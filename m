Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C13C4C88E73
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Sep 2026 07:58:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D90210E250;
	Tue, 15 Sep 2026 07:58:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DKqKTU0t";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010039.outbound.protection.outlook.com [52.101.85.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA06010F2E4
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Sep 2026 07:58:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A4Qhgzg3gPDUDYI+TXHcFlj6kdQZt8duHu7egPffx+fMBMZx/cNkGrhgHfbL4YuKq0rNZz7U+ggUj+hxLjfLxIp8vC0xLMBmOXqekMyfLqeXCwbaKJc81qoGDc2Av0JywU9Rl0SFLc+TFJ+HSpz58Ra49qiRosPQoafrNOnD8OREG2MYxHTdQsVi0rjDxoTBqUVMuES+yIziLLPWBrLTByny/amsaVOazjEUVpppntRMxx0dp9TYo6L17VgMjOT9ke39m9m7pYvkZLHqImsqL5E8l9wcmeSS1BWy1EdaKLBSeZMrK0OFprJKmfSqNGjWp19kun3nKsWTOW6E2gosYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EbChN4teGVAobDUgUDpw9oT04JhQ/2FE6HRzk3vH2V8=;
 b=fNdlplCsNwD2aJTw4cKC+egSIxv8OL8vdBI8PyhnlWjXtaXC/SWQnxjJgMFiNUaBl8yO/26y97mddAcklN69FRKN8BTLZElsFvJSMpnHVF3VSNoTiBTsz8NdHQCmvNfdAJ17wzZ4qk17ywzM6md3M6TPTdOIy5mHN1fk58PeNHtfy3I9tcaHWOmBZrbHUS3aOtnHsDcgVzIS9VG07QzfMpm2/YYYHxMsYK1NMDzn8zA1h83jzD2IqMyJPekXyJtQV9ecSIEjc2iYGRAI6YNJ+72iqdyV0ntYQUTl00QkTsvf0QIuEfKwINwhctW6lvziXoz+lQsmVYJF0repd6CXTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EbChN4teGVAobDUgUDpw9oT04JhQ/2FE6HRzk3vH2V8=;
 b=DKqKTU0tvf3GfpLVQMKWp9GMNN4zL+YwpSAzF94JSKhPB6mObioAq9YV8IuDUDeIxbPzhdjMFJ0alIbkLD1sKG9dPXifMhipezbmYmrpWq/EoORTwuMRKIPtNihjJHK+tNIZpKnIATiN7U3krhV0nGMxsfoDAIUaLyQoqAFJOek=
