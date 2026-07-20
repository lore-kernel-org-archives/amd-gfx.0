Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F249C44515
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Jul 2026 13:09:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C39AA10E91F;
	Mon, 20 Jul 2026 13:09:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0GAsY2kI";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013015.outbound.protection.outlook.com
 [40.93.201.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7585810E91F
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Jul 2026 13:09:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TbtfAaPlh0lPkT5tuMiR5iYYQQUKocHvNlgUzH9wuPDxtE68pKQlJi1fuScWE3qROtQL2gx34Hgupoi3803BMlAM2ehlJI7MQxMAMrU86BwGVh+KV31Z1Rrj1vXyqwnsL1wSTEIRm73QzeeC7ZJKCiNIKkiFq5uXEUIeluL2DSK9i8QLOurn0iE1yuaHp54TX9195aVW9i3PcN0hKFxpnwR7kjTn5zVilhKzkQpvxf+2wS7sI/LPdFq7Nuo/qFv6actWo2yLf6vjYTgyWr4uQ2Iss7oVPyrEini5lVSFLJg6qOxMqvb8AmSoNzn2tft6PSjxuzL5ja1Ynw8jf1z7nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qwdnminbkQZXi1p9NBXM+aqGXEix2fZ2hucwpwCOb3s=;
 b=Ft3J/kzCjpjIyS8/mgjOX7DMEHDEp87hP/fOJEtHZ0xzwyZDJoRrrVrc1dw5eFNMVw0gI2Qc9bJPTSjP3HqjCEZ0aW3TIjWLFtuTmTAnpfNY7YYhReVbzUAZVOSP6hCLPL3EfNkj2EPCaCi8qWlEjN3iraBgFLqhBTGyQVxo0n2m7EvsjPv7IyA6VMhCRQDpnqqMdxXKgKvwwBarPc+EkQhKGruRuk1caz/+750NSxBKmXnDNrgBr62+sViGpMYoCKv9Qh07NNIdIhQueIh7eY1YL1CPe4N/KOvMT+I6JuAzMqSm9A2tpxCc4np6YgurQHLJlVGQ0MMwZcC/KI2VNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qwdnminbkQZXi1p9NBXM+aqGXEix2fZ2hucwpwCOb3s=;
 b=0GAsY2kINXx1LL436LNVOe7Nl1bGNnta4Wgi/nTeY+GjGkXdbJXT+6hBHcrmGptNgP6OKdMyQ3IhpDj3HFPHEMP9WS3heQLBkDxbIEMhH8L+ZqGrRMQPprUOhSWGzRmc3Tf2ZvE9F2R4Rwak+9TGrNXkl/j4j912Ba60FwI3Egg=
Received: from CY5PR12MB6527.namprd12.prod.outlook.com (2603:10b6:930:30::13)
 by CY5PR12MB6600.namprd12.prod.outlook.com (2603:10b6:930:40::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Mon, 20 Jul
 2026 13:09:08 +0000
Received: from CY5PR12MB6527.namprd12.prod.outlook.com
 ([fe80::325b:6e02:14e4:9092]) by CY5PR12MB6527.namprd12.prod.outlook.com
 ([fe80::325b:6e02:14e4:9092%4]) with mapi id 15.21.0223.015; Mon, 20 Jul 2026
 13:09:08 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Lin, Wayne" <Wayne.Lin@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Wentland, Harry" <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)"
 <Sunpeng.Li@amd.com>, "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>, "Li,
 Roman" <Roman.Li@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>, "Chung,
 ChiaHsuan (Tom)" <ChiaHsuan.Chung@amd.com>, "Zuo, Jerry" <Jerry.Zuo@amd.com>, 
 "Wu, Ray" <Ray.Wu@amd.com>, "LIPSKI, IVAN" <IVAN.LIPSKI@amd.com>, "Hung,
 Alex" <Alex.Hung@amd.com>, "Lin, Ping Lei" <PingLei.Lin@amd.com>, "Chen,
 Chen-Yu" <Chen-Yu.Chen@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>
Subject: RE: [PATCH 00/70] DC Patches July 13, 2026
Thread-Topic: [PATCH 00/70] DC Patches July 13, 2026
Thread-Index: AQHdFGAYvys5KSGE00ipNmMpIJKlu7Z2aJGQ
Date: Mon, 20 Jul 2026 13:09:07 +0000
Message-ID: <CY5PR12MB6527526246BDFDA31136E3AC9CC32@CY5PR12MB6527.namprd12.prod.outlook.com>
References: <20260715134432.1975118-1-Wayne.Lin@amd.com>
In-Reply-To: <20260715134432.1975118-1-Wayne.Lin@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Enabled=True;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SetDate=2026-07-20T13:08:52.0000000Z;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Name=AMD Public
 v26; MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_ContentBits=3;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6527:EE_|CY5PR12MB6600:EE_
x-ms-office365-filtering-correlation-id: 77c1f42c-8c57-47a8-9aa6-08dee660150a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|3023799007|6133799003|10067099003|56012099006|11063799006|22082099003|18002099003|38070700021;
x-microsoft-antispam-message-info: lILPRYEvg+gAWDSTcrXBKRpk7uYanHoPFtSFlK7Jo/FxaV+TVENLox9i+Nsd9DkSnjJdfszzIuUDrErOaMdk+HMGSi7of+WQ3r2hgVGtg1jZJ1N9/D+GHdBNredbclvnwl0haqafX63E7bhu0i/c8tDPA/B65xVOoy186prMbDdqS2SW4nTbM2fOMPwC30mVUxtqfiN4z0c15LothhbHqMp9vY8CdrXzznCQK+VsIU5xV/wxe7GE5MuOHRAYlHmGk1n9l8glB95EoFWKOTNCw2KDr5SN5q591NXnEfM3frWc6QWHO81M2duIy8+2Nw0LKTvhCnKSQ3Quz4FiTCPQruR7yjl9keWKfDZE+JW3Tt5yB5NQW0LAUkYHTp5Wad46k/WCip2cZFPJEZkkvvSd7xNgwmzIo1SZznwwJ6MAYoCZNOavfrEgAIbXcblqDo9Ngy4bkok3nZkLXI9vE/O0juRCd3T/8kEcx+qGAhcbrw4wiFz7mIc7RFHOjrjzI7F+pof/G9kzIxJs6zDLrRU5Sd8BEX8YtB74eWCHcShf3YqY40t7qqxFNDfvAKPvClV0E3d1+wyNLxjNdNGM4iClvwep0PVD0Dq5JRh7ia7Nmlm8QYjsa6Jm8idTmwXhR5xqoDpBL+2n9ovydcQpUuN22hE9KoXc81wUtJ2W7Ptk/F8erOOEM85rOUkUYcEE76rXXqRQhLu8swfbeZtps2d3L9YfujNH/sDQYSW5xHXx/Fc=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6527.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(3023799007)(6133799003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Ul9g0cDiqYbwD5wK41oo7eLBr8rDiTOW9n2mD5r9Y+H3j/sBtAlyxVLXlE?=
 =?iso-8859-1?Q?H2ax4qoWw2PB79fu2kPMXsHCTo+cSrtvdgGDhsLy5yuifGAMsA8+siiafV?=
 =?iso-8859-1?Q?8e7qRYkZAzwGARpQWBeLlEZdjm1PGhx8FL2c9zkjI3JQ162oEVjPG+Giwi?=
 =?iso-8859-1?Q?4KEKR/P7s2joCH6cv+Eoi+zVDArlnlSHRHDeEoCFOXGhX6yAD9IdTFb2FI?=
 =?iso-8859-1?Q?IQXSQuKohOV7XPaXfLcotOSY8PjBIiMhY2p2ehnmIeQWr25uMhKRnLqlIA?=
 =?iso-8859-1?Q?WV4MUU8zUQfmxlb4dL6flWSVxr51c2RiBnUOzbV0w82pHYcUzF0I1wi3MY?=
 =?iso-8859-1?Q?efiOCHN+ZbSCq5DCszFu40CEtYY/yfR2JqaaVWaBTdlEMSA6pQhfiXe4lL?=
 =?iso-8859-1?Q?0Hp7Wg18JboG8S3imq98jqnlmaPpnnmyqhwGDyseShgdNWVkr468RgvoSV?=
 =?iso-8859-1?Q?8a3lsnOYC/bOEFv8oCGpU9BKkUgye5BQlPxsE+8V25TWrosV/Zfu8uswQn?=
 =?iso-8859-1?Q?C7cTPtaJLPjmDlaDYwYhvRMz7TGJ4/KBkqPmKQYIo8hIkRNumIBLtRYMVG?=
 =?iso-8859-1?Q?osZatlaCgBwz4Nvk+0vZUPfIdwkqlJQMxoaxH9L5aivObLDiZkNsjZ496o?=
 =?iso-8859-1?Q?cOzyNo34AKTKLaAjHVVvCZgaudmxIpfyZ++ujzpeNlv03vajgS0g1WWtZ/?=
 =?iso-8859-1?Q?xIcVpEV2YGn0knCV92Kzg8X9g0dh3GQf6bAvhf9p+uTybgtSK12Bhr9N56?=
 =?iso-8859-1?Q?kLmeXk91yH7RGmCCHI8SP/DUpvX1/EJTn5PGOsCzT9/p4ISD3qlCsmCrbi?=
 =?iso-8859-1?Q?E7etDzQC/myLtm/0PmjW7DdTawMrdeNdT+mOp7TbrN8LDFGOL/4thRYEyj?=
 =?iso-8859-1?Q?oPbLj+jXs+d7rGee2eNNl8lR+lTx/2LyeKyV4v+ljHQUPXAMrXx6nIWn/E?=
 =?iso-8859-1?Q?micw2mL3JM0sfuokBVlQDMtNWXqb2tkPA+ORUYKxtemw1nXwB0pSQes8w1?=
 =?iso-8859-1?Q?neivdurnBjJeRsOYaxzCLtPek+d+cUJRtUbHB/FSdx3NKTZ9lk7sXEiI42?=
 =?iso-8859-1?Q?YnRVlc8Tb14aLg1ZHQFRexOlJ3nIM+bEXy0SIeUgfy+gm1IfTxHymSPGwr?=
 =?iso-8859-1?Q?oH31LWV0dYRwPvIUXt9QSiNXBfITgPNxnrerFlvklYqfTtnfmFeZzEOlTc?=
 =?iso-8859-1?Q?AieCABr/xzgFmtimnd9AWrjmmxWFiNWWMmLXq3yFc3xKoKevGobMHKUyKK?=
 =?iso-8859-1?Q?oSqzBxyvFhKkhHHr7M5gNA9kgZWn9Rpj+2sh3X8+5SMVb1Y+rMvMo/Bx+M?=
 =?iso-8859-1?Q?nh1usLiFlJwoo5lOz7INJXvw+wv/aCI5KYKGzfFwVptD+H2sL5gtnz3YGP?=
 =?iso-8859-1?Q?sOQzMqtSuDUC9nGGVKSPmAs6omAQFZcUYPeeMoR1+XUfyeQ0hCkhtZ8T8K?=
 =?iso-8859-1?Q?zH7x0/PQy1zFHMhTiWssVRuSMUJ8A5nMbhm3KEtKmMclLVOgr501Wk7ddy?=
 =?iso-8859-1?Q?aAnbbmxOFaEiIDoMVDNJe7EzJsu7CZBEkqKCzYO3an7eG9dN25xpTEV6vw?=
 =?iso-8859-1?Q?cTTvkTlobdmM5m6a7JK5R3MQ/OIjFVtJjWfOMhuQp0FDYFqOYZJaWMNaDJ?=
 =?iso-8859-1?Q?B790t/ryBOjHp2vL2Ks5L7bMggcWjxgIzWYsRmo2m6lZ2zRnVnohplHYKs?=
 =?iso-8859-1?Q?+3y5beH3kVLgNT21L5e7lvkXRypPQfU9fQurm4wiypNOwtwzyic6Ui6Mi3?=
 =?iso-8859-1?Q?UzrbHTZYFvNHHPPUfXXpDG7Y2a5/PgJ9Xunh3CHgy4+gU7?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6527.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77c1f42c-8c57-47a8-9aa6-08dee660150a
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2026 13:09:07.6945 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fRe7wKUrn82aT92ZnnqGkBQ6qSxtTKZSET4tiYN09by2WtH65yzK4ot7d8S2BdiiZp5JMU8zP1nJtnfbKIUOmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6600
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


The patchset consists of the amd-staging-drm-next branch (Head commit - 5b6=
18c86e32058864f039598aa1760c45649a7f0 -> drm/amd/display: Check dc_link bef=
ore applying DSC policy) with new patches added on top of it.

Tested on Ubuntu 24.04.4, on Gnome Wayland.

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
From: Wayne Lin <Wayne.Lin@amd.com>
Sent: Wednesday, July 15, 2026 9:37 AM
To: amd-gfx@lists.freedesktop.org
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.L=
i@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>; Li, Roman <Roman.=
Li@amd.com>; Lin, Wayne <Wayne.Lin@amd.com>; Chung, ChiaHsuan (Tom) <ChiaHs=
uan.Chung@amd.com>; Zuo, Jerry <Jerry.Zuo@amd.com>; Wheeler, Daniel <Daniel=
.Wheeler@amd.com>; Wu, Ray <Ray.Wu@amd.com>; LIPSKI, IVAN <IVAN.LIPSKI@amd.=
com>; Hung, Alex <Alex.Hung@amd.com>; Lin, Ping Lei <PingLei.Lin@amd.com>; =
Chen, Chen-Yu <Chen-Yu.Chen@amd.com>; Lin, Wayne <Wayne.Lin@amd.com>
Subject: [PATCH 00/70] DC Patches July 13, 2026

This DC patchset brings improvements in multiple areas. In summary, we have=
:

* Unified dc_update_state commit interface with dc_probe model,
  dc_state_get_status, and perfmon BLS sequence
* DCN42 enhancements including mcache programming, PMFW DF C-state client,
  and DCCG clocking fix
* DML2.1 writeback validation plus MCIF ARB and watermark/latency updates
* Color management refactor to dc_plane_cm with plane/CRTC colorop test cov=
erage
* Greatly enhanced KUnit coverage across amdgpu_dm, connector, CRC, DMUB, a=
nd
  color management
* HDMI AV mute timing, DP link training logging, and Apple Studio Display f=
ixes
* Code cleanup including DCE trim from DCN-only builds and HWSS refactors
* SPL UPSP upsampling and YUV422/YUV444 scaling support
* Fix missing dc_3dlut forward declaration in color management KUnit header=
s
* Fix DM IRQ schedule-work KUnit tests after cancel_work_sync teardown chan=
ge

---
Alex Hung (26):
  drm/amd/display: add dm_dmub_hw_init KUnit coverage
  drm/amd/display: add dm_dmub_hw_resume KUnit coverage
  drm/amd/display: add fused IO KUnit coverage
  drm/amd/display: add DMUB command sync KUnit coverage
  drm/amd/display: add VBIOS bounding box KUnit test
  drm/amd/display: Test color mod init and 3D LUT size
  drm/amd/display: Test plane colorop helper walkers
  drm/amd/display: Test CRTC color management update
  drm/amd/display: Test plane color management update
  drm/amd/display: Test plane colorop pipeline update
  drm/amd/display: add KUnit tests for DM IP-block callbacks
  drm/amd/display: add KUnit tests for DM CRTC vblank/scanout
  drm/amd/display: add KUnit tests for DM atomic state helpers
  drm/amd/display: add KUnit tests for DM stream scaling
  drm/amd/display: add KUnit tests for HDCP state diffing
  drm/amd/display: add KUnit tests for freesync config
  drm/amd/display: add KUnit tests for per-frame master sync
  drm/amd/display: add KUnit tests for stutter quirk
  drm/amd/display: add KUnit tests for DPCD poweroff delay
  drm/amd/display: add CRC source list KUnit coverage
  drm/amd/display: add CRC source verify KUnit coverage
  drm/amd/display: add CRC configure KUnit coverage
  drm/amd/display: add CRC set-source KUnit coverage
  drm/amd/display: add CRC IRQ handler KUnit coverage
  drm/amd/display: Fix missing dc_3dlut forward declaration
  drm/amd/display: Flush IRQ workqueue in schedule-work tests

Aurabindo Pillai (2):
  drm/amd/display: Adjust the structure dml2_dchub_watermark_regs
  drm/amd/display: Adjust structure dml2_display_dlg_regs

Austin Zheng (1):
  drm/amd/display: Add Writeback Watermarks and Latency Fields

Bhawanpreet Lakha (11):
  drm/amd/display: Replace amdgpu_dm_kunit_helpers.h with dm_helpers.h
  drm/amd/display: Add stream creation tests for connector
  drm/amd/display: Add detect and poll tests for connector
  drm/amd/display: Add register and unregister tests for connector
  drm/amd/display: Add destroy tests for connector
  drm/amd/display: Add encoder helper tests for connector
  drm/amd/display: Add EDID management tests for connector
  drm/amd/display: Add mode helper tests for connector
  drm/amd/display: Add i2c and EDID parsing tests for connector
  drm/amd/display: Add mode validation and CEC tests for connector
  drm/amd/display: Add stream validation tests for connector

Clara Wong (1):
  drm/amd/display: Reduce DML reinitialization when params don't change

Dillon Varone (4):
  drm/amd/display: Correct pipe usage for populating stream config
  drm/amd/display: Add MCIF ARB programming structures
  drm/amd/display: Add updated MCIF ARB register definitions
  drm/amd/display: Add DWB validation support to DML2.1 wrapper

Dominik Kaszewski (1):
  drm/amd/display: Split DPMS ON into parts

Dyllan Kobal (1):
  drm/amd/display: fix wrong register field in
    dccg35_set_hdmistreamclk_src_new

Gaghik Khachatrian (1):
  drm/amd/display: Trim DCE from DCN-only builds

Gleb Markov (1):
  drm/amd/display: Remove unused-but-set variable hubp from

Ilya Bakoulin (1):
  drm/amd/display: Fix DP LT failure logging

Jerry Zuo (1):
  drm/amd/display: hide Apple Studio Display secondary tile

Justin Chen (1):
  drm/amd/display: Revert Fix DMSS not triggering for HDR to SDR
    transition

Leo Chen (1):
  drm/amd/display: Register DCN as a PMFW DF C-state client on DCN42

Matthew Stewart (1):
  drm/amd/display: Add DCHUBBUB_HW_DEBUG offset/mask

Pengpeng Hou (1):
  drm/amd/display: wire DCN42B mcache programming callback

Ray Wu (1):
  drm/amd/display: Increase HDMI AV mute wait from 2 to 3 frames

Robin Chen (1):
  drm/amd/display: fix debug flags assignment in dmub_replay.c

Taimur Hassan (1):
  drm/amd/display: Promote DC to 3.2.390

Tomasz Siemek (3):
  drm/amd/display: Drop CONFIG_DRM_AMD_DC_DCN4_2 from 3dlut code
  drm/amd/display: Refactor DPP_PROGRAM_GAMUT_REMAP to drop pipe_ctx
    param
  drm/amd/display: Refactor DPP_SET_OUTPUT_TRANSFER_FUNC to drop
    pipe_ctx

Wayne Lin (1):
  drm/amd/display: Add SPL UPSP upsampling and YUV422 scaling support

WenTao Liang (1):
  drm/amd/display: set new_stream to NULL after release

Wenjing Liu (7):
  drm/amd/display: Introduce dc_probe public object model
  drm/amd/display: Introduce dc_update_state unified commit interface
  drm/amd/display: Refactor dc_validation_set array into single root
    struct
  drm/amd/display: Introduce dc_state_get_status unified status accessor
  drm/amd/display: Introduce program_perfmon hwss hook and BLS perfmon
    sequence
  drm/amd/display: Wire probe commit path into dc_update_state
  drm/amd/display: Make dc_state_update const in commit path

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   85 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   33 +
 .../amd/display/amdgpu_dm/amdgpu_dm_audio.c   |    2 +-
 .../display/amdgpu_dm/amdgpu_dm_backlight.c   |    2 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_color.c   |   16 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_color.h   |   12 +
 .../amd/display/amdgpu_dm/amdgpu_dm_colorop.c |    2 +-
 .../display/amdgpu_dm/amdgpu_dm_connector.c   |  117 +-
 .../display/amdgpu_dm/amdgpu_dm_connector.h   |   45 +
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c |    7 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    |    2 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_dmub.c    |   11 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_dmub.h    |    9 +
 .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.c    |    1 -
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |   12 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c |    2 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c |    2 +-
 .../amdgpu_dm/amdgpu_dm_kunit_helpers.h       |   20 -
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |    1 -
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   |    2 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c  |    2 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c |    2 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_quirks.c  |    2 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_replay.c  |    2 +-
 .../display/amdgpu_dm/amdgpu_dm_services.c    |    2 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c  |    2 +-
 .../amdgpu_dm/tests/amdgpu_dm_color_test.c    |  799 +++++++
 .../tests/amdgpu_dm_connector_test.c          | 1541 +++++++++++++
 .../amdgpu_dm/tests/amdgpu_dm_crc_test.c      |  728 ++++++
 .../amdgpu_dm/tests/amdgpu_dm_dmub_test.c     |  837 +++++++
 .../amdgpu_dm/tests/amdgpu_dm_irq_test.c      |   31 +-
 .../display/amdgpu_dm/tests/amdgpu_dm_test.c  | 1220 ++++++++++
 .../display/dc/bios/bios_parser_interface.c   |    2 +
 .../display/dc/bios/command_table_helper.c    |    2 +
 .../display/dc/bios/command_table_helper.h    |    2 +
 .../display/dc/bios/command_table_helper2.c   |    2 +
 .../display/dc/bios/command_table_helper2.h   |    4 +-
 .../dc/bios/command_table_helper_struct.h     |    2 +
 .../dc/bios/dcn10/command_table_helper2_dcn.c |  293 +++
 .../dc/bios/dcn10/command_table_helper2_dcn.h |   34 +
 .../gpu/drm/amd/display/dc/clk_mgr/Makefile   |    2 +-
 .../gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c  |    4 +
 .../display/dc/clk_mgr/dcn10/dcn10_clk_mgr.c  |  203 ++
 .../display/dc/clk_mgr/dcn10/dcn10_clk_mgr.h  |   43 +
 .../display/dc/clk_mgr/dcn10/rv1_clk_mgr.c    |    9 +-
 .../display/dc/clk_mgr/dcn10/rv2_clk_mgr.c    |    6 +-
 .../display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c  |   12 +-
 .../dc/clk_mgr/dcn201/dcn201_clk_mgr.c        |    6 +-
 .../amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c |    6 +-
 .../display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c  |    8 +-
 .../display/dc/clk_mgr/dcn301/vg_clk_mgr.c    |    8 +-
 .../display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c  |   10 +-
 .../dc/clk_mgr/dcn314/dcn314_clk_mgr.c        |   10 +-
 .../dc/clk_mgr/dcn315/dcn315_clk_mgr.c        |   10 +-
 .../dc/clk_mgr/dcn316/dcn316_clk_mgr.c        |   10 +-
 .../display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c  |   18 +-
 .../display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c  |   12 +-
 .../dc/clk_mgr/dcn401/dcn401_clk_mgr.c        |   18 +-
 .../display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c  |   42 +-
 .../display/dc/clk_mgr/dcn42/dcn42_clk_mgr.h  |    1 +
 .../amd/display/dc/clk_mgr/dcn42/dcn42_smu.c  |   29 +-
 .../amd/display/dc/clk_mgr/dcn42/dcn42_smu.h  |    2 +
 .../dc/clk_mgr/dcn42b/dcn42b_clk_mgr.c        |   10 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  471 ++--
 .../drm/amd/display/dc/core/dc_hw_sequencer.c |  424 +++-  .../gpu/drm/amd=
/display/dc/core/dc_resource.c |  176 +-
 drivers/gpu/drm/amd/display/dc/core/dc_sink.c |    3 +
 .../gpu/drm/amd/display/dc/core/dc_state.c    |   72 +-
 .../gpu/drm/amd/display/dc/core/dc_stream.c   |   24 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |  217 +-
 drivers/gpu/drm/amd/display/dc/dc_probe.h     |   97 +
 drivers/gpu/drm/amd/display/dc/dc_state.h     |    7 +
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |   30 +-
 drivers/gpu/drm/amd/display/dc/dc_types.h     |    9 +-
 .../amd/display/dc/dccg/dcn35/dcn35_dccg.c    |    2 +-
 .../gpu/drm/amd/display/dc/dce/dmub_replay.c  |    2 +-
 .../dc/dcn10/dcn10_hw_sequencer_debug.c       |    2 +-
 drivers/gpu/drm/amd/display/dc/dm_helpers.h   |   11 +
 .../dml2_0/dml21/dml21_translation_helper.c   |   84 +-
 .../amd/display/dc/dml2_0/dml21/dml21_utils.c |   17 +
 .../amd/display/dc/dml2_0/dml21/dml21_utils.h |    5 +
 .../dc/dml2_0/dml21/dml21_wrapper_fpu.c       |   27 +-
 .../dml21/inc/dml_top_dchub_registers.h       |   30 +
 .../dc/dml2_0/dml21/inc/dml_top_types.h       |    5 +
 .../dml21/src/dml2_core/dml2_core_dcn4.c      |   34 +-
 .../src/dml2_core/dml2_core_dcn4_calcs.c      |   71 +-
 .../src/dml2_core/dml2_core_dcn4_calcs.h      |    2 +
 .../src/dml2_core/dml2_core_shared_types.h    |    2 +
 .../dml21/src/dml2_dpmm/dml2_dpmm_dcn4.c      |   21 +
 .../gpu/drm/amd/display/dc/gpio/hw_factory.c  |    4 +
 .../drm/amd/display/dc/gpio/hw_translate.c    |    4 +
 .../display/dc/hubbub/dcn35/dcn35_hubbub.h    |    7 +-
 .../amd/display/dc/hubp/dcn10/dcn10_hubp.c    |    3 +-
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c |   32 +-
 .../amd/display/dc/hwss/dce110/dce110_hwseq.h |    3 +
 .../amd/display/dc/hwss/dce60/dce60_hwseq.c   |    2 +-
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   | 1989 ++++++++++++++++-
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.h   |   71 +-
 .../amd/display/dc/hwss/dcn10/dcn10_init.c    |   44 +-
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   |   22 +-
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.h   |    3 +-
 .../amd/display/dc/hwss/dcn20/dcn20_init.c    |   42 +-
 .../amd/display/dc/hwss/dcn201/dcn201_init.c  |   44 +-
 .../amd/display/dc/hwss/dcn21/dcn21_hwseq.c   |    8 +-
 .../amd/display/dc/hwss/dcn21/dcn21_init.c    |   36 +-
 .../amd/display/dc/hwss/dcn30/dcn30_hwseq.c   |   71 +-
 .../amd/display/dc/hwss/dcn30/dcn30_hwseq.h   |    6 +-
 .../amd/display/dc/hwss/dcn30/dcn30_init.c    |   34 +-
 .../amd/display/dc/hwss/dcn301/dcn301_init.c  |   32 +-
 .../amd/display/dc/hwss/dcn31/dcn31_hwseq.c   |   21 +-
 .../amd/display/dc/hwss/dcn31/dcn31_init.c    |   34 +-
 .../amd/display/dc/hwss/dcn314/dcn314_init.c  |   32 +-
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.c   |   31 +-
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.h   |    8 +-
 .../amd/display/dc/hwss/dcn32/dcn32_init.c    |   34 +-
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   |    7 +-
 .../amd/display/dc/hwss/dcn35/dcn35_init.c    |   32 +-
 .../amd/display/dc/hwss/dcn351/dcn351_init.c  |   32 +-
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |   72 +-
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.h |    6 +-
 .../amd/display/dc/hwss/dcn401/dcn401_init.c  |   34 +-
 .../amd/display/dc/hwss/dcn42/dcn42_hwseq.c   |   17 +-
 .../amd/display/dc/hwss/dcn42/dcn42_init.c    |   34 +-
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |  214 +-
 .../display/dc/hwss/hw_sequencer_private.h    |    6 +-
 .../gpu/drm/amd/display/dc/inc/core_status.h  |   10 +
 .../gpu/drm/amd/display/dc/inc/core_types.h   |   53 +
 .../gpu/drm/amd/display/dc/inc/hw/clk_mgr.h   |   10 +
 .../gpu/drm/amd/display/dc/inc/hw/dchubbub.h  |   18 +-
 .../gpu/drm/amd/display/dc/inc/hw/mcif_wb.h   |   24 +-
 .../gpu/drm/amd/display/dc/inc/link_service.h |    4 +-
 drivers/gpu/drm/amd/display/dc/inc/resource.h |    7 +-
 .../gpu/drm/amd/display/dc/irq/irq_service.c  |   31 +
 .../gpu/drm/amd/display/dc/irq/irq_service.h  |    9 +
 .../gpu/drm/amd/display/dc/link/link_dpms.c   |  184 +-
 .../gpu/drm/amd/display/dc/link/link_dpms.h   |    4 +-
 .../dc/link/protocols/link_dp_training.c      |   28 +-
 drivers/gpu/drm/amd/display/dc/os_types.h     |   10 +
 .../dc/resource/dce100/dce100_resource.h      |    1 -
 .../dc/resource/dce112/dce112_resource.h      |    7 -
 .../dc/resource/dcn10/dcn10_resource.c        |    2 +-
 .../dc/resource/dcn20/dcn20_resource.c        |    2 +-
 .../dc/resource/dcn201/dcn201_resource.c      |    2 +-
 .../dc/resource/dcn21/dcn21_resource.c        |    2 +-
 .../dc/resource/dcn30/dcn30_resource.c        |    2 +-
 .../dc/resource/dcn301/dcn301_resource.c      |    2 +-
 .../dc/resource/dcn31/dcn31_resource.c        |    4 +-
 .../dc/resource/dcn314/dcn314_resource.c      |    2 +-
 .../dc/resource/dcn315/dcn315_resource.c      |    2 +-
 .../dc/resource/dcn316/dcn316_resource.c      |    2 +-
 .../dc/resource/dcn32/dcn32_resource.c        |    2 +-
 .../dc/resource/dcn321/dcn321_resource.c      |    2 +-
 .../dc/resource/dcn35/dcn35_resource.c        |    2 +-
 .../dc/resource/dcn351/dcn351_resource.c      |    2 +-
 .../dc/resource/dcn36/dcn36_resource.c        |    2 +-
 .../dc/resource/dcn401/dcn401_resource.c      |    2 +-
 .../dc/resource/dcn42/dcn42_resource.c        |    2 +-
 .../dc/resource/dcn42b/dcn42b_resource.c      |    4 +-
 drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c  |  202 +-
 .../drm/amd/display/dc/sspl/dc_spl_types.h    |   58 +-
 .../amd/display/include/link_service_types.h  |    6 +-
 .../drm/amd/display/modules/power/power_psr.c |    7 -
 .../amd/display/modules/power/power_replay.c  |    7 -
 163 files changed, 10920 insertions(+), 1087 deletions(-)  delete mode 100=
644 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_kunit_helpers.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/bios/dcn10/command_table=
_helper2_dcn.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/bios/dcn10/command_table=
_helper2_dcn.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/dcn10_clk_=
mgr.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/dcn10_clk_=
mgr.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dc_probe.h

--
2.43.0

