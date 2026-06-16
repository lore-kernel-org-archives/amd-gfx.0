Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D7BCCD98DA
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jun 2026 09:17:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DFE3C10E97C;
	Tue, 16 Jun 2026 09:17:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sQB6HQAZ";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010012.outbound.protection.outlook.com [52.101.56.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D1CF10E981
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jun 2026 09:17:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZXDcmIQxHVdPpCiwKlyVAwVMPBM0o+uLXR+E+3eU9ZyrrJJynD9LLVUAp4oGJfRdSJIQKsUnaTCm+geNndXRejH6fqz6pGZj8kSuvHSdunnJyPvV3Vis1IHgv6qFsmTO4CcLOz3cgf98oGebIBoZ1NSarjW2oii7h3SasixcwPyjD7F5sfc+lYhYt7/3U+4ISZV1lF5qH0xYYBjBJyxZUzJy9Gtfq1MBPD9tC734FySZZIbpgb6RwpwHxrMDlN0g52DUR4U2zAtkOCFnzYQg2zkPD4J+ewcRJX+dKM+D/OBbUj0NChbqAWDiI750gPU4gaVcBC6i0zbLQHzaP8gRmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PFZFIYQ+xVHeJCIsfBtTrmvR/zfEf3ZYYaS5Ax5RRCE=;
 b=kwHOSDqZq4IQXnw/tPG3/GmIKwqmsXX4zyI29E0K6m0yt07mhqcBwWpdiU3VvSajiXsY0FAkDXqCrcFgyLqdc9NykMQoQdMe4z+BHQHQMNWYvnDzlzposZUe3usubknt6v4DN5f/TkWh4nC7dZWvzjUgn+2GtWIhQMpi2dDzwZVQDjYsSFBEq4oZJpMHrg9DqgEJNMWeBrHVByNiuhcbH3ZrxUIeTBNfqEwkjqy8ZwfauUmUc9Bx8rINEgJKy9eDFY7/SPoATUvVJW7X9j5/MSr+DX3t5dZdAx16AG//+lBKxEUaZq4RTgVOMRTJDNILCt/YokNwI6Na7vcxERj4bA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PFZFIYQ+xVHeJCIsfBtTrmvR/zfEf3ZYYaS5Ax5RRCE=;
 b=sQB6HQAZQQ9ufteiaptD/CZQtAiZgd/oK2LN3a66s3ysmFL3BCTc906No+iPU6f7lrMtt64B+RgNIzG0IK9KSSAoAWAmuA2Vwod+cGwUpHtAyzFsHCDYYh/4TL5ySQiiSg1ANVg+LqEJsuKjJkKrOLxMmxAcDiTjgDAIUrInVsQ=
