Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DFB7F8FA94
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Apr 2026 15:33:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 42F9910E8EA;
	Tue, 21 Apr 2026 15:33:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FYhkMevE";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013018.outbound.protection.outlook.com
 [40.93.201.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2DFAF10ED03
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Apr 2026 15:33:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h/sqQybD/zL8D+FyiYxzj1l3TZBGItscbOTGkOwqzRUbGVJ5BcuW81YDFlhqMWeFx83uYPj/2uSxEZ3nJiN/0Ag14YjvdvnNrNyZCAZ7obezp3bMpjLeRfwKbaAW853hUtkdaKPIzLYglQcI9fiy3KSTMsvCJZl+SRm//qBXFJJwge/syV1VvDiKHM8qLCfhc3sFBZ5hDIaWE9pcjYKK7ZkTCAcRcroPINGfI8yNbFNU1St8fzO60YSnxi28AxVN2dHcTgNY/ap0DaKvU+XqVBWdkj22rN48PcHjxInS5StGd3jJoiT72zBlMVp2ZbnbfdLRpJi1MNkHeHweilsnAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iUP6buCcg6uvdWXC/dMCAQrYOVtpj0SmOKSVhq3Hfvc=;
 b=HCrfydVddnQqjefQXEHCXklX/xT2Ls7yzl+cWineD6ujDeLUqIhu7O5H17iSYhT1gIDi56kUnrG7amLH3laNQITnQDFrRk1H8z2Wsv8jI9o1F0ubPHbtu0hsYJ8QX77E5O+QPVB80/gDYtOXyxMpe7ekOqcd/GD9VmFS6vaJX7V9ali3vGDMcztksr1MAPeX4sGDEzrdkRCe0kPD9nohn5NinB6UCt1lvFiq1/R0XTt1lMd7h4YQkd5IBGfdvJflIgWPMxlPv+3QK10nFGARGNhOHBXe23cpkoAIt1lRnqqUxwYb75sUI/HZPTco/mYH4pTeo0RI/MTAIGC/Ctc87Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iUP6buCcg6uvdWXC/dMCAQrYOVtpj0SmOKSVhq3Hfvc=;
 b=FYhkMevEEUowZPrvrLXzYrggdJgDNtj0l9l0Z84LPIFYH5MDqsw1VYmRGKU4JR3bD1Qk/Ihf6+I/84yZATPEDDKm/n9NW/O/7PnBq+ICAueVdXlI3Plbe2RM3Z4bhuvyklUDjcYe2PCfOM9qtpNGc4IhUBJrf2lFy8eRmRF+BfU=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by DS4PR12MB9820.namprd12.prod.outlook.com (2603:10b6:8:2a7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.12; Tue, 21 Apr
 2026 15:33:33 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::699b:1fb2:73:6a33]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::699b:1fb2:73:6a33%6]) with mapi id 15.20.9846.016; Tue, 21 Apr 2026
 15:33:33 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Milind Sardeshpande, Shubhankar" <Shubhankar.MilindSardeshpande@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Lazar,
 Lijo" <Lijo.Lazar@amd.com>
Subject: RE: [PATCH] drm/amdgpu: Avoid reset in AMDGPU unload path for APUs
 with GFX V11 and higher.
Thread-Topic: [PATCH] drm/amdgpu: Avoid reset in AMDGPU unload path for APUs
 with GFX V11 and higher.
