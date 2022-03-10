Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86F9AC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Mar 2022 22:21:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 150F910E26D;
	Thu, 10 Mar 2022 22:21:21 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2083.outbound.protection.outlook.com [40.107.244.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2778F10E26D
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Mar 2022 22:21:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SgV0nbuIgNVEKHGfYXOsbMddf+jQgUOKTPdPDmQ5/pwRzmbY6j3g8wje8eTiobCIMH/82wRpJ1LZR0zzxHRd2z7S9g8TNhAM2c9EjeP9JgDU3dQILZln0yIZAOY1eDDVGgePS3wkhYv03HQQUMhC8mjl94km1piPNqseQx+T63EtPxWcAqsaOEGGrqVLuNY3P9yD4rGi4sDEFfGB6hAr2LqQodf8tuYNdhY+R2gdHzVjOV+TBrU9VIok16AUKImQEUIzzQ1NhHAiyw63tAAeeMntLx82euNFZ7m1EeKufzJ2WmBRJh5O/UTNaVcsA6hbN4CGJ5zYXMRjZAE/oNVKCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PifGRzJEEUL7rCT9/DwP3Zy6Kv9yLXlAhgihss1jx7o=;
 b=YAVcrgejH1BAY3fKgv8IlPocclDi20UKu8zmoFtezD/YsW58j4Bzehiy8muPjO8a5nluxwfgvjtsatWwc7VRTEFKFjBKP/aEcFYBpEA3HdRZYrL4IXKoIpt8ygW7oTTerVQHc7NxnYuCmF9RXUUcPQQMh/K52k4Sro/D0IirqI33trBHeREfz2LucNJyAHGd1tBehSGzcuQ8zZ0i8O69hhE8Uo+5Q1nolEWWYUPesvESJzovuU0lyuIXKoipXXpy4uUNt+JywG4MhMeY4h8Cdq/e9SFVxaAGszv9WlcOy5SBO1+ME7knUdZs5UcCd0DK0WQ4gKzcqHOyJCXf2bYtcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PifGRzJEEUL7rCT9/DwP3Zy6Kv9yLXlAhgihss1jx7o=;
 b=G7S3RiuUpE36ilwy6DPnCyADGlmFp8x2aL8rIqTpIH9pO7QVZBHX9JdsMkqfy1FBj7DnKIxCUgNR4zlD/5rTUgg4GBtRZjd3zz9Jkw9PsrUHmU64cxrg3tLKy8zIa7QFXZLWM/PjQon1USNQ+zVFZFVBXBnsIdf/IXqRLj6JEf0=
Received: from BN9PR03CA0878.namprd03.prod.outlook.com (2603:10b6:408:13c::13)
 by CH2PR12MB3687.namprd12.prod.outlook.com (2603:10b6:610:2b::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.18; Thu, 10 Mar
 2022 22:21:17 +0000
Received: from BN8NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13c:cafe::2d) by BN9PR03CA0878.outlook.office365.com
 (2603:10b6:408:13c::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.16 via Frontend
 Transport; Thu, 10 Mar 2022 22:21:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT037.mail.protection.outlook.com (10.13.177.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5061.22 via Frontend Transport; Thu, 10 Mar 2022 22:21:16 +0000
Received: from Linux-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 10 Mar
 2022 16:21:10 -0600
From: Agustin Gutierrez <agustin.gutierrez@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 01/12] drm/amd/display: Add I2C escape to support query device
 exist.
Date: Thu, 10 Mar 2022 17:20:34 -0500
Message-ID: <20220310222045.664867-2-agustin.gutierrez@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220310222045.664867-1-agustin.gutierrez@amd.com>
References: <20220310222045.664867-1-agustin.gutierrez@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 59c5840e-7c60-4584-2892-08da02e44b3a
X-MS-TrafficTypeDiagnostic: CH2PR12MB3687:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB3687347099AC554C33FC6319F50B9@CH2PR12MB3687.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5ctO4itcUlW1uw+drYgw0d/J2JnM8MEP78rzU4nIaw5H2sKkmL4mrGj8uZkfDJiLohOapLkQz3ICn9TbfLnZ2BBhWZf6JsHBPw6EnLwN9pO0UqO7OQjGT1KzW1KHlRxQm+YWr2NgadPkryZHO3E5sM2NnZUdqZP5yegRKjNTINJmr+L133oKsTdFICPVZjHb1zob40F7qkuWONrmXM3ZTgDDvka59e3Z6vnNWop6vQx5ZHWXTeMkvL6xWBU8V1ZTMEWTXf94dvHz//fXVZH4F5Cw00MptKcIrtlbGbOPZ/hRd6q5C1+CDjfV6P3RV6CKCgNEw/cf7ZLZLPL8/T8sndFVoo6ZcEayVr10J9/dcQJyCNkYD/ulDxRg3iLva5PvNaULa+heeHH0Py4MvTwKLpiO5aN12Brpmh3shkshaIhzMTXJ5xVDdjLM7uePOIpUO1MtFnUhfabG95rSe+VEPx3FtHouw3z/6q9Q3JKR0tKtEzJSq7h56w82G2JtWUfvofI/Gd1HEW7n0FAMHKWxw2ztL2BlFvaPgTsh8ZYkcU3BvBBezvbAvgxvM/t4MNVfbjx4EPDePDeRSXuWM7gJRXr6C8jb2Zt422xn5JDLmdk0ejLlOKUeofiuYZpyJHmWcwTcCCws34vjP/TjsCLjHQ2GbFM/twBYS2FNQ+RA3Rkanv+G4qh5iamyo2k7krpq8+AhC1g+1MdWGYSOLG1bLg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(2906002)(36756003)(336012)(8936002)(426003)(44832011)(4326008)(6666004)(1076003)(6916009)(5660300002)(54906003)(26005)(70586007)(70206006)(508600001)(186003)(82310400004)(8676002)(7696005)(356005)(47076005)(16526019)(86362001)(81166007)(40460700003)(316002)(36860700001)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2022 22:21:16.2217 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59c5840e-7c60-4584-2892-08da02e44b3a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3687
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
Cc: stylon.wang@amd.com, Aric Cyr <Aric.Cyr@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, "JinZe.Xu" <JinZe.Xu@amd.com>,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: "JinZe.Xu" <JinZe.Xu@amd.com>

[How]
1. Search OEM I2C info from BIOS and compare with input parameter.
2. If BIOS doesn't record it, just try to read one byte.

Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Agustin Gutierrez <agustin.gutierrez@amd.com>
Signed-off-by: JinZe.Xu <JinZe.Xu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c     | 13 ++++++++++
 drivers/gpu/drm/amd/display/dc/dc_link.h     |  5 ++++
 drivers/gpu/drm/amd/display/dc/dce/dce_i2c.c | 26 ++++++++++++++++++++
 drivers/gpu/drm/amd/display/dc/dce/dce_i2c.h |  6 +++++
 4 files changed, 50 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 01b5996fa3aa..f6e19efea756 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -3363,6 +3363,19 @@ bool dc_is_dmcu_initialized(struct dc *dc)
 	return false;
 }
 
+bool dc_is_oem_i2c_device_present(
+	struct dc *dc,
+	size_t slave_address)
+{
+	if (dc->res_pool->oem_device)
+		return dce_i2c_oem_device_present(
+			dc->res_pool,
+			dc->res_pool->oem_device,
+			slave_address);
+
+	return false;
+}
+
 bool dc_submit_i2c(
 		struct dc *dc,
 		uint32_t link_index,
diff --git a/drivers/gpu/drm/amd/display/dc/dc_link.h b/drivers/gpu/drm/amd/display/dc/dc_link.h
index 78e66e4bab5a..aa818bf840eb 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_link.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_link.h
@@ -466,6 +466,11 @@ const struct dc_link_settings *dc_link_get_link_cap(
 void dc_link_overwrite_extended_receiver_cap(
 		struct dc_link *link);
 
+bool dc_is_oem_i2c_device_present(
+	struct dc *dc,
+	size_t slave_address
+);
+
 bool dc_submit_i2c(
 		struct dc *dc,
 		uint32_t link_index,
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_i2c.c b/drivers/gpu/drm/amd/display/dc/dce/dce_i2c.c
index dd41736bb5c4..f5cd2392fc5f 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_i2c.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_i2c.c
@@ -25,6 +25,32 @@
 #include "dce_i2c.h"
 #include "reg_helper.h"
 
+bool dce_i2c_oem_device_present(
+	struct resource_pool *pool,
+	struct ddc_service *ddc,
+	size_t slave_address
+)
+{
+	struct dc *dc = ddc->ctx->dc;
+	struct dc_bios *dcb = dc->ctx->dc_bios;
+	struct graphics_object_id id = {0};
+	struct graphics_object_i2c_info i2c_info;
+
+	if (!dc->ctx->dc_bios->fw_info.oem_i2c_present)
+		return false;
+
+	id.id = dc->ctx->dc_bios->fw_info.oem_i2c_obj_id;
+	id.enum_id = 0;
+	id.type = OBJECT_TYPE_GENERIC;
+	if (dcb->funcs->get_i2c_info(dcb, id, &i2c_info) != BP_RESULT_OK)
+		return false;
+
+	if (i2c_info.i2c_slave_address != slave_address)
+		return false;
+
+	return true;
+}
+
 bool dce_i2c_submit_command(
 	struct resource_pool *pool,
 	struct ddc *ddc,
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_i2c.h b/drivers/gpu/drm/amd/display/dc/dce/dce_i2c.h
index a171c5cd8439..535fd58de450 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_i2c.h
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_i2c.h
@@ -30,6 +30,12 @@
 #include "dce_i2c_hw.h"
 #include "dce_i2c_sw.h"
 
+bool dce_i2c_oem_device_present(
+	struct resource_pool *pool,
+	struct ddc_service *ddc,
+	size_t slave_address
+);
+
 bool dce_i2c_submit_command(
 	struct resource_pool *pool,
 	struct ddc *ddc,
-- 
2.35.1

