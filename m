Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20074C55822
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Aug 2026 13:24:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7EC7510E700;
	Tue,  4 Aug 2026 13:24:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tx4JpkNl";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010018.outbound.protection.outlook.com [52.101.201.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0C7D10E700
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Aug 2026 13:24:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qut0xPaFt4VfaLYvHah+6yOexFCkDVOAcyAHq2SQYaQ8/HrifvlIulrk4v7xcfceCcgkiKJkg7NlEuWJMvP0Bz4jj3o98Gw+XZVuDG2893yBYJF9dQ4Z6m+WeKWiR7MxIoIl5ES8OaNSTDVvERa00l+NEbnvjCQhYkV+XcJ8J6EBnhT8YMx2aUibmjYomoMF1ZohTar/lX75XK9DGd5+3K/RJlmbPXEfuaIFd0PaNrjE40t3rMBnvWAbEBx5rO56WWKd/vknoNV26W7ByuuqlWsf7gGFktis7IsJMj6KJFEI6SZZF0HvPf7ZzsGjyU8ObNltQhE3epAki8y3AimF7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ekvpn/paS23AVk3/3Xm1f0YHAU6G8yBtuv/dbZ7SHrk=;
 b=QN0muihRjylVArjmzZWFIt1ZeR48dPs3LxSSDTBFYjajSG+8mZ/D/Fpl05MawbE/R19PxAhK+8HtAZZwy/Y+h4th8sojpv1q2JGZn0KR3AbOKz6VOFDXYqlkfb6905t6+Qvmx/toS6TsezOmhWxD0vGPoS/twxMLiCohsqH6LLIssHNwd+MY9w6MB3eh36piTCzUcC0W6Zww2zQZXVDOi7+XxGoOq8UkVR7e6Ce4UMEGyyDUfT9pw+0dMbIVnwMuYmSxViRr2QdEMDqOlcCdzY8+3EhyNIroK2p4eeJ73LreqK2nqZ+9/kGLa/aoe0pWe3PuSuIRWc1QMOES+LzNkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ekvpn/paS23AVk3/3Xm1f0YHAU6G8yBtuv/dbZ7SHrk=;
 b=tx4JpkNl0ge6KrakBEMKOeRNAGIieZOIUa8DJdXEc4Ml9kl4Qw8b4+8pTVofg6geu7AoSgxwVm3AOqGlVKidxEfiUNFbCRW0CFFU2Hn6xAey8TPEcHGvnNIPQedMRPKh5+D8j/73Hb7SyONsZ5mefWCGJ2jXCD8HdSKcxKWlAXw=
Received: from DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) by
 DM4PR12MB6278.namprd12.prod.outlook.com (2603:10b6:8:a4::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.18; Tue, 4 Aug 2026 13:24:14 +0000
Received: from DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::b2e1:64e5:3b9e:738a]) by DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::b2e1:64e5:3b9e:738a%6]) with mapi id 15.21.0270.017; Tue, 4 Aug 2026
 13:24:14 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Li, Roman" <Roman.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Wentland, Harry" <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)"
 <Sunpeng.Li@amd.com>, "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>, "Li,
 Roman" <Roman.Li@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>, "Chung,
 ChiaHsuan (Tom)" <ChiaHsuan.Chung@amd.com>, "Zuo, Jerry" <Jerry.Zuo@amd.com>, 
 "Wu, Ray" <Ray.Wu@amd.com>, "LIPSKI, IVAN" <IVAN.LIPSKI@amd.com>, "Hung,
 Alex" <Alex.Hung@amd.com>, "Lin, Ping Lei" <PingLei.Lin@amd.com>, "Chen,
 Chen-Yu" <Chen-Yu.Chen@amd.com>, "Li, Roman" <Roman.Li@amd.com>
Subject: RE: [PATCH 00/41] DC Patches July 31, 2026
Thread-Topic: [PATCH 00/41] DC Patches July 31, 2026
Thread-Index: AQHdITGgQrEOGds9vUKdCmOH25bWLraN5ong
Date: Tue, 4 Aug 2026 13:24:14 +0000
Message-ID: <DS0PR12MB6534DBC2062ABCED50A622A79CD42@DS0PR12MB6534.namprd12.prod.outlook.com>
References: <20260731211302.3040343-1-Roman.Li@amd.com>
In-Reply-To: <20260731211302.3040343-1-Roman.Li@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Enabled=True;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SetDate=2026-08-04T13:24:07.0000000Z;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Name=AMD Public
 v26; MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_ContentBits=3;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6534:EE_|DM4PR12MB6278:EE_
