Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8084606A325
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Oct 2026 14:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=1hTVxiLo
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BC8511286E;
	Fri, 30 Oct 2026 14:51:30 +0000 (UTC)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012071.outbound.protection.outlook.com [40.107.209.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 514FB11286E
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Oct 2026 14:51:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tt/XUkbGCz84JvDcfUJcRqEax7h/prTR6Z3bW+xUj3LL/Pnm21m89HU4fbAT29ER8Kv6M9z6XWcip1iY4a7MGDgOfHtMijxk8Fc3fpW4Ig/JMvH73CZDrTRSDP0R6/25GgmnDpbFENV8DaKXM3HzcjYSUClE5so11v1datiOGqRsMCB87vw+5LKQk6s/r4B1cBovN1S7Nk42sytaspQMQVsX+Q8o6Z8vsxT6sbExtWcgPNzUVu9mHm7uwGq1F6LA3+mjBrNdUKah2wRxibg67Cq9Uspankl8KEuD+9StSh4k5rWxW7afXMg4iKVZH832Y8N0e/+dBHWT9qebpNFGng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xvh19APF8wVs587ud4R9cFtSndfR+Nq0R9I+qh4gmdM=;
 b=cfzAdS9TYo9kNqxThSPvw9YXVAUaGvFClUHizcGI9jLVGmmbjoiVHm+04dvfk1X0kgvq1D4Phtv8BilO02KLLdx5uFbFmCHv7BiLa7hvP6QILDMUIk2TVFlJQmV/5L2ZD8Rgv2sqMUl97pgGVnyvaBZWf6w1oitPwsS5FOPtShX0wWYq2D5h3ush8EGpc5jSAV5KDjCGej9h6dOLEOF8Yboq+UGlwPWQYWbOqgr4PAZOA9oHzq0y30gE8FYpaa3sNIG2HMUq8TnNtKnkmyiI289C87z9phyH+1KVRLqtZIHqRR0FLxf4A1Z8FtlxQwrM47gxvn8xAGOouGtXqktHFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xvh19APF8wVs587ud4R9cFtSndfR+Nq0R9I+qh4gmdM=;
 b=1hTVxiLovYMA5mnTvUGtH32Sjwy1k55qf/WUSuehOGJxSQBOxBrWk1arI5PQ6NaCznf4TNdxo1W42gu92ybXShSwLX4/QtbGp3rcurqo3U2cYdZ+GbSjQZXwgZEgLZNm5wPI2wNkApgVJHY+i+ernisnLyXxNBQch6lST8T81Uw=
Received: from MW4PR03CA0054.namprd03.prod.outlook.com (2603:10b6:303:8e::29)
 by LV3PR12MB9216.namprd12.prod.outlook.com (2603:10b6:408:1a5::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.9; Fri, 30 Oct
 2026 14:51:15 +0000
Received: from BY1PEPF0001AE1D.namprd04.prod.outlook.com
 (2603:10b6:303:8e:cafe::9b) by MW4PR03CA0054.outlook.office365.com
 (2603:10b6:303:8e::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.9 via Frontend Transport; Fri, 30
 Oct 2026 14:51:14 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BY1PEPF0001AE1D.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Fri, 30 Oct 2026 14:51:13 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 30 Oct
 2026 09:51:12 -0500
Received: from RSNDADJELK01.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via
 Frontend Transport; Fri, 30 Oct 2026 09:51:10 -0500
From: Dejan Andjelkovic <Dejan.Andjelkovic@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Lijo.Lazar@amd.com>, <Nikola.Prica@amd.com>, 
 Dejan Andjelkovic <Dejan.Andjelkovic@amd.com>
Subject: [PATCH v2 1/2] drm/amdgpu: Enable IP discovery via PSP mailbox
Date: Fri, 30 Oct 2026 15:50:55 +0100
Message-ID: <20261030145056.518748-1-Dejan.Andjelkovic@amd.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1D:EE_|LV3PR12MB9216:EE_
X-MS-Office365-Filtering-Correlation-Id: f38a8f9e-5fec-48b3-aeec-08df36953e73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|23010399003|1800799024|18002099003|56012099006|11063799006|261022075727099003|10067099003|261021123027099003|261028144727099003|261021121427099003|261022105027099003|261009223027099003|261026121527099003|261026140227099003;
X-Microsoft-Antispam-Message-Info: mtAF1pOn5ltKKw/FArAlWzPUVbHOJx5FQc0Vbbx/jnGlpxLvdQVUwsn/Z7J3gaP8puAxRlS3eCQKQ4LQo8tSTLQ2aX3Qr4ziPxuvkU02Ipb1gNLB/yxwhIH66iOwCo/MQq4lYwwsfBSzpmTK/d4EvxEk0U6xMGEOSiFUKSzEc2yHDYx0QbCxU28jDQ3MCu/+OTxZPgAow+B9f5nY0LJEhiOOPbKP9kiijc0WL4LgBFjeb/ZLhWYZPc+7xUfyt2xLztGxNP1vq0Hkty+RhHFIMcSWxbIiNeypESo7Hcp4rUedqV90lQvvVcHMe9GzWi8zIYNKTZ/738K6PB23QpIozrQgDqrrek9UcXiMkGiWnZQ6yYDAxHJr1VjHcjsFo7URA6wZcKoUBAz+UTYRPibQnbiXRMCZYErAvaEuRoOv72Lb+3lHt6+RilceJtbXeobh+1PcBQ5/gzzQsZB1IdPGF4knPmDhmaJ7w2kqiWBBJIgqJBQEQnLURLga9NiBoOvW98pCJOb6+obW3hPTIreZ4nuGr0jA0cgCzouwnZmYZOVPAVvlLyeyvLMJMvfu8/znM/sIEsOBnFOv3/JX1RkKhFT+C/dEwbTXxmdA3ca03D5ChJu+UJtxkfr/+wyWrp+6rKd/UbJ+kgSMhirB8pyuTJlwGnXnCEkBiedznzjpIJkdqdwjcjMaStIRddqMAII2DncDMTtaUJFZQeLes8ugjw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(23010399003)(1800799024)(18002099003)(56012099006)(11063799006)(261022075727099003)(10067099003)(261021123027099003)(261028144727099003)(261021121427099003)(261022105027099003)(261009223027099003)(261026121527099003)(261026140227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: OWtL/2gSjUzZw7Th8cglGN++8HrKD0ov2tMnHJK8tE7uThQ2afC1rmFJsGa2og20vgLjvoPx0ZAei8ZHIQQnZzdvVv5a8MPrfS70cO9f5XP8Ronm1fb2588fsbPhDo8Sj/+L9yu5KxkRDIVfHu+GDqp3BQj524tLhSPRCMwficN0D/y7LirZR9xzXB6kHkK7MqPsLy10zK+4LcoSd36kdqDfQoiMYLtLcAQZzkzDcjFbwVFCIsmzS3/4zkiQo+gDh8A4o5BnspNQG70aI+hu2jubSLv2FnTKv0PiNqswqRUaaiQXGS5iTLFcm1NOldsU6QWPOPYT2gcEFOmXTNkNpOrdBxgPUuibuR7YvZGo8S3CTT1bo+doXpw7Mkt7XcV3cN5xuohhvXv/t8b01zrPH5QD3GWGttZ+iKmFzaUjUXDESqXsRUkECehMnuQNBVLX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 14:51:13.4415 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f38a8f9e-5fec-48b3-aeec-08df36953e73
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE1D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9216
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
v2: Adjust how A+A & passthrough case is detected as suggested by
    Lijo.Lazar@amd.com.

 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c | 56 ++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h       |  4 +-
 2 files changed, 58 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 5564850e3ff4..047034cf7d20 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -28,6 +28,7 @@
 #include "amdgpu_discovery.h"
 #include "amdgpu_ualink.h"
 #include "soc15_hw_ip.h"
+#include "psp_gfx_if.h"
 #include "discovery.h"
 #include "amdgpu_ras.h"
 
@@ -149,6 +150,10 @@ MODULE_FIRMWARE("amdgpu/aldebaran_ip_discovery.bin");
 #define mmRCC_CONFIG_MEMSIZE	0xde3
 #define mmRCC_HW_DEBUG		0x10c01
 #define mmMP0_SMN_C2PMSG_33	0x16061
+#define mmMP0_SMN_C2PMSG_64	0x16080
+#define mmMP0_SMN_C2PMSG_69	0x16085
+#define mmMP0_SMN_C2PMSG_70	0x16086
+#define mmMP0_SMN_C2PMSG_71	0x16087
 #define mmMM_INDEX		0x0
 #define mmMM_INDEX_HI		0x6
 #define mmMM_DATA		0x1
@@ -410,6 +415,47 @@ static int amdgpu_discovery_read_binary_from_sysmem(struct amdgpu_device *adev,
 	return -ENOENT;
 }
 
+static int amdgpu_discovery_wait_psp_gfx_ctrl_resp(struct amdgpu_device *adev)
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
+static int amdgpu_discovery_read_binary_from_psp_mailbox(struct amdgpu_device *adev,
+							 uint8_t *binary,
+							 GFX_CTRL_ADDR_TYPE addr_type)
+{
+	phys_addr_t phys_addr;
+	uint32_t length;
+	int ret;
+
+	phys_addr = virt_to_phys(binary);
+
+	length = adev->discovery.size;
+	length = (length & 0x0fffffffU) | ((u32)addr_type << 28);
+
+	WREG32(mmMP0_SMN_C2PMSG_69, lower_32_bits((u64)phys_addr));
+	WREG32(mmMP0_SMN_C2PMSG_70, upper_32_bits((u64)phys_addr));
+	WREG32(mmMP0_SMN_C2PMSG_71, length);
+
+	WREG32(mmMP0_SMN_C2PMSG_64, GFX_CTRL_CMD_ID_GET_IP_DISCOVERY);
+
+	ret = amdgpu_discovery_wait_psp_gfx_ctrl_resp(adev);
+	if (ret)
+		dev_err(adev->dev, "ip_discovery: PSP wait timed out\n");
+
+	return ret;
+}
+
 #define IP_DISCOVERY_V2		2
 #define IP_DISCOVERY_V4		4
 
@@ -762,9 +808,17 @@ static int amdgpu_discovery_init(struct amdgpu_device *adev)
 		return r;
 
 	discovery_bin = adev->discovery.bin;
+	unsigned long bar_flags = pci_resource_flags(adev->pdev, 0);
 	/* Read from file if it is the preferred option */
 	fw_name = amdgpu_discovery_get_fw_name(adev);
-	if (fw_name != NULL) {
+	if (amdgpu_passthrough(adev) &&
+		((bar_flags & IORESOURCE_UNSET) || !(bar_flags & IORESOURCE_MEM))) {
+		drm_dbg(&adev->ddev, "use ip discovery information from psp mailbox");
+		r = amdgpu_discovery_read_binary_from_psp_mailbox(adev, discovery_bin,
+								GFX_CTRL_ADDR_TYPE_GUEST_PHY_ADDR);
+		if (r)
+			goto out;
+	} else if (fw_name != NULL) {
 		drm_dbg(&adev->ddev, "use ip discovery information from file\n");
 		r = amdgpu_discovery_read_binary_from_file(adev, discovery_bin,
 							   fw_name);
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

