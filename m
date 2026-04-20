Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55DA4F588C4
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Apr 2026 12:54:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EAFA210E5A1;
	Mon, 20 Apr 2026 12:54:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BkOJ7ddc";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011006.outbound.protection.outlook.com [52.101.62.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C42C810E5A3
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Apr 2026 12:54:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WhVkt7GNQglsk2sOY5q3HUnPe7qcYdokiA7j/v6SSn4QZTlCQSF/szFetVgrCYS7F+FHyeoqeCKbtonfsNz1Dk93NnqYMGfxt1PfcnB85zqFzTxbwelbOQHjrmNi8g1MPmskHIqCn6OIdx98dKmy50dCfetu9loEb0p/hQzm1SKHBX+hIeNkDdwWdObZw1WeQ6Yfgu/9cEpz9DTVw5sSMcX9LIvm0MprJ8d7WtwR29djqw6IBilGp6CzOSAuxPy78DNUs5/ahI9RRHu2nAc4hk0p7O4wmIoMKHEz2zsFuRMR1ypfD3I/hCUs4Dbqdrv2gKZO4t1E3n8qGOmIZAT8Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LH2PXflvBw15kDhku2J3Jg2zkk0eRsu4B66DmNSr7Ao=;
 b=c84oZNq3Ht4Z2QJtcWSNU2UEWzg0VkiQ8ZfKQKKgotbfjS7vVXx/OyjeH4n7Hm69CgOOhVeTtw36b1qzK/bJyVXm2XbuQg6vihXrwGMyhHaLoXZeYC2l859/miw/7EOV7NxG0xDYD5VuqUlZzVS5rWpFFzIsdBO52muhP6pM1KT4fqEJz9HRuhIkiRn2/QMfZ5gi5IRpzOv0yW9fSwZ3A4hbdTcb+w+hqZ1lHws04qSfuz3yqdYisrLd3xnoh/tjha+rrcEg/K2gOCdq68RNHvLCiqsLh+nORI0GIsYNX7FQGJYvwlGt58rj1GwqV1+MqDbht4fhKE/88Q5fseRT7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LH2PXflvBw15kDhku2J3Jg2zkk0eRsu4B66DmNSr7Ao=;
 b=BkOJ7ddcPULqPyzCayikEfsD9tiPfG47jj0UiIEf+zp2vKhE9f4Ui6dNZdQ38dZRcAXjm4T4VsFMikge7hzNW4bFZaWfL3aHQHgC+16m4y6ivVmtg5nt1XRKzDIo8T1Y/pTIRZjO8dh/hbSTIN4AA67rHyGSBkfANloQk79ygYk=
Received: from DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) by
 IA0PR12MB8696.namprd12.prod.outlook.com (2603:10b6:208:48f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.15; Mon, 20 Apr
 2026 12:54:39 +0000
Received: from DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::b2e1:64e5:3b9e:738a]) by DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::b2e1:64e5:3b9e:738a%4]) with mapi id 15.20.9846.007; Mon, 20 Apr 2026
 12:54:38 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Chen, Chen-Yu" <Chen-Yu.Chen@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Wentland, Harry" <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)"
 <Sunpeng.Li@amd.com>, "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>, "Li,
 Roman" <Roman.Li@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>, "Chung,
 ChiaHsuan (Tom)" <ChiaHsuan.Chung@amd.com>, "Zuo, Jerry" <Jerry.Zuo@amd.com>, 
 "Wu, Ray" <Ray.Wu@amd.com>, "LIPSKI, IVAN" <IVAN.LIPSKI@amd.com>, "Hung,
 Alex" <Alex.Hung@amd.com>, "Tseng, Chuan Yu (Max)" <ChuanYu.Tseng@amd.com>,
 "Chen, Chen-Yu" <Chen-Yu.Chen@amd.com>
