Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E968ECAAD1
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Sep 2022 02:41:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D082B10E554;
	Thu,  1 Sep 2022 02:41:56 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2086.outbound.protection.outlook.com [40.107.223.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EDE8110E56D
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Sep 2022 02:41:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O1lo4R5f5YMpv7esurNSIwRu0e4zf2O6BAyowwKnCkYgsswRQUGPTVXbYs2huLHW7OmdMh3D+i1C0Zh+jXH9/YQHdPwbuk0q4XmdYqGEJiNYxUQDSEnrVdtP9EPbAEMbe3arQs8syx5qZrK5IdkFtTeT0SGxxFO9oMy/3PBTF0ui7gTfRgNczBxZ2uWsONY/mxWQcA1Tx28ah7gELe/z3OW1tfo9W/tD/dC0gmPKOqgGndfSw0Cpb/5KcXz/G7QRbBmWtvby4DnU7oiQxHyvXUrIpo3bqJXg/gTXfc4dGziglYO6dicNy/j4Kq7W7EvG1KJiAwaO6DoVJWpnUdmbWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WzF1zXnKuaKsZ8j6MoFuEt6CT3vERhBaWtX3/XHNTJs=;
 b=PNbjwfWkNWU2nKKJ/bmAQ8IutTEEEv/9WwWpE5xnNMjxUGO4VVrfXZmjy01G90KIYMepfmoNvn+Yead9JEvNl/2tWeVEXu7Ml4a8zv/yhBEbqWA45l0Qm1EkiCc4tFypS+BX3ggLC0xJsED30iW86rsmZxgGFFh9ndLaZFaWcoFxijpHuvMnmyQyGcVEy6xB008u4MzkVEYH/vUfkpWD8DqQX86bIX4hCeACNxHT+Ly+4hDPhdaRQ2+TlPOcKqqlZ5yjnvQN+gkLZubk8aBKoxSFcloCe8JHLuojOwlKUjjpQUWJVI9vFnChE6Kk+UIh6vZR/HFesVpIDEIFEgATGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WzF1zXnKuaKsZ8j6MoFuEt6CT3vERhBaWtX3/XHNTJs=;
 b=PNpZyfJ37ujzC9Bqr9xG2aLjVK6LrC8OEy21KPqBQRtMKKqhwW8t2afMgXd0Y05eJmaf9LJN7Y16NwGKFxyK6vgTvceAgbXPKsKjMqmUOWEtiKOuiGTFze6q+/Nyq8XM5fCLh/Stgj0+ZlhIkGlYOpuNS9jTD9UP1uDA5scl03c=
Received: from DM6PR12MB4958.namprd12.prod.outlook.com (2603:10b6:5:20a::8) by
 PH7PR12MB7233.namprd12.prod.outlook.com (2603:10b6:510:204::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.16; Thu, 1 Sep
 2022 02:41:51 +0000
Received: from DM6PR12MB4958.namprd12.prod.outlook.com
 ([fe80::295a:949:a450:c06a]) by DM6PR12MB4958.namprd12.prod.outlook.com
 ([fe80::295a:949:a450:c06a%9]) with mapi id 15.20.5588.011; Thu, 1 Sep 2022
 02:41:51 +0000
From: "Chang, HaiJun" <HaiJun.Chang@amd.com>
To: "Yang, Stanley" <Stanley.Yang@amd.com>, "Zhou1, Tao" <Tao.Zhou1@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>, "Liu, Monk" <Monk.Liu@amd.com>, "Skvortsov, 
 Victor" <Victor.Skvortsov@amd.com>, "Chander, Vignesh"
 <Vignesh.Chander@amd.com>, "Wan, Gavin" <Gavin.Wan@amd.com>, "Liu, Shaoyun"
 <Shaoyun.Liu@amd.com>, "Zhang, Andy" <Andy.Zhang@amd.com>, "Jiang, Jerry
 (SW)" <Jerry.Jiang@amd.com>
Subject: RE: [PATCH 1/2] drm/amdgpu: support RAS error inject for SRIOV
Thread-Topic: [PATCH 1/2] drm/amdgpu: support RAS error inject for SRIOV
Thread-Index: AQHYvRU7c+e4+3OG+EmSRWyi1C7ZJq3J2YSAgAADI9A=
Date: Thu, 1 Sep 2022 02:41:51 +0000
Message-ID: <DM6PR12MB49587CE9A1B45005E98ECAE6817B9@DM6PR12MB4958.namprd12.prod.outlook.com>
References: <20220831083925.1440-1-tao.zhou1@amd.com>
 <BL1PR12MB5334431C61BE14E5BDD566189A7B9@BL1PR12MB5334.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB5334431C61BE14E5BDD566189A7B9@BL1PR12MB5334.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-09-01T02:23:33Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=855a2917-e406-479e-ae63-a88dd8cfb036;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: eb84cd19-2e31-4b5b-0f32-08da8bc38666
x-ms-traffictypediagnostic: PH7PR12MB7233:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6ATv3sZtDZsE/9a1a0oPYEONiIIDUNQiFJesYzvmGjZchzIaDpmMtJ6U4+jNY3hSaee9AUuDJH1OzCRdB1zteLy7P6VH7qtRIFh/8kvh1Pv2x8x+Y7J1VpyRerRmsYv5cWQ2PA2QMVHBEQqHtju6gRMPvwsU5V96g1icR5B2Re8WNk+htMRLlN7vDEp/1KTtybSOdj+GnMMFlWkcD7k2PQMYlB5AQChhJXZB3oq8gGEh/tdAlCuH+c3UhT/m4mhuxG3iG6psYy7egRVq2a//pMg8O9MXUERxeAlyheuRXUb5DF3EWUPRctk506xsofbekLIJk0nz+yLk9C7LVvB8D/NEP+AH6qc/ltCoIHjSTvsznYAValFlWpv0TsLtdo3ladZmELqZz0yXrFuTT8SUrex1Dqii3Fn0caIJOWyKji5FaA6Q6Z+EFdVeEPc7PJXlgi/tdt7jr8y0Eia+Ss55cwoX5bWysFj6MgxWV4LJvf9f9o/oZBOwEGxcz0toIc+nZdxSesCj7PChxjDbvwIAbN8oK579VA5SYkxsOOyFLIiCKct7+qQ1Gw8keKiqmSDdpDpws3CMp3C720PIoKp9hKwuu/Rgbdu2mPITdTuTbFzO6HpesRVw/i0RKQi1x5VffUIRB5CW0ayzagLW3tJvEFV1jhtTyR0QE84xdDTO6xUw7Sh9KWGdWIx46cMdkjmuUREszkD3aC1eQUlAe+MdJeyWDcL0TYtgYnvfR1mWBcckbX6OP61yByywLZL24L7BXdNIJle91ANm+RncDqTa9ySU5FHc+NrcLuoB5TDXinI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4958.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(346002)(396003)(366004)(376002)(39860400002)(186003)(122000001)(2906002)(921005)(66946007)(83380400001)(110136005)(6636002)(316002)(64756008)(66446008)(76116006)(66556008)(8676002)(66476007)(5660300002)(478600001)(53546011)(7696005)(6506007)(26005)(52536014)(8936002)(9686003)(41300700001)(33656002)(71200400001)(38100700002)(86362001)(38070700005)(55016003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?61wIJaXN6kXfB7qYqzrApm5MEtusVxbFlOpkwUYTy/rMwihqwuSvjG1LdR3K?=
 =?us-ascii?Q?U0jzfvFhzkBzDD022hd6PAZQoINUKl72aEUulLvvnJe8KcsXZjExDhh7eiE/?=
 =?us-ascii?Q?OEA8OA3cD2Bp+7KR7tS/I28ZN4Woy+n3kqQLRRKc8wonkyHrnr6xQWal/IBw?=
 =?us-ascii?Q?iF41Wyr7yjDNtHybN1jHM9Tqprx/l5YJgDHmyJmHcIQenaky13vrWLeNax8Y?=
 =?us-ascii?Q?f5LZNrEBfA0BVjO1/WuDcPYK991L1cCPab4DsxrLj599rIpfiOApshsoLKCw?=
 =?us-ascii?Q?YGVczrGu/bGoqiXqIUafyFoNRTG+B5Stm6ltS8Bt9HzHN6xOGZKp2dMNMcTh?=
 =?us-ascii?Q?0HlVKAU2S5nFS3EWsEPr4b4F9cdUXcAhHCUL/soNxCn4s6R6n0rsLAIsJUhd?=
 =?us-ascii?Q?f6h26DhHGUsu+v8Rnr/fXar8uqzG0SPwluawRxQeUtljwKuGd55arE8Szjrz?=
 =?us-ascii?Q?EAhtZuGjmRc8wgV4bcAL1T7PNNGM6TabOjh7vq87GRK5geqrPJXsvjz2fJ9k?=
 =?us-ascii?Q?voVJKONOiC/4/S6N3NFykwehBPtbz6cm8ZCn/EIYC/aMXRVoJwaIGCJytCDR?=
 =?us-ascii?Q?ueeHDCARDMTW9UJME0ebsY/IqXCd4yf95cW8A0q/AlcjsmxeQ5g2tpGJkLl6?=
 =?us-ascii?Q?nVODt052QxLDpXmSkOCcDASZrfd8Efa1M2Ann6YWU8l6A/8Ffrmf5T8yErDy?=
 =?us-ascii?Q?ADod6ETGe7ytg1v+NVvwgfwFZazMM6+aAWUg/QpgvNqSsUZGDYhs5o9JX0Gw?=
 =?us-ascii?Q?1CR2eUbzUsXvgnALrf/qY7FgzXhyMX93iI9hEnKen6l2xtV++cn3lq8JkwKR?=
 =?us-ascii?Q?352HwOKz6f/qujd8MGVgVmCVuNnk4D9/Eskp4bAbCOe4cV7oQ8+3Uy/EHbAE?=
 =?us-ascii?Q?68qWQvhSWVEmrkK0pQLuyied9i/YG9jnDFY6pwIjqop1omnKoV7D2AaplkA3?=
 =?us-ascii?Q?x6olI1f/1oiOZm/FoTpww9wby0wwWAje8xb4y2drO1KASQTNJQRpOYxlrTlb?=
 =?us-ascii?Q?y08AoT61hNac0YmGC4rcJpNDtgbUfaMDSmkUigkr6Kg+jbJRuisgCvBUwxtE?=
 =?us-ascii?Q?qJ4q4YXNMNuHvtapC27a8Z35eFf4kDim84XtSEPgwrjcOu5dkgQKQHTAYACf?=
 =?us-ascii?Q?FSF7GcbBAHnXTIwqhkTkyJOvAwa7CU4Lbpfvcy1aQ0t9HPuyqfxnA8RfLrLJ?=
 =?us-ascii?Q?U5BksHAAFgV4crCC8OIzucJIxZbw2r6/8qj/eV8wDvgVB6iYPRWG/+kdztf0?=
 =?us-ascii?Q?gTtZnj3ZvFoFIvQM/+JvQsD02a+KxaTwyIy6tcT0QpXMe5o3FQAAiPBW5fia?=
 =?us-ascii?Q?rFbto2Jc4CHoULNdC1J3FsIDWQdBXtQMUlhHpHS780H+c8iWEIcuE3aZ3bSq?=
 =?us-ascii?Q?lHlm6rqVuy21w6FT7tHRkNxhiDphbx5SEHNYTqT3ypPIabAoPESrNDcWoo/J?=
 =?us-ascii?Q?EROHXiSaIFBNiWHCCuVd0OmnFukqAnOMSgyFXxigXFPSdTwkd9IVxRyjUgJa?=
 =?us-ascii?Q?VtHU5g1hhOknlvLO5ea8FrDdy8uxmnCQtezQsBLiM6EF7g+bT5RBtDvWT/1E?=
 =?us-ascii?Q?GEsBYpCjWHX7W0CZHejgfCAMCL0sf2sNw9zVMw9u?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4958.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb84cd19-2e31-4b5b-0f32-08da8bc38666
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2022 02:41:51.5440 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SuNl5rpE85FYQ1O15S0s9iTc0ZkhyA2SZ6HifETmounPq4AzvX4aL7X6kxFrXucx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7233
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

+ Andy and Jerry,

Hi Tao & Stanley,

As security concern, we cannot define such PF-VF mailbox message for ECC or=
 RAS error injection.  As Vignesh said, we might need to test script to com=
municate between host and guest.

Thanks,
HaiJun

-----Original Message-----
From: Yang, Stanley <Stanley.Yang@amd.com>=20
Sent: Thursday, September 1, 2022 10:24 AM
To: Zhou1, Tao <Tao.Zhou1@amd.com>; amd-gfx@lists.freedesktop.org; Zhang, H=
awking <Hawking.Zhang@amd.com>; Liu, Monk <Monk.Liu@amd.com>; Skvortsov, Vi=
ctor <Victor.Skvortsov@amd.com>; Chang, HaiJun <HaiJun.Chang@amd.com>; Chan=
der, Vignesh <Vignesh.Chander@amd.com>; Wan, Gavin <Gavin.Wan@amd.com>; Liu=
, Shaoyun <Shaoyun.Liu@amd.com>
Subject: RE: [PATCH 1/2] drm/amdgpu: support RAS error inject for SRIOV

[AMD Official Use Only - General]

The series is fine for me, these patches also need to be reviewed by the vi=
rtualization group.

Regards,
Stanley
> -----Original Message-----
> From: Zhou1, Tao <Tao.Zhou1@amd.com>
> Sent: Wednesday, August 31, 2022 4:39 PM
> To: amd-gfx@lists.freedesktop.org; Zhang, Hawking=20
> <Hawking.Zhang@amd.com>; Yang, Stanley <Stanley.Yang@amd.com>; Liu,=20
> Monk <Monk.Liu@amd.com>; Skvortsov, Victor <Victor.Skvortsov@amd.com>;=20
> Chang, HaiJun <HaiJun.Chang@amd.com>; Chander, Vignesh=20
> <Vignesh.Chander@amd.com>; Wan, Gavin <Gavin.Wan@amd.com>; Liu,=20
> Shaoyun <Shaoyun.Liu@amd.com>
> Cc: Zhou1, Tao <Tao.Zhou1@amd.com>
> Subject: [PATCH 1/2] drm/amdgpu: support RAS error inject for SRIOV
>=20
> In SRIOV, RAS error injection request will be sent to PF via mailbox,=20
> the injection input information should also be transferred to PF.
>=20
> Generally, the error injection is operated on PF side directly, but=20
> for RAS poison test, since workload is launched on VF side, VF has to=20
> tell PF about the injection information.
>=20
> Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c  | 26 ++++++++++++++++------
> --  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h |  2 ++
>  drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c    | 24
> ++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h    |  9 ++++++++
>  4 files changed, 53 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index ab9ba5a9c33d..498642eb5fb7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -1103,15 +1103,25 @@ int amdgpu_ras_error_inject(struct=20
> amdgpu_device *adev,
>  							  block_info.address);
>  	}
>=20
> -	if (info->head.block =3D=3D AMDGPU_RAS_BLOCK__GFX) {
> -		if (block_obj->hw_ops->ras_error_inject)
> -			ret =3D block_obj->hw_ops->ras_error_inject(adev,
> info);
> +	if (!amdgpu_sriov_vf(adev)) {
> +		if (info->head.block =3D=3D AMDGPU_RAS_BLOCK__GFX) {
> +			if (block_obj->hw_ops->ras_error_inject)
> +				ret =3D block_obj->hw_ops-
> >ras_error_inject(adev, info);
> +		} else {
> +			/* If defined special ras_error_inject(e.g: xgmi),
> implement special ras_error_inject */
> +			if (block_obj->hw_ops->ras_error_inject)
> +				ret =3D block_obj->hw_ops-
> >ras_error_inject(adev, &block_info);
> +			else  /*If not defined .ras_error_inject, use default
> ras_error_inject*/
> +				ret =3D psp_ras_trigger_error(&adev->psp,
> &block_info);
> +		}
>  	} else {
> -		/* If defined special ras_error_inject(e.g: xgmi), implement
> special ras_error_inject */
> -		if (block_obj->hw_ops->ras_error_inject)
> -			ret =3D block_obj->hw_ops->ras_error_inject(adev,
> &block_info);
> -		else  /*If not defined .ras_error_inject, use default
> ras_error_inject*/
> -			ret =3D psp_ras_trigger_error(&adev->psp,
> &block_info);
> +		if (adev->virt.ops && adev->virt.ops->ras_trigger_error) {
> +			adev->virt.ops->ras_trigger_error(adev, &block_info);
> +			ret =3D 0;
> +		} else {
> +			dev_warn(adev->dev,
> +				"No ras_trigger_error interface in SRIOV!\n");
> +		}
>  	}
>=20
>  	if (ret)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> index 239f232f9c02..4534e6f70a4b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
> @@ -84,6 +84,8 @@ struct amdgpu_virt_ops {
>  	int (*reset_gpu)(struct amdgpu_device *adev);
>  	int (*wait_reset)(struct amdgpu_device *adev);
>  	void (*trans_msg)(struct amdgpu_device *adev, u32 req, u32 data1,
> u32 data2, u32 data3);
> +	void (*ras_trigger_error)(struct amdgpu_device *adev,
> +				struct ta_ras_trigger_error_input *info);
>  };
>=20
>  /*
> diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
> b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
> index a2f04b249132..3b4c5162a237 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
> @@ -33,6 +33,7 @@
>  #include "mxgpu_ai.h"
>=20
>  #include "amdgpu_reset.h"
> +#include "ta_ras_if.h"
>=20
>  static void xgpu_ai_mailbox_send_ack(struct amdgpu_device *adev)  {=20
> @@ -
> 405,6 +406,28 @@ static int xgpu_ai_request_init_data(struct=20
> amdgpu_device *adev)
>  	return xgpu_ai_send_access_requests(adev,
> IDH_REQ_GPU_INIT_DATA);  }
>=20
> +void amdgpu_virt_ras_trigger_error(struct amdgpu_device *adev,
> +               struct ta_ras_trigger_error_input *info) {
> +       uint32_t addr_lo, addr_hi, data1 =3D 0;
> +
> +       addr_lo =3D lower_32_bits(info->address);
> +       addr_hi =3D upper_32_bits(info->address);
> +
> +       /* block id : bits[0:4], inject_error_type : bits[5:8]
> +        * sub_block_index : bits[9:17], value : bits[18:19]
> +        */
> +       data1 =3D info->block_id & RAS_BLOCK_ID_MASK;
> +       data1 |=3D (info->inject_error_type &=20
> + RAS_INJECT_ERROR_TYPE_MASK)
> <<
> +			RAS_INJECT_ERROR_TYPE_SHIFT;
> +       data1 |=3D (info->sub_block_index & RAS_SUB_BLOCK_INDEX_MASK) <<
> +			RAS_SUB_BLOCK_INDEX_SHIFT;
> +       data1 |=3D (info->value & RAS_VALUE_MASK) << RAS_VALUE_SHIFT;
> +
> +       xgpu_ai_mailbox_trans_msg(adev, IDH_RAS_ERROR_INJECT, data1,
> +				addr_lo, addr_hi);
> +}
> +
>  const struct amdgpu_virt_ops xgpu_ai_virt_ops =3D {
>  	.req_full_gpu	=3D xgpu_ai_request_full_gpu_access,
>  	.rel_full_gpu	=3D xgpu_ai_release_full_gpu_access,
> @@ -412,4 +435,5 @@ const struct amdgpu_virt_ops xgpu_ai_virt_ops =3D {
>  	.wait_reset =3D NULL,
>  	.trans_msg =3D xgpu_ai_mailbox_trans_msg,
>  	.req_init_data  =3D xgpu_ai_request_init_data,
> +	.ras_trigger_error =3D amdgpu_virt_ras_trigger_error,
>  };
> diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h
> b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h
> index fa7e13e0459e..0841d6632328 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h
> +++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.h
> @@ -29,6 +29,14 @@
>  #define AI_MAILBOX_POLL_FLR_TIMEDOUT	10000
>  #define AI_MAILBOX_POLL_MSG_REP_MAX	11
>=20
> +#define RAS_BLOCK_ID_MASK 0x1f
> +#define RAS_INJECT_ERROR_TYPE_MASK 0xf #define=20
> +RAS_INJECT_ERROR_TYPE_SHIFT 5 #define RAS_SUB_BLOCK_INDEX_MASK 0x1ff=20
> +#define RAS_SUB_BLOCK_INDEX_SHIFT 9 #define RAS_VALUE_MASK 0x3=20
> +#define RAS_VALUE_SHIFT 18
> +
>  enum idh_request {
>  	IDH_REQ_GPU_INIT_ACCESS =3D 1,
>  	IDH_REL_GPU_INIT_ACCESS,
> @@ -39,6 +47,7 @@ enum idh_request {
>=20
>  	IDH_LOG_VF_ERROR       =3D 200,
>  	IDH_READY_TO_RESET 	=3D 201,
> +	IDH_RAS_ERROR_INJECT =3D 202,
>  };
>=20
>  enum idh_event {
> --
> 2.35.1
