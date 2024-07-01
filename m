Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFCBBC3065A
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jul 2024 18:02:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B14710E4BF;
	Mon,  1 Jul 2024 18:02:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ImgFfAJn";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2046.outbound.protection.outlook.com [40.107.93.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF23710E4BF
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jul 2024 18:02:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZHDzJIgzQqmuhvv2cUoUlO4kZGICaAValjlrQUVaaC8URaYMZGq6e9IipqTH+ZTydaN1qiCpGo25lA94hKGMqIiS0RRIqXptE9L9siIOSdgBnooyJy7e3tZreO//FMJiJ/tJGhh01qeDg4eCW9RsU4rQkqxHFYprarvLYCx2BKeU/ireeg8kZYquyvcjWWxgpreQnWjiSYcAbomS1NPjd0/Mit9gPnQ0Hh3xahd0/3CskM6mJxoRtd8IdBEOQQuOi7pvUZnAQroyfOJyzTWKB40CbX54hRRmxi3mBStufUXIVRKarmRQmkUhiThd0vkUZLHsC5/z+tYUkpdNBefPSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OBBivLkSuN0R57vcIBpQdf9UHRUbiVcN1KjG4L5W7bI=;
 b=XNL9EqIAWORNY0DXLR/tlFrvqy6xjrsPt7bNgSWcBORXmgU+B02B4aK8c8cGumpT5H1ti3AcdzWA5h/mzsPTDDNJ3nRgu8VszG3zWeUZRdXEwLJxCyWG0SwirIGTo2cvuRZwCxgYaEwXq3Zsx6EZtIqyKw+kt9CGlQmYsrxdScixRIS3pFfobze7bFLpu9Q1mfqpcHaQM3eo41Gtss/n3oT5YotKghGVi3PaUB31S5OH1oxDOWlWV1+sUX11Y0CDgdgQUCNrp6Rj8jC3X/GjyZf8nY9UxFqgQ1hkq/DMoBks5IXT2L1Nd0sOBGYn94BW7+EZnqGZv4uPiLofnCUjFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OBBivLkSuN0R57vcIBpQdf9UHRUbiVcN1KjG4L5W7bI=;
 b=ImgFfAJny8Oy+PyJHgDyuOrOqmzIT6VGEsF2AB3LsNxCpb9EeXvVQb/71r2MOC8BTI7vyKYFx6bjJnTett45IAFwIuJ0krU4DENvvsnAL+UY1R6fbk+3w0N4B9JcLt0/7xFsydmOU1h7yAfF3p9J/l1rJC+3hZ+EBUil69NQlR4=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by PH7PR12MB5928.namprd12.prod.outlook.com (2603:10b6:510:1db::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Mon, 1 Jul
 2024 18:02:19 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::491a:cce3:e531:3c42%4]) with mapi id 15.20.7719.029; Mon, 1 Jul 2024
 18:02:15 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Huang, Tim" <Tim.Huang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Zhang, Yifan" <Yifan1.Zhang@amd.com>, "Zhang, Yifan"
 <Yifan1.Zhang@amd.com>
Subject: Re: [PATCH 2/2] drm/amdgpu: Add NBIO IP v7.11.3 support
Thread-Topic: [PATCH 2/2] drm/amdgpu: Add NBIO IP v7.11.3 support
Thread-Index: AQHayvy5PqIw2Vr8kUiAcFjJP0NrebHiK5mf
Date: Mon, 1 Jul 2024 18:02:15 +0000
Message-ID: <BL1PR12MB5144B621C8C1F585498425F3F7D32@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20240630144852.2018966-1-Tim.Huang@amd.com>
 <20240630144852.2018966-2-Tim.Huang@amd.com>
