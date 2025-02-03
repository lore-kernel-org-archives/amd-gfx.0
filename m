Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37720C02192
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Feb 2025 14:21:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB8CA10E09D;
	Mon,  3 Feb 2025 14:21:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bzSHcOLn";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2085.outbound.protection.outlook.com [40.107.95.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EDE9D10E09D
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Feb 2025 14:21:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xiUh5F6u0+WHBKgoqfbKWyOAWqIBEe9Mn4FllIzTBVxGDIJg5+1o1p7HS/7dLud1qK5Si3HgNqF5I4zZkKqqJrzzciK2DCkBitfdeB/HEdftJmFsJ1LAxhcQbhzkxuZ4TGVDFjNlCnkyhFazFh9pdX3sTIsg+C9jgnsjfCMm+NNWLSoO5cUrLSxt5e5JCsCxUeZLUq2hkRrQhRWRbimgQ4meOmBEcSpgP0c3hvAkTdCrhjOkIe0XsQlnj1PTJ7DxBOigaDnANJ9VU1y+KMA7OEazmE0jRxKIyqYc1k7PW0f1HPdw5G8aEprjbE95wOTOeA+KIIAZWXfqz+cTMOXd1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7kuwQctgjpKwOF/wlEI6BlTPubLmm1Q1xVWnEriI7cA=;
 b=R6A8QAffGDcZXdQcKnNbUEc2knTI6ueX8gWJOUF9Qm2Aqx+hxukiiVfo18TmjkLyoFZ31j5YhpuZ5YKQs/z39qVGW96reGXFpzZdE4Pf4Euh7Ln5bmP+xIeZ862Bqh5Z/MC+79GdpxMm2s+zPoalue58ipXBUwG9K99TasjRHxRL1kMJ+miRp/kuE8FficxVOFKHAKUM5MRUYW3jiTJ7buW5Lt0WhTqDy0JELq5H9BYd+Nv3GyUm+F6kErAEtlgO0SKqOQotWQoWF3XKl2u+TNC0jxDFpcWxE4tXnDCqbKzmW/nvW6JqulKdyB8Q8IoeFc+SNp13qK+z8cmNArRs/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7kuwQctgjpKwOF/wlEI6BlTPubLmm1Q1xVWnEriI7cA=;
 b=bzSHcOLnfPsVVz9I/PFM2ooEw0C3wHvx/InQnrDEPunUkdUgatCKnRAnvaRxdsxw1hq9jsarXht7KYydqzitDsj2cnYNrSyR2rajESSV24+G6av0SsjgPsKxf5eGgwWYilkkJuFudjhxPiktCQ7rQEPd4+cS7xC90und+fTOn3o=
Received: from DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) by
 SA1PR12MB7150.namprd12.prod.outlook.com (2603:10b6:806:2b4::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.20; Mon, 3 Feb 2025 14:21:16 +0000
Received: from DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::ea87:74ba:36ec:8cf6]) by DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::ea87:74ba:36ec:8cf6%5]) with mapi id 15.20.8398.025; Mon, 3 Feb 2025
 14:21:16 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Hung, Alex" <Alex.Hung@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Wentland, Harry" <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)"
 <Sunpeng.Li@amd.com>, "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
 "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>, "Li, Roman"
 <Roman.Li@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>, "Chung, ChiaHsuan
 (Tom)" <ChiaHsuan.Chung@amd.com>, "Zuo, Jerry" <Jerry.Zuo@amd.com>, "Mohamed, 
 Zaeem" <Zaeem.Mohamed@amd.com>, "Chiu, Solomon" <Solomon.Chiu@amd.com>
