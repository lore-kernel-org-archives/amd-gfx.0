Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3BA0D75E4F
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Nov 2024 14:06:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E34A10EB8B;
	Fri, 22 Nov 2024 14:06:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zE/V2rYA";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2057.outbound.protection.outlook.com [40.107.220.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66F4910EB8B
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Nov 2024 14:06:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IHCXX1iOYzWVHL3mYDZ2IMxyxzeQApee9t9LuVBeg71HfXKB/Q0aC/flPmdTvfymOT3V4FHF0M9EXUjIEzNtRcEGzxgk25CvqtwmiOFYnvWYktTuYUNyvvKGcgOZ22850BT5oVnkGhqiMxgqWTO7+IgeKwgu9TARhQixl+sdQwcYdkM+bmcDSWc1FzvS5zDtG8MHUubuX6zoNSZ6PoCjLSCBYTDcc3cGjyPk8tIaPCBDrkZdfxRRXA61uaidy/bnIPcq4guMcb2nD1Tl4PsJZvMzqFOdmeUISC7FHOPEGk99HbdI17YxuZLgC1CiSA1XjBoi8VODXPIk3A5L/iNAFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CYapd5ZUbKtto8vOLxESgQg9Tak3JPESTkzjQXb/eX4=;
 b=OiP4I3A+X9A3RRPMIpgZ+P/2yW4/P+UEdP8lhRss5c1l3Br7BJUyDL0etehR5id1FgrG5gKNqEX0G1RqFU8A3r9kIWY0JnaoNpy9kpjnRKygfOk3Ghap9sPtiCNQkhD5ihX8R73mmfztnSDV+wEl4DxNyuNPIzIMuz7GEtbGLeONSMLMtnjkS26kD+qifcoSnmM5gYUZJ/bcppTzhGaSJawnMhgkjApldOtMhpdUK2jscMRluIH0SozsWq9dH3zVAy4O9qRp3FYfwe4+tvTWEwyTbo6coh8jAc0km01BORaw8Y4h4gSBv3T4gI4CGfXbkkYQk6BI66ZplL6IbfB5bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CYapd5ZUbKtto8vOLxESgQg9Tak3JPESTkzjQXb/eX4=;
 b=zE/V2rYA9Jbjet91POSnuejkxTylnCU12n4PpRmie5ozoGNUjAJv9/S5tI4rfSQws7tkRpv07ZSTIpQ0/DBxgPFYgO+EfSNfgSBC5P6TUPH7ii4F7gVwDh22wRBz8Db3huc0rUAcvbouOpzy6EZ3qcp7WigiabAl/r8Y7tC7y/4=
Received: from CY5PR12MB6527.namprd12.prod.outlook.com (2603:10b6:930:30::13)
 by BL1PR12MB5755.namprd12.prod.outlook.com (2603:10b6:208:392::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.19; Fri, 22 Nov
 2024 14:06:15 +0000
Received: from CY5PR12MB6527.namprd12.prod.outlook.com
 ([fe80::6ac9:89ee:fdef:754e]) by CY5PR12MB6527.namprd12.prod.outlook.com
 ([fe80::6ac9:89ee:fdef:754e%4]) with mapi id 15.20.8182.016; Fri, 22 Nov 2024
 14:06:12 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Hung, Alex" <Alex.Hung@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Wentland, Harry" <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)"
 <Sunpeng.Li@amd.com>, "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
 "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>, "Li, Roman"
 <Roman.Li@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>, "Chung, ChiaHsuan
 (Tom)" <ChiaHsuan.Chung@amd.com>, "Zuo, Jerry" <Jerry.Zuo@amd.com>, "Mohamed, 
 Zaeem" <Zaeem.Mohamed@amd.com>, "Chiu, Solomon" <Solomon.Chiu@amd.com>
