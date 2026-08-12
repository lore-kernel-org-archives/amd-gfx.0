Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 015C5C5B56A
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Aug 2026 17:20:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E03410F0A6;
	Wed, 12 Aug 2026 17:20:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="H1c4/+SD";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012022.outbound.protection.outlook.com
 [40.107.200.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7CB410F0A6
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Aug 2026 17:20:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PN8LqVAT9Z39fak9lnd8sm13TB8ankKY2ch169xvHYsP6f189b0RSRsfva5K99inIzLBzVfTMu4bzB+FEBeLASJ60dyQo8RdFuIG7fLoKNFp9d5Xj/Y1lUToShNnGdDfkeTxgAF9hmB0u1VQcc6HBN66/+bMqsY9hnJz7pI2PO/avJPk8YgVyx50bKAfgllSOB3rxGAH7PvjvGskXPVcLgOl7Tv+/tGjmJVGvzO1XZaGcR/qIIoHPEBUuFGfSroMWGVcfW4FMdDnnRInmx94B9K+onf9fj6kBmc9yAMqeB2muD3hpLTdQLMkFMOsZ03FJKgHeXz7gzneanGW1eiS0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dGoFMxK8NEux6dqndH9FsKn4n+FSRtq4cWgWCX6llzY=;
 b=VTMzPDC/z+SGYSTUxzxI8NE/WMCSDMJO6jsGtWBad29k1fOkuqLq2YJJ+FJzUAlLLHs3bcoi2RO9BiIMWqw2SCn6VsHyqnAKJ67iPXHtOLrlB9/KubPGAja2NDSn4JlIVLFRYkSiaIOWxqGM7NnTUroq1If3uxRnsuua4JGhs1KZxiSeI1PiV6H2f1OnD/WyFwe2uxg2licDj+NWnqor1E5xls/+huWaBqYbvFQv6zMP8ouT0X6UjmCO15+qP9nsjC7srQNfENOL6loJLDynQDRofcYUyZeWrQh9uLP4T2gcqTa2lwtYCdXtipxVwC9Lry+osBq64Y2RQ1mVm/++jA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dGoFMxK8NEux6dqndH9FsKn4n+FSRtq4cWgWCX6llzY=;
 b=H1c4/+SDoqZcLXNh1W7aBbcZOWbPca/mk0WPIQgsxfFleS4HyQJka8nxSrPU2RrXuvDM++hRbPfe2fgfx/Y3ZrxRxoh3tLLxiOUZQD9MuVHld3eBPHKeansrLf9KabpQ+YCNeWFYBuGZ/tQ7Z59tPBhRMBzVCfZ3drpG48Jth0U=
Received: from DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) by
 CH3PR12MB8970.namprd12.prod.outlook.com (2603:10b6:610:176::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.11; Wed, 12 Aug
 2026 17:20:30 +0000
Received: from DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::b2e1:64e5:3b9e:738a]) by DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::b2e1:64e5:3b9e:738a%6]) with mapi id 15.21.0315.011; Wed, 12 Aug 2026
 17:20:28 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Chung, ChiaHsuan (Tom)" <ChiaHsuan.Chung@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Wentland, Harry" <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)"
 <Sunpeng.Li@amd.com>, "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>, "Li,
 Roman" <Roman.Li@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>, "Chung,
 ChiaHsuan (Tom)" <ChiaHsuan.Chung@amd.com>, "Zuo, Jerry" <Jerry.Zuo@amd.com>, 
 "Wu, Ray" <Ray.Wu@amd.com>, "LIPSKI, IVAN" <IVAN.LIPSKI@amd.com>, "Hung,
 Alex" <Alex.Hung@amd.com>, "Lin, Ping Lei" <PingLei.Lin@amd.com>, "Chen,
 Chen-Yu" <Chen-Yu.Chen@amd.com>
