Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0866082BE7
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Nov 2026 16:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=ZLAAQg33
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8321810E143;
	Thu,  5 Nov 2026 16:02:37 +0000 (UTC)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012020.outbound.protection.outlook.com
 [40.93.195.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1319910E143
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Nov 2026 16:02:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gga0WAT+eZxiubdF5VfS0CXGIkrTto73TKvWv12XYlQ0tOqx/Cbcxmk9yDHnpXoxHgTlBKjClh8DQC7UOFB9x6mI/BG3Ync+L+go3EQJJeVYHJDR6NDr1oPQPDTfnvq8vhQkq+FEiPSw8h9VFj5c8pOyWnjJb5UtiOtCMTqUKeX05IAVIb6611BgOKygoaWw92cR3KlJnDvav3WOvX8t+gacR6NaeyDp9nHm48JbV22t7dZ3nFq5hH9dqQLCB7RGfZr25ntpr7JqeeKG6GPI2WheEY75MiIn1/jdxysXB9nwGLgl4yXlqD8dJfKmDBj8QFLJbfWO50SB2T5+nsbvRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VOnY+/ICN9SE0OR+i5FU82QgK5wdXKfc+UW98oT6zoA=;
 b=JjYP4tGaFDyIq48yWpDTq0nurVOaHfJpDE8sH4HZdp8Cr+mJoE2qcxwYPevB6HglB0KdioegSGZiIrN52lhMbG95ZpkvypoB7WyBSk+jYZFucNckSE1ChbTdl8nYCHkqnZNxZojPa0w69d3pelgKeSx89zNbF3vDSqMvgdXzk6iGaGIeGDehuWd9YM+Yz2Jp4O/DBlAcNq+z4u1CCb9l/60dWiG3WKpQUgjieuSNTO7TznmnjCfXVCqkW6SkwVBX6K4Jf1C63GXSFFOyo1zr8dAPXLTgBN17MSm2pFgkkWgTGvA9BTW7e/ZI9+Wc03oXgPF7qcSmcP2HNtzAXvY0UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VOnY+/ICN9SE0OR+i5FU82QgK5wdXKfc+UW98oT6zoA=;
 b=ZLAAQg33ooo7C3VXkHv4DtuhW+SnE24wDV620CMmtzZbtSf6bjnR5bnOMZyMLgvSwZ/g4mocLUfKRU2RXguHVl3D7Q4DDTPlQDs8SRNe/qAhHwpzGWAjyaOu3fC8rFzDfvFCq+PwVZ4UsNUR4i1Jy3M0ci+MapfDLVk8Nv+KkL8=
Received: from CH0PR03CA0312.namprd03.prod.outlook.com (2603:10b6:610:118::21)
 by BL1PR12MB5900.namprd12.prod.outlook.com (2603:10b6:208:398::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 16:02:29 +0000
Received: from DS4PEPF000001C4.namprd21.prod.outlook.com
 (2603:10b6:610:118:cafe::3c) by CH0PR03CA0312.outlook.office365.com
 (2603:10b6:610:118::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Thu, 5
 Nov 2026 16:02:29 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS4PEPF000001C4.mail.protection.outlook.com (10.167.23.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.2 via Frontend Transport; Thu, 5 Nov 2026 16:02:28 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 5 Nov
 2026 10:02:28 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 5 Nov
 2026 10:02:28 -0600
Received: from RSNDADJELK01.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via
 Frontend Transport; Thu, 5 Nov 2026 10:02:26 -0600
From: Dejan Andjelkovic <Dejan.Andjelkovic@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Lijo.Lazar@amd.com>, <Nikola.Prica@amd.com>, 
 Dejan Andjelkovic <Dejan.Andjelkovic@amd.com>
Subject: [PATCH v5 1/2] drm/amdgpu: enable IP discovery via PSP mailbox
Date: Thu, 5 Nov 2026 17:02:19 +0100
Message-ID: <20261105160220.881165-1-Dejan.Andjelkovic@amd.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PEPF000001C4:EE_|BL1PR12MB5900:EE_
X-MS-Office365-Filtering-Correlation-Id: cb2533ac-e053-4e33-392b-08df3b563140
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|36860700016|82310400026|261026135527099003|11063799006|5023799004|56012099006|261022113327099003|261022115727099003|261022105027099003|261021121427099003|261021135927099003|261021133027099003|261021130227099003|261009221227099003|261009223027099003|261021123027099003|261022075727099003|261102123227099003|261026121527099003|261026130827099003|261026140227099003|261028144727099003|10067099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: FCuKIQp7Kie1DVl5PwFbWo5I3L5j5U/Ic1dnJOZkuGjs2YgmqLMOK2vBHn/y4oJkMB90w+W6WNxDO8vO4+7VShOkJYZ/38U2+73plv0ia62Jdaw65fR1qpJORMNgse8f+YbLYGpb+9ClFPLYDlTslI+I9kMUckOLul+ohAbThDxTCFfgKAfbGC2PBOsazVRueFKwpv9YXKeATZ9SPRNxG1GHMmIK7C0lq8PhV9U0msnuioGlqju5AZjN2q3q5IEc+g2tfKaLhoUzPlp5pLF3+YGKi6MzRNQfPS7tv9E6STaZq9Qmiq1WiElvbptWZCh65b+UdEaWykl6BkB6Bw429dCojWnK3cPnb/LY06ii3nlMcN29SO7RJsP4qVqqxvoWhPplwQf8XjrTF1OtuyYd+Qgk/iVXPld4xevbW6zvfqEFvZzhF7rS8KaX7V1SWvKbL7gqiy6PQPOyOIgWNDd8evs5UsWeEo8woZDDMz80uynx2vvWiVjf1dPREMiiivk7Wd88QhCeVCYi2Tiy7Yq6ygA2eZF7zm+14jVSYikKEdFPrFircHZ14hedzCYcB1ekqjtKCNakDe3LEYGgzN/k4uoOxoZZpiVF0b9fAdXDE9MCyTDWQIRWecoCia/Kq7eLAQIfR4V5uARbgEG/2RXZ6PRGif9jWymeadKOrGiAcJToIaD43VQbbW7wh7qPPRf9cpE/VFfKgYP6Nx8J4aDejw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(36860700016)(82310400026)(261026135527099003)(11063799006)(5023799004)(56012099006)(261022113327099003)(261022115727099003)(261022105027099003)(261021121427099003)(261021135927099003)(261021133027099003)(261021130227099003)(261009221227099003)(261009223027099003)(261021123027099003)(261022075727099003)(261102123227099003)(261026121527099003)(261026130827099003)(261026140227099003)(261028144727099003)(10067099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 8OR2QRrPEW2m4Ynbh2pgyEhJVk83Z1N9TsbBGe75/AxDTIFGVdMMHRq8AaJ5JBo5UBH9+JrpC7OyfBnHXnbZTTKB+u9UOaoRXHB8AN5msZ+RchgBE53BUN7OwiCW9hZAIsYaE82AQaPPltswpsa3GL4WUVaIDvWWfq+h2HlrXPLcK9UrOpgAM0c6b3GRvHDDlLW3zyVNFd6pWa+hWNvJgHervr0/EXEjJiPtis81eGjiKJsdKo6uHBtMds48z9G+3HZkqgRkAMpBp0hSUInlyR2DzUj3nYbTzv3G9GvysE4jUDmGiT8UXnCXWaqvP8qdylZ7N5+9X8SM78CDBCtC1UP6sFSJWx48ep1ikyRLA6W4qbWpC/pQiLrLxX8jfisEw9GKW2E7upieFRgwSo5h0BFm3ocf388Rscht1HYzss5qWVMQzcB9xbsEjg2VzZ7Z
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 16:02:28.8644 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb2533ac-e053-4e33-392b-08df3b563140
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS4PEPF000001C4.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5900
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
v4 -> v5:
- Split psp_wait_for() so the poll takes an amdgpu_device. IP discovery runs before psp->adev is set.
- Drop amdgpu_psp_mbx_wait_resp(). Wait for the response bit with __psp_wait_for(), then return -EIO if the status field is nonzero.

 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  5 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |  6 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       | 69 +++++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h       |  2 +
 drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h       |  4 +-
 5 files changed, 79 insertions(+), 7 deletions(-)

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
index c0ed3e24b684..50f87bb424c7 100644
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
@@ -3347,6 +3360,50 @@ int psp_securedisplay_invoke(struct psp_context *psp, uint32_t ta_cmd_id)
 }
 /* SECUREDISPLAY end */
 
+int amdgpu_psp_read_discovery(struct amdgpu_device *adev, uint8_t *binary,
+			      GFX_CTRL_ADDR_TYPE addr_type)
+{
+	void *cpu_addr;
+	dma_addr_t dma_addr;
+	u32 length;
+	u32 resp;
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
+			     GFX_CMD_RESPONSE_MASK, GFX_CMD_RESPONSE_MASK,
+			     PSP_WAITREG_NOVERBOSE);
+	if (ret) {
+		dev_err(adev->dev, "ip_discovery: PSP wait timed out\n");
+	} else {
+		resp = RREG32(mmMP0_SMN_C2PMSG_64_MMIO);
+		if (resp & GFX_CMD_STATUS_MASK) {
+			dev_err(adev->dev, "PSP mbx returned status 0x%04x\n",
+				resp & GFX_CMD_STATUS_MASK);
+			ret = -EIO;
+		} else {
+			memcpy(binary, cpu_addr, adev->discovery.size);
+		}
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

