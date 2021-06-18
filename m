Return-Path: <SRS0=S25v=LM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3E73C48BDF
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Jun 2021 17:35:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AA4860698
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Jun 2021 17:35:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AA4860698
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B9366EA4C;
	Fri, 18 Jun 2021 17:35:42 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99E5B6EA4D
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Jun 2021 17:35:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O9e6Tkm1hEO2GowLnwRvPkM474xYR73tGplOiv70GL40Ep0SnRFJjXjBvRrLYGGji12tamCnp2BjYk1ob0HbNqUqcob60StzaxyNazEBPrPgnNluyABinaxaIe2weycSGqtd0cOH1JBnv7wixqqI9CtYz+mpkdCOttZinUxD1qARI8+GugUMLLIMEDeN5N9rTv9T/CycPQBO2lKo7gkt9HWTyh7QfzQlXBLq0DRPybG5DN9YZGa+bXFEpHAnRXczjNewhInrrcMhPNoCKAXRWF57Po85IeCgHpo2l9XokknfEMAYyb7P7rU9t3Z2m5S+LsJGRP8//ibw1RR8HlTlpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KXlbyaxmXZ7tAu4WAHyasEcREuHrVaelxidf8mBO5fo=;
 b=n7iZDZAcIo9WbGLN/R6kzqzKeImxjgTQtULnVcGNjScu1htClDcG6RzhM147aV8poF+5SBphsF83pJZ8/Hwr4puAN1t4fAVjt7ysByfYTJXO3GJGWRQdglmo6nlOlvkJ34gfjeLLWEhDWNO0gca6tRyoW4xaEzl5QODcTiXCXvSUsaAwed/mYXMSCNyREzYQx+zmTmA7bakJ22QrPf7qrNqwq13zBJXKqv4sV0CrTmmqruO8zP8UsHRFh7MfP+r2tp4YJJ9q0HzWMkKs06xX7Ok7x5MWv1rZzW6XiBZatnYfI40RRD5euKGbEa+CBvY4S+YUD6Y1t9AE4ldrbjd4oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KXlbyaxmXZ7tAu4WAHyasEcREuHrVaelxidf8mBO5fo=;
 b=jNd8NacPA6mlsjFJGtzwiNDGpqKhn5xrDG0zJZvi4LX7JjRjJl3LYj4BuRW55HbmRoqHEzQqXTdM0FZYmEi3C7kL9/8oAAFcavYRiXy1bjDWpiARn6b/GybSkzVrxzsjJ1evfFh/ESAH0vHoM1N98MgFC1w6sz+MPYfzyXLxMBY=
Received: from BN6PR1701CA0021.namprd17.prod.outlook.com
 (2603:10b6:405:15::31) by DM5PR12MB1564.namprd12.prod.outlook.com
 (2603:10b6:4:f::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Fri, 18 Jun
 2021 17:35:38 +0000
Received: from BN8NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:15:cafe::91) by BN6PR1701CA0021.outlook.office365.com
 (2603:10b6:405:15::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.15 via Frontend
 Transport; Fri, 18 Jun 2021 17:35:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT009.mail.protection.outlook.com (10.13.176.65) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4242.16 via Frontend Transport; Fri, 18 Jun 2021 17:35:38 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 18 Jun
 2021 12:35:37 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 18 Jun
 2021 10:35:37 -0700
Received: from bindu-HP-EliteDesk-705-G4-MT.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.4
 via Frontend Transport; Fri, 18 Jun 2021 12:35:31 -0500
From: Bindu Ramamurthy <bindu.r@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/12] drm/amd/display: get socBB from VBIOS for dcn302 and
 dcn303