Subject: RE: [PATCH 00/34] DC Patches Aug 10 2026
Thread-Topic: [PATCH 00/34] DC Patches Aug 10 2026
Thread-Index: AQHdJKU7ZbLW337vsUubUerhM7OI8raXS/LQ
Date: Wed, 12 Aug 2026 17:20:27 +0000
Message-ID: <DS0PR12MB6534E61D528869D8500F44889CDC2@DS0PR12MB6534.namprd12.prod.outlook.com>
References: <20260805063937.2145774-1-chiahsuan.chung@amd.com>
In-Reply-To: <20260805063937.2145774-1-chiahsuan.chung@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Enabled=True;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SetDate=2026-08-10T13:18:47.0000000Z;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Name=AMD Public
 v26; MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_ContentBits=3;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6534:EE_|CH3PR12MB8970:EE_
x-ms-office365-filtering-correlation-id: c626d934-f7a0-499e-0581-08def896010c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|38070700021|6133799003|56012099006|10067099003|11063799006|22082099003|18002099003|3023799007;
x-microsoft-antispam-message-info: Ej9rnVt8UdngwRNaR3Q1ARtjesYFNjLKwv4XTr8FlAnJek6y3cs7Q2sQ3eg8lVb07URChHA2HdCPTXqnaKwSxxwkSaW2KSy1lKiITq62tBpQFO0ZHrhpKhcvLmKGuVPL++0ApzP2M6aMVesIF2Hm/2cZ+y1Y2XIZhmVzKps8ofllpKaUhx/NfQljxwCMeQ0h1IxRLKRVxDMMelSIjAmpA0JF4eXOz6j5wOxM8IbEs/cGNGEKRtErkQLkGB0RJwqyRSRhd4cE2yvYviQ9a+qyNX7AA/orUs8Tka4RvoQozzGf+p+VaQJ4Kcv2r/FoNAkS04Lh2/Q1XCAEmgZk5VI/j/nrtebhGESUn3vxPShSlythV52FFoz/6jEE61Scz99jBaOKz54gLxNuS3R8I1cGTktui9jpu52xkDVvajgb75BIZPWFdYA7XqKb6QrT6aRf1/KymLVQyGqxHmKsFO/jaFYAuQlSM6ozD8W1nD8Q+WY94SQKo3MexVdEtyPRSDT7yAM3uteAl+ATASib8wR7kO8Tn3K8RqXyHZx17PCyJYpHtBriNVORsCENcjMik721jlHcqWKMgS4k5a8heBh9kJbl6WfU+8x4vVJmJMbzse2QHB3IVQhe1kn+d+C0D1CegaWNHyIVhkY/xFVUEzkUDDbmjAKdMlIAMkdJgO2rkqqNeFs3hwSKFFjmmK9u0OKcaoS/zIDSSvFaY9+wuhf7lS652DjvEaTtcTr9O1JwG2E=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6534.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(38070700021)(6133799003)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?AAUTG9FoNp/2TIsKtAoTt2WMcV1sZsz00EFmqhXMbIRmv8A5M7dr+NywRM?=
 =?iso-8859-1?Q?bd4nqS4zdUMKcK0XCCQhhFz9X8RIsSBqWM5Xsjp8DYCDHJJDD0ay9Nsr7L?=
 =?iso-8859-1?Q?fP8c4jbYU3AWdH1BT7WRKbsgAJPNHC/aXV2B4fyy5pQGCBoh7BIk2OkdIx?=
 =?iso-8859-1?Q?rWdxBnh4MAaQnAQltshS99P6rUiDB0uzAXj1YcS/Wn9m/MuMIk9xZobZNB?=
 =?iso-8859-1?Q?P/EeBl2rye1XCpxEwrta3PXBvPQXrZnGS21huUMgaCu0SzNHuFo4osBNPX?=
 =?iso-8859-1?Q?WKeNLjSremqwXV31Wx1Ah0unkofgzDHDTssx3tC9qvKeV8tyGOuVzyDJgu?=
 =?iso-8859-1?Q?rBkgfF3uOdCXuNs5NUY3hVunlfzSCoB9ZNXM3zeYhUldRyagB1MOKJQnQE?=
 =?iso-8859-1?Q?mkZDSSOemM9/cbcaS8iZI09FRPuSMDwsoYhcy0EdKQ1jHkjwM5r4RLBx5I?=
 =?iso-8859-1?Q?B8lrn3ZwSjr/UgO0/JKlX0E7q0WPPaWSNZw5bzg66qEz3bfNjDvdeEwTCz?=
 =?iso-8859-1?Q?Yg0KvRXFx/YrK6IrSUWTv5Fz95kXDi+xXZ8BKQGrmTHURRI2dF60HDTngb?=
 =?iso-8859-1?Q?+yErwCSIZf5DUN9aXHs5mdhLMgp46+5czB3bbpZQ75GaZ6H6thjPqIcKwd?=
 =?iso-8859-1?Q?0xex+nUYU4XxDmHSh1w4I1pW0dEaVRgyRnGbles8heG693g+kzGV5VVfbm?=
 =?iso-8859-1?Q?SPWboSKnXDajKHoDwjLxcsDvSfCPz5g2TwXVsbgy1j6WFtTqmsCN3t7rxQ?=
 =?iso-8859-1?Q?tcKQbTrj+RUnBJSS2ja4gO4JroZfxkP8tIM984Ta1isr60Yhv9Zmzh3PcQ?=
 =?iso-8859-1?Q?vnmOLZMzrVAICfaaqPawzlhGKf6JLCEPhmH5t8ruiQAZS1XDYWhlwbYBY9?=
 =?iso-8859-1?Q?wY8/cAFpcsq6MOs77xtvVmOHIGsoSzMFZwfoK3IcfPKxCVaTFwdU+wXqY4?=
 =?iso-8859-1?Q?udbLGwBsBtWoTMG7gZVxf/9ZaDlj4L+LCOc3WzbeMrGqJ71y5eMHjK38QA?=
 =?iso-8859-1?Q?KZj0n5DYGjLgksEqbE2nF/ehNa4nBjXKpq0ddEiLYk79rGW2q736fJ9B68?=
 =?iso-8859-1?Q?gZtRXwcqQ1+SF4a0HlWC8L9ojeECHOPbOCwRUPil3pkYRI/EWbpEY6XbkH?=
 =?iso-8859-1?Q?iEIoSd5j0aOGcGA1OcL3rQTsl5HzvmKTcYweyK2m7gnuMRyPeU/esRbT1U?=
 =?iso-8859-1?Q?+gXsymNTUdmBQURyQQwZDon2A5yiOaFkNGWKtn0tdhrJVwLAXS+wvDChtO?=
 =?iso-8859-1?Q?hHl3Jh2HdXjiM+qCibukCs7ntKIUdOeXkeFdN35vGrIySbsS/Tcv9hfTT7?=
 =?iso-8859-1?Q?IogTR+Gk66a4G1ruwoOUYwtGA+g05VM04J34WqriMUorTAZBRTRDsts7Ql?=
 =?iso-8859-1?Q?q14Z5SGB5JyO9Xhyi559+mBPOkOigDJPGZSiwgTAF8uQWHvU5UOfHNwGl3?=
 =?iso-8859-1?Q?4ytmYy5vxp1CU2Qr+tHXcwZDIimtHRNemDMS7hWl2wPI7AYaiR6NGesS/e?=
 =?iso-8859-1?Q?EXV8rDozn0IctEqAYjTtXizHbnKieh0LyoUfRivggljwi9H9pO/hYPbLuz?=
 =?iso-8859-1?Q?n3gcfTBuZ5v2SlY4E5xkjyXV0h4RK1fPYXQDJdWhWX0xssshf+u3Z1GcRB?=
 =?iso-8859-1?Q?6Up/H8fL3+a3xahjSjl5D2mRI1Ri+oFunitDQV9aD9drtXI6nXelOxILQy?=
 =?iso-8859-1?Q?LzpDEMdKR3Hv4Jj2vn+zp7dHxXA8UODB51LBgc1biQ7J33Ausi3kpnUjXn?=
 =?iso-8859-1?Q?y3VIzerJ9NnO13who8OFvt5j9wSXnHL41Qp+0AaSWwpows?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c626d934-f7a0-499e-0581-08def896010c
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2026 17:20:27.9476 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RlPdW+H7HcWy+nzWzOnY0QZGjcP5KZ+7rd1pYwhNCC9aXub9WMzH19pTxipunoOmwN4EUyppFa2HiCCgRZoq5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8970
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

