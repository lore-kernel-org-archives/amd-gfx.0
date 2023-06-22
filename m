Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B92CDEB64DA
	for <amd-gfx@archiver.kernel.org>; Thu, 22 Jun 2023 18:25:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF4D410E09F;
	Thu, 22 Jun 2023 18:25:27 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8AB210E09D
 for <amd-gfx@lists.freedesktop.org>; Thu, 22 Jun 2023 18:25:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nK+8jxL+FdGtrVMq181DUtYIMyL/PcNu++7PMNTT8TE6UvEox5scshxEZvERxQIXxNg7LXEGlsmgE2DgwEDKvqFWttgVHiN39Q3H0ISzBQf8wp/dmFhmqae8Cba/QZVGCq4GayuJuMaPsrh77BZbMp6SqNshAzxcfSwquypRLT/SOIIW0hSJ3s/dgrI0rYwfm1jMfymboCdHtFv7jzVvgqF6fdVNN2JFSbv8cGbkEva154YVjviM9vweDH6q4yHJjPx0+C0URG44Vtg/hleP1zuxnV7K8VP2kWOYC9DM4lPjmLd/CHAA53l4zjyTaPGIeWO+AuuiZb0LYwtmvOP93g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HXlEX+AfXBYJ2066MWaPOYyPXhf6LC0o+NMJAHPHg98=;
 b=hhxvWJ3po4+DVhs++37wPMQsa/LS4+JsEVQoUMf0xM2J0wmlyru4cxHTdJGbgSw6RSd2rJBGOW5BmkYtYge8649kqVmTQX+T2S+YYKrgxcbzLhauxUq/4dxxdXu73Ii4TXvxneDLGGJWD4FrfTND6UluKLreqLGtJmulbdqGPtLAsklljk2usQBxmBUYvIuIONpenQmSPhwE7ERJGi6xKLpKMmiXxnZQfziQYzpAdyY8/fuZcJxUTiGgaeacBy2WdkkUPQit9pP3pCYWbAw0UGO6fIXoKBGsyt9DLUFWBDK8n6ZIQ2Pm1znwl8rzpZc7TLU6Dyf4w8BFXBzzvOhAdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HXlEX+AfXBYJ2066MWaPOYyPXhf6LC0o+NMJAHPHg98=;
 b=PxzE5f/aV1D7Kr31trpEjjXryIfwFZGZNyV//12YyThreAKM7HOPwNu0aBY1Q9OEZnm6YbzmQV9hszNQ8D7Z9fjn44QtxpS6C3TRpWWUGJRzgG0ZS4Nnh0RzkZGDrpCOlIXXv1zUSTfRS5t2oY/W8iMWqj6cucyqnh4aihMu53w=
