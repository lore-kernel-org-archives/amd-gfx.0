Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B868D0C608
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Oct 2024 13:25:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B187710EAC3;
	Fri, 25 Oct 2024 13:25:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iuljp3OU";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2072.outbound.protection.outlook.com [40.107.223.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7BF2110EAC3
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Oct 2024 13:25:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LGwun84QspOwJWlXQ9beTGyEheEN+CU3cGT4+t7WKFELJnRSXgZE53wy4fb+JXr4AK4oC9P6GfSdufIpIqLpIfmpfI5vFGeYHZrGinlyX8y57iq5ItqsZMOtmpJjgyY4GLgLYVF+Sq7ZPDF+E4A/MYOa9sVSmnXHepAj3Ld7GYo1QPSn8q6LBhBmtZQ+6iXQa1fPDGd8Fh+ergFI4NVORZfeQ7W2sW57xXvhtpcAAxY0SAt0hJpSRpxL8J104P3Ao3pJKNxwPxoLtEnWkCeVeekhX+mXmvLzIewO3JikN1a+hiW9bbgegwv66G2HpALqX+O+5hYc92NjNdHhjhDbAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+o9KnB3OpHVHAfE79VSOUuRF3iwkCMtUJH/2koQcnIw=;
 b=TmVsvCHhyL5PQpCBeMuBmmQZPZdXTPlSp6MBP3jYR4ttfZNoU7ovJY2ZWYMfL1R0nwQ8nYASfgc93FA6u0Ygefaq/DLYl8y7aFH3d+nr06S0puHsPJXphYN6Kj+wWmlPKbFBombci02Yqkz9SV6ZMU7b1PHqBpXXAYXUvpRNkME+sVOmO23RxwYRbccbVahPeHd/Y5LBcshJzNJVzh0vvCXU9ovzSXyjmkhodvLeWVxghLnY+prkyGUWcQ0vlJbMGrd9urdff8jk1nh/TJc9kfXMgp1H3JyRtUuwYdeRab7uOr3UvEZHoMCQ6JXFha34Qw76qIWFYleYsHF1aWxw/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+o9KnB3OpHVHAfE79VSOUuRF3iwkCMtUJH/2koQcnIw=;
 b=iuljp3OU3WYoiTOiSjpyZRKOw4E+OHfwn8ARxbTU1u5SCjfQ2Qi/2tttNFxkdKwz14WV9K/Z5aEyojgTRKO5C38GrdD/FN6FnUj04ezFWCk/y6jC6WlK1/qG9BU7Tn42wHqOPASdJ26onT+tL+KyZaaJfBGA8yNCjhoCisbx8ho=
Received: from DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) by
 SA1PR12MB5639.namprd12.prod.outlook.com (2603:10b6:806:22b::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.21; Fri, 25 Oct 2024 13:25:39 +0000
Received: from DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::ea87:74ba:36ec:8cf6]) by DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::ea87:74ba:36ec:8cf6%3]) with mapi id 15.20.8093.018; Fri, 25 Oct 2024
 13:25:39 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Chung, ChiaHsuan (Tom)" <ChiaHsuan.Chung@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Wentland, Harry" <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)"
 <Sunpeng.Li@amd.com>, "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
 "Mahfooz, Hamza" <Hamza.Mahfooz@amd.com>, "Pillai, Aurabindo"
 <Aurabindo.Pillai@amd.com>, "Li, Roman" <Roman.Li@amd.com>, "Lin, Wayne"
 <Wayne.Lin@amd.com>, "Chung, ChiaHsuan (Tom)" <ChiaHsuan.Chung@amd.com>,
 "Zuo, Jerry" <Jerry.Zuo@amd.com>, "Mohamed, Zaeem" <Zaeem.Mohamed@amd.com>,
 "Chiu, Solomon" <Solomon.Chiu@amd.com>
