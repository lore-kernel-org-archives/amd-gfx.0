Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E8D6C2BD09
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jul 2024 18:03:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B4A710E4CC;
	Mon,  1 Jul 2024 18:03:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="04p5T3iG";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2085.outbound.protection.outlook.com [40.107.220.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 392A210E4CC
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jul 2024 18:03:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ShddjuZH3KH0IpNQBIjy425UOGVNxnKJxU/q6JcPhpQHddfayXxshR+oW43K0ZGl/7WnlYYUVpIEaTALW85w5IXKDi/5S5/XM5OTJI0YPqUK57L8ZCumsF041kmbdZPNwd0Ph/PaDRj95/JoDdNfCBE2FX2SR9bsHE26xL9Vgce3Xmxb36vh7RNmk7Kbj31ICqL6xK9QzBOki/8NH+oe8DkohkjH0UpuF8nh3uanGrpJU81oek5ugSU5KDtItFu8ExMUyb8WE7gghOyeiTaVLZzm3n0Fh5AON4QjtBs1ddHF4XLN8ayjM6ByVjclml2yfBqsMV3jZeh6xIjXP3XDkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PZL+kRUS1xvs0t5Y+ggj3zhdBvLrFfgc5i+HSXI07wI=;
 b=bpi8DgJrlZBbdZBEsIvRbJI4+Gsv8imGH2N1UfxwnY/OOW8PyiYb29n+23/3XbsYF7qHiCJdKf4Lc293KYFSNoXS2r/OaY3o6QwIVitvd9oBzsET+vlc1YpbrTv7/j8k2zmMIbMwajNiAiwU/j/b9iZtyYkV0eyzcgmsLX6dQjSBViQiC6gjRIi0XYZ3fcIqxIHhc77dI/EMGJoY65dDxeYD7ilU9vN2geHglbpg6hnGuyt5lcOVDK4SR1WXz6HEuahE6BFTPnSh6nzu1/UiSxHBdYRTfFqc8w38ioABFr3wI+YM2FsvlAAwdRpvwpAGn+HqcNIoHFwhoiJAowt1jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PZL+kRUS1xvs0t5Y+ggj3zhdBvLrFfgc5i+HSXI07wI=;
 b=04p5T3iGTQbYpbamRkysp6cwuJJRaCXE0G4r6MiBpdd8Zrk8/OjlhmhYXmHjw/C/g7tliyiwmQHcsl+LpXvSIqy4axZteG4aB2u8f82kPEO9vOCcRtcaYrv9vOM2I3gVCBQnb1aWaYN8nph4qGrMhVD3etgDMlSl82OZtpMaiN4=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by PH7PR12MB5928.namprd12.prod.outlook.com (2603:10b6:510:1db::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Mon, 1 Jul
 2024 18:03:13 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42%4]) with mapi id 15.20.7719.029; Mon, 1 Jul 2024
 18:03:13 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Huang, Tim" <Tim.Huang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Yifan" <Yifan1.Zhang@amd.com>, "Zhang, Yifan"
 <Yifan1.Zhang@amd.com>
Subject: Re: [PATCH 7/7] drm/amdgpu: add firmware for PSP IP v14.0.4
Thread-Topic: [PATCH 7/7] drm/amdgpu: add firmware for PSP IP v14.0.4
Thread-Index: AQHayv4h2q0NE11ja0+GQyIz5oBLirHiK+Cz
Date: Mon, 1 Jul 2024 18:03:13 +0000
Message-ID: <BL1PR12MB51442F4DF0F9CC2906447238F7D32@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20240630145831.2023399-1-Tim.Huang@amd.com>
 <20240630145831.2023399-7-Tim.Huang@amd.com>
