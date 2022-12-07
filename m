Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E613CC352A1
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Dec 2022 15:19:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE9F410E3C8;
	Wed,  7 Dec 2022 15:19:07 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2064.outbound.protection.outlook.com [40.107.220.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E061810E3C8
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Dec 2022 15:19:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kGszUdRcBlDwhH4n+XXNTtmgX4raMZWHdRnFKeo64SmSAg66HyXNF3HHZaoNhLo6P/XLJXdEVev4vHks+Xx2jN9KR48fZwp+FxPvdv7EPBOx32+mzynOeyc1wssJ/mutfiettfUIqa+e7+j/a4xC7WrmPRLaiijHbHeTf7Q5450bTZRZaga/CiwCanuuUFIoRvHZlDBilKXHRaO7Vu76tP9aNQGIRlxFrZgp2YJt6KkhG8SB17S4gAOiUnYsYCeJHed+4AVYMTKf3YoZv6SwfRnZ7L8k4hbpR59hBeAJUQay9m06jGsfmWe++0CgaxPjHMuJCTTrXcghGEE4uMBqZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cg6i4dyg76Nrr9e1w8KNw+hI+LOtuiWfp8VwJ/2Y6JI=;
 b=HRUYzA+acq/W1K98J+87Bbiskwx1cEkKTdIAMrgLV8qvYTvontcAXuVtCRqcWWw2tqCkFAOmN1kcB26ENcO1JIC2x5s9S1MSpL6+CNRJcJ2GnEfcj4i4cliyihmdC1VpVVEvRhOdjsA8l2vnwicLOJ8LQCnE+qlSFH8MDz+mus9jz9R//fGpHPpk50I1tdhJSItxmzImu6iQ+M2PP+ukkFrGglWEkhePDG/Mh/9Eu+SPVY/GNAP1vzcHkH1BWsBwuCmtlSVO207A1Wgu3/fv0MRZKd8USFWwXm9tWEKfhxtYq6AXOiQD+S7SfNadmKnwIVNOcxTOo/UvsThiI30DcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cg6i4dyg76Nrr9e1w8KNw+hI+LOtuiWfp8VwJ/2Y6JI=;
 b=sKkI/SGI5UhZt0MuOeXakLqw8dhvdvJVhF0CBSWAaQOlNLq1n/6LSsW53LGFxPGXWU1KOFHGeA10IPOB4xcMjhqK6y/IB0l6Dmnm1SYbLWhRZSjfTeH21qvuAP+PrgmTDIHlLZJmDU2hKcgW2vpGOrtmsoVgEesiYrC5f8qCSZ8=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by DS0PR12MB8271.namprd12.prod.outlook.com (2603:10b6:8:fb::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5880.14; Wed, 7 Dec 2022 15:19:01 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::39a0:6c44:c6a5:cfa9]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::39a0:6c44:c6a5:cfa9%3]) with mapi id 15.20.5880.014; Wed, 7 Dec 2022
 15:19:01 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>, "Yang, Stanley" <Stanley.Yang@amd.com>,
 "Wan, Gavin" <Gavin.Wan@amd.com>, "Chander, Vignesh"
 <Vignesh.Chander@amd.com>, "Yu, David" <David.Yu@amd.com>
Subject: RE: [PATCH 5/6] drm/amdgpu: update VCN/JPEG RAS setting
Thread-Topic: [PATCH 5/6] drm/amdgpu: update VCN/JPEG RAS setting
Thread-Index: AQHZCiM9bG1YYhPg90WF5f8lfsBi+a5iiNUg
Date: Wed, 7 Dec 2022 15:19:00 +0000
Message-ID: <BN9PR12MB52571868C8CCC2FFD31CCDF2FC1A9@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20221207100341.15356-1-tao.zhou1@amd.com>
 <20221207100341.15356-5-tao.zhou1@amd.com>
