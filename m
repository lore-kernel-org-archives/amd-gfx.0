Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7A5ECCA479
	for <amd-gfx@archiver.kernel.org>; Sat, 16 Jul 2022 14:40:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E2BB010FC43;
	Sat, 16 Jul 2022 14:36:13 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2063.outbound.protection.outlook.com [40.107.93.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 01A8D10E1EA
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Jul 2022 18:17:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aoeT3OBB/pdpFuFUqG669PAxUX5ajLD6QirV2lnoS18rd2x/qUUc1HhFs2myGEj/9rnY1mLJeUAaZVQqJkylD0QJNJxqXZIZxvYeCM8IZwxue9IE+k5gqW4uNIgJUyAp7W9A4geimhgE93Gxc6PpVn/CYWsBD1sFfseXwFVtZQ980juMmdgnLC8nG+EM+wRBwsEKiGxXdRjgEBTy36CNA1mT88ak4DnqhmMfgwSfdJEl6uSG0I/Y8Wb8aN8V3LQY3q1bqOOJ9o7T/BtdqiBiUA6NFM1J+s4Jm//qdnLRNunOlcxvmRfqtDlGyu9bDmFWDV2Hi/fesTs5xUzKwezwdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EPodHEn38OkE93/8c4/NAGRoa1JEu8eGszMrVOFoVEw=;
 b=Jy7RCmNWhN4PHi46Rg1zBUmon1TluUt6QKLvIaE7m98dzg/7G7V6pb37rlgjuW/rV+U3/6DMl3UdTyoevkuXC8NurQ9B0mJHZol2zKTuJhClWklU032b3xhURTNThZSaQK/VBHe4QAtz6MjN7l1bj+bVXfLmEOw7kqiVrjEfLA27fegEfYKP7fzWkrs0KbbikrKO8Xvr6qohcknPkpgXM4q/aVxYYg+Oq8043ZXVeucA6YKFAcV6nzPBE9rw7F9WudqmZYkTwjmmtwONWd+y/cwQb8zrLB5+9aks8afhZMh1g7X1gFOLOa0HfovnT3iZCInT/TyMyjCyclWN8TOwCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EPodHEn38OkE93/8c4/NAGRoa1JEu8eGszMrVOFoVEw=;
 b=25lb+yK4B5TpdiBo3gB/aoZxUfaJIprIjHsDdHd8P4g9exj2UFWg10DUSiCDnsWWGP+8FHGAmJuBCfU4E8UY000fSCIjYpW/CSR/4b08/33iFurYVpg5bxzMRQnKV2+aCmcAqF+BGpAFmK+itltMEE/2Wg2NSL0MG5t7thuYY00=
Received: from DS7PR05CA0100.namprd05.prod.outlook.com (2603:10b6:8:56::23) by
 BYAPR12MB2854.namprd12.prod.outlook.com (2603:10b6:a03:135::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Fri, 15 Jul
 2022 18:17:42 +0000
Received: from DM6NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:56:cafe::74) by DS7PR05CA0100.outlook.office365.com
 (2603:10b6:8:56::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.9 via Frontend
 Transport; Fri, 15 Jul 2022 18:17:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT024.mail.protection.outlook.com (10.13.172.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5438.12 via Frontend Transport; Fri, 15 Jul 2022 18:17:41 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 15 Jul
 2022 13:17:40 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 15 Jul
 2022 13:17:40 -0500
Received: from arch-sec.hitronhub.home (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.28 via
 Frontend Transport; Fri, 15 Jul 2022 13:17:39 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 12/31] drm/amd/display: Don't set dram clock change
 requirement for SubVP
Date: Fri, 15 Jul 2022 14:16:46 -0400
Message-ID: <20220715181705.1030401-13-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220715181705.1030401-1-Rodrigo.Siqueira@amd.com>
References: <20220715181705.1030401-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9ddee4e1-bac7-4aa6-debe-08da668e4ea5
X-MS-TrafficTypeDiagnostic: BYAPR12MB2854:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VrsGNUiBZrZt2fZFZpWDPBd0vhqTIkgHanA4sI02LeDMycqHe75kd7S85+fkyX+L5ktTN9W3scNl4snawRuc21lX84SD0VDnu6PSLEknwEjYC6ghLmrOjQBT705nOYjDFMUcLOI5TCu4oTP5yTS4jhVKFEzH+SSRBXyUO1wq9HHof7rPH5NXfea+X7WR7ylmfdrW8ZP7FlSK+e39e4YUeF/cIKUsKBHxaI9G0zjCcQesgOIYw1ZHAlK0xrgXwhKRxyHllF9IoP5EUn17wdC3IK+ZZEag/Ik4c5NV0XHlaezaMrkxLAXTjBWMo5CMGTdlmLWt4zbZ4QGKTfGo4q8GxjGQN9YD4HvG2WpLll6cngkOuqTWZQV9Vn3QG2/cv+HzSl0oJugtrHntwKAC8raHh6thkgU3lAZr5JTMcVKv391RX7q1vjg7fBTz3YnJIFQ4GyveC0u5WuVlkZFe8Foh+5btt/vRLedmeiJbfmToy8nLNCLYkAbFzWFOHEoqGgHa7vc4aNMW0nfGxYpDU0R3J9GGHIixgWQzDeXuD3KvlHitGNJQIjKlWzCJlNtmUIfyGwEPDZs0uc5TxwBPt6uR3IHPff9eaD5bXDzoTFMhUMxBLJ7Ty+2U7qH0ev5HRMZ+0BxQ1JK9OGaT4HMkUOdAqViPg+1sUBbwKJm9MCHvSclMshaLS+mPGhg3kKV8eUNxAuk0KdvpoxELMC+e85w8cSM+BVIWCGw4MWoHp2rlId6NIVclzBSeMhUFnxhLuzmrXAfUE+3L80rCOE0VmzzxH3u/8QHqsYqkt4Medmh3mGlpSL6xnyUX4fDMZ0ZNHBUD/45egTU6vvXLOWOHPMbaOkREX6ChzHeMDFCIfHMdz0s=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(39860400002)(346002)(376002)(136003)(40470700004)(36840700001)(46966006)(40460700003)(5660300002)(8936002)(82740400003)(41300700001)(82310400005)(2906002)(1076003)(40480700001)(36860700001)(47076005)(83380400001)(81166007)(36756003)(26005)(6666004)(186003)(478600001)(70206006)(54906003)(336012)(70586007)(356005)(2616005)(8676002)(86362001)(6916009)(316002)(4326008)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2022 18:17:41.6135 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ddee4e1-bac7-4aa6-debe-08da668e4ea5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2854
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
Cc: stylon.wang@amd.com, Alan Liu <HaoPing.Liu@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Alvin Lee <Alvin.Lee2@amd.com>, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <Alvin.Lee2@amd.com>

[Description]
In general cases we want to keep the dram clock change requirement (we
prefer configs that support MCLK switch). Only override to false for
SubVP.

Acked-by: Alan Liu <HaoPing.Liu@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
index f913daabcca5..92d87745d933 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
@@ -2984,6 +2984,7 @@ int dcn32_populate_dml_pipes_from_context(
 	int i, pipe_cnt;
 	struct resource_context *res_ctx = &context->res_ctx;
 	struct pipe_ctx *pipe;
+	bool subvp_in_use = false;
 
 	dcn20_populate_dml_pipes_from_context(dc, context, pipes, fast_validate);
 
@@ -3006,6 +3007,7 @@ int dcn32_populate_dml_pipes_from_context(
 		switch (pipe->stream->mall_stream_config.type) {
 		case SUBVP_MAIN:
 			pipes[pipe_cnt].pipe.src.use_mall_for_pstate_change = dm_use_mall_pstate_change_sub_viewport;
+			subvp_in_use = true;
 			break;
 		case SUBVP_PHANTOM:
 			pipes[pipe_cnt].pipe.src.use_mall_for_pstate_change = dm_use_mall_pstate_change_phantom_pipe;
@@ -3076,6 +3078,14 @@ int dcn32_populate_dml_pipes_from_context(
 
 	dcn32_update_det_override_for_mpo(dc, context, pipes);
 
+	// In general cases we want to keep the dram clock change requirement
+	// (prefer configs that support MCLK switch). Only override to false
+	// for SubVP
+	if (subvp_in_use)
+		context->bw_ctx.dml.soc.dram_clock_change_requirement_final = false;
+	else
+		context->bw_ctx.dml.soc.dram_clock_change_requirement_final = true;
+
 	return pipe_cnt;
 }
 
-- 
2.37.0

