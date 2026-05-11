Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73127CD37BE
	for <amd-gfx@archiver.kernel.org>; Mon, 11 May 2026 13:05:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 115FD10E537;
	Mon, 11 May 2026 13:05:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="As9i+xjy";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011007.outbound.protection.outlook.com [40.107.208.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3994410E537
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 May 2026 13:05:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JFZTl3R3X02XApITo6FNem2CLTgMh8CYbnA2r1+YedRv/cKsmSq7zurLHIbDX5ysKBxBnZOhnF03giQJVYEm38kebq0smRD8rCRljJ89EykYIYOiaNLHzVx5lfr2n8l1J80aDGrwzII/00YKXHzDu5SkQq6uzeYM4ysU/ih4iXR8IAuYC+QfKvyvOcOPPz/vblYN/8qVLrEoHxy/RtuKSAcr9iGFPISwLscsBbeSaIJLAeO82XG31Y17uULuiHP/pNqJ4Ab8wKytk6GGYSQvq75+n5M4TV7cymMG4veYZfwS9QhX0zEmElY+eU8m+Le27LzNlfHSdr5LLg6i1a6cEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2ewdskmNuA6f8a9OwxjYXUFP9b35PcHyGD+00OCOy6I=;
 b=rfJYCl25p74sz3QtPbnKygxj6ySunHTd4PE/JYMfmxaipd+LwfAfY/aqm+9yOYIgyTtrN+M7nxMIb1cXKqjRUNe6uLAXxISw7fObsrRmpDeinJvmHGnMCNDeUzJsb+eB2qm1+3DepzrtJSJmhrG1b4x0wdGM5dsvgKf1Hp7dBAf34N/2Jy2jH5ZwJYOh+jrZZNVwVDMIBM91scKvX6bPzHmos/6aJP1dW/9YawRXb0baaHoRK0ZubVFMqw0UXYGIDTuY1hnctexg11C8WqRiuKmpqoMoGikICwlgRKw9ar/4sA8rhm4D9Ayf80Ty65t6t06DESveDFpLnz8s39P+Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2ewdskmNuA6f8a9OwxjYXUFP9b35PcHyGD+00OCOy6I=;
 b=As9i+xjyX/oaxzvqEJ2e1sjue8JtRwbk4vIG0enZDmFMV1FC0WkfXkzLbHROqv7ntlmK34bu4q9FD7WCh8ZPOUBzXZrevUVzIFpCJj+CDNG/eSQtd+6FGK8jkojtp1ugRutE2FNKQb59EjUvlIp0jkxv+P4DmvO8htNiHJfFle0=
Received: from DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) by
 CH3PR12MB8879.namprd12.prod.outlook.com (2603:10b6:610:171::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.22; Mon, 11 May
 2026 13:05:48 +0000
Received: from DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::b2e1:64e5:3b9e:738a]) by DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::b2e1:64e5:3b9e:738a%6]) with mapi id 15.20.9891.021; Mon, 11 May 2026
 13:05:47 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Lin, Ping Lei" <PingLei.Lin@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Wentland, Harry" <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)"
 <Sunpeng.Li@amd.com>, "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>, "Li,
 Roman" <Roman.Li@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>, "Chung,
 ChiaHsuan (Tom)" <ChiaHsuan.Chung@amd.com>, "Zuo, Jerry" <Jerry.Zuo@amd.com>, 
 "Wu, Ray" <Ray.Wu@amd.com>, "LIPSKI, IVAN" <IVAN.LIPSKI@amd.com>, "Hung,
 Alex" <Alex.Hung@amd.com>, "Lin, Ping Lei" <PingLei.Lin@amd.com>, "Chen,
 Chen-Yu" <Chen-Yu.Chen@amd.com>
Subject: RE: [PATCH 00/20] DC Patches May 11 2026
Thread-Topic: [PATCH 00/20] DC Patches May 11 2026
Thread-Index: AQHc3SZbS/yJPKJN4k+6orGOzyOxebYI0yuQ
Date: Mon, 11 May 2026 13:05:47 +0000
Message-ID: <DS0PR12MB6534D3BD1B12DC3FC42E26EE9C382@DS0PR12MB6534.namprd12.prod.outlook.com>
References: <20260506043342.2164710-1-PingLei.Lin@amd.com>
In-Reply-To: <20260506043342.2164710-1-PingLei.Lin@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Enabled=True;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SetDate=2026-05-11T13:04:57.0000000Z;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Name=AMD Public
 v26; MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_ContentBits=3;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6534:EE_|CH3PR12MB8879:EE_
