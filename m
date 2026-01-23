Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA1E5D6CFDE
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Jan 2026 06:41:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 646D110E2DD;
	Fri, 23 Jan 2026 06:41:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AhqvBZ1k";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010052.outbound.protection.outlook.com
 [40.93.198.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2642910E2DD
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Jan 2026 06:41:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YyWpg0YM9pCVnLNFEXoPVL2nVN11WIiJpQNQbL+5Nh0xnv29FBkQr1OAYPt27138hdCsHT7G9oPpHlrDxIgFn/4VO/LtyJYhbpEWc6MbDpIOef9GF9RjXZrzMVAWAuOgMLbLnZbvK5gIx0WWpHoUxpcsXC0Q6nipe76r0XVTDz9nraYucEy+p6sypHIPEKQQm5Fz4TT1ye2nsCbDBIOVLPFtC6DpwGTyiLZqHesaMh1WAVw4fN2mpRwc0kiUSwlbqFz1UtUdohmHVrREFeA1toJQrKvxA2t1Hze+3Od2RMLNKmFAA0RcAAOj9aCmsIU77QO7VwyPloDetPRp10UTvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=96fvvE3V5Mgfm6QvVrm3qZui5ozaXHg3MG6hUwCKJJg=;
 b=vIrB0Aa/rcxGByIFuc/yFTy0lIzjLY2CeXcFUEg0+rTv8yaqSGl+fiJKnayKmgQbT1VR3TFmaIyQCrdFv0sSYUeuIIuxn/Wgps4221gJCsMB2jyt5ok3+QK5+MpJmE/LwipQUCpr86yPEV/ysaU8jwQgMz8bgSRRlUsYr4Ca38/rVcOTrcJanMcklehDMOZWnWRwlM0KungcWEyp6QJgvvt8FBQgET1DclBX9xwGGcVsELsPdrTUA+Dc3T0Yu5twfLGL4EkTezi17rhNbU+ZFB6VCplpCKnR8EOrNesZiR4rZGSUBaZK4ymlDyF+yfJKpqSqgDfU80HgIYjy71r2mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=96fvvE3V5Mgfm6QvVrm3qZui5ozaXHg3MG6hUwCKJJg=;
 b=AhqvBZ1knnMjfb6wkp33JEOuNA/Io9lTt6fVMVCK0FR96gi7qVMXQ9u1woWCgA//+HbILneyoQmgjegpxbLSFnjTtfqmwpx7ckeNQJWcVCufb/yf+WOV5eL6CEvs+py7MvILajE7T9Cbbbivky9GMfqSQxW2R/SdwOUkMl2hdoM=
Received: from PH7PR12MB5997.namprd12.prod.outlook.com (2603:10b6:510:1d9::21)
 by MN0PR12MB5714.namprd12.prod.outlook.com (2603:10b6:208:371::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Fri, 23 Jan
 2026 06:41:29 +0000
Received: from PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::7547:2c7b:d652:8d04]) by PH7PR12MB5997.namprd12.prod.outlook.com
 ([fe80::7547:2c7b:d652:8d04%3]) with mapi id 15.20.9542.010; Fri, 23 Jan 2026
 06:41:29 +0000
From: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>
To: "Feng, Kenneth" <Kenneth.Feng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Feng, Kenneth"
 <Kenneth.Feng@amd.com>
Subject: RE: [PATCH 1/2] drm/amd/pm: use debug port for mode1 reset request on
 smu 13&14
Thread-Topic: [PATCH 1/2] drm/amd/pm: use debug port for mode1 reset request
 on smu 13&14
