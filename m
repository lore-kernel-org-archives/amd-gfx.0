Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4796EC982ED
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2026 13:19:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C4F2D10E78E;
	Mon, 21 Sep 2026 13:19:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hyfHIc5V";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010008.outbound.protection.outlook.com [52.101.46.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CEAF510E38D
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Sep 2026 13:19:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ax3aSDysdFaONyStdDnx5cwf7/36EFL4DQgPDBqW8e7Rw37DmTEHapvKK99nWXTN2MYzrHKejM+JTv9IhzpKgdiAuQ7wI8of5whxUcBV9MtNKFoZoJ1dllbI5Akj30R6PHw6F22o4f4cHJhEffJEB8o9M4pXs3Isi5BmOSgcNt75Ox/068c9aRmLvebNXj5FquU9SsWfEu0Lq6TtAA7NvYw+Fh58dA8Xbg8H75NapqLE3Uny5jeHWUC30/8ScyVyu03dYk+7/EfaOrc7SQGCWdpq5KihKSYMyuC4V1ogLCcYxeoudWsA0QSqtEZjOPlL9ZELyGNYSrYc0HQdRgjLIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nm/43yNysuXXSPgJPHFd9C/h54hGhJUh8jZondRqb8k=;
 b=iUlQpeR1rU9PCH2GaW1AJh6juB+50mQTSsvXt4JuC4EoRECZ/xcCNtEdQYLJLvnqGRmPMoinJqsd/P5H7q+PZCFBsa6gc+Hh0JMITGmm9OBRWHuFIPYipa5Sw6Gaw0V5A2ZIAetsQSD61sLh3wpt5iBKvDLBnutS8Ec4Qt5c3x1wrS6eqXKgjAKN0/BLK1n/YAUM4eVYU0XUWNDuzPvr2MbHk9GSlUr6BFE0lDQI2RzN+IJhrvwswehP6Z+Q4roK7jT0yFhyiBO8Aznw1Fa9kulst1ZwMSwXgfv267nQ9uIUtjKRb0I0ImKiQlxFZUa8hTaDNXgoJEKfpnFX+asHSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nm/43yNysuXXSPgJPHFd9C/h54hGhJUh8jZondRqb8k=;
 b=hyfHIc5VEUxLloyn3cDO6afg57n5HTrdC1vbm2sAlDjkYtsbrstIMS2ki7CZtMtQmp/1V1W2bJ2DmFGd5c7Lygvoq6dVnCjyMv8j03HwmSXwP5OaWCee5XPwq5jKkBnN8+6sAA0l8oE68wT/vVlxIbR3vP9QUge/WMYt5W46xqA=
Received: from DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) by
 DS5PPF5C5D42165.namprd12.prod.outlook.com (2603:10b6:f:fc00::64f)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 13:19:18 +0000
Received: from DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::b2e1:64e5:3b9e:738a]) by DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::b2e1:64e5:3b9e:738a%4]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 13:19:17 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Zhang, George" <George.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Wentland, Harry" <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)"
 <Sunpeng.Li@amd.com>, "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>, "Li,
 Roman" <Roman.Li@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>, "Chung,
 ChiaHsuan (Tom)" <ChiaHsuan.Chung@amd.com>, "Zuo, Jerry" <Jerry.Zuo@amd.com>, 
 "Wu, Ray" <Ray.Wu@amd.com>, "LIPSKI, IVAN" <IVAN.LIPSKI@amd.com>, "Hung,
 Alex" <Alex.Hung@amd.com>, "Lin, Ping Lei" <PingLei.Lin@amd.com>, "Chen,
 Chen-Yu" <Chen-Yu.Chen@amd.com>
Subject: RE: [PATCH 00/64] DC Patches for September 16, 2026
Thread-Topic: [PATCH 00/64] DC Patches for September 16, 2026
Thread-Index: AQHdRgQiT62P5i9SnE+2hmlZ44zgsLbZCj8A
Date: Mon, 21 Sep 2026 13:19:17 +0000
Message-ID: <DS0PR12MB6534D6F491DC5A36670EFA3E9C842@DS0PR12MB6534.namprd12.prod.outlook.com>
References: <20260916175301.368306-1-george.zhang@amd.com>
In-Reply-To: <20260916175301.368306-1-george.zhang@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Enabled=True;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SetDate=2026-09-21T13:15:22.0000000Z;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Name=AMD Public
 v26; MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_ContentBits=3;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6534:EE_|DS5PPF5C5D42165:EE_
