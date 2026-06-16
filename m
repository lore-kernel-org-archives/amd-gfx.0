Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21F5BCD98CF
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jun 2026 09:17:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A395710E97F;
	Tue, 16 Jun 2026 09:17:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QYW+dT9t";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011009.outbound.protection.outlook.com [40.107.208.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA56710E97F
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jun 2026 09:17:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H5nRfN4HIoMVdpkataq2MMRkU3eYAqdgdNRLDub8BK1KjFdyy1qG3FGR1yNjLEzdxF1OZ3+sYXpYYG1sPwuvhPILn9owfnZ86rmy1mLpdXZo+Oaa1B1y7GH92ZGD9GpmHHHvRqhB49+mA/yRzAzpPPKXBRDpa+GSdR4UHFVAHkNuyONIwehnjaMQXYldt5J4aly/ATOEOwJ21HByE73wTkYv8nL6qc6qFbEyMghMUcS7eqduD2qvN4GgRkqNO5ZM0/JNRry9Q3aUcJxY9dHz+4u9ocgARhNl9ImZYiQt3IhXnu6agCPbDEhhoW2wzx2Pp+9IoJSx0KQcpGOUkan29g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0vw2BBHlfYwAoht56ik8WdeSeiWvbgeZ2rtIeYHXrMg=;
 b=RrlgTgnhqwcXmGK/tDmGqsjLH1QzHYcUtEkDNA2mpNV1q0j4Vm+tYrfcERPWFffeBOtC5j+XbcKeNhd0eMVxyRrZ7p16N/rAgOkBuvu5UJua6sNHlmGX7YfjZ+M07sE5Wr/pdeQYIqsv8REHKBVlTAX70ckNNQ5wPAzFWw6g5yM5JB7vGd6AoRC2jQ/+2ivL9/SgjTIgrcuzxJjw0o+rZu1cWHv+ZydDzj6Hg6dCmKYCuXQu6Lysj7GZcfJgfkHwhxpQOCNS56skuwgf1sbOwMpHP6JtzUQ7i5GYSZY4dWeRG0PW3+IyunBYBsqcUWHVxjL90YRjny0TE4cb1/hvEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0vw2BBHlfYwAoht56ik8WdeSeiWvbgeZ2rtIeYHXrMg=;
 b=QYW+dT9tsHmPX0KKSjfTBi6FdWhfc8B1nXtUOySaKNL9lv8ufxCdnPiaeRoJuM5Kui/r+XhIxBZk7jnG+/PIhQO1IEyTQS7hR3GKT7BIPnpHcr5+YO/GsgREBTZLbr8luE6EYgkvHe1p5NocZX725UBBwpPdhjq8yx2MkMCXF18=
Received: from CH5PR05CA0020.namprd05.prod.outlook.com (2603:10b6:610:1f0::13)
 by SA5PPF6407DD448.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8ce) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 09:17:43 +0000
