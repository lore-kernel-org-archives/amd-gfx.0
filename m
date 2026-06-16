Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10E11CD98CF
	for <amd-gfx@archiver.kernel.org>; Tue, 16 Jun 2026 09:25:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A4BB110E0EB;
	Tue, 16 Jun 2026 09:25:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QNN/Jqk9";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010011.outbound.protection.outlook.com [52.101.61.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50CB310E0EB
 for <amd-gfx@lists.freedesktop.org>; Tue, 16 Jun 2026 09:25:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xt2rZ7humdfRn3v443lgQ21jTb8sVJOQuSyevTeX1H7OWsnTrTSIvJEHWIpnyYqETODd/1EN447j4DXUYeat1h5w9Ecyy6WL4PFoYtJpqcvw1vTfixVIG6YJlt4GIAxnXAaCNLFbbnmnH60F8WZfnBG9JME+ukPsjGvvsJx6BuYOGNcOhgDe9qQbzdjxVksbyup8bFU5ohF5Vbshi+j0RY4juFdvkDqJY5sGfQh6dw+QSXAsdfLLOxGxArXqOSKWqfIf3o07P/ZT44LnMIERMBRKVu0Vwo8pcGVFP89kPMezPIzCTMXHdN1Az0QRo4iRLlPjQwi7lrKkDmk8jR509Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PFZFIYQ+xVHeJCIsfBtTrmvR/zfEf3ZYYaS5Ax5RRCE=;
 b=xUUPERZCRi5QL3+3NtK1xSoeOTRaRleI78ichB0W7zkhlfl7dRyvYtlj5q9GRysWbwq8okIiszSPd5JayDQOanjKWZfNwaezzDp6LT5GGq2lMxGemsQCa1LSq8+IpmB1YUt/2uLWntUg0PEQTE1t8RgcyjTkdEXGSozFu/JVoSR6X3Yn0gWAIKH9Dn/C9oNGnHlTUPeFNaMrd3HKEelKGjoDx0ESt5NoBxNLeZOrWpdnqQEnnmR+zkko7dcIc4HX2h6jWFop9PbXQ5/MpwPgo3H0DT0kT6q8tOCZCtsfvu+eICagQWHrSXGbU8Qa0rrpZjhB1CYcQg8xv6wYrEY9MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PFZFIYQ+xVHeJCIsfBtTrmvR/zfEf3ZYYaS5Ax5RRCE=;
 b=QNN/Jqk9k/Licj+vvpa0nJHOFk25awVwy6EVKnKb6lHvin2+vkgPvAsTQYt9NWzBLBn3W2VtbCBEgmFx20DPOneJ+w+9U1PDMlrnkWsX/Um+ALVBqz9aJ0b6l5ZQfixzpo/nTF6b60nP17j7IvCUYxxl9I+oK3RtZ6feWF3J6B4=
Received: from BL1PR13CA0380.namprd13.prod.outlook.com (2603:10b6:208:2c0::25)
 by CH3PR12MB7763.namprd12.prod.outlook.com (2603:10b6:610:145::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 09:25:01 +0000
Received: from BL6PEPF0001AB4F.namprd04.prod.outlook.com
 (2603:10b6:208:2c0:cafe::41) by BL1PR13CA0380.outlook.office365.com
 (2603:10b6:208:2c0::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.7 via Frontend Transport; Tue, 16
 Jun 2026 09:25:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB4F.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Tue, 16 Jun 2026 09:25:00 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 16 Jun
 2026 04:25:00 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 16 Jun
 2026 04:24:59 -0500
Received: from rtg-MAPLE.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 16 Jun 2026 04:24:57 -0500
From: Priya Hosur <Priya.Hosur@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Lijo.Lazar@amd.com>,
 <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Mario.Limonciello@amd.com>, <Kenneth.Feng@amd.com>
CC: <Pratik.Vishwakarma@amd.com>, <Veerabadhran.Gopalakrishnan@amd.com>,
 <Priya.Hosur@amd.com>
Subject: [PATCH v5 3/4] drm/amd/pm: smu_v14_0_0: add SMU_DCEFCLK support in
 DPM frequency queries
Date: Tue, 16 Jun 2026 14:54:55 +0530
Message-ID: <20260616092456.3973-1-Priya.Hosur@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260616091731.3722-1-Priya.Hosur@amd.com>
References: <20260616091731.3722-1-Priya.Hosur@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4F:EE_|CH3PR12MB7763:EE_
X-MS-Office365-Filtering-Correlation-Id: d1a98f31-94e9-40e5-5137-08decb89240e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|23010399003|22082099003|18002099003|11063799006|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info: vcnhnHG1X/PxQtubauEtUA7Sj4+77roohOCfQLPs3ISw9xBfNmJGBMqqALDMwYOdhRQ7uP0cXLEQDgAiETgFAm0ZHtwelHkai+4b5xSI8z28hpqF6ItfNVwOHQUYhUsd3sqrRMYmeMGXjBj1nsdeWGz1JslKoAbb2toVpzz/fp+3fNzf43iySUZ/B3XvA4pkyYcLWeeQl4NUUjEvxmL3TthSo+iOMls2l1ifOmbzH7b75GBokYg0Yk5XSXeJrbRauurE3XYbfkXkm1ClEP+Rd7/jTQCjILFDhB9pW66oMF155k3lC+EcyLMLjTQU+gXw8lejX0jOAkPKORhEu3CCPVdukPoYaOQtKuZgrBmQ6Kv26XCKdx6E418uFx1qJAxSiaJJ0I7j+NjvCSFuCT3PKK4Ym4vdVNKqOZ19XSL9A8SWw9y8GdH2dntxCdp6ukMVh++3cPF0NOGTvKdNAJyN3wnzEGOhb01hxQMaok8BcAY+aKMyNeiBgGS1x3EsXML19a4LPnfpuzDB4L327s89viNlu8RMWnT8NG6e6w5MxcH/WVFnMc2/4B3sfjdzJO+1gVjxtsxzci0mluS+swkByqozRrwWXHUfU0McPLD9ZN9ljQkzk8fszNCciCcJjAg6g5/y1/x2ayZh8NYfbJZjEFcawHoaQgOKpYVIi8PP+O78+n7qz+UVu6mEMV4gsM1FeV0Gn51JK7XgEvwocft464N+fneqsx4PpzWO4z0MRS0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(23010399003)(22082099003)(18002099003)(11063799006)(6133799003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: kRqtbQLvEQbMiota1PwWLhoCVovsV924sa3bI2KQFCYO+e/4CVuvhYbbSGdU/L7BM5jwVSZqDxzuCKiY6Lzj8Fz6B52Lhj5BpI7YdOwdDxLzmYiRVIZl9guzs8S5BZnLhEe2q2e741lAGw3Nk/6dPPr4A2SIB5vXZ9yZUAPzNrALcNBdUqGsTnoNhoesfJ2imRoLcX01Os6RDVjgT8mVZWx6tGdDlIgm9MQ6XgVqaDUW+JWW24Kfd97zLgbBirSB/QvOu/zPqEWzkZWFspBocDsAGz9sfRyzzZbL3RmpFJovAnOsc5wKQ24v79BczEGFcnQVXxg5yPHVl6UiaTSLgnMtq4iYEh5HQoXhelNnzzNOn4lqolq+HZp+8Y/cy3ftBQf/2sKNNGycwJSXFEMc3eUm/qnH4lVA76iDec5YdKiOOVBQOyo5kb7fGJKwWePe
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 09:25:00.8642 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1a98f31-94e9-40e5-5137-08decb89240e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7763
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