Subject: RE: [PATCH 0/9] DC Patches Nov 19, 2024
Thread-Topic: [PATCH 0/9] DC Patches Nov 19, 2024
Thread-Index: AQHbOuO2BYGmdB9Eq0OBSLfuhC76g7LDWQMw
Date: Fri, 22 Nov 2024 14:06:11 +0000
Message-ID: <CY5PR12MB6527E271A2182E1DE7E099B99C232@CY5PR12MB6527.namprd12.prod.outlook.com>
References: <20241120003044.2160289-1-alex.hung@amd.com>
In-Reply-To: <20241120003044.2160289-1-alex.hung@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=3b2d794e-8b0a-43e5-9680-cca86b722556;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2024-11-22T14:05:51Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6527:EE_|BL1PR12MB5755:EE_
x-ms-office365-filtering-correlation-id: a60cd1b1-97a9-4884-f414-08dd0afed236
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?gzQKZkmJMfN2lLGUJ8MKZXEhP5TcMpPZXv64615wOaDhS7CgICFdymoY1w?=
 =?iso-8859-1?Q?ZE7h2ZPuDnK3/1XAkG3QvvOjFa+gBXH1l0uC3+c1A46HTUIeXqpi1knPit?=
 =?iso-8859-1?Q?IOJjt6LhE7jYL7Os77jDHapm3+fs9Ar08t1VSF/dnfyVFaAG1vSLTFbSLg?=
 =?iso-8859-1?Q?lC2eUawDi6PnQZoz0kMaWufuMBkncOeB8IR6PCvrzsU+t88+XmMm6voiz1?=
 =?iso-8859-1?Q?ZhwKzC3Bg+rVSQvbtNgezg9IfhyetdoF8ub43ecWSRazyxM60Xf/Tbgzen?=
 =?iso-8859-1?Q?StH4LURpP8fbdrgGUmP71B9fNonG3b1R+0TJ5/e37eV5imPNQepbzfymTU?=
 =?iso-8859-1?Q?QeE3HpvlyMr38+KoIp1dH97oConM8usQguvjS0AE0+q+lmkI2kmBfEBPT6?=
 =?iso-8859-1?Q?7iyQzWwrA9/zd+76YoHGxD1v0Nn4muaMQEU1j51sVdDXJYd9fHXqnqv0xA?=
 =?iso-8859-1?Q?midKu8yGujovHGKYr90hAKQ8MrOrPADFy+swqEIytgsI9DuEZ9AqrW/l9m?=
 =?iso-8859-1?Q?RJ8/KdyBay5XCWugQBCNo5SG/ZZMMCrRZVraE7uXqikZn3CE7KHg2S6Lex?=
 =?iso-8859-1?Q?uRUUAXtE7PwRd2P9FCp0ZEa1U2GU0evaZeIvs0X2oneCV1r+Acqz1cmRNB?=
 =?iso-8859-1?Q?0g9AP+Hh8Q50tGUSSfOchXX1JUPBbu8Qr//wBDpAgEDr4O6VgIsVKTduMz?=
 =?iso-8859-1?Q?bMDABPWlx89vzZa2lNrEr/S4VDjRfzYEaUOYRsNQ13KSJDropU+9TgjgAn?=
 =?iso-8859-1?Q?oO8yo3nM30ei4TkVeCLYBeMinKn0UZhW4pL9h783+t+GPmnOi9Dgv0MYfB?=
 =?iso-8859-1?Q?Qh1a1tVOsxlgZsZU6uVeSnfeBMy9/1TMfSZqMAN29BSWBBevJK4EUbOs2a?=
 =?iso-8859-1?Q?TTPZKK9omyMGzFKHZ2fx0QcZqcITJsNKxjtTRfTRN9AFbLddEPXGMAfZCj?=
 =?iso-8859-1?Q?GjLqe0lo1bJkpSjYmXY1Be8qcVZ7GNG4UxJaUvZ8ntOZ1YWTCT7ga+uWrf?=
 =?iso-8859-1?Q?/HD3oFlS/CRs2ZgNVI6GI55+wRz6aY7NRWxL5eu3ZnKp5GQx0U0Ltvyvat?=
 =?iso-8859-1?Q?wra6JHdiL6AlUudt+BGpDQMgy6T9g1vxpDji8RgGJYLS9I/WSduhsd/reT?=
 =?iso-8859-1?Q?spNapw7RMPFCa2r8zMkNjmEumolPaeVkb551HrSf0kpTE5MgFbIU485tk2?=
 =?iso-8859-1?Q?T3CCi56TvnMhhNRegsEiqylp7oAgGPL+nt5O8JyGpADRRoM8sp7AgTjBQu?=
 =?iso-8859-1?Q?G8qKjvsyQUMNIe6dH65jOAegFwJUY0+gRvtgn87E/km7926uFstdsR5FdG?=
 =?iso-8859-1?Q?+xjVqQMQnJYGVIrri0rYBRIeslwTiHRXy0N/klKl5ud5Zl2RDM6x/KLksv?=
 =?iso-8859-1?Q?Z9A5oQ1qXvMYvPH07HbVSAUjn27TNL5/eQMvqyGj88AXop54YJyjQ=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6527.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?HcZVYLitOYU9cg9Vq2vuojz5OdeFFy9Gj2wzOKlGp3DgfWJGW7qrO6GrSh?=
 =?iso-8859-1?Q?SAGiqvJmFbowtwuroTub6mu4q51AetFHKU8gMGcVK8R0p6Q31hqOO6KhKc?=
 =?iso-8859-1?Q?jiRUoqLhObFEc/6wLupNUFTaw87ar/IEoCkk/Uys9ucuOopMDEqVEq2Ygb?=
 =?iso-8859-1?Q?b7LSNKnDcTUmN1ctnJwAheUPiLPbvxQj6Vcc7KwUeabhPynijpf55Ryl24?=
 =?iso-8859-1?Q?QoGqTdI/Or9XN41mODWRs2v1/IZHqKKhZk1DM0862P/J4nsjeqe0Wsfx36?=
 =?iso-8859-1?Q?pTDriLUm0uWoFnEIc5MEgN0uKmbdVArUNxRwHquAT6jvQSzeJFftqdR2T9?=
 =?iso-8859-1?Q?Nm323+rmwrD7OP7gvkxswRERlFmYaFOCpLcVXWre/4+/ozQBSCbsSGJWbf?=
 =?iso-8859-1?Q?bg0OLF+1MnfZQxhmMFpda542SMG5Kw6hBM8wjOzAXQE1268V5uWb+9e53L?=
 =?iso-8859-1?Q?XX248azLLwCgPDkqRTGb4Ergl5SQGc52w09zsiSeOx4lsoenlsLTL4SjK6?=
 =?iso-8859-1?Q?5zsvT5ANVPY9hZ221IrnvvVY7SBheUmt4IIm2MW98ayvE5vKcF2eLrKvOH?=
 =?iso-8859-1?Q?CuZpWyXbxNZrM3Sbu1SDIbifUe+jCYlfg/EhS/QWnRvyB+g11wlGxzl7N3?=
 =?iso-8859-1?Q?pmSsSRPPW8D5Y+S6z9sdrG7QMprRMGwJmIQ+o0WpUMBTXIrEJ/Tqp1xi7x?=
 =?iso-8859-1?Q?xUNPcFrdyqSO2RfvHOU7aagOkxzPFiIqwn3Jku55daWjdKfmM3jOnBUA5+?=
 =?iso-8859-1?Q?QjbeqHMG3L8dtE7UUWii7NJ07hw6r6gWJLYxmyrDeNhp+W1k+62Ja7vNYH?=
 =?iso-8859-1?Q?nbazjjdq0uzBcnTJfULyJlLwp/D+QFCDdCojfH++qW7QerR2vjx3EK+JUX?=
 =?iso-8859-1?Q?hdny3UBbhqQ5MYHpKMPg5VUIg4H8w7+2RlnsMYPqw5cI/2Yh/FQQZb49YG?=
 =?iso-8859-1?Q?U9/2aXLsxaOND+wgZcEQauFhIUeKOcb6FjgLiDNqNSECqqnJSQ1Hd/EQKd?=
 =?iso-8859-1?Q?9ViUreIiPgrE0Ge0LjBZVHLaS4FLcLlriX0GSRbl1vhAdLMfNGkSpxDxEF?=
 =?iso-8859-1?Q?J8BdR8DamiTzyU1vTFpmvlPw8fxS1rGMd0LNXKiq4lw7n5lGorUYRXhcIL?=
 =?iso-8859-1?Q?OEJ6ClkmIp1hq7RFLUsQ3d7B1A+ucCDliCbTxFbK9+1pbx+QOWftK8+f0D?=
 =?iso-8859-1?Q?NmLNCyz3pm9e2Rxz3Upq3QKTM9/pu7DO2kJ86v9+U1XAoP1YrUe2gN4Nhd?=
 =?iso-8859-1?Q?E50Id6TpKTFN6zdgQkPQM6cS4sBH9cnG7ILfUxEAANazX/+YHcmfHzScCj?=
 =?iso-8859-1?Q?2f/9Ft2YFuPdAptPG84jFoEBfMAkwAL8VL0Ds/TuEopQZcUcuC/Pdp90CA?=
 =?iso-8859-1?Q?MZgHnZ5tOOMCJfLFUIsBWluHCxxDGIEcsam/1Im6yKmOqXo+EuaY8uS9Ca?=
 =?iso-8859-1?Q?Dl4LZsNtDRnJClRIoFsMM/F1Cv4eFdL7olRrP9OQMuL547JA/dCAtDv6/c?=
 =?iso-8859-1?Q?pmUW0+PjsLTy4DNYobwRX6F8GLyntikxR4dCApX70UfrHLgTRyPX90xUJJ?=
 =?iso-8859-1?Q?zDqA82lxs0SVlQ29drdx3acqA0jdCVH5TQ3YgYQmXVgMhLn3o8rH2mZiGt?=
 =?iso-8859-1?Q?SQ6IU8mbPwtKA=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6527.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a60cd1b1-97a9-4884-f414-08dd0afed236
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2024 14:06:11.8144 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KvNqgOyqncfdgYbsc2smxHEWyPpBr4twfiKPte4YzdW4t4MZQdYoFx5YnU7reIwMk/0dnXB5kSB4RIKj7FYQlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5755
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
        * Single Display DP -> 4k144hz, 4k240hz
        * Multi display -> eDP + DP/HDMI/USB-C -> 1080p 60hz eDP + 4k 144hz=