x-ms-office365-filtering-correlation-id: 3658908f-c444-402e-65d3-08df17e2f0ab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|10067099003|3023799007|6133799003|18002099003|22082099003|56012099006|11063799006|38070700021;
x-microsoft-antispam-message-info: hfk3QmIcTTyeL6Npwi3N00Nnom3xeEfeQiEbbK1qjLXIN8hPTg+Keqy2rtmtISF/mHav86cQGtaqPAvaUe5P2iNrOch//9NhPGzW4NZRtcxA+Uuh7Uu8udvUfqhmlrRSbZQ0JigHQVivsFzJCSvL/dXWUURpfcR56DALwrd12wfDlybOIKhE4tLfC19MLbazCE6NGPtsRK+SG42VEG4qs/PBtqrJaGX01uLLzyMBu+ZloG1Xw/XUZn713eWsz1hMiXTsiM+FxiEUPglES18oB/lLtVNQXmh96I/FhiK2lQ0R58AHlhEYQtxpGHxWdXwEdK80T6g6LjWm5CIl2p9jmOBbJwubDAsPHTF0/ObLCgvnSMJ7kd149NR45UdwALkkIZTxfzNIHA5WEoLJXYZTFX/AmuI6eGlm+/kGnR4UF2zkb77YYHclW8/jpZDRnWGLdnh4zgFwchQbjsiN0Qex1EPAqGeCGzbNQyxVJUFvQxtBxgtQGvaWcmPwP6ypTTlmpBFyly2OCHtagZ4RqYkVHU2VSwuz+qdSKwkE4AySVK9iSlvEYBl32WAZJ6jwD8758gJwIy4lwPrf93Lwh7mwZQ4ii2NfQHZPbFblMtb6xwEydN2sRZ+NaBwwytswnJQ7iqTu4dTepaT5lBpi+WPI6lbQSjK13c3KHLoeZHmslwozLRU8zPz2nLG0LhnX8/9gTsspIC00sD8PiPGMzcrBJG5bQNUQmwrCl3CIdBZZtPs=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6534.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(10067099003)(3023799007)(6133799003)(18002099003)(22082099003)(56012099006)(11063799006)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?hbZ+ZDMAgQ7+wTBC1QV8Q3KIR8WSgid8vqWcsj64WJFIs17xRmNVsgtyMG?=
 =?iso-8859-1?Q?Kjt7LWmaRS7bYM+0YzUY1zhgoADjm6TkbaUmXO9YAeB16fJEKTpZXL17Y+?=
 =?iso-8859-1?Q?P2RWRvAP1nJOrmjTDeOSK6RPOI4p/ChprsdnXEEo4OOQOuIl+I8UPI7Ia+?=
 =?iso-8859-1?Q?5+vX/tGamdxh53N+Ob2vjnjeuZrKKR1rcVIeEqFgi0cfaaRfSZvlAxaCok?=
 =?iso-8859-1?Q?nq/VU/tZSQeZhEdZ2PiUqYphXualMZaw+Ulim1PpXLlFqIQYPNjn35XDso?=
 =?iso-8859-1?Q?92h1VO9LY2rskoB2EGBACeKT9m3282dfCOmRPzeyphKWbLYMKdaWXt5XhE?=
 =?iso-8859-1?Q?nKPsz0oPb1jvEOek+tFx5eIEQDEv50/MA4/Hn3XT18gO+m9hwpW1rqnA/w?=
 =?iso-8859-1?Q?v03YMTVomtjwGRNVAJKFVPwcvMEzObGGA/bRmkQRzXvGC7GjtOmqQGYYNM?=
 =?iso-8859-1?Q?wZGsjOt68Vh9kgXDgYe+y2Ru2awEL+9omL18mFftGcWdyqy75RWmwonCe+?=
 =?iso-8859-1?Q?N93Npxijs+CEOwDs9OzpurziR1hdmNK1wrvcLpIe/LLN6GDITzC4bGRcCd?=
 =?iso-8859-1?Q?LXQO/SKbmjNAzefJRvyXTI5o/oh3Q7JFx7IvmThppKOM5xy55U3apkc8nq?=
 =?iso-8859-1?Q?jR80M8NNvCTyJrCuEk3LucF14CSrsM4m+K8RppZJdsUiC17/N/MvfXr8uC?=
 =?iso-8859-1?Q?Igiz0ztU3CBhRLYLkBIneJI3KEubiBkaL3J4JOtrDlEpmTMUeLemJd+mZC?=
 =?iso-8859-1?Q?/J9F1UFyZoO31sr3pqeqF3rAOGZoiEEONztyD1x84/AoMnAXfbOhFwHUEu?=
 =?iso-8859-1?Q?qclX2c5v/RaQtv8Tul6EaeJOTkgPT92jWURec4KVff9+T4mtTZjXWXshP1?=
 =?iso-8859-1?Q?/yaEt0fpkf6gzlxqefMRF/EFGy6jA1D9q53dJk+KyufBW4EuSXmcJVobXK?=
 =?iso-8859-1?Q?ngxiJJ9OAXAzN612X394OhpB43TaSVwgmRhdTrxytjaqq8O4tHvy2fqeac?=
 =?iso-8859-1?Q?WkclSsSIL9yYE9dE6UG78rxWlf4ylwAr2Z9RbnxJEiclEmv/eRAucOlaNY?=
 =?iso-8859-1?Q?57iWomBdoh5A1XQjG5XyYXe+LZ8op2bkBHvbheMc+OpJgjTbZpEkuyCH8N?=
 =?iso-8859-1?Q?hd2iMbhWRoWqzcNEcxvcGDUzJsIOjDzIPN1IuBxIvj+fdqKTnU9l8hH+eF?=
 =?iso-8859-1?Q?KyVRALNUmHyU4iCxiqoUtKV7JVDDM13y4Qh48zANNUxoDiHZe5dSSo3+7t?=
 =?iso-8859-1?Q?4oGqdtlsBSkYnCzVAVX8U9upvfqASA9Gkt4RF3GoseuJzC5NPfyXfNvm25?=
 =?iso-8859-1?Q?fcpBOlwOWsYtcRo4XxKxcplkHYYQ1j86+RUpohBwqdwgB8Hi/bHyQXiaCD?=
 =?iso-8859-1?Q?Ofjlx20wuro8mV/7ujg17Hol8OuleIdmq67UzqhHgPNxzP/ge9sNc/CiV8?=
 =?iso-8859-1?Q?ac068PPYnnwNtcz88vteSqlsbGDRafaxRk2qdcmzQza7RWq6LFDlPGh8lV?=
 =?iso-8859-1?Q?PkIQZNKz3+cgKo2p3JELqRzjVbNdMcVbfA9dcOS5/gwuvY3eo92syKtD3P?=
 =?iso-8859-1?Q?VbOXWCNabFFiUxUO+4xHXpoRRZTk6w5U+BQfa3d2OV7nF8nOl4f2BUO13W?=
 =?iso-8859-1?Q?qvPEp4g0ZxRJFAgd+laMUpiuZ153gEaTgZFUZAW6oNGi23YC793GrZYtmC?=
 =?iso-8859-1?Q?9W9pUPzA/vR16bVA/JV6qK+9ZWfZCXwszzxddE9T077KjLYgLkK0DzsX2W?=
 =?iso-8859-1?Q?v2L7NZ4siXeqmMaEvvVIQStpUsWuqWOhAc17Wi0Zvr3/Bq?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3658908f-c444-402e-65d3-08df17e2f0ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2026 13:19:17.7419 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A9fN6BjaA5+QwLSUqUOwt8eachSJC23/aW4rJ3iwytNUXW62t8/S6Z49T2VFR2EAoRgfd4n0mixa/FLYuzlxsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF5C5D42165
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