Thread-Index: AQHcjC0gxQmmdoqFvEGteWdLgLzVy7VfTUWQ
Date: Fri, 23 Jan 2026 06:41:29 +0000
Message-ID: <PH7PR12MB599728646DD69F17C14580928294A@PH7PR12MB5997.namprd12.prod.outlook.com>
References: <20260123055654.3776-1-kenneth.feng@amd.com>
In-Reply-To: <20260123055654.3776-1-kenneth.feng@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-01-23T06:37:57.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB5997:EE_|MN0PR12MB5714:EE_
x-ms-office365-filtering-correlation-id: bc12c1cd-613c-48bb-e85f-08de5a4a705a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?bDWSnYgfEIVdQ1TYbJG4cXQU+fRVYBXUNtJ+ixK0wFldiCUMWiQkDToOPKD+?=
 =?us-ascii?Q?lQ3myw9vYR90QJtAGgnbqfm1m0ZCCN0sqz0otA8i+RDvPwucA2iHL7mwVODQ?=
 =?us-ascii?Q?drTn+Qv8qALXH1Prvaojq2cRib7FKuXh0bqQDsMuXYJ940fIOE4JtPV1gMBs?=
 =?us-ascii?Q?FjtX4432rdTXx2a0mHG2hxu64SrjfwJm0BxduJvJIAd8GVV55aUYc+k+kI8P?=
 =?us-ascii?Q?AtI7t/GDcJaIJpZKB4nt9kygrAF3ZRW++d4kmVSr+mb8/y3xJZ4ljr7Xcimn?=
 =?us-ascii?Q?N3T0PzwMD3m0zSCOsLa6VLn8tDJmX/1fv6OmXMVC9i9z8M0OMgQIzGFyWEnC?=
 =?us-ascii?Q?eVx8a4CvkkfiZ8aCHwwSN4rQyHGxJSbZAlLR6n8JXJiMOJGR/5k4lDJ8mfJ2?=
 =?us-ascii?Q?xeRyliwfRfN0FLZ4kxO9WKEacJTKJQ1wPUOuJuRRc7vp3mSQz5YSnHS8uCye?=
 =?us-ascii?Q?b6K+9+7KMtxotYv3gnHarSisfKdlba8EfFCEssAGo2P4FX8t1cAa7IL3OEKv?=
 =?us-ascii?Q?lN5x+wP/qjii/lOj/65R+RLpXQlJVuPYQyssHqQsERRWUppz7WAVCfQhrveQ?=
 =?us-ascii?Q?GKWYkpcMsq346haHWBICQ/TzD0hQL4uiM5tqu7XQPXf8GWRF+VK/nC5X/FMB?=
 =?us-ascii?Q?q7G2P58MJsfCMlPsOFoiaQK+Ypz61qVhrpbU1U+p9L6q72qfQixnqwLXpurs?=
 =?us-ascii?Q?TifYGP9VW6ReI26dNK8YswJOCXnLK/zJakFucD0+1pUFCNmEh1QCGY796720?=
 =?us-ascii?Q?mMgbUQyElDummR/RbHsfR2Iaa/P4RLxkQ5Ai2nODOgC+K87tJpqoQZLFHbXM?=
 =?us-ascii?Q?fkrBrHr+iM/oaQXVGgKKMBtNWUGB371cxGVeNy4cNQMn6SxRnRQvuQdUkuZP?=
 =?us-ascii?Q?Nox6GvXopOfHMyVJrOiGFI9g8a3SrTm1YJLYI3r8gmyRdrEpONh4xnr0yJYu?=
 =?us-ascii?Q?8bEEvELFl9IeCdscveDegWtrifWlOCjedoSadm5jiIycTkaPI/pEak7dtopf?=
 =?us-ascii?Q?NHj6ijNvyvDRKSeZpRCvHMU7BvRrKfiaRGKRGsokSUsXFONnsYKNRX10HLBt?=
 =?us-ascii?Q?nOLd/U5Vp7pLE8BOxVSlLn5Meb+IACN+HtjKH5Jo2NZQH8PPigMfjHLotswb?=
 =?us-ascii?Q?JqDKXGtJoecBozjJK0nH2KyikEaVd4LnoTTa4g/zK5LfnZ84CRqWOrwRN+/L?=
 =?us-ascii?Q?rp/NFAXJvLrev1JEQlf68MZuZblYabf5ZMUbr5oKyVuJkHeb2AG0BfrlmDly?=
 =?us-ascii?Q?kCc6rBbMyGgcxu4yrEz8VRcGAOwWLB/llozQPWyZQtqIGXourzS2PCTVu2hJ?=
 =?us-ascii?Q?i+WI0TqASRrHji7ZrWOT3FJUQeDiajNlnmR6mhIp1HsGBgq9Eqbc0ePhIDps?=
 =?us-ascii?Q?9LoD94cl8m8rSjaE8WxnDhezMt00j/n6ASuJ0esAV+CMTjC/9ZuoEnQz4Vzl?=
 =?us-ascii?Q?ebSG9TeK965lKJsaAy/1hZvMqtDTNI+o5DlLFARKHuc72gc3rMcCyeeUm+e3?=
 =?us-ascii?Q?Tr01/8fKcMfMXQUEkMAs9Rhs6+S5MT+TQ3LO3ixKQPwmLx+EOBG+BrT54/pz?=
 =?us-ascii?Q?jUbpjEyqR+S50RuTYplXuIZ7Mi5k+yjSRWNW9zu77rDxERDXqaWncgPHTXVa?=
 =?us-ascii?Q?wfWj3aV9B20SATv29rNZUOU=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IV9uFbCGr3plnHY2evoq6+y3GFJYihexfcIW5V0LZlpNFDZl+raptXpg+EyM?=
 =?us-ascii?Q?WNCbkSVSv1UTl3GuWTyMvW5OcjIakNOk5QVmgt/uyS3EYRVWX3WkpnYK4bTl?=
 =?us-ascii?Q?dZQwvhgwvhk4lgjYanWyE7lDl0jC0kJs2FaGwu3xJWaIptbdDuczg/8vLIWA?=
 =?us-ascii?Q?GS6XY0K0CLJe+4phqlJH5QXtvWVQYI+JzxClJphTurpFI62EoCK0sZAo6gJV?=
 =?us-ascii?Q?EibcrBho/5K0uBHJ99jcVGaQw3tb/gFOMKIcwN/ECFEcp8oE29Cvkdb6nYjl?=
 =?us-ascii?Q?i5+PIhv6zuOixQ8BrvRkqfXePsBjSUg9lfxWihsY58dfQr+opC74i8uyA6Eh?=
 =?us-ascii?Q?Q1foK59+1OYPPDwjGAS3YK9yxeS5Kyz87kqc6ELCE2gwvfJ2eorr44NvHOIE?=
 =?us-ascii?Q?pQnCcfTqXyEGan0qLgNzQqsGNAnwpTIllITMMNSAJ0wFQelkHNuY1e3m7xiZ?=
 =?us-ascii?Q?hEiuu1bK+oWyYB/MoB/HfyfI88J+BAKO6XqWQ7xpSd04A2aE6pF1IOOr9up+?=
 =?us-ascii?Q?ZiObbfrJPcwjoOtYLWAa3KK5YNEKpqdzoPdT4KcdGCcRaaub5GMHbBBHyYEa?=
 =?us-ascii?Q?XPBQljDia0vNdixh/SKNN14BulHMuD2MDn8pD/Ax6oi7eNZ/F3fYrLVgWKJY?=
 =?us-ascii?Q?x9h+PPgZemBpXlFMSmcyIoEqIpaYM5AEFUmbHK5zulBP7eC5tGIsqgCwbTNT?=
 =?us-ascii?Q?lUZQVt4hYuacI2FkuHYkxaCYAmDL94vuhpKW6dlj4U8sx6qzFvhgCjPFRkdQ?=
 =?us-ascii?Q?mgyEEXygjjR6p5HIPpPxcW92AJ7cbx/W+m1CBxl8DxGN1bh5fOD1HayeckVM?=
 =?us-ascii?Q?pkgFzuVfBQAAE0eC8ouYiMJCMfrxotTeLIjwRU/a5YZonjyOUR2+7195KZym?=
 =?us-ascii?Q?wlwNiM5IGhWdIjLtsM9goJcYCIamySNqKezVUnRPP1qHKR4aT/Ma1y1VGE9C?=
 =?us-ascii?Q?K6OHkr+A0zB5UDy7zCpd0h5wOAiwTGtKuI+GA3YZqpZKibfDMJyhwvuxy+Xu?=
 =?us-ascii?Q?Vlv5PbZCxcnywYvfz0Pp/szucqAkou0O/pOHsa1oQoXSxZVoXE1Q0ZpJypuz?=
 =?us-ascii?Q?dTPaIxzjSFT6mru+Fz0afEKs1hPMvSXeV9f1X1Zeob8+25EaVR3pOjc4c9gn?=
 =?us-ascii?Q?RjBFOM10ymTm8yCQcv912ik1St6oXzM/IIhLRUtfGnMuqhkaky9Sq0TapeKg?=
 =?us-ascii?Q?ONhu88ren6DTIj5EWhcFg7HAqyKXX3fcT9lqzQsHVUyA6ymjF6fwoz/5ubX1?=
 =?us-ascii?Q?aMwwH73pcYIY0tHz35ydXCH76p2DFii6NzZlBO1vKRXhlNyMde9UUmmlxBLS?=
 =?us-ascii?Q?voAhDB1d3AdfoNeeknGR6WMZiqJfK75Sa8fLbjM1ZHsHVie8mbi4NVHuDQU/?=
 =?us-ascii?Q?i7op4TAY/sOZs8hy+BFpAyTEyYWjrlcHQ/xYymK8mFL9q4PF7H+ZpA4NI9Nw?=
 =?us-ascii?Q?Y3lHiSphRYcj9asU0CxZZMYNzcBGYbbiC3SLNWdorJst5fyueiWAUj6Xpa+U?=
 =?us-ascii?Q?HBmY+V0fSwVRk+NaUGBcTopsuN74E1gvg8AZ9xj6FJFUWU7ylz2wlZh+dEwI?=
 =?us-ascii?Q?GMH9pWgbBsUOhVZneKmuTIBHGjlaFG0DKw6cqnyfP/RKrm8my4Er0BM1ir3+?=
 =?us-ascii?Q?O2TDFiQXDKjVAJw4uBlTxhGXwChYtASoKg01A9D5cDkgGDYTTPzofaBug9SA?=
 =?us-ascii?Q?6SpWN7XbbuzbSkxb0904pzk4w0pkTPfUjnj2s9GizkWyD+AA?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5997.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc12c1cd-613c-48bb-e85f-08de5a4a705a
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2026 06:41:29.2021 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0EN1ZqS7OAbSUEAKERt3JD1b1+Lz/fVs3Zp3k2DaOFPCAXaORvZT4ifGP4aO6rlP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5714
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

