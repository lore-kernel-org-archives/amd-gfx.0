Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39445C83F17
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Jul 2025 13:12:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C7E2F10E506;
	Mon, 28 Jul 2025 13:12:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bVlvVwwP";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2068.outbound.protection.outlook.com [40.107.212.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 69F0E10E502
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Jul 2025 13:12:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z71wRn+y01VbBlgbxZ5md/DYD0PhEbmX7BLLh5WOt3IX47tk77CAeOupfJBIGfv8/4sr/pv8qFaxxEiB4jCLYM5BDfEXOK6dwGgDiwnUaJTSizJiN1Ix12WkmsLKPt3ww5D4+kpSneIdLltURtNye5O7AehO9S6rHKMJmxyKK3aR1nk/NJPGKiRlQn8I6/+LNcL1dqzhoHZRjO1qScEh1CU1+WP2VKRV6cglwwk/jBZnoGbNi/NYbajh1d0ZjoBcQS7tV6V3Z11t7bcpS1/jlHXONEvsP4P921gx06yyly7i1uQu7si4MlbMgnGuIYx9FxI8gV0Fc6gPqX3PEluLBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hqMf/DzPzTDPGU3mKurd2EV26dguKKFTSrtCR4TQOao=;
 b=j4DyCpLAGvHx/IHcAgq30usxjhKJzQr69akSgl9pEoKasJITip+SGmmgHkFfb/pyBOMNpVI1wsBH5T+exm9KST0EojroCqtCIYx//qCnzkLwHaVgIWn8xNHRN1IOL4OVko99X+7oDGb7Pf0smB0aFC3eYiEDhvfw0AN/FwGtYa489sAQh2SiOk8PxRuNlWtsbQYInfk1j3zMqzVufxqlD7FCvAaT4fKfvClu4ul69txc35zh9c7uuEt4eNG3afARK7MfH4MMydyiouNsM1uRcJ4kuJP8Nx6To/R11GC67TiEOFeDwgD7rC0pACuC5TX2AraMhxAOOd74urD6xS5olQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hqMf/DzPzTDPGU3mKurd2EV26dguKKFTSrtCR4TQOao=;
 b=bVlvVwwPPc5tIURRyMWtUAzGoRwoqnQT6uXS/VqdgTRlp/olMD0lw+O5CowzBpqp1M5OHf2xBdjMyUacrkuiQ/H+5KvD0tCFAJVwgNF1mi/i+DaYmTvumhmCvYfDZTT1XkQhIp1PppZy4A7x2KhvyuEc+aBI+sIxdInwIOqlPkc=
Received: from DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) by
 CY5PR12MB6345.namprd12.prod.outlook.com (2603:10b6:930:22::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8964.27; Mon, 28 Jul 2025 13:12:41 +0000
Received: from DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::ea87:74ba:36ec:8cf6]) by DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::ea87:74ba:36ec:8cf6%4]) with mapi id 15.20.8964.024; Mon, 28 Jul 2025
 13:12:40 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "LIPSKI, IVAN" <IVAN.LIPSKI@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Wentland, Harry" <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)"
 <Sunpeng.Li@amd.com>, "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>, "Li,
 Roman" <Roman.Li@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>, "Chung,
 ChiaHsuan (Tom)" <ChiaHsuan.Chung@amd.com>, "Zuo, Jerry" <Jerry.Zuo@amd.com>, 
 "Wu, Ray" <Ray.Wu@amd.com>, "Hung, Alex" <Alex.Hung@amd.com>, "LIPSKI, IVAN"
 <IVAN.LIPSKI@amd.com>
