Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC539606A329
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Nov 2026 11:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=24bKwQbs
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 85BCD10E2E3;
	Thu,  5 Nov 2026 11:18:13 +0000 (UTC)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011004.outbound.protection.outlook.com [40.107.208.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 580F610E2E3
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Nov 2026 11:18:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wfF+asLdw1qhtFT7g749iVcwfA7p4xlr/9DBaID8iWB/9VKAmRJvA4gceYKMesE38YMAcFWQ/ZVtQDlxdnu478Yal0HHt9S2qX/ABixiqjTooObHBQh9U7QZbVZ6SABMjyfszwHTIqiPcSysDQQdSzlhsgbs/NuGcSDEvM8yfLFiKcXyGV60D0bt8Bqvh05CRlDQAIKUZqRUn3z/G0BKYaaapRQ0CBrSqiu6w7B9kbkZIZYFR/IL3EEeGDTRsicxdtQcpEvaAEt+UgGAOrHj1lcsnVWKlGrQHfQ9BvNVkfxys+LUvSVt8w5298F3B9Wd9UUNoRmwobCZ0EP1yrnQ5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HnK2KJ3n3S7IgCdEFiYQSk7/x7dGQQCnqNGFvilMYaw=;
 b=Qydp1xzjyMHsjNKWOwhGaze6+qfMYDxm1KXVBJaQj/kmbtSv0zLh0cq7xruVYiTHU3CfasYI/TnbQiiY/88BrMkx0gYRJn6eW52z4aSeX3Pfcc3GZCfHo+m/TXgqhqAlMoRIHrvkUaTdqN+UnJLq3cqsm8Bk+RQkI3V5T3aGpp2yv2G5sCZYwCUk4HB+zSXJrW4qw4lU627iifsC2TJwSbFeELHBsiJ8LGXtWSpm37LrkkFUECk08E++7/O6Dpycv43e6ITWDb2JoXqMy68l7u/GQD8AIA7CoIS4toQqETWnqUqLIrst6BH47y5rXb4lSyMcNF2PmXapI/0gm0d1Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HnK2KJ3n3S7IgCdEFiYQSk7/x7dGQQCnqNGFvilMYaw=;
 b=24bKwQbsPSvEqg980+H1Zv3St7IF2HVdT9T24D1JLdBPFaqoxxmA07I/u+04edQg0GVEEkzC6w7vAjcSMusTaOILoIMLlZHkfdC65FTeycEXDFDf1fa8LWBPPcEXbAE4x273K6y7pntKwYanwvoJgdctF+lB8xXrxI5L0RC6XgQ=
Received: from SJ0PR13CA0060.namprd13.prod.outlook.com (2603:10b6:a03:2c2::35)
 by MW4PR12MB5603.namprd12.prod.outlook.com (2603:10b6:303:16a::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Thu, 5 Nov
 2026 11:18:02 +0000
Received: from MWH0EPF000D894E.namprd05.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::23) by SJ0PR13CA0060.outlook.office365.com
 (2603:10b6:a03:2c2::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4 via Frontend Transport; Thu, 5
 Nov 2026 11:18:01 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MWH0EPF000D894E.mail.protection.outlook.com (10.167.249.214) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Thu, 5 Nov 2026 11:18:01 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 5 Nov
 2026 05:18:01 -0600
Received: from RSNDADJELK01.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via
 Frontend Transport; Thu, 5 Nov 2026 05:17:59 -0600
From: Dejan Andjelkovic <Dejan.Andjelkovic@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Lijo.Lazar@amd.com>, <Nikola.Prica@amd.com>, 
 Dejan Andjelkovic <Dejan.Andjelkovic@amd.com>
Subject: [PATCH v4 1/2] drm/amdgpu: enable IP discovery via PSP mailbox
Date: Thu, 5 Nov 2026 12:17:51 +0100
Message-ID: <20261105111752.796343-1-Dejan.Andjelkovic@amd.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000D894E:EE_|MW4PR12MB5603:EE_
X-MS-Office365-Filtering-Correlation-Id: b0be7bfb-10f2-4909-c550-08df3b2e7469
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|23010399003|376014|1800799024|6133799003|10067099003|261102123227099003|18002099003|261021133027099003|261021130227099003|261028144727099003|5023799004|261021135927099003|261022115727099003|261022105027099003|11063799006|261022113327099003|261026140227099003|261026121527099003|261009221227099003|261009223027099003|261022075727099003|261021121427099003|261026135527099003|56012099006|261026130827099003|261021123027099003;
X-Microsoft-Antispam-Message-Info: oVN565f4NUu/9cF0WTIgfTv3Ib8oFaUZ2f6dKztIa3UqxOzoWSXe555bp/A00SgEMf+puai+mOrJTu8iN06t/XvK3Pmn5dT7rU9mMlhk8FC48fXGdGH8cGnp+bQlJO9ePDZOyA3cU9QvAR7lWm3ANWplNRmR2VNiSHSErGCTasmuXv2jwzuaGDe9KE8KCP9DikTqhtYaino3EqNBmEis0H6pwaApgbwYJsqThzfxvakXbprLvGlb749MtaPz2gdBk5apldv5ozvonqr1AXZLPT7y9oUoPVyG5FGxkQPqUNYkoGZX7nIOtnelS0DRFXpTYt2I0kSts+qdAGwYVkqknC/m+V2sY51Bc7i4KFDdnO99TspIGAbXmGguKPo0VzQ4fR4fnepXjPBNSzsvQpjxMmmv9S0reCsCBrxtmGe7u+lOLx1mviuI7fL4bM+/jzxUG/NB4MvwZ+CeUtmFzQetN7MgW+C+GEvLekn3/zFznaZBwc3uJe98+zNPZ6+joH8xbWIm31rmeC5vaKHTrhzEVwCIw3Y59NsoGvB27qw/y/5K0U9S1Ivq2N1fmsNIGRkhQD96Dska50YeXC7+J/Gb7TtWiVgOWe9pDoJLR1O8JqOe7i1NdS4dAlFjwckTKIpj/8Q6EC9UgdWmBaC8fzecHG6e8W7wjGVhsx7/hJtCF2nYX41eDUZM1xd099jEKjHqZFdYX7eHdgn+F1r7WvxNng==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(23010399003)(376014)(1800799024)(6133799003)(10067099003)(261102123227099003)(18002099003)(261021133027099003)(261021130227099003)(261028144727099003)(5023799004)(261021135927099003)(261022115727099003)(261022105027099003)(11063799006)(261022113327099003)(261026140227099003)(261026121527099003)(261009221227099003)(261009223027099003)(261022075727099003)(261021121427099003)(261026135527099003)(56012099006)(261026130827099003)(261021123027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: RIThQCPQl/azjQnwkaErDSvz7cFZ2UlbwUc3xkjP3cRHBEYDnw1NlopWuoLWzaBlT/uT/VQk4TDoKnxr5NbOt9NxvI9A1ibWqkNuO6oCAORex90ZB4ivnMbCgiabJUalsu8W8bzz4hhoCbHfumidZZTfaUbwgbjlo/eFZq7VGmaPW19Peai2tKayFMi+9v+q6IwGJwZRB8rMr4Jt5fWn7mvYmhS1Sd5n0DamK38pAfsMqSg9VIELd681Ct/Cjm/X80Q72qxJnhxBSUUS4dkYMgLM+DjzHo5z1WZl7pSRme5yeIy5P57ikxzFYetVVguCRbtHPNp3qMzOdtoBfzVuVl28KsJS7JOUSo2paPTbfRYMJ8uobjmz1xStaFZDmIvuy+Zx2rqV3KoGvyjOcHTQu1umzTCTGNLnaBspqbkhYJmVrJraLdC6ylikvbr3fnjp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 11:18:01.6426 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0be7bfb-10f2-4909-c550-08df3b2e7469
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000D894E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5603
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
v3 -> v4:
- Prefer a discovery firmware file over the PSP mailbox.
- Renaming fixed mailbox registers to avoid redefition errors in the future.
- Return -EIO when the PSP reports a status, instead of waiting out the timeout.
- Drop Reviewed-by. The code changed after review.

 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  5 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |  6 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c       | 65 +++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h       |  2 +
 drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h       |  4 +-
 5 files changed, 81 insertions(+), 1 deletion(-)

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
index c0ed3e24b684..3e1a314e9560 100644
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
@@ -3347,6 +3353,65 @@ int psp_securedisplay_invoke(struct psp_context *psp, uint32_t ta_cmd_id)
 }
 /* SECUREDISPLAY end */
 
+static int amdgpu_psp_mbx_wait_resp(struct amdgpu_device *adev)
+{
+	u32 val;
+	int i;
+
+	for (i = 0; i < adev->usec_timeout; i++) {
+		val = RREG32(mmMP0_SMN_C2PMSG_64_MMIO);
+		if (val & GFX_CMD_RESPONSE_MASK) {
+			if (val & GFX_CMD_STATUS_MASK) {
+				dev_err(adev->dev,
+					"PSP mbx returned status 0x%04x\n",
+					val & GFX_CMD_STATUS_MASK);
+				return -EIO;
+			}
+			return 0;
+		}
+		udelay(1);
+	}
+
+	return -ETIMEDOUT;
+}
+
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
+	ret = amdgpu_psp_mbx_wait_resp(adev);
+	if (ret) {
+		if (ret == -ETIMEDOUT)
+			dev_err(adev->dev, "ip_discovery: PSP wait timed out\n");
+		else
+			dev_err(adev->dev, "ip_discovery: PSP wait failed\n");
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

