Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9E91C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Jan 2022 03:57:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F84B10EB8E;
	Fri, 14 Jan 2022 03:57:50 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2058.outbound.protection.outlook.com [40.107.220.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8F6A10EB90
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Jan 2022 03:57:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GTES/HOHQYj0o4WdHbkJ/qsNic6iI0i3e9TTbGoobrRrZdwyl9Ln/+LPneSASHyu+ftjf3G21+S2vcrzkvMn4ZztfYNAYmBMmpV1LblG+/8UWEIoAk5UonlyGglBVoSP8OaaveTJgYU3S/zdJjfzEYLHCnEtPAErYQm5fM5fNcopfK/9suS11LOrzVLom9ekG03b6yKl7pycFhE0qIukdjTBXRqk+FQgM91eT3Jfy4Vm5wWWacWHbpOFxseFBO6Zt48P5KoOs4IVHZmxn30bl5AncS8fpkFtcZlB3f4x+KGU06Dgy287MQ6ICzVCawe8Modm2C9N+IgzzQdMDhRVIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Vh/RAEEexu+mItiWCjRdPvBRnB1h+Ujpm4tsYSI6pY=;
 b=BsN9nHbjo7JemWWpOeHW4iH9+XBuxN+7YgqF4cNWVGLGJFSwQOV/dmDwaH03j1b8BJ6hENdKZs1yelKVtYLhel0Lco8tXGd6OFsCuyjsenvkvPBcX8JZ0w7wZJzsB2407gpMb5vOu1m1rWZNHQREIIC6ubdv143RqrXaBX1//AN7B+kBCg7KV4LK8dhlhTFa+7acDsFuQIAr5/03BdLJ0/EhEhVVZc+iCyDOSFV5hHNmxecr9YNtklF4aNwHOX/y9ZvkUk8JAryR92OQJ3KaCQqiKp3Xkv2ulUVnR0QntCFPtPNHFAyR5wZ+K20zbbn3gfYkeSUhbohVHK0c7+BYGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Vh/RAEEexu+mItiWCjRdPvBRnB1h+Ujpm4tsYSI6pY=;
 b=gvQKzQE1olPqjbb8+492bqXWvrrc/FPdlVBGNjHyyrPa4oxCM699H92Vz3oJ0fLvm0E5rzDwXbbT4POyViPR0RIEG6Tmrswd8T89cndkbAlWVMlBFZ63FcfauFPOLTesDePBk2KDDtAWRwcqgDVZKe1HULUUwtEVaE8F+Z1OWoA=
Received: from CH2PR12MB4215.namprd12.prod.outlook.com (2603:10b6:610:ab::24)
 by BN9PR12MB5337.namprd12.prod.outlook.com (2603:10b6:408:102::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Fri, 14 Jan
 2022 03:57:38 +0000
Received: from CH2PR12MB4215.namprd12.prod.outlook.com
 ([fe80::68f6:f42b:2c29:7f94]) by CH2PR12MB4215.namprd12.prod.outlook.com
 ([fe80::68f6:f42b:2c29:7f94%6]) with mapi id 15.20.4888.011; Fri, 14 Jan 2022
 03:57:38 +0000
From: "Chai, Thomas" <YiPeng.Chai@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/5] drm/amdgpu: Fix the code style warnings in amdgpu_ras
Thread-Topic: [PATCH 1/5] drm/amdgpu: Fix the code style warnings in amdgpu_ras
Thread-Index: AQHYCPfvmk4I37PVmUGFW3xFOl65IKxh4CWAgAACwdA=
Date: Fri, 14 Jan 2022 03:57:38 +0000
Message-ID: <CH2PR12MB4215427A3FAFD6958F59221AFC549@CH2PR12MB4215.namprd12.prod.outlook.com>
References: <20220114033559.4009592-1-YiPeng.Chai@amd.com>
 <DM5PR12MB1770600414D1EEE9FCE1A79BB0549@DM5PR12MB1770.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB1770600414D1EEE9FCE1A79BB0549@DM5PR12MB1770.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-01-14T03:44:29Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=7e3ef08a-9fb4-4ed2-9f21-d9e7bac6cfb4;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: caf1fb5d-c3c2-45b6-1b1a-08d9d712017b
x-ms-traffictypediagnostic: BN9PR12MB5337:EE_
x-microsoft-antispam-prvs: <BN9PR12MB5337647B5F67BC33ED68212AFC549@BN9PR12MB5337.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:175;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JJapt0zwXUar/A4hQMou2rp37TT9HJK4wgeRccpQHU4GPfkQP0pXcO9Nn/2rp+7DmA2PVjpc1QJpcgLYr81tYoc6OdDlkUADTA4B5NMegObgnsdbgxdGFtyZhSD+mIbVqMq1hPXJSjOzvuGIfqHWxDEXdnYrgbxULMylG0IG0NTJOT01rDnL22zOj7IDNBOMLaWb75Q3M9A2Cb2SqFgCz2T1Cxj39vsfPtIVnwzqYeSRhyGwKS67wor0hdnWXpYJGwm8i9KzrjYrOQavoXYwNpGC2JEDTekBfFPPN2G0+shsR3RPnJAcCawbNVLFuwUtyIpg9My6KxTd1bHffm7jIhVqSy/o+HhGlX7bwLtanzN1JercmUzp7EzXGwMKDbArjS/CQTUdxJwbIBRFdgJtFIBUNJAenkYWMLm1DwUJNHTk9cclL3i3tHKyN2C9Znt2zjVzO/WLyHa0fQ/4XAe+sQ28h8Xwqq+SJJqdkXpeCYYcLcotnHvrNKi0Kf9HSff/le7unI8xVh9Fl2ol6BOwULQM893Oli+itO2JbyedoBwtaAvkiXiXse3cOFxy/P7cGNy3sj98IEhmckyso/DsYQtovzlWUd+r87ExfGipl/GtiNaQUFH51eoycbbVfVjTx5tvH7N2fzMrFRkBO1oMzQmUmPKWsOb8IWk3MhQQW3v2O50P7BOBvKf+KS0l6p9nzC/+eyqeMijllPVaPzALog==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB4215.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(9686003)(33656002)(5660300002)(83380400001)(38070700005)(86362001)(122000001)(26005)(4326008)(55016003)(2906002)(66476007)(38100700002)(66946007)(76116006)(52536014)(316002)(71200400001)(54906003)(66446008)(64756008)(66556008)(110136005)(508600001)(6506007)(8936002)(186003)(8676002)(7696005)(53546011);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?O6sYMqRtWcIysXPv4QXIDnYqupTCu6BcbgIrCrlZYfpHN/SW3cJtaLMWlMlh?=
 =?us-ascii?Q?mKWC4OH059br/vs84PAHnJQkjjRprNEJGTmqsaa2sRpgUr9EHnFQJTvQUexU?=
 =?us-ascii?Q?+H1rIvWw6h+4KuSJrshNQ9PRFkBy9x1YN4nKxNkYCJmS9mLzUUPuwbBkIrcx?=
 =?us-ascii?Q?RWXPhdKx2wOd8BHIacvfDeMMuyYCAwOc7WoaTLcg6lI2tP2h5sZsFzY2uSun?=
 =?us-ascii?Q?O8+Icm9YsfQbvN0jvhgb3uTvcW8FLDciRAmB/xDjlMmY1AFMRZQw0uC1cBZt?=
 =?us-ascii?Q?0eMQYckwfhGZz5Ol2qWB1r6Xvp9pwMykJ3Fyzq3gP1ulDQvVg3FwEZidu/Vu?=
 =?us-ascii?Q?zxH+lSK1ZOiovjagQR1MK6o3MpL+SBsLFTbY51E6D9bISFc4em13c7MKLiGJ?=
 =?us-ascii?Q?W0D9RMMfGru/Bb1t3BxzCh5pwVYKu7AiHLFdLP0c71SMiTd+cGAYDCXX4FrO?=
 =?us-ascii?Q?9h+c2IcjmK6dye17ciClNgsL/Rf29SWsv1dVOenoCopuuy2Z/85IqhyIWcEJ?=
 =?us-ascii?Q?1gCmPTIapjxfkX5FVrJClBafRE6EvqTO2QkOmlEuYXUyEZRFd/Ylau3FB8NM?=
 =?us-ascii?Q?KpGZ+nK67Jetkq/Gs0yNkMvSITCp8PsHFXyyzvEJkfG/MaQWCozZkXBT7hJg?=
 =?us-ascii?Q?cu7uSVYGEOVPlx4JZJPvsfYg0HwAzIuzTprM6acCc/NQw3HfyVZevztdh3BA?=
 =?us-ascii?Q?5Oc4YPEG/6Vu05grGMedA0/xOeBiQ9ylAkSuihjshjib/KG7wqk6LdgCUEGE?=
 =?us-ascii?Q?yuc2x2Oq2QtS4R+qID1MyR1xq4tJ5ikIJ8KD/b0d+s15+pj023Q2KYFpFm0Q?=
 =?us-ascii?Q?0SXHSpBmNqLSpNRpMUbZCgexX0bsJ/H4dV8bB3AOviEM9eTrpc6YZQ7NgMlD?=
 =?us-ascii?Q?fiaEFVhK2HvqfV3Lxzhtq/Njv5ClpTAK7u/ErZ2eL48blnpnSbmuxtaUmbZA?=
 =?us-ascii?Q?U510RqbReXuf7K64hQleyz+8OWwSk7rIIaE1w1qtTO8pNZ/VykUZZ3VfIwlN?=
 =?us-ascii?Q?PYzYawPGkb23/Pxn8DCf4Ci0Es/aj/bvCFzNwInVIqiz/Pr4jIjXpg0Nitkl?=
 =?us-ascii?Q?JSkso+NBfAF+soRdIPPWOtpYDonxgfTu/ON4La7+xSUZrSijiBsXR0+w+7nZ?=
 =?us-ascii?Q?F7O71HFOX/b3GOcjpgiQpMT5akqBWYmwlSjxbYOk4xpqBotLsLf7LCxfhJ5r?=
 =?us-ascii?Q?u4okCvt3FVdUM3lL7BiMMHihmRlYiAT1kWml+EaYusdIubelGDsfPGlGpMfB?=
 =?us-ascii?Q?3fSYWjT18uPGBNOT8cvgvcZFspZ//dePR4j6tsKTZd2UlxrreKabDjHZvbLC?=
 =?us-ascii?Q?CprBYLE4GC7qHmfRhI+XXxaXbmACDMIfkOKv0ypYppZA95a4bW9bu+16xDZY?=
 =?us-ascii?Q?lufbUCHm47LoSQtVxoLYug/OJNlCspmqsSXCU8W/5Kek/UyUnbU3vVHL/wU1?=
 =?us-ascii?Q?i86ScCpUytQrxvmQZ2ra1l55Xctyn1uxXeEj9n20ORUDpk9SZAyn22zeLdPe?=
 =?us-ascii?Q?9dgRXIkqclnwEnwBGWvEAvGyJbcYUHpOOpkeChU5IkIahGSor/Nv7y6VtIh7?=
 =?us-ascii?Q?Q+hzv9DfonW2G7MOW/tTz5q44bkTB7+Z/QdIzKQjLXLv2jc2NYB0KiH35+0a?=
 =?us-ascii?Q?MB5CXuaTEAIE4OvK2Qn1Ulo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4215.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: caf1fb5d-c3c2-45b6-1b1a-08d9d712017b
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2022 03:57:38.2771 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QlYNurMDStDeWbxFBmI3+ficD4BQ+mRUKdkrszDNRv0Yt17PdHzxsbVy4hZRVCXsZNdGICYpTdAz+ZWJBh3UiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5337
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
Cc: "Clements, John" <John.Clements@amd.com>, "Zhang,
 Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

OK, I will update the patches to add the fixed warning types.

-----Original Message-----
From: Zhou1, Tao <Tao.Zhou1@amd.com>=20
Sent: Friday, January 14, 2022 11:45 AM
To: Chai, Thomas <YiPeng.Chai@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Zhang, Hawking <Hawking.Zhang@amd.com>; Clements, John <John.Clements@a=
md.com>
Subject: RE: [PATCH 1/5] drm/amdgpu: Fix the code style warnings in amdgpu_=
ras

[AMD Official Use Only]



> -----Original Message-----
> From: Chai, Thomas <YiPeng.Chai@amd.com>
> Sent: Friday, January 14, 2022 11:36 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Chai, Thomas <YiPeng.Chai@amd.com>; Zhang, Hawking=20
> <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Clements,=20
> John <John.Clements@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>
> Subject: [PATCH 1/5] drm/amdgpu: Fix the code style warnings in=20
> amdgpu_ras
>=20
> Fix the code style warnings in amdgpu_ras.

[Tao] Could you add more description to explain the warnings you want to fi=
x?

>=20
> Signed-off-by: yipechai <YiPeng.Chai@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 41=20
> +++++++++++++++---------- drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h | 10=20
> +++---
>  2 files changed, 30 insertions(+), 21 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 0bb6b5354802..23502b2b0770 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -872,7 +872,7 @@ static int amdgpu_ras_enable_all_features(struct
> amdgpu_device *adev,  static int amdgpu_ras_block_match_default(struct
> amdgpu_ras_block_object *block_obj,
>  		enum amdgpu_ras_block block)
>  {
> -	if(!block_obj)
> +	if (!block_obj)
>  		return -EINVAL;
>=20
>  	if (block_obj->block =3D=3D block)
> @@ -881,7 +881,7 @@ static int amdgpu_ras_block_match_default(struct
> amdgpu_ras_block_object *block_
>  	return -EINVAL;
>  }
>=20
> -static struct amdgpu_ras_block_object*=20
> amdgpu_ras_get_ras_block(struct amdgpu_device *adev,
> +static struct amdgpu_ras_block_object=20
> +*amdgpu_ras_get_ras_block(struct amdgpu_device *adev,
>  					enum amdgpu_ras_block block,
> uint32_t sub_block_index)  {
>  	struct amdgpu_ras_block_object *obj, *tmp; @@ -941,7 +941,7 @@=20
> static void amdgpu_ras_get_ecc_info(struct amdgpu_device *adev, struct=20
> ras_err_d  int amdgpu_ras_query_error_status(struct amdgpu_device *adev,
>  				  struct ras_query_if *info)
>  {
> -	struct amdgpu_ras_block_object* block_obj =3D NULL;
> +	struct amdgpu_ras_block_object *block_obj =3D NULL;
>  	struct ras_manager *obj =3D amdgpu_ras_find_obj(adev, &info->head);
>  	struct ras_err_data err_data =3D {0, 0, 0, NULL};
>=20
> @@ -953,7 +953,7 @@ int amdgpu_ras_query_error_status(struct
> amdgpu_device *adev,
>  	} else {
>  		block_obj =3D amdgpu_ras_get_ras_block(adev, info->head.block, 0);
>  		if (!block_obj || !block_obj->hw_ops)   {
> -			dev_info(adev->dev, "%s doesn't config ras function \n",
> +			dev_info(adev->dev, "%s doesn't config ras function.\n",
>  					get_ras_block_str(&info->head));
>  			return -EINVAL;
>  		}
> @@ -1023,13 +1023,14 @@ int amdgpu_ras_query_error_status(struct
> amdgpu_device *adev,  int amdgpu_ras_reset_error_status(struct
> amdgpu_device *adev,
>  		enum amdgpu_ras_block block)
>  {
> -	struct amdgpu_ras_block_object* block_obj =3D
> amdgpu_ras_get_ras_block(adev, block, 0);
> +	struct amdgpu_ras_block_object *block_obj =3D=20
> +amdgpu_ras_get_ras_block(adev, block, 0);
>=20
>  	if (!amdgpu_ras_is_supported(adev, block))
>  		return -EINVAL;
>=20
>  	if (!block_obj || !block_obj->hw_ops)   {
> -		dev_info(adev->dev, "%s doesn't config ras function \n",
> ras_block_str(block));
> +		dev_info(adev->dev, "%s doesn't config ras function.\n",
> +				ras_block_str(block));
>  		return -EINVAL;
>  	}
>=20
> @@ -1066,7 +1067,8 @@ int amdgpu_ras_error_inject(struct amdgpu_device=20
> *adev,
>  		return -EINVAL;
>=20
>  	if (!block_obj || !block_obj->hw_ops)	{
> -		dev_info(adev->dev, "%s doesn't config ras function \n",
> get_ras_block_str(&info->head));
> +		dev_info(adev->dev, "%s doesn't config ras function.\n",
> +					get_ras_block_str(&info->head));
>  		return -EINVAL;
>  	}
>=20
> @@ -1702,19 +1704,25 @@ static void=20
> amdgpu_ras_log_on_err_counter(struct
> amdgpu_device *adev)  static void amdgpu_ras_error_status_query(struct
> amdgpu_device *adev,
>  					  struct ras_query_if *info)
>  {
> -	struct amdgpu_ras_block_object* block_obj =3D
> amdgpu_ras_get_ras_block(adev, info->head.block, info-
> >head.sub_block_index);
> +	struct amdgpu_ras_block_object *block_obj =3D
> amdgpu_ras_get_ras_block(adev,
> +									info-
> >head.block,
> +									info-
> >head.sub_block_index);
>  	/*
>  	 * Only two block need to query read/write
>  	 * RspStatus at current state
>  	 */
>  	if ((info->head.block !=3D AMDGPU_RAS_BLOCK__GFX) &&
>  		(info->head.block !=3D AMDGPU_RAS_BLOCK__MMHUB))
> -		return ;
> +		return;
> +
> +	block_obj =3D amdgpu_ras_get_ras_block(adev,
> +					info->head.block,
> +					info->head.sub_block_index);
>=20
> -	block_obj =3D amdgpu_ras_get_ras_block(adev, info->head.block, info-
> >head.sub_block_index);
>  	if (!block_obj || !block_obj->hw_ops) {
> -		dev_info(adev->dev, "%s doesn't config ras function \n",
> get_ras_block_str(&info->head));
> -		return ;
> +		dev_info(adev->dev, "%s doesn't config ras function.\n",
> +			get_ras_block_str(&info->head));
> +		return;
>  	}
>=20
>  	if (block_obj->hw_ops->query_ras_error_status)
> @@ -2715,7 +2723,7 @@ static void
> amdgpu_register_bad_pages_mca_notifier(struct amdgpu_device *adev)  }=20
> #endif
>=20
> -struct amdgpu_ras* amdgpu_ras_get_context(struct amdgpu_device *adev)
> +struct amdgpu_ras *amdgpu_ras_get_context(struct amdgpu_device *adev)
>  {
>  	if (!adev)
>  		return NULL;
> @@ -2723,7 +2731,7 @@ struct amdgpu_ras* amdgpu_ras_get_context(struct=20
> amdgpu_device *adev)
>  	return adev->psp.ras_context.ras;
>  }
>=20
> -int amdgpu_ras_set_context(struct amdgpu_device *adev, struct=20
> amdgpu_ras*
> ras_con)
> +int amdgpu_ras_set_context(struct amdgpu_device *adev, struct=20
> +amdgpu_ras *ras_con)
>  {
>  	if (!adev)
>  		return -EINVAL;
> @@ -2755,7 +2763,7 @@ int amdgpu_ras_reset_gpu(struct amdgpu_device
> *adev)
>=20
>  /* Register each ip ras block into amdgpu ras */  int=20
> amdgpu_ras_register_ras_block(struct amdgpu_device *adev,
> -		struct amdgpu_ras_block_object* ras_block_obj)
> +		struct amdgpu_ras_block_object *ras_block_obj)
>  {
>  	struct amdgpu_ras_block_object *obj, *tmp;
>  	if (!adev || !ras_block_obj)
> @@ -2766,9 +2774,8 @@ int amdgpu_ras_register_ras_block(struct
> amdgpu_device *adev,
>=20
>  	/* If the ras object is in ras_list, don't add it again */
>  	list_for_each_entry_safe(obj, tmp, &adev->ras_list, node) {
> -		if (obj =3D=3D ras_block_obj) {
> +		if (obj =3D=3D ras_block_obj)
>  			return 0;
> -		}
>  	}
>=20
>  	INIT_LIST_HEAD(&ras_block_obj->node);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> index 7a4d82378205..a51a281bd91a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> @@ -496,7 +496,8 @@ struct amdgpu_ras_block_object {
>  	/* ras block link */
>  	struct list_head node;
>=20
> -	int (*ras_block_match)(struct amdgpu_ras_block_object *block_obj,
> enum amdgpu_ras_block block, uint32_t sub_block_index);
> +	int (*ras_block_match)(struct amdgpu_ras_block_object *block_obj,
> +				enum amdgpu_ras_block block, uint32_t
> sub_block_index);
>  	int (*ras_late_init)(struct amdgpu_device *adev, void *ras_info);
>  	void (*ras_fini)(struct amdgpu_device *adev);
>  	const struct amdgpu_ras_block_hw_ops *hw_ops; @@ -504,7 +505,7 @@=20
> struct amdgpu_ras_block_object {
>=20
>  struct amdgpu_ras_block_hw_ops {
>  	int  (*ras_error_inject)(struct amdgpu_device *adev, void *inject_if);
> -	void (*query_ras_error_count)(struct amdgpu_device *adev,void
> *ras_error_status);
> +	void (*query_ras_error_count)(struct amdgpu_device *adev, void=20
> +*ras_error_status);
>  	void (*query_ras_error_status)(struct amdgpu_device *adev);
>  	void (*query_ras_error_address)(struct amdgpu_device *adev, void=20
> *ras_error_status);
>  	void (*reset_ras_error_count)(struct amdgpu_device *adev); @@ -
> 678,7 +679,8 @@ int amdgpu_ras_reset_gpu(struct amdgpu_device *adev);
>=20
>  struct amdgpu_ras* amdgpu_ras_get_context(struct amdgpu_device=20
> *adev);
>=20
> -int amdgpu_ras_set_context(struct amdgpu_device *adev, struct=20
> amdgpu_ras* ras_con);
> +int amdgpu_ras_set_context(struct amdgpu_device *adev, struct=20
> +amdgpu_ras *ras_con);
>=20
> -int amdgpu_ras_register_ras_block(struct amdgpu_device *adev, struct
> amdgpu_ras_block_object* ras_block_obj);
> +int amdgpu_ras_register_ras_block(struct amdgpu_device *adev,
> +				struct amdgpu_ras_block_object
> *ras_block_obj);
>  #endif
> --
> 2.25.1
