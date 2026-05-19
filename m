Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D22CCCD4F3C
	for <amd-gfx@archiver.kernel.org>; Tue, 19 May 2026 14:09:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73E3610E530;
	Tue, 19 May 2026 14:09:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LdDWc0VP";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010064.outbound.protection.outlook.com [52.101.46.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6451210E530
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2026 14:09:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vv3SCY1AsU6KZAAEZUsJ0c6EEvNPtvvx6Gx8l/ICeMPNGaTuLXLlO7bzhk8l7GKGsG5xzBbWRGn8iokwCM0Ub7L365nO60slgdd1DmbouJ9YiIIYRgr2NVyeV6cWvLEdwHIqCGR3Bq0kwc/zEE5xnoTK1RL/BemPlwzb0bzAu2npZ8L0j8PW1hLxp3ibiqdtJb8odSohhq5lurPozQ5/QugRduHgMgbynLMltQ9ZOSK3/iIRR7O/ZI0wOVhvYRQTzIXcRHd8jcFNSH7c6tuuBA/kSeA3KyDP6fZmBxXomrSCCRpkrSiZlWTk/SmO0JDclyNK6c/GiqjT9/L8D/uAiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B9GlVqu4TAIAJU3AiUKr8bFx/35AuJj4UAoZfKCUEWk=;
 b=BsDrnN8ZIw5mOnLHehMWoo08IUpGQDtJszMlkfm1SyJ+mh+z2LlpcKIPGmZViYUW9C261hSYjSLY4l955rQwHhoH8JKPTvo6FDJcABTFWOIci5LDmgIN6EKDNR0ym4Z5T7lh565C9B9bSKrAaNuyLeIB1mE2d+rRQFk5zeUsesYomUdWJnebFm0Wm2vR5Ts6+fIVa3VBx23hCrI7fm2qH8TNoBDvDci3FcXbGxeqoxSlzAPIq6XQOH1lyuCGoM3zGJ8uM65gNkBLdhRFZsyH/1s4TlyCy6Y8lm+0+zKFVOPMaX845Y8r+DLvtv7He7XfS0V0E+kggMf4xFZUlzQIfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B9GlVqu4TAIAJU3AiUKr8bFx/35AuJj4UAoZfKCUEWk=;
 b=LdDWc0VPyoBVFq7md1echPqzOlyjiB2o3dB/LiMOkAoj0vKVaCRm+60P1d/bfm+LZbIl6T15wncBuZvMtL2U/u8UtsBzByEiTJuPjtxcjb3vd9m9nzNsglUmTB19YreKL04OYkIYQMzwkuewPFVWLbzCGJqa67LF3jlLoXNc+kg=
Received: from DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) by
 IA0PPFAF4999BF6.namprd12.prod.outlook.com (2603:10b6:20f:fc04::be0)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Tue, 19 May
 2026 14:09:54 +0000
