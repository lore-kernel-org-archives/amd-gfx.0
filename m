Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06666C3065A
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jul 2024 18:02:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B0AB410E4CB;
	Mon,  1 Jul 2024 18:02:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LLRh96jL";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2061.outbound.protection.outlook.com [40.107.93.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 08B8410E4CB
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jul 2024 18:02:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P4+KFW9GVC/8PRvFzaTBTfJAlENg2vkhGsf9LsR0hT1MQmiTS5dpK3W1b/LMiZ8IAiSBIZjNZiZpWfAzvRkM4ckrAMuIqUr1vz1JED2UjYCTJCEH+k9HQ2gEt32E0hWf4AT66iYIpPOZXtq5yALy6qZ0fhnRMq24Ghktz9S0vBDNDtmDGaJQfouWj+gQvZmSJPx7UvHg5IYgOoeCEbpJBa5wE92OKGofJ251vDllfeMt06gzYYsEt9nweYWfoSJ1HkDkqImKfRNdL0VKB8jkXaCyNGZDLZ0qkN6y+sWAyjO9esj22/LcInP76FqUsqOG/Sdl9cV1j17lluuDjmX34Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c6BkpwazfnP9seHTiTGpIrNzI1cAyqxDRW6x0rAn4m4=;
 b=OVYqxUcutzr8vzLIj1fzts2Dnqw89s9tX6//PCdtjZr1wLD9huYumudOP6cxDaiUn3c2YlNeogB787EUrucWjEPd1EnE+doNlDpH6FRr+8Jk1DE1u48iNIkDo6f/MN8s16Y1zHJcB2nAKQGbtT8syxTiCP/w5XsOqgz0Z6Yl2L/g3B3fyVGvDTEp1Nmxuc64LDvyG6iU9HCyovhdrHLINv/2bIIhJihQD+MzHHYxv3Y8fFqfjP/N67j/okeN119pES1Gwnd1aElz0oI7E48jpi0AzUjtQcSAu+Pmnew4i2954Y+Jaht5AtHkwFNqtxxh7JMppEnVxogUZTUEHhiXgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c6BkpwazfnP9seHTiTGpIrNzI1cAyqxDRW6x0rAn4m4=;
 b=LLRh96jLSy8GYFf9/WdIAL6EmHMAWKkOAthNnRtOaifiE5xF32KGOhMPsrbtRPt0+LkJzW3LYvsrVX7ernTllcqi+q1Xisvl7WELpRg28J9bkuxBHL2bOHYL2wdxjBA+KvYL1NiIJGPbxT5uvZS6gYZAvMlnwm5BWJlHSbwW9M4=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by PH7PR12MB5928.namprd12.prod.outlook.com (2603:10b6:510:1db::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Mon, 1 Jul
 2024 18:02:36 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42%4]) with mapi id 15.20.7719.029; Mon, 1 Jul 2024
 18:02:36 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Huang, Tim" <Tim.Huang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Yifan" <Yifan1.Zhang@amd.com>, "Zhang, Yifan"
 <Yifan1.Zhang@amd.com>
Subject: Re: [PATCH 3/3] drm/amdgpu: add firmware for VPE IP v6.1.3
Thread-Topic: [PATCH 3/3] drm/amdgpu: add firmware for VPE IP v6.1.3
Thread-Index: AQHayv1kUPjzL5UnNkGiIdeoWfixerHiK68Q
Date: Mon, 1 Jul 2024 18:02:35 +0000
Message-ID: <BL1PR12MB51440224F1A3BC4D6CCB9B4AF7D32@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20240630145046.2021348-1-Tim.Huang@amd.com>
 <20240630145046.2021348-3-Tim.Huang@amd.com>