x-ms-office365-filtering-correlation-id: fde3f940-ba75-40c6-8c9d-08deaf5e04a7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|18002099003|3023799003|11063799003|38070700021|56012099003|22082099003;
x-microsoft-antispam-message-info: 2W+1weNHCVs6zjVqhzApJdF4LiaGQnnPH+PG0mFBlpSVEDJQRqr+eIKDkA6T28s95xnyzSJf/O0OIDRX1mFEVCJMQSgxePn3ykp38+wttZ6InzFq9O3/yFjzvMdaw1V5CSj6mTCyB03jiWKdmDKDWJIFLen7Xczyz9Cu9KBZHygCWahPTWu4RuVF7BrCZrSDmR4cQK1+xm4xZFcW95Awi+vL+dVm8d0OjMxaEe9fAEBXwjkh6aWPKParr034Fjwt3X85N44Z+4tObfQp4XLfNfBf5Alo26+h+nQn2imh/ARGZcfBfebsvVhEjIMtWrdJQ9JwnQTLVX6AKfIpIGRbQrzCT1HByR1CMQ2+PxutF8t7QoWRAkOGrCgJzHD2oWMrsB/2ybBi/6kXMwzf/cyYd62u1SN7iYu1m7yhPMa/D/93yVn1jSgeb2HipkwWz4kIGwcLEzBlsLLpo6mz0DmU6x47wkmVrUQpUkGLlOUt42ve17vtYxWYiyMGEzi03/DYMiu9xovThlCmXP9yKcXUnitLuF+L+Cy+2BeD1zs/0VmJBagIiZiZv1ZY31vSYbIaRAUuW5AIEpHHZNEJmc37byXAfX+mbAUJ+p5hhFtn0vfeKnzod2TmPjhju3AWBdKAgllVpNF0e9jNi1p5iAXGEbkdPdwN4/3jD5yXzxCoh2bRS12VDt7N+kMBw436GBC281TSn9R64KLcAXSVBWqcnaYvmybFWxs6LevR8AArh2lgStF0qOFEmRJgAIKzH3vY
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6534.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(3023799003)(11063799003)(38070700021)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?m6QuAtDU2rNvg29wGT63HdDr19ILHPt/qZKklyNa7+FDtnC1WRH94yBx4d?=
 =?iso-8859-1?Q?pyuIVBse+RXVbM10FgzkK1KTryF5i8OcPKaNGjYyPCo9btqV4L6HbTO1aJ?=
 =?iso-8859-1?Q?S7jGt+GfykeSj/e8l3rJkAE6IeRXVSgrRZn+39XuFCZfoRzpCLFyOXEVka?=
 =?iso-8859-1?Q?NMgn38PB6Tc54+f73jhkKz7rrpMdB8agtF2DyETjy8eZMd8EtjaWdsKQqa?=
 =?iso-8859-1?Q?zvSMyFoopBt81dXkOJh2ONGHeO9OXValapZ7854/jiIfHNHnWj2J1r2jTs?=
 =?iso-8859-1?Q?4XqPQyg1SQA0Teh1/5NrAA1m9oF3kSoGJ7a8ihsSjqXvfY/pm2phQCRFr1?=
 =?iso-8859-1?Q?QMmf+hIUgrabNURyTG5s40rd4sJAQg9nRK10Zg6Na6YDzQCQIhNQEAr5gu?=
 =?iso-8859-1?Q?UC0pfk3QvmoIQJ2ASRRU9e975bQu7IMiO/EBxzcrfrAVJ9ZOLBXfSNC1ov?=
 =?iso-8859-1?Q?0CTLZrMEZ/97dSIsuK8SI7rawe9bIWBaJQDeyiOqo/cKi4Ldf/fa33lnh4?=
 =?iso-8859-1?Q?ztalvJAgvMN8rTfGQpuTPAlz7hdraHcdNQV5db+ImCfeqNXd/i5Swej9CA?=
 =?iso-8859-1?Q?doGjCqwkqEMllo5NaovWIzXCIk6kKX2zyufea9NXfbXYYNk7DyMSjfUdpA?=
 =?iso-8859-1?Q?cqa+sS4pul2sgopydfC1uG/MznWImX3FoYg+9G/Mkm1EDOVY7hcJKrpSXH?=
 =?iso-8859-1?Q?k4Yi15fe3IHoULYPM0mFnXQS5C//xD9lAyMD1z75lVb8DI1HPqMzRliHpW?=
 =?iso-8859-1?Q?vnKUG2yM9ZPejgXq0sBr/3UaLvXYKvUHfso637QsmN/G9zmNaxFxYSORm9?=
 =?iso-8859-1?Q?l/GOQ19NHIaRl2JqaZodfXYBhl1rArifVznU/BtcIfflNGSazk6Ug6tl+z?=
 =?iso-8859-1?Q?ywjte/5HNhqWy0zhqIsM6z4ryWZUZtXPLcSBhj0QxLWaXMaxYtQJ9dtLDw?=
 =?iso-8859-1?Q?apAmIChBRrEANaZ7lFw7d4zYvj3wVAJka0K7g3Bl010WUhnlSerukGskKs?=
 =?iso-8859-1?Q?iJti7ua2Y9DBWR/WSlZ0msnWgmhwbwTltid+mRsCmIuAa1cQwnEgiL2QOf?=
 =?iso-8859-1?Q?lFAZ8uGZydIzc5vy/+t7CTSMIykRo1reh2TIJNox/9aU0w3IKbrqZys2/t?=
 =?iso-8859-1?Q?TM9EY2w5S3J/Q3maSzCFhzUAa7uAQt+WLK9PwYXD3vYaNB2+rLq7UaoFKS?=
 =?iso-8859-1?Q?fvY2fmcUmrfxHX1OjQE5cXKdox94UdDqIZrHlKdq1oQYdRiGF6TAc5VLgz?=
 =?iso-8859-1?Q?tYHnGVa4F7R6KBYveUOgqwu8Uyfbc3giHUF8xq9zcS6szEAlJoms02qHUL?=
 =?iso-8859-1?Q?guGZnYUAGDwkJRH5D45QQcY8IlgRk4blPTB7yLSyX9ZKgVn2pxySOdaw6O?=
 =?iso-8859-1?Q?4bZlsUyUXcX7IoLvX1fSnQq0wWmCYTdD19a65qI7FgPQxwWDZKtkMmFcn9?=
 =?iso-8859-1?Q?G5HFzpFB7gZ2Ra8Q9tDJw2GA8zl5y7Mzsx5OCJRUsJqppmCWewjQMLo0WN?=
 =?iso-8859-1?Q?6Ho/SaotYrZP33S/RrRuGQRynEkwMeXTMgVYNuPqqMEw2t9tH+Vweec737?=
 =?iso-8859-1?Q?64/+mgBatWlG+KqngwQdlzEkoNijqz1VYv3n0IuM9+jJfzCARCFvQUn+LZ?=
 =?iso-8859-1?Q?DsjHUjw7tnvwkZmge78XIWX60qfgWIibIY0+yHGxiJNtf4JHhNUc7hzshd?=
 =?iso-8859-1?Q?45S5Ol9wQHrzrqgODKGzuT+y35Ajr5MQAHFXkGIkOm/Ga4Wlh7GLCaOeok?=
 =?iso-8859-1?Q?Ag/Q0By1mPtyF/x/NqbDMhxZn6tk+j60CcFPk08Pc0pAib?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fde3f940-ba75-40c6-8c9d-08deaf5e04a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2026 13:05:47.2707 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uAEzBIm5KB36UCXdyvLZqNq2taAbFON2iLLThUf/fYC0d00eM9qQeRv4Ypqzg40AoZg1z5yYHaL81/160ZmNYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8879
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