Hi all,

This week this patchset was tested on 4 systems, two dGPU and two APU based=
, and tested across multiple display and connection types.

APU
        * Single Display eDP -> 1080p 60hz, 1920x1200 165hz, 3840x2400 60hz
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
        * Samsung ATNA60YV02-0 3840x2400 60Hz OLED eDP


The patchset consists of the amd-staging-drm-next branch (Head commit - 523=
4cbd0f4b39bbf04640566218b08ff47d51bc7 -> drm/amd/display: Promote DC to 3.2=
.392) with new patches added on top of it.

Tested on Ubuntu 26.04, on Gnome Wayland.

Tested-by: Dan Wheeler <daniel.wheeler@amd.com>


Thank you,

Dan Wheeler
Sr. Technologist | AMD
SW Display
---------------------------------------------------------------------------=
---------------------------------------
1 Commerce Valley Dr E, Thornhill, ON L3T 7X6
amd.com


-----Original Message-----
From: Tom Chung <chiahsuan.chung@amd.com>
Sent: Wednesday, August 5, 2026 2:36 AM
To: amd-gfx@lists.freedesktop.org
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.L=
i@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>; Li, Roman <Roman.=
Li@amd.com>; Lin, Wayne <Wayne.Lin@amd.com>; Chung, ChiaHsuan (Tom) <ChiaHs=
uan.Chung@amd.com>; Zuo, Jerry <Jerry.Zuo@amd.com>; Wheeler, Daniel <Daniel=
.Wheeler@amd.com>; Wu, Ray <Ray.Wu@amd.com>; LIPSKI, IVAN <IVAN.LIPSKI@amd.=
com>; Hung, Alex <Alex.Hung@amd.com>; Lin, Ping Lei <PingLei.Lin@amd.com>; =
Chen, Chen-Yu <Chen-Yu.Chen@amd.com>
Subject: [PATCH 00/34] DC Patches Aug 10 2026

