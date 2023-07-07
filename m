Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87EF9EB64DA
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Jul 2023 14:37:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2683310E5A4;
	Fri,  7 Jul 2023 14:37:25 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2040.outbound.protection.outlook.com [40.107.100.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8347A10E5A4
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Jul 2023 14:37:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oc0kCbpcbEVeRIooRCQsh/8zyw6YWoalGhSDBft2mda/4osdiNjrUVT3D7OIi4FsgHaKdq8TwaM4Vo1G1ZbZtfTlTckxdxlEAeCXusGKGNc+0I32WXIvI75sjORfZWUc2hdBRBS0ScKxKN0iOnHDsgVD3erxUE6ny0bh+eGlya6O6NjqTQMucAU831dTV+jhwX+ntODm2ug/5n4jl3J06bT3XvfYMXDl4kExQNFd9+IMs/NYTam0xiIFJec8kqdJxWSKpwj/tDZS6QPNShDMSH3ev+opc7CIV2AzNc6hIFHVzDWRepNOZ94HOQ4CU9l6XFnAK8DtMm+xhkUVbLajyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6FCfveyBtAivqBBMTt87ec4I+o53QtbJNoT7EckxT1A=;
 b=V+Re8PE39OD806xSOUcFaUOj1LdmUIhCgW/aHlh+XMzqX25o3Kr5jnrYXjZbL28UTOcdmdmwCbSZw2IR866HLBmIoVFZsMNtKnkKHv3hZiCnSiZWpprCO3XVwCKfikuQWXGhUhFnIvE7NaOqm6CKnHPoBzh00wAzzlkIzpcamSgZ5yxKxGL9e92SgJacv4Szxq3b15j54SZ7hZNJMuKkBrq9Q3dcWmIF/asZm4I7Sv6zCD+sM/oI6FCFkuCX3UC8rKERBzNuqCcRz/KU3nmKfiya47bDC1lxSMh/M3IMTLzb76VqgIYXNWJRkmfAUS/Rq5HfIVha2ezuWRSMrStMVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6FCfveyBtAivqBBMTt87ec4I+o53QtbJNoT7EckxT1A=;
 b=uHOPK2RlyPnNA+xZRezhS2s3ByhNmYoOD8m6oBmtgzbGlIJyE5YLyVoc/nP1uXpOFIrZYmrBKlYbGARSi5My5y2smCHQCKMIsS9Ms+bJgShkBrMtv8kwopbGrZNJ8WjlH/owE95pFS7Bu1gCcSVsi4M1jEqYndiLZSNVJKcoq8Y=
Received: from CY8PR12MB7435.namprd12.prod.outlook.com (2603:10b6:930:51::6)
 by PH7PR12MB6956.namprd12.prod.outlook.com (2603:10b6:510:1b9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.25; Fri, 7 Jul
 2023 14:37:15 +0000
Received: from CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::100e:1d82:bd2a:e05e]) by CY8PR12MB7435.namprd12.prod.outlook.com
 ([fe80::100e:1d82:bd2a:e05e%3]) with mapi id 15.20.6565.025; Fri, 7 Jul 2023
 14:37:15 +0000
From: "Kim, Jonathan" <Jonathan.Kim@amd.com>
To: "Huang, JinHuiEric" <JinHuiEric.Huang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/6] drm/amdkfd: add kfd2kgd debugger callbacks for GC
 v9.4.3
Thread-Topic: [PATCH 1/6] drm/amdkfd: add kfd2kgd debugger callbacks for GC
 v9.4.3
Thread-Index: AQHZsDZwaQACM0rhm0inM61UAIjgS6+uYDxA
Date: Fri, 7 Jul 2023 14:37:15 +0000
Message-ID: <CY8PR12MB7435343E89498E3CAFEC301A852DA@CY8PR12MB7435.namprd12.prod.outlook.com>
References: <20230706181918.189722-1-jinhuieric.huang@amd.com>
 <20230706181918.189722-2-jinhuieric.huang@amd.com>