In-Reply-To: <20240630145831.2023399-7-Tim.Huang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2024-07-01T18:03:13.380Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|PH7PR12MB5928:EE_
x-ms-office365-filtering-correlation-id: 0f50d76a-7dc5-4267-4ce5-08dc99f81379
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?4JWAqO4fcUsiO7InQTUi/q1LhmbaiAgDl8tsIBV+J5Gw04ehzveaQ14dW5Ms?=
 =?us-ascii?Q?mAkoy+EPLPzvArs14KDGLATYwZssr2drZ8jz8xM2T+zExyr/6pZaZ1VHwPFZ?=
 =?us-ascii?Q?hte5iZH7jn5yBhNIZ17sg4RvMsr19VOMHmZAZJZ+ti76Uk1tb+COskUWaqiM?=
 =?us-ascii?Q?qmboyMQ97UIWfdlyKP3to+d1rYQNC7OQBUIMDTqqQ1hVkDqf3zSkA0fIVtdM?=
 =?us-ascii?Q?+SJVEJFG5cqaA1IkcFkp/WJraDrd76P2qtRnicvtJX0hG1Vlbnp18GcqZ98Q?=
 =?us-ascii?Q?wlvV4AohmiohlR+9JAMb2ZAdxt3NxMdM3Hoxy30vkXNmt7wrQ21GYRjzYNRA?=
 =?us-ascii?Q?9ZZEM1enQpRVzgGU9N28enzuyrJiMaNxnPypdkaT/ObF9YGcHkMSyceeuCLh?=
 =?us-ascii?Q?BHwS4PIx5juuDBSoxsWuHlxM18FFSU6DS67evivfJK6KOOqZoNL54Vpfq2hU?=
 =?us-ascii?Q?mAOybxE+WbOt5qCGJ7/vhiWBZ6s4+9FMAF0Sgh61cJ1ttwI5QF2I1SNkUpvb?=
 =?us-ascii?Q?ro4knkglvlqi1P0N2yyjx6/As2aVqF4kNUQ0JQign8P8YSdWa9c8cM+DW1UH?=
 =?us-ascii?Q?xSJgYIjG8ez9237tTyOUx9N4Waw01CNN2R1zfGtQEK1ZfZaHhKMhO02UIyLH?=
 =?us-ascii?Q?dsKvb8XzzhMiJZQfPxPZ6yCr9JrrLAiBRsMD6edQOQ2kYY/HfMc2c3V3iJpo?=
 =?us-ascii?Q?X3jPGKRbQCcS8KUcwN1fbGA0yIPlL1IQ2jtNtWhXPmsEvw48Kcw3HYck4gaU?=
 =?us-ascii?Q?IEpZIeRybPdB4oOswFuZMdi5B+BsvYbJfM3Ko7JLsmrysAsDOu3PNDjfcs9C?=
 =?us-ascii?Q?erbXWBWDOAYRAANXf9aebUEgA3Evuvpk0NbDedHGmccoMTa7+vl6R/UvKj6N?=
 =?us-ascii?Q?WhPLM3ufG+FQJTYH/CEDZ6eT+SytQS1mQL6ps0tII0iuz+H+q+Q9+XfV2NOE?=
 =?us-ascii?Q?l8aQZIGH7PLL2su2uloWN6kqI69ip/fPic9fpaPf6cEspkNKIw16l1WWW91Y?=
 =?us-ascii?Q?YopdvhDlX4CF5B4rcXi8AAH8kfMO00ZEBLGXzGRDKLZaOTRy9NIkcVN1SNZi?=
 =?us-ascii?Q?vV/a3mrGmTlb90GT4hiURzg6AvJGBMRZ4ot89CWZbE3iBpl8dqtcNqcj99pZ?=
 =?us-ascii?Q?0XzXQoQAOSa2csSTHfAHAanejtRbJSuUfDrohbesiEl1oFCzTE1zywLF/pE5?=
 =?us-ascii?Q?GUKSyrX+rOA12GuJf+8tRVDAwjwVVQakQf8svoVeQxqsZRNEcJqACSjqPyhO?=
 =?us-ascii?Q?UGR8mJ/UUEqhxTxOJ8jIwc6LKqPemHe2SSHyGm7IryitldFrmq6fnZhspdJH?=
 =?us-ascii?Q?TS9tJjrZr4k2bGVXrZYdZhjIHaMQki82XPhZoHINqLj3FsfwR9lYnLSydGAe?=
 =?us-ascii?Q?ac3c+iWmQEIRbZa+DpJyUF03xGcgTbyYgkAEj9dHp7GoA/Fwkw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5XKYS4aHB07R87wUuHaZF4q1Q6b3zUvkzoYavvdiIKZiA+3+0FeO30nNcnAh?=
 =?us-ascii?Q?GMmFkDTqsR6fWQyWr0gnHO2u+mTwbq1gUYBxQ9IhsXEu42go6E+AeQmbqWXY?=
 =?us-ascii?Q?KIdr5RCH2pVODN5PjhvrPIVKFO0UIAIYHgWzNV4E48hOSmlaezdjjBfZWZPI?=
 =?us-ascii?Q?L9ejfUF94p73t32I2AbJEWedzOhFeMld3fTrNLbCP40PInWGpaqcXYPGXhMP?=
 =?us-ascii?Q?z2JnN2eRerEZ9K5tHms65TAfbiHGm43jDh1BrsE6LP0VzC0G3FDC++rWFHI0?=
 =?us-ascii?Q?7kjGtbkNJcVJEEj9zStJFP0xnWA66Yc1YO5s1YIuVA8vIhU7XN5r89OWoAdj?=
 =?us-ascii?Q?DPnPnZhzyxBSJ5NPgZRPmUoY1x0diBhwBP99fHR2biKaWFPYyzb5i5zb9b3f?=
 =?us-ascii?Q?vIHTzMWCTxjUqOzdQSvbOs8qQUkblICV0e73wPRR77+8ZXtwFTLYcNhLmeQ6?=
 =?us-ascii?Q?lq7EvT5H7nTQuctbDhqU3tSxrVXq82U+LOOXWO2gET2l3tpBRiZzI9e4XzTy?=
 =?us-ascii?Q?cX0X+hAENfsFaXoSLxhVGT/otwrcCyJiylhJcP8xOfQvoEITllZbm0dt6CB4?=
 =?us-ascii?Q?eO4F8Tjb0t9XlifetLXugdGcUMGl7mWQXFYQr1QUnGiCoQrhteMJPpoc4yBW?=
 =?us-ascii?Q?G2B0ed/FD5q94+cQ6cfctu33onCLOAhL7y+uO1TUdwiYrBhQQbHpAaeABtlb?=
 =?us-ascii?Q?8G5zGJCvjn9oYIL6DMf95DJgA7Ig4UUuq8GhHVCtzYrSDv5bVNaV+st3gqsE?=
 =?us-ascii?Q?CEYLnA/l4zqig/r7AkTHS0UdfzWCa0Jl93CdhIeL1PQBBVFKoO+p2E36Jvgm?=
 =?us-ascii?Q?XU3JIAvB+fhXqwX0k+wlvmpfvgTFzlOvkNAg0tq20iNEJwZoyx2ZFFnOmP/K?=
 =?us-ascii?Q?H4MdE9E5zvVuP42Trkz1NUSgiF8gy+524ujfojSFSG65R/phmTUz5xgIlhNY?=
 =?us-ascii?Q?viM0lsbdD8RbUWbCCqIwcT4f7Meb17MjiCCcPzUA0v92MLP4/ZTyOoKLSVhL?=
 =?us-ascii?Q?G9rAOJ04Alc3ZnjKZ+POegjR6iISzJaxXGBWoRMWAf/TG2O77FvlHRj8OtgG?=
 =?us-ascii?Q?tQO9Jj9LUp2SlwWswiVSlOfpTvaVJiajOjyJ3b4fDn4Q1/EgEOsgHcD3rZCZ?=
 =?us-ascii?Q?ePP38kKW6GSLyvKpTl/hvUcIb7oGKewHz/A+7XLbOHbliCMp3kRYPD6gmbNA?=
 =?us-ascii?Q?mHIXRhBaEDUE9eDtrI557aldlJCEMJ+YpZnQJekAsUKVWLHxiKTXzH78IBzr?=
 =?us-ascii?Q?EeICSiNuCFn4rd7HJILxG/a1UCtJP+bgSrGpzqUnknHPsJ9RXL7RQnEJFkk0?=
 =?us-ascii?Q?2mfH6+b6QXBs3ycmCS3soIZF5vL2NcELwd1ixAQ8dxMTcGDSJ9rIFYVlqHKp?=
 =?us-ascii?Q?Qznmh60ji8ZnY41f6fkFK93qecU/ipDuFpCYWUlW0/m2JvchKnezkP/NKG6X?=
 =?us-ascii?Q?8f4wVXGWSQJ27/bM+vbnFQX8oRFErVSSIW6cJpPpOchMWL0Wi/jf9v6jqQSW?=
 =?us-ascii?Q?/SwoFhq1PNFS0+LPw/9tQV4zx4MS/g0KsmObGnVyoODm2lXLLTYtWwxqF/FP?=
 =?us-ascii?Q?hDSmYkZgQWwY4zi66HI=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB51442F4DF0F9CC2906447238F7D32BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f50d76a-7dc5-4267-4ce5-08dc99f81379
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2024 18:03:13.7411 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EgehRwTOgbAyaGwdwk3Rtz99Dwj/vM4fLcwnTaAUMCVA29GgwK0FfZ8UNBXrE+h614tDwfpFltjsvrwfDD5Onw==
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

