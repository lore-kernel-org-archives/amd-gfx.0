Return-Path: <SRS0=uIzi=PX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13DA2C433F5
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Nov 2021 20:52:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCCA260720
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Nov 2021 20:52:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BCCA260720
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3177E7361C;
	Thu,  4 Nov 2021 20:52:30 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2067.outbound.protection.outlook.com [40.107.243.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE4E472DF9
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Nov 2021 20:52:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GCUvabCsztYe26cSlxCjOr1aoZIpYr1EGIz8y5PBQ6BZBuSUsZWsnIY3UPA6OQKbxzsd5QonjzoUE/g6jQvZjFDVatPl+vXZRNfXvBcIhyRMp/8NHV9qc2kOgDlr9UL63r01KyxiTzRHQfFOd8LmYsnXiNbvZR2xtgJ1oO/rr5WUUxHIltPhRxRZCxTahWoJGxegG1FbxZFsTo96QV+rW0xe3ZZKiyiDy62KmWFHOs1G3q8QlVWpe2vnl4BGTrjB33iPqd/xjMYa0yNIVB5Eq9tjvGoCLlGd/IXoZ9PD4ZyK6+9I7MRVnIDVsZ5btZPFxB+A2PTVspSht5hO+yT74Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tgpiabQlKl6/QKKI5atRvTUMjVuoZKkUgAtO35crfl4=;
 b=ir7YrhhYV+c5npzExQc1Qrod16MpoKRrtY4Lvfh0Z2POag0ygGmB8pzZxPz/GdPdoDYMktH1ceYjF9P5OSQB31ramffNh4dito+K4Y7IqT+lKO2jzQWOAkWSvHpqV/cPA7GEt2hHdRdRfwsWGvf/VMZPpeIDPA5Y5GIMcCa6xhXvrK7QNt9nJ9r5ujoVkn/whCo82jB4na9w7Uz2M5+tezcLzz7rNBHMqPR90vxH33XNJJta2wrSrM3sSGDTfpzCVTuDGN6Bc5NIY23pa4wwuMC3tnl0ZEVCnjwT1PpfJOwsNAqM6dt0IY0h0ka/jadAFvBUh4cGJN11etUEQ4TwiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tgpiabQlKl6/QKKI5atRvTUMjVuoZKkUgAtO35crfl4=;
 b=YBomdI37ML4E3ZxKyMOeNopzpzl6qK05KjNMYPc04fDWFk5+mfTGSWs4L5t98b0+uqoCQfuIyJOxeHnMe6vOZZQd91D964qjJRduc59sx5Fyr9d8bAPvZbS3W49PdG7m8IfGBUgvtWiYk4fiRJpK1XXkjZy8WkCeCBYZr6ILklg=
Received: from DM5PR12CA0013.namprd12.prod.outlook.com (2603:10b6:4:1::23) by
 DM6PR12MB3225.namprd12.prod.outlook.com (2603:10b6:5:188::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4628.18; Thu, 4 Nov 2021 20:52:26 +0000
Received: from DM6NAM11FT057.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:1:cafe::76) by DM5PR12CA0013.outlook.office365.com
 (2603:10b6:4:1::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11 via Frontend
 Transport; Thu, 4 Nov 2021 20:52:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT057.mail.protection.outlook.com (10.13.172.252) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4669.10 via Frontend Transport; Thu, 4 Nov 2021 20:52:25 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Thu, 4 Nov
 2021 15:52:24 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Thu, 4 Nov
 2021 15:52:24 -0500
Received: from Optimus.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2308.15 via Frontend
 Transport; Thu, 4 Nov 2021 15:52:23 -0500
From: Anson Jacob <Anson.Jacob@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 04/22] drm/amd/display: Add comment where
 CONFIG_DRM_AMD_DC_DCN macro ends
Date: Thu, 4 Nov 2021 16:51:57 -0400
Message-ID: <20211104205215.1125899-5-Anson.Jacob@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211104205215.1125899-1-Anson.Jacob@amd.com>
References: <20211104205215.1125899-1-Anson.Jacob@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f66f2d72-5ae7-4ca4-6229-08d99fd501c1
X-MS-TrafficTypeDiagnostic: DM6PR12MB3225:
X-Microsoft-Antispam-PRVS: <DM6PR12MB32250F8FD3E19FC2368B3666EB8D9@DM6PR12MB3225.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1850;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UNJIgUfjOwu2VZpJ87dDyb95f63NQChELEDb3G2eH5psQPTmgcl3/zejgXtwdHTCkbs96y204x1uzzhyQO1RnqKxq1fQfj8quzVQDrrc4CqL+NcBEzoUBsKeDLC4gB/rV/EerJ5b/+GXMa9cQPpZpo2bdPYLbwpSwpvXf5lvz1N1GQf8PzFf/i8f5PfGqc3MRCTbl1iu32nmCDIMtgwnMjD5ZEAqOJbxNZ/Y3VXmew7d1dGoEUpexMPWuePbxP3yTm5gNv2K8VeOak4k768/RVrF9xAcK16zwejeMvwpKCudoY/ZY6pnMF9vNVbmM1BsmW6Hqcg80rADZaPvGRwryHFlElKawpJ+W84vZqj9ohESV1BrBEdLdjYteRCOx2MqSi5DUJfFRwkSnd4Z3z6zY7V9CevqOnqmF2FD9SQ4Pi4pXD2m/U17GC/h3S2nirBkO8qgpVDvfCIeMxNOcQ6FDQCqeYMBdkNJKfImQ5L+hC6JG3RKT/GliFFz/cuDl1wloosz14D7ZB0OyBCKQ+EyhFlQS+dGcDpDTQW1lnoBv9mOGy8cu+/Doi79c8ceD69iiAXtV+NiNTwJVC/OvRsRy+AaNkAVU5BrY6gjAVb4+wkVw7MVVuCj2GfUT+5XirYFLAtqeujSjVMfsJKRSfK6crWyOZ40quJG7CkcyktVW9tc/CF7FoDbex4NrfdLhnQyWd27C+6I2lGEYYXy/16hAlAiNKR7F5QmsEui7P8F3bc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(54906003)(8676002)(316002)(86362001)(26005)(6916009)(5660300002)(426003)(81166007)(1076003)(2906002)(2616005)(36860700001)(70586007)(36756003)(70206006)(6666004)(356005)(83380400001)(186003)(4326008)(508600001)(82310400003)(336012)(47076005)(8936002)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2021 20:52:25.5137 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f66f2d72-5ae7-4ca4-6229-08d99fd501c1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT057.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3225
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
Cc: stylon.wang@amd.com, solomon.chiu@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com,
 Ariel Bernstein <Eric.Bernstein@amd.com>, wayne.lin@amd.com,
 mikita.lipski@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Trivial patch which adds a comment for macro
endif's in amdgpu_dm.c

Reviewed-by: Ariel Bernstein <Eric.Bernstein@amd.com>
Reviewed-by: Harry Wentland <Harry.Wentland@amd.com>
Acked-by: Anson Jacob <Anson.Jacob@amd.com>
Signed-off-by: Anson Jacob <Anson.Jacob@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 8 ++++----
 drivers/gpu/drm/amd/display/dc/core/dc.c          | 6 ++++--
 drivers/gpu/drm/amd/display/dc/core/dc_link.c     | 2 +-
 3 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 1e26d9be8993..5d646acd269d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -619,7 +619,7 @@ static void dm_dcn_vertical_interrupt0_high_irq(void *interrupt_params)
 
 	amdgpu_dm_crtc_handle_crc_window_irq(&acrtc->base);
 }
