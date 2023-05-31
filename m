Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E430C77B73
	for <amd-gfx@archiver.kernel.org>; Wed, 31 May 2023 09:22:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9403410E4A1;
	Wed, 31 May 2023 09:22:25 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2067.outbound.protection.outlook.com [40.107.243.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D53E610E4A1
 for <amd-gfx@lists.freedesktop.org>; Wed, 31 May 2023 09:22:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YafW+UFNgNxqLqMBLAhVwRSRTIKAXBSR33gtWrDjG7xDkt7kTFBF4mbAO0RwGSLa6BTLQz9QLyvpPw0kN2QFHe6kMDPU/Kapkn8X5TqqHcbITYxVMRkErOLIkfO8VCshRZdBXiD6F3ZkNBI9zIp+1vusvcZciay8xbLFZ8nTwW5U6f4juBU4oVG3JRynwF4Ok+4K2eOdl5blgekpFyjK6gvOtKP8PrB164WBPHyoE6yq7u6Xec8iBfpLWiJLvz2c3phxMZZs0uknJ/sb7XCp71Gxp2uHpVumrGI3LxTUk3SWV9LCEPQQurXL2BaRpQ8m7U36n7XVSsNc94jP38/UIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+zuK3rwNwc+LYu7AMuitIrJ9Oaj15vW0PxnbA024Snk=;
 b=Ok3bvV4BU/eaePjOk4sTTaS7JA9mc4Z+9HE4d4SwxhGgdG7IrmbmvZxOqoPDjRfDDAl5daVr4LEzEIPEjhpjgZ1DgExrZKl3nJ8MT+y1bUXKaP6Pkj/xf8QW/XXAD0Uz30ETNQQrT3w2h5GoheGmJfOCQy96yzBQj68yHHWZkl/3g5gJfZ3SGmQK/DKgGP86Zc26vBg5PBQ/+rfYxaKNQlLeqxFZT6VZbEpS7Ly/0/SqUhA84xkheQVc2vkxpe99EnuD/aXnK9Akfa3I27XA4KmJTM3ieJmkdUh/42Weow92Bhu1sNaRLgX/Yf8HbayyfjL46VN2jAnqYBnroSStdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+zuK3rwNwc+LYu7AMuitIrJ9Oaj15vW0PxnbA024Snk=;
 b=u0jn3O4uLwR+1epLbwZzXFdCbL0wQ/7/0382F9YOMxx4rZTBoLOGEO9AUm5QSrb9QEaRKv1/hdykF/snvG0PMuo3ghlTMkxt4LXsWbMf90FtvvmjekUa/wyJpE8aLaeolIsvtXHD9DtfT3KIoVx/15yu0ROy37pAOBrg075w5UM=
Received: from BL1PR13CA0403.namprd13.prod.outlook.com (2603:10b6:208:2c2::18)
 by PH8PR12MB7279.namprd12.prod.outlook.com (2603:10b6:510:221::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.22; Wed, 31 May
 2023 09:22:19 +0000
Received: from BL02EPF000145BA.namprd05.prod.outlook.com
 (2603:10b6:208:2c2:cafe::d9) by BL1PR13CA0403.outlook.office365.com
 (2603:10b6:208:2c2::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22 via Frontend
 Transport; Wed, 31 May 2023 09:22:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF000145BA.mail.protection.outlook.com (10.167.241.210) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.18 via Frontend Transport; Wed, 31 May 2023 09:22:18 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 31 May
 2023 04:22:16 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Aurabindo Pillai <aurabindo.pillai@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, "Harry
 Wentland" <harry.wentland@amd.com>
Subject: [PATCH v2] drm/amd/display: Fix up kdoc formatting in
 dcn32_resource_helpers.c
Date: Wed, 31 May 2023 14:52:02 +0530
Message-ID: <20230531092202.3352796-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF000145BA:EE_|PH8PR12MB7279:EE_
X-MS-Office365-Filtering-Correlation-Id: ca1d75de-5ae1-4123-2d50-08db61b887f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FxhupDWZ9gBPXYFyLyd6+BDqfxDaxOJdvktldKwkUoqaaelB2zrRJcCJBs3oWnhnGGaSQf8j4gZRi2zBAAk5d3DjxHcRGCl92unpK3ZdUoeo5gKdvxs5qrNrEgkOqOkU84WvEyIoWvX7Rx7IGBzUtJC2i2mthHNPK8bV5lT+bjetBMyBQUUHZ6CJfp+xXr9IO/ZAJuYdJ8Ts7HFxreMH2WTcVcS694qIjCZLHAIUYEwKz0WObWXgXeBea6S2TmEIikHDpRSWe2k+zA2HpMXanxQ0yAkk6Wkpo2hg/+fxKjG3/g5NJog2RaQ9EzZBXYSRr/OIC6feGLInC7oO//nOC2FUxU3Cp+rpUfYdPqqqahncPZiRZF+0SEPKZClQ/UUVe7/EF6SDTHSPNIDqTogUVf1sulFAaPB6Fas0tGDeFZ2kuYemS4RSJ8owNRMeIg8u/XmkWMyWK+Cg70to5C24T29mjgeGNCzKrgFYbcj67fz5MVWDU0XclrUo1nQqdaPo6Fu484wG4S6hi/SVmTvVLRewqA8nrh04PysDiFxM5qvJMNHfzkmMrOR3A55mEMO12qX+1amjWcM4HkMMDGWT4aFSxDd5uBVXa2aQsSPCKS+9W6Oirv+NYxj9UNQtj0iaL/uxaQvfll22uYX/8z8xJCK0932Im6xDe4d1OZgbOY25D77lgnDoaVmlT3di5kvJTQTU8xXvJIDp+8RGc7DclMogZ/Wt+0EMJGmJyTgosJiyPgxfD+KPqGSroBYXXSV5GGBzMM36+el6jF7RZ522iQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(376002)(396003)(39860400002)(136003)(451199021)(46966006)(36840700001)(40470700004)(54906003)(478600001)(110136005)(40460700003)(4326008)(8676002)(44832011)(8936002)(70206006)(5660300002)(36756003)(86362001)(82310400005)(2906002)(82740400003)(70586007)(81166007)(356005)(6636002)(316002)(40480700001)(41300700001)(36860700001)(26005)(1076003)(426003)(336012)(83380400001)(47076005)(186003)(2616005)(16526019)(6666004)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2023 09:22:18.5195 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca1d75de-5ae1-4123-2d50-08db61b887f1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF000145BA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7279
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
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fixes the following W=1 kernel build warning:

drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_resource_helpers.c:97: warning: Cannot understand  * **************************************************************************
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_resource_helpers.c:264: warning: Cannot understand  * *************************************************************************
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_resource_helpers.c:435: warning: Cannot understand  * *************************************************************************
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_resource_helpers.c:475: warning: Cannot understand  * *************************************************************************

drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_resource_helpers.c:599:
warning: Function parameter or member 'dc' not described in
'dcn32_can_support_mclk_switch_using_fw_based_vblank_stretch'
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_resource_helpers.c:599:
warning: Function parameter or member 'context' not described in
'dcn32_can_support_mclk_switch_using_fw_based_vblank_stretch'

drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_resource_helpers.c:587:
warning: Function parameter or member 'dc' not described in
'dcn32_can_support_mclk_switch_using_fw_based_vblank_stretch'
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_resource_helpers.c:587:
warning: Function parameter or member 'context' not described in
'dcn32_can_support_mclk_switch_using_fw_based_vblank_stretch'

Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---

v2: 
 - Fixes added for line no. 587 also.

 .../display/dc/dcn32/dcn32_resource_helpers.c | 57 ++++++++-----------
 1 file changed, 23 insertions(+), 34 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
index a8082580df92..1d13fd797212 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
@@ -94,18 +94,15 @@ uint32_t dcn32_helper_calculate_mall_bytes_for_cursor(
 }
 
 /**
- * ********************************************************************************************
- * dcn32_helper_calculate_num_ways_for_subvp: Calculate number of ways needed for SubVP
+ * dcn32_helper_calculate_num_ways_for_subvp(): Calculate number of ways needed for SubVP
  *
  * Gets total allocation required for the phantom viewport calculated by DML in bytes and
  * converts to number of cache ways.
  *
- * @param [in] dc: current dc state
- * @param [in] context: new dc state
+ * @dc: current dc state
+ * @context: new dc state
  *
- * @return: number of ways required for SubVP
- *
- * ********************************************************************************************
+ * Return: number of ways required for SubVP
  */
 uint32_t dcn32_helper_calculate_num_ways_for_subvp(
 		struct dc *dc,
@@ -261,8 +258,7 @@ bool dcn32_is_psr_capable(struct pipe_ctx *pipe)
 #define DCN3_2_NEW_DET_OVERRIDE_MIN_MULTIPLIER 7
 
 /**
- * *******************************************************************************************
- * dcn32_determine_det_override: Determine DET allocation for each pipe
+ * dcn32_determine_det_override(): Determine DET allocation for each pipe
  *
  * This function determines how much DET to allocate for each pipe. The total number of
  * DET segments will be split equally among each of the streams, and after that the DET
@@ -290,13 +286,11 @@ bool dcn32_is_psr_capable(struct pipe_ctx *pipe)
  * 3. Assign smaller DET size for lower pixel display and higher DET size for
  *    higher pixel display
  *
- * @param [in]: dc: Current DC state
- * @param [in]: context: New DC state to be programmed
- * @param [in]: pipes: Array of DML pipes
- *
- * @return: void
+ * @dc: Current DC state
+ * @context: New DC state to be programmed
+ * @pipes: Array of DML pipes
  *
- * *******************************************************************************************
+ * Return: void
  */
 void dcn32_determine_det_override(struct dc *dc,
 		struct dc_state *context,
@@ -432,8 +426,7 @@ void dcn32_set_det_allocations(struct dc *dc, struct dc_state *context,
 }
 
 /**
- * *******************************************************************************************
- * dcn32_save_mall_state: Save MALL (SubVP) state for fast validation cases
+ * dcn32_save_mall_state(): Save MALL (SubVP) state for fast validation cases
  *
  * This function saves the MALL (SubVP) case for fast validation cases. For fast validation,
  * there are situations where a shallow copy of the dc->current_state is created for the
@@ -446,13 +439,11 @@ void dcn32_set_det_allocations(struct dc *dc, struct dc_state *context,
  * NOTE: This function ONLY works if the streams are not moved to a different pipe in the
  *       validation. We don't expect this to happen in fast_validation=1 cases.
  *
- * @param [in]: dc: Current DC state
- * @param [in]: context: New DC state to be programmed
- * @param [out]: temp_config: struct used to cache the existing MALL state
+ * @dc: Current DC state
+ * @context: New DC state to be programmed
+ * @temp_config: struct used to cache the existing MALL state
  *
- * @return: void
- *
- * *******************************************************************************************
+ * Return: void
  */
 void dcn32_save_mall_state(struct dc *dc,
 		struct dc_state *context,
@@ -472,18 +463,15 @@ void dcn32_save_mall_state(struct dc *dc,
 }
 
 /**
- * *******************************************************************************************
- * dcn32_restore_mall_state: Restore MALL (SubVP) state for fast validation cases
+ * dcn32_restore_mall_state(): Restore MALL (SubVP) state for fast validation cases
  *
  * Restore the MALL state based on the previously saved state from dcn32_save_mall_state
  *
- * @param [in]: dc: Current DC state
- * @param [in/out]: context: New DC state to be programmed, restore MALL state into here
- * @param [in]: temp_config: struct that has the cached MALL state
- *
- * @return: void
+ * @dc: Current DC state
+ * @context: New DC state to be programmed, restore MALL state into here
+ * @temp_config: struct that has the cached MALL state
  *
- * *******************************************************************************************
+ * Return: void
  */
 void dcn32_restore_mall_state(struct dc *dc,
 		struct dc_state *context,
@@ -588,10 +576,11 @@ static int get_refresh_rate(struct dc_stream_state *fpo_candidate_stream)
 }
 
 /**
- * dcn32_can_support_mclk_switch_using_fw_based_vblank_stretch - Determines if config can support FPO
+ * dcn32_can_support_mclk_switch_using_fw_based_vblank_stretch() - Determines if config can
+ *								    support FPO
  *
- * @param [in]: dc - current dc state
- * @param [in]: context - new dc state
+ * @dc: current dc state
+ * @context: new dc state
  *
  * Return: Pointer to FPO stream candidate if config can support FPO, otherwise NULL
  */
-- 
2.25.1

