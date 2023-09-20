Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41F7ACE79A8
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Sep 2023 03:17:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF21A10E03F;
	Wed, 20 Sep 2023 03:17:26 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2061b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::61b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0562B10E03F
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Sep 2023 03:17:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cu8okRiELxhBPpuFjobn6vOleQcEyX4Tvq0NXRSZ+x3ZzEZX7fvB6qL9lzjNQpvrxcLoTzkkBy/ekc+ZGpAZSXGUXMHjWWIK/tq5vkCFmNgYZWBIbgWhWzrMCxOiHY8hUgCDNRXVnrbKvqFMDyrwU7LxGIXwydhwsloBjeUGpJA8SamUyGJLSWjVihKYtgnkK531tOqkORw6WZ2jocnIxL32XEKEpTK1aQpYJ8rIP2w/llwSyIhc9Tc7vo+MlqlkyLiRnhdDfUlGJ8kq6IobaXQV0wPgHi1UtHAHt/WFXRsgmx7cfSvKJjxzyVY10H+I6SA7Yq2fSuk/CXrsTvaKeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8hKtWj2zEeKCOY0oBjiyobrUxyBCNO+jhJSVOIzHMQ=;
 b=MzeUZlyJdUvcjS/V3uwrb3p8Pj7793wMAJtKh9G09UebgXkUxRUsR7DscJTBgdXcqbisq/RFwTaNQ5sWKTimNLibFRmT+iJpjn5cHVmytMtRkig2w/vgv67SGMMo6qWklKxTe/ABh93HC47mYCTEBECvniMHsNZgwnOSRfCew9p+tWUiC42pqh/DQVLm9421R0+frmAYTzSF6DuECMRY8W1JOcStPHAN+quP3gULeLbRReMkNup/oUu/dVlZ8B90ntI+jWHt6WJegiw0kxgQ5FJ2f+7VeH/P7OQQAtAnD72cLqeqxviipvtwN/ASNf+Ye+C2sjJUavHn0Og0EDjdKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8hKtWj2zEeKCOY0oBjiyobrUxyBCNO+jhJSVOIzHMQ=;
 b=Ab70HFfXCQupRznCsto3ruHfnzCSkAd9INya56BJ/2okbxNmhLfrKmXhwQDKx7ixouhpmJj3QdoB3KKlkTGj8lzcVE6U7TSIdCjaiqsW+4u0+FM4b2un5JtlLrhwyIQ7aslB0Em+1WS4MZ8OVzJUQQMYcwW70XVmisnNgIeNwu8=
