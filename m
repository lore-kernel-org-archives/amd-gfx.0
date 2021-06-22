Return-Path: <SRS0=0Dgm=LQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B28CC2B9F4
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Jun 2021 13:32:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDA0A613B1
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Jun 2021 13:32:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDA0A613B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97BBA6E508;
	Tue, 22 Jun 2021 13:32:39 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2072.outbound.protection.outlook.com [40.107.100.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB9266E069
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Jun 2021 13:32:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JavUO+Ydp0j3uAtDJkr/dnq1zALfiQptJPIz0c+N+V5L01GWvN1KQhNBZvTbtZ9SsBuPFuZ9k8xAqY1M/GpIlX31JzKihD6rYN3b4TLPIIEFQ4EERTlXM1jw/Sg42tiCiwweQemd19fYDbYlGdLyAiYb7f433XnxbvfYJirqIaFwCiHX0kIgv63lhs0TFFnTvVEFQ1+pm4OrKFSJn2Hawf2xAzPuodctmu1FSmpAZ4iqKBWWY67ClpT4x8enaaBBbxBk4Lr42JnKE77HI7Q6g3Vm8a+yI1GaQw3JpRS8aRc+tcWOglC3biD9uuh2KAZpRAehDxLP2HZBheppYfmrsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d44pyZmDrFg6Dso6J4iYLgbJupTsFHlNH1iqwO1ZAAE=;
 b=YSgwmpT5sk965toEOBfIYDJXEpURBwoXxA0PwbAzOpy5D1QLXZCwhJrbKCOUcByYq3deENY6opVbXMAj+2c7hLSGLnUNgnVTOhiGtCEHS3UpadUEp6USuWqV3ONBv9pyEVO4+TI49ynBe8e7S2BjTW/GI5FIGW53seCIFcGcKhuEACCX8u2T5zJqcw8rOhpvBC1XI4y8eECJmuZIUfwgUPhwkQHEZbt06pQzNUfycYneEt+Ioc5Zzw/Px1J0xdlVSP46rhDKUz+84kjWyR+FeEmp+PLu6UH/m7DrxheIazn+gDMGWmLLLCg9JLJR/I/7+DDQEITyWMxUcgWMRI4PNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d44pyZmDrFg6Dso6J4iYLgbJupTsFHlNH1iqwO1ZAAE=;
 b=pZL4eiSKnZGra67hUTe0KV699EiY3j2JjFNIRqoIce/grKyoXQhY1kzNkgf9YKVIvmP9adklPXMQ2eli7Z+QQNM+eH4fJ8AxmkMOEAlOKhl+Z2DAzKDuC82nOxC62GMTYzE4TVwZsiGUkSNQ888l9oq84+JnVAGkFfSkmB1RFdU=
Received: from MW4PR03CA0012.namprd03.prod.outlook.com (2603:10b6:303:8f::17)
 by BN9PR12MB5225.namprd12.prod.outlook.com (2603:10b6:408:11e::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Tue, 22 Jun
 2021 13:32:36 +0000
Received: from CO1NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8f:cafe::e) by MW4PR03CA0012.outlook.office365.com
 (2603:10b6:303:8f::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16 via Frontend
 Transport; Tue, 22 Jun 2021 13:32:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT019.mail.protection.outlook.com (10.13.175.57) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4242.16 via Frontend Transport; Tue, 22 Jun 2021 13:32:35 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 22 Jun
 2021 08:32:34 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/4] drm/amdkfd: add sysfs counters for vm fault and migration
Date: Tue, 22 Jun 2021 09:32:12 -0400
Message-ID: <20210622133213.21393-3-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210622133213.21393-1-Philip.Yang@amd.com>
References: <20210622133213.21393-1-Philip.Yang@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 869ef51f-1544-40b1-94a0-08d93582326e
X-MS-TrafficTypeDiagnostic: BN9PR12MB5225:
X-Microsoft-Antispam-PRVS: <BN9PR12MB52255513ADE094B9BEDA9E81E6099@BN9PR12MB5225.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2331;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6wI18DKZqR01zCanEv3Arjq2T/lpOgbYK8hdmYekNmr1MsVa9JhUO30FBc45kJ2CAvmRTmZYLNEHHg/w7cPbsTfnKJDH4NBnlk9Uu5FVvkNSVwVWXHWAVniHb4aacXF9Uq4Zwv69GUEsNOSqQ55iqop+bxgpLdPL4n4MQV7C2HHaycgBqK513af+2ccatGGGuczxjLVMaOnmbciuMclMDmrMsmWWJsOvaFHs3MGdlkLUOppaq0/FYaog7qQZOySROm4zs5Kf/OyGyzHGeVCvwAr6N9B29xLWQw/1MMADKM3F4Lt2rSb7+b1xLTT7rFyANJoKB+8RxYreKneRaDE+tznU09GWQTP2dBCECfd7XF0BIFKQAQ4iR0QtIWDLc31BGbFJtc+GGAoXqLXrVcMDxdBcmTS1s8KXNOsR9nfWi+prmnXM8rZVIpTzH8osDL9N4HzUFwASaG2ypOhInGruVKwae0X1B3IceDN7AEr8FNg9XlrEVCFESeoMUXKQJCEQkcyCHnXGQieKN0Gd77bUv/SqPV0fgwott2NVGHl/t6eKPLOywAbEJsqahtjarf3Tqb9mOyZbyrD/Xwqg/TAb0C4Z7HXA6GgatgKBsIKIbT7nu8rA/qIcqnt1ELe8LnH7u/yVPzzbFTLyfFe+eZy1Fhd2YKwBIW4Gw+Q+5FnwKFXtcBWhXKvbripD7++JwDI9
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(346002)(39860400002)(376002)(396003)(36840700001)(46966006)(36860700001)(336012)(82310400003)(426003)(6916009)(8936002)(7696005)(478600001)(70586007)(8676002)(70206006)(2616005)(1076003)(316002)(6666004)(86362001)(16526019)(186003)(81166007)(2906002)(47076005)(82740400003)(26005)(5660300002)(4326008)(83380400001)(356005)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2021 13:32:35.6015 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 869ef51f-1544-40b1-94a0-08d93582326e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5225
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
Cc: Philip Yang <Philip.Yang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is part of SVM profiling API, export sysfs counters for
per-process, per-GPU vm retry fault, pages migrated in and out of GPU vram.

counters will not be updated in parallel in GPU retry fault handler and
migration to vram/ram path, use READ_ONCE to avoid compiler
optimization.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h    |   9 ++
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 151 ++++++++++++++++++-----
 2 files changed, 131 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 6dc22fa1e555..3426743ed228 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -730,6 +730,15 @@ struct kfd_process_device {
 	 *  number of CU's a device has along with number of other competing processes
 	 */
 	struct attribute attr_cu_occupancy;
+
+	/* sysfs counters for GPU retry fault and page migration tracking */
+	struct kobject *kobj_counters;
+	struct attribute attr_faults;
+	struct attribute attr_page_in;
+	struct attribute attr_page_out;
+	uint64_t faults;
+	uint64_t page_in;
+	uint64_t page_out;
 };
 
 #define qpd_to_pdd(x) container_of(x, struct kfd_process_device, qpd)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index cfc36fceac8a..21ec8a18cad2 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -416,6 +416,29 @@ static ssize_t kfd_procfs_stats_show(struct kobject *kobj,
 	return 0;
 }
 