The patchset consists of the amd-staging-drm-next branch (Head commit -> c9=
c3b6a85b346a8aba4b4009c2cd66a37e6bc0b9 -> drm/amdgpu/sdma: Fix executing du=
plicate commands after recovery on SDMA v4.4.2) with new patches added on t=
op of it.

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
From: Zhang, George <George.Zhang@amd.com>
Sent: Wednesday, September 16, 2026 1:51 PM
To: amd-gfx@lists.freedesktop.org
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.L=
i@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>; Li, Roman <Roman.=
Li@amd.com>; Lin, Wayne <Wayne.Lin@amd.com>; Chung, ChiaHsuan (Tom) <ChiaHs=
uan.Chung@amd.com>; Zuo, Jerry <Jerry.Zuo@amd.com>; Wheeler, Daniel <Daniel=
.Wheeler@amd.com>; Wu, Ray <Ray.Wu@amd.com>; LIPSKI, IVAN <IVAN.LIPSKI@amd.=
com>; Hung, Alex <Alex.Hung@amd.com>; Lin, Ping Lei <PingLei.Lin@amd.com>; =
Chen, Chen-Yu <Chen-Yu.Chen@amd.com>; Zhang, George <George.Zhang@amd.com>
Subject: [PATCH 00/64] DC Patches for September 16, 2026

