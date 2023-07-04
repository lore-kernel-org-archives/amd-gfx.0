Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A67BEB64D9
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Jul 2023 15:39:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8FB410E2E7;
	Tue,  4 Jul 2023 15:39:56 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2058.outbound.protection.outlook.com [40.107.243.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A92C10E2DC
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Jul 2023 15:39:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gwGUyFRIGogoEeQ+XpALMJBG3+MvX0fyGB/AdF6/cZ3Ig4NSgzB9tDWH5l0FK05Fpy4MG45lr6HK8RIWAde71ynpBtDqIw3hv7chX55TNQ2GfGy0SWvjyLiRfJWC2Or4wKXEAunzeK3i3bwXAhjfVao/i+IPnkK00NlhGzE9RrVbapRXReVnIKT/eI0Ywlh6Q3c1RMVlEeZ116zBhHW07sFWZyYK3b5c8lmhSaE7XLvFQ0QHeCFKGLiwk280ZM/UPnUcrdjgTBmQSrO5xMx1IweDbodR9x/l5qmv7aOgY/895nuw8vwy71ZXMZf8UgeDYiGdn+0nuqNr2UGQv/xgKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/2ppJtamQcQhGaj+rIjdDbaPv2sozOQezMluO97WTsk=;
 b=nbW1DM78Kmt0hvbyrzq8dLBwBRDJy7HGW0oTda91BALUmXuSPiuKtMoofFIYyO1JQcj2Ppumd+gPP03Amo22R7EXoFf/X8AM220C9azE9TzVjPmQ+1UAEgt5OGfK7Nk8mvFOLyWpVhf9QPqEIr6FvtM2voYXKEwBNGZHHbpCClTLZD8l5mUgMC6cWnl+1hVYAo0phWXS49+3sek0kqO60bkO2WyHemZI8rHLQ0bUj69FfXHIS1OkSyEaeU4+DjWbtInzaf4uePHIU/fAlq6avKg7Pz88K7LIycJoCZi5hLARecCwQObylzWQc5Y3jZqw8w+JlJGp0UWgoZcltnrn+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/2ppJtamQcQhGaj+rIjdDbaPv2sozOQezMluO97WTsk=;
 b=RM5MOAiOnDE9Uz1Et9wlCtMJGTgHTrbZxw3B2HwQRVFRg4yZvznzU6/VCWhtLA5wgUrpWKBHYwt/vJX7F6rjS/X4AWsER7r+ulrT1ylxFMZv7ODWgvL6dK0uBki2fmkCoUYAIlp/ixbOASza0xRhMJL5W9Ls1Tpnzglbf60m2sw=
Received: from CY8PR12MB7435.namprd12.prod.outlook.com (2603:10b6:930:51::6)
 by SJ0PR12MB6853.namprd12.prod.outlook.com (2603:10b6:a03:47b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Tue, 4 Jul
 2023 15:39:48 +0000
Received: from CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::100e:1d82:bd2a:e05e]) by CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::100e:1d82:bd2a:e05e%3]) with mapi id 15.20.6565.016; Tue, 4 Jul 2023
 15:39:48 +0000
From: "Kim, Jonathan" <Jonathan.Kim@amd.com>
To: "Huang, JinHuiEric" <JinHuiEric.Huang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/5] drm/amdgpu: add debugger support for GC v9.4.3
Thread-Topic: [PATCH 1/5] drm/amdgpu: add debugger support for GC v9.4.3
Thread-Index: AQHZqgbb9qh9O86EjUKHFZXFdfmnDa+pxNiw
Date: Tue, 4 Jul 2023 15:39:48 +0000
Message-ID: <CY8PR12MB74353A6E9B7BBEE471AE63D4852EA@CY8PR12MB7435.namprd12.prod.outlook.com>
References: <20230628212323.248650-1-jinhuieric.huang@amd.com>
 <20230628212323.248650-2-jinhuieric.huang@amd.com>