Thread-Index: AQHc0YQbN/B3Ok2MdECNNiCKWXvt37Xpo+EQ
Date: Tue, 21 Apr 2026 15:33:33 +0000
Message-ID: <BL1PR12MB5144D95669B69B3AE6040A01F72C2@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20260421114255.3850980-1-Shubhankar.MilindSardeshpande@amd.com>
In-Reply-To: <20260421114255.3850980-1-Shubhankar.MilindSardeshpande@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2026-04-21T15:28:08.0000000Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=3;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|DS4PR12MB9820:EE_
x-ms-office365-filtering-correlation-id: 2ad7cdb5-efbf-4c39-ae4d-08de9fbb5902
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: u3oRF/KNeU4kopLJpxrQUxAad+Nk/ZZqH1Urd244LCJT3LQutFccBuB5aasNbtVPPPuIarCM/LH0p1zkz7FsXbTCtScw+jswOMO/E2kHJ5orAkjkMGJyP9+wenovXti5oJCVpkLY0C3Ap2Tgx4kAmAKKPR5z8oELfy/t4/jklz7vAl7SJXWDEuBK1Uefty5AcOQX0UNanVWZTpwwLQ8eMIz9fiug69//lfdFzsQJci9ONRNqQLO1UB2p5vG5Agu5NNPa493jxQRy5TORf0foXj3XuMk0aL6CNgeUuPYmEhyl/D/u5fzTqMg+oeQWV9BneQUDrTN7GUJ5IAcQEkZy5rAtj97qTcwFBlWGOIy2/CpMNGgJzi8RXmKs+emOey/HvBW26/+Hm8N8OzJAKdvFWOTOuzt4C2IHGM5EsG7XwTQP376TCn+aTBYciyAY+kgkx+VecrKtnueQfJE+OgTp2sD6MDKXmtp9k/V3P89agNVMZ+8x2QjTQHi+hOLYd94rXXWrh8C9LmG+CS+AqKq7QrKu1R9QEL36KG0WLXJph0k4VzwWnn/ORd6rgJJoXsPSZG4d01Xbn1MO/fNNlb1Hr7JhUUHZMUWWS7xVOTywECe8jCX89v7J2sCH6TQcxFWJFOo4Th4IXcZLogc2XBOR9bYNp50IVlmD3pBIFdcu4H4yIwmRoBNvmEI8XbMGAl0nVn88nfVZcEcwIQFbzmTJtIR1zj6NLLWy428hN8OQqoB6w6BJSSPAQAlahm+4OOrp3vmh6CJz/yVsOkFPFxPgntf4xCdGsMcA6qqTkwgWPRs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700021)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?eA3dFZR+E+kQJfPd1JOx9TmAGNIzxyn7aPxyEa8YczbqRTNowEky9H9Sy83c?=
 =?us-ascii?Q?Wox7vXVPEk74QAEbMxUoUEnItwW6VzQzF7OpsNVw10bq7VHAxR8vcFtbgqyd?=
 =?us-ascii?Q?fEGILAyZHC/C7E0NRDgs+bEibgZm+6FY026s/bsKJOr/VEC3xu1DJHXsIxDn?=
 =?us-ascii?Q?/ejDkUd05g6J8qudHxJeTzF1Xu7dL3zeyEArfJIGUp681Nd7kGCBMDx3hi/e?=
 =?us-ascii?Q?LsXLwLUlZlBxxtQO6o94SSWhOUcdrd1J+RJe+Mk9dLDVVAQtyAWqzeOBFSVv?=
 =?us-ascii?Q?OndtvGT06Jl/SA4kEczCL6qftRQFKEbmZmLz2SlXiyxO9b+AMp50jiMPKcas?=
 =?us-ascii?Q?lDVc5y/KnZyEH7X8mDDR91C2ss/Gj3+xrb1lNrJaNP2Y516/LZq+R6MJvBQE?=
 =?us-ascii?Q?oAq3AGEC0AqLsgxqX9cmwGi4cK5HFIlbgImQvhxjwRwKBHBvYS/fuEaRsYv4?=
 =?us-ascii?Q?jwYuo5bjSunEkJDFxsUrT5pO3b18Dht7rTzFVn5rOHFxv6me6PlfIZl9d6Ho?=
 =?us-ascii?Q?iYVNbpYcm/oYvoHIx0/M2E6F3m7JUEvIyeMgGaeCMlUyrAoc4cr+yWF18tkY?=
 =?us-ascii?Q?oMC1eVk3JhFpOsD3Smifgl/8XNXm5UAw1ykXvoeMq3y38y+ktNgjVmTd4/QI?=
 =?us-ascii?Q?0DHmkSUwyrbUT/DeJE2kPFLfjzZ5VWNqjgWYhjRWOXP5XpJU7deXma++99+X?=
 =?us-ascii?Q?F9Y8nhc67JHlhtFSa1IGXf7lief3SFKHUeJa/n/YkVjK7EiTRHRCuVLckMzc?=
 =?us-ascii?Q?t/uSScURTU6kVFHpK1tMPGUH2UnmauZvJJX0Sjabp4xBWMfcXHbqp4dVcIup?=
 =?us-ascii?Q?LzI//DKaZFbkgFe0KX33TsIQQrBbpdVnLFNCA2Q8+O8AXzRCyyrTtXla+/Tu?=
 =?us-ascii?Q?mmj8j5ppZUw3EF/6YqfhwKHt3sc1ct8AX9uAzq7rITussmCKr/X+O+18IpKz?=
 =?us-ascii?Q?jyswt8DHYTvZKDK1kUj/DeFoma/MowJTolZ81BZyPWZ5D9pmqPy3XDA8zKxQ?=
 =?us-ascii?Q?4Ac5NO90/CHopu564o9VXR32yCYM2APtcrRn0ICLEta11C7pwQO7Z8latBdH?=
 =?us-ascii?Q?V3PI/gz0k90xsl8ynvMEon269G22GvPpo0d5zgD7+aNo0h22b240CLtfVDMm?=
 =?us-ascii?Q?J7MSGc6/S1Nk3wWTeIudIzYzJ2Ml1hlVBRQDLLkqTFgWzBiL9pSf/X31GI24?=
 =?us-ascii?Q?fJUlBMquUQKk89ERa4i0raG//S4zYsXx+QP+hMJP+WVb6KTsks7lbxCmi/kx?=
 =?us-ascii?Q?GOVWn20evlDWdXNKFh/qIfRWD4J5nk34dUQbBjvaoAKRxQgszokf8cHcSyVZ?=
 =?us-ascii?Q?MEXkKVRMDsLinyxhLO5fsUSfyUKCUoWnyk7LrPq9UTnrXJmSpkx5sAT2k6eW?=
 =?us-ascii?Q?Qyj2tedSWTgTtRgomcJ5thiA5O3C51fJh78izw/4A+aL4b9GGz+rwm9WaVfZ?=
 =?us-ascii?Q?LKFm0PhTsDeqiFiVcFIeXnt9dqghV0Y/4nrTHw8woLE6G5Jw45GZcZzF0kJu?=
 =?us-ascii?Q?l64vuHRJHAT0Dgaa19UacEbtlEb4w2k759Rys4soRjK/XY3QPx/gfUD+Xv+D?=
 =?us-ascii?Q?BSHssGOS2eSegQxUYzRYh5ZO4PwJ0T/9eZ9LF3xF9/tBe5SpdYUI7/o1jog/?=
 =?us-ascii?Q?3qSW6rXMe2kwo2hAlyaRM4d7xEQn5WScncc3ADTfLAlmgfKyK90VFArcE+Tm?=
 =?us-ascii?Q?svgvtZxIdYv7+VwXB0GzI6uzkU+Jpr/tcg38mxDgowWifadP?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ad7cdb5-efbf-4c39-ae4d-08de9fbb5902
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2026 15:33:33.4031 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UGBtaY33qT5ujpGHZlTAQ1pZeTwZZ+Ub/B2X8Kj3eVRu5HKvqD5gJSQXicvNLeVXEkmPu1kHJkHFSkupEgejMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9820
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
> From: Milind Sardeshpande, Shubhankar
> <Shubhankar.MilindSardeshpande@amd.com>
> Sent: Tuesday, April 21, 2026 7:43 AM
> To: Deucher, Alexander <Alexander.Deucher@amd.com>; amd-
> gfx@lists.freedesktop.org; Lazar, Lijo <Lijo.Lazar@amd.com>
> Cc: Milind Sardeshpande, Shubhankar
> <Shubhankar.MilindSardeshpande@amd.com>
> Subject: [PATCH] drm/amdgpu: Avoid reset in AMDGPU unload path for APUs
> with GFX V11 and higher.
>
> GFX V11 has GC block as default off IP. Every time AMDGPU driver sends a
> request to PMFW to unload MP1, PMFW will put GC in reset and power down
> the voltage.
> Hence, skipping reset for APUs with GFX V11 or later to avoid reset relat=
ed
> failures.
>
> Signed-off-by: Shubhankar Milind Sardeshpande
> <Shubhankar.MilindSardeshpande@amd.com>

