Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0087BD32D9B
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Dec 2025 15:06:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8AB7E10EB2C;
	Fri,  5 Dec 2025 15:06:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=appvaab.onmicrosoft.com header.i=@appvaab.onmicrosoft.com header.b="WbzRbgna";
	dkim-atps=neutral
Received: from MM0P280CU009.outbound.protection.outlook.com
 (mail-swedensouthazon11021143.outbound.protection.outlook.com
 [52.101.76.143])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 689FB10EB34
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Dec 2025 14:27:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vWlSAV2/J+9+9Tw1uUSjoE38+rsYywKOkxyOLShRwInwQ5dCBFk6j5iIdCU7cXP0icsHX1dOPGDhWy1Pl3FkpooBAla0toI+6D9EQTLyDNQpZCGS+PzCbf9mjjbJ64vpVY00R9LJNQrdJBES6RrMHNjBrMN6823YA399Grz4bRmu2lEAUno660DQwyfQTxipG1YqkiRo0qlnq/knvez/j1Et+09/r8+NXnwCBfp+k/NcGv4BHLC/q3MwQi9JjVpLFt0r3jDjmfY4YEHJufZX/RvYilCVuEBuafcgQQWiz9sxNVIy55eKyWjwWucV/u5L2LrdIkZZjUF8LlvlojuV4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sjSz836O9DYRvZVkxAVbpubiqOYzKIsX128yP+N/d3k=;
 b=AOXFsTvM8rwGrfi1C49lM8iuxxTEEj2E8Gp0KSGureLU9454/2uHynBFn9JjCHmOgHvEGpcljIS3zf2mE69NJHusiyezv3regoVji78Yf3Ej5Xv+MRiKSQXL8xEUna+u9BOTAqHQsCYri3onCb3PLW7z5rvwUwSOhLmvwv/GYMDPznkUIiuBwLeXy9XmD3BkThFWY6Khgp8c7EIIr2rZ7a+3yHPVweUrbperqlpfG2ETmJgvGYL0IC3d9BveSlpAOm9iGijF92zupihgI4txa9vH5rjHI+C21pc16lFGLlFDH8Oi/O3L4M+2MoJfdATYbbhOvcCpr3H+Gq7CGIlH0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=appva.com; dmarc=pass action=none header.from=appva.com;
 dkim=pass header.d=appva.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=appvaab.onmicrosoft.com; s=selector2-appvaab-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sjSz836O9DYRvZVkxAVbpubiqOYzKIsX128yP+N/d3k=;
 b=WbzRbgna2zKFwV/6EoE/ije1Thsu9c2bQtvhqpKaXlJdJgow1dXGk559y315bNRExywPp5VKbIST6NQDkChQAeSMty/jz+ovUTtng/toglHSF5lLQKqcotR32/tuAB9I5VyWLjF8Secd0m0m7LNS7OxxFZpuv0XWZqY7BkjgilU=
