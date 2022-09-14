Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6B44ECAAD8
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Sep 2022 05:13:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6CC9A10E82F;
	Wed, 14 Sep 2022 05:13:42 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2060.outbound.protection.outlook.com [40.107.237.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6674810E55F
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Sep 2022 05:13:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LvTRd/5ldAWK1g0WavfcPo1kHAwTguq23hwGJCMUT+kJEPHbAThfBPa619GOWN2Nzv1qCjBgYLjr2FCANVtjI1Wap0To+jw6WjQf6RPQ9mXoVJB9k1hMOxLI62OV3fAype07TcbUA2403M39nsHKnWXTIzvxtY15BzyvwORnGU+oAxEvz6D9OffzzZRpF30X5CnWcZR+Ybio2uUx6aHYjHh6ZkX4Xt0sHRa2IBFxeqYoYGQhN8kYIWXtT2Mkpiaas60j+W160il3jH/WqG2XMdzpVH3bSI2sp+PRTMxit5WeLusP/I6Z0UEnkriLm8CBEatyE6CXCXbWNIQQRKU/wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ustIEJ7rt1h/Jxej59DLgAVxmJN1egO9c6HGTnDG204=;
 b=PRWLXdlzgRtNVg1x/74ZH6bIZai2H9L8+9L4fcq0u05CeP0RQ3dSNhT4dP7MLuiRoSWKJf2WymvxCJpICJUO1odE/Ed/ULvOKt6TSwz7/WsTiiLBqhQzO9SPDSB+mV+lAzCcO2Kp7MiFEdTmdX8sEAXjMAEMl5hlmMBtcxjZiXPzvaLxq70AajlSltloOuZ2367GVfHDzzq8npGJrFYLjULJkzGZtHqLXeIc2yZc0VoK6SIsl7H0GUFdHBCjGuU1c9KMPyk2Oie4jmWO2W9A4+ZPAe8nEcTMTax5bgFKZF71oYGcJG+0npx+UqcyLd6fq3gPKkALCMCNN+HVgEmZ/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ustIEJ7rt1h/Jxej59DLgAVxmJN1egO9c6HGTnDG204=;
 b=HCoBzXd6Cpyuf8Akem8C1rtdmGg0Loe4O/KQx8azYKN9KYXQatEhnQGkiqKpffzN7/pv5xGUmf9edIhi9hh6eEsvABUUdktPQVi2U1DynSsfYwlqXN3agjAqlC+jV/LLeg9e/B5akQQtydl68aB+OURRr9B9fn40VtdfbNnL4eM=
Received: from DM6PR14CA0062.namprd14.prod.outlook.com (2603:10b6:5:18f::39)
 by BL3PR12MB6377.namprd12.prod.outlook.com (2603:10b6:208:3b0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Wed, 14 Sep
 2022 05:13:29 +0000
Received: from DM6NAM11FT081.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:18f:cafe::b5) by DM6PR14CA0062.outlook.office365.com
 (2603:10b6:5:18f::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.15 via Frontend
 Transport; Wed, 14 Sep 2022 05:13:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT081.mail.protection.outlook.com (10.13.172.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5632.12 via Frontend Transport; Wed, 14 Sep 2022 05:13:28 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 14 Sep
 2022 00:13:28 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Wed, 14 Sep 2022 00:13:23 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V3 12/47] drm/amd/display: For ODM seamless transition require
 AUTO mode
Date: Wed, 14 Sep 2022 13:10:11 +0800
Message-ID: <20220914051046.1131186-13-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220914051046.1131186-1-Wayne.Lin@amd.com>
References: <20220914051046.1131186-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT081:EE_|BL3PR12MB6377:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e498709-a8de-4dc5-6328-08da960fdc24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VbrFQAHhRtj4y+I1UYKGKUOUE3LJupjq/xyg00BSOprN+kg6NSO4bveARvptSG6FnVxfVO6GD6mX1kX6xNCoCj57N9SmOyWKto1KPTGf6IVcvdomrc+Aycx6WCtpjLHsVdHo/vY4yLmVRE9frlNz4rUEkOdU7z3FRC7BinpbV1O4WOk0MCFs4fOaSvZ+F8kz/OSnXiKkz2LBBcyYkwM4ZfOH1OW41SBGkH4s3KJafQpzUcBjoif9rRzg27hKlC5I2G630G+DIoCu7tAPm50nKJNhQnDM5txfxnx7QzRhFMX6XuQoVGvo/hc7SDuQUiUNjMfof+ohBPOzOkIlMZ8ynnotDN1Ek9CcQU7iP+7gICDULCEUeWPXntm5JYKe4IHXz99DrOAFC1126OYHp2uDO9scLiAnCsh9nhHtX+QsS/YaHyrKANAfVgRqc4b94WqOJQ6Uq1O6i6zG0G9vg8i3dNCetXnK5pEjSwXoknqZsxdsIenvHBzoD78cdlZ/Qx2yC8An7QOnraZCw399dEGNU3mDhOxZC8fbM45uxPLdfgcVXoK6GMONLLMYn74yf50uA+0PZFyoYR2RubA/m5/YLi9b9355i1QTzMFUSNiRNPQkgEDqsXbScYn2zH2dLSum5eKW5xwHoR+JRDgSF4maB0GgZjtWk+ZWWX/iLKrrltAxZf51EtCYXfwwhhZXd3bP73mV0/KcIl/l66FZbdRJ4Bt43MYrgNpSdIgmpa7AAWQ5bKAd3w/g+iXNZniFVJckp/c/YWiyCVO7w8oGrZwBwWpMt9gaVpNGg8GnY917ZGZMcVDMzo/2mW6eiwcc0Kle
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(346002)(39860400002)(136003)(376002)(451199015)(36840700001)(40470700004)(46966006)(8676002)(36860700001)(70586007)(70206006)(8936002)(82310400005)(356005)(336012)(36756003)(6916009)(47076005)(7696005)(1076003)(2906002)(26005)(41300700001)(426003)(40480700001)(40460700003)(86362001)(5660300002)(4326008)(316002)(186003)(2616005)(83380400001)(6666004)(81166007)(54906003)(478600001)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 05:13:28.7300 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e498709-a8de-4dc5-6328-08da960fdc24
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT081.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6377
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
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, Alvin Lee <Alvin.Lee2@amd.com>,
 wayne.lin@amd.com, Jun Lei <Jun.Lei@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <Alvin.Lee2@amd.com>

[Why & How]
ODM seamless transitions require DIV_MODE_AUTO. However,
DIV_MODE_AUTO only works when all the horizontal timing params
are divisible by the ODM combine factor. Therefore, disable the
ODM 2:1 policy when the horizontal timing params are not divisible
by 2.

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_resource.c | 22 +++++++++++++++++++
 .../drm/amd/display/dc/dcn32/dcn32_resource.c |  3 ++-
 drivers/gpu/drm/amd/display/dc/inc/resource.h |  2 ++
 3 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 29f27e3fe3ac..5bedee56acd4 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -3645,3 +3645,25 @@ const struct link_hwss *get_link_hwss(const struct dc_link *link,
 	else
 		return get_virtual_link_hwss();
 }
+
+bool is_h_timing_divisible_by_2(struct dc_stream_state *stream)
+{
+	bool divisible = false;
+	uint16_t h_blank_start = 0;
+	uint16_t h_blank_end = 0;
+
+	if (stream) {
+		h_blank_start = stream->timing.h_total - stream->timing.h_front_porch;
+		h_blank_end = h_blank_start - stream->timing.h_addressable;
+
+		/* HTOTAL, Hblank start/end, and Hsync start/end all must be
+		 * divisible by 2 in order for the horizontal timing params
+		 * to be considered divisible by 2. Hsync start is always 0.
+		 */
+		divisible = (stream->timing.h_total % 2 == 0) &&
+				(h_blank_start % 2 == 0) &&
+				(h_blank_end % 2 == 0) &&
+				(stream->timing.h_sync_width % 2 == 0);
+	}
+	return divisible;
+}
\ No newline at end of file
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
index 6bc0fe922599..d757d1638fa7 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
@@ -1871,7 +1871,8 @@ int dcn32_populate_dml_pipes_from_context(
 		timing = &pipe->stream->timing;
 
 		pipes[pipe_cnt].pipe.dest.odm_combine_policy = dm_odm_combine_policy_dal;
-		if (context->stream_count == 1 && !dc_is_hdmi_signal(res_ctx->pipe_ctx[i].stream->signal)) {
+		if (context->stream_count == 1 && !dc_is_hdmi_signal(res_ctx->pipe_ctx[i].stream->signal) &&
+				is_h_timing_divisible_by_2(res_ctx->pipe_ctx[i].stream)) {
 			if (dc->debug.enable_single_display_2to1_odm_policy) {
 				if (!((plane_count > 2) && pipe->top_pipe))
 					pipes[pipe_cnt].pipe.dest.odm_combine_policy = dm_odm_combine_policy_2to1;
diff --git a/drivers/gpu/drm/amd/display/dc/inc/resource.h b/drivers/gpu/drm/amd/display/dc/inc/resource.h
index 58158764adc0..a58f80ac94ba 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/resource.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/resource.h
@@ -224,4 +224,6 @@ uint8_t resource_transmitter_to_phy_idx(const struct dc *dc, enum transmitter tr
 const struct link_hwss *get_link_hwss(const struct dc_link *link,
 		const struct link_resource *link_res);
 
+bool is_h_timing_divisible_by_2(struct dc_stream_state *stream);
+
 #endif /* DRIVERS_GPU_DRM_AMD_DC_DEV_DC_INC_RESOURCE_H_ */
-- 
2.37.3