In-Reply-To: <20230628212323.248650-2-jinhuieric.huang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=11652586-7c74-4b48-a7c4-41824ae80faa;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-07-04T15:30:31Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7435:EE_|SJ0PR12MB6853:EE_
x-ms-office365-filtering-correlation-id: c1bdd3f2-658d-4a8b-7ef3-08db7ca4e635
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wBMF48jLpBjMNJTGx/sFcgrzyNz5QovwMyOekJyGeYLEjq9LwrfQAows2LZnLfik/i80JTo6i4ewBKF0vZ/dqb6o568sxbdnJop+ar8ATCFebR/3l8rG4EnhuCNCPIZ8xixywBQHualbNtDg7LWP7dRNVePU6dy0hq+kCAFEiiifClz0DFze39+YgZmck0AUc7mm+D5IDymgz207do7ZoPOYAdoIFvcUJbfEty8eMWuFlDBlHBfeBIh4fTLFzIXpvBp0xNxvL0azfMErAKalr7eOEmHKTC8OaZxRQSAJxdDt4MBtNQoA8kGdVV3lUoaFWUkl+sLSFChA5lHO0jc81lXHTZhyN5xhdgl3XopFTlwMjMCS4lUQlMxzRre0JFaGbK96DU2h4zZhxV5naF94NnRXPBp4ZBCD/cd5wArrKrxVkIWz4lKoiijx90oqamPWEQj9eHmek+oU0m5nEmbzs8tWHC0D4VZGt6JbwB6Ae1VHHoBQxvHFOeFgSHgqD+sszGDzzViDJXWCZJ7YCasHfTt/JkLSRbsckbA+eiwUL2XR06otkEyaYmK9G6bZcGpkXzfddchDG3pX0iYTAobX/9K/EmYi3Ee9CvLCqx9gAt+gANlXSInbZGDZBkRLC/OK
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7435.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(366004)(376002)(136003)(396003)(346002)(451199021)(2906002)(7696005)(71200400001)(55016003)(122000001)(9686003)(86362001)(38100700002)(83380400001)(53546011)(6506007)(30864003)(110136005)(41300700001)(38070700005)(186003)(316002)(66946007)(66556008)(64756008)(66476007)(76116006)(66446008)(33656002)(5660300002)(52536014)(478600001)(8676002)(8936002)(66899021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?S9JiWSjGGszBlqon9kYJGlokUGWl8hwqu+F/US9z6ihsVlWs7EMdX2PdmOVN?=
 =?us-ascii?Q?eyvyi8GILOdLt9joZLNsVKbz4FiAuHhZPdws0C2D2R/Flfd4vK8Xf9XxkKXG?=
 =?us-ascii?Q?yJPdj2UtmK/C51Vnxarp7spgz/vaFYh41qXuGxzlXhegozkcOSWIfs97FxgW?=
 =?us-ascii?Q?lsK0FsNEIIzgWdHBpcbPi5Tpza1gejlzyUR9jYMqBc5IwJsz2djXpKtrdNmQ?=
 =?us-ascii?Q?0TID2egfOZ0W1ddkIIe4ZyRh8vwdVnzzTsI2Nyp8GqSqeF9clUqIHFB7E4v1?=
 =?us-ascii?Q?L22lj9SMGygHnSVSbxev1N50srTk6Lud8CJ3Y7Ig3ptDvoxAJDIkWCtoUglC?=
 =?us-ascii?Q?fGBFfW3yESnn0roppcT8jJ9hqWZy4BzSxFbVt8pntLzvDAdJSrnJOFAb2gc+?=
 =?us-ascii?Q?YtIY1EadGhNLndJQe3/13IbuxeZw8xTlr47lY8IyEg52Bizo3v9h8Vo8i5Q4?=
 =?us-ascii?Q?eTxm2D+w2jiL6cLeQeMRldxSY/dW2ju58m2km7SkoN5kM6y0T7sqSZeX9G/X?=
 =?us-ascii?Q?+cbvMa6BxnCTKSYY0+hpkmANqjtJ+Gwe0Kl01fenfOCivqPG0V2GhAYfVqim?=
 =?us-ascii?Q?ugivi4uEVdmkcVE0h6IBBHn0Njj7EU2wVNgwq9MSY+UjAKQoYMwZ8ODZAlCv?=
 =?us-ascii?Q?TMZLXkyJWwvwsfWrkP1WkdEmA9gyZIiL5RqenAXbcGujxAHT1mHDW9IhcHVo?=
 =?us-ascii?Q?TLlxS/bzL2VOLIQuffsmfYNdyMKWrhkQ5Bm+1wpaccoNYC0LXuVb4POlqQBI?=
 =?us-ascii?Q?9Rc/5+ZIbj2QvNcLiTJ0G3m+4PDrNx7ysZ4XfDCpzCZA/GcksJXGYysb1XXP?=
 =?us-ascii?Q?NchkxmCn+eJJd1sI5AdrAuDbvtnRFpohWB8EMj8GzPtcDX7aVRNGdxVxjchS?=
 =?us-ascii?Q?lWJNPwh7edtOmTcxPtAineo+xRMUOGO1kmITZac1XWgEFUiJujjtywtupB3U?=
 =?us-ascii?Q?S5jcw5rNMrSvZgzCzvSaFOV+xTG+b7KmMi0dWgQsrmaxa32qdJji7pFFy0Uw?=
 =?us-ascii?Q?gwT2WZxyBjsqWBWOCPb66/w1/08PYXm6rIQihSdQTgPgauzj9+RaK5Czq/b8?=
 =?us-ascii?Q?5KkSk2KeqR03Ng8CZlJxbDzLpkI0zCVKICLT8XyRh2muoltSsek0Jh/l67s/?=
 =?us-ascii?Q?6QantauUhRR4LOHdwq8D3Lvo1WighG3LkhuyWf08pV4sAMFizmep19t1BaCx?=
 =?us-ascii?Q?m/nbwRx0YvNdG5YdNloa8psNaTPGt74sxNHK/yTU0iaWin6s6eKSnyCH+I5p?=
 =?us-ascii?Q?j+d+sCBZTmEnnmumfe8nwC/oZwH5nmrFIXXzm3REO5ZcjR47lhMvq6J7lltk?=
 =?us-ascii?Q?blHrpRa0z55TE1fRsYJc/kIFAaltluflmrjcIB1qEsHW+jP0q1lL+Xj55JIw?=
 =?us-ascii?Q?aEF3MYvBNCt7YQ5EUFUdM2hiCoX+c8lp7kvDiJISXzKQRE1FuHbI6WftbRkp?=
 =?us-ascii?Q?s2rgGjMfZTEZGHZrF5TC0lOpLZY7MP8SMfSwMFifWMt33oyCO30P5/ciT5N5?=
 =?us-ascii?Q?v9G5rGYffZOwlUrssghRodJ3t4yngJld7lPuZYO5j60NouAjDM1v9jJX3K4g?=
 =?us-ascii?Q?rfud0ogKPg86iurDsmdpDCYm85sKolt/uBbhj1JaEvHP6AS1/PCClF4DwqD5?=
 =?us-ascii?Q?YUkA+/dFqmfTkPntu05kN1c=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1bdd3f2-658d-4a8b-7ef3-08db7ca4e635
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2023 15:39:48.1521 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MlSVhl1tREDRqUexSApcwpTjR7nck3CGaNwDg+SDZ6sv8c9wFsIYpVc44KJCX8//
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6853
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

[Public]

> -----Original Message-----
> From: Huang, JinHuiEric <JinHuiEric.Huang@amd.com>
> Sent: Wednesday, June 28, 2023 5:23 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Kim, Jonathan <Jonathan.Kim@amd.com>; Kim, Jonathan
> <Jonathan.Kim@amd.com>; Huang, JinHuiEric <JinHuiEric.Huang@amd.com>
> Subject: [PATCH 1/5] drm/amdgpu: add debugger support for GC v9.4.3

This patch doesn't add support but defines the KGD callbacks required for s=
upport.

>
> From: Jonathan Kim <jonathan.kim@amd.com>
>
> Implement the similarities as GC v9.4.2, and the difference
> for GC v9.4.3 HW spec.
>
> Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
> ---
>  .../drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c  |   7 +-
>  .../drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.h  |  30 ++++
>  .../drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c   | 146
> +++++++++++++++++-
>  3 files changed, 179 insertions(+), 4 deletions(-)
>  create mode 100644
> drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.h
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
> index 60f9e027fb66..f3f7e0437447 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
> @@ -23,6 +23,7 @@
>  #include "amdgpu_amdkfd.h"
>  #include "amdgpu_amdkfd_arcturus.h"
>  #include "amdgpu_amdkfd_gfx_v9.h"
> +#include "amdgpu_amdkfd_aldebaran.h"
>  #include "gc/gc_9_4_2_offset.h"
>  #include "gc/gc_9_4_2_sh_mask.h"
>  #include <uapi/linux/kfd_ioctl.h>
> @@ -36,7 +37,7 @@
>   * initialize the debug mode registers after it has disabled GFX off dur=
ing the
>   * debug session.
>   */
> -static uint32_t kgd_aldebaran_enable_debug_trap(struct amdgpu_device
> *adev,
> +uint32_t kgd_aldebaran_enable_debug_trap(struct amdgpu_device *adev,
>                                           bool restore_dbg_registers,
>                                           uint32_t vmid)
>  {
> @@ -50,7 +51,7 @@ static uint32_t
> kgd_aldebaran_enable_debug_trap(struct amdgpu_device *adev,
>  }
>
>  /* returns TRAP_EN, EXCP_EN and EXCP_REPLACE. */
> -static uint32_t kgd_aldebaran_disable_debug_trap(struct amdgpu_device
> *adev,
> +uint32_t kgd_aldebaran_disable_debug_trap(struct amdgpu_device *adev,
>                                               bool keep_trap_enabled,
>                                               uint32_t vmid)
>  {
> @@ -107,7 +108,7 @@ static uint32_t
> kgd_aldebaran_set_wave_launch_trap_override(struct amdgpu_device
>       return data;
>  }
>
> -static uint32_t kgd_aldebaran_set_wave_launch_mode(struct
> amdgpu_device *adev,
> +uint32_t kgd_aldebaran_set_wave_launch_mode(struct amdgpu_device
> *adev,
>                                       uint8_t wave_launch_mode,
>                                       uint32_t vmid)
>  {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.h
> new file mode 100644
> index 000000000000..5f776ede295e
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.h
> @@ -0,0 +1,30 @@
> +/*
> + * Copyright 2021 Advanced Micro Devices, Inc.

Should be dated 2023.

> + *
> + * Permission is hereby granted, free of charge, to any person obtaining=
 a
> + * copy of this software and associated documentation files (the "Softwa=
re"),
> + * to deal in the Software without restriction, including without limita=
tion
> + * the rights to use, copy, modify, merge, publish, distribute, sublicen=
se,
> + * and/or sell copies of the Software, and to permit persons to whom the
> + * Software is furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be includ=
ed
> in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
> MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO
> EVENT SHALL
> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM,
> DAMAGES OR
> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
> OTHERWISE,
> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE
> USE OR
> + * OTHER DEALINGS IN THE SOFTWARE.
> + */
> +uint32_t kgd_aldebaran_enable_debug_trap(struct amdgpu_device *adev,
> +                                     bool restore_dbg_registers,
> +                                     uint32_t vmid);
> +uint32_t kgd_aldebaran_disable_debug_trap(struct amdgpu_device *adev,
> +                                     bool keep_trap_enabled,
> +                                     uint32_t vmid);
> +uint32_t kgd_aldebaran_set_wave_launch_mode(struct amdgpu_device
> *adev,
> +                                     uint8_t wave_launch_mode,
> +                                     uint32_t vmid);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
> index 5b4b7f8b92a5..7aab8dcf46e1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c
> @@ -22,6 +22,7 @@
>  #include "amdgpu.h"
>  #include "amdgpu_amdkfd.h"
>  #include "amdgpu_amdkfd_gfx_v9.h"
> +#include "amdgpu_amdkfd_aldebaran.h"
>  #include "gc/gc_9_4_3_offset.h"
>  #include "gc/gc_9_4_3_sh_mask.h"
>  #include "athub/athub_1_8_0_offset.h"
> @@ -32,6 +33,7 @@
>  #include "soc15.h"
>  #include "sdma/sdma_4_4_2_offset.h"
>  #include "sdma/sdma_4_4_2_sh_mask.h"
> +#include <uapi/linux/kfd_ioctl.h>
>
>  static inline struct v9_sdma_mqd *get_sdma_mqd(void *mqd)
>  {
> @@ -361,6 +363,139 @@ static int kgd_gfx_v9_4_3_hqd_load(struct
> amdgpu_device *adev, void *mqd,
>       return 0;
>  }
>
> +static int kgd_gfx_v9_4_3_validate_trap_override_request(
> +                             struct amdgpu_device *adev,
> +                             uint32_t trap_override,
> +                             uint32_t *trap_mask_supported)
> +{
> +     *trap_mask_supported &=3D KFD_DBG_TRAP_MASK_FP_INVALID |
> +                             KFD_DBG_TRAP_MASK_FP_INPUT_DENORMAL |
> +                             KFD_DBG_TRAP_MASK_FP_DIVIDE_BY_ZERO |
> +                             KFD_DBG_TRAP_MASK_FP_OVERFLOW |
> +                             KFD_DBG_TRAP_MASK_FP_UNDERFLOW |
> +                             KFD_DBG_TRAP_MASK_FP_INEXACT |
> +                             KFD_DBG_TRAP_MASK_INT_DIVIDE_BY_ZERO |
> +                             KFD_DBG_TRAP_MASK_DBG_ADDRESS_WATCH |
> +                             KFD_DBG_TRAP_MASK_DBG_MEMORY_VIOLATION |
> +                             KFD_DBG_TRAP_MASK_TRAP_ON_WAVE_START |
> +                             KFD_DBG_TRAP_MASK_TRAP_ON_WAVE_END;
> +
> +     if (trap_override !=3D KFD_DBG_TRAP_OVERRIDE_OR &&
> +                     trap_override !=3D
> KFD_DBG_TRAP_OVERRIDE_REPLACE)
> +             return -EPERM;
> +
> +     return 0;
> +}
> +
> +static uint32_t trap_mask_map_sw_to_hw(uint32_t mask)
> +{
> +     uint32_t trap_on_start =3D (mask &
> KFD_DBG_TRAP_MASK_TRAP_ON_WAVE_START) ? 1 : 0;
> +     uint32_t trap_on_end =3D (mask &
> KFD_DBG_TRAP_MASK_TRAP_ON_WAVE_END) ? 1 : 0;
> +     uint32_t excp_en =3D mask & (KFD_DBG_TRAP_MASK_FP_INVALID |
> +
>       KFD_DBG_TRAP_MASK_FP_INPUT_DENORMAL |
> +                             KFD_DBG_TRAP_MASK_FP_DIVIDE_BY_ZERO |
> +                             KFD_DBG_TRAP_MASK_FP_OVERFLOW |
> +                             KFD_DBG_TRAP_MASK_FP_UNDERFLOW |
> +                             KFD_DBG_TRAP_MASK_FP_INEXACT |
> +                             KFD_DBG_TRAP_MASK_INT_DIVIDE_BY_ZERO
> |
> +
>       KFD_DBG_TRAP_MASK_DBG_ADDRESS_WATCH |
> +
>       KFD_DBG_TRAP_MASK_DBG_MEMORY_VIOLATION);
> +     uint32_t ret;
> +
> +     ret =3D REG_SET_FIELD(0, SPI_GDBG_PER_VMID_CNTL, EXCP_EN,
> excp_en);
> +     ret =3D REG_SET_FIELD(ret, SPI_GDBG_PER_VMID_CNTL,
> TRAP_ON_START, trap_on_start);
> +     ret =3D REG_SET_FIELD(ret, SPI_GDBG_PER_VMID_CNTL,
> TRAP_ON_END, trap_on_end);
> +
> +     return ret;
> +}
> +
> +static uint32_t trap_mask_map_hw_to_sw(uint32_t mask)
> +{
> +     uint32_t ret =3D REG_GET_FIELD(mask, SPI_GDBG_PER_VMID_CNTL,
> EXCP_EN);
> +
> +     if (REG_GET_FIELD(mask, SPI_GDBG_PER_VMID_CNTL,
> TRAP_ON_START))
> +             ret |=3D KFD_DBG_TRAP_MASK_TRAP_ON_WAVE_START;
> +
> +     if (REG_GET_FIELD(mask, SPI_GDBG_PER_VMID_CNTL,
> TRAP_ON_END))
> +             ret |=3D KFD_DBG_TRAP_MASK_TRAP_ON_WAVE_END;
> +
> +     return ret;
> +}
> +
> +/* returns TRAP_EN, EXCP_EN and EXCP_RPLACE. */

Typo.  EXCP_RPLACE should be EXCP_REPLACE.

> +static uint32_t kgd_gfx_v9_4_3_set_wave_launch_trap_override(
> +                             struct amdgpu_device *adev,
> +                             uint32_t vmid,
> +                             uint32_t trap_override,
> +                             uint32_t trap_mask_bits,
> +                             uint32_t trap_mask_request,
> +                             uint32_t *trap_mask_prev,
> +                             uint32_t kfd_dbg_trap_cntl_prev)
> +
> +{
> +     uint32_t data =3D 0;
> +
> +     *trap_mask_prev =3D
> trap_mask_map_hw_to_sw(kfd_dbg_trap_cntl_prev);
> +
> +     data =3D (trap_mask_bits & trap_mask_request) |
> +            (*trap_mask_prev & ~trap_mask_request);
> +     data =3D trap_mask_map_sw_to_hw(data);
> +
> +     data =3D REG_SET_FIELD(data, SPI_GDBG_PER_VMID_CNTL, TRAP_EN,
> 1);
> +     data =3D REG_SET_FIELD(data, SPI_GDBG_PER_VMID_CNTL,
> EXCP_REPLACE, trap_override);
> +
> +     return data;
> +}
> +
> +#define TCP_WATCH_STRIDE (regTCP_WATCH1_ADDR_H -
> regTCP_WATCH0_ADDR_H)
> +static uint32_t kgd_gfx_v9_4_3_set_address_watch(
> +                             struct amdgpu_device *adev,
> +                             uint64_t watch_address,
> +                             uint32_t watch_address_mask,
> +                             uint32_t watch_id,
> +                             uint32_t watch_mode,
> +                             uint32_t debug_vmid)
> +{
> +     uint32_t watch_address_high;
> +     uint32_t watch_address_low;
> +     uint32_t watch_address_cntl;
> +
> +     watch_address_cntl =3D 0;
> +     watch_address_low =3D lower_32_bits(watch_address);
> +     watch_address_high =3D upper_32_bits(watch_address) & 0xffff;
> +
> +     watch_address_cntl =3D REG_SET_FIELD(watch_address_cntl,
> +                     TCP_WATCH0_CNTL,
> +                     MODE,
> +                     watch_mode);
> +
> +     watch_address_cntl =3D REG_SET_FIELD(watch_address_cntl,
> +                     TCP_WATCH0_CNTL,
> +                     MASK,
> +                     watch_address_mask >> 7);
> +
> +     watch_address_cntl =3D REG_SET_FIELD(watch_address_cntl,
> +                     TCP_WATCH0_CNTL,
> +                     VALID,
> +                     1);
> +
> +     WREG32_RLC((SOC15_REG_OFFSET(GC, 0, regTCP_WATCH0_ADDR_H)
> +
> +                     (watch_id * TCP_WATCH_STRIDE)),
> +                     watch_address_high);
> +
> +     WREG32_RLC((SOC15_REG_OFFSET(GC, 0, regTCP_WATCH0_ADDR_L)
> +
> +                     (watch_id * TCP_WATCH_STRIDE)),
> +                     watch_address_low);
> +
> +     return watch_address_cntl;
> +}
> +
> +static uint32_t kgd_gfx_v9_4_3_clear_address_watch(struct amdgpu_device
> *adev,
> +                             uint32_t watch_id)
> +{
> +     return 0;
> +}
> +
>  const struct kfd2kgd_calls gc_9_4_3_kfd2kgd =3D {
>       .program_sh_mem_settings =3D
> kgd_gfx_v9_program_sh_mem_settings,
>       .set_pasid_vmid_mapping =3D
> kgd_gfx_v9_4_3_set_pasid_vmid_mapping,
> @@ -380,5 +515,14 @@ const struct kfd2kgd_calls gc_9_4_3_kfd2kgd =3D {
>       .set_vm_context_page_table_base =3D
>
>       kgd_gfx_v9_set_vm_context_page_table_base,
>       .program_trap_handler_settings =3D
> -                             kgd_gfx_v9_program_trap_handler_settings
> +                             kgd_gfx_v9_program_trap_handler_settings,

What happened to setting up the custom grace period?
That should still be a requirement for the debugger.

Thanks,

Jon

> +     .enable_debug_trap =3D kgd_aldebaran_enable_debug_trap,
> +     .disable_debug_trap =3D kgd_aldebaran_disable_debug_trap,
> +     .validate_trap_override_request =3D
> +                     kgd_gfx_v9_4_3_validate_trap_override_request,
> +     .set_wave_launch_trap_override =3D
> +                     kgd_gfx_v9_4_3_set_wave_launch_trap_override,
> +     .set_wave_launch_mode =3D kgd_aldebaran_set_wave_launch_mode,
> +     .set_address_watch =3D kgd_gfx_v9_4_3_set_address_watch,
> +     .clear_address_watch =3D kgd_gfx_v9_4_3_clear_address_watch
>  };
> --
> 2.34.1