Received: from BL1P222CA0010.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:2c7::15)
 by DS0PR12MB8785.namprd12.prod.outlook.com (2603:10b6:8:14c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.19; Wed, 20 Sep
 2023 03:17:20 +0000
Received: from MN1PEPF0000F0E3.namprd04.prod.outlook.com
 (2603:10b6:208:2c7:cafe::b0) by BL1P222CA0010.outlook.office365.com
 (2603:10b6:208:2c7::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28 via Frontend
 Transport; Wed, 20 Sep 2023 03:17:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MN1PEPF0000F0E3.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Wed, 20 Sep 2023 03:17:20 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 19 Sep
 2023 22:17:17 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 19 Sep
 2023 20:17:05 -0700
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Tue, 19 Sep 2023 22:16:55 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 00/19] DC Patches September 22, 2023
Date: Wed, 20 Sep 2023 11:16:05 +0800
Message-ID: <20230920031624.3129206-1-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E3:EE_|DS0PR12MB8785:EE_
X-MS-Office365-Filtering-Correlation-Id: baefb295-c6af-4c8b-9424-08dbb98819ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pTsVKRTRiMo092zozwaCR+gNIxFsuiIkNhwjTManxh0gbWS4F0s7tWU6zG04eil9dXuAR/toDNvgovPIeaDpOZoXOrpSd4Rps5ABargPA27Dj8tihtxmQAWvUNoJ03XWjXsBC+rejcOZbsRXVIreQzU0oD9T7QkT32vVC9LQzgU6OSXF7eeXjJg90DbHKPCyvpcAmKnFZwtwy3Un7PQ0Cbp9gfBO/GFaoud6+hY8dydkdO4m9Nko4IM6K9XBtEBUhPnLQF0FnYUfvWVzH93sfPQibfMrSaIO9PwXHLEVSB1oyNGTw8KRXR1LUG0UdF333fNv6aiX8I+isIJq5EUTHCtEtnk1myhIBtxqksfa+FfM+2lBugeaLbcQrrupYG/KQdByntJjNNqegknYFM7M3FixbYxqekz3csPrkLe2w267WThiibr36BzBD1+Sx1kVY1c1WrH/rXIJeVEzeXLtVgORg7G9fSg0VMWc2iuv0T5l7gua86XRyzhEZoxKv2f6HeMFGyvO9OUS0nVv/w6rmp4jpgSnryS1Epfa/+BX89vCXh+bpdfrb7PRvZOYy8Yq9IK4rNNNHn1a8ZdmGMWuNLtK7bT/WxVtVujc6R4UYvr2vpwyTCC/FpTT811i6Pw4cmhB6pV9zTZ33pMwsmqAFvbxjE32yooG7x5PpS9/M1/e4tgj/jP5yuY8NlYurahLI3qIlJpvv2F1qIt4KMVxnNh2KUGXuqe2h9ZGl9roNYQnskXnUkTk7tSSxq3IvZ4ZDSzzF819nzZYFhm+i2/BfA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(376002)(136003)(396003)(39860400002)(186009)(451199024)(1800799009)(82310400011)(40470700004)(46966006)(36840700001)(2616005)(5660300002)(40460700003)(1076003)(41300700001)(426003)(336012)(26005)(47076005)(2906002)(356005)(81166007)(82740400003)(86362001)(36756003)(36860700001)(4326008)(40480700001)(8676002)(8936002)(83380400001)(7696005)(6666004)(478600001)(316002)(6916009)(70206006)(54906003)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 03:17:20.4214 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: baefb295-c6af-4c8b-9424-08dbb98819ec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8785
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
 Aurabindo.Pillai@amd.com, Wayne Lin <Wayne.Lin@amd.com>,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This DC patchset brings improvements in multiple areas. In summary, we highlight:

- fix incorrect odm change detection logic
- add primary pipe check when building slice table for dcn3x
- add get primary dpp pipe resource interface
- add missing function pointer for DCN321 resource
- Rename DisableMinDispClkODM in dc_config
- Break after finding supported vlevel for repopulate
- Update OPP counter from new interface
- augment display clock in dc_cap structure
- Improve code style on bios_parser2
- skip audio config for virtual signal
- block MPO if it prevents pstate support
- Fix DP2.0 timing sync
- Improve x86 and dmub ips handshake
- remove guaranteed viewports limitation for odm
- add new windowed mpo odm minimal transition sequence
- reset stream slice count for new ODM policy
- determine fast update only before commit minimal transition state
- remove unused mmhub_reg_offsets

Cc: Daniel Wheeler <daniel.wheeler@amd.com>
---
Alex Hung (1):
  drm/amd/display: skip audio config for virtual signal

Alvin Lee (1):
  drm/amd/display: Break after finding supported vlevel for repopulate

Aric Cyr (1):
  drm/amd/display: 3.2.253

Dmytro Laktyushkin (1):
  drm/amd/display: block MPO if it prevents pstate support

Duncan Ma (1):
  drm/amd/display: Improve x86 and dmub ips handshake

Gabe Teeger (1):
  drm/amd/display: Rename DisableMinDispClkODM in dc_config

Hong-lu Cheng (1):
  drm/amd/display: Update OPP counter from new interface

Ilya Bakoulin (1):
  drm/amd/display: Fix DP2.0 timing sync

Max Tseng (1):
  drm/amd/display: augment display clock in dc_cap structure

Qingqing Zhuo (1):
  drm/amd/display: remove unused mmhub_reg_offsets

Rodrigo Siqueira (1):
  drm/amd/display: Improve code style on bios_parser2

Wenjing Liu (8):
  drm/amd/display: determine fast update only before commit minimal
    transition state
  drm/amd/display: reset stream slice count for new ODM policy
  drm/amd/display: add new windowed mpo odm minimal transition sequence
  drm/amd/display: remove guaranteed viewports limitation for odm
  drm/amd/display: add missing function pointer for DCN321 resource
  drm/amd/display: add get primary dpp pipe resource interface
  drm/amd/display: add primary pipe check when building slice table for
    dcn3x
  drm/amd/display: fix incorrect odm change detection logic

 .../drm/amd/display/dc/bios/bios_parser2.c    |  37 +--
 .../display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c  |  37 +++
 .../amd/display/dc/clk_mgr/dcn35/dcn35_smu.c  |  14 +-
 .../amd/display/dc/clk_mgr/dcn35/dcn35_smu.h  |   4 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 311 ++++++++++++------
 .../gpu/drm/amd/display/dc/core/dc_resource.c |  46 +++
 drivers/gpu/drm/amd/display/dc/dc.h           |  13 +-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |  57 +++-
 .../gpu/drm/amd/display/dc/dce/dce_audio.c    |   4 +
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |  89 ++---
 .../drm/amd/display/dc/dcn314/dcn314_dccg.c   |   1 +
 .../amd/display/dc/dcn314/dcn314_resource.c   |   2 +
 .../amd/display/dc/dcn315/dcn315_resource.c   |   4 +-
 .../gpu/drm/amd/display/dc/dcn32/dcn32_dccg.c |   1 +
 .../amd/display/dc/dcn321/dcn321_resource.c   |   1 +
 .../gpu/drm/amd/display/dc/dcn35/dcn35_dccg.c |   1 +
 .../drm/amd/display/dc/dcn35/dcn35_hwseq.c    |  30 +-
 .../drm/amd/display/dc/dcn35/dcn35_hwseq.h    |   3 +
 .../gpu/drm/amd/display/dc/dcn35/dcn35_init.c |   4 +-
 .../drm/amd/display/dc/dcn35/dcn35_resource.c |  14 +-
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  |  44 +--
 .../gpu/drm/amd/display/dc/inc/core_types.h   |  11 +
 .../gpu/drm/amd/display/dc/inc/hw/clk_mgr.h   |   2 +
 drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h  |   4 +
 .../gpu/drm/amd/display/dc/inc/hw_sequencer.h |   3 +-
 drivers/gpu/drm/amd/display/dc/inc/resource.h |  16 +
 26 files changed, 527 insertions(+), 226 deletions(-)

-- 
2.37.3

