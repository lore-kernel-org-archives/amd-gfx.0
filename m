Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84479CA9ED2
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Oct 2026 13:08:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1998A10F717;
	Tue, 13 Oct 2026 13:08:46 +0000 (UTC)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011045.outbound.protection.outlook.com [52.101.52.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6E9810E830
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Oct 2026 13:08:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tDsIFipaDT/U9U4q6zQDWKSKh7khaDJ3livfUB1wY9lSoKxz0RWdpGNpjAz+lofHIPQCq5XTUU8t7oOCYUXzDmM9lVNCuUhgGaF6lqudUuLg0zhR0cuWlMtm9ngcNUFlmGmpMvT5s0/sx9iY/yn0mQZ6LzBjLSHP3bJlt2Jtt+8zef9yWoXKVzSuMbvhkqbdEgU84vP2pbgJY4Pk0Q/whWBWZHk//sU6uIyenUbBG8mJvFfeOC77uhY9HU3qTQpGsQWF743c1i4kizFldxwXOW6pNs4f1QT55+enek+YpVZQAXp1op+5chjpr5s7NmHlz42sbSpU02/fHSJsChv69g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mynkBmQHdY8Z5F53Qjm1WIUMm1+aIJpKvEF5q2wfztQ=;
 b=be5WjQXF1o+kjyMeElES6dHPJwWcGhOx7XCFfmoT6FHMrN7H4E3OYYEhAkzP5bS0jAMWYAhvGH+eDWeXvV0Ok50pmK2n3kaykObwwKrMc5fmbHyxPWTTMkNc6fvLXuZtv0Lu86Y2+HlUK36k4gg2GSIcxjCFr6w64v9H+aL7sJDdqPHjkEKKu+F65VYxjm6uNmXQ8Z23jFM/ONVRQ6IvSf9Q1TVQ9Yjz+YjjcSJtB6aApjaaPHQg52iiMx1duvk4zHLAYr3WjYF4/rJneXl38Q5/xEOM6GIP5HtZYlqE6UX8H0NHTLvQo089yLGRUsq8rliRzW5oq9+wl8TBLBS05w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mynkBmQHdY8Z5F53Qjm1WIUMm1+aIJpKvEF5q2wfztQ=;
 b=T1iMCpf54DkfPshNh6PemXaWWFSQBUpiEtrDfc1DDcIWLMRsdIzRKZJHdTjrObDTTCbsEW1YEvIY2dGYmC2gVuMA6t24kVQUZKvM/WOxiv9x2a/veme+3zN9m5emJfLZnb4QNS93Y3EfR4bh2GyCN+SH1GSxlMPYZ6weJJi0H1Y=
Received: from CY5PR12MB6527.namprd12.prod.outlook.com (2603:10b6:930:30::13)
 by PH7PR12MB7968.namprd12.prod.outlook.com (2603:10b6:510:272::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.18; Tue, 13 Oct
 2026 13:08:35 +0000
Received: from CY5PR12MB6527.namprd12.prod.outlook.com
 ([fe80::325b:6e02:14e4:9092]) by CY5PR12MB6527.namprd12.prod.outlook.com
 ([fe80::325b:6e02:14e4:9092%7]) with mapi id 15.21.0496.021; Tue, 13 Oct 2026
 13:08:35 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "LIPSKI, IVAN" <IVAN.LIPSKI@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Wentland, Harry" <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)"
 <Sunpeng.Li@amd.com>, "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>, "Li,
 Roman" <Roman.Li@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>, "Chung,
 ChiaHsuan (Tom)" <ChiaHsuan.Chung@amd.com>, "Zuo, Jerry" <Jerry.Zuo@amd.com>, 
 "Wu, Ray" <Ray.Wu@amd.com>, "LIPSKI, IVAN" <IVAN.LIPSKI@amd.com>, "Hung,
 Alex" <Alex.Hung@amd.com>, "Lin, Ping Lei" <PingLei.Lin@amd.com>, "Chen,
 Chen-Yu" <Chen-Yu.Chen@amd.com>
Subject: RE: [PATCH 00/19] DC Patches October 5, 2026
Thread-Topic: [PATCH 00/19] DC Patches October 5, 2026
Thread-Index: AQHdVn3nFe/VC2SKMU6buCEaI9erp7b7enwg
Date: Tue, 13 Oct 2026 13:08:34 +0000
Message-ID: <CY5PR12MB6527841E54F8341FF4D506E99C9E2@CY5PR12MB6527.namprd12.prod.outlook.com>
References: <20261007170412.1898315-1-ivan.lipski@amd.com>
In-Reply-To: <20261007170412.1898315-1-ivan.lipski@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Enabled=True;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SetDate=2026-10-13T13:08:02.0000000Z;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Name=AMD Public
 v26; MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_ContentBits=3;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Method=Privileged
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY5PR12MB6527:EE_|PH7PR12MB7968:EE_
x-ms-office365-filtering-correlation-id: 09855d04-396c-4a21-480e-08df292b16ae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|6133799003|22082099003|18002099003|10067099003|261009223027099003|11063799006|56012099006|38070700021;
x-microsoft-antispam-message-info: 3g6CGVw0wFJ3gbKkVPHhtpZvZ2l2QjNa7yHEXjdcnDZlRJA6FFRENwrvZ965Rvs9qlpCXNmIJSh1NehQ+l3zNqDTLgMQo2yfkTOPrfRq/lANRrXMEdVb5/pFUL4seGC3nhZOykfxAzX9nmM8Ipx5gcjDXMwgTud86EZe0Ot45q/phT7vA/BwO6RBLiYTGc7+XbS0uBIuiLm2lQP5z8bG+0vsvRiCWvrkmJZwy5mEsCruWMCUDBmNl3X0d+JIqMopnj7wH58og9k/QPjLFpoIef7YiF6u/f/XaMFFXV/+6XtqkQk1vrfGTOov82AWgNTZFSW2z7CFJj5EBY54S2wW0v1PPTYm5iQCMIu5ozATFAO0c6skmkRu9gMApJWcTMyNepFSIh4lEyJp9bxNzCB1SCZTRmT3GZN/qUk50gGA0YTFO2i/zEf6tgGKjj16r+WyXAz5s8HBXhkAp+he9SWYKoNtaHdOkB/oPVvx3q3w7gXzy1GXKG3lmYiWWiFtnQsh1M1DkP1hjKc+fRDmZY/V32V/MosjJRc/keZnKl8sI7ZwKGtto+AW+44LvWovlL0bwtBWO/wydORhK1AaG1xvjwEfvuU1aBhwTfTJ0mMudKVihoS5uCtX6VWe9UqbDYHa5ZQROH9kO/oBV7GmWErVgGP89TwWa5W4kMj9+90EhO0tlIjex8bkXEpv/L8x3MNJOW5i3VgNsEeCxxDOKBhR0g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY5PR12MB6527.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(6133799003)(22082099003)(18002099003)(10067099003)(261009223027099003)(11063799006)(56012099006)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?gbvLkxsVN7H3QqMHXE8y2gTPYdjX7OqAp5mtxsxtGOdMtHvuqicQuiGCz+?=
 =?iso-8859-1?Q?O24J/CdRbQB0TwmkzrWE4k/Ki7INBnWqUsu4peX9JyWWFxCD/Tdyg+W5oV?=
 =?iso-8859-1?Q?iqTDG0ehCrFvQVZDMivDmMcu0iwApkPEzjJFnjcWDm/pu14zPVPcGexo91?=
 =?iso-8859-1?Q?6wLTLI+Df0gT00YtRbM5Zl7yFsPecP7iUE8sI54POjyK5YIt2625yVrc0+?=
 =?iso-8859-1?Q?ggxt+MqjF5dMtAiNl+DcQowPDzdZnsEgIVc83DktNpVqC/Sm2r8sYgVA83?=
 =?iso-8859-1?Q?cUlsY8zCGLYEXwnAyCucm0CERwdVuvzl10SryVp12RbqKAeeG+4naDswc4?=
 =?iso-8859-1?Q?RRXGgv9WSH483xOKgLNeD3eXDfOoWIlvTBKwiM42W/3NE4aGR9qK/QAzVD?=
 =?iso-8859-1?Q?mdo7BcXoJe9wkKUsKOUblvbruWQ/YpdNvM9n08qHAOOFiGrz1+8X8lV6Cb?=
 =?iso-8859-1?Q?7iWvk3CfQkbQ2Yw5RyjkJytR5M/xN/Njc2rzHVv3u3bEQ502SVqZVowFhO?=
 =?iso-8859-1?Q?uGGJ2QFskuHYJGUw1M6kYGFLwSPW6HEmUceyJu6VtjnM9Q8Epu/ZxYj5tW?=
 =?iso-8859-1?Q?5c29Xhj508ctSYh210NpN0a5HGeD9/8HjOxkWtvXSt5PhZkTpC24q4bqEP?=
 =?iso-8859-1?Q?4VleLtLjIy5VYpwyyLPrDcWNf9uMtdfqc+iIVTRSK+BeqQk3IIdidElnzJ?=
 =?iso-8859-1?Q?3lJuMVTP5wHvbQqbzKKcw2k8mUMjAVD9G5zLZVY/bNb55pVJJxaFTIwV8v?=
 =?iso-8859-1?Q?unp/NjsOx83t3a5NiEWCVqw6yAIGT/pSo0ob51LQXDJZkC2HqONUgg8JDX?=
 =?iso-8859-1?Q?qf9IJXQxSUtGsoRUisHDuGRkjx2MQcGkXf4yzNPietnmKVoMi5+tlkKr/t?=
 =?iso-8859-1?Q?VLggBf9kiWVfgOav+iTCn7bSM08CIyKfV5HeNOp5UBv5PS2wgaBaKRagDK?=
 =?iso-8859-1?Q?8k62+R5X4na7haMpIuVKUfIges1IIIVKh/mNFWf5P5E2USZZ71zPy1kAe6?=
 =?iso-8859-1?Q?GQuCWd2+/8UrVn0eMYvqjuS099d/Hkom6Rj2GaimedUcz/KtSYxw6SPrE3?=
 =?iso-8859-1?Q?irLqvzynAxHUN4sQxJTU4tGt+BO3whbhqym5u3vUEUTvUUM0vw5VcSG0gn?=
 =?iso-8859-1?Q?/REvQmgpETIe0yvcYEz7ZV4LjkXmytvbQ7SbISMtRwiBY1XW68qljleWuu?=
 =?iso-8859-1?Q?URJRILdBJEwXDlPOxFg5OMmqL5S0YTd4qijrUrJcXh2pvPQkeOJMdkJzzl?=
 =?iso-8859-1?Q?QjxJMFFGl3tq8g1acTFGJkwa1tE5NllV3KL98F2D0UigIheSX+rlpRq5iS?=
 =?iso-8859-1?Q?QusSpP2Yo9soh0x/cZUC8unsIIj2bRpXj3PCYUTsAlh6pl9Q6PtocntlqU?=
 =?iso-8859-1?Q?4BRvQgaUcSka1gzM+bohWLs1RjawUfsVRSphilg1LIyIPNIl9xJ7NO1yk1?=
 =?iso-8859-1?Q?8k8Whyc4Rvx4Iw59H0Ynuo6++gMrZF2PjZm4LOMYw/HUHdd8STRujN/RaA?=
 =?iso-8859-1?Q?khZFUnSNfZNH01ZWDI8xYXlT3D/LzyHgdvpJIv5jrpJhgCRu25x394WVTK?=
 =?iso-8859-1?Q?0I8xwWpsTyMzwHXppVh7Y9Ve2KmSz7MPxaFGzxEeJNBc3nMpQ5m+fQnrgX?=
 =?iso-8859-1?Q?ZblB5rzlwth4IFPzOTrgqPgkNH0PSlwBKDMdZ8JhbFTx//qJN1cRgXAxju?=
 =?iso-8859-1?Q?ulCy5qcir8IDhEiucSpHxXe5jI+QvtzCr6s98uZc6zWxYaxtpJXsV5FWvG?=
 =?iso-8859-1?Q?1sXgVgWgDFbbq+U15RnPbROj28/wlEbXaIpvQSwU5kL51u?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6527.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09855d04-396c-4a21-480e-08df292b16ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2026 13:08:35.0161 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vLTLqkFrEA0negJ185RO3vdt4lH4ft9lHf3XP83sVlbfH/RTdXQb3oTteRWpUyLKtbXeL9DZhrJ3sZ0WhvATOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7968
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


The patchset consists of the amd-staging-drm-next branch (Head commit -> e5=
93ef9bdb11cee9c13bfdf2bd4e49355c85eff1 -> drm/amd/display: only clear the h=
otplug sources the ASIC has) with new patches added on top of it.

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
From: ivan.lipski@amd.com <ivan.lipski@amd.com>
Sent: Wednesday, October 7, 2026 1:00 PM
To: amd-gfx@lists.freedesktop.org
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.L=
i@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>; Li, Roman <Roman.=
Li@amd.com>; Lin, Wayne <Wayne.Lin@amd.com>; Chung, ChiaHsuan (Tom) <ChiaHs=
uan.Chung@amd.com>; Zuo, Jerry <Jerry.Zuo@amd.com>; Wheeler, Daniel <Daniel=
.Wheeler@amd.com>; Wu, Ray <Ray.Wu@amd.com>; LIPSKI, IVAN <IVAN.LIPSKI@amd.=
com>; Hung, Alex <Alex.Hung@amd.com>; Lin, Ping Lei <PingLei.Lin@amd.com>; =
Chen, Chen-Yu <Chen-Yu.Chen@amd.com>
Subject: [PATCH 00/19] DC Patches October 5, 2026

From: Ivan Lipski <ivan.lipski@amd.com>

This DC patchset brings improvements in multiple areas. In summary, we high=
light:

 - Refactor DC IP request control in HWSS.
 - Fix rotate 90 degrees surface corruption issue.
 - Refactor DPP root clock control in HWSS.
 - Fix upsampling and linear scaling.
 - Use aux hw inst if no ddc pin exists.
 - Directly include compiler_attributes.h.
 - Fix frac_urg_bw conversion to correct U0.10 format.
 - Do full link training during HDR/SDR seamless switch.
 - Fix SPL format handling for linear scaling and upsampling.
 - Update DCN42 cstate latencies.
 - Invalidate the DRR shadow after a hardware re-init.
 - Program HDR visual confirm based on per pipe info.
 - Split link_set_dsc_on_stream into encoder and DSC components.
 - Add new config_dsc hwseq function for DCN60.
 - Program DSC prior to OTG enable starting DCN60.
 - Improve mandatory pstate optimization and check.
 - Disable HUBP/DPP power gating on DCN42.

Cc: Dan Wheeler <daniel.wheeler@amd.com>

Alvin Lee (2):
  drm/amd/display: Use aux hw inst if no ddc pin exists
  drm/amd/display: Program HDR visual confirm based on per pipe info

Aric Cyr (1):
  drm/amd/display: Invalidate the DRR shadow after a hardware re-init

Charlene Liu (1):
  drm/amd/display: Fix rotate 90 degrees surface corruption issue

Dillon Varone (1):
  drm/amd/display: Improve mandatory pstate optimization and check

Dominik Kaszewski (1):
  drm/amd/display: Directly include compiler_attributes.h

George Shen (3):
  drm/amd/display: Split link_set_dsc_on_stream into encoder and DSC
    components
  drm/amd/display: Add new config_dsc hwseq function for dcn60
  drm/amd/display: Program DSC prior to OTG enable starting DCN60

Ivan Lipski (1):
  drm/amd/display: Fix FreeSync caps tests after common EDID VSDB switch

Karthi Kandasamy (1):
  drm/amd/display: Do full link training during HDR/SDR seamless switch

Leo Chen (1):
  drm/amd/display: Disable HUBP/DPP power gating on DCN42

Ovidiu Bunea (2):
  drm/amd/display: Fix frac_urg_bw conversion to correct U0.10 format
  drm/amd/display: Update DCN42 cstate latencies

Rafal Ostrowski (2):
  drm/amd/display: HWSS Refactor - DC IP request control
  drm/amd/display: HWSS Refactor - DPP root clock control

Sridevi Arvindekar (2):
  drm/amd/display: Fix upsampling for linear scaling of subsampled YUV
  drm/amd/display: Fix linear scaling and upsampling

Taimur Hassan (1):
  drm/amd/display: Promote DC to 3.2.402

 .../tests/amdgpu_dm_connector_test.c          |  30 +-
 drivers/gpu/drm/amd/display/dc/Makefile       |   1 +
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  43 ++-
 .../drm/amd/display/dc/core/dc_hw_sequencer.c |  93 ++++--  .../gpu/drm/am=
d/display/dc/core/dc_resource.c |  19 --  .../amd/display/dc/core/dc_resour=
ce_helper.c  |  46 +++
 drivers/gpu/drm/amd/display/dc/dc.h           |   2 +-
 drivers/gpu/drm/amd/display/dc/dc_fused_io.c  |   4 +-
 .../gpu/drm/amd/display/dc/dc_memory_pool.c   |   1 +
 .../gpu/drm/amd/display/dc/dc_memory_pool.h   |   2 +
 .../gpu/drm/amd/display/dc/dc_spl_translate.c |  22 +-
 .../amd/display/dc/dccg/dcn314/dcn314_dccg.c  |   4 +-
 .../amd/display/dc/dccg/dcn35/dcn35_dccg.c    |  21 +-
 .../amd/display/dc/dccg/dcn35/dcn35_dccg.h    |   3 +-
 .../amd/display/dc/dccg/dcn42/dcn42_dccg.c    |   2 +-
 .../dml21/inc/bounding_boxes/dcn42_soc_bb.h   |   8 +-
 .../src/dml2_core/dml2_core_dcn4_calcs.c      |   7 +-
 .../dml2_core/dml2_core_dcn5_calcs_dchub.c    |   5 +-
 .../dml2_core/dml2_core_dcn6_calcs_dchub.c    |  10 +-
 .../dml21/src/dml2_dpmm/dml2_dpmm_dcn4.c      |  20 +-
 .../dml21/src/dml2_dpmm/dml2_dpmm_dcn5.c      |  13 +-
 .../dml2_pmo/dml2_pmo_dcn6_stage_optimizers.c |  97 +++---
 .../src/inc/dml2_internal_shared_types.h      |   2 +-
 .../drm/amd/display/dc/dpp/dcn10/dcn10_dpp.c  |   4 +-
 .../drm/amd/display/dc/dpp/dcn10/dcn10_dpp.h  |   3 +-
 .../drm/amd/display/dc/dpp/dcn20/dcn20_dpp.c  |   4 +-
 .../amd/display/dc/dpp/dcn201/dcn201_dpp.c    |   4 +-
 .../drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c  |  76 ++++-
 .../drm/amd/display/dc/dpp/dcn30/dcn30_dpp.h  |   9 +-
 .../amd/display/dc/dpp/dcn401/dcn401_dpp.c    |   4 +-
 .../amd/display/dc/dpp/dcn401/dcn401_dpp.h    |   3 +-
 .../display/dc/dpp/dcn401/dcn401_dpp_dscl.c   |   8 +-
 .../drm/amd/display/dc/dpp/dcn42/dcn42_dpp.c  |   4 +-
 .../drm/amd/display/dc/dpp/dcn50/dcn50_dpp.c  |   4 +-
 .../drm/amd/display/dc/dpp/dcn50/dcn50_dpp.h  |   3 +-
 .../drm/amd/display/dc/dpp/dcn60/dcn60_dpp.c  |  38 ++-  .../drm/amd/displ=
ay/dc/dpp/dcn60/dcn60_dpp.h  |  15 +-  .../amd/display/dc/dpp/dcn60/dcn60_d=
pp_dscl.c |  13 +-
 .../display/dc/hubbub/dcn31/dcn31_hubbub.c    |   9 +-
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c |  13 +-
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   |  28 +-
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   |  23 +-
 .../amd/display/dc/hwss/dcn31/dcn31_hwseq.c   |  21 +-
 .../amd/display/dc/hwss/dcn314/dcn314_hwseq.c |  20 +-
 .../amd/display/dc/hwss/dcn314/dcn314_hwseq.h |   2 +
 .../amd/display/dc/hwss/dcn314/dcn314_init.c  |   1 +
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.c   |   7 +-
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   |  24 +-
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.h   |   2 +
 .../amd/display/dc/hwss/dcn35/dcn35_init.c    |   1 +
 .../amd/display/dc/hwss/dcn351/dcn351_init.c  |   1 +
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |  27 +-
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.h |   2 +-
 .../amd/display/dc/hwss/dcn42/dcn42_hwseq.c   |   6 +-
 .../amd/display/dc/hwss/dcn42/dcn42_init.c    |   1 +
 .../amd/display/dc/hwss/dcn50/dcn50_hwseq.c   |   3 +-
 .../amd/display/dc/hwss/dcn60/dcn60_hwseq.c   | 101 ++++++-
 .../amd/display/dc/hwss/dcn60/dcn60_hwseq.h   |   1 +
 .../amd/display/dc/hwss/dcn60/dcn60_init.c    |   1 +
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |   9 +-
 .../display/dc/hwss/hw_sequencer_private.h    |   5 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h  |   6 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/dpp.h   |   3 +-
 .../gpu/drm/amd/display/dc/link/link_dpms.c   | 282 +++++++++++-------
 drivers/gpu/drm/amd/display/dc/os_types.h     |   1 -
 .../dc/resource/dcn42/dcn42_resource.c        |   4 +-
 .../dc/resource/dcn60/dcn60_resource.h        |   6 +
 drivers/gpu/drm/amd/display/dc/sspl/dc_spl.c  |  52 ++--
 68 files changed, 874 insertions(+), 435 deletions(-)  create mode 100644 =
drivers/gpu/drm/amd/display/dc/core/dc_resource_helper.c

--
2.43.0

