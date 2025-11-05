Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4BA1CCFA04
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Nov 2025 08:51:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 47AC110E6E2;
	Wed,  5 Nov 2025 08:51:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nCSvpHd7";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010038.outbound.protection.outlook.com [52.101.56.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7328F10E6E2
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Nov 2025 08:51:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mj7LSxDMKicRrxjY+sAL4RgEpFE7CcRf8UFZKbkhhOXN0lvL13uRKEQ9qLqvWNpF3vUOM4Vt03vpUW6sULYNUe3JoKizyRTnVr2A239rGvwtKvCzrnqVETCG4r54Aqnu04dlWQsE0v+8Oc6e+0SH/ewEUsqntCnt5KM8CJyWU4CUVQfXP6kxrJPNbJumFr9RIvFEEBfa4RNvO6lzovtlhem6LSkAcOPAWV4WphCNMMgfRQ9VepBIXNAup1NQfjELaIlbZ3YwzncqSmHEfRaXGAqLCn1DhQfS0vdeuoT4iq0NTBNdZSZvql94cke09ZEnNscRdnKASlkd5NcTPMDtLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FEqljenYLUDfHLm2i/MTa4uK0/w7fpZ0vRQbQLPq1/Q=;
 b=wMpmH3FWvNhMZtPv6/TlEApWboAHN8G3A1HxmDvHxO0kD+BAmwX2neQBfwp5AlmOKnc7ushWk31GDefXa2IR7bl5A4XcilP0SGU2RM+zCVBS2Qu+DSinKZp3K6WxSO1jxtAOH0F1AT+hw2VJ69FlCRAN5tBd23KP8DBXN9fd1yNIX7EMMfcFrTq5d5Pc3y7ih4Gdu2NZ8I3MKRwG16Ihk2OYTyiNSqw9eLwOMA8ld0EnRl+Kf+uJigdp3iwyluJgDdvh2rLo6CQOx69KTWZVv+N+ITuxpgcm4MujH6Z6gRTH5oMWcUWqTtNOrKoN6K536tGoVH09kpt/exWvu0184w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FEqljenYLUDfHLm2i/MTa4uK0/w7fpZ0vRQbQLPq1/Q=;
 b=nCSvpHd7KaBtSkSka0ZNNeFWHhkRA+OcN0CQxeIWmHzOTjs8tkxhxq/G/xF+8rG0PD7zSOE83uKqAzzUx6Rrciss7soNNPUjN4oBlfFFyBWdkX1tF4o4BmifzfhN8Nv3rNnUg7WEWjUq0hEk0bsoSjf5Z4yxUxUA3cAZ33GNtzo=
Received: from PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22)
 by SA1PR12MB6821.namprd12.prod.outlook.com (2603:10b6:806:25c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Wed, 5 Nov
 2025 08:51:05 +0000
Received: from PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd]) by PH7PR12MB8796.namprd12.prod.outlook.com
 ([fe80::910f:c354:ea0d:1fd%4]) with mapi id 15.20.9298.007; Wed, 5 Nov 2025
 08:51:05 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Chai, Thomas" <YiPeng.Chai@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Hawking" <Hawking.Zhang@amd.com>, "Li, Candice"
 <Candice.Li@amd.com>, "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>, "Yang,
 Stanley" <Stanley.Yang@amd.com>, "Su, Joe" <Jinzhou.Su@amd.com>