, 4k 240hz (Includes USB-C to DP/HDMI adapters)
        * Thunderbolt -> LG Ultrafine 5k
        * DSC -> Cable Matters 101075 (DP to 3x DP) with 3x 4k60hz displays=
, HP Hook G2 with 2x 4k60hz displays
        * USB 4 -> HP Hook G4, Lenovo Thunderbolt Dock, both with 2x 4k60hz=
 DP and 1x 4k60hz HDMI displays
        * SST PCON -> Club3D CAC-1085 + 1x 4k 144hz, at a max resolution su=
pported by the dongle of 4k 120hz YUV420 12bpc.
        * MST PCON -> 1x 4k 144hz, at a max resolution supported by the ada=
pter of 4k 120hz YUV420 12bpc.

DGPU
        * Single Display DP -> 4k144hz, 4k240hz
        * Multiple Display DP -> 4k240hz + 4k144hz
        * MST (Startech MST14DP123DP [DP to 3x DP] and 2x 4k 60hz displays)
        * DSC (with Cable Matters 101075 [DP to 3x DP] with 3x 4k60hz displ=
ays)

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

The patchset consists of the amd-staging-drm-next branch (Head commit - 84c=
fda24bb8e0bbb4c3d7ffc02c1ba7e5ab68ee0 -> drm/amd: Fix initialization mistak=
e for NBIO 7.11 devices) with new patches added on top of it.

