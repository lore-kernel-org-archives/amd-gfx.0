Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 149B5F46100
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Mar 2026 13:18:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABC4C10E3F3;
	Mon, 23 Mar 2026 13:18:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CutSg4aN";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013063.outbound.protection.outlook.com
 [40.107.201.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD6FC10E3F3
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Mar 2026 13:18:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nEm8U6wHcb4oGVwvh2Ul2PXkaWaLCOjg+jNGHxnjOP7/evt/y1eVUbtucVDRRQppLrETssTyg/U63aJlPC4wKQkR/ndRENmDyKkPtLLc58IhKP53sIf4oiCEJnA+d9jM1+Fmuy77JmJxvuxeMr0E1c712RQgGjiolQwLo8IiKX4iKd7uXn1ATQ3VOMpTuSUMNv8lNzvQuDnOgTF+ddC5JCSaDf8zhdKOERcnC+eWoxGycb+IuJapF2SjSGW7uzqtu6746qY7cmFN/HjT04dDR6rJOVS/fu2D4uQ6arzP/83K5gCMwtUFZyJan/57Y1bb026keJsgyzuHUIwmBYRqHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cbFK7Pwo4hsUEPJ4BQqz8VqhBy+mKTcH5AFQdvRVAzI=;
 b=ZQUEwTYdn+wB4yQJiylpdXekHdtlVgZiBHeEe2D8MAz2Xb5IrLwdVYFDe59uGIoohcD7LU1niUnODGV4Z6eZ80M/O7X3Vqr6VQchylF7V6+0yF9E7gQWFNT9ikWAehBo0lPiUvWBdE92PHc6uCi1aQitzPsDOlSW3PQDwTq/IjKvHCCoiHu8a7ohgoeGtV9kFKdOuexrY9OC586zRNNQexrLvgQgkWKhsuUUPjhU3MrZ00F001Q/+H7pXjFGmcsRbnNQLERGGvNteNrjGCTc/fM7voYgUBSJ6aXMFZ+8OmTLAc4qLg+kiqb/12/NWnEyxsPjUC1+Fg3hcV8aCCP4wA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cbFK7Pwo4hsUEPJ4BQqz8VqhBy+mKTcH5AFQdvRVAzI=;
 b=CutSg4aNlgq7AkbMpxjETihqKhL+iiOvkZ5uvC7zET6Y5kGAuYtm3MEs89OZfQjJkpz6qi8/PXjfkQXrPO0uOWOczrASDE37QK0ScRqn18NP08ATfELmKRnk6HxZzzVKozIu6lZcTNTLQfonuIyFQ+VO3HkQ/EvzuWp9Ztd2q60=
Received: from DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) by
 SN7PR12MB7788.namprd12.prod.outlook.com (2603:10b6:806:345::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.20; Mon, 23 Mar 2026 13:18:39 +0000
Received: from DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::b2e1:64e5:3b9e:738a]) by DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::b2e1:64e5:3b9e:738a%4]) with mapi id 15.20.9745.019; Mon, 23 Mar 2026
 13:18:38 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Tseng, Chuan Yu (Max)" <ChuanYu.Tseng@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Wentland, Harry" <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)"
 <Sunpeng.Li@amd.com>, "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>, "Li,
 Roman" <Roman.Li@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>, "Chung,
 ChiaHsuan (Tom)" <ChiaHsuan.Chung@amd.com>, "Zuo, Jerry" <Jerry.Zuo@amd.com>, 
 "Wu, Ray" <Ray.Wu@amd.com>, "LIPSKI, IVAN" <IVAN.LIPSKI@amd.com>, "Hung,
 Alex" <Alex.Hung@amd.com>