The patchset consists of the amd-staging-drm-next branch (3abbc6894f696de83=
7f4238a0fc24b236892861a -> drm/amd/display: Promote DC to 3.2.381) with new=
 patches added on top of it.

Tested on Ubuntu 24.04.4, on Wayland and X11, using Gnome.

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
From: James Lin <PingLei.Lin@amd.com>
Sent: Wednesday, May 6, 2026 12:31 AM
To: amd-gfx@lists.freedesktop.org
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.L=
i@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>; Li, Roman <Roman.=
Li@amd.com>; Lin, Wayne <Wayne.Lin@amd.com>; Chung, ChiaHsuan (Tom) <ChiaHs=
uan.Chung@amd.com>; Zuo, Jerry <Jerry.Zuo@amd.com>; Wheeler, Daniel <Daniel=
.Wheeler@amd.com>; Wu, Ray <Ray.Wu@amd.com>; LIPSKI, IVAN <IVAN.LIPSKI@amd.=
com>; Hung, Alex <Alex.Hung@amd.com>; Lin, Ping Lei <PingLei.Lin@amd.com>; =
Chen, Chen-Yu <Chen-Yu.Chen@amd.com>
Subject: [PATCH 00/20] DC Patches May 11 2026

Start from:
6ee9f5160ad6e0bf672329f7680398e718fc56f5
SWDEV-114487 - modules: [BACKPORT] drm/amd/display: Fix divide by zero in c=
alc_psr_num_static_frames