In-Reply-To: <20240630144852.2018966-2-Tim.Huang@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2024-07-01T18:02:14.868Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|PH7PR12MB5928:EE_
x-ms-office365-filtering-correlation-id: 57b1297f-d471-4c66-e422-08dc99f7f0aa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?UwFNvcTXLFiOcTiDb0TaXgHASgmOL8FlRwtUIyalxhOlAUVCIq9Kwa++ypTg?=
 =?us-ascii?Q?8LOn9Sfr2Xr2QDQVFwpE9BDNBUU8O8Z8+f5krOJivYSsTLixH2aTY777a80u?=
 =?us-ascii?Q?77425fsV2FBLN1tv12a/tB3mYaKE0Z57Y+AoDUPPHJicVJlSMlr9y0qb2pqy?=
 =?us-ascii?Q?yzasjqje9v59LINYOZk3Pu+RIeVjAn0QDKtWE25wj8DVPgfc1LcQwSe1Ce1Q?=
 =?us-ascii?Q?DeuS97FRP18N/A6IDS/D4eEBRuaA/zhwEIMF7A6MxvFeN+x8nDYQQJK+iVBV?=
 =?us-ascii?Q?OorBMdDLBAhDEt3wqxkdIis9BKFej1+3SoCxxlIZyzZS2siNJ8oLNdcS8QsP?=
 =?us-ascii?Q?rcfjrfX8JH9TICJGrmXUvW/KU7fV/rMDAXe5fwWUZCWAY1P9cULxRhdyd+od?=
 =?us-ascii?Q?7zdBvYLnNOoHBOG9BH7MBIaY4CdhqsbHmPfAPXu5WsuTcoZpeEmc6wMQKRtx?=
 =?us-ascii?Q?sBwKTdTonJkdeEHBedSeEX0zG8GMFXKlhBeRZXhzFM2ojBk3TkDMRpEg/Tsj?=
 =?us-ascii?Q?0FfmIdCqOPt//XvH8QyZkbEKrv8dgOh+lXlSTb3AjZPYCmA0WdtFH5yvGIV8?=
 =?us-ascii?Q?gTtxCmnU+eU033zUXqB6wWuFLvCi73R6OqnanL5zfZy9klpuVu1OBlUszbLC?=
 =?us-ascii?Q?AopGG7iMuLhYWoxq2p+tneAXCUfZWRivYOGaGIYsJJmic9SGvhL92jpGjSNT?=
 =?us-ascii?Q?zE8+Mu7G1aBGu1UUlGdDkF2tOW1XC6MOsJVfidcUfQgdTE/lFUel7vDRvpM8?=
 =?us-ascii?Q?LrzWQ4k4yTmfACf/VEH1ihiPaKKcY1G1zEwWf5C5v8bx5QL8g3ETS4Y2ieTB?=
 =?us-ascii?Q?1mCkOtZcPsDQjmg+AjnmKBJFY+dY5LBUbsNMXeAHzah6uhdy1ycqx3a11XrJ?=
 =?us-ascii?Q?+lc1L1syYhIDsrFxin9A3QlvB7qJ0+opvOxVQWIx3Sv1dm4L91jMcTPaUqW6?=
 =?us-ascii?Q?6OTwEvs0W/JAkPVZ0dt4ODh/T4AlazRqa+6mA8FOLQR6JO96xpsvorgp5Eme?=
 =?us-ascii?Q?Gw3gRjL9kIqs5KsdccwntupwnMS5tfj5jZ4nS76QCbukYwgdbzLmqtIUJxc/?=
 =?us-ascii?Q?mZxLAuYsjHI+ig2rS3g+1liL+TyIciQvz/F83vJPfsCxOVwLKHlJNBzEzSNW?=
 =?us-ascii?Q?7AWPA+Snlfz/XPteMfh1IFVJ/q8/o6UfU8X+Lqmk6m6v1/mrA4tfrTxaPCIT?=
 =?us-ascii?Q?tMvVCjfqqnSE0dyXA8NqttxZg7dyirjfBTwm0Tm38JvY4i+dHpy065ucFfs8?=
 =?us-ascii?Q?u69bbeTdUE/YJwWolw9cgDgaJZFl7zWoXoOkrTQWipQzoAeT28qfRM7S8nf3?=
 =?us-ascii?Q?IfP9cQla7B0ziNt0lqjO2+y++MD2RkAe3Wm0+WxQ6fzHcjCf9KG3ktuWLQ/G?=
 =?us-ascii?Q?b9sS8Rpw2bnc7pb+6dXkd6YueyW6JALu3JB11/lCt1xKMotnng=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5144.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mZ5wnQukrBwgd4bQV5btz1Kw9EcP61UK6TXWKT5OnAi89sPw7gOpH3BSqwm1?=
 =?us-ascii?Q?PEMoGuYENTajR1BIDdrTtooaNFgPksKY3x8kb1rtZvemP64Kb1tjdwp/vTlw?=
 =?us-ascii?Q?M4brLp+0oC3SvYD/33Hg+BHMvlJ08KeSiiq53UM4ESxW9pULHX4tDmsIGsCi?=
 =?us-ascii?Q?+NAwG2f91VZ6SAThE8yok/tNpODJ8zPLAkDXIzN4nGg4BlT6qv/SIu9edi6j?=
 =?us-ascii?Q?g62dNinMHTmUH3v19T5z0t4hEcq068n+oYIajZ9A3ZlHuP/fnLoFpNEdUr+S?=
 =?us-ascii?Q?9iOfpxuQyxK77qCklVusRCkpCfaNekJcFmYdftaGUdPIUoUBeIhfazy/Qmok?=
 =?us-ascii?Q?5J1GUSIQkUoVN+gRYXQwpvGK7veihm6uYgbggjLdjSFTPocMugKUnoHAA7v5?=
 =?us-ascii?Q?PnxGdV1FMfP7dWbujZj2xBeU7uxSb9SiTp36TrQGT8w2qV6/SQsgIwtUh4TW?=
 =?us-ascii?Q?vuBEzqVw2GgDT8jhmlBXUeUSlBlrHxMuyiszH6FQQ1H/iRwPfVVpx3d4bgqj?=
 =?us-ascii?Q?31CdN0dK4KNmc/s3N8bdEF9t6vSRxIdUTqm70peub/vAJEkzzHEGLaQ9dOaa?=
 =?us-ascii?Q?rbPg/IPi774tu9CSo7ZpDTAtXMtkR/8kHhGClGoazswgCJFF0iXSj/tHqyPv?=
 =?us-ascii?Q?Ur7sz7/eRd+SMoUTnRPBNsI/7h0e5UAEWtZbZ0b8s47xvCu7wq8Mj/K5JFUe?=
 =?us-ascii?Q?7M7oMUgfr6w4DFks/uGSzYI/6jH0atw7/Cr7wBYt/onAuuOstvW6G6no2Dvp?=
 =?us-ascii?Q?WW8exBZVPVYFQjS+xw5D1jUUONh02af5DW3n2Tn/e2Jgtg1pDCijGCWIWVFb?=
 =?us-ascii?Q?ZQ6VOHrBkQ0C58IX8fVef5/rrdp8RQwoqOEbjFGw1eKz2C9SFUeidx9y7OfA?=
 =?us-ascii?Q?K7BS2GSx9J7/2z6bkqQzGKq5k+SYNmNnfSvF1WeX0UA22heaRNWkBPTeuT5T?=
 =?us-ascii?Q?cXDqBU+VSDxqfWxaqzeE68gXs+DVD7Dr9le6ryoBEhHFC1l4GQHxu130ozUW?=
 =?us-ascii?Q?XSsZQ2FrElqdi8lcg9WieasWneccavyDvMhjz2Xp3v9cMtZ59kFi9PdLunqh?=
 =?us-ascii?Q?pB/qHNftLyaD29ENKcCtlffQF79dMFMhQZ1gTS7X5XUQ8fU0t+a5/Z7NOm2c?=
 =?us-ascii?Q?BzkYvfnUwbfA2ID/HqFlbTp6I0A7kwPn/5isgIpdvofzGopfn616E9FvQ+Pr?=
 =?us-ascii?Q?KfXapwemgxKHBaL6kXMhoVrQCvN/nQx06Gr6jkkZy+JR+mcIPBo3FBvsX60J?=
 =?us-ascii?Q?CfOEh1wuAZSxYno65+F/MvweF5sll//PIZ3IOmyKtCCq10eaqQQmcC2PWUju?=
 =?us-ascii?Q?cMbE8xQmSALcwH3sXgZiMGowjm69f5DVkqRt7zYzyyayauLEa9yN8Az/A4xj?=
 =?us-ascii?Q?FAfK5NXdoLBIEAuZ88W3JQDclV1l7TDFHg6mw2n69v7RgB2PQswSsXMxGkCi?=
 =?us-ascii?Q?bb3X4fG8H2eBxbtj/idAWYhtCHBY0syQGcH9BGdB2mqMx5AbmcY2z3H9xudK?=
 =?us-ascii?Q?oJaI+2JgVV1mIO0nUCHYvAOUMZKV58qF6mdphKqH70rErFVLR8eISidgqFfZ?=
 =?us-ascii?Q?hCXPbgMGkXXoDr/vp8M=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL1PR12MB5144B621C8C1F585498425F3F7D32BL1PR12MB5144namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57b1297f-d471-4c66-e422-08dc99f7f0aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2024 18:02:15.2910 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 83xJjLHEI0E0VD/x/g6RdTEQLShBVjGWRXFxLSICZbJSnFcDDsPXy9C+QjAbe7i6gT08JLWNm1wsw6i4dVJByQ==
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

