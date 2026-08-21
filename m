Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38B9EC5DF7D
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 19:51:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3CF710E349;
	Fri, 21 Aug 2026 19:51:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UxdO2TA6";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012028.outbound.protection.outlook.com [52.101.48.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00E0310E349
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 19:51:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MheuZZsbp9fST8/gxsR8erpD28LcjvCgeR5C736TLT71CC2XE6vls27g0ozOOsIixB8aysbqTnS/WR6JLyxGs6UAyaA8DyiC7VrMdPWtuM2wemWWY1wQzYOrGTLaNZQloaNWEm3WpwiMik4W8X6bkNEug5fiIhNkH288OT0yxkP1Ogi/OTdykwfgH7kaW7j0zAx4tWFuBAUr5p2DRDMzlxPPrAD7EkpGzudqUDTTNmufofrf2pMd0OvxvioS2M9vpNi3+F4s6hVwEv0h1SvpM+YJu7VkuNccmXxvIFM++6TM8ODvjDQ0ViT6R9vyN/j5qyCAK6Hbe2A+GBCLHjLC+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0YIJAwjtvsv4uf93Gn+l7M04axYLXReqYz/F2CZW/Ig=;
 b=jWOwJXiiMZac07SiWJJU1FKxtJX/+whQGWLNpBa1XhiCj2Es9CszFM2T9oG7L0eVyRsa7/y70yoUBGqsyUlbbw9IYZ2O964ATRP1gsegYVTFhe7YpuMphmyalAeL+3afz7RYENdsJ8GMJsrAfYwCiWoGsWyWt7HNwjY4+7VCFBQ4kd9ifdER0uGsaKtDnSqXNW4ZEroZxrPZvB5hKF+dsEf4El19+voUbFmp+S3vZObZlzY4Ni12MiqAJI+Zawr+Eb4XwyVA3Og2hvlH65iKkBmG72DA6qjAXSN2ackNY63GXUE2tUKNc2w1Q0O6XrPZvHhQgcgbCr3PXr4VyQAr3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0YIJAwjtvsv4uf93Gn+l7M04axYLXReqYz/F2CZW/Ig=;
 b=UxdO2TA6DO9i0k0kWjdajpwVcvsX8UrnJ4ZkvuIUvB9iJkfdrP0IB1fX3c74xGrA7KD2h25zeR//nGFHpWYIN18/Ala6UzMbBXjRjKSx39Aas2vQuj2OvXPqt4l+jcHLKrOjkF2yrCKSBfFODkZlcRT1F7JrdorJxbS47bQk1mA=
Received: from CH2PR10CA0005.namprd10.prod.outlook.com (2603:10b6:610:4c::15)
 by CY8PR12MB8242.namprd12.prod.outlook.com (2603:10b6:930:77::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Fri, 21 Aug
 2026 19:35:34 +0000
Received: from CH1PEPF0000AD7F.namprd04.prod.outlook.com
 (2603:10b6:610:4c:cafe::85) by CH2PR10CA0005.outlook.office365.com
 (2603:10b6:610:4c::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 19:35:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD7F.mail.protection.outlook.com (10.167.244.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 19:35:34 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:35:32 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 14:35:31 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 14:35:31 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Philip Yang <Philip.Yang@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 33/95] drm/amdgpu: Add UALink NPA address computation for ring
 buffers
Date: Fri, 21 Aug 2026 15:33:56 -0400
Message-ID: <20260821193458.808626-34-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821193458.808626-1-alexander.deucher@amd.com>
References: <20260821193458.808626-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7F:EE_|CY8PR12MB8242:EE_
X-MS-Office365-Filtering-Correlation-Id: 25b1b157-38cf-4e52-6d0d-08deffbb5e65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|376014|82310400026|1800799024|11063799006|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: jrSdOZKTlu/Oq6KNiGO5X439+wcpJMwgCbKNYp85OGSwNoJRXnBT97CVsoCNMkjpbcmTbl0Dhvw1nlzEBGeIOZM2/G0V/3PGZ5CODp1wZP1MOklJMSTbtofrYlW7Mel0dz9Iiaf2pjfDjUvyXDmsqFICeS8Pr/Y4aB6sh3Sp7UxYQ3H3G5AXoCsfA9u36Z7BdebAv/NLDWUtNGzN9H4xzcpl+gukvORCdzRBhVXMOVDih15FchletFiDfxglPGZnPTNO7jlLrcj3SWe2VniA3ChaKWwzg7fbYlXw8lYHX1j/ROkLsQPu4Uhr+noIFBZ0eQOrcnNNWyuNUBe7ZtGUJphrebhTT/wsjbr74az/FyOm4egyXcjwy6UeQ4ALOGYDmWob8LXpS+eSR60M3G7T0tBsCY3BX6oc4z+kc6EKQLYJWNdirKAofRhN2M92iBumF0XcnFHVWlZoa2faHh6KW41FWfD/8WTbw5SyA4HiPI3Tx1IV4wPj804Je3IDdqeCgf0R+/estHNUvHaJdSYHCOnWXkcH1EDYctoi6iApGPajZqMDMkOOJjYBeaExRhXaDAvlpxCK4HpaWxgAfZ0ClImzoUke7LmWH8VvdrWCEWAFgeImPoAitqNzxpMgQ/L3KxKzpQ/eE6Xrmm9lWbSGNzPGPffUja2NCfEMGvWZL5iVrd7P4Pio5/lPVjyn7iYoks/FAcL1HS23B4114/o4tQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(376014)(82310400026)(1800799024)(11063799006)(10067099003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: QEdH15Kt5bYr5OMG/iZMKIDTNOMr6Bjxz+uZ77HxmOldOK45WhfF65Hvz5E/66jpCNowzlbg9UK9QzaYrkzfFFu7oHB7nB6BLewcSYfioL/qd2VdboDH8ZYRWeyIp6f4xM1ed51m0AYMBX2lmdUzbZGgSzm2JoV/21kWE9hkP0B6EViWMmBnNGe8m39f5ZkXoemOEYp0DWSM3EOqr1bcug9SUawrY5Jk8UMLQIcpQDwIz5vMZXw29hQsI1KFYLau9Aobco/1Cmo2td7pK19Qo9plKlTiItVD81tLiCiVRb1Ie55nvcJ2/yVy57PYe60rxPXuT5VxkJs7Zg0fMzJFhjluWc/+u1oTUlXMYKcoV4jK3eBu4IAS8swxnF2hCWlTfO6SzlZVG+nTNWsb24T+vWiUDOPTst38mFrqUnBCrVnwo/uadSQt/8253gcyYXSb
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 19:35:34.0549 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 25b1b157-38cf-4e52-6d0d-08deffbb5e65
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8242
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
index 44abdf5511417..857af8a3727b3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -1228,6 +1228,9 @@ void amdgpu_ualink_manager_stop(struct amdgpu_device *adev)
 /* f/w status */
 #define mmMPNHT_SMN_C2PMSG_26_ALT_2	0xAE10968
 
+/* 2MB NPA start address for 2MB page mapping */
+#define AMDGPU_UALINK_SOURCE_ALIAS_NPA_OFFSET SZ_2M
+
 struct amdgpu_ualink_metadata {
 	u32 header;
 
@@ -1436,3 +1439,97 @@ static inline u32 ualink_tlb_wb_offset(struct amdgpu_device *adev, u32 accel_id)
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

