Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A2DEC02192
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Feb 2025 11:45:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC1C310E788;
	Wed,  5 Feb 2025 11:45:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0Q6r+WD0";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2083.outbound.protection.outlook.com [40.107.244.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF1BD10E786
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Feb 2025 11:38:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RfXcdAfnJJ/glLJBMnAVk27OvnIG4GKWzqOLYd5hsQNudv7dfXhPvzLZibgX7ndRvX/2+KaYpj+jiMMwPcR+agdanLYLhay4OznrRtazqPGmJLQriGj/uc2G87GIEmCopxte94EIes/iu6Lq+eoIBA6foQPFDEwnPYS08Y/QJ6OriXolT1CQ1yZtzaghOterPiUUFZhgjbcVQAej1efB/8z0AqB5mxTwpbQSQnDunhHsM+if61h8hIfr6Hfk+VQViO3YUjEtlHAwyDhFD3p7RWswM6vbaiIaeTBY3L33stSxA9scnJmMn030VKPMTZyLNFivkRfhZcX3XpLmEkV0HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+UnQxRRhC2Dd7t6lq33Uloup2ITuzWk9ZbJw4q/cL+o=;
 b=gc8fQI+DTRORy7e2yjv159mvTBKs+eEvnZr07MrVBABsQjj9jRuZbPSU7DsP9MydtHzcXQKy+c4d0kVLozOCpnHL42dKF/T6KoOomdabCkvlPw0APHzWRcKPXHxYGdn79/cM374GOTBKVlb6XQe78Zpk2pYYhcD4Mnl2YRaWM7w9ZRD2tYpuJvUjzEpl2iDSsROZwAvPbSRs8GWNC09ouqNInzQ4NcdOn4QWIgt1JI7I2Sp8UOq/WxYgPu12fbhFC2lNGawA8qBYT/zrZkRJI1l2kJUu0yO2M1wUqlWa7CmdcRvqfq1djKgrNGQDog8S8SYA8KJer+FDTphNppT54A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+UnQxRRhC2Dd7t6lq33Uloup2ITuzWk9ZbJw4q/cL+o=;
 b=0Q6r+WD0r+glO1D4IuQqeJLbyAQR61BjqaN80+wvGG0eTWQvgp1nAXBKQLuHVtQsGGy76BtaEuF45lYDIa7FWoQDgyN0GoglB2g0RsDpJ17SxPDUn8E4qZe3ZQG/RzyWZmdlnp1GI+kNcunq3Ku+qljtr8Ls3FoFiNvoR2eAwHI=
