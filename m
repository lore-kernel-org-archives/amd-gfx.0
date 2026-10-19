Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B75CCCF2DE
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Oct 2026 13:03:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9516B10ECF2;
	Mon, 19 Oct 2026 13:02:54 +0000 (UTC)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012052.outbound.protection.outlook.com [52.101.53.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FBE410ECF2
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Oct 2026 13:02:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UZSBuB0GGVwJIumT7V2dxYgqYLZQgFO9JBybtDc1/ijmBGMX3ZBNygGYSchrqruwRzxNfE5gTJcZXvg6hLPhY6ufS5PZBjDZtLtLTewlpI0Tu+DYU5jzv3wkQ8oCEYau665qvAb0TSJ/RbW6+g6HEiu+pcab3HQaUSZJj3SO5JWn1X0Lsx+PpVZRcHSC/Tcu7deB0SyVos78lCuQIVbItkzgsFFqPRa7HezKUTBs8kzzygs8MxtztswcfH26jd4MhJIh4IDYwYhwj1EiYdwMS4ftfTGdYc2IiDBRUoiZIn9TvYzN3me7UHlMjEgfTMth7I0LIMYLqRVRebBCKmmuPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O4EWI1u20nd/NB9M2affbJZ5gQLJndkKGwyaiSnK7F8=;
 b=TgLdCT8DjC9V+qFg3oC5ytxxCuddX39WfH0SaqB8foTJ55dTWftINleLbTdL9523ZVUXJZcs9lYU+20XLnPhZW6zqfgU07jRiRb/lHGO2Kj30p50rDlwmY9ZzmK69t19ULfep1gyTBiqynRUIxPCYRcLayKAo3gZBGpQaZ+wMLD62SkyLN/HJfw4WKUhiaoVKFKozxNB3OsTBNo2lJW1jsmJplI+fTW5xgVAIRrLE1eIBk0pc9fxODL80NDoyLTUzMjOl+r43s3xSBpqECJl7yf73oUToJh1WHWH3HrZL6nDquTVJi4VlffN+Tb72qIFfb8ea9B7Aq7xCbaranvjjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O4EWI1u20nd/NB9M2affbJZ5gQLJndkKGwyaiSnK7F8=;
 b=ZxZqhNMTzCNnnxQtjDpDYfeb6CbemwRDNIrpUOwcizHi7ErVgRGjf6l8HXIMOa1yg9lhlE9GqKhXprymjquQJmuA4MNixHjZpQfADC5S/9dzY8+Wjz75va7jLHF+CR/iTZorsi+kklxlm5W4JmeGPb91/9Cs2gdRbTXRNngQN5E=
Received: from DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) by
 DS4PR12MB9684.namprd12.prod.outlook.com (2603:10b6:8:281::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.19; Mon, 19 Oct 2026 13:02:43 +0000
Received: from DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::b2e1:64e5:3b9e:738a]) by DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::b2e1:64e5:3b9e:738a%4]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 13:02:43 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Wu, Ray" <Ray.Wu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Wentland, Harry" <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)"
 <Sunpeng.Li@amd.com>, "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>, "Li,
 Roman" <Roman.Li@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>, "Chung,
 ChiaHsuan (Tom)" <ChiaHsuan.Chung@amd.com>, "Zuo, Jerry" <Jerry.Zuo@amd.com>, 
 "Wu, Ray" <Ray.Wu@amd.com>, "LIPSKI, IVAN" <IVAN.LIPSKI@amd.com>, "Hung,
 Alex" <Alex.Hung@amd.com>, "Lin, Ping Lei" <PingLei.Lin@amd.com>, "Chen,
 Chen-Yu" <Chen-Yu.Chen@amd.com>, "Wu, Ray" <Ray.Wu@amd.com>
