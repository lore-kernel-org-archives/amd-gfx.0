Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97B79CC6B03
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Oct 2026 11:17:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B0D810E4E1;
	Tue, 13 Oct 2026 11:17:29 +0000 (UTC)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011063.outbound.protection.outlook.com [52.101.52.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 63D8010E4E1
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Oct 2026 11:17:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g3WnaNg0fVCMUMPO8+m3pj1KMpEaQtyWJ9CUwV0eo8eiv9ZMsk2FWBcjL49hkDopFX1pG12sW3a7UPYYbjEdC5FMzppJ7DWeLR/ev77tzlOfBNdy6fZfWYF6ksXoF7xfirxDaU+gKOMhRulkzFjb1PTpXqlCwjsqT9z8pnQoe6GhtyHtn9oG8B/TQHfNdnkOLKh3EdIpzUT2wVGa5oO3e7UcZihLEa1Qayp3RVjHCH6djpICkw+j+Y0NsGfLMOTUNOSXTcc9WcaJutQHVC9y5n6FiJfJSg3WsKkdFoJmaFfCjBk0YfAsCxUE2T5YdI3d3baj64B7fk5kissT/WsLQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HNSGP3xkgdi4SDpn0QAIfZEuqrqURrWKEgcvGQZTI5Y=;
 b=Zs4IW9NmI/Ai6ntYSDXYNA2+IxNXddgM3cS42RjFt2q80MOLBI6c8s41avNec9dTHiyw8dd1H6ZBCxwpqMAdWMAqpx6ygH1kwEKTiEKAuT6cLH2HfX9Pvofe+NWR3if2K0G2NIkyuyoAC3FevqgdlRg2HTEEguurrfA82RKxH1lxZAE6PBiS+AQswGvN49I8tBj/JciTkeNgJd40DaWNYT3XouP4/Kxnk4/POAPJIKwrvzHRhYNk1whMhVE2c04XgSIiA8QwU6pU+1v4EXzOzy5otqE1U6k/si9tBFuNPnsluQpgJeT9ovx/7SjN7v2H6ZA8mwI76Mn0t28KNR2vhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HNSGP3xkgdi4SDpn0QAIfZEuqrqURrWKEgcvGQZTI5Y=;
 b=QsPA70eSLTQa7P9WMr0fEd+6rIlFiokNqP+gdpCFdJOAJZ1tktUjjP2BTpGqkT+hiKbdyxzHEtXigMm6eAXVwyJKWps7L1oLdtia1xdSYQmLSUDkj6JOyUXRSXURQUysdxGhtohOnRc3IhCSGcuQGcikwK/GDScEjX2yPjG+bqg=
Received: from DS7PR03CA0231.namprd03.prod.outlook.com (2603:10b6:5:3ba::26)
 by CH4PR12MB635819.namprd12.prod.outlook.com (2603:10b6:610:509::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 11:17:19 +0000
Received: from DM3PEPF000265C3.namprd03.prod.outlook.com
 (2603:10b6:5:3ba:cafe::1c) by DS7PR03CA0231.outlook.office365.com
 (2603:10b6:5:3ba::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Tue, 13
 Oct 2026 11:17:19 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DM3PEPF000265C3.mail.protection.outlook.com (10.167.23.184) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Tue, 13 Oct 2026 11:17:18 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 13 Oct
 2026 06:17:12 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 13 Oct
 2026 06:17:12 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 13 Oct 2026 06:17:03 -0500
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Sharique Pervaiz <sharique.pervaiz@amd.com>, "Martin
 Leung" <martin.leung@amd.com>, Ray Wu <ray.wu@amd.com>
Subject: [PATCH 09/30] drm/amd/display: Add DPG force-on-flip support for
 SystemDisplayEnable
Date: Tue, 13 Oct 2026 19:07:56 +0800
Message-ID: <20261013111616.2267344-10-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013111616.2267344-1-ray.wu@amd.com>
References: <20261013111616.2267344-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PEPF000265C3:EE_|CH4PR12MB635819:EE_
X-MS-Office365-Filtering-Correlation-Id: b31fc8d2-d429-4939-0b7c-08df291b8b24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700016|23010399003|82310400026|56012099006|11063799006|261009223027099003|10067099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: iQ1npuL4Ym+Hbsv+uhHwJWE1T+UQGk3AjLSUJCIdjfJKfzQEN3e7Gfq0nMrmTyIWeEEv3Kwc9+bYSAPxevkPxD2Ibjw4KRGGvQUYWjjPxJ8KyVqw3b5x+22k66Zbi6tLkwmwK0ZInuWuIrQAQyCEBqlp0GJkGFpy58SizdEu7yv/lTxrq7fA4Ls4kYekOf7HWw13CSeD7rMey13gbEuyY54lRS76P27Xk7NY2eGekLpgItJzV0x+WfyCkbDVUxL9gTQqO8sq3AP3zMt/K14fQjYYgbNFNikWdvhLa572ASRE187GEIJJsf6tH9znJbb+83jrAMsNN7GI7AahiFItzC0JtW/Jj8a/1+RUs1L18U248985Iiutxf9SuoB+TwsUO7zLZ2WSILYk1UyXbci10KoQZ9YDYh/1rIK05/SPu1+o2YEuF/tfnVgAz5PJyM+Vm3o9Lsa9clGXd0ts7rhKy3K8Q+UheLGet83vsJjRYsymCigu+FNn31Ta65qKYEIVq4nteC05MwKt0bRr8+N3qK2+9xFNoxMIRabtZyNBUmEbzJ3CzDyYJAefnhs+Vcb1rV7A8ahbHR8HTff7dIvTZY7v5SbdufR1xgOQ700eeEMBg4yIYjiZaQPN77tdYel3hMVlIDdVVJ8a66NvMn8gVajUMyH6KVDv6NqIxGdnUoiMzWAxZ/Q3bOvviJ4S3LrafLEKLcNdoj2Xqpzdc09NxQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700016)(23010399003)(82310400026)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0DI510XfBvn5DxHpheyOzknif/DAgNH4RYp8Zu7t7KmddcRx8l4IeWv/UEsyuAA6tIogeDQZqwZu46ePao2IB47qVfLU+ky0HN3MLB+MObSVkXqbbisLm8N7EallsMhi8ZdSJYmgtUkzM76H7OG75be4dSYBbIm6OIjpF6wIPlITy8blbcHvLqeVaGZm+hzeHWI+XdCNBHVp4ELmwB5Yq3NPKYX8jVsGlWxfjwXK8NWggeetYFfftB8feu6RgDajQ7EiCEMeJhmpV3n+dCQjtDqKWX0SUr7j2t/DOZNHIHDUhX7RoISWc4xTBJuj3Drc4psrxJSrtOoU7d2S0x5rppINUZNJscoNnRerIdR/a3eDDBptvPCP6A/gy4H8QHGpOykB+W+3sTjrdX7s2Gnt7YknlUDIF2AJdmry8BPS0KH5IdJr6X8ENBuwXndjKCVu
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 11:17:18.4347 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b31fc8d2-d429-4939-0b7c-08df291b8b24
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3PEPF000265C3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR12MB635819
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

From: Sharique Pervaiz <sharique.pervaiz@amd.com>

[Why & How]
Add force_dpg_on_flip debug option so DM can drive a solid-color DPG
pattern on the final flip instead of a real surface flip.

Reviewed-by: Martin Leung <martin.leung@amd.com>
Signed-off-by: Sharique Pervaiz <sharique.pervaiz@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h                   |  1 +
 .../gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c   |  7 +++++++
 .../gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c | 11 +++++++++++
 3 files changed, 19 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 91d4a8ec7a94..5bd990138f20 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1188,6 +1188,7 @@ struct dc_debug_options {
 	bool enable_dmcub_surface_flip;
 	bool usbc_combo_phy_reset_wa;
 	bool force_fva;
+	bool force_dpg_on_flip;
 	int max_frl_rate;
 	unsigned int  force_frl_rate;
 	bool ignore_ffe;
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
index b0cc1f2506ba..636cbd947918 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
@@ -1249,6 +1249,13 @@ void dcn20_blank_pixel_data(
 	/* get opp dpg blank color */
 	color_space_to_black_color(dc, color_space, &black_color);
 
+	/* Debug: force a solid blue DPG pattern. */
+	if (dc->debug.force_dpg_on_flip) {
+		black_color.color_r_cr = 0;
+		black_color.color_g_y = 0;
+		black_color.color_b_cb = 0x3ff;
+	}
+
 	if (blank) {
 		dc->hwss.set_abm_immediate_disable(pipe_ctx);
 
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index a843e216a6b0..f2391d45d4c5 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -2723,6 +2723,17 @@ void dcn401_program_front_end_for_ctx(
 			pipe->plane_res.hubp->funcs->hubp_wait_pipe_read_start(pipe->plane_res.hubp);
 		}
 	}
+
+	/* Debug (DM SystemDisplayEnable, driver disabled): force solid-color DPG
+	 * output last, after all normal pipe/OPP programming, so it isn't overwritten.
+	 */
+	if (dc->debug.force_dpg_on_flip && hws->funcs.blank_pixel_data) {
+		for (i = 0; i < dc->res_pool->pipe_count; i++) {
+			pipe = &context->res_ctx.pipe_ctx[i];
+			if (resource_is_pipe_type(pipe, OTG_MASTER))
+				hws->funcs.blank_pixel_data(dc, pipe, true);
+		}
+	}
 }
 
 void dcn401_post_unlock_program_front_end(
-- 
2.43.0

