Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2A2CC10DCE
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Dec 2023 22:54:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3237C10E0DA;
	Thu,  7 Dec 2023 22:54:41 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2089.outbound.protection.outlook.com [40.107.102.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CCB610E0DA
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Dec 2023 22:54:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZFX9je2HEk7/oySRtfupMnkI7Vre1Sh/vsifFiIdzLqASxPMRKGGoMTTKuTM3zKtBSsJUM/fl88WGNE6qAOaqIMOK9DOUr/LTfQdEnpfzG00jJpeyVC+5rhQ7TPh5UP7foxLqubLilWHOYgbYPJhR+U7U0YHhaUVJqynPjFsSqJZcMjGBlHdeAmG+3UxUIcUFIm0QHHoTer1UVvSMRI04w04qnrSmhNspyFLYWmYQZsMvY5V9JQ8Qa6PVYAguJFXm6B6VtlnQtqswHUIvV9zHIzPfr1lSIHnJReeAffKSx2bBzovGFTNwp7vmaD/eliQcd50iTRrUboS1Zemn9CuhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jJf4MITlGcom2Yrss9RBdEDT4+r+QLRu85/wrXI8QQI=;
 b=MidsdB6i0ZZfbSt2qfT9WosF0Cq6oAgkN3djfB3TyY0UONoGNwIl40/ZbNEQLeJVY5x47KH0yNlZoqnhnsvY1TjDBkm89hLlCNeyMtCc82t+HQN1AnYbRJK2iocwx6VRHjGKlYm0uAT694H1RwnvbXLK8eqDC1uOfqSvObGldgSPTjsulyGDRrFp5boD0Hh9s/QqeviogS7rHaOfJw56r/Q2h9yMUr9yYwuqs+rCFEIWFBm61qg3UWG8Bfma7oT7/sMlsThJUdWknzJvH6osVvpjyPhjtuUwQQ6PvQS9aCRsWI/B+1yXiAG7eVa8UpHldou3gx3wNu0SKGRCTPA0PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jJf4MITlGcom2Yrss9RBdEDT4+r+QLRu85/wrXI8QQI=;
 b=ls/hznZm/jQZKovChPScY+No9PweMRrzfFUH2m4ZLZK2Nv3OHW7m+VNUX4lS8oWkGfuDpaVAAM8iD01CmA8Hu+tpUpopjygiDY1ACm1/EZUBHrw8znyHCDfLtXAEya8dhlpDZT38cHKg3d7PrQji8AGWmD1M69hhze2XKhT+B40=
Received: from CH2PR20CA0019.namprd20.prod.outlook.com (2603:10b6:610:58::29)
 by MW3PR12MB4393.namprd12.prod.outlook.com (2603:10b6:303:2c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.27; Thu, 7 Dec
 2023 22:54:37 +0000
Received: from DS2PEPF0000343A.namprd02.prod.outlook.com
 (2603:10b6:610:58:cafe::50) by CH2PR20CA0019.outlook.office365.com
 (2603:10b6:610:58::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34 via Frontend
 Transport; Thu, 7 Dec 2023 22:54:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343A.mail.protection.outlook.com (10.167.18.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7068.20 via Frontend Transport; Thu, 7 Dec 2023 22:54:36 +0000
Received: from jz-tester2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 7 Dec
 2023 16:54:35 -0600
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 02/23] drm/amdkfd: add pc sampling support
Date: Thu, 7 Dec 2023 17:54:01 -0500
Message-ID: <20231207225422.4057292-3-James.Zhu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231207225422.4057292-1-James.Zhu@amd.com>
References: <20231207225422.4057292-1-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343A:EE_|MW3PR12MB4393:EE_
X-MS-Office365-Filtering-Correlation-Id: 584236b2-16d7-4173-2990-08dbf7777c93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KS8Y5WQAedUupRw2fFePBCeaPLi4DESdrPZ0j+fW9/D09Xqjz9zCf/ONW474cZkBK5y9KzaiocQNj7tWWKqiMnjqnk+jn9RKuZhWbKyTWTpOMjhdg8kbrGJ7j7CMH35E3oulgviOeaR+QHzMjjLAaHPBhNetdwl20Su9quiBWS9xn+cWWWkVe2yAL6QwTst00S4ta83aXTxsBKE0WZ1HbNMpy+RLF1qOnmV3jET1Jcx7MWS9G8YOjrN5QlBIa4gz60N6C/m3CvzcBIJGljDt5ASKTtbg83ROcc15GF3TeV0RmXP/oFanzY7XrKVISZnnQyfehXy45mkbEDnN91UwNgij8G67RMx9IdEhO2UjIl2gCWMpVUNpm07egppNG42joRlSPwuFGPot3ZOPEI+r1DPCrJy63SNg32NKKySKXr2SzSajUamhI6SB6RfuXInE2lV6FOWPSTe/zJ7vPAlkG4x7FeN1h0akwZI8y/KGOU5rVgVyhgAsX1TAEnkdkMsCg5an7UMVqgdh8nJBeP99LTWVxP4rhuAS1dJ18/Dil/b3TJCeFzVUrVhWGMcZ8OVvuFjzV9M4ZugxZaN9NFaYgNpqTXJnuKJF5Nk5iClUGnu6eihFTJcfdp49nRh+Isai26uYcsOg2alfJh4RZu0FTOQ2lM715//vqYWsg1x8Uij/wdDukk1361b9gZVayu0X7OzpbWIODIdOA3YvAJmk5HKuCVkQeNeTvOpAMuylZyKW5cJp7M1wV8D4FWpRjwNSV9A2gD/KGvuqqP/erzoYGQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(376002)(136003)(346002)(39860400002)(230922051799003)(64100799003)(1800799012)(451199024)(82310400011)(186009)(46966006)(36840700001)(40470700004)(36860700001)(82740400003)(83380400001)(6666004)(478600001)(40480700001)(4326008)(2616005)(8936002)(8676002)(6916009)(1076003)(70586007)(316002)(54906003)(70206006)(426003)(7696005)(47076005)(356005)(81166007)(16526019)(336012)(26005)(2906002)(5660300002)(40460700003)(66899024)(41300700001)(86362001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2023 22:54:36.5464 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 584236b2-16d7-4173-2990-08dbf7777c93
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4393
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

From: David Yat Sin <david.yatsin@amd.com>

Add pc sampling functions in amdkfd.

Co-developed-by: James Zhu <James.Zhu@amd.com>
Signed-off-by: James Zhu <James.Zhu@amd.com>
Signed-off-by: David Yat Sin <david.yatsin@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/Makefile          |  3 +-
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c     | 44 +++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c | 78 ++++++++++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.h | 34 +++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h        | 13 ++++
 5 files changed, 171 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
 create mode 100644 drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.h

diff --git a/drivers/gpu/drm/amd/amdkfd/Makefile b/drivers/gpu/drm/amd/amdkfd/Makefile
index a5ae7bcf44eb..790fd028a681 100644
--- a/drivers/gpu/drm/amd/amdkfd/Makefile
+++ b/drivers/gpu/drm/amd/amdkfd/Makefile
@@ -57,7 +57,8 @@ AMDKFD_FILES	:= $(AMDKFD_PATH)/kfd_module.o \
 		$(AMDKFD_PATH)/kfd_int_process_v11.o \
 		$(AMDKFD_PATH)/kfd_smi_events.o \
 		$(AMDKFD_PATH)/kfd_crat.o \
-		$(AMDKFD_PATH)/kfd_debug.o
+		$(AMDKFD_PATH)/kfd_debug.o \
+		$(AMDKFD_PATH)/kfd_pc_sampling.o
 
 ifneq ($(CONFIG_DEBUG_FS),)
 AMDKFD_FILES += $(AMDKFD_PATH)/kfd_debugfs.o
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index f6d4748c1980..1a3a8ded9c93 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -41,6 +41,7 @@
 #include "kfd_priv.h"
 #include "kfd_device_queue_manager.h"
 #include "kfd_svm.h"
+#include "kfd_pc_sampling.h"
 #include "amdgpu_amdkfd.h"
 #include "kfd_smi_events.h"
 #include "amdgpu_dma_buf.h"
@@ -1750,6 +1751,38 @@ static int kfd_ioctl_svm(struct file *filep, struct kfd_process *p, void *data)
 }
 #endif
 
+static int kfd_ioctl_pc_sample(struct file *filep,
+				   struct kfd_process *p, void __user *data)
+{
+	struct kfd_ioctl_pc_sample_args *args = data;
+	struct kfd_process_device *pdd;
+	int ret;
+
+	if (sched_policy == KFD_SCHED_POLICY_NO_HWS) {
+		pr_err("PC Sampling does not support sched_policy %i", sched_policy);
+		return -EINVAL;
+	}
+
+	mutex_lock(&p->mutex);
+	pdd = kfd_process_device_data_by_id(p, args->gpu_id);
+
+	if (!pdd) {
+		pr_debug("could not find gpu id 0x%x.", args->gpu_id);
+		ret = -EINVAL;
+	} else {
+		pdd = kfd_bind_process_to_device(pdd->dev, p);
+		if (IS_ERR(pdd)) {
+			pr_debug("failed to bind process %p with gpu id 0x%x", p, args->gpu_id);
+			ret = -ESRCH;
+		} else {
+			ret = kfd_pc_sample(pdd, args);
+		}
+	}
+	mutex_unlock(&p->mutex);
+
+	return ret;
+}
+
 static int criu_checkpoint_process(struct kfd_process *p,
 			     uint8_t __user *user_priv_data,
 			     uint64_t *priv_offset)
@@ -3224,6 +3257,9 @@ static const struct amdkfd_ioctl_desc amdkfd_ioctls[] = {
 
 	AMDKFD_IOCTL_DEF(AMDKFD_IOC_DBG_TRAP,
 			kfd_ioctl_set_debug_trap, 0),
+
+	AMDKFD_IOCTL_DEF(AMDKFD_IOC_PC_SAMPLE,
+			kfd_ioctl_pc_sample, KFD_IOC_FLAG_PERFMON),
 };
 
 #define AMDKFD_CORE_IOCTL_COUNT	ARRAY_SIZE(amdkfd_ioctls)
@@ -3300,6 +3336,14 @@ static long kfd_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
 		}
 	}
 
