Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDC64C88E59
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Sep 2026 17:56:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 28AAA10F6A2;
	Fri, 11 Sep 2026 17:56:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Fl4R8Vj/";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012028.outbound.protection.outlook.com [52.101.53.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AADB010F69F
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Sep 2026 17:56:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x0U/fwYUMaSqbG3syrdwGYDdi5HTBExzVnWKTYpWVb6hRn/ZANyXZgxKnpyKLCJKNyIvU6noceVefyUyfDMVX6Pr6YkfQjTEbRsX0N+v8hwxL/v9ecZvGEGxKugFc1XPAjDz+R+tiVg377jnQ97JSjtu2B7WulBcTNkQApMtGpnzBPZBDD803+gEMao0U2lLno6igxnJ4SfkfDV72kJYuLu5yln4keOGLwc2z5BhryonArb61bg2aoU0KnxMz7or+gk6+h4jB6XeyGT2zBou5JH7zdIOu0gV1yZ3aqsF2eiuFUToA220D0TequfF4y/8Ufgr7G7nIrhfMLtSnx74wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Geot7SOdWvRNEgY6YxBNrivOQUTvaKlYOLyFkbuP5oE=;
 b=oHSVpb2ZBrXiUeQxcFc1aP4m1wmsUSGWQGZgahcRfmTbBn5Gz27cTGkreG5aJ+eyqMqWakOeQbk27Xl7xzAN0DYaaV6iD7TxmT/E7RUx95gWkizroDm+J9HKwKE1GYXUKtPtLSHQo2cSFtkNqZHn9W+rjTBGOBKWvq9ws5ICo3VcGVbOUQw00NaYGQLhvHa/K0+s2l/SGSh/VjyhuQO7uVRXnB3o2wh3zmkr9DxhMLjCRqipBFXFsctW4zRNHvudUcmyZve1GfZLSM+pR92Krr+lkygMTHlTnakF5r5aIeEgKHAALqA+CpO5X53kYsrnviK6Ee/c8xI/GzZ7xXHgPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Geot7SOdWvRNEgY6YxBNrivOQUTvaKlYOLyFkbuP5oE=;
 b=Fl4R8Vj/biAOmbgtzMQ4k1wwPUOOgYCU1iNS2j/AM1wkzJhjo9ikAGutEgJkDPL2aEGL/qWFs4O+e1JSVtG4KJqnhd+4wfJuPqrVowwfTcx3oody/MYprfcBaTekOKyUfpSAkMGqUMVC49BnSFsr8i+Vian82nJy7iqmkMYTa18=
