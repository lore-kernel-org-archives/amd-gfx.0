Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F090CC32771
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Sep 2022 19:41:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C76A10E4F6;
	Mon, 26 Sep 2022 19:41:21 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2076.outbound.protection.outlook.com [40.107.101.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 169DE10E4F6
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Sep 2022 19:41:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JlbKZcMR1e7CxjXoZED1I2I6AL+rSj0Y+Am9KVvREICFLvxBlFgppNaYA2k8T+cuKFpNf97Q53TkulZVacpuGiPQ58Tmfjs6nbkM69zYnFu3hiabyTTdhTDcmtZ6OGGsPmobVKlQWAG9TDs+STeR8hNIcwQgy+jBq2aJ8NvolMY6sLvwIA4b2IeP+DiZuanR7wgHn2tkURa87AUUcZI9fp4KwRIsKHmtYveYnTtKRLCp1NFwuO28ps2bLfO2gF+tInSnCE9oPyC73RE8VerFKsRvN125KAayqbjHyz2xnZDTTwa3QyBujEmbkU9UO6fBCTSh1HyMpIKK4b/dK4srhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d3IsPkWQu79qCyP4CxJ9qobrkecQNHfLD5BPe2gA744=;
 b=nXu5H3br2zoz+hVIDXFMZMeVZB2N3cPxygozpxqlZaV0QZsqrx3gmROrB4s+wCVLxJHVTkSJ/8JD6nvCMuZ8OOQroWtbftCizyw8rnjAtiTnZBBypcAM9g6XuK9ptLjsoELlvkYsIgahQGuZA+Vpkc9U+fQzlt0d7LOuHH2I7WjregeYXkBBocLE1cDFEISqcr09nj7NxCXwyPzuUubJ45e8Df6D4mZsGeUAoORXtE8ZCvydmhufQmF4EjL4veEEjT5t/r57hPMFctg+2IrADAfXNOybh6bptL8YJ1x+Ue/ezeisRHDrr7oEtZrV8qIZrUksD17DsvmcO51KkFGGVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d3IsPkWQu79qCyP4CxJ9qobrkecQNHfLD5BPe2gA744=;
 b=RIagCLjIZfB4gmAVK5vso2ZN4AD66DtJ853ORhJDLUlmyXPWxPtI575A487KcNKozny8S0QaH8v3jy9VFwQJzqLSRw3083Vp6uxvlqal5AvwUhiu3Yjz2z2eb/DHNmIPXKg6cNSdH+VmmuB0HUQyoc4FgzizqC824k61ePY8edk=
Received: from DS7P222CA0005.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::17) by
 MW4PR12MB6899.namprd12.prod.outlook.com (2603:10b6:303:208::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Mon, 26 Sep
 2022 19:41:17 +0000
Received: from DM6NAM11FT104.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2e:cafe::18) by DS7P222CA0005.outlook.office365.com
 (2603:10b6:8:2e::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.16 via Frontend
 Transport; Mon, 26 Sep 2022 19:41:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT104.mail.protection.outlook.com (10.13.173.232) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.14 via Frontend Transport; Mon, 26 Sep 2022 19:41:17 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 26 Sep
 2022 14:41:15 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 1/1] drm/amdkfd: Track unified memory when switching xnack
 mode
Date: Mon, 26 Sep 2022 15:40:24 -0400
Message-ID: <20220926194024.31643-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT104:EE_|MW4PR12MB6899:EE_
X-MS-Office365-Filtering-Correlation-Id: 94d1fc6d-a0b1-4540-02ca-08da9ff7146a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AMo1JfMFZDnUgc0jOHjYc8uSKU7B/lUs/jCH4/D5LcdmpQZgZC58RzyNJQAyZcLGf3iyr+Nt/mz9liNIUyaO9zdEcLxMqu3dXTezI018DjaBip/reQZIqx6prW6FyECmWYgX0wHVwMPQkzPrFIEtz76R6FUaUjKlJ0pEsKMqZsinSurV6zoedCTsY7eWG90dPdllwNOckp+wyc1Xn2NKGFAyrDXu2Z070fgk65iCCkZlOhsdamglyveVYPMsJvAiCtEAIJCai0vNbwOsGTz2AbeCcZy/7NAXXabfxOVFT2a7kkBXXKrgWBE0QGU4xla+NlTVfFjmVlj2aS+enu0qE89lKUlneFdZNTQv+97dt1khS/dn1HwKM14mqpmhV+jVdcuczLcmVpaGiCAChO69vkeZfREK7fFjV/CA5fHLbZNJMuckDl7dmK6KwBZfUi0T7VgiIDRPqJkVRgq39TP/ixxNrs2P4SvoXw1wvbazmsIf/7fyY9ydDdpeotH9ugelt7mWWBQ+pujnYqrbMAySpVce+sqYxIYIj3QRNuKqT0Ia8DzjWDk3/giwrAPddGRjRn/O4xH9biTJzd1vq90X4p7B04RBJHprReR5jFQgtZzcuGBs4eduo6RvU9f0uWFmz/MzcqOlPePFz0YfWqkBeRgRcGB/vTotmw0jvDK9X+JvJQCqy7U1SuKZXyDu+hV2HkppGGV3TeCf8SRqdxMIWaUeha3LC2itPCoq9zzFoDQ1baxAYKhxgh2qEihDBIgsf4NkU5DKx4xkQXkbb+mlKeVymimTVZTu/cJemg3I4lY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(396003)(376002)(136003)(39860400002)(451199015)(36840700001)(46966006)(40470700004)(82310400005)(40460700003)(36756003)(40480700001)(83380400001)(426003)(1076003)(186003)(336012)(2616005)(16526019)(47076005)(356005)(81166007)(82740400003)(36860700001)(70206006)(70586007)(4326008)(8676002)(86362001)(316002)(6916009)(2906002)(5660300002)(41300700001)(478600001)(7696005)(26005)(6666004)(8936002)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2022 19:41:17.3639 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 94d1fc6d-a0b1-4540-02ca-08da9ff7146a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT104.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6899
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
Cc: Philip Yang <Philip.Yang@amd.com>, felix.kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Unified memory usage with xnack off is tracked to avoid oversubscribe
system memory. When switching xnack mode from off to on, subsequent
free ranges allocated with xnack off will not unreserve memory when
xnack is on, cause memory accounting unbalanced.

