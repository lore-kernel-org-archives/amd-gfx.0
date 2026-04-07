Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A85DBFEEF2E
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Apr 2026 11:43:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 320E610E3F1;
	Tue,  7 Apr 2026 11:43:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="svDaN9lj";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011008.outbound.protection.outlook.com
 [40.93.194.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B2E110E339
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Apr 2026 11:43:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=heqjyL/ikz483HdGnEmDJUvXFHI0PG/gNnZWLuQd9C0gAXyrUC7tzlbluSl4EN6p9i7B7VCTzh1Nw3exllkIr9Rr9XlfL8sH99pIbTNadqv4MpJTck7V3/70OC9mi3fdFeM2EPDxHORj1OD25ww4Hng1WWnRyAL29d7mv1bMrsIeFMu/qkjvbbURgrRHWeQhMEeqebBoSytc17L8nyk7ZdW02jUMhrTcQBq4pbJbh++h/ayPNiEpB8yxL0jZ6uKDYnzLprN+F15P4YRtWtk7LLOouKj3Ju+cLsNkm4bSVffaHQl2Zj6feEWAa2hz3CH6SdaQqpFVb+BfGZ6cEGbpSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w/CyejWt5BTAnfbufwxUT52cqn1XQx5UECeG6h2K2D4=;
 b=AYsgiHo6ROknPE8azxpXVxi+VK24sH7sqkYhk2jFwU60+TFgQ9DNXEHDpZCKxkZAt5xt9nYGGhVdfsJLPBU7cGWK4AVOQh7lBruPrlEN4LAFxd0oCJETyeB2q/drVEkrZN8r5sKaqiaqyC6w8GrwATYnjZ8t71mv7TIAr0T02Czy+9L6RpKSd9InXyePzVcXIepidDTGTknoA3fBnsQv5qFgwJsBhi2qpwkVkcv1a46T/6GyxUw1/CKjzaCcxlxPBsITNhgoRB9sDPiBTNIMlGqJY+wsZ11CnLxHk/p2Koz657OqRwHUBtadK8eOKu50P+ERESUfVgmNuN6+YlK0zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w/CyejWt5BTAnfbufwxUT52cqn1XQx5UECeG6h2K2D4=;
 b=svDaN9lj16XoX63qdn20h9zDTUSWwgOqQO2l/HMYvtj2XDyd+pJMoNactJ+1mvAi8MxoUq1k/XKJ/J/vFFnlyx3+KHjQDG0T86GrKuZM55VBDW8OaMknNEV+IKklUw+FomxEH4kF3FO6+BA2DlGATZnDaiYM4Ue3KBxiMM9nX4o=
Received: from DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) by
 DS7PR12MB9476.namprd12.prod.outlook.com (2603:10b6:8:250::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.20; Tue, 7 Apr 2026 11:43:16 +0000
Received: from DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::b2e1:64e5:3b9e:738a]) by DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::b2e1:64e5:3b9e:738a%4]) with mapi id 15.20.9769.016; Tue, 7 Apr 2026
 11:43:16 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Li, Roman" <Roman.Li@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Wentland, Harry" <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)"
 <Sunpeng.Li@amd.com>, "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>, "Li,
 Roman" <Roman.Li@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>, "Chung,
 ChiaHsuan (Tom)" <ChiaHsuan.Chung@amd.com>, "Zuo, Jerry" <Jerry.Zuo@amd.com>, 
 "Wu, Ray" <Ray.Wu@amd.com>, "LIPSKI, IVAN" <IVAN.LIPSKI@amd.com>, "Hung,
 Alex" <Alex.Hung@amd.com>, "Tseng, Chuan Yu (Max)" <ChuanYu.Tseng@amd.com>,
 "Li, Roman" <Roman.Li@amd.com>