Tested on Ubuntu 24.04.1, on Wayland and X11, using KDE Plasma and Gnome.

Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>



Thank you,

Dan Wheeler
Sr. Technologist  |  AMD
SW Display
---------------------------------------------------------------------------=
---------------------------------------
1 Commerce Valley Dr E, Thornhill, ON L3T 7X6
Facebook |  Twitter |  amd.com


-----Original Message-----
From: Hung, Alex <Alex.Hung@amd.com>
Sent: Tuesday, November 19, 2024 7:28 PM
To: amd-gfx@lists.freedesktop.org
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.L=
i@amd.com>; Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; Pillai, Aurabindo=
 <Aurabindo.Pillai@amd.com>; Li, Roman <Roman.Li@amd.com>; Lin, Wayne <Wayn=
e.Lin@amd.com>; Chung, ChiaHsuan (Tom) <ChiaHsuan.Chung@amd.com>; Zuo, Jerr=
y <Jerry.Zuo@amd.com>; Mohamed, Zaeem <Zaeem.Mohamed@amd.com>; Chiu, Solomo=
n <Solomon.Chiu@amd.com>; Wheeler, Daniel <Daniel.Wheeler@amd.com>; Hung, A=
lex <Alex.Hung@amd.com>
Subject: [PATCH 0/9] DC Patches Nov 19, 2024

