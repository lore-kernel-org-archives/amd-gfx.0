Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C039C61DA4
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Feb 2023 19:09:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7621410E8A9;
	Fri,  3 Feb 2023 19:09:36 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2069.outbound.protection.outlook.com [40.107.237.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C36B10E8A8
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Feb 2023 19:09:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Eb9hRyQ3kleJbbOHxqd8GG8rwXb9QvXVV+FIMMdm+x+XaYT6JEc1wziBvrBnWW9VmIHyscoajKOjQtgB/one8zxq9vNIejzWyyQAv5LbDTdYG8j+QeBQW3weHu8SIDIMpk6pOmdU9+QdXpgSlN7rP2hatBjt0e80/G9ovu2XH6YbucRirKZ810oa+r3CBE0W9mSB6h1kKeuE5R1Bi0Z7ZX3tKj4/o8OEsa70YFseN7OUPjFmX/mX+LRVZamJtwZAe7dX6feky74vRK7R2XkXh+JbQOEN80x3sXd3OxA1lC8hoa7us3T7XFCXRpGtj2KbOI+YAwT4grPtwICo9jJabg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0rLsHG9zujoeFqXj79X1RDBgQoZgGd2/9MhUAmXeMEg=;
 b=kqAIjSHJ6Vv5hr7kM8iaHitV/EUzsQIBJlGvELL7hcHIlymfmR3oMaM0FYe7TFVHCskV8UAH4KQ/3XdSiewkRxA5OqLn51f7bl4VrSLcw6D/WRG5HVVgsVtUIp6TF1XgtI9DBoT0OQMgLq3kamQEv9MOI+fZl/oVq2u5udwYktibt0vNoCVy+v7H4d5cuaPE+03MzE8qChMJomReOKkjj+4Q8FIcdTBF65p5CNlUhEKYJcIEO3A6v+x4LDXRSUfttqa5pCfMpzz7M0DfpSV2zT+/A7Zl1I3IDJoRMJ2ZKZriY18KnIvsc6zWJjhC3XB53h4TZiYowsADOUr9b+x2Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0rLsHG9zujoeFqXj79X1RDBgQoZgGd2/9MhUAmXeMEg=;
 b=QvbWeXBqfuCB1AUI2eG0hsu7W4XPdTX5erACcUDwxoxEy7FkPiqGxGHVbh0SOKr5vhAex1s9tduN40JOsVPgTeKeiFtuSaYbasD1CQKJPiIkLK1QNKk0kTXk3Sp7ozE5kPq4Oyk5DZDVVqK93HV/5JSPyD5JlRJvwnaZ7lmrAvY=
Received: from CY5PR15CA0250.namprd15.prod.outlook.com (2603:10b6:930:66::24)
 by DS0PR12MB6438.namprd12.prod.outlook.com (2603:10b6:8:ca::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.24; Fri, 3 Feb
 2023 19:09:29 +0000
Received: from CY4PEPF0000B8EC.namprd05.prod.outlook.com
 (2603:10b6:930:66:cafe::ce) by CY5PR15CA0250.outlook.office365.com
 (2603:10b6:930:66::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.31 via Frontend
 Transport; Fri, 3 Feb 2023 19:09:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000B8EC.mail.protection.outlook.com (10.167.241.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6086.4 via Frontend Transport; Fri, 3 Feb 2023 19:09:29 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 3 Feb
 2023 13:09:27 -0600
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/13] drm/amdgpu: doorbell support in get_memory functions
Date: Fri, 3 Feb 2023 20:08:29 +0100
Message-ID: <20230203190836.1987-13-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20230203190836.1987-1-shashank.sharma@amd.com>
References: <20230203190836.1987-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000B8EC:EE_|DS0PR12MB6438:EE_
X-MS-Office365-Filtering-Correlation-Id: 8055ee24-5bd0-417b-f677-08db061a2cd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8rWmpA6ynSJFvIww9QMP4j9VHglO1KAZpz5YVvORtijYTxmJP+I/GX8CbmjCXMTGn6JBRFAvLYWmrTgeu/zsfu1zWX6n6QVFr0sE3um6f7FWIjqK/qykeN4AiuMktsjdXOfNei48deYDpVFCIaSuHq5SeA6RwF9w+6yTOYcQ2nO2JGmo3W5ODLnF33QVqwoc3ToLiNwVezL4gAHeAPlsiszQ4kkFMs6ofNrbc7OYl5jAH0tQHEMXW2MVP9HQZzyriYeEwkAvEjArn42+UO3mtXRVy2oGBDuLNAfBZhj9k0F04RdBsuqFATPO5XwCAKA7NClalDX2YEv/GdDHlabTpqHQLKi/NsfmJODPf9VJzH+vWhwwXWWyghSXLRy+jEOswJux4jdJlAA3PAsvi0NSzQ9Xht0NjNpj9RxubzrxmP4km6yed1hfiUBkx2rFNGu1+ZTvNKC8qNY2nvLyvDeDTdp2s9y+FFpWLsW+IGpkljyZO7IT+wVKmFbGXq6PA3etidF0etnbbwUJHzRd1gMs38Gzxjg2qEPn8qFoV6DfM1oNLCJkpgKfb9A7oJCCWN8ZBWTlfrKJD7KaTQApLDj5Rsjwrvag6lnhaJEon4225/fJLnxWDvBTREU36y8OtGHqT30vKBGWLTd1rB90AmH7mHn9DCYuBS2qYRdCEawRqZRek0/Rw4IpNMlUMNnXxZV11nm5U3dGlUTJCJc7zgjrsru3Xr20zZxa6TQQMG+qZsg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(39860400002)(396003)(136003)(376002)(346002)(451199018)(36840700001)(46966006)(40470700004)(70586007)(5660300002)(8936002)(40480700001)(41300700001)(81166007)(44832011)(36860700001)(336012)(36756003)(82740400003)(4326008)(82310400005)(6916009)(8676002)(356005)(478600001)(40460700003)(26005)(1076003)(186003)(70206006)(2616005)(426003)(7696005)(47076005)(2906002)(16526019)(316002)(83380400001)(54906003)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2023 19:09:29.2886 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8055ee24-5bd0-417b-f677-08db061a2cd2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000B8EC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6438
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
Cc: alexander.deucher@amd.com, christian.koenig@amd.com,
 shashank.sharma@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alex Deucher <alexander.deucher@amd.com>

This patch adds section for doorbell memory in memory status
reporting functions like vm/bo_get_memory.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c |  4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c |  9 ++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |  3 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c     | 15 ++++++++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h     |  3 ++-
 5 files changed, 22 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
index 99a7855ab1bc..202df09ba5de 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
@@ -60,7 +60,7 @@ void amdgpu_show_fdinfo(struct seq_file *m, struct file *f)
 	struct amdgpu_fpriv *fpriv = file->driver_priv;
 	struct amdgpu_vm *vm = &fpriv->vm;
 
-	uint64_t vram_mem = 0, gtt_mem = 0, cpu_mem = 0;
+	uint64_t vram_mem = 0, gtt_mem = 0, cpu_mem = 0, doorbell_mem = 0;
 	ktime_t usage[AMDGPU_HW_IP_NUM];
 	uint32_t bus, dev, fn, domain;
 	unsigned int hw_ip;
@@ -75,7 +75,7 @@ void amdgpu_show_fdinfo(struct seq_file *m, struct file *f)
 	if (ret)
 		return;
 
-	amdgpu_vm_get_memory(vm, &vram_mem, &gtt_mem, &cpu_mem);
+	amdgpu_vm_get_memory(vm, &vram_mem, &gtt_mem, &cpu_mem, &doorbell_mem);
 	amdgpu_bo_unreserve(vm->root.bo);
 
 	amdgpu_ctx_mgr_usage(&fpriv->ctx_mgr, usage);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index b2cfd46c459b..ef1f3106bc69 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -1288,7 +1288,8 @@ void amdgpu_bo_move_notify(struct ttm_buffer_object *bo,
 }
 
 void amdgpu_bo_get_memory(struct amdgpu_bo *bo, uint64_t *vram_mem,
-				uint64_t *gtt_mem, uint64_t *cpu_mem)
+			  uint64_t *gtt_mem, uint64_t *cpu_mem,
+			  uint64_t *doorbell_mem)
 {
 	unsigned int domain;
 
@@ -1300,6 +1301,9 @@ void amdgpu_bo_get_memory(struct amdgpu_bo *bo, uint64_t *vram_mem,
 	case AMDGPU_GEM_DOMAIN_GTT:
 		*gtt_mem += amdgpu_bo_size(bo);
 		break;
+	case AMDGPU_GEM_DOMAIN_DOORBELL:
+		*doorbell_mem += amdgpu_bo_size(bo);
+		break;
 	case AMDGPU_GEM_DOMAIN_CPU:
 	default:
 		*cpu_mem += amdgpu_bo_size(bo);
@@ -1578,6 +1582,9 @@ u64 amdgpu_bo_print_info(int id, struct amdgpu_bo *bo, struct seq_file *m)
 	case AMDGPU_GEM_DOMAIN_GTT:
 		placement = " GTT";
 		break;
+	case AMDGPU_GEM_DOMAIN_DOORBELL:
+		placement = "DOOR";
+		break;
 	case AMDGPU_GEM_DOMAIN_CPU:
 	default:
 		placement = " CPU";
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
index 082f451d26f4..bf9759758f0d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
@@ -326,7 +326,8 @@ int amdgpu_bo_sync_wait(struct amdgpu_bo *bo, void *owner, bool intr);
 u64 amdgpu_bo_gpu_offset(struct amdgpu_bo *bo);
 u64 amdgpu_bo_gpu_offset_no_check(struct amdgpu_bo *bo);
 void amdgpu_bo_get_memory(struct amdgpu_bo *bo, uint64_t *vram_mem,
-			  uint64_t *gtt_mem, uint64_t *cpu_mem);
+			  uint64_t *gtt_mem, uint64_t *cpu_mem,
+			  uint64_t *doorbell_mem);
 void amdgpu_bo_add_to_shadow_list(struct amdgpu_bo_vm *vmbo);
 int amdgpu_bo_restore_shadow(struct amdgpu_bo *shadow,
 			     struct dma_fence **fence);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index dc379dc22c77..1561d138945b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -918,7 +918,8 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 }
 
 void amdgpu_vm_get_memory(struct amdgpu_vm *vm, uint64_t *vram_mem,
-				uint64_t *gtt_mem, uint64_t *cpu_mem)
+			  uint64_t *gtt_mem, uint64_t *cpu_mem,
+			  uint64_t *doorbell_mem)
 {
 	struct amdgpu_bo_va *bo_va, *tmp;
 
@@ -927,37 +928,37 @@ void amdgpu_vm_get_memory(struct amdgpu_vm *vm, uint64_t *vram_mem,
 		if (!bo_va->base.bo)
 			continue;
 		amdgpu_bo_get_memory(bo_va->base.bo, vram_mem,
-				gtt_mem, cpu_mem);
+				     gtt_mem, cpu_mem, doorbell_mem);
 	}
 	list_for_each_entry_safe(bo_va, tmp, &vm->evicted, base.vm_status) {
 		if (!bo_va->base.bo)
 			continue;
 		amdgpu_bo_get_memory(bo_va->base.bo, vram_mem,
-				gtt_mem, cpu_mem);
+				     gtt_mem, cpu_mem, doorbell_mem);
 	}
 	list_for_each_entry_safe(bo_va, tmp, &vm->relocated, base.vm_status) {
 		if (!bo_va->base.bo)
 			continue;
 		amdgpu_bo_get_memory(bo_va->base.bo, vram_mem,
-				gtt_mem, cpu_mem);
+				     gtt_mem, cpu_mem, doorbell_mem);
 	}
 	list_for_each_entry_safe(bo_va, tmp, &vm->moved, base.vm_status) {
 		if (!bo_va->base.bo)
 			continue;
 		amdgpu_bo_get_memory(bo_va->base.bo, vram_mem,
-				gtt_mem, cpu_mem);
+				     gtt_mem, cpu_mem, doorbell_mem);
 	}
 	list_for_each_entry_safe(bo_va, tmp, &vm->invalidated, base.vm_status) {
 		if (!bo_va->base.bo)
 			continue;
 		amdgpu_bo_get_memory(bo_va->base.bo, vram_mem,
-				gtt_mem, cpu_mem);
+				     gtt_mem, cpu_mem, doorbell_mem);
 	}
 	list_for_each_entry_safe(bo_va, tmp, &vm->done, base.vm_status) {
 		if (!bo_va->base.bo)
 			continue;
 		amdgpu_bo_get_memory(bo_va->base.bo, vram_mem,
-				gtt_mem, cpu_mem);
+				     gtt_mem, cpu_mem, doorbell_mem);
 	}
 	spin_unlock(&vm->status_lock);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 094bb4807303..b8ac7d311c8b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -458,7 +458,8 @@ void amdgpu_vm_set_task_info(struct amdgpu_vm *vm);
 void amdgpu_vm_move_to_lru_tail(struct amdgpu_device *adev,
 				struct amdgpu_vm *vm);
 void amdgpu_vm_get_memory(struct amdgpu_vm *vm, uint64_t *vram_mem,
-				uint64_t *gtt_mem, uint64_t *cpu_mem);
+			  uint64_t *gtt_mem, uint64_t *cpu_mem,
+			  uint64_t *doorbell_mem);
 
 int amdgpu_vm_pt_clear(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		       struct amdgpu_bo_vm *vmbo, bool immediate);
-- 
2.34.1