In-Reply-To: <20240630145046.2021348-3-Tim.Huang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2024-07-01T18:02:35.687Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|PH7PR12MB5928:EE_
x-ms-office365-filtering-correlation-id: 38c18dfd-d805-41a3-d29a-08dc99f7fcff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?keqzwLBMax2KkrV8pLCnO9kT13fbVdDMvOWGODZMqHn1r+CF19k2hw6clSiu?=
 =?us-ascii?Q?2gZXVh2r4E1qNIAxNSOmVF06hykSuz2+3Edvc/C7Z+zZ5zFnQ92ABjS1moUG?=
 =?us-ascii?Q?nnDR411/MdAZ0Xqc3Tx+iDSeKXZrVOT+1PA5hpmDX4g/eo3eoesKZZCyqYJv?=
 =?us-ascii?Q?ALUfqMPPscVSq18c0OR1vnuA02+E0p4/2j89G0VzIvGoKNfVI6wjdq7gcXIY?=
 =?us-ascii?Q?C6R9oiWWePssnNJRXAZ4aiDDLnX0sMSqENxlJ1ArpVck0t6D5PAw2ODRqCxw?=
 =?us-ascii?Q?rphpLFtCn7V/iNebhMDuJXJnuwxYpB2TW9h9mOxasW+1TLZn69rHlA7bv2+H?=
 =?us-ascii?Q?nvkSpEuGVZqwRKcIJCofpAcKjLACK8yNZ45caNwGRdPZu8hvf/bUhVAA/azu?=
 =?us-ascii?Q?jwM0O+afW4YCparKU+mYfD7WTQtqGrg0uf55e4CnK1A2bucA+EPw7l8HiAGa?=
 =?us-ascii?Q?6bRVY0lB/DR1k7GKEg+hPXkrP/iG/PBsMg53HQh0gXTvlLB1O0Sn5TBqX3jh?=
 =?us-ascii?Q?yvc4c0dcLmkjDbPYOtVag3U/aryXalSb1UgdykM3eEjJAjq/It267X5Q9CYA?=
 =?us-ascii?Q?3lAKGnlZxUQ700kNs1U1qU50LypTcqHfAQ7wGoGfQURYLh8r3tpVkOSUp5x+?=
 =?us-ascii?Q?Qifsfc65fMSndkPi1El4P8ypVIdh16FaZaroWFkVQ5DiA9sTSGstv/+6t2V2?=
 =?us-ascii?Q?wAQOyV1HXaZWkCxBc9ZxtcwuPrgSleIZ3x9jnJ1nLBo9FtOh+O0ii7mQHXIu?=
 =?us-ascii?Q?Hmd/rABedVhGZg3J9pFNBIDJzkzpIlQrFJNakOYIgfN/dh7uuKTncPecmPb5?=
 =?us-ascii?Q?o6WZZnekXf/yDXJZQPjtycUPIo/qC03zfybLQhS8So22KmtkgwSFE+R/RAMF?=
 =?us-ascii?Q?JtFL7sT5R5iVuNf5RJNdY9JQ2rxcRaaoglUB7hB3wTyMsTqMRhn+OCavL6/z?=
 =?us-ascii?Q?RXsGNGUjM/wNoCxsjCrVa/NDERTwSA0jbmR2wpiZPlH8BZn4HDRfsa0Lt2oj?=
 =?us-ascii?Q?YbFXhGATrqqRzhz3SSksxm3fWj/lZ4gW7AXVeFWK6bU9m0QtQYb4mjPSkL2O?=
 =?us-ascii?Q?7ZVWLRvP9Y69TEA51Dp/dccGrdDE519nkNcD9pSXI0b0CLW/NXWL9Nawb9oB?=
 =?us-ascii?Q?cLKhmcUxdlupqoLepmL2aPsz4mDdgiop91H4PIqhGgigjGzvN2x7NSlzhkgl?=
 =?us-ascii?Q?PRCEs7RPxkshM4CMGtl+bj1O6CyuBh5kQAVtZgbll7W/tV1ZfTzogAsKn/gj?=
 =?us-ascii?Q?ANMe3WiQbezmKhkwa6/dHv6Tbkjbq4GuDoixb6PTtsNoy7CjCxr2YxrCRYdT?=
 =?us-ascii?Q?LyGKNkp3jAO57iyBPBa85ByUMzEwEZStrAHAFUF95dfEOgcza8g3lSx0fC4F?=
 =?us-ascii?Q?v/HmKjxM4+JcknWAt5c6M3LPEiajpnmGCtbs6ne71i7TVZ5zxQ=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pRS2EOtrrBcmQiwO+mJTCwp4a9x5JmHQOlhILcsi71rUqTtxL4o/cZ+FlnHn?=
 =?us-ascii?Q?68AUZVL8YP9Lgb2/MzMcY2zOehnfeHJFcQdoTle2GDA00u1FRUZpJe0ig7Lp?=
 =?us-ascii?Q?mnyO6Jcyr9eH3VgFeTcWi63T6/sGPOVdvyj7RvrzrXjCJxjhhtAJmLmov3Fy?=
 =?us-ascii?Q?s+3qfQNB0tGWKoKnuXmVOwcgKpisNoPDiqVT2rjXtMhGTwqY7f53DGnM1QW4?=
 =?us-ascii?Q?nPb0TS/DImBakZCLWWhvcuTGQxNIW868qrMVXyXFFKlvj3bawKTf7JOquFVj?=
 =?us-ascii?Q?gDyOT9oKVnqj5BJGuBAJsluwqlrLSXyAVmdbn4rdxt3U/zVvpor2cU+PtlbY?=
 =?us-ascii?Q?z7yiW/pXC/XvROwB3sXY7zZDekd8oDtqtmQNIxZkdRmvA0sRHgrI4HVhXypm?=
 =?us-ascii?Q?ARzj6jAYnYUYi6NyVf+g+6ZWs77bv6MAxNEVF1BtJToH0LsUlQqgzuk1FxRY?=
 =?us-ascii?Q?8632tpZQYveNLMDawBxDFffxSUnZMm3mNlMk8P+4K5JycLwQVj7Y0dNBqk1d?=
 =?us-ascii?Q?ZZ3BPogQkHMh+oW7LjKvD1MzyOzbB3AqQDK+MAWgiZ/U7PqGJO59bd+YlUAn?=
 =?us-ascii?Q?yOcDmvZ11BCKGodC5RQRle4oDs6uNvpRTlMtnYMDFWBgv1VvxZMjIuP8X9w9?=
 =?us-ascii?Q?Pv6o0urWED0C6uEdjjSEtbCyYAp6yX9L84yUgzozWnFsZ4nvtgbJ2lBDx/vv?=
 =?us-ascii?Q?g4pn0ATG0HWHhjQWyCEVjjHUNtVkAfbHTJYRno+Sewh5li9v/VRrqt03xidg?=
 =?us-ascii?Q?4ZBFRDfL9b1mr2RoznGiLNtYU4Fo7RHMtQWVeMFJJECns/GHm96xpnB3MN9Q?=
 =?us-ascii?Q?/Q/ksyHtcZaMD324+i5u7KIUikkDa4T+h/2DnO0atT6+3dT4OGs3lZ3zJuth?=
 =?us-ascii?Q?Fmj6QL1rMwlIdBSUPZzPIaEHlxBbhOcjQwFBI4qCBXe4+n4lKlAngoiTs8fe?=
 =?us-ascii?Q?N3holF/AGg2F6bZUA3JQYqUCds9FA3t/818DfBmsa3uMQor1PQyXfN0+Oca4?=
 =?us-ascii?Q?8KgiBXoQgQBaszXb6NornkTaht2j9rEKt3FoL6eoS6brAdfVMHjBPtEznSAW?=
 =?us-ascii?Q?KULhaJ3CpWeIFfu5iZE3JOUI000rw9ldD+F6xhciW24vB+gx6RCIUuxYajMR?=
 =?us-ascii?Q?XI/8tCll4OREYcbVt8S+bzEJyinA09rM4B79UqbFegad8N9qCy29VEFEfaKw?=
 =?us-ascii?Q?y2tHI3xWS9PLXyMJrxGfIpHMDvjRDlYVLXgopV90/cGvwl+GPWElJz0b+gke?=
 =?us-ascii?Q?sBDkHvf8u4ATSjXUUa+wEVT3Wk5MOyo7YA1/NCqbzQizMyHY1NI7QU5PPy4v?=
 =?us-ascii?Q?YFt4A05pfVFdST1c6nFLBWverSLLqStX1dY5jdiL2+NjMDo6F/N+jj9tkKRb?=
 =?us-ascii?Q?vV3L286QoG/ouUxFfIRGCxNoLGAr4bItsTQeZCU7Hkt04xqnzaoXSS/8u2yK?=
 =?us-ascii?Q?ficlzOELdNgAUDnEWs7iWnGlF3DaNGj6B49VNygBt25ha3fn4iICsXAQEE94?=
 =?us-ascii?Q?b7ngX5P3sp2FFccqB5UdoHkqFVWk3cuMlnhetbKNf0UTchDbp8LnVW+dau7B?=
 =?us-ascii?Q?+7+j6MXRsTpkgxJBhnU=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB51440224F1A3BC4D6CCB9B4AF7D32BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38c18dfd-d805-41a3-d29a-08dc99f7fcff
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2024 18:02:36.0034 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c3QD7mz+Oh0n/lPlISFYx0VffjUDSyB1EMVjS8+D1LLuPkWXKfCUh16YDD7MlWsTp9dOvU0oeSbcuEqsCd4SPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5928
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

