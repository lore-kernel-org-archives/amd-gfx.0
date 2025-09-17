Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A13E0CAC592
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Sep 2025 03:11:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B87F10E023;
	Wed, 17 Sep 2025 03:11:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="h+Ow0ED+";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012063.outbound.protection.outlook.com
 [40.107.200.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D14F710E023
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Sep 2025 03:11:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RF7Kzg0UI7c6iVPeJ/ILNmMBC54qgGJ5n/MHzTw2Iss5w4oNRXA2bkhDrBcn1IJgy1ISJNx9Jq0yRgP++o80rs7blYMDIEgMHdVHAufkRpu95X0IJCWwJ9GveuYips7ixWhI3NxfTxiBkvveSaHphIoCEPppOWpNfWebHg9j2SNQJToWUAWmKE789wsedb8ikHu67pxf+t99d+Kr3joaTCvSedxTQpRVIwUs69USSkPJvT+/QWEVc/mpfWylHuEZyOnYpuFZISWzg7yc99RalzyCw4O8ZF9TI1hBBf3O9cLWncFJcBCEfZ3u3JLAxtyjrlOUWtJFhL8o2bE9Z7krAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7HyYMA7SEQ+zsus3Lm6+L7vgoOXtaUAUrGucrv03Waw=;
 b=S4pXGIBH7hPXRbS0Cap/0pePHAInaVeyZHfCWpuAd7Hdese0SVDBvLjhPbzRxY7cDFGxG+nswpaRqNvmz6PxwsOs0tO9c17bRytSLBT0RykEWOj4fpS5eq4grDZ/WRZ2CPlmfC+4mJmqn4g7jwGzeTQwmq2OeivvjdtGUdS9s5kde4wZESmvrv5fIFBm06z9SofehKLG844gxhmY/uMHwmaeC1Zh1Jv/HY2qTjgY+cwRq3/eDavI3SKFDCXJLkiLQRlhsqgo3nKKXQhLm20NKudzuaNmOT0jhJy8mryQY7MEFX34og/iiiMvA1x1U/VqFDAj10e2vn2lcSDAmteyvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7HyYMA7SEQ+zsus3Lm6+L7vgoOXtaUAUrGucrv03Waw=;
 b=h+Ow0ED+eBLs9BaP0vhCTUfYPmrtc/ILWUMIhrMgC/kclwqZlQSP/YuuPbiZTc3Yl0/7VrX3XFd/QqNB96bctmKVd+yIjjd3fNoTycfV+UdkS4NtuqBTkXqywDtg5edit6t0A53h9aXtKPPY36z71wtwgNm0Pdipf/m3qBpNZrU=
Received: from DM4PR12MB5152.namprd12.prod.outlook.com (2603:10b6:5:393::16)
 by IA0PPFA19DE7612.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bdd) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Wed, 17 Sep
 2025 03:11:03 +0000
Received: from DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed]) by DM4PR12MB5152.namprd12.prod.outlook.com
 ([fe80::d4b5:6a30:96d5:e3ed%7]) with mapi id 15.20.9137.012; Wed, 17 Sep 2025
 03:11:02 +0000
From: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Liu, Leo" <Leo.Liu@amd.com>, "Jiang, Sonny"
 <Sonny.Jiang@amd.com>, "Ji, Ruili" <Ruili.Ji@amd.com>
Subject: RE: [v5 1/4] drm/amdgpu: Refactor VCN v5.0.1 HW init into separate
 instance function
Thread-Topic: [v5 1/4] drm/amdgpu: Refactor VCN v5.0.1 HW init into separate
 instance function