Received: from BN9PR03CA0060.namprd03.prod.outlook.com (2603:10b6:408:fb::35)
 by DM4PR12MB7744.namprd12.prod.outlook.com (2603:10b6:8:100::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.26; Wed, 5 Feb
 2025 11:38:53 +0000
Received: from BL6PEPF0001AB4E.namprd04.prod.outlook.com
 (2603:10b6:408:fb:cafe::d8) by BN9PR03CA0060.outlook.office365.com
 (2603:10b6:408:fb::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.21 via Frontend Transport; Wed,
 5 Feb 2025 11:38:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4E.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Wed, 5 Feb 2025 11:38:52 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 5 Feb
 2025 05:38:50 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>
Subject: [PATCH 3/4] drm/amdgpu: Add flag to make VBIOS read optional
Date: Wed, 5 Feb 2025 17:08:31 +0530
Message-ID: <20250205113832.1903614-3-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250205113832.1903614-1-lijo.lazar@amd.com>
References: <20250205113832.1903614-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4E:EE_|DM4PR12MB7744:EE_
X-MS-Office365-Filtering-Correlation-Id: 82c1adee-a0ab-49ad-4740-08dd45d9aa6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GLr+XEsMH/Mejy1HZks9ywQtE+0dRzxW3uxCkAgP+uNzguNiccL+RE2M/CuT?=
 =?us-ascii?Q?fsXhuzABkvcOqbHg6ZLskeXqWnSO92HAyNqH+zPGxYN34LNu+oOL1SvcbIhO?=
 =?us-ascii?Q?Brai3nRwWl2+c9OO4Ll3w7gvrwvxe9GPmGCD9xeansqbq10t+2njrRwwmIsy?=
 =?us-ascii?Q?EsjysmLuIRdN0KBSfCM8ELFWuWBJg5quT4pBJUBGz5AaSaqJvbVKOqCBrpcK?=
 =?us-ascii?Q?AbUJ8QI9hcFVYyOfn6xw6fqvMp96PxCRQZZaJEMx2V4WPPTi5EtmPzJ0axPV?=
 =?us-ascii?Q?rN5gGm6mtr6yx7ew9uqmunLUyoh3uoQ5Cxw0DmHbMXVKeqs0kaEZKWruCSwH?=
 =?us-ascii?Q?gqEwMYwFxyPVD0ruBZEC35JU2NsvPIjvtWBMRrfcZ7/1OeyawIuKfUvEKDYM?=
 =?us-ascii?Q?axCKzt74t9JUunzQfAmoat/Un7nM0ZICwHLVsJiO42xNPA6YmP+jFo5F+rFq?=
 =?us-ascii?Q?sJnkJJvvFBfHikbLvshbQnzw8/ZuN80pv7+OalHCoVz4tAHKfuxZZQ2rDnLJ?=
 =?us-ascii?Q?Ng38TaDbgDdA61GXoKHd1NyQ5HkfRDgigB0KStRIr4pH5YxJIhdwaynGwGJc?=
 =?us-ascii?Q?f1+WqwGXJqnJOuRZnN1dSFaMkNzY85Z2NiY9sve4lhmQQ5wiDDMtY8UKPiH+?=
 =?us-ascii?Q?jHFyqlYz6fHsAFGxebfYIPlEDE/ZCcjIvYaTEs9Fk2z955nzxD1mfckxKP2w?=
 =?us-ascii?Q?+dp0kNZm0mmBHpN6q7G3fFQA6FVdhvfDtp9ScB6l0h/LmPX852Mle7hS4MFu?=
 =?us-ascii?Q?Hch48AGG3lkeqrmpCkgijDkF7V+r8t1TaJE5eM4GahmpbilyBrIwQFDHmhhB?=
 =?us-ascii?Q?45QK5/eaY5MExrwvh9UbFmYmwkiYsqQzQud3rtK6HS/E04vj6T779D4trwIR?=
 =?us-ascii?Q?cbdmIDW90e7+OLk9lfN1wiyKCzkKNpXUO2m9lmtpU0C0NwwzDe6xQSMZlTXY?=
 =?us-ascii?Q?YS+KCetocMOxDIzFRZ0RSaxeZq+o7hKJzedPdcrqpQgHcFY5KTFL8zvfNnzK?=
 =?us-ascii?Q?pqpCj3KoIzVVT9JCsEDGE3AiM6NjiL3z8htKzuXpTIuaHZXpkn5vXLyEI1BK?=
 =?us-ascii?Q?FxvjYYN1EKVLBel12+4uhqkiValM++PKZEXsbFrh/S3Qp/rrNdYtjdDMKZ83?=
 =?us-ascii?Q?4s5HnH3VrDuk3aB+RTyv6rO1fbB4K4pB8AqVG1oO4K+rtmFlruNKD20zuc0J?=
 =?us-ascii?Q?mwfvlBamjHpa6nFzX7VvfyV01pMjmsAIXX2k1YFIlfm8c6VTcZlXmfr6Yhnn?=
 =?us-ascii?Q?2jbNmNq3J5yPqW2Vb4aAN1PyzvQ8sNJr1dkI06h49AJMbYE4Dg4nlzXJZ02W?=
 =?us-ascii?Q?90ZWrwFPue8Clb3ROCa+dqB2gL73xHMXdxw6PrMuRqlrJ3Ii0sI+q0HEUpXq?=
 =?us-ascii?Q?6U30DSV4DdQFpCurczQW4N0BUyl1YAxJWky0T2la3bSWyziD2ZGpszaEJyt4?=
 =?us-ascii?Q?PzO/jH8U4Kis4zIC8Mf0P6BlPo4hJxu+BGwsb0UcXfe6IIxA0jiFwRq0O8kf?=
 =?us-ascii?Q?nQyFW429GOhsJEg=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 11:38:52.5427 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82c1adee-a0ab-49ad-4740-08dd45d9aa6e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7744
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

Certain SOCs may not need much data from VBIOS. Some data like VBIOS
version used will be missed but it doesn't affect functionality. Add a
flag to make VBIOS image optional.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 70 +++++++++++++------
 .../gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c    | 16 ++---
 .../gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c    |  2 +-
 3 files changed, 59 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 0a3641a2bede..ddccdceb1d2f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -103,6 +103,7 @@ MODULE_FIRMWARE("amdgpu/navi12_gpu_info.bin");
 #define AMDGPU_PCIE_DATA_FALLBACK (0x3C >> 2)
 
 #define AMDGPU_VBIOS_SKIP (1U << 0)
+#define AMDGPU_VBIOS_OPTIONAL (1U << 1)
 
 static const struct drm_driver amdgpu_kms_driver;
 
@@ -1391,6 +1392,14 @@ static void amdgpu_block_invalid_wreg(struct amdgpu_device *adev,
 	BUG();
 }
 
+static uint32_t amdgpu_device_get_vbios_flags(struct amdgpu_device *adev)
+{
+	if (hweight32(adev->aid_mask) && (adev->flags & AMD_IS_APU))
+		return AMDGPU_VBIOS_SKIP;
+
+	return 0;
+}
+
 /**
  * amdgpu_device_asic_init - Wrapper for atom asic_init
  *
@@ -1400,18 +1409,28 @@ static void amdgpu_block_invalid_wreg(struct amdgpu_device *adev,
  */
 static int amdgpu_device_asic_init(struct amdgpu_device *adev)
 {
+	uint32_t flags;
+	bool optional;
 	int ret;
 
 	amdgpu_asic_pre_asic_init(adev);
+	flags = amdgpu_device_get_vbios_flags(adev);
+	optional = !!(flags & (AMDGPU_VBIOS_OPTIONAL | AMDGPU_VBIOS_SKIP));
 
 	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3) ||
 	    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 4) ||
 	    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 5, 0) ||
 	    amdgpu_ip_version(adev, GC_HWIP, 0) >= IP_VERSION(11, 0, 0)) {
 		amdgpu_psp_wait_for_bootloader(adev);
+		if (optional && !adev->bios)
+			return 0;
+
 		ret = amdgpu_atomfirmware_asic_init(adev, true);
 		return ret;
 	} else {
+		if (optional && !adev->bios)
+			return 0;
+
 		return amdgpu_atom_asic_init(adev->mode_info.atom_context);
 	}
 
