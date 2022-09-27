Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00F61C6FA83
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Sep 2022 15:44:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19C4710E974;
	Tue, 27 Sep 2022 15:44:09 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2079.outbound.protection.outlook.com [40.107.95.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 78DF610E974
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Sep 2022 15:44:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mR2rMJY0mTOs6EOdMMwIFgvAX3mPTv48kvFJ7bgNS5HykIy2JwXBqjlU396ZbIXNxjvG3Tv8hIZ5d9qo6qCdc0ARTESyd/l9quG+HdjAD6h+AgFJNtqgLmIf/rLfBLBZygQCC+QoeY7JCWnaPDwAyC//Zk0GPcckOiR7GvVBKkQg083LHWnemXSRX07FYFf8dWWkJCWDoc03t5I+iTqy3sGEProBSrEZ+7gYovfvRqJAiEp/3SL71VEUh9IURJG6JO/BQe8Xri2aylbT40WT8kWc/v0SRoUb6TMgA0cT6mhqTNWZt+hIWjiIk0LdVVDcCgTcSEGdlxoJW0qSB+0nKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EMHgkJZGlglGYS2kGukyXW69ESzJx5r4lERhVUp52QE=;
 b=geeD/ut5lDYiyJWH/7iEpAV5ugLjLU0FvPT7oLT9M7zJHTxetQtOEmJg7Tsee+iRDjxWjbTkKxc1Je1lN+xOMND01EcGfYYMNE3Cg3zZSBC57VbdT36LySi+2cNcqG9Mz89MpV9ZXxY/CbhMET+efgR33ZdxVJ42y5S4lXIe93LjD3LpInoc0yh1OZ3GHlZ4OWWPjrhVd+q6bkDA2G8C4nKV2UpH/xPsyVrBfZSBfSnttPE1w7XhrdmO918JXziTE0VZljkj30XG/KQIzD+5pjkocqJR7vOwlJkqrlArrPh5/9lNWH5eC42kokPFQ+xcovDK3aYA5pu3xNOk7UZs6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EMHgkJZGlglGYS2kGukyXW69ESzJx5r4lERhVUp52QE=;
 b=jS+MsD4psriFO/VKirUv7clZFD+xXM1uK6ixj6R+fBrh25uU+jmAwGCKqJIqGcDLThmUz5IQaiImeIMnbd5cYHFHWw3ylWqG5PlM0mFS+Pun0jZ+J2PzwQf3oM0nX+o8BoH8iHTUekNVVmFYC65dDKlqjZymDJAtH5/DO+X9Yxk=
Received: from BN9PR03CA0371.namprd03.prod.outlook.com (2603:10b6:408:f7::16)
 by CH2PR12MB4937.namprd12.prod.outlook.com (2603:10b6:610:64::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26; Tue, 27 Sep
 2022 15:44:03 +0000
Received: from BN8NAM11FT083.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f7:cafe::93) by BN9PR03CA0371.outlook.office365.com
 (2603:10b6:408:f7::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.26 via Frontend
 Transport; Tue, 27 Sep 2022 15:44:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT083.mail.protection.outlook.com (10.13.177.75) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.14 via Frontend Transport; Tue, 27 Sep 2022 15:44:02 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 27 Sep
 2022 10:44:02 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v4 1/1] drm/amdkfd: Track unified memory when switching xnack
 mode
Date: Tue, 27 Sep 2022 11:43:48 -0400
Message-ID: <20220927154348.20274-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT083:EE_|CH2PR12MB4937:EE_
X-MS-Office365-Filtering-Correlation-Id: 607f6e9a-bdd0-47f4-e1a3-08daa09f1a62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PzgOOQ/G0ar7Hf4gBuB/1Ix33rd8OYi+xuI8gkC12iBzArElIH4PkjbGnfJIL6CAsrGrwPVhv5dPJbei0Kpf2zeYvZxr0C7vdTUTv1WGhMZmI2m2ewieTXCGAWnnwiSrXyOidD0iayjWXVQVwAR7U0io6R6DN6oMAE9UgHEcp4X2M+ErE35VXUivulMcN74YCW8sjiDv3nZya7+wfjGCGLyozZMAFse2DiUIN6X+dadppx6HQFYiP4PsC3Fyw3pvcOT0UjfAsjJ4L5wU3Ss69FRdIeKTSvr97ncP5p79tcDT0QUOHmBqWAVetjJV5o71gX9dU8etuMlzXvWRVjw7KIVsJowx6cLS03vfDpmxcwdEdqredfF790dIAeHBNhlxWYkLJm2uiPty+rwhyN8YVfgh6/OMD5hG61AS5PjMisqO7RlFvOZaPZsfC9zT5FW6XKHKj3dcrXZ6VHsOSv6Cp3Q7MoPpT4MJMLXgJoZahO2WsrDcefcK3DKuq7lbYDp1lzPALn5urvVFVssX8gVa+OLUR8EnD0diOQlNuN9Zo9HKQGrzuW+00daVxwt0gt1kepTIszwR/groCxXwdyGEehiHzEl1WHsMblvxTP1X5FMKsX1geu3OuCEMVnV1hqpqwD/4Bc3Bnov1DurvCyUvYJqJ0GT6oaxaHoipqgv/yncwHBcqGs5DT3x10ubjPAkBo1aOH/YC1UKEFkwv/ggT7qlCudXaoDlRugQVViPCnKSzzbiG5bKUG4nIHpIX5GC7vKr6qAV4E0KOeP2rEUrgJGCXJlC2HM5oI/k3Vyuep7fgMhDm7LI27VtbvN7iIBvi
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(136003)(39860400002)(346002)(396003)(451199015)(36840700001)(40470700004)(46966006)(36756003)(82740400003)(36860700001)(336012)(16526019)(2616005)(47076005)(41300700001)(186003)(426003)(1076003)(83380400001)(86362001)(81166007)(356005)(40460700003)(478600001)(6666004)(8676002)(40480700001)(26005)(54906003)(7696005)(6916009)(316002)(2906002)(8936002)(70586007)(5660300002)(70206006)(4326008)(82310400005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2022 15:44:02.8497 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 607f6e9a-bdd0-47f4-e1a3-08daa09f1a62
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT083.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4937
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
system memory, with xnack on, we don't track unified memory usage to
allow memory oversubscribe. When switching xnack mode from off to on,
subsequent free ranges allocated with xnack off will not unreserve
memory. When switching xnack mode from on to off, subsequent free ranges
allocated with xnack on will unreserve memory. Both cases cause memory
accounting unbalanced.

When switching xnack mode from on to off, need reserve already allocated
svm range memory. When switching xnack mode from off to on, need
unreserve already allocated svm range memory.

v4: Handle reservation memory failure
v3: Handle switching xnack mode race with svm_range_deferred_list_work
v2: Handle both switching xnack from on to off and from off to on cases

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 26 ++++++++++----
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c     | 44 +++++++++++++++++++++++-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.h     |  2 +-
 3 files changed, 64 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 56f7307c21d2..5feaba6a77de 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1584,6 +1584,8 @@ static int kfd_ioctl_smi_events(struct file *filep,
 	return kfd_smi_event_open(pdd->dev, &args->anon_fd);
 }
 
+#if IS_ENABLED(CONFIG_HSA_AMD_SVM)
+
 static int kfd_ioctl_set_xnack_mode(struct file *filep,
 				    struct kfd_process *p, void *data)
 {
@@ -1594,22 +1596,29 @@ static int kfd_ioctl_set_xnack_mode(struct file *filep,
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
+		r = svm_range_switch_xnack_reserve_mem(p, args->xnack_enabled);
 	} else {
 		args->xnack_enabled = p->xnack_enabled;
 	}
+
+out_unlock:
 	mutex_unlock(&p->mutex);
 
 	return r;
 }
 
-#if IS_ENABLED(CONFIG_HSA_AMD_SVM)
 static int kfd_ioctl_svm(struct file *filep, struct kfd_process *p, void *data)
 {
 	struct kfd_ioctl_svm_args *args = data;
@@ -1629,6 +1638,11 @@ static int kfd_ioctl_svm(struct file *filep, struct kfd_process *p, void *data)
 	return r;
 }
 #else
+static int kfd_ioctl_set_xnack_mode(struct file *filep,
+				    struct kfd_process *p, void *data)
+{
+	return -EPERM;
+}
 static int kfd_ioctl_svm(struct file *filep, struct kfd_process *p, void *data)
 {
 	return -EPERM;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index cf5b4005534c..13d2867faa0c 100644
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
@@ -2956,6 +2956,48 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 	return r;
 }
 
+int
+svm_range_switch_xnack_reserve_mem(struct kfd_process *p, bool xnack_enabled)
+{
+	struct svm_range *prange;
+	uint64_t reserved_size = 0;
+	uint64_t size;
+	int r = 0;
+
+	pr_debug("switching xnack from %d to %d\n", p->xnack_enabled, xnack_enabled);
+
+	mutex_lock(&p->svms.lock);
+
+	/* Change xnack mode must be inside svms lock, to avoid race with
+	 * svm_range_deferred_list_work unreserve memory in parallel.
+	 */
+	p->xnack_enabled = xnack_enabled;
+
+	list_for_each_entry(prange, &p->svms.list, list) {
+		size = (prange->last - prange->start + 1) << PAGE_SHIFT;
+		pr_debug("svms 0x%p %s prange 0x%p size 0x%llx\n", &p->svms,
+			 xnack_enabled ? "unreserve" : "reserve", prange, size);
+
+		if (xnack_enabled) {
+			amdgpu_amdkfd_unreserve_mem_limit(NULL, size,
+						KFD_IOC_ALLOC_MEM_FLAGS_USERPTR);
+		} else {
+			r = amdgpu_amdkfd_reserve_mem_limit(NULL, size,
+						KFD_IOC_ALLOC_MEM_FLAGS_USERPTR);
+			if (r)
+				break;
+			reserved_size += size;
+		}
+	}
+
+	if (r)
+		amdgpu_amdkfd_unreserve_mem_limit(NULL, reserved_size,
+						KFD_IOC_ALLOC_MEM_FLAGS_USERPTR);
+
+	mutex_unlock(&p->svms.lock);
+	return r;
+}
+
 void svm_range_list_fini(struct kfd_process *p)
 {
 	struct svm_range *prange;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
index 012c53729516..e58690376e17 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
@@ -203,11 +203,11 @@ void svm_range_list_lock_and_flush_work(struct svm_range_list *svms, struct mm_s
 void svm_range_bo_unref_async(struct svm_range_bo *svm_bo);
 
 void svm_range_set_max_pages(struct amdgpu_device *adev);
+int svm_range_switch_xnack_reserve_mem(struct kfd_process *p, bool xnack_enabled);
 
 #else
 
 struct kfd_process;
-
 static inline int svm_range_list_init(struct kfd_process *p)
 {
 	return 0;
-- 
2.35.1