Received: from DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::b2e1:64e5:3b9e:738a]) by DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::b2e1:64e5:3b9e:738a%6]) with mapi id 15.21.0025.016; Tue, 19 May 2026
 14:09:53 +0000
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
Subject: RE: [PATCH 00/28] DC Patches May 13, 2026
Thread-Topic: [PATCH 00/28] DC Patches May 13, 2026
Thread-Index: AQHc4uVmsq1WmaDebUebhTy+y/7herYVaoNA
Date: Tue, 19 May 2026 14:09:53 +0000
Message-ID: <DS0PR12MB6534D8F8B8117B6A5A360A189C002@DS0PR12MB6534.namprd12.prod.outlook.com>
References: <20260513143213.1852892-2-IVAN.LIPSKI@amd.com>
In-Reply-To: <20260513143213.1852892-2-IVAN.LIPSKI@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Enabled=True;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SetDate=2026-05-19T14:03:17.0000000Z;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Name=AMD Public
 v26; MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_ContentBits=3;
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6534:EE_|IA0PPFAF4999BF6:EE_
x-ms-office365-filtering-correlation-id: b27fc79d-f565-41c4-c727-08deb5b04c4a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|3023799003|11063799006|38070700021|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info: UdBaisQGaIvWkbBJjCfTNcbAw2d+IyoKLyDnMODV+iPFNBzpSKC8jXv1rQSKOWQDKGKclOOsMFCjHxGILtJio2sZ3tj+fQu2LYWoaSSk73J36/rszMV4Skw38QBMlLNonN1A0KL1y8/YLBBz2pyk4grqRCmv0Y3fTWOlO4I/1dnftmH3uF4UOokH2RBmGB0/Pgk0D6pvrASIcPNU+cBrKWPsPDHWI4AlhRXcF+zHUP/+PjtcPnNJbeAeRi1y2mS6nvtlDHiCDHB4Evsr97WRvyO3beSB167/egdxC2mYdVA7vQ3VMSoo4rV1ayWp/I7ZqcxWKefnHTE3hr0ltxnu5cHcNNElQFrcnZYuiPyTGcO8DMYGxJt14rdSI7oe76mShXswuVwuq6rFsuCiEbwiAa83SJqBnnrcRNK2mPGGUOueUK300qPs+15pwoHSoANVmC4tPb1zm8umDMP+r/4XiRODBBjg9Yob9F6dcQZLpqutvk5Xy26aSVw4lFWUsxNcF1ztvpNO2Zmr7GJpR4qtvdVT5BUg1ccyOJqjMZm9rt+YmQrnytKgUflpcczy1KaclofIy7KfGbXhA2Ia7owIRnvUfFdKTBEqekj12oGkthp4Y0L0wjcgyMCv21PFkV+iOcuRiKkPjYxbxh85gRGczjJ91iG4naT5+gCTxmLupFe1Wvrbf8IaLVI8nJJxDthsJU/mT3+28/Z0OqxPNLiLXeZsIeMEFbUIcr6moFLo3nS7kW/0wdmQcJ4jRUMLg2Hl
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6534.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(3023799003)(11063799006)(38070700021)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?mzhFevYGwUXqMGHareuq83Wl4ni/Vj4SKt1DYE+Hv3rD2yjWxzFL0ZeCgy?=
 =?iso-8859-1?Q?wE+UfG+rleOosB7IYMSM9w6nO4HBK+ghXfax8RRFjc8mqvJi9ri3pzhztA?=
 =?iso-8859-1?Q?+I1epBxlkSVZcSJKm/Eq3v/7Q1MkgUoAN8LJkBXta4MMHAEP/tcaq18sLL?=
 =?iso-8859-1?Q?F/dNzFDL59UylNk/1Jcur/og+vCbKq4/sosowEvilZa+3oHrgm4c4nOOTG?=
 =?iso-8859-1?Q?yU2C29kwGS16wEyhYAtHU0zahBLFdUrLADQeQJ/iRL53XwFa78jj/J4oif?=
 =?iso-8859-1?Q?ll6ANbkFKwwfQQC+lkorb6lI6yc0+KwRPjZoXN5woHXeJgIyAwhrhRA6F3?=
 =?iso-8859-1?Q?rgYkqUFIWGfNPAAuoFpG/LhhutlcoJAowEBSWom4XjBvM7axHXPL/hlr+v?=
 =?iso-8859-1?Q?TR5oRKcPn88DtwVf064dM7vE5TITPn7d+5OeAz3JLu7HRTKYksKWbUrTT/?=
 =?iso-8859-1?Q?WHMimU3T+PQJ7rtVQZggXExqMd5iqElrooQfr+EXWY7WrmBogqZBErNRi8?=
 =?iso-8859-1?Q?b/lFu7gF2bSaYVSKhikrpsVxy8FiCXrOs69Xjp3C7dwmKxHzNhAAbaB8jG?=
 =?iso-8859-1?Q?juh77NAzhMcF9OxlGr74gco2Cba/QVhBD87GIqhmUnudR42KTkfDHh7KRq?=
 =?iso-8859-1?Q?hHWO0AltEU2/JVakXkcMMTIZ7AUe5tULFHsLx4sKy1bhfCrsJGY/QErf25?=
 =?iso-8859-1?Q?egYOVtNWs6W7jJv5qai4YdXV1m1qbX6vvqo3oy+3Pnn/uUN35WHtGvYsIj?=
 =?iso-8859-1?Q?Nq7Z6U3gwjwfT/KuIetChhxEitnTTHP9X0TJ/6juxnYLPgc7zQJP7OF/Qv?=
 =?iso-8859-1?Q?TaBHj9B7c5QpjgCX3TMUXXyCgW4T9MlNvJ4CH55CfPLdIe8odBwRAC7hFP?=
 =?iso-8859-1?Q?20gR6ZhNa18glTngBst6UPz5gIlYVHf4zf9AbqryhHZBwPWBLw4ribf56c?=
 =?iso-8859-1?Q?PKrK4ByKOACp/+yLoxr1fXY9FSgqDGDHBka8YFqJjSqwvysY8HF2e3P/Y5?=
 =?iso-8859-1?Q?BHirg21q8dSsjesDpRhnvHHLCGyXwA0DtgZ7gjJMTWfYN8Ktg60edICoel?=
 =?iso-8859-1?Q?vOubP4sPabHjVx7idDEAPcG0QxE1Y+8NkxydePXzVNiDDaX5SKlHTl4DRm?=
 =?iso-8859-1?Q?SOOF6XlThGBFypkAf9eOFEngOL1M2Q6Y+ke5gAXOOxeTi89U7IBBxO/TG1?=
 =?iso-8859-1?Q?W763RMcy/nU4O3d9WFzjpRb96ciFUEeI5MFuIfnCOLT5kKqDjuD8iIc0ni?=
 =?iso-8859-1?Q?IrR47EkFLO/3bXivpef9liLW0XvaL2D844YmZHUqKez0SzBdCd5mytLOKY?=
 =?iso-8859-1?Q?xnhffzN/EzEBFD5JF1Gb8C+/SRLdrIM8dvRZG7WhuH3d/9sLKSaSqZIayq?=
 =?iso-8859-1?Q?0KaTyQsSPLWrA52Tz2NHo4R10v6G6esyH4gb1zrQIMrrElzZKEIXvB5X2d?=
 =?iso-8859-1?Q?qwLaXOXVLFRJ9CK/YMYnwXUiIow90vXI2yhsgGuGzyhNT6K2KSLJrSAtiS?=
 =?iso-8859-1?Q?DQnNaqvLJjliDXf0WquoX+dbp0kBaVhejbbqoh7pOWJXgZrtyRz4tD6AId?=
 =?iso-8859-1?Q?S68LSMgoUBMzoZ8irxESYvtUEh+pisrm2axQlHqmVv1NVQNCx5ijqItTVw?=
 =?iso-8859-1?Q?hJbb18EcOLr4QOYitqFejcOnojWOPDzvam/Mas2+BTLRjGNqUNumJpYCGS?=
 =?iso-8859-1?Q?t3fZyDHpjX3xa26wjGxELHjYGLF+dF0/SPhG4wPfi1rkCRAE0EO/Lx00dh?=
 =?iso-8859-1?Q?iwRyTegcsX0KEloBp7HRMuVBzp00/1Lp/aaisaWfmjvlT6?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b27fc79d-f565-41c4-c727-08deb5b04c4a
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2026 14:09:53.1545 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DN5wsAKmZAD5pmj9J3qFPg27+ksHQ3oQy0OhcIv5/G20JhNKzaQq9m8XCSvmDc+L6qozBpQsuP5qxh8OVyxnTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPFAF4999BF6
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


