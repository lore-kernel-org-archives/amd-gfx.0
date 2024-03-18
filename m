Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55F30C54E58
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Mar 2024 13:54:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFEBE10E314;
	Mon, 18 Mar 2024 13:54:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eAEKcPte";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2066.outbound.protection.outlook.com [40.107.220.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0E6C10E314
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Mar 2024 13:54:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q0udwuq/qDIjKrAi56/aaMGWXtn7vPBsTvR468ZmD/9mn9LTojgLHF/6a1YCsp3rMReFKbCeT0tgmbSemeAh9i96sM2YWjJTwOM47Oj0euV5TVtEMBaXYrcebek7/IbLn2tbbtzmZn82KSDIJq3JJuWXWwv6jDyt4rA6W3ubLfRmg2mDp04i3GzzLXVKYPmysp4PJ2g2JyRiqGtZhdQeathKtLFIv8mvJHuF36+wR5wnxRpH0GQ9TE56NWLILgFRU60FewlYIsKJ4RflTB/XrGzjXF7RZTNxIv0NqKeULDCR8MqwXyk2VxNt3GD1GutXqNeNrUWZFQ4pW3ht/c2mHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MbUNvEWfQugJJaRarTc2TERJi8yRrArprR2pWqUuS/k=;
 b=jXBQSO6StUuaFy5uKuj6ycs1kaswN6A/bXir6Wh6iJEq8X1kFFB1dX4Bb1GBmtfkgYRd3bawHneCSd4BM9Qkeb098IludsuLRrxW8PBikHmzq618158E/TE7kRFNZRTXuR5atTy8haZZTUnDC7VcJqQ+jpiY32HdQBqlCeAV+fuBKTi8Sb3c47C4sut/QJTekB1Rm2R6WR3h1aOZSTVmAiKQvuvb6Tul7axkfsEs+Qb+vk6Gqh7nFA1h0eg8RMWVmwtQOCssAqJ6qlTAOJCVncfCnmgZhvpgZIQ/wOnwqqKr0D1sjlCbzMyI75AB3712FY9XHjWEZKmv2Zc/BxDiaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MbUNvEWfQugJJaRarTc2TERJi8yRrArprR2pWqUuS/k=;
 b=eAEKcPteOzCELT0rtGSK7yFcNdokhg4qT5K4S974WY/zB27KEKvnG3P7cPCBH+wLlZgg3lErPIjVIEos/iYQFnkbscfaun5gy96VBWqtmqUMFBbRkNC0mXaW3tSaxywr1ttgQWfdG+PZTyZ73d8urbiOzaecJHdJiU6ZjaAoDKg=
Received: from DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) by
 SJ2PR12MB9138.namprd12.prod.outlook.com (2603:10b6:a03:565::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7386.26; Mon, 18 Mar 2024 13:54:49 +0000
Received: from DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::6503:7457:78d3:b2f4]) by DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::6503:7457:78d3:b2f4%5]) with mapi id 15.20.7386.025; Mon, 18 Mar 2024
 13:54:49 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Lin, Wayne" <Wayne.Lin@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Wentland, Harry" <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)"
 <Sunpeng.Li@amd.com>, "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
 "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>, "Li, Roman"
 <Roman.Li@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>, "Gutierrez, Agustin"
 <Agustin.Gutierrez@amd.com>, "Chung, ChiaHsuan (Tom)"
 <ChiaHsuan.Chung@amd.com>, "Wu, Hersen" <hersenxs.wu@amd.com>, "Zuo, Jerry"
 <Jerry.Zuo@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>
