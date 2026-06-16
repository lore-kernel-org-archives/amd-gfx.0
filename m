Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30F3ACD98CF
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jun 2026 09:18:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB4CC10E983;
	Tue, 16 Jun 2026 09:18:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DWV9/pNC";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011047.outbound.protection.outlook.com [40.107.208.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EDCF010E988
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jun 2026 09:17:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ou4FWJMyI7O5hLjrV7pd9srXF6EADTjYOxOHUihx+WrSe6K5DQJO1pa2vPi5a2Po6/7BkKyX6yoRSwakHCqIFYjkTEblseKMmEjL73aSZSyFqYJ36KZjD65ga7rCrRjlLFZNZTsS6cQp0UdRR02aT2+e/SOr5SD22NK+Q1tYrFdswmvwHvYKLrxfvC1g1oW6W1YLWc8ivKmGScrvPElZQmrnj6vrDxOI0qOTYnWiPlR5L3UEwb9WHiUQK/wa7i391h1KXvHr6/gzgI/ItJxHI3T0x+osDrQc6d91GsVBXgAwql01HgHrViKrR6WSk4egmaSt7Al/k7RPVCP7gG1YYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p8XXgSZZMxzC9TX4+PFlejGMK22cLrFxKZMRfScQyLA=;
 b=lLV5kWRbNEy+TTrTUnM2iQWUsvpsRor3fVQ2EKkiH2amgKKe/mCVoDR7FgjVFi6jHemGBB6ejHD+5PI8kqqlCFDajRPSAhDmFkXuQEYI96jJGlxnr8wbRDWsY7GOka1Y2Dhm8u8GsYsJn0/nb34H5yps72twaxJtmpFULZxkUfcSnGjJI1k92j+BZ3sp2lv7oFuSQC3jaqe1+IK4iUZQ6SYUlrUVvWFLGFTeDcwTfrviE/mVS1wWoG4PtZWNL0KaeKBGHuMAFvGWgATMkMcmo/I3DpROP4IDQ/zw6gEF9iF2WBOhr2T0CbC37KInBw0LuYC7rcoL+6ZmUD/BxX9dxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p8XXgSZZMxzC9TX4+PFlejGMK22cLrFxKZMRfScQyLA=;
 b=DWV9/pNCuZweCx0zoN1Sbm3mcrIDv8JaMpyXetT3fUGBO595xcgaUDEUNJIEhaERORpU62darODCejwOTtpC2QUCT4QFcdiCQsYHkoVmnPpUHjRIG49Sx7r/Wj97hwdi8pw83WDbLBFPNLGjUdF64dfPQXZTShSmCu2HOd+nTig=