This DC patchset brings improvements in multiple areas. In summary, we have=
:

* Add hblank borrowing support
* Limit VTotal range to max hw cap minus fp
* Correct prefetch calculation
* Add option to retrieve detile buffer size
* Add support for custom recout_width in SPL
* Add disable_ips_in_dpms_off flag for IPS
* Enable EASF based on luma taps only
* Add a left edge pixel if in YCbCr422 or YCbCr420 and odm

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Aric Cyr (1):
  drm/amd/display: 3.2.311

Chris Park (1):
  drm/amd/display: Add hblank borrowing support

Dillon Varone (1):
  drm/amd/display: Limit VTotal range to max hw cap minus fp

Lo-an Chen (1):
  drm/amd/display: Correct prefetch calculation

Nicholas Kazlauskas (1):
  drm/amd/display: Add disable_ips_in_dpms_off flag for IPS

Peterson Guo (1):
  drm/amd/display: Add a left edge pixel if in YCbCr422 or YCbCr420 and
    odm

Samson Tam (2):
  drm/amd/display: Enable EASF based on luma taps only
  drm/amd/display: Add support for custom recout_width in SPL

Sung Lee (1):
  drm/amd/display: Add option to retrieve detile buffer size

 drivers/gpu/drm/amd/display/dc/core/dc.c      | 18 +++++++
 .../gpu/drm/amd/display/dc/core/dc_resource.c | 42 +++++++++++++++-
 drivers/gpu/drm/amd/display/dc/dc.h           |  7 ++-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |  2 +-  .../gpu/drm/amd/dis=
play/dc/dc_spl_translate.c | 10 ++--
 .../amd/display/dc/dml2/display_mode_core.c   |  1 +
 .../dc/dml2/dml21/dml21_translation_helper.c  | 48 +++++++++++++++++--
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.c   |  3 +-
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |  7 ++-
 .../gpu/drm/amd/display/dc/inc/core_types.h   |  3 ++
 .../gpu/drm/amd/display/dc/link/link_dpms.c   |  3 +-
 .../dc/resource/dcn20/dcn20_resource.c        | 23 +++++++++
 .../dc/resource/dcn30/dcn30_resource.c        |  1 +
 .../dc/resource/dcn302/dcn302_resource.c      |  1 +
 .../dc/resource/dcn303/dcn303_resource.c      |  1 +
 .../dc/resource/dcn31/dcn31_resource.c        |  7 +++
 .../dc/resource/dcn31/dcn31_resource.h        |  3 ++
 .../dc/resource/dcn314/dcn314_resource.c      |  1 +
 .../dc/resource/dcn315/dcn315_resource.c      |  1 +
 .../dc/resource/dcn316/dcn316_resource.c      |  1 +
 .../dc/resource/dcn32/dcn32_resource.c        |  2 +
 .../dc/resource/dcn321/dcn321_resource.c      |  1 +
 .../dc/resource/dcn35/dcn35_resource.c        |  2 +
 .../dc/resource/dcn351/dcn351_resource.c      |  2 +
 .../dc/resource/dcn401/dcn401_resource.c      |  1 +
 drivers/gpu/drm/amd/display/dc/spl/dc_spl.c   | 37 +++++++++-----
 .../gpu/drm/amd/display/dc/spl/dc_spl_types.h | 10 +++-
 .../amd/display/modules/freesync/freesync.c   | 13 ++++-
 28 files changed, 223 insertions(+), 28 deletions(-)

--
2.43.0