Subject: RE: [PATCH 1/2] drm/amd/ras: Increase ras switch control range
Thread-Topic: [PATCH 1/2] drm/amd/ras: Increase ras switch control range
Thread-Index: AQHcSjTPCOkY9rncHUayPF/TKYNETLTjzilw
Date: Wed, 5 Nov 2025 08:51:05 +0000
Message-ID: <PH7PR12MB8796C7B5CC0AEDA6FF66BEF6B0C5A@PH7PR12MB8796.namprd12.prod.outlook.com>
References: <20251031070435.2612918-1-YiPeng.Chai@amd.com>
In-Reply-To: <20251031070435.2612918-1-YiPeng.Chai@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-11-05T08:50:51.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB8796:EE_|SA1PR12MB6821:EE_
x-ms-office365-filtering-correlation-id: d924e6bb-14ef-4a0c-e28e-08de1c48748d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7053199007|38070700021; 
x-microsoft-antispam-message-info: =?us-ascii?Q?q8kYeR7syvLJl0yOaf4Pst2qvFVin0jge++KoVxSZWgbOw4MVSqL+gkcbdJJ?=
 =?us-ascii?Q?wYC088i4rsHWb67i4AHnTLnYYk78eFVIGQJpk2DamLHBZw4L8MDYVep7oYm6?=
 =?us-ascii?Q?YYICS2hOEQeq1GKNC5QC4fmsbPRcfY02yO9OKnmwH8vMeWBciS1kKMYvKJx8?=
 =?us-ascii?Q?+CjPEoSXyYoEV7rs+hhcxsvQb0pOSaeFCv5viEWwJCxW4FglljVtdMt3kis5?=
 =?us-ascii?Q?pVGkRxDTOrYqPOc1tlhRb2al/MIQhxoHCx803Bb5m736SmeSB2AAJJue332J?=
 =?us-ascii?Q?zGdiu0FNuzL7NNy829NkoPB+d98UA4WBNapiS2k8soTDB9RlDTJl0U4Q/Z+o?=
 =?us-ascii?Q?gxtZWTk0U+Lue45dsADqq5byNmtAg/sI05ifYogiPTHYGwCWlxBvQWj955wK?=
 =?us-ascii?Q?NaC/0fuXR6/cO+NR0phgdf86geaZ0Ce/8WzX15wP1PsszvTlU72oWoIonjXD?=
 =?us-ascii?Q?S+UXKID1xyqZEgicAzVBDZ8ROCMMTClUFbGSL9oHa7JH870YnWu30Kzy3r8R?=
 =?us-ascii?Q?0UPNnJK2VN6JUB65ErsOsnLVDTAmKfjT2C0D1a09tB1likk+ArNLApQijtjd?=
 =?us-ascii?Q?RFAt9GYL85ugXaVttu46QZku4oaMHmzpKmHzvwkp3dmPvS3m/Ce6/3L+jgKK?=
 =?us-ascii?Q?GeDU/l6auvvj6O2uSi4BQ3Sb/G71P+8mb6JuYL2818xCyY79OX9JLeZWjcHz?=
 =?us-ascii?Q?35ogDzr5CqTVBD/OKZVYZX3nvc8AoJGnGXmms/F6Ijdzimz/1DeJw9kXZ48r?=
 =?us-ascii?Q?ERL23+yAzJRDPOLbfLQLbrxD7AXUXEF/7ZNGg1+wOBbWAqjbX4clrVOHrClx?=
 =?us-ascii?Q?1s7CILgwuEBDyytajrStdqmrpxNgavhtvFEjELrf6xALt5kCTs/FUWVByalF?=
 =?us-ascii?Q?jGPoxpGbPP0D5JsHCNkgpOKh2P+omoCMi3ce91oJ1nTymW1HmqJ9oClKZFgp?=
 =?us-ascii?Q?ThsJRAQvd9hI/i6yS/LeoGChkhuu+1jWXa6UZFpuxds1t8l2h5lpfm6LS3iG?=
 =?us-ascii?Q?aMpyfe79mSZFV/ERIIpisSETD6i/DuW3L0QjpwoVvq0GO2iy5ageTr7b631o?=
 =?us-ascii?Q?8jZaxKYQ+gQdFjNOXmNizOCkyiYCYTovoUrRuztnTOterp23y4zestdvEKgw?=
 =?us-ascii?Q?TPrgeeP7l20QXVxhjoQXUcEwUDXVeR0KJojqVM7un5C6fR/XQA5GvbsdlfJb?=
 =?us-ascii?Q?AHDbASN5bf/zNM01Ve7PY3lOESHoyX5u6QBN5DOScXKL8TClCnTxJjyjpRnK?=
 =?us-ascii?Q?BPwFqUBHz6zLQmiNPpx+CuwHluS4QXb2tZXvlpZrozb3eNFP3ANerOG7Jgl4?=
 =?us-ascii?Q?jEJQnLWPpXDSiVqwhgHg0kn07do05xmJ3N9F+on6E327C0OxMWbosfQxrbKW?=
 =?us-ascii?Q?+LJHs42bE+b97Y/9/xpek5kcFtpZJz29IGJrp5XNf6aKAHyHpDZKXSp8JQXO?=
 =?us-ascii?Q?HFO7JvvzGUCwuJmP5yJExET+cbdnFRjxDp3aUatfBp3QLGJlpKJXgoJ36W4j?=
 =?us-ascii?Q?3vE40eLaY00ZwH0MD5vhrH+br3cQqpfqWlrY?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB8796.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(38070700021); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IHEZxf3QXrmoU7zXZ/uScA9iymup5UzHY5mWg32SDmTfJjv8pZ9Vlwlf5HaM?=
 =?us-ascii?Q?BIQ/cKHm7C51EHbafIcE+pu5WbVMvQDNrlWErKRObfGtYsw2BVMw1SP5Umi3?=
 =?us-ascii?Q?A7L2LMMbYUyaSBhbJvpZm93jMZ12OCxPBXkaEFA4ax/hKohhtg0rjIPL/Wcd?=
 =?us-ascii?Q?kmwSnf6JbcgIu6ccj4uq2UX15X0Y1oS5QATA+3QJJh26Lof2c3lFSVBcPnCs?=
 =?us-ascii?Q?bxxpYbk12f7PWJHLFMpRTK4ujFZbtE3y9XVIQYClxiT9cmbqpspaxHRJy3Ie?=
 =?us-ascii?Q?7dWykwfXmPxA0AaPqGZBlc+Qj8lC4w/miJzLpTYQd+88M0uyd4FpGZ3c91Hw?=
 =?us-ascii?Q?BNQfchAyv/o+OdHFPut3T0gwNPQZZg85TPgcazjQ0puallWM5MpCX7ZVryxO?=
 =?us-ascii?Q?vZLSEIldjarPqywIyZfZCb5eibMYZCqCw4VH+lnoFs75A4UcNrm59U8FwaNd?=
 =?us-ascii?Q?SMdfLdXe5feID6nUcFMPb52IzaClNeLflmoelcmB8gmlmFqUYq3GTyBTgHsO?=
 =?us-ascii?Q?jcDWlfvizdq+MFGPnA3kiyKYOvpBS7U7XbN5ZJngCQ1TiMPthzgUN6QdpSFS?=
 =?us-ascii?Q?QfSz7mGN1Paths9SlsvpyPXXu/cWEbfJh6izegjBggzGEJEpU+NhFUG7UpnM?=
 =?us-ascii?Q?iNK6C3SMpz5rPTSpBrvb7hV4dHDZGplDqqSng+kpQwcY9emP7pPMY2p4c+bW?=
 =?us-ascii?Q?dOehNpMJhgbQ0Mp0EuwiqNNv2HOsBR1LDGECa/FNOp03oi07oqd5NGkf3XDD?=
 =?us-ascii?Q?+BoMeqAo1urSVwY09k8eKUR1/OFp/Rnn9/1A1jlrHuJ36fmDl7qlnEdlRiE/?=
 =?us-ascii?Q?vJAkpIIP7mbhDDCmHwOCoEITUGD7w/Ilt7EzsSCTKkEoFSHmVIN4Vaussj+C?=
 =?us-ascii?Q?g2slw4rSh2c3MBtDukgQ7c0YPmyhlUqTHhfzIS73vRejBwWuB7wzS4UOWCsd?=
 =?us-ascii?Q?WrXVlGAM1pOuzMYEErFTjkYtRwTitUy3AvEJCbB1TMiS1q0+EtkwehFF7Hkl?=
 =?us-ascii?Q?WGEHrsAksslVvC/6SWzrQrfF6EiTlOclxFq6aI7Uu5HKUnQ/flqGQn5uuygu?=
 =?us-ascii?Q?goZmqEt3IKgescmcjxOUKuRBJL7835E9hn6j6pvCJrIKiQzTqHYZttRhwU/1?=
 =?us-ascii?Q?oMXmticIfeB+BGjVHVK8z4od8zze9VfyGK90oup3nKAgH1LUIwgQGeZ92ElQ?=
 =?us-ascii?Q?KYNHNmcrJ92bSf5rX1xkokEEYOnCpJyPKqP82nw/nwcUnHKVpUDyUR7wdXRH?=
 =?us-ascii?Q?JTDcJ7sV3d92eqg/McXzMDoQBsiFz+RyghcVz1sGMtd4JzfN16UFGTkaeMTx?=
 =?us-ascii?Q?kSS3WV9GcUuI8Y5y4YOqR/FGicn6sDj/NXAElvXXRYv5AyXz2c38WS3B5qm5?=
 =?us-ascii?Q?w1tO8ams6JwLBGGAvBMdib/EknOcmvl0Q76tMtrlcIHWmSpQhK0bMR8yJScr?=
 =?us-ascii?Q?nC1fiVTUfE85nRexzfqrARepRNBEHdjLZB4H9pn5phqP7fmpDmv7W2LPXRlG?=
 =?us-ascii?Q?aK3YQj19TktuLZHWkbhNVCsmAq20zD37yTLn2wCbMy9RztvpcuValtFCibb2?=
 =?us-ascii?Q?yMtkE+VvB+UPcGjlxJM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB8796.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d924e6bb-14ef-4a0c-e28e-08de1c48748d
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2025 08:51:05.1628 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dUBe9PReOXdYhXr3uduhyc2mAxZV+djVhbcu5hL74yPn+3GyFWZsX/MPf7BaEneK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6821
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

