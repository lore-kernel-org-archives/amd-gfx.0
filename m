Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2819C48BF6
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Mar 2024 00:20:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4AC7911276A;
	Tue,  5 Mar 2024 00:20:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UnrQTR45";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2076.outbound.protection.outlook.com [40.107.95.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A66D11276A
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Mar 2024 00:20:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OtfRw8UPYU+SqpSgzXs/eaDrRdt7kYIn7Q2fPRnxk+kf9om/lgH/Iie6AX3YKHbbRyuXA7QKaFEtIYxUdu+ATpldJSD5sMd1bYw1ZsHuegMnR4uByNMo9RBrkLlQbGC5i77PlXa+Kfz9gJwB9TMwRvTUANV9qaqFOy/a8q0jvi9k/b56wp/H/48b8kgGBHays/X9EheX6f5y4dpoXwpnaxz3DXKFNjNCIYTd7xotxbNdPXUjoeqHibvvtq4lIcSWBPnCEE/blpyjd/mLi3idMZ++IqkSBnLVigoySZNeUiugbbzbWTUevCPPOoFXcoLVmedzm8tKvFcLwaglnKxArg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gK9vFmKdZxHjDulVDEgHybR4rQwk5dXyyrZGRkROejw=;
 b=ZOqmc6FZ/SwYxdVdOawF++w3+U6VnueWmz7T0Dx27gc9HNzokjQ2qLcz/v/q7U45Lt+3Ww12ymOWKbyKT0RePZmeRnOLZnouikMRCVfCtNpdiwj0M15RWdriCc4XNJi+L/7k+ryF22uGAbjmX37/EZvV2Inb5dvgpTvwAoLX3qK1Tj55yVA5T121+zTJgGE/BuCCF3v+MdvH0bSXGs7DJF1N7xYM7v2GNmMSZSZF6ybOX9I2i3eEvJuhuBM3aqSj2bweafbiEYkp86uTOmgG21F9x1wIjZy99tP/EPmqHjflbbS7R3sdpnOaF5yhAhsF2SNSKxxbgY4wl9sJn4+NoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gK9vFmKdZxHjDulVDEgHybR4rQwk5dXyyrZGRkROejw=;
 b=UnrQTR45+akjcacDbDuia4Ji0vC0kxCrpFS24E9vY6I3oNYHrxP4bkosEbXL+NyWdWBKGNKhyc26inc9Ladl6nDYBei7GCAiED6/LyCrj6/zE/yB7VjKyY/TpJAL7Bp6JAfoYNPTuPogA0X6ZFeN58zXDbc/nFuxQeO+E9cs+jQ=
