Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D82EFCA192
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Mar 2026 21:37:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 183A710E5C3;
	Mon,  9 Mar 2026 21:37:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FsKOUDjE";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010059.outbound.protection.outlook.com [52.101.61.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1BEE10E5C3
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Mar 2026 21:37:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hmvLdLecLOXudYJeZQJjInn9kK9DfdT5xceeaHdiv0wVEGRwX4wjMqQwTFV3qrLjMD1gPT4FRu6mql8AyIehmTdIJtpDwwPxDTh1jVpYB0NcNhBFYAakZHF/EZfNSn6hLIjwzCOZ55Ekz+/fVA+isENMlRKoCIuaT78mn9r1wjYgqlS7Ku6eS/XOU/Kr1GVePVVCOEb+Pzeuh16XGXRu8vIjY+7RJEVLs7mRr9bcuj+MdNW19E4d55V3V503lhSx1xfkjvhkMDtpGUcIpjPTxrtpLJVqiYEsdfSaWjwpic/PuWRdC9IVpaFhHLSL8MgKMSdy4G6SNE2pCZjgOQ52YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BaArG/ndOUI67QAFNlPJ/4k5PTu7v6aPXqkHsKHvsws=;
 b=n0xzrSPP+o+rX3Gnmbt05X6HlAqvtT5ZEwFDhwqM9kg/njKWfv9FnNaY+AV/OD/Bfvw8QJT5Nag5++UxBabc+dGSVEVwb70awIMex1YI6Xwb2mUe55sxUkCUJgcuo09OWE8F83z+R3ZtnkGc+h21pKKNUesGVZTzy0jbADv9nZ1NnlLcNW5sreu1k/Ss9f29z8hiWSy+y6mzhnp9sFouWqqWfw5jxOHuEQFpkH8GZ3aGxvr6B6tT6iw22yadhg51LhwhX+37fAvyWuvBnngC4+AfZd5i6QSePM2yTFqIScZL+d2kjSZNy4RyuDBFto52upB1kOjxDxCCxVjf1P2diw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BaArG/ndOUI67QAFNlPJ/4k5PTu7v6aPXqkHsKHvsws=;
 b=FsKOUDjELajZ3Cvhb4JXDy+7OOGMya1XL1zc/mmVcwL83judemR8QXGG9ITTCVH+11eb8ozegyeH1CmVaraLyHjQya2kErMpMqwxKKFpNr2mdg3kuEb5iStanW106Lb+UZv8TfqETPpsALGiKSaXqfrVcvUl8KO9Sbq5eFzjwBg=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by CH3PR12MB8483.namprd12.prod.outlook.com (2603:10b6:610:15c::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Mon, 9 Mar
 2026 21:37:50 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::699b:1fb2:73:6a33]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::699b:1fb2:73:6a33%6]) with mapi id 15.20.9700.010; Mon, 9 Mar 2026
 21:37:50 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Xie, Chenglei" <Chenglei.Xie@amd.com>
CC: "Chan, Hing Pong" <Jeffrey.Chan@amd.com>, "Luo, Zhigang"
 <Zhigang.Luo@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH v2] drm/amdgpu: Avoid KIQ ring access during GPU reset to
 fix fence timeout
Thread-Topic: [PATCH v2] drm/amdgpu: Avoid KIQ ring access during GPU reset to
 fix fence timeout
Thread-Index: AQHcr+eR4ak5mfZre0W4PCSb6ujZvbWmuekw
Date: Mon, 9 Mar 2026 21:37:50 +0000
Message-ID: <BL1PR12MB514440E60EE90386DB56E50CF779A@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <CADnq5_OCRm7oVkr7TY_OCyfSnkPJXAY7ZhjThpEbAauQNz_T_g@mail.gmail.com>
 <20260309170950.1982724-1-Chenglei.Xie@amd.com>
