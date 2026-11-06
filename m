Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17522606A33D
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Nov 2026 11:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=S50HYl4P
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA10F10E49E;
	Fri,  6 Nov 2026 11:31:01 +0000 (UTC)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011067.outbound.protection.outlook.com [52.101.62.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF2A210E49E
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Nov 2026 11:30:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DWyiNkvVDXxN88sW+Sfw7mtl/O7WzjKFXQiSvuYub//vv2hxfw22mUAvxdF92b6783ZxqUGyMGi2DSPC+WZ7RCqll8bJoiyR8llZximxDOiYAF6s7lv5xoIbos3ouKnDq8iCRbkkiS0BVFYq3QrgDdD1WQJ3bE47CVdSLSkKKST+aHJwrW1DHnu7Fm+aphpCZU5V2TewKxy+pwmd5ixv9xiGX68hos6MesnO6PtpWnqAySSNNIB4ZGnBpWzwCvSWBOeEt76MRs1lUWrRkozCCI3VpKSeJ3KtKHPAnmB2luJIFvdtVbT/SkFHVdSkV/1crdNn1VPs72iRmgBS6cEx8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QQZmEMDI6+B2U9wdEzmalK9iS+0eW0ioIQma4uDhtf8=;
 b=ulx4zl4SEkgJQi4kzlZ1JEYFlVAkzeLHsKe78t6wTL5PlEjwKSMYS35WfFi1eppL6apA+4gMDhsesDXOYlQvgWer86fd4CB7sibSQZeGouYMZBTqAEIRIUjoWplqFQVZlqH2LRTQMA04jxZfoCQU0CAdxBi8QNQRMclOOTzKF1UdRrFf/7XuAjFd3QbcRuKu/0amM6aep8beDAMYZTim8mtUWhOAjF1JiSPDeOsJ3aKrFr3KG2Isc+2sVk+B9zL8eb4g4EessJkjv5SOB85eluhPculxq/mT/5IJCLYhuNchG9WDWu6fh5WB+wUuBHObxL1R4gKoM7JoelGtohsLlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QQZmEMDI6+B2U9wdEzmalK9iS+0eW0ioIQma4uDhtf8=;
 b=S50HYl4PFbDslNUtAUjlfRCErc5mY0iJ/AIdq+xex6JaGGEJnsI3FINOGeLYGzb7vujcZ79OVH3UFIRzBI5pGc6M/nnTvz509ApLcp6noLJdszb1fPvqec927VNnNs3j8GFDo7egAdu6Esiw1Xjsws4l8mFbW2QtI04oiXZXUb4=
Received: from MW4PR03CA0327.namprd03.prod.outlook.com (2603:10b6:303:dd::32)
 by CH3PR12MB8281.namprd12.prod.outlook.com (2603:10b6:610:128::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Fri, 6 Nov
 2026 11:30:02 +0000
Received: from SJ1PEPF000037AB.namprd03.prod.outlook.com
 (2603:10b6:303:dd:cafe::2d) by MW4PR03CA0327.outlook.office365.com
 (2603:10b6:303:dd::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.8 via Frontend Transport; Fri, 6
 Nov 2026 11:30:02 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF000037AB.mail.protection.outlook.com (10.167.244.185) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 11:30:01 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 6 Nov
 2026 05:30:01 -0600
Received: from RSNDADJELK01.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via
 Frontend Transport; Fri, 6 Nov 2026 05:29:59 -0600
From: Dejan Andjelkovic <Dejan.Andjelkovic@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Lijo.Lazar@amd.com>, <Nikola.Prica@amd.com>, 
 Dejan Andjelkovic <Dejan.Andjelkovic@amd.com>
Subject: [PATCH v6 2/2] drm/amdgpu: add support for FB carveout disablement
Date: Fri, 6 Nov 2026 12:29:50 +0100
Message-ID: <20261106112950.1281549-2-Dejan.Andjelkovic@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261106112950.1281549-1-Dejan.Andjelkovic@amd.com>
References: <20261106112950.1281549-1-Dejan.Andjelkovic@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037AB:EE_|CH3PR12MB8281:EE_
X-MS-Office365-Filtering-Correlation-Id: 605074a3-919a-4877-6f6b-08df3bf94c08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|23010399003|1800799024|18002099003|22082099003|10067099003|3023799007|11063799006|261102123227099003|261026140227099003|261028144727099003|261021121427099003|261022105027099003|261021123027099003|56012099006|261009221227099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: EJGxJ9BQOMW3zvyYN05BouNQsqKHXxKW2NOA6vGs1zG3wQn97XIxESrSOs/e3ymIdjF3CRu7yXSoNCc4vgoVs3cZJMMw7FVX3Z5/tH8yHCccpkdi7qyQrOad+X265V7uWZcTpW7U8KrqBhfo5xClk3RO3mvjZ8/PZs7tTrF6wSOc3foTLkLI8FsPX2lCIrqMdpl9bjXHQpsNiL28wRUshQ6BOvn9q/5RB4kdZoxY9Q+fiT8dxm17Idai7aQaYk+1jk3EYQOVOyKP3ZD7vuI0W/r5mK4uma/z1X5bITm8zNluheT4ekXOf8n3HJbMf8EjesiUuUOkbF90wiooAWjq5CZksIPjXwu/66RBFJZeETaF0NmVWtfS7y1qmEEia3J72DDxPb2s0ixACUVonheEQVZss24Lr4Jt85+5k+86qfs5f1VjAXYfvD6SFGbP4LyDvt0SOrv/w6JAvwENZw0bijlaDSrbgqvHj79XmDI8v6EIOzRdNfCpus7roZaj/1Ip7LTOhJrPg9Y7Ls/zStQgMY/m+jF1k5JrTNuibeh8WOd7YKPRHD8cmSMa1LpR7AqrvhbHJ/CAVBat2nVQLislxVHQ3lO5SU2F9wy/GEzpnSFm5UQCAZFs2YDFTRYwk++3TexDy3h/LWNwH2I8D2F8MLtEZI/Mcj1DjgJ5AYaHaqpct8ZkUcp7dLUq5DxUz4q7J/W3k4z7USB+8mFey4gOlw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(23010399003)(1800799024)(18002099003)(22082099003)(10067099003)(3023799007)(11063799006)(261102123227099003)(261026140227099003)(261028144727099003)(261021121427099003)(261022105027099003)(261021123027099003)(56012099006)(261009221227099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: RQupHdYypcFjGpeGff+ZSw5owuTlnrk5eU+RkN7l6F2CCtk3xu04lJOAsf8xM58OOT7urb6Ks1Ls+r5+xgYSll+jnoJsAD7mnHFrbHisvAiQcbPBc0no44ZYB8fMLK4dC9JFqdC+ZwVzApTnoWMT3TNI8OgZS1JbqUWnrpyXopZM/5AtTV0AWadr7sXFjDcoGBgVxT0DGylkecyMXJT2lPNW6EZGwroWbmqBiMLRwwha3mHnWJNc2WSaHsB9tJEjqLQlnyR824V+3oyGutrSElQj4UT5grH7lhMaWuMjUki9IBv3ldjmlje8fz9HWgZ+hAs+bQDAfvg8yubU1k7XspI50Y0PjrDkQ0v/oR4f95EljN5ycFwuv0cmVb06OTRt7OolgcSnu/kJNV9qO75dw659H1QrL8fhKKrBA60mklDswJSTCozAXlK2LIDZU1L4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 11:30:01.7748 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 605074a3-919a-4877-6f6b-08df3bf94c08
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000037AB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8281
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
v5 -> v6:
- Drop the post-wait status read in amdgpu_psp_disable_fb_carveout().

 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  6 ++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c    | 16 ++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.h    |  1 +
 drivers/gpu/drm/amd/amdgpu/psp_gfx_if.h    | 10 ++++++----
 4 files changed, 29 insertions(+), 4 deletions(-)

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
index 50861175d661..bbf4264dd3c9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -3396,6 +3396,22 @@ int amdgpu_psp_read_discovery(struct amdgpu_device *adev, uint8_t *binary,
 	return ret;
 }
 
+int amdgpu_psp_disable_fb_carveout(struct amdgpu_device *adev)
+{
+	int ret;
+
+	WREG32(mmMP0_SMN_C2PMSG_64_MMIO, GFX_CTRL_CMD_ID_DISABLE_FB_CARVEOUT);
+
+	ret = __psp_wait_for(adev, mmMP0_SMN_C2PMSG_64_MMIO,
+			     MBOX_TOS_RESP_FLAG, MBOX_TOS_RESP_MASK,
+			     PSP_WAITREG_NOVERBOSE);
+	if (ret) {
+		dev_err(adev->dev, "disable_fb_carveout: PSP cmd failed\n");
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

