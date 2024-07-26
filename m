Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D32BC3DA49
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Jul 2024 15:22:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C6F4C10E9CB;
	Fri, 26 Jul 2024 15:22:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Hn4L5/iB";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2078.outbound.protection.outlook.com [40.107.220.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E84710E9CB
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Jul 2024 15:22:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AsHy9GW439cYpK0HLlCgJ2m/CDiJdRJdbdjMLxW1whXg30MtlygPB8B57wRwB/Hx0v9+yrGCRdBJyQnDF3AkwWLqh9pcDFwRrjneaApxPbxGbdYHurvMkA5Bhrf7AStJzRL27aL9UJVbFf5VG9iSC6d5exbkdJBz0rtliJZBILrOdhJXEZA6jszhakM0my3ajFeCBHUqp0zM/6WkhyEky+lw+jo+6OBHPo8XNEUJI5x1gft0JXooFgJY64CnuqHarAZdIgiuNdGyimw/JCkrro/A1+5FBi71i1OuRRCEzKTdeWHW9ea5fXycxIuhaC9W7rm2nFHGLoQwS/PLo4qBpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BbN7/HRXF7x7VCGkbDBNCbHjQFycTIDeliFM888L+rM=;
 b=d1TavohZ4I0qzWu2OGomTnrxKZdfhpYjSVkmcpAg7vZe7QMRqQdbfPZCjVpInjbtfi5iF2hggLBDvzWBgkvs1AwjnQJrOwB4HBv4DwMTAY7X4K5jBCkfmwBbM5kFz9XJ72Jp6zzcRlK1Bi07xnBXRl0oV3wp1HxTDDueRVTsdRtC3TcLYIttrUqWK6slkfgdN8mr+kJMhd2/Eu1oKLFLZ5eZZrr82XNx/MxUWtxTHehEoQXIgv5VzDifUCC3ksr6xretJ16TNT8ww6zG78n0vyBR54IDHNPz9CuEb12TACjikt/np+ovV9FH2S+rE7ahERrOE6mFa7dFoVdQSwWR4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BbN7/HRXF7x7VCGkbDBNCbHjQFycTIDeliFM888L+rM=;
 b=Hn4L5/iBRdsVQ0Lg+pUHaSYQShS3gmAw5luWFWcxLoS0/SWOBqO5kl5TGEA3FLyp9YwBvNsziGHg5qsRqvVvXCkBWyX12KI4hGxYMFeCN9AGR2p/K9eHiXmhNSjTVGuImecM2tiZDndcA68y3FRAFYgvpbaYABlD9xZn0e5SeNc=
Received: from DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) by
 BL1PR12MB5777.namprd12.prod.outlook.com (2603:10b6:208:390::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.29; Fri, 26 Jul
 2024 15:22:43 +0000
Received: from DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::ea87:74ba:36ec:8cf6]) by DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::ea87:74ba:36ec:8cf6%4]) with mapi id 15.20.7784.020; Fri, 26 Jul 2024
 15:22:43 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Wentland, Harry" <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)"
 <Sunpeng.Li@amd.com>, "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>, "Li,
 Roman" <Roman.Li@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>, "Gutierrez,
 Agustin" <Agustin.Gutierrez@amd.com>, "Chung, ChiaHsuan (Tom)"
 <ChiaHsuan.Chung@amd.com>, "Zuo, Jerry" <Jerry.Zuo@amd.com>, "Mohamed, Zaeem"
 <Zaeem.Mohamed@amd.com>
