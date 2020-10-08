Return-Path: <SRS0=l8SD=DP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAD2BC43467
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Oct 2020 11:18:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12C632145D
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Oct 2020 11:18:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="pSTpDg2U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12C632145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C9FB6E30D;
	Thu,  8 Oct 2020 11:18:58 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2041.outbound.protection.outlook.com [40.107.244.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73FE86E30D
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Oct 2020 11:18:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LPQGvGyF/nVahsbJJ6eQIGZ8BQKcEtunnHJZGEbYcXBG64+2i4bfs51JDnIYtvYMfbDlc5e2VroU/QDki32McGLmETO5Wc37xNLGisNNJEHoUdv1OBGrCEqYR/IZtUZj0Ydgo/zdBhS0EXhMaxJDqi2dsJ92YGbrDLeycsPVfBe/DePGtAWqH5BJJGmBfSRldZmd+CI2EP7ZnHQaEZrFHCDKHsUYdG5qhH5++P/DTv+flL5EKAgMnWebsCVbTjCF0n1uF71tf8gfgluioAjb1Y5YbsQDWqOwtbVGJ4v0HcRP/R6NG3rHJWtj915fIckIJc4mkMsKHsfXUiboEvhPgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gqHY+mXBo9Z3FnZQGdmJW95aqa2nm4xP+jJYWVx64oo=;
 b=dBlKm5YWFNO7eQCEphJugr6kPez0YCMMobYDK167CQj3w206tamrEDa3TDdIw93Rk7ILWUhpGBjwYDivqSiULr1MDA4qVNCKunb2hha/yx2XVLL2J427DHjhnVZLKTOTU6TZ1219KdPsNkjA9OqK08HESWOGJlol0GtLKgPXsE5MZSfcIljicSzaDUw+C30MZStjEforpxr+Nv66RjElMWpZNDpLulm24bP5GRPRmHYBGcQ3l4MP9wF3ct+DOY7xW4hWKgl6AKcSaECLQ2IUeWTyVC0af1q4UQ810edmgd3Zkyw9KBkjcvI2Vq7/My8JgPfj+GTwyMaUJbZPnUew2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gqHY+mXBo9Z3FnZQGdmJW95aqa2nm4xP+jJYWVx64oo=;
 b=pSTpDg2U8QQ+hFrNJk6IOTKGqfc7agvRaDctbYvPSmbspuAU/uBJyNRxhBFyoy/QREIBIjQd3tyr7PKPECGKFxWjHgTLxMEP30a+GSRRsuvMxLvnQ38OjmABcnvR7anW2MV5/KFXWHsEWtFyID0trWkqeMrOKxqLi7AOMYlBN6U=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4452.namprd12.prod.outlook.com (2603:10b6:5:2a4::17)
 by DM6PR12MB4418.namprd12.prod.outlook.com (2603:10b6:5:28e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.32; Thu, 8 Oct
 2020 11:18:55 +0000
Received: from DM6PR12MB4452.namprd12.prod.outlook.com
 ([fe80::3061:cd92:9bf4:8380]) by DM6PR12MB4452.namprd12.prod.outlook.com
 ([fe80::3061:cd92:9bf4:8380%6]) with mapi id 15.20.3455.024; Thu, 8 Oct 2020
 11:18:55 +0000
From: Mihir Patel <mihir.patel@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: Add debugfs entry for printing VM info
Date: Thu,  8 Oct 2020 16:48:24 +0530
Message-Id: <20201008111824.110811-1-mihir.patel@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.159.242]
X-ClientProxiedBy: BM1PR01CA0137.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:40::31) To DM6PR12MB4452.namprd12.prod.outlook.com
 (2603:10b6:5:2a4::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mihirp-navi14.amd.com (165.204.159.242) by
 BM1PR01CA0137.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:40::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3455.22 via Frontend Transport; Thu, 8 Oct 2020 11:18:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: aa480bc3-5ee1-468a-662c-08d86b7bf18b
X-MS-TrafficTypeDiagnostic: DM6PR12MB4418:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4418CC0A4E29D5A6517C27C4E80B0@DM6PR12MB4418.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MeW8l0NXokPtkTaw/D5536e0IKQ1Dtiog8jXHOWYw98AGwvDIvyxsvtzuGGiZScTkqZchVxNBWiKZ4PtHAqZ/y3wQgaHZKYJiB7rUUtKsEhxp+HuPBbkbCArNjGF4dYfaKtPu2581bSxqyahrQ/awQEdjQ8aSqWP99sxFAVYXJP+CKBDrOkL7+G8muBkaJ7eI24RmAZyejXzVuUlBgf3dfy4hpR5zDhLveyRl8m6TIlYzmYs7PRmxVSHJ6I4o07EqSmOBCXaoqWjEP9pg24W8PV5Zj0BoAgebyqoP7vAbHvp9klhgWzBlIUnkLLpM5izP/1kAjV6GnMGOUqwfOjWeA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4452.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(366004)(39860400002)(376002)(346002)(66946007)(66556008)(956004)(316002)(52116002)(5660300002)(66476007)(6916009)(8676002)(2906002)(2616005)(86362001)(186003)(16526019)(6486002)(26005)(6666004)(1076003)(8936002)(4326008)(478600001)(7696005)(83380400001)(44832011)(36756003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: OUkpk+Ra/iqAwuDsbPjYCx3e1V28tcQ67TVf9WtsDds6Zpbn3SWgke5we0MGv7EA19ljW50ZMqZP97Op2JZbTQQrbUFloxIaANJERKyYrmP9krA8gGHb9nDGvn1m0JQU5Da9DKnyEbYnQGw8zSB4qJ80xXjNZcQRjJwUhMX31rmSdh0HRhcqpANpFrYaWWima1UfXftO9yp7W6UYKsg9qCFGBsT4v1eX3GfLT2Pkx/323R6p4OZvG7pUNNO0Dw69g09CTTTzxMsejRi8T+7UNqpHWYEi0lo373jqs/H0byoDl/s7fkfuGIPFXfKtWvEGRf74SgprGBoMUHu8+b9jRIxQcZFBqoUd71oXIpR2QXl8YBpnmolot73Fi60N6UsPh/tVA8YQa9scNW/OzHOg5ATHa2PIwToIYBR6pILcIjaWy1sBr6MN+i7JhZMrtTkExDRgg5U1evTIBDSJ8lq9aw7EVvmsAgV18u8bs0YhRJr2Dlr+RC9BiNk8bQ1x48KP9zOFpRiguG5kAdf73s1wYkFn4pPs+dTw6bbq10KxvZs6E32qdNoOeCPa10vPpkCXvvuodAqLj3OzkpbnAikou/ff1zq3zXTZKulgUP4uRCTWXvT0UVlNBzAuOXVtlWfHhC/8092ryRuXtqZzS7FsVg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa480bc3-5ee1-468a-662c-08d86b7bf18b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4452.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2020 11:18:55.2152 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uE1isJfy1aNA9ybja8Jm1lnsL9fVcda7GX9TJZG4FO8rbx9flgrmCPmjrIM77nspBL/Idom0Dqu6LlHePjbk2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4418
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
Cc: Chauhan.Madhav@amd.com, Mihir Bhogilal Patel <Mihir.Patel@amd.com>,
 ksurampa@amd.com, alexander.deucher@amd.com, pkamliya@amd.com,
 Christian.Koenig@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Mihir Bhogilal Patel <Mihir.Patel@amd.com>

Create new debugfs entry to print memory info using VM buffer
objects.

Note: Early upload for discussion and review
Require work for:
- Identifying correct list for swap information
- Review on proper locking
- Consolidated memory utilization info like total etc.

Signed-off-by: Mihir Bhogilal Patel <Mihir.Patel@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |  34 ++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c      | 123 ++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h      |   4 +
 3 files changed, 161 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 2d125b8b15ee..74028b7d673c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -1335,11 +1335,45 @@ static int amdgpu_debugfs_evict_gtt(struct seq_file *m, void *data)
 	return 0;
 }
 
+static int amdgpu_debugfs_vm_info(struct seq_file *m, void *data)
+{
+	struct drm_info_node *node = (struct drm_info_node *)m->private;
+	struct drm_device *dev = node->minor->dev;
+	struct drm_file *file;
+	int r;
+
+#ifndef HAVE_DRM_DEVICE_FILELIST_MUTEX
+	r = mutex_lock_interruptible(&dev->struct_mutex);
+#else
+	r = mutex_lock_interruptible(&dev->filelist_mutex);
+#endif
+	if (r)
+		return r;
+
+	list_for_each_entry(file, &dev->filelist, lhead) {
+		struct amdgpu_fpriv *fpriv = file->driver_priv;
+		struct amdgpu_vm *vm = &fpriv->vm;
+
+		seq_printf(m, "pid:%d\tProcess:%s ----------\n",
+				vm->task_info.pid, vm->task_info.process_name);
+		amdgpu_debugfs_vm_bo_info(vm, m);
+	}
+
+#ifndef HAVE_DRM_DEVICE_FILELIST_MUTEX
+	mutex_unlock(&dev->struct_mutex);
+#else
+	mutex_unlock(&dev->filelist_mutex);
+#endif
+
+	return 0;
+}
+
 static const struct drm_info_list amdgpu_debugfs_list[] = {
 	{"amdgpu_vbios", amdgpu_debugfs_get_vbios_dump},
 	{"amdgpu_test_ib", &amdgpu_debugfs_test_ib},
 	{"amdgpu_evict_vram", &amdgpu_debugfs_evict_vram},
 	{"amdgpu_evict_gtt", &amdgpu_debugfs_evict_gtt},
+	{"amdgpu_vm_info", &amdgpu_debugfs_vm_info},
 };
 
 static void amdgpu_ib_preempt_fences_swap(struct amdgpu_ring *ring,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 3cd949aad500..f2f77fd3caa0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -3392,3 +3392,126 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, unsigned int pasid,
 
 	return false;
 }
+
+#if defined(CONFIG_DEBUG_FS)
+#define amdgpu_debugfs_vm_bo_print_flag(m, bo, flag)		\
+	do {							\
+		if (bo->flags & (AMDGPU_GEM_CREATE_ ## flag)) {	\
+			seq_printf((m), " " #flag);		\
+		}						\
+	} while (0)
+
+/**
+ * amdgpu_debugfs_print_bo_info - print BO info in debugfs file
+ *
+ * @id: Index or Id of the BO
+ * @bo: Requested BO for printing info
+ * @data: debugfs file
+ *
+ * Print BO information in debugfs file
+ *
+ * Returns:
+ * Size of the BO in bytes.
+ */
+static unsigned long amdgpu_debugfs_print_bo_info(int id, struct amdgpu_bo *bo, void *data)
+{
+	struct seq_file *m = data;
+	struct dma_buf_attachment *attachment;
+	struct dma_buf *dma_buf;
+	unsigned int domain;
+	const char *placement;
+	unsigned int pin_count;
+	unsigned long size;
+
+	domain = amdgpu_mem_type_to_domain(bo->tbo.mem.mem_type);
+	switch (domain) {
+	case AMDGPU_GEM_DOMAIN_VRAM:
+		placement = "VRAM";
+		break;
+	case AMDGPU_GEM_DOMAIN_GTT:
+		placement = " GTT";
+		break;
+	case AMDGPU_GEM_DOMAIN_CPU:
+	default:
+		placement = " CPU";
+		break;
+	}
+
+	size = amdgpu_bo_size(bo);
+	seq_printf(m, "\t\t0x%08x: %12ld byte %s",
+		   id++, size, placement);
+
+	pin_count = READ_ONCE(bo->pin_count);
+	if (pin_count)
+		seq_printf(m, " pin count %d", pin_count);
+
+	dma_buf = READ_ONCE(bo->tbo.base.dma_buf);
+	attachment = READ_ONCE(bo->tbo.base.import_attach);
+
+	if (attachment)
+		seq_printf(m, " imported from %p", dma_buf);
+	else if (dma_buf)
+		seq_printf(m, " exported as %p", dma_buf);
+
+	amdgpu_debugfs_vm_bo_print_flag(m, bo, CPU_ACCESS_REQUIRED);
+	amdgpu_debugfs_vm_bo_print_flag(m, bo, NO_CPU_ACCESS);
+	amdgpu_debugfs_vm_bo_print_flag(m, bo, CPU_GTT_USWC);
+	amdgpu_debugfs_vm_bo_print_flag(m, bo, VRAM_CLEARED);
+	amdgpu_debugfs_vm_bo_print_flag(m, bo, SHADOW);
+	amdgpu_debugfs_vm_bo_print_flag(m, bo, VRAM_CONTIGUOUS);
+	amdgpu_debugfs_vm_bo_print_flag(m, bo, VM_ALWAYS_VALID);
+	amdgpu_debugfs_vm_bo_print_flag(m, bo, EXPLICIT_SYNC);
+
+	seq_printf(m, "\n");
+
+	return size;
+}
+
+/**
+ * amdgpu_debugfs_vm_bo_info  - print BO info for the VM
+ *
+ * @vm: Requested VM for printing BO info
+ * @data: debugfs file
+ *
+ * Print BO information in debugfs file for the VM
+ */
+void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm *vm, void *data)
+{
+	struct seq_file *m = data;
+
+	struct amdgpu_bo_va_mapping *mapping;
+	struct amdgpu_bo_va *bo_va, *tmp;
+	unsigned long long total_mapped_size = 0;
+	unsigned long long total_idle_size = 0;
+	unsigned int total_mapped_objs = 0;
+	unsigned int total_idle_objs = 0;
+	unsigned int id = 0;
+
+	spin_lock(&vm->invalidated_lock);
+	/* Print BO info for all VA mappings */
+	seq_printf(m, "\tMapped BOs:\n");
+	for (mapping = amdgpu_vm_it_iter_first(&vm->va, 0, U64_MAX); mapping;
+	     mapping = amdgpu_vm_it_iter_next(mapping, 0, U64_MAX)) {
+		if (mapping->bo_va && mapping->bo_va->base.bo)
+			total_mapped_size += amdgpu_debugfs_print_bo_info(id++,
+							mapping->bo_va->base.bo, m);
+	}
+
+	total_mapped_objs = id;
+	id = 0;
+	/* Print info for Idle BOs */
+	seq_printf(m, "\tIdle BOs:\n");
+	list_for_each_entry_safe(bo_va, tmp, &vm->idle, base.vm_status) {
+		if (bo_va && bo_va->base.bo)
+			total_idle_size += amdgpu_debugfs_print_bo_info(id++,
+								bo_va->base.bo, m);
+	}
+	spin_unlock(&vm->invalidated_lock);
+
+	total_idle_objs = id;
+	seq_printf(m, "\tTotal mapped size:  %12lld\n", total_mapped_size);
+	seq_printf(m, "\tTotal mapped objs:  %12d\n", total_mapped_objs);
+	seq_printf(m, "\tTotal idle size:    %12lld\n", total_idle_size);
+	seq_printf(m, "\tTotal idle objs:    %12d\n", total_idle_objs);
+}
+#endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 7c46937c1c0e..a64465c72c9c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -441,4 +441,8 @@ void amdgpu_vm_move_to_lru_tail(struct amdgpu_device *adev,
 				struct amdgpu_vm *vm);
 void amdgpu_vm_del_from_lru_notify(struct ttm_buffer_object *bo);
 
+#if defined(CONFIG_DEBUG_FS)
+void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm *vm, void *data);
+#endif
+
 #endif
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
