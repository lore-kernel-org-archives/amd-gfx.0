Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51E35C3ABA5
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Apr 2025 19:48:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ADBE710E279;
	Tue, 29 Apr 2025 19:48:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OYkxqMWT";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2056.outbound.protection.outlook.com [40.107.236.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6AC6A10E23B
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Apr 2025 19:48:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NMX7snhyDd/IW6PAo3FEvc552ITFfTw46hNPfwnLvHPq5hvLSf7000EbPtmGldymt3mKokHzW6LaWKGFlgE2nrmsHuap7rFmVJRCvhG96oYl6FA4KFIioDtcXceGMj+F0Pf1Ev82Bhnx85DB8p4Mgbx+AJNVyw44jf7p8i45tk8rpz4WI9zFQB8os1WXoxKusSE+6pVhPWiElWZZ7QvLv/18Gh6Jee3RrQZyQlFB++NYjhMmKpgBgmcS4SAtHUq+4LvE0YSb33Qs0jZeicn2dDuzlfFxWbWUQs+ya7zoENO7frz+UDql4hjX7HKxuXuiGx8/jQxcodxUcyUsJPqspw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7KKBI2F9OqT6mPpiXIyN9AxFAaj7VltOV05XHHbcwrY=;
 b=rNQIh8/sQp5ehp1P53zR9QeFy1/jhCvAcAgfRG/embq26K2nibUQFHH5f4IroKGQ8JjnqxPAHlvnhXf+rRWE6esDTJgflgxUrcWoX2FJ3ad8nUa72BM8uLcBlXKpcR9QeR/m/npYaheKo+qQrbkLh6mUvzi0Ftp6mI63ZfmqjYhKfZLpvGC7FakZe2m/6kZi+ciD5YZ7647cUTwDcjQ3YfUwE8C5Oabv9UJ2mDF3F3nMSN73uCV9Aio3TAtA7nU+NGDXil3qKt+6fG6IBeo14gcY9Skh54LqidiNBySaMCH3gHbQkoHagtwE0Jcoo4W60DMReSxNd8kuKZabCszfhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7KKBI2F9OqT6mPpiXIyN9AxFAaj7VltOV05XHHbcwrY=;
 b=OYkxqMWTiK63rQXBETGhaquM5DqrRclBOgfYUJtvgt/hZhC7JRP8jVNe8osKcQjnGMu5G6AiNiqmTsH4unDB5pqx3oVuE+Wqhr9GYGXbi9HFtV1+WMDmNxsuioTwstGoiNRXwGp5773sq+ADo2i8n28lifUZ5F5IHOPGmdqiLv8=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by PH0PR12MB8797.namprd12.prod.outlook.com (2603:10b6:510:28d::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.20; Tue, 29 Apr
 2025 19:48:18 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42%5]) with mapi id 15.20.8678.033; Tue, 29 Apr 2025
 19:48:18 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Xie, Patrick" <Gangliang.Xie@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "Xie, Patrick" <Gangliang.Xie@amd.com>
