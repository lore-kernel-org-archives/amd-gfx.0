Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76501C282EC
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Mar 2025 14:44:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2065510EA03;
	Fri, 14 Mar 2025 14:44:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nvbKcowc";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2058.outbound.protection.outlook.com [40.107.101.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 128F210EA00
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Mar 2025 14:44:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D3bgexLdTCZLP5irjOC9BY3Na1vSflMIKAOmmle4mf5bf8ylabotFDLdApDFz95REAPouA4I1FobrDnpNbjZ7kO705bGg7l30HsO3rAw+1mSbtT5oT2y8dM2NwtKT1okhUGSldn1WSa950+y7r/IrSOVRhr4YvDondgcllm69wk6vgE5Fsr+RT1p4EAzhh/voxv7KUcDNyRzMnxPdrhKapej6rl72wKkBD7mXO2mH/KiTyQf1OVNwip+V3e5uK6nXqCLMWGYihJkQY1p6hIzu6JXZjaeE5tV2YdqgZoyOXmlxuwyLlElOhvGvXyXzmb98/ck7SuynRP2psCs7KTp/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JdS0wO/5VDG2DC3dcPe1GI33wH81iSR0a2WnlteSQeA=;
 b=iMg4xYGtYFBt6JYYEf73/PYy2t7H7pFXRZp00BiDETHkttiHs8K5DIQLZj/u7Al+NtDw1gFiuQ6ZQV5A1qNm8Fr86aJzELEJ0zu+0WdbnohrknJQe4RfhoPz5J94MYQS1FOwmCc0U74dDra4uv/R40wpV0CS2lSlYnY53iSq/qDrI+fM/6LizO0tm2Ssbu6OqWzyDfNnhvEpgEK7qhWzh8G4GH0qfDwih1CfNzonQguZeATgGKqhU4Kgmih9BSH4nimI5dt9MJwKmAG3FdhlkeBJDIuyDMzG8pBNiTmcachjTBV36yVMMLkJ0ktsCdGlVApbWH5O+1lfX0sE7WsfMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JdS0wO/5VDG2DC3dcPe1GI33wH81iSR0a2WnlteSQeA=;
 b=nvbKcowcJHARsW/vj+i4j/tZrhzxqFgk4/cxWy/sLMFouIit2EdorIp6nkvG0I6C4eHlv/0MfA2NNWmD/jZ23fNZyjhleCogWHSK91i7FVOJIEyMwTeAe3D1M+k7qI5lSL2QFq/npEAxosv1HEHkBcahIfFx47y2JcQ+DL4jFak=
Received: from BL1PR12MB5898.namprd12.prod.outlook.com (2603:10b6:208:396::7)
 by BY5PR12MB4147.namprd12.prod.outlook.com (2603:10b6:a03:205::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.28; Fri, 14 Mar
 2025 14:44:15 +0000
Received: from BL1PR12MB5898.namprd12.prod.outlook.com
 ([fe80::989a:c38d:3dc7:97b7]) by BL1PR12MB5898.namprd12.prod.outlook.com
 ([fe80::989a:c38d:3dc7:97b7%3]) with mapi id 15.20.8511.026; Fri, 14 Mar 2025
 14:44:15 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 3/3] drm/amdgpu: don't free conflicting apertures for
 non-display devices
Thread-Topic: [PATCH 3/3] drm/amdgpu: don't free conflicting apertures for
 non-display devices
Thread-Index: AQHblHy9M/Zv2ehCk0+gO3qc690Xa7NytgNw
Date: Fri, 14 Mar 2025 14:44:15 +0000
Message-ID: <BL1PR12MB5898C99ADC04DDC34CEE4B5985D22@BL1PR12MB5898.namprd12.prod.outlook.com>
References: <20250314010152.1503510-1-alexander.deucher@amd.com>
 <20250314010152.1503510-3-alexander.deucher@amd.com>