In-Reply-To: <20260309170950.1982724-1-Chenglei.Xie@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2026-03-09T21:37:10.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|CH3PR12MB8483:EE_
x-ms-office365-filtering-correlation-id: 5b9b326b-634e-4065-8c49-08de7e241d39
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|38070700021|7053199007; 
x-microsoft-antispam-message-info: ftyVlP5cCMLnDNVoH1/gYkZLx9DfniV8Tssx8guA66IujeXydOfU5XmYuUFj12wI6yMrFf5802oDPyM/ff65FlOcxOH4I9N3QllhldC2b0naIZdfGkLMOcrOdVv/mo0MjoojJcabE7dwEzRrG3ukS0lXSHvNNaxSI3JbVNo2s/Inhj0IDVas14FTFs6BNNXkC3/5UH4h00/WHx2JTf0nWUekJCLkUZ5rcyKHk/PA2pMm+cPUZ71Kl8E0C9LsEe/m9R84LGiCep2SrG+lSZXrJz6Qj8/dFZbE16n/Qg4DV8j5xXG9aYoUyVv7Hz5BWM6MR3JTe+CB3Hai69huprfL0mfj9JbQkg7+W6D73wNWTwJjrHHiCxslC/i6hwN3fdC5uipfqksCnwITxgXEltZ8/uqksTQX3woLWoGQwHF9igZzUikxGHsoMgv7mx7bIX++zBiYiNfjEpymTgT5P6Q5TUIm7JEZoR6tgcAxAUEFPjUqnuS6CCs4FogTHD4YpsrSqScGhHIfzc5pCFm4lKkAntZz4guCAPiOVE5KHACqlFvlmKUmzwjB9kgtjbRHAOnYz4VSkMxT81qcwI6qaw1j4dAT6uRm5DjmPNZnZj7TQpQapOm0+azqcvx18VGj0S+PAOVCJ+lEmdbz7wTCWkd8EBxsDWysi7G4oIdfxGUM+mKyTerOYNn8QPrWclCyWVciRXUp6rrExshsjaehP9JOLwUl52GkOCPrBVcXmNiW+dmx9YVGLjWpvzmSqvSXXDE2y/qR3PtRVdQuUBkDOP9gpA7eQfVfFJQNuYi6ZinqBrM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700021)(7053199007); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dfhm0jeSU1D0tviXzLmbfjqr/TTQTCyjX69XtI5KasEo4K0aqiqmQHTeRGtx?=
 =?us-ascii?Q?eFIKth3b30cU/iy2bN/VrIkgq2N/pLk+w+zzWDaPwvs8q+Slyiu/74+P19hd?=
 =?us-ascii?Q?cLmu2VQ6J22VfDjE3LR4/umwRlQcLPMF7c796JC7HGmbKZEJZQiWcr/X2AbD?=
 =?us-ascii?Q?eOTy9YpnKKFORmLLJtTkqBtwn6AZTb96fNzTj5ANnVZz1B7oeXWRWkquEbnq?=
 =?us-ascii?Q?NwOT0JOJtzsGT60o7GVTJV/6eHGlDc0+gZbrRUZyxcRufymUtNPBTYPlasfZ?=
 =?us-ascii?Q?JORudsnIjquNApsLZOsuWRo4rQZ2UUbpUjCEjUNiGW6ZF10qdjF0TPnOgvWk?=
 =?us-ascii?Q?iifmtS0wFoOsoLjCNYYj8V9uj3Xh+xf2gSHq6YjoyJIvUkC/Q3UXkEHNjfMI?=
 =?us-ascii?Q?jt/buvrUAQJGMXTq/4Ems1UQdJdZytHHsjMz2NrL0rQBvZO47BIOI+oE4IAc?=
 =?us-ascii?Q?X4ciBtFftTVmB3bnZznlCOcpEpZDt1gGVIY9n2kXdorqOYdf2T2C5TjgBeAo?=
 =?us-ascii?Q?yxgdh2hBJvIXxEI3NGOPaQf5YJioFSbN5mGH2VemzetA9vV5nzvE+PPqRpa8?=
 =?us-ascii?Q?3cj+L6ui21l2B2ahN1G3p+ZoIWJeZzI1Ezs/aZYQxxBtBB/SbmeyKpMilEg8?=
 =?us-ascii?Q?xeAnocJ2W0VMhZk9AvbNAIcENLGDmn2aySld9HxkZaFUltvQ31XVyEa6nqJV?=
 =?us-ascii?Q?jp4YhGyjrQ8EsDDpn0h1tB/YgLwzKqgf5MSfRC463KichsdqaQVNs9AYbDP0?=
 =?us-ascii?Q?/3VVMzS3SyZT/sS+Jrx7OIjF2ED4JmtzaLZkrMmkpXb1W9GUFJ++W0OWL8JB?=
 =?us-ascii?Q?0i7gRFzHvwYRzyYDiaZA5zjUdOpHt+Zqu65iNTR+I9aacR7DpVL1P2lmlY1y?=
 =?us-ascii?Q?WJXucWjpK9A1zKSoude46Lqoacblo9v0bwn0w/4gRng0H7kgkEIRfSF39zbC?=
 =?us-ascii?Q?VC/kgWFjTRIu9TLjhYUKT7UPerqfjCGC/o+Mt+Aie/2utWXlDOydnCNEz9/x?=
 =?us-ascii?Q?Z6yhmUlN/ZrZTX/WMGUrFbQrprmZh7U8ECSWAOhThUYFP9jlBhBcW/l50y7w?=
 =?us-ascii?Q?WBANRtWhvZpT0+cwA4c31MsFmy5hA1fbNZRYwwFkZhZiwrVVHXI03g0tTmeZ?=
 =?us-ascii?Q?rQLpWz8RgWawUdSzoYrtoJ+f446ecK8F7kxLz9ZqMtfaaCt5g/d5loYQ1TSK?=
 =?us-ascii?Q?Rb/r5v92Zkga8UMaVnDFyhmfb+ZhluBkkoHBaKzXxriM8/LCILdfG6Mbgp8I?=
 =?us-ascii?Q?YI3ochEfK9eM1Q6/n5zHfopSGuI6pdsEiZtV80DmeyAiMs+6Rmfxy6WxlieU?=
 =?us-ascii?Q?TjOF++d7Bv0Pmlwu4s+LE71nBfpICwQ8zmmOi67Uq8geVvIzN/7lEe0x2Bpy?=
 =?us-ascii?Q?Y/8j9I52if8PDzlM3aVSEkj/LTXgZLeAhIMLv1dACwXJLBjAkLUiJFqVtmd+?=
 =?us-ascii?Q?NpvItN52TkxMA98bzIyRINeKS10BFc9wB2iRzv4h39MSN/h0h+512whOEPFg?=
 =?us-ascii?Q?7tVzvBmzl734oVICApxSzwdMnLHq7DsCaWAi5iPVgToAPO3XwyzNiqLecNnq?=
 =?us-ascii?Q?0zzPNJpECpwcylTN7aDhiJvwQte2aRkdixr33j8lHyTRamarj3jxqAVxPeJ5?=
 =?us-ascii?Q?6xb263SD6OazAHrOJ8Wlr9g8vHt2dXocqOcFX9sEOZJlqH5F8AapM42fFuLc?=
 =?us-ascii?Q?F/ZUPddViyd1VrwrMqT/YEQaAPbgA1Uk3kGRzeHATNCB6qYf?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b9b326b-634e-4065-8c49-08de7e241d39
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2026 21:37:50.7337 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9peYyWoTOjW1IEsJp8ZmqbrrHBP4P6WFNxzn8dLcCqqx0KggNpVrzoBQPFVDftfS++FJVAsZt4xb84HeFhQ85g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8483
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