--_000_BL1PR12MB51440224F1A3BC4D6CCB9B4AF7D32BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Huang, Tim <Tim.Huang@amd.com>
Sent: Sunday, June 30, 2024 10:50 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Yifan <Yifan1.Zh=
ang@amd.com>; Huang, Tim <Tim.Huang@amd.com>; Zhang, Yifan <Yifan1.Zhang@am=
d.com>
Subject: [PATCH 3/3] drm/amdgpu: add firmware for VPE IP v6.1.3

This patch is to add firmware for VPE 6.1.3.

Signed-off-by: Tim Huang <Tim.Huang@amd.com>
Reviewed-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vpe_v6_1.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vpe_v6_1.c b/drivers/gpu/drm/amd/am=
dgpu/vpe_v6_1.c
index 09315dd5a1ec..45876883bbf3 100644
--- a/drivers/gpu/drm/amd/amdgpu/vpe_v6_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/vpe_v6_1.c
@@ -34,6 +34,7 @@

 MODULE_FIRMWARE("amdgpu/vpe_6_1_0.bin");
 MODULE_FIRMWARE("amdgpu/vpe_6_1_1.bin");
+MODULE_FIRMWARE("amdgpu/vpe_6_1_3.bin");

 #define VPE_THREAD1_UCODE_OFFSET        0x8000

