Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76DC9C6379F
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Feb 2023 16:15:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E07F810E927;
	Tue, 14 Feb 2023 16:15:57 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20621.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::621])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 666EF10E926
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Feb 2023 16:15:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OHt6Io+ckvn0hD99SESpxCzOsPu9Tw+GcDJIO4I9vWTX8McCH7oaNg1dM2uH05bVtRuhBpgwt6/CM/N8XcWWvC+Ak/xqJ7ptu5LMGIHZv77QYPuKV5gZe62j3OXtMhV0BgzLerbV6Gb3cHsOEAzE0ukRjcgS/ufU7z//SdW/vTcKlJNsYBEVl5hnMKxTJtb6Vi1tDWRReXHZBFiyGR2Fmt+Rx37zfCqjQfrr5SO60k3mvI3TIQBJM8S3twfQQmbGHI3hAvRrDgn//WRpKeBUu/h5hPxMGkwmG1Z2OiEf5bxlMCY3cUIGzo3AiMOtSkxjDy/NRNOArvtkLE2XT8VaQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qhZkT53Wvz28kl1nnuB3PSCAWfJ/Z7YlgSgpnQPErCs=;
 b=LVwcqZ4c1gHisweC/Dn4tVXVHp4//zHt+u8y3KYc88n6txu6iJaVdzRYu3CXdgv+BTc48GEtKpb44T6Y2iYDfgA0qpr2y51XRvMS5ESl7dFqHy2wsZBYtswicxAGc0MQPkWMKifH79bRHHMqy1lASv/4QRUHeyW34+2e2a0dtfVDZHe1fXVykLvB7mmhkCoGTiXspOFlMwY8ReI+Xq7MsHC4VVmXAqeUjSwoZtDXPv22hrz1SZj6isU03CSK/uXLJmcC4ANlDeiS9adPD0uLNXMWUhJuiJ4dwwry7Tu8BNuRZ7xD6rSUVKe5ZxiUIPFSwb72226jIqjUAtqRQ+aD1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qhZkT53Wvz28kl1nnuB3PSCAWfJ/Z7YlgSgpnQPErCs=;
 b=JmaeYu2MnygmCgNifZpGf5rkBoz62jKntb6yHDT8xutTDAz31A9mL8OuRShzJi2uhjSPBMwFUUCa6EZKJ1SRwAWuKEjiSSSvD1PlnweDOiQbPD0qrapqaffILz/EevkW7jujnyqXxVXBUWQ3i64qKOS7Z5XGWEJCtVvmoCD6zUI=
