Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 377BBC5DF6A
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2026 21:03:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04F4010EF7B;
	Fri, 14 Aug 2026 21:03:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3yAahCkZ";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010005.outbound.protection.outlook.com
 [52.101.193.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1EFDF10F6C6
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2026 21:03:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UnoEUFJ1uGnO0w753hbue0fdzjzYOLlHzEVmWh7ZeFMTZdyUxK1KAFEusqX/kA/+onWTeVfyaUPMX38cBjcX7HA6e1r55lWWmbXq7GFEi1dtmrQmtNVbHCtDLCZ7GDy6DXQ3gltsPW+s6njC2fCJ7UiDGY+ZHFq6waK4waqRDKzNhyRUdZyp50ag/Q0hUm+RS/sm7NjiUuncsPxGcfEM6N4U5rQ5BNiAlb5Yra+eGUqyWx8RO7zxG3rvYJrQPyZOD1IuuzUK2nKB9TgVjZSjq98ipuGipzShphdjONssnhdDlEcSXNbM5S9U6jx+2nlmqCYp09VjYnKnWoSVIM0Sgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KdXm9AS8R/IWfkEZ+oL7HnOaHQJpGCFGE4D0rLxiyU0=;
 b=juhSz6WbeeWiWN6+VAOPfq7KO3HL77+zpva2lJ5xglnjHN9DasP4zpMHo/EvGkjr/AjBvRdPIc0NNa/cK/qGazCwiqQyTY0eW8I+zg4AVN03FR9pbpkq2IAChIdHx2PZ9Brwruryc4s87epDUdtDFYxrw2XMrIw2qpV6+LS+ki+wq02R9UEl2kda4SuNiftjuyQdeHCMZZZRKzT8tuViX6B/JcO1QtbD9yL4x/mEXgz1bYr56H42MYgRhqC3dVgbZpA87V3CoYLjPlr9xmEIf+DtWpzF3x/fPOyZnz8Q049TOO6AiOYtSWXY5x+zmoNgu1LRUhiO9Pqn8p1W4RVVaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KdXm9AS8R/IWfkEZ+oL7HnOaHQJpGCFGE4D0rLxiyU0=;
 b=3yAahCkZl69ELe8ES/xljE3K5c74BZF414PG/XqTXizMVZbwZScwD2TjNB1VHbujraz5YCmPFNOQ9Oi4ZJF9A8SYyqLX1vISbcsyZMs3PwZ4cgUWOj3kHpuFRDz8Zqy2ne6QQPGtJPcrzRNwuxcsVnPwe42D3DA4oHER/Bu9S8w=
Received: from SA9PR13CA0082.namprd13.prod.outlook.com (2603:10b6:806:23::27)
 by BL4PR12MB9533.namprd12.prod.outlook.com (2603:10b6:208:58f::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Fri, 14 Aug
 2026 21:03:03 +0000
Received: from SA2PEPF00001504.namprd04.prod.outlook.com
 (2603:10b6:806:23:cafe::a1) by SA9PR13CA0082.outlook.office365.com
 (2603:10b6:806:23::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.6 via Frontend Transport; Fri, 14
 Aug 2026 21:03:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SA2PEPF00001504.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Fri, 14 Aug 2026 21:03:03 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:03:01 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 14 Aug 2026 16:03:01 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: YiPeng Chai <YiPeng.Chai@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 007/109] drm/amd/ras: Add interface to get ras eeprom table
 version
Date: Fri, 14 Aug 2026 17:01:04 -0400
Message-ID: <20260814210246.3067612-8-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814210246.3067612-1-alexander.deucher@amd.com>
References: <20260814210246.3067612-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001504:EE_|BL4PR12MB9533:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a690444-81f2-46b5-503e-08defa476e3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|23010399003|376014|22082099003|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: m8bkEmxa0nhpOXcnwCI88A2PaDaMN2+jstQcBs826ASOiwFO/FlY7CjdLeXl3DsP7JZpQDgTLnwNOpH00K4bg9qbNAZViv0YlasdXwnlxLmJ0+VAd2I4Z4URBwdfIOVuf/1/OMIRCuhrQ1ybH/zwDbBQ4k6QDPewuOMWz6dicYDZsPEVQkzUlCJtfNxEk/C1vChW61nN987w+Lz2H2Hz1GUnF26mdY4WZyJ0RpiCEJKU99voNN9fMEFU/8SeHB/UndD6ta0eWx7BOSDACHrzTb1JWnBPR2+GLINi2DzyBk6w22kSZAl2madf8gq3Ur66y5slq3SRmlbFgHc1HI4uKeznQfKYeiMkznx6AKPixj0pXaK8YIzVHtP9Ek6FtofB8YEwKA4tIVzCYO8PDak4C5vPnvhr0T5JMynrg78K2EDgHljJ5Slm+kspdnnKtV9BYiIGoX90LaYl0/nUKJ51aO2r7rjJhM0J/uSAPYT+I2Yy95OasIPTyHqov4d5W2wp2Uv26XwGLry1FLoMLt6gW4O+sr3ULXHx0ZYrdN6Mz1k1gnjoNARs/vAX/Vpo16QRsXDxec5TLBHdk9tlHbrxQa94nvLIt2quTkjpXSLmMS79llEeK4ABo8AafzQVRL3LVnBbLMoMYpqDKw53vrByeyQI/G3xZjPP8u8ftUPwY1hfpobAfQzOauX/oo63b6e8VwjlgRHrzw29z1G9uI+q7Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(23010399003)(376014)(22082099003)(18002099003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: AlS7IsaAjpS5OptubgfbAH9QmxGyup6DhpcH5aPuuWKo5ZBcM9Ka8uho5EVC613/gJqH2BoMg9SbIT4twTAEN5W4QcVRfNRNTqNipz/ENHivAWC7dfR5F9alHLGuz2aeQe+J44X0id4arOUiIsFmDaUOx0FiEaKRVIjjCihiEIl5NXlmpSQJHshVVQmez+Vr5DeCIOhuZ9lgmeSTYZ53UsqYX0/Fo/LBwT0Hu1o5ie+2hYewWoUWQ2QLxhPa/JM/kOFM3gqFJYNHbIy4fmMs/nhnfhS9Sr7ieyX1OnjlcHQ8pjCsyQUV4I6eUZBqPHwEP1d0iIPK+wNjaW+IWdw6i2qyTOzhSzd/BM5N8Lz5zwM25MKZaR+zpfY5mg6NvnJHBZYQjUrQoYT6GdIIweQQixWDFh5mDDawFinW4rRSPss82Cz0IIfphJUdi6ZJWjZd
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 21:03:03.1573 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a690444-81f2-46b5-503e-08defa476e3b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001504.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9533
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

From: YiPeng Chai <YiPeng.Chai@amd.com>

Add interface to get ras eeprom table version.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/ras/core/core.c   |  6 ++++++
 drivers/gpu/drm/amd/ras/core/eeprom.c | 10 ++++++++++
 drivers/gpu/drm/amd/ras/core/eeprom.h |  3 +++
 drivers/gpu/drm/amd/ras/core/ras.h    |  2 ++
 4 files changed, 21 insertions(+)

diff --git a/drivers/gpu/drm/amd/ras/core/core.c b/drivers/gpu/drm/amd/ras/core/core.c
index 0e19cf41bc26f..3a56abce59dbb 100644
--- a/drivers/gpu/drm/amd/ras/core/core.c
+++ b/drivers/gpu/drm/amd/ras/core/core.c
@@ -714,3 +714,9 @@ int ras_core_check_address_sanity(struct ras_core_context *ras_core,
 
 	return 0;
 }
+
+int ras_core_get_eeprom_version(struct ras_core_context *ras_core,
+	uint32_t *version)
+{
+	return ras_eeprom_get_version(ras_core, version);
+}
diff --git a/drivers/gpu/drm/amd/ras/core/eeprom.c b/drivers/gpu/drm/amd/ras/core/eeprom.c
index 7afaac81f37a1..1bc409048e732 100644
--- a/drivers/gpu/drm/amd/ras/core/eeprom.c
+++ b/drivers/gpu/drm/amd/ras/core/eeprom.c
@@ -1368,3 +1368,13 @@ enum ras_gpu_health_status
 
 	return rai->rma_status;
 }
+
+int ras_eeprom_get_version(struct ras_core_context *ras_core, uint32_t *version)
+{
+	if (!ras_core || !version)
+		return -EINVAL;
+
+	*version = ras_core->ras_eeprom.tbl_hdr.version;
+
+	return 0;
+}
diff --git a/drivers/gpu/drm/amd/ras/core/eeprom.h b/drivers/gpu/drm/amd/ras/core/eeprom.h
index 32bd1526bc55b..c46ce23ea6ee6 100644
--- a/drivers/gpu/drm/amd/ras/core/eeprom.h
+++ b/drivers/gpu/drm/amd/ras/core/eeprom.h
@@ -187,4 +187,7 @@ void ras_eeprom_sync_info(struct ras_core_context *ras_core);
 int ras_eeprom_check_storage_status(struct ras_core_context *ras_core);
 enum ras_gpu_health_status
 	ras_eeprom_check_gpu_status(struct ras_core_context *ras_core);
+
+int ras_eeprom_get_version(struct ras_core_context *ras_core,
+	uint32_t *version);
 #endif
diff --git a/drivers/gpu/drm/amd/ras/core/ras.h b/drivers/gpu/drm/amd/ras/core/ras.h
index ee1b19948830b..43e028189087b 100644
--- a/drivers/gpu/drm/amd/ras/core/ras.h
+++ b/drivers/gpu/drm/amd/ras/core/ras.h
@@ -409,4 +409,6 @@ int ras_core_check_address_sanity(struct ras_core_context *ras_core, uint64_t ad
 
 int ras_core_set_debug_mode(struct ras_core_context *ras_core, bool enable);
 bool ras_core_is_ce_log_disabled(struct ras_core_context *ras_core);
+int ras_core_get_eeprom_version(struct ras_core_context *ras_core,
+	uint32_t *version);
 #endif
-- 
2.55.0

