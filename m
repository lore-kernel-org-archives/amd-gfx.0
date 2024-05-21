Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CEDBC25B7C
	for <amd-gfx@archiver.kernel.org>; Tue, 21 May 2024 14:41:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC0D510ECA6;
	Tue, 21 May 2024 14:41:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="17LilefB";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2084.outbound.protection.outlook.com [40.107.94.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1C1D10EC96
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 May 2024 14:41:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y9LuOhasQqzdKrmr7/P171p5OOc01Amb9EZDHt2Oq/nMN3oCjwSx77rUs3ycrK4WL/VYBewbXS3Z69bvnJiCunT3JKYXvG12cRzhu05AkBTc84To/1y9yJA+7ANz+9mHiEPQi2Oa7j0ehZRJc/u32hdCiyqp5sZVfWIyAwKkVUyV71piio5CccpPRVpOhMXnaL5SQPoyj95bOFidQDJq67VvpZBq2D5LAKkoNY1NK7VlAUtuhncppvMT1WEUKDYDxp414sOp2Ky07JCyOCMJPeXitFblmAHzOqy4rsOmmf1Uje+V+h3JsLE+zPjdZCNyqj5s6X8h5JTzHjSr0JyKHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UzqemZy20FD5wJGeUwA+j7AzyL6mYgOU8ApMJflyzrQ=;
 b=PHQLhHnlEgLTMuF/Ro9q3xZ39wUUh4zPV5Y9X2jNtVvysmoXe2f869JoxnaotSjNPGPhOzv+ST2GdGBEAfBDfHc0Bd0OxDvf1g7hqyQ7Ryg/XQbxL+nxisS2LyYFN/2oCeGd7z2RNGOkC1bRYf/5CKcqMDqVvNq1sMtveKA0ibSdP/9tch7r6PDQRJ9uMge7tEptRdIfoZKOmQcAOKj7RhMwxxLwO9tH6/V/tLOpJTnFG6ShWr7Ju29LxD/GVGJN1V/YUPxOIsoV4yNych/H8Y37foMJiK5YPYqfISj9eM4+vo/9TRamPuhFqMYRFII1X008o6fP9LGy6KeiSDudzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UzqemZy20FD5wJGeUwA+j7AzyL6mYgOU8ApMJflyzrQ=;
 b=17LilefB31RnXb2GXRMkRB6H4q3P5CY9ETJTHBqmDBCvxGC2gd0PfbXPBoJBFWRC6uAIYWVglxR6JzWy4F6KentMkMkmvy5h4eI1hK03T/RnyoO31RvE5kfJNEHe8pyqbmDbnE4CPliZYs1R1bRuOHvnlaWQhFY/ducfcGc7CVU=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by CH0PR12MB8505.namprd12.prod.outlook.com (2603:10b6:610:193::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Tue, 21 May
 2024 14:41:40 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42%7]) with mapi id 15.20.7587.035; Tue, 21 May 2024
 14:41:40 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Koenig, Christian" <Christian.Koenig@amd.com>, "Huang, Tim"
 <Tim.Huang@amd.com>
Subject: Re: [PATCH 2/4 V2] drm/amd/pm: fix unsigned value asic_type compared
 against
Thread-Topic: [PATCH 2/4 V2] drm/amd/pm: fix unsigned value asic_type compared
 against
