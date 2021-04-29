Return-Path: <SRS0=oJVB=J2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4611AC433B4
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 07:54:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C7635613F7
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 07:54:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7635613F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B66F6ED80;
	Thu, 29 Apr 2021 07:54:26 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2078.outbound.protection.outlook.com [40.107.244.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B523B6ED7D
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Apr 2021 07:54:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CkQCF5HTEu25IBAAQFWC+QgX2++1pWiNVoUFrKSidHQ4YtoPdhwEMGEyF6zqlWgxX3RcAvIPelxx+uqgfraeUbfis7HvlPHYCYU0VOunY5GKOInKFI+8aWVWGbK+j9p5sDP2gbs7Sb6JrIbpKEAAriNwvmuPzuYaKfo9z7CvzYS5PVqtGn8H38FqFBzGBwBPcqn045L15MT7Ix+GrPi026XkHE01HzHdoQ96yJbQazNLbuerjksMobfzVFtwaWz4QaI0kPM1lChNksmKIctDPKFzKNjivAZXuuhhyQ2PrxEa1IfLqyTuVjFCJmaHwj91LSZZVDz7Xvkpf4PTqdND0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oewogfqVgso1GJMNf8qhG/iO0vaqofB4lftPou9JFR0=;
 b=AahCsxmVQE1xn0LAIgMpva5CJPTJAT83qC0vMua2zVNC0Iee4fzsmHEueAN4dOu91qklE8fURPmnZo3Q5xewzZL1SFyBIbucUc0tK7+EKLJ9rPT8o+hjvAgPZAO293WBCcbueWPqrBSsz097u3KorsjSUEqdbZRIF5i+2dk4FnUcezBZ3ZcbpXuRlXswPWUf8OxcDARXH9mZWdSN5A6GY+BDmUpVzOaFXNqV7vhZELVBoLCu8bgoxFG2PlHWlesbD+iZEM8Tfw+N/QrelaPs0su96bOBDi3SN/EToliwH7BAaKwsnm7olfFwbxBuv9QHIFEnTI8nikWCKU4oXKFPcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oewogfqVgso1GJMNf8qhG/iO0vaqofB4lftPou9JFR0=;
 b=3y71Y6zukCEmrFAeY9R4Pq3djtZxWnD1y6kKRmvUpfJp7zHVDXJc3dZyKOK5MS1bC4Gwo1ASZE7F9IZBtOxT46MRw1CCxWrgw+wlBdJj2O0LCHILnF7wXOaLjCO2gD8SaMHUn6sj7O9cgsH+HITlgarvhI7pFopUUyakBj4hUH8=
Received: from DM5PR04CA0029.namprd04.prod.outlook.com (2603:10b6:3:12b::15)
 by MN2PR12MB4438.namprd12.prod.outlook.com (2603:10b6:208:267::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Thu, 29 Apr
 2021 07:54:21 +0000
Received: from DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:12b:cafe::f2) by DM5PR04CA0029.outlook.office365.com
 (2603:10b6:3:12b::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.31 via Frontend
 Transport; Thu, 29 Apr 2021 07:54:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT029.mail.protection.outlook.com (10.13.173.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4087.32 via Frontend Transport; Thu, 29 Apr 2021 07:54:21 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 29 Apr
 2021 02:54:20 -0500
Received: from wayne-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2242.4
 via Frontend Transport; Thu, 29 Apr 2021 02:54:18 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 04/14] drm/amd/display: Extend DMUB HW params to allow DM to
 specify boot options
Date: Thu, 29 Apr 2021 15:51:56 +0800
Message-ID: <20210429075206.15974-5-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210429075206.15974-1-Wayne.Lin@amd.com>
References: <20210429075206.15974-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 10243cff-d2cd-4e03-8038-08d90ae3ffe8
X-MS-TrafficTypeDiagnostic: MN2PR12MB4438:
X-Microsoft-Antispam-PRVS: <MN2PR12MB4438B1D2EC4670CF493D8CD1FC5F9@MN2PR12MB4438.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p1a1atrGcR5NcpGeHnW2GnEQ42jngaBy/GAEXW2nMH7Wd7ezLoX57u6V6UI7xlzCYlb/lmH03yO7MFLc60QdlMpFmFCtJA4LMRNQUl7GMcR/X2Ac43zrXS2aCiMqitYRXiAhsfFY+yic6EfmlJPyJDmHzJXqfwm3eNSAI7SWHh2oQCHRFSHJu0PzBxcBMpL9i0Pw7Y6b9qlf4q2A8oD8sWY5tvgtchM0vNbRj1wyxfqIkxK3VlgmXjZfKhmiFtN61dospKKoeDoYwqtWVo+CWqAWZw4KEJ8xWbhB1eSbHu7bbQz6B95r1dcTLCCxbFkbukotzeinTrROn2V7998WSYFEXwvlD73EartRlM6hClKKvMNE0epHh6V+31HIqFsP+LalYa4wi8+rG4Kfl3kMyEaUssCPhOqkE/BPdV/lYOF7uYs59dTtu2UuTPTHktuUUi4jYvSDcZnTk7OTniNVhOKqOu8CZCUeLQPzhrvwgy/WtGV4X//cW7o+O0QAcr7u6f+w/aj8lxOHdRnRdepX7SoeHeGRXSzzafMtQkiurnaZsvgL84LmVPTLRY/r6R80yaty2dxpZQBwQ67rbdgnEYqRLK8sxq4dvpIKAiw4Ce8bbeGh4ru0gTKvejMEu9CAGAm/PEQxeQgJFGqNVWEiq43oia4JOxeqQwri973zrTG1IuaegzH8Amak5o51DVe5
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(346002)(376002)(39860400002)(136003)(46966006)(36840700001)(356005)(26005)(86362001)(336012)(82310400003)(8676002)(1076003)(83380400001)(70586007)(70206006)(54906003)(316002)(8936002)(2906002)(426003)(36860700001)(81166007)(36756003)(6666004)(5660300002)(2616005)(47076005)(186003)(478600001)(4326008)(82740400003)(7696005)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2021 07:54:21.6007 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 10243cff-d2cd-4e03-8038-08d90ae3ffe8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4438
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
Cc: Eric Yang <Eric.Yang2@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Eric Yang <Eric.Yang2@amd.com>

[Why & How]
Add the field to HW params to allow DM dynamically pass down debug and
boot options as needed.

Signed-off-by: Eric Yang <Eric.Yang2@amd.com>
Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Wayne Lin <Wayne.Lin@amd.com>
---
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   | 37 ++++++++++---------
 .../gpu/drm/amd/display/dmub/src/dmub_dcn20.c |  2 +-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn20.h |  2 +-
 .../gpu/drm/amd/display/dmub/src/dmub_srv.c   |  4 ++
 4 files changed, 25 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
index b4e14960b164..3ef6b536ccea 100644
--- a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
@@ -216,6 +216,23 @@ struct dmub_srv_fb_info {
 	struct dmub_fb fb[DMUB_WINDOW_TOTAL];
 };
 
+/*
+ * struct dmub_srv_hw_params - params for dmub hardware initialization
+ * @fb: framebuffer info for each region
+ * @fb_base: base of the framebuffer aperture
+ * @fb_offset: offset of the framebuffer aperture
+ * @psp_version: psp version to pass for DMCU init
+ * @load_inst_const: true if DMUB should load inst const fw
+ */
+struct dmub_srv_hw_params {
+	struct dmub_fb *fb[DMUB_WINDOW_TOTAL];
+	uint64_t fb_base;
+	uint64_t fb_offset;
+	uint32_t psp_version;
+	bool load_inst_const;
+	bool skip_panel_power_sequence;
+};
+
 /**
  * struct dmub_srv_base_funcs - Driver specific base callbacks
  */
@@ -290,7 +307,8 @@ struct dmub_srv_hw_funcs {
 	bool (*is_hw_init)(struct dmub_srv *dmub);
 
 	bool (*is_phy_init)(struct dmub_srv *dmub);
-	void (*enable_dmub_boot_options)(struct dmub_srv *dmub);
+	void (*enable_dmub_boot_options)(struct dmub_srv *dmub,
+				const struct dmub_srv_hw_params *params);
 
 	void (*skip_dmub_panel_power_sequence)(struct dmub_srv *dmub, bool skip);
 
@@ -325,23 +343,6 @@ struct dmub_srv_create_params {
 	bool is_virtual;
 };
 
-/*
- * struct dmub_srv_hw_params - params for dmub hardware initialization
- * @fb: framebuffer info for each region
- * @fb_base: base of the framebuffer aperture
- * @fb_offset: offset of the framebuffer aperture
- * @psp_version: psp version to pass for DMCU init
- * @load_inst_const: true if DMUB should load inst const fw
- */
-struct dmub_srv_hw_params {
-	struct dmub_fb *fb[DMUB_WINDOW_TOTAL];
-	uint64_t fb_base;
-	uint64_t fb_offset;
-	uint32_t psp_version;
-	bool load_inst_const;
-	bool skip_panel_power_sequence;
-};
-
 /**
  * struct dmub_srv - software state for dmcub
  * @asic: dmub asic identifier
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c
index 6934906c665e..b11f530f682c 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.c
@@ -385,7 +385,7 @@ union dmub_fw_boot_status dmub_dcn20_get_fw_boot_status(struct dmub_srv *dmub)
 	return status;
 }
 
-void dmub_dcn20_enable_dmub_boot_options(struct dmub_srv *dmub)
+void dmub_dcn20_enable_dmub_boot_options(struct dmub_srv *dmub, const struct dmub_srv_hw_params *params)
 {
 	union dmub_fw_boot_options boot_options = {0};
 
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.h b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.h
index de5351cd5abc..42d610a260ef 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.h
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn20.h
@@ -221,7 +221,7 @@ bool dmub_dcn20_is_gpint_acked(struct dmub_srv *dmub,
 
 uint32_t dmub_dcn20_get_gpint_response(struct dmub_srv *dmub);
 
-void dmub_dcn20_enable_dmub_boot_options(struct dmub_srv *dmub);
+void dmub_dcn20_enable_dmub_boot_options(struct dmub_srv *dmub, const struct dmub_srv_hw_params *params);
 
 void dmub_dcn20_skip_dmub_panel_power_sequence(struct dmub_srv *dmub, bool skip);
 
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
index 1cbb125b4063..ed9fa6138aa6 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
@@ -514,6 +514,10 @@ enum dmub_status dmub_srv_hw_init(struct dmub_srv *dmub,
 	outbox0_rb_params.capacity = tracebuff_fb->size - dmub_align(TRACE_BUFFER_ENTRY_OFFSET, 64);
 	dmub_rb_init(&dmub->outbox0_rb, &outbox0_rb_params);
 
+	/* Report to DMUB what features are supported by current driver */
+	if (dmub->hw_funcs.enable_dmub_boot_options)
+		dmub->hw_funcs.enable_dmub_boot_options(dmub, params);
+
 	if (dmub->hw_funcs.reset_release)
 		dmub->hw_funcs.reset_release(dmub);
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