Received: from BN9PR03CA0174.namprd03.prod.outlook.com (2603:10b6:408:f4::29)
 by SA1PR12MB7365.namprd12.prod.outlook.com (2603:10b6:806:2ba::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 17:56:04 +0000
Received: from BN1PEPF00018071.namprd04.prod.outlook.com
 (2603:10b6:408:f4:cafe::67) by BN9PR03CA0174.outlook.office365.com
 (2603:10b6:408:f4::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.9 via Frontend Transport; Fri, 11
 Sep 2026 17:56:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00018071.mail.protection.outlook.com (10.167.245.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Fri, 11 Sep 2026 17:56:04 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 11 Sep
 2026 12:55:58 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Fri, 11 Sep 2026 12:55:57 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 05/23] drm/amdgpu/gmc9: set vmhub funcs for gfxhub and mmhub
Date: Fri, 11 Sep 2026 13:55:26 -0400
Message-ID: <20260911175544.1314467-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260911175544.1314467-1-alexander.deucher@amd.com>
References: <20260911175544.1314467-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00018071:EE_|SA1PR12MB7365:EE_
X-MS-Office365-Filtering-Correlation-Id: 67b6c60d-30db-4b9d-15d1-08df102df303
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|23010399003|82310400026|1800799024|6133799003|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: nackiNS+RMXtlhFJPp+CSzD/mNlgzlIE7mkVgf4Cy5RtYjDp1ewwGvss5EE8sasmFCP+hwx1DGch0l0bvY1JmUQIPXjaEomQEPUhIFXNA8ZXjUC7QE3CzavaMNCTs+Co922PV0adBpP8EuAg0hUGLdmhs6H2szI+74DrmR7q+ct5WdxmG4mDH1fvroJFxN/WN8KeAsI7tCNC9lJbFJJcZrNhva+Ljycp+l2Hb2rqwndf1DDF61Kp0JUqnZgfeBD522NLAHzPbjTQ6aomsSEvsh0nBQl9fPgN+cuYr/9SnCfxM9+uOPQoGD0V8WsV6BJGPtEO/WCOyszbzjOs1dfAkEwqpcZZqc1hhvam7iqKBv+C1Dsfcx0TPMBhijUEZ9MlHQQ1P+HJyyLXV4CrHopYAUOJBbaeK9DSDGeZeD7Z7DWe7drPulHznvi1GW09i9+eRBK5KiuDJp21aQ4b7pQA3GEDNFKqZPydswONb7AxNSOdfpTTaK9BqtRrFW1q+r1/wQCb+hMdM6FQyh7bTfTEOkBum/VIg80ZxK1Jv90M6j5xi7zom7Jjl4LNlgxPyJu7T7iRcpx00DwqJ8Dng96TjNkgpTi0Ve2Im3Mixvrfqtfe9YFn3WFIhOr1+w8Vgk/jeST53lDDFSQxr6kPLMuoIByNQ/psDZPp8Aaf/kypH/I8Kz4wc1QPN6B3EkQpiRgy4OSvWx9NRvmdWy3zHXo+kQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(23010399003)(82310400026)(1800799024)(6133799003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: WipPDldltqOGJGCNx+9SxeuYTbPI2Fa77TdttzMXrEOG0NtXadqidc+LRuEjycp+ESKVwrebV0OVB31mhfaPmZO91yGfWnYblo5OLQUnZe6H51lgEvIlt3T7OfQiWl7lxXlkBZf02/CfbyX26NMgDbpZH73SGHFE7ADcfrZykXXQy/RtRyWJ9qRMJpkUa1JCv+t2stzDbOzfgBFyFUxWryoycgdGCc7Iz/xD8hS9NAsnvnOyStjIgm5MZhm20GlxoZMAZNHMW7k3sSoDrToKXEt2x+p4setrtQ45tS6Wytkcq2RI9m9yCbJNQkVZx3aD6QH5zd5xAZjP2ZsEbSeZKlt45b9PUIh1RssPMGMXXFA08nlSQ26kLVhdFtwjXD4XgD7Air1d32DG8UN7YQDZaL4svzrpcAUdJjvbWN0jwzC6qy5rhbhBuB8RdDE+OgIq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 17:56:04.6102 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67b6c60d-30db-4b9d-15d1-08df102df303
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00018071.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7365
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

This was handled in gmc_v9_0 directly.  Set the pointers
so that we can use rely on the callbacks in the generic gmc
helpers.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c | 33 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c | 33 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c    | 23 ++---------------
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c  | 33 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c  | 32 +++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c  | 32 +++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c  | 32 +++++++++++++++++++++++
 7 files changed, 197 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
index c35856180c3c4..8ff366f7b0b87 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
@@ -415,6 +415,37 @@ static void gfxhub_v1_0_set_fault_enable_default(struct amdgpu_device *adev,
 	WREG32_SOC15(GC, 0, mmVM_L2_PROTECTION_FAULT_CNTL, tmp);
 }
 
+static void
+gfxhub_v1_0_print_l2_protection_fault_status(struct amdgpu_device *adev,
+					     uint32_t status)
+{
+	/* this is handled in gmc_v9_0.c already */
+}
+
+static uint32_t gfxhub_v1_0_get_invalidate_req(unsigned int vmid,
+					       uint32_t flush_type)
+{
+	u32 req = 0;
+
+	req = REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ,
+			    PER_VMID_INVALIDATE_REQ, 1 << vmid);
+	req = REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ, FLUSH_TYPE, flush_type);
+	req = REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ, INVALIDATE_L2_PTES, 1);
+	req = REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ, INVALIDATE_L2_PDE0, 1);
+	req = REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ, INVALIDATE_L2_PDE1, 1);
+	req = REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ, INVALIDATE_L2_PDE2, 1);
+	req = REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ, INVALIDATE_L1_PTES, 1);
+	req = REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ,
+			    CLEAR_PROTECTION_FAULT_STATUS_ADDR,	0);
+
+	return req;
+}
+
+static const struct amdgpu_vmhub_funcs gfxhub_v1_0_vmhub_funcs = {
+	.print_l2_protection_fault_status = gfxhub_v1_0_print_l2_protection_fault_status,
+	.get_invalidate_req = gfxhub_v1_0_get_invalidate_req,
+};
+
 static void gfxhub_v1_0_init(struct amdgpu_device *adev)
 {
 	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB(0)];