Subject: RE: [PATCH 00/19] DC Patches Apr 20 2026
Thread-Topic: [PATCH 00/19] DC Patches Apr 20 2026
Thread-Index: AQHczKtvSOT7oe7FXU2+zXOIwkKxiLXn8CjQ
Date: Mon, 20 Apr 2026 12:54:38 +0000
Message-ID: <DS0PR12MB65347B18A90D5C5F5317DE619C2F2@DS0PR12MB6534.namprd12.prod.outlook.com>
References: <20260415074223.34848-1-chen-yu.chen@amd.com>
In-Reply-To: <20260415074223.34848-1-chen-yu.chen@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2026-04-20T12:54:10.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6534:EE_|IA0PR12MB8696:EE_
x-ms-office365-filtering-correlation-id: 1213880a-487d-4500-1964-08de9edbfb90
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info: 0JTzaBzlmpK5NWdEh0YKAbgGEMGKo1zbdDdh2YfM5u6KLy2FXfaFKWJE+9eh5w5Z7TsIcTAzFehNMDR79n7fx8iZe8CPmjoA4KtToxF/CQYsNxpMWAu5LRvK7QEAdR7W05T0AvOjKL9a81LjRj2uF5X9jRIxWoxzfpJcvdfGtPoe9i6Wv+o8YGsRpSjFE/HsuynJmizUTS/znu6j81wiuq5NQOdHhBcjVe6LC46eh/RVmJj/hKWI2byyEqFhRRJWYReu03yk9kORncSii9SZzUVFJOrE41KUtCdxJwy6YLEUpeQp3KI3cJEySirNbyYz9cM/rBeRLLblNBTTT7qNKrW70nOKJHjLMrM8ny751kV7hZqNSvT0X4GwPolEN78SPa3z4OEBjyIjHIgRhH571mZ2XlJOJYZoo5FvdWKLi3qo5K30R1nYfjCF9I3AU/VX6RONYYl12HK9UdmeYlLlzAta4RGw0tBSyojNfhat/G/HrCQUQC+Ec5SYvQld64p0UShsl0y5gEqbitPXQ3HR+0y5Hvct8jXptUZ/Z+Hoteec5120rlBc6xjMkjaKumXszN+wmhHjwPzbAfhdeAnXtuuxj0zssj0Q3aMMifhFha6IkoNqjrvRP9OoMmFgBIGoYouQ+o85iUi5nx2TemmYC4JpEWlMwAGcy4QbDVkytKaDa1ixFwEyg/BJ6vOw5YU6s3fB8S5Bd4gZ8afixFqFAoTg6aRV+eFUOESPnoDCxjlpiU8xMA19h7EuL33K4m/SmVV7yg+70F9KCewqbCzuX4INjaKPzGMVQFgNd4TPftY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6534.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?XOcg5lFa4kuNiahX+XnK3hBzLcsDsNpm4jQt5tXVsukoB4j47q63VWn5Ea?=
 =?iso-8859-1?Q?NKrT+DWyXsyhMUWnrJbf9AJa2ILi4gkoPoler8byMmvGVuTqdhPPKJli+p?=
 =?iso-8859-1?Q?+8ndEW67e5px204cdJHN3se8WQOWsVs/leov68aq1Wp9kVI3kcWAdesSQQ?=
 =?iso-8859-1?Q?1sX1Kz9pVmg6Dp21PqA8Vp+fqFdRcF2FI5z6ep40HQJJ/2maToG9uXOXpA?=
 =?iso-8859-1?Q?W3Y4jD3Zku3PAqyQMd4TdGfKUJlzIiA+PCIBthD+Xwpsb1FyHWxhA9GLNk?=
 =?iso-8859-1?Q?693zHbnKC/q4N7XRaiLmRv7o6tBNEOiOd4G/R3xvn8F9XSjditBch/6CJ7?=
 =?iso-8859-1?Q?cZsk3NaTjbRrQDp5Xbr5GNx7t2yW2yVeAmKcdeC99hYv83LZ0Ip0HPkPXc?=
 =?iso-8859-1?Q?ZROvuMzjTaLznnnbHhyPv2gc746U/m/Fzz5829GrHD6He/3xd1EyU1Ep+h?=
 =?iso-8859-1?Q?ELmOmiz9mm6IVYN8e0I2y4eTYbmaLLNsKVymZkadank0GzRc/hKece/6sl?=
 =?iso-8859-1?Q?tdZuJIPl7jHJBWFQsWy9q/+xSTjFMiQILHoRKrJL+LR20Rza8gX8OxXRF6?=
 =?iso-8859-1?Q?KVKlmh/U1UB30fx9FJQzte/58U0HaEDMriJUs0jgRtbhr6oT8/mmUkLxUm?=
 =?iso-8859-1?Q?+iubyGd7LPuXwWWXaa05TSSl53nPVXW8P/eZoSc2a5yurxInPsTF8JWE1D?=
 =?iso-8859-1?Q?YZbRzyzXlga9cQImgl+edhIDhRdZcZWkZdnP11ykbgmcsTBC8xQNlq0nl2?=
 =?iso-8859-1?Q?m0d12HFTEsbrw+g6P+SYw2anizm+4aSKOPR9FNa4Zvn/45eM49uAOrpJCk?=
 =?iso-8859-1?Q?CuB8qNIbBPMyFsV8NWltc54HvilXdlIB+LQ3D1mZ12vRTJxj3qwpEIq4fG?=
 =?iso-8859-1?Q?/oYoW3+0qew8StToWh549lCyGYtcnd/o2qweE7J77ReVke5b8/JayZLxDl?=
 =?iso-8859-1?Q?Q7XT5IKxNlILVmJf7ceIkty7Oc4K4KCj24pONJe5ifkBa6Eed2nktRgR5b?=
 =?iso-8859-1?Q?wJwWNtdNXh0KQJNMUXhESsoMZGy1OWjy2cuIGJzNggvsII5XbJYHky8AFL?=
 =?iso-8859-1?Q?hJ7wkApo4UhSDNUg2L6zwgmXrb12LzfvFSXt8yJRGGptbr+bVFTkCMuMKj?=
 =?iso-8859-1?Q?ai521XMk3h6dHC/fRdztDkjRekPHGb3mqIuDqxaOR4F7g9KRXclpBc/I3u?=
 =?iso-8859-1?Q?tPYhjuLN6nUDrj4kIi1tJkkSy2cGAecvo0VKIOybUnRY8MLSB8UBtKF2Ab?=
 =?iso-8859-1?Q?9ZNWskJrFpcStJptf6oiFdH9Vwn6F1VP7gjYW8YfQOsaoik5XDf3tluAk3?=
 =?iso-8859-1?Q?9doz4TeJN7lUaAxbNppILHQuF+5OVf+F4t7htaKjxx4Fz6HpGF5XyCZC9O?=
 =?iso-8859-1?Q?RsH9H3ZjIy1f4iASBh6+Wea+ceHWLjISI0HobEgwM3wCB6GM7vofHmbuXp?=
 =?iso-8859-1?Q?jGb8KiUTvGuNqenRImBBHnOfiepD08Q6X5gyx99ykFoZq5M02FA4An2l42?=
 =?iso-8859-1?Q?CEnW7Yislu7T9hhE8N0vl6+ZvDhaRJ5aLe6Mmxnw6FkIJFjbfKuXNYTAwY?=
 =?iso-8859-1?Q?IW2eLJpjGhEaeQa5CzECWGezFENyo/hKWXAZSwS5ntHQEYitxPtuwg8ydO?=
 =?iso-8859-1?Q?aprETXOXNRzmBDeeZi/s2xMGMX6WnRVZIEGZPH2YplDOyRB1KThk2ooYp0?=
 =?iso-8859-1?Q?VtrKlU6X/NFWv6y8ZVJWYF6JkfXJkmKdpaHx8isuFWUklaJ9mFnYhfWtg5?=
 =?iso-8859-1?Q?BvttCL6yCivo667yhPWDnNN2Dq+dOiJYsFuoeD59osTGC0?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1213880a-487d-4500-1964-08de9edbfb90
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2026 12:54:38.8544 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 79PMhUHunh9GldnfHIKl/fxT5P1kwcrfL+0LHT+QHirrdvMcGFmqk4Tn8JdjaCH2qLblyyCcrp8r3PU9ZQ1sBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8696
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


