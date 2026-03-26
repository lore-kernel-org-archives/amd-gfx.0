Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BF4D106F2E7
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Mar 2026 07:54:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96E6810E2E1;
	Thu, 26 Mar 2026 07:54:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xqn5Kfn1";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010033.outbound.protection.outlook.com [52.101.61.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95D6A10E169
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 07:54:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MGBb+6TON3xO+DofWQjT3v26NQSAnBhUG/ORhtMn16VcLVoPT9H8lQ742ty/qwt/bw/M7D/gcZLC3vcoEBD9ZBCyhYmC+Yt34d4jULD+oOvkWBIXfzXZCP6j5bEf/uPJMtffwNUBXATUVkc6cyXSgvRzLEKfjvsIh5jUlknw5ERuogiS7qM0DiMQt0yLCwZKdwkI9/+lXFyWROXnaOhAaA38wDbspoQZS6AQe7UHlUIB3W8l6wiiqK1IWt6rY5bm6MU/SThHb++H/5a/8/r/j/KFXizCzLap6N9Bf01+gFKYEKfgEAICf9LHN9YJLr7Sd+6/t3ybq/Ocs5GBP/S5DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wELNS4u1c+POZRam1bYJqc5Zvf+WuCBg6HMA3pUczI0=;
 b=b8LisAhRil8dDV4IsUfroddcgL5IPRu0MvgmZVRzxAJeDspgqvWt1T8mhgY6hCiNLStH1re4U7yDZVq2MOzWX+TAKOCnFe1ksdfeqf21ooMT+tWjQ+9X1+FfHD57s4U81lQJp480NN6RliQAX1KBuzUnDFswFbwEhL2sNNaDoufMWmWbdKJ5TZ5rrNTsdNNmLvV1Vi6IP/lEn12qPEz+sEm3P+Yx7j5Prg9z8/q2AtLxrHASSd/kQdX+KgmhI4L9trvjmUn7IwnhFlMbevMr2VD9u9I+glBzzuS6g0EqWYU0j3nS5duM5ez7cnC+bq8zmOkLsXnO+U8VsdOsDEMfsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wELNS4u1c+POZRam1bYJqc5Zvf+WuCBg6HMA3pUczI0=;
 b=xqn5Kfn1ORt+pKpVtS+mHdbEHYx6flBkQGBDHctsypqsCQC5aJTq5PZy5CZcA27BT0RJyplcmgXRlJyp4mvVWj4LPc+bVVejzCJCR1CgjN3o1IJW3z8emezHXNQYuKynmRMF7SaqdzUwZBuIUPtfw0Ua89sqJKci5TnEbgNgq8o=
