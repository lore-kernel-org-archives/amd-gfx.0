Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EF0DCD4F54
	for <amd-gfx@archiver.kernel.org>; Fri, 29 May 2026 13:12:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8353610FEEC;
	Fri, 29 May 2026 13:12:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MOBeQvD7";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012005.outbound.protection.outlook.com [52.101.53.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66FF710FEEC
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 May 2026 13:12:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s8IGb5/StvqCPghYVVguuNlYKtvh+a6wu2otgYw98QlOEn2aAycjfF76tlBUvXQms/zmz+PLecVBwz0qzT7nPZ5U7q6DjUbsqxUNW2J42WfRjs0m3gi3Cg6ds+fGPXh1abo+TvwGGCRmGCqJmMNnOxP72dquXS7i5h8tmdZs9e9VJG3KA3ThYN6b+p6iB1sKzXeCA/hd+JFCbEYp8xO5+B1w7wWbMz/xKR1ZoDmPxqEqfhr3WyyDa0oiIB87PefB1C06aCZnpLTGVdPnZPfQxrbMBovtMjnYZ25VYuX4o5CP3MujXImVOVfV0QsiOWCHXIwbtzMchHHBPvzW3q2kOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pWxU/+miD9u0BC2c/FttcWW6RL8qoR3g4BKRZ3cs4Ls=;
 b=cWl0bnEDNB34/u3OwzuR6RYYtKwD6ZDG6CVMti/f7YeqxvgJo8n3tnB61VinV4Zys87xsAsodl1EYZSxlknTbZz2FeIqevYCikoBBTtPJsKkcpu5cvCcHqs229f1TlwUMPh+xOeRMDacyrxvivF5yoBUiH275axIGOD+1Fa2somm6QECAXvPastF0RE1qoAbDrp3vyvC2LRpRk6FNbrm0avluiaelGGcaSk2bNYAh0mCNpJdAChWGvSbxrSmOlRRxOpqYFXmPOqup/G/ZsCuSlCcBObU7zjEbGhfSowc9YQz1kkh0/wivLjOdwAyV5os2t+A89aN3oC8C6LOJYeiTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pWxU/+miD9u0BC2c/FttcWW6RL8qoR3g4BKRZ3cs4Ls=;
 b=MOBeQvD7t9yUoyA3YLRvuTn1Gjbm790BIKRMi4lpsJ7fpDL6GY7Ig+4g/9rndKH1iOE6pNxv3wVCdyk1Lh/8kyGwgp/0kBXTGbnRlPFpP852kLkTRh8qJjtEm2SnKCBxnT1gpfpJC67ZWwuABp6bYLbQbjpEMwoy7Yv/UQcPhG8=
Received: from BN9PR12MB5257.namprd12.prod.outlook.com (2603:10b6:408:11e::16)
 by CH0PR12MB8507.namprd12.prod.outlook.com (2603:10b6:610:189::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Fri, 29 May
 2026 13:12:45 +0000
Received: from BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::1aeb:47e6:faf1:5f13]) by BN9PR12MB5257.namprd12.prod.outlook.com
 ([fe80::1aeb:47e6:faf1:5f13%5]) with mapi id 15.21.0071.014; Fri, 29 May 2026
 13:12:45 +0000
From: "Zhang, Hawking" <Hawking.Zhang@amd.com>
To: "Lazar, Lijo" <Lijo.Lazar@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Kamal, Asad"
 <Asad.Kamal@amd.com>, "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