The patchset consists of the amd-staging-drm-next branch (Head commit -> 22=
055267cc98e8b94ac506d5c9dc5589e4cb09ea -> drm/amd/display: Enable DCN42 PMO=
 policy) with new patches added on top of it.

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
Sent: Wednesday, May 13, 2026 10:29 AM
To: amd-gfx@lists.freedesktop.org
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.L=
i@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>; Li, Roman <Roman.=
Li@amd.com>; Lin, Wayne <Wayne.Lin@amd.com>; Chung, ChiaHsuan (Tom) <ChiaHs=
uan.Chung@amd.com>; Zuo, Jerry <Jerry.Zuo@amd.com>; Wheeler, Daniel <Daniel=
.Wheeler@amd.com>; Wu, Ray <Ray.Wu@amd.com>; LIPSKI, IVAN <IVAN.LIPSKI@amd.=
com>; Hung, Alex <Alex.Hung@amd.com>; Lin, Ping Lei <PingLei.Lin@amd.com>; =
Chen, Chen-Yu <Chen-Yu.Chen@amd.com>
Subject: [PATCH 00/28] DC Patches May 13, 2026

From: Ivan Lipski <ivan.lipski@amd.com>

This DC patchset brings improvements in multiple areas. In summary, we high=
light:

 - Add amdgpu_dm KUnit test for:
   * CRC function
   * HDCP process_output
   * colorop TF bitmasks
   * color helpers
   * PSR and Replay functions
   * ISM functions
 - Fix eDP receiver ready status check in T7 sequence
 - Enable dcn42 pstate pmo
 - Refactor PSR. Replay and ABM functionality into dedicated power modules
 - Fix assertion due to disable/enable CM blocks
 - Enable additional wait for pipe pending checks
 - Fix ISM dc_lock deadlock during suspend
 - Use lockdep_assert_held() for dc_lock check
 - Fix clear PSR config flow
 - Exclude the MST overhead from BW deallocation
 - Allow power up even w/ powergating disabled on DCN42
 - Fix integer overflow in bios_get_image()
 - Validate GPIO pin LUT table size before iterating
 - Add Auxless-ALPM support in VESA Panel Replay
 - Add debug option for replay ESD recovery
 - Validate payload length and link_index in dc_process_dmub_aux_transfer_a=