This DC patchset brings improvements in multiple areas. In summary, we have=
:
- Increased KUnit coverage
- Reverts a patch causing regression on DCN42
- Fixes for cursor
- Imporvements for ABM


Alex Hung (33):
  drm/amd/display: Select KUnit helpers
  drm/amd/display: Fold blending tests into two cases
  drm/amd/display: Fold universal overlay format test
  drm/amd/display: Fold plane modifier list tests
  drm/amd/display: Fold modifier append tests
  drm/amd/display: Fold GFX9 tiling info tests
  drm/amd/display: Fold GFX6-8 tiling and modifier tests
  drm/amd/display: Fold DCC validation tests
  drm/amd/display: Fold DCC block mode tests
  drm/amd/display: Fold plane scaling and cursor tests
  drm/amd/display: Fold plane state check tests
  drm/amd/display: Fix amdgpu_dm's kernel-doc warnings
  drm/amd/display: Test EDID helper paths
  drm/amd/display: Test AUX transfer paths
  drm/amd/display: Test MST topology start
  drm/amd/display: Test unassigned OTG CRTC lookup
  drm/amd/display: Test VRR pageflip completion
  drm/amd/display: Test HPD RX offload work branches
  drm/amd/display: Test HDMI HPD debounce re-detect
  drm/amd/display: Test HPD handler HDCP and detect
  drm/amd/display: Test HPD RX downstream handling
  drm/amd/display: Drop redundant amdgpu_dm_irq tests
  drm/amd/display: Fix KUnit connector warnings
  drm/amd/display: Fix KUnit CRTC warnings
  drm/amd/display: Fix KUnit cursor warning
  drm/amd/display: Fix KUnit VRR warnings
  drm/amd/display: Fix KUnit helper warnings
  drm/amd/display: Fix KUnit IRQ warnings
  drm/amd/display: Fix KUnit MST warnings
  drm/amd/display: Fix KUnit DM warnings
  drm/amd/display: Fix KUnit writeback warnings
  drm/amd/display: Fix KUnit checkpatch warnings
  drm/amd/display: Fix LSDMA divide by zero

Alvin Lee (3):
  drm/amd/display: Enable double buffering for DSCCLK updates
  drm/amd/display: Wait response should be based on fw_based_mclk_switch
  drm/amd/display: Re-enable P-State message to SMU

Austin Zheng (1):
  drm/amd/display: Add Back Unified CalculateFlipSchedule

Dillon Varone (1):
  drm/amd/display: Add more diagnostic logs for DMU

Fangzhi Zuo (1):
  drm/amd/display: Restore FreeSync VCP code check for HDMI/PCON sinks

Huang, Leon (1):
  drm/amd/display: Forward periodic ABM keep-alive scenario to DMU

Ivan Lipski (3):
  drm/amd/display: Expose 3 overlay planes on DCN6
  drm/amd/display: Remove DCN6 DCFCLK num assert
  drm/amd/display: Resync cursor cache after offload abort on DCN60

Matthew Stewart (1):
  drm/amd/display: Fix DCN42B plane alpha

Nicholas Kazlauskas (1):
  drm/amd/display: Fix missing gaps for link lock with inbox0