Received: from CH0PR04CA0104.namprd04.prod.outlook.com (2603:10b6:610:75::19)
 by PH7PR12MB7842.namprd12.prod.outlook.com (2603:10b6:510:27a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 09:17:48 +0000
Received: from CH2PEPF00000141.namprd02.prod.outlook.com
 (2603:10b6:610:75:cafe::61) by CH0PR04CA0104.outlook.office365.com
 (2603:10b6:610:75::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.18 via Frontend Transport; Tue,
 16 Jun 2026 09:17:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF00000141.mail.protection.outlook.com (10.167.244.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Tue, 16 Jun 2026 09:17:48 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 16 Jun
 2026 04:17:47 -0500
Received: from rtg-MAPLE.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 16 Jun 2026 04:17:45 -0500
From: Priya Hosur <Priya.Hosur@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Lijo.Lazar@amd.com>,
 <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Mario.Limonciello@amd.com>, <Kenneth.Feng@amd.com>
CC: <Pratik.Vishwakarma@amd.com>, <Veerabadhran.Gopalakrishnan@amd.com>,
 <Priya.Hosur@amd.com>
Subject: [PATCH v5 3/4] drm/amd/pm: smu_v14_0_0: add SMU_DCEFCLK support in
 DPM frequency queries
Date: Tue, 16 Jun 2026 14:47:30 +0530
Message-ID: <20260616091731.3722-4-Priya.Hosur@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260616091731.3722-1-Priya.Hosur@amd.com>
References: <20260616091731.3722-1-Priya.Hosur@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000141:EE_|PH7PR12MB7842:EE_
X-MS-Office365-Filtering-Correlation-Id: 124316b0-c5d8-4205-74e5-08decb882233
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|36860700016|82310400026|1800799024|56012099006|11063799006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: hVXv/1HaHvq5M5hqdnJnaeWD/FqYstfukef/G26b2yh3kOzwQWuqeKPRqIWrH07sZ1K0+mCpGJYpfSR0rersXhbikwL8ryoR/0BLjNMJYtxRqLhg3TBETLeT+vRwYK1EuM03gEJPn62Lc2B+prKLZ074VokOJww6WvxAkgi+gFAjl9owNcPbp9R6ZqvCsv0oqlzTea2cYthwewVqYTP2fni2QrMeN0iWq4HiW6+uYqsm2jq+ojZ6/S+foaa9Nu4E8Mqy+IjwMB3NHg3IrbtVqcQY5LkrTNpEUjHvqJqgkFbObme+Ps8sZUHOhAF8Gpv2kC5dFOBYuTnl7+qws6kK6+9uSbJ5vvrSCvZLfK5FqUILFlyVthe88Ls8+fddsIOS/qTLElLTK0X3ddbm0HxpZJxRSfnt65HERw0Ls5g+WEj/X6lUikNoeKcEyG6SmpSCKjeZl2Ym29GK8cAf8kkwpFpXzS/xMncCkdPVShO/EYOyul2So1hSnqZbDeeuninLwZh4vFTq/Vfuv/W3t6CZtHbL6eG23aA+b+23RAcmV3oH2CdxDlZjeL4z1HVFZNRZb4vRH6+WFQHNnuoq+leA5UM6rYMSQiYWQboCcrDXH97fh82lj2mSv5ohzTnxt6AHCsiNLYJqUhHnoqPMYpJqFhp9YuVT+EEfdzlpmQfhGCSOAJIC9kw4pkG3itylRMwvPVDEFSw53bw/+IHkpmitbB8RTIHlRlxQFTmzuZgZAEo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(36860700016)(82310400026)(1800799024)(56012099006)(11063799006)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: sCpg+vxl6MWzoVpQPNTEbyJ3jCBaSn7NP4yJ5VsM77urqejlpbIHHPIrz4DvpI5ZJKtSfa2KGc/ExcyzgRgrW+vhd+5Y2un05mBg+QzUgW0eijEbx05flOphfHKtAKUOv4bP/DlGg3YNWrtzd4jxTN7G6rGqeYh1SI/OfwXHWbamGMAF9MoFON61qr7If/snyZQFYoi+X5toTcNLBfm/e29WTE98DKvqeAo0MmteZsaEQupZcV8nJ/sVKumy5+Y+nqOM3icXeMKfUimehSkdU3TrBgVCUH5G0pMUoVcnVPhzXLrXTNd8nKKo9RTUch61NLSt0gwpkVQUFULaBhbYLOH4k7MgVlUmpK+YLqh1siJZ5Fmnone+YRSfsydM26BPmnaFO3tnN6LSjufJKmvXGcPGSBohstk5ATb56EbaR59u9bO90IlCH6AA8VsiNIfI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 09:17:48.2351 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 124316b0-c5d8-4205-74e5-08decb882233
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000141.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7842
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

Add SMU_DCEFCLK case to smu_v14_0_1_get_dpm_freq_by_index and
smu_v14_0_0_get_dpm_freq_by_index using DcfClocks[] with
NumDcfClkLevelsEnabled bounds check. Add matching case in both
get_dpm_level_count functions.

Add SMU_DCEFCLK case in emit_clk_levels to list DCEF DPM levels.
No * marker is emitted since SmuMetrics_t has no DcfclkFrequency
field (same firmware limitation as Phoenix).

Without this, pp_dpm_dcefclk reports N/A on Strix Halo.

Signed-off-by: Priya Hosur <Priya.Hosur@amd.com>
---
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c  | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
index b206a4d0376b..f273b95928c9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
@@ -735,6 +735,11 @@ static int smu_v14_0_1_get_dpm_freq_by_index(struct smu_context *smu,
 			return -EINVAL;
 		*freq = clk_table->FclkClocks_Freq[dpm_level];
 		break;
+	case SMU_DCEFCLK:
+		if (dpm_level >= clk_table->NumDcfClkLevelsEnabled)
+			return -EINVAL;
+		*freq = clk_table->DcfClocks[dpm_level];
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -779,6 +784,11 @@ static int smu_v14_0_0_get_dpm_freq_by_index(struct smu_context *smu,
 			return -EINVAL;
 		*freq = clk_table->FclkClocks_Freq[dpm_level];
 		break;
+	case SMU_DCEFCLK:
+		if (dpm_level >= clk_table->NumDcfClkLevelsEnabled)
+			return -EINVAL;
+		*freq = clk_table->DcfClocks[dpm_level];
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -1142,6 +1152,9 @@ static int smu_v14_0_1_get_dpm_level_count(struct smu_context *smu,
 	case SMU_FCLK:
 		*count = clk_table->NumFclkLevelsEnabled;
 		break;
+	case SMU_DCEFCLK:
+		*count = clk_table->NumDcfClkLevelsEnabled;
+		break;
 	default:
 		break;
 	}
@@ -1171,6 +1184,9 @@ static int smu_v14_0_0_get_dpm_level_count(struct smu_context *smu,
 	case SMU_FCLK:
 		*count = clk_table->NumFclkLevelsEnabled;
 		break;
+	case SMU_DCEFCLK:
+		*count = clk_table->NumDcfClkLevelsEnabled;
+		break;
 	default:
 		break;
 	}
@@ -1237,6 +1253,18 @@ static int smu_v14_0_0_emit_clk_levels(struct smu_context *smu,
 					      cur_value == value ? "*" : "");
 		}
 		break;
+	case SMU_DCEFCLK:
+		ret = smu_v14_0_common_get_dpm_level_count(smu, clk_type, &count);
+		if (ret)
+			return ret;
+
+		for (i = 0; i < count; i++) {
+			ret = smu_v14_0_common_get_dpm_freq_by_index(smu, clk_type, i, &value);
+			if (ret)
+				return ret;
+			size += sysfs_emit_at(buf, size, "%d: %uMhz\n", i, value);
+		}
+		break;
 	case SMU_GFXCLK:
 	case SMU_SCLK:
 		ret = smu_v14_0_0_get_current_clk_freq(smu, clk_type, &cur_value);
-- 
2.43.0

