Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE9E5C61CE8
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Jun 2025 08:26:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6974910E7AE;
	Thu, 12 Jun 2025 08:26:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cWJHlFZ8";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2084.outbound.protection.outlook.com [40.107.236.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A04A310E7B1
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Jun 2025 08:26:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AHs+K3rxBkTC1ON1+RIHX2OfgH7Lr8HUrIT9RgFNBFEhHbB0vQSXsD0QMJ5hnYDZr9KC25lJyUV1uMnWZ3SeXu+T2aMo80lu+MNV/i2wTkD9XG4gCy1hXqYJEdDQZgulQTNF3Rtd7HwBUlbv8k+SA64WhzS6RKxWT23Y+xclzGoh9rMJB8AJwMkMSoDkhiIaLNtLBc5WgrzR+dDIFfk2BUUWH1XsNTmFMPtbC5PEHaPMQXVrC4mm8TA2R4PLkB6YtA2zzPI0ijcIQzwrrfM+9Jgh6ZIfi+8y6mFypwFCndB9uSgUoFufHpnOLz88of66E/sjrhQ/tMsKHVkgOd1COQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tPoXlcwOIzKfcEddeU7iDnMGoTNqQCC3lfHNigglTbI=;
 b=N+HKk7FnkDDGdnr10Te/Cfa+MfIVH2LFKesotSZxs2MxKopNIGOGVebQrvv7C7OeniV5Nrz5gFVUOvdnKRdrtGeFf4qpMYjiHBAId0X9z8sGeSOMheUwBqSVY+00l9VhYKyshg8QbiVLQai1dBhR/AaI+rUpZacl52NASoPnKCQuL8aH2uhzXXF3WPmroJhAzfu2XEXSYcu4v2uRKv2Comguj3PPTq3Ne2uulH48MXzaFXHtpGXk7CFzo9ZWYrQma9pbvWhdp2/RP+65dbq14QXntX6s8ZRxy9f5oQd6m9B9OybrWmw1srIqDYD3Px8HhWQuo9o6yIKjul+qXVIpxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tPoXlcwOIzKfcEddeU7iDnMGoTNqQCC3lfHNigglTbI=;
 b=cWJHlFZ8i77L0AIVQeCKS/dbNF3fiXlMetMZfssE3HJmI3/8hrlIRyd014G1actDEZ0IrqHGZoqEvPx3WYhoSqHQOumfVC3I13I0oi02O7HROix0xvTYK3xjGQCzSB1E3kuLGB9TiZTHOu7/OFlPPoJli0JqWyiOV+oSR1uiW+8=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by CH2PR12MB4295.namprd12.prod.outlook.com (2603:10b6:610:a7::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.23; Thu, 12 Jun
 2025 08:26:26 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::c5da:9b53:9d77:c708]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::c5da:9b53:9d77:c708%2]) with mapi id 15.20.8835.018; Thu, 12 Jun 2025
 08:26:25 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Feng, Kenneth" <Kenneth.Feng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Feng, Kenneth" <Kenneth.Feng@amd.com>
Subject: RE: [PATCH 1/2] drm/amd/pm: override pcie dpm parameters only if it
 is necessary
Thread-Topic: [PATCH 1/2] drm/amd/pm: override pcie dpm parameters only if it
 is necessary