Received: from MW4PR03CA0316.namprd03.prod.outlook.com (2603:10b6:303:dd::21)
 by CY8PR12MB7540.namprd12.prod.outlook.com (2603:10b6:930:97::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 22 Jun
 2023 18:25:24 +0000
Received: from MWH0EPF000989E9.namprd02.prod.outlook.com
 (2603:10b6:303:dd:cafe::1) by MW4PR03CA0316.outlook.office365.com
 (2603:10b6:303:dd::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24 via Frontend
 Transport; Thu, 22 Jun 2023 18:25:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E9.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.17 via Frontend Transport; Thu, 22 Jun 2023 18:25:23 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 22 Jun
 2023 13:25:22 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/4] drm/amd/display: Set minimum requirement for using PSR-SU
 on Rembrandt
Date: Thu, 22 Jun 2023 13:25:05 -0500
Message-ID: <20230622182507.25531-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230622182507.25531-1-mario.limonciello@amd.com>
References: <20230622182507.25531-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E9:EE_|CY8PR12MB7540:EE_
X-MS-Office365-Filtering-Correlation-Id: c316bd67-d87f-4955-8a00-08db734e0b89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vGvSGLsIiSZ8If8nW1A2gP3a9pq1dJgnFGn0L1l2qmVK3/Fcody1fRKoEPrZ5UwgOwiRd+tn4ygaWaOnd5CDD+mQPE5wrWti/BfKC0X91ra36zN2Lo6AulB+wsWQLvIW0sFmYMLFQhIr8frWuPZs26nSx7btH4N+M0UmWvTOCYXalJ2OoWc/Z0Ruq6CFkEz0vNJL1ZDYrlCjk+n3rZ7XGLgCYsLWeimPduvvokC9Fp+voJowq69mMcf+j4PGYjy2LCWVzD1ZEyBxq4ludvUWcGZiezQIgp+35HWCv1IsgHKIhoLk4KsnPCb7hdjESZmzE0/7bZOSsLs9Hzc4U4vjQQvYSzaVgSYl0V9Y5gDkaLWLNuLuqXm/ofH3ojWWjd1pLcqyKiwlZ3QQHklC1vqF7HaR+y5P3L9eLTbNrStWEbfcHp/mCbBZbBTqOQ0DBl1CHvV9Ub9Trw1eGILiwMqVniALNExjK9wF6YVT5JtK8uUZsODQvEMyuJpQ9T9H8eT1zQE3VaLmfBeBv/JgaGLnNV5LFiWxOMVf/bh4fu2T2e5u1kL2kI7dl2jUq461PcPi+qDuJJMYa9z0sZBaxqX90+FDwKWvk2GUkXGCKw1vykflquxuUhxVRtlq5Cf0AWSiIQN/fHCDxMjQ9wqcuevk5uAPpkuikYIRb1LVKH3SqMlXH7zDHIo9JZhi2ls8JXwCKVhGR8uXUkPyE9fp/QmPV/JnQZpNEqmHrvoI2bioCmVKdzLcfm3mLCik+gKp/Vbw
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(396003)(39860400002)(346002)(136003)(451199021)(46966006)(40470700004)(36840700001)(44832011)(966005)(40480700001)(47076005)(5660300002)(2906002)(1076003)(26005)(8676002)(16526019)(8936002)(186003)(40460700003)(41300700001)(2616005)(426003)(336012)(83380400001)(36756003)(356005)(82310400005)(478600001)(82740400003)(81166007)(7696005)(36860700001)(86362001)(70586007)(70206006)(316002)(4326008)(6916009)(54906003)(6666004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 18:25:23.9544 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c316bd67-d87f-4955-8a00-08db734e0b89
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7540
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
Cc: Tsung-hua Lin <Tsung-hua.Lin@amd.com>, Marc Rossi <Marc.Rossi@amd.com>,
 Sean Wang <sean.ns.wang@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Hamza Mahfooz <Hamza.Mahfooz@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

A number of parade TCONs are causing system hangs when utilized with
older DMUB firmware and PSR-SU. Some changes have been introduced into
DMUB firmware to add resilience against these failures.

Don't allow running PSR-SU unless on the newer firmware.

Cc: Sean Wang <sean.ns.wang@amd.com>
Cc: Marc Rossi <Marc.Rossi@amd.com>
Cc: Hamza Mahfooz <Hamza.Mahfooz@amd.com>
Cc: Tsung-hua (Ryan) Lin <Tsung-hua.Lin@amd.com>
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2443
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c |  3 ++-
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c          |  7 +++++++
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h          |  1 +
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h           |  2 ++
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c     |  5 +++++
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.h     |  2 ++
 drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c       | 10 ++++++----
 7 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
index d647f68fd563..4f61d4f257cd 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.c
@@ -24,6 +24,7 @@
  */
 
 #include "amdgpu_dm_psr.h"
+#include "dc_dmub_srv.h"
 #include "dc.h"
 #include "dm_helpers.h"
 #include "amdgpu_dm.h"
@@ -50,7 +51,7 @@ static bool link_supports_psrsu(struct dc_link *link)
 	    !link->dpcd_caps.psr_info.psr2_su_y_granularity_cap)
 		return false;
 
-	return true;
+	return dc_dmub_check_min_version(dc->ctx->dmub_srv->dmub);
 }
 
 /*
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index c52c40b16387..c753c6f30dd7 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -1011,3 +1011,10 @@ void dc_send_update_cursor_info_to_dmu(
 		dm_execute_dmub_cmd_list(pCtx->stream->ctx, 2, cmd, DM_DMUB_WAIT_TYPE_WAIT);
 	}
 }
+
+bool dc_dmub_check_min_version(struct dmub_srv *srv)
+{
+	if (!srv->hw_funcs.is_psrsu_supported)
+		return true;
+	return srv->hw_funcs.is_psrsu_supported(srv);
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
index a5196a9292b3..099f94b6107c 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
@@ -86,4 +86,5 @@ void dc_dmub_setup_subvp_dmub_command(struct dc *dc, struct dc_state *context, b
 void dc_dmub_srv_log_diagnostic_data(struct dc_dmub_srv *dc_dmub_srv);
 
 void dc_send_update_cursor_info_to_dmu(struct pipe_ctx *pCtx, uint8_t pipe_idx);
+bool dc_dmub_check_min_version(struct dmub_srv *srv);
 #endif /* _DMUB_DC_SRV_H_ */
