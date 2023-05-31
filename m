Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46F9CC77B73
	for <amd-gfx@archiver.kernel.org>; Wed, 31 May 2023 04:20:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9394D10E1AD;
	Wed, 31 May 2023 04:20:10 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2043.outbound.protection.outlook.com [40.107.212.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A93A310E466
 for <amd-gfx@lists.freedesktop.org>; Wed, 31 May 2023 04:20:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fq7b3DQoYwXksGJQ0FJMlChmJMmyw2H9KjGMkulPG1n3kRro9Q5HCTHCLZjtGC5hgKJdhFADMm9GF6E0khwyVwQKcgQEmOJsHAb9K7zxkWJLxtZdDMSRzLFoOxwH1Ec+saezD3INyyRUIOUgalrlP2t1pNXjVTrQTjnwUViKTfQ2xRk/PhhJlSDKAhJrkL6UOvk5ofyiMuZrp4gYH6yB9H5hYUW4DnX5zuwyP7ZXYhsbXXeByjWxyle3wQG5O1I3m2d4SpV5t3vnTCZkgfqKvBzX9ySm/hELy0+OeG445UjEdJ8ySSbN0xHKc0aI67IDx6nJGphcDyGTpP/1/xX6yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ezHiO/GUj+FnnTINOzamnrygCdctGDmEozimUjzm9A4=;
 b=lKi2DJ9bhDXoGblh1IVcIGj3qQvgFX6ETwzGf2JO6qhLBAWcgy11Q109qLdWNUni8tzclDOMSypCGGsJ2SgHNrMeu8a9EJctkB+xDPnEl6ZUm3Y4QKkpMiLGuAdvmg1YMmYRJdtakMLaeD1lj/R5eJurHRXcF9DlGihBrNGjQOA/0Uks1qYBiRUF3oH9s2qh1bZfPmw3Gxfo0UAkLXBuZKjvxmjBcP/Ps90/A4+DPtUIx4580br8FeGaPk00vQsE8Q8UtKfEGpWgr3wIcleTfayx0N8rB7uAP5LklVndWNGEtlpCiYGnWyrnWVUClN10vty/xJJXkEKRRrA+9E9FOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ezHiO/GUj+FnnTINOzamnrygCdctGDmEozimUjzm9A4=;
 b=muR/VbsCeKCSPEieH8kyi2pi2HUXIHefF8jJqibZsGBuxf+s3w57pMAnnaGzBDGW2Edgc5Y62DT3h/GibJ5+4f1Qm6h0+8FONeW83jtQklYLOu+Vjrkcx9Ufu/ELNSfP36TuoZv6C4iuGBQSFQK7fieAGy8LaRU3bK3bHSFaiqc=
Received: from BN9PR03CA0766.namprd03.prod.outlook.com (2603:10b6:408:13a::21)
 by CH3PR12MB8728.namprd12.prod.outlook.com (2603:10b6:610:171::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Wed, 31 May
 2023 04:20:05 +0000
Received: from BN8NAM11FT007.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13a:cafe::ac) by BN9PR03CA0766.outlook.office365.com
 (2603:10b6:408:13a::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23 via Frontend
 Transport; Wed, 31 May 2023 04:20:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT007.mail.protection.outlook.com (10.13.177.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.22 via Frontend Transport; Wed, 31 May 2023 04:20:04 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 30 May
 2023 23:20:02 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Aurabindo Pillai <aurabindo.pillai@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, "Harry
 Wentland" <harry.wentland@amd.com>
Subject: [PATCH] drm/amd/display: Fix up kdoc formatting in
 dcn32_resource_helpers.c
Date: Wed, 31 May 2023 09:49:47 +0530
Message-ID: <20230531041947.3240207-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT007:EE_|CH3PR12MB8728:EE_
X-MS-Office365-Filtering-Correlation-Id: 5dc5e26f-6522-468f-b4d5-08db618e4f7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hqIx5PyYivLPNCTJlTDfnglUNeZw3ZM1+O0uitbeAK68pmh9S/a/GTVzq1NSJcUEXyDo/9SL3zwNOkX0395d2utonnDWO6BejA3B/8Xt7hYHTVvIaaEOmfnOwYFv2Tu+/RXtCfaXnLOVhWWNK/6j2I7QqKlY2AAOOueOnecuHT9VkShEm332VKFeLuJ3WOR6gFJhFeX1CWSuXPjgZATGE269detj70Uve5lNW5rdovawAfmMk19ndeux3THAcM9DQkiyhSvnhjAmJn2Du/N+Xqs59CE1cQkJxZmwRIYAPM47O9Yp/yGhqGC/VTmCL81dKcT7zRusyHwUi9iNgoCtltA9BGyJZaCS/HjE80fRI/R5zL0jv5hMENK9qK35SOCWq9xhjF0noyCsCsShcucrdop1h5kucL/+iqnhWaTWnZ9dRHtkr6kGOPkBZ/it3o/B8ghM+F4zKoMbumIPTpCkn54B5kihOQTISAFXgymRGsMZO0Wr/HgYkac42FfgvUupw8Tz25mxffx9Un8xgdYHaV6YS1gaYIipvaEFyDo4epH0VPWgMgI8rZLvCfH2fb/CW1MYKAckrzaiF4UZ+kOqLYTOXxvBkcTwyGI7w+JoO9oESK7cwq4+t0zyqJWBYR1gO9ugUDaC9xzr/ygWdDK5isylDXV9XhC3Mb5jtmDptxtTr0KI2jxJbfmGsWXZuHjWR4rXcKsZ5jPPBBwDMO7vOYPiuqc7spisS9+UsQPIoz4zS4VcmL9QxPEjZzeVbvIgOSMV2Y1ine8dCYDWtT/nmw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(346002)(376002)(136003)(39860400002)(451199021)(36840700001)(46966006)(40470700004)(186003)(2616005)(16526019)(41300700001)(336012)(426003)(83380400001)(26005)(1076003)(7696005)(6666004)(36860700001)(47076005)(478600001)(40460700003)(110136005)(54906003)(6636002)(356005)(4326008)(70586007)(82740400003)(81166007)(40480700001)(316002)(5660300002)(8936002)(8676002)(44832011)(70206006)(86362001)(2906002)(82310400005)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2023 04:20:04.9346 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dc5e26f-6522-468f-b4d5-08db618e4f7b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT007.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8728
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

Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 .../display/dc/dcn32/dcn32_resource_helpers.c | 56 ++++++++-----------
 1 file changed, 22 insertions(+), 34 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
index a8082580df92..0ed208989c46 100644
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
@@ -588,10 +576,10 @@ static int get_refresh_rate(struct dc_stream_state *fpo_candidate_stream)
 }
 
 /**
- * dcn32_can_support_mclk_switch_using_fw_based_vblank_stretch - Determines if config can support FPO
+ * dcn32_can_support_mclk_switch_using_fw_based_vblank_stretch() - Determines if config can support FPO
  *
- * @param [in]: dc - current dc state
- * @param [in]: context - new dc state
+ * @dc - current dc state
+ * @context - new dc state
  *
  * Return: Pointer to FPO stream candidate if config can support FPO, otherwise NULL
  */
-- 
2.25.1

