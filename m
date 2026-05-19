Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76942CD4F54
	for <amd-gfx@archiver.kernel.org>; Tue, 19 May 2026 06:51:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 071A710E31D;
	Tue, 19 May 2026 06:51:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4O4FRvil";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010031.outbound.protection.outlook.com [52.101.61.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C3DD10E31D
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2026 06:51:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zrj7lcp8tBqPglHU12XYNqSwAAz+uU3PhjP9ENMbYJ+jiaFK2l7WWHVkmxFnynN0KRm9j7eGG14jkTrntPr6WHBsgHXdwKQRNMDP8aMR/b+4gevL4WzwysCZJfiD9ZaYR+yNEpxbOPz2VkDLWT8DRbb6nNyO3dQ+Tyg2ShsvsxUUGaM6bffa4me9iajFF1Ermpc4sKQVRxm3ES3vUarUVr0Pd7hXqpHejN9U4Vooc4KCuVfW3un4n0r5bPpwp4Wr0B4flzZtx9cVf5IyikXh6+gP18XzV9uaNbQvtzWA+kSvlfLxFdk7cpcOHDwyvycQGPnFoXhAJ/8DjZVh9vDl3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CNkLr0oNS1csKzFCyerFS33j0MqHop+OJiJ9dklmgos=;
 b=JsPhN/E+ehSby7+YnrCI7fJYojzbYLN/7hZaRmNODJhCf0EH0qCXo1Kvxk50TCqw6vC7B2SdAT0KBrOQJj0gDAyHccWLANL/HUtSSVTRW8iLzKnsmUK47DvzoNlGIHXIZBZOpSX3Kv313zxg+IDHkF+uLpTR3I/hQkdKEGkoSWFChB2h8U2dDti56Yg85GJIrogQNKDt7Y31VBuUnaa8e2gAH4k2tmx+D3cj4jS0dp3m3iDIqsJL3fcmFiLIa5vVxrIAATVq59GxKTHYzaR3W0hZkVDk7PtbAADWGJAew1j3LAMIxKfHIZix4AbIkOJihXQtt40x9HQbHVYtAlzZLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CNkLr0oNS1csKzFCyerFS33j0MqHop+OJiJ9dklmgos=;
 b=4O4FRvilOH2uVXJFzstm/pqsBqMWbvnVXV8aoGGqRvuZThn31cYJz9nAgJchem26lgl2lbFRGgY1tKO24yH+TmYS3QAKOuyJxQ2jV5glqdCMB/5/Zmv7bsUROo5ebFfQrmoDSg3pX9RlAKZ06/trRGb97vJvxV9fUmn1vWKlpzk=
