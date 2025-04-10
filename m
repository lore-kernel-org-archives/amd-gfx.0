Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C654FC3601E
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Apr 2025 15:23:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5762A10E9F6;
	Thu, 10 Apr 2025 15:23:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MXx6DyTf";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2070.outbound.protection.outlook.com [40.107.236.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B8F910E9F6
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Apr 2025 15:23:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YN5b9uBnZI7QPsXqqk0aSDpwHLs5I38nQjMMHVnsubMvyxqXqzz4/1Ybj+srHPqqA9ekGUkGk9MnudnRW/xWIxsDcnecL1gy4wJewqX9tmjDqQ1kjEtmOFWsAkuOPe+V5f0Fs2GZDAyKi+V0RhlrWSYbmLH2O4sC3eBuDVRP6WEwJv8Ex7pf3IRQ77j7lBl9LrvuFFVUvIcSjAk8zujrnDbZ2LFZ8+cp+JSdTY/Y+vvVDR9dazdpmJcBT7jbfqF3wBwz0qO3EFRiuzjiuoUCTWis0+b3oAt7jv/7nSXtzUrI2PXMXIRPXQjw128PO9iVT1QVqvIqEqIP0jeXkxrrdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jW0/GNn6Ww5H+GHhK1FvXgk+CJfbLIlDmHR6oF8piEI=;
 b=ercK6KxYZqNbpYmp/kBBUMD23IyDXkcNL2516sWeMm6C/GvoOmQz3MBAW3csW8FWW9zIjGqTZ/ZlpmLhFKOo1mwu6WyvMfag/FHqGeux0LBTmFF9nm1bAo3gQjOTsHnAU1sfjLtbLfCPGrA+744dXHgABaqWtVuWgMLo/AmPo0OxjY1L6Sn7ueETmnbyqwomCLBm2W+a9Ta0uFXYy61zv9JzZcqhXYsKZXrGDfAmaJMGVveLnM7oMPwX8YrcwTAULkMeDkFywTRYzSRXxv7uvk+rXKldC2V8JFn2OGmTSnduB5jcEEwcfkxzdEstdvEsV7f3Syrp3mLHkq74867cFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jW0/GNn6Ww5H+GHhK1FvXgk+CJfbLIlDmHR6oF8piEI=;
 b=MXx6DyTfEcPvPR+MielaRPWR+g1/yqK71lhDJsY2V8o2wgX9PFmeKDuKXOmo5tWgse28MabiJjqcAtEfYIHo+3PyRFPezJtR64FxgXngQwdgLMaq7fU/fWy2QezI1S+O16omdHRdHQN1SiNu0LxY6ud13aO9sU5yPhmEBzoKvM8=
Received: from CH0PR12MB5284.namprd12.prod.outlook.com (2603:10b6:610:d7::13)
 by BY5PR12MB4258.namprd12.prod.outlook.com (2603:10b6:a03:20d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.21; Thu, 10 Apr
 2025 15:23:21 +0000
Received: from CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::8060:1b11:e9f3:3a51]) by CH0PR12MB5284.namprd12.prod.outlook.com
 ([fe80::8060:1b11:e9f3:3a51%4]) with mapi id 15.20.8632.021; Thu, 10 Apr 2025
 15:23:20 +0000