Piotr Maziarz (5):
  drm/amd/display: Refactor DPP_PROGRAM_UPSP to drop pipe_ctx
  drm/amd/display: Remove phantom SW state ops from block sequence
  drm/amd/display: fix cursor refactor fallout and sync UT headers
  drm/amd/display: clamp cursor hotspot at the register write
  drm/amd/display: Rename build_cursor_position to
    dcn10_build_cursor_pos_update_params

Rafal Ostrowski (2):
  drm/amd/display: Drop pipe_ctx from hwss block sequence operations
  drm/amd/display: refactor hwss SET_CURSOR_POSITION block sequence

Taimur Hassan (2):
  drm/amd/display: [FW Promotion] Release 0.1.76.0
  drm/amd/display: Promote DC to 3.2.399

Tony Cheng (9):
  drm/amd/display: add SPDX-License-Identifier
  drm/amd/display: Add inst field to struct hubbub
  drm/amd/display: Add inst field to struct clk_mgr
  drm/amd/display: Add inst field to struct abm
  drm/amd/display: Add inst field to struct dmub_psr
  drm/amd/display: Add inst field to struct dmub_replay
  drm/amd/display: Add inst field to struct pg_cntl
  drm/amd/display: Add inst field to encoder structs
  drm/amd/display: Add inst field to clock_source and dio

