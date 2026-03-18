Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18A6CFEDA09
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2026 01:01:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF89310E5F7;
	Wed, 18 Mar 2026 01:01:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="30lDnFhE";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011046.outbound.protection.outlook.com
 [40.93.194.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3424A10E5F7
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Mar 2026 01:01:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yYZk4nAGbIfF2HYY4CnhULFNgg6RdsVfPduqlKYOdaPHKYCxcKn52FGtP3X+RgGdQ68Ut2v4ecci3GqndP/sZcowN2Cq/vD648tCiOAt0Yy4P3CekPbmjhkXi0RvMD98dErt9EFr1LYS8jWNYPtI8seGCluNfUxdYRX7H00ToUvE+8/Cr13CY0tPHrrPvEW4zgQ+fvIdr1OVeCQRXvCBavPFfUD3MHgGO8LwCxWd7znWtAgu+oqZmIUcrBEVSA60uPvPnlB+/zW+ETkk5H45Ipc6zAhdXHZsZ0zeVXvnjhVVX0c/hthZxAn41/f9uCk29v6L8UPb2qZ1FnNAe5fLng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=54YNEG94eW5keo/EUcM3Vh4hiUAwZykWOViWUTMShn8=;
 b=RiufDVKHHy/JetIA++QrwCsJ2FPuIwXbSefg8+YLRmneUc3oeY4tgKap+Ti+6c+jc6WE6TvqToiHQwMeA0Cj0n8fQch5QjnZGrxYlR0ukGhqGFNtHMEY8Veef5iZR2UknD0ITOFbX9XmWIuSdcZyBKqd351S+enG1+J7fEgk6HqYICvloe+T0CUQqCZHH6AJ7brLAocjU+ZuzLzdd5GioF+LKwQdBgE7gcNxAhkFWZwTI2r4bacZoBzQl6DW6OTu9fiwPwihWqJCvtathSdYFVLTlJI773PvCF8GqE/h2xd3n3t41RhRdIh1g4RKbvvW7x+p2oFa9CEhHCoDCRqjxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=54YNEG94eW5keo/EUcM3Vh4hiUAwZykWOViWUTMShn8=;
 b=30lDnFhEw3o5j0jTo5eCDy1kDywXVBW6GcUWPtWPeAdoryWJ+y98d4wVkBi7zjbAOECZL4exUYcWjF3RBGdag1KOtvpho9R8mF7orRCIEJjXvDqmVkU0IHqJvM18JAYWGMbsAFnVroofvvlfeuEKG+GHbRjwNGleyQC1dI+rWdw=
Received: from SN7PR04CA0184.namprd04.prod.outlook.com (2603:10b6:806:126::9)
 by SA0PR12MB4416.namprd12.prod.outlook.com (2603:10b6:806:99::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 01:01:38 +0000
Received: from SN1PEPF000397B2.namprd05.prod.outlook.com
 (2603:10b6:806:126:cafe::7c) by SN7PR04CA0184.outlook.office365.com
 (2603:10b6:806:126::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.25 via Frontend Transport; Wed,
 18 Mar 2026 01:01:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397B2.mail.protection.outlook.com (10.167.248.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Wed, 18 Mar 2026 01:01:37 +0000
Received: from maxMSI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 17 Mar
 2026 20:01:34 -0500
From: ChuanYu Tseng <ChuanYu.Tseng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Roman Li <Roman.Li@amd.com>, Charlene Liu
 <charlene.liu@amd.com>, Ovidiu Bunea <ovidiu.bunea@amd.com>, Chuanyu Tseng
 <Chuanyu.Tseng@amd.com>
Subject: [PATCH 10/31] drm/amd/display: Clamp min DS DCFCLK value to DCN limit
Date: Wed, 18 Mar 2026 08:59:19 +0800
Message-ID: <20260318010224.513094-11-ChuanYu.Tseng@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260318010224.513094-1-ChuanYu.Tseng@amd.com>
References: <20260318010224.513094-1-ChuanYu.Tseng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B2:EE_|SA0PR12MB4416:EE_
X-MS-Office365-Filtering-Correlation-Id: c204dffe-b593-4ffb-9128-08de8489e88e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|82310400026|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: IhBkmYdNh0N3DJ0GYTvSUFtA7IKDMjT9u19xKoseIJF7w5IoJm18huqEu5i7VjhQxatZ0ZiQtiLkO2D8GGF7YO5QAhQm7mrvEyP1Dt2L2aihU02ZbNfTjST2G+N/d2tM9Wql9UmedpBO8iuAxc03GyPhLGR8Dk85EtsL69G0VX+ciyKeI95ANm9ttCkTeZ7vmr6uGzKBs0jODGWv4pt4EIjBbzSWIdj0URXetKXvZBCAlO/xfKYBVeC/tdyS939vkYwaMX2pcu0uwEhNLQXxcfrJPEVGjAQnTPdNe2EiF5ZyaAMe3gyLxVQokBeo+B0bz9qHFXkl/Wgg08oUIKa65rVKUwusfLc1U2X2nJjWuu41qD4Jm+tsTnya13Ia0bsXiO6ZrAZqFWe9YMsh+3TWV3LucWBTOiZdB5LbDzc31sinivUGRsaxcR1eYucVmhFkCnXsCpLlE/Z1PwF33++ICu8V+Wa/z8R6IIDh33LBLb7+yUHSSYrFwzaSBO82IsaGgB1WRW4uZLP0C44eyLLLAkluls0R2CS/Y1MXVSTjJuPGEY91p72Ohp4Sm5vRyvOwICtsyAaP3xUpqj1lgJND/3I3cgW5r9tO6An6evDFKJoNvfdlyvz4sy3/NHEyepe7DYYshcNz/cPfH7ZsmFCL6Z3Jab2CYRowKXdfckTBat0msHzmocIkzkUrXK+JJr9RJaBfl+ipJHb5VbDK1j3Qd+3TeHTXG8XnAR0RxMhi1UjA6QbS3qyF5UA96lBXhWHgDeoQX/xQttC8dKt9+CVN9Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: bu+HVXHGRGSIld9KdJl+8X3jEoEfXNkUNDzXbR99rNBUuDC0rXh4Rx3DaYG3vMHdu5ImHBmu9W/rmB8u9hie89irTBV2vfXZM0Rw+4NLY9ggbIz0seAln7dcuBgNaI3cFa3IqcuJbtdD6DWrNKmbrUTZ3AL+ThX0kWDNMxySTwIfY27+3Aki4O0sbfk1rIBIi9w2i/19qnFzK3SQRoAjM/YKJEvl9pWfBoBWtLYULgROFlXiC+tb/abU2Eg4YrdyNGO11XwpTv0aMURsE2XaVKhTFw2Jz6w2rb25XnxTpRiXSp+0W10VEo5CTHQLZMqDFPNPwqLZxsaVtHAzUd7g8UTzs06DbXDIWWijU7xcO1jF3OoiHcuFg7XJgcLuQMU5IzIIEMdCt8mYddvZGa1GH3MVr+5NksfXaBR5GE9JhkUbRpclO3ZtuVCkK+aXTzn2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 01:01:37.9873 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c204dffe-b593-4ffb-9128-08de8489e88e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4416
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

From: Roman Li <Roman.Li@amd.com>

[why & how]
DCN has a global limit for minimum DS DCFCLK during any operation.

Adhere to that limit and add a debug flag.

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Signed-off-by: Ovidiu Bunea <ovidiu.bunea@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
Signed-off-by: Chuanyu Tseng <Chuanyu.Tseng@amd.com>
---
 drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c | 5 +++++
 drivers/gpu/drm/amd/display/dc/dc.h                          | 1 +
 .../gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c   | 1 +
 3 files changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c
index a0296d5f0102..bc11510b63a1 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn42/dcn42_clk_mgr.c
@@ -291,6 +291,11 @@ void dcn42_update_clocks(struct clk_mgr *clk_mgr_base,
 	if (should_set_clock(safe_to_lower,
 			new_clocks->dcfclk_deep_sleep_khz, clk_mgr_base->clks.dcfclk_deep_sleep_khz)) {
 		clk_mgr_base->clks.dcfclk_deep_sleep_khz = new_clocks->dcfclk_deep_sleep_khz;
+
+		/* Clamp the requested clock to PMFW based on DCN limit. */
+		if (dc->debug.min_deep_sleep_dcfclk_khz > 0 && clk_mgr_base->clks.dcfclk_deep_sleep_khz < dc->debug.min_deep_sleep_dcfclk_khz)
+			clk_mgr_base->clks.dcfclk_deep_sleep_khz = dc->debug.min_deep_sleep_dcfclk_khz;
+
 		dcn42_smu_set_min_deep_sleep_dcfclk(clk_mgr, clk_mgr_base->clks.dcfclk_deep_sleep_khz);
 	}
 
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 0b48feaba131..4d15d97ed7f1 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1215,6 +1215,7 @@ struct dc_debug_options {
 	bool enable_dmu_recovery;
 	unsigned int force_vmin_threshold;
 	bool enable_otg_frame_sync_pwa;
+	unsigned int min_deep_sleep_dcfclk_khz;
 };
 
 
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c
index 7b451c7db02c..8175109a66b0 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c
@@ -760,6 +760,7 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.disable_z10 = false,
 	.ignore_pg = true,
 	.disable_stutter_for_wm_program = true,
+	.min_deep_sleep_dcfclk_khz = 8000,
 };
 
 static const struct dc_check_config config_defaults = {
-- 
2.43.0