Received: from CH2PR15CA0005.namprd15.prod.outlook.com (2603:10b6:610:51::15)
 by PH0PR12MB8049.namprd12.prod.outlook.com (2603:10b6:510:28f::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 09:17:56 +0000
Received: from CH2PEPF00000142.namprd02.prod.outlook.com
 (2603:10b6:610:51:cafe::4a) by CH2PR15CA0005.outlook.office365.com
 (2603:10b6:610:51::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.18 via Frontend Transport; Tue,
 16 Jun 2026 09:17:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF00000142.mail.protection.outlook.com (10.167.244.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Tue, 16 Jun 2026 09:17:56 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 16 Jun
 2026 04:17:56 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 16 Jun
 2026 04:17:55 -0500
Received: from rtg-MAPLE.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 16 Jun 2026 04:17:48 -0500
From: Priya Hosur <Priya.Hosur@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Lijo.Lazar@amd.com>,
 <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Mario.Limonciello@amd.com>, <Kenneth.Feng@amd.com>
CC: <Pratik.Vishwakarma@amd.com>, <Veerabadhran.Gopalakrishnan@amd.com>,
 <Priya.Hosur@amd.com>, Lijo Lazar <lijo.lazar@amd.com>
Subject: [PATCH v5 4/4] drm/amd/pm: smu_v14_0_0: use find_clk_level() for DPM
 level marking
Date: Tue, 16 Jun 2026 14:47:31 +0530
Message-ID: <20260616091731.3722-5-Priya.Hosur@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260616091731.3722-1-Priya.Hosur@amd.com>
References: <20260616091731.3722-1-Priya.Hosur@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000142:EE_|PH0PR12MB8049:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c2dd651-9e92-46a4-430f-08decb882702
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|23010399003|1800799024|6133799003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 1ysxmgDiQ0ANd0dOXjJrFi05shWSORhCp9Jfx7XmaZn/RjxdLwubrWEUVQDOuCVlvbG43YdIvYQTP7yIZ/bOMJyxYAlGeqvHUJLBwS5mqIN0A8pv/FdjtPWd8ZfgqNZUFJMZ+68iLde+bgom/gdDdG0gs+IwEEa0EsRUy4rbZ7exBrvNeDg8dZ6kwM0yM1gWixM12hWuN1tC4lXqZvKKytUyVoqgsS9wB0FRF8JfAVSTHrWqHIvvDCImB20LzTJBwZj8Q6rFrExhi8xPR7QatA+4vkIrAgRE2m8RKZeeo+bMgclaiyku39PtaVj8qMqix0zh1SecxdrDs1g0AsYAcoDX/PDSbSF61+rGxbpjKgH/MGGD58gBYthmgWbDJ+3GaAHKqX+IQR46EQXRvio4NodOaMTb71XLUNtbCOHiHqPMwLF8evhocURO+wybBVJAJ10Y5e9zjDW3wznHWaFSAOEJUA0PFHzhA6wtLLCz9hwhtpu8abVHCTuEV5URJ3Uv8+vATkNQD+2vQ6fK+g8np9boBpI382VFCzJcP7ZDEwL5pXdYjmI4iwQJJE1tBj1x/yNjFi/edY0fghmeOsdt6uPH65HajwhPEfyShzarRqUNCSVtiCYAo8kWC61spjlSm6d0eO8O0eELkfl6bQepGuk+p08HWJGWzEu3f5iQx9F3gMdlbPzHbZ7W9f/hE5CIG8P/JILZOXTelorDZ0McsX9TDiG4OoaNxSlz3iz6EXg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(23010399003)(1800799024)(6133799003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Ee12ThnBl+TOVmAqEQ7M4h7giNeOmRyUd/M7GEI0gOv6ybJWPJaXdf3PblralEBCpF7XJ0kQkfL3Tzg1yaX/XqUFVu3h45FnWeGVw4aVHPW+z//y6kM2vvF4/t25AVBWilEed4c+wj4isPT/5L8xjgpWDrOwjRLr3eDa37w+9r/zxBQvoqddZA6+crcqaGbIGyA5M3pKSdTh7pcG49qjjcioPRQCcX+vxg6kJ8HKvekp2PpwhGCkh3AMcqHgIeGV6OnLqTRDzInCxbXbkKBfiVqs9/gBlBIwjHHn62OsG4ah1mc5bmvfJUrAKFbOgY7qCMea5tCT/n91bWtIe9b1tOriEdysa0tspWTxiQgc8CpXSb799RNHIEk6FCkvFz+C86ozjBxCo8xyCvRCOix/yiUqZPLvD4AMMtFp4sRqwCmn8yaRvluaSrsqL9sRoAzM
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 09:17:56.3295 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c2dd651-9e92-46a4-430f-08decb882702
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000142.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8049
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

Replace the simple exact-match loop in emit_clk_levels with a call
to smu_v14_0_0_find_clk_level() introduced in patch 1.  The helper
already handles both exact and closest-match semantics.

Build a stack-local frequency table from the DPM levels (using
reverse index for SMU_MCLK since MemPstateTable stores levels
high-to-low), then call the helper once to find the active level.

The SMU reports time-filtered average frequencies that often do not
match any DPM table entry exactly.  Without closest-match fallback,
MCLK, FCLK and other clocks show DPM levels but never display the
* marker, breaking userspace tools that rely on it to identify the
active frequency.

Signed-off-by: Priya Hosur <Priya.Hosur@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c  | 29 ++++++++++++++-----
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
index f273b95928c9..9efeaedbe317 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
@@ -1243,14 +1243,29 @@ static int smu_v14_0_0_emit_clk_levels(struct smu_context *smu,
 		if (ret)
 			return ret;
 
-		for (i = 0; i < count; i++) {
-			idx = (clk_type == SMU_MCLK) ? (count - i - 1) : i;
-			ret = smu_v14_0_common_get_dpm_freq_by_index(smu, clk_type, idx, &value);
-			if (ret)
-				return ret;
+		/*
+		 * Build a frequency table and use find_clk_level() to
+		 * locate the closest DPM level.  The SMU often reports
+		 * time-averaged frequencies that do not match any DPM
+		 * entry exactly.
+		 */
+		{
+			uint32_t freqs[NUM_SOCCLK_DPM_LEVELS];
+			int active;
+
+			for (i = 0; i < count; i++) {
+				idx = (clk_type == SMU_MCLK) ? (count - i - 1) : i;
+				ret = smu_v14_0_common_get_dpm_freq_by_index(smu, clk_type, idx, &freqs[i]);
+				if (ret)
+					return ret;
+			}
+
+			active = smu_v14_0_0_find_clk_level(freqs, count, cur_value);
 
-			size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n", i, value,
-					      cur_value == value ? "*" : "");
+			for (i = 0; i < count; i++)
+				size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n",
+						      i, freqs[i],
+						      i == active ? "*" : "");
 		}
 		break;
 	case SMU_DCEFCLK:
-- 
2.43.0

