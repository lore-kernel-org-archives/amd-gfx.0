Return-Path: <SRS0=9uL8=BD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DD6AC433E1
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Jul 2020 21:06:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAF9A206F0
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Jul 2020 21:06:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="p3SCyD43"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAF9A206F0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 796A06E88D;
	Fri, 24 Jul 2020 21:06:44 +0000 (UTC)
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750059.outbound.protection.outlook.com [40.107.75.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B01A16E88D
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Jul 2020 21:06:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eyctXsmNhaGpUjDPezwzH9d4ac/nkvWlc0NE7Q1xbN8p+LSkcNN6W2E+dYJYOQjQoFJSRyAMHKBIv18mLn9hwWJ3BkzWDZ0YeoL2ok1Z8xPxNQOHfMake95ocHeahxzA1sD5loTBFZtN9nfznWISTCdhSKcWdVEJyo0x1yAyXPXkQQiyx23pu1uQiP0rDy+NylKtZfX51QtgEvBCAat7HIoKEX0/TAvCzPxJXyWLwUw5BMftOtQPAYIAfjAhfNcpqtSKZ2ZeDSjOC5pEAS2CEiLTjXI9PVLQhFEFWnzSl/QfSyej3+9hfwbJjOU0oWVdKgeKZopN5bqcFTEmCejxQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6rayc0NPpHvrKIbPv/aOppC2UPCJfILpeTf7Z5QccU0=;
 b=kIeE0xh3hE16XxFUBDALOsIWl9QpDYPLEyvGPgif6NIj1P02EFJmHSGBCNoIlsOerGYbPSZQcXmJ22WR8W2UNk9Dl2hqPrwvkFiGhQDBtbzo785RpNdXN7pu5xwB+2BNBMyibfiCK8GxC1VtGlxQP1YblB5BtS8Dw/9zh6PgjhgKhz0Dg4JW+eOFoL2SoL9xJZxiTCp/rYQS9HMkV1IEk6ujhy/dUTBvtfOsudM6PWu8COPX11Pdl5tBAMl4ClN/6HGXfFGd02BnXhHM1ihTV4LaljgvJ4JH+/d3NyhCYq8NWn4hqH2ywYNYOkaTB7wiQnfcOnwv2EqC38OnLEDiwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6rayc0NPpHvrKIbPv/aOppC2UPCJfILpeTf7Z5QccU0=;
 b=p3SCyD43ye6EOuVOGQ7Iyv30DQMYuhEgwWR1RvMcGzUV1IFMoTX7TTUjp2nezP5N9CwuH8Qc5VIDhQdMclW8Y2qqxMig/JB/+Qr6x5trC0L6jtWuWvJcZGHoL/pdWvjR4pV5Tc/24dkjJSthmerZ7bIjDZSVWPkGWzivrddJLR8=
Received: from MWHPR2001CA0003.namprd20.prod.outlook.com
 (2603:10b6:301:15::13) by BN6PR12MB1874.namprd12.prod.outlook.com
 (2603:10b6:404:fd::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.21; Fri, 24 Jul
 2020 21:06:37 +0000
Received: from CO1NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:15:cafe::ac) by MWHPR2001CA0003.outlook.office365.com
 (2603:10b6:301:15::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.21 via Frontend
 Transport; Fri, 24 Jul 2020 21:06:37 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT055.mail.protection.outlook.com (10.13.175.129) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3216.10 via Frontend Transport; Fri, 24 Jul 2020 21:06:37 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 24 Jul
 2020 16:06:36 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Fri, 24 Jul 2020 16:06:30 -0500
From: Eryk Brol <eryk.brol@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 00/15] DC Patches July 29, 2020
Date: Fri, 24 Jul 2020 17:06:03 -0400
Message-ID: <20200724210618.2709738-1-eryk.brol@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ce671460-9504-40b4-e326-08d830157433
X-MS-TrafficTypeDiagnostic: BN6PR12MB1874:
X-Microsoft-Antispam-PRVS: <BN6PR12MB1874405AF1F03F6F6455438CE5770@BN6PR12MB1874.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jDavlyP8OOTZSQMJQI+5ED8qV3sFC40Lt2D2BXZsg6DxQzG2Yc5rro8maUIti0p2oFCY4FmcyEzVqg3FZVw90zpu1QSiZfvRKuizm/4x14vFImKF6FeXv0LKCGShNBfyek2GcUSw1EJHC414HbDgtA3JgPHFDnsp1Ww0liC9tTWMws3+ZUyYvb2ZnCwX+jwKS2TSfEq/ZbGJqEcPHGf6MqocnLsVwLj7HtMLLCCQUA7wzmPKezY38eUj3F72Av6yFHWaZHeVg/QSVCbTzql0puAtcSPgD3WvjXYLFKgsv3a7jkND/D8+W6jiTe2XSKZCNpAOdzG1DA3D7cJnnQftaEVId4Ywmomkguc8JKZihBVPtVQdjT4Dg9Q6AsVOZAtGBCBUFFtwSY9MTeTcFINRgA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(346002)(376002)(39860400002)(46966005)(356005)(316002)(82740400003)(36756003)(2906002)(186003)(5660300002)(81166007)(8676002)(44832011)(6666004)(478600001)(1076003)(82310400002)(6916009)(8936002)(86362001)(26005)(83380400001)(4326008)(2616005)(426003)(54906003)(336012)(70206006)(70586007)(47076004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2020 21:06:37.3000 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce671460-9504-40b4-e326-08d830157433
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1874
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
Cc: Eryk Brol <eryk.brol@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This DC patchset brings improvements in multiple areas. In summary, we highlight:

* Fixes in DP Compliance, ABM, and others;
* Enhancements in DSC;
* Improvements in FSFT, DCN, and others.

Alvin Lee (1):
  drm/amd/display: Don't compare dppclk before updating DTO

Anthony Koo (1):
  drm/amd/display: [FW Promotion] Release 0.0.26

Aric Cyr (2):
  drm/amd/display: 3.2.96
  drm/amd/display: Fix DP Compliance tests 4.3.2.1 and 4.3.2.2

Dmytro Laktyushkin (1):
  drm/amd/display: Clean up global sync param retrieval

Eryk Brol (4):
  drm/amd/display: Rename bytes_pp to the correct bits_pp
  drm/amd/display: Fix naming of DSC Debugfs entry
  drm/amd/display: DSC Clock enable debugfs write entry
  drm/amd/display: DSC Slice width debugfs write entry

Jun Lei (1):
  drm/amd/display: Disable idle optimizations before programming DCN

Martin Tsai (1):
  drm/amd/display: Check lane status again after link training done

Reza Amini (1):
  drm/amd/display: Allow asic specific FSFT timing optimization

Stylon Wang (1):
  drm/amd/display: Fix dmesg warning from setting abm level

Wyatt Wood (1):
  drm/amd/display: Use hw lock mgr

hersen wu (1):
  drm/amd/display: dchubbub p-state warning during surface planes switch

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  32 ++-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   6 +
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c | 193 +++++++++++++++++-
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |  17 +-
 .../display/dc/clk_mgr/dcn10/rv1_clk_mgr.c    |  69 ++++++-
 .../display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c  |   7 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  18 +-
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  |  49 +++++
 .../gpu/drm/amd/display/dc/core/dc_stream.c   |  18 +-
 drivers/gpu/drm/amd/display/dc/dc.h           |   2 +-
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |   4 +-
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c |   2 +-
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c |   4 +-
 .../gpu/drm/amd/display/dc/dcn20/dcn20_dsc.c  |   2 +-
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |  27 +++
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.h    |   5 +
 .../gpu/drm/amd/display/dc/dcn20/dcn20_init.c |   3 +
 .../drm/amd/display/dc/dcn20/dcn20_resource.c |  49 +----
 .../gpu/drm/amd/display/dc/dcn21/dcn21_init.c |   3 +
 .../drm/amd/display/dc/dml/display_mode_vba.c |  14 +-
 .../drm/amd/display/dc/dml/display_mode_vba.h |   7 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/dsc.h   |   2 +-
 .../gpu/drm/amd/display/dc/inc/hw_sequencer.h |   5 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   |   4 +-
 .../amd/display/include/link_service_types.h  |   2 +
 .../amd/display/modules/freesync/freesync.c   |   5 +-
 26 files changed, 451 insertions(+), 98 deletions(-)

-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
