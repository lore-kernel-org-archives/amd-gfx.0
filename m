Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6B43CD98F0
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jun 2026 11:31:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7841310EFB9;
	Wed, 17 Jun 2026 11:31:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VJsjTkcC";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010020.outbound.protection.outlook.com [52.101.201.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2889B10EFB9
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jun 2026 11:31:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nctw8iYdtJ7/Cd+U9MaJHIbBMjEGejkRjvUSSK+GNRmztqGwYch9d3XAnFWXZxhXk2YovnPVS50yrsv/OJ+h9/rvLCjI/+FOq7BrVtR1dr4jZVRoRohSiMRCV3itdKV4sRQ4x+TGxzyJL9bNIenZpqld9v+I85ds+zSWIWhPOXM/sb/GUrgIXc+Yq2GSipoWzO/97WJhKgmoNGAry9FaPZe4TYCRDSmjcbtn5tXwuBGAQpKlcTDZx5WyMQQOH4Z3/fKc5u2fNATlNJFi2S/W5TLfOMkM1qJ4d888VFAcCIeX/ZTe12CGE5br1aUSF0D1gPX/HFWDB6HaCUiAF4EE+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p8XXgSZZMxzC9TX4+PFlejGMK22cLrFxKZMRfScQyLA=;
 b=dihxri69TwUSGVZlsYbDurXiin3KWOm6ehSYjtglC8JJaht+l/MeqLSD+09e2UHoLp4U8ZDEVHFddVEJSEpUPhoggafbfS+JZogn5M2iY9+FPhLmVhBfJ5W0wg95q8t4JKGF2e9Xd4q01SvjTWM9AZ2j7D7NI5i3UL3n4/ppA20X+DhcMNSu0Mf0shzoGe9prBpQxZq2ZNRluTOvdZmc2tEnplWxwPJFMkb4nnaPH2iRWYxS+s7zpSw2mLVfncxDT83uFDLDW3kdtWMVcfC5nr4UsyKnxbI3O8Qhx4jz4cPmGWLu5G1TqRNokTNKheJVSYHovh8vLIWMsfai1pDACg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p8XXgSZZMxzC9TX4+PFlejGMK22cLrFxKZMRfScQyLA=;
 b=VJsjTkcCxzap4Sd8HdTUdGdam0yJomzkZNnULLtxARdztj/dTSmc7vCKCfC0eqVMm926Me2ph1aL0JFDNOtzzngnmqeuK5YhaxJSYEtCsUAAhdt3BKAP0J1gw1vtVrjpXHJv2m4Oe3rQuu0K6Sg17gqShntPQqdO41lHs1zeqR0=
Received: from CH0PR03CA0007.namprd03.prod.outlook.com (2603:10b6:610:b0::12)
 by DS2PR12MB9773.namprd12.prod.outlook.com (2603:10b6:8:2b1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Wed, 17 Jun
 2026 11:31:18 +0000
Received: from CH2PEPF0000013E.namprd02.prod.outlook.com
 (2603:10b6:610:b0:cafe::64) by CH0PR03CA0007.outlook.office365.com
 (2603:10b6:610:b0::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.11 via Frontend Transport; Wed,
 17 Jun 2026 11:31:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000013E.mail.protection.outlook.com (10.167.244.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Wed, 17 Jun 2026 11:31:18 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 17 Jun
 2026 06:31:17 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 17 Jun
 2026 06:29:22 -0500
Received: from rtg-MAPLE.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 17 Jun 2026 06:29:15 -0500
From: Priya Hosur <Priya.Hosur@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Lijo.Lazar@amd.com>,
 <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Mario.Limonciello@amd.com>, <Kenneth.Feng@amd.com>
CC: <Pratik.Vishwakarma@amd.com>, <Veerabadhran.Gopalakrishnan@amd.com>,
 <Priya.Hosur@amd.com>, Lijo Lazar <lijo.lazar@amd.com>
Subject: [PATCH v5 4/4] drm/amd/pm: smu_v14_0_0: use find_clk_level() for DPM
 level marking
Date: Wed, 17 Jun 2026 16:59:09 +0530
Message-ID: <20260617112909.14373-1-Priya.Hosur@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013E:EE_|DS2PR12MB9773:EE_
X-MS-Office365-Filtering-Correlation-Id: 165fa4b7-2eef-4305-8e7e-08decc63f333
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|376014|1800799024|36860700016|11063799006|56012099006|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info: qe3VOJeLtlCjmmxd3WiZsuVBvFoFUYUrOQJuBYGmpe8xsWqp4hwGaHc2TIcV1JSlwX7Ja1U6aXqYjc+25qe7qcrK7owrZt9aUCGLdnKJlprErZAYRusRUnjKGx1yPVApEcF6b+kIRZqZiDDn9XSPjE7CKr8xtJhkf9r/yEaCCWI/jqq/jwoy6vPU7wQib858+6zfZid3wqVGPQHYup/P7cVR2ORTChm42yoWOr98DKE4D9VHRJbz+ejpipHyUV7MBA99U/4jjVtD31heJMO0dRWN/J676QEZRlYDyjqg4mvu5cVC6HtlDZUdTqJae67873HKVWPncG1yNUZko4ZU1iOwsodkxD/Mm4R5xvFF8r90PV+e6gcj27mTRX+LNVkfVteDI+sqS4iZXgFHoeuvF4+1+wqWQwPMlrvniPvPd9/5s4hA3TxgI2CXas+FoCzn6tY4BCCGX+5qC+5qCz0uqNNx+C0vfqp1BLRz+VyGR25lYHmeTVTp2pqqaCfViKXl12+yAQB6yi4vDvcRyfzIE+4gZxK/QFOhDsEV79FoSCqvLkwIRE1Efs2YUdiTwWTNIpjYzHBVE+HLXYohkF3UH4vejLOlFU2L1dUqoNKU0Tj2xx+vfppBQrfRR6pyFV/sQ2Vn1etgdZ2iCL8gdJdyVTwG1uuChmEezw6bqvJRTlC/kyN7JqfYy3k7jFdvi0+TKZ19Z/byEcIKzCEhJiaE/eqIg/qMasrcB20cQdqYB/I=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(376014)(1800799024)(36860700016)(11063799006)(56012099006)(6133799003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: TPIL8UgAlDLmKmcs1vfsGmJgezcOk2vDrMJnuFHqv4RuX7+ddLxlJ06sY9gx0tXHDBkOXd/eFT+PQnKIlNfSLHXBFJzRLbX5uBXdZW1OLMjBKncIz9lAGx+TpIyzbAeW2awurGh/6OUeYf9cnOwgo5JN0r1N83OV/0+NiFqWxFtH3QHj/wESQLSXZcpkAHfDZFGzxGx2cdIb6H6PYy1OZsxCSNbiKpyICEOEmK5kK+wX+0CrNotrHMybUNs9Zyu1d56VrJOxFgtbsbIv0VesebLzMPJCMZs1FUTg7G3xWv3ClEoyNZVTk39caTd6r5YOf9gzYCf+1aNPVHHwCHXcxglvDTj/cEzgc7Dj92k58vqvrY7tsSN4d18MYaJ1odC1QOS5M+3Qfogp/WdEVxHWAQcCT7jY6B0AF/TFYRsbfI4aOrMAy66dgZ4IpowVvg0L
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 11:31:18.6854 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 165fa4b7-2eef-4305-8e7e-08decc63f333
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9773
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

