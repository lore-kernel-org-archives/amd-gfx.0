Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917A86083635
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Nov 2026 16:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=LRpNUmv/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0104C10E90E;
	Thu,  5 Nov 2026 16:02:48 +0000 (UTC)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012051.outbound.protection.outlook.com
 [40.93.195.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0202F10E7B4
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Nov 2026 16:02:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=laxRAKxq9/hWnqHVFAzY7SfI5/QLNdCXfn5xKKkuhl/Zj2CYA2oElK534D+BAR6cV+FMO8GXuyChs3BPwACSRQqC4xl2Dxq7oMzFSZeu+8zUl/UJH+9wJBGYrsEnBwMhW6Zu3C5IWo56AYBMIUCdAdzFXTxVVDCKsatLUtsv+RROkmYpx7jt6wYewa0DYzY4TwLPSc8JxDUfHerJ6hEHI924jFncgbbn26sxNzXUGi0Va8dUnS6zr9TzVe4GRZxyBNpb8gS0X0jPepwknw+OdRJiTJD1hzLROMzMFJPRm55DUMt6pjkalg5Wi8JOqlox0YpxOeXVaqcIN+MIqR5BOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SyX8KA3nDQyUrVs3KfkUhuQA5MtIsWYbPP5pe4tmBzA=;
 b=pCC4ItLRzpO8rU32oI4ChkGmW41u1uG2OR5HzFIq2PWHNkC11Xo1lUdjl2OwvSJ0kzuvaycDdK1vVDDtQIp9txw7os3IkUDGzcemqQdjuhG8GKKIPe04tYnaejPYYark3ppgBhv20ZjiOa70UMQSwazM3NHmffeaQOZ3vCnRQqrMlW1f1BSv0v7FBM1iWGUPQ8KZMZb/1364lMG36W5o7XEY19QX/Jdlc51kGyk9radgk83dQA40k1pLwltXs2OHEOydHstjB+fXELMmoBQ3jjPQk8EZAjgoCtYwPcS01c33JAtACEFWCplAHCrMZ7invzVtUoD5Qhj/u2Km2bdEBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SyX8KA3nDQyUrVs3KfkUhuQA5MtIsWYbPP5pe4tmBzA=;
 b=LRpNUmv/BBE0kXNNc9T7r8hk1h1I49q34lq9zgLM6eRVoqill+SSEKn+PAAmR0wx4C+NTxYyFk+82DUnXsYhdRbzPF+/3+6r0lJ1Eq2QOrx2VekeRgWxd7CM53UIsEhUTgoDyL5XENQpJ26ztrgUpWeNpCWwPcTI0VPnXOoDwAw=
Received: from DS7PR03CA0037.namprd03.prod.outlook.com (2603:10b6:5:3b5::12)
 by LV2PR12MB5751.namprd12.prod.outlook.com (2603:10b6:408:17d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Thu, 5 Nov 2026
 16:02:35 +0000
Received: from CH2PEPF00000147.namprd02.prod.outlook.com
 (2603:10b6:5:3b5:cafe::88) by DS7PR03CA0037.outlook.office365.com
 (2603:10b6:5:3b5::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Thu, 5
 Nov 2026 16:02:34 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH2PEPF00000147.mail.protection.outlook.com (10.167.244.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Thu, 5 Nov 2026 16:02:34 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 5 Nov
 2026 10:02:31 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 5 Nov
 2026 10:02:30 -0600
Received: from RSNDADJELK01.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via
 Frontend Transport; Thu, 5 Nov 2026 10:02:29 -0600
From: Dejan Andjelkovic <Dejan.Andjelkovic@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Lijo.Lazar@amd.com>, <Nikola.Prica@amd.com>, 
 Dejan Andjelkovic <Dejan.Andjelkovic@amd.com>
Subject: [PATCH v5 2/2] drm/amdgpu: add support for FB carveout disablement
Date: Thu, 5 Nov 2026 17:02:20 +0100
Message-ID: <20261105160220.881165-2-Dejan.Andjelkovic@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261105160220.881165-1-Dejan.Andjelkovic@amd.com>
References: <20261105160220.881165-1-Dejan.Andjelkovic@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000147:EE_|LV2PR12MB5751:EE_
X-MS-Office365-Filtering-Correlation-Id: 99b0a806-598d-462c-f99a-08df3b56345a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|23010399003|376014|1800799024|18002099003|22082099003|10067099003|3023799007|11063799006|261026140227099003|261028144727099003|261102123227099003|261022105027099003|261021121427099003|56012099006|261021123027099003|261009221227099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: y+p2yfJX5aaWbLys+x+ANVBgwQQHCWSlnAJ/Cba1lFqQi1nqrxQSE5p77p0bzDi5N04lSjAtK9HZAt9dACBcpGTR3gJ7eroMvPq8uvY5e3yGN6HIqFAzfdMzHSTTpFNQHTHjf7OGa+HUWQUYqDGIEZsAgHSCGJRioCd0TKMXwHTUD+2MTW3Ut7GB7O/qxgLQY3e7mjGH17PhysXUAqf6BKSqLVTZSX1mMcSAGIgDY3ehGGl75P0V3cOeZhSqgNIMS9NcNH8TLaTmwLDVpwC5HPkp2TJ7VaEAinkLNOZOODp3OX77IBYwYYJWJtqSM0mKn8L7bhdOO9huVf11B/UkbyTdN7BrE+XC8/mvWGARpUcE6GikofzTm2UmHnRI/GTy6AjsIiAnbuKfHi1ZmJrhm6R9ciCLSSfdv4RwDwbO7cQ72v/AOdViCT0eBYWIS7vbzH3zK+RI39Wdp2bDqDGGt9smqsYL4BD+af1dv8sp1eGJ7RNXOZUnnOsU9zrsYPsGqEoxirnPRfGhkQmcp3hty7sG/utOZTkl8AgCvS3BnbGXfjwT8kEcMyMjdTChrbFrt4kgSUffoebEzs3fABmJJD1eRg5dwqfrjenXqIpj2tThjTVBA5b5iDAoww+pyqDCyupyhGE9S62K/YpRcka/VLleY0KTtBwvnrNfqMNAFMvnFvV+pzUvxQb8aqn4wN7XLkEXt3Qpj/uEsnKqbz5wvA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(23010399003)(376014)(1800799024)(18002099003)(22082099003)(10067099003)(3023799007)(11063799006)(261026140227099003)(261028144727099003)(261102123227099003)(261022105027099003)(261021121427099003)(56012099006)(261021123027099003)(261009221227099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: NyaVxf9fvvmTlLmWlHp0YSRWGwHfmLBfuWM0eD5aW29SXUkR1Xa+6TCp95crJRheEhhLsno2t+oU3wbHL3smJLzqUahGa6icXBMHilO1yDmt/aQTm06SkCarqdY9zOwvi3gspbFhbM0KStSTRkdad7+aTC9EyJClM1BsyGxUI03kU8zIdmmuifIc5Wau1TSiWGRgAJ2e3X9n0DD+qD/wqTIgh763S3KTxa+2cXLj/1Ok49f5RA/S6gAeJCTxzh3+izAkUH8sPyANYpMbfTA9eWRfccwOrBrlAwc/KbD8t/eWypUnCjVlKhLVLm43udfa6vyicGHYhTH3ru091ZbOAKN7qlf0OVmPrm8B8qhpzTX+odVwXOQDqrmN6jUKZm6KktSXD1hVmOlCvGDZW8cwp6sedD+e6GTv0cutOJwbaXC0vUN2BzHuZXJfWjdlebh7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 16:02:34.1232 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99b0a806-598d-462c-f99a-08df3b56345a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000147.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5751
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
v4 -> v5:
- Wait for the carveout command with __psp_wait_for(), same as IP discovery, instead of amdgpu_psp_mbx_wait_resp().

 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  6 ++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c    | 24 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h    |  1 +
 drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h    | 10 +++++----
 4 files changed, 37 insertions(+), 4 deletions(-)

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
index 50f87bb424c7..a92c30c0b5c0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -3404,6 +3404,30 @@ int amdgpu_psp_read_discovery(struct amdgpu_device *adev, uint8_t *binary,
 	return ret;
 }
 
+int amdgpu_psp_disable_fb_carveout(struct amdgpu_device *adev)
+{
+	u32 resp;
+	int ret;
+
+	WREG32(mmMP0_SMN_C2PMSG_64_MMIO, GFX_CTRL_CMD_ID_DISABLE_FB_CARVEOUT);
+
+	ret = __psp_wait_for(adev, mmMP0_SMN_C2PMSG_64_MMIO,
+			     GFX_CMD_RESPONSE_MASK, GFX_CMD_RESPONSE_MASK,
+			     PSP_WAITREG_NOVERBOSE);
+	if (ret) {
+		dev_err(adev->dev, "disable_fb_carveout: PSP wait timed out\n");
+	} else {
+		resp = RREG32(mmMP0_SMN_C2PMSG_64_MMIO);
+		if (resp & GFX_CMD_STATUS_MASK) {
+			dev_err(adev->dev, "PSP mbx returned status 0x%04x\n",
+				resp & GFX_CMD_STATUS_MASK);
+			ret = -EIO;
+		}
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