Tony Qi (1):
  drm/amd/display: Revert "request DMUB HW cursor offload"

 drivers/gpu/drm/amd/display/Kconfig           |    3 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   10 -
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |    7 +-
 .../display/amdgpu_dm/amdgpu_dm_connector.c   |    6 +
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h |    9 +
 .../display/amdgpu_dm/amdgpu_dm_mst_types.h   |    2 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   |    1 +
 .../amd/display/amdgpu_dm/tests/.kunitconfig  |    1 -
 .../tests/amdgpu_dm_connector_test.c          |   64 +-
 .../amdgpu_dm/tests/amdgpu_dm_crtc_test.c     |   50 +-
 .../amdgpu_dm/tests/amdgpu_dm_cursor_test.c   |    4 +
 .../amdgpu_dm/tests/amdgpu_dm_freesync_test.c |   22 +
 .../amdgpu_dm/tests/amdgpu_dm_helpers_test.c  |  250 ++
 .../amdgpu_dm/tests/amdgpu_dm_irq_test.c      | 1066 +++++----
 .../tests/amdgpu_dm_mst_types_test.c          |    9 +
 .../amdgpu_dm/tests/amdgpu_dm_plane_test.c    | 2036 +++++------------
 .../amdgpu_dm/tests/amdgpu_dm_services_test.c |    2 +-
 .../display/amdgpu_dm/tests/amdgpu_dm_test.c  |   43 +-
 .../amdgpu_dm/tests/amdgpu_dm_wb_test.c       |    4 +
 .../dc/clk_mgr/dcn401/dcn401_clk_mgr.c        |    1 +
 .../display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c  |    7 +-
 .../dc/clk_mgr/dcn42b/dcn42b_clk_mgr.c        |    3 +-
 .../drm/amd/display/dc/clk_mgr/dcn60/dalsmc.h |    3 +-
 .../display/dc/clk_mgr/dcn60/dcn60_clk_mgr.c  |    4 +-
 .../dc/clk_mgr/dcn60/dcn60_clk_mgr_smu_msg.c  |   36 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |    4 +-
 .../drm/amd/display/dc/core/dc_hw_sequencer.c |  301 +--
 .../gpu/drm/amd/display/dc/core/dc_resource.c |    6 +-
 .../gpu/drm/amd/display/dc/core/dc_stream.c   |   23 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |    2 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |  134 +-
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h  |    3 +
 drivers/gpu/drm/amd/display/dc/dc_types.h     |    2 +
 .../amd/display/dc/dccg/dcn20/dcn20_dccg.h    |    4 +
 .../amd/display/dc/dccg/dcn60/dcn60_dccg.c    |    4 +
 .../amd/display/dc/dccg/dcn60/dcn60_dccg.h    |    4 +
 drivers/gpu/drm/amd/display/dc/dce/dce_abm.c  |    2 +
 .../drm/amd/display/dc/dce/dce_clock_source.c |    5 +-
 drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c |    1 +
 .../drm/amd/display/dc/dce/dmub_hw_lock_mgr.c |   10 +-
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c |    1 +
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.h |    1 +
 .../gpu/drm/amd/display/dc/dce/dmub_replay.c  |    3 +-
 .../gpu/drm/amd/display/dc/dce/dmub_replay.h  |    1 +
 .../amd/display/dc/dcn301/dcn301_panel_cntl.c |    1 +
 .../amd/display/dc/dcn31/dcn31_panel_cntl.c   |    1 +
 .../drm/amd/display/dc/dio/dcn10/dcn10_dio.c  |    1 +
 .../display/dc/dio/dcn10/dcn10_link_encoder.c |    2 +
 .../dc/dio/dcn10/dcn10_stream_encoder.c       |    2 +
 .../display/dc/dio/dcn20/dcn20_link_encoder.c |    2 +
 .../dc/dio/dcn20/dcn20_stream_encoder.c       |    2 +
 .../dc/dio/dcn30/dcn30_dio_link_encoder.c     |    2 +
 .../dc/dio/dcn30/dcn30_dio_stream_encoder.c   |    2 +
 .../dc/dio/dcn301/dcn301_dio_link_encoder.c   |    2 +
 .../dc/dio/dcn31/dcn31_dio_link_encoder.c     |    2 +
 .../dc/dio/dcn314/dcn314_dio_stream_encoder.c |    2 +
 .../dc/dio/dcn32/dcn32_dio_link_encoder.c     |    2 +
 .../dc/dio/dcn32/dcn32_dio_stream_encoder.c   |    2 +
 .../dc/dio/dcn321/dcn321_dio_link_encoder.c   |    2 +
 .../dc/dio/dcn35/dcn35_dio_link_encoder.c     |    2 +
 .../dc/dio/dcn35/dcn35_dio_stream_encoder.c   |    2 +
 .../dc/dio/dcn401/dcn401_dio_link_encoder.c   |    2 +
 .../dc/dio/dcn401/dcn401_dio_stream_encoder.c |    1 +
 .../dc/dio/dcn42/dcn42_dio_link_encoder.c     |    2 +
 .../dc/dio/dcn42/dcn42_dio_stream_encoder.c   |    2 +
 .../dc/dio/dcn60/dcn60_dio_link_encoder.c     |    2 +
 .../dc/dio/dcn60/dcn60_dio_stream_encoder.c   |    2 +
 .../dc/dio/virtual/virtual_link_encoder.c     |    3 +
 .../dc/dio/virtual/virtual_stream_encoder.c   |    1 +
 .../dml21/inc/bounding_boxes/dcn4_soc_bb.h    |    2 +-
 .../src/dml2_core/dml2_core_dcn4_calcs.c      |  164 +-
 .../src/dml2_core/dml2_core_shared_types.h    |    3 +
 .../alternate_pstate_shared_lib.c             |   22 +-
 .../dml2_utm_soc_bb/dml2_utm_soc_bb_dcn6.c    |    2 -
 .../amd/display/dc/dpp/dcn401/dcn401_dpp.h    |    2 +
 .../amd/display/dc/dpp/dcn401/dcn401_dpp_cm.c |   19 +
 .../drm/amd/display/dc/dpp/dcn60/dcn60_dpp.c  |    1 +
 .../hpo/dcn30/dcn30_hpo_frl_stream_encoder.c  |    2 +
 .../dcn401/dcn401_hpo_frl_stream_encoder.c    |    2 +
 .../hpo/dcn42/dcn42_hpo_frl_stream_encoder.c  |    2 +
 .../hpo/dcn60/dcn60_hpo_frl_stream_encoder.c  |    2 +
 .../display/dc/hubbub/dcn10/dcn10_hubbub.c    |    2 +
 .../display/dc/hubbub/dcn20/dcn20_hubbub.c    |    2 +
 .../display/dc/hubbub/dcn201/dcn201_hubbub.c  |    2 +
 .../display/dc/hubbub/dcn21/dcn21_hubbub.c    |    2 +
 .../display/dc/hubbub/dcn30/dcn30_hubbub.c    |    2 +
 .../display/dc/hubbub/dcn301/dcn301_hubbub.c  |    2 +
 .../display/dc/hubbub/dcn31/dcn31_hubbub.c    |    1 +
 .../display/dc/hubbub/dcn32/dcn32_hubbub.c    |    2 +
 .../display/dc/hubbub/dcn35/dcn35_hubbub.c    |    2 +
 .../display/dc/hubbub/dcn401/dcn401_hubbub.c  |    2 +
 .../display/dc/hubbub/dcn42/dcn42_hubbub.c    |    2 +
 .../display/dc/hubbub/dcn60/dcn60_hubbub.c    |    2 +
 .../amd/display/dc/hubp/dcn31/dcn31_hubp.c    |    1 +
 .../amd/display/dc/hubp/dcn401/dcn401_hubp.c  |  105 +-
 .../amd/display/dc/hubp/dcn401/dcn401_hubp.h  |    2 +
 .../amd/display/dc/hubp/dcn60/dcn60_hubp.c    |    1 +
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c |    2 +-
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   |   20 +-
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.h   |    7 +-
 .../amd/display/dc/hwss/dcn10/dcn10_init.c    |    1 +
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   |   14 +-
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.h   |    3 +-
 .../amd/display/dc/hwss/dcn20/dcn20_init.c    |    1 +
 .../amd/display/dc/hwss/dcn201/dcn201_init.c  |    1 +
 .../amd/display/dc/hwss/dcn21/dcn21_init.c    |    1 +
 .../amd/display/dc/hwss/dcn30/dcn30_init.c    |    1 +
 .../amd/display/dc/hwss/dcn301/dcn301_init.c  |    1 +
 .../amd/display/dc/hwss/dcn31/dcn31_init.c    |    1 +
 .../amd/display/dc/hwss/dcn314/dcn314_init.c  |    1 +
 .../amd/display/dc/hwss/dcn32/dcn32_init.c    |    1 +
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   |   11 +
 .../amd/display/dc/hwss/dcn35/dcn35_init.c    |    1 +
 .../amd/display/dc/hwss/dcn351/dcn351_init.c  |    1 +
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |   71 +-
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.h |    7 +-
 .../amd/display/dc/hwss/dcn401/dcn401_init.c  |    1 +
 .../amd/display/dc/hwss/dcn42/dcn42_init.c    |    1 +
 .../amd/display/dc/hwss/dcn50/dcn50_hwseq.c   |    6 +-
 .../amd/display/dc/hwss/dcn60/dcn60_init.c    |    1 +
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |   75 +-
 .../display/dc/hwss/hw_sequencer_private.h    |    3 +
 .../gpu/drm/amd/display/dc/inc/clock_source.h |    2 +
 drivers/gpu/drm/amd/display/dc/inc/hw/abm.h   |    1 +
 .../gpu/drm/amd/display/dc/inc/hw/clk_mgr.h   |    1 +
 .../gpu/drm/amd/display/dc/inc/hw/dchubbub.h  |    1 +
 drivers/gpu/drm/amd/display/dc/inc/hw/dio.h   |    1 +
 drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h   |    2 +
 drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h  |    2 +
 .../drm/amd/display/dc/inc/hw/link_encoder.h  |    1 +
 .../gpu/drm/amd/display/dc/inc/hw/pg_cntl.h   |    1 +
 .../amd/display/dc/inc/hw/stream_encoder.h    |    2 +
 drivers/gpu/drm/amd/display/dc/inc/resource.h |    2 +-
 .../amd/display/dc/pg/dcn35/dcn35_pg_cntl.c   |    1 +
 .../amd/display/dc/pg/dcn42/dcn42_pg_cntl.c   |    1 +
 .../dc/resource/dcn60/dcn60_resource.c        |    6 +-
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |   58 +-
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |   53 +-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn20.c |   84 +-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn20.h |    2 +-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn31.c |   94 +-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn31.h |    2 +-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn32.c |   94 +-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn32.h |    2 +-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn35.c |   94 +-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn35.h |    2 +-
 .../drm/amd/display/dmub/src/dmub_dcn401.c    |   98 +-
 .../drm/amd/display/dmub/src/dmub_dcn401.h    |    2 +-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn42.c |   98 +-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn42.h |    2 +-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn60.c |   98 +-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn60.h |    2 +-
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   |   54 +-
 153 files changed, 2963 insertions(+), 2688 deletions(-)

--
2.55.0