Subject: RE: [PATCH 00/10] DC Patches Jan 28, 2025
Thread-Topic: [PATCH 00/10] DC Patches Jan 28, 2025
Thread-Index: AQHbcffMSEXHsvmkcUqLcaYvkRiztrM1p8zA
Date: Mon, 3 Feb 2025 14:21:16 +0000
Message-ID: <DS0PR12MB65349162C2E28BE912D6BD429CF52@DS0PR12MB6534.namprd12.prod.outlook.com>
References: <20250129024432.2107937-1-alex.hung@amd.com>
In-Reply-To: <20250129024432.2107937-1-alex.hung@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=68e4736d-ac06-4000-92b4-b161c4317348;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-02-03T14:14:43Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6534:EE_|SA1PR12MB7150:EE_
x-ms-office365-filtering-correlation-id: c8c592d5-aa83-4b27-cb88-08dd445e0564
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?3kXtkP1+AHJiPQZ3X7yTAz9lveMiT566f3v/DvrctPQsntU6Tqe25mQXOfE+?=
 =?us-ascii?Q?k3VtYDY5Gwqota/wcbIgiY+kVwMSnvhN1CSsL0l3q6kQ75B8XElCAq9XaJkK?=
 =?us-ascii?Q?0O7MBEE4Q9vQqaFWtx3gCiCrPc0XTC7UYXhcJ71mAyrLOstt/w5an5+ny/jI?=
 =?us-ascii?Q?Elaabs5FDKw1LQ9Ap9r62AvoDUIoOhhew6WUJvCe/wKauMUTX+Co3VAiTrjU?=
 =?us-ascii?Q?Ys5/xoHpDBpBEVrI1M1+5bImYBTdkqe53Y4v7aWOWGtHtPLWou25JyR8km+k?=
 =?us-ascii?Q?sPefLdYE32EChHsYhdQPWktu9LNCFeVADotvJC/myfvAeufJmFt3lGrZV7Pi?=
 =?us-ascii?Q?H2OUo2ArZRG+baXVtHJet2FTrE5tGUMg3m8KH17hY2xXjAL/bixLirFRyMck?=
 =?us-ascii?Q?AbjHUsCEkWPAVKjWxnm0woUreEwcETdmO8owgsJGobhj2cBF1UzGNZgtF1GY?=
 =?us-ascii?Q?hsX3qTefSV5v+P+UUQ/7U8QY7mJrHc9FX0rqgVueFl7R/mcgHEqB6lSePeBt?=
 =?us-ascii?Q?/OzH4JiqT6AoTTxtetWZL+kzMOSpax8HpF3KM3QCj22okjaWDmnYFQ+Vj7Jo?=
 =?us-ascii?Q?VsqjD/5ZtuaNroX6SjttOi4Ie2AFarMccYbIE6khDzQ9U+5I/0yKco9Ja/X9?=
 =?us-ascii?Q?RHsHrovN4YJr/Pg204itVxnEdvCxeA3/n1cYtUKNxpnkYQ/Dky/FWRH3nPmE?=
 =?us-ascii?Q?Pm4ww1j+gjKx44fjYPg+LAnrdAInN0uIWUdaKdpl93W6TgAMLANQDzVM1mFo?=
 =?us-ascii?Q?JG+9moumj9gsoky+ehMHBkRoJh6CI0qpxYaultNfuatOXWmiH12juM/uijkN?=
 =?us-ascii?Q?I+SZJWnlqM900mLi/dihyPGoqS38V8KEers222Y9oemKFqg5vvh30EBTv5t6?=
 =?us-ascii?Q?WNC2tO3z8piw1r80VKGoDc/6RxuIX/AHAy2yc9qmY01tmSvXkZ3Ha5Xzd609?=
 =?us-ascii?Q?VQwmrsoxwnxL3/ttBrRBY+Nvvc66vgBOHUBm+GsM1WjLS2LtZghMceXgmFuQ?=
 =?us-ascii?Q?YCyrBGzz5WESTcHwkU2S2qdhppMGQBflXtufca7a4zvuL2JBMbPOKBxe0h4Q?=
 =?us-ascii?Q?75RfIGoHd6x5PokBJBEehpEuD4thDRzLeFyK15j5rqvGUcY4crYYi6IN2OfE?=
 =?us-ascii?Q?gAb4+L7RpIkcOkiui0bLY/TCw0J5wPcwHXnosC4OLSgtlxLYD3nvBPsw0wJ0?=
 =?us-ascii?Q?NHU0JsNNMKwGl53Q4eWPrOWnbfOwMQAuI3YVi+YNx6AfrpE0sGAbCz0aikpc?=
 =?us-ascii?Q?JLJPEv2Qk3o2eD0G9ZcwivbMoFjVHpd7QH79tkMByl/47qpAoymt/DG/AP2T?=
 =?us-ascii?Q?Gsz+c5whdbhmauRCs4PqcxqagF2EK85cPG1UxR/gMNKsFLjkWKZlWbt8suvJ?=
 =?us-ascii?Q?KByF5UsjoN6cqAYtPl5zZrsIWEpYF627dL96pY+a2+6eXGMN+4cTilQCfje3?=
 =?us-ascii?Q?z7nYiybPapxUZLYziNb+8Xe6GqsNANi+?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6534.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FmFJI4dE/nNjbNJcBVc1UaHyU0lNrBfztkog3gfx3VjEo/zHsJUP97Chp/Vr?=
 =?us-ascii?Q?T/JtgB+6eGypJ4xasHBoUlf2a7rIthL3XPy4n8jJ8GmFpCj9mZWa6NV7imOF?=
 =?us-ascii?Q?Yu3+2ioRF6BL4qmHU0qdAPto2F3ns6QCBiJRKuRgFED+hcOZODErzGK1li12?=
 =?us-ascii?Q?nueZZO+WttAvroMQ7PEjL1M6PIw7bNCu0fTwlCoCpCJPznit+mMzXUKwqaKr?=
 =?us-ascii?Q?hZ0db5Zr1J0Oljes7B4RefNfhjJz9QHaqv8ZQjSCu0/EOSLR2tg+MIwXohWS?=
 =?us-ascii?Q?8gjaOTeAJnAyn0lem7ziFmI5Pf6SqUfeBELjRbEdME1l500dDOG+IVAA2pdz?=
 =?us-ascii?Q?jo813emGORJB2gax/4/AF+63cuEdH4gjNgaHOPYXtThXHefXiUprajGL1YsE?=
 =?us-ascii?Q?txdshFd1mQfCorPXTJUDZI2NpiSH3oHYf/uFpQfL3Q8F6yx8fJbGYki7Eo3C?=
 =?us-ascii?Q?Xau2xUCRmBeMQWr2f00jA49esStseWU02V/YnyH4LZejGHwlKqXbOwwt09jZ?=
 =?us-ascii?Q?sJZOwGc6kQinC8T6V1400O+usfoj3VOIWIbO53Dw8QZN4Qrp2LnP2T2bEn60?=
 =?us-ascii?Q?U4+UuxOA6gcH5bkkE/GKZ/KZCHr+UlnLWdbMgHjn1wFyk9KwGRhrHMykFcVJ?=
 =?us-ascii?Q?PN4yvSJAk8ksicc4jkCsxDOeTVwSaBUHjCBi0/zuIOYVml4xXHPvmdi2O4C8?=
 =?us-ascii?Q?wwWZjdzObTIaxnLLQ+JU3xI5ALYsrQ0IL04QGv1ff2WIEdchsjcec9xtBf3h?=
 =?us-ascii?Q?jTxDfjoXc6CpjQMSrk6DgIG7lLa3sIJyVBgTV7hfA9LbptnMpABBC0a4Gu1l?=
 =?us-ascii?Q?PqJkcgXWAB8YkM84evnkRzxz/3vPtETEcQ68HL73m7iAQJ9ND8MJw4E4e4I1?=
 =?us-ascii?Q?yV1P+UbAr7ZiQBD2Q8arkM+1WsU2j+vGQVA4sMAesIXQe8WS8dUP6s4DBB74?=
 =?us-ascii?Q?8644trPHE0Ww4RfUjBMQReKZkewi26VrO/PtAurN0bqp2XmK2kp5ZJAELgtc?=
 =?us-ascii?Q?CdLBRhvhcPLs3X90+ZMq1pzC/WFpR4AmDRdAafw1O5GXUS0McNhYAkI2qdc/?=
 =?us-ascii?Q?12NwbiOFxtYbj8leHwzG7urcpu3E5y1EI0LttuaPR6h26EeFlnUF8t0V3ADS?=
 =?us-ascii?Q?+xYp/tw2XtAJl4suf9aiMGMl4b68/V3q91+VRmFhqJzX6Uo1xLtcjNZwvzwb?=
 =?us-ascii?Q?wuM1Qo3cXD7GZBxMbmnvRuPJSds1RaYWzQf0bukKRnRDXf/3XOOiXYdaAAtw?=
 =?us-ascii?Q?N5ZHAV72YcM2KlZXnbszMzrlVYtLE3qN3M0SvLLbxho3GWw80hw8Ct/ZUdF7?=
 =?us-ascii?Q?euq+8nDkDuss9req0nsMd0p8K64/mc3E5KEnG0RtoAUGueQY2HyxTFTbI0+P?=
 =?us-ascii?Q?Nm9M4st8BAbzxMlyB8DK+m5JQEEC3cF5xL5qenRNF66x3sh7xkjBtdIxKWOp?=
 =?us-ascii?Q?+63Y7gcN3YFUdu9WDd9wAxWvleoe+bmHAqvlsbVOCfcd3oerEqZOAb/J1H5B?=
 =?us-ascii?Q?qHc7711erBLpj8bVjqLTPoQPCjW2KzLeXwW0aOgEx+SovxJzplFossHmXfD/?=
 =?us-ascii?Q?aUBZPuHSX0RPG6qYqsw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8c592d5-aa83-4b27-cb88-08dd445e0564
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2025 14:21:16.4455 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ayEktndEmiwvHLfxwn9L0XwiyYZb4tFzR2uVjL0VLyU1dZxMWjvu93kGO4snkba7vOjthk6NARyULBimsQpO9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7150
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

