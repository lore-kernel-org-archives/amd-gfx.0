Return-Path: <SRS0=L/30=DT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6E0CC433E7
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Oct 2020 09:02:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB7AA20773
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Oct 2020 09:02:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="r5wcMVMl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB7AA20773
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E0206E0CE;
	Mon, 12 Oct 2020 09:02:40 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760058.outbound.protection.outlook.com [40.107.76.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E7EA6E42A
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Oct 2020 09:02:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JnHOEUVJvoafqcXGaYx6YsbehedmhS8EQWfTEVgyPDYqs5gMzGwMNijQ6SChDpwpXJoJIea4HtyvB7azJ8BXC1AN2unOgcFGiF09LeA/nTlJaRn41B2dG10jeYB9Y8fIl3hj2S/n6KVSPT77DvDdE8NkrNADIBSe0ors0y6CShfdvrsd0fMc62QjzW3GWlI4tmdR4UnsAHGbI0bjt0mKcyKqY3PNgS8etxmBPg3E8XIAPIWeb2NoZ1FuqmdrzoMctWEWCQwVahiq8XrndseU0ltVpnZBjnIOHmMqF7baeLAjO0VaIUlwpW4kbL/MsE3u8JnulMDDVJm5g+rYcXSeDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QUDrAcc1zZHjcTm90IgfijGuWtwSa13lzxj9ulqJXbE=;
 b=oGzwt8xxQTdM+w/Zl1wdsmKX6unlYIv3Z8Tu06Ca59+IIXwSEVOe16QMfSZ6SRHlLNiO+WQuzUMuLraOp2vyjz705mUVxQg3JXVweYdl3/LhHFKgqPkKtTCHNgk9QFMP5OLoLCLjc9SllpVJ01AjKOqlqKzhspJN6I0KxObRbENkDwm1wtRcSnYwSZK0gYKOEuctreUnj4qps0P8E3humD2kHEdRxtB3lCNLIQQrOa1ZoP7Nh6TPp1tyEA5tyMkQPqofj9R+J8niRfJZPmUP7W7NskV83uKHAu67Or1Uni5bJgQn2I479e1aMsq02qeNVaamkxBb8A3oBGycIRkGqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QUDrAcc1zZHjcTm90IgfijGuWtwSa13lzxj9ulqJXbE=;
 b=r5wcMVMlONZREvqq0qP2AT1Pzg9OxesYR6kf8KWDzMig6IYwh+aqgd0eTCw4kWQnPq10fBLE9NuBwzwl8tmr4lO6G5XI6fulAsVZhyw6a3b3cBFrQRPj6+iMZ1qdqCl/wWSb45gl5prrnahZWMvRGCeLt1BtTQa5YbxUltuo4uw=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4452.namprd12.prod.outlook.com (2603:10b6:5:2a4::17)
 by DM6PR12MB2634.namprd12.prod.outlook.com (2603:10b6:5:49::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.21; Mon, 12 Oct
 2020 09:02:36 +0000
Received: from DM6PR12MB4452.namprd12.prod.outlook.com
 ([fe80::3061:cd92:9bf4:8380]) by DM6PR12MB4452.namprd12.prod.outlook.com
 ([fe80::3061:cd92:9bf4:8380%6]) with mapi id 15.20.3455.030; Mon, 12 Oct 2020
 09:02:36 +0000
From: Mihir Patel <mihir.patel@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v3] drm/amdgpu: Add debugfs entry for printing VM info
Date: Mon, 12 Oct 2020 14:31:59 +0530
Message-Id: <20201012090159.28825-1-mihir.patel@amd.com>
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [183.83.139.166]
X-ClientProxiedBy: MA1PR01CA0154.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::24) To DM6PR12MB4452.namprd12.prod.outlook.com
 (2603:10b6:5:2a4::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mihirp-navi14.amd.com (183.83.139.166) by
 MA1PR01CA0154.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:71::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3455.23 via Frontend Transport; Mon, 12 Oct 2020 09:02:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 660f4e4f-bce6-471e-d215-08d86e8d9067
X-MS-TrafficTypeDiagnostic: DM6PR12MB2634:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB2634FF2A3EE52D8974212896E8070@DM6PR12MB2634.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1227;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t6KdA+I35P3M56B4MBeuVZf/baJaVIByfYprKEThUnTG3FfJSAOxLOphYaIgcZ/rryR4amm0IdrdZaOiyjbZJfTdjYRg6dCePDy8t9iLaWq6rK8n8AQymXf1Ajs/NL0Qh8cVEvS6o9oU58kY6xv2Fv2BqRfzGTuDZvn4T6GydG9VIMH4dB7RHUc4rbthbF2WLZDGiarhzvO+oieCbDWzGaPj0dwzYMFHYAk/dJROK9On4+p86VEPYWAJCtLsu9CLTP6M3XjJqosGX3PvX9uUVcc4Be3K/PFGqCHNh2glO+Pa95cbL2qkbCKPgR+DNalOJQ74I+9sN4p7TVsmjzK2gg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4452.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(39860400002)(346002)(396003)(376002)(366004)(26005)(44832011)(1076003)(7696005)(86362001)(5660300002)(52116002)(956004)(2906002)(36756003)(6486002)(8936002)(8676002)(4326008)(186003)(16526019)(66946007)(6666004)(30864003)(2616005)(6916009)(66556008)(83380400001)(316002)(478600001)(66476007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: iNsx4abUtW4yMgkXMCM66TqOtiedW9/DMW779BHivbuK6ky5XbXaLPgcZViYxOp/djrQmOSkI81lSnOApccq7jI1JlimJfElPm7/hCgUwcv+QWX7TtINAccKaHWhOXP/ZlhonYkDH1Ly+wHfRBwpwUzEfISUG41Ien0Ql0DIya+nuxPRfKw44yC7jB/YcYgKqVQd3SDMoXRCzNs2N+NDBOJg5XDTVfqfPAXqszxUmWA78ggOX8k/HKWQHbSxRpdYOq1wdJmna01KqQIobgtqfK4OgT5xYXY3xlzTOiaEVbpDvhZgAVTvpSc5sI5OejNR4nfidyT2spG5BXDRShFPywsR9/KEPvXFQUB8g8yK/mPYsysRE2/3Ds2zMVMr9p2RB+61CtqiOHPsyNla3IIEOYljNvQ2U6V6leaXKVPDzseUP6qehCwv43nOlTzWNeY7e8PI/8NGHEZoBgLE4dr5LCgoUqx0DLQNxfhumffl4soiItsSBQVfLkpB15f70b9tRxvUqFkcMGhIaZeuW6YFIENntfdG71FFb9V/YO74TFtpPfU/puO04+zwYtLhzm1+N3zLcZ47YmtzfgzZYs1kf05xtqPqrNuLa7LNKa6p4ZIvf5BvlIJ88EDB17wTHRpaFdm2ktxh0QZFQVdbuTJo4A==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 660f4e4f-bce6-471e-d215-08d86e8d9067
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4452.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2020 09:02:36.8587 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g4KSz780bil6ocD/sCENa8AZCsGACMIbajN2BwKqlVrA0oN0pva4m3sTLJUa2M/WQXOt+tD0B6S/EWeGe3nEcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2634
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

Pending:
- Consolidated memory utilization info like total, swap etc.

V2: Added Common function for printing BO info.
    Dump more VM lists for evicted, moved, relocated, invalidated.
    Removed dumping VM mapped BOs.
V3: Fixed coding style comments, renamed print API and variables.

Signed-off-by: Mihir Bhogilal Patel <Mihir.Patel@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 30 +++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c     | 69 ++--------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c  | 74 +++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h  |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c      | 88 +++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h      |  4 +
 6 files changed, 204 insertions(+), 62 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 2d125b8b15ee..0b41b8b72ba3 100644
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
+			continue;
+		amdgpu_debugfs_vm_bo_info(vm, m);
+		amdgpu_bo_unreserve(vm->root.base.bo);
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
index 2ce79bccfc30..f4142b7a3c59 100644
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
+ * @data: debugfs file
+ *
+ * Print BO information in debugfs file
+ *
+ * Returns:
+ * Size of the BO in bytes.
+ */
+unsigned long amdgpu_bo_print_info(int id, struct amdgpu_bo *bo, struct seq_file *m)
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
index afa5189dba7d..06fbff49958d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
@@ -330,6 +330,7 @@ void amdgpu_sa_bo_free(struct amdgpu_device *adev,
 #if defined(CONFIG_DEBUG_FS)
 void amdgpu_sa_bo_dump_debug_info(struct amdgpu_sa_manager *sa_manager,
 					 struct seq_file *m);
+unsigned long amdgpu_bo_print_info(int id, struct amdgpu_bo *bo, struct seq_file *m);
 #endif
 int amdgpu_debugfs_sa_init(struct amdgpu_device *adev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 3cd949aad500..0e1cb399e508 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -3392,3 +3392,91 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, unsigned int pasid,
 
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
+	/* Print info for Idle BOs */
+	seq_puts(m, "\tIdle BOs:\n");
+	list_for_each_entry_safe(bo_va, tmp, &vm->idle, base.vm_status) {
+		if (!bo_va->base.bo)
+			continue;
+		total_idle += amdgpu_bo_print_info(id++, bo_va->base.bo, m);
+	}
+	total_idle_objs = id;
+	id = 0;
+
+	/* Print info for Evicted BOs */
+	seq_puts(m, "\tEvicted BOs:\n");
+	list_for_each_entry_safe(bo_va, tmp, &vm->evicted, base.vm_status) {
+		if (!bo_va->base.bo)
+			continue;
+		total_evicted += amdgpu_bo_print_info(id++, bo_va->base.bo, m);
+	}
+	total_evicted_objs = id;
+	id = 0;
+
+	/* Print info for Relocated BOs */
+	seq_puts(m, "\tRelocated BOs:\n");
+	list_for_each_entry_safe(bo_va, tmp, &vm->relocated, base.vm_status) {
+		if (!bo_va->base.bo)
+			continue;
+		total_relocated += amdgpu_bo_print_info(id++, bo_va->base.bo, m);
+	}
+	total_relocated_objs = id;
+	id = 0;
+
+	/* Print info for Moved BOs */
+	seq_puts(m, "\tMoved BOs:\n");
+	list_for_each_entry_safe(bo_va, tmp, &vm->moved, base.vm_status) {
+		if (!bo_va->base.bo)
+			continue;
+		total_moved += amdgpu_bo_print_info(id++, bo_va->base.bo, m);
+	}
+	total_moved_objs = id;
+	id = 0;
+
+	/* Print info for Invalidated BOs */
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
+								total_idle_objs);
+	seq_printf(m, "\tTotal evicted size:     %12lld\tobjs:\t%d\n", total_evicted,
+								total_evicted_objs);
+	seq_printf(m, "\tTotal relocated size:   %12lld\tobjs:\t%d\n", total_relocated,
+								total_relocated_objs);
+	seq_printf(m, "\tTotal moved size:       %12lld\tobjs:\t%d\n", total_moved,
+								total_moved_objs);
+	seq_printf(m, "\tTotal invalidated size: %12lld\tobjs:\t%d\n", total_invalidated,
+								total_invalidated_objs);
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
