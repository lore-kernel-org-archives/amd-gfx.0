Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECC32D44144
	for <amd-gfx@archiver.kernel.org>; Fri, 12 Dec 2025 08:31:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 907DB10E57F;
	Fri, 12 Dec 2025 08:31:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XU4VT6FP";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010056.outbound.protection.outlook.com [52.101.85.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B26C510E57F
 for <amd-gfx@lists.freedesktop.org>; Fri, 12 Dec 2025 08:31:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TzNSE1fJdH+idG3Uyb/aNJmGFNZM3Ec2yUftfv9w5P6L51kvUX6C9heCsKJinuXUyFqE56DRGjtQ7+2QoN3LNI+j/V9iPQ9hrF1qF0nnQH1BZnhVLl6oSHsjPtOHexqeB+Gske4+JR6/Ty4gjyNDJ0o8RI3QS4sFMaf0tD+znNzbic1y10wVdClmn9AoVTdDVrfHIsxQ8rlb8rqt60vVUR2UqwcGHeZMPfk4CGlqRl/9kgHWhC93edEyH6bfCxlNiTcaZ9NY1PbJrTjg2xdK22KdDbPpAfk+lbGRehds16H/TPp8sNJzoWBoX22ycrsf5Zo4KneRp/wbGpfGeOCzVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ovg/3O5DlPY8ftmCNdeWbmUTdQQqQ8T3T57H5M+XvxM=;
 b=Qw8gVzOH5kU/Y55xLHu4KnJToMLzltG4yKQM0fnstyiyl7GM25je2a/nirSeksB/GwGKbXCKzclCF/QV35Uu0LziaKSvA1YdnNDA2YwU6pwzJr3iXAY+W6WG8XLc+moZIRCffDFmmZJWlp6FZPdSCk6Qb2CAmjbqrfSqFNQURPcga7G/8qw7+IG1G0ek6B4NSdFmSb7phzmAhjPLGhbKVWWlvKmT6JYvlk2zVxFEL+fBYzbQ9TEhG4BHd6l5V4+75WiEKeWR9ux3MAcjLcTim96jE0TQh2rwauq3z1r3ELJtNERZi378WDAaYnlRXJVsPydxbmic3PZOcEd9w41Zmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ovg/3O5DlPY8ftmCNdeWbmUTdQQqQ8T3T57H5M+XvxM=;
 b=XU4VT6FPdZ5+EkMtkpe9KNzO1S3ob06e/BdLrGM5QnJJLzMyewKNQgG2YH/MgH/uQTzpeWpg/+DfapOBKETb/V7JPz2lWi11DVIrQSNHMxpRLXFnL8+vBBotfw9aFOjrXGXw7IqcWjgTN655X/aEt9khaFkVTJeJ/btgVx0xCtQ=
