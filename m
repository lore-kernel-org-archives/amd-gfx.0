Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93A4BC77B7A
	for <amd-gfx@archiver.kernel.org>; Fri, 26 May 2023 02:15:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 217B310E1A7;
	Fri, 26 May 2023 02:15:33 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2054.outbound.protection.outlook.com [40.107.212.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 75C9510E1A7
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 May 2023 02:15:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QuJB9jgcy4F0PPqIU6gDsYNeGMiG+G6JFoNca+8X6PmvRblYVcL0eDlRCEhHOEzg173mVAbP5fw9byDW2JwEy0HybRc5gcBQGl4vbE8hqFGcKVNfIc7VZoXzlxLqS9KKRdcRwCSGdBqO6U/gN4ZKVYwg69KAf609o181WCOmaeAHGPe6YUyK54nHh66NhlY7yI2bjp7CjPCnsp0kYd8DPI2/kF06SjMyowQXq0L9JuqNVkZn8fr2fX1L4gFZ9o/qfpEgxn19DnR2t75LArqOFbT856RxWTlxpw7i7b4xYhPw6CoywqnLeHrinx/6QbWNlbJiZXBK6/Bd/3uMHIJ9sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TW0vnrAkyzZwDU9YCn8IJZNrFZ/URx+ISMupOHaKZzw=;
 b=mVknb0B/HF6MVvNmFiyFU/xsxMVXDpIdDElCouQgIfa+eaiS7CDMBHTRpefTF1CZH75f0mwyaE/cAZaz5piCTnGLyMLrNKnNvqwdW11bx2FMCuvtV+3zqO8fglvSqEtT2dT562j740VD0gcQjnpz6nNhNTVRVuWScdZ/eEGrl9w83sZWmKibmc5ehGUxp1ct3IYzLbmA3jSGZrm6LMWCc5fCwEXEsrKSwn4XKgmcEF6dbYpec2Dyr4Pc6w1eUAkCaC3gBXEV9EerJ2RLBFSuBKsGWk4iTItOFEhVrM8zkgqLBogVI8Ca13g4qggIeNMGBftTc8VbzRtO3km6FRE/kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TW0vnrAkyzZwDU9YCn8IJZNrFZ/URx+ISMupOHaKZzw=;
 b=AGp7o/hb8P5iRQ+Eng+QR9u9mfcKme9Z05NT/x5tszaIuGOCw1vGtMwyMe01HlZVag0WVTICPoyYN2v+vv4jnd5DTS0SOETD8nES4oqEIE+gOU7OSJV2BkbLgUkjRkcsQMHWRiXwAe9N0wWcw8kTfmbLSqyte6L+GnbKpfWx8NI=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 IA0PR12MB8279.namprd12.prod.outlook.com (2603:10b6:208:40c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.17; Fri, 26 May
 2023 02:15:28 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::33d9:b6ae:36f1:e374]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::33d9:b6ae:36f1:e374%3]) with mapi id 15.20.6433.015; Fri, 26 May 2023
 02:15:28 +0000
From: "Chen, Guchun" <Guchun.Chen@amd.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Deucher, 
 Alexander" <Alexander.Deucher@amd.com>, "Zhang, Hawking"
 <Hawking.Zhang@amd.com>, "Lazar, Lijo" <Lijo.Lazar@amd.com>, "Yang, Philip"
 <Philip.Yang@amd.com>, "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>
Subject: RE: [PATCH] drm/amdgpu: add a flag to indicate if a VM is attached to
 fpriv
Thread-Topic: [PATCH] drm/amdgpu: add a flag to indicate if a VM is attached
 to fpriv
