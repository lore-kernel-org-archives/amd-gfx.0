Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9286C982D2
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Sep 2026 03:34:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8999110E077;
	Fri, 18 Sep 2026 03:34:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OVelA1K6";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012044.outbound.protection.outlook.com
 [40.93.195.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A0F3B10E077
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Sep 2026 03:34:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KuUEmepzHuUPU9dvhJf+6a5pxbj/1VT3qwjDiiV+aidDhB6IXiwAQ8xJUFHQykvSvrJ7d9IfjKblSdLpp/MkDWpEQ5E3vvXB4GbICkrOAwJP7u4qrSgl4vybmgVfmFC74tLsbQxOOVdhnjDbK4Jn2U1RedTUZpZPBB+OjtBVXvVAeb5xIj4Es9Ur5TXHkngNSi2rxtfwGAf9lZZww9N0LkTq7+LdJhkAHtk1Kn2/8kFTpLmXnt1bmDfmOElrkbpDwopQ7ronJZmgrHrscISZIX+aPPb+4dqro/7I6Fj8sAn1tyHxTr3HUC876rETn02SrQ+Oq52qDengvMyVEuYsRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ykQM0rQwQ5d/UgmDeRQtBoLuNHhorvu+Y/pCbIYEuRg=;
 b=McGmC2rqkAN10NC8GFLYVF/NCmShkWvfGHFVEP/RGGCVwF+RNYJiUMfNXWKM2GQwLFe215QfjKfI9l+XT56Kl1rBVXYrZo7qgis6R6M/sYRgrrUOSEkCAwhb3ec9dpHfp7Bij6WShHlDO2HY2q+ontMrq1ZyAYaYt+ZYA3f8NzNTP5WA8z0279Y/LgEgvNEZFYXSKLx09eHXGDiTskOLHqAReXa0WcQtF4zZ+ACPLt+wutVUH78/LVWoiqYBnvTVV4PVmWslQLGeTJt/NP+0DG7hRBbh3IBqQ/NmcVyHxd2IlgigDR1S4n6n490+FdLDjePCGJCAcvYfVfP87GO07g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ykQM0rQwQ5d/UgmDeRQtBoLuNHhorvu+Y/pCbIYEuRg=;
 b=OVelA1K6b9A1LjUpfZxvd2zqsEMP55qkYbL+hRoq3VrAE333izBWQXO+Kz0+gTX8rkpdSKWWnSGYeHLXDnE5CyhkZrtRgKXhX9YuEjEOgWBKEV/rWtYz2X1CRtbl6n0LUKJ/0ucG6yOhUP+KbvYihpKzou4bFRhCq2AiFjhE4uE=
Received: from BN9PR03CA0185.namprd03.prod.outlook.com (2603:10b6:408:f9::10)
 by MN0PR12MB5932.namprd12.prod.outlook.com (2603:10b6:208:37f::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Fri, 18 Sep
 2026 03:34:00 +0000
Received: from BN3PEPF00022BCF.namprd03.prod.outlook.com
 (2603:10b6:408:f9:cafe::2c) by BN9PR03CA0185.outlook.office365.com
 (2603:10b6:408:f9::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.12 via Frontend Transport; Fri,
 18 Sep 2026 03:34:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF00022BCF.mail.protection.outlook.com (10.167.248.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Fri, 18 Sep 2026 03:34:00 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 17 Sep
 2026 22:33:58 -0500
From: Kevin Wang <kevin.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <hawking.zhang@amd.com>,
 <kenneth.feng@amd.com>
Subject: [PATCH] drm/amd/pm: report smu energy accumulator updates
Date: Fri, 18 Sep 2026 11:33:45 +0800
Message-ID: <20260918033345.419596-1-kevin.wang@amd.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BCF:EE_|MN0PR12MB5932:EE_
X-MS-Office365-Filtering-Correlation-Id: 55878449-a992-4d22-5629-08df1535add9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|23010399003|36860700016|56012099006|11063799006|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info: qZUXgYf4enh8+g9j0P/t26NG4Ug6gUMlldRuoBP6P+DLsYr66BFKDMT3y5Jg8FkluzZUKQSFWO9mmuIr0jbzLKnqJyyN2dylLoPnr3Yr/Y1Gv7w2xFa8yHKqIUdI0n0CQt42vbawagCb+WoZk7UYtpy9sFafvU2IKw1m1cTHZk1tXQhk56poiU7Sm59FjFFRXrfahJe4rvX+0kfaalRnpspPLDtHnyy/UDXzGUBIY+BvME6vkCDKbh08PIAN2hoIe16G79p/oNxlCILs1Mn1BerI92rxxslMwKcR/QEDZPSiyK8SXxTQ5ogwRhn7gYMVWp83UaC7k59N3kC3QoMOY0l40RkR3jo71mLsftL75NRi7Ji2h5qCAS68R8Yk+KfD4M0Kv0Pu7PRchMW/3kodsnGzAIwQFR3Ao3H0SPGrfCuYLUtCOt8n8SDxx0rcXFiM40SiSXgzvikM+8+6FaZfF1mTbJosj+r0/MxdcrSTLo0hXYIHifuwO4aEJT/juGoI8rUZaJH8Cmol4XumjbxOHINbAeuvoCIgXdQSTnRsleU7LaRzOAERJSgvk2mEXmIa2gH4FDn14vEqjC4Kg23pRORSzs/taHGaWhJX7CAJ7dqs1eyflGPDs7BXVcCPczHBI9RdA88rlVOEdmn50vMDmqKWVyOxVsc+Oebd2G5Gw5bGjnd9VSp1gKESJZxmecwuk1oZz3bZOx5QRig1vFiDtw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(23010399003)(36860700016)(56012099006)(11063799006)(18002099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: pgE65+1hLIfCXo9TG5PQ1T+0QzRdF1F/szdPlbTvkMJZv/wCBYi0vVpfhgXvuSb6svIdQlCgrZTSyFA8oouMqVlAXuiUaxllGJ4cQ8NK/QLv8RHVNZPNjZomiEkbCeBX8KHaxTZ7WjxrgPo1ASJ02FV4s5xLlV+p48v0TLfhCMcCXLsdyS8Nml9QgmpTSpFjQBmPBfmDy/ZsKVQFojF/3bjRMN+tOWyCR/xNEvBl9I21KLwHHTMdm3oiZXFilJyRjKOtbBs3RkR1ecabOkcLPsJ93kd5qltcMRzrxToQbO22OhlNWwLAyTo24hU+bWx1HxC1uHBkhbMsl19VZWFmfdZeBe0HisE8BKmARd3vRcfrc4zTcP0WJGacA+s10eUtdZdpJAPlUp+4At/nCBFA4iO9pmW3D8ij5R8z2VbMV1m1qWw/lO3D6o8ZY0xdyiYf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 03:34:00.3638 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55878449-a992-4d22-5629-08df1535add9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF00022BCF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5932
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

the energy accumulator becomes valid again after an unsupported
firmware range. add gpu metrics gates for:

- SMU 13.0.10: 80.93.0
- SMU 13.0.7: 82.98.0
- SMU 14.0.2: 102.72.0

Signed-off-by: Kevin Wang <kevin.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c | 6 ++++--
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c | 3 ++-
 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c | 7 +++++--
 3 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index e868bfe1f0e1..6eb829d0edb0 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -2093,9 +2093,11 @@ static ssize_t smu_v13_0_0_get_gpu_metrics(struct smu_context *smu,
 	gpu_metrics->average_socket_power = metrics->AverageSocketPower;
 
 	if ((mp1_ver == IP_VERSION(13, 0, 0) &&
-	     (smu->smc_fw_version <= 0x004e1e00 || smu->smc_fw_version >= 0x004e8600)) ||
+	     (smu->smc_fw_version <= 0x004e1e00 ||
+	      smu->smc_fw_version >= 0x004e8600)) ||
 	    (mp1_ver == IP_VERSION(13, 0, 10) &&
-	     smu->smc_fw_version <= 0x00500800))
+	     (smu->smc_fw_version <= 0x00500800 ||
+	      smu->smc_fw_version >= 0x00505d00)))
 		gpu_metrics->energy_accumulator = metrics->EnergyAccumulator;
 
 	if (metrics->AverageGfxActivity <= SMU_13_0_0_BUSY_THRESHOLD)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index b0399dd49639..64590965fe56 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -2097,7 +2097,8 @@ static ssize_t smu_v13_0_7_get_gpu_metrics(struct smu_context *smu,
 					       metrics->Vcn1ActivityPercentage);
 
 	gpu_metrics->average_socket_power = metrics->AverageSocketPower;
-	if (smu->smc_fw_version <= 0x00521400)
+	if (smu->smc_fw_version <= 0x00521400 ||
+	    smu->smc_fw_version >= 0x00526200)
 		gpu_metrics->energy_accumulator = metrics->EnergyAccumulator;
 
 	if (metrics->AverageGfxActivity <= SMU_13_0_7_BUSY_THRESHOLD)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
index d91bfa8998d4..20abf342a30c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
@@ -2172,8 +2172,11 @@ static ssize_t smu_v14_0_2_get_gpu_metrics(struct smu_context *smu,
 					       metrics->Vcn1ActivityPercentage);
 
 	gpu_metrics->average_socket_power = metrics->AverageSocketPower;
-	if (mp1_ver == IP_VERSION(14, 0, 3) && smu->smc_fw_version >= 0x00685000)
-	    gpu_metrics->energy_accumulator = metrics->EnergyAccumulator;
+	if ((mp1_ver == IP_VERSION(14, 0, 2) &&
+	     smu->smc_fw_version >= 0x00664800) ||
+	    (mp1_ver == IP_VERSION(14, 0, 3) &&
+	     smu->smc_fw_version >= 0x00685000))
+		gpu_metrics->energy_accumulator = metrics->EnergyAccumulator;
 
 	if (metrics->AverageGfxActivity <= SMU_14_0_2_BUSY_THRESHOLD)
 		gpu_metrics->average_gfxclk_frequency = metrics->AverageGfxclkFrequencyPostDs;
-- 
2.55.0