sync
 - Add ADDR3 swizzle modes


Cc: Dan Wheeler <daniel.wheeler@amd.com>


Alex Hung (6):
  drm/amd/display: Add KUnit test for HDCP process_output
  drm/amd/display: Add KUnit test for colorop TF bitmasks
  drm/amd/display: Add KUnit test for color helpers
  drm/amd/display: Add KUnit test for PSR function
  drm/amd/display: Add KUnit test for replay
  drm/amd/display: Add KUnit test for ISM functions

Aric Cyr (2):
  drm/amd/display: Fix assertion due to disable/enable CM blocks
  drm/amd/display: Enable additional wait for pipe pending checks

Aurabindo Pillai (1):
  drm/amd/display: Add KUnit test for CRC function

Charlene Liu (1):
  drm/amd/display: Allow power up when PG disallowed in driver

Cruise Hung (1):
  drm/amd/display: Exclude the MST overhead from BW deallocation

Dmytro Laktyushkin (1):
  drm/amd/display: Enable dcn42 pstate pmo

Harry Wentland (3):
  drm/amd/display: Fix integer overflow in bios_get_image()
  drm/amd/display: Validate GPIO pin LUT table size before iterating
  drm/amd/display: Validate payload length and link_index in
    dc_process_dmub_aux_transfer_async

James Lin (2):
  drm/amd/display: Add some missing code for dcn42
  Revert "drm/amd/display: dmub_cmd.h: add missing kernel-doc for enums"

Leon Huang (2):
  drm/amd/display: Fix clear PSR config flow
  drm/amd/display: Add Auxless-ALPM support in VESA Panel Replay

Lohita Mudimela (2):
  drm/amd/display: Refactor PSR functionality into dedicated power_psr
    module
  drm/amd/display: Refactor Replay functionality into dedicated
    power_replay module

Nicholas Kazlauskas (1):
  drm/amd/display: Enable DCN42 PMO policy

Ray Wu (2):
  drm/amd/display: Fix ISM dc_lock deadlock during suspend
  drm/amd/display: Use lockdep_assert_held() for dc_lock check

Sung-huai Wang (1):
  drm/amd/display: Fix eDP receiver ready status check in T7 sequence

Taimur Hassan (1):
  drm/amd/display: Promote DC to 3.2.383

Wei-Guang Li (1):
  drm/amd/display: Add debug option for replay ESD recovery