Subject: RE: [PATCH 00/39] DC Patches July 25, 2024
Thread-Topic: [PATCH 00/39] DC Patches July 25, 2024
Thread-Index: AQHa3rz70lOshRsclkW9Zlg0DZQKbrIJISVg
Date: Fri, 26 Jul 2024 15:22:42 +0000
Message-ID: <DS0PR12MB6534B0FAD5A5402AD8C721239CB42@DS0PR12MB6534.namprd12.prod.outlook.com>
References: <20240725180309.105968-1-Rodrigo.Siqueira@amd.com>
In-Reply-To: <20240725180309.105968-1-Rodrigo.Siqueira@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ActionId=dec31735-17b3-44bc-b21e-255cde8dc4c2;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=0;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=true;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open Source;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2024-07-26T15:22:39Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6534:EE_|BL1PR12MB5777:EE_
x-ms-office365-filtering-correlation-id: 6b749767-542c-49d3-7582-08dcad86cb70
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?N3/dvr1SE4p1agETXHnNxLEtOCx/M+tFICl9OJaOIdL70HywL4VDoI9t80UZ?=
 =?us-ascii?Q?a51bQwEQVcwtpYgzK+BDLcpM3f32v/clu7tcwXsdrrv6pjnJQ7YfKBVY84Zr?=
 =?us-ascii?Q?3XMmIwPNXxSKWKWMcpoZGmpXTU8c47grnKd/vC//Ij05DSd6IEcuC70JaBTE?=
 =?us-ascii?Q?Zx+q5Bs67uWeDdNE//4PAJNU7iniqaxFYcxzY2qqrtrEwIsC7UUZ/S6kspYn?=
 =?us-ascii?Q?jhx9XKc/HuNMzfqCkUTUiOktPVdcA6S2XfjBAYFCJbgkqLecD2oLBOErn2uu?=
 =?us-ascii?Q?L9uW09VwIQofUiL2hb3HrjV3RzhzVZ6Fnj2dJHMHnAHuBgpmTKGvoESBYmD4?=
 =?us-ascii?Q?stfaGLo6PU/t7dxK1uxUdHIBo2vvyZPynqtE0HFZ4yekYPMGoC0Sezazkwor?=
 =?us-ascii?Q?7GGY3emFcY3G9FhYqxWE2BrP345oAG+ix/1EC1jODAHRtDcFCz8nct7ZLRqV?=
 =?us-ascii?Q?7x/DTtMb4KjfWzJW45NsQ/zOFF+ebyl83IizGp/qZY8npcPPgdH7WuNktJqa?=
 =?us-ascii?Q?HR5fUqZ66tcfuvthPpFuYm3/HQTwt8aQF33h9HZo+jmJlsTcxnh1eFBVz/5K?=
 =?us-ascii?Q?RrPQJ8EDa/JJ5aPZsGokWeX5D6hgNdb2Ze8TkfSEGyYNA3y5Uuhuaa6ldr5k?=
 =?us-ascii?Q?/koDa7tdE2D51rZ4WFeLIJ9wFCgQkJeRdVg/Ih/2h5YBa3ZEI5Xxf/jfOQea?=
 =?us-ascii?Q?qw7stZI2UfApcU0xfgN1H6CeoLsuDNyaS/b/gu/c7yDBPgHrYk6YM9DTgWlD?=
 =?us-ascii?Q?6TgooG0IYUObm2Y/viw00lJnqnsloSSKOlGVxnjAtQeWU2B3P97PBzMT2rf3?=
 =?us-ascii?Q?A5VDMw98IWbdXHS29X0HoUv/P+oTekpyLs49vudu6EYZ+hLrO9AEV5AXtE2t?=
 =?us-ascii?Q?YFY+eitsVyQjH3pfox7D7FptDSrWn53iLng/UjOzf0LtFAPu89++q2UAfKTX?=
 =?us-ascii?Q?AsSaZa2ICMWJvWLC5KTwE0PJFAxsm/ccw0YsP+f5z280j8l/mcwRacomPQdQ?=
 =?us-ascii?Q?pcr1J0RH5f6BMwNI6oAMVM7yY6gBynvt8e2Zg8xVdGD0IYDjSxHI+au/I6Lx?=
 =?us-ascii?Q?aLAz/KkMZUAQW6IZIk3rb6LuPDSwLh/dm0YO/ZPv7VmD1y++qT3FYzeIvLhG?=
 =?us-ascii?Q?G0j56F0qmBsZ0P+5ubPTJeXWrLxGHl+ODEUPhfZljgBIMd9rSIqoXUHnT+mC?=
 =?us-ascii?Q?LlaI+5aoBbmIdDAX14uKt3kWJiI8zrYcuxKlmNbf0dqw/qTg2zRwGv/2NObb?=
 =?us-ascii?Q?fPU0I3nBRvXsYh6/6Yafjhset2kAdAvYH4yptUYeIwg6HQfP5ognI7We7IFM?=
 =?us-ascii?Q?bJYqODQm4RHkp0vRsMhyeGwFLAFk2afbs57ceYXoCXrXLXCiKYKJeCGVffdc?=
 =?us-ascii?Q?zPflgKuOPF8TS2vaW7LLFC5gpRMzGj8WDSTF5g1bi7WVGg4V+g=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6534.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lOVlkJd1rlrREZRlN4e82DSfLDIWRUto+a0r52ybk200LEWXcKAHadbIXZ1s?=
 =?us-ascii?Q?GssqMmAtlyPz9x6q9ucN0gR5kczWh+cFR0t5r88LHX5iic4c6VMD6LQ0eIE9?=
 =?us-ascii?Q?tKts2LCm5J5xOfT+3Y2cHB+qV/P5ydfCegkFYp9yBLmgnAoy4pLqV2bUfZq/?=
 =?us-ascii?Q?JAvqnR+Io/FMVspDKUXdaC1G5un8dCo+xv4KY1rt3k087qeDy4Kg6odWgUU4?=
 =?us-ascii?Q?xqCDmeM9eMPRp/buFis94By970Ppoc3lbMqdJ/91jj//8yrt+zrgS+baXkmn?=
 =?us-ascii?Q?7/6RXUk/wZeqfHzRHM2sjihsPVlmBwXeXIlAyCIinmRVnfjJlvbpxkWvD+V5?=
 =?us-ascii?Q?dol7UfgI5PiLVPC1JU2dUuz1vieyRCai04dMdlwurTwq1ZGKF/OONpkn0pHi?=
 =?us-ascii?Q?8sc+G/o/8HWqLqu23m6KITEEiD0KEKbuOg2Ny9Od2ORx2xiGrCJ3NWcRA5J7?=
 =?us-ascii?Q?qInc/Xk0caEnZxAtGZ+5UK1X/5cArQrs3DJwK/u6bgoN5iNGgFCtiZILh7ZN?=
 =?us-ascii?Q?zRD/I/aNE+qpLh/fa+CirZaNEXJY+SYsVJBaV5dVvFY/wMpv6/xu91I7DG0+?=
 =?us-ascii?Q?4qEtRyIDFKw9BEB7tiaAeF0ERky8MU/rajDymJkfN6jSntktNJ8yeLw7KCfx?=
 =?us-ascii?Q?nxyeL3wJZlm7j44Xn/M6gbOwWhsZWtdfiHtaUXdfcPQ8jvs/4reBK/Pdk2qT?=
 =?us-ascii?Q?8N8JElbt12KX3bILZqsjmAQxC/hhS7EQEGo1YokMAucK/4dh8pbRnOwzIOCH?=
 =?us-ascii?Q?WnfpDdXeKm+i20YnucfvYpNPYbDnZAwydCU70kzUPFfBoDyK0tjw1sDkuyp5?=
 =?us-ascii?Q?UZuaigiXVe3j2iS5yx+IqdVEdPUAQJIag2v02flbrgoQudpiCR5aiH9iFqR1?=
 =?us-ascii?Q?DoK0Q2QGf8FEyLO9s/uBktPMphcl1yUo/lkkItYGLndh037KDxciuXzQAo68?=
 =?us-ascii?Q?lIK5Lp0Dc3Q3aAkbWL7GT0iT4IefaQfeDzOjQLl06CA4XWty3woispTO0/1p?=
 =?us-ascii?Q?U6g5W0GQI09c2c1crR8K39WjvzggYTlXzu/qO/kmg6PXNlrjqYLU+mRwUJWJ?=
 =?us-ascii?Q?EvtgAiTj6qQdScSYV1RMFj8k/H1Lg3QgHCPFjTc77lSpVvXARZArfu4FJ8n7?=
 =?us-ascii?Q?HahYQ8VDnvLCwozoU3+WfrslsKCe1jQSosH46xuqzITH2LmKr/NuY9SsNkJl?=
 =?us-ascii?Q?WrTwtBvAPkQ5BBqGckNFiiRjjiMtEyzmIF2WOGaOxCroFKYWmGOPE1BTxYy6?=
 =?us-ascii?Q?1pelXs8WlxfPnGKe4dczU/ZRa30VB2Prqpp3qTVmTWCqPr0fNcVLbGWJMdVD?=
 =?us-ascii?Q?b1TVULwV4OLRuA9ClLCFDjtbGvMCp/uBBAJMyJdBiwBjh00vuJ4rdDunCsZ+?=
 =?us-ascii?Q?JfD8gDf8SJ5Ehma4MBKMS2gAbevYpOSmFOhKJUfrl/wwaaFahpm5QckbqAJ7?=
 =?us-ascii?Q?YtTFnwhb09//27CCrWVn5CPKJLUlwQV2lFSPIFI/2QaTayo/nDeWUX+9Tji8?=
 =?us-ascii?Q?L/NYwjTGjjTZLrJM7vEYHb92cw1hVqUNHaKkm/sAXyGq9MAMU/oOJDKZDrfl?=
 =?us-ascii?Q?qlDqyaGGIUFKlIllqDY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b749767-542c-49d3-7582-08dcad86cb70
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2024 15:22:42.9658 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KvFOam5GpcTAMlCBrT9CoOG8tulB+/K6MJ3Trewle7CMisy9G6KeHKFD+vbtKo+gVz/bSYeR+MB6npRhwHES5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5777
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

