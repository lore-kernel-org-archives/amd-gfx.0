Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54EDAC4332F
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Dec 2023 22:22:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD57910E2EA;
	Thu, 14 Dec 2023 22:22:16 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2051.outbound.protection.outlook.com [40.107.92.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9864610E2EA
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Dec 2023 22:22:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S/DGBI4SnYqQKRL7t7KGW32Y21uWyivUas8C36TQxgPjRt8tXN1tAvgMtEXbPqrKdnGCgaJ8E9IlpevTUdiWHdSwGwbCTzOOQHMPKqWhYOAhzQzgLxp8ZJ6brUNVKtofnVLqELXSaHsJ9EcpQu71g0D3l8GMcLqCTXtE7g8k4VqLvAY7uw2IiTy7qOpFrkDzFXjwQsbfFbUu3W9YOs3lKoM2MPG3egOyOKjF27P7m6UXW6I1XPEpL11Vtne8hTJ+p1Sb72gW6Nny07rzns/mHHADo78l+2XVFTRnpKZpL51nYXQU0G9/eLc1WqzTJqH4bHiamDnpavqmqT95bD4N2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IPPCLdT+bLJibedxguJSK6Tbja7qEyG28mPmz4jubWo=;
 b=N9cDX6NOrAZqgUu1/kbuSpkC9B0Um60zwPR8UQ2o72/zR3gCd5ft5w95e7cEVhOru0+dbMZkckTAqhQUIPKm/yx+1F3o3hQEO5M+im1xfl2UFyc74t+S4fuxQtk3XoYZHbtMMe3D4tYXo21+N4KSDl1wXMNGNss8afXVj91vx9FRbEDmRgsYYEcvjSd+yx0kLbHz9RdJV/n5e6kedICRFpz5+IV+P9MT582avKRSluOOPa1kExaXQ81NinGxHfwlQOoKQLksPEQUzF0OpplOxecRwligN5EswCtiQ4gJyvaWdLl9PP98tZMf/ibG3tuoaz4afWypYNvoYG4bvyNS9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IPPCLdT+bLJibedxguJSK6Tbja7qEyG28mPmz4jubWo=;
 b=vurRWYSO6IdEtdojsxH2mmnsxgI/J37y2cfXZYR/2hyPqsq8R1HuVNoPQiQfq5RRxhiUZbUf8bCstH+VQgYLmSnYpHuYilI/UJNzduy2ljkSIbN/sHLsExTUW/jYUbUxYEjKHeX94CKdODKxPveACE/mYqEjfEjf2yqxLkIKLEg=
Received: from DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) by
 SN7PR12MB6813.namprd12.prod.outlook.com (2603:10b6:806:267::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Thu, 14 Dec
 2023 22:22:07 +0000
Received: from DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::246:b20b:f0c1:bbf7]) by DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::246:b20b:f0c1:bbf7%7]) with mapi id 15.20.7091.028; Thu, 14 Dec 2023
 22:22:07 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Lin, Wayne" <Wayne.Lin@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 00/25] DC Patches for Dec 18, 2023
