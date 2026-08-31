Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C5DBC624DC
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2026 18:29:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1BD0D10EA8D;
	Mon, 31 Aug 2026 18:29:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GQZ9El66";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012063.outbound.protection.outlook.com
 [40.107.200.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45D3510EA67
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 18:29:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c/z2dIB8KQg7Ek0NTV2+TQ68U0AoVyf6cA5ok5R0P+e8G7NgUEIddXF8lQjRI9jU1kIxel+Klafux6fxsHLOw5vg2EmMTkNcwXV53ttok+8PTvrA84mwMTgSglXaI/lXZ7WLDx14yeS5X72r2/9chL4ZVw2IEF0BF4evk5n0wU9W72ogOWW+T+YgAlvWAnAeSk2vZfYjsZw4VYR/xLKLKg1ViZTxelFZpmRgW9+iPWP2ygsBJwAu2uHXGgMo0Yj9qV9sVUBufBp/B2ylFb1xqyJXNymZ9ChX7DR+jYsfCzp0V55FlXkT4JAGKVD5w8HDCEMAvFJ28OY6mBjIpFi6zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dDKOjNK3wIVeGejaG8bk0NVdEWucqXblUz6kn5QJ/Ho=;
 b=RTGwxqza9w08iSTk4KjX0HLe3mH6ZNpQOSy1T/W4Ifv0itkfjijkI0gtyZH9P342GEBAiMbHP7UbrHSS0319hphdCAFwblEP4lyOK6MHgBGgwuOGmssSr2JvTL2pgXGsAbgfvdL7NZbObUjkTHlla/4Eibp9mZVU2wvoJuUN8iw6TMFS5TTnL4zSPmdy3x/lqz+A4irD4k9EzzTsEh2W1Z3DV47yzrc98uKZpTQEd62xEPAvHpENLDBvycrDZnStX+v0E12+Gm5AgqhjZTRCpXFYcngQryGUS62UJkv3f0nVk7nAKba6r64oI77iW7WlUQgy+OedIYAl7eQSNFcbeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dDKOjNK3wIVeGejaG8bk0NVdEWucqXblUz6kn5QJ/Ho=;
 b=GQZ9El66hc1KEXngenFVBL0K7rHpdDW7L9PsHjZORVBgiztbU9LpeUMmoAMxVK3lVOi/YzX0c6aCkTThG/PE3yUzMDWN/+TYwMz4yiFOSCOlwgYUd/WYAH1zWCsx7FgsIZ0LzcHE4/B0+aDIPpK42yDaRy010rlCX+E2L/P9KrY=
Received: from CH0PR04CA0115.namprd04.prod.outlook.com (2603:10b6:610:75::30)
 by CH3PR12MB7740.namprd12.prod.outlook.com (2603:10b6:610:145::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 18:29:11 +0000
Received: from BL6PEPF0001AB76.namprd02.prod.outlook.com
 (2603:10b6:610:75:cafe::6f) by CH0PR04CA0115.outlook.office365.com
 (2603:10b6:610:75::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Mon,
 31 Aug 2026 18:29:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF0001AB76.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 18:29:11 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 13:28:55 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 13:28:56 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Mon, 31 Aug 2026 13:28:55 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Lijo Lazar <lijo.lazar@amd.com>, Felix Kuehling <felix.kuehling@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 77/95] drm/admgpu: Seggregate ualink nht messaging
Date: Mon, 31 Aug 2026 14:27:36 -0400
Message-ID: <20260831182754.1089811-78-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831182754.1089811-1-alexander.deucher@amd.com>
References: <20260831182754.1089811-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB76:EE_|CH3PR12MB7740:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cbae303-3230-4299-0400-08df078dc079
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|23010399003|376014|22082099003|18002099003|56012099006|3023799007|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: jHr7TIRNNDi/ob/OEPL2lr0yTCeCLV+7ae0ajlXtmhfkAvGk8/GbYGTNjN4bRyMYsCZQPOoG6MTdzRkMn5bN3k0cv9RcFLZ3TPWcKr0wwJTjG95cWR/kqhj3Xy5iS1X/IvRoMRSwdEGlgRPomXeKN92P7ykuDQqq7V7ZL8F1bz746TI3Po3NfZZ7PRzEFGg7KC6tUeG8uaR/462k1iZxLqhBKKH4lYmMqyE8V/iTMRZpyN5RenCcRxrb+uIadB++7TqT7AfDWoMkqTo7t/LZaSL1nc6r8r7UBFoAX0msWN4klq5pwYxtYg5yoaWEQqEcdheyHrNR4yNcH46UirjBT902BPEFOkjocsccBNfDy8rLvSVnk6Cl6Y4fUoAXBAHersi53JezrecKQXx5AiY42WzranGb6OQcfbJE1fCLoPYgMQidWbqA1QYTMC2XL2AWHsOzwV1kbIZ+4+SUXamjBZNInIJF721ngSdu7fLaLaCXZizN4jZmBa4iwHZVzPzsqp+6X6Hi5qLlYhHa+z72L7XQhjUvBMeeaQWvTzLh33A5BZOtFWcr2kg3oSvLFkSQnbJqWe9YVXb7Jwlr2ki/voDLHRhkDma51mTvPIfr16MWfCNk3Q3nIuK7qynBjQNOBPIe8cNyKv6Jz1bkcaTloDemotUm8uXwqgZ/Zd3+hjQd4yQcYTkoU+uSlTnZoBzbUS7+l/vo0XjJAW7DLvuHyA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(23010399003)(376014)(22082099003)(18002099003)(56012099006)(3023799007)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: M/AxNXRc2Q0VJTrywGtXuENPl0dNQvyyKL1XOPqxC0cmJqtTAXeL3FhLeli+3mnaU+DRFu+3AhAyqiga4dN7KGwtXnDsKUnJBgC5cao7TtUwpSWh5SViH02neFjh4Ycvj1wAgqgv5SyUKT8i91viB/v1IqRyjlvGaUK8L2s4OWYMaccN3jSZQA6etcK15hJHqowwrJQxpqDJ96eFHh5kKSAbI31iWQBLT3Tga76xOLzw4pR3Z6Y+pfVM3eN8+ks1N1jNImojKTdTdLrGv4hk9caAVRt5RTnDte3GV0k7oLJwmhMZ9N/ZPb8evdwMD0vlFId532f9/6CC3RsUYPXiWF5CxhLMv8wUdUX7sXMzBbg0BUHnad90veP+vmdT2cpffljxJT+uwTPsvofHZXKGPCj+D/cJYxaAUgZJC0/66TcwGiBOiiigKR4M/VgZYO3j
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 18:29:11.0337 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cbae303-3230-4299-0400-08df078dc079
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB76.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7740
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
index 2772d99233615..ec34d5bc4dc03 100644
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
@@ -1050,7 +1050,7 @@ static const struct kobj_type ualink_station_config_ktype = {
 	.sysfs_ops = &kobj_sysfs_ops
 };
 
-static int ualink_ip_sw_init(struct amdgpu_ip_block *ip_block)
+int ualink_ip_sw_init(struct amdgpu_ip_block *ip_block)
 {
 	int r;
 
@@ -1102,7 +1102,7 @@ static int ualink_ip_sw_init(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
-static int ualink_ip_sw_fini(struct amdgpu_ip_block *ip_block)
+int ualink_ip_sw_fini(struct amdgpu_ip_block *ip_block)
 {
 	amdgpu_ualink_object_fini(ip_block->adev);
 	return 0;
@@ -3520,29 +3520,6 @@ void amdgpu_ualink_manager_stop(struct amdgpu_device *adev)
 
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
 
@@ -3771,25 +3748,6 @@ static void amdgpu_ualink_flush_tlb(struct amdgpu_device *adev, u32 flush_type)
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
@@ -4464,7 +4422,7 @@ static int amdgpu_ualink_metadata_init(struct amdgpu_device *adev)
 	u32 size, rb_size, wptr_size, rptr_size, metadata_size;
 	u64 rb_gpu_addr, wptr_gpu_addr;
 	u32 status, accel_id;
-	int i, r;
+	int r;
 
 	remote->active_accel_bits = adev->ualink.info->vpod.active_accel_bits;
 	dev_dbg(adev->dev, "%d active accelerators config in vpod\n",
@@ -4476,9 +4434,9 @@ static int amdgpu_ualink_metadata_init(struct amdgpu_device *adev)
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
@@ -4595,25 +4553,9 @@ static int amdgpu_ualink_metadata_init(struct amdgpu_device *adev)
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
@@ -5364,23 +5306,10 @@ int amdgpu_ualink_sw_init(struct amdgpu_device *adev)
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
@@ -5588,20 +5517,3 @@ int amdgpu_ualink_init_interrupt(struct amdgpu_device *adev)
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
index 64ebdf943aa72..d4e727c9f98a0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
@@ -35,6 +35,13 @@ struct amdgpu_device;
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
@@ -299,9 +306,17 @@ struct amdgpu_ualink_connection {
 
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
@@ -388,5 +403,10 @@ int amdgpu_ualink_import_handle(struct drm_device *dev,
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