This week this patchset was tested on the following systems:
        * Lenovo ThinkBook T13s Gen4 with AMD Ryzen 5 6600U
        * MSI Gaming X Trio RX 6800
        * Gigabyte Gaming OC RX 7900 XTX

These systems were tested on the following display/connection types:
        * eDP, (1080p 60hz [5650U]) (1920x1200 60hz [6600U]) (2560x1600 120=
hz[6600U])
        * DP/HDMI/USB-C (1440p 170hz, 4k 60hz, 4k 144hz, 4k 240hz [Includes=
 USB-C to DP/HDMI adapters])
        * Thunderbolt (LG Ultrafine 5k)
        * MST (Startech MST14DP123DP [DP to 3x DP] and 2x 4k 60Hz displays)
        * DSC (with Cable Matters 101075 [DP to 3x DP] with 3x 4k60 display=
s, and HP Hook G2 with 1 4k60 display)
        * USB 4 (Kensington SD5700T and 1x 4k 60Hz display)
        * PCON (Club3D CAC-1085 and 1x 4k 144Hz display [at 4k 120HZ, as th=
at is the max the adapter supports])

The testing is a mix of automated and manual tests. Manual testing includes=
 (but is not limited to):
        * Changing display configurations and settings
        * Benchmark testing
        * Feature testing (Freesync, etc.)

