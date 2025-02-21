Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B704C021B5
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2025 19:54:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A3B0210E235;
	Fri, 21 Feb 2025 19:54:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iK5pted4";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2087.outbound.protection.outlook.com [40.107.244.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C0D510E235
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2025 19:54:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R2oX46hxnz8DESypYvLG7C1BtRfbGtVFOAyQMGaPKBP9SygLshOqSRhQUCMk7Y/tYapfcKbNmEtkzy4ktiaRMRLpDzeEQbA6OAnJRi3L3pnkjBhhUiMkGEBl3MX4jxhpIvtEOQk1XlZX4RHKlWEAg1e4ijRyqI865ZuFCKBLRhdV7+z9aJk/Wfgx7UfDpneP/6+7PZM+rgGv5vpfHkNsnf7qhXbeTj7gkt/6POaotWoivtHwsttJWZIUOaXTwZueYkilOdbvHPPAMoZv2aoHJVKqMshwWZZ7CtFMAbY2BGF+ORnULormO/rD3K21hJOqI8ewvTfRGGDcuPTeX4VoEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hNenuNaaoWIYw+RY/FuWbVsZU65jc9rnDT+IR/SV/Xg=;
 b=HQQ5MbMR8zyKzOJHqbRwRfJJLihV0827CiPPlDyl3nZmAfqtIa92hLUwn1+WhllMh6bODLfsU1CQHWqKZso9FfMkdMY0KWkhUTIOtvRAK/Ib4DgMUyo+Zktj486lyea51vn+7Zujt+LONnqoVw4Ru/KiTLwRs5SLmBbbURrh4jiFqj4WoldvjZHxja2MGVZ3/jT8TqdzqUNyWkyqa4ee/N9f7dOYJD6/SLqtrveK1fUk5YPIWMmggI+CrNpGqqsWf/PsRI88as5WVrgNLEWKcdtFb7N08YslUwHz1vWS8bo2TX8JKTeh3UGbm2cL8GCuIRXAtOyBDfIbLrMLNZsnew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hNenuNaaoWIYw+RY/FuWbVsZU65jc9rnDT+IR/SV/Xg=;
 b=iK5pted4gl/Z7tbtuRiFDqVDFl/x2xi1lY5rNgSIKZaHvsvM8Ax+AkA5aoCTlnUxA+meU04hdZ4Adr88sauebUEg2vyMxK9CZWov2dfI23ziH8Pe5SXPDW4bh3D9uPssktOP3FKf9npx651HX3Eq39pQEo9zWZTJxGdslbc8Fas=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by MW4PR12MB6825.namprd12.prod.outlook.com (2603:10b6:303:20d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Fri, 21 Feb
 2025 19:54:23 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42%4]) with mapi id 15.20.8466.016; Fri, 21 Feb 2025
 19:54:23 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Wentland, Harry" <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)"
 <Sunpeng.Li@amd.com>
Subject: Re: [PATCH] MAINTAINERS: Update AMDGPU DML maintainers info
Thread-Topic: [PATCH] MAINTAINERS: Update AMDGPU DML maintainers info
Thread-Index: AQHbhJZVL/swBXL4cUizgjW+RB6uf7NSK49k
Date: Fri, 21 Feb 2025 19:54:23 +0000
Message-ID: <BL1PR12MB514421EE3C088E68D8718B79F7C72@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20250221192503.320868-1-aurabindo.pillai@amd.com>
In-Reply-To: <20250221192503.320868-1-aurabindo.pillai@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Enabled=True;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_SetDate=2025-02-21T19:54:23.080Z;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Name=AMD
 Internal Distribution
 Only; MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_ContentBits=0;
 MSIP_Label_dce362fe-1558-4fb5-9f64-8a6240d76441_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|MW4PR12MB6825:EE_