-#endif
+#endif /* CONFIG_DRM_AMD_SECURE_DISPLAY */
 
 /**
  * dmub_aux_setconfig_reply_callback - Callback for AUX or SET_CONFIG command.
@@ -812,7 +812,7 @@ static void dm_dmub_outbox1_low_irq(void *interrupt_params)
 	if (count > DMUB_TRACE_MAX_READ)
 		DRM_DEBUG_DRIVER("Warning : count > DMUB_TRACE_MAX_READ");
 }
-#endif
+#endif /* CONFIG_DRM_AMD_DC_DCN */
 
 static int dm_set_clockgating_state(void *handle,
 		  enum amd_clockgating_state state)
@@ -1563,7 +1563,7 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 			DRM_ERROR("amdgpu: fail to register dmub hpd callback");
 			goto error;
 		}
-#endif
+#endif /* CONFIG_DRM_AMD_DC_DCN */
 	}
 
 	if (amdgpu_dm_initialize_drm_device(adev)) {
@@ -6077,7 +6077,7 @@ static void apply_dsc_policy_for_stream(struct amdgpu_dm_connector *aconnector,
 	if (stream->timing.flags.DSC && aconnector->dsc_settings.dsc_bits_per_pixel)
 		stream->timing.dsc_cfg.bits_per_pixel = aconnector->dsc_settings.dsc_bits_per_pixel;
 }
-#endif
+#endif /* CONFIG_DRM_AMD_DC_DCN */
 
 /**
  * DOC: FreeSync Video
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 398de46fb7e4..0ded4decee05 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1892,6 +1892,7 @@ static bool is_flip_pending_in_pipes(struct dc *dc, struct dc_state *context)
 	return false;
 }
 
+#ifdef CONFIG_DRM_AMD_DC_DCN
 /* Perform updates here which need to be deferred until next vupdate
  *
  * i.e. blnd lut, 3dlut, and shaper lut bypass regs are double buffered
@@ -1901,7 +1902,6 @@ static bool is_flip_pending_in_pipes(struct dc *dc, struct dc_state *context)
  */
 static void process_deferred_updates(struct dc *dc)
 {
-#ifdef CONFIG_DRM_AMD_DC_DCN
 	int i = 0;
 
 	if (dc->debug.enable_mem_low_power.bits.cm) {
@@ -1910,8 +1910,8 @@ static void process_deferred_updates(struct dc *dc)
 			if (dc->res_pool->dpps[i]->funcs->dpp_deferred_update)
 				dc->res_pool->dpps[i]->funcs->dpp_deferred_update(dc->res_pool->dpps[i]);
 	}
-#endif
 }
+#endif /* CONFIG_DRM_AMD_DC_DCN */
 
 void dc_post_update_surfaces_to_stream(struct dc *dc)
 {
@@ -1938,7 +1938,9 @@ void dc_post_update_surfaces_to_stream(struct dc *dc)
 			dc->hwss.disable_plane(dc, &context->res_ctx.pipe_ctx[i]);
 		}
 
+#ifdef CONFIG_DRM_AMD_DC_DCN
 	process_deferred_updates(dc);
+#endif
 
 	dc->hwss.optimize_bandwidth(dc, context);
 
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index b4cdf6d43965..d856f08491de 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -4821,7 +4821,7 @@ uint32_t dc_bandwidth_in_kbps_from_timing(
 				timing->dsc_cfg.bits_per_pixel,
 				timing->dsc_cfg.num_slices_h,
 				timing->dsc_cfg.is_dp);
-#endif
+#endif /* CONFIG_DRM_AMD_DC_DCN */
 
 	switch (timing->display_color_depth) {
 	case COLOR_DEPTH_666:
-- 
2.25.1