Subject: RE: [PATCH] Add support for leagcy records in eeprom format V3
Thread-Topic: [PATCH] Add support for leagcy records in eeprom format V3
Thread-Index: AQHbuNSevoRjaxsRTU6wZvz35i4OtbO7DV1g
Date: Tue, 29 Apr 2025 19:48:18 +0000
Message-ID: <BL1PR12MB514493AEAEFEFF41B4106BD6F7802@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20250429070121.299873-1-ganglxie@amd.com>
In-Reply-To: <20250429070121.299873-1-ganglxie@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=f76aa62d-a490-4b00-85cd-370cd16f818b;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-04-29T19:47:29Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Tag=10, 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|PH0PR12MB8797:EE_
x-ms-office365-filtering-correlation-id: 93cacfe7-6b61-4dad-d2e5-08dd8756ca24
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|38070700018|7053199007; 
x-microsoft-antispam-message-info: =?us-ascii?Q?nh7ve7HKO7D82vfOG9vJhvWI3Ek7S596Gol3ByKED9CGBvZV4OLXf1IjXPpO?=
 =?us-ascii?Q?I1tEStGWh90q53SH8McQbm6LTNcQflMFRB+XwwJcBhckNNdzpUwQaRwLxLgZ?=
 =?us-ascii?Q?dv2wE9oi2KYZsq0S2blqnitm9AVmolFFxzDRu86AalEdiArHd5FGrXj0yoc8?=
 =?us-ascii?Q?iOibayRHNVc0i3eV22BUCAafRJ2ngrsSr5z9Wy9xyFjDSvmfYvOcqUbbB8wy?=
 =?us-ascii?Q?laZ3K/tbS3mgJPE6Lt5airb5IJfH3UcdsQe/D4AMivu4/5vwf5jZstz/Ab1y?=
 =?us-ascii?Q?dZTWJ7cH5ZEU47nuHkYqwJQamh/i6TQoUlMPgSstoSJj2wjslCLTKhG6vTsW?=
 =?us-ascii?Q?TpMALw0KW1fOg70JP2PjSBruYwydzsaRgFaiznItvUFY0Lp7bpD03+z1Lu+b?=
 =?us-ascii?Q?N7GGdosbDs0fu6aDfH5IEBIPGVITs8LaLKcZ4aqvq2fVpuJ0olj9U78FfWn+?=
 =?us-ascii?Q?T/xqzdJdg+jhZ8+uFP15ADE1S2HjM6TZh5VHDn0bqAHgvFsaggH3AH6WVe7d?=
 =?us-ascii?Q?Ab0vFamv1LHq1MCcotwMQcG8FRJV3B8YFk7zl3MwpwjVdI+1l3C9w9vsQYwa?=
 =?us-ascii?Q?BAg3THja6ascWeOpEzg/2xcrdGFh79TbXYdBYq+zKTFdutiwTAdjj7LPUXzN?=
 =?us-ascii?Q?/XmSrOZEakpp6k0a3Tgjtwk6FkaIxly7/a29OtI69NDzAleqd/EhyBxsFK1h?=
 =?us-ascii?Q?fjuWuUch8nleeg3QZd1WeUMhgE1r/VjsZrLjzEVrheiOZvPZGq3YN8j0+vJx?=
 =?us-ascii?Q?5tVvAIoudL8+p95WqDPymjfMxQwca1RGXo9NlOCtp2G/8WYcwIj6uQHXSP2j?=
 =?us-ascii?Q?CqN7Hz8u2SnqOhyRQxyWaBfuU0hHdw7KCwF7Uc0pYAnTkorJxfBOnlWhRgQO?=
 =?us-ascii?Q?LcLB8fAg4UoY/P7441muwBramecGWvHgQV9394OgEmVMY8SJlmTnowT5xj5Q?=
 =?us-ascii?Q?GfhUt9SjDHbxWN7NM0Vf/EVNoCFQISeUnUvwN4aowoMJWzgPUd3rHXJZ4vIv?=
 =?us-ascii?Q?Y3q6nPMvMG1v/VMzle+pTKMreK85516atQC7ckHOGR8Lvev7xco1xlM0bsnB?=
 =?us-ascii?Q?JV8XiFQwgC6bsJdryrN5kqCI2uI0OH9ZdrODZ3XFlQjaIgjtUkBhXk/glsi7?=
 =?us-ascii?Q?S66t/wRixwJii2tGuE0y6OH7qIKFXqCghP0vpSl2ocHN+mDP1r5DNAPcH2Ly?=
 =?us-ascii?Q?v330gnIxwuF/MOTacgsfO9FfIU8cSNyv80dYfOSv/fqz1MZiLC7nwb12e6A6?=
 =?us-ascii?Q?FEQcsjgLYOf7YVMO29v91NfuqQ1tExaeiIGViyZJO+WdrLkq3RdCsm/kqY+y?=
 =?us-ascii?Q?k7OS4ZKTf2dGO9akehcd/i7NZx80hEWX9bvLecI47Ai2w9P+NAGPWgkYQfgP?=
 =?us-ascii?Q?uBkdp43800dVbdAfs+fzW/uFyqR48M/KXVF9sJnp/yLGQsxg6NvRYav3NgCp?=
 =?us-ascii?Q?ZklsBtv/h/SPIMD4GT4V/dbWub6bpAwSQBNTIbTSNAxRXDadXM8xDQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DwdzxccieXTWy8k7TEepQSyJLeQ996FWsMSvlwqr8+2FxESxgGh4qTl+GGwA?=
 =?us-ascii?Q?FVn+9V8eGxrbFeHmZFebbSFPlLyXfzG8rZplh7vjHcp7Jd5+Bhf0dkP12mHv?=
 =?us-ascii?Q?whm+XpqRGm5RxiX0SANMYyoTKeDTW/EhffDPucqyy1+GgxSZvSGzqJ+7IUA1?=
 =?us-ascii?Q?f7LJGJHHIkD7lWY1AdC0x+kDvIRtf+mLoEfCKumD9oMI5a0iwwxEJHpFDi2w?=
 =?us-ascii?Q?iruOJvIDp4AxpB5hV5xzMx/nxcvXFfYkZzZex/RDAU77PTHcYkuYAP4SsUy+?=
 =?us-ascii?Q?FMMKC1ODycHbIgW2j8eMlHa7LPVkFZVgtsrDGDcmRyLyGlATIpY8Wx9tdMp7?=
 =?us-ascii?Q?b3Fw3BwDoRKJUqMOqhqCJ0Sh5Nh2tm7DFJ8Onkr1QlUoVSmKVylfvPP9ybGZ?=
 =?us-ascii?Q?AvutdhwYFQUm4l//acDDd5BobCbS94qYqQ6QJ5o0zn8ItRzH25lbraVzYHub?=
 =?us-ascii?Q?DbcSDLBS5YPPKEKCCVSm4q46Q2QySY29pJrMnBNr9byp9zcm3TK94Fut5kwh?=
 =?us-ascii?Q?VoRbQ7G2RP6lNqmuDbuSdm9mhCh7MkSo+p88RX5uRxUMSU1RNTRRh8Abkfa+?=
 =?us-ascii?Q?3CruZzgHF9S31luiR+I5nowinIvdzF1yo1PKXjJvtn0FrqcN+2Cql3Y+D/rV?=
 =?us-ascii?Q?XSgMqUuZB16cQj2Gn+GTFWgDeHeFrhJzZHskBm2oagH6P7pL4kMelqXRgraX?=
 =?us-ascii?Q?jiz7I6hU9kQJQQdwLRVjukmn9Y8fuJe/JX9lpTN0FRxsxSsiBJJDpYVB4pi8?=
 =?us-ascii?Q?QZFaxlLawFjOtvlE3IdgtzNXMdXzjVKLreIkRjy2iVLBwbaa7qXcFOxM3Tso?=
 =?us-ascii?Q?5F0jWBshNjFLL0MUSg6fqoatMQgcaeL4R0RkYGiUk0eIDJ/SfNZ53wSFNFdb?=
 =?us-ascii?Q?IW/W4rkV/C6nyFxCtxlI4z7qkkz7vFJLS34JtFiCCavOFeTxzGGD5mFr/l9I?=
 =?us-ascii?Q?oWp8Mnf/rDmBaZzRZ8mV2mjGKcksYC8adCQcHZ9Sp3pvQJ8kVjCA7iS75kBB?=
 =?us-ascii?Q?MCKzPK8+Mvl4U++BH6d4kIhJAZEs8L5c1Kt0oFgzmlNt3RaD0/p1U1xyMzb2?=
 =?us-ascii?Q?zVnekVYb9+ti2hwrrEUP3eVTKdQbo9CsHeHMAZYGN7yp9QC8Bt3TMBiJMQfP?=
 =?us-ascii?Q?wEH1F/iJbfhHyo3SeXd5OtFMJMPOGfSD2d2Fj1oUIihFQH2ln4mTUVPVwvFu?=
 =?us-ascii?Q?wex1LkSf1UW3OoCBNxAG9rjK5Hg6QGuzFEwYMNxKzFeyIMUxa2GBkiAYRI5J?=
 =?us-ascii?Q?EQIlFlwVN0GPHABQzA/BxI5LqHC6qEE3svAR+MxCfBwjC6nfxJA1p94fx/zW?=
 =?us-ascii?Q?B5A71oAJ1JLJRxTHG2x6N34gvVTpJ4uZi7Nb01RT8O++iO6mZHrORa8jda3H?=
 =?us-ascii?Q?ZZrwmFhyx2OL810rSB8p1rLfwQCpOTYKnrmiQi3JcXK48fWp6AHC8pbA23xN?=
 =?us-ascii?Q?JPO9qVvlSuqewua0WB7KlRXNvydmp6fPzeKHUQfEdcaAKFW5UWRhDyvsokkV?=
 =?us-ascii?Q?IlnSBm1k/1x100+7UXPI8jEMxxKufxPv3d4jOKn+yXDIXC6bhHO9lRS+ue9O?=
 =?us-ascii?Q?s+lN2er1/kL35gUi7S8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93cacfe7-6b61-4dad-d2e5-08dd8756ca24
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2025 19:48:18.4253 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6pxrj83awjHanzhlSKyYtQluP2B4wt3xS6gGNx6mATSu4z46Kdz+XFT3UBfQisFQaDAbZEP9pzo+zXG0059SWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8797
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

