Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A362C433EF
	for <amd-gfx@archiver.kernel.org>; Sat,  5 Feb 2022 04:33:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E847910EEAD;
	Sat,  5 Feb 2022 04:33:44 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2088.outbound.protection.outlook.com [40.107.236.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8BF010ED91
 for <amd-gfx@lists.freedesktop.org>; Sat,  5 Feb 2022 04:33:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PR246Ym2BcYEomV9biz0Hi0MMIs/GbFpN7hTGTdyzwv7PT5DIMdjfu/CxGDngx0NdNvuX2Wy7B7g6dYovnOU92F/JLhEb+/CvLW1KEqJFzXlWknyXk1BTF/fMEK+boMGObhc0ecSHB3fVhvk/KsQ/QagLWkPobP8WW4MBHVf+5PRY6JXtSoL+DyU+PCPduZ9Bhd98ta0ncxlpXzT/gAldN72qyprYXFXTzFFbIXtz2KdlOzd6PourbldA/INiOUXQTrKUk32cOWGkL31vles4jhuLNP1+3JlpIzJlyx2rpb5wz/6/waWDt9yWey+Z22MXgOMho19YDnEwLO6NIiYQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SJSf8AFrXQe0evn8zO2+VFQWb2julKfUkdgvMjDHU20=;
 b=lNotK3QVpZm+q/6Vhja2MyaFIXzW6vG1C5lGH2GUWt7QBzj2HCGaHs3OZM88GiG7Ypp0ggEtUHX+KYOlrG2dlPFnx17eF/SAOceUqent0/hl0Fa53y5u5sQF9QJbapuSxMlTc1WTVQq+XWBDCTrrxJ7EaEHvio6SXscMHSFoKRfYN9rYJ6OEZ9cy07LT9cOAYJWrhXS+ZV1Ii8OGn2pm/jdLWAHSrB8aeSJIklJKkmSdT+CFXmGL/QPUY8y3X3x9JTI7AneQ7tNf78e0jLp9SoZ3PLP61HRnNkrkrXwpeSopjVDij7H8ylUKawGlnjh0k6DcyNZQg8gbhMOzrjHW+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SJSf8AFrXQe0evn8zO2+VFQWb2julKfUkdgvMjDHU20=;
 b=FrKFMxYs6yRx574QpO8cSv6AHGTxaZtRF1FJd1o2Q8cV6vMteH1QJ7PSK3IpU9vx2kefxGKF64Yp3qSmkof8pIugjsBucbAVHaTCTiI7sz9h0ZODxyo3G5vZ91A3Ct2UfS6GjLoiMyiGGyRqa0tTaM8Af+9Q/gsShPuY1nuV4Hg=
Received: from MWHPR15CA0028.namprd15.prod.outlook.com (2603:10b6:300:ad::14)
 by MW3PR12MB4473.namprd12.prod.outlook.com (2603:10b6:303:56::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.17; Sat, 5 Feb
 2022 04:33:32 +0000
Received: from CO1NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:ad:cafe::27) by MWHPR15CA0028.outlook.office365.com
 (2603:10b6:300:ad::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.17 via Frontend
 Transport; Sat, 5 Feb 2022 04:33:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT025.mail.protection.outlook.com (10.13.175.232) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4951.14 via Frontend Transport; Sat, 5 Feb 2022 04:33:31 +0000
Received: from jasdeep-System-Product-Name.hitronhub.home (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Fri, 4 Feb 2022 22:33:30 -0600
From: Jasdeep Dhillon <jdhillon@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/13] drm/amd/display: change fastboot timing validation
Date: Fri, 4 Feb 2022 23:33:04 -0500
Message-ID: <20220205043310.165991-8-jdhillon@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220205043310.165991-1-jdhillon@amd.com>
References: <20220205043310.165991-1-jdhillon@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9901dfdc-532a-4a45-eb18-08d9e860aa39
X-MS-TrafficTypeDiagnostic: MW3PR12MB4473:EE_
X-Microsoft-Antispam-PRVS: <MW3PR12MB44735AFC1CE363788C2C9CE9FB2A9@MW3PR12MB4473.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:820;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KG9cX6/uvW1+nB1hugyab9ZBOpk+e3cBIZjoi4BXytAw8JY84Yyspc9p+HVsPSNNxT9ZxYJKqhipTufXcPuPNXmmHboK6a/8i94E50kay1XEKBsQc53bThNwUzyGYkwG9G36EZ89cvTJY/tRmgejqxsUrSehkNn3z9eQqMRd/eqiDOGrUNDj7u4INhGUy5C5z2KSNoXdviCMFbcwoBE4MYKG63Cf1Jxdj76wA0UVBaZimrpk27VJQ3eTccAQB7o9GqiCs0lPZzvlzGcAdHEtHhR82zToM5jX6xAyvM+8dbhsVSY1msTtp8rkiu9SyiHcAO9FfUPu2Tz8KlvZm0zNpriolcT33ncXA5LEPQQ/SoXiXel7cRvZvoUv01kfqDDOB1XxlDAGeZJzrAAvSuBruRPhx/KDqVIzp3VEJp4h3v7txm6zRHV50+PmzhXO1pWk+O9ZS+r4AiBFnzqA447J8cKm6D3/Fc8/QVf/nEXk+R0BmgFa9CKXEw7pGIcUJmU98+66d5mXe7UCwOecttKn2Uut4vrmhL5aozg/dK45Ix3t/wWPp/6DGC7NK7XzaG+vZ2mjXYYDxWP11HPhyo07eGHEFuwlu43/qxNenS69vZ9rXes+AjBgMFsuhxWMRWFwNS6keXUukm6D3Ha0YVHuTBPph/beHVN/q35ct/9n9D9Ihxjo09/ysIW3jNnuMLooDOHR4phqkh62NSoBtwwQUQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(508600001)(6916009)(316002)(6666004)(54906003)(2906002)(36756003)(8676002)(4326008)(8936002)(5660300002)(70206006)(70586007)(2616005)(36860700001)(16526019)(356005)(426003)(336012)(47076005)(83380400001)(1076003)(26005)(186003)(81166007)(40460700003)(82310400004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2022 04:33:31.8187 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9901dfdc-532a-4a45-eb18-08d9e860aa39
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4473
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
Cc: stylon.wang@amd.com, Anthony Koo <Anthony.Koo@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Jasdeep Dhillon <jdhillon@amd.com>, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Paul Hsieh <paul.hsieh@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Paul Hsieh <paul.hsieh@amd.com>

[Why]
VBIOS light up eDP with 6bpc but driver use 8bpc without
disable valid stream then re-enable valid stream. Some
panels can't runtime change color depth.

[How]
Change fastboot timing validation function. Not only check
LANE_COUNT, LINK_RATE...etc

Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Jasdeep Dhillon <jdhillon@amd.com>
Signed-off-by: Paul Hsieh <paul.hsieh@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c                    | 2 +-
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c           | 2 +-
 drivers/gpu/drm/amd/display/dc/dc.h                         | 2 +-
 drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c | 3 ++-
 4 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 1d9404ff29ed..997eb7e2d2b3 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1467,7 +1467,7 @@ static bool context_changed(
 	return false;
 }
 
-bool dc_validate_seamless_boot_timing(const struct dc *dc,
+bool dc_validate_boot_timing(const struct dc *dc,
 				const struct dc_sink *sink,
 				struct dc_crtc_timing *crtc_timing)
 {
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 9df66501a453..b36bae4b5bc9 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -2168,7 +2168,7 @@ static void mark_seamless_boot_stream(
 
 	if (dc->config.allow_seamless_boot_optimization &&
 			!dcb->funcs->is_accelerated_mode(dcb)) {
-		if (dc_validate_seamless_boot_timing(dc, stream->sink, &stream->timing))
+		if (dc_validate_boot_timing(dc, stream->sink, &stream->timing))
 			stream->apply_seamless_boot_optimization = true;
 	}
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 69d264dd69a7..8248d4b75066 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1125,7 +1125,7 @@ struct dc_validation_set {
 	uint8_t plane_count;
 };
 
-bool dc_validate_seamless_boot_timing(const struct dc *dc,
+bool dc_validate_boot_timing(const struct dc *dc,
 				const struct dc_sink *sink,
 				struct dc_crtc_timing *crtc_timing);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
index 8c32b9cb3b49..52b22a944f94 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
@@ -1761,7 +1761,8 @@ void dce110_enable_accelerated_mode(struct dc *dc, struct dc_state *context)
 			    edp_link->link_status.link_active) {
 				struct dc_stream_state *edp_stream = edp_streams[0];
 
-				can_apply_edp_fast_boot = !is_edp_ilr_optimization_required(edp_stream->link, &edp_stream->timing);
+				can_apply_edp_fast_boot = dc_validate_boot_timing(dc,
+					edp_stream->sink, &edp_stream->timing);
 				edp_stream->apply_edp_fast_boot_optimization = can_apply_edp_fast_boot;
 				if (can_apply_edp_fast_boot)
 					DC_LOG_EVENT_LINK_TRAINING("eDP fast boot disabled to optimize link rate\n");
-- 
2.25.1

