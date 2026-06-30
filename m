Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1333CC43458
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Jun 2026 02:54:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 875E310E09E;
	Tue, 30 Jun 2026 02:54:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RWuzgRwi";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012057.outbound.protection.outlook.com
 [40.93.195.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E0A410E09E
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Jun 2026 02:54:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=di5v+gC8Sf73GGssPPiB0BylIyQzKvNOPCNLkxKlolcmQ4D1ffxwEmllv5K9ORdCVaF7vidaYg8VPjAmj0CXCPhdGttuUxMRDQTXgtSNs/lBvEwIfB78mLsuPNLaZpB07e1YfvzdQQ72+lXue7pl2/lBEfi78Ferm/GMu2mbcPmVIrnM68KVhak8HrJ9tMJu3rEP5KM7s2MtBATRvWR07+B+G8WG2HkaFpdHlC0KysP881aPOZy/LsPhpjkV2QWT1QbzJr4UifrEAnSknQ1O24bs5af09iTGpTbcfEv2wXjX9iiozNt77XkvhSYI6DY2hhm6Cl4+e0C+5aBLrw5Ntg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LpHWBqkgD3P8GwTNA/YxCNZ6SwTaSBnzYmSJMchSIfk=;
 b=I1iB44NsL5poZv/VDB5tw3J1h3RlpzIbqvL6piBISCYE8JzAJs7jFjY+B41p2Fbik962dwNZ99dITO7IWoqXkdYAfUxQbJycA/8j/XObXymiqdN+6J7WTA2GWHyG0PwHF7YZ5jPCxn9jjm06gxHvqpzBjzQeWE1NA61XEze2tHeRDqYm76sOB5gpaKD1/YUt/WkMkUCiYBsZnnPUTmKUJ5aFbvSoXNkBULCKZR0Hu745fl6PfLnetwCeYnn2cxE6P4f5s7NRmlwsdPqln6ZVYJm2kW3DpAKM1J6X/ErCUXl6lAyukz3GW8QOefDayfJFQG4oIs9aA6Mv7Zg/wo/0rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LpHWBqkgD3P8GwTNA/YxCNZ6SwTaSBnzYmSJMchSIfk=;
 b=RWuzgRwiyqTV6vCUa7eU+8ojcieGOcGy6mV+j5d/EjpIjTrdyxa4BG28ohrytKDpsTTlMl/4uiyyFNQJBWTNREn5h4jsR+PUV77ol1k4SztvvboVfwm289tynECqiD3Ij0Fdp1pdvN6e+ev/JC92+u3tzRV/5UAcx3VNsQG4xdI=
Received: from CH0PR03CA0342.namprd03.prod.outlook.com (2603:10b6:610:11a::16)
 by SA1PR12MB7176.namprd12.prod.outlook.com (2603:10b6:806:2bd::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 02:54:17 +0000
Received: from CH2PEPF00000142.namprd02.prod.outlook.com
 (2603:10b6:610:11a:cafe::93) by CH0PR03CA0342.outlook.office365.com
 (2603:10b6:610:11a::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.19 via Frontend Transport; Tue,
 30 Jun 2026 02:54:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF00000142.mail.protection.outlook.com (10.167.244.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 30 Jun 2026 02:54:16 +0000
Received: from chonglidebug.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 29 Jun
 2026 21:54:14 -0500
From: chong li <chongli2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Emily.Deng@amd.com>, <HaiJun.Chang@amd.com>, chong li <chongli2@amd.com>
Subject: [PATCH] [PATCH] drm/amdgpu: improve the amdgpu device init progress
 in sriov mode
Date: Tue, 30 Jun 2026 10:53:20 +0800
Message-ID: <20260630025341.2101161-1-chongli2@amd.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000142:EE_|SA1PR12MB7176:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e253ecd-df21-41b1-40b4-08ded652e011
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|82310400026|376014|36860700016|18002099003|6133799003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: mk29gRLdUGTRnJ6OYmP4iYiL2Geh/z0TwzdYyoC8/v8WOzktsXJZDtw6+l8WbcIZAVQ787I/VQ2aDIwgW46EDabPLZdKIXetlJsy0xua5i3rFkEOIDnlWikVjotPKPzmB3kLdNV6gzhJKGTkGN6Q4ZgsnoAtH4ceLK2Klgvp3X2m+XWdzQyqxCL7h20nDtHHYQ3pA4ymR33BhO4LwGsH2BSAU0MPX+mffc2LZOqpuOWdFGm2L2GBoIH0Shj3scslM8Y0pyZrp9Au7o2P2Dj0/Z4tXP7omJvDxkX56dsn/gjUMwrDq3sDL9RAKQjuoR0jBegzf1/2/jyhfKkAOMZsoQc3J+MYJZxp40TU+tiaurXT4ELB5ZeDd6pJ0bYb6bkSQcl0XVwmnIvcVp4nFpgf3Aqoe/mN8whVpRFJVY41TWsDtpc09uzRqvzVmYM+SHHFlpOvknXyfeRyU2Wgvm/KtpGMlaAQEcCyfcBl8wG62VolhRVNQ+b4ouzk8J2wBGkZybTQLimEpLo0aQkdFshNmzlGUov2mIF4Qa4voyiZHMdJ1MyM7to6z7ZZ2NZ59il26ika4bn8eF5OPS6f8djolFsXLcZvLThL9r6wkNch8JDFPBf7Hcy6xK/EazvHOLsdWrZOoSPEV2VtKoCjF2l0mS8Oc5+B/lSDsHDuEU5bAdI6cQECapW3ETUONVRm+8PnYFoVxC+oBuh2Il0bS4CttA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(82310400026)(376014)(36860700016)(18002099003)(6133799003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 7LgnoCDEmAlFtcSrOukwiW+h45dMgFSHHyHZ+5IwjAyotz5p7FoN4xkGpvguxgq0p+pYSYlr/Kpidg2skF9K1A9+phpwH3MKMfKc1l6zK1GvsX4yxC82w3l6Bfu3Djzvvn+sUTLLneW7RUvsRx8so0582dzNSrVp4EvvF2ntJZoDJxRMUoSlacBIJqFaHd2eUDuWPu9i9g2TX4YN6vE7UvzISCGyufF261cPoFPye565/LArLc2pNZrMEraGxVUwf7kXmflWmMQeIHXIRPxTzjtDhA7jFw0cKpYWT2+UEEbHbwa1W/0T67jWP2hREQAk3tmRta556cO5thDs2DiJi/r3WTP6sVUFfRKOtM95jU4Ftken0OimLyuBazuYTPHHu3GXKgBYrricyxKOmqXAowWqYdfykh+88YIxk5fQcPufct3zINYALDVJeARTN56R
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 02:54:16.7544 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e253ecd-df21-41b1-40b4-08ded652e011
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000142.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7176
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

Move the initialization of non-GPU resources
out of the full GPU access region during AMDGPU device initialization

Signed-off-by: chong li <chongli2@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  10 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 131 ++++++++++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c      | 138 +++++++++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h      |   2 +
 4 files changed, 181 insertions(+), 100 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 5442a1fc1c37..247779cbf394 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1953,10 +1953,6 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
 	amdgpu_device_enable_virtual_display(adev);
 
 	if (amdgpu_sriov_vf(adev)) {
-		r = amdgpu_virt_request_full_gpu(adev, true);
-		if (r)
-			return r;
-
 		r = amdgpu_virt_init_critical_region(adev);
 		if (r)
 			return r;
@@ -2118,6 +2114,12 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
 	if (!total)
 		return -ENODEV;
 
+	if (amdgpu_sriov_vf(adev)) {
+		r = amdgpu_virt_request_full_gpu(adev, true);
+		if (r)
+			return r;
+	}
+
 	if (adev->gmc.xgmi.supported)
 		amdgpu_xgmi_early_init(adev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 029931f4e6ed..26916ebca452 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -26,6 +26,7 @@
 
 #include "amdgpu.h"
 #include "amdgpu_discovery.h"
+#include "amdgpu_virt.h"
 #include "soc15_hw_ip.h"
 #include "discovery.h"
 #include "amdgpu_ras.h"
@@ -292,21 +293,54 @@ static int amdgpu_discovery_get_tmr_info(struct amdgpu_device *adev,
 	u32 msg, tmr_offset_lo, tmr_offset_hi;
 	int i, ret;
 
-	if (!amdgpu_sriov_vf(adev)) {
-		/* It can take up to two second for IFWI init to complete on some dGPUs,
-		 * but generally it should be in the 60-100ms range.  Normally this starts
-		 * as soon as the device gets power so by the time the OS loads this has long
-		 * completed.  However, when a card is hotplugged via e.g., USB4, we need to
-		 * wait for this to complete.  Once the C2PMSG is updated, we can
-		 * continue.
-		 */
+	if (amdgpu_sriov_vf(adev)) {
+		u32 ipd_size_kb =
+			adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_IPD_TABLE_ID].size_kb;
+
+		*is_tmr_in_sysmem = false;
+
+		if (ipd_size_kb) {
+			adev->discovery.offset =
+				adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_IPD_TABLE_ID].offset;
+			adev->discovery.size = ipd_size_kb << 10;
+			if (!adev->discovery.size)
+				return -EINVAL;
+		} else if (adev->virt.req_init_data_ver == GPU_CRIT_REGION_V1) {
+			vram_size = RREG32(mmRCC_CONFIG_MEMSIZE);
+			if (vram_size == U32_MAX)
+				return -ENXIO;
+			else if (!vram_size)
+				return -ENODEV;
 
-		for (i = 0; i < 2000; i++) {
-			msg = RREG32(mmMP0_SMN_C2PMSG_33);
-			if (msg & 0x80000000)
-				break;
-			msleep(1);
+			adev->discovery.size = DISCOVERY_TMR_SIZE;
+			adev->discovery.offset = (vram_size << 20) - DISCOVERY_TMR_OFFSET;
+		} else if (amdgpu_sriov_xgmi_connected_to_cpu(adev)) {
+			ret = amdgpu_acpi_get_tmr_info(adev, &tmr_offset, &tmr_size);
+			if (ret)
+				return ret;
+
+			*is_tmr_in_sysmem = true;
+			adev->discovery.size = DISCOVERY_TMR_SIZE;
+			adev->discovery.offset = tmr_offset + tmr_size - DISCOVERY_TMR_OFFSET;
+		} else {
+			return -EINVAL;
 		}
+		goto out;
+	}
+
+	/* It can take up to two second for IFWI init to complete on some dGPUs,
+	 * but generally it should be in the 60-100ms range.  Normally this starts
+	 * as soon as the device gets power so by the time the OS loads this has long
+	 * completed.  However, when a card is hotplugged via e.g., USB4, we need to
+	 * wait for this to complete.  Once the C2PMSG is updated, we can
+	 * continue.
+	 */
+
+	for (i = 0; i < 2000; i++) {
+		msg = RREG32(mmMP0_SMN_C2PMSG_33);
+		if (msg & 0x80000000)
+			break;
+		msleep(1);
 	}
 
 	vram_size = RREG32(mmRCC_CONFIG_MEMSIZE);
@@ -322,35 +356,22 @@ static int amdgpu_discovery_get_tmr_info(struct amdgpu_device *adev,
 	if (vram_size)
 		adev->discovery.offset = (vram_size << 20) - DISCOVERY_TMR_OFFSET;
 
-	if (amdgpu_sriov_vf(adev)) {
-		if (adev->virt.is_dynamic_crit_regn_enabled) {
-			adev->discovery.offset =
-				adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_IPD_TABLE_ID].offset;
-			adev->discovery.size =
-				adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_IPD_TABLE_ID].size_kb << 10;
-			if (!adev->discovery.size)
-				return -EINVAL;
-		} else {
-			goto out;
-		}
-	} else {
-		tmr_size = RREG32(mmDRIVER_SCRATCH_2);
-		if (tmr_size) {
-			/* It's preferred to transition to PSP mailbox reg interface
-			 * for both bare-metal and passthrough if available */
-			adev->discovery.size = (u32)tmr_size;
-			tmr_offset_lo = RREG32(mmDRIVER_SCRATCH_0);
-			tmr_offset_hi = RREG32(mmDRIVER_SCRATCH_1);
-			adev->discovery.offset = ((u64)le32_to_cpu(tmr_offset_hi) << 32 |
-						  le32_to_cpu(tmr_offset_lo));
-		} else if (!vram_size) {
-			/* fall back to apci approach to query tmr offset if vram_size is 0 */
-			ret = amdgpu_acpi_get_tmr_info(adev, &tmr_offset, &tmr_size);
-			if (ret)
-				return ret;
-			adev->discovery.size = DISCOVERY_TMR_SIZE;
-			adev->discovery.offset = tmr_offset + tmr_size - DISCOVERY_TMR_OFFSET;
-		}
+	tmr_size = RREG32(mmDRIVER_SCRATCH_2);
+	if (tmr_size) {
+		/* It's preferred to transition to PSP mailbox reg interface
+		 * for both bare-metal and passthrough if available */
+		adev->discovery.size = (u32)tmr_size;
+		tmr_offset_lo = RREG32(mmDRIVER_SCRATCH_0);
+		tmr_offset_hi = RREG32(mmDRIVER_SCRATCH_1);
+		adev->discovery.offset = ((u64)le32_to_cpu(tmr_offset_hi) << 32 |
+					  le32_to_cpu(tmr_offset_lo));
+	} else if (!vram_size) {
+		/* fall back to apci approach to query tmr offset if vram_size is 0 */
+		ret = amdgpu_acpi_get_tmr_info(adev, &tmr_offset, &tmr_size);
+		if (ret)
+			return ret;
+		adev->discovery.size = DISCOVERY_TMR_SIZE;
+		adev->discovery.offset = tmr_offset + tmr_size - DISCOVERY_TMR_OFFSET;
 	}
 out:
 	adev->discovery.bin = kzalloc(adev->discovery.size, GFP_KERNEL);
@@ -384,23 +405,21 @@ static int amdgpu_discovery_read_binary_from_mem(struct amdgpu_device *adev,
 						 uint8_t *binary,
 						 bool is_tmr_in_sysmem)
 {
-	int ret = 0;
+	if (is_tmr_in_sysmem)
+		return amdgpu_discovery_read_binary_from_sysmem(adev, binary);
 
-	if (!is_tmr_in_sysmem) {
-		if (amdgpu_sriov_vf(adev) &&
-		    amdgpu_sriov_xgmi_connected_to_cpu(adev)) {
-			ret = amdgpu_discovery_read_binary_from_sysmem(adev, binary);
-		} else {
-			amdgpu_device_vram_access(adev, adev->discovery.offset,
-						  (uint32_t *)binary,
-						  adev->discovery.size, false);
-			adev->discovery.reserve_tmr = true;
-		}
-	} else {
-		ret = amdgpu_discovery_read_binary_from_sysmem(adev, binary);
+	if (amdgpu_sriov_vf(adev)) {
+		adev->discovery.reserve_tmr = true;
+		return amdgpu_virt_read_vf_fb(adev, adev->discovery.offset,
+					      binary, adev->discovery.size);
 	}
 
-	return ret;
+	amdgpu_device_vram_access(adev, adev->discovery.offset,
+				  (uint32_t *)binary,
+				  adev->discovery.size, false);
+	adev->discovery.reserve_tmr = true;
+
+	return 0;
 }
 
 static int amdgpu_discovery_read_binary_from_file(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
index 7b0d42510161..9ade91ff9394 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
@@ -754,8 +754,7 @@ static int amdgpu_virt_read_exchange_data_from_mem(struct amdgpu_device *adev, u
 		adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_DATAEXCHANGE_TABLE_ID].offset;
 	uint32_t dataexchange_size =
 		adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_DATAEXCHANGE_TABLE_ID].size_kb << 10;
-	uint64_t pos = 0;
-
+	int ret;
 	dev_info(adev->dev,
 			"Got data exchange info from dynamic crit_region_table at offset 0x%x with size of 0x%x bytes.\n",
 			dataexchange_offset, dataexchange_size);
@@ -764,12 +763,10 @@ static int amdgpu_virt_read_exchange_data_from_mem(struct amdgpu_device *adev, u
 		dev_err(adev->dev, "Data exchange data not aligned to 4 bytes\n");
 		return -EINVAL;
 	}
+	ret = amdgpu_virt_read_vf_fb(adev, dataexchange_offset, pfvf_data,
+				     dataexchange_size);
 
-	pos = (uint64_t)dataexchange_offset;
-	amdgpu_device_vram_access(adev, pos, pfvf_data,
-			dataexchange_size, false);
-
-	return 0;
+	return ret;
 }
 
 void amdgpu_virt_fini_data_exchange(struct amdgpu_device *adev)
@@ -802,7 +799,7 @@ void amdgpu_virt_init_data_exchange(struct amdgpu_device *adev)
 		schedule_delayed_work(&(adev->virt.vf2pf_work), msecs_to_jiffies(adev->virt.vf2pf_update_interval_ms));
 	} else if (adev->bios != NULL) {
 		/* got through this logic in early init stage to get necessary flags, e.g. rlcg_acc related*/
-		if (adev->virt.req_init_data_ver == GPU_CRIT_REGION_V2) {
+		if (adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_DATAEXCHANGE_TABLE_ID].size_kb) {
 			pfvf_data =
 				kzalloc(adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_DATAEXCHANGE_TABLE_ID].size_kb << 10,
 					GFP_KERNEL);
@@ -1014,38 +1011,89 @@ static uint8_t amdgpu_virt_crit_region_calc_checksum(uint8_t *buf_start, uint8_t
 	return 0xffffffff - sum;
 }
 
-int amdgpu_virt_init_critical_region(struct amdgpu_device *adev)
+int amdgpu_virt_read_vf_fb(struct amdgpu_device *adev, u64 offset,
+			   void *buf, size_t size)
 {
-	struct amd_sriov_msg_init_data_header *init_data_hdr = NULL;
-	u64 init_hdr_offset = adev->virt.init_data_header.offset;
-	u64 init_hdr_size = (u64)adev->virt.init_data_header.size_kb << 10; /* KB → bytes */
-	u64 vram_size;
+	resource_size_t bar_start, bar_size, map_base;
+	void __iomem *vram;
+	size_t map_offset, map_size;
 	u64 end;
-	int r = 0;
-	uint8_t checksum = 0;
 
-	/* Skip below init if critical region version != v2 */
-	if (adev->virt.req_init_data_ver != GPU_CRIT_REGION_V2)
-		return 0;
-
-	vram_size = RREG32(mmRCC_CONFIG_MEMSIZE);
-	if (!vram_size || vram_size == U32_MAX)
+	if (!buf || !size)
 		return -EINVAL;
-	vram_size <<= 20;
 
-	if (check_add_overflow(init_hdr_offset, init_hdr_size, &end) || end > vram_size) {
-		dev_err(adev->dev, "init_data_header exceeds VRAM size, exiting\n");
+	bar_size = pci_resource_len(adev->pdev, 0);
+	if (!bar_size)
+		return -ENODEV;
+
+	if (check_add_overflow(offset, size, &end) || end > bar_size) {
+		dev_err(adev->dev,
+			"VF FB read exceeds BAR0 size: offset=0x%llx size=0x%zx BAR0=0x%llx\n",
+			offset, size, (u64)bar_size);
 		return -EINVAL;
 	}
 
+	bar_start = pci_resource_start(adev->pdev, 0);
+	map_offset = offset_in_page(offset);
+	map_base = bar_start + (offset & PAGE_MASK);
+	map_size = PAGE_ALIGN(map_offset + size);
+
+	vram = ioremap_wc(map_base, map_size);
+	if (!vram)
+		return -ENOMEM;
+
+	memcpy_fromio(buf, (u8 __iomem *)vram + map_offset, size);
+	iounmap(vram);
+
+	return 0;
+}
+
+static int amdgpu_virt_init_critical_region_v1(struct amdgpu_device *adev)
+{
+	memset(&adev->virt.crit_regn, 0, sizeof(adev->virt.crit_regn));
+	memset(adev->virt.crit_regn_tbl, 0, sizeof(adev->virt.crit_regn_tbl));
+
+	adev->virt.crit_regn.offset = 0;
+	adev->virt.crit_regn.size_kb = AMD_SRIOV_MSG_INIT_DATA_TOT_SIZE_KB_V1;
+
+	adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_VBIOS_IMG_TABLE_ID].offset =
+		AMD_SRIOV_MSG_VBIOS_OFFSET_V1;
+	adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_VBIOS_IMG_TABLE_ID].size_kb =
+		AMD_SRIOV_MSG_VBIOS_SIZE_KB_V1;
+	adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_RAS_TELEMETRY_TABLE_ID].offset =
+		AMD_SRIOV_MSG_RAS_TELEMETRY_OFFSET_KB_V1 << 10;
+	adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_RAS_TELEMETRY_TABLE_ID].size_kb =
+		AMD_SRIOV_MSG_RAS_TELEMETRY_SIZE_KB_V1;
+	adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_DATAEXCHANGE_TABLE_ID].offset =
+		AMD_SRIOV_MSG_DATAEXCHANGE_OFFSET_KB_V1 << 10;
+	adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_DATAEXCHANGE_TABLE_ID].size_kb =
+		AMD_SRIOV_MSG_DATAEXCHANGE_SIZE_KB_V1;
+	adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_BAD_PAGE_INFO_TABLE_ID].offset =
+		AMD_SRIOV_MSG_BAD_PAGE_OFFSET_KB_V1 << 10;
+	adev->virt.crit_regn_tbl[AMD_SRIOV_MSG_BAD_PAGE_INFO_TABLE_ID].size_kb =
+		AMD_SRIOV_MSG_BAD_PAGE_SIZE_KB_V1;
+
+	adev->virt.is_dynamic_crit_regn_enabled = true;
+
+	return 0;
+}
+
+static int amdgpu_virt_init_critical_region_v2(struct amdgpu_device *adev)
+{
+	struct amd_sriov_msg_init_data_header *init_data_hdr = NULL;
+	u64 init_hdr_offset = adev->virt.init_data_header.offset;
+	int r = 0;
+	uint8_t checksum = 0;
+
 	/* Allocate for init_data_hdr */
 	init_data_hdr = kzalloc(sizeof(struct amd_sriov_msg_init_data_header), GFP_KERNEL);
 	if (!init_data_hdr)
 		return -ENOMEM;
 
-	amdgpu_device_vram_access(adev, (uint64_t)init_hdr_offset, (uint32_t *)init_data_hdr,
-					sizeof(struct amd_sriov_msg_init_data_header), false);
-
+	r = amdgpu_virt_read_vf_fb(adev, init_hdr_offset, init_data_hdr,
+				   sizeof(struct amd_sriov_msg_init_data_header));
+	if (r)
+		goto out;
 	/* Table validation */
 	if (strncmp(init_data_hdr->signature,
 				AMDGPU_SRIOV_CRIT_DATA_SIGNATURE,
@@ -1158,16 +1206,6 @@ int amdgpu_virt_init_critical_region(struct amdgpu_device *adev)
 		goto out;
 	}
 
-	/* reserved memory starts from crit region base offset with the size of 5MB */
-	amdgpu_ttm_init_vram_resv(adev, AMDGPU_RESV_FW_VRAM_USAGE,
-				  adev->virt.crit_regn.offset,
-				  adev->virt.crit_regn.size_kb << 10, true);
-	dev_info(adev->dev,
-		"critical region v%d requested to reserve memory start at %08llx with %llu KB.\n",
-			init_data_hdr->version,
-			adev->mman.resv_region[AMDGPU_RESV_FW_VRAM_USAGE].offset,
-			adev->mman.resv_region[AMDGPU_RESV_FW_VRAM_USAGE].size >> 10);
-
 	adev->virt.is_dynamic_crit_regn_enabled = true;
 
 out:
@@ -1177,6 +1215,16 @@ int amdgpu_virt_init_critical_region(struct amdgpu_device *adev)
 	return r;
 }
 
+int amdgpu_virt_init_critical_region(struct amdgpu_device *adev)
+{
+	if (adev->virt.req_init_data_ver == GPU_CRIT_REGION_V1)
+		return amdgpu_virt_init_critical_region_v1(adev);
+	else if (adev->virt.req_init_data_ver == GPU_CRIT_REGION_V2)
+		return amdgpu_virt_init_critical_region_v2(adev);
+
+	return 0;
+}
+
 int amdgpu_virt_get_dynamic_data_info(struct amdgpu_device *adev,
 	int data_id, uint8_t *binary, u32 *size)
 {
@@ -1193,10 +1241,20 @@ int amdgpu_virt_get_dynamic_data_info(struct amdgpu_device *adev,
 	/* Validate on input params */
 	if (!binary || !size || *size < (uint64_t)data_size)
 		return -EINVAL;
+	/*
+	 * Proceed to copy the dynamic content. During early VF init the normal
+	 * VRAM aperture is not mapped yet, so read directly from the VF FB BAR.
+	 */
+	if (amdgpu_sriov_vf(adev)) {
+		int r;
 
-	/* Proceed to copy the dynamic content */
-	amdgpu_device_vram_access(adev,
-			(uint64_t)data_offset, (uint32_t *)binary, data_size, false);
+		r = amdgpu_virt_read_vf_fb(adev, data_offset, binary, data_size);
+		if (r)
+			return r;
+	} else {
+		amdgpu_device_vram_access(adev, (uint64_t)data_offset,
+					  (uint32_t *)binary, data_size, false);
+	}
 	*size = (uint64_t)data_size;
 
 	dev_dbg(adev->dev,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
index d8500c3e48a1..1ffd6065c6be 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.h
@@ -452,6 +452,8 @@ static inline bool is_virtual_machine(void)
 	((adev)->virt.is_xgmi_node_migrate_enabled && (adev)->gmc.xgmi.node_segment_size != 0)
 
 bool amdgpu_virt_mmio_blocked(struct amdgpu_device *adev);
+int amdgpu_virt_read_vf_fb(struct amdgpu_device *adev, u64 offset,
+			   void *buf, size_t size);
 void amdgpu_virt_init_setting(struct amdgpu_device *adev);
 int amdgpu_virt_request_full_gpu(struct amdgpu_device *adev, bool init);
 int amdgpu_virt_release_full_gpu(struct amdgpu_device *adev, bool init);
-- 
2.48.1