When switching xnack mode from on to off, need reserve already allocated
svm range memory because subsequent free ranges will unreserve memory
with xnack off.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 30 ++++++++++++++++++++----
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c     | 20 +++++++++++++++-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.h     |  2 ++
 3 files changed, 46 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 56f7307c21d2..938095478707 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1594,16 +1594,36 @@ static int kfd_ioctl_set_xnack_mode(struct file *filep,
 	if (args->xnack_enabled >= 0) {
 		if (!list_empty(&p->pqm.queues)) {
 			pr_debug("Process has user queues running\n");
-			mutex_unlock(&p->mutex);
-			return -EBUSY;
+			r = -EBUSY;
+			goto out_unlock;
 		}
-		if (args->xnack_enabled && !kfd_process_xnack_mode(p, true))
+
+		if (p->xnack_enabled == args->xnack_enabled)
+			goto out_unlock;
+
+		if (args->xnack_enabled && !kfd_process_xnack_mode(p, true)) {
 			r = -EPERM;
-		else
-			p->xnack_enabled = args->xnack_enabled;
+			goto out_unlock;
+		}
+
+		pr_debug("switching xnack from %d to %d\n", p->xnack_enabled,
+			 args->xnack_enabled);
+
+		mutex_lock(&p->svms.lock);
+
+		/* Switching to XNACK on/off, unreserve/reserve memory of all
+		 * svm ranges. Change xnack must be inside svms lock, to avoid
+		 * race with svm_range_deferred_list_work unreserve memory.
+		 */
+		p->xnack_enabled = args->xnack_enabled;
+		svm_range_list_unreserve_mem(p, p->xnack_enabled);
+
+		mutex_unlock(&p->svms.lock);
 	} else {
 		args->xnack_enabled = p->xnack_enabled;
 	}
+
+out_unlock:
 	mutex_unlock(&p->mutex);
 
 	return r;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index cf5b4005534c..5a82d5660470 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -278,7 +278,7 @@ static void svm_range_free(struct svm_range *prange, bool update_mem_usage)
 	svm_range_free_dma_mappings(prange);
 
 	if (update_mem_usage && !p->xnack_enabled) {
-		pr_debug("unreserve mem limit: %lld\n", size);
+		pr_debug("unreserve prange 0x%p size: 0x%llx\n", prange, size);
 		amdgpu_amdkfd_unreserve_mem_limit(NULL, size,
 					KFD_IOC_ALLOC_MEM_FLAGS_USERPTR);
 	}
@@ -2956,6 +2956,24 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 	return r;
 }
 
+void svm_range_list_unreserve_mem(struct kfd_process *p, bool unreserve)
+{
+	struct svm_range *prange;
+	uint64_t size;
+
+	list_for_each_entry(prange, &p->svms.list, list) {
+		size = (prange->last - prange->start + 1) << PAGE_SHIFT;
+		pr_debug("svms 0x%p %s prange 0x%p size 0x%llx\n", &p->svms,
+			 unreserve ? "unreserve" : "reserve", prange, size);
+		if (unreserve)
+			amdgpu_amdkfd_unreserve_mem_limit(NULL, size,
+						KFD_IOC_ALLOC_MEM_FLAGS_USERPTR);
+		else
+			amdgpu_amdkfd_reserve_mem_limit(NULL, size,
+						KFD_IOC_ALLOC_MEM_FLAGS_USERPTR);
+	}
+}
+
 void svm_range_list_fini(struct kfd_process *p)
 {
 	struct svm_range *prange;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
index 012c53729516..05a2135cd56e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
@@ -203,10 +203,12 @@ void svm_range_list_lock_and_flush_work(struct svm_range_list *svms, struct mm_s
 void svm_range_bo_unref_async(struct svm_range_bo *svm_bo);
 
 void svm_range_set_max_pages(struct amdgpu_device *adev);
+void svm_range_list_unreserve_mem(struct kfd_process *p, bool unreserve);
 
 #else
 
 struct kfd_process;
+void svm_range_list_unreserve_mem(struct kfd_process *p, bool unreserve) { }
 
 static inline int svm_range_list_init(struct kfd_process *p)
 {
-- 
2.35.1