Thread-Index: AQHaq07c7O8UaKFc4Ey/L2ke2UoewLGhwydX
Date: Tue, 21 May 2024 14:41:40 +0000
Message-ID: <BL1PR12MB514403D43F0B109825E335D2F7EA2@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20240521071644.371330-1-jesse.zhang@amd.com>
In-Reply-To: <20240521071644.371330-1-jesse.zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-05-21T14:41:39.778Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|CH0PR12MB8505:EE_
x-ms-office365-filtering-correlation-id: bcfd803d-70d8-408a-c35e-08dc79a42030
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|1800799015|366007|376005|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?RYusebzhkVEOB3qpqI4oZYwBO+87iFEnoEj5CK/bf0n93dW5FkHpZ1edxXnx?=
 =?us-ascii?Q?j2vMn/OXXlbq6JPHWbw/K2O2ZMzXdOQde8FFl9xl7JPusBDoKftdzb30tNRL?=
 =?us-ascii?Q?ZQWJL5ogWgwIurRd7IDqSRgk4Tm81JH1rvL30es1mP4IWOqI0EB+CCXhoy7I?=
 =?us-ascii?Q?fjaKxHiUKTczGtbhuHDnsIhQnv7pNkcwVQlr9IxnK6l8CuRcXQxl41+tQS4f?=
 =?us-ascii?Q?USAVPOEcEKUNEEkgk8QnIDEH1NxuVs9ni4qlKSQMF+0hrxl07o9M9TytbVJ/?=
 =?us-ascii?Q?Cr/rXdZxPk0NexBur47Z57u35NXiBwi6Clt9vplFkvzaZOXV+ll7V8YP4+mO?=
 =?us-ascii?Q?WtyDVHeAZND60CLk/44pBm78VUmxPflK11Edb5GFv5dTSQ+mh6vrUZB7W2Du?=
 =?us-ascii?Q?zu5XTHiH2Ij58nndk/A0+g/cjwfkoRXoCrYA9UmzcldIMl67fKxwKuLm0g/g?=
 =?us-ascii?Q?A5mnv6VjHwcniPPyCKejaQbJXHqClcpbo1g/J8ia0IjdJ/PLuJSjx8xdXKtc?=
 =?us-ascii?Q?z9tOncF5DsxT3/B8QrdfGidAI8bk8O6AosrVmdmy7OKWl1GXH7fpKdadPITF?=
 =?us-ascii?Q?lE8KSoFwXlMiYXw0sCHA4LcJvgILT5kpkLMlqrrrp6pRAVxJBdydNJ4/0M1f?=
 =?us-ascii?Q?2thovuyxFwk1EYBlj9a7fIM82YPbZOzBTVT5Hr5w6cds7r5VDd+4Um2GiK26?=
 =?us-ascii?Q?uEL6PTPPjhDW8woI1ot3JVgDQFwwAf+IxmKTUIdHiNMc7A7hCnzNyxV4J1zz?=
 =?us-ascii?Q?CNLL87Ttj7KJDJGFRjEm/d3GvZpfjdJsyXJSgqDHo9qlQnYmGpYuyD+/ZJFZ?=
 =?us-ascii?Q?QOySJo7vWw4oXWfRfBf93fwUcdx48Lg6lZEJNNiDJxgX4aPGmIED9hTC58P/?=
 =?us-ascii?Q?OjGXfUU5BvVdRrv+IRy6fn8x5Fp8124lMj64nR/Vnn9hVdegNUfMCL5mk/wn?=
 =?us-ascii?Q?Zj7uPlHbfqsh1fSsBxAOHiONRQnlh6YdjaeYM+5Zs3tcr5eidUx5ThvUQ6OL?=
 =?us-ascii?Q?n1/7ELy7ZFFSIomjt0h7ZIlkWk4vOwy5+e05pWRXIAZMyCAKBYa/IAZ4IbJy?=
 =?us-ascii?Q?tJjUtfPKJxzIV32aEJAIcb1ZRYYVgdQX+j2h9VbBFtxAowlzzeMbjFci8XKt?=
 =?us-ascii?Q?70HtqYaj4SbZJAN/RIPGaZ3yCbZiHb2BiaVq2hU3zBHBr6jP9lqZaQ+aJ1Vj?=
 =?us-ascii?Q?ucjNnO3MbxxkbXkKYzIFHqLXspszj1OgzF+LTIFsoSDd/bLp8+Dih00z4lf2?=
 =?us-ascii?Q?l9dbKwXHigCUTqXP1jvgmqAz0mzOK7zHcZeQNIBP/qlRnX1bUsWezbjC1zN2?=
 =?us-ascii?Q?bZV9G8FVdz3Ixk6QzmbT8v4q?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kXyzH4DKBm+irNZhhXH/VhJQ/21TJoU75lvMhTB2z/CLkOUACHhmCMeAk9B+?=
 =?us-ascii?Q?0lo2ePGyzWe5yMrZlBqbsEwrjoYGbGq5eNkjsSZIi5plg60KpNoKuBQ3rIeq?=
 =?us-ascii?Q?oXwiaJhGW42UL4FSxBtqp/EHSlGzkVU35V98o17n8pkYaxRsXyeRUvSdOw/8?=
 =?us-ascii?Q?HDWjyJLGs+oqKfLde36ONZr5RP2GBF3NM7zIS6ObLmrOT5TzfZM9lgV/wvap?=
 =?us-ascii?Q?XdMS/ukG9Cv4y2gFAlTzkzeJ9aPRvEJ8wd0bdciZtpJXtlymLwZG8L7ZN1Rb?=
 =?us-ascii?Q?FcDF1yLFO+Utx+hAn80vZ7TxMKDxuEC31QzHgW3nBi7uzPV2MV5Wph1qiGyd?=
 =?us-ascii?Q?1MZG6thJMj5E3UKbUDVf0h6+mIgcMrlwZILuLCHuLJ7xS409Lf172o/JB9jj?=
 =?us-ascii?Q?cocf4SXKrP7guOcl4FHdYz4K8eBk/fc1rbBsdaSmoPJ8CpjWy1Z4sb1cvCpx?=
 =?us-ascii?Q?3uZ0JwM6E7wEx8XyBgByc81KlfKSGSipWj4i5Eq9eyolkZnKEAsLbWqFmflO?=
 =?us-ascii?Q?sE4TAupjPtXKbdVmjpv/F+TyjfmUJ3Ebb2Z1eT6vRRUbNALBB3ryxVwvjRGn?=
 =?us-ascii?Q?/pBhet8/chIPtLHaJ+xMCXKyZB6yZtVkrn4soF380xtJLyA8uphn4Lgrxoh/?=
 =?us-ascii?Q?yBRXmvpZyeYPbrLVKDtIBAh6vC3M2z7h+mzzDrB2p42d+RX29dgf3XfPhXPs?=
 =?us-ascii?Q?LbF1E7ulH2nyTf2aP2NsZr9nKLU6sPaODCDAooSTAmTjMSsFe6/CAoX1Aid2?=
 =?us-ascii?Q?M6ZsQRsGpGD9LC0cOlrbW7GpiY72B/JDL6PHFH54M1GAmBRpAkmnQT6mjgNZ?=
 =?us-ascii?Q?HCtvB2dwUBTUU5oMb3dCi3+bJobR0gzX30yDjOyHTIc2VReLl/Dj9ZCrWJWs?=
 =?us-ascii?Q?WNKw0e8V/kLXk7xSzPPVPXxff1/VFsQQz6xQ3p0a4WE3GoZPyuRWNDAYGuJV?=
 =?us-ascii?Q?tNwR+651jR0x29nVMlVWGnAWfCZTLhZpSE0vAZxlDHEUxsIVP3m0cnaBFk9j?=
 =?us-ascii?Q?rXeMrPoWQqsKEOBYTVA/XjYeSi/wPS+mqZdQZ2P1t0aGcP/kCsuvkdh7fES0?=
 =?us-ascii?Q?2KGZAfTkAA5/yMpqEg7eQzhTb6psJCsP5qS79lvIs5pxj2RGG9NPEepE+PhO?=
 =?us-ascii?Q?CDe5KTvlQk8riqLNeZxXEllUMARJoV5iTzISREJCx0uHKiRco5ScYd3H139D?=
 =?us-ascii?Q?25+3thAHQhHjZARbQzfcafSQFmjRWdtuSypVgLOtyFxcsDB7PgbzJ4s3nQUb?=
 =?us-ascii?Q?ADDM6sulGUuCGRI4eGBKSQkCjqznuXgU+/l4K1rmEiieHtjM7ZnK0ZiUbN0l?=
 =?us-ascii?Q?woXtjG77xK8d9XFH3lQPzZAR6gR1pwrKXqFL+/stvQ4hpbKAR4decHMqAJDi?=
 =?us-ascii?Q?A9P8Bd7RZzf17HSFZhMGLXLZx2xaYcfXV5Cq0crUXrnRsTpZvqX+I4F3Jc6Q?=
 =?us-ascii?Q?Q0I200D0Z2P1W0hVoe+2HF5Z/OAlF3SzVj1L9VoJnnbRM0rrhevyIKLCPNLY?=
 =?us-ascii?Q?RuBLQnrFsB8cYsPPMnsWU+jcHzQtFUP+D3sm2TCvL5Wpmd6HVuf/W1JLPuSW?=
 =?us-ascii?Q?wu9EWBMOv2JgHIvg+Q0=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB514403D43F0B109825E335D2F7EA2BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcfd803d-70d8-408a-c35e-08dc79a42030
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2024 14:41:40.1099 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: os2hwV0ipMuE4FGfLm9je2v3irpE4XJUoIVCif85W2gRVLLEHfP2hLkIy6zRrm+NW1vfj7BmfkGuGElodjm6eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8505
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