Subject: RE: [PATCH 00/22] DC Patches April 02, 2026
Thread-Topic: [PATCH 00/22] DC Patches April 02, 2026
Thread-Index: AQHcws86YDjKE8/ng0m9CnQ03crsArXTgZ1g
Date: Tue, 7 Apr 2026 11:43:15 +0000
Message-ID: <DS0PR12MB65346A53C42279E0027D9B339C5AA@DS0PR12MB6534.namprd12.prod.outlook.com>
References: <20260402183314.1388755-1-Roman.Li@amd.com>
In-Reply-To: <20260402183314.1388755-1-Roman.Li@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2026-04-07T11:42:45.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6534:EE_|DS7PR12MB9476:EE_
x-ms-office365-filtering-correlation-id: 19504270-9e61-418c-9069-08de949adb5c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info: LGBUFNYqHaAgtfzf2Rh6WuSL+bviLaCtMXvIfu4EMBEOen2xlR0UM/QFM9zjjJcjEHGinUzJWLzQV8Wdl4WURuLsyEdjMXnqXtZfTiUElLESI9INR7EP1UAJby9yblm3zaIaKunEiFF/ym9ySwKrca6rsWLxHn/hxB7hdGNnWuJyK1xDQEz2AJG5uehaN6mQbI7tEoiVCA4UCATjIDBcrVsEYNmGarKFQKBqXCqvzuehpVJwM+ksQSK/Z+J4c07sV7A2bOXoeLTlosibk0KHeDVHzDQn14Sf5YYZyyarMge6bnSTrJkrHKwBdjFEpC9As26f8GPIi2vshOix9n7U13pGmqHPOo8860QYmY06BH1St7c6+f+eTiIgP+j0GcwY8QCmYl4jleqFFzoLmhhiTYfRpO6HHmJ1BM/0nXxSQHGqzrZXUViEzeETmZqk39WkyIpn5192d86sZDsvfwlJcpZZK1orw/mLTiJw9pvWYFF/gWvgNc9MQX2PzA3wJjkGeg1GCGA2AMLd1jpWFYlgUjHm1MPqPDT/CGZ+w7y+aCjZrkHWlvjXeFTNUFnQek2vezQzQKJv/W3BTGaOdo3zaHCIqxwO+Fgl0kKm+ftlTAYkg+SHZwh+i/IGANt3q9RVdJ5+1dLfzEAqYyFdPDK3mifxwCDm0OUfHeagcpQGnejaeEUIkWZEEzy9HilFglbvXwsGBk+hILj5+m4VEo2k1dZz4nKygfWpvwtoI7330wylGmDJwhWZvaOUmMS17XBcjy3KTu45R6w+rja4mqE/2XHXvnIhxp19aNjY+E9UNww=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6534.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Of7xTLvaLRW/MEkWHZR08ud/dnHXWiDevv87LqQtkF2qTx1Mu2dElTf/Cf?=
 =?iso-8859-1?Q?LaRTIHBGgEvH1v6me2SPZ2RaAMfoAUVR5qDzInuIPL4graMHBLfUphbWZ6?=
 =?iso-8859-1?Q?3RK4MhciJWhv0Q5b3mpDNBILARMjH8UZWR1WlsXP2d6InFlzOIkMTD97c8?=
 =?iso-8859-1?Q?pQFdBUzF0MsmA3CPXBjeukYmtVsU3/Ygr/Eba0bNCsIs4+T5k7wpU8fMpT?=
 =?iso-8859-1?Q?heWwHYeKw5URR4H2IkjIQcHbdEwUWh89TEZ8gfRPx1dJ8nRsjSH52wocmr?=
 =?iso-8859-1?Q?g0PG12ApRPz2ZIjLI4jgjKzG18kvYNuzFJJzwmmbn+TVGQR3UXBvArZvn+?=
 =?iso-8859-1?Q?OHy+vMtGvwkp9bJNmhqgZATKF2YImpsYJ9bMGGYSS8cZ8H4GN1wqrGTBjq?=
 =?iso-8859-1?Q?yOM8m5biZpDXNQ68zlRE6R/yCHGrJo9j+R9eFIE64Uny36lnreTqP8F10O?=
 =?iso-8859-1?Q?XPZw8HY8cbdelmMbD7PxCbrNlHj4JiaUREtzDjM1Joh1yEhQnQk/nfiETW?=
 =?iso-8859-1?Q?YCoBIpAJIEH/CqL/tUmSH3R5r38fT75wOBlBa7iAByW/ix/bKDBAVT5rnl?=
 =?iso-8859-1?Q?qk6jaRmIUYrhkItSrbVBJ3rTKnyvS2uhd6jjvyEbpWq7a32bSRU03cBnhC?=
 =?iso-8859-1?Q?N98FVhjjkcbzeI+oZbuTv7yWdM5iHrCDRpPS8vQdaNkzT3VBctzTx1bpTE?=
 =?iso-8859-1?Q?M5Lh+7BKSI3tU0ytd4wWVuPPwotZlvKBCk/B1iBvEeUfw/00zDWtKD1Cst?=
 =?iso-8859-1?Q?wIwDkGj3nFOtz/Gjg/8bEGd1B1MQAw2cdqr3njxROtEuu9/8o0c2bDAvCv?=
 =?iso-8859-1?Q?P1fdgG4pTtCM+aa/aPl0gaxcYS7PxZQKg6nMndNyyzZfYHCLftxk/5LhKP?=
 =?iso-8859-1?Q?x1vm7eO7pJ6gJ6WZez+YCIIzCN4KQfpJplk6I/qxsBfslOZvyeSQ6XqyJQ?=
 =?iso-8859-1?Q?lmCORNNrXS2dCDAg/Y3js7wcnKys7yUOvT8twA5/GzOIkculS3SZuNDOEn?=
 =?iso-8859-1?Q?HPHhmwvQOwSI602voQZ7oskVBKROUSVO0hiJM+DIYSSIsXExqktro9dAMJ?=
 =?iso-8859-1?Q?2kaKfGnl91zTW8jMRIFICZ3l5D69wmuJRUTMsYCTUut2Oj3V1NfbbI3SzX?=
 =?iso-8859-1?Q?nNPzeva1Hi/4bb0b5peFnlvpfQTmBE2XPQ3QLo1vMoAx+YsyWdWxxrCOVm?=
 =?iso-8859-1?Q?fmDu6SBrEE1Ggfa/9TZRbyI+88QLIhORc+oIJLTfZRFMSY5UnuBXLtze6a?=
 =?iso-8859-1?Q?thLVPsQrmWRmKOrfFsWWQW/XglIap2Do1QMeKmSxy1DLldONoRqCrNCWxO?=
 =?iso-8859-1?Q?E0eEQB8uN4G+4/XAA42CkbB9BasHiJKGPbO9QpUtdB2gXFJ3JodAJkLLMA?=
 =?iso-8859-1?Q?oRIAtthKT9Cfj1AtjcvrArJkkLClsJgri31Ee0NU91LqTKkxtrlo58AF3e?=
 =?iso-8859-1?Q?tvN2gvQ4lIjNj6zLxkDo+ItDN02+hg74oGfGQ9WqGH5L5pod52qjha9h50?=
 =?iso-8859-1?Q?KKAo2dIcWb6Rc13BpfpfFSklJg3+bBDzoCa6V2MmmfLESWETJaYDYWaN+R?=
 =?iso-8859-1?Q?pBaarNHPivHvaHwfU9GDJX9bMwAQoUBtjK9GocNvkNfilp5Y6LQ3l1aLHn?=
 =?iso-8859-1?Q?+yzJwUh/p9/r8AylBQN9XDRw81yq9cpXlHxf5N2XdaOx0KyDAr58qvho8P?=
 =?iso-8859-1?Q?VRgSVatr21JGHeb6xXmWdzEOsw3Wa91chmMdoD1rvrGrdNVCSbv95V/GjI?=
 =?iso-8859-1?Q?v8dH3M75ZHOSNSSJMxBCyUxfdWmXPi7ddQxjU4vnV9bNTJ?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19504270-9e61-418c-9069-08de949adb5c
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2026 11:43:15.8724 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WvgaSxzBTE+qlbOShSZOouDInT8IyxXZG93zUKvIp1pQ5iCrABaClUX/WgE9CRemRkTF5ZwVeNAKIRJTS1bt7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9476
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


