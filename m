Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4997CC48BC4
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Feb 2024 21:26:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 61BF610E19B;
	Thu, 15 Feb 2024 21:26:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nPoM3Y2s";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2089.outbound.protection.outlook.com [40.107.92.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E32910E19B
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Feb 2024 21:26:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VI87qTQL5f9muwXp6IJvH9pmNYlilH7mjKsrJlPhGg3gI6BwIPAPGEMgVYdIilUJHNJILj1dFquzOyAhhuHRYx0CEJqbYjYWackB/mHaAFbM9jaTFzKFDYOIuYbtaG0GKIMKK4nqkrBgiTHN6RJ0qVcsit6+Fka5jau/cItrVD40C/tOTxAav7wpRuXxfnB+heYO/N+UlvXA8m6KjhZSZjna0DyDnbJQ5MNCbZYLSNcEReP0iM8l925QlcK5koY6zmhmjduNOdERDCv3MrYkd/WmV/0WwtzUh+WQELBdSJmR2kN48Y65zoh4GTTV++T4SY9RhZgXKzdbjyn9/U1g5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dKwjFiTP6Ez43WRoT/IsmyI61BqeF0yA+M7ym9L7UzA=;
 b=AnUOyZ/LohvahgggB6/Us6HoupfPVh+vQdXA5Ko2INBgn1zMfwrbjFPVWzTCsdjCsm2u2GQ6Kis7hPKtATrh89XGgSmoqaHMT/Fsm8sLcz8+gNRxaY41LP5a3XpCgrpfqNHaG/gxv9TvXr3XFao+6NUTDNPAvNS7ThTxd2jyaoR6phKeylOpvWA0R6hKfW/mlW9JZZbtr8r5mD3zHEcZYg8FwqfxdpkVnY7ptgzhyOowxadh6aFa0uTxfQQA7roRDD1KxyVg1mXkujNtYAFkaYRquB6DBgMuGdjxe7ni4o1g+QIMZFVSbEOJWHOiZ9u8Bvkal5NtXcCR5fqbI7FLFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dKwjFiTP6Ez43WRoT/IsmyI61BqeF0yA+M7ym9L7UzA=;
 b=nPoM3Y2sRgcVa77lIl45OJft7jpFHuYYJenZJppRxP2+rg9oAZVbcxcDtPiklbBwdhrG1QX2LmDk8PU8Z/kjA099pxyRvxAwJawH+qnIZhDPYBrTOXePYNTzlDru0cutn9rBKmR2v277V1CNeRTsLKvFvZHZf04D75UFBvWgCz0=
Received: from DS0PR12MB6534.namprd12.prod.outlook.com (2603:10b6:8:c1::19) by
 SN7PR12MB7811.namprd12.prod.outlook.com (2603:10b6:806:34f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.25; Thu, 15 Feb
 2024 21:26:23 +0000
Received: from DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::6503:7457:78d3:b2f4]) by DS0PR12MB6534.namprd12.prod.outlook.com
 ([fe80::6503:7457:78d3:b2f4%4]) with mapi id 15.20.7292.021; Thu, 15 Feb 2024
 21:26:23 +0000
From: "Wheeler, Daniel" <Daniel.Wheeler@amd.com>
To: "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
CC: "Wentland, Harry" <Harry.Wentland@amd.com>, "Li, Sun peng (Leo)"
 <Sunpeng.Li@amd.com>, "Pillai, Aurabindo" <Aurabindo.Pillai@amd.com>, "Li,
 Roman" <Roman.Li@amd.com>, "Lin, Wayne" <Wayne.Lin@amd.com>, "Gutierrez,
 Agustin" <Agustin.Gutierrez@amd.com>, "Chung, ChiaHsuan (Tom)"
 <ChiaHsuan.Chung@amd.com>, "Wu, Hersen" <hersenxs.wu@amd.com>, "Zuo, Jerry"
 <Jerry.Zuo@amd.com>