In-Reply-To: <20230706181918.189722-2-jinhuieric.huang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=333a560a-6d2e-4d77-9e02-8bfc0a02faaf;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-07-07T14:35:52Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7435:EE_|PH7PR12MB6956:EE_
x-ms-office365-filtering-correlation-id: 0fa85256-c890-4d8d-e422-08db7ef7a8a5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HR7L53jP7TH9Yqf/rqD7cRdsZYUtK1CuaVj7Zff5tywXfNe3SFmJj/w1oSyXZ+2kv3WXAXfJGTaheKR6MznDmyF/DY531Bv6a4m5lCbp5AQPEuH9Yfg7wwDkKaY5wRZWra05jBG4fD0QLhmVoIEOuvO4ujVkzfK0Nn3PKM/u8UW8D3bFr1VjTxxb3+CqPI3bzIbuzOrIwgzjPHyHGyFHIKwB/f8WkIbhD19HKprGKn8aTQfI09LBxSxva3+0A113rZm0ESSnpIa4X5QJRacTlMCkQI3bdtTNu7f0YEqL8F4FmirYhLQk478bsqrkGaOxZd8mhkJJsKYctqlfWLe3CfJDy+AWzJW2fMBscRH/N3VHfhlMCqo0I5rBpHfPuBn7AHjtiyqmoa5YE3q0py6kVKDpE06KlCnMHx3bhH5IOolW37PU0k04T47E5zJNJNW8koAe5bvCc+kg9T/svYkyy+FBEaWDDS+7W0MEW5imdbMoTga9MlsVtk2auIWocdiHnWFZPY8MejXSaLiAU6Gxrj7TIm+uaiZiFxk49KsY7yXJ9vOwrc6Ud85rhkPgs+JTryL6PsT5Jq0ePI3hOQGCkKjjiJG1nLUGBAp6k706IC98iJaZCZnXJC4sJl6BntGg
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR12MB7435.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(366004)(376002)(396003)(346002)(39860400002)(451199021)(52536014)(41300700001)(5660300002)(110136005)(7696005)(55016003)(30864003)(8676002)(8936002)(2906002)(316002)(66899021)(71200400001)(64756008)(66446008)(66476007)(76116006)(66946007)(66556008)(33656002)(9686003)(478600001)(186003)(86362001)(38100700002)(122000001)(83380400001)(53546011)(6506007)(26005)(38070700005)(559001)(579004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KB9/qxHQAH8/d5rfYFw4povxUpRhfwSTRPqYa7y3KFKbKgX03aqGATgT11pz?=
 =?us-ascii?Q?KxeKVwXyLpf4OaxznNMHamUNyAPP+4y0/Es5qgMz5jvxMscy2xYuADZWN+SZ?=
 =?us-ascii?Q?yTq4XWIVOG+4SS8UCWTz+dVZUpQvtAknXe8heogKxYno90h8Mrdiy4oHQPSi?=
 =?us-ascii?Q?2IlPD4wI+XfdctVd5OUhnFfdA15b2XgaBkj6YmaoTHAancElXzA6hgZRZYfC?=
 =?us-ascii?Q?mn8c2xPDMHolECrRPI/IIT7tfiGh6SXRviwUoxonS4gpp7zzqrAAX839bBV/?=
 =?us-ascii?Q?jEa7KEPFILZEgyZVDyvjtJq3jN3M7awtW13TuHatiWZD8JvY2089mEiJpLKc?=
 =?us-ascii?Q?SoIvXWbLpzYnQr13qxmwHNSW1JLzQ2ZDsiHZxP4gA02ZaOGabsGkOs3Yjafm?=
 =?us-ascii?Q?eAZtDu6BCjwSPboZ/kG3S+m/Q5whiBUuHUnDJXewtZ5Lr3qb1ZuQ/lWbRILo?=
 =?us-ascii?Q?GQ5LtpWFHy0l4Bhfz2z45za+Z4wDUuanSxNxsjk8EUBB9uTSAmR0T4j4MCcD?=
 =?us-ascii?Q?zvWje5qhX5idDIxOu+k4XflkH/93D/uGqcnSYmYHh68cPg/OzfHE7drfVx7p?=
 =?us-ascii?Q?YVFBlW1vXt/AaxKDeCUQHQ7cIXLwE4kXqNTL8wTLQzpXU3kEJmZZWJtV5a4Z?=
 =?us-ascii?Q?6E9+LIam88e/w2icfp2tXRlkxAbDgekl+fC3BI7x/KdDbNH2QOH7bSfT/wVY?=
 =?us-ascii?Q?BOOaWzhwqKsohoNwwEVNQSarvMmojyjx/1NuGSGAGipBzgqoBaPoR+WxdRiL?=
 =?us-ascii?Q?jQCHeItRDebBDeDBWlCPE9XgQShLvuriTdSYVFUYvKd1DcTnTMyNyhxRRIvP?=
 =?us-ascii?Q?AD1Ny5QEz/iJ8ODxnLBi5jCC1Utyitgn5vAg5UU/23ePW3DR7pg29aOfZgXf?=
 =?us-ascii?Q?VDM4JroegTWpCQdfvWClSyMMrYHOdF34ft2OpPt5EwO+hL0vLvo6v7zdTAgb?=
 =?us-ascii?Q?4g60wK6PmXYERAZTnvpLlOc0BUEqtODjFGXNkVTVWpJvJ4nCzj5aulCG7oFI?=
 =?us-ascii?Q?UiPvYOCMe3EZuz+hDy/v12Cl6Wq2CwgOMPfQ15airmm25bX+ZwmYsG5QJtvN?=
 =?us-ascii?Q?ov7R0Df3osxiGZ20gd3oWqgtmWcL3VOKY8yet7DTxeGSK4kULaPRZtx1wp29?=
 =?us-ascii?Q?hdSRsNnyWwgNDOwkyx5iKDHM2ASHrdD5IO3VXEnSmQBtjdCHsry08eS1ks/a?=
 =?us-ascii?Q?0xcJuvh1ADtVpLxseSg4h+QqPT4Xwhw0kECS5FAYoryNCjrW+tBTSnco76W8?=
 =?us-ascii?Q?WnxjqXIUtLFCTgqVEgPkWeKGegzEUAPVP82PIIvXJMLkd8gOOck8wN+kYVr/?=
 =?us-ascii?Q?mKYXac5Ywr03VbM7F5XR0CqS346fFI8eRxRSYWrQJxO6uzJZPYDewIQITaR8?=
 =?us-ascii?Q?Rec5b0fzukXNFpfmT/J8Mf8r3EsjVbVcTIC3tzsuM+hwokQ8jJ4eQC+Kdh4s?=
 =?us-ascii?Q?8wXTc4Y8hgHdhDN/Gel22malJ+4sgwTMt7aEvAJHHPYNrT9557y0di19nzAx?=
 =?us-ascii?Q?g69erdWcbftsR+z2Qax7WL3wChnY80Vj3CJYdhOzdR8FAj9HmsGiM4WpGC/E?=
 =?us-ascii?Q?zE7d0fri1YzMFb07VdU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fa85256-c890-4d8d-e422-08db7ef7a8a5
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2023 14:37:15.4405 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UKneyRCDntHU/kQrz3vgPUwSQZwcNV/hphr9b6yUpxiez3f8Coxxply/0XtF3gqV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6956
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

> -----Original Message-----
> From: Huang, JinHuiEric <JinHuiEric.Huang@amd.com>
> Sent: Thursday, July 6, 2023 2:19 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Kim, Jonathan <Jonathan.Kim@amd.com>; Kim, Jonathan
> <Jonathan.Kim@amd.com>; Huang, JinHuiEric <JinHuiEric.Huang@amd.com>
> Subject: [PATCH 1/6] drm/amdkfd: add kfd2kgd debugger callbacks for GC
> v9.4.3
>
> From: Jonathan Kim <jonathan.kim@amd.com>
>
> Implement the similarities as GC v9.4.2, and the difference
> for GC v9.4.3 HW spec, i.e. xcc instance.
>
> Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
> ---
>  .../drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c  |  10 +-
>  .../drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.h  |  30 ++++
>  .../drm/amd/amdgpu/amdgpu_amdkfd_gc_9_4_3.c   | 152
> +++++++++++++++++-
>  .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c    |   9 +-
>  .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h    |  10 +-
>  .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c    |   3 +-
>  .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c |  15 +-
>  .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h |  10 +-
>  drivers/gpu/drm/amd/amdkfd/kfd_debug.c        |   3 +-
>  .../drm/amd/amdkfd/kfd_device_queue_manager.c |   2 +-
>  .../drm/amd/amdkfd/kfd_packet_manager_v9.c    |   3 +-
>  .../gpu/drm/amd/include/kgd_kfd_interface.h   |   9 +-
>  12 files changed, 230 insertions(+), 26 deletions(-)
>  create mode 100644
> drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.h
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.c
> index 60f9e027fb66..7d7eaed68531 100644
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
> @@ -125,7 +126,8 @@ static uint32_t
> kgd_gfx_aldebaran_set_address_watch(
>                                       uint32_t watch_address_mask,
>                                       uint32_t watch_id,
>                                       uint32_t watch_mode,
> -                                     uint32_t debug_vmid)
> +                                     uint32_t debug_vmid,
> +                                     uint32_t inst )
>  {
>       uint32_t watch_address_high;
>       uint32_t watch_address_low;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.h
> new file mode 100644
> index 000000000000..ed349ff397bd
> --- /dev/null
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_aldebaran.h
> @@ -0,0 +1,30 @@
> +/*
> + * Copyright 2023 Advanced Micro Devices, Inc.
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
> index 5b4b7f8b92a5..1880162a4581 100644
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
> @@ -361,6 +363,142 @@ static int kgd_gfx_v9_4_3_hqd_load(struct
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
> +/* returns TRAP_EN, EXCP_EN and EXCP_REPLACE. */
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
> +                             uint32_t debug_vmid,
> +                             uint32_t inst)
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
> +     WREG32_RLC((SOC15_REG_OFFSET(GC, GET_INST(GC, inst),
> +                     regTCP_WATCH0_ADDR_H) +
> +                     (watch_id * TCP_WATCH_STRIDE)),
> +                     watch_address_high);
> +
> +     WREG32_RLC((SOC15_REG_OFFSET(GC, GET_INST(GC, inst),
> +                     regTCP_WATCH0_ADDR_L) +
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
> @@ -380,5 +518,17 @@ const struct kfd2kgd_calls gc_9_4_3_kfd2kgd =3D {
>       .set_vm_context_page_table_base =3D
>
>       kgd_gfx_v9_set_vm_context_page_table_base,
>       .program_trap_handler_settings =3D
> -                             kgd_gfx_v9_program_trap_handler_settings
> +                             kgd_gfx_v9_program_trap_handler_settings,
> +     .build_grace_period_packet_info =3D
> +                             kgd_gfx_v9_build_grace_period_packet_info,
> +     .get_iq_wait_times =3D kgd_gfx_v9_get_iq_wait_times,
> +     .enable_debug_trap =3D kgd_aldebaran_enable_debug_trap,
> +     .disable_debug_trap =3D kgd_aldebaran_disable_debug_trap,

Let's implement disable_debug_trap here instead of referencing GC 9.4.2.
That way we can drop patch 5.

Thanks,

Jon

> +     .validate_trap_override_request =3D
> +                     kgd_gfx_v9_4_3_validate_trap_override_request,
> +     .set_wave_launch_trap_override =3D
> +                     kgd_gfx_v9_4_3_set_wave_launch_trap_override,
> +     .set_wave_launch_mode =3D kgd_aldebaran_set_wave_launch_mode,
> +     .set_address_watch =3D kgd_gfx_v9_4_3_set_address_watch,
> +     .clear_address_watch =3D kgd_gfx_v9_4_3_clear_address_watch
>  };
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
> index 8ad7a7779e14..f1f2c24de081 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
> @@ -886,7 +886,8 @@ uint32_t kgd_gfx_v10_set_address_watch(struct
> amdgpu_device *adev,
>                                       uint32_t watch_address_mask,
>                                       uint32_t watch_id,
>                                       uint32_t watch_mode,
> -                                     uint32_t debug_vmid)
> +                                     uint32_t debug_vmid,
> +                                     uint32_t inst)
>  {
>       uint32_t watch_address_high;
>       uint32_t watch_address_low;
> @@ -968,7 +969,8 @@ uint32_t kgd_gfx_v10_clear_address_watch(struct
> amdgpu_device *adev,
>   *     deq_retry_wait_time      -- Wait Count for Global Wave Syncs.
>   */
>  void kgd_gfx_v10_get_iq_wait_times(struct amdgpu_device *adev,
> -                                     uint32_t *wait_times)
> +                                     uint32_t *wait_times,
> +                                     uint32_t inst)
>
>  {
>       *wait_times =3D RREG32(SOC15_REG_OFFSET(GC, 0,
> mmCP_IQ_WAIT_TIME2));
> @@ -978,7 +980,8 @@ void
> kgd_gfx_v10_build_grace_period_packet_info(struct amdgpu_device *adev,
>                                               uint32_t wait_times,
>                                               uint32_t grace_period,
>                                               uint32_t *reg_offset,
> -                                             uint32_t *reg_data)
> +                                             uint32_t *reg_data,
> +                                             uint32_t inst)
>  {
>       *reg_data =3D wait_times;
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h
> index e6b70196071a..ecaead24e8c9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.h
> @@ -44,12 +44,16 @@ uint32_t kgd_gfx_v10_set_address_watch(struct
> amdgpu_device *adev,
>                                       uint32_t watch_address_mask,
>                                       uint32_t watch_id,
>                                       uint32_t watch_mode,
> -                                     uint32_t debug_vmid);
> +                                     uint32_t debug_vmid,
> +                                     uint32_t inst);
>  uint32_t kgd_gfx_v10_clear_address_watch(struct amdgpu_device *adev,
>                                       uint32_t watch_id);
> -void kgd_gfx_v10_get_iq_wait_times(struct amdgpu_device *adev, uint32_t
> *wait_times);
> +void kgd_gfx_v10_get_iq_wait_times(struct amdgpu_device *adev,
> +                             uint32_t *wait_times,
> +                             uint32_t inst);
>  void kgd_gfx_v10_build_grace_period_packet_info(struct amdgpu_device
> *adev,
>                                              uint32_t wait_times,
>                                              uint32_t grace_period,
>                                              uint32_t *reg_offset,
> -                                            uint32_t *reg_data);
> +                                            uint32_t *reg_data,
> +                                            uint32_t inst);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c
> index 91c3574ebed3..77ca5cbfb601 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c
> @@ -743,7 +743,8 @@ static uint32_t kgd_gfx_v11_set_address_watch(struct
> amdgpu_device *adev,
>                                       uint32_t watch_address_mask,
>                                       uint32_t watch_id,
>                                       uint32_t watch_mode,
> -                                     uint32_t debug_vmid)
> +                                     uint32_t debug_vmid,
> +                                     uint32_t inst)
>  {
>       uint32_t watch_address_high;
>       uint32_t watch_address_low;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> index 51d93fb13ea3..7b1eea493377 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
> @@ -822,7 +822,8 @@ uint32_t kgd_gfx_v9_set_address_watch(struct
> amdgpu_device *adev,
>                                       uint32_t watch_address_mask,
>                                       uint32_t watch_id,
>                                       uint32_t watch_mode,
> -                                     uint32_t debug_vmid)
> +                                     uint32_t debug_vmid,
> +                                     uint32_t inst)
>  {
>       uint32_t watch_address_high;
>       uint32_t watch_address_low;
> @@ -903,10 +904,12 @@ uint32_t kgd_gfx_v9_clear_address_watch(struct
> amdgpu_device *adev,
>   *     deq_retry_wait_time      -- Wait Count for Global Wave Syncs.
>   */
>  void kgd_gfx_v9_get_iq_wait_times(struct amdgpu_device *adev,
> -                                     uint32_t *wait_times)
> +                                     uint32_t *wait_times,
> +                                     uint32_t inst)
>
>  {
> -     *wait_times =3D RREG32(SOC15_REG_OFFSET(GC, 0,
> mmCP_IQ_WAIT_TIME2));
> +     *wait_times =3D RREG32(SOC15_REG_OFFSET(GC, GET_INST(GC, inst),
> +                     mmCP_IQ_WAIT_TIME2));
>  }
>
>  void kgd_gfx_v9_set_vm_context_page_table_base(struct amdgpu_device
> *adev,
> @@ -1100,7 +1103,8 @@ void
> kgd_gfx_v9_build_grace_period_packet_info(struct amdgpu_device *adev,
>               uint32_t wait_times,
>               uint32_t grace_period,
>               uint32_t *reg_offset,
> -             uint32_t *reg_data)
> +             uint32_t *reg_data,
> +             uint32_t inst)
>  {
>       *reg_data =3D wait_times;
>
> @@ -1116,7 +1120,8 @@ void
> kgd_gfx_v9_build_grace_period_packet_info(struct amdgpu_device *adev,
>                       SCH_WAVE,
>                       grace_period);
>
> -     *reg_offset =3D SOC15_REG_OFFSET(GC, 0, mmCP_IQ_WAIT_TIME2);
> +     *reg_offset =3D SOC15_REG_OFFSET(GC, GET_INST(GC, inst),
> +                     mmCP_IQ_WAIT_TIME2);
>  }
>
>  void kgd_gfx_v9_program_trap_handler_settings(struct amdgpu_device
> *adev,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
> index 5f54bff0db49..936e501908ce 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
> @@ -89,12 +89,16 @@ uint32_t kgd_gfx_v9_set_address_watch(struct
> amdgpu_device *adev,
>                                       uint32_t watch_address_mask,
>                                       uint32_t watch_id,
>                                       uint32_t watch_mode,
> -                                     uint32_t debug_vmid);
> +                                     uint32_t debug_vmid,
> +                                     uint32_t inst);
>  uint32_t kgd_gfx_v9_clear_address_watch(struct amdgpu_device *adev,
>                                       uint32_t watch_id);
> -void kgd_gfx_v9_get_iq_wait_times(struct amdgpu_device *adev, uint32_t
> *wait_times);
> +void kgd_gfx_v9_get_iq_wait_times(struct amdgpu_device *adev,
> +                             uint32_t *wait_times,
> +                             uint32_t inst);
>  void kgd_gfx_v9_build_grace_period_packet_info(struct amdgpu_device
> *adev,
>                                              uint32_t wait_times,
>                                              uint32_t grace_period,
>                                              uint32_t *reg_offset,
> -                                            uint32_t *reg_data);
> +                                            uint32_t *reg_data,
> +                                            uint32_t inst);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> index fff3ccc04fa9..24083db44724 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
> @@ -466,7 +466,8 @@ int kfd_dbg_trap_set_dev_address_watch(struct
> kfd_process_device *pdd,
>                               watch_address_mask,
>                               *watch_id,
>                               watch_mode,
> -                             pdd->dev->vm_info.last_vmid_kfd);
> +                             pdd->dev->vm_info.last_vmid_kfd,
> +                             0);
>       amdgpu_gfx_off_ctrl(pdd->dev->adev, true);
>
>       if (!pdd->dev->kfd->shared_resources.enable_mes)
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index f515cb8f30ca..a2bff3f01359 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -1621,7 +1621,7 @@ static int initialize_cpsch(struct
> device_queue_manager *dqm)
>
>       if (dqm->dev->kfd2kgd->get_iq_wait_times)
>               dqm->dev->kfd2kgd->get_iq_wait_times(dqm->dev->adev,
> -                                     &dqm->wait_times);
> +                                     &dqm->wait_times, 0);
>       return 0;
>  }
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
> b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
> index 29a2d0499b67..8fda16e6fee6 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
> @@ -298,7 +298,8 @@ static int pm_set_grace_period_v9(struct
> packet_manager *pm,
>                       pm->dqm->wait_times,
>                       grace_period,
>                       &reg_offset,
> -                     &reg_data);
> +                     &reg_data,
> +                     0);
>
>       if (grace_period =3D=3D USE_DEFAULT_GRACE_PERIOD)
>               reg_data =3D pm->dqm->wait_times;
> diff --git a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
> b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
> index d0df3381539f..8433f99f6667 100644
> --- a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
> +++ b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
> @@ -315,16 +315,19 @@ struct kfd2kgd_calls {
>                                       uint32_t watch_address_mask,
>                                       uint32_t watch_id,
>                                       uint32_t watch_mode,
> -                                     uint32_t debug_vmid);
> +                                     uint32_t debug_vmid,
> +                                     uint32_t inst);
>       uint32_t (*clear_address_watch)(struct amdgpu_device *adev,
>                       uint32_t watch_id);
>       void (*get_iq_wait_times)(struct amdgpu_device *adev,
> -                     uint32_t *wait_times);
> +                     uint32_t *wait_times,
> +                     uint32_t inst);
>       void (*build_grace_period_packet_info)(struct amdgpu_device *adev,
>                       uint32_t wait_times,
>                       uint32_t grace_period,
>                       uint32_t *reg_offset,
> -                     uint32_t *reg_data);
> +                     uint32_t *reg_data,
> +                     uint32_t inst);
>       void (*get_cu_occupancy)(struct amdgpu_device *adev, int pasid,
>                       int *wave_cnt, int *max_waves_per_cu, uint32_t
> inst);
>       void (*program_trap_handler_settings)(struct amdgpu_device *adev,
> --
> 2.34.1