The patchset consists of the amd-staging-drm-next branch (Head commit - 5fc=
862467a34397739ce66733b6344c4e671ef50 -> drm/amdgpu/userq: unmap_helper don=
t return the queue state) with new patches added on top of it.

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
Sent: Wednesday, April 15, 2026 3:40 AM
To: amd-gfx@lists.freedesktop.org
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.L=
i@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>; Li, Roman <Roman.=
Li@amd.com>; Lin, Wayne <Wayne.Lin@amd.com>; Chung, ChiaHsuan (Tom) <ChiaHs=
uan.Chung@amd.com>; Zuo, Jerry <Jerry.Zuo@amd.com>; Wheeler, Daniel <Daniel=
.Wheeler@amd.com>; Wu, Ray <Ray.Wu@amd.com>; LIPSKI, IVAN <IVAN.LIPSKI@amd.=
com>; Hung, Alex <Alex.Hung@amd.com>; Tseng, Chuan Yu (Max) <ChuanYu.Tseng@=
amd.com>; Chen, Chen-Yu <Chen-Yu.Chen@amd.com>
Subject: [PATCH 00/19] DC Patches Apr 20 2026

This DC patchset brings improvements in multiple areas. In summary, we high=
light:

 - Add allow_clock_gating to dcn42 dccg.
 - Bypass post csc for additional color spaces in dcn42.
 - Remove unused dml2_project.
 - Unset Replay desync error verification by default.
 - Align HWSS fast commit path with legacy path.
 - Fix implicit narrowing conversion warnings.
 - Enable driver power gating.
 - Fix double free.
 - Introduce power module on Linux.
 - Add power module on Linux.
 - Fix fpu guard warning.
 - Add Replay/PSR active check in link loss status check.
 - Remove SYMCLK F and G values from link encoder and MANUAL_FLOW_CONTROL f=
