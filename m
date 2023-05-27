Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88F14C77B73
	for <amd-gfx@archiver.kernel.org>; Sat, 27 May 2023 16:42:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0BA6110E247;
	Sat, 27 May 2023 16:42:33 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2060.outbound.protection.outlook.com [40.107.237.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6820610E247
 for <amd-gfx@lists.freedesktop.org>; Sat, 27 May 2023 16:42:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kyulSJ3lqPoC3ucnLeCtdWo/32tuaStcQliPezUfruJGLxzoRCvaeVMKMm20BUWEyTsRIX5E9JnjjcIzIs0GsNBeV+usewnZUBcH3XJdsGaW8KbaUSYb/32uyfkSQSIi8CV0+ePDbok4RiNyGYkuQtno7nyt0emk9LW7sqPL58G1G5apH438k4V02Q6nDY4kO0y+/cIsWpwY+tIyn9ADnzFcrUhbhXhdYkmAUnGoMjKVjmfdM+hY46+A6HKGPVf7dLuxtjniENNG5z39qx7Vwum6ObrK81X3MAKKnYGXA+ejfmtV02sB4W4OpFCIPbgJc88dQp2A/TUjRf//Y584ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kbEMUiipncUW6IK/uaqJd0xNtgmRNsqTJed+qREZKzc=;
 b=mS7CE/2me54L/vATuc7w3BldMOSWZNBSNiz5LVIy3q8utWvQ3pcFXEhcH6PysaZOw1ijya5QZkXNsTu7I5HYM5ojLwqUpfobHZWI8cpzzCRr/z2cwE6HWqBLWzQp9tTWv5N5IP5MR5SCLrdQT1XNR1UgXqeOLMLUMs73aPJv+cxvGvhFReqcfRaOwI4AHPEGd7drc6/PKnSuScXcCopDBlccqv1lPVLwe1EAIaxUfn2c7dnLGa6iVFSOY/80i35xobfw2gWHNtWZvmftHmNgvozVjy661C6Ke2Dg0RqyTDSm16nWZUkwOkNdbqgiKKRcXI5Q9ULDs5Qvlq60h+AVLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kbEMUiipncUW6IK/uaqJd0xNtgmRNsqTJed+qREZKzc=;
 b=x7zjSdeXXm3cV88+44YG/xVwwfYAUVfep871yUEB2AlY1ujiZcQ9TwNdXWjTF7ezt/CiMjzV5jS02c5dohqCdkUdrb26USJEPaujjkxyK2xk9HteRByLLIMTxAY5gC5HTmF5XI6vKxZlSNta7rCXhFLdXuMcJnAjnO8+teewCI8=
Received: from MW4PR04CA0130.namprd04.prod.outlook.com (2603:10b6:303:84::15)
 by SA0PR12MB4400.namprd12.prod.outlook.com (2603:10b6:806:95::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.19; Sat, 27 May
 2023 16:42:27 +0000
Received: from CO1NAM11FT096.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:84:cafe::73) by MW4PR04CA0130.outlook.office365.com
 (2603:10b6:303:84::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.19 via Frontend
 Transport; Sat, 27 May 2023 16:42:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT096.mail.protection.outlook.com (10.13.175.84) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6433.18 via Frontend Transport; Sat, 27 May 2023 16:42:27 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Sat, 27 May
 2023 11:42:23 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Harry Wentland <Harry.Wentland@amd.com>
Subject: [PATCH] drm/amd/display: Fix up kdoc formats in dcn32_fpu.c
Date: Sat, 27 May 2023 22:12:07 +0530
Message-ID: <20230527164207.1527732-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT096:EE_|SA0PR12MB4400:EE_
X-MS-Office365-Filtering-Correlation-Id: 37594fea-0fb7-420c-24b3-08db5ed15b0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C9u1i1B/CcyfgJHX3wt05gsMbGR/iIpQ2UcdA1fx7XhWCyXvB33nEGjMfZDTPLYqvEMiuxX/Ry6rYm1XVO/kv++0dB72Cx8gAwYSN8bdRoVcgT65VlMfs5KXFr/yaAwFRDXUFniFlCI/4GKyoyKcp3QPiJ1s1Ak8B/DQQ4XB90QSl1sj9L0/OEo93ZWOi6rmqeuzADlzBvV9nga+jC8Q24I3qfOsGhV26gJgFnc89PR74Wno7/KYZOGtGf1j3DPMX1twileXgQaUPJyhm6mLWt9zyQgR8we0wBgw/jQiWPaEqVldfqt+S65Kwzxxc3UTX17mdkbNr+PPDu/yF64n2XNd5BZq/Tn4nN8zx26Va8FD2VMM1GIO/Siv3L8+NzZz44b5Hn05ZSpyn+3WiiKqZZN3x2/OjIO3X+TJO5Cow8D3YC6NFllWcNO2zevqF1Gqq/ND9yNC/cc7gQfl69p8R2xMr8ussPklG8wtvmqMgs0lXB7lb8HEOOirwujDkNri7nwueAAeVqMZkqRnk6oZNe3PxEFIotGAIh/DLAhwGMRR7S4jTmKl3wbPop5uq3goTEvR3fG3lWfsNxTWtxO43T+pT/zyN1v0jMRvsS0y/Zfor7YSmy12ueqlInKjRb4sWE5NokMusK2KTN0ZwP1628+Hln/5wzXpvNQuAkEysKsas+BGWfuTzXuBJWOMP4uGo+cC5Evb9TW95Y5ptIo6zhRPUZS6AmWT2iv6fs+akgZ+G//2N50ILT1KBuvn+7LTxmTqGFL2smCRVIdQa+Otpg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(396003)(136003)(39860400002)(346002)(451199021)(36840700001)(40470700004)(46966006)(82310400005)(44832011)(5660300002)(8936002)(40460700003)(8676002)(478600001)(54906003)(110136005)(7696005)(81166007)(40480700001)(316002)(6666004)(70206006)(6636002)(70586007)(4326008)(356005)(82740400003)(36756003)(2616005)(86362001)(16526019)(186003)(2906002)(336012)(36860700001)(426003)(83380400001)(41300700001)(47076005)(1076003)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2023 16:42:27.0349 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37594fea-0fb7-420c-24b3-08db5ed15b0c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT096.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4400
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
Cc: Harry Wentland <harry.wentland@amd.com>,
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fixes the following gcc with W=1:

drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/dcn32_fpu.c:2806: warning: Cannot understand  * *************************************************************************
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/dcn32_fpu.c:2855: warning: Cannot understand  * *************************************************************************
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/dcn32_fpu.c:2900: warning: Function parameter or member 'dc' not described in 'dcn32_assign_fpo_vactive_candidate'
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/dcn32_fpu.c:2900: warning: Function parameter or member 'context' not described in 'dcn32_assign_fpo_vactive_candidate'
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/dcn32_fpu.c:2900: warning: Function parameter or member 'fpo_candidate_stream' not described in 'dcn32_assign_fpo_vactive_candidate'
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/dcn32_fpu.c:2929: warning: Function parameter or member 'dc' not described in 'dcn32_find_vactive_pipe'
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/dcn32_fpu.c:2929: warning: Function parameter or member 'context' not described in 'dcn32_find_vactive_pipe'
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/dcn32_fpu.c:2929: warning: Function parameter or member 'vactive_margin_req_us' not described in 'dcn32_find_vactive_pipe'

Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  | 46 +++++++++----------
 1 file changed, 22 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index 137ff970c9aa..6d8dda4cb065 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -2802,13 +2802,12 @@ bool dcn32_allow_subvp_with_active_margin(struct pipe_ctx *pipe)
 	return allow;
 }
 
-/**
- * ************************************************************************************************
+/*
  * dcn32_allow_subvp_high_refresh_rate: Determine if the high refresh rate config will allow subvp
  *
- * @param [in]: dc: Current DC state
- * @param [in]: context: New DC state to be programmed
- * @param [in]: pipe: Pipe to be considered for use in subvp
+ * @dc: Current DC state
+ * @context: New DC state to be programmed
+ * @pipe: Pipe to be considered for use in subvp
  *
  * On high refresh rate display configs, we will allow subvp under the following conditions:
  * 1. Resolution is 3840x2160, 3440x1440, or 2560x1440
@@ -2817,9 +2816,8 @@ bool dcn32_allow_subvp_with_active_margin(struct pipe_ctx *pipe)
  * 4. Freesync is inactive
  * 5. For single display cases, freesync must be disabled
  *
- * @return: True if pipe can be used for subvp, false otherwise
- *
- * ************************************************************************************************
+ * Returns:
+ *	True if pipe can be used for subvp, false otherwise
  */
 bool dcn32_allow_subvp_high_refresh_rate(struct dc *dc, struct dc_state *context, struct pipe_ctx *pipe)
 {
@@ -2851,16 +2849,15 @@ bool dcn32_allow_subvp_high_refresh_rate(struct dc *dc, struct dc_state *context
 	return allow;
 }
 
-/**
- * *******************************************************************************************
+/*
  * dcn32_determine_max_vratio_prefetch: Determine max Vratio for prefetch by driver policy
  *
- * @param [in]: dc: Current DC state
- * @param [in]: context: New DC state to be programmed
+ * @dc: Current DC state
+ * @context: New DC state to be programmed
  *
- * @return: Max vratio for prefetch
+ * Returns:
+ *	Max vratio for prefetch
  *
- * *******************************************************************************************
  */
 double dcn32_determine_max_vratio_prefetch(struct dc *dc, struct dc_state *context)
 {
@@ -2881,7 +2878,7 @@ double dcn32_determine_max_vratio_prefetch(struct dc *dc, struct dc_state *conte
 	return max_vratio_pre;
 }
 
-/**
+/*
  * dcn32_assign_fpo_vactive_candidate - Assign the FPO stream candidate for FPO + VActive case
  *
  * This function chooses the FPO candidate stream for FPO + VActive cases (2 stream config).
@@ -2890,11 +2887,12 @@ double dcn32_determine_max_vratio_prefetch(struct dc *dc, struct dc_state *conte
  * ActiveMargin <= 0 to be the FPO stream candidate if found.
  *
  *
- * @param [in]: dc - current dc state
- * @param [in]: context - new dc state
- * @param [out]: fpo_candidate_stream - pointer to FPO stream candidate if one is found
+ * @dc: current dc state
+ * @context: new dc state
+ * @fpo_candidate_stream: pointer to FPO stream candidate if one is found
  *
- * Return: void
+ * Return:
+ *	void
  */
 void dcn32_assign_fpo_vactive_candidate(struct dc *dc, const struct dc_state *context, struct dc_stream_state **fpo_candidate_stream)
 {
@@ -2915,13 +2913,13 @@ void dcn32_assign_fpo_vactive_candidate(struct dc *dc, const struct dc_state *co
 	}
 }
 
-/**
+/*
  * dcn32_find_vactive_pipe - Determines if the config has a pipe that can switch in VACTIVE
  *
- * @param [in]: dc - current dc state
- * @param [in]: context - new dc state
- * @param [in]: vactive_margin_req_us - The vactive marign required for a vactive pipe to be
- *                                      considered "found"
+ * @dc: current dc state
+ * @context: new dc state
+ * @vactive_margin_req_us: The vactive marign required for a vactive pipe to be
+ *                              considered "found"
  *
  * Return: True if VACTIVE display is found, false otherwise
  */
-- 
2.25.1