Thread-Index: AQHb23A7GS/mP/1Ndk6dzic2VJfmFrP/MDLA
Date: Thu, 12 Jun 2025 08:26:25 +0000
Message-ID: <PH7PR12MB59972F022F01A0DD736E597D8274A@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20250612080132.433434-1-kenneth.feng@amd.com>
In-Reply-To: <20250612080132.433434-1-kenneth.feng@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-06-12T08:25:21.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|CH2PR12MB4295:EE_
x-ms-office365-filtering-correlation-id: 41a035bd-57ab-4afe-6891-08dda98ad22e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?Vc/hwHao5QVDU03MxzQ7ztwp2yPbJ24eskCHdlwNb/A8NjTaZzUdmHemQB+p?=
 =?us-ascii?Q?ngb/88yD8+uV1bkmbbcl5w/g4TjDwiGZWrCHighzL2IstGEcx4K7CxeHpxiD?=
 =?us-ascii?Q?oK6HegeFWohvwfgAix6D4Kdvk1H35ijasYdXvwZUDjZydVR3aBoC55l0GNN1?=
 =?us-ascii?Q?HSVjtEG2eN5sa7WORu6aX9Jr07gvZAa34mwtMXnsfnhxeRL3rUtnj21FodHK?=
 =?us-ascii?Q?L5JabsjIxmsyPc42ILps9Du9KFRG4v7K3Zzi5sXV32Dvc2qb8fEiNivT+St9?=
 =?us-ascii?Q?PiOR6jOZzo5fzu3ZzMZpUwUvpxGXBA5GSkTj7x645nT+3pQvhzJJg1rB8v+n?=
 =?us-ascii?Q?013APlBSf+cnd4MocBVaRCOAbjCBsCYseVKVYGYA8uBdeVWKSwzYK5ZofxCi?=
 =?us-ascii?Q?3zPjYoahIa7HFDii98sJFIYRQj9YPJIQQ13gEE9qWR3j9vj0u8g4oO0QZE0h?=
 =?us-ascii?Q?A0hTI6dGEFPyjGc5BEXJpVL/ui9LRSSVCDP/1cMzIXYJjllZsJuh+WTR+hKr?=
 =?us-ascii?Q?27+UdB06CPJ2ZioYAlES/GUa4Tyq6kQBSar9KZ2pUV5Tdi9xUiS72j5B0sfs?=
 =?us-ascii?Q?N4Q50do0oyjMEGOX417oYroIK8SmDmB0BUf5s3IzyH3SlJGroOHKwd8SOY+E?=
 =?us-ascii?Q?0M9MbXTGthz7z79efmhpsc7HUa4oXdlmyflR9iKC2qsO4cu9KTfP9kXxCjD9?=
 =?us-ascii?Q?3GBT8e7X3zkA0Zy+EWO2SKwLceBFM0LDQqzP/ErLhV9gTv8bPWrMPSHIiDAk?=
 =?us-ascii?Q?iNWhPVaTZ6fnvWls49erzlrCvecGFMzcfbUsucNNomCCtBPlyyBBsAQbCPML?=
 =?us-ascii?Q?Jh0KLD8kv7w8jbobe7cRa7T3K4bJcEW6i1XaXysboBN5aPavwBXoJ7np7q0a?=
 =?us-ascii?Q?ZWfAXWXCPIWIRK6MmSb2t3sKB7Wcqj4NY2lOX17/griaWLvO30c39Rau8psH?=
 =?us-ascii?Q?EAhqkqf6pjuhmnI+Yx/XVcvFu1eRmHUkx2tOJuizbETsx3iJ+P3sYgrN+JCx?=
 =?us-ascii?Q?4jhZg1OT+fNL05s51ndL2imHxM8/AEfQmZYYbOgQUXZ/SOToo/c43b0hHZOi?=
 =?us-ascii?Q?jt5ohKwGRyvc0b0CkHPHPqV6YzgO6QyVm8HwVgETmca3UCQpYDlUZDz9RW2I?=
 =?us-ascii?Q?7V2cAofEkQ8LXelyzTQE+wATjTewQQ0h74M64x0JgsU7HTLimB7cTk6ZS8Oy?=
 =?us-ascii?Q?aBRH+iOC5asREl28BwlbgeOx/yTgFkJq8SAx8mOJU0HCH9cU+jaFNyGrzPi2?=
 =?us-ascii?Q?5FA6P7k1lveUS5GTPB+IHtrOfrC6kly4sSkLMOOFIuuCQzLFy9wuTYIaBcA4?=
 =?us-ascii?Q?lwMcUXN4CwI7jeRP6Dl68106BvVltGI1U2duHOg1Za7x0NEYj6Z0Ik6LAa2e?=
 =?us-ascii?Q?Ko2wTAemvhD6kIA3uW5qC6oIdTA/vR+YwTJSl7ZNseTHZOsh0OH0q1ZDFnVS?=
 =?us-ascii?Q?NQCNULLvluyaZl2yfmw2te6T73a69QE+x2fAjJJKsqinGPB/MwevsVP/rkld?=
 =?us-ascii?Q?eH17nhgUCF2BHNA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+IXTvVvX7u9xlDxzy7DjkWc3AmeQf+Vnex6x681x7veaMzoi3DmpGzUhfv1Y?=
 =?us-ascii?Q?H2irZyS7bjdKu4I/rwyjFIORYD9sYRi/8Nssli/+Qn0dBIU/+bMowDyy0wmA?=
 =?us-ascii?Q?F6Ip5wwN6LfA6AcYd3r+1638Q6pz/oDuYCw/LZhe3falW3XodCbV5O8TyX9K?=
 =?us-ascii?Q?yDo1SUaTERx1RtRMpbai8z/AWFcdgz8GMaFNyxYHkfaVDo3aNPmMGNKauHnq?=
 =?us-ascii?Q?toY0zQBySeEBz1neiBOYWOsRAIKS1+J9JVIFgedUinhd7wR7UNN5P6BUvp+o?=
 =?us-ascii?Q?Op9keRcSAdOCb5Qtyt3CcUJywiauzpSlFwGYJfiJoW/yCVUTuIA//KOtGDpb?=
 =?us-ascii?Q?ve98W8s7ITx4vfVLlpJb/ix2bUIFsdhztzyZtE7RceKm/pvMAlxZdSFdgX2i?=
 =?us-ascii?Q?wiXWp9S6gTLiN37Hn3Dt0Q2J2lVwjSgVU2SiqMj0GBXtY8UtF5ywxl/8mIjf?=
 =?us-ascii?Q?Y6OIO91F4JsXdAjSh4hdTeBEaIYlWdYYcqmgdGZzPYbzY99EAczEZNyYC+Ac?=
 =?us-ascii?Q?b2wyvLH+EXaOxqGvoKngYNcMQVJfnWu9tKbgK3XSd4d2e0rZ5opAujkLIo3C?=
 =?us-ascii?Q?ig4ca0yX3NwjlyroRLU+L/kmkR9B7WfLXu9SCIUQAUHvAZXiKIj06PkaHTpJ?=
 =?us-ascii?Q?9yj+8hjtUNOeNZhoGMZdJ3RzR8KboITerELgslbS9ucMTi6F1gupGhyUWMhq?=
 =?us-ascii?Q?vxKNc3ZCPrJJeaBbTCQv3/ei8s7FLhOjYXGqe1Ox8Ve5TGT0Msz/40ivWBgQ?=
 =?us-ascii?Q?U7o8uTjXHs2VSTw2vW59truLwoQyUzLA3XfsyElO3HoV6YEBAwo9DYbQRvn7?=
 =?us-ascii?Q?SqJPKT7yx3csWYQiBByh9kFPJH+8YyR7qeg0VconY+eL5pRSHJp+WjFpr+3n?=
 =?us-ascii?Q?Azz1aNYywoT0HZhLAlliEAJPGkAhU0HKCQvGRXRtjZuwpghfIg2IskfRAJom?=
 =?us-ascii?Q?gAy5ZC5LuUXtdkz7cB4yCzFzKd5M+4nTdVIR7V6mV8UNspbPP2vw7dV2pnz6?=
 =?us-ascii?Q?+1sC982FAPV5t9CE2ejjeW/2e9BzNCTQkAn2soehp9J/Y1Ustx5dPnR8Spp3?=
 =?us-ascii?Q?7FMdm1uPq+wPaBlBBvpYhdfrwcRFJLtkLfx2oYOEn7/UYUny3Wger2/9QFgR?=
 =?us-ascii?Q?ow+quak4XfKCpnrlTixRZpwW9wsWJZO+2E3qF8LM04scRPiClE5l5neXtFMl?=
 =?us-ascii?Q?BhGUpiIKaHq+PcOgINpf8huVUcPRBiDbbjsy5mz50Uu6hZ08j1617XSGPMw7?=
 =?us-ascii?Q?iIKv6kF1B80B2B+o5RSNaZ27E1tgXkGrFcaSjiryLEaxvTmMHWwKaiWurEqI?=
 =?us-ascii?Q?pNjDhDpcaPBV3SHuOzHfdO6lyNq5p0Qf82LIxmnCojoxmrJGdwSgTQCqcNO6?=
 =?us-ascii?Q?s8A42sgyEjQPM8gGAGRnG+CcTrNBdD21D4/kwEIaQ93BSwu6pzJ8R4gjsYyU?=
 =?us-ascii?Q?gvYxCqLe8t0QtRX8i/Z5Nhunx+vHVQskgyTOWv9kAHvZiGl3kFgPmk/DS8Sm?=
 =?us-ascii?Q?GilSAiEP5Y7AHhL1CM5pTloTntIPLR7/R3v8MIfsj6gTRsqs+sro2ONab2jd?=
 =?us-ascii?Q?mA71/Q3538mH22Pkm20=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41a035bd-57ab-4afe-6891-08dda98ad22e
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2025 08:26:25.2627 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K3l9yVaPUYPxAZtH881Ss/ph98b56NQNPdZHR3SIu3EN/aMZxeKwyD7ojSwWxCfE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4295
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