Please fix up the patch title as well.  E.g.,

drm/amdgpu: Add support for legacy records in eeprom format V3

Alex


> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of ganglx=
ie
> Sent: Tuesday, April 29, 2025 3:01 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Xie, Patrick <Gangliang.Xie@amd.com>
> Subject: [PATCH] Add support for leagcy records in eeprom format V3
>
> After eeprom records format upgrades to V3, records that have 'address =
=3D=3D 0'
> should be supported in NPS1
>
> Signed-off-by: ganglxie <ganglxie@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 73 ++++++++++++++++---------
>  1 file changed, 48 insertions(+), 25 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index e85143acf3a2..4f4e12452ecc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -2881,6 +2881,17 @@ static int __amdgpu_ras_convert_rec_from_rom(struc=
t
> amdgpu_device *adev,
>       save_nps =3D (bps->retired_page >> UMC_NPS_SHIFT) &
> UMC_NPS_MASK;
>       bps->retired_page &=3D ~(UMC_NPS_MASK << UMC_NPS_SHIFT);
>
> +     /* if address=3D=3D 0, the rec must be a PA rec under NPS1 */
> +     if (bps->address =3D=3D 0) {
> +             if (nps =3D=3D AMDGPU_NPS1_PARTITION_MODE) {
> +                     if (amdgpu_umc_pages_in_a_row(adev, err_data,
> +                             bps->retired_page <<
> AMDGPU_GPU_PAGE_SHIFT))
> +                             return -EINVAL;
> +                     goto out;
> +             } else {
> +                     return -EOPNOTSUPP;
> +             }
> +     }
>       if (save_nps =3D=3D nps) {
>               if (amdgpu_umc_pages_in_a_row(adev, err_data,
>                               bps->retired_page <<
> AMDGPU_GPU_PAGE_SHIFT)) @@ -2889,6 +2900,8 @@ static int
> __amdgpu_ras_convert_rec_from_rom(struct amdgpu_device *adev,
>               if (amdgpu_ras_mca2pa_by_idx(adev, bps, err_data))
>                       return -EINVAL;
>       }
> +
> +out:
>       return __amdgpu_ras_restore_bad_pages(adev, err_data->err_addr,
>                                                                       ade=
v-
> >umc.retire_unit);
>  }
> @@ -2903,7 +2916,7 @@ int amdgpu_ras_add_bad_pages(struct amdgpu_device
> *adev,
>                       &adev->psp.ras_context.ras->eeprom_control;
>       enum amdgpu_memory_partition nps =3D
> AMDGPU_NPS1_PARTITION_MODE;
>       int ret =3D 0;
> -     uint32_t i;
> +     uint32_t i =3D 0;
>
>       if (!con || !con->eh_data || !bps || pages <=3D 0)
>               return 0;
> @@ -2924,28 +2937,31 @@ int amdgpu_ras_add_bad_pages(struct
> amdgpu_device *adev,
>       mutex_lock(&con->recovery_lock);
>
>       if (from_rom) {
> -             for (i =3D 0; i < pages; i++) {
> -                     if (control->ras_num_recs - i >=3D adev->umc.retire=
_unit) {
> -                             if ((bps[i].address =3D=3D bps[i + 1].addre=
ss) &&
> -                                 (bps[i].mem_channel =3D=3D bps[i + 1].m=
em_channel)) {
> -                                     //deal with retire_unit records a t=
ime
> -                                     ret =3D
> __amdgpu_ras_convert_rec_array_from_rom(adev,
> -                                                                     &bp=
s[i],
> &err_data, nps);
> -                                     if (ret)
> -                                             goto free;
> -                                     i +=3D (adev->umc.retire_unit - 1);
> +             /* there is no pa recs in V3, so skip pa recs processing */
> +             if (control->tbl_hdr.version < RAS_TABLE_VER_V3) {
> +                     for (i =3D 0; i < pages; i++) {
> +                             if (control->ras_num_recs - i >=3D adev-
> >umc.retire_unit) {
> +                                     if ((bps[i].address =3D=3D bps[i + =
1].address) &&
> +                                             (bps[i].mem_channel =3D=3D =
bps[i +
> 1].mem_channel)) {
> +                                             /* deal with retire_unit re=
cords a time */
> +                                             ret =3D
> __amdgpu_ras_convert_rec_array_from_rom(adev,
> +                                                                        =
     &bps[i],
> &err_data, nps);
> +                                             if (ret)
> +                                                     control->ras_num_ba=
d_pages -
> =3D adev->umc.retire_unit;
> +                                             i +=3D (adev->umc.retire_un=
it - 1);
> +                                     } else {
> +                                             break;
> +                                     }
>                               } else {
>                                       break;
>                               }
> -                     } else {
> -                             break;
>                       }
>               }
>               for (; i < pages; i++) {
>                       ret =3D __amdgpu_ras_convert_rec_from_rom(adev,
>                               &bps[i], &err_data, nps);
>                       if (ret)
> -                             goto free;
> +                             control->ras_num_bad_pages -=3D adev-
> >umc.retire_unit;
>               }
>       } else {
>               ret =3D __amdgpu_ras_restore_bad_pages(adev, bps, pages); @=
@ -
> 3040,21 +3056,28 @@ static int amdgpu_ras_load_bad_pages(struct
> amdgpu_device *adev)
>               dev_err(adev->dev, "Failed to load EEPROM table records!");
>       } else {
>               if (adev->umc.ras && adev->umc.ras->convert_ras_err_addr) {
> -                     for (i =3D 0; i < control->ras_num_recs; i++) {
> -                             if ((control->ras_num_recs - i) >=3D adev-
> >umc.retire_unit) {
> -                                     if ((bps[i].address =3D=3D bps[i + =
1].address) &&
> -                                             (bps[i].mem_channel =3D=3D =
bps[i +
> 1].mem_channel)) {
> -                                             control->ras_num_pa_recs +=
=3D adev-
> >umc.retire_unit;
> -                                             i +=3D (adev->umc.retire_un=
it - 1);
> +                     /*In V3, there is no pa recs, and some cases(when
> address=3D=3D0) may be parsed
> +                     as pa recs, so add verion check to avoid it.
> +                     */
> +                     if (control->tbl_hdr.version < RAS_TABLE_VER_V3) {
> +                             for (i =3D 0; i < control->ras_num_recs; i+=
+) {
> +                                     if ((control->ras_num_recs - i) >=
=3D adev-
> >umc.retire_unit) {
> +                                             if ((bps[i].address =3D=3D =
bps[i +
> 1].address) &&
> +                                                     (bps[i].mem_channel=
 =3D=3D bps[i +
> 1].mem_channel)) {
> +                                                     control->ras_num_pa=
_recs +=3D
> adev->umc.retire_unit;
> +                                                     i +=3D (adev->umc.r=
etire_unit - 1);
> +                                             } else {
> +                                                     control->ras_num_mc=
a_recs
> +=3D
> +                                                                        =
     (control-
> >ras_num_recs - i);
> +                                                     break;
> +                                             }
>                                       } else {
> -                                             control->ras_num_mca_recs +=
=3D
> -                                                                     (co=
ntrol-
> >ras_num_recs - i);
> +                                             control->ras_num_mca_recs +=
=3D
> (control->ras_num_recs - i);
>                                               break;
>                                       }
> -                             } else {
> -                                     control->ras_num_mca_recs +=3D (con=
trol-
> >ras_num_recs - i);
> -                                     break;
>                               }
> +                     } else {
> +                             control->ras_num_mca_recs =3D control-
> >ras_num_recs;
>                       }
>               }
>
> --
> 2.34.1

