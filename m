Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ED5DC5CFCF
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2026 21:03:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FBD810E5CC;
	Fri, 14 Aug 2026 21:03:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PnzC2GFW";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010016.outbound.protection.outlook.com [52.101.61.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3611810E5CB
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2026 21:03:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z12T1HBHkhyLt95gP490jzP+GBCDBVgzLAOZCZD2TVgGUA967EEZmQWEJ1A6bfYL9QPamADOY936pPnTGbhIBjwDi7Qi4JMWaql3CZPGl2fHoWFYDUXTeJSJmof/Rg6rqROgtNcQHA0azm3J+vrIkiP+eiRD6OaLMZXd6DXFjE3R3PSH2huVLuQhwEuWcOW+9GszBvq9xuDUDdEq511juFxXQ/pEkqH9qEtwSruviswX1Quz3ad60UC5rAPh3pQDWyoxV8FuvF/KF3NQks3aVNiIhi6Bm6cuyM8cTivL1f4S9VZ63theblxl6ongpaNzk/Gpt0WyVzqQz6+/RYJSnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gvAUplVjUhyX85uF16oSOtXnYr3oB+wHOD3WhJon/CQ=;
 b=VCAmiS9oDo2vn8B83ztBbqa9+hJUGrnVOKAjTCNcKC0+hbEb0UM3jCl9rSYQZMOvKW3uMzl8Tcpd8g0zUjkFS/6BzOfO8Xag8oE2jvOCjzk8jOLp2OtllCJbRX3LLDaqhm98q72b626IBdzJRSi5jXF/esbNxVM9SeTMDZZMUx8GgWiqxXqI7/OZfFgDY9fyvVKzcyy7iVarvay7XAM41/bR0qrrISZvQ+bPjqDBEC8kxahER/SdrVYQZsRNdhoDTwors/6zuQYlcS+O2UO5Ije3PPYYTtPulXCL+opbaZHiTNX57+E2XRQ8mSaueMbJOkchvrPgNNJMcVs+ldCxvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gvAUplVjUhyX85uF16oSOtXnYr3oB+wHOD3WhJon/CQ=;
 b=PnzC2GFW3L255k0D3puKO8QMsszxjyMWckWK8gTJ6KjxCyEg1qUZ0soshCUgWcx6aUlIv0Q91tmgTVrjFm29co5TsWgII89+jV5KsROatpnw+neSIZxi5ISNBrGbtKbur+z4OdbQ6qO21d8IVvDpA0mX4KcogbxMeHK23ld9hm8=
