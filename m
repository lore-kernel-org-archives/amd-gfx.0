Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A2FFC433F5
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Feb 2022 08:54:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B9D7810E5CF;
	Wed,  9 Feb 2022 08:54:56 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2069.outbound.protection.outlook.com [40.107.236.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 198C810E5CF
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Feb 2022 08:54:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FWqbDNF5F1v/wFWxpBkd7zQ3WCOoM8nd3h95RMIvy89s1a4A7mPLzB1cBZO5xjz49gDA1WSguS6PD+Jo6VnxZgkt3ClcP4OW5EZeNDV1RKFdRydFoMzz0ZBjp16ThGBt39cVXn/N3WCWWjl+R0qkxn/VDSkTVnU/FM2Yq0YECQ6FMGTn2kvAbI7VZicjwQUVHiW7B9HeihAV8ZFJnpz+DB1EQpo9Bnj0staFhuPvxqaHLdkhq0GVHabaL+bcOMoOwV+nsPPRDJ3A4ppWoCFTjk4TftAO0DfcXZIx29oP1UKaqdikZPFeC/1XaEPKJ7Y9cUDCqAynBduSGyxKpmWVYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0+Cl2C3Mou7eKLubXWOc3wTabJjsdph3CCRraI/VMAs=;
 b=G1IDtyf/yJPYG/LMnXu5ghpB1nNvi+4VRkVNsNk1DtNFh5JfvZVNQMfUsW+zOgfLJGlw7+bNtdFzZtNTtcy/jWEk+y35DYEVVcpBJRt2xm/307tSTVH21eaTOdsuccld7unM+YXDdvvaCc1ClDByClx9WBGh6OR/b7C6FsPWrpTn6sWbtfc+kmpneoj/ez+Kcc0GcyNLGmwTSyOlhIBz0US+E42gwAGHY4sprC22jDgl5iw0tcimtZlJvB4x1SlntOjYd+fy3kmyMtCvjJCyRCw9m+TjzsuG4yDHsggdXYoZxTF6oLB3tJlTX6DoWdx2RHABXCXvYq8UtIzqP2Dxag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0+Cl2C3Mou7eKLubXWOc3wTabJjsdph3CCRraI/VMAs=;
 b=cjLsQu48cldNO73+ItUumIEgOXKLHV8oyMa3mMYOeX1t3DhZeVjNJ1n0xOCM3Ayeuat2ihbXdAkks+yYId/fvc1PXq2qbC+4/avRvwADLcjeZiy2ng87y0HaH4+afkVK9/nUAMwyvdvB5dtgjlT4Q5pOm0sJPguRzLXlyjIpP/8=
Received: from DM5PR12MB1770.namprd12.prod.outlook.com (2603:10b6:3:108::22)
 by PH0PR12MB5647.namprd12.prod.outlook.com (2603:10b6:510:144::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.14; Wed, 9 Feb
 2022 08:54:53 +0000
Received: from DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::1551:5d31:89de:9e7f]) by DM5PR12MB1770.namprd12.prod.outlook.com
 ([fe80::1551:5d31:89de:9e7f%3]) with mapi id 15.20.4951.019; Wed, 9 Feb 2022
 08:54:53 +0000
From: "Zhou1, Tao" <Tao.Zhou1@amd.com>
To: "Chai, Thomas" <YiPeng.Chai@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 01/11] drm/amdgpu: Optimize
 xxx_ras_late_init/xxx_ras_late_fini for each ras block
Thread-Topic: [PATCH 01/11] drm/amdgpu: Optimize
 xxx_ras_late_init/xxx_ras_late_fini for each ras block
