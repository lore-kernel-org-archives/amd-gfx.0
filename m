Return-Path: <SRS0=d+6m=QG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AEB2C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Nov 2021 19:44:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A36161159
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Nov 2021 19:44:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3A36161159
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 429EC6E34B;
	Fri, 19 Nov 2021 19:43:59 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2083.outbound.protection.outlook.com [40.107.244.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3FBE46E3F0
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Nov 2021 19:43:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CvWkxOrgqQng/iJpUGd/Loz/WsTedXUayr0CWEcNuKFep+tlQdmLuRfzN5YbPcEb8eaD8GzXJi5O2NFF9S8K+ZZrx877Ub2GDMziQp4cC1lxmja6LwDq/q4hgsf9Aw26lYZpW+oqY0k4UgzcEZql/Eb/F0GncBbyBzNk79OSeOj4aLs0JtC/eZo9OQG83xpVwIzZ0Qyi4TLEPWlk64JjusdmWiebhrk9HrcbDOTK8MlSmXs7wDtYH+gJvk/jCD+/KXVjwoXtxmVzJDglgF3sxCX2hBacHmB6XoSEAB0MQifMqzKIP9RAmjgeL8bs/lr83Zky80FlSUUs6F3jGfpOEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mRGVnAJ+VJgINRo+ZQPxzppdcL2r9XnpbQ9cpw3NLPI=;
 b=a9TqPNxBlVHu2us2azIC72y3GVvTi+YPEe9uPJT+Gk2q7kYwzWR0sU10oM7L0ti1l5WB+/h0qbIcG2iyxBM9LZ2xN45iI9HGFAHI3vNNkTM2dMsk5Up7c5Uxxb6thhlnqZ21XJscIKcDfcEtzTLL5Vuf4H9yM5BhEi9Xy3VpHDGyyx4NOuU7Z/ROoDzY6caF20oxi33mLgrG3g/+yObqLyB4msenB3Fhtk6G+0iaSgF4u4bjgWxwidJd3U+M5TMC17PCy6JroKlMWhL44tNuPdIEX560gX5YcoPr32Fio0/mKuWWLoyhACoKNDXalKXzvSYdhoATEBuUYX6nCsWCig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mRGVnAJ+VJgINRo+ZQPxzppdcL2r9XnpbQ9cpw3NLPI=;
 b=MLNIeQ4rLAQEgJi0nyqimZ09LWxiKIodoAPX52/gdCM3rgoUaffaoLlMnop+i1FygU7XqcposNQnWQZlwXiStYoFMKJlklrhK1lxWEXyWVtAYwNJ8ASwrTwHhST80QrtmHNWlQKTWNFrrFWuyn5NPaIApoNTqD+rlbv0FZlQKnU=
Received: from MW4PR03CA0271.namprd03.prod.outlook.com (2603:10b6:303:b5::6)
 by MN2PR12MB2861.namprd12.prod.outlook.com (2603:10b6:208:af::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.26; Fri, 19 Nov
 2021 19:43:55 +0000
Received: from CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b5:cafe::75) by MW4PR03CA0271.outlook.office365.com
 (2603:10b6:303:b5::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.20 via Frontend
 Transport; Fri, 19 Nov 2021 19:43:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT015.mail.protection.outlook.com (10.13.175.130) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4713.20 via Frontend Transport; Fri, 19 Nov 2021 19:43:54 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Fri, 19 Nov
 2021 13:43:52 -0600
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 04/16] drm/amd/display: enable seamless boot for DCN301
Date: Fri, 19 Nov 2021 14:43:27 -0500
Message-ID: <20211119194339.97573-5-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211119194339.97573-1-qingqing.zhuo@amd.com>
References: <20211119194339.97573-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 47e1eaef-be86-4ec9-0957-08d9ab94eb9b
X-MS-TrafficTypeDiagnostic: MN2PR12MB2861:
X-Microsoft-Antispam-PRVS: <MN2PR12MB28612475F4D102F4962E929FFB9C9@MN2PR12MB2861.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:561;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z8DhU3itA4EO6snZRBusFIEREGIogBwwm5YkjiQREdd+qzdV2etfuZgV8LJF+l23FeOGJXbZXgoWa/c39MT6Q2O1G5gzBxX5ZBjt9hAdo5eK2bH2r+W0E0JSHGEGzQEhK+lTS4XMEq7C2DkhUvlBpXoinR/SOU3x8VeZpOUoNfwuJD+MKlv7f9TjoujnGjwfvrytSMd/GROdjOVTt84Qw/AZaQk5+r7WxNf9bkc9g2sAobi3z6zGrn6NTbQBW7Lpf9S05RdPzKyZ/Hgr0l4DF2TntSrw+HhnnR3ZUq+E3qw/kg+9lKRwTjzF9mrC64ARkJcH+gPMBL8IFdlo0vNoWe7MGzNH+Mk67yRSngjMpD580mt0U/3/3aSSkKkkW/lfa03wqU35YSpSnJi+bzTvJrVxQXB2Aw+nj1/WZULV+aCPSUCd16OkUM+ZHd//Zra2DPARc6WDB9Q2N8/+NffYVq0ePPvwI6sfXHkut/8MRF1Y6HlHwATgNgaU9QtKUn63LBufdbVhxI9HNOVIiQkK8g5/Vn3R62KqxZCEmcc9ly4do7zv39cbvp4CtgtceHR/vKPq+QJpfbotHrh3vWoy9MWrp8YGp3eiZCxIFn13rr6H+aYUtxXWTlfl9z3n8jw7907s/jmpvpWoJdjGBdGuiCaE+LFkpHvl83iw4O2yckE1vCcM2PR+acxA57q1lEmJrcQW8UxuURnfPTiGL6ZLnns3IcJii36zFr9e+ZdEYWmG1W3M0qNfD5OKwJnNGs3Hks7oaDfDaqt6ftkH1cz3DWHx1aCbeGuK+wnBpjjBQfE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(47076005)(8676002)(6916009)(2906002)(2616005)(508600001)(8936002)(426003)(336012)(36860700001)(36756003)(70586007)(70206006)(44832011)(86362001)(356005)(82310400003)(1076003)(54906003)(316002)(83380400001)(16526019)(186003)(5660300002)(6666004)(4326008)(26005)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2021 19:43:54.4362 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47e1eaef-be86-4ec9-0957-08d9ab94eb9b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2861
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
 Zhan Liu <Zhan.Liu@amd.com>, solomon.chiu@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, mikita.lipski@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Zhan Liu <Zhan.Liu@amd.com>

[Why]
DCN301 is capable of running seamless boot
if keep_stolen_vga_memory is not set.

[How]
Add a helper to check whether an ASIC can support
seamless boot and set it based on base driver flags.

Reviewed-by: Charlene Liu <Charlene.Liu@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Zhan Liu <Zhan.Liu@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 27 +++++++++++++++++++
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  3 +++
 .../gpu/drm/amd/display/dc/core/dc_resource.c |  1 -
 .../amd/display/dc/dcn301/dcn301_resource.c   |  2 +-
 4 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 729ab647f691..7b1b88dc98c3 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1454,6 +1454,12 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 
 	init_data.flags.power_down_display_on_boot = true;
 
+	if (check_seamless_boot_capability(adev)) {
+		init_data.flags.power_down_display_on_boot = false;
+		init_data.flags.allow_seamless_boot_optimization = true;
+		DRM_INFO("Seamless boot condition check passed\n");
+	}
+
 	INIT_LIST_HEAD(&adev->dm.da_list);
 	/* Display Core create. */
 	adev->dm.dc = dc_create(&init_data);
@@ -11612,3 +11618,24 @@ int amdgpu_dm_process_dmub_aux_transfer_sync(bool is_cmd_aux, struct dc_context
 			ctx, DMUB_ASYNC_TO_SYNC_ACCESS_SUCCESS,
 			(uint32_t *)operation_result);
 }
