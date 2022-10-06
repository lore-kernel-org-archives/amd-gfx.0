Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B6D7C433F5
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Oct 2022 21:28:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5067810E8BB;
	Thu,  6 Oct 2022 21:28:00 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0815110E8B1
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Oct 2022 21:27:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nmVLQRQNLEoMkFZV7nL1l7Sku5VeQwtmjUV/j1m3wvEwkE4dxaXY7iftJVu+ZonGdZRp678U9ePVqe5GFO00d9Lm5lPnEjQZzkybtBgrJXWo1ST2srE/rl0t+hwVzlVT6wBSaB6zYPBEQaHJJXVruiUMG3+WeINol8QbsQPYgjd5vivOpDG/t94h7n21j9SZlZhai9kJZU0d5a26Ke0KKs4olAphhYrNnQQuJhbbMy1gAzHSY9mq2v+bJ/sbYZobDxvsYNx8Pyf6/JEHLXgUCiqBlzF4POcI1d8mxV1wmYzQewIXcdJtlaCmv604hRtJLQm9CzFJag2lgGwZPUHsng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EyopJBi9BV7CpG90LpUQMAtH0N26Nelozx++WU/3hv4=;
 b=e5BUIg0YHGpIMJVggxb+5N8hxRU/tj++px1PRKQHODPo/HN4DDXgS4fi+uHjbyLXDvV4eUz6gxFzvzSA8KCLC/2lZFB+KkrM3wr777l7FM5xPJb3iDlNyCLZttSW+0gI9mn8KV/A3x/SJcAYtjurls23HxS4o0VJdaB6+17TaFQzOmD7COSlEbwiyJzgzKyqMmEHC/Z0MLU5UGMwMz7R2bF09kERFWfTgInibZTlL6VWNQrDp5Khm+Cmlg1Xd5fhYyhJvyOqb+54EgapYIZqPgkZneDl6uH4mq5uU1c3NSZd2i+T4eVIXu3JFlXxTNxKeabW7p0njJ8nrR1EiZ7WUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EyopJBi9BV7CpG90LpUQMAtH0N26Nelozx++WU/3hv4=;
 b=H1LQ3BvNhNbXn6AtosxMIs4gjaAeke2AxJbBCuXgpwzmo7KM7GuqQdloLwQ2PEeZ3T97Jfd/Me1eybixKRjLj9IZUkMVnjQVXdhEyd7ixacJiL9xuVnYmFUbnvgO/ij4YHZ5dw6Q7Ad2iAS5DYHJZr44hbf5/8tCk52ysnMqpYA=
Received: from BN8PR07CA0013.namprd07.prod.outlook.com (2603:10b6:408:ac::26)
 by MN0PR12MB5883.namprd12.prod.outlook.com (2603:10b6:208:37b::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.32; Thu, 6 Oct
 2022 21:27:47 +0000
Received: from BN8NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ac:cafe::31) by BN8PR07CA0013.outlook.office365.com
 (2603:10b6:408:ac::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.26 via Frontend
 Transport; Thu, 6 Oct 2022 21:27:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT040.mail.protection.outlook.com (10.13.177.166) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5709.10 via Frontend Transport; Thu, 6 Oct 2022 21:27:47 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 6 Oct
 2022 16:27:45 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 14/23] drm/amd/display: Display does not light up after S4
 resume