Stopped at:
5e7f507891f430f50c71004b73c5ef4c13224f1a
SWDEV-2 - dc: Promote DC to 3.2.382

This version brings along following update:
-Revert "Enable HUBP/OPTC/DPP power gating" -Revert "Unify fast update clas=
sification paths" -enable ODM 2:1 on single eDP based on pixel clock -Enabl=
e IPS on DCN42 -Add additional IPS entry/exit for PSR/Replay -Separate ABM =
functions into dedicated power_abm.c file -Fix always-true lower-bound asse=
rt -Refactor dc_link_aux_transfer_raw -only call pmfw if smu present flags =
true -Fix multiple compiler warnings -Fix CRC open failure during active re=
ndering -Fix white screen on boot with OLED panel -Fix refresh rate round u=
p case


Charlene Liu (2):
  drm/amd/display: only call pmfw if smu present flags true
  drm/amd/display: enable ODM 2:1 on single eDP based on pixel clock

ChunTao Tso (1):
  drm/amd/display: Fix refresh rate round up case

Clay King (1):
  drm/amd/display: Fix warnings

Gaghik Khachatrian (5):
  drm/amd/display: Fix signed/unsigned comparison mismatches
  drm/amd/display: Fix compiler warnings in dml2
  drm/amd/display: Fix multiple compiler warnings
  drm/amd/display: always-true lower-bound assert
  drm/amd/display: Fix enum decl warnings

Ivan Lipski (2):
  drm/amd/display: Add additional IPS entry/exit for PSR/Replay
  drm/amd/display: Enable IPS on DCN42

Leo Chen (1):
  drm/amd/display: Revert "Enable HUBP/OPTC/DPP power gating"

Lohita Mudimela (1):
  drm/amd/display: Separate ABM functions into dedicated power_abm.c
    file

Matthew Stewart (1):
  drm/amd/display: Refactor dc_link_aux_transfer_raw

Mikhail Gavrilov (1):
  drm/amd/display: Wrap DCN32 phantom-plane allocation in
    DC_RUN_WITH_PREEMPTION_ENABLED

Ovidiu Bunea (1):
  drm/amd/display: Revert "Unify fast update classification paths"

Ray Wu (1):
  drm/amd/display: Fix white screen on boot with OLED panel

Taimur Hassan (2):
  drm/amd/display: [FW Promotion] Release 0.1.59.0
  drm/amd/display: Promote DC to 3.2.382