Received: from BYAPR05CA0056.namprd05.prod.outlook.com (2603:10b6:a03:74::33)
 by BL1PR12MB5900.namprd12.prod.outlook.com (2603:10b6:208:398::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.10; Fri, 12 Dec
 2025 08:31:09 +0000
Received: from SJ5PEPF00000205.namprd05.prod.outlook.com
 (2603:10b6:a03:74:cafe::d7) by BYAPR05CA0056.outlook.office365.com
 (2603:10b6:a03:74::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.8 via Frontend Transport; Fri,
 12 Dec 2025 08:31:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF00000205.mail.protection.outlook.com (10.167.244.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Fri, 12 Dec 2025 08:31:08 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 12 Dec
 2025 02:31:06 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <Asad.Kamal@amd.com>
Subject: [PATCH] drm/amd/pm: Return right size for gpuboard metrics
Date: Fri, 12 Dec 2025 14:00:45 +0530
Message-ID: <20251212083045.2463099-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000205:EE_|BL1PR12MB5900:EE_
X-MS-Office365-Filtering-Correlation-Id: b5cb8ee9-3a8e-408e-c3c4-08de3958cc99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?p20EFeHd5aN/3HS6CkVh0ECAGK3LaYHF4TgDH1jQ4pxp1PWfGRQ3wvygZ6Wu?=
 =?us-ascii?Q?4wpW6++Cu3y5/wp7xBf6qd31TDtJ1VHpfD/fVJ8ye2CPG3FALidkNG8JybQ5?=
 =?us-ascii?Q?a/sCfvTobwm6pR2uTeoB4kUvJRJ/1CtOBZUFsKuPL4bVsREls39c4oND0qG3?=
 =?us-ascii?Q?Fw/A+8Jo+KEZGffPEU+bjLjm5KhhDVwQX2QBnS4luOG5Q6qiJ56GsRGLUXXg?=
 =?us-ascii?Q?I1hU0vTO9dAUUmfoaXvMGg1WP+Q7Ph0hu1pubUApAerTp8v8lkOqGaBsiQG4?=
 =?us-ascii?Q?vJvLd8ZV+ZwPPLv9UaVsB0xW42ul2HRVFRekQ1/3MfvlQebkMFXXd4E4LMmS?=
 =?us-ascii?Q?EGrBpObO8UDm0AaeVNE39V+6KDPoVJ9YH44J79qt9jxHDRpBGj6OhUME13Vb?=
 =?us-ascii?Q?eWfo2h73DzNT2fzRdmum72n9xnMuIPfk+/PSDmhECDACHCeT81Gd1wUwdW9A?=
 =?us-ascii?Q?jWhy8gV+DGagh/RZPV+zpbexOq2EUfARDIncso7foC5wb+438S9/f2n1BKR6?=
 =?us-ascii?Q?TMpCvzHQm5KW/Xi/eFaRxIWh5lLm+RBdmY4LWU2G0l9RvT/l2BwwCHPVqdQc?=
 =?us-ascii?Q?0Yuq/AcRb3Iwu8K45kaUwMuUelz/qealLfSEE9qEHjqcDlt6ghnoBWbAcD6H?=
 =?us-ascii?Q?hnCHol6L9/cdzpwmATDYdgo3DlL0Nqu7SUAT4UOOPtItjOqkuhv9fyFGRVHI?=
 =?us-ascii?Q?Qi4fvlvKIBfKRrgazMNlJMvJAVoTIyi44rg7Cp2Pe7nwUsNkFiQcVjd5GylN?=
 =?us-ascii?Q?3kX1g8hUGp0Eu8Gt9CGE06EBQEzaQhFcNDLgIjYWbcn5KszcdTyp1wn6H+b2?=
 =?us-ascii?Q?uUJpQPzGyksUIwUFT3XyIxluOfdSAUSk6RBQUtBbuGElpd9pRvC0BMXe+Mbb?=
 =?us-ascii?Q?KyeY7X5OoaJECUAPiKGnI0zxUTP+kvDJN/SRPpJQFaMSFAK+vB/qAPQ4kh4o?=
 =?us-ascii?Q?mD5K06dJ47Q0Pq2SEB0/fz5leA/Qa5Jy2etkU9rSYcj9U6kvwnX2LFXJHblH?=
 =?us-ascii?Q?9BXiah5pzCBXcgg2E5KiH8aCaAXRTWr2gCxHotBwOZMDjMFQxWfNaqXkKZu9?=
 =?us-ascii?Q?/SGWvi39jmWY4yBNAGML5G8TWnnk8UG5C24V9bJwsE1LPtmPPzmEO5obxK/n?=
 =?us-ascii?Q?LEWSJTyx22CspuFyc5KtAWCOIKVPGaRJS9ziDVoGp22uemTg3wRVLR2lUfbd?=
 =?us-ascii?Q?83KRaU2rNda//PABImqnGWm8lSiClxyaXTCl4gGD+etkI3aNw+YThcgPH2Q7?=
 =?us-ascii?Q?Tmu4BVWPxLqGqtYf3+uhct/Djyc40bnDrAEzVQeApSs5ptMgUruyWb9FV1Qc?=
 =?us-ascii?Q?KXJG3HvYMNnRGYPHY2NItg4xsoyK+Fu/EKppOuUSFXye3Yc5ZWfGhsStclzL?=
 =?us-ascii?Q?i7dHQEBnFwX24NWK52hx7CqrPNYOtkEsBuyBAeWwE5z7ZCzI2iV+t5B9Rvp7?=
 =?us-ascii?Q?tQLu84wcYoWgYbPp0NBDcZ/vPWa7RRdq8bzPhrn1bA4lJKkQRaKssb+uMRVY?=
 =?us-ascii?Q?Kl9rS5YsQTO4NAZBLe6BHDYbits9iuSLPYgJgfbvym88sE00HCv33jkZ8ZqL?=
 =?us-ascii?Q?szvbYvaVVWmYY8Z9mcI=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2025 08:31:08.4319 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5cb8ee9-3a8e-408e-c3c4-08de3958cc99
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000205.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5900
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

Change to switch style checks and return the correct size for gpu board
metrics.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c | 45 +++++++++----------
 1 file changed, 22 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
index 91a17db7912b..44d5f134a87a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
@@ -693,30 +693,21 @@ static ssize_t smu_v13_0_12_get_temp_metrics(struct smu_context *smu,
 	u32 idx, sensors;
 	ssize_t size;
 
-	if (type == SMU_TEMP_METRIC_BASEBOARD) {
-		/* Initialize base board temperature metrics */
-		table_id = SMU_DRIVER_TABLE_BASEBOARD_TEMP_METRICS;
-		baseboard_temp_metrics =
-			(struct amdgpu_baseboard_temp_metrics_v1_0 *)
-				smu_driver_table_ptr(smu, table_id);
-		size = sizeof(*baseboard_temp_metrics);
-	} else {
-		table_id = SMU_DRIVER_TABLE_GPUBOARD_TEMP_METRICS;
-		gpuboard_temp_metrics =
-			(struct amdgpu_gpuboard_temp_metrics_v1_0 *)
-				smu_driver_table_ptr(smu, table_id);
-		size = sizeof(*baseboard_temp_metrics);
-	}
-
 	ret = smu_v13_0_12_get_system_metrics_table(smu);
 	if (ret)
 		return ret;
 
 	sys_table = &tables[SMU_TABLE_PMFW_SYSTEM_METRICS];
 	metrics = (SystemMetricsTable_t *)sys_table->cache.buffer;
-	smu_driver_table_update_cache_time(smu, table_id);
 
-	if (type == SMU_TEMP_METRIC_GPUBOARD) {
+	switch (type) {
+	case SMU_TEMP_METRIC_GPUBOARD:
+		table_id = SMU_DRIVER_TABLE_GPUBOARD_TEMP_METRICS;
+		gpuboard_temp_metrics =
+			(struct amdgpu_gpuboard_temp_metrics_v1_0 *)
+				smu_driver_table_ptr(smu, table_id);
+		size = sizeof(*gpuboard_temp_metrics);
+
 		gpuboard_temp_metrics->accumulation_counter = metrics->AccumulationCounter;
 		gpuboard_temp_metrics->label_version = metrics->LabelVersion;
 		gpuboard_temp_metrics->node_id = metrics->NodeIdentifier;
@@ -743,7 +734,15 @@ static ssize_t smu_v13_0_12_get_temp_metrics(struct smu_context *smu,
 				idx++;
 			}
 		}
-	} else if (type == SMU_TEMP_METRIC_BASEBOARD) {
+		memcpy(table, gpuboard_temp_metrics, size);
+		break;
+	case SMU_TEMP_METRIC_BASEBOARD:
+		table_id = SMU_DRIVER_TABLE_BASEBOARD_TEMP_METRICS;
+		baseboard_temp_metrics =
+			(struct amdgpu_baseboard_temp_metrics_v1_0 *)
+				smu_driver_table_ptr(smu, table_id);
+		size = sizeof(*baseboard_temp_metrics);
+
 		baseboard_temp_metrics->accumulation_counter = metrics->AccumulationCounter;
 		baseboard_temp_metrics->label_version = metrics->LabelVersion;
 		baseboard_temp_metrics->node_id = metrics->NodeIdentifier;
@@ -758,12 +757,12 @@ static ssize_t smu_v13_0_12_get_temp_metrics(struct smu_context *smu,
 				idx++;
 			}
 		}
-	}
-
-	if (type == SMU_TEMP_METRIC_BASEBOARD)
 		memcpy(table, baseboard_temp_metrics, size);
-	else
-		memcpy(table, gpuboard_temp_metrics, size);
+		break;
+	default:
+		return -EINVAL;
+	}
+	smu_driver_table_update_cache_time(smu, table_id);
 
 	return size;
 }
-- 
2.49.0