Received: from CY5PR12MB6034.namprd12.prod.outlook.com (2603:10b6:930:2e::12)
 by DS0PR12MB6415.namprd12.prod.outlook.com (2603:10b6:8:cc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Tue, 5 Mar
 2024 00:20:14 +0000
Received: from CY5PR12MB6034.namprd12.prod.outlook.com
 ([fe80::351d:5a27:4dce:d4]) by CY5PR12MB6034.namprd12.prod.outlook.com
 ([fe80::351d:5a27:4dce:d4%7]) with mapi id 15.20.7339.035; Tue, 5 Mar 2024
 00:20:14 +0000
From: "Rehman, Ahmad" <Ahmad.Rehman@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Wan, Gavin" <Gavin.Wan@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Init zone device and drm client after mode-1
 reset on reload
Thread-Topic: [PATCH] drm/amdgpu: Init zone device and drm client after mode-1
 reset on reload
Thread-Index: AQHaboAW1uPVdB7cr0i8rS3s84Nd5rEoPWUAgAAKRZE=
Date: Tue, 5 Mar 2024 00:20:14 +0000
Message-ID: <CY5PR12MB60344BA3CFBEAA1BDD9D66648F222@CY5PR12MB6034.namprd12.prod.outlook.com>
References: <20240304220504.367278-1-Ahmad.Rehman@amd.com>
 <d4413128-92d2-4711-ae46-36369a495868@amd.com>
In-Reply-To: <d4413128-92d2-4711-ae46-36369a495868@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2024-03-05T00:20:13.844Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6034:EE_|DS0PR12MB6415:EE_
x-ms-office365-filtering-correlation-id: d79288ce-e3d9-4e63-2d33-08dc3caa072c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KlGOt9Vjs7b8J18+b422ZJCRxFFMaDsbwPHMVBRMDDT+yiZCGhhYd8wBCLcE7W8pYoH2rAynWsJEZ0CH97FPBKUy+serRPwfFrz6lFmJjJOUAQHl/Hnk4H8+1TSnkCoDBMEsqCJcYsHQtNqFvvd213SUZbVUa8SEfP3EsYOiEaLPvxIW9x2JAtzpqyAUJWCdtiByRU21ZkuQCUN8qsgNUZSXhFb6qr90rPXNKH75+EQJxgxRrieqNrB+yL8suwAeLNpqlmbGoEMdC1Cix7wjaGoYPVX/IXFg5kpzycBsDGQKhepxbqLkAar8gitUQEE4iDoyn+VsM4+eYs53QUmZQ6Vjo9rjL94jrLDwotaiwwIXIPXtledqnE90JESiG3HPwtnzn2Kw3gc6UGdOzmYLfPHPZSL/5/sDj9TDIjSi+vLp4ZAhdQfHUk+Wdx6meomLS5copkwHRJxWLNBxWvoaJ8/q0luqtPWTvociZn4A371k5lS67NUWAx3Dk288745qMsqVws2OgSx9pnNFfsMSH67ZKLEoOFoN5746S7/9eqbuCk3AVUSTgFTqslejso/jEjp6fgdxq3EOY96gFgKU+8BmUADNEt4ZaoczIM2tcNVmV43qfaJ91KBcoE6rLa0lebrton1BRNl6uQowqNXTuNGGy2E/yX0KYVJDRsqel/gDYa1wYbHWYhZ8HFDHluyFt3xunQNxZ/0isp/Abum9CGwarQcT915JWR02b+Pp+A8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6034.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?NHZWnNIDeMfmIfkCcIIOy31O4l8bA2TfnvR9cXvBR2hvozuh5yu/5yVTkL?=
 =?iso-8859-1?Q?lOfR91GsmzYwtBDGgok5uC1j/C8VQE2/B7mMjNgZ+S8mNBZkULWrZB9B9y?=
 =?iso-8859-1?Q?e2p+9fJbmFuFG42T0FBJsGL7tcpartg10qU7KiUq3VDMxgNH3mB6nnclKB?=
 =?iso-8859-1?Q?Zhy2KxhmcKrh7vQ7XZXaoXOqoOtmRCo462yDPtxFpgNbbo5CHo6lSD07S7?=
 =?iso-8859-1?Q?cdX9CTZD46GlIQXtJZRJFKUD2/oOH/D8K4myfbq48xlqX1U5qfOzH3v/1Q?=
 =?iso-8859-1?Q?Y8CH+eMR86ZAiCs2OGNrspENW2EToVg5QLzDgQPW6dOGN7/yWfB7Xu3snK?=
 =?iso-8859-1?Q?MbZ8XY5SollO/ctazer457TNbHVp+LwcOR7QKAYzk3CeUXUrEyu+TkKCbb?=
 =?iso-8859-1?Q?5cfaxRQrPyf/MB/0lRJmWTErXDvxmjM0C15BZqxTvBNX6PNM6Utihdx6EJ?=
 =?iso-8859-1?Q?tArwDXqykC9dfKxY6tJEhK8LJ2M3laig5rvM4Pr93eLS/qC171WAzgGPuH?=
 =?iso-8859-1?Q?8RXA7xHM6KuJ8ab0viLLbJ4YkJCqOEiICwSpC+4+BI3Qewq/lYZMiAHFOS?=
 =?iso-8859-1?Q?tPl2sqSHd3vC2DzAI4rEABlrDkrq3/TUk3uCuCeE/cMpHKziy1FIoM/2nr?=
 =?iso-8859-1?Q?46usZwHy8togDbJfQMCfisxiC/y3XccHLFQUT7LU01phqDsFznLBJdykAQ?=
 =?iso-8859-1?Q?tsL9biUkHGR+ylAwpggOqwk+pPd0IocoslZBx72pTQ2QlWDXVmwpwBgH4q?=
 =?iso-8859-1?Q?GYMPfUPbQsR8Vt2usQGu4X2+jmiel0L82TQUd+jUiVLPA59gQ66aqczFGY?=
 =?iso-8859-1?Q?c3GegDRIaVcNo+6TKemkVviOEh3jnffYVI/XHngLOkDflQWpsX/vY52Bbw?=
 =?iso-8859-1?Q?oonP718hbX8GbgDDo0Kcq9LSCl3D5b0h4Bb0NPOvPPjD5Wo5UwCfeDl5de?=
 =?iso-8859-1?Q?dgVb6ypfv6veFQk9DZbTTTYYrNslxa2FWo35nznmxdJleaOmAvySdklQN6?=
 =?iso-8859-1?Q?9MiFEphDTxwVlyTOG6znYARDNufKXSg4mGaBSl2jYTxxfd9UujMPD9rM2E?=
 =?iso-8859-1?Q?aHE5PsI9CEu9OVUiihjDFCWnJf9CrrkzgubPAA7YvxAZALYVGyDq122A7+?=
 =?iso-8859-1?Q?S0YVzifFb3/4FrLQqHm407ElwRo3egxFOYL4YxwUAKF4W+vpq8Sr3+m4Il?=
 =?iso-8859-1?Q?WzhnlGubXk18YwRvPT/y34TDpp6vvKvGeP4j9QPs9t2jTFSbFL8ttz5eSf?=
 =?iso-8859-1?Q?EhLnJAvIa8rdlPwUxd3xl610Bg2KgBOmYoiQKhQFzdjdYgBrKd82NP0Hyo?=
 =?iso-8859-1?Q?nd2RmougUg3GrSamUBT876FT9zRG5eiRrFLhYLVCqJaJdxhaajWiZfYrVx?=
 =?iso-8859-1?Q?gcd1S5i1qCW2oOUyKjjaahvKc8m1RbtY9hiCmHmBmVfiO3uyHy1SGBDYrN?=
 =?iso-8859-1?Q?WzkkmdRhGvol/rTU/eK+tzJL7GJJgCYKvEGytUQyI2RxOODwVRkWiPw/Ev?=
 =?iso-8859-1?Q?PEsIrdAJwIh0xQzVs2bzZwgvPXvw7pvFCQMMC1oQyQAEpQHQ98/mxCUyr+?=
 =?iso-8859-1?Q?S3jdeF6NGZrLckfaT3kery9eH6fmJofTXmROKnJAQlDaSeiIVhUXzLJJ7W?=
 =?iso-8859-1?Q?e2VH8ZxXrBKiQ=3D?=
Content-Type: multipart/alternative;
 boundary="_000_CY5PR12MB60344BA3CFBEAA1BDD9D66648F222CY5PR12MB6034namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6034.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d79288ce-e3d9-4e63-2d33-08dc3caa072c
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2024 00:20:14.2004 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OM9v0yKYExjPdk2OHMyphsdY0xTpf2FsNQ3OXl3SfXYU7E9o/KI6c57XtXbvb/rW8ICDOxzi45WzAQ9p0FZtWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6415
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

--_000_CY5PR12MB60344BA3CFBEAA1BDD9D66648F222CY5PR12MB6034namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

Hey,


Due to mode-1 reset (pending_reset), the amdgpu_amdkfd_device_init will not=
 be called and hence adev->kfd.init_complete will not be set. The function =
amdgpu_amdkfd_drm_client_create has condition:
if (!adev->kfd.init_complete)
                return 0;
So, in probe function, when we return from device_init the KFD is not initi=
alized and amdgpu_amdkfd_drm_client_create returns without doing anything.

Thanks,
Ahmad

________________________________
From: Kuehling, Felix <Felix.Kuehling@amd.com>
Sent: Monday, March 4, 2024 6:39 PM
To: Rehman, Ahmad <Ahmad.Rehman@amd.com>; amd-gfx@lists.freedesktop.org <am=
d-gfx@lists.freedesktop.org>
Cc: Wan, Gavin <Gavin.Wan@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Init zone device and drm client after mode=
-1 reset on reload


On 2024-03-04 17:05, Ahmad Rehman wrote:
> In passthrough environment, when amdgpu is reloaded after unload, mode-1
> is triggered after initializing the necessary IPs, That init does not
> include KFD, and KFD init waits until the reset is completed. KFD init
> is called in the reset handler, but in this case, the zone device and
> drm client is not initialized, causing app to create kernel panic.
>
> Signed-off-by: Ahmad Rehman <Ahmad.Rehman@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_drv.c
> index 15b188aaf681..80b9642f2bc4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -2479,8 +2479,11 @@ static void amdgpu_drv_delayed_reset_work_handler(=
struct work_struct *work)
>        }
>        for (i =3D 0; i < mgpu_info.num_dgpu; i++) {
>                adev =3D mgpu_info.gpu_ins[i].adev;
> -             if (!adev->kfd.init_complete)
> +             if (!adev->kfd.init_complete) {
> +                     kgd2kfd_init_zone_device(adev);
>                        amdgpu_amdkfd_device_init(adev);
> +                     amdgpu_amdkfd_drm_client_create(adev);
I don't see what's preventing the DRM client initialization in the
reset-on-driver-load case. It only needs to be created once and that
happens in amdgpu_pci_probe. Am I missing anything?

Regards,
   Felix


> +             }
>                amdgpu_ttm_set_buffer_funcs_status(adev, true);
>        }
>   }

