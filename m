Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E01E606D823
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Nov 2026 11:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=l3ZvKrIc
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E930810E521;
	Fri,  6 Nov 2026 11:30:10 +0000 (UTC)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010061.outbound.protection.outlook.com [52.101.46.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 861B510E9FD
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Nov 2026 11:30:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aLBsfuyBWj121fJkKObWGiU+8Fw5tHV7gQZPkSSaQWLO8idzbeqKdaFUINrOt2f3Ow8s48uhjZ3hMhM3WIGAnpzxVhvf1ZqGLuwlqkjqBbVAhiGLDQ5v1tWfpMJyjBDxUJRGk9MZIePM18aV27bpz91TBtKrR8aRZVHgtXKJSTJtbZSRl0UpXHxqA2VecYiDuwVLdD+JMQAIsRHxiu/Th6EwyVWNB9JODnt6GqvbbgRCJZhMNhO4Bh4JvqA991Hym43+JBXTV6VwI/N/my+kVSqP3r8lArVdLdVDnHKDAs4iMUOtsDrFv7M3zZIUMm+16qdPJJc42lv1IAPuoIiMxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ahJ8kvXPST4Bw1aPs8oWaqQoWkGZ//xGPbalyyEN+Wc=;
 b=oh26s3LaBuOjouHq9iU9IqBvyurc9nt9UmGtAo+JUkyUxZZEW5+zUcj8EYOlEH3ozs3bWI+W1wwL5zsn8dg2/+tRTZhxqiG2qgNVKf5Nyb9NBmLs6eUvrx6UCsHwcvj2uNk8Ju3ueDd5tylTZnm/eswMztjUnAcbI9YLo8hw5+uaIz13Xr0s80Doyg0MZsU4coLa20t6xYBP/nh8B6GG3spNEXireVmbbSHs/9kaY3uRDs+M+IBmNfKJ+9e0LdN1xH1ajIoLQNTcYVi4R+8kzCu4QBIOXRGroMSvRREmo/R4WG9GXqXIkfnxIccAa3VOOEGuaQ7bWAqhO9Urlc9ubg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ahJ8kvXPST4Bw1aPs8oWaqQoWkGZ//xGPbalyyEN+Wc=;
 b=l3ZvKrIcB5HlvePuQZCXDHJcbSCH9A7mVtezRF7cg2keV9KDVYUUKaLtBGRZcBiTFmUI4lotFJmO/wfP6uPdlyIZdoIYVo9zpGXSsJxRNb7isJ7Ig9zvt8gXU1A4rjk4gSJUohqJHyoW6CqRZZez1kb7JcnkVmieIIupI8upkSU=
Received: from SJ0PR13CA0133.namprd13.prod.outlook.com (2603:10b6:a03:2c6::18)
 by CY5PR12MB6249.namprd12.prod.outlook.com (2603:10b6:930:23::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Fri, 6 Nov 2026
 11:30:00 +0000
Received: from SJ1PEPF000037AA.namprd03.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::a8) by SJ0PR13CA0133.outlook.office365.com
 (2603:10b6:a03:2c6::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.5 via Frontend Transport; Fri, 6
 Nov 2026 11:29:59 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF000037AA.mail.protection.outlook.com (10.167.244.184) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 11:29:59 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 6 Nov
 2026 05:29:58 -0600
Received: from RSNDADJELK01.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via
 Frontend Transport; Fri, 6 Nov 2026 05:29:57 -0600
From: Dejan Andjelkovic <Dejan.Andjelkovic@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Lijo.Lazar@amd.com>, <Nikola.Prica@amd.com>, 
 Dejan Andjelkovic <Dejan.Andjelkovic@amd.com>
Subject: [PATCH v6 1/2] drm/amdgpu: enable IP discovery via PSP mailbox
Date: Fri, 6 Nov 2026 12:29:49 +0100
Message-ID: <20261106112950.1281549-1-Dejan.Andjelkovic@amd.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037AA:EE_|CY5PR12MB6249:EE_
X-MS-Office365-Filtering-Correlation-Id: 599b1367-d337-49a0-3464-08df3bf94a8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|23010399003|1800799024|10067099003|18002099003|6133799003|261022075727099003|56012099006|261022115727099003|11063799006|5023799004|261022105027099003|261022113327099003|261102123227099003|261026140227099003|261026135527099003|261021133027099003|261028144727099003|261026121527099003|261021130227099003|261009221227099003|261021135927099003|261026130827099003|261009223027099003|261021121427099003|261021123027099003;
X-Microsoft-Antispam-Message-Info: k5VeRHs26JVP+53SMR6Djxiwb4QYr597vM+M6vL31a+wnNt+0gl5k+HS+oQ59pfM+NymqGhUUqDj67SiBmrEBAbalDqU3I5Utx8biVJFOdXulivO1n2luOZmRsf/7aVaFhLsfIUezwHEoxjPE9sx+3/ulLPrsMMgfRAedP1FTPnu4zcwKzqJ0QC5QDjTVkkRyxzbCgNEOnIg8kh1z7WgEW100KsjIZ6F+zUfsJrdzrg/nhTKHaAEPxDZm5LhHu5VWuNmzCItoQmvMO2GdESSzx5xNh4dvhJnqpo639OWStj4D5qjJFPutvwP7KMlAVBSDyJLGfLO15Kka2TMzZiSp+c/g8BcVvACvl8wjkE7/40ZAqRio6X1kpH/xl/D1Z1czbalt2iDDplkCNpQHxS+Mn0ZIGGq7iZiDbNSON/OfQUnXgebvw98eEUAS8lZoXzFag0lF+yKulFW7kiXDZ2G0Z4cqwmXfP+pJFxCdvFmT8Wqi4tqeeWTQQ6p7EeXtAolLIhLmTFhT3FtRxfNDvk/GWla2306tKixeSaTkY1lC9DerTIDLBTducmEfgqw7LGCH7GADpsrNgtR0g+AoFvg12HrFQC7kKfjs4kmMtOvfAOULsxDT5VG+mlMUKM28ybYurJjKaLF2XXS2fs7iQEPh3lAR9p0YA7lBP3LyCToZ4GNYZ9s2KAN68WaxZ7DvMXMN7jTkULZ9jHdXlN07+GSIg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(23010399003)(1800799024)(10067099003)(18002099003)(6133799003)(261022075727099003)(56012099006)(261022115727099003)(11063799006)(5023799004)(261022105027099003)(261022113327099003)(261102123227099003)(261026140227099003)(261026135527099003)(261021133027099003)(261028144727099003)(261026121527099003)(261021130227099003)(261009221227099003)(261021135927099003)(261026130827099003)(261009223027099003)(261021121427099003)(261021123027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: F7ghk5R3zj2KxV0IlcfQVu22OhQzO9M0O2zHhKbHXHjWvti1ZuoQKQUtW3vBUTaUc3BxylHgq1X4Cxm+UPqz3wPl34SRo8Dz/Oe0c/P1KEzQ2ueOxoDzWZhE1sSlVexoaSOm1i1zc+tIOIAwP5nuSf6Cl2VWqz7Hxbd/O0vvVHIi4u0IfnxLTlOk8YYcVLqUdn4dgG/VKVcKRASLa9xFdcZkxc5Y72c7OrLUvViot2XXLVDck7nWhQMwVpFQ3jAcMwFnBYKnXeoK/OwD8AlHPKtoVUUrlUV8ZT3OBRkaIyEimvu5FDfdXeJlvbBaV2E4/Kb0md08spdT/WJJeMLXsOj6Ocv1SLaER4uIJviDuc681IGWIqgVeiwkFsOxihhYLBuIl2ioRp4DaWSODDrwjpyIJx89jx+AMgrPSt3IZdZjK0ubf69XysN545i2SW9M
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 11:29:59.2439 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 599b1367-d337-49a0-3464-08df3bf94a8f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000037AA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6249
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Adds support for IP discovery via PSP mailbox using guest phys
addr for passthrough A+A.

Keep the discovery firmware file as the preferred source. Use the
mailbox only when no firmware file is selected and the device is in
passthrough with a zero-sized BAR0.

The mailbox registers are fixed MMIO indexes. This runs before IP
discovery has programmed the hardware register bases.

Signed-off-by: Dejan Andjelkovic <Dejan.Andjelkovic@amd.com>
---
v5 -> v6:
- Drop the post-wait status read in amdgpu_psp_read_discovery().

 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  5 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |  6 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       | 61 +++++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h       |  2 +
 drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h       |  4 +-
 5 files changed, 71 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 5a32b54b1e9b..20570ab1d2c0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1019,6 +1019,11 @@ static inline struct amdgpu_device *amdgpu_ttm_adev(struct ttm_device *bdev)
 	return container_of(bdev, struct amdgpu_device, mman.bdev);
 }
 
+static inline bool amdgpu_is_spm_passthrough(struct amdgpu_device *adev)
+{
+	return amdgpu_passthrough(adev) && !pci_resource_len(adev->pdev, 0);
+}
+
 static inline bool amdgpu_is_multi_aid(struct amdgpu_device *adev)
 {
 	return !!adev->aid_mask;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 79a2b1268b23..8b976e363f16 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -771,6 +771,12 @@ static int amdgpu_discovery_init(struct amdgpu_device *adev)
 							   fw_name);
 		if (r)
 			goto out;
+	} else if (amdgpu_is_spm_passthrough(adev)) {
+		drm_dbg(&adev->ddev, "use ip discovery information from psp mailbox\n");
+		r = amdgpu_psp_read_discovery(adev, discovery_bin,
+					      GFX_CTRL_ADDR_TYPE_GUEST_PHY_ADDR);
+		if (r)
+			goto out;
 	} else {
 		drm_dbg(&adev->ddev, "use ip discovery information from memory\n");
 		r = amdgpu_discovery_read_binary_from_mem(adev, discovery_bin,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index c0ed3e24b684..50861175d661 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -52,6 +52,12 @@
 
 #define PSP_IRQ_DEFAULT_HANDLER_ID 0xFFFFFFFF
 
+/* Note: These are pre-IP-discovery fixed MMIO indexes */
+#define mmMP0_SMN_C2PMSG_64_MMIO	0x16080
+#define mmMP0_SMN_C2PMSG_69_MMIO	0x16085
+#define mmMP0_SMN_C2PMSG_70_MMIO	0x16086
+#define mmMP0_SMN_C2PMSG_71_MMIO	0x16087
+
 static int psp_load_smu_fw(struct psp_context *psp);
 static int psp_rap_terminate(struct psp_context *psp);
 static int psp_securedisplay_terminate(struct psp_context *psp);
@@ -761,17 +767,13 @@ static int psp_sw_fini(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
-int psp_wait_for(struct psp_context *psp, uint32_t reg_index, uint32_t reg_val,
-		 uint32_t mask, uint32_t flags)
+static int __psp_wait_for(struct amdgpu_device *adev, uint32_t reg_index, uint32_t reg_val,
+			  uint32_t mask, uint32_t flags)
 {
 	bool check_changed = flags & PSP_WAITREG_CHANGED;
 	bool verbose = !(flags & PSP_WAITREG_NOVERBOSE);
 	uint32_t val;
 	int i;
-	struct amdgpu_device *adev = psp->adev;
-
-	if (psp->adev->no_hw_access)
-		return 0;
 
 	for (i = 0; i < adev->usec_timeout; i++) {
 		val = RREG32(reg_index);
@@ -793,6 +795,17 @@ int psp_wait_for(struct psp_context *psp, uint32_t reg_index, uint32_t reg_val,
 	return -ETIME;
 }
 
+int psp_wait_for(struct psp_context *psp, uint32_t reg_index, uint32_t reg_val,
+		 uint32_t mask, uint32_t flags)
+{
+	struct amdgpu_device *adev = psp->adev;
+
+	if (psp->adev->no_hw_access)
+		return 0;
+
+	return __psp_wait_for(adev, reg_index, reg_val, mask, flags);
+}
+
 int psp_wait_for_spirom_update(struct psp_context *psp, uint32_t reg_index,
 			       uint32_t reg_val, uint32_t mask, uint32_t msec_timeout)
 {
@@ -3347,6 +3360,42 @@ int psp_securedisplay_invoke(struct psp_context *psp, uint32_t ta_cmd_id)
 }
 /* SECUREDISPLAY end */
 
+int amdgpu_psp_read_discovery(struct amdgpu_device *adev, uint8_t *binary,
+			      GFX_CTRL_ADDR_TYPE addr_type)
+{
+	void *cpu_addr;
+	dma_addr_t dma_addr;
+	u32 length;
+	int ret;
+
+	cpu_addr = dma_alloc_coherent(adev->dev, adev->discovery.size,
+				      &dma_addr, GFP_KERNEL);
+	if (!cpu_addr)
+		return -ENOMEM;
+
+	length = adev->discovery.size;
+	length = (length & 0x0fffffffU) | ((u32)addr_type << 28);
+
+	WREG32(mmMP0_SMN_C2PMSG_69_MMIO, lower_32_bits((u64)dma_addr));
+	WREG32(mmMP0_SMN_C2PMSG_70_MMIO, upper_32_bits((u64)dma_addr));
+	WREG32(mmMP0_SMN_C2PMSG_71_MMIO, length);
+
+	WREG32(mmMP0_SMN_C2PMSG_64_MMIO, GFX_CTRL_CMD_ID_GET_IP_DISCOVERY);
+
+	ret = __psp_wait_for(adev, mmMP0_SMN_C2PMSG_64_MMIO,
+			     MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK,
+			     PSP_WAITREG_NOVERBOSE);
+	if (ret) {
+		dev_err(adev->dev, "ip_discovery: PSP cmd failed\n");
+	} else {
+		memcpy(binary, cpu_addr, adev->discovery.size);
+	}
+
+	dma_free_coherent(adev->dev, adev->discovery.size, cpu_addr, dma_addr);
+
+	return ret;
+}
+
 int amdgpu_psp_wait_for_bootloader(struct amdgpu_device *adev)
 {
 	struct psp_context *psp = &adev->psp;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
index 975d12359358..fe3d053d9924 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -688,6 +688,8 @@ int psp_memory_partition(struct psp_context *psp, int mode);
 
 int is_psp_fw_valid(struct psp_bin_desc bin);
 
+int amdgpu_psp_read_discovery(struct amdgpu_device *adev, uint8_t *binary,
+			      GFX_CTRL_ADDR_TYPE addr_type);
 int amdgpu_psp_wait_for_bootloader(struct amdgpu_device *adev);
 bool amdgpu_psp_get_ras_capability(struct psp_context *psp);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h b/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
index 49aa95c76745..d13ae1756887 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
+++ b/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
@@ -49,6 +49,7 @@ enum psp_gfx_crtl_cmd_id
     GFX_CTRL_CMD_ID_GBR_IH_SET      = 0x00080000,   /* set Gbr IH_RB_CNTL registers */
     GFX_CTRL_CMD_ID_CONSUME_CMD     = 0x00090000,   /* send interrupt to psp for updating write pointer of vf */
     GFX_CTRL_CMD_ID_DESTROY_GPCOM_RING = 0x000C0000, /* destroy GPCOM ring */
+    GFX_CTRL_CMD_ID_GET_IP_DISCOVERY   = 0x000D0000, /* Copy IP_DISCOVERY_DATA to host-specified address */
 
     GFX_CTRL_CMD_ID_MAX             = 0x000F0000,   /* max command ID */
 };
@@ -58,7 +59,8 @@ typedef enum
     GFX_CTRL_ADDR_TYPE_AUTO_DETECT = 0,
     GFX_CTRL_ADDR_TYPE_SYS_PHY_ADDR,
     GFX_CTRL_ADDR_TYPE_GPU_PHY_ADDR,
-    GFX_CTRL_ADDR_TYPE_GPU_VIRT_ADDR
+    GFX_CTRL_ADDR_TYPE_GPU_VIRT_ADDR,
+    GFX_CTRL_ADDR_TYPE_GUEST_PHY_ADDR
 }  GFX_CTRL_ADDR_TYPE;
 
 /*-----------------------------------------------------------------------------
-- 
2.43.0

