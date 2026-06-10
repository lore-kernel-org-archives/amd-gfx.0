Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50C80CD8CB9
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jun 2026 12:13:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E16E910E91D;
	Wed, 10 Jun 2026 12:13:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="h4Cq2gLw";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010036.outbound.protection.outlook.com [52.101.46.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C124A10E91D
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jun 2026 12:13:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C9Fs60wd6O+hKyzeUCD+toVbXLZJA0LHhErNJtkRKUY9wmvWVXoM8QsQbks/puvcudWsDTyt1AX+0TnfY624BlRUmEnA5WArLApxj58gj2ncpBzi3p7teRrqJr5mR5xxaW2Wq9hOU7zJGzcSEY3Az27BrFZ5duWTsO6CB+3yjgd60syVEWuPeaiCToeAvxrywHpLgPl0dMGZUxYKuZ3SYoxut8EWxB+1l8bAR1t8q4ZuhNdfpMIUpfDDn42MLJ1BTR9Pgy6GFHnqXZYSSRyjSP5yuJ883wqlAy1lgmNkg8L7mUAUrBs2yGxQsqxmpG8GkXlpGRfChHwvQAFI9AL6cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yh6TauxW0zqyPUzqvjqmPcacWZjXvepcC54nK74m9zI=;
 b=jkg+1PLiQ5SAs52jRg914IEwMEH0KrKIOPcj7rVMeh8nmCY+uCkZMwmWT4v9hetefobUH/3EfjTZsxnU8gpdWjb4tlIpW+Dl5vvKwii1w96cWOswDla+bVnw1VhqnWMTq+OQ+Le0Fbrh9VDR+mkf/+r5NTM3gHn85RcRkr3sMonFTZB1umFV+OQLoj0nu/fKJQdiyJjYT7W6UUJe1ZI3RS7unAmrmu5fRsW3N5FTf8SbcRPCQpKQH1InCoItU4IMM4JCxR9LJBOuOLCMB34eqFxWMGqbeoHGhIB2R9aTbIgNV2MIOQyd+vGt77xgVBquLf+ZGRfNa5Sxk7OTVrHgqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yh6TauxW0zqyPUzqvjqmPcacWZjXvepcC54nK74m9zI=;
 b=h4Cq2gLwspa7A1KxRWTPxLy/vkKk2q6n8y35ROREy1ZUBK3tG3JhbI1x7qcopUDeM9QUkmItAbAe9bSrjcnW3gqyMmUQ+9IPFhSdWPfGSRwWUVl1wgaDSAUCPITB/s6wGbYZeR01P8/cBiqh2dUXhclTBH5tJoIpUdlNOkQVWIQ=
Received: from CH5PR03CA0021.namprd03.prod.outlook.com (2603:10b6:610:1f1::15)
 by IA1PR12MB6603.namprd12.prod.outlook.com (2603:10b6:208:3a1::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.14; Wed, 10 Jun
 2026 12:13:01 +0000
Received: from CH2PEPF00000149.namprd02.prod.outlook.com
 (2603:10b6:610:1f1:cafe::5e) by CH5PR03CA0021.outlook.office365.com
 (2603:10b6:610:1f1::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.10 via Frontend Transport; Wed,
 10 Jun 2026 12:13:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH2PEPF00000149.mail.protection.outlook.com (10.167.244.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Wed, 10 Jun 2026 12:13:01 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 10 Jun
 2026 07:12:57 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 10 Jun
 2026 07:09:55 -0500
Received: from rtg-MAPLE.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 10 Jun 2026 07:09:53 -0500
From: Priya Hosur <Priya.Hosur@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Lijo.Lazar@amd.com>,
 <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Mario.Limonciello@amd.com>, <Kenneth.Feng@amd.com>
CC: <Pratik.Vishwakarma@amd.com>, <Veerabadhran.Gopalakrishnan@amd.com>,
 <Priya.Hosur@amd.com>
Subject: [PATCH 3/4] drm/amd/pm: smu_v14_0_0: add SMU_DCEFCLK support in DPM
 frequency queries
Date: Wed, 10 Jun 2026 17:39:43 +0530
Message-ID: <20260610120944.124040-4-Priya.Hosur@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260610120944.124040-1-Priya.Hosur@amd.com>
References: <20260610120944.124040-1-Priya.Hosur@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000149:EE_|IA1PR12MB6603:EE_
X-MS-Office365-Filtering-Correlation-Id: 78f61e4e-4286-48b0-11e5-08dec6e99de8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|82310400026|36860700016|1800799024|56012099006|11063799006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: NqXn8yOi+pM4thDpIygt2T2ABvq65ZU41zK1pzVKsbnYep/Mn3nkbiTHP1FiOBobVQ0xaTFWaUYKc396PSjfPb3NPvvyzLoYP/Ugv/X3VNkYG0K+1+Du5dX+seBPnLvHrlxHDcsyn4qrleAKBORLJf9JXav9CCwRyFxH38A8LIzF4bl8mzswsIwSHK0igyA9T1lnVp+gmxeUUH1dm+HbXK3D3UGWAYrAX864rR1Xc5B6ueMMN0RbQYj6d+AQ3Em9lOYeNHzKDEX/Wk1iGvQhjh+2I1ZY9Fof8B5gf0oCLz4fMlyeCiw67wk5u8JPrY8zXCL7v6Jh3FC+EFPbfsiu2cZUNX9G4nNwjMWB3OgF2lQuqgWtlCE02O8exZ1HX2O7NdbW4cHA82+BTW03b51pW90jRr7QCR3MHoNOxL7nRw7BoPUUJlFT7of2hXDfGwb4nUdcX4tC/lML0Ff1c99nSkx+VJoKwWwPaxsXxJy39qUxp6lCBJKW0/C6T9uTXefUqtuPM7cUp+lzNCzlTs9xh85uXHFiDOrWMNMPPkfHix367d22QCEFmNQhVkQVGeI0WPK9qUSgR4RRuog4Qh0Orq1G7BObIwR/sNZew8U8y1zuohHi2VvGTbszd8RRaRVbk+1lEnNB/ciC/+lb2kYonMdMyEWQU0ZWT6W+3N29PYAX/TFJ1OED52jJ+t+0+wZnzOmMqLSB0fHCx34EYIT/RZvZMxtP3nmnHSZDXjMY9ls=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(82310400026)(36860700016)(1800799024)(56012099006)(11063799006)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 6bshKITAd/zJOAsBC+MH5My321A+nw+H2fc1lzO+ELMj4f4zA08tUwMo5W0eGv07n750QPS3MZr2Igh95mQ3PYPVVUzRqPCZcfoHENAPTOogzU3ZEwx/IQZtt3f3EMQBdhWd82jk/tDQIdRDQyESPYad/iLKdOf9r2i7XKHCI0yYvB4uEOyjKm3wZzy9ylcnumztKszLponAF8eE0O+b3F1phxd5oMMbGWp9K8MiOV6P0X20rfK8FsnOHlbBCWY2PEzRDdJmTuseYdGVqutltuUw3nSxhD8ghBw0ghLbNBP7HfO7l7stHCnnvttkqU6b6DIR4sAVq0HkpzdNRswnCU1Aey9AQzUIFc7Isd3c/HtQrrJD1iI2KX10P6LAsmg/DVew08lUiKOVl9RBtTksQBoS8WcjSE1DT8/WsCNkIWQ951qC02lUE52mof2Utd62
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 12:13:01.1810 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 78f61e4e-4286-48b0-11e5-08dec6e99de8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000149.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6603
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
index c977681d8946..c203e828cce4 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
@@ -687,6 +687,11 @@ static int smu_v14_0_1_get_dpm_freq_by_index(struct smu_context *smu,
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
@@ -731,6 +736,11 @@ static int smu_v14_0_0_get_dpm_freq_by_index(struct smu_context *smu,
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
@@ -1094,6 +1104,9 @@ static int smu_v14_0_1_get_dpm_level_count(struct smu_context *smu,
 	case SMU_FCLK:
 		*count = clk_table->NumFclkLevelsEnabled;
 		break;
+	case SMU_DCEFCLK:
+		*count = clk_table->NumDcfClkLevelsEnabled;
+		break;
 	default:
 		break;
 	}
@@ -1123,6 +1136,9 @@ static int smu_v14_0_0_get_dpm_level_count(struct smu_context *smu,
 	case SMU_FCLK:
 		*count = clk_table->NumFclkLevelsEnabled;
 		break;
+	case SMU_DCEFCLK:
+		*count = clk_table->NumDcfClkLevelsEnabled;
+		break;
 	default:
 		break;
 	}
@@ -1189,6 +1205,18 @@ static int smu_v14_0_0_emit_clk_levels(struct smu_context *smu,
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

