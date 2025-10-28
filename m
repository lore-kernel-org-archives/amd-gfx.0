Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9D3FCCF9E0
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Oct 2025 04:58:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5527D10E1D1;
	Tue, 28 Oct 2025 04:58:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VWG5Iklr";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013041.outbound.protection.outlook.com
 [40.93.196.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D288210E1D1
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Oct 2025 04:58:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lvmddxRZ2RzwHjLM5vnSALPHjBBisjJ2ZFTR9PPs+oqNJuy8ZUhG4LUcbx05Rm0onqV4C7VeiQiQsuO/8SaDtnrtDlq7LCawExfSZaG/kWORXQNwzYLLbzMRK2FV1iAY1NJ+aVzvAcFfLXRCqYcX6I7/hEDuDQP3qiJRqRoF8dD0sJfss9IZw9K/siPqaAxtkI5Jd5WQG6Pv4+K0QeDIc+BWtJUDk3QZFU4rSr1D8oKmLuEvUtZ06kr94PD3Rb1M9H/BdskjIfIXi2gUiY8BiFkRNyfqxdPJ0WWRsHZFgkscDA7HuEYcneDkAQB19smpIb/e8r7h4qAA+WAM12k38g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ASS+Llb1jC4xpxyfkf6fgLtqbOt0vXfQ2/7W6WAteIY=;
 b=BZXEbYxXmpxyGfnth38OsKna9Epa4hxlKKnMjETYMCAj2VYvBF2gpHY33P9LatjR+HEAjuLXjLMbW99jDMjUqledxe2wV3iLVqyLyzelWWJgJuWnQjb+T8csQqAxPQisLsc/L1g0USGTUOf5H5S3XjtOX5NWN6hNUdwmP23Bn1FxPSWyUChvJSIyZRhZexZ1q92fAnWnBPg2STRCYehS1HxBx3EonAZTy4v1rPcitRApSsLPbqbHInoYLydOtCSXctzdClAiOEehBQQxey5WgDVc0jkfOi1uhZBLpSDwIOMlrNBZYPtcQQEfXk/2cR6j36mDLboQQ+vUGwVYnViaaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ASS+Llb1jC4xpxyfkf6fgLtqbOt0vXfQ2/7W6WAteIY=;
 b=VWG5IklrxSriPlnzymH9FO7xqZ3uY21UpLv9iV3NXbrWjyeaZCn/wvWlgRj+f3QKNv3iK1aRBwe3TiiYWBTlwjJ5wTF1z+bBfaE19DkfKFUXAbTK7DlkpSBWPoPF/DWeE0yoDl8/dvMXCBN5v6WVi+3pr9oA9o5MaJx9F0ip8mg=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by LV3PR12MB9354.namprd12.prod.outlook.com (2603:10b6:408:211::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Tue, 28 Oct
 2025 04:58:19 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed%5]) with mapi id 15.20.9253.018; Tue, 28 Oct 2025
 04:58:19 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>
Subject: RE: [PATCH 3/3] drm/amdgpu: use irq-safe lock in
 amdgpu_userq_fence_driver_process
Thread-Topic: [PATCH 3/3] drm/amdgpu: use irq-safe lock in
 amdgpu_userq_fence_driver_process
Thread-Index: AQHcRMrjtYb1ip0tu0uhGn6D2jsPqrTXBMyw
Date: Tue, 28 Oct 2025 04:58:18 +0000
Message-ID: <DM4PR12MB5152AB69DB0AF046B9EAEDF1E3FDA@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20251024094445.3090110-1-Jesse.Zhang@amd.com>
 <20251024094445.3090110-3-Jesse.Zhang@amd.com>