The patchset consists of the amd-staging-drm-next branch (Head commit - 2e9=
8e61beda6e3ecc365a61feb94537363a2ed63 -> drm/amdgpu: Add bounds checking to=
 ib_{get, set}_value) with new patches added on top of it.

Tested on Ubuntu 24.04.3, on Wayland and X11, using Gnome.

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
Sent: Thursday, April 2, 2026 2:33 PM
To: amd-gfx@lists.freedesktop.org
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.L=
i@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>; Li, Roman <Roman.=
Li@amd.com>; Lin, Wayne <Wayne.Lin@amd.com>; Chung, ChiaHsuan (Tom) <ChiaHs=
uan.Chung@amd.com>; Zuo, Jerry <Jerry.Zuo@amd.com>; Wheeler, Daniel <Daniel=
.Wheeler@amd.com>; Wu, Ray <Ray.Wu@amd.com>; LIPSKI, IVAN <IVAN.LIPSKI@amd.=
com>; Hung, Alex <Alex.Hung@amd.com>; Tseng, Chuan Yu (Max) <ChuanYu.Tseng@=
amd.com>; Li, Roman <Roman.Li@amd.com>
Subject: [PATCH 00/22] DC Patches April 02, 2026

From: Roman Li <Roman.Li@amd.com>

