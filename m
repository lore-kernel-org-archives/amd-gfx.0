Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12408C46CA1
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Sep 2023 13:40:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A13D510E066;
	Mon, 18 Sep 2023 13:40:03 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2066.outbound.protection.outlook.com [40.107.92.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 993AD10E066
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Sep 2023 13:40:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nvW42Wql9fSrtrX6R0jmdgJdKLPXlmcpt2rsLEdF7pfXQWcA5rtS2bV5b1XKw/k+kR9kIe7FeOgRT5NW3vUHjdMZzcHERN7VCrDMPuH9lT/YMg7aJqLXaZkHxa4GJkv9cxy6V/Oqnc/5G4pzzg6dzG8UoegMT4WuiIV+Bhp3zNVi1xawGElRDbx3sA8LpPH9fvqaDIXnC1OIjB1HWcORAUzuuErEYU7N2wsXfrFMAoLCDbVf96kdZR+OpAV5vFg0RsSEiD/yVjKPvZiLyRZqdv1tNPaVgE92Xa2N4QUzlrVTU5jgoxHWfjyrHg3A2od9GR63f/VVGr7LB1btNCdgPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sDlPbOI0bSEbmKTTf2QW9l4ehG2JcE70kURyUkMjMzM=;
 b=NtQTY3mTyE60a4rq3XloOFWxG4QX8TbGiRkxs2PpXExGVPfddF7esS1+/vsjkyAZF3STOizxpNMEjs1+bCStWI3Q5baCzeDXWPCIQhbQLYA+8bBdQ0EBKpo9ln4xA0YamHbud6ikAZs3cs8BNJ1VLELiU4KgSVk1tbBFzE5XefhycWpqPULR7KreN3A52pQ5nY2QsVLNaBqF1ieWCYxth8n6OT15tBBmh/QpbjERm97p0JDAoJkrOHFI/BbWpZw5NLCrJXnn7uFs4LRIBPsuEsqG8Hif7vZunRGvebGdrWo0dcckdCKwMIh+Xe2kbDW5bYVx6RbVgXiEfWYM0lHSrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sDlPbOI0bSEbmKTTf2QW9l4ehG2JcE70kURyUkMjMzM=;
 b=ew2cij8dC9TciFkGwNvzvZ8qGBoJxCkzIFWS0HQFW74Z+RlrSf696b38bPufRblrMHNYa3eNuTv1Fr/Hg01poQOaG/IBeqawS2SBICa8p742UzcB7tPMNBCVkYjr0EEmaE+4A+m8RuJFRFUZOpHHsy46BH4XU9iwvNPjPLC/F30=
Received: from DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) by
 BN9PR12MB5323.namprd12.prod.outlook.com (2603:10b6:408:104::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Mon, 18 Sep
 2023 13:39:59 +0000
Received: from DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::13e9:ae15:edf6:e173]) by DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::13e9:ae15:edf6:e173%5]) with mapi id 15.20.6792.026; Mon, 18 Sep 2023
 13:39:58 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 00/28] DC Patches September 13, 2020