Thread-Index: AQHcJeXFjUMI6Yfd90Srkhf+zzzWuLSWtUjQ
Date: Wed, 17 Sep 2025 03:11:02 +0000
Message-ID: <DM4PR12MB515258855577C26BB8858E40E317A@DM4PR12MB5152.namprd12.prod.outlook.com>
References: <20250915020924.137122-1-Jesse.Zhang@amd.com>
In-Reply-To: <20250915020924.137122-1-Jesse.Zhang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-09-17T03:09:53.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5152:EE_|IA0PPFA19DE7612:EE_
x-ms-office365-filtering-correlation-id: f5494f99-8f6e-44d7-4bdf-08ddf597d589
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?qP2oTDVAgw/wP9Kre8NYyU8FfmNA5o9fRB1Bn6eUAUd4Dc9lA7WE7rMjqyqw?=
 =?us-ascii?Q?rdXRlrRe0o/lkOik4ZaaCg63syUsebTMnZTaV6TKJs+Ei5PJkpqhFUKyyF90?=
 =?us-ascii?Q?mHsGl73pNoGaATIEk69aAd7RIuAvFINvHejtaFL7hpFQfZWTNy5GZl3C9VF/?=
 =?us-ascii?Q?KsgF0aSuzie4SQIWRY0NIt8FGuf8i3tR7ph3yDezO+voq0fjO9xVCTv/IiN9?=
 =?us-ascii?Q?lolvz+/7DQWv15G2M0gQj7uvQreuOv8iuP/iboMlkB+3cLf+QKSFe5g2lp5l?=
 =?us-ascii?Q?mlPzyZMBhd/KZ5GPIzG8J4cWXrTo8ZpfIC6zwhm3H4Z0BmWMfhNJ6St2ee14?=
 =?us-ascii?Q?I8Z9g79sC6RY13HlLdK3FB8r4U0VwxSUUTFsUj677wJG8BdDy0bK1D+vwhZh?=
 =?us-ascii?Q?whmCnsjnfIrxDr5l7tSuM3cl6C++fUnFxkRycrfw39Nq0Dus3BlplZ0BfQlD?=
 =?us-ascii?Q?lH8+asO+AmsmZX+pWfC2J3gU/KEvft6d1y/dyHggr7TmKSsaTIKLba6+df+m?=
 =?us-ascii?Q?kufFrw5qTFUhLimfLVUDzycV3BdIxCide527b39/pRO3+BRKtdY48Xyl9bhn?=
 =?us-ascii?Q?yM114cs7U6PXpHFU6FJwSX972amSx2fhuEe/f4kQqFFC0NnVdqZXdxT2Nw2l?=
 =?us-ascii?Q?LhFgrh0hZGwn7nJ6f+Sm5lO67XRWQ3/pNaMLFtq5BuBgtcBaLdFdVqe7LY6H?=
 =?us-ascii?Q?cD3tDQbo7Fv/B8MlQYbCM0NZiJQO97pXSJ10pSExNFS25Kswp0PU6XQZLKVx?=
 =?us-ascii?Q?6mwLdrK2bRubPPb/Kg6liGwFOawoN9Dz/iNpaRKB6tuItMfNhAxsg61qn2dT?=
 =?us-ascii?Q?/MAazR7N4C0ETCJY5MBFP8lbYsTMjq6zaNIda1YM4bkDuVB9h3YUa1bLUuwn?=
 =?us-ascii?Q?WM7BsxoyCZzZ4GJ3+1chrGrfawgaenX3H/NOsSI714zbWkVoaNlJQyzW6RFg?=
 =?us-ascii?Q?lYoGPAWCGhjI23R4g15cUGNqxj4q5pYbKZbunsADpt+QzSMNOn/EVNEeN4/E?=
 =?us-ascii?Q?m2yQN0zYu9Hk8BOV6UONsq6uABvN5/BdPKhHbxpQg5TkCUyAoPmE/U6Nes+J?=
 =?us-ascii?Q?4IzuBd0ajir7Lvwgb62kOoBVVsusWx4oLRpXxUj4MerCcp150ImlZRpSqsfn?=
 =?us-ascii?Q?0EZohNid+CwqwhJvtzFRGtOvNKaWBt8+6Fa9Aq8wb+R5sHKJvjHIrgJxFpMh?=
 =?us-ascii?Q?w4aqG1g394QSCG2r48Bl67oQ9n6yc+PkYOBd3N81xbitfXOwXqSvp6K6U7Q0?=
 =?us-ascii?Q?+pZczGY1eVlk5rj4pteJQkLnV6Duejkbu7p/KEcz7mN7GnR871neXMzMjnv1?=
 =?us-ascii?Q?tVhTeBxtLBUrJKfnKCe9RN5jHSgagfSx5MkAohHzLlTDSomr/ft6Npoe0SKe?=
 =?us-ascii?Q?L44RcrKOMkgwQNvoAGIHeYKEFs8WE8ovgb4jIva8MJBvhneYFBuWYGZPDvzF?=
 =?us-ascii?Q?UkEFZvpbbx0QmIrlz8mP4lY/dMK1hQcBF0/7by7pj3zaac6ckMo33w=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5152.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?88Z4ym2LMY8807/h1VXG7CXgi3XaGyVjqb5c0ArOXLnb5sdyPJg1Dt9o6cqF?=
 =?us-ascii?Q?L/vUcuhvj99daBa02JzLYMR9VoAGqV6oLnJDkGRpa5KdJj6ybfIqKOMAh5rr?=
 =?us-ascii?Q?B0v4gpA6OAMeDjfhmXA9J03t0qpi66g10cHxqcoIDU9q4zZZ9c1LKpe9VebJ?=
 =?us-ascii?Q?t+zLHgCJjXaeTENsul8YQ0gdTx7ShWLFqqjCY1EZUuqzTA/K/oxKtK1hQ+I6?=
 =?us-ascii?Q?7nHZ6m8yGXooXalbjX2kXj75sb40WVW1gK7bmtTOoAupnRT2pkT8N/US/t42?=
 =?us-ascii?Q?hdjWTip9PVX0jLpk6PfB62zeivw1og9elkes/+cxQ3QRLGJYOBnb/Kry0fuP?=
 =?us-ascii?Q?xgyscKSI+erIw9evdtC5Sd7T/5liQyM5mrv5XBofyNKcQWHorNRZhRZ61b0v?=
 =?us-ascii?Q?k1ZHCxBo3pqvbbYo7uxbPMhTIkr1ROY2h4FIfNZGJ0xCr52DZnpEf+RE6b46?=
 =?us-ascii?Q?h7e55eKKaMD0J/jNH39z5hPwLCEoOc3GFXFAnVTW4YIVwkFjzLxe6jhAWzYQ?=
 =?us-ascii?Q?MwuBnFgYNdF7Gff6TxYqqMD44yGupqJxz8q+qiqGkq5FTOZYVU5NZtn6d8A5?=
 =?us-ascii?Q?WBvjHQAsucCNXNGrscAfGYS8IOlJ6CbyMr/2mWl5WjCqz+k4E8Qq9IbZPI6Y?=
 =?us-ascii?Q?WSm66MxEZYUmAvFQFCgjuTSGTeHecvU24lrTVmdeumwtZPtAgtRwZAW0sRY/?=
 =?us-ascii?Q?XSqFy6pAWQ3/Kf+ha7oKm84XlGhRmvpQ/tTtuqgfC0gJXTDKIhthrU5nR3Qj?=
 =?us-ascii?Q?VVTyGNymCp3O8eQ1xNmzV6LCx92EKyGKqZ5Hx9NgcZyPeCmknTZrBQ6rBCT2?=
 =?us-ascii?Q?K3bdXOwvM4hJ89BPT6IY8U+1wA68wkcWPMGSAgTo/d3sNpgOKM3IZFYwiFnu?=
 =?us-ascii?Q?hOYOsvnLv6brU3H4pItjbdBY/OYGJROQI00zaEaUuuvC5JpurlXccmQQVHRe?=
 =?us-ascii?Q?jaYog5/uEg56aqHoU2RwgmDAj7wPH5RgdMmjFpB6FOKgPipYn80PAI27HBrS?=
 =?us-ascii?Q?1D2DVcUSrcmzdRrpUCyDDdPCNHuyGF2qQOa4vk88TjlRC38fN4B7r+vCamuy?=
 =?us-ascii?Q?jXrb8arO/R94+HD5xV394wAhJOFl/L3putKl6Z4mxBzu2nBlYWecz8TidLZc?=
 =?us-ascii?Q?7NSXLSUcIgqWjaFBmPMT5qmamoNSqzGn2lBPCCIAZapznyqlJfvpyLL4q3/4?=
 =?us-ascii?Q?DB8er97tvS+rfEWt+s9IOxNoWr64ZcB+uPnjpUA1HZxYQc1kLRwIeiIZ4E2g?=
 =?us-ascii?Q?ODVYvyIkUxn2nNWEXFzBg2p4iskr9hLbTOushfF2h6P4h2hVpl+SDmHr6m1L?=
 =?us-ascii?Q?rNQ4o0xMB28k470r8wbsmT0VQ4tbI26Ba2uQvjakpP6glgiB3aDlKlqLZS+i?=
 =?us-ascii?Q?LTdW4WkNMZ3TfI0k/UdMpL3BMKTPYZqJqgxkCF2Qc6mUOQqPZjLhkv15HlmF?=
 =?us-ascii?Q?Haj+5cU2ozt3ivyBjjY8NzTVSMVL2XXa40H4IBlA/Qw1WiBCLJPD9LhvNtqh?=
 =?us-ascii?Q?fmZoVLNnGkn9teSio1HeJgjV+U/4p5f/pRXL+iVHbV/wK7H+ZDc6UX/sbDG+?=
 =?us-ascii?Q?QzXhDK7CIdPUBtVOzrg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5152.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5494f99-8f6e-44d7-4bdf-08ddf597d589
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Sep 2025 03:11:02.7648 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QxVLJob45Lz4CpdGXOidOll+vOyICTSiPQ1Wiqbm7Ktz8r2hIYN3zDgWedVBoTPgHcLd7CtDceXxVkjV/DIQdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPFA19DE7612
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
> Sent: Monday, September 15, 2025 10:09 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> <Christian.Koenig@amd.com>; Liu, Leo <Leo.Liu@amd.com>; Jiang, Sonny
> <Sonny.Jiang@amd.com>; Zhang, Jesse(Jie) <Jesse.Zhang@amd.com>; Ji, Ruili
> <Ruili.Ji@amd.com>
> Subject: [v5 1/4] drm/amdgpu: Refactor VCN v5.0.1 HW init into separate i=
nstance
> function
>
> Split the per-instance initialization code from vcn_v5_0_1_hw_init() into=
 a new