[Public]

Hi all,

This week this patchset was tested on 4 systems, two dGPU and two APU based=
, and tested across multiple display and connection types.

APU
        * Single Display eDP -> 1080p 60hz, 2560x1600 120hz, 1920x1200 165h=
z
        * Single Display DP (SST DSC) -> 4k144hz, 4k240hz
        * Multi display -> eDP + DP/HDMI/USB-C -> 1080p 60hz eDP + 4k 144hz=
, 4k 240hz (Includes USB-C to DP/HDMI adapters)
        * Thunderbolt -> LG Ultrafine 5k
        * MST DSC -> Cable Matters 101075 (DP to 3x DP) with 3x 4k60hz disp=
lays, HP Hook G2 with 2x 4k60hz displays
        * USB 4 -> HP Hook G4, Lenovo Thunderbolt Dock, both with 2x 4k60hz=
 DP and 1x 4k60hz HDMI displays
        * SST PCON -> Club3D CAC-1085 + 1x 4k 144hz, FRL3, at a max resolut=
ion supported by the dongle of 4k 120hz YUV420 12bpc.
        * MST PCON -> 1x 4k 144hz, FRL3, at a max resolution supported by t=
he adapter of 4k 120hz RGB 8bpc.

DGPU
        * Single Display DP (SST DSC) -> 4k144hz, 4k240hz
        * Multiple Display DP -> 4k240hz + 4k144hz
        * MST (Startech MST14DP123DP [DP to 3x DP] and 2x 4k 60hz displays)
        * MST DSC (with Cable Matters 101075 [DP to 3x DP] with 3x 4k60hz d=
isplays)