This DC patchset brings improvements in multiple areas. In summary, we have=
:

- DCN6 fixes on GPUVM calculations, HostVM and SOCBB VM config,
  clkmgr interfaces, and peak bandwidth measurement
- Unified fast update classification paths and inbox0 HW lock on DCN35
- HDMI FRL fixes on LT timeout behaviour and cap restore during
  non-destructive link verify
- Greatly enhanced KUnit coverage across CRTC, VRR, and cursor paths
- eDP panel polarity control, FreeSync range quirk, and Z8-based
  zstate support
- DCE ASIC code gated behind CONFIG_DRM_AMD_DC_DCE for DCN-only builds
- Fixes on HPD filter programming, DMUB DIG PHY wait, dcn42b
  force_min_dcfclk clamp, audio tests, and UTM client QC profile override


Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Alex Hung (7):
  drm/amd/display: test stream VRR updates
  drm/amd/display: test VRR IRQ parameters
  drm/amd/display: test VRR transitions
  drm/amd/display: test dm_check_cursor_fb
  drm/amd/display: test native cursor state check
  drm/amd/display: test dm_plane_color_pipeline_active
  drm/amd/display: test amdgpu_dm_crtc_get_cursor_mode

Alvin Lee (2):
  drm/amd/display: Update dcn60 clkmgr interfaces
  drm/amd/display: Apply workaround to limit SopCount for now

Bhawanpreet Lakha (6):
  drm/amd/display: Cover crtc duplicate_state stream and null guard
  drm/amd/display: Cover crtc destroy callback
  drm/amd/display: Add reset_state existing-state branch test
  drm/amd/display: Add amdgpu_dm_crtc_late_register test
  drm/amd/display: Add amdgpu_dm_crtc_init tests
  drm/amd/display: Add KUnit tests for
    amdgpu_dm_crtc_helper_atomic_check

Charlene Liu (2):
  drm/amd/display: fix HPD program filter programming
  drm/amd/display: add a NULL pointer check

Dillon Varone (1):
  drm/amd/display: Add support for overriding UTM client QC profile