Subject: RE: [PATCH 00/25] DC Patches July 21, 2025
Thread-Topic: [PATCH 00/25] DC Patches July 21, 2025
Thread-Index: AQHb+1l2Gww/ZikEx0ifJs1axSqq3rRHiydQ
Date: Mon, 28 Jul 2025 13:12:40 +0000
Message-ID: <DS0PR12MB6534935FA4C162266EF11AA59C5AA@DS0PR12MB6534.namprd12.prod.outlook.com>
References: <20250722223911.2655505-1-IVAN.LIPSKI@amd.com>
In-Reply-To: <20250722223911.2655505-1-IVAN.LIPSKI@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-07-28T13:12:35.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6534:EE_|CY5PR12MB6345:EE_
x-ms-office365-filtering-correlation-id: cf942e99-f445-4d58-02d2-08ddcdd86e99
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?xOaaZhp1Crl0+Xgjvv6Nj9nqJSFYaCrpiVTz+Adya6pGL2dIiBmTMaDd8L1X?=
 =?us-ascii?Q?WFp6IPQ1QbryN2H2g0NpKb2IqhWQaTBI80+fF+u9CUY8i31NilLLZ/XkhMwW?=
 =?us-ascii?Q?jCRueX+ic7MzcM2DOVsCvlIPcAwG3FbFo/1aBjCeoKd6tnJ8NGlYsxBapFh+?=
 =?us-ascii?Q?zROy0rYm8uqNcXe2mhgA5Bk4sqrZy9+Rqi/DbqnJrsEYEYZ6bgCy/MGvrfjL?=
 =?us-ascii?Q?1bMml1EEdl8gBqZrmtYgBCTo3nz6PNGQMTd9rxZlm+OLqbAYc/5lwfITM/4/?=
 =?us-ascii?Q?Et42j1QrY4OEVdii2G7ihyYo3+1qDLaQnD7n+/UOuiMWx9+PHgM2gMcL2SR4?=
 =?us-ascii?Q?SlJznUkEXuDGrddji6T9MPwHorxNVLSH2emnZv7w3J3/ARvJ/NSB7t+gT3Ai?=
 =?us-ascii?Q?AjxwN40Y0VszH16/q6+jnIXUElYYNb7MapKTc7I90VwtEgXo9dqdP+vr+Iy3?=
 =?us-ascii?Q?gC0xX5nMRbMxklAsQeDt+Oitj69Pv6Wma8C230RIaxoS1pAx63cSLfbdoCPa?=
 =?us-ascii?Q?6pmrROYxalAT12orkKYogoZDg2B7AOE9Hhz4xhO0pbWbTsi60pcKHwqMRWlC?=
 =?us-ascii?Q?QquMLx3qPasuXBkzxIizpCEIIlFYw0Hg7R7EHKrHwYnRqYqHNmrNSNljlEVX?=
 =?us-ascii?Q?tthQrySv4UyWQJAplV6iRWilPTSVpu3+Hb5SqMl0qmAZKiAbErmhCkb5jAiz?=
 =?us-ascii?Q?AhlXVFh+XRwdhpeOHaIcmwt7+5pjwirqSg1wdvvpjQ7XwrHM63cSmzj8c/K5?=
 =?us-ascii?Q?Xi+yDreZigaxB+p6EFqkOr/fFtQvtHMft/MXoQzML5Lx24XWNtdkVCcp0d9z?=
 =?us-ascii?Q?jenjw0SghYQGR6m+F0Jc1Pm2fnQV9l2hpzoFhKVpnj7MJuJdTtDd658/fGfc?=
 =?us-ascii?Q?ATvuHFbUcgzgVbBk7GOpXTcWsRQtKSxxc284IWbMOM/3u/q6L8sKnHn7Fhxc?=
 =?us-ascii?Q?+tb4W8xGPAWnaUE+crUJ4vr2yRil82yIMIsEkEbQmOoWf/YDAorqmF2X/wbg?=
 =?us-ascii?Q?vxe/KJLBDY5PuY++sLkXIzekDbhf3FZEMdj39h7XgLOkg4z3mZvoq+dETALw?=
 =?us-ascii?Q?tMgcalJ4PkRRdKFc4KJS+hfTZYzgsnHIVa57wEIIq3+xI0o2H9f8hwa1Alx7?=
 =?us-ascii?Q?8NxDXHDGT38OlHRB+dqaf4s+nFTqaYbx6G7tQWgLPtncGxEMwPwMMC6ngNtx?=
 =?us-ascii?Q?mj+uUY8Sl/54eseglT0Z1n+gGGMl+da8cOKmyjy1s20TlXHlVg4yzZ1XeKIS?=
 =?us-ascii?Q?sAr6mv4wjonLIyMXCmlBNlIq4MIgUL8ST8AnfmvJKE0G38L+h2iiG3r/Kb1s?=
 =?us-ascii?Q?JH5WTv9yhNdxQnSBumP5wQm2dN9pRJM1nR+G27BWaCh+mlKNz0EE4lusZtaQ?=
 =?us-ascii?Q?Toxbb1Q0h70ckJ8GMmtn4CPJ4pYRAtKbPvP+agnKNCDKRpdcPX9zKsWmtRgF?=
 =?us-ascii?Q?ElRDvfLgcfKiTYawr/Mw/+Sj+22AdYjPnlyeitYg/j5jBXd390cXqw=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6534.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?feh+5esGYiA2HFPyqmyIbCkCANiRYaIfhbiY/ENnJY6fco1Rv2s2Tvc2t1FE?=
 =?us-ascii?Q?wbXx+3sm1cHSt7YW7VAnFaMeMNWmh3PzrlEm9a2bhgYO7iO2Q1TrzQXEUUBx?=
 =?us-ascii?Q?JP5sg0T7pvZhWcvk49PEuY/fYqkTGquSVj0x5G120kDZWyt/2pO/gA6V3GzM?=
 =?us-ascii?Q?VV/70iyJaltxZOI+FwlN5nDTEiQ1nQ6tz/yNq5xj4yc3j0UT0LdslBiDgf9m?=
 =?us-ascii?Q?/RBzu4KBAm19X+g6izePX+y5wvG7gbOAW3Eo7wB4UcposFg+/QBqgQEZBYa1?=
 =?us-ascii?Q?3uQ13HRMyWnGVRJ3PwHckI2bp4jJ+Hg0RR6ngioLoKmhvE1n6xin57wuDXYh?=
 =?us-ascii?Q?MtnAX9XzUIPx91n85Bsal7x9ul3KaziwrQ5je945sGXbJdMhx+mu0ESlVQE6?=
 =?us-ascii?Q?IFbjHAmk4KsTedYKzkTOwT2/sc1uzYXEsFpBRdGPqHfaU8S24DQQeJWLFT86?=
 =?us-ascii?Q?FgSFCh+hqaWbEkqmWTlwRWWmhib4LIcd/bg2tSsKivovNP7P4WjIp4EVXm6C?=
 =?us-ascii?Q?mAbYJZn+Y6W7NlTmjGOS6G4hObgnCU7tb2AH+Z5XvlLLGu2Zm855+zOyqq+b?=
 =?us-ascii?Q?dRNdUHV1GhdT32islsJ2QVMkoVXlbi1BzFnoQVr0jnHFlFnecdrWOBG4l7Rx?=
 =?us-ascii?Q?mW5wYp8QoG8KSdfUo3CfkZjV/oskeGF3nxNoxOQY5aA0VKnEIaPEPYB/x1wQ?=
 =?us-ascii?Q?2BZtU6+Ir/itevPhDl+pATkLT4JdRLh/6WMozvXkGVwCuwg9NiZwejmiSBI8?=
 =?us-ascii?Q?q0qJxV7nG07/M70T7ek96UlX/teGV9hcQHWMipLRBiD/y4xdAvpCcJKiOJ5l?=
 =?us-ascii?Q?P+xDoi+e4zcGO6iKbjCkPhdPk5nL0XFYRZRp4FdUOOUAmRznTMYPiZiKcbVe?=
 =?us-ascii?Q?epMOesMK11xf2xcEi3jFh5zxnffonaANZ5DB9XaeajUEhf3AUmNR9ETHa0x8?=
 =?us-ascii?Q?2yZ6CSwAYocT3UuubwfIK+6fF7L3j1bAv90KlEyGIddd3ppkxrBBYnAqqhK2?=
 =?us-ascii?Q?wGujk0h+04CTn8D71X5QaNAO0yw78BSSg5Gm7+OzdI51zwR8V0sLMwNzAbWT?=
 =?us-ascii?Q?SLUKKyORXMT7qGp5GVHlvhYG8seho7mMKT8QBa3s3PHu3u2fby6NPMjrYgNi?=
 =?us-ascii?Q?3ijx2yhx05MPiwDO1IxfV5eM9IpcpGOPrphMKtobgf28RWCVKBofWQp+gH+k?=
 =?us-ascii?Q?MfAt1Jr+dKTq6h8fDhC1wnLZu4UKbaCj8vmA3BrJO9AvmPEyKzgimTE2bsec?=
 =?us-ascii?Q?i600mC18um9nbs7zQHKD5xxM1hSXWPpdbYaRXixlqG5VsdBL/YHRV7avcDBA?=
 =?us-ascii?Q?1Fjh/cSaVNDdMOFXCov2he+ZXkwJsg1k6NyXyopCatKBHPmg1xxlA1ZlNRZt?=
 =?us-ascii?Q?efPViH4nlfrTXRACWxzbIzlxVsJAWBZfJDe0ZclkjKvBJeEECkBTHTgRmJg5?=
 =?us-ascii?Q?7yJpXfK6vzd4G9kEvzYiLPBlTdGq5f+lzIpyXKp3IPRHxx1DrlNfy4ZxsOnR?=
 =?us-ascii?Q?w3nJjFcyW366PdwN+78DbGnl02m8OgZt9LH2GEkN6HStG4DVCOhksV04axRb?=
 =?us-ascii?Q?cIQ+fKXukgOb0KSdkNE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf942e99-f445-4d58-02d2-08ddcdd86e99
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2025 13:12:40.7997 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NwfelM1ghzf3WN2TsJbnlVkcfyVG4SzrwewSpbHAyct9MwnWIDjv2djGIHHRp3uhmFx4InDEOYn2xdcIYXSSvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6345
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