Date: Thu, 6 Oct 2022 17:26:41 -0400
Message-ID: <20221006212650.561923-15-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221006212650.561923-1-qingqing.zhuo@amd.com>
References: <20221006212650.561923-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT040:EE_|MN0PR12MB5883:EE_
X-MS-Office365-Filtering-Correlation-Id: 289bc0d6-8591-4d3c-e805-08daa7e19d59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YHnNVJaaBCPuJ8EDufWc4vCgFdR4+blcI2PiEgWntHk5ZsqFDdw/YmbAOUhvKb598J2L/T2OUtzft4LhW72Faun+lxpUnRkKLw05QV58uj+9XKSvur16rJv620jTU2mmcIoxL3Dk8vNtXO+U6Lt51oWqrZ/X6wkDvWZXYdOkZoXucJvgF6kHTMMl/vucFecceQ3pAw5WhxWVMultuFDsFn7OuKihxg3GN8yLBuP6qUGCxSLgGRw8yxSfrYe0V7ILcutybCta80/rgLezJ2Q//FEeMjntA4l5RXWAahiBCvTujomdz8fFmYIOI16kHajpc7ufn4iQzslyKSqLz3c8UbfDfs/6QtugQLncSi1Ig8LkCiz4hcGIWuhU4CNvNWDsR2WMmU0FVDLWhjQ4n4tLFX28eS/nWsAC5bPn7eY8VkRKpv+SJ6SBqGfCuyuTEv1BTiwD9kmovMUeyqYGdsPbt5mvPNQGt5RC4VtCnhl88x2mPyLeY/NQAliC5gISbTb6EG6rNVNy469fJBLt/NFA6RO1774dcYUghnhNgZ3bdz0V/dFqwFQGm+/GD/9mPLi4jC/daLc53p6DiMacT8fKLXF0Bras7koVAMh6rastu2t8sB6vtiKobq4qcuqagG2/WLB0dYCqUpy4oYjrAMCaUNYfwFy8Es0rR3Bbrp8W/BOYVspMOxwg7s6kPOKB1HC0eC54oBLSQfz3ODGc3OqB5X7wh2dGRpdRd3HhcNkFI62PvwdX2F126wJwRmXhsyS/FHHOct2duyT7vol9r7+M7OBrh/eWXP2YArXv8yX4wQaDY/+3xyIsR0zBmxG0QH/F
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(376002)(346002)(39860400002)(396003)(451199015)(40470700004)(36840700001)(46966006)(426003)(83380400001)(47076005)(82310400005)(8676002)(4326008)(336012)(16526019)(26005)(8936002)(36756003)(2906002)(54906003)(70206006)(186003)(70586007)(6916009)(41300700001)(36860700001)(40480700001)(2616005)(6666004)(1076003)(44832011)(356005)(86362001)(316002)(81166007)(40460700003)(478600001)(5660300002)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2022 21:27:47.4960 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 289bc0d6-8591-4d3c-e805-08daa7e19d59
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5883
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
Cc: stylon.wang@amd.com, Jun Lei <Jun.Lei@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Meenakshikumar
 Somasundaram <meenakshikumar.somasundaram@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Mustapha Ghaddar <Mustapha.Ghaddar@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>

[Why]
Dpia hpd interrupt processing is disabled when entering S4/S0i3 and would
be reenabled after detection completes during resuming. Because, keeping
hpd interrupts enabled during detection leads to multiple detections for
the same hpd transition. There is a S4 case where dpia hpd interrupt is
missed when driver is in transitioning from hpd interrupt processing
disable to enable and the display does not light up.

[How]
- Added dmub inbox command DMUB_CMD__DPIA_HPD_INT_ENABLE to explicitly
control dmub to issue dpia hpd interrupt or not. If dpia hpd interrupt is
disabled, dmub will keep the hpd pending and post it once driver reenables
dpia hpd interrupt or when querying with DMUB_CMD__QUERY_HPD_STATE.
- Added dmub boot option dpia_hpd_int_enable_supported to notify dmub
about whether DMUB_CMD__DPIA_HPD_INT_ENABLE command would be used.

Reviewed-by: Mustapha Ghaddar <Mustapha.Ghaddar@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 31 +++++++++++++++++++
 drivers/gpu/drm/amd/display/dc/dc.h           |  3 ++
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h   |  1 +
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 21 ++++++++++++-
 .../gpu/drm/amd/display/dmub/src/dmub_dcn31.c |  1 +
 5 files changed, 56 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index b5058a2ce7e8..660316a536f7 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -4656,6 +4656,37 @@ enum dc_status dc_process_dmub_set_mst_slots(const struct dc *dc,
 	return DC_OK;
 }
 