The testing is a mix of automated and manual tests. Manual testing includes=
 (but is not limited to)
        * Changing display configurations and settings
        * Video/Audio playback
        * Benchmark testing
        * Suspend/Resume testing
        * Feature testing (Freesync, HDCP, etc.)

Automated testing includes (but is not limited to)
        * Script testing (scripts to automate some of the manual checks)
        * IGT testing

The testing is mainly tested on the following displays, but occasionally th=
ere are tests with other displays
        * Samsung G8 Neo 4k240hz
        * Samsung QN55QN95B 4k 120hz
        * Acer XV322QKKV 4k144hz
        * HP U27 4k Wireless 4k60hz
        * LG 27UD58B 4k60hz
        * LG 32UN650WA 4k60hz
        * LG Ultrafine 5k 5k60hz
        * AU Optronics B140HAN01.1 1080p 60hz eDP
        * AU Optronics B160UAN01.J 1920x1200 165hz eDP
        * AU Optronics B160QAN02.L 2560x1600 120hz eDP

The patchset consists of the amd-staging-drm-next branch (Head commit - 5bb=
7cf8ad45fe218929c0fd78ae8adef1616a5fa -> drm/amdkfd: only flush the validat=
e MES contex) with new patches added on top of it.

Tested on Ubuntu 24.04.1, on Wayland and X11, using KDE Plasma and Gnome.

Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>



