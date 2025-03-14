Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADE71C282EC
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Mar 2025 14:43:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5905C10E9FF;
	Fri, 14 Mar 2025 14:43:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TIepT7vJ";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2045.outbound.protection.outlook.com [40.107.220.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43D8110E9FF
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Mar 2025 14:43:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MctEjDRaAGV8YLzH4L1Tyyww0wAmqEIzxG8BbZf3KQ2xEfQbcaKREeI+zs0qP6txGb4CjGo2zQv28pepj9WLb7hy7PcNC4QWxlktPfGD+wD3YF1JmZJVCZWChyvTXf/zfyZBY0+7n0erB45k+AmyEqHasbW7ONxyS2ORl6o7laoaUiG5BdgjU17MMFqFnnxIvhq4F04Xm1EbecAG3dzGQ3TwOfLeQjJVxFu52a8f7mHIZd/Bdaucwu8yjUQ7guPpHdk60OWikUBCbRvHoHAFDBNgI/+UUG13y5WLEFiF0Tx+LTAEZy1UVFs5JfDyn9NGILmoH/LpwpXT+4Oftrcg+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sgCkBvhw1SH6a07Fb0LSgn2t0f42OY24pWOvqtUMFao=;
 b=eoo5zFMciSvc5ZX35/xNIbJs0L+9MOJSTs9C547mR6rBhwtxySSinBm0n7IbC7T6zodjRwNZ955hBk/pn3veBxQpgRibeL3Pr8CI7fDFXWznxspkG6pozS83hOQFmk8HoAh9mY508SD41A0Nqh/czCbFxg4MVTDWGUnhDiOf/frEiJZHvcSgEPSGv1/GrUBY2YwduIcBA/MlTBMTQE9oFwUX2ekMKtyOrPeuqVFmQ9f2B3+KQJlYL2E19o4nCODAOH3Q/Ik/o32WbBX1xPX9xyBs53hH5F1vs8BFg6riHLLyj536+omSEpljSfg8wVmTjfhsikCnRzP4p1XL25C2Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sgCkBvhw1SH6a07Fb0LSgn2t0f42OY24pWOvqtUMFao=;
 b=TIepT7vJvZvEelDcvSn3NWLNIx9VWoewg+UZeejzsGBG8L5XaplMPPhihsrje9htQRMh9l64RRB/4fzrDjv2FOqpb3Kk7A+eKkoa53iF3rJjdgokf9KeXANpRFQB4zBa8vCu043U4Oag3UkamV0u8+6pvz+E7sNtOaGTQJkp4mw=
Received: from BL1PR12MB5898.namprd12.prod.outlook.com (2603:10b6:208:396::7)
 by BY5PR12MB4147.namprd12.prod.outlook.com (2603:10b6:a03:205::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.28; Fri, 14 Mar
 2025 14:43:39 +0000
Received: from BL1PR12MB5898.namprd12.prod.outlook.com
 ([fe80::989a:c38d:3dc7:97b7]) by BL1PR12MB5898.namprd12.prod.outlook.com
 ([fe80::989a:c38d:3dc7:97b7%3]) with mapi id 15.20.8511.026; Fri, 14 Mar 2025
 14:43:39 +0000
From: "Russell, Kent" <Kent.Russell@amd.com>
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH 2/3] drm/amdgpu: adjust drm_firmware_drivers_only()
 handling
Thread-Topic: [PATCH 2/3] drm/amdgpu: adjust drm_firmware_drivers_only()
 handling
Thread-Index: AQHblHy9QHLMq/7ioUyUnlY6zZMaWLNytfBw
Date: Fri, 14 Mar 2025 14:43:39 +0000
Message-ID: <BL1PR12MB5898F76B9BFFBF83D261F92F85D22@BL1PR12MB5898.namprd12.prod.outlook.com>
References: <20250314010152.1503510-1-alexander.deucher@amd.com>
 <20250314010152.1503510-2-alexander.deucher@amd.com>