In-Reply-To: <20251024094445.3090110-3-Jesse.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-10-28T04:56:16.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|LV3PR12MB9354:EE_
x-ms-office365-filtering-correlation-id: 98fd5b11-2c83-4840-6c93-08de15de9cb4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?qRyyofpHo/mZDDFCRJXkjoj4fS/US7AKMcf/odIiSEVkrtHska+xx3m+OAZv?=
 =?us-ascii?Q?18Ztehj3rodagTGJYWMkFti5JeLitmNYvokuPSrLOiqEsUHZWNfFqXcE/r8u?=
 =?us-ascii?Q?5p5YU1UHiwRGsfX5ZK0dcgCOEm5BJCNCLsJZPnqtLIwrhKC5lZtfeqCKgMgv?=
 =?us-ascii?Q?F3qpsZDr+nMZt73T147fvmHYXybEqNHOniKdfcgrugLRHQed1VFoKF54zroI?=
 =?us-ascii?Q?ZGRaGDanwsJg+rlQT06yYj9zyjFW96TOtanIn9MqzJi0RPlHE09Fi8IRPabp?=
 =?us-ascii?Q?IEddN8zAKcccwhGwtaqoKIZxO8+j56NEyMinr2SxnN35KzrVenriwisWawwr?=
 =?us-ascii?Q?iKw7FCVoa3G0ErIHm7eTzobCGWnguGdnK5btxeIPt4QE/Vhb9uNzH+iracun?=
 =?us-ascii?Q?h+cGaNJUw4i0gERFAMoOaGLW+zwm9oTXNRMf5H8469zyVDPV3JyJvYCvY07I?=
 =?us-ascii?Q?B5QajEThbgqZ3frwxWiZ0Z4c9nvf4ncBPK0lts6C3E5QGxNv2UccFSoYW7Dd?=
 =?us-ascii?Q?RW3KbGr3jaUfgQMuZ5scb/iNybsrkQYzUumdQPxW1NQVZcTiFIAlXnnMHgdT?=
 =?us-ascii?Q?O3yG670GaBUn5GuKU2EXs6Ktps2Oe3t4II9lS0pn/AOPE1Jb+d0+J/G2xcZ3?=
 =?us-ascii?Q?B7ubdyomt9u4yyF1dPk09kOxXiLvsaOjWfUTGahDWq5njETeyRDMnF9fO8GL?=
 =?us-ascii?Q?Lda67xpmgWRfacw7vGU+1E+aetk53blcSzZlsX3F/UgkdOG4lTGhMCaOCv+T?=
 =?us-ascii?Q?gSJ8ZIJ8hPwGX5ZeR/nd7+L6RgGLoyZx8wyFekT/a3ovhZP38BlWWn+Lj6dQ?=
 =?us-ascii?Q?c3QibctHu0bQ5EnvnSc+1q8LknZHTcARRfKuB3EN6JMpSFznRPeCraLGxvWG?=
 =?us-ascii?Q?IL3hTp1D3eLxmNfSQWEVN/iV1dRVv2gPnFWIFLq4LzyXqNXCNbaKGl68U8E8?=
 =?us-ascii?Q?1xFbcQKTN4jUThZx5m6WygiNObMHiikJ9yw/7rTKdNcC1JnyLtuND1w3iJw6?=
 =?us-ascii?Q?klvcmUFpylckONkhFpkgpTQ7yE2a1cOSbxckOfg11OYPVGX20K0vXqT4ML4g?=
 =?us-ascii?Q?TEw3sjYk/QlAICQCgYdKR+t2UpBUGtQTuVOdbmiuv+U9QtHzuvD1fyXUiLSe?=
 =?us-ascii?Q?8KDt/+DiZKTSRBnlYb4MfLtEzOQci57kc4hTOZDmR96z+JzG3L9zpXygMPm3?=
 =?us-ascii?Q?cobB3KmKe4UUWrR/rTsT44g3nP1+OujANGpEIKBjFKRIfWisNJmi5+xhJhMo?=
 =?us-ascii?Q?kIWG+JVLPoT7Q1bg/s9B7oGsYfdyx1Xlf/QiL1bCQi3/y2BOOuSWKhHekyNU?=
 =?us-ascii?Q?PDg9k28SqaQ8OvhR0ujSaF49fTcKQnrdH7RWmPNJsFNUoAONEIONfqwB9lhu?=
 =?us-ascii?Q?UPmgja3VPopMIldWQbpE1/eeQepXNPXAbK49GdhjjT973ulhbNIEujpIaStZ?=
 =?us-ascii?Q?qlSLY98EzUqzbACMR8Hi2PZaofiZ6WRVyQCE55YL1Fqu0sFMMywYevmk65ON?=
 =?us-ascii?Q?Z6LM8COLNaUy6qTrKF9C67QuaVDl/wSaPsFp?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1oGDMcv0nHWliScbKqYKpxYJcbFzvQaKp93c06G/FGhG+8FaXhU7d6PVlDlz?=
 =?us-ascii?Q?VU/4tCOBSlA0j4XBDARNUlP0f2JTWCBu0iES6Dr/I2vrgo5WV6K85GoMZT4L?=
 =?us-ascii?Q?X0huhWrgdq9jWxRhPukWtbMXpzIpIeu9rrE5co7DOwfTUsWwWmxIK/9YxGdi?=
 =?us-ascii?Q?qRvgGdIH/PNXa5pOcSFsUT9elGeNN0NHG6+JobT59YJRbsVAAD4wT1MYvZDT?=
 =?us-ascii?Q?jXCKVzAg3QrCHgK9SqVl5JYxqKdV5rqfhuRFHI+HsJSln1zp19l1slDkhTPJ?=
 =?us-ascii?Q?0FLdoCf6AqsPZZ1poR2iaj7la0Qk3ulVt6nr9ynWq3b4XW9PnlOdDILURcWU?=
 =?us-ascii?Q?SVzY/vgeZX4dyPSX14PTsBtyk09vmsRtM78hWbNCwkg3Yf4hayZls/TuIXy/?=
 =?us-ascii?Q?taT9Rz1n0lGst82riqMbyvhIUndPYyUrh45foEM4ykOpu3CAVZm6Rt1qMqR8?=
 =?us-ascii?Q?y6UbSGizJPSZhCMkJUgCbRM1zUI5Ccx9WwcuVpWhwXUa5fR2EpPfUChVzKd7?=
 =?us-ascii?Q?9AmQ0i0Fww5wViOMOhQ40rp8PN4htM2SKow8RRj4ZjekNAlLejELJdhj3947?=
 =?us-ascii?Q?RZ8/W4s4pT9dLqSAfBPakV5CEA//FHLOc4JKVaBVy2RGYHZ/OXTPlV5zXeNR?=
 =?us-ascii?Q?q32jVL0O7OgczgV5ZP+a3rVCiTAifETcAGiD3qxXb34IigRA1eO8D0iZ8cqM?=
 =?us-ascii?Q?dJkfLGft5VuvyzzCj5WuaGDVz5Vvtd7jufwEelbk8USi/Jpi6gr7jZrFr4mo?=
 =?us-ascii?Q?jIN4fw7xUgKzZOjpNBfHbRbE70KyMABSUqvt3iXALxVCcEaQDBSCCUD2DRMN?=
 =?us-ascii?Q?phgtp1VCP7J/D5ZO10eiA3KJVf+pXjMv/CREAuQ62m2R3WCi4VWAlnJWRvHX?=
 =?us-ascii?Q?9ZUT4mlSVNOJNRydq9EIcVQWDh7YjYWyyTekn1bvlydyTcnzA2/SnkEV5occ?=
 =?us-ascii?Q?0hv9U54heQgqqU7DpTIQbHifYbPzUdFnI+WOSRJYlvYccfzcn7rxlSWYdoXE?=
 =?us-ascii?Q?6twO9kRFQKyxoK8GWJydr+LGMR5gGfxzwBaA6vD7Gwg3KppB9oz6PucbJyc6?=
 =?us-ascii?Q?8sZw4c2g/w46pTYcuyU48fBKsV6gPGariacXcgRHZ/n/T80F6hflemhB68jl?=
 =?us-ascii?Q?AeBhieNyudI7FWFrkDTR3VcCbAJdAUJdEdPWoXQOWBgTR0NknkDJQGoarbkY?=
 =?us-ascii?Q?wDTldex1eCmn6nZh0Jp9odrTiOoFG3z+c4VJeV+QR6SxbkrQ8M6NsEh6JYVU?=
 =?us-ascii?Q?BuJ+Sr9U0D9Cck+5L05ezXInKwUTNZ6cdr3nMQuZHs5vnGy4Tpr9wIbp3+wJ?=
 =?us-ascii?Q?6VDmReqyE6f/w863wNNyTzB8KSlTn0nLp9tIrr/mEC38xzg1RTtU5K6RiIcN?=
 =?us-ascii?Q?Dvpls+vJdiTNUN5SI0iKC3bdAr4GWioryIKnKzzjVBBM0nlgC3xeGtHLBU3b?=
 =?us-ascii?Q?Q2S3IoFXs28MrhAuHuNye3LWIS3tlYin2qs5l+/+F5+NpLU8vAOZnuvmBfVr?=
 =?us-ascii?Q?+yTC7vFE/KIqbMd2cxlINHrWQRXmiORGuS80dc9artp7ZTkjmmBjVabLB51j?=
 =?us-ascii?Q?WTeRtJ9GRMgwhcrxn8k=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98fd5b11-2c83-4840-6c93-08de15de9cb4
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2025 04:58:18.9012 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OuK0zDc0kC13CWRypYtWPU3GT8b/V5FcObj0UtT9KqyKI+8Gu9S5m8mMLdMwRfd1aMSkCewMxSwQRecF4gD1Cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9354
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