Subject: RE: [PATCH 00/30] DC Patches October 19, 2026
Thread-Topic: [PATCH 00/30] DC Patches October 19, 2026
Thread-Index: AQHdWwQ/0ZjkezcTUEOP5ctvbcLitrcE3gpg
Date: Mon, 19 Oct 2026 13:02:42 +0000
Message-ID: <DS0PR12MB653475AD272FC1A21FCA6AE09C982@DS0PR12MB6534.namprd12.prod.outlook.com>
References: <20261013111616.2267344-1-ray.wu@amd.com>
In-Reply-To: <20261013111616.2267344-1-ray.wu@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Enabled=True;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SetDate=2026-10-19T13:02:37.0000000Z;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Name=AMD Public
 v26; MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_ContentBits=3;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Method=Privileged
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6534:EE_|DS4PR12MB9684:EE_
x-ms-office365-filtering-correlation-id: 54255d67-b9df-49bf-770e-08df2de1435b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|261009223027099003|10067099003|56012099006|3023799007|6133799003|22082099003|18002099003|11063799006|38070700021;
x-microsoft-antispam-message-info: Ji7qaA5rjsDRVn0rk+XWb8Um26dPMReGXOmikiz5tQr6hPZIVSre2JDY14qevAGEh6gr2i9bWofFGSpcyn7Bsn93g6nUExR2VaL6o7gpQK2sJSAI6YsSJoKMGfoX+IpmC1A8gRwOzJQrMqt3qgm6Tv0a7KQGL3UQFu2HDvgs4Hjynct38M4Pg9M3a/Zr35y5j+bvAvGlfPPdGApxtl/reknXgIx1joLaEA0sMm72vCMavuVDZnGkdt/I3Ij4UWkhLYf0Aoull3qXM7NxBtarex6QgtKW3ABm04M3RT21sgeRqAx2uz05NER5ZR9GdYmkg7GCkxzE4LuFVQiNE89pi3xgCEuCDsggBsgMTBKNaJ2arP5fuqLaNDODvZOCgyY7HuuZbpyY9ms7gpgtM+CceAnYWeQN3+bFWalBKCaflNnJ4CY6TZMnZoh6D8myVwbJcsIjLtDaX58bBOQ2qCyEaTQzt9cQIS8EPBmPO9CSikEsRKkb8Jo7qML4bUOiohEMo8xjo/erbkjyWElIgh7zZgBgjd+SVf0j/4uWMtmlKgtcdN2R4EVQasu59p5jWqTHYsWteVEjbYaPJG0+Qy5StIXpewrSwSeM0AGYjU8bEPjs0u/+iR00pCo0XU2RopxU/9ostjr0oV/6Ns5AS8tyV98hrunskVFWPQVwaSZeA8jrWl06XlizmmR0+mixwcViI+Qgomnhr9uyh4sJudt7uLV35sJxjN3wmrNObABWMMU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6534.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(261009223027099003)(10067099003)(56012099006)(3023799007)(6133799003)(22082099003)(18002099003)(11063799006)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?shjqyTv0CNEkN+3TcOBVuSwWHmREVkH6RH8lxB5vSaBZjnsHjIrB4o199u?=
 =?iso-8859-1?Q?iB+pG8pFPFvkTY0IwhzWaIJZP9xfZRb3VoGuEMqlonIB1E+8cdVuPxIyDZ?=
 =?iso-8859-1?Q?oUeJL6NZv0YLlxFqqy2e9hyOM9+r+OOCF8SmlW7qnMWhn33eo5wXnaIqRv?=
 =?iso-8859-1?Q?nC6Z4rbNvDwY0KGxE41euKcIUjCdbA2Uj6FDZ4qn5M1ZPK28PrE49G/MS5?=
 =?iso-8859-1?Q?0sDnMe7Tt6TPS127cr7U8reJQYEcEQdcgW6ePsnQN2wRZJB7C1Nfk/IDqU?=
 =?iso-8859-1?Q?a6dlA3OpH9fJtwpr5OEoNdK0eo1/u57D3pm+jtSQhIXoqLgR34OGiQ+cj/?=
 =?iso-8859-1?Q?iAKjj5TfQKtSDTyn8ScvXspYnr/JgnCWZhdr2uvPbpZq+9/JGfVfGjLEpf?=
 =?iso-8859-1?Q?KyDGgq5/zH/RLb695PvoWbq6ukM/J1/yV7wRaokqq12oUBR1dmOyvxDAyX?=
 =?iso-8859-1?Q?XiWt1d9H58C2Tyb3LPGHs6kiU2SVp9/Csyoqfx+k2YlrcnOmAnMEjGjFNm?=
 =?iso-8859-1?Q?02Jd8ItZqH4uTKTOkjvdr826DeHMX6kzZXAy32WKwTeBKBTmVmxrhmOuxi?=
 =?iso-8859-1?Q?3ORjN8N6hShaLWnBV6f/WTs6hn/L99zZfVe9Gy0c0jwnd1BSciOTF7ufxm?=
 =?iso-8859-1?Q?LvprE+58pmx7XSsAoZBoLPar9CA6XkOuyKLUWibiWLdlhjZhE2DsSa6St6?=
 =?iso-8859-1?Q?+bijOhbL4PZUyluqVwT4FbYRy1RKAKzFbWi38Ufr3Qn4V74wRadqhpVSri?=
 =?iso-8859-1?Q?GnelDRnQiYJVyZSPCokfc8/Sg2qpM1ofqxhfiWdu1L1m6Ku/X6ygGayN2I?=
 =?iso-8859-1?Q?qMxvT7Dz2Rp7jsIF4JElpL+TkF3gfMvmB3jxnKOqjgxcBN3hOZxk2iB91E?=
 =?iso-8859-1?Q?vpSju7kEEBAvXF0ZOmPGsBHLPx1wvB3Y2RuaeolHqqXpAP/H/sInI7FzVa?=
 =?iso-8859-1?Q?t4tc8Kcz5QwOLmWvgBFnJ+4iAwJGdpNggv35kKypsn2awP8myemSNL8IxJ?=
 =?iso-8859-1?Q?dMEZhqX05jS9P+65U1SHDIAOwDKvAanv1f2AZNyGZjKDEN8aLRH2fx9HoW?=
 =?iso-8859-1?Q?VIxw6uzEwPrFXxwgvV05W6fdql0OoEdtr+4v18u+wZ+GHbAUQzKpO6fs6V?=
 =?iso-8859-1?Q?DfYBydJD6e2wWGGcXIjNGq0SWkvRWuHuqDh+ilmpf0IVuesTajuHkgP/n7?=
 =?iso-8859-1?Q?eT0cv6vm1ZEm1h3lfhgLhocMwgPwnhTZvV0OyOxw3GOkrBEj0S+KSoimbA?=
 =?iso-8859-1?Q?ToFbA0SsSnzAcOZdVwg9IezcUkLGRzYw1otnI2IzWk8BPe0hcSq/6qGsyl?=
 =?iso-8859-1?Q?NqaAD+b31olFkYqr/dp2PuXSUBUIYghhBHTTcyTRNWg/Eo2Dfg9n5bB2Iz?=
 =?iso-8859-1?Q?JKh8YMghgwqFZc1cblpebvT9cP+I5JaeVw0A0Zv0rcbAMo0bZL1HwPMwI8?=
 =?iso-8859-1?Q?Qsku7wT+Q/nnR3jTvyeI9Vz0zcw1mwa2s7dXmDl8TLGeHS26EbfQBy7FLs?=
 =?iso-8859-1?Q?5y6jjbNEetp5f8RVrFBJtx9p6f9IJwjiLy4tPIOS70Jp8DDSWIYPBJkXbM?=
 =?iso-8859-1?Q?qxpavoPRxqjQQFM+8bSy6rIslMTieBOG6fvKwh/ytrncZ3cvoWIdGBzcug?=
 =?iso-8859-1?Q?0EE3geGzIcm9cPpebwRt+r3MiNJohbdljbdrq1hAaFioQwfiAoKRHzgWk6?=
 =?iso-8859-1?Q?0xoIQY4B1BNuWD7NiAkM2lvIop4QsZiwIfc+Gvsxh6epW2L+7mGsw0YZyW?=
 =?iso-8859-1?Q?7aUUqDYtQS3/DwfXgV4RaJju+dPrRkIB+exOnhcIhghyYg?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54255d67-b9df-49bf-770e-08df2de1435b
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2026 13:02:43.0407 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W/nAscYWRZDVbxgy4CdAfyw7dIQwWxbRpo7sBQ95CEkJP0xg8mSaDb3Kld+f7W0G4Wad4WrUPJh9im4229t5zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9684
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