Good morning  all,

This week this patchset was tested on 4 systems, two dGPU and two APU based=
, and tested across multiple display and connection types.

APU
        * Single Display eDP -> 1080p 60hz, 1920x1200 165hz
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

The patchset consists of the amd-staging-drm-next branch (Head commit - b8a=
dc31cc0ca120cd3ab23d2b98ef9f99e4b5132 -> drm/amdgpu: Avoid extra evict-rest=
ore process) with new patches added on top of it.

Tested on Ubuntu 24.04.3, on Wayland and X11, using KDE Plasma and Gnome.

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
From: IVAN.LIPSKI@amd.com <IVAN.LIPSKI@amd.com>
Sent: Tuesday, July 22, 2025 6:36 PM
To: amd-gfx@lists.freedesktop.org
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.L=
i@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>; Li, Roman <Roman.=
Li@amd.com>; Lin, Wayne <Wayne.Lin@amd.com>; Chung, ChiaHsuan (Tom) <ChiaHs=
uan.Chung@amd.com>; Zuo, Jerry <Jerry.Zuo@amd.com>; Wheeler, Daniel <Daniel=
.Wheeler@amd.com>; Wu, Ray <Ray.Wu@amd.com>; Hung, Alex <Alex.Hung@amd.com>=
; LIPSKI, IVAN <IVAN.LIPSKI@amd.com>
Subject: [PATCH 00/25] DC Patches July 21, 2025