--_000_CY5PR12MB60344BA3CFBEAA1BDD9D66648F222CY5PR12MB6034namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;font-=
style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Hey,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof"><span style=3D"font-family: Aptos, Aptos_Embe=
ddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 1=
1pt; color: rgb(0, 0, 0);"><br>
</span></div>
<div class=3D"elementToProof"><span style=3D"font-family: Aptos, Aptos_Embe=
ddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 1=
1pt; color: rgb(0, 0, 0);">Due to mode-1 reset (pending_reset), the amdgpu_=
amdkfd_device_init will not be called
 and hence adev-&gt;kfd.init_complete will not be set. The function </span>=
<span style=3D"font-family: &quot;Segoe UI Web (West European)&quot;, &quot=
;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;Helvetica=
 Neue&quot;, sans-serif; font-size: 14.6667px; color: rgb(0, 0, 0); backgro=
und-color: rgb(255, 255, 255);">amdgpu_amdkfd_drm_client_create</span><span=
 style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, Cali=
bri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0);">&nbsp;ha=
s
 condition:</span></div>
<div class=3D"elementToProof"><span style=3D"font-family: Aptos, Aptos_Embe=
ddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 1=
1pt; color: rgb(0, 0, 0);">if (!adev-&gt;kfd.init_complete)</span></div>
<div class=3D"elementToProof"><span style=3D"font-family: Aptos, Aptos_Embe=
ddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 1=
1pt; color: rgb(0, 0, 0);">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
 &nbsp; return 0;</span></div>