--_000_BL1PR12MB5144B621C8C1F585498425F3F7D32BL1PR12MB5144namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[Public]

Series is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
________________________________
From: Huang, Tim <Tim.Huang@amd.com>
Sent: Sunday, June 30, 2024 10:48 AM
To: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Zhang, Yifan <Yifan1.Zh=
ang@amd.com>; Huang, Tim <Tim.Huang@amd.com>; Zhang, Yifan <Yifan1.Zhang@am=
d.com>
Subject: [PATCH 2/2] drm/amdgpu: Add NBIO IP v7.11.3 support

Enable setting soc21 common clockgating for NBIO 7.11.3.

Signed-off-by: Tim Huang <Tim.Huang@amd.com>
Reviewed-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc21.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgp=
u/soc21.c
index b04c763015d3..b43c50f1c7ad 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -953,6 +953,7 @@ static int soc21_common_set_clockgating_state(void *han=
dle,
         case IP_VERSION(7, 7, 1):
         case IP_VERSION(7, 11, 0):
         case IP_VERSION(7, 11, 1):
+       case IP_VERSION(7, 11, 3):
                 adev->nbio.funcs->update_medium_grain_clock_gating(adev,
                                 state =3D=3D AMD_CG_STATE_GATE);
                 adev->nbio.funcs->update_medium_grain_light_sleep(adev,
--
2.43.0


--_000_BL1PR12MB5144B621C8C1F585498425F3F7D32BL1PR12MB5144namp_
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
<b>Sent:</b> Sunday, June 30, 2024 10:48 AM<br>
<b>To:</b> amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedesktop.org&=
gt;<br>
<b>Cc:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;; Zhang, Yif=
an &lt;Yifan1.Zhang@amd.com&gt;; Huang, Tim &lt;Tim.Huang@amd.com&gt;; Zhan=
g, Yifan &lt;Yifan1.Zhang@amd.com&gt;<br>
<b>Subject:</b> [PATCH 2/2] drm/amdgpu: Add NBIO IP v7.11.3 support</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Enable setting soc21 common clockgating for NBIO 7=
.11.3.<br>
<br>
Signed-off-by: Tim Huang &lt;Tim.Huang@amd.com&gt;<br>
Reviewed-by: Yifan Zhang &lt;yifan1.zhang@amd.com&gt;<br>
---<br>
&nbsp;drivers/gpu/drm/amd/amdgpu/soc21.c | 1 +<br>
&nbsp;1 file changed, 1 insertion(+)<br>
<br>
diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgp=
u/soc21.c<br>
index b04c763015d3..b43c50f1c7ad 100644<br>
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c<br>
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c<br>
@@ -953,6 +953,7 @@ static int soc21_common_set_clockgating_state(void *han=
dle,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(7, 7, 1):<=
br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(7, 11, 0):=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(7, 11, 1):=
<br>
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case IP_VERSION(7, 11, 3):<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;nbio.funcs-&gt;update_medium_grain_clock_gat=
ing(adev,<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; state =3D=3D AMD_CG_STATE_GATE);=
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;nbio.funcs-&gt;update_medium_grain_light_sle=
ep(adev,<br>
-- <br>
2.43.0<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_BL1PR12MB5144B621C8C1F585498425F3F7D32BL1PR12MB5144namp_--
