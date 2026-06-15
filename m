Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4645CCD98C5
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jun 2026 13:12:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD2F510E3DE;
	Mon, 15 Jun 2026 13:12:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="X+OlrFMd";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010063.outbound.protection.outlook.com [52.101.61.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC25710E3DE
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jun 2026 13:12:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SGDibgLvY4m2Fdv6qQ4P+49pmuZC1VIXTor8v6VAc46ViT1lRFQ3TgIe8HbUdJWBsgX3Ywz/8JdGMuJ7WaF9FUzmCJJClqjsWoTRhA7w4RvYFsbMv78ZabrbK43aoC5Z6PYXz2EdYyy67GcECyh7U/qrXMyAw0SaiGMi4nG17AJrE41cF+G0/MI0MrrScOQ+HeCuvyuQkseRY4kX5t8AQ20j9RzzU9bEyzgNtFiMDeanvEdhshXT2ENlnUneXDXClhnQE/0Bqnvk45xCUFlNxQhsPUvoiI8qq8kXd7YXsR2AY+Gua8Jb4kMBGnlq0CgFSjMjydcAWs7zHFaoUGycng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fi7+fd4jCoVnvqetHV+3Y8+ChlWMU+uxDDhb3hS8Z1A=;
 b=iBOYy1k/umyuSqfpbXwImxjbjkvH0VSRQthkSSxeR/H0jDRdMcXCr7z401csfQ86CmFplOd+JpxzxHmo5zfU832NSO9AZjHWYDeZS5Tx4ZZvSISuNNAEYQBfdbBMJyuUBurmvqIxbStHzE/trx4aJUWclX7IcqSn4woGlBjAHkUpEQ8Fi+tsg5kY0CRLemrMDEzrmT8xBspOKjRulshabPF19/tZ2qyaP4IUhDE3TRudt3KBQrSeDiJgfuGiP+VYQEO1o3nqAdXnRBv0mQ3tk0MhpFu4KKwU5fWrJ0eqAo6kSolg5yOTDQ6McOY7aFkq3OrK3m3yGFKYogd0Q1eScg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fi7+fd4jCoVnvqetHV+3Y8+ChlWMU+uxDDhb3hS8Z1A=;
 b=X+OlrFMdx7JejIkeU0NqsgKI4AGKfBEbD4SkZiAGsNqxgWp3C0nUICV0etgCj/h/upteFuysl3zEeE9SxAT64m7qFF7mn+4+pwpm0NiIeAe4nHnxtZOWU8WVa6fRiT8ohfHz0A5APDgy1D+9cdKHx5wvSfHrYVt8DEZ9QdxVybw=
Received: from DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) by
 CY1PR12MB9697.namprd12.prod.outlook.com (2603:10b6:930:107::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.18; Mon, 15 Jun 2026 13:12:00 +0000
Received: from DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::b2e1:64e5:3b9e:738a]) by DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::b2e1:64e5:3b9e:738a%6]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 13:11:59 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Chen, Chen-Yu" <Chen-Yu.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Wentland, Harry" <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)"
 <Sunpeng.Li@amd.com>, "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>, "Li,
 Roman" <Roman.Li@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>, "Chung,
 ChiaHsuan (Tom)" <ChiaHsuan.Chung@amd.com>, "Zuo, Jerry" <Jerry.Zuo@amd.com>, 
 "Wu, Ray" <Ray.Wu@amd.com>, "LIPSKI, IVAN" <IVAN.LIPSKI@amd.com>, "Hung,
 Alex" <Alex.Hung@amd.com>, "Lin, Ping Lei" <PingLei.Lin@amd.com>, "Chen,
 Chen-Yu" <Chen-Yu.Chen@amd.com>, "Chen, Chen-Yu" <Chen-Yu.Chen@amd.com>
Subject: RE: [PATCH 00/32] DC Patches Jun 15 2026
Thread-Topic: [PATCH 00/32] DC Patches Jun 15 2026
Thread-Index: AQHc+L46he63JFygFUCxYnnGr10kqLY/n2HQ
Date: Mon, 15 Jun 2026 13:11:59 +0000
Message-ID: <DS0PR12MB6534BB556EB3FBBC2D127C6E9CE62@DS0PR12MB6534.namprd12.prod.outlook.com>
References: <20260610094639.1965367-1-chen-yu.chen@amd.com>
In-Reply-To: <20260610094639.1965367-1-chen-yu.chen@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Enabled=True;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SetDate=2026-06-15T13:11:48.0000000Z;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Name=AMD Public
 v26; MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_ContentBits=3;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6534:EE_|CY1PR12MB9697:EE_
