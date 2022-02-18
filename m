Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80BF5C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Feb 2022 15:04:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 092DC10EEC7;
	Fri, 18 Feb 2022 15:04:22 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2086.outbound.protection.outlook.com [40.107.101.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D62710EEC7
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Feb 2022 15:04:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nDugid61CGl07T6aUr//CHOXlDQovGl90qbAFxE+CZU8M5IXuICdYqLB9Wb/lOMeMvGyF8+zZofDABHkKzSnK5O1XE1tgd+sgpM9R4NA+HV3n2L0TDmNciTurRcbn8BA6WyoSCYyLbrpvPoeSjQLqNJ3ZZ8aWV5zh96vb/xMMu/CMzY8j7xKXnV71p4kvPbhqB1+mallqsDyLrIvkYU4BpTA8NrSy1l0BH+thYRPO/CQXguunMu+1sGtHYFp03QLCd0Hrx+mxRuFpj2ydtGOuQroxNe3oCd0QuI+4OCuUkOPGQ0icKSt1BTYwaU8oGDRF75n+KnRUGTWg4jIR33L/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qKoYDaBa+BnFCedMLhG281QO6KcVpehasRN7Be+D5Y0=;
 b=BCcEVuCFxqC2Uj2aNZ9W7s9u65GspHjZiWME2yZywGLHmfSvnZsHaO5aTFELaJgPt402H0IPC3ECzeBNroIC1yIIvx9MK/nTWn9zuaCg2sbyHmYSh8aqU7+0vpZZE3dZDOVcTC/teUA3v7X8MIEKXByOFfkwTrspqOB6eCyExjjbuES7R9H/KDZbN3miNDV1V6wq4cca3OBhaa7OyLC7sFJl8QU+b9SSB4CQBO21A15e0bPp+dp2eaNUr3ykQfLD5RDuDlvo/0l///+YPS+3XMvco75hkD2jA2UXgCySul5ktDQycpB4RSY/Ppr4KJhFv/67Z4OI9odXs3CrSXCglw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qKoYDaBa+BnFCedMLhG281QO6KcVpehasRN7Be+D5Y0=;
 b=L4FaR+yGCwYcCELepmhab4m2ggxYJcnMG2y0pkgpztLo1aYyLaEmEGu1OqDrbaFjfv0aFsss5MNYB5BChSYd+6clM2XrfQv9ErU75fAcW8ILXkQ+s038KEBSuhA+AFNXT9cDsQxmY2vu49HFNq4dlhnWG41Sk6opOQx4WJ1X9c0=
Received: from DM6PR13CA0062.namprd13.prod.outlook.com (2603:10b6:5:134::39)
 by BN6PR12MB1345.namprd12.prod.outlook.com (2603:10b6:404:18::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.17; Fri, 18 Feb
 2022 15:04:19 +0000
Received: from DM6NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:134:cafe::b3) by DM6PR13CA0062.outlook.office365.com
 (2603:10b6:5:134::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.10 via Frontend
 Transport; Fri, 18 Feb 2022 15:04:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT059.mail.protection.outlook.com (10.13.172.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4995.15 via Frontend Transport; Fri, 18 Feb 2022 15:04:18 +0000
Received: from solomon-t14.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 18 Feb
 2022 09:04:11 -0600
From: Solomon Chiu <solomon.chiu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/12] drm/amd/display: Set compbuf size to min at prep
 prevent overbook crb
Date: Fri, 18 Feb 2022 23:03:20 +0800
Message-ID: <20220218150329.7976-4-solomon.chiu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220218150329.7976-1-solomon.chiu@amd.com>
References: <20220218150329.7976-1-solomon.chiu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f98d0f8e-7f62-41df-fea0-08d9f2eff029
X-MS-TrafficTypeDiagnostic: BN6PR12MB1345:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB13458534951CEAD4C1E26ABB97379@BN6PR12MB1345.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1zBEZVr0WR/zmO6Dr6uZDjW13U0Hv9OpuXvj9B8X/1FUqkODTHHh/+Crlrcz82bytIBFXxMXFg3W2CGwW+RvOqwH/gedFYw6BBHen/1c8dWZKjvsAblWO5hfgPgT3WGUCFY7h7wgDHiX7vSEMb1SXQMgLzpHnJj8JeDY9voK/aAYti2P5tqAM+m3PSBPzqWrGqexABwuIe7Y7QMeg/1/QzpoFP3gNrtj8qweNeqyrTd5w2gFmRN7gzWwXj92BZVlEwxOo13v/Saq7b2kWywD1XIb952AkWRkEdMBDZyMoBahK6Jx6XtOUZEHWuvQwEVXMpKmdj2EVjy4Gvoxh95zsSF2XITOyaX61AzWH2GNZBOYO5gCExuxCVhHiE+TXOycr/hCrt+P6HwREXN14UVRPDCWzweoMCm5Z+HKzYYpXLFNQCIqP2LUC0fb1VdyL/6EEzpVH4Wk+bHsnkm/CrS3G/kza6F1SipqRY193HjtZbnbe50lFRS6mMrVjG6Z5EowVYmcsA0hQbdsRhQs+T2f2Eo1rb6wegwNWsMHJ7KnD9bMET1Xkhz1VT3CwwLEhjunADsPW4yrqbskjbXoZD/t7L00TvH/Xjp2bfODvEjU4yq//SyY6K+Mf5vi4xW1Lc+Y4HWtN6i7MZTPrx6bts7if428PTWJ5x4kyQjKF7D8BVt9cxCDCsclMg7cxxGrTeM6FnXm004ATa52/pbx0gpJvA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(36756003)(2906002)(44832011)(70586007)(7696005)(81166007)(356005)(54906003)(6916009)(86362001)(83380400001)(5660300002)(8936002)(6666004)(2616005)(40460700003)(336012)(426003)(1076003)(316002)(47076005)(70206006)(8676002)(4326008)(26005)(508600001)(36860700001)(82310400004)(186003)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2022 15:04:18.9087 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f98d0f8e-7f62-41df-fea0-08d9f2eff029
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1345
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
Cc: stylon.wang@amd.com, Charlene Liu <Charlene.Liu@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, "Ma, Duncan" <duncanma@amd.com>,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: "Ma, Duncan" <duncanma@amd.com>

[Why]
Detbuffer size is dynamically set for dcn31x. At certain moment,
compbuf+(def size * num pipes) > config return buffer size causing
flickering. This is easily reproducible when MPO is
enabled with two displays.

[How]
At prepare BW, use the min comp buffer size. When it is to
optimize BW, set compbuf size back to maximum possible size.

Reviewed-by: Charlene Liu <Charlene.Liu@amd.com>
Reviewed-by: Charlene Liu <Charlene.Liu@amd.com>
Acked-by: Solomon Chiu <solomon.chiu@amd.com>
Signed-off-by: Duncan Ma <duncanma@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c   | 12 ++++++++++--
 .../drm/amd/display/dc/dml/display_mode_structs.h    |  1 +
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index 20a9cbb7c0a8..1ef880fed776 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -1818,6 +1818,7 @@ void dcn20_prepare_bandwidth(
 		struct dc_state *context)
 {
 	struct hubbub *hubbub = dc->res_pool->hubbub;
+	unsigned int compbuf_size_kb = 0;
 
 	dc->clk_mgr->funcs->update_clocks(
 			dc->clk_mgr,
@@ -1829,9 +1830,16 @@ void dcn20_prepare_bandwidth(
 					&context->bw_ctx.bw.dcn.watermarks,
 					dc->res_pool->ref_clocks.dchub_ref_clock_inKhz / 1000,
 					false);
+
 	/* decrease compbuf size */
-	if (hubbub->funcs->program_compbuf_size)
-		hubbub->funcs->program_compbuf_size(hubbub, context->bw_ctx.bw.dcn.compbuf_size_kb, false);
+	if (hubbub->funcs->program_compbuf_size) {
+		if (context->bw_ctx.dml.ip.min_comp_buffer_size_kbytes)
+			compbuf_size_kb = context->bw_ctx.dml.ip.min_comp_buffer_size_kbytes;
+		else
+			compbuf_size_kb = context->bw_ctx.bw.dcn.compbuf_size_kb;
+
+		hubbub->funcs->program_compbuf_size(hubbub, compbuf_size_kb, false);
+	}
 }
 
 void dcn20_optimize_bandwidth(
diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h b/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h
index 8f9f1d607f7c..59f0a61c33cf 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h
@@ -141,6 +141,7 @@ struct _vcs_dpi_ip_params_st {
 	unsigned int odm_capable;
 	unsigned int rob_buffer_size_kbytes;
 	unsigned int det_buffer_size_kbytes;
+	unsigned int min_comp_buffer_size_kbytes;
 	unsigned int dpte_buffer_size_in_pte_reqs_luma;
 	unsigned int dpte_buffer_size_in_pte_reqs_chroma;
 	unsigned int pde_proc_buffer_size_64k_reqs;
-- 
2.25.1