Subject: RE: [PATCH 00/16] DC Patches Oct 28 2024
Thread-Topic: [PATCH 00/16] DC Patches Oct 28 2024
Thread-Index: AQHbJQeNUCw8cycsc023dOtQvO30O7KXd8iw
Date: Fri, 25 Oct 2024 13:25:39 +0000
Message-ID: <DS0PR12MB6534DE21BCEB080CFFB055649C4F2@DS0PR12MB6534.namprd12.prod.outlook.com>
References: <20241023045336.1557443-1-chiahsuan.chung@amd.com>
In-Reply-To: <20241023045336.1557443-1-chiahsuan.chung@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=ba2ca9ac-6621-40ba-b64f-8046766fdae6;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2024-10-25T13:23:06Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6534:EE_|SA1PR12MB5639:EE_
x-ms-office365-filtering-correlation-id: 47c6e5cb-1932-4fec-6d20-08dcf4f884ae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?CvBhM7TNT2vxzZiKpLIyf8e8PI1ishY8QqcTADcbOlQG86zpE3pxQe2KacPx?=
 =?us-ascii?Q?YAeKFgOew7G9NmA0HxCscpSMVDi9bGiUuf5LbNOrS9KI/0zHk6go+UDUV1KN?=
 =?us-ascii?Q?B/f4Q/YqIpxI7Mxx1/wY0jzSwhPfU7v4ihgjNjmEY3FagJgyOfmUxRqTM0iK?=
 =?us-ascii?Q?Imo+PLRrcvteYoqKtPsmUdbG+yiFu5wYb8rq/V8wM3WqP4ko6aSSC+1F3JIZ?=
 =?us-ascii?Q?MVKumvSqd0aKEpUtYOhlof+YmjIdDlXJCAPA+VSHlgtcuWo9T9xqFJlI+UrD?=
 =?us-ascii?Q?6MbmQNEXL8tIToFD8Kn8R1gewUKbGZosGAn2PyyQKkm2jrSLIpo7t8Bjh0KN?=
 =?us-ascii?Q?gTSqpKwJFDCqJc3whE9iCnOMLTxjouX0QB25RImtkmq6mOiWkB/Xzx8phlC9?=
 =?us-ascii?Q?iGy5smkJDjURDndkqRtzEstcWusyI+iShbY4zy81CFtt6/I0rsUYcKJ1QD65?=
 =?us-ascii?Q?BUq6W36ubWMXEbMNSz1w48MT3BPOlrex/tey4d7aPTwHiaMkvRmgSl9fgjHZ?=
 =?us-ascii?Q?UleRH1cnjKGlkVgRpCuRtp8sEwdQE/j5VUVpHcK8ghg3Zfim1gKNK5XkULOW?=
 =?us-ascii?Q?zVbQET5od/12kPqbyhy7NzpsnZb2KuUzI2u9O3mpM+kudhNv809boFJyTlmA?=
 =?us-ascii?Q?J3A9cNsB4WbqopoJw+2bQirXTtKG7OmH8zLQDuhx/l9LpCxWdVH6msztqJbU?=
 =?us-ascii?Q?ocv8B9iBF+RcrmTnegRbn5UfdLle5TNzmsQr5Zd+V94AdlqitAAaDF49IKQi?=
 =?us-ascii?Q?jtU3zBBn52M9QAhZVrGT0XkaLPtHcPkJNacsfrgEAbUd6wFYboxmEJPBYM+k?=
 =?us-ascii?Q?kQR7tWD2qaYcZe6G1AJFNrI2BAU1rZFzH35nVY6xKkBw1oo+ErbSGQG6Vrif?=
 =?us-ascii?Q?bdiGjMSPhv5GGUsjs65EkxEqK5etSJPcy4q+2s1/3YTCT4HsPkRWHdCkXkF/?=
 =?us-ascii?Q?FlskFq0yOywju+hZLSbaJzBeLEoSGTiULYqZxNb4+d7drMzML3ovB6Pa4mG0?=
 =?us-ascii?Q?6YoNcK9P3Dol6kkEDs65ALncJ/RgzqSyHJAh1H8K4NzUchC44Z9jNb5UFsV+?=
 =?us-ascii?Q?xLDBl6MSoebPE6YX8U4CQzsCKBiDDCjTDW/Q9g77faxj1h8xvidues2iv/94?=
 =?us-ascii?Q?y370QZCmT/5+eYv4igTyUZCdw19theQp37COZUyjpgpUCP2ERm4SzVJIMoGI?=
 =?us-ascii?Q?u0F09ROIj73IwAbkZpdmvi+lWWht0z0IZBUivXdsmhLadQ0xx+kgWm6PhT4t?=
 =?us-ascii?Q?n93MJ543InYmChBJUhrEeKiOcQMPUqj7PA/2i56ZQzPi4nX7olyDm4bAvHTt?=
 =?us-ascii?Q?uSAvsPTh15YqQxVs12VbUCK8ksWnZxUUv8t+BKNd9GZpKlKN8p1KW8bPga6W?=
 =?us-ascii?Q?JKBtVSA=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6534.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?V3fC4RYH4Fi7/X6FsesCCOyEi/grKKL7h7tH/11d3GJeS5wuFravIne6HLXY?=
 =?us-ascii?Q?oBxG/qWRUicxcrCDPJnRaSjakMQuawSbZlQwVHlTLBfABYanfBwf4AMAyo2Z?=
 =?us-ascii?Q?FNGkCMcDZZYm9ktBJeoEg5JBeD4mquqfAiGf1IX74T5J/wLnkRJmNkUQHFGl?=
 =?us-ascii?Q?F+G7s90zIHL07Cgwg7f3pBisOa1ECbuqt922Fzc1l/73kQ719NbRwQVchqzW?=
 =?us-ascii?Q?bGGLjJvvu4AuzEqbdonhNuzzlXdT3IqJBMBisaWGUW5MEPKqD+4ms1fXwc0x?=
 =?us-ascii?Q?1XwkefUou1zVTRS+Lfm70sBYK6DWOP+0io1RzSPIJLudNkTK/CTXTkTtDQMs?=
 =?us-ascii?Q?DsOFwGbAsLEUYBKfceXZB6fdOilnoDUs5rptzv7RNxaeyjAZMEQ8/y+2HRCq?=
 =?us-ascii?Q?5S4P1PlLeLYbIc2jmEeNdvQ4zzNid0RI57h/I7jwRYK7DmrTyt8pc1DuCEwK?=
 =?us-ascii?Q?jabSIyT2154/aD06X6OOk2SxqGjncBzBENZWO4OQFAEmROjwwFOzO2rBWpnc?=
 =?us-ascii?Q?mtnVs0TqQu3mkEIj0NdVtZ7w+aQvKSEu1fny6591BL/y5VmgtusmgY8+lHNj?=
 =?us-ascii?Q?UepgaBQtrwCGsaaJvR1FfOPdQoQsB7QKGJAthHWFkdNxQYaJR8rcl7+ArQ1P?=
 =?us-ascii?Q?Yx08ahzbjMDovwk+XXgo67lhkDmh+HdeZ81PpABlm26CKPWEK+V7dFROJHSd?=
 =?us-ascii?Q?8lhLvOnURC9Is+IXBEmjfqfXh3WSygt163fV1U6X+jjR1K2SyWqlVBlzIzFc?=
 =?us-ascii?Q?nzZDSliV3zmzcUGsRxMhfED/sXra5+DyFHB0ikAoYSrXBpUrDD/G6VszP/qz?=
 =?us-ascii?Q?dHml2Y7iRk2jxA3fh5RIeWxOsVzKGdWQ0Q87lt3n2YM0g1tpPkSvdogex+Dy?=
 =?us-ascii?Q?IYRlVYXCcebHA9phJI2fyOiupqf3htEv6V/rVXAVAfln0nATPLkeOGCzpDnd?=
 =?us-ascii?Q?OQWWGzypI0sI//A75O+tQxRABiBNr0kqqVnMR6YY+HiUDjg8hQGonj/Vox45?=
 =?us-ascii?Q?GPrHpdF26V1N6ZmSPkIXeQLA9dbCdUbmL2EILOsoRaJPjSYuBZ1r/mDoDGQU?=
 =?us-ascii?Q?Iirm1FJAROzPAG8rQ/31y+UqRy8mieFUeZspgNxFafR6vZyyKZTKreW+UjfU?=
 =?us-ascii?Q?J2l/1oqQrPwIQYcKnEwQA6WKKcZKzEBRkrLHXizsej5zcMYN6eePtQZMmtdk?=
 =?us-ascii?Q?CZulxFzAn3gD971FXY4lGFOSoK1vKvev4Xpv3GQTxDGFPAHbhSbT7iEiedwv?=
 =?us-ascii?Q?pm951ze05tp7ZXcsut6brwa4NPPpNxOq3KqsBRAV2s1NELbh7b+/FzOunhSY?=
 =?us-ascii?Q?jeykIWPuYdqapeuMY8mwXUi17OCbt0rkRIhhj6iPsM/LtJXd1o1tl999wIcX?=
 =?us-ascii?Q?xflGJ3HP48tvegXVmwobJEwTLNntW7VJuK1Knd1ErUw5jrDhxujxw65anbhU?=
 =?us-ascii?Q?bGwgViHc0Ia/ddI4U0B3db52yCIGgz+S7LVZ8qF2x8IDKdDkjz0s8mra6E9O?=
 =?us-ascii?Q?21AI+lD68WjdiyR/aaQ8WhPfCJgm7yX/A8XyZBFy5w+xd3E1RhnXrvRp6uAS?=
 =?us-ascii?Q?gI2Q5xbFItj/DlMLRLg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47c6e5cb-1932-4fec-6d20-08dcf4f884ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2024 13:25:39.4448 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5QFq6bOXVYE5qxz0C0RLtRAPy3sQLBm/VUJ2y8v6+czTJ6oTJFtp7b0+P9Cc7j9N++1dFu+EdlH77Gan+gUy1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5639
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
        * PCON -> Club3D CAC-1085 + 1x 4k 144hz

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