Received: from BYAPR21CA0014.namprd21.prod.outlook.com (2603:10b6:a03:114::24)
 by PH8PR12MB7111.namprd12.prod.outlook.com (2603:10b6:510:22d::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Tue, 15 Sep
 2026 07:58:18 +0000
Received: from SJ1PEPF000023D9.namprd21.prod.outlook.com
 (2603:10b6:a03:114:cafe::1) by BYAPR21CA0014.outlook.office365.com
 (2603:10b6:a03:114::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.4 via Frontend Transport; Tue, 15
 Sep 2026 07:58:13 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023D9.mail.protection.outlook.com (10.167.244.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.1 via Frontend Transport; Tue, 15 Sep 2026 07:58:12 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 15 Sep 2026 02:58:08 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Alex Hung <alex.hung@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Dan Carpenter <error27@gmail.com>, Roman Li
 <Roman.Li@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Dan Wheeler
 <daniel.wheeler@amd.com>, Roman Li <roman.li@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>
Subject: [PATCH] drm/amd/display: Fix null deref of link_enc in
 dce110_enable_tmds_link_output
Date: Tue, 15 Sep 2026 13:27:55 +0530
Message-ID: <20260915075755.458506-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D9:EE_|PH8PR12MB7111:EE_
X-MS-Office365-Filtering-Correlation-Id: bfa247d7-9f32-4d04-e2c4-08df12ff176b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|36860700016|82310400026|3023799007|11063799006|10067099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: WKb6Y8KurVl79BtN11dxY6DEAohSMApSnCqlCAA/oF3N2F3Zhi/0BTcLwzIPfpzLHl4VgBndgRb+inKsQ8WtC8QkhvI8fCXd6LT3UUbbYusvxzhR2vGqlSRAqXRC5COWGZKQZEKSrazRPs/px5eC/+291eBxddX3FfY364bpTGkj0ur/bKydnwkQJzl7eFvXoocwMRKTrwsjiTiky+hutVYQNZTYSIBPWmsaLjZzxDyGvGLtnFTDPhudI7SrHV76zc0XC4k2CXOfnMpFtb+nJVr1a118oBihmg5GybbehTKFw6fR0DiAzpLh/isI+On7dg6Av3/8dEnkxmhJNu6g+I2ZerEgOfzi55blPT6uDm2FiUyWG7ex2Q3R+7px0CwoxjYu4t1dgfZ/G7h68/+U5L/RqZqYUDooo54OAbrTBpzCrCannHplGB5F7DmTphtxtGGqvYTstpEQ7Ow9a03w80HcarU7fLjc/jgBGJQeF5XnOPp7UsgAFDx25eIMOm8QaGk2Svxq2tchEPW2CiE7rZCHyPDVAAFfdZss5nwHRk1PyfQBlofYH+tzPLvn3n1Tr3P4frui6qyAbIGRnIFjQsJm+KbgjQfa8FZqyPU2YOetCo/xomP4XaZ9Zt0ke7dE9KvUD08WWeNgLoDDMh90q58hcbjyWy+NHacsFuFSGdv0OGgBhHWliJ2zdzEqLPfDjIPlpzywyBTzvBsjyxqJYA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(36860700016)(82310400026)(3023799007)(11063799006)(10067099003)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: fx74s5xuw1svnLar43fiLRhpUMbOfIoxgGc/jQe+osJwU6ZGUkYvHDfE/HZW9Z5WznbRdTb5clj2tbGcsSj+PgEPVv8OgbrJqfAcGTCXjbmelDaQOHzA7x/B3ZS1NmmpCR4dd6B0YFEr+cCMPwQ5jnWsRdO13FAXIZ02fge986zp65O4L927R2NKjKjorb6lVU1wIppLEsi35eN9VB0DA3yOZn6NWnGBBrtqhrN7g+m6p5f1F25Z7dIxrRm9+snCDPB0OTZTxgc+OUurrgK4aRN5SRouGzZ+ak9Ho46bcRf2NTWEED3QMLYmC+JmikEvZf2024f5Lg1UZZ3PZ/R4C7G8nCtgqbVDhDngE8oysVL3uZ7F5AaskWcb4OOYec/iBVRR4h50bIa1ZiPbKn1YHrrrUuNwIvIfgHRGJddVV8MsmIyAGV3w9nCM7h3qcyQs
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 07:58:12.7805 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bfa247d7-9f32-4d04-e2c4-08df12ff176b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D9.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7111
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

Smatch reports that link->link_enc is unconditionally dereferenced at
the top of dce110_enable_tmds_link_output() while the later
setup_ri_pj_check_in_sw_or_hw_mode calls guard against it being NULL,
making those checks contradictory.

Add an early return when link_enc is NULL and drop the redundant NULL
checks from the two call sites that follow, since link_enc is guaranteed
non-NULL past the guard

Fixes: 64fb5e1fd7fd ("drm/amd/display: Enable DCN6 sources compilation")
Reported-by: Dan Carpenter <error27@gmail.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Roman Li <Roman.Li@amd.com>
Cc: Ivan Lipski <ivan.lipski@amd.com>
Cc: Dan Wheeler <daniel.wheeler@amd.com>
Cc: Roman Li <roman.li@amd.com>
Cc: Alex Hung <alex.hung@amd.com>
Cc: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Change-Id: I3e55d05cfbcfa006bb06de92bf735806438b6b42
---
 drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
index bb46d7249025..54797293c0a1 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
@@ -3487,6 +3487,10 @@ void dce110_enable_tmds_link_output(struct dc_link *link,
 		uint32_t pixel_clock)
 {
 	(void)link_res;
+
+	if (!link->link_enc)
+		return;
+
 	link->link_enc->funcs->enable_tmds_output(
 			link->link_enc,
 			clock_source,
@@ -3497,12 +3501,12 @@ void dce110_enable_tmds_link_output(struct dc_link *link,
 
 	// For dongle Type 2 with no I2C support on board, setup sw mode of Ri/Pj check with proper aux instance
 	if (link->force_to_use_aux) {
-		if (link->link_enc && link->link_enc->funcs->setup_ri_pj_check_in_sw_or_hw_mode)
+		if (link->link_enc->funcs->setup_ri_pj_check_in_sw_or_hw_mode)
 			link->link_enc->funcs->setup_ri_pj_check_in_sw_or_hw_mode(link->link_enc,
 				link->aux_hw_inst, true);
 	} else
 		// For HDMI setup hw mode of Ri/Pj check with proper ddc pin instance
-		if (link->link_enc && link->link_enc->funcs->setup_ri_pj_check_in_sw_or_hw_mode)
+		if (link->link_enc->funcs->setup_ri_pj_check_in_sw_or_hw_mode)
 			link->link_enc->funcs->setup_ri_pj_check_in_sw_or_hw_mode(link->link_enc,
 				link->ddc_hw_inst, false);
 }
-- 
2.34.1