x-ms-office365-filtering-correlation-id: 84e0bfd7-ce62-4509-164f-08def22badac
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|38070700021|6133799003|10067099003|11063799006|56012099006|22082099003|18002099003|3023799007;
x-microsoft-antispam-message-info: Uc8rGcjdPtodAXJlM41KkCIT0hv+0ZV8AL/J9MWrfnAeoOvJwC5EoNlM3jpfh7JcY/7g9EYv76t4fY/fz7Zwz2Z9AiNdK1d1Ap5Ey69GL05TWiJMcFbujuEZT/xnpIHWkC7i3NoLPrwqsHO8kRcmPSuAH6luXkjTmQxjdXhGZExzsj9T/gP1qtqnNypHA5PKHr2x4P/M76fElbJGnfROd5zgRaXQvoGZ0DAaHuvixmaz/wPRLWBhpiXgRKsIf/1br/VPVMfgYAtfVq/29QQR2iqTDioww9fqFN8FknXFvzUkK6cZUewNM3CPJktjy6bv++XWLLy6lhVzrFj8qWOEZFdVru4e/ZeGK+5tGe0iJ1LMF4Mr8wwNh4gRGznfGSzRMUd2d3ON8x+YlE3lTNcFrJftAHjmROyfkNiWH9MUeKhrkpGbUZnm2cjti9DcrVB9cw6hSOpQW8L3AfK744nJaudrJz9eaa/7ogURl36Oy2iJQpgXkK0iyrqhWYcIRPKy1iSjn7wEVFxt8u1RrV2g9Wxzg783Dsz/tgD2LoH9BCa5mVxydMtjgcLvjhZ7z49sNfwIts/eLCitgGecUkHw2EmsyMCiCzV+ZJCrp1BkrOYN7beAtNoTsIfThCWMBQ39z4DVqfuCePVIkXVyeMy7sV7M1VLSdV20/b88uL95mVpzPVnPNVtV+zQTaTcSjn0g5TT2EdZyC541C9K6ws6Q9MCGWGBSv70SaWsx4+4gWyo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6534.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(38070700021)(6133799003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?jIg70j41QZwH2Z+3Pc6SzcO6vBa3XW6SvlT6k+UUixEItZRHmjyY6IPbRE?=
 =?iso-8859-1?Q?6OU1br9s58rIHg9IHObSevR+PX5xQD2uQ+Ib3mVn2bllxB69UVMv3d1DGQ?=
 =?iso-8859-1?Q?J1aLvw7uCubK5dGfNKcuz0OZtVq7dxUoQSQQGHNVcqdfkaNz/Z0cyusMc9?=
 =?iso-8859-1?Q?V/zcOURyzzBy3DlTrwqNpUsRxhwNzjqQOdxzv6H1kxapJG5ATFIRoB64H9?=
 =?iso-8859-1?Q?3gAz13jLuVY4/1C3sCyxwCh1dDDgfeW9acCLTdMZq35dLDJBt1wqkzcslW?=
 =?iso-8859-1?Q?insj6m4tlkQ05KXVHmRQASetlY1a7L85N52tto92Ycy3K7baFDGeTnq5Tl?=
 =?iso-8859-1?Q?5xL1AgDusR9zdRrfte9kZHepwuKa1sjW7BXB5et3dpb7uAKyjykvVW3gwH?=
 =?iso-8859-1?Q?hDMjjmM0grGmeLSKF8wSUm5Le58RsbdNhSGrVN/emi8J7FMo0Xmq6jYxf0?=
 =?iso-8859-1?Q?OrkxYj5FQEmNpu8+uhauDYIt9V0ec0PchnSFgEmlHzpfW1uESK7r/jOf0i?=
 =?iso-8859-1?Q?ln1XUtDAmOuT+8YNnCcUVwiTLpjgxXjdNIeJJZbsy+jRfxj0RjKC15aUOV?=
 =?iso-8859-1?Q?V7v2ievXkOIymHQxGCDFfMRX79CmUtNRq6SbRDQe5bcI24+hQ/0lUWkTw4?=
 =?iso-8859-1?Q?1GQTgVwMStpWIHtJ6yFHTjqXEyvDb0eoSVsBsFcFkH2fSGEC4zBO+s4v3N?=
 =?iso-8859-1?Q?oOLsdM5iNWrz0nf5mZ+zmOaU7B1NL/L1XlJSo+o2UUvfP98m5PleabyeeC?=
 =?iso-8859-1?Q?z+JZ+JfR3K+50DSPaBaL9gr40Km1/upQhtORX5xySY7Qkg9gWBbhtUUSjA?=
 =?iso-8859-1?Q?TzOmA9E80Mm9c8KMkRrvYuvof41eXMB96EPtdxhEzNs5YC6pwOn99FaIKw?=
 =?iso-8859-1?Q?Fq8jvGxYxMmccQAcPY3jVLB16WtO1DG9ESDpDi0mfhqMC7Q3nbSo5EKiBk?=
 =?iso-8859-1?Q?SRjlQDCuM6OYmmdMwtNoAHiFn0wN7xtD0xfacCFQQdOQmLDB5mltpe7Wl0?=
 =?iso-8859-1?Q?tYRi29xYrg9p1vwkMcE+O1/ciFUPMD51dT/LbbXhVneuP2tNcNDQi4nwne?=
 =?iso-8859-1?Q?GLUMjOERNWPYDjesu0QpIQM3CHu4r4G0PrmeoLzU5vIGGfAM+1SJ/Bihh4?=
 =?iso-8859-1?Q?9QOq5RLmHF1Own093IISYCxKWqrftE8SjGqiiYSKazj5I20wWdzBoIJxTr?=
 =?iso-8859-1?Q?uade+LoUiQy+RabdyEMD7oBWwDpRawALSCUTwKM7V/pHWYrv397Rr8jQoS?=
 =?iso-8859-1?Q?Jnc30LTUi7RH97dg5C6c+4L6Ulbq6zsIFr4kqloxANYRvSNPQPPXSIFalo?=
 =?iso-8859-1?Q?vjQ/RwV2mqVMVjPhkSEB9FzkH/E+B1VMvCZXJ7Elmjy5SJSQqTAKM9trsY?=
 =?iso-8859-1?Q?2Wqgxf+9FE5J/4xIJQA2jZKsPr/UuQT471jAoZs2WfXwS/CPfxqvc/VRrc?=
 =?iso-8859-1?Q?pDu0lKE2BDk5K23GZZYbpfTqAkvM3Z+bLRtOFA8ebtOvjDz5fl/ZNF+3er?=
 =?iso-8859-1?Q?D78VKpmZQ0M/qhYhODiqNNWm0FUMmbYvnH0pxYVNEEVecchsXKc9yNHst/?=
 =?iso-8859-1?Q?zTbAgucuZMxy6tHYsrQZ9i26NXmXgVoot2Web3vUoXs6LYepLLDHoFcjDs?=
 =?iso-8859-1?Q?2qRFSj72tql88zkhy9q9hhDrBzEfgtuU35nmPEYDkMP/e4uqNQ0YrnyRRQ?=
 =?iso-8859-1?Q?/k1NkUY3c6va5JTuzuU3sid3VoWeHs9vPmQEdnv26l3qJGK7Rb3/nBp3Uh?=
 =?iso-8859-1?Q?EkJFh+lG6B3nezYuyWtNBqwwGbopUOL5BmEh4uIfIMNgMl?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84e0bfd7-ce62-4509-164f-08def22badac
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2026 13:24:14.3851 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vFYJdxkhAlpkoH70PQ35aOOJil0uV5gYeg/U+oVW3fagpXPbSITTP9yEouXMpZ5pTBLrKXff2le9a0U87HzJuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6278
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


The patchset consists of the amd-staging-drm-next branch (Head commit - 76e=
667ef60446d435b869360961888cca1500cb6 -> drm/amd/display: use proper contex=
t for logging) with new patches added on top of it.

Tested on Ubuntu 26.04.1, on Gnome Wayland.

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
From: Roman.Li@amd.com <Roman.Li@amd.com>
Sent: Friday, July 31, 2026 5:12 PM
To: amd-gfx@lists.freedesktop.org
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.L=
i@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>; Li, Roman <Roman.=
Li@amd.com>; Lin, Wayne <Wayne.Lin@amd.com>; Chung, ChiaHsuan (Tom) <ChiaHs=
uan.Chung@amd.com>; Zuo, Jerry <Jerry.Zuo@amd.com>; Wheeler, Daniel <Daniel=
.Wheeler@amd.com>; Wu, Ray <Ray.Wu@amd.com>; LIPSKI, IVAN <IVAN.LIPSKI@amd.=
com>; Hung, Alex <Alex.Hung@amd.com>; Lin, Ping Lei <PingLei.Lin@amd.com>; =
Chen, Chen-Yu <Chen-Yu.Chen@amd.com>; Li, Roman <Roman.Li@amd.com>
Subject: [PATCH 00/41] DC Patches July 31, 2026

From: Roman Li <Roman.Li@amd.com>

This DC patchset brings improvements in multiple areas. In summary, we high=
light:
 - Add KUnit tests for crtc functions
 - Enable DCN6
 - Fix ABM, CRC engine, MCM, writeback issues
 - Refactor stream validation.

Cc: Dan Wheeler <daniel.wheeler@amd.com>

Alex Hung (2):
  drm/amd/display: Fix wb_info leak and NULL deref in writeback
  drm/amd/display: Fix more KUnit connector use-after-free bugs

Alvin Lee (1):
  drm/amd/display: Update BW bounding box unconditionally for DCN6

Aurabindo Pillai (5):
  drm/amd: Add DCN6 register headers
  drm/amd/display: Add new sources for DCN6
  drm/amd/display: Enable DCN6 init
  drm/amd/display: Dependent changes for DCN6
  drm/amd/display: Enable DCN6 sources compilation

Bhawanpreet Lakha (12):
  drm/amd/display: Add KUnit tests for more crtc functions
  drm/amd/display: Add vblank handling tests for crtc
  drm/amd/display: Add idle worker tests for crtc
  drm/amd/display: Add active plane count tests for crtc
  drm/amd/display: Add KUnit test for crtc vblank event completion
  drm/amd/display: Add KUnit tests for crtc set_vupdate_irq
  drm/amd/display: Add KUnit tests for crtc set_static_screen_optimze
  drm/amd/display: Add KUnit tests for crtc set_vblank
  drm/amd/display: Cover crtc set_vblank workqueue branch
  drm/amd/display: Cover crtc vblank IPS self-refresh restore
  drm/amd/display: Cover crtc vblank restore replay-supported path
  drm/amd/display: Cover crtc destroy_state stream release

Charlene Liu (1):
  drm/amd/display: Ensure dtbclk is enabled

Fangzhi Zuo (1):
  drm/amd/display: Gate HDMI FRL status polling on active FRL link rate

Harry VanZyllDeJong (1):
  drm/amd/display: Update VRR info packet to support 12-bit refresh
    rates

Harry Wentland (2):
  drm/amd/display: Resize MST HDCP per-connector arrays to 32
  drm/amd/display: Bounds-check connector->index in dm_dp_mst_get_modes

Iswara Nagulendran (1):
  drm/amd/display: Fix ABM over VABC

Ivan Lipski (3):
  drm/amd/display: Refactor stream validation
  drm/amd/display: Unify force_yuv debugfs into force_yuv_pixel_format
  drm/amd/display: Align connector KUnit tests with stream validation
    refactor

Karthi Kandasamy (1):
  drm/amd/display: Fix seamless mode switch not triggering for HDR to
    SDR transition

Matthew Stewart (1):
  drm/amd/display: Add missing DCN42B register defines

Rafal Ostrowski (1):
  drm/amd/display: Migrate color manager HW and fix MCM blend LUT issues

Relja Vojvodic (2):
  drm/amd/display: switch max FFE level cap based on FRL link rate
  drm/amd/display: Add FFE level defaults

Roman Li (1):
  drm/amd/display: Remove duplicate in tests/Makefile

Sung-huai Wang (1):
  drm/amd/display: Increase fclk change latency on dcn351

Taimur Hassan (2):
  drm/amd/display: Add missing DMUB CACP and PR definitions
  drm/amd/display: Promote DC to 3.2.392

Wayne Lin (3):
  drm/amd/display: Add missing OTG_CRC1_SELECT mask for DCN3.2
  drm/amd/display: Fix CRC engine 1 enable/disable on DCN3.1.2+
  drm/amd/display: Configure all CRC engines in pipe CRC source path

 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |     1 +
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |    31 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |     2 -
 .../amd/display/amdgpu_dm/amdgpu_dm_audio.h   |     2 +-
 .../display/amdgpu_dm/amdgpu_dm_connector.c   |   289 +-
 .../display/amdgpu_dm/amdgpu_dm_connector.h   |     8 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c |    13 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    |    25 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_crtc.h    |     9 +
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c |    57 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_dmub.c    |    10 +
 .../amd/display/amdgpu_dm/amdgpu_dm_dmub.h    |     1 +
 .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.c    |    10 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.h    |    10 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |     6 +
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |     3 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_plane.c   |     9 +-
 .../drm/amd/display/amdgpu_dm/tests/Makefile  |     1 -
 .../tests/amdgpu_dm_connector_test.c          |   163 +-
 .../amdgpu_dm/tests/amdgpu_dm_crtc_test.c     |  1436 +
 .../amdgpu_dm/tests/amdgpu_dm_kunit_helpers.c |    29 +
 .../tests/amdgpu_dm_kunit_test_helpers.h      |     3 +
 .../display/dc/bios/command_table_helper2.c   |     1 +
 .../gpu/drm/amd/display/dc/clk_mgr/Makefile   |     9 +
 .../gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c  |    15 +
 .../display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c  |    28 +-
 .../display/dc/clk_mgr/dcn42/dcn42_clk_mgr.h  |     1 +
 .../drm/amd/display/dc/clk_mgr/dcn60/dalsmc.h |   389 +
 .../display/dc/clk_mgr/dcn60/dcn60_clk_mgr.c  |  1673 +
 .../display/dc/clk_mgr/dcn60/dcn60_clk_mgr.h  |   150 +
 .../dc/clk_mgr/dcn60/dcn60_clk_mgr_smu_msg.c  |   369 +
 .../dc/clk_mgr/dcn60/dcn60_clk_mgr_smu_msg.h  |    35 +
 drivers/gpu/drm/amd/display/dc/core/dc.c      |    76 +-
 .../drm/amd/display/dc/core/dc_hw_sequencer.c |   428 +
 .../gpu/drm/amd/display/dc/core/dc_resource.c |    47 +
 .../gpu/drm/amd/display/dc/core/dc_state.c    |    12 +
 .../gpu/drm/amd/display/dc/core/dc_stream.c   |    27 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |    41 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |    44 +
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h  |    23 +
 drivers/gpu/drm/amd/display/dc/dc_helper.c    |     2 +
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h  |    53 +-
 .../gpu/drm/amd/display/dc/dc_spl_translate.c |    32 +-
 .../gpu/drm/amd/display/dc/dc_state_priv.h    |     1 +
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |     5 +
 drivers/gpu/drm/amd/display/dc/dc_types.h     |    13 +-
 drivers/gpu/drm/amd/display/dc/dccg/Makefile  |     8 +
 .../amd/display/dc/dccg/dcn20/dcn20_dccg.h    |    10 +
 .../amd/display/dc/dccg/dcn60/dcn60_dccg.c    |   187 +
 .../amd/display/dc/dccg/dcn60/dcn60_dccg.h    |   182 +
 .../drm/amd/display/dc/dce/dce_clock_source.c |    28 +
 .../drm/amd/display/dc/dce/dce_clock_source.h |     9 +
 drivers/gpu/drm/amd/display/dc/dio/Makefile   |     8 +
 .../display/dc/dio/dcn10/dcn10_link_encoder.h |    16 +
 .../dc/dio/dcn401/dcn401_dio_link_encoder.c   |    15 +
 .../dc/dio/dcn401/dcn401_dio_link_encoder.h   |    10 +
 .../dc/dio/dcn60/dcn60_dio_link_encoder.c     |   373 +
 .../dc/dio/dcn60/dcn60_dio_link_encoder.h     |    43 +
 .../dc/dio/dcn60/dcn60_dio_stream_encoder.c   |   538 +
 .../dc/dio/dcn60/dcn60_dio_stream_encoder.h   |   181 +
 drivers/gpu/drm/amd/display/dc/dm_helpers.h   |     8 +
 .../amd/display/dc/dml/dcn351/dcn351_fpu.c    |     4 +-
 .../gpu/drm/amd/display/dc/dml2_0/Makefile    |    25 +
 .../dml2_0/dml21/dml21_translation_helper.c   |    57 +-
 .../amd/display/dc/dml2_0/dml21/dml21_utils.c |   129 +-
 .../dml21/inc/bounding_boxes/dcn5_soc_bb.h    |    36 +
 .../dml21/inc/bounding_boxes/dcn6_soc_bb.h    |   229 +
 .../bounding_boxes/utm_qos_model_dchub_v1.h   |   109 +
 .../bounding_boxes/utm_qos_model_dchub_v2.h   |   122 +
 .../bounding_boxes/utm_qos_model_dchub_v3.h   |    53 +
 .../inc/bounding_boxes/utm_qos_model_types.h  |    51 +
 .../dc/dml2_0/dml21/inc/dml_dmub_cmd.h        |   502 +
 .../dml21/inc/dml_top_display_cfg_types.h     |    10 +
 .../dml21/inc/dml_top_soc_parameter_types.h   |     2 +
 .../dc/dml2_0/dml21/inc/dml_top_types.h       |    45 +
 .../dml2_0/dml21/src/dml2_cga/dml2_cga_dcn6.c |   152 +
 .../dml2_0/dml21/src/dml2_cga/dml2_cga_dcn6.h |     9 +
 .../dml21/src/dml2_cga/dml2_cga_factory.c     |    38 +
 .../dml21/src/dml2_cga/dml2_cga_factory.h     |     9 +
 .../dml2_core_calcs_dsc_shared_types.h        |    32 +
 .../src/dml2_core/dml2_core_dcn4_calcs.c      |     1 +
 .../dml2_core/dml2_core_dcn5_calcs_dchub.c    |  5893 ++
 .../dml2_core/dml2_core_dcn5_calcs_dchub.h    |   426 +
 .../dml2_core_dcn5_calcs_display_pipe.c       |  1029 +
 .../dml2_core_dcn5_calcs_display_pipe.h       |   151 +
 .../dml2_core_dcn5_calcs_dsc_latency.c        |   501 +
 .../dml2_core_dcn5_calcs_dsc_latency.h        |    23 +
 .../dml2_core_dcn5_funcs_initialize.c         |    78 +
 .../dml2_core_dcn5_funcs_initialize.h         |    12 +
 .../dml2_core_dcn5_funcs_mode_programming.c   |  1791 +
 .../dml2_core_dcn5_funcs_mode_programming.h   |    11 +
 .../dml2_core_dcn5_funcs_mode_support.c       |  2957 +
 .../dml2_core_dcn5_funcs_mode_support.h       |    11 +
 .../src/dml2_core/dml2_core_dcn6_calcs.c      |    11 +
 .../src/dml2_core/dml2_core_dcn6_calcs.h      |     8 +
 .../dml2_core/dml2_core_dcn6_calcs_dchub.c    |  1951 +
 .../dml2_core/dml2_core_dcn6_calcs_dchub.h    |   101 +
 .../dml2_core_dcn6_funcs_initialize.c         |   165 +
 .../dml2_core_dcn6_funcs_initialize.h         |    12 +
 .../dml2_core_dcn6_funcs_mode_programming.c   |  1389 +
 .../dml2_core_dcn6_funcs_mode_programming.h   |    11 +
 .../dml2_core_dcn6_funcs_mode_support.c       |  4277 ++
 .../dml2_core_dcn6_funcs_mode_support.h       |    11 +
 .../dml21/src/dml2_core/dml2_core_factory.c   |    25 +
 .../src/dml2_core/dml2_core_shared_types.h    |   160 +
 .../dml21/src/dml2_dpmm/dml2_dpmm_dcn4.c      |     1 -
 .../dml21/src/dml2_dpmm/dml2_dpmm_dcn5.c      |   449 +
 .../dml21/src/dml2_dpmm/dml2_dpmm_dcn5.h      |    19 +
 .../dml21/src/dml2_dpmm/dml2_dpmm_factory.c   |    12 +
 .../dml21/src/dml2_mcg/dml2_mcg_factory.c     |     5 +
 .../dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c  |    57 +
 .../dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn5.c |   522 +
 .../dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn5.h |    21 +
 .../dml2_pmo/dml2_pmo_dcn5_stage_optimizers.c |  2228 +
 .../dml2_pmo/dml2_pmo_dcn5_stage_optimizers.h |    97 +
 .../dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn6.c |   506 +
 .../dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn6.h |    22 +
 .../dml2_pmo/dml2_pmo_dcn6_stage_optimizers.c |  1789 +
 .../dml2_pmo/dml2_pmo_dcn6_stage_optimizers.h |    17 +
 .../dml21/src/dml2_pmo/dml2_pmo_factory.c     |    34 +
 .../alternate_pstate_shared_lib.c             |  1078 +
 .../alternate_pstate_shared_lib.h             |   109 +
 .../dml21/src/dml2_top/dml2_top_interfaces.c  |     7 +
 .../dml2_0/dml21/src/dml2_top/dml2_top_utm.c  |   394 +
 .../dml2_0/dml21/src/dml2_top/dml2_top_utm.h  |     9 +
 .../dml2_utm_soc_bb/dml2_utm_soc_bb_dcn5.c    |   144 +
 .../dml2_utm_soc_bb/dml2_utm_soc_bb_dcn5.h    |    11 +
 .../dml2_utm_soc_bb/dml2_utm_soc_bb_dcn6.c    |   405 +
 .../dml2_utm_soc_bb/dml2_utm_soc_bb_dcn6.h    |    12 +
 .../dml2_utm_soc_bb/dml2_utm_soc_bb_factory.c |    29 +
 .../dml2_utm_soc_bb/dml2_utm_soc_bb_factory.h |    11 +
 .../src/inc/dml2_internal_shared_types.h      |   485 +
 .../drm/amd/display/dc/dml2_0/dml2_wrapper.h  |     8 +
 drivers/gpu/drm/amd/display/dc/dpp/Makefile   |    17 +
 .../amd/display/dc/dpp/dcn401/dcn401_dpp.h    |    41 +
 .../display/dc/dpp/dcn401/dcn401_dpp_dscl.c   |    26 +-
 .../drm/amd/display/dc/dpp/dcn42/dcn42_dpp.c  |     7 +-
 .../drm/amd/display/dc/dpp/dcn42/dcn42_dpp.h  |     6 +
 .../drm/amd/display/dc/dpp/dcn50/dcn50_dpp.c  |   391 +
 .../drm/amd/display/dc/dpp/dcn50/dcn50_dpp.h  |    86 +
 .../drm/amd/display/dc/dpp/dcn60/dcn60_dpp.c  |   346 +
 .../drm/amd/display/dc/dpp/dcn60/dcn60_dpp.h  |   525 +
 .../amd/display/dc/dpp/dcn60/dcn60_dpp_dscl.c |   315 +
 drivers/gpu/drm/amd/display/dc/dsc/Makefile   |     7 +
 .../drm/amd/display/dc/dsc/dcn60/dcn60_dsc.c  |   447 +
 .../drm/amd/display/dc/dsc/dcn60/dcn60_dsc.h  |   248 +
 drivers/gpu/drm/amd/display/dc/gpio/Makefile  |    10 +
 .../display/dc/gpio/dcn60/hw_factory_dcn60.c  |   228 +
 .../display/dc/gpio/dcn60/hw_factory_dcn60.h  |    11 +
 .../dc/gpio/dcn60/hw_translate_dcn60.c        |   168 +
 .../dc/gpio/dcn60/hw_translate_dcn60.h        |    13 +
 .../gpu/drm/amd/display/dc/gpio/ddc_regs.h    |    15 +
 drivers/gpu/drm/amd/display/dc/gpio/hw_ddc.c  |   302 +
 drivers/gpu/drm/amd/display/dc/gpio/hw_ddc.h  |    28 +
 .../gpu/drm/amd/display/dc/gpio/hw_factory.c  |     4 +
 .../drm/amd/display/dc/gpio/hw_translate.c    |     4 +
 .../gpu/drm/amd/display/dc/hdcp/hdcp_msg.c    |     9 +
 drivers/gpu/drm/amd/display/dc/hpo/Makefile   |     8 +
 .../hpo/dcn31/dcn31_hpo_dp_stream_encoder.h   |    47 -
 .../dc/hpo/dcn60/dcn60_hpo_frl_link_encoder.c |   114 +
 .../dc/hpo/dcn60/dcn60_hpo_frl_link_encoder.h |    18 +
 .../hpo/dcn60/dcn60_hpo_frl_stream_encoder.c  |   358 +
 .../hpo/dcn60/dcn60_hpo_frl_stream_encoder.h  |    32 +
 .../gpu/drm/amd/display/dc/hubbub/Makefile    |     8 +
 .../display/dc/hubbub/dcn10/dcn10_hubbub.h    |   108 +
 .../display/dc/hubbub/dcn60/dcn60_hubbub.c    |  1816 +
 .../display/dc/hubbub/dcn60/dcn60_hubbub.h    |   207 +
 drivers/gpu/drm/amd/display/dc/hubp/Makefile  |    16 +
 .../amd/display/dc/hubp/dcn20/dcn20_hubp.h    |    29 +
 .../amd/display/dc/hubp/dcn401/dcn401_hubp.c  |   201 +-
 .../amd/display/dc/hubp/dcn401/dcn401_hubp.h  |    23 +-
 .../amd/display/dc/hubp/dcn42/dcn42_hubp.c    |    78 +-
 .../amd/display/dc/hubp/dcn42/dcn42_hubp.h    |    10 +-
 .../amd/display/dc/hubp/dcn50/dcn50_hubp.c    |   532 +
 .../amd/display/dc/hubp/dcn50/dcn50_hubp.h    |    48 +
 .../amd/display/dc/hubp/dcn60/dcn60_hubp.c    |   472 +
 .../amd/display/dc/hubp/dcn60/dcn60_hubp.h    |   272 +
 drivers/gpu/drm/amd/display/dc/hwss/Makefile  |    16 +
 .../drm/amd/display/dc/hwss/dce/dce_hwseq.h   |     9 +
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c |    21 +-
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   |     3 +-
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   |     3 +-
 .../amd/display/dc/hwss/dcn30/dcn30_hwseq.c   |     3 +-
 .../amd/display/dc/hwss/dcn31/dcn31_hwseq.c   |    21 +-
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.c   |     5 +-
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   |     8 +-
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |   483 +-
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.h |     7 +-
 .../amd/display/dc/hwss/dcn401/dcn401_init.c  |     1 -
 .../amd/display/dc/hwss/dcn42/dcn42_hwseq.c   |   488 +-
 .../amd/display/dc/hwss/dcn42/dcn42_hwseq.h   |     6 -
 .../amd/display/dc/hwss/dcn42/dcn42_init.c    |     2 -
 .../amd/display/dc/hwss/dcn50/dcn50_hwseq.c   |   759 +
 .../amd/display/dc/hwss/dcn50/dcn50_hwseq.h   |    32 +
 .../amd/display/dc/hwss/dcn60/dcn60_hwseq.c   |  1164 +
 .../amd/display/dc/hwss/dcn60/dcn60_hwseq.h   |    32 +
 .../amd/display/dc/hwss/dcn60/dcn60_init.c    |   181 +
 .../amd/display/dc/hwss/dcn60/dcn60_init.h    |    12 +
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |    19 +-
 .../display/dc/hwss/hw_sequencer_private.h    |     5 -
 .../gpu/drm/amd/display/dc/inc/core_types.h   |     1 +
 .../gpu/drm/amd/display/dc/inc/hw/clk_mgr.h   |     1 +
 .../amd/display/dc/inc/hw/clk_mgr_internal.h  |    22 +
 .../amd/display/dc/inc/hw/cursor_reg_cache.h  |     3 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h   |     7 +
 drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h  |    35 +-
 .../drm/amd/display/dc/inc/hw/link_encoder.h  |     6 +
 drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h   |    81 +-
 .../gpu/drm/amd/display/dc/inc/hw/transform.h |     1 +
 drivers/gpu/drm/amd/display/dc/inc/resource.h |     2 +
 drivers/gpu/drm/amd/display/dc/irq/Makefile   |     9 +
 .../display/dc/irq/dcn60/irq_service_dcn60.c  |   417 +
 .../display/dc/irq/dcn60/irq_service_dcn60.h  |    12 +
 .../drm/amd/display/dc/link/link_detection.c  |    29 +
 .../drm/amd/display/dc/link/link_factory.c    |     5 +
 .../amd/display/dc/link/protocols/link_ddc.c  |     8 +
 .../display/dc/link/protocols/link_hdmi_frl.c |    23 +-
 drivers/gpu/drm/amd/display/dc/mpc/Makefile   |     8 +
 .../amd/display/dc/mpc/dcn401/dcn401_mpc.c    |   177 +-
 .../amd/display/dc/mpc/dcn401/dcn401_mpc.h    |    25 +-
 .../drm/amd/display/dc/mpc/dcn42/dcn42_mpc.c  |   405 +-
 .../drm/amd/display/dc/mpc/dcn42/dcn42_mpc.h  |    55 +-
 .../drm/amd/display/dc/mpc/dcn60/dcn60_mpc.c  |   330 +
 .../drm/amd/display/dc/mpc/dcn60/dcn60_mpc.h  |   472 +
 drivers/gpu/drm/amd/display/dc/opp/Makefile   |     8 +
 .../drm/amd/display/dc/opp/dcn60/dcn60_opp.c  |    25 +
 .../drm/amd/display/dc/opp/dcn60/dcn60_opp.h  |    64 +
 drivers/gpu/drm/amd/display/dc/optc/Makefile  |     9 +
 .../amd/display/dc/optc/dcn10/dcn10_optc.c    |    36 +-
 .../amd/display/dc/optc/dcn10/dcn10_optc.h    |     3 +-
 .../amd/display/dc/optc/dcn31/dcn31_optc.h    |     4 +
 .../amd/display/dc/optc/dcn314/dcn314_optc.h  |     1 +
 .../amd/display/dc/optc/dcn32/dcn32_optc.h    |     2 +
 .../amd/display/dc/optc/dcn35/dcn35_optc.c    |    26 +-
 .../amd/display/dc/optc/dcn401/dcn401_optc.h  |     1 +
 .../amd/display/dc/optc/dcn42/dcn42_optc.c    |     9 +-
 .../amd/display/dc/optc/dcn42/dcn42_optc.h    |     4 +
 .../amd/display/dc/optc/dcn60/dcn60_optc.c    |   107 +
 .../amd/display/dc/optc/dcn60/dcn60_optc.h    |   178 +
 .../gpu/drm/amd/display/dc/resource/Makefile  |    10 +
 .../dc/resource/dcn10/dcn10_resource.c        |     1 +
 .../dc/resource/dcn20/dcn20_resource.c        |     1 +
 .../dc/resource/dcn201/dcn201_resource.c      |     1 +
 .../dc/resource/dcn21/dcn21_resource.c        |     1 +
 .../dc/resource/dcn30/dcn30_resource.c        |     2 +
 .../dc/resource/dcn301/dcn301_resource.c      |     1 +
 .../dc/resource/dcn302/dcn302_resource.c      |     2 +
 .../dc/resource/dcn303/dcn303_resource.c      |     2 +
 .../dc/resource/dcn31/dcn31_resource.c        |     1 +
 .../dc/resource/dcn314/dcn314_resource.c      |     2 +
 .../dc/resource/dcn315/dcn315_resource.c      |     6 +-
 .../dc/resource/dcn316/dcn316_resource.c      |     5 +-
 .../dc/resource/dcn32/dcn32_resource.c        |     2 +
 .../dc/resource/dcn321/dcn321_resource.c      |     2 +
 .../dc/resource/dcn35/dcn35_resource.c        |     2 +
 .../dc/resource/dcn351/dcn351_resource.c      |     2 +
 .../dc/resource/dcn36/dcn36_resource.c        |     2 +
 .../dc/resource/dcn401/dcn401_resource.c      |    34 +-
 .../dc/resource/dcn401/dcn401_resource.h      |     4 +
 .../dc/resource/dcn42/dcn42_resource.c        |     3 +
 .../dc/resource/dcn42b/dcn42b_resource.c      |    20 +-
 .../dc/resource/dcn60/dcn60_resource.c        |  2377 +
 .../dc/resource/dcn60/dcn60_resource.h        |   676 +
 .../display/dc/soc_and_ip_translator/Makefile |     3 +
 .../dcn60/dcn60_soc_and_ip_translator.c       |   117 +
 .../dcn60/dcn60_soc_and_ip_translator.h       |    16 +
 .../soc_and_ip_translator.c                   |     4 +
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |     5 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |   229 +-
 drivers/gpu/drm/amd/display/dmub/src/Makefile |     1 +
 .../gpu/drm/amd/display/dmub/src/dmub_dcn60.c |   732 +
 .../gpu/drm/amd/display/dmub/src/dmub_dcn60.h |   303 +
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   |    52 +
 .../gpu/drm/amd/display/include/dal_asic_id.h |    18 +
 .../gpu/drm/amd/display/include/dal_types.h   |     1 +
 .../amd/display/modules/freesync/freesync.c   |     8 +-
 .../drm/amd/display/modules/power/power_abm.c |   215 +-
 .../amd/display/modules/power/power_helpers.h |     9 +
 .../drm/amd/display/modules/power/power_psr.c |     7 +
 .../amd/display/modules/power/power_replay.c  |     7 +
 .../include/asic_reg/dcn/dcn_6_0_0_offset.h   | 15799 +++++
 .../include/asic_reg/dcn/dcn_6_0_0_sh_mask.h  | 58556 ++++++++++++++++
 .../include/asic_reg/dpcs/dpcs_6_0_0_offset.h |    47 +
 .../asic_reg/dpcs/dpcs_6_0_0_sh_mask.h        |    55 +
 .../asic_reg/mmhub/mmhub_5_0_1_offset.h       |    17 +
 .../asic_reg/mmhub/mmhub_5_0_1_sh_mask.h      |    17 +
 286 files changed, 129427 insertions(+), 1800 deletions(-)  create mode 10=
0644 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dalsmc.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dcn60_clk_=
mgr.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dcn60_clk_=
mgr.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dcn60_clk_=
mgr_smu_msg.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn60/dcn60_clk_=
mgr_smu_msg.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dccg/dcn60/dcn60_dccg.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dccg/dcn60/dcn60_dccg.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dio/dcn60/dcn60_dio_link=
_encoder.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dio/dcn60/dcn60_dio_link=
_encoder.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dio/dcn60/dcn60_dio_stre=
am_encoder.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dio/dcn60/dcn60_dio_stre=
am_encoder.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/boundin=
g_boxes/dcn5_soc_bb.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/boundin=
g_boxes/dcn6_soc_bb.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/boundin=
g_boxes/utm_qos_model_dchub_v1.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/boundin=
g_boxes/utm_qos_model_dchub_v2.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/boundin=
g_boxes/utm_qos_model_dchub_v3.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/boundin=
g_boxes/utm_qos_model_types.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_dmu=
b_cmd.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_cg=
a/dml2_cga_dcn6.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_cg=
a/dml2_cga_dcn6.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_cg=
a/dml2_cga_factory.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_cg=
a/dml2_cga_factory.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_co=
re/dml2_core_calcs_dsc_shared_types.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_co=
re/dml2_core_dcn5_calcs_dchub.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_co=
re/dml2_core_dcn5_calcs_dchub.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_co=
re/dml2_core_dcn5_calcs_display_pipe.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_co=
re/dml2_core_dcn5_calcs_display_pipe.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_co=
re/dml2_core_dcn5_calcs_dsc_latency.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_co=
re/dml2_core_dcn5_calcs_dsc_latency.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_co=
re/dml2_core_dcn5_funcs_initialize.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_co=
re/dml2_core_dcn5_funcs_initialize.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_co=
re/dml2_core_dcn5_funcs_mode_programming.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_co=
re/dml2_core_dcn5_funcs_mode_programming.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_co=
re/dml2_core_dcn5_funcs_mode_support.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_co=
re/dml2_core_dcn5_funcs_mode_support.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_co=
re/dml2_core_dcn6_calcs.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_co=
re/dml2_core_dcn6_calcs.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_co=
re/dml2_core_dcn6_calcs_dchub.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_co=
re/dml2_core_dcn6_calcs_dchub.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_co=
re/dml2_core_dcn6_funcs_initialize.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_co=
re/dml2_core_dcn6_funcs_initialize.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_co=
re/dml2_core_dcn6_funcs_mode_programming.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_co=
re/dml2_core_dcn6_funcs_mode_programming.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_co=
re/dml2_core_dcn6_funcs_mode_support.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_co=
re/dml2_core_dcn6_funcs_mode_support.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_dp=
mm/dml2_dpmm_dcn5.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_dp=
mm/dml2_dpmm_dcn5.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pm=
o/dml2_pmo_dcn5.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pm=
o/dml2_pmo_dcn5.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pm=
o/dml2_pmo_dcn5_stage_optimizers.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pm=
o/dml2_pmo_dcn5_stage_optimizers.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pm=
o/dml2_pmo_dcn6.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pm=
o/dml2_pmo_dcn6.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pm=
o/dml2_pmo_dcn6_stage_optimizers.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pm=
o/dml2_pmo_dcn6_stage_optimizers.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_st=
andalone_libraries/alternate_pstate_shared_lib.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_st=
andalone_libraries/alternate_pstate_shared_lib.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_to=
p/dml2_top_utm.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_to=
p/dml2_top_utm.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_ut=
m_soc_bb/dml2_utm_soc_bb_dcn5.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_ut=
m_soc_bb/dml2_utm_soc_bb_dcn5.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_ut=
m_soc_bb/dml2_utm_soc_bb_dcn6.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_ut=
m_soc_bb/dml2_utm_soc_bb_dcn6.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_ut=
m_soc_bb/dml2_utm_soc_bb_factory.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_ut=
m_soc_bb/dml2_utm_soc_bb_factory.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dpp/dcn50/dcn50_dpp.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dpp/dcn50/dcn50_dpp.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dpp/dcn60/dcn60_dpp.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dpp/dcn60/dcn60_dpp.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dpp/dcn60/dcn60_dpp_dscl=
.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dsc/dcn60/dcn60_dsc.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dsc/dcn60/dcn60_dsc.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/gpio/dcn60/hw_factory_dc=
n60.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/gpio/dcn60/hw_factory_dc=
n60.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/gpio/dcn60/hw_translate_=
dcn60.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/gpio/dcn60/hw_translate_=
dcn60.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/hpo/dcn60/dcn60_hpo_frl_=
link_encoder.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/hpo/dcn60/dcn60_hpo_frl_=
link_encoder.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/hpo/dcn60/dcn60_hpo_frl_=
stream_encoder.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/hpo/dcn60/dcn60_hpo_frl_=
stream_encoder.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/hubbub/dcn60/dcn60_hubbu=
b.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/hubbub/dcn60/dcn60_hubbu=
b.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/hubp/dcn50/dcn50_hubp.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/hubp/dcn50/dcn50_hubp.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/hubp/dcn60/dcn60_hubp.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/hubp/dcn60/dcn60_hubp.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/hwss/dcn50/dcn50_hwseq.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/hwss/dcn50/dcn50_hwseq.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/hwss/dcn60/dcn60_hwseq.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/hwss/dcn60/dcn60_hwseq.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/hwss/dcn60/dcn60_init.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/hwss/dcn60/dcn60_init.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/irq/dcn60/irq_service_dc=
n60.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/irq/dcn60/irq_service_dc=
n60.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/mpc/dcn60/dcn60_mpc.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/mpc/dcn60/dcn60_mpc.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/opp/dcn60/dcn60_opp.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/opp/dcn60/dcn60_opp.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/optc/dcn60/dcn60_optc.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/optc/dcn60/dcn60_optc.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/resource/dcn60/dcn60_res=
ource.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/resource/dcn60/dcn60_res=
ource.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/dc=
n60/dcn60_soc_and_ip_translator.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/soc_and_ip_translator/dc=
n60/dcn60_soc_and_ip_translator.h
 create mode 100644 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn60.c
 create mode 100644 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn60.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_6_0_0_offs=
et.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_6_0_0_sh_m=
ask.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/dpcs/dpcs_6_0_0_of=
fset.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/dpcs/dpcs_6_0_0_sh=
_mask.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/mmhub/mmhub_5_0_1_=
offset.h
 create mode 100644 drivers/gpu/drm/amd/include/asic_reg/mmhub/mmhub_5_0_1_=
sh_mask.h

--
2.34.1