In-Reply-To: <20250314010152.1503510-3-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=5e272740-7f77-4dbc-a997-04f9ae92bf69;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-03-14T14:43:47Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5898:EE_|BY5PR12MB4147:EE_
x-ms-office365-filtering-correlation-id: ca6a80c8-ef14-43de-fd79-08dd6306b19a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?px3rb3y7bXfTVVoAnWijJhCqvD8T+dIAwjqGPEju0QWVI33+PhIRIlK4Pwoa?=
 =?us-ascii?Q?TbEK++tPdAIev5xOCdrt0R+HYE8aA0UM5P9GbCJq779jIT0yQ7Mn7PRL4FpG?=
 =?us-ascii?Q?26BySii7uY+1oMHAwD2OTISLoIWU6aip/HJBww06xreWYW//dwVqB3ap6O0U?=
 =?us-ascii?Q?ALkc6zpTQPQ1S2FFyFo+blts6mHS3gViZDnRYPBheKYkhA97ZKrtMd3DrsuT?=
 =?us-ascii?Q?+1MrbBgy4r01ZX3colYwRWw2NF0cWyZlyIAFCyYSstjTXgbWo1T0w7Bpzytx?=
 =?us-ascii?Q?V0mMOj471O8mfF/cVQCHn+ZwR9Vzux9xkpnUh9WAdsuZXCeEgZ73C3A6SpqB?=
 =?us-ascii?Q?6m8T042xbM8hsbmjXTZZe19frmNzmGOgLA9JfT9KXLo7GwR+4fwUGnRrUVim?=
 =?us-ascii?Q?6udIyFbz7hHcmmFlONeP9bo5rJHR8iD2PzZo9z9uE3m95QeEHw64poxPZ1Bj?=
 =?us-ascii?Q?GSovIw2wQxlHHb3Mh1AELUALoxSIzw8qNvXCJidcOOw7CyxwACNX1y+slzql?=
 =?us-ascii?Q?JfY+SSYtA0iKaV6K98hbdhAY5VdiTES517Elk9Bzfd2rMc20XzQaY0X0KXQ9?=
 =?us-ascii?Q?bMt7tEa1F4Cf/kxfwxCMaE8YOiMzxoBZ/QRqaGtuGIYRSGKdxNmrF7ZyBF2A?=
 =?us-ascii?Q?Ofx7Eh7cXQFTLdACxZR90nICeJJgmPs01wZ54reGThNehP/SAprCYBJFB1+t?=
 =?us-ascii?Q?RDt+9HlfAYDyQXZEDgXUMYkO8PfpJzGgNRM5Ml1GsIpA8dLXs+k+snwFGYqj?=
 =?us-ascii?Q?X4/hQ+10RqTlhtZKNo5/3UpkYLXdQCwPW+unLvXTE+H59ZXTUABky5Sx6nFQ?=
 =?us-ascii?Q?GPoy0yGg/eSgdcizxfiXKgr1x5xO8PS8ymEoTrccHOhXEgHCOvvrQwb3DQv3?=
 =?us-ascii?Q?/Qi7SDpiRE+FCde2f91Vk9m+YQ0LBBTCk/qEFKwaX/jfewvzrMKQzf104+X1?=
 =?us-ascii?Q?Zsuxl9TbRDgRa0C7aroCgvk4o/LEnDf1ypA5ObQmwk53fDQl0b6fyy8tbvE3?=
 =?us-ascii?Q?fPMUrQurC5/hGWS8cMBAoWjvv4nwJ7WOPUZdW2WanOgfbCnnP4qqrTvtFfKi?=
 =?us-ascii?Q?gUhDbst1bZ6yKnrDpiip7LQVTd+xXc3sCxYUYRUINeKFNKX6qYd++I+8D88I?=
 =?us-ascii?Q?45LkCJnNvoSxFwuUehw+vArlQDeELS9QJPO3Ucjb3ZQTqH3o6pWlK2Cepw7w?=
 =?us-ascii?Q?UnXl/FOAt2M2K8xUBz+tlvnlPHcA3VRzsWg/QgFwewa3AVl5FybiM0k4Be5m?=
 =?us-ascii?Q?Y40zhiroI7UTpenXelrhcIjDRPru0B+L77fFfwcgYGAXWW2A88+FuB5BacUY?=
 =?us-ascii?Q?M8lFd/HAT5uy+B6+eMc6HwIys6YjVXRm2lIIPD5hSbwmtBYMFqiUVv2r8Zs0?=
 =?us-ascii?Q?zvk3ZvefEgslxXxNMF9HUTDvQiTpWSp8H8lqhnzoXbLavqRuoLTtBThYQmP2?=
 =?us-ascii?Q?UsNGQPE99ueTBZjakfam1+scpwz3brPk?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5898.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?isio4xCvbSSOfAOJRsql9hUvZeU5AqTqTSvxWPwwr3rOo2mR1ErrwotTS3AY?=
 =?us-ascii?Q?/P4jiQlAi9NyztgKOinzt13L4VAg1hkMAw8GXHHJt2HPKBYlJDMuFPKfioG3?=
 =?us-ascii?Q?5AjaxJB60hQ5qWVoM0Be1/wCP6sxkQpt8av/1/WnYfDKJYv7i9Jq8dOv/oWh?=
 =?us-ascii?Q?2gy7signKNrdhOVCz88HSjKWKriYgW1Etw0qpd6g860eTfDvgk8IknyIuOR2?=
 =?us-ascii?Q?B/TViQ88eDX3tNoOPlv2IC1w50CAYvy/UTsVkBo9n1aPswGTJCLJhSzEPehn?=
 =?us-ascii?Q?7IfATSoZsLK6bboRfXgvjEPjgA0g91KK1AVHpk9RH1CTPqJE5jGZ4QgeCeSQ?=
 =?us-ascii?Q?rflulshCHT4qDlmDTnRgvFCxHFhlgfqevN81NTjqQROTu+IBY+C3HoiwOEhO?=
 =?us-ascii?Q?5sEa/BIVHy5HoDkq6uvXA+rc1yKu/vAnfpoPL50ZumzrckBwCJxKdDlFVrdR?=
 =?us-ascii?Q?l/e/BpX5eIXe77+Pnef8WaUlR/29sjJuui4/7nAqYn7oqWNw/MW6E1a/Hic3?=
 =?us-ascii?Q?c364nFD271pmSJQBMobVpjWSxa8PT6fVsGNq7ko6g0DEW395euwXwpn90GZH?=
 =?us-ascii?Q?PKn5siMyfK/TCnoeQASs8Zh7ZohwHMawjOMAC64Dve9d08nsvQbrRObjnoTM?=
 =?us-ascii?Q?W2Ad1hpqN4PIrcwYVq6GUOxmK1seIwAsgXM3uODqBhV9G8MIaPG1pr8PBH2J?=
 =?us-ascii?Q?kM9Ckry8qFGXA9I8oP/4LqTRFGsvoUPc3K2vbXj2iYjuVKxkae1THZJsoBRx?=
 =?us-ascii?Q?9MSK7Z8sN7ruv1gaAjSC61beM380kDHyvq+t9RfQDRjorxRvRZwgbz+e0mNh?=
 =?us-ascii?Q?wzmz+eqKDDCdiF4cx1xogd6ASpK+i8yzBT3Frczb1gmRzUCUeOmrRzyG+OlX?=
 =?us-ascii?Q?fzSP63wIwbg4v4XXxfILYkiIDv+hvx3nfM+T/7ppQmtQxWv4OhBqZNi7c07y?=
 =?us-ascii?Q?qk+Ej2peuBT4Ihhmfpd8MIu/BCWI4Cgtp2Ny8MDoEtMXSEujC9Mm5Sytit+b?=
 =?us-ascii?Q?mksKW7jqn/rBQOpj5gr6FaLPg1dBWbgedq7yLH1l7+vmMAw6TMUwFqVimAPr?=
 =?us-ascii?Q?iyMMyJ/G7qU2xSG3Hyh4xTZ9jpurChZWKQioTK2Tkoa6RBUKfiNnep9EADRP?=
 =?us-ascii?Q?2JW1WFOCGjxTuVUvZf8GFoVRx6jstMfzmADNwaUQzUkk5kij6UehDPYNYgoZ?=
 =?us-ascii?Q?rfthsI5BG0iTQCrQL/GwdCZQbdETJXjb5j3AO6WMMCTHuEuenumpf6YCHa0P?=
 =?us-ascii?Q?kIHV1y+FkX+0gHZHTtgSxgj4dCT793r54TAibepqcWbFXFMenDkDOHGa37px?=
 =?us-ascii?Q?YM7SueKGeRY3As/tNz8gva8FS9ZPg+W9W5fVcVGHSRmIEfcu1TlOSLYOFTb+?=
 =?us-ascii?Q?trCimguLWX+ljiTc03qHsDZq0yskKTqnEc+csGLw+u8soZuftufa2kXNGUz+?=
 =?us-ascii?Q?ZNVpgh7HHFE5+WbGDM8ZK4lEGF4jpcvprFRJ3Q7BpwWC4ng1oaglSY2kHxAe?=
 =?us-ascii?Q?sV8XDZ/G9u4PYZhvirAS7z+xINIpfHFdNZXHJWvA8zNBPvTbYkwM3P7A82g9?=
 =?us-ascii?Q?zeduV0CZ7LZmZGM4WHQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5898.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca6a80c8-ef14-43de-fd79-08dd6306b19a
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2025 14:44:15.6718 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t6nX630iOC7OYXDTCcVk0Nm7PvGdo8iAHSN0jKVbQzKLexClwwRi+znuIn+alxeRwGU8YdUQ6PXVTRwhlJ+WKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4147
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