Tom Chung (1):
  drm/amd/display: Fix CRC open failure during active rendering

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   22 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c |    7 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c |   77 +
 .../display/dc/clk_mgr/dce100/dce_clk_mgr.c   |    6 +-
 .../display/dc/clk_mgr/dce100/dce_clk_mgr.h   |    2 +-
 .../display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c  |    8 +-
 .../dc/clk_mgr/dcn30/dcn30_clk_mgr_smu_msg.c  |    4 +-
 .../dc/clk_mgr/dcn30/dcn30_clk_mgr_smu_msg.h  |    2 +-
 .../display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c  |    2 +-
 .../dc/clk_mgr/dcn401/dcn401_clk_mgr.c        |    2 +-
 .../dc/clk_mgr/dcn401/dcn401_clk_mgr.h        |    4 +-
 .../clk_mgr/dcn401/dcn401_clk_mgr_smu_msg.c   |    4 +-
 .../clk_mgr/dcn401/dcn401_clk_mgr_smu_msg.h   |    2 +-
 .../display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c  |   11 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  260 +-
 .../drm/amd/display/dc/core/dc_hw_sequencer.c |   12 -
 .../drm/amd/display/dc/core/dc_link_exports.c |    2 +-
 .../gpu/drm/amd/display/dc/core/dc_resource.c |   18 +-
 .../gpu/drm/amd/display/dc/core/dc_state.c    |    6 +-
 .../gpu/drm/amd/display/dc/core/dc_stream.c   |    4 +-
 .../drm/amd/display/dc/core/dc_vm_helper.c    |    4 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |  105 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |    3 +-
 drivers/gpu/drm/amd/display/dc/dc_dsc.h       |    2 +-
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |    7 +-
 drivers/gpu/drm/amd/display/dc/dc_types.h     |    2 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_aux.c  |   20 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_aux.h  |    4 +
 .../amd/display/dc/dcn21/dcn21_link_encoder.c |    2 +-
 .../display/dc/dio/dcn10/dcn10_link_encoder.c |    2 +-
 drivers/gpu/drm/amd/display/dc/dm_helpers.h   |    1 +
 .../drm/amd/display/dc/dml/dcn20/dcn20_fpu.c  |    6 +-
 .../dc/dml/dcn21/display_mode_vba_21.c        |   36 +-
 .../drm/amd/display/dc/dml/dcn30/dcn30_fpu.c  |    4 +-
 .../dc/dml/dcn30/display_mode_vba_30.c        |  342 +--
 .../amd/display/dc/dml/dcn301/dcn301_fpu.c    |    2 +-
 .../dc/dml/dcn31/display_mode_vba_31.c        |  408 ++--
 .../amd/display/dc/dml/dcn314/dcn314_fpu.c    |   10 +-
 .../dc/dml/dcn314/display_mode_vba_314.c      |  400 +--
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  |   15 +-
 .../dc/dml/dcn32/display_mode_vba_util_32.c   |    8 +-
 .../dc/dml/dcn32/display_mode_vba_util_32.h   |    8 +-
 .../drm/amd/display/dc/dml/dcn35/dcn35_fpu.c  |   10 +-
 .../amd/display/dc/dml/dcn351/dcn351_fpu.c    |   10 +-
 .../drm/amd/display/dc/dml/display_mode_vba.h |   12 +-
 .../amd/display/dc/dml2_0/display_mode_core.c |    6 +-
 .../drm/amd/display/dc/dml2_0/dml2_utils.c    |    2 +-
 .../amd/display/dc/dpp/dcn10/dcn10_dpp_cm.c   |    2 +-
 .../drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c  |    2 +-
 .../amd/display/dc/dpp/dcn30/dcn30_dpp_cm.c   |    4 +-
 drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c   |    2 +-
 .../drm/amd/display/dc/dsc/dcn20/dcn20_dsc.c  |    8 +-
 .../drm/amd/display/dc/dsc/dcn35/dcn35_dsc.c  |    8 +-
 .../amd/display/dc/dsc/dcn401/dcn401_dsc.c    |   10 +-
 .../amd/display/dc/hubp/dcn401/dcn401_hubp.c  |    4 +-
 .../amd/display/dc/hubp/dcn401/dcn401_hubp.h  |    2 +-
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   |   10 +-
 .../amd/display/dc/hwss/dcn30/dcn30_hwseq.c   |    8 +-
 .../amd/display/dc/hwss/dcn314/dcn314_hwseq.c |    2 +-
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.c   |    2 +-
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   |    2 +-
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |    5 +-
 drivers/gpu/drm/amd/display/dc/inc/bw_fixed.h |    2 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h  |    2 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/opp.h   |    4 +-
 .../amd/display/dc/inc/hw/timing_generator.h  |    8 +-
 .../gpu/drm/amd/display/dc/inc/link_service.h |    2 +-
 .../gpu/drm/amd/display/dc/inc/reg_helper.h   |   72 +-
 .../drm/amd/display/dc/link/link_detection.c  |    2 +-
 .../drm/amd/display/dc/link/link_detection.h  |    2 +-
 .../amd/display/dc/link/protocols/link_ddc.c  |    7 +-
 .../link/protocols/link_edp_panel_control.c   |    8 +-
 .../drm/amd/display/dc/mpc/dcn10/dcn10_mpc.c  |    2 +-
 .../drm/amd/display/dc/mpc/dcn30/dcn30_mpc.c  |    6 +-
 .../drm/amd/display/dc/opp/dcn20/dcn20_opp.c  |    2 +-
 .../drm/amd/display/dc/opp/dcn20/dcn20_opp.h  |    2 +-
 .../amd/display/dc/optc/dcn32/dcn32_optc.c    |    2 +-
 .../dc/resource/dce100/dce100_resource.c      |   10 +-
 .../dc/resource/dce110/dce110_resource.c      |    8 +-
 .../dc/resource/dce112/dce112_resource.c      |    4 +-
 .../dc/resource/dce120/dce120_resource.c      |    6 +-
 .../dc/resource/dce80/dce80_resource.c        |    8 +-
 .../dc/resource/dcn10/dcn10_resource.c        |   15 +-
 .../dc/resource/dcn20/dcn20_resource.c        |   60 +-
 .../dc/resource/dcn21/dcn21_resource.c        |   26 +-
 .../dc/resource/dcn30/dcn30_resource.c        |   63 +-
 .../dc/resource/dcn301/dcn301_resource.c      |   31 +-
 .../dc/resource/dcn302/dcn302_resource.c      |   22 +-
 .../dc/resource/dcn303/dcn303_resource.c      |   22 +-
 .../dc/resource/dcn31/dcn31_resource.c        |   30 +-
 .../dc/resource/dcn314/dcn314_resource.c      |   26 +-
 .../dc/resource/dcn315/dcn315_resource.c      |   37 +-
 .../dc/resource/dcn316/dcn316_resource.c      |   29 +-
 .../dc/resource/dcn32/dcn32_resource.c        |   33 +-
 .../resource/dcn32/dcn32_resource_helpers.c   |    6 +-
 .../dc/resource/dcn321/dcn321_resource.c      |   22 +-
 .../dc/resource/dcn35/dcn35_resource.c        |   26 +-
 .../dc/resource/dcn351/dcn351_resource.c      |   26 +-
 .../dc/resource/dcn36/dcn36_resource.c        |   26 +-
 .../dc/resource/dcn401/dcn401_resource.c      |   32 +-
 .../dc/resource/dcn42/dcn42_resource.c        |   50 +-
 .../dc/resource/dcn42/dcn42_resource_fpu.c    |   22 +
 .../dc/resource/dcn42/dcn42_resource_fpu.h    |    2 +-
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |   32 +-
 .../gpu/drm/amd/display/include/fixed31_32.h  |    6 +-
 .../amd/display/modules/color/color_gamma.c   |   28 +-
 .../drm/amd/display/modules/hdcp/hdcp_log.c   |    2 +-
 .../amd/display/modules/inc/mod_color_types.h |   47 +
 .../amd/display/modules/inc/mod_info_packet.h |    9 +-
 .../modules/inc/mod_info_packet_types.h       |   37 +
 .../drm/amd/display/modules/inc/mod_power.h   |   25 +
 .../drm/amd/display/modules/power/Makefile    |    2 +-
 .../gpu/drm/amd/display/modules/power/power.c | 1323 +---------  .../drm/a=
md/display/modules/power/power_abm.c | 2160 +++++++++++++++++  .../amd/disp=
lay/modules/power/power_helpers.c |  823 +------
 .../amd/display/modules/power/power_helpers.h |    1 +
 116 files changed, 3922 insertions(+), 3295 deletions(-)  create mode 1006=
44 drivers/gpu/drm/amd/display/modules/inc/mod_color_types.h
 create mode 100644 drivers/gpu/drm/amd/display/modules/inc/mod_info_packet=
_types.h
 create mode 100644 drivers/gpu/drm/amd/display/modules/power/power_abm.c

--
2.43.0

