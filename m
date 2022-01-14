Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F41F7C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Jan 2022 01:37:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70FE810EAEE;
	Fri, 14 Jan 2022 01:37:36 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2076.outbound.protection.outlook.com [40.107.93.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A45710EAEE
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Jan 2022 01:37:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A7jD14mdEdatxoydgowKKPfav81xtXUs8CebZqr6WeXl+YcSXxUvkNkpEX0fOx7RKSh/6JhCNXtqqnLGufKjm04eSRAeuAhoVKbEG11WIx0Lvq+xkuNmCcfpa8ahWlUK1FKdY/CH5uoWMON/0wxVVJdpAUZdxKae4Nz37NdhMoItnp81LaBqSOU+JDndCMZhBVE0iFgB7TOkRK328keN03wiZqS8rTBzrjhVzYhScDvvDW447OMO4uAasN3Vsh2oBZEbj2icyLOXdjGOyMlim9XaaeFyUmALhOcRu/c0UEDatD8Qji6ZgOBsLARm62R/CzpG6MLjYJyMjLj9hl0jag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8y61LH0ZKqyM4JclZ0wKRXZr4ycaC136W7GBUEtAv7c=;
 b=DCLhCtOQzrkcq21fLhtLo3ejLJMK7ztKcQRRbMCPqyVZR7kgr5R2LskErNIs0mVuoD/po8rfTx8XbDEFVIrkktsN4wH0q47z6ijxZsuxZjIN/P/ZBmTv3Q9cHhVUUlENic1JqGqFsqh+Lx05SurMkoC2IH5L74bpyrtP+OBPtQQwqy15qCeqf30a5wxQuW7iiCTktqLWPQhbg8Lb+gTq9X8mjm5Y0we6QkxTc1Ew7Qt/aBkKdQVzkL0aclOh2LwlAw+Z6ttsw+VAl0amLKJhtVrVAJj1lScMubXk9Q7PrtgQ2HMBi7/ZjE3VlUFXJ7JX45GFKNPk46cAyi0Aq9PtPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8y61LH0ZKqyM4JclZ0wKRXZr4ycaC136W7GBUEtAv7c=;
 b=NzyvqVcDgc0iId+5r0FadRmk/t2FPYRUETGtopv82fMQ1kZ8u9tFc9REr14XVCYhMW7gvEhIda1U79mE51IXjdRNRcLEuMpwhJFWF7+c2nupbijB2juXFzyiRrhTS7xvVie/uYOxABVXpyseaWTrEgkpiX/R2+ra+S2Y/HZPfs0=
Received: from BN9PR03CA0867.namprd03.prod.outlook.com (2603:10b6:408:13d::32)
 by DM6PR12MB3673.namprd12.prod.outlook.com (2603:10b6:5:1c5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.12; Fri, 14 Jan
 2022 01:37:32 +0000
Received: from BN8NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13d:cafe::3c) by BN9PR03CA0867.outlook.office365.com
 (2603:10b6:408:13d::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.10 via Frontend
 Transport; Fri, 14 Jan 2022 01:37:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT056.mail.protection.outlook.com (10.13.177.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4888.9 via Frontend Transport; Fri, 14 Jan 2022 01:37:32 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 13 Jan
 2022 19:37:31 -0600
Received: from wayne-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.17
 via Frontend Transport; Thu, 13 Jan 2022 19:37:27 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 04/13] drm/amd/display: support new PMFW interface to disable
 Z9 only
Date: Fri, 14 Jan 2022 09:36:48 +0800
Message-ID: <20220114013657.3119627-5-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220114013657.3119627-1-Wayne.Lin@amd.com>
References: <20220114013657.3119627-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2617ea31-f6cc-467f-448a-08d9d6fe6f24
X-MS-TrafficTypeDiagnostic: DM6PR12MB3673:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB3673E030C54E7695B3CEDEBFFC549@DM6PR12MB3673.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TbElqrwbv+5lXEByeCFkQKAF7kG1iFu4S8MnPVGISr4J8mY8hGfIkLMtmSt5tOkBUuNsyyDJXIgFWifuEJp7MiD+3deQ6qwjtPodowENwRQmkn+iPzCQWfxLh3PHom/lGT1brF4ltCcH0tYt9S3kzi0MntxdcqN/U7FuHfQHjUcENnpfV+N9zj+530yUUOw0qVPQD8v9vLchyuNPdGeZAxL+6RrkM75KZIG78hl3+0ttS7zfooXRxY0WY6vU7zNKEslzeX3B+X6cldiYKTA/6vRXJMXmSMQ4T/3m+TENdsX3oBli0FKggVsqnPC4KveZC2pRONhjT2ryk5aHQLQGlMHiX2Y2SS2wDR30wdx5q/pvuDGLXrmvhhW3acNDbsToLm0QUEdtxI/j73Y2Dw3ltqBSBapLB2KDLvcQWP/Zbn51TNo7Sy0Y6QXAJVZPTqDpFg52NYFaNkw5qoc8LwgIappqwPSln6M1mSOUp2Rxg6z89ZBe8kdwUCh7kHqh+eeZhBhOZCE3gVSNZnNfFXWiLdxXJ/8G4Clgy/GpUIz3S31XLln7Q0rc/PhRrkVR7LGzZXxUdCmjItJQBZ9yO4rKk29FNLZwowrDEKHhsEJs21d9yBreEr8mDBs/TM4Ni10Qz+tB7qkemGeyvHG83TtHxefwF6nOwJvpexCpeISTiI7MwLbDH8r6w5QBBRuFVPVxRpIchc+8eEjI6m1GvuwOqt5wwQUbUmEHCGThzhsnztEQV9Y4lTETRwltgzlX3iQU31LCZRWprH035z9Zst8996pOxTZYTCYQxQ2pwt9sUvU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(40470700002)(36840700001)(82310400004)(4326008)(81166007)(6916009)(54906003)(186003)(6666004)(7696005)(26005)(426003)(8676002)(2616005)(8936002)(356005)(36860700001)(316002)(40460700001)(83380400001)(47076005)(70586007)(336012)(508600001)(2906002)(5660300002)(86362001)(1076003)(36756003)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2022 01:37:32.4008 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2617ea31-f6cc-467f-448a-08d9d6fe6f24
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3673
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
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Eric Yang <Eric.Yang2@amd.com>

[Why]
Need to disable Z9 on configurations that only support Z10

[How]
Support new PMFW interface to disable Z9

Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Eric Yang <Eric.Yang2@amd.com>
---
 .../amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c  |  6 +++---
 .../drm/amd/display/dc/clk_mgr/dcn31/dcn31_smu.c  | 15 ++++++++++-----
 .../drm/amd/display/dc/clk_mgr/dcn31/dcn31_smu.h  |  2 +-
 drivers/gpu/drm/amd/display/dc/dc.h               |  1 +
 .../gpu/drm/amd/display/dc/dcn20/dcn20_resource.c |  8 +++++++-
 5 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c
index 4162ce40089b..66bd0261ead6 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_clk_mgr.c
@@ -139,9 +139,9 @@ void dcn31_update_clocks(struct clk_mgr *clk_mgr_base,
 	 * also if safe to lower is false, we just go in the higher state
 	 */
 	if (safe_to_lower) {
-		if (new_clocks->zstate_support == DCN_ZSTATE_SUPPORT_ALLOW &&
+		if (new_clocks->zstate_support != DCN_ZSTATE_SUPPORT_DISALLOW &&
 				new_clocks->zstate_support != clk_mgr_base->clks.zstate_support) {
-			dcn31_smu_set_Z9_support(clk_mgr, true);
+			dcn31_smu_set_zstate_support(clk_mgr, new_clocks->zstate_support);
 			dm_helpers_enable_periodic_detection(clk_mgr_base->ctx, true);
 			clk_mgr_base->clks.zstate_support = new_clocks->zstate_support;
 		}
@@ -167,7 +167,7 @@ void dcn31_update_clocks(struct clk_mgr *clk_mgr_base,
 	} else {
 		if (new_clocks->zstate_support == DCN_ZSTATE_SUPPORT_DISALLOW &&
 				new_clocks->zstate_support != clk_mgr_base->clks.zstate_support) {
-			dcn31_smu_set_Z9_support(clk_mgr, false);
+			dcn31_smu_set_zstate_support(clk_mgr, DCN_ZSTATE_SUPPORT_DISALLOW);
 			dm_helpers_enable_periodic_detection(clk_mgr_base->ctx, false);
 			clk_mgr_base->clks.zstate_support = new_clocks->zstate_support;
 		}
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_smu.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_smu.c
index a1011f3273f3..1c0415366216 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_smu.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_smu.c
@@ -306,23 +306,28 @@ void dcn31_smu_transfer_wm_table_dram_2_smu(struct clk_mgr_internal *clk_mgr)
 			VBIOSSMC_MSG_TransferTableDram2Smu, TABLE_WATERMARKS);
 }
 
-void dcn31_smu_set_Z9_support(struct clk_mgr_internal *clk_mgr, bool support)
+void dcn31_smu_set_zstate_support(struct clk_mgr_internal *clk_mgr, enum dcn_zstate_support_state support)
 {
 	//TODO: Work with smu team to define optimization options.
-	unsigned int msg_id;
+	unsigned int msg_id, param;
 
 	if (!clk_mgr->smu_present)
 		return;
 
-	if (support)
-		msg_id = VBIOSSMC_MSG_AllowZstatesEntry;
+	if (support == DCN_ZSTATE_SUPPORT_ALLOW_Z10_ONLY)
+		param = 1;
 	else
+		param = 0;
+
+	if (support == DCN_ZSTATE_SUPPORT_DISALLOW)
 		msg_id = VBIOSSMC_MSG_DisallowZstatesEntry;
+	else
+		msg_id = VBIOSSMC_MSG_AllowZstatesEntry;
 
 	dcn31_smu_send_msg_with_param(
 		clk_mgr,
 		msg_id,
-		0);
+		param);
 
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_smu.h b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_smu.h
index cd0b7e1e685f..dfa25a76a6d1 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_smu.h
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn31/dcn31_smu.h
@@ -265,7 +265,7 @@ void dcn31_smu_set_dram_addr_low(struct clk_mgr_internal *clk_mgr, uint32_t addr
 void dcn31_smu_transfer_dpm_table_smu_2_dram(struct clk_mgr_internal *clk_mgr);
 void dcn31_smu_transfer_wm_table_dram_2_smu(struct clk_mgr_internal *clk_mgr);
 
-void dcn31_smu_set_Z9_support(struct clk_mgr_internal *clk_mgr, bool support);
+void dcn31_smu_set_zstate_support(struct clk_mgr_internal *clk_mgr, enum dcn_zstate_support_state support);
 void dcn31_smu_set_dtbclk(struct clk_mgr_internal *clk_mgr, bool enable);
 
 #endif /* DAL_DC_31_SMU_H_ */
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 263f7edd42a4..b5e15da29017 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -396,6 +396,7 @@ enum dcn_pwr_state {
 enum dcn_zstate_support_state {
 	DCN_ZSTATE_SUPPORT_UNKNOWN,
 	DCN_ZSTATE_SUPPORT_ALLOW,
+	DCN_ZSTATE_SUPPORT_ALLOW_Z10_ONLY,
 	DCN_ZSTATE_SUPPORT_DISALLOW,
 };
 #endif
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
index 2bc93df023ad..d0a5c7afa265 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
@@ -3093,8 +3093,14 @@ static enum dcn_zstate_support_state  decide_zstate_support(struct dc *dc, struc
 	else if (context->stream_count == 1 &&  context->streams[0]->signal == SIGNAL_TYPE_EDP) {
 		struct dc_link *link = context->streams[0]->sink->link;
 
-		if (link->link_index == 0 && context->bw_ctx.dml.vba.StutterPeriod > 5000.0)
+		/* zstate only supported on PWRSEQ0 */
+		if (link->link_index != 0)
+			return DCN_ZSTATE_SUPPORT_DISALLOW;
+
+		if (context->bw_ctx.dml.vba.StutterPeriod > 5000.0)
 			return DCN_ZSTATE_SUPPORT_ALLOW;
+		else if (link->psr_settings.psr_feature_enabled)
+			return DCN_ZSTATE_SUPPORT_ALLOW_Z10_ONLY;
 		else
 			return DCN_ZSTATE_SUPPORT_DISALLOW;
 	} else
-- 
2.25.1

