Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4555DC4332F
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Nov 2023 13:12:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C08EA10E9BD;
	Fri,  3 Nov 2023 13:12:04 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2066.outbound.protection.outlook.com [40.107.101.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E06310E9BE
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Nov 2023 13:12:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aPUmvZBjkD2KOSwXR5JIcFgWHRkMBt1C973HG/uGuazxrADn+aSmXfFZ70Oq4XJ02BirEZbF6Hgk2F1kbHKOgFZtdQPOPrHiU9buTTU2wjlEKdlE39CcHyjKEGx5g73Qb/6yetd9BsTy/uyXFQUNcxpE3Eyqgs1XX3KTuTF2lKMXdYEIt5kQWM7WEkSZFh2crHQujYZ6Ff9SV/foPrYvpABsxLM5c2mOOxrLqWc0XIWHun5FsKAB4vnIRyH3h/AaOq/lmqieJ3gi01GnzdGZHztOCMLwo1OiFhmRGAQE4BWsvH89g4j0SXQWgg4oPBNYRxDsEHuoO3refXajKM/smg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ah7VxNUKo8L97VvPa5EabTRYwshFVo2g9Yncm8D9BXI=;
 b=clTNv/V0qpgrHy70PQSPUGhENvcXuMpuC9oO3EiKj/d3bdEf1vf+MdMsJJIfGdz9T7C5IrdIo/04aqaVCkzhqQe8WHVyrwmu6wzX2xN0/dKsuO+gD0qtq/ENEBHvCVoL7S9ULvwedft3p7o2gIzD5grUUOul8vEC/1NyAzhBWKxCJP9l/ZeeJ7zS5CcVxb6Pjzinsd97dixAOXCD5tLMQPpPXXe3MZgTD+zCYYNSIcUrxsliHTpEa1dHecS2W18n/g1JknpAgscOuEuTMieNI+yInEC3XMlDX4Q7ds2kjDKo/Ey7xARr0/0sFvqenjqTrclSG490hD61Msj0wT2zWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ah7VxNUKo8L97VvPa5EabTRYwshFVo2g9Yncm8D9BXI=;
 b=MorvZdLUjNRZJGkUM0G/D38kIkRJp/1Xv8TUL6E6uTbzPBtEx9NkqxE0Dy8SkNLbXWOTyOtd3M/ZZhUhT/ACxYPY7J8xmLpzWRNKY6ta+4uyTGZcHW8W1YxGh5DFjWEHZDpD0YuhsPPmyZPui3wSO4vzmFM70heZroYlzUZcMaI=
Received: from DS7PR03CA0112.namprd03.prod.outlook.com (2603:10b6:5:3b7::27)
 by IA1PR12MB6041.namprd12.prod.outlook.com (2603:10b6:208:3d7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.21; Fri, 3 Nov
 2023 13:12:00 +0000
Received: from DS3PEPF000099D5.namprd04.prod.outlook.com
 (2603:10b6:5:3b7:cafe::29) by DS7PR03CA0112.outlook.office365.com
 (2603:10b6:5:3b7::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.22 via Frontend
 Transport; Fri, 3 Nov 2023 13:11:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D5.mail.protection.outlook.com (10.167.17.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6954.19 via Frontend Transport; Fri, 3 Nov 2023 13:11:59 +0000
Received: from jz-tester2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Fri, 3 Nov
 2023 08:11:58 -0500
From: James Zhu <James.Zhu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/24] drm/amdkfd: add pc sampling support
Date: Fri, 3 Nov 2023 09:11:17 -0400
Message-ID: <20231103131139.766920-3-James.Zhu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231103131139.766920-1-James.Zhu@amd.com>
References: <20231103131139.766920-1-James.Zhu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D5:EE_|IA1PR12MB6041:EE_
X-MS-Office365-Filtering-Correlation-Id: efd9d899-d5e7-48b9-ec7d-08dbdc6e76b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8QiikeFonzZDcWc70fvJfCGlTOfrWhATYR2hEt53EBpwF9HJeR05/3HBk3r6odRllSOcwk6Mg4zb0KjFzH/Lm0z/Y1h6iFLOB1rgQgSWAI/Jyfw88mkNfLAJtBplU22O+h6GSal+MGJiWCUexxqZk8bcWl407nJOQsbRa/QIXo8Q0i36OTsPYZyiZMyxpIpjE1Tdi2KSmoTyGcQJEITNTeIlbSjCLEgeoVj8/sa7B6tU3bTu/avd0eqFt/L9i06q5Q9vIuMuTUksEHcKfAipKlxleLJuWbLesh3PbreKAWdllCjEdIKzeERmBSHy3zLYKrFR8zR0rsqClDv3x5EOb5177d6e8lHwXZaoydOcIDV1lSyX30B7pJtGcHLnZpQK3/UG/A+IpIYtT1F9/tWo+nld8s31YJpzCP6nQrLu2OIWET8bP8XkGtokNu3ahewqXov+cpcSP1eK3kmaNMSbCdzcDK+3Wpj3XOp+EF/nLIRMGXMrWHkAJ2RLYomp7GbnMunuRnsx8k9dzd17yJJ3/8i/RRGI5B/u18uc43XM5fyVH0FX81XLPtiqrtU7I8xlRnam+5adr5BlSGktO2WeG67o41U1575mOS+90fj9p8qfVM1MQxh370mmkb0Pv/qvoHqWnnUSsztjBmM6vVbZM9uLGhLHRtp8QTMmKRLGeXNoQ275PntAIXaOz7LMBswaSg7thr5mZRLgA0NqFCCXXKztFRhl8GmvTW/wks27yyyxJh1Sv2x0jjQb9MlEe89dn7F2nbwDRtwRb8nxn7AbMA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(376002)(39860400002)(346002)(396003)(230922051799003)(82310400011)(186009)(451199024)(64100799003)(1800799009)(46966006)(40470700004)(36840700001)(47076005)(16526019)(7696005)(26005)(478600001)(54906003)(6666004)(2906002)(81166007)(40480700001)(70206006)(70586007)(1076003)(82740400003)(2616005)(36756003)(336012)(426003)(40460700003)(41300700001)(316002)(5660300002)(6916009)(66899024)(356005)(83380400001)(86362001)(36860700001)(4326008)(8676002)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2023 13:11:59.8267 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: efd9d899-d5e7-48b9-ec7d-08dbdc6e76b5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6041
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
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c     | 36 +++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.c | 78 ++++++++++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_pc_sampling.h | 34 +++++++++
 4 files changed, 150 insertions(+), 1 deletion(-)
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
index 06988cf1db51..b00390e451bf 100644
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
+			kfd_ioctl_pc_sample, 0),
 };
 
 #define AMDKFD_CORE_IOCTL_COUNT	ARRAY_SIZE(amdkfd_ioctls)
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
-- 
2.25.1