Thank you,

Dan Wheeler
Sr. Technologist | AMD
SW Display
---------------------------------------------------------------------------=
---------------------------------------
1 Commerce Valley Dr E, Thornhill, ON L3T 7X6
amd.com

-----Original Message-----
From: Hung, Alex <Alex.Hung@amd.com>
Sent: Tuesday, January 28, 2025 9:42 PM
To: amd-gfx@lists.freedesktop.org
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.L=
i@amd.com>; Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; Pillai, Aurabindo=
 <Aurabindo.Pillai@amd.com>; Li, Roman <Roman.Li@amd.com>; Lin, Wayne <Wayn=
e.Lin@amd.com>; Chung, ChiaHsuan (Tom) <ChiaHsuan.Chung@amd.com>; Zuo, Jerr=
y <Jerry.Zuo@amd.com>; Mohamed, Zaeem <Zaeem.Mohamed@amd.com>; Chiu, Solomo=
n <Solomon.Chiu@amd.com>; Wheeler, Daniel <Daniel.Wheeler@amd.com>; Hung, A=
lex <Alex.Hung@amd.com>
Subject: [PATCH 00/10] DC Patches Jan 28, 2025

This DC patchset brings improvements in multiple areas. In summary, we high=
light:

* Fixes on DCN3.2 and DCN4
* Code factoring for SPL module
* Various bug fixes

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Ahmed, Muhammad (1):
  drm/amd/display: Enable odm 4:1 when debug key is set

Alex Hung (1):
  drm/amd/display: Fix out-of-bound accesses

Aric Cyr (1):
  drm/amd/display: Request HW cursor on DCN3.2 with SubVP

Brandon Syu (1):
  Revert "drm/amd/display: Exit idle optimizations before attempt to
    access PHY"

Dillon Varone (1):
  drm/amd/display: Fixes for mcache programming in DML21

Dmytro (1):
  drm/amd/display: Allow reuse of of DCN4x code

Lo-an Chen (1):
  drm/amd/display: Fix seamless boot sequence

Martin Tsai (1):
  drm/amd/display: Support multiple options during psr entry.

Samson Tam (1):
  drm/amd/display: Move SPL to a new path

Taimur Hassan (1):
  drm/amd/display: 3.2.319

 drivers/gpu/drm/amd/display/dc/Makefile       |  2 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  2 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |  4 +-
 .../gpu/drm/amd/display/dc/dc_spl_translate.c |  1 -
 drivers/gpu/drm/amd/display/dc/dc_types.h     |  7 ++++
 .../amd/display/dc/dccg/dcn401/dcn401_dccg.c  | 24 +++++------  .../amd/di=
splay/dc/dccg/dcn401/dcn401_dccg.h  | 40 ++++++++++++++++++-  drivers/gpu/d=
rm/amd/display/dc/dce/dmub_psr.c |  4 ++
 .../dc/dio/dcn30/dcn30_dio_stream_encoder.c   |  2 +-
 .../dc/dio/dcn30/dcn30_dio_stream_encoder.h   |  6 ++-
 .../dc/dio/dcn401/dcn401_dio_stream_encoder.c | 12 +++---  .../dc/dio/dcn4=
