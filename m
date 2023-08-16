Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADEA5C001E0
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Aug 2023 06:08:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38F1710E2D0;
	Wed, 16 Aug 2023 06:08:14 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2071.outbound.protection.outlook.com [40.107.94.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A16D910E2D0
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Aug 2023 06:08:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KHiKjB1DBZazyORUHjjuBmpCIR0uNv2lFYlFidLJmeY79YTa+0u+im1MDIo1HfwnF88F+ZQET3A/aveVMxs83u0Zvt04T4Zd/vTCPA2fyKuPAUBUVbdpI4rp6Pshhiqxj9WuacSwQCf8avKcr216XOvW4eQLBMk/dj/6gQY/hCH9ALMWMqnymPrpLQ4jMQVLwYzKd5T+NJqs4EyGdvh7ZyZegvI8Ur0KOGg5IEhtrtMuoEsudSApSxPAg+h1FIMTYJ16wSSBYyoAdmCAL/IdYIAYy37AE8UkBasVVNvvy+WgBsKTOd4b8UiSuv9SrQQ6gk+cIZYQ5atNhf7gzwcemQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yWhcydVFWeWXl6UsUTS0Effy+Cs077bJGuY45RQZ2XM=;
 b=NEX/kerEqdeAB04Rr3/tsEq4riOu85lQ3XHxuTSd5RQY87QqeWVjwTiMXOtgo+7efuL40l+IYKdkNWqe68JH1CYJ0Fch/XRERjIhw9hktRLePQUDsYZmaOKQvgD9kNZG4NL01eTokQzfsQNDJ/W6f4VoC8Td38ULK+jkenDrnJdx+WIylEsRIGOQoqVkAB5HVoLREmzgq9eLKudk8tWzRZVZbEE+aWRNlXaRftoR1/keALnRsjYGQaQVkri1Che7E/AqpzTUNXB+X27ul5atTXiJCW0OAmVZpgidU1R/h+aQvB7SUUhnUcMvWyJNqTVAt3kSD728SvRiGId5+I9FNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yWhcydVFWeWXl6UsUTS0Effy+Cs077bJGuY45RQZ2XM=;
 b=E/rELt5rb4PMmzf1POKCW2sbQBD8FxASp6kr/iCsYgxDmvgD8ePt+RV2ehYQcBFH6SFc3gJCVVuCnVuyJTCOi6hjcw8yBH21M8SteDKxvdNUeBFNE32togK1qfWxhgv0dJMqzJsWltTX2s7u5xyT2J0ntgmhc0VmUon0WmPRN3Q=
Received: from DM6PR11CA0015.namprd11.prod.outlook.com (2603:10b6:5:190::28)
 by SA1PR12MB6996.namprd12.prod.outlook.com (2603:10b6:806:24f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Wed, 16 Aug
 2023 06:08:10 +0000
Received: from CY4PEPF0000EE32.namprd05.prod.outlook.com
 (2603:10b6:5:190:cafe::5a) by DM6PR11CA0015.outlook.office365.com
 (2603:10b6:5:190::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Wed, 16 Aug 2023 06:08:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EE32.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Wed, 16 Aug 2023 06:08:09 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 16 Aug
 2023 01:08:08 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 15 Aug
 2023 23:08:08 -0700
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Wed, 16 Aug 2023 01:07:58 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/16] drm/amd/display: Enable runtime register offset init
 for DCN32 DMUB
Date: Wed, 16 Aug 2023 14:06:48 +0800
Message-ID: <20230816060658.2141009-7-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230816060658.2141009-1-Wayne.Lin@amd.com>
References: <20230816060658.2141009-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE32:EE_|SA1PR12MB6996:EE_
X-MS-Office365-Filtering-Correlation-Id: 06f29197-9f94-4d7c-f783-08db9e1f2aa8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7zXxL/CWYIygZyOv3OlykPWkYYWRoOGrRmzmFWbtyqFC/s9hkT85bFK6CD6tNJ39ARMxrcTQkd+oDSynpp5Hd1BnjVyy7c/FKjbUUEjZkKzKH1dLZojONANMjnqoQcH7ZMQ8IHQ2ZfA/oOrcdDSFhclVLDXbXUi/dImUba3SDcaqfyWv2BWKRX4cPjLrur5zMbRc4UAEBYAxcPE4FIt2x7NzYvcYUZkFD97jc5Kxj3wj7jqmcvhrbVbG3S6fcPHpQM5WNDC7NVqS/8+JKJpDKq/s3maewmIfvU+aoEjuq5G1wmuxMmki4DSW/50HPAR5j93r+tBoLeAnpZv7Eq9huUDZ5UWwytcsgGRYAeI6xM0L1Rye7qAsX4Z1/b1xs6g1c+QWqANUbfsbteeTPuuhEfze2wlyJ+SPDhLYAg8ndvG6oaEop/bBM1OAOSJ7IhC09/7pFdtkS4pOlDPrTesyrXwCt97YddxtGsKWHZ94va8t73/zGYjxaFuu5ALOfCO+ooOSYikb1xPqX05MZUflndYXVvz+innLqx6upIYMoDtEC6pv2pBq8yEyi5Ot0er6afMmR3qLw19HeqAL9/TncmIFnhV6JuMgwxbzrGhhnnjsc19RIVHuehiEnzARLKcbGh+yfVlj5pi4VMfXVqZJpvxSqL5H5TAaf0fM3iMufQXHUMlFi7JF0DI3x5V1g9jeED+p7HF8IXTWu9HkYc4l9P3EC9vZViRHVl9HXaHAqhm9N7qvPA56vTdDU9eS5SoHFXtMlPvMQq598p58nNOkqw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(39860400002)(396003)(346002)(136003)(1800799009)(82310400011)(451199024)(186009)(46966006)(36840700001)(40470700004)(6666004)(54906003)(70586007)(70206006)(7696005)(2906002)(478600001)(1076003)(336012)(426003)(26005)(6916009)(5660300002)(2616005)(83380400001)(41300700001)(316002)(47076005)(36860700001)(8936002)(4326008)(82740400003)(8676002)(81166007)(356005)(40460700003)(36756003)(86362001)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 06:08:09.8854 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06f29197-9f94-4d7c-f783-08db9e1f2aa8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE32.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6996
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
DMUB subsystem was continuing to use compile time offset calculation for
register access. Switch this to runtime calculation to stay consistent
with rest of DC code.

To enable this, an additional interface init_reg_offsets() are added to
DMUB's hw_funcs struct. Asics with runtime register offset calculation
enabled shall populate this hook with a fn pointer that will invoke the
necessary macros to calculate the offset.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  5 +++
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |  4 ++-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn32.c | 34 +++++++++++--------
 .../gpu/drm/amd/display/dmub/src/dmub_dcn32.h | 10 +++---
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   |  3 ++
 5 files changed, 36 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 98aa7ee8acf8..e5a2ae53d80b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1068,6 +1068,7 @@ static int dm_dmub_hw_init(struct amdgpu_device *adev)
 	const struct firmware *dmub_fw = adev->dm.dmub_fw;
 	struct dmcu *dmcu = adev->dm.dc->res_pool->dmcu;
 	struct abm *abm = adev->dm.dc->res_pool->abm;
+	struct dc_context *ctx = adev->dm.dc->ctx;
 	struct dmub_srv_hw_params hw_params;
 	enum dmub_status status;
 	const unsigned char *fw_inst_const, *fw_bss_data;
@@ -1089,6 +1090,10 @@ static int dm_dmub_hw_init(struct amdgpu_device *adev)
 		return -EINVAL;
 	}
 
+	/* initialize register offsets for ASICs with runtime initialization available */
+	if (dmub_srv->hw_funcs.init_reg_offsets)
+		dmub_srv->hw_funcs.init_reg_offsets(dmub_srv, ctx);
+
 	status = dmub_srv_has_hw_support(dmub_srv, &has_hw_support);
 	if (status != DMUB_STATUS_OK) {
 		DRM_ERROR("Error checking HW support for DMUB: %d\n", status);
diff --git a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
index 2d995c87fbb9..43676c1c81d9 100644
--- a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
@@ -65,6 +65,7 @@
  */
 
 #include "inc/dmub_cmd.h"
+#include "dc/dc_types.h"
 
 #if defined(__cplusplus)
 extern "C" {
@@ -399,6 +400,7 @@ struct dmub_srv_hw_funcs {
 	void (*get_diagnostic_data)(struct dmub_srv *dmub, struct dmub_diagnostic_data *dmub_oca);
 
 	bool (*should_detect)(struct dmub_srv *dmub);
+	void (*init_reg_offsets)(struct dmub_srv *dmub, struct dc_context *ctx);
 };
 
 /**
@@ -438,7 +440,7 @@ struct dmub_srv {
 	/* private: internal use only */
 	const struct dmub_srv_common_regs *regs;
 	const struct dmub_srv_dcn31_regs *regs_dcn31;
-	const struct dmub_srv_dcn32_regs *regs_dcn32;
+	struct dmub_srv_dcn32_regs *regs_dcn32;
 
 	struct dmub_srv_base_funcs funcs;
 	struct dmub_srv_hw_funcs hw_funcs;
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.c
index bf5994e292d9..8f427047ac40 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.c
@@ -26,33 +26,39 @@
 #include "../dmub_srv.h"
 #include "dmub_reg.h"
 #include "dmub_dcn32.h"
+#include "dc/dc_types.h"
 
 #include "dcn/dcn_3_2_0_offset.h"
 #include "dcn/dcn_3_2_0_sh_mask.h"
 
 #define DCN_BASE__INST0_SEG2                       0x000034C0
 
-#define BASE_INNER(seg) DCN_BASE__INST0_SEG##seg
+#define BASE_INNER(seg) ctx->dcn_reg_offsets[seg]
 #define CTX dmub
 #define REGS dmub->regs_dcn32
-#define REG_OFFSET_EXP(reg_name) (BASE(reg##reg_name##_BASE_IDX) + reg##reg_name)
-
-const struct dmub_srv_dcn32_regs dmub_srv_dcn32_regs = {
-#define DMUB_SR(reg) REG_OFFSET_EXP(reg),
-	{
-		DMUB_DCN32_REGS()
-		DMCUB_INTERNAL_REGS()
-	},
+#define REG_OFFSET_EXP(reg_name) BASE(reg##reg_name##_BASE_IDX) + reg##reg_name
+
+void dmub_srv_dcn32_regs_init(struct dmub_srv *dmub,  struct dc_context *ctx)
+{
+	struct dmub_srv_dcn32_regs *regs = dmub->regs_dcn32;
+
+#define REG_STRUCT regs
+
+#define DMUB_SR(reg) REG_STRUCT->offset.reg = REG_OFFSET_EXP(reg);
+	DMUB_DCN32_REGS()
+	DMCUB_INTERNAL_REGS()
 #undef DMUB_SR
 
-#define DMUB_SF(reg, field) FD_MASK(reg, field),
-		{ DMUB_DCN32_FIELDS() },
+#define DMUB_SF(reg, field) REG_STRUCT->mask.reg##__##field = FD_MASK(reg, field);
+	DMUB_DCN32_FIELDS()
 #undef DMUB_SF
 
-#define DMUB_SF(reg, field) FD_SHIFT(reg, field),
-		{ DMUB_DCN32_FIELDS() },
+#define DMUB_SF(reg, field) REG_STRUCT->shift.reg##__##field = FD_SHIFT(reg, field);
+	DMUB_DCN32_FIELDS()
 #undef DMUB_SF
-};
+
+#undef REG_STRUCT
+}
 
 static void dmub_dcn32_get_fb_base_offset(struct dmub_srv *dmub,
 		uint64_t *fb_base,
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.h b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.h
index d58a1e4b9f1c..38e47065e00e 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.h
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn32.h
@@ -178,13 +178,11 @@ struct dmub_srv_dcn32_reg_mask {
 };
 
 struct dmub_srv_dcn32_regs {
-	const struct dmub_srv_dcn32_reg_offset offset;
-	const struct dmub_srv_dcn32_reg_mask mask;
-	const struct dmub_srv_dcn32_reg_shift shift;
+	struct dmub_srv_dcn32_reg_offset offset;
+	struct dmub_srv_dcn32_reg_mask mask;
+	struct dmub_srv_dcn32_reg_shift shift;
 };
 
-extern const struct dmub_srv_dcn32_regs dmub_srv_dcn32_regs;
-
 void dmub_dcn32_reset(struct dmub_srv *dmub);
 
 void dmub_dcn32_reset_release(struct dmub_srv *dmub);
@@ -256,4 +254,6 @@ void dmub_dcn32_send_inbox0_cmd(struct dmub_srv *dmub, union dmub_inbox0_data_re
 void dmub_dcn32_clear_inbox0_ack_register(struct dmub_srv *dmub);
 uint32_t dmub_dcn32_read_inbox0_ack_register(struct dmub_srv *dmub);
 
+void dmub_srv_dcn32_regs_init(struct dmub_srv *dmub, struct dc_context *ctx);
+
 #endif /* _DMUB_DCN32_H_ */
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
index 93624ffe4eb8..9780c157196c 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
@@ -78,6 +78,8 @@
 
 #define DMUB_REGION5_BASE (0xA0000000)
 
+static struct dmub_srv_dcn32_regs dmub_srv_dcn32_regs;
+
 static inline uint32_t dmub_align(uint32_t val, uint32_t factor)
 {
 	return (val + factor - 1) / factor * factor;
@@ -304,6 +306,7 @@ static bool dmub_srv_hw_setup(struct dmub_srv *dmub, enum dmub_asic asic)
 		funcs->set_outbox0_rptr = dmub_dcn32_set_outbox0_rptr;
 		funcs->get_current_time = dmub_dcn32_get_current_time;
 		funcs->get_diagnostic_data = dmub_dcn32_get_diagnostic_data;
+		funcs->init_reg_offsets = dmub_srv_dcn32_regs_init;
 
 		break;
 
-- 
2.37.3

