Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E57D8CD6E4C
	for <amd-gfx@archiver.kernel.org>; Fri, 29 May 2026 06:19:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 78BDC10F94B;
	Fri, 29 May 2026 06:19:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HEioVHbl";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013048.outbound.protection.outlook.com
 [40.93.196.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 84CD110F949
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 May 2026 06:19:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JjSZI4cR9T0as58Bz3zvXe13+Krys1Vdh/DI/AwbIOl6C2wLbhNITD9rY2ieDH2qwoJqV9X+DMb7J/A+BK06Hwap5lU1L+GBzPuf1kH3IynPN+Itn2zCCouXwVV5zgFcK5pOtgvGrgv2n2gBXSiPbhP2VlL8dPzwaHnJksPfIVr2Ghs5gaSZQCk4oHIboaujloR01Rdpy31641WYuukHjD3LH6NouwkHZ1G0EKoswC1vIcEXNEYuAh7NQ9UJk35mNDrTIV6aKrEj5GzzUE3oQ0Qs6XSfHJPOohNGsX2ImU9fwZ/D8c2RPG2+Ge0lqpVYZRgktRw2ictHzM5oUBv+Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wfzvEneBYfhQf0Yz3ERCdxfW8tN6f0LEoMGoEkRedmk=;
 b=pNoD7XUo7wzh7l3EY62cp1L07LltDqWfi5OZKvkp0nkSfT8kOc1WtCoFMmTcbh0D1olTxlsF6rUYhqj4R4RH8GYUSGbpPvNElZB6B8S90C1iipFyMIutx6v2xcaap+OJ+t1RVdkQAIUEqocIyn3qkOXzc2JDaiK/DSIwzu98f60uiFeOWcf6Ba9V/aR2fOHeaWjTPB3mrU3A/9NjMne+QW9AWyJXL7qmExuHuLcrspdJAdtgRXvo8AeG0HhCbyUnPOpEJF8CEBk1/YSUy8CvUpfluTWT2KODrfrwKD3H3WY28ZRvOFDZS3rYguzKuVtm1Mv6Rscz6+t8EI0iEj4UBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wfzvEneBYfhQf0Yz3ERCdxfW8tN6f0LEoMGoEkRedmk=;
 b=HEioVHbllq5WOWl7UKLprxOikVrltbNYY1UWGUsUqkk3aBR9hrl/+v4tDlGGyYEmKCUduVP8/7/vquTPAzMNGYCXSXFu915QWe348armBtL2HeET6YkTcrOH/rRLi0ot+hhDofmguefZ+VLdzyEv4gAa6d9TZ/VZLVszTyy8Wlg=
Received: from BL1PR13CA0226.namprd13.prod.outlook.com (2603:10b6:208:2bf::21)
 by PH0PR12MB5607.namprd12.prod.outlook.com (2603:10b6:510:142::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Fri, 29 May
 2026 06:19:36 +0000
Received: from BL6PEPF0001AB77.namprd02.prod.outlook.com
 (2603:10b6:208:2bf:cafe::72) by BL1PR13CA0226.outlook.office365.com
 (2603:10b6:208:2bf::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.5 via Frontend Transport; Fri, 29
 May 2026 06:19:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB77.mail.protection.outlook.com (10.167.242.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Fri, 29 May 2026 06:19:35 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 29 May
 2026 01:19:33 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <lijo.lazar@amd.com>, <hawking.zhang@amd.com>, <le.ma@amd.com>,
 <shiwu.zhang@amd.com>, <alexander.deucher@amd.com>, <kevinyang.wang@amd.com>, 
 <asad.kamal@amd.com>
Subject: [PATCH 1/4] drm/amd/pm: Handle truncation in common clk/pcie printers
Date: Fri, 29 May 2026 14:19:17 +0800
Message-ID: <20260529061920.357400-1-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB77:EE_|PH0PR12MB5607:EE_
X-MS-Office365-Filtering-Correlation-Id: 59449715-19f6-44ca-0541-08debd4a4182
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|82310400026|18002099003|6133799003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: SXc5/frO0+bxLBVpeS8Gha/dYSNfAtXjYfgMfcPs4HrDxvvdq4SEcMyUZWpG6DuAmVuEYI7praeK+Hr/dGI9m2607T5Nx8taK9Fh7hnUHUtFWVMowxws+mC7EuR2mo4TPmCYX0kkPbp7bw1ZZawsZ3PMhFZcg0Z6btmlL2k/rnM0nGMtBy59fvihlXtWThB/ox9No7paeqPp1U4mUgnrOw0QYnfEXb4AZD0yNW99MkoUZF6kpwSB2n80/+N2bmvFY13yCbIw+WSY7fiE6lSa2BszXKxeaoA1NPumXg0CBXJ6dBA+oDRIC6QDw8Oatx8RCZ7myAncuQxNjuehf9EY0aO2XzwZ5aalbOwPnUfqz0cX7jIY1uKCjpRvSKHUcotUCwTW1D24dyLwm5UEsqAXFEe5FUvQHCjzKHR2rswVPcbfQS/lh9n/Xn4lnCLzqRl2G/UPD3dyPk+KjvHztSPWXTKQwtJo3zDKayKwSFBbOP84EsptDoH01XsX/H9FzZFeEKrbwIBrjEuoSYxtSSiMq2htOTSJF/2lI6heg5TcXuqDArrgiHZOkieSfoTYwgSsLJBfVc/mgcLtkK9qz7bUW8roXdB2ca4+5uqTEFibGkXy9YsHgmbYBms34iSS0SItZBx4hwKLYGw7ISiUczqaxX24jJIzKa1UdUf60+m5/4mLj7O1w7rwM+C3HeGezc2b0860l0ZuI+yFdDEs2PfSuJUA/NWl90Zkal05niA+pgY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(18002099003)(6133799003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: cOG1BopV55mPa0Z7G1+T/RTdF0gROXZ1Wr0aZPeKJ/rE1ipeqM+lj3n5c/B5eq+FxYmCVyCfqZUouxRMQ/mOJzurJ/zHn9zJOY3smYWUQzE4YcLcr0P2A0OBo1yx1OwxRFAVwfKCETRU89XbmzoXyec67djoG1WWf5k1o/KYBmIswU1JOmX/x/XyXvxwR6TvJgmfxxsFMolI8wE7cB+pOMw6Q78GSFYUkqNNKey+FQXfRssJGaZEKkrVtmHj8D5KDuB0SN5buk5G1v4iSKQ3q9d2o37tIXf9c8i+2MFRuvUT9X7gwGv+13YVKhVqrKWYQ+kNIg40CLsCkb977LPRhvqu0aDYg9CojL5w1W+159lp4lAxe26Pww3csU+CKioMUDQK8Jt4PAO6YzgZhuQsBoe4Mg2Slx5d6myiYykMFDTmhSjy3zEEHEXsgsHi8+G0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 06:19:35.7021 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59449715-19f6-44ca-0541-08debd4a4182
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB77.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5607
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

In smu_cmn_print_dpm_clk_levels() and smu_cmn_print_pcie_levels(),
use the sysfs_emit_at() return value, break out of per-level loops
when n == 0, and use a shared out label before updating offset.

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 77 +++++++++++++++-----------
 1 file changed, 44 insertions(+), 33 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index 546e64e3ba9c..0a745afa8552 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -1384,7 +1384,7 @@ int smu_cmn_print_dpm_clk_levels(struct smu_context *smu,
 {
 	uint32_t min_clk, max_clk, level_index, count;
 	uint32_t freq_values[3];
-	int size, lvl, i;
+	int size, lvl, i, n;
 	bool is_fine_grained;
 	bool is_deep_sleep;
 	bool freq_match;
@@ -1402,7 +1402,10 @@ int smu_cmn_print_dpm_clk_levels(struct smu_context *smu,
 	/* Deep sleep - current clock < min_clock/2, TBD: cur_clk = 0 as GFXOFF */
 	is_deep_sleep = cur_clk < min_clk / 2;
 	if (is_deep_sleep) {
-		size += sysfs_emit_at(buf, size, "S: %uMhz *\n", cur_clk);
+		n = sysfs_emit_at(buf, size, "S: %uMhz *\n", cur_clk);
+		if (!n)
+			goto out;
+		size += n;
 		level_index = 1;
 	}
 
@@ -1412,10 +1415,13 @@ int smu_cmn_print_dpm_clk_levels(struct smu_context *smu,
 				     smu_cmn_freqs_match(
 					     cur_clk,
 					     dpm_table->dpm_levels[i].value);
-			size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n",
-					      level_index + i,
-					      dpm_table->dpm_levels[i].value,
-					      freq_match ? "*" : "");
+			n = sysfs_emit_at(buf, size, "%d: %uMhz %s\n",
+					  level_index + i,
+					  dpm_table->dpm_levels[i].value,
+					  freq_match ? "*" : "");
+			if (!n)
+				break;
+			size += n;
 		}
 	} else {
 		count = 2;
@@ -1437,13 +1443,16 @@ int smu_cmn_print_dpm_clk_levels(struct smu_context *smu,
 		}
 
 		for (i = 0; i < count; i++) {
-			size += sysfs_emit_at(
-				buf, size, "%d: %uMhz %s\n", level_index + i,
-				freq_values[i],
-				(!is_deep_sleep && i == lvl) ? "*" : "");
+			n = sysfs_emit_at(buf, size, "%d: %uMhz %s\n",
+					  level_index + i, freq_values[i],
+					  (!is_deep_sleep && i == lvl) ? "*" : "");
+			if (!n)
+				break;
+			size += n;
 		}
 	}
 
+out:
 	*offset = size;
 
 	return 0;
@@ -1454,7 +1463,7 @@ int smu_cmn_print_pcie_levels(struct smu_context *smu,
 			      uint32_t cur_gen, uint32_t cur_lane, char *buf,
 			      int *offset)
 {
-	int size, i;
+	int size, i, n;
 
 	if (!pcie_table || !buf)
 		return -EINVAL;
@@ -1462,28 +1471,30 @@ int smu_cmn_print_pcie_levels(struct smu_context *smu,
 	size = *offset;
 
 	for (i = 0; i < pcie_table->lclk_levels; i++) {
-		size += sysfs_emit_at(
-			buf, size, "%d: %s %s %dMhz %s\n", i,
-			(pcie_table->pcie_gen[i] == 0) ? "2.5GT/s," :
-			(pcie_table->pcie_gen[i] == 1) ? "5.0GT/s," :
-			(pcie_table->pcie_gen[i] == 2) ? "8.0GT/s," :
-			(pcie_table->pcie_gen[i] == 3) ? "16.0GT/s," :
-			(pcie_table->pcie_gen[i] == 4) ? "32.0GT/s," :
-			(pcie_table->pcie_gen[i] == 5) ? "64.0GT/s," :
-							 "",
-			(pcie_table->pcie_lane[i] == 1) ? "x1" :
-			(pcie_table->pcie_lane[i] == 2) ? "x2" :
-			(pcie_table->pcie_lane[i] == 3) ? "x4" :
-			(pcie_table->pcie_lane[i] == 4) ? "x8" :
-			(pcie_table->pcie_lane[i] == 5) ? "x12" :
-			(pcie_table->pcie_lane[i] == 6) ? "x16" :
-			(pcie_table->pcie_lane[i] == 7) ? "x32" :
-							  "",
-			pcie_table->lclk_freq[i],
-			(cur_gen == pcie_table->pcie_gen[i]) &&
-					(cur_lane == pcie_table->pcie_lane[i]) ?
-				"*" :
-				"");
+		n = sysfs_emit_at(buf, size, "%d: %s %s %dMhz %s\n", i,
+				  (pcie_table->pcie_gen[i] == 0) ? "2.5GT/s," :
+				  (pcie_table->pcie_gen[i] == 1) ? "5.0GT/s," :
+				  (pcie_table->pcie_gen[i] == 2) ? "8.0GT/s," :
+				  (pcie_table->pcie_gen[i] == 3) ? "16.0GT/s," :
+				  (pcie_table->pcie_gen[i] == 4) ? "32.0GT/s," :
+				  (pcie_table->pcie_gen[i] == 5) ? "64.0GT/s," :
+				  "",
+				  (pcie_table->pcie_lane[i] == 1) ? "x1" :
+				  (pcie_table->pcie_lane[i] == 2) ? "x2" :
+				  (pcie_table->pcie_lane[i] == 3) ? "x4" :
+				  (pcie_table->pcie_lane[i] == 4) ? "x8" :
+				  (pcie_table->pcie_lane[i] == 5) ? "x12" :
+				  (pcie_table->pcie_lane[i] == 6) ? "x16" :
+				  (pcie_table->pcie_lane[i] == 7) ? "x32" :
+				  "",
+				  pcie_table->lclk_freq[i],
+				  (cur_gen == pcie_table->pcie_gen[i]) &&
+				  (cur_lane == pcie_table->pcie_lane[i]) ?
+				  "*" :
+				  "");
+		if (!n)
+			break;
+		size += n;
 	}
 
 	*offset = size;
-- 
2.46.0