x-ms-office365-filtering-correlation-id: 43f0e42c-4fea-41f5-0ea2-08decadfaf12
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|56012099006|11063799006|3023799007|6133799003|22082099003|38070700021|18002099003;
x-microsoft-antispam-message-info: cjt/+evDPE9yRkOO+GvYomMTOXTcJEvZdgJ2U7AEkL/GqK4rNRP1LVrvOI1GQwTl2Ylt81qK75WuBz7KLdzQgOLXp7kHVENaOV+3v0pA6GArdUFBPGMqX9+jRFVa2zf0Eux/VoJr8t8hYkvfjHNqM2/VmR40vLf8Ppvl6+Dtd+GeQcNYYR2C1ARFoPgokRBJCFXthMd+IpTkF0xcVcdiCSu/M0C7NYs+F4WvToaVSy/sjmTwQc5fHFmgbwE71kE/IR1CCkiyze7Iy7O+J8WbVu+TYEuzqTZGoVbxluI49KdMCjDoiFQH6qVI97YJxk8BrjPB/e8cG3ykQkH/ZGxTI9DiRJ6jFgZNFzzsZlihYVhVQF8fNzIpUK55MpLWEA+BU8q+aVcJGq+LSD5qFNFffYoG5nVeHwmrPxXVpB/BKEno7gjolicxbfTfhHb4ei1b+zFWu7fUH8c6FoGL3IHWgCGIYrfuzbEUE9swI9yFhzWdbav5mSGUkP1wUGrupjxAjVSpeF+oSbqWNf0yTC2JaLq5Cq6SHkhZEriyhdT1x4CW9sVRFGDKUoJeM1TNbTYD/5pKvj5h/TaUnzFK8HFVXxxUibsemaYrje+ffqGjt/nOhAgtD+4IZXcUZNj1tmPjWwpSPVcqZr5Jxe6LatxR+IvRyreWSC4Y6IhVccwdgFv1Y8yNq2yu0N7UNwIrwGJV4trV8sldXWfmjcls3IUTxd7frsTYA1LgO0IOELvBnGRWqBupBMhnpC+ZC4Dmugxv
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6534.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(56012099006)(11063799006)(3023799007)(6133799003)(22082099003)(38070700021)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?QBFQaPq58N1XoBX+UOTmGgL7VmcQsXgtQNNzTPyn81Ey8YqGoTrhaUr6Kb?=
 =?iso-8859-1?Q?4CxrFpchYzpx5xmtIwms21WV+8PwRISpZhpFMPCdOZvYvTugZxYKjcLLFE?=
 =?iso-8859-1?Q?xW738ni70J9K7SQbeRrpaCcdlOhsECyvOuuvwb1XDRKos/NXVvsEWBdrXX?=
 =?iso-8859-1?Q?+IywJeDU6rqWXWgAuKY/g3aoFj8l666qLnRz+14jPEQ+jjhIqfYWjygdiq?=
 =?iso-8859-1?Q?6bmArPdxfD8eo8Fix8YpODqrHXyyozQTrkEOloZ2lkiRpDTWxmu0297YTA?=
 =?iso-8859-1?Q?y4vQxboBIe00rwgowgiGq1iN1jow2u7XI6RBYDDcnil9LjmtK9SCOJt6OW?=
 =?iso-8859-1?Q?5M7nidsutI+75S7O2YW17bL8NOshgIwJmsCGnhxlkUgayQCF12enaG0ViL?=
 =?iso-8859-1?Q?AhYbADNp7NcC4zuzsFenGbuoTkvR+Qn65CAbnMjXcvIjFe0uFpbgcWLF0b?=
 =?iso-8859-1?Q?eeS587A1HZ7DU3ueKsraRgtmWcDwMQFllhe1ZTXFH2Xq1u7bhX836VGAPA?=
 =?iso-8859-1?Q?9UDne4Owwy1THlD+XxH8HdwgxUQeqxbXfwrnTs+m/EVZkSv0EVCdECLGa7?=
 =?iso-8859-1?Q?QCq6NZcYyvsr8FSyx0/jjyau+W0qF9p+LHmp5KbXLBvq+YP9gLN+tUOkWV?=
 =?iso-8859-1?Q?4ff41WE0wP75lQYBwZgu2F7cBdLkuWVww9tEwv7/mFp7gEUBi6QfPAUPFO?=
 =?iso-8859-1?Q?Kr4WSNol3D5V/IZRQdqMOKDLZBgmWqBMl94S8TpEfcyzXCDqO66j4xNGH9?=
 =?iso-8859-1?Q?IOBVINMUI4otZU2LtIa9jJkuQrrxmUl2M/9MWdLhewLojOwkrTgUzKnvBz?=
 =?iso-8859-1?Q?bd+q13C1Xt+rjo0dZYO7FFeJ8UHwYsbpGuXhWb3b41PBtU+7AU9YtAxHpy?=
 =?iso-8859-1?Q?Ueqd/xnzuLV3FIzeIastybB0M1mTuOAwmqnW1/7I26fv2rMDxIU8Xy+0LZ?=
 =?iso-8859-1?Q?D+3ADy7YyoCQH6+6Xid7D5c03/KJINWHquRtKyje0Zoms9MqyY53VNc+EN?=
 =?iso-8859-1?Q?DholV9cFZ3fAKQKU6qBGx7TAJn39uEzEd0MAh7FXn4E3BKY0IMtj0R2LDw?=
 =?iso-8859-1?Q?wDNApwJiS35n5H/G1w9zulEURkWXoug7/lQgqdXT9eJskuiXmd46/v+Voq?=
 =?iso-8859-1?Q?pV/fRVLosp/nkQ3a2SZ4lCmKl3ViZQkThOBsRQZbXY6agDP8MijmazsFtM?=
 =?iso-8859-1?Q?o7jBNhbjjggSPgWi7LmL8KiTCWUNSW/hCgv2Yg7ia2jy6C8Of2OQntlGyG?=
 =?iso-8859-1?Q?Yi5d2lX+pvM7xTS/kwb6+2B7DfVS1wp8knTf39g9pzIS3ZKKk9jHhXKGxU?=
 =?iso-8859-1?Q?9Dvqcca6D+ItiDqVYXJj7gCiaqwaSqfpE6PRIK44wwRr/1fcOAUt+vj0eK?=
 =?iso-8859-1?Q?R/EFUq28/yy2qh7wK78SDexfpgP4pC/3pHOdnOaxy5IVn1pf/5w7chHW4G?=
 =?iso-8859-1?Q?N/8vsFoDt83s0g3qtBUsm2kZlwyVFiz2Ty80FsCpFOKbA7ID1Q7LgiAwla?=
 =?iso-8859-1?Q?WHd4XLiRRH+A1HmmQevWxyz1Hlv7YpbiOL00BwDkdC2GRxRysB0RuCOP9V?=
 =?iso-8859-1?Q?bGRL2hRenDlYVx4rEJgU/gR9mD9T+W81iBmTf3zsvC9EXfVoZBqdyhGeaF?=
 =?iso-8859-1?Q?D0ehEoQ8AYO/h7Sclpd3xLEoESim2i0DF9MGHRClcNp21WDoZrUELIKqLt?=
 =?iso-8859-1?Q?cbuYnLx7OF7R6qIhuGT5V6XNIfb1RvJCPoBC+gZx9IovJUDvdXR1Fc7i6+?=
 =?iso-8859-1?Q?1uHcb0rswS9xht5xeY1e15/+2g3+nbYr4fm2iE1fglQXt6?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43f0e42c-4fea-41f5-0ea2-08decadfaf12
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2026 13:11:59.6678 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PBLFC75Mfyq/tTc0DiYkoj2HwLnumj5ATa3BC+jd5Rf55lC3ni2cDpAWNgD+BcvUOdYyuwcDLvLM0rUgCI2x7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9697
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
, and tested across multiple display and connection types. This week was al=
so the last promotion test ran on Ubuntu 24.04. There won't be any testing =
this week as we had a holiday this past Monday, so the first test on Ubuntu=
 26.04 will begin next week.

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


