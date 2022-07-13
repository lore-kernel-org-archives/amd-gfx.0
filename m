Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CD0BC43334
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Jul 2022 18:04:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C38D511AC21;
	Wed, 13 Jul 2022 18:04:15 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2067.outbound.protection.outlook.com [40.107.93.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D91811AC21
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Jul 2022 18:04:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n/8T+XOrujCDjczPQgn02KzpGnvT36FY6qVVfO1ilfN2QYUaZyzJ6qkykBbio7iKouBroJSTjRqM3nwK147kBmEteM6KVXg9A5/SOm+qUW20TO+REmrWMuoa7CZqmsd5RtlEfJAXHXCmjanVTVl3o5D+Qqd9dyS30SEO2qpkLCvW0dAX0twpvHD39G+Y4LLup4xIjcDD2u/0W+rMSlBT7rw3Bb8KJkgExZztxVktTnbJc1irySGRgPBU9wkHS5Xw9/7zeZGS8VDnGtCRu6z46BeOG205WzR2w7StaMBqn4KMjBQJ9NMqi4kEdf2xhE//gTDoL4Lkp7j8zH+/XiI7BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CSvH907SSxF8zGtDh1zADIz+5vSqqOygfGOd/u5x+ww=;
 b=TzaS0uBG3KfBFpM/3SHk4AL30wU6IlHW9oDxFFdmRwVWsjO0q8m4JxSErrXwSajhEJxm77wJikg8Bl60aKe8yO8JIVFAoe5N99pAE35Ve+gxfSVra2ZxqmtTIvtvCm7ZyNDmj0o47iKDAoC6Jl8pd9SPTrqAd9o7vnAaR3g254eL5/jIDc1VEP3hlh/Pzp0fC3JQDZOzlqtnG5hWEajacUF9st6ODmD5PvXQLaKHN4pnW/DFt258apFEOqOHFbDNSEvGANpJeLTrAICmYOSsPlzXPgq9Bv45x9P9hWRKzkhWbZSZbGRBE1AaHR71Ud/V/wSjXAB8z/3q5umjnsiWfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CSvH907SSxF8zGtDh1zADIz+5vSqqOygfGOd/u5x+ww=;
 b=f2tj0w6QGHj2mmn3bfk65mPSecm3ETk8GCFyBxrhKNXBZQaqlN9yTdSUfZ2hrK/+1wXVKd9K8/XXCfnWg2Q0hYGTnsQByCmwGZDQbbKkrVUSAw66hKKyJfmoq7P2Hjh4XDHLqOjRvK9qiem2PbkOCa21qUh/4QXV96RJ7xUJtR4=
Received: from DM5PR12MB1308.namprd12.prod.outlook.com (2603:10b6:3:76::7) by
 BN6PR12MB1300.namprd12.prod.outlook.com (2603:10b6:404:1a::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5438.13; Wed, 13 Jul 2022 18:04:12 +0000
Received: from DM5PR12MB1308.namprd12.prod.outlook.com
 ([fe80::9169:810:9f70:7b97]) by DM5PR12MB1308.namprd12.prod.outlook.com
 ([fe80::9169:810:9f70:7b97%11]) with mapi id 15.20.5417.026; Wed, 13 Jul 2022
 18:04:11 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdgpu: use the same HDP flush registers for all
 nbio 2.3.x
Thread-Topic: [PATCH 2/2] drm/amdgpu: use the same HDP flush registers for all
 nbio 2.3.x
Thread-Index: AQHYluKVtpJmnchpu0ekpEYgiADcGK18l/ig
Date: Wed, 13 Jul 2022 18:04:11 +0000
Message-ID: <DM5PR12MB130888E2293A6EF2B491418A85899@DM5PR12MB1308.namprd12.prod.outlook.com>
References: <20220713180056.529423-1-alexander.deucher@amd.com>
 <20220713180056.529423-2-alexander.deucher@amd.com>
In-Reply-To: <20220713180056.529423-2-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-07-13T18:04:10Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=efdbd873-7f57-4f1a-bee0-166f172af7e3;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2bbb8c6b-3abb-4bd2-311e-08da64fa171a
x-ms-traffictypediagnostic: BN6PR12MB1300:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GgtsUF+IZ+RVa52aCHfPQQ+2f+7zJLoUwD4G17qYSCKllH1PFLdnp+5Tm+BLTxdM5JNILIuF0Sn/eJ9dJEUyfYkhRJ6/hUw6xY21KC5eTzdzQK++nHFsqC2r8S+CLKVQqJ/9KBJOo5pD9LHyge5GvQ51XV3E/Dd6Ivf9GNYn8cpg+4xR77iSA+cCWHn6PPmdLzucavnxV/O7dwxpQpEFTO6sbzsTWhAtTgphrCdEGAbA9srv7TvKZfhcWk7ZWr5KxvtmUsdEy8T+Ymvhe8Vf83gnrMQtk45cXRiQgOSFp+TuEZ5DvZ//8MCJHyj9EOQMVyc8o3DPK9pdjIICatIu3trSoTKBeW98EM40a/fVQY2+jRU3dZrPYqJR3T3g39gxZov2/6h1zeIQt3Vl06RrT+/Nujo4fwAjczcqUDout5sDWR3vAD9sh13YCxs3kX23K8tZ+cMi6p0s+poWTOYgz0TBM7w67//zk5XW75DuYBEhe3SarLpsrBs0q0ZLhLKjSVikganv3+bekJSEdQZSlzX/0Doa3U+GSr9bmeIfkedGzAlfujIlxcUQKlAi9T5W+7iPX3TVTTW1JMAAvZB+GJKhPvmzRyY2+hDS9JUX7IaAC1B6crClOQ65plkJetf73kWeMexXhC3OgN7xZLfeazKn0eA7OzKiThkMOGBqi3GgsPxb5l2N19pSzxHjBduEVUPl+HagC1hO6SBvyd0nFtjOeLX5op6p7vm6vW2JCNprYwWeIQPXCAwW9PiuJOT+JplamaY39eMGocvkUsJJAG8pEj24qHGNRbvbGp94hga8gJvYUlxDbvN7xkAC7B2z
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1308.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(346002)(366004)(136003)(396003)(39860400002)(122000001)(2906002)(38100700002)(83380400001)(5660300002)(33656002)(55016003)(8936002)(38070700005)(110136005)(86362001)(66556008)(186003)(66476007)(8676002)(4326008)(66946007)(52536014)(64756008)(66446008)(316002)(41300700001)(76116006)(26005)(7696005)(6506007)(9686003)(53546011)(71200400001)(478600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?C0kzpUXleQPbK/6pZ3z9Z2A2MzGLMLFBXMIGl6rgPeWq2MtG16XVo9bCBmrt?=
 =?us-ascii?Q?bXFgJ9LNoxuKLJ3/adTE6a1l/HcgFD15I3KhqvBUxBRzZWHEK8cgtfG7Xfzg?=
 =?us-ascii?Q?YJv8fMeGy472YZvzbPj1/gDQ1oWHfG2Mr2a7HEa0aIKKkfC2SNNzs75O+9wP?=
 =?us-ascii?Q?CkiSSN7WHDwFfR7Fq0Q1NEPXLqkzearcOe8oPFNJpprKiRXZqVfAlC6NGUuq?=
 =?us-ascii?Q?PLS21sX5SreIN5j28oa1/D1it786Oa222B6sq//nFIOEepJQwBAz4VM1v1mc?=
 =?us-ascii?Q?KfK8BOXTtUjZMywHYBMgENnUhw7gXwa4u9+vq3rQse3tJbq2laSUddXd+/Z5?=
 =?us-ascii?Q?xQnky1RRJIB1xG4HreylxrRr+9f+5P+tb/37RA/kDj0ByWv20/pUTIQ2/bzM?=
 =?us-ascii?Q?3DN6w08tblwmHj7tlxZDbkxIsB0z1tCiNySOOrIDivZBATi+fufAINLENKJl?=
 =?us-ascii?Q?7zr1QhZiBd3gxGXaZregGdr/urZFDxdMaM1YHoZr9HSJknOcwEtE4ceV67x0?=
 =?us-ascii?Q?g0nE4dfHunsWJ5iZWe1WJQJ2d66z6ptZdbKQzbazZTCDHw2m8cObRUVw/4he?=
 =?us-ascii?Q?Jly6Rtsna/nccexN5GRH/m6NDwtdHRSg6sHnUZ6Aed+KGVGL1LtLEZwn3LSY?=
 =?us-ascii?Q?fJdgE1jMUumjgeKa34IgfocxH1KN6sIdWTC74+nx8xFMsMlVMixzM0UQGPiQ?=
 =?us-ascii?Q?L9Y1o2rwg8+M8MyO5bHfDeVWmrut3AH3IdaJrXpC9uY643enqkiRXMtE84E6?=
 =?us-ascii?Q?1+/bzwR0vU2gt1jk203uj06zTHMvp8sHJQsutDHF/K56uo1czbigDM2bhCiS?=
 =?us-ascii?Q?JlgthsyofudS+kLcoI/hry0pwVEJo4wtptn+6eplliZ24UXPrd39aXqA3fiO?=
 =?us-ascii?Q?Mu51pZu1qBGRMXorP7aO3xmOPCCcV3nK34vsLGXtqME52aW6mwT6pkUOgDHE?=
 =?us-ascii?Q?D7o4RHL3VVd2NZ6k2hTugoeDV3wHNM6aIlo4LrMbCdRsDfXD+LKuwB+pPXAH?=
 =?us-ascii?Q?TJ3dcZd6KuA3SCV6sXrDBkQe5z7KKOEOTjPRybdKex22/O5EuPpWE1IgDRKK?=
 =?us-ascii?Q?KwQq7JQrGJMv3BI2/oHO3ktO9HU3dVxTdfEuvcMg1JPr1ahEgJ6yvz3oKGgG?=
 =?us-ascii?Q?lGHGeb6/CXK9eBf7mSVGx9STmm66c8yt/pq3OkyOOTm+G+RXfdnVl1cHEUYA?=
 =?us-ascii?Q?tgggBLUN4yjeUzsrvWryLhtyOL9eEnZCynN6AtRWSOd6O2G2oIDDmXL1YV0O?=
 =?us-ascii?Q?fWYVJwEH/jnoCgendk1XsQitIV3IAsghfMVG7Whd1lKoL/FuOO9poVqXEIOk?=
 =?us-ascii?Q?va2mz4r426eOR2ck+te2EQWGcn8lw66BgXYK6hB7/z385nbVnmA18mAsnuNL?=
 =?us-ascii?Q?1zp0w4I87aCa4SYRVBKYaecY0wwSMYLLr5K8qMWto+S1ja8vkw3P2DKGJHvN?=
 =?us-ascii?Q?dej+F0jPz4h9uIN9IZdK7OBLgin+zvjb/8rOpm4adB+Gh7wG1rf/kAZ8xYK6?=
 =?us-ascii?Q?JTNevTfiqjr8INUN0WuHVE+sU4I2E/z3s2hZyfcD3Bm6JJI8cJwExAH37JRj?=
 =?us-ascii?Q?DXjaJ5UCbg4xDo4OUQA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1308.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bbb8c6b-3abb-4bd2-311e-08da64fa171a
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2022 18:04:11.8071 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GT+yzt/ozz2tEjG2nEpmoURMUsOkjzSM9KkXnJWEgX5Vdgqg+9jvVThnyUUvpo6FTyzlcxgnvXpSfBLTGrbrrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1300
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

Series is  Reviewed-by: Kent Russell <kent.russell@amd.com>



> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> Deucher
> Sent: Wednesday, July 13, 2022 2:01 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH 2/2] drm/amdgpu: use the same HDP flush registers for all=
 nbio
> 2.3.x
>=20
> Align RDNA2.x with other asics.  One HDP bit per SDMA instance,
> aligned with firmware.  This is effectively a revert of
> commit 369b7d04baf3 ("drm/amdgpu/nbio2.3: don't use GPU_HDP_FLUSH bit
> 12").
> On further discussions with the relevant hardware teams,
> re-align the bits for SDMA.
>=20
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |  5 +----
>  drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c        | 21 -------------------
>  drivers/gpu/drm/amd/amdgpu/nbio_v2_3.h        |  1 -
>  3 files changed, 1 insertion(+), 26 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> index 4f83897a54a8..22144ba6c7ec 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
> @@ -2229,15 +2229,12 @@ int amdgpu_discovery_set_ip_blocks(struct
> amdgpu_device *adev)
>  	case IP_VERSION(2, 3, 0):
>  	case IP_VERSION(2, 3, 1):
>  	case IP_VERSION(2, 3, 2):
> -		adev->nbio.funcs =3D &nbio_v2_3_funcs;
> -		adev->nbio.hdp_flush_reg =3D &nbio_v2_3_hdp_flush_reg;
> -		break;
>  	case IP_VERSION(3, 3, 0):
>  	case IP_VERSION(3, 3, 1):
>  	case IP_VERSION(3, 3, 2):
>  	case IP_VERSION(3, 3, 3):
>  		adev->nbio.funcs =3D &nbio_v2_3_funcs;
> -		adev->nbio.hdp_flush_reg =3D &nbio_v2_3_hdp_flush_reg_sc;
> +		adev->nbio.hdp_flush_reg =3D &nbio_v2_3_hdp_flush_reg;
>  		break;
>  	case IP_VERSION(4, 3, 0):
>  	case IP_VERSION(4, 3, 1):
> diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
> b/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
> index 34c610b9157d..b465baa26762 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.c
> @@ -328,27 +328,6 @@ const struct nbio_hdp_flush_reg
> nbio_v2_3_hdp_flush_reg =3D {
>  	.ref_and_mask_sdma1 =3D
> BIF_BX_PF_GPU_HDP_FLUSH_DONE__SDMA1_MASK,
>  };
>=20
> -const struct nbio_hdp_flush_reg nbio_v2_3_hdp_flush_reg_sc =3D {
> -	.ref_and_mask_cp0 =3D
> BIF_BX_PF_GPU_HDP_FLUSH_DONE__CP0_MASK,
> -	.ref_and_mask_cp1 =3D
> BIF_BX_PF_GPU_HDP_FLUSH_DONE__CP1_MASK,
> -	.ref_and_mask_cp2 =3D
> BIF_BX_PF_GPU_HDP_FLUSH_DONE__CP2_MASK,
> -	.ref_and_mask_cp3 =3D
> BIF_BX_PF_GPU_HDP_FLUSH_DONE__CP3_MASK,
> -	.ref_and_mask_cp4 =3D
> BIF_BX_PF_GPU_HDP_FLUSH_DONE__CP4_MASK,
> -	.ref_and_mask_cp5 =3D
> BIF_BX_PF_GPU_HDP_FLUSH_DONE__CP5_MASK,
> -	.ref_and_mask_cp6 =3D
> BIF_BX_PF_GPU_HDP_FLUSH_DONE__CP6_MASK,
> -	.ref_and_mask_cp7 =3D
> BIF_BX_PF_GPU_HDP_FLUSH_DONE__CP7_MASK,
> -	.ref_and_mask_cp8 =3D
> BIF_BX_PF_GPU_HDP_FLUSH_DONE__CP8_MASK,
> -	.ref_and_mask_cp9 =3D
> BIF_BX_PF_GPU_HDP_FLUSH_DONE__CP9_MASK,
> -	.ref_and_mask_sdma0 =3D GPU_HDP_FLUSH_DONE__RSVD_ENG1_MASK,
> -	.ref_and_mask_sdma1 =3D GPU_HDP_FLUSH_DONE__RSVD_ENG2_MASK,
> -	.ref_and_mask_sdma2 =3D GPU_HDP_FLUSH_DONE__RSVD_ENG3_MASK,
> -	.ref_and_mask_sdma3 =3D GPU_HDP_FLUSH_DONE__RSVD_ENG4_MASK,
> -	.ref_and_mask_sdma4 =3D GPU_HDP_FLUSH_DONE__RSVD_ENG5_MASK,
> -	.ref_and_mask_sdma5 =3D GPU_HDP_FLUSH_DONE__RSVD_ENG6_MASK,
> -	.ref_and_mask_sdma6 =3D GPU_HDP_FLUSH_DONE__RSVD_ENG7_MASK,
> -	.ref_and_mask_sdma7 =3D GPU_HDP_FLUSH_DONE__RSVD_ENG8_MASK,
> -};
> -
>  static void nbio_v2_3_init_registers(struct amdgpu_device *adev)
>  {
>  	uint32_t def, data;
> diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.h
> b/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.h
> index 6074dd3a1ed8..a43b60acf7f6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.h
> +++ b/drivers/gpu/drm/amd/amdgpu/nbio_v2_3.h
> @@ -27,7 +27,6 @@
>  #include "soc15_common.h"
>=20
>  extern const struct nbio_hdp_flush_reg nbio_v2_3_hdp_flush_reg;
> -extern const struct nbio_hdp_flush_reg nbio_v2_3_hdp_flush_reg_sc;
>  extern const struct amdgpu_nbio_funcs nbio_v2_3_funcs;
>=20
>  #endif
> --
> 2.35.3
