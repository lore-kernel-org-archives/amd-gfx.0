Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7B0AC36002
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Mar 2025 13:11:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 679C610E33F;
	Mon, 24 Mar 2025 13:11:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LOmQkK+X";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2085.outbound.protection.outlook.com [40.107.243.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6E5610E202
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Mar 2025 13:11:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pEDh6RY7v7d4cd4bIcFI/6e+Eq+huXbTnOSNl9eQeHstBtKlph8FCx8aK9mbf1Pj1wumGa5J/SAbPfxD880mf8oQ8a6kB5AnVSYdEa7uilDphz7o5vv4nwv1pLqf28vDWNB82mceCl6Ex7VxsGMKv8mCcWmprDkXTHwLJWyHS4DHy95VNTDJDd94Kkl+V9x/PAP9ACpMS5mgobnGp6k1c5zocvCkAjO+LZNfHmcf8IAACUx154yyMg6Q2upE6iJBlHvNzICyJ8x/DSG83K1R+YqaUJP6LxlKGOTCu6yAvkT9/ku17jzcYdiBPxwYJ1Cmy+gg+nds3OlBxqMu0Bff4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yut8+QYwk2dFer/YPotI1OBRFGJszeeayLnleoKL5dU=;
 b=U00xWn8FeeT6jtBwH/VTB9/wMDIO8shET5i8+iE7OEJTILrjXQt4bcz+KScrQFYnj80Z57QeBxJHEGv+nDJpZDLH00PTCsWgrXlBJa82JXhzdaY0TtJADk4c1qv4FNYsnbo4MB3EgnhK9QnBMfgkzM7JxYxprMonrduTkhd4HvF+HADaGzycq9VoezuV3R+USljlnZHEjzjnVjD0GWnoFkdUhT8Z/SEjn/oUrxsooqycJfCUM/yrHw37L/ctw/qpVRFbPmCfCojtJEKe+DjS/UPhpjSrXvDIEcdbTrA6Zv/T+YrtByDwobSrkgHP5dyozV5i/F7rH5I+QK4kKlbpyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yut8+QYwk2dFer/YPotI1OBRFGJszeeayLnleoKL5dU=;
 b=LOmQkK+XEAPG7k3gdybluZwEHc/z3OaiPUMpxSTLL8P1rYa84Lmxjv079BWBPO9SU5nsh7JE35p3T1GIAuSLDj57seMu6uDcci4I8lX5TnRZvkGKdbx2gCrPIdBQheP/NEi7wc1nAJOydDNoU699Dzy6QC5KQosmonpy/9TxyJg=
Received: from DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) by
 IA1PR12MB7639.namprd12.prod.outlook.com (2603:10b6:208:425::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.42; Mon, 24 Mar 2025 13:10:28 +0000
Received: from DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::ea87:74ba:36ec:8cf6]) by DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::ea87:74ba:36ec:8cf6%2]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 13:10:28 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Wentland, Harry" <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)"
 <Sunpeng.Li@amd.com>, "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>, "Li,
 Roman" <Roman.Li@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>, "Chung,
 ChiaHsuan (Tom)" <ChiaHsuan.Chung@amd.com>, "Zuo, Jerry" <Jerry.Zuo@amd.com>, 
 "Mohamed, Zaeem" <Zaeem.Mohamed@amd.com>, "Chiu, Solomon"
 <Solomon.Chiu@amd.com>, "Hung, Alex" <Alex.Hung@amd.com>