In-Reply-To: <20221207100341.15356-5-tao.zhou1@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=f3273595-2160-440d-826f-aa845282de0e;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-12-07T15:14:08Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|DS0PR12MB8271:EE_
x-ms-office365-filtering-correlation-id: 46ceeeae-9bfa-4ea7-026d-08dad8665e75
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bg1bJ9D1238Ac4NAK/8q837dZqYbg8Dn5p1Wh8QIF74bX7nUuk9eLORmVzp1G6IcqSPErvMfljwf56WtvGps+XWKp+twbnHHRBh8e3p5z/GXZ6nTs4c2XibW5WSNENkZ5apCX1OT8HO4VcKtH6hd0ksrCn2TJldzo7Zf3VsZ2TZubj6CBPW4UgMmE1VP0Tfl1tlyMpkN/RJFLD6Ekgwgr/jQiYJSVnK94M216tTSmuG6L1nl73POYwIrKXUGvPuE1VFAp7bSsRypTuyCkcZt47JJVSI1KM982Zd+a7n3StIgka8WE8hS7sxzRhae+IbsDd66HjQbKypdlTFHLZEwKo50qbrrpoMFl7M27ZwkPmvsThm4S6uOdfBDEGlzDNxAaS9kSsAaxMQfQwufdCP7V4vy50z343ZL2fgMDTXPqVWHv7NTaJ6g/weCQ7PQdFl/v61qh/IhbMiml086Soeuop/p27lxbJG+Ew/m/Tb4SUBVuZhI7FvwqC6Z/kFysx2kVhQ2JFztIGLgoIkJoiuvJkBOqFMpz7+xhsqJ6aZJKnPllsItGxNE+rhTaqmw6B93i94NwPEsJMVNqUj/G4iE+54H9UNMAvkiTlbm3bUB4OgD97FHN1JYcUi2DvVBzkCQutYJqvigpMFywB5O+b/QVQtULDY4E+k/AiUqLOVIxLJTdq3CDbCsFgBsnEtFb5r7suU4PnBw+xdorbQZb4UvnpynuAOSJIO2FHbh+w0HCA4=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(39860400002)(376002)(136003)(346002)(366004)(451199015)(122000001)(83380400001)(8676002)(66556008)(86362001)(38100700002)(5660300002)(2906002)(38070700005)(15650500001)(66476007)(33656002)(41300700001)(921005)(8936002)(66446008)(64756008)(9686003)(55016003)(6506007)(7696005)(186003)(52536014)(53546011)(26005)(316002)(110136005)(6636002)(76116006)(66946007)(71200400001)(478600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ghKIwxsZssJvyf2+gzGPPTFdL2eC+L9VL+tyoZ2eZMF7es1OSVkC57rAKQjP?=
 =?us-ascii?Q?BI85+9zskOI+zLr9puMtzZZEpew6T/IqtWSSyYn9pi7ZD9TozR476+Sy1W9b?=
 =?us-ascii?Q?DL/rxP1hVcqb9SvwXbWLpgvU37bbqYvQ8EolnvnVkLjNqjIsoJ2ztn/9XIg+?=
 =?us-ascii?Q?5D03acWtkk/D1wsyC7vhqqcHgPzuqT2s83ybUuy9RxKjFfkbOHXz7qDsaKd5?=
 =?us-ascii?Q?k/xWBA5Ng+YflCi4r+zugMur0tK3VyYMvzTuk18YyIPn/B+NK09TLPcvB0LW?=
 =?us-ascii?Q?ya/tZrarEsff0HgRWiL4xyVWRynd1qQ7bWuORVCnC4rk2IMo8e8BH4/mHbpq?=
 =?us-ascii?Q?vbSupoF1wzscb0hgqC6N3zFMccpYWZA07oefHJDmzzw6KOnlXAnJmUq1M71h?=
 =?us-ascii?Q?twqwIddVOibmER8QV1c9wcYc/brFoPKX0WUUYBjTCE4AKv19Hb9JEr1eV/+T?=
 =?us-ascii?Q?2R3VyMTTTGoa1niLkD1wp/PzVMAj58zHaDs/2gBc35jlXUUh8C7pJ4RsFle+?=
 =?us-ascii?Q?zJbf75n+rcfgwUjMZljtRWZXYwi5tJwzYexBL1RJ9X6FZparjxKaK1GcT0vU?=
 =?us-ascii?Q?zgz8hn54iKQPE7mEPEXiR0z/6T0BCMrkQRpXpbUw+1rpdqJPp8txj1/XayI1?=
 =?us-ascii?Q?beP/gy1MDTD951XsxPYh3XrILgFKe4oIIxTJq92pMC7sN9g8FIZiiuLqzgT7?=
 =?us-ascii?Q?wZ4R02WuANMFHs8n/jVX5mE1U6Z9sSJhmX/dSMJVyxv62ug3mIreyqpsTfOj?=
 =?us-ascii?Q?8xlHuLkXmO0YWQVz4RbJZR+Gu9Eg9ePT6CHlP0ZoNtac7MIgtnWL3EMunCSJ?=
 =?us-ascii?Q?mQcT8u1YJ+9+u71dmXekFaRWxxr6+9PYWaUOdP1vzd17QXiCw1VzizJGs9CU?=
 =?us-ascii?Q?1RfidSjnmSTaFQbdmV46omoFVem6TmLj83+dz9FKwm+68ITE7S8TPiV+esBO?=
 =?us-ascii?Q?VTF96Nx+J0y4bHI+VDznG8Fpuc+HJbNacvaxz6TFLr1o+f1Gln1ngJQIjby0?=
 =?us-ascii?Q?uEOuLVV2UtJlk+DZqtZxodtKOB8D9tWOANSgp4K9MOy9A8XDIgaQ/Y5tp/7J?=
 =?us-ascii?Q?FKmBX2mQFlOk+q+Rb3EJixsJ9PIv6lLlbGamEtyXxNOEuKPxPtVN5V20SeIu?=
 =?us-ascii?Q?A2hE/eHp665A/9eaPRSnQ7B1KmvTJkhfy4uBJUd3mmz2C3lc5XJrKGpahEhk?=
 =?us-ascii?Q?AkrUFq/FEs0409zSSDMX7KM+z3A0cpIVRNPHyhaUFb9GLLgSYnVj/33LMPyD?=
 =?us-ascii?Q?s0VBedNAQZAJ0/6WLm28yq2eN/9mD/A3OGMMAV5D4ukBPCEWfOxrSzwYwSeu?=
 =?us-ascii?Q?HHGLrluDxeJOzUVNhw1EolH7NbP+nqyumyU9304S2C3JsU5syi6jvKR47LoA?=
 =?us-ascii?Q?GU02aNwR9+jevbp7kCZyH8AArP2O8vhCUkvWijBr67JikjBk2898RAOyUarl?=
 =?us-ascii?Q?agWnLvq+HCBD1q+kiaKIULiSZov+pUbPs+gDW3F5YrWPKydnTJAO1VVvspfH?=
 =?us-ascii?Q?vP+3eQRLzZ/4vWr/hz39MeNa1pSwae84ybym9eb7NXoFKuQDryZiqLI7AWR6?=
 =?us-ascii?Q?rhf7XSqKVN1ZVVslWWIYh7JTi/ro57OiuhLynUN3?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46ceeeae-9bfa-4ea7-026d-08dad8665e75
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2022 15:19:00.9180 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kkc66J85LfBVWX1WwzJ19w2iuBLrUKD1ShEnLzvhJgyvdKDSRoR+wBsdDRAbYl4h1k1Gv2gc7YxCLo3pMHowFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8271
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

the commit description and the inline comments are confusing. I would say w=
e support VCN RAS in both bare-metal and SRIOV environment now.

-----Original Message-----
From: Zhou1, Tao <Tao.Zhou1@amd.com>
Sent: Wednesday, December 7, 2022 18:04
To: amd-gfx@lists.freedesktop.org; Zhang, Hawking <Hawking.Zhang@amd.com>; =
Yang, Stanley <Stanley.Yang@amd.com>; Wan, Gavin <Gavin.Wan@amd.com>; Chand=
er, Vignesh <Vignesh.Chander@amd.com>; Yu, David <David.Yu@amd.com>
Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
Subject: [PATCH 5/6] drm/amdgpu: update VCN/JPEG RAS setting

The enablement of VCN/JPEG RAS is unrelated to SRIOV.

Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ras.c
index 854cff9e7ebd..20474708bc7d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2353,22 +2353,22 @@ static void amdgpu_ras_check_supported(struct amdgp=
u_device *adev)

                if (amdgpu_atomfirmware_sram_ecc_supported(adev)) {
                        dev_info(adev->dev, "SRAM ECC is active.\n");
-                       if (!amdgpu_sriov_vf(adev)) {
+                       if (!amdgpu_sriov_vf(adev))
                                adev->ras_hw_enabled |=3D ~(1 << AMDGPU_RAS=
_BLOCK__UMC |
                                                            1 << AMDGPU_RAS=
_BLOCK__DF);
-
-                               if (adev->ip_versions[VCN_HWIP][0] =3D=3D I=
P_VERSION(2, 6, 0) ||
-                                   adev->ip_versions[VCN_HWIP][0] =3D=3D I=
P_VERSION(4, 0, 0))
-                                       adev->ras_hw_enabled |=3D (1 << AMD=
GPU_RAS_BLOCK__VCN |
-                                                       1 << AMDGPU_RAS_BLO=
CK__JPEG);
-                               else
-                                       adev->ras_hw_enabled &=3D ~(1 << AM=
DGPU_RAS_BLOCK__VCN |
-                                                       1 << AMDGPU_RAS_BLO=
CK__JPEG);
-                       } else {
+                       else
                                adev->ras_hw_enabled |=3D (1 << AMDGPU_RAS_=
BLOCK__PCIE_BIF |
                                                                1 << AMDGPU=
_RAS_BLOCK__SDMA |
                                                                1 << AMDGPU=
_RAS_BLOCK__GFX);
-                       }
+
+                       /* VCN/JPEG RAS setting is unrelated to SRIOV */
+                       if (adev->ip_versions[VCN_HWIP][0] =3D=3D IP_VERSIO=
N(2, 6, 0) ||
+                           adev->ip_versions[VCN_HWIP][0] =3D=3D IP_VERSIO=
N(4, 0, 0))
+                               adev->ras_hw_enabled |=3D (1 << AMDGPU_RAS_=
BLOCK__VCN |
+                                                       1 << AMDGPU_RAS_BLO=
CK__JPEG);
+                       else
+                               adev->ras_hw_enabled &=3D ~(1 << AMDGPU_RAS=
_BLOCK__VCN |
+                                                       1 << AMDGPU_RAS_BLO=
CK__JPEG);
                } else {
                        dev_info(adev->dev, "SRAM ECC is not presented.\n")=
;
                }
--
2.35.1

