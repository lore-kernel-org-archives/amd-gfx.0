Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99D64D10F50
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Nov 2025 13:29:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4009310E5FA;
	Wed, 26 Nov 2025 13:29:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xtWHrbc4";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013067.outbound.protection.outlook.com
 [40.93.196.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C47C510E5FA
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Nov 2025 13:29:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HZKMtLsc70Pf0dnUPi4ekzZF59zGpr0mY17Acnc8oJlOYVcF4sakOYvxPM8aJGxizbjWp0e5gTy7WygiXRLU1NA0olbmhgnCzjKAS3c7SzY7Chen3EjpWms9wYmbGw6msTWXXRxovaRNKuN6u5t3wiWThNNCydd1Za+ISgHCS7oYLXCHZgfsfFZT4/um7pOGjw1CuSElAgHx8wZNouBBSPJdMGchJk5d1qTXC9tymEfuHFURuqHxRztYkqAunyFaLhBsi9Gwdi01flVmwcCqVlIsv3EBCHqdTX20+3Ve2yLVsy3/O3s4s2BIJMr6LGwup8hiwie3LYcev0OwdEbmkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QOn249WM3fR9/Z+tyxg2Xzd0Uab3SsjqMUrI8vRL+JY=;
 b=px3DNDEGi1fXslPuXi7P1FMKxCQ8HOubuwRNjJgOWRdaEdOCdsh3GQobbEyQypuRbHg1tGCxFSeC1bO2ogFMfSUm9KIZFJwWgvGrcJDsjfnFjrog+qgrlP/iLX8/kLvTERbILjhx00SpGeGHU+NNpg2VbXs2kn0ARiWFiV5Xw+/olndWT3ONfGKaUuwF2t8BK/gcsKUHgjeBH9ejiV1p7CXzC3zuIPs9xiZYU2Ab19i9dXulWChq9omODsAObdG2Kx3tOKsm/4UoX2uGlB9XSkSkIu+wAjtv9JURdje67BB/SJWiuziyGQvbGlGKZxNAzxPXpwYiOf9HjZl/c4gJgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QOn249WM3fR9/Z+tyxg2Xzd0Uab3SsjqMUrI8vRL+JY=;
 b=xtWHrbc4XeZEPzIwaAJk43ACDe0zm04MOKTWMsf0jnf4+vpMyuo2Ml3AG1tWLAOAp3TowblNxW78RvS8PGqtO0Q6fiZ2SyY5W7nzxlCbAsa7Dh+IiOy5s2C4STouVBzm9lJxyD5VQwXBiVu9z3EEtxJsvFajYmhkNJhTBbKdddM=
Received: from SJ0PR03CA0293.namprd03.prod.outlook.com (2603:10b6:a03:39e::28)
 by MW4PR12MB7144.namprd12.prod.outlook.com (2603:10b6:303:21b::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.12; Wed, 26 Nov
 2025 13:28:57 +0000
Received: from SJ1PEPF00002314.namprd03.prod.outlook.com
 (2603:10b6:a03:39e:cafe::e8) by SJ0PR03CA0293.outlook.office365.com
 (2603:10b6:a03:39e::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.12 via Frontend Transport; Wed,
 26 Nov 2025 13:28:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002314.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Wed, 26 Nov 2025 13:28:57 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 26 Nov
 2025 07:28:55 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <Jesse.Zhang@amd.com>
Subject: [PATCH 09/20] drm/amd/pm: Use emit_clk_levels in SMUv13.0.6
Date: Wed, 26 Nov 2025 18:53:56 +0530
Message-ID: <20251126132822.3266730-10-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251126132822.3266730-1-lijo.lazar@amd.com>
References: <20251126132822.3266730-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002314:EE_|MW4PR12MB7144:EE_
X-MS-Office365-Filtering-Correlation-Id: 687b9669-1170-4837-8dfc-08de2cefc0bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BUv3RDxWl9xUm0QqMcrZME0Yt8+YjjjRr4IpGzu0xUCYIQbhrkEXf26L8/jx?=
 =?us-ascii?Q?WUu6AbjogrOq9QrNo+Gamh9F6HY9ci8CfVIdQLr11vdfF/uyBSbry2wLg0ft?=
 =?us-ascii?Q?0N94VDpTEgKU3asGp1dpyvxWFA5WLkh/w+/HoajGvDtnZdOk6AdajVHIPhoH?=
 =?us-ascii?Q?tS8w9+54Yi2BVxYKOW6mO4id8IY7/Fi0G1V9tf8QhMahgg9BCLHUMHU76X3v?=
 =?us-ascii?Q?GE5d7gDi6HuOZ59sECdVEcuM7a5y8Xfr9kIXKUmaV2wsU/dwDmbfHzgO47sW?=
 =?us-ascii?Q?mwyX0vtoDEELXvIC8VZS/p5l/+DI6doKFBF10SVyEtHiHItqk8CeKU+yapkJ?=
 =?us-ascii?Q?pVGsh0EvRlRuZMnAxhwUGqYc/sdpGWVHHltUXsudf7/4u2jDjW7p5ZjPU+3i?=
 =?us-ascii?Q?Sxf3Vo172kpkq94KDHnIVIxMsDWz8dD/NGTh/nw/585dr7rKV/P+v+b7v6f0?=
 =?us-ascii?Q?YsC4s3Ep4WfswZMA8FoTTtY8V0YuQoCUKpK6ChxII38Pnsm8WHwh73KOSath?=
 =?us-ascii?Q?DQsCCHakKX+QBdYhYvRpwoTzqdKQXtT2NIhKovaxSTIwDr7/0WHPekhR5XWC?=
 =?us-ascii?Q?cdzmoc85WsHV46NPQSakURLWceuqHZJyl3M6fkgEHFSOydYjokMzWAiwnsGp?=
 =?us-ascii?Q?/iqMAMsBFJNO+UFan+7uZnQi8meROemveb35i/fFO9kJ8qeAtLxOVcSuXCWZ?=
 =?us-ascii?Q?2a+FWTvgsJ/3F1mv+jOvsNsznxEpzFuidBFVlTiNPlnDVuVtk18uzHY07IhY?=
 =?us-ascii?Q?5TycCw+YDa5CddHR6StOmaVUnhY8gCdKfrKM92qJnU2faMGu+86cfAhRFmCH?=
 =?us-ascii?Q?NMGxTfRUeLY81G7CWj3xFqTYGNq1t9wF8ONhC3jO1YH85rsjhnM+WfwvR8sl?=
 =?us-ascii?Q?SRezmNwdhvPHyOROL4Ga7K7sXXCa2KMQKtOrwn4cPDSA5gGANVhNHF+HpXvX?=
 =?us-ascii?Q?9HI0gj/aZuTwIxVzqRFS3flnToUff6CLcW6ahlD5+uXcbkOE5ibER2GA9OsX?=
 =?us-ascii?Q?I+HJIcATD7NcOTTk63DG2kuMXslH4H/xITTrWngvGM1KgmDf6eLTn8ZkyUgV?=
 =?us-ascii?Q?IB768y21+b338nrHrsp88LxREYOPXyD5l8C1HnGBey6Bolo/6L5r1ph3hszW?=
 =?us-ascii?Q?N64E5uWn7mTvIesW+Cwws/rQSx5xCJm6IdN4JnZqZDePPtnOgft+bt1dVd8x?=
 =?us-ascii?Q?z/8//KmdSJiMlLECP3+/E00u0zeAfCpDJqmGwbwNGNPx68aPM5NEI2Rk8ZRl?=
 =?us-ascii?Q?rbWhyYZUlPMQ5IwJEvqAEDqxOobosZYNWkmH9OHrmNMBATq2onCP7brK4s48?=
 =?us-ascii?Q?/LpGTnz9x0f8ZjZZMZCBzPFqZlDM1eulkPfWhO/cezADv0fRfSzF9GyJsCGv?=
 =?us-ascii?Q?HTLowtF8d+o563SIhJJgZQt8/vREaorClUv4QeqHI3n9CIxPkgYuYvco+IQB?=
 =?us-ascii?Q?TfYDd+Y/hb5EmseZzakiwMvIsbDg9nqwoIo5rd8tvq0L/gWpK7z2lgR3YkTl?=
 =?us-ascii?Q?T4yStKsyfL4yc+NMGgls9f2vKjaN5HuqCXxO2m7bXLGUYlH8kj/hgoafIhpn?=
 =?us-ascii?Q?CKlmGMpGUvinVfo6wmo=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2025 13:28:57.4396 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 687b9669-1170-4837-8dfc-08de2cefc0bf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002314.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7144
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

Move to emit_clk_levels from print_clk_levels

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  | 30 +++++++++----------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index a3ceecbe5d68..7ba299d5d7ca 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -1453,10 +1453,11 @@ static int smu_v13_0_6_print_clks(struct smu_context *smu, char *buf, int size,
 	return size;
 }
 
-static int smu_v13_0_6_print_clk_levels(struct smu_context *smu,
-					enum smu_clk_type type, char *buf)
+static int smu_v13_0_6_emit_clk_levels(struct smu_context *smu,
+				       enum smu_clk_type type, char *buf,
+				       int *offset)
 {
-	int now, size = 0, start_offset = 0;
+	int now, size = *offset, start_offset = *offset;
 	int ret = 0;
 	struct smu_umd_pstate_table *pstate_table = &smu->pstate_table;
 	struct smu_13_0_dpm_table *single_dpm_table;
@@ -1464,12 +1465,9 @@ static int smu_v13_0_6_print_clk_levels(struct smu_context *smu,
 	struct smu_13_0_dpm_context *dpm_context = NULL;
 	uint32_t min_clk, max_clk;
 
-	smu_cmn_get_sysfs_buf(&buf, &size);
-	start_offset = size;
-
 	if (amdgpu_ras_intr_triggered()) {
-		size += sysfs_emit_at(buf, size, "unavailable\n");
-		return size - start_offset;
+		sysfs_emit_at(buf, size, "unavailable\n");
+		return -EBUSY;
 	}
 
 	dpm_context = smu_dpm->dpm_context;
@@ -1546,7 +1544,7 @@ static int smu_v13_0_6_print_clk_levels(struct smu_context *smu,
 		if (ret < 0)
 			return ret;
 
-		size += ret;
+		size = ret;
 		break;
 	case SMU_SOCCLK:
 		ret = smu_v13_0_6_get_current_clk_freq_by_table(smu, SMU_SOCCLK,
@@ -1564,7 +1562,7 @@ static int smu_v13_0_6_print_clk_levels(struct smu_context *smu,
 		if (ret < 0)
 			return ret;
 
-		size += ret;
+		size = ret;
 		break;
 	case SMU_FCLK:
 		ret = smu_v13_0_6_get_current_clk_freq_by_table(smu, SMU_FCLK,
@@ -1582,7 +1580,7 @@ static int smu_v13_0_6_print_clk_levels(struct smu_context *smu,
 		if (ret < 0)
 			return ret;
 
-		size += ret;
+		size = ret;
 		break;
 	case SMU_VCLK:
 		ret = smu_v13_0_6_get_current_clk_freq_by_table(smu, SMU_VCLK,
@@ -1600,7 +1598,7 @@ static int smu_v13_0_6_print_clk_levels(struct smu_context *smu,
 		if (ret < 0)
 			return ret;
 
-		size += ret;
+		size = ret;
 		break;
 	case SMU_DCLK:
 		ret = smu_v13_0_6_get_current_clk_freq_by_table(smu, SMU_DCLK,
@@ -1618,13 +1616,15 @@ static int smu_v13_0_6_print_clk_levels(struct smu_context *smu,
 		if (ret < 0)
 			return ret;
 
-		size += ret;
+		size = ret;
 		break;
 	default:
 		break;
 	}
 
-	return size - start_offset;
+	*offset += size - start_offset;
+
+	return 0;
 }
 
 static int smu_v13_0_6_upload_dpm_level(struct smu_context *smu, bool max,
@@ -4020,7 +4020,7 @@ static const struct pptable_funcs smu_v13_0_6_ppt_funcs = {
 	/* dpm/clk tables */
 	.set_default_dpm_table = smu_v13_0_6_set_default_dpm_table,
 	.populate_umd_state_clk = smu_v13_0_6_populate_umd_state_clk,
-	.print_clk_levels = smu_v13_0_6_print_clk_levels,
+	.emit_clk_levels = smu_v13_0_6_emit_clk_levels,
 	.force_clk_levels = smu_v13_0_6_force_clk_levels,
 	.read_sensor = smu_v13_0_6_read_sensor,
 	.set_performance_level = smu_v13_0_6_set_performance_level,
-- 
2.49.0

