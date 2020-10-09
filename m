Return-Path: <SRS0=3Gw3=DQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2271C433DF
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Oct 2020 11:40:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DB8C22284
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Oct 2020 11:40:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="k1rYcZrW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DB8C22284
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C40696ECC6;
	Fri,  9 Oct 2020 11:40:51 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2061.outbound.protection.outlook.com [40.107.237.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A65E6ECC6
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Oct 2020 11:40:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bmtSj0927BE+Cxh4WytUlNyvlozxmXTr3FUGPc16HB3VaWVJ5gSALxSnHu/gQvyNlqfJW6ykYaSwZFoSbloyqDB6l5FopCHEyGeUBhFFqqnrMsCkH3gwvD+BhVsn7iedQAsNAQzmTXGaC1QbOMDMf+hbV6Fap4wQt+EBfYDkr4XYiVMlRE96fNogHhUo9fIVZeEAhqB9vwqebQWPzvIuRsBJdviod984GbSLO1kncYkq115tPMOrDKINl1oeUPmx0lzAuVEsC4Dlu90ryaqVByQY2oc2Vnbpjq+7aADbnJpDjmgRHQrlWEP72xv+ENprBXzKa+WsCFg8Zom+SlUs+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P0SFxLhIThnh5FzAc2lLPvaUUOXhy/OShJCRevR7duM=;
 b=ZjBbmU/dgUhdxWxWAjoiB6ntmR1UJxIfzxgPlYKEZyA1fih0KxcESZIWJgx+5NHAWPTntRCcBKlQHQy/tforL3Cd2kYVO9sWcmfAJSLYpO+WRxV3AV2pIZyyS1bh2/jYnPNlKj86nvtJhFOJzntvBUM0S+mjHTF9sZ+Jq3dCDemdIV2QU/6yJI/TOmL0qzmBasHeMqdwD50Va11hG9Sq6WPvrtqclACJCs2LS3QZDHKrHsH1Qpc/4TsUeTjUfwENlcod67L8mkpkMLmDDrPk2xkMQws2pCE2hXQKNCaehL6Is5NDSAbHySc4LnmgNUDVAOAKa4PhUuIw3sNJKFOFNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P0SFxLhIThnh5FzAc2lLPvaUUOXhy/OShJCRevR7duM=;
 b=k1rYcZrWt5IZ0LRvovdEq4T9IuQQp1rV0DEopPlUiNDK+L3fKFWuR3tk8ttWWtW/zTotBz8wHcn3PJ+lEHs2faBiwAVnVurzUUWmn6+qNgREAPMh4AfCr5QAzhnKY6MxjMDjKKF6l6qxu3mfOGOQ8Uqr6LmRd7H6I7gZAcO0PU4=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4452.namprd12.prod.outlook.com (2603:10b6:5:2a4::17)
 by DM6PR12MB3531.namprd12.prod.outlook.com (2603:10b6:5:18b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.24; Fri, 9 Oct
 2020 11:40:48 +0000
Received: from DM6PR12MB4452.namprd12.prod.outlook.com
 ([fe80::3061:cd92:9bf4:8380]) by DM6PR12MB4452.namprd12.prod.outlook.com
 ([fe80::3061:cd92:9bf4:8380%6]) with mapi id 15.20.3455.027; Fri, 9 Oct 2020
 11:40:48 +0000
From: Mihir Patel <mihir.patel@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v2] drm/amdgpu: Add debugfs entry for printing VM info
Date: Fri,  9 Oct 2020 17:10:25 +0530
Message-Id: <20201009114025.42904-1-mihir.patel@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.159.242]
X-ClientProxiedBy: BMXPR01CA0041.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:c::27) To DM6PR12MB4452.namprd12.prod.outlook.com
 (2603:10b6:5:2a4::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mihirp-navi14.amd.com (165.204.159.242) by
 BMXPR01CA0041.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:c::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3455.21 via Frontend Transport; Fri, 9 Oct 2020 11:40:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 039393e7-c912-440f-1c5a-08d86c482aba
X-MS-TrafficTypeDiagnostic: DM6PR12MB3531:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB35313099A0200205DF661CDFE8080@DM6PR12MB3531.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1227;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SAE5cj5FDayspVhI4WyIWfa/J80aoZN9lhH1JC3env0XQrLeEAePDDTh+zfyqjFMXmDvjv6YdEEdrszvK+FHFjb99fzfTq3+P04tTs75IaHV3I0KUzVf7aoEP5pJ4AAffmutEptiw3rz/ND2qV2EJ3IR054IOjDZL6FJAwXtc5ZTK0y8FyG4A2yUvYFDQQ/dFZ2eiburazOwLJLiIjTopswxfIgOwTjYUPYm9TfzdvW5KfEeahpvjonFdTH+kVldYlTdg+uK3A8GG0ExUBwAK6Wvt9yEWLcvSS7vr6Q2R/gd1601F9MymOlOF+LWKa1TIaZQmD48QnJx1xY0S3COrg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4452.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(366004)(346002)(376002)(136003)(2616005)(52116002)(66946007)(16526019)(30864003)(86362001)(1076003)(83380400001)(316002)(36756003)(44832011)(8936002)(8676002)(2906002)(186003)(956004)(4326008)(6486002)(7696005)(26005)(66476007)(6916009)(478600001)(5660300002)(6666004)(66556008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: uaGWKyzSC9iAwJm9kAVfIOh5DZjvHw8L49LDVQlkrPTEanzuW7yTAaTzpD02fkHw399kfnFL0zPUns5Hocv+XSvm8MELUj3SkB9lfwDytk2WSKe7LFeU9j9Ioxv1OI+5PY3jqEyO2HPnChWSeBFYgYQKw1zsjQypxbL+cppQ4gnWtfYa1Rugzgr+byU/Q2UN6lDsWnceeE9QgrTqrZvK1XjEI3mE+Q/GjHhbnoS9hW1NEw8S7FROzlSyehI/6dbwV1d2LvmO1kPbZQ4t/MaYsohhG3bb1NlUwOFKmCMMHX09WZaZ6bDCuXUPkUHcthiu/q9dMe+S88GIeXfmUOuy7FcNiRj6Ch9SuUOw5U2n6OrLsVtMYZyes7vXfi7NFSLVw47jMrIOX3hp9qjyvlPX7Ie68tcqeo+H8lCDz9+2KuY4jbVXCc8rqH6FwtVBfVitYlXVi14zlT4HDDDrjhoVtoQoItnPfTQlbObgEZ7drLYn/cYdxa35jrzE23yBZJ5G/NRxQ7LcVrO4/RH3U10KyRtt0rpxO6HhKMR4vxmz0fuLsXpuSdRtJ4qWWNcfqaEVB8Tk1LlKzsOHmaIUG4MNOFuKhKBDaE3Y0lQAwN29YiEkNVYbZjBAB3khXE7VOAZGBiMqzd7TR97x0GZ4n21Prw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 039393e7-c912-440f-1c5a-08d86c482aba
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4452.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2020 11:40:48.5340 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aKGZP9WAdxOlh8JOdDReehFY8/dwiYYpeYICvuXdeOhLPNbVIDNyrpbZ+3FHJ3tYuP2MWHm17CTzOUKPOEt2sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3531
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

Note: Early upload for discussion and review
Pending:
- Add proper locking
- Print UID information
- Consolidated memory utilization info like total, swap etc.

V2: Added Common function for printing BO info.
    Dump more VM lists for evicted, moved, relocated, invalidated.
    Removed dumping VM mapped BOs.

Signed-off-by: Mihir Bhogilal Patel <Mihir.Patel@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 26 +++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c     | 69 ++---------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c  | 74 ++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h  |  2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c      | 86 +++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h      |  4 +
 6 files changed, 199 insertions(+), 62 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 2d125b8b15ee..1986b688f046 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -1335,11 +1335,37 @@ static int amdgpu_debugfs_evict_gtt(struct seq_file *m, void *data)
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
+		amdgpu_debugfs_vm_bo_info(vm, m);
+	}
+
+	mutex_unlock(&dev->filelist_mutex);
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
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index f4c2e2e75b8f..f009d17c0aca 100644
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
+			amdgpu_debugfs_print_bo_info(id, bo, m);
+		}
 		spin_unlock(&file->table_lock);
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 2ce79bccfc30..c6172a6e6877 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -1528,3 +1528,77 @@ uint32_t amdgpu_bo_get_preferred_pin_domain(struct amdgpu_device *adev,
 	}
 	return domain;
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
+unsigned long amdgpu_debugfs_print_bo_info(int id, struct amdgpu_bo *bo, struct seq_file *m)
+{
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
+			id++, size, placement);
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
+	seq_puts(m, "\n");
+
+	return size;
+}
+#endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
index afa5189dba7d..3d2a9515f462 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
@@ -330,6 +330,8 @@ void amdgpu_sa_bo_free(struct amdgpu_device *adev,
 #if defined(CONFIG_DEBUG_FS)
 void amdgpu_sa_bo_dump_debug_info(struct amdgpu_sa_manager *sa_manager,
 					 struct seq_file *m);
+unsigned long amdgpu_debugfs_print_bo_info(int id, struct amdgpu_bo *bo,
+						struct seq_file *m);
 #endif
 int amdgpu_debugfs_sa_init(struct amdgpu_device *adev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 3cd949aad500..820c980467f2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -3392,3 +3392,89 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, unsigned int pasid,
 
 	return false;
 }
+
+#if defined(CONFIG_DEBUG_FS)
+/**
+ * amdgpu_debugfs_vm_bo_info  - print BO info for the VM
+ *
+ * @vm: Requested VM for printing BO info
+ * @data: debugfs file
+ *
+ * Print BO information in debugfs file for the VM
+ */
+void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm *vm, struct seq_file *m)
+{
+	struct amdgpu_bo_va *bo_va, *tmp;
+	unsigned long long total_idle_size = 0;
+	unsigned long long total_evicted_size = 0;
+	unsigned long long total_relocated_size = 0;
+	unsigned long long total_moved_size = 0;
+	unsigned long long total_invalidated_size = 0;
+	unsigned int total_idle_objs = 0;
+	unsigned int total_evicted_objs = 0;
+	unsigned int total_relocated_objs = 0;
+	unsigned int total_moved_objs = 0;
+	unsigned int total_invalidated_objs = 0;
+	unsigned int id = 0;
+
+	/* Print info for Idle BOs */
+	seq_puts(m, "\tIdle BOs:\n");
+	list_for_each_entry_safe(bo_va, tmp, &vm->idle, base.vm_status) {
+		if (bo_va && bo_va->base.bo)
+			total_idle_size += amdgpu_debugfs_print_bo_info(id++,
+								bo_va->base.bo, m);
+	}
+	total_idle_objs = id;
+	id = 0;
+
+	/* Print info for Evicted BOs */
+	seq_puts(m, "\tEvicted BOs:\n");
+	list_for_each_entry_safe(bo_va, tmp, &vm->evicted, base.vm_status) {
+		if (bo_va && bo_va->base.bo)
+			total_evicted_size += amdgpu_debugfs_print_bo_info(id++,
+								bo_va->base.bo, m);
+	}
+	total_evicted_objs = id;
+	id = 0;
+
+	/* Print info for Relocated BOs */
+	seq_puts(m, "\tRelocated BOs:\n");
+	list_for_each_entry_safe(bo_va, tmp, &vm->relocated, base.vm_status) {
+		if (bo_va && bo_va->base.bo)
+			total_relocated_size += amdgpu_debugfs_print_bo_info(id++,
+								bo_va->base.bo, m);
+	}
+	total_relocated_objs = id;
+	id = 0;
+
+	/* Print info for Moved BOs */
+	seq_puts(m, "\tMoved BOs:\n");
+	list_for_each_entry_safe(bo_va, tmp, &vm->moved, base.vm_status) {
+		if (bo_va && bo_va->base.bo)
+			total_moved_size += amdgpu_debugfs_print_bo_info(id++,
+								bo_va->base.bo, m);
+	}
+	total_moved_objs = id;
+	id = 0;
+
+	/* Print info for Invalidated BOs */
+	seq_puts(m, "\tInvalidated BOs:\n");
+	list_for_each_entry_safe(bo_va, tmp, &vm->invalidated, base.vm_status) {
+		if (bo_va && bo_va->base.bo)
+			total_invalidated_size += amdgpu_debugfs_print_bo_info(id++,
+								bo_va->base.bo, m);
+	}
+	total_invalidated_objs = id;
+
+	seq_printf(m, "\tTotal idle size:        %12lld\tobjs:\t%d\n", total_idle_size,
+									total_idle_objs);
+	seq_printf(m, "\tTotal evicted size:     %12lld\tobjs:\t%d\n", total_evicted_size,
+									total_evicted_objs);
+	seq_printf(m, "\tTotal relocated size:   %12lld\tobjs:\t%d\n", total_relocated_size,
+									total_relocated_objs);
+	seq_printf(m, "\tTotal moved size:       %12lld\tobjs:\t%d\n", total_moved_size,
+									total_moved_objs);
+	seq_printf(m, "\tTotal invalidated size: %12lld\tobjs:\t%d\n", total_invalidated_size,
+									 total_invalidated_objs);
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