x-ms-office365-filtering-correlation-id: d7c67b88-770a-49c3-c2b8-08dd52b18a10
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|13003099007|38070700018|7053199007|8096899003;
x-microsoft-antispam-message-info: =?us-ascii?Q?uokmiWv2eucWVosXfeg3UeneJqT7HXM4R3p1MCsxjZ5fZEzrQzwS8xwp8WPq?=
 =?us-ascii?Q?Q3Lez6/uLdzqAcifwa08br6JpIqpvPmfuFRfPL7E7hr7vdn2xadrzLo/bKAO?=
 =?us-ascii?Q?0HzNs3XzokJEqBv2Rg74nq6MA2J/Cp0NOljfWjmjSq9i0cjIXsetKsohL1fF?=
 =?us-ascii?Q?7Ko7wUf0g4kgRIsNCJBvNj4zMVFRhZU+bvOWft00jxknBKk/0879el8HA82X?=
 =?us-ascii?Q?mbMrNTRJjXHqTZAc0YCImbn+PPoDlkR3dCZb0Si4FeCJmr0rVCEKlZSyrsb+?=
 =?us-ascii?Q?zgvLZfw9LaZhf/VvZP3AcUmZ5ul17ZVtUmjaMswnHelWB4WGBozBlwa2FdQm?=
 =?us-ascii?Q?QAfoqJHQQR5SO2l6xi9KpNyeWEyGYpTpFu5GUIWq7905pvuJ7MPlxCYf0sc4?=
 =?us-ascii?Q?XPFVdctztZoKj2XUyNRERVeLoX8mZeGGPIwkDEBtqp7X/36xmU3ihZQ8m4+j?=
 =?us-ascii?Q?koEX5btlNLfF3OXNwgpzB8klgKHpODuUPOIxDPapNnrstp+f9wXrLXEyT3fq?=
 =?us-ascii?Q?1oTq8m3aQLHgDYSEaOrXCiuj/W5qF+t8dbxue1UHx2X3y/mO/nl082PnlD6i?=
 =?us-ascii?Q?YcPGyXghCTo0UC+Obkxq+pZwkVYGniVSfGyb+QKK7zlU1OhUufvwXzM+alyj?=
 =?us-ascii?Q?NFX+5NTLFeXZ+ced5jhfaet0fGo1OoNK57rEWOvr8bsTwSqHQuBvZoUoRK1l?=
 =?us-ascii?Q?XrWgkHLpKtwKXMnFM9q4i9Hdv+zIngP1znDE9R04WdpObxUpNg1QwMv0bC5a?=
 =?us-ascii?Q?pbatO7vDrU9F7/MUvzLCpIMuO6UK6gpkl2dNon2h42zReeHIn2mjr3TWLySA?=
 =?us-ascii?Q?7elKUeMmBz1VDordkV3nNX1Z0gfzIWmYr4T7RN4pZD3h5T82zbw158jVXbQ0?=
 =?us-ascii?Q?56OE+E855VXfApS+qyvqKaqp4IcC9MG7OztIvHpiQOWdQmQ1IQ/InnFjYfJW?=
 =?us-ascii?Q?xQCfF9VT0WL2/3Jik46sRtE5Yuii1yYBJSeevER6baY6ONfGi/6yHRlpOgHj?=
 =?us-ascii?Q?UtLe4rdZiBLq6HXxIdzYU4iSQ14hHM1s0yX5SkPUIE3cBvHsabni9jnO9V/3?=
 =?us-ascii?Q?iSdRsJp0dzUFvJLHaKOOTEoFm35gaN6UQmCzK2sOmMF6VYTpRzSnF+t5lDoM?=
 =?us-ascii?Q?DjGWX7+U3xCVs9pk1dkYqVsIk1HEicKZpel+MA3d0nLioZrXxAMtwpLrOvyL?=
 =?us-ascii?Q?SKyPR+m8BCGy2O6gCgWouUBwC6qRtb9PSNK6Uw0F3HfuPeeZX2HREl+8ZulG?=
 =?us-ascii?Q?U5Fff6z5icgd4wbBguxV3mNxGFYxAb6JjoBOt1VO/td0jOaBfOSDjWUwH/3e?=
 =?us-ascii?Q?9i2R0MArZ8mZg40KawdFTGSC6BFDy2GE7kJWsamcMrxtVAlgb7j1vSa6ZU4i?=
 =?us-ascii?Q?Hb8pD2YHvRmuOpcsUEQnbBbg+XlD?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(13003099007)(38070700018)(7053199007)(8096899003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YxWZT/7jom/Me+WOMAhlI76x2Hj6ZS89yc6iFmGFsMI5K6c6D9vVMmHp1gO9?=
 =?us-ascii?Q?/L/hsa+Cpp8svxlJ941nswhLf3FHcdMRcz/Js9fBrpen0W2N4CGAZo/IqZ2m?=
 =?us-ascii?Q?rH+sn8vEHoH80Am8I6+cmDmA1Eq5Z4qfg0L2zYEp26magtRqynoZO0EoRPmq?=
 =?us-ascii?Q?b0WYbxSX64cj/7LfNIMImzWFmiH00Clcgn/2Z7Dr1wDhtzDxHT3aRKjW9wjX?=
 =?us-ascii?Q?ts5312LVdDsd2SWMVrjGngeQE+/Vruu1HJQrH066wgxyPgz1YcPmi14A31+p?=
 =?us-ascii?Q?8Ov7Rm5IcM6jz7x+qFpLMlA50J6Gw936Za2lIHUCagfOrxOmc1bEWTbkFDLd?=
 =?us-ascii?Q?jMq/gvKEMcz6WsoAkAaToIwD0ebDrvlSznrsfKqQQkTg0vy2vy3wqFUrZPJN?=
 =?us-ascii?Q?nFu8z6wbxusFoxtoZWYvevHUwuSNABhniSaDgfLMp0ATbvSemBpVKeA6wDjo?=
 =?us-ascii?Q?APfO7lgUffcJm//JNfZvEaCZyn39zCZOE3vZB7Ffw+3NlftASWO1GHYYGtEl?=
 =?us-ascii?Q?VAXfT9Rd6KoX8huTlly6N6RBjmcmSZF3wIpuLHNfEuA9fCFZeWa5t/bmnglw?=
 =?us-ascii?Q?+eD5h/qLtFT49g6Q+XDfLh+Ta4R4yELgySQyTbJv3SceiFS1Z07of7sYfyPA?=
 =?us-ascii?Q?RMmVm8uxQe4+WMFMSxqQAaJBpoUXi8bRqpPQF5ZFMRSPH1lCjxaEihfH3YT0?=
 =?us-ascii?Q?p1D+jzUtrKkdIW0NSYvMUcsSQTHsI1MvuDJahBPFkCIOEQb/ZMLcMwOar7f9?=
 =?us-ascii?Q?oPWNUsvNDB9syzFrUy1C/eDSoWqQ2MpTUj8a6rhwaCUJFa1AILIiwWudGyPl?=
 =?us-ascii?Q?ULj7f8BdiozoMSdRNawjqd7Qo+ZXQG/CDNAi+zoh9Ws9OfBkyZ+LY7Zv1lAN?=
 =?us-ascii?Q?FKv5+a5u2x0VqwX8sFx3d2Zpg5WetNn1oypLyaJAvSJJwhRpeZcrJfkHr3nF?=
 =?us-ascii?Q?RaLgoVIO9xxhsSa7j9/191zLDUPOR1vZXRJ5dHwiZXMzZVbxD1Jj5S7dShiI?=
 =?us-ascii?Q?AAmzzZ+fgvGrxa9r7mxUUYYG5xioMbn9Sfhkwm3rUyS3i/WfhXTmhARPxGOD?=
 =?us-ascii?Q?WcUBZh53VJO48um+tAXyheeXuGGb1LOqv1tG4DscaPTlf2w2Tww9glZXn+yy?=
 =?us-ascii?Q?7CpJZsnfnMWwd89MHB80zBN7O96GoHtZ/uWKkNSo9OplnlsfR9dpcC/YYyQA?=
 =?us-ascii?Q?fpCPyZLfdXz+yLvUsZgY6NeuEWXgy6ShMyG5MdZcNt6307ebxB5aMSjzWlz6?=
 =?us-ascii?Q?dH2cr6npv7I7j83u1z98A5BC0Hd7IHqdfV44itQP3G4wxGxTi5VWRBkiW5km?=
 =?us-ascii?Q?JwSmXzLP/DYi6vzguHIjH038gvufSzP9jnm97Twb2VtM7gKL6LyVrdyftWm9?=
 =?us-ascii?Q?0yzHCOJ8YaPR7ShP6ynS88bMbqIgGNe5fhLTHpeLbX6wVo1DnWV6gPhLZeEZ?=
 =?us-ascii?Q?tMiqaI21fhNtXHS26E7nJcbxsmIrPA+hOroT7oS2Jxsd9hXieoOkoEc56tjA?=
 =?us-ascii?Q?ALxLRsSb/f0ILZwh1mAKY1kCqdRBOC9bP+qrK0CLv3Z6aVhxUxB8EvIVeecu?=
 =?us-ascii?Q?RWfLfdIJPMDi4ZIFGak=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB514421EE3C088E68D8718B79F7C72BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7c67b88-770a-49c3-c2b8-08dd52b18a10
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2025 19:54:23.5114 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: smrRKK2idwQ0Fi+QJOcD+xlm7IheGeV+sDf8rG0tpQ3d7TPqTZgd26kCRgPAu9hVqRvUP+u4orE/cN5ICnC3uQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6825
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

--_000_BL1PR12MB514421EE3C088E68D8718B79F7C72BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - AMD Internal Distribution Only]

