Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA860C54791
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Mar 2024 02:44:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 39F9210E04A;
	Mon, 11 Mar 2024 02:44:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="y5H1o2Ff";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2041.outbound.protection.outlook.com [40.107.102.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B2B9810E04A
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Mar 2024 02:44:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KmDnKMqh80Zx7ThDQhP29p923/mmqK7cbcdClES5FEWAirPjWESt2ROGVtO+k8YgpNmM0dK6edvC1Qd4u8nQlZqe1XLyxNVR2tAYtV7cAa5ModCvIAA4pwF68/8JiZM6+h36LC4nxNGYxVlFvInq97YKOdz+e1t5QJUId7wJ7fggVxelAqo3Vwusog20vJiNSPe6gHCL1hEVYLWRoU68z1YnbyfzfNSECBgGZHyj7j9AqDgUXqqJ9NtJAggRh7c8UdRoghGYV6qGqYUhDtIMhyVqe7F8QkD+HKPuESvqH9pxcVbQm1Ew8YbpQKLe6zAqIszZNmYIH6qQDnop5AaP+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DzN6TgkQWGcCxVSCcHk0qNORDXhuM+XvvrtyMj3cfi8=;
 b=QEwNRgSfvEFUSwFH8GmDtQ5VOhG6oq5M5D173Y1zKci3JWchbIfs8Ts4IXVuj++FkcUx4x5i+sBMe0a2bEiwBxMRfYhgsIR+8zuG1FYX5wJbyi1+L6yi7ipGnvfaUfBlQgXqrjq5Z5gGqLfDZoaBw9fFnwtbuGlz3R6WFYLJrZ2isTYFW9/9oJnVvaBnW3GYu3EubjktEJDCh8BqzVXJ1QhANq7LpG5gGltgkrBovBwW6w9VbBOx+rJ2ucZ7+mKu32687awA925wBjrvBP+9He8yeodh2pHVU4IR8v0hAsWlSG2IKjb7sZwND/OZWr3VhEe8XTmkp2rnDXUK3ZlpIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DzN6TgkQWGcCxVSCcHk0qNORDXhuM+XvvrtyMj3cfi8=;
 b=y5H1o2Ff6tQkDHToMtqgftQ13iZXtocdKd9fvLitEgBVjC9+LqhZDzh8SlIiWM6NlbkaHZ/h+JvGgWGDtszkLrAhc1qxbpkJwS19gD2v24mCUXYG7LYv2iOsP4m7htkSrgpUnI1zHJua7rBQMmVhobjADm8JFAxLvNX3tMeVVPw=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by SN7PR12MB8101.namprd12.prod.outlook.com (2603:10b6:806:321::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Mon, 11 Mar
 2024 02:44:42 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::2c3d:b3d4:f995:915b]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::2c3d:b3d4:f995:915b%6]) with mapi id 15.20.7362.035; Mon, 11 Mar 2024
 02:44:42 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/5] drm/amdgpu: add new bit definitions for GC 9.0
 PROTECTION_FAULT_STATUS
Thread-Topic: [PATCH 1/5] drm/amdgpu: add new bit definitions for GC 9.0
 PROTECTION_FAULT_STATUS
