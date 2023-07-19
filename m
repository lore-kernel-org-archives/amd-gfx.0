Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A8F7C001B0
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Jul 2023 18:32:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F9C810E116;
	Wed, 19 Jul 2023 18:32:57 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2065.outbound.protection.outlook.com [40.107.220.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DA8710E116
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Jul 2023 18:32:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WroRp4ePUyYj2BxgOsA0sbQeq669flVoz6On+h+IWG7kNdk/9efRFIXTFpExWVkHH6oPgNwBVYX/sfpKJWrj+ZU13ravjgKLS2c6f1g57MQMVzFibwJDrnihvF9ghKYNi77NUF8EIGfc05rcpc7R0AdHAdnNHBItqWdQuY7vy6kugN7BARx2z+DrlF/LjEce1MAd4VjDUeyEgZnZBc/QEuEMr2L5FyWE5aguv/VBuprRKFemotlUVtvntT1nB9BqUURQ2JH+eOBc9Z4jTdcynotSMNq6XB+4VrzKdP1pWm8Zjycj3UVj9u3OwE0xBF/UdNnsrBzWGXYimPcXr034uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G/iEAGL+Kxrhh+KXuKlusv3WzknqC+QuhkD1xKWsbPs=;
 b=Po1cG5T9lfoIQt4+C9/wQoS542vBWZRxjvuRxFOVz2lgkWxj1jt7TNwl7V5+axmvdxktAN32E7kHOOEvHkCCrsNxDyITXEsfQM7NS1WifoQndCac9ChF2/LOcYYeUYwMvSy4YbZJKs2JGHK/EmdLpPWcVu2Wc127Z4ax1gzN6tdnKaWHfCCH2FZ+vA+u83pJ0zyR5Spbx63GpbPIYSLNlJcuZV7r71efJ3e53SMy7A4QO6kyimmo04ns39+CiI55hGkPPOeqMyMNGJYBtmvkd8Tc2BTqQEkxCS8ZikTU8WDiAZdYmUBLuOC/OpO5j9dIsrB8tFfx4H2ZP5XwbcadCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G/iEAGL+Kxrhh+KXuKlusv3WzknqC+QuhkD1xKWsbPs=;
 b=2BfmJdsuXgLKXvC6HrmJm+t/YlWkj5s1EllH/4jI4WJKpmDjsJefNyE4N0oMtqmNXhsQ88G8DzgjnJu/cojgCkRjzTLoqlxkGX1J9KApRuhgCYgz4ThfIEr6bBqIrBxcnoSco8e/tyTxS81b3y1TY1oB4JU3aXRhwBoXbly2+cc=
Received: from BN8PR15CA0062.namprd15.prod.outlook.com (2603:10b6:408:80::39)
 by BY5PR12MB4934.namprd12.prod.outlook.com (2603:10b6:a03:1db::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Wed, 19 Jul
 2023 18:32:51 +0000
Received: from BN8NAM11FT076.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:80:cafe::4a) by BN8PR15CA0062.outlook.office365.com
 (2603:10b6:408:80::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24 via Frontend
 Transport; Wed, 19 Jul 2023 18:32:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT076.mail.protection.outlook.com (10.13.176.174) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.34 via Frontend Transport; Wed, 19 Jul 2023 18:32:50 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 19 Jul
 2023 13:32:48 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 00/16] DC Patches July 19, 2023
Date: Wed, 19 Jul 2023 12:27:50 -0600
Message-ID: <20230719183211.153690-1-alex.hung@amd.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT076:EE_|BY5PR12MB4934:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b851814-2894-47d5-8d9d-08db88868f0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Kik2DE+cJVeQtoh8ZtlN/SAG4fsl92z+LXp12lUUUpUZnjRxubKz8raeh9/d7WPnYjte+WpZZvTKt4mESk2Jg/MC1UwHHdU6yEotH1rmsBpoWHvzH4hhoEEAf/cEaXtS9bCNl6NSYwDNwTn3w+sbvoc3TltjnyhEqkf0LvrTnS5GtlyOwG4iwXRrYsDny9M5lFwd2S8aEBIgTllg13qgs3aUegs0iJwUet50OHIjEp4u72P5xoUq/J4kwFg+yIT1v/QSVmzdNQjvd5mjvIDtApP/DxUUun8qtZSmPrk9c4fU6XSexnb+Py5Ps70Zg6eC+p9UEP9xeHm6gJvRkTIo8LBUxahYaHZzuBjl7PApugCcE1H9l9iUinFr6qYXX6Xsw4d1yAoi+f1oRXgAW+lXaxVg0hBrVc6noOg+OpYikST5f7oAr9U2oyVoQKATNjavsiZWwQK+N6upCK4X41FWub4SbxkscMCH9iYGl2jOc4TdTUCFgSNBU7C29ovfw9LiQct4LYSTOwRBgExQTSXKAheveiHeDYJvIEbdfQX5sxWKsWKcrs2UPMWaB9O4IF91NMj4LMpRfHB0NV1yrTMR17blY1S2SQL8FKFninZRQoGbHloYIAUiqlkbkTXrULTVsMPnjhLCIX2O1imWLBdASmO7cf7FW0n/VdBFJAB6olxr8ubHHSnfZsiVfSFWlKS6NeTjZa+H1vkr9BwiS4DjaLq9vv+dvydZEmP8PO3MmEQfdLwkS4w15Q9egShwD+nar9gyxQHbFJ0kjGNzy/oVOg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(346002)(376002)(136003)(396003)(82310400008)(451199021)(40470700004)(36840700001)(46966006)(81166007)(82740400003)(356005)(40480700001)(40460700003)(6666004)(7696005)(86362001)(186003)(336012)(1076003)(16526019)(26005)(8676002)(44832011)(6916009)(316002)(41300700001)(5660300002)(70586007)(70206006)(4326008)(54906003)(2906002)(8936002)(83380400001)(36860700001)(2616005)(426003)(47076005)(478600001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 18:32:50.9613 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b851814-2894-47d5-8d9d-08db88868f0d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT076.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4934
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Daniel Wheeler <daniel.wheeler@amd.com>,
 Aurabindo.Pillai@amd.com, Alex Hung <alex.hung@amd.com>, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This DC patchset brings improvements in multiple areas. In summary, we highlight:

- Fix underflow issue on 175hz timing
- Add interface to modify DMUB panel power options
- Remove check for default eDP panel_mode
- Add new sequence for 4-lane HBR3 on vendor specific retimers
- Update DPG test pattern programming
- Correct unit conversion for vstartup
- Exit idle optimizations before attempt to access PHY
- Refactor recout calculation with a more generic formula
- Read down-spread percentage from lut to adjust dprefclk.
- Don't apply FIFO resync W/A if rdivider = 0
- Prevent invalid pipe connections
- Rearrange dmub_cmd defs order
- Add VESA SCR case for default aux backlight
- Guard DCN31 PHYD32CLK logic against chip family
- Correct grammar mistakes

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Alvin Lee (1):
  drm/amd/display: Don't apply FIFO resync W/A if rdivider = 0

Anthony Koo (1):
  drm/amd/display: Rearrange dmub_cmd defs order

Aric Cyr (1):
  drm/amd/display: 3.2.244

Ethan Bitnun (1):
  drm/amd/display: Prevent invalid pipe connections

George Shen (1):
  drm/amd/display: Guard DCN31 PHYD32CLK logic against chip family

Iswara Nagulendran (1):
  drm/amd/display: Add VESA SCR case for default aux backlight

Leo Chen (1):
  drm/amd/display: Exit idle optimizations before attempt to access PHY

Leo Ma (1):
  drm/amd/display: Fix underflow issue on 175hz timing

Martin Tsai (1):
  drm/amd/display: Read down-spread percentage from lut to adjust
    dprefclk.

Ovidiu Bunea (1):
  drm/amd/display: Add new sequence for 4-lane HBR3 on vendor specific
    retimers

Paul Hsieh (1):
  drm/amd/display: Add interface to modify DMUB panel power options

Reza Amini (2):
  drm/amd/display: Correct grammar mistakes
  drm/amd/display: Correct unit conversion for vstartup

Taimur Hassan (1):
  drm/amd/display: Remove check for default eDP panel_mode

Wenjing Liu (2):
  drm/amd/display: Refactor recout calculation with a more generic
    formula
  drm/amd/display: Update DPG test pattern programming

 .../dc/clk_mgr/dcn314/dcn314_clk_mgr.c        |  33 +-
 .../dc/clk_mgr/dcn314/dcn314_clk_mgr.h        |   7 +
 .../gpu/drm/amd/display/dc/core/dc_resource.c | 597 +++++++++++++-----
 drivers/gpu/drm/amd/display/dc/dc.h           |   2 +-
 .../display/dc/dce110/dce110_hw_sequencer.c   |   3 +
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |  45 +-
 .../drm/amd/display/dc/dcn21/dcn21_resource.c |   4 +-
 .../drm/amd/display/dc/dcn30/dcn30_resource.c |   4 +-
 .../gpu/drm/amd/display/dc/dcn31/dcn31_dccg.c |   3 +-
 .../gpu/drm/amd/display/dc/dcn32/dcn32_dccg.c |   5 +-
 .../amd/display/dc/dml/dcn314/dcn314_fpu.c    |  25 +-
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  |   4 +-
 .../dc/dml/dcn32/display_mode_vba_util_32.c   |   7 +-
 .../display/dc/link/accessories/link_dp_cts.c | 107 ++--
 .../link_dp_training_fixed_vs_pe_retimer.c    |  67 +-
 .../link/protocols/link_edp_panel_control.c   |  67 +-
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |   3 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |  74 +--
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   |  12 +
 19 files changed, 750 insertions(+), 319 deletions(-)

-- 
2.41.0