From: Ivan Lipski <ivan.lipski@amd.com>

This DC patchset brings improvements in multiple areas. In summary, we high=
light:

* Fixes on DCN314 and DCN301
* Fixes on DMUB command alignment
* Addition of debugfs for Replay, and debug option for BW allocation mode
* Refactor of amdgpu_dm code

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Alvin Lee (1):
  drm/amd/display: Add comma to last entry of enum for consistency

Chiang, Richard (1):
  drm/amd/display: Remove update_planes_and_stream_v1 sequence

Cruise Hung (2):
  drm/amd/display: Remove check DPIA HPD status for BW Allocation
  drm/amd/display: Add debug option to control BW Allocation mode

Duncan Ma (1):
  drm/amd/display: Add eDP AUXless ALPM

Ivan Lipski (1):
  drm/amd/display: Allow DCN301 to clear update flags

Jingwen Zhu (1):
  drm/amd/display: Add a config flag for limited_pll_vco

Karthi Kandasamy (1):
  drm/amd/display: Add DC EDID read policy struct

Mario Limonciello (8):
  drm/amd/display: Add missing SPDX license identifier
  drm/amd/display: Drop unused include
  drm/amd/display: Remove unnecessary whitespace
  drm/amd/display: Remove unnecessary includes
  drm/amd/display: Avoid configuring PSR granularity if PSR-SU not
    supported
  drm/amd/display: Only finalize atomic_obj if it was initialized
  drm/amd/display: Rename dcn31 string shown to user
  drm/amd/display: Pass up errors for reset GPU that fails to init HW