Subject: RE: [PATCH 00/17] DC Patches February 14, 2024
Thread-Topic: [PATCH 00/17] DC Patches February 14, 2024
Thread-Index: AQHaX3VJOoFZKKUOTE2KzUkHsN51SLEL31Xw
Date: Thu, 15 Feb 2024 21:26:23 +0000
Message-ID: <DS0PR12MB6534D19FAA694DB66B7C927B9C4D2@DS0PR12MB6534.namprd12.prod.outlook.com>
References: <20240214184006.1356137-1-Rodrigo.Siqueira@amd.com>
In-Reply-To: <20240214184006.1356137-1-Rodrigo.Siqueira@amd.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=04d0dca8-310e-4150-8f2c-75fefb983de3;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2024-02-15T20:40:14Z;
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR12MB6534:EE_|SN7PR12MB7811:EE_
x-ms-office365-filtering-correlation-id: 449606a1-d520-488d-87f6-08dc2e6cc297
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DvaBp0/PGOEAQp9tgyON//P1pwCtnAI4Qq8vfIsdlxCl25rEuMY4yWV7btyI1tqVuMkZ3EgiEWjP9q01/DSLQDNQHaosbicQkO4c/9NpEQZoPRc4ytywGEY/Wwi7iZ4a+fBGndksa+pxfTO9KbEjMWzNCbmAFqvsdORsnFxBPpqOT1x+fcV+dFLL+VnFCwkhaAuXadXfZcgCPzFucKYZSwWzZVM/+f4f1ta+wi8i/6EK0vpkxAOf91qIJtXoPfaMHVvEpjCUJM48hoVK9uCEzt7pdXhlcjl9qdVsoPD1jAeTRQnSjmzc3D1GhuRCNiiTsb6eUNkoQAROwwLmceZ+4fQIOs/8I3KnKWgbe7h40XGo+pBmRDp0ACff/+4qU7UoLSqxS6JhDQ5Y2SEaLpb1w3xC9LI39jac43SRftLDzeqrLWssXcPuagHBJ9FZpK5TmFYmf8KLqmVLBuOGV050TTsHB7hUsXzbx2WXbP9BCU729zTtrG/0xfjjEgrM15u8GHGlbgnqI7RcGilFeYSEF2vIyvIgTuhA2T2oRxEW9SS7G6gnv3je5Ef1mBenSMBxuD0RMTKPsVi65g4gkDry3ZkaNOIqUdztKQeiCl5nF6WjVNOpmw+1UklFGNrh5aVM
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB6534.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(396003)(346002)(39860400002)(366004)(136003)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(83380400001)(5660300002)(86362001)(66446008)(110136005)(478600001)(66476007)(66556008)(64756008)(76116006)(7696005)(71200400001)(6506007)(66946007)(53546011)(316002)(9686003)(2906002)(38100700002)(54906003)(52536014)(122000001)(8676002)(33656002)(55016003)(8936002)(26005)(4326008)(41300700001)(38070700009);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pktih6SjGE3xIATLx5VToNTVYx9v/tb58PIDWBug1DjU801uhOfUi3TwZ84U?=
 =?us-ascii?Q?//6wQ2zdPJ0D6msYPVipvKcl2md0bu2r1xxt45aQf9q8F1HUSSKwwf3T0zYe?=
 =?us-ascii?Q?EwclMjNw7U6LblqEdiuE3kuTmv3U3rQPuw5ZHyKQZVei0UJQW7XeXqZQozYe?=
 =?us-ascii?Q?mpQqUD00wsWzFgs9M0csSnLNLPJaOnclaOmYwNLwIIAMepsBI9blvwfZ+gl0?=
 =?us-ascii?Q?kV5NRZaH2yiIfyZ8hNvsbPsZ5LkfYAfUfZaxNyqEd7g7CA93pS/i8XBUMOHj?=
 =?us-ascii?Q?OPkESotstJQFEToavPLsTB9EJOb+vnL//wlnK7dFCsuUOa3KAOIEYhNBUV1b?=
 =?us-ascii?Q?ToMxl6UjVmf8xMI7RAkZwl7hkp8v47Z6PnZdICqOOLIv3X8prJEPZn2t/PDG?=
 =?us-ascii?Q?uRqYDlJ96WjJXac989PDhaG4zivxALeoOzEBEc56GivbKo0Bf2Y14Qbh5wJm?=
 =?us-ascii?Q?R7ifoR7oO3tjVWlp9/wnH7++VPrl8Emj2A3i+MNgifwVuX+JQQidWZmhI35J?=
 =?us-ascii?Q?tRFw/AP4TAm7gtA7n5MQcWAQX7SVh9lADFEox8oekPpEG5jfLGcV/kt/0BKe?=
 =?us-ascii?Q?KVAohzsw644mQT+syu33BHZuWI3YYTI2Q4hDRJIhFpbPuicjF1JvhZDgpYNc?=
 =?us-ascii?Q?xxc1d5lhfeNyQMZljFdYPTYQ4I6zkhO8pvTv9BmR+dxIwL/qQdDxgLaluDKA?=
 =?us-ascii?Q?ssl9zTUGe/oa49J3HbrEDQN+OWE759Fvw3rHXd4BPFtczYxXxxxCtgr4Qrc1?=
 =?us-ascii?Q?Hf3baNH5GZumv7gTof4RWlXRgpMBYk0g41LBUaHsPZuHs5/9v1XFYvBz2/7G?=
 =?us-ascii?Q?lOZrq6v0/ZwcRFSTgqrDx0sTEbjP8uKhU3Eyf8FRYI7KXvAR/Peo9gm0Frbt?=
 =?us-ascii?Q?NE/mA+2jELMdGWVtPgN7ygER9ho1Uifah8E4cY3Wa9TsnB23aVKTjpIuYbV7?=
 =?us-ascii?Q?zeTxp5VE4iDw12qzJK+3cwsCQW95WFIb06CRJs67hhMlRtMrL/2S6oU+7CGC?=
 =?us-ascii?Q?OiwrnpkpTjy2UmBeyZHMTbk9+OwiXaYGDQYo/oe1O0YyUvrrhwm5HPFHiHMZ?=
 =?us-ascii?Q?MPQwMAnurrWhK/YW1ZNkuXd/o1WFcOmWlKDfQpwMrMg5f5HBsX24js7inVuk?=
 =?us-ascii?Q?bunHTHEojSUuKamhlcUKe73AFJwmojMtxjgc2JrGLbGpvMpPfCyB3tvi+0dM?=
 =?us-ascii?Q?lAP4w/ZHOIi2GgFrOnTcUhcrEJl79qIhVn9dgXyYwawigXxIAQTMvK29OO1N?=
 =?us-ascii?Q?5f6SmDrm2LOX+M1rlRWsqxhmT7N2crh5kwCtKHS5rMbwVSIHhbubX21Bdw3/?=
 =?us-ascii?Q?DmxEcTWisoF6NNTRLGZ6mvNNTP30XRrjuRM+kVZ/drUfHcVp9mR4kw3PP5W/?=
 =?us-ascii?Q?kae5JGjzb7CciOnDUiHbZTjaCrZnefvPLLkhNiPX9R9gKg8/kwgmiwGeF6eT?=
 =?us-ascii?Q?BEUYGpwPW29oGKj/D50nmGxWwT9/5YID++cWPIs3fyjqZp5ZtJ5Ai8PsieWI?=
 =?us-ascii?Q?XCH3LvI/9Oxs4LMKKzxooqeT+KEQXS6oLaW5Njh5ybWySpNXX0C5lqnag6Jj?=
 =?us-ascii?Q?dIfmJVstIpFdW/BlnCk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6534.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 449606a1-d520-488d-87f6-08dc2e6cc297
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Feb 2024 21:26:23.5640 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t7eMqdx4V7JcdM2HIGLlYFE8zx3EIJ5ZjcLvgJdjb2c6Vov+JHyr1WbInYQ7Fdl7Pm8RYhhoP/cQJzYG1r6mvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7811
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