This DC patchset brings improvements in multiple areas. In summary, we high=
light:

* Enable sink freesync via MCCS with pcon whitelist adjustments
* Rework YCbCr422 DSC policy
* Update DML2.1 parameters
* Fix coding style issues and compiler warnings

Cc: Dan Wheeler <daniel.wheeler@amd.com>

Charlene Liu (2):
  drm/amd/display: update dcn42 bounding box
  drm/amd/display: Restore "Move setup_stream_attribute"

Chuanyu Tseng (1):
  drm/amd/display: Fix coding style issue

Dmytro Laktyushkin (2):
  drm/amd/display: update dcn42 memory latencies
  drm/amd/display: move memory latency update to dml for dcn42

Gaghik Khachatrian (2):
  drm/amd/display: Fix unused parameters warnings in dml2_0
  drm/amd/display: Fix implicit narrowing conversions in modules

George Shen (1):
  drm/amd/display: Remove unnecessary Freesync w/a from DCN32

Nicholas Kazlauskas (5):
  drm/amd/display: Fix HostVMMinPageSize unit mismatch in DML2.1
  drm/amd/display: Correct MALL parameters for DCN42 soc bb
  drm/amd/display: Pass min page size from SOC BB to dml2_1 plane config
  drm/amd/display: Fix DCN42 gpuvm_min_page_size_kbytes in SOC BB
  drm/amd/display: Add DCN42 PMO policy for DML2.1

Relja Vojvodic (1):
  drm/amd/display: Rework YCbCr422 DSC policy

Roman Li (1):
  drm/amd/display: Drop unused tiling formats from dml2

Taimur Hassan (1):
  drm/amd/display: Promote DC to 3.2.377

Wayne Lin (5):
  drm/amd/display: Adjust freesync pcon whitelist
  drm/amd/display: Parse freesync mccs vcp code
  drm/amd/display: Read sink freesync support via mccs
  drm/amd/display: Enable sink freesync via MCCS
  drm/amd/display: Avoid to do MCCS transaction if unnecessary

