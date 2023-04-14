Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D5E4C77B71
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Apr 2023 15:54:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A7FFD10EDE2;
	Fri, 14 Apr 2023 15:54:48 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A944F10EDE5
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Apr 2023 15:54:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J73sKLjeTeNIQ5EFi0DDtJFxn3TAOxfQxEEkyW/hXYaEPuKPWVz09VrC525RWTy6f6T4ary32hxreFJN+mo7EnbcAqIHyvkoIZyixmQrgfXuzzIDrw0zkYArYSCMLTrVWCCMqAZ1jHyDaDEnj8QR1/dR+hj22+OSmY3CESEl/VG23+rUVJ92ahApjF9c1qZ61ZmexgR959A9fLiYQQHX6rSaC+OW3F8SRq/VFREYuf7QiO0aPURAGsu3w/hr2Zto9gW2EhS9dMagZaPCZMz1tqc+4BRpiwgQNOyy7VsqA20o7ch71VMtkxaLv15vaixosL4+DIKAgDVQ/4fNie+Tng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sZN2CAyqsChC4cP0TnMiGjPsH1aT9O8sXE2QZexgnjI=;
 b=Eq6ZrVp/5ZAp3RDvxsfwUYTNP7Is4XkqWTq3/rxphGIqXQLe1yVNmjuDWyBFnYCQrQLmDkmPiXLlRFw3uwR7dWfc93hP5RpuM1q3d1+livHl1ICZRJWIKPNDlRr3dQBDPMa8XvWwMMizlEi9Gx9F5gELtQe5NbBpal0LO5uJbnXRItpfRcrBrdU9Ran/vsGdYkEU0piRDNNMD/ZrVxmVssO/0P4q+BFqrCeLiPjWW1K1BALUVYbeKoghMhRxU8oADn2VHQAYwCzfuYoWk5450zF+p5Qn7HSnm+e1mntapQD39FBuiC68DLYa8m+uxdNPN0tmiUmaEaQ5cjzSb+5AWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sZN2CAyqsChC4cP0TnMiGjPsH1aT9O8sXE2QZexgnjI=;
 b=eOtGUSi0Gy93JVbrHDtoEe7B11vo1Zt/Hiu7z4w99FsjaTQjhQEptn2EbL7YLOzLyzCqKEBCi2DLfMOJnrANsbtiENVb7/5dVKR04AKkNN+7exxxcaELiOzEWjTc7iUguian5EA1KTGMLl48iUKAiFUYFNg0qRNy6lj2ePsFhAY=