Thread-Index: AQHZjiFvsi2ABPirc0m6/xzzWHxDGK9r02lQ
Date: Fri, 26 May 2023 02:15:27 +0000
Message-ID: <DM5PR12MB2469C5EF3566C8D7B142CC0DF1479@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <20230524092326.1941139-1-guchun.chen@amd.com>
In-Reply-To: <20230524092326.1941139-1-guchun.chen@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=bb307f11-394b-4794-8029-d0163807ffbd;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-05-26T02:15:03Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR12MB2469:EE_|IA0PR12MB8279:EE_
x-ms-office365-filtering-correlation-id: ef59d779-4df0-468b-d828-08db5d8f1279
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: v11qyRvgBJW03fxUILnS3/tjZ9YY9VhRQEx0ET773esuzTr/OOCFgllNzNyN2CFBCKUDcuKL1r0U4nzZWP9B/y+ZOEs6kJ90wsXcC4Nm3+2UYdoJbfkbZhj2/AUAMypQI4AvSyii7IY39Ny6XNYIg/Y2GftSLv60aKQOZdYrQStZuzwQbvQ6tMFVgmFw9f6hej0a7VgwndY7949A/qGCjIyepFRTgX8/rQiouTAS73c3L+F5t7pJKk9jl7HeBaTjCepAmtpiEqz9V//cMCKq0g47lIge5qELo4xYclJ1r0rtXyS+Rlgs4TbgRRKFpaDDhfysHbJCTcHIkmGT9xc0OMn1cwL7JsZnxKlbF65mNS9KYNREPC8aOY7YAt/DzxRc2LeXjMbl9DuYV9acjQ/BsvZ8Wtf2lXjhrrQPLGJxBJ/NOpq5/xFxO8B8VdEG3oWT7dcPFK80rs4+tJR7CIcXG7CIt3ljrW6hRBS2Y7hKA2TTOUTf8G+mvBy91slXYhnX857oSQIqOeV4X+48ucgkT4XOiyltGd/p+KDhWHM+9YCuP8rkWwUYtCz2DHCCbC4f4cIcLi/PLmZiFnc+S+dvyOWIZUUD2NhZhn21MqP/f0IQ/6ijLToy/yjCfAyTDzL3snd2OmDDUQlpXNd3pVitHg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB2469.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(39860400002)(376002)(366004)(346002)(136003)(451199021)(8676002)(2906002)(41300700001)(8936002)(5660300002)(52536014)(66476007)(64756008)(76116006)(66946007)(66556008)(66446008)(6636002)(316002)(110136005)(71200400001)(7696005)(478600001)(6506007)(55016003)(9686003)(186003)(53546011)(26005)(83380400001)(33656002)(86362001)(921005)(122000001)(38070700005)(38100700002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?T4Ir+3+nfiflkE0A42mgDw7Jd1NnG3ap8PXoen7C93XrKLDxkyfHz7fyf0xc?=
 =?us-ascii?Q?InitiHHBJACr/LPy6t+x3I6dHWQKpeMJmIAfZTz+0iVUIiSadJWf73CJyUoE?=
 =?us-ascii?Q?GfG5nlaupp8ZLEk5vkmGzcgC37Zyx259++Qd0ziZIBW0US2OgBMLFZ3dXgQq?=
 =?us-ascii?Q?XdQ2/YvbsZQpl8IOsDYb5N4+qnrdQYARoeUautuQo9LeEvvFbe/TqQ5JjXJa?=
 =?us-ascii?Q?358Llb2OH8tOCU66ozWIYc9CFHyK1u1+lnO0qXLoM0Qy6Otc46A4pdQEAPbY?=
 =?us-ascii?Q?ptGcAlihVvBMZcEuL+o7A+LV2hPl7ZGZrvP4DSs6DIHUNFqNpv+1+VAb1LIj?=
 =?us-ascii?Q?tBQj0nTosyN1Mnql8g5LFd5H7aEryEZcnezi9HzxYDU0Vs2+fqZBM6PWMcBU?=
 =?us-ascii?Q?rUuA0G4h2ze+yS6GGjn0qfzJh+FkQpzzRwL9aPbfOMMha6SyxvBYQpFczwyG?=
 =?us-ascii?Q?H4cI84+vER9yQ4YWWCzjxZJSi40iSvzVnh8p5EzO+70odb7c54Q7XWfFVlMu?=
 =?us-ascii?Q?kFzWXqq7OGUFwMnWsGaxQBiJR+K51fVBaTjuZ6/OoM75gOyPo7ZHywMukes1?=
 =?us-ascii?Q?qjRG+5yIEw4XTaOEX2U/LB8rIQ4i57bSE8afmFh7Pukr3RHUZoa3AAZanJDQ?=
 =?us-ascii?Q?eWNGP2AfP8C3L6530F6jAkKFqSq4IR4B6SDsrc4FTzVTxXAOgMfrhn0rnPUa?=
 =?us-ascii?Q?r1C7sObaY746dGjT416kpZ9Q8zrAU+PwmJdHzM3vff/9s5Sbo9j+4Xp+JqiQ?=
 =?us-ascii?Q?F2YsKSm5t+MMJfvk+VYVWZrVPVdHqHd0UBV10bzGsWRHie0mSXMIVI3SdUfc?=
 =?us-ascii?Q?miSjiff5V2swdhgpSR5S2bNEW+bj89Gf2k00t3qmpT+Po8TCNZGODz6FMAhS?=
 =?us-ascii?Q?qnGvPMy0wSlKBm3xR9YQWHOzZw8mXoGS3szN3mtUjQvuaAMEfoYzl8Mjmyee?=
 =?us-ascii?Q?+6Oab9Vej9MItcXFQRcxE6c3p2AvdtOW7BbaMiVDUZxyY6b4nxcbL1CmHPih?=
 =?us-ascii?Q?i8ofAeG0C9mFlvMC4yT3Eg2QO3EWykmjYFCniSWwDOmQtehh2tWj5WrKvHml?=
 =?us-ascii?Q?Ln1tWJlT6zDfb83zhFnTVSyS34WgWE5TX6erl27nme+0mcK32WzNOjNZBcRC?=
 =?us-ascii?Q?RT1wDKI+wGoID2nrR4hgQMGxc9BEhvSi72Nmmo3YnkFkAbUYa5PfehpH8+UJ?=
 =?us-ascii?Q?/Cv/MKOKPWz2Lt+OXAyOjJ61Yk+XVw0er2FRE7h8u8js7DN54wY4NIoiairo?=
 =?us-ascii?Q?RMr7PSgHdMHF1cvULiYVro0kaChvC0Ky0kY38e2ACf86lRON4hVUBp3LahXV?=
 =?us-ascii?Q?QzCUHy1ix1d6YW8hulxyqJ/KNE53r8so2HlZ7Htkc3sEV1b7IUoCxmdwx0hW?=
 =?us-ascii?Q?9DBfiOZLKkkobdcBDuLVu0SzWq79/EBH/7ge1/4zL1zarcdX2oH+beYvfOzy?=
 =?us-ascii?Q?0oKK8T6NBwnAjogO/fb+/Th9hO4Kjz9IKYlRSdZqesp1WS4k9PoR/0oKtRKr?=
 =?us-ascii?Q?ZDIGDCzM/P3JxYc1sqY2+UCL0U3/+5Yq+QLM1H+1++Llw2muhu9WmuVeMSjY?=
 =?us-ascii?Q?Z4cn8AmPJ0wsFd+03wc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef59d779-4df0-468b-d828-08db5d8f1279
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2023 02:15:27.4653 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h8x096aWIOeD7qOdnzzGSQm4L1bLrbdoZIq8UpQ94OgfllcdpMrIoRql/7JFCpWh4faH/zfNCgECrlYYq/9u8A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8279
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