Subject: RE: [PATCH 00/43] DC Patches March 18, 2024
Thread-Topic: [PATCH 00/43] DC Patches March 18, 2024
Thread-Index: AQHadF6YsHqvq9ZDQEu9hilC2REXQrE9jqaw
Date: Mon, 18 Mar 2024 13:54:49 +0000
Message-ID: <DS0PR12MB65346BEAD764293E9B2143829C2D2@DS0PR12MB6534.namprd12.prod.outlook.com>
References: <20240312092036.3283319-1-Wayne.Lin@amd.com>
In-Reply-To: <20240312092036.3283319-1-Wayne.Lin@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=7a2191e6-2499-40ad-b1b3-91b2c9f0d790;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2024-03-18T13:54:10Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6534:EE_|SJ2PR12MB9138:EE_
x-ms-office365-filtering-correlation-id: 7c6c7e1d-d5d0-4319-2698-08dc4752fa93
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vKrKQrEqiJnF3r4nuRprUJmc4bopz8ut6w/nn7DdwsNNPrPX9URVD7DLE6S/FGruvP9CvpFwIZ+g98kskzs3XZ+sw83QY+7D2ZndVNX93UYhduZjAybWzkmDageIZm4IoZN9T+TKNfeEJ6KDaWkz/+hl96vtFaCSBWIreMiq2Dlv+YltPy1vtmGCpeTM+P38tKcwc7wPXwoMDSTFyVDSJJMopM1MQF58N0kttcJgaEqruYVNG9aduEeVBaVaQLWYHSEr+hlhV2D0gl84SrUdE2RaNeWH3rvjR+LKyDLrG43X5hFjDJX5vO6l2Qk7lQAIPtRX4ghY5K4BaqIdR7Ib2LngZg2UlynnHPhAI/xXw/FNvxpGtAp9bJJQT7SF/r9J/Rn8DSt+VKFxfjklGq6FW1CxBwMhgcj7bGF3EtYvCKXwTcA5MX+wPrEs3x5dQPRlxbuH7p2hjPTXcA4+4fSzEC18FDgfWzQY5rbee+15R6qly+lDzc/S0g2m2JCOX++CFBJw4JjiUlwh05i+9AzN0uLd1GAaPR23FnbTqoIIyqpJL+NQEub2xSpaAZfzuRf72pJTKm/HOIbmtUoTGNzcszClxWwVBOkO9RLHInNx0gV9yjasQo6Mh8CYuZ6UYzogVUoTJXfGqrg681mV3LYvOL8Bu2FN8fZU3ahAIzNCeRZoPSNSl9d+RV9avBjDToJ/QtMAOThFtB50G1oPwDtuio55WE6ZQQzHuJM+V3N4+6c=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6534.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?a8AqIw34BwtlhZOzFr3a9p320BqqH3FZAW7q7JxZt+KAsz6LBFo+nrV9LhH5?=
 =?us-ascii?Q?u6MwQfpa17x0v7SmDFCmuzKKRpGRxunA0vHJQ5DoiPP8xaf5qPQmplLjpEN5?=
 =?us-ascii?Q?9a3fmF9GYFCkSePWEOztovMvSf5f1jOZl2f9rvw+ma7MqH+kC4izKEjL4+Lc?=
 =?us-ascii?Q?JRzNblZmwv7IDDrZHWoX+mKyR0VAgmjeiWdSYKwtVMVt+4v6Zh2QBbf/xO1m?=
 =?us-ascii?Q?IVb2iSma3+zVaoIpYP4cLrler1SiN5235D2Dbejv9x54U4wayL8pE4/0Xjmb?=
 =?us-ascii?Q?K7TreSZH30TOmtGr4oHg9gnByuv9AHGzgFt62VwPrIWlWOzPKL0lv0Cvmrnh?=
 =?us-ascii?Q?MZ0AbCiNp18rA9H17Vz96CJ+sukOFT76AgMl7XPOsOFHoE/G9E4f5iIGdRKE?=
 =?us-ascii?Q?uvfd3/mDmjB2u1kjkcAO/OSHMR5nC3Tu0Lim3Uo8r5blumgZf7BPnEzhl5tn?=
 =?us-ascii?Q?OTfgtWJ3b3CYA4/6UCTzCtbRL6X8eMB+qrfCBk7bQ5hZDCL+FU3hJ5Ht+5DF?=
 =?us-ascii?Q?nYW65o7x/1zHIbyjVdfFxoY6Mycmpgt4g4WFYXSef1KSlY/nG2haAfB1esQ4?=
 =?us-ascii?Q?MGs+E7EM+1riPBC4vEv5PMFrXU3Le+LRRFBxlg7MfsJmqqaS7kJ5oN7ngrAX?=
 =?us-ascii?Q?ZnZnoCi1GjgH7viGyBorhOO884qbO83YCWWSX78IIEhPTL8GdAhzWHMzV0K6?=
 =?us-ascii?Q?eSpvVJK9UBs+IPQl3ToZ5hmRMRgscJIWkRxob37igoRLhqAxU0Om6x9pzn1j?=
 =?us-ascii?Q?lvSD3gyvGyn4LN1HKeZC/+HMSZ5pH4+/Wgtp13+GHaKiFLCCs3Kc1eUaY1HF?=
 =?us-ascii?Q?fssOYS+7kHN0m28BiabMgJ5oTP5ulqqcbpjRViUxkxvECC/UAMtDITDBBs91?=
 =?us-ascii?Q?qPu2+ASsmGWjxkyGR36TvED7cCbTCIVX/z47mNySTV8f2ZWqYXJbFKZRKi3M?=
 =?us-ascii?Q?Ks+Il6sjKv9Ka3LiY7UcT12GzdJrAbM8ZxxQvFIGJHqKBFJFY3BwyoZ1P7Fq?=
 =?us-ascii?Q?lLCVDKqMUaQCUB74JTQuKa+a9ZYRb6JcQpb5PezhkGoczFj2AiC8Y/CmQty5?=
 =?us-ascii?Q?f7vkfaDCHkrog2IuWQhxuoehuUj8nHXaPZ1l7DKbGZMJlN55G1ykugnDqXx6?=
 =?us-ascii?Q?lmPUzgAKhy5P8w5Khe4w9edrnaqpt+ahD04gchgt+JeyLF0CHLH+ssIM0psV?=
 =?us-ascii?Q?2WZ8CR5TSf2GfBKFRCv3lXRz1OjZxr4YVEET4ddwZU1zHqZWYDnyeLofUUTQ?=
 =?us-ascii?Q?c6HHaO89FWuDW4Zcq5JNxTcGbIZHLYcs04wlbhgRL+ijfqmz4K2IFdx6fdVH?=
 =?us-ascii?Q?ifebxn6477ZePyBIuAcDPOyi2XVEgye3pUBjgTZIhE/vrs9ulI1At3ftlA9w?=
 =?us-ascii?Q?1YSTNkqeQSfXJEwIQxbtOTo0i+hgpAiiVSRK7l5ig6Mh9a9TkDmUiallqvCH?=
 =?us-ascii?Q?a6L/firgHZv6Xf4j5i72bZ1a0/tLeyEchkaBB5XkUKhXVmvewZsg+c+hiEJS?=
 =?us-ascii?Q?Dzrag6zqM+kdsG3jB333yKiRxXFKuwC/r9wecN+1u8onhJILEDKrdZC0SoxQ?=
 =?us-ascii?Q?Ggo+M0tyODGtQ/QEzrI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c6c7e1d-d5d0-4319-2698-08dc4752fa93
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2024 13:54:49.6118 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uv1ZiRfBVSlDOF1gKaNIwmARZDfV66DkXDKCcU9a+0Rz+FFwZJRQnY4TGXGHTBf+kc+wDU9GKIhDRzP4A2QbHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9138
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

