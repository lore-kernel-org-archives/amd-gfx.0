Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B294C64EC4
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Feb 2023 06:41:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B0B510E0EF;
	Wed, 22 Feb 2023 06:41:08 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2049.outbound.protection.outlook.com [40.107.96.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9288A10E0EF
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Feb 2023 06:41:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aLW9rDvhj+y7xPEZOSn/+V7GT2v7O2UkRJ8Q+vfIQSP6wRW4owdHRXIhuWD3scCNHLiDmhTCraKib8CZQ1dA9KHgFaO8vMwd+VgHPcKLxtPKaAZPaG0skY/x7qwh5n1uXPKxYoksAlaDMELFraQrauInIHGgG6QqOdTogKhGgsR1dAcFEzo6BYMy8v+83fK7y4cMaG1+vn4iqiXGaWZ3Pl52ZxfCjv9Ak4Z31bdiN+61RdWEyv6YSyaq+ufYW9z6RdPkGJ/PwBaoNfvKgUGtLUrcWZ4gopGGpR/Q137PJg/7Zwtkb6v0J9hY9oHFlLMpbh1wObGocIR3Wc4wiBIMLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gBn+VObaAGa26x6xNDLPLM3YrL1+5QS/QDwUzodscNc=;
 b=HqHGOeaS+hTX9B+RHZb2bS6Elzy1Fl8bXOSUmI4ACa9FMf2B/Qi1BCer+249euXAMQtaOH4PILoJny3M+VzcTR4KnS/F3PcpAq2DITSY2PNcwMS16I0uJCBb3/jTf/ozivZaXTjK7vadlLoNmDJ7/t9H2MOLMP/zEREL1HIbdkHAq+GYpABs4tPVgiDdzS76JP6pjdimSalt6JdkNDGQfdTYVWxpi9+h4j0T+y/u25omT2nKRvSxpJQC5SF08EPrskLcISWMZ2emBkHRO9z0BVL1nHRJ/4me7nyXIxTAl8Y49KF1o8Sa8R0pKw11BL/M0q+3/85Abb94lW9b91JNpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gBn+VObaAGa26x6xNDLPLM3YrL1+5QS/QDwUzodscNc=;
 b=kQUoxtbyQrgTDOYfQxD2R34KoLMnG51LcuWRn0tsAMa6yxOI3DJDCkEGXME/TkjbMKGYjvP9BlT1V+qFeY1LZQRcj4j5ZV3SvNAy8DwiEpkls2wt46RpLKZXXJRTNELwWoKMSW764AjVWshXM8DzK99JNTjz8GlffqNZHXxnfbg=
Received: from DS7PR05CA0056.namprd05.prod.outlook.com (2603:10b6:8:2f::17) by
 BL1PR12MB5048.namprd12.prod.outlook.com (2603:10b6:208:30a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.21; Wed, 22 Feb
 2023 06:41:05 +0000
Received: from DM6NAM11FT091.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2f:cafe::66) by DS7PR05CA0056.outlook.office365.com
 (2603:10b6:8:2f::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.17 via Frontend
 Transport; Wed, 22 Feb 2023 06:41:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT091.mail.protection.outlook.com (10.13.173.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6134.19 via Frontend Transport; Wed, 22 Feb 2023 06:41:04 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 22 Feb
 2023 00:40:58 -0600
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 00/20] DC Patches Feb 27th, 2023
Date: Wed, 22 Feb 2023 01:40:21 -0500
Message-ID: <20230222064041.2824-1-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT091:EE_|BL1PR12MB5048:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f339996-d24b-438d-6a51-08db149fc547
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ttWz4u1GTav7JqxEJ+vskPcvAqUvx2n6sQnXAf8oQak1qkzEaxHz0qbwtylk9S9gcJV2CLReS7GnPMJNOPJZN0o8ppZ+rBPUdj7ytwwrdS3ljFVg8bu2f9iuKqMfoHZL+afEL63410DVhbpivs4uQKQE7EpvwbsyvF3d+KnWVeDLfr5+K/XKz81bB+dxvSHl6pNwYmxkWTh7tsuGQsYOWmIkUhidOu8g0om01ZOv+/WMAZ/UftiL6GSwHKEL38XL2DHDfs7nQGjlgrK6ymXRmTbD0BNWVh42fFlCo0cVEH5Gc0fEhhlxnpHqOpnla1JEb3ks2Tvu6ss4Xrxq1T0UZYydlUy5zW9/wsVqCgfgAqKKTlIF+F9Md8Sqnunoxy9lXbJv3yn4j3NUHKgkcHwoyNNQD4HdqpMN2/lVGdGMhMPU3Y4NBsEb0BNQqA03CvdYDmZuiYQ/IOSAUuE7d2XtSTmgvojapI4u+nm/w/m4m5V1sXUb5WcPdW/CBPXhS4ArvsfC8QysNR//9YPbyvQEEYzeCa8X95faHHCfsqdFavlJ086uEejQZXNp97TWSYeoRS/9BDps3zor0GQ4SDCyOcX189O8b3y768KDZv7loPL7GFc33e9qkwyX9dZfZyeJ12+UW8oAkpdQMr7M6UwA/0LW4p9k5StCmdYR12sj3oOWI+ryHPl7ixPRkRH/FIkAAoT9BPX/yAjDewKnvlBeiuSPiZgvHd6UDy/jZCVK6KY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(39860400002)(396003)(346002)(136003)(376002)(451199018)(40470700004)(46966006)(36840700001)(83380400001)(47076005)(41300700001)(82310400005)(186003)(54906003)(16526019)(26005)(1076003)(316002)(40460700003)(40480700001)(336012)(86362001)(6666004)(478600001)(36756003)(356005)(8676002)(6916009)(2616005)(70206006)(4326008)(70586007)(426003)(2906002)(36860700001)(82740400003)(81166007)(5660300002)(44832011)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2023 06:41:04.4110 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f339996-d24b-438d-6a51-08db149fc547
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT091.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5048
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
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This DC patchset brings improvements in multiple areas. In summary, we highlight:
- Correct DML calculation
- Extend Freesync over Pcon support
- Fixes in pstate hang and more
- Code cleanup for dc_link.h and dc_link.c

Cc: Daniel Wheeler <daniel.wheeler@amd.com>

Alex Hung (1):
  drm/amd/display: fix shift-out-of-bounds in CalculateVMAndRowBytes

Alvin Lee (1):
  drm/amd/display: DAL to program DISPCLK WDIVIDER if PMFW doesn't

Aric Cyr (6):
  drm/amd/display: Reduce CPU busy-waiting for long delays
  Revert "drm/amd/display: Do not set DRR on pipe commit"
  Revert "drm/amd/display: Fix FreeSync active bit issue"
  drm/amd/display: Do not update DRR while BW optimizations pending
  drm/amd/display: Only wait for blank completion if OTG active
  drm/amd/display: Promote DAL to 3.2.224

Ayush Gupta (1):
  drm/amd/display: populate subvp cmd info only for the top pipe

Hersen Wu (1):
  drm/amd/display: dcn32/321 dsc_pg_control not executed properly

Jasdeep Dhillon (1):
  drm/amd/display: Updating Video Format Fall Back Policy.

Mustapha Ghaddar (2):
  drm/amd/display: Allocation at stream Enable
  drm/amd/display: Update BW ALLOCATION Function declaration

Paul Hsieh (1):
  drm/amd/display: Correct DML calculation as HW SpreadSheet

Ryan Lin (1):
  drm/amd/display: Ext displays with dock can't recognized after resume

Samson Tam (1):
  drm/amd/display: enable DPG when disabling plane for phantom pipe

Sung Joon Kim (1):
  drm/amd/display: Extend Freesync over PCon support for more devices

Wenjing Liu (2):
  drm/amd/display: merge dc_link.h into dc.h and dc_types.h
  drm/amd/display: remove empty dc_link.c

Yihan Zhu (1):
  drm/amd/display: update pixel format in DP hw sequence

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  17 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_debugfs.c |   2 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_hdcp.c    |   1 +
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c |   2 +
 .../gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c  |   4 +-
 .../display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c  |  41 +-
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 253 +++-----
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |  27 -
 .../drm/amd/display/dc/core/dc_link_exports.c |  87 +++
 drivers/gpu/drm/amd/display/dc/dc.h           | 556 +++++++++++++++++-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |   3 +-
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h  | 107 ++++
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h  |  14 +
 drivers/gpu/drm/amd/display/dc/dc_link.h      |   8 +-
 drivers/gpu/drm/amd/display/dc/dc_types.h     | 104 ++++
 drivers/gpu/drm/amd/display/dc/dce/dce_aux.c  |   9 +-
 drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c |   2 +-
 drivers/gpu/drm/amd/display/dc/dce/dmub_abm.c |   2 +-
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c |   2 +-
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.h |   5 +-
 .../display/dc/dce110/dce110_hw_sequencer.c   |   2 +-
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c |   2 +-
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |   9 +
 .../dc/dcn30/dcn30_dio_stream_encoder.c       |   1 +
 .../drm/amd/display/dc/dcn30/dcn30_hwseq.c    |  10 +-
 .../dc/dcn31/dcn31_hpo_dp_link_encoder.c      |   1 -
 .../dc/dcn31/dcn31_hpo_dp_stream_encoder.c    |   2 +-
 .../dc/dcn314/dcn314_dio_stream_encoder.c     |   6 +
 .../dc/dcn32/dcn32_hpo_dp_link_encoder.c      |   1 -
 .../drm/amd/display/dc/dcn32/dcn32_hwseq.c    |  21 +-
 .../drm/amd/display/dc/dcn32/dcn32_resource.c |   1 +
 .../amd/display/dc/dcn321/dcn321_resource.c   |   1 +
 .../dc/dml/dcn30/display_mode_vba_30.c        |   6 +-
 .../dc/dml/dcn31/display_mode_vba_31.c        | 299 ++++++----
 .../dc/dml/dcn314/display_mode_vba_314.c      | 299 ++++++----
 .../dc/dml/dcn32/display_mode_vba_32.c        |   1 -
 .../gpu/drm/amd/display/dc/inc/hw/hw_shared.h |  14 -
 .../drm/amd/display/dc/inc/hw/link_encoder.h  |  52 --
 .../amd/display/dc/inc/hw/stream_encoder.h    |   1 -
 drivers/gpu/drm/amd/display/dc/inc/link.h     |   1 -
 .../display/dc/link/accessories/link_dp_cts.c |  17 -
 .../drm/amd/display/dc/link/link_detection.c  |  99 ++++
 .../gpu/drm/amd/display/dc/link/link_dpms.c   |  15 +-
 .../amd/display/dc/link/protocols/link_ddc.h  |   1 +
 .../dc/link/protocols/link_dp_capability.c    |  10 +-
 .../display/dc/link/protocols/link_dp_dpia.c  |   1 -
 .../dc/link/protocols/link_dp_dpia_bw.c       |  38 +-
 .../dc/link/protocols/link_dp_dpia_bw.h       |  14 +-
 .../dc/link/protocols/link_dp_training.c      |   7 +-
 .../dc/link/protocols/link_dp_training_dpia.c |   3 +-
 .../link/protocols/link_edp_panel_control.c   |   4 +-
 .../amd/display/include/link_service_types.h  |  26 -
 .../amd/display/modules/freesync/freesync.c   |  12 +-
 .../drm/amd/display/modules/inc/mod_hdcp.h    |   1 +
 54 files changed, 1618 insertions(+), 606 deletions(-)
 delete mode 100644 drivers/gpu/drm/amd/display/dc/core/dc_link.c

-- 
2.34.1

