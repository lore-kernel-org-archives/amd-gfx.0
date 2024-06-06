Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 657D6C27C54
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jun 2024 16:56:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C09410E1E3;
	Thu,  6 Jun 2024 16:56:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rL1WpTTo";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2040.outbound.protection.outlook.com [40.107.244.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D28810E1E3
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jun 2024 16:56:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jUpiUofSDG/JYRjXImAeJqKmPpOVJs66ut9yJ4EFFvP6YFSZbOv154ONJwmRBoUjDDG4ufW+u0AFfhDcZ44oFh7SLenqXX7f4fg/imU02HxHmDxgd1DWduxJZUqkIty/WQMlXQC6UU/bhfAm2OmVG9lm/e3NUVeQk0ofghxwCAAOdkgoG02QoGUWgP3mO4erGZj0R9aJS3I6un4K91mQyb39E87TlN1o0n4mEV0iHZdlgTHDVNn3HqrO209kvVJyF6PF6jPj25NAongWhBsUI3x8Mb3TxVeBXhTCERvz+jTbQYto72RvL1mYuqY6W3YoJpsw66Wehnem0hJJt+tNjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kMA3PBg6viDTJ7uRZQ/BR+jr7WI2CdEpZBd7bZ+dsRg=;
 b=F4UN6JKEmd4MUjhXk9fhYwBcSvJ3wRHiHQKhdxa7KRcJuXXKG44l387AWELyNSVob5PqJTGUzZfYKWdCcl6xny0DVFhQjk6BXjsmqc7HwdBnip7WDpX54yXM5/dVmXoGV4xscYo7YrZYCVpC6PMf7084kOhguV3sH4aQ8sobS4oexm65GwsloT3R+WwUO5AZb6tdj/rnZIPWFd/ojKMWbemLa1n/LQLoCYzh1bmGHRu78IKLmmvgM3ijPAR7uuyLVHpaj1Bdk85WYY9Fz4gpYaXi5lK9OqtU0/VaVlgP7o/lJQkSjfBVLrIbDtBxLg6ANhRGSFPZ+LPdqLFALa/WPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kMA3PBg6viDTJ7uRZQ/BR+jr7WI2CdEpZBd7bZ+dsRg=;
 b=rL1WpTToAmf703Zg0g9bD1KEJxuFP3zMidf8kKFgCQWwQKPy3c1p4MhQ9GrnHLNY8hqhunmNOP0/HKKCo9KsKbDG5FJz38QaU6FbRAim0naGlTxvRA+LwXs2ILDP8+KBimw9r/SaulKHTlmdMWS6fFSYYe7SG4D+aqVQx1EV50c=
