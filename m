Return-Path: <SRS0=biE/=M3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9198C4320E
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Aug 2021 07:05:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BAF660F38
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Aug 2021 07:05:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6BAF660F38
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A7E0D6E9E2;
	Wed,  4 Aug 2021 07:05:42 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2080.outbound.protection.outlook.com [40.107.237.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E0836E9E2
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Aug 2021 07:05:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rt+fhhNv2Cyw/ydpZfRToGtcVxoUo1Z4Oclotr1dU6yvbzJ7DHDF+UGs948XY95d2l7f/vmNqLOnskCWOH3fqXwfFXSFI5hYZKSzMuEwq5raJpwhZmz9jslYaaA1Cit81qLAhXb2TERJwIJWnTicUqthic23M5c3653e30dXgak3DyOP/F0tRpryaD8mz63CHoZSi9eC1z7xPI5GVW1hPjLoMu/LvufCzvHRK4JS39b0hu6e8ilEs6k4al+p1OiOcYEaPWWDq718zqGPGqdYb5i6bwRLLWZ59Sw0kk9BCztPFqnUUWMkgrcTMNtMlRKPURqTEUhUExHMq6KC7G650g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qydx6gCz6SGxI19nWHPkpzfZG3BMn4Kh5r9o0zMEE+o=;
 b=am/kfTEbya6tDMPRhYvV5S+q0/2KFmritnf74KmDjtfXUeIUYQUAJOqouByZOaf9Ux7ajWihe7NbgE4VeYzFYAmF5KlhPSiKk6hw9I5DUdh2QwWTb2oRMXokD4/CIMQhEr5ognAb/vL8/ocQsyO6/PHt8cIZLkTZR7z5DSXPl/5fJU3wfD9hXONd2X5Hr/E9o1E5rZxbBxMC5EFv9ai/6wddKGokKzhoJnKVSMn3BWJJ1guBSXk6v0Xx7TFOGuL90s/1hb+lOrlL9V919ikSznlovnrwJzZeZcXlTF3lcEeury4MynxFWsLkeHrNo6ZylAKebKhoEMnbCpdO/Z2VEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qydx6gCz6SGxI19nWHPkpzfZG3BMn4Kh5r9o0zMEE+o=;
 b=yNED092BiWl/CTuumiXdRvcVuPXarFvUIhYSJ7n1nC19Ejjlc/kEOXtln+lHxqVxPS9PteeHmkNT53Jnv8ew7rZvKMItkMA/vdu+Ajz/QlCFeUjuHvq/fG7BxSjX9qaqPYlOq80msfLvYK/pfytHKDxT12H28akWk6LdfPpgORk=
Received: from DM8PR12MB5478.namprd12.prod.outlook.com (2603:10b6:8:29::12) by
 DM4PR12MB5198.namprd12.prod.outlook.com (2603:10b6:5:395::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4373.18; Wed, 4 Aug 2021 07:05:32 +0000
Received: from DM8PR12MB5478.namprd12.prod.outlook.com
 ([fe80::9dce:d45f:88c7:8a72]) by DM8PR12MB5478.namprd12.prod.outlook.com
 ([fe80::9dce:d45f:88c7:8a72%9]) with mapi id 15.20.4373.026; Wed, 4 Aug 2021
 07:05:32 +0000
From: "Zhou, Peng Ju" <PengJu.Zhou@amd.com>
To: "Zhou, Peng Ju" <PengJu.Zhou@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Nieto, David M" <David.Nieto@amd.com>
Subject: RE: [PATCH] drm/amdgpu: add done BO list
Thread-Topic: [PATCH] drm/amdgpu: add done BO list
Thread-Index: AQHXiNafDCq2Dl1SNUSF5Gy2clREKKti7ILA
Date: Wed, 4 Aug 2021 07:05:32 +0000
Message-ID: <DM8PR12MB547892C60E05BABC33CF7C40F8F19@DM8PR12MB5478.namprd12.prod.outlook.com>
References: <20210804021528.25421-1-PengJu.Zhou@amd.com>
In-Reply-To: <20210804021528.25421-1-PengJu.Zhou@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-08-04T07:05:28Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=9963c91f-6f6d-42f0-80ee-a78da979e6db;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 76a4af6f-e6a6-4938-1278-08d95716404c
x-ms-traffictypediagnostic: DM4PR12MB5198:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM4PR12MB51986D362E22071ACA9593BFF8F19@DM4PR12MB5198.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: URMJ753GtdP47nvbF7M62DmBRk8VPjzgnQ12VHgKYneUaNDmGqCfL0IPPt64KyvwEbsdc8sG7+s/DqR7hxU41wsLTPXu01j8rR9gprfYBqHuz61jLgbM81lqEhJM+JrcmirbucT7GBCaNLcw9wrhoSJR+YQUdcdPq7d5hrwPu2VCMpxiYdnzJynDHP8rcz8xTzrSzxoy+1lqPIuil7SeHGSOa7sh90p28WEL86QNnu7KU6ZVLSHHryXEOfAmmK2kIWBLWrm/JLr66D6kjvVkES1E2ddNYzvfXJRMtUkU7u8DyDoslCK3hu/rf2FpnCfIvHbnsWhuU4ngOpuGzxpHp+vsu/4zkHRy1Jp0J/StoVajRpk3J442ctuLZqG4EiDJKda+oTvD4fn8Q1yB/vzYzz+7o0jVk9QBgiKfCYwYHj4nw9pNosjPy9yvvITEAW6ofL5e3FjsQzoeJSFLn1pOdyS2IfB7PsC6p/y6TJ0yMW4hpvsWnN4XGvQ6NHMt5quOxLBFh3mdHW53rxnznoh4M5T0079kTR60Zd6EUa69lBA2ORdaIgze8Lh4cqi/0eO+3JTSTIhxNI7hJbOLAHUvDG58aOBPa07C7cz+hHzZqB+GhKBWdFyl+eTEZBB29jFNazibvdU1nDrUtCAZDgdhvsTiqjb+oLZna+L1xnS/W1KqglHeIyCjVM2MCpPYF1onn9Q+j0xZX97bm4Ze2W0Osw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM8PR12MB5478.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(39860400002)(396003)(376002)(346002)(8676002)(86362001)(71200400001)(33656002)(7696005)(8936002)(4326008)(38070700005)(66476007)(66556008)(64756008)(478600001)(66446008)(9686003)(110136005)(6506007)(26005)(66946007)(76116006)(186003)(55016002)(30864003)(316002)(38100700002)(83380400001)(53546011)(122000001)(5660300002)(52536014)(2906002)(579004)(559001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?aqPxLBvY0EAbt2CbQ88zsdqx7zwVMdC6iVv5p3tvTJF2xFhHT372ztcsNEDM?=
 =?us-ascii?Q?OdpKvs7VpLj+tRAI3xSVhZigSJ7KLdgY3zQ19lF+a9qKQh8I1KyPjYdgiKTB?=
 =?us-ascii?Q?7suiemyKZ/Hk+VMXY/oLkelrm3i8SVB4mzz1vCCUSLVbluLByQ5eVti2RDiF?=
 =?us-ascii?Q?pDcHL35FVeUFHRHA84a0GM0Nj38eqqYNsRAYEt+MQfOKRhChdN5tiF8u5Osw?=
 =?us-ascii?Q?Efb0hJlMl9WPbOqqD7ruYK5CEC0OQcNFAR4onMTfZIyeyAWu8zF18ckVk1VL?=
 =?us-ascii?Q?uEAPj1yiU/2WH8YsWJIyw7ItDD3Ujrkg52qWKfbfpnEuwqQEvL3JrzLrJ/B4?=
 =?us-ascii?Q?iSY7ZmTKatRUhNRgMXTdvcwiojWX7n67Ro3tBbYDpcGbQ85hmMCkl6jEiIMf?=
 =?us-ascii?Q?fJvbpsMQOOj0Rv/R7/g9npbjCxlC/e1RDMh4cwEMOX7OrCnWHpGotVc8Hdt/?=
 =?us-ascii?Q?NCZm5XgU3G13iSkdtxAYHd0LLPVt2jPaVTj+jtOvInnZLfvM6lee+UvD/xmi?=
 =?us-ascii?Q?m3+2PWVpv/Uo5CCiZkuO2vC5ZFIVsSvAGOVlnpLm+Q5lfX55phvgoUVYECZw?=
 =?us-ascii?Q?K/C8h3H6Jvhhdd0XxzcP/8LSvvlQh4lsLSrhNG6JM5w/xxAEqXc4l63gHRL6?=
 =?us-ascii?Q?izrn8vEE8bvjFNfja6QMFF8ma/37+6YzwEOTDb8g75CSQc4Vh29yaLbEMa0P?=
 =?us-ascii?Q?C1FY12aWxmdLcN9mqISp9FS+Rd4l3mWV5GvM0zBjh0AdmgO/rNVJKXlZYEQG?=
 =?us-ascii?Q?vPME8CMFPAZamQxPwSgUrjI4ufKZ8gOuZ+VWb2vQZloetwaNYHCZd9OOeM35?=
 =?us-ascii?Q?/YMtaXdZLIcNYXDzhEkRXNNOecYncU5mdL9967O08zjq7tX1ZGFa/DxRVmvc?=
 =?us-ascii?Q?TdPEr/5mVAEcDLsxVBJdVTgkdWnK9EOdZ1SH/DmQ2fsDHou4ddmC7eWbEuMN?=
 =?us-ascii?Q?1FU8bklhOh7SRi9/ivfvYMuV8MQyefc4ZU21W6LdfXXzwCO1qd9rmzhJyB5n?=
 =?us-ascii?Q?LxkT/peZ/S3+8FOLj8dLkYuF49p9Sd9Zo/bOCxNKitBIVSpmXtsg62E0zpBd?=
 =?us-ascii?Q?7yDeICU2mTJOK435CFM0Fpco5stW4WStHgSbcz7aEuDx1CaUp2ZBEoKF1bH5?=
 =?us-ascii?Q?Wx0HeFNekJyj0ukbsuLxFTE/5Y4dNVoF0zP8aMaBmNCAwOFtt2TwBWdRXh2u?=
 =?us-ascii?Q?WyYzwJ6I6aT2ZowNc2uCIMK2xjkoKa4DivwZQvkb6oJBUsQSOy5Bp3dUfHyB?=
 =?us-ascii?Q?HOMGtCiauimqowVnQ7xrbW3S4MtPv+mU4yUNVUfrBIf/rptQUo2wuq1hdUDR?=
 =?us-ascii?Q?7+znSc5kSPtSCfyx8kbB8WSf?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5478.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76a4af6f-e6a6-4938-1278-08d95716404c
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2021 07:05:32.7348 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gl808h6YlCHT/OS4k7/c5tndEXh4p1fju3ahoCmNTBZZaKNkAw3YJBex8skENgOcVP3FqEyOECYPuXKZxrRmug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5198
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

[AMD Official Use Only]

Merge error, Too big to drop

> -----Original Message-----
> From: Peng Ju Zhou <PengJu.Zhou@amd.com>
> Sent: Wednesday, August 4, 2021 10:15 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Nieto, David M <David.Nieto@amd.com>; Zhou, Peng Ju
> <PengJu.Zhou@amd.com>
> Subject: [PATCH] drm/amdgpu: add done BO list
>=20
> From: David M Nieto <david.nieto@amd.com>
>=20
> backport of "add a list in VM for BOs in the done state"
>=20
> Signed-off-by: David M Nieto <david.nieto@amd.com>
> Signed-off-by: Peng Ju Zhou <PengJu.Zhou@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 1196 +++++++++++-------------
>  1 file changed, 561 insertions(+), 635 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 2a88ed5d983b..ecf7f2039de0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -25,22 +25,16 @@
>   *          Alex Deucher
>   *          Jerome Glisse
>   */
> -
>  #include <linux/dma-fence-array.h>
>  #include <linux/interval_tree_generic.h>
>  #include <linux/idr.h>
> -#include <linux/dma-buf.h>
>=20
>  #include <drm/amdgpu_drm.h>
> -#include <drm/drm_drv.h>
>  #include "amdgpu.h"
>  #include "amdgpu_trace.h"
>  #include "amdgpu_amdkfd.h"
>  #include "amdgpu_gmc.h"
>  #include "amdgpu_xgmi.h"
> -#include "amdgpu_dma_buf.h"
> -#include "amdgpu_res_cursor.h"
> -#include "kfd_svm.h"
>=20
>  /**
>   * DOC: GPUVM
> @@ -89,46 +83,6 @@ struct amdgpu_prt_cb {
>  };
>=20
>  /**
> - * amdgpu_vm_set_pasid - manage pasid and vm ptr mapping
> - *
> - * @adev: amdgpu_device pointer
> - * @vm: amdgpu_vm pointer
> - * @pasid: the pasid the VM is using on this GPU
> - *
> - * Set the pasid this VM is using on this GPU, can also be used to remov=
e the
> - * pasid by passing in zero.
> - *
> - */
> -int amdgpu_vm_set_pasid(struct amdgpu_device *adev, struct amdgpu_vm
> *vm,
> -			u32 pasid)
> -{
> -	int r;
> -
> -	if (vm->pasid =3D=3D pasid)
> -		return 0;
> -
> -	if (vm->pasid) {
> -		r =3D xa_err(xa_erase_irq(&adev->vm_manager.pasids, vm-
> >pasid));
> -		if (r < 0)
> -			return r;
> -
> -		vm->pasid =3D 0;
> -	}
> -
> -	if (pasid) {
> -		r =3D xa_err(xa_store_irq(&adev->vm_manager.pasids, pasid, vm,
> -					GFP_KERNEL));
> -		if (r < 0)
> -			return r;
> -
> -		vm->pasid =3D pasid;
> -	}
> -
> -
> -	return 0;
> -}
> -
> -/*
>   * vm eviction_lock can be taken in MMU notifiers. Make sure no reclaim-=
FS
>   * happens while holding this lock anywhere to prevent deadlocks when
>   * an MMU notifier runs in reclaim-FS context.
> @@ -136,13 +90,13 @@ int amdgpu_vm_set_pasid(struct amdgpu_device
> *adev, struct amdgpu_vm *vm,
>  static inline void amdgpu_vm_eviction_lock(struct amdgpu_vm *vm)
>  {
>  	mutex_lock(&vm->eviction_lock);
> -	vm->saved_flags =3D memalloc_noreclaim_save();
> +	vm->saved_flags =3D memalloc_nofs_save();
>  }
>=20
>  static inline int amdgpu_vm_eviction_trylock(struct amdgpu_vm *vm)
>  {
>  	if (mutex_trylock(&vm->eviction_lock)) {
> -		vm->saved_flags =3D memalloc_noreclaim_save();
> +		vm->saved_flags =3D memalloc_nofs_save();
>  		return 1;
>  	}
>  	return 0;
> @@ -150,7 +104,7 @@ static inline int amdgpu_vm_eviction_trylock(struct
> amdgpu_vm *vm)
>=20
>  static inline void amdgpu_vm_eviction_unlock(struct amdgpu_vm *vm)
>  {
> -	memalloc_noreclaim_restore(vm->saved_flags);
> +	memalloc_nofs_restore(vm->saved_flags);
>  	mutex_unlock(&vm->eviction_lock);
>  }
>=20
> @@ -372,7 +326,7 @@ static void amdgpu_vm_bo_base_init(struct
> amdgpu_vm_bo_base *base,
>  	base->next =3D bo->vm_bo;
>  	bo->vm_bo =3D base;
>=20
> -	if (bo->tbo.base.resv !=3D vm->root.bo->tbo.base.resv)
> +	if (amdkcl_ttm_resvp(&bo->tbo) !=3D amdkcl_ttm_resvp(&vm-
> >root.base.bo->tbo))
>  		return;
>=20
>  	vm->bulk_moveable =3D false;
> @@ -382,7 +336,7 @@ static void amdgpu_vm_bo_base_init(struct
> amdgpu_vm_bo_base *base,
>  		amdgpu_vm_bo_idle(base);
>=20
>  	if (bo->preferred_domains &
> -	    amdgpu_mem_type_to_domain(bo->tbo.resource->mem_type))
> +	    amdgpu_mem_type_to_domain(bo->tbo.mem.mem_type))
>  		return;
>=20
>  	/*
> @@ -401,14 +355,14 @@ static void amdgpu_vm_bo_base_init(struct
> amdgpu_vm_bo_base *base,
>   * Helper to get the parent entry for the child page table. NULL if we a=
re at
>   * the root page directory.
>   */
> -static struct amdgpu_vm_bo_base *amdgpu_vm_pt_parent(struct
> amdgpu_vm_bo_base *pt)
> +static struct amdgpu_vm_pt *amdgpu_vm_pt_parent(struct amdgpu_vm_pt
> *pt)
>  {
> -	struct amdgpu_bo *parent =3D pt->bo->parent;
> +	struct amdgpu_bo *parent =3D pt->base.bo->parent;
>=20
>  	if (!parent)
>  		return NULL;
>=20
> -	return parent->vm_bo;
> +	return container_of(parent->vm_bo, struct amdgpu_vm_pt, base);
>  }
>=20
>  /*
> @@ -416,8 +370,8 @@ static struct amdgpu_vm_bo_base
> *amdgpu_vm_pt_parent(struct amdgpu_vm_bo_base *p
>   */
>  struct amdgpu_vm_pt_cursor {
>  	uint64_t pfn;
> -	struct amdgpu_vm_bo_base *parent;
> -	struct amdgpu_vm_bo_base *entry;
> +	struct amdgpu_vm_pt *parent;
> +	struct amdgpu_vm_pt *entry;
>  	unsigned level;
>  };
>=20
> @@ -456,17 +410,17 @@ static bool amdgpu_vm_pt_descendant(struct
> amdgpu_device *adev,
>  {
>  	unsigned mask, shift, idx;
>=20
> -	if ((cursor->level =3D=3D AMDGPU_VM_PTB) || !cursor->entry ||
> -	    !cursor->entry->bo)
> +	if (!cursor->entry->entries)
>  		return false;
>=20
> +	BUG_ON(!cursor->entry->base.bo);
>  	mask =3D amdgpu_vm_entries_mask(adev, cursor->level);
>  	shift =3D amdgpu_vm_level_shift(adev, cursor->level);
>=20
>  	++cursor->level;
>  	idx =3D (cursor->pfn >> shift) & mask;
>  	cursor->parent =3D cursor->entry;
> -	cursor->entry =3D &to_amdgpu_bo_vm(cursor->entry->bo)->entries[idx];
> +	cursor->entry =3D &cursor->entry->entries[idx];
>  	return true;
>  }
>=20
> @@ -493,7 +447,7 @@ static bool amdgpu_vm_pt_sibling(struct
> amdgpu_device *adev,
>  	shift =3D amdgpu_vm_level_shift(adev, cursor->level - 1);
>  	num_entries =3D amdgpu_vm_num_entries(adev, cursor->level - 1);
>=20
> -	if (cursor->entry =3D=3D &to_amdgpu_bo_vm(cursor->parent->bo)-
> >entries[num_entries - 1])
> +	if (cursor->entry =3D=3D &cursor->parent->entries[num_entries - 1])
>  		return false;
>=20
>  	cursor->pfn +=3D 1ULL << shift;
> @@ -579,7 +533,7 @@ static void amdgpu_vm_pt_first_dfs(struct
> amdgpu_device *adev,
>   * True when the search should continue, false otherwise.
>   */
>  static bool amdgpu_vm_pt_continue_dfs(struct amdgpu_vm_pt_cursor *start,
> -				      struct amdgpu_vm_bo_base *entry)
> +				      struct amdgpu_vm_pt *entry)
>  {
>  	return entry && (!start || entry !=3D start->entry);
>  }
> @@ -630,7 +584,7 @@ void amdgpu_vm_get_pd_bo(struct amdgpu_vm *vm,
>  			 struct amdgpu_bo_list_entry *entry)
>  {
>  	entry->priority =3D 0;
> -	entry->tv.bo =3D &vm->root.bo->tbo;
> +	entry->tv.bo =3D &vm->root.base.bo->tbo;
>  	/* Two for VM updates, one for TTM and one for the CS job */
>  	entry->tv.num_shared =3D 4;
>  	entry->user_pages =3D NULL;
> @@ -653,7 +607,7 @@ void amdgpu_vm_del_from_lru_notify(struct
> ttm_buffer_object *bo)
>  	if (!amdgpu_bo_is_amdgpu_bo(bo))
>  		return;
>=20
> -	if (bo->pin_count)
> +	if (bo->mem.placement & TTM_PL_FLAG_NO_EVICT)
>  		return;
>=20
>  	abo =3D ttm_to_amdgpu_bo(bo);
> @@ -662,7 +616,7 @@ void amdgpu_vm_del_from_lru_notify(struct
> ttm_buffer_object *bo)
>  	for (bo_base =3D abo->vm_bo; bo_base; bo_base =3D bo_base->next) {
>  		struct amdgpu_vm *vm =3D bo_base->vm;
>=20
> -		if (abo->tbo.base.resv =3D=3D vm->root.bo->tbo.base.resv)
> +		if (amdkcl_ttm_resvp(&abo->tbo) =3D=3D amdkcl_ttm_resvp(&vm-
> >root.base.bo->tbo))
>  			vm->bulk_moveable =3D false;
>  	}
>=20
> @@ -682,30 +636,27 @@ void amdgpu_vm_move_to_lru_tail(struct
> amdgpu_device *adev,
>  	struct amdgpu_vm_bo_base *bo_base;
>=20
>  	if (vm->bulk_moveable) {
> -		spin_lock(&adev->mman.bdev.lru_lock);
> +		spin_lock(&ttm_bo_glob.lru_lock);
>  		ttm_bo_bulk_move_lru_tail(&vm->lru_bulk_move);
> -		spin_unlock(&adev->mman.bdev.lru_lock);
> +		spin_unlock(&ttm_bo_glob.lru_lock);
>  		return;
>  	}
>=20
>  	memset(&vm->lru_bulk_move, 0, sizeof(vm->lru_bulk_move));
>=20
> -	spin_lock(&adev->mman.bdev.lru_lock);
> +	spin_lock(&ttm_bo_glob.lru_lock);
>  	list_for_each_entry(bo_base, &vm->idle, vm_status) {
>  		struct amdgpu_bo *bo =3D bo_base->bo;
> -		struct amdgpu_bo *shadow =3D amdgpu_bo_shadowed(bo);
>=20
>  		if (!bo->parent)
>  			continue;
>=20
> -		ttm_bo_move_to_lru_tail(&bo->tbo, bo->tbo.resource,
> -					&vm->lru_bulk_move);
> -		if (shadow)
> -			ttm_bo_move_to_lru_tail(&shadow->tbo,
> -						shadow->tbo.resource,
> +		ttm_bo_move_to_lru_tail(&bo->tbo, &vm->lru_bulk_move);
> +		if (bo->shadow)
> +			ttm_bo_move_to_lru_tail(&bo->shadow->tbo,
>  						&vm->lru_bulk_move);
>  	}
> -	spin_unlock(&adev->mman.bdev.lru_lock);
> +	spin_unlock(&ttm_bo_glob.lru_lock);
>=20
>  	vm->bulk_moveable =3D true;
>  }
> @@ -734,21 +685,15 @@ int amdgpu_vm_validate_pt_bos(struct
> amdgpu_device *adev, struct amdgpu_vm *vm,
>=20
>  	list_for_each_entry_safe(bo_base, tmp, &vm->evicted, vm_status) {
>  		struct amdgpu_bo *bo =3D bo_base->bo;
> -		struct amdgpu_bo *shadow =3D amdgpu_bo_shadowed(bo);
>=20
>  		r =3D validate(param, bo);
>  		if (r)
>  			return r;
> -		if (shadow) {
> -			r =3D validate(param, shadow);
> -			if (r)
> -				return r;
> -		}
>=20
>  		if (bo->tbo.type !=3D ttm_bo_type_kernel) {
>  			amdgpu_vm_bo_moved(bo_base);
>  		} else {
> -			vm->update_funcs-
> >map_table(to_amdgpu_bo_vm(bo));
> +			vm->update_funcs->map_table(bo);
>  			amdgpu_vm_bo_relocated(bo_base);
>  		}
>  	}
> @@ -780,8 +725,8 @@ bool amdgpu_vm_ready(struct amdgpu_vm *vm)
>   *
>   * @adev: amdgpu_device pointer
>   * @vm: VM to clear BO from
> - * @vmbo: BO to clear
> - * @immediate: use an immediate update
> + * @bo: BO to clear
> + * @direct: use a direct update
>   *
>   * Root PD needs to be reserved when calling this.
>   *
> @@ -790,14 +735,13 @@ bool amdgpu_vm_ready(struct amdgpu_vm *vm)
>   */
>  static int amdgpu_vm_clear_bo(struct amdgpu_device *adev,
>  			      struct amdgpu_vm *vm,
> -			      struct amdgpu_bo_vm *vmbo,
> -			      bool immediate)
> +			      struct amdgpu_bo *bo,
> +			      bool direct)
>  {
>  	struct ttm_operation_ctx ctx =3D { true, false };
>  	unsigned level =3D adev->vm_manager.root_level;
>  	struct amdgpu_vm_update_params params;
> -	struct amdgpu_bo *ancestor =3D &vmbo->bo;
> -	struct amdgpu_bo *bo =3D &vmbo->bo;
> +	struct amdgpu_bo *ancestor =3D bo;
>  	unsigned entries, ats_entries;
>  	uint64_t addr;
>  	int r;
> @@ -821,11 +765,11 @@ static int amdgpu_vm_clear_bo(struct
> amdgpu_device *adev,
>  		entries -=3D ats_entries;
>=20
>  	} else {
> -		struct amdgpu_vm_bo_base *pt;
> +		struct amdgpu_vm_pt *pt;
>=20
> -		pt =3D ancestor->vm_bo;
> +		pt =3D container_of(ancestor->vm_bo, struct amdgpu_vm_pt,
> base);
>  		ats_entries =3D amdgpu_vm_num_ats_entries(adev);
> -		if ((pt - to_amdgpu_bo_vm(vm->root.bo)->entries) >=3D
> ats_entries) {
> +		if ((pt - vm->root.entries) >=3D ats_entries) {
>  			ats_entries =3D 0;
>  		} else {
>  			ats_entries =3D entries;
> @@ -837,22 +781,21 @@ static int amdgpu_vm_clear_bo(struct
> amdgpu_device *adev,
>  	if (r)
>  		return r;
>=20
> -	if (vmbo->shadow) {
> -		struct amdgpu_bo *shadow =3D vmbo->shadow;
> -
> -		r =3D ttm_bo_validate(&shadow->tbo, &shadow->placement,
> &ctx);
> +	if (bo->shadow) {
> +		r =3D ttm_bo_validate(&bo->shadow->tbo, &bo->shadow-
> >placement,
> +				    &ctx);
>  		if (r)
>  			return r;
>  	}
>=20
> -	r =3D vm->update_funcs->map_table(vmbo);
> +	r =3D vm->update_funcs->map_table(bo);
>  	if (r)
>  		return r;
>=20
>  	memset(&params, 0, sizeof(params));
>  	params.adev =3D adev;
>  	params.vm =3D vm;
> -	params.immediate =3D immediate;
> +	params.direct =3D direct;
>=20
>  	r =3D vm->update_funcs->prepare(&params, NULL,
> AMDGPU_SYNC_EXPLICIT);
>  	if (r)
> @@ -869,7 +812,7 @@ static int amdgpu_vm_clear_bo(struct amdgpu_device
> *adev,
>  			amdgpu_gmc_get_vm_pde(adev, level, &value,
> &flags);
>  		}
>=20
> -		r =3D vm->update_funcs->update(&params, vmbo, addr, 0,
> ats_entries,
> +		r =3D vm->update_funcs->update(&params, bo, addr, 0,
> ats_entries,
>  					     value, flags);
>  		if (r)
>  			return r;
> @@ -892,7 +835,7 @@ static int amdgpu_vm_clear_bo(struct amdgpu_device
> *adev,
>  			}
>  		}
>=20
> -		r =3D vm->update_funcs->update(&params, vmbo, addr, 0,
> entries,
> +		r =3D vm->update_funcs->update(&params, bo, addr, 0, entries,
>  					     value, flags);
>  		if (r)
>  			return r;
> @@ -902,85 +845,34 @@ static int amdgpu_vm_clear_bo(struct
> amdgpu_device *adev,
>  }
>=20
>  /**
> - * amdgpu_vm_pt_create - create bo for PD/PT
> + * amdgpu_vm_bo_param - fill in parameters for PD/PT allocation
>   *
>   * @adev: amdgpu_device pointer
>   * @vm: requesting vm
>   * @level: the page table level
> - * @immediate: use a immediate update
> - * @vmbo: pointer to the buffer object pointer
> + * @direct: use a direct update
> + * @bp: resulting BO allocation parameters
>   */
> -static int amdgpu_vm_pt_create(struct amdgpu_device *adev,
> -			       struct amdgpu_vm *vm,
> -			       int level, bool immediate,
> -			       struct amdgpu_bo_vm **vmbo)
> +static void amdgpu_vm_bo_param(struct amdgpu_device *adev, struct
> amdgpu_vm *vm,
> +			       int level, bool direct,
> +			       struct amdgpu_bo_param *bp)
>  {
> -	struct amdgpu_bo_param bp;
> -	struct amdgpu_bo *bo;
> -	struct dma_resv *resv;
> -	unsigned int num_entries;
> -	int r;
> -
> -	memset(&bp, 0, sizeof(bp));
> +	memset(bp, 0, sizeof(*bp));
>=20
> -	bp.size =3D amdgpu_vm_bo_size(adev, level);
> -	bp.byte_align =3D AMDGPU_GPU_PAGE_SIZE;
> -	bp.domain =3D AMDGPU_GEM_DOMAIN_VRAM;
> -	bp.domain =3D amdgpu_bo_get_preferred_pin_domain(adev,
> bp.domain);
> -	bp.flags =3D AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS |
> +	bp->size =3D amdgpu_vm_bo_size(adev, level);
> +	bp->byte_align =3D AMDGPU_GPU_PAGE_SIZE;
> +	bp->domain =3D AMDGPU_GEM_DOMAIN_VRAM;
> +	bp->domain =3D amdgpu_bo_get_preferred_pin_domain(adev, bp-
> >domain);
> +	bp->flags =3D AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS |
>  		AMDGPU_GEM_CREATE_CPU_GTT_USWC;
> -
> -	if (level < AMDGPU_VM_PTB)
> -		num_entries =3D amdgpu_vm_num_entries(adev, level);
> -	else
> -		num_entries =3D 0;
> -
> -	bp.bo_ptr_size =3D struct_size((*vmbo), entries, num_entries);
> -
>  	if (vm->use_cpu_for_update)
> -		bp.flags |=3D AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED;
> -
> -	bp.type =3D ttm_bo_type_kernel;
> -	bp.no_wait_gpu =3D immediate;
> -	if (vm->root.bo)
> -		bp.resv =3D vm->root.bo->tbo.base.resv;
> -
> -	r =3D amdgpu_bo_create_vm(adev, &bp, vmbo);
> -	if (r)
> -		return r;
> -
> -	bo =3D &(*vmbo)->bo;
> -	if (vm->is_compute_context || (adev->flags & AMD_IS_APU)) {
> -		(*vmbo)->shadow =3D NULL;
> -		return 0;
> -	}
> -
> -	if (!bp.resv)
> -		WARN_ON(dma_resv_lock(bo->tbo.base.resv,
> -				      NULL));
> -	resv =3D bp.resv;
> -	memset(&bp, 0, sizeof(bp));
> -	bp.size =3D amdgpu_vm_bo_size(adev, level);
> -	bp.domain =3D AMDGPU_GEM_DOMAIN_GTT;
> -	bp.flags =3D AMDGPU_GEM_CREATE_CPU_GTT_USWC;
> -	bp.type =3D ttm_bo_type_kernel;
> -	bp.resv =3D bo->tbo.base.resv;
> -	bp.bo_ptr_size =3D sizeof(struct amdgpu_bo);
> -
> -	r =3D amdgpu_bo_create(adev, &bp, &(*vmbo)->shadow);
> -
> -	if (!resv)
> -		dma_resv_unlock(bo->tbo.base.resv);
> -
> -	if (r) {
> -		amdgpu_bo_unref(&bo);
> -		return r;
> -	}
> -
> -	(*vmbo)->shadow->parent =3D amdgpu_bo_ref(bo);
> -	amdgpu_bo_add_to_shadow_list(*vmbo);
> -
> -	return 0;
> +		bp->flags |=3D AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED;
> +	else if (!vm->root.base.bo || vm->root.base.bo->shadow)
> +		bp->flags |=3D AMDGPU_GEM_CREATE_SHADOW;
> +	bp->type =3D ttm_bo_type_kernel;
> +	bp->no_wait_gpu =3D direct;
> +	if (vm->root.base.bo)
> +		bp->resv =3D amdkcl_ttm_resvp(&vm->root.base.bo->tbo);
>  }
>=20
>  /**
> @@ -989,7 +881,7 @@ static int amdgpu_vm_pt_create(struct amdgpu_device
> *adev,
>   * @adev: amdgpu_device pointer
>   * @vm: VM to allocate page tables for
>   * @cursor: Which page table to allocate
> - * @immediate: use an immediate update
> + * @direct: use a direct update
>   *
>   * Make sure a specific page table or directory is allocated.
>   *
> @@ -1000,27 +892,40 @@ static int amdgpu_vm_pt_create(struct
> amdgpu_device *adev,
>  static int amdgpu_vm_alloc_pts(struct amdgpu_device *adev,
>  			       struct amdgpu_vm *vm,
>  			       struct amdgpu_vm_pt_cursor *cursor,
> -			       bool immediate)
> +			       bool direct)
>  {
> -	struct amdgpu_vm_bo_base *entry =3D cursor->entry;
> -	struct amdgpu_bo *pt_bo;
> -	struct amdgpu_bo_vm *pt;
> +	struct amdgpu_vm_pt *entry =3D cursor->entry;
> +	struct amdgpu_bo_param bp;
> +	struct amdgpu_bo *pt;
>  	int r;
>=20
> -	if (entry->bo)
> +	if (cursor->level < AMDGPU_VM_PTB && !entry->entries) {
> +		unsigned num_entries;
> +
> +		num_entries =3D amdgpu_vm_num_entries(adev, cursor->level);
> +		entry->entries =3D kvmalloc_array(num_entries,
> +						sizeof(*entry->entries),
> +						GFP_KERNEL | __GFP_ZERO);
> +		if (!entry->entries)
> +			return -ENOMEM;
> +	}
> +
> +	if (entry->base.bo)
>  		return 0;
>=20
> -	r =3D amdgpu_vm_pt_create(adev, vm, cursor->level, immediate, &pt);
> +	amdgpu_vm_bo_param(adev, vm, cursor->level, direct, &bp);
> +
> +	r =3D amdgpu_bo_create(adev, &bp, &pt);
>  	if (r)
>  		return r;
>=20
>  	/* Keep a reference to the root directory to avoid
>  	 * freeing them up in the wrong order.
>  	 */
> -	pt_bo =3D &pt->bo;
> -	pt_bo->parent =3D amdgpu_bo_ref(cursor->parent->bo);
> -	amdgpu_vm_bo_base_init(entry, vm, pt_bo);
> -	r =3D amdgpu_vm_clear_bo(adev, vm, pt, immediate);
> +	pt->parent =3D amdgpu_bo_ref(cursor->parent->base.bo);
> +	amdgpu_vm_bo_base_init(&entry->base, vm, pt);
> +
> +	r =3D amdgpu_vm_clear_bo(adev, vm, pt, direct);
>  	if (r)
>  		goto error_free_pt;
>=20
> @@ -1028,7 +933,7 @@ static int amdgpu_vm_alloc_pts(struct
> amdgpu_device *adev,
>=20
>  error_free_pt:
>  	amdgpu_bo_unref(&pt->shadow);
> -	amdgpu_bo_unref(&pt_bo);
> +	amdgpu_bo_unref(&pt);
>  	return r;
>  }
>=20
> @@ -1037,17 +942,16 @@ static int amdgpu_vm_alloc_pts(struct
> amdgpu_device *adev,
>   *
>   * @entry: PDE to free
>   */
> -static void amdgpu_vm_free_table(struct amdgpu_vm_bo_base *entry)
> +static void amdgpu_vm_free_table(struct amdgpu_vm_pt *entry)
>  {
> -	struct amdgpu_bo *shadow;
> -
> -	if (!entry->bo)
> -		return;
> -	shadow =3D amdgpu_bo_shadowed(entry->bo);
> -	entry->bo->vm_bo =3D NULL;
> -	list_del(&entry->vm_status);
> -	amdgpu_bo_unref(&shadow);
> -	amdgpu_bo_unref(&entry->bo);
> +	if (entry->base.bo) {
> +		entry->base.bo->vm_bo =3D NULL;
> +		list_del(&entry->base.vm_status);
> +		amdgpu_bo_unref(&entry->base.bo->shadow);
> +		amdgpu_bo_unref(&entry->base.bo);
> +	}
> +	kvfree(entry->entries);
> +	entry->entries =3D NULL;
>  }
>=20
>  /**
> @@ -1064,7 +968,7 @@ static void amdgpu_vm_free_pts(struct
> amdgpu_device *adev,
>  			       struct amdgpu_vm_pt_cursor *start)
>  {
>  	struct amdgpu_vm_pt_cursor cursor;
> -	struct amdgpu_vm_bo_base *entry;
> +	struct amdgpu_vm_pt *entry;
>=20
>  	vm->bulk_moveable =3D false;
>=20
> @@ -1332,10 +1236,10 @@ uint64_t amdgpu_vm_map_gart(const
> dma_addr_t *pages_addr, uint64_t addr)
>   */
>  static int amdgpu_vm_update_pde(struct amdgpu_vm_update_params
> *params,
>  				struct amdgpu_vm *vm,
> -				struct amdgpu_vm_bo_base *entry)
> +				struct amdgpu_vm_pt *entry)
>  {
> -	struct amdgpu_vm_bo_base *parent =3D amdgpu_vm_pt_parent(entry);
> -	struct amdgpu_bo *bo =3D parent->bo, *pbo;
> +	struct amdgpu_vm_pt *parent =3D amdgpu_vm_pt_parent(entry);
> +	struct amdgpu_bo *bo =3D parent->base.bo, *pbo;
>  	uint64_t pde, pt, flags;
>  	unsigned level;
>=20
> @@ -1343,10 +1247,9 @@ static int amdgpu_vm_update_pde(struct
> amdgpu_vm_update_params *params,
>  		pbo =3D pbo->parent;
>=20
>  	level +=3D params->adev->vm_manager.root_level;
> -	amdgpu_gmc_get_pde_for_bo(entry->bo, level, &pt, &flags);
> -	pde =3D (entry - to_amdgpu_bo_vm(parent->bo)->entries) * 8;
> -	return vm->update_funcs->update(params, to_amdgpu_bo_vm(bo),
> pde, pt,
> -					1, 0, flags);
> +	amdgpu_gmc_get_pde_for_bo(entry->base.bo, level, &pt, &flags);
> +	pde =3D (entry - parent->entries) * 8;
> +	return vm->update_funcs->update(params, bo, pde, pt, 1, 0, flags);
>  }
>=20
>  /**
> @@ -1361,11 +1264,11 @@ static void amdgpu_vm_invalidate_pds(struct
> amdgpu_device *adev,
>  				     struct amdgpu_vm *vm)
>  {
>  	struct amdgpu_vm_pt_cursor cursor;
> -	struct amdgpu_vm_bo_base *entry;
> +	struct amdgpu_vm_pt *entry;
>=20
>  	for_each_amdgpu_vm_pt_dfs_safe(adev, vm, NULL, cursor, entry)
> -		if (entry->bo && !entry->moved)
> -			amdgpu_vm_bo_relocated(entry);
> +		if (entry->base.bo && !entry->base.moved)
> +			amdgpu_vm_bo_relocated(&entry->base);
>  }
>=20
>  /**
> @@ -1373,7 +1276,7 @@ static void amdgpu_vm_invalidate_pds(struct
> amdgpu_device *adev,
>   *
>   * @adev: amdgpu_device pointer
>   * @vm: requested vm
> - * @immediate: submit immediately to the paging queue
> + * @direct: submit directly to the paging queue
>   *
>   * Makes sure all directories are up to date.
>   *
> @@ -1381,7 +1284,7 @@ static void amdgpu_vm_invalidate_pds(struct
> amdgpu_device *adev,
>   * 0 for success, error for failure.
>   */
>  int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
> -			  struct amdgpu_vm *vm, bool immediate)
> +			  struct amdgpu_vm *vm, bool direct)
>  {
>  	struct amdgpu_vm_update_params params;
>  	int r;
> @@ -1392,19 +1295,18 @@ int amdgpu_vm_update_pdes(struct
> amdgpu_device *adev,
>  	memset(&params, 0, sizeof(params));
>  	params.adev =3D adev;
>  	params.vm =3D vm;
> -	params.immediate =3D immediate;
> +	params.direct =3D direct;
>=20
>  	r =3D vm->update_funcs->prepare(&params, NULL,
> AMDGPU_SYNC_EXPLICIT);
>  	if (r)
>  		return r;
>=20
>  	while (!list_empty(&vm->relocated)) {
> -		struct amdgpu_vm_bo_base *entry;
> +		struct amdgpu_vm_pt *entry;
>=20
> -		entry =3D list_first_entry(&vm->relocated,
> -					 struct amdgpu_vm_bo_base,
> -					 vm_status);
> -		amdgpu_vm_bo_idle(entry);
> +		entry =3D list_first_entry(&vm->relocated, struct amdgpu_vm_pt,
> +					 base.vm_status);
> +		amdgpu_vm_bo_idle(&entry->base);
>=20
>  		r =3D amdgpu_vm_update_pde(&params, vm, entry);
>  		if (r)
> @@ -1427,9 +1329,9 @@ int amdgpu_vm_update_pdes(struct amdgpu_device
> *adev,
>   * Make sure to set the right flags for the PTEs at the desired level.
>   */
>  static void amdgpu_vm_update_flags(struct amdgpu_vm_update_params
> *params,
> -				   struct amdgpu_bo_vm *pt, unsigned int
> level,
> +				   struct amdgpu_bo *bo, unsigned level,
>  				   uint64_t pe, uint64_t addr,
> -				   unsigned int count, uint32_t incr,
> +				   unsigned count, uint32_t incr,
>  				   uint64_t flags)
>=20
>  {
> @@ -1445,7 +1347,7 @@ static void amdgpu_vm_update_flags(struct
> amdgpu_vm_update_params *params,
>  		flags |=3D AMDGPU_PTE_EXECUTABLE;
>  	}
>=20
> -	params->vm->update_funcs->update(params, pt, pe, addr, count, incr,
> +	params->vm->update_funcs->update(params, bo, pe, addr, count, incr,
>  					 flags);
>  }
>=20
> @@ -1544,24 +1446,20 @@ static int amdgpu_vm_update_ptes(struct
> amdgpu_vm_update_params *params,
>  		uint64_t incr, entry_end, pe_start;
>  		struct amdgpu_bo *pt;
>=20
> -		if (!params->unlocked) {
> +		if (flags & (AMDGPU_PTE_VALID | AMDGPU_PTE_PRT)) {
>  			/* make sure that the page tables covering the
>  			 * address range are actually allocated
>  			 */
>  			r =3D amdgpu_vm_alloc_pts(params->adev, params->vm,
> -						&cursor, params->immediate);
> +						&cursor, params->direct);
>  			if (r)
>  				return r;
>  		}
>=20
>  		shift =3D amdgpu_vm_level_shift(adev, cursor.level);
>  		parent_shift =3D amdgpu_vm_level_shift(adev, cursor.level - 1);
> -		if (params->unlocked) {
> -			/* Unlocked updates are only allowed on the leaves */
> -			if (amdgpu_vm_pt_descendant(adev, &cursor))
> -				continue;
> -		} else if (adev->asic_type < CHIP_VEGA10 &&
> -			   (flags & AMDGPU_PTE_VALID)) {
> +		if (adev->asic_type < CHIP_VEGA10 &&
> +		    (flags & AMDGPU_PTE_VALID)) {
>  			/* No huge page support before GMC v9 */
>  			if (cursor.level !=3D AMDGPU_VM_PTB) {
>  				if (!amdgpu_vm_pt_descendant(adev,
> &cursor))
> @@ -1584,7 +1482,7 @@ static int amdgpu_vm_update_ptes(struct
> amdgpu_vm_update_params *params,
>  			continue;
>  		}
>=20
> -		pt =3D cursor.entry->bo;
> +		pt =3D cursor.entry->base.bo;
>  		if (!pt) {
>  			/* We need all PDs and PTs for mapping something, */
>  			if (flags & AMDGPU_PTE_VALID)
> @@ -1596,10 +1494,8 @@ static int amdgpu_vm_update_ptes(struct
> amdgpu_vm_update_params *params,
>  			if (!amdgpu_vm_pt_ancestor(&cursor))
>  				return -EINVAL;
>=20
> -			pt =3D cursor.entry->bo;
> +			pt =3D cursor.entry->base.bo;
>  			shift =3D parent_shift;
> -			frag_end =3D max(frag_end, ALIGN(frag_start + 1,
> -				   1ULL << shift));
>  		}
>=20
>  		/* Looks good so far, calculate parameters for the update */
> @@ -1611,26 +1507,19 @@ static int amdgpu_vm_update_ptes(struct
> amdgpu_vm_update_params *params,
>  		entry_end =3D min(entry_end, end);
>=20
>  		do {
> -			struct amdgpu_vm *vm =3D params->vm;
>  			uint64_t upd_end =3D min(entry_end, frag_end);
>  			unsigned nptes =3D (upd_end - frag_start) >> shift;
> -			uint64_t upd_flags =3D flags | AMDGPU_PTE_FRAG(frag);
>=20
>  			/* This can happen when we set higher level PDs to
>  			 * silent to stop fault floods.
>  			 */
>  			nptes =3D max(nptes, 1u);
> -
> -			trace_amdgpu_vm_update_ptes(params, frag_start,
> upd_end,
> -						    nptes, dst, incr, upd_flags,
> -						    vm->task_info.pid,
> -						    vm-
> >immediate.fence_context);
> -			amdgpu_vm_update_flags(params,
> to_amdgpu_bo_vm(pt),
> -					       cursor.level, pe_start, dst,
> -					       nptes, incr, upd_flags);
> +			amdgpu_vm_update_flags(params, pt, cursor.level,
> +					       pe_start, dst, nptes, incr,
> +					       flags | AMDGPU_PTE_FRAG(frag));
>=20
>  			pe_start +=3D nptes * 8;
> -			dst +=3D nptes * incr;
> +			dst +=3D (uint64_t)nptes * AMDGPU_GPU_PAGE_SIZE <<
> shift;
>=20
>  			frag_start =3D upd_end;
>  			if (frag_start >=3D frag_end) {
> @@ -1650,11 +1539,7 @@ static int amdgpu_vm_update_ptes(struct
> amdgpu_vm_update_params *params,
>  			 * completely covered by the range and so potentially
> still in use.
>  			 */
>  			while (cursor.pfn < frag_start) {
> -				/* Make sure previous mapping is freed */
> -				if (cursor.entry->bo) {
> -					params->table_freed =3D true;
> -					amdgpu_vm_free_pts(adev, params-
> >vm, &cursor);
> -				}
> +				amdgpu_vm_free_pts(adev, params->vm,
> &cursor);
>  				amdgpu_vm_pt_next(adev, &cursor);
>  			}
>=20
> @@ -1670,51 +1555,39 @@ static int amdgpu_vm_update_ptes(struct
> amdgpu_vm_update_params *params,
>  /**
>   * amdgpu_vm_bo_update_mapping - update a mapping in the vm page table
>   *
> - * @adev: amdgpu_device pointer of the VM
> - * @bo_adev: amdgpu_device pointer of the mapped BO
> + * @adev: amdgpu_device pointer
>   * @vm: requested vm
> - * @immediate: immediate submission in a page fault
> - * @unlocked: unlocked invalidation during MM callback
> + * @direct: direct submission in a page fault
>   * @resv: fences we need to sync to
>   * @start: start of mapped range
>   * @last: last mapped entry
>   * @flags: flags for the entries
> - * @offset: offset into nodes and pages_addr
> - * @res: ttm_resource to map
> + * @addr: addr to set the area to
>   * @pages_addr: DMA addresses to use for mapping
>   * @fence: optional resulting fence
> - * @table_freed: return true if page table is freed
>   *
>   * Fill in the page table entries between @start and @last.
>   *
>   * Returns:
>   * 0 for success, -EINVAL for failure.
>   */
> -int amdgpu_vm_bo_update_mapping(struct amdgpu_device *adev,
> -				struct amdgpu_device *bo_adev,
> -				struct amdgpu_vm *vm, bool immediate,
> -				bool unlocked, struct dma_resv *resv,
> -				uint64_t start, uint64_t last,
> -				uint64_t flags, uint64_t offset,
> -				struct ttm_resource *res,
> -				dma_addr_t *pages_addr,
> -				struct dma_fence **fence,
> -				bool *table_freed)
> +static int amdgpu_vm_bo_update_mapping(struct amdgpu_device *adev,
> +				       struct amdgpu_vm *vm, bool direct,
> +				       struct dma_resv *resv,
> +				       uint64_t start, uint64_t last,
> +				       uint64_t flags, uint64_t addr,
> +				       dma_addr_t *pages_addr,
> +				       struct dma_fence **fence)
>  {
>  	struct amdgpu_vm_update_params params;
> -	struct amdgpu_res_cursor cursor;
>  	enum amdgpu_sync_mode sync_mode;
> -	int r, idx;
> -
> -	if (!drm_dev_enter(&adev->ddev, &idx))
> -		return -ENODEV;
> +	int r;
>=20
>  	memset(&params, 0, sizeof(params));
>  	params.adev =3D adev;
>  	params.vm =3D vm;
> -	params.immediate =3D immediate;
> +	params.direct =3D direct;
>  	params.pages_addr =3D pages_addr;
> -	params.unlocked =3D unlocked;
>=20
>  	/* Implicitly sync to command submissions in the same VM before
>  	 * unmapping. Sync to moving fences before mapping.
> @@ -1730,133 +1603,178 @@ int amdgpu_vm_bo_update_mapping(struct
> amdgpu_device *adev,
>  		goto error_unlock;
>  	}
>=20
> -	if (!unlocked && !dma_fence_is_signaled(vm->last_unlocked)) {
> -		struct dma_fence *tmp =3D dma_fence_get_stub();
> +	if (flags & (AMDGPU_PTE_VALID | AMDGPU_PTE_PRT)) {
> +		struct amdgpu_bo *root =3D vm->root.base.bo;
>=20
> -		amdgpu_bo_fence(vm->root.bo, vm->last_unlocked, true);
> -		swap(vm->last_unlocked, tmp);
> -		dma_fence_put(tmp);
> +		if (!dma_fence_is_signaled(vm->last_direct))
> +			amdgpu_bo_fence(root, vm->last_direct, true);
>  	}
>=20
>  	r =3D vm->update_funcs->prepare(&params, resv, sync_mode);
>  	if (r)
>  		goto error_unlock;
>=20
> -	amdgpu_res_first(pages_addr ? NULL : res, offset,
> -			 (last - start + 1) * AMDGPU_GPU_PAGE_SIZE, &cursor);
> -	while (cursor.remaining) {
> -		uint64_t tmp, num_entries, addr;
> +	r =3D amdgpu_vm_update_ptes(&params, start, last + 1, addr, flags);
> +	if (r)
> +		goto error_unlock;
> +
> +	r =3D vm->update_funcs->commit(&params, fence);
> +
> +error_unlock:
> +	amdgpu_vm_eviction_unlock(vm);
> +	return r;
> +}
>=20
> -		num_entries =3D cursor.size >> AMDGPU_GPU_PAGE_SHIFT;
> -		if (pages_addr) {
> -			bool contiguous =3D true;
> +/**
> + * amdgpu_vm_bo_split_mapping - split a mapping into smaller chunks
> + *
> + * @adev: amdgpu_device pointer
> + * @resv: fences we need to sync to
> + * @pages_addr: DMA addresses to use for mapping
> + * @vm: requested vm
> + * @mapping: mapped range and flags to use for the update
> + * @flags: HW flags for the mapping
> + * @bo_adev: amdgpu_device pointer that bo actually been allocated
> + * @nodes: array of drm_mm_nodes with the MC addresses
> + * @fence: optional resulting fence
> + *
> + * Split the mapping into smaller chunks so that each update fits
> + * into a SDMA IB.
> + *
> + * Returns:
> + * 0 for success, -EINVAL for failure.
> + */
> +static int amdgpu_vm_bo_split_mapping(struct amdgpu_device *adev,
> +				      struct dma_resv *resv,
> +				      dma_addr_t *pages_addr,
> +				      struct amdgpu_vm *vm,
> +				      struct amdgpu_bo_va_mapping *mapping,
> +				      uint64_t flags,
> +				      struct amdgpu_device *bo_adev,
> +				      struct ttm_mem_reg *mem,
> +				      struct dma_fence **fence)
> +{
> +	struct drm_mm_node *nodes =3D mem ? mem->mm_node : NULL;
> +	uint64_t vram_base_offset =3D bo_adev-
> >vm_manager.vram_base_offset;
> +	unsigned min_linear_pages =3D 1 << adev->vm_manager.fragment_size;
> +	uint64_t pfn, start =3D mapping->start;
> +	int r;
>=20
> -			if (num_entries >
> AMDGPU_GPU_PAGES_IN_CPU_PAGE) {
> -				uint64_t pfn =3D cursor.start >> PAGE_SHIFT;
> -				uint64_t count;
> +	/* normally,bo_va->flags only contians READABLE and WIRTEABLE bit
> go here
> +	 * but in case of something, we filter the flags in first place
> +	 */
> +	if (!(mapping->flags & AMDGPU_PTE_READABLE))
> +		flags &=3D ~AMDGPU_PTE_READABLE;
> +	if (!(mapping->flags & AMDGPU_PTE_WRITEABLE))
> +		flags &=3D ~AMDGPU_PTE_WRITEABLE;
> +
> +	/* Apply ASIC specific mapping flags */
> +	amdgpu_gmc_get_vm_pte(adev, mapping, &flags);
> +
> +	if (adev !=3D bo_adev &&
> +	    !(flags & AMDGPU_PTE_SYSTEM) &&
> +	    !mapping->bo_va->is_xgmi) {
> +		if (amdgpu_device_is_peer_accessible(bo_adev, adev)) {
> +			flags |=3D AMDGPU_PTE_SYSTEM;
> +			vram_base_offset =3D bo_adev->gmc.aper_base;
> +		} else {
> +			DRM_DEBUG_DRIVER("Failed to map the VRAM for
> peer device access.\n");
> +			return -EINVAL;
> +		}
> +	}
>=20
> -				contiguous =3D pages_addr[pfn + 1] =3D=3D
> -					pages_addr[pfn] + PAGE_SIZE;
> +	trace_amdgpu_vm_bo_update(mapping);
>=20
> -				tmp =3D num_entries /
> -					AMDGPU_GPU_PAGES_IN_CPU_PAGE;
> -				for (count =3D 2; count < tmp; ++count) {
> -					uint64_t idx =3D pfn + count;
> +	pfn =3D mapping->offset >> PAGE_SHIFT;
> +	if (nodes) {
> +		while (pfn >=3D nodes->size) {
> +			pfn -=3D nodes->size;
> +			++nodes;
> +		}
> +	}
>=20
> -					if (contiguous !=3D (pages_addr[idx] =3D=3D
> -					    pages_addr[idx - 1] + PAGE_SIZE))
> +	do {
> +		dma_addr_t *dma_addr =3D NULL;
> +		uint64_t max_entries;
> +		uint64_t addr, last;
> +		uint64_t count;
> +
> +		if (nodes) {
> +			addr =3D nodes->start << PAGE_SHIFT;
> +			max_entries =3D (nodes->size - pfn) *
> +				AMDGPU_GPU_PAGES_IN_CPU_PAGE;
> +
> +			switch (mem->mem_type) {
> +			case TTM_PL_TT:
> +				if (pages_addr) {
> +					for (count =3D 1;
> +						 count < max_entries /
> AMDGPU_GPU_PAGES_IN_CPU_PAGE;
> +						 ++count){
> +						uint64_t idx =3D pfn + count;
> +						if (pages_addr[idx] !=3D
> +							(pages_addr[idx - 1] +
> PAGE_SIZE))
>  						break;
> +						}
> +					if (count < min_linear_pages) {
> +						addr =3D pfn << PAGE_SHIFT;
> +						dma_addr =3D pages_addr;
> +					} else {
> +						addr =3D pages_addr[pfn];
> +						max_entries =3D count;
> +					}
> +				} else if (flags & (AMDGPU_PTE_VALID |
> AMDGPU_PTE_PRT)) {
> +					addr +=3D vram_base_offset;
> +					addr +=3D pfn << PAGE_SHIFT;
>  				}
> -				num_entries =3D count *
> -					AMDGPU_GPU_PAGES_IN_CPU_PAGE;
> -			}
> -
> -			if (!contiguous) {
> -				addr =3D cursor.start;
> -				params.pages_addr =3D pages_addr;
> -			} else {
> -				addr =3D pages_addr[cursor.start >>
> PAGE_SHIFT];
> -				params.pages_addr =3D NULL;
> +				break;
> +			case AMDGPU_PL_DGMA_IMPORT:
> +			case AMDGPU_PL_DGMA_PEER:
> +				addr =3D 0;
> +				dma_addr =3D pages_addr;
> +				break;
> +			case AMDGPU_PL_DGMA:
> +				addr +=3D vram_base_offset +
> +					adev->mman.bdev.man[mem-
> >mem_type].gpu_offset -
> +					adev-
> >mman.bdev.man[TTM_PL_VRAM].gpu_offset;
> +				addr +=3D pfn << PAGE_SHIFT;
> +				break;
> +			case TTM_PL_VRAM:
> +				addr +=3D vram_base_offset;
> +				addr +=3D pfn << PAGE_SHIFT;
> +				break;
> +			default:
> +				break;
>  			}
> -
> -		} else if (flags & (AMDGPU_PTE_VALID | AMDGPU_PTE_PRT)) {
> -			addr =3D bo_adev->vm_manager.vram_base_offset +
> -				cursor.start;
>  		} else {
>  			addr =3D 0;
> +			max_entries =3D S64_MAX;
>  		}
>=20
> -		tmp =3D start + num_entries;
> -		r =3D amdgpu_vm_update_ptes(&params, start, tmp, addr, flags);
> +		last =3D min((uint64_t)mapping->last, start + max_entries - 1);
> +		r =3D amdgpu_vm_bo_update_mapping(adev, vm, false, resv,
> +						start, last, flags, addr,
> +						dma_addr, fence);
>  		if (r)
> -			goto error_unlock;
> -
> -		amdgpu_res_next(&cursor, num_entries *
> AMDGPU_GPU_PAGE_SIZE);
> -		start =3D tmp;
> -	}
> +			return r;
>=20
> -	r =3D vm->update_funcs->commit(&params, fence);
> +		pfn +=3D (last - start + 1) / AMDGPU_GPU_PAGES_IN_CPU_PAGE;
> +		if (nodes && nodes->size =3D=3D pfn) {
> +			pfn =3D 0;
> +			++nodes;
> +		}
> +		start =3D last + 1;
>=20
> -	if (table_freed)
> -		*table_freed =3D *table_freed || params.table_freed;
> +	} while (unlikely(start !=3D mapping->last + 1));
>=20
> -error_unlock:
> -	amdgpu_vm_eviction_unlock(vm);
> -	drm_dev_exit(idx);
> -	return r;
> +	return 0;
>  }
>=20
> -void amdgpu_vm_get_memory(struct amdgpu_vm *vm, uint64_t
> *vram_mem,
> -				uint64_t *gtt_mem, uint64_t *cpu_mem)
> -{
> -	struct amdgpu_bo_va *bo_va, *tmp;
> -
> -	list_for_each_entry_safe(bo_va, tmp, &vm->idle, base.vm_status) {
> -		if (!bo_va->base.bo)
> -			continue;
> -		amdgpu_bo_get_memory(bo_va->base.bo, vram_mem,
> -				gtt_mem, cpu_mem);
> -	}
> -	list_for_each_entry_safe(bo_va, tmp, &vm->evicted, base.vm_status) {
> -		if (!bo_va->base.bo)
> -			continue;
> -		amdgpu_bo_get_memory(bo_va->base.bo, vram_mem,
> -				gtt_mem, cpu_mem);
> -	}
> -	list_for_each_entry_safe(bo_va, tmp, &vm->relocated, base.vm_status)
> {
> -		if (!bo_va->base.bo)
> -			continue;
> -		amdgpu_bo_get_memory(bo_va->base.bo, vram_mem,
> -				gtt_mem, cpu_mem);
> -	}
> -	list_for_each_entry_safe(bo_va, tmp, &vm->moved, base.vm_status) {
> -		if (!bo_va->base.bo)
> -			continue;
> -		amdgpu_bo_get_memory(bo_va->base.bo, vram_mem,
> -				gtt_mem, cpu_mem);
> -	}
> -	spin_lock(&vm->invalidated_lock);
> -	list_for_each_entry_safe(bo_va, tmp, &vm->invalidated,
> base.vm_status) {
> -		if (!bo_va->base.bo)
> -			continue;
> -		amdgpu_bo_get_memory(bo_va->base.bo, vram_mem,
> -				gtt_mem, cpu_mem);
> -	}
> -	list_for_each_entry_safe(bo_va, tmp, &vm->done, base.vm_status) {
> -		if (!bo_va->base.bo)
> -			continue;
> -		amdgpu_bo_get_memory(bo_va->base.bo, vram_mem,
> -				gtt_mem, cpu_mem);
> -	}
> -	spin_unlock(&vm->invalidated_lock);
> -}
>  /**
>   * amdgpu_vm_bo_update - update all BO mappings in the vm page table
>   *
>   * @adev: amdgpu_device pointer
>   * @bo_va: requested BO and VM object
>   * @clear: if true clear the entries
> - * @table_freed: return true if page table is freed
>   *
>   * Fill in the page table entries for @bo_va.
>   *
> @@ -1864,13 +1782,14 @@ void amdgpu_vm_get_memory(struct
> amdgpu_vm *vm, uint64_t *vram_mem,
>   * 0 for success, -EINVAL for failure.
>   */
>  int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct
> amdgpu_bo_va *bo_va,
> -			bool clear, bool *table_freed)
> +			bool clear)
>  {
>  	struct amdgpu_bo *bo =3D bo_va->base.bo;
>  	struct amdgpu_vm *vm =3D bo_va->base.vm;
>  	struct amdgpu_bo_va_mapping *mapping;
>  	dma_addr_t *pages_addr =3D NULL;
> -	struct ttm_resource *mem;
> +	struct ttm_mem_reg *mem;
> +	struct drm_mm_node *nodes;
>  	struct dma_fence **last_update;
>  	struct dma_resv *resv;
>  	uint64_t flags;
> @@ -1879,23 +1798,21 @@ int amdgpu_vm_bo_update(struct
> amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
>=20
>  	if (clear || !bo) {
>  		mem =3D NULL;
> -		resv =3D vm->root.bo->tbo.base.resv;
> +		nodes =3D NULL;
> +		resv =3D amdkcl_ttm_resvp(&vm->root.base.bo->tbo);
>  	} else {
> -		struct drm_gem_object *obj =3D &bo->tbo.base;
> -
> -		resv =3D bo->tbo.base.resv;
> -		if (obj->import_attach && bo_va->is_xgmi) {
> -			struct dma_buf *dma_buf =3D obj->import_attach-
> >dmabuf;
> -			struct drm_gem_object *gobj =3D dma_buf->priv;
> -			struct amdgpu_bo *abo =3D gem_to_amdgpu_bo(gobj);
> -
> -			if (abo->tbo.resource->mem_type =3D=3D TTM_PL_VRAM)
> -				bo =3D gem_to_amdgpu_bo(gobj);
> +		struct ttm_dma_tt *ttm;
> +
> +		mem =3D &bo->tbo.mem;
> +		nodes =3D mem->mm_node;
> +		if (mem->mem_type =3D=3D TTM_PL_TT) {
> +			ttm =3D container_of(bo->tbo.ttm, struct ttm_dma_tt,
> ttm);
> +			pages_addr =3D ttm->dma_address;
> +		} else if (mem->mem_type =3D=3D AMDGPU_PL_DGMA_IMPORT ||
> +			   mem->mem_type =3D=3D AMDGPU_PL_DGMA_PEER) {
> +			pages_addr =3D (dma_addr_t *)bo_va->base.bo-
> >tbo.mem.bus.addr;
>  		}
> -		mem =3D bo->tbo.resource;
> -		if (mem->mem_type =3D=3D TTM_PL_TT ||
> -		    mem->mem_type =3D=3D AMDGPU_PL_PREEMPT)
> -			pages_addr =3D bo->tbo.ttm->dma_address;
> +		resv =3D amdkcl_ttm_resvp(&bo->tbo);
>  	}
>=20
>  	if (bo) {
> @@ -1909,8 +1826,7 @@ int amdgpu_vm_bo_update(struct amdgpu_device
> *adev, struct amdgpu_bo_va *bo_va,
>  		flags =3D 0x0;
>  	}
>=20
> -	if (clear || (bo && bo->tbo.base.resv =3D=3D
> -		      vm->root.bo->tbo.base.resv))
> +	if (clear || (bo && amdkcl_ttm_resvp(&bo->tbo) =3D=3D
> amdkcl_ttm_resvp(&vm->root.base.bo->tbo)))
>  		last_update =3D &vm->last_update;
>  	else
>  		last_update =3D &bo_va->last_pt_update;
> @@ -1924,26 +1840,9 @@ int amdgpu_vm_bo_update(struct amdgpu_device
> *adev, struct amdgpu_bo_va *bo_va,
>  	}
>=20
>  	list_for_each_entry(mapping, &bo_va->invalids, list) {
> -		uint64_t update_flags =3D flags;
> -
> -		/* normally,bo_va->flags only contians READABLE and
> WIRTEABLE bit go here
> -		 * but in case of something, we filter the flags in first place
> -		 */
> -		if (!(mapping->flags & AMDGPU_PTE_READABLE))
> -			update_flags &=3D ~AMDGPU_PTE_READABLE;
> -		if (!(mapping->flags & AMDGPU_PTE_WRITEABLE))
> -			update_flags &=3D ~AMDGPU_PTE_WRITEABLE;
> -
> -		/* Apply ASIC specific mapping flags */
> -		amdgpu_gmc_get_vm_pte(adev, mapping, &update_flags);
> -
> -		trace_amdgpu_vm_bo_update(mapping);
> -
> -		r =3D amdgpu_vm_bo_update_mapping(adev, bo_adev, vm,
> false, false,
> -						resv, mapping->start,
> -						mapping->last, update_flags,
> -						mapping->offset, mem,
> -						pages_addr, last_update,
> table_freed);
> +		r =3D amdgpu_vm_bo_split_mapping(adev, resv, pages_addr, vm,
> +					       mapping, flags, bo_adev,
> +					       mem, last_update);
>  		if (r)
>  			return r;
>  	}
> @@ -1952,8 +1851,8 @@ int amdgpu_vm_bo_update(struct amdgpu_device
> *adev, struct amdgpu_bo_va *bo_va,
>  	 * the evicted list so that it gets validated again on the
>  	 * next command submission.
>  	 */
> -	if (bo && bo->tbo.base.resv =3D=3D vm->root.bo->tbo.base.resv) {
> -		uint32_t mem_type =3D bo->tbo.resource->mem_type;
> +	if (bo && amdkcl_ttm_resvp(&bo->tbo) =3D=3D amdkcl_ttm_resvp(&vm-
> >root.base.bo->tbo)) {
> +		uint32_t mem_type =3D bo->tbo.mem.mem_type;
>=20
>  		if (!(bo->preferred_domains &
>  		      amdgpu_mem_type_to_domain(mem_type)))
> @@ -2089,17 +1988,18 @@ static void amdgpu_vm_free_mapping(struct
> amdgpu_device *adev,
>   */
>  static void amdgpu_vm_prt_fini(struct amdgpu_device *adev, struct
> amdgpu_vm *vm)
>  {
> -	struct dma_resv *resv =3D vm->root.bo->tbo.base.resv;
> +	struct dma_resv *resv =3D amdkcl_ttm_resvp(&vm->root.base.bo->tbo);
>  	struct dma_fence *excl, **shared;
>  	unsigned i, shared_count;
>  	int r;
>=20
> -	r =3D dma_resv_get_fences(resv, &excl, &shared_count, &shared);
> +	r =3D dma_resv_get_fences_rcu(resv, &excl,
> +					      &shared_count, &shared);
>  	if (r) {
>  		/* Not enough memory to grab the fence list, as last resort
>  		 * block for all the fences to complete.
>  		 */
> -		dma_resv_wait_timeout(resv, true, false,
> +		dma_resv_wait_timeout_rcu(resv, true, false,
>  						    MAX_SCHEDULE_TIMEOUT);
>  		return;
>  	}
> @@ -2135,7 +2035,7 @@ int amdgpu_vm_clear_freed(struct amdgpu_device
> *adev,
>  			  struct amdgpu_vm *vm,
>  			  struct dma_fence **fence)
>  {
> -	struct dma_resv *resv =3D vm->root.bo->tbo.base.resv;
> +	struct dma_resv *resv =3D amdkcl_ttm_resvp(&vm->root.base.bo->tbo);
>  	struct amdgpu_bo_va_mapping *mapping;
>  	uint64_t init_pte_value =3D 0;
>  	struct dma_fence *f =3D NULL;
> @@ -2150,10 +2050,9 @@ int amdgpu_vm_clear_freed(struct amdgpu_device
> *adev,
>  		    mapping->start < AMDGPU_GMC_HOLE_START)
>  			init_pte_value =3D AMDGPU_PTE_DEFAULT_ATC;
>=20
> -		r =3D amdgpu_vm_bo_update_mapping(adev, adev, vm, false,
> false,
> -						resv, mapping->start,
> -						mapping->last, init_pte_value,
> -						0, NULL, NULL, &f, NULL);
> +		r =3D amdgpu_vm_bo_update_mapping(adev, vm, false, resv,
> +						mapping->start, mapping-
> >last,
> +						init_pte_value, 0, NULL, &f);
>  		amdgpu_vm_free_mapping(adev, vm, mapping, f);
>  		if (r) {
>  			dma_fence_put(f);
> @@ -2172,6 +2071,58 @@ int amdgpu_vm_clear_freed(struct amdgpu_device
> *adev,
>=20
>  }
>=20
> +void amdgpu_vm_get_memory(struct amdgpu_vm *vm, uint64_t
> *vram_mem,
> +				uint64_t *gtt_mem, uint64_t *cpu_mem)
> +{
> +	struct amdgpu_bo_va *bo_va, *tmp;
> +
> +	list_for_each_entry_safe(bo_va, tmp, &vm->idle, base.vm_status) {
> +		if (!bo_va->base.bo)
> +			continue;
> +		amdgpu_bo_get_memory(bo_va->base.bo, vram_mem,
> +					gtt_mem, cpu_mem);
> +	}
> +	list_for_each_entry_safe(bo_va, tmp, &vm->evicted, base.vm_status) {
> +		if (!bo_va->base.bo)
> +			continue;
> +		amdgpu_bo_get_memory(bo_va->base.bo, vram_mem,
> +					gtt_mem, cpu_mem);
> +	}
> +	list_for_each_entry_safe(bo_va, tmp, &vm->relocated, base.vm_status)
> {
> +		if (!bo_va->base.bo)
> +			continue;
> +		amdgpu_bo_get_memory(bo_va->base.bo, vram_mem,
> +					gtt_mem, cpu_mem);
> +	}
> +	list_for_each_entry_safe(bo_va, tmp, &vm->moved, base.vm_status) {
> +		if (!bo_va->base.bo)
> +			continue;
> +		amdgpu_bo_get_memory(bo_va->base.bo, vram_mem,
> +					gtt_mem, cpu_mem);
> +	}
> +	spin_lock(&vm->invalidated_lock);
> +	list_for_each_entry_safe(bo_va, tmp, &vm->invalidated,
> base.vm_status) {
> +		if (!bo_va->base.bo)
> +			continue;
> +		amdgpu_bo_get_memory(bo_va->base.bo, vram_mem,
> +					gtt_mem, cpu_mem);
> +	}
> +	list_for_each_entry_safe(bo_va, tmp, &vm->freed, base.vm_status) {
> +		if (!bo_va->base.bo)
> +			continue;
> +		amdgpu_bo_get_memory(bo_va->base.bo, vram_mem,
> +					gtt_mem, cpu_mem);
> +	}
> +	spin_unlock(&vm->invalidated_lock);
> +
> +	list_for_each_entry_safe(bo_va, tmp, &vm->done, base.vm_status) {
> +		if (!bo_va->base.bo)
> +			continue;
> +		amdgpu_bo_get_memory(bo_va->base.bo, vram_mem,
> +					gtt_mem, cpu_mem);
> +	}
> +}
> +
>  /**
>   * amdgpu_vm_handle_moved - handle moved BOs in the PT
>   *
> @@ -2195,7 +2146,7 @@ int amdgpu_vm_handle_moved(struct
> amdgpu_device *adev,
>=20
>  	list_for_each_entry_safe(bo_va, tmp, &vm->moved, base.vm_status) {
>  		/* Per VM BOs never need to bo cleared in the page tables */
> -		r =3D amdgpu_vm_bo_update(adev, bo_va, false, NULL);
> +		r =3D amdgpu_vm_bo_update(adev, bo_va, false);
>  		if (r)
>  			return r;
>  	}
> @@ -2204,7 +2155,7 @@ int amdgpu_vm_handle_moved(struct
> amdgpu_device *adev,
>  	while (!list_empty(&vm->invalidated)) {
>  		bo_va =3D list_first_entry(&vm->invalidated, struct
> amdgpu_bo_va,
>  					 base.vm_status);
> -		resv =3D bo_va->base.bo->tbo.base.resv;
> +		resv =3D amdkcl_ttm_resvp(&bo_va->base.bo->tbo);
>  		spin_unlock(&vm->invalidated_lock);
>=20
>  		/* Try to reserve the BO to avoid clearing its ptes */
> @@ -2214,7 +2165,7 @@ int amdgpu_vm_handle_moved(struct
> amdgpu_device *adev,
>  		else
>  			clear =3D true;
>=20
> -		r =3D amdgpu_vm_bo_update(adev, bo_va, clear, NULL);
> +		r =3D amdgpu_vm_bo_update(adev, bo_va, clear);
>  		if (r)
>  			return r;
>=20
> @@ -2258,13 +2209,14 @@ struct amdgpu_bo_va
> *amdgpu_vm_bo_add(struct amdgpu_device *adev,
>  	INIT_LIST_HEAD(&bo_va->valids);
>  	INIT_LIST_HEAD(&bo_va->invalids);
>=20
> -	if (!bo)
> -		return bo_va;
> -
> -	if (amdgpu_dmabuf_is_xgmi_accessible(adev, bo)) {
> +	if (bo && amdgpu_xgmi_same_hive(adev, amdgpu_ttm_adev(bo-
> >tbo.bdev)) &&
> +	    (bo->preferred_domains & AMDGPU_GEM_DOMAIN_VRAM)) {
>  		bo_va->is_xgmi =3D true;
> +		mutex_lock(&adev->vm_manager.lock_pstate);
>  		/* Power up XGMI if it can be potentially used */
> -		amdgpu_xgmi_set_pstate(adev,
> AMDGPU_XGMI_PSTATE_MAX_VEGA20);
> +		if (++adev->vm_manager.xgmi_map_counter =3D=3D 1)
> +			amdgpu_xgmi_set_pstate(adev, 1);
> +		mutex_unlock(&adev->vm_manager.lock_pstate);
>  	}
>=20
>  	return bo_va;
> @@ -2272,7 +2224,7 @@ struct amdgpu_bo_va *amdgpu_vm_bo_add(struct
> amdgpu_device *adev,
>=20
>=20
>  /**
> - * amdgpu_vm_bo_insert_map - insert a new mapping
> + * amdgpu_vm_bo_insert_mapping - insert a new mapping
>   *
>   * @adev: amdgpu_device pointer
>   * @bo_va: bo_va to store the address
> @@ -2294,7 +2246,7 @@ static void amdgpu_vm_bo_insert_map(struct
> amdgpu_device *adev,
>  	if (mapping->flags & AMDGPU_PTE_PRT)
>  		amdgpu_vm_prt_get(adev);
>=20
> -	if (bo && bo->tbo.base.resv =3D=3D vm->root.bo->tbo.base.resv &&
> +	if (bo && amdkcl_ttm_resvp(&bo->tbo) =3D=3D amdkcl_ttm_resvp(&vm-
> >root.base.bo->tbo) &&
>  	    !bo_va->base.moved) {
>  		list_move(&bo_va->base.vm_status, &vm->moved);
>  	}
> @@ -2329,15 +2281,14 @@ int amdgpu_vm_bo_map(struct amdgpu_device
> *adev,
>  	uint64_t eaddr;
>=20
>  	/* validate the parameters */
> -	if (saddr & ~PAGE_MASK || offset & ~PAGE_MASK ||
> -	    size =3D=3D 0 || size & ~PAGE_MASK)
> +	if (saddr & AMDGPU_GPU_PAGE_MASK || offset &
> AMDGPU_GPU_PAGE_MASK ||
> +	    size =3D=3D 0 || size & AMDGPU_GPU_PAGE_MASK)
>  		return -EINVAL;
>=20
>  	/* make sure object fit at this offset */
>  	eaddr =3D saddr + size - 1;
>  	if (saddr >=3D eaddr ||
> -	    (bo && offset + size > amdgpu_bo_size(bo)) ||
> -	    (eaddr >=3D adev->vm_manager.max_pfn <<
> AMDGPU_GPU_PAGE_SHIFT))
> +	    (bo && offset + size > amdgpu_bo_size(bo)))
>  		return -EINVAL;
>=20
>  	saddr /=3D AMDGPU_GPU_PAGE_SIZE;
> @@ -2395,15 +2346,14 @@ int amdgpu_vm_bo_replace_map(struct
> amdgpu_device *adev,
>  	int r;
>=20
>  	/* validate the parameters */
> -	if (saddr & ~PAGE_MASK || offset & ~PAGE_MASK ||
> -	    size =3D=3D 0 || size & ~PAGE_MASK)
> +	if (saddr & AMDGPU_GPU_PAGE_MASK || offset &
> AMDGPU_GPU_PAGE_MASK ||
> +	    size =3D=3D 0 || size & AMDGPU_GPU_PAGE_MASK)
>  		return -EINVAL;
>=20
>  	/* make sure object fit at this offset */
>  	eaddr =3D saddr + size - 1;
>  	if (saddr >=3D eaddr ||
> -	    (bo && offset + size > amdgpu_bo_size(bo)) ||
> -	    (eaddr >=3D adev->vm_manager.max_pfn <<
> AMDGPU_GPU_PAGE_SHIFT))
> +	    (bo && offset + size > amdgpu_bo_size(bo)))
>  		return -EINVAL;
>=20
>  	/* Allocate all the needed memory */
> @@ -2541,7 +2491,7 @@ int amdgpu_vm_bo_clear_mappings(struct
> amdgpu_device *adev,
>  			after->start =3D eaddr + 1;
>  			after->last =3D tmp->last;
>  			after->offset =3D tmp->offset;
> -			after->offset +=3D (after->start - tmp->start) <<
> PAGE_SHIFT;
> +			after->offset +=3D after->start - tmp->start;
>  			after->flags =3D tmp->flags;
>  			after->bo_va =3D tmp->bo_va;
>  			list_add(&after->list, &tmp->bo_va->invalids);
> @@ -2628,7 +2578,7 @@ void amdgpu_vm_bo_trace_cs(struct amdgpu_vm
> *vm, struct ww_acquire_ctx *ticket)
>  			struct amdgpu_bo *bo;
>=20
>  			bo =3D mapping->bo_va->base.bo;
> -			if (dma_resv_locking_ctx(bo->tbo.base.resv) !=3D
> +			if (dma_resv_locking_ctx(amdkcl_ttm_resvp(&bo-
> >tbo)) !=3D
>  			    ticket)
>  				continue;
>  		}
> @@ -2656,7 +2606,7 @@ void amdgpu_vm_bo_rmv(struct amdgpu_device
> *adev,
>  	struct amdgpu_vm_bo_base **base;
>=20
>  	if (bo) {
> -		if (bo->tbo.base.resv =3D=3D vm->root.bo->tbo.base.resv)
> +		if (amdkcl_ttm_resvp(&bo->tbo) =3D=3D amdkcl_ttm_resvp(&vm-
> >root.base.bo->tbo))
>  			vm->bulk_moveable =3D false;
>=20
>  		for (base =3D &bo_va->base.bo->vm_bo; *base;
> @@ -2689,8 +2639,12 @@ void amdgpu_vm_bo_rmv(struct amdgpu_device
> *adev,
>=20
>  	dma_fence_put(bo_va->last_pt_update);
>=20
> -	if (bo && bo_va->is_xgmi)
> -		amdgpu_xgmi_set_pstate(adev,
> AMDGPU_XGMI_PSTATE_MIN);
> +	if (bo && bo_va->is_xgmi) {
> +		mutex_lock(&adev->vm_manager.lock_pstate);
> +		if (--adev->vm_manager.xgmi_map_counter =3D=3D 0)
> +			amdgpu_xgmi_set_pstate(adev, 0);
> +		mutex_unlock(&adev->vm_manager.lock_pstate);
> +	}
>=20
>  	kfree(bo_va);
>  }
> @@ -2711,7 +2665,7 @@ bool amdgpu_vm_evictable(struct amdgpu_bo *bo)
>  		return true;
>=20
>  	/* Don't evict VM page tables while they are busy */
> -	if (!dma_resv_test_signaled(bo->tbo.base.resv, true))
> +	if (!dma_resv_test_signaled_rcu(amdkcl_ttm_resvp(&bo->tbo), true))
>  		return false;
>=20
>  	/* Try to block ongoing updates */
> @@ -2719,7 +2673,7 @@ bool amdgpu_vm_evictable(struct amdgpu_bo *bo)
>  		return false;
>=20
>  	/* Don't evict VM page tables while they are updated */
> -	if (!dma_fence_is_signaled(bo_base->vm->last_unlocked)) {
> +	if (!dma_fence_is_signaled(bo_base->vm->last_direct)) {
>  		amdgpu_vm_eviction_unlock(bo_base->vm);
>  		return false;
>  	}
> @@ -2744,13 +2698,13 @@ void amdgpu_vm_bo_invalidate(struct
> amdgpu_device *adev,
>  	struct amdgpu_vm_bo_base *bo_base;
>=20
>  	/* shadow bo doesn't have bo base, its validation needs its parent */
> -	if (bo->parent && (amdgpu_bo_shadowed(bo->parent) =3D=3D bo))
> +	if (bo->parent && bo->parent->shadow =3D=3D bo)
>  		bo =3D bo->parent;
>=20
>  	for (bo_base =3D bo->vm_bo; bo_base; bo_base =3D bo_base->next) {
>  		struct amdgpu_vm *vm =3D bo_base->vm;
>=20
> -		if (evicted && bo->tbo.base.resv =3D=3D vm->root.bo-
> >tbo.base.resv) {
> +		if (evicted && amdkcl_ttm_resvp(&bo->tbo) =3D=3D
> amdkcl_ttm_resvp(&vm->root.base.bo->tbo)) {
>  			amdgpu_vm_bo_evicted(bo_base);
>  			continue;
>  		}
> @@ -2761,7 +2715,7 @@ void amdgpu_vm_bo_invalidate(struct
> amdgpu_device *adev,
>=20
>  		if (bo->tbo.type =3D=3D ttm_bo_type_kernel)
>  			amdgpu_vm_bo_relocated(bo_base);
> -		else if (bo->tbo.base.resv =3D=3D vm->root.bo->tbo.base.resv)
> +		else if (amdkcl_ttm_resvp(&bo->tbo) =3D=3D
> amdkcl_ttm_resvp(&vm->root.base.bo->tbo))
>  			amdgpu_vm_bo_moved(bo_base);
>  		else
>  			amdgpu_vm_bo_invalidated(bo_base);
> @@ -2891,12 +2845,12 @@ void amdgpu_vm_adjust_size(struct
> amdgpu_device *adev, uint32_t min_vm_size,
>   */
>  long amdgpu_vm_wait_idle(struct amdgpu_vm *vm, long timeout)
>  {
> -	timeout =3D dma_resv_wait_timeout(vm->root.bo->tbo.base.resv, true,
> -					true, timeout);
> +	timeout =3D dma_resv_wait_timeout_rcu(amdkcl_ttm_resvp(&vm-
> >root.base.bo->tbo),
> +						   true, true, timeout);
>  	if (timeout <=3D 0)
>  		return timeout;
>=20
> -	return dma_fence_wait_timeout(vm->last_unlocked, true, timeout);
> +	return dma_fence_wait_timeout(vm->last_direct, true, timeout);
>  }
>=20
>  /**
> @@ -2904,19 +2858,26 @@ long amdgpu_vm_wait_idle(struct amdgpu_vm
> *vm, long timeout)
>   *
>   * @adev: amdgpu_device pointer
>   * @vm: requested vm
> + * @vm_context: Indicates if it GFX or Compute context
> + * @pasid: Process address space identifier
>   *
>   * Init @vm fields.
>   *
>   * Returns:
>   * 0 for success, error for failure.
>   */
> -int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm)
> +int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
> +		   int vm_context, unsigned int pasid)
>  {
> -	struct amdgpu_bo *root_bo;
> -	struct amdgpu_bo_vm *root;
> +	struct amdgpu_bo_param bp;
> +	struct amdgpu_bo *root;
>  	int r, i;
>=20
> +#ifndef HAVE_TREE_INSERT_HAVE_RB_ROOT_CACHED
> +	vm->va =3D RB_ROOT;
> +#else
>  	vm->va =3D RB_ROOT_CACHED;
> +#endif
>  	for (i =3D 0; i < AMDGPU_MAX_VMHUBS; i++)
>  		vm->reserved_vmid[i] =3D NULL;
>  	INIT_LIST_HEAD(&vm->evicted);
> @@ -2929,7 +2890,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev,
> struct amdgpu_vm *vm)
>  	INIT_LIST_HEAD(&vm->done);
>=20
>  	/* create scheduler entities for page table updates */
> -	r =3D drm_sched_entity_init(&vm->immediate,
> DRM_SCHED_PRIORITY_NORMAL,
> +	r =3D drm_sched_entity_init(&vm->direct,
> DRM_SCHED_PRIORITY_NORMAL,
>  				  adev->vm_manager.vm_pte_scheds,
>  				  adev->vm_manager.vm_pte_num_scheds,
> NULL);
>  	if (r)
> @@ -2939,14 +2900,21 @@ int amdgpu_vm_init(struct amdgpu_device *adev,
> struct amdgpu_vm *vm)
>  				  adev->vm_manager.vm_pte_scheds,
>  				  adev->vm_manager.vm_pte_num_scheds,
> NULL);
>  	if (r)
> -		goto error_free_immediate;
> +		goto error_free_direct;
>=20
>  	vm->pte_support_ats =3D false;
>  	vm->is_compute_context =3D false;
>=20
> -	vm->use_cpu_for_update =3D !!(adev->vm_manager.vm_update_mode
> &
> -				    AMDGPU_VM_USE_CPU_FOR_GFX);
> +	if (vm_context =3D=3D AMDGPU_VM_CONTEXT_COMPUTE) {
> +		vm->use_cpu_for_update =3D !!(adev-
> >vm_manager.vm_update_mode &
> +
> 	AMDGPU_VM_USE_CPU_FOR_COMPUTE);
>=20
> +		if (adev->asic_type =3D=3D CHIP_RAVEN)
> +			vm->pte_support_ats =3D true;
> +	} else {
> +		vm->use_cpu_for_update =3D !!(adev-
> >vm_manager.vm_update_mode &
> +
> 	AMDGPU_VM_USE_CPU_FOR_GFX);
> +	}
>  	DRM_DEBUG_DRIVER("VM update mode is %s\n",
>  			 vm->use_cpu_for_update ? "CPU" : "SDMA");
>  	WARN_ONCE((vm->use_cpu_for_update &&
> @@ -2958,50 +2926,65 @@ int amdgpu_vm_init(struct amdgpu_device *adev,
> struct amdgpu_vm *vm)
>  	else
>  		vm->update_funcs =3D &amdgpu_vm_sdma_funcs;
>  	vm->last_update =3D NULL;
> -	vm->last_unlocked =3D dma_fence_get_stub();
> +	vm->last_direct =3D dma_fence_get_stub();
>=20
>  	mutex_init(&vm->eviction_lock);
>  	vm->evicting =3D false;
>=20
> -	r =3D amdgpu_vm_pt_create(adev, vm, adev->vm_manager.root_level,
> -				false, &root);
> +	amdgpu_vm_bo_param(adev, vm, adev->vm_manager.root_level,
> false, &bp);
> +	if (vm_context =3D=3D AMDGPU_VM_CONTEXT_COMPUTE)
> +		bp.flags &=3D ~AMDGPU_GEM_CREATE_SHADOW;
> +	r =3D amdgpu_bo_create(adev, &bp, &root);
>  	if (r)
>  		goto error_free_delayed;
> -	root_bo =3D &root->bo;
> -	r =3D amdgpu_bo_reserve(root_bo, true);
> +
> +	r =3D amdgpu_bo_reserve(root, true);
>  	if (r)
>  		goto error_free_root;
>=20
> -	r =3D dma_resv_reserve_shared(root_bo->tbo.base.resv, 1);
> +	r =3D dma_resv_reserve_shared(amdkcl_ttm_resvp(&root->tbo), 1);
>  	if (r)
>  		goto error_unreserve;
>=20
> -	amdgpu_vm_bo_base_init(&vm->root, vm, root_bo);
> +	amdgpu_vm_bo_base_init(&vm->root.base, vm, root);
>=20
>  	r =3D amdgpu_vm_clear_bo(adev, vm, root, false);
>  	if (r)
>  		goto error_unreserve;
>=20
> -	amdgpu_bo_unreserve(vm->root.bo);
> +	amdgpu_bo_unreserve(vm->root.base.bo);
> +
> +	if (pasid) {
> +		unsigned long flags;
> +
> +		spin_lock_irqsave(&adev->vm_manager.pasid_lock, flags);
> +		r =3D idr_alloc(&adev->vm_manager.pasid_idr, vm, pasid, pasid +
> 1,
> +			      GFP_ATOMIC);
> +		spin_unlock_irqrestore(&adev->vm_manager.pasid_lock, flags);
> +		if (r < 0)
> +			goto error_free_root;
> +
> +		vm->pasid =3D pasid;
> +	}
>=20
>  	INIT_KFIFO(vm->faults);
>=20
>  	return 0;
>=20
>  error_unreserve:
> -	amdgpu_bo_unreserve(vm->root.bo);
> +	amdgpu_bo_unreserve(vm->root.base.bo);
>=20
>  error_free_root:
> -	amdgpu_bo_unref(&root->shadow);
> -	amdgpu_bo_unref(&root_bo);
> -	vm->root.bo =3D NULL;
> +	amdgpu_bo_unref(&vm->root.base.bo->shadow);
> +	amdgpu_bo_unref(&vm->root.base.bo);
> +	vm->root.base.bo =3D NULL;
>=20
>  error_free_delayed:
> -	dma_fence_put(vm->last_unlocked);
> +	dma_fence_put(vm->last_direct);
>  	drm_sched_entity_destroy(&vm->delayed);
>=20
> -error_free_immediate:
> -	drm_sched_entity_destroy(&vm->immediate);
> +error_free_direct:
> +	drm_sched_entity_destroy(&vm->direct);
>=20
>  	return r;
>  }
> @@ -3020,14 +3003,17 @@ int amdgpu_vm_init(struct amdgpu_device *adev,
> struct amdgpu_vm *vm)
>   *	0 if this VM is clean
>   */
>  static int amdgpu_vm_check_clean_reserved(struct amdgpu_device *adev,
> -					  struct amdgpu_vm *vm)
> +	struct amdgpu_vm *vm)
>  {
>  	enum amdgpu_vm_level root =3D adev->vm_manager.root_level;
>  	unsigned int entries =3D amdgpu_vm_num_entries(adev, root);
>  	unsigned int i =3D 0;
>=20
> +	if (!(vm->root.entries))
> +		return 0;
> +
>  	for (i =3D 0; i < entries; i++) {
> -		if (to_amdgpu_bo_vm(vm->root.bo)->entries[i].bo)
> +		if (vm->root.entries[i].base.bo)
>  			return -EINVAL;
>  	}
>=20
> @@ -3039,6 +3025,7 @@ static int amdgpu_vm_check_clean_reserved(struct
> amdgpu_device *adev,
>   *
>   * @adev: amdgpu_device pointer
>   * @vm: requested vm
> + * @pasid: pasid to use
>   *
>   * This only works on GFX VMs that don't have any BOs added and no
>   * page tables allocated yet.
> @@ -3046,6 +3033,7 @@ static int amdgpu_vm_check_clean_reserved(struct
> amdgpu_device *adev,
>   * Changes the following VM parameters:
>   * - use_cpu_for_update
>   * - pte_supports_ats
> + * - pasid (old PASID is released, because compute manages its own PASID=
s)
>   *
>   * Reinitializes the page directory to reflect the changed ATS
>   * setting.
> @@ -3053,12 +3041,13 @@ static int
> amdgpu_vm_check_clean_reserved(struct amdgpu_device *adev,
>   * Returns:
>   * 0 for success, -errno for errors.
>   */
> -int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct
> amdgpu_vm *vm)
> +int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct
> amdgpu_vm *vm,
> +			   unsigned int pasid)
>  {
>  	bool pte_support_ats =3D (adev->asic_type =3D=3D CHIP_RAVEN);
>  	int r;
>=20
> -	r =3D amdgpu_bo_reserve(vm->root.bo, true);
> +	r =3D amdgpu_bo_reserve(vm->root.base.bo, true);
>  	if (r)
>  		return r;
>=20
> @@ -3067,16 +3056,27 @@ int amdgpu_vm_make_compute(struct
> amdgpu_device *adev, struct amdgpu_vm *vm)
>  	if (r)
>  		goto unreserve_bo;
>=20
> +	if (pasid) {
> +		unsigned long flags;
> +
> +		spin_lock_irqsave(&adev->vm_manager.pasid_lock, flags);
> +		r =3D idr_alloc(&adev->vm_manager.pasid_idr, vm, pasid, pasid +
> 1,
> +			      GFP_ATOMIC);
> +		spin_unlock_irqrestore(&adev->vm_manager.pasid_lock, flags);
> +
> +		if (r =3D=3D -ENOSPC)
> +			goto unreserve_bo;
> +		r =3D 0;
> +	}
> +
>  	/* Check if PD needs to be reinitialized and do it before
>  	 * changing any other state, in case it fails.
>  	 */
>  	if (pte_support_ats !=3D vm->pte_support_ats) {
>  		vm->pte_support_ats =3D pte_support_ats;
> -		r =3D amdgpu_vm_clear_bo(adev, vm,
> -				       to_amdgpu_bo_vm(vm->root.bo),
> -				       false);
> +		r =3D amdgpu_vm_clear_bo(adev, vm, vm->root.base.bo, false);
>  		if (r)
> -			goto unreserve_bo;
> +			goto free_idr;
>  	}
>=20
>  	/* Update VM state */
> @@ -3088,28 +3088,46 @@ int amdgpu_vm_make_compute(struct
> amdgpu_device *adev, struct amdgpu_vm *vm)
>  		   !amdgpu_gmc_vram_full_visible(&adev->gmc)),
>  		  "CPU update of VM recommended only for large BAR
> system\n");
>=20
> -	if (vm->use_cpu_for_update) {
> -		/* Sync with last SDMA update/clear before switching to CPU
> */
> -		r =3D amdgpu_bo_sync_wait(vm->root.bo,
> -
> 	AMDGPU_FENCE_OWNER_UNDEFINED, true);
> -		if (r)
> -			goto unreserve_bo;
> -
> +	if (vm->use_cpu_for_update)
>  		vm->update_funcs =3D &amdgpu_vm_cpu_funcs;
> -	} else {
> +	else
>  		vm->update_funcs =3D &amdgpu_vm_sdma_funcs;
> -	}
>  	dma_fence_put(vm->last_update);
>  	vm->last_update =3D NULL;
>  	vm->is_compute_context =3D true;
>=20
> +	if (vm->pasid) {
> +		unsigned long flags;
> +
> +		spin_lock_irqsave(&adev->vm_manager.pasid_lock, flags);
> +		idr_remove(&adev->vm_manager.pasid_idr, vm->pasid);
> +		spin_unlock_irqrestore(&adev->vm_manager.pasid_lock, flags);
> +
> +		/* Free the original amdgpu allocated pasid
> +		 * Will be replaced with kfd allocated pasid
> +		 */
> +		amdgpu_pasid_free(vm->pasid);
> +		vm->pasid =3D 0;
> +	}
> +
>  	/* Free the shadow bo for compute VM */
> -	amdgpu_bo_unref(&to_amdgpu_bo_vm(vm->root.bo)->shadow);
> +	amdgpu_bo_unref(&vm->root.base.bo->shadow);
> +
> +	if (pasid)
> +		vm->pasid =3D pasid;
>=20
>  	goto unreserve_bo;
>=20
> +free_idr:
> +	if (pasid) {
> +		unsigned long flags;
> +
> +		spin_lock_irqsave(&adev->vm_manager.pasid_lock, flags);
> +		idr_remove(&adev->vm_manager.pasid_idr, pasid);
> +		spin_unlock_irqrestore(&adev->vm_manager.pasid_lock, flags);
> +	}
>  unreserve_bo:
> -	amdgpu_bo_unreserve(vm->root.bo);
> +	amdgpu_bo_unreserve(vm->root.base.bo);
>  	return r;
>  }
>=20
> @@ -3123,7 +3141,14 @@ int amdgpu_vm_make_compute(struct
> amdgpu_device *adev, struct amdgpu_vm *vm)
>   */
>  void amdgpu_vm_release_compute(struct amdgpu_device *adev, struct
> amdgpu_vm *vm)
>  {
> -	amdgpu_vm_set_pasid(adev, vm, 0);
> +	if (vm->pasid) {
> +		unsigned long flags;
> +
> +		spin_lock_irqsave(&adev->vm_manager.pasid_lock, flags);
> +		idr_remove(&adev->vm_manager.pasid_idr, vm->pasid);
> +		spin_unlock_irqrestore(&adev->vm_manager.pasid_lock, flags);
> +	}
> +	vm->pasid =3D 0;
>  	vm->is_compute_context =3D false;
>  }
>=20
> @@ -3145,11 +3170,19 @@ void amdgpu_vm_fini(struct amdgpu_device
> *adev, struct amdgpu_vm *vm)
>=20
>  	amdgpu_amdkfd_gpuvm_destroy_cb(adev, vm);
>=20
> -	root =3D amdgpu_bo_ref(vm->root.bo);
> +	root =3D amdgpu_bo_ref(vm->root.base.bo);
>  	amdgpu_bo_reserve(root, true);
> -	amdgpu_vm_set_pasid(adev, vm, 0);
> -	dma_fence_wait(vm->last_unlocked, false);
> -	dma_fence_put(vm->last_unlocked);
> +	if (vm->pasid) {
> +		unsigned long flags;
> +
> +		spin_lock_irqsave(&adev->vm_manager.pasid_lock, flags);
> +		idr_remove(&adev->vm_manager.pasid_idr, vm->pasid);
> +		spin_unlock_irqrestore(&adev->vm_manager.pasid_lock, flags);
> +		vm->pasid =3D 0;
> +	}
> +
> +	dma_fence_wait(vm->last_direct, false);
> +	dma_fence_put(vm->last_direct);
>=20
>  	list_for_each_entry_safe(mapping, tmp, &vm->freed, list) {
>  		if (mapping->flags & AMDGPU_PTE_PRT && prt_fini_needed) {
> @@ -3164,16 +3197,24 @@ void amdgpu_vm_fini(struct amdgpu_device
> *adev, struct amdgpu_vm *vm)
>  	amdgpu_vm_free_pts(adev, vm, NULL);
>  	amdgpu_bo_unreserve(root);
>  	amdgpu_bo_unref(&root);
> -	WARN_ON(vm->root.bo);
> +	WARN_ON(vm->root.base.bo);
>=20
> -	drm_sched_entity_destroy(&vm->immediate);
> +	drm_sched_entity_destroy(&vm->direct);
>  	drm_sched_entity_destroy(&vm->delayed);
>=20
> +#ifndef HAVE_TREE_INSERT_HAVE_RB_ROOT_CACHED
> +	if (!RB_EMPTY_ROOT(&vm->va)) {
> +#else
>  	if (!RB_EMPTY_ROOT(&vm->va.rb_root)) {
> +#endif
>  		dev_err(adev->dev, "still active bo inside vm\n");
>  	}
>  	rbtree_postorder_for_each_entry_safe(mapping, tmp,
> +#ifndef HAVE_TREE_INSERT_HAVE_RB_ROOT_CACHED
> +					     &vm->va, rb) {
> +#else
>  					     &vm->va.rb_root, rb) {
> +#endif
>  		/* Don't remove the mapping here, we don't want to trigger a
>  		 * rebalance and the tree is about to be destroyed anyway.
>  		 */
> @@ -3197,12 +3238,6 @@ void amdgpu_vm_manager_init(struct
> amdgpu_device *adev)
>  {
>  	unsigned i;
>=20
> -	/* Concurrent flushes are only possible starting with Vega10 and
> -	 * are broken on Navi10 and Navi14.
> -	 */
> -	adev->vm_manager.concurrent_flush =3D !(adev->asic_type <
> CHIP_VEGA10 ||
> -					      adev->asic_type =3D=3D CHIP_NAVI10
> ||
> -					      adev->asic_type =3D=3D CHIP_NAVI14);
>  	amdgpu_vmid_mgr_init(adev);
>=20
>  	adev->vm_manager.fence_context =3D
> @@ -3229,7 +3264,11 @@ void amdgpu_vm_manager_init(struct
> amdgpu_device *adev)
>  	adev->vm_manager.vm_update_mode =3D 0;
>  #endif
>=20
> -	xa_init_flags(&adev->vm_manager.pasids, XA_FLAGS_LOCK_IRQ);
> +	idr_init(&adev->vm_manager.pasid_idr);
> +	spin_lock_init(&adev->vm_manager.pasid_lock);
> +
> +	adev->vm_manager.xgmi_map_counter =3D 0;
> +	mutex_init(&adev->vm_manager.lock_pstate);
>  }
>=20
>  /**
> @@ -3241,8 +3280,8 @@ void amdgpu_vm_manager_init(struct
> amdgpu_device *adev)
>   */
>  void amdgpu_vm_manager_fini(struct amdgpu_device *adev)
>  {
> -	WARN_ON(!xa_empty(&adev->vm_manager.pasids));
> -	xa_destroy(&adev->vm_manager.pasids);
> +	WARN_ON(!idr_is_empty(&adev->vm_manager.pasid_idr));
> +	idr_destroy(&adev->vm_manager.pasid_idr);
>=20
>  	amdgpu_vmid_mgr_fini(adev);
>  }
> @@ -3260,7 +3299,7 @@ void amdgpu_vm_manager_fini(struct
> amdgpu_device *adev)
>  int amdgpu_vm_ioctl(struct drm_device *dev, void *data, struct drm_file =
*filp)
>  {
>  	union drm_amdgpu_vm *args =3D data;
> -	struct amdgpu_device *adev =3D drm_to_adev(dev);
> +	struct amdgpu_device *adev =3D dev->dev_private;
>  	struct amdgpu_fpriv *fpriv =3D filp->driver_priv;
>  	long timeout =3D msecs_to_jiffies(2000);
>  	int r;
> @@ -3280,7 +3319,7 @@ int amdgpu_vm_ioctl(struct drm_device *dev, void
> *data, struct drm_file *filp)
>  		/* Wait vm idle to make sure the vmid set in SPM_VMID is
>  		 * not referenced anymore.
>  		 */
> -		r =3D amdgpu_bo_reserve(fpriv->vm.root.bo, true);
> +		r =3D amdgpu_bo_reserve(fpriv->vm.root.base.bo, true);
>  		if (r)
>  			return r;
>=20
> @@ -3288,7 +3327,7 @@ int amdgpu_vm_ioctl(struct drm_device *dev, void
> *data, struct drm_file *filp)
>  		if (r < 0)
>  			return r;
>=20
> -		amdgpu_bo_unreserve(fpriv->vm.root.bo);
> +		amdgpu_bo_unreserve(fpriv->vm.root.base.bo);
>  		amdgpu_vmid_free_reserved(adev, &fpriv->vm,
> AMDGPU_GFXHUB_0);
>  		break;
>  	default:
> @@ -3305,19 +3344,19 @@ int amdgpu_vm_ioctl(struct drm_device *dev,
> void *data, struct drm_file *filp)
>   * @pasid: PASID identifier for VM
>   * @task_info: task_info to fill.
>   */
> -void amdgpu_vm_get_task_info(struct amdgpu_device *adev, u32 pasid,
> +void amdgpu_vm_get_task_info(struct amdgpu_device *adev, unsigned int
> pasid,
>  			 struct amdgpu_task_info *task_info)
>  {
>  	struct amdgpu_vm *vm;
>  	unsigned long flags;
>=20
> -	xa_lock_irqsave(&adev->vm_manager.pasids, flags);
> +	spin_lock_irqsave(&adev->vm_manager.pasid_lock, flags);
>=20
> -	vm =3D xa_load(&adev->vm_manager.pasids, pasid);
> +	vm =3D idr_find(&adev->vm_manager.pasid_idr, pasid);
>  	if (vm)
>  		*task_info =3D vm->task_info;
>=20
> -	xa_unlock_irqrestore(&adev->vm_manager.pasids, flags);
> +	spin_unlock_irqrestore(&adev->vm_manager.pasid_lock, flags);
>  }
>=20
>  /**
> @@ -3349,60 +3388,50 @@ void amdgpu_vm_set_task_info(struct
> amdgpu_vm *vm)
>   * Try to gracefully handle a VM fault. Return true if the fault was han=
dled and
>   * shouldn't be reported any more.
>   */
> -bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
> +bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, unsigned int
> pasid,
>  			    uint64_t addr)
>  {
> -	bool is_compute_context =3D false;
>  	struct amdgpu_bo *root;
> -	unsigned long irqflags;
>  	uint64_t value, flags;
>  	struct amdgpu_vm *vm;
> -	int r;
> +	long r;
>=20
> -	xa_lock_irqsave(&adev->vm_manager.pasids, irqflags);
> -	vm =3D xa_load(&adev->vm_manager.pasids, pasid);
> -	if (vm) {
> -		root =3D amdgpu_bo_ref(vm->root.bo);
> -		is_compute_context =3D vm->is_compute_context;
> -	} else {
> +	spin_lock(&adev->vm_manager.pasid_lock);
> +	vm =3D idr_find(&adev->vm_manager.pasid_idr, pasid);
> +	if (vm)
> +		root =3D amdgpu_bo_ref(vm->root.base.bo);
> +	else
>  		root =3D NULL;
> -	}
> -	xa_unlock_irqrestore(&adev->vm_manager.pasids, irqflags);
> +	spin_unlock(&adev->vm_manager.pasid_lock);
>=20
>  	if (!root)
>  		return false;
>=20
> -	addr /=3D AMDGPU_GPU_PAGE_SIZE;
> -
> -	if (is_compute_context &&
> -	    !svm_range_restore_pages(adev, pasid, addr)) {
> -		amdgpu_bo_unref(&root);
> -		return true;
> -	}
> -
>  	r =3D amdgpu_bo_reserve(root, true);
>  	if (r)
>  		goto error_unref;
>=20
>  	/* Double check that the VM still exists */
> -	xa_lock_irqsave(&adev->vm_manager.pasids, irqflags);
> -	vm =3D xa_load(&adev->vm_manager.pasids, pasid);
> -	if (vm && vm->root.bo !=3D root)
> +	spin_lock(&adev->vm_manager.pasid_lock);
> +	vm =3D idr_find(&adev->vm_manager.pasid_idr, pasid);
> +	if (vm && vm->root.base.bo !=3D root)
>  		vm =3D NULL;
> -	xa_unlock_irqrestore(&adev->vm_manager.pasids, irqflags);
> +	spin_unlock(&adev->vm_manager.pasid_lock);
>  	if (!vm)
>  		goto error_unlock;
>=20
> +	addr /=3D AMDGPU_GPU_PAGE_SIZE;
>  	flags =3D AMDGPU_PTE_VALID | AMDGPU_PTE_SNOOPED |
>  		AMDGPU_PTE_SYSTEM;
>=20
> -	if (is_compute_context) {
> +	if (vm->is_compute_context) {
>  		/* Intentionally setting invalid PTE flag
>  		 * combination to force a no-retry-fault
>  		 */
>  		flags =3D AMDGPU_PTE_EXECUTABLE | AMDGPU_PDE_PTE |
>  			AMDGPU_PTE_TF;
>  		value =3D 0;
> +
>  	} else if (amdgpu_vm_fault_stop =3D=3D
> AMDGPU_VM_FAULT_STOP_NEVER) {
>  		/* Redirect the access to the dummy page */
>  		value =3D adev->dummy_page_addr;
> @@ -3414,15 +3443,8 @@ bool amdgpu_vm_handle_fault(struct
> amdgpu_device *adev, u32 pasid,
>  		value =3D 0;
>  	}
>=20
> -	r =3D dma_resv_reserve_shared(root->tbo.base.resv, 1);
> -	if (r) {
> -		pr_debug("failed %d to reserve fence slot\n", r);
> -		goto error_unlock;
> -	}
> -
> -	r =3D amdgpu_vm_bo_update_mapping(adev, adev, vm, true, false,
> NULL, addr,
> -					addr, flags, value, NULL, NULL, NULL,
> -					NULL);
> +	r =3D amdgpu_vm_bo_update_mapping(adev, vm, true, NULL, addr, addr
> + 1,
> +					flags, value, NULL, NULL);
>  	if (r)
>  		goto error_unlock;
>=20
> @@ -3431,106 +3453,10 @@ bool amdgpu_vm_handle_fault(struct
> amdgpu_device *adev, u32 pasid,
>  error_unlock:
>  	amdgpu_bo_unreserve(root);
>  	if (r < 0)
> -		DRM_ERROR("Can't handle page fault (%d)\n", r);
> +		DRM_ERROR("Can't handle page fault (%ld)\n", r);
>=20
>  error_unref:
>  	amdgpu_bo_unref(&root);
>=20
>  	return false;
>  }
> -
> -#if defined(CONFIG_DEBUG_FS)
> -/**
> - * amdgpu_debugfs_vm_bo_info  - print BO info for the VM
> - *
> - * @vm: Requested VM for printing BO info
> - * @m: debugfs file
> - *
> - * Print BO information in debugfs file for the VM
> - */
> -void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm *vm, struct seq_file
> *m)
> -{
> -	struct amdgpu_bo_va *bo_va, *tmp;
> -	u64 total_idle =3D 0;
> -	u64 total_evicted =3D 0;
> -	u64 total_relocated =3D 0;
> -	u64 total_moved =3D 0;
> -	u64 total_invalidated =3D 0;
> -	u64 total_done =3D 0;
> -	unsigned int total_idle_objs =3D 0;
> -	unsigned int total_evicted_objs =3D 0;
> -	unsigned int total_relocated_objs =3D 0;
> -	unsigned int total_moved_objs =3D 0;
> -	unsigned int total_invalidated_objs =3D 0;
> -	unsigned int total_done_objs =3D 0;
> -	unsigned int id =3D 0;
> -
> -	seq_puts(m, "\tIdle BOs:\n");
> -	list_for_each_entry_safe(bo_va, tmp, &vm->idle, base.vm_status) {
> -		if (!bo_va->base.bo)
> -			continue;
> -		total_idle +=3D amdgpu_bo_print_info(id++, bo_va->base.bo, m);
> -	}
> -	total_idle_objs =3D id;
> -	id =3D 0;
> -
> -	seq_puts(m, "\tEvicted BOs:\n");
> -	list_for_each_entry_safe(bo_va, tmp, &vm->evicted, base.vm_status) {
> -		if (!bo_va->base.bo)
> -			continue;
> -		total_evicted +=3D amdgpu_bo_print_info(id++, bo_va->base.bo,
> m);
> -	}
> -	total_evicted_objs =3D id;
> -	id =3D 0;
> -
> -	seq_puts(m, "\tRelocated BOs:\n");
> -	list_for_each_entry_safe(bo_va, tmp, &vm->relocated, base.vm_status)
> {
> -		if (!bo_va->base.bo)
> -			continue;
> -		total_relocated +=3D amdgpu_bo_print_info(id++, bo_va-
> >base.bo, m);
> -	}
> -	total_relocated_objs =3D id;
> -	id =3D 0;
> -
> -	seq_puts(m, "\tMoved BOs:\n");
> -	list_for_each_entry_safe(bo_va, tmp, &vm->moved, base.vm_status) {
> -		if (!bo_va->base.bo)
> -			continue;
> -		total_moved +=3D amdgpu_bo_print_info(id++, bo_va->base.bo,
> m);
> -	}
> -	total_moved_objs =3D id;
> -	id =3D 0;
> -
> -	seq_puts(m, "\tInvalidated BOs:\n");
> -	spin_lock(&vm->invalidated_lock);
> -	list_for_each_entry_safe(bo_va, tmp, &vm->invalidated,
> base.vm_status) {
> -		if (!bo_va->base.bo)
> -			continue;
> -		total_invalidated +=3D amdgpu_bo_print_info(id++,
> 	bo_va->base.bo, m);
> -	}
> -	total_invalidated_objs =3D id;
> -	id =3D 0;
> -
> -	seq_puts(m, "\tDone BOs:\n");
> -	list_for_each_entry_safe(bo_va, tmp, &vm->done, base.vm_status) {
> -		if (!bo_va->base.bo)
> -			continue;
> -		total_done +=3D amdgpu_bo_print_info(id++, bo_va->base.bo,
> m);
> -	}
> -	spin_unlock(&vm->invalidated_lock);
> -	total_done_objs =3D id;
> -
> -	seq_printf(m, "\tTotal idle size:        %12lld\tobjs:\t%d\n", total_id=
le,
> -		   total_idle_objs);
> -	seq_printf(m, "\tTotal evicted size:     %12lld\tobjs:\t%d\n",
> total_evicted,
> -		   total_evicted_objs);
> -	seq_printf(m, "\tTotal relocated size:   %12lld\tobjs:\t%d\n",
> total_relocated,
> -		   total_relocated_objs);
> -	seq_printf(m, "\tTotal moved size:       %12lld\tobjs:\t%d\n",
> total_moved,
> -		   total_moved_objs);
> -	seq_printf(m, "\tTotal invalidated size: %12lld\tobjs:\t%d\n",
> total_invalidated,
> -		   total_invalidated_objs);
> -	seq_printf(m, "\tTotal done size:        %12lld\tobjs:\t%d\n", total_do=
ne,
> -		   total_done_objs);
> -}
> -#endif
> --
> 2.17.1
