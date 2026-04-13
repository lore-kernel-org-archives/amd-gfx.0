Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37DE4F34C4E
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Apr 2026 13:15:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C47FE10E436;
	Mon, 13 Apr 2026 13:15:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WH37nurP";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010055.outbound.protection.outlook.com [52.101.201.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E8E7A10E436
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Apr 2026 13:15:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bHnWwOIxIr2zjqjhrv7oIz3kva014bhcqrPHeoiYhIO0BBgIzZC5NYksz+NffXoYirRn75UlXqZOS++SMbg+/2qnJSyyKNnX39ocfik4mEN64c62r1rr1gsvH4efa1DyTb1osG/tAyj0dUn5UBfpVOoAP+pwuN2/fWiVo+RirkcvH7nbmd+OsLW9HeJdtXsSoGQVu67rN73T5H1DMoITbGFHXlJdIOGe44Z/2H1eUZxFka+cDj75LxPGMu5/3k7bn089iAaANKyPMjnQ3rZzNBFVFiQB96pEkrFHQPW0fZQttyYJ1n7CpiP1Tky4T5hU4zrMus7KvhcqdHA5JKQTvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=twqK95QG4NoP7EgCFe4IogmklE3WPZsnOehLIelHZGU=;
 b=I+m1DaitnJuF9zl4N+gIvnH1eBAnz2blbaycYqCmu+wj/EKO9h4lObmopaNfCQRibKf4OkvkKPnvgPDmQ0Gon/AsQixCivm1tM/DtVYU0Yvlxw8/TlD1Z7teCB0j9CUxgBWl5lHOo7nMCagtyg8PHadxdjA08uKhNy/8wZtFIb6g2CY0Z4E/3BylbVneNSfo1T5KgDgo1BUoVj7UwqtwybYTuxdqDMR9zVOqDS6dwqJbBudU/wFs3jyZ5IuwTorG4PPtyA/zMqUgyMJZQgvU7sIj531WIA+0rGJgJ9wQNsQG+JJFX+TSlDlv8ImcxF7KiNJwjeoDP3O6Ut1ih5Kk7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=twqK95QG4NoP7EgCFe4IogmklE3WPZsnOehLIelHZGU=;
 b=WH37nurPO7SzLF4ocgTAR3Y01BD4FUE9i4MoRkDdjuGLpK/zMZ5nPjh71jnMuP8DOwuQXSF0/4I1cVuRcIvop/mXZ+T32OlvIrR91lTU7Rrn1tBqFQyC0VjSdVS/0hniqjSLfsLooSep17hM4WvqFGXQU5U2NKxZCvnwzzQAwuA=
Received: from DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) by
 PH7PR12MB8106.namprd12.prod.outlook.com (2603:10b6:510:2ba::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9818.20; Mon, 13 Apr 2026 13:15:13 +0000
Received: from DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::b2e1:64e5:3b9e:738a]) by DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::b2e1:64e5:3b9e:738a%4]) with mapi id 15.20.9818.017; Mon, 13 Apr 2026
 13:15:13 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Wentland, Harry" <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)"
 <Sunpeng.Li@amd.com>, "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>, "Li,
 Roman" <Roman.Li@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>, "Chung,
 ChiaHsuan (Tom)" <ChiaHsuan.Chung@amd.com>, "Zuo, Jerry" <Jerry.Zuo@amd.com>, 
 "Wu, Ray" <Ray.Wu@amd.com>, "LIPSKI, IVAN" <IVAN.LIPSKI@amd.com>, "Hung,
 Alex" <Alex.Hung@amd.com>, "Tseng, Chuan Yu (Max)" <ChuanYu.Tseng@amd.com>
