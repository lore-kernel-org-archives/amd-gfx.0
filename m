Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C949C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Mar 2022 22:21:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDFF210E758;
	Thu, 10 Mar 2022 22:21:54 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2059.outbound.protection.outlook.com [40.107.237.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 87F4B10E758
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Mar 2022 22:21:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yz7ZEGwmwU72dNrlLralCFWX6WS2mLRKt0XZbyf6afANCI6BQl+yCD2zdV+aK2AOO17dQlWeuHMBUitkSUPwmTPhXazCNUdkXCUNH7U6db3WL3iJcF/ZY+2+/O+x0dMIJCQCiT7kL11/H2JR56yXlwyAvE0SkNm6ePhLeE4yH8shk35K+thmssAE53y0cfnAT7We6SRVWltuTNF2D2tlHIhOir1LJJj8gehhpmrWfX7vkSXqh64TBJhS5STeVG0P99VLMjGLQ8EsFoxC1Gd2hvm9PG6fuxYz45UjCLLIWdYTg5KBCI51kmsvGuMqftOm7H50dAiiBZ1jVuYwDhdqGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z6bXSAFH2F/p47uA1fvYke/qD+1yMNoZJrmhjQBlmuc=;
 b=mQ6GElE5cRND9ghwXFKOrxxLmjwtuXPFhNXelfX0Afk3Vsx0kkXzIbx4TUgTLxshzNWMv4PA/pIrTDNDKpQ5qPfIxNukalq4akFpVIGxk7rjroKAcFoaGwUt1GNxZ2XliGwxtI7XXVBBiUiaK4zhWk1wDq3+4UufSObAQAhg4ZrxQ+CfgBeLN7UBY1G4Ur7rXrCCIPLO1/fA24eLt7Jw4XvSXZQ4G9rDgjcEI4Ji5pX+lY9xomAr/HZGnLrp4MNNsREHv/xAZnAtka3007PSxrjkm57n1VVKR8VoV+dzLtXVp2V0zb5MLriZhkQMA5uucaxf7trNNcm9yEOkHJhKhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z6bXSAFH2F/p47uA1fvYke/qD+1yMNoZJrmhjQBlmuc=;
 b=Yudo36pHOKc2EHfexz6ty9dmi69wAGH8vO9Wqn7UzVQgDBwsBQCSXiDk91BwBIFDjD8i2BZ9aj6ByMVkbVNUaptuKXOECvbKmQO69Cm0pIzRcU+xNSqfXM8VnclKqWTDm+F4DlQA8AQpyaxW6O4By2JoB1+NvjmdoKejfYbnl8Q=
Received: from DM5PR13CA0027.namprd13.prod.outlook.com (2603:10b6:3:7b::13) by
 CY4PR12MB1350.namprd12.prod.outlook.com (2603:10b6:903:41::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5038.19; Thu, 10 Mar 2022 22:21:51 +0000
Received: from DM6NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:7b:cafe::fc) by DM5PR13CA0027.outlook.office365.com
 (2603:10b6:3:7b::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.7 via Frontend
 Transport; Thu, 10 Mar 2022 22:21:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT061.mail.protection.outlook.com (10.13.173.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5061.22 via Frontend Transport; Thu, 10 Mar 2022 22:21:51 +0000
Received: from Linux-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 10 Mar
 2022 16:21:48 -0600
From: Agustin Gutierrez <agustin.gutierrez@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/12] drm/amd/display: Wait for hubp read line for Pollock
Date: Thu, 10 Mar 2022 17:20:42 -0500
Message-ID: <20220310222045.664867-10-agustin.gutierrez@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220310222045.664867-1-agustin.gutierrez@amd.com>
References: <20220310222045.664867-1-agustin.gutierrez@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4e13142c-d1a6-4046-e174-08da02e45ffe
X-MS-TrafficTypeDiagnostic: CY4PR12MB1350:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB13504DB17D4687C19D9B1968F50B9@CY4PR12MB1350.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Cy7CghYNMZxa7LxHsyoVSr9PD44HFROCFo7LyQl1uuu+q21PZrWNudY7hWo8EmZtXDhF47O4jNKDoUxDCfnURgnyLalcqCfaEY5SeQ341WaUiJcVa4YP8Ymm1hQB64ZT7Us6168mXzb8THaeWBF78XN5xlwyAw7PxVyR23JTdyTtMj3G3itDLpwdsCYq2Jyp23PJdeAFyUvi7QsjrjsuCLqhkG72Uox9ctZPQAHff9Ztse85uKjiflQ6/eBDN3kljUrl/84wXiRTVXhAonrycWCk8PufXNp5P9U8pfDxYbSsE4wxzhJXlY742CfSCeU/Y9VtQiSB4fVTAknuQzPu9NCSpEE7LzEnfMXr5fiY7+7EqG4vhciHzemrt3yKVr+DXBo5UgsojZXrkRAYrMw39pNv44fSkHjfJGgaDWYuTYlkbB6DJi5ENpYWGZmwVuypdm3W2IeOXtryaunYOdbxOSSONanz5hB0DToGE8qSO7T8rkk/ZmawZzgx6Hxjo5Roc+IKYEe5Cu8ee1boYucU8kPKf4oCgay7iZYN9+zJ0TDCbJPQrHp4D9n+HUjBS8xcvEG4MaGZ855CM3/4KifOBmnqgUxeG8PtPKzSnUEG7fA/3bNj0ZQDD1RurvhEH4SrENY/WlK6P52irsEuGn1T+CP5orVKC1tk6CgYltfOIUjPef6JKXjpPawF32GHJsQTQAvBQ57Ex/9marAX04PfFQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(7696005)(70206006)(81166007)(83380400001)(36756003)(47076005)(16526019)(70586007)(508600001)(6666004)(5660300002)(186003)(316002)(26005)(54906003)(426003)(86362001)(336012)(1076003)(40460700003)(8676002)(36860700001)(2616005)(356005)(8936002)(6916009)(4326008)(82310400004)(44832011)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2022 22:21:51.1747 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e13142c-d1a6-4046-e174-08da02e45ffe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1350
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
Cc: stylon.wang@amd.com, Aric Cyr <Aric.Cyr@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Becle Lee <becle.lee@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, Hersen Wu <hersenxs.wu@amd.com>, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Becle Lee <becle.lee@amd.com>

[Why]
Underflow occurred while hubp ret pipe read is idle and the
second pipe is powered up and added. Flickering and underflow
are only observed on Pollock.

[How]
Check the hubp ret pipe read prior to unlock pipes.

Reviewed-by: Hersen Wu <hersenxs.wu@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Agustin Gutierrez <agustin.gutierrez@amd.com>
Signed-off-by: Becle Lee <becle.lee@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubp.c | 15 +++++++++++++++
 drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubp.h |  4 ++++
 .../gpu/drm/amd/display/dc/dcn10/dcn10_resource.c | 15 +++++++++++++++
 .../gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c    | 10 ++++++++++
 drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h      |  1 +
 .../drm/amd/display/dc/inc/hw_sequencer_private.h |  1 +
 6 files changed, 46 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubp.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubp.c
index ea185c877323..fbff6beb78be 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubp.c
@@ -1311,6 +1311,20 @@ void hubp1_set_flip_int(struct hubp *hubp)
 	return;
 }
 
+/**
+ * hubp1_wait_pipe_read_start - wait for hubp ret path starting read.
+ *
+ * @hubp: hubp struct reference.
+ */
+void hubp1_wait_pipe_read_start(struct hubp *hubp)
+{
+	struct dcn10_hubp *hubp1 = TO_DCN10_HUBP(hubp);
+
+	REG_WAIT(HUBPRET_READ_LINE_STATUS,
+		PIPE_READ_VBLANK, 0,
+		 1, 1000);
+}
+
 void hubp1_init(struct hubp *hubp)
 {
 	//do nothing
@@ -1345,6 +1359,7 @@ static const struct hubp_funcs dcn10_hubp_funcs = {
 	.hubp_soft_reset = hubp1_soft_reset,
 	.hubp_in_blank = hubp1_in_blank,
 	.hubp_set_flip_int = hubp1_set_flip_int,
+	.hubp_wait_pipe_read_start = hubp1_wait_pipe_read_start,
 };
 
 /*****************************************/
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubp.h b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubp.h
index 9cb8c383d673..0b17c2993ca5 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubp.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hubp.h
@@ -76,6 +76,7 @@
 	SRI(DCSURF_SURFACE_CONTROL, HUBPREQ, id),\
 	SRI(DCSURF_SURFACE_FLIP_INTERRUPT, HUBPREQ, id),\
 	SRI(HUBPRET_CONTROL, HUBPRET, id),\
+	SRI(HUBPRET_READ_LINE_STATUS, HUBPRET, id),\
 	SRI(DCN_EXPANSION_MODE, HUBPREQ, id),\
 	SRI(DCHUBP_REQ_SIZE_CONFIG, HUBP, id),\
 	SRI(DCHUBP_REQ_SIZE_CONFIG_C, HUBP, id),\
@@ -186,6 +187,7 @@
 	uint32_t DCSURF_SURFACE_CONTROL; \
 	uint32_t DCSURF_SURFACE_FLIP_INTERRUPT; \
 	uint32_t HUBPRET_CONTROL; \
+	uint32_t HUBPRET_READ_LINE_STATUS; \
 	uint32_t DCN_EXPANSION_MODE; \
 	uint32_t DCHUBP_REQ_SIZE_CONFIG; \
 	uint32_t DCHUBP_REQ_SIZE_CONFIG_C; \
@@ -338,6 +340,7 @@
 	HUBP_SF(HUBPRET0_HUBPRET_CONTROL, DET_BUF_PLANE1_BASE_ADDRESS, mask_sh),\
 	HUBP_SF(HUBPRET0_HUBPRET_CONTROL, CROSSBAR_SRC_CB_B, mask_sh),\
 	HUBP_SF(HUBPRET0_HUBPRET_CONTROL, CROSSBAR_SRC_CR_R, mask_sh),\
+	HUBP_SF(HUBPRET0_HUBPRET_READ_LINE_STATUS, PIPE_READ_VBLANK, mask_sh),\
 	HUBP_SF(HUBPREQ0_DCN_EXPANSION_MODE, DRQ_EXPANSION_MODE, mask_sh),\
 	HUBP_SF(HUBPREQ0_DCN_EXPANSION_MODE, PRQ_EXPANSION_MODE, mask_sh),\
 	HUBP_SF(HUBPREQ0_DCN_EXPANSION_MODE, MRQ_EXPANSION_MODE, mask_sh),\
@@ -538,6 +541,7 @@
 	type DET_BUF_PLANE1_BASE_ADDRESS;\
 	type CROSSBAR_SRC_CB_B;\
 	type CROSSBAR_SRC_CR_R;\
+	type PIPE_READ_VBLANK;\
 	type DRQ_EXPANSION_MODE;\
 	type PRQ_EXPANSION_MODE;\
 	type MRQ_EXPANSION_MODE;\
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
index ac96242cc474..4048908dd265 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
@@ -863,6 +863,21 @@ static struct dce_hwseq *dcn10_hwseq_create(
 		hws->wa.DEGVIDCN10_253 = true;
 		hws->wa.false_optc_underflow = true;
 		hws->wa.DEGVIDCN10_254 = true;
+
+		if ((ctx->asic_id.chip_family == FAMILY_RV) &&
+			ASICREV_IS_RAVEN2(ctx->asic_id.hw_internal_rev))
+			switch (ctx->asic_id.pci_revision_id) {
+			case PRID_POLLOCK_94:
+			case PRID_POLLOCK_95:
+			case PRID_POLLOCK_E9:
+			case PRID_POLLOCK_EA:
+			case PRID_POLLOCK_EB:
+				hws->wa.wait_hubpret_read_start_during_mpo_transition = true;
+				break;
+			default:
+				hws->wa.wait_hubpret_read_start_during_mpo_transition = false;
+				break;
+			}
 	}
 	return hws;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index 1ef880fed776..ab910deed481 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -1739,6 +1739,16 @@ void dcn20_program_front_end_for_ctx(
 					|| pipe->stream->update_flags.raw)
 				&& hws->funcs.program_all_writeback_pipes_in_tree)
 			hws->funcs.program_all_writeback_pipes_in_tree(dc, pipe->stream, context);
+
+		/* Avoid underflow by check of pipe line read when adding 2nd plane. */
+		if (hws->wa.wait_hubpret_read_start_during_mpo_transition &&
+			!pipe->top_pipe &&
+			pipe->stream &&
+			pipe->plane_res.hubp->funcs->hubp_wait_pipe_read_start &&
+			dc->current_state->stream_status[0].plane_count == 1 &&
+			context->stream_status[0].plane_count > 1) {
+			pipe->plane_res.hubp->funcs->hubp_wait_pipe_read_start(pipe->plane_res.hubp);
+		}
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h b/drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h
index 2c031586f4e6..e45b7993c5c5 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h
@@ -195,6 +195,7 @@ struct hubp_funcs {
 
 	void (*hubp_set_flip_int)(struct hubp *hubp);
 
+	void (*hubp_wait_pipe_read_start)(struct hubp *hubp);
 };
 
 #endif
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer_private.h b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer_private.h
index 280c8764b636..8c2f190c4712 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer_private.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer_private.h
@@ -42,6 +42,7 @@ struct dce_hwseq_wa {
 	bool DEGVIDCN21;
 	bool disallow_self_refresh_during_multi_plane_transition;
 	bool dp_hpo_and_otg_sequence;
+	bool wait_hubpret_read_start_during_mpo_transition;
 };
 
 struct hwseq_wa_state {
-- 
2.35.1