@@ -444,6 +475,8 @@ static void gfxhub_v1_0_init(struct amdgpu_device *adev)
 	hub->eng_distance = mmVM_INVALIDATE_ENG1_REQ - mmVM_INVALIDATE_ENG0_REQ;
 	hub->eng_addr_distance = mmVM_INVALIDATE_ENG1_ADDR_RANGE_LO32 -
 		mmVM_INVALIDATE_ENG0_ADDR_RANGE_LO32;
+
+	hub->vmhub_funcs = &gfxhub_v1_0_vmhub_funcs;
 }
 
 const struct amdgpu_gfxhub_funcs gfxhub_v1_0_funcs = {
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
index 8397d3d382875..e45eee485204d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
@@ -541,6 +541,37 @@ static void gfxhub_v1_2_set_fault_enable_default(struct amdgpu_device *adev,
 	gfxhub_v1_2_xcc_set_fault_enable_default(adev, value, xcc_mask);
 }
 
+static void
+gfxhub_v1_2_print_l2_protection_fault_status(struct amdgpu_device *adev,
+					     uint32_t status)
+{
+	/* this is handled in gmc_v9_0.c already */
+}
+
+static uint32_t gfxhub_v1_2_get_invalidate_req(unsigned int vmid,
+					       uint32_t flush_type)
+{
+	u32 req = 0;
+
+	req = REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ,
+			    PER_VMID_INVALIDATE_REQ, 1 << vmid);
+	req = REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ, FLUSH_TYPE, flush_type);
+	req = REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ, INVALIDATE_L2_PTES, 1);
+	req = REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ, INVALIDATE_L2_PDE0, 1);
+	req = REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ, INVALIDATE_L2_PDE1, 1);
+	req = REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ, INVALIDATE_L2_PDE2, 1);
+	req = REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ, INVALIDATE_L1_PTES, 1);
+	req = REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ,
+			    CLEAR_PROTECTION_FAULT_STATUS_ADDR,	0);
+
+	return req;
+}
+
+static const struct amdgpu_vmhub_funcs gfxhub_v1_2_vmhub_funcs = {
+	.print_l2_protection_fault_status = gfxhub_v1_2_print_l2_protection_fault_status,
+	.get_invalidate_req = gfxhub_v1_2_get_invalidate_req,
+};
+
 static void gfxhub_v1_2_xcc_init(struct amdgpu_device *adev, uint32_t xcc_mask)
 {
 	struct amdgpu_vmhub *hub;
@@ -579,6 +610,8 @@ static void gfxhub_v1_2_xcc_init(struct amdgpu_device *adev, uint32_t xcc_mask)
 		hub->eng_addr_distance =
 				regVM_INVALIDATE_ENG1_ADDR_RANGE_LO32 -
 				regVM_INVALIDATE_ENG0_ADDR_RANGE_LO32;
+
+		hub->vmhub_funcs = &gfxhub_v1_2_vmhub_funcs;
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index b036f7fe27b8c..cae11bd1c754a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -705,25 +705,6 @@ static void gmc_v9_0_set_irq_funcs(struct amdgpu_device *adev)
 	}
 }
 
