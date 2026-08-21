Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E323C5DF8C
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 19:52:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1538D10F43B;
	Fri, 21 Aug 2026 19:52:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CgWuu9XE";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010024.outbound.protection.outlook.com [52.101.201.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B71EE10F43B
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 19:52:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Te9IA+Z6ldwKscgEog1rDJuLpij34O1IdDCgPA+mjJig3AEfasAbvwymi7poJ3yWxLr/1av9tNP09+r7Tf3Oao5NL3UKQSiivD9QzTl7V2fAZZG5Ivqyu2dPBNKX4INtFntpLKqX/C2gqGsZ2M4zmv7/H6/LVKChWmdyC6+fpsUpKE9+8G0xHkxz7Wvuh+yqxgSsiJu1nTGJa1usRuDVslWRD+5D73Ycm5H7Kj2WFYsUw6h8guBNq6rjtHYLmNoJi1hO4siybK2phJW06i4k3T4jTVo/zyX26k1alTBWSd5QfyJ+6gycXLJIsPE+6sheik6ssWfBQSLoITnORgSRYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NaZ9VBlU0risd8oEvi2Q3ZV3HnhAPj1IVI2OvuRQ3hs=;
 b=KPsl6noMKdJojuRhuLxEgF5hlI1dVFxtc+t30uUEVbq+eT3VhdWqWrqN/o71tZcd6gZKFq4xKcs27230qbvSr35bssRb2ZOaClgvduC79Xk70AYm+JdcrHz8sXgJxT7gWBtu2pmLyY5tLkyg6+YVayUoaSsizW9+m5E7WO6Xom0aG2QHE6Rj05B273XcR4qHv7AVuO9aoNsYLSWUnrz6YTn2eI69zM8JZzHeA18mkNCFCLThmCR6ArBtWlY8zcfWwgyhC6PVEMLKJF1SjrYsKCzOyZH8vq5xWK2wWlgLa7tcoDx3HXqNCRjOTxYN/2OfHV7uU2oqIhrNor9ROzAq0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NaZ9VBlU0risd8oEvi2Q3ZV3HnhAPj1IVI2OvuRQ3hs=;
 b=CgWuu9XE4sDWAVxAQwSNvCzmQZv6DCH0VhgGhREsuf4LjllVENuxREzcweokPBgKakuspRgQTeSONFQTaJYcyGlYaWNZHU2NG0B5a2zuwFcnAsRbFLbqO2ZKiXnwzqDet1ZC+BbHXz6+rgeFvoqRj16J+wSeL4somlkja3gjwzs=
