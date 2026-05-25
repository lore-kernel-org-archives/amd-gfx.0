Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AF7ACD5BBF
	for <amd-gfx@archiver.kernel.org>; Mon, 25 May 2026 08:18:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD4D010E44E;
	Mon, 25 May 2026 08:18:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="O5siKSYF";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010007.outbound.protection.outlook.com [52.101.46.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E28F10E44E
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 May 2026 08:18:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SNQmRmGnzAsBaVGp2+KmhOLTdP8A/R1pMyGRQhqktN4EvCMPEf6SpFO7gUjRb5EW9gtJ17MmvOrVGpGVRiYQxv1d7bzKLo99svYetIX5gihDEnWcSeg6BWWghXu3qkjvF+ZLcgNLIsx7m+lToJHYk5mQy/XSVjEdHdyqrCHWokEHOM5eKcWQO24e+qODouoOS9X0UTTcJ1/1g7JA+acpOZzQKnRJjgpw73cCAZTP/3rWkf8UjK08bwU4SaiYX1ODfVRNZbXzZ1NApRgBhpWSe+cWZeymQDc6ZjsB8nmb5T0ne/mj8z2M4wYghpXI57Jle4EusJaDKKdidXbkjHsD1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PfQUgF/qWYlUIrjSitRhY9ucNVhmP10+CQr7BKJs6PQ=;
 b=kZkoyg24HVX7RVW1nmpJoYmhxkuZKr40y4ZIo3jO6vy9LHd3auLE6Kl99q1OBvUIW4xD16+m185flQO+HQWLFTg4yS8l1qbsjxfU3N0y6yfRctvjeC/SZUcvG9FA1so6T2ke1adh+H8jf5hwWCHmc9g+SPg9Gc7HgAoBQs+rSd8DxjhZMgh5IboJeBZeVng7YDPzwQ5HTF8rSED6z7nzVmAZfY6AsWG/UOfjNtqz0RGC+IYY1IytV836I+9WYiWS7ssKLwf3i/OIN7Yxfi2tE+42J//wvOBO6nW6JRwLvAValvmgSmFo6gOMbBIN+ib8jA4v6TMjgImXgCk4VizHDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PfQUgF/qWYlUIrjSitRhY9ucNVhmP10+CQr7BKJs6PQ=;
 b=O5siKSYFVMisIXT9O2uIF/V4SwAf64GIgNV8dXd8lyAsMjoV1yQtCbaemQe7VLuEjX8loGQIkRTHW/XTmui0P5dTLWKhYKtusRx5Mhsmpli4d3y6q2gew+04FyVDboPWEsyFhomEjis+DoZkimafTU50rYHPxUrwOZv9ySFBga0=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Mon, 25 May
 2026 08:18:37 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::8874:ea43:ba4a:e73d]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::8874:ea43:ba4a:e73d%5]) with mapi id 15.21.0048.019; Mon, 25 May 2026
 08:18:37 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, "Khatri, Sunil"
 <Sunil.Khatri@amd.com>, "Lin, Amber" <Amber.Lin@amd.com>, "Liu, Shaoyun"
 <Shaoyun.Liu@amd.com>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 37/42] drm/amdgpu/gfx: add a common helper to handle MES
 compute resets
Thread-Topic: [PATCH 37/42] drm/amdgpu/gfx: add a common helper to handle MES
 compute resets
Thread-Index: AQHc6YEVrSqObzSU4kyjG0Uovo8/l7YeaL1g
Date: Mon, 25 May 2026 08:18:37 +0000
Message-ID: <DM4PR12MB5152A80D107241390960382AE30A2@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20260522002048.98506-1-alexander.deucher@amd.com>
 <20260522002048.98506-38-alexander.deucher@amd.com>
