Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56ECAC77B7F
	for <amd-gfx@archiver.kernel.org>; Wed, 17 May 2023 11:38:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07EDA10E3EB;
	Wed, 17 May 2023 11:38:29 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::600])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8585D10E011
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 May 2023 11:38:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NIBBgxEWQTAzu/oPn9w3xpReukxKjqTkoTr653Hv7JLqutol0ksGPim7QOOLpzvt2izjI4H030/lhx8VGMY1dwx5m3IyIbjRJJwCjaPAY9sv7mZIGknHLjUqkpOkbeGLpivOGrtGyFMmQ8SA2OIRTefyBMVBtFoUKCYEJmasBqsArv1eHnsiFWiN+T4pdBNxDe9CnpbS6hFWHOzX2lJbpTtlvvvzMPvbmTvEHc0j8wOPmyc8yhPS42GTvEi4VnHO+6/nw8L9Y8AhagU2qeWWXCWxkqdgxq8EOM0tkujRWGk0G8Rn9J0139We/ROFCCLeOYT8oe20yXW4/waUh2EvXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nb9hRzm4IzraOgNFOSjUTVtuYdHlPYHfDCiH5aLZ14E=;
 b=IrvyICzNMiRkf7mvQP7sSIJ5NnKvG/+FX0ezuyF+lh9jp17Scvj+buHB4fKDHROQWZrlWK6w5Yxw+PFqQ+0X7MV7WDjpvjVKG4Tr0BV/nZ4LtvBL6eDWan4UXj2V/80z7YnVRJDldkb1LXLeQvR9XD/mn3YNp1KBR0n/3nUqXqc2dq82l2/I9i08vYFGEHOfYoIH1iAEvwKcoO+tztkYLoSJulqixmK/hIa7E2aDOTnsR1k0+YYqYHxcCaa/wjmzOatQGxqjt0kszwjDRLXndw9UIDqS7QgcfBHtjNxVsaIk6eNySLbesH16cR6WfGpq+qgDy8j208awA1VAfOPjBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nb9hRzm4IzraOgNFOSjUTVtuYdHlPYHfDCiH5aLZ14E=;
 b=FXd0AvwEICk4kFn+bQu8qMeAN5CvXoquWHZOMwhhPzx6oKYPFRh/m8nCp2c/M3P9V+dxB7zBDujc8YU7p9JwL9eBTozEFbTMHjWZYH8mxuF/7LJ3sQ7nC+IW8/I1JJ5gIdkZO5UngHXcXJ9x4kOTfRI9Z0Kwtq2T3lpFfMT5oTM=