Received: from CH5PR02CA0020.namprd02.prod.outlook.com (2603:10b6:610:1ed::25)
 by MN2PR12MB4405.namprd12.prod.outlook.com (2603:10b6:208:26d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.16; Fri, 21 Aug
 2026 19:36:05 +0000
Received: from CH1PEPF0000AD7C.namprd04.prod.outlook.com
 (2603:10b6:610:1ed:cafe::51) by CH5PR02CA0020.outlook.office365.com
 (2603:10b6:610:1ed::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 19:36:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD7C.mail.protection.outlook.com (10.167.244.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 19:36:04 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:36:00 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:35:58 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 14:35:58 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Lijo Lazar <lijo.lazar@amd.com>, Felix Kuehling <felix.kuehling@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 77/95] drm/admgpu: Seggregate ualink nht messaging
Date: Fri, 21 Aug 2026 15:34:40 -0400
Message-ID: <20260821193458.808626-78-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821193458.808626-1-alexander.deucher@amd.com>
References: <20260821193458.808626-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7C:EE_|MN2PR12MB4405:EE_
X-MS-Office365-Filtering-Correlation-Id: 435e905f-53e5-4c04-f4d9-08deffbb707f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|23010399003|376014|82310400026|10067099003|56012099006|22082099003|18002099003|11063799006|3023799007;
X-Microsoft-Antispam-Message-Info: 6m47nSeftiL7ZIR9A4Ft764SyMYx6JWmtBVK/Gsp5lFixwl+deaPaT2cFSF6NDdOVVBahq9jSstLKJltMbh/aJefuuHo4bCVn6uUJbMihJgr9llJoVTHxIByujpxTOlkW4dLMw58MucC0ccmDJ82wYEWgUa0eqjoMBg5BBM2s/PpzLuzOg8inLJDpvnnssGpkzvOw8MS7l673GuwLyHS3ILUoSlhC7tuezPADEotvfbwbl8qQRFxzOT8OYTBoTUeRf5DVpqC4/+crwlpTiPM0EbqAuCNWVsJ6bitZWDd4ct0rzi89yNSIL+QnnGqw9Ph/UjpK7r+6TMXQ+kBnUYoBtQbsorRxQDoZr2MV4S9jlAKekt27AwSSyc5cKsT1eJPwlb1ZWSICM8Y+eGZz4Q9/KDlXGQNXJh80XxmMFzr3ZPXiDNTiIzNIfbn9TDpC6cnauhYHLkpmy3xi9m8YL1QFLv0DRDAJeAzA0nRqSxvc3ZgeNZ9M/955CqXM0Ey9vx/rxQuD5v852Vvahp1RyS11XLv2nh4Yx6mEoxhaTWiZH8ioYfOph6ONK9/fYTogUSDpGsd7kpxZPQBoofR5uie5bP4FwkJqbRRhcSIFyA3G5Vk6LYpxhsJlRX0Mo8TOwtjKXmD4c/mB7qKyhsihof20V4sxuPt+UVQJpcmMswHNB4ntsk/61qzpE1EMW/9ihrpSVKqOwNALiUyeSjkO+bHuA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(23010399003)(376014)(82310400026)(10067099003)(56012099006)(22082099003)(18002099003)(11063799006)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: kaPB5tdChQhNQRg6rAZ1p33Q9i/EBfetnwVXJY4opTsiNVdcujtZ8Xq6e5g2Di/jYW+93k0aj46ydUeu6a9fsWVBFxN5RwE1XamV6Cco8sSGEhvSMf3vN0TkpAW9lo8sSsUorCR/MAOLuWPGfM+ku4laueExlxRDACa6azFf4ItIxzwxb8pZTop81GUZwMWkZM/am7TfCPt/QN7+ooU61+oQ7lz/OE/tdQfrkPpT28JhYPb0Mple9OC/sFKcsdGC8DKk+e+r/Z5CFTWWvNFiT7W/e2jlW1pCSfUBPpw+zprbTAi8M+ggQbKBRoujRmeyAolqyGghmmOrSnJNFkkvp/uf3M6IoF5AfA6D/kW0b67SzZDcPkbt46Ev0phZTfhOUWmxfmLqYiQV9yEcgndkzNdBRpAgGhaHVbCpKcqXApQRJ30M/7i2oLdTQgBYgDO+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 19:36:04.4053 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 435e905f-53e5-4c04-f4d9-08deffbb707f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4405
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

From: Lijo Lazar <lijo.lazar@amd.com>

Message handshake with NHT firmware is IP specific. Separate that into
IP specific file. Move ip block v1.0 definition also the version
specific file.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile        |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 112 ++-----------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h |  20 ++++
 drivers/gpu/drm/amd/amdgpu/ualink_v1_0.c   | 122 +++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/ualink_v1_0.h   |  30 +++++
 5 files changed, 185 insertions(+), 101 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/ualink_v1_0.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/ualink_v1_0.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index bb33119608a06..7b08814a24da4 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -279,7 +279,7 @@ amdgpu-y += amdgpu_amdkfd.o
 amdgpu-y += amdgpu_userq.o
 
 # add UALink manager support
-amdgpu-y += amdgpu_ualink.o
+amdgpu-y += amdgpu_ualink.o ualink_v1_0.o
 
 ifneq ($(CONFIG_HSA_AMD),)
 AMDKFD_PATH := ../amdkfd
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index afcb5ef84bd48..d376c3136af8a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -95,7 +95,7 @@ static void amdgpu_ualink_object_fini(struct amdgpu_device *adev)
 	adev->ualink.info = NULL;
 }
 
-static int ualink_ip_hw_init(struct amdgpu_ip_block *ip_block)
+int ualink_ip_hw_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
 	int r;
@@ -132,7 +132,7 @@ static int ualink_ip_hw_init(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
-static int ualink_ip_late_init(struct amdgpu_ip_block *ip_block)
+int ualink_ip_late_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
 	int r;
@@ -1021,7 +1021,7 @@ static const struct kobj_type ualink_station_config_ktype = {
 	.sysfs_ops = &kobj_sysfs_ops
 };
 
-static int ualink_ip_sw_init(struct amdgpu_ip_block *ip_block)
+int ualink_ip_sw_init(struct amdgpu_ip_block *ip_block)
 {
 	int r;
 
@@ -1073,7 +1073,7 @@ static int ualink_ip_sw_init(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
-static int ualink_ip_sw_fini(struct amdgpu_ip_block *ip_block)
+int ualink_ip_sw_fini(struct amdgpu_ip_block *ip_block)
 {
 	amdgpu_ualink_object_fini(ip_block->adev);
 	return 0;
@@ -3474,29 +3474,6 @@ void amdgpu_ualink_manager_stop(struct amdgpu_device *adev)
 
 #define AMDGPU_UALINK_METADATA_HEADER	0x4E485446
 
-/* UALINK F/W commands */
-#define AMDGPU_UALINK_FW_CMD_LOAD_METADATA	0x1
-#define AMDGPU_UALINK_FW_CMD_HALT_OPERATION	0x2
-
-/* UALINK F/W status */
-#define AMDGPU_UALINK_FW_STATUS_PREINIT	0xA0
-#define AMDGPU_UALINK_FW_STATUS_READY	0xA1
-#define AMDGPU_UALINK_FW_STATUS_HALT	0xA2
-#define AMDGPU_UALINK_FW_STATUS_ERROR	0xA3
-#define AMDGPU_UALINK_FW_STATUS_FATAL	0xF0
-
-/* UALINK mailbox registers via SMN, copy of MP1 */
-/* send command to nht f/w */
-#define mmMPNHT_SMN_C2PMSG_22_ALT_2	0xAE10958
-/* additional data */
-#define mmMPNHT_SMN_C2PMSG_23_ALT_2	0xAE1095C
-/* metadata address low */
-#define mmMPNHT_SMN_C2PMSG_24_ALT_2	0xAE10960
-/* metadata address high */
-#define mmMPNHT_SMN_C2PMSG_25_ALT_2	0xAE10964
-/* f/w status */
-#define mmMPNHT_SMN_C2PMSG_26_ALT_2	0xAE10968
-
 /* 2MB NPA start address for 2MB page mapping */
 #define AMDGPU_UALINK_SOURCE_ALIAS_NPA_OFFSET SZ_2M
 
@@ -3725,25 +3702,6 @@ static void amdgpu_ualink_flush_tlb(struct amdgpu_device *adev, u32 flush_type)
 					bit, flush_type);
 }
 
-static inline u32 amdgpu_ualink_mailbox_read(struct amdgpu_device *adev,
-					     u32 mailbox_reg)
-{
-	u32 value;
-
-	value = RREG32_PCIE(mailbox_reg);
-	dev_dbg_ratelimited(adev->dev, "ualink read mailbox 0x%x return value 0x%x\n",
-			    mailbox_reg, value);
-	return value;
-}
-
-static inline void amdgpu_ualink_mailbox_write(struct amdgpu_device *adev,
-					       u32 mailbox_reg, u32 value)
-{
-	dev_dbg(adev->dev, "ualink write mailbox 0x%x value 0x%x\n",
-		mailbox_reg, value);
-	WREG32_PCIE(mailbox_reg, value);
-}
-
 /**
  * amdgpu_ualink_npa_vm_map_range - Map a range in the NPA VM
  * @adev: amdgpu device pointer
@@ -4418,7 +4376,7 @@ static int amdgpu_ualink_metadata_init(struct amdgpu_device *adev)
 	u32 size, rb_size, wptr_size, rptr_size, metadata_size;
 	u64 rb_gpu_addr, wptr_gpu_addr;
 	u32 status, accel_id;
-	int i, r;
+	int r;
 
 	remote->active_accel_bits = adev->ualink.info->vpod.active_accel_bits;
 	dev_dbg(adev->dev, "%d active accelerators config in vpod\n",
@@ -4430,9 +4388,9 @@ static int amdgpu_ualink_metadata_init(struct amdgpu_device *adev)
 	 */
 	remote->num_accel = AMDGPU_UALINK_ACCEL_MAX;
 
-	status = amdgpu_ualink_mailbox_read(adev, mmMPNHT_SMN_C2PMSG_26_ALT_2);
-	if (status != AMDGPU_UALINK_FW_STATUS_PREINIT &&
-	    status != AMDGPU_UALINK_FW_STATUS_HALT) {
+	status = adev->ualink.msg_ctl->check_status(adev);
+	if (status != AMDGPU_NHT_FW_ST_PREINIT &&
+	    status != AMDGPU_NHT_FW_ST_HALT) {
 		dev_dbg(adev->dev, "fw status 0x%x not preinit or halt\n", status);
 		return -ENODEV;
 	}
@@ -4549,25 +4507,9 @@ static int amdgpu_ualink_metadata_init(struct amdgpu_device *adev)
 			metadata[accel_id].tailptr_ri, metadata[accel_id].tailptr_tlb_inv);
 	}
 
-	amdgpu_ualink_mailbox_write(adev, mmMPNHT_SMN_C2PMSG_25_ALT_2,
-				    upper_32_bits(remote->metadata_gpu_addr));
-	amdgpu_ualink_mailbox_write(adev, mmMPNHT_SMN_C2PMSG_24_ALT_2,
-				    lower_32_bits(remote->metadata_gpu_addr));
-	amdgpu_ualink_mailbox_write(adev, mmMPNHT_SMN_C2PMSG_23_ALT_2,
-				    AMDGPU_UALINK_ACCEL_MAX << 8);
-	amdgpu_ualink_mailbox_write(adev, mmMPNHT_SMN_C2PMSG_22_ALT_2,
-				    AMDGPU_UALINK_FW_CMD_LOAD_METADATA);
-
-	for (i = 0; i < 2000; i++) {
-		status = amdgpu_ualink_mailbox_read(adev, mmMPNHT_SMN_C2PMSG_26_ALT_2);
-		if (status == AMDGPU_UALINK_FW_STATUS_READY)
-			break;
-		mdelay(1);
-	}
-	if (status != AMDGPU_UALINK_FW_STATUS_READY) {
-		dev_dbg(adev->dev, "f/w load metadata failed 0x%x\n", status);
-		r = -ETIME;
-	}
+	r = adev->ualink.msg_ctl->send_metadata(adev,
+						    remote->metadata_gpu_addr,
+						    AMDGPU_UALINK_ACCEL_MAX << 8);
 
 out:
 	if (r)
@@ -5315,23 +5257,10 @@ int amdgpu_ualink_sw_init(struct amdgpu_device *adev)
  */
 void amdgpu_ualink_sw_fini(struct amdgpu_device *adev)
 {
-	u32 status;
-	int i;
-
 	dev_dbg(adev->dev, "halt accel_id %u addr_mode %d\n", ualink_accel_id(adev),
 		ualink_addr_mode(adev));
 
-	amdgpu_ualink_mailbox_write(adev, mmMPNHT_SMN_C2PMSG_22_ALT_2,
-				    AMDGPU_UALINK_FW_CMD_HALT_OPERATION);
-
-	for (i = 0; i < 2000; i++) {
-		status = amdgpu_ualink_mailbox_read(adev, mmMPNHT_SMN_C2PMSG_26_ALT_2);
-		if (status == AMDGPU_UALINK_FW_STATUS_HALT)
-			break;
-		mdelay(1);
-	}
-	if (status != AMDGPU_UALINK_FW_STATUS_HALT)
-		dev_warn(adev->dev, "f/w halt failed status 0x%x\n", status);
+	adev->ualink.msg_ctl->send_halt(adev);
 
 	amdgpu_ualink_peer_remote_fini(adev);
 	amdgpu_ualink_sdma_entities_fini(adev);
@@ -5539,20 +5468,3 @@ int amdgpu_ualink_init_interrupt(struct amdgpu_device *adev)
 			      UALINK_IH_SOURCE_ID, &adev->ualink.irq);
 	return r;
 }
-
-const struct amd_ip_funcs ualink_ip_funcs = {
-	.name = "ualink",
-	.late_init = ualink_ip_late_init,
-	.sw_init = ualink_ip_sw_init,
-	.sw_fini = ualink_ip_sw_fini,
-	.hw_init = ualink_ip_hw_init,
-};
-
-const struct amdgpu_ip_block_version ualink_v1_0_ip_block = {
-	.type = AMD_IP_BLOCK_TYPE_UALINK,
-	.major = 1,
-	.minor = 0,
-	.rev = 0,
-	.funcs = &ualink_ip_funcs,
-};
-
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
index 3c043167f948e..d2348511e61af 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
@@ -31,6 +31,13 @@
 #define AMDGPU_UALINK_LOCAL_ACCELS_MAX 8
 #define AMDGPU_UALINK_STATIONS_MAX 64
 
+/* nHT firmware status */
+#define AMDGPU_NHT_FW_ST_PREINIT	0xA0
+#define AMDGPU_NHT_FW_ST_READY	0xA1
+#define AMDGPU_NHT_FW_ST_HALT	0xA2
+#define AMDGPU_NHT_FW_ST_ERROR	0xA3
+#define AMDGPU_NHT_FW_ST_FATAL	0xF0
+
 #define AMDGPU_UALINK_RESP_TIMEOUT			5000 /* 5s timeout */
 
 #define AMDGPU_UALINK_HANDLE_ACCID_MASK			GENMASK_ULL(9, 0)
@@ -295,9 +302,17 @@ struct amdgpu_ualink_connection {
 
 struct amdgpu_ualink_remote;
 
+struct amdgpu_ualink_msg_ctl {
+	u32 (*check_status)(struct amdgpu_device *adev);
+	int (*send_metadata)(struct amdgpu_device *adev, u64 metadata_gpu_addr,
+			     u32 accel_data);
+	int (*send_halt)(struct amdgpu_device *adev);
+};
+
 struct amdgpu_ualink_mgr {
 	u64 npa_size;
 	u32 psp_if_ver;
+	const struct amdgpu_ualink_msg_ctl *msg_ctl;
 	struct amdgpu_ualink_info *info;
 	struct amdgpu_ualink_ppod_setup *setup;
 	struct amdgpu_ualink_vpod_config *config;
@@ -384,5 +399,10 @@ int amdgpu_ualink_import_handle(struct drm_device *dev,
 				int *fd_out);
 void amdgpu_ualink_revoke_exported_memory(struct amdgpu_bo *bo);
 
+int ualink_ip_hw_init(struct amdgpu_ip_block *ip_block);
+int ualink_ip_late_init(struct amdgpu_ip_block *ip_block);
+int ualink_ip_sw_init(struct amdgpu_ip_block *ip_block);
+int ualink_ip_sw_fini(struct amdgpu_ip_block *ip_block);
+
 extern const struct amdgpu_ip_block_version ualink_v1_0_ip_block;
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/ualink_v1_0.c b/drivers/gpu/drm/amd/amdgpu/ualink_v1_0.c
new file mode 100644
index 0000000000000..0fe2c0fba4cf9
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/ualink_v1_0.c
@@ -0,0 +1,122 @@
+/*
+ * Copyright 2026 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ */
+
+#include <linux/delay.h>
+#include "amdgpu.h"
+#include "amdgpu_ualink.h"
+#include "ualink_v1_0.h"
+
+/* nHT firmware mailbox registers via SMN, copy of MP1 */
+#define mmMPNHT_SMN_C2PMSG_CMD		0xAE10958
+#define mmMPNHT_SMN_C2PMSG_DATA		0xAE1095C
+#define mmMPNHT_SMN_C2PMSG_ADDR_LO	0xAE10960
+#define mmMPNHT_SMN_C2PMSG_ADDR_HI	0xAE10964
+#define mmMPNHT_SMN_C2PMSG_STATUS	0xAE10968
+
+/* nHT firmware commands */
+#define UALINK_V1_0_FW_CMD_LOAD_METADATA	0x1
+#define UALINK_V1_0_FW_CMD_HALT_OPERATION	0x2
+
+#define UALINK_V1_0_FW_POLL_COUNT	2000
+
+static u32 ualink_v1_0_check_status(struct amdgpu_device *adev)
+{
+	return RREG32_PCIE(mmMPNHT_SMN_C2PMSG_STATUS);
+}
+
+static int ualink_v1_0_send_metadata(struct amdgpu_device *adev,
+				     u64 metadata_gpu_addr, u32 accel_data)
+{
+	u32 status;
+	int i;
+
+	dev_dbg(adev->dev, "nht load metadata addr 0x%llx accel_data 0x%x\n",
+		metadata_gpu_addr, accel_data);
+
+	WREG32_PCIE(mmMPNHT_SMN_C2PMSG_ADDR_HI, upper_32_bits(metadata_gpu_addr));
+	WREG32_PCIE(mmMPNHT_SMN_C2PMSG_ADDR_LO, lower_32_bits(metadata_gpu_addr));
+	WREG32_PCIE(mmMPNHT_SMN_C2PMSG_DATA, accel_data);
+	WREG32_PCIE(mmMPNHT_SMN_C2PMSG_CMD, UALINK_V1_0_FW_CMD_LOAD_METADATA);
+
+	for (i = 0; i < UALINK_V1_0_FW_POLL_COUNT; i++) {
+		status = RREG32_PCIE(mmMPNHT_SMN_C2PMSG_STATUS);
+		if (status == AMDGPU_NHT_FW_ST_READY)
+			return 0;
+		mdelay(1);
+	}
+
+	dev_dbg(adev->dev, "f/w load metadata failed 0x%x\n", status);
+	return -ETIME;
+}
+
+static int ualink_v1_0_send_halt(struct amdgpu_device *adev)
+{
+	u32 status;
+	int i;
+
+	dev_dbg(adev->dev, "nht halt cmd 0x%x\n", UALINK_V1_0_FW_CMD_HALT_OPERATION);
+
+	WREG32_PCIE(mmMPNHT_SMN_C2PMSG_CMD, UALINK_V1_0_FW_CMD_HALT_OPERATION);
+
+	for (i = 0; i < UALINK_V1_0_FW_POLL_COUNT; i++) {
+		status = RREG32_PCIE(mmMPNHT_SMN_C2PMSG_STATUS);
+		if (status == AMDGPU_NHT_FW_ST_HALT)
+			return 0;
+		mdelay(1);
+	}
+
+	dev_warn(adev->dev, "f/w halt failed status 0x%x\n", status);
+	return -ETIME;
+}
+
+const struct amdgpu_ualink_msg_ctl ualink_v1_0_msg_ctl = {
+	.check_status = ualink_v1_0_check_status,
+	.send_metadata = ualink_v1_0_send_metadata,
+	.send_halt = ualink_v1_0_send_halt,
+};
+
+static int ualink_v1_0_early_init(struct amdgpu_ip_block *ip_block)
+{
+	struct amdgpu_device *adev = ip_block->adev;
+
+	adev->ualink.msg_ctl = &ualink_v1_0_msg_ctl;
+
+	return 0;
+}
+
+static const struct amd_ip_funcs ualink_v1_0_ip_funcs = {
+	.name = "ualink",
+	.early_init = ualink_v1_0_early_init,
+	.late_init = ualink_ip_late_init,
+	.sw_init = ualink_ip_sw_init,
+	.sw_fini = ualink_ip_sw_fini,
+	.hw_init = ualink_ip_hw_init,
+};
+
+const struct amdgpu_ip_block_version ualink_v1_0_ip_block = {
+	.type = AMD_IP_BLOCK_TYPE_UALINK,
+	.major = 1,
+	.minor = 0,
+	.rev = 0,
+	.funcs = &ualink_v1_0_ip_funcs,
+};
\ No newline at end of file
diff --git a/drivers/gpu/drm/amd/amdgpu/ualink_v1_0.h b/drivers/gpu/drm/amd/amdgpu/ualink_v1_0.h
new file mode 100644
index 0000000000000..d794b0e3e800e
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/ualink_v1_0.h
@@ -0,0 +1,30 @@
+/*
+ * Copyright 2026 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ */
+#ifndef __UALINK_V1_0_H__
+#define __UALINK_V1_0_H__
+
+#include "amdgpu_ualink.h"
+
+extern const struct amdgpu_ualink_msg_ctl ualink_v1_0_msg_ctl;
+
+#endif
-- 
2.55.0

