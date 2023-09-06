Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B1BFEB8FC7
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Sep 2023 12:50:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 822FE10E63B;
	Wed,  6 Sep 2023 12:50:01 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20619.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::619])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C7DAF10E63A
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Sep 2023 12:49:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KA/WQ36f7v3FoCVH6KbuixFNRAKm64UNDJ2CHcuaHndEHR5Is/nYx8VfbD2yXb8B35gdBk/B/Dy8ZkIBZVvowW8TAr4VgOxeKkfuCTePQNU7EAxcBKyTd5H/lXhLL4qFoZqk998nvm1f1vgVzzr2RuZTUnLNzus/2vKdePTWO/KQFKE/vxXu/2BFWe8X3nSZAwD0tgxKUB/tvNhmw7h6rEAiIalqg2JzTJVhhycTQZsPgqWjEa+ByAop7QW/xJZkZBcq1wFqKygYOKYYxtBP2RiowNJRF8cfaQ0ouyBabdDnJKk1W0l92BR3sB3noiH1FTq4vE7aeKf5cj0kM4mAtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SvEJgS8bQb3gcKrnQmou0xujgTZPFvIPn8e3i0+u9XI=;
 b=I5/8uJK3KrIPJThhKMf3bEza6QwUTa/p8AgE98usKlvdOmWfpeekxiMy2Kk8mRTqlYsNrApBzUnIfrRqRfXjqx2J5Z038nmD9Ap96ifQJlboazJGT3hHyVuMK+fhlIye6BOj6C25oUtsIA9y/X76W8n2lQSbR4gbQDZGax7HN7GepKWEvsNf7WRqQQVKHbqO7+0beMgZ+QmnNExaHO73qFn1cPKy/Sj9gmJxPIVyM3ex1g9mTMZUXFI0ioeo6+nrgfwY6QNE8SmnQ3Ms4UxO5BaRLrX9Wftq89PlWrM500h2biD9uOI2idWKRrlFdi91AlQvXS0pmHNGwpV0sFbLbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SvEJgS8bQb3gcKrnQmou0xujgTZPFvIPn8e3i0+u9XI=;
 b=EdCGA5OmUHAeMi+KjtaVjrXTetw4/FnCYpPKnXNQG0X5p0DaMYkObW/jWtXUFmyJElcpw1KfYyRD31C39F0fu81yxczPxZleZsDTyHykXFiRRN0+LbgCeT2iVWB0tP9m4fGna3UUi+4pd3FkZIkh1kw/7vkRbBJJQ3UsMhl7ubs=