> -----Original Message-----
> From: Xie, Chenglei <Chenglei.Xie@amd.com>
> Sent: Monday, March 9, 2026 1:10 PM
> To: Deucher, Alexander <Alexander.Deucher@amd.com>
> Cc: Chan, Hing Pong <Jeffrey.Chan@amd.com>; Luo, Zhigang
> <Zhigang.Luo@amd.com>; amd-gfx@lists.freedesktop.org; Xie, Chenglei
> <Chenglei.Xie@amd.com>
> Subject: [PATCH v2] drm/amdgpu: Avoid KIQ ring access during GPU reset to
> fix fence timeout
>
> After GPU reset, the hardware queue is cleared and all pending fences are=
 lost,
> but the fence writeback memory stays stale. If the driver keeps submittin=
g to
> the KIQ ring during reset (e.g. HDP flush), sync_seq advances while write=
back
> does not, so amdgpu_fence_emit_polling() waits for lost fences and hits -
> ETIMEDOUT, blocking further KIQ use.
>
> Fix this by skipping KIQ ring use when in reset.
>
> Signed-off-by: Chenglei Xie <Chenglei.Xie@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> Change-Id: I717df52ed0ef0bb51a6901f218191d9837a77f6f
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 10 ++++++++++
> drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c |  3 +++
>  2 files changed, 13 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index cab3196a87fb1..0021e763b753a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -1124,6 +1124,9 @@ uint32_t amdgpu_kiq_rreg(struct amdgpu_device
> *adev, uint32_t reg, uint32_t xcc_
>       if (adev->mes.ring[0].sched.ready)
>               return amdgpu_mes_rreg(adev, reg, xcc_id);
>
> +     if (amdgpu_in_reset(adev))
> +             return ~0;
> +
>       BUG_ON(!ring->funcs->emit_rreg);
>
>       spin_lock_irqsave(&kiq->ring_lock, flags); @@ -1202,6 +1205,9 @@
> void amdgpu_kiq_wreg(struct amdgpu_device *adev, uint32_t reg, uint32_t v=
,
> uint3
>               return;
>       }
>
> +     if (amdgpu_in_reset(adev))
> +             return;
> +
>       spin_lock_irqsave(&kiq->ring_lock, flags);
>       r =3D amdgpu_ring_alloc(ring, 32);
>       if (r)
> @@ -1298,6 +1304,10 @@ int amdgpu_kiq_hdp_flush(struct
> amdgpu_device *adev)
>       if (adev->enable_mes_kiq && adev->mes.ring[0].sched.ready)
>               return amdgpu_mes_hdp_flush(adev);
>
> +     /* Avoid KIQ ring access during reset; caller will use
> amdgpu_hdp_flush fallback */
> +     if (amdgpu_in_reset(adev))
> +             return -EBUSY;
> +
>       if (!ring->funcs->emit_hdp_flush) {
>               return -EOPNOTSUPP;
>       }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> index 20e1395b39882..f9db2b17105b7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
> @@ -876,6 +876,9 @@ void amdgpu_gmc_fw_reg_write_reg_wait(struct
> amdgpu_device *adev,
>               return;
>       }
>
> +     if (amdgpu_in_reset(adev))
> +             return;
> +
>       spin_lock_irqsave(&kiq->ring_lock, flags);
>       amdgpu_ring_alloc(ring, 32);
>       amdgpu_ring_emit_reg_write_reg_wait(ring, reg0, reg1,
> --
> 2.34.1