The patchset consists of the amd-staging-drm-next branch (Head commit - e72=
728217063bdc2577dafb210acfe146fcbe68c -> drm/amd/display: Disable PSR-SU on=
 Parade 08-01 TCON too) with new patches added on top of it.

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
From: Tom Chung <chiahsuan.chung@amd.com>
Sent: Wednesday, October 23, 2024 12:53 AM
To: amd-gfx@lists.freedesktop.org
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.L=
i@amd.com>; Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; Mahfooz, Hamza <H=
amza.Mahfooz@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>; Li, Ro=
man <Roman.Li@amd.com>; Lin, Wayne <Wayne.Lin@amd.com>; Chung, ChiaHsuan (T=
om) <ChiaHsuan.Chung@amd.com>; Zuo, Jerry <Jerry.Zuo@amd.com>; Mohamed, Zae=
em <Zaeem.Mohamed@amd.com>; Chiu, Solomon <Solomon.Chiu@amd.com>; Wheeler, =
Daniel <Daniel.Wheeler@amd.com>
Subject: [PATCH 00/16] DC Patches Oct 28 2024

This DC patchset brings improvements in multiple areas. In summary, we high=
light:

- Fix polling DSC registers during S0i3
- Fix idle optimizations entry log
- Change MPC Tree visual confirm colours
- Fix underflow when playing 8K video in full screen mode
- Optimize power up sequence for specific OLED

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Alex Hung (2):
  drm/amd/display: Remove useless assignments and variables
  drm/amd/display: Simplify dcn35_is_ips_supported()

