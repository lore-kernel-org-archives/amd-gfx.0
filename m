Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A8DDCDB46B
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jun 2026 08:42:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1FB310E2CF;
	Mon, 22 Jun 2026 08:42:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bVQ2GB+I";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012060.outbound.protection.outlook.com [52.101.53.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D53110E2CF
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jun 2026 08:42:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TjfbpVuoQbZ+vSUCeuJQ5D5szvkgUZ5shuIG6vE9Ma8DP0K+IIAOwgt+QOSG/DS572c4F80htoPHnBdHhFQ5Kuq16Zu+K5Ltc2nyEpg2RW3IAy6bIYvF0cakmN5B4r23OAUHDd15/gkj2wU1GMq0ZACf+iQHv7/Kcz+HcnlMbDq/+IHC+lLGTDlYwnTIq1zl73QOmzpnpTR/+9SFw91mkXGPp1iM3OT8GaXn3M9m+iIOs//99oxrgBJgEo2T5tUbHF+hNxT+fTXwGKoy6XckcIbuqW69kB1keCup7oJSmx2Pf0iXICzbCFoLzXDQZ/cyvcUAlSqrDxAmeaiBGa1ZbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=648YKcO2z3ld8gRNmwHWI6Ke3M/xseluunmS8Wfe7ZA=;
 b=brNUbOQAFzaoPoDIm+RIwJyaB4a3aI2mVV8DpAfsYsAuQHiYGXHzTOmv5306//yzv4V4EP+rY13+5y7U6n0aN5di074IEG2lT8NWGu6LhAzOzYlV3SDgsaMIzQqCzyQWC1ZmurRZwR4MhYZeaxseKjXAeuBJGBxB7l/MzuPMLvOXgI2u4lH0ABMzG7g6dNLTlsUHWBofG+pwn7l0te/QQm/TrnE26GiM16bhYBZpNIfFGFvAPwu08o79ddLdbRlI8RE0V7OQFT8uzJ7CVn3/VAP+fZyglhlXxts3FALQPUo8U/LZPnQoX5hmBBDnjxMQFIk6WHYQvBqGHQIXvhXYJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=648YKcO2z3ld8gRNmwHWI6Ke3M/xseluunmS8Wfe7ZA=;
 b=bVQ2GB+Ie1RsUtFhU1ntAK5664wImo5XXBCs6EC1qTQjUKjB7NsqeSl7qZ1vnaIqggQ1KgYRv89tKny9MTCFP+NRgwm1gjTV5Uvjf5p1TxaxANCWgbbOIT2/ebAyOO/a+s3x1DU016Nw5rFZ2yowuNTEQVW7FlfN2bgbnbVazds=