Subject: RE: [PATCH 00/31] DC Patches Mar 16 2026
Thread-Topic: [PATCH 00/31] DC Patches Mar 16 2026
Thread-Index: AQHctnK1KXmHb5WhmkKy3UYFwGQGRbW8IbwQ
Date: Mon, 23 Mar 2026 13:18:37 +0000
Message-ID: <DS0PR12MB65346E190C80AB37C072E8639C4BA@DS0PR12MB6534.namprd12.prod.outlook.com>
References: <20260318010224.513094-1-ChuanYu.Tseng@amd.com>
In-Reply-To: <20260318010224.513094-1-ChuanYu.Tseng@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2026-03-23T13:17:11.0000000Z;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source; MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6534:EE_|SN7PR12MB7788:EE_
x-ms-office365-filtering-correlation-id: 146a953c-cfa6-4a8b-83bd-08de88deb1f2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|18002099003|22082099003|56012099003|38070700021;
x-microsoft-antispam-message-info: SyEv2CaV3kVcs+cDB2NfvN0wh3Oj4+Nn3xl9g/sF8xwmML3lEIdBTfRCU3nIWHQtskNSUwlRHSOQox9hM3ebBpnS1HX5HXv87WhimdKbyng+R97qbcpuKkOwGTGKHeA/cNf0obo+Tftve9HXoRlywoWX8jTYprONOHynM5WyfuXgVosBqWXYguZV1AaCeLkLEzyoDBxUOuD6Vs4+j9/q9e/DhMtV9nCj/U6W925+FdW8s0DA9bvnqTcss1zU6X83SFNn130aS2vl9ZxaLWTffi5pFO8SaH0SMODVuWBg67xoSwo75+WR/cfqKDNmUqMkcjKGlaaXeHRKJ4cTQMaInBxhBhi9bkFJsStZ+1LaeAtDZJfcpDse1ec3jq2K8fwdUWHdjw0+YBwJ+5Q3XWyuRBK0+oxXnxLjnVh0IvsuyB14AOhkqVwnfZr0gPbjIaEj+OdaIqhg46VHratwxYwiOjWofxY3NZue3Khoz+7kG3edH+xOXvG6arlZQmrJEJM7ZACeFVXWJTR4vKyhlZ48PKWlEOBr7yEei/po/CLH0YCU5cHxL9yT1yYRx0ksiNFkQwJguB7JExIJ+CYHimUI7rlzdKJne6bVTbX075YvUoCnumP1XMLCjGaiPTSrvAsMgL5WTI8n2PUNDJStqBIwdTLHkmdzwC+lSOFPtI/2ScbMHH1oK0dNREQaq0c4Bi0KiuEy3L8TpOlZJ+QZ21Ix5aPnTPsEmCim95dwA+vTmC05bbN/AWP7cFDr7RxSOhJztVdWGHsDIbPy9ONAjcQrKK2A6zD25mkHCO1nrfAaMfw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6534.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(22082099003)(56012099003)(38070700021);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?/vayRcpRpJMFxreT+PFwh8R8mcW568qgX8tu0vzvC/DyZSGBQ6+++fORXR?=
 =?iso-8859-1?Q?nzwxpNYDD+qksHRwP7lH98Sf0BnA8bJtE0TOexlhggOPNl6fd64pbO9JSu?=
 =?iso-8859-1?Q?divU3YvX27sXsJqt8LCzSaTzL2PY1x3cgIPPSKpIhqIc3tN7pnhhk37THH?=
 =?iso-8859-1?Q?zuv2R74sdl7ODeuQqlXlLsEvq8lXv+qVJpu0M54sG7M6/55bQolbLVFADL?=
 =?iso-8859-1?Q?XzmZjkkh6/0DaFnINakHdj6zoIF5/fJGuHSdCsKUunbZeVz66xwt4RKhbt?=
 =?iso-8859-1?Q?EekXi6colpc9tSfvCjKx/r/VZxPiys5msnlBqdun/Qe7tOjc3SM6wzjHiY?=
 =?iso-8859-1?Q?Vy+ZDjCWN0ZVe506pWxN6jQsrcS+WpgauQp8ilU0O047QAMenu6orqwlNM?=
 =?iso-8859-1?Q?JCyjeEtrz2uFewDDpA9BH8FpuaeVP49U8/Z03tSMykRvdFzFzrBRsfbNPF?=
 =?iso-8859-1?Q?6/ut0pB+36H9h6nDJO1lwkniyIDiSPQRAqetqsF5ZkrIXcKZTKsqhnJsij?=
 =?iso-8859-1?Q?Fo2yHcrNa2rnmAV3NkNn8WW9zPsgupzQOkwrOphIjheI7BQ/w0PELgcexT?=
 =?iso-8859-1?Q?iPUPIRYn2zTjEqZlnvGMf2TJTu3fSpCMscceON4ZAo8tycku9peY1kyAtu?=
 =?iso-8859-1?Q?hCnO+RWu8KygCVnfyGNV3wvxNJI0BYTPb3+B/kubAPatQ+6P3cni4VK93M?=
 =?iso-8859-1?Q?SLDwYmBircDBQff2M6/i4oV1npCgrwda1tKKAu1tkmq6YcfSokjr1U3bxy?=
 =?iso-8859-1?Q?YkliBW/MLe0ePEidiV1W4R+RfPuTL6QNm3qy2XtcIAz6zgVr2dwt0HMap3?=
 =?iso-8859-1?Q?ThJVOeez7EzudH5fFaxRwbkVfQPWZS0iIZZ1W3XRaAXN+xec7z+vrpbsYL?=
 =?iso-8859-1?Q?Q38cR2VJGsAznlz10puJY5IKZTIuZugqHuSWt6+mbtvz3+X8g6gRC5arru?=
 =?iso-8859-1?Q?rDXsrplOTP75CZNJWaogmMV08kP8PS66q7QdUhOH1Ly+seepyl+kRrhIsw?=
 =?iso-8859-1?Q?MM7HC7Tr5/HHYy3YOoB1YXXoR78hLJR/bxWXDqrCygqYrOnhLBRzOOKcCH?=
 =?iso-8859-1?Q?M74KNlP1PqjrmGbQTaTkAH6szKkZKghc1qDrWEdto114qik9QNVWcp7iL5?=
 =?iso-8859-1?Q?eeOa6RwFI0n4wvgI1tq2CSRXyNnBbEl4dUdaS/iVMXpLP1ZIg5ZiyODc+Z?=
 =?iso-8859-1?Q?7WD7OfNtfgfrm3psZ4CSXA03HAa11XyQZnVFywpT5Cwc8LKAQOStZ/rMTV?=
 =?iso-8859-1?Q?m3qvaBWt5sGeMmPCXWnDZgImTt4QEFMU5+635gK2Mwe2UvkGGoJ6ODcAe1?=
 =?iso-8859-1?Q?y7hRHRmq2AV2Yq7jnh+UmD8AX3v9yUYGbhnft+RSR8fUp0OICY5P1ezB+x?=
 =?iso-8859-1?Q?jd6vi5yN1r9lpzFU//1GOcTcAfT4a9GykX9NvfOSuE7Cy6lIZoAJrRE5wO?=
 =?iso-8859-1?Q?gI5HJ7Ill8gsl4QNxKT2zMcaAa9xKBPLZuQNIkqTyCMeh4w3TqNcmzcG/O?=
 =?iso-8859-1?Q?usYAMKtGg8ofMtfjC65VUC6T5LwuA+hdixBOsUCQemai/mRWIHIeQhjoWf?=
 =?iso-8859-1?Q?exM7rwe3OG3sqXUwfpBVzBynLrLs+Ryg173O/ZLQZHbjHaUlEJgLRngG+v?=
 =?iso-8859-1?Q?Ch9tJu7/Q6dUCW2+AXstOkMq6/LfW2WshC47Bl+i7SI3qhCan4wIYPdyRe?=
 =?iso-8859-1?Q?m9iSvVw+NAqaYB08VB0umvN9MDWaYHT+VdOX2+5k6ymCJ2GzWrK3dqIN9A?=
 =?iso-8859-1?Q?mBL4QGAlUQ7usKtZppRLSsD5zoBWu7FO7GxvcCAlUGQNSh?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 146a953c-cfa6-4a8b-83bd-08de88deb1f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2026 13:18:38.1517 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v293ASYk8OviOVP2pD19QAfcCYGfSBcSSNGAtd+hzPwfHTolSbH4SU7eHvsbq+5f0F749QX4XRNHfVDYoPaC2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7788
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