rom optc.
 - Add minimum vfp requirement.
 - Fix narrowing boundaries and eDP parser assignment.
 - Fix dml2_0 narrowing boundaries.
 - Add README.md file to DML2_0 repository.
 - Fix DPMS using partially updated pipe context.
 - Move dml2_destroy to non-FPU compilation unit.

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Allen Li (2):
  drm/amd/display: Unset Replay desync error verification by default
  drm/amd/display: Add Replay/PSR active check in link loss status check

Andrew Lichmanov (1):
  drm/amd/display: Remove SYMCLK F and G values from link encoder and
    MANUAL_FLOW_CONTROL from optc

Dillon Varone (1):
  drm/amd/display: Add minimum vfp requirement

Dominik Kaszewski (1):
  drm/amd/display: Fix DPMS using partially updated pipe context

Gaghik Khachatrian (3):
  drm/amd/display: Fix implicit narrowing conversion warnings
  drm/amd/display: Fix narrowing boundaries and eDP parser assignment
  drm/amd/display: Fix dml2_0 narrowing boundaries

Ilya Bakoulin (1):
  drm/amd/display: Fix double free

Rafal Ostrowski (2):
  drm/amd/display: Align HWSS fast commit path with legacy path
  drm/amd/display: Move dml2_destroy to non-FPU compilation unit

Ray Wu (2):
  drm/amd/display: Introduce power module on Linux
  drm/amd/display: Add power module on Linux

Roman Li (3):
  drm/amd/display: Add allow_clock_gating to dcn42 dccg
  drm/amd/display: bypass post csc for additional color spaces in dcn42
  drm/amd/display: Remove unused dml2_project

Samson Tam (1):
  drm/amd/display: Add README.md file to DML2_0 repository

Taimur Hassan (1):
  drm/amd/display: Promote DC to 3.2.379