Received: from IA1P220CA0023.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:464::7)
 by PH7PR12MB6657.namprd12.prod.outlook.com (2603:10b6:510:1fe::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Thu, 26 Mar
 2026 07:54:45 +0000
Received: from BN1PEPF0000468C.namprd05.prod.outlook.com
 (2603:10b6:208:464:cafe::bd) by IA1P220CA0023.outlook.office365.com
 (2603:10b6:208:464::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.22 via Frontend Transport; Thu,
 26 Mar 2026 07:54:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF0000468C.mail.protection.outlook.com (10.167.243.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Thu, 26 Mar 2026 07:54:44 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 26 Mar
 2026 02:54:42 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <Feifei.Xu@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 01/14] drm/amdgpu: Add reserved region ids
Date: Thu, 26 Mar 2026 13:15:22 +0530
Message-ID: <20260326075412.1378411-2-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260326075412.1378411-1-lijo.lazar@amd.com>
References: <20260326075412.1378411-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468C:EE_|PH7PR12MB6657:EE_
X-MS-Office365-Filtering-Correlation-Id: 77044db4-0850-48a4-3173-08de8b0cf1b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: QBpMi1Q/WQxj8431eZC2v6F56Z4ggNBLmADItYZXoT+DEmuCmvNiT6xVMBpDk1vDXMpjwV+rMtOkeCEwPFy0IrkzSJBGbO+x8OuU+f5/MRkmmVqGz87lxBTCRMktVqhwmNTeUyeObFTOicWYTJEDfxw36PUK+8L82b7py3kcWGohJHEZKLJfQwyLZQg81OQQnmJWXdWNMZlmH3cxG8ERT9NZ+NjiJyYbSyluTdZAs0vrxKK5KXGh4etwxrnqfo4zcsyFac8ytW4N6w7wA360oIqz8KlhOddBZvdzQiBC2jkpn/1kxekBGhTGJaR+F3cAwVtHhSuUdjTR4S/GQMO1AGMkD3XlsVUTs0m7hbimnr49+wMuV8Anlkb0EKjbzeWTs+6QCYJ4iuiUf3Y9KDB8ytXqyiWtafUGDltbBfWTVzQukkLRBdFZuzsJxh43ok41W1xv7MqITNi5rnX+sm1ovvCjR01BU3g+fJdCCklN7mBBTJYiodxswTSdS0JKA5E/dkcqExMtRUVHQPX/87JugwV9FFD2iB4MWhBomyOoZE76vACGRUHMbwOzrG9IlFVOGXe7TWtzKhD3D/dBHaV404XRR+WtsVzyv5vhuNyXPpT8mtbxQXG7Itb1roDrT6ksY8am4v5n2lx1I0u5vWNe6H++goVIuMt1Kim2iWXNzd5E/gxmSkfiRW+XgITerJwvGptd6LRMnOxoTNc0/ai0NAAyNt3uKt4iUokT/BiBoff3I+RdUugj0vNRo9NUH6vFW68RucmytAlHqWbvvz4HmQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: uMhIG6jgNiGovmmuUhAVoqx16EeBbXGYicS/9S87FoniCRUMtYMYw/Ipv7dErUEI8wGxLtSPFVwUICMODs++fhz4xYUKileyG4Y+mExhKF8KVvLBp+BtROwnqlXOEEm+HHFi7T2RAs3/IP98bY8TYriWdPIrIQ0s55O6JhyoiKS6nYe/Zrwc9CSmc1tfW894bdg3tSueOhBrJg+DCbjvazDm309g/CJtNi4c2n0gBtHQp6ops74vDhiKReeF+jAdNCLuqd+mV8iftBe6OYEEjMkCq36fTUubRGgFe3zGi9uDG0scCYLWnEtYIfIjBvDNnMo03BZxWTjFWg5M9dYQoY+bbUlTH0CnzpV5P5qr/1W6Mgs2+8TkxZv1WBUaD6pstNj5Wn8QpCDiQIzvDxbhhvd0/gNsAfb+aZ8Gfbg5fJ2qfUe/bgjSppTGEzdqbHAq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 07:54:44.3939 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 77044db4-0850-48a4-3173-08de8b0cf1b7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6657
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

Add reserved regions and helper functions to memory manager.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 58 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h | 31 +++++++++++++
 2 files changed, 89 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 714fd8d12ca5..45011176d4cf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1677,6 +1677,64 @@ static struct ttm_device_funcs amdgpu_bo_driver = {
 	.access_memory = &amdgpu_ttm_access_memory,
 };
 
+void amdgpu_ttm_init_vram_resv(struct amdgpu_device *adev,
+				enum amdgpu_resv_region_id id,
+				uint64_t offset, uint64_t size,
+				bool needs_cpu_map)
+{
+	struct amdgpu_vram_resv *resv;
+
+	if (id >= AMDGPU_RESV_MAX)
+		return;
+
+	resv = &adev->mman.resv_region[id];
+	resv->offset = offset;
+	resv->size = size;
+	resv->needs_cpu_map = needs_cpu_map;
+}
+
+int amdgpu_ttm_mark_vram_reserved(struct amdgpu_device *adev,
+				  enum amdgpu_resv_region_id id)
+{
+	struct amdgpu_vram_resv *resv;
+	int ret;
+
+	if (id >= AMDGPU_RESV_MAX)
+		return -EINVAL;
+
+	resv = &adev->mman.resv_region[id];
+	if (!resv->size)
+		return 0;
+
+	ret = amdgpu_bo_create_kernel_at(adev, resv->offset, resv->size,
+					 &resv->bo,
+					 resv->needs_cpu_map ? &resv->cpu_ptr : NULL);
+	if (ret) {
+		dev_dbg(adev->dev, "reserve vram failed: id=%d offset=0x%llx size=0x%llx ret=%d\n",
+			id, resv->offset, resv->size, ret);
+		memset(resv, 0, sizeof(*resv));
+	}
+
+	return ret;
+}
+
+void amdgpu_ttm_unmark_vram_reserved(struct amdgpu_device *adev,
+				     enum amdgpu_resv_region_id id)
+{
+	struct amdgpu_vram_resv *resv;
+
+	if (id >= AMDGPU_RESV_MAX)
+		return;
+
+	resv = &adev->mman.resv_region[id];
+	if (!resv->bo)
+		return;
+
+	amdgpu_bo_free_kernel(&resv->bo, NULL,
+			      resv->needs_cpu_map ? &resv->cpu_ptr : NULL);
+	memset(resv, 0, sizeof(*resv));
+}
+
 /*
  * Firmware Reservation functions
  */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
index bf101215757e..e8fe34751bbd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
@@ -59,6 +59,26 @@ struct amdgpu_ttm_buffer_entity {
 	u64			gart_window_offs[2];
 };
 
+enum amdgpu_resv_region_id {
+	AMDGPU_RESV_STOLEN_VGA,
+	AMDGPU_RESV_STOLEN_EXTENDED,
+	AMDGPU_RESV_STOLEN_RESERVED,
+	AMDGPU_RESV_FW,
+	AMDGPU_RESV_FW_EXTEND,
+	AMDGPU_RESV_FW_VRAM_USAGE,
+	AMDGPU_RESV_DRV_VRAM_USAGE,
+	AMDGPU_RESV_MEM_TRAIN,
+	AMDGPU_RESV_MAX
+};
+
+struct amdgpu_vram_resv {
+	uint64_t		offset;
+	uint64_t		size;
+	struct amdgpu_bo	*bo;
+	void			*cpu_ptr;
+	bool			needs_cpu_map;
+};
+
 struct amdgpu_mman {
 	struct ttm_device		bdev;
 	struct ttm_pool			*ttm_pools;
@@ -105,6 +125,8 @@ struct amdgpu_mman {
 	struct amdgpu_bo	*drv_vram_usage_reserved_bo;
 	void		*drv_vram_usage_va;
 
+	struct amdgpu_vram_resv		resv_region[AMDGPU_RESV_MAX];
+
 	/* PAGE_SIZE'd BO for process memory r/w over SDMA. */
 	struct amdgpu_bo	*sdma_access_bo;
 	void			*sdma_access_ptr;
@@ -171,6 +193,15 @@ void amdgpu_vram_mgr_clear_reset_blocks(struct amdgpu_device *adev);
 bool amdgpu_res_cpu_visible(struct amdgpu_device *adev,
 			    struct ttm_resource *res);
 
+void amdgpu_ttm_init_vram_resv(struct amdgpu_device *adev,
+				enum amdgpu_resv_region_id id,
+				uint64_t offset, uint64_t size,
+				bool needs_cpu_map);
+int amdgpu_ttm_mark_vram_reserved(struct amdgpu_device *adev,
+				  enum amdgpu_resv_region_id id);
+void amdgpu_ttm_unmark_vram_reserved(struct amdgpu_device *adev,
+				     enum amdgpu_resv_region_id id);
+
 int amdgpu_ttm_init(struct amdgpu_device *adev);
 void amdgpu_ttm_fini(struct amdgpu_device *adev);
 void amdgpu_ttm_set_buffer_funcs_status(struct amdgpu_device *adev,
-- 
2.49.0

