Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57541C54E4A
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Mar 2024 18:14:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C4FBF10E715;
	Thu,  7 Mar 2024 18:14:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bd0B2/oP";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD49D10E715
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Mar 2024 18:14:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FlwJfDPfUM4iZYNnRCjpGkwSUtKEyUJgGmNRmcjJUMIRwLqNCgqEPHrSKIz+b542m9bosIWpGlVf3JoaDeO8WFYYUlB3bF2jIAgK/UPLB1sXf6v0Rqfs/pImBpLVzlcGSub8vDxBGSoeWq9hIo6bRNyQSG3yQKrAxnYN9P3JrZi8m194ZysflkhBKW+HERQOcl4ZwvqqUcXgTv8UQrSMC4sYJ+KVTDez2gMUO7tj8E1cpqWpboDd9Ms8euLnsyajoKJZwmWvUJZ9F80V4CeBvb4a1sDv1MRjZRLqZp0xnOJZvxTbk/tN05FngnhciswS2Uj2qsz92qn0227J8Rq8Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OTXOupwgBTK6652sS0H1eYRSIK15wOnClWixtb7DHUw=;
 b=X1K+4Xk+HjQjMFalwJsDB9t39EdjYMZvuEWLmN3aXKFkl/9MIhIqcREdVYU1xt8jDGvQzDPq3W6KD/paH02uC+Di3ZHycxEqefBTQmXiq/N7NQjpEHPFNd8CkYuVjZSjfirEpX7iSukBNBOZWq40uP9CMXEG90fJyIPphiUUHxEfy/zIos/yrCISyTGWObldpGBreWfCC9gEXfDcILD7Vwg37QX2NtElbM2s4odhZQjqYuvuOXbkDn92mpdQ4ib8WUmv0E3JFmotuwdwKtvkDFON0IOpqxUPL8w8Ddl4CJ2Mo6Fciq8OkcwRuNYKYgTE4GpZbNcyA5XExQlh2BAmOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OTXOupwgBTK6652sS0H1eYRSIK15wOnClWixtb7DHUw=;
 b=bd0B2/oPwrTTWLOuHIMxARtXkLzY+s07wwg+jKX3pqz5hcZo/7KVGcF8j7u3uW/d9JJ+CgLkokkl+3+6jX/N9kmEIU3I0fwTK9fjoMfl6OCXQPWmZt2HNV19SPUWxeSSZxpT13P7pKQCBFmlgaNHbBVuom45Yq1qGW/n2yuKPxU=
Received: from DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) by
 DM4PR12MB8451.namprd12.prod.outlook.com (2603:10b6:8:182::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7339.42; Thu, 7 Mar 2024 18:14:44 +0000
Received: from DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::6503:7457:78d3:b2f4]) by DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::6503:7457:78d3:b2f4%5]) with mapi id 15.20.7339.035; Thu, 7 Mar 2024
 18:14:44 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Hung, Alex" <Alex.Hung@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
CC: "Wentland, Harry" <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)"
 <Sunpeng.Li@amd.com>, "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
 "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>, "Li, Roman"
 <Roman.Li@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>, "Gutierrez, Agustin"
 <Agustin.Gutierrez@amd.com>, "Chung, ChiaHsuan (Tom)"
 <ChiaHsuan.Chung@amd.com>, "Wu, Hersen" <hersenxs.wu@amd.com>, "Zuo, Jerry"
 <Jerry.Zuo@amd.com>