The series is:

Reviewed-by: Tao Zhou <tao.zhou1@amd.com>

> -----Original Message-----
> From: Chai, Thomas <YiPeng.Chai@amd.com>
> Sent: Friday, October 31, 2025 3:05 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Zhou1, Tao
> <Tao.Zhou1@amd.com>; Li, Candice <Candice.Li@amd.com>; Wang, Yang(Kevin)
> <KevinYang.Wang@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>; Su, Joe
> <Jinzhou.Su@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>
> Subject: [PATCH 1/2] drm/amd/ras: Increase ras switch control range
>
> Increase ras switch control range.
>
> Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h       |  3 +++
>  .../gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c  | 25 ++++++++++++++-----
>  2 files changed, 22 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> index 556cf4d7b5ef..40c0bf85f1d3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> @@ -591,6 +591,9 @@ struct amdgpu_ras {
>
>       /* Protect poison injection */
>       struct mutex poison_lock;
> +
> +     /* Disable/Enable uniras switch */
> +     bool uniras_enabled;
>  };
>
>  struct ras_fs_data {
> diff --git a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
> b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
> index 8007e49951d8..e1f6db13c55f 100644
> --- a/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
> +++ b/drivers/gpu/drm/amd/ras/ras_mgr/amdgpu_ras_mgr.c
> @@ -283,6 +283,18 @@ static int amdgpu_ras_mgr_sw_init(struct
> amdgpu_ip_block *ip_block)
>       struct amdgpu_ras_mgr *ras_mgr;
>       int ret =3D 0;
>
> +     /* Disabled by default */
> +     con->uniras_enabled =3D false;
> +
> +     /* Enabled only in debug mode */
> +     if (adev->debug_enable_ras_aca) {
> +             con->uniras_enabled =3D true;
> +             RAS_DEV_INFO(adev, "Debug amdgpu uniras!");
> +     }
> +
> +     if (!con->uniras_enabled)
> +             return 0;
> +
>       ras_mgr =3D kzalloc(sizeof(*ras_mgr), GFP_KERNEL);
>       if (!ras_mgr)
>               return -EINVAL;
> @@ -315,6 +327,9 @@ static int amdgpu_ras_mgr_sw_fini(struct amdgpu_ip_bl=
ock
> *ip_block)
>       struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev);
>       struct amdgpu_ras_mgr *ras_mgr =3D (struct amdgpu_ras_mgr *)con-
> >ras_mgr;
>
> +     if (!con->uniras_enabled)
> +             return 0;
> +
>       if (!ras_mgr)
>               return 0;
>
> @@ -332,12 +347,11 @@ static int amdgpu_ras_mgr_sw_fini(struct
> amdgpu_ip_block *ip_block)  static int amdgpu_ras_mgr_hw_init(struct
> amdgpu_ip_block *ip_block)  {
>       struct amdgpu_device *adev =3D ip_block->adev;
> +     struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev);
>       struct amdgpu_ras_mgr *ras_mgr =3D amdgpu_ras_mgr_get_context(adev)=
;
>       int ret;
>
> -     /* Currently only debug mode can enable the ras module
> -      */
> -     if (!adev->debug_enable_ras_aca)
> +     if (!con->uniras_enabled)
>               return 0;
>
>       if (!ras_mgr || !ras_mgr->ras_core)
> @@ -360,11 +374,10 @@ static int amdgpu_ras_mgr_hw_init(struct
> amdgpu_ip_block *ip_block)  static int amdgpu_ras_mgr_hw_fini(struct
> amdgpu_ip_block *ip_block)  {
>       struct amdgpu_device *adev =3D ip_block->adev;
> +     struct amdgpu_ras *con =3D amdgpu_ras_get_context(adev);
>       struct amdgpu_ras_mgr *ras_mgr =3D amdgpu_ras_mgr_get_context(adev)=
;
>
> -     /* Currently only debug mode can enable the ras module
> -      */
> -     if (!adev->debug_enable_ras_aca)
> +     if (!con->uniras_enabled)
>               return 0;
>
>       if (!ras_mgr || !ras_mgr->ras_core)
> --
> 2.34.1

