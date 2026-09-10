Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0A66C79FB9
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Sep 2026 05:56:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3961E10E245;
	Thu, 10 Sep 2026 05:56:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="el8bvnrH";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010061.outbound.protection.outlook.com [52.101.46.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3267710E245
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Sep 2026 05:56:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B1GWkvBHhJ3gpwtsVyHDNnB04IJer3wiIG0y1IVFb3b+/tzpYZe8wZRgs5KQqgthk0nuAWAvYGBL5RSejGHr7dstJFv+1ldcKyV+q2zoU+WRhW3IlovIiGE7xz5JqctG/MWqweDqMxH3WSu1f2cqrXK/5FPSVgqdsejcvecvBgAhO/UNe3djeLRigiQuPF0C0i666SZT3rTaqcc7oBeGTOGPM4Iy9jID/rjqdE8muW/ajMhpbrDITYWZDLHwES1NvjJcQViK09TEfz8DzOpKMVX+vS9w4zBSRV/kM6JbrYniXNtOFsiVHSfiq5b3gv7sPmQIdZOeSqMHbT/8/ZNefA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9zgZGlxWiMz0B3Zyypk1ym6EiJHNd8okD/EXc5I0QXE=;
 b=hQ3n91a5b5cM7vgxdpeNVPkikitXd3+PKGECX2Cm3ARoYO9VhLFvVSyI3kgS5IPCL6ty1yO1xG/3SnoCb0a6GpWe0mXk2TdqPeorY+WTLGdjMkLNHY1hNRSxzTHVtpNwWU1HwkWI362wAsxeb2T6k9Ip9B08HYhta9cisgzIiIWPYueM4LYXXNz0OpNz0wajDqBRzFRwzLT+ASK+lkBTaiZ7Pj+hJvvrTOxwmXbZS7lTxIbX5QLXA75r6qJ5D/mdSdniMRCp7VchuSCNRyP25UJ+Ghv2Va9LTG03dGjxIuaRkEEa+AjZ5Ob3C4eksTiD8LZjyEMhqGkUxg9TMttq2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9zgZGlxWiMz0B3Zyypk1ym6EiJHNd8okD/EXc5I0QXE=;
 b=el8bvnrHJz45up8sl0vhEc4nEpNisOQ1l7KpoH6BHUZRUqdxGIej1PhSK1HxjMFdO7r8R/zPGYQnxpXlrmr6nR6vpTMKY85zrj60XCD7FwIPSDmNFoOgPIsq1Nw+sLd+BsQt2A8k+U3mipRw/gvrt9eqDm36A8Njs4WB5jGU+lk=
Received: from DS7PR12MB6005.namprd12.prod.outlook.com (2603:10b6:8:7c::17) by
 DM3PR12MB9288.namprd12.prod.outlook.com (2603:10b6:0:4a::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.8; Thu, 10 Sep 2026 05:56:01 +0000
Received: from DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::ab84:617d:61a9:3727]) by DS7PR12MB6005.namprd12.prod.outlook.com
 ([fe80::ab84:617d:61a9:3727%6]) with mapi id 15.21.0406.007; Thu, 10 Sep 2026
 05:56:01 +0000
From: "Liang, Prike" <Prike.Liang@amd.com>
To: "Prosyak, Vitaly" <Vitaly.Prosyak@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Prosyak, Vitaly" <Vitaly.Prosyak@amd.com>, "Khatri, Sunil"
 <Sunil.Khatri@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 1/2] drm/amdgpu: reserve eviction-fence slot at WPTR caller
Thread-Topic: [PATCH 1/2] drm/amdgpu: reserve eviction-fence slot at WPTR
 caller
