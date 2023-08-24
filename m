Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75A5CC3DA6F
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Aug 2023 21:59:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0564D10E5DE;
	Thu, 24 Aug 2023 21:59:08 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2062b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::62b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EEA4A10E5E2
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Aug 2023 21:58:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X8G9f7jsdHVqxi3wbsXemHlL55HE+7mgFgoe8OsyfKrArP/aQUjxyGvh75bFdzMbqXGSok38b0VuQcbVHhU5/KIYtc7dybRzhXxsaA55aJM3Qgdnhp8ucPIKzfewkja75on5JHmRStckWbmk3z3YrC0YFxSLkKmmwQUvkFNcw7dpwShXyQf4STUE4waTuUU7bbiCCxWiqxSwMlBoWI4zHAAZ4B1JC39NbupQ0RxnibHHhcCV7xNgLBbKddAr55b0odzAsLYz4QQGznq7c6Ly4hSTMxp+U/Y2vo6FXpVRcx+3V5oiGCNPR0jte6TIE8pLtf2jN+LjuSp9PnxKcpnkSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aI0ExQ3sPvH4eDURlc+tnOT9H25UkoFWyR95YoVf5JU=;
 b=NIk4W/sQQIPhBj8ZYqltk2qTuDRKm93Z0dnGOEMSi6BO5nCDnN+aiO14tc5icgpUHNfxe3uAjb+x/7zHRdMbqrGCVvZw3i0uFj63LyJ9p5ViRwdMp49BKrNIVzpW9S/946XrAYKadS0al+PiynIXEp7tuSmDw+uk5kzEQ3mO/2myMV/cs+x8OW3wLSlRlSqv/lgogoCTz6e9X19cVHbT3L+S57xV1Yv1JnCmu2CgKVJrYRIq3iSfwcI8gzdyjxrTBnUlU/ABTNEODXhh1RAPrZZQHNjeTiwWyUU/Zg+4XMOogDvR3M9R6pdcsXFCmtfRYrtWGLC4vR9sKhNP6e29MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aI0ExQ3sPvH4eDURlc+tnOT9H25UkoFWyR95YoVf5JU=;
 b=MYRBaWadip02A4wrbrq6k9N0HtFB0SyDTxKl6qjPKhOUSa8nRtGdch8mOiz6y5x4RALaiozk4yhZBH8TBxdEofudBfuukGPr4w9+f5tQ61y7ZOn+gB3iMOCaQplQ91frLhTKw2QD5BxKtJnYkANf/mszCV783rycw/Oa0wFEyio=