The patchset consists of the amd-staging-drm-next branch (Head commit -> fd=
a768acb2a1d6dd59212bb06b94142dd80f361c -> drm/amd/display: Promote DC to 3.=
2.385) with new patches added on top of it.

Tested on Ubuntu 26.04.4, on Wayland and X11, using Gnome.

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
From: Chenyu Chen <chen-yu.chen@amd.com>
Sent: Wednesday, June 10, 2026 5:45 AM
To: amd-gfx@lists.freedesktop.org
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.L=
i@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>; Li, Roman <Roman.=
Li@amd.com>; Lin, Wayne <Wayne.Lin@amd.com>; Chung, ChiaHsuan (Tom) <ChiaHs=
uan.Chung@amd.com>; Zuo, Jerry <Jerry.Zuo@amd.com>; Wheeler, Daniel <Daniel=
.Wheeler@amd.com>; Wu, Ray <Ray.Wu@amd.com>; LIPSKI, IVAN <IVAN.LIPSKI@amd.=
com>; Hung, Alex <Alex.Hung@amd.com>; Lin, Ping Lei <PingLei.Lin@amd.com>; =
Chen, Chen-Yu <Chen-Yu.Chen@amd.com>; Chen, Chen-Yu <Chen-Yu.Chen@amd.com>
Subject: [PATCH 00/32] DC Patches Jun 15 2026