Fangzhi Zuo (2):
  drm/amd/display: Force FreeSync range minimum on quirky panels
  drm/amd/display: restore FRL cap on non-destructive HDMI link verify

Gabe Teeger (1):
  drm/amd/display: clamp force_min_dcfclk to dcn42b range

Gaghik Khachatrian (1):
  drm/amd/display: gate DCE ASIC code behind CONFIG_DRM_AMD_DC_DCE

Harry VanZyllDeJong (1):
  drm/amd/display: eDP panel polarity control and test support

Nicholas Kazlauskas (2):
  drm/amd/display: Fix crash in DCN5/6 calcs when GPUVM enabled
  drm/amd/display: Fix HostVM init and SOCBB VM config for DCN6

Ovidiu Bunea (1):
  drm/amd/display: Decide zstate_support based off Z8 global support

Rafal Ostrowski (1):
  drm/amd/display: Unify fast update classification paths

Ray Wu (1):
  drm/amd/display: Align KUnit tests Makefile license header

Relja Vojvodic (1):
  drm/amd/display: Update and revert FRL LT Timeout behaviour

Sridevi Arvindekar (1):
  drm/amd/display: Fix audio test errors

Taimur Hassan (1):
  drm/amd/display: Promote DC to 3.2.393

Wayne Lin (1):
  drm/amd/display: Extend DMUB wait for DIG PHY programming commands

Wenjing Liu (1):
  drm/amd/display: Fix DCN6 peak bandwidth measurement overshoot

YiLing Chen (1):
  drm/amd/display: Extend inbox0 HW lock support to DCN35

 drivers/gpu/drm/amd/display/Kconfig           |   9 +
 .../display/amdgpu_dm/amdgpu_dm_connector.c   |  12 +
 .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    |  10 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_crtc.h    |   6 +
 .../amd/display/amdgpu_dm/amdgpu_dm_cursor.c  |  16 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_cursor.h  |   6 +
 .../display/amdgpu_dm/amdgpu_dm_freesync.c    |   3 +
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |  18 +
 .../drm/amd/display/amdgpu_dm/tests/Makefile  |   4 +-
 .../amdgpu_dm/tests/amdgpu_dm_crtc_test.c     | 645 ++++++++++++++++
 .../amdgpu_dm/tests/amdgpu_dm_cursor_test.c   | 694 ++++++++++++++++++
 .../amdgpu_dm/tests/amdgpu_dm_freesync_test.c | 407 ++++++++++  .../amdgpu=
_dm/tests/amdgpu_dm_helpers_test.c  |  17 +
 .../display/dc/bios/command_table_helper.c    |   7 +-
 .../display/dc/bios/command_table_helper2.c   |   2 +
 .../gpu/drm/amd/display/dc/clk_mgr/Makefile   |   8 +
 .../gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c  |   4 +
 .../display/dc/clk_mgr/dce100/dce_clk_mgr.c   | 115 ---
 .../display/dc/clk_mgr/dce100/dce_clk_mgr.h   |   8 +-
 .../dc/clk_mgr/dce112/dce112_clk_mgr.c        |  59 --
 .../dc/clk_mgr/dce112/dce112_clk_mgr.h        |   4 +-
 .../display/dc/clk_mgr/dcn10/dcn10_clk_mgr.c  | 181 +++++  .../display/dc/=
clk_mgr/dcn10/dcn10_clk_mgr.h  |  29 +
 .../dc/clk_mgr/dcn42b/dcn42b_clk_mgr.c        |  30 +-
 .../drm/amd/display/dc/clk_mgr/dcn60/dalsmc.h | 344 ++-------  .../display=
/dc/clk_mgr/dcn60/dcn60_clk_mgr.c  | 115 +--  .../display/dc/clk_mgr/dcn60/=
dcn60_clk_mgr.h  |  17 +-  .../dc/clk_mgr/dcn60/dcn60_clk_mgr_smu_msg.c  | =
220 +++++-  .../dc/clk_mgr/dcn60/dcn60_clk_mgr_smu_msg.h  | 167 ++++-
 .../dc/clk_mgr/dcn60/dcn60_smu_driver_if.h    |  76 ++
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 246 +------
 .../drm/amd/display/dc/core/dc_link_exports.c |  22 +  .../gpu/drm/amd/dis=