[AMD Official Use Only - AMD Internal Distribution Only]

Series is

Reviewed-by: Yang Wang <kevinyang.wang@amd.com>

Best Regards,
Kevin
-----Original Message-----
From: Kenneth Feng <kenneth.feng@amd.com>
Sent: Thursday, June 12, 2025 16:02
To: amd-gfx@lists.freedesktop.org
Cc: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; Feng, Kenneth <Kenneth.Feng=
@amd.com>
Subject: [PATCH 1/2] drm/amd/pm: override pcie dpm parameters only if it is=
 necessary

override pcie dpm parameters only if it is necessary

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 31 +++++++------
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 22 ++++++----
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    | 43 +++++++++++--------
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c  | 37 ++++++++++------
 4 files changed, 77 insertions(+), 56 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/=
drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 7fad5dfb39c4..d7d5ec247624 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -2444,7 +2444,8 @@ static int navi10_update_pcie_parameters(struct smu_c=
ontext *smu,
        struct smu_11_0_dpm_context *dpm_context =3D smu->smu_dpm.dpm_conte=
xt;
        PPTable_t *pptable =3D smu->smu_table.driver_pptable;
        uint32_t smu_pcie_arg;
-       int ret, i;
+       int ret =3D 0;
+       int i;

        /* lclk dpm table setup */
        for (i =3D 0; i < MAX_PCIE_CONF; i++) {
@@ -2453,25 +2454,23 @@ static int navi10_update_pcie_parameters(struct smu=
_context *smu,
        }

        for (i =3D 0; i < NUM_LINK_LEVELS; i++) {
-               smu_pcie_arg =3D (i << 16) |
-                       ((pptable->PcieGenSpeed[i] <=3D pcie_gen_cap) ? (pp=
table->PcieGenSpeed[i] << 8) :
-                               (pcie_gen_cap << 8)) | ((pptable->PcieLaneC=
ount[i] <=3D pcie_width_cap) ?
-                                       pptable->PcieLaneCount[i] : pcie_wi=
dth_cap);
-               ret =3D smu_cmn_send_smc_msg_with_param(smu,
-                                         SMU_MSG_OverridePcieParameters,
-                                         smu_pcie_arg,
-                                         NULL);
-
-               if (ret)
-                       return ret;
-
-               if (pptable->PcieGenSpeed[i] > pcie_gen_cap)
+               if (pptable->PcieGenSpeed[i] > pcie_gen_cap ||
+                       pptable->PcieLaneCount[i] > pcie_width_cap) {
                        dpm_context->dpm_tables.pcie_table.pcie_gen[i] =3D =
pcie_gen_cap;
-               if (pptable->PcieLaneCount[i] > pcie_width_cap)
                        dpm_context->dpm_tables.pcie_table.pcie_lane[i] =3D=
 pcie_width_cap;
+                       smu_pcie_arg =3D i << 16;
+                       smu_pcie_arg |=3D pcie_gen_cap << 8;
+                       smu_pcie_arg |=3D pcie_width_cap;
+                       ret =3D smu_cmn_send_smc_msg_with_param(smu,
+                                                       SMU_MSG_OverridePci=
eParameters,
+                                                       smu_pcie_arg,
+                                                       NULL);
+                       if (ret)
+                               break;
+               }
        }

-       return 0;
+       return ret;
 }

 static inline void navi10_dump_od_table(struct smu_context *smu, diff --gi=
t a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/d=
rm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 115e3fa456bc..d57591509aed 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -2145,7 +2145,8 @@ static int sienna_cichlid_update_pcie_parameters(stru=
ct smu_context *smu,
        uint8_t min_gen_speed, max_gen_speed;
        uint8_t min_lane_width, max_lane_width;
        uint32_t smu_pcie_arg;
-       int ret, i;
+       int ret =3D 0;
+       int i;

        GET_PPTABLE_MEMBER(PcieGenSpeed, &table_member1);
        GET_PPTABLE_MEMBER(PcieLaneCount, &table_member2); @@ -2170,19 +217=
1,22 @@ static int sienna_cichlid_update_pcie_parameters(struct smu_context=
 *smu,
        pcie_table->pcie_lane[1] =3D max_lane_width;

        for (i =3D 0; i < NUM_LINK_LEVELS; i++) {
-               smu_pcie_arg =3D (i << 16 |
+               if (!(smu->adev->pm.pp_feature & PP_PCIE_DPM_MASK) ||
+                       table_member1[i] > pcie_gen_cap || table_member2[i]=
 > pcie_width_cap) {
+                       smu_pcie_arg =3D (i << 16 |
                                pcie_table->pcie_gen[i] << 8 |
                                pcie_table->pcie_lane[i]);

-               ret =3D smu_cmn_send_smc_msg_with_param(smu,
-                               SMU_MSG_OverridePcieParameters,
-                               smu_pcie_arg,
-                               NULL);
-               if (ret)
-                       return ret;
+                       ret =3D smu_cmn_send_smc_msg_with_param(smu,
+                                               SMU_MSG_OverridePcieParamet=
ers,
+                                               smu_pcie_arg,
+                                               NULL);
+                       if (ret)
+                               break;
+               }
        }

-       return 0;
+       return ret;
 }

 static int sienna_cichlid_get_dpm_ultimate_freq(struct smu_context *smu, d=
iff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/dr=
m/amd/pm/swsmu/smu13/smu_v13_0.c
index 1c7235935d14..1a1f2a6b2e52 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -2386,7 +2386,8 @@ int smu_v13_0_update_pcie_parameters(struct smu_conte=
xt *smu,
                                &dpm_context->dpm_tables.pcie_table;
        int num_of_levels =3D pcie_table->num_of_link_levels;
        uint32_t smu_pcie_arg;
-       int ret, i;
+       int ret =3D 0;
+       int i;

        if (!num_of_levels)
                return 0;
@@ -2402,30 +2403,38 @@ int smu_v13_0_update_pcie_parameters(struct smu_con=
text *smu,
                for (i =3D 0; i < num_of_levels; i++) {
                        pcie_table->pcie_gen[i] =3D pcie_gen_cap;
                        pcie_table->pcie_lane[i] =3D pcie_width_cap;
+                       smu_pcie_arg =3D i << 16;
+                       smu_pcie_arg |=3D pcie_table->pcie_gen[i] << 8;
+                       smu_pcie_arg |=3D pcie_table->pcie_lane[i];
+
+                       ret =3D smu_cmn_send_smc_msg_with_param(smu,
+                                                               SMU_MSG_Ove=
rridePcieParameters,
+                                                               smu_pcie_ar=
g,
+                                                               NULL);
+                       if (ret)
+                               break;
                }
        } else {
                for (i =3D 0; i < num_of_levels; i++) {
-                       if (pcie_table->pcie_gen[i] > pcie_gen_cap)
+                       if (pcie_table->pcie_gen[i] > pcie_gen_cap ||
+                               pcie_table->pcie_lane[i] > pcie_width_cap) =
{
                                pcie_table->pcie_gen[i] =3D pcie_gen_cap;
-                       if (pcie_table->pcie_lane[i] > pcie_width_cap)
                                pcie_table->pcie_lane[i] =3D pcie_width_cap=
;
+                               smu_pcie_arg =3D i << 16;
+                               smu_pcie_arg |=3D pcie_table->pcie_gen[i] <=
< 8;
+                               smu_pcie_arg |=3D pcie_table->pcie_lane[i];
+
+                               ret =3D smu_cmn_send_smc_msg_with_param(smu=
,
+                                                                       SMU=
_MSG_OverridePcieParameters,
+                                                                       smu=
_pcie_arg,
+                                                                       NUL=
L);
+                               if (ret)
+                                       break;
+                       }
                }
        }

-       for (i =3D 0; i < num_of_levels; i++) {
-               smu_pcie_arg =3D i << 16;
-               smu_pcie_arg |=3D pcie_table->pcie_gen[i] << 8;
-               smu_pcie_arg |=3D pcie_table->pcie_lane[i];
-
-               ret =3D smu_cmn_send_smc_msg_with_param(smu,
-                                                     SMU_MSG_OverridePcieP=
arameters,
-                                                     smu_pcie_arg,
-                                                     NULL);
-               if (ret)
-                       return ret;
-       }
-
-       return 0;
+       return ret;
 }

 int smu_v13_0_disable_pmfw_state(struct smu_context *smu) diff --git a/dri=
vers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers/gpu/drm/amd/pm/=
swsmu/smu14/smu_v14_0_2_ppt.c
index 82c2db972491..d5a4abd60d06 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
@@ -1489,7 +1489,8 @@ static int smu_v14_0_2_update_pcie_parameters(struct =
smu_context *smu,
                                &dpm_context->dpm_tables.pcie_table;
        int num_of_levels =3D pcie_table->num_of_link_levels;
        uint32_t smu_pcie_arg;
-       int ret, i;
+       int ret =3D 0;
+       int i;

        if (!num_of_levels)
                return 0;
@@ -1505,30 +1506,38 @@ static int smu_v14_0_2_update_pcie_parameters(struc=
t smu_context *smu,
                for (i =3D 0; i < num_of_levels; i++) {
                        pcie_table->pcie_gen[i] =3D pcie_gen_cap;
                        pcie_table->pcie_lane[i] =3D pcie_width_cap;
+                       smu_pcie_arg =3D i << 16;
+                       smu_pcie_arg |=3D pcie_table->pcie_gen[i] << 8;
+                       smu_pcie_arg |=3D pcie_table->pcie_lane[i];
+
+                       ret =3D smu_cmn_send_smc_msg_with_param(smu,
+                                                     SMU_MSG_OverridePcieP=
arameters,
+                                                     smu_pcie_arg,
+                                                     NULL);
+                       if (ret)
+                               break;
                }
        } else {
                for (i =3D 0; i < num_of_levels; i++) {
-                       if (pcie_table->pcie_gen[i] > pcie_gen_cap)
+                       if (pcie_table->pcie_gen[i] > pcie_gen_cap ||
+                               pcie_table->pcie_lane[i] > pcie_width_cap) =
{
                                pcie_table->pcie_gen[i] =3D pcie_gen_cap;
-                       if (pcie_table->pcie_lane[i] > pcie_width_cap)
                                pcie_table->pcie_lane[i] =3D pcie_width_cap=
;
-               }
-       }
-
-       for (i =3D 0; i < num_of_levels; i++) {
-               smu_pcie_arg =3D i << 16;
-               smu_pcie_arg |=3D pcie_table->pcie_gen[i] << 8;
-               smu_pcie_arg |=3D pcie_table->pcie_lane[i];
+                               smu_pcie_arg =3D i << 16;
+                               smu_pcie_arg |=3D pcie_table->pcie_gen[i] <=
< 8;
+                               smu_pcie_arg |=3D pcie_table->pcie_lane[i];

-               ret =3D smu_cmn_send_smc_msg_with_param(smu,
+                               ret =3D smu_cmn_send_smc_msg_with_param(smu=
,
                                                      SMU_MSG_OverridePcieP=
arameters,
                                                      smu_pcie_arg,
                                                      NULL);
-               if (ret)
-                       return ret;
+                               if (ret)
+                                       break;
+                       }
+               }
        }

-       return 0;
+       return ret;
 }

 static const struct smu_temperature_range smu14_thermal_policy[] =3D {
--
2.34.1

