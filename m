Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 904DACD6E45
	for <amd-gfx@archiver.kernel.org>; Fri, 29 May 2026 06:19:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2768B10F950;
	Fri, 29 May 2026 06:19:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BS0ETv4s";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010062.outbound.protection.outlook.com
 [40.93.198.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 97A4010F94F
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 May 2026 06:19:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g4OStNiQB+numTflyW62Et1LFHOA5/W6U/2Y41prnRIuph8I8HDYUDsiYm5CQudIxrHQsf3kZrul6Wfp/PM25FurJylC8K/DpG3fib7ehpsgpCD4kMCp9UAOyNh/efmP7hL44G3aUiAtdYARsVKtXrk16MvX7fEim6QXROEswaq2/80KN7dmSE+lg5xYvPrTAT1dheJir2YJBsvnUUkE1igO9aFegqH12W0kMSE+ALQTR3khZUBw53shFRsjTjgpnGSUCYN6SXjn940dK2WkBzApafZozfJCVIRs+q/ukTVhHmEBgFGtDHAjr3T/acr643qSZuLlKS/vzfWPdToWoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joO0zNYpxDK+HRWFRDq9EPR9cDgIe2kx2WM/ozBNaZo=;
 b=SodHFautWMPZSFBlvretUfE+cxFMtMkQPtgafel3QKQhVkhp4q0uAp6PDsy14HmkT5IYBT6H0yOOkvfFVU17ot8fyI0kD27W+RKsOgh/LJQ7ZiML9oEsHH8CM0PIiNtvjmzGVefEjLQSeOjmktVKMvorFzZHh6sYzunlTBJTczQyJas7ZHzStkJoh/SkLswoB9QHBnu+pRG+6ST56PMNA27Fxmmf1ZOr5iHXoOheozw0NQFyXgPLdZHf3NyXiodiVWsb2OSn8bpgc33B87XpbQsVn9vaeF3Scohqa9OuRUc0ru3HYU3eXo+/P6ACpE4+vw//KLu/fbqRlQ2dkV8U0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joO0zNYpxDK+HRWFRDq9EPR9cDgIe2kx2WM/ozBNaZo=;
 b=BS0ETv4s2vkYKp4D4gf59Ji08qIk8QCPmtXxGcfHq1FfFjHIMDcGai/i3Vnc6TQaAc5cytk2O8/uJCjfkZ390XriVI9ghSS2ZKL0B2StZLQSbep2QhV6xtI1Ztt1EcqtvHoqC7vZI4EkGUafIduhkQduUddThntLZj2+cA0DGbY=
Received: from MN0P220CA0025.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:52e::33)
 by DM4PR12MB6661.namprd12.prod.outlook.com (2603:10b6:8:b7::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.15; Fri, 29 May 2026 06:19:42 +0000
Received: from BL6PEPF0001AB71.namprd02.prod.outlook.com
 (2603:10b6:208:52e:cafe::37) by MN0P220CA0025.outlook.office365.com
 (2603:10b6:208:52e::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Fri, 29
 May 2026 06:19:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB71.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Fri, 29 May 2026 06:19:40 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 29 May
 2026 01:19:38 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <lijo.lazar@amd.com>, <hawking.zhang@amd.com>, <le.ma@amd.com>,
 <shiwu.zhang@amd.com>, <alexander.deucher@amd.com>, <kevinyang.wang@amd.com>, 
 <asad.kamal@amd.com>
Subject: [PATCH 3/4] drm/amd/pm: Handle sysfs_emit truncation for smu13
Date: Fri, 29 May 2026 14:19:19 +0800
Message-ID: <20260529061920.357400-3-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20260529061920.357400-1-asad.kamal@amd.com>
References: <20260529061920.357400-1-asad.kamal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB71:EE_|DM4PR12MB6661:EE_
X-MS-Office365-Filtering-Correlation-Id: 17cc52ca-de12-49a5-638b-08debd4a4476
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|376014|22082099003|18002099003|11063799006|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info: vSYXx0N5xPmevOnF/u7mZ4kq7ykc4nuqwxMAhHjfgsX8bsKbZcGleQfQAK2vDLsUe/+9lgq0rd7Xr5yNHn3HaedSWKTzAyKX6o8AVn5Q4GXLmlFd2w3kPUfiUZrNpWPgCB8GuLwD00uxXx0WSakOr0tG+h1LOl6NOzmkdSpJjq+o/IQIEMwIGGnuPFubzXoskIgMr67ApV5sM4c5zeRmcE01Ij9uV0awZtDW6E7rDlruOFyjO8qGqT9t8gh/W304A+ARb4prAjZjgp3hDbE1sp5l7vWzOgmMTaSexLz2hVZeWZNLngsPOeCfcPH4rIGB/PDkg68ee59wDpmTPSdfB8cl4Kh/VQmBEdNa2/+W/wntTjN9fqkxI5JoAmeKmaXOPnV1+R4dHY+ZLqqN8UstqGes5/9mnG5kLlZwMOZAZdDxVBaQjVrvXOryeotzddCkRyr8ptotmuK7O3JtSEZL09SMesJJflhHLV0GRu3l4jXMCMewfh+dEIdqUvMm4OZ6Yxqzc9axWXr+vHZTRbg1JIgHCbs0kos8aTNhmVjuOqwsgHU27gDKyMrZ6AipsAc7KwDFSD6geKkXRaG+h9O/LfCJ18q9ZksJrjPIjWCecuyEgo158olDgKpq3ZF2/mhYBwMf6234czh7AWhmROl7c9zSWyReh+te5IpgXovpqgsMjIM3/1I8h07f9t6MzTX3a+TTPjr/ELxGcvqRb2glqOunuPiklIdu2aiU2yeg/As=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(22082099003)(18002099003)(11063799006)(6133799003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: i/oYKUR6w0CszQX4IIU7wK1GRpsbu6ms29MjVXhbjolChe1zE0HRgcwjMrcePfxeJzy/c9EQNGT8YtYvwg+/9P5dR7OANQqWb1fZJswx0olXKzp/3kHo+cYIGL6E7F2LpM/jjWkohvMuoDtVWxRbkLPC2YMjiZA8paucbLd/ubIkdim+xqPFjQL9sen79ZUTnITaiY9XQgZGuw2CfEbZOceCDUT5GEr+2HvhaOGhuTHF7JWeD4SX/N9+MzgzPH4ax+Z3+R+Ql3CbVrlLrAYDvvIcSr6oHRRFGKnlAEUd574peBTGwREIOL+3hIyTNR/LApypofLqbb3Zp8y751kkKl7kPmu0xdf6lJiuGkRl4QvWPGTOeqZyRjpZJm5Mu0qay3VJvJ3Dt/y1b8rkc//d9BtxiBwmrDjUpvPvnFz9/m2TDGtoLQz3tR1iaAjvIx8h
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 06:19:40.6577 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17cc52ca-de12-49a5-638b-08debd4a4476
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB71.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6661
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

Check sysfs_emit_at() in emit_clk_levels() for smu_v13_0_4, smu_v13_0_5,
yellow_carp, aldebaran, and smu_v13_0_6 (OD sysfs and OD_FCLK on v13_0_6)
and stop emitting when the sysfs page is full

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    | 36 +++++++---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c  | 68 +++++++++++++------
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c  | 66 +++++++++++++-----
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 45 ++++++++----
 .../drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c  | 66 +++++++++++++-----
 5 files changed, 203 insertions(+), 78 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index 3a19f0ffcf3c..2d4c557c04e9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -791,7 +791,7 @@ static int aldebaran_get_current_clk_freq_by_table(struct smu_context *smu,
 static int aldebaran_emit_clk_levels(struct smu_context *smu,
 				     enum smu_clk_type type, char *buf, int *offset)
 {
-	int ret = 0;
+	int ret = 0, n;
 	struct smu_umd_pstate_table *pstate_table = &smu->pstate_table;
 	struct smu_dpm_table *single_dpm_table = NULL;
 	struct smu_dpm_context *smu_dpm = &smu->smu_dpm;
@@ -800,7 +800,10 @@ static int aldebaran_emit_clk_levels(struct smu_context *smu,
 	static const char attempt_string[] = "Attempt to get current";
 
 	if (amdgpu_ras_intr_triggered()) {
-		*offset += sysfs_emit_at(buf, *offset, "unavailable\n");
+		int unr = sysfs_emit_at(buf, *offset, "unavailable\n");
+
+		if (unr)
+			*offset += unr;
 		return -EBUSY;
 	}
 
@@ -808,16 +811,28 @@ static int aldebaran_emit_clk_levels(struct smu_context *smu,
 
 	switch (type) {
 	case SMU_OD_SCLK:
-		*offset += sysfs_emit_at(buf, *offset, "%s:\n", "OD_SCLK");
-		*offset += sysfs_emit_at(buf, *offset, "0: %uMhz\n1: %uMhz\n",
-					 pstate_table->gfxclk_pstate.curr.min,
-					 pstate_table->gfxclk_pstate.curr.max);
+		n = sysfs_emit_at(buf, *offset, "%s:\n", "OD_SCLK");
+		if (!n)
+			goto out;
+		*offset += n;
+		n = sysfs_emit_at(buf, *offset, "0: %uMhz\n1: %uMhz\n",
+				  pstate_table->gfxclk_pstate.curr.min,
+				  pstate_table->gfxclk_pstate.curr.max);
+		if (!n)
+			goto out;
+		*offset += n;
 		return 0;
 	case SMU_OD_MCLK:
-		*offset += sysfs_emit_at(buf, *offset, "%s:\n", "OD_MCLK");
-		*offset += sysfs_emit_at(buf, *offset, "0: %uMhz\n1: %uMhz\n",
-					 pstate_table->uclk_pstate.curr.min,
-					 pstate_table->uclk_pstate.curr.max);
+		n = sysfs_emit_at(buf, *offset, "%s:\n", "OD_MCLK");
+		if (!n)
+			goto out;
+		*offset += n;
+		n = sysfs_emit_at(buf, *offset, "0: %uMhz\n1: %uMhz\n",
+				  pstate_table->uclk_pstate.curr.min,
+				  pstate_table->uclk_pstate.curr.max);
+		if (!n)
+			goto out;
+		*offset += n;
 		return 0;
 
 	case SMU_SCLK:
@@ -842,6 +857,7 @@ static int aldebaran_emit_clk_levels(struct smu_context *smu,
 		return -EINVAL;
 	}
 
+out:
 	if (single_dpm_table) {
 		ret = aldebaran_get_current_clk_freq_by_table(smu, type,
 							      &cur_value);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
index 167b3499f7f1..903d81a74ede 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
@@ -503,23 +503,40 @@ static int smu_v13_0_4_emit_clk_levels(struct smu_context *smu,
 				       enum smu_clk_type clk_type, char *buf,
 				       int *offset)
 {
-	int i, idx, size = *offset, ret = 0, start_offset = *offset;
+	int i, idx, size = *offset, ret = 0, start_offset = *offset, n;
 	uint32_t cur_value = 0, value = 0, count = 0;
 	uint32_t min, max;
 
 	switch (clk_type) {
 	case SMU_OD_SCLK:
-		size += sysfs_emit_at(buf, size, "%s:\n", "OD_SCLK");
-		size += sysfs_emit_at(buf, size, "0: %10uMhz\n",
-		(smu->gfx_actual_hard_min_freq > 0) ? smu->gfx_actual_hard_min_freq : smu->gfx_default_hard_min_freq);
-		size += sysfs_emit_at(buf, size, "1: %10uMhz\n",
-		(smu->gfx_actual_soft_max_freq > 0) ? smu->gfx_actual_soft_max_freq : smu->gfx_default_soft_max_freq);
+		n = sysfs_emit_at(buf, size, "%s:\n", "OD_SCLK");
+		if (!n)
+			goto out;
+		size += n;
+		n = sysfs_emit_at(buf, size, "0: %10uMhz\n",
+				  (smu->gfx_actual_hard_min_freq > 0) ?
+				  smu->gfx_actual_hard_min_freq : smu->gfx_default_hard_min_freq);
+		if (!n)
+			goto out;
+		size += n;
+		n = sysfs_emit_at(buf, size, "1: %10uMhz\n",
+				  (smu->gfx_actual_soft_max_freq > 0) ?
+				  smu->gfx_actual_soft_max_freq : smu->gfx_default_soft_max_freq);
+		if (!n)
+			goto out;
+		size += n;
 		break;
 	case SMU_OD_RANGE:
-		size += sysfs_emit_at(buf, size, "%s:\n", "OD_RANGE");
-		size += sysfs_emit_at(buf, size, "SCLK: %7uMhz %10uMhz\n",
-				      smu->gfx_default_hard_min_freq,
-				      smu->gfx_default_soft_max_freq);
+		n = sysfs_emit_at(buf, size, "%s:\n", "OD_RANGE");
+		if (!n)
+			goto out;
+		size += n;
+		n = sysfs_emit_at(buf, size, "SCLK: %7uMhz %10uMhz\n",
+				  smu->gfx_default_hard_min_freq,
+				  smu->gfx_default_soft_max_freq);
+		if (!n)
+			goto out;
+		size += n;
 		break;
 	case SMU_SOCCLK:
 	case SMU_VCLK:
@@ -540,8 +557,11 @@ static int smu_v13_0_4_emit_clk_levels(struct smu_context *smu,
 			if (ret)
 				return ret;
 
-			size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n", i, value,
-					      cur_value == value ? "*" : "");
+			n = sysfs_emit_at(buf, size, "%d: %uMhz %s\n", i, value,
+					  cur_value == value ? "*" : "");
+			if (!n)
+				goto out;
+			size += n;
 		}
 		break;
 	case SMU_GFXCLK:
@@ -557,18 +577,28 @@ static int smu_v13_0_4_emit_clk_levels(struct smu_context *smu,
 			i = 0;
 		else
 			i = 1;
-		size += sysfs_emit_at(buf, size, "0: %uMhz %s\n", min,
-				      i == 0 ? "*" : "");
-		size += sysfs_emit_at(buf, size, "1: %uMhz %s\n",
-				      i == 1 ? cur_value : 1100, /* UMD PSTATE GFXCLK 1100 */
-				      i == 1 ? "*" : "");
-		size += sysfs_emit_at(buf, size, "2: %uMhz %s\n", max,
-				      i == 2 ? "*" : "");
+		n = sysfs_emit_at(buf, size, "0: %uMhz %s\n", min,
+				  i == 0 ? "*" : "");
+		if (!n)
+			goto out;
+		size += n;
+		n = sysfs_emit_at(buf, size, "1: %uMhz %s\n",
+				  i == 1 ? cur_value : 1100, /* UMD PSTATE GFXCLK 1100 */
+				  i == 1 ? "*" : "");
+		if (!n)
+			goto out;
+		size += n;
+		n = sysfs_emit_at(buf, size, "2: %uMhz %s\n", max,
+				  i == 2 ? "*" : "");
+		if (!n)
+			goto out;
+		size += n;
 		break;
 	default:
 		break;
 	}
 
+out:
 	*offset += size - start_offset;
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
index 141e778333c5..d26beb4cd6d7 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
@@ -868,22 +868,39 @@ static int smu_v13_0_5_emit_clk_levels(struct smu_context *smu,
 				       enum smu_clk_type clk_type, char *buf,
 				       int *offset)
 {
-	int i, idx, size = *offset, ret = 0, start_offset = *offset;
+	int i, idx, size = *offset, ret = 0, start_offset = *offset, n;
 	uint32_t cur_value = 0, value = 0, count = 0;
 	uint32_t min = 0, max = 0;
 
 	switch (clk_type) {
 	case SMU_OD_SCLK:
-		size += sysfs_emit_at(buf, size, "%s:\n", "OD_SCLK");
-		size += sysfs_emit_at(buf, size, "0: %10uMhz\n",
-		(smu->gfx_actual_hard_min_freq > 0) ? smu->gfx_actual_hard_min_freq : smu->gfx_default_hard_min_freq);
-		size += sysfs_emit_at(buf, size, "1: %10uMhz\n",
-		(smu->gfx_actual_soft_max_freq > 0) ? smu->gfx_actual_soft_max_freq : smu->gfx_default_soft_max_freq);
+		n = sysfs_emit_at(buf, size, "%s:\n", "OD_SCLK");
+		if (!n)
+			goto out;
+		size += n;
+		n = sysfs_emit_at(buf, size, "0: %10uMhz\n",
+				  (smu->gfx_actual_hard_min_freq > 0) ?
+				  smu->gfx_actual_hard_min_freq : smu->gfx_default_hard_min_freq);
+		if (!n)
+			goto out;
+		size += n;
+		n = sysfs_emit_at(buf, size, "1: %10uMhz\n",
+				  (smu->gfx_actual_soft_max_freq > 0) ?
+				  smu->gfx_actual_soft_max_freq : smu->gfx_default_soft_max_freq);
+		if (!n)
+			goto out;
+		size += n;
 		break;
 	case SMU_OD_RANGE:
-		size += sysfs_emit_at(buf, size, "%s:\n", "OD_RANGE");
-		size += sysfs_emit_at(buf, size, "SCLK: %7uMhz %10uMhz\n",
-						smu->gfx_default_hard_min_freq, smu->gfx_default_soft_max_freq);
+		n = sysfs_emit_at(buf, size, "%s:\n", "OD_RANGE");
+		if (!n)
+			goto out;
+		size += n;
+		n = sysfs_emit_at(buf, size, "SCLK: %7uMhz %10uMhz\n",
+				  smu->gfx_default_hard_min_freq, smu->gfx_default_soft_max_freq);
+		if (!n)
+			goto out;
+		size += n;
 		break;
 	case SMU_SOCCLK:
 	case SMU_VCLK:
@@ -903,8 +920,11 @@ static int smu_v13_0_5_emit_clk_levels(struct smu_context *smu,
 			if (ret)
 				return ret;
 
-			size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n", i, value,
-					cur_value == value ? "*" : "");
+			n = sysfs_emit_at(buf, size, "%d: %uMhz %s\n", i, value,
+					  cur_value == value ? "*" : "");
+			if (!n)
+				goto out;
+			size += n;
 		}
 		break;
 	case SMU_GFXCLK:
@@ -920,18 +940,28 @@ static int smu_v13_0_5_emit_clk_levels(struct smu_context *smu,
 			i = 0;
 		else
 			i = 1;
-		size += sysfs_emit_at(buf, size, "0: %uMhz %s\n", min,
-				i == 0 ? "*" : "");
-		size += sysfs_emit_at(buf, size, "1: %uMhz %s\n",
-				i == 1 ? cur_value : SMU_13_0_5_UMD_PSTATE_GFXCLK,
-				i == 1 ? "*" : "");
-		size += sysfs_emit_at(buf, size, "2: %uMhz %s\n", max,
-				i == 2 ? "*" : "");
+		n = sysfs_emit_at(buf, size, "0: %uMhz %s\n", min,
+				  i == 0 ? "*" : "");
+		if (!n)
+			goto out;
+		size += n;
+		n = sysfs_emit_at(buf, size, "1: %uMhz %s\n",
+				  i == 1 ? cur_value : SMU_13_0_5_UMD_PSTATE_GFXCLK,
+				  i == 1 ? "*" : "");
+		if (!n)
+			goto out;
+		size += n;
+		n = sysfs_emit_at(buf, size, "2: %uMhz %s\n", max,
+				  i == 2 ? "*" : "");
+		if (!n)
+			goto out;
+		size += n;
 		break;
 	default:
 		break;
 	}
 
+out:
 	*offset += size - start_offset;
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index ce520f43ab94..3d2bcdab1621 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -1387,7 +1387,7 @@ static int smu_v13_0_6_emit_clk_levels(struct smu_context *smu,
 				       enum smu_clk_type type, char *buf,
 				       int *offset)
 {
-	int now, size = *offset, start_offset = *offset;
+	int now, size = *offset, start_offset = *offset, n;
 	int ret = 0;
 	struct smu_umd_pstate_table *pstate_table = &smu->pstate_table;
 	struct smu_dpm_table *single_dpm_table = NULL;
@@ -1403,28 +1403,46 @@ static int smu_v13_0_6_emit_clk_levels(struct smu_context *smu,
 
 	switch (type) {
 	case SMU_OD_SCLK:
-		size += sysfs_emit_at(buf, size, "%s:\n", "OD_SCLK");
-		size += sysfs_emit_at(buf, size, "0: %uMhz\n1: %uMhz\n",
-				      pstate_table->gfxclk_pstate.curr.min,
-				      pstate_table->gfxclk_pstate.curr.max);
+		n = sysfs_emit_at(buf, size, "%s:\n", "OD_SCLK");
+		if (!n)
+			goto out;
+		size += n;
+		n = sysfs_emit_at(buf, size, "0: %uMhz\n1: %uMhz\n",
+				  pstate_table->gfxclk_pstate.curr.min,
+				  pstate_table->gfxclk_pstate.curr.max);
+		if (!n)
+			goto out;
+		size += n;
 		break;
 	case SMU_OD_MCLK:
 		if (!smu_v13_0_6_cap_supported(smu, SMU_CAP(SET_UCLK_MAX)))
 			return -EOPNOTSUPP;
 
-		size += sysfs_emit_at(buf, size, "%s:\n", "OD_MCLK");
-		size += sysfs_emit_at(buf, size, "0: %uMhz\n1: %uMhz\n",
-				      pstate_table->uclk_pstate.curr.min,
-				      pstate_table->uclk_pstate.curr.max);
+		n = sysfs_emit_at(buf, size, "%s:\n", "OD_MCLK");
+		if (!n)
+			goto out;
+		size += n;
+		n = sysfs_emit_at(buf, size, "0: %uMhz\n1: %uMhz\n",
+				  pstate_table->uclk_pstate.curr.min,
+				  pstate_table->uclk_pstate.curr.max);
+		if (!n)
+			goto out;
+		size += n;
 		break;
 	case SMU_OD_FCLK:
 		if (!smu_cmn_feature_is_enabled(smu, SMU_FEATURE_DPM_FCLK_BIT))
 			return -EOPNOTSUPP;
 
-		size += sysfs_emit_at(buf, size, "%s:\n", "OD_FCLK");
-		size += sysfs_emit_at(buf, size, "0: %uMhz\n1: %uMhz\n",
-				      pstate_table->fclk_pstate.curr.min,
-				      pstate_table->fclk_pstate.curr.max);
+		n = sysfs_emit_at(buf, size, "%s:\n", "OD_FCLK");
+		if (!n)
+			goto out;
+		size += n;
+		n = sysfs_emit_at(buf, size, "0: %uMhz\n1: %uMhz\n",
+				  pstate_table->fclk_pstate.curr.min,
+				  pstate_table->fclk_pstate.curr.max);
+		if (!n)
+			goto out;
+		size += n;
 		break;
 	case SMU_SCLK:
 	case SMU_GFXCLK:
@@ -1462,6 +1480,7 @@ static int smu_v13_0_6_emit_clk_levels(struct smu_context *smu,
 						    buf, offset);
 	}
 
+out:
 	*offset += size - start_offset;
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
index 748b5b074fff..e668af4df402 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
@@ -1048,23 +1048,40 @@ static int yellow_carp_emit_clk_levels(struct smu_context *smu,
 				       enum smu_clk_type clk_type, char *buf,
 				       int *offset)
 {
-	int i, idx, size = *offset, ret = 0, start_offset = *offset;
+	int i, idx, size = *offset, ret = 0, start_offset = *offset, n;
 	uint32_t cur_value = 0, value = 0, count = 0;
 	uint32_t min, max;
 	uint32_t clk_limit = 0;
 
 	switch (clk_type) {
 	case SMU_OD_SCLK:
-		size += sysfs_emit_at(buf, size, "%s:\n", "OD_SCLK");
-		size += sysfs_emit_at(buf, size, "0: %10uMhz\n",
-		(smu->gfx_actual_hard_min_freq > 0) ? smu->gfx_actual_hard_min_freq : smu->gfx_default_hard_min_freq);
-		size += sysfs_emit_at(buf, size, "1: %10uMhz\n",
-		(smu->gfx_actual_soft_max_freq > 0) ? smu->gfx_actual_soft_max_freq : smu->gfx_default_soft_max_freq);
+		n = sysfs_emit_at(buf, size, "%s:\n", "OD_SCLK");
+		if (!n)
+			goto out;
+		size += n;
+		n = sysfs_emit_at(buf, size, "0: %10uMhz\n",
+				  (smu->gfx_actual_hard_min_freq > 0) ?
+				  smu->gfx_actual_hard_min_freq : smu->gfx_default_hard_min_freq);
+		if (!n)
+			goto out;
+		size += n;
+		n = sysfs_emit_at(buf, size, "1: %10uMhz\n",
+				  (smu->gfx_actual_soft_max_freq > 0) ?
+				  smu->gfx_actual_soft_max_freq : smu->gfx_default_soft_max_freq);
+		if (!n)
+			goto out;
+		size += n;
 		break;
 	case SMU_OD_RANGE:
-		size += sysfs_emit_at(buf, size, "%s:\n", "OD_RANGE");
-		size += sysfs_emit_at(buf, size, "SCLK: %7uMhz %10uMhz\n",
-						smu->gfx_default_hard_min_freq, smu->gfx_default_soft_max_freq);
+		n = sysfs_emit_at(buf, size, "%s:\n", "OD_RANGE");
+		if (!n)
+			goto out;
+		size += n;
+		n = sysfs_emit_at(buf, size, "SCLK: %7uMhz %10uMhz\n",
+				  smu->gfx_default_hard_min_freq, smu->gfx_default_soft_max_freq);
+		if (!n)
+			goto out;
+		size += n;
 		break;
 	case SMU_SOCCLK:
 	case SMU_VCLK:
@@ -1085,8 +1102,11 @@ static int yellow_carp_emit_clk_levels(struct smu_context *smu,
 			if (ret)
 				return ret;
 
-			size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n", i, value,
-					cur_value == value ? "*" : "");
+			n = sysfs_emit_at(buf, size, "%d: %uMhz %s\n", i, value,
+					  cur_value == value ? "*" : "");
+			if (!n)
+				goto out;
+			size += n;
 		}
 		break;
 	case SMU_GFXCLK:
@@ -1103,18 +1123,28 @@ static int yellow_carp_emit_clk_levels(struct smu_context *smu,
 			i = 0;
 		else
 			i = 1;
-		size += sysfs_emit_at(buf, size, "0: %uMhz %s\n", min,
-				i == 0 ? "*" : "");
-		size += sysfs_emit_at(buf, size, "1: %uMhz %s\n",
-				i == 1 ? cur_value : clk_limit,
-				i == 1 ? "*" : "");
-		size += sysfs_emit_at(buf, size, "2: %uMhz %s\n", max,
-				i == 2 ? "*" : "");
+		n = sysfs_emit_at(buf, size, "0: %uMhz %s\n", min,
+				  i == 0 ? "*" : "");
+		if (!n)
+			goto out;
+		size += n;
+		n = sysfs_emit_at(buf, size, "1: %uMhz %s\n",
+				  i == 1 ? cur_value : clk_limit,
+				  i == 1 ? "*" : "");
+		if (!n)
+			goto out;
+		size += n;
+		n = sysfs_emit_at(buf, size, "2: %uMhz %s\n", max,
+				  i == 2 ? "*" : "");
+		if (!n)
+			goto out;
+		size += n;
 		break;
 	default:
 		break;
 	}
 
+out:
 	*offset += size - start_offset;
 
 	return 0;
-- 
2.46.0