--_000_BL1PR12MB514403D43F0B109825E335D2F7EA2BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Jesse Zhang <jesse.zhang@amd.com>
Sent: Tuesday, May 21, 2024 3:16 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Chri=
stian.Koenig@amd.com>; Huang, Tim <Tim.Huang@amd.com>; Zhang, Jesse(Jie) <J=
esse.Zhang@amd.com>; Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>
Subject: [PATCH 2/4 V2] drm/amd/pm: fix unsigned value asic_type compared a=
gainst

Enum asic_type always greater than or equal CHIP_TAHITI.

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
Suggested-by: Tim Huang <Tim.Huang@amd.com>
---
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c b/drivers/gpu/drm/a=
md/pm/legacy-dpm/si_dpm.c
index f245fc0bc6d3..68ac01a8bc3a 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
@@ -7928,12 +7928,8 @@ static void si_dpm_print_power_state(void *handle,
         DRM_INFO("\tuvd    vclk: %d dclk: %d\n", rps->vclk, rps->dclk);
         for (i =3D 0; i < ps->performance_level_count; i++) {
                 pl =3D &ps->performance_levels[i];
-               if (adev->asic_type >=3D CHIP_TAHITI)
-                       DRM_INFO("\t\tpower level %d    sclk: %u mclk: %u v=
ddc: %u vddci: %u pcie gen: %u\n",
-                                i, pl->sclk, pl->mclk, pl->vddc, pl->vddci=
, pl->pcie_gen + 1);
-               else
-                       DRM_INFO("\t\tpower level %d    sclk: %u mclk: %u v=
ddc: %u vddci: %u\n",
-                                i, pl->sclk, pl->mclk, pl->vddc, pl->vddci=
);
+               DRM_INFO("\t\tpower level %d    sclk: %u mclk: %u vddc: %u =
vddci: %u pcie gen: %u\n",
+                        i, pl->sclk, pl->mclk, pl->vddc, pl->vddci, pl->pc=
ie_gen + 1);
         }
         amdgpu_dpm_print_ps_status(adev, rps);
 }