--_000_BL1PR12MB51442F4DF0F9CC2906447238F7D32BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Huang, Tim <Tim.Huang@amd.com>
Sent: Sunday, June 30, 2024 10:58 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Yifan <Yifan1.Zh=
ang@amd.com>; Huang, Tim <Tim.Huang@amd.com>; Zhang, Yifan <Yifan1.Zhang@am=
d.com>
Subject: [PATCH 7/7] drm/amdgpu: add firmware for PSP IP v14.0.4

This patch is to add firmware for PSP 14.0.4.

Signed-off-by: Tim Huang <Tim.Huang@amd.com>
Reviewed-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/psp_v13_0.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c b/drivers/gpu/drm/amd/a=
mdgpu/psp_v13_0.c
index 407477b895d1..1251ee38a676 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c
@@ -57,6 +57,8 @@ MODULE_FIRMWARE("amdgpu/psp_14_0_0_toc.bin");
 MODULE_FIRMWARE("amdgpu/psp_14_0_0_ta.bin");
 MODULE_FIRMWARE("amdgpu/psp_14_0_1_toc.bin");
 MODULE_FIRMWARE("amdgpu/psp_14_0_1_ta.bin");
+MODULE_FIRMWARE("amdgpu/psp_14_0_4_toc.bin");
+MODULE_FIRMWARE("amdgpu/psp_14_0_4_ta.bin");

 /* For large FW files the time to complete can be very long */
 #define USBC_PD_POLLING_LIMIT_S 240