In-Reply-To: <20260522002048.98506-38-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-05-25T08:09:57.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|DS0PR12MB6583:EE_
x-ms-office365-filtering-correlation-id: 43a29666-0ffc-411a-b880-08deba363876
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|56012099003|22082099003|18002099003|38070700021|921020|11063799006|4143699003;
x-microsoft-antispam-message-info: kvEmmoaf9ldEpzr4xNbT4DV5abzuKbwdSFgLG7DJIW0a3gZZwGcvHtTKgaS75GQfV1cMzd6w0CxmM7Sq1g6fbMh/c88pdFsTepm46Qiyw0e8ufzmfL6c3aGxr0LmPDH3F8GYBeUHmKbfRLtAooTp73yLIJE8HWlUQcy/qxFWedE+drNGMu+8KgFCduZUuMx/qMz2/YrIyQwqlAODYaRtd3drsafd/BP62yMVF2ktF9DzlI8kO0b+cTBKSHeeegITmlpZtkT1OfkKci1Nqw9VAkxMinIB4bc3DWLB8UnhEu+Ozico5TGs80Bfj8YsOIYr6/3vDsiRcY8UOMOuEWqvBOS6G07r7CW/qOqawa71p/2DeSPiB3hj38Mz8WCYXbIhhvuct5ADtBLNnXjD+Ez0hkchejfOPlb1WDqi6IylGGETPww7lVrCmRxh0QW4uzLzUcGVJXAV6670LWE/eBuwywQrRJUy1uYgZSRqG3xHguKeaP8RTfsAaCpv1HXQmN6FbVRe4XcrJ19sCXP8TUNhR1otRsOrWnzMFDfgKj2ZhlF35Df877d5O2IF4bGM6gSRV74YaI9bo2V3LuGcdYuXVoKy0gFl91RY551gLXVngt9aAmVsSdXFEdMCLE1y+JqM0J0/ztMibL1DiDa+lDytf3cZTeY3AxhwLwHpYVXvY1x1YJZuocA7K9Gi6BqjNBYDAUgbW/RPCCnEEOmj2Gf2xplqfsxyOVrS4UqCws3t9LuJ+zwIWCej6sEShsOq5noWjSJYreEiRgzJdAlrygPgsQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(22082099003)(18002099003)(38070700021)(921020)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Vor0qlGcehZ53lKGwNWnkjBx3MKMAWdyJwF6k+iakQyH85NRA5DBzg+zyZk4?=
 =?us-ascii?Q?+WVJjpqV6MegZPpylH2Izr3puZ+5OUSsb5O8OjrF82NsNcPk3Mp8YuCRJ+jR?=
 =?us-ascii?Q?1Jh0pqpv0qIjQR6huCaQOsCLzMYyA10gsDeZ3BveAWyiQcbIed01YyLdtCSE?=
 =?us-ascii?Q?aODOfrDSd5grDcdPrG+G3nl59izNtKvV4Sy7N9uerh8cWqImgh1oX+iGhbhl?=
 =?us-ascii?Q?jsotJE2olDbom8J/wh4JvKqKsOyuk5n27UHPGBxIY/muYN1vhqDRdE2iB8pB?=
 =?us-ascii?Q?1ZqmGz6fPtX+enCvpSY4fzAEXYXlOuYIvYG4p6SCaj75CmIJg4gi9qH32TN1?=
 =?us-ascii?Q?WRlP/axeE8y7+TnTcAwCnpTWmE3bihPhsJO675GV+YVp4LjYPQnuIY1QaLce?=
 =?us-ascii?Q?kBtIMVNkv+eATzPxYPcAkd+ant6g+Fw+6o+y8K2G3L4rtgFB0U/vk6jZZzNN?=
 =?us-ascii?Q?LsggS9e/C9iaERBIow1o9zCRA8jCfnBmb2uSbhPsfTlJy2UYJMCATnIvS1BS?=
 =?us-ascii?Q?1iIhe2Y8qQ1mDFcdBP/bpDMHgTCNGqKCZlimvsouV7/uRXiPqKRje8FiCsbp?=
 =?us-ascii?Q?P5mPdSkNq28VIzcIrh2FA7i3qqNxVFGFKf/nXdbLxjFvkmWzbCFuazp3vVRC?=
 =?us-ascii?Q?ZcEfInL5oGvWQMMBPirr3NG+5OowBbEriM6UTGhYhoGMWQ6OgTZGiVcsg9uT?=
 =?us-ascii?Q?Xk+GZ2QtoXKscgn8TO59thrW1rDKGYRtrsQ5bQ4Gq0s8Y/KPk8mAjgQYbKjq?=
 =?us-ascii?Q?qwuBDrUimOWbyEtNv/PDBtbOy9UxbChqpW7lYjAmBp+RxZN+3DxZIY8/2XGR?=
 =?us-ascii?Q?DrR7hv9D8OXQiWWZd39oKBJpj+aMF7d7asokysRBuv9JqS0t/680v1tE752Y?=
 =?us-ascii?Q?0QAEDDFLwBegR0Zxi2z1Tlg9H25EGE5YbKrrEYtvWfVs3UTktX80KgM36B0a?=
 =?us-ascii?Q?Gm4QrXhzhFby5Vxt4YI/0qSi0fGDKcZO+1lpdSQlkmIp2pRRgX3YQm4eM9Tn?=
 =?us-ascii?Q?cpxS3nsokCrqiWPzg3TyKZefecIbkFmxd7yxSXGjVrCsjNKJKZxixETGkjjM?=
 =?us-ascii?Q?3VIoruzlN9foHfTn4kVWRSLSn0IjMIcZT5paIjg/wGKjRtroI/wQQxigD2Pr?=
 =?us-ascii?Q?YatpNeu8J7OeFjDYcirvNsmN0iqtHSznJaTqNUaYBew7zBBUL3gQOjtleJ2K?=
 =?us-ascii?Q?/GGnxN3TcgspTsv5O8nnzRqTLupUA1MDPKAuZzPxlBhwvtbqnuKemFDmnknn?=
 =?us-ascii?Q?x6T7LV9fmQG19JK9M1dJyAHAA7sbOI2acfwDAJ7A9CnndCSVmmJYrCcuPboy?=
 =?us-ascii?Q?AoVCU3K076C9wFPz3BPIX7jTTaYOUVxkIGN3RroeU71J7QnqCiBll/y80ZXM?=
 =?us-ascii?Q?IRNco5Vw2nCqC2fgBqWNGviVjQr9d0RIpkKHXu8Hkj05DAw/YzwqDs1HrOk3?=
 =?us-ascii?Q?0CEPigA7AQcmJm0MIyvGuC5O//RavuWA/Iv47QBtEV2nG1sElSgxXVi2Xu6h?=
 =?us-ascii?Q?BbBYEMQRXvBgs7rSSDPfwxjg+6aNeAVS+H/xJgx/hVNQwKuQ4RjH8eqMsp1m?=
 =?us-ascii?Q?QCo7dcgmvHfOEEjiSaJRiIpD8w75wRD/7RfX6urXmcT1hFDAhwILp32JQMkf?=
 =?us-ascii?Q?geq9gvQJztoqnlkDxfzkB9bVUgAr6/f2t2Fbdaf0DSA3Fqza8kYoEE8NtqO+?=
 =?us-ascii?Q?jHboNSlajqI6TI/nU7lDU+9Xk4vpEIYxN8aCEKsUzfL/j5Te?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43a29666-0ffc-411a-b880-08deba363876
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2026 08:18:37.1292 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: spBeN1tarlQzowD0Lw/p0A95VlLKg7Ao8M2XkfhG1GFTBpJiulTF44tuF7F2+10xRr7+RRzkzBoSu2C++xWdBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6583
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
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> Deucher
> Sent: Friday, May 22, 2026 8:21 AM
> To: amd-gfx@lists.freedesktop.org; Koenig, Christian
> <Christian.Koenig@amd.com>; Khatri, Sunil <Sunil.Khatri@amd.com>; Lin, Am=
ber
> <Amber.Lin@amd.com>; Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>; Liu,
> Shaoyun <Shaoyun.Liu@amd.com>
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Jesse(Jie)
> <Jesse.Zhang@amd.com>
> Subject: [PATCH 37/42] drm/amdgpu/gfx: add a common helper to handle MES
> compute resets
>
> Add helpers to handle MES compute queue resets when multiple queues are
> affected.  Can you be used by both KGD and KFD.
>
> v2: sqaush in updates
> v3: squash in userq updates
>
> Co-developed-by: Jesse Zhang <jesse.zhang@amd.com>
> Co-developed-by: Amber Lin <Amber.Lin@amd.com>
> Signed-off-by: Amber Lin <Amber.Lin@amd.com>
> Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 140 +++++++++++++++++++++++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |   9 ++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c |   6 +
>  drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c  |   2 +
>  drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c  |   2 +
>  drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c  |   2 +
>  6 files changed, 160 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index de8c85dfc4c62..960d192076de8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -34,6 +34,7 @@
>  #include "amdgpu_xcp.h"
>  #include "amdgpu_xgmi.h"
>  #include "amdgpu_mes.h"
> +#include "mes_userqueue.h"
>  #include "nvd.h"
>
>  /* delay 0.1 second to enable gfx off feature */ @@ -1976,15 +1977,25 @@=
 int
