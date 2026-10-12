Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DD51CA9EBD
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Oct 2026 01:28:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE37A10E197;
	Mon, 12 Oct 2026 01:28:11 +0000 (UTC)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010015.outbound.protection.outlook.com [52.101.56.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 788FC10E197
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Oct 2026 01:28:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a2p8FexP2rjkebeV0PUGF18WuTcKvRh66wHUOar4HZAP8Ugj2n9VuuNygWWeTewDbMN/LnYWIPu6H3asXda93OhhLPtS0bPwplwJmFHJOEesNW0owKGYlz2QPx3/2Xq24verWXxZ+7cm67R0CTe6FpHipGTtmFqGnqOMrpGdQ74Vjx+a/d1LnQQ8hVFaov+JJ0OSwh3N8m5GvrfIKk98dpu2z1/KWKq7qWfy4Ao20GX1UsX0PUn7Fm+gIHY38e+vEaP5CrgDarv9AaS7B3SGOo//ixZ7AdLhmv7bIVm6Jj8KO1Twi2rDoZZ5zPQs5aCehRoMsowsl1nO1NcEk9/q/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fn7WZS94FwZhFlflm/6nqLXftPp+HkLMpEazk7OGiCw=;
 b=x+UMVe81C60cfythJPSEze716iQqfo1HmIM3SD4+UtuFiVeIgKvVaifJrJWAksGaNuy51BojG2cqD+t+7CaX3WXBYGzNqQnTIOTsLl1ZZU2RJ+hr17pDmZf6CcxOOGzyhFPofsftUaDrkr6w+c1VHO/pGSRhc3bmCskpXr/ci6BKZ934d9IOZIz1zLHkDO6IjWgB8/EsGPA8SAbyC9+z16eTI0sZq2vD2cNpma+o3H4MC7Grced2mUlKmawABeEBwjTrvxodeo8VOnWckYg21qOUZ5NzKYCh3uCopbApege7ihqUOUmNN5VbO0rq79dyRS14oy/1kYkyiMravp5fYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fn7WZS94FwZhFlflm/6nqLXftPp+HkLMpEazk7OGiCw=;
 b=r2Nx3tOTUyyBF3jgw9CQi+bJDTPXRveRlZUKEWG/QODJiHLhsIsJuB0T9216RsJyraLi/8PfNUxlMthy3gEXBnj+5fvu4irLZiss+tCIwzUlezoOZ6hsOkBXiii8huMRW44htiuSIsOqVdaB006+vGeaLnxrDqBlrEtONtcfYJY=
Received: from MW4PR04CA0253.namprd04.prod.outlook.com (2603:10b6:303:88::18)
 by BL1PR12MB5804.namprd12.prod.outlook.com (2603:10b6:208:394::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.20; Mon, 12 Oct
 2026 01:28:00 +0000
Received: from SJ1PEPF000037AA.namprd03.prod.outlook.com
 (2603:10b6:303:88:cafe::1e) by MW4PR04CA0253.outlook.office365.com
 (2603:10b6:303:88::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Mon, 12
 Oct 2026 01:28:00 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000037AA.mail.protection.outlook.com (10.167.244.184) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Mon, 12 Oct 2026 01:27:59 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Sun, 11 Oct
 2026 20:27:52 -0500
From: Kevin Wang <kevin.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <hawking.zhang@amd.com>,
 <kenneth.feng@amd.com>
Subject: [PATCH] drm/amd/pm: mark the current DPM clock level active
Date: Mon, 12 Oct 2026 09:27:47 +0800
Message-ID: <20261012012748.3150968-1-kevin.wang@amd.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037AA:EE_|BL1PR12MB5804:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ffa31da-155d-40e4-9093-08df28000d46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|36860700016|1800799024|376014|6133799003|18002099003|10067099003|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: ZolbGGKs57o3Dyfil7I9kq/K4e/EfIwxHfo64YDX9TALBFMp7Cd27ewwZRXUQWLHc7s8M4PbgOtjNNZUtxkPWJumVquAhUbCKiAPf0fMufIePnCOnPd+6SF1ucSKR6K2srPYzcVMoywAGD8oyanXKFa4KOub7BLQA8gBMhs59onjn4Hd9h6oHASv24lEABkFaheD/a7N1Rz7rrANVYeXvALUvqEvc4d2ig+IEeGGT7xnxwaxeIoSWqmwxtlHd0ZZtjoQ1W+0yECjXt/4QLuUkmxL5taXiWDCohkkd0WLfPYFFING5f5Kbb9n6HaHAhkGHT7z/GxDi3n0jX8LW7f1Q0tCpXzu3rkV/vA9n6GsTDW/x+qtl9+EQr/kFYyCQ3s8UPUlRx5RI9sjk3R984bBgGNA+UbwGC+FiPXuqNgt5pJxcv6FW/LYhe2gwFoHCNmozlClO1bVLv3xJhbcsNGkz07QymgOqVvrwf2Wlbh5r3UOCwCbtPazB4E6oqyaBS01Yc9VmFZfO1aFdg8nzcilkMBwOUb5QgiZs417QFW2OQ+4MT82QGSpTVkVE6Bk4aKl5SLcUC9woOgP1AJHE9OeVOjzCPC1vNzjvJwYyggcRmcXd6ybL51a+ZSIoSV+JyHY+IEQHzu5T00gxOLSMhdVi2OOb7kEN6RDMHY34rbM51gwUlVS/rRjW4nCacwNTwjm
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(36860700016)(1800799024)(376014)(6133799003)(18002099003)(10067099003)(11063799006)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 9pjgucppkJoRHe8+VG1gz/Q0q0THnG9+sR8WrnhhQ2ix7C31aV3jZzmh6yw7t0zDDa27DifU+vHlKIA8MWJD1HDG+4tRy5U2UpQ1iWxBBlKFV/RGZIkwhyegy/jd2DoGsA5LSZ9+r30ycdcETmxlajcsm+7k1lMN0RMWgkgXYdSYNgZmJyX8NrlaUXZLCCywljEQ1mQaQ6rWDNEyNYc2peDsIU8VViSmZYsZsXttkKJhHgD7RAy75E7gE/BUer67P1lFZ/kCEuvQ5iGPZ0qwfy9Z4YtlPz8Gu6PsI8i3VIaoBd1OjjXHz3jY/W5Tw5Dldgr7M76sftNqD9RLWUL7J32C1amzy1KyykSdf9ADjzJnug2iDSFG/3ELPGz0o7mvVAq2Q95WFxdYBEOuBY99JgWoJvTm4z3BHImDHnoYaQatoWSZvMxgVDcBaj5qRUNO
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 01:27:59.6481 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ffa31da-155d-40e4-9093-08df28000d46
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000037AA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5804
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

PMFW can report clocks outside or between advertised DPM levels.

Report a clock below DPM0 as a special active S level.
Mark the nearest level active for a discrete DPM table.
Clamp a clock above the table range to the maximum DPM level.
Keep reporting the actual clock for a fine-grained DPM table.

Signed-off-by: Kevin Wang <kevin.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 35 ++++++++++++++++++++------
 1 file changed, 27 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index 361657c19ea3..8cf616517ddd 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -1391,11 +1391,12 @@ int smu_cmn_print_dpm_clk_levels(struct smu_context *smu,
 				 uint32_t cur_clk, char *buf, int *offset)
 {
 	uint32_t min_clk, max_clk, level_index, count;
+	uint32_t nearest_level = 0, nearest_diff = U32_MAX;
 	uint32_t freq_values[3];
+	uint32_t clk_diff, level_clk;
 	int size, lvl, i;
 	bool is_fine_grained;
 	bool is_deep_sleep;
-	bool freq_match;
 
 	if (!dpm_table || !buf)
 		return -EINVAL;
@@ -1407,23 +1408,41 @@ int smu_cmn_print_dpm_clk_levels(struct smu_context *smu,
 	min_clk = SMU_DPM_TABLE_MIN(dpm_table);
 	max_clk = SMU_DPM_TABLE_MAX(dpm_table);
 
-	/* Deep sleep - current clock < min_clock/2, TBD: cur_clk = 0 as GFXOFF */
-	is_deep_sleep = cur_clk < min_clk / 2;
+	/* A clock below DPM0 is reported as a special deep-sleep level. */
+	is_deep_sleep = cur_clk < min_clk;
 	if (is_deep_sleep) {
 		size += sysfs_emit_at(buf, size, "S: %uMhz *\n", cur_clk);
 		level_index = 1;
 	}
 
+	/*
+	 * Discrete tables mark the level nearest to the current clock.  Clamp
+	 * clocks above the advertised range to the last level.  Fine-grained
+	 * tables keep reporting the actual current clock between min and max.
+	 */
 	if (!is_fine_grained || count == 1) {
+		if (!is_deep_sleep) {
+			if (cur_clk >= max_clk) {
+				nearest_level = count - 1;
+			} else {
+				for (i = 0; i < count; i++) {
+					level_clk = dpm_table->dpm_levels[i].value;
+					clk_diff = cur_clk > level_clk ?
+						   cur_clk - level_clk : level_clk - cur_clk;
+					if (clk_diff < nearest_diff) {
+						nearest_diff = clk_diff;
+						nearest_level = i;
+					}
+				}
+			}
+		}
+
 		for (i = 0; i < count; i++) {
-			freq_match = !is_deep_sleep &&
-				     smu_cmn_freqs_match(
-					     cur_clk,
-					     dpm_table->dpm_levels[i].value);
 			size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n",
 					      level_index + i,
 					      dpm_table->dpm_levels[i].value,
-					      freq_match ? "*" : "");
+					      (!is_deep_sleep &&
+					       i == nearest_level) ? "*" : "");
 		}
 	} else {
 		count = 2;
-- 
2.55.0