Received: from BYAPR12MB2597.namprd12.prod.outlook.com (2603:10b6:a03:6e::20)
 by SN7PR12MB8169.namprd12.prod.outlook.com (2603:10b6:806:32f::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Tue, 19 May
 2026 06:51:47 +0000
Received: from BYAPR12MB2597.namprd12.prod.outlook.com
 ([fe80::bd10:5352:bf15:e02]) by BYAPR12MB2597.namprd12.prod.outlook.com
 ([fe80::bd10:5352:bf15:e02%5]) with mapi id 15.21.0025.012; Tue, 19 May 2026
 06:51:46 +0000
From: "Xie, Patrick" <Gangliang.Xie@amd.com>
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Chai, Thomas" <YiPeng.Chai@amd.com>
Subject: RE: [PATCH 3/3] drm/amd/ras: return error when converting records to
 nps pages fails
Thread-Topic: [PATCH 3/3] drm/amd/ras: return error when converting records to
 nps pages fails
Thread-Index: AQHc5pFsq4ZFDkEn10yGp03t4OWb17YTrFSAgAE9d5A=
Date: Tue, 19 May 2026 06:51:46 +0000
Message-ID: <BYAPR12MB259733094FA6E477E818C3BAE5002@BYAPR12MB2597.namprd12.prod.outlook.com>
References: <20260518064053.2778626-1-ganglxie@amd.com>
 <20260518064053.2778626-3-ganglxie@amd.com>
 <PH7PR12MB87968C198CFB0E3C5B94EE36B0032@PH7PR12MB8796.namprd12.prod.outlook.com>
In-Reply-To: <PH7PR12MB87968C198CFB0E3C5B94EE36B0032@PH7PR12MB8796.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-05-18T11:50:09.0000000Z;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD General
 v26; MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR12MB2597:EE_|SN7PR12MB8169:EE_
x-ms-office365-filtering-correlation-id: b9c6262a-2c3b-473e-9508-08deb5731834
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|38070700021|4143699003|11063799003|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info: WZnz2rBLMpncPELyEp5PjgRFzcq3huIXfSAdGdE+VPSfQCVIjj0nm6eae8JjyXPl7+b3X2hpUPTPZU+TpmqSeCi5vel1eeohArAK98/EVoaDaP/3gUkuPW8a/ZULJ6DJI/I0Afh+71fsCDcg29MGwO+QkACO46q+waFjBXrtQKQ1Htijj8ZFrvGSAkcQWliTYIrJ803FObjoNI6PQP5fZJPvbjAzsKiVXpHAXS6eAdfYKqkvzQDzOqDaaNztGGPUzZ13AVAZdBZHegppfKr7YKozdXtVw5CWSTmtcY40+Rpdgj/OJOnzrP05jINWV5lgKHyiXnLHErK6u3RB8SjVB79TJx1TXD/UIXcY8E3jBb3SucFXoEZ/NaouW0rYlhQkkm6Ztyz1nYRNU10aAKKqvss6vscSDKypjCeBh24632HEP7fZMMPQEkH3066x8lzUCvjF1DmLpfxjhYYKMygHR8KL2kLwR6nljinpVFK5jZUcckyqgW9ysbXP/Cw/GMb0i+F7twRWLQLZovk5AKn2JGAp4kyYYauWGALbGIrf3elwGZF1ECJ+2SEpl0xlSxsERn2mB2IDnSJwlBTbsVu5Ae9VTEoecS+3HQ+FoglczcM/LWwfc12vuG9ivwNFIhThfWa5VBV95WzQyb44ZnYnuOTxNY3lqLY/JqSaG8byS3+Ad0IWwjJ1yLqRjT+VF4PLoK+XUTJTo2RvVgtAP2xJd69EkGsbaOyEaJnudtq6C3uUgbIgxItglNZ5frUF/Z2p
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB2597.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700021)(4143699003)(11063799003)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1Kkc6Zb9hZtjlFsjH1/sc5wZUi1kMMNi0SvH6sYNae4cigbPG92YTGIW2DED?=
 =?us-ascii?Q?ot6RXejd4XQzbdgdHVJlHF3DxFiqpVJOB0P7MHgQuF56uMQlA97dUe/ePcNa?=
 =?us-ascii?Q?KZtQDM4XXs3YFZ2oJWYIVyMcqTImw4kz1kms/yTLz9LcVl02FufUzmxmkyH4?=
 =?us-ascii?Q?guECvrsVuLLuChsq8p2Q685rld61Q2b1IRJ2wylf7GO0OZJGZGLFdAtOqtO5?=
 =?us-ascii?Q?N7LlYSiQuhKG3QSQRF14OVojco8m24Kh2BYPjeHUxK77kWvuIMviq7h9t1hx?=
 =?us-ascii?Q?PQiDIzT+hWGwPFoG3KFlbALj2UpmwTDrOyCrLLBIIXBRtQytyjudNT4ixKJq?=
 =?us-ascii?Q?qc9KrIiPTw7q4MTqkaHx9LnlgzXOU3tILdyFTaxQCFQ2OaqYbVSKStKyGVzR?=
 =?us-ascii?Q?zPnvnrtljVeM1/xyCTVyHSCOYpwnUboa0uPnlwPZmd5slbZA8j2befYesYrS?=
 =?us-ascii?Q?bJRJ6CBlgQfve4pHano65xfZ23LbyD7+g52Aw0XRFsokTopCKs7W8be3lgF3?=
 =?us-ascii?Q?S27ujsSF/LTvgJAYADB0YwqyJKbzs4k4x69k2/jHn6UmnRwMMqu2qCwHseGz?=
 =?us-ascii?Q?fnOC3EPAH0/JtJpGuXS19A04aluyMtJfS+vgQu0agdyFBDZkxMUcwehy9jlu?=
 =?us-ascii?Q?F3Vj5JDjc7LcWTFHQJWvEDVEmCeZZvrFhJhEMv6l92JLjy62p1Ipzb+1r5cL?=
 =?us-ascii?Q?A6J36o8jZVGDuzplQ+7/bpfrPe+Q9G51DC1raQO05fEfchoFqoMYPKBG04gj?=
 =?us-ascii?Q?jR3907xIayvdfrTC1q2rshSS80JckpaE1nz9Ko/SdvRXMKQ34O6pnaKa2REI?=
 =?us-ascii?Q?oNCIf8k0iBc+E1e6jDNLSbJlkZvXMIieMUZ/Z10DYixjyv1dRQNgpKumyYQI?=
 =?us-ascii?Q?QP0UuTCDTuL8eNnck0JkUo8HfxoAo+EtUPySowEZLeI09WsekhG653df3JPL?=
 =?us-ascii?Q?yDiq81TUrHYuAQCrr8wqJxoK5AeeUXKDCsQ5JJd3rG0b5gaupRjPgmrusTp2?=
 =?us-ascii?Q?SwL3anWzipUgOklv1hQoUJP+Whqa/Ey/1rE2zO9+BKy+s37YljMV5DePNp99?=
 =?us-ascii?Q?BvH6OIpoPM9i4dYlAkEMFIbX6043viUbyfug9d5idtidQwWNRE5R1YcozltZ?=
 =?us-ascii?Q?CMBXW2WN7D4E/Mg3RzmTW04PbrUt29l1wzH1gCW51ZUdRYuzK5GxCel7jvHc?=
 =?us-ascii?Q?jGWIuBIFX1COKhaSMPGjL1CR5COkKN6wIWuxpZY501IhKIxMmr6dtn+okBXa?=
 =?us-ascii?Q?eFK40B8rWaJe0dLLGFwsNfumuyjlQYHle8Ow+Ev49pxJoiH6x+il8fwbYPHW?=
 =?us-ascii?Q?M+zBii4PttkibyPFMtMpKliz2ay3hxrf0G0rXFkVopB4F70Ts2bqZ/sXgZv7?=
 =?us-ascii?Q?hbiMnHKSCse57wwtC16pCEpLi8cGKsQ4D//VIheLy85H+HBSwBjzspm+oePU?=
 =?us-ascii?Q?ZfAJoRmzsGHCfpDqORSEH1p2orSl4Lg2Pgh/izxy6pDiUK/LtBgaJEeMaVwb?=
 =?us-ascii?Q?BzrHo6kWMj5USvIKh3euqis9XlUC7LpBEYBr0oQY1KdRVOCti3xTsLIfkCLL?=
 =?us-ascii?Q?QZQZD7GgXB6w4OxOoZRTiCt8/gN3p9GYPnMB5dp9DGF0f6Qbk/zuxKx7TXgo?=
 =?us-ascii?Q?b4kQHu11JlHBTpbSkWfRKEDZW9O3dRNbtcysuDBM/YB85gv+yWTOflT+xSh6?=
 =?us-ascii?Q?DQ5EL75whwc8CIFf3tQ9xF5Tj6YPOy7COh4AmNXvekOXP/0/?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2597.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9c6262a-2c3b-473e-9508-08deb5731834
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2026 06:51:46.5007 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 69dY3e9kNfGg+EBJOrJoChj+Q9F70ZWoN1C5SDr3rAgrsSldcqEja6uZGYEd4c0ku+TBvnG5brUwX17J4otfKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8169
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