Thread-Index: AQHdQL3rno7y3B9ZfEusefOJGgaGJrbHTdSA
Date: Thu, 10 Sep 2026 05:56:01 +0000
Message-ID: <DS7PR12MB6005E595F855BD7D24D1ACF4FBBF2@DS7PR12MB6005.namprd12.prod.outlook.com>
References: <20260910004701.94511-1-vitaly.prosyak@amd.com>
In-Reply-To: <20260910004701.94511-1-vitaly.prosyak@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-09-10T05:45:59.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB6005:EE_|DM3PR12MB9288:EE_
x-ms-office365-filtering-correlation-id: 6542ab45-04bd-4e73-ad43-08df0f003172
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|38070700021|56012099006|10067099003|11063799006|18002099003|22082099003;
x-microsoft-antispam-message-info: l/pDfyB8SUlNXdgd1qiTS4Ni6/xB7/MfOr0hy0KiKSKG2JZJ86Hy6NnhpP5NjFYfNLmiQABb1RBFNxq/M29J1NMRgR4xB53C60y8RCRHESdJBWJxvF/aAxyjRYnJfSiU/JEzxiKxEuwp4JN26P5vC9cderqH5JN/oAEyeKu7bCghBBOmbvwyaPBinBcgrLPsjF/gX12pqVJodx8KhAb5jXq34wtHN8fJllcDalRiniiJ6kXuE680QqvHj/Dh6n7ufJ2BERCAoQ3tmk3/JO6pZuJHNTyS3FOqEkJgNWTVfn8YRqdCzv2lSDrBMODBAw+JJaY7QwkeiJIWTyxTZvu8hksFq8QDf0moHZps7KCWTsLHqLZ0G2kuoP1xvs8GY9KOiGJCON84tcZxnXwKrDXlv9tVjrFcODWiTUUGqPOehkfE8imbJbpje059WiuTT+rh7X/U2lj+YZcFpxGyajKCJ/n5LuM6ZixOrIQE5ytHDPDXn0XLuLoJOQ0e+uP3YuCHL6pluKlQP8tmDDQ+RjHUyko/0+tLjKnclC2QL+nwtqrUf3U8jaKsSKZnA32YQwOkUR/fV4mwfUinaBODiDEo+t8StRASFlXT0J9frM3FWS2G+/KukQ2Ej1OAi/68ToBAleu39uPoKrn6Q1pFGBXDO4szWMYSt8ZWv7Uwkh7ldI22osDPsI2/T1rVRP9q78Kl1tJ0IdNvCUTpfEVfd0SahXlL+EaZkGFFzcbzezb0xJg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB6005.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(38070700021)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?xHOdeUGLcZhM5VtwbfOYzBrA7HbcvdfKu8SK3Z7XB+cp6vMyT8uZMa7Ai9?=
 =?iso-8859-1?Q?lvnCBF5xvWilp/pcLnd0cJJXOQolAtGeFkpeXupHXMfgM+PSTakxUV79Nz?=
 =?iso-8859-1?Q?0LV/v96qN1wXYMY0gPZjnJ+esP6yc0kSNrSz75kaKgO+jlVOooUI1z4e5g?=
 =?iso-8859-1?Q?FYWeO8OJQ95SkiENQFuewtGUDSbwTY7bf/1FzR9JPdyQ5It0r7RUOmMmE4?=
 =?iso-8859-1?Q?SMj+kzwYw11vyRY1pQs7LZXD0UintwJ9xNlkuCb5Dw6kQ9VLZAooFJ4G8G?=
 =?iso-8859-1?Q?abMvlF9J00o1QBMSUIyuXRKkDbeHjVYTVJ8gIrsypnpW06tt8ejNXaNBCC?=
 =?iso-8859-1?Q?ZHs+198ejuxJV/jIIOiHH5n61s+0x2RnIAfm3WG/+TaFIzvkSl9wunTofY?=
 =?iso-8859-1?Q?1r9jwTgxoUQnqFSMgKWVZToZOJdbrjqGj4ijrUWGrmxMiit6FnQvaWkZpL?=
 =?iso-8859-1?Q?9ERJ9xiKwmeLYfMW3IQwIsH+3cP+wuN+zO3EJUDpn3U6Nm2BRLMBIsFPcN?=
 =?iso-8859-1?Q?l7GsNJYMj/XcyBqNYiEbPNWTqTU2i0Ivl30L4P9QV+ziR3h5zxCvbg3nzK?=
 =?iso-8859-1?Q?Y4A10EZlJoHljhmiEzgnCvQJto3+2+k39m3uEd/uI0VR81XrngyyWlPmhc?=
 =?iso-8859-1?Q?llLV+Ca5csj4oZJDXBYdFDtFYWvGBycRyXCyFiVcMQiNBeby2u9PAoQJTx?=
 =?iso-8859-1?Q?IDh5BeLaFf6rswLbUVpKQ/KzPf+Y31WnglABeNejgMso1YqAWCI+RM4OEj?=
 =?iso-8859-1?Q?WTeHOaNiDMmXyRR6QZZp57B0ZYhABK4K47w55FGOX3rbk6Y13BVWQoJ0iW?=
 =?iso-8859-1?Q?7kACwaQqU8XqJmpFr1MBbjXyZf7mKfdHd/kbxzEDFWSXqi8xnREbi5hYth?=
 =?iso-8859-1?Q?8hIKskaQWhv1XO6GkHmdiQ06/RiQVfpBpJfhiPBlHDl8ZOycwPWHK/Xdyf?=
 =?iso-8859-1?Q?sH3njgVGKfFe6ICSo/88smuZWEsm6jFtoVl+NdvjPHwhLDl2gnDPZl/oSK?=
 =?iso-8859-1?Q?6U+up67raTkOUE+CWZaWoxyWlPHakWwbIQQdt085dITJPVJ2kZlQq14WTQ?=
 =?iso-8859-1?Q?WvseKeKcbeB4rTYdi1ml+AznMMbPD38uzGrenA2R8/PZ4Oj3VPHSIvttVP?=
 =?iso-8859-1?Q?z6ORi1ec1X5duogd6yHc9yqcwqdTr3ZCk7Tkx4sToednO1DfYMRRWfaqeW?=
 =?iso-8859-1?Q?mH3d8zX7+9el02P9lEJ5S4F2uPG4T9jT6O1H58bbb0D9iDIcbZNMb/Qr1d?=
 =?iso-8859-1?Q?WqOzMxPIoQpaj1woAjA+5Nphp4d1hlld0xUXnNBtOkEbH14iu+i3WPtu1g?=
 =?iso-8859-1?Q?yTGvnJJTuVE15d82mZa2MeAtU9YTKjjo6qihx6eRmPkeOd6E1q7euNPJ9x?=
 =?iso-8859-1?Q?/tGJIH2UOFRfEASZx2uYnOq4VVbw9ba6poJf/QnNsx+4MVlPXYNJvev/9S?=
 =?iso-8859-1?Q?gDJnfszUPr+6emC9pU1XHSQhpm+hRE6CNHwp7bMwH5oHMAA4YmgwROBo1x?=
 =?iso-8859-1?Q?ZwDpSQo5OL9cP+uNdPyiHvkZcDSY64tY9rIH14TarlJzmFniIT+cMeYWpT?=
 =?iso-8859-1?Q?0kMaVWkRfizeIPo9jJR9m80g975kkdt6bD82Xi1fvGYpjsr8I2qEgRiBEk?=
 =?iso-8859-1?Q?2/uuZEZe/hmppNnMay+NXulIwDnjKjs1qrVsS0VOJHv9nW2gHkruZk6gz3?=
 =?iso-8859-1?Q?BjGAymus8yC8G3uHfqabO4nI87cWWfePw+iMn5BneJyiegXKe/7+5XihkZ?=
 =?iso-8859-1?Q?98FmOdjhVDlTci3DI/W42wRkrHSqqxefn62gakVbbF6TIj?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6005.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6542ab45-04bd-4e73-ad43-08df0f003172
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2026 05:56:01.3024 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U1+7NBAh3szhWwRwu22nsmjreEa77gx/fwqVpC7UxK2W2UKpokQ5WiCWVKSIkf/Q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9288
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