-static uint32_t gmc_v9_0_get_invalidate_req(unsigned int vmid,
-					uint32_t flush_type)
-{
-	u32 req = 0;
-
-	req = REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ,
-			    PER_VMID_INVALIDATE_REQ, 1 << vmid);
-	req = REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ, FLUSH_TYPE, flush_type);
-	req = REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ, INVALIDATE_L2_PTES, 1);
-	req = REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ, INVALIDATE_L2_PDE0, 1);
-	req = REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ, INVALIDATE_L2_PDE1, 1);
-	req = REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ, INVALIDATE_L2_PDE2, 1);
-	req = REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ, INVALIDATE_L1_PTES, 1);
-	req = REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ,
-			    CLEAR_PROTECTION_FAULT_STATUS_ADDR,	0);
-
-	return req;
-}
-
 /**
  * gmc_v9_0_use_invalidate_semaphore - judge whether to use semaphore
  *
@@ -785,7 +766,7 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 	BUG_ON(vmhub >= AMDGPU_MAX_VMHUBS);
 
 	hub = &adev->vmhub[vmhub];
-	inv_req = gmc_v9_0_get_invalidate_req(vmid, flush_type);
+	inv_req = hub->vmhub_funcs->get_invalidate_req(vmid, flush_type);
 	sem = hub->vm_inv_eng0_sem + hub->eng_distance * eng;
 	req = hub->vm_inv_eng0_req + hub->eng_distance * eng;
 	ack = hub->vm_inv_eng0_ack + hub->eng_distance * eng;
@@ -931,7 +912,7 @@ static uint64_t gmc_v9_0_emit_flush_gpu_tlb(struct amdgpu_ring *ring,
 	bool use_semaphore = gmc_v9_0_use_invalidate_semaphore(ring->adev, ring->vm_hub);
 	struct amdgpu_device *adev = ring->adev;
 	struct amdgpu_vmhub *hub = &adev->vmhub[ring->vm_hub];
-	uint32_t req = gmc_v9_0_get_invalidate_req(vmid, 0);
+	uint32_t req = hub->vmhub_funcs->get_invalidate_req(vmid, 0);
 	unsigned int eng = ring->vm_inv_eng;
 
 	/*
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
index 243eabda06077..46b0fc94007cc 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
@@ -464,6 +464,37 @@ static void mmhub_v1_0_set_fault_enable_default(struct amdgpu_device *adev, bool
 	WREG32_SOC15(MMHUB, 0, mmVM_L2_PROTECTION_FAULT_CNTL, tmp);
 }
 
+static uint32_t mmhub_v1_0_get_invalidate_req(unsigned int vmid,
+					      uint32_t flush_type)
+{
+	u32 req = 0;
+
+	req = REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ,
+			    PER_VMID_INVALIDATE_REQ, 1 << vmid);
+	req = REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ, FLUSH_TYPE, flush_type);
+	req = REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ, INVALIDATE_L2_PTES, 1);
+	req = REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ, INVALIDATE_L2_PDE0, 1);
+	req = REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ, INVALIDATE_L2_PDE1, 1);
+	req = REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ, INVALIDATE_L2_PDE2, 1);
+	req = REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ, INVALIDATE_L1_PTES, 1);
+	req = REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ,
+			    CLEAR_PROTECTION_FAULT_STATUS_ADDR,	0);
+
+	return req;
+}
+
+static void
+mmhub_v1_0_print_l2_protection_fault_status(struct amdgpu_device *adev,
+					     uint32_t status)
+{
+	/* this is handled in gmc_v9_0.c already */
+}
+
+static const struct amdgpu_vmhub_funcs mmhub_v1_0_vmhub_funcs = {
+	.print_l2_protection_fault_status = mmhub_v1_0_print_l2_protection_fault_status,
+	.get_invalidate_req = mmhub_v1_0_get_invalidate_req,
+};
+
 static void mmhub_v1_0_init(struct amdgpu_device *adev)
 {
 	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_MMHUB0(0)];