+
+/*
+ * Check whether seamless boot is supported.
+ *
+ * So far we only support seamless boot on CHIP_VANGOGH.
+ * If everything goes well, we may consider expanding
+ * seamless boot to other ASICs.
+ */
+bool check_seamless_boot_capability(struct amdgpu_device *adev)
+{
+	switch (adev->asic_type) {
+	case CHIP_VANGOGH:
+		if (!adev->mman.keep_stolen_vga_memory)
+			return true;
+		break;
+	default:
+		break;
+	}
+
+	return false;
+}
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index 37e61a88d49e..bb65f41d1a59 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -731,4 +731,7 @@ extern const struct drm_encoder_helper_funcs amdgpu_dm_encoder_helper_funcs;
 int amdgpu_dm_process_dmub_aux_transfer_sync(bool is_cmd_aux,
 					struct dc_context *ctx, unsigned int link_index,
 					void *payload, void *operation_result);
+
+bool check_seamless_boot_capability(struct amdgpu_device *adev);
+
 #endif /* __AMDGPU_DM_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index fabe1b83bd4f..d226ef799e50 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -2078,7 +2078,6 @@ static void mark_seamless_boot_stream(
 {
 	struct dc_bios *dcb = dc->ctx->dc_bios;
 
-	/* TODO: Check Linux */
 	if (dc->config.allow_seamless_boot_optimization &&
 			!dcb->funcs->is_accelerated_mode(dcb)) {
 		if (dc_validate_seamless_boot_timing(dc, stream->sink, &stream->timing))
diff --git a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
index e3596a5f68b1..7abc36a4ff76 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
@@ -686,7 +686,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.disable_clock_gate = true,
 	.disable_pplib_clock_request = true,
 	.disable_pplib_wm_range = true,
-	.pipe_split_policy = MPC_SPLIT_AVOID_MULT_DISP,
+	.pipe_split_policy = MPC_SPLIT_AVOID,
 	.force_single_disp_pipe_split = false,
 	.disable_dcc = DCC_ENABLE,
 	.vsr_support = true,
-- 
2.25.1

