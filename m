Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F9CECD98D2
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Jun 2026 11:42:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 33BA710EE9F;
	Thu, 11 Jun 2026 11:42:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pc8iTNdX";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011048.outbound.protection.outlook.com
 [40.93.194.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9875C10EE94
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Jun 2026 11:42:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pc0vvf7c/QSDb9k2o4wc7qa9pFcRs0MhOlOzisE0DMh6xvEccxN9T68PbUCfC41EznOBYKwq98TFDHVTlvB5+CrnPzwFZjC3yEpVR72IpTWppmxM6UTDenliYtu8zdDz0bAKIMdLqOkJjnqYhSKsCaJXM8spOVjnajEUS/bpM1zbE97xVz/A+0PCr/4Cg68uud6YbLb/a3oG4YQE2TbkCP9sP6rPuxGGeJLwSd0pHtpVkZ+/c5vd35hE+3CAAzbCPDAT/p7G1OmEzNzxziDZmg6g158r4OE2FNlAipakJZqrp/auWlVVd/8cdsQBPl7LFFr8G2tyEE/3II58e/X5bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yI6wZOzd7bCS12xFSVAtQ4cXTzsegNCRaJ9XGhD28CI=;
 b=EuGUX9iv/a+TAFzvaYMde4GllVSnHBjzJLc6j11nzBEa+odp1JsbxKOdDvF1rxIVJOqK564UaReFFM9+DU8PrDYUgk+T5xNPDhBSpZcCr4R9HcPP8jb0mZaYHCDlPT9bJqNluQNVer341xukezU/ed+ShY22/RaYDDjNFKKzYzxqAADw1nNTRoUIaXMZwc2ixLY1/nJOYgierzPZsITqSzrD++kCuZIxM8FzyD59bwMTEAHswtSNg9G1qnh0/IhMc5bgDjze0MALOlrolp5uNnO+MRoN+1jEXRKzWLSxpEx4fsA1IU6uqVv+DKVTwtewThAFmShxx94EYoWv0h0w5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yI6wZOzd7bCS12xFSVAtQ4cXTzsegNCRaJ9XGhD28CI=;
 b=pc8iTNdXvahEoazCC67O588JuSt8cMezvrbvrygU3eSjHBynXF77uGPeE4IubQVNtCaq6//HAVVb6Ve1GisbksyjESP9pR4boNvalDdPZuvhlZC4JIHJtE4YigCNo7HYDdb5xiha2VAHKY/arKuuuk4cQIRBoGyVGULHti5p5vw=
Received: from PH0PR07CA0105.namprd07.prod.outlook.com (2603:10b6:510:4::20)
 by MW4PR12MB7216.namprd12.prod.outlook.com (2603:10b6:303:226::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.9; Thu, 11 Jun 2026
 11:42:17 +0000
Received: from SA2PEPF0000150A.namprd04.prod.outlook.com (2603:10b6:510:4::4)
 by PH0PR07CA0105.outlook.office365.com (2603:10b6:510:4::20) with
 Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.11
 via Frontend Transport; Thu, 11 Jun 2026 11:42:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SA2PEPF0000150A.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Thu, 11 Jun 2026 11:42:17 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 11 Jun
 2026 06:41:56 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 11 Jun
 2026 06:36:55 -0500
Received: from rtg-MAPLE.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Thu, 11 Jun 2026 06:36:52 -0500
From: Priya Hosur <Priya.Hosur@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Lijo.Lazar@amd.com>,
 <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Mario.Limonciello@amd.com>, <Kenneth.Feng@amd.com>
CC: <Pratik.Vishwakarma@amd.com>, <Veerabadhran.Gopalakrishnan@amd.com>,
 <Priya.Hosur@amd.com>
Subject: [PATCH v3 4/4] drm/amd/pm: smu_v14_0_0: add closest-match fallback
 for DPM level marking
Date: Thu, 11 Jun 2026 17:06:15 +0530
Message-ID: <20260611113628.3217-5-Priya.Hosur@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260611113628.3217-1-Priya.Hosur@amd.com>
References: <20260611113628.3217-1-Priya.Hosur@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150A:EE_|MW4PR12MB7216:EE_
X-MS-Office365-Filtering-Correlation-Id: 9537adac-60dd-4216-f659-08dec7ae7d5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|82310400026|36860700016|1800799024|18002099003|6133799003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: VuYjcEO2ouapfsacRAbdH6m2B695jO0FAHlaRYH+CPyxD1NIeBvvC/HyPFBSE/3c0b8WAwVAQm/g19ODqjaT9TTCoftUovmOxGqLtkySBYGmvWDWgGHxU+f+JcvVpogFxEdFGwIb+YLpgTL72O526ZrKXdI9fvK7NXM9IPzOfvR+dkuU+z3UTONVUVtoq8kXQ1OFg59pn09DDxuui7109D2CMWue920sYadTtoZUQflE0VhmgTbwTgD8uXogp7k0I7ThIU5PlzC5H1JbxH4aZha4LjbiIwlcVSICh0U5pWcAiNwVpLxZQBfZxllHhbN11VWwxRHR3bg4w2YfW58AExWBBhHiOAFQct+7edA3xIXYgcl0kWUxshE/gJouJoeidF8DAo5lqh39YN2iiCNKhsA/M9qQgZF2eI9rZW8X8ymjVo/CrBwxq5fhWJvczwCl2HJVKvX4EYvbMhgMNLjgfoQrN7qiHDQfnTd0ZY5vDVRoSZOMojWXIE9JNTgm1sBvh8STLlAA92IhGzX0K+CJxuWRtVSYEVtfomgNfhRL6vLmYJgmrQzXf0911M4M779+JAv2x3pm4STLs8utHbYnMB38dICG0INmpndrTYlrj9sOqVvumtkI05zsmkewtP6XsgxZbaN62s43uMsJ2C9r1IkQdbgA2n+20xDXteLRH8ESdzt/PNpKMXy0zFL8Nqkt/da6nRd/0fBjDa/fB604MuBkhjufqoJk6kih36Q/4Ms=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(82310400026)(36860700016)(1800799024)(18002099003)(6133799003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +6rCclaSSqZM3EeBL3T/EzqqkLUzJ91xIKekVZT0JwxncEaaKQ2M8CUzy4njk9EpURMOAbMt8OKPETbphnVX8j8tNzfzJTKZAZIefDRQvfn+c6XKn741Tfwg6R4DsWMMTii2S8zN5lRdmnonWZNK/2ZV/D40nJsxgkJUHxclyeWl4k2YzIdg5/Z511eQCLTgaJFFvwWnMvnLaC26egSNFY01HxvrxprSH3myWoJFGJnkuLfnKnlekeG9yt1GUDKkENqJ0/TqLll0Km1QMIOAD3uGH4b1/OjaLJl2fmZsbOwAuxzctfqCFV796XzGuooh3zHU75S9BZjYum9fAL5tt9IG9VeIc8ZOZE2He11XIQynvfR9xEY+FfjM66pNmZ4tYQdDMxvsRnotAtVtccRASafp/xECvtf+fubm512R2UK+UsjT4kb1dN1F7mtz6+mz
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 11:42:17.4289 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9537adac-60dd-4216-f659-08dec7ae7d5c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF0000150A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7216
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

Replace the simple exact-match loop in emit_clk_levels with a
two-pass approach: the first pass checks whether the current
frequency matches any DPM level exactly and also tracks the closest
level by absolute frequency difference. The second pass emits the
levels, marking the exact match if found, otherwise the closest
level.

The SMU reports time-filtered average frequencies that often do not
match any DPM table entry exactly. Without this fallback, MCLK,
FCLK and other clocks show DPM levels but never display the *
marker, breaking userspace tools that rely on it to identify the
active frequency.

Also uses reverse DPM index for SMU_MCLK since MemPstateTable
stores levels high-to-low.

Signed-off-by: Priya Hosur <Priya.Hosur@amd.com>
---
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c  | 46 ++++++++++++++++---
 1 file changed, 39 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
index 4469048d966e..1c11e74072d3 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
@@ -1194,14 +1194,46 @@ static int smu_v14_0_0_emit_clk_levels(struct smu_context *smu,
 		if (ret)
 			return ret;
 
-		for (i = 0; i < count; i++) {
-			idx = (clk_type == SMU_MCLK) ? (count - i - 1) : i;
-			ret = smu_v14_0_common_get_dpm_freq_by_index(smu, clk_type, idx, &value);
-			if (ret)
-				return ret;
+		/*
+		 * Try exact match first. If the SMU reports a time-averaged
+		 * frequency that doesn't match any DPM level exactly, fall
+		 * back to marking the closest DPM level.
+		 */
+		{
+			int closest_idx = 0;
+			uint32_t closest_diff = U32_MAX;
+			uint32_t diff;
+
+			for (i = 0; i < count; i++) {
+				idx = (clk_type == SMU_MCLK) ? (count - i - 1) : i;
+				ret = smu_v14_0_common_get_dpm_freq_by_index(smu, clk_type, idx, &value);
+				if (ret)
+					return ret;
+
+				if (cur_value == value) {
+					closest_idx = i;
+					break;
+				}
+
+				diff = abs((int)cur_value - (int)value);
+				if (diff < closest_diff) {
+					closest_diff = diff;
+					closest_idx = i;
+				} else if (diff > closest_diff) {
+					break;
+				}
+			}
 
-			size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n", i, value,
-					      cur_value == value ? "*" : "");
+			for (i = 0; i < count; i++) {
+				idx = (clk_type == SMU_MCLK) ? (count - i - 1) : i;
+				ret = smu_v14_0_common_get_dpm_freq_by_index(smu, clk_type, idx, &value);
+				if (ret)
+					return ret;
+
+				size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n",
+						      i, value,
+						      i == closest_idx ? "*" : "");
+			}
 		}
 		break;
 	case SMU_DCEFCLK:
-- 
2.43.0