@@ -493,6 +524,8 @@ static void mmhub_v1_0_init(struct amdgpu_device *adev)
 	hub->eng_distance = mmVM_INVALIDATE_ENG1_REQ - mmVM_INVALIDATE_ENG0_REQ;
 	hub->eng_addr_distance = mmVM_INVALIDATE_ENG1_ADDR_RANGE_LO32 -
 		mmVM_INVALIDATE_ENG0_ADDR_RANGE_LO32;
+
+	hub->vmhub_funcs = &mmhub_v1_0_vmhub_funcs;
 }
 
 static void mmhub_v1_0_update_medium_grain_clock_gating(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
index 2adee2b94c37d..84d1dc32728bd 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
@@ -448,6 +448,37 @@ static void mmhub_v1_7_set_fault_enable_default(struct amdgpu_device *adev, bool
 	WREG32_SOC15(MMHUB, 0, regVM_L2_PROTECTION_FAULT_CNTL, tmp);
 }
 
+static void
+mmhub_v1_7_print_l2_protection_fault_status(struct amdgpu_device *adev,
+					     uint32_t status)
+{
+	/* this is handled in gmc_v9_0.c already */
+}
+
+static uint32_t mmhub_v1_7_get_invalidate_req(unsigned int vmid,
+					      uint32_t flush_type)
+{
+	u32 req = 0;
+
+	req = REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ,
+			    PER_VMID_INVALIDATE_REQ, 1 << vmid);
+	req = REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ, FLUSH_TYPE, flush_type);
+	req = REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ, INVALIDATE_L2_PTES, 1);
+	req = REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ, INVALIDATE_L2_PDE0, 1);
+	req = REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ, INVALIDATE_L2_PDE1, 1);
+	req = REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ, INVALIDATE_L2_PDE2, 1);
+	req = REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ, INVALIDATE_L1_PTES, 1);
+	req = REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ,
+			    CLEAR_PROTECTION_FAULT_STATUS_ADDR,	0);
+
+	return req;
+}
+
+static const struct amdgpu_vmhub_funcs mmhub_v1_7_vmhub_funcs = {
+	.print_l2_protection_fault_status = mmhub_v1_7_print_l2_protection_fault_status,
+	.get_invalidate_req = mmhub_v1_7_get_invalidate_req,
+};
+
 static void mmhub_v1_7_init(struct amdgpu_device *adev)
 {
 	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_MMHUB0(0)];
@@ -476,6 +507,7 @@ static void mmhub_v1_7_init(struct amdgpu_device *adev)
 	hub->eng_addr_distance = regVM_INVALIDATE_ENG1_ADDR_RANGE_LO32 -
 		regVM_INVALIDATE_ENG0_ADDR_RANGE_LO32;
 
+	hub->vmhub_funcs = &mmhub_v1_7_vmhub_funcs;
 }
 
 static void mmhub_v1_7_update_medium_grain_clock_gating(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
index 47d07cd25fc41..4c9f41905b650 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
@@ -577,6 +577,37 @@ static void mmhub_v1_8_set_fault_enable_default(struct amdgpu_device *adev, bool
 	}
 }
 