In-Reply-To: <20250314010152.1503510-2-alexander.deucher@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ActionId=324aeb62-804c-4f51-858c-d59350f20fa7;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=true;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution Only;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-03-14T14:43:31Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Tag=10, 3, 0, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5898:EE_|BY5PR12MB4147:EE_
x-ms-office365-filtering-correlation-id: 9c986693-8333-47d8-d70e-08dd63069bee
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|7053199007|38070700018; 
x-microsoft-antispam-message-info: =?us-ascii?Q?An8NWGaH6CBPyPEoENg8T9H/3l/4LwUAaP1zpFX5HUuKdRdcVpIevCUMKITQ?=
 =?us-ascii?Q?O2Tq1CMDLUXh05grEeeA5viwbM8aAOM6LB1R1XhyAZddAEy+7TVg9qn8fPKj?=
 =?us-ascii?Q?XP/DjTbA2i4HwhpL+2TR6+IO1qqpEEUp7rS0nzzFYlUQ5BIWP1t1LqBDcvOT?=
 =?us-ascii?Q?QVrmqEmgHaOiZVyM6ADS/J9LMoMGNbtltrTYzZBsDbvQVY2tA/svefXjI8qX?=
 =?us-ascii?Q?9V95/BNZBBop7QiBbFgzWAsfG2Wvh0u1KjnTjL5pE6H94pg+llbIv8gIT5Gz?=
 =?us-ascii?Q?kEGQuod9/Y4cjIh2PF6ekHcuSBFXBSuNXuqk/ydO94tEuL2tOTeaZYAxVm/I?=
 =?us-ascii?Q?OPqWV0urSwrqDTVP6AIlRal6fA+nN8sZwDGqkvT8AGF51lgsa5itYU5650+I?=
 =?us-ascii?Q?kVfNELhLbhb6KNu+0Xl49sXkaSp26/Is4VVpkrxMyVZrR4JUCTkjFHbNmnyT?=
 =?us-ascii?Q?Tdilie47am4p0H7xUq8WFBpy9cZv68aKB2hWSMb3u6JvEgEZ4zf3GpviZ7mt?=
 =?us-ascii?Q?obEgcepFdEsAvUXxU0Rz3CLr8TT2MIeLh0zUcSPO6EWgZ9q/2o7isx8/0RCM?=
 =?us-ascii?Q?tqXXGeFtoI34mQvK6DliPlu2rpLznxKCgE9DcWLnDGRC4Fuq7kOhSO43gG0d?=
 =?us-ascii?Q?iMpIeGt0iJb9tnJow5YyC31RRzx/NptNehZjnSJvrP9zw/0XCeNUpVp0K7Lw?=
 =?us-ascii?Q?W7c/jt6i3fDvFlYW2BPdcAEOtpXfkMfxm2Dtmv6eDJOdb1noVosapYOF3N/7?=
 =?us-ascii?Q?q5dv2kFCUNu0/L+DO8CE15bgsmZx/M+DVa/hG1hK97RZJoaZs+Wm7vhS9Dqp?=
 =?us-ascii?Q?LvIo8spsc3ogAcckWEm9U6AOapx+gTUwWZVkUbEKoq8MzDSU3tQ8C0wDqWsw?=
 =?us-ascii?Q?OZbc+3K1lCim84QqKQaAxul9a6FX49GMr/flv9fcpW5Htk1R0nVJMTB9aMed?=
 =?us-ascii?Q?yozHMMDJ4/39O4MBSCxVoOm+dn3idSuoptmRBNevkJASz9Cg3J3XoXkGTlow?=
 =?us-ascii?Q?K9c1CyUgyZEdrqg1quP/q2W02XfLZhy+ftpUzWAMXhtlp3WGeGp6rY0wxXhX?=
 =?us-ascii?Q?r9xTSGRizTZ/gWck7VcVWs9azNy2iZPOGaV1kxD1zl6XPMTDwnaBR9DHHxin?=
 =?us-ascii?Q?YbZeYPPe07sWt+sy809CdtiEiluHDFhqDJ+37KkjAljvfjMHk8wJTcqRQntD?=
 =?us-ascii?Q?xx3ha4X8+zGlg+hIggoRDsXWJyzWwZq/5qtrLoNDOkMQpV+R/8smwPCpqi0v?=
 =?us-ascii?Q?Jx9s/99TO8PzH4RGwT66tnp9ccRa/gFQjKc2zT9XHKJY3hg0bjRrTocjWrRQ?=
 =?us-ascii?Q?FZgXgAg0wzvA++3p4EpLDtWW5gTSyySl1pOkWpAARXsbLEX64NAXFruD7x0I?=
 =?us-ascii?Q?aWZZ6YCBAtyZEs3O4yJpMI4F/Vg+A4d6dmS3NfMtKqpgUqLN6Lbeu0Mhymfi?=
 =?us-ascii?Q?K97W6JE38QaQDjV7BruBZ8xFV7tiDo2D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5898.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007)(38070700018); DIR:OUT;
 SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kX2stu8r4WQ2PG4Jw93z+OYfv6VqlEiJxz058o9g57qcFDUwvcOyQBzNk6CI?=
 =?us-ascii?Q?6q3WFqgXAopOBSgUbCIbbUG0+dqQMjd7KqqyU/vhp2w/V/c+G73JgZQYjeW+?=
 =?us-ascii?Q?6kYWXNsdgxqJF8KNTI7YWAIpaQ41ph11VYCvUm59vLNYRCoEDU6DE0+/kLhs?=
 =?us-ascii?Q?Yqm1LgrpEDVw586fv7vfgrmqNXTq9gkmN2Wlo86KUgsEXZjx9CJtsa3Q62eb?=
 =?us-ascii?Q?cMqfOC5/erGM8QUHFsKIvFiC6g1JW8ufVMHcBIcI4V2Yo1aj9n4a/kxjiKtC?=
 =?us-ascii?Q?BFZcQqNf2MZLU3xoH1pzKV9aLD5Y1DFPcnA8OTOCQLn5Xyn9WTutl1yPdKka?=
 =?us-ascii?Q?u3+LPxiUQ597/0YP8QH9dEwfmGSrw7XwLsOLhtdvy0pS5/+n7eHctQFWivCE?=
 =?us-ascii?Q?HIF7xMnrL7nnBcp9Qsy8ko3jkmuJ6stZaonMMA4ldem6k+Dq6ilSxdP5bSnv?=
 =?us-ascii?Q?2MXrndj5atS+ihRa5sjEyFApe+mFAE9p0US2u6HCBFzAciEKWONukW6BOTRK?=
 =?us-ascii?Q?rt4gne4ol21Y79T5uW9k9UbKsv4RKeW49JrKe76ikfCTehbqzfq+fa9e3VEI?=
 =?us-ascii?Q?Y9XSD/nSXrrfhXEFk7JRPNe7CrnJcdpLjcVDhVaSMeHMLLcM1MzyxTK37m/q?=
 =?us-ascii?Q?xJyQcV0DlQde788wvima/UJTazYaOv5O4YwvUu+/CA8AG9ggMGl1+SgMl66W?=
 =?us-ascii?Q?Sn1+6F9G+lSthRu+JAKE3k+Buz97wxuQB2HAVBUhoe7Jm2VQ+BxtbxWIPh6o?=
 =?us-ascii?Q?e1PEFjIIjJEAW0sIz1LlUQcL0iyg+TnlrLSZFpnZGy33U/h36DEIyOw5anmy?=
 =?us-ascii?Q?/It1kFNJG9bzQEfCpYtAQwDFyjwmClZG3c5tHfs5OyfQ/4ys5S8cAf7Rrbeg?=
 =?us-ascii?Q?ynOG82wvJpcs4tBw/j+5jF7AVBYpBZFV6zxrwIdDgeAL5JELxnTZtrKKyCCs?=
 =?us-ascii?Q?JjRhfgmLyJ/Ei5cgyn9vB5KU7UfSLYgRlHiP3cB6AU0u4uTW6QahPCxEAP4l?=
 =?us-ascii?Q?nPnEZPAau5whg1NPcPiWbdrv9EwTKURAyg4zX0tiSA19VEJkING1uPAxy7DD?=
 =?us-ascii?Q?5+dYylrh0yZm64aV8nu9AGed0ahDqt1YTdnLYQrkWtpn8DJ/ygDBRzVQOGoU?=
 =?us-ascii?Q?3vfjpl1ZRCFbDvXb4lNmb8pvcbryjwwmv/IHnPxhOf5yCUBGmPvA2V0/4v8P?=
 =?us-ascii?Q?OXnHE3JwPH1yqTBATrvpJUQ+XM4NHawjNpcuOgcQ7C+9oYhlE16Uumqxw1Em?=
 =?us-ascii?Q?5q+nQjy82W2Qvhjsl4auhBlY7V0Kw3OUQicasocAxnz9lLptkSSXd/O3ZrBI?=
 =?us-ascii?Q?tHI3bKnynXkeyEpJmwP1EG5BlwP6lEbwN1qzyCOYTOGyzmI/f0HDBvs+/VN5?=
 =?us-ascii?Q?a+dziHdjLkpRzLR/4hXs6wjle/jPOA5KS6QBT/rlOoWZaV2zchaWFYWEsNfa?=
 =?us-ascii?Q?e63VLe9N3bTTeulcmAZ77GREt/877n8EqudsdeYU/NO4ZJi9ro2TRto1MjiQ?=
 =?us-ascii?Q?kgTEkd/FdikYzOWrRk5PNwr8vv62ncLJiWctbJkhXxoV0Sh7aFpuX8q1yanp?=
 =?us-ascii?Q?2yPEwOMrXBX1A1Llv8k=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5898.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c986693-8333-47d8-d70e-08dd63069bee
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2025 14:43:39.2961 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Wg6fh20mGStp6T+Eisa9l3mZKPp3dfgVsLBsb6mCbGJioJILWJl2OPuXpOnjeP9Jil8JSh7eyz4f5XOmO5tGzA==
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
> Subject: [PATCH 2/3] drm/amdgpu: adjust drm_firmware_drivers_only() handl=
ing
>
> Move to probe so we can check the PCI device type and
> only apply the drm_firmware_drivers_only() check for
> PCI DISPLAY classes.  Also add a module parameter to
> override the nomodeset kernel parameter as a workaround
> for platforms that have this hardcoded on their kernel
> command lines.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index dd86661153582..4e1a6a249bba5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -178,6 +178,7 @@ uint amdgpu_sdma_phase_quantum =3D 32;
>  char *amdgpu_disable_cu;
>  char *amdgpu_virtual_display;
>  bool enforce_isolation;
> +int amdgpu_modeset =3D -1;
>
>  /* Specifies the default granularity for SVM, used in buffer
>   * migration and restoration of backing memory when handling
> @@ -1040,6 +1041,13 @@ module_param_named(user_partt_mode,
> amdgpu_user_partt_mode, uint, 0444);
>  module_param(enforce_isolation, bool, 0444);
>  MODULE_PARM_DESC(enforce_isolation, "enforce process isolation between
> graphics and compute . enforce_isolation =3D on");
>
> +/**
> + * DOC: modeset (int)
> + * Override nomodeset (1 =3D override, -1 =3D auto). The default is -1 (=
auto).
> + */
> +MODULE_PARM_DESC(modeset, "Override nomodeset (1 =3D enable, -1 =3D auto=
)");
> +module_param_named(modeset, amdgpu_modeset, int, 0444);
> +
>  /**
>   * DOC: seamless (int)
>   * Seamless boot will keep the image on the screen during the boot proce=
ss.
> @@ -2270,6 +2278,12 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
>       int ret, retry =3D 0, i;
>       bool supports_atomic =3D false;
>
> +     if ((pdev->class >> 8) =3D=3D PCI_CLASS_DISPLAY_VGA ||
> +         (pdev->class >> 8) =3D=3D PCI_CLASS_DISPLAY_OTHER) {
> +             if (drm_firmware_drivers_only() && amdgpu_modeset =3D=3D -1=
)
> +                     return -EINVAL;
> +     }
> +
>       /* skip devices which are owned by radeon */
>       for (i =3D 0; i < ARRAY_SIZE(amdgpu_unsupported_pciidlist); i++) {
>               if (amdgpu_unsupported_pciidlist[i] =3D=3D pdev->device)
> --
> 2.48.1