--
2.25.1


--_000_BL1PR12MB514403D43F0B109825E335D2F7EA2BL1PR12MB5144namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - AMD Internal Distribution Only]<br>
</p>
<br>
<div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Jesse Zhang &lt;jesse=
.zhang@amd.com&gt;<br>
<b>Sent:</b> Tuesday, May 21, 2024 3:16 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Koenig, Ch=
ristian &lt;Christian.Koenig@amd.com&gt;; Huang, Tim &lt;Tim.Huang@amd.com&=
gt;; Zhang, Jesse(Jie) &lt;Jesse.Zhang@amd.com&gt;; Zhang, Jesse(Jie) &lt;J=
esse.Zhang@amd.com&gt;<br>
<b>Subject:</b> [PATCH 2/4 V2] drm/amd/pm: fix unsigned value asic_type com=
pared against</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Enum asic_type always greater than or equal CHIP_T=
AHITI.<br>
<br>
Signed-off-by: Jesse Zhang &lt;Jesse.Zhang@amd.com&gt;<br>
Suggested-by: Tim Huang &lt;Tim.Huang@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c | 8 ++------<br>
&nbsp;1 file changed, 2 insertions(+), 6 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c b/drivers/gpu/drm/a=
md/pm/legacy-dpm/si_dpm.c<br>
index f245fc0bc6d3..68ac01a8bc3a 100644<br>
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c<br>
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c<br>
@@ -7928,12 +7928,8 @@ static void si_dpm_print_power_state(void *handle,<b=
r>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_INFO(&quot;\tuvd&nbsp;=
&nbsp;&nbsp; vclk: %d dclk: %d\n&quot;, rps-&gt;vclk, rps-&gt;dclk);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; ps-&g=
t;performance_level_count; i++) {<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; pl =3D &amp;ps-&gt;performance_levels[i];<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; if (adev-&gt;asic_type &gt;=3D CHIP_TAHITI)<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_INFO(&quot;\=
t\tpower level %d&nbsp;&nbsp;&nbsp; sclk: %u mclk: %u vddc: %u vddci: %u pc=
ie gen: %u\n&quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i, pl-&gt;sclk, pl-&gt;mclk, pl-&gt;v=
ddc, pl-&gt;vddci, pl-&gt;pcie_gen + 1);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; else<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DRM_INFO(&quot;\=
t\tpower level %d&nbsp;&nbsp;&nbsp; sclk: %u mclk: %u vddc: %u vddci: %u\n&=
quot;,<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i, pl-&gt;sclk, pl-&gt;mclk, pl-&gt;v=
ddc, pl-&gt;vddci);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; DRM_INFO(&quot;\t\tpower level %d&nbsp;&nbsp;&nbsp; sclk: %u mcl=
k: %u vddc: %u vddci: %u pcie gen: %u\n&quot;,<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; i, pl-&gt;=
sclk, pl-&gt;mclk, pl-&gt;vddc, pl-&gt;vddci, pl-&gt;pcie_gen + 1);<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_dpm_print_ps_status=
(adev, rps);<br>
&nbsp;}<br>
-- <br>
2.25.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB514403D43F0B109825E335D2F7EA2BL1PR12MB5144namp_--