Date: Fri, 18 Jun 2021 13:35:07 -0400
Message-ID: <20210618173514.430647-6-bindu.r@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210618173514.430647-1-bindu.r@amd.com>
References: <20210618173514.430647-1-bindu.r@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1fd8a319-544c-45e2-d067-08d9327f7cc1
X-MS-TrafficTypeDiagnostic: DM5PR12MB1564:
X-Microsoft-Antispam-PRVS: <DM5PR12MB156449FA14BC632F8F477E50F50D9@DM5PR12MB1564.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YQ4QQU05fpJZuk4nvIY0VUgvbX6/BZL99NeC0EvkPcQs3njwo7kp9Dm03gnmP22W/UbaZotmDqxID4aolgIY9YzWhAWmaybo7F2MQJcqIEUOvRLUVbT3HLm2vC6BAwNeJPVEi4XVkFIv+2SRNjWFYBOQByMnheMBByNNEpkQzAsdKpTBdcgGKc2zuFQozmgWOGkg4swmoMTQMpsJtfQa8NOZO/2T+pfDK+Rm5Pp6gUcMxM6aB5xoQbYU5+sVIU8OFBpbFn6yaTOfsTeylnuCNtyXwDdCBI30ja9H2j0zHwWWwKyGIQbg0f+EdrtnqFEK4lTTN7iAmTjeDc1GtZOF3t/xW3dDZ0ZNQPHQ5zAjLsjoJGBeBLjPLPKzuHSUCsGFImMaAdGyCdwalfAKy4vN9uaWuP+W8Syu2pbF9HaEwkMVrhgAoiS08ofDQa1jkHrXIPb4tlG0sz0ZSrr6Chj9E92vQCR8Psd9eObyM2vtEmgrFxUz7giYIO6T8Etpb/zpvmVWK1GBS3CJX0xH4RPPc7lkl8Y+WSIIeGwK6XaKf0L2A0I8T+Y4lbb8dDHBK1sAatDIgG8wS+//HLr9X605WKkjxuIA5dZTcuIIHkqq6P85x0slsQpEFj/aJiNUMKCqHT5mHxzjDtfR56aNH32vtNusavlK/GqUh4MsuStOQsDYmyeUw/G0g5d1uZy195lP
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(346002)(396003)(136003)(39860400002)(36840700001)(46966006)(36756003)(316002)(336012)(4326008)(47076005)(2616005)(426003)(356005)(70586007)(5660300002)(86362001)(82740400003)(36860700001)(2906002)(8676002)(7696005)(82310400003)(26005)(70206006)(54906003)(478600001)(83380400001)(81166007)(186003)(1076003)(8936002)(6666004)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2021 17:35:38.4508 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fd8a319-544c-45e2-d067-08d9327f7cc1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1564
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
Cc: Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Anson.Jacob@amd.com,
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aurabindo Pillai <aurabindo.pillai@amd.com>

[why]
Some SOC BB paramters may vary per SKU, and it does
not make sense for driver to hardcode these values.
This change was added for dcn30 and dcn301, but not
for dcn302 and dcn303

[how]
Parse the values from VBIOS if available, and use
them if valid
Fixes: "drm/amd/display: get socBB from VBIOS"

Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Acked-by: Bindu Ramamurthy <bindu.r@amd.com>
---
 .../amd/display/dc/dcn302/dcn302_resource.c   | 20 +++++++++++++++++++
 .../amd/display/dc/dcn303/dcn303_resource.c   | 20 +++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c b/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
index 628b227f0a13..16a75ba0ca82 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
@@ -1102,6 +1102,26 @@ static bool init_soc_bounding_box(struct dc *dc,  struct resource_pool *pool)
 	loaded_ip->max_num_dpp = pool->pipe_count;
 	loaded_ip->clamp_min_dcfclk = dc->config.clamp_min_dcfclk;
 	dcn20_patch_bounding_box(dc, loaded_bb);
+
+	if (dc->ctx->dc_bios->funcs->get_soc_bb_info) {
+		struct bp_soc_bb_info bb_info = { 0 };
+
+		if (dc->ctx->dc_bios->funcs->get_soc_bb_info(
+			    dc->ctx->dc_bios, &bb_info) == BP_RESULT_OK) {
+			if (bb_info.dram_clock_change_latency_100ns > 0)
+				dcn3_02_soc.dram_clock_change_latency_us =
+					bb_info.dram_clock_change_latency_100ns * 10;
+
+			if (bb_info.dram_sr_enter_exit_latency_100ns > 0)
+				dcn3_02_soc.sr_enter_plus_exit_time_us =
+					bb_info.dram_sr_enter_exit_latency_100ns * 10;
+
+			if (bb_info.dram_sr_exit_latency_100ns > 0)
+				dcn3_02_soc.sr_exit_time_us =
+					bb_info.dram_sr_exit_latency_100ns * 10;
+		}
+	}
+
 	return true;
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c b/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c
index 88b609c32b0a..34b89464ae02 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c
@@ -1028,6 +1028,26 @@ static bool init_soc_bounding_box(struct dc *dc,  struct resource_pool *pool)
 	loaded_ip->max_num_dpp = pool->pipe_count;
 	loaded_ip->clamp_min_dcfclk = dc->config.clamp_min_dcfclk;
 	dcn20_patch_bounding_box(dc, loaded_bb);
+
+	if (dc->ctx->dc_bios->funcs->get_soc_bb_info) {
+		struct bp_soc_bb_info bb_info = { 0 };
+
+		if (dc->ctx->dc_bios->funcs->get_soc_bb_info(
+			    dc->ctx->dc_bios, &bb_info) == BP_RESULT_OK) {
+			if (bb_info.dram_clock_change_latency_100ns > 0)
+				dcn3_03_soc.dram_clock_change_latency_us =
+					bb_info.dram_clock_change_latency_100ns * 10;
+
+			if (bb_info.dram_sr_enter_exit_latency_100ns > 0)
+				dcn3_03_soc.sr_enter_plus_exit_time_us =
+					bb_info.dram_sr_enter_exit_latency_100ns * 10;
+
+			if (bb_info.dram_sr_exit_latency_100ns > 0)
+				dcn3_03_soc.sr_exit_time_us =
+					bb_info.dram_sr_exit_latency_100ns * 10;
+		}
+	}
+
 	return true;
 }
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
