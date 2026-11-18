Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9AC606A333
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Nov 2026 15:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=XKwWvYOB
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 61B2610FDAA;
	Wed, 18 Nov 2026 15:16:11 +0000 (UTC)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011050.outbound.protection.outlook.com [52.101.52.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E81610FDA6
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Nov 2026 15:16:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oTc8yNF5Fef00ot5GKVhj1XM3ehLDY9rjVNN08ZAj8zSI/erDNmbXyEl5jqThXDMA+phxLY3b2uOupuFxpkK0HRg/JhRObfpZ3WYHJFUHN0iORWA9aUQzJw6XPtvjTvrc2qz3G3VtWwTSqrBIFtQoHBXfA9JhDonfHDehd1D5xiby9LZgE79PvGH+WpFYzj6FjYInlX/vHLv8O87IvlLfsR5CJqg0RqqKy/uZ/nnv+HxXE5jvyz2Qhab7lGTX95cfTb5CyzjwOSJcZCMcky4FM1kxF1rR97bTXmoYb33jQBxmHQmO6+JYVK9jfmyTM280ltElD3E2YDs4YsJAwtO8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LEAc7cEKOjLd1gu+HZfiTtvwR6cahV3vq5CKw7SzvZ4=;
 b=npIeuiCxJZ6BjEBB0MAqGrdfUcqz8qqGLnPy+4CLY6ST22tVsdat11lDaKDMeT4eqVRAJ7a1kjxaDsFKaPiWR0JZ9xwq6E7swmCSiK/BwAIvseKQqtlWljb9ww3IbZCYFK7DrF+rXDQfEJFVx7GNeUtr4NFjwSEiRAuE9GjbLdGehLLUpDZ4sxP30cgXF2VQEGL44+koadH73cDoCxCv4yjSqvAEeVNOAtSxNiiCTELWE1LyVHaPMdhxc7AZQgMFUMzKw80KlQwOht85acIGEptKkronLRrjYXploFgfgjSs7kOnOUumhcgvmec8lXZMkmnNWjM4j6PuNr9hdPmyXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LEAc7cEKOjLd1gu+HZfiTtvwR6cahV3vq5CKw7SzvZ4=;
 b=XKwWvYOB4HTBVPm5OFmiiXp4M0p7cn2aWXRAhXUz9PmaXZENzuUTmzMxhBftXUK72Qq6qGFHH5y3R3KXlxegnoEDVDo/E+Dyu0HVCHd1e4dY7MKsndDpnDh9KPgC8ygEncpxUEjZbG0taQzFZZmrpQY7lbeu0ErQzKr9e1++dzQ=
Received: from CH5P221CA0018.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1f2::13)
 by DSWPR12MB999151.namprd12.prod.outlook.com (2603:10b6:8:36b::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Wed, 18 Nov
 2026 15:16:00 +0000
Received: from MN1PEPF000793FD.namprd05.prod.outlook.com
 (2603:10b6:610:1f2:cafe::1) by CH5P221CA0018.outlook.office365.com
 (2603:10b6:610:1f2::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.14 via Frontend Transport; Wed,
 18 Nov 2026 15:16:00 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF000793FD.mail.protection.outlook.com (10.167.249.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 18 Nov 2026 15:16:00 +0000
Received: from SureshG-DevBox.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 18 Nov
 2026 09:15:58 -0600
From: Suresh Guttula <suresh.guttula@amd.com>
To: <Alexander.Deucher@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: <suresh.guttula@amd.com>
Subject: [PATCH v2] drm/amd/amdgpu: Enable IMU_I/DRAM FW_LOAD CMD
Date: Wed, 18 Nov 2026 20:45:44 +0530
Message-ID: <20261118151544.42346-1-suresh.guttula@amd.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF000793FD:EE_|DSWPR12MB999151:EE_
X-MS-Office365-Filtering-Correlation-Id: 0212379b-19f3-434f-7b7c-08df4586da91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|23010399003|18002099003|261009223027099003|11063799006|56012099006|10067099003|261102123227099003|261021123027099003|261022075727099003|261021121427099003;
X-Microsoft-Antispam-Message-Info: XRkUm4RAPkW5pdM17ozWqtwaaHXVBrTO/lGFVJuYhwPz96kVvtqiEhidz43RmW1lOIik2/f81kFcCnWFsz1nfLondTTsV7eBNpRMNUqMbhuT0qcN1MYDffgGMILVLAMzjDdQuZDhJGflv8GSREhBRiOT/VOie4y/TqQ6smTq0EscNBqjznvWU3vpmoZcpa+eNK1LiO3g2tNYFZtuqQwkd54JxOf2yDogXfnO5xfjReeOVoQm1xYRrmzbACtKP7BU04u/bRxVwUH8F5MkvvRl/cQrDDp79/O0okjxiESeMh91xj9WY/0CkLoDpbIA0jfP/N47vxMHHDa7Z8FEzagIJJDlL/DILK2/lqUFb3ldBWjv1b4y5uNHjf08FWnLO/a5mCHWObH8xepuKyIBayPWSMeE4tdczK8G0pUdlQLcjojqdIV7W2SK0JldM9VUsGvlLFl9+2ro2Z6lCzVcB/yUpVT0vJCQl31iXeXFFFpImC2y3BBU8Wj+KE91gN7RfWcvmeoPjQjM+QlnrhgXhLeUVdtknQ9HbvYvnPM/02REB7mDvKRBlcKpGPR2TTdm5YMcrdQo6e2VIo5t5BZv6n7cT9d/iYQ/euW/D7V0pY8R8aG2oY5euUmKpacJzKZu/YFUq0VI/G7A4m/egEcTiJRclfPyvLF6kFWJhhBNO+nYEPpoF61L2MPoP3pXjTc1IS7wl0biqsm1Y/u3ZOkawacUPg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(23010399003)(18002099003)(261009223027099003)(11063799006)(56012099006)(10067099003)(261102123227099003)(261021123027099003)(261022075727099003)(261021121427099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: DackisrsCtsA+JlqG9PCvx0iBJVlX69uuP7eQCzo1uvHdHbDR1Vp1owjrZKJqPoLUuKRO3E6lG0FfMzTNApM4VIGoyxJOcWiYw8iY7lfVTSTR6SPMWYKTP0y3RUrB/+iVPpJYeUKi7XcFkKWFT9uMdUTfXPUJ1xyKxPTSTZMu4qNVw4TwHrSVKl57veSrNjNro3GdacIyv280t0x7clXGUm9HUmLWZjLI7nAxOZx2LZ6YEy2HB9vVCsUScpdkaVS8aJzB7fKhboBe6rrZA7gy1iV5G0ca6DdFAf+OVSBXVH8KMWG6petd6P/PjPD8xHmRYfFTiPura66x3Py9HtjZDk1vLozQ6xoGcrY4GiVH5jyr7QPDcn8NzbmEUmZDxd2PtLrUhWocXSSO0yB/6JkVOiQgGllCZkcrl6gEaHeqeiLzwXKGtCl2filIz53Jszs
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2026 15:16:00.4361 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0212379b-19f3-434f-7b7c-08df4586da91
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF000793FD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR12MB999151
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

For GC 11, Eventhough IMU ucode load from BIOS/IFWI, PSP exepct Load
command from GFX to load IMU ucode.

v2:
Updated fw_load_skip_check specific to GC11

Signed-off-by: Suresh Guttula <suresh.guttula@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 10 ++++++++++
 drivers/gpu/drm/amd/amdgpu/imu_v11_0.c  | 14 +++++++++++++-
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 7a8cc043df5e..e50796f530a9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -4023,6 +4023,16 @@ static int psp_load_smu_fw(struct psp_context *psp)
 static bool fw_load_skip_check(struct psp_context *psp,
 			       struct amdgpu_firmware_info *ucode)
 {
+	struct amdgpu_device *adev = psp->adev;
+	/* Keep IMU firmware loading enabled for APUs with GC IP 11.0.0-11.7.1. */
+	if ((adev->flags & AMD_IS_APU) &&
+	    (amdgpu_ip_version(adev, GC_HWIP, 0) >= IP_VERSION(11, 0, 0)
+	    && amdgpu_ip_version(adev, GC_HWIP, 0) <= IP_VERSION(11, 7, 1))) {
+		if (!ucode->fw && (ucode->ucode_id == AMDGPU_UCODE_ID_IMU_I ||
+		    ucode->ucode_id == AMDGPU_UCODE_ID_IMU_D))
+			return false;
+	}
+
 	if (!ucode->fw || !ucode->ucode_size)
 		return true;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c b/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
index b6c4ae35ca03..3aef68c9891a 100644
--- a/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/imu_v11_0.c
@@ -31,6 +31,8 @@
 #include "gc/gc_11_0_0_offset.h"
 #include "gc/gc_11_0_0_sh_mask.h"
 
+#define IMU_DATA_SIZE_BYTES	66304
+
 MODULE_FIRMWARE("amdgpu/gc_11_0_0_imu.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_0_0_imu_kicker.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_0_1_imu.bin");
@@ -73,8 +75,18 @@ static int imu_v11_0_init_microcode(struct amdgpu_device *adev)
 	else
 		err = amdgpu_ucode_request(adev, &adev->gfx.imu_fw, required,
 					   "amdgpu/%s_imu.bin", ucode_prefix);
-	if (err == -ENODEV && imu_in_ifwi)
+	if (err == -ENODEV && imu_in_ifwi) {
+		info = &adev->firmware.ucode[AMDGPU_UCODE_ID_IMU_I];
+		info->ucode_id = AMDGPU_UCODE_ID_IMU_I;
+		info->fw = adev->gfx.imu_fw;
+		info->ucode_size = IMU_DATA_SIZE_BYTES;
+
+		info = &adev->firmware.ucode[AMDGPU_UCODE_ID_IMU_D];
+		info->ucode_id = AMDGPU_UCODE_ID_IMU_D;
+		info->fw = adev->gfx.imu_fw;
+		info->ucode_size = IMU_DATA_SIZE_BYTES;
 		return 0;
+	}
 	if (err)
 		goto out;
 
-- 
2.43.0

