Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5687EE0212
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Sep 2023 02:01:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31FF210E216;
	Thu, 14 Sep 2023 02:01:43 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2069.outbound.protection.outlook.com [40.107.244.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BB0510E216
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Sep 2023 02:01:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YOAk2RAk3LtNkI6zXb1O5BsWkxwuhl9EQZfta2L5nhcIiS3qsYveYgRSsKoQLdWDuBp4RpC3ALVhgCkyHhwup+h+2gkdCR5hulWdXvAn4l1UtH4uG/7AKU5czyfmnpNjiXbv4HlwvdFV95LigLrHsBevg+ax+LAPsHSpXtB9UugET7rc1FEz3HBKTmiRzedKG1UHSGGah4SudZskgvQ5vfoZjJr37To6QpnZe4xQI6n/F30mFyyOi6bwpZTcGmJ/J+sClZT7jyFtz1hy7ZNNrzP1KwR8cs5UyL0M5pzrbaggC9ckOexyxwbdtu9SM0xWkayOSECwzIJs0hUG9EHRkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yQP6/W3bQC74To0G7EYmC9UCDs1R6aaqTERkApjat0w=;
 b=NRHj5C9t96LmJ40Sm7e7MrybiAmd7UolOJW5brYb+sfv9VoC/FKWrG1F1fv6pyYG6UhNc7pbgucFqqX2dPIGjgLw0zFqs9HADW2GkfBZrOJOnchg4XZhLKDNrtJYr3CkH/rQDTuFg8l55bgA5Op8soeOt7j66zUjc2O5JXlZMUid9BFANoO9CIzJvG6oYKmx3cad+y2oyuvXVX7CKY13vIW8yxxgMjCX5PoOTQnvH0+oGVUUEC3unYPFEFJwqEVHLjhAqi4/07Qi67N6UiIz6e2520XlBPudaBqTSA1iEL0y2aqdVnBSROKkxgDvxHBya3XqFU6yCxiSCqk3rMqqJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yQP6/W3bQC74To0G7EYmC9UCDs1R6aaqTERkApjat0w=;
 b=4MyYId7rj98AfmfMTscN0GaSiWI32oDpPMGaZrbfbNLuikK3jpixHIfsCBOv9SOUAclBwFSq3Z6nYRiIOBWt/79WEc2zlysRFwflrw3P85AlkN0RbMshuopurB0XYMbt/qXcJKKup3uHjb396g5ufkCBzD9nrKc0X0YRjvdvMm0=
Received: from SA0PR11CA0038.namprd11.prod.outlook.com (2603:10b6:806:d0::13)
 by MW4PR12MB7333.namprd12.prod.outlook.com (2603:10b6:303:21b::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Thu, 14 Sep
 2023 02:01:37 +0000
Received: from SA2PEPF000015CA.namprd03.prod.outlook.com
 (2603:10b6:806:d0:cafe::bb) by SA0PR11CA0038.outlook.office365.com
 (2603:10b6:806:d0::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20 via Frontend
 Transport; Thu, 14 Sep 2023 02:01:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Thu, 14 Sep 2023 02:01:37 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 13 Sep
 2023 21:01:34 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/28] drm/amd/display: Add DPIA Link Encoder Assignment Fix
 for DCN35
Date: Wed, 13 Sep 2023 20:00:03 -0600
Message-ID: <20230914020021.2890026-11-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230914020021.2890026-1-Rodrigo.Siqueira@amd.com>
References: <20230914020021.2890026-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CA:EE_|MW4PR12MB7333:EE_
X-MS-Office365-Filtering-Correlation-Id: cde3eaf7-bba1-4597-551a-08dbb4c6876e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3Hb26pclHLOkwOfANGo/Jn/mfWuXqDeKO44q1D8rpexl7HYZezwPhIhebLGPXfulg+isFmQgpoVpvpHmJ+t+Cs6hIQ65ZLZBI6F7qpEYUr6RkJ9UZFzYESqO225+rdceE7WoSeVY4427qyD9JqESJlTGG9PKxKFuiFMSMKJI/CwbLNV+gNGbCPkL+poOqsTRZdBAsh4tau3g+GdbsxE+kA5qpQkudcGI/439rCSeNuuwqeboQ4jkG69OEFfpegPtPDxpUxBOU6FQ3VjcF6ScjeR2A4BCccE7ZGu/1jKIt06LUaJ+s3x0VqYouJoaqreY3i1ylnnVgAgX8TQjYdgV4zYzvar97fWez2RDoe5P9mX1ngaXUhLqCQJQJBKffKpp77bAH1M9oJLsoqIgGImBFzILEI/kDmEtCZFzMO8oq/C5txDoAH5a/qPzfCIw0sevjdgwg0EEOi3gyhCtIv8tA8VYs6O4zcNCvLZLFnQoY5p3iqtE3FVd9SgpqneHOpIzT4kFOEXmHo9mQnv1fh8DOLuz6mv85lBH9gFf9WLhSmyHb1S6sSVjSS0Jx429WUamXdlkrScmew5jk7jsuezom5tIxRcfXdS6kco1lFSCv6Egp8TXccv4iMws16tgBW/Xl/G5aT9Wwj4zvkVxoH1sBsax0CUnZT1vNcz9VHjrNVyukCnhwQjGQv3Ker5PcgBSmIn9yOL4jF4oCMFT0shLPQwALrYgDvkBc34VpoJ9jXmdgQgH8pEKUGMW6ktbuzKAsl70fdukz2C309kSbOfkmg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(136003)(376002)(396003)(346002)(451199024)(82310400011)(1800799009)(186009)(36840700001)(40470700004)(46966006)(5660300002)(40460700003)(66574015)(36756003)(47076005)(82740400003)(83380400001)(81166007)(356005)(2906002)(6916009)(40480700001)(36860700001)(54906003)(70586007)(70206006)(316002)(86362001)(6666004)(2616005)(8936002)(478600001)(16526019)(1076003)(26005)(426003)(8676002)(4326008)(336012)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 02:01:37.1111 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cde3eaf7-bba1-4597-551a-08dbb4c6876e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7333
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, George Shen <george.shen@amd.com>,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Mustapha Ghaddar <mghaddar@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Mustapha Ghaddar <mghaddar@amd.com>

[HOW & WHY]
For DPIA we should have preferred DIG assignment based on DPIA
selected as per the ASIC design

Reviewed-by: George Shen <george.shen@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Mustapha Ghaddar <mghaddar@amd.com>
---
 .../drm/amd/display/dc/dcn35/dcn35_resource.c | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c
index 60e7e09a577a..02480920a5b0 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_resource.c
@@ -863,6 +863,28 @@ static const struct dce_i2c_mask i2c_masks = {
 		I2C_COMMON_MASK_SH_LIST_DCN35(_MASK)
 };
 
+/* ========================================================== */
+
+/*
+ * DPIA index | Preferred Encoder     |    Host Router
+ *   0        |      C                |       0
+ *   1        |      First Available  |       0
+ *   2        |      D                |       1
+ *   3        |      First Available  |       1
+ */
+/* ========================================================== */
+static const enum engine_id dpia_to_preferred_enc_id_table[] = {
+		ENGINE_ID_DIGC,
+		ENGINE_ID_DIGC,
+		ENGINE_ID_DIGD,
+		ENGINE_ID_DIGD
+};
+
+static enum engine_id dcn35_get_preferred_eng_id_dpia(unsigned int dpia_index)
+{
+	return dpia_to_preferred_enc_id_table[dpia_index];
+}
+
 static struct dce_i2c_hw *dcn31_i2c_hw_create(
 	struct dc_context *ctx,
 	uint32_t inst)
@@ -1701,6 +1723,7 @@ static struct resource_funcs dcn35_res_pool_funcs = {
 	.update_bw_bounding_box = dcn35_update_bw_bounding_box_fpu,
 	.patch_unknown_plane_state = dcn20_patch_unknown_plane_state,
 	.get_panel_config_defaults = dcn35_get_panel_config_defaults,
+	.get_preferred_eng_id_dpia = dcn35_get_preferred_eng_id_dpia,
 };
 
 static bool dcn35_resource_construct(
-- 
2.40.1

