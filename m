Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFFFEC636CC
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Feb 2023 19:09:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63FCB10E8A8;
	Fri,  3 Feb 2023 19:09:35 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2060c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::60c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E24010E8A5
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Feb 2023 19:09:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bGigebszJnDCsF164i+taAREj8F6VHQZUphrBJjLX1TCtT4W2ZY057HAxsLveuDlr7E5ciuWooDH3F0imFG5JLsQia9vh1AZifvjFDIbhkmHEzgS8+81E7k36m57UxjoWGth9RRxjp/I0LrmHquXlUSfHJqAb8BjaPPIjdPE+OoTNHEfM57AxfKa+tpPSnRQjWS+Io+e9L4hhL5SEwRLHmWYhKSKJqNwz4tXWTLwY/MEgqNDvGfECM/ZrY7XTzAsHZSpOqA/nGzqKkMSZt9GjBKImdAbKqQHPot/g2suWzrPOWg6Sn4zWnOeCxDBW4UWDL3L5/kKnK7a5nBy+mogDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HaE2knV9Hn2UHcmhaJAvDQig+kBdodyKOKh7/kFyqi0=;
 b=K/+l0ixjglBBrd+p1iAd6EKCdx+RtydKL3MUGdBEMHW0VkZWf72d118UEVZE7puDTOG3naK2bWLqiUJmYBoic90IjrM8uLQvVknk1WK3n2fJVsTAxn47ZfNAreOffYNqCD5nugi5BFiu8e+U1PAeDBZfAkZtwRW704aAYz/whS2rqGyHcqM6IRMqTqbJrsPOuRvU+5y+g4gkPTuI3Q8sAWwWuYqsG+7QAl/SUkgArez/vohkKEbNF5AlVaenR11T8w45HvtEbW1cItsfnokSm5L+m/yQ05sbMcpDWytzXqo+I4OdpcN+kgB8hI8PWLVYUH+7IRusPmeUEdDFdgHj8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HaE2knV9Hn2UHcmhaJAvDQig+kBdodyKOKh7/kFyqi0=;
 b=cir8GXFA6CMzf7NivFQr6MQqIwXVl6aFGjIzgWstED9dSIXAvZA1RW628ccMOe1L49oabAXFNPdBnJZ3WNetaiEb7fKSEtiJxWgM01bt9g0RiPEAa3fh/Fvd/499OA2+WMnla/8YylUq3Tx1nZhjvkOZ22A3PO3co4XConEVOC4=
Received: from CY5PR20CA0002.namprd20.prod.outlook.com (2603:10b6:930:3::24)
 by DS7PR12MB6359.namprd12.prod.outlook.com (2603:10b6:8:94::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38; Fri, 3 Feb
 2023 19:09:30 +0000
Received: from CY4PEPF0000B8EB.namprd05.prod.outlook.com
 (2603:10b6:930:3:cafe::32) by CY5PR20CA0002.outlook.office365.com
 (2603:10b6:930:3::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.28 via Frontend
 Transport; Fri, 3 Feb 2023 19:09:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000B8EB.mail.protection.outlook.com (10.167.241.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6064.15 via Frontend Transport; Fri, 3 Feb 2023 19:09:30 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 3 Feb
 2023 13:09:28 -0600
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 11/14] drm/amdgpu: doorbell support in get_memory functions
Date: Fri, 3 Feb 2023 20:08:30 +0100
Message-ID: <20230203190836.1987-14-shashank.sharma@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000B8EB:EE_|DS7PR12MB6359:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e54554e-9a4e-46e9-a7c8-08db061a2d89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7rEPd7EMovG5zrCsBH/IWMCUHZkebKpZ0+m2Dtyma1kTQQGi3M45MLEgOgGwO5S3qEeeV7d5ADQymfixnNHbeK/xwvgyir2JaFLVbZs2fhrCNxw4Eu75iGJz3wdb0j61SLyt0+BqOWc7Uq5EK5FEh+WJSiQMHrxvUT4C+vSfR2Dn0VJvnXSFctJFCF50yXcBGdMLlAniL7uAU9EYfyL2CiE/Ndw8pWRPco405Wz4bSMF0WGbbviXgT0PqIdeKrMEpfsjSf/CFE6f7yR96Vw/crPTVN4TcUofG64I+6XcvalqSu1FAsXNOWgBs8xpxZ86iOQ2zykMPzGk8tuxhcO9xEWAB8E53dBS+oavG2LW6nAK+NlwEt1SEl/fqd8/FgxWH6zctXAf5xGzSqKgzcBpiO9B9sgqyntid8FKXILblsswImBDeOdiu9ELnQMlJdvq4z4B/++PaijpeV8Gi1DJeVuBl1OLIoSNzOvQ72zcE+WrK10PI1xfJsM568DnhVem7vxKPKUrSc+ziQZmO86kJjQ6ibisEEC8ppz89jKV+uH0HKCAJlqYMQ1jTIf3NU4Q64ztaSQVvUk8yTq9j3BfY+K74Yic7k6WtyDUH/5fcY9/lJWtIU/UxuG9bj4uDhBa1q+HJQjxMV36+907ute0dhq3/UIV+bgoY0hFc4JZOjX1OUBjBffspPMUZajfuLWasdQah0ZHW2IyQPMqKNRDwic76BrfV2TDJasXkaxt+hU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(346002)(136003)(396003)(39860400002)(376002)(451199018)(46966006)(40470700004)(36840700001)(4326008)(44832011)(2906002)(5660300002)(54906003)(1076003)(36756003)(336012)(6666004)(83380400001)(8936002)(426003)(6916009)(186003)(70206006)(2616005)(26005)(86362001)(40460700003)(70586007)(16526019)(478600001)(40480700001)(47076005)(8676002)(7696005)(356005)(316002)(81166007)(82310400005)(41300700001)(82740400003)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2023 19:09:30.4875 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e54554e-9a4e-46e9-a7c8-08db061a2d89
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000B8EB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6359
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
index ab32dfe68c5f..d9608eee0672 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -1287,7 +1287,8 @@ void amdgpu_bo_move_notify(struct ttm_buffer_object *bo,
 }
 
 void amdgpu_bo_get_memory(struct amdgpu_bo *bo, uint64_t *vram_mem,
-				uint64_t *gtt_mem, uint64_t *cpu_mem)
+			  uint64_t *gtt_mem, uint64_t *cpu_mem,
+			  uint64_t *doorbell_mem)
 {
 	unsigned int domain;
 
@@ -1299,6 +1300,9 @@ void amdgpu_bo_get_memory(struct amdgpu_bo *bo, uint64_t *vram_mem,
 	case AMDGPU_GEM_DOMAIN_GTT:
 		*gtt_mem += amdgpu_bo_size(bo);
 		break;
+	case AMDGPU_GEM_DOMAIN_DOORBELL:
+		*doorbell_mem += amdgpu_bo_size(bo);
+		break;
 	case AMDGPU_GEM_DOMAIN_CPU:
 	default:
 		*cpu_mem += amdgpu_bo_size(bo);
@@ -1577,6 +1581,9 @@ u64 amdgpu_bo_print_info(int id, struct amdgpu_bo *bo, struct seq_file *m)
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