Please split the patch into two parts, one for vf mode reset support and th=
e other for modifying msg to debug port.

With that fixed, the series is

Reviewed-by: Yang Wang <kevinyang.wang@amd.com>

Best Regards,
Kevin

-----Original Message-----
From: Kenneth Feng <kenneth.feng@amd.com>
Sent: Friday, January 23, 2026 13:57
To: amd-gfx@lists.freedesktop.org
Cc: Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; Deucher, Alexander <Alexand=
er.Deucher@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>
Subject: [PATCH 1/2] drm/amd/pm: use debug port for mode1 reset request on =
smu 13&14

use debug port for mode1 reset request so fw can handle mode1 reset even wh=
en it is stuck.

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  | 14 ++-----------  .../drm/=
amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  |  6 ++++++  .../drm/amd/pm/swsmu/smu=
13/smu_v13_0_7_ppt.c  | 21 ++++++++++++++++++-  .../drm/amd/pm/swsmu/smu14/=
smu_v14_0_2_ppt.c  |  6 +++++-
 4 files changed, 33 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index ce52b616b935..d216db3b804b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -2617,21 +2617,11 @@ static int smu_v13_0_0_set_power_profile_mode(struc=
t smu_context *smu,  static bool smu_v13_0_0_is_mode1_reset_supported(struc=
t smu_context *smu)  {
        struct amdgpu_device *adev =3D smu->adev;
-       u32 smu_version;
-       int ret;

        /* SRIOV does not support SMU mode1 reset */
        if (amdgpu_sriov_vf(adev))
                return false;

-       /* PMFW support is available since 78.41 */
-       ret =3D smu_cmn_get_smc_version(smu, NULL, &smu_version);
-       if (ret)
-               return false;
-
-       if (smu_version < 0x004e2900)
-               return false;
-
        return true;
 }

@@ -2830,8 +2820,8 @@ static int smu_v13_0_0_mode1_reset(struct smu_context=
 *smu)
                /* SMU 13_0_0 PMFW supports RAS fatal error reset from 78.7=
7 */
                smu_v13_0_0_set_mode1_reset_param(smu, 0x004e4d00, &param);

-               ret =3D smu_cmn_send_smc_msg_with_param(smu,
-                                               SMU_MSG_Mode1Reset, param, =
NULL);
+               ret =3D smu_cmn_send_debug_smc_msg_with_param(smu,
+                                               DEBUGSMC_MSG_Mode1Reset, pa=
ram);
                break;

        case IP_VERSION(13, 0, 10):
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 1e82c43c851a..b8e202d702d3 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -3055,6 +3055,12 @@ static int smu_v13_0_6_link_reset(struct smu_context=
 *smu)

 static bool smu_v13_0_6_is_mode1_reset_supported(struct smu_context *smu) =
 {
+       struct amdgpu_device *adev =3D smu->adev;
+
+       /* SRIOV does not support SMU mode1 reset */
+       if (amdgpu_sriov_vf(adev))
+               return false;
+
        return true;
 }

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index 0375e8484b2a..882316c15602 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -72,6 +72,8 @@

 #define MP0_MP1_DATA_REGION_SIZE_COMBOPPTABLE  0x4000

+#define DEBUGSMC_MSG_Mode1Reset        2
+
 #define PP_OD_FEATURE_GFXCLK_FMIN                      0
 #define PP_OD_FEATURE_GFXCLK_FMAX                      1
 #define PP_OD_FEATURE_UCLK_FMIN                                2
@@ -2735,6 +2737,23 @@ static int smu_v13_0_7_update_pcie_parameters(struct=
 smu_context *smu,
        return ret;
 }

+static int smu_v13_0_7_mode1_reset(struct smu_context *smu) {
+       int ret;
+
+       ret =3D smu_cmn_send_debug_smc_msg(smu, DEBUGSMC_MSG_Mode1Reset);
+
+       if (!ret) {
+               /* disable mmio access while doing mode 1 reset*/
+               smu->adev->no_hw_access =3D true;
+               /* ensure no_hw_access is globally visible before any MMIO =
*/
+               smp_mb();
+               msleep(SMU13_MODE1_RESET_WAIT_TIME_IN_MS);
+       }
+
+       return ret;
+}
+
 static const struct pptable_funcs smu_v13_0_7_ppt_funcs =3D {
        .get_allowed_feature_mask =3D smu_v13_0_7_get_allowed_feature_mask,
        .set_default_dpm_table =3D smu_v13_0_7_set_default_dpm_table,
@@ -2796,7 +2815,7 @@ static const struct pptable_funcs smu_v13_0_7_ppt_fun=
cs =3D {
        .baco_enter =3D smu_v13_0_baco_enter,
        .baco_exit =3D smu_v13_0_baco_exit,
        .mode1_reset_is_support =3D smu_v13_0_7_is_mode1_reset_supported,
-       .mode1_reset =3D smu_v13_0_mode1_reset,
+       .mode1_reset =3D smu_v13_0_7_mode1_reset,
        .set_mp1_state =3D smu_v13_0_7_set_mp1_state,
        .set_df_cstate =3D smu_v13_0_7_set_df_cstate,
        .gpo_control =3D smu_v13_0_gpo_control,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers=
/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
index faae1da81bd4..81635050b455 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
@@ -1899,7 +1899,11 @@ static int smu_v14_0_2_baco_exit(struct smu_context =
*smu)

 static bool smu_v14_0_2_is_mode1_reset_supported(struct smu_context *smu) =
 {
-       // TODO
+       struct amdgpu_device *adev =3D smu->adev;
+
+       /* SRIOV does not support SMU mode1 reset */
+       if (amdgpu_sriov_vf(adev))
+               return false;

        return true;
 }
--
2.34.1