The patchset consists of the amd-staging-drm-next branch (Head commit - 030=
c6867a687 drm/amd/display: 3.2.272) with new patches added on top of it.

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
From: Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>
Sent: Wednesday, February 14, 2024 1:39 PM
To: amd-gfx@lists.freedesktop.org
Cc: Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) <Sunpeng.L=
i@amd.com>; Siqueira, Rodrigo <Rodrigo.Siqueira@amd.com>; Pillai, Aurabindo=
 <Aurabindo.Pillai@amd.com>; Li, Roman <Roman.Li@amd.com>; Lin, Wayne <Wayn=
e.Lin@amd.com>; Gutierrez, Agustin <Agustin.Gutierrez@amd.com>; Chung, Chia=
Hsuan (Tom) <ChiaHsuan.Chung@amd.com>; Wu, Hersen <hersenxs.wu@amd.com>; Zu=
o, Jerry <Jerry.Zuo@amd.com>; Wheeler, Daniel <Daniel.Wheeler@amd.com>
Subject: [PATCH 00/17] DC Patches February 14, 2024

This DC patchset brings improvements in multiple areas. In summary, we
highlight:

- Re-enable windowed MPO support for DCN32/321.
- Improvements in the subvp feature.
- Code clean-up.
- USB4 fixes.

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Thanks
Siqueira