Subject: RE: [PATCH] drm/amd/pm: Validate custom profile parameters
Thread-Topic: [PATCH] drm/amd/pm: Validate custom profile parameters
Thread-Index: AQHc70/Eyj/6edyPvkiGJZPknafeBrYk+viw
Date: Fri, 29 May 2026 13:12:45 +0000
Message-ID: <BN9PR12MB525762299D5A0643E0763224FC162@BN9PR12MB5257.namprd12.prod.outlook.com>
References: <20260529094416.1135533-1-lijo.lazar@amd.com>
In-Reply-To: <20260529094416.1135533-1-lijo.lazar@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-05-29T13:12:26.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5257:EE_|CH0PR12MB8507:EE_
x-ms-office365-filtering-correlation-id: afbd1580-32d8-4408-8a7a-08debd83f91d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|18002099003|22082099003|3023799007|11063799006|56012099006|38070700021;
x-microsoft-antispam-message-info: 9e0wUuJh493eqKi7OuU7Ewj9qxMYGsL/GGvnGN0OFUTFtGO/t9yHr6bBEPaL7IISuRRRaNfGktVSWkXT9Kq64DfaWb73E+6X/xX2yHapdJoRUpHmBqgCSqRSFEQbiR0bnv100/Y42PsgM5KW5s5W717VQL0KCA+BRZvW89WohUmTcxzn8gA3l0MhPyS3siTHC2yjGKGzI4IFHtb5yUkOVAStuhkeIyQ81GvLv3itNzkzjCMWcfhHVRRBVDxrqli0FO2kHMR/6gNOsTgjYYectt3uFgW5CE2mjVkeqLvlFUTr938J5SUtb7GupkdTULV6KdGJQm5/W3hmm12BuKaUhcquYJifHBavm+B/rK8MuJtOKKb396XxduNqNOqi3uFrl4/rv81Q3P7/lTmM893V4bFVP3l0qp1NJEPtVS3idkxpIud5E2K7Kb+T/XeAs7FRYSlIT9U1Xnd1a/nXQFnkUbVav8poNx0/7Y5DBVAyIO++nBgQ1+M9aEnQB8msIrh+3NXq548h0+te42dA3IVpNV88Z0ctGwyLjtSHg1rt8otoezDdCsCLg6ZYY+v+unsXkMWA3UeRvS7kGEFx5DDAcMDPhQ22X034Ixwx0PzZo+20pYC6FebhRqZ1sx33jQluFUYFRQ6G0el7MQzrrrR9LQgGJ8gP25D2R4/rP964giGSaXG7fw60JaiRsRdrDlrkV/UmvJx7K7Ij4FYCpTsnw74pg4ic7rRrn0m4YdUeRB91ZrdBN10/W+o0ox5Isf57
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5257.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(22082099003)(3023799007)(11063799006)(56012099006)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RbDSy6EJZUl0CjPJkyNV2sx1/b8oJbJCtF+0YY6exu0kdoDXLAOTBdhxfnju?=
 =?us-ascii?Q?u1mB3ZCSPj6+Xrj+apiWLsCA/MmOGv7HKR6nkkEONJ+/uHzxdw233mpqVKec?=
 =?us-ascii?Q?CiVulr884+3Uo64nVHLqXvMoaMBA2PpiwH9NxdPO1ZO9sJ4NGCgO/0pojP5N?=
 =?us-ascii?Q?mwtJi5gjt3mIxT6hMnGygCmbnpFg/hplCPo5xN7qoZ+j0h83gOYsyoI9LMYo?=
 =?us-ascii?Q?zFoaL7nZWTwwxsj671lnqxZQh52uR7nCb3yjdgbbaZjIx8HWq73+VIA5/a9X?=
 =?us-ascii?Q?c34zLcek2HF5O6ACs2my3KPXwohy22Cj9iuzSipSeRldxKnCDOD2xdF7Lor1?=
 =?us-ascii?Q?gn3DSvmg7Ffad3Y2yMjwvN4H6V1fr9p3bKo6JpfXB5Nzc30LtJf4u9Sca3v4?=
 =?us-ascii?Q?19p8WiVEbBd73KHUawWzWivk5f1bYXPkJ5d+g7Aj4zaA48pc9GdxkKlWwwzW?=
 =?us-ascii?Q?RF/DdaHK8pIRWblyv4Du9b1Et4EWZbxBk5ucEaVoDpAyjwKoQb02HJSVpLH1?=
 =?us-ascii?Q?pBeZU345y2DifeETtQT2Z3pjjRKDJxW6jX2L2FMMpWdHUmitiKftEzTIlSST?=
 =?us-ascii?Q?TEkSETULjRbcfLaDxEfAuYLZpK9rUp1b7JA1W1JXocwxgaiFwhxOthFx1M6a?=
 =?us-ascii?Q?9TIaABKCvRcen8bhPAF7Ri0GEAXgJX9pbnJeq/m/M0h+qvX0L6ppl4ntk1iZ?=
 =?us-ascii?Q?o7z1+R9bMQ8Nse4RonQenrSC/kHAXVmrV/PcOqEzt87yI1wq2wZIcz5cdDQ+?=
 =?us-ascii?Q?VvWEpFvzE1ccDKaJ/PZSmhPbQ8bw1TNShPLccZrulDE/xFv7xGEyIOPnC0ua?=
 =?us-ascii?Q?3LR1wTCIkbir5TQLbyJBM+UUJQ4W36FOD00YkufPi7DDKKmShvhHmg5YbIBJ?=
 =?us-ascii?Q?mz5delD7ruAicKIqtWEBypgpqFCPiT6KBNOSTNCAi+0PZ/r9cMMdDh/HW2UG?=
 =?us-ascii?Q?CKyeSZKc6d53IQo6jrURX0P9T4i6B/vnMNIFvi+QPWAzn6UOH6yVV4o5oS52?=
 =?us-ascii?Q?DmOsdSFM0p1RCbu7IG2P8Nl8BTZR4Fylu8CR8OQMmguyCMfqrowGDRMaPV01?=
 =?us-ascii?Q?rTbCz/9jGfvkaXhb5x3Af4YqqdpELlRoUzGhSenDHy4AUmMc8LXhIrvA3+ec?=
 =?us-ascii?Q?uTL1EwV1V/wfChbLZFdm8cWKlksWExODKleujhIFE2qPSCmG3gigKd1QJQVB?=
 =?us-ascii?Q?e65SuBuDqmPU+qWJWYg1yyFTj0Uk0Czzo43ZvPEc3wK0ORM+aARTYxHV0Aqr?=
 =?us-ascii?Q?r3La1ITnygPR5Xpb5jf5RENvBB2pYji+eK+kwCvzVStCU3D8ShGeVlsgiMPS?=
 =?us-ascii?Q?fA3yAAqcIc32aPodxANOBqg+e1Takpn9poqpOHif393QthRD6RFHFRrmCs1H?=
 =?us-ascii?Q?SKMbhYU2Ncj425u+L+T79b7qzCw2O2s/GFviwTWsatFDrhI0IaLdQMIGgh4b?=
 =?us-ascii?Q?mAVeH4VALTlhiAYBWXKjSFOuHjiZzPcmZSbjY+ILYLy4IE2P70UvlPBTaHPo?=
 =?us-ascii?Q?zB71kiVjJYAQNaRnHN4i090Qx28FYdTag5nI3r1opMekOmA2ABZPbkxSJfMy?=
 =?us-ascii?Q?uMCKb3GMAjpLTGwA2HmE75NjEql6/9EvP3nK/UtMvaQ7UTvaSFj8qPU6ayPo?=
 =?us-ascii?Q?S5VNfLGanPzRr94XrqqpDL4UQBfPcTRqzJ2ftkF2/9fBFaNPPkXN6ACvfTDS?=
 =?us-ascii?Q?B90RqpXnIyL718IRaM64UiIihNizo+goON0VUytU8Myg/arT?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5257.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afbd1580-32d8-4408-8a7a-08debd83f91d
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 May 2026 13:12:45.0523 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kIU+rApbLM3M5MJt4boVQrK4EB2H/ipIQNfZeSdmmAvfFI4uJHnsOto31c8rpU6FYig2wgwbe5/96Ug8MzXlhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8507
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

