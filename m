Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38E2B106B53F
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2026 14:14:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C47FC10E843;
	Wed, 25 Mar 2026 14:14:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="efIR4tSm";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010062.outbound.protection.outlook.com
 [40.93.198.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BEA4510E843
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Mar 2026 14:14:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n9gyiEG4fqqGStR8iHJbGCBDRcXm8EWbkl1deL4H3axtsjDxMS+4zlFqdom95btGPWCScXrrd/HR85xeANn2onUoi+Bt4LjYJ8xoQ308nCmKKHasAmX3QtXx0GgwZvOT9prQzd0yTWF6VKzTKiHSfrK+WmSHN0SKwZxdXZiSRYVoO0ZfiisYbMo0hcTKeRU8HCXsSl4/AezHWSvwHyK8J0tZNYKTyuYNsvjIBM9rO9Sul2d6erYwNVM/NCg5fSTzjRXI56n9Cnh86it14jvGV0EaaHzQ3FGcnh7I7RdHwRc0mCac07nujkx/ko+AJYlISRtGTSagxJWztASjBmHHNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vV+4yKGhJ7MWGgiyvIKvDGV1E5OfTSzaX7PifQEOsPs=;
 b=C6leG82dHi0WenKfjMHrnjOFZWplJMqixSpy5vtQYnyziZcLeQDkDmJANpwYcmq4fvYMowSkc3k65TjYvK/B3bnvsamz+77QBG4DvBPBFEDYarlewhvV+Me19NB3D5QTvMV9ifIXs8lyVRZek84oYfUh5yQYmPipWaZpQUJgDBffMF1UM44CSCSo8CYYP07yhexjXsM6JpyzOBIs0/VJNumtgRZcNvNzvepNJOtlb17IJpq6iChgIswjYqtZAO96ICAaDwTwhwq4N2cSbeItWm+iexnNbaGEUCucLwAYMaLIGWud7i7xm5vgYIO6XqCDOJSEoM+APrfc1R6ddzBrhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vV+4yKGhJ7MWGgiyvIKvDGV1E5OfTSzaX7PifQEOsPs=;
 b=efIR4tSm0lM/Z8rRgPkIfOuX9HlK5j877w+aVAcpnsgozl8feEJ5ITGD3cqEkSLc2SMpErBquMCIxtdveSfLRKO+evL7QkbaPmxm+FxKMDmQuudvz+WsL1Ns0T2pFk19v3Mwf+Xwof98/kaAmOFMgci0Xli//Z+gE8foGJdzflk=
Received: from SJ0PR05CA0043.namprd05.prod.outlook.com (2603:10b6:a03:33f::18)
 by BN7PPF39B20C1D8.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6cc) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 14:12:50 +0000