Alvin Lee (2):
  drm/amd/display: Generalize new minimal transition path
  drm/amd/display: Remove pixle rate limit for subvp

Aric Cyr (2):
  drm/amd/display: Fix nanosec stat overflow
  drm/amd/display: 3.2.273

Ethan Bitnun (1):
  drm/amd/display: Only log during optimize_bandwidth call

George Shen (1):
  drm/amd/display: Check DP Alt mode DPCS state via DMUB

Lewis Huang (1):
  drm/amd/display: Only allow dig mapping to pwrseq in new asic

Nicholas Kazlauskas (1):
  drm/amd/display: Fix S4 hang polling on HW power up done for VBIOS
    DMCUB

Rodrigo Siqueira (6):
  drm/amd/display: Remove break after return
  drm/amd/display: Initialize variable with default value
  drm/amd/display: Remove unused file
  drm/amd/display: Add SMU timeout check and retry
  drm/amd/display: Remove redundant FPU guard
  drm/amd/display: Drop unnecessary header

Swapnil Patel (1):
  drm/amd/display: fix input states translation error for dcn35 & dcn351

Wayne Lin (1):
  drm/amd/display: adjust few initialization order in dm

Wenjing Liu (1):
  drm/amd/display: reenable windowed mpo odm support on dcn32 and dcn321

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  37 +++--
 .../gpu/drm/amd/display/dc/basics/dce_calcs.c |   2 -
 .../gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c  |   3 -
 .../display/dc/clk_mgr/dce100/dce_clk_mgr.c   |   2 +-
 .../display/dc/clk_mgr/dcn10/rv1_clk_mgr.c    |   2 -
 .../dc/clk_mgr/dcn10/rv1_clk_mgr_clk.c        |  79 ----------
 .../dc/clk_mgr/dcn21/rn_clk_mgr_vbios_smu.c   |  11 +-
 .../display/dc/clk_mgr/dcn301/dcn301_smu.c    |   6 +-
 .../display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c  |   4 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 146 +++++++-----------
 drivers/gpu/drm/amd/display/dc/dc.h           |   2 +-
 .../drm/amd/display/dc/dce/dce_panel_cntl.c   |   1 +
 .../amd/display/dc/dcn301/dcn301_panel_cntl.c |   1 +
 .../amd/display/dc/dcn31/dcn31_panel_cntl.c   |  18 ++-
 .../display/dc/dcn32/dcn32_dio_link_encoder.c |  85 +++++++---
 .../display/dc/dcn32/dcn32_dio_link_encoder.h |   5 +
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  |   1 -
 .../display/dc/dml2/dml2_translation_helper.c |   9 +-
 .../gpu/drm/amd/display/dc/hdcp/hdcp_msg.c    |   2 -
 .../gpu/drm/amd/display/dc/inc/core_types.h   |  31 ++--
 .../drm/amd/display/dc/inc/hw/panel_cntl.h    |   2 +-
 .../display/dc/irq/dcn20/irq_service_dcn20.c  |   2 -
 .../display/dc/irq/dcn21/irq_service_dcn21.c  |   2 -
 .../drm/amd/display/dc/link/link_factory.c    |  26 +---
 .../dc/resource/dcn20/dcn20_resource.c        |   2 -
 .../dc/resource/dcn32/dcn32_resource.c        |   1 +
 .../dc/resource/dcn321/dcn321_resource.c      |   2 +-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn35.c |   8 +-
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   |   9 +-
 .../drm/amd/display/modules/inc/mod_stats.h   |   4 +-
 30 files changed, 223 insertions(+), 282 deletions(-)  delete mode 100644 =
drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr_clk.c

--
2.43.0

