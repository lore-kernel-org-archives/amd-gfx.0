Return-Path: <SRS0=e3IM=OZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43105C433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Oct 2021 07:59:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06F5F61352
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Oct 2021 07:59:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 06F5F61352
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C3426F59E;
	Tue,  5 Oct 2021 07:59:13 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2067.outbound.protection.outlook.com [40.107.93.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D0DD6F59E
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Oct 2021 07:59:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fbQHSy2BI4k3O3xQXV5nJ3PqTWvSDtzYXzxrhR0Fo/XPlSmMnVWrKI7xA6yeFDRgQwgLTjAD3TwiLxtz9aFSHr2HSLtThOhmwuVlbx3W6L/0z8VfmbD1NCHmfa0rHW1iqFZbLloHtZ9ADTice8qv+R2iLrPYyUhUHDfgYMxmqb7IFLSsXTw+yfj3NhfWr99PyGfJ0rgpgY/j3IrVn7VkkiW0lbRgRINLgbEq6n+PqxzuCyQME4axoT8qbzgLbgslPIVIea36Y/dvdmHwC+Cad6CZwUKJPR7/9VINM+i2Hrgtox8xJlYBuCnsd+YOe2QR/DmftOM9xLMPz4KVMH1F3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tKt6XFlJh7FwlR/lfbeJaH/umPDnufIcPSBVFNxvOiE=;
 b=P2rAH1bpZHjcWuHsjA0KP7CYN1w6QvONzfk3CKTxIZls5HDdlxzhgUXH2Dj74vd3YtKqCxSbZjprGnvs1i5oRR0+/Obn0YWBkmJgKU4YE/5UNhuwdjU6lYmLZsDurLzii1PT6dc5rMCe5SxCDABqLZ6kGMJW0u/Yfmxd62jXTF0wYiMoCZT1OaahWjLQKblrJlo4cwhSfcnNGlp47MMINe2WXDJ4e8YHN719DLPuKN3RoLb397XSpgonM2w4LpFm4a9TW7fDZVd0GLEIw969ZgZBD/D5F0vzxxjY+tqVNW2zxwZbyasC+4ec5xFUx4WXfE6k2tsR37PL5oTbwZXOEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tKt6XFlJh7FwlR/lfbeJaH/umPDnufIcPSBVFNxvOiE=;
 b=lcyCMFGX/Ddj2ARqpjq/ygywDJUiQ3q9QVTC3Ry9yfX614B13G1Zjo1iGgvxRHnYGFbj5xaAU34akDfmNqvY699KHKF2ZLbev5Qh2b1ZBVrlCTI7mLsVOC7ROt6XkTPeVmT7p629g/1Yfx4yfQeDk83i1K/FV9Am50ObdhjhOPk=
Received: from MWHPR03CA0001.namprd03.prod.outlook.com (2603:10b6:300:117::11)
 by BYAPR12MB2949.namprd12.prod.outlook.com (2603:10b6:a03:12f::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.22; Tue, 5 Oct
 2021 07:59:06 +0000
Received: from CO1NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:117:cafe::f6) by MWHPR03CA0001.outlook.office365.com
 (2603:10b6:300:117::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14 via Frontend
 Transport; Tue, 5 Oct 2021 07:59:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT041.mail.protection.outlook.com (10.13.174.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4566.14 via Frontend Transport; Tue, 5 Oct 2021 07:59:06 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 5 Oct 2021
 02:59:05 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 5 Oct 2021
 00:59:04 -0700
Received: from wayne-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2308.8
 via Frontend Transport; Tue, 5 Oct 2021 02:58:52 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <Harry.Wentland@amd.com>,
 <nicholas.kazlauskas@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <wayne.lin@amd.com>, <stylon.wang@amd.com>, <jude.shih@amd.com>,
 <jimmy.kizito@amd.com>, <meenakshikumar.somasundaram@amd.com>, Jimmy Kizito
 <Jimmy.Kizito@amd.com>, Wayne Lin <Wayne.Lin@amd.com>
Subject: [PATCH v2 16/23] drm/amd/display: Add dpia debug options
Date: Tue, 5 Oct 2021 15:51:58 +0800
Message-ID: <20211005075205.3467938-17-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211005075205.3467938-1-Wayne.Lin@amd.com>
References: <20211005075205.3467938-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3384ec18-54c4-41c7-275b-08d987d60143
X-MS-TrafficTypeDiagnostic: BYAPR12MB2949:
X-Microsoft-Antispam-PRVS: <BYAPR12MB294962FA604D7B2A7D07B5FCFCAF9@BYAPR12MB2949.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fSrnS9AruDunr8CV29zJB6zFA5a8b0tP5PwltGCPlKTWbMdIoaEdZDPMfI5KCQQBY+cLps12s5vNNRd6y1hL+FK6DtpZItxcMvcgYrOuscPbuuzbwaw8zoIxR9bHBj1m6kGCLNMrFUXx2qzTwK2E+akmev8lh2cQ5UKU7H4ajfFapGXqgnasi656cvdXLfNZ7wWOw61VOQ/tf4hveEQC9gV0W7wFiAJdlHL0ZPsoBCRp940e0Stg15+uk7/iepJ0zOpplffr/CJDULRxZyxLf76FjqkIwITkkP7IpRmwMim6ZbUUgM1WufE+zcAGBrTaN9m8dbwzsvUTDMSwe4OnpHSi1PMMKq74xwA58xCdNPfLrOhfKIk7BrBevB0NkzYRI+twBi4vNjD0qgnk9+4P0lXwR1NJC46rohE642upjKHc8yoRW3g95GjqlxkjvZpKZppD1wAw+5C4nsTHVrXP8Mlv79AmSCK0R2CvW7YIqXc7ZRILhlL2YJOj+6mYtVp2x3ZEy4C+G+nwDfZ8ZvoV/aOTw8gPCbXojqRACMs31JSF02JoBCXSvJkrShMc1L3hAmy2r7udHdpKhhbHQnLx4Mfy6M6nDUaEBehNEfhWsJMK050B9BpC3PAw/ZUg+GsxiB7+C0czHpOHCiOe9t/t1WdOjYWS0lPEYKYCV6EuJETsX0ZqR659ZX2oMfRb+7vLS006bxf53uMuU+uHvXT4oUGJ2UNL3C+fUTyrRzrseXI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(82310400003)(83380400001)(316002)(7696005)(86362001)(1076003)(70586007)(70206006)(47076005)(8676002)(54906003)(81166007)(356005)(8936002)(36860700001)(4326008)(508600001)(2906002)(186003)(26005)(6916009)(36756003)(336012)(2616005)(426003)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2021 07:59:06.2145 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3384ec18-54c4-41c7-275b-08d987d60143
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2949
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

From: Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>

[Why & How]
To add support for dpia debug options.

Reviewed-by: Jimmy Kizito <Jimmy.Kizito@amd.com>
Acked-by: Wayne Lin <Wayne.Lin@amd.com>
Acked-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h                   | 9 +++++++++
 drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c | 3 ++-
 drivers/gpu/drm/amd/display/dmub/dmub_srv.h           | 1 +
 drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h       | 3 +--
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c     | 1 +
 5 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index c6b5d4535cb4..e3f884942e04 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -496,6 +496,14 @@ union root_clock_optimization_options {
 	uint32_t u32All;
 };
 
+union dpia_debug_options {
+	struct {
+		uint32_t disable_dpia:1;
+		uint32_t reserved:31;
+	} bits;
+	uint32_t raw;
+};
+
 struct dc_debug_data {
 	uint32_t ltFailCount;
 	uint32_t i2cErrorCount;
@@ -668,6 +676,7 @@ struct dc_debug_options {
 #if defined(CONFIG_DRM_AMD_DC_DCN)
 	bool disable_z10;
 	bool enable_sw_cntl_psr;
+	union dpia_debug_options dpia_debug;
 #endif
 };
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
index 2e021f9345c0..7cb7604a35eb 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
@@ -2428,7 +2428,8 @@ static bool dcn31_resource_construct(
 	}
 
 	if (dc->ctx->asic_id.chip_family == FAMILY_YELLOW_CARP &&
-	    dc->ctx->asic_id.hw_internal_rev == YELLOW_CARP_B0) {
+	    dc->ctx->asic_id.hw_internal_rev == YELLOW_CARP_B0 &&
+	    !dc->debug.dpia_debug.bits.disable_dpia) {
 		/* YELLOW CARP B0 has 4 DPIA's */
 		pool->base.usb4_dpia_count = 4;
 	}
diff --git a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
index 7a86c97af910..365fbc4758e1 100644
--- a/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dmub/dmub_srv.h
@@ -237,6 +237,7 @@ struct dmub_srv_hw_params {
 	bool load_inst_const;
 	bool skip_panel_power_sequence;
 	bool disable_z10;
+	bool disable_dpia;
 };
 
 /**
diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 4c61e73ceccd..b37a485fcba5 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -369,8 +369,7 @@ union dmub_fw_boot_options {
 		uint32_t disable_clk_gate: 1; /**< 1 if clock gating should be disabled */
 		uint32_t skip_phy_init_panel_sequence: 1; /**< 1 to skip panel init seq */
 		uint32_t z10_disable: 1; /**< 1 to disable z10 */
-		uint32_t reserved2: 1; /**< reserved for an unreleased feature */
-		uint32_t reserved_unreleased1: 1; /**< reserved for an unreleased feature */
+		uint32_t enable_dpia: 1; /**< 1 if DPIA should be enabled */
 		uint32_t invalid_vbios_data: 1; /**< 1 if VBIOS data table is invalid */
 		uint32_t reserved_unreleased2: 1; /**< reserved for an unreleased feature */
 		uint32_t reserved : 22; /**< reserved */
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c
index 6ac370c15dea..3988f65f1ea4 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn31.c
@@ -338,6 +338,7 @@ void dmub_dcn31_enable_dmub_boot_options(struct dmub_srv *dmub, const struct dmu
 	union dmub_fw_boot_options boot_options = {0};
 
 	boot_options.bits.z10_disable = params->disable_z10;
+	boot_options.bits.enable_dpia = params->disable_dpia ? 0 : 1;
 
 	REG_WRITE(DMCUB_SCRATCH14, boot_options.all);
 }
-- 
2.25.1