Subject: RE: [PATCH 00/34] DC Patches Feb 28, 2020
Thread-Topic: [PATCH 00/34] DC Patches Feb 28, 2020
Thread-Index: AQHaanWmO6lVJm1CVUm6mJbPprXH+7Esnqug
Date: Thu, 7 Mar 2024 18:14:44 +0000
Message-ID: <DS0PR12MB6534851F93A0C393A701E5C69C202@DS0PR12MB6534.namprd12.prod.outlook.com>
References: <20240228183940.1883742-1-alex.hung@amd.com>
In-Reply-To: <20240228183940.1883742-1-alex.hung@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=221009cd-f584-47e7-9af3-5558d7043563;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2024-03-07T18:04:03Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6534:EE_|DM4PR12MB8451:EE_
x-ms-office365-filtering-correlation-id: f27c8ab5-b4c5-4f72-e5e8-08dc3ed27756
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ymGDfmSVptQxREnmVceJQnn/JK6Y33BxGQBCDlIuclrxT39tYIrO6P7qk9QktJEgggVi/3DnRGo4Jynj2+XlOJLuPtkhwnvtdaRlRn3paLq8lllB7pR2hroWvYWQEgryl2Xu441AOL8SRykpstKsc0p9/YGhHJmJAdwb2aiC0k+sf8d1E9UzslewthkcdRGOkSOsblWpDQ7ISopIE+ScUIj8WIRLeapaf5F5h7fYoYZn7yZi0WB9LCCKlugTW/HkhqVejcurcaNPwIuDEpq2zLUdwYx0nsGI6WR/zzPopxU7uAkjYkPJwOLkgs4KjcoKIcbL2UACvaVAUdJeoOo8ngTTPR7QPY8n15rigDMv75aFZRb3luYTQ24uHpQl95jsz/Ut3xBfQApVEjjAjz6yyVaHhx6iCQlhQTRSzWArKoU5azeSmHViRRZWSOeJsRHEjLotyZ69SL5N+T/KO1N8u7RyAvFCfri+vPtvhOzSz0u1wLKm0sAx4Yym1GzP7g6ZojcZOqMmmfRmtrSXOKcJaTjI84LzPERDtzqYFEUIhJJ5lqiaLjaOZQ57z9svsk4NexV+iRrpbZWZ7h4a2UiNjDatf0rnelM5cPyQ3gwBHDH8gLqJ03Btk9hTMEuRvfdrOi3ZvpMq6DBwkTvNSLjeQ8e+QeGUGRkpexQlOdfaLQNchGgXy8Qu4MK9J+GFPMp4QkrtwzrCPeIexDGmvhMK0A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6534.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?HYryYX/zsJYi4uYm2g8GvpK/v0x0lSDaKiDNAW8aplRNP4oNcq0roc1b9Vf2?=
 =?us-ascii?Q?0Cnk3jWxEXmKA/QQIPQsdxUP6V1r6udLGu/65N8jZnL549sX7a/x3Bv0ovvk?=
 =?us-ascii?Q?Gzi8CEVBfZNt9mJZmii0+4tqZ04idGh0BW1SZgaDUeMAzPLv73AACVY16q3t?=
 =?us-ascii?Q?NzMoAN/RVMPCS12lMJggVqW8crFLLSABbyr6Cnz7XujynItuLPOJYvkWfbwb?=
 =?us-ascii?Q?lPIk35qA3MTy+xxcax4XPslvpMZw59mvgkGXWIjQ6K+3HU9eOc87PFDXugAG?=
 =?us-ascii?Q?FWic+4NRhcmlCyHVaQkI0nQU5gcJORBGgXhj5io3k8OGHQ9F4dnWXYkSPgHF?=
 =?us-ascii?Q?WBu3IDOfjBTnPr+PJsuO067oDZhlJhUXlBX/Su6iG+MWN19fMdV/CuOftaon?=
 =?us-ascii?Q?MFBUW6LKUTvZYATrT6WoXVA3Z2n+7tRLXcvcIOjDmuvDtLVbEHQcOaOCTyA+?=
 =?us-ascii?Q?tNLXY66L7q48RHp5qZ4yOPSGhHgzV92aW6PnpKW6FMyFtoNuKa6jmUNNqn/C?=
 =?us-ascii?Q?1Sx4lQIZCMan+HR4oRwtJJawjCl2EKC72cUnjVfLbgj//A5CPAFD6rXel6Pj?=
 =?us-ascii?Q?jogyGqBYWj0mhk8xTvXY4GlQHNigd6/iq0BEDsP88QdgnALUS9YzrSspxdbB?=
 =?us-ascii?Q?bQnHqfOChpMzqoB+TuvbdTaFt5rGLIC/O7OE/ZK5qz189p7SHIsiPLroTkc9?=
 =?us-ascii?Q?NcH56tnxeCvnGjdt1zLMyxMFjjJyf3sYX9yTMnY7mwbGO5dvgIR2Nyn3CQ7l?=
 =?us-ascii?Q?3OU9ndQ9MuhS+Cl0ERvgI+4H2G6UVc8pkLWajyZDjMEbMuGStcbXdqqY4ZDN?=
 =?us-ascii?Q?qmtemqGl/2SagNuTFhLdsB6881IYY60BoxyXlYTNzLDlOPViU91hxQql7ra/?=
 =?us-ascii?Q?uLp4ZUMK+DKci8NreCSsWs4bw+1KdJR4E82QK5N1ALS7e5+5xrMTQhM7/YHG?=
 =?us-ascii?Q?53LwV/6gAEQL/zRYm4njUlyVSNdWlLD+9ejCj82TJa/LOvhfs+T+E+qROCzW?=
 =?us-ascii?Q?HpD5tskuNuxYe85HcP0TOVnl9RH2LfiF4M3bEy8wFe+yYDvU63HbZn58bNuA?=
 =?us-ascii?Q?6AFo4Ku8skiB/OBY7LLv15H4mwB4WIRp73i9toGqCvJrhnTLSUfLUCnk+kuI?=
 =?us-ascii?Q?opApsLFURipav1tTp3JMf93zqV35ZKvwgLOsfpwlqRxWsXR9b8ohX+L0pvE4?=
 =?us-ascii?Q?xf6kzqi8zv7Qqmxi3lAXTDzHV4r6c1NowfJQNZJlAavDOH/Mcp8xT2ORgIOk?=
 =?us-ascii?Q?mA7b0TUFmYaixj68wGJ1H4jAdXZhTRr5NDhvpYpnjJ4l1YSkzR+5m5ScZ1pz?=
 =?us-ascii?Q?HKw1f2BUL+pCdTzeXUPt1yzBz6LsLJwMp7RVJae6AyOXVgPFWq6y+RRa8Nul?=
 =?us-ascii?Q?UDVBwcAxi+v075CHiyqo6D9WKmAQWob9A6M2X9QdpiduSt9CJFnF2dHnxVXy?=
 =?us-ascii?Q?zjGRVtUqD8UxwMH/zW3y3h8oNY7ncqVahU5q6xE36OSPxeKimbjvwuoYS6+o?=
 =?us-ascii?Q?RtPjK3HOf4owng2QVFuW363G/CI4QNMQ2orr9iEvgaWzs8B8GjNAEbJEn2vQ?=
 =?us-ascii?Q?aWwbatO+0+A4MNWbuws=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f27c8ab5-b4c5-4f72-e5e8-08dc3ed27756
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2024 18:14:44.5766 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A0etDPDXLtg2puyjfDPBR5YYoHyRnwKb5aOednvyzFMuvPBuMWh+T2Bd8lQEpqs2flvy0JrK4GksRI8A5c78RQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8451
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