Thread-Index: AQHaZjGpFx1grK1O/E2v4Wnodkh7ULEx76tw
Date: Mon, 11 Mar 2024 02:44:42 +0000
Message-ID: <PH7PR12MB87967F9EAA8AE4B8EC76E212B0242@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20240223082352.323583-1-tao.zhou1@amd.com>
In-Reply-To: <20240223082352.323583-1-tao.zhou1@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=57bf6600-26c7-490a-8e7a-18551d7f8ede;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-03-11T02:44:24Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|SN7PR12MB8101:EE_
x-ms-office365-filtering-correlation-id: f7b3168e-232d-4911-4e08-08dc4175347b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9Sf+FmlYoE/A2qB7YoYnojzDuvyYQRQu9I5Ez9zSk6Uh+mrd4jPMM0smPHu8/am5s/oXkEBMud8HpFeK7wruPgpW9x8tcQJAYwbQ19He4IJV0tBK5DPlIJDUOJRO7WO+P5qsYyRhXy3xExe5gHf1tlQF2q1o1BCb6V2ZXEXtudJJ8W5ISfylHC8KeaU5qNYxcww1dRDMDPEGV9AsclwQev8qkW57RRBb9QjROwlvB2htNFFnff5XAybowFOu0CnE34HlLOwofuGMwtrGmgbwZT4eikH9ztMe6n5edTdS2+tnVelQL7WGEhKGkD2+sD+qSOe0peJXHs51TQkQ+hHvAwbKtY3r9qWklIBCwtyXCZ2kR5/YBa2tqEjiZ9wFH0t+Zx+uUnEZ5PjjdyxOA4zJntE6TcVY12cugtFmispVmkQJnS/sYYMy+uEOnjB/qqyOAF8sWEzaEPC7scY+bcSRXK7Qa7wBUwR4MN9mFnDID7iAmeYkg1iyFAWDFmcsMgxbA4LaOnNrvoYtg8V94R1QE2SwYJnXMiDGV8Qx7AsSf53SsWIpJcGmg+vXIfMnkxGNKRzULFLl058uRcnxfmz4I4/z1fVYjGr1X5dZ5HIFti0P9tdWZm1UsMt6a/7c3ODScl4dQwpRRRVBxXsISDWXeE0gfLnLJTI2NLVXlRPu+EUSRCJllBIeZSwi4jgBBPviDEStOppKVoXOrXYCgc5DFWh/BckxnivH/5gwwSlxeqM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fuTtFL1ihDi9o3YRgXzV68Q5KnAwNnk+B7asoB7L7VXvqNFIiSQDocbOdtuK?=
 =?us-ascii?Q?L3iHC0qAGgVZN2m+mSW1L3fK3jNp/wy33KpI9QGMZL0GuoCvCZ8hViG3gEfw?=
 =?us-ascii?Q?oguKavBYXGGMG26XATdUw0JIpMdraM5EGLoHuulTT8xb2C9VOAxp7do8i7b5?=
 =?us-ascii?Q?o6QwnNaLEZQGNZo+3NMxqMOPEpthmQg5KKswVaRkuywwp/CuexXqvKmIeILS?=
 =?us-ascii?Q?C9VaB31CuZW++4kjqHgsieYdxYhbNoCceyF1p+fgsydIZr5VB3WK6d23VGH1?=
 =?us-ascii?Q?FCqNoAuSVGdJ9REtomorqRKXMboxvLt75MeDlmGxunZqCCCZGUJBp+jZukeR?=
 =?us-ascii?Q?1Z29Dd4h9PeK12AT91qW3wj/efLiZv4BmSST9jtIht2knLjrdAce5L+X1JiZ?=
 =?us-ascii?Q?6p9s9vuYGmnEZ6ataW1LIMmsKEyxcgKN2kp0KC0MqTFpHzQ3rxifr8SNCHxd?=
 =?us-ascii?Q?gitPFh5eYVTjsFiUCLie6XBJb7H/2trXZezzHLpz81gf/fpplDtH7ye802GS?=
 =?us-ascii?Q?raWpyfTsMiPJHYQbSvYaaUTuWQv1Ho1s46z4RcslGFAyFRAfopuXr8ZIoiBe?=
 =?us-ascii?Q?pmYiU4xt8LVQD61B8Oh84AHBDHsPFqUwYBO9t1DPePbDnKqYpY0Dr2DIBPM9?=
 =?us-ascii?Q?TW+7Gw+6Ri0bMeLH8nCR8MXZMMjYHUUukRtWt3B3H3NBWJZ31sJ3oXdPgsgp?=
 =?us-ascii?Q?LhPZHo1mnyeKG3X5UddLOGRYbyda4pHVLR2vLCM3/tBbcN6yh1Ohwct9CoFf?=
 =?us-ascii?Q?qawqBwOuV/NAheWo/mTmS19/8t0yhOGdfH0x6tHw61GENNXjJOgKNEnZi1i4?=
 =?us-ascii?Q?UQG6bdu4uL6kz57zCK+qnlSuyB+YdFfF+qbQZ7dcqfDBWXQtA3jZ7WELlfi0?=
 =?us-ascii?Q?B4S5+7Z9lBT0TZx8KEqZvf1YGgMuECj8RLb/y24MSrUVT8XWqrFnorkKWzfp?=
 =?us-ascii?Q?pDna02Ie8jdo9CqSokDOOydUsKWopyLXr57yPnT9LwHViS7f4v4Q110uJsWU?=
 =?us-ascii?Q?euRVKzdnwU+72d+LVIgANGu8RLL7N2BgG8okkjECbojRqoUB+YbuqK5WDpaQ?=
 =?us-ascii?Q?OLa4tYDyMJ0Uy/zX9xGFd8E0upz5uyJhiZbgDR621vJqkePf+JXY+jI/Ztjt?=
 =?us-ascii?Q?e1Kx8uZ6O97MBeGAq3TWKIzk7ltZcToW/CQxdgPgsL48BHbY2eD8RITREmYN?=
 =?us-ascii?Q?f/Ubedp5R1jiAKWs/FfqMXOU3/vK+TAIFfAdHeq/E1QxRkY/DY+HZFSJKxo6?=
 =?us-ascii?Q?O0BZ1/IKTh4Ae/W3r7c1OFKv7TVqB3IRHAeKQbNtlEzoqRastZZgPpIWWElO?=
 =?us-ascii?Q?V4pyhOzT3KUGL8YK6i+gdTkv/jnAvhYtelTwiIYPpbC5gEP5WW0HkKHldL+k?=
 =?us-ascii?Q?0vQb7Rlg2JtwwN5Tgpy85Uakij3Y0mXvnbJfvDP++k471vqiepsfkKwqaj6E?=
 =?us-ascii?Q?vQ+t/FHKvrLjSBMBj0CJump0f1oHDGYgUjOnrOb+1rTuu+1qtBQHacW0zWKa?=
 =?us-ascii?Q?LbilFXm+8/+tpS8sCXFi3vfmFSrQj3ewKHN6/nkm8U51MWcLcvuIJrwqfxRW?=
 =?us-ascii?Q?l9RfRuYIh0DwYCGrBA0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7b3168e-232d-4911-4e08-08dc4175347b
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2024 02:44:42.6777 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iy8iGnyMFjdnwPvrvA5TicwvjbjTXH1tcRcplQ0hQXglL6nh+HGwRfx7+OA+WbLI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8101
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

