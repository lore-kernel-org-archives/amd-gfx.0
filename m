Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC861CC6B2D
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Oct 2026 21:39:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 421D010EB2E;
	Wed, 14 Oct 2026 21:39:30 +0000 (UTC)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011030.outbound.protection.outlook.com [40.107.208.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34CAE10EB2E
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Oct 2026 21:39:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xjsg2PJ8yQWqL1GwWZVl0ccJCYXbayX7pRuNB5zARiCO4zRh9rZMVIBCynLRzTS77rTnEI3zm4W24DZj/ZE6rhiW7ZXiWBZq6lMYsG3NVUBFIeZz28PMomUo5N4XSSBhyLIFAfvlgEDaXg6BB3OzSk3E64vQbUPkN+ut0y7ovI626JRC44kohuOSm2PS2HE13TX3PZB+8EJGKWnf1PYt8dKIjOlVeQjsDN39wIiQLsyMFTTWXpFxlYoQ2sX9MJ55/+K52f8fyFE6eBUpze4Ei7Ak+kD8gUv6/LQ7sdXHb7D9HOJah8+EKCDWyYJQcS0tSVv4Gs0Z4gp7CIcpLNGQCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b5C2n0s+0FBpg9MNtZttLF/JrMaFxNW1wCLFZIw9DTg=;
 b=yzMj+qKaS5pDSJG5yMP16224Dn3SUp4Yx5oWl0cg9iEOZD95ZQOJLrBjr9Ip7d7xGOQacOFSUXCzcOVfldFnLF54uTqI5U84h89dWia+ygoYTnniAbJ7AXJFUp0et9RtcnkxlJtvBF/0BB2791i4gin3hMOszICatU9FOFQy8OeOh7t7ejimuhdg3letjhddGJ9+k2lFAcDYpr4YXkdGX/ESdykk3nwi21MuuH2HqwHGUuUiH3YVWXv1EjfIhYABs08WErnbON994KQT3TH+qr7TJHMP3vlIs7zK1Pgx+P2tgtjdX1k1Fuk8VSIzm0nKTksLxYSG4/94scl55ZbRQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b5C2n0s+0FBpg9MNtZttLF/JrMaFxNW1wCLFZIw9DTg=;
 b=enqHVOUkhNyx0syRCLTy2nE5WRwwL8BXDW9KeTOzO2tVIMsupyJ400yIxLmQ0ocVfxu8cjI6mlLcyJpOXsdxTAAwyKI3IvOxhAvPtXyQjQG13VNCVw4ozfGnN1fIZfwCzRRbWMue065Rtl5NL7mXELdewwe9fXq2L2RWxv9FbAY=
Received: from BN9PR12MB5146.namprd12.prod.outlook.com (2603:10b6:408:137::16)
 by SA1PR12MB7245.namprd12.prod.outlook.com (2603:10b6:806:2bf::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.20; Wed, 14 Oct
 2026 21:39:17 +0000
Received: from BN9PR12MB5146.namprd12.prod.outlook.com
 ([fe80::535a:591e:27f6:c23]) by BN9PR12MB5146.namprd12.prod.outlook.com
 ([fe80::535a:591e:27f6:c23%7]) with mapi id 15.21.0496.021; Wed, 14 Oct 2026
 21:39:17 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: Maciej Kucharek <qchcio@gmail.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: RE: [PATCH] drm/amdgpu: reset SI ASIC on MacBookPros with VRAM at 0
Thread-Topic: [PATCH] drm/amdgpu: reset SI ASIC on MacBookPros with VRAM at 0
Thread-Index: AQHdXBEtFbuE+1J6RUqLu5DXondMV7b9kBog
Date: Wed, 14 Oct 2026 21:39:17 +0000
Message-ID: <BN9PR12MB514681E5EDA768CB4497EACFF79D2@BN9PR12MB5146.namprd12.prod.outlook.com>
References: <20261014192030.10611-1-qchcio@gmail.com>
In-Reply-To: <20261014192030.10611-1-qchcio@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Enabled=True;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SetDate=2026-10-14T21:36:54.0000000Z;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Name=AMD Public
 v26; MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_ContentBits=3;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Method=Privileged
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5146:EE_|SA1PR12MB7245:EE_
x-ms-office365-filtering-correlation-id: 39244cc8-b064-4077-85cf-08df2a3b992a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|18002099003|10067099003|22082099003|38070700021|11063799006|261009223027099003|56012099006;
x-microsoft-antispam-message-info: cWrBkqjnmAh49vLB308CbKnmQKEolVhhhmzbeoHBQRclnuguokjiruDEvrkC0foBQBcJMznlhTfpn6Qanq6eJ8wPATCkSslU9/X9GXQxppC6L6SgrPOi7DxsoS+JvzdS/6i4awXOqzx8rXLM5W+9cxu9Uu15825iYz7FU3aeg2PJLKGpbAdPhP1y94tdvMrCLpdHOHhlI6DgFyhMHbgPOuj4devgVs6vDl5jfABT4Bn0EibeJSL+XAC4KiW6gT8YcHs1FELZsOlnmT8IMG7qOSybTSJoKdsp0AlN6vU5jI3TRzgunUjHri2ZzjH5GqgLouwG7c7tXITP6jjI+Iwl7ennPXHkGNyy0OT6wvWkKKImvx3LquwcBDqnp8iFNNVMDSvHlGmk8yPBtYzpqspVimc/suOdwpeZ7Y5gHnDxysxEEErhSW/EFFnxlzSK8l8w8xMSz6tLsSMih+ttCt2LVrBsbHl01KfQ5gojZC8rcTDKBJqIPBCqq+11Yk4SxRgNeX++lqTqIGVzS/aiUsWbA0/06jRt92bV0yK0LlDx5uIReXHxycae7ZpuN24H6oHP75Puf3eWJ+bIhaqJ9gJU9E4eI3ZrjkKHNPqA6vnLHSErqXpDtamVfrsBFpJH4TGmuU2zpOqGPAk3Ex8Po1bUr/BxtY9GznkaxJYBpg4IoYo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5146.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(18002099003)(10067099003)(22082099003)(38070700021)(11063799006)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?isyC4N2rFGzl8wgnp15L+ljk8dO4bLcjT9U3mZCBy4S8+IvFEMTPX2kS1pUi?=
 =?us-ascii?Q?MDQky/pGMySfINox0fpMla4Pjk1tcEsbrteo5DXRiLhvJvTSatu6qGH2c2n6?=
 =?us-ascii?Q?hRbwuN5tVyJN0WrADa4/lWg+z1wpokzsOTKncnvbgpJtLvnXr+9EMafCZsQ5?=
 =?us-ascii?Q?PkDpr8nL9FxxO8f7Vje5b1gsqiVqPFEGRF/fsrXoUMESRhSvxRQ2/bNNdc4Q?=
 =?us-ascii?Q?PxZ9IK8RYtr8/BiwFqBiw5yWDHBUlyd4gtOQRMGk581bcWIqamRoimT4xxdG?=
 =?us-ascii?Q?SiZuODlnUc3yUSsNCr1NpYPaoJ38xVuPcHlperuusrTQb8EeviGnOmJVE9pf?=
 =?us-ascii?Q?kee1M91hOMyIOoLbCakB/RMZe2PFRIS+7jeQU5qgm88yLmdXirozv/39o7R8?=
 =?us-ascii?Q?3pvD0GyQl22viKBCrCwHcQPYlnU/L/UpSq3VFTwPc0XdTNZaOR737Bpf+EkD?=
 =?us-ascii?Q?HCandyFh4TcSZIVGut3fr9+whcvIyGgbMc7JwQi7amq+x/mQkvy6Z0cVSskc?=
 =?us-ascii?Q?U+IwQ4tUu8hugCnnH4NcqBOLG1w1cV1zkPykJNQDTo4e7QMMz+bz9XzmrUlW?=
 =?us-ascii?Q?Wn6/3OyDv0wEam6Y1hXMyyS1jWDXTiECwfjZisMKrUTIlUufNC7cl4Cbaymi?=
 =?us-ascii?Q?jl4qtRjCo2w681age4Ld3VpAEfC8e96u16GvpqgNaGQSY/mZrFUWElGD8uqs?=
 =?us-ascii?Q?z27LMK+KuAMeygGjAMN9OSztNmb7qF1D7hCoa9dN7iWwvrEeMyx4iMEAA9fW?=
 =?us-ascii?Q?CteoqMOkxqnOpICyoZ5qadxuOzrn7GWe749hrUrbPS5sKe6C2NL9IChAWCY8?=
 =?us-ascii?Q?MESYQZvCeeJ9f3XM0f3MMbp0njFs0Ss0zZ2rVmi7ufQv0nFa1op5CR8+0A7B?=
 =?us-ascii?Q?B3grv7SOwWD2VnPcms0lKNPOo6qI/x1+RCY+AymblWL9+5yAlZ8jGlO0Mxo0?=
 =?us-ascii?Q?50zjbuEKu7hJ9VHFxNSLL3Wvg7efJvCVchZPrrmO8ytZo2hz0e8fToHoIW5F?=
 =?us-ascii?Q?RcX/K1TGdtDnksoUQhuNVTf8AIIENBIs1lu7vw1SGjma/m+F6AZZnnfEqrTF?=
 =?us-ascii?Q?zZjCzNFxMlrjMfQoTzfSvDYJOAXkisfDZ4ABOr+mThK3RC3Y79cHYAqpwiBv?=
 =?us-ascii?Q?uAEDcrPFzc2eR+tJ2MjKbqcpoYzx595AG1J2LN383lBWDvn7WC4jmyfujdKE?=
 =?us-ascii?Q?ZPXAfxsQ2g/Uk+EX9ndK+5ZZOsXSMsAUDIguw4HvxBYRfKXhCxPTrc57YLZE?=
 =?us-ascii?Q?fEg7OddeKJKVgoummomHZ/G7zrJGGSC21TjShqRliqXAubA5VuSrYsonZ4cX?=
 =?us-ascii?Q?hmQwcyTU5r/a+1eA58QyJsTa/hRa6ME8sdvUTfMyghTENsOh+NbycCZCz6Fu?=
 =?us-ascii?Q?sN3N81PgJiFsF2O3ZSJt9RZA6yD383WFWa58h8yooLTkV7jnZKzU3IutFUrJ?=
 =?us-ascii?Q?nxNT8ikWdP2DUJPB0aSDsr2HNrhZDO4Lk7Ip+Vl8HbiOfek5CyTHAb36RjpA?=
 =?us-ascii?Q?ermVzvhmMmE46FSejvCKHgWW7b9eDYWNPhFrgUuLausOi7WUrNzYF3FrMQ0c?=
 =?us-ascii?Q?q6ImT2Hwh4dMb7ksi3S8HVQK6qTaswC8A5WY+bh/Jc3W/VTwxu7VrpLsghsF?=
 =?us-ascii?Q?G2LmTK1ZJL6VZBVTWy7tL0/GVxP8/2bHCwVSAwBsZFEx+avALnCvXuMVJQUR?=
 =?us-ascii?Q?OjYJpc9sIAraxZdKzj6yDXG2gLW7xm2E9v2BpqKx3+a7a7dU?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5146.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39244cc8-b064-4077-85cf-08df2a3b992a
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2026 21:39:17.0943 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0g4Z2b8R58oyb5qF/C7mLsKJZPwsgyLP6wIan52aSlMqjPR84fXFYWkQ/jpL7HrZdP6Kk9XRZr4tcAyaYcWPnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7245
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

Public

> -----Original Message-----
> From: Maciej Kucharek <qchcio@gmail.com>
> Sent: Wednesday, October 14, 2026 3:21 PM
> To: amd-gfx@lists.freedesktop.org; Deucher, Alexander
> <Alexander.Deucher@amd.com>
> Cc: Koenig, Christian <Christian.Koenig@amd.com>; Maciej Kucharek
> <qchcio@gmail.com>
> Subject: [PATCH] drm/amdgpu: reset SI ASIC on MacBookPros with VRAM at
> 0
>
> On MacBookPros with switchable graphics, the firmware puts VRAM at MC
> address 0 when the iGPU is enabled.  The EFI stub enables the iGPU on the=
se
> machines through apple_set_os().  On a MacBookPro11,5 (Radeon R9
> M370X, 1002:6821, subsystem 106b:0149), the driver adopts this layout at
> init:
>
>   MC_VM_FB_LOCATION=3D0x007f0000, HDP_NONSURFACE_BASE=3D0
>   VRAM at 0x0-0x7fffffff, GART table at 0x1400000
>
> The driver posts the ASIC again on S3 resume and after a GPU reset.
> The VBIOS asic_init table then moves VRAM back to the VBIOS default:
>
>   MC_VM_FB_LOCATION=3D0xf47ff400, HDP_NONSURFACE_BASE=3D0xf4000000
>
> gmc_v6_0 does not reprogram these registers.  The GART table is then no
> longer in VRAM, and the gfx ring test times out:
>
>   amdgpu: ring gfx test failed (-110)
>   amdgpu: resume of IP block <gfx_v6_0> failed -110
>
> Reset and post the ASIC at driver load on Apple boards with VRAM at 0.
> The driver then uses the VBIOS layout (VRAM at 0xf400000000) from the
> start, and later posts keep it.  After the reset, FB_BASE is not 0, so a =
module
> reload does not reset the ASIC again.
>
> The test is the same one that commit c7f44ec5c4ec ("drm/amdgpu: make Mac
> FB workaround generic") uses: an Apple subsystem vendor and VRAM at 0.
> The VI quirks for the MacBookPro14,3 and MacBookPro15,1 reset at load for
> the same reason:
>
>   commit a22e5e4f2ebb ("drm/amdgpu: reset VI ASIC on MacBookPro14,3")
>   commit a5be7ad8f5f0 ("drm/amdgpu: reset VI ASIC on MacBookPro15,1")
>
> Other Apple SI boards only change if their firmware also leaves VRAM at 0=
.
> They then get the same reset at load.

Can you also update the VI code to follow the same logic?  Or better yet, a=
dd the same logic to si.c, cik.c, and vi.c.  Presumably CI based chips have=
 the same issue.

Alex

>
> Tested on a MacBookPro11,5 with 7.2.5 and this patch: the panel comes up =
at
> boot, and 4 of 4 deep S3 cycles resume.  Without the patch, S3 resume fai=
ls
> every time.  The GPU reset path is not tested.
>
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/5978
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Maciej Kucharek <qchcio@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/si.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/si.c
> b/drivers/gpu/drm/amd/amdgpu/si.c index 0adfd4b10..892e80f09 100644
> --- a/drivers/gpu/drm/amd/amdgpu/si.c
> +++ b/drivers/gpu/drm/amd/amdgpu/si.c
> @@ -1512,6 +1512,15 @@ static void si_invalidate_hdp(struct
> amdgpu_device *adev,
>
>  static bool si_need_reset_on_init(struct amdgpu_device *adev)  {
> +     /*
> +      * MacBookPros with switchable graphics put VRAM at 0.  Any later
> post
> +      * (S3 resume, GPU reset) moves it back to the vbios default, so re=
set
> +      * and post on load to start with the vbios layout.
> +      */
> +     if (adev->pdev->subsystem_vendor =3D=3D PCI_VENDOR_ID_APPLE &&
> +         !(RREG32(mmMC_VM_FB_LOCATION) &
> MC_VM_FB_LOCATION__FB_BASE_MASK))
> +             return true;
> +
>       return false;
>  }
>
> --
> 2.55.0

