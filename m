Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66954606A326
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Nov 2026 11:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=JDBsV+BR
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0472D11236F;
	Thu,  5 Nov 2026 11:19:11 +0000 (UTC)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010049.outbound.protection.outlook.com [52.101.61.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5FD811236E
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Nov 2026 11:19:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oKLylYL0MMCJ8zVuZS3jfSNt0eMv1eXuWGbIwYAsnghkeHd521iD2Z3ZHVQV/arBYfahQqMppNVpcquv3rLunruRK2l0Z1YnI76eikNRyDiPpd5yHij64GVA0YaBxA/swTyhz43F7w5i5h3dt6RQz9yEruBGevpRY8jW3TEWIk5ToWq4oIJ8V4KQNcl6wOktJvSys9yJgfGILao1gITV8dBpC674RNuaazSZqJjplxUXv2LSfl8SIKZ5zzxC0QcU+B/93Matt/wP+wTo3DhcUzdDmDzNBCBOn5wbAzr6m4nmqTRNlVf1vBObm3c83EXtaqx4A4jQq596QEJKCj0SwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rh/ZwdKh7cIue+/FlH1NTAq+CynspLmVKNfO3yldiDU=;
 b=Q7VjtqaC4VMmy0a4VfE00pkaWNz5ujfK/KHerorGapyPb5Ub7Ep2JrAzTeio3/tch6V4DtReKGcx9PB+eNGQVydG+HhuzmL2BtnT1jJOh/v0aJVIWT9nTXkS/ViiONF1E84omr3pZImjzj3LIpvsfLHbNGKVe4lQSywgm0gmv+KVnvZfBg75cn5lTTVzJjgNWkXsChMdq+Jn3gfQXAaR29pFjj2U9j8e1H9QQpEy94/K4HllOeGhe6NuwGGLJicGcfVp2BHqF9ZPkSQIpT5PclDY3IIHTdslMTi0BUGg8h2B8vj7ZNuHchC/UCosu+kU+nG92QAQpX72XvWkj3mQGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rh/ZwdKh7cIue+/FlH1NTAq+CynspLmVKNfO3yldiDU=;
 b=JDBsV+BRH886yegtj/x3tBqZ3TeQU1MIF1QXo8Abazic4xy7qDmTpFO/7WJf50aPl1XeTXRHBN+qq3hDO6APZOCYjUAC8Kw8TFcjCC6U0Oveu1/tCB+25kDQqxDUPY6oeocXOR75TwrL1l20RwKlEnOs1M5QRIZZZIygdl2WQBY=
Received: from PH8PR15CA0005.namprd15.prod.outlook.com (2603:10b6:510:2d2::12)
 by IA3PR12MB773576.namprd12.prod.outlook.com (2603:10b6:208:61f::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 11:18:06 +0000
Received: from PH7PEPF0000000A.namprd04.prod.outlook.com
 (2603:10b6:510:2d2:cafe::41) by PH8PR15CA0005.outlook.office365.com
 (2603:10b6:510:2d2::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Thu, 5
 Nov 2026 11:18:06 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 PH7PEPF0000000A.mail.protection.outlook.com (10.167.243.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Thu, 5 Nov 2026 11:18:06 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 5 Nov
 2026 05:18:04 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 5 Nov
 2026 05:18:04 -0600
Received: from RSNDADJELK01.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via
 Frontend Transport; Thu, 5 Nov 2026 05:18:03 -0600
From: Dejan Andjelkovic <Dejan.Andjelkovic@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Lijo.Lazar@amd.com>, <Nikola.Prica@amd.com>, 
 Dejan Andjelkovic <Dejan.Andjelkovic@amd.com>
Subject: [PATCH v4 2/2] drm/amdgpu: add support for FB carveout disablement
Date: Thu, 5 Nov 2026 12:17:52 +0100
Message-ID: <20261105111752.796343-2-Dejan.Andjelkovic@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261105111752.796343-1-Dejan.Andjelkovic@amd.com>
References: <20261105111752.796343-1-Dejan.Andjelkovic@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PEPF0000000A:EE_|IA3PR12MB773576:EE_
X-MS-Office365-Filtering-Correlation-Id: c65539c2-5228-4859-4e42-08df3b2e7716
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|36860700016|82310400026|11063799006|56012099006|261022105027099003|261021121427099003|261009221227099003|261009223027099003|261021123027099003|261102123227099003|261026121527099003|261026140227099003|261028144727099003|10067099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: uWP8FPPM5yuhRArv16nPrRDHArNwK6AsCvkuxWuIeYX55vroZN22STVqVg2cuRHFGp96up5B9hcg/vDYnEfvaMqJgChPhnw8i970bu5LqFxLVTCXbzQBygar4itCS54lbGgNZHGq62uDA9iPvfyQw6M1uYK8zyro250wLlrixC5ThPNp7xL78TvXUPv3u9J+7EjXt82JHpoHfCD0RPrH/rla1K2EBBCwN2CGbDhJNUz9ap3rP8Dl/oGQfY/b9FKY1/GdfC9NZOjvaK+LOTwkdOz9nhC3D4gCDAsbY3nJv/wminFjK4LMqvCK2ucTjoQUNGhem40C9lZsB5lYg5pvNNwmKADMwJ5q4PjYVK286aw58WLpqaiJor6+K0cLHShpwpG4QVdCm9ip5Ln6IwNYQx35XvdwLGRxJiqJkjwoYYxxrf6Mm2HogCkpVa5/WK0FZDKU5gIYlofDRAiqkIXpf4TlKgwHuJ2c1/zLqfuuHUKtrobbn7HLBC/to4fVqfwlFXQFaENVQ7G+H0yqnCrtDMBx9ByyfSVUDLJCOd+6i/6oBXeUV1l1ZF/UOBXuIVNn2zrTlGJax/06essB8nWkU+l1LY+V9RMIxIjhDsJLzJadOsZJBBEk36i3rsJ70pj1voJugXoS6S3aMxor1wDv09V2WEmKcpCkXeP13akTBwNkn1xmJRncUlVA1bvBHp0IBmdYj9J1Ws+3qqbkH4NTSg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(36860700016)(82310400026)(11063799006)(56012099006)(261022105027099003)(261021121427099003)(261009221227099003)(261009223027099003)(261021123027099003)(261102123227099003)(261026121527099003)(261026140227099003)(261028144727099003)(10067099003)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: qRyt/GkiX4DH9Ysn1Cx/GtyUHsITCzzOIFd/j3xblIZ6JpKCQOcWwZdN9suw7o2vtEJlAubwfMHuXc4Xxa4nGKylQX7sdymMUP6uuhpl5qViL+Q+Pih9aixmZhn4dxVAmUXCOEYM0sO/tadzfZvoYWT6OuS82pOIvPRhnUHvfhjEorsZy6MNp1dvVfbyeLGdcLjAPSZ+qbyB5VCXd6iNS405MraCbBPvcsG54zyNlcGcX3vRLZBf33wNLDoSohVmCxvruD+ovzF+j4pDMX8ViR/cb9qlYTXnJIoovrtmkMmkIndLZrnRJy/wKEGT+yzyHx92c7GAemfUrprEUneAxPSzbvrA0gWzcqGn/20Me56QN9PgckBjvNmLIGw76a03m9Q0yCHjGPYiCxEwvPRBMHun+vvrS28X8xogURU4p3oGSgsZT6khI9aWvMQlFKQQ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 11:18:06.1265 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c65539c2-5228-4859-4e42-08df3b2e7716
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: PH7PEPF0000000A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR12MB773576
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

On passthrough A+A the PSP keeps a framebuffer carveout the guest
cannot use. After IP discovery, ask the PSP to release it through the
GFX mailbox.

Define the enable command so the interface matches the ASP header.
The PSP locks this mailbox after the disable, so amdgpu never sends
the enable.

Grow the GFX command id field from 4 bits to 6 so these commands fit.

Signed-off-by: Dejan Andjelkovic <Dejan.Andjelkovic@amd.com>
---
v3 -> v4:
- Disable the FB carveout after the asic switch in early init, instead of discovery path.
- Widen the GFX command id field to 6 bits so the carveout commands fit.
- Log a timeout and a PSP status failure separately.
- Drop Reviewed-by. The code changed after review.

 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  6 ++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c    | 17 +++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h    |  1 +
 drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h    | 10 ++++++----
 4 files changed, 30 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 9326f811c500..7ff97861f8bf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2058,6 +2058,12 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
 		break;
 	}
 
+	if (amdgpu_is_spm_passthrough(adev)) {
+		r = amdgpu_psp_disable_fb_carveout(adev);
+		if (r)
+			return r;
+	}
+
 	/* Check for IP version 9.4.3 with A0 hardware */
 	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3) &&
 	    !amdgpu_device_get_rev_id(adev)) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 3e1a314e9560..5d1440ee1071 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -3412,6 +3412,23 @@ int amdgpu_psp_read_discovery(struct amdgpu_device *adev, uint8_t *binary,
 	return ret;
 }
 
+int amdgpu_psp_disable_fb_carveout(struct amdgpu_device *adev)
+{
+	int ret;
+
+	WREG32(mmMP0_SMN_C2PMSG_64_MMIO, GFX_CTRL_CMD_ID_DISABLE_FB_CARVEOUT);
+
+	ret = amdgpu_psp_mbx_wait_resp(adev);
+	if (ret) {
+		if (ret == -ETIMEDOUT)
+			dev_err(adev->dev, "disable_fb_carveout: PSP wait timed out\n");
+		else
+			dev_err(adev->dev, "disable_fb_carveout: PSP wait failed\n");
+	}
+
+	return ret;
+}
+
 int amdgpu_psp_wait_for_bootloader(struct amdgpu_device *adev)
 {
 	struct psp_context *psp = &adev->psp;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
index fe3d053d9924..e747eb47c47b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h
@@ -690,6 +690,7 @@ int is_psp_fw_valid(struct psp_bin_desc bin);
 
 int amdgpu_psp_read_discovery(struct amdgpu_device *adev, uint8_t *binary,
 			      GFX_CTRL_ADDR_TYPE addr_type);
+int amdgpu_psp_disable_fb_carveout(struct amdgpu_device *adev);
 int amdgpu_psp_wait_for_bootloader(struct amdgpu_device *adev);
 bool amdgpu_psp_get_ras_capability(struct psp_context *psp);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h b/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
index d13ae1756887..f42dd8ab5350 100644
--- a/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
+++ b/drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h
@@ -27,15 +27,15 @@
 #define PSP_GFX_CMD_BUF_VERSION     0x00000001
 
 #define GFX_CMD_STATUS_MASK         0x0000FFFF
-#define GFX_CMD_ID_MASK             0x000F0000
-#define GFX_CMD_RESERVED_MASK       0x7FF00000
+#define GFX_CMD_ID_MASK             0x003F0000
+#define GFX_CMD_RESERVED_MASK       0x7FC00000
 #define GFX_CMD_RESPONSE_MASK       0x80000000
 
 /* USBC PD FW version retrieval command */
 #define C2PMSG_CMD_GFX_USB_PD_FW_VER 0x2000000
 
 /* TEE Gfx Command IDs for the register interface.
-*  Command ID must be between 0x00010000 and 0x000F0000.
+*  Command ID must be between 0x00010000 and 0x003F0000.
 */
 enum psp_gfx_crtl_cmd_id
 {
@@ -50,8 +50,10 @@ enum psp_gfx_crtl_cmd_id
     GFX_CTRL_CMD_ID_CONSUME_CMD     = 0x00090000,   /* send interrupt to psp for updating write pointer of vf */
     GFX_CTRL_CMD_ID_DESTROY_GPCOM_RING = 0x000C0000, /* destroy GPCOM ring */
     GFX_CTRL_CMD_ID_GET_IP_DISCOVERY   = 0x000D0000, /* Copy IP_DISCOVERY_DATA to host-specified address */
+    GFX_CTRL_CMD_ID_DISABLE_FB_CARVEOUT = 0x00100000, /* Message runtime VBL to disable FB carveout */
+    GFX_CTRL_CMD_ID_ENABLE_FB_CARVEOUT  = 0x00110000, /* Message runtime VBL to enable FB carveout */
 
-    GFX_CTRL_CMD_ID_MAX             = 0x000F0000,   /* max command ID */
+    GFX_CTRL_CMD_ID_MAX             = 0x003F0000,   /* max command ID */
 };
 
 typedef enum
-- 
2.43.0

