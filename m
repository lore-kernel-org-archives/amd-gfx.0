Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99268FEDA09
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2026 01:01:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 022FA10E5AE;
	Wed, 18 Mar 2026 01:01:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="x9qt9kjF";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013034.outbound.protection.outlook.com
 [40.93.201.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A9B010E5AE
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Mar 2026 01:01:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p4BDfmN2OX8M3XijktBCZ0G1yZpRVGJFx9W66BPAvkYj52MjTA8rzrpUxwxz38PolkPHhxlVFN2REi3TyaR1WdUvoM1n1p80Zmeb28gkWEaOd3+47VRWhUdCnn2TjEnP76j/7RUY98tdiOD4Hi9MG3nf9GcTlm6W6OH/3L6+JN9fzU+6yH9UacQhIQOD5N4rs4F4Azg63njuEmxB5sSz2KUMr52G3abmb9fAjQDl3PLxbSZYNrKGSALMgpUolj5d1Yl4VX25yjYzJ0ZOg9ig8ph+BxggdX7sZYMwDq9rYOKOoDJ5MiSdkpfTVhlS2NwOoZI+JtA1oBNQWMkTZymaAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6iS5PxBwFL3XZvHhScxyp8fVhTAEkPGtyrSngj/qIWE=;
 b=swGQK08H/aFANnE8HmVtHiyXGcvTHWyi9rqAUClgBgmubfO3CRKo0OwoQuqsBSVmWxL0Skvic79qNLyHzVou4icqaMozVcosXYhyWu/aydWqpUtne+JCkK+BYDh1/6+bZrM7q3Ihd2wynCZXDqwwXJAIBHxx8kpWH+isKbAwv/UnYL1xRAkjFBSgkc0yUIG1fj501U2si/bkmYbQhJDwpIZWVSQCBfBkhDr5kZBR/I8VZafymrmvjR3Hr0dIsQN9ge8NLqSMBLgvrM0FCEGVdAm3O73CzX91sgxbmfcwnhFMLIonDz9QxhkK3oghlYHX/c1JWs4qMgi+frEmQMxW7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6iS5PxBwFL3XZvHhScxyp8fVhTAEkPGtyrSngj/qIWE=;
 b=x9qt9kjFvXceR2Y45HP6KFGJx9iNwCQ8md6ircj/je5b4NwwlOdo3HKErAnwi8+eea3U1jxHRtWmDUtTITAvbNl4NIgrUlw5Ov9M3+hnMeWwMsDfAx10ExISYu5uTTtw8qFEZjwdpS3+btBL+W8g9QNlLWhSdhpvdLaI7EPv7u4=
Received: from PH8P222CA0027.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:2d7::28)
 by IA1PR12MB8467.namprd12.prod.outlook.com (2603:10b6:208:448::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 01:01:11 +0000
Received: from SN1PEPF000397B5.namprd05.prod.outlook.com
 (2603:10b6:510:2d7:cafe::e1) by PH8P222CA0027.outlook.office365.com
 (2603:10b6:510:2d7::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.24 via Frontend Transport; Wed,
 18 Mar 2026 01:01:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397B5.mail.protection.outlook.com (10.167.248.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Wed, 18 Mar 2026 01:01:11 +0000
Received: from maxMSI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 17 Mar
 2026 20:01:07 -0500
From: ChuanYu Tseng <ChuanYu.Tseng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, "Leo
 Chen" <leo.chen@amd.com>, Chuanyu Tseng <Chuanyu.Tseng@amd.com>
Subject: [PATCH 03/31] drm/amd/display: Add MRQ programming for DCN42
Date: Wed, 18 Mar 2026 08:59:12 +0800
Message-ID: <20260318010224.513094-4-ChuanYu.Tseng@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260318010224.513094-1-ChuanYu.Tseng@amd.com>
References: <20260318010224.513094-1-ChuanYu.Tseng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B5:EE_|IA1PR12MB8467:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c961ccc-26a3-46e6-1fd4-08de8489d89d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|376014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Svco/amWygZmExZ1NgwDiDVFoyoknBKmELo03VHW5g+o5zk5BWZDSt6oXJH/XICNpDLJSjxRDu+mi4Ug1D3znf9xh7vDOhX8MAf2BM14awyw2+0kBd+DzZYNkDCzcYzTSffJlS3wLiVtr/IyHxHgyUeWGM62+XqCYxPZGwZLBd0Q3oTvRADN1xrjdKYdyEj0M6GURXR/xsOzzD26EazVLqvjIplVml2Ml/LXXg8ksqCocXV9qYSkYBM6JK+8jG0t09klO7pHm6qrSPR3Epy/oZQOQmRhpCKzbNumNNvrtyzEr0uHDi7qPs6esBg/Zgvw8IUlTC+W2nRNUThIssCN+W9oGTfhuhFMINSjg0Ilcyvoyh/THRR3xM7izRPpCtsmTEdSFmAZbKB2AWDyt/crcaknFd0OKoQOaru+Mvkoa1/3iaYxPdocqg8kvhTBLfn081v/AWEXONcJWDtfHDJs70SVUpOHR/xSlfNQIOQJr67uW2BXeo1DiJoqcV/GCsQs/QAjSnBeawU+PrNOq5f/vPJGsDppyZGsHB1USbvSYQZKF6OFnUevrmln34NXfD6dzJ0RMXxid1n4/P+LK4oyD1K4pE/bc3Gy0FN/vLvQ6csKPe73PU8Qca5zBPqj3PCLGOKVpGvLzrWpRCB1cKxvNrR2lYvwuN2Wj81XiN+sVYHmVx3LC84WXttP6BecD/KeRpjecXOtKGfj13Vpi42KkHM+RFxorOwgAEWTM/TfvsGklQzct1yPYAt3nBN0roxsWKOSEVcZa9mnlMr8Zc6OYA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: EcIPDB2kzv5SSV25GvGY3UYTJxHGl4gkjOTb73X0GG5r5K1IzzwS5axAI+CJk7r5XWYGvPUKRK5De1F+UFBREthgWp09lvVwKFG555HPIHtOHRSwm6dbXQTXcYO2WxEGlvrDx5L55HyHmsNBGCQ7m1lgj02bi5LGyNARkmGhO18Fh9ijVCFYfVP9llmhbgFOCHSPXQAXNEa8Axur5+3gcj/nWW7wZGJ5iNmBQxD69YWtroXmTGctemU9X2NQnByeBNWZVjRumrxAnEqHTZDvcgr44vV6Wu5LjLm9tx9rL0A0sUV7JTxECfI/J9c3YfURtk3+ctNbp1KzfmqjdfGeMT+lTdBb3pLO6+V5AneXFebLLZXtcCor3KsUkZJOVZQf652hbU/BqMjwopM8qnEfFImZCejeMV5rMQlzyOLmheVNfQjgl8IhYTUXXqZ2Itse
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 01:01:11.2399 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c961ccc-26a3-46e6-1fd4-08de8489d89d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8467
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

[Why]
DCN401 didn't have a MRQ present so these fields didn't exist.

They are still present on DCN42 so we need to continue programming
them like we did on DCN35 or we can block have poor meta requesting
efficiency which blocks p-state.

[How]
Add `hubp42_program_requestor` which takes DML21 input and programs
the registers like DCN35 and prior.

Reviewed-by: Leo Chen <leo.chen@amd.com>
Signed-off-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
Signed-off-by: Chuanyu Tseng <Chuanyu.Tseng@amd.com>
---
 .../amd/display/dc/hubp/dcn42/dcn42_hubp.c    | 35 ++++++++++++++++++-
 .../amd/display/dc/hubp/dcn42/dcn42_hubp.h    |  6 ++++
 2 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn42/dcn42_hubp.c b/drivers/gpu/drm/amd/display/dc/hubp/dcn42/dcn42_hubp.c
index 0e33c739f459..d85a4ab957a4 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn42/dcn42_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn42/dcn42_hubp.c
@@ -245,6 +245,39 @@ static void hubp42_program_deadline(
 			REFCYC_PER_VM_DMDATA, dlg_attr->refcyc_per_vm_dmdata);
 }
 
+void hubp42_program_requestor(
+		struct hubp *hubp,
+		struct dml2_display_rq_regs *rq_regs)
+{
+	struct dcn20_hubp *hubp2 = TO_DCN20_HUBP(hubp);
+
+	REG_UPDATE(HUBPRET_CONTROL,
+			DET_BUF_PLANE1_BASE_ADDRESS, rq_regs->plane1_base_address);
+	REG_SET_4(DCN_EXPANSION_MODE, 0,
+			DRQ_EXPANSION_MODE, rq_regs->drq_expansion_mode,
+			PRQ_EXPANSION_MODE, rq_regs->prq_expansion_mode,
+			MRQ_EXPANSION_MODE, rq_regs->mrq_expansion_mode,
+			CRQ_EXPANSION_MODE, rq_regs->crq_expansion_mode);
+	REG_SET_8(DCHUBP_REQ_SIZE_CONFIG, 0,
+		CHUNK_SIZE, rq_regs->rq_regs_l.chunk_size,
+		MIN_CHUNK_SIZE, rq_regs->rq_regs_l.min_chunk_size,
+		META_CHUNK_SIZE, rq_regs->rq_regs_l.meta_chunk_size,
+		MIN_META_CHUNK_SIZE, rq_regs->rq_regs_l.min_meta_chunk_size,
+		DPTE_GROUP_SIZE, rq_regs->rq_regs_l.dpte_group_size,
+		VM_GROUP_SIZE, rq_regs->rq_regs_l.mpte_group_size,
+		SWATH_HEIGHT, rq_regs->rq_regs_l.swath_height,
+		PTE_ROW_HEIGHT_LINEAR, rq_regs->rq_regs_l.pte_row_height_linear);
+	REG_SET_7(DCHUBP_REQ_SIZE_CONFIG_C, 0,
+		CHUNK_SIZE_C, rq_regs->rq_regs_c.chunk_size,
+		MIN_CHUNK_SIZE_C, rq_regs->rq_regs_c.min_chunk_size,
+		META_CHUNK_SIZE_C, rq_regs->rq_regs_c.meta_chunk_size,
+		MIN_META_CHUNK_SIZE_C, rq_regs->rq_regs_c.min_meta_chunk_size,
+		DPTE_GROUP_SIZE_C, rq_regs->rq_regs_c.dpte_group_size,
+		SWATH_HEIGHT_C, rq_regs->rq_regs_c.swath_height,
+		PTE_ROW_HEIGHT_LINEAR_C, rq_regs->rq_regs_c.pte_row_height_linear);
+}
+
+
 void hubp42_setup(
 		struct hubp *hubp,
 	    struct dml2_dchub_per_pipe_register_set *pipe_regs,
@@ -255,7 +288,7 @@ void hubp42_setup(
 	 * disable the requestors is not needed
 	 */
 	hubp401_vready_at_or_After_vsync(hubp, pipe_global_sync, timing);
-	hubp401_program_requestor(hubp, &pipe_regs->rq_regs);
+	hubp42_program_requestor(hubp, &pipe_regs->rq_regs);
 	hubp42_program_deadline(hubp, &pipe_regs->dlg_regs, &pipe_regs->ttu_regs);
 }
 static void hubp42_program_surface_config(
diff --git a/drivers/gpu/drm/amd/display/dc/hubp/dcn42/dcn42_hubp.h b/drivers/gpu/drm/amd/display/dc/hubp/dcn42/dcn42_hubp.h
index 486c8907413a..88bb1337ab9d 100644
--- a/drivers/gpu/drm/amd/display/dc/hubp/dcn42/dcn42_hubp.h
+++ b/drivers/gpu/drm/amd/display/dc/hubp/dcn42/dcn42_hubp.h
@@ -48,6 +48,8 @@
 	HUBP_SF(CURSOR0_0_HUBP_3DLUT_ADDRESS_LOW, HUBP_3DLUT_ADDRESS_LOW, mask_sh),\
 	HUBP_SF(CURSOR0_0_HUBP_3DLUT_DLG_PARAM, REFCYC_PER_3DLUT_GROUP, mask_sh)
 
+struct dml2_display_rq_regs;
+
 bool hubp42_construct(
 	struct dcn20_hubp *hubp2,
 	struct dc_context *ctx,
@@ -64,6 +66,10 @@ void hubp42_program_3dlut_fl_config(struct hubp *hubp,
 
 void hubp42_read_state(struct hubp *hubp);
 
+void hubp42_program_requestor(
+		struct hubp *hubp,
+		struct dml2_display_rq_regs *rq_regs);
+
 void hubp42_setup(
 		struct hubp *hubp,
 	    struct dml2_dchub_per_pipe_register_set *pipe_regs,
-- 
2.43.0

