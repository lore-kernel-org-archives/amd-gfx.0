Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6031C43458
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jul 2026 09:35:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F69510E5A1;
	Wed,  8 Jul 2026 09:35:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wJXfabl4";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010062.outbound.protection.outlook.com
 [40.93.198.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF21510E5A1
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jul 2026 09:35:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FuVuuIoK4s8SnqPy1SihN4ZP/jGv3XMF02OLuLndR6SH/9mOhldvjfLOzqUC/luLcOvQPzdPSCeXgk5Wx0V6qKRO3vdS2z1atPtuQFFZk288ejCY8FLrGsGwV2AfJkvItqBsyM0lagjRTOvaOZ8gM5NWmp7tVdxK5Cn9hrfpFXZQz+5H/vJ2iyopIbdzcuc/ufSDnGZ2dlTxdzAE9Jjgz5XBfHBe894Spkt8yA2QkK0vK869SEfOJbXGt56PZvjMUkGNf+1M4qaR9Yu4FuRU07aF/g9HU4V5ga2uA4EUbGx94GKCkNHRQXw+fj7jC3eByJbI4god5dShMChDOAR87g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AanoY3fRKtkgW8C6XlaZ+AB+YKlgzEvfsvs1RySUCjc=;
 b=IutJ9xVkm9waHByI/KML5hMXhjJ/9t4WifP75J9rebfvNOcTHppkVcVp8B1q5qbP72f4xx5n6Pku9k0WFDwKkG07LQ396628+StAEXUhr4lXIFqca8yo9o89p39JpNLTh56jxc7ssDdvg5QCFSpCqs4u0pBNscQrBpbae57v53n3U/rEGaguMfiEYBREoy4vsAgbeaOW9jzzPIb2YBLqLAQyjM3bau7T67SmzYAnltA38zEhzvWfvz8tigYSB0H4WFdA28NW+nilTwErh8F/rvCfZmQxIz7tjSPdHCoQpkOWkYVeZqGAgKMCXfOd1un/h2ppmGwT8SPZMirz0ALy2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AanoY3fRKtkgW8C6XlaZ+AB+YKlgzEvfsvs1RySUCjc=;
 b=wJXfabl4zHZvHDtomaPG1jBnLaTKFKXr38ZmSbEAP+BARr3UY4E35c/72kC58y9uDhnLkPCP1wJ7kHd7gLfi8VnNwQD1MvqTJTqj0e+ywRBr59F2a3YONMGA8s4zBKz5BijOkBzNzpoc+fTleZ/x+JYkjtViza8YvHn2/6jKXnQ=
Received: from DS7PR12MB5768.namprd12.prod.outlook.com (2603:10b6:8:77::18) by
 DS7PR12MB8203.namprd12.prod.outlook.com (2603:10b6:8:e1::12) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.10; Wed, 8 Jul 2026 09:35:32 +0000
Received: from DS7PR12MB5768.namprd12.prod.outlook.com
 ([fe80::5d2c:ba94:5102:679b]) by DS7PR12MB5768.namprd12.prod.outlook.com
 ([fe80::5d2c:ba94:5102:679b%6]) with mapi id 15.21.0181.009; Wed, 8 Jul 2026
 09:35:32 +0000
From: "Li, Chong(Alan)" <Chong.Li@amd.com>
To: "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deng, Emily" <Emily.Deng@amd.com>, "Chang, HaiJun"
 <HaiJun.Chang@amd.com>, "Skvortsov, Victor" <Victor.Skvortsov@amd.com>,
 "Lazar, Lijo" <Lijo.Lazar@amd.com>, Cursor <cursoragent@cursor.com>
Subject: RE: [PATCH] drm/amdgpu: improve the amdgpu device init progress in
 sriov mode
Thread-Topic: [PATCH] drm/amdgpu: improve the amdgpu device init progress in
 sriov mode
Thread-Index: AQHdDrQa3QpfXwgbKkOxqgf8xZxSzLZjVF4AgAAAzLA=
Date: Wed, 8 Jul 2026 09:35:32 +0000
Message-ID: <DS7PR12MB5768E74BF2292A0F8F87E0CE9BFF2@DS7PR12MB5768.namprd12.prod.outlook.com>
References: <20260708083035.186400-1-chongli2@amd.com>
 <d3ffa862-8fff-40cb-8779-97d3bb4a429b@amd.com>
In-Reply-To: <d3ffa862-8fff-40cb-8779-97d3bb4a429b@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-07-08T09:08:05.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB5768:EE_|DS7PR12MB8203:EE_
x-ms-office365-filtering-correlation-id: f6368a43-fffe-4ff9-73c3-08dedcd441b1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|38070700021|56012099006|11063799006|4143699003|6133799003|22082099003|18002099003;
x-microsoft-antispam-message-info: aIybJlKSy45eou/JkbVPm/ucPuZ2FCLMBOMymY2S29HTDqILeEr0049akAS6rf5trN2l0jFiqMq5qfCWLidloqXoJldxFDYQHQ2+g3DoFDY5t569J8RqoQT81gKBN1VJ1+Cmpp/EHvMYW7U2UQKJslHFyf4jDiLxdnzxHWqH1XUcctaNeGm272JASMxh3LvmtcIEUgPfvk3/d84dgRX7Zx0o8AunHp0WS8BIrefUSeXVHTIOQdgh7fWF9/Z1gq6gOohSWPpRGD5ORu9y1YKQHJlKWXBj7kTkK0Qcaorp2J2strjwkUYkR6FlZL5/loU3Wbl1Cs8EDZpBvVg48z+SxqBTO2bLtAXhY9BRItxuz1YSX2bF8TaThYnQLX8XvRCotDQISTZZENFUDLK1wzW+fK1kbiHxEb44exK81Y/MX04cSs1rj7/c5UiTZTz7Qz93fPfZF8A9HQZ+aXfOeN0oo6vZvYxpy55Nt9YFJ+iE8hGTtXOLzdyTsBz957FUlih619IkHEAtbxlkBsUmn7XGqmNwIaGnUlg2fObZ4EMEou6zgiRXWMcW9MT7eIlrtOkl19UqVa7aTCcNDZUGWIXDrRXKBngYdFkwypiTt35IINj/zh/jU0+8Y7rMR+TvxXyF8hrATgW0cu6sGLrw/0S3dmEUQLVbZYOoeqn8f5AwvbSnhJTiI9FO0dTHq2pP6AJKJpm5eKFxq1oy1oRA/LsP6fQeEj1jTerE/OPA32srpqQ=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB5768.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(38070700021)(56012099006)(11063799006)(4143699003)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2bi8rUV2hbNN5uazpCI6kmSaOc6XXM8ERemZXTdquMtShYUoMw3dkg/Ye/i/?=
 =?us-ascii?Q?oaYZIfO3KIyTD3mBnxPJGHCkiSVPquF4FqZqmld+C/Euu+e0g/tBeha1j6Z9?=
 =?us-ascii?Q?ER2Lhs9RvgLTUxzDwYUm0O8faaXxxWGstlfu8e1ZGizsGOEJURin0eCv7LnD?=
 =?us-ascii?Q?ucmM1gxmrfH5ojZJfbI8bgcMJO90n8nmuBk+IJJpyQ2N/Bb9nSzs2mQGX5ZB?=
 =?us-ascii?Q?Jli7C+/1jUsJv/ZEbWgx3Z4ZmEXLmD8PiKg8YUfE9hiGhE9q54eniPDqQnaQ?=
 =?us-ascii?Q?VvVN2WlcjIz4qE0m3xv/gFJjCTHHMw9z4RGw6LeDmCuyVYpzat1R4AnZ4t4l?=
 =?us-ascii?Q?BGH4dlrZE5WukapNA644LYDMlomFq/Wk7/SHv1xHOYVEwjsyCfzIk/TMThdf?=
 =?us-ascii?Q?zqhzPqFCQtrOSzFL0M9vExZkKzLTQOA0KpD2ErmrrAUUfeaoSBGirqOZDQiz?=
 =?us-ascii?Q?kOCNjcQzmXVi+KTf1JbQP81UqrYwFv0LykSkF/dozFZx3Ototimw+pDIS4sP?=
 =?us-ascii?Q?2RLl1ooEf7y1rgp34BuvLU7ZUxHb0kkG+YkwZ5wSBpt4u0FKOnHbuA2ynoVt?=
 =?us-ascii?Q?PGZteB2qjZ2KaXJKWqIULk4eJKKHp8QEMgic5m+9/I2SbvbKj0TcLD9MrmsQ?=
 =?us-ascii?Q?AT+8YNaHfdhCgv2nCQ1XuHy6EUb5ylzxIkr3r4WqriofLZbKJv+Szgz2w8qC?=
 =?us-ascii?Q?VC3+eZPQWfnZsBIPDa6szw89oEN1mQSWSpwuiSlw1Nj0bBku2eIv6idgaoSG?=
 =?us-ascii?Q?vdb4fiyM1JAngq0n124gWR0egJJL0BGcseYmiZV81fCNq871tdISVWNK4q2i?=
 =?us-ascii?Q?/nInd9grpyY36RX1K4nVmz9M6E9B+Db8w7IAorOTGw+vCurOSkTG9UeoA9IT?=
 =?us-ascii?Q?9uMhP2GJvpM4JRgVdc2clRqOQoeTotFizMUxQtUyEQF0aT2scDmgEGD2uQN6?=
 =?us-ascii?Q?hXVkdqfASqUVV4OvuJcCUweMJMGRF0QIx6fjDNrMvGdSJt9/QOBGlL4Dgg1n?=
 =?us-ascii?Q?ciqb6pPvNnaC1dpa3kPuAFk1llzmqNjFDdzAnThU4aQtWNCq+6sK+Dt5RnkS?=
 =?us-ascii?Q?2iAcrHJLen6l3u3pC9YsqY2LLe8R6DJkTXwR1GcIav4J7IPFSGs6ilC2KsfS?=
 =?us-ascii?Q?FIWRWvK+nSo5qx1pBlid6pm9Kf5utrTmcl4JWQoLf1OBC5zqrustcjd6cBF+?=
 =?us-ascii?Q?Po004+7w2cmbnIuqrBbvRCcq0WWtnGSoEz7T68nkDxah9U/DIakK5i/IhUXC?=
 =?us-ascii?Q?TATTAsR1BwD7B5Ernhb5a3ZyJzz9XzK1j9ZhU1LwLyz5Pi9ijo0uzvH6rJiN?=
 =?us-ascii?Q?uvEfeiEBlZjqrMqLYxTD9ZIC43L1NLfSL9avBzMeZukMtt+F7TIacM3ckDKN?=
 =?us-ascii?Q?PJdQkX+ikrVM00NIiOPU38XFGR1GDP7ADDgbcAd8Y6+LUpFsWocQec6Lxf8D?=
 =?us-ascii?Q?fFPH/S6vJlkEQdHVMh6U3CsJC2cJp6NXwGDj2Yxet+vKpmXnO76C0NgIv/aS?=
 =?us-ascii?Q?Uwjb91XFnQFzBCMBZxD9GB+bflha6kt4J64MB5BXt8QG1HKVVhFYsr5KFWy+?=
 =?us-ascii?Q?xLmHSkQv4bUnIyWyWU2LOit0J/vHGkgBmuos2Tz3Iu3wTxiri1iXO4li4zcZ?=
 =?us-ascii?Q?deE0LUFFOUEPn8MP9YmTEU35MDtEhCL8xdmGMp66vNGTZalN7l+pd60pzSW2?=
 =?us-ascii?Q?gRaMJV/k9AD4qK0pbdGglIX48H25STiNU+fY5FhgNoO3KQXP?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5768.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6368a43-fffe-4ff9-73c3-08dedcd441b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2026 09:35:32.6052 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UmYuKG2M0Mq0r8QyqZM9plGz8yv3mLY/vL1bLKn9/NThl3aLWDxQsAcxuyAJ9szCnxic4xUv5xydnyqAaqwXZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8203
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

Hi, Christian.

This version of the patch is not host-platform dependent; all host platform=
s follow the same path.

I verified this patch with KVM in my local environment and with ESXi on a b=
orrowed server.

Distinguishing the host platform was a mistake,
and I have explained the situation at the end of the patch email.

I have pasted the content below:

        Hi, Christian and Lijo.

        Sorry, I made a mistake.
        Host access to the VF FB is not platform-dependent. After the host =
driver sets VF_FB_EN in response to GPU_INIT_DATA, the host can access the =
VF FB.

        I borrowed an ESXi server and tested this patch there.
        The amdgpu driver works normally.

        I rewrote the background. Is anything still unclear?

Thanks,
Chong.






-----Original Message-----
From: Koenig, Christian <Christian.Koenig@amd.com>
Sent: Wednesday, July 8, 2026 5:05 PM
To: Li, Chong(Alan) <Chong.Li@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Deng, Emily <Emily.Deng@amd.com>; Chang, HaiJun <HaiJun.Chang@amd.com>;=
 Skvortsov, Victor <Victor.Skvortsov@amd.com>; Lazar, Lijo <Lijo.Lazar@amd.=
com>; Cursor <cursoragent@cursor.com>
Subject: Re: [PATCH] drm/amdgpu: improve the amdgpu device init progress in=
 sriov mode

On 7/8/26 10:25, chong li wrote:
> v2:
> Some legacy ASICs do not send amdgpu_virt_request_init_data().
> Only keep the full GPU access request early when request_init_data is not=
 sent.
>
> v1:
> Move the initialization of non-GPU resources out of the full GPU
> access region during AMDGPU device initialization.
>
> Background:
> In SR-IOV, the guest sends GPU_INIT_DATA, then the host enables
> VF_FB_EN and places early initialization data, such as IP discovery,
> VBIOS, and PF-VF exchange data, in the VF FB. The guest should then be
> able to read this data before requesting full GPU access.
>
> Before this patch, the VF still requested full GPU access in
> amdgpu_device_ip_early_init(). At that point TTM is not initialized
> yet, so the normal VRAM aperture mapping is unavailable and the guest
> falls back to MM_INDEX/MM_DATA register access. That register path
> requires full GPU access.
>
> Use the BAR0 framebuffer read path, amdgpu_device_read_fb_via_bar0(),
> for the early init-data copy instead of MM_INDEX/MM_DATA. This lets
> the driver delay the full GPU access request until after the early
> init data has been copied.

That looks like it goes into the right direction, but as far as I can see i=
t is still an ESXi specific change.

So once more: We can't adjust the driver to the hypervisor!

Either this works on all hypervisors or I have to reject the change.

Regards,
Christian.

>
> Signed-off-by: chong li <chongli2@amd.com>
> Co-authored-by: Cursor <cursoragent@cursor.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 21 +++++++++++++++++----
>  drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c      |  4 ++--
>  2 files changed, 19 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 610d82b79de3..ac66796e8634 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -38,6 +38,10 @@
>  #include <linux/apple-gmux.h>
>  #include <linux/nospec.h>
>
> +#ifdef CONFIG_X86
> +#include <asm/hypervisor.h>
> +#endif
> +
>  #include <drm/drm_atomic_helper.h>
>  #include <drm/drm_client_event.h>
>  #include <drm/drm_crtc_helper.h>
> @@ -1987,16 +1991,19 @@ static int amdgpu_device_ip_early_init(struct
> amdgpu_device *adev)  {
>       struct amdgpu_ip_block *ip_block;
>       struct pci_dev *parent;
> -     bool total, skip_bios;
> +     bool total, skip_bios, early_full_gpu_access =3D false;
>       uint32_t bios_flags;
>       int i, r;
>
>       amdgpu_device_enable_virtual_display(adev);
>
>       if (amdgpu_sriov_vf(adev)) {
> -             r =3D amdgpu_virt_request_full_gpu(adev, true);
> -             if (r)
> -                     return r;
> +             early_full_gpu_access =3D (adev->virt.req_init_data_ver =3D=
=3D 0);
> +             if (early_full_gpu_access) {
> +                     r =3D amdgpu_virt_request_full_gpu(adev, true);
> +                     if (r)
> +                             return r;
> +             }
>
>               r =3D amdgpu_virt_init_critical_region(adev);
>               if (r)
> @@ -2159,6 +2166,12 @@ static int amdgpu_device_ip_early_init(struct amdg=
pu_device *adev)
>       if (!total)
>               return -ENODEV;
>
> +     if (amdgpu_sriov_vf(adev) && !early_full_gpu_access) {
> +             r =3D amdgpu_virt_request_full_gpu(adev, true);
> +             if (r)
> +                     return r;
> +     }
> +
>       if (adev->gmc.xgmi.supported)
>               amdgpu_xgmi_early_init(adev);
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
> b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
> index 9a40107a0869..340703d89d6b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
> @@ -185,8 +185,8 @@ static int xgpu_ai_send_access_requests(struct amdgpu=
_device *adev,
>       } else if (req =3D=3D IDH_REQ_GPU_INIT_DATA){
>               /* Dummy REQ_GPU_INIT_DATA handling */
>               r =3D xgpu_ai_poll_msg(adev, IDH_REQ_GPU_INIT_DATA_READY);
> -             /* version set to 0 since dummy */
> -             adev->virt.req_init_data_ver =3D 0;
> +             /* Version is set to 1 since GPU_CRIT_REGION_V1 */
> +             adev->virt.req_init_data_ver =3D GPU_CRIT_REGION_V1;
>       }
>
>       return 0;

