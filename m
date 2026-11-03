Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AAE4606A326
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Nov 2026 14:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=vr4J2XWv
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0852910F617;
	Tue,  3 Nov 2026 14:44:17 +0000 (UTC)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012056.outbound.protection.outlook.com [52.101.48.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA5DA10F617
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Nov 2026 14:44:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JEMfN0eJzxZjronKMdcw+u5qIdZDVRmbSDo1N2VmRUPgISzlAS/TuIjVhhdVeX/StNDTb4bSp+p+Rt4uEjhNyMLbfiKcjqUO4dcmmGUXG12izffkIoUJ6zw9WpTJXhj9QlDQBss/aeSjNqTd6rVGGOnwpFgWWnZ6T1+wVr1cbxRHo5NP14djWIlIuYt3E9tdGv82bq7AElZ1n1CdZmDkRc6DmpBckJ9rz9WhA6fh72wEzPVdGNyX78CpMOC1CbQUvb7d5qZCiJgO66PTqFGcO1cBwPMJbMWiHYXZye3o4Rt/tG+I5xM8xTifh3jiLRZHOKjU4D0MHzM5Cwi/1OVOuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pmBEUvrvZqkYtu4WCicS+GbwGXRkKX0b5RB6MApAOx0=;
 b=a/a3uBy6E37n5TyxRqZXLVH0CuNTrxKmpg2e0AQuHMlQWrSJ9hZv//nVmmg3HnM/gNeIPeButtJrn0pS9A6ICEpjv4JhwEYOeH1JK7ZafPML6/KoJv4YWR94806oGHhCqiBVDaW6Nbx598ok8OCbT5fFuUx7G8TSeXk78159670gow/1Nya5F1WbxJtO8VB3evA55PkNuB7wHbpGAHKoKMHD9I603rNw3TtX8hCBhNIU9MS3N77IWv7+Y+vYmivpza+HZgqOVJNG2FVf0fCRAzdLaiDIgRN6A7EKZFbjIgO1jA1TvQOi0m9d7vXhiB/JgbaXkrdoYv5E+nVVBYQn5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pmBEUvrvZqkYtu4WCicS+GbwGXRkKX0b5RB6MApAOx0=;
 b=vr4J2XWvAIyQyBhWKnCZ8i3aassxWWZsILxU2f6tpuGfWAcjJpbfJmb1gGOxEq72HfXM3B9JNex87MeZCclE8Vhh26JxQcxvtqO6MD2F0eLkDHT7Y1/98SEWt5TKfnnluF5BUdpSVBQv8zcR5eZ9aBbPDy8bLPhBaIY6Mmt8y0I=
Received: from BN0PR03CA0028.namprd03.prod.outlook.com (2603:10b6:408:e6::33)
 by IA3PR12MB259910.namprd12.prod.outlook.com (2603:10b6:208:70e::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Tue, 3 Nov 2026
 14:44:05 +0000
Received: from BN3PEPF00022BD4.namprd03.prod.outlook.com
 (2603:10b6:408:e6:cafe::67) by BN0PR03CA0028.outlook.office365.com
 (2603:10b6:408:e6::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.8 via Frontend Transport; Tue, 3
 Nov 2026 14:44:05 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF00022BD4.mail.protection.outlook.com (10.167.248.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Tue, 3 Nov 2026 14:44:05 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 3 Nov
 2026 08:44:04 -0600
Received: from RSNDADJELK01.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via
 Frontend Transport; Tue, 3 Nov 2026 08:44:03 -0600
From: Dejan Andjelkovic <Dejan.Andjelkovic@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Lijo.Lazar@amd.com>, <Nikola.Prica@amd.com>, 
 Dejan Andjelkovic <Dejan.Andjelkovic@amd.com>
Subject: [PATCH v3 1/2] drm/amdgpu: Enable IP discovery via PSP mailbox
Date: Tue, 3 Nov 2026 15:44:00 +0100
Message-ID: <20261103144401.298613-1-Dejan.Andjelkovic@amd.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BD4:EE_|IA3PR12MB259910:EE_
X-MS-Office365-Filtering-Correlation-Id: aa139869-ec83-4ac3-fa04-08df39b8e8fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|82310400026|36860700016|261022105027099003|5023799004|11063799006|56012099006|261009221227099003|261009223027099003|261021130227099003|261021133027099003|261022075727099003|261021121427099003|261022113327099003|261021123027099003|261022115727099003|261021135927099003|261102123227099003|261028144727099003|261026130827099003|261026140227099003|261026135527099003|261026121527099003|10067099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: Bt5ofJZbdU9+IfQJFzpOeFy7rumX2sQ35lmPCczQQx6ID+4U8+DqIxXzOWgEHCvkuJvpVc4TOy8v5Uq2FORkS20T9EGp6Sf6UcWipzRw9IpVdi2lnngaEG8vCbiiiRLBY9HDLloMmSVz2GaT23sgVCZ35yOZUFwNaH4QZUtW8ZDHObWBrSdSRzNClvWw3vd5xRddZrXjP4ehXOL2J1wpS7lfsJP0WoWyJzB4Pwci1nekps2ZTzoQTLoUpJy0K+oVbM4A/tMhaJF5rCVfTN6OtOQmWs43LUevSSOAvkTvbll3Mxw6LLFCe6v4SxCzW3xTGW3Z/PaL6+L4fIj9lfLJXjjUUq8+r9oNrpCzuoqjBD93KcCzpiIOrHTD+STBQr8dsUX9ApyKUNTSce5yC6dotw6EabdEpT7qnvD7zvBb11sr0RTayGjEZuiyC4FsHM6v9Exi/o4/CUJSz5zUzmD736RnAik+Q0cwAKyMXm5495pTFVGpeU7b/FX4UDybGhE1YSX/0uOUJmi4VkPq8muf/uixg3A5sUPH8crxQbvs/QIWQAxWFxQlF+NZ6s1E2rZ40AmkHFxG20psYP8tyVZVECXbVbANEeLhLXfmGU5NdNhDm7cLOuxZh12m5wx62hPU1vH/aJ5F1kyyr+5MFfFkejZ3raJEgmUvG126gvOSOwOwHSIrqluplFqp6LW5B82oYzbrCliAvzwN58oYCN8r6g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(82310400026)(36860700016)(261022105027099003)(5023799004)(11063799006)(56012099006)(261009221227099003)(261009223027099003)(261021130227099003)(261021133027099003)(261022075727099003)(261021121427099003)(261022113327099003)(261021123027099003)(261022115727099003)(261021135927099003)(261102123227099003)(261028144727099003)(261026130827099003)(261026140227099003)(261026135527099003)(261026121527099003)(10067099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 93mpzJ9BlnXqlQCxmfIxOhB0M1HCrF8GniowvHShXGn8L0Kr7hPu5NgQSkHdTMf0sqHw2OjUk07D8h0OnnH1wBWNmuz+wvGHonjaSqKZ0Doiy6nAkUNhH+qAAH4iawUKpD7aYnC0bq46DtuLAixNYT2Okx0XCPPBqJZfAIO7ps7Detexf0Xrx6VGlI8QkNmPZZOV9IfBepXor+Y7yvFXrvv/EkQSkH1t4BEpIQIHRBmuiy6mQbJ7l6D0Wp3IyHml2IwoZNAQC0CqFJyRc8ypkvfJxYofqI3zzCCTJfLRGYyDAYgRF/PHcbyb+doJKNw8qBvLYdX+W/LscJMO+zbph+HL2NbKfiI/sX+EKZZRZe5FuU8t97iD67u6FZHx0Oe/xrZyVez4NmsO5mIKJ3kMvXsDQdeKATGvucloXPj8gDApPxWMJYLmXcr05ruIIlCP
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 14:44:05.5125 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa139869-ec83-4ac3-fa04-08df39b8e8fc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF00022BD4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR12MB259910
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

Signed-off-by: Dejan Andjelkovic <Dejan.Andjelkovic@amd.com>
---
v3: Adjust how A+A & passthrough case is detected, moved psp functions
to amdgpu_psp as suggested by Lijo.Lazar@amd.com.

 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  5 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |  8 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       | 53 +++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h       |  2 +
 drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h       |  4 +-
 5 files changed, 70 insertions(+), 2 deletions(-)

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
index 79a2b1268b23..d264a135ad27 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -765,7 +765,13 @@ static int amdgpu_discovery_init(struct amdgpu_device *adev)
 	discovery_bin = adev->discovery.bin;
 	/* Read from file if it is the preferred option */
 	fw_name = amdgpu_discovery_get_fw_name(adev);
-	if (fw_name != NULL) {
+	if (amdgpu_is_spm_passthrough(adev)) {
+		drm_dbg(&adev->ddev, "use ip discovery information from psp mailbox");
+		r = amdgpu_psp_read_discovery(adev, discovery_bin,
+								GFX_CTRL_ADDR_TYPE_GUEST_PHY_ADDR);
+		if (r)
+			goto out;
+	} else if (fw_name != NULL) {
 		drm_dbg(&adev->ddev, "use ip discovery information from file\n");
 		r = amdgpu_discovery_read_binary_from_file(adev, discovery_bin,
 							   fw_name);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 01dca6858833..b1492f8d5d92 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -52,6 +52,11 @@
 
 #define PSP_IRQ_DEFAULT_HANDLER_ID 0xFFFFFFFF
 
+#define mmMP0_SMN_C2PMSG_64	0x16080
+#define mmMP0_SMN_C2PMSG_69	0x16085
+#define mmMP0_SMN_C2PMSG_70	0x16086
+#define mmMP0_SMN_C2PMSG_71	0x16087
+
 static int psp_load_smu_fw(struct psp_context *psp);
 static int psp_rap_terminate(struct psp_context *psp);
 static int psp_securedisplay_terminate(struct psp_context *psp);
@@ -3347,6 +3352,54 @@ int psp_securedisplay_invoke(struct psp_context *psp, uint32_t ta_cmd_id)
 }
 /* SECUREDISPLAY end */
 
+static int amdgpu_psp_mbx_wait_resp(struct amdgpu_device *adev)
+{
+	u32 val;
+	int i;
+
+	for (i = 0; i < adev->usec_timeout; i++) {
+		val = RREG32(mmMP0_SMN_C2PMSG_64);
+		if ((val & 0x8000FFFF) == 0x80000000)
+			return 0;
+		udelay(1);
+	}
+
+	return -ETIMEDOUT;
+}
+
+int amdgpu_psp_read_discovery(struct amdgpu_device *adev, uint8_t *binary,
+			 GFX_CTRL_ADDR_TYPE addr_type)
+{
+	void *cpu_addr;
+	dma_addr_t dma_addr;
+	uint32_t length;
+	int ret;
+
+	cpu_addr = dma_alloc_coherent(adev->dev, adev->discovery.size,
+	&dma_addr, GFP_KERNEL);
+	if (!cpu_addr)
+		return -ENOMEM;
+
+	length = adev->discovery.size;
+	length = (length & 0x0fffffffU) | ((u32)addr_type << 28);
+
+	WREG32(mmMP0_SMN_C2PMSG_69, lower_32_bits((u64)dma_addr));
+	WREG32(mmMP0_SMN_C2PMSG_70, upper_32_bits((u64)dma_addr));
+	WREG32(mmMP0_SMN_C2PMSG_71, length);
+
+	WREG32(mmMP0_SMN_C2PMSG_64, GFX_CTRL_CMD_ID_GET_IP_DISCOVERY);
+
+	ret = amdgpu_psp_mbx_wait_resp(adev);
+	if (ret)
+		dev_err(adev->dev, "ip_discovery: PSP wait timed out\n");
+	else
+		memcpy(binary, cpu_addr, adev->discovery.size);
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
index a4ec60f6c317..3ca2fe9ce94d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -688,6 +688,8 @@ int psp_memory_partition(struct psp_context *psp, int mode);
 
 int is_psp_fw_valid(struct psp_bin_desc bin);
 
+int amdgpu_psp_read_discovery(struct amdgpu_device *adev, uint8_t *binary,
+			 GFX_CTRL_ADDR_TYPE addr_type);
 int amdgpu_psp_wait_for_bootloader(struct amdgpu_device *adev);
 bool amdgpu_psp_get_ras_capability(struct psp_context *psp);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h b/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
index 49aa95c76745..e0713e27556f 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
+++ b/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
@@ -49,6 +49,7 @@ enum psp_gfx_crtl_cmd_id
     GFX_CTRL_CMD_ID_GBR_IH_SET      = 0x00080000,   /* set Gbr IH_RB_CNTL registers */
     GFX_CTRL_CMD_ID_CONSUME_CMD     = 0x00090000,   /* send interrupt to psp for updating write pointer of vf */
     GFX_CTRL_CMD_ID_DESTROY_GPCOM_RING = 0x000C0000, /* destroy GPCOM ring */
+    GFX_CTRL_CMD_ID_GET_IP_DISCOVERY   = 0x000D0000,   /**< Copy IP_DISCOVERY_DATA to host-specified address */
 
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