AMD General

Hi, Tao:
        'Count=3D0' and 'Count < 0' both mean there are something wrong wit=
h bad page lookup, so they are both treated as error.

-----Original Message-----
From: Zhou1, Tao <Tao.Zhou1@amd.com>
Sent: Monday, May 18, 2026 7:52 PM
To: Xie, Patrick <Gangliang.Xie@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Chai, Thomas <YiPeng.Chai@amd.com>
Subject: RE: [PATCH 3/3] drm/amd/ras: return error when converting records =
to nps pages fails

AMD General

> -----Original Message-----
> From: Xie, Patrick <Gangliang.Xie@amd.com>
> Sent: Monday, May 18, 2026 2:41 PM
> To: amd-gfx@lists.freedesktop.org
> Cc: Zhou1, Tao <Tao.Zhou1@amd.com>; Chai, Thomas
> <YiPeng.Chai@amd.com>; Xie, Patrick <Gangliang.Xie@amd.com>
> Subject: [PATCH 3/3] drm/amd/ras: return error when converting records
> to nps pages fails
>
> return error when converting records to nps pages fails
>
> Signed-off-by: Gangliang Xie <ganglxie@amd.com>
> ---
>  drivers/gpu/drm/amd/ras/rascore/ras_umc.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/ras/rascore/ras_umc.c
> b/drivers/gpu/drm/amd/ras/rascore/ras_umc.c
> index d4072350f48f..78db402182f7 100644
> --- a/drivers/gpu/drm/amd/ras/rascore/ras_umc.c
> +++ b/drivers/gpu/drm/amd/ras/rascore/ras_umc.c
> @@ -391,9 +391,8 @@ static int ras_umc_update_eeprom_ram_data(struct
> ras_core_context *ras_core,
>                       data->space_left--;
>               }
>       } else {
> -             memcpy(&data->bps[data->count], bps, sizeof(*data->bps));
> -             data->count++;
> -             data->space_left--;
> +             RAS_DEV_ERR(ras_core->dev, "Failed to convert record to
> + nps
> pages!");
> +             return -EINVAL;

[Tao] are your sure the error is also fit for the condition of count =3D=3D=
 0?

>       }
>
>       return 0;
> --
> 2.34.1


