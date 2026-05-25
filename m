Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27BB3CD5BC9
	for <amd-gfx@archiver.kernel.org>; Mon, 25 May 2026 14:23:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA98810E112;
	Mon, 25 May 2026 14:23:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cWCSYO/s";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010047.outbound.protection.outlook.com [52.101.46.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 480B910E112
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 May 2026 14:23:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MLcoHTg8ksjlDT4AgrsDUbopUHZadR6e7yzGkUFBy4m6mj0OQMQpPB96juwt55EUir3Fw+Ak38kqGfD+UaIDoiKWfmurHIdowtRCPB7meYmZ5KVmtYD3n8DVYOJo9SESfUue9nkFuGT/0jQqNC48rHayWv/A8F0PYTqfymiswuiGiKjG6TO+Te5V2OxY+RrFJ4lZHu9qZ5/hs7ap7JMSFq252/2S6nQyE2zQ0EXxmV22l4//QW5omIpg9F6BZmEFvvLgoLOJX3gSgQ88FxylQMyOboRInuDz5alQFj19nbDhfeVEitB2FDVBpyZj54ze78zzYF4+o2DKp0a1e3uXog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PgakHbfzoJizBceqRPM6mM4sDy8lKdeoEZhRVhivkUY=;
 b=Jb6+QQQrDw7/hafzbcBBVsYjpr1leauwRH09WUkvSeMd+hC3kVz4yP0itBCHIfNfFIHgkL6di0vZc/tWSBnpIW/5cN5XoT8Ix2NETQfrnHXus88k5lOpLmeXBAi/tlkwA1ipWMvUC9vcaBCXWJNbmkS2K4lid7GRJKW6gBCZ1Z59Qch/lxSqAq1lB0pYt8L55d/RvI5RpS5d1ttmfOHXqtAP5B1Qtr7/zO8Ls98vOxqjGXQbSOqHCSzxvEK6xDgwSCwvQQ1jfDhwuRdkzhsYZCdFiibZ+YK8tW9Oo2tU6M4wMC9d1Y94yzGd61VwW7XmoZhZ7IZUOFflnwWz0EfJ9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PgakHbfzoJizBceqRPM6mM4sDy8lKdeoEZhRVhivkUY=;
 b=cWCSYO/sJumpIHV4w6bLGSrP5eAvAzSmSnVr8wPsNfrM5Sg0x0Rz3ErhvjgI73L5+aG77bHwW1WfsVCDGFeXdQPOcW8m9xbeEj5afZdWgu/psQz2PSYFGHyKr9b8O0riy8mqJpIhU5ZEkmryqRdY9Y+BnjOr2PeSVemaTBJANgs=