Received: from BL1PR12MB5898.namprd12.prod.outlook.com (2603:10b6:208:396::7)
 by PH0PR12MB7094.namprd12.prod.outlook.com (2603:10b6:510:21d::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.33; Thu, 6 Jun
 2024 16:56:32 +0000
Received: from BL1PR12MB5898.namprd12.prod.outlook.com
 ([fe80::989a:c38d:3dc7:97b7]) by BL1PR12MB5898.namprd12.prod.outlook.com
 ([fe80::989a:c38d:3dc7:97b7%5]) with mapi id 15.20.7633.021; Thu, 6 Jun 2024
 16:56:32 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: "Joshi, Mukul" <Mukul.Joshi@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Deucher, Alexander"
 <Alexander.Deucher@amd.com>, "Joshi, Mukul" <Mukul.Joshi@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Add missing locking for MES API calls
Thread-Topic: [PATCH] drm/amdgpu: Add missing locking for MES API calls
Thread-Index: AQHauDHVeXdaWpoJBU2cSgwX4JW/iLG69GEQ
Date: Thu, 6 Jun 2024 16:56:31 +0000
Message-ID: <BL1PR12MB5898C513B0D9E4801B920F4185FA2@BL1PR12MB5898.namprd12.prod.outlook.com>
References: <20240606165100.2821320-1-mukul.joshi@amd.com>
In-Reply-To: <20240606165100.2821320-1-mukul.joshi@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=cb56e961-e762-4d45-8e07-835299815ad1;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-06-06T16:55:50Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5898:EE_|PH0PR12MB7094:EE_
x-ms-office365-filtering-correlation-id: fd3f4148-aad4-4c66-eb4b-08dc86499dea
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info: =?us-ascii?Q?SPgWVSIhULRpfGPW8+UKqNqu5Be8kx4HQTkacn/HurDHNKOHzh/Abuupk6ih?=
 =?us-ascii?Q?j3FIWSM2+U4kM/p/muY3s4Mf0VTCM2DyJbKBn2n53yRkvA7xRBl5Xhy5NKa2?=
 =?us-ascii?Q?OXHlfbvnu1/5PxwI2emrTsm1Xn1KSxQFoo/1wRua7rmk48c9IX5eOmYUg30Q?=
 =?us-ascii?Q?k0BfMTM4KuQWgYU7UFExpw3sxrsTCzca26zcHou+d5GfgtCK6Z+pb3Z0bnrs?=
 =?us-ascii?Q?9ZjTBPexN+cucMSveTRNNdxLstdmiA5jDIO6D90frAxlY3lbL00OeP7dzpqp?=
 =?us-ascii?Q?B3vSyVeI//FZyQ7O18q8yl6A/41UmFO5BSNhjY/XR3pxWYSHiWrsfK2ny6PC?=
 =?us-ascii?Q?uXHAcoBHQPpY9DiL1exUTMf/nN57edznvhCXs6j/tGxI5lscp/fHxwhzAh3v?=
 =?us-ascii?Q?CBcMy7y970M9b8F/8q5LcTFbjVn29WzcJhRKQOatN9rfHuC0sGd3wRRi5dXG?=
 =?us-ascii?Q?umWj8ASNh12PwrBG9OR2uuj2g32nCiCMxfJt7XDFIzpTC3u8PoXoK6Cl6gEh?=
 =?us-ascii?Q?t7QHq9+nntA6Y+CwkeITL1PXHMyOS1B0x2d2M2rOdz5Kc0huWMoFF3bfDYG1?=
 =?us-ascii?Q?6GZ43OqV3FPd7oKvrLJBZnb3fj9u1/bPav3+qxpqDvmRobEFZT7Nibe5OiMp?=
 =?us-ascii?Q?pbC+62qRNx02K/yKfS/GTNRxNWcCiPeyAiJl8Er17q+VC5YCr6ltxlR13YOE?=
 =?us-ascii?Q?fctBNqpu2Fja06bbjcnSVWV7ed9EO4d92JfcmVva91rS6EjvExzP2wa46Md+?=
 =?us-ascii?Q?TvpuPw6Fxm+B4RYQamRxRxUCXklrwpsBApjUo9YasebTBczfJCTOgw6xwYEi?=
 =?us-ascii?Q?sxFDZthPlAGbq7iCqBqZ1Y7F+5hOck1Coh1g5mxBhv/XkHlzT8PYtnnZEbuB?=
 =?us-ascii?Q?t9BthC5PvlWV4HVyGP1GlEkN5+s2Is6MdvkPQ8oQu2CKHKFN01PEncqUcyTH?=
 =?us-ascii?Q?tCmB0cL4EC5JFo7bn8zea8TcFTRdAnfZdNRwuUPG/z2aajjYYgg60SUwlBbg?=
 =?us-ascii?Q?ewqlaQ0d2eMxZxx3RwvtslbvhGzo8w3DmQ/rcWmgcaaxG/tWA1zORuIvT1FQ?=
 =?us-ascii?Q?+6toC4saxgP58CqYei6pc6tv6iWWYxAQXvixd5g0biero0XrGE7IvrkipGmP?=
 =?us-ascii?Q?cEqhohnB9sh4XMUusBOO7EdeYpZr8v1sJxy98Xte7sbyVWVXJRPNoI6Xw6Vi?=
 =?us-ascii?Q?PD/R0+cWwPed3ZVoUNwrpqKmzFOMwBNEFiRAlzP2KA9mVBDOEidLbFeMKnzr?=
 =?us-ascii?Q?+RWbIgwTOfbWGYDR2UBWi5cojxDqIREzTc1q9LPDWWGPun5bqwAY2j26vofx?=
 =?us-ascii?Q?uvWdsocLI8hc2UXqx+tPQ+rLcB/mpfMyvpsqsXoeYnzk5teAKHZ5GOzMqXr9?=
 =?us-ascii?Q?ADIFzqY=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5898.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(376005)(1800799015)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yDKRCVxpQjZGKfkGtsBP99sgwW01rw1B+r+dwO1hmbhD5f5K+o8/MhW7j2UO?=
 =?us-ascii?Q?tmIgRTcWDKwHtSNCKnHvJy2Rc+9BJj8rFqH2YPDxtjL/3/euRK1FbVQaUzwC?=
 =?us-ascii?Q?hreF870xS/04cs/I2pKnRS5BGRifIXIqMeShY37V2OsW5gPpUPcXUcR6hG3E?=
 =?us-ascii?Q?P5Wp2Wjv4zhz3EaEEhhJp+Kvrow9ACl6vyxWdHmu2iIIpU/p17JwGzFudYPr?=
 =?us-ascii?Q?WxGgG3UV7+drvtZC0nY61QTzg8arJLZ1MjKvB7eRtRjjwZ08yew4LQsbJCe7?=
 =?us-ascii?Q?f1HagoZJD1XXYQ6fjLbru+nZsAc/1eBsm1kIQwkXyxn8Jg2cwb79LbUWlxCn?=
 =?us-ascii?Q?ss9dXxOvfxnP1TMzxus+yPg8vpRe0Gmkex9UJy8dGzPf8tLzvw5i+LNEPcRz?=
 =?us-ascii?Q?ruaMzr8Fj2+Q4axJCuUYkii5XT1aJtc3S9C5Z1DMkbCICfmi8F2cSLdp6vzL?=
 =?us-ascii?Q?WWGMu8UKHakPvA2q2wpr3wNnda1LU2f9dxNlVt2K030+a9UPwbohxUBXiGjL?=
 =?us-ascii?Q?lMmWmkl1Ov8VgvRmxfV3uD0deIiYk7GvjYlz0igHqkZvSe1OKe1S0kAj7XRZ?=
 =?us-ascii?Q?JHZO6yeVsbEATJkBD87r4rOHnEhbdvehhnsc9BP5zw9unRqRFUvVpckgXAy2?=
 =?us-ascii?Q?iE+VUUbbw32ezOGPFuDbFoVIVWYvPKiRZ4X02drumLkVTsTw1uSOAZ5CzHt1?=
 =?us-ascii?Q?pJw/v2zgEztQm1IZKDiCeIkJtg3Uck5ZvpYRw7Z+m0TuDYTcuoziQa6IWzhE?=
 =?us-ascii?Q?zL1kLhLXiC2DR4bWMrAli30Ai7HSXEoF7CFTWJB6Rr3P4xATxr1NuHwI9xI0?=
 =?us-ascii?Q?pqjWhOc6B66ZnM+dCjZhZO7oABTS/UWKKzwgtAPQ/SxYCK7msVGj1G+Pu5CP?=
 =?us-ascii?Q?6jySNbkVRs9wOA5aaGkJ70jpz9HD98w2GdGIZzWXcpsp5+tx8KyBIIy3Qdlb?=
 =?us-ascii?Q?51ZCPLOK71QP/VFQ0ALVHoR7zVm8UlG8hU0LOL8wavBQvMePMVOMg9olY88Z?=
 =?us-ascii?Q?qWFhH5fQj4jnsI4HK9LQRsRigBuylMyJd0lyX6dLoow3R2eIW65zICs6Sedq?=
 =?us-ascii?Q?SbaOfEO/c5KaNwEZFkpNFUpBf0rPl0aNBjHbLStCDR9qfztAH5sHo4yptHVb?=
 =?us-ascii?Q?l0K0ZD6D0M9+NCViCgbJml+3gVeYzrQmFDSCnGW+F7Gj9l42ISUgbP4gF5S6?=
 =?us-ascii?Q?2CoDC7acpywC5NMX/oQDhnacrSGKNkCgX5CsI+LCrgweYEHBVa3CG7MFP/Fj?=
 =?us-ascii?Q?eRVSySqUDs+uOdKNbWKFTt0c10xEgkkRuGkfl3EsOazOpOolOLJ5rKhJSuDY?=
 =?us-ascii?Q?gGq3dt0o88YOJkgITc7L1eZ/pLhruBOyUc7VygBTVn/MCBpjG2fItTZpKgLG?=
 =?us-ascii?Q?LGarN+ZcrnlDQlIlTZDrpxOIDHE6gCydGkgHaD185VKKmSuncBCTW4aPAX2y?=
 =?us-ascii?Q?ewfHS5QVeSR2DhJ3QVWGzCadr7CviHhEfvFhhZZbyFGYO/lTSNRqB6ukkTCN?=
 =?us-ascii?Q?mh0Zmh6itGGRrRIrXGBv5Z55P8rCz+C/uDkuCAU2XKEpEvO29SkxNbzOrHTb?=
 =?us-ascii?Q?uNVZj7/NPEQu0X4267A=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5898.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd3f4148-aad4-4c66-eb4b-08dc86499dea
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2024 16:56:31.9873 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tQUQGYh7go9ZZ8nHinS6SBt3N7xhSHOihUNzsainxbdn3kL+vF4ZtaQqW3MIcv/DPvv4WfhXIn6tZUu/kkoTeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7094
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

[AMD Official Use Only - AMD Internal Distribution Only]

> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Mukul
> Joshi
> Sent: Thursday, June 6, 2024 12:51 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Kuehling, Felix <Felix.Kuehling@amd.com>; Deucher, Alexander
> <Alexander.Deucher@amd.com>; Joshi, Mukul <Mukul.Joshi@amd.com>
> Subject: [PATCH] drm/amdgpu: Add missing locking for MES API calls
>
> Add missing locking at a few places when calling MES APIs to ensure
> exclusive access to MES queue.
>
> Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> index 62edf6328566..df6c067b1dc9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
> @@ -801,7 +801,9 @@ int amdgpu_mes_map_legacy_queue(struct
> amdgpu_device *adev,
>       queue_input.mqd_addr =3D amdgpu_bo_gpu_offset(ring->mqd_obj);
>       queue_input.wptr_addr =3D ring->wptr_gpu_addr;
>
> +     amdgpu_mes_lock(&adev->mes);
>       r =3D adev->mes.funcs->map_legacy_queue(&adev->mes, &queue_input);
> +     amdgpu_mes_unlock(&adev->mes);
>       if (r)
>               DRM_ERROR("failed to map legacy queue\n");
>
> @@ -824,7 +826,9 @@ int amdgpu_mes_unmap_legacy_queue(struct
> amdgpu_device *adev,
>       queue_input.trail_fence_addr =3D gpu_addr;
>       queue_input.trail_fence_data =3D seq;
>
> +     amdgpu_mes_lock(&adev->mes);
>       r =3D adev->mes.funcs->unmap_legacy_queue(&adev->mes,
> &queue_input);
> +     amdgpu_mes_unlock(&adev->mes);
>       if (r)
>               DRM_ERROR("failed to unmap legacy queue\n");
>
> @@ -845,11 +849,13 @@ uint32_t amdgpu_mes_rreg(struct amdgpu_device
> *adev, uint32_t reg)
>               goto error;
>       }
>
> +     amdgpu_mes_lock(&adev->mes);
>       r =3D adev->mes.funcs->misc_op(&adev->mes, &op_input);
>       if (r)
>               DRM_ERROR("failed to read reg (0x%x)\n", reg);
>       else
>               val =3D *(adev->mes.read_val_ptr);
> +     amdgpu_mes_unlock(&adev->mes);
If we're following the pattern, this should go before the if/else block

 Kent

>
>  error:
>       return val;
> @@ -871,7 +877,9 @@ int amdgpu_mes_wreg(struct amdgpu_device *adev,
>               goto error;
>       }
>
> +     amdgpu_mes_lock(&adev->mes);
>       r =3D adev->mes.funcs->misc_op(&adev->mes, &op_input);
> +     amdgpu_mes_unlock(&adev->mes);
>       if (r)
>               DRM_ERROR("failed to write reg (0x%x)\n", reg);
>
> @@ -898,7 +906,9 @@ int amdgpu_mes_reg_write_reg_wait(struct
> amdgpu_device *adev,
>               goto error;
>       }
>
> +     amdgpu_mes_lock(&adev->mes);
>       r =3D adev->mes.funcs->misc_op(&adev->mes, &op_input);
> +     amdgpu_mes_unlock(&adev->mes);
>       if (r)
>               DRM_ERROR("failed to reg_write_reg_wait\n");
>
> @@ -923,7 +933,9 @@ int amdgpu_mes_reg_wait(struct amdgpu_device *adev,
> uint32_t reg,
>               goto error;
>       }
>
> +     amdgpu_mes_lock(&adev->mes);
>       r =3D adev->mes.funcs->misc_op(&adev->mes, &op_input);
> +     amdgpu_mes_unlock(&adev->mes);
>       if (r)
>               DRM_ERROR("failed to reg_write_reg_wait\n");
>
> --
> 2.35.1