This DC patchset brings improvements in multiple areas. In summary, we high=
light:

 - Major amdgpu_dm refactoring into modular components
   (backlight, audio, DMUB, IRQ, connector)
 - Enhancements in clock management and DCN4 pstate handling
 - HDMI pipeline cleanup and compliance automation support
 - Introduction of dc_plane_cm and surface update refactor
 - Backlight handling improvements without ACPI dependency
 - Addition of KUnit tests to improve test coverage
 - Firmware update to version 0.1.63.0

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Alex Hung (19):
  drm/amd/display: Extract backlight code to amdgpu_dm_backlight
  drm/amd/display: Extract audio code to amdgpu_dm_audio
  drm/amd/display: Extract DMUB code to amdgpu_dm_dmub
  drm/amd/display: Move HPD and IRQ handler code to amdgpu_dm_irq
  drm/amd/display: Extract connector and encoder code to
    amdgpu_dm_connector
  drm/amd/display: Fix conflicting types for dc_plane_cm functions
  drm/amd/display: Add KUnit tests for amdgpu_dm
  drm/amd/display: Add KUnit tests for amdgpu_dm_backlight
  drm/amd/display: Add KUnit tests for amdgpu_dm_audio
  drm/amd/display: Add KUnit tests for amdgpu_dm_dmub
  drm/amd/display: Add KUnit tests for amdgpu_dm_connector
  drm/amd/display: Add KUnit tests for amdgpu_dm_irq
  drm/amd/display: Add KUnit tests for amdgpu_dm_crtc
  drm/amd/display: Add KUnit tests for amdgpu_dm_services
  drm/amd/display: Add KUnit tests for amdgpu_dm_helpers
  drm/amd/display: Add KUnit tests for amdgpu_dm_quirks
  drm/amd/display: Add more KUnit tests for amdgpu_dm_pp_smu
  drm/amd/display: Add more KUnit tests for amdgpu_dm_mst_types
  drm/amd/display: Move backlight macros to backlight header

Fangzhi Zuo (1):
  drm/amd/display: Add Support for HDMI Compliance Automation

Gabe Teeger (2):
  drm/amd/display: Increase dcn42b uclk value
  drm/amd/display: Enable pstate for DCN4 non-emulation builds

Mario Limonciello (1):
  drm/amd/display: Set default backlight without ACPI support

Nicholas Kazlauskas (1):
  drm/amd/display: Add a new interface to set idle opts in clock manager

Rafal Ostrowski (2):
  drm/amd/display: Introduce dc_plane_cm and migrate surface update
    color path
  drm/amd/display: Refactor surface_update_flags to flat struct with
    helpers

Robin Chen (1):
  drm/amd/display: Add PSR Active VTotal Control capability

Taimur Hassan (2):
  drm/amd/display: [FW Promotion] Release 0.1.63.0
  drm/amd/display: Promote DC to 3.2.386