<div class=3D"elementToProof"><span style=3D"font-family: Aptos, Aptos_Embe=
ddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 1=
1pt; color: rgb(0, 0, 0);">So, in probe function, when we return from devic=
e_init the KFD is not initialized and
</span><span style=3D"font-family: &quot;Segoe UI Web (West European)&quot;=
, &quot;Segoe UI&quot;, -apple-system, BlinkMacSystemFont, Roboto, &quot;He=
lvetica Neue&quot;, sans-serif; font-size: 14.6667px; color: rgb(0, 0, 0); =
background-color: rgb(255, 255, 255);">amdgpu_amdkfd_drm_client_create</spa=
n><span style=3D"font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontServic=
e, Calibri, Helvetica, sans-serif; font-size: 11pt; color: rgb(0, 0, 0); ba=
ckground-color: rgb(255, 255, 255);">&nbsp;returns
 without doing anything.</span></div>
<div class=3D"elementToProof"><span style=3D"font-family: Aptos, Aptos_Embe=
ddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 1=
1pt; color: rgb(0, 0, 0);"><br>
</span></div>
<div class=3D"elementToProof"><span style=3D"font-family: Aptos, Aptos_Embe=
ddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 1=
1pt; color: rgb(0, 0, 0);">Thanks,</span></div>
<div class=3D"elementToProof"><span style=3D"font-family: Aptos, Aptos_Embe=
ddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 1=
1pt; color: rgb(0, 0, 0);">Ahmad</span></div>
<div id=3D"appendonsend"></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<hr style=3D"display: inline-block; width: 98%;">
<div dir=3D"ltr" id=3D"divRplyFwdMsg"><span style=3D"font-family: Calibri, =
sans-serif; font-size: 11pt; color: rgb(0, 0, 0);"><b>From:</b>&nbsp;Kuehli=
ng, Felix &lt;Felix.Kuehling@amd.com&gt;<br>
<b>Sent:</b>&nbsp;Monday, March 4, 2024 6:39 PM<br>
<b>To:</b>&nbsp;Rehman, Ahmad &lt;Ahmad.Rehman@amd.com&gt;; amd-gfx@lists.f=
reedesktop.org &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Cc:</b>&nbsp;Wan, Gavin &lt;Gavin.Wan@amd.com&gt;<br>
<b>Subject:</b>&nbsp;Re: [PATCH] drm/amdgpu: Init zone device and drm clien=
t after mode-1 reset on reload</span>
<div>&nbsp;</div>
</div>
<div><span style=3D"font-size: 11pt;"><br>
On 2024-03-04 17:05, Ahmad Rehman wrote:<br>
&gt; In passthrough environment, when amdgpu is reloaded after unload, mode=
-1<br>
&gt; is triggered after initializing the necessary IPs, That init does not<=
br>
&gt; include KFD, and KFD init waits until the reset is completed. KFD init=
<br>
&gt; is called in the reset handler, but in this case, the zone device and<=
br>
&gt; drm client is not initialized, causing app to create kernel panic.<br>
&gt;<br>
&gt; Signed-off-by: Ahmad Rehman &lt;Ahmad.Rehman@amd.com&gt;<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 5 ++++-<br>
&gt;&nbsp;&nbsp; 1 file changed, 4 insertions(+), 1 deletion(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_drv.c<br>
&gt; index 15b188aaf681..80b9642f2bc4 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br>
&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c<br>
&gt; @@ -2479,8 +2479,11 @@ static void amdgpu_drv_delayed_reset_work_handl=
er(struct work_struct *work)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &lt; mgpu_in=
fo.num_dgpu; i++) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; adev =3D mgpu_info.gpu_ins[i].adev;<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (!adev-&gt;kfd.init_complete)<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (!adev-&gt;kfd.init_complete) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kgd2kfd_init_zone_devic=
e(adev);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_=
amdkfd_device_init(adev);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_amdkfd_drm_clien=
t_create(adev);<br>
I don't see what's preventing the DRM client initialization in the<br>
reset-on-driver-load case. It only needs to be created once and that<br>
happens in amdgpu_pci_probe. Am I missing anything?<br>
<br>
Regards,<br>
&nbsp;&nbsp; Felix<br>
<br>
<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; amdgpu_ttm_set_buffer_funcs_status(adev, true);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; }</span></div>
</div>
</body>
</html>

--_000_CY5PR12MB60344BA3CFBEAA1BDD9D66648F222CY5PR12MB6034namp_--
