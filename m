Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10708CD98D5
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Jun 2026 11:42:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CC0210EE94;
	Thu, 11 Jun 2026 11:42:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="k2CWH43A";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011000.outbound.protection.outlook.com [40.107.208.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CDF910EEA6
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Jun 2026 11:42:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GQpqemobbYk6hoTJAKvBfOEz0kMx1b38AaMkjchCCredy9Go41L+RWX7TATcSwW0CmI9Lk9Z76Ore0UGN+RHTFInVgauuEixVM2taxvHm75wrC2Kq4k3hlxgg6/6Sa4ICDvS/xNyCsgbGSU051x3Q/nYjiU79YrLufyukqnIveaGFbHe7QsLrbxt1v5a/pXT8+Q+ECCb+5QmXOpDZVm3D6RNrXNEbm0MWFTbc7i83Fn2TiH/Vaon+/WZwH54dJ7oll4hNjljMMECDEZruZGnokhW2IaFHUet3GDiWTQ/M2QkP912/pmNEcCWOTVHZrvGYsz77V9g1LygV7jTmvnRAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i9MUZVCLv34k8yANjHWd+gQgHAGptmJIXft8W8WwE1Y=;
 b=hYpO8rEstUxOu8rtJBHZ6xtaXMEibJBUAcxe1dIJPrX/qh2lusuaPqzB97vxm8LaTyYZzT0MmPbRAR8j+YynTY5Tsd35L4+QVePJ2jGQaIXNG8ljFfTkEjtidWlHU2kZKIELl9qYr5fcRPbST6C1y8bTMeKDULva3xup6JAkQ/R6tAx/MqRtat9oywreNjMNc9Jlq8gxxGv3Nxojov9mO+xQ88yCcVk/TJe49Zj4bLlSxkxYXg7T5kuFnwGJWu5yk4KeQpjSRqffdkfUCRM7EAoDiglXXrOY38zMyxm4WbZec1HC2ub6xx9Q9/w0TpdxgEqmRpglmvropZAfRvoUnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i9MUZVCLv34k8yANjHWd+gQgHAGptmJIXft8W8WwE1Y=;
 b=k2CWH43AAxYd1F+HlkIiXb3kJq3J6vs+Lpwog54tH/e+Hp7bVa5sX/o8pR/RzMoIreZVeyWy/hKHGVJa0uQs+uY4uAJ5YuxibCXDZ6g4+ykPPDifm2ywGcclt/kLX5L07elfBLfD/hz6rLjeumvve0vZHgZ+GUZ2jNHKXZr2slE=
Received: from PH7P220CA0140.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:327::17)
 by PH0PR12MB8097.namprd12.prod.outlook.com (2603:10b6:510:295::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Thu, 11 Jun
 2026 11:42:23 +0000
Received: from CY4PEPF0000FCC0.namprd03.prod.outlook.com
 (2603:10b6:510:327:cafe::8b) by PH7P220CA0140.outlook.office365.com
 (2603:10b6:510:327::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.13 via Frontend Transport; Thu,
 11 Jun 2026 11:42:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000FCC0.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Thu, 11 Jun 2026 11:42:22 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 11 Jun
 2026 06:41:56 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 11 Jun
 2026 06:36:49 -0500
Received: from rtg-MAPLE.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Thu, 11 Jun 2026 06:36:47 -0500
From: Priya Hosur <Priya.Hosur@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Lijo.Lazar@amd.com>,
 <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Mario.Limonciello@amd.com>, <Kenneth.Feng@amd.com>
CC: <Pratik.Vishwakarma@amd.com>, <Veerabadhran.Gopalakrishnan@amd.com>,
 <Priya.Hosur@amd.com>
Subject: [PATCH v3 3/4] drm/amd/pm: smu_v14_0_0: add SMU_DCEFCLK support in
 DPM frequency queries
Date: Thu, 11 Jun 2026 17:06:14 +0530
Message-ID: <20260611113628.3217-4-Priya.Hosur@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260611113628.3217-1-Priya.Hosur@amd.com>
References: <20260611113628.3217-1-Priya.Hosur@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC0:EE_|PH0PR12MB8097:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e35f8d2-c7de-4111-ae2f-08dec7ae80a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|376014|1800799024|82310400026|56012099006|11063799006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: ryvdcupwUFvp5gXVe8kA1zUzZxYpDEUlr1sfZpWXH7supqzgwJr5Pu+Gm2fe9RPQsE/wfYw/W/Rz9oTb93LNsU+Wlnmv7G70qllu1WQf/6TlK0+9nJ5fbLMTRmcQKXP3t3MQ9IXPQfPPex3sf5YzcYM/sHyx0bCAtuexlV8RLtqK2xRCH0bHN/G0wIq4KucUQW5ngsSK9NUZNsh84VUaokQd/Jvge3DyJxlCz659UTFy6Gm7k7wtIcW3Q8jY6Fz4PtoofeUBtWbushAYe/DiQ70vu//+vT1m0YOktSx4oxorE6XZB58Jwft/Kj2PHHSP+AfPIDXJOjfYFANOF19+1Xy65eaSAl1oo1wS5d1w40texwRv42lYfvPsVV4CX/JnCmBeXza1MV4P0RId+A67NRVGxFPp0QLvDdunyQGIkfx+ld/ZzMpdoMMzs+ZpsXunH5s9RKYfTVS+tba9e+0koPh/mNG4bzWauXrYnVhFD6UtYDPvuqF0gTY+P7T76pmBKfBH0zyHIVJUV3Hl2StAddnaluJ0SibqPutS3qp5l0fc6eZ2kHI6+Ouip2mWuFH/Vll/4f/NtEtPu+5yL10JXlGwnXu4fHW/7MDjAeXz+aRfYzwUvcQIHz8WuSmFg06sTFP9F5cbp4uT2CXv2lo8Knt11+CYjUnxGrdS3imrk+/gFG5UAQijegmuBNLVGbytluCuGIGnX2J+5er61OkjZq8R/EVJtXvOyRaQ6Oajm5E=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(376014)(1800799024)(82310400026)(56012099006)(11063799006)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Q8QeXIyIL45Kd617pGN2z3nKoGBdZ8FOQuc+wjKg5an82WvJXRNTmrQLYGAKZkUf9bebCPcS+lRGEnURjLVzd5ZHGwfDM0JJSWNPpuGGhV2w6neOqFjtTrYH3H0F3yqceHsfxrBLcKEQsZMzxtO9FFlDrhYZwnLmXT1+mlQCC+hBZgjTpZnfWN9Ws3Kr0RObtJdc7SW1tzcyruxNNAbp8Enc/u8H39IxuAbS252tTR8QM4aQYJFwmEOpRQeIPbQAns4qeoRt7yqeyfGB4CQF4J8o34kvy2/RIDz3nul8A5LY5xmIPjnDmWfdCN6cIKvBIXknFxDMEcZKVaW0OlAWLZisSBX53MuGiuuIyeMmMHuoM4U9k5xrV1W1dh8cWm7wGTuMGJTvKn+c0HFW5etsjUKVapeEfpcErYsTc1LN87+MMeorSVEgZevoDw4yKWTx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2026 11:42:22.9207 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e35f8d2-c7de-4111-ae2f-08dec7ae80a6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8097
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
index eeb508336349..4469048d966e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
@@ -686,6 +686,11 @@ static int smu_v14_0_1_get_dpm_freq_by_index(struct smu_context *smu,
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
@@ -730,6 +735,11 @@ static int smu_v14_0_0_get_dpm_freq_by_index(struct smu_context *smu,
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
@@ -1093,6 +1103,9 @@ static int smu_v14_0_1_get_dpm_level_count(struct smu_context *smu,
 	case SMU_FCLK:
 		*count = clk_table->NumFclkLevelsEnabled;
 		break;
+	case SMU_DCEFCLK:
+		*count = clk_table->NumDcfClkLevelsEnabled;
+		break;
 	default:
 		break;
 	}
@@ -1122,6 +1135,9 @@ static int smu_v14_0_0_get_dpm_level_count(struct smu_context *smu,
 	case SMU_FCLK:
 		*count = clk_table->NumFclkLevelsEnabled;
 		break;
+	case SMU_DCEFCLK:
+		*count = clk_table->NumDcfClkLevelsEnabled;
+		break;
 	default:
 		break;
 	}
@@ -1188,6 +1204,18 @@ static int smu_v14_0_0_emit_clk_levels(struct smu_context *smu,
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