--
2.43.0


--_000_BL1PR12MB51442F4DF0F9CC2906447238F7D32BL1PR12MB5144namp_
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
<p style=3D"font-family:Calibri;font-size:10pt;color:#0000FF;margin:5pt;fon=
t-style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - AMD Internal Distribution Only]<br>
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
<b>Sent:</b> Sunday, June 30, 2024 10:58 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Zhang, Yif=
an &lt;Yifan1.Zhang@amd.com&gt;; Huang, Tim &lt;Tim.Huang@amd.com&gt;; Zhan=
g, Yifan &lt;Yifan1.Zhang@amd.com&gt;<br>
<b>Subject:</b> [PATCH 7/7] drm/amdgpu: add firmware for PSP IP v14.0.4</fo=
nt>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">This patch is to add firmware for PSP 14.0.4.<br>
<br>
Signed-off-by: Tim Huang &lt;Tim.Huang@amd.com&gt;<br>
Reviewed-by: Yifan Zhang &lt;yifan1.zhang@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/psp_v13_0.c | 2 ++<br>
&nbsp;1 file changed, 2 insertions(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c b/drivers/gpu/drm/amd/a=
mdgpu/psp_v13_0.c<br>
index 407477b895d1..1251ee38a676 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v13_0.c<br>
@@ -57,6 +57,8 @@ MODULE_FIRMWARE(&quot;amdgpu/psp_14_0_0_toc.bin&quot;);<b=
r>
&nbsp;MODULE_FIRMWARE(&quot;amdgpu/psp_14_0_0_ta.bin&quot;);<br>
&nbsp;MODULE_FIRMWARE(&quot;amdgpu/psp_14_0_1_toc.bin&quot;);<br>
&nbsp;MODULE_FIRMWARE(&quot;amdgpu/psp_14_0_1_ta.bin&quot;);<br>
+MODULE_FIRMWARE(&quot;amdgpu/psp_14_0_4_toc.bin&quot;);<br>
+MODULE_FIRMWARE(&quot;amdgpu/psp_14_0_4_ta.bin&quot;);<br>
&nbsp;<br>
&nbsp;/* For large FW files the time to complete can be very long */<br>
&nbsp;#define USBC_PD_POLLING_LIMIT_S 240<br>
-- <br>
2.43.0<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB51442F4DF0F9CC2906447238F7D32BL1PR12MB5144namp_--