diff --git a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
index 2a66a305679a..4585e0419da6 100644
--- a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
@@ -367,6 +367,8 @@ struct dmub_srv_hw_funcs {
 
 	bool (*is_supported)(struct dmub_srv *dmub);
 
+	bool (*is_psrsu_supported)(struct dmub_srv *dmub);
+
 	bool (*is_hw_init)(struct dmub_srv *dmub);
 
 	void (*enable_dmub_boot_options)(struct dmub_srv *dmub,
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c
index ebf7aeec4029..c8445d474107 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c
@@ -302,6 +302,11 @@ bool dmub_dcn31_is_supported(struct dmub_srv *dmub)
 	return supported;
 }
 
+bool dmub_dcn31_is_psrsu_supported(struct dmub_srv *dmub)
+{
+	return dmub->fw_version >= DMUB_FW_VERSION(4, 0, 58);
+}
+
 void dmub_dcn31_set_gpint(struct dmub_srv *dmub,
 			  union dmub_gpint_data_register reg)
 {
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.h b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.h
index 7d5c10ee539b..89c5a948b67d 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.h
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.h
@@ -221,6 +221,8 @@ bool dmub_dcn31_is_hw_init(struct dmub_srv *dmub);
 
 bool dmub_dcn31_is_supported(struct dmub_srv *dmub);
 
+bool dmub_dcn31_is_psrsu_supported(struct dmub_srv *dmub);
+
 void dmub_dcn31_set_gpint(struct dmub_srv *dmub,
 			  union dmub_gpint_data_register reg);
 
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
index 9e9a6a44a7ac..fd5b043dd32d 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
@@ -226,14 +226,16 @@ static bool dmub_srv_hw_setup(struct dmub_srv *dmub, enum dmub_asic asic)
 	case DMUB_ASIC_DCN314:
 	case DMUB_ASIC_DCN315:
 	case DMUB_ASIC_DCN316:
-		if (asic == DMUB_ASIC_DCN314)
+		if (asic == DMUB_ASIC_DCN314) {
 			dmub->regs_dcn31 = &dmub_srv_dcn314_regs;
-		else if (asic == DMUB_ASIC_DCN315)
+			funcs->is_psrsu_supported = dmub_dcn314_is_psrsu_supported;
+		} else if (asic == DMUB_ASIC_DCN315) {
 			dmub->regs_dcn31 = &dmub_srv_dcn315_regs;
-		else if (asic == DMUB_ASIC_DCN316)
+		} else if (asic == DMUB_ASIC_DCN316) {
 			dmub->regs_dcn31 = &dmub_srv_dcn316_regs;
-		else
+		} else {
 			dmub->regs_dcn31 = &dmub_srv_dcn31_regs;
+		}
 		funcs->reset = dmub_dcn31_reset;
 		funcs->reset_release = dmub_dcn31_reset_release;
 		funcs->backdoor_load = dmub_dcn31_backdoor_load;
-- 
2.34.1

