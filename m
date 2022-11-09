Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3E68C4332F
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Nov 2022 06:15:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0128B10E07F;
	Wed,  9 Nov 2022 06:15:33 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2043.outbound.protection.outlook.com [40.107.94.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3630E10E575
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Nov 2022 06:15:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gMErzlkVhHikoAI4TilZNcCObOovJEZaK4LrvD6a3rKyBiFr6NZ7gcvpz8iB1G9zC+kjWpLZ7N2ySdIHvBG0G+z7kWLkHhQOGJnFbHs8zuky2noPNOmfhgvFINZ3kkeKir/IGjncdW4qqmvehPcmTj/MfWmFWQXdggOwe1z6IAC+mDS4MZYuZybNbxdU8rpT8Z2syCpF0aTwhqZITyTXcpgClE/1iR/1GrBgxRiGeSRNleCtCHr4IqbR8RKZZUUxzXLanGjkX8zkKEvqSXEwDKRQb9BXYRGnNr//rh2ZX19OqwaK6wAdM1HlOL4POn2j3mYb9QRp4+n/MD9shiqQkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hyQpMul53muzhi82G5AC4yQMAocnynP8sS0m5f9NfQA=;
 b=hCYIoTdRSfdnKZcMT7XHIy0dHMdfp5066aqEeClG9LKgdsyiqY2pXDy+IXI6oiNNq+S2QJUulspd2Jop1+xKh/lLo7woYJmhykq+l5DacRplylvP1OF2tpVTfmtEEOJnYLu/VTdvpc3w5ZgJ8B2DU1HhXsz7qX7LGhXNE7oWDsvp4wsALRTOuAJKlSit7R+XciYlnxmhBK9upppibulVm9QPH0tstocEWuFjp/x4cD4mpv67OpENkmBQ+johPTDbpFhm79LK4JLN9EBb31VROa8+octOI2L7oK8KugwcPIaeZMkWgLh/s4yt5p4a9d1TvJGe5BEskCrgk5am8FSeJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hyQpMul53muzhi82G5AC4yQMAocnynP8sS0m5f9NfQA=;
 b=LoHVCUoXrm5Ot7Ckea57YyijMjrL6DIpwgsLLHnxMMUssiBHkscVoC/yANv8TPdT1rFc5hxn0mstaOzTVdUpiCSJmaCOfZUjYej62JzmhpDfRVScUkO3aoKrHficRMPj1dCRxt616Ddga47mxsz3FENYfoKiv/Ta4a9HBBEDKwM=
Received: from DM6PR04CA0013.namprd04.prod.outlook.com (2603:10b6:5:334::18)
 by DS0PR12MB7581.namprd12.prod.outlook.com (2603:10b6:8:13d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Wed, 9 Nov
 2022 06:15:25 +0000
Received: from DM6NAM11FT111.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:334:cafe::5f) by DM6PR04CA0013.outlook.office365.com
 (2603:10b6:5:334::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27 via Frontend
 Transport; Wed, 9 Nov 2022 06:15:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT111.mail.protection.outlook.com (10.13.173.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5813.12 via Frontend Transport; Wed, 9 Nov 2022 06:15:25 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 9 Nov
 2022 00:15:18 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 8 Nov
 2022 22:15:11 -0800
Received: from tom-HP.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.31 via Frontend
 Transport; Wed, 9 Nov 2022 00:15:06 -0600
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/29] drm/amd/display: clean up some irq service code for
 dcn201
Date: Wed, 9 Nov 2022 14:12:56 +0800
Message-ID: <20221109061319.2870943-7-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221109061319.2870943-1-chiahsuan.chung@amd.com>
References: <20221109061319.2870943-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT111:EE_|DS0PR12MB7581:EE_
X-MS-Office365-Filtering-Correlation-Id: f70b3c08-5edd-46bd-25fb-08dac219ca7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ewz36icOj7xWuBf9QpmW/dlaTpztEwS+vKRA9Q+C5lt70yfJBlU1/twOb41lFoapOcDCfH0o+6cmcwl7hvDS31P2iTyeIwHa5vmAmYGfasuW/4rC8d827Ca+lIiph+3JfMvjB2QgRqE7EnM3OeTrN2kXBleaAg+oQfgsVTpR2BDR1FG+tmJ5j8+JQSSEqX2sZW08yK3kMiyLb/UhZzksGpR3HxUNOSmV36mH7W28hC+ryBDKMPAG9O0gaA6gfNmQjfuOSlN9tU7gZuyVcrO/EJrUcnr9uaUUH/Fz1X7RHv0kY29rJs94wfdmRNKqyc3YHGwhKZhNiUbyhNlHM8euxqiQK1POakKNbJPxBwztBshxwEKIBmpvLCanoHOO2dtBjn7SN+XdDeyXvtozSqDsVmqUto37ylgDxU0K+S2WHm3axli4kUQpMup1sHlD8ZxTstvyrKyWV+NoIdmW2ds0Pg30FuURHzW7VpCJdyQgWngq6I8fdAeSU6umdHjO8pD9cqsnSrcfZ9j9bxmxEn3A65xzlFfhE69meQ9bnOXBR8ZySy++Ud4bT/we/Gws+iVN8FphJ+3uBe7/sOQOWZ8N5UPRjGpDXEEHfPhw45/O2S9VX4VAAYVjdvvgefLb/rfkSJHbpwU1PmjhetNtJzHcdBhK/GcA7UFeJIHJDWw1gGNjuCMQEokNRgzXIq9m78NQZ2h9eIBLr9DkdS6h5DlBwhWHq5rxfsweu9qR0hG0Z6RBUKwqX2qXn0GriFPY+rBi4o2voALfi4VE1sH//Oi3EIM/3TrQYKydsOqTsaUV79xl9QQgC4sRAN6oy6qkWcgh
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(396003)(136003)(376002)(39860400002)(451199015)(36840700001)(46966006)(40470700004)(47076005)(426003)(2616005)(2906002)(8676002)(41300700001)(70206006)(70586007)(4326008)(40480700001)(83380400001)(26005)(81166007)(356005)(86362001)(82310400005)(36756003)(316002)(54906003)(6666004)(82740400003)(478600001)(5660300002)(36860700001)(186003)(8936002)(7696005)(40460700003)(336012)(6916009)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2022 06:15:25.2579 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f70b3c08-5edd-46bd-25fb-08dac219ca7d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT111.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7581
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
Cc: stylon.wang@amd.com, Charlene Liu <Charlene.Liu@amd.com>,
 Tom Chung <chiahsuan.chung@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Liu Xi <xi.liu@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Liu Xi <xi.liu@amd.com>

[Why and how]

Clean up some irq service code for dcn201.

Reviewed-by: Charlene Liu <Charlene.Liu@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Liu Xi <xi.liu@amd.com>
---
 .../display/dc/irq/dcn201/irq_service_dcn201.c  | 17 ++++++++++-------
 .../display/dc/irq/dcn201/irq_service_dcn201.h  |  2 +-
 2 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn201/irq_service_dcn201.c b/drivers/gpu/drm/amd/display/dc/irq/dcn201/irq_service_dcn201.c
index 45f99351a0ab..5f4f6dd79511 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/dcn201/irq_service_dcn201.c
+++ b/drivers/gpu/drm/amd/display/dc/irq/dcn201/irq_service_dcn201.c
@@ -28,20 +28,19 @@
 #include "include/logger_interface.h"
 
 #include "../dce110/irq_service_dce110.h"
+#include "irq_service_dcn201.h"
 
 #include "dcn/dcn_2_0_3_offset.h"
 #include "dcn/dcn_2_0_3_sh_mask.h"
 
 #include "cyan_skillfish_ip_offset.h"
 #include "soc15_hw_ip.h"
-
-#include "irq_service_dcn201.h"
-
 #include "ivsrcid/dcn/irqsrcs_dcn_1_0.h"
 
-static enum dc_irq_source to_dal_irq_source_dcn201(struct irq_service *irq_service,
-						   uint32_t src_id,
-						   uint32_t ext_id)
+enum dc_irq_source to_dal_irq_source_dcn201(
+		struct irq_service *irq_service,
+		uint32_t src_id,
+		uint32_t ext_id)
 {
 	switch (src_id) {
 	case DCN_1_0__SRCID__DC_D1_OTG_VSTARTUP:
@@ -79,7 +78,6 @@ static enum dc_irq_source to_dal_irq_source_dcn201(struct irq_service *irq_servi
 	default:
 		return DC_IRQ_SOURCE_INVALID;
 	}
-	return DC_IRQ_SOURCE_INVALID;
 }
 
 static bool hpd_ack(
@@ -138,6 +136,11 @@ static const struct irq_source_info_funcs vupdate_no_lock_irq_info_funcs = {
 	.ack = NULL
 };
 
+static const struct irq_source_info_funcs dmub_outbox_irq_info_funcs = {
+	.set = NULL,
+	.ack = NULL
+};
+
 #undef BASE_INNER
 #define BASE_INNER(seg) DMU_BASE__INST0_SEG ## seg
 
diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn201/irq_service_dcn201.h b/drivers/gpu/drm/amd/display/dc/irq/dcn201/irq_service_dcn201.h
index 8e27c5e219a3..0cfd2f2d62e8 100644
--- a/drivers/gpu/drm/amd/display/dc/irq/dcn201/irq_service_dcn201.h
+++ b/drivers/gpu/drm/amd/display/dc/irq/dcn201/irq_service_dcn201.h
@@ -1,5 +1,5 @@
 /*
- * Copyright 2018 Advanced Micro Devices, Inc.
+ * Copyright 2022 Advanced Micro Devices, Inc.
  *
  * Permission is hereby granted, free of charge, to any person obtaining a
  * copy of this software and associated documentation files (the "Software"),
-- 
2.25.1