The patchset consists of the amd-staging-drm-next branch (Head commit - 031=
2d86bf720 drm/amd/pm: Increase SMUv13.0.6 mode-2 reset time) with new patch=
es added on top of it.

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
From: Hung, Alex <Alex.Hung@amd.com>
Sent: Wednesday, February 28, 2024 1:39 PM
To: amd-gfx@lists.freedesktop.org
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.L=
i@amd.com>; Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; Pillai, Aurabindo=
 <Aurabindo.Pillai@amd.com>; Li, Roman <Roman.Li@amd.com>; Lin, Wayne <Wayn=
e.Lin@amd.com>; Gutierrez, Agustin <Agustin.Gutierrez@amd.com>; Chung, Chia=
Hsuan (Tom) <ChiaHsuan.Chung@amd.com>; Wu, Hersen <hersenxs.wu@amd.com>; Zu=
o, Jerry <Jerry.Zuo@amd.com>; Hung, Alex <Alex.Hung@amd.com>; Wheeler, Dani=
el <Daniel.Wheeler@amd.com>
Subject: [PATCH 00/34] DC Patches Feb 28, 2020

This DC patchset brings improvements in multiple areas. In summary, we high=
light:

* Fixes on HDCP, eDP and FW idle check.
* Enhancement in debug messages
* Improvement on updates sequences
* DPP refactoring to a new directory
* Enhancements in DMUB

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Allen Pan (1):
  drm/amd/display: Add a dc_state NULL check in dc_state_release