AMD General

With this fix, my following patch#13 could be dropped.

drm/amdgpu: allocate dma_fence slot explicitly for rearming eviction fence

The patch is Reviewed-by: Prike Liang <Prike.Liang@amd.com>


Regards,
      Prike

> -----Original Message-----
> From: vitaly.prosyak@amd.com <vitaly.prosyak@amd.com>
> Sent: Thursday, September 10, 2026 8:46 AM
> To: amd-gfx@lists.freedesktop.org
> Cc: Prosyak, Vitaly <Vitaly.Prosyak@amd.com>; Khatri, Sunil
> <Sunil.Khatri@amd.com>; Liang, Prike <Prike.Liang@amd.com>; Koenig, Chris=
tian
> <Christian.Koenig@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>
> Subject: [PATCH 1/2] drm/amdgpu: reserve eviction-fence slot at WPTR call=
er
>
> From: Vitaly Prosyak <vitaly.prosyak@amd.com>
>
> Root cause analysis showed that the previous workaround was fixing the sy=
mptom
> in the wrong layer.
>
> Problem:
>   kernel BUG at drivers/dma-buf/dma-resv.c:319!
>   BUG_ON(fobj->num_fences >=3D fobj->max_fences)
>   Workqueue: events amdgpu_userq_restore_worker
>
> - amdgpu_evf_mgr_attach_fence() had been temporarily taught to reserve/ad=
d
>   fence bookkeeping internally as a workaround.
> - This hid the real contract violation and made reservation policy implic=
it
>   inside a helper.
>
> Review clarification:
> - The helper-side dma_resv_add_fence-related workaround was only an inten=
ded
>   proposal sent for review discussion, not the final direction.
> - Final fix keeps fence-slot reservation explicit in callers and leaves t=
he
>   helper free of policy decisions.
>
> Findings from investigation:
> - drm_exec_prepare_obj() both locks and reserves fence slots.
> - drm_exec_lock_obj() only locks and does not reserve slots.
> - Existing attach_fence callers in the GEM/userq restore flows already re=
serve
>   TTM_NUM_MOVE_FENCES + 1 before adding the bookkeeping eviction fence.
> - The WPTR mapping path in mes_userq_create_wptr_mapping() used
>   drm_exec_lock_obj() and then called amdgpu_evf_mgr_attach_fence(), so t=
his
>   specific path could add a fence without pre-reserved space.
>
> Fix:
> - Switch the WPTR mapping path to drm_exec_prepare_obj(...,
>   TTM_NUM_MOVE_FENCES + 1), restoring the caller-side reservation contrac=
t.
> - Remove the helper-side reservation workaround from
>   amdgpu_evf_mgr_attach_fence().
>
> Why this is the right layer:
> - Reservation policy stays explicit at call sites that define how many fe=
nces
>   may be added in that execution context.
> - The helper only performs validate + add_fence when called with a proper=
ly
>   prepared reservation object, matching the existing drm_exec model.
>
> Fixes: 91a358fe99d86 (drm/amdgpu: dont pin wptr bo instead use eviction f=
ence)
>
> Cc: Sunil Khatri <sunil.khatri@amd.com>
> Cc: Prike Liang <prike.liang@amd.com>
> Cc: Christian K=F6nig <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
> Change-Id: Ibb2ec1f210a8c6e5d2a48ed9b8ec77c6dabddb7e
> ---
>  drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> index 68beccee9fc0..fe49aa4dc5ff 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> @@ -60,7 +60,8 @@ mes_userq_create_wptr_mapping(struct amdgpu_device
> *adev,
>               }
>
>               obj =3D wptr_mapping->bo_va->base.bo;
> -             ret =3D drm_exec_lock_obj(&exec, &obj->tbo.base);
> +             ret =3D drm_exec_prepare_obj(&exec, &obj->tbo.base,
> +                                        TTM_NUM_MOVE_FENCES + 1);
>               drm_exec_retry_on_contention(&exec);
>               if (unlikely(ret))
>                       goto fail_lock;
> --
> 2.54.0