Received: from BL1PR12MB5898.namprd12.prod.outlook.com (2603:10b6:208:396::7)
 by LV2PR12MB5917.namprd12.prod.outlook.com (2603:10b6:408:175::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Mon, 25 May
 2026 14:23:45 +0000
Received: from BL1PR12MB5898.namprd12.prod.outlook.com
 ([fe80::914d:6a80:1477:4ed0]) by BL1PR12MB5898.namprd12.prod.outlook.com
 ([fe80::914d:6a80:1477:4ed0%5]) with mapi id 15.21.0048.019; Mon, 25 May 2026
 14:23:45 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: "Zhang, Yifan" <Yifan1.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Yat Sin, David" <David.YatSin@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>
Subject: RE: [PATCH v4] drm/amdgpu: add ioctl to handle RAS poison error
Thread-Topic: [PATCH v4] drm/amdgpu: add ioctl to handle RAS poison error
Thread-Index: AQHc6QD07OfZGCYi5U+/LzIr//qNQ7YdC+GAgAHGKPA=
Date: Mon, 25 May 2026 14:23:45 +0000
Message-ID: <BL1PR12MB5898EE3BD319F4BBF204ABE9850A2@BL1PR12MB5898.namprd12.prod.outlook.com>
References: <20260521090445.2292040-1-yifan1.zhang@amd.com>
 <IA1PR12MB6356564293C123C66AF6EB6CC10D2@IA1PR12MB6356.namprd12.prod.outlook.com>
In-Reply-To: <IA1PR12MB6356564293C123C66AF6EB6CC10D2@IA1PR12MB6356.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-05-24T11:17:20.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5898:EE_|LV2PR12MB5917:EE_
x-ms-office365-filtering-correlation-id: 1ab932bb-0572-4af5-36ca-08deba693ab2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|18002099003|38070700021|3023799007|6133799003|11063799006|4143699003|22082099003|56012099003;
x-microsoft-antispam-message-info: 421Q0oMWRBXnLYpSm6xm2k5oaOlcYwg5xFIEFgYV5eLjrWdL57luNN0IUDdwTutzDuLO/HwwQnpqlMKaWssbgHPh5ADTaSB4Q5RBGnZsFFR9/0icE0lI1IqcXhIuvZBTmxmbzwlmSjShRlWiF4bp94mkK7+rBg0TnOgIFxfLMOuuhPtuDX7Mn2YZ8LUxyyLaApvC972k4JGo190S5JbN9AqKw7ymCN3HtpWgFsnBxjzS1OcoGpCZX33N9iSBskdVTq9zctku4T3GzpNu2YIbI3/C9riJrkBY2Q2YFZLUyGRQAtTGZ3K+bnFioRHqETrLJAwvj4GW4aL64yar0nT1EBdXxct/jEmdv9Qb2tQzKJDf70f06SvY/C3HkV+tdl/Klz2vpXOBLKaBIijlkzxfG8YbeYDHdHsoMD8jdkMTjOfC9Mgv+F5V9opamEUFe48ZKQV0aPRtOpKjaHJuY+vnRdw8u5xPNeWeC5bMboJTY49hSk9Q4g8hSdqR54ck6FX26L+EQaiSSN/5aw8Ctrih83qZbHbTu4X/dB+rrDfhMH8xRKE7Ndb7ywRYltgNuad551KePzVsPS74wmKDCOeGYqj6ippvGqCZnwFF2BeAj/rlnzAOX0SZA4d8ykYTFjznwcIRCTEA0tx03uncTCh+rZE6ocC9wjbjfV2aLhVkOWOXHPXT+S8oODEHrH+jqRdlJnIw+CDEQ9kQA/PKWp0xnaglbZYqu4i1qmv7yc7HvK/q7cKOYf+JJtba5BJ9i5Tl
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5898.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(18002099003)(38070700021)(3023799007)(6133799003)(11063799006)(4143699003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?b6Z9ESsIJ6r0upNockO7Ug1Ie+kWZWzCIz59GH8HhcPv9HY3fItgcSwwHcgN?=
 =?us-ascii?Q?7uxpEhZLoNz4MIZC9kPTU64zYFxzrBD4BYPH7F7XLERFM9UvJuOFsyOsAjMD?=
 =?us-ascii?Q?50drWutE5qgvr5MCActKD0Ua+Te0ahOuOUQuHGePpo66wJRJb92ly8EiWgtQ?=
 =?us-ascii?Q?J8Dkt5PB/4K2q44pALQ2J7FELkBRtNwrBrwA3H7CA9clsq/tta61nxlXTseL?=
 =?us-ascii?Q?YOR6AMGpShybka8ZBYWBLc7XEgiyX+S7Ha/z8KU7RxgHtD8/bD7EbxAPDPzu?=
 =?us-ascii?Q?pE8Y+Or58PLgIWZdCJ4bBU55beGw6qN1v4+t8rxM9KATrUZwT2rLfhkQhVM4?=
 =?us-ascii?Q?OGz7yOTDjkDtVJdLVllAkgH0l8BfJqeHSWQ/rJMvx5eRqFBwIMNQ7ibuR7xR?=
 =?us-ascii?Q?APMVxhPMahSVJvNZvwTOFGMsf6BN1LDVbmNHJfeFNfitRxuiJ6bzA7koj+vP?=
 =?us-ascii?Q?1R5x4z7l9zX7TeI0RyzIzmfdLsmbMubcm6FJ4BbWgNJpdY9r1pELBzwVLrWw?=
 =?us-ascii?Q?TQh3TWB7YIxo2Hy7xOUJqflZphon8cDbHvrE/cg98AT1j2bNbbkNLr2fCNw8?=
 =?us-ascii?Q?PRWV5C6yey/BpeYfO2S+OHNhrI9fRQ3azIq9R4XByxmasgA37+7Vyr2m0xk+?=
 =?us-ascii?Q?S7mw0I8SFDi1QPrjn4yF3DYrxhqZ+qCXQm1S571jxjoQ/Oej54/Y2pjRAIlP?=
 =?us-ascii?Q?mURUDMX6gUouoW6GsFc+Us7yHHKYgQffsQfCZE45L0H9ATKt2EPbya+3YOLU?=
 =?us-ascii?Q?/3CnpoxFF10Sfh/g5s06f1UQ+4IhT6wAeRt3zBS0p1XvNQX46vCTQB9RzIcn?=
 =?us-ascii?Q?uY4b0weTRjXXtP9nH6acMf43HjdV6pBw3bfIu/PjPNY3bV2cfYNRuoaZeSqq?=
 =?us-ascii?Q?4ebt+IReXEcJAUi6zUvQgR8C/nCJWKYAoRJpgKpxx3C/jXcN8TZScoxwnSKz?=
 =?us-ascii?Q?saGKylv31uO/Xzp6vIf32+L2wzaFs33nDgVBJfKL0nfrooeChrutRCAetth6?=
 =?us-ascii?Q?5P21g8HihLAJIpfTwlHyJLW7VnhvM121GWeNCTNe9kqmaNEMxY3v3pa+HQrQ?=
 =?us-ascii?Q?YvFDv4NNuXdwSONwiNVjeISgpysJrjtmsmdnTNf83PT7Ywyhowbto4yvvI5b?=
 =?us-ascii?Q?c31jWgPLfxi61HquUCMHYhjZcmir7XUX80325RIgC24Buswima94hIgBkmQl?=
 =?us-ascii?Q?XonuCOmKotMLUegXe0KDjkW2RhLSbCxJa/I677TObD6nGHlMA3cJD/yi1cyy?=
 =?us-ascii?Q?eFtsLX1PsZm/0p+xhBzjm55abiSvzzei8x6qIUR9TgR/qhMIAsnNS7b1VJnL?=
 =?us-ascii?Q?dJzTDVNQYKd9iJxt7PEuUiUaa6niq+A0GQHgREFtkK9L3JrP/JYmvGwTmZxn?=
 =?us-ascii?Q?dYMxJD6AJWCiuJp4cHaZ4mHztyowoHuRnOQxwu+My/7Q4Eb/gRe4SFZkO6LA?=
 =?us-ascii?Q?6LbexALZCdMO4JdDB58m5bp5Tpvx8oKGtfr7lv21v364aJJxlo8Ov+1FTkn7?=
 =?us-ascii?Q?8FzZzC2ZMWw/33MvfxZe+fis8Kpmnc5mMVvT3D8lTFy36PJhwwalOWuYsnPG?=
 =?us-ascii?Q?JW7pM6KxH7MNAiJIzBr9xeXb8FhT17elI5HL9FF5DbIat037yrNiv+9IsPNP?=
 =?us-ascii?Q?nwV3bKsnPqeHsFx+KmsuZdFBH9ZUGuOUy4o/dv7QqtdQb+VBvD16PnxcgdMH?=
 =?us-ascii?Q?MoSLCPc+j/lER7jJpjNt4x1UFblr0Tsa/GHZL+yxVti8Kpzt?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5898.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ab932bb-0572-4af5-36ca-08deba693ab2
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2026 14:23:45.1698 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: awlLfnb61dQrnXBV7v/9+ecU5OOjhdeja2F9HqZFT1HhMygWrziAsxvp/9mvm7z2r19grjWAQWv+LkuRJhdTRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5917
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

Seems fine to me. Will wait for Lijo and David to chime in on their v2/v3 c=
hange requests before I give a Reviewed-By

 Kent

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Zhang,
> Yifan
> Sent: May 24, 2026 7:18 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Yat Sin, David <David.YatSin@amd.com>; Lazar,
> Lijo <Lijo.Lazar@amd.com>
> Subject: RE: [PATCH v4] drm/amdgpu: add ioctl to handle RAS poison error
>
> AMD General
>
> ping
>
> -----Original Message-----
> From: Zhang, Yifan <Yifan1.Zhang@amd.com>
> Sent: Thursday, May 21, 2026 5:05 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Yat Sin, David <David.YatSin@amd.com>; Lazar,
> Lijo <Lijo.Lazar@amd.com>; Zhang, Yifan <Yifan1.Zhang@amd.com>
> Subject: [PATCH v4] drm/amdgpu: add ioctl to handle RAS poison error
>
> Add a new DRM_IOCTL_AMDGPU_USER_OPTIONS ioctl with the
> AMDGPU_USER_OPTIONS_OP_KFD_SIGBUS_DELAY option, allowing userspace
> (ROCr) to control per-process SIGBUS delivery.
>
> Userspace for this can be found at:
> https://github.com/ROCm/rocm-systems/pull/6190
>
> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  2 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h |  6 ++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c    | 27 +++++++++
>  drivers/gpu/drm/amd/amdkfd/kfd_events.c    | 70 +++++++++++++++++++++-
>  drivers/gpu/drm/amd/amdkfd/kfd_priv.h      | 14 +++++
>  drivers/gpu/drm/amd/amdkfd/kfd_process.c   | 23 +++++++
>  include/uapi/drm/amdgpu_drm.h              | 21 +++++++
>  8 files changed, 163 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 5d7bfa59424a..771ec0608270 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -1467,6 +1467,8 @@ int amdgpu_enable_vblank_kms(struct drm_crtc
> *crtc);  void amdgpu_disable_vblank_kms(struct drm_crtc *crtc);  int
> amdgpu_info_ioctl(struct drm_device *dev, void *data,
>                       struct drm_file *filp);
> +int amdgpu_user_options_ioctl(struct drm_device *dev, void *data,
> +                             struct drm_file *filp);
>
>  /*
>   * functions used by amdgpu_encoder.c
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> index 5333e052d56d..68d83a6e6b3a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> @@ -210,6 +210,7 @@ int amdgpu_amdkfd_evict_userptr(struct
> mmu_interval_notifier *mni,  int amdgpu_amdkfd_bo_validate_and_fence(stru=
ct
> amdgpu_bo *bo,
>                                         uint32_t domain,
>                                         struct dma_fence *fence);
> +int amdgpu_amdkfd_set_sigbus_delay(struct task_struct *task, u32 ms);
>  #else
>  static inline
>  bool amdkfd_fence_check_mm(struct dma_fence *f, struct mm_struct *mm)
> @@ -241,6 +242,11 @@ int amdgpu_amdkfd_bo_validate_and_fence(struct
> amdgpu_bo *bo,  {
>         return 0;
>  }
> +static inline
> +int amdgpu_amdkfd_set_sigbus_delay(struct task_struct *task, u32 ms) {
> +       return -EOPNOTSUPP;
> +}
>  #endif
>  /* Shared API */
>  int amdgpu_amdkfd_alloc_kernel_mem(struct amdgpu_device *adev, size_t si=
ze,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 1781c0c3d010..4d4d21babc61 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -3076,6 +3076,7 @@ const struct drm_ioctl_desc amdgpu_ioctls_kms[] =3D=
 {
>         DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_SIGNAL,
> amdgpu_userq_signal_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
>         DRM_IOCTL_DEF_DRV(AMDGPU_USERQ_WAIT, amdgpu_userq_wait_ioctl,
> DRM_AUTH|DRM_RENDER_ALLOW),
>         DRM_IOCTL_DEF_DRV(AMDGPU_GEM_LIST_HANDLES,
> amdgpu_gem_list_handles_ioctl, DRM_AUTH|DRM_RENDER_ALLOW),
> +       DRM_IOCTL_DEF_DRV(AMDGPU_USER_OPTIONS,
> amdgpu_user_options_ioctl,
> +DRM_AUTH|DRM_RENDER_ALLOW),
>  };
>
>  static const struct drm_driver amdgpu_kms_driver =3D { diff --git
> a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index 24526e92f9b8..772e0fda7e14 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -1423,6 +1423,33 @@ int amdgpu_info_ioctl(struct drm_device *dev, void
> *data, struct drm_file *filp)
>         return 0;
>  }
>
> +/**
> + * amdgpu_user_options_ioctl - set per-fd user options
> + *
> + * @dev: drm dev pointer
> + * @data: pointer to struct drm_amdgpu_user_options
> + * @filp: drm file
> + *
> + * Sets options stored on the per-file amdgpu_fpriv. Currently the only
> + * supported option is %AMDGPU_USER_OPTIONS_OP_KFD_SIGBUS_DELAY
> which
> + * controls how KFD delivers SIGBUS for poison/RAS events to the
> +calling
> + * process (immediate, suppressed, or delayed by N milliseconds).
> + */
> +int amdgpu_user_options_ioctl(struct drm_device *dev, void *data,
> +                             struct drm_file *filp)
> +{
> +       struct drm_amdgpu_user_options *args =3D data;
> +
> +       switch (args->op) {
> +       case AMDGPU_USER_OPTIONS_OP_KFD_SIGBUS_DELAY:
> +               return amdgpu_amdkfd_set_sigbus_delay(current,
> +                                                     args->kfd_sigbus_de=
lay.value);
> +       default:
> +               DRM_DEBUG_KMS("Invalid user option op %u\n", args->op);
> +               return -EINVAL;
> +       }
> +}
> +
>  /**
>   * amdgpu_driver_open_kms - drm callback for open
>   *
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> index e9be798c0a2b..e7d70e3a7f3e 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> @@ -29,10 +29,12 @@
>  #include <linux/uaccess.h>
>  #include <linux/mman.h>
>  #include <linux/memory.h>
> +#include <linux/workqueue.h>
>  #include "kfd_priv.h"
>  #include "kfd_events.h"
>  #include "kfd_device_queue_manager.h"
>  #include <linux/device.h>
> +#include <uapi/drm/amdgpu_drm.h>
>
>  /*
>   * Wrapper around wait_queue_entry_t
> @@ -1337,6 +1339,72 @@ void kfd_signal_reset_event(struct kfd_node *dev)
>         srcu_read_unlock(&kfd_processes_srcu, idx);  }
>
> +/*
> + * Per-process opt-in for poison-consumption SIGBUS handling.
> + *
> + * Default: kernel sends SIGBUS to the process immediately when poison
> +is
> + * consumed, in addition to delivering the KFD HW/MEMORY exception event=
s.
> + *
> + * Userspace (ROCr) can opt-in per-process via the
> + * DRM_IOCTL_AMDGPU_USER_OPTIONS /
> +AMDGPU_USER_OPTIONS_OP_KFD_SIGBUS_DELAY
> + * option. This lets the app's registered system-event callback handle
> +the
> + * RAS error first, instead of being killed by SIGBUS.
> + *
> + * Encoded value (stored on the kfd_process):
> + *   0          - default: SIGBUS immediately (no opt-in)
> + *   0xFFFFFFFF - opt-in, never escalate to SIGBUS
> + *   N (other)  - opt-in, escalate to SIGBUS after N ms if app does not
> + *                handle the error in time (safety timeout)
> + */
> +
> +static void kfd_signal_sigbus_delayed_fn(struct work_struct *work) {
> +       struct kfd_process_device *pdd =3D container_of(to_delayed_work(w=
ork),
> +                               struct kfd_process_device, work);
> +       struct kfd_process *p =3D pdd->process;
> +
> +       if (p->lead_thread)
> +               send_sig(SIGBUS, p->lead_thread, 0);
> +
> +       kfd_unref_process(p);
> +}
> +
> +static void kfd_signal_sigbus_with_delay(struct kfd_node *dev,
> +                                        struct kfd_process *p)
> +{
> +       struct kfd_process_device *pdd;
> +       u32 delay_ms =3D atomic_read(&p->kfd_sigbus_delay_ms);
> +
> +       if (delay_ms =3D=3D AMDGPU_USER_OPTIONS_KFD_SIGBUS_DELAY_DISABLED=
)
> {
> +               dev_info(dev->adev->dev,
> +                        "SIGBUS suppressed for process %s(pid:%d): app o=
pted in to handle
> RAS error\n",
> +                        p->lead_thread->comm, p->lead_thread->pid);
> +               return;
> +       }
> +
> +       if (delay_ms =3D=3D 0)
> +               goto send_now;
> +
> +       pdd =3D kfd_get_process_device_data(dev, p);
> +       if (!pdd) {
> +               dev_err(dev->adev->dev, "Process device data doesn't exis=
t\n");
> +               goto send_now;
> +       }
> +
> +       /* Take an extra reference for the delayed worker. */
> +       kref_get(&p->ref);
> +       INIT_DELAYED_WORK(&pdd->work, kfd_signal_sigbus_delayed_fn);
> +
> +       dev_info(dev->adev->dev,
> +                "Deferring SIGBUS to process %s(pid:%d) by %u ms (RAS er=
ror opt-in
> safety timeout)\n",
> +                p->lead_thread->comm, p->lead_thread->pid, delay_ms);
> +       schedule_delayed_work(&pdd->work, msecs_to_jiffies(delay_ms));
> +       return;
> +
> +send_now:
> +       send_sig(SIGBUS, p->lead_thread, 0);
> +}
> +
>  void kfd_signal_poison_consumed_event(struct kfd_node *dev, u32 pasid)  =
{
>         struct kfd_process *p =3D kfd_lookup_process_by_pasid(pasid, NULL=
); @@ -
> 1391,7 +1459,7 @@ void kfd_signal_poison_consumed_event(struct kfd_node
> *dev, u32 pasid)
>         rcu_read_unlock();
>
>         /* user application will handle SIGBUS signal */
> -       send_sig(SIGBUS, p->lead_thread, 0);
> +       kfd_signal_sigbus_with_delay(dev, p);
>
>         kfd_unref_process(p);
>  }
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> index f037062c33ea..d3fcf07c0ebe 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> @@ -875,6 +875,9 @@ struct kfd_process_device {
>         u32 pasid;
>         /* Indicates this process has requested PTL stay disabled */
>         bool ptl_disable_req;
> +
> +       /* Delayed signal to user */
> +       struct delayed_work work;
>  };
>
>  #define qpd_to_pdd(x) container_of(x, struct kfd_process_device, qpd) @@=
 -
> 957,6 +960,17 @@ struct kfd_process {
>         size_t signal_event_count;
>         bool signal_event_limit_reached;
>
> +       /**
> +        * @kfd_sigbus_delay_ms: Per-process KFD SIGBUS delivery option f=
or
> +        * poison/RAS events (set via DRM_IOCTL_AMDGPU_USER_OPTIONS /
> +        * AMDGPU_USER_OPTIONS_OP_KFD_SIGBUS_DELAY).
> +        *
> +        *   0          - send SIGBUS immediately (default)
> +        *   0xFFFFFFFF - suppress SIGBUS delivery
> +        *   other      - delay SIGBUS delivery by this many milliseconds
> +        */
> +       atomic_t kfd_sigbus_delay_ms;
> +
>         /* Information used for memory eviction */
>         void *kgd_process_info;
>         /* Eviction fence that is attached to all the BOs of this process=
. The diff --git
> a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index 419bb8086ccd..dadb7cf7b072 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -992,6 +992,29 @@ struct kfd_process *kfd_create_process(struct
> task_struct *thread)
>         return process;
>  }
>
> +/**
> + * amdgpu_amdkfd_set_sigbus_delay - Set per-process KFD SIGBUS delay
> + * @task: task in the target process
> + * @ms:   encoded delay value (0 =3D immediate, 0xFFFFFFFF =3D suppress,
> + *        otherwise delay in milliseconds)
> + *
> + * Stores the SIGBUS delivery option on the kfd_process associated with
> + * @task. If no kfd_process exists yet, one is created so the option
> + * persists until poison/RAS events are signaled.
> + */
> +int amdgpu_amdkfd_set_sigbus_delay(struct task_struct *task, u32 ms) {
> +       struct kfd_process *p;
> +
> +       p =3D kfd_create_process(task);
> +       if (IS_ERR(p))
> +               return PTR_ERR(p);
> +
> +       atomic_set(&p->kfd_sigbus_delay_ms, ms);
> +       kfd_unref_process(p);
> +       return 0;
> +}
> +
>  static struct kfd_process *find_process_by_mm(const struct mm_struct *mm=
)  {
>         struct kfd_process *process;
> diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.=
h
> index 9f3090db2f16..ab71c4b4aeac 100644
> --- a/include/uapi/drm/amdgpu_drm.h
> +++ b/include/uapi/drm/amdgpu_drm.h
> @@ -58,6 +58,7 @@ extern "C" {
>  #define DRM_AMDGPU_USERQ_SIGNAL                0x17
>  #define DRM_AMDGPU_USERQ_WAIT          0x18
>  #define DRM_AMDGPU_GEM_LIST_HANDLES    0x19
> +#define DRM_AMDGPU_USER_OPTIONS                0x1A
>
>  #define DRM_IOCTL_AMDGPU_GEM_CREATE
> DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_CREATE, union
> drm_amdgpu_gem_create)
>  #define DRM_IOCTL_AMDGPU_GEM_MMAP
> DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_MMAP, union
> drm_amdgpu_gem_mmap)
> @@ -79,6 +80,7 @@ extern "C" {
>  #define DRM_IOCTL_AMDGPU_USERQ_SIGNAL
> DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_SIGNAL, struct
> drm_amdgpu_userq_signal)
>  #define DRM_IOCTL_AMDGPU_USERQ_WAIT
> DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USERQ_WAIT, struct
> drm_amdgpu_userq_wait)
>  #define DRM_IOCTL_AMDGPU_GEM_LIST_HANDLES
> DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_GEM_LIST_HANDLES,
> struct drm_amdgpu_gem_list_handles)
> +#define DRM_IOCTL_AMDGPU_USER_OPTIONS
> DRM_IOWR(DRM_COMMAND_BASE + DRM_AMDGPU_USER_OPTIONS, struct
> drm_amdgpu_user_options)
>
>  /**
>   * DOC: memory domains
> @@ -1673,6 +1675,25 @@ struct drm_amdgpu_info_uq_metadata {
>  #define AMDGPU_FAMILY_GC_11_5_4                        154 /* GC 11.5.4 =
*/
>  #define AMDGPU_FAMILY_GC_12_0_0                        152 /* GC 12.0.0 =
*/
>
> +/*
> + * Definition of user options
> + *
> + * option: AMDGPU_USER_OPTIONS_OP_KFD_SIGBUS_DELAY
> + *    0:          Disable sigbus delay - SIGBUS will be raised immediate=
ly
> + *    0xFFFFFFFF: SIGBUS will not be raised
> + *    other:      Set the sigbus delay in milliseconds
> + */
> +#define AMDGPU_USER_OPTIONS_OP_KFD_SIGBUS_DELAY                0
> +
> +#define AMDGPU_USER_OPTIONS_KFD_SIGBUS_DELAY_DISABLED
> 0xFFFFFFFFu
> +
> +struct drm_amdgpu_user_options {
> +       __u32 op;
> +       struct {
> +               __u32 value;
> +       } kfd_sigbus_delay;
> +};
> +
>  #if defined(__cplusplus)
>  }
>  #endif
> --
> 2.43.0