Automated testing includes (but is not limited to):
        * Script testing (scripts to automate some of the manual checks)
        * IGT testing

The patchset consists of the amd-staging-drm-next branch (Head commit - 087=
de3e81122 drm/amd/display: 3.2.293) with new patches added on top of it.

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
From: Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>
Sent: Thursday, July 25, 2024 2:01 PM
To: amd-gfx@lists.freedesktop.org
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.L=
i@amd.com>; Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; Pillai, Aurabindo=
 <Aurabindo.Pillai@amd.com>; Li, Roman <Roman.Li@amd.com>; Lin, Wayne <Wayn=
e.Lin@amd.com>; Gutierrez, Agustin <Agustin.Gutierrez@amd.com>; Chung, Chia=
Hsuan (Tom) <ChiaHsuan.Chung@amd.com>; Zuo, Jerry <Jerry.Zuo@amd.com>; Moha=
med, Zaeem <Zaeem.Mohamed@amd.com>; Wheeler, Daniel <Daniel.Wheeler@amd.com=
>
Subject: [PATCH 00/39] DC Patches July 25, 2024

This DC patchset brings improvements in multiple areas. In summary, we
have:

- SPL improvements.
- Address coverity issues.
- DML2 fixes.
- Code cleanup.
- DIO and DCCG refactor.
- Improve the PSR state.

Cc: Daniel Wheeler <daniel.wheeler@amd.com> Thanks Siqueira

Alex Hung (7):
  drm/amd/display: Fix possible overflow in integer multiplication
  drm/amd/display: Check null pointers before using them
  drm/amd/display: Check stream_status before it is used
  drm/amd/display: Avoid overflow assignment in link_dp_cts
  drm/amd/display: Check null values from functions
  drm/amd/display: Initialize get_bytes_per_element's default to 1
  drm/amd/display: Check UnboundedRequestEnabled's value

Alvin Lee (2):
  drm/amd/display: Add option to disable unbounded req in DML21
  drm/amd/display: For FAMS2 don't program P-State force from driver

Aric Cyr (1):
  drm/amd/display: 3.2.294

Bhuvanachandra Pinninti (1):
  drm/amd/display: Refactor for dio

Charlene Liu (2):
  drm/amd/display: restore immediate_disable_crtc for w/a
  drm/amd/display: sync dmub output event type.

Chris Park (1):
  drm/amd/display: Add two dmmuy I2C entry for GPIO port mapping issue