The patchset consists of the amd-staging-drm-next branch (Head commit - 0b2=
33252a7c1 drm/amd/display: 3.2.275) with new patches added on top of it.

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
Sent: Tuesday, March 12, 2024 5:20 AM
To: amd-gfx@lists.freedesktop.org
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.L=
i@amd.com>; Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; Pillai, Aurabindo=
 <Aurabindo.Pillai@amd.com>; Li, Roman <Roman.Li@amd.com>; Lin, Wayne <Wayn=
e.Lin@amd.com>; Gutierrez, Agustin <Agustin.Gutierrez@amd.com>; Chung, Chia=
Hsuan (Tom) <ChiaHsuan.Chung@amd.com>; Wu, Hersen <hersenxs.wu@amd.com>; Zu=
o, Jerry <Jerry.Zuo@amd.com>; Lin, Wayne <Wayne.Lin@amd.com>; Wheeler, Dani=
el <Daniel.Wheeler@amd.com>
Subject: [PATCH 00/43] DC Patches March 18, 2024

This DC patchset brings improvements in multiple areas. In summary, we high=
light:

- Clear mpc_tree in init_pipes
- Program pixclk according to dcn revision
- Add stream clock source to DP DTO params
- Enabling urgent latency adjustment for DCN35
- To adjust dprefclk by down spread percentage
- Add debug option for idle reg checks
- Revert few patches which cause regression
- skip forcing odm in minimal transition
- Fix noise issue on HDMI AV mute
- Enable fast update for DCN314
- Enable 2to1 ODM policy for DCN35
- Fix DCN31 underflow problem
- Add the MALL size in the fallback function
- Modify coding style/errors and remove redundant codes
- Add missing registers and offset
- Fix few problems for DCN35
- Fix a bug which dereferences freed memory
- Enable new interface design for alternate scrambling
- Enhance IPS handshake
- Increase Z8 watermark times
- Fix DML2 problem
- Revert patch which cause regression
- Fix problems for dmub idle power optimization