Thread-Index: AQHYHXn+dH+8RriMPki060ThAvwnNqyK6lOg
Date: Wed, 9 Feb 2022 08:54:53 +0000
Message-ID: <DM5PR12MB177083B00D19257A05CD2294B02E9@DM5PR12MB1770.namprd12.prod.outlook.com>
References: <20220209055644.1873011-1-YiPeng.Chai@amd.com>
In-Reply-To: <20220209055644.1873011-1-YiPeng.Chai@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2022-02-09T08:54:51Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=220374ba-b317-4ae9-8084-7d476b7393f6;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_enabled: true
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_setdate: 2022-02-09T08:54:51Z
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_method: Standard
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_name: AMD Official Use
 Only-AIP 2.0
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_actionid: ad918ce1-7b71-4662-ae22-ba5152637078
msip_label_88914ebd-7e6c-4e12-a031-a9906be2db14_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 24d22328-270d-4fd5-72fb-08d9eba9d6c6
x-ms-traffictypediagnostic: PH0PR12MB5647:EE_
x-microsoft-antispam-prvs: <PH0PR12MB5647AB30D2DAB499F6D164F2B02E9@PH0PR12MB5647.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:79;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TbdYrOLqVA82rZT5EwITI12UIWJuMLiKc3OCNOMAbVE9ymrEEw2/xGVWZfXGnHgiUI6w1supzb4Jyv9GxsdYUu+vHQcFycHEBwobJ5v7v5smhFK8jvh1Jhl3IYNOuO1ZgDvml8+3o4oblqnSoSICEjr03dBLjQo/cN6gvvfwPj9b6954zAWoaYcp+Bx1tyNUMMXr6EATUxUdEvx830wao9Llrf7shDoJbrMdW4ONU7a/7+EWjEoBXZAevYnBzL9dkV7xlnstBskgVI1DeGe7F8y/HqULIzoB66+4uZsdrUE2NvoKBM7mnpkyFYdMeE6mIUHHZPrQbCb1rbXKqWq1Ejz2iuToTc3TTaaimxKLi7oga84Ch7yZb9DfWKVEjjZKirHKtLA8Keu7SnQBMU4wG85/XicxHlmW5ISPU+95DHut1d3V5wmZJqV2FaJLLoBOksVA03ln5Ebzf0BQY7UYyFIJsNBg2M6D6ZB6og0Wqb+p72CgxdMXv83jJHuIMx1M1EySVJNfepDmICu9EffENF9+qGD7TjDUz8agF1x70famc+YiGhBQeE4sZAcVXETRwwYKuQvSObXx/AexR7OQOCgS5y43s9/WV8ROg3S30KKgY3h8cqtpm/FDwjS7Kh4rz8qIQx23G7m/rUby1FYWTU4KWNsCPqJd6KNSVSkZL5vjrw449c3F4E/erBFcP7kbYyHHKIuS4C7fR8SHKPYRbD0FfMSuSiGMBJcNEvSF7ho=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1770.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(86362001)(71200400001)(316002)(110136005)(508600001)(66556008)(66476007)(66446008)(64756008)(66946007)(122000001)(4326008)(8676002)(8936002)(54906003)(38070700005)(26005)(76116006)(186003)(83380400001)(52536014)(5660300002)(30864003)(2906002)(53546011)(33656002)(55016003)(9686003)(6506007)(7696005)(38100700002)(21314003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?y3XYnryGDb7t792SItX0u1YS5rNgN9cUsxJa/V4zaHbcWyuHM41SOESB6gV5?=
 =?us-ascii?Q?zrfbOPJQyd1lxKDfbv2Q8hf0R7JIBDnzqcwa1PHTM5FQHsA6D5UXbkH0cdW5?=
 =?us-ascii?Q?7zqCG7nyw1FJXqpZ+uRgs3h7awTSemqUNfGkponVKEV6UVzuG5oOpVGy07dh?=
 =?us-ascii?Q?rla7mVHs0514QZKyedMsimMKAE2UDH1r9SQUKPtcTnxTCHEHVu4FAaGrfRaB?=
 =?us-ascii?Q?RGFJPFslNH9ykQikM0htAASO2XcKTJ/G2IFQ5bfEiJFdsEQOI7GUDa3/d1+3?=
 =?us-ascii?Q?2GteA3givU4sfibLCmTD/4lU4IUbtsdZ6BDy1CE2Mh9l70DJwX3MWyCgpdi5?=
 =?us-ascii?Q?2IRXfkQMZocD4eAc7iLx8Gp+TMY68DQoG2O5i/iD5VPPRk5oSLn8vD1UPLGd?=
 =?us-ascii?Q?V8d/k6G8se4JdsqV5Jl3M31rXb2lpIpIyxI6rL1RkNI1FfqZ5q0lTk05+nR2?=
 =?us-ascii?Q?tTL6+6LR1zm/Otvlx4ImzfkieVcsXxa3y5yVoIil9FARW9yLH6OMY3MpRoDa?=
 =?us-ascii?Q?HlU1ppH5iJyZCRDnfOFN2+Seklk1UWJrCMLziwXto+YhqG6Mh/15/w4oKNVb?=
 =?us-ascii?Q?H9BDW4BxNo9Agsb+6P9ihWeH4uzhudAy+USE0+jFkb3nodQz/VEbV0MXN/1w?=
 =?us-ascii?Q?EuYXxpSxf3ENb4YzpvTn88hfBj3l6Ko1zXkMbu5ZXTpoJBrzzDKFdGN4DRnT?=
 =?us-ascii?Q?uhuafVGmacNVkqmOhGS1T3QtCEuOQP+j+mWLXxq+XDbDYch3M0DDsyq8oqSP?=
 =?us-ascii?Q?0CZ+IYA+WFlJFpjy5EPnLywvOXv1yFGJJqCNpgEwv4ZsuCvV9gC54y2+9roE?=
 =?us-ascii?Q?md9tG+PmuM9+29ytamps0XAp2XPQBEy+JJ2MgOHlyB68nglxUpqeBWlGH8pu?=
 =?us-ascii?Q?BTIGZIma98pyA1dyGjAGCTiCWUMHxnZZs+Ix6pqrEzTBFVMvS9GHBHgyUwbu?=
 =?us-ascii?Q?dubtI/kwxowzjT8TCiQKhHtOlN/LuTfpLqbbiqVL9VykbTVS0sixGDPr72de?=
 =?us-ascii?Q?8AUcv3W5Ny/eOagcmlhHaLQj6AdyiTvJtgQDSJXXpu1mlFn/la1v2J2AZwpr?=
 =?us-ascii?Q?uaNrTKglt6L96i5RP5ni3tcKxXX8c2vCmoGyVXrrQViJzP4P0Ax2iat/Ep8W?=
 =?us-ascii?Q?qB2/QV4N5w6O0pyivsJonTK5/AAKSZOCwViqCYw/eIvVlh4mBGUc06aCDaBt?=
 =?us-ascii?Q?9VTNogFePHAS6jYHBzOI8AdzL5Y1IbeLnobWsskZCUih6jzHfjAn5Q08ImrR?=
 =?us-ascii?Q?rxRZcUCZu0SKxL9Pa92LDSn6b+Vpd7+otwc8ZoiVy8+KQI00WJ+Ifg5dnHG2?=
 =?us-ascii?Q?B7EYLsU59+/VI0uU/JCJJlxEY5AzK6Pyw0dPpifi+/yniNAKgQYONl96UX89?=
 =?us-ascii?Q?ftTkoDjl0GI3G2jgDvdjfw/GJmzbgfPa7fqWqOeeNgg31kgZie4sw+fTKPz1?=
 =?us-ascii?Q?vF7iswIs8iIFFR1FrUm/7n1V4fGLdQeBRk09wD5lvI63IszC4pFkzbVDuZY+?=
 =?us-ascii?Q?0FlwVsKKICpEbf7CYhdBhSAdNZTrfYFN77gVngYueXgIfGXgE6WuZ7x4jGko?=
 =?us-ascii?Q?6tuWGwByK8k1i6Dq6PA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1770.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24d22328-270d-4fd5-72fb-08d9eba9d6c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2022 08:54:53.4184 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cEARLb4v8Zu5SZK2sR211paNQENBAaSC4zDaZmBk7+gxkA1gpZeY4DZwwoZLVbLn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5647
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
> Sent: Wednesday, February 9, 2022 1:57 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Chai, Thomas <YiPeng.Chai@amd.com>; Zhang, Hawking
> <Hawking.Zhang@amd.com>; Zhou1, Tao <Tao.Zhou1@amd.com>; Clements,
> John <John.Clements@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>
> Subject: [PATCH 01/11] drm/amdgpu: Optimize
> xxx_ras_late_init/xxx_ras_late_fini for each ras block
>=20
> 1. Define amdgpu_ras_block_late_init to create sysfs nodes
>    and interrupt handles.
> 2. Define amdgpu_ras_block_late_fini to remove sysfs nodes
>    and interrupt handles.
> 3. Replace ras block variable members in struct
>    amdgpu_ras_block_object with struct ras_common_if, which
>    can makes it easy to associate each ras block instance
[Tao]: makes -> make

>    with each ras block functional interface.
> 4. Add .ras_cb to struct amdgpu_ras_block_object.
> 5. Change each ras block to fit for the changement of struct
>    amdgpu_ras_block_object.
>=20
> Signed-off-by: yipechai <YiPeng.Chai@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c  |  7 +++--
> drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c  | 35
> +++++++++++++++++++++++-  drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h  |
> 15 ++++++----  drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c |  6 ++--
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c    |  4 +--
>  drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c   |  4 +--
>  drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c    |  8 +++---
>  drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c    |  6 ++--
>  drivers/gpu/drm/amd/amdgpu/mca_v3_0.c    | 28 +++++++++++--------
>  drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c   |  6 ++--
>  drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c   |  4 +--
>  11 files changed, 86 insertions(+), 37 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
> index 52a60c2316a2..ad057d6b2c77 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mca.c
> @@ -83,14 +83,15 @@ int amdgpu_mca_ras_late_init(struct amdgpu_device
> *adev,
>  		.sysfs_name =3D sysfs_name,
>  	};
>=20
> -	snprintf(sysfs_name, sizeof(sysfs_name), "%s_err_count", mca_dev-
> >ras->ras_block.name);
> +	snprintf(sysfs_name, sizeof(sysfs_name), "%s_err_count",
> +		mca_dev->ras->ras_block.ras_comm.name);
>=20
>  	if (!mca_dev->ras_if) {
>  		mca_dev->ras_if =3D kmalloc(sizeof(struct ras_common_if),
> GFP_KERNEL);
>  		if (!mca_dev->ras_if)
>  			return -ENOMEM;
> -		mca_dev->ras_if->block =3D mca_dev->ras->ras_block.block;
> -		mca_dev->ras_if->sub_block_index =3D mca_dev->ras-
> >ras_block.sub_block_index;
> +		mca_dev->ras_if->block =3D mca_dev->ras-
> >ras_block.ras_comm.block;
> +		mca_dev->ras_if->sub_block_index =3D
> +mca_dev->ras->ras_block.ras_comm.sub_block_index;
>  		mca_dev->ras_if->type =3D
> AMDGPU_RAS_ERROR__MULTI_UNCORRECTABLE;
>  	}
>  	ih_info.head =3D fs_info.head =3D *mca_dev->ras_if; diff --git
> a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 5934326b9db3..b7aed19db7e9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -877,7 +877,7 @@ static int amdgpu_ras_block_match_default(struct
> amdgpu_ras_block_object *block_
>  	if (!block_obj)
>  		return -EINVAL;
>=20
> -	if (block_obj->block =3D=3D block)
> +	if (block_obj->ras_comm.block =3D=3D block)
>  		return 0;
>=20
>  	return -EINVAL;
> @@ -2457,6 +2457,23 @@ int amdgpu_ras_late_init(struct amdgpu_device
> *adev,
>  	return r;
>  }
>=20
> +int amdgpu_ras_block_late_init(struct amdgpu_device *adev,
> +			struct ras_common_if *ras_block)
> +{
> +	char sysfs_name[32];
> +	struct ras_ih_if ih_info;
> +	struct ras_fs_if fs_info;
> +	struct amdgpu_ras_block_object *obj;
> +
> +	obj =3D container_of(ras_block, struct amdgpu_ras_block_object,
> ras_comm);
> +	ih_info.cb =3D obj->ras_cb;
> +	ih_info.head =3D *ras_block;
> +	snprintf(sysfs_name, sizeof(sysfs_name), "%s_err_count", ras_block-
> >name);
> +	fs_info.sysfs_name =3D (const char *)sysfs_name;
> +	fs_info.head =3D *ras_block;
> +	return amdgpu_ras_late_init(adev, ras_block, &fs_info, &ih_info); }
> +
>  /* helper function to remove ras fs node and interrupt handler */  void
> amdgpu_ras_late_fini(struct amdgpu_device *adev,
>  			  struct ras_common_if *ras_block,
> @@ -2470,6 +2487,22 @@ void amdgpu_ras_late_fini(struct amdgpu_device
> *adev,
>  		amdgpu_ras_interrupt_remove_handler(adev, ih_info);  }
>=20
> +void amdgpu_ras_block_late_fini(struct amdgpu_device *adev,
> +			  struct ras_common_if *ras_block)
> +{
> +	struct ras_ih_if ih_info;
> +	struct amdgpu_ras_block_object *obj;
> +
> +	if (!ras_block)
> +		return;
> +
> +	obj =3D container_of(ras_block, struct amdgpu_ras_block_object,
> ras_comm);
> +	ih_info.head =3D *ras_block;
> +	ih_info.cb =3D obj->ras_cb;
> +
> +	amdgpu_ras_late_fini(adev, ras_block, &ih_info); }
> +
>  /* do some init work after IP late init as dependence.
>   * and it runs in resume/gpu reset/booting up cases.
>   */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> index a55743b12d57..8b94b556baf6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
> @@ -486,17 +486,13 @@ struct ras_debug_if {  };
>=20
>  struct amdgpu_ras_block_object {
> -	/* block name */
> -	char name[32];
> -
> -	enum amdgpu_ras_block block;
> -
> -	uint32_t sub_block_index;
> +	struct ras_common_if  ras_comm;
>=20
>  	int (*ras_block_match)(struct amdgpu_ras_block_object *block_obj,
>  				enum amdgpu_ras_block block, uint32_t
> sub_block_index);
>  	int (*ras_late_init)(struct amdgpu_device *adev, void *ras_info);
>  	void (*ras_fini)(struct amdgpu_device *adev);
> +	ras_ih_cb ras_cb;
>  	const struct amdgpu_ras_block_hw_ops *hw_ops;  };
>=20
> @@ -605,10 +601,17 @@ int amdgpu_ras_late_init(struct amdgpu_device
> *adev,
>  			 struct ras_common_if *ras_block,
>  			 struct ras_fs_if *fs_info,
>  			 struct ras_ih_if *ih_info);
> +
> +int amdgpu_ras_block_late_init(struct amdgpu_device *adev,
> +			struct ras_common_if *ras_block);
> +
>  void amdgpu_ras_late_fini(struct amdgpu_device *adev,
>  			  struct ras_common_if *ras_block,
>  			  struct ras_ih_if *ih_info);
>=20
> +void amdgpu_ras_block_late_fini(struct amdgpu_device *adev,
> +			  struct ras_common_if *ras_block);
> +
>  int amdgpu_ras_feature_enable(struct amdgpu_device *adev,
>  		struct ras_common_if *head, bool enable);
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> index 5929d6f528c9..15707af89212 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> @@ -981,8 +981,10 @@ struct amdgpu_ras_block_hw_ops  xgmi_ras_hw_ops
> =3D {
>=20
>  struct amdgpu_xgmi_ras xgmi_ras =3D {
>  	.ras_block =3D {
> -		.name =3D "xgmi",
> -		.block =3D AMDGPU_RAS_BLOCK__XGMI_WAFL,
> +		.ras_comm =3D {
> +			.name =3D "xgmi",
> +			.block =3D AMDGPU_RAS_BLOCK__XGMI_WAFL,
> +		},
>  		.hw_ops =3D &xgmi_ras_hw_ops,
>  		.ras_late_init =3D amdgpu_xgmi_ras_late_init,
>  		.ras_fini =3D amdgpu_xgmi_ras_fini,
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index ca7b886c6ce6..0a291d2e5f91 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -2198,8 +2198,8 @@ static int gfx_v9_0_gpu_early_init(struct
> amdgpu_device *adev)
>  			return err;
>  		}
>=20
> -		strcpy(adev->gfx.ras->ras_block.name,"gfx");
> -		adev->gfx.ras->ras_block.block =3D AMDGPU_RAS_BLOCK__GFX;
> +		strcpy(adev->gfx.ras->ras_block.ras_comm.name, "gfx");
> +		adev->gfx.ras->ras_block.ras_comm.block =3D
> AMDGPU_RAS_BLOCK__GFX;
>=20
>  		/* If not define special ras_late_init function, use gfx default
> ras_late_init */
>  		if (!adev->gfx.ras->ras_block.ras_late_init)
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> index bddaf2417344..2a362c570346 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> @@ -672,8 +672,8 @@ static void gmc_v10_0_set_umc_funcs(struct
> amdgpu_device *adev)
>  	if (adev->umc.ras) {
>  		amdgpu_ras_register_ras_block(adev, &adev->umc.ras-
> >ras_block);
>=20
> -		strcpy(adev->umc.ras->ras_block.name, "umc");
> -		adev->umc.ras->ras_block.block =3D
> AMDGPU_RAS_BLOCK__UMC;
> +		strcpy(adev->umc.ras->ras_block.ras_comm.name, "umc");
> +		adev->umc.ras->ras_block.ras_comm.block =3D
> AMDGPU_RAS_BLOCK__UMC;
>=20
>  		/* If don't define special ras_late_init function, use default
> ras_late_init */
>  		if (!adev->umc.ras->ras_block.ras_late_init)
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index 4595027a8c63..af873c99d5e4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -1232,8 +1232,8 @@ static void gmc_v9_0_set_umc_funcs(struct
> amdgpu_device *adev)
>  	if (adev->umc.ras) {
>  		amdgpu_ras_register_ras_block(adev, &adev->umc.ras-
> >ras_block);
>=20
> -		strcpy(adev->umc.ras->ras_block.name, "umc");
> -		adev->umc.ras->ras_block.block =3D
> AMDGPU_RAS_BLOCK__UMC;
> +		strcpy(adev->umc.ras->ras_block.ras_comm.name, "umc");
> +		adev->umc.ras->ras_block.ras_comm.block =3D
> AMDGPU_RAS_BLOCK__UMC;
>=20
>  		/* If don't define special ras_late_init function, use default
> ras_late_init */
>  		if (!adev->umc.ras->ras_block.ras_late_init)
> @@ -1280,8 +1280,8 @@ static void gmc_v9_0_set_mmhub_ras_funcs(struct
> amdgpu_device *adev)
>  	if (adev->mmhub.ras) {
>  		amdgpu_ras_register_ras_block(adev, &adev->mmhub.ras-
> >ras_block);
>=20
> -		strcpy(adev->mmhub.ras->ras_block.name,"mmhub");
> -		adev->mmhub.ras->ras_block.block =3D
> AMDGPU_RAS_BLOCK__MMHUB;
> +		strcpy(adev->mmhub.ras->ras_block.ras_comm.name,
> "mmhub");
> +		adev->mmhub.ras->ras_block.ras_comm.block =3D
> AMDGPU_RAS_BLOCK__MMHUB;
>=20
>  		/* If don't define special ras_late_init function, use default
> ras_late_init */
>  		if (!adev->mmhub.ras->ras_block.ras_late_init)
> diff --git a/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
> b/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
> index 6b41fcbf4875..503c292b321e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/hdp_v4_0.c
> @@ -157,8 +157,10 @@ struct amdgpu_ras_block_hw_ops
> hdp_v4_0_ras_hw_ops =3D {
>=20
>  struct amdgpu_hdp_ras hdp_v4_0_ras =3D {
>  	.ras_block =3D {
> -		.name =3D "hdp",
> -		.block =3D AMDGPU_RAS_BLOCK__HDP,
> +		.ras_comm =3D {
> +			.name =3D "hdp",
> +			.block =3D AMDGPU_RAS_BLOCK__HDP,
> +		},
>  		.hw_ops =3D &hdp_v4_0_ras_hw_ops,
>  		.ras_late_init =3D amdgpu_hdp_ras_late_init,
>  		.ras_fini =3D amdgpu_hdp_ras_fini,
> diff --git a/drivers/gpu/drm/amd/amdgpu/mca_v3_0.c
> b/drivers/gpu/drm/amd/amdgpu/mca_v3_0.c
> index 68565262af9c..386416378a82 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mca_v3_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mca_v3_0.c
> @@ -53,8 +53,8 @@ static int mca_v3_0_ras_block_match(struct
> amdgpu_ras_block_object *block_obj,
>  	if (!block_obj)
>  		return -EINVAL;
>=20
> -	if ((block_obj->block =3D=3D block) &&
> -		(block_obj->sub_block_index =3D=3D sub_block_index)) {
> +	if ((block_obj->ras_comm.block =3D=3D block) &&
> +		(block_obj->ras_comm.sub_block_index =3D=3D sub_block_index)) {
>  		return 0;
>  	}
>=20
> @@ -68,9 +68,11 @@ const struct amdgpu_ras_block_hw_ops
> mca_v3_0_mp0_hw_ops =3D {
>=20
>  struct amdgpu_mca_ras_block mca_v3_0_mp0_ras =3D {
>  	.ras_block =3D {
> -		.block =3D AMDGPU_RAS_BLOCK__MCA,
> -		.sub_block_index =3D AMDGPU_RAS_MCA_BLOCK__MP0,
> -		.name =3D "mp0",
> +		.ras_comm =3D {
> +			.block =3D AMDGPU_RAS_BLOCK__MCA,
> +			.sub_block_index =3D AMDGPU_RAS_MCA_BLOCK__MP0,
> +			.name =3D "mp0",
> +		},
>  		.hw_ops =3D &mca_v3_0_mp0_hw_ops,
>  		.ras_block_match =3D mca_v3_0_ras_block_match,
>  		.ras_late_init =3D mca_v3_0_mp0_ras_late_init, @@ -103,9
> +105,11 @@ const struct amdgpu_ras_block_hw_ops mca_v3_0_mp1_hw_ops
> =3D {
>=20
>  struct amdgpu_mca_ras_block mca_v3_0_mp1_ras =3D {
>  	.ras_block =3D {
> -		.block =3D AMDGPU_RAS_BLOCK__MCA,
> -		.sub_block_index =3D AMDGPU_RAS_MCA_BLOCK__MP1,
> -		.name =3D "mp1",
> +		.ras_comm =3D {
> +			.block =3D AMDGPU_RAS_BLOCK__MCA,
> +			.sub_block_index =3D AMDGPU_RAS_MCA_BLOCK__MP1,
> +			.name =3D "mp1",
> +		},
>  		.hw_ops =3D &mca_v3_0_mp1_hw_ops,
>  		.ras_block_match =3D mca_v3_0_ras_block_match,
>  		.ras_late_init =3D mca_v3_0_mp1_ras_late_init, @@ -138,9
> +142,11 @@ const struct amdgpu_ras_block_hw_ops mca_v3_0_mpio_hw_ops
> =3D {
>=20
>  struct amdgpu_mca_ras_block mca_v3_0_mpio_ras =3D {
>  	.ras_block =3D {
> -		.block =3D AMDGPU_RAS_BLOCK__MCA,
> -		.sub_block_index =3D AMDGPU_RAS_MCA_BLOCK__MPIO,
> -		.name =3D "mpio",
> +		.ras_comm =3D {
> +			.block =3D AMDGPU_RAS_BLOCK__MCA,
> +			.sub_block_index =3D
> AMDGPU_RAS_MCA_BLOCK__MPIO,
> +			.name =3D "mpio",
> +		},
>  		.hw_ops =3D &mca_v3_0_mpio_hw_ops,
>  		.ras_block_match =3D mca_v3_0_ras_block_match,
>  		.ras_late_init =3D mca_v3_0_mpio_ras_late_init, diff --git
> a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
> b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
> index 39974b449341..c7cca87f1647 100644
> --- a/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
> +++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_4.c
> @@ -664,8 +664,10 @@ const struct amdgpu_ras_block_hw_ops
> nbio_v7_4_ras_hw_ops =3D {
>=20
>  struct amdgpu_nbio_ras nbio_v7_4_ras =3D {
>  	.ras_block =3D {
> -		.name =3D "pcie_bif",
> -		.block =3D AMDGPU_RAS_BLOCK__PCIE_BIF,
> +		.ras_comm =3D {
> +			.name =3D "pcie_bif",
> +			.block =3D AMDGPU_RAS_BLOCK__PCIE_BIF,
> +		},
>  		.hw_ops =3D &nbio_v7_4_ras_hw_ops,
>  		.ras_late_init =3D amdgpu_nbio_ras_late_init,
>  		.ras_fini =3D amdgpu_nbio_ras_fini,
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> index 06a7ceda4c87..8b0a8587dd36 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
> @@ -2814,8 +2814,8 @@ static void sdma_v4_0_set_ras_funcs(struct
> amdgpu_device *adev)
>  	if (adev->sdma.ras) {
>  		amdgpu_ras_register_ras_block(adev, &adev->sdma.ras-
> >ras_block);
>=20
> -		strcpy(adev->sdma.ras->ras_block.name, "sdma");
> -		adev->sdma.ras->ras_block.block =3D
> AMDGPU_RAS_BLOCK__SDMA;
> +		strcpy(adev->sdma.ras->ras_block.ras_comm.name, "sdma");
> +		adev->sdma.ras->ras_block.ras_comm.block =3D
> AMDGPU_RAS_BLOCK__SDMA;
>=20
>  		/* If don't define special ras_late_init function, use default
> ras_late_init */
>  		if (!adev->sdma.ras->ras_block.ras_late_init)
> --
> 2.25.1
