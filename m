Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 635DFC6FD18
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Mar 2023 20:10:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 237E910EC1A;
	Wed, 29 Mar 2023 20:10:03 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2081.outbound.protection.outlook.com [40.107.237.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F3E8610EC21
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Mar 2023 20:09:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g46FuOYV76/HwWaZPZCXdYF7z6n6DWb1v1kxHstDjunNGisddlGxasdwisbyKgQTz1585lcrFGxWz6ZLFccz/JCI24EfUlBBwV6v8AjY3c/BMMP4u8Nqngv2brKIOyozZz8rietODEyvG8hfa4jsNGEc8gkYx9zdIZOuKwQMp4ZXA9VibAcTmtIDGrVNIaHrigKpXBE/Dd6dTge6EDj2B+uS0jqGgwVMnJnWIJ0wngvDImUqQ6hL/4rNFFL1bCYv8CTm/XKGeJ437c4rOm8nCv9oe3GdeCEwER1+/+VrnBHmI3HphYXOjeZIahlWR3jtLTBU+NzvevyU7jAJJtQuOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l6E2jYc7DEIOyUeeWVY+AqZNcL1924061KU13MI+kdw=;
 b=TjJaVXLgidCD6cT4jSkwDxcWCzFZozOYnvQFwql/j92St449AWx94FAmSDR2NRhEwntxqmoZR1sP+JAP8L4+ZBQYrcLR30905AodJEvK2EqIXap8kvvKF8BS3deOzxcZzN7ZW1X51peGH6adKXg3UQGCsV49T2qhbr8eT3q4hhdIepsGEE32jOSDexsyciuk2GYYIlPanoJVOzfK67zitovhSzeQahG8Dbjj/v3SJhVKzdFumQvNrZR1vhUY6zb3XGoS5MOGILjdxgmDh/Idl14Lpzj1v5qTEHyVk91RtKRWdBODflxswinJbkIX0BBxOzX4EufbGbuQtgePMhXdPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l6E2jYc7DEIOyUeeWVY+AqZNcL1924061KU13MI+kdw=;
 b=N/UeKxNgczF2bsf0c/h1+Z5+QewbdOi3Rb+tE2OtO+VuJj3VR4/LVi1EYpVog+Z466mWMDdwKG3PUz0kuFrrnjwrR5HxJzZtLGf1jl9M3EuHFPt29M52jJhU/dVxyl2weJPAnT8rw+P7edpTKEce/7gDvTMaAPVijMCVP9vVGuc=
Received: from DS7PR06CA0002.namprd06.prod.outlook.com (2603:10b6:8:2a::16) by
 IA1PR12MB8222.namprd12.prod.outlook.com (2603:10b6:208:3f2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.35; Wed, 29 Mar
 2023 20:09:54 +0000
Received: from DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2a:cafe::6d) by DS7PR06CA0002.outlook.office365.com
 (2603:10b6:8:2a::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.20 via Frontend
 Transport; Wed, 29 Mar 2023 20:09:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT029.mail.protection.outlook.com (10.13.173.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.22 via Frontend Transport; Wed, 29 Mar 2023 20:09:54 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 29 Mar
 2023 15:09:53 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/12] drm/amdkfd: Rework kfd_locked handling
Date: Wed, 29 Mar 2023 16:09:23 -0400
Message-ID: <20230329200930.1982035-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230329200930.1982035-1-alexander.deucher@amd.com>
References: <20230329200930.1982035-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT029:EE_|IA1PR12MB8222:EE_
X-MS-Office365-Filtering-Correlation-Id: eb9f0f41-4f76-454d-d3b2-08db30918fef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q6R0IjZFoFdlFP6Z7DmoBkJlPE9ykBrc9TxRjzQUSemzndzT20GmpHgrpNZpq8QZ10n6Zx+8rmlfpJryznlIT6RS1a97SkKGRC4gN3KX/Tv9cCB4dzCD8b1YzN2d5SCBbgKDf+KwoiToPkhBED8HGz1jK5KQMqK+c2dhf4nns/Q7qkY8IaFBJUmiVhGaW64NY1T/PYnQ3HSmKRgVzHiyWnPA1dOfsY3IFRPa01Wbb79zmhKnlBx2Vm9bdOaEutwQ36YDr5Vu1tl7F+aT857oJgkQfox5QOR09t/kASaP4DYBmZI1Z5CjN1hjk7/qiUx7YyACZIRprDm+NQfy1i43LQsW/n6CNf0zQzBbUfsWQ+nHSrE8c3DHArwfahcfa02U/Kv3lJz1vQb9TMbKB46vWyN6p9JP0BEVIg8wJoI/6Ebyq/OTUi7lD08T1lW+rTGoHMiAy/cwki7zZw1rpULJd+V03Jdx2Q+zysQvzyHaDy5u2eFpHSP1STywFuGlqITwGBq4uBQxYRZNeY1OSrepBJCcu1y8198rJqOKVHyOxENcMDHn4YgIuDJvOwYFMzh5cFX1Wb/GusOuKWawNEzbK2qEv8kkci/sP6R/q+qTWN8cfTD2FIvLU2xEuPd+DfGPVH1lP3BkgDzrzFKPW2HDPCYqDUYOtSN19d4XHb2/Fm4uAa2IXf7G8B+wq9DQqBq8tO2vGx3AusQ5UIcNgTrBYukzC/lxP/moGNeSW7cEolY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(376002)(136003)(39860400002)(396003)(451199021)(40470700004)(46966006)(36840700001)(86362001)(36756003)(316002)(70206006)(70586007)(6916009)(41300700001)(4326008)(6666004)(54906003)(478600001)(8936002)(40480700001)(5660300002)(82310400005)(82740400003)(186003)(2906002)(8676002)(7696005)(36860700001)(81166007)(26005)(356005)(1076003)(336012)(16526019)(83380400001)(47076005)(2616005)(426003)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 20:09:54.5526 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb9f0f41-4f76-454d-d3b2-08db30918fef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8222
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Mukul Joshi <mukul.joshi@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Mukul Joshi <mukul.joshi@amd.com>

Currently, even if kfd_locked is set, a process is first
created and then removed to work around a race condition
in updating kfd_locked flag. Rework kfd_locked handling to
ensure no processes is created if kfd_locked is set. This
is achieved by updating kfd_locked under kfd_processes_mutex.
With this there is no need for kfd_locked to be an atomic
counter. Instead, it can be a regular integer.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c |  7 -------
 drivers/gpu/drm/amd/amdkfd/kfd_device.c  | 21 ++++++++++++++++-----
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h    |  2 ++
 drivers/gpu/drm/amd/amdkfd/kfd_process.c |  8 +++++++-
 4 files changed, 25 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index cf1a97583901..82749405be79 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -146,13 +146,6 @@ static int kfd_open(struct inode *inode, struct file *filep)
 	if (IS_ERR(process))
 		return PTR_ERR(process);
 
-	if (kfd_is_locked()) {
-		dev_dbg(kfd_device, "kfd is locked!\n"
-				"process %d unreferenced", process->pasid);
-		kfd_unref_process(process);
-		return -EAGAIN;
-	}
-
 	/* filep now owns the reference returned by kfd_create_process */
 	filep->private_data = process;
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 1a482f0855d2..7aa4f4ee7752 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -42,7 +42,7 @@
  * once locked, kfd driver will stop any further GPU execution.
  * create process (open) will return -EAGAIN.
  */
-static atomic_t kfd_locked = ATOMIC_INIT(0);
+static int kfd_locked;
 
 #ifdef CONFIG_DRM_AMDGPU_CIK
 extern const struct kfd2kgd_calls gfx_v7_kfd2kgd;
@@ -872,7 +872,9 @@ int kgd2kfd_post_reset(struct kfd_dev *kfd)
 			return ret;
 	}
 
-	atomic_dec(&kfd_locked);
+	mutex_lock(&kfd_processes_mutex);
+	--kfd_locked;
+	mutex_unlock(&kfd_processes_mutex);
 
 	for (i = 0; i < kfd->num_nodes; i++) {
 		node = kfd->nodes[i];
@@ -885,21 +887,27 @@ int kgd2kfd_post_reset(struct kfd_dev *kfd)
 
 bool kfd_is_locked(void)
 {
-	return  (atomic_read(&kfd_locked) > 0);
+	lockdep_assert_held(&kfd_processes_mutex);
+	return  (kfd_locked > 0);
 }
 
 void kgd2kfd_suspend(struct kfd_dev *kfd, bool run_pm)
 {
 	struct kfd_node *node;
 	int i;
+	int count;
 
 	if (!kfd->init_complete)
 		return;
 
 	/* for runtime suspend, skip locking kfd */
 	if (!run_pm) {
+		mutex_lock(&kfd_processes_mutex);
+		count = ++kfd_locked;
+		mutex_unlock(&kfd_processes_mutex);
+
 		/* For first KFD device suspend all the KFD processes */
-		if (atomic_inc_return(&kfd_locked) == 1)
+		if (count == 1)
 			kfd_suspend_all_processes();
 	}
 
@@ -925,7 +933,10 @@ int kgd2kfd_resume(struct kfd_dev *kfd, bool run_pm)
 
 	/* for runtime resume, skip unlocking kfd */
 	if (!run_pm) {
-		count = atomic_dec_return(&kfd_locked);
+		mutex_lock(&kfd_processes_mutex);
+		count = --kfd_locked;
+		mutex_unlock(&kfd_processes_mutex);
+
 		WARN_ONCE(count < 0, "KFD suspend / resume ref. error");
 		if (count == 0)
 			ret = kfd_resume_all_processes();
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 5cfebcc8b305..400b4dcbdf05 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -201,6 +201,8 @@ extern int amdgpu_no_queue_eviction_on_vm_fault;
 /* Enable eviction debug messages */
 extern bool debug_evictions;
 
+extern struct mutex kfd_processes_mutex;
+
 enum cache_policy {
 	cache_policy_coherent,
 	cache_policy_noncoherent
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 9e667fa38df1..75cd4eafaa44 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -50,7 +50,7 @@ struct mm_struct;
  * Unique/indexed by mm_struct*
  */
 DEFINE_HASHTABLE(kfd_processes_table, KFD_PROCESS_TABLE_SIZE);
-static DEFINE_MUTEX(kfd_processes_mutex);
+DEFINE_MUTEX(kfd_processes_mutex);
 
 DEFINE_SRCU(kfd_processes_srcu);
 
@@ -818,6 +818,12 @@ struct kfd_process *kfd_create_process(struct file *filep)
 	 */
 	mutex_lock(&kfd_processes_mutex);
 
+	if (kfd_is_locked()) {
+		mutex_unlock(&kfd_processes_mutex);
+		pr_debug("KFD is locked! Cannot create process");
+		return ERR_PTR(-EINVAL);
+	}
+
 	/* A prior open of /dev/kfd could have already created the process. */
 	process = find_process(thread, false);
 	if (process) {
-- 
2.39.2

