Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A3D4CD6E45
	for <amd-gfx@archiver.kernel.org>; Fri, 29 May 2026 09:41:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B4F610FC08;
	Fri, 29 May 2026 09:41:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EL3SJag1";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013001.outbound.protection.outlook.com
 [40.93.201.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34B0810FBFE
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 May 2026 09:41:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nPT4UgCO9eSkR+8pynt5YEjqg1bGfJgYux0VYyBh3hbbZFaOMEES2XKfvFWJsT9mctM7bCOc4a0154YudEg02QUEpnM/LVgMQOMH9f5unI2RjLSkX6blpwFPbFtmVlWa1mUscjyalqRszf7s0R9jqdvMG5uNj9ECpHr5dtmuOfplWHDbkPRhoez9YMmP6K1ZZ/zCd6QHvglv32YZzMD49rb+5rnauMKsSzXRJBV88Cq+pb2c5rvA5olVfcHJlEHduxIx1yYSLuOBcmAri+eyAAUbPWs0Fkwl/aGx9z3f/MON5DPCu9D85ROJF8pARbUIucxfmehP357soh+nXmATgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZePg6NeXtanG7/tbjUduEIwvr+6ZULpzcqve2sB2J9A=;
 b=EdXaVf6QjO0WieXUGSvOGpNAgg5nRK9MyrcZ4xuzJsK7S8x36g2rmxRQwmVtcnL75vqVuB0pi9tCVeTvLRfYOWAfrOQxDPEEzKvYxBvYEwrMnaKuzJkv4SetO64QyoUjb2G3KHJuOTOPN1G+tUxRWjNJTke/8dyXGk4MI8Ot28Lqlz/F4QuuiPIyp6Eo/ZWsBQC4LhsUHkkNUd4/4lsGeB7HE4keuQPHCh/X02cd7KDzWSe2R761VZS2rmceAWa7ceSQV5nM4bdaL74dLKOW/98PK2M9Lo2XiNqfZmSP6X+ikrXcchB0JfKW+FFjNms00WjYqYpVaR9prw8dD9zRQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZePg6NeXtanG7/tbjUduEIwvr+6ZULpzcqve2sB2J9A=;
 b=EL3SJag1KjD48PeIFMpCJJViVwBBE9ukjINtEVCMWUTHetF9mIUwW8RchEyQdq8KdfqcEdKsQ9limhCvRmonLeokUEOWEczBLQsSh/c8HNDuVp/nYfrb79iHb3Fgi4yxKb+f8yR1ULp7jXFz1eu4Alkr9m8Sl21jJjTCgFsn+e8=
Received: from DS1P220CA0014.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:455::18) by
 PH8PR12MB6891.namprd12.prod.outlook.com (2603:10b6:510:1cb::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Fri, 29 May
 2026 09:41:38 +0000
Received: from CH3PEPF00000012.namprd21.prod.outlook.com
 (2603:10b6:8:455:cafe::9f) by DS1P220CA0014.outlook.office365.com
 (2603:10b6:8:455::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Fri, 29
 May 2026 09:41:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000012.mail.protection.outlook.com (10.167.244.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.0 via Frontend Transport; Fri, 29 May 2026 09:41:38 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 29 May
 2026 04:41:35 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <kevinyang.wang@amd.com>
Subject: [PATCH 1/5] drm/amd/pm: Add helper functions to fetch pptable
Date: Fri, 29 May 2026 15:11:15 +0530
Message-ID: <20260529094119.1134923-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000012:EE_|PH8PR12MB6891:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f2ae8e9-c8e6-4008-dec9-08debd667b21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: BrxBlLEp3cbWjekeNv2eDzQBMmoJD21MFM0qDsi5zDNDc++zmoyP2fukazjqxjvLd4S12NwZgLBTHBEz4A9LzZhRpLe/bghuqpio9YBdwe66uphB5rk3xnr0xyiFki3U6peZYiV/obJF3UXTdp0aDlLRq+lsPz4o+j7CPIYT6CeWAVpD+YGAuVntrNfIylYDOv/Z1P8kOOtkBRiYH4iv0zCnNxd7GmymOcJW8PSjV54cRY3cMY3uPVkEZLy1syKQDLWQ7KWVOy/dgsaf/GQlW09xMAn6J84KAxpNjM9/i9CvZ8LLq2OXZeExufGfrAV027Sj1r2AdNi7oitrdX6qRemFrAQLLOyA6ze8IYFCZRCY6JAJiNU8VyDhLKtq9cQ4VFNTz/3rQFZpRcWAQLJwyivfEurBwdMYMyyloskzrOrNICfDIdA2IU+tvpza72rY2UcV9mgN9jci7CrCAVXmiwVZO/Tlf21rH4a9I/NMds4mXQb0LjG+JDGa2yljKF7lrFcABDP2QDT07w6yuPmoDxp0EDq61ghF377WZVVyPhtRtu13DGZpagQqk6IXtdM5s47j3xmsNyFCceV+BjIOn2WQVCbvVuZNXSU+R3ZFRPJdlC20N/45VyRfpXmsHh4GmL0dD4Lu72MY8wzlOTGAgMlCHepum6c5TGMcpJiE635+GlaGha8zyauakxhUqoEJaBO4ozdBSaQm5RICSfnZeR2cb4W4k/ITXeyCaYSBRgM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: pHRzG0vC4l6Sy3tv6PJSE+kfSZcTPMQXnrqzXLuOedgIpFlNWBwY4Ew2T/iS3zEaIJQc6aHY1jwJW0vXs0Pgxu2TnM8hKQY5vQ8sr/8jV0ir95va3mTgjkEQoqNY95ouYgmHpuAsKtCI0aGRxl19AjsYWCGdcIMJMRsdT1gVtqrCGAK7civ8GT9fW3OL2aBNe6ksaJ2u7JU9mX+5l4My41a0xSfHJNUDJWVVj9FJqIpjOOdH/jzjTI4FXFsU2RSwhN/2pKPuyT/ta/3GB4C4PYIZufNf2JUS99Zqzi5UXpuDn2PTDaqhuINaO7spbCOGqJZaGHBrPJ8iA5fZVvr66XQhfCpUb0Z1H9ymYHIIdoWubEAx34NAKwd1TtwKoUTI2Atmg/Ir5rZrT8E/O3EbSk3q4io8EsGJR+q7jML6rm0q+WeHlXCArl5DmRams7DD
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 09:41:38.2995 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f2ae8e9-c8e6-4008-dec9-08debd667b21
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000012.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6891
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

PPTables could be embedded in firmware binaries with v2.0 or v2.1
format. Add a common helper to get pptable from firmware binaries.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Assisted-by: Claude Sonnet (Cursor AI)
---
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c | 140 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h |   3 +
 2 files changed, 143 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index 0a745afa8552..ad1020b8389c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -1551,3 +1551,143 @@ int smu_cmn_dpm_pcie_width_idx(int width)
 
 	return ret;
 }
+
+static int smu_cmn_get_pptable_v2_0(struct smu_context *smu, void **table, uint32_t *size)
+{
+	const struct smc_firmware_header_v2_0 *v2;
+	struct amdgpu_device *adev = smu->adev;
+	size_t fw_size = adev->pm.fw->size;
+	uint32_t ppt_offset_bytes;
+	uint32_t ppt_size_bytes;
+
+	if (fw_size < sizeof(*v2)) {
+		dev_err(adev->dev,
+			"SMC firmware too small for v2.0 header: %zu < %zu\n",
+			fw_size, sizeof(*v2));
+		return -EINVAL;
+	}
+
+	v2 = (const struct smc_firmware_header_v2_0 *)adev->pm.fw->data;
+
+	ppt_offset_bytes = le32_to_cpu(v2->ppt_offset_bytes);
+	ppt_size_bytes   = le32_to_cpu(v2->ppt_size_bytes);
+
+	if (ppt_offset_bytes > fw_size ||
+	    ppt_size_bytes > fw_size - ppt_offset_bytes) {
+		dev_err(adev->dev,
+			"pptable v2.0 exceeds firmware binary: offset %u + size %u > %zu\n",
+			ppt_offset_bytes, ppt_size_bytes, fw_size);
+		return -EINVAL;
+	}
+
+	*size  = ppt_size_bytes;
+	*table = (uint8_t *)v2 + ppt_offset_bytes;
+
+	return 0;
+}
+
+static int smu_cmn_get_pptable_v2_1(struct smu_context *smu, void **table,
+				     uint32_t *size, uint32_t pptable_id)
+{
+	const struct smc_firmware_header_v2_1 *v2_1;
+	struct amdgpu_device *adev = smu->adev;
+	struct smc_soft_pptable_entry *entries;
+	size_t fw_size = adev->pm.fw->size;
+	uint32_t pptable_entry_offset;
+	uint32_t ppt_offset_bytes;
+	uint32_t ppt_size_bytes;
+	uint32_t pptable_count;
+	int i;
+
+	if (fw_size < sizeof(*v2_1)) {
+		dev_err(adev->dev,
+			"SMC firmware too small for v2.1 header: %zu < %zu\n",
+			fw_size, sizeof(*v2_1));
+		return -EINVAL;
+	}
+
+	v2_1 = (const struct smc_firmware_header_v2_1 *)adev->pm.fw->data;
+
+	pptable_entry_offset = le32_to_cpu(v2_1->pptable_entry_offset);
+	pptable_count        = le32_to_cpu(v2_1->pptable_count);
+
+	if (pptable_entry_offset > fw_size ||
+	    pptable_count > (fw_size - pptable_entry_offset) / sizeof(*entries)) {
+		dev_err(adev->dev,
+			"pptable v2.1 entry array exceeds firmware binary: offset %u, count %u\n",
+			pptable_entry_offset, pptable_count);
+		return -EINVAL;
+	}
+
+	entries = (struct smc_soft_pptable_entry *)
+		((uint8_t *)v2_1 + pptable_entry_offset);
+
+	for (i = 0; i < pptable_count; i++) {
+		if (le32_to_cpu(entries[i].id) != pptable_id)
+			continue;
+
+		ppt_offset_bytes = le32_to_cpu(entries[i].ppt_offset_bytes);
+		ppt_size_bytes   = le32_to_cpu(entries[i].ppt_size_bytes);
+
+		if (ppt_offset_bytes > fw_size ||
+		    ppt_size_bytes > fw_size - ppt_offset_bytes) {
+			dev_err(adev->dev,
+				"pptable entry %d exceeds firmware binary: offset %u + size %u > %zu\n",
+				i, ppt_offset_bytes, ppt_size_bytes, fw_size);
+			return -EINVAL;
+		}
+
+		*table = (uint8_t *)v2_1 + ppt_offset_bytes;
+		*size  = ppt_size_bytes;
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+/**
+ * smu_cmn_get_pptable_from_firmware - locate the soft pptable embedded in the
+ *                                     SMC firmware binary.
+ * @smu:        SMU context
+ * @table:      on success, set to the start of the pptable within the firmware
+ *              blob
+ * @size:       on success, set to the pptable size in bytes
+ * @pptable_id: the entry ID to search for (used only for v2.1 binaries)
+ *
+ * Reads the firmware header version and dispatches to the appropriate v2.x
+ * parser.  Only major version 2 is supported; minor version selects between
+ * the single-entry (v2.0) and multi-entry directory (v2.1) layouts.
+ *
+ * Return: 0 on success, -EINVAL for an unsupported version or if the
+ *         requested pptable cannot be found or exceeds the binary bounds.
+ */
+int smu_cmn_get_pptable_from_firmware(struct smu_context *smu, void **table,
+				      uint32_t *size, uint32_t pptable_id)
+{
+	const struct smc_firmware_header_v1_0 *hdr;
+	struct amdgpu_device *adev = smu->adev;
+	uint16_t version_major, version_minor;
+
+	hdr = (const struct smc_firmware_header_v1_0 *)adev->pm.fw->data;
+	if (!hdr)
+		return -EINVAL;
+
+	dev_info(adev->dev, "use driver provided pptable %d\n", pptable_id);
+
+	version_major = le16_to_cpu(hdr->header.header_version_major);
+	version_minor = le16_to_cpu(hdr->header.header_version_minor);
+	if (version_major != 2) {
+		dev_err(adev->dev, "Unsupported smu firmware version %d.%d\n",
+			version_major, version_minor);
+		return -EINVAL;
+	}
+
+	switch (version_minor) {
+	case 0:
+		return smu_cmn_get_pptable_v2_0(smu, table, size);
+	case 1:
+		return smu_cmn_get_pptable_v2_1(smu, table, size, pptable_id);
+	default:
+		return -EINVAL;
+	}
+}
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
index 5b7f64b94179..ae6742f5298f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.h
@@ -249,6 +249,9 @@ int smu_cmn_dpm_pcie_gen_idx(int gen);
 int smu_cmn_dpm_pcie_width_idx(int width);
 int smu_cmn_check_fw_version(struct smu_context *smu);
 
+int smu_cmn_get_pptable_from_firmware(struct smu_context *smu, void **table,
+				      uint32_t *size, uint32_t pptable_id);
+
 /*SMU gpu metrics */
 
 /* Attribute ID mapping */
-- 
2.49.0

