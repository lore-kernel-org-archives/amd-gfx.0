Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77DE7C77B73
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jun 2023 11:38:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9795010E335;
	Tue,  6 Jun 2023 11:38:29 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2047.outbound.protection.outlook.com [40.107.243.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 52B8710E331
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Jun 2023 11:38:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FFG66xAxjVv39LJZVacaNDd74Zcs1VBVUwRErcrh95bho1DsBKR1KIhmhTD4RLmNd1tp5Tz+9NoBYOKwiA1omZSw98G9CTIsvivVrQo312dMMzJzUioCTLuPRM7D+vKN8vyTrV1y7CBZyaVzvMSjgqLut2fh7vna0F2qxUhFNj71owKaeUWXrZi8BosyfZ0bo8rTmhMycn9OupJ86+SEoJtv5y1Wtj4xo87DvorLVGAFLEWgTK7ayT+xjYd7S75kF1t0NYYwauYFaM3zlGIKzX+0ORD5+va5D8MfAd/qTQFNyDh5MmPFlnPT+GvKcyTc8rFijGrYX96ntV+ZtI8gwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hndyikwm7UiDv0JN2UpE2avMtoaFMLFsa/VjsVnntLQ=;
 b=GjPVUJqkOSW0oRUGrSoo/Hd9mkWg5F9YOoiERFxsL7e+bY4L5M2LA+aUiQd9GFRDFCkrgGkQnf6W62ss99g69bkY2DkM7OL8JUkOP3ee//b76zT9JmtiJoCCXEZxVKhzxB3e2xl7dlCrFXoQ6UHXUtemiyPH8eG7F+AorvOcgb0qXdH1j8w2LYXyTTwKQvP6vVCMMk4F/o39kMoNjB5R9idKvX22Z6sWvXn78SREeMzDKcJZZXR29kPGk1rho6+t60oX7uHzcjJPXUhoy4NlNM1jp3lcvqpakAobCNMNALTpRDZYy8u4cKbhhT4CuicR3kDWeMsQKv22Ge+/bgoloA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hndyikwm7UiDv0JN2UpE2avMtoaFMLFsa/VjsVnntLQ=;
 b=HpOslpeQVnS+r6qT0B/FMP+kfCvPkAXXMMvKvHo+LyIt8Rg4V2fn/BWm8eUEKZAufbpzNj4ZBr5efpyRc7F/it2uYzMngLHjhywBUbvJkhINmTfKps4KnDaMQIhMMErp99df7kaw8RbP8+POfSCPI7jUzQrHNkBqCSWgGRREXb8=
Received: from DM6PR12MB4250.namprd12.prod.outlook.com (2603:10b6:5:21a::9) by
 IA0PR12MB8975.namprd12.prod.outlook.com (2603:10b6:208:48f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Tue, 6 Jun
 2023 11:38:25 +0000
Received: from DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::994f:fee2:62e0:d10f]) by DM6PR12MB4250.namprd12.prod.outlook.com
 ([fe80::994f:fee2:62e0:d10f%6]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 11:38:24 +0000
From: "Yu, Lang" <Lang.Yu@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: unmap and remove csa_va properly
Thread-Topic: [PATCH] drm/amdgpu: unmap and remove csa_va properly
Thread-Index: AQHZf+jtGTpiMocoTEWaUbTZk9pYqa991NwQ
Date: Tue, 6 Jun 2023 11:38:24 +0000
Message-ID: <DM6PR12MB42507D5CF368D8A2D3BF4D13FB52A@DM6PR12MB4250.namprd12.prod.outlook.com>
References: <20230506070302.246369-1-Lang.Yu@amd.com>
In-Reply-To: <20230506070302.246369-1-Lang.Yu@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=b33265d7-6deb-48c9-b10d-7af3e476aa99;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-06-06T11:31:09Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB4250:EE_|IA0PR12MB8975:EE_
x-ms-office365-filtering-correlation-id: 6f3dd1b6-da6b-4b17-5bbf-08db668289f4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3/EPm9+lVlCEQgzPjklEdvmshGULJpKvZQlaxRWvC75YcDwNGpuAO9ip/qUG7bCLQ84gXUHrmBWxFbFHYBvVFBbS2/6UPnBFYVW4XrnEzsYucO83fdtNVlmHG2IoLwjcfj5j3QIFrmyPzJLS91qOHtx5/y55FmQrBYY4Yus3p8hPdV51f3svN5+DEo64A/JKchx9O/qEfoi1uJ1y+ugdZCNCMV5BTuHBEe2aHJkkQm4zaoFaqua2Etx4maODoaUrYnPhupW7Ptr3IRh1u3NapUAiYJdNgr9v+gZWNgG0LN3vI8pX1pPqhkgxtl5ZV/kXkI/NQ8W04kn6addAeLvsXSYkk3cu3Ap/dmFkwMzA7PZj4zJy5WirlhKofaLCnOFZN/OctkzoWGCxxh1BJAZHqbDTyVwAfWMLov2Ybrp62qUGeRrCOZFKBxVlrTQpAoWiPpmYOAM1KKkNz8VvC6TFAORsehTJ9d48YGOI8WtintAAuBrQR3DB9MPAXtKbvipVEI2Ebm2mBKqKkn/a/xmsHn0VxuIEXuyOWXzJSsulLIAFkurYDZsH5jRoSY0J5yUbMZS83RgN0qOWN++6Lr1J8ooeMbIbReWpKkvC6nJcRkV3aj457qGV5PR9Lqcx26J0
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4250.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(136003)(346002)(396003)(39860400002)(376002)(451199021)(71200400001)(7696005)(2906002)(66446008)(66556008)(76116006)(64756008)(122000001)(66946007)(66476007)(110136005)(8676002)(8936002)(5660300002)(38070700005)(38100700002)(52536014)(86362001)(41300700001)(33656002)(316002)(55016003)(478600001)(26005)(6506007)(9686003)(186003)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6pAUBPMdIepG4GIAAmtj3uir5qWVaXxfWpuOhPM4B5UgCSbrodZfLY4EJHld?=
 =?us-ascii?Q?W5RVDKVV6cUnWVmLgnmp3lXv0yVhQZopvSc7Uj6fr7UriaVXOOyL6OjG+G6P?=
 =?us-ascii?Q?TH/gIDf2urJ0umnHcOW9PqB0PjlvrsNB3yEsHJ1yLrcXvUON0qS1h21otXqq?=
 =?us-ascii?Q?nTcjv/RXiChe13Pzas3wH9OJig+8WQk2Vn1nHh20cIkWARz4lFd8fy8ml1G1?=
 =?us-ascii?Q?7RrfDPeX+LCjWhb4RunKr6Yo9O9+k5tKIYoJvX/UO+IO9eKnvoAXeuZbr27N?=
 =?us-ascii?Q?sXd5ieuOtpBYCU1Y26o4uQwwC9P2jQWMyRKVtUp4Wj27c24D9pRuXfiQhg9R?=
 =?us-ascii?Q?f20V0Qj5I3I22akkbXUtPc58jb0GcoZa7Q/yMjLQHh41q2Rl6aO88guKjhaM?=
 =?us-ascii?Q?M2EBKUHp2BG6l1iEkCDKcsXVicrTfFRMxchxRw3GEn+U3oUsz1zBzqs2RVPs?=
 =?us-ascii?Q?1T3ZC6DG/fm63lFy5UiaBPLi24jMytfrAzgEe4SHDrTj3rLdfcGqcUHNWsgu?=
 =?us-ascii?Q?22Fq6/WzqgoVHy1ZYrzhoxC63aWU8EzXU+KyAtFdDo4WLT1/TzinWPMsAMSM?=
 =?us-ascii?Q?/1o7EDbIc7UZuxYH5ZotFXHOodxB0Herw2Kiws/Iv9TXgq0JfTNqbFv9Dj0N?=
 =?us-ascii?Q?k0lwWek5rks/bFrodmuLeb/3CxoRuyJxNBWY9iqTzWc4leTapCRX0l97MGlq?=
 =?us-ascii?Q?MSt29JjeWgyOO4iccWnWtosBMvQZ1SfjgXA+Jdv6raHJ2HrvCwqiLew+85TS?=
 =?us-ascii?Q?M+JCJrgfK8z3uNunvg+STVlcuNVVfEdrRk8ihdYn0Kn2bxpSPwG10JU03PyX?=
 =?us-ascii?Q?oaUbgc13ZnBMngf+xJGCe0Kc6pDh4lLfIVLFpgILWWwHGdnYaLKBAqcZvWdJ?=
 =?us-ascii?Q?Xc72NJKmSry42WR6I52+fcxcQSQntNFS/nTscg/7IRy3KX8feX/LKsz80KAB?=
 =?us-ascii?Q?Q5F/9a+nh8piVCgAYTOxQevNhQ82LaeAuO1S3X/D2g9BwICwpsQ/my/ujRPf?=
 =?us-ascii?Q?T7f/P9jS9XVUAhsdJ2T9q8GaeSn6yLWc5eQ9OKEnE2uR1ATuQq97IPqveAXw?=
 =?us-ascii?Q?yJa9BuOZuWuOsLkCtFT3ypobMqZ2DhjdQ+SVo9+DNeG4/Il5XFucBv3+bHbk?=
 =?us-ascii?Q?WO0v8R9UiFf21hDRhaRoa7gDAnXT+5VlWLSiHIpIPZJfYxhSARISBAjPVWNR?=
 =?us-ascii?Q?bT4Zd7ujFD1qaiWRW7rqafUFlhsVvKtC2L64BKrjQkw+8JAjA0GJ30qVBWS8?=
 =?us-ascii?Q?R3SMvzoSHtsdP299LeOuU/2qBNfuikP+aWheh5oGF5rqS+T7rPbv4tRHj074?=
 =?us-ascii?Q?E3vtO6W5+ngVrRwC4vzlXOccfwLTKW/wvxD8rg7kDxtEEN7JUu1hwOY9oozo?=
 =?us-ascii?Q?2BUM1mY4WeRGMgcDI1Cy/uza41sNkwvFJLRATDGAjEOZL2/SQ6AuFl+riBEm?=
 =?us-ascii?Q?mQJJxGe925//VALubH0/sz7faWscwYc2/EdMILlGzNFgYc7rHkFQuvI4izWo?=
 =?us-ascii?Q?BPwv1E/P3u56X/zijERbsvOsC2WGnQuyh557NMmg84NzzOkVvT6SR5zxoulI?=
 =?us-ascii?Q?UfFqIMDIBfZKxrfY154=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4250.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f3dd1b6-da6b-4b17-5bbf-08db668289f4
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2023 11:38:24.9029 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2oul+/luiZjWifgz6JdNKYWLbT1AP6cHJeXHCA7GgJ/MPZ/B3USM9vGVfNXHiVgJNhLGgBzTiJt2j4NRDgNaOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8975
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

Ping. Hi Christian, what do you think?

Regards,
Lang

>-----Original Message-----
>From: Yu, Lang <Lang.Yu@amd.com>
>Sent: Saturday, May 6, 2023 3:03 PM
>To: amd-gfx@lists.freedesktop.org
>Cc: Liu, Monk <Monk.Liu@amd.com>; Koenig, Christian
><Christian.Koenig@amd.com>; Yu, Lang <Lang.Yu@amd.com>
>Subject: [PATCH] drm/amdgpu: unmap and remove csa_va properly
>
>Root PD BO should be reserved before unmap and remove a bo_va from VM
>otherwise lockdep will complain.
>
>[14616.936827] WARNING: CPU: 6 PID: 1711 at
>drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:1762
>amdgpu_vm_bo_del+0x399/0x3f0 [amdgpu] [14616.937096] Call Trace:
>[14616.937097]  <TASK>
>[14616.937102]  amdgpu_driver_postclose_kms+0x249/0x2f0 [amdgpu]
>[14616.937187]  drm_file_free+0x1d6/0x300 [drm] [14616.937207]
>drm_close_helper.isra.0+0x62/0x70 [drm] [14616.937220]
>drm_release+0x5e/0x100 [drm] [14616.937234]  __fput+0x9f/0x280
>[14616.937239]  ____fput+0xe/0x20 [14616.937241]
>task_work_run+0x61/0x90 [14616.937246]
>exit_to_user_mode_prepare+0x215/0x220
>[14616.937251]  syscall_exit_to_user_mode+0x2a/0x60
>[14616.937254]  do_syscall_64+0x48/0x90
>[14616.937257]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
>
>Signed-off-by: Lang Yu <Lang.Yu@amd.com>
>---
> drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c | 38
>+++++++++++++++++++++++++
>drivers/gpu/drm/amd/amdgpu/amdgpu_csa.h |  3 ++
>drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c |  9 +++---
> 3 files changed, 45 insertions(+), 5 deletions(-)
>
>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c
>b/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c
>index c6d4d41c4393..23d054526e7c 100644
>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c
>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c
>@@ -106,3 +106,41 @@ int amdgpu_map_static_csa(struct amdgpu_device
>*adev, struct amdgpu_vm *vm,
>       ttm_eu_backoff_reservation(&ticket, &list);
>       return 0;
> }
>+
>+int amdgpu_unmap_static_csa(struct amdgpu_device *adev, struct
>amdgpu_vm *vm,
>+                          struct amdgpu_bo *bo, struct amdgpu_bo_va
>*bo_va,
>+                          uint64_t csa_addr)
>+{
>+      struct ww_acquire_ctx ticket;
>+      struct list_head list;
>+      struct amdgpu_bo_list_entry pd;
>+      struct ttm_validate_buffer csa_tv;
>+      int r;
>+
>+      INIT_LIST_HEAD(&list);
>+      INIT_LIST_HEAD(&csa_tv.head);
>+      csa_tv.bo =3D &bo->tbo;
>+      csa_tv.num_shared =3D 1;
>+
>+      list_add(&csa_tv.head, &list);
>+      amdgpu_vm_get_pd_bo(vm, &list, &pd);
>+
>+      r =3D ttm_eu_reserve_buffers(&ticket, &list, true, NULL);
>+      if (r) {
>+              DRM_ERROR("failed to reserve CSA,PD BOs: err=3D%d\n", r);
>+              return r;
>+      }
>+
>+      r =3D amdgpu_vm_bo_unmap(adev, bo_va, csa_addr);
>+      if (r) {
>+              DRM_ERROR("failed to do bo_unmap on static CSA,
>err=3D%d\n", r);
>+              ttm_eu_backoff_reservation(&ticket, &list);
>+              return r;
>+      }
>+
>+      amdgpu_vm_bo_del(adev, bo_va);
>+
>+      ttm_eu_backoff_reservation(&ticket, &list);
>+
>+      return 0;
>+}
>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.h
>b/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.h
>index 524b4437a021..7dfc1f2012eb 100644
>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.h
>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.h
>@@ -34,6 +34,9 @@ int amdgpu_allocate_static_csa(struct amdgpu_device
>*adev, struct amdgpu_bo **bo  int amdgpu_map_static_csa(struct
>amdgpu_device *adev, struct amdgpu_vm *vm,
>                         struct amdgpu_bo *bo, struct amdgpu_bo_va
>**bo_va,
>                         uint64_t csa_addr, uint32_t size);
>+int amdgpu_unmap_static_csa(struct amdgpu_device *adev, struct
>amdgpu_vm *vm,
>+                          struct amdgpu_bo *bo, struct amdgpu_bo_va
>*bo_va,
>+                          uint64_t csa_addr);
> void amdgpu_free_static_csa(struct amdgpu_bo **bo);
>
> #endif
>diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>index 1d3b224b8b28..6b47ac3eb40d 100644
>--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
>@@ -1307,11 +1307,10 @@ void amdgpu_driver_postclose_kms(struct
>drm_device *dev,
>               amdgpu_vce_free_handles(adev, file_priv);
>
>       if (amdgpu_mcbp) {
>-              /* TODO: how to handle reserve failure */
>-              BUG_ON(amdgpu_bo_reserve(adev->virt.csa_obj, true));
>-              amdgpu_vm_bo_del(adev, fpriv->csa_va);
>-              fpriv->csa_va =3D NULL;
>-              amdgpu_bo_unreserve(adev->virt.csa_obj);
>+              uint64_t csa_addr =3D amdgpu_csa_vaddr(adev) &
>AMDGPU_GMC_HOLE_MASK;
>+
>+              WARN_ON(amdgpu_unmap_static_csa(adev, &fpriv->vm,
>adev->virt.csa_obj,
>+                                              fpriv->csa_va, csa_addr));
>       }
>
>       pasid =3D fpriv->vm.pasid;
>--
>2.25.1

