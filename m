Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F945C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Jan 2022 07:14:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFF3B10E429;
	Thu, 27 Jan 2022 07:14:35 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2061.outbound.protection.outlook.com [40.107.236.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1B8910E429
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Jan 2022 07:14:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FBREBu5RWmDjHvcy9axYDqDhF7yUoO+Q7nQrtk3UeJQVISLVb4BfvC45TYVy0S7CIr1m9sno3jp28/Tqq7vm/j1gQF3t5tCSVHA76e031qmnl7CNIjfXGvEb+A/wkOSoB10zqapbDvtsGAb5/5dSXUZpZ3MKcYpeoY9IYEFgQbTeZUZUdiU6/9dmKhJziHf1WRG0dXI7Y9oAe6CVA0p0bUawa2nv060VoVVSll+U7mX4w4di5+15DSGHYDT+a/090Roca3i4tPzqVuF8trMbYF9aSS0DawKRpP97l2V59LLxkq3tuLgXIMFkyfDizV7PPRkWY27idjtRc3zg7+CdPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YVM7nJPGVi05V2BYZqJZidshT+2yJrkpmsz47+QPuwQ=;
 b=g7iTJ2gcZNo5sWey02v/sXzV+n643jRDj8Vu0n7wFaEbzptauN90Q6BYE5m8lG0iSrVU7epFgMm+v5C9DDyKkO3yRbTcHIki6IjuwsLMfA5u5FzYIniApJoY1pRVmT6SmIgHFc/5Zjuw2maCq67OGUklUQChepqBvUtP1QB0AUB7nm5PlUunn2aY00c8+xG1ahjK83cNrmhRG+QTSDZImh3S5uIea3Ik/AlGghSU28jFUq07DbQQKdtQFwUZh3/BSZpb5gBvR9CmIUY12iSSoLu274+34S07Es18JPWuAJBBOmXuoPHmNcfkdai1CGigc16hrm9wUbAtxDwr8Lv2FQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YVM7nJPGVi05V2BYZqJZidshT+2yJrkpmsz47+QPuwQ=;
 b=Yu8fdDEOFZLf23rQ0mHdQeGQ6xNIlRx4CO5k+XZJgiU/0ReZNIlrbkE6S+xyRuCCNANqEeQA4DmSpZlRlrs/gSIQweTyp5zbM5JpJm7v7KOZq4nNgsyAoSgkAQadldIj0mkAvO30mAWDoFGiLEnEoZJUNKqpxAcleD30irydzgY=
Received: from BL1PR12MB5237.namprd12.prod.outlook.com (2603:10b6:208:30b::18)
 by DM6PR12MB4433.namprd12.prod.outlook.com (2603:10b6:5:2a1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Thu, 27 Jan
 2022 07:14:31 +0000
Received: from BL1PR12MB5237.namprd12.prod.outlook.com
 ([fe80::c5a5:a37a:8817:4587]) by BL1PR12MB5237.namprd12.prod.outlook.com
 ([fe80::c5a5:a37a:8817:4587%4]) with mapi id 15.20.4930.017; Thu, 27 Jan 2022
 07:14:31 +0000
From: "Liu, Aaron" <Aaron.Liu@amd.com>
To: "Chen, Guchun" <Guchun.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: move GTT allocation from gmc_sw_init to
 gmc_hw_init
Thread-Topic: [PATCH] drm/amdgpu: move GTT allocation from gmc_sw_init to
 gmc_hw_init
Thread-Index: AQHYE0wbZ8Ar8KFO8EKZmjFmpmxdCqx2cyQAgAAA3wA=
Date: Thu, 27 Jan 2022 07:14:31 +0000
Message-ID: <BL1PR12MB52376E62ECACA6D89065DB33F0219@BL1PR12MB5237.namprd12.prod.outlook.com>
References: <20220127070403.3029564-1-aaron.liu@amd.com>
 <DM5PR12MB2469C3ACE0D780706E633C32F1219@DM5PR12MB2469.namprd12.prod.outlook.com>
In-Reply-To: <DM5PR12MB2469C3ACE0D780706E633C32F1219@DM5PR12MB2469.namprd12.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2022-01-27T07:09:16Z; 
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=d13fa8c1-0eb5-4a5a-85ad-2fc5171a1784;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=1
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_enabled: true
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_setdate: 2022-01-27T07:14:27Z
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_method: Privileged
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_name: Public-AIP 2.0
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_actionid: b36bc7ef-4ea2-4b1f-a3ac-5018142bce13
msip_label_d4243a53-6221-4f75-8154-e4b33a5707a1_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3d62add1-4be7-45ea-9c0e-08d9e164aa40
x-ms-traffictypediagnostic: DM6PR12MB4433:EE_
x-microsoft-antispam-prvs: <DM6PR12MB4433B733DF4223FA74271988F0219@DM6PR12MB4433.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ig9K4R9bNw9DU9Pr6hAQ2jNp/vMmsPqTZYBiK4eWtGZ4uXgQ1zY8sKrnbCGkpVI1iSkgm3LTP6wxlRHF5cz7XP1BvdoeG/lcyxHfgBPY6Bt6kFez/6R/rNXleAsSzy3g1wzQUD6eMsdXotv7saI9+M2iTBGfUEuRlEG/OpoVUE33hZKdPBRK8ccfWP2R4mGaaDtiCCsy+Sm9pLbLQ6HQEAzXX72BWduDTJx8BqEO/81tPnSlaLvFp3GCfPnoP1dI14mnIylHTU0DE8Y6a+5EyoNp673/daKw7CiYMLi45dhHAlZaiDeQwhK1qP+om7cwbpBiNEPNGAfXwMufeB0rs/MqTWhiXFdcOjOoM8psriQwNKMj0Aj1Ivb5KtWaQSKT1WMmNjCzs7/hiH7eJijtjo5NTPgK4RCxvlStnrza4S9JHJsuu/HLrwZbe1Ua7YQhmGlS74wLAarWGZi1CWsneO6kfwhPKyrJZZm1KCcyI9+RrvLcGD9G4H0O5F507Gxeu9+CJyjE0MNIsLZy+OugDPa0YeApg6DxBudq30McA+TCS1eG0xr8UGs8E38mTVYfDVJLy+P/gIGFdS4K/8USkSRrCW1qMw3SR8/g/e/NSH5Ea9q6h6m0tDWPaVIb+AKtHvFrjm+f24FkeX0tPD+LCJTmC51pm+YHsejym204McxvQohQabDAnj10UJHtvvYll3oKv3A7k7b67NnOIPpv6g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5237.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(9686003)(52536014)(66946007)(2906002)(5660300002)(53546011)(76116006)(508600001)(7696005)(6506007)(71200400001)(55016003)(66556008)(66476007)(66446008)(64756008)(83380400001)(26005)(122000001)(316002)(33656002)(110136005)(54906003)(38070700005)(8676002)(38100700002)(8936002)(4326008)(186003)(86362001)(20210929001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KQN7EwWPQGFEmg0ij+8e5I2pul0urCyUdyVz8Wa2z9ZnsybHJk8BY6Kfl4Nl?=
 =?us-ascii?Q?PiJDaq6tnQxiYz0LP/+EmAJJvj2vbY1tT7TNesMIM2QC7jKHJ77xq2EV1Iyv?=
 =?us-ascii?Q?/VLZYJZwGfwYI+Ypnu1M83ZqZS19zcdW91DRXMChRuaeSj5A4POs8pU7vam8?=
 =?us-ascii?Q?n4f5YX1Z9L7IGpKnALrjs5i2lMaLuDkpxHqrP7XjoeB7QKjII17t9WZBH5ss?=
 =?us-ascii?Q?2tjI+AD1IJSjTpyXSRw5DtuAbPd6kgDoUWNda085W5skL44sMMuOUAx2hoky?=
 =?us-ascii?Q?ZCC4ZPRHa7jkvF6NNyA7uZ6Roi/8evRmy/v7jj4U8Yu9yGUTDBNTYSbVFa14?=
 =?us-ascii?Q?MWpjNwYcyOtU4spodeQ+cPYJFUa+cq/YZLuUdg8sJfa3V1q/u3FidwRwE89Q?=
 =?us-ascii?Q?SMYvQqV+UMTdCPPf3/VOE2qC1M7tMRMeYNB9yplVkeImHRK3F6m6DqG6Uy9s?=
 =?us-ascii?Q?xOnCU+KCTb8OxydlmDGIosCFweXF8SDhSv7qlgHEDW06ISSi6rMls2JXWbd2?=
 =?us-ascii?Q?g1akJvtZCixkwXxf0aNfhCZmcGd/crHpN7ccE77dYMJRll2EnuXSoust2JOz?=
 =?us-ascii?Q?NrzqByA77oDTLLWzRYH8OaKshAs61n4L8Ln9FhL1pWZsG1kKf/t8jFzMsXZU?=
 =?us-ascii?Q?M4R+Mg1rf5tmV40P1xSTjGa5Uj8BV7ixmwkQFSRECNfysZwpxB45VQhCRdcv?=
 =?us-ascii?Q?bbkBx1aMx+U5Mola2iXjd1xJedknKtDEBFG1MouVLsRP75bEqrtzMjzsJTsO?=
 =?us-ascii?Q?aX0QmoKhvOj7WfKdXnthMBDexoKkJ3ZLwTPpAnhGR9U6LqzfrT9hGcVCVfQq?=
 =?us-ascii?Q?MEFTMBZmldynTc4W7NUOeapvgmrbk33j3MJv3BuphFrPHud4vOC9y+o5QDjz?=
 =?us-ascii?Q?YGLDelgB7QzrDBoW/h+NPJp/4wVPMzUD5TQXAHTnURn4qpdZyC2h0LLiXngh?=
 =?us-ascii?Q?LoEF5x2cc8g6+w7F5Vqzq6ZffEKg0zPruCItuRKlCT4egkWZnzOeEbYc+K1B?=
 =?us-ascii?Q?MVX4nVBjUhxyxGyylFYhH+TrubBTfjL9yhiH9JYCLI9dluOP2lhr+k08/Kcx?=
 =?us-ascii?Q?6KKwwLfhBWqh+jOhXGd+RXwqcRC7TrNAMtDteqYd+ZAVRhO9x2uzr+UNJ4gF?=
 =?us-ascii?Q?/5qSZMri3M4DF96Jw0dDY4LArg1FpMRP+7FeUof41YANIhjqFao/bNR/04Yq?=
 =?us-ascii?Q?OaROv/hLGZWPQ0kkyUmrnskF05pTuoyJ9oC+VC1C4JXkIL6uvqPMkdbnyOrb?=
 =?us-ascii?Q?SCtCmG+pbU3XusYC9qJxsvxrt5s2n5gtWFwleGMlTO+ybv98hJQusxZd50Fv?=
 =?us-ascii?Q?TNzoMh0G4OA15pc9WYlYK0wTfVsRcOScUsBG2y4IEysHTx6GDta5wnhwZ+Ya?=
 =?us-ascii?Q?xhorZowY/67g/wE48Ff28zHrWEIwp4hFIiwuAdvEcA9OvFWXxfQaf6uUtc1r?=
 =?us-ascii?Q?zYirztKyA7ct1AKkavAfgYX8PXF+GbS8g8jP+p50pScGT99Ycby4T1YVy+TM?=
 =?us-ascii?Q?KMy4i8xgEnYK0rWmP/Tfsm30sSeUVPdNY3tJDBpKnIxtF38ss1gqj/NSaQ0H?=
 =?us-ascii?Q?xFsLW1ADM53Fr+jLInc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5237.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d62add1-4be7-45ea-9c0e-08d9e164aa40
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2022 07:14:31.7882 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iL0Ii6py0LunVMtPnFN9yP/n3dGpjPsjzDmzOAOWNfT2qkYs3F4BCMgotI842Uaj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4433
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Ji,
 Ruili" <Ruili.Ji@amd.com>, "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Kim,
 Jonathan" <Jonathan.Kim@amd.com>, "Huang, Ray" <Ray.Huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Public]

Guchun.
Thanks your reminder. I need to modify again.

--
Best Regards
Aaron Liu

> -----Original Message-----
> From: Chen, Guchun <Guchun.Chen@amd.com>
> Sent: Thursday, January 27, 2022 3:10 PM
> To: Liu, Aaron <Aaron.Liu@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Ji, Ruili <Ruili.Ji@amd.com>; Kim, Jonathan <Jonathan.Kim@amd.com>;
> Kuehling, Felix <Felix.Kuehling@amd.com>; Liu, Aaron
> <Aaron.Liu@amd.com>; Huang, Ray <Ray.Huang@amd.com>; Deucher,
> Alexander <Alexander.Deucher@amd.com>
> Subject: RE: [PATCH] drm/amdgpu: move GTT allocation from gmc_sw_init
> to gmc_hw_init
>=20
> [Public]
>=20
> This will create sdma_access_bo only for ASIC with gmc v10? Original
> creation occurs in amdgpu_ttm_init, it's not limited to ASICs with gmc v1=
0.
>=20
> Regards,
> Guchun
>=20
> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
> Aaron Liu
> Sent: Thursday, January 27, 2022 3:04 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Ji, Ruili <Ruili.Ji@amd.com>; Kim, Jonathan <Jonathan.Kim@amd.com>;
> Kuehling, Felix <Felix.Kuehling@amd.com>; Liu, Aaron
> <Aaron.Liu@amd.com>; Huang, Ray <Ray.Huang@amd.com>; Deucher,
> Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH] drm/amdgpu: move GTT allocation from gmc_sw_init to
> gmc_hw_init
>=20
> The below patch causes system hang for harvested ASICs.
> d015e9861e55 drm/amdgpu: improve debug VRAM access performance
> using sdma
>=20
> The root cause is that GTT buffer should be allocated after GC SA harvest
> programming completed.
>=20
> For harvested AISC, the GC SA harvest process(see utcl2_harvest) is
> programmed in gmc_v10_0_hw_init function. This is a hardware
> programming.
> Therefore should be located in hw init. Hence need to move GTT allocation
> from gmc_v10_0_sw_init to gmc_v10_0_hw_init.
>=20
> Signed-off-by: Aaron Liu <aaron.liu@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 8 --------
> drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c  | 9 +++++++++
>  2 files changed, 9 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 3d8a20956b74..7ce0478b2908 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -1823,12 +1823,6 @@ int amdgpu_ttm_init(struct amdgpu_device
> *adev)
>  		return r;
>  	}
>=20
> -	if (amdgpu_bo_create_kernel(adev, PAGE_SIZE, PAGE_SIZE,
> -				AMDGPU_GEM_DOMAIN_GTT,
> -				&adev->mman.sdma_access_bo, NULL,
> -				&adev->mman.sdma_access_ptr))
> -		DRM_WARN("Debug VRAM access will use slowpath MM
> access\n");
> -
>  	return 0;
>  }
>=20
> @@ -1850,8 +1844,6 @@ void amdgpu_ttm_fini(struct amdgpu_device
> *adev)
>  	if (adev->mman.stolen_reserved_size)
>  		amdgpu_bo_free_kernel(&adev-
> >mman.stolen_reserved_memory,
>  				      NULL, NULL);
> -	amdgpu_bo_free_kernel(&adev->mman.sdma_access_bo, NULL,
> -					&adev->mman.sdma_access_ptr);
>  	amdgpu_ttm_fw_reserve_vram_fini(adev);
>=20
>  	if (drm_dev_enter(adev_to_drm(adev), &idx)) { diff --git
> a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> index 73ab0eebe4e2..c560bdc2a93c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> @@ -1062,6 +1062,12 @@ static int gmc_v10_0_hw_init(void *handle)
>  	if (adev->umc.funcs && adev->umc.funcs->init_registers)
>  		adev->umc.funcs->init_registers(adev);
>=20
> +	if (amdgpu_bo_create_kernel(adev, PAGE_SIZE, PAGE_SIZE,
> +				AMDGPU_GEM_DOMAIN_GTT,
> +				&adev->mman.sdma_access_bo, NULL,
> +				&adev->mman.sdma_access_ptr))
> +		DRM_WARN("Debug VRAM access will use slowpath MM
> access\n");
> +
>  	return 0;
>  }
>=20
> @@ -1082,6 +1088,9 @@ static int gmc_v10_0_hw_fini(void *handle)  {
>  	struct amdgpu_device *adev =3D (struct amdgpu_device *)handle;
>=20
> +	amdgpu_bo_free_kernel(&adev->mman.sdma_access_bo, NULL,
> +					&adev->mman.sdma_access_ptr);
> +
>  	gmc_v10_0_gart_disable(adev);
>=20
>  	if (amdgpu_sriov_vf(adev)) {
> --
> 2.25.1