Received: from CYZPR05CA0034.namprd05.prod.outlook.com (2603:10b6:930:a3::20)
 by IA1PR12MB6482.namprd12.prod.outlook.com (2603:10b6:208:3a9::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Wed, 6 Sep
 2023 12:49:55 +0000
Received: from CY4PEPF0000EDD3.namprd03.prod.outlook.com
 (2603:10b6:930:a3:cafe::7) by CYZPR05CA0034.outlook.office365.com
 (2603:10b6:930:a3::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.25 via Frontend
 Transport; Wed, 6 Sep 2023 12:49:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD3.mail.protection.outlook.com (10.167.241.207) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6768.25 via Frontend Transport; Wed, 6 Sep 2023 12:49:55 +0000
Received: from stylon-EliteDesk.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 6 Sep
 2023 07:49:50 -0500
From: Stylon Wang <stylon.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 13/28] drm/amd/display: Add DCHUBBUB callback to report MALL
 status
Date: Wed, 6 Sep 2023 20:28:18 +0800
Message-ID: <20230906124915.586250-14-stylon.wang@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230906124915.586250-1-stylon.wang@amd.com>
References: <20230906124915.586250-1-stylon.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD3:EE_|IA1PR12MB6482:EE_
X-MS-Office365-Filtering-Correlation-Id: d656969f-1d84-46b1-03fd-08dbaed7c51f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Auf/DfcHx+4Yb9FONrehobQ4TEx0XnmmwoFzkeyRrv25tS3ifVrRi0uV7h+SZ5uGSAswV164CPKm7WkcG/Cw0fSi7GkBWJ+/4hQIRfGLj7b2mVrEPFCUL8AA6ABlYQCiihGcOs1FpNrJfZVtwmOHJFHMtxL2VL1qKfNfp4gascTbbFnFau+GkSA4QDPALiAi+95j8WXFmUZerXua+/luF3QkZzkdXXZJJ4seolc9y9E77YRKVwkhISzRO0BUnBKLvfw4kGXM1cdPds/C6Ofy9OGc3rHJ7XshbT4Q5tEZgjoAxUOhz85VZAYTtzDvKXq+icxtVHsaI06ESnyOO68lR5CTAmZ5WGUXJ6XoH10JlgFZh6yV1x4nNDBeqBq9KEUpeAUMvH35m8KOsOEi1OvlxedSmxftXJl1zPe9qHCSiRFpiyUi5Q/7aJRDsJq2ncMsQz96TQ8YxOL+XLq+SMeWzvHAZqDrYdjVgyendXbM6t/QHLuCFaF5iI7l4PUhjyheDpw6hEAyNdVHhGoD/b1bKiBPEGbPAu5MPw/ULtznUO+gwDe0boGuG6YYTWaoZS1FI4B1Qxa1KDJhEAK09D52NhBGRZaHmEfSW6UnXJZicCr7O3nXVFGf8/EuXPg21d3eJb8/0obobKs9zOEqspSkSNRJc+8GOi4r6a9oEyOthCf78qknlt7kZjpbwrGa6wviM1aMtgYM/q5GE5H6Gg8SBigbM5FnqM+LZaFn0cZ4vezq1/eXK7we5uTRAjhHHUUaI1O4fmaCJwA0h8KLsjEicg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(376002)(396003)(346002)(136003)(82310400011)(186009)(1800799009)(451199024)(36840700001)(46966006)(40470700004)(6666004)(7696005)(478600001)(83380400001)(1076003)(2616005)(26005)(426003)(16526019)(336012)(2906002)(54906003)(6916009)(44832011)(41300700001)(70206006)(316002)(70586007)(5660300002)(4326008)(8936002)(8676002)(40460700003)(36756003)(40480700001)(47076005)(36860700001)(86362001)(81166007)(356005)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 12:49:55.0309 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d656969f-1d84-46b1-03fd-08dbaed7c51f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6482
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
 solomon.chiu@amd.com, Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Alvin Lee <alvin.lee2@amd.com>, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aurabindo Pillai <aurabindo.pillai@amd.com>

[Why&How]
For enabling automated testing, add a hook to DCHUBBUB interface so that
mall status can be queried by userspace through debugfs. This removes
dependence on requiring a userspace tool like UMR for querying status
for MALL static screen IGT test.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Acked-by: Stylon Wang <stylon.wang@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c  | 13 ++++++++++---
 .../gpu/drm/amd/display/dc/dcn10/dcn10_hubbub.h    |  5 ++++-
 .../gpu/drm/amd/display/dc/dcn32/dcn32_hubbub.c    | 14 +++++++++++++-
 .../gpu/drm/amd/display/dc/dcn32/dcn32_hubbub.h    |  6 +++++-
 .../gpu/drm/amd/display/dc/dcn32/dcn32_resource.h  |  1 +
 drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h   |  1 +
 6 files changed, 34 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
index 05c1ad98a1f6..1259d6351c50 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_debugfs.c
@@ -37,6 +37,7 @@
 #include "link_hwss.h"
 #include "dc/dc_dmub_srv.h"
 #include "link/protocols/link_dp_capability.h"
+#include "inc/hw/dchubbub.h"
 
 #ifdef CONFIG_DRM_AMD_SECURE_DISPLAY
 #include "amdgpu_dm_psr.h"
@@ -3642,10 +3643,16 @@ DEFINE_DEBUGFS_ATTRIBUTE(disable_hpd_ops, disable_hpd_get,
 static int capabilities_show(struct seq_file *m, void *unused)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)m->private;
-	struct dc_caps caps = adev->dm.dc->caps;
-	bool mall_supported = caps.mall_size_total;
+	struct dc *dc = adev->dm.dc;
+	bool mall_supported = dc->caps.mall_size_total;
+	unsigned int mall_in_use = false;
+	struct hubbub *hubbub = dc->res_pool->hubbub;
+
+	if (hubbub->funcs->get_mall_en)
+		hubbub->funcs->get_mall_en(hubbub, &mall_in_use);
 
-	seq_printf(m, "mall: %s\n", mall_supported ? "yes" : "no");
+	seq_printf(m, "mall supported: %s, enabled: %s\n",
+			   mall_supported ? "yes" : "no", mall_in_use ? "yes" : "no");
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubbub.h b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubbub.h
index adc876156d2e..5ddf2b36986e 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubbub.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubbub.h
@@ -171,6 +171,7 @@ struct dcn_hubbub_registers {
 	uint32_t DCHUBBUB_ARB_FCLK_PSTATE_CHANGE_WATERMARK_B;
 	uint32_t DCHUBBUB_ARB_FCLK_PSTATE_CHANGE_WATERMARK_C;
 	uint32_t DCHUBBUB_ARB_FCLK_PSTATE_CHANGE_WATERMARK_D;
+	uint32_t DCHUBBUB_ARB_MALL_CNTL;
 	uint32_t SDPIF_REQUEST_RATE_LIMIT;
 	uint32_t DCHUBBUB_SDPIF_CFG0;
 	uint32_t DCHUBBUB_SDPIF_CFG1;
@@ -194,7 +195,9 @@ struct dcn_hubbub_registers {
 		type DCHUBBUB_ARB_FCLK_PSTATE_CHANGE_WATERMARK_A;\
 		type DCHUBBUB_ARB_FCLK_PSTATE_CHANGE_WATERMARK_B;\
 		type DCHUBBUB_ARB_FCLK_PSTATE_CHANGE_WATERMARK_C;\
-		type DCHUBBUB_ARB_FCLK_PSTATE_CHANGE_WATERMARK_D
+		type DCHUBBUB_ARB_FCLK_PSTATE_CHANGE_WATERMARK_D;\
+		type MALL_PREFETCH_COMPLETE;\
+		type MALL_IN_USE
 
 #define HUBBUB_REG_FIELD_LIST_DCN35(type) \
 		type DCHUBBUB_FGCG_REP_DIS
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubbub.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubbub.c
index 8bfef6d095b2..88dfc907553d 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubbub.c
@@ -945,6 +945,17 @@ void hubbub32_force_wm_propagate_to_pipes(struct hubbub *hubbub)
 			DCHUBBUB_ARB_DATA_URGENCY_WATERMARK_A, prog_wm_value);
 }
 
+void hubbub32_get_mall_en(struct hubbub *hubbub, unsigned int *mall_in_use)
+{
+	struct dcn20_hubbub *hubbub2 = TO_DCN20_HUBBUB(hubbub);
+	uint32_t prefetch_complete, mall_en;
+
+	REG_GET_2(DCHUBBUB_ARB_MALL_CNTL, MALL_IN_USE, &mall_en,
+			  MALL_PREFETCH_COMPLETE, &prefetch_complete);
+
+	*mall_in_use = prefetch_complete && mall_en;
+}
+
 void hubbub32_init(struct hubbub *hubbub)
 {
 	struct dcn20_hubbub *hubbub2 = TO_DCN20_HUBBUB(hubbub);
@@ -995,7 +1006,8 @@ static const struct hubbub_funcs hubbub32_funcs = {
 	.init_crb = dcn32_init_crb,
 	.hubbub_read_state = hubbub2_read_state,
 	.force_usr_retraining_allow = hubbub32_force_usr_retraining_allow,
-	.set_request_limit = hubbub32_set_request_limit
+	.set_request_limit = hubbub32_set_request_limit,
+	.get_mall_en = hubbub32_get_mall_en,
 };
 
 void hubbub32_construct(struct dcn20_hubbub *hubbub2,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubbub.h b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubbub.h
index ad33427192c6..f073839a4b6d 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubbub.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubbub.h
@@ -110,7 +110,9 @@
 	HUBBUB_SF(DCHUBBUB_CLOCK_CNTL, DCFCLK_R_DCHUBBUB_GATE_DIS, mask_sh),\
 	HUBBUB_SF(DCHUBBUB_SDPIF_CFG0, SDPIF_PORT_CONTROL, mask_sh),\
 	HUBBUB_SF(DCHUBBUB_SDPIF_CFG1, SDPIF_MAX_NUM_OUTSTANDING, mask_sh),\
-	HUBBUB_SF(DCHUBBUB_MEM_PWR_MODE_CTRL, DET_MEM_PWR_LS_MODE, mask_sh)
+	HUBBUB_SF(DCHUBBUB_MEM_PWR_MODE_CTRL, DET_MEM_PWR_LS_MODE, mask_sh),\
+	HUBBUB_SF(DCHUBBUB_ARB_MALL_CNTL, MALL_PREFETCH_COMPLETE, mask_sh),\
+	HUBBUB_SF(DCHUBBUB_ARB_MALL_CNTL, MALL_IN_USE, mask_sh)
 
 
 
@@ -157,4 +159,6 @@ void hubbub32_construct(struct dcn20_hubbub *hubbub2,
 
 void hubbub32_set_request_limit(struct hubbub *hubbub, int umc_count, int words_per_umc);
 
+void hubbub32_get_mall_en(struct hubbub *hubbub, unsigned int *mall_in_use);
+
 #endif
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h
index c76de61029e0..f075982363be 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h
@@ -1283,6 +1283,7 @@ bool dcn32_subvp_vblank_admissable(struct dc *dc, struct dc_state *context, int
       SR(DCHUBBUB_ARB_FCLK_PSTATE_CHANGE_WATERMARK_B),                         \
       SR(DCHUBBUB_ARB_FCLK_PSTATE_CHANGE_WATERMARK_C),                         \
       SR(DCHUBBUB_ARB_FCLK_PSTATE_CHANGE_WATERMARK_D),                         \
+      SR(DCHUBBUB_ARB_MALL_CNTL),                                              \
       SR(DCN_VM_FAULT_ADDR_MSB), SR(DCN_VM_FAULT_ADDR_LSB),                    \
       SR(DCN_VM_FAULT_CNTL), SR(DCN_VM_FAULT_STATUS),                          \
       SR(SDPIF_REQUEST_RATE_LIMIT)                                             \
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h b/drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h
index f5677dbb4e7d..cea05843990c 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h
@@ -193,6 +193,7 @@ struct hubbub_funcs {
 	void (*force_usr_retraining_allow)(struct hubbub *hubbub, bool allow);
 	void (*set_request_limit)(struct hubbub *hubbub, int memory_channel_count, int words_per_channel);
 	void (*dchubbub_init)(struct hubbub *hubbub);
+	void (*get_mall_en)(struct hubbub *hubbub, unsigned int *mall_in_use);
 };
 
 struct hubbub {
-- 
2.42.0