> vcn_v5_0_1_hw_init_inst() function. This improves code organization by:
>
> 1. Separating the instance-specific initialization logic 2. Making the ma=
in init function
> more readable 3. Following the pattern used in queue reset
>
> The SR-IOV specific initialization remains in the main function since it =
has different
> requirements.
>
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> Signed-off-by: Ruili Ji <ruiliji2@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c | 27 +++++++++++++++++--------
>  1 file changed, 19 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
> b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
> index 9c281ba6bced..3677ea9ffa43 100644
> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
> @@ -253,6 +253,23 @@ static int vcn_v5_0_1_sw_fini(struct amdgpu_ip_block
> *ip_block)
>       return 0;
>  }
>
> +static int vcn_v5_0_1_hw_init_inst(struct amdgpu_device *adev, int i) {
> +     struct amdgpu_ring *ring;
> +     int vcn_inst;
> +
> +     vcn_inst =3D GET_INST(VCN, i);
> +     ring =3D &adev->vcn.inst[i].ring_enc[0];
> +
> +     if (ring->use_doorbell)
> +             adev->nbio.funcs->vcn_doorbell_range(adev, ring->use_doorbe=
ll,
> +                     ((adev->doorbell_index.vcn.vcn_ring0_1 << 1) +
> +                     11 * vcn_inst),
> +                     adev->vcn.inst[i].aid_id);
> +
> +     return 0;
> +}
> +
>  /**
>   * vcn_v5_0_1_hw_init - start and test VCN block
>   *
> @@ -264,7 +281,7 @@ static int vcn_v5_0_1_hw_init(struct amdgpu_ip_block
> *ip_block)  {
>       struct amdgpu_device *adev =3D ip_block->adev;
>       struct amdgpu_ring *ring;
> -     int i, r, vcn_inst;
> +     int i, r;
>
>       if (amdgpu_sriov_vf(adev)) {
>               r =3D vcn_v5_0_1_start_sriov(adev);
> @@ -282,14 +299,8 @@ static int vcn_v5_0_1_hw_init(struct amdgpu_ip_block
> *ip_block)
>               if (RREG32_SOC15(VCN, GET_INST(VCN, 0),
> regVCN_RRMT_CNTL) & 0x100)
>                       adev->vcn.caps |=3D
> AMDGPU_VCN_CAPS(RRMT_ENABLED);
>               for (i =3D 0; i < adev->vcn.num_vcn_inst; ++i) {
> -                     vcn_inst =3D GET_INST(VCN, i);
>                       ring =3D &adev->vcn.inst[i].ring_enc[0];
> -
> -                     if (ring->use_doorbell)
> -                             adev->nbio.funcs->vcn_doorbell_range(adev, =
ring-
> >use_doorbell,
> -                                     ((adev->doorbell_index.vcn.vcn_ring=
0_1 << 1)
> +
> -                                     11 * vcn_inst),
> -                                     adev->vcn.inst[i].aid_id);
> +                     vcn_v5_0_1_hw_init_inst(adev, i);
>
>                       /* Re-init fw_shared, if required */
>                       vcn_v5_0_1_fw_shared_init(adev, i);
> --
> 2.49.0

