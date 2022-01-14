Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D44AFC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Jan 2022 03:44:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04AA610EB71;
	Fri, 14 Jan 2022 03:44:38 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2077.outbound.protection.outlook.com [40.107.244.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94B9C10EB6B
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Jan 2022 03:44:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QbCJaAOCF/VkSNmzcuNrxWDPEWd3k4lK5nUfjQ8WScxv7HoMRqHHqflnzDEVU/b1nnK5pLn264PJNABcaCEVS/I/ok1jj/ao6T7/MSHZkBxzQw9DA7Ag/mQBLO7Pqn2fSa/QwIZwOL1FjiFkNGSS2M/DKKDsQQyc10zyZzWkEPEXw7W8PInQ+FCJvDENQwcLDmQt2Lg2wNUj+1UxJkWHFbyHNKPe2nbg0H+Nh0UfgQgr679ZZOIXWTFmgz3qAkXPTwP7yH3PtGWY1gWZBNfaWEU5C1oJQH+T/1gb0jzw1x1af60Knm0rhfwH8B/sr67rzGa83o6Wsmx29DzP+ZS2zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dVWUdOyKW1Obb/yG3ge9ncPhGPc2zmIZhronGLAAm5U=;
 b=n+sBquDOGaNqpanVqNdSpcpVtLw4plpcDnBBI4d9X9tHLK/jFTrKRXtxeWC1pq3TMA4TqBJTdNto5Tpwonhw81h5Jtw/X5sjB+BF94bXnqupr1Ey+kl9JdFUIx44eW/RGuLh4zX3urcTCp9wib7TsPkqS0RaszyCYM5/8v+8aZs5eEUWVrn16J1fxEPJWKU7HGxY7loBknu82Zgf4ORxWMCbEUBocr4bSLY5YaaGKuy6v1/Q3rQp5oZg62MuInUXtA14yeR+IGcmD+XKJGowKU8GjlTmENqyDVCVPejfwQ5ChFFRCQTLvPbKwFkOayTQU0/7FDq0upFN6jppDnvUxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dVWUdOyKW1Obb/yG3ge9ncPhGPc2zmIZhronGLAAm5U=;
 b=Xtt8UovU2DtO8jQW2a5ebTfWa5Nv+kNY7dHVBioZiqRE6EiFa9Udv9F08sH/xdInswPH95FIHFrXBWwihzeY3SdtxTcprqOwHppcDuZueofLtdLgx/fCqPeOv5LFACqGkLEwU3W0OGgbqBEULWd1pcf784Dowy1yaaUkzOHGBK8=
Received: from DM5PR12MB1770.namprd12.prod.outlook.com (2603:10b6:3:108::22)
 by DM6PR12MB4910.namprd12.prod.outlook.com (2603:10b6:5:1bb::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11; Fri, 14 Jan
 2022 03:44:34 +0000
Received: from DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::a1bb:3874:a99d:5934]) by DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::a1bb:3874:a99d:5934%11]) with mapi id 15.20.4888.011; Fri, 14 Jan
 2022 03:44:33 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Chai, Thomas" <YiPeng.Chai@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 1/5] drm/amdgpu: Fix the code style warnings in amdgpu_ras