The patchset consists of the amd-staging-drm-next branch (Head commit -> e0=
57322aedb24072dc6c7f531b1bbbaa0497c31b -> drm/amd/ras: report the bad page =
threshold in every work mode) with new patches added on top of it.

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
From: Ray Wu <ray.wu@amd.com>
Sent: Tuesday, October 13, 2026 7:08 AM
To: amd-gfx@lists.freedesktop.org
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.L=
i@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>; Li, Roman <Roman.=
Li@amd.com>; Lin, Wayne <Wayne.Lin@amd.com>; Chung, ChiaHsuan (Tom) <ChiaHs=
uan.Chung@amd.com>; Zuo, Jerry <Jerry.Zuo@amd.com>; Wheeler, Daniel <Daniel=
.Wheeler@amd.com>; Wu, Ray <Ray.Wu@amd.com>; LIPSKI, IVAN <IVAN.LIPSKI@amd.=
com>; Hung, Alex <Alex.Hung@amd.com>; Lin, Ping Lei <PingLei.Lin@amd.com>; =
Chen, Chen-Yu <Chen-Yu.Chen@amd.com>; Wu, Ray <Ray.Wu@amd.com>
Subject: [PATCH 00/30] DC Patches October 19, 2026

This DC patchset brings improvements in multiple areas. In summary, we have=
:

- Fix HDMI FRL FFE compliance test and adjust FRL LT timeout.
- Align eDP DSC link policy to minimize lane count.
- Add AS-SDP V3 support for VESA Panel Replay.
- Add DPG force-on-flip support.
- Log PSR/Replay status and exit PSR/Replay on non-modeset full updates.
- Reject invalid per-mode FreeSync timing and set VRR_EN state.
- Align VRR timing gate with FreeSync module.
- Warn on unadvertised modes without scaling.
- Use DMUB to notify PME and update DMU cmd header.
- Do not allow vbios version of dmubfw in the driver.
- Use picoseconds for line time and correct next frame calculation.
- Fix YUV422 semi-planar color blurring and UPSP chroma upsampling.
- Reset UPSP and pre-CSC registers on DCN6 DPP reset.
- Handle exit LS in second ISHARP programming block.
- Remove hard-coded min dcfclk for AC.
- Do not WARN when removing an unallocated MST payload.
- Various cleanups, KUnit test fixes and debug flag gating.

Cc: Dan Wheeler <daniel.wheeler@amd.com>

Alvin Lee (3):
  drm/amd/display: Update DMU cmd header
  drm/amd/display: Use picoseconds for line time on DCN6+
  drm/amd/display: Correct next frame calculation

Aric Cyr (1):
  drm/amd/display: move timing_adjust_pending into dc_stream_state

Charlene Liu (3):
  drm/amd/display: use dmub to notify pme
  drm/amd/display: Do not allow vbios version of dmubfw in the driver
  drm/amd/display: remove hard code min dcfclk for AC.

Dillon Varone (1):
  drm/amd/display: set VRR_EN for inactive state

Fangzhi Zuo (4):
  drm/amd/display: Simplify hdmi_automation debugfs with
    debugfs_create_bool
  drm/amd/display: reject invalid per-mode FreeSync timing
  drm/amd/display: warn on unadvertised modes without scaling
  drm/amd/display: align VRR timing gate with FreeSync module

Ilya Bakoulin (2):
  drm/amd/display: Fix HDMI FRL FFE compliance test
  drm/amd/display: Adjust HDMI FRL LT timeout

Ivan Lipski (2):
  drm/amd/display: Remove unused has_vsdb variable
  drm/amd/display: fix NULL dc deref in hpd_init KUnit tests