Subject: RE: [PATCH 00/16] DC Patches for 24 Mar 2025
Thread-Topic: [PATCH 00/16] DC Patches for 24 Mar 2025
Thread-Index: AQHbmPhgD1JUxOYEOUugfUa/pxT4XLOCSeRQ
Date: Mon, 24 Mar 2025 13:10:28 +0000
Message-ID: <DS0PR12MB6534491CF7BFBFE33D7BA2D89CA42@DS0PR12MB6534.namprd12.prod.outlook.com>
References: <20250319175718.2578234-1-aurabindo.pillai@amd.com>
In-Reply-To: <20250319175718.2578234-1-aurabindo.pillai@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=6f985ad3-d4d3-420d-abd5-2d640c6fa931;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-03-24T13:09:36Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Tag=10, 0, 1, 1;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6534:EE_|IA1PR12MB7639:EE_
x-ms-office365-filtering-correlation-id: 29e36c50-da8b-45d6-7496-08dd6ad53f83
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?3R2U+LUQL7r7NgggpX5MVNCKpuqcDDAvph0LjGCenPKhc18IWNrNGFlebqF4?=
 =?us-ascii?Q?k4UCwU/zwZHpRM9IhQIpYvY/KU3Fvs8123W51jkuTMP5oL08Vt4YMTG+v5xd?=
 =?us-ascii?Q?XejEgrZUlpX2CMUHf10fjOGhB/3B1V5vEidomhdlz4N1zuOM7JvdARR/1KDL?=
 =?us-ascii?Q?p8FvyXXgZClnfncV9nnbsaygQ/d4uv+kMcPJ3If4+IXkywlg8setPj171dyp?=
 =?us-ascii?Q?EryI8L1JxLbJzcyFRn3INVnMrV3s9jrtyky6sL0ot8KrXb3KK6y/mzs1aWxx?=
 =?us-ascii?Q?bGYodpfv4wTkRf1e+OGZmqAdL2z4MXOr3YRjr7hXOPgau+T/b/zLgIbWh/+3?=
 =?us-ascii?Q?c1NnKoSM+kObFDmzkxucQHgIWc8n2a689B+xERkRXdj6th7kbrrXhSbIHO4I?=
 =?us-ascii?Q?rlp0TFG0PcewDRc0X7S6SjSe8ez6b9y378Zw1BYPCsijfAFCjhu9qNEz2VQo?=
 =?us-ascii?Q?CQIdhkeSLsl1DPA7tzbuOrz9Vgw3EbBjmnUaV5qD+hWkjx+LbAixIvavvrCD?=
 =?us-ascii?Q?NJUd+ppmWNM6Em1noGPQwvYp0/CMwmhCLQvhj5lUcV/V2zcYWapQ9D/uZsPS?=
 =?us-ascii?Q?JcB7y2k5he8QDEDetTQvdyuVncIcS8UojFuBeUf8Sl9eKioIDg1KgWf8mN44?=
 =?us-ascii?Q?tR8X69ItX0e3DQ1ZoF+P5Tap0dmBwQgf4WE1Si8HJ+dwP1uSn32TsL7bbxyP?=
 =?us-ascii?Q?0vGSup/AHdN2ZegYBL6uHmFNygSCnamWxmOxxEL3Kg+/W4h+deXDItAfJs2C?=
 =?us-ascii?Q?PIXp5nUHBUAu+FPrBKoHueL5KYKtZmi7gdGxQi+0MCe9q6rhw9fIVMdKhyw4?=
 =?us-ascii?Q?c4PoH27Tg/WBEj6SIeIWlCi6Hm3jr5+cODOs/5UT1Frow+W5MafIE59vo0Ha?=
 =?us-ascii?Q?Al7e3GaDdFsumYm4s0LBj3AlY0hM+GmgRu8a6+/a5jE/R0cBZDeALBkMBESF?=
 =?us-ascii?Q?CFTMhQ9EIhEi6peBtjVbV8EeBWgmDvhMAuk5W0hwV7fYwkV1le5wIyh3ptW2?=
 =?us-ascii?Q?WiXKdesaNyuhwaPWr1JsThYIcepil1sqrpqZ74jF48jLtQCwkPdqv+Csyzvg?=
 =?us-ascii?Q?DMvqk6/lNjQheXBCJwO8Wy/qz/AQ4mHCVyxB/33O4YibI11sVCeu/e/HeCKv?=
 =?us-ascii?Q?qRmRMyeGGfGf57EhPmmcx6Q2IeAkblA2SCO2cueOlTSlcfNumTv1ofq3Wodc?=
 =?us-ascii?Q?W+ZAKhqkSMT4mGLl5mWqvdzdwNtSGoVs4l1BpGkLv2Er0qWbNeKuj0SJhV7H?=
 =?us-ascii?Q?jgvegrFHkpeoQo4FHl8RpQ/ukW483yD5Qcx7ISHdrimpgsoIf6ehI6W7tPEs?=
 =?us-ascii?Q?0slCH1tGalhZwJk1Knyo8V4cHtijVQhSAi34JLWMkK+OnSxbZ+Mzmmxla0EZ?=
 =?us-ascii?Q?hngnOv9U5NVxokl0lyDTwdNY+c3nEZjqQz3Qp+nXeENEMX/m0dwkD/iioyzr?=
 =?us-ascii?Q?KtNRhUj3jixNnWe1Ch5N0Qy8dYWxu81u?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6534.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?m/Xtp0/H++KVE6HBDzQtbP2tsOSxVSaucHJ0g0QVvWXdcvO6kB9onfrA0EiV?=
 =?us-ascii?Q?XfJpmq1GNtYPM87PlA6/sQo4qg/n9DeXWOBEjPSeL4gH5KEGBBkdL7XtsnAR?=
 =?us-ascii?Q?U/QCugucyG629uscfaviTh9wBLHRutwlTFkZ3xb2Nh5/X3H3Ih0RwaX8wtid?=
 =?us-ascii?Q?hafxMi1RbAGBD3KOjVtxv+7E1R4/ymTN1QD9dbG0wuFB9N0E347ECqT64Xjs?=
 =?us-ascii?Q?310jEqIeJmZ+Hmk5rN1U7DllOkYM/jFagOhR6F+AH01nhrdEUeriVV75/eAw?=
 =?us-ascii?Q?JX3BdHfCHPOaPKE6kask5yNHCjWL7ewNhxgnXiQCX5HtYfSYdgy7QyAIR6um?=
 =?us-ascii?Q?uWvcVA4zv7xYfyLyN3L/ZrUbRyVLyJ7XfAb12L1PQonElweSzu0ksULtnMdz?=
 =?us-ascii?Q?nfk2fzoR4NIbH7mxmZAf49TdVrURcKqyiHo51VklowbH6HfsHApIyMsktxXg?=
 =?us-ascii?Q?OdmwmFZMXDYBZkXyNnzCFswqYmXEFQjV0YVgy65Wu+hu1THdZihThYK99XBn?=
 =?us-ascii?Q?E2/ZBqdtm/2PPK7b6OqbqrqKVpOLsQaIdbiJjSmlHxEUm2rjFg+6A7KHEHTs?=
 =?us-ascii?Q?AbhZTWE17qgo2TIy3vpIq5GZfsZjbehdHfWa2HKcU5iFXq+2aN4z4AHpHmli?=
 =?us-ascii?Q?GgR4yKOPtMQ/xGeqb7FX5WnEpJIEG0yWkGkYzgXCgLqIcb/RAVRhfobsn/e6?=
 =?us-ascii?Q?WddavO02B3bihBae2ZlTC2++0/VeZMWv3VZJeLpJ2XPf/UxU+/J9Lp/vjqnf?=
 =?us-ascii?Q?bh7lHkx9siKQbcwh9jT+AHyRyatiLCZ3IUK4C9JTQdPoJxZ/OhVWRLJEl1H0?=
 =?us-ascii?Q?CX/aVfhH4tOoPBTgjxQw1rAhogyz7b0kUFigveRtOYmR512Y5Zu2v+/vuKu7?=
 =?us-ascii?Q?flT/EZZcpQ7f6IGakh89TX60ELIP/f1xxak0RbUMOkUYcUJJBrN7KGpypw3d?=
 =?us-ascii?Q?6qB5oxeYM6p4XBwukazRbT2xmGmOnxFIo5BxNPGzcw+w6ueYY7miNqpOEqaF?=
 =?us-ascii?Q?3soBzJlNdv3ZjV2EBvTQPVUApvn3KTH59QyXXunnGawzTnhsT47yZ2gPZOzn?=
 =?us-ascii?Q?ptQYFJGPodcA4ECsqc5CH3btjwwMXMaAkXjfbCsmZ7R7wNvi8AabWT6BLTzz?=
 =?us-ascii?Q?K0EfMJN7PxpkLlx4pvaTxMwwLhxPN1lZgd3RLhTM2qFIgonPS6k4m2er2F+M?=
 =?us-ascii?Q?qRobmwFhVoIV3xSU4D+tyHepTXQ63GaTnunvwkkKbPofbisdxBE7BHDLy5sc?=
 =?us-ascii?Q?A69mys/QwtYtMcut6csRQPXMvqPWVINP+t1OlgBSGc7tkqutEYFIHwe+Hoef?=
 =?us-ascii?Q?sVZLWC07xEjcLOWilURVvpl3HYlda/TDOqO5FQs2KY2xHLynfaDrUYMnkLGV?=
 =?us-ascii?Q?xSHmqA0Cpdl++aV02tACx4BVnMYTzmvg9D6ILwlh4P/UP5YWLFNpf0QLkVVX?=
 =?us-ascii?Q?rcKFpJVX4KNRsByvs2KQNQqR6ZqkEzYUUqh3Gxwlr6tv/V5UW/zcFh9GtKVu?=
 =?us-ascii?Q?5cII1zJJ93ppMGo2O7MbilNaVOZYUupy8iSqdSmZZLl4z3Q7kYP9uSvZqfPk?=
 =?us-ascii?Q?M8RLvcQfP3Gp7QWli7s=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29e36c50-da8b-45d6-7496-08dd6ad53f83
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2025 13:10:28.2336 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q2mqI9lAUBq7dKj0UhZm/wHbrvmG7P47T8PErYPnfnWHvJqO+bWRZlQ5dGVebCJrvFE+LzmsrOjZVC/wWey0tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7639
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
        * AU Optronics B160QAN02.L 2560x1600 120hz eDP