Can verify that the mp1unload is called on all gfx11 APUs?  That's required=
 for this to work.

Please also add:
Fixes: 34355e61835e ("drm/amdgpu: Fix GFX hang on SteamDeck when amdgpu is =
reloaded")

With all of that verified,

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>


> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index b11c4b5fa8fc..b8c812f43a59 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2839,8 +2839,11 @@ static int amdgpu_device_ip_fini_early(struct
> amdgpu_device *adev)
>        * that checks whether the PSP is running. A solution for those iss=
ues
>        * in the APU is to trigger a GPU reset, but this should be done du=
ring
>        * the unload phase to avoid adding boot latency and screen flicker=
.
> +      * GFX V11 has GC block as default off IP. Every time AMDGPU driver
> sends
> +      * a request to PMFW to unload MP1, PMFW will put GC in reset and
> power down
> +      * the voltage. Hence, skipping reset for APUs with GFX V11 or late=
r.
>        */
> -     if ((adev->flags & AMD_IS_APU) && !adev->gmc.is_app_apu) {
> +     if ((adev->flags & AMD_IS_APU) && !adev->gmc.is_app_apu &&
> +amdgpu_ip_version(adev, GC_HWIP, 0) < IP_VERSION(11, 0, 0)) {
>               r =3D amdgpu_asic_reset(adev);
>               if (r)
>                       dev_err(adev->dev, "asic reset on %s failed\n",
> __func__);
> --
> 2.43.0

