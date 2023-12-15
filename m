Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CABFC46CD3
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Dec 2023 16:01:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E08A10EA42;
	Fri, 15 Dec 2023 16:01:15 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2046.outbound.protection.outlook.com [40.107.92.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 33FCE10EA31
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Dec 2023 16:01:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oLfXzZiVAJaw2VWR5WrFZgSCw9ZQiQFmNy7v6DWQdDB6dfGaBQ4aLOh3HdRTeA8VDhAPWAPYq22Mohdf73oFNjS6Z7lz3J7iWFTxirpS7OrXfqDgEbUINJCWvL98R1Gseql/K0vF6Mh8DzLrCOYruQotapbbsQTE4JJAirlGBrjYMAChKnZzDzgKSVVx96NW0S3185/8ypQ557y/ypGQ4BKQfCqQnAvJPQt8mJbEKsEqaZLrdBzIiDF9mlbYIFBzCZaB0cjtBMzxlrjrAbFzUNab7aaqHGJOPXqn9o7lmAZS8BdmK+dJlhgCKK5cJYITGupRdSyZHFIWQoBBwRBmDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xb2uXfioSQKxjny4wjqMqr1eUySDu41D5IHw4sUZO54=;
 b=lW9WDOCPgElvWU2+SvfOY5jMc7/uJvhnjq3TezmPVL3uXy0bcQNjA0pUikbHo9g6Aa5fAieMpLWsKuiD0bau3IimqmHDf/f+42XKE3G0kBNBFy91Lc0KgP/jziM/jBFTv/T8nDlvIm5zsa8XvbvICy/rQhO3ixS3ltG2ROS7Pul4yx09bQSzoMyR8LJvrIoHI3PTbAKH6BuogK/5OuOjQPO60W8Y4Q20acuvNNR7Ox/rYabz8wxM2OwsGmTlgjaoW6gKdO5yCZ2Wm7DOK1VEWCrB+PteDfvSSG+okd6KYYg7XJFQuNtCHLzk+nEyiVUdU0YHn4tY6rbLbONa4Och4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xb2uXfioSQKxjny4wjqMqr1eUySDu41D5IHw4sUZO54=;
 b=NRkYoSp9Vxd1vvvWgG6yqoMPkD4xD1/cSSGQlzFkcihxQHStJy15W/asawHtB0NYg+7LcgjB+bXPTrCLOyqFwAFqrUayzXi+0E6hFbCBJ19DS0W748SceYZWcQRIjLyALTTyzQpEMMaiyTc2LhPwlznHIdGgPEnSyqy70buIlrA=
Received: from DM6PR06CA0036.namprd06.prod.outlook.com (2603:10b6:5:120::49)
 by LV8PR12MB9153.namprd12.prod.outlook.com (2603:10b6:408:185::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Fri, 15 Dec
 2023 16:01:06 +0000
Received: from CY4PEPF0000EDD1.namprd03.prod.outlook.com
 (2603:10b6:5:120:cafe::dd) by DM6PR06CA0036.outlook.office365.com
 (2603:10b6:5:120::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.31 via Frontend
 Transport; Fri, 15 Dec 2023 16:01:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD1.mail.protection.outlook.com (10.167.241.205) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Fri, 15 Dec 2023 16:01:05 +0000
Received: from jz-tester2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 15 Dec
 2023 10:00:47 -0600
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 23/24] drm/amdkfd: set debug trap bit when enabling PC
 Sampling
Date: Fri, 15 Dec 2023 10:59:50 -0500
Message-ID: <20231215155951.811884-24-James.Zhu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231215155951.811884-1-James.Zhu@amd.com>
References: <20231215155951.811884-1-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD1:EE_|LV8PR12MB9153:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e71a9d1-c23b-478b-f088-08dbfd870b98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QyVIATN8Opqqi5D9m/MCj5fyajgEq5lnae8R4uu8CtYerg0hcFN1QBNbJNakiNmli9y6p4+bjJJvAY/j5kwTXj6pJoePi2vztv6ecN9CVS0/pqb5n4GOrfrFvP6a8/LfeLnrHFmYwmtuIHzSTg/qR9yYA+7drtlXPE2ptxFOEEvrsND2ICybriWz6LYCDiQycCuEM10m+N9ZpcsPBBCSdQ0bflRHX47g4QJVdrBaqhQRoqb8FjBclJF+QqpI+Mhw6xL1l8rBQxIjU1NUwGI2kuakuX4oam6DfrSZ2cCauNmpGirvT3G7Shvr0oXoDZ0iObgOoAUD0f6P3jEUUpik9RUeR9xaI0LxFW1IxB0FnS4aJSRt4xFUV1l3kUxVWAGB7N/0M9Nim+7TgesXU8VE1qpSzshkQBPd+G91mZMD1axbj2FUiabNkr8m6kb37ONFqMYLWj8NLUwxt5dhXTlwlLjXbty7f/dvdajSfI6gCuv0xFecnytTChqVyEEzIIlw46vJ55eu6IQiFf1eCJiZHaF6rWth12SilovOBZerAlMQGCI2tDZZDnkmODB6wl+bNyJ0C6ZDvx3MjG8+jnHB6wm9KgwiEyN1O1T89cEuaAVRJkkGJaa0XKB4I/wW07P/eY9v1apI7O9NWAEhHNR89v2xL+3ImGC4ZmyztKhLQgVgGnqkQYs1gyh9BDl39K/cJNVlJLFLW7O3feLj0vbUVkUBEXoKlyYKCvrCd3n0e4QMchCWik/jkSg2yJ1pVhilFQg+IvWt57Vqb/QdwdUSRg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(346002)(39860400002)(136003)(376002)(230922051799003)(186009)(64100799003)(451199024)(82310400011)(1800799012)(36840700001)(46966006)(40470700004)(82740400003)(40460700003)(336012)(83380400001)(426003)(36860700001)(2616005)(26005)(8676002)(4326008)(8936002)(316002)(2906002)(47076005)(16526019)(5660300002)(1076003)(478600001)(6666004)(6916009)(54906003)(70586007)(70206006)(7696005)(41300700001)(81166007)(36756003)(86362001)(356005)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2023 16:01:05.9104 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e71a9d1-c23b-478b-f088-08dbfd870b98
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9153
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
Cc: Felix.kuehling@amd.com, joseph.greathouse@amd.com, jamesz@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: David Yat Sin <David.YatSin@amd.com>

We need the SPI_GDBG_PER_VMID_CNTL.TRAP_EN bit to be set during PC
Sampling so that the TTMP registers are valid inside the sampling data.
runtime_info.ttmp_setup will be cleared when the user application
does the AMDKFD_IOC_RUNTIME_ENABLE ioctl without
KFD_RUNTIME_ENABLE_MODE_ENABLE_MASK flag on exit.

It is also not valid to have the debugger attached to a process while PC
sampling is enabled so adding some checks to prevent this.

Signed-off-by: David Yat Sin <David.YatSin@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c     | 31 ++++----------
 drivers/gpu/drm/amd/amdkfd/kfd_debug.c       | 22 ++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_debug.h       |  3 ++
 drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c | 43 +++++++++++++++++---
 drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.h |  4 +-
 5 files changed, 75 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 1a3a8ded9c93..f7a8794c2bde 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1775,7 +1775,7 @@ static int kfd_ioctl_pc_sample(struct file *filep,
 			pr_debug("failed to bind process %p with gpu id 0x%x", p, args->gpu_id);
 			ret = -ESRCH;
 		} else {
-			ret = kfd_pc_sample(pdd, args);
+			ret = kfd_pc_sample(p, pdd, args);
 		}
 	}
 	mutex_unlock(&p->mutex);
@@ -2808,26 +2808,9 @@ static int runtime_enable(struct kfd_process *p, uint64_t r_debug,
 
 	p->runtime_info.runtime_state = DEBUG_RUNTIME_STATE_ENABLED;
 	p->runtime_info.r_debug = r_debug;
-	p->runtime_info.ttmp_setup = enable_ttmp_setup;
 
-	if (p->runtime_info.ttmp_setup) {
-		for (i = 0; i < p->n_pdds; i++) {
-			struct kfd_process_device *pdd = p->pdds[i];
-
-			if (!kfd_dbg_is_rlc_restore_supported(pdd->dev)) {
-				amdgpu_gfx_off_ctrl(pdd->dev->adev, false);
-				pdd->dev->kfd2kgd->enable_debug_trap(
-						pdd->dev->adev,
-						true,
-						pdd->dev->vm_info.last_vmid_kfd);
-			} else if (kfd_dbg_is_per_vmid_supported(pdd->dev)) {
-				pdd->spi_dbg_override = pdd->dev->kfd2kgd->enable_debug_trap(
-						pdd->dev->adev,
-						false,
-						0);
-			}
-		}
-	}
+	if (enable_ttmp_setup)
+		kfd_dbg_enable_ttmp_setup(p);
 
 retry:
 	if (p->debug_trap_enabled) {
@@ -2976,9 +2959,13 @@ static int kfd_ioctl_set_debug_trap(struct file *filep, struct kfd_process *p, v
 		goto out;
 	}
 
-	/* Check if target is still PTRACED. */
 	rcu_read_lock();
-	if (target != p && args->op != KFD_IOC_DBG_TRAP_DISABLE
+
+	if (kfd_pc_sampling_enabled(target)) {
+		pr_debug("Cannot enable debug trap on PID:%d because PC Sampling active\n", args->pid);
+		r = -EBUSY;
+	/* Check if target is still PTRACED. */
+	} else if (target != p && args->op != KFD_IOC_DBG_TRAP_DISABLE
 				&& ptrace_parent(target->lead_thread) != current) {
 		pr_err("PID %i is not PTRACED and cannot be debugged\n", args->pid);
 		r = -EPERM;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
index 9ec750666382..092c2dc84d24 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
@@ -1118,3 +1118,25 @@ void kfd_dbg_set_enabled_debug_exception_mask(struct kfd_process *target,
 
 	mutex_unlock(&target->event_mutex);
 }
+
+void kfd_dbg_enable_ttmp_setup(struct kfd_process *p)
+{
+	int i;
+	p->runtime_info.ttmp_setup = true;
+	for (i = 0; i < p->n_pdds; i++) {
+		struct kfd_process_device *pdd = p->pdds[i];
+
+		if (!kfd_dbg_is_rlc_restore_supported(pdd->dev)) {
+			amdgpu_gfx_off_ctrl(pdd->dev->adev, false);
+			pdd->dev->kfd2kgd->enable_debug_trap(
+					pdd->dev->adev,
+					true,
+					pdd->dev->vm_info.last_vmid_kfd);
+		} else if (kfd_dbg_is_per_vmid_supported(pdd->dev)) {
+			pdd->spi_dbg_override = pdd->dev->kfd2kgd->enable_debug_trap(
+					pdd->dev->adev,
+					false,
+					0);
+		}
+	}
+}
\ No newline at end of file
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.h b/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
index fd0ff64d4184..d7ce0b119dd0 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
@@ -90,6 +90,9 @@ int kfd_dbg_trap_device_snapshot(struct kfd_process *target,
 
 void kfd_dbg_set_enabled_debug_exception_mask(struct kfd_process *target,
 					uint64_t exception_set_mask);
+
+void kfd_dbg_enable_ttmp_setup(struct kfd_process *p);
+
 /*
  * If GFX off is enabled, chips that do not support RLC restore for the debug
  * registers will disable GFX off temporarily for the entire debug session.
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
index d8286aabd5a7..6870548fc42c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
@@ -24,6 +24,7 @@
 #include "kfd_priv.h"
 #include "amdgpu_amdkfd.h"
 #include "kfd_pc_sampling.h"
+#include "kfd_debug.h"
 #include "kfd_device_queue_manager.h"
 
 struct supported_pc_sample_info {
@@ -39,6 +40,19 @@ struct supported_pc_sample_info supported_formats[] = {
 	{ IP_VERSION(9, 4, 2), &sample_info_hosttrap_9_0_0 },
 };
 
+/* Checks whether PC Sampling is enabled on any devices in use by this process */
+bool kfd_pc_sampling_enabled(struct kfd_process *p) {
+	int i;
+
+	for (i = 0; i < p->n_pdds; i++) {
+		struct kfd_process_device *pdd = p->pdds[i];
+
+		if (pdd->dev->pcs_data.hosttrap_entry.base.pc_sample_info.method)
+			return true;
+	}
+	return false;
+}
+
 static int kfd_pc_sample_thread(void *param)
 {
 	struct amdgpu_device *adev;
@@ -99,13 +113,19 @@ static int kfd_pc_sample_thread_start(struct kfd_node *node)
 	return ret;
 }
 
-static int kfd_pc_sample_query_cap(struct kfd_process_device *pdd,
+static int kfd_pc_sample_query_cap(struct kfd_process *p, struct kfd_process_device *pdd,
 					struct kfd_ioctl_pc_sample_args __user *user_args)
 {
 	uint64_t sample_offset;
 	int num_method = 0;
 	int i;
 
+	if (p->debug_trap_enabled) {
+		pr_debug("Cannot have PC Sampling and debug trap simultaneously");
+		user_args->num_sample_info = 0;
+		return 0;
+	}
+
 	for (i = 0; i < ARRAY_SIZE(supported_formats); i++)
 		if (KFD_GC_VERSION(pdd->dev) == supported_formats[i].ip_version)
 			num_method++;
@@ -205,7 +225,7 @@ static int kfd_pc_sample_stop(struct kfd_process_device *pdd,
 	return 0;
 }
 
-static int kfd_pc_sample_create(struct kfd_process_device *pdd,
+static int kfd_pc_sample_create(struct kfd_process *p, struct kfd_process_device *pdd,
 					struct kfd_ioctl_pc_sample_args __user *user_args)
 {
 	struct kfd_pc_sample_info *supported_format = NULL;
@@ -217,6 +237,11 @@ static int kfd_pc_sample_create(struct kfd_process_device *pdd,
 	if (user_args->num_sample_info != 1)
 		return -EINVAL;
 
+	if (p->debug_trap_enabled) {
+		pr_debug("Cannot have PC Sampling and debug trap simultaneously");
+		return -EBUSY;
+	}
+
 	ret = copy_from_user(&user_info, (void __user *) user_args->sample_info_ptr,
 				sizeof(struct kfd_pc_sample_info));
 	if (ret) {
@@ -275,6 +300,14 @@ static int kfd_pc_sample_create(struct kfd_process_device *pdd,
 	pcs_entry->pdd = pdd;
 	user_args->trace_id = (uint32_t)i;
 
+	/*
+	 * Set SPI_GDBG_PER_VMID_CNTL.TRAP_EN so that TTMP registers are valid in the sampling data
+	 * p->runtime_info.ttmp_setup will be cleared when user application calls runtime_disable
+	 * on exit.
+	 */
+	if (!p->runtime_info.ttmp_setup)
+		kfd_dbg_enable_ttmp_setup(p);
+
 	pr_debug("alloc pcs_entry = %p, trace_id = 0x%x on gpu 0x%x", pcs_entry, i, pdd->dev->id);
 
 	return 0;
@@ -321,7 +354,7 @@ void kfd_pc_sample_release(struct kfd_process_device *pdd)
 	mutex_unlock(&pdd->dev->pcs_data.mutex);
 }
 
-int kfd_pc_sample(struct kfd_process_device *pdd,
+int kfd_pc_sample(struct kfd_process *p, struct kfd_process_device *pdd,
 					struct kfd_ioctl_pc_sample_args __user *args)
 {
 	struct pc_sampling_entry *pcs_entry;
@@ -344,10 +377,10 @@ int kfd_pc_sample(struct kfd_process_device *pdd,
 
 	switch (args->op) {
 	case KFD_IOCTL_PCS_OP_QUERY_CAPABILITIES:
-		return kfd_pc_sample_query_cap(pdd, args);
+		return kfd_pc_sample_query_cap(p, pdd, args);
 
 	case KFD_IOCTL_PCS_OP_CREATE:
-		return kfd_pc_sample_create(pdd, args);
+		return kfd_pc_sample_create(p, pdd, args);
 
 	case KFD_IOCTL_PCS_OP_DESTROY:
 		if (pcs_entry->enabled)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.h b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.h
index 6175563ca9be..42525feefb85 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.h
@@ -28,8 +28,10 @@
 #include "amdgpu.h"
 #include "kfd_priv.h"
 
-int kfd_pc_sample(struct kfd_process_device *pdd,
+int kfd_pc_sample(struct kfd_process *p, struct kfd_process_device *pdd,
 					struct kfd_ioctl_pc_sample_args __user *args);
 void kfd_pc_sample_release(struct kfd_process_device *pdd);
 
+bool kfd_pc_sampling_enabled(struct kfd_process *p);
+
 #endif /* KFD_PC_SAMPLING_H_ */
-- 
2.25.1