Kaier Hsueh (1):
  drm/amd/display: YUV422 Semi-Planar Images Show Color Blurring at
    Color Boundaries

Leon Huang (1):
  drm/amd/display: Add AS-SDP V3 support for VESA PR

Mario Limonciello (1):
  drm/amd/display: don't WARN when removing an unallocated MST payload

Piotr Maziarz (1):
  drm/amd/display: Gate DP_TRACE_SOURCE_SEQUENCE emission on the debug
    flag

Ray Wu (3):
  drm/amd/display: Align eDP DSC link policy to minimize lane count
  drm/amd/display: Log PSR and Replay status after mode change
  drm/amd/display: Exit PSR/Replay on non-modeset full updates

Roman Li (1):
  drm/amd/display: guard DCE-only hwseq definitions

Samson Tam (2):
  drm/amd/display: handle exit LS in second ISHARP programming block
  drm/amd/display: handle UPSP chroma upsampling in DML

Sharique Pervaiz (1):
  drm/amd/display: Add DPG force-on-flip support for SystemDisplayEnable

Sridevi Arvindekar (1):
  drm/amd/display: Reset UPSP and pre-CSC registers on DCN6 DPP reset

Taimur Hassan (2):
  drm/amd/display: [FW Promotion] Release 0.1.80.0
  drm/amd/display: Promote DC to 3.2.403

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  61 ++++++---
 .../display/amdgpu_dm/amdgpu_dm_connector.c   |  44 +++---
 .../display/amdgpu_dm/amdgpu_dm_connector.h   |   2 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c |  69 +---------
 .../display/amdgpu_dm/amdgpu_dm_freesync.c    |  43 +++++-
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |   7 +-
 .../tests/amdgpu_dm_connector_test.c          |   8 +-
 .../amdgpu_dm/tests/amdgpu_dm_freesync_test.c |  55 +++++++-  .../amdgpu_d=
m/tests/amdgpu_dm_helpers_test.c  |  20 ++-
 .../amdgpu_dm/tests/amdgpu_dm_irq_test.c      |  48 ++++++-
 .../dc/clk_mgr/dcn42b/dcn42b_clk_mgr.c        |   2 -
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  55 ++++++--
 .../drm/amd/display/dc/core/dc_hw_sequencer.c |  12 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |   4 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |  17 +++  drivers/gpu/drm/a=
md/display/dc/dc_dmub_srv.h  |  11 ++
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h  |   3 +-
 .../gpu/drm/amd/display/dc/dc_hdmi_types.h    |   4 +-
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h  |   1 -
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |   3 +
 .../dml2_core_dcn6_funcs_mode_programming.c   |   4 +-
 .../dml2_core_dcn6_funcs_mode_support.c       |   3 +-
 .../alternate_pstate_shared_lib.c             |  11 +-
 .../amd/display/dc/dpp/dcn401/dcn401_dpp.h    |   8 +-
 .../display/dc/dpp/dcn401/dcn401_dpp_dscl.c   |  40 ++++--
 .../drm/amd/display/dc/dpp/dcn60/dcn60_dpp.c  |  17 ++-
 .../drm/amd/display/dc/dpp/dcn60/dcn60_dpp.h  |   1 +
 .../amd/display/dc/dpp/dcn60/dcn60_dpp_dscl.c |   7 +
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c |  55 ++++++--
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   |   7 +
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |  11 ++
 .../display/dc/link/hwss/link_hwss_hpo_frl.c  |   3 +
 .../gpu/drm/amd/display/dc/link/link_dpms.c   |   2 +
 .../display/dc/link/protocols/link_hdmi_frl.c | 129 +++++++++++++-----
 drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c  |   7 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  34 ++++-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn42.c |   7 +
 .../amd/display/modules/inc/mod_info_packet.h |   5 +
 .../display/modules/info_packet/info_packet.c |  38 +++++-
 39 files changed, 634 insertions(+), 224 deletions(-)

--
2.43.0