+static ssize_t kfd_sysfs_counters_show(struct kobject *kobj,
+				       struct attribute *attr, char *buf)
+{
+	struct kfd_process_device *pdd;
+
+	if (!strcmp(attr->name, "faults")) {
+		pdd = container_of(attr, struct kfd_process_device,
+				   attr_faults);
+		return sysfs_emit(buf, "%llu\n", READ_ONCE(pdd->faults));
+	}
+	if (!strcmp(attr->name, "page_in")) {
+		pdd = container_of(attr, struct kfd_process_device,
+				   attr_page_in);
+		return sysfs_emit(buf, "%llu\n", READ_ONCE(pdd->page_in));
+	}
+	if (!strcmp(attr->name, "page_out")) {
+		pdd = container_of(attr, struct kfd_process_device,
+				   attr_page_out);
+		return sysfs_emit(buf, "%llu\n", READ_ONCE(pdd->page_out));
+	}
+	return 0;
+}
+
 static struct attribute attr_queue_size = {
 	.name = "size",
 	.mode = KFD_SYSFS_FILE_MODE
@@ -456,6 +479,15 @@ static struct kobj_type procfs_stats_type = {
 	.release = kfd_procfs_kobj_release,
 };
 
+static const struct sysfs_ops sysfs_counters_ops = {
+	.show = kfd_sysfs_counters_show,
+};
+
+static struct kobj_type sysfs_counters_type = {
+	.sysfs_ops = &sysfs_counters_ops,
+	.release = kfd_procfs_kobj_release,
+};
+
 int kfd_procfs_add_queue(struct queue *q)
 {
 	struct kfd_process *proc;
@@ -544,6 +576,50 @@ static void kfd_procfs_add_sysfs_stats(struct kfd_process *p)
 	}
 }
 