01/dcn401_dio_stream_encoder.h | 18 +++++++++
 .../amd/display/dc/dml/dcn314/dcn314_fpu.c    |  3 ++
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  |  1 +  .../dc/dml2/dml21/dm=
l21_translation_helper.c  |  4 +-
 .../amd/display/dc/dml2/dml21/dml21_utils.c   |  1 -
 .../amd/display/dc/dml2/dml21/dml21_wrapper.c | 14 +++++++  .../display/dc=
/dml2/dml21/inc/dml_top_types.h |  1 +  .../dml2/dml21/src/dml2_core/dml2_c=
ore_dcn4.c | 30 +++++++++++++-
 .../src/dml2_core/dml2_core_dcn4_calcs.c      |  3 ++
 .../dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c  | 21 ++++++++++  .../dml2/dm=
l21/src/dml2_top/dml2_top_soc15.c  |  8 ----  .../display/dc/dml2/dml2_tran=
slation_helper.c |  6 +--
 .../drm/amd/display/dc/dml2/dml2_wrapper.c    |  5 ++-
 .../drm/amd/display/dc/dpp/dcn20/dcn20_dpp.h  |  1 -  .../drm/amd/display/=
dc/dpp/dcn32/dcn32_dpp.h  |  1 -
 .../amd/display/dc/dsc/dcn401/dcn401_dsc.c    | 19 +++------
 .../amd/display/dc/dsc/dcn401/dcn401_dsc.h    |  7 ++++
 .../dc/hpo/dcn32/dcn32_hpo_dp_link_encoder.c  |  2 +-  .../dc/hpo/dcn32/dc=
n32_hpo_dp_link_encoder.h  |  1 +
 .../display/dc/hubbub/dcn30/dcn30_hubbub.c    |  3 +-
 .../display/dc/hubbub/dcn31/dcn31_hubbub.c    |  3 +-
 .../display/dc/hubbub/dcn32/dcn32_hubbub.c    |  3 +-
 .../display/dc/hubbub/dcn35/dcn35_hubbub.c    | 17 ++++----
 .../display/dc/hubbub/dcn35/dcn35_hubbub.h    | 16 ++++++++
 .../amd/display/dc/hubp/dcn20/dcn20_hubp.h    |  5 +--
 .../amd/display/dc/hubp/dcn30/dcn30_hubp.c    |  2 +
 .../amd/display/dc/hubp/dcn32/dcn32_hubp.c    |  2 +
 .../amd/display/dc/hubp/dcn35/dcn35_hubp.c    |  2 +-
 .../amd/display/dc/hubp/dcn35/dcn35_hubp.h    |  1 +
 .../drm/amd/display/dc/hwss/dce/dce_hwseq.h   |  8 ++++
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c |  5 ---
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   |  3 +-
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.c   |  3 +-
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   |  3 +-
 .../gpu/drm/amd/display/dc/inc/core_types.h   |  2 +-
 .../gpu/drm/amd/display/dc/inc/hw/transform.h |  2 +-  drivers/gpu/drm/amd=
/display/dc/inc/resource.h |  1 -  .../gpu/drm/amd/display/dc/mmhubbub/Make=
file  |  2 +-
 drivers/gpu/drm/amd/display/dc/mpc/Makefile   |  2 +-
 .../amd/display/dc/mpc/dcn401/dcn401_mpc.c    |  4 +-
 .../amd/display/dc/mpc/dcn401/dcn401_mpc.h    |  5 ++-
 .../amd/display/dc/optc/dcn10/dcn10_optc.h    | 14 +++++--
 .../amd/display/dc/optc/dcn401/dcn401_optc.c  | 22 +++++-----  .../amd/dis=
play/dc/optc/dcn401/dcn401_optc.h  | 19 +++++++++
 .../dc/resource/dcn401/dcn401_resource.c      |  4 +-
 .../drm/amd/display/dc/{spl =3D> sspl}/Makefile |  2 +-  .../drm/amd/displ=