Alvin Lee (1):
  drm/amd/display: Backup and restore only on full updates

Anthony Koo (2):
  drm/amd/display: Add entry and exit counters
  drm/amd/display: Update DMUB flags and definitions

Aric Cyr (2):
  drm/amd/display: 3.2.274
  drm/amd/display: 3.2.275

Aurabindo Pillai (3):
  drm/amd/display: Enable DML2 debug flags
  drm/amd/display: Add some forward declarations
  drm/amd/display: Add DML2 folder to include path

ChunTao Tso (1):
  drm/amd/display: Amend coasting vtotal for replay low hz

Dillon Varone (1):
  drm/amd/display: Init DPPCLK from SMU on dcn32

George Shen (1):
  drm/amd/display: Add left edge pixel for YCbCr422/420 + ODM pipe split

Josip Pavic (1):
  drm/amd/display: Allow dirty rects to be sent to dmub when abm is
    active

Muhammad Ahmed (2):
  drm/amd/display: Add debug key to allow disabling dtbclk
  drm/amd/display: Set the power_down_on_boot function pointer to null

Nicholas Kazlauskas (6):
  drm/amd/display: Add debug prints for IPS testing
  drm/amd/display: Exit idle optimizations before HDCP execution
  drm/amd/display: Fix idle check for shared firmware state
  drm/amd/display: Add guards for idle on reg read/write
  drm/amd/display: Guard cursor idle reallow by DC debug option
  drm/amd/display: Add debug counters to IPS exit prints

Revalla Hari Krishna (1):
  drm/amd/display: Refactor DPP into a component directory

Robin Chen (1):
  drm/amd/display: Support long vblank feature

Rodrigo Siqueira (2):
  drm/amd/display: Return the correct HDCP error code
  drm/amd/display: Add comments to v_total calculation and drop legacy
    TODO

Roman Li (1):
  drm/amd/display: Fix function banner for amdgpu_dm_psr_disable_all()

Ryan Lin (1):
  drm/amd/display: Add monitor patch for specific eDP

Sohaib Nadeem (1):
  drm/amd/display: Override min required DCFCLK in dml1_validate

Swapnil Patel (1):
  drm/amd/display: Change default size for dummy plane in DML2

Wenjing Liu (4):
  drm/amd/display: Update odm when ODM combine is changed on an otg
    master pipe with no plane
  drm/amd/display: Implement update_planes_and_stream_v3 sequence
  drm/amd/display: Lock all enabled otg pipes even with no planes
  drm/amd/display: Implement wait_for_odm_update_pending_complete