From: "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amd/display/dml2: use vzalloc rather than kzalloc
Thread-Topic: [PATCH] drm/amd/display/dml2: use vzalloc rather than kzalloc
Thread-Index: AQHbqZg2SX7DjF3QLk+cN7cFR9VlsbOc8tgI
Date: Thu, 10 Apr 2025 15:23:20 +0000
Message-ID: <CH0PR12MB5284C8F92852DFB1581ECA148BB72@CH0PR12MB5284.namprd12.prod.outlook.com>
References: <20250409214138.1293048-1-alexander.deucher@amd.com>
In-Reply-To: <20250409214138.1293048-1-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-04-10T15:23:20.025Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR12MB5284:EE_|BY5PR12MB4258:EE_
x-ms-office365-filtering-correlation-id: 80aa48ad-0e4e-4621-f8c1-08dd7843a086
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|13003099007|38070700018|7053199007|8096899003;
x-microsoft-antispam-message-info: =?us-ascii?Q?1TNHDnLvy2BrZcM+AUCWZuhfK9H+BvQemZi4DmkRwjhoTkM73zWUc+Fo300Z?=
 =?us-ascii?Q?GaluZPv9ISy4rGv8ihn79TOx4j0l/VSg0YwpgDOKpPWlg+pS1gtkPLQPRZEb?=
 =?us-ascii?Q?YXowAlNNyyJ+zxA7qBTgNzCzjuk+HlVcazR/BmeUhzXAlPwRKDkp5CyYoRWp?=
 =?us-ascii?Q?nYzlA1aTyEroTZY9daBN+pqpyiDiYhAAamgQ/J3LnvXY+wrTnQAbByIJZtqB?=
 =?us-ascii?Q?5pxYMtvQEuR8MEQwIfxHuYVsqPXbGZO2ok4nP5y26gqQsAWs/Pl5RwHqIoS0?=
 =?us-ascii?Q?lz0gEpgKG976zQWe8PNup06P10C6zxXSDTU6kDe6f0Vh9dMgA10npsKTL/Ci?=
 =?us-ascii?Q?1dfgVVQiFtYABWwHmbM3RKXAW74Bm1xhgXTFBfMdak+4RZJUc0WZeEdpct60?=
 =?us-ascii?Q?pwULMULqJcajGA1ES2XFenEPL5Ls++PcV6h5vnL589hkHQlebqXjvLTs8+nY?=
 =?us-ascii?Q?xh+0jwSndDpcAPKqhCzatmSMaMJuxqU0poqk+bLwNV61AAET8FPw19h6Fh71?=
 =?us-ascii?Q?1Ix8IoXn3rejRS0gc+T80VvM9+cKPitfQBU6tHHt9EnbAkfZ+Oz9moqUDdOU?=
 =?us-ascii?Q?BklvzloYNfrYkrS5lU8lNis/GHqHrHjJ/PSi7qRVYRlMvyZ/gv4so8635bdp?=
 =?us-ascii?Q?lmlOaI2dAFgjtI498HWwicy3H0Td8eRrhaaf6dLVbQ8O8G6VMwEDWw0I29Av?=
 =?us-ascii?Q?m3+/Nj3pdQWoj97F+9Hesk5wjWiS871FcW99+Yy/L4rm1AcsLY/6MsPZz7OK?=
 =?us-ascii?Q?Lx6FuSCJcUmOqxAzn28KeWaKOACFZllwAIwhUSWAxxUhituMrZA1TWT5UHhk?=
 =?us-ascii?Q?3msgApY8vBCK29Nolw35lijV73qEOis17iwdWoZ0g1AsUgau/7EL9mdyeOha?=
 =?us-ascii?Q?3ATDiYYR/Y4V2tWnhL9r5KIUr+83YPeEFcCopJCczvEA7dy/GVz9l4ajgNEl?=
 =?us-ascii?Q?0iXU2kLhPey35BstUFK4/W5icnzCVVW2iQtDe3Nq0TwKng2vPJFeoayNJrGa?=
 =?us-ascii?Q?+DPb/PY8GzA0q0Zx7oxFF1vIp/J01Ip1YNqORKBJ80iOTWrPAE93FCSddUwl?=
 =?us-ascii?Q?eVkhtkgRQ1aDVmx/1autBF+lqGuOXyoqtKk0cRdWQzcZylazpi3MvIEUGera?=
 =?us-ascii?Q?XhNrexEVV+Gq26yZJMTVYvl+cxel7eiIiToICV6gjIrWrl0LfujjyGsqOOwP?=
 =?us-ascii?Q?QGqG1FIPpapbTq57RrMYkyLqv2dDQg4gjFViy8UMtxhSvt7lW/rEAbKqaDI+?=
 =?us-ascii?Q?khKF9mCZjdVGQeKmks+jbJlP8PldbtWTgK6qoJ0h4tgSC+K8WhphLaqtg23S?=
 =?us-ascii?Q?tTMEsvIm79syLJeeyUyjSTOJVF6VEFa2Y6V+UK/2tudQpHmnsK4iFfQUJSaj?=
 =?us-ascii?Q?GYpW8wuEBZA1jFOe2g71wl8urTg0Yo62QIXbhzgN3V4OJXTFNvMka5PcrCip?=
 =?us-ascii?Q?QzATe2h4dMw=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5284.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(13003099007)(38070700018)(7053199007)(8096899003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?tgfjn4U+t+0bVDcXES5nVPhpCfR+GGwQMnz8/mU3Clbo3dk+hpo3SuFcKDSc?=
 =?us-ascii?Q?M6sHjkfZfFKdp6pF7plACviDJhvbMhqLy16Y/QfPaOkkzydp8pIAEbxXCfD1?=
 =?us-ascii?Q?MP0CLOwsGTOsafmvKMal6ID/B//flt0z9NkV6+oEUK51Uts4645UhDAA36jI?=
 =?us-ascii?Q?vjB0cD6W8DOcoYVmaP5ok8NxUVFvoHvFsCWlyG4yIk1uSQl9QiygVq3lHG8Q?=
 =?us-ascii?Q?p4nL6tM9wnmSeLrAYqakrmumWDiIIbaCFfSbOEUwE2NMbeb2raO8Hzqykm+l?=
 =?us-ascii?Q?qYdMp2BKiqwPlRYmdDCAHBGv8PefHguOWAdZuVBLyBQujp2IA2rj0ekAj3v1?=
 =?us-ascii?Q?oUj2JLyHMOLFKvMd0od+NYvsE3/GKogCZWYxhSK3cT+HPvEGQXxN/fLJrTtU?=
 =?us-ascii?Q?6w6t9w4mc7FYD6cAhwbF5h+XSEm4scTTrbHLBufVim+JroGNbM4C2pbM99tH?=
 =?us-ascii?Q?qlVgxEFaQK/OS6wRUETh6W1zDV5CJ3jzVkqFVqPjkjY+UBCMwcbUBQihG9pk?=
 =?us-ascii?Q?07WNqys1JgEwXAF6T6z9zTZxBMSm7wiVQVzQjLKOeed6E82sEE1Nx9zd/M8T?=
 =?us-ascii?Q?6hIWu2SinfXhi1gg4uyHuKR2deohVz0w5oeTjQBmxbX8NzkF+FIXSdkzbka0?=
 =?us-ascii?Q?wA6qKFqFfODbpC1Mo1HFzh5JfJkZv9LGRD3EsuolDo7mAZe2cjkR7CPDMYzd?=
 =?us-ascii?Q?0+0ZbGW9S5ICzYzOMH56FL2GIFmKkCl9boVgner3ew02/UJDeQkaB+Csglkr?=
 =?us-ascii?Q?W6+Q5zsV8Uh15nzjOuQqYFEeH3kvOR/Ebn56ai0DDdTluaGRTCaHcovT/Ag9?=
 =?us-ascii?Q?dEtl5PNQf0IY0u7I4CixXomVQ1UXBzTBF8w5B9aR3XfkY/H09U3xjo87QeZO?=
 =?us-ascii?Q?EIoM/I8VUejs2xutlVFCJjycEccxVEGVLqdy/7kpztDQsBrBbfqkqWH/cy4Q?=
 =?us-ascii?Q?f8bS1bZnGsit2x4fbPnApDVerLN9UO5ADr+YrbofkRK6+mnCIFmtETPwoR3d?=
 =?us-ascii?Q?+rqE0Kw0v9M9MxkdCXqS0V/Ujpg8JH3R5n44JpjBywTF+X1R8iP9KCSeQ/X8?=
 =?us-ascii?Q?7tdW3ev+Q0YWX/2tWpm5G77gooDHlwrxqsBGTI9SKvwpzChh3Jt3dvEBbZN6?=
 =?us-ascii?Q?A7SmyfcxXTNeRAcjv8p3uJEiYP4q++fLSxbJtO8qQ6sAD5P/gy0N+AwTBwiy?=
 =?us-ascii?Q?3TXTawQdIp5Qem1KhCZwMJcPsMVLK0VoQqdlxYY9m1ZcO6v1fo2g5KmPR2Gt?=
 =?us-ascii?Q?TvigZfDfzezw8ZE8grJKi8CQpcZRVjwrIMZr033xbGbT03ar12EZBlm5Gf4u?=
 =?us-ascii?Q?TYPWlq+Q9eCbSW4432BFXoDa7hOzNa6RpeM043rp1a3YiVeJ/iYEnOMpVH2e?=
 =?us-ascii?Q?uIAwAiNoa9m1C+eaz/pPnVQFX3KKzzQoJ9udupm3rndLShqNfJG718ncWXBt?=
 =?us-ascii?Q?0Xi+c4yNrLKiT+x0/x79RE0NXJKNC07Z+fHIzdwMsbkk8Lfg9RgY690yopz5?=
 =?us-ascii?Q?zv4DJpVgYDN/GVgEz3QdZKG8jzyaLaV52UY4+jcDQExf8VVxECWKnHEAnu8O?=
 =?us-ascii?Q?jxs67lmWFKHTidUE9Yo=3D?=
Content-Type: multipart/alternative;
 boundary="_000_CH0PR12MB5284C8F92852DFB1581ECA148BB72CH0PR12MB5284namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5284.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80aa48ad-0e4e-4621-f8c1-08dd7843a086
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2025 15:23:20.7486 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wjj+/tkcW/jwpfFgotQPZ1erTIcYGoZF8Bkd62d8WG9FqO49q09mKLLSZmtubBRhxtK+mOav2JCEy6nQm3lePw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4258
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

--_000_CH0PR12MB5284C8F92852DFB1581ECA148BB72CH0PR12MB5284namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>

--

Regards,
Jay
________________________________
From: Deucher, Alexander <Alexander.Deucher@amd.com>
Sent: Wednesday, April 9, 2025 5:41 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Pillai, Aurabindo <Aura=
bindo.Pillai@amd.com>
Subject: [PATCH] drm/amd/display/dml2: use vzalloc rather than kzalloc

The structures are large and they do not require continuous
memory so use vzalloc.

Fixes: 70839da63605 ("drm/amd/display: Add new DCN401 sources")
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4126
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/display/dc/dml2/dml21/dml21_wrapper.c | 11 ++++++-----
 drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c    |  6 ++++--
 2 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_wrapper.c b/dr=
ivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_wrapper.c
index 94e99e540691c..5d16f36ec95c8 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_wrapper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_wrapper.c
@@ -2,6 +2,7 @@
 //
 // Copyright 2024 Advanced Micro Devices, Inc.

+#include <linux/vmalloc.h>

 #include "dml2_internal_types.h"
 #include "dml_top.h"
@@ -13,11 +14,11 @@

 static bool dml21_allocate_memory(struct dml2_context **dml_ctx)
 {
-       *dml_ctx =3D kzalloc(sizeof(struct dml2_context), GFP_KERNEL);
+       *dml_ctx =3D vzalloc(sizeof(struct dml2_context));
         if (!(*dml_ctx))
                 return false;

-       (*dml_ctx)->v21.dml_init.dml2_instance =3D kzalloc(sizeof(struct dm=
l2_instance), GFP_KERNEL);
+       (*dml_ctx)->v21.dml_init.dml2_instance =3D vzalloc(sizeof(struct dm=
l2_instance));
         if (!((*dml_ctx)->v21.dml_init.dml2_instance))
                 return false;

@@ -27,7 +28,7 @@ static bool dml21_allocate_memory(struct dml2_context **d=
ml_ctx)
         (*dml_ctx)->v21.mode_support.display_config =3D &(*dml_ctx)->v21.d=
isplay_config;
         (*dml_ctx)->v21.mode_programming.display_config =3D (*dml_ctx)->v2=
1.mode_support.display_config;

-       (*dml_ctx)->v21.mode_programming.programming =3D kzalloc(sizeof(str=
uct dml2_display_cfg_programming), GFP_KERNEL);
+       (*dml_ctx)->v21.mode_programming.programming =3D vzalloc(sizeof(str=
uct dml2_display_cfg_programming));
         if (!((*dml_ctx)->v21.mode_programming.programming))
                 return false;

@@ -115,8 +116,8 @@ bool dml21_create(const struct dc *in_dc, struct dml2_c=
ontext **dml_ctx, const s

 void dml21_destroy(struct dml2_context *dml2)
 {
-       kfree(dml2->v21.dml_init.dml2_instance);
-       kfree(dml2->v21.mode_programming.programming);
+       vfree(dml2->v21.dml_init.dml2_instance);
+       vfree(dml2->v21.mode_programming.programming);
 }

 static void dml21_calculate_rq_and_dlg_params(const struct dc *dc, struct =
dc_state *context, struct resource_context *out_new_hw_state,
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c b/drivers/g=
pu/drm/amd/display/dc/dml2/dml2_wrapper.c
index 04316d719426a..525b7d04bf84c 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c
@@ -24,6 +24,8 @@
  *
  */

+#include <linux/vmalloc.h>
+
 #include "display_mode_core.h"
 #include "dml2_internal_types.h"
 #include "dml2_utils.h"
@@ -750,7 +752,7 @@ bool dml2_validate(const struct dc *in_dc, struct dc_st=
ate *context, struct dml2

 static inline struct dml2_context *dml2_allocate_memory(void)
 {
-       return (struct dml2_context *) kzalloc(sizeof(struct dml2_context),=
 GFP_KERNEL);
+       return (struct dml2_context *) vzalloc(sizeof(struct dml2_context))=
;
 }

 static void dml2_init(const struct dc *in_dc, const struct dml2_configurat=
ion_options *config, struct dml2_context **dml2)
@@ -824,7 +826,7 @@ void dml2_destroy(struct dml2_context *dml2)

         if (dml2->architecture =3D=3D dml2_architecture_21)
                 dml21_destroy(dml2);
-       kfree(dml2);
+       vfree(dml2);
 }

 void dml2_extract_dram_and_fclk_change_support(struct dml2_context *dml2,
--
2.49.0


--_000_CH0PR12MB5284C8F92852DFB1581ECA148BB72CH0PR12MB5284namp_
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
Reviewed-by: Aurabindo Pillai &lt;aurabindo.pillai@amd.com&gt;</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"color: inherit;" class=3D"elementToProof" id=3D"Signature">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
--</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Regards,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Jay<br>
</div>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Deucher, Alexander &l=
t;Alexander.Deucher@amd.com&gt;<br>
<b>Sent:</b> Wednesday, April 9, 2025 5:41 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Pillai, Au=
rabindo &lt;Aurabindo.Pillai@amd.com&gt;<br>
<b>Subject:</b> [PATCH] drm/amd/display/dml2: use vzalloc rather than kzall=
oc</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">The structures are large and they do not require c=
ontinuous<br>
memory so use vzalloc.<br>
<br>
Fixes: 70839da63605 (&quot;drm/amd/display: Add new DCN401 sources&quot;)<b=
r>
Closes: <a href=3D"https://gitlab.freedesktop.org/drm/amd/-/issues/4126">ht=
tps://gitlab.freedesktop.org/drm/amd/-/issues/4126</a><br>
Cc: Aurabindo Pillai &lt;aurabindo.pillai@amd.com&gt;<br>
Signed-off-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;<br>
---<br>
&nbsp;.../gpu/drm/amd/display/dc/dml2/dml21/dml21_wrapper.c | 11 ++++++----=
-<br>
&nbsp;drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c&nbsp;&nbsp;&nbsp; =
|&nbsp; 6 ++++--<br>
&nbsp;2 files changed, 10 insertions(+), 7 deletions(-)<br>
<br>
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_wrapper.c b/dr=
ivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_wrapper.c<br>
index 94e99e540691c..5d16f36ec95c8 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_wrapper.c<br>
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_wrapper.c<br>
@@ -2,6 +2,7 @@<br>
&nbsp;//<br>
&nbsp;// Copyright 2024 Advanced Micro Devices, Inc.<br>
&nbsp;<br>
+#include &lt;linux/vmalloc.h&gt;<br>
&nbsp;<br>
&nbsp;#include &quot;dml2_internal_types.h&quot;<br>
&nbsp;#include &quot;dml_top.h&quot;<br>
@@ -13,11 +14,11 @@<br>
&nbsp;<br>
&nbsp;static bool dml21_allocate_memory(struct dml2_context **dml_ctx)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *dml_ctx =3D kzalloc(sizeof(struct dm=
l2_context), GFP_KERNEL);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *dml_ctx =3D vzalloc(sizeof(struct dm=
l2_context));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!(*dml_ctx))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return false;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (*dml_ctx)-&gt;v21.dml_init.dml2_inst=
ance =3D kzalloc(sizeof(struct dml2_instance), GFP_KERNEL);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (*dml_ctx)-&gt;v21.dml_init.dml2_inst=
ance =3D vzalloc(sizeof(struct dml2_instance));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!((*dml_ctx)-&gt;v21.d=
ml_init.dml2_instance))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return false;<br>
&nbsp;<br>
@@ -27,7 +28,7 @@ static bool dml21_allocate_memory(struct dml2_context **d=
ml_ctx)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (*dml_ctx)-&gt;v21.mode_su=
pport.display_config =3D &amp;(*dml_ctx)-&gt;v21.display_config;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (*dml_ctx)-&gt;v21.mode_pr=
ogramming.display_config =3D (*dml_ctx)-&gt;v21.mode_support.display_config=
;<br>
&nbsp;<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (*dml_ctx)-&gt;v21.mode_programming.p=
rogramming =3D kzalloc(sizeof(struct dml2_display_cfg_programming), GFP_KER=
NEL);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (*dml_ctx)-&gt;v21.mode_programming.p=
rogramming =3D vzalloc(sizeof(struct dml2_display_cfg_programming));<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!((*dml_ctx)-&gt;v21.m=
ode_programming.programming))<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; return false;<br>
&nbsp;<br>
@@ -115,8 +116,8 @@ bool dml21_create(const struct dc *in_dc, struct dml2_c=
ontext **dml_ctx, const s<br>
&nbsp;<br>
&nbsp;void dml21_destroy(struct dml2_context *dml2)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(dml2-&gt;v21.dml_init.dml2_inst=
ance);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(dml2-&gt;v21.mode_programming.p=
rogramming);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vfree(dml2-&gt;v21.dml_init.dml2_inst=
ance);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vfree(dml2-&gt;v21.mode_programming.p=
rogramming);<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static void dml21_calculate_rq_and_dlg_params(const struct dc *dc, st=
ruct dc_state *context, struct resource_context *out_new_hw_state,<br>
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c b/drivers/g=
pu/drm/amd/display/dc/dml2/dml2_wrapper.c<br>
index 04316d719426a..525b7d04bf84c 100644<br>
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c<br>
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c<br>
@@ -24,6 +24,8 @@<br>
&nbsp; *<br>
&nbsp; */<br>
&nbsp;<br>
+#include &lt;linux/vmalloc.h&gt;<br>
+<br>
&nbsp;#include &quot;display_mode_core.h&quot;<br>
&nbsp;#include &quot;dml2_internal_types.h&quot;<br>
&nbsp;#include &quot;dml2_utils.h&quot;<br>
@@ -750,7 +752,7 @@ bool dml2_validate(const struct dc *in_dc, struct dc_st=
ate *context, struct dml2<br>
&nbsp;<br>
&nbsp;static inline struct dml2_context *dml2_allocate_memory(void)<br>
&nbsp;{<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return (struct dml2_context *) kzallo=
c(sizeof(struct dml2_context), GFP_KERNEL);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return (struct dml2_context *) vzallo=
c(sizeof(struct dml2_context));<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;static void dml2_init(const struct dc *in_dc, const struct dml2_confi=
guration_options *config, struct dml2_context **dml2)<br>
@@ -824,7 +826,7 @@ void dml2_destroy(struct dml2_context *dml2)<br>
&nbsp;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (dml2-&gt;architecture =
=3D=3D dml2_architecture_21)<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; dml21_destroy(dml2);<br>
-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfree(dml2);<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vfree(dml2);<br>
&nbsp;}<br>
&nbsp;<br>
&nbsp;void dml2_extract_dram_and_fclk_change_support(struct dml2_context *d=
ml2,<br>
-- <br>
2.49.0<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_CH0PR12MB5284C8F92852DFB1581ECA148BB72CH0PR12MB5284namp_--
