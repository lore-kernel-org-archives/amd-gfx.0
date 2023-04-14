Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A949BC77B78
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Apr 2023 15:54:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0536610EDDC;
	Fri, 14 Apr 2023 15:54:43 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2084.outbound.protection.outlook.com [40.107.212.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E91E10EDD9
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Apr 2023 15:54:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nTwc8Gp4w0qF++mnpDDM78P6N+ybb3glwQyK9gzVnPcPnjuMDpCjxK9T2ykv0HmRQuo+9FWhK7OJZ9eHIAX6/MXT11o1qRyxO0V8IIuYYUWN0zbadKZk7njHdERBMCWltrlmYpoE7VbTguyJybTAUumsbU1lAOHfwgnvCTrD1AJa0hvCLgYfQqqm/PYtC5l/wwpMVCD7DQuFId3GID9JKEbqcZHNedtVlumU7j5P4bmV5NzdzVCtjwdeb2VIF5YbdZhHpLRxDdg3OUZwuGWJAc+FJOacT/RLoLhY0IrGtoRyjMQpMKW0LrSKnB7cjB0doAhkF7OXW7yczXe+uZL3Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/lnAA8Ee3Lw/yGwtAkpJ27ctgZRuBRQp7pC/8jXIaws=;
 b=VnJwYuaC6TqRwwOuQXXY35WxdYbTnt8NY/tISa12UxCFKvpzjya3onALWqjH1YpakM0PdSxBxQ4EkVrA9+tVDonmMNARWfmWpPllvqS9haxTf6xBksDSkhfM9T98B//oD5bUV3gV7Iaoi0k190020G/cUCJJIzx0ZrRZ6VyjlidnCk/wF5uXvtqdYJq7nEEKoxsYpYwA1YC6lnkqhvbmRcDBV4pLBuY4RojOwYSLZJAQ8AtWEpyfLVcq4pI/x3SS+0nNX+/uhUbs/KS49Dg/NnWdBEmxRWWiqRTLuKl9ZVRHFUesZU9OY8oWTpcJUJnZNoRlf8iXr1/zpFGpLVxj9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/lnAA8Ee3Lw/yGwtAkpJ27ctgZRuBRQp7pC/8jXIaws=;
 b=v1Pjo4OfgtzM2NbyZSdpYAuwXdCDfueIIQxPJAqNvxFbEqzWcEGUFOroy2/6SoLhV5/8O8VZieeudB4iQ4Gq/Eh+Sw5h3TvFvBq2gSlbD9/gIG8nwgvR54EmqWohH5WONlmUr8j5Cbjk1RTfc6zUz/6kDvB9lquV8ACRknapTM8=
Received: from BN9PR03CA0455.namprd03.prod.outlook.com (2603:10b6:408:139::10)
 by CH0PR12MB8488.namprd12.prod.outlook.com (2603:10b6:610:18d::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Fri, 14 Apr
 2023 15:54:36 +0000
Received: from BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:139:cafe::b1) by BN9PR03CA0455.outlook.office365.com
 (2603:10b6:408:139::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.36 via Frontend
 Transport; Fri, 14 Apr 2023 15:54:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT048.mail.protection.outlook.com (10.13.177.117) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.36 via Frontend Transport; Fri, 14 Apr 2023 15:54:36 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 14 Apr
 2023 10:54:33 -0500
From: Qingqing Zhuo <Qingqing.Zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 32/66] drm/amd/display: add extra dc odm debug options
Date: Fri, 14 Apr 2023 11:52:56 -0400
Message-ID: <20230414155330.5215-33-Qingqing.Zhuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230414155330.5215-1-Qingqing.Zhuo@amd.com>
References: <20230414155330.5215-1-Qingqing.Zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT048:EE_|CH0PR12MB8488:EE_
X-MS-Office365-Filtering-Correlation-Id: 702e350d-a85b-43da-7ef6-08db3d008bf8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JcjqMRj+Z5lWLoTTpkTZw6U8w0NaqW/dwUX0sQweFGhKitzQC1oIUmIM1/XUZNJbKi1rSv6K7rkzvnG0yYkSsbk2vhaX+3E48asxRRrgjbKbhIPhyJIApZNXOF9dxHL+9FbqG1uuExttAE7E5JbyfIn1MUzpIC0YZGy7+G9c4yQm06fm91uyvnxxUyfvrSA+2u9Wk0s+nBTJ1VrOr6BltMZmTtwlGOiZl1G2KR1Gl+WseDaDwujEg6Bx3A0S124hL+S1hnd4whBACTwtunb1zXGR1GEik28mKtGJRwheGReLv5gyQBxvpV6D/x5WXthYqNV2ReHVKXFoT5l7/iF4Mu8Lyc4x5jiQCGUgPO3vQtaN5ALkOvgtu7VPFt06ksgllWyjeafqZOV+J9XfeChNP85oovp5Iq/KYtBFJnAeeCVcYYZDkEGpYtY+ZnKSSyKhyc/ZJtiC1TGxWvYrKtYr7ziKf3VVX7N9g+xFzOm605VV8GxZDOZ9Gn20NzqhqW7u15jJrTZ4Pn6+VKBN8J+ZFUOydooOo43NrO9eBDd+yx057zlolNOl+jtkX827JHXNXNJlAekOP1iQoCxFP9ABmliJOdfiVmCZBWACXfwmx5dbFl/DRocSbv1C188pEZoe7sN7OZpcfBS08fHKbmgTYCFj9O2KqWSisKUIEk+2ORyn9u1aWNftpQPMuld1J4trNz87rPFcUxFsEGs+mgsfvrMwuPvBU4OhZ/mXUnY1R2Q=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(376002)(346002)(136003)(396003)(451199021)(46966006)(40470700004)(36840700001)(40460700003)(2616005)(426003)(336012)(2906002)(26005)(1076003)(186003)(16526019)(47076005)(8676002)(4326008)(70586007)(70206006)(6916009)(41300700001)(54906003)(316002)(478600001)(5660300002)(6666004)(36860700001)(40480700001)(8936002)(356005)(81166007)(82740400003)(86362001)(82310400005)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2023 15:54:36.0201 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 702e350d-a85b-43da-7ef6-08db3d008bf8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT048.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8488
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
Cc: stylon.wang@amd.com, Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, Ariel Bernstein <Eric.Bernstein@amd.com>,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>

[Why & How]
Add options for dc odm debug.

Reviewed-by: Ariel Bernstein <Eric.Bernstein@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h        | 2 ++
 drivers/gpu/drm/amd/display/dc/dc_stream.h | 5 +++++
 2 files changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 23ee63b98dcd..3595149deceb 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -879,6 +879,8 @@ struct dc_debug_options {
 	uint32_t fpo_vactive_margin_us;
 	bool disable_fpo_vactive;
 	bool disable_boot_optimizations;
+	bool override_odm_optimization;
+	bool minimize_dispclk_using_odm;
 };
 
 struct gpu_info_soc_bounding_box_v1_0;
diff --git a/drivers/gpu/drm/amd/display/dc/dc_stream.h b/drivers/gpu/drm/amd/display/dc/dc_stream.h
index 270282fbda4a..0add5ecc895f 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_stream.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_stream.h
@@ -172,6 +172,10 @@ struct mall_temp_config {
 	bool is_phantom_plane[MAX_PIPES];
 };
 
+struct dc_stream_debug_options {
+	char force_odm_combine_segments;
+};
+
 struct dc_stream_state {
 	// sink is deprecated, new code should not reference
 	// this pointer
@@ -182,6 +186,7 @@ struct dc_stream_state {
 	 * a stream via the volatile dc_state rather than the static dc_link.
 	 */
 	struct link_encoder *link_enc;
+	struct dc_stream_debug_options debug;
 	struct dc_panel_patch sink_patches;
 	union display_content_support content_support;
 	struct dc_crtc_timing timing;
-- 
2.34.1