Wayne Lin (1):
  drm/amd/display: Fix fpu guard warning

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  344 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   10 +
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c |   36 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    |   74 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_crtc.h    |    5 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c |   60 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c |   26 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c |  242 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_psr.h |   13 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_replay.c  |  143 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_replay.h  |   28 +-
 .../display/amdgpu_dm/amdgpu_dm_services.c    |   27 +
 .../drm/amd/display/dc/basics/custom_float.c  |    2 +-
 .../gpu/drm/amd/display/dc/basics/dce_calcs.c |    2 +-
 .../gpu/drm/amd/display/dc/bios/bios_parser.c |    6 +-
 .../drm/amd/display/dc/bios/bios_parser2.c    |   21 +-
 .../drm/amd/display/dc/bios/command_table.c   |   12 +-
 .../drm/amd/display/dc/bios/command_table2.c  |    4 +-
 .../dc/clk_mgr/dce110/dce110_clk_mgr.c        |    6 +-
 .../amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c |   12 +-
 .../display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c  |   39 +-
 .../display/dc/clk_mgr/dcn301/vg_clk_mgr.c    |   13 +-
 .../display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c  |   14 +-
 .../dc/clk_mgr/dcn314/dcn314_clk_mgr.c        |   14 +-
 .../dc/clk_mgr/dcn315/dcn315_clk_mgr.c        |   15 +-
 .../dc/clk_mgr/dcn316/dcn316_clk_mgr.c        |   15 +-
 .../display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c  |   43 +-
 .../display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c  |   16 +-
 .../dc/clk_mgr/dcn401/dcn401_clk_mgr.c        |   40 +-
 .../display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c  |   22 +-
 .../amd/display/dc/clk_mgr/dcn42/dcn42_smu.c  |    1 -
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  206 +-
 .../drm/amd/display/dc/core/dc_hw_sequencer.c |  565 ++-
 .../gpu/drm/amd/display/dc/core/dc_resource.c |   66 +-
 .../gpu/drm/amd/display/dc/core/dc_stream.c   |   26 +-
 .../gpu/drm/amd/display/dc/core/dc_surface.c  |    2 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |   17 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |  137 +-
 drivers/gpu/drm/amd/display/dc/dc_fused_io.c  |    6 +-
 drivers/gpu/drm/amd/display/dc/dc_helper.c    |   12 +-
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |   38 +-
 drivers/gpu/drm/amd/display/dc/dc_types.h     |   30 +
 .../amd/display/dc/dccg/dcn31/dcn31_dccg.c    |    4 +-
 .../amd/display/dc/dccg/dcn401/dcn401_dccg.c  |   20 +-
 .../amd/display/dc/dccg/dcn42/dcn42_dccg.c    |    2 +
 drivers/gpu/drm/amd/display/dc/dce/dce_aux.c  |    4 +-
 .../drm/amd/display/dc/dce/dce_clock_source.c |   24 +-
 .../gpu/drm/amd/display/dc/dce/dce_i2c_hw.c   |    2 +-
 .../gpu/drm/amd/display/dc/dce/dce_i2c_sw.c   |   16 +-
 .../drm/amd/display/dc/dce/dce_panel_cntl.c   |    4 +-
 .../drm/amd/display/dc/dce/dce_transform.c    |    8 +-
 .../gpu/drm/amd/display/dc/dce/dmub_abm_lcd.c |   14 +-
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c |   12 +-
 .../gpu/drm/amd/display/dc/dce/dmub_replay.c  |   23 +-
 .../display/dc/dce80/dce80_timing_generator.c |    2 +-
 .../amd/display/dc/dcn10/dcn10_cm_common.c    |    4 +-
 .../drm/amd/display/dc/dcn30/dcn30_mmhubbub.c |   16 +-
 .../dc/dio/dcn401/dcn401_dio_stream_encoder.c |    2 +-
 .../dc/dio/dcn42/dcn42_dio_link_encoder.h     |    2 -
 .../dc/dio/dcn42/dcn42_dio_stream_encoder.c   |    4 +-
 .../drm/amd/display/dc/dml/calcs/dcn_calcs.c  |    5 +-
 .../drm/amd/display/dc/dml/dcn20/dcn20_fpu.c  |    9 +-
 .../drm/amd/display/dc/dml/dcn20/dcn20_fpu.h  |    2 +-
 .../drm/amd/display/dc/dml/dcn30/dcn30_fpu.c  |    2 +-
 .../drm/amd/display/dc/dml/dcn31/dcn31_fpu.c  |    6 +-
 .../drm/amd/display/dc/dml/dcn31/dcn31_fpu.h  |    6 +-
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  |   37 +-
 .../gpu/drm/amd/display/dc/dml2_0/README.md   |   31 +
 .../amd/display/dc/dml2_0/display_mode_core.c |   14 +-
 .../amd/display/dc/dml2_0/display_mode_util.c |   20 +-
 .../dml2_0/dml21/dml21_translation_helper.c   |   15 +-
 .../amd/display/dc/dml2_0/dml21/dml21_utils.c |    2 +-
 .../display/dc/dml2_0/dml21/dml21_wrapper.c   |    4 +-
 .../dc/dml2_0/dml21/inc/dml_top_types.h       |    1 -
 .../dml21/src/dml2_core/dml2_core_factory.c   |    1 -
 .../dml21/src/dml2_dpmm/dml2_dpmm_factory.c   |    1 -
 .../dml21/src/dml2_mcg/dml2_mcg_factory.c     |    1 -
 .../dml21/src/dml2_pmo/dml2_pmo_factory.c     |    3 +-
 .../dml21/src/dml2_top/dml2_top_interfaces.c  |    1 -
 .../amd/display/dc/dml2_0/dml2_mall_phantom.c |  100 +-
 .../drm/amd/display/dc/dml2_0/dml2_policy.c   |    6 +-
 .../dc/dml2_0/dml2_translation_helper.c       |    4 +-
 .../drm/amd/display/dc/dml2_0/dml2_utils.c    |   40 +-
 .../drm/amd/display/dc/dml2_0/dml2_wrapper.c  |   11 +
 .../amd/display/dc/dml2_0/dml2_wrapper_fpu.c  |   10 -
 .../drm/amd/display/dc/dpp/dcn42/dcn42_dpp.c  |    6 +-
 .../drm/amd/display/dc/dsc/dcn20/dcn20_dsc.c  |   16 +-
 .../gpu/drm/amd/display/dc/dsc/rc_calc_dpi.c  |   33 +-
 drivers/gpu/drm/amd/display/dc/gpio/hw_ddc.c  |    2 +-
 .../gpu/drm/amd/display/dc/gpio/hw_generic.c  |    2 +-
 drivers/gpu/drm/amd/display/dc/gpio/hw_gpio.c |    2 +-
 drivers/gpu/drm/amd/display/dc/gpio/hw_gpio.h |    9 +
 drivers/gpu/drm/amd/display/dc/gpio/hw_hpd.c  |    2 +-
 .../display/dc/hubbub/dcn10/dcn10_hubbub.c    |   16 +-
 .../display/dc/hubbub/dcn20/dcn20_hubbub.c    |   28 +-
 .../display/dc/hubbub/dcn20/dcn20_hubbub.h    |    3 +
 .../display/dc/hubbub/dcn21/dcn21_hubbub.c    |   12 +-
 .../display/dc/hubbub/dcn30/dcn30_hubbub.c    |   12 +-
 .../display/dc/hubbub/dcn31/dcn31_hubbub.c    |   12 +-
 .../amd/display/dc/hubp/dcn20/dcn20_hubp.c    |    4 +-
 .../amd/display/dc/hubp/dcn21/dcn21_hubp.c    |    4 +-
 .../amd/display/dc/hubp/dcn30/dcn30_hubp.c    |    4 +-
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c |   33 +-
 .../amd/display/dc/hwss/dce120/dce120_hwseq.c |   12 +-
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   |   12 +-
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   |   13 +-
 .../amd/display/dc/hwss/dcn21/dcn21_hwseq.c   |    8 +-
 .../amd/display/dc/hwss/dcn30/dcn30_hwseq.c   |   16 +-
 .../amd/display/dc/hwss/dcn314/dcn314_hwseq.c |    4 +-
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.c   |    4 +-
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   |    6 +-
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |   18 +-
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |  138 +
 drivers/gpu/drm/amd/display/dc/inc/bw_fixed.h |    2 +-
 .../dc/irq/dce110/irq_service_dce110.c        |    2 +-
 .../display/dc/link/accessories/link_dp_cts.c |   37 +-
 .../display/dc/link/hwss/link_hwss_hpo_dp.c   |    4 +-
 .../drm/amd/display/dc/link/link_detection.c  |    4 +-
 .../gpu/drm/amd/display/dc/link/link_dpms.c   |   16 +-
 .../drm/amd/display/dc/link/link_factory.c    |    6 +-
 .../amd/display/dc/link/protocols/link_ddc.c  |    5 +-
 .../dc/link/protocols/link_dp_capability.c    |    2 +-
 .../display/dc/link/protocols/link_dp_dpia.c  |    2 +-
 .../dc/link/protocols/link_dp_dpia_bw.c       |   10 +-
 .../dc/link/protocols/link_dp_irq_handler.c   |   57 +-
 .../dc/link/protocols/link_dp_panel_replay.c  |   27 +-
 .../link/protocols/link_dp_training_8b_10b.c  |   10 +-
 .../link/protocols/link_edp_panel_control.c   |   41 +-
 .../dc/mmhubbub/dcn20/dcn20_mmhubbub.c        |    4 +-
 .../dc/mmhubbub/dcn32/dcn32_mmhubbub.c        |    4 +-
 .../amd/display/dc/optc/dcn20/dcn20_optc.c    |    4 +-
 .../amd/display/dc/optc/dcn42/dcn42_optc.h    |    1 -
 .../dc/resource/dce110/dce110_resource.c      |    4 +-
 .../dc/resource/dcn10/dcn10_resource.c        |    4 +-
 .../dc/resource/dcn20/dcn20_resource.c        |   24 +-
 .../dc/resource/dcn21/dcn21_resource.c        |    9 +-
 .../dc/resource/dcn30/dcn30_resource.c        |   14 +-
 .../dc/resource/dcn301/dcn301_resource.c      |    8 +-
 .../dc/resource/dcn302/dcn302_resource.c      |    4 +-
 .../dc/resource/dcn303/dcn303_resource.c      |    4 +-
 .../dc/resource/dcn31/dcn31_resource.c        |   11 +-
 .../dc/resource/dcn314/dcn314_resource.c      |    4 +-
 .../dc/resource/dcn315/dcn315_resource.c      |   11 +-
 .../dc/resource/dcn316/dcn316_resource.c      |   11 +-
 .../dc/resource/dcn32/dcn32_resource.c        |   20 +-
 .../resource/dcn32/dcn32_resource_helpers.c   |    2 +-
 .../dc/resource/dcn321/dcn321_resource.c      |    4 +-
 .../dc/resource/dcn35/dcn35_resource.c        |    4 +-
 .../dc/resource/dcn351/dcn351_resource.c      |    4 +-
 .../dc/resource/dcn36/dcn36_resource.c        |    4 +-
 .../dc/resource/dcn401/dcn401_resource.c      |    4 +-
 .../dc/resource/dcn42/dcn42_resource.c        |    4 +-
 .../dcn401/dcn401_soc_and_ip_translator.c     |   42 +-
 .../dcn42/dcn42_soc_and_ip_translator.c       |   14 +-
 .../drm/amd/display/modules/inc/mod_power.h   |  415 +++
 .../display/modules/info_packet/info_packet.c |    2 +-
 .../drm/amd/display/modules/power/Makefile    |    2 +-
 .../gpu/drm/amd/display/modules/power/power.c | 3030 +++++++++++++++++
 .../amd/display/modules/power/power_helpers.c |   16 +-
 159 files changed, 5833 insertions(+), 1416 deletions(-)  create mode 1006=
44 drivers/gpu/drm/amd/display/dc/dml2_0/README.md
 create mode 100644 drivers/gpu/drm/amd/display/modules/inc/mod_power.h
 create mode 100644 drivers/gpu/drm/amd/display/modules/power/power.c

--
2.43.0

