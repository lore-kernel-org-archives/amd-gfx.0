Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5954FD375D
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Feb 2026 06:34:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BB8310E00E;
	Thu, 26 Feb 2026 06:34:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="35bFI4Jy";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013035.outbound.protection.outlook.com
 [40.93.196.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 975D410E00E
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Feb 2026 06:34:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wYGqyd7/9BjAl9hh0J8kbHjclJhveB/R18Ast0CPvmpj/v69814Z4LCj/WBxGSKwcMJkxEB+Wy1zBi/GDaCip4283UHkPnjTT1Ttz0ffqbtrPPaM0Lx8rFpwjF4E1L9s9An6ikY5ykWSkaR9TMNT196o/+YxsHCfKWLtvfO0YT/xyr7ZUQlBvHNkVbRc+KK1M/mfEaM2qL/Ck3WarH1Og85DoxBIlalpKU43lglP8fnHoE6cKyrOVswZcCXWT1CqcfuQLlCkot+3di99wCDlcjFaS7Ud5wjW++H6f1DPBJCm4XFssR1LROnvWLwSXiZXx+InXvqNyq5wrKVr4xvbBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iNkhRjAebNk5ujJMgaSmxhtLllH7oMcWPuyYBSKToVk=;
 b=VRqFDP9nJD0LO7KqEnms/MKZbtt49xsYQ6ywpSMWz3qUb1GkCuvP74S0jqOjv6y4a+sISG0v8l+g35UnxFsnSO0X3KCnpHsMS9+FAHl6Gl0mrzCQJoGN01rm7ZxRgOAH2i3rs+9BBxUapuJdfydiiGa2zdM3pkw5WR5tfX8YZx9DrSodFZHiOfjj1MRW6Yow72xMZ+/Q4aXkkGzck1ik3B3GhKVJpq7cuL8UNK9eGtDjPG9wmAS1DtaDalS7vGB6spymNs9vuCttWE7TyVCltM/qYN4vEXa3Xa06lzECSsnrEJRJ1+FgOj3b0SW2iiCTZW1pxsBJWJNOTjV3tWAduA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iNkhRjAebNk5ujJMgaSmxhtLllH7oMcWPuyYBSKToVk=;
 b=35bFI4JyVX2OD3pOqwA/IQ7s0no8JoeZvC8kx6uJeifMatssiLfcS0jXgMyIIbRCdh+3QK9IPdwF4AKqQ4MRXl618+Xt7btdXXJZczlSqsaT1gObquY4Qvka7Rk0szBcvX3GnmoTi4GzqotmhnYFuRFoc3uvBZ1nbAAVit2Aalg=
Received: from SA9PR13CA0067.namprd13.prod.outlook.com (2603:10b6:806:23::12)
 by DS7PR12MB5959.namprd12.prod.outlook.com (2603:10b6:8:7e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Thu, 26 Feb
 2026 06:34:28 +0000
Received: from SN1PEPF000397B5.namprd05.prod.outlook.com
 (2603:10b6:806:23:cafe::df) by SA9PR13CA0067.outlook.office365.com
 (2603:10b6:806:23::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.21 via Frontend Transport; Thu,
 26 Feb 2026 06:34:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397B5.mail.protection.outlook.com (10.167.248.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Thu, 26 Feb 2026 06:34:27 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 26 Feb
 2026 00:34:25 -0600
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <hawking.zhang@amd.com>,
 <kenneth.feng@amd.com>
Subject: [PATCH v2] drm/amd/pm: remove invalid gpu_metrics.energy_accumulator
 on smu v13.0.x
Date: Thu, 26 Feb 2026 01:34:15 -0500
Message-ID: <20260226063415.509989-1-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B5:EE_|DS7PR12MB5959:EE_
X-MS-Office365-Filtering-Correlation-Id: 837d8929-de9d-4bca-9529-08de75011720
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: GjPPe67M8ZwMvdPlsYhFP5mZeL4jr8XtLp9k8W1Gt/kvyXrKVM8RD8XRNC73lcfaqUkbHnwgPxqozU7sfjYEue/O3CsC5qvN5i3lBn3Z+FZiMKMIlUcwWfopB5+uUHS9SfgjOlMAPRhgBmsZ1QPIBI6WG4g6gP910S3LYIVibh7mypFBCBCa3CVLJDtnfkBxD8pTPYpH6Wr6llXBRqaSZHgK846eT2uvtcj7b3tp1NAIM+h2qPZc3EOXCNHrQxWTzAL3QXXrm3CtmGr2us5LsB5O8JEWfFLu8DOwPHwv/r39rLM78IkA/QWiNSgqRdZIK7k1uwovC70qpcXt0Nk1MIqWIxdRqoV3FZo49DmkhmJIiKXIMt2EjqBZCpXkEVmynB3MhI9wtmYkSv/PhGPuKcuXWQ2xvOrnzLSXzT9traXvZu5lrYxEXWAfrHQy9bPG/i0yH52EoBRDjyTnMflZ8s79FQ+yAe3uW8LUfMjBE72hHHdX1QKPv1mmfj3YKFGFgrX6Wy/XSzcz5y8mLtFFBHCTjVpufLmjQ5jjZKgIXheKYJIZfIenMDF6qXkjsWXyvf/k+sP7KB3+Ej1lEh/1mFL3D5y2V+3BU99RoqY4wB45xijkTvD5Rg4ZUMMv+gSnF4vYQMmV5oLWKsLKcC7SyjIGji57wpDxI6YvxCsc1mz7rodCx0ZRUFWA6R/pAshlavdoDShn6u9wrcbAkZf7CHFespjB8hZm0Ic1R9eFKE8oN7awAZZqTq2OjUDrIku9A01XDTvhHKK8xBefnaOy4QVt20NLF3e+WvMSm15SEnPZZEAyd5H4SDiQNjcLz+NDnpiGGJQEMCvjRXwj3809EA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: alZICNH3NgcRPalEJkcPUVruTwbp2mwsHnswQF/JrM6uoGo0FsuV6GUAtTC2GHz5WwEoG6x8Q6BO08g0CXwJJgy2aO+142qJqwDaCDx2yzTxj5QgZ+NvqHquLna+LqcNi+Ku3D4E9+Ke/IK2pSif1cCC1usZpGcGMiG1sS7hLarCNr+m3yZpU0C3O/jDFiGuT8sLJWHYmn7B2hRpC19XRHAfEQyNUT5hralj5h09r8rojdLeYO8Ot+gYtc4P4FSmbtbVj0dVTMXUUT5RxwMwwgUeo8qYoAPW8bfwccQP32yA67z2hkIJbcmLb2yZtBmBbvQV8cpWBtaNuzzkwBsyjkLCiRcO91CoGchHIKfhctEahXgh+fNmbnKTakzwXhlYmHB5DCnosi+si+XaZd1brHC9XmexgqpXfm0RrLtp16svIrqnBuLQfFM9gJg9yhvi
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 06:34:27.5971 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 837d8929-de9d-4bca-9529-08de75011720
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5959
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

v1:
The metrics->EnergyAccumulator field has been deprecated on newer pmfw.

v2:
add smu 13.0.0/13.0.7/13.0.10 support.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c | 8 +++++++-
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c | 3 ++-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index 468d51f5f918..35d36f2fe7dd 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -2035,6 +2035,7 @@ static ssize_t smu_v13_0_0_get_gpu_metrics(struct smu_context *smu,
 			smu, SMU_DRIVER_TABLE_GPU_METRICS);
 	SmuMetricsExternal_t metrics_ext;
 	SmuMetrics_t *metrics = &metrics_ext.SmuMetrics;
+	uint32_t mp1_ver = amdgpu_ip_version(smu->adev, MP1_HWIP, 0);
 	int ret = 0;
 
 	ret = smu_cmn_get_metrics_table(smu,
@@ -2059,7 +2060,12 @@ static ssize_t smu_v13_0_0_get_gpu_metrics(struct smu_context *smu,
 					       metrics->Vcn1ActivityPercentage);
 
 	gpu_metrics->average_socket_power = metrics->AverageSocketPower;
-	gpu_metrics->energy_accumulator = metrics->EnergyAccumulator;
+
+	if ((mp1_ver == IP_VERSION(13, 0, 0) && smu->smc_fw_version <= 0x004e1e00) ||
+	    (mp1_ver == IP_VERSION(13, 0, 10) && smu->smc_fw_version <= 0x00500800))
+		gpu_metrics->energy_accumulator = metrics->EnergyAccumulator;
+	else
+		gpu_metrics->energy_accumulator = UINT_MAX;
 
 	if (metrics->AverageGfxActivity <= SMU_13_0_0_BUSY_THRESHOLD)
 		gpu_metrics->average_gfxclk_frequency = metrics->AverageGfxclkFrequencyPostDs;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index a6c22ae86c98..4f729f54a64c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -2066,7 +2066,8 @@ static ssize_t smu_v13_0_7_get_gpu_metrics(struct smu_context *smu,
 					       metrics->Vcn1ActivityPercentage);
 
 	gpu_metrics->average_socket_power = metrics->AverageSocketPower;
-	gpu_metrics->energy_accumulator = metrics->EnergyAccumulator;
+	gpu_metrics->energy_accumulator = smu->smc_fw_version <= 0x00521400 ?
+		metrics->EnergyAccumulator : UINT_MAX;
 
 	if (metrics->AverageGfxActivity <= SMU_13_0_7_BUSY_THRESHOLD)
 		gpu_metrics->average_gfxclk_frequency = metrics->AverageGfxclkFrequencyPostDs;
-- 
2.47.3