Cruise (2):
  drm/amd/display: Add logs for debugging outbox
  drm/amd/display: Get link index for AUX reply notification

Daniel Sa (1):
  drm/amd/display: Underflow Seen on DCN401 eGPU

Hansen Dsouza (2):
  drm/amd/display: Add new enable and disable functions
  drm/amd/display: Add new enable and disable functions for DCN35

Ilya Bakoulin (1):
  drm/amd/display: Use correct cm_helper function

Leo Li (2):
  drm/amd/display: Let drm_crtc_vblank_on/off manage interrupts
  drm/amd/display: Run idle optimizations at end of vblank handler

Meenakshikumar Somasundaram (1):
  drm/amd/display: Enable aux transfer path via dmub for dp tunneling

Nicholas Kazlauskas (3):
  drm/amd/display: Request 0MHz dispclk for zero display case
  drm/amd/display: Add seamless boot support for more DIG operation
    modes
  drm/amd/display: Use gpuvm_min_page_size_kbytes for DML2 surfaces

Rodrigo Siqueira (9):
  drm/amd/display: Re-order enum in a header file
  drm/amd/display: Setup two pixel per container
  drm/amd/display: Replace dm_execute_dmub_cmd with
    dc_wake_and_execute_dmub_cmd
  drm/amd/display: Add missing DET segments programming
  drm/amd/display: Remove duplicated code
  drm/amd/display: Add missing mcache registers
  drm/amd/display: Add dcc propagation value
  drm/amd/display: Add missing registers for dcn32
  drm/amd/display: Remove unused code

Samson Tam (1):
  drm/amd/display: roll back quality EASF and ISHARP and dc dependency
    changes

Sung Lee (1):
  drm/amd/display: Fix Cursor Offset in Scaled Scenarios