Thread-Topic: [PATCH 00/28] DC Patches September 13, 2020
Thread-Index: AQHZ5q9Y+OgR/GfpzUiy7jfcOmXlDLAgnQsg
Date: Mon, 18 Sep 2023 13:39:58 +0000
Message-ID: <DS0PR12MB6534B45087EFC05377CE6AD09CFBA@DS0PR12MB6534.namprd12.prod.outlook.com>
References: <20230914020021.2890026-1-Rodrigo.Siqueira@amd.com>
In-Reply-To: <20230914020021.2890026-1-Rodrigo.Siqueira@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=47dd56c2-b849-4135-8954-bf7fe4a6ed8f;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-09-18T13:39:52Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6534:EE_|BN9PR12MB5323:EE_
x-ms-office365-filtering-correlation-id: 93b9117c-9024-42b2-8c6f-08dbb84cc044
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KjqFCfrYMd8Bl3BijYXQpZAr7fKQQmN7svdGfJD5bIOGe6HJgUePDIZ+2LOCJmT+gFN1ljR4nqlyzEX99aSB3sSt8tVkrHqYf4XtymzJi085Bablu/2cKt289+P+igkIjlHcTkc3N8PXrw2UYO2/gCAlf+003yUYdkNZb3WoRedTVvy1ugaaMXr+36z9YafJI1yrMmsxwOQA9ko0b12v17/66bn3qfSjMVp8/OPvgq6Gl+3ev5UnrdWDmrGpEBmyuB5HYw/k0NsEqNdaDQqpbysR+jhLN9MlnwzI3VPGwWOizGujs17IDOXz4KHLZ17BSWvfKK3m0kLxAuVseiT6GXl8dR/Cnjy57P8eom1G+EJAOXthvBe/taDyzP9VtLLG/YizWxPjECx0tSfvc4uFEOMUPQ7Z4I2MYOdIOI27I7MmBsQuBHfCp6Ko/L5B+CgAdMG8YvHKdgWJYkLmNYAW3L0TNThoNIwIasuds0A3m8zZS460ztDD1VradWDrBdMVdwY4U6E1vfFmsZowJlJeoLcfLJEyLsZdG3UzKyIINTKTqjqKCqD+DRMwBdnaKoDOUXkErKTvPd214mwHsIwYLWgCnNwddutqIi25y7AvYto=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6534.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(376002)(396003)(346002)(39860400002)(366004)(1800799009)(186009)(451199024)(2906002)(52536014)(5660300002)(8676002)(41300700001)(4326008)(8936002)(316002)(110136005)(54906003)(66476007)(66556008)(66446008)(66946007)(76116006)(64756008)(478600001)(7696005)(71200400001)(6506007)(53546011)(26005)(9686003)(55016003)(83380400001)(33656002)(38070700005)(38100700002)(122000001)(86362001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Y5R6onSjV5ii2CbMCFQheHmfcjHZQiEz2S0ceJrbdz1k8O2coMfLzXNO7SJt?=
 =?us-ascii?Q?Jao6JzouCVXOvuV5xmmj05GCQ7VieosybRMKvE+WhjSgNGWaoO4gK68mWi9M?=
 =?us-ascii?Q?0irLCMVjQMhVzD2IahhJdUFWLhLlkgcAreQsqaxXQ6PMWk54qE2oiBtvUkKs?=
 =?us-ascii?Q?klRZ+YvdcYowV/UdtqmXwjIUeLbDzeLor4eBwUVT+uypUZGNtuET+7rYqK5n?=
 =?us-ascii?Q?3PROOie47hpEeP8c4+TYY/BeVc/8fQjGi3Z7E/d1tnaTve4I8ROskUA7MsfE?=
 =?us-ascii?Q?FFTWvUczMJRq2FGYM4bKsxaComnHCYlPEC6NCFsQNlh74ymw/3ttxnyAz7qL?=
 =?us-ascii?Q?BWKAgjZmn5kde3DH+EgVpXZktQddzGSV2bHI6zpXPH0M51R3ahBhl2+yjx7R?=
 =?us-ascii?Q?YI00Z1VRizY+Ak9PrjuDmxLl/H+ui6m8vcsbvDbw5H3ThdJriT2h0FinfA20?=
 =?us-ascii?Q?jlyZtTNtNCepvDZU+3YEoiiMpGjOTnx91fSBqZgx19j5QDRNBmfr0jh+3cQh?=
 =?us-ascii?Q?qZSe045oWgQisyhO+tLBQJI7I8AG2+wHc9QlszriOYRR1T4/XugzYLWK/jEf?=
 =?us-ascii?Q?a2yXMYfI89WUHeUgzSrMT3eJQrr14i5ifbC/4dN/cBJz91KTrV69YgFbBnb/?=
 =?us-ascii?Q?r0710cVzvU5dpX2bgvfYn4Khacu2OG/lY/a49qpam8BnhVNxFS6ZI+oKimvG?=
 =?us-ascii?Q?bSTvqPFOIWMORPcJW8XUc8X8pST1KQkwiMK2/2SwwokgUv54dBnfLrKbJ79F?=
 =?us-ascii?Q?L2qGRJ5rZqygXziEPZZ+NP6hJUn5OIv4JwLJxN481dCHd0FAu9oaoSncmZKg?=
 =?us-ascii?Q?fzuXb8JxIX5+8TQE7GKOsmVP5RNUXQVhOXg5ddQ/tuVF07yBLIdp8ztCqEFi?=
 =?us-ascii?Q?UmpadEVKAJpKF1j/ZluWCQBOvVPZKEfN+g43pJyjZIkkajUZAwfm3U9b3W5H?=
 =?us-ascii?Q?Yv7565NYNa5eTgvGt2a2kWp1oB+Rvgq1bdhWVcUkE/9I5xm8FfsHZlBr7ysZ?=
 =?us-ascii?Q?0B/aupzQ8tgwfjEm47sl1rVlo+ioxG7s+UzaWQp5Uy94FfxrQSeixLDMyrWd?=
 =?us-ascii?Q?+uy6XDXBMN+6jTOXpGmbdihytE0r4NLZXHGRFlEz6tZTR9g5rAast4JqLT6I?=
 =?us-ascii?Q?DHiGyqgISqpaeJD2Xv7S2STM8G/CoqkrfJiPnJcCyk+IJnW9oSp3aWkiVguq?=
 =?us-ascii?Q?yR2QwnFTkAeiolKyxH6bvWbOQX1ye7Z+sdZjH4yiXQP1b0tip7eR/vvnv0En?=
 =?us-ascii?Q?4eYoGdKL08fe7bCGN68hUJnUeNAMd6YPm83bsDgC3BU/e6m5dNjWHXXerbI4?=
 =?us-ascii?Q?gPgfG1aFPp6rEa+myTOWgZ37bMiSSTyKyMzA9Dqxh3E1SvuBPlVuxgk3l5+4?=
 =?us-ascii?Q?ZoP8/cVqTDYBmiDkBv+9SIT79h4Cp/v276VpOhCJi/e4mAIBkKIgrNGS8f1d?=
 =?us-ascii?Q?6u/Obf0QRkB+i+/UONiayKBiVMGLmARggU6FFP1aGsiiuw6h/VyqRIs1SdS0?=
 =?us-ascii?Q?5bzK7n24iN4NHe3k+XTmuGEHrqhlqMAI4yhlUoIW64HlKyzHPoh6M4Z2HG6d?=
 =?us-ascii?Q?aFAnlhWnQpq8qHF2cb4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93b9117c-9024-42b2-8c6f-08dbb84cc044
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2023 13:39:58.5273 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ixTmR4XWZ65TNhggbWdz9l650YEOjBld4uwu4Q5t7oki/E13k6XzmiYT0JsVTMCcXr0nzelUldy0vN0MYLMyNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5323
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
Cc: "Wang, Chao-kai \(Stylon\)" <Stylon.Wang@amd.com>, "Li,
 Sun peng \(Leo\)" <Sunpeng.Li@amd.com>, "Wentland,
 Harry" <Harry.Wentland@amd.com>, "Zhuo,
 Qingqing \(Lillian\)" <Qingqing.Zhuo@amd.com>, "Li, Roman" <Roman.Li@amd.com>,
 "Chiu, 
 Solomon" <Solomon.Chiu@amd.com>, "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>,
 "Lin, Wayne" <Wayne.Lin@amd.com>, "Lakha,
 Bhawanpreet" <Bhawanpreet.Lakha@amd.com>, "Gutierrez,
 Agustin" <Agustin.Gutierrez@amd.com>, "Kotarac, Pavle" <Pavle.Kotarac@amd.com>
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

The patchset consists of the amd-staging-drm-next branch (Head commit - b5c=
e5056952786df17c852f154c92085ebac76d8 drm/amd/display: add skip_implict_edp=
_power_control flag for dcn32) with new patches added on top of it.

Tested on Ubuntu 22.04.3, on Wayland and X11, using Gnome for both.

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
Sent: Wednesday, September 13, 2023 10:00 PM
To: amd-gfx@lists.freedesktop.org
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.L=
i@amd.com>; Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>; Siqueira, Rodri=
go <Rodrigo.Siqueira@amd.com>; Pillai, Aurabindo <Aurabindo.Pillai@amd.com>=
; Zhuo, Qingqing (Lillian) <Qingqing.Zhuo@amd.com>; Li, Roman <Roman.Li@amd=
.com>; Lin, Wayne <Wayne.Lin@amd.com>; Wang, Chao-kai (Stylon) <Stylon.Wang=
@amd.com>; Chiu, Solomon <Solomon.Chiu@amd.com>; Kotarac, Pavle <Pavle.Kota=
rac@amd.com>; Gutierrez, Agustin <Agustin.Gutierrez@amd.com>; Wheeler, Dani=
el <Daniel.Wheeler@amd.com>
Subject: [PATCH 00/28] DC Patches September 13, 2020

This DC patchset brings improvements in multiple areas. In summary, we
highlight:

- Use optc32 instead of optc30 in DC
- Optimize OLED T7 delay
- Multiple fixes for MST, register mas, and others
- Update driver and IPS interop
- Improve z8 watermark mask
- DCN35 updates
- Enable replay for DCN35
- Temporarily disable clock gating

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Thanks
Siqueira

Agustin Gutierrez (1):
  drm/amd/display: Optimize OLED T7 delay

Anthony Koo (1):
  drm/amd/display: [FW Promotion] Release 0.0.183.0

Aric Cyr (2):
  drm/amd/display: 3.2.251
  drm/amd/display: 3.2.252

Artem Grishin (1):
  drm/amd/display: STREAM_MAPPER_CONTROL register offset on DCN35

Charlene Liu (4):
  drm/amd/display: Temporarily disable clock gating
  drm/amd/display: Add z8_marks related in dml for DCN35
  drm/amd/display: Correct z8 watermark mask
  drm/amd/display: fix some non-initialized register mask and setting

Duncan Ma (2):
  drm/amd/display: Fix dig register undefined
  drm/amd/display: Update driver and IPS interop

Gabe Teeger (1):
  drm/amd/display: Add option to flip ODM optimization

Muhammad Ahmed (6):
  drm/amd/display: disable clock gating logic
  drm/amd/display: Enable DCLK_DS from driver by default
  drm/amd/display: disable IPS
  drm/amd/display: Fix MST recognizes connected displays as one
  drm/amd/display: Expand DML to better support replay
  drm/amd/display: Enable DCN low mem power by default

Mustapha Ghaddar (1):
  drm/amd/display: Add DPIA Link Encoder Assignment Fix for DCN35

Ovidiu Bunea (1):
  drm/amd/display: Use optc32 instead of optc30 in DC

Qingqing Zhuo (1):
  drm/amd/display: Add DCN35 case for dc_clk_mgr_create

Rodrigo Siqueira (1):
  drm/amd/display: Drop unused code

Roman Li (1):
  drm/amd/display: Enable replay for dcn35

Sung Joon Kim (2):
  drm/amd/display: Add pointer check before function call
  drm/amd/display: Add IPS control flag

Sung-huai Wang (1):
  drm/amd/display: fix static screen detection setting for DCN35

Taimur Hassan (1):
  drm/amd/display: Add reset for SYMCLKC_FE_SRC_SEL

Wenjing Liu (1):
  drm/amd/display: Update pipe resource interfaces for DCN35

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   1 +
 .../drm/amd/display/dc/bios/bios_parser2.c    |   9 --
 .../gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c  |  13 ++  .../display/dc/clk=
_mgr/dcn35/dcn35_clk_mgr.c  |  24 ++-  .../amd/display/dc/clk_mgr/dcn35/dcn=
35_smu.c  |  16 +-
 .../amd/display/dc/clk_mgr/dcn35/dcn35_smu.h  |   1 +
 drivers/gpu/drm/amd/display/dc/dc.h           |   3 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |   4 +
 .../display/dc/dce110/dce110_hw_sequencer.c   |   3 +-
 .../drm/amd/display/dc/dcn10/dcn10_hubbub.h   |   8 +-
 .../gpu/drm/amd/display/dc/dcn30/dcn30_optc.c |   2 +-
 .../gpu/drm/amd/display/dc/dcn32/dcn32_optc.c |   2 +-
 .../gpu/drm/amd/display/dc/dcn32/dcn32_optc.h |   2 +
 .../gpu/drm/amd/display/dc/dcn35/dcn35_dccg.c | 114 +++++++++----
 .../drm/amd/display/dc/dcn35/dcn35_hubbub.c   |  62 +++++--
 .../drm/amd/display/dc/dcn35/dcn35_hubbub.h   |   9 +-
 .../gpu/drm/amd/display/dc/dcn35/dcn35_hubp.h |   4 +-
 .../drm/amd/display/dc/dcn35/dcn35_hwseq.c    |   2 +
 .../gpu/drm/amd/display/dc/dcn35/dcn35_init.c |   2 +-
 .../gpu/drm/amd/display/dc/dcn35/dcn35_optc.c |   2 +-
 .../gpu/drm/amd/display/dc/dcn35/dcn35_optc.h | 151 +-----------------  ..=
./drm/amd/display/dc/dcn35/dcn35_pg_cntl.c  |  53 +++---  .../drm/amd/displ=
ay/dc/dcn35/dcn35_resource.c |  50 +++++-
 .../drm/amd/display/dc/dcn35/dcn35_resource.h |   3 +-
 .../drm/amd/display/dc/dml/dcn35/dcn35_fpu.c  |  47 ++++++
 .../gpu/drm/amd/display/dc/inc/hw/clk_mgr.h   |   1 +
 drivers/gpu/drm/amd/display/dc/link/Makefile  |   4 +-
 .../display/dc/link/accessories/link_fpga.c   |  95 -----------
 .../display/dc/link/accessories/link_fpga.h   |  30 ----
 .../gpu/drm/amd/display/dc/link/link_dpms.c   |   1 -
 .../drm/amd/display/dc/link/link_factory.c    |   1 -
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  31 ++++
 32 files changed, 359 insertions(+), 391 deletions(-)  delete mode 100644 =
drivers/gpu/drm/amd/display/dc/link/accessories/link_fpga.c
 delete mode 100644 drivers/gpu/drm/amd/display/dc/link/accessories/link_fp=
ga.h

--
2.40.1

