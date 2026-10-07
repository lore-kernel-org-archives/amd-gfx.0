Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A58BECA5FFC
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2026 12:03:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FAF910E47C;
	Wed,  7 Oct 2026 12:03:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wLewNVEc";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010066.outbound.protection.outlook.com
 [40.93.198.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB8B210E45B
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Oct 2026 12:03:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qRf7GRw6fS3cXymUvu083mEbfVCXv35akc7Q1lWVWN1sSNYyyxmyzRw1X/vSrtofSfxQAI7MZ/DLB3ekfzVLrqOYJAulh23elarqyOZFwt7pfQfh+sQsNa8LqZcHOn5WFZP4A/ElaQP+AHsw/oGrWxIx2G2uxlnczQMMtGACtrMvBQl4Sj4Hcq0O1vl95opL1ETmt8T1C6Eo6fwLYln83V2iwIH8o+UJ3kiTXQLH53cMZByjPymlpD9um4vuuLGNsHfVjwXV5gPzz+OhT7pxD6m6PB82CHajgv4DQS5MIFGxzj7kZiUMxWT9WYJMPcHDOj8qAAwQcKSeNxOIV9AffA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eDDVY/ccSrQHqqwPNhVysLKKjRXBNZEDEOUDK3g6gzw=;
 b=K2ljM2k6DYS9k2UtN2oi/P18J13I262gsuczQbJdfCZy12GumX/Oflcgk2NLbbXKzOLWo669HC3f7mHB/d2mmWcksLdEZ+L2XHDIuQTJgwcC+wueMTEhfLBuPv2t+kUNIS9zTnu6Z+hue/3CUfNOpyon2DVhX7owF35r1J/5fnrZYW35qZQzqAEZgOYEH36N0kYypqL2/KUVodGyY/3s8ozk0CAAaLuJODXWGc5GIqoFP1OoW1rgQ1QUDaVJl9Y3mJUvKUinBubLI+4Jov5tsc7sIU0yBSEnOMYGUJ+UMYo/vpZuJWciceehFx+qrzuMssyHwypx+hglgEMM/pjsmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eDDVY/ccSrQHqqwPNhVysLKKjRXBNZEDEOUDK3g6gzw=;
 b=wLewNVEcAJ7fBDg0NM6f3C3RzIIfU3U2Ytm/JwL4awUvI/Kbpe+rWwpS6ZKTjfJs20BL9BxeaccaezBip6ij4PDh5duQSBoyW1zks8RyyMAwlKEeHdMdvXzfsQYul4KuOkWNiUkP7i4ttOA1eHdOioCsEitArNZ60hyH2GZH8Ys=
Received: from SA0PR11CA0102.namprd11.prod.outlook.com (2603:10b6:806:d1::17)
 by SJ2PR12MB8926.namprd12.prod.outlook.com (2603:10b6:a03:53b::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Wed, 7 Oct
 2026 12:03:40 +0000
Received: from SA2PEPF00003F62.namprd04.prod.outlook.com
 (2603:10b6:806:d1:cafe::3d) by SA0PR11CA0102.outlook.office365.com
 (2603:10b6:806:d1::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Wed, 7
 Oct 2026 12:03:40 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003F62.mail.protection.outlook.com (10.167.248.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Wed, 7 Oct 2026 12:03:39 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 7 Oct
 2026 07:03:37 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <Asad.Kamal@amd.com>
Subject: [PATCH] drm/amdgpu: Allow cancelling a requested NPS mode
Date: Wed, 7 Oct 2026 17:33:21 +0530
Message-ID: <20261007120321.3516957-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F62:EE_|SJ2PR12MB8926:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e8fdba8-e757-40d1-620a-08df246b0685
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|23010399003|82310400026|1800799024|11063799006|56012099006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: sZ6x6V93eKWocNSut3ZpMoiEP2Es8PwKSS+L5KiGOG6ZKuwFcu1EQo+ukOFtsiFsV6WWKZf9+FigZ379N3usWMnEfXyLgKhWu/ZXO3VNYeShxUo/t9jW1ndC0cdojI0fYvy29wF1eZ+IklYdd+gfYxit8UQE2ZEE+bjSLKxiYoI5NldHPl3iblnXVWGd1k9WMsGIXvWdP6ZAVvWzzN93gjEoUap/rVaV4/45wNynuMZxcfIGQMgxL+0wGwHxqfT15ktb0nQiw54jGCbeMCrMnrr8Whczo5mD0kE2QwsyNNd68SFZ7fzyRujQOeS1/dDQFD1dhFM5asa3fpNpQ58rHq+SNJx0/CZfogB/l1UdJg99Cl+Sm3N6bqpU4JISMCDHwU6Tgn0Fl5ksfEa+qtfmdnEoLV/SkEjIc7zFUvyQ5wT85qoHUHG5NIJ6Lrp6Rz2dG/Rvb++zOTW2hDP47z3hmXUx4D/tPOf9W6l9ccS7tK9f7/U2U5Nt/zVT5twpfd0jmjQe3I/eA/hwIBZ8Ke2tNNV/ALSikgjehzOd8cbjgDmAGsvc+/svIndWo1DJBshRELhlwYLvWTNsWsi/wNXZiXhlft41wBFwel7/ouR6186lw+r68nc4H0lg7ocCuyQ/Tsfk6m5u6PEyJ0FdXfposvZeaxXdPnGCg76NVtHkcjOLcYDjm2qu2qteQ04UIPaUiT6RSDvrDX2nZ3+26J2xfg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(23010399003)(82310400026)(1800799024)(11063799006)(56012099006)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: eTPBf4PPUKbPul3gEZ1l94D9g2fy/MUampyMoy3ZlPl+ro7wvE8TrEc9iv15YxUSXamEEybWn2zBtK6LObdqiqC6om1YHUgTfi5KobkaFkFC1rvSs5g5xqIHtWzmlzAjkhR61/IPjE1Z6pnXY1jS1aQIOGVGP/aiyP+1QZlk97lxW/Z1ih3hy6fyzu+j6AT8z7k3AuQGVQhu/ihUhZGv4IJStwccTMWHn3WLL+5n3F1NORxRcZ88XG+dww3xOTWtKZyaHVQYXTNaYqsUfooLGhcNcxd7SH1mv+LPdgRszToqXXDow7dJ3bHYF/kNaPlVBeQXJNuQa/GYytI9lH1wJoqwg8aOfdDmPgLZYydW2ADI9Vjo60XcNP1Wf4NYzoMfG/0dURt5sZ96fmaoeIXWC3XG9DbQUKvOvEkIrhhF/zWYLyBnipy4lUwAbqhHKPDr
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 12:03:39.9082 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e8fdba8-e757-40d1-620a-08df246b0685
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F62.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8926
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

NPS mode change request doesn't allow to request the current mode. This
causes an issue where a user stores a request and later wants to cancel
the request by writing the current mode back. Th pending request stays
the same as before.

Allow user to change the mode by comparing against the cached request.
Writing the current mode back clears the pending request without asking
for a reload.

Fixes: 012be6f22c01 ("drm/amdgpu: Add sysfs interfaces for NPS mode")
Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 52 ++++++++++++++++++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h |  4 ++
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   | 13 +++++++
 3 files changed, 56 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index d25ca903e21b..87d78fd34e23 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -1398,6 +1398,40 @@ static ssize_t available_memory_partition_show(struct device *dev,
 	return size;
 }
 
+void amdgpu_gmc_set_requested_nps_mode(struct amdgpu_device *adev,
+				       enum amdgpu_memory_partition mode)
+{
+	struct amdgpu_hive_info *hive;
+
+	/* If device is part of hive, all devices in the hive should request the
+	 * same mode. Hence store the requested mode in hive.
+	 */
+	hive = amdgpu_get_xgmi_hive(adev);
+	if (hive) {
+		atomic_set(&hive->requested_nps_mode, mode);
+		amdgpu_put_xgmi_hive(hive);
+	} else {
+		adev->gmc.requested_nps_mode = mode;
+	}
+}
+
+enum amdgpu_memory_partition
+amdgpu_gmc_get_requested_nps_mode(struct amdgpu_device *adev)
+{
+	struct amdgpu_hive_info *hive;
+	enum amdgpu_memory_partition mode;
+
+	hive = amdgpu_get_xgmi_hive(adev);
+	if (hive) {
+		mode = atomic_read(&hive->requested_nps_mode);
+		amdgpu_put_xgmi_hive(hive);
+	} else {
+		mode = adev->gmc.requested_nps_mode;
+	}
+
+	return mode;
+}
+
 static ssize_t current_memory_partition_store(struct device *dev,
 					      struct device_attribute *attr,
 					      const char *buf, size_t count)
@@ -1405,7 +1439,6 @@ static ssize_t current_memory_partition_store(struct device *dev,
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = drm_to_adev(ddev);
 	enum amdgpu_memory_partition mode;
-	struct amdgpu_hive_info *hive;
 	int i;
 
 	mode = UNKNOWN_MEMORY_PARTITION_MODE;
@@ -1419,23 +1452,16 @@ static ssize_t current_memory_partition_store(struct device *dev,
 	if (mode == UNKNOWN_MEMORY_PARTITION_MODE)
 		return -EINVAL;
 
-	if (mode == adev->gmc.gmc_funcs->query_mem_partition_mode(adev)) {
+	if (mode == amdgpu_gmc_get_requested_nps_mode(adev)) {
 		dev_info(
 			adev->dev,
-			"requested NPS mode is same as current NPS mode, skipping\n");
+			"requested NPS mode is same as current/already requested NPS mode, skipping\n");
 		return count;
 	}
 
-	/* If device is part of hive, all devices in the hive should request the
-	 * same mode. Hence store the requested mode in hive.
-	 */
-	hive = amdgpu_get_xgmi_hive(adev);
-	if (hive) {
-		atomic_set(&hive->requested_nps_mode, mode);
-		amdgpu_put_xgmi_hive(hive);
-	} else {
-		adev->gmc.requested_nps_mode = mode;
-	}
+	amdgpu_gmc_set_requested_nps_mode(adev, mode);
+	if (mode == amdgpu_gmc_query_memory_partition(adev))
+		return count;
 
 	dev_info(
 		adev->dev,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index 76e6f1f96913..89f1ee829eea 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -484,6 +484,10 @@ enum amdgpu_memory_partition
 amdgpu_gmc_get_memory_partition(struct amdgpu_device *adev, u32 *supp_modes);
 enum amdgpu_memory_partition
 amdgpu_gmc_query_memory_partition(struct amdgpu_device *adev);
+void amdgpu_gmc_set_requested_nps_mode(struct amdgpu_device *adev,
+				       enum amdgpu_memory_partition mode);
+enum amdgpu_memory_partition
+amdgpu_gmc_get_requested_nps_mode(struct amdgpu_device *adev);
 int amdgpu_gmc_init_mem_ranges(struct amdgpu_device *adev);
 void amdgpu_gmc_init_sw_mem_ranges(struct amdgpu_device *adev,
 				   struct amdgpu_mem_partition_info *mem_ranges);
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 85ba228f002d..5c233acba084 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1617,6 +1617,7 @@ static int gmc_v9_0_early_init(struct amdgpu_ip_block *ip_block)
 static int gmc_v9_0_late_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
+	bool nps_switch_support;
 	int r;
 
 	r = amdgpu_gmc_allocate_vm_inv_eng(adev);
@@ -1641,6 +1642,18 @@ static int gmc_v9_0_late_init(struct amdgpu_ip_block *ip_block)
 		amdgpu_ras_reset_error_count(adev, AMDGPU_RAS_BLOCK__HDP);
 	}
 
+	nps_switch_support = !adev->gmc.xgmi.connected_to_cpu &&
+			     (hweight32(adev->gmc.supported_nps_modes &
+					AMDGPU_ALL_NPS_MASK) > 1);
+	/* Initialize requested NPS mode to be the same as current mode */
+	if (nps_switch_support) {
+		enum amdgpu_memory_partition mode =
+			amdgpu_gmc_get_requested_nps_mode(adev);
+		if (mode == UNKNOWN_MEMORY_PARTITION_MODE)
+			amdgpu_gmc_set_requested_nps_mode(
+				adev, amdgpu_gmc_query_memory_partition(adev));
+	}
+
 	return amdgpu_irq_get(adev, &adev->gmc.vm_fault, 0);
 }
 
-- 
2.49.0