ay/dc/{spl =3D> sspl}/dc_spl.c |  0  .../drm/amd/display/dc/{spl =3D> sspl}=
/dc_spl.h |  0  .../display/dc/{spl =3D> sspl}/dc_spl_filters.c |  0  .../d=
isplay/dc/{spl =3D> sspl}/dc_spl_filters.h |  0  .../dc/{spl =3D> sspl}/dc_=
spl_isharp_filters.c  |  0  .../dc/{spl =3D> sspl}/dc_spl_isharp_filters.h =
 |  0
 .../{spl =3D> sspl}/dc_spl_scl_easf_filters.c   |  0
 .../{spl =3D> sspl}/dc_spl_scl_easf_filters.h   |  0
 .../dc/{spl =3D> sspl}/dc_spl_scl_filters.c     |  0
 .../dc/{spl =3D> sspl}/dc_spl_scl_filters.h     |  0
 .../display/dc/{spl =3D> sspl}/dc_spl_types.h   |  0
 .../dc/{spl =3D> sspl}/spl_custom_float.c       |  0
 .../dc/{spl =3D> sspl}/spl_custom_float.h       |  0
 .../amd/display/dc/{spl =3D> sspl}/spl_debug.h  |  0  .../display/dc/{spl =
=3D> sspl}/spl_fixpt31_32.c |  0  .../display/dc/{spl =3D> sspl}/spl_fixpt3=
1_32.h |  0
 .../display/dc/{spl =3D> sspl}/spl_os_types.h   |  0
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  6 +++
 75 files changed, 304 insertions(+), 107 deletions(-)  rename drivers/gpu/=
drm/amd/display/dc/{spl =3D> sspl}/Makefile (96%)  rename drivers/gpu/drm/a=
md/display/dc/{spl =3D> sspl}/dc_spl.c (100%)  rename drivers/gpu/drm/amd/d=
isplay/dc/{spl =3D> sspl}/dc_spl.h (100%)  rename drivers/gpu/drm/amd/displ=
ay/dc/{spl =3D> sspl}/dc_spl_filters.c (100%)  rename drivers/gpu/drm/amd/d=
isplay/dc/{spl =3D> sspl}/dc_spl_filters.h (100%)  rename drivers/gpu/drm/a=
md/display/dc/{spl =3D> sspl}/dc_spl_isharp_filters.c (100%)  rename driver=
s/gpu/drm/amd/display/dc/{spl =3D> sspl}/dc_spl_isharp_filters.h (100%)  re=
name drivers/gpu/drm/amd/display/dc/{spl =3D> sspl}/dc_spl_scl_easf_filters=
.c (100%)  rename drivers/gpu/drm/amd/display/dc/{spl =3D> sspl}/dc_spl_scl=
_easf_filters.h (100%)  rename drivers/gpu/drm/amd/display/dc/{spl =3D> ssp=
l}/dc_spl_scl_filters.c (100%)  rename drivers/gpu/drm/amd/display/dc/{spl =
=3D> sspl}/dc_spl_scl_filters.h (100%)  rename drivers/gpu/drm/amd/display/=
dc/{spl =3D> sspl}/dc_spl_types.h (100%)  rename drivers/gpu/drm/amd/displa=
y/dc/{spl =3D> sspl}/spl_custom_float.c (100%)  rename drivers/gpu/drm/amd/=
display/dc/{spl =3D> sspl}/spl_custom_float.h (100%)  rename drivers/gpu/dr=
m/amd/display/dc/{spl =3D> sspl}/spl_debug.h (100%)  rename drivers/gpu/drm=
/amd/display/dc/{spl =3D> sspl}/spl_fixpt31_32.c (100%)  rename drivers/gpu=
/drm/amd/display/dc/{spl =3D> sspl}/spl_fixpt31_32.h (100%)  rename drivers=
/gpu/drm/amd/display/dc/{spl =3D> sspl}/spl_os_types.h (100%)

--
2.43.0