Reviewed-by: Kent Russell <kent.russell@amd.com>


> -----Original Message-----
> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
> Deucher
> Sent: Thursday, March 13, 2025 9:02 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>
> Subject: [PATCH 3/3] drm/amdgpu: don't free conflicting apertures for non=
-display
> devices
>
> PCI_CLASS_ACCELERATOR_PROCESSING devices won't ever be
> the sysfb, so there is no need to free conflicting
> apertures.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 1eff6252f66b4..689f1833d02b7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4401,10 +4401,17 @@ int amdgpu_device_init(struct amdgpu_device *adev=
,
>       if (r)
>               return r;
>
> -     /* Get rid of things like offb */
> -     r =3D aperture_remove_conflicting_pci_devices(adev->pdev,
> amdgpu_kms_driver.name);
> -     if (r)
> -             return r;
> +     /*
> +      * No need to remove conflicting FBs for non-display class devices.
> +      * This prevents the sysfb from being freed accidently.
> +      */
> +     if ((pdev->class >> 8) =3D=3D PCI_CLASS_DISPLAY_VGA ||
> +         (pdev->class >> 8) =3D=3D PCI_CLASS_DISPLAY_OTHER) {
> +             /* Get rid of things like offb */
> +             r =3D aperture_remove_conflicting_pci_devices(adev->pdev,
> amdgpu_kms_driver.name);
> +             if (r)
> +                     return r;
> +     }
>
>       /* Enable TMZ based on IP_VERSION */
>       amdgpu_gmc_tmz_set(adev);
> --
> 2.48.1