Subject: RE: [PATCH 0/6] DC Patches for 13 April 2026
Thread-Topic: [PATCH 0/6] DC Patches for 13 April 2026
Thread-Index: AQHcyDIlWkINlY7ILU6MpdcoijFDPbXc/g6w
Date: Mon, 13 Apr 2026 13:15:13 +0000
Message-ID: <DS0PR12MB653409CFEF11581F9EB37D749C242@DS0PR12MB6534.namprd12.prod.outlook.com>
References: <20260409150413.34779-1-aurabindo.pillai@amd.com>
In-Reply-To: <20260409150413.34779-1-aurabindo.pillai@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2026-04-13T13:14:37.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6534:EE_|PH7PR12MB8106:EE_
x-ms-office365-filtering-correlation-id: 58ed04ff-be9e-4358-eff8-08de995eb271
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: paT2KeP8ApHoh8ztfxM1+8aZ3AuoiTTDuCxsOJUtkFccTiRARD4zBcz7N1H4ePtIBYWCi9xQKoDWYG1y7EO0eTyqueD2f6nz8TlU2mgBkTfS6ocnDKndAaGpaNOGwe/lEIUMw6PmZyT63N7nVfTvYrBRxIBIjf4g1UX6lXk9sf2lMe06iMoEbRf6H9grS2lbeHuSQd+3uH0KFIYMH1hL/sgDk+rcESWK7WOTQkA2Neeh/2zwyBq+udUSBgCNOTQcJhTkP98zfS10I9M4+3nWi+Dr75pm5t94QxRTxbo1wok42CX/NhNC3JR2GPMYtJNKclgllOE/Fgn7GDn9bbodi6U3nIm1b4Le1Dnu0vidtyitUL8EjeiC+bFHhyBo5S3690wyphME9svRyuHebJzix2/rEJsgf/rTK2GAvkuYvewSWwDrOupC9jzx9T30wcRuMf6J9fkj/xfcK1pLs9iTEyMZoNGxrEw1TpbswgMK7WxTxk6n3pCRDGzCMwZCmE+b136AWtuuT4RUgm0wONC/HjWriGTf1oALpBzlOQ/4RTKRcBRkuD7P6t9lx8qd376sVBWvX5t+019l7EwHBPHLEoA+vNmd/ll+SjhLc4sM4YmHDTTW1RuJ88uiQNlg1i32vGhgcUo2YrkD5hwiBU9mryEyLJYSt/Hv/IDE8Sb4UPfOEAeBzNVJ21dezY9ygZcrIWZZC+nzX9Zs14jUYBrHAc2yayfIC864C4fqOQlgU5Lqb7TDRBjLzTIRQKbUklAtqUMsY/bcTPGysEAXzg4CXosN2mMk3Q7YoB4DZwutqRM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6534.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(38070700021)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?7gvgxAlZq+feCpD+voSequfGQyoWDi/+Aiv4IGEM0cJbJVatLPVKDm04Ip?=
 =?iso-8859-1?Q?C+DWbYFfXyrNSZOX9RnECuCOa6XMJyhQ9d+47xh/ie9XqV8p3OA0rmjb5P?=
 =?iso-8859-1?Q?U8CoxlqwKkuJnzvMZzucoFGll3lBsUaLm29btDSnnc4aihH9YDS59jhj9M?=
 =?iso-8859-1?Q?RUsHVMve99uPj5uf5tWU475n6W7X15qSYWfV7ZP7NVu2It7LVfqCf4x6c8?=
 =?iso-8859-1?Q?NSp6sHmCiGdS1VwhxpIIv01EpKLRODxKfQjcDSD9zJMoYmTNSPBXlZyzG8?=
 =?iso-8859-1?Q?R/sAonR2ceTn3jgWo08uLRbdt8WmzOYGdFZOdJsyCGATo3qxzMR7jCgUVA?=
 =?iso-8859-1?Q?ApMrCmbXQZ0HdF0WUhQOKCMEKQLk4Abx3N6dsq72L/HS+aEzefQY67A050?=
 =?iso-8859-1?Q?ZaZJ297tdQRHOlbJwduW4HPoNPP3gR4AlsPqoQIVvKwqztudz8vMsxyVfz?=
 =?iso-8859-1?Q?6QFTSDKIwJya251+l6CW3IaTdAUkHfj37Ahyt2i62ba7brZ9Lb6QAb2dA2?=
 =?iso-8859-1?Q?Cr/7votC2wUMkE+xzCBP1f+DRc5w3iT5qUhzLgOjqNziC/q9utPcSH7Czu?=
 =?iso-8859-1?Q?Tr/rnVy0MQ/6Kbd1ad7TjXg+r1f6BpXq5vsDChrB6ss51Eae/9bCv6F8cr?=
 =?iso-8859-1?Q?+FpJlZo+NPEjpGUD2xFyFQ/wyxrDM1wn+hFP89L1JX1LgsAVee8fqDbjk9?=
 =?iso-8859-1?Q?vkhtPNHjoTPpKAhZfRA7mf9z0BG8N66slUBkDHx496dPZ2nHWEKcgZ5c/d?=
 =?iso-8859-1?Q?q0IZeHOGhJ2iWyzKaMmphR2JI4Ozgih6vOfNy4Xi3bbC0TWrTFi3wESgsg?=
 =?iso-8859-1?Q?UpHcFsOyD73O+k0km49fG4a38TWEpNX9eyXJPyyymg9IDqo2aTHaE8l8YI?=
 =?iso-8859-1?Q?oGHc0Shx1WF4VUjdajMwqjaGiej9pyz7UaR5BNisdnUDdIgX07UnHP2I28?=
 =?iso-8859-1?Q?h93/1WPtKGovUbkZM+mMRa3yX/NceqoZt5BDVYX1HS0Hs53TJQfGbp4RWz?=
 =?iso-8859-1?Q?se/bzfMYKCNAaBcwm2SYOiCS/ykZ6xNXFJmSlvZbQMRfxSWt1qXXd6l7dM?=
 =?iso-8859-1?Q?BFw7orXAEplO8TpsnuiJ6lIUwZS5OIqrehjbjcIn/4/pN8Z7dpXjXOnzeK?=
 =?iso-8859-1?Q?NmaqdgnL2Yin93QnleoFRkfZj6ozZAfiEnOjP2IcyRAsvc5wYCBRt8hoLl?=
 =?iso-8859-1?Q?EmJbT+MGgbiJjsF1qiP3I26boas37P756OecQzhe7BE1Mrf/57HL9y30KC?=
 =?iso-8859-1?Q?cBFdhdfnuTazvhktjBHYt46t2bNc5IOxBScAvcZaC90QsLVBOWvAhWj7XJ?=
 =?iso-8859-1?Q?P+k4GQUzT8La4ylVzhwEB2RHX8uoewwiF895Zs0+AmNuAi+WqrK0rIsm/k?=
 =?iso-8859-1?Q?v5Vd50KUoxNEWaW6UWS68OrnlubNU7xTRKgxG38wAdn9pVSSKA0xqeX3I6?=
 =?iso-8859-1?Q?jmMwSOoZUvUIibgBgWGkMWz2oezznMvDvAkaG2N6MQbM8NTBi3Oa2/GARk?=
 =?iso-8859-1?Q?T5/yJoN2EpekzQf4XPnXs+W+aj3uocszXtXRhlUlPEYjhF70N/UXDjn1YB?=
 =?iso-8859-1?Q?KEVag+lQEsxYIsGtO/eNqF+3jzw481mA+TSDsAoyug4tk9GTAbZHNJ1p8d?=
 =?iso-8859-1?Q?cFcpPZAO/Mv4pIfX3TAdYIeXd+/Kp3u6sCx5+0fbQDFga6Y74Gn9gARbQS?=
 =?iso-8859-1?Q?wyLhv3kY5GEsdsI9ZyRZODI+juzBFSMYp6axkLyGZYJIIPMUf97L6JYr9k?=
 =?iso-8859-1?Q?24qm5++Iz2OFLXsfRaHZC2xb4yekb24b/ldW5hPQjaS20h?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58ed04ff-be9e-4358-eff8-08de995eb271
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2026 13:15:13.2825 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p35h/J1Ow2eb2SBZAfSGwsyA11aN8nHL6hjaxly0OIM3pceZTREOJ1PR57wkbfpRjr5Jt5f9YcFMcZwhspS/VA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8106
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