Cc: Daniel Wheeler <daniel.wheeler@amd.com>
---

Alex Hung (2):
  drm/amd/display: Delete duplicated function prototypes
  drm/amd/display: Correct indentations and spaces

Anthony Koo (1):
  drm/amd/display: [FW Promotion] Release 0.0.208.0

Aric Cyr (2):
  drm/amd/display: 3.2.276
  drm/amd/display: 3.2.277

Chaitanya Dhere (1):
  drm/amd/display: Add TB_BORROWED_MAX definition

Charlene Liu (2):
  drm/amd/display: fix debug key not working on dml2
  drm/amd/display: change aux_init to apu version

Chris Park (1):
  drm/amd/display: Prevent crash on bring-up

Dillon Varone (3):
  drm/amd/display: add stream clock source to DP DTO params
  drm/amd/display: Program pixclk according to dcn revision
  drm/amd/display: Power on VPG memory unconditionally if off

Gabe Teeger (1):
  drm/amd/display: Revert Add left edge pixel + ODM pipe split

Leo Ma (1):
  drm/amd/display: Fix noise issue on HDMI AV mute

Martin Leung (1):
  drm/amd/display: revert Exit idle optimizations before HDCP execution

Natanel Roizenman (2):
  drm/amd/display: Added debug prints for zstate_support and
    StutterPeriod
  drm/amd/display: Increase Z8 watermark times.

Nicholas Kazlauskas (6):
  drm/amd/display: Add debug option for idle reg checks
  drm/amd/display: Workaround register access in idle race with cursor
  drm/amd/display: Detect and disallow idle reallow during reentrancy
  drm/amd/display: Add optional optimization for IPS handshake
  drm/amd/display: Enable optimized handshake for DCN35
  drm/amd/display: Enable reallow for idle on DCN35

Nicholas Susanto (1):
  drm/amd/display: Enabling urgent latency adjustment for DCN35

Ovidiu Bunea (1):
  drm/amd/display: Revert "Set the power_down_on_boot function pointer
    to null"

Rodrigo Siqueira (9):
  drm/amd/display: Remove code duplication
  drm/amd/display: Remove wrong signal from vrr calculation
  drm/amd/display: Enable 2to1 ODM policy for DCN35
  drm/amd/display: Add the MALL size in the fallback function
  drm/amd/display: Move define to the proper header
  drm/amd/display: Enable fast update for DCN314
  drm/amd/display: Remove legacy code
  drm/amd/display: Comments adjustments
  drm/amd/display: Add missing registers and offset

Samson Tam (1):
  drm/amd/display: clear mpc_tree in init_pipes

Sherry Wang (1):
  drm/amd/display: correct hostvm flag

Sung Joon Kim (1):
  drm/amd/display: Enable new interface design for alternate scrambling