+static void
+mmhub_v1_8_print_l2_protection_fault_status(struct amdgpu_device *adev,
+					     uint32_t status)
+{
+	/* this is handled in gmc_v9_0.c already */
+}
+
+static uint32_t mmhub_v1_8_get_invalidate_req(unsigned int vmid,
+					      uint32_t flush_type)
+{
+	u32 req = 0;
+
+	req = REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ,
+			    PER_VMID_INVALIDATE_REQ, 1 << vmid);
+	req = REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ, FLUSH_TYPE, flush_type);
+	req = REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ, INVALIDATE_L2_PTES, 1);
+	req = REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ, INVALIDATE_L2_PDE0, 1);
+	req = REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ, INVALIDATE_L2_PDE1, 1);
+	req = REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ, INVALIDATE_L2_PDE2, 1);
+	req = REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ, INVALIDATE_L1_PTES, 1);
+	req = REG_SET_FIELD(req, VM_INVALIDATE_ENG0_REQ,
+			    CLEAR_PROTECTION_FAULT_STATUS_ADDR,	0);
+
+	return req;
+}
+
+static const struct amdgpu_vmhub_funcs mmhub_v1_8_vmhub_funcs = {
+	.print_l2_protection_fault_status = mmhub_v1_8_print_l2_protection_fault_status,
+	.get_invalidate_req = mmhub_v1_8_get_invalidate_req,
+};
+
 static void mmhub_v1_8_init(struct amdgpu_device *adev)
 {
 	struct amdgpu_vmhub *hub;
@@ -610,6 +641,7 @@ static void mmhub_v1_8_init(struct amdgpu_device *adev)
 			regVM_INVALIDATE_ENG0_REQ;
 		hub->eng_addr_distance = regVM_INVALIDATE_ENG1_ADDR_RANGE_LO32 -
 			regVM_INVALIDATE_ENG0_ADDR_RANGE_LO32;
+		hub->vmhub_funcs = &mmhub_v1_8_vmhub_funcs;
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
index fe0710b55c3ac..af7958931b152 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
@@ -536,6 +536,37 @@ static void mmhub_v9_4_set_fault_enable_default(struct amdgpu_device *adev, bool
 	}
 }
 
+static void
+mmhub_v9_4_print_l2_protection_fault_status(struct amdgpu_device *adev,
+					    uint32_t status)
+{
+	/* this is handled in gmc_v9_0.c already */
+}
+
+static uint32_t mmhub_v9_4_get_invalidate_req(unsigned int vmid,
+					      uint32_t flush_type)
+{
+	u32 req = 0;
+
+	req = REG_SET_FIELD(req, VML2VC0_VM_INVALIDATE_ENG0_REQ,
+			    PER_VMID_INVALIDATE_REQ, 1 << vmid);
+	req = REG_SET_FIELD(req, VML2VC0_VM_INVALIDATE_ENG0_REQ, FLUSH_TYPE, flush_type);
+	req = REG_SET_FIELD(req, VML2VC0_VM_INVALIDATE_ENG0_REQ, INVALIDATE_L2_PTES, 1);
+	req = REG_SET_FIELD(req, VML2VC0_VM_INVALIDATE_ENG0_REQ, INVALIDATE_L2_PDE0, 1);
+	req = REG_SET_FIELD(req, VML2VC0_VM_INVALIDATE_ENG0_REQ, INVALIDATE_L2_PDE1, 1);
+	req = REG_SET_FIELD(req, VML2VC0_VM_INVALIDATE_ENG0_REQ, INVALIDATE_L2_PDE2, 1);
+	req = REG_SET_FIELD(req, VML2VC0_VM_INVALIDATE_ENG0_REQ, INVALIDATE_L1_PTES, 1);
+	req = REG_SET_FIELD(req, VML2VC0_VM_INVALIDATE_ENG0_REQ,
+			    CLEAR_PROTECTION_FAULT_STATUS_ADDR,	0);
+
+	return req;
+}
+
+static const struct amdgpu_vmhub_funcs mmhub_v9_4_vmhub_funcs = {
+	.print_l2_protection_fault_status = mmhub_v9_4_print_l2_protection_fault_status,
+	.get_invalidate_req = mmhub_v9_4_get_invalidate_req,
+};
+
 static void mmhub_v9_4_init(struct amdgpu_device *adev)
 {
 	struct amdgpu_vmhub *hub[MMHUB_NUM_INSTANCES] = {
@@ -584,6 +615,7 @@ static void mmhub_v9_4_init(struct amdgpu_device *adev)
 			mmVML2VC0_VM_INVALIDATE_ENG0_REQ;
 		hub[i]->eng_addr_distance = mmVML2VC0_VM_INVALIDATE_ENG1_ADDR_RANGE_LO32 -
 			mmVML2VC0_VM_INVALIDATE_ENG0_ADDR_RANGE_LO32;
+		hub[i]->vmhub_funcs = &mmhub_v9_4_vmhub_funcs;
 	}
 }
 
-- 
2.55.0

