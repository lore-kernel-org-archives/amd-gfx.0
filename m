Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03313C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Feb 2022 16:59:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E3BD10EE3C;
	Fri, 18 Feb 2022 16:59:41 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2068.outbound.protection.outlook.com [40.107.244.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 148D410EE40
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Feb 2022 16:59:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TEqWf+u0zfdtJMxqdfMFCnho3UpQGrFbWWPs9cl7v/iiHTovBh3Kdxep4Jp258MJ7PY4nhW5JKt1XDR0+di9ofUgUSQu05Uir0lyKPU9kA8VEcqdROy+xsDo8lwuFxMFs1gnq6cpk7ddTCntdXHM8fRH3EsA5XTdydjpGHlnGV0VzQff05v8YLY1qyD6ODoWAQaQvfyliMBjZ++QtDg5V+UKkHNQN9SwXpnQoweeytDR+qlNrqdip7FY3jQ9ys/C8JnbMGCsb7svA1xmIuyTUjL3f93J6OdO/ja7VaAdxCFj/bV0XuZX4H2z6kd/7bX2H8UaFt6QnMp1MbOpqkKPjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=toeToV3kP4v8YK8npXaR1N4g+UqH7EYyPzbhVcsQSxE=;
 b=htsMKKLzDy9kzQd8GB16CawW4DdrotABWCOVgNL4wFPUhpq7M/Sfi6YAutrsD5Odtj7+OWufOJ0jnb1Qrig1S6A71AjnNe+EM+sqVk6GOvA5Y1ln5cd1BDDpgJcuaoDxlwFL5MiaSGwOWqJhwg03+W2pX0921gIL0hDQ6SuHa1SveBjAvn9iurhGZxvDUTyWyWaFKrEvj4yCGeAtUSEGs6pqsTg++2POFtMwIPkha7E6qw/Hu26tgZ6OU0C4IPM3iP6lkfnlGx1a9AFgIitWjpxGZ5NqmOP2ClVukZ7BsApJOR5XoNnFUZuzZyV/dW1/BuMwhEMQRSV8NXfkOOddGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=toeToV3kP4v8YK8npXaR1N4g+UqH7EYyPzbhVcsQSxE=;
 b=wBSAHEURHo9SyKzgRCv805/0VpDkYpZ5wSmCi7NRrtsk7t8r8wLO5KJlltd4PAfVTzV4730Nqsk0YyhpbHFO1m0evbvU9Uzk2EXoqhqgFyAzxdCgqVOjam9usS74roixLsTDC+q5NMVCHA1jG8kXEMpyG4Z5oMpUYtDK1WoYuuE=
Received: from MW4PR03CA0003.namprd03.prod.outlook.com (2603:10b6:303:8f::8)
 by DM5PR12MB1577.namprd12.prod.outlook.com (2603:10b6:4:f::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4995.17; Fri, 18 Feb 2022 16:59:15 +0000
Received: from CO1NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8f:cafe::a1) by MW4PR03CA0003.outlook.office365.com
 (2603:10b6:303:8f::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16 via Frontend
 Transport; Fri, 18 Feb 2022 16:59:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT068.mail.protection.outlook.com (10.13.175.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4995.15 via Frontend Transport; Fri, 18 Feb 2022 16:59:15 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 18 Feb
 2022 10:59:13 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 11/13] drm/amd/display: Add DCN315 CORE
Date: Fri, 18 Feb 2022 11:58:52 -0500
Message-ID: <20220218165854.1417733-10-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220218165854.1417733-1-alexander.deucher@amd.com>
References: <20220218165854.1417733-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8ce8dc37-b3c7-4660-a989-08d9f2fffeeb
X-MS-TrafficTypeDiagnostic: DM5PR12MB1577:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB15778A8771080BCE694F7A1FF7379@DM5PR12MB1577.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:826;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: c1mNhS3lKS5AVaK9Zib24AsUgodMhbkIeP01zSYkXGfzTIXizBkJ1UxpcDViK9YtbFpXDqbHe9hZ1ZrpHqbPUJgkF4d5XTYYqRqRbfIMMaxoSJe5/Oa+8P+LYagfrUo2didMff1cPfaTHOfJf8WpZ6ZNSN/dJP2oFd6AJDWt72LldjnulUzGryzGV40s+kP3AMGtNVo8wMDUAhQibiDpdQcP6y6712Azm8OzZMkXihvWDAk+GSmeAkz7gxVPLgJZQmLgBG0Ud62V8JGhioCr2m7kCjNhzWSg+3ESD7OcEOGgZuw2mUSkbCmZ45Gd3faMVYTxgR3NEbes+ubVW5GZn+Z/1vaTqN/01XYBbBq+yMe1ISQn8IFriTZWyxkwsI7Y7he1RuELPIlFn5g5oRxCB3uUOHvHfBKJAU+Fn+iL/Dq6BzuUIBcZxBzJGP8UmtpBIWGjFRS9bVIKOXT9gxYRqcbSgZFKokshl70DVh5QPlk5n9UdgC/BDMSYCD591Ytk0eE+t6zFvD7dVewDMySXWIoO7OiPACRwnrobkyDEAZuI9TQclXGI3+wrUqHR173AoVR8OypEDY/J3PCvfJRXiBUDVbuFiLOiyUQGDbtxv8g9/BxqSufFSnVtGyc3KOQbzGz64XPRO3RxmR+nzRXl3a6ZLPbZbraHaggqLoFaN8INU/OVlH+mc7Krqy9QzZaw9a7+ryXHox7Woo21u0MSAw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(8936002)(6666004)(508600001)(1076003)(426003)(4326008)(316002)(8676002)(7696005)(86362001)(2616005)(70206006)(5660300002)(2906002)(36756003)(40460700003)(47076005)(70586007)(336012)(356005)(82310400004)(6916009)(54906003)(16526019)(26005)(186003)(36860700001)(81166007)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2022 16:59:15.5200 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ce8dc37-b3c7-4660-a989-08d9f2fffeeb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1577
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Qingqing Zhuo <qingqing.zhuo@amd.com>, Harry Wentland <Harry.Wentland@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Qingqing Zhuo <qingqing.zhuo@amd.com>

DC core changes for DCN 3.1.5.

Signed-off-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Acked-by: Harry Wentland <Harry.Wentland@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c     | 13 ++++++++++---
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c |  8 ++++++++
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 48858e31b092..417976426bbf 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -3236,9 +3236,16 @@ bool dc_link_setup_psr(struct dc_link *link,
 	/*skip power down the single pipe since it blocks the cstate*/
 #if defined(CONFIG_DRM_AMD_DC_DCN)
 	if (link->ctx->asic_id.chip_family >= FAMILY_RV) {
-		psr_context->psr_level.bits.SKIP_CRTC_DISABLE = true;
-		if (link->ctx->asic_id.chip_family == FAMILY_YELLOW_CARP && !dc->debug.disable_z10)
-			psr_context->psr_level.bits.SKIP_CRTC_DISABLE = false;
+		switch(link->ctx->asic_id.chip_family) {
+		case FAMILY_YELLOW_CARP:
+		case AMDGPU_FAMILY_GC_10_3_6:
+			if(!dc->debug.disable_z10)
+				psr_context->psr_level.bits.SKIP_CRTC_DISABLE = false;
+			break;
+		default:
+			psr_context->psr_level.bits.SKIP_CRTC_DISABLE = true;
+			break;
+		}
 	}
 #else
 	if (link->ctx->asic_id.chip_family >= FAMILY_RV)
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 004a299228ab..d266253a78a2 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -66,6 +66,7 @@
 #include "dcn302/dcn302_resource.h"
 #include "dcn303/dcn303_resource.h"
 #include "dcn31/dcn31_resource.h"
+#include "dcn315/dcn315_resource.h"
 #include "dcn316/dcn316_resource.h"
 #endif
 
@@ -156,6 +157,10 @@ enum dce_version resource_parse_asic_id(struct hw_asic_id asic_id)
 		if (ASICREV_IS_YELLOW_CARP(asic_id.hw_internal_rev))
 			dc_version = DCN_VERSION_3_1;
 		break;
+	case AMDGPU_FAMILY_GC_10_3_6:
+		if (ASICREV_IS_GC_10_3_6(asic_id.hw_internal_rev))
+			dc_version = DCN_VERSION_3_15;
+		break;
 	case AMDGPU_FAMILY_GC_10_3_7:
 		if (ASICREV_IS_GC_10_3_7(asic_id.hw_internal_rev))
 			dc_version = DCN_VERSION_3_16;
@@ -251,6 +256,9 @@ struct resource_pool *dc_create_resource_pool(struct dc  *dc,
 	case DCN_VERSION_3_1:
 		res_pool = dcn31_create_resource_pool(init_data, dc);
 		break;
+	case DCN_VERSION_3_15:
+		res_pool = dcn315_create_resource_pool(init_data, dc);
+		break;
 	case DCN_VERSION_3_16:
 		res_pool = dcn316_create_resource_pool(init_data, dc);
 		break;
-- 
2.35.1