Wenjing Liu (3):
  drm/amd/display: skip forcing odm in minimal transition
  drm/amd/display: Revert Remove pixle rate limit for subvp
  drm/amd/display: fix a bug to dereference already freed old current
    state memory

Xi Liu (2):
  drm/amd/display: increase bb clock for DCN351
  drm/amd/display: Remove unnecessary hard coded DPM states

Zhongwei (1):
  drm/amd/display: To adjust dprefclk by down spread percentage

 .../gpu/drm/amd/display/dc/bios/bios_parser.c |   1 +
 .../gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c  |  15 ++-
 .../display/dc/clk_mgr/dcn314/dcn314_smu.h    |  42 +++----
 .../dc/clk_mgr/dcn32/dcn32_clk_mgr_smu_msg.h  |   3 +-
 .../display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c  |  50 ++++++++
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 118 +++++++++++-------
 .../gpu/drm/amd/display/dc/core/dc_resource.c |  40 +-----
 drivers/gpu/drm/amd/display/dc/core/dc_stat.c |   2 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |   5 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |  44 +++++--
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h  |   1 +
 .../display/dc/dcn31/dcn31_dio_link_encoder.c |   2 +-
 .../display/dc/dcn31/dcn31_dio_link_encoder.h |   2 +
 .../gpu/drm/amd/display/dc/dcn31/dcn31_vpg.c  |   7 +-
 .../display/dc/dcn35/dcn35_dio_link_encoder.c |   2 +-
 .../drm/amd/display/dc/dml/dcn31/dcn31_fpu.h  |   1 +
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  |   1 +
 .../drm/amd/display/dc/dml/dcn35/dcn35_fpu.c  |  12 +-
 .../amd/display/dc/dml/dcn351/dcn351_fpu.c    |  94 +++++++++++---
 .../amd/display/dc/dml2/display_mode_core.c   |   2 +
 .../display/dc/dml2/dml2_translation_helper.c |  17 ++-
 .../gpu/drm/amd/display/dc/dml2/dml2_utils.c  |   6 +
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c |   3 +-
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   |  16 +++
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   |  10 --
 .../amd/display/dc/hwss/dcn30/dcn30_hwseq.c   |  12 +-
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   |  16 +++
 .../amd/display/dc/hwss/dcn35/dcn35_init.c    |   2 +-
 .../gpu/drm/amd/display/dc/inc/core_types.h   |   2 -
 drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h  |   1 +
 drivers/gpu/drm/amd/display/dc/inc/resource.h |   4 -
 .../gpu/drm/amd/display/dc/link/link_dpms.c   |   3 +
 .../dc/link/protocols/link_dp_training.c      |  16 +--
 .../link/protocols/link_edp_panel_control.c   |  64 ++++++++++
 .../link/protocols/link_edp_panel_control.h   |   2 +
 .../dc/resource/dcn20/dcn20_resource.c        |   7 +-
 .../dc/resource/dcn31/dcn31_resource.c        |   5 +-
 .../dc/resource/dcn314/dcn314_resource.c      |  21 +---
 .../dc/resource/dcn316/dcn316_resource.c      |   1 -
 .../dc/resource/dcn32/dcn32_resource.c        |   3 +-
 .../dc/resource/dcn321/dcn321_resource.c      |   4 +-
 .../dc/resource/dcn35/dcn35_resource.c        |   5 +-
 .../dc/resource/dcn351/dcn351_resource.c      |   3 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  73 ++++++++++-
 .../amd/display/modules/freesync/freesync.c   |   2 +-
 .../gpu/drm/amd/display/modules/hdcp/hdcp.c   |  10 --
 .../drm/amd/display/modules/inc/mod_hdcp.h    |   8 --
 .../display/modules/info_packet/info_packet.c |   2 -
 .../include/asic_reg/dcn/dcn_3_2_1_offset.h   |  37 +++++-
 .../include/asic_reg/dcn/dcn_3_2_1_sh_mask.h  |  16 +++
 50 files changed, 581 insertions(+), 234 deletions(-)

--
2.37.3