Received: from MW2PR16CA0054.namprd16.prod.outlook.com (2603:10b6:907:1::31)
 by MW6PR12MB7070.namprd12.prod.outlook.com (2603:10b6:303:238::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Tue, 14 Feb
 2023 16:15:54 +0000
Received: from CO1NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:1:cafe::da) by MW2PR16CA0054.outlook.office365.com
 (2603:10b6:907:1::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26 via Frontend
 Transport; Tue, 14 Feb 2023 16:15:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT059.mail.protection.outlook.com (10.13.174.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6086.24 via Frontend Transport; Tue, 14 Feb 2023 16:15:54 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 14 Feb
 2023 10:15:52 -0600
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 6/8] drm/amdgpu: get doorbell memory
Date: Tue, 14 Feb 2023 17:15:08 +0100
Message-ID: <20230214161510.2153-7-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20230214161510.2153-1-shashank.sharma@amd.com>
References: <20230214161510.2153-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT059:EE_|MW6PR12MB7070:EE_
X-MS-Office365-Filtering-Correlation-Id: f9e5c006-11a8-4c3a-1679-08db0ea6bf8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Pq6j4cLoI6g5fWAxJuhEviNMOZOiVj+maW8sP6e6fm9meFBCrj0n7xAzaRLMjLoTwKsh5oz6ZG0AkNuyMYbDrsBpq12TkmuCFNWvHe6sRBL4KTnoyo9OIvbsYBliEA5nvIX/pXUiexngn4EhgNghd9/Zovbn5KTzTSMsXO9TIDXqxNi+npUXiUS54pPDoZ1xyoGd7Df5YfEitUkuvnETg0/UgmH5HYhupG1aWD3KN42XQS2blRPnIOJKVyNoxBCCHy5pwuEaI51CUNT03PyZcmvjge0lAZ7KWqUtnudPAuS2WypltA37NNmcaGkfHc2R6N/DrcW8HjRsFM0CYBqS3vQCu1LfCjcz7i3mqlyKwg5wZxTVsG06vtfLSOs0Hbih6CVI0LRrmu6Ds3eJbY/vbTHtIoCxTR72ZgCiBZ0170O/eux1FpY4Jh3zFL+XbRnX7VX/AIlWVPBVA9oj255xVt96rU+UO0hcmr3g9jBX9+AFv+S0vHBPHqUqWIAC6lWTCsW+61onUQ6u8Vl/OJ4tzoqE1mBqgUcA9okWGTAHOr6VNxyNc4Am31+2M8glgCgUKngJ6SNURk0cz0fVObymMlpx1a3oUCWOEqTgENMld3t5MDJx5soc6dji+9/Lp3SXiTcCodBkB9hn2JIONGMwYmx5eTanQ54gJwy9nUcMiTafY2Cfg+jojj25TMD8kBvoodNK2tRUPWi0rEreP0hulOZbNc/PjLjM7sLW6S5DF0M=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(39860400002)(136003)(376002)(346002)(396003)(451199018)(46966006)(40470700004)(36840700001)(5660300002)(47076005)(83380400001)(426003)(26005)(186003)(36756003)(2906002)(44832011)(1076003)(82310400005)(86362001)(41300700001)(40460700003)(6666004)(478600001)(7696005)(8936002)(40480700001)(81166007)(16526019)(336012)(82740400003)(36860700001)(356005)(2616005)(316002)(54906003)(70206006)(70586007)(4326008)(6916009)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2023 16:15:54.2549 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9e5c006-11a8-4c3a-1679-08db0ea6bf8d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB7070
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
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, Arvind.Yadav@amd.com,
 shashank.sharma@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alex Deucher <alexander.deucher@amd.com>

This patch adds section for doorbell memory in memory status
reporting functions like vm/bo_get_memory.

V2: Rebase

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
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
index ff9979fecfd2..90e97abc1454 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -1275,7 +1275,8 @@ void amdgpu_bo_move_notify(struct ttm_buffer_object *bo,
 }
 
 void amdgpu_bo_get_memory(struct amdgpu_bo *bo, uint64_t *vram_mem,
-				uint64_t *gtt_mem, uint64_t *cpu_mem)
+			  uint64_t *gtt_mem, uint64_t *cpu_mem,
+			  uint64_t *doorbell_mem)
 {
 	unsigned int domain;
 
@@ -1287,6 +1288,9 @@ void amdgpu_bo_get_memory(struct amdgpu_bo *bo, uint64_t *vram_mem,
 	case AMDGPU_GEM_DOMAIN_GTT:
 		*gtt_mem += amdgpu_bo_size(bo);
 		break;
+	case AMDGPU_GEM_DOMAIN_DOORBELL:
+		*doorbell_mem += amdgpu_bo_size(bo);
+		break;
 	case AMDGPU_GEM_DOMAIN_CPU:
 	default:
 		*cpu_mem += amdgpu_bo_size(bo);
@@ -1565,6 +1569,9 @@ u64 amdgpu_bo_print_info(int id, struct amdgpu_bo *bo, struct seq_file *m)
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
index 93207badf83f..bf9759758f0d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
@@ -326,7 +326,8 @@ int amdgpu_bo_sync_wait(struct amdgpu_bo *bo, void *owner, bool intr);
 u64 amdgpu_bo_gpu_offset(struct amdgpu_bo *bo);
 u64 amdgpu_bo_gpu_offset_no_check(struct amdgpu_bo *bo);
 void amdgpu_bo_get_memory(struct amdgpu_bo *bo, uint64_t *vram_mem,
-				uint64_t *gtt_mem, uint64_t *cpu_mem);
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

