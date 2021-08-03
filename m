Return-Path: <SRS0=T22W=M2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF948C4338F
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Aug 2021 18:58:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F5F760725
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Aug 2021 18:58:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8F5F760725
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E0706E139;
	Tue,  3 Aug 2021 18:58:17 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2076.outbound.protection.outlook.com [40.107.236.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 11AEB6E139
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Aug 2021 18:58:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f6yHclXO6W+peGH8umIE4Bgc3KRlgrCboNS7jfvjjDV3cgrzJErZHTcgdVeWwO3tJ/zPqQRLe6Okk8glQV8EtEp68hBcyw4gajpf3tdw6WjxiLtU3gNHWMWDmBabsYyf2RvkrHGsowex3wbt0U+MAqqi80UFkpXTlVOYzJ+dtmXXcgo9ayQL95rF+awALntalmtYBlZs+dfHSWDmQTBYuayJKYZ6KnsL5uEZTKGsUMEMVW4MNhy7GeDSFeIR9AVifRI4m06Ao+evd9Y+EdOAf+xkujpPq+eAxf0Wep2t3Lqyji1Q77z4PaE9ix6uCcUALY60XfH7sKk4fwJ9xs+ZzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wJm4oYkSEwCmqxnM/qksS+NcG7dQYauv/42s/ypiuQY=;
 b=DQXv2+N2QrroLilD5wl12LzdMOeas2d1LUGoqzKLJwA18RDSlh5oJaKjvb8DXj59HqhfYivnSfQZrPQjfajE866wngEuqCFfJmwR9dAXJhIzX8FeXJrr9IRim33J0l/jpnF2NFvCND1nFsNeDxPBSszQbPJLOJcyoYm13hVLNpYhYbZyb59MDLQxnQGL4OyOHOZjttWGJ3T7ifMgsHpF3VrIQx8X0APpfN7vF2kMV5PC+PTUNjprjaFU/5c19klPIExn7B1leXnQVk4+Y1mrbcI628E5AWurSejJ9Vh4Zxih6jSeWin1vK4O7jiHG4VS6UnSqQBPqnqsGRuiyWpeiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wJm4oYkSEwCmqxnM/qksS+NcG7dQYauv/42s/ypiuQY=;
 b=EOBfQyutZO+tSug3BLl6leMMf0Bj20x48RmIMM7oOZ0tQJJRtALh9l7rghzCApcpbdodUDR+/HOJPuO1e38ALn7VMhKZap1AoX5Aenl+jCFBHcV/o27QSq8tiqGSW9hh4HdyKx1DD8ryLaBCHT/BH2H2fzLJRxbHqSnFKU6XkfA=
Received: from BN6PR2001CA0039.namprd20.prod.outlook.com
 (2603:10b6:405:16::25) by CH2PR12MB3847.namprd12.prod.outlook.com
 (2603:10b6:610:2f::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15; Tue, 3 Aug
 2021 18:58:13 +0000
Received: from BN8NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:16:cafe::7c) by BN6PR2001CA0039.outlook.office365.com
 (2603:10b6:405:16::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.19 via Frontend
 Transport; Tue, 3 Aug 2021 18:58:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT013.mail.protection.outlook.com (10.13.176.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4373.18 via Frontend Transport; Tue, 3 Aug 2021 18:58:13 +0000
Received: from eric-HP-EliteBook-745-G4.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Tue, 3 Aug 2021 13:58:11 -0500
From: Eric Huang <jinhuieric.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Eric Huang <jinhuieric.huang@amd.com>
Subject: [PATCH] drm/amdkfd: add parameter force in kfd_process_evict_queues
Date: Tue, 3 Aug 2021 14:57:57 -0400
Message-ID: <20210803185757.1029578-1-jinhuieric.huang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 143c5f7e-f536-4724-2270-08d956b0a4ea
X-MS-TrafficTypeDiagnostic: CH2PR12MB3847:
X-Microsoft-Antispam-PRVS: <CH2PR12MB3847DBC669CCF1853B618D5782F09@CH2PR12MB3847.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z4mpswMvx8x+m/diXZCMdHQq21v0gzTLIBvfKfh6Yuo6hfy3u7oOIKnSneq8SqthckXl+eznx0PDZu5j+YWV990lXIseSLa0L505mBGSpExhg9qIRhI0goJuA1m3VlcR4yU1i/TTpMehHF11OJ9rznZmg1NtYMiLClXyC5cp8vW+mUHj8J3NBBQo01PVCpmZ7Ash3jnb3vgXfWCk0j0k5zaGCKlzsza14bMEyqW2nPVeJqrhyuU9Ep43+Kwkk8hI+xq1iZn4GsKIngiLXFtfAaxWaQAGq3mIe8H2bYnOewhO8db/+YWw6zhG3oeoStL8PdlpZOiBdnUjN5TTHlGQXd5y5jFswVaWyT3dGaEKI5sJVedMeEmG/1+ETB6aOsvqoubZU5F0aBXQgAtkzjx+Xtzum/RPUEHK0kYaTHgJdP196mF2H+H/rjBxFWFM78ocWO9qc+3rkIb9SGLbn4t9sEe0rceRjLMAvTIzl+xXQZW/e/EiFTAiLYB/+6XqJQb21JtlG9Jh9j9lP7F9eAgVoOZVmwi2Ys0teJ3CrekI+Eg9i0bk2NyxqvCsNUrHEg/oNYfF807uKoYukdoU2Og4eSlVph1BJDF7QTlfozJKy3t4sx5bgkUF5o+QUeNjYEp0AF49441rK9o02XK01qpJxUitUe/8eIoWW5y03SfoTor1IP4/pHK3XfgPPMWWNGqZIsoPkPI+yRPMSVOk97Z+RbUEA3WfgKQWbKEHwVXJptI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(136003)(39860400002)(396003)(376002)(36840700001)(46966006)(316002)(36756003)(1076003)(8936002)(83380400001)(36860700001)(2616005)(2906002)(47076005)(426003)(478600001)(6666004)(7696005)(82310400003)(5660300002)(336012)(81166007)(16526019)(186003)(70586007)(82740400003)(356005)(70206006)(26005)(4326008)(86362001)(6916009)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2021 18:58:13.0226 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 143c5f7e-f536-4724-2270-08d956b0a4ea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3847
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

It is to differenciate case scenario for proper behavior when
calling evict queues, such as GPU reset doesn't need to roll
back restoring partial evicted queues.

Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h |  4 ++--
 drivers/gpu/drm/amd/amdkfd/kfd_device.c    | 10 +++++-----
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h      |  4 ++--
 drivers/gpu/drm/amd/amdkfd/kfd_process.c   | 18 ++++++++++--------
 5 files changed, 20 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 77044e8ba4e6..59ce5a17a834 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -190,7 +190,7 @@ void amdgpu_amdkfd_interrupt(struct amdgpu_device *adev,
 void amdgpu_amdkfd_suspend(struct amdgpu_device *adev, bool run_pm)
 {
 	if (adev->kfd.dev)
-		kgd2kfd_suspend(adev->kfd.dev, run_pm);
+		kgd2kfd_suspend(adev->kfd.dev, run_pm, false);
 }
 
 int amdgpu_amdkfd_resume(struct amdgpu_device *adev, bool run_pm, bool sync)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index 332ccba00e69..b7e46ad0507e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -372,7 +372,7 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
 			 struct drm_device *ddev,
 			 const struct kgd2kfd_shared_resources *gpu_resources);
 void kgd2kfd_device_exit(struct kfd_dev *kfd);
-void kgd2kfd_suspend(struct kfd_dev *kfd, bool run_pm);
+void kgd2kfd_suspend(struct kfd_dev *kfd, bool run_pm, bool force);
 int kgd2kfd_resume(struct kfd_dev *kfd, bool run_pm, bool sync);
 int kgd2kfd_pre_reset(struct kfd_dev *kfd);
 int kgd2kfd_post_reset(struct kfd_dev *kfd);
@@ -407,7 +407,7 @@ static inline void kgd2kfd_device_exit(struct kfd_dev *kfd)
 {
 }
 
-static inline void kgd2kfd_suspend(struct kfd_dev *kfd, bool run_pm)
+static inline void kgd2kfd_suspend(struct kfd_dev *kfd, bool run_pm, bool force)
 {
 }
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 24b5e0aa1eac..48e51ee8de56 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -940,7 +940,7 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
 void kgd2kfd_device_exit(struct kfd_dev *kfd)
 {
 	if (kfd->init_complete) {
-		kgd2kfd_suspend(kfd, false);
+		kgd2kfd_suspend(kfd, false, true);
 		svm_migrate_fini((struct amdgpu_device *)kfd->kgd);
 		device_queue_manager_uninit(kfd->dqm);
 		kfd_interrupt_exit(kfd);
@@ -965,7 +965,7 @@ int kgd2kfd_pre_reset(struct kfd_dev *kfd)
 
 	kfd->dqm->ops.pre_reset(kfd->dqm);
 
-	kgd2kfd_suspend(kfd, false);
+	kgd2kfd_suspend(kfd, false, true);
 
 	kfd_signal_reset_event(kfd);
 	return 0;
@@ -1001,7 +1001,7 @@ bool kfd_is_locked(void)
 	return  (atomic_read(&kfd_locked) > 0);
 }
 
-void kgd2kfd_suspend(struct kfd_dev *kfd, bool run_pm)
+void kgd2kfd_suspend(struct kfd_dev *kfd, bool run_pm, bool force)
 {
 	if (!kfd->init_complete)
 		return;
@@ -1010,7 +1010,7 @@ void kgd2kfd_suspend(struct kfd_dev *kfd, bool run_pm)
 	if (!run_pm) {
 		/* For first KFD device suspend all the KFD processes */
 		if (atomic_inc_return(&kfd_locked) == 1)
-			kfd_suspend_all_processes();
+			kfd_suspend_all_processes(force);
 	}
 
 	kfd->dqm->ops.stop(kfd->dqm);
@@ -1122,7 +1122,7 @@ int kgd2kfd_quiesce_mm(struct mm_struct *mm)
 		return -ESRCH;
 
 	WARN(debug_evictions, "Evicting pid %d", p->lead_thread->pid);
-	r = kfd_process_evict_queues(p);
+	r = kfd_process_evict_queues(p, true);
 
 	kfd_unref_process(p);
 	return r;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 3d5d3994d8a4..e80fb64a6dcc 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1042,9 +1042,9 @@ static inline struct kfd_process_device *kfd_process_device_from_gpuidx(
 }
 
 void kfd_unref_process(struct kfd_process *p);
-int kfd_process_evict_queues(struct kfd_process *p);
+int kfd_process_evict_queues(struct kfd_process *p, bool force);
 int kfd_process_restore_queues(struct kfd_process *p);
-void kfd_suspend_all_processes(void);
+void kfd_suspend_all_processes(bool force);
 /*
  * kfd_resume_all_processes:
  *	bool sync: If kfd_resume_all_processes() should wait for the
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 38a9dee40785..a41ece37bc3c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1875,20 +1875,22 @@ struct kfd_process *kfd_lookup_process_by_mm(const struct mm_struct *mm)
  * Eviction is reference-counted per process-device. This means multiple
  * evictions from different sources can be nested safely.
  */
-int kfd_process_evict_queues(struct kfd_process *p)
+int kfd_process_evict_queues(struct kfd_process *p, bool force)
 {
-	int r = 0;
+	int r = 0, r_tmp = 0;
 	int i;
 	unsigned int n_evicted = 0;
 
 	for (i = 0; i < p->n_pdds; i++) {
 		struct kfd_process_device *pdd = p->pdds[i];
 
-		r = pdd->dev->dqm->ops.evict_process_queues(pdd->dev->dqm,
+		r_tmp = pdd->dev->dqm->ops.evict_process_queues(pdd->dev->dqm,
 							    &pdd->qpd);
-		if (r) {
+		if (r_tmp) {
 			pr_err("Failed to evict process queues\n");
-			goto fail;
+			r = r_tmp;
+			if (!force)
+				goto fail;
 		}
 		n_evicted++;
 	}
@@ -2079,7 +2081,7 @@ static void evict_process_worker(struct work_struct *work)
 	p->last_evict_timestamp = get_jiffies_64();
 
 	pr_debug("Started evicting pasid 0x%x\n", p->pasid);
-	ret = kfd_process_evict_queues(p);
+	ret = kfd_process_evict_queues(p, false);
 	if (!ret) {
 		dma_fence_signal(p->ef);
 		dma_fence_put(p->ef);
@@ -2147,7 +2149,7 @@ static void restore_process_worker(struct work_struct *work)
 		pr_err("Failed to restore queues of pasid 0x%x\n", p->pasid);
 }
 
-void kfd_suspend_all_processes(void)
+void kfd_suspend_all_processes(bool force)
 {
 	struct kfd_process *p;
 	unsigned int temp;
@@ -2158,7 +2160,7 @@ void kfd_suspend_all_processes(void)
 		cancel_delayed_work_sync(&p->eviction_work);
 		cancel_delayed_work_sync(&p->restore_work);
 
-		if (kfd_process_evict_queues(p))
+		if (kfd_process_evict_queues(p, force))
 			pr_err("Failed to suspend process 0x%x\n", p->pasid);
 		dma_fence_signal(p->ef);
 		dma_fence_put(p->ef);
-- 
2.25.1

