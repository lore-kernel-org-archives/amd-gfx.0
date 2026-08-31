Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2E28C624C6
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2026 18:29:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF01510EA68;
	Mon, 31 Aug 2026 18:29:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="a5F/vWWF";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010031.outbound.protection.outlook.com
 [52.101.193.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A046810EA58
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 18:28:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yMERhw4sqTWPf1cNQiJi+wx9tIry1fM1kc9GCEel0paTkypqNlTLejJCnWnRq5ZsAqNx8Ubf/QnnZzO0zRIi6MZ13UM6qxf8VXq8WyRV3cjbIT1W8fVX85WJIe6I4Mu3QNHfFS1QNEnNXVnxvmvGauiXAH472l7A26TbE/DYJnn+ripRV/cftKl7NWVsgcVsO4O4uOofb9k2XxWrif2vGH7p8mIczdgglGw6nxCZoHx57+W+6E//c2NkL74VbLc5Fyabua2il5/QiYXQ/jXWuBp4ELg04TdFWFCDBYEaP0g2llNLsCcm034gx3OST0zhMgtpFsYuqDYUPCQDp7nrqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YkGrDxTKIi0B8Gu0LxvlMGRT5hcACv2CFiww70gtIWE=;
 b=Oae+UGxTRhnoll7oTpAe5QIHdF/g1g/uPu/cZb/VDGh9CsxVZkp54goyuw42a6OrYQvR2YluWsPtaa2yym/EW+HfT0Z7QQGf2PV/mV3syVrdaKqdUWbtqltseGqy5KGy+0BK+ieD8UmBBsbLymJZnwE8D2dPZA69tkypFq0bR74nHf1z4nxq214Fy4Dt4w+8UrcYVDEP60BEXm+127GJyQ1cdmwfz6KsOX1TPORoH0Xkfs58Qj0k0pwpoz9Ep5i0e4WHHoEUcAtxzEHyuH+8wi0sj6f7b07M9ces1YSHQHQzKvypPMPbDzshLK05QZLCIq0IbghbBK5Mzwigrprxkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YkGrDxTKIi0B8Gu0LxvlMGRT5hcACv2CFiww70gtIWE=;
 b=a5F/vWWFplS7EfJ9Vgz2blkTpiOaxwTT1SwBho+saJzaFyf9MgL4rCwY5+H89jj0e+9KG1k69EGskLv+7zl5vUPLi247hyxqiUZY/Z01TLCRNAK2n1bBUaQX1klfnE+rGzAVYGVDdjWouJXNesau47a46EEJIuUJU7OZiuwX6AM=
Received: from CH5P220CA0005.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::26)
 by DM4PR12MB6351.namprd12.prod.outlook.com (2603:10b6:8:a2::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.13; Mon, 31 Aug 2026 18:28:39 +0000
Received: from BL6PEPF0001AB71.namprd02.prod.outlook.com
 (2603:10b6:610:1ef:cafe::1e) by CH5P220CA0005.outlook.office365.com
 (2603:10b6:610:1ef::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Mon,
 31 Aug 2026 18:28:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF0001AB71.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 18:28:39 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 13:28:27 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 13:28:28 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Mon, 31 Aug 2026 13:28:27 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Philip Yang <Philip.Yang@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 33/95] drm/amdgpu: Add UALink NPA address computation for ring
 buffers
Date: Mon, 31 Aug 2026 14:26:52 -0400
Message-ID: <20260831182754.1089811-34-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831182754.1089811-1-alexander.deucher@amd.com>
References: <20260831182754.1089811-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB71:EE_|DM4PR12MB6351:EE_
X-MS-Office365-Filtering-Correlation-Id: 29192e31-2c31-49e3-49c5-08df078dad9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|82310400026|36860700016|1800799024|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: HgQyNEWYUBIlWB4TWpYy+b+8sg4f6LINabzpaC/QFWm+IsNuDTTb6PpZSNJSo9soiw/5JxWFK0HD3NtXvS7kzR8p0xzvuSTKQfML705AMUvZSGTtOVh1YjM6cwJeNasH32lwJD/ap9AFn2QUQe/cHHc/njgXROjNcP6j/c7a0/NL2qAlcVgK+yfF2RDkOvBhpbRLXuLCUhlzOYKjMTSlfNaNS4xLzy7iaBy9dKLhPhmLU6jqwVj72PizuSTePnWndXKMI22zPFB1TrT8vnr7hTMZcykZAcniRYTRkDM+xMLKMGTSCzF9wXZg1YhcNSrG8u0YsoQnYOMilRf26hhUw3fZIO5UsDSMQABu0NNHlcNzE23arhOwIqhXRcocf2Ut44TKVnd892245nezr6Ai7/t3Z6z05C3ws6TJ4lbM88zEywFz7sIhCCQqkeA3AVKT8VAnJlgd7Wb21ggVUsJ+7SyqYYAWpXnBUEl4Txrwffp1mbBoAZwN1J2bFoU7S6V1MUzuL1BcD2aiqBtiN8Bfbt7xSEh/fJzkK5LjyNVpUdl30bzmdhoKphh6py2AFUiwiQQfP4aMUgW/0UD5B6tUNAbEvPt8l7NrhkR+7aBa3XN89hN17yncECMq9UFahS972z2OEdjACke6v3fzSHlsvsoFB1dEptwGJeKJ63K8tyTPzt31Rufese/kCcUJ9LSnWYPkl93lsecubAc6vQ+DJg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(82310400026)(36860700016)(1800799024)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: v/jo25kB9Isqakvw7MGxFluayhU5Nutl1C2xKYc7x848JWSLKd8yiXjFrWdpBCT1GDsia0MR8qMJrQ8W8xDk7Lj9RvqR6YWKeSRSH2/IYJvkH5SYo997/zWiqNyOMQ5lT53Tn4gWnjk3pWawXI4QljAWtvkDhJHtkev93a1J+md9iwQRWoPfHDvlECtBTDSzBRhu21ns5ZCHedzblCaK3rmM3LLS0iJtuNkqT+M02+Xvs30+tlchuLYA+KDTdD9zJeXndw+nIggixTbbPlQdf/OrE1W96DJ3Yfh7Q0UUHoYX5nhIbq46EupYXr7j00SLDJ0N5RzZmFESZFgyoAt+YvdiPzeAXJCREYvmMJXIa8QGRBraHZBeUKpzWx7zUQhC+k1Sf35AbhMu7PoG1y8AGTyUTUgcp1O1nLdezdkvJtYJaZH7Ta2UYs84ERurZWZe
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 18:28:39.4083 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29192e31-2c31-49e3-49c5-08df078dad9f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB71.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6351
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

From: Philip Yang <Philip.Yang@amd.com>

Add a ring buffer type enum and address formula for the reserved NPA
space between source and destination GPUs, covering both addressing
modes. Add a GART-adjusted variant so the local SDMA engine can address
remote GPU buffers.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 97 ++++++++++++++++++++++
 1 file changed, 97 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index ae3ae41c8f360..c4edefcef2141 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -1273,6 +1273,9 @@ void amdgpu_ualink_manager_stop(struct amdgpu_device *adev)
 /* f/w status */
 #define mmMPNHT_SMN_C2PMSG_26_ALT_2	0xAE10968
 
+/* 2MB NPA start address for 2MB page mapping */
+#define AMDGPU_UALINK_SOURCE_ALIAS_NPA_OFFSET SZ_2M
+
 struct amdgpu_ualink_metadata {
 	u32 header;
 
@@ -1481,3 +1484,97 @@ static inline u32 ualink_tlb_wb_offset(struct amdgpu_device *adev, u32 accel_id)
 	return ualink_wb_offset(adev, accel_id) + sizeof(struct amdgpu_ualink_wb);
 }
 
+/*
+ * Reserved NPA space for remote shootdown and interrupt ring buffer,
+ * write pointers, read pointers and writeback buffers
+ *
+ * NPA ring type: 0 = shootdown, 1 = interrupt, 2 = tailptr (wptr)
+ */
+enum ring_buffer_type {
+	RB_TYPE_TLB_INV			= 0,
+	RB_TYPE_REMOTE_INTERRUPT	= 1,
+	RB_TYPE_TAILPTR			= 2
+};
+
+/**
+ * amdgpu_ualink_npa_addr - Get reserved NPA address for ring buffer
+ * @adev: amdgpu device pointer
+ * @type: Ring buffer type (TLB_INV, REMOTE_INTERRUPT, or TAILPTR)
+ * @src_accel_id: Source accelerator ID
+ * @dst_accel_id: Destination accelerator ID
+ *
+ * Return: NPA address for the specified ring buffer type and GPUs
+ */
+static u64 amdgpu_ualink_npa_addr(struct amdgpu_device *adev, u32 type,
+				  u32 src_accel_id, u32 dst_accel_id)
+{
+	u32 addr_mode = ualink_addr_mode(adev);
+	u64 npa;
+
+	WARN_ON_ONCE(src_accel_id >= AMDGPU_UALINK_ACCEL_MAX ||
+		     dst_accel_id >= AMDGPU_UALINK_ACCEL_MAX ||
+		     type > RB_TYPE_TAILPTR ||
+		     (addr_mode != AMDGPU_UALINK_ADDR_MODE_SOURCE_IDENT &&
+		     addr_mode != AMDGPU_UALINK_ADDR_MODE_SOURCE_ALIAS));
+
+	switch (addr_mode) {
+	case AMDGPU_UALINK_ADDR_MODE_SOURCE_IDENT:
+		npa = (u64)src_accel_id << 41 | type << 12;
+		break;
+
+	case AMDGPU_UALINK_ADDR_MODE_SOURCE_ALIAS:
+	default:
+		if (type == RB_TYPE_TAILPTR)
+			npa = (u64)dst_accel_id << 13;
+		else
+			npa = (u64)src_accel_id << 13 | type << 12;
+
+		/*
+		 * In order to avoid address conflicts between source-identification
+		 * and source-aliasing mode, add 2MB to the buffer addresses in
+		 * source-aliasing mode. This way in a misconfigured cluster, a GPU
+		 * configured in the wrong address mode will access unmapped NPA addresses
+		 * rather than the wrong buffer mappings.
+		 */
+		npa += AMDGPU_UALINK_SOURCE_ALIAS_NPA_OFFSET;
+		break;
+	}
+
+	dev_dbg(adev->dev, "addr mode %d from accel %d to accel %d type %d NPA 0x%llx\n",
+		addr_mode, src_accel_id, dst_accel_id, type, npa);
+
+	return npa;
+}
+
+/**
+ * amdgpu_ualink_gart_npa_addr - Get GART-mapped NPA address for ring buffer
+ * @adev: amdgpu device pointer
+ * @type: Ring buffer type (TLB_INV, REMOTE_INTERRUPT, or TAILPTR)
+ * @src_accel_id: Source accelerator ID
+ * @dst_accel_id: Destination accelerator ID
+ *
+ * Computes the NPA address suitable for GART mapping by adding dst_accid_id to
+ * NPA address to access remote by SDMA.
+
+ * clears the source GPU ID bits from the NPA address which is set for
+ * address-identification mode.
+ *
+ * Return: NPA address adjusted for GART mapping
+ */
+
+#define AMDGPU_UALINK_GART_NPA_ADDR_GPUID_SHIFT		41
+#define AMDGPU_UALINK_GART_NPA_ADDR_GPUID_MASK		GENMASK_ULL(50, 41)
+
+static u64 amdgpu_ualink_gart_npa_addr(struct amdgpu_device *adev, u32 type,
+					u32 src_accel_id, u32 dst_accel_id)
+{
+	u64 npa;
+
+	npa = amdgpu_ualink_npa_addr(adev, type, src_accel_id, dst_accel_id);
+
+	/* wiping out source accelerator id */
+	npa &= ~AMDGPU_UALINK_GART_NPA_ADDR_GPUID_MASK;
+
+	return npa | ((u64)dst_accel_id << AMDGPU_UALINK_GART_NPA_ADDR_GPUID_SHIFT);
+}
+
-- 
2.55.0