@@ -1700,14 +1719,6 @@ int amdgpu_device_resize_fb_bar(struct amdgpu_device *adev)
 	return 0;
 }
 
-static uint32_t amdgpu_device_get_vbios_flags(struct amdgpu_device *adev)
-{
-	if (hweight32(adev->aid_mask) && (adev->flags & AMD_IS_APU))
-		return AMDGPU_VBIOS_SKIP;
-
-	return 0;
-}
-
 /*
  * GPU helpers function.
  */
@@ -1730,6 +1741,8 @@ bool amdgpu_device_need_post(struct amdgpu_device *adev)
 	flags = amdgpu_device_get_vbios_flags(adev);
 	if (flags & AMDGPU_VBIOS_SKIP)
 		return false;
+	if ((flags & AMDGPU_VBIOS_OPTIONAL) && !adev->bios)
+		return false;
 
 	if (amdgpu_passthrough(adev)) {
 		/* for FIJI: In whole GPU pass-through virtualization case, after VM reboot
@@ -2700,14 +2713,27 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
 			skip_bios = !!(bios_flags & AMDGPU_VBIOS_SKIP);
 			/* Read BIOS */
 			if (!skip_bios) {
-				if (!amdgpu_get_bios(adev))
+				bool optional =
+					!!(bios_flags & AMDGPU_VBIOS_OPTIONAL);
+				if (!amdgpu_get_bios(adev) && !optional)
 					return -EINVAL;
 
-				r = amdgpu_atombios_init(adev);
-				if (r) {
-					dev_err(adev->dev, "amdgpu_atombios_init failed\n");
-					amdgpu_vf_error_put(adev, AMDGIM_ERROR_VF_ATOMBIOS_INIT_FAIL, 0, 0);
-					return r;
+				if (optional && !adev->bios)
+					dev_info(
+						adev->dev,
+						"VBIOS image optional, proceeding without VBIOS image");
+
+				if (adev->bios) {
+					r = amdgpu_atombios_init(adev);
+					if (r) {
+						dev_err(adev->dev,
+							"amdgpu_atombios_init failed\n");
+						amdgpu_vf_error_put(
+							adev,
+							AMDGIM_ERROR_VF_ATOMBIOS_INIT_FAIL,
+							0, 0);
+						return r;
+					}
 				}
 			}
 
@@ -4744,11 +4770,13 @@ void amdgpu_device_fini_sw(struct amdgpu_device *adev)
 	/* free i2c buses */
 	amdgpu_i2c_fini(adev);
 
-	if (amdgpu_emu_mode != 1)
-		amdgpu_atombios_fini(adev);
+	if (adev->bios) {
+		if (amdgpu_emu_mode != 1)
+			amdgpu_atombios_fini(adev);
 
-	kfree(adev->bios);
-	adev->bios = NULL;
+		kfree(adev->bios);
+		adev->bios = NULL;
+	}
 
 	kfree(adev->fru_info);
 	adev->fru_info = NULL;
@@ -5371,7 +5399,8 @@ int amdgpu_device_mode1_reset(struct amdgpu_device *adev)
 	u32 i;
 	int ret = 0;
 
-	amdgpu_atombios_scratch_regs_engine_hung(adev, true);
+	if (adev->bios)
+		amdgpu_atombios_scratch_regs_engine_hung(adev, true);
 
 	dev_info(adev->dev, "GPU mode1 reset\n");
 
@@ -5413,7 +5442,8 @@ int amdgpu_device_mode1_reset(struct amdgpu_device *adev)
 		goto mode1_reset_failed;
 	}
 
-	amdgpu_atombios_scratch_regs_engine_hung(adev, false);
+	if (adev->bios)
+		amdgpu_atombios_scratch_regs_engine_hung(adev, false);
 
 	return 0;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
index 09c9194d5bd5..89109eb2ce16 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fru_eeprom.c
@@ -63,10 +63,10 @@ static bool is_fru_eeprom_supported(struct amdgpu_device *adev, u32 *fru_addr)
 		switch (adev->asic_type) {
 		case CHIP_VEGA20:
 			/* D161 and D163 are the VG20 server SKUs */
-			if (strnstr(atom_ctx->vbios_pn, "D161",
-				    sizeof(atom_ctx->vbios_pn)) ||
-			    strnstr(atom_ctx->vbios_pn, "D163",
-				    sizeof(atom_ctx->vbios_pn))) {
+			if (atom_ctx && (strnstr(atom_ctx->vbios_pn, "D161",
+						 sizeof(atom_ctx->vbios_pn)) ||
+					 strnstr(atom_ctx->vbios_pn, "D163",
+						 sizeof(atom_ctx->vbios_pn)))) {
 				if (fru_addr)
 					*fru_addr = FRU_EEPROM_MADDR_6;
 				return true;
@@ -78,8 +78,8 @@ static bool is_fru_eeprom_supported(struct amdgpu_device *adev, u32 *fru_addr)
 			return false;
 		}
 	case IP_VERSION(11, 0, 7):
-		if (strnstr(atom_ctx->vbios_pn, "D603",
-			    sizeof(atom_ctx->vbios_pn))) {
+		if (atom_ctx && strnstr(atom_ctx->vbios_pn, "D603",
+					sizeof(atom_ctx->vbios_pn))) {
 			if (strnstr(atom_ctx->vbios_pn, "D603GLXE",
 				    sizeof(atom_ctx->vbios_pn))) {
 				return false;
@@ -94,8 +94,8 @@ static bool is_fru_eeprom_supported(struct amdgpu_device *adev, u32 *fru_addr)
 		}
 	case IP_VERSION(13, 0, 2):
 		/* All Aldebaran SKUs have an FRU */
-		if (!strnstr(atom_ctx->vbios_pn, "D673",
-			     sizeof(atom_ctx->vbios_pn)))
+		if (atom_ctx && !strnstr(atom_ctx->vbios_pn, "D673",
+					 sizeof(atom_ctx->vbios_pn)))
 			if (fru_addr)
 				*fru_addr = FRU_EEPROM_MADDR_6;
 		return true;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index 723c655bb4d5..83b54efcaa87 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -177,7 +177,7 @@ static bool __get_eeprom_i2c_addr(struct amdgpu_device *adev,
 	if (!control)
 		return false;
 
-	if (amdgpu_atomfirmware_ras_rom_addr(adev, &i2c_addr)) {
+	if (adev->bios && amdgpu_atomfirmware_ras_rom_addr(adev, &i2c_addr)) {
 		/* The address given by VBIOS is an 8-bit, wire-format
 		 * address, i.e. the most significant byte.
 		 *
-- 
2.25.1