Received: from SJ1PEPF00001CE1.namprd05.prod.outlook.com
 (2603:10b6:a03:33f:cafe::93) by SJ0PR05CA0043.outlook.office365.com
 (2603:10b6:a03:33f::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Wed,
 25 Mar 2026 14:12:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CE1.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Wed, 25 Mar 2026 14:12:50 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 25 Mar
 2026 09:12:47 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <Feifei.Xu@amd.com>
Subject: [PATCH 1/9] drm/amdgpu: Add reserved region ids
Date: Wed, 25 Mar 2026 19:42:18 +0530
Message-ID: <20260325141226.1173216-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE1:EE_|BN7PPF39B20C1D8:EE_
X-MS-Office365-Filtering-Correlation-Id: f74c085b-4e7b-4e3e-780a-08de8a78990b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|82310400026|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: MJFR8YyJduYOOqL+GH/Dm4WXxv5/F2WWEPyoC6pqxtiiLlz8cvNUOphNpmvjF50uUuL/Vhz2fgKWNdMc3HwYsokjaFCR48eGlKONwgDgP/7slUQ4CrdBM+umVQ38KDjqgJIaa3q7Kb1MS0plFrCrkAKYPqGuJYMOwP+b1ADUSIWc4cIYF+3rDwsEqkKxluZejf5pMyg3KhpVxuT19kxbflBIjD709sJ9f1U6NAtnPNL4SXHLQlfqXbocb5z+3kKkvf5LXy6RE86HLgMrsJa3J2nggHlxeuuBAe+5+c31bjX2SDX+7FRw+Mq2IBLKucCP80rr5Qs6dtB9GzWseIydk/GLCGssPTHOy4QqqEq22JmgOJ4cKDcAir58CHYWH3Jxg4alOr1Pn9Qx/MVTUexKpwY3UMPMMnwvyazOHZ3a9pXClKF6E3ehoBxuyRqChK4rloX6KINrDeP/ZHZuSTH1MhIQrFsqT5fbGf+sezUxfpJSoXNdEvnc3dz/0arMrNaqwM58F++bCn4wUmgHKuZpGqKlFPAH0N+njYbzSZLIrr0yleP9/+0ZPbnfi6ia+5ZbkDWRn3XKVR6EKzSbwebhw2a2KIUxg0z3yrfxMKcSiMWk/7D2740wHv5lZlK6FcNeLYaoi59pDrCWflCaPAk1elKBurK/REDHqHkor9XD0moyvM8daQGSWSeTp7HCnLmC0nPRFjKlpPRw6muJTnxOBWK1ARbsOjb0N9QqHVmkbfuneulsVkp2NTRpG1fRzDsM7Lepwwjg9VO9UNyhV1FUTQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: PNf9ulFxzsVWdajFJ31A052XtuU6VKJwDeonCSfkKUCRci8/rN/yRL0KDd8/AaqysasImJ8hCLu2Ea2iLZCo1lKoUMz6IVqfofx0BS578bzpdY5lOYqLseEYxaIByQvIPHwoTxbyQiFCTJlBu+LcxTiSP9gBD3i67kPUCqUFOEjYZWavMjpDkWcdxYP3dA5QWojc+5Jd4SvXeQ7x+5dpLCKpqB9RsHvc77EeL3BKiM63xdUlBG7BCxIZ+bS8CieaLCvkWQrTZbDeL70rY0uGg6qoDUG4poETizOueRDm83hojKBeTQP5KouCPfX5gXEs8QoDbExK8tVtShH3wvpdjtB3qgx7AZcRqjlnVgxNcVMsgpkILuddcKPkAvBoirnFlL/gco3fIJPEwuecqDCJVKoeprZUaN+euz4bEk+DgXZyxVzlrSVSKSLBEieehbRV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 14:12:50.0377 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f74c085b-4e7b-4e3e-780a-08de8a78990b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF39B20C1D8
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
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 58 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h | 31 +++++++++++++
 2 files changed, 89 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 714fd8d12ca5..7f04e53983b5 100644
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
+int amdgpu_ttm_reserve_vram(struct amdgpu_device *adev,
+			    enum amdgpu_resv_region_id id)
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
+					 resv->needs_cpu_map ? &resv->cpu_addr : NULL);
+	if (ret) {
+		dev_dbg(adev->dev, "reserve vram failed: id=%d offset=0x%llx size=0x%llx ret=%d\n",
+			id, resv->offset, resv->size, ret);
+		memset(resv, 0, sizeof(*resv));
+	}
+
+	return ret;
+}
+
+void amdgpu_ttm_unreserve_vram(struct amdgpu_device *adev,
+			       enum amdgpu_resv_region_id id)
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
+			      resv->needs_cpu_map ? &resv->cpu_addr : NULL);
+	memset(resv, 0, sizeof(*resv));
+}
+
 /*
  * Firmware Reservation functions
  */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
index bf101215757e..b73f65a4bc0d 100644
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
+	void			*cpu_addr;
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
+int amdgpu_ttm_reserve_vram(struct amdgpu_device *adev,
+			    enum amdgpu_resv_region_id id);
+void amdgpu_ttm_unreserve_vram(struct amdgpu_device *adev,
+			       enum amdgpu_resv_region_id id);
+
 int amdgpu_ttm_init(struct amdgpu_device *adev);
 void amdgpu_ttm_fini(struct amdgpu_device *adev);
 void amdgpu_ttm_set_buffer_funcs_status(struct amdgpu_device *adev,
-- 
2.49.0