Received: from BN9PR03CA0224.namprd03.prod.outlook.com (2603:10b6:408:f8::19)
 by CH2PR12MB4939.namprd12.prod.outlook.com (2603:10b6:610:61::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Fri, 14 Apr
 2023 15:54:43 +0000
Received: from BN8NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f8:cafe::71) by BN9PR03CA0224.outlook.office365.com
 (2603:10b6:408:f8::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.36 via Frontend
 Transport; Fri, 14 Apr 2023 15:54:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT052.mail.protection.outlook.com (10.13.177.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.37 via Frontend Transport; Fri, 14 Apr 2023 15:54:43 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 14 Apr
 2023 10:54:40 -0500
From: Qingqing Zhuo <Qingqing.Zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 37/66] drm/amd/display: add mechanism to skip DCN init
Date: Fri, 14 Apr 2023 11:53:01 -0400
Message-ID: <20230414155330.5215-38-Qingqing.Zhuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230414155330.5215-1-Qingqing.Zhuo@amd.com>
References: <20230414155330.5215-1-Qingqing.Zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT052:EE_|CH2PR12MB4939:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f5e089b-61cc-4476-3b5a-08db3d009032
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0wct03n1iAG8lH1HgeO+CzYc7VnvdLItRRRFfE22AsKg7XHUETQPWdec7lM+vBZpMzih4CRo/iLtySBC9cBW1TjWUcaf2zxFNt2NuBSUqzd3R41NSpvuNpadNKkGDSSArSJsNLqR5n0/zNdMGcl+p5HXolq/2pHvsl1hjF/LmCAxABJvKH4LDYaqwObJE+g0n8pMGFNw+GduCej8qZFSXrzTgLnktzz6lHDPXjJpSntuytjU7lYmAY4hBY6Kmru4kD/CBEHt1/dVjpALQcNM3njz3wJ+BxNUrPQNwk57QdRBjDX/fw4JiemowbCddkLcgxT5X1e//66vrmp0/L2q7QXQGvBpR0JMVhjWIiPzrIP2GWcfGIeI0Gse9g1Y2ItGW2WUEFCkbJxbN//B1WjfbCrRy+PJFuBDGrgMm88ijE0Ayc8sK8HOyjJ3WlYYtqgvAAwbUFZpeqWuPkG4xVaEpJ96NzzMPl8XsOS0dyQ49INt8AKfCzHlmAHw3O7JCWrmMATMkzH9a04VUabVX30RvMOlTrNis5+kgWsAQsYSDZMSN/KuelkzztJ/hRzh3sF4iUABSCxMIh/Ri1JXG/xRKFEtnl7Z/5gifekjJJ68TIrcLHrONnz/+eo6YNdy7OWd9pxiRUcF67FuXrWsYReV6D3N870XtwWmHll9sJCc3YoX0e7Vxh0+JtXeUU1bzvaDuOYpFhbxE0OIdAto8YYYvhnJ4Ids1f3HCb/pNuTw2NU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(376002)(396003)(39860400002)(136003)(451199021)(46966006)(36840700001)(40470700004)(82310400005)(83380400001)(82740400003)(16526019)(81166007)(40460700003)(356005)(54906003)(6666004)(41300700001)(6916009)(4326008)(316002)(86362001)(36756003)(478600001)(70206006)(186003)(70586007)(36860700001)(336012)(426003)(47076005)(40480700001)(26005)(8936002)(5660300002)(1076003)(2906002)(8676002)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2023 15:54:43.1093 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f5e089b-61cc-4476-3b5a-08db3d009032
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4939
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
Cc: stylon.wang@amd.com, Eric Yang <Eric.Yang2@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Eric Yang <Eric.Yang2@amd.com>

[Why]
If optimized init is done in FW. DCN init can be skipped in driver. This
need to be communicated between driver and fw and maintain backwards
compatibility.

[How]
Use DMUB scratch 0 bit 2 to indicate optimized init done in fw and
use DMUB scatch 4 bit 0 to indicate drive supports the optimized flow
so FW will perform it.

Signed-off-by: Eric Yang <Eric.Yang2@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  3 --
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  | 28 +++++--------------
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h  |  2 +-
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c |  4 ++-
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |  1 -
 .../gpu/drm/amd/display/dmub/src/dmub_dcn21.c |  6 ----
 .../gpu/drm/amd/display/dmub/src/dmub_dcn21.h |  4 ---
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   | 25 +----------------
 8 files changed, 12 insertions(+), 61 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index da6cf3ca372c..9304eb66a1af 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -4288,9 +4288,6 @@ void dc_set_power_state(
 
 		dc_z10_restore(dc);
 
-		if (dc->ctx->dmub_srv)
-			dc_dmub_srv_wait_phy_init(dc->ctx->dmub_srv);
-
 		dc->hwss.init_hw(dc);
 
 		if (dc->hwss.init_sys_ctx != NULL &&
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index eef43577508c..d15ec32243e2 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -179,31 +179,17 @@ bool dc_dmub_srv_cmd_run_list(struct dc_dmub_srv *dc_dmub_srv, unsigned int coun
 	return true;
 }
 
-void dc_dmub_srv_wait_phy_init(struct dc_dmub_srv *dc_dmub_srv)
+bool dc_dmub_srv_optimized_init_done(struct dc_dmub_srv *dc_dmub_srv)
 {
-	struct dmub_srv *dmub = dc_dmub_srv->dmub;
-	struct dc_context *dc_ctx = dc_dmub_srv->ctx;
-	enum dmub_status status;
-
-	for (;;) {
-		/* Wait up to a second for PHY init. */
-		status = dmub_srv_wait_for_phy_init(dmub, 1000000);
-		if (status == DMUB_STATUS_OK)
-			/* Initialization OK */
-			break;
+	struct dmub_srv *dmub;
+	union dmub_fw_boot_status status;
 
-		DC_ERROR("DMCUB PHY init failed: status=%d\n", status);
-		ASSERT(0);
+	if (!dc_dmub_srv || !dc_dmub_srv->dmub)
+		return false;
 
-		if (status != DMUB_STATUS_TIMEOUT)
-			/*
-			 * Server likely initialized or we don't have
-			 * DMCUB HW support - this won't end.
-			 */
-			break;
+	dmub = dc_dmub_srv->dmub;
 
-		/* Continue spinning so we don't hang the ASIC. */
-	}
+	return status.bits.optimized_init_done;
 }
 
 bool dc_dmub_srv_notify_stream_mask(struct dc_dmub_srv *dc_dmub_srv,
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
index 22f7b2704c8e..a5196a9292b3 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
@@ -54,7 +54,7 @@ struct dc_dmub_srv {
 
 void dc_dmub_srv_wait_idle(struct dc_dmub_srv *dc_dmub_srv);
 
-void dc_dmub_srv_wait_phy_init(struct dc_dmub_srv *dc_dmub_srv);
+bool dc_dmub_srv_optimized_init_done(struct dc_dmub_srv *dc_dmub_srv);
 
 bool dc_dmub_srv_cmd_run(struct dc_dmub_srv *dc_dmub_srv, union dmub_rb_cmd *cmd, enum dm_dmub_wait_type wait_type);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index 1c3b6f25a782..a7ad1d7bc43e 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -1524,7 +1524,9 @@ void dcn10_init_hw(struct dc *dc)
 	if (!dcb->funcs->is_accelerated_mode(dcb))
 		hws->funcs.disable_vga(dc->hwseq);
 
-	hws->funcs.bios_golden_init(dc);
+	if (!dc_dmub_srv_optimized_init_done(dc->ctx->dmub_srv))
+		hws->funcs.bios_golden_init(dc);
+
 
 	if (dc->ctx->dc_bios->fw_info_valid) {
 		res_pool->ref_clocks.xtalin_clock_inKhz =
diff --git a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
index ba1715e2d25a..719bf9bb168a 100644
--- a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
@@ -366,7 +366,6 @@ struct dmub_srv_hw_funcs {
 
 	bool (*is_hw_init)(struct dmub_srv *dmub);
 
-	bool (*is_phy_init)(struct dmub_srv *dmub);
 	void (*enable_dmub_boot_options)(struct dmub_srv *dmub,
 				const struct dmub_srv_hw_params *params);
 
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn21.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn21.c
index 51bb9bceb1b1..2d212bc974cc 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn21.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn21.c
@@ -54,9 +54,3 @@ const struct dmub_srv_common_regs dmub_srv_dcn21_regs = {
 #undef DMUB_SF
 };
 
-/* Shared functions. */
-
-bool dmub_dcn21_is_phy_init(struct dmub_srv *dmub)
-{
-	return REG_READ(DMCUB_SCRATCH10) == 0;
-}
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn21.h b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn21.h
index 6fd5b0cd4ef3..8c4033ae4007 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn21.h
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn21.h
@@ -32,8 +32,4 @@
 
 extern const struct dmub_srv_common_regs dmub_srv_dcn21_regs;
 
-/* Hardware functions. */
-
-bool dmub_dcn21_is_phy_init(struct dmub_srv *dmub);
-
 #endif /* _DMUB_DCN21_H_ */
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
index 92c18bfb98b3..67c53f7e589c 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
@@ -190,11 +190,9 @@ static bool dmub_srv_hw_setup(struct dmub_srv *dmub, enum dmub_asic asic)
 
 		funcs->get_diagnostic_data = dmub_dcn20_get_diagnostic_data;
 
-		if (asic == DMUB_ASIC_DCN21) {
+		if (asic == DMUB_ASIC_DCN21)
 			dmub->regs = &dmub_srv_dcn21_regs;
 
-			funcs->is_phy_init = dmub_dcn21_is_phy_init;
-		}
 		if (asic == DMUB_ASIC_DCN30) {
 			dmub->regs = &dmub_srv_dcn30_regs;
 
@@ -721,27 +719,6 @@ enum dmub_status dmub_srv_wait_for_auto_load(struct dmub_srv *dmub,
 	return DMUB_STATUS_TIMEOUT;
 }
 
-enum dmub_status dmub_srv_wait_for_phy_init(struct dmub_srv *dmub,
-					    uint32_t timeout_us)
-{
-	uint32_t i = 0;
-
-	if (!dmub->hw_init)
-		return DMUB_STATUS_INVALID;
-
-	if (!dmub->hw_funcs.is_phy_init)
-		return DMUB_STATUS_OK;
-
-	for (i = 0; i <= timeout_us; i += 10) {
-		if (dmub->hw_funcs.is_phy_init(dmub))
-			return DMUB_STATUS_OK;
-
-		udelay(10);
-	}
-
-	return DMUB_STATUS_TIMEOUT;
-}
-
 enum dmub_status dmub_srv_wait_for_idle(struct dmub_srv *dmub,
 					uint32_t timeout_us)
 {
-- 
2.34.1