The patchset consists of the amd-staging-drm-next branch (Head commit -> b7=
87d21fab08ddebc308b1c8b4baece1eb81243d -> drm/amd/pm: fix incorrect Feature=
CtrlMask setting on smu v14.0.x) with new patches added on top of it.

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
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
Sent: Thursday, April 9, 2026 11:03 AM
To: amd-gfx@lists.freedesktop.org
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.L=
i@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>; Li, Roman <Roman.=
Li@amd.com>; Lin, Wayne <Wayne.Lin@amd.com>; Chung, ChiaHsuan (Tom) <ChiaHs=
uan.Chung@amd.com>; Zuo, Jerry <Jerry.Zuo@amd.com>; Wheeler, Daniel <Daniel=
.Wheeler@amd.com>; Wu, Ray <Ray.Wu@amd.com>; LIPSKI, IVAN <IVAN.LIPSKI@amd.=
com>; Hung, Alex <Alex.Hung@amd.com>; Tseng, Chuan Yu (Max) <ChuanYu.Tseng@=
amd.com>
Subject: [PATCH 0/6] DC Patches for 13 April 2026

DC v3.2.378 summary:

New:
   - Add p-state schedule admissibility flags and frame-time utility

Fixes:
   - Fixed incorrect math_mod() result due to wrong variable in fmod implem=
entation (Cc: stable)
   - Use overlay cursor when a color pipeline is active to avoid incorrect =
rendering
   - Constrain vblank_nom to bounding box value instead of entire blank
Cleanups:
   - Add const qualifiers to watermark params struct
   - Fix C4242 narrowing-conversion warnings

---

Alex Hung (1):
  drm/amd/display: Use overlay cursor when color pipeline is active

Gaghik Khachatrian (1):
  drm/amd/display: Fix compiler warnings

Taimur Hassan (1):
  drm/amd/display: Promote DC to 3.2.378

Wenjing Liu (3):
  drm/amd/display: fix math_mod() using arg1 instead of arg2
  drm/amd/display: add const qualifiers to watermark params struct
  drm/amd/display: add pstate schedule admissibility flags and
    frame-time utility

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 53 +++++++++++++++++--
 drivers/gpu/drm/amd/display/dc/dc.h           | 10 ++--
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |  4 +-
 drivers/gpu/drm/amd/display/dc/dc_types.h     |  2 +-
 .../src/dml2_core/dml2_core_shared_types.h    | 39 ++++++++------
 .../dml21/src/dml2_core/dml2_core_utils.c     |  8 +++
 .../dml21/src/dml2_core/dml2_core_utils.h     |  1 +
 .../lib_float_math.c                          |  2 +-
 8 files changed, 90 insertions(+), 29 deletions(-)

--
2.53.0