Xi Liu (1):
  drm/amd/display: Set DCN351 BB and IP the same as DCN35

 drivers/gpu/drm/amd/display/Makefile          |   1 +
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   3 +
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |   6 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c |   2 +-
 drivers/gpu/drm/amd/display/dc/Makefile       |   2 +-
 .../display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c  |  14 +
 .../display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c  |   3 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 824 ++++++++++++------
 .../gpu/drm/amd/display/dc/core/dc_resource.c |  37 +
 .../gpu/drm/amd/display/dc/core/dc_state.c    |   4 +-
 .../gpu/drm/amd/display/dc/core/dc_stream.c   |   4 +-
 drivers/gpu/drm/amd/display/dc/dc.h           | 174 ++--
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |  94 ++
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h  |   1 +
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h  |   1 +
 drivers/gpu/drm/amd/display/dc/dc_types.h     |   4 +-
 .../gpu/drm/amd/display/dc/dce/dmub_replay.c  |   2 +-
 drivers/gpu/drm/amd/display/dc/dcn10/Makefile |   4 +-
 .../amd/display/dc/dcn10/dcn10_cm_common.c    |   2 +-
 .../gpu/drm/amd/display/dc/dcn10/dcn10_opp.c  |   1 +
 drivers/gpu/drm/amd/display/dc/dcn20/Makefile |   2 +-
 .../gpu/drm/amd/display/dc/dcn20/dcn20_opp.c  |  14 +
 .../gpu/drm/amd/display/dc/dcn20/dcn20_opp.h  |   2 +
 .../gpu/drm/amd/display/dc/dcn201/Makefile    |   2 +-
 .../drm/amd/display/dc/dcn201/dcn201_opp.c    |   1 +
 drivers/gpu/drm/amd/display/dc/dcn30/Makefile |   2 -
 .../amd/display/dc/dcn30/dcn30_cm_common.c    |   2 +-
 drivers/gpu/drm/amd/display/dc/dcn32/Makefile |   2 +-
 .../display/dc/dcn32/dcn32_resource_helpers.c |   6 +
 drivers/gpu/drm/amd/display/dc/dcn35/Makefile |   2 +-
 drivers/gpu/drm/amd/display/dc/dml2/Makefile  |   1 +
 .../display/dc/dml2/dml2_dc_resource_mgmt.h   |   2 +
 .../display/dc/dml2/dml2_translation_helper.c |  24 +-
 .../drm/amd/display/dc/dml2/dml2_wrapper.c    |  28 +-
 .../drm/amd/display/dc/dml2/dml2_wrapper.h    |   3 +
 drivers/gpu/drm/amd/display/dc/dpp/Makefile   |  77 ++
 .../amd/display/dc/dpp/dcn10/CMakeLists.txt   |   6 +
 .../display/dc/{ =3D> dpp}/dcn10/dcn10_dpp.c    |   2 +-
 .../display/dc/{ =3D> dpp}/dcn10/dcn10_dpp.h    |   0
 .../display/dc/{ =3D> dpp}/dcn10/dcn10_dpp_cm.c |   4 +-
 .../dc/{ =3D> dpp}/dcn10/dcn10_dpp_dscl.c       |   2 +-
 .../amd/display/dc/dpp/dcn20/CMakeLists.txt   |   5 +
 .../display/dc/{ =3D> dpp}/dcn20/dcn20_dpp.c    |   2 +-
 .../display/dc/{ =3D> dpp}/dcn20/dcn20_dpp.h    |   0
 .../display/dc/{ =3D> dpp}/dcn20/dcn20_dpp_cm.c |   2 +-
 .../amd/display/dc/dpp/dcn201/CMakeLists.txt  |   4 +
 .../display/dc/{ =3D> dpp}/dcn201/dcn201_dpp.c  |   2 +-
 .../display/dc/{ =3D> dpp}/dcn201/dcn201_dpp.h  |   0
 .../amd/display/dc/dpp/dcn30/CMakeLists.txt   |   5 +
 .../display/dc/{ =3D> dpp}/dcn30/dcn30_dpp.c    |   4 +-
 .../display/dc/{ =3D> dpp}/dcn30/dcn30_dpp.h    |   0
 .../display/dc/{ =3D> dpp}/dcn30/dcn30_dpp_cm.c |   4 +-
 .../amd/display/dc/dpp/dcn32/CMakeLists.txt   |   4 +
 .../display/dc/{ =3D> dpp}/dcn32/dcn32_dpp.c    |   2 +-
 .../display/dc/{ =3D> dpp}/dcn32/dcn32_dpp.h    |   0
 .../amd/display/dc/dpp/dcn35/CMakeLists.txt   |   4 +
 .../display/dc/{ =3D> dpp}/dcn35/dcn35_dpp.c    |   2 +-
 .../display/dc/{ =3D> dpp}/dcn35/dcn35_dpp.h    |   0
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   |  55 +-
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.c   |  30 +
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.h   |   2 +
 .../amd/display/dc/hwss/dcn32/dcn32_init.c    |   2 +-
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   |  28 +
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.h   |   3 +
 .../amd/display/dc/hwss/dcn35/dcn35_init.c    |   5 +-
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |   1 +
 .../gpu/drm/amd/display/dc/inc/core_types.h   |  24 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/opp.h   |   3 +
 .../amd/display/dc/inc/hw/timing_generator.h  |   8 +
 drivers/gpu/drm/amd/display/dc/inc/link.h     |   4 +-
 drivers/gpu/drm/amd/display/dc/inc/resource.h |   4 +
 .../link/protocols/link_edp_panel_control.c   |   4 +-
 .../link/protocols/link_edp_panel_control.h   |   4 +-
 .../amd/display/dc/optc/dcn10/dcn10_optc.h    |   9 +-
 .../amd/display/dc/optc/dcn32/dcn32_optc.c    |   8 +
 .../amd/display/dc/optc/dcn32/dcn32_optc.h    |   1 +
 .../amd/display/dc/optc/dcn35/dcn35_optc.c    | 165 +++-
 .../amd/display/dc/optc/dcn35/dcn35_optc.h    |   6 +-
 .../dc/resource/dcn32/dcn32_resource.c        |   3 +
 .../dc/resource/dcn32/dcn32_resource.h        |   3 +
 .../dc/resource/dcn321/dcn321_resource.c      |   2 +
 .../dc/resource/dcn35/dcn35_resource.h        |   2 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  56 +-
 .../amd/display/include/link_service_types.h  |   1 -
 .../drm/amd/display/include/logger_types.h    |   1 +
 .../amd/display/modules/freesync/freesync.c   |   6 +-
 .../gpu/drm/amd/display/modules/hdcp/hdcp.c   |  10 +
 .../drm/amd/display/modules/hdcp/hdcp_psp.c   |   3 +
 .../drm/amd/display/modules/inc/mod_hdcp.h    |   8 +
 .../amd/display/modules/power/power_helpers.c |   2 +-
 .../amd/display/modules/power/power_helpers.h |   2 +-
 91 files changed, 1436 insertions(+), 436 deletions(-)  create mode 100644=
 drivers/gpu/drm/amd/display/dc/dpp/Makefile
 create mode 100644 drivers/gpu/drm/amd/display/dc/dpp/dcn10/CMakeLists.txt
 rename drivers/gpu/drm/amd/display/dc/{ =3D> dpp}/dcn10/dcn10_dpp.c (99%) =
 rename drivers/gpu/drm/amd/display/dc/{ =3D> dpp}/dcn10/dcn10_dpp.h (100%)=
  rename drivers/gpu/drm/amd/display/dc/{ =3D> dpp}/dcn10/dcn10_dpp_cm.c (9=
9%)  rename drivers/gpu/drm/amd/display/dc/{ =3D> dpp}/dcn10/dcn10_dpp_dscl=
.c (99%)  create mode 100644 drivers/gpu/drm/amd/display/dc/dpp/dcn20/CMake=
Lists.txt
 rename drivers/gpu/drm/amd/display/dc/{ =3D> dpp}/dcn20/dcn20_dpp.c (99%) =
 rename drivers/gpu/drm/amd/display/dc/{ =3D> dpp}/dcn20/dcn20_dpp.h (100%)=
  rename drivers/gpu/drm/amd/display/dc/{ =3D> dpp}/dcn20/dcn20_dpp_cm.c (9=
9%)  create mode 100644 drivers/gpu/drm/amd/display/dc/dpp/dcn201/CMakeList=
s.txt
 rename drivers/gpu/drm/amd/display/dc/{ =3D> dpp}/dcn201/dcn201_dpp.c (99%=
)  rename drivers/gpu/drm/amd/display/dc/{ =3D> dpp}/dcn201/dcn201_dpp.h (1=
00%)  create mode 100644 drivers/gpu/drm/amd/display/dc/dpp/dcn30/CMakeList=
s.txt
 rename drivers/gpu/drm/amd/display/dc/{ =3D> dpp}/dcn30/dcn30_dpp.c (99%) =
 rename drivers/gpu/drm/amd/display/dc/{ =3D> dpp}/dcn30/dcn30_dpp.h (100%)=
  rename drivers/gpu/drm/amd/display/dc/{ =3D> dpp}/dcn30/dcn30_dpp_cm.c (9=
9%)  create mode 100644 drivers/gpu/drm/amd/display/dc/dpp/dcn32/CMakeLists=
.txt
 rename drivers/gpu/drm/amd/display/dc/{ =3D> dpp}/dcn32/dcn32_dpp.c (99%) =
 rename drivers/gpu/drm/amd/display/dc/{ =3D> dpp}/dcn32/dcn32_dpp.h (100%)=
  create mode 100644 drivers/gpu/drm/amd/display/dc/dpp/dcn35/CMakeLists.tx=
t
 rename drivers/gpu/drm/amd/display/dc/{ =3D> dpp}/dcn35/dcn35_dpp.c (98%) =
 rename drivers/gpu/drm/amd/display/dc/{ =3D> dpp}/dcn35/dcn35_dpp.h (100%)

--
2.34.1

