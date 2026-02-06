Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EF9DEE2091
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Feb 2026 11:25:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD1D710E189;
	Fri,  6 Feb 2026 11:25:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ecFT/m07";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011069.outbound.protection.outlook.com
 [40.93.194.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C7F1310E083
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Feb 2026 11:25:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K2NRY2KZSOt3LhzvFFIVmhnTcWHz3252kGrOl1uCBv+aJgphACK1ynvdAzVMEEIEEAyqJYktjjuvK57RCcod0TpuYmUSweis8cAWiDYxOONmdoJ6/Ct6mBSOR4OSKxgH4uN/un/i/Yce2XuCQCWkUW3/MaTKf70Go2UF1FN3/k6OIs+sF4v5xn520ZVbFRLaigcxxIJEmR5c9iYlZ3cBTlfQXV0/XSFUN4NT3jBPJHTzSdsp+/gNXu/+ss8ZxPDBqaaU7jTc1ZQNKIBBvksM0iGv2OvVTdfQ4ycCWaFCQ3+HJze1EgYApUSU+du0F1UPNJj0MdUda+ZM3iZSQlws7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yV1zPb7IcM4wSvzZ/uRNkiN4aZStSpOgeWZfiZfibNY=;
 b=pVFTphDXsaBYPhjtznL0Iv3gXLrfhZIt4PLC2UrwGPUvbMnLQ15WWzuvb9Cq7NO/oYK6FnMJlSD/o7iMmWGmG1DAU/bWVgFpa+dgIsNLcl/AdCUGfeCas2dyZoOPv4It1fbXHtrHtOi4oK3sE9PLdYF1eeK62V3J24U8sWaZQkZFkcGjrCPP39tsrfMIwbnBzN3x8e9MldPD8jsRu7bd9xKtSvUJo3HEEwnRHAlRapH3JNCIFIL0+t37t5ZJ4G0Uhdt5ux6HWQh35Qxn0Jv3Hos372T9h0SLy6APH61MbM+wWI4IzA2sAWDJRTqddkLA6/C0AfZcpNBpIA2qZlB2kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yV1zPb7IcM4wSvzZ/uRNkiN4aZStSpOgeWZfiZfibNY=;
 b=ecFT/m07rGFzRJBvzVZUtBjSiOqjRIk9CbKseJULe/wdZFbihikrSSToKuXFazwEKd/2T3GBcGDLLyg/ej2F0Y8O/Wn9qC8tAdh8YOAMZCCjLMZmyFB39pECOgk1KGfx7p/uPMfxMsvdY0+jlA0Y+K54JxUuBVUE5bP0tkrmWEc=
Received: from MN2PR01CA0034.prod.exchangelabs.com (2603:10b6:208:10c::47) by
 MN2PR12MB4341.namprd12.prod.outlook.com (2603:10b6:208:262::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.15; Fri, 6 Feb
 2026 11:25:13 +0000
Received: from BL02EPF00029929.namprd02.prod.outlook.com
 (2603:10b6:208:10c:cafe::cf) by MN2PR01CA0034.outlook.office365.com
 (2603:10b6:208:10c::47) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.16 via Frontend Transport; Fri,
 6 Feb 2026 11:25:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00029929.mail.protection.outlook.com (10.167.249.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Fri, 6 Feb 2026 11:25:12 +0000
Received: from BLRPVISHWAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 6 Feb
 2026 05:25:11 -0600
From: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
To: <Alexander.Deucher@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: <Lijo.Lazar@amd.com>, Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
Subject: [PATCH v3 04/11] drm/admgpu: Update metrics_table for SMU15
Date: Fri, 6 Feb 2026 11:24:42 +0000
Message-ID: <20260206112449.45381-4-Pratik.Vishwakarma@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260206112449.45381-1-Pratik.Vishwakarma@amd.com>
References: <20260206112449.45381-1-Pratik.Vishwakarma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00029929:EE_|MN2PR12MB4341:EE_
X-MS-Office365-Filtering-Correlation-Id: c84af78f-a9cb-41e8-dc18-08de6572651f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?IGRQQNb3sjsu94l3y6h5bjlkJLCoMguU+4BgzUokrFEztxOAY4aeQwM3sFAa?=
 =?us-ascii?Q?E6WCY+QKvzgwHqrcY7TIl3j/jOEP1usGoDQx8M8ianwWgwTHzzLA3UBGiFe1?=
 =?us-ascii?Q?lhBPdEedQIzTxQj4/zFbwIvB6VF+mRMtWcJgk83ppNL9WNXQO+M0S6XZox1j?=
 =?us-ascii?Q?q5IkOzOQrrB5FchHBwlffhisLjSr/d/xt7//nZsK9r/FKFoiUBbhteBCZcEp?=
 =?us-ascii?Q?CbPLdRX3lqHwpIHJMAs8X0n4W9My87v6vzpawxCdNyYRMAJtHsuGyWHrcutn?=
 =?us-ascii?Q?8gxmNug6REK00EbRJpIsDhij6rJp0rYswxiXcRCJ8kMb40dc6VtD+TbOUxm4?=
 =?us-ascii?Q?SrM+/NQvA//nVDZMR9/Pl6Zs+zSwjpHWMLbzpA8nvp3x5jXFxfh61mo8nO7i?=
 =?us-ascii?Q?X4gt7tag/BSLWQ0VVI4n3JlZh4dZDfLsc37c/sSTqPJpGXctxvUjRU4rweee?=
 =?us-ascii?Q?bn/I2tvHRqr7urqeIZKM4CMm2VC8CklLvMeQcyAEHrUJKpn58d6axJSdqdCs?=
 =?us-ascii?Q?gS2HRVP3JSSYAkVly/TafFZBYPsL3KBToOmRHPLPPksVezNaaQNp2sHGLVEn?=
 =?us-ascii?Q?pO1gpcJtTH6S8sd+QApyHuFA4GNeapB3k5qs+te2/zPPP+P8hsHwqtoEFxqG?=
 =?us-ascii?Q?GbZ7oJfykeKmiIMxqCL02ozso2D0leY8fMWs3lWa/DmbE8YF1MfHMuS9psyk?=
 =?us-ascii?Q?NFwNB6KIleHEDGgyOHBiCdwNtw+OzpkchZ5Cyuc6A7hhiLoqw/yOwSZJtE5Y?=
 =?us-ascii?Q?eusF3m0CbnzqaImSMUp3BruW4/VgR2XsG6ibsfRxQ+jW2JMjWs1ztF1xC14B?=
 =?us-ascii?Q?sAVPq6pf//ottCymqXhGkOcxisNfFwnwaELHW47LrIS8HL8TVvZdC6YBs7sv?=
 =?us-ascii?Q?q5xYsItYQMV0oIyso7St6izEKnDGmn99656iSzHea2K/TEv05iXymLKbKC5e?=
 =?us-ascii?Q?YnoBsW2MCfWUD1Y6uUHg1o1wbij8UjXN5L7tobUQz1eoY4RirsKTI4NT/5vk?=
 =?us-ascii?Q?I7L8Y04Sn5zjF+F9gGZSVocfY+0bvSc0vFoKJYGGazYwpbllifgJQgw2Xwyw?=
 =?us-ascii?Q?mHilzNXOjJ68x+D16wO04he9yWl8CJkN4ZJZMwbggQEI5k+2jpMmfxzcRBGA?=
 =?us-ascii?Q?gEb0PGwXJIKSmGgUnv4yIzDX5NcaIp4tbaS9FL7TazDQYJisRD7upDClRd4p?=
 =?us-ascii?Q?JGSX/q5gNp2N4KOCIg1pS+8EVi6cBiBJmtI5BsXhVgIvc4XKHy6aR+AjYuYN?=
 =?us-ascii?Q?yPHYEt8AaTMklLmeCVKmzTgx50wogi0Mg+5he09qDugCZJm0TiX3T1VigBcY?=
 =?us-ascii?Q?hQrBM5sBNr2FrARZGW+9iIAL+J0ji01x5nZVEhinm2V+y2ijS2DPV+H3D4lr?=
 =?us-ascii?Q?S8v45Kz9pQSq0E56Xrdkih3+UxaBVtUpc1S+Ukbrdd8HxL+KLR9nA4fce+fP?=
 =?us-ascii?Q?K9c1kUed2b9+GsweSJHR/YAZXBQxSLLpmwooRZpTkraMlN+k77HzJyIGik1x?=
 =?us-ascii?Q?tMilCm8CS4R+Q2valqT7YlG99Y0R5lpvpVDUSA3OMdR5QsTXWUcpnWLRjfK2?=
 =?us-ascii?Q?rDWWSMgx5iXTFoC+jC/ZWbK0fOUMM/DM1pUMOLFzemqrNF2NkZHy8D0/LWKx?=
 =?us-ascii?Q?nEXzIxkrJKX8NgGNGz4WN2024vYqUEZIr5l/+laZBSbZg/hjp7wMaWGCA2KP?=
 =?us-ascii?Q?AgPGkg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: feZMuqvyFiVJyARzQLSs5l1ZiXYWlzvQbPePB243aQ9BRpUZd/7TgL8Tn7umAijtLgbso5fC3anqNPPikRxK+a7cGM7gnIf/5Fbe9ORCkiIbV+fLgnbAMRmlzI85AWfGS2zTSu3lJHXVgyG51PxpcHPnsqKzZWAxyj73zdZcy/JwZsE+QVp/rpAI8NPNIUbMVvYekOjXynrRxJ7JUGY2NzbCZnUxixrrCy7gt5eVi/gZMBn5Swv38VmD1RGY/l7SCropbp5JyDtX5rHbCJ0isbYXLOMaQDZwX9C+sM1cjckrPsmMtBWXOwx4XgWaL5wBYVXRK1jZD7iedJUylW51AlP50MzLEq8onC1AGXqjr5yQoxCQ6YLzGO2v1R10iCb1YIUOGHooarxeCaxaQwr8FvFS2M4E7eIqamXNet+u4SBm7v8ah78Lck/w0Plkl/VE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 11:25:12.9992 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c84af78f-a9cb-41e8-dc18-08de6572651f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00029929.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4341
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

Use multi param based get op for metrics_table

Signed-off-by: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
---
 .../drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c  | 34 +++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
index d58b0bc2bf78..2987ff1b13e4 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
@@ -246,6 +246,36 @@ static int smu_v15_0_0_system_features_control(struct smu_context *smu, bool en)
 	return ret;
 }
 
+static int smu_v15_0_0_get_metrics_table(struct smu_context *smu,
+							void *metrics_table,
+							bool bypass_cache)
+{
+	struct smu_table_context *smu_table = &smu->smu_table;
+	uint32_t table_size =
+			smu_table->tables[SMU_TABLE_SMU_METRICS].size;
+	int ret = 0;
+
+	if (bypass_cache ||
+		!smu_table->metrics_time ||
+		time_after(jiffies, smu_table->metrics_time + msecs_to_jiffies(1))) {
+		ret = smu_v15_0_0_update_table(smu,
+						SMU_TABLE_SMU_METRICS,
+						0,
+						smu_table->metrics_table,
+						false);
+		if (ret) {
+			dev_info(smu->adev->dev, "Failed to export SMU15_0_0 metrics table!\n");
+			return ret;
+		}
+		smu_table->metrics_time = jiffies;
+	}
+
+	if (metrics_table)
+		memcpy(metrics_table, smu_table->metrics_table, table_size);
+
+	return 0;
+}
+
 static int smu_v15_0_0_get_smu_metrics_data(struct smu_context *smu,
 					    MetricsMember_t member,
 					    uint32_t *value)
@@ -255,7 +285,7 @@ static int smu_v15_0_0_get_smu_metrics_data(struct smu_context *smu,
 	SmuMetrics_t *metrics = (SmuMetrics_t *)smu_table->metrics_table;
 	int ret = 0;
 
-	ret = smu_cmn_get_metrics_table(smu, NULL, false);
+	ret = smu_v15_0_0_get_metrics_table(smu, NULL, false);
 	if (ret)
 		return ret;
 
@@ -530,7 +560,7 @@ static ssize_t smu_v15_0_0_get_gpu_metrics(struct smu_context *smu,
 	SmuMetrics_t metrics;
 	int ret = 0;
 
-	ret = smu_cmn_get_metrics_table(smu, &metrics, true);
+	ret = smu_v15_0_0_get_metrics_table(smu, &metrics, true);
 	if (ret)
 		return ret;
 
-- 
2.43.0