Thread-Topic: [PATCH 1/5] drm/amdgpu: Fix the code style warnings in amdgpu_ras
Thread-Index: AQHYCPfv1X2M7mY3jEiLaMCbstUYDaxh38hg
Date: Fri, 14 Jan 2022 03:44:33 +0000
Message-ID: <DM5PR12MB1770600414D1EEE9FCE1A79BB0549@DM5PR12MB1770.namprd12.prod.outlook.com>
References: <20220114033559.4009592-1-YiPeng.Chai@amd.com>
In-Reply-To: <20220114033559.4009592-1-YiPeng.Chai@amd.com>
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
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2022-01-14T03:44:29Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: d84d7022-0b61-42ef-ad5f-81a6c4dab500
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 45c275fd-d37a-491b-9c2e-08d9d7102ddf
x-ms-traffictypediagnostic: DM6PR12MB4910:EE_
x-microsoft-antispam-prvs: <DM6PR12MB491030D8C4056AC246572103B0549@DM6PR12MB4910.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:171;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RPIoJCrxJeKe8qsBt9pr+FpaiKKWKq/JBwapRGvZkd5hC/b++RnaOowfkNjC9VSqqAmxIz15PKooZuUCpp6tO2fKKJORu1C+kAm6jSY2ZKwBLx5a7RLZL8yXtSaQ02O44INi8tDrTKB6wtuvG1ZvzxFRdKNmPWT0v/2KDQRCMmyYdVGIlWtFSYpPFGhwtR53ca5cLp+6A+t9Ova7HmjObIZRaHIMNmjD1Y6Le0NVwANoaHF/Kqt11XfOcuCqWAV+ZVivu4Kvb1xnx6BjKiJ+nQqKvkcykDXNqlWbZtVa8NqDwPyJP4Q7NSri6s8E4pvdPDtn+2l/QncXoI4U8m2oFqqu8tEuwGjzZ38LUfZ4wxh5mL8H1kWL8rQf7baP3mmGFpmzpZg+oSQSxOl2MpXaiiF+MNAIIZPsjaJBMmxT2nH137R+ZJNcKQ5NLq2+LMW51L0z0bn3AEksqtgM4EzH317x0OfaEsvXytWWvSD+YWofO/Wr61jiDH2ZjNr2LMhjR8feOin+mHlfT4Mmr3UxxkXuZTKa3utkxsiyrmFfEXRT4TXQsFMsFIm2/J7HJW1vrWQz05WVDNnrb+lJa7KF7SVJlvktw8Nv7sAz5NV9pfmqmMn0RtsZHcNRzMButqSZFy77LJIeNemX/BYejVR5aOrrFCcpqQCiaKlqBjvLze8oqmbLjsN+RR3UDQNcEvWDjtU9BUTYYODN7cpvswOi4Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1770.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(316002)(5660300002)(54906003)(71200400001)(110136005)(186003)(38070700005)(38100700002)(76116006)(52536014)(2906002)(122000001)(6506007)(86362001)(33656002)(64756008)(7696005)(66446008)(55016003)(66556008)(508600001)(26005)(66946007)(66476007)(53546011)(8676002)(9686003)(83380400001)(8936002)(4326008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RcJ+EWDy3GIQIYGFTwWGtqB4nzthNfoKdr/XYfJO2/AZCa++JkhnIKtjV49v?=
 =?us-ascii?Q?Frtn1R9IMDvFApk7SM0yflWhyUmNlmPYABw0o6QksC/GpNtEznee37D9/qMY?=
 =?us-ascii?Q?Hfk4lOQb4RsptrtaYjEuoExPFryhxened8fysyAw7QSFoByKUzdPW12yNZBL?=
 =?us-ascii?Q?hUROKRM87Ahdk7ZjIDSx/PpBLV6RLr+dh5WiqOankMok1MadTIKg8nfrgtTL?=
 =?us-ascii?Q?XmDxnFDAFdAua3wnszj3SeABdw0mf29DXPoq41WeNpghYaKaETbE3oHsJ7ed?=
 =?us-ascii?Q?32M6l8oB26+DtJ8lQ8v1d+iDFkde4yl6nZd2f4EnNFmHnh3MYuAqRHqWGpLV?=
 =?us-ascii?Q?4OlCtAb7LqaycwQYfRpM/nh+EG9Zgmf/lVbM2ZwTQbotjkZXZVZ+TPSIFYxy?=
 =?us-ascii?Q?x7uhDbVkr0C9BIYEPmI+cfki0V1p6BR4K6MvOPkeoXE5I7q5TLMmDAu5GiJ5?=
 =?us-ascii?Q?mIbOingzcjhmpMNQcus+n3yQxXmJQXi8xyU2dccEJgKarjlrLyh6FN6d6EHe?=
 =?us-ascii?Q?vE84S4ItUTW3va5qQMqHBT2VFrR5SdLaCR935hyCawwciRcQBZ4ub4mrTWRv?=
 =?us-ascii?Q?nuXXyaGNYo+f6GPud4Fr+2DvwP4ZXQx9lhouX5t0gvM2i0CEtuOToRpfOQyT?=
 =?us-ascii?Q?RF+YtzY/MOJJKZQOJaqDbhD5dLDK/sXVOoGZfQCkQzPJjm5yL5nKytytlMla?=
 =?us-ascii?Q?PgI91sIpHjSsGSuv+rdvzOje/RWavepGVQNbXYj/eKyzKKY2G9I79Z5xwmJB?=
 =?us-ascii?Q?KV+GgofS9pQr6qH429VH8QCFsizbP8nMQsF2sy9xWt2s7fNdpgwrvrL1NmJ5?=
 =?us-ascii?Q?8nEpBTyMNqvlH4/7rueXUNoctVqHzrGpYPdPHuP6/tKnuqOP0pcJnVB/jO8B?=
 =?us-ascii?Q?avM9hQYNhMUQTZDjon5X3ZaaYSSHP8njcMWuqgk+yaNBVj5L2X/EdpLicjBS?=
 =?us-ascii?Q?+hNanylQoXQY8C73xKYAdfUfjC63vXBX9a/2iElM4kiFWmMi88rNUe/dh/OZ?=
 =?us-ascii?Q?gaPYMfaz1JVNncqaoyLBPmTn0Qqg+J7v7Q3kEWDRpScM9I96unLEf5RqAPrn?=
 =?us-ascii?Q?438yo0XzFCufc7pGE62ryhj+oozlVXWUC3pq5Rf64QIy5zlxSJM1ng791m7E?=
 =?us-ascii?Q?CCXLTGqzb0nXtPGRkGJsDEl9H3qF6yGlPNjCrjUFb0QJMfn3INSEEOxmL34I?=
 =?us-ascii?Q?SeoENVXwo6zztZSfZExJG5FZsoWPqsAD6mkhAHDXHAig+IdCEfYmONLgLWmE?=
 =?us-ascii?Q?ydBEyl3gTL+vy1k1tQjK2HyjjciaJ7ZOzklhibTCYm37k9xQmNA8k3eS99Cp?=
 =?us-ascii?Q?kIyWn9is38j3vHfCBLHcclRChxhjqlN8IgqL6zRarDKTYb2NPYwMN2V11EtG?=
 =?us-ascii?Q?8elM7IHzyhv4iezIHivM885qeHS7CQIKqO1p8ssL+jkerGAhn/Qg9twhLfSL?=
 =?us-ascii?Q?MJQgVRQ6dap5sMBawZKc2vrZ+TyG0Sns5k+0RJfb0Kbbsq6Yocktmx7Ce7IN?=
 =?us-ascii?Q?xcegYOiUFL8afw39oM/Ku8FTGZfop2Wf7NDHp3zGscWnFBmJSxEggW+fIoYe?=
 =?us-ascii?Q?pkmXlBIsOmI86rYjLtA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1770.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45c275fd-d37a-491b-9c2e-08d9d7102ddf
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2022 03:44:33.7619 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o0ofIKF81ocny4J4gzFtXaeASnrZwfdcdcQsTCRpVdkBJsP6m3QZRfzWcPIiqpby
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4910
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

[AMD Official Use Only]



> -----Original Message-----
> From: Chai, Thomas <YiPeng.Chai@amd.com>
> Sent: Friday, January 14, 2022 11:36 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Chai, Thomas <YiPeng.Chai@amd.com>; Zhang, Hawking
> <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Clements,
> John <John.Clements@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>
> Subject: [PATCH 1/5] drm/amdgpu: Fix the code style warnings in amdgpu_ra=
s
>=20
> Fix the code style warnings in amdgpu_ras.

[Tao] Could you add more description to explain the warnings you want to fi=
x?

>=20
> Signed-off-by: yipechai <YiPeng.Chai@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 41 +++++++++++++++----------
> drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h | 10 +++---
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
> -static struct amdgpu_ras_block_object* amdgpu_ras_get_ras_block(struct
> amdgpu_device *adev,
> +static struct amdgpu_ras_block_object *amdgpu_ras_get_ras_block(struct
> +amdgpu_device *adev,
>  					enum amdgpu_ras_block block,
> uint32_t sub_block_index)  {
>  	struct amdgpu_ras_block_object *obj, *tmp; @@ -941,7 +941,7 @@
> static void amdgpu_ras_get_ecc_info(struct amdgpu_device *adev, struct
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
>  		block_obj =3D amdgpu_ras_get_ras_block(adev, info->head.block,
> 0);
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
> +	struct amdgpu_ras_block_object *block_obj =3D
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
> @@ -1066,7 +1067,8 @@ int amdgpu_ras_error_inject(struct amdgpu_device
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
> @@ -1702,19 +1704,25 @@ static void amdgpu_ras_log_on_err_counter(struct
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
> amdgpu_register_bad_pages_mca_notifier(struct amdgpu_device *adev)  }
> #endif
>=20
> -struct amdgpu_ras* amdgpu_ras_get_context(struct amdgpu_device *adev)
> +struct amdgpu_ras *amdgpu_ras_get_context(struct amdgpu_device *adev)
>  {
>  	if (!adev)
>  		return NULL;
> @@ -2723,7 +2731,7 @@ struct amdgpu_ras* amdgpu_ras_get_context(struct
> amdgpu_device *adev)
>  	return adev->psp.ras_context.ras;
>  }
>=20
> -int amdgpu_ras_set_context(struct amdgpu_device *adev, struct amdgpu_ras=
*
> ras_con)
> +int amdgpu_ras_set_context(struct amdgpu_device *adev, struct
> +amdgpu_ras *ras_con)
>  {
>  	if (!adev)
>  		return -EINVAL;
> @@ -2755,7 +2763,7 @@ int amdgpu_ras_reset_gpu(struct amdgpu_device
> *adev)
>=20
>  /* Register each ip ras block into amdgpu ras */  int
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
>  	const struct amdgpu_ras_block_hw_ops *hw_ops; @@ -504,7 +505,7
> @@ struct amdgpu_ras_block_object {
>=20
>  struct amdgpu_ras_block_hw_ops {
>  	int  (*ras_error_inject)(struct amdgpu_device *adev, void *inject_if);
> -	void (*query_ras_error_count)(struct amdgpu_device *adev,void
> *ras_error_status);
> +	void (*query_ras_error_count)(struct amdgpu_device *adev, void
> +*ras_error_status);
>  	void (*query_ras_error_status)(struct amdgpu_device *adev);
>  	void (*query_ras_error_address)(struct amdgpu_device *adev, void
> *ras_error_status);
>  	void (*reset_ras_error_count)(struct amdgpu_device *adev); @@ -
> 678,7 +679,8 @@ int amdgpu_ras_reset_gpu(struct amdgpu_device *adev);
>=20
>  struct amdgpu_ras* amdgpu_ras_get_context(struct amdgpu_device *adev);
>=20
> -int amdgpu_ras_set_context(struct amdgpu_device *adev, struct amdgpu_ras=
*
> ras_con);
> +int amdgpu_ras_set_context(struct amdgpu_device *adev, struct
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
