Return-Path: <SRS0=L/30=DT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CD08C433DF
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Oct 2020 11:48:48 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FEDD2145D
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Oct 2020 11:48:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="i1YjemOm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FEDD2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A4706E2C0;
	Mon, 12 Oct 2020 11:48:47 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2041.outbound.protection.outlook.com [40.107.223.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB05E6E2C0
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Oct 2020 11:48:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Plws4MLTc+MMEQGtQliA9kwrcxOvJSjNBG0mVWDx/WwqjRi9AuXt5TUVtoJrt+RGVSOPp1oUjQ+uJ9jwKbLT1j1iO7Wbwf1WW2cC2SObQVJdcwwCfjqkW023/7xmUhIEn5j3oe+3Jm6z0K1VHCr8bLY3tbtV8iFL1onS/yn4ySY/ZCvjBQAyx94PBM/49QlVCYweokz1TnSrP1x9i6DUE7sXvChBeNZminB5vo3sD6Nxz75Jm75mmnvhfPq/GbNPsWQdIvU9lYOkozwKQdP7BK1FwJf1gGlO0TWW62sDLXJWH0AoyYQcrAnXUnturRbhvsAiqCWdsqtoTWxuLuCvIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dYhcNcW2n099mhP3l+iUz4AzD94ZJvBYhHzblcP23kc=;
 b=TvGAlOqCqnRbky10i86f07YT6EZkZhjJFK+1BCCznZRUD1bTQ1pDeJ4ncvBU1U0Ml3eVP4on2NdhL6QsdDBqGmkyAAISaZN6vv+FABffuAuqMcOWLZSRyNc9XzX9ZML9OhH4D0vcW5Fw6PiLEPffzirOt/vjRRLH/6hZn+XIRg763t1QFHpM5clA4VDd2yf1ipVyqmVS4KqB4dRBnWQ7PH6tp5Le1zSiucrgz2zmPoAvZQNjq7RL8RosGBFwx5DFcE2YlQ1Ce9RRnH1t07FIXqYtqOHJauhUaU/BujZJGYerFGVsgkGFQxtsgUIVJq8xEWyPsHk9jeOM5K7nEbOpFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dYhcNcW2n099mhP3l+iUz4AzD94ZJvBYhHzblcP23kc=;
 b=i1YjemOmfKUCz8l8jHJ3rwhnMtazdDGJU/rwt1Ip7TkWWx/gv/6a94EJZBv/Z+sZNLrNlxninEbyrJg8tfe14fcc7IAIVH+qMxlLyPr3OL85AfiE83+KDO/udYUBvvVrteX9Dyzz7UVct9k8cJmaKCJMzuXPYhD9DMoRAVnMIWo=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4452.namprd12.prod.outlook.com (2603:10b6:5:2a4::17)
 by DM5PR12MB1897.namprd12.prod.outlook.com (2603:10b6:3:112::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.22; Mon, 12 Oct
 2020 11:48:43 +0000
Received: from DM6PR12MB4452.namprd12.prod.outlook.com
 ([fe80::3061:cd92:9bf4:8380]) by DM6PR12MB4452.namprd12.prod.outlook.com
 ([fe80::3061:cd92:9bf4:8380%6]) with mapi id 15.20.3455.030; Mon, 12 Oct 2020
 11:48:43 +0000
From: Mihir Patel <mihir.patel@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v4] drm/amdgpu: Add debugfs entry for printing VM info
Date: Mon, 12 Oct 2020 17:18:11 +0530
Message-Id: <20201012114811.52125-1-mihir.patel@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [183.83.139.166]
X-ClientProxiedBy: MA1PR0101CA0058.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:20::20) To DM6PR12MB4452.namprd12.prod.outlook.com
 (2603:10b6:5:2a4::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mihirp-navi14.amd.com (183.83.139.166) by
 MA1PR0101CA0058.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:20::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.21 via Frontend
 Transport; Mon, 12 Oct 2020 11:48:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c10f2703-01ae-4560-c63f-08d86ea4c4b7
X-MS-TrafficTypeDiagnostic: DM5PR12MB1897:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1897FC4B0E6DC3F397093E59E8070@DM5PR12MB1897.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1227;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IcZIBvBJK+q8qN/KLUp8vcxWZJectlOtx5pGG/b9x6Jyj9lJNY18bRbThUTjXeDg8QSFdbljsGaOsD/0B8kk7eICRlNe4dk24eC7DYyB8qgd5EMtijDU1UJXL/HpS6pBuk3ikjFfYxcrY1m/yKnhDWUSF74VRKCF8NvzLL9xY48tlYCnIzHkfFQ+/rScQthm89VtZ8nR7JW5p1srv8JiFDa582ifZWaBImAFQG5fZld8EORC3d5dEkVnkj9piB/VXQudQ+DIeevUj3FRezNO5iMoYekPzpg+REh7DxFYXlZvOSxpGJuUUqIcNF3B79p2eMMPAjE83trn80itpY9BOQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4452.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(346002)(136003)(366004)(376002)(7696005)(52116002)(6916009)(478600001)(4326008)(6486002)(26005)(8936002)(36756003)(5660300002)(6666004)(16526019)(86362001)(8676002)(186003)(66946007)(44832011)(316002)(30864003)(2906002)(956004)(2616005)(83380400001)(1076003)(66556008)(66476007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: SeO7FvgkZ0qxl3aPwzVOHho6UgQE8/t7BPebEmCq32QmZ2UosXycjyCcBDBTuv7MB6JqmvXqdqaGF+iVBhE2ln2FTyCAlfa+Wc7j8sboRtF22bHJRr10gV6fLIlMT4Yr/rnJkg6cD2gc2vC6WMtlipq/WTdUox6bleHeE4d8Dmp9lztDwIHrrtCiruKreFXiy49NEY1Idu1wT1DM4i58gxL41nnceEu4xRYBY/9g6YsfKvJtcCfXUG67gcquflZiEmJNlCUDV8myVxp0gMyYFSTnG0UsJefWqtAxxxPUOlG/AOrTpDTv/jre/WcyfB9LHUSpUMRnD6Xq0hf2H295+Cx52ZUi60rXxSmuxst8PSIJonGT4XUtyNHmDLMUBTDBP4xemh2IxmCKPgohrfUDIYwXrrcdx0n8fJ/DfZoCnqxKHF1NVd/57mvyTAyUrFU4XaH6EKuZHXeKPOIt/J0iKy6jaX+KpwyuCbsbQCPVYYG3MgtsHetnluDGKKjVzjVkGxFLPDqhiRY5/XBvRUizCpmL06JWvmZnt6yTNqUoGO1dBjCzLvZRroBlHXc6JCxRylv0Tj40K/7B+gu4qITsN4Gd9GCZe9RfHE9D3vX/iyp5hASZFYGR1NuInZof0JlnUuAQuILJinKvRqBW1F68nQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c10f2703-01ae-4560-c63f-08d86ea4c4b7
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4452.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2020 11:48:43.0898 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zTa2eAXeuynzm8ABBLzksaHKXQuLn068Ti54UVXmVshEBnOZf6972OT3pTO8iKthAncjAQ/6lLavxP930I3gEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1897
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
Cc: Mihir Bhogilal Patel <Mihir.Patel@amd.com>, alexander.deucher@amd.com,
 ksurampa@amd.com, Madhav.Chauhan@amd.com, pkamliya@amd.com,
 Christian.Koenig@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Mihir Bhogilal Patel <Mihir.Patel@amd.com>

Create new debugfs entry to print memory info using VM buffer
objects.

V2: Added Common function for printing BO info.
    Dump more VM lists for evicted, moved, relocated, invalidated.
    Removed dumping VM mapped BOs.
V3: Fixed coding style comments, renamed print API and variables.
V4: Fixed coding style comments.

Signed-off-by: Mihir Bhogilal Patel <Mihir.Patel@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 30 ++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c     | 69 ++---------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c  | 74 ++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h  |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c      | 83 +++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h      |  4 +
 6 files changed, 199 insertions(+), 62 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 2d125b8b15ee..8ec4806c2ff4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -1335,11 +1335,41 @@ static int amdgpu_debugfs_evict_gtt(struct seq_file *m, void *data)
 	return 0;
 }
 
+static int amdgpu_debugfs_vm_info(struct seq_file *m, void *data)
+{
+	struct drm_info_node *node = (struct drm_info_node *)m->private;
+	struct drm_device *dev = node->minor->dev;
+	struct drm_file *file;
+	int r;
+
+	r = mutex_lock_interruptible(&dev->filelist_mutex);
+	if (r)
+		return r;
+
+	list_for_each_entry(file, &dev->filelist, lhead) {
+		struct amdgpu_fpriv *fpriv = file->driver_priv;
+		struct amdgpu_vm *vm = &fpriv->vm;
+
+		seq_printf(m, "pid:%d\tProcess:%s ----------\n",
+				vm->task_info.pid, vm->task_info.process_name);
+		r = amdgpu_bo_reserve(vm->root.base.bo, true);
+		if (r)
+			break;
+		amdgpu_debugfs_vm_bo_info(vm, m);
+		amdgpu_bo_unreserve(vm->root.base.bo);
+	}
+
+	mutex_unlock(&dev->filelist_mutex);
+
+	return r;
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
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index f4c2e2e75b8f..6197c5ce744c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -826,67 +826,6 @@ int amdgpu_mode_dumb_create(struct drm_file *file_priv,
 }
 
 #if defined(CONFIG_DEBUG_FS)
-
-#define amdgpu_debugfs_gem_bo_print_flag(m, bo, flag)	\
-	if (bo->flags & (AMDGPU_GEM_CREATE_ ## flag)) {	\
-		seq_printf((m), " " #flag);		\
-	}
-
-static int amdgpu_debugfs_gem_bo_info(int id, void *ptr, void *data)
-{
-	struct drm_gem_object *gobj = ptr;
-	struct amdgpu_bo *bo = gem_to_amdgpu_bo(gobj);
-	struct seq_file *m = data;
-
-	struct dma_buf_attachment *attachment;
-	struct dma_buf *dma_buf;
-	unsigned domain;
-	const char *placement;
-	unsigned pin_count;
-
-	domain = amdgpu_mem_type_to_domain(bo->tbo.mem.mem_type);
-	switch (domain) {
-	case AMDGPU_GEM_DOMAIN_VRAM:
-		placement = "VRAM";
-		break;
-	case AMDGPU_GEM_DOMAIN_GTT:
-		placement = " GTT";
-		break;
-	case AMDGPU_GEM_DOMAIN_CPU:
-	default:
-		placement = " CPU";
-		break;
-	}
-	seq_printf(m, "\t0x%08x: %12ld byte %s",
-		   id, amdgpu_bo_size(bo), placement);
-
-	pin_count = READ_ONCE(bo->pin_count);
-	if (pin_count)
-		seq_printf(m, " pin count %d", pin_count);
-
-	dma_buf = READ_ONCE(bo->tbo.base.dma_buf);
-	attachment = READ_ONCE(bo->tbo.base.import_attach);
-
-	if (attachment)
-		seq_printf(m, " imported from %p%s", dma_buf,
-			   attachment->peer2peer ? " P2P" : "");
-	else if (dma_buf)
-		seq_printf(m, " exported as %p", dma_buf);
-
-	amdgpu_debugfs_gem_bo_print_flag(m, bo, CPU_ACCESS_REQUIRED);
-	amdgpu_debugfs_gem_bo_print_flag(m, bo, NO_CPU_ACCESS);
-	amdgpu_debugfs_gem_bo_print_flag(m, bo, CPU_GTT_USWC);
-	amdgpu_debugfs_gem_bo_print_flag(m, bo, VRAM_CLEARED);
-	amdgpu_debugfs_gem_bo_print_flag(m, bo, SHADOW);
-	amdgpu_debugfs_gem_bo_print_flag(m, bo, VRAM_CONTIGUOUS);
-	amdgpu_debugfs_gem_bo_print_flag(m, bo, VM_ALWAYS_VALID);
-	amdgpu_debugfs_gem_bo_print_flag(m, bo, EXPLICIT_SYNC);
-
-	seq_printf(m, "\n");
-
-	return 0;
-}
-
 static int amdgpu_debugfs_gem_info(struct seq_file *m, void *data)
 {
 	struct drm_info_node *node = (struct drm_info_node *)m->private;
@@ -900,6 +839,8 @@ static int amdgpu_debugfs_gem_info(struct seq_file *m, void *data)
 
 	list_for_each_entry(file, &dev->filelist, lhead) {
 		struct task_struct *task;
+		struct drm_gem_object *gobj;
+		int id;
 
 		/*
 		 * Although we have a valid reference on file->pid, that does
@@ -914,7 +855,11 @@ static int amdgpu_debugfs_gem_info(struct seq_file *m, void *data)
 		rcu_read_unlock();
 
 		spin_lock(&file->table_lock);
-		idr_for_each(&file->object_idr, amdgpu_debugfs_gem_bo_info, m);
+		idr_for_each_entry(&file->object_idr, gobj, id) {
+			struct amdgpu_bo *bo = gem_to_amdgpu_bo(gobj);
+
+			amdgpu_bo_print_info(id, bo, m);
+		}
 		spin_unlock(&file->table_lock);
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 2ce79bccfc30..0fa5de0f1dc1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -1528,3 +1528,77 @@ uint32_t amdgpu_bo_get_preferred_pin_domain(struct amdgpu_device *adev,
 	}
 	return domain;
 }
+
+#if defined(CONFIG_DEBUG_FS)
+#define amdgpu_bo_print_flag(m, bo, flag)		        \
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
+ * @m: debugfs file
+ *
+ * Print BO information in debugfs file
+ *
+ * Returns:
+ * Size of the BO in bytes.
+ */
+u64 amdgpu_bo_print_info(int id, struct amdgpu_bo *bo, struct seq_file *m)
+{
+	struct dma_buf_attachment *attachment;
+	struct dma_buf *dma_buf;
+	unsigned int domain;
+	const char *placement;
+	unsigned int pin_count;
+	u64 size;
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
+	seq_printf(m, "\t\t0x%08x: %12lld byte %s",
+			id, size, placement);
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
+	amdgpu_bo_print_flag(m, bo, CPU_ACCESS_REQUIRED);
+	amdgpu_bo_print_flag(m, bo, NO_CPU_ACCESS);
+	amdgpu_bo_print_flag(m, bo, CPU_GTT_USWC);
+	amdgpu_bo_print_flag(m, bo, VRAM_CLEARED);
+	amdgpu_bo_print_flag(m, bo, SHADOW);
+	amdgpu_bo_print_flag(m, bo, VRAM_CONTIGUOUS);
+	amdgpu_bo_print_flag(m, bo, VM_ALWAYS_VALID);
+	amdgpu_bo_print_flag(m, bo, EXPLICIT_SYNC);
+
+	seq_puts(m, "\n");
+
+	return size;
+}
+#endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
index afa5189dba7d..5e0311e4c198 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
@@ -330,6 +330,7 @@ void amdgpu_sa_bo_free(struct amdgpu_device *adev,
 #if defined(CONFIG_DEBUG_FS)
 void amdgpu_sa_bo_dump_debug_info(struct amdgpu_sa_manager *sa_manager,
 					 struct seq_file *m);
+u64 amdgpu_bo_print_info(int id, struct amdgpu_bo *bo, struct seq_file *m);
 #endif
 int amdgpu_debugfs_sa_init(struct amdgpu_device *adev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 3cd949aad500..122814c3ff5f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -3392,3 +3392,86 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, unsigned int pasid,
 
 	return false;
 }
+
+#if defined(CONFIG_DEBUG_FS)
+/**
+ * amdgpu_debugfs_vm_bo_info  - print BO info for the VM
+ *
+ * @vm: Requested VM for printing BO info
+ * @m: debugfs file
+ *
+ * Print BO information in debugfs file for the VM
+ */
+void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm *vm, struct seq_file *m)
+{
+	struct amdgpu_bo_va *bo_va, *tmp;
+	u64 total_idle = 0;
+	u64 total_evicted = 0;
+	u64 total_relocated = 0;
+	u64 total_moved = 0;
+	u64 total_invalidated = 0;
+	unsigned int total_idle_objs = 0;
+	unsigned int total_evicted_objs = 0;
+	unsigned int total_relocated_objs = 0;
+	unsigned int total_moved_objs = 0;
+	unsigned int total_invalidated_objs = 0;
+	unsigned int id = 0;
+
+	seq_puts(m, "\tIdle BOs:\n");
+	list_for_each_entry_safe(bo_va, tmp, &vm->idle, base.vm_status) {
+		if (!bo_va->base.bo)
+			continue;
+		total_idle += amdgpu_bo_print_info(id++, bo_va->base.bo, m);
+	}
+	total_idle_objs = id;
+	id = 0;
+
+	seq_puts(m, "\tEvicted BOs:\n");
+	list_for_each_entry_safe(bo_va, tmp, &vm->evicted, base.vm_status) {
+		if (!bo_va->base.bo)
+			continue;
+		total_evicted += amdgpu_bo_print_info(id++, bo_va->base.bo, m);
+	}
+	total_evicted_objs = id;
+	id = 0;
+
+	seq_puts(m, "\tRelocated BOs:\n");
+	list_for_each_entry_safe(bo_va, tmp, &vm->relocated, base.vm_status) {
+		if (!bo_va->base.bo)
+			continue;
+		total_relocated += amdgpu_bo_print_info(id++, bo_va->base.bo, m);
+	}
+	total_relocated_objs = id;
+	id = 0;
+
+	seq_puts(m, "\tMoved BOs:\n");
+	list_for_each_entry_safe(bo_va, tmp, &vm->moved, base.vm_status) {
+		if (!bo_va->base.bo)
+			continue;
+		total_moved += amdgpu_bo_print_info(id++, bo_va->base.bo, m);
+	}
+	total_moved_objs = id;
+	id = 0;
+
+	seq_puts(m, "\tInvalidated BOs:\n");
+	spin_lock(&vm->invalidated_lock);
+	list_for_each_entry_safe(bo_va, tmp, &vm->invalidated, base.vm_status) {
+		if (!bo_va->base.bo)
+			continue;
+		total_invalidated += amdgpu_bo_print_info(id++,	bo_va->base.bo, m);
+	}
+	spin_unlock(&vm->invalidated_lock);
+	total_invalidated_objs = id;
+
+	seq_printf(m, "\tTotal idle size:        %12lld\tobjs:\t%d\n", total_idle,
+		   total_idle_objs);
+	seq_printf(m, "\tTotal evicted size:     %12lld\tobjs:\t%d\n", total_evicted,
+		   total_evicted_objs);
+	seq_printf(m, "\tTotal relocated size:   %12lld\tobjs:\t%d\n", total_relocated,
+		   total_relocated_objs);
+	seq_printf(m, "\tTotal moved size:       %12lld\tobjs:\t%d\n", total_moved,
+		   total_moved_objs);
+	seq_printf(m, "\tTotal invalidated size: %12lld\tobjs:\t%d\n", total_invalidated,
+		   total_invalidated_objs);
+}
+#endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 7c46937c1c0e..74cc14179c41 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -441,4 +441,8 @@ void amdgpu_vm_move_to_lru_tail(struct amdgpu_device *adev,
 				struct amdgpu_vm *vm);
 void amdgpu_vm_del_from_lru_notify(struct ttm_buffer_object *bo);
 
+#if defined(CONFIG_DEBUG_FS)
+void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm *vm, struct seq_file *m);
+#endif
+
 #endif
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