Aric Cyr (1):
  drm/amd/display: 3.2.307

Aurabindo Pillai (1):
  drm/amd/display: Fix idle optimizations entry log

Dillon Varone (1):
  drm/amd/display: Add P-State Stall Timeout Recovery Support for dcn401

Fangzhi Zuo (1):
  drm/amd/display: Reduce HPD Detection Interval for IPS

Hansen Dsouza (1):
  drm/amd/display: Add a boot option to reduce phy ssc for HBR3

Joshua Aberback (1):
  drm/amd/display: Change MPC Tree visual confirm colours

Leo Ma (1):
  drm/amd/display: Fix underflow when playing 8K video in full screen
    mode

Lohita Mudimela (1):
  drm/amd/display: Refactoring if and endif statements to enable
    DC_LOGGER

Ovidiu Bunea (3):
  drm/amd/display: Optimize power up sequence for specific OLED
  Revert "drm/amd/display: update DML2 policy
    EnhancedPrefetchScheduleAccelerationFinal DCN35"
  drm/amd/display: Do not read DSC state if not in use

Samson Tam (2):
  drm/amd/display: fix handling of max_downscale_src_width fail check in
    SPL
  drm/amd/display: store sharpness 1dlut table in dscl_prog_data

Taimur Hassan (1):
  drm/amd/display: [FW Promotion] Release 0.0.240.0

 .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    | 10 +---
 .../display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c  |  5 +-
 .../dc/clk_mgr/dcn314/dcn314_clk_mgr.c        |  6 +-
 .../display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c  |  6 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  8 ++-
 .../drm/amd/display/dc/core/dc_hw_sequencer.c |  4 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |  3 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |  1 -
 drivers/gpu/drm/amd/display/dc/dc_types.h     |  1 +
 .../amd/display/dc/dce/dce_stream_encoder.c   |  2 -
 .../display/dc/dce110/dce110_mem_input_v.c    |  2 -
 .../dc/dio/dcn10/dcn10_stream_encoder.c       |  2 -
 .../dc/dio/dcn401/dcn401_dio_stream_encoder.c |  2 -  .../dc/dml2/dml21/dm=