Received: from BN0PR04CA0066.namprd04.prod.outlook.com (2603:10b6:408:ea::11)
 by DM4PR12MB5769.namprd12.prod.outlook.com (2603:10b6:8:60::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6411.17; Wed, 17 May 2023 11:38:23 +0000
Received: from BN8NAM11FT007.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ea:cafe::d1) by BN0PR04CA0066.outlook.office365.com
 (2603:10b6:408:ea::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.18 via Frontend
 Transport; Wed, 17 May 2023 11:38:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT007.mail.protection.outlook.com (10.13.177.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.18 via Frontend Transport; Wed, 17 May 2023 11:38:22 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 17 May
 2023 06:38:20 -0500
Received: from tom-HP.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Wed, 17 May 2023 06:38:15 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/18] drm/amd/display: Fix DMUB debugging print issue
Date: Wed, 17 May 2023 19:37:07 +0800
Message-ID: <20230517113723.1757259-3-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230517113723.1757259-1-chiahsuan.chung@amd.com>
References: <20230517113723.1757259-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT007:EE_|DM4PR12MB5769:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a3f9dfb-daff-4064-84a5-08db56cb3874
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Xg3gQs3Ru/V07CYVDDj+nXzvoO6hCEVp7pHGPJqstZv0BjpyjcwmHbIGnfidW1ZghvH707YDt0NcQgzQAAsZ418ja9I79ypXhfazlQyjjnHGzBmxDCfznxADlDj/baDWQ9aaP8pyKiYyw5E/ULmTvCB2WlXmRHK1k5V6vWo6kKwrh6oxC1/Bzq7ccFOM8FTy1R7XqwepQZhcU2Kyglttq2ZecxzDd6qfVnRgr0bkRcHS5ci8gqMg/OrdxFM+t4JBXppQK1Es8pNcezD013Ts7DS2pGruGQ1Pbyevq7rOhuGJAE0qb34xmoQfjKpD7VrMaNZ7OWlTo4R1XNRc8Tp9fl1Z9XDNLXOaNeAz+rerSjLyXaziNjzQqtXUKngBKjuCr5gyU7J1v+GOnHD9xJIMM3fzslwBI0zmkvAaa9lmrtfOGcnJRoEotcgUm1kS1ow8IXa/VHngugZD0xazOrY87HG7Qa+lnfIXSn/QtbEajUpvcofL+5rpkiIwOJGMHlV51QE7zQIKGJcWah5kt7//i344yT1ANK5uXw/eMN7g7478acevRE9t7WoUc9C9LpNQomzkvlvoZ9OzyYOLuppXh740aYoxiumvZH1LYJJZmzlNWuzsqkfcngoGMpX93cwBOpZ36LRKYhqiBnZlbZXjLLZldgWBWTeFzhgNq1pG8uqhrXYrmTq0+f1x/NFbjQbnQc76L4oL/NL9Ubf35neufFSDxKcyGPYLgPBqZLiKiATiRvNKRLZ7JH1q5mNPyKJ0033EWSihr7puc7Fn3nOWxQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(396003)(39860400002)(136003)(346002)(451199021)(40470700004)(46966006)(36840700001)(82310400005)(1076003)(2906002)(186003)(40460700003)(86362001)(26005)(83380400001)(40480700001)(2616005)(336012)(426003)(36860700001)(36756003)(47076005)(81166007)(356005)(82740400003)(6666004)(41300700001)(7696005)(4326008)(6916009)(70586007)(70206006)(316002)(54906003)(478600001)(5660300002)(8676002)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 11:38:22.8254 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a3f9dfb-daff-4064-84a5-08db56cb3874
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT007.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5769
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
Cc: stylon.wang@amd.com, Tom Chung <chiahsuan.chung@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 Cruise Hung <cruise.hung@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Cruise Hung <cruise.hung@amd.com>

[Why]
The DMUB diagnostic data was not printed out correctly.

[How]
Print the DMUB diagnostic data line by line.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Cruise Hung <cruise.hung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c     |  12 +++
 drivers/gpu/drm/amd/display/dc/dc.h          |   2 +
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c | 103 +++++++------------
 3 files changed, 49 insertions(+), 68 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index f864fd3b6f29..32bc268a7138 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -4853,6 +4853,18 @@ void dc_process_dmub_dpia_hpd_int_enable(const struct dc *dc,
 	DC_LOG_DEBUG("%s: hpd_int_enable(%d)\n", __func__, hpd_int_enable);
 }
 
+/**
+ * dc_print_dmub_diagnostic_data - Print DMUB diagnostic data for debugging
+ *
+ * @dc: [in] dc structure
+ *
+ *
+ */
+void dc_print_dmub_diagnostic_data(const struct dc *dc)
+{
+	dc_dmub_srv_log_diagnostic_data(dc->ctx->dmub_srv);
+}
+
 /**
  * dc_disable_accelerated_mode - disable accelerated mode
  * @dc: dc structure
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 2dff1a5cf3b1..7fc087f85d39 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -2236,6 +2236,8 @@ enum dc_status dc_process_dmub_set_mst_slots(const struct dc *dc,
 void dc_process_dmub_dpia_hpd_int_enable(const struct dc *dc,
 				uint32_t hpd_int_enable);
 
+void dc_print_dmub_diagnostic_data(const struct dc *dc);
+
 /* DSC Interfaces */
 #include "dc_dsc.h"
 
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index 0319a30f2d5c..c52c40b16387 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -169,6 +169,7 @@ bool dc_dmub_srv_cmd_run_list(struct dc_dmub_srv *dc_dmub_srv, unsigned int coun
 
 		if (status != DMUB_STATUS_OK) {
 			DC_LOG_DEBUG("No reply for DMUB command: status=%d\n", status);
+			dc_dmub_srv_log_diagnostic_data(dc_dmub_srv);
 			return false;
 		}
 
@@ -797,74 +798,40 @@ void dc_dmub_srv_log_diagnostic_data(struct dc_dmub_srv *dc_dmub_srv)
 		return;
 	}
 
-	DC_LOG_DEBUG(
-		"DMCUB STATE\n"
-		"    dmcub_version      : %08x\n"
-		"    scratch  [0]       : %08x\n"
-		"    scratch  [1]       : %08x\n"
-		"    scratch  [2]       : %08x\n"
-		"    scratch  [3]       : %08x\n"
-		"    scratch  [4]       : %08x\n"
-		"    scratch  [5]       : %08x\n"
-		"    scratch  [6]       : %08x\n"
-		"    scratch  [7]       : %08x\n"
-		"    scratch  [8]       : %08x\n"
-		"    scratch  [9]       : %08x\n"
-		"    scratch [10]       : %08x\n"
-		"    scratch [11]       : %08x\n"
-		"    scratch [12]       : %08x\n"
-		"    scratch [13]       : %08x\n"
-		"    scratch [14]       : %08x\n"
-		"    scratch [15]       : %08x\n"
-		"    pc                 : %08x\n"
-		"    unk_fault_addr     : %08x\n"
-		"    inst_fault_addr    : %08x\n"
-		"    data_fault_addr    : %08x\n"
-		"    inbox1_rptr        : %08x\n"
-		"    inbox1_wptr        : %08x\n"
-		"    inbox1_size        : %08x\n"
-		"    inbox0_rptr        : %08x\n"
-		"    inbox0_wptr        : %08x\n"
-		"    inbox0_size        : %08x\n"
-		"    is_enabled         : %d\n"
-		"    is_soft_reset      : %d\n"
-		"    is_secure_reset    : %d\n"
-		"    is_traceport_en    : %d\n"
-		"    is_cw0_en          : %d\n"
-		"    is_cw6_en          : %d\n",
-		diag_data.dmcub_version,
-		diag_data.scratch[0],
-		diag_data.scratch[1],
-		diag_data.scratch[2],
-		diag_data.scratch[3],
-		diag_data.scratch[4],
-		diag_data.scratch[5],
-		diag_data.scratch[6],
-		diag_data.scratch[7],
-		diag_data.scratch[8],
-		diag_data.scratch[9],
-		diag_data.scratch[10],
-		diag_data.scratch[11],
-		diag_data.scratch[12],
-		diag_data.scratch[13],
-		diag_data.scratch[14],
-		diag_data.scratch[15],
-		diag_data.pc,
-		diag_data.undefined_address_fault_addr,
-		diag_data.inst_fetch_fault_addr,
-		diag_data.data_write_fault_addr,
-		diag_data.inbox1_rptr,
-		diag_data.inbox1_wptr,
-		diag_data.inbox1_size,
-		diag_data.inbox0_rptr,
-		diag_data.inbox0_wptr,
-		diag_data.inbox0_size,
-		diag_data.is_dmcub_enabled,
-		diag_data.is_dmcub_soft_reset,
-		diag_data.is_dmcub_secure_reset,
-		diag_data.is_traceport_en,
-		diag_data.is_cw0_enabled,
-		diag_data.is_cw6_enabled);
+	DC_LOG_DEBUG("DMCUB STATE:");
+	DC_LOG_DEBUG("    dmcub_version      : %08x", diag_data.dmcub_version);
+	DC_LOG_DEBUG("    scratch  [0]       : %08x", diag_data.scratch[0]);
+	DC_LOG_DEBUG("    scratch  [1]       : %08x", diag_data.scratch[1]);
+	DC_LOG_DEBUG("    scratch  [2]       : %08x", diag_data.scratch[2]);
+	DC_LOG_DEBUG("    scratch  [3]       : %08x", diag_data.scratch[3]);
+	DC_LOG_DEBUG("    scratch  [4]       : %08x", diag_data.scratch[4]);
+	DC_LOG_DEBUG("    scratch  [5]       : %08x", diag_data.scratch[5]);
+	DC_LOG_DEBUG("    scratch  [6]       : %08x", diag_data.scratch[6]);
+	DC_LOG_DEBUG("    scratch  [7]       : %08x", diag_data.scratch[7]);
+	DC_LOG_DEBUG("    scratch  [8]       : %08x", diag_data.scratch[8]);
+	DC_LOG_DEBUG("    scratch  [9]       : %08x", diag_data.scratch[9]);
+	DC_LOG_DEBUG("    scratch [10]       : %08x", diag_data.scratch[10]);
+	DC_LOG_DEBUG("    scratch [11]       : %08x", diag_data.scratch[11]);
+	DC_LOG_DEBUG("    scratch [12]       : %08x", diag_data.scratch[12]);
+	DC_LOG_DEBUG("    scratch [13]       : %08x", diag_data.scratch[13]);
+	DC_LOG_DEBUG("    scratch [14]       : %08x", diag_data.scratch[14]);
+	DC_LOG_DEBUG("    scratch [15]       : %08x", diag_data.scratch[15]);
+	DC_LOG_DEBUG("    pc                 : %08x", diag_data.pc);
+	DC_LOG_DEBUG("    unk_fault_addr     : %08x", diag_data.undefined_address_fault_addr);
+	DC_LOG_DEBUG("    inst_fault_addr    : %08x", diag_data.inst_fetch_fault_addr);
+	DC_LOG_DEBUG("    data_fault_addr    : %08x", diag_data.data_write_fault_addr);
+	DC_LOG_DEBUG("    inbox1_rptr        : %08x", diag_data.inbox1_rptr);
+	DC_LOG_DEBUG("    inbox1_wptr        : %08x", diag_data.inbox1_wptr);
+	DC_LOG_DEBUG("    inbox1_size        : %08x", diag_data.inbox1_size);
+	DC_LOG_DEBUG("    inbox0_rptr        : %08x", diag_data.inbox0_rptr);
+	DC_LOG_DEBUG("    inbox0_wptr        : %08x", diag_data.inbox0_wptr);
+	DC_LOG_DEBUG("    inbox0_size        : %08x", diag_data.inbox0_size);
+	DC_LOG_DEBUG("    is_enabled         : %d", diag_data.is_dmcub_enabled);
+	DC_LOG_DEBUG("    is_soft_reset      : %d", diag_data.is_dmcub_soft_reset);
+	DC_LOG_DEBUG("    is_secure_reset    : %d", diag_data.is_dmcub_secure_reset);
+	DC_LOG_DEBUG("    is_traceport_en    : %d", diag_data.is_traceport_en);
+	DC_LOG_DEBUG("    is_cw0_en          : %d", diag_data.is_cw0_enabled);
+	DC_LOG_DEBUG("    is_cw6_en          : %d", diag_data.is_cw6_enabled);
 }
 
 static bool dc_can_pipe_disable_cursor(struct pipe_ctx *pipe_ctx)
-- 
2.25.1

