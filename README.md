# Handoff : MaCité (application de gestion locative, Flutter)

## Vue d'ensemble
MaCité permet aux **bailleurs** de gérer immeubles, chambres, locataires, loyers, signalements et annonces, et aux **locataires** (étudiants, jeunes actifs) de payer leur loyer, déclarer un problème et consulter leur cité. Contexte : Afrique francophone, montants en FCFA, paiements Mobile Money (MTN, Orange, Moov) et espèces. Interface en français.

Cible : **Flutter (Android, iOS, web)**, **Material Design 3**, widgets standard.

## À propos des fichiers de maquette
Les fichiers de `maquettes/` sont des **références de design réalisées en HTML** : des prototypes cliquables qui montrent l'apparence et le comportement attendus. **Ce n'est pas du code de production à copier.** La tâche consiste à recréer ces écrans en Flutter avec les patterns du projet (gestion d'état, navigation, architecture).

Ouvrir un fichier : double-cliquer sur un `.dc.html` (garder `support.js`, `image-slot.js` et `assets/` dans le même dossier). En haut de chaque prototype : bascule **Mobile / Ordinateur**, et pour Bailleur/Locataire une bascule **Clair / Sombre**.

## Fidélité
**Haute fidélité.** Couleurs, typographie, espacements, rayons, états et textes sont définitifs. Reproduire au plus près avec Material 3. Les données (noms, montants, chambres) sont fictives.

## Fichiers
| Fichier | Contenu |
| --- | --- |
| `maquettes/Design System.dc.html` | Palette, typographie, espacements, boutons (tous états), champs, badges, cartes, tableau, navigation, états vides/chargement/erreur/succès, transitions. Chaque élément porte entre crochets le widget Flutter correspondant. |
| `maquettes/Communs.dc.html` | Démarrage, accueil, présentation (3 étapes), connexion, mot de passe oublié, choix du profil, code d'invitation, inscription, succès. |
| `maquettes/Bailleur.dc.html` | Espace bailleur complet (voir liste des écrans). |
| `maquettes/Locataire.dc.html` | Espace locataire complet. |
| `maquettes/Accueil public.dc.html` | Page web publique (vitrine) animée, version site. |
| `app_theme.dart` | **Tokens prêts à l'emploi** : `AppColors`, `AppSpacing`, `AppRadius`, `AppShadows`, `TextTheme`, `ThemeData` clair/sombre, `formatFcfa()`. |
| `assets/logo-mark.png` | Symbole du logo (fond transparent). `assets/logo-full.png` : logo complet avec nom. |

## Responsive
- **Mobile 390 × 844** : grille 4 colonnes, marges 16. Navigation `NavigationBar` en bas (80 px).
  - Bailleur : Accueil · Immeubles · Locataires · Signalements · Plus
  - Locataire : Accueil · Signaler · Paiements · Ma cité · Profil
- **Ordinateur 1440 × 900** : `NavigationDrawer` fixe à gauche (256 px, logo + icônes + libellés), barre du haut 64 px (recherche 400 px, notifications avec pastille ambre, avatar), contenu centré `maxWidth: 1200`, marges 32, grille 12 colonnes.
- Listes de cartes : 1 colonne mobile → 3-4 colonnes ordinateur. Locataires et paiements en **tableaux** (`DataTable`) sur ordinateur.
- Point de rupture conseillé : `LayoutBuilder` à 840 px (mobile/tablette → ordinateur).

## Écrans (noms de widgets proposés)

### Communs
| Écran | Points clés |
| --- | --- |
| `SplashScreen` | Fond `primary`, logo sur carré blanc 96 px (rayon 28), « MaCité », sous-titre, indicateur circulaire. Passe à l'accueil après 1,8 s. |
| `WelcomeScreen` | Slogan « La gestion locative, simplement. » (32/800 mobile, 56/800 ordinateur, « simplement. » en primary). Carte animée qui alterne 3 fonctionnalités toutes les 3,5 s (glissement + points). Boutons bas : « Créer un compte » (plein), « Se connecter » (contour), « Découvrir l'application » (texte → onboarding). |
| `OnboardingScreen` | 3 pages `PageView` : « Gérez vos chambres », « Suivez vos locataires », « Signalez un problème en un clic ». Image 340 px rayon 24, badge, titre 28/700, texte 16. « Passer » en haut, indicateur (point actif 24 px), bouton « Suivant » / « Commencer ». |
| `LoginScreen` | `SegmentedButton` Téléphone / E-mail, champ identifiant + mot de passe (icône œil), « Mot de passe oublié ? », bouton « Se connecter » avec état de chargement, bandeau `MaterialBanner` « Pas de connexion internet ». Validation : champ vide → « Ce champ est obligatoire. », e-mail invalide, téléphone < 8 chiffres. Ordinateur : panneau gauche indigo 640 px (logo, photo, slogan), formulaire 420 px à droite. |
| `ForgotPasswordScreen` | Champ unique, « Recevoir un code », confirmation verte « Code envoyé. Il est valable 10 minutes. » |
| `RoleChoiceScreen` | 2 cartes radio : « Je suis bailleur » / « Je suis locataire ». Sélection : fond `primarySurface`, bordure 2 px primary. |
| `InviteCodeScreen` | Champ 64 px, police mono 24/700, espacement 0,3 em, 6 caractères majuscules. Erreur si ≠ 6. Succès : carte « Code valide · Chambre A-102 · Immeuble A ». |
| `SignUpScreen` | Nom, téléphone, mot de passe (aide « 8 caractères minimum, dont un chiffre »), case CGU obligatoire. |
| `SignUpSuccessScreen` | Grande coche verte animée (échelle 0,6 → 1,08 → 1), « Compte créé ». |

### Bailleur
| Écran | Points clés |
| --- | --- |
| `BailleurDashboardScreen` | KPI : carte principale indigo « Loyers payés » (32/700 + barre de progression), Impayés, Problèmes en attente, Chambres, Taux d'occupation. Listes « Loyers en retard » et « Derniers signalements ». FAB « + » = ajouter un locataire. Version sombre fournie. |
| `BuildingListScreen` | Cartes : photo 140/180 px, nom, adresse, nb chambres/étages, barre d'occupation, retards. |
| `BuildingDetailScreen` | Plan par étage (étage le plus haut en premier), tuiles 72/88 px : fond clair + bordure 2 px + icône + numéro (+ libellé sur ordinateur). Légende avec compteurs. FAB = ajouter une chambre. |
| `RoomDetailScreen` | Carrousel photos, statut, loyer, type, équipements (`Chip`), locataire actuel ou « Attribuer à un locataire », historique des occupants. |
| `RoomFormScreen` | Numéro, étage (puces), type (Simple/Studio/Appartement), loyer FCFA, équipements (FilterChip), statut (Libre/En travaux), 3-4 photos. Erreurs : numéro vide, loyer = 0. Bouton fixe en bas sur mobile. |
| `TenantListScreen` | Recherche, filtres (Tous/À jour/En retard + immeuble). Mobile : liste ; ordinateur : tableau. |
| `TenantDetailScreen` | Avatar, statut, Appeler / Envoyer un message (contour), « Enregistrer un paiement » (plein, fixé en bas sur mobile). Coordonnées, bail, pièce d'identité, contact d'urgence, historique 6 mois avec téléchargement de quittance, signalements envoyés, notes privées. |
| `RecordPaymentSheet` / `Dialog` | Montant prérempli (reste dû), mode de paiement (MTN MoMo, Orange Money, Moov Money, Espèces). Erreurs : 0 → « Saisissez un montant supérieur à 0. », dépassement du reste dû. Succès : SnackBar « Paiement de X enregistré · quittance prête ». |
| `AddTenantScreen` | Stepper 3 étapes (Informations → Chambre libre → Bail : date, durée 6/12/24 mois) puis `AddTenantSuccessScreen` (chambre attribuée, SMS d’invitation à installer l’app). |
| `RentsScreen` | Sélecteur de mois, synthèse (attendu, encaissé, reste, taux), filtres statut + immeuble, lignes avec badge Payé/Partiel/En retard, bouton « Relancer » (contour) ou « Quittance » (tonal). |
| `ReportBoardScreen` / `ReportListScreen` | Ordinateur : Kanban 3 colonnes (Nouveau, En cours, Résolu). Mobile : `TabBar` 3 onglets. Carte : photo, urgence, catégorie, chambre, date. État vide illustré. |
| `ReportDetailScreen` | Description, photos, changement de statut (3 boutons), assignation technicien, fil de discussion (bulles : moi = primary/blanc à droite, locataire = blanc à gauche), champ d'envoi fixé en bas sur mobile. |
| `AnnouncementsScreen` | Destinataires (Toute la cité / Immeuble A/B/C), type (Coupure d'eau, d'électricité, Réunion, Travaux, Autre), titre obligatoire, message, portée (« Sera envoyée à N locataires »), historique avec taux de lecture. |
| `LandlordSettingsScreen` | Profil, interrupteurs (relance auto, rappel J-3, alertes, SMS), moyens de paiement acceptés, mode sombre, déconnexion. |
| `MoreScreen` (mobile) | Loyers et paiements, Annonces, Profil et paramètres. |

### Locataire
| Écran | Points clés |
| --- | --- |
| `TenantHomeScreen` | Carte « Ma chambre » (photo 136 px), carte « Prochain loyer » (32/700, échéance, statut, bouton « Payer »), raccourci ambre « Déclarer un problème », annonces. Version sombre fournie. |
| `ReportIssueScreen` | **< 30 s.** Étape 1 : 7 catégories en grandes tuiles (avance automatiquement au toucher). Étape 2 : description (obligatoire, ≥ 5 caractères) + photos. Étape 3 : urgence Faible / Moyen / Urgent + récapitulatif. Barre de progression 3 segments. Puis `ReportSuccessScreen` (référence, suivi 3 étapes). |
| `MyReportsScreen` | Statut + suivi Envoyé → Pris en charge → Résolu, note 1-5 étoiles une fois résolu. |
| `TenantPaymentsScreen` | Solde restant (carte indigo), payer, historique avec téléchargement des quittances. |
| `PayRentSheet` | Opérateur (MTN/Orange/Moov), numéro Mobile Money, « Confirmer » → état « Validez sur votre téléphone… » → succès. |
| `MyCityScreen` | Infos immeuble, contacts utiles (bailleur, gardien, pompiers 18, police 17) avec appel, règlement intérieur dépliable (`ExpansionTile`), annonces. |
| `TenantProfileScreen` | Photo, chambre, bail (entrée, durée, fin, loyer), statut des paiements, infos personnelles, documents (contrat PDF, pièce d'identité vérifiée). |
| `NotificationsScreen` | Groupes Aujourd'hui / Cette semaine, pastille non lue, « Tout lire ». Un toucher ouvre l'écran concerné. |
| `TenantSettingsScreen` | Interrupteurs de notifications, mode sombre, langue, mot de passe, déconnexion. |

## Interactions et comportement
- **Transitions** : entre écrans glissement horizontal 300 ms (`SharedAxisTransition`, package `animations`) ; apparition des cartes fondu + montée 8 px, 200-250 ms, décalage 40-60 ms ; carte → détail `OpenContainer` 300 ms ; bottom sheet montée depuis le bas 300 ms `Curves.easeOutCubic` ; dialog ordinateur fondu + échelle 0,96 → 1, 200 ms.
- **Retour tactile** : `InkWell` partout, échelle 0,98 au toucher sur les cartes, vibration légère à la validation.
- **Survol (web)** : cartes ombre `AppShadows.hover` + translation -2 px ; boutons pleins `primaryHover` ; lignes de tableau fond `#F8FAFC`.
- **Focus clavier** : contour 3 px `#A5B4FC`, décalage 2 px.
- **Chargement** : squelettes à effet shimmer (1,4 s, `#F1F5F9` → `#E2E8F0`) à chaque changement d'écran.
- **SnackBar** : fond `#0F172A`, texte `#F1F5F9`, icône `#34D399`, rayon 12, 3,5 s.
- **Champs** : libellé au-dessus (13/500), icône à gauche, message d'erreur dessous avec icône `error` ; en erreur, bordure 2 px `#EF4444` et libellé `#B91C1C`.
- **Actions principales dans la zone du pouce** sur mobile (boutons fixés en bas, FAB à 16 px du bord, au-dessus de la barre de navigation).
- **Jamais la couleur seule** : chaque statut a icône + libellé.

## Badges de statut (`StatusBadge`)
Pilule hauteur 24-28, padding 0 12 0 8, icône 14-16, texte 12-13/600.
| Statut | Fond | Texte | Icône |
| --- | --- | --- | --- |
| Payé / Libre / Résolu | `#D1FAE5` | `#047857` | check_circle / door_open |
| Partiel / En cours / Moyen | `#FEF3C7` | `#B45309` | timelapse / build / signal_cellular_3_bar |
| En retard / Urgent | `#FEE2E2` | `#B91C1C` | schedule / priority_high |
| Occupée | `#E0E7FF` | `#3730A3` | person |
| En travaux / Faible / À venir | `#F1F5F9` | `#475569` | construction / signal_cellular_1_bar |
| Nouveau | `#DBEAFE` | `#1D4ED8` | fiber_new |

Mode sombre : fonds foncés (`#450A0A`/`#FCA5A5`, `#422006`/`#FCD34D`, `#064E3B`/`#6EE7B7`, `#312E81`/`#C7D2FE`).

## Tokens de design
Voir `app_theme.dart` (valeurs exactes). Résumé :
- **Couleurs** : principale `#4F46E5`, secondaire `#F59E0B`, fond `#F8FAFC`, cartes `#FFFFFF`, texte `#0F172A` / `#64748B`, bordures `#E2E8F0`, succès `#10B981`, erreur `#EF4444`, info `#3B82F6`. Sombre : fond `#0F172A`, cartes `#1E293B`, texte `#F1F5F9`, principale `#818CF8` (texte `#0F172A` dessus).
- **Typo** : Plus Jakarta Sans. 32/700 chiffres clés · 28/700 titre d'écran · 20/600 section · 16/400 corps (interligne 1,5) · 16/600 boutons · 13/500 libellés. Pas de majuscules forcées.
- **Espacements** : 8, 16, 24, 32.
- **Rayons** : 12 boutons/champs, 16 cartes, 24 modales, pilule badges.
- **Ombres** : cartes `0 1 2 rgba(15,23,42,.06)`, survol `0 4 12 .08`, modale `0 12 32 .14`.
- **Boutons** : hauteur ≥ 48 (56 pour les CTA mobiles principaux), plein = principal, contour `#C7D2FE` = secondaire.
- **Icônes** : Material Symbols Rounded 24 px (package `material_symbols_icons`, style rounded). Remplie (`FILL 1`) pour l'onglet actif.
- **Montants** : `formatFcfa(45000)` → « 45 000 FCFA ».

## État et données
- Session : rôle (bailleur / locataire), utilisateur, cité.
- Bailleur : immeubles → étages → chambres (statut : libre / occupée / en travaux / retard calculé depuis le paiement du mois), locataires (bail, coordonnées, documents, notes privées), paiements (mois, montant, payé, mode, date, quittance PDF), signalements (catégorie, urgence, statut, technicien, messages, photos), annonces (cible, type, titre, message, lectures), préférences.
- Locataire : chambre, loyer courant, historique, signalements (étape 1-3, note), notifications (lue / non lue), préférences.
- Prévoir un mode hors ligne (file d'attente des actions) : bandeau « Hors connexion. Vos actions seront envoyées au retour du réseau. »

## Assets
- `assets/logo-mark.png` : symbole du logo fourni par le client, détouré (fond transparent). Sur fond indigo ou sombre, le poser sur un carré blanc arrondi.
- Photos (immeubles, chambres, signalements, avatars) : emplacements vides dans les maquettes, à remplacer par les photos réelles (`ClipRRect` rayon 12-16, `BoxFit.cover`, formats homogènes). Avatars sans photo : initiales sur fond teinté.
- Icônes : Material Symbols Rounded. Logos opérateurs : pastilles de couleur (MTN `#FFCC00`, Orange `#FF7900`, Moov `#0066B3`), à remplacer par les logos officiels si les licences le permettent.
