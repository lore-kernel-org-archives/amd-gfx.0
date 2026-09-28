Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E09B5CA5FA1
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Sep 2026 16:44:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65E4210EB12;
	Mon, 28 Sep 2026 16:44:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OzupnmDI";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013024.outbound.protection.outlook.com
 [40.93.196.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A0FB210E68B
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Sep 2026 16:44:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YWh6mBYl1ymGAjLYHGmTxVp5xgag3uav/km6FNSGcOHoQBsNglpmQwo83MAdqsbiPkogA7jo7gu8vUfOECptx9ijnq0w3vWvVGFU9l1M+SgYOHURKtgHQ5C/p7/0578LcJRwbIov+rtc44xEdXFH/zM+xaoeGrEG5QtwvsqluVNOfTQDNdpIEpJAEqrO7rWV0m3CaxGoTtX9Bapa+QBaa+FXP+pgTcIJ2ZW0YQT5hBgoQnHapQtilCqogAOFPRVo4cAULNrO1r+k64i7Gz94Ido3bqmhvDFW6GLZfC2INqG9oXXVHlpL3X6TdjkPgevy3dzZMWYnUYPZElzX0uB1Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BiqdoWgLxq2Vub8iySxTykFPtEIQJUsRvXBZgEccNQM=;
 b=U+BErAL927NM21r+5AXZjDt6QF9J+0b1c81I91vFB5ZA5NJkfDkRdIZDkrUDCyfC9O2l4Ot3SNNEIrymqT5LntVIwCaZvun2poau9WARnrAmhBnyth7tVitHWa1XRG0Azym2z0ZHSTIjSoXtwapkeQp38sVg8ZQXva2xD2dM9l1PcTx6PtD1H3ajWjd+T+EDpqOtPCy6H8/omFGsCJqJaCu/b0xnxol6HjEIUhvn9LXtKeqCjF0194oZXrCAQ1h7S1LpGDI8Yfp78CWaI5WUe7eXaphQrKdlyVd2QCqcb6n/Yzuj4Y1JtEjqqRMVLhoWuGVZp8q6xyNi9Rn9h5po3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BiqdoWgLxq2Vub8iySxTykFPtEIQJUsRvXBZgEccNQM=;
 b=OzupnmDI0EQd9vGfaHUbaE64sF0yP5H4aO5GwMWJtpr6bVBZ3FiRx2iAd8PF3XBXybEpi1Q9CE/7rLhEBNcdceqtm1lDFMSdz2icmTXPfetJGsOKDIvEjS1D77Ptbjqsi5sVGu5pjYEDIjks+u16U8ylOyqLEz81MHZROCZZ3wY=
Received: from BN9PR03CA0760.namprd03.prod.outlook.com (2603:10b6:408:13a::15)
 by CY1PR12MB9676.namprd12.prod.outlook.com (2603:10b6:930:104::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Mon, 28 Sep
 2026 16:44:46 +0000
Received: from BN2PEPF000044A7.namprd04.prod.outlook.com
 (2603:10b6:408:13a:cafe::47) by BN9PR03CA0760.outlook.office365.com
 (2603:10b6:408:13a::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.23 via Frontend Transport; Mon,
 28 Sep 2026 16:44:45 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044A7.mail.protection.outlook.com (10.167.243.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Mon, 28 Sep 2026 16:44:45 +0000
Received: from MKMZHLUO01.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 28 Sep
 2026 11:44:44 -0500
From: Zhigang Luo <Zhigang.Luo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Philip.Yang@amd.com>,
 <Hawking.Zhang@amd.com>, <Lijo.Lazar@amd.com>, <Gavin.Wan@amd.com>,
 <Victor.Skvortsov@amd.com>, Zhigang Luo <Zhigang.Luo@amd.com>, Zhigang Luo
 <zhigang.luo@amd.com>, Fangsheng Huang <Fangsheng.Huang@amd.com>, YuBiao Wang
 <YuBiao.Wang@amd.com>, Lijo Lazar <lijo.lazar@amd.com>
Subject: [PATCH 1/6] drm/amdgpu: add SRAT lookup for GPU-local memory
Date: Mon, 28 Sep 2026 12:44:15 -0400
Message-ID: <20260928164421.10144-1-Zhigang.Luo@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A7:EE_|CY1PR12MB9676:EE_
X-MS-Office365-Filtering-Correlation-Id: d015775f-99e8-4658-0ca4-08df1d7fcd9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|23010399003|36860700016|1800799024|10067099003|6133799003|11063799006|18002099003|56012099006|8126099003;
X-Microsoft-Antispam-Message-Info: zVAG27QoOy6pQItw9tJnIvz0z5RhW8vnzRg6djWe7RdnYYo4c/hirIoFE1ZaYqEV0n+FJ4OCjWRYb8oYb7LgqSX+dT+P/QMZ3FvNj0CnxwGalJKEnxSjbICtVJtebSI824EN21GMFUwioMC3nimDfFSqsKsrn9H/K2LSjC8Sgl7wrweoLi750sW3W5P6/RNoTXfLLf35hQhl5wqVlVk8vdhMue6LBjWl6Vc5AJG6jlliOxE9w5iwiCDrFDswPBCTAPkJ+t1aHyQtQqTL3ftJ7s1l8FxNQzLELYZVY0tHmRx0U4C8q5iih/2YwGPn/xv6Lcjexz74Q9s/aUdNK9RN2vSONFZ+CSEoRexJOgiX895PsL7haFvfJwnz3MUqmc0fN9eUA0B2/2+Fj+tJbaKFvqvuZRcI/TZDQswYnzL/Wm4Dq3sa/jFZ+ruG7yaBWlTs154duNJj9B7Q1BTGUu54PrbqTEdoU5donwyeHSCgTQ18Om/Nfw07p95nYFISPHrQe2Bd7r+si9L13Oqu2Omj+lAY+vTiXnvWCSLf0x+s8IrXS/+aQs7DBMOZMQM+oKc+PSp0yI620H9RHtvjAm6vz1RD7O5Xbeuic1Reo4idVXJdZZ3AHSuaP5zsLSTaIRkd7hy+F5Oh+dTnwtShXAxvQ2IFrzZY7z4i1Sx2aHrhKrircQYVcLrFgGDXdqaTy18iHg8c9l1n2J+VDiN5IPxNxQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(23010399003)(36860700016)(1800799024)(10067099003)(6133799003)(11063799006)(18002099003)(56012099006)(8126099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 4IUPOIndFYdQdf49LehpAsJTUAxmmsT3UAIgmVJHkkE9Jldmq96hPhB7i3iXFFP536I01CFnTTYb1rcIG10kDqWGrhNEzRjD+ejQITbMFJ9wX79B/wq4lLRiuJCcbcEGSfty69X9+DPl3me5IrHG88zVrEPrcJgcs9hKHbM5Yzkt2cMYh5sOUoLbxCG4wqJzj0GdEWhQYTPdpUNF2zFePGsVW28TWnndSN5ZkY1dpoJGSsgJCm0QoP1SsibjcrwRNK8Bbs4sjkabJ4pHZTMMhv2h3N2va7wRmkzYxUnqWrsd7cceoyEvEYfGL7YZQJlyFUuxDLolu4H9LOla/+S/CaRwT4wKuRk65j7bQKOcygdKeKjJZhdfSXHQBoGqpesa4ou32UdFbSjbGMqivIEDWSMRA/ANMT5TDKyCW2zQTpqv/BbURXZ30dqoEi/4t5vb
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 16:44:45.7276 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d015775f-99e8-4658-0ca4-08df1d7fcd9f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9676
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

On A+A the GPU HBM is exposed as specific-purpose memory described by
SRAT, and the GPU reaches it at a system physical address over the
internal link, so the driver needs a way to discover that range.

Add amdgpu_acpi_find_gpu_memory_in_srat(), which resolves the GPU
proximity domain from the SRAT GENERIC_AFFINITY entry matching the PCI
device handle, then returns the enabled, non-hotpluggable memory range
of that domain.

No caller yet, the users follow.

v2:
- A+A VF/passthrough is identified later by missing FB BAR0
  (AMDGPU_VIRT_VRAM_IS_SPM), not by xgmi.connected_to_cpu.

v3:
- Rename best_base/best_len to mem_base/mem_len; first match, not a
  comparison.
- Drop the unused legacy packed-BDF PCI handle format.
- Log "no acpi generic initiator found" without extra PCI BDF.
- Use dev_err for error-return logs.

v4:
- Reverse Christmas-tree local declarations, one per line.
- Reject NULL base_addr/length with -EINVAL.

Signed-off-by: Zhigang Luo <zhigang.luo@amd.com>
Signed-off-by: Fangsheng Huang <Fangsheng.Huang@amd.com>
Signed-off-by: YuBiao Wang <YuBiao.Wang@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 136 +++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.h |   7 ++
 2 files changed, 143 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
index 7f5abb03be1b..d46ebbb5e811 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
@@ -28,6 +28,7 @@
 #include <linux/slab.h>
 #include <linux/xarray.h>
 #include <linux/power_supply.h>
+#include <linux/numa.h>
 #include <linux/pm_runtime.h>
 #include <linux/suspend.h>
 #include <acpi/video.h>
@@ -1445,6 +1446,141 @@ bool amdgpu_acpi_should_gpu_reset(struct amdgpu_device *adev)
 #endif
 }
 
+#ifdef HAVE_ACPI_SRAT_GENERIC_AFFINITY
+static bool amdgpu_acpi_srat_pci_handle_match(struct pci_dev *pdev,
+					      struct acpi_srat_generic_affinity *gi)
+{
+	u16 segment = *(u16 *)&gi->device_handle[0];
+	u8 bus = gi->device_handle[2];
+	u8 devfn = gi->device_handle[3];
+
+	/* Only PCI device handles (ACPI 6.3: type 1; some firmware used 0) */
+	if (gi->device_handle_type != 0 && gi->device_handle_type != 1)
+		return false;
+
+	if (!(gi->flags & ACPI_SRAT_GENERIC_AFFINITY_ENABLED))
+		return false;
+
+	/* ACPI 6.3 Table 5-80: segment + bus + devfn bytes */
+	return segment == pci_domain_nr(pdev->bus) &&
+	       bus == pdev->bus->number &&
+	       devfn == pdev->devfn;
+}
+
+int amdgpu_acpi_find_gpu_memory_in_srat(struct amdgpu_device *adev,
+					uint64_t *base_addr, uint64_t *length)
+{
+	struct acpi_srat_generic_affinity *gpu;
+	struct acpi_subtable_header *sub_header;
+	struct acpi_table_header *table_header;
+	struct acpi_srat_mem_affinity *mem;
+	struct pci_dev *pdev = adev->pdev;
+	unsigned long subtable_len;
+	unsigned long table_end;
+	acpi_status status;
+	bool pxm_found = false;
+	bool mem_found = false;
+	u64 mem_base = 0;
+	u64 mem_len = 0;
+	u32 gpu_pxm = 0;
+
+	if (!base_addr || !length)
+		return -EINVAL;
+
+	status = acpi_get_table(ACPI_SIG_SRAT, 0, &table_header);
+	if (ACPI_FAILURE(status))
+		return -ENOENT;
+
+	table_end = (unsigned long)table_header + table_header->length;
+
+	/* Pass 1: find GPU PXM from GENERIC_AFFINITY */
+	sub_header = (struct acpi_subtable_header *)
+		((unsigned long)table_header + sizeof(struct acpi_table_srat));
+	subtable_len = sub_header->length;
+
+	while (((unsigned long)sub_header) + subtable_len <= table_end) {
+		if (subtable_len == 0)
+			break;
+
+		if (sub_header->type == ACPI_SRAT_TYPE_GENERIC_AFFINITY) {
+			gpu = (struct acpi_srat_generic_affinity *)sub_header;
+			if (amdgpu_acpi_srat_pci_handle_match(pdev, gpu)) {
+				gpu_pxm = gpu->proximity_domain;
+				pxm_found = true;
+				break;
+			}
+		}
+
+		sub_header = (struct acpi_subtable_header *)
+			((unsigned long)sub_header + subtable_len);
+		subtable_len = sub_header->length;
+	}
+
+	if (!pxm_found) {
+		acpi_put_table(table_header);
+		dev_err(adev->dev, "SRAT: no acpi generic initiator found\n");
+		return -ENOENT;
+	}
+
+	/* Pass 2: find SPM memory for gpu_pxm */
+	sub_header = (struct acpi_subtable_header *)
+		((unsigned long)table_header + sizeof(struct acpi_table_srat));
+	subtable_len = sub_header->length;
+
+	while (((unsigned long)sub_header) + subtable_len <= table_end) {
+		if (subtable_len == 0)
+			break;
+
+		if (sub_header->type == ACPI_SRAT_TYPE_MEMORY_AFFINITY) {
+			bool enabled, hotplug;
+
+			mem = (struct acpi_srat_mem_affinity *)sub_header;
+			enabled = mem->flags & ACPI_SRAT_MEM_ENABLED;
+			hotplug = mem->flags & ACPI_SRAT_MEM_HOT_PLUGGABLE;
+
+			/* MUST filter ENABLED && !HOTPLUGGABLE */
+			if (enabled && !hotplug &&
+			    mem->proximity_domain == gpu_pxm) {
+				/* [mem->base_address, mem->length] is the SPM range */
+				mem_base = mem->base_address;
+				mem_len = mem->length;
+				mem_found = true;
+				break;
+			}
+		}
+
+		sub_header = (struct acpi_subtable_header *)
+			((unsigned long)sub_header + subtable_len);
+		subtable_len = sub_header->length;
+	}
+
+	acpi_put_table(table_header);
+
+	if (!mem_found) {
+		dev_err(adev->dev, "SRAT: no memory affinity for pxm %u\n",
+			 gpu_pxm);
+		return -ENOENT;
+	}
+
+	dev_info(adev->dev, "SRAT: gpu pxm=%u base=%llx length=%llx\n",
+		 gpu_pxm, mem_base, mem_len);
+
+	*base_addr = mem_base;
+	*length = mem_len;
+
+	return 0;
+}
+#else
+int amdgpu_acpi_find_gpu_memory_in_srat(struct amdgpu_device *adev,
+					uint64_t *base_addr, uint64_t *length)
+{
+	if (!base_addr || !length)
+		return -EINVAL;
+
+	return -ENOENT;
+}
+#endif
+
 /*
  * amdgpu_acpi_detect - detect ACPI ATIF/ATCS methods
  *
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.h
index 6569a4db5dae..624faf738963 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.h
@@ -102,6 +102,8 @@ int amdgpu_acpi_get_mem_info(struct amdgpu_device *adev, int xcc_id,
 
 void amdgpu_acpi_get_backlight_caps(struct amdgpu_dm_backlight_caps *caps);
 bool amdgpu_acpi_should_gpu_reset(struct amdgpu_device *adev);
+int amdgpu_acpi_find_gpu_memory_in_srat(struct amdgpu_device *adev,
+					uint64_t *base_addr, uint64_t *length);
 void amdgpu_acpi_detect(void);
 void amdgpu_acpi_release(void);
 #else
@@ -117,6 +119,11 @@ static inline int amdgpu_acpi_get_mem_info(struct amdgpu_device *adev,
 {
 	return -EINVAL;
 }
+static inline int amdgpu_acpi_find_gpu_memory_in_srat(struct amdgpu_device *adev,
+						      uint64_t *base_addr, uint64_t *length)
+{
+	return -EINVAL;
+}
 static inline void amdgpu_acpi_fini(struct amdgpu_device *adev) { }
 static inline bool amdgpu_acpi_should_gpu_reset(struct amdgpu_device *adev) { return false; }
 static inline void amdgpu_acpi_detect(void) { }
-- 
2.43.0