> amdgpu_gfx_mes_reset_queue(struct amdgpu_ring *ring,
>                              bool use_mmio)
>  {
>       struct amdgpu_device *adev =3D ring->adev;
> +     bool reinit_queue;
>       int r;
>
[Zhang, Jesse(Jie)]  The *_pipe_reset_enable` property is always 0. Should =
set the flag ?

> +     if ((ring->funcs->type =3D=3D AMDGPU_RING_TYPE_COMPUTE) &&
> +         adev->mes.compute_pipe_reset_enabled)
> +             reinit_queue =3D true;
> +     else if ((ring->funcs->type =3D=3D AMDGPU_RING_TYPE_GFX) &&
> +              adev->mes.gfx_pipe_reset_enabled)
> +             reinit_queue =3D true;
> +     else
> +             reinit_queue =3D use_mmio;
> +
>       amdgpu_ring_reset_helper_begin(ring, timedout_fence);
>
>       r =3D amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, use_mmi=
o, 0);
>       if (r)
>               return r;
>
> -     if (use_mmio) {
> +     if (reinit_queue) {
>               r =3D amdgpu_mes_unmap_legacy_queue(adev, ring,
>                                                 RESET_QUEUES, 0, 0, 0);
>               if (r)
> @@ -2159,6 +2170,133 @@ void amdgpu_gfx_sysfs_fini(struct amdgpu_device
> *adev)
>       }
>  }
>
> +static void amdgpu_gfx_reset_start_compute_scheds(struct amdgpu_device
> *adev,
> +                                               struct amdgpu_ring *guilt=
y_ring) {
> +     struct amdgpu_ring *ring;
> +     int i;
> +
> +     for (i =3D 0; i < adev->gfx.num_compute_rings; i++) {
> +             ring =3D &adev->gfx.compute_ring[i];
> +             if (ring =3D=3D guilty_ring)
> +                     continue;
> +             drm_sched_wqueue_start(&ring->sched);
> +     }
> +}
> +
> +static void amdgpu_gfx_reset_stop_compute_scheds(struct amdgpu_device
> *adev,
> +                                              struct amdgpu_ring *guilty=
_ring) {
> +     struct amdgpu_ring *ring;
> +     int i;
> +
> +     for (i =3D 0; i < adev->gfx.num_compute_rings; i++) {
> +             ring =3D &adev->gfx.compute_ring[i];
> +             if (ring =3D=3D guilty_ring)
> +                     continue;
> +             drm_sched_wqueue_stop(&ring->sched);
> +     }
> +}
> +
> +static int amdgpu_gfx_reset_mes_kcq(struct amdgpu_device *adev,
> +                                 struct amdgpu_ring *guilty_ring,
> +                                 unsigned int db)
> +{
> +     bool use_mmio =3D adev->gfx.mec.use_mmio_for_reset;
> +     struct amdgpu_fence *fence;
> +     struct amdgpu_ring *ring;
> +     int i, r;
> +
> +     for (i =3D 0; i < adev->gfx.num_compute_rings; i++) {
> +             ring =3D &adev->gfx.compute_ring[i];
> +             if (ring =3D=3D guilty_ring)
> +                     continue;
> +             if (ring->doorbell_index =3D=3D db) {
> +                     fence =3D amdgpu_ring_find_guilty_fence(ring);
> +                     r =3D amdgpu_gfx_mes_reset_queue(ring, 0, fence,
> use_mmio);
> +                     if (r)
> +                             return r;
> +                     break;
> +             }
> +     }
> +     return 0;
> +}
> +
> +int amdgpu_gfx_reset_mes_compute(struct amdgpu_device *adev,
> +                              struct amdgpu_ring *ring,
> +                              struct amdgpu_fence *guilty_fence,
> +                              struct amdgpu_usermode_queue *uq,
> +                              unsigned int *hung_queue_count)
> +{
> +     struct amdgpu_mes_hung_queue_hqd_info *hqd_info =3D
> +             (struct amdgpu_mes_hung_queue_hqd_info *)
> +             &adev->gfx.mec.mes_hung_db_array[adev-
> >mes.hung_queue_hqd_info_offset];
> +     int i, r, pipe, queue, queue_type;
> +     unsigned int num_hung =3D 0;
> +     bool use_mmio =3D adev->gfx.mec.use_mmio_for_reset;
> +
> +     guard(mutex)(&adev->gfx.mec.reset_mutex);
> +     /* stop the drm schedulers for all compute queues */
> +     amdgpu_gfx_reset_stop_compute_scheds(adev, ring);
> +     /* suspend all will determine which queues are hung.
> +      * reset detect will return the array of bad queue doorbells
> +      */
> +     r =3D amdgpu_mes_suspend(adev, 0);
> +     /* if suspend all success, it should no hang queue */
> +     if (!r)
> +             /* always reset the KCQ/userq since we need to signal the f=
ence
> +              * and we could be stuck in a loop which is preemptable.
> +              */
> +             goto fence_reset;
> +     r =3D amdgpu_mes_detect_and_reset_hung_queues(adev,
> AMDGPU_RING_TYPE_COMPUTE,
> +                                                 true, &num_hung, adev-
> >gfx.mec.mes_hung_db_array, 0);
> +     if (r)
> +             goto out;
> +     if (hung_queue_count)
> +             *hung_queue_count =3D num_hung;
> +
> +fence_reset:
> +     /* reset the queue this came from if specified */
> +     if (ring) {
> +             r =3D amdgpu_gfx_mes_reset_queue(ring, 0, guilty_fence, use=
_mmio);
> +             if (r)
> +                     goto out;
> +     }
> +     if (uq) {
> +             r =3D mes_userq_reset(uq);
> +             if (r)
> +                     goto out;
> +     }
> +     for (i =3D 0; i < num_hung; i++) {
> +             pipe =3D hqd_info[i].pipe_index;
> +             queue =3D hqd_info[i].queue_index;
> +             queue_type =3D hqd_info[i].queue_type;
> +
> +             /* reset any KCQs */
> +             r =3D amdgpu_gfx_reset_mes_kcq(adev, ring,
> +                                          adev->gfx.mec.mes_hung_db_arra=
y[i]);
> +             if (r)
> +                     goto out;
> +             /* reset any KFD queues */
> +             r =3D amdgpu_amdkfd_reset_mes_queue(adev, 0, queue_type, pi=
pe,
> queue,
> +                                               adev-
> >gfx.mec.mes_hung_db_array[i]);
> +             if (r)
> +                     goto out;
> +             /* reset KGD user queues */
> +             r =3D mes_userq_reset_queue(adev, uq, queue_type, pipe, que=
ue,
> +                                       adev->gfx.mec.mes_hung_db_array[i=
]);
> +             if (r)
> +                     goto out;
> +     }
> +out:
> +     /* resume all will enable the non-hung queues */
> +     amdgpu_mes_resume(adev, 0);
> +     if (!r)
> +             amdgpu_gfx_reset_start_compute_scheds(adev, ring);
> +
> +     return r;
> +}
> +
>  int amdgpu_gfx_cleaner_shader_sw_init(struct amdgpu_device *adev,
>                                     unsigned int cleaner_shader_size)  { =
diff --git
> a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> index f9175faa64ab7..8ef2ef394e9af 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> @@ -36,6 +36,8 @@
>  #include "amdgpu_ring_mux.h"
>  #include "amdgpu_xcp.h"
>
> +struct amdgpu_usermode_queue;
> +
>  /* GFX current status */
>  #define AMDGPU_GFX_NORMAL_MODE                       0x00000000L
>  #define AMDGPU_GFX_SAFE_MODE                 0x00000001L
> @@ -117,6 +119,8 @@ struct amdgpu_mec {
>       u32 num_queue_per_pipe;
>       void                    *mqd_backup[AMDGPU_MAX_COMPUTE_RINGS *
> AMDGPU_MAX_GC_INSTANCES];
>       bool use_mmio_for_reset;
> +     u32 *mes_hung_db_array;
> +     struct mutex            reset_mutex;
>  };
>
>  struct amdgpu_mec_bitmap {
> @@ -642,6 +646,11 @@ int amdgpu_gfx_poison_consumption_handler(struct
> amdgpu_device *adev,  bool amdgpu_gfx_is_master_xcc(struct amdgpu_device
> *adev, int xcc_id);  int amdgpu_gfx_sysfs_init(struct amdgpu_device *adev=
);  void
> amdgpu_gfx_sysfs_fini(struct amdgpu_device *adev);
> +int amdgpu_gfx_reset_mes_compute(struct amdgpu_device *adev,
> +                              struct amdgpu_ring *ring,
> +                              struct amdgpu_fence *guilty_fence,
> +                              struct amdgpu_usermode_queue *uq,
> +                              unsigned int *hung_queue_count);
>  void amdgpu_gfx_ras_error_func(struct amdgpu_device *adev,
>               void *ras_error_status,
>               void (*func)(struct amdgpu_device *adev, void *ras_error_st=
atus, diff
> --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> index 370e8d159b6fe..ec4d9a1e029a7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> @@ -252,6 +252,10 @@ int amdgpu_mes_init(struct amdgpu_device *adev)
>               }
>       }
>
> +     adev->gfx.mec.mes_hung_db_array =3D
> +             kcalloc(amdgpu_mes_get_hung_queue_db_array_size(adev),
> +                     sizeof(u32), GFP_KERNEL);
> +
>       return 0;
>
>  error_doorbell:
> @@ -279,6 +283,8 @@ void amdgpu_mes_fini(struct amdgpu_device *adev)
>       int i;
>       int num_xcc =3D adev->gfx.xcc_mask ? NUM_XCC(adev->gfx.xcc_mask) :
> 1;
>
> +     kfree(adev->gfx.mec.mes_hung_db_array);
> +
>       amdgpu_bo_free_kernel(&adev->mes.event_log_gpu_obj,
>                             &adev->mes.event_log_gpu_addr,
>                             &adev->mes.event_log_cpu_addr); diff --git
> a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> index 1a214c274ad02..32e01eb311c3b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
> @@ -1908,6 +1908,8 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_block
> *ip_block)
>       adev->gfx.me.use_mmio_for_reset =3D false;
>       adev->gfx.mec.use_mmio_for_reset =3D true;
>
> +     mutex_init(&adev->gfx.mec.reset_mutex);
> +
>       return 0;
>  }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> index 5beb0ae980d0b..247bcb7034e19 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
> @@ -1606,6 +1606,8 @@ static int gfx_v12_0_sw_init(struct amdgpu_ip_block
> *ip_block)
>       adev->gfx.me.use_mmio_for_reset =3D false;
>       adev->gfx.mec.use_mmio_for_reset =3D true;
>
> +     mutex_init(&adev->gfx.mec.reset_mutex);
> +
>       return 0;
>  }
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
> index 033f15e21ad33..7f8e43130bd28 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
> @@ -1287,6 +1287,8 @@ static int gfx_v12_1_sw_init(struct amdgpu_ip_block
> *ip_block)
>       if (r)
>               return r;
>
> +     mutex_init(&adev->gfx.mec.reset_mutex);
> +
>       return 0;
>  }
>
> --
> 2.54.0