l21_translation_helper.c  |  2 +-  .../dml2/dml21/inc/dml_top_dchub_registe=
rs.h  |  1 +
 .../src/dml2_core/dml2_core_dcn4_calcs.c      |  3 +
 .../gpu/drm/amd/display/dc/dml2/dml2_policy.c |  1 +
 .../display/dc/dpp/dcn401/dcn401_dpp_dscl.c   |  3 +-
 .../display/dc/hubbub/dcn10/dcn10_hubbub.h    |  9 ++-
 .../display/dc/hubbub/dcn401/dcn401_hubbub.c  | 12 ++++  .../display/dc/hu=
bbub/dcn401/dcn401_hubbub.h  |  8 ++-  .../amd/display/dc/hwss/dce110/dce11=
0_hwseq.c |  3 +-
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   | 15 +++--
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |  5 ++  .../gpu/drm/amd/dis=
play/dc/inc/hw/dchubbub.h  |  1 +
 .../gpu/drm/amd/display/dc/link/link_dpms.c   | 15 +++--
 .../dc/link/protocols/link_dp_capability.c    |  3 +-
 .../dc/resource/dcn401/dcn401_resource.h      |  4 +-
 drivers/gpu/drm/amd/display/dc/spl/dc_spl.c   | 16 ++++--
 .../display/dc/spl/dc_spl_isharp_filters.h    |  1 -
 .../gpu/drm/amd/display/dc/spl/dc_spl_types.h |  3 +-
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |  1 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 56 +++++++++++++++----
 .../gpu/drm/amd/display/dmub/src/dmub_dcn35.c |  1 +
 34 files changed, 150 insertions(+), 65 deletions(-)

--
2.34.1