Michael Strauss (3):
  drm/amd/display: Move setup_stream_attribute
  drm/amd/display: Increase AUX Intra-Hop Done Max Wait Duration
  drm/amd/display: Cache streams targeting link when performing LT
    automation

Ovidiu Bunea (2):
  drm/amd/display: Revert "Add a config flag for limited_pll_vco"
  drm/amd/display: Fix dmub_cmd header alignment

Ray Wu (1):
  drm/amd/display: Add Replay residency in debugfs

Relja Vojvodic (1):
  drm/amd/display: Allow for sharing of some link and audio link
    functions

Roman Li (1):
  drm/amd/display: Disable dsc_power_gate for dcn314 by default

Taimur Hassan (1):
  drm/amd/display: Promote DAL to 3.2.343

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  27 ++--
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   1 +
 .../amd/display/amdgpu_dm/amdgpu_dm_color.c   |   2 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c |   1 +
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_crc.h |   1 +
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c |  35 ++++-
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.h |   1 +
 .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.c    |   1 +
 .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.h    |   1 +
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |   1 +
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_irq.c |   1 +
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_irq.h |   1 +
 .../display/amdgpu_dm/amdgpu_dm_irq_params.h  |   1 +
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |   1 +
 .../display/amdgpu_dm/amdgpu_dm_mst_types.h   |   1 +
 .../amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c  |   1 +
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c |   8 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_psr.h |   1 +
 .../amd/display/amdgpu_dm/amdgpu_dm_replay.c  |   1 +
 .../amd/display/amdgpu_dm/amdgpu_dm_replay.h  |   1 +
 .../display/amdgpu_dm/amdgpu_dm_services.c    |   1 +
 .../amd/display/amdgpu_dm/amdgpu_dm_trace.h   |   1 +
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 132 +-----------------
 .../drm/amd/display/dc/core/dc_link_exports.c |   7 +
 drivers/gpu/drm/amd/display/dc/dc.h           |  16 ++-
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h  |  16 ++-
 drivers/gpu/drm/amd/display/dc/dc_helper.c    |   2 +-
 drivers/gpu/drm/amd/display/dc/dc_types.h     |  14 ++
 .../gpu/drm/amd/display/dc/dce/dmub_replay.c  |  13 ++
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c |   7 +-
 .../amd/display/dc/hwss/dce110/dce110_hwseq.h |   7 +
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   |   2 +
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |   2 +
 .../gpu/drm/amd/display/dc/inc/core_types.h   |   2 +-
 drivers/gpu/drm/amd/display/dc/inc/link.h     |   5 +-
 .../display/dc/link/accessories/link_dp_cts.c |  17 ++-
 .../gpu/drm/amd/display/dc/link/link_dpms.c   |   3 -
 .../drm/amd/display/dc/link/link_factory.c    |   2 +
 .../drm/amd/display/dc/link/link_validation.c |   6 +-
 .../dc/link/protocols/link_dp_capability.c    |  37 +++++
 .../dc/link/protocols/link_dp_capability.h    |   6 +
 .../dc/link/protocols/link_dp_dpia_bw.c       |  65 ++++-----
 .../dc/link/protocols/link_dp_training.c      |   9 +-
 .../link/protocols/link_edp_panel_control.c   |   8 +-
 .../dc/resource/dcn314/dcn314_resource.c      |   1 +
 .../dc/virtual/virtual_stream_encoder.c       |   7 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  20 +--
 47 files changed, 281 insertions(+), 215 deletions(-)

--
2.43.0