Received: from SA9PR13CA0075.namprd13.prod.outlook.com (2603:10b6:806:23::20)
 by MW6PR12MB8997.namprd12.prod.outlook.com (2603:10b6:303:23e::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.16; Fri, 14 Aug
 2026 21:03:02 +0000
Received: from SA2PEPF00001504.namprd04.prod.outlook.com
 (2603:10b6:806:23:cafe::8b) by SA9PR13CA0075.outlook.office365.com
 (2603:10b6:806:23::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.6 via Frontend Transport; Fri, 14
 Aug 2026 21:03:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SA2PEPF00001504.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Fri, 14 Aug 2026 21:03:02 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:03:00 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:03:00 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 14 Aug 2026 16:02:59 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: YiPeng Chai <YiPeng.Chai@amd.com>, Xiang Liu <xiang.liu@amd.com>, "Hawking
 Zhang" <Hawking.Zhang@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 005/109] drm/amd/ras: Parse error type of MCE and encode CPER
Date: Fri, 14 Aug 2026 17:01:02 -0400
Message-ID: <20260814210246.3067612-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814210246.3067612-1-alexander.deucher@amd.com>
References: <20260814210246.3067612-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001504:EE_|MW6PR12MB8997:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cd7115d-43ae-44e9-d5bb-08defa476dbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|23010399003|3023799007|56012099006|10067099003|22082099003|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: hSZdxwl6MjueXe+9qwx3G6bf/ywepoYR2LZkGeJpgw2fS6CDW7sqkImalX/ic9SakqBAoQw4pw6vAWOCPYMEZ1CYin6K2YRtbJ2IWLuhmaQaLr/C7m3z0OXhsuWrWIeGn2SyN6Utjo2IgqRpNMAiabMGCzcp6/GH8PmGGNIUDwh/W79epq6rO+aMxnC221M260tEXtnQpp+TUZA5mPu9fMbqLKoPCx0lyag2BYjLHJn7jRk2GrIH8L0inm1NaSCVchtK6aRSqEu9UFmPc6PnjpeBGxhBo9FM4oj1d4Ra2dN9WuN/0UaNCjKA8WuDZj4C6yx9G/n7UzQdpnzyvwgzL0haQ0ug2g9GyefWgmJS3KsinDg7yxjUYVPqohueyJtiUyaxls6JWt+F7G71FeAC16tMk8X9tmEZuIa0WVUiMBLlFHzLaRNnLgLeWmfbffb0ynr4phspQXnyrwVVWMdL9YSyWKWnOu7Icoq0MnFtAoPL1KTiFzit1m7MEV33GvyrCQ14sPse5vfKDM4cTvn2CfgeuJ5Kin03k3ao/kGnVKYHQB8DqZkdxJVe/bNyHu5QKjZtOxrXj0yTUINuazyQHDz5ZsuTuExsk2sZ1vYLV7IrCswiONNGc4iV90ijk32TqrY3MN8Qu5/sbSwbAV7BttsZBGX4Cl2dAW+qNbMoDsni8RWgUL4/oXi+ep6rP1xT0uyDZTjtdSwvAmWBe6gl9Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(23010399003)(3023799007)(56012099006)(10067099003)(22082099003)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: uFeSRkXLhBfMWmMFUbtc8+8OLfgTpe94DZkkfyDZ8uwFbo4sR7t+xfHgGkwpqlwa/ZxCuVgWY/7OkfVvJbNmKspRMGMTNYH813kNv5J4nO3dPDDkPWH/qgszSs3i8LzMVgoxDWK97ODk4HV1nQWfsLUXrQg5Tf+IVo9qWZ/B7vncrOwXgU0/TRzRK87qkK8so17xItpANP4322AyzpGqQJs7Gnd0RIVrfo4XBw/vXxVwJ5l8EghHivCemYwePme9cRUNshewDxv3lx0vRXsiOMz3qlbwGRNG7S7zhlZ0od2gDh9qJC6/akiWQn7yPHY82M8gPk7jEHhjpqNJcA/g2wDQ1BaBn1WpGCv/xX8GZfkFTkVHkYscbJm/ii/JsTB4Ly3rSluhy5yvxZaXCMQ5mlS2fT9B04jxYZS9XaGm6N0tmnKTfe4J3hcOSQK0CB1r
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 21:03:02.3162 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cd7115d-43ae-44e9-d5bb-08defa476dbb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001504.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8997
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

Introduce MCE type ras log event.
Parse error type of MCE and encode to corresponding CPER.

Signed-off-by: Xiang Liu <xiang.liu@amd.com>
Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/ras/core/log_ring.h |  1 +
 drivers/gpu/drm/amd/ras/core/ras_cper.c | 28 +++++++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/drivers/gpu/drm/amd/ras/core/log_ring.h b/drivers/gpu/drm/amd/ras/core/log_ring.h
index a1ef2f24130c0..13973add0e5cb 100644
--- a/drivers/gpu/drm/amd/ras/core/log_ring.h
+++ b/drivers/gpu/drm/amd/ras/core/log_ring.h
@@ -37,6 +37,7 @@ enum ras_log_event {
 	RAS_LOG_EVENT_POISON_CREATION,
 	RAS_LOG_EVENT_POISON_CONSUMPTION,
 	RAS_LOG_EVENT_RMA,
+	RAS_LOG_EVENT_MCE,
 	RAS_LOG_EVENT_COUNT_MAX,
 };
 
diff --git a/drivers/gpu/drm/amd/ras/core/ras_cper.c b/drivers/gpu/drm/amd/ras/core/ras_cper.c
index dd95e6891bcf2..fb37c7cc29142 100644
--- a/drivers/gpu/drm/amd/ras/core/ras_cper.c
+++ b/drivers/gpu/drm/amd/ras/core/ras_cper.c
@@ -270,6 +270,26 @@ static enum ras_cper_type cper_ras_log_event_to_cper_type(enum ras_log_event eve
 	}
 }
 
+static enum ras_log_event cper_mce_parse_err_type(struct ras_core_context *ras_core,
+						  struct aca_bank_reg *bank)
+{
+	struct aca_bank_ecc bank_err = {0};
+
+	if (ras_aca_parse_bank(ras_core, bank, &bank_err))
+		return RAS_LOG_EVENT_NONE;
+
+	if (bank_err.ue_count)
+		return RAS_LOG_EVENT_UE;
+
+	if (bank_err.ce_count)
+		return RAS_LOG_EVENT_CE;
+
+	if (bank_err.de_count)
+		return RAS_LOG_EVENT_DE;
+
+	return RAS_LOG_EVENT_NONE;
+}
+
 int ras_cper_generate_cper(struct ras_core_context *ras_core,
 		struct ras_log_info *trace_list, uint32_t count,
 		uint8_t *buf, uint32_t buf_len, uint32_t *real_data_len)
@@ -279,6 +299,14 @@ int ras_cper_generate_cper(struct ras_core_context *ras_core,
 	int record_size, saved_size = 0;
 	struct cper_section_hdr *hdr;
 
+	if (trace_list[0].event == RAS_LOG_EVENT_MCE) {
+		struct aca_bank_reg bank = { 0 };
+
+		/* MCE is encoded as 1 record each */
+		memcpy(&bank.regs, &trace_list[0].aca_reg.regs, sizeof(bank.regs));
+		trace_list[0].event = cper_mce_parse_err_type(ras_core, &bank);
+	}
+
 	/* All the batch traces share the same event */
 	record_size = cper_get_record_size(
 			cper_ras_log_event_to_cper_type(trace_list[0].event), count);
-- 
2.55.0