+static void kfd_procfs_add_sysfs_counters(struct kfd_process *p)
+{
+	int ret = 0;
+	int i;
+	char counters_dir_filename[MAX_SYSFS_FILENAME_LEN];
+
+	if (!p || !p->kobj)
+		return;
+
+	/*
+	 * Create sysfs files for each GPU which supports SVM
+	 * - proc/<pid>/counters_<gpuid>/
+	 * - proc/<pid>/counters_<gpuid>/faults
+	 * - proc/<pid>/counters_<gpuid>/page_in
+	 * - proc/<pid>/counters_<gpuid>/page_out
+	 */
+	for_each_set_bit(i, p->svms.bitmap_supported, p->n_pdds) {
+		struct kfd_process_device *pdd = p->pdds[i];
+		struct kobject *kobj_counters;
+
+		snprintf(counters_dir_filename, MAX_SYSFS_FILENAME_LEN,
+			"counters_%u", pdd->dev->id);
+		kobj_counters = kfd_alloc_struct(kobj_counters);
+		if (!kobj_counters)
+			return;
+
+		ret = kobject_init_and_add(kobj_counters, &sysfs_counters_type,
+					   p->kobj, counters_dir_filename);
+		if (ret) {
+			pr_warn("Creating KFD proc/%s folder failed",
+				counters_dir_filename);
+			kobject_put(kobj_counters);
+			return;
+		}
+
+		pdd->kobj_counters = kobj_counters;
+		kfd_sysfs_create_file(kobj_counters, &pdd->attr_faults,
+				      "faults");
+		kfd_sysfs_create_file(kobj_counters, &pdd->attr_page_in,
+				      "page_in");
+		kfd_sysfs_create_file(kobj_counters, &pdd->attr_page_out,
+				      "page_out");
+	}
+}
 
 static void kfd_procfs_add_sysfs_files(struct kfd_process *p)
 {
@@ -777,6 +853,7 @@ struct kfd_process *kfd_create_process(struct file *filep)
 
 		kfd_procfs_add_sysfs_stats(process);
 		kfd_procfs_add_sysfs_files(process);
+		kfd_procfs_add_sysfs_counters(process);
 	}
 out:
 	if (!IS_ERR(process))
@@ -919,44 +996,60 @@ static void kfd_process_destroy_pdds(struct kfd_process *p)
 	p->n_pdds = 0;
 }
 
-/* No process locking is needed in this function, because the process
- * is not findable any more. We must assume that no other thread is
- * using it any more, otherwise we couldn't safely free the process
- * structure in the end.
- */
-static void kfd_process_wq_release(struct work_struct *work)
+static void kfd_process_remove_sysfs(struct kfd_process *p)
 {
-	struct kfd_process *p = container_of(work, struct kfd_process,
-					     release_work);
+	struct kfd_process_device *pdd;
 	int i;
 
-	/* Remove the procfs files */
-	if (p->kobj) {
-		sysfs_remove_file(p->kobj, &p->attr_pasid);
-		kobject_del(p->kobj_queues);
-		kobject_put(p->kobj_queues);
-		p->kobj_queues = NULL;
+	if (!p->kobj)
+		return;
 
-		for (i = 0; i < p->n_pdds; i++) {
-			struct kfd_process_device *pdd = p->pdds[i];
+	sysfs_remove_file(p->kobj, &p->attr_pasid);
+	kobject_del(p->kobj_queues);
+	kobject_put(p->kobj_queues);
+	p->kobj_queues = NULL;
 
-			sysfs_remove_file(p->kobj, &pdd->attr_vram);
-			sysfs_remove_file(p->kobj, &pdd->attr_sdma);
+	for (i = 0; i < p->n_pdds; i++) {
+		pdd = p->pdds[i];
 
-			sysfs_remove_file(pdd->kobj_stats, &pdd->attr_evict);
-			if (pdd->dev->kfd2kgd->get_cu_occupancy)
-				sysfs_remove_file(pdd->kobj_stats,
-						  &pdd->attr_cu_occupancy);
-			kobject_del(pdd->kobj_stats);
-			kobject_put(pdd->kobj_stats);
-			pdd->kobj_stats = NULL;
-		}
+		sysfs_remove_file(p->kobj, &pdd->attr_vram);
+		sysfs_remove_file(p->kobj, &pdd->attr_sdma);
 
-		kobject_del(p->kobj);
-		kobject_put(p->kobj);
-		p->kobj = NULL;
+		sysfs_remove_file(pdd->kobj_stats, &pdd->attr_evict);
+		if (pdd->dev->kfd2kgd->get_cu_occupancy)
+			sysfs_remove_file(pdd->kobj_stats,
+					  &pdd->attr_cu_occupancy);
+		kobject_del(pdd->kobj_stats);
+		kobject_put(pdd->kobj_stats);
+		pdd->kobj_stats = NULL;
+	}
+
+	for_each_set_bit(i, p->svms.bitmap_supported, p->n_pdds) {
+		pdd = p->pdds[i];
+
+		sysfs_remove_file(pdd->kobj_counters, &pdd->attr_faults);
+		sysfs_remove_file(pdd->kobj_counters, &pdd->attr_page_in);
+		sysfs_remove_file(pdd->kobj_counters, &pdd->attr_page_out);
+		kobject_del(pdd->kobj_counters);
+		kobject_put(pdd->kobj_counters);
+		pdd->kobj_counters = NULL;
 	}
 
+	kobject_del(p->kobj);
+	kobject_put(p->kobj);
+	p->kobj = NULL;
+}
+
+/* No process locking is needed in this function, because the process
+ * is not findable any more. We must assume that no other thread is
+ * using it any more, otherwise we couldn't safely free the process
+ * structure in the end.
+ */
+static void kfd_process_wq_release(struct work_struct *work)
+{
+	struct kfd_process *p = container_of(work, struct kfd_process,
+					     release_work);
+	kfd_process_remove_sysfs(p);
 	kfd_iommu_unbind_process(p);
 
 	kfd_process_free_outstanding_kfd_bos(p);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