Ping..

> -----Original Message-----
> From: Chen, Guchun <Guchun.Chen@amd.com>
> Sent: Wednesday, May 24, 2023 5:23 PM
> To: amd-gfx@lists.freedesktop.org; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Zhang, Hawking
> <Hawking.Zhang@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.com>; Yang, Philip
> <Philip.Yang@amd.com>; Kuehling, Felix <Felix.Kuehling@amd.com>
> Cc: Chen, Guchun <Guchun.Chen@amd.com>
> Subject: [PATCH] drm/amdgpu: add a flag to indicate if a VM is attached t=
o
> fpriv
>
> Recent code stores xcp_id to amdgpu bo for accounting memory usage or
> find correct KFD node, and this xcp_id is from file private data after op=
ening
> device. However, not all VMs are attached to this fpriv structure like th=
e case
> in amdgpu_mes_self_test.
> So add a flag to differentiate the cases. Otherwise, KASAN will complain =
out
> of bound access.
>
> [   77.292314] BUG: KASAN: slab-out-of-bounds in
> amdgpu_vm_pt_create+0x17e/0x4b0 [amdgpu]
> [   77.293845] Read of size 4 at addr ffff888102c48a48 by task
> modprobe/1069
> [   77.294146] Call Trace:
> [   77.294178]  <TASK>
> [   77.294208]  dump_stack_lvl+0x49/0x63
> [   77.294260]  print_report+0x16f/0x4a6
> [   77.294307]  ? amdgpu_vm_pt_create+0x17e/0x4b0 [amdgpu]
> [   77.295979]  ? kasan_complete_mode_report_info+0x3c/0x200
> [   77.296057]  ? amdgpu_vm_pt_create+0x17e/0x4b0 [amdgpu]
> [   77.297556]  kasan_report+0xb4/0x130
> [   77.297609]  ? amdgpu_vm_pt_create+0x17e/0x4b0 [amdgpu]
> [   77.299202]  __asan_load4+0x6f/0x90
> [   77.299272]  amdgpu_vm_pt_create+0x17e/0x4b0 [amdgpu]
> [   77.300796]  ? amdgpu_init+0x6e/0x1000 [amdgpu]
> [   77.302222]  ? amdgpu_vm_pt_clear+0x750/0x750 [amdgpu]
> [   77.303721]  ? preempt_count_sub+0x18/0xc0
> [   77.303786]  amdgpu_vm_init+0x39e/0x870 [amdgpu]
> [   77.305186]  ? amdgpu_vm_wait_idle+0x90/0x90 [amdgpu]
> [   77.306683]  ? kasan_set_track+0x25/0x30
> [   77.306737]  ? kasan_save_alloc_info+0x1b/0x30
> [   77.306795]  ? __kasan_kmalloc+0x87/0xa0
> [   77.306852]  amdgpu_mes_self_test+0x169/0x620 [amdgpu]
>
> Fixes: ffc6deb773f7("drm/amdkfd: Store xcp partition id to amdgpu bo")
> Signed-off-by: Guchun Chen <guchun.chen@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c   |  2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c   |  2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    |  5 ++++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h    |  5 ++++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 12 +++++++++---
>  5 files changed, 19 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> index 41d047e5de69..79b80f9233db 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
> @@ -1229,7 +1229,7 @@ int amdgpu_driver_open_kms(struct drm_device
> *dev, struct drm_file *file_priv)
>               pasid =3D 0;
>       }
>
> -     r =3D amdgpu_vm_init(adev, &fpriv->vm);
> +     r =3D amdgpu_vm_init(adev, &fpriv->vm, true);
>       if (r)
>               goto error_pasid;
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> index 49bb6c03d606..3be5219edf88 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> @@ -1345,7 +1345,7 @@ int amdgpu_mes_self_test(struct amdgpu_device
> *adev)
>               goto error_pasid;
>       }
>
> -     r =3D amdgpu_vm_init(adev, vm);
> +     r =3D amdgpu_vm_init(adev, vm, false);
>       if (r) {
>               DRM_ERROR("failed to initialize vm\n");
>               goto error_pasid;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 37b9d8a8dbec..47ffaa1526a0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -2099,13 +2099,15 @@ long amdgpu_vm_wait_idle(struct amdgpu_vm
> *vm, long timeout)
>   *
>   * @adev: amdgpu_device pointer
>   * @vm: requested vm
> + * @vm_attach_to_fpriv: flag to tell if vm is attached to file private
> + data
>   *
>   * Init @vm fields.
>   *
>   * Returns:
>   * 0 for success, error for failure.
>   */
> -int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm)
> +int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
> +                bool vm_attach_to_fpriv)
>  {
>       struct amdgpu_bo *root_bo;
>       struct amdgpu_bo_vm *root;
> @@ -2131,6 +2133,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev,
> struct amdgpu_vm *vm)
>
>       vm->pte_support_ats =3D false;
>       vm->is_compute_context =3D false;
> +     vm->vm_attach_to_fpriv =3D vm_attach_to_fpriv;
>
>       vm->use_cpu_for_update =3D !!(adev-
> >vm_manager.vm_update_mode &
>                                   AMDGPU_VM_USE_CPU_FOR_GFX);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index d551fca1780e..62ed14b1fc16 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -333,6 +333,9 @@ struct amdgpu_vm {
>       /* Flag to indicate if VM is used for compute */
>       bool                    is_compute_context;
>
> +     /* Flag to tell if VM is attached to file private data */
> +     bool vm_attach_to_fpriv;
> +
>       /* Memory partition number, -1 means any partition */
>       int8_t                  mem_id;
>  };
> @@ -392,7 +395,7 @@ int amdgpu_vm_set_pasid(struct amdgpu_device
> *adev, struct amdgpu_vm *vm,
>                       u32 pasid);
>
>  long amdgpu_vm_wait_idle(struct amdgpu_vm *vm, long timeout); -int
> amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm);
> +int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
> +bool vm_attach_to_fpriv);
>  int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct
> amdgpu_vm *vm);  void amdgpu_vm_release_compute(struct
> amdgpu_device *adev, struct amdgpu_vm *vm);  void
> amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm); diff
> --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> index cc3b1b596e56..16b3350aa896 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> @@ -502,7 +502,7 @@ int amdgpu_vm_pt_clear(struct amdgpu_device
> *adev, struct amdgpu_vm *vm,  int amdgpu_vm_pt_create(struct
> amdgpu_device *adev, struct amdgpu_vm *vm,
>                       int level, bool immediate, struct amdgpu_bo_vm
> **vmbo)  {
> -     struct amdgpu_fpriv *fpriv =3D container_of(vm, struct amdgpu_fpriv=
,
> vm);
> +     struct amdgpu_fpriv *fpriv;
>       struct amdgpu_bo_param bp;
>       struct amdgpu_bo *bo;
>       struct dma_resv *resv;
> @@ -535,7 +535,10 @@ int amdgpu_vm_pt_create(struct amdgpu_device
> *adev, struct amdgpu_vm *vm,
>
>       bp.type =3D ttm_bo_type_kernel;
>       bp.no_wait_gpu =3D immediate;
> -     bp.xcp_id_plus1 =3D fpriv->xcp_id =3D=3D ~0 ? 0 : fpriv->xcp_id + 1=
;
> +     if (vm->vm_attach_to_fpriv) {
> +             fpriv =3D container_of(vm, struct amdgpu_fpriv, vm);
> +             bp.xcp_id_plus1 =3D fpriv->xcp_id =3D=3D ~0 ? 0 : fpriv->xc=
p_id + 1;
> +     }
>
>       if (vm->root.bo)
>               bp.resv =3D vm->root.bo->tbo.base.resv; @@ -561,7 +564,10
> @@ int amdgpu_vm_pt_create(struct amdgpu_device *adev, struct
> amdgpu_vm *vm,
>       bp.type =3D ttm_bo_type_kernel;
>       bp.resv =3D bo->tbo.base.resv;
>       bp.bo_ptr_size =3D sizeof(struct amdgpu_bo);
> -     bp.xcp_id_plus1 =3D fpriv->xcp_id =3D=3D ~0 ? 0 : fpriv->xcp_id + 1=
;
> +     if (vm->vm_attach_to_fpriv) {
> +             fpriv =3D container_of(vm, struct amdgpu_fpriv, vm);
> +             bp.xcp_id_plus1 =3D fpriv->xcp_id =3D=3D ~0 ? 0 : fpriv->xc=
p_id + 1;
> +     }
>
>       r =3D amdgpu_bo_create(adev, &bp, &(*vmbo)->shadow);
>
> --
> 2.25.1

