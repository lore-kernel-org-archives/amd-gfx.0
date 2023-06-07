Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64338C7EE23
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Jun 2023 12:17:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F198910E4DA;
	Wed,  7 Jun 2023 12:17:17 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2056.outbound.protection.outlook.com [40.107.92.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A0AB10E4DA
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Jun 2023 12:17:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TzicVccujHO1l814k59QzD+UaXevhGlgW+KO1Jm3kO3ujk2becHsNqFyrwuuXDPFZc6lJ5Qsy+UIO6JTFE46iYrFDZVVPfJ9yU4c6OPyvt4LKjBGMaNz55Hr+YhGVd71LeX0vBJoMDmFrmZDHXp3L7qbSl8HKNZWSek9AoVkGcPhp+Ma5Gxrwm+AkJE1+maw3Yh0Mjg0RO0UjPq6XZ8Aq+GFgOjoH39YMC18GuZCQaXJuXUEUA5dVhmbip56pss4XR/has+Dz1GOyuqQb1vBXGOadyN2pAr0i3dUBaDQJtasKlfwtyz2h+tN14J8aUADrBYhhAM8kLfQP7xcd9CdUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cEHn/xvUyp8zGDUwIHgP8Dlagl1aFjBzdVhUzkjO2CQ=;
 b=e2+LfN2f8tMZGUvF24McHC3PgScWFOVduUaDgayK21fyBmvEHn5AIH6AZxXa1zOzaJdFj18WQD+CnZdLsiNtU+2wKo5DkGbelgw1WCYDxizXkekKegg/Krds0h3w3WxPmbUS98dCDLTdKNUvHsaJesQMrCQTOftAfVtpBsKlcAgqKfDfdOsOnwUuFs4zJNolendXj4DxyzMgAgazEwDIc+NCJybeIF1ybXbnfypLvpr10PYwSD5vDLt+EqHO7GmdZ/r7lx/3N7WHtJZiB5gSIPfcamYgCnVubRhjTlDA1umBGWDYgQSQEpFcy9p14B62vTB2CXTgSbsHsN4Rxum/3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cEHn/xvUyp8zGDUwIHgP8Dlagl1aFjBzdVhUzkjO2CQ=;
 b=o7MCWYAX1MU2xprtzYCu/mj8LRAUaSD/iYKwFJVmmix9/+1c/dKTYGmkIyUtAaMNJQ5BKwRyD23xdhS05MH+FzpX0lUtDTss2RUkABH567IOQeJZs4whnYU0SQahD3ajdCZX0i5F9XpH/Pwon/9o7JYWIHUdb9WX5bn7vCrxCIA=
Received: from DS7PR03CA0072.namprd03.prod.outlook.com (2603:10b6:5:3bb::17)
 by CH3PR12MB8209.namprd12.prod.outlook.com (2603:10b6:610:123::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Wed, 7 Jun
 2023 12:17:13 +0000
Received: from CY4PEPF0000EE32.namprd05.prod.outlook.com
 (2603:10b6:5:3bb:cafe::27) by DS7PR03CA0072.outlook.office365.com
 (2603:10b6:5:3bb::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33 via Frontend
 Transport; Wed, 7 Jun 2023 12:17:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE32.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6477.13 via Frontend Transport; Wed, 7 Jun 2023 12:17:11 +0000
Received: from stylon-rog.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 7 Jun
 2023 07:17:07 -0500
From: Stylon Wang <stylon.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 15/20] drm/amd/display: Limit Minimum FreeSync Refresh Rate
Date: Wed, 7 Jun 2023 20:15:43 +0800
Message-ID: <20230607121548.1479290-16-stylon.wang@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230607121548.1479290-1-stylon.wang@amd.com>
References: <20230607121548.1479290-1-stylon.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE32:EE_|CH3PR12MB8209:EE_
X-MS-Office365-Filtering-Correlation-Id: 003b3b5e-e655-4d95-60ee-08db67511f5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: knaKSUuvi0vc/W228uTu2i20Qzk+0oa6LkvyQHSpg0MddGon+9UTvH1H69EM1z8UGShFhWBeBVZDWwW4XT9Fz1FnkfIuNEKR+rui0UNB3Od0wKdcRKzsM4Yu+sLsfPQ5Uc8XQ889UMQ0PYjKyWic5SX0eDW9scVft5M/Ek3kVhkXjSYvIKFsxY+arVTwXv6mKwtXW6p0Phm+wABKoAQXjr2OhdGr3XdBpuAMT3ISJRakSw5BaP5uvT1+qoYyXctN/Y/DXdImbiilmQjXpRPXDKSF6+qII7tlXkUDYFRo39W+bvkbLkd+/ujSpbdEedFAzPpwPFbGhFAFTXDyrqkfVqiRvl+brcEHB7uskQzHNeneFN26AHSrMKLpG5l/ctT76QKT8xkgLddu3W+AW79np9A/SC9Klx5GbbtDlvQGwQUDbGzBMOAXmGNXF6zC25mGO6svf+TtqCDzEd/Nau2qqyNUyGpvGQPJeaqPXxlE1+grMDshkHeismdu9zXI5nVO8hkkiLRDYB8fBXrhnU9iG4JKhqSaFeVcA+fFwP2tKzB7Uj2wbgiDJQxuEHvJGDcwc3E+U/pqi65g5+XJmbbtHFZOLbF35AVrBBtF0i0GSyKOjyoIIw2FvP8hME5An5tRNZBA91OOja5oWGDgZTsR7GLCrwgLPDw2Od0mB2Y9TGhTfM3TKre4oDoMKJUVi1NMTVYb+onzlXv0tF0E49tBDMN++VK2MEVzCkthakPvlPuOLDoA+NhTsiWnmF4nQwrZH+xWjS9XCU7O0VcYtmPahg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(136003)(39860400002)(376002)(346002)(451199021)(40470700004)(36840700001)(46966006)(54906003)(40460700003)(478600001)(40480700001)(6916009)(44832011)(8936002)(8676002)(2906002)(36756003)(5660300002)(86362001)(82310400005)(4326008)(81166007)(70206006)(70586007)(356005)(316002)(82740400003)(2616005)(1076003)(41300700001)(26005)(47076005)(16526019)(36860700001)(83380400001)(186003)(7696005)(6666004)(336012)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2023 12:17:11.8279 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 003b3b5e-e655-4d95-60ee-08db67511f5c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE32.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8209
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
Cc: stylon.wang@amd.com, Austin Zheng <austin.zheng@amd.com>,
 Anthony Koo <Anthony.Koo@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Austin Zheng <austin.zheng@amd.com>

Why:
Some EDIDs report a minimum refresh rate lower than what HW can support

How:
Add a check to calculate minimum supported refresh rate with current timing
and use that as the minimum if a lower one is passed in

Acked-by: Stylon Wang <stylon.wang@amd.com>
Signed-off-by: Austin Zheng <austin.zheng@amd.com>
Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h                   |  1 +
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c |  1 +
 .../gpu/drm/amd/display/dc/dcn302/dcn302_resource.c   |  1 +
 .../gpu/drm/amd/display/dc/dcn303/dcn303_resource.c   |  1 +
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c |  1 +
 .../gpu/drm/amd/display/dc/dcn321/dcn321_resource.c   |  1 +
 .../gpu/drm/amd/display/modules/freesync/freesync.c   | 11 +++++++++--
 7 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 5c906b007e4d..a239dcd8e9fb 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -266,6 +266,7 @@ struct dc_caps {
 	uint16_t subvp_pstate_allow_width_us;
 	uint16_t subvp_vertical_int_margin_us;
 	bool seamless_odm;
+	uint32_t max_v_total;
 	uint8_t subvp_drr_vblank_start_margin_us;
 };
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
index f4ee4b3df596..1a0284a068b2 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
@@ -2328,6 +2328,7 @@ static bool dcn30_resource_construct(
 	dc->caps.color.mpc.ocsc = 1;
 
 	dc->caps.dp_hdmi21_pcon_support = true;
+	dc->caps.max_v_total = (1 << 15) - 1;
 
 	/* read VBIOS LTTPR caps */
 	{
diff --git a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c b/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
index 93f42132c900..7dc065ea247a 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
@@ -1227,6 +1227,7 @@ static bool dcn302_resource_construct(
 	dc->caps.force_dp_tps4_for_cp2520 = true;
 	dc->caps.extended_aux_timeout_support = true;
 	dc->caps.dmcub_support = true;
+	dc->caps.max_v_total = (1 << 15) - 1;
 
 	/* Color pipeline capabilities */
 	dc->caps.color.dpp.dcn_arch = 1;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c b/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c
index f35514188a5c..6d9761395288 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c
@@ -1152,6 +1152,7 @@ static bool dcn303_resource_construct(
 	dc->caps.force_dp_tps4_for_cp2520 = true;
 	dc->caps.extended_aux_timeout_support = true;
 	dc->caps.dmcub_support = true;
+	dc->caps.max_v_total = (1 << 15) - 1;
 
 	/* Color pipeline capabilities */
 	dc->caps.color.dpp.dcn_arch = 1;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
index 8c9e15952a49..19f134caa8ad 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
@@ -2175,6 +2175,7 @@ static bool dcn32_resource_construct(
 	dc->caps.extended_aux_timeout_support = true;
 	dc->caps.dmcub_support = true;
 	dc->caps.seamless_odm = true;
+	dc->caps.max_v_total = (1 << 15) - 1;
 
 	/* Color pipeline capabilities */
 	dc->caps.color.dpp.dcn_arch = 1;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
index ee07ee340171..ea204742ad35 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
@@ -1718,6 +1718,7 @@ static bool dcn321_resource_construct(
 	dc->caps.edp_dsc_support = true;
 	dc->caps.extended_aux_timeout_support = true;
 	dc->caps.dmcub_support = true;
+	dc->caps.max_v_total = (1 << 15) - 1;
 
 	/* Color pipeline capabilities */
 	dc->caps.color.dpp.dcn_arch = 1;
diff --git a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
index 5798c0eafa1f..dbd60811f95d 100644
--- a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
+++ b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
@@ -1,5 +1,5 @@
 /*
- * Copyright 2016 Advanced Micro Devices, Inc.
+ * Copyright 2016-2023 Advanced Micro Devices, Inc.
  *
  * Permission is hereby granted, free of charge, to any person obtaining a
  * copy of this software and associated documentation files (the "Software"),
@@ -989,6 +989,7 @@ void mod_freesync_build_vrr_params(struct mod_freesync *mod_freesync,
 	unsigned int refresh_range = 0;
 	unsigned long long min_refresh_in_uhz = 0;
 	unsigned long long max_refresh_in_uhz = 0;
+	unsigned long long min_hardware_refresh_in_uhz = 0;
 
 	if (mod_freesync == NULL)
 		return;
@@ -999,7 +1000,13 @@ void mod_freesync_build_vrr_params(struct mod_freesync *mod_freesync,
 	nominal_field_rate_in_uhz =
 			mod_freesync_calc_nominal_field_rate(stream);
 
-	min_refresh_in_uhz = in_config->min_refresh_in_uhz;
+	if (stream->ctx->dc->caps.max_v_total != 0 && stream->timing.h_total != 0) {
+		min_hardware_refresh_in_uhz = div64_u64((stream->timing.pix_clk_100hz * 100000000ULL),
+			(stream->timing.h_total * stream->ctx->dc->caps.max_v_total));
+	}
+	/* Limit minimum refresh rate to what can be supported by hardware */
+	min_refresh_in_uhz = min_hardware_refresh_in_uhz > in_config->min_refresh_in_uhz ?
+		min_hardware_refresh_in_uhz : in_config->min_refresh_in_uhz;
 	max_refresh_in_uhz = in_config->max_refresh_in_uhz;
 
 	/* Full range may be larger than current video timing, so cap at nominal */
-- 
2.40.1

