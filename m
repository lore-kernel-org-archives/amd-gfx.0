Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A547BC4828D
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Feb 2024 15:59:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1ABA310F74F;
	Tue,  6 Feb 2024 15:59:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="b0nrIopc";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2084.outbound.protection.outlook.com [40.107.223.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A55B910F6DC
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Feb 2024 15:59:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=atecLraaLM6zwoSIJIDmM4fQdw4mHFa362dCiv8dkY6dNdAgB97swxTz23wxZOqkdt8DO6PFjnaI+d9wibyybTd8BxK5waSnde1ZrS6bkI7nLrNI/EbFMpt0tXOivqa8wb/wfa43sWzUXtzrJIy1NvbwfhIhlGLBFbgyVci5lSHGWExxSD5fUfY/X7ZEqTyxnbpsSLF9DhmHjmf2Y5WeQul6qe2Tcj6t4aC6AMyqVe6/H27AVXgZ9zcSAkmp1Gs2QOEcwSjPnFjPU/KnFUBsou1aPKMsTvU7Ty2KJBltneadzmPGO5tde4Pfccx/J4OEwS/+EqiigkY7AssCy4NYkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AxIKa+x28pnGlrmMhE+v5OTQrkI7E0h2m2sAZQ5HzXk=;
 b=l+VMkohvQZ+hu2oZcmZehzYJD28sjvvj6VnquggqLKInu8QGhTvelFqubiNBacp0+PeEneAq1iR3D3hp8zdyCtegaYt8afevJZkYcmymf6wUBkr9A4c8ekV/zZOv5efYfyAfYq4SsmzKtzmwWPYR3mflsZO2H+XdMorXz7FOf2ZdvuIrbhI1doY8YIbwUr1UTHgLAvKORblkHIfElt9Aq4wiwoNvIsOszSeJp5JVlbbJBUlk27OvivvOJyNVSPLps4JqElhUHlln8U3ef5b7PltCDuGVLeAvgmjaXIW613XSmNi6TQnP2ApwV/XfdPjeR7AKOEhA2KMmL07AV2PHaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AxIKa+x28pnGlrmMhE+v5OTQrkI7E0h2m2sAZQ5HzXk=;
 b=b0nrIopc3Fk28d3oYOdNXH9dRXdUVWCxvzlb07E4CQ7GtcWRbOC6AwHpBptgplzCins4UAHTJc27wBPZnB6vduktv43cBeYoOiRSwy3ezaKy1dfTD5ts5mrwv3nm+Wd0WEL0jJFbfqMdKZaoUjFRN4RVbFlgqUGgvTWZWkMU/3M=
Received: from SJ0PR03CA0226.namprd03.prod.outlook.com (2603:10b6:a03:39f::21)
 by SA1PR12MB6971.namprd12.prod.outlook.com (2603:10b6:806:24e::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.14; Tue, 6 Feb
 2024 15:59:34 +0000
Received: from SJ1PEPF00001CDD.namprd05.prod.outlook.com
 (2603:10b6:a03:39f:cafe::c2) by SJ0PR03CA0226.outlook.office365.com
 (2603:10b6:a03:39f::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36 via Frontend
 Transport; Tue, 6 Feb 2024 15:59:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CDD.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Tue, 6 Feb 2024 15:59:34 +0000
Received: from jz-tester2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 6 Feb
 2024 09:59:32 -0600
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.kuehling@amd.com>, <joseph.greathouse@amd.com>,
 <vladimir.indic@amd.com>, <david.yatsin@amd.com>, <jamesz@amd.com>
Subject: [PATCH v4 02/24] drm/amdkfd: add pc sampling support
Date: Tue, 6 Feb 2024 10:58:58 -0500
Message-ID: <20240206155920.3171418-3-James.Zhu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240206155920.3171418-1-James.Zhu@amd.com>
References: <20240206155920.3171418-1-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDD:EE_|SA1PR12MB6971:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b8eae96-dc52-4748-fd18-08dc272c9d06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ritl208XpI5VQvKn1Ddbu69APSasAznhf8CB9sb3dwTHyQpDHNUQiNzyVlvjmqauEmE6/OqkG6ROdmJWRSXlgdH36nnMf57GhFAcTK3disOnWBh/c6+TScn/waJYD8jSAoikAoInECdO/tlleldN1o0eJ3MhZN0YMzP6bcFNsDrKCrjCdPymiKoyqaK3gz1UREJKY5VZKjqqoa6/m8TlOSeGVRRc2gE3R4cQQ+OfIDXDeyoO9vLiiFLBLZEJmGL0nGCUfjFzNdfqvTOBrLFaCvs0rbDn6aPCG6iKsJf1cDwhgU04S2XHqssz/UQ3L9EYCGaUXq6Iqb35Q7JFBMH4OajxD8J0wDFpnmMXZmD/o+H+hcchMrmykoTykeNQ1c/g9gP4rZtD/X9WKnEgIxm6FtmHZM0fEZbVPaTn4bFx5H0Uwul4GQF4ZrwMP3ttdcHf+R/0AvYO5SpILVwR/4KIspaPilc+lkAnJwi4CvV9MHsoF2PvmmkstTD3jy0dm4M72ZNVRNw18uASw6Uwxg/rYfWFIM/APG/FVb2dQbEtGuUtRsUfHDaWxKWbtqgHebNT7jH8ngQrASJ6o87zzUT/RPCzEo2TALCdVLbAAYQhew7oVnr5mTSD1BETR7FNRITr5UXXKHcxHeFOWK9g2iy/bpXx50YuhxhRfHBxr2H2omxS7KTTbr10VDee1KmIE7q37LrvjvAvG3J3JuzfRUiCbwI1aIqrIIMmsqFTZEbNjjK6VzEs+fR6HjDu/QzgWuD0PvQTCTQiKPy+fSsnJjfDyQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(136003)(346002)(39860400002)(376002)(230922051799003)(1800799012)(451199024)(82310400011)(64100799003)(186009)(36840700001)(46966006)(40470700004)(478600001)(16526019)(26005)(83380400001)(81166007)(1076003)(47076005)(356005)(2616005)(82740400003)(36860700001)(6666004)(8936002)(8676002)(70586007)(4326008)(6916009)(5660300002)(70206006)(2906002)(316002)(7696005)(54906003)(336012)(426003)(36756003)(41300700001)(40460700003)(40480700001)(86362001)(66899024)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 15:59:34.5043 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b8eae96-dc52-4748-fd18-08dc272c9d06
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CDD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6971
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

From: David Yat Sin <david.yatsin@amd.com>

Add pc sampling functions in amdkfd.

Co-developed-by: James Zhu <James.Zhu@amd.com>
Signed-off-by: James Zhu <James.Zhu@amd.com>
Signed-off-by: David Yat Sin <david.yatsin@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/Makefile          |  3 +-
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c     | 45 +++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c | 78 ++++++++++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.h | 34 +++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h        | 13 ++++
 5 files changed, 172 insertions(+), 1 deletion(-)
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
index 80e90fdef291..d9cac97c54c0 100644
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
@@ -1745,6 +1746,39 @@ static int kfd_ioctl_svm(struct file *filep, struct kfd_process *p, void *data)
 }
 #endif
 
+static int kfd_ioctl_pc_sample(struct file *filep,
+				   struct kfd_process *p, void __user *data)
+{
+	struct kfd_ioctl_pc_sample_args *args = data;
+	struct kfd_process_device *pdd;
+	int ret = 0;
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
+	} else if (args->op == KFD_IOCTL_PCS_OP_START) {
+		pdd = kfd_bind_process_to_device(pdd->dev, p);
+		if (IS_ERR(pdd)) {
+			pr_debug("failed to bind process %p with gpu id 0x%x", p, args->gpu_id);
+			ret = -ESRCH;
+		}
+	}
+
+	if (!ret)
+		ret = kfd_pc_sample(pdd, args);
+	mutex_unlock(&p->mutex);
+
+	return ret;
+}
+
 static int criu_checkpoint_process(struct kfd_process *p,
 			     uint8_t __user *user_priv_data,
 			     uint64_t *priv_offset)
@@ -3219,6 +3253,9 @@ static const struct amdkfd_ioctl_desc amdkfd_ioctls[] = {
 
 	AMDKFD_IOCTL_DEF(AMDKFD_IOC_DBG_TRAP,
 			kfd_ioctl_set_debug_trap, 0),
+
+	AMDKFD_IOCTL_DEF(AMDKFD_IOC_PC_SAMPLE,
+			kfd_ioctl_pc_sample, KFD_IOC_FLAG_PERFMON),
 };
 
 #define AMDKFD_CORE_IOCTL_COUNT	ARRAY_SIZE(amdkfd_ioctls)
@@ -3295,6 +3332,14 @@ static long kfd_ioctl(struct file *filep, unsigned int cmd, unsigned long arg)
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
index 677281c0793e..ae9a41670909 100644
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

