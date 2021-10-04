Return-Path: <SRS0=otPk=OY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E14B6C433EF
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Oct 2021 14:44:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD67A6137D
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Oct 2021 14:44:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AD67A6137D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 307246EA07;
	Mon,  4 Oct 2021 14:44:53 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2078.outbound.protection.outlook.com [40.107.223.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DBB956EA07
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Oct 2021 14:44:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lDe/Sj5a+joEqfoPSMYXCxjY6pCBHHvWZuPOSzYBQeuT7ziRhqEtadpNIhXowRhmqGD5dm8GpwAvLkt0Nh1rUZpkPoJGcFz4yw/n5hARabwniKV8TvtVkmtyET6oE3vhGQg/aF1KX+sbSJGWI1F47WTC+OUNnqPwM++bsE0CAt/RKO5Ui6lGI/kvHeDwtPv0TGQYN0O0Pj0B+WWGppaoet65m083idJBH8kkWXXZc8TK9D6d9lHNaSlFK+lSiSbFfS0zgXN9d4YIqpwHoT0CpMCvD0gaOK5Uqva5GHlYA2lLxCkeaLOI5fVgMigb20NrjnZi8bgL7uqJ2nsw8cWoUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tKt6XFlJh7FwlR/lfbeJaH/umPDnufIcPSBVFNxvOiE=;
 b=i5a/a2vkznye0o1hQmWngTN793Kb8y/CDgpHBj+G1YQTC0Tup2xtgQFA85NNFARs1z0jCCcbpdV8/PvC0q+7zI37JWVoYSstKylMGCQlmwifsbPVeGSMbE4njWmP6+Rf2IPovU6bA8oYZy9CNCc+yfliULHCySuk8MFdo9lBUZa0F0zOQwRElQce7ltWA3OxKy4kHy88undYPkJCMTIlTxIATUIpct9QouKdEcLMDGkfO/rwmzELNRAn3eh36Jl5poATTv5gSWWZtLRa4tDDelBJlSBpbs2yh4WvPqLlu93GlMGKKLqDOrYKW7UOZmZkCI49IM/BwSOp5CWXgimftg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tKt6XFlJh7FwlR/lfbeJaH/umPDnufIcPSBVFNxvOiE=;
 b=UDO7BzwMsxHivmw6D8iad+eq3hqAvJlrK2fLC3AA5xrB1UI02rD96mjoZFQKSm4WAitST/ZI7yRtde+cGpiSFHiafSVNLHOqNN+Mtu1eA+86cl9mhQH7o0k7TezqIOQUrUWViJJlC9A+j9aJVwxA5lKdlzLLMcrB3XOODw12a3E=
Received: from MWHPR22CA0041.namprd22.prod.outlook.com (2603:10b6:300:69::27)
 by MWHPR12MB1920.namprd12.prod.outlook.com (2603:10b6:300:10e::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.22; Mon, 4 Oct
 2021 14:44:49 +0000
Received: from CO1NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:69::4) by MWHPR22CA0041.outlook.office365.com
 (2603:10b6:300:69::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14 via Frontend
 Transport; Mon, 4 Oct 2021 14:44:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT005.mail.protection.outlook.com (10.13.174.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4566.14 via Frontend Transport; Mon, 4 Oct 2021 14:44:49 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Mon, 4 Oct 2021
 09:44:48 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Mon, 4 Oct 2021
 09:44:47 -0500
Received: from wayne-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2308.8
 via Frontend Transport; Mon, 4 Oct 2021 09:44:34 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <Harry.Wentland@amd.com>,
 <nicholas.kazlauskas@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <wayne.lin@amd.com>, <stylon.wang@amd.com>, <jude.shih@amd.com>,
 <jimmy.kizito@amd.com>, <meenakshikumar.somasundaram@amd.com>, Jimmy Kizito
 <Jimmy.Kizito@amd.com>, Wayne Lin <Wayne.Lin@amd.com>
Subject: [PATCH 16/23] drm/amd/display: Add dpia debug options
Date: Mon, 4 Oct 2021 22:40:43 +0800
Message-ID: <20211004144050.3425351-17-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211004144050.3425351-1-Wayne.Lin@amd.com>
References: <20211004144050.3425351-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 02677ebc-1529-4cd5-ced6-08d98745845b
X-MS-TrafficTypeDiagnostic: MWHPR12MB1920:
X-Microsoft-Antispam-PRVS: <MWHPR12MB19200081F93F89CDA19EBC4BFCAE9@MWHPR12MB1920.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g54k16zydFIGEbm2r1GYdummb90l+tQMPvsQ1BhUhbFwb/BAMZ4FI8dJHDgjbWJrJIxN1Nt4U8jPFK8JkedambwNLgXUPlfpKXIydwgsJIc8rg3yOBacSu4xfz0KmkZclMl9hOVJZHTnpVOKudMc/p4N5difStq3n35PdcEs7oS2cJze4TokMTa5mApXhVd/48vtT+Sd9visAtyYAhtKGizl6te0Yqzvy5qVFYGiFmDk3kZWSWsj1+nmo9wr547sYs25nqf2XLSuvMaNb5UC/Q86WpU0ZMwYPWd3DOc8NGwSDRBpBoRFLdvtsQpri9iJcHYlTOaj48Nv8UDBsvWzoQTg5Ci/faeyfLX9w9sMo33o0R5ST8Xu5R+i9jd0kbD6SuGqxn8n10tckcehwbivt6u7//xM8s3rRFH0nrjLl3fRMjoCtW5uM3CjBdU7V5l8xI88CpwqgHChW3BQpgw3s7bjjjd+VlUbUKac6kY+O2IkGwG3bmF9myCZWBwOm+7SiIWXGD/aii1XuGvlqJSzOJmH2chz3pCHwMumQ05O5YNinQfB+rHg3OfWIAyUy4uWmkWeOqkQK7ZPrlu2XHvDBQi7fi34n1hWksRDp7e9GqB3HcTf9S5gnisgmhNktWYxk9tjJw16DlXFGEq458oJENdniNJq6RmfEVf+PacVpJ3yIY3+PUjGkkAsLdPrx3QP1rmPP2IvWEklxko8zWeQ5ydFQU5MO0dMqMJOOfSsz+4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(316002)(83380400001)(426003)(186003)(86362001)(2906002)(508600001)(336012)(70586007)(47076005)(1076003)(70206006)(54906003)(36756003)(8676002)(8936002)(6666004)(81166007)(6916009)(7696005)(82310400003)(356005)(2616005)(5660300002)(36860700001)(26005)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2021 14:44:49.1249 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02677ebc-1529-4cd5-ced6-08d98745845b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1920
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

