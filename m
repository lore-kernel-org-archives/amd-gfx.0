Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB4D0CD98F1
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jun 2026 11:45:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 61BCB10EFC2;
	Wed, 17 Jun 2026 11:45:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZWZueONg";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010001.outbound.protection.outlook.com [52.101.46.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05F7310EFC2
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jun 2026 11:45:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GOYu7HrhcCEh3piJ6yXjx84G+Yby3rx9w6UgmvMrJU2G2kIkIIf5Bq74H2OaDXDvgA3FqOlOcjK7e1evv4h2C336InzVx+8d80XFpibF760tLvJIosIfRAWuXTV9ryok/CW1L7QI/eqHS2UL1Ky9MxzUfKuJDUlCWys52iMrXRjTjJOI2FMbDpPUsW2KtoOrYI/GhsTUymE0IgUhvCsT6Ex4D7HM3upYoAk2gwrzvMFkfxdcVqpxJmoIRWX3kkS7O/ezoDqXpSTSkDIuxfPy6wGtzhkkONz/2UhgU0qn93JKPHLbwgrVL3TdJg90JxXSKIE2Dzy4OLKQEYPSM9cQ0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p8XXgSZZMxzC9TX4+PFlejGMK22cLrFxKZMRfScQyLA=;
 b=yfuhDEBTnrWmZwCvCF7YMfuK1WIVV5zm7IWwd2krqbl6IYeAF7Z5tgSXZ/fRBN95u/YC1Q3DLFh9Ds8crb+yrQWlw62ieHS9rpDPIACm20IvyfcZhmXbF8xyfsG8RsflWl/kkmep7ANsu+7DLkF+DZDk8+66rI0zoQE0lT4aJe3Otdtkm/4kCLBm93/nrQFVYin1/xg8RwKsqRmgawfdtx0BDtrEywcTHaDLLy5CBx7NlQXwHT3gQQD7r70LYz8DAVqlUamEX13Fa1BKwrLnnfLKv3nHFHCT8CRbnSFxWAJA9lDlxvMrZtHtXAGmB0gpCZv8VA1jP/ZMJTowTWO7vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p8XXgSZZMxzC9TX4+PFlejGMK22cLrFxKZMRfScQyLA=;
 b=ZWZueONgm8Q9mMixmvlkyTOkbwVgsPwHIogI6ZeyTPmu+3UONxfIL3coEKpe/JFtmOVcl599H8RHq6WAInHMDmoLG7TFAwOgdUW0aNiY+3rsZsOY75xX66VWVq0CeCdVE2YrQPygzxVJ6AaAO1OKphjewKjx5PJ9DEiOMW5E1mk=
Received: from BL1PR13CA0069.namprd13.prod.outlook.com (2603:10b6:208:2b8::14)
 by IA0PR12MB8863.namprd12.prod.outlook.com (2603:10b6:208:488::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Wed, 17 Jun
 2026 11:45:51 +0000
Received: from BL02EPF00029929.namprd02.prod.outlook.com
 (2603:10b6:208:2b8:cafe::ac) by BL1PR13CA0069.outlook.office365.com
 (2603:10b6:208:2b8::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.11 via Frontend Transport; Wed,
 17 Jun 2026 11:45:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00029929.mail.protection.outlook.com (10.167.249.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Wed, 17 Jun 2026 11:45:51 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 17 Jun
 2026 06:45:50 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 17 Jun
 2026 06:45:50 -0500
Received: from rtg-MAPLE.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 17 Jun 2026 06:45:42 -0500
From: Priya Hosur <Priya.Hosur@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Lijo.Lazar@amd.com>,
 <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Mario.Limonciello@amd.com>, <Kenneth.Feng@amd.com>
CC: <Pratik.Vishwakarma@amd.com>, <Veerabadhran.Gopalakrishnan@amd.com>,
 <Priya.Hosur@amd.com>, Lijo Lazar <lijo.lazar@amd.com>
Subject: [PATCH v5 4/4] drm/amd/pm: smu_v14_0_0: use find_clk_level() for DPM
 level marking
Date: Wed, 17 Jun 2026 17:15:42 +0530
Message-ID: <20260617114542.14675-1-Priya.Hosur@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00029929:EE_|IA0PR12MB8863:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cb9be90-788f-4afa-5235-08decc65fb62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|23010399003|1800799024|36860700016|18002099003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: wmxCG0tMIRY3QBkGL9sBlK5xq43GarcMA/Jpnu3r5CByOXmuA1Slaz7qATfN7GFdEgmsh0Z94Sic9QvttBTk3ENka1GgXIHMaDsSYdrM3NZNV+OQyTmte/VQ39SLpH1SPrD92Fs5Ua5c4BYhVT4zZAjPTVMvxp4UDKHZ0EuOp9ptb6tH2fTUBFjnkF352LtaIY5ro/Zqe0rSgXr7GGHhOHI+dobQRSeZ5LRlL0eShRI86U+IyHqTC7rLyyKp/ubUTjGkkfSMVbYYXBD3BsP6Wx7cMPgSj6+zNBJ/4i2hqP0ZEsTrIAF9pcdl/qVfM4LAutrk3wkuIzL5qSYr5QCKGO4LpEtEwolQvoUg37+5gtIv+ZQWdLG8mNBRzwp5hXsNXji/SMcpxnrkay6l7RprdvFYUFJhExN9wAacGLi1soRXbw6bB0xFO6b3eTRTEa/onWa04lifeyrxcDIxogtC24yc+lwqSiVKn5CYkOmGRNW7/5l916BiX76kW0ttFPpc1dzN7eQs6Od77sP5fFqXNUx2PyA3kmrOJmWeCsq2NJd8ljRNHsLFxhdKEBs77NnvGGi1LLlhvDDsFMwYAwgAYKjXcnDb+OE/KuHpUQIt8C3e4yJEulUdbBdJ9FTouNclfnmdsu8tkvTa1TQwS0fPbVWsvnDk+z4RFfOGh3NTs1K66kQ7FkA3xswubELPRrYK2AYkI1WIGLDQ5P4ABENQ0aHMBtGj3yrq3xwtnhRaz3o=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(23010399003)(1800799024)(36860700016)(18002099003)(11063799006)(56012099006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: FdiG22KuCzyCZBAg4wwiStOGOYe6dlG8XYeROsEB4wr4mTv+qIdXL63Fs6jKfsqzX3zT4OX/qfWVoUGSBJEaSafPeaLsJWf9yDUu6GB+6f4/Ck6purywQyVdVOfNq78uTFqv4gAp1krdRRIamSSIcyQztYjy9Hx0AekkVU/gnjhx0Kpng6p3D02nnUcMDXi+ilAeTc580iaZCT0CsOqy/PV15DVHUd/BFUfxryWKMGuXo8itAOd4YidyXIiEVgAVswSHp7c1PvZM3nzb9hUnOA+aS7BIEh0imqPgmsxhIBpEnX0G9c4cIEsBJcMl17GYRbWpzB4nzY7ZS0pOZT3yd4Bl1cg4lLusiYyD4HZUXQEHzPf5Xuk5wRv6YRqdzxJEdHbjfHGelaQYG0Ptgq5XrTSyXJOYbhjlUo5Itz8pnJVwXetG6XM4h70qJY/asi+f
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 11:45:51.4051 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cb9be90-788f-4afa-5235-08decc65fb62
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00029929.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8863
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

