Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D09ACD8C85
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Jun 2026 06:51:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C7D710E0F4;
	Tue,  9 Jun 2026 06:51:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qcRSfcWZ";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010044.outbound.protection.outlook.com
 [40.93.198.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 530C510E0F2
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 Jun 2026 06:51:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y/6Cyln8D0HpkAtSgJKeTN/Ryna8NC3gQG2U/sUsknt47tUxnVzr4qTuay38SboXRO6MSXdKb4lGPpXh9JD4XhdGNJti+PvPg6KMSmft7Wtmv4QJ5ZC5gka7o6QgYBxGIM84Ea/Xp+5IvbG9FEImUZdcJNgT/hS8C8AHzy1JbdIsD4dVEma/P2v+fXL+kJg5y4cHLlNeUJtIbru/JrsGwWPPMbYM6Ul/st8oxfmvJ3P7hkmaUofOF1i7GgFkfgZ5Umb5Dht3bBe0eBX0GFH3dpfG/h1uzNd3OoRdnQD3QXALqQjVSYw1MEjdCAyjD3hWUCpEpUptp5YyDzF4FdkYiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U+RXqgwJVPW9VFNQDMDR+BTKZJf9X5TqQ4+NG8tLadY=;
 b=zEkwPG5F+Hj9xtB0R16RXhiV5GL6yKsOHKBNAkIRRmJpxh1G9SdHwvDNWmVPGDF0O5CK+M3ckOsxCKVUPbMf9KVv8ehiEdR8v1IvCwZY2LLHNfVq90Lec6pr4bif8QEcEGBQ54FJysnjELUr+1poIkH9ahcRUaIBmaPqlTQyocwoat4FUaFuQHoRAyWYXw5T1LM/aLIzfeGkufRV4NEtQ87KBC9BSvkY04Ah2vYB4FEy2SMyXMGu1bU/5lrTR93m88tWtDHppSBXsyzjFW8ExYGagGDy202AkSc3w7eXLtoVehbr7X7pPsgnZon2QxLprpJDYSAykCaJMPnKF65i0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U+RXqgwJVPW9VFNQDMDR+BTKZJf9X5TqQ4+NG8tLadY=;
 b=qcRSfcWZQCLXoT7jRkxRUbXtbq4YTZsTfcgK+/3i43/uqk10BGFR2LRoSOJLgrPuNbw8QzIAj+5f14LYb5Qotu4JOehFHI9+bwLZugQzxTGHZLoPNxTmPOehbUxD2ik52WKmSJNsT0qsCy964p0wac/lK1ajxgdhJGnjUABk3b8=
Received: from MN0P223CA0005.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:52b::22)
 by CY5PR12MB6600.namprd12.prod.outlook.com (2603:10b6:930:40::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Tue, 9 Jun 2026
 06:51:41 +0000
Received: from BL02EPF0001A107.namprd05.prod.outlook.com
 (2603:10b6:208:52b:cafe::a3) by MN0P223CA0005.outlook.office365.com
 (2603:10b6:208:52b::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.14 via Frontend Transport; Tue, 9
 Jun 2026 06:51:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A107.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Tue, 9 Jun 2026 06:51:40 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 9 Jun
 2026 01:51:39 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <hawking.zhang@amd.com>,
 <kenneth.feng@amd.com>
Subject: [PATCH] drm/amd/pm: refactor DPM clock level reporting
Date: Tue, 9 Jun 2026 14:51:23 +0800
Message-ID: <20260609065123.215816-1-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A107:EE_|CY5PR12MB6600:EE_
X-MS-Office365-Filtering-Correlation-Id: 9eb94ffa-b05e-4432-db7a-08dec5f38f99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|376014|11063799006|3023799007|56012099006|6133799003|13003099007|18002099003;
X-Microsoft-Antispam-Message-Info: DNokigKwf4wJ7bsVgi3movbD+KPG52mtihIGaDQzZsFijWTYHBZvJ7ZLElPYjht3QprAcyl8qiznPueMBSR0v2lefFhte7c1Am5puXOXS5bJn9PKJSyeCM2qAVIyguD5ypiJfyJ0E8lSCJ/NJGPF+LQPDw2ixuKzGXhKiWPSZK3f8TUWlrSyAdXAHQp2JvxQ0IhcXHjcrk/8pLloKToEG4dRm/RLzt30jBUhvBbOPFjg9JrIi06h0Y2Edx8YHdJKH5wqJm8npfCe5ApSUJ7uf5eZAS8CvV1TSI2ZMoz1+scTZ6KW9+ZPiPrFExWqDEiBtWHcDxq48Rx0GKBWgAfdZ1V/YC0OeEdz+z9nOj19HCI4Gp+dc0pjVhue0uVCdbEoQBm8BPHe5uywqTtARcOIarRvbdyCBD0vfsTOLvPn+SABo3IoOhfG7siGOZnxjQSMaZIlrRUD4Od/Oqsk7LnMkdYcg/maA59KYvFRcW4/OshB/1ArHJmzfnl5jZn+FTwMqYZFYe+pRSJBYB8NGIvpDDDlLDliorddQ8d/fEeWOAByS2hQynKrzeUH5W1hffTrJjQ1Apdzat+wr2bQw0i8mNN+8HX4gw7sN46DQ36aUFH3qUb4dF1iYPShp1KffMVm1WOb3f0yuV1ajM36A5ERKZDZjkuLZG7PGPJ8w8Kl3Z/cSxERJGRIL3BjsGOBOsaUUyE8kh1orQasTth9oUtGYzZee0n6WFRcnTWhh/T69wc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(11063799006)(3023799007)(56012099006)(6133799003)(13003099007)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: amTlGmFe+ZuwFW1Gv42PnP2bibLD28IKxhzrlSz/oOCYHAY1s5sFV6yeC+WfqxCfZDOccuK6A2Hk1X4shGEkvg5ZqiB7WHSrnqOIZiT8zRWYvbbiz8JbqVklEVPE8Mo7WIXMp0EXrrxDq+614xJuupSzVxOrt1e42nj3jRxcHDWylfZ27UcDYWQP3ABMRtWTuRA9zLH4F2JJuI7XXg4gNHGoFMfrH7WBynqbvJ5jpSIHYEvQG4qW4OJKhh9rJHVBk2ptbGYnWJlGLAXL8aaCEuV7u3/Tk6jid6BtdsJLMf7W1FJ3/GX+hL4RK8oSx//kWCRHvLYj+cTnyuPIIAvY3i4o54RZPfF8L3wXahJUpoZLplGe6lO583k+NFnyOTztwVfeoum6D2tgzECxfWEsA7QeudUkyv5U0Ca9eZ2U62nWNBSGcwLmTYVintF2ZHns
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 06:51:40.9742 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9eb94ffa-b05e-4432-db7a-08dec5f38f99
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A107.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6600
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

Refactor smu_cmn_print_dpm_clk_levels() to build clock entries before
emitting sysfs output.

For discrete DPM tables, mark the level closest to the reported current
clock. This avoids losing the active '*' marker when the SMU-reported
clock does not fall within the previous fixed tolerance.

Keep fine-grained output explicit by reporting the current clock on an
'F' line, and keep deep sleep represented by the 'S' line without marking
a discrete level.

Active marker placement:

| Mode         | '*' marker location       | Reason                    |
| ------------ | ------------------------- | ------------------------- |
| discrete     | closest/current DPM level | entries are real levels   |
| fine-grained | 'F:' current clock line   | min/max are range bounds  |
| deep sleep   | 'S:' line                 | outside normal DPM range  |

Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/5295
Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 148 +++++++++++++++++--------
 1 file changed, 101 insertions(+), 47 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index d365f06ac1ac..872c0328f290 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -1376,77 +1376,131 @@ void smu_cmn_reset_custom_level(struct smu_context *smu)
 	pstate_table->uclk_pstate.custom.max = 0;
 }
 
-static inline bool smu_cmn_freqs_match(uint32_t freq1, uint32_t freq2)
+struct smu_clk_print_entry {
+	uint32_t freq;
+	bool selected;
+};
+
+static inline uint32_t smu_cmn_freq_distance(uint32_t freq1, uint32_t freq2)
+{
+	return freq1 > freq2 ? freq1 - freq2 : freq2 - freq1;
+}
+
+static inline uint32_t smu_cmn_get_dpm_level_count(struct smu_dpm_table *dpm_table)
+{
+	return min_t(uint32_t, dpm_table->count, SMU_MAX_DPM_LEVELS);
+}
+
+static uint32_t smu_cmn_get_closest_clk_level(struct smu_dpm_table *dpm_table, uint32_t cur_clk)
+{
+	uint32_t min_distance, distance;
+	uint32_t closest_level = 0;
+	uint32_t count;
+	uint32_t i;
+
+	count = smu_cmn_get_dpm_level_count(dpm_table);
+	if (!count)
+		return SMU_MAX_DPM_LEVELS;
+
+	min_distance = smu_cmn_freq_distance(cur_clk, dpm_table->dpm_levels[0].value);
+	for (i = 1; i < count; i++) {
+		distance = smu_cmn_freq_distance(cur_clk, dpm_table->dpm_levels[i].value);
+		if (distance < min_distance) {
+			min_distance = distance;
+			closest_level = i;
+		}
+	}
+
+	return closest_level;
+}
+
+static inline int smu_cmn_emit_clk_line(char *buf, int size,
+					int level_index, uint32_t freq, bool selected)
+{
+	return sysfs_emit_at(buf, size, "%d: %uMhz %s\n",
+			     level_index, freq, selected ? "*" : "");
+}
+
+static void smu_cmn_build_fine_grained_levels(uint32_t min_clk, uint32_t max_clk,
+					      struct smu_clk_print_entry *entries,
+					      uint32_t *entry_count)
+{
+	*entry_count = 2;
+	entries[0].freq = min_clk;
+	entries[0].selected = false;
+	entries[1].freq = max_clk;
+	entries[1].selected = false;
+}
+
+static void smu_cmn_build_discrete_levels(struct smu_dpm_table *dpm_table,
+					  uint32_t selected_level,
+					  struct smu_clk_print_entry *entries,
+					  uint32_t *entry_count)
+{
+	uint32_t i;
+
+	*entry_count = smu_cmn_get_dpm_level_count(dpm_table);
+
+	for (i = 0; i < *entry_count; i++) {
+		entries[i].freq = dpm_table->dpm_levels[i].value;
+		entries[i].selected = (i == selected_level);
+	}
+}
+
+static int smu_cmn_emit_clk_prefix(char *buf, int size,
+				   bool is_fine_grained, bool is_deep_sleep,
+				   uint32_t cur_clk)
 {
-	/* Frequencies within 25 MHz are considered equal */
-	return (abs((int)freq1 - (int)freq2) <= 25);
+	if (is_deep_sleep)
+		size += sysfs_emit_at(buf, size, "S: %uMhz *\n", cur_clk);
+	else if (is_fine_grained)
+		size += sysfs_emit_at(buf, size, "F: %uMhz *\n", cur_clk);
+
+	return size;
 }
 
 int smu_cmn_print_dpm_clk_levels(struct smu_context *smu,
 				 struct smu_dpm_table *dpm_table,
 				 uint32_t cur_clk, char *buf, int *offset)
 {
-	uint32_t min_clk, max_clk, level_index, count;
-	uint32_t freq_values[3];
-	int size, lvl, i;
+	struct smu_clk_print_entry entries[SMU_MAX_DPM_LEVELS];
+	uint32_t min_clk, max_clk, count, entry_count = 0;
+	uint32_t selected_level = SMU_MAX_DPM_LEVELS;
+	int size, i;
 	bool is_fine_grained;
 	bool is_deep_sleep;
-	bool freq_match;
 
 	if (!dpm_table || !buf)
 		return -EINVAL;
 
-	level_index = 0;
 	size = *offset;
-	count = dpm_table->count;
 	is_fine_grained = dpm_table->flags & SMU_DPM_TABLE_FINE_GRAINED;
-	min_clk = SMU_DPM_TABLE_MIN(dpm_table);
-	max_clk = SMU_DPM_TABLE_MAX(dpm_table);
+	count = smu_cmn_get_dpm_level_count(dpm_table);
+	min_clk = count ? dpm_table->dpm_levels[0].value : 0;
+	max_clk = count ? dpm_table->dpm_levels[count - 1].value : 0;
 
 	/* Deep sleep - current clock < min_clock/2, TBD: cur_clk = 0 as GFXOFF */
 	is_deep_sleep = cur_clk < min_clk / 2;
-	if (is_deep_sleep) {
-		size += sysfs_emit_at(buf, size, "S: %uMhz *\n", cur_clk);
-		level_index = 1;
-	}
 
 	if (!is_fine_grained || count == 1) {
-		for (i = 0; i < count; i++) {
-			freq_match = !is_deep_sleep &&
-				     smu_cmn_freqs_match(
-					     cur_clk,
-					     dpm_table->dpm_levels[i].value);
-			size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n",
-					      level_index + i,
-					      dpm_table->dpm_levels[i].value,
-					      freq_match ? "*" : "");
+		if (!is_deep_sleep) {
+			selected_level =
+				smu_cmn_get_closest_clk_level(dpm_table, cur_clk);
 		}
+		smu_cmn_build_discrete_levels(dpm_table, selected_level,
+						      entries, &entry_count);
 	} else {
-		count = 2;
-		freq_values[0] = min_clk;
-		freq_values[1] = max_clk;
+		smu_cmn_build_fine_grained_levels(min_clk, max_clk,
+						  entries, &entry_count);
+	}
 
-		if (!is_deep_sleep) {
-			if (smu_cmn_freqs_match(cur_clk, min_clk)) {
-				lvl = 0;
-			} else if (smu_cmn_freqs_match(cur_clk, max_clk)) {
-				lvl = 1;
-			} else {
-				/* NOTE: use index '1' to show current clock value */
-				lvl = 1;
-				count = 3;
-				freq_values[1] = cur_clk;
-				freq_values[2] = max_clk;
-			}
-		}
+	size = smu_cmn_emit_clk_prefix(buf, size, is_fine_grained,
+				       is_deep_sleep, cur_clk);
 
-		for (i = 0; i < count; i++) {
-			size += sysfs_emit_at(
-				buf, size, "%d: %uMhz %s\n", level_index + i,
-				freq_values[i],
-				(!is_deep_sleep && i == lvl) ? "*" : "");
-		}
-	}
+	for (i = 0; i < entry_count; i++)
+		size += smu_cmn_emit_clk_line(buf, size, i,
+					     entries[i].freq,
+					     entries[i].selected);
 
 	*offset = size;
 
-- 
2.47.3