Acked-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
Sent: Friday, February 21, 2025 2:25 PM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Wentland, Harry <Harry.=
Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.Li@amd.com>; Pillai, Aurabin=
do <Aurabindo.Pillai@amd.com>
Subject: [PATCH] MAINTAINERS: Update AMDGPU DML maintainers info

Chaitanya is no longer with AMD, and the responsibility has been
taken over by Austin.

Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index c8b35ca294a0..d167946f88e5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1031,7 +1031,7 @@ T:        git https://gitlab.freedesktop.org/agd5f/li=
nux.git
 F:      drivers/gpu/drm/amd/display/

 AMD DISPLAY CORE - DML
-M:     Chaitanya Dhere <chaitanya.dhere@amd.com>
+M:     Austin Zheng <austin.zheng@amd.com>
 M:      Jun Lei <jun.lei@amd.com>
 S:      Supported
 F:      drivers/gpu/drm/amd/display/dc/dml/
--
2.48.1


--_000_BL1PR12MB514421EE3C088E68D8718B79F7C72BL1PR12MB5144namp_
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
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 12pt; c=
olor: rgb(0, 0, 0);">
Acked-by: Alex Deucher &lt;alexander.deucher@amd.com&gt;</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Aurabindo Pillai &lt;=
aurabindo.pillai@amd.com&gt;<br>
<b>Sent:</b> Friday, February 21, 2025 2:25 PM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Wentland, =
Harry &lt;Harry.Wentland@amd.com&gt;; Li, Sun peng (Leo) &lt;Sunpeng.Li@amd=
.com&gt;; Pillai, Aurabindo &lt;Aurabindo.Pillai@amd.com&gt;<br>
<b>Subject:</b> [PATCH] MAINTAINERS: Update AMDGPU DML maintainers info</fo=
nt>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Chaitanya is no longer with AMD, and the responsib=
ility has been<br>
taken over by Austin.<br>
<br>
Signed-off-by: Aurabindo Pillai &lt;aurabindo.pillai@amd.com&gt;<br>
---<br>
&nbsp;MAINTAINERS | 2 +-<br>
&nbsp;1 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/MAINTAINERS b/MAINTAINERS<br>
index c8b35ca294a0..d167946f88e5 100644<br>
--- a/MAINTAINERS<br>
+++ b/MAINTAINERS<br>
@@ -1031,7 +1031,7 @@ T:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; git <a h=
ref=3D"https://gitlab.freedesktop.org/agd5f/linux.git">
https://gitlab.freedesktop.org/agd5f/linux.git</a><br>
&nbsp;F:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drivers/gpu/drm/amd/display/<br>
&nbsp;<br>
&nbsp;AMD DISPLAY CORE - DML<br>
-M:&nbsp;&nbsp;&nbsp;&nbsp; Chaitanya Dhere &lt;chaitanya.dhere@amd.com&gt;=
<br>
+M:&nbsp;&nbsp;&nbsp;&nbsp; Austin Zheng &lt;austin.zheng@amd.com&gt;<br>
&nbsp;M:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Jun Lei &lt;jun.lei@amd.com&gt;<br>
&nbsp;S:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Supported<br>
&nbsp;F:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drivers/gpu/drm/amd/display/dc/dml/<=
br>
-- <br>
2.48.1<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB514421EE3C088E68D8718B79F7C72BL1PR12MB5144namp_--