The patchset consists of the amd-staging-drm-next branch (Head commit - 394=
e1f9e6b8ea3b34d0448b3bac6bdb0d9080a1e -> Revert "drm/amdgpu/gfx: fix ref co=
unting for ring based profile handling") with new patches added on top of i=
t.

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
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
Sent: Wednesday, March 19, 2025 1:55 PM
To: amd-gfx@lists.freedesktop.org
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.L=
i@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>; Li, Roman <Roman.=
Li@amd.com>; Lin, Wayne <Wayne.Lin@amd.com>; Chung, ChiaHsuan (Tom) <ChiaHs=
uan.Chung@amd.com>; Zuo, Jerry <Jerry.Zuo@amd.com>; Mohamed, Zaeem <Zaeem.M=
ohamed@amd.com>; Chiu, Solomon <Solomon.Chiu@amd.com>; Wheeler, Daniel <Dan=
iel.Wheeler@amd.com>; Hung, Alex <Alex.Hung@amd.com>
Subject: [PATCH 00/16] DC Patches for 24 Mar 2025

DC v3.2.326 Summary:

* DML 2.1 resync
* Vblank disable fixes
* Visual confirm debug improvements
* Add command for reading ABM histogram
* Bug fixes & improvements

______________

Aric Cyr (2):
  drm/amd/display: Create a temporary scratch dc_link
  drm/amd/display: DC v3.2.326

Ausef Yousof (1):
  drm/amd/display: Enable pipe update pending wait

Austin Zheng (1):
  drm/amd/display: DML21 Reintegration

Brendan Tam (1):
  drm/amd/display: prevent hang on link training fail

Charlene Liu (2):
  drm/amd/display: fix zero value for APU watermark_c
  Revert "drm/amd/display: dml2 soc dscclk use DPM table clk setting"

Chun-Liang Chang (1):
  drm/amd/display: Add Read Histogram command header

Cruise (1):
  drm/amd/display: Remove BW Allocation from DPIA notification

JinZe.Xu (1):
  drm/amd/display: Use sync version of indirect register access.

Leo Li (2):
  drm/amd/display: Increase vblank offdelay for PSR panels
  drm/amd/display: Actually do immediate vblank disable

Leo Zeng (2):
  drm/amd/display: Add override for visual confirm
  drm/amd/display: Get visual confirm color for stream

Paul Hsieh (1):
  drm/amd/display: Skip to enable dsc if it has been off

Yi-Ling Chen (1):
  drm/amd/display: Apply the adjusted DP ref clock for DP devices

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   43 +-
 .../display/dc/clk_mgr/dcn315/dcn315_smu.c    |   29 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |   51 +
 drivers/gpu/drm/amd/display/dc/dc.h           |  337 +-
 .../drm/amd/display/dc/dce/dce_clock_source.c |    9 +-
 drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c |    2 +
 drivers/gpu/drm/amd/display/dc/dml2/Makefile  |    3 -
 .../amd/display/dc/dml2/dml21/inc/dml_top.h   |    1 +
 .../dml2/dml21/inc/dml_top_dchub_registers.h  |    2 +
 .../dml21/inc/dml_top_display_cfg_types.h     |    3 +-
 .../dml2/dml21/src/dml2_core/dml2_core_dcn4.c |   10 +-
 .../src/dml2_core/dml2_core_dcn4_calcs.c      | 3083 ++++++++---------
 .../src/dml2_core/dml2_core_shared_types.h    |    2 +
 .../dml21/src/dml2_core/dml2_core_utils.c     |  134 +-
 .../dml2/dml21/src/dml2_dpmm/dml2_dpmm_dcn4.c |    4 +
 .../dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c  |    8 +-
 .../dml2/dml21/src/dml2_top/dml2_top_soc15.c  |    2 +-
 .../dc/dml2/dml21/src/inc/dml2_debug.c        |   31 -
 .../dc/dml2/dml21/src/inc/dml2_debug.h        |   77 +-
 .../display/dc/dml2/dml2_translation_helper.c |    2 +-
 .../drm/amd/display/dc/dml2/dml2_wrapper.c    |    5 +-
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c |    5 -
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   |    1 -
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   |   14 +-
 .../amd/display/dc/hwss/dcn314/dcn314_hwseq.c |   14 +
 .../amd/display/dc/hwss/dcn35/dcn35_init.c    |    1 +
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |    7 +-
 .../gpu/drm/amd/display/dc/inc/core_types.h   |    2 +-
 .../gpu/drm/amd/display/dc/inc/reg_helper.h   |    4 +
 .../link/protocols/link_edp_panel_control.c   |    8 +-
 .../amd/display/dc/optc/dcn35/dcn35_optc.c    |    3 +
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |    4 -
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |   59 +
 .../drm/amd/display/dmub/src/dmub_srv_stat.c  |   17 -
 34 files changed, 2021 insertions(+), 1956 deletions(-)  delete mode 10064=
4 drivers/gpu/drm/amd/display/dc/dml2/dml21/src/inc/dml2_debug.c

--
2.49.0