Ping for the series...

> -----Original Message-----
> From: Zhou1, Tao <Tao.Zhou1@amd.com>
> Sent: Friday, February 23, 2024 4:24 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
> Subject: [PATCH 1/5] drm/amdgpu: add new bit definitions for GC 9.0
> PROTECTION_FAULT_STATUS
>
> Add UCE and FED bit definitions.
>
> Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
> ---
>  drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_0_sh_mask.h | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_0_sh_mask.h
> b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_0_sh_mask.h
> index efc16ddf274a..2dfa0e5b1aa3 100644
> --- a/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_0_sh_mask.h
> +++ b/drivers/gpu/drm/amd/include/asic_reg/gc/gc_9_0_sh_mask.h
> @@ -6822,6 +6822,8 @@
>  #define VM_L2_PROTECTION_FAULT_STATUS__VMID__SHIFT
> 0x14
>  #define VM_L2_PROTECTION_FAULT_STATUS__VF__SHIFT
> 0x18
>  #define VM_L2_PROTECTION_FAULT_STATUS__VFID__SHIFT
> 0x19
> +#define VM_L2_PROTECTION_FAULT_STATUS__UCE__SHIFT
> 0x1d
> +#define VM_L2_PROTECTION_FAULT_STATUS__FED__SHIFT
> 0x1e
>  #define VM_L2_PROTECTION_FAULT_STATUS__MORE_FAULTS_MASK
> 0x00000001L
>  #define VM_L2_PROTECTION_FAULT_STATUS__WALKER_ERROR_MASK
> 0x0000000EL
>  #define VM_L2_PROTECTION_FAULT_STATUS__PERMISSION_FAULTS_MASK
> 0x000000F0L
> @@ -6832,6 +6834,8 @@
>  #define VM_L2_PROTECTION_FAULT_STATUS__VMID_MASK
> 0x00F00000L
>  #define VM_L2_PROTECTION_FAULT_STATUS__VF_MASK
> 0x01000000L
>  #define VM_L2_PROTECTION_FAULT_STATUS__VFID_MASK
> 0x1E000000L
> +#define VM_L2_PROTECTION_FAULT_STATUS__UCE_MASK
> 0x20000000L
> +#define VM_L2_PROTECTION_FAULT_STATUS__FED_MASK
> 0x40000000L
>  //VM_L2_PROTECTION_FAULT_ADDR_LO32
>  #define
> VM_L2_PROTECTION_FAULT_ADDR_LO32__LOGICAL_PAGE_ADDR_LO32__SHIF
> T                                       0x0
>  #define
> VM_L2_PROTECTION_FAULT_ADDR_LO32__LOGICAL_PAGE_ADDR_LO32_MASK
> 0xFFFFFFFFL
> --
> 2.34.1

