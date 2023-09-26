Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F1D4E7F13B
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Sep 2023 21:53:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 073FA10E438;
	Tue, 26 Sep 2023 21:53:44 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2049.outbound.protection.outlook.com [40.107.93.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0107710E438
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Sep 2023 21:53:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PB5cHxqt7+7F4ttmCbaov+MLXxfaYqAGRQgnshWJCzYODzZ619IVZ82OB7y35r8nIN0hDH10X6+TfGyGp2T1FWVMcwBO3YAvhSQSLQZ6QS4Mo+/HhuavLLDUmoM465l8JIVgdbc06iLVUMfbwHiX6AkWhV3GphlDfEVabaL7tnNnQJtmRg3n6HocIJ3uEZGQBXrkc8GIL5fUsev9qlV1SqZuBGGwz5KyBQpNp6TgW13cmZ8nzBWhfO/OgDFFC/Yhbm+OXSujzLMPRLxkj5yBVTEsYnyQH7me7Q+jq56rl3mtHvksCjiVr3cwIalF+oh3iDnwjQ4xwa/88zwNflu57Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cp+Yr4tJcXWCKUAYiGQ/mCUFZXkD6Ag3CRkSZYCpzus=;
 b=UMInf30aZYHBPpKr8WJqlojLgJVtbp1sDKPCfXvqxnsZ+n8pIRNGgipKIiBTuioUR8doM2fbfi5ykQzFgt846x+eTPtcEe1i8I6jnQc9J3Ru6XtIZ4zYVViN94Jt3SWddPPBSmxOVUjWYFJSOAanjhSmt7Bn0/2uXO+rzHFaAjiOUyCq4AP2sHF52/LSMtFQKgedcU3yhescY3haY9sVcuWWj3QGdweXiIkYCCYNtd38Kzt/y+k0k19UfGvY2l2vgSRoBJtLgycjM7v1RJfOtA9iVkUdvcT1DHdkVk8gHf6oYHnab6pxpBP1xKIXGYkibyQzq5QCkAKFETDncyDVAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cp+Yr4tJcXWCKUAYiGQ/mCUFZXkD6Ag3CRkSZYCpzus=;
 b=5eAzoOEB1FRjMFCkYItXjMip8+WRVxrukjvRoZTVAcuSEGzKW3PLhOzg5T7x8bz5nJAfT2V3I4smR9rI8fbCR22fzoMZgfyhkm+XS/VC6e8Kw+ODe87mq9WFGX8V1fBzl/QAbRuHxFm9WQaIYs1e00qFSVPbvGmue68IplJ1YUA=
Received: from SJ0PR05CA0153.namprd05.prod.outlook.com (2603:10b6:a03:339::8)
 by MW6PR12MB7072.namprd12.prod.outlook.com (2603:10b6:303:238::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Tue, 26 Sep
 2023 21:53:38 +0000
Received: from DS3PEPF000099D4.namprd04.prod.outlook.com
 (2603:10b6:a03:339:cafe::30) by SJ0PR05CA0153.outlook.office365.com
 (2603:10b6:a03:339::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.19 via Frontend
 Transport; Tue, 26 Sep 2023 21:53:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D4.mail.protection.outlook.com (10.167.17.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Tue, 26 Sep 2023 21:53:37 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 26 Sep
 2023 16:53:37 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 26 Sep
 2023 14:53:36 -0700
Received: from manjaura-ryzen.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Tue, 26 Sep 2023 16:53:36 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 00/14] DC Patches for 2023 Sept 29
Date: Tue, 26 Sep 2023 17:46:51 -0400
Message-ID: <20230926215335.200765-1-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D4:EE_|MW6PR12MB7072:EE_
X-MS-Office365-Filtering-Correlation-Id: be1e972f-81ca-4ae2-e9f9-08dbbedb09e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5Ps/2Amud+W2HLMC1xNw3ZZSn2FlwxXO32gYnRF0sSNLaKEgOwRL0EhPAOS9noj3xLcd56+MizUFrObrKQiVpN2tHTeOBVkJHa024u/tJFfVHMS8uVAYWgN5Din2paBkUh4DPrh4ME5gkzqxr9ZOFEi+w5+dzpN0jk3nDW5ICGPE+9nJaY73Ec+gBRins6iipcaBrHTnsChRctI+cB4H/eTvirExR6kgHCxgISwVHy48WXF+2YppdrmLK/jaso1SqElLFVfElRXYeXSaZdnfCk/Jk+Ouk6WseT7oHxxoAkNYwpQdHSXClei5OJi0Zo/VINYJEnLt4GejXQ8CSGNyUxSPZMjoXiqr2RgEwWaYYtH16Fa/BPhf7fajAptkFWFvpaiNScOxLTB5gJvt5kqiybZET/lJzShJqEvMk/8uWR19duUTsnoENs4kdbdupvu6p8c6BwH/9x8OU3q1qEACjKX+d/XyxO+qkDXa1qw+PulsT0DUnFxXDXI1PFbwoNkDxUSwbWvwhVhy0BVeWGRw8/aa3SYQMr4BfrgbBW6/2X/UE0isT0lHNp13FGSI7XO9i1hHRJ8r01sDR5YyAYR10/yznuxgKEGLf0Sc3Lcx4rRvMWm8GAwuPoHulyY4NNyTQ9KKJ9Bq0w2CRh+HOtPjUVKCFupqZBQTOFLLtPxnSt4rLtfp6jjVjmd69J6mGNSAVaZn/ykJt/D+gHWnX6nK3L4YP0YBMd+FnBN9hbwJQATxaJTiHWCgN5kVHfWmXKI9Eo7Dh44i2p5B0h70NJoLMA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(376002)(136003)(346002)(230922051799003)(82310400011)(186009)(1800799009)(451199024)(46966006)(40470700004)(36840700001)(2906002)(40460700003)(47076005)(478600001)(82740400003)(86362001)(36756003)(6666004)(26005)(1076003)(426003)(336012)(83380400001)(7696005)(81166007)(2616005)(356005)(40480700001)(8936002)(41300700001)(36860700001)(4326008)(8676002)(316002)(5660300002)(44832011)(70206006)(70586007)(54906003)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2023 21:53:37.5650 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be1e972f-81ca-4ae2-e9f9-08dbbedb09e8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D4.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB7072
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
Cc: stylon.wang@amd.com, chiahsuan.chung@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This DC patchset brings improvements in multiple areas. In summary, we have:

* Stability fixes through null pointer checks, blackscreen fixes on
  certain configurations 
* Improvements for various functionality like Idle optimization, ILR, DSC, IPS
* Fixes for ILR functionality
* Trivial code cleanups

===================================================================

Aric Cyr (2):
  drm/amd/display: Clean up code warnings
  drm/amd/display: 3.2.254

Aurabindo Pillai (3):
  drm/amd/display: Update DMUB cmd header
  drm/amd/display: Adjust code style for dmub_cmd.h
  drm/amd/display: Adjust code style for hw_sequencer.h

Chiawen Huang (1):
  drm/amd/display: remove duplicated edp relink to fastboot

Gabe Teeger (1):
  drm/amd/display: Add Null check for DPP resource

Kim, Sung joon (1):
  drm/amd/display: Add a check for idle power optimization

Muhammad Ahmed (1):
  drm/amd/display: enable dsc_clk even if dsc_pg disabled

Ovidiu Bunea (1):
  drm/amd/display: Make driver backwards-compatible with non-IPS PMFW

Samson Tam (1):
  drm/amd/display: apply edge-case DISPCLK WDIVIDER changes to master
    OTG pipes only

Sherry Wang (1):
  drm/amd/display: refactor ILR to make it work

Wayne Lin (1):
  drm/amd/display: fix problems in power_helper

Wenjing Liu (1):
  drm/amd/display: use full update for clip size increase of large plane
    source

 .../display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c  |   4 +-
 .../display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c  |   4 +-
 .../display/dc/clk_mgr/dcn35/dcn35_clk_mgr.c  |  28 ++-
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 102 ++++-----
 .../gpu/drm/amd/display/dc/core/dc_resource.c |   2 +-
 .../gpu/drm/amd/display/dc/core/dc_stream.c   |  17 --
 drivers/gpu/drm/amd/display/dc/dc.h           |  10 +-
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h  |   7 -
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |   6 -
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |  27 ---
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.h    |   6 -
 .../gpu/drm/amd/display/dc/dcn20/dcn20_init.c |   3 -
 .../gpu/drm/amd/display/dc/dcn21/dcn21_init.c |   3 -
 .../drm/amd/display/dc/dcn32/dcn32_hwseq.c    |   3 +
 .../drm/amd/display/dc/dcn35/dcn35_resource.c |   3 +-
 .../gpu/drm/amd/display/dc/inc/hw_sequencer.h |  56 +++--
 .../drm/amd/display/dc/link/link_detection.c  |   6 +
 .../dc/link/protocols/link_dp_capability.c    |  14 +-
 .../link/protocols/link_edp_panel_control.c   |  21 +-
 .../link/protocols/link_edp_panel_control.h   |   2 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 193 ++++++++++--------
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   |   1 +
 .../drm/amd/display/modules/inc/mod_stats.h   |   2 +-
 .../amd/display/modules/power/power_helpers.c |  23 ++-
 24 files changed, 248 insertions(+), 295 deletions(-)

-- 
2.42.0