Received: from CH2PEPF00000140.namprd02.prod.outlook.com
 (2603:10b6:610:1f0:cafe::1d) by CH5PR05CA0020.outlook.office365.com
 (2603:10b6:610:1f0::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.11 via Frontend Transport; Tue,
 16 Jun 2026 09:17:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF00000140.mail.protection.outlook.com (10.167.244.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Tue, 16 Jun 2026 09:17:42 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 16 Jun
 2026 04:17:42 -0500
Received: from rtg-MAPLE.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 16 Jun 2026 04:17:39 -0500
From: Priya Hosur <Priya.Hosur@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Lijo.Lazar@amd.com>,
 <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Mario.Limonciello@amd.com>, <Kenneth.Feng@amd.com>
CC: <Pratik.Vishwakarma@amd.com>, <Veerabadhran.Gopalakrishnan@amd.com>,
 <Priya.Hosur@amd.com>
Subject: [PATCH v5 1/4] drm/amd/pm: smu_v14_0_0: fix DCLK metric reporting via
 VCLK level index
Date: Tue, 16 Jun 2026 14:47:28 +0530
Message-ID: <20260616091731.3722-2-Priya.Hosur@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260616091731.3722-1-Priya.Hosur@amd.com>
References: <20260616091731.3722-1-Priya.Hosur@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000140:EE_|SA5PPF6407DD448:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a5b63ee-287a-414d-2143-08decb881ed2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|23010399003|82310400026|376014|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: UaIz4to5+V+KGpo1hEyB95BAHVP9G2n8x+9VG023RDcpVRmi5W29gdeHZDSof/USlczSuBklixHVxpaoxzqaB+wPnRAcCPn5n3yFFVJhoOCYjDGcT9vSrlnX9JeAXujGCcGRTWaRfix8nNoyNOKJNqiZoo8p29owC38dz1K5zIoQcQQxppMymDcSiOJDFMqypUdBrEfJ19AM2wge9G30u0zjeuR3rOX4EuVDyoczYoI/+KmKoTCuAtdiH9f7lAfBYRh8wqwlerllo2UKqNxp1shtujY6R9S1FS5B9U0tOtHd207v4NLMt45I6pKCeL6LjJeF3bI2BjCziL5VmyNv4PWN7mLTKZxApTabH3yKcfxZCCKCIidzvMW2Z4TN1NJw/RRe0FfwkSeoX2YTCR2QfTl96jQQ2qy/orvreFZfeDdDPYiJptS+gm2fz5C2JOUl3ZfnjniK5cmmK+bvkPXmMtYWktWCUSSkOb3YGR0Ckd1q8NTvyQHXZ8B4Y0axB3UbS8QSlsz5anCZV9uueUaQ7QRukXJZmNFmsH/Ro3shT4+Yd0EHFXVZ2D6Zj5kPgaJYKzTIns/z2IVYD+54Dx2FfadUJ72Dy37eB9r4AdkJkGtzReyHhjfDgMWCSnaExnBJK9NwDPH0zkrtoo0uIsOu4pRRuHnJ3zTl4ewkU1qPlTj0dnwno8PcxwRElRmhY9GROv+SmGLWFjKWAosVajDTU4SG6BI2ryoJciQkey4HhPo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(23010399003)(82310400026)(376014)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /LAI2mtY3QPY8BU9NONYjnyL+NSxoHSicnBu2kfbu1VdHBSNu5rstLmi4OwknARDaWded2rBA1YqmCJPoGcPX0rAnPD68CjIUd3vT7WwUL6TtbqcEX+DTAs7qvmf7Q4zmQGR2w6W4M/V8EatFKEWu2mgmXDjAHDqzaH5A/OXxYpzIPbuj1hsyz1zqVVUBIeCPFfQxh3K4vVUEgvPTA3gEJZZ6AohtRlbAUsjQ5O2m50L6wJBvFUn5SkRvNXAGAN8mBqNdMP+G8OwcFn0fHkb+CAPX2x5CB+6ZRWRWylhrcyV/RQGvT+NnacYGNyMaZV7hU6PLKvmokOskAnI9v+oJuUb7NC0dGDc/4xILhyH3BM7EmoB5LPj2Q4DWprMqpaJ5aYMLRY+2DeeXLsnBwlH9znjTgo3H7EmdcyxfmtI8iDmpZGt+zzBH8KiLhrBaJET
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 09:17:42.5986 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a5b63ee-287a-414d-2143-08decb881ed2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000140.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF6407DD448
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

SmuMetrics_t has no DclkFrequency field but DCLK and VCLK have
separate DPM clock tables with different frequencies at each level.

Introduce smu_v14_0_0_find_clk_level(), a shared helper that
finds the closest DPM level for a given target frequency in a
frequency array.

For METRICS_AVERAGE_DCLK, use the helper to find the DPM level
whose VCLK frequency matches the reported VclkFrequency and
return the DCLK frequency at that same level index, since both
clocks share the same level count (VcnClkLevelsEnabled /
Vcn0ClkLevelsEnabled).

The original code returned 0 for METRICS_AVERAGE_DCLK, which broke
the active-level marker in pp_dpm_dclk entirely.

Signed-off-by: Priya Hosur <Priya.Hosur@amd.com>
---
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c  | 52 +++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
index 2fe006de927a..b206a4d0376b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
@@ -260,6 +260,35 @@ static int smu_v14_0_0_system_features_control(struct smu_context *smu, bool en)
 	return ret;
 }
 
+/**
+ * smu_v14_0_0_find_clk_level - find the closest DPM level for a frequency
+ * @freqs: array of frequencies (one per DPM level)
+ * @count: number of valid entries in @freqs
+ * @target: the frequency to match
+ *
+ * Returns the index of the DPM level whose frequency is closest to @target.
+ * If an exact match exists it is preferred; otherwise the nearest level by
+ * absolute difference is returned.
+ */
+static uint8_t smu_v14_0_0_find_clk_level(const uint32_t *freqs, uint8_t count,
+					   uint32_t target)
+{
+	uint8_t i, closest = 0;
+	uint32_t best_diff = U32_MAX;
+
+	for (i = 0; i < count; i++) {
+		uint32_t diff = abs((int)target - (int)freqs[i]);
+
+		if (diff < best_diff) {
+			best_diff = diff;
+			closest = i;
+		}
+		if (freqs[i] == target)
+			return i;
+	}
+	return closest;
+}
+
 static int smu_v14_0_0_get_smu_metrics_data(struct smu_context *smu,
 					    MetricsMember_t member,
 					    uint32_t *value)
@@ -284,7 +313,30 @@ static int smu_v14_0_0_get_smu_metrics_data(struct smu_context *smu,
 		*value = metrics->VclkFrequency;
 		break;
 	case METRICS_AVERAGE_DCLK:
+		/*
+		 * SmuMetrics_t has no DclkFrequency field.  DCLK and VCLK
+		 * share the same DPM level count, so find the DPM level
+		 * whose VCLK matches the reported VclkFrequency and return
+		 * the DCLK frequency at that level.
+		 */
 		*value = 0;
+		if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) == IP_VERSION(14, 0, 1)) {
+			DpmClocks_t_v14_0_1 *clk_table = smu->smu_table.clocks_table;
+			uint8_t lvl = smu_v14_0_0_find_clk_level(
+					clk_table->VClocks0,
+					clk_table->Vcn0ClkLevelsEnabled,
+					metrics->VclkFrequency);
+
+			*value = clk_table->DClocks0[lvl];
+		} else {
+			DpmClocks_t *clk_table = smu->smu_table.clocks_table;
+			uint8_t lvl = smu_v14_0_0_find_clk_level(
+					clk_table->VClocks,
+					clk_table->VcnClkLevelsEnabled,
+					metrics->VclkFrequency);
+
+			*value = clk_table->DClocks[lvl];
+		}
 		break;
 	case METRICS_AVERAGE_UCLK:
 		*value = metrics->MemclkFrequency;
-- 
2.43.0