Received: from GVZP280MB0725.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:f8::9) by
 GVYP280MB0986.SWEP280.PROD.OUTLOOK.COM (2603:10a6:150:ed::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.9; Fri, 5 Dec 2025 14:27:00 +0000
Received: from GVZP280MB0725.SWEP280.PROD.OUTLOOK.COM
 ([fe80::5593:d368:dcbc:3ad5]) by GVZP280MB0725.SWEP280.PROD.OUTLOOK.COM
 ([fe80::5593:d368:dcbc:3ad5%4]) with mapi id 15.20.9388.009; Fri, 5 Dec 2025
 14:27:00 +0000
From: =?iso-8859-1?Q?Natalie_Klestrup_R=F6ijezon?= <natalie.roijezon@appva.com>
To: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: linux-stable 6.17.10 (and 6.18.0) regression - broken DisplayPort
 MST/daisy chaining
Thread-Topic: linux-stable 6.17.10 (and 6.18.0) regression - broken
 DisplayPort MST/daisy chaining
Thread-Index: AQHcZfDAwmeUGRHAJUOCGB1FadhPJQ==
Date: Fri, 5 Dec 2025 14:26:59 +0000
Message-ID: <GVZP280MB0725CCBA01C7021B957C708097A7A@GVZP280MB0725.SWEP280.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=appva.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: GVZP280MB0725:EE_|GVYP280MB0986:EE_
x-ms-office365-filtering-correlation-id: b7d064cd-e9e3-42e4-b28a-08de340a5a0c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700021;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?W158KEQvj6e4gT5dEPX+EfvZ4pIekSBSPhvLPGwH8I5L390fzrfJYn6yz0?=
 =?iso-8859-1?Q?yR1+yP8CByTo7uRDpBP3HxosmKSGJRPv3S2x0CvjW0JXeMstUvqkGU/Z+e?=
 =?iso-8859-1?Q?AFt9KbG29eMqvutn+RsdIVcA6xBe+qqVLITHqvQzyDVAkclwvrlMzUE4By?=
 =?iso-8859-1?Q?xwwHaNFMTbI4zYZylkwpxnVTbCDeizPBVMTBujBEtYH2GQk8N/0GMKFcCm?=
 =?iso-8859-1?Q?S8qKoHms7YZbQ0cfpuBLgrD7NaxBOhKkxKz8a+gIMFzr/OMTQzwhlDPO0h?=
 =?iso-8859-1?Q?8/eCLy+flUuxhUWEsQfd9qLGT6fu9yp3XoR4Bd5wRISMRl9R++KQXGdm3s?=
 =?iso-8859-1?Q?W7Rn/GHlSB8cFUxWA6SxHzcR5ZuzTwNLVaaspIc/hK4tuUukE/XGGvlyKu?=
 =?iso-8859-1?Q?xm4g+MJgSDbrYqDsMy7g9TIUHK0rCXPgcxOPb9P1AWMLyh2I95jajZN1BG?=
 =?iso-8859-1?Q?qPnIB5EEWOD0ZoQMP9ChwCQCGbCR0M76L3ALbDad1F6PQfU+gHqwZLVvm3?=
 =?iso-8859-1?Q?Zomq3iMSKouUcV7E7HgoEcCxFhjN95EWvfrBN4Sjn/EBibg3UjAuZ/vyyU?=
 =?iso-8859-1?Q?bQ+3ObHcmnB517OM0vbj7BDfxvSqxgT2F1kkDyQ+9bCZk5yOfmzbOnf/QK?=
 =?iso-8859-1?Q?5ml0wmZoap0llq8CQE43cUTccjaTtSnj2TxUigAQJzyRS2QeKfyqkXApX6?=
 =?iso-8859-1?Q?ZbqSzwSvDI8qiYIqmXNAqlTZCFutQcaPQ7a0snez9c1m+DLcvJZHpireZd?=
 =?iso-8859-1?Q?qFDfQlH7fCDK8SEK2K67d/Ie01icVzT1EB/WDXJkEOs5uZ2llYAqJ+mJTf?=
 =?iso-8859-1?Q?q+OmMdGZ2Nm/y75h3vhc2kQgSaKvKIpyYNIDG21mMII0uPfCAWbolT46ux?=
 =?iso-8859-1?Q?kaNgbMGlbX1xFVfrJ2goyS+WupAgk2WADbwsKCf2Hne/vnfrmwV7/XQ+In?=
 =?iso-8859-1?Q?eOE1xmzSP/DAxnTeQKudxD8Vtg4TgYAXr4sTHHoaSQfU0KRgcDrwabQrpc?=
 =?iso-8859-1?Q?P6mXUjPBxKhYKbrMuRpD3HnU9LEXKMQpwoGCLtXCjn4TSlPrOrJkKm1oJK?=
 =?iso-8859-1?Q?RsGscgI8qFVdarlNOBHvr8zMu1h3rw9qNXzpI7zCs+tgh3rOGZZyT0sXeY?=
 =?iso-8859-1?Q?szCmIfncLAu0ytMe5nZE9fuSnrmaGtRCbClvILOUAiYNRXt9ESwcBZoIYN?=
 =?iso-8859-1?Q?7ey9sYI6118OEUAwW1PlpcJjQtFtu1wf5MK4VacILcbEZ3EqlTXG71Nr2/?=
 =?iso-8859-1?Q?Ka2Nj+JHbHsJclDloDA1ObrLhOaueDwBBVBYGTpMdan5MafA4zTX/+wWQu?=
 =?iso-8859-1?Q?qSe8+1KORA9EYffUZ/SdwM8NrPPaGOWyJYmcMTNHhULHSVJWxHUa1S5sqL?=
 =?iso-8859-1?Q?uTug5xU3c+mR3R27h1jeG8jRXLjJcK7PYFfg0PhBK9kV9x7iQA0bSFG+n0?=
 =?iso-8859-1?Q?FTA6Wzz28t5xz+I9Q+9u9WDHPYHlM9lEQdM4hSVo8YnaQOete0IP3X/6mi?=
 =?iso-8859-1?Q?RTdmyeTEG0pd+5fuVNTvxc1JQ59Y0XIEi2vmN7nPka93bMRMVPgI1hoBE/?=
 =?iso-8859-1?Q?VR/2jqTcNwJapmlVw6O73RP/hNi6?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVZP280MB0725.SWEP280.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?2m6WYj22rZcgDpWZXzsOXCVu2Q9Tj7olUcAYTxZKxkc/uT4+6h8hK09NF4?=
 =?iso-8859-1?Q?/vCNW3MqoMEAy/tjoUjuCYrDeD81prSCKBbkqfZBnhy5hm2xHORkcvnVDv?=
 =?iso-8859-1?Q?DulaxK+2MnFK64YVSxvKuGBGio/Gx7VrnpByyF16QV053iOKbAF2CWDU5W?=
 =?iso-8859-1?Q?10z73UwE0mPzitMkxLok1jJYAwii/QPccuDncny6E3VsD4VNE8c5rkLOWw?=
 =?iso-8859-1?Q?Atu5x/PaAn66mDIwPyoMZo44pOC+m7cBQBLPUVYQCvSCEObzH4o8Yku+53?=
 =?iso-8859-1?Q?butRAaVQ8rv8SGqjfcGVheBinnf3uADSpEQeiiulSN62Rri/r1atYz1SjC?=
 =?iso-8859-1?Q?12wOqcBu9fDIFLfZZoXyB4/tsgTyxn0lmrC5nauZ7wamRRAxpMPGFwTmId?=
 =?iso-8859-1?Q?7ilF9hgfIKOO1aa6KF5XKcL/inFTmDev2+ZPdMtL2CjABSIqO/LaocT5N5?=
 =?iso-8859-1?Q?gJW3bTaB8Tnp5iwgGRzsnixWOW87Gcxot9rX+c8pf5vxsdQ30QTzbGA2jH?=
 =?iso-8859-1?Q?+WEA7AfzWjMpulI6+/sMuWDzsZ5EbwQRrkAxS1dmXwDq0tFRXlm7/dWugg?=
 =?iso-8859-1?Q?LptCuMiRpGtqzbqjVBAVhGVqLgNHR8KDNDZTFtMynL3kaDaxGEnNW9Kn7k?=
 =?iso-8859-1?Q?vneOaLVBIdQFDxkhJgedKQCT0WSk9OP5Ne8yo8FwAxpC1UN2om/a26Heqw?=
 =?iso-8859-1?Q?H63/4MHRfE5gIc2l5GJptMRndhOnZrl5aP8bu8VoC3f3RhKNAw57GGG8WR?=
 =?iso-8859-1?Q?lryMRFizGbYrzUPySmP0f5v4QyIuhmY0bHuxTuUrUxY818viM8NjLgoyvj?=
 =?iso-8859-1?Q?7gXJVYA0Iqr52iZKT/ajLGHM9xK++6ym6NB+oOZTakEBRm8lJyo0ozBigw?=
 =?iso-8859-1?Q?QzIIsnv2vPq0DzAhvPH2wHDzMqPScG5jWNGwLWrxmCkNKvQ+mxAtglj9CH?=
 =?iso-8859-1?Q?zhbVJPRbYgffWnPEEjEd3BLf6fHnhYna39rHYC2o4QyRSQKtBw7UxxVWVm?=
 =?iso-8859-1?Q?zEWGA5ki31KYsx9N0Da5adhJJEiuHLMemsNHp9L0XJl6WP75Z2JaRVPMsX?=
 =?iso-8859-1?Q?eObMtiRwf3TyAtEy+7Ps1pO0L/+IfTtIqRjiAft3ZMuIIJnnSIcDgE8VoR?=
 =?iso-8859-1?Q?71tfMorAHIcH1jhwrM0M/ct+KDRlMTlunsMP6I62FCCWH0iOztYTJt31il?=
 =?iso-8859-1?Q?IRgqDWm13wJn/iAR49CMFp4cCXIMKeeUwHnOGb9BlbFRbKvotRtFBhxeiq?=
 =?iso-8859-1?Q?Dx1GyDvIYdsq7pCn6UOEolrHiqIjMmP6ablBBS6vua2eC4gfnYq8b3OSU/?=
 =?iso-8859-1?Q?lTHZI+m0dh93gdJsKfjdI+b1tPmcdoh+vhTIq2/y48wDOPNQKpUYZx0ZC7?=
 =?iso-8859-1?Q?Te0qhwHnxOt6njCcq674/Fqrbz/Ior22STnWWRtfLdXZFb2cFLWGuDfAJh?=
 =?iso-8859-1?Q?9TRve6cOxW0vVxZn6y8fU/Ej40C0wJc3dHEgS4IJUX2LcnJSyvBZBvrBf6?=
 =?iso-8859-1?Q?7nC4kxYKMAR4j5Oxdtdd4Eb9K4nIr7HqmxvaXPHH0u+aBbGB5k/krE8Fv8?=
 =?iso-8859-1?Q?FR7LK3kCpbMQfVsf09X98wmNn/DJEmu1JXAu4ch3CEKuBjWT1NpS+ZJJyz?=
 =?iso-8859-1?Q?+QzulTEuRuLFVObbUxrCExPaCiHrSr1WA2?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: appva.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: GVZP280MB0725.SWEP280.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: b7d064cd-e9e3-42e4-b28a-08de340a5a0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2025 14:26:59.7741 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 88fbf70e-8a24-4877-a040-2eef1db91e41
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yEmZ8Q+4eF2oJni81nXU/jFJf2uvs4DDEv8r4bpG3H3PHM3j8MhevoHxB8cadaFSWa+Se72y4tqHMaVXeZCgmW3pYBszPeMt1gUa4ZrRs6U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVYP280MB0986
X-Mailman-Approved-At: Fri, 05 Dec 2025 15:06:09 +0000
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

Hey,=0A=
=0A=
After upgrading to Linux 6.18.0 I noticed that my daisy-chained display=0A=
setup (Lenovo ThinkPad P16s Gen 4 AMD feeding 3x Dell U2424HE monitors=0A=
over USB-C for the first, and then daisy-chained MST between them for=0A=
the rest, running at 1080p@120Hz) would no longer work:=0A=
displays 2 and 3 in the chain would just show "no DP signal" errors=0A=
instead.=0A=
=0A=
The same problem also happens on 6.17.10, but 6.17.9 is fine.=0A=
=0A=
I bisected it down to=0A=
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/dri=
vers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c?h=3Dv6.17.10&id=3D=
18030e84cbda014787369b6d4cde8404fa2d08fc=0A=
and have confirmed that it 6.17.10 with=0A=
18030e84cbda014787369b6d4cde8404fa2d08fc reverted runs fine again,=0A=
and is able to feed all three monitors.=0A=
=0A=
Now, obviously the patch exists for a /reason/, but at the moment it=0A=
appears to just be trading one miscalculation for another.. would it make=
=0A=
sense to revert it for now?=0A=
=0A=
Happy to (try to) assist in troubleshooting, but I'm also woefully=0A=
underinformed about what the numbers are supposed to be instead.=0A=
=0A=
Thanks,=0A=
Natalie Klestrup R=F6ijezon=0A=