The patchset consists of the amd-staging-drm-next branch (Head commit - 96e=
aa9b94f8177780ebe67d8399eff22f62fd4bc -> Revert "drm/amdgpu: revert to old =
status lock handling v4") with new patches added on top of it.

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
From: Tseng, Chuan Yu (Max) <ChuanYu.Tseng@amd.com>
Sent: Tuesday, March 17, 2026 8:59 PM
To: amd-gfx@lists.freedesktop.org
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.L=
i@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>; Li, Roman <Roman.=
Li@amd.com>; Lin, Wayne <Wayne.Lin@amd.com>; Chung, ChiaHsuan (Tom) <ChiaHs=
uan.Chung@amd.com>; Zuo, Jerry <Jerry.Zuo@amd.com>; Wheeler, Daniel <Daniel=
.Wheeler@amd.com>; Wu, Ray <Ray.Wu@amd.com>; LIPSKI, IVAN <IVAN.LIPSKI@amd.=
com>; Hung, Alex <Alex.Hung@amd.com>; Tseng, Chuan Yu (Max) <ChuanYu.Tseng@=
amd.com>
Subject: [PATCH 00/31] DC Patches Mar 16 2026

This DC patchset brings improvements in multiple areas. In summary, we high=
light:

- Rework YCbCr422 DSC policy
- Restore full update for tiling change to linear
- add dccg FGCG mask init
- Remove unnecessary completion flag for secure display
- Agument live + capture with CVT case.
- remove dc_clock_limit for apu
- Fix Signed/Unsigned Int Usage Compiler Warning
- Hardcode dtbclk value in bw_params
- Revert inbox0 lock for cursor due to deadlock
- Add 3DLUT DMA broadcast support
- Fix Silence warnings
- export get_power_profile interface for later use
- pg cntl update based on previous asic.
- remove disable_sutter touch pstate debug code
- Refactor DC update checks
- Fix drm_edid leak in amdgpu_dm
- Add Extra SMU Log for dtbclk
- Clamp min DS DCFCLK value to DCN limit
- Update dpia supported configuration
- Multiple DCN42 updates

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Alex Hung (1):
  drm/amd/display: Fix drm_edid leak in amdgpu_dm

Alexander Chechik (1):
  drm/amd/display: Fix DCN42 memory clock table using MemClk instead of
    UClk

Charlene Liu (8):
  drm/amd/display: dcn42 don't round up disclk and dppclk
  drm/amd/display: System Hang When System enters to S0i3 w/ iGPU
  drm/amd/display: Add Extra SMU Log for dtbclk
  drm/amd/display: remove disable_sutter touch pstate debug code
  drm/amd/display: pg cntl update based on previous asic.
  drm/amd/display: export get_power_profile interface for later use
  drm/amd/display: remove dc_clock_limit for apu
  drm/amd/display: add dccg FGCG mask init

ChunTao Tso (1):
  drm/amd/display: Agument live + capture with CVT case.

Dillon Varone (2):
  drm/amd/display: Refactor DC update checks
  drm/amd/display: Add 3DLUT DMA broadcast support

Dmytro Laktyushkin (1):
  drm/amd/display: move dcn42 bw_params init

Gaghik Khachatrian (2):
  drm/amd/display: Fix Silence warnings
  drm/amd/display: Fix Signed/Unsigned Int Usage Compiler Warning

Ivan Lipski (2):
  drm/amd/display: Move DPM clk read to clk_mgr_construct in DCN42
  drm/amd/display: Move DPM clk read to clk_mgr_construct in DCN42

Joshua Aberback (1):
  drm/amd/display: Restore full update for tiling change to linear

Matthew Stewart (1):
  drm/amd/display: Hardcode dtbclk value in bw_params

Meenakshikumar Somasundaram (1):
  drm/amd/display: Update dpia supported configuration

Nicholas Kazlauskas (3):
  drm/amd/display: Add MRQ programming for DCN42
  drm/amd/display: Split arbiter programming for DCN42
  drm/amd/display: Revert inbox0 lock for cursor due to deadlock

Relja Vojvodic (1):
  drm/amd/display: Rework YCbCr422 DSC policy

Roman Li (4):
  drm/amd/display: Add get_default_tiling_info for dcn42
  drm/amd/display: Add missing dcn42 hubbub function pointers
  drm/amd/display: Clamp min DS DCFCLK value to DCN limit
  drm/amd/display: Update underflow detection for DCN42

Taimur Hassan (1):
  drm/amd/display: Promote DC to 3.2.375

Wayne Lin (1):
  drm/amd/display: Remove unnecessary completion flag for secure display

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   9 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c |   7 -
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_crc.h |   1 -
 .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    |   2 +-
 .../display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c  | 263 ++++-----
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 500 +++++++-----------
 .../gpu/drm/amd/display/dc/core/dc_stream.c   |  30 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |  25 +-
 drivers/gpu/drm/amd/display/dc/dc_dsc.h       |   1 +
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h  |   4 +
 drivers/gpu/drm/amd/display/dc/dc_types.h     |   8 +-
 .../amd/display/dc/dccg/dcn42/dcn42_dccg.h    |   1 +
 .../display/dc/dml2_0/dml2_dc_resource_mgmt.c |   2 +-
 .../dc/dml2_0/dml2_translation_helper.c       |   6 +-
 drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c   |  13 +-
 .../drm/amd/display/dc/dsc/dcn20/dcn20_dsc.c  |   2 +-
 .../drm/amd/display/dc/dsc/dcn35/dcn35_dsc.c  |   2 +-
 .../amd/display/dc/dsc/dcn401/dcn401_dsc.c    |   2 +-
 .../display/dc/hubbub/dcn42/dcn42_hubbub.c    |  63 ++-
 .../amd/display/dc/hubp/dcn42/dcn42_hubp.c    |  35 +-
 .../amd/display/dc/hubp/dcn42/dcn42_hubp.h    |   6 +
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c | 108 ++--
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.h |   3 +-
 .../amd/display/dc/hwss/dcn42/dcn42_hwseq.c   |   3 +-
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |   2 +-
 .../drm/amd/display/dc/link/link_detection.c  |  10 +-
 .../gpu/drm/amd/display/dc/link/link_dpms.c   |   3 +-
 .../amd/display/dc/pg/dcn42/dcn42_pg_cntl.c   |   9 +-
 .../dc/resource/dcn31/dcn31_resource.c        |   2 +
 .../dc/resource/dcn315/dcn315_resource.c      |   2 +
 .../dc/resource/dcn401/dcn401_resource.c      |   2 +-
 .../dc/resource/dcn401/dcn401_resource.h      |   1 +
 .../dc/resource/dcn42/dcn42_resource.c        |   5 +-
 .../dc/resource/dcn42/dcn42_resource.h        |   3 +
 .../dcn42/dcn42_soc_and_ip_translator.c       |   8 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |   1 +
 .../gpu/drm/amd/display/dmub/src/dmub_dcn42.c |   7 +-
 .../amd/display/modules/color/color_gamma.c   |   2 +
 .../amd/display/modules/freesync/freesync.c   |   6 +
 .../gpu/drm/amd/display/modules/hdcp/hdcp.h   |   1 +
 .../include/asic_reg/dcn/dcn_4_2_0_offset.h   |   6 +
 41 files changed, 588 insertions(+), 578 deletions(-)

--
2.43.0