Ping this series.


> -----Original Message-----
> From: Jesse.Zhang <Jesse.Zhang@amd.com>
> Sent: Friday, October 24, 2025 5:44 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>
> Subject: [PATCH 3/3] drm/amdgpu: use irq-safe lock in
> amdgpu_userq_fence_driver_process
>
> The amdgpu_userq_fence_driver_process() function can be called from both
> interrupt context (IRQ handlers like gfx_v11_0_eop_irq) and process conte=
xt
> (workqueues like eviction suspend worker). Using regular spin_lock() in i=
nterrupt
> context triggers lockdep warnings and could lead to potential deadlocks.
>
> Replace the regular spin_lock()/spin_unlock() with their interrupt- safe =
variants
> spin_lock_irqsave()/spin_unlock_irqrestore() to ensure proper locking sem=
antics in
> all execution contexts.
>
> This ensures:
> - Interrupts are properly disabled when locking in interrupt context
> - No lockdep warnings due to mixed context usage
> - Safe execution across all code paths that process user queue fences
>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> index 2aeeaa954882..69908b90d255 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> @@ -151,15 +151,16 @@ void amdgpu_userq_fence_driver_process(struct
> amdgpu_userq_fence_driver *fence_d  {
>       struct amdgpu_userq_fence *userq_fence, *tmp;
>       struct dma_fence *fence;
> +     unsigned long flags;
>       u64 rptr;
>       int i;
>
>       if (!fence_drv)
>               return;
>
> +     spin_lock_irqsave(&fence_drv->fence_list_lock, flags);
>       rptr =3D amdgpu_userq_fence_read(fence_drv);
>
> -     spin_lock(&fence_drv->fence_list_lock);
>       list_for_each_entry_safe(userq_fence, tmp, &fence_drv->fences, link=
) {
>               fence =3D &userq_fence->base;
>
> @@ -174,7 +175,7 @@ void amdgpu_userq_fence_driver_process(struct
> amdgpu_userq_fence_driver *fence_d
>               list_del(&userq_fence->link);
>               dma_fence_put(fence);
>       }
> -     spin_unlock(&fence_drv->fence_list_lock);
> +     spin_unlock_irqrestore(&fence_drv->fence_list_lock, flags);
>  }
>
>  void amdgpu_userq_fence_driver_destroy(struct kref *ref)
> --
> 2.49.0