Received: from DS0PR17CA0013.namprd17.prod.outlook.com (2603:10b6:8:191::11)
 by SJ1PR12MB6050.namprd12.prod.outlook.com (2603:10b6:a03:48b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Thu, 24 Aug
 2023 21:58:54 +0000
Received: from CY4PEPF0000EE37.namprd05.prod.outlook.com
 (2603:10b6:8:191:cafe::a1) by DS0PR17CA0013.outlook.office365.com
 (2603:10b6:8:191::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27 via Frontend
 Transport; Thu, 24 Aug 2023 21:58:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE37.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Thu, 24 Aug 2023 21:58:54 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 24 Aug
 2023 16:58:53 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/14] drm/amdgpu: add selftest framework for UMSCH
Date: Thu, 24 Aug 2023 17:58:29 -0400
Message-ID: <20230824215835.2740115-9-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230824215835.2740115-1-alexander.deucher@amd.com>
References: <20230824215835.2740115-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE37:EE_|SJ1PR12MB6050:EE_
X-MS-Office365-Filtering-Correlation-Id: 715b7f96-cd44-4027-21a1-08dba4ed4f18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m8rQBciC4Pq/vF8QlIHrMkljknvMiGfgS4B6vSu2D8RWvf703RxSpP0ag06CFYfFjYu0LZesBzOT5huKvN2FWb8UY0T7cx4NvwNfTqRcT7mg+/xWvOYpiXaRVR6KJZsjGqHcip+LLJszlNngWu2lXm+5Pqu1Dle3sg3Lnji/BGKhPgdsekWz7EjcoCGuCE+10gQ4tCNC9FsL+QdE/6KLr/AQrbsszIfxHtRZaxrOHQS3UbsYs3lAYyzuyAftMQKmGdZGDPFzyrOJDW8bDI49IHS0Q4l5asHUz7gBYc8k6FgxpIc5VcsnMkS6VT4uaEM5JRksw4WPs7WUpjkrLurMlQHuj9mnjjDge8q0nCjO3pu+4IeoiBPaIhhYLv1AFcSKRp9euJ8fdcSM8mv6ZB3crFSatr/hdvWaUtcaW+ygmL83BINt0NR5sGkx2P2nNVuu4GpPYbPL5jNJXBXGPIQG33HUeD2t45J/rzU0CtLE0ObYuv7sTftJsFI8fd/SVA+hftObf988+KGL1+q6klrKaycK/zVWBvI3Xbuk2HZCZV5vJg1td4VzhcJMcONAPL39jvDWl7zdXQk9f/eQ9WB9LFFwPYlzNoot7GJVkNpBVWGIin7xgLr03X0fijvDaxTwz1tclOG0T9uvFeR+yICisXpsca86n9aiisYuW1k4E/mNNoYAh/BlJb/COVu9OV+cO5sygLa9dJl8wU+YjvD4rl6LE3lUHX73YEAzRecFXuMYjqV7+EkgWXrzYfxkwCiqB6HkxxvXOpusJKmgFqP3lw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(136003)(39860400002)(346002)(376002)(186009)(1800799009)(451199024)(82310400011)(36840700001)(40470700004)(46966006)(54906003)(6916009)(316002)(70586007)(70206006)(8676002)(8936002)(4326008)(2616005)(36756003)(41300700001)(1076003)(40460700003)(81166007)(82740400003)(356005)(478600001)(6666004)(5660300002)(40480700001)(83380400001)(30864003)(2906002)(36860700001)(47076005)(7696005)(86362001)(336012)(426003)(16526019)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 21:58:54.3149 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 715b7f96-cd44-4027-21a1-08dba4ed4f18
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE37.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6050
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Leo Liu <leo.liu@amd.com>,
 Lang Yu <Lang.Yu@amd.com>, Veerabadhran
 Gopalakrishnan <Veerabadhran.Gopalakrishnan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lang Yu <Lang.Yu@amd.com>

Prepare for VPE and VCN queue submission test.

Signed-off-by: Lang Yu <Lang.Yu@amd.com>
Reviewed-by: Leo Liu <leo.liu@amd.com>
Reviewed-by: Veerabadhran Gopalakrishnan <Veerabadhran.Gopalakrishnan@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c | 406 ++++++++++++++++++-
 1 file changed, 405 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c
index 29457c503c85..ced963aaf7cf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umsch_mm.c
@@ -28,6 +28,408 @@
 #include "amdgpu_umsch_mm.h"
 #include "umsch_mm_v4_0.h"
 
+struct umsch_mm_test_ctx_data {
+	uint8_t process_csa[PAGE_SIZE];
+	uint8_t vpe_ctx_csa[PAGE_SIZE];
+	uint8_t vcn_ctx_csa[PAGE_SIZE];
+};
+
+struct umsch_mm_test_mqd_data {
+	uint8_t vpe_mqd[PAGE_SIZE];
+	uint8_t vcn_mqd[PAGE_SIZE];
+};
+
+struct umsch_mm_test_ring_data {
+	uint8_t vpe_ring[PAGE_SIZE];
+	uint8_t vpe_ib[PAGE_SIZE];
+	uint8_t vcn_ring[PAGE_SIZE];
+	uint8_t vcn_ib[PAGE_SIZE];
+};
+
+struct umsch_mm_test_queue_info {
+	uint64_t mqd_addr;
+	uint64_t csa_addr;
+	uint32_t doorbell_offset_0;
+	uint32_t doorbell_offset_1;
+	enum UMSCH_SWIP_ENGINE_TYPE engine;
+};
+
+struct umsch_mm_test {
+	struct amdgpu_bo	*ctx_data_obj;
+	uint64_t		ctx_data_gpu_addr;
+	uint32_t		*ctx_data_cpu_addr;
+
+	struct amdgpu_bo	*mqd_data_obj;
+	uint64_t		mqd_data_gpu_addr;
+	uint32_t		*mqd_data_cpu_addr;
+
+	struct amdgpu_bo	*ring_data_obj;
+	uint64_t		ring_data_gpu_addr;
+	uint32_t		*ring_data_cpu_addr;
+
+
+	struct amdgpu_vm	*vm;
+	struct amdgpu_bo_va	*bo_va;
+	uint32_t		pasid;
+	uint32_t		vm_cntx_cntl;
+	uint32_t		num_queues;
+};
+
+static int map_ring_data(struct amdgpu_device *adev, struct amdgpu_vm *vm,
+			  struct amdgpu_bo *bo, struct amdgpu_bo_va **bo_va,
+			  uint64_t addr, uint32_t size)
+{
+	struct ww_acquire_ctx ticket;
+	struct list_head list;
+	struct amdgpu_bo_list_entry pd;
+	struct ttm_validate_buffer csa_tv;
+	struct amdgpu_sync sync;
+	int r;
+
+	INIT_LIST_HEAD(&list);
+	INIT_LIST_HEAD(&csa_tv.head);
+	csa_tv.bo = &bo->tbo;
+	csa_tv.num_shared = 1;
+
+	list_add(&csa_tv.head, &list);
+	amdgpu_vm_get_pd_bo(vm, &list, &pd);
+
+	amdgpu_sync_create(&sync);
+
+	r = ttm_eu_reserve_buffers(&ticket, &list, true, NULL);
+	if (r)
+		return r;
+
+	*bo_va = amdgpu_vm_bo_add(adev, vm, bo);
+	if (!*bo_va) {
+		ttm_eu_backoff_reservation(&ticket, &list);
+		return -ENOMEM;
+	}
+
+	r = amdgpu_vm_bo_map(adev, *bo_va, addr, 0, size,
+			     AMDGPU_PTE_READABLE | AMDGPU_PTE_WRITEABLE |
+			     AMDGPU_PTE_EXECUTABLE);
+
+	if (r) {
+		amdgpu_vm_bo_del(adev, *bo_va);
+		ttm_eu_backoff_reservation(&ticket, &list);
+		return r;
+	}
+
+
+	r = amdgpu_vm_bo_update(adev, *bo_va, false);
+	if (r)
+		goto error;
+
+	amdgpu_sync_fence(&sync, (*bo_va)->last_pt_update);
+
+	r = amdgpu_vm_update_pdes(adev, vm, false);
+	if (r)
+		goto error;
+
+	amdgpu_sync_fence(&sync, vm->last_update);
+
+	amdgpu_sync_wait(&sync, false);
+
+	ttm_eu_backoff_reservation(&ticket, &list);
+	amdgpu_sync_free(&sync);
+
+	return 0;
+error:
+	ttm_eu_backoff_reservation(&ticket, &list);
+	amdgpu_sync_free(&sync);
+	return r;
+}
+
+static int unmap_ring_data(struct amdgpu_device *adev, struct amdgpu_vm *vm,
+			    struct amdgpu_bo *bo, struct amdgpu_bo_va *bo_va,
+			    uint64_t addr)
+{
+	struct ww_acquire_ctx ticket;
+	struct list_head list;
+	struct amdgpu_bo_list_entry pd;
+	struct ttm_validate_buffer csa_tv;
+	int r;
+
+	INIT_LIST_HEAD(&list);
+	INIT_LIST_HEAD(&csa_tv.head);
+	csa_tv.bo = &bo->tbo;
+	csa_tv.num_shared = 1;
+
+	list_add(&csa_tv.head, &list);
+	amdgpu_vm_get_pd_bo(vm, &list, &pd);
+
+	r = ttm_eu_reserve_buffers(&ticket, &list, true, NULL);
+	if (r)
+		return r;
+
+	r = amdgpu_vm_bo_unmap(adev, bo_va, addr);
+	if (r) {
+		ttm_eu_backoff_reservation(&ticket, &list);
+		return r;
+	}
+
+	amdgpu_vm_bo_del(adev, bo_va);
+
+	ttm_eu_backoff_reservation(&ticket, &list);
+
+	return 0;
+}
+
+static void setup_vpe_queue(struct amdgpu_device *adev,
+			    struct umsch_mm_test *test,
+			    struct umsch_mm_test_queue_info *qinfo)
+{
+}
+
+static void setup_vcn_queue(struct amdgpu_device *adev,
+			    struct umsch_mm_test *test,
+			    struct umsch_mm_test_queue_info *qinfo)
+{
+}
+
+static int add_test_queue(struct amdgpu_device *adev,
+			  struct umsch_mm_test *test,
+			  struct umsch_mm_test_queue_info *qinfo)
+{
+	struct umsch_mm_add_queue_input queue_input = {};
+	int r;
+
+	queue_input.process_id = test->pasid;
+	queue_input.page_table_base_addr = amdgpu_gmc_pd_addr(test->vm->root.bo);
+
+	queue_input.process_va_start = 0;
+	queue_input.process_va_end = (adev->vm_manager.max_pfn - 1) << AMDGPU_GPU_PAGE_SHIFT;
+
+	queue_input.process_quantum = 100000; /* 10ms */
+	queue_input.process_csa_addr = test->ctx_data_gpu_addr +
+				       offsetof(struct umsch_mm_test_ctx_data, process_csa);
+
+	queue_input.context_quantum = 10000; /* 1ms */
+	queue_input.context_csa_addr = qinfo->csa_addr;
+
+	queue_input.inprocess_context_priority = CONTEXT_PRIORITY_LEVEL_NORMAL;
+	queue_input.context_global_priority_level = CONTEXT_PRIORITY_LEVEL_NORMAL;
+	queue_input.doorbell_offset_0 = qinfo->doorbell_offset_0;
+	queue_input.doorbell_offset_1 = qinfo->doorbell_offset_1;
+
+	queue_input.engine_type = qinfo->engine;
+	queue_input.mqd_addr = qinfo->mqd_addr;
+	queue_input.vm_context_cntl = test->vm_cntx_cntl;
+
+	amdgpu_umsch_mm_lock(&adev->umsch_mm);
+	r = adev->umsch_mm.funcs->add_queue(&adev->umsch_mm, &queue_input);
+	amdgpu_umsch_mm_unlock(&adev->umsch_mm);
+	if (r)
+		return r;
+
+	return 0;
+}
+
+static int remove_test_queue(struct amdgpu_device *adev,
+			     struct umsch_mm_test *test,
+			     struct umsch_mm_test_queue_info *qinfo)
+{
+	struct umsch_mm_remove_queue_input queue_input = {};
+	int r;
+
+	queue_input.doorbell_offset_0 = qinfo->doorbell_offset_0;
+	queue_input.doorbell_offset_1 = qinfo->doorbell_offset_1;
+	queue_input.context_csa_addr = qinfo->csa_addr;
+
+	amdgpu_umsch_mm_lock(&adev->umsch_mm);
+	r = adev->umsch_mm.funcs->remove_queue(&adev->umsch_mm, &queue_input);
+	amdgpu_umsch_mm_unlock(&adev->umsch_mm);
+	if (r)
+		return r;
+
+	return 0;
+}
+
+static int submit_vpe_queue(struct amdgpu_device *adev, struct umsch_mm_test *test)
+{
+	return 0;
+}
+
+static int submit_vcn_queue(struct amdgpu_device *adev, struct umsch_mm_test *test)
+{
+	return 0;
+}
+
+static int setup_umsch_mm_test(struct amdgpu_device *adev,
+			  struct umsch_mm_test *test)
+{
+	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_MMHUB0(0)];
+	int r;
+
+	test->vm_cntx_cntl = hub->vm_cntx_cntl;
+
+	test->vm = kzalloc(sizeof(*test->vm), GFP_KERNEL);
+	if (!test->vm) {
+		r = -ENOMEM;
+		return r;
+	}
+
+	r = amdgpu_vm_init(adev, test->vm, -1);
+	if (r)
+		goto error_free_vm;
+
+	test->pasid = amdgpu_pasid_alloc(16);
+	if (test->pasid < 0) {
+		r = test->pasid;
+		goto error_fini_vm;
+	}
+
+	r = amdgpu_bo_create_kernel(adev, sizeof(struct umsch_mm_test_ctx_data),
+				    PAGE_SIZE, AMDGPU_GEM_DOMAIN_GTT,
+				    &test->ctx_data_obj,
+				    &test->ctx_data_gpu_addr,
+				    (void **)&test->ctx_data_cpu_addr);
+	if (r)
+		goto error_free_pasid;
+
+	memset(test->ctx_data_cpu_addr, 0, sizeof(struct umsch_mm_test_ctx_data));
+
+	r = amdgpu_bo_create_kernel(adev, PAGE_SIZE,
+				    PAGE_SIZE, AMDGPU_GEM_DOMAIN_GTT,
+				    &test->mqd_data_obj,
+				    &test->mqd_data_gpu_addr,
+				    (void **)&test->mqd_data_cpu_addr);
+	if (r)
+		goto error_free_ctx_data_obj;
+
+	memset(test->mqd_data_cpu_addr, 0, PAGE_SIZE);
+
+	r = amdgpu_bo_create_kernel(adev, sizeof(struct umsch_mm_test_ring_data),
+				    PAGE_SIZE, AMDGPU_GEM_DOMAIN_GTT,
+				    &test->ring_data_obj,
+				    NULL,
+				    (void **)&test->ring_data_cpu_addr);
+	if (r)
+		goto error_free_mqd_data_obj;
+
+	memset(test->ring_data_cpu_addr, 0, sizeof(struct umsch_mm_test_ring_data));
+
+	test->ring_data_gpu_addr = AMDGPU_VA_RESERVED_SIZE;
+	r = map_ring_data(adev, test->vm, test->ring_data_obj, &test->bo_va,
+			  test->ring_data_gpu_addr, sizeof(struct umsch_mm_test_ring_data));
+	if (r)
+		goto error_free_ring_data_obj;
+
+	return 0;
+
+error_free_ring_data_obj:
+	amdgpu_bo_free_kernel(&test->ring_data_obj, NULL,
+			      (void **)&test->ring_data_cpu_addr);
+error_free_mqd_data_obj:
+	amdgpu_bo_free_kernel(&test->mqd_data_obj, &test->mqd_data_gpu_addr,
+			      (void **)&test->mqd_data_cpu_addr);
+error_free_ctx_data_obj:
+	amdgpu_bo_free_kernel(&test->ctx_data_obj, &test->ctx_data_gpu_addr,
+			      (void **)&test->ctx_data_cpu_addr);
+error_free_pasid:
+	amdgpu_pasid_free(test->pasid);
+error_fini_vm:
+	amdgpu_vm_fini(adev, test->vm);
+error_free_vm:
+	kfree(test->vm);
+
+	return r;
+}
+
+static void cleanup_umsch_mm_test(struct amdgpu_device *adev,
+				  struct umsch_mm_test *test)
+{
+	unmap_ring_data(adev, test->vm, test->ring_data_obj,
+			test->bo_va, test->ring_data_gpu_addr);
+	amdgpu_bo_free_kernel(&test->mqd_data_obj, &test->mqd_data_gpu_addr,
+			      (void **)&test->mqd_data_cpu_addr);
+	amdgpu_bo_free_kernel(&test->ring_data_obj, NULL,
+			      (void **)&test->ring_data_cpu_addr);
+	amdgpu_bo_free_kernel(&test->ctx_data_obj, &test->ctx_data_gpu_addr,
+			       (void **)&test->ctx_data_cpu_addr);
+	amdgpu_pasid_free(test->pasid);
+	amdgpu_vm_fini(adev, test->vm);
+	kfree(test->vm);
+}
+
+static int setup_test_queues(struct amdgpu_device *adev,
+			     struct umsch_mm_test *test,
+			     struct umsch_mm_test_queue_info *qinfo)
+{
+	int i, r;
+
+	for (i = 0; i < test->num_queues; i++) {
+		if (qinfo[i].engine == UMSCH_SWIP_ENGINE_TYPE_VPE)
+			setup_vpe_queue(adev, test, &qinfo[i]);
+		else
+			setup_vcn_queue(adev, test, &qinfo[i]);
+
+		r = add_test_queue(adev, test, &qinfo[i]);
+		if (r)
+			return r;
+	}
+
+	return 0;
+}
+
+static int submit_test_queues(struct amdgpu_device *adev,
+			      struct umsch_mm_test *test,
+			      struct umsch_mm_test_queue_info *qinfo)
+{
+	int i, r;
+
+	for (i = 0; i < test->num_queues; i++) {
+		if (qinfo[i].engine == UMSCH_SWIP_ENGINE_TYPE_VPE)
+			r = submit_vpe_queue(adev, test);
+		else
+			r = submit_vcn_queue(adev, test);
+		if (r)
+			return r;
+	}
+
+	return 0;
+}
+
+static void cleanup_test_queues(struct amdgpu_device *adev,
+			      struct umsch_mm_test *test,
+			      struct umsch_mm_test_queue_info *qinfo)
+{
+	int i;
+
+	for (i = 0; i < test->num_queues; i++)
+		remove_test_queue(adev, test, &qinfo[i]);
+}
+
+static int umsch_mm_test(struct amdgpu_device *adev)
+{
+	struct umsch_mm_test_queue_info qinfo[] = {};
+	struct umsch_mm_test test = { .num_queues = ARRAY_SIZE(qinfo) };
+	int r;
+
+	r = setup_umsch_mm_test(adev, &test);
+	if (r)
+		return r;
+
+	r = setup_test_queues(adev, &test, qinfo);
+	if (r)
+		goto cleanup;
+
+	r = submit_test_queues(adev, &test, qinfo);
+	if (r)
+		goto cleanup;
+
+	cleanup_test_queues(adev, &test, qinfo);
+	cleanup_umsch_mm_test(adev, &test);
+
+	return 0;
+
+cleanup:
+	cleanup_test_queues(adev, &test, qinfo);
+	cleanup_umsch_mm_test(adev, &test);
+	return r;
+}
+
 int amdgpu_umsch_mm_submit_pkt(struct amdgpu_umsch_mm *umsch, void *pkt, int ndws)
 {
 	struct amdgpu_ring *ring = &umsch->ring;
@@ -272,7 +674,9 @@ static int umsch_mm_early_init(void *handle)
 
 static int umsch_mm_late_init(void *handle)
 {
-	return 0;
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+
+	return umsch_mm_test(adev);
 }
 
 static int umsch_mm_sw_init(void *handle)
-- 
2.41.0