+	/* PC Sampling Monitor */
+	if (unlikely(ioctl->flags & KFD_IOC_FLAG_PERFMON)) {
+		if (!capable(CAP_PERFMON) && !capable(CAP_SYS_ADMIN)) {
+			retcode = -EACCES;
+			goto err_i1;
+		}
+	}
+
 	if (cmd & (IOC_IN | IOC_OUT)) {
 		if (asize <= sizeof(stack_kdata)) {
 			kdata = stack_kdata;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
new file mode 100644
index 000000000000..a7e78ff42d07
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c
@@ -0,0 +1,78 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+/*
+ * Copyright 2023 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+#include "kfd_priv.h"
+#include "amdgpu_amdkfd.h"
+#include "kfd_pc_sampling.h"
+
+static int kfd_pc_sample_query_cap(struct kfd_process_device *pdd,
+					struct kfd_ioctl_pc_sample_args __user *user_args)
+{
+	return -EINVAL;
+}
+
+static int kfd_pc_sample_start(struct kfd_process_device *pdd)
+{
+	return -EINVAL;
+}
+
+static int kfd_pc_sample_stop(struct kfd_process_device *pdd)
+{
+	return -EINVAL;
+
+}
+
+static int kfd_pc_sample_create(struct kfd_process_device *pdd,
+					struct kfd_ioctl_pc_sample_args __user *user_args)
+{
+	return -EINVAL;
+}
+
+static int kfd_pc_sample_destroy(struct kfd_process_device *pdd, uint32_t trace_id)
+{
+	return -EINVAL;
+
+}
+
+int kfd_pc_sample(struct kfd_process_device *pdd,
+					struct kfd_ioctl_pc_sample_args __user *args)
+{
+	switch (args->op) {
+	case KFD_IOCTL_PCS_OP_QUERY_CAPABILITIES:
+		return kfd_pc_sample_query_cap(pdd, args);
+
+	case KFD_IOCTL_PCS_OP_CREATE:
+		return kfd_pc_sample_create(pdd, args);
+
+	case KFD_IOCTL_PCS_OP_DESTROY:
+		return kfd_pc_sample_destroy(pdd, args->trace_id);
+
+	case KFD_IOCTL_PCS_OP_START:
+		return kfd_pc_sample_start(pdd);
+
+	case KFD_IOCTL_PCS_OP_STOP:
+		return kfd_pc_sample_stop(pdd);
+	}
+
+	return -EINVAL;
+}
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.h b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.h
new file mode 100644
index 000000000000..4eeded4ea5b6
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.h
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: GPL-2.0 OR MIT */
+/*
+ * Copyright 2023 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ */
+
+#ifndef KFD_PC_SAMPLING_H_
+#define KFD_PC_SAMPLING_H_
+
+#include "amdgpu.h"
+#include "kfd_priv.h"
+
+int kfd_pc_sample(struct kfd_process_device *pdd,
+					struct kfd_ioctl_pc_sample_args __user *args);
+
+#endif /* KFD_PC_SAMPLING_H_ */
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 45366b4ca976..99426182bfc6 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -144,6 +144,19 @@ enum kfd_ioctl_flags {
 	 * we also allow ioctls with SYS_ADMIN capability.
 	 */
 	KFD_IOC_FLAG_CHECKPOINT_RESTORE = BIT(0),
+
+	/*
+	 * @KFD_IOC_FLAG_PERFMON:
+	 * Performance monitoring feature, GPU performance monitoring can allow users
+	 * to gather some information about other processes. PC sampling can allow
+	 * users to infer information about wavefronts from other processes that are
+	 * running on the same CUs, such as which execution units they are using. As
+	 * such, this type of performance monitoring should be protected and only
+	 * available to users with sufficient capabilities: either CAP_PERFMON, or,
+	 * for backwards compatibility, CAP_SYS_ADMIN.
+	 */
+
+	KFD_IOC_FLAG_PERFMON = BIT(1),
 };
 /*
  * Kernel module parameter to specify maximum number of supported queues per
-- 
2.25.1

