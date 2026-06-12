Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DC32CD98CE
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Jun 2026 10:44:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B67CC10F41F;
	Fri, 12 Jun 2026 10:44:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="y6atS1ap";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012053.outbound.protection.outlook.com [52.101.53.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A05910F430
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Jun 2026 10:44:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EiyeNJYItl8sss5C9B5ULDo+Bqv1D9LDIUGOj+OEfiiAzsiq58XwY7OCZaK8q6+yJ3PwJBt10nTEi01YWXm699KVq6h0AAxW1PgFyPW48SpY5Vv5YvBBx+67xbCEtO6NBd0l8eNg3zN046My3FasI7T1ZFPVqix9zy2PTDym6d4hcMxWsE6lWQ8VNch+4z6N8NeLgxbi/sRfLMXpE0WqS5dnoNZC4Si6It5u/aKeVYfZUP+oSPqxvmR2S/CYq33at6yZeUcHjcggBQPSw+KhZe0IudeqAMkU4D+AyupG9A4NCYSifMXSUUV3NegDU8oxoe3LobCIyQMByuB6toVafQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hlnmyl7xia9NLvs0oqXxKOvSQOQXsPxjJ6UrGZ2+4hI=;
 b=FgIFJq8kJvY0mg9AcNjwhZv0HrWuGiW1TCj7P58EkDLVwLj3I0x81xctYgsLCUmNQPPYGK03f4IMsvw/lqJV6ruFL9qBV48jSzBfrMedaclCRy02Eo4W+Nu5X0FCpVbwGbrs/fbXMhhBpWRL2R5O6jzt4aXuVUW1wtwgYzdmA+QhB/qPRjTQhQx9r0XTBUOiCImSFb7CtVe7syPZOIyfiZaOpaD1BEWm9VgBYAlsDUnnpasAVEn70YkvGJfvmrsUgSgivvlz/PjTMOYkvXwQWxKbQLj7gMWb/KxU8o5jHFbvp7A90c94Fo1TPCpMPCgPN8uDswD9M5+UVbLXYoXTDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hlnmyl7xia9NLvs0oqXxKOvSQOQXsPxjJ6UrGZ2+4hI=;
 b=y6atS1ap7UGdQwTwRi2xF0FONn1CB1yzmhSIRP8qxEb3QxLMNKdbn2t/jF9vIRQOjKFtYBmQyHBxm9SNNX8HKsp8HsptDDXbxqtNduZ5vz31sBwDx5BvpsHbDrLq2kwGdlR8FxK5e07wXOi4ta1M3yfIV9vbY55q6QLDnhWYAjs=
Received: from BY3PR05CA0013.namprd05.prod.outlook.com (2603:10b6:a03:254::18)
 by SA1PR12MB8986.namprd12.prod.outlook.com (2603:10b6:806:375::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.15; Fri, 12 Jun
 2026 10:44:25 +0000
Received: from CO1PEPF000075F1.namprd03.prod.outlook.com
 (2603:10b6:a03:254:cafe::83) by BY3PR05CA0013.outlook.office365.com
 (2603:10b6:a03:254::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.6 via Frontend Transport; Fri, 12
 Jun 2026 10:44:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF000075F1.mail.protection.outlook.com (10.167.249.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Fri, 12 Jun 2026 10:44:25 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 12 Jun
 2026 05:44:24 -0500
Received: from rtg-MAPLE.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Fri, 12 Jun 2026 05:44:22 -0500
From: Priya Hosur <Priya.Hosur@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Lijo.Lazar@amd.com>,
 <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Mario.Limonciello@amd.com>, <Kenneth.Feng@amd.com>
CC: <Pratik.Vishwakarma@amd.com>, <Veerabadhran.Gopalakrishnan@amd.com>,
 <Priya.Hosur@amd.com>
Subject: [PATCH v4 3/4] drm/amd/pm: smu_v14_0_0: add SMU_DCEFCLK support in
 DPM frequency queries
Date: Fri, 12 Jun 2026 16:14:07 +0530
Message-ID: <20260612104408.9596-4-Priya.Hosur@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260612104408.9596-1-Priya.Hosur@amd.com>
References: <20260612104408.9596-1-Priya.Hosur@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F1:EE_|SA1PR12MB8986:EE_
X-MS-Office365-Filtering-Correlation-Id: f33eaa20-9cdb-4549-a89a-08dec86f9252
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|23010399003|22082099003|18002099003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: CGhFEXjF5A34WJniDDFzlV8E3/ODZFMU2t34fUTRgd3IoE7hzZl6e8k0PD7b7aCkuaW4Mtb6CzqqDOFd8Th69ViYYoczRiUrXAtTMZXw4LNW+HkcKaKtPb0PqeJF3y89T1QZBOAm4CmQEDRRdMD6PBmWLFfx0R/5eiDf7/kd/3zZokaT2OcIMysJWarfvmWaK/OSb7xZrpi+h6WJPSFpQfSnmCyKpGnepzetyIPhBWx9uaMHBEW26ZHkH93vKJdtI7upaPvBIVaTh4K2FY8las7yWKXnnd8MnlMZ5BB8aYLvyX/ZaKraFFQYe/U4xb7qljR75COUMc2pAu7SGulstSGobtoENgGHJhVH+GunxzKm27eFp6KCK6e8cPukLi1tfob6wYkZnUnE33p2Tttu3zGvl67Ksmrn9g4Hw4sGK5kd9wcvoAEUro8QJsP5tSttJ4JHe78xDC3U64BxygOXCx2pQDkA9jpdpChGBL2uLoWczuRnNMWr4DvmbiYsi6chcGGKyWaxG3F4hp9bh33dKdNpm8cKJoi1dLLbz0PtTym+9cCol4Mb/aJWf8aRFAqC2wtpP4NMHHHm+OMiB6NQYIVqmUjJrhDnhfhNuLwW3lgmBy0RxXFCKjEnuct464P+KUWI22xwkk0SAASoxzf2hTh4L0Kx3rP+OHADjQeHN8IvJXj3Nx1yI46rsxptEdEY64BGrADbfezUMfU2T37p73gzKmGRPKSHjr1koLxXYEg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(23010399003)(22082099003)(18002099003)(11063799006)(56012099006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 5RSxyGLeuxLLj3mSGOHp8P5DRN9Q94Nn2UuDHH1v2cUlMGtM8nOSpASDsSYNrA+ZtCAbA4I1CqiY4ae5m+R+dqOeRFR4n7odnt1NnJFLix9TAeIJelQRGlgSOUdGQNn//08OYeXh0v1C1L6GH8elOxzR/Mc8/fGpG7kzatCA1SUyJUIJ+P6y/UjbIOAkS+uLgzwUP7xwWRud/mz0oGUDAW+8bPmmYagyW5J5jo7i4y8aBpzn3G9Km6i0ZBfZIXMzR3ovozoJLw1MiKByrJEad+jDXPrz7Maq7s9EqXQdJ1Es6GzWq7QNQUEVn7P8fY44dRnprse2bH4qW6KpuhVF3bwbz7TEy2S47VrTGt8KK7mnqeWxOa4EwzLCJqkBFKlXpjnLxTwJ4DLtRfg7/F4mq0JUAdTp7jCKdJfy+4quPfSZtxBMueLqlRxvnHbZTs2t
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 10:44:25.3687 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f33eaa20-9cdb-4549-a89a-08dec86f9252
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8986
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
index c4c45c8dff69..206bfa906ad6 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
@@ -710,6 +710,11 @@ static int smu_v14_0_1_get_dpm_freq_by_index(struct smu_context *smu,
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
@@ -754,6 +759,11 @@ static int smu_v14_0_0_get_dpm_freq_by_index(struct smu_context *smu,
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
@@ -1117,6 +1127,9 @@ static int smu_v14_0_1_get_dpm_level_count(struct smu_context *smu,
 	case SMU_FCLK:
 		*count = clk_table->NumFclkLevelsEnabled;
 		break;
+	case SMU_DCEFCLK:
+		*count = clk_table->NumDcfClkLevelsEnabled;
+		break;
 	default:
 		break;
 	}
@@ -1146,6 +1159,9 @@ static int smu_v14_0_0_get_dpm_level_count(struct smu_context *smu,
 	case SMU_FCLK:
 		*count = clk_table->NumFclkLevelsEnabled;
 		break;
+	case SMU_DCEFCLK:
+		*count = clk_table->NumDcfClkLevelsEnabled;
+		break;
 	default:
 		break;
 	}
@@ -1212,6 +1228,18 @@ static int smu_v14_0_0_emit_clk_levels(struct smu_context *smu,
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