play/dc/core/dc_resource.c |  79 ++
 drivers/gpu/drm/amd/display/dc/dc.h           |  42 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |  54 +-  drivers/gpu/drm/am=
d/display/dc/dc_dmub_srv.h  |  27 +
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |   3 +
 drivers/gpu/drm/amd/display/dc/dc_types.h     |   1 +
 .../display/dc/dio/dcn10/dcn10_link_encoder.c |  10 +-
 .../dc/dio/dcn42/dcn42_dio_link_encoder.c     |   4 +-
 .../dml2_0/dml21/dml21_translation_helper.c   |   2 +-
 .../dc/dml2_0/dml21/inc/dml_top_types.h       |   1 +
 .../dml21/src/dml2_core/dml2_core_dcn4.c      |   4 +
 .../src/dml2_core/dml2_core_dcn4_calcs.c      |  15 +
 .../src/dml2_core/dml2_core_dcn4_calcs.h      |   1 +
 .../dml2_core/dml2_core_dcn5_calcs_dchub.c    |   2 +-
 .../src/dml2_core/dml2_core_shared_types.h    |   2 +
 .../gpu/drm/amd/display/dc/gpio/hw_factory.c  |   4 +
 .../drm/amd/display/dc/gpio/hw_translate.c    |   4 +
 .../display/dc/hubbub/dcn10/dcn10_hubbub.h    |  11 +-
 .../display/dc/hubbub/dcn60/dcn60_hubbub.c    | 206 +++++-
 .../display/dc/hubbub/dcn60/dcn60_hubbub.h    |  19 +-
 drivers/gpu/drm/amd/display/dc/hwss/Makefile  |   6 +
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c |   2 +
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   |  46 ++
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.h   |   4 +
 .../amd/display/dc/hwss/dcn35/dcn35_init.c    |   2 +
 .../amd/display/dc/hwss/dcn351/dcn351_init.c  |   2 +
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |  15 +-
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.h |   2 +-
 .../amd/display/dc/hwss/dcn42/dcn42_hwseq.c   |  13 +-
 .../amd/display/dc/hwss/dcn42/dcn42_hwseq.h   |   2 +-
 .../amd/display/dc/hwss/dcn60/dcn60_hwseq.c   |  16 +-
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |   2 +-
 .../gpu/drm/amd/display/dc/inc/hw/dchubbub.h  |   1 +
 .../gpu/drm/amd/display/dc/inc/link_service.h |   5 +-
 drivers/gpu/drm/amd/display/dc/irq/Makefile   |   2 +
 .../dc/irq/dce110/irq_service_dce110.c        |  21 -
 .../dc/irq/dce110/irq_service_dce110.h        |   9 -
 .../gpu/drm/amd/display/dc/irq/irq_service.c  |  28 +
 .../gpu/drm/amd/display/dc/irq/irq_service.h  |   9 +
 .../drm/amd/display/dc/link/link_detection.c  |   2 +-
 .../drm/amd/display/dc/link/link_factory.c    |   4 +
 .../link/protocols/link_edp_panel_control.c   |  30 +
 .../link/protocols/link_edp_panel_control.h   |   4 +
 .../display/dc/link/protocols/link_hdmi_frl.c |  32 +-
 .../gpu/drm/amd/display/dc/resource/Makefile  |   4 +
 .../dc/resource/dce112/dce112_resource.c      |  62 --
 .../dc/resource/dcn60/dcn60_resource.c        |  10 +-
 .../dc/resource/dcn60/dcn60_resource.h        |   9 +-
 .../dcn60/dcn60_soc_and_ip_translator.c       |   6 +-
 .../gpu/drm/amd/display/include/dal_asic_id.h |   5 +
 82 files changed, 3357 insertions(+), 990 deletions(-)  create mode 100644=
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/dcn10_clk_mgr.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/dcn10_clk_=
mgr.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dcn60_smu_=
driver_if.h

--
2.43.0