Received: from SJ0PR12MB6967.namprd12.prod.outlook.com (2603:10b6:a03:44b::6)
 by SJ0PR12MB6687.namprd12.prod.outlook.com (2603:10b6:a03:47a::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Mon, 22 Jun
 2026 08:42:30 +0000
Received: from SJ0PR12MB6967.namprd12.prod.outlook.com
 ([fe80::9e49:aeba:9265:f46e]) by SJ0PR12MB6967.namprd12.prod.outlook.com
 ([fe80::9e49:aeba:9265:f46e%3]) with mapi id 15.21.0139.018; Mon, 22 Jun 2026
 08:42:29 +0000
From: "Sun, Ce(Overlord)" <Ce.Sun@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Chai, Thomas"
 <YiPeng.Chai@amd.com>, "Zhou1, Tao" <Tao.Zhou1@amd.com>
Subject: Re: [PATCH v1 48/48] drm/amd/pm: retire legacy MCMP1_* macros
Thread-Topic: [PATCH v1 48/48] drm/amd/pm: retire legacy MCMP1_* macros
Thread-Index: AQHdAgGzQRV0hYkt5k6I6fzisIXWdbZKQN3Z
Date: Mon, 22 Jun 2026 08:42:29 +0000
Message-ID: <SJ0PR12MB69678D5BFD92680160C0B3B69DEF2@SJ0PR12MB6967.namprd12.prod.outlook.com>
References: <cover.1782103073.git.cesun102@amd.com>
 <13e43cf250ef3d8895f39fc09f0393cc14dd445a.1782103074.git.cesun102@amd.com>
In-Reply-To: <13e43cf250ef3d8895f39fc09f0393cc14dd445a.1782103074.git.cesun102@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-06-22T08:42:29.121Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=1;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR12MB6967:EE_|SJ0PR12MB6687:EE_
x-ms-office365-filtering-correlation-id: 482b7aa2-8e86-4bcc-e639-08ded03a31f9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|38070700021|8096899003|18002099003|22082099003|11063799006|4143699003|56012099006;
x-microsoft-antispam-message-info: j5Ht57LOV5bWHhvN7j773yTjoB/re4C95g5KI5JLiyYoRPm+N85IUXLl05C9idyQxoXmmPFRcKCxdNAUAcpr72Sy6Ns6JJ5p6TqSEURMFSaHLmS2oMUaewUsYh0G00Y+y6oJYNA9mVTF+QZRPTA9qf7FwOkUBIOXhUAg6ptLVq67CCqcyiHwDsut1kPCrxeS9xz7Lfz6XrsddyFzm+vxiC4SapWAWmOCfPR6Q7gC6nPmMcc/r+7uEe6zyuMKTrbwpAKcmZKpecdRe96Q0jVoO1Mzlhl3x/RlYNwmyjaEOYxlDp6vI0K4orkckKmfFZ16OkERkmL/ONg3ig7Fvpagm4CFccnSyMMzPzPCNhrnlTEQnTR9R/aRUvNjbPkB8TkQ68qdWDKInD+xi0vNsOQoG9yiKV/U8mpec+I/fD8T1Xb6FPo1pzCt4zPZxiTon5r0tSu5pjNcoZKjrX65MKbSpvMAOhcBB6d7u/JGeD8QUfNbP0NNuJGS8XGure14zTRc4d8cbD3TKjNwYSo0iKGXeZ6nRqjW3TBEtzpf0QcEMOLjPgkeRvg6sKpiD0r3eChapCA/LByok0MUouUhLSNGK7hnQCpxWctMcQDXyjGBcOJUG2HO1Bb4OjPc6uCQChqXm4fctKLTWD7GD9K0nymGuBe9NUJFIi6EaFC9TmvpJBugzXRA77ejR9dn/peCnxA855ejR1ZjeKt1EP3O+saU9WIewIfNnoaaZFMeUXWektc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB6967.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(38070700021)(8096899003)(18002099003)(22082099003)(11063799006)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5owtia/CkvJy4HRD3RcbMNmgiqIu4HbV/VsyoUWejMY8vbTAtCCXbkSG/muM?=
 =?us-ascii?Q?6oEaMBHW0McwCzQrvuVNL052rblbDpcsPXgLIRt+T4XI5TxqMQpBu0uU3OR1?=
 =?us-ascii?Q?2EptjcAiXQ1tt1D9x4z2Rqc7TQTbbkTur+C25lLuks+JgHGkhGm8E7dliNWN?=
 =?us-ascii?Q?G9CSvbplHf+Vwiwub0wUQEi8hDHB0sKMFwHIRiKeTW7T7C/xQrMZZfq0pjNX?=
 =?us-ascii?Q?67QNIdYtFOKccjvclQ4mhkzKWACM+2NO8kDmqqhmAHTecwDx7DtFWSMxuBWI?=
 =?us-ascii?Q?2WL34Z8oyGyQcgZRRNuSTEsc+D6e5pox+RZIy/czc/kZl1qYaqGY8tBkHIUN?=
 =?us-ascii?Q?EvwCkV5cz4na90QPToNYgkpC6K3V5S7I9/bq2S5RLs+xKGfPQSDECKD3yQDr?=
 =?us-ascii?Q?CtmWwetWFN4oaF3tNhI3A1fLDehGjLAJ7J4MBF0Zh/4P4VUPK0TN+Nbt4TJZ?=
 =?us-ascii?Q?EyU3wUswz5vAU0+yWuCBP5Q1VT6FKju6GlD69BVnYGJvObarjoaxSRurRIl+?=
 =?us-ascii?Q?0cJehF9YM2YzzJ0pKPHjIRJNUCycx2WEb4LosKGFQzqSbz+ZCZTXId7JoCBl?=
 =?us-ascii?Q?8zka5soXA0lGPtrwmLSYpPKZ28yVJspR8U1TIr26lhPfgSpcuRG/5eQp6HCy?=
 =?us-ascii?Q?GJJGrkZDYaCx7ZkqKDRwsFl33cgjeeHI5UUDrIrnRT7aE7iQWBcjeus8M8+x?=
 =?us-ascii?Q?JgEA7aZ8zkykjfBTd81heKzrhkn0wwIqIGAfAUGKsBnHkbW4GhSyDj6KJnUm?=
 =?us-ascii?Q?HNtnubPX4fSjtWxNPITYjmwLjs1XhfhcGgZBx31J0zTfxQcMB568PtX5jlJ5?=
 =?us-ascii?Q?8vK1RjAI3x5pCPOc6ZKZPlj5Zkko98QYDLNNE6OuL6aroe1IMQ7JMvUsgiPA?=
 =?us-ascii?Q?pUZF1a3aaTF6qTlhR7GCon8Uy82cbqlSFvggR2A467scTvZejoXWHpBElXxq?=
 =?us-ascii?Q?dj+71o7Dflv29TK2Jd0bu+aLC1yvuvFHFHBnx+mQ68RL9LFa8X6kkKK3TF+g?=
 =?us-ascii?Q?d0qmjdUCj9nJYLmCqyErL2s30VP2pKb44XIwBv2mfUAwwm/Ril03Uy/ronB7?=
 =?us-ascii?Q?//Z8OflkJnEeDghtMgASt2hMWjc8i8h0tyYfhKxTBKMjW2NzapewantWSOcO?=
 =?us-ascii?Q?XWiU/3laDbscWHxwqzckZ1oWRrINMXkxMUL952nauKHphlcR82lqZ02/c5hs?=
 =?us-ascii?Q?JjvMl81zdy+Hlp5797A8euwxlNZtM9SKhpKTvM8+efgGgL1fGwrb3qduvA8m?=
 =?us-ascii?Q?xVwSK6kQJtgEbie9FVWBPdCy6Dq1em6KHt5EmPRm9eOdLB0836/hNQe9hWdc?=
 =?us-ascii?Q?EtvGkVVSg6lMxm0n7l9dzKVIOmXZg8jCP7On5jLlz3b+nRbN7C+4+UZj4Jxn?=
 =?us-ascii?Q?UaGXh3SCQj8OXGIWdWHVlCCu173ZES6iNi5De9XI1h6h1ha9ZZl/lwlu6Wrm?=
 =?us-ascii?Q?ZtJbCSPybHIx0D/fTmD7LBjYU06zzFH7t1ktno9abxXiANbMd29ceBzbgJEQ?=
 =?us-ascii?Q?p+fn8oxcSWOtrumuEfXQLUM/XtRBI00BYxNKUWusUVitSiYqvKe2JSh6wfbg?=
 =?us-ascii?Q?LQpAwU/XF4kiABczqLX4AH7xAW4PguyI8LOTqeM1iPo1qkOz+VC0xDjyNQ3R?=
 =?us-ascii?Q?C4572aoqbnoMn1ttc5BKrg1+raep54WOcWGREwNRdGlCIjnS+7ok0FyDVqwz?=
 =?us-ascii?Q?ySo1nkh/nuR+jEY1ynyjfamkL3DsoCxC8QxXnXwMkenI9NW2?=
Content-Type: multipart/alternative;
 boundary="_000_SJ0PR12MB69678D5BFD92680160C0B3B69DEF2SJ0PR12MB6967namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB6967.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 482b7aa2-8e86-4bcc-e639-08ded03a31f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2026 08:42:29.7394 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h28vzsclMNgkxLV5VoZdwpO7HuEVSduWUPf4WDfjh4gIyfderC+2i0D4C2ltZZQ6FfTIw+RKmFsj+VO5x3CuQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6687
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

--_000_SJ0PR12MB69678D5BFD92680160C0B3B69DEF2SJ0PR12MB6967namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

AMD General

Hi all,

Sorry that there are issues in this patch-12 set. Please ignore this v1 sub=
mission. I will fix the problem and resend the updated v2 patches shortly.


Regards,
Sun,Ce
________________________________
From: Sun, Ce(Overlord) <Ce.Sun@amd.com>
Sent: Monday, June 22, 2026 12:40 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Chai, Thomas <YiPeng.Chai@amd.c=
om>; Zhou1, Tao <Tao.Zhou1@amd.com>; Sun, Ce(Overlord) <Ce.Sun@amd.com>
Subject: [PATCH v1 48/48] drm/amd/pm: retire legacy MCMP1_* macros

Remove legacy MCMP1_* macros

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 .../include/asic_reg/mp/mp_13_0_6_sh_mask.h   | 29 -------------------
 1 file changed, 29 deletions(-)

diff --git a/drivers/gpu/drm/amd/include/asic_reg/mp/mp_13_0_6_sh_mask.h b/=
drivers/gpu/drm/amd/include/asic_reg/mp/mp_13_0_6_sh_mask.h
index 2684e396f548..9d237924a59c 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/mp/mp_13_0_6_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/mp/mp_13_0_6_sh_mask.h
@@ -670,33 +670,4 @@
 #define MP1_FIRMWARE_FLAGS__INTERRUPTS_ENABLED_MASK                       =
                                    0x00000001L
 #define MP1_FIRMWARE_FLAGS__RESERVED_MASK                                 =
                                    0xFFFFFFFEL

-//MCMP1_IPIDT0
-#define MCMP1_IPIDT0__InstanceIdLo__SHIFT                                 =
                                    0x0
-#define MCMP1_IPIDT0__HardwareID__SHIFT                                   =
                                    0x20
-#define MCMP1_IPIDT0__InstanceIdHi__SHIFT                                 =
                                    0x2c
-#define MCMP1_IPIDT0__McaType__SHIFT                                      =
                                    0x30
-
-#define MCMP1_IPIDT0__InstanceIdLo_MASK                                   =
                                    0x00000000FFFFFFFFL
-#define MCMP1_IPIDT0__HardwareID_MASK                                     =
                                    0x00000FFF00000000L
-#define MCMP1_IPIDT0__InstanceIdHi_MASK                                   =
                                    0x0000F00000000000L
-#define MCMP1_IPIDT0__McaType_MASK                                        =
                                    0xFFFF000000000000L
-
-//MCMP1_STATUST0
-#define MCMP1_STATUST0__ErrorCode__SHIFT                                  =
                                    0x0
-#define MCMP1_STATUST0__ErrorCodeExt__SHIFT                               =
                                    0x10
-#define MCMP1_STATUST0__PCC__SHIFT                                        =
                                    0x39
-#define MCMP1_STATUST0__UC__SHIFT                                         =
                                    0x3d
-#define MCMP1_STATUST0__Val__SHIFT                                        =
                                    0x3f
-
-#define MCMP1_STATUST0__ErrorCode_MASK                                    =
                                    0x000000000000FFFFL
-#define MCMP1_STATUST0__ErrorCodeExt_MASK                                 =
                                    0x00000000003F0000L
-#define MCMP1_STATUST0__PCC_MASK                                          =
                                    0x0200000000000000L
-#define MCMP1_STATUST0__UC_MASK                                           =
                                    0x2000000000000000L
-#define MCMP1_STATUST0__Val_MASK                                          =
                                    0x8000000000000000L
-
-//MCMP1_MISC0T0
-#define MCMP1_MISC0T0__ErrCnt__SHIFT                                      =
                                    0x20
-
-#define MCMP1_MISC0T0__ErrCnt_MASK                                        =
                                    0x00000FFF00000000L
-
 #endif
--
2.34.1


--_000_SJ0PR12MB69678D5BFD92680160C0B3B69DEF2SJ0PR12MB6967namp_
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
<div>
<div style=3D"font-family: Calibri; text-align: left; color: rgb(0, 0, 255)=
; margin-left: 5pt; font-size: 10pt;">
AMD General</div>
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Hi all, </div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Sorry that there are issues in this patch-12 set. Please ignore this v1 sub=
mission. I will fix the problem and resend the updated v2 patches shortly.
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Regards, </div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Sun,Ce</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Sun, Ce(Overlord) &lt=
;Ce.Sun@amd.com&gt;<br>
<b>Sent:</b> Monday, June 22, 2026 12:40 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Zhang, Hawking &lt;Hawking.Zhang@amd.com&gt;; Chai, Thomas &lt;Y=
iPeng.Chai@amd.com&gt;; Zhou1, Tao &lt;Tao.Zhou1@amd.com&gt;; Sun, Ce(Overl=
ord) &lt;Ce.Sun@amd.com&gt;<br>
<b>Subject:</b> [PATCH v1 48/48] drm/amd/pm: retire legacy MCMP1_* macros</=
font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Remove legacy MCMP1_* macros<br>
<br>
Signed-off-by: Ce Sun &lt;cesun102@amd.com&gt;<br>
---<br>
&nbsp;.../include/asic_reg/mp/mp_13_0_6_sh_mask.h&nbsp;&nbsp; | 29 --------=
-----------<br>
&nbsp;1 file changed, 29 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/include/asic_reg/mp/mp_13_0_6_sh_mask.h b/=
drivers/gpu/drm/amd/include/asic_reg/mp/mp_13_0_6_sh_mask.h<br>
index 2684e396f548..9d237924a59c 100644<br>
--- a/drivers/gpu/drm/amd/include/asic_reg/mp/mp_13_0_6_sh_mask.h<br>
+++ b/drivers/gpu/drm/amd/include/asic_reg/mp/mp_13_0_6_sh_mask.h<br>
@@ -670,33 +670,4 @@<br>
&nbsp;#define MP1_FIRMWARE_FLAGS__INTERRUPTS_ENABLED_MASK&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00000001L<br>
&nbsp;#define MP1_FIRMWARE_FLAGS__RESERVED_MASK&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; 0xFFFFFFFEL<br>
&nbsp;<br>
-//MCMP1_IPIDT0<br>
-#define MCMP1_IPIDT0__InstanceIdLo__SHIFT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 0x0<br>
-#define MCMP1_IPIDT0__HardwareID__SHIFT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; 0x20<br>
-#define MCMP1_IPIDT0__InstanceIdHi__SHIFT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 0x2c<br>
-#define MCMP1_IPIDT0__McaType__SHIFT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; 0x30<br>
-<br>
-#define MCMP1_IPIDT0__InstanceIdLo_MASK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; 0x00000000FFFFFFFFL<br>
-#define MCMP1_IPIDT0__HardwareID_MASK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; 0x00000FFF00000000L<br>
-#define MCMP1_IPIDT0__InstanceIdHi_MASK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp; 0x0000F00000000000L<br>
-#define MCMP1_IPIDT0__McaType_MASK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0xFFFF000000000000L<br>
-<br>
-//MCMP1_STATUST0<br>
-#define MCMP1_STATUST0__ErrorCode__SHIFT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; 0x0<br>
-#define MCMP1_STATUST0__ErrorCodeExt__SHIFT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x10<br>
-#define MCMP1_STATUST0__PCC__SHIFT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x39<br>
-#define MCMP1_STATUST0__UC__SHIFT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x3d<br>
-#define MCMP1_STATUST0__Val__SHIFT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x3f<br>
-<br>
-#define MCMP1_STATUST0__ErrorCode_MASK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; 0x000000000000FFFFL<br>
-#define MCMP1_STATUST0__ErrorCodeExt_MASK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 0x00000000003F0000L<br>
-#define MCMP1_STATUST0__PCC_MASK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x0200000000000000L<br>
-#define MCMP1_STATUST0__UC_MASK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x2000000000000000L<br>
-#define MCMP1_STATUST0__Val_MASK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x8000000000000000L<br>
-<br>
-//MCMP1_MISC0T0<br>
-#define MCMP1_MISC0T0__ErrCnt__SHIFT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp; 0x20<br>
-<br>
-#define MCMP1_MISC0T0__ErrCnt_MASK&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 0x00000FFF00000000L<br>
-<br>
&nbsp;#endif<br>
-- <br>
2.34.1<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_SJ0PR12MB69678D5BFD92680160C0B3B69DEF2SJ0PR12MB6967namp_--
