Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FB3CC5DF6E
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2026 21:04:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CEDC10F73F;
	Fri, 14 Aug 2026 21:04:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="U62SQ2QH";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012049.outbound.protection.outlook.com [52.101.53.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 372DB10F72E
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2026 21:04:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I9RE0q7yg4VK+lK1k4oMhpQnvkmiTb59HFuiOFprdKOVPnN9hsczrzJT+xiTfte4TMVdMnukdEEsGWFzs3a08IdaUG0Iw+0+Io9idNrXcGZLpd/U0Yn5IpfNDlBiLBiE7GnQAbVbp/oN+AhCFVBcMLY8EahL1rsX+GHDCwQ/PaosLHz0U+Xdj5Vm/P6B8jY+nLYsVJVuXn6oDwNS+Pm73fyGTkzrGd4C/zJYMY8KY+GYA0Js02l7V0bXpN5yFlsi4sDaTXlVkNwwHQ7WGA/8kXSxo/9fyTMn59ZNbJ7HgWAXTius9L5yeUXGji7ZxcxqC8F1Fgn2PZmZNg0CDAxDcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+p0NOxdCsQu0L0y4MEUoAKqnEfvXSsUKkCk8EuXYUWg=;
 b=pESzawFwHn/eW4OQvIFYkf80mXcSeD6Y5Ec3dV9lRHS3r6hefSt7s4aD5J08nb02Kif17vf9pM0b1jg3gpNE7/iNJp67wBbETXyKmywVKYpdH9Bnw5Xu4OBXaRzpBs7ftwxXz0N18IAx9qvFetWJRQ+5Zcr+Lu/ZBFiqbdXyFiK2sV4V+bjwsjotbCJ0hn1EaHQtTT7VmYA4IMHycW5alqrlP4Mkh71rAwaSkowvI2wK9BiNmTtKKArQBT+VRMv02L2E8gH+OoHCeyOPpnJsA5GAf8sE4ewBZ7BpbPXiHzsd72uNy/rGVgv3rIfIpmKuWnhW/mzQv1ih+ZeapwvlhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+p0NOxdCsQu0L0y4MEUoAKqnEfvXSsUKkCk8EuXYUWg=;
 b=U62SQ2QHzzjzQr/WIBthTRWWgox56Hw5KWyzR26O5D7VJM7hZC70c8wfXDLo1RCP3/GIaTYsW2NbYyLWBztMUnyyiAWnjNqb9Joj/wlF8QPqz164rA6aNJeu8U2nZpYM042w+S9r7q+Tv4E75odbSd7j5fmtwJTUAbre3mhdipc=
Received: from BN9PR03CA0503.namprd03.prod.outlook.com (2603:10b6:408:130::28)
 by SN7PR12MB7276.namprd12.prod.outlook.com (2603:10b6:806:2af::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Fri, 14 Aug
 2026 21:03:56 +0000
Received: from BN2PEPF000044A1.namprd02.prod.outlook.com
 (2603:10b6:408:130:cafe::30) by BN9PR03CA0503.outlook.office365.com
 (2603:10b6:408:130::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.15 via Frontend Transport; Fri,
 14 Aug 2026 21:03:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF000044A1.mail.protection.outlook.com (10.167.243.152) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Fri, 14 Aug 2026 21:03:56 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 16:03:54 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 14 Aug 2026 16:03:53 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: YiPeng Chai <YiPeng.Chai@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 094/109] drm/amd/ras: populate cper aca register info for rma
 device
Date: Fri, 14 Aug 2026 17:02:31 -0400
Message-ID: <20260814210246.3067612-95-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814210246.3067612-1-alexander.deucher@amd.com>
References: <20260814210246.3067612-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A1:EE_|SN7PR12MB7276:EE_
X-MS-Office365-Filtering-Correlation-Id: e3a9e014-45e5-48ad-d588-08defa478e1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|82310400026|36860700016|22082099003|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: s0VuuB8eCe7OtuR2VkUjEf1e5bdf/UnodVNJkYjmv5dHEua/14JhdBOW/WKtR13VM3Z/9k3WG7P5PASy0amMy17+xqmSIcaFtUCpeCHqj9JtI5Yx9aTJvY7aCTV0b2bGXcT7PCn+DBPTiE53wBunPXbWp44SFDRAqEtCugDFysQ0xExpViNhOR/+lH8iZjE1g2hnY6j5/isWx9eIMecIpfvvbGDKa2BGeudAOMUaIK5Pw+e8oRGyhu8Ll/vz5xKOCrgXQIqhe7/MB4hoN+mep3L3DIK+au2R/aAj3b/Wk/Nyi28RXjHmVbhelhFHK2S2JFBF7VhwcwpkQGmG8QGfyVuBBgH3js3JlyKMWhmDA5AQ0nAwBGKlCPAoT7hwhWj2jhHcd0dXjb1H+b4FbEBQFgR8cuqL6CGEzmFeM8kmANLK8VgmKV5hyYsP18tSWjmEvQH3OVCxihm5+cGytNe8phyHkCm5t3ipILndiOMi2AcGWHMZmOgjnT3GO02xUfcFKhYWtmVh8D0HJO2cigZsEYS+wiNtE5fCcQA1XfaBrRn3yNAVRIuvvNO9ISp1NyOcNu5zh9Bpq7ddYrlFydqkxiiE2mevN6tzAPV3kftAFiyioItdXiBD6D6mMOnoitjCGQ6rGXOxZyxttMsO1kWnsaFqPXcm/zl2JJmZfGcIkqnJguHDpFipEhlrSuhPwFWsz6z3PrZSOgdzO6Rs+MAR1g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(82310400026)(36860700016)(22082099003)(18002099003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: nYs/0fZgqdWWSjNG88l6hifuLztl6LCZ8T+Vomm5+sU0f9BlV2mBh4DgtUhqRc/R/GxGsxH8UkmVzMJmZj5/BY/1cAVudrJK9EWYzvnXzE/8AXuIgRt8JSOvEF/ck1XTYtGa4yUTvYY25BLhY8Ecg3AjcPr9UVDPdtJoMOz/Oc6HROTRno3E9Yc3fiTvFUpGGy3XfTQOvOPU/tiFvCdIKxi/EUAooS7Iq6/9KlrLaKlXX+isrrjvECu9PILaUSMuxN0e90QGbu9eFGod+rlbeJxTxtpCuhvQWWjXVdSweB/PZ3Rl1j4rEgjI2UDQxgB2I4MzoAVeulWO676/r98toEqgGn9hji44M9xbj7+RqXoyV+xuEAs00jyMCgrPVthfkLfV1IdHltteCxnRkLJgvlUiYGXhM1qct4Ims9axmmcCuYYPUHl4G1hWJWSCKJWQ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 21:03:56.6559 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3a9e014-45e5-48ad-d588-08defa478e1a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7276
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

Populate cper aca register info for rma device.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/ras/core/aca.c          | 14 ++++++++++
 drivers/gpu/drm/amd/ras/core/aca.h          |  2 ++
 drivers/gpu/drm/amd/ras/core/aca_v1_0.c     | 26 ++++++++++++++++++
 drivers/gpu/drm/amd/ras/core/log_ring.c     | 30 ++++++++-------------
 drivers/gpu/drm/amd/ras/core/ras_aca_v5_0.c | 22 +++++++++++++++
 5 files changed, 75 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/ras/core/aca.c b/drivers/gpu/drm/amd/ras/core/aca.c
index 60a435ae92c9a..0f5e57965ac86 100644
--- a/drivers/gpu/drm/amd/ras/core/aca.c
+++ b/drivers/gpu/drm/amd/ras/core/aca.c
@@ -691,3 +691,17 @@ u64 ras_aca_get_parser_caps(struct ras_core_context *ras_core)
 
 	return 0;
 }
+
+int ras_aca_fill_rma_bank(struct ras_core_context *ras_core,
+			struct aca_bank_reg *bank)
+{
+	struct ras_aca *ras_aca = &ras_core->ras_aca;
+
+	if (!bank)
+		return -EINVAL;
+
+	if (ras_aca->ip_func && ras_aca->ip_func->fill_rma_bank)
+		return ras_aca->ip_func->fill_rma_bank(ras_core, bank);
+
+	return -EOPNOTSUPP;
+}
diff --git a/drivers/gpu/drm/amd/ras/core/aca.h b/drivers/gpu/drm/amd/ras/core/aca.h
index 518351fe187aa..52acf19fac11a 100644
--- a/drivers/gpu/drm/amd/ras/core/aca.h
+++ b/drivers/gpu/drm/amd/ras/core/aca.h
@@ -145,6 +145,7 @@ struct ras_aca_ip_func {
 	uint32_t block_num;
 	const struct aca_block_info **block_info;
 	u64 (*aca_parse_ras_caps)(struct ras_core_context *ras_core);
+	int (*fill_rma_bank)(struct ras_core_context *ras_core, struct aca_bank_reg *bank);
 };
 
 struct ras_aca {
@@ -170,4 +171,5 @@ int ras_aca_parse_bank(struct ras_core_context *ras_core,
 				struct aca_bank_reg *bank,
 				struct aca_bank_ecc *ecc);
 u64 ras_aca_get_parser_caps(struct ras_core_context *ras_core);
+int ras_aca_fill_rma_bank(struct ras_core_context *ras_core, struct aca_bank_reg *bank);
 #endif
diff --git a/drivers/gpu/drm/amd/ras/core/aca_v1_0.c b/drivers/gpu/drm/amd/ras/core/aca_v1_0.c
index 1f0ad3e502da1..a4145f30f45f3 100644
--- a/drivers/gpu/drm/amd/ras/core/aca_v1_0.c
+++ b/drivers/gpu/drm/amd/ras/core/aca_v1_0.c
@@ -384,8 +384,34 @@ static u64 aca_parse_ras_caps_v1_0(struct ras_core_context *ras_core)
 	return parser_supported_mask;
 }
 
+static int aca_fill_rma_bank_v1_0(struct ras_core_context *ras_core, struct aca_bank_reg *bank)
+{
+	struct device_system_info dev_info = {0};
+	u64 socket_id;
+	int ret;
+
+	if (!bank)
+		return -EINVAL;
+
+	ret = ras_core_get_device_system_info(ras_core, &dev_info);
+	if (ret)
+		return ret;
+
+	socket_id = dev_info.socket_id;
+
+	memset(bank->regs, 0, sizeof(bank->regs));
+	bank->regs[ACA_REG_IDX__CTL]    = 0x1ULL;
+	bank->regs[ACA_REG_IDX__STATUS] = 0xB000000000000137ULL;
+	bank->regs[ACA_REG_IDX__CONFG]  = 0x1ff00000002ULL;
+	bank->regs[ACA_REG_IDX__IPID]   = 0x9600000000ULL |
+		((socket_id / 4) & 0x01) | (((socket_id % 4) & 0x3) << 44);
+
+	return 0;
+}
+
 const struct ras_aca_ip_func ras_aca_func_v1_0 = {
 	.block_num = ARRAY_SIZE(aca_block_info_v1_0),
 	.block_info = aca_block_info_v1_0,
 	.aca_parse_ras_caps = aca_parse_ras_caps_v1_0,
+	.fill_rma_bank = aca_fill_rma_bank_v1_0,
 };
diff --git a/drivers/gpu/drm/amd/ras/core/log_ring.c b/drivers/gpu/drm/amd/ras/core/log_ring.c
index fb42449fbd6c4..e57f7ea3f3079 100644
--- a/drivers/gpu/drm/amd/ras/core/log_ring.c
+++ b/drivers/gpu/drm/amd/ras/core/log_ring.c
@@ -32,16 +32,6 @@
 
 #define BATCH_IDX_TO_TREE_IDX(batch_idx, sn) (((batch_idx) << 8) | (sn))
 
-static const uint64_t ras_rma_aca_reg[ACA_REG_MAX_COUNT] = {
-	[ACA_REG_IDX__CTL]    = 0x1,
-	[ACA_REG_IDX__STATUS] = 0xB000000000000137,
-	[ACA_REG_IDX__ADDR]   = 0x0,
-	[ACA_REG_IDX__MISC0]  = 0x0,
-	[ACA_REG_IDX__CONFG] = 0x1ff00000002,
-	[ACA_REG_IDX__IPID]   = 0x9600000000,
-	[ACA_REG_IDX__SYND]   = 0x0,
-};
-
 static uint64_t ras_log_ring_get_logged_ecc_count(struct ras_core_context *ras_core)
 {
 	struct ras_log_ring *log_ring = &ras_core->ras_log_ring;
@@ -227,9 +217,8 @@ int ras_log_ring_add_log_event(struct ras_core_context *ras_core,
 		void *data, uint32_t size, struct ras_log_batch_tag *batch_tag)
 {
 	struct ras_log_ring *log_ring = &ras_core->ras_log_ring;
-	struct device_system_info dev_info = {0};
 	struct ras_log_info *log;
-	uint64_t socket_id;
+	struct aca_bank_reg *rma_bank;
 	void *obj;
 
 	if (size > sizeof(union ras_log_body)) {
@@ -263,13 +252,16 @@ int ras_log_ring_add_log_event(struct ras_core_context *ras_core,
 		log->size = size;
 	}
 
-	if (event == RAS_LOG_EVENT_RMA) {
-		memcpy(&log->body.aca_reg, ras_rma_aca_reg, sizeof(log->body.aca_reg));
-		ras_core_get_device_system_info(ras_core, &dev_info);
-		socket_id = dev_info.socket_id;
-		log->body.aca_reg.regs[ACA_REG_IDX__IPID] |= ((socket_id / 4) & 0x01);
-		log->body.aca_reg.regs[ACA_REG_IDX__IPID] |= (((socket_id % 4) & 0x3) << 44);
-		log->size = sizeof(log->body.aca_reg);
+	if ((event == RAS_LOG_EVENT_RMA) && !data && !size) {
+		rma_bank = kzalloc_obj(*rma_bank);
+		if (rma_bank && !ras_aca_fill_rma_bank(ras_core, rma_bank)) {
+			memcpy(log->body.aca_reg.regs,
+				rma_bank->regs, sizeof(log->body.aca_reg.regs));
+			log->size = sizeof(log->body.aca_reg);
+		} else {
+			RAS_DEV_WARN(ras_core->dev, "Failed to fill rma bank info!\n");
+		}
+		kfree(rma_bank);
 	}
 
 	return ras_log_ring_add_data(ras_core, log, batch_tag);
diff --git a/drivers/gpu/drm/amd/ras/core/ras_aca_v5_0.c b/drivers/gpu/drm/amd/ras/core/ras_aca_v5_0.c
index 52036ca7a39af..e35f96c3ac350 100644
--- a/drivers/gpu/drm/amd/ras/core/ras_aca_v5_0.c
+++ b/drivers/gpu/drm/amd/ras/core/ras_aca_v5_0.c
@@ -348,8 +348,30 @@ static u64 aca_parse_ras_caps_v5_0(struct ras_core_context *ras_core)
 	return parser_supported_mask;
 }
 
+static int aca_fill_rma_bank_v5_0(struct ras_core_context *ras_core, struct aca_bank_reg *bank)
+{
+	struct device_system_info dev_info = {0};
+	int ret;
+
+	if (!bank)
+		return -EINVAL;
+
+	ret = ras_core_get_device_system_info(ras_core, &dev_info);
+	if (ret)
+		return ret;
+
+	memset(bank->regs, 0, sizeof(bank->regs));
+	bank->regs[ACA_REG_IDX__CTL]    = 0x1ULL;
+	bank->regs[ACA_REG_IDX__STATUS] = 0xB000000000000137ULL;
+	bank->regs[ACA_REG_IDX__CONFG]  = 0x1ff00000002ULL;
+	bank->regs[ACA_REG_IDX__IPID]   = 0x9600000000ULL | (dev_info.socket_id & 0xFF);
+
+	return 0;
+}
+
 const struct ras_aca_ip_func ras_aca_func_v5_0 = {
 	.block_num = ARRAY_SIZE(aca_block_info_v5_0),
 	.block_info = aca_block_info_v5_0,
 	.aca_parse_ras_caps = aca_parse_ras_caps_v5_0,
+	.fill_rma_bank = aca_fill_rma_bank_v5_0,
 };
-- 
2.55.0