--
2.43.0


--_000_BL1PR12MB51440224F1A3BC4D6CCB9B4AF7D32BL1PR12MB5144namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Calibri;font-size:10pt;color:#008000;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[Public]<br>
</p>
<br>
<div>
<div class=3D"elementToProof" style=3D"text-align: left; text-indent: 0px; =
margin: 0px; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, C=
alibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
Series is:</div>
<div class=3D"elementToProof" style=3D"text-align: left; text-indent: 0px; =
margin: 0px; font-family: Aptos, Aptos_EmbeddedFont, Aptos_MSFontService, C=
alibri, Helvetica, sans-serif; font-size: 12pt; color: rgb(0, 0, 0);">
Reviewed-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Huang, Tim &lt;Tim.Hu=
ang@amd.com&gt;<br>
<b>Sent:</b> Sunday, June 30, 2024 10:50 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Zhang, Yif=
an &lt;Yifan1.Zhang@amd.com&gt;; Huang, Tim &lt;Tim.Huang@amd.com&gt;; Zhan=
g, Yifan &lt;Yifan1.Zhang@amd.com&gt;<br>
<b>Subject:</b> [PATCH 3/3] drm/amdgpu: add firmware for VPE IP v6.1.3</fon=
t>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">This patch is to add firmware for VPE 6.1.3.<br>
<br>
Signed-off-by: Tim Huang &lt;Tim.Huang@amd.com&gt;<br>
Reviewed-by: Yifan Zhang &lt;yifan1.zhang@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/vpe_v6_1.c | 1 +<br>
&nbsp;1 file changed, 1 insertion(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/vpe_v6_1.c b/drivers/gpu/drm/amd/am=
dgpu/vpe_v6_1.c<br>
index 09315dd5a1ec..45876883bbf3 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/vpe_v6_1.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/vpe_v6_1.c<br>
@@ -34,6 +34,7 @@<br>
&nbsp;<br>
&nbsp;MODULE_FIRMWARE(&quot;amdgpu/vpe_6_1_0.bin&quot;);<br>
&nbsp;MODULE_FIRMWARE(&quot;amdgpu/vpe_6_1_1.bin&quot;);<br>
+MODULE_FIRMWARE(&quot;amdgpu/vpe_6_1_3.bin&quot;);<br>
&nbsp;<br>
&nbsp;#define VPE_THREAD1_UCODE_OFFSET&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; 0x8000<br>
&nbsp;<br>
-- <br>
2.43.0<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB51440224F1A3BC4D6CCB9B4AF7D32BL1PR12MB5144namp_--
