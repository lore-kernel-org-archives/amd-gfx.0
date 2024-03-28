Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D3DBCD11DF
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Mar 2024 19:52:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 79961112537;
	Thu, 28 Mar 2024 19:52:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="I389eNiz";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2049.outbound.protection.outlook.com [40.107.93.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 89EB410E0C6
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Mar 2024 19:52:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O0wiGIsZPZn03ZPRsPQcXXYuW2UtzovzDctxd8IpEr1v1kHVJOO2iU2bL5CltOx0wW82xo7X524uBtotSDKoANhNJAP+jZF0lmo8YyOzmApLs0OJmh6qtXsZ4SgjDsFXhbKcgX379bdmqz1c1QuCyye56zf4NM34SPQtHxM5NgnwiPbTVaEcup4Uci/7u5NlsvSNlWa+tRpxUy6ZqdsAUStZuMSMu3hv30yPjwcTqJJp0+CsyYcE41wu9tGsJMq99OD+ZsiZ2HN/Gj3XCzkWm6wUy5HXzKgLaCTuMFbyo3tshbwgL5zKmM4bJxska6JT+319aRedw5oVQaEu0FbydA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=869VPBHmfoktNEyo+2XzfQpuHqpjdTPJ81sxRsWWxx8=;
 b=dUdUDOdWGJCpOXFYV01jJ9t4MEAHucSQ/kF1XF5jYGoBUQvHNpn+ct0S3AYFbnR1SoMk+A+w4T+xcB6H6bq3Y0NmN6TXMQtaUJr+CLAAqT4B8xCUR9gJBQnzNCoXiGYNrejqm73yfOfrKW3EzQC9q51zH5PjMWym4S4ZLisZoDL0wp17WVZgf4Vk6spr9nxD/sOQ1jCHpEL1FRAHpaI32qcymU9oUxue7W0a2OCkgUaQF/wpJ596Y3MGvy+Du8YeNAwQH8Yd4f+SCfsyifF0vkrDZXlC4QkN/idTS3fo4wLs6HmV7xcqparCRnxfzYCkTWksKDASHMubEPxdM+KzAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=869VPBHmfoktNEyo+2XzfQpuHqpjdTPJ81sxRsWWxx8=;
 b=I389eNizZvr+15qj2QPQmCF2MpBAWEgPS+8BL0TWkC8CTH2zJXSf4kQle4CsuRdnRSAHJUU+cEbMPvEM3hJzRUdx3NbmMcMhrb8k4u87SuhWY1M/zde9HdQB6XGV4rsZC1q7BsHK7UOAQ4EGBcZXItpz137rNUFMLJRtC0YADUw=
Received: from SJ0PR13CA0229.namprd13.prod.outlook.com (2603:10b6:a03:2c1::24)
 by PH8PR12MB7182.namprd12.prod.outlook.com (2603:10b6:510:229::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Thu, 28 Mar
 2024 19:52:18 +0000
Received: from CO1PEPF000042A9.namprd03.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::53) by SJ0PR13CA0229.outlook.office365.com
 (2603:10b6:a03:2c1::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Thu, 28 Mar 2024 19:52:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000042A9.mail.protection.outlook.com (10.167.243.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Thu, 28 Mar 2024 19:52:17 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 28 Mar
 2024 14:52:11 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 28 Mar
 2024 14:52:10 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 28 Mar 2024 14:52:10 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Daniel Wheeler <daniel.wheeler@amd.com>, <Harry.Wentland@amd.com>,
 <Sunpeng.Li@amd.com>, <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, 
 <roman.li@amd.com>, <wayne.lin@amd.com>, <solomon.chiu@amd.com>,
 <agustin.gutierrez@amd.com>, <hamza.mahfooz@amd.com>
Subject: [PATCH 41/43] drm/amd/display: Includes adjustments
Date: Thu, 28 Mar 2024 15:50:45 -0400
Message-ID: <20240328195047.2843715-42-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240328195047.2843715-1-Roman.Li@amd.com>
References: <20240328195047.2843715-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Roman.Li@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A9:EE_|PH8PR12MB7182:EE_
X-MS-Office365-Filtering-Correlation-Id: 11616d4c-c2ee-4a5a-8440-08dc4f6092ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wq1F1/X/tyO4zrgwGikclP0QTylAbeWIbvcQOs5LfP2ZlJhJMSjmpR2qZLJiDyqC6X5mxla7FodelqT8llMO/22uXVfDdUCVuLKkTclFPiDDmYpJRraGyNs0oa0wAAyOjEiVvxdYPSCVttYAtWI6a25jeZq2IuEulvU5BKPfqLTO04XazxoyBm9EO5y3hde6sJYEh5EWum+htUnas74lLQ9lkZ9HKMedSgqWn0Mf/RmxdaMbuHpViUIqO67HEU4+WkMMPpAbBN1Lcj7prSpM/js7LJ3po+X/2eZpkUn7pAsfHNHetdOSWJxdphzP7dGybqPhDdV2m3IoBAIOOkZSZmNlmOvTPrIlAdT5qn9SegXfXfJwW6Cre0owv5sjEplHyfL9TAoVMYtcPiWzRRfJnA58kZMp8ub2DuZYYelRMrGaHKa5Qs55houg4ZJJBAV8SwLK0DM+Qnk+kp6HLilHK1BfR7s24fSrI6EbeloXSdw3ahV12mNwpT/BnIYHQo4+Er8xM3ND574Sb56YmAf6u5NmwaUmUDgmnfr1a+EW3zuETeHZPUVw7IFZsVXqhPfi67wKJgtsrrs3IlEMz/FSe9fOxsdDLOEZwltcj0yQlPLaByqZ5H2dVY+P5Wtp3oM/YpLzSRovs6+WnPgUMzspZVTxYTbD7DNTRpOsaOqSruQ6bwzEuUN9hWPqFnG6XaM6D5M0KSaNa9IQs+FZ848f+GMJgTxDy4aA074GyeTlK+AfZ+4RmueTJyjR+58DBtnJ
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(36860700004)(82310400014)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 19:52:17.5886 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 11616d4c-c2ee-4a5a-8440-08dc4f6092ce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042A9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7182
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

From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

This commit clean up some of the includes used by DCN.

Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dmub_abm_lcd.c             | 4 ----
 drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dio_link_encoder.c | 2 --
 .../gpu/drm/amd/display/dc/dcn30/dcn30_dio_stream_encoder.c   | 2 --
 .../gpu/drm/amd/display/dc/dcn35/dcn35_dio_stream_encoder.h   | 1 -
 drivers/gpu/drm/amd/display/dc/inc/dcn_calcs.h                | 2 +-
 5 files changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dmub_abm_lcd.c b/drivers/gpu/drm/amd/display/dc/dce/dmub_abm_lcd.c
index f9d6a181164a..b851fc65f5b7 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dmub_abm_lcd.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dmub_abm_lcd.c
@@ -34,11 +34,7 @@
 #include "reg_helper.h"
 #include "fixed31_32.h"
 
-#ifdef _WIN32
-#include "atombios.h"
-#else
 #include "atom.h"
-#endif
 
 #define TO_DMUB_ABM(abm)\
 	container_of(abm, struct dce_abm, base)
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dio_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dio_link_encoder.c
index 1fb8fd7afc95..b8e31b5ea114 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dio_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dio_link_encoder.c
@@ -30,8 +30,6 @@
 #include "dcn30_dio_link_encoder.h"
 #include "stream_encoder.h"
 #include "dc_bios_types.h"
-/* #include "dcn3ag/dcn3ag_phy_fw.h" */
-
 #include "gpio_service_interface.h"
 
 #define CTX \
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dio_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dio_stream_encoder.c
index 005dbe099a7a..8ed7125d230d 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dio_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_dio_stream_encoder.c
@@ -30,8 +30,6 @@
 #include "hw_shared.h"
 #include "dc.h"
 #include "core_types.h"
-#include <linux/delay.h>
-
 
 #define DC_LOGGER \
 		enc1->base.ctx->logger
diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dio_stream_encoder.h b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dio_stream_encoder.h
index 499052329ebb..1212fcee38f2 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dio_stream_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dio_stream_encoder.h
@@ -28,7 +28,6 @@
 #include "dcn30/dcn30_vpg.h"
 #include "dcn30/dcn30_afmt.h"
 #include "stream_encoder.h"
-#include "dcn10/dcn10_link_encoder.h"
 #include "dcn20/dcn20_stream_encoder.h"
 
 /* Register bit field name change */
diff --git a/drivers/gpu/drm/amd/display/dc/inc/dcn_calcs.h b/drivers/gpu/drm/amd/display/dc/inc/dcn_calcs.h
index 9e4ddc985240..55529c5f471c 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/dcn_calcs.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/dcn_calcs.h
@@ -31,7 +31,7 @@
 #define __DCN_CALCS_H__
 
 #include "bw_fixed.h"
-#include "../dml/display_mode_lib.h"
+#include "dml/display_mode_lib.h"
 
 
 struct dc;
-- 
2.34.1