Wenjing Liu (3):
  drm/amd/display: Add utm_qos_model pointer to clk_bw_params
  drm/amd/display: Remove get_utm_qos_model from soc_and_ip_translator
  drm/amd/display: Remove unused project_id from DML2 core instance

 .../gpu/drm/amd/display/amdgpu_dm/Makefile    |     6 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 11981 ++++------------
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |    79 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_audio.c   |   323 +
 .../amd/display/amdgpu_dm/amdgpu_dm_audio.h   |    56 +
 .../display/amdgpu_dm/amdgpu_dm_backlight.c   |   704 +
 .../display/amdgpu_dm/amdgpu_dm_backlight.h   |    67 +
 .../amd/display/amdgpu_dm/amdgpu_dm_color.c   |    69 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_color.h   |     8 +-
 .../display/amdgpu_dm/amdgpu_dm_connector.c   |  3581 +++++
 .../display/amdgpu_dm/amdgpu_dm_connector.h   |   162 +
 .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    |    14 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_crtc.h    |     6 +
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c |    69 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_dmub.c    |   934 ++
 .../amd/display/amdgpu_dm/amdgpu_dm_dmub.h    |    68 +
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |    64 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.h |    20 +
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c |  1511 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h |    27 +
 .../amdgpu_dm/amdgpu_dm_kunit_helpers.h       |     1 +
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |   145 +-
 .../display/amdgpu_dm/amdgpu_dm_mst_types.h   |    12 +
 .../amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c  |   234 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_pp_smu.h  |    22 +
 .../amd/display/amdgpu_dm/amdgpu_dm_quirks.c  |     2 +
 .../display/amdgpu_dm/amdgpu_dm_services.c    |     7 +
 .../drm/amd/display/amdgpu_dm/tests/Makefile  |    11 +
 .../amdgpu_dm/tests/amdgpu_dm_audio_test.c    |   490 +
 .../tests/amdgpu_dm_backlight_test.c          |  1128 ++
 .../amdgpu_dm/tests/amdgpu_dm_color_test.c    |    64 +-
 .../tests/amdgpu_dm_connector_test.c          |  2142 +++
 .../amdgpu_dm/tests/amdgpu_dm_crtc_test.c     |   532 +
 .../amdgpu_dm/tests/amdgpu_dm_dmub_test.c     |   600 +
 .../amdgpu_dm/tests/amdgpu_dm_helpers_test.c  |   645 +
 .../amdgpu_dm/tests/amdgpu_dm_irq_test.c      |   934 ++
 .../tests/amdgpu_dm_mst_types_test.c          |   385 +
 .../amdgpu_dm/tests/amdgpu_dm_pp_smu_test.c   |   736 +
 .../amdgpu_dm/tests/amdgpu_dm_quirks_test.c   |   103 +
 .../amdgpu_dm/tests/amdgpu_dm_services_test.c |   313 +
 .../display/amdgpu_dm/tests/amdgpu_dm_test.c  |   929 ++
 drivers/gpu/drm/amd/display/dc/core/dc.c      |   287 +-
 .../drm/amd/display/dc/core/dc_hw_sequencer.c |    20 +-
 .../gpu/drm/amd/display/dc/core/dc_surface.c  |    44 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |   227 +-
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h  |     1 +
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |    29 +
 drivers/gpu/drm/amd/display/dc/dc_types.h     |    66 +-
 .../drm/amd/display/dc/dml/calcs/dcn_calcs.c  |     2 +-
 .../dml21/inc/bounding_boxes/dcn42b_soc_bb.h  |     2 +-
 .../dml21/src/dml2_core/dml2_core_factory.c   |     2 -
 .../src/dml2_core/dml2_core_shared_types.h    |     2 -
 .../src/inc/dml2_internal_shared_types.h      |     1 -
 .../amd/display/dc/hubp/dcn401/dcn401_hubp.c  |     2 +-
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c |     8 +-
 .../amd/display/dc/hwss/dce60/dce60_hwseq.c   |     8 +-
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   |    62 +-
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   |    76 +-
 .../amd/display/dc/hwss/dcn201/dcn201_hwseq.c |     2 +-
 .../amd/display/dc/hwss/dcn30/dcn30_hwseq.c   |    10 +-
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.c   |    33 +-
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |   244 +-
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.h |     2 +-
 .../amd/display/dc/hwss/dcn42/dcn42_hwseq.c   |   318 +-
 .../amd/display/dc/hwss/dcn42/dcn42_hwseq.h   |     5 +-
 .../display/dc/hwss/hw_sequencer_private.h    |     3 +-
 .../gpu/drm/amd/display/dc/inc/hw/clk_mgr.h   |     4 +
 drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h  |     2 +-
 .../display/dc/inc/soc_and_ip_translator.h    |    14 -
 .../dc/link/protocols/link_dp_capability.c    |     6 +-
 .../dc/resource/dcn42b/dcn42b_resource.c      |     2 +-
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |   178 +-
 .../amd/display/include/ddc_service_types.h   |     1 +
 73 files changed, 20422 insertions(+), 10425 deletions(-)  create mode 100=
644 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_audio.c
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_audio.h
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlig=
ht.c
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_backlig=
ht.h
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connect=
or.c
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connect=
or.h
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.c
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_dmub.h
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers=
.h
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_a=
udio_test.c
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_b=
acklight_test.c
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_c=
onnector_test.c
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_c=
rtc_test.c
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_d=
mub_test.c
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_h=
elpers_test.c
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_i=
rq_test.c
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_q=
uirks_test.c
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_s=
ervices_test.c
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_t=
est.c

--
2.43.0