Thread-Topic: [PATCH 00/25] DC Patches for Dec 18, 2023
Thread-Index: AQHaLYtpmxClf0RwnE+o1+E5H0z6a7CpXEUA
Date: Thu, 14 Dec 2023 22:22:07 +0000
Message-ID: <DS0PR12MB65347D599177535037D24C979C8CA@DS0PR12MB6534.namprd12.prod.outlook.com>
References: <20231213061227.1750663-1-Wayne.Lin@amd.com>
In-Reply-To: <20231213061227.1750663-1-Wayne.Lin@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=a7b3431a-f70d-4760-b8e9-74bb4a0e5938;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-12-14T22:20:29Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6534:EE_|SN7PR12MB6813:EE_
x-ms-office365-filtering-correlation-id: 41774715-deb3-4671-6f36-08dbfcf31bc6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 69eKNnnkvD0+VP9s9SrbZ0olgKYALAIHuu2HBf7nOqPyycdBoCifpNQpaBPJ64ESShqPCGaeX9otMZfuUNkSksdFOQdadTHjvI7DpIi7DzLSyOCLOZ5UZ4V4K+58RHloAb9zuIAuig3+p5oWMS46oqqkJtfRC7WSveWFs4Ptn/LPwhblJc0hI+HrCf/JOVuF6QuLePzdZFyz4pLbepUrkBnZVWFqHv4DuW2mtp86L76hEJxP5zIEAuJk/JzsfM50hX0/7IuRxv5xyTtCMSAAEl35tg3gxST276PuXHztsLbQGs59zgMckB9p01XZmyeSnate9VVPMgKHPMSZyAAnyQmETl5GWMtkpk+5zuNnNhi3Nff/tQmq2SskSJtJU9MEeKmoxi5H+4wyP0pW+rQD+A4lp26VNdp5Vfj1vT/NYEZj5KCUQkZby9HBgqa3dAb7BQoCWEAZMnz8tGAZH2wSjocEnKcXBrIIUVoqZnzswaVelAleQ5S6gtBgQ2hdkMFFsUfgcjxZ8aWGE8TqgX9KbV7Amoc6iVpznYGdOdlBYqmoWNn/4Wt4oQFYQgQngeLzv1ByziFljw5+wGVw/C/Meyoc7ctdYd3+LCab7lNwlkQft4tubD65/JmIyxc4LlEj
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6534.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(376002)(136003)(346002)(396003)(39860400002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(55016003)(26005)(9686003)(7696005)(6506007)(71200400001)(86362001)(33656002)(38070700009)(38100700002)(5660300002)(52536014)(4326008)(8676002)(8936002)(83380400001)(53546011)(122000001)(66446008)(54906003)(110136005)(66946007)(66556008)(76116006)(64756008)(41300700001)(2906002)(316002)(478600001)(66476007);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9Vd0grvCJtwoKabNRkTbcSIYUXHoLhIMktrJrCU2/RyoLXwWlUN+dWtMq69E?=
 =?us-ascii?Q?q25F831vy5YDG+kOsIaXbbrzcSeHt3JsETxG3UTv5ME3JNc/GcPAAc9Bmu8X?=
 =?us-ascii?Q?x20st2rfnFGUowL3PmJbMAFaLdcjLUdLNzbolpnZvQlAu+qBAno1G5TrweUa?=
 =?us-ascii?Q?/dacXCsmhhUllo8VK6fd8UKzBKZU56fgxEDfLsx00RoVJz7HXR/mwFwcRlTK?=
 =?us-ascii?Q?sxhy1CDRWg0kaprbCyekhI7s7rUVWUs7405Pgq1GtVbfGX2nQPVNe5OrR5Cm?=
 =?us-ascii?Q?aG2wC7wuZd295D2ptnyrJqMbFYfi4UgUJje/Bhse8fX7aBZdbQiyQ1xeiCXb?=
 =?us-ascii?Q?xSuawsd35g06+QzCEuFxPnbtEiW6kDLm/xUa0EdUAOj4rHhtc/tlT4OgZXWW?=
 =?us-ascii?Q?H6qEL7fEBf3+e0/av3u+4hsYCg7y9yoYNyDWgEaPoWqHx7U/anLu9CQzl+/z?=
 =?us-ascii?Q?NJ+BhVApUzyNhWkfGLqzrN/fXNoGq2uc0vMY+kUTWNDfqjFKNRf6H7XSkmJD?=
 =?us-ascii?Q?OhOerGHY5CGKpHadTrAkSEnmmVaM1QVQHRr533P5jTTJWtnihs5bWqetH7Zg?=
 =?us-ascii?Q?K4v518Hrjw9YhMfdalLZwuXaYLAL9FFMzoePuMrKFIS3GigSxCsRJIbbj1V2?=
 =?us-ascii?Q?aBsRiXaRx7cFaoAWhFcWKzObTZ3gsM1sZIqwhjSN48nibdE4dC+YDF4lxonm?=
 =?us-ascii?Q?+zACprGT8YVQUPVtj7+rkgaC4ivQROYFdpi6KnxYi6xIf6BCwHGwudo/pGaf?=
 =?us-ascii?Q?nOcZ/UYa7Exf8NqijzNsUqRImpvPpp1hZg3paLp6zrqPbnK9lw6go5JBcrjK?=
 =?us-ascii?Q?hBgXsPzq3FX3ErEU8GrJ1uavu/WwNBHV9I8zMdumaei/wTNPf2vaFhB8WmIS?=
 =?us-ascii?Q?uMjCxtUlQQhwTZLHjE+9W/Kprn38UbxuxU+MV60TCktb+lcNV48JIKq+BHLN?=
 =?us-ascii?Q?gH1PvGcT5JezI6bqiKHi3yrJZWmvL9snqmwRfUPX7hd+YgbEmz14KVZVHyMM?=
 =?us-ascii?Q?ieq4tXb+lZ8CZtxAZauCFHVRdQCw8dA3v3VqgfnbQVKCIqw3WCNKKmtxTgWL?=
 =?us-ascii?Q?SvL3TWqppyY8GtGs+uUBVLce7h7nbSDEYB3jUfYy8BVHcly9/2JM58JgbLTk?=
 =?us-ascii?Q?EurFBIszV+552n49CzxWQwafhRLot8TAlJkgzHSyJPc2LzRVIpKLHcareuQa?=
 =?us-ascii?Q?46deFMHs2fuUBMa7f1WlEeco6Q0gHDvq4n9yiWUWMSppEBcmdznAKUFKnPjr?=
 =?us-ascii?Q?As8tNkcOsdA8By6XctiMwGzc2eBGl7GF3cycqmcYwrNrPkxToJQtRy3qS4rE?=
 =?us-ascii?Q?1ZAA6+mJPdwj4Q7XlN7btyz4lpSBUcY2SWnguexkwV75fpU+ERj3yw5CWrd/?=
 =?us-ascii?Q?giLMC68LuuoSy6Jk1Ehw70+RYYqJ9jEfFo7hScVde4LMk6S2pnL0+JU5mc+t?=
 =?us-ascii?Q?oysoE6NbnvC1VTm8oXSgvBU+GyXxPWADNeKB1Ydp5YUFNn+rA3px9c4f8Eep?=
 =?us-ascii?Q?mlDg4tloGYEQnJbUUF3ataEWPm9YZgxG2J/52VBnqBv45bcE97EcANA1oBGm?=
 =?us-ascii?Q?Qak904Z2eZQX6g7aTIA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41774715-deb3-4671-6f36-08dbfcf31bc6
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2023 22:22:07.6213 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Yf+tGOedPP9xOVXRuMOY+sQsC2dRDVZwCTry6+wfJqL42L5j7OYZc4YV5VcrJuf53LvR1pBa1g7uecBKeeiQQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6813
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
Cc: "Wang, Chao-kai \(Stylon\)" <Stylon.Wang@amd.com>, "Chung,
 ChiaHsuan \(Tom\)" <ChiaHsuan.Chung@amd.com>, "Li,
 Sun peng \(Leo\)" <Sunpeng.Li@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>, "Li, Roman" <Roman.Li@amd.com>, "Zuo,
 Jerry" <Jerry.Zuo@amd.com>, "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>,
 "Wu, Hersen" <hersenxs.wu@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>,
 "Wentland, Harry" <Harry.Wentland@amd.com>, "Gutierrez,
 Agustin" <Agustin.Gutierrez@amd.com>
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
        * VGA and DVI (1680x1050 60hz [DP to VGA/DVI, USB-C to VGA/DVI])
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

The patchset consists of the amd-staging-drm-next branch (Head commit - cf2=
5f7abf109 drm/amdgpu: xgmi_fill_topology_info) with new patches added on to=
p of it.

Tested on Ubuntu 22.04.3, on Wayland and X11, using KDE Plasma and Gnome.


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
From: Wayne Lin <Wayne.Lin@amd.com>
Sent: Wednesday, December 13, 2023 1:12 AM
To: amd-gfx@lists.freedesktop.org
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.L=
i@amd.com>; Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; Pillai, Aurabindo=
 <Aurabindo.Pillai@amd.com>; Li, Roman <Roman.Li@amd.com>; Lin, Wayne <Wayn=
e.Lin@amd.com>; Wang, Chao-kai (Stylon) <Stylon.Wang@amd.com>; Gutierrez, A=
gustin <Agustin.Gutierrez@amd.com>; Chung, ChiaHsuan (Tom) <ChiaHsuan.Chung=
@amd.com>; Wu, Hersen <hersenxs.wu@amd.com>; Zuo, Jerry <Jerry.Zuo@amd.com>=
; Lin, Wayne <Wayne.Lin@amd.com>; Wheeler, Daniel <Daniel.Wheeler@amd.com>
Subject: [PATCH 00/25] DC Patches for Dec 18, 2023

This DC patchset brings improvements in multiple areas. In summary, we high=
light:

- change static screen wait frame_count for ips
- Fix hang/underflow when transitioning to ODM4:1
- Only clear symclk otg flag for HDMI
- Fix lightup regression with DP2 single display configs
- Refactor phantom resource allocation
- Refactor dc_state interface
- Wake DMCUB before executing GPINT commands
- Wake DMCUB before sending a command
- Refactor DMCUB enter/exit idle interface
- enable dcn35 idle power optimization
- fix usb-c connector_type
- add debug option for ExtendedVBlank DLG adjust
- Set test_pattern_changed update flag on pipe enable
- dereference variable before checking for zero
- get dprefclk ss info from integration info table
- skip error logging when DMUB is inactive from S3
- make flip_timestamp_in_us a 64-bit variable
- Add case for dcn35 to support usb4 dmub hpd event
- Add function for dumping clk registers
- Unify optimize_required flags and VRR adjustments
- Revert using channel_width as 2 for vram table 3.0
- remove HPO PG in driver side
- do not send commands to DMUB if DMUB is inactive from S3

Cc: Daniel Wheeler <daniel.wheeler@amd.com>
---

Allen Pan (2):
  drm/amd/display: fix usb-c connector_type
  drm/amd/display: change static screen wait frame_count for ips

Alvin Lee (2):
  drm/amd/display: Revert " drm/amd/display: Use channel_width =3D 2 for
    vram table 3.0"
  drm/amd/display: Only clear symclk otg flag for HDMI

Anthony Koo (1):
  drm/amd/display: [FW Promotion] Release 0.0.197.0

Aric Cyr (2):
  drm/amd/display: Unify optimize_required flags and VRR adjustments
  drm/amd/display: 3.2.265

Charlene Liu (1):
  drm/amd/display: get dprefclk ss info from integration info table

Dillon Varone (2):
  drm/amd/display: Refactor dc_state interface
  drm/amd/display: Refactor phantom resource allocation

George Shen (1):
  drm/amd/display: Set test_pattern_changed update flag on pipe enable

Ilya Bakoulin (1):
  drm/amd/display: Fix hang/underflow when transitioning to ODM4:1

Johnson Chen (1):
  drm/amd/display: Add function for dumping clk registers

Josip Pavic (2):
  drm/amd/display: make flip_timestamp_in_us a 64-bit variable
  drm/amd/display: dereference variable before checking for zero

Michael Strauss (1):
  drm/amd/display: Fix lightup regression with DP2 single display
    configs

Muhammad Ahmed (2):
  drm/amd/display: remove HPO PG in driver side
  drm/amd/display: add debug option for ExtendedVBlank DLG adjust

Nicholas Kazlauskas (3):
  drm/amd/display: Refactor DMCUB enter/exit idle interface
  drm/amd/display: Wake DMCUB before sending a command
  drm/amd/display: Wake DMCUB before executing GPINT commands

Roman Li (1):
  drm/amd/display: enable dcn35 idle power optimization

Samson Tam (2):
  drm/amd/display: do not send commands to DMUB if DMUB is inactive from
    S3
  drm/amd/display: skip error logging when DMUB is inactive from S3

Wayne Lin (1):
  drm/amd/display: Add case for dcn35 to support usb4 dmub hpd event

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  59 +-  .../amd/display/am=
dgpu_dm/amdgpu_dm_debugfs.c |  29 +-
 drivers/gpu/drm/amd/display/dc/Makefile       |   2 +-
 .../drm/amd/display/dc/bios/bios_parser2.c    |  27 +-
 .../drm/amd/display/dc/bios/command_table2.c  |  12 +-
 .../gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c  |   3 +-
 .../display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c  |   2 +-
 .../dc/clk_mgr/dcn314/dcn314_clk_mgr.c        |   2 +-
 .../dc/clk_mgr/dcn315/dcn315_clk_mgr.c        |   2 +-
 .../dc/clk_mgr/dcn316/dcn316_clk_mgr.c        |   2 +-
 .../display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c  |   9 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 300 ++----
 .../drm/amd/display/dc/core/dc_hw_sequencer.c |  19 +-  .../gpu/drm/amd/di=
splay/dc/core/dc_resource.c | 418 +--------
 .../gpu/drm/amd/display/dc/core/dc_state.c    | 861 ++++++++++++++++++
 .../gpu/drm/amd/display/dc/core/dc_stream.c   |  46 +-
 .../gpu/drm/amd/display/dc/core/dc_surface.c  |   6 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |  33 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  | 244 ++++-  drivers/gpu/drm=
/amd/display/dc/dc_dmub_srv.h  |  59 +-
 drivers/gpu/drm/amd/display/dc/dc_helper.c    |   6 +-
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h  |   2 +-
 drivers/gpu/drm/amd/display/dc/dc_plane.h     |  38 +
 .../gpu/drm/amd/display/dc/dc_plane_priv.h    |  34 +
 drivers/gpu/drm/amd/display/dc/dc_state.h     |  78 ++
 .../gpu/drm/amd/display/dc/dc_state_priv.h    | 102 +++
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |  76 +-
 .../gpu/drm/amd/display/dc/dc_stream_priv.h   |  37 +
 drivers/gpu/drm/amd/display/dc/dc_types.h     |   5 +
 .../gpu/drm/amd/display/dc/dce/dmub_abm_lcd.c |  14 +-
 .../drm/amd/display/dc/dce/dmub_hw_lock_mgr.c |   2 +-
 .../gpu/drm/amd/display/dc/dce/dmub_outbox.c  |   2 +-
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c |  33 +-
 .../gpu/drm/amd/display/dc/dcn21/dcn21_hubp.c |   2 +-
 .../display/dc/dcn31/dcn31_dio_link_encoder.c |   4 +-
 .../amd/display/dc/dcn31/dcn31_panel_cntl.c   |   4 +-
 .../display/dc/dcn32/dcn32_resource_helpers.c |  93 +-
 .../display/dc/dcn35/dcn35_dio_link_encoder.c |   5 +
 .../gpu/drm/amd/display/dc/dcn35/dcn35_init.c |   2 +-
 .../drm/amd/display/dc/dml/dcn20/dcn20_fpu.c  |   5 +-
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  |  51 +-
 .../amd/display/dc/dml2/display_mode_core.c   |   2 +-
 .../drm/amd/display/dc/dml2/dml2_dc_types.h   |   1 +
 .../amd/display/dc/dml2/dml2_mall_phantom.c   |  89 +-
 .../display/dc/dml2/dml2_translation_helper.c |  10 +-  .../gpu/drm/amd/di=
splay/dc/dml2/dml2_utils.c  |  14 +-
 .../drm/amd/display/dc/dml2/dml2_wrapper.c    |   2 +-
 .../drm/amd/display/dc/dml2/dml2_wrapper.h    |  35 +-
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c |  13 +-
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   |  35 +-
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.h   |   7 +-
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   |  79 +-
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.h   |   2 +-
 .../amd/display/dc/hwss/dcn201/dcn201_hwseq.c |   8 +-
 .../amd/display/dc/hwss/dcn201/dcn201_hwseq.h |   2 +-
 .../amd/display/dc/hwss/dcn21/dcn21_hwseq.c   |   4 +-
 .../amd/display/dc/hwss/dcn30/dcn30_hwseq.c   |  12 +-
 .../amd/display/dc/hwss/dcn31/dcn31_hwseq.c   |   7 +-
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.c   |  78 +-
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   |  58 +-
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.h   |   6 +-
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |   8 +-
 .../display/dc/hwss/hw_sequencer_private.h    |   1 +
 .../gpu/drm/amd/display/dc/inc/core_types.h   |  20 +-
 .../gpu/drm/amd/display/dc/inc/hw/clk_mgr.h   |  19 +
 .../gpu/drm/amd/display/dc/inc/hw/hw_shared.h |   1 +
 drivers/gpu/drm/amd/display/dc/inc/resource.h |   1 -
 .../dc/link/protocols/link_dp_capability.c    |   2 +-
 .../display/dc/link/protocols/link_dp_dpia.c  |   3 +-
 .../amd/display/dc/optc/dcn32/dcn32_optc.c    |   7 +
 .../amd/display/dc/optc/dcn35/dcn35_optc.c    |   7 +
 .../dc/resource/dcn32/dcn32_resource.c        | 134 +--
 .../dc/resource/dcn32/dcn32_resource.h        |  14 -
 .../dc/resource/dcn321/dcn321_resource.c      |  25 +-
 .../dc/resource/dcn35/dcn35_resource.c        |   8 +-
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |  22 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |   2 +-
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   |  15 +
 .../display/include/grph_object_ctrl_defs.h   |   2 +
 79 files changed, 2147 insertions(+), 1338 deletions(-)  create mode 10064=
4 drivers/gpu/drm/amd/display/dc/core/dc_state.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dc_plane.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dc_plane_priv.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dc_state.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dc_state_priv.h
 create mode 100644 drivers/gpu/drm/amd/display/dc/dc_stream_priv.h

--
2.37.3