+/**
+ *****************************************************************************
+ *  Function: dc_process_dmub_dpia_hpd_int_enable
+ *
+ *  @brief
+ *		Submits dpia hpd int enable command to dmub via inbox message
+ *
+ *  @param
+ *		[in] dc: dc structure
+ *		[in] hpd_int_enable: 1 for hpd int enable, 0 to disable
+ *
+ *	@return
+ *		None
+ *****************************************************************************
+ */
+void dc_process_dmub_dpia_hpd_int_enable(const struct dc *dc,
+				uint32_t hpd_int_enable)
+{
+	union dmub_rb_cmd cmd = {0};
+	struct dc_dmub_srv *dmub_srv = dc->ctx->dmub_srv;
+
+	cmd.dpia_hpd_int_enable.header.type = DMUB_CMD__DPIA_HPD_INT_ENABLE;
+	cmd.dpia_hpd_int_enable.enable = hpd_int_enable;
+
+	dc_dmub_srv_cmd_queue(dmub_srv, &cmd);
+	dc_dmub_srv_cmd_execute(dmub_srv);
+	dc_dmub_srv_wait_idle(dmub_srv);
+
+	DC_LOG_DEBUG("%s: hpd_int_enable(%d)\n", __func__, hpd_int_enable);
+}
+
 /**
  * dc_disable_accelerated_mode - disable accelerated mode
  * @dc: dc structure
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index b0afcff94591..5d0103e20412 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1612,6 +1612,9 @@ enum dc_status dc_process_dmub_set_mst_slots(const struct dc *dc,
 				uint8_t mst_alloc_slots,
 				uint8_t *mst_slots_in_use);
 
+void dc_process_dmub_dpia_hpd_int_enable(const struct dc *dc,
+				uint32_t hpd_int_enable);
+
 /*******************************************************************************
  * DSC Interfaces
  ******************************************************************************/
diff --git a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
index f34c45b19fcb..eb5b7eb292ef 100644
--- a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
@@ -248,6 +248,7 @@ struct dmub_srv_hw_params {
 	bool disable_dpia;
 	bool usb4_cm_version;
 	bool fw_in_system_memory;
+	bool dpia_hpd_int_enable_supported;
 };
 
 /**
diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 834707dfc189..1d36f0fceb3e 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -400,8 +400,9 @@ union dmub_fw_boot_options {
 		uint32_t diag_env: 1; /* 1 if diagnostic environment */
 		uint32_t gpint_scratch8: 1; /* 1 if GPINT is in scratch8*/
 		uint32_t usb4_cm_version: 1; /**< 1 CM support */
+		uint32_t dpia_hpd_int_enable_supported: 1; /* 1 if dpia hpd int enable supported */
 
-		uint32_t reserved : 17; /**< reserved */
+		uint32_t reserved : 16; /**< reserved */
 	} bits; /**< boot bits */
 	uint32_t all; /**< 32-bit access to bits */
 };
@@ -728,6 +729,12 @@ enum dmub_cmd_type {
 	/**
 	 * Command type used for all VBIOS interface commands.
 	 */
+
+	/**
+	 * Command type used to set DPIA HPD interrupt state
+	 */
+	DMUB_CMD__DPIA_HPD_INT_ENABLE = 86,
+
 	DMUB_CMD__VBIOS = 128,
 };
 
@@ -1255,6 +1262,14 @@ struct dmub_rb_cmd_set_mst_alloc_slots {
 	struct dmub_cmd_mst_alloc_slots_control_data mst_slots_control; /* mst slots control */
 };
 
+/**
+ * DMUB command structure for DPIA HPD int enable control.
+ */
+struct dmub_rb_cmd_dpia_hpd_int_enable {
+	struct dmub_cmd_header header; /* header */
+	uint32_t enable; /* dpia hpd interrupt enable */
+};
+
 /**
  * struct dmub_rb_cmd_dpphy_init - DPPHY init.
  */
@@ -3336,6 +3351,10 @@ union dmub_rb_cmd {
 	 * Definition of a DMUB_CMD__QUERY_HPD_STATE command.
 	 */
 	struct dmub_rb_cmd_query_hpd_state query_hpd;
+	/**
+	 * Definition of a DMUB_CMD__DPIA_HPD_INT_ENABLE command.
+	 */
+	struct dmub_rb_cmd_dpia_hpd_int_enable dpia_hpd_int_enable;
 };
 
 /**
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c
index c7bd7e216710..c90b9ee42e12 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c
@@ -350,6 +350,7 @@ void dmub_dcn31_enable_dmub_boot_options(struct dmub_srv *dmub, const struct dmu
 	boot_options.bits.dpia_supported = params->dpia_supported;
 	boot_options.bits.enable_dpia = params->disable_dpia ? 0 : 1;
 	boot_options.bits.usb4_cm_version = params->usb4_cm_version;
+	boot_options.bits.dpia_hpd_int_enable_supported = params->dpia_hpd_int_enable_supported;
 	boot_options.bits.power_optimization = params->power_optimization;
 
 	boot_options.bits.sel_mux_phy_c_d_phy_f_g = (dmub->asic == DMUB_ASIC_DCN31B) ? 1 : 0;
-- 
2.25.1