Tom Chung (2):
  drm/amd/display: Add a missing PSR state
  drm/amd/display: Reset VRR config during resume

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   46 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    |   60 +-
 drivers/gpu/drm/amd/display/dc/Makefile       |    1 -
 .../display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c  |    4 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |   14 +-
 .../gpu/drm/amd/display/dc/core/dc_resource.c |    2 +
 drivers/gpu/drm/amd/display/dc/core/dc_stat.c |    1 +
 drivers/gpu/drm/amd/display/dc/dc.h           |    2 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |    3 +
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h  |    2 +-
 .../gpu/drm/amd/display/dc/dc_spl_translate.c |   50 +-
 .../gpu/drm/amd/display/dc/dc_spl_translate.h |    1 -
 drivers/gpu/drm/amd/display/dc/dc_types.h     |    1 +
 .../amd/display/dc/dccg/dcn35/dcn35_dccg.c    |  266 ++-
 drivers/gpu/drm/amd/display/dc/dce/dce_aux.c  |   10 +-
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c |    2 +
 .../gpu/drm/amd/display/dc/dce/dmub_replay.c  |    3 +-
 .../gpu/drm/amd/display/dc/dcn301/Makefile    |    2 +-
 .../gpu/drm/amd/display/dc/dcn314/Makefile    |   10 -
 drivers/gpu/drm/amd/display/dc/dio/Makefile   |   18 +
 .../dcn301/dcn301_dio_link_encoder.c          |    0
 .../dcn301/dcn301_dio_link_encoder.h          |    0
 .../dcn314/dcn314_dio_stream_encoder.c        |    0
 .../dcn314/dcn314_dio_stream_encoder.h        |    0
 .../dc/dio/dcn321/dcn321_dio_link_encoder.c   |    1 -
 .../dc/dio/dcn35/dcn35_dio_stream_encoder.c   |   20 +-
 .../dc/dml/dcn20/display_rq_dlg_calc_20v2.c   |    2 +-
 .../dc/dml/dcn21/display_rq_dlg_calc_21.c     |    2 +-
 .../dc/dml2/dml21/dml21_translation_helper.c  |   13 +-
 .../src/dml2_core/dml2_core_dcn4_calcs.c      |    2 +-
 .../dml21/src/dml2_pmo/dml2_pmo_dcn4_fams2.c  |    8 +
 .../display/dc/dml2/dml2_translation_helper.c |   20 +-
 .../drm/amd/display/dc/dml2/dml2_wrapper.c    |    2 +-
 .../display/dc/dpp/dcn401/dcn401_dpp_dscl.c   |  568 +++---
 .../dc/gpio/dcn401/hw_factory_dcn401.c        |   16 +-
 .../amd/display/dc/hubp/dcn401/dcn401_hubp.c  |    5 +-
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   |    2 +
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |   30 +-
 .../amd/display/dc/hwss/dcn401/dcn401_init.c  |    1 -
 .../gpu/drm/amd/display/dc/inc/hw/clk_mgr.h   |    3 -
 .../amd/display/dc/inc/hw/stream_encoder.h    |    1 +
 .../gpu/drm/amd/display/dc/inc/hw/transform.h |   10 -
 .../display/dc/link/accessories/link_dp_cts.c |    3 +-
 .../amd/display/dc/optc/dcn31/dcn31_optc.c    |    8 +-
 .../dc/resource/dcn32/dcn32_resource.h        |    5 +
 .../resource/dcn32/dcn32_resource_helpers.c   |    4 +-
 .../dc/resource/dcn401/dcn401_resource.c      |    8 +-
 .../dc/resource/dcn401/dcn401_resource.h      |    4 +-
 drivers/gpu/drm/amd/display/dc/spl/Makefile   |    2 +-
 drivers/gpu/drm/amd/display/dc/spl/dc_spl.c   | 1310 +++++--------
 .../drm/amd/display/dc/spl/dc_spl_filters.c   |   15 -
 .../drm/amd/display/dc/spl/dc_spl_filters.h   |   15 -
 .../display/dc/spl/dc_spl_isharp_filters.c    |  427 +---
 .../display/dc/spl/dc_spl_isharp_filters.h    |   33 +-
 .../display/dc/spl/dc_spl_scl_easf_filters.c  | 1726 -----------------
 .../display/dc/spl/dc_spl_scl_easf_filters.h  |   38 -
 .../amd/display/dc/spl/dc_spl_scl_filters.c   |   92 +-
 .../amd/display/dc/spl/dc_spl_scl_filters.h   |   55 +-
 .../display/dc/spl/dc_spl_scl_filters_old.c   |   25 +
 .../gpu/drm/amd/display/dc/spl/dc_spl_types.h |   75 +-
 .../gpu/drm/amd/display/dc/spl/spl_debug.h    |   23 -
 .../drm/amd/display/dc/spl/spl_fixpt31_32.c   |  518 -----
 .../drm/amd/display/dc/spl/spl_fixpt31_32.h   |  546 ------
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |    3 +
 .../gpu/drm/amd/display/dmub/src/dmub_dcn31.c |    4 +
 .../gpu/drm/amd/display/dmub/src/dmub_dcn32.c |    4 +
 .../gpu/drm/amd/display/dmub/src/dmub_dcn35.c |    4 +
 .../drm/amd/display/dmub/src/dmub_dcn401.c    |    4 +
 .../gpu/drm/amd/display/include/dpcd_defs.h   |    1 +
 69 files changed, 1510 insertions(+), 4646 deletions(-)  delete mode 10064=
4 drivers/gpu/drm/amd/display/dc/dcn314/Makefile
 rename drivers/gpu/drm/amd/display/dc/{ =3D> dio}/dcn301/dcn301_dio_link_e=
ncoder.c (100%)  rename drivers/gpu/drm/amd/display/dc/{ =3D> dio}/dcn301/d=
cn301_dio_link_encoder.h (100%)  rename drivers/gpu/drm/amd/display/dc/{ =
=3D> dio}/dcn314/dcn314_dio_stream_encoder.c (100%)  rename drivers/gpu/drm=
/amd/display/dc/{ =3D> dio}/dcn314/dcn314_dio_stream_encoder.h (100%)  dele=
te mode 100644 drivers/gpu/drm/amd/display/dc/spl/dc_spl_filters.c
 delete mode 100644 drivers/gpu/drm/amd/display/dc/spl/dc_spl_filters.h
 delete mode 100644 drivers/gpu/drm/amd/display/dc/spl/dc_spl_scl_easf_filt=
ers.c
 delete mode 100644 drivers/gpu/drm/amd/display/dc/spl/dc_spl_scl_easf_filt=
ers.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/spl/dc_spl_scl_filters_o=
ld.c
 delete mode 100644 drivers/gpu/drm/amd/display/dc/spl/spl_debug.h
 delete mode 100644 drivers/gpu/drm/amd/display/dc/spl/spl_fixpt31_32.c
 delete mode 100644 drivers/gpu/drm/amd/display/dc/spl/spl_fixpt31_32.h

--
2.43.0