Wenxian Wang (1):
  drm/amd/display: Add ADDR3 swizzle modes

 drivers/gpu/drm/amd/display/Kconfig           |   12 +
 .../gpu/drm/amd/display/amdgpu_dm/Makefile    |    5 +
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   25 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |    2 -
 .../amd/display/amdgpu_dm/amdgpu_dm_color.c   |   65 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_color.h   |   89 ++
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c |   17 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_crc.h |    7 +
 .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.c    |    5 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.h    |   13 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c |   80 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_ism.h |   11 +
 .../amdgpu_dm/amdgpu_dm_kunit_helpers.h       |   19 +
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c |    6 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_psr.h |    5 +
 .../amd/display/amdgpu_dm/amdgpu_dm_replay.c  |    3 +
 .../amd/display/amdgpu_dm/tests/.kunitconfig  |   14 +
 .../drm/amd/display/amdgpu_dm/tests/Makefile  |   18 +
 .../amdgpu_dm/tests/amdgpu_dm_color_test.c    | 1071 +++++++++++++
 .../amdgpu_dm/tests/amdgpu_dm_colorop_test.c  |  161 ++
 .../amdgpu_dm/tests/amdgpu_dm_crc_test.c      |  121 ++
 .../amdgpu_dm/tests/amdgpu_dm_hdcp_test.c     |  175 +++
 .../amdgpu_dm/tests/amdgpu_dm_ism_test.c      |  636 ++++++++
 .../amdgpu_dm/tests/amdgpu_dm_psr_test.c      |  255 ++++
 .../amdgpu_dm/tests/amdgpu_dm_replay_test.c   |  206 +++
 .../drm/amd/display/dc/bios/bios_parser2.c    |    9 +
 .../amd/display/dc/bios/bios_parser_helper.c  |    9 +-
 .../display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c  |    2 +
 drivers/gpu/drm/amd/display/dc/core/dc.c      |    6 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |    3 +-
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h  |    4 +-
 .../dml2_0/dml21/dml21_translation_helper.c   |    5 +-
 .../dc/dml2_0/dml21/inc/dml_top_types.h       |    1 +
 .../dml21/src/dml2_pmo/dml2_pmo_dcn42.c       |  144 +-
 .../dml21/src/dml2_pmo/dml2_pmo_dcn42.h       |    1 +
 .../dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c  |    4 -
 .../dml21/src/dml2_pmo/dml2_pmo_factory.c     |   16 +
 .../dml21/src/dml2_top/dml2_top_soc15.c       |   30 +-
 .../drm/amd/display/dc/dml2_0/dml2_wrapper.h  |    1 +
 .../drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c  |    3 +
 .../amd/display/dc/dpp/dcn30/dcn30_dpp_cm.c   |    1 +
 .../display/dc/dpp/dcn401/dcn401_dpp_dscl.c   |    1 +
 .../display/dc/hubbub/dcn401/dcn401_hubbub.c  |    2 +
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   |    8 +-
 .../amd/display/dc/hwss/dcn10/dcn10_init.c    |    2 +
 .../amd/display/dc/hwss/dcn20/dcn20_init.c    |    2 +
 .../amd/display/dc/hwss/dcn30/dcn30_init.c    |    2 +
 .../amd/display/dc/hwss/dcn301/dcn301_init.c  |    2 +
 .../amd/display/dc/hwss/dcn31/dcn31_init.c    |    2 +
 .../amd/display/dc/hwss/dcn314/dcn314_init.c  |    2 +
 .../amd/display/dc/hwss/dcn32/dcn32_init.c    |    2 +
 .../amd/display/dc/hwss/dcn401/dcn401_init.c  |    2 +
 .../amd/display/dc/hwss/dcn42/dcn42_hwseq.c   |    5 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/optc.h  |    1 -
 .../gpu/drm/amd/display/dc/link/link_dpms.c   |   41 +-
 .../dc/link/protocols/link_dp_irq_handler.c   |   14 +-
 .../dc/link/protocols/link_dp_panel_replay.c  |   13 +
 .../link/protocols/link_edp_panel_control.c   |   26 +-
 .../amd/display/dc/optc/dcn35/dcn35_optc.c    |    1 -
 .../amd/display/dc/optc/dcn42/dcn42_optc.c    |    2 -
 .../amd/display/dc/pg/dcn42/dcn42_pg_cntl.c   |   43 +-
 .../dc/resource/dcn42/dcn42_resource.c        |   12 +-
 .../dc/resource/dcn42/dcn42_resource.h        |    7 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  156 +-
 .../drm/amd/display/modules/inc/mod_power.h   |   23 -
 .../drm/amd/display/modules/power/Makefile    |    4 +-
 .../gpu/drm/amd/display/modules/power/power.c | 1343 +----------------
 .../drm/amd/display/modules/power/power_abm.c |   98 --
 .../amd/display/modules/power/power_helpers.c |  250 ---  .../amd/display/=
modules/power/power_helpers.h |  121 ++  .../drm/amd/display/modules/power/=
power_psr.c |  665 ++++++++  .../amd/display/modules/power/power_replay.c  =
|  911 +++++++++++
 72 files changed, 5060 insertions(+), 1963 deletions(-)  create mode 10064=
4 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.h
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_kunit_h=
elpers.h
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/tests/.kunitconfi=
g
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/tests/Makefile
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_c=
olor_test.c
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_c=
olorop_test.c
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_c=
rc_test.c
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_h=
dcp_test.c
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_i=
sm_test.c
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_p=
sr_test.c
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_r=
eplay_test.c
 create mode 100644 drivers/gpu/drm/amd/display/modules/power/power_psr.c
 create mode 100644 drivers/gpu/drm/amd/display/modules/power/power_replay.=
c

--
2.43.0

