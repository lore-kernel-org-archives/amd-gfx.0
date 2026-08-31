Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79BEAC61DE2
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2026 08:23:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3E0110E756;
	Mon, 31 Aug 2026 08:23:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="R6BzI0H4";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011017.outbound.protection.outlook.com [52.101.62.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ADA9A10E756
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 08:23:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i2LJwGAjX0+lg6r6RLkqqNqidU6mgHZKMysUIKyUnTAzIRvq3xopIVrYmZtqtCGusooE78e4/W3+BBMsQeRUF/h4vbuWJY+Q2H2IjvcP5T1hdFC1wwSgIaspXJ1jWMX2j0gPJCZ3MU1sqy1aYbVGFRn/m+G/wZujHO0Mw5uQ04OsvmfA1CbqUifaRwztLbYJ7HXa3EQy2Mb+vmlVpaxYy6epDnPaZ1Qre35CXY2XRymimnAvIXX3RQCzc1uKa6givZ1GVvD2OlMmrKCrDjBWUdc/3BsUM0hFTwOY47wgjcyKlj0w3KiPMFvHrCpjZibKiiR9Z5jxGy5Mk2w2Im1zRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Syaymb664UIEVTv7RwYRhXyVpeMNBu/DsL/NZmBUI1s=;
 b=nyrCqWyqvuUZqGNafm7TMJfRUHs/kIgj1OKjntwE94ktO6AdkeRJFddjlSx+TNUXf9bTsIB4M5zrdOTMnpMRqLCt59gX5oyO6C5b5CSgTR+1qyKp89gmnSV57ID16X1J1hAkvTniIo35VATrPmKdwl5VhIeII5olO2WV6mm/WneG1i2Xd4hwxHU0IhC8ss7XnPqtZd1FWMYemaQvJ1IohZeOiLPZNFiht1F/jJC3eI9p/JMME8rjHgofVERLhcjW+8816+N2MidahhVsgdSLgib2+kPDfftOo3kgVumLqlOwZx+Zd8FU8Ra/Qat/4P+bdrvGiRgtC+ZINu+bLG7C7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Syaymb664UIEVTv7RwYRhXyVpeMNBu/DsL/NZmBUI1s=;
 b=R6BzI0H46xkeXRsi8HqiDVB35tXR4uNU/em59h9Oofo1CRmLVus5l2FTvhv3nwxbeSG5dS88tqoNNiWy6G5muTqGIQZbXUN3W/xkdOqeFtum3QSxBkaIC+OYFI236BjJm0JwpeShdJARfVXso7/+KkdUI4yVSSqx4+f+a32L6lY=
Received: from BN9PR12MB5211.namprd12.prod.outlook.com (2603:10b6:408:11c::24)
 by PH7PR12MB7283.namprd12.prod.outlook.com (2603:10b6:510:20a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 08:23:54 +0000
Received: from BN9PR12MB5211.namprd12.prod.outlook.com
 ([fe80::1bae:ee6:d7f4:b85a]) by BN9PR12MB5211.namprd12.prod.outlook.com
 ([fe80::1bae:ee6:d7f4:b85a%5]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 08:23:54 +0000
From: "Wang, Kevin" <Kevin.Wang@amd.com>
To: "Feng, Kenneth" <Kenneth.Feng@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>
Subject: RE: [PATCH 0/7] drm/amd/pm: stage OD reset until commit
Thread-Topic: [PATCH 0/7] drm/amd/pm: stage OD reset until commit
Thread-Index: AQHdOQIsOtLaxb5uKU2B0jqBexC/y7a3zi2AgAADOnA=
Date: Mon, 31 Aug 2026 08:23:54 +0000
Message-ID: <BN9PR12MB52110799094CCF1F3233F03893A92@BN9PR12MB5211.namprd12.prod.outlook.com>
References: <20260831043507.523599-1-kevin.wang@amd.com>
 <MW4PR12MB680329990EAECAA7EF692FF78EA92@MW4PR12MB6803.namprd12.prod.outlook.com>
In-Reply-To: <MW4PR12MB680329990EAECAA7EF692FF78EA92@MW4PR12MB6803.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-08-31T08:08:12.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5211:EE_|PH7PR12MB7283:EE_
x-ms-office365-filtering-correlation-id: 2294ec21-937b-4ff8-d33d-08df07393201
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|6133799003|56012099006|10067099003|3023799007|4143699003|11063799006|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info: IO1MwmrXMaKZq2ebdEII/Cg8K0NL/rD8An9TEOMWxvhmEIpILzQ9XpZLyJEJMfozqGG8eAEe/vpLQ5yZgt+/ThKqJXaA8flmCVbGoWV85VVV0JkVLPWzCrY2hiy69fZ+xmzzudm+Fr+ex3oCiQaFVS1OAczKRtUaeieXiIU2m8rTS6/N0hgUXcMsKFLhRpJdzp2mWWbyb0l/MjHDifBV+8NsFErdRdtSuMwpGAYQEl597uqmevcuIc5CHyjYJBGkOsi7xRyOqn68Vn3nzn6SfQ4DTNFK6jZkG91txwE4pnkCcA+MgDGHlB7khxuTuMA7mYh88gRlyeBzdpkr+exNatUrd4T1DE6wdFVZPDEak86jgCFc3dP/G/8f5JSdezg9BtzBxeq/SXtwSXZkkVTUrukgj6gvkPp3kJSHC9MIgMpkrH/c/FEg1Bw3n+teHHAN86dc+esYsej626U4dzHxb0nziEYHP1JHFYj1QXO6heLxbD4TyYgWAHInQjBmJTGpj1O3cCimDXYDzibxKDXU/raFQCVTZQ8tNM/GuceP77g3g8yaMWVBb8llXWGiiuoIGMfu2FwU/YqIoelVTY/fAbPBEj95ByjERM5wFxWLaRkUlwDU5yCY0K3cDtueNwTDIU0vQHdurmzk4L16kUmI3GBJCAJp1KN4nBEEsxxztNE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5211.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(6133799003)(56012099006)(10067099003)(3023799007)(4143699003)(11063799006)(18002099003)(22082099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?im6VPxm0Sduwnr4WI6Ppv8ScxLt0zJK49b/esw2frV4uY9IhsnRN125Y7mnK?=
 =?us-ascii?Q?k723fQ01AKuYkHzHTqTX0bDrZ5+iiafZ4YCJwC7Yl2+2vwdgr23bAWzLAD7F?=
 =?us-ascii?Q?YxWArY4yWYehQS3VenK1K4f5+0marNCvhBrPpmz+Sl4vEF732ooUNT/DtQrl?=
 =?us-ascii?Q?7aUdMFtB3X2WSy4cCIpTk56rdha5oHCa95BBzZ7L1K7vylzGKdmYK4UZs1eX?=
 =?us-ascii?Q?MBCcPhjIVz4n1Unc/tjPXdrDSAAXaIFpo606tSF7yOeSolnssoDF3phd8A1T?=
 =?us-ascii?Q?dnC+9+TuFAExg89VgTxZfRqTsQhB3HGEZa9wGEwMtnzp2HrguJZuQs1OGw0+?=
 =?us-ascii?Q?0VEO4MNKRDprPW/KLqaba3rGNWpWeFzKZoP7tBw7tzgd4uUStBAn/Qm4FKmr?=
 =?us-ascii?Q?7s+kVjDY5pQo+VosJXdDvfx5dEwvwTrgItx9Rk5o4vVnMnT3jepkDkKcsqF1?=
 =?us-ascii?Q?WJzG9GnB+lCLV07LvOtoa5Qwo1gWrh6qIx88lqauU3VB0qT8V5hnXWaLyu/R?=
 =?us-ascii?Q?l/vXrFy3SMPEzugujlqjDq5uixMHu8qGaVk8g8k69Z/BqugcbNnoLPCsjO6A?=
 =?us-ascii?Q?zpIiiTUarrxJL/G+3fBSCeb2SsUghY6IHq4+qERpsVufNo2Ieb3wzqnr5eQe?=
 =?us-ascii?Q?CjBQz0Q4s18KA215G5bt/hrPnojkhBHIILV4H1SYuFmCav4vnAXPXcqJYxdV?=
 =?us-ascii?Q?U0Idmg9g3+M0popMnzDVRlHc0IBi3cjMLWIJqEcdbeXPWaJ65CqNI4wyGBqf?=
 =?us-ascii?Q?MbWqlXB/u+QK1AngsIvg7rJ7ixgzORbBFEbH+aDPMBQNgASuZnfu28qupTpJ?=
 =?us-ascii?Q?dC3RvkvVkybkBudWTEv/MM7iy0cAgcqGJEHZJrr1HS7TKPlXLPONgR8WKzEW?=
 =?us-ascii?Q?EDTEzxVGPI6fWcP0Rx7QY6W/EsqMwG+iAhhJwPUXHSxJOLUKN7vobpnSPHOs?=
 =?us-ascii?Q?DCvHvbPsA85wEnEsz0j7f5umNMxqJi7ehfqgD+XpihqxeVs+B55+aEkslzxc?=
 =?us-ascii?Q?PBf8jU9aJVo4WfhfWXUFVE7o2PR6W4EDr7ratEoOOPJvBQovabVqftNezLO/?=
 =?us-ascii?Q?Hxr3aTca75e5rRN0H0xOr1Qz3rUqZ7VJVIMqESBpJzcep84l85aQnhKDxupb?=
 =?us-ascii?Q?4RYcg7ANOThECPJzM9jMm+Mi6HzHDvTEROtW+kn080ZVw13HwA43Ml9cL1sO?=
 =?us-ascii?Q?cVKB/PnikTfbFocOO+G68KMWnwHKA7UWcqP8YZrWuy7UxeXjWjkSH8XpdaSQ?=
 =?us-ascii?Q?YqiriSYvRLzdZli671MHyCXYL2J+wjcEH18ls9o05j1GoCGTD45C8u4pxINb?=
 =?us-ascii?Q?gKN2Vh6qTZYCLo5PiiRYTvtZCQw42TbQlBV+sglVzXIh+R81Mkmx/3Huo8pd?=
 =?us-ascii?Q?1X5FGnpxVBxqBTvGTD4ptTVx+S6YFmL/oa0xa4lpMxlb1kYKjX5aLHMsGD5M?=
 =?us-ascii?Q?rKAT4Of8k7M5gHfXk/3BlWfsHo9DcKzKEIx+gtT/lP5ZJNIOnSyOhaK7xcKi?=
 =?us-ascii?Q?csEZ3uX0uGo2ZXE73JeAxuGYtHQxazPKXqZRLIX9/QJgAiCwMyS+loN285sD?=
 =?us-ascii?Q?EJIz/I7BfGmkPMYmjvqXgoqEJBU9Oh/gPIMUZ7uvsCgZLNGiveHB4PTlyeQv?=
 =?us-ascii?Q?YgpGfyvK3hFdZ+ZmTl7zSqLInu56rRGKyOZlNwajfHoMWBTjnRvk4/m75HHC?=
 =?us-ascii?Q?S4u1WufIhjmILGb+aA9Z7AHF7ZUrTQyVyTLPWVQ8vzBtNi7/?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5211.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2294ec21-937b-4ff8-d33d-08df07393201
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2026 08:23:54.3293 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pYTl/vBbrec7hZmPN4331gGWLJdGfotvw6nECeuJ6p/Z2dApoe85Xa4wfEw6I+sy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7283
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

> -----Original Message-----
> From: Feng, Kenneth <Kenneth.Feng@amd.com>
> Sent: Monday, August 31, 2026 4:10 PM
> To: Wang, Kevin <Kevin.Wang@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking
> <Hawking.Zhang@amd.com>
> Subject: RE: [PATCH 0/7] drm/amd/pm: stage OD reset until commit
>
> AMD General
>
> The uclk setting when uclk dpm is disabled looks redundant, other than th=
at,

This is not redundant code. Before the user sends the 'c' <commit> command =
to the driver, the user may override other fields based on these default se=
tting values.

Best Regards,
Kevin

> Series is Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>
>
> -----Original Message-----
> From: Wang, Kevin <Kevin.Wang@amd.com>
> Sent: Monday, August 31, 2026 12:35 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Hawking
> <Hawking.Zhang@amd.com>; Feng, Kenneth <Kenneth.Feng@amd.com>
> Subject: [PATCH 0/7] drm/amd/pm: stage OD reset until commit
>
> The pp_od_clk_voltage interface exposes a staged OverDrive workflow:
> users edit clock, voltage, and power settings, then write "c" to commit t=
hem
> to the SMU.
>
> However, PP_OD_RESTORE_DEFAULT_TABLE does not follow this workflow on
> every SMU version. Some backends restore their cached settings and wait f=
or
> "c", while others upload the reset table or send frequency-limit commands
> directly from "r". As a result, the same userspace sequence has different
> hardware effects across ASICs.
>
> For example:
>
> - SMU 14.0.0 and SMU 13.0.5 stage reset limits until "c".
> - SMU 14.0.2 and SMU 13.0.6 apply reset values immediately.
> - Navi10 stages the boot OD table, while Vega20 reads the current SMU
>   table instead of restoring the saved defaults.
>
> This series makes "r" restore default values only in driver-side staging =
state.
> "c" remains the sole operation that uploads an OD table or sends frequenc=
y-
> limit commands to PMFW.
>
> This gives pp_od_clk_voltage one consistent transaction model:
>
>   edit/reset -> staged driver state -> commit
>
> It also permits userspace to reset a staged configuration, adjust one or =
more
> settings, and submit the final configuration with one commit, without
> temporarily applying an intermediate default configuration.
>
> Link: https://gitlab.freedesktop.org/drm/amd/-/work_items/5690
>
> Kevin Wang (7):
>   drm/amd/pm: stage od reset for smu 11.0.7
>   drm/amd/pm: stage od reset for smu 13.0.2
>   drm/amd/pm: stage od reset for smu 13.0.0/13.0.7
>   drm/amd/pm: stage od reset for smu 13.0.6
>   drm/amd/pm: stage od reset for smu 14.0.2
>   drm/amd/pm: stage od reset for smu 15.0.8
>   drm/amd/pm: stage od reset for smu vega20
>
>  .../drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c | 75 ++++++++++++++--
>  .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   |  2 +-
>  .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    | 15 +---
>  .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  |  2 +-
>   .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 85 ++++++++++-------
> --  .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  |  2 +-
>   .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c  |  2 +-
>   .../drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c  | 50 ++++++-----
>  8 files changed, 145 insertions(+), 88 deletions(-)
>
> --
> 2.55.0
>