AMD General

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>

Regards,
Hawking
-----Original Message-----
From: Lazar, Lijo <Lijo.Lazar@amd.com>
Sent: Friday, May 29, 2026 5:44 PM
To: amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander <Alexander.D=
eucher@amd.com>; Kamal, Asad <Asad.Kamal@amd.com>; Wang, Yang(Kevin) <Kevin=
Yang.Wang@amd.com>
Subject: [PATCH] drm/amd/pm: Validate custom profile parameters

Add helpers to validate custom profile params against negative/out-of-range=
 values. Use the helpers to validate user passed params.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Assisted-by: Claude Sonnet (Cursor AI)
---
 drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c      |  7 ++++---
 drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c        |  7 ++++---
 .../gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c    |  7 ++++---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c   |  7 ++++---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c   |  7 ++++---
 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c   |  7 ++++---
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h                 | 10 ++++++++++
 7 files changed, 34 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gp=
u/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index d73c3c191e9c..051a0008aa10 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -1467,9 +1467,10 @@ static int arcturus_set_power_profile_mode(struct sm=
u_context *smu,
                                return -ENOMEM;
                }
                if (custom_params && custom_params_max_idx) {
-                       if (custom_params_max_idx !=3D ARCTURUS_CUSTOM_PARA=
MS_COUNT)
-                               return -EINVAL;
-                       if (custom_params[0] >=3D ARCTURUS_CUSTOM_PARAMS_CL=
OCK_COUNT)
+                       if (!smu_cmn_custom_params_count_valid(custom_param=
s_max_idx,
+                                                              ARCTURUS_CUS=
TOM_PARAMS_COUNT) ||
+                           !smu_cmn_custom_params_clock_valid(custom_param=
s[0],
+                                                              ARCTURUS_CUS=
TOM_PARAMS_CLOCK_COUNT))
                                return -EINVAL;
                        idx =3D custom_params[0] * ARCTURUS_CUSTOM_PARAMS_C=
OUNT;
                        smu->custom_profile_params[idx] =3D 1; diff --git a=
/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/s=
wsmu/smu11/navi10_ppt.c
index f2ce8de58cb9..2f2a5953dbbc 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -1845,9 +1845,10 @@ static int navi10_set_power_profile_mode(struct smu_=
context *smu,
                                return -ENOMEM;
                }
                if (custom_params && custom_params_max_idx) {
-                       if (custom_params_max_idx !=3D NAVI10_CUSTOM_PARAMS=
_COUNT)
-                               return -EINVAL;
-                       if (custom_params[0] >=3D NAVI10_CUSTOM_PARAMS_CLOC=
KS_COUNT)
+                       if (!smu_cmn_custom_params_count_valid(custom_param=
s_max_idx,
+                                                              NAVI10_CUSTO=
M_PARAMS_COUNT) ||
+                           !smu_cmn_custom_params_clock_valid(custom_param=
s[0],
+                                                              NAVI10_CUSTO=
M_PARAMS_CLOCKS_COUNT))
                                return -EINVAL;
                        idx =3D custom_params[0] * NAVI10_CUSTOM_PARAMS_COU=
NT;
                        smu->custom_profile_params[idx] =3D 1; diff --git a=
/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/=
amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 68255cfcb04d..70897c70db32 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -1756,9 +1756,10 @@ static int sienna_cichlid_set_power_profile_mode(str=
uct smu_context *smu,
                                return -ENOMEM;
                }
                if (custom_params && custom_params_max_idx) {
-                       if (custom_params_max_idx !=3D SIENNA_CICHLID_CUSTO=
M_PARAMS_COUNT)
-                               return -EINVAL;
-                       if (custom_params[0] >=3D SIENNA_CICHLID_CUSTOM_PAR=
AMS_CLOCK_COUNT)
+                       if (!smu_cmn_custom_params_count_valid(custom_param=
s_max_idx,
+                                                              SIENNA_CICHL=
ID_CUSTOM_PARAMS_COUNT) ||
+                           !smu_cmn_custom_params_clock_valid(custom_param=
s[0],
+                                                              SIENNA_CICHL=
ID_CUSTOM_PARAMS_CLOCK_COUNT))
                                return -EINVAL;
                        idx =3D custom_params[0] * SIENNA_CICHLID_CUSTOM_PA=
RAMS_COUNT;
                        smu->custom_profile_params[idx] =3D 1; diff --git a=
/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd=
/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index fa91837f7024..d7792616e4b9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -2734,9 +2734,10 @@ static int smu_v13_0_0_set_power_profile_mode(struct=
 smu_context *smu,
                                return -ENOMEM;
                }
                if (custom_params && custom_params_max_idx) {
-                       if (custom_params_max_idx !=3D SMU_13_0_0_CUSTOM_PA=
RAMS_COUNT)
-                               return -EINVAL;
-                       if (custom_params[0] >=3D SMU_13_0_0_CUSTOM_PARAMS_=
CLOCK_COUNT)
+                       if (!smu_cmn_custom_params_count_valid(custom_param=
s_max_idx,
+                                                              SMU_13_0_0_C=
USTOM_PARAMS_COUNT) ||
+                           !smu_cmn_custom_params_clock_valid(custom_param=
s[0],
+                                                              SMU_13_0_0_C=
USTOM_PARAMS_CLOCK_COUNT))
                                return -EINVAL;
                        idx =3D custom_params[0] * SMU_13_0_0_CUSTOM_PARAMS=
_COUNT;
                        smu->custom_profile_params[idx] =3D 1; diff --git a=
/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd=
/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index 25f977a42a1c..ce83e299a66a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -2690,9 +2690,10 @@ static int smu_v13_0_7_set_power_profile_mode(struct=
 smu_context *smu,
                                return -ENOMEM;
                }
                if (custom_params && custom_params_max_idx) {
-                       if (custom_params_max_idx !=3D SMU_13_0_7_CUSTOM_PA=
RAMS_COUNT)
-                               return -EINVAL;
-                       if (custom_params[0] >=3D SMU_13_0_7_CUSTOM_PARAMS_=
CLOCK_COUNT)
+                       if (!smu_cmn_custom_params_count_valid(custom_param=
s_max_idx,
+                                                              SMU_13_0_7_C=
USTOM_PARAMS_COUNT) ||
+                           !smu_cmn_custom_params_clock_valid(custom_param=
s[0],
+                                                              SMU_13_0_7_C=
USTOM_PARAMS_CLOCK_COUNT))
                                return -EINVAL;
                        idx =3D custom_params[0] * SMU_13_0_7_CUSTOM_PARAMS=
_COUNT;
                        smu->custom_profile_params[idx] =3D 1; diff --git a=
/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers/gpu/drm/amd=
/pm/swsmu/smu14/smu_v14_0_2_ppt.c
index 6b5aa4e514fd..933873de7850 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
@@ -1829,9 +1829,10 @@ static int smu_v14_0_2_set_power_profile_mode(struct=
 smu_context *smu,
                                return -ENOMEM;
                }
                if (custom_params && custom_params_max_idx) {
-                       if (custom_params_max_idx !=3D SMU_14_0_2_CUSTOM_PA=
RAMS_COUNT)
-                               return -EINVAL;
-                       if (custom_params[0] >=3D SMU_14_0_2_CUSTOM_PARAMS_=
CLOCK_COUNT)
+                       if (!smu_cmn_custom_params_count_valid(custom_param=
s_max_idx,
+                                                              SMU_14_0_2_C=
USTOM_PARAMS_COUNT) ||
+                           !smu_cmn_custom_params_clock_valid(custom_param=
s[0],
+                                                              SMU_14_0_2_C=
USTOM_PARAMS_CLOCK_COUNT))
                                return -EINVAL;
                        idx =3D custom_params[0] * SMU_14_0_2_CUSTOM_PARAMS=
_COUNT;
                        smu->custom_profile_params[idx] =3D 1; diff --git a=
/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h b/drivers/gpu/drm/amd/pm/swsmu/smu_=
cmn.h
index 0e119965ce13..5b7f64b94179 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
@@ -113,6 +113,16 @@ static inline int pcie_gen_to_speed(uint32_t gen)
        return ((gen =3D=3D 0) ? link_speed[0] : link_speed[gen - 1]);  }

+static inline bool smu_cmn_custom_params_count_valid(u32 max_idx, u32
+params_count) {
+       return max_idx =3D=3D params_count;
+}
+
+static inline bool smu_cmn_custom_params_clock_valid(long clock_idx,
+long clock_count) {
+       return clock_idx >=3D 0 && clock_idx < clock_count; }
+
 int smu_cmn_send_smc_msg_with_param(struct smu_context *smu,
                                    enum smu_message_type msg,
                                    uint32_t param,
--
2.49.0