Zheng, Austin (1):
  drm/amd/display: Remove Duplicate Prefetch Parameter

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  74 ++++--
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   7 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 241 ++++++++++++++++++
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |   2 +-
 .../display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c  |  78 ------
 drivers/gpu/drm/amd/display/dc/dc.h           |   5 +-
 drivers/gpu/drm/amd/display/dc/dc_dsc.h       |   1 +
 drivers/gpu/drm/amd/display/dc/dc_types.h     |   6 +
 .../dc/dio/virtual/virtual_stream_encoder.c   |  10 +
 drivers/gpu/drm/amd/display/dc/dm_helpers.h   |  10 +
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  |  37 ---
 .../gpu/drm/amd/display/dc/dml2_0/Makefile    |   1 +
 .../amd/display/dc/dml2_0/display_mode_core.c |  17 ++  .../amd/display/dc=
/dml2_0/display_mode_util.c |  14 +
 .../dml2_0/dml21/dml21_translation_helper.c   |  24 +-
 .../amd/display/dc/dml2_0/dml21/dml21_utils.c |   2 +
 .../dc/dml2_0/dml21/dml21_wrapper_fpu.c       |   2 +
 .../dml21/inc/bounding_boxes/dcn42_soc_bb.h   |  25 +-
 .../dml21/inc/dml_top_display_cfg_types.h     |  14 -
 .../dml21/src/dml2_core/dml2_core_dcn4.c      |   5 +-
 .../src/dml2_core/dml2_core_dcn4_calcs.c      |  37 ++-
 .../src/dml2_core/dml2_core_shared_types.h    |   1 -
 .../dml21/src/dml2_core/dml2_core_utils.c     |  65 +----
 .../dml21/src/dml2_core/dml2_core_utils.h     |   2 -
 .../dml21/src/dml2_dpmm/dml2_dpmm_dcn4.c      |   1 +
 .../dml21/src/dml2_dpmm/dml2_dpmm_factory.c   |   2 +
 .../dml21/src/dml2_mcg/dml2_mcg_factory.c     |   1 +
 .../dml21/src/dml2_pmo/dml2_pmo_dcn42.c       | 192 ++++++++++++++
 .../dml21/src/dml2_pmo/dml2_pmo_dcn42.h       |  17 ++
 .../dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c  |  21 +-  .../dml21/src/dml2=
_pmo/dml2_pmo_dcn4_fams2.h  |  10 +
 .../dml21/src/dml2_pmo/dml2_pmo_factory.c     |   3 +
 .../dml21/src/dml2_top/dml2_top_soc15.c       |   2 +
 .../display/dc/dml2_0/dml2_dc_resource_mgmt.c |   9 +
 .../dc/dml2_0/dml2_translation_helper.c       |   6 +
 .../drm/amd/display/dc/dml2_0/dml2_utils.c    |   1 +
 .../dc/dml2_0/dml_display_rq_dlg_calc.c       |   1 +
 drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c   |  13 +-
 .../drm/amd/display/dc/dsc/dcn20/dcn20_dsc.c  |   2 +-
 .../drm/amd/display/dc/dsc/dcn35/dcn35_dsc.c  |   2 +-
 .../amd/display/dc/dsc/dcn401/dcn401_dsc.c    |   2 +-
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   |   2 +
 .../drm/amd/display/dc/link/link_detection.c  |  25 +-
 .../gpu/drm/amd/display/dc/link/link_dpms.c   |   6 +-
 .../dc/link/protocols/link_dp_capability.c    |   5 +-
 .../dc/resource/dcn31/dcn31_resource.c        |   2 +
 .../dc/resource/dcn315/dcn315_resource.c      |   2 +
 .../dcn42/dcn42_soc_and_ip_translator.c       |   4 +
 .../amd/display/include/ddc_service_types.h   |   1 +
 .../amd/display/modules/freesync/freesync.c   |  32 ++-
 .../amd/display/modules/power/power_helpers.c |  49 ++--
 .../gpu/drm/amd/display/modules/vmid/vmid.c   |   8 +-
 52 files changed, 799 insertions(+), 302 deletions(-)  create mode 100644 =
drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pmo/dml2_pmo_dcn42.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_pm=
o/dml2_pmo_dcn42.h

--
2.34.1

