Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24FA7ECAAD5
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Aug 2022 14:32:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2995310F342;
	Mon, 29 Aug 2022 14:32:39 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2049.outbound.protection.outlook.com [40.107.102.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1BADC10F2F2
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Aug 2022 14:31:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nU8b7WKSeg3lWLuVHLd2CvepfMB0iA542f1JlbNJkWb8/8MKLmOUt+c6QuXzEKMXu4hq5UVj5dfRBcAPet3d4Q6KAQy48zDwBmzNmGwHihff961ycMgHstf3BBDrKXj6rc9SIVHPu0yVHj7/SGI0VzLTNx+Tzk8YD9KR+0MbzKHxAVbGcCM9ozCyfUZrZxeutkRw7wxhaxhMpcKKWqFQ/Br0bw4q7yhdAZh/YpT9K2sQRgMKuijiYXV1BYM/s3cnCw92ldpZY/G2jBU5jpFn2BnPf6FGXc7llc415uWggUhyfICSDbRt1uSLhbRULwtrktBx/UwymtuodikZYpC0dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gk0OgWcIgo9vaYjqpA0zUrRY0dfh3cE71+3Irei8NY4=;
 b=OKgI51xM2jtvu30QaYGFFQ0uN3k43/iwUPKPEaNHrS1cnIKN9YLZurwaBSWOADxGG+STFqUYOPs+Z32UMvUW2WtE+kOqlsFbNAhZ99alEM+MCf7b/qZ+UjRBpJQ5ucUY2dl70pCugQCLEY9A0iiJSnooudBlXjOXJ3autzeu6zzNhfPnZT67m7Q/nLn7nHwjjq3cF5Vu2f4aZA12rDw2aOMDPJfmOdjeiJXDDcnkQ77lbq5hKN/pBdPlBwIjA+fGEBtQ0PCObsFHhOLSigdbxPrdLdHXwpHZQXUOXAoAmFrV2I/zicHm6+aq8oIY1RheUc6s/lOTK72edIyqPsUwOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gk0OgWcIgo9vaYjqpA0zUrRY0dfh3cE71+3Irei8NY4=;
 b=s+Hk0BstR6IB31y31J7mpYs6EdFp8BmIlUBR+923Vz/T7R3Nw90HNXWHt6pDufq4jpkoQsbW8xl3bsObvUPPMXuiBXZMtpLFNdB1ISY3wMUOwQsJIaHw8m/CLnXGwidBkjHHMPLw0+g2rNnB5oCZ+g7Uglrrgh/9wGtVca+rixk=
Received: from MW4PR04CA0174.namprd04.prod.outlook.com (2603:10b6:303:85::29)
 by MWHPR1201MB0190.namprd12.prod.outlook.com (2603:10b6:301:55::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.19; Mon, 29 Aug
 2022 14:31:14 +0000
Received: from CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:85:cafe::21) by MW4PR04CA0174.outlook.office365.com
 (2603:10b6:303:85::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21 via Frontend
 Transport; Mon, 29 Aug 2022 14:31:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT009.mail.protection.outlook.com (10.13.175.61) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.15 via Frontend Transport; Mon, 29 Aug 2022 14:31:14 +0000
Received: from jonathan-KFD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 29 Aug
 2022 09:30:49 -0500
From: Jonathan Kim <jonathan.kim@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 18/29] drm/amdkfd: update process interrupt handling for debug
 events
Date: Mon, 29 Aug 2022 10:30:15 -0400
Message-ID: <20220829143026.1509027-19-jonathan.kim@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220829143026.1509027-1-jonathan.kim@amd.com>
References: <20220829143026.1509027-1-jonathan.kim@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f800fdcc-5dbc-4878-3bf9-08da89cb2093
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0190:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Dj2K0QLsEFmkkjEXFl1IJNlF9iIXPeKHzgvV/5XEvUvbL8rSd6rm2JKJlt1+oiV6H+mN1VCxWJn1Mo2SAS+IbVeKJd5fIzSO+RV9NH7sR4GwPfhwSEtUm4SM2rITGRDDQX2I4TNiFw3RxRwiygbn/1AcqC3WywHkz7Q5Yaqyoyx3xYAFMrKfR0KNnhf1hpIj62EvOJVR9S8i2JST6d1amurx5rfEPRpjgDe4cP2IaZwv7F87kUFeqlcsvgGRp9Kcj2o6qMunZkaMZCFh6xPwzYIL/jEqoCj95CysFAecAHicefWf6aB5QG/JhVKifpE/LsQJBZE8cIE4GF5Qw/embhPPfVd7iEzYW+VsL2KOIAbFIfWE/3+dzRLKk69NAVS03GrVxrbI4Zt1q6ObADWcD05rwnWWRvesDE7UWbR+CMUWMB6TBlDEQef0ebSTvcssbWipVOH5z+cicnIM7kHvnHr/AWqipbxzsX2Nq7Q6ytyB72Oxf09dHk8kdRZ1ptdGz0mYHuPUFfl7LtUaxf2p+58C4I4RpC3is/FOjSEib98nx+RtJTR253KQ/l87EBEllmY/pAgKPDA1rnSbQR7lX9CNJAqzP4BJKec0wjXieGkb9OP7SYX4GE9O4IvAIJO/VHpaHiRh8DunYjU2qXef3HshSBh7RVUFdX4xXxjR5AMEA6oH5MLQa30hhcMF9u2Qt9046FsY9qP38SzUOqrrPN6inrnFrkrIDrA6GXazWd3LuWB/b6ZuvyLoXSCl6EF5j2or9pFYbP4SNamNiP5lFDynGn+mUtcmqe+U3ZEAULQ4Gerl8M8Nq6Yzh2PgMTVA
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(396003)(136003)(39860400002)(376002)(40470700004)(46966006)(36840700001)(2906002)(44832011)(82740400003)(30864003)(6666004)(2616005)(82310400005)(26005)(15650500001)(426003)(7696005)(40480700001)(40460700003)(47076005)(16526019)(336012)(186003)(1076003)(36860700001)(83380400001)(356005)(316002)(6916009)(8676002)(4326008)(70206006)(70586007)(41300700001)(81166007)(8936002)(54906003)(86362001)(36756003)(5660300002)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2022 14:31:14.2358 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f800fdcc-5dbc-4878-3bf9-08da89cb2093
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0190
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
Cc: Felix.Kuehling@amd.com, Lancelot.Six@amd.com, Laurent.Morichetti@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The debugger must be notified by any debugger subscribed exception
that comes from hardware interrupts.

Debugger notification must be scheduled as HW state may be unknown
when receiving an exception that could require an immediate process
eviction.

If a debugger session exits, any exceptions it subscribed to may still
have interrupts in the interrupt ring buffer or KGD/KFD pipeline.
To prevent a new session from inheriting stale interrupts, when a new
queue is created, open an interrupt drain and allow the IH ring to drain
from a timestamped checkpoint.  Then inject a custom IV so that once
the custom IV is picked up by the KFD, it's safe to close the drain
and proceed with queue creation.

The debugger may also not be attached nor subscibed to certain
exceptions so forward them directly to the runtime.

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c    |  16 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |   2 +
 drivers/gpu/drm/amd/amdkfd/Makefile           |   1 +
 drivers/gpu/drm/amd/amdkfd/kfd_debug.c        |  59 +++
 drivers/gpu/drm/amd/amdkfd/kfd_debug.h        |   6 +
 drivers/gpu/drm/amd/amdkfd/kfd_device.c       |   4 +-
 .../gpu/drm/amd/amdkfd/kfd_int_process_v10.c  | 402 ++++++++++++++++++
 .../gpu/drm/amd/amdkfd/kfd_int_process_v9.c   |  95 ++++-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  12 +
 drivers/gpu/drm/amd/amdkfd/kfd_process.c      |  43 ++
 .../amd/amdkfd/kfd_process_queue_manager.c    |   1 +
 11 files changed, 631 insertions(+), 10 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdkfd/kfd_int_process_v10.c

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 091415a4abf0..1004d162efc1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -760,6 +760,22 @@ void amdgpu_amdkfd_ras_poison_consumption_handler(struct amdgpu_device *adev, bo
 		amdgpu_amdkfd_gpu_reset(adev);
 }
 
+int amdgpu_amdkfd_send_close_event_drain_irq(struct amdgpu_device *adev,
+					uint32_t *payload)
+{
+	int ret;
+
+	/* Device or IH ring is not ready so bail. */
+	ret = amdgpu_ih_wait_on_checkpoint_process_ts(adev, &adev->irq.ih);
+	if (ret)
+		return ret;
+
+	/* Send payload to fence KFD interrupts */
+	amdgpu_amdkfd_interrupt(adev, payload);
+
+	return 0;
+}
+
 bool amdgpu_amdkfd_ras_query_utcl2_poison_status(struct amdgpu_device *adev)
 {
 	if (adev->gfx.ras && adev->gfx.ras->query_utcl2_poison_status)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index 647220a8762d..5ba68ec08199 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -236,6 +236,8 @@ int amdgpu_amdkfd_get_xgmi_bandwidth_mbytes(struct amdgpu_device *dst,
 					    struct amdgpu_device *src,
 					    bool is_min);
 int amdgpu_amdkfd_get_pcie_bandwidth_mbytes(struct amdgpu_device *adev, bool is_min);
+int amdgpu_amdkfd_send_close_event_drain_irq(struct amdgpu_device *adev,
+					uint32_t *payload);
 
 /* Read user wptr from a specified user address space with page fault
  * disabled. The memory must be pinned and mapped to the hardware when
diff --git a/drivers/gpu/drm/amd/amdkfd/Makefile b/drivers/gpu/drm/amd/amdkfd/Makefile
index 747754428073..2ec8f27c5366 100644
--- a/drivers/gpu/drm/amd/amdkfd/Makefile
+++ b/drivers/gpu/drm/amd/amdkfd/Makefile
@@ -53,6 +53,7 @@ AMDKFD_FILES	:= $(AMDKFD_PATH)/kfd_module.o \
 		$(AMDKFD_PATH)/kfd_events.o \
 		$(AMDKFD_PATH)/cik_event_interrupt.o \
 		$(AMDKFD_PATH)/kfd_int_process_v9.o \
+		$(AMDKFD_PATH)/kfd_int_process_v10.o \
 		$(AMDKFD_PATH)/kfd_int_process_v11.o \
 		$(AMDKFD_PATH)/kfd_smi_events.o \
 		$(AMDKFD_PATH)/kfd_crat.o \
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
index d4f87f2adada..8d0e6802e2fb 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
@@ -125,6 +125,65 @@ bool kfd_dbg_ev_raise(uint64_t event_mask,
 	return is_subscribed;
 }
 
+/* set pending event queue entry from ring entry  */
+bool kfd_set_dbg_ev_from_interrupt(struct kfd_dev *dev,
+				   unsigned int pasid,
+				   uint32_t doorbell_id,
+				   uint64_t trap_mask,
+				   void *exception_data,
+				   size_t exception_data_size)
+{
+	struct kfd_process *p;
+	bool signaled_to_debugger_or_runtime = false;
+
+	p = kfd_lookup_process_by_pasid(pasid);
+
+	if (!p)
+		return false;
+
+	if (!kfd_dbg_ev_raise(trap_mask, p, dev, doorbell_id, true,
+					exception_data, exception_data_size)) {
+		struct process_queue_manager *pqm;
+		struct process_queue_node *pqn;
+
+		if (!!(trap_mask & KFD_EC_MASK_QUEUE) &&
+				p->runtime_info.runtime_state == DEBUG_RUNTIME_STATE_ENABLED) {
+			mutex_lock(&p->mutex);
+
+			pqm = &p->pqm;
+			list_for_each_entry(pqn, &pqm->queues,
+							process_queue_list) {
+
+				if (!(pqn->q && pqn->q->device == dev &&
+						pqn->q->doorbell_id == doorbell_id))
+					continue;
+
+				kfd_send_exception_to_runtime(p,
+						pqn->q->properties.queue_id,
+						trap_mask);
+
+				signaled_to_debugger_or_runtime = true;
+
+				break;
+			}
+
+			mutex_unlock(&p->mutex);
+		} else if (trap_mask & KFD_EC_MASK(EC_DEVICE_MEMORY_VIOLATION)) {
+			kfd_dqm_evict_pasid(dev->dqm, p->pasid);
+			kfd_signal_vm_fault_event(dev, p->pasid, NULL,
+							exception_data);
+
+			signaled_to_debugger_or_runtime = true;
+		}
+	} else {
+		signaled_to_debugger_or_runtime = true;
+	}
+
+	kfd_unref_process(p);
+
+	return signaled_to_debugger_or_runtime;
+}
+
 int kfd_dbg_send_exception_to_runtime(struct kfd_process *p,
 					unsigned int dev_id,
 					unsigned int queue_id,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.h b/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
index e31c9bb0e848..5270d5749828 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
@@ -30,6 +30,12 @@ void kgd_gfx_v9_set_wave_launch_stall(struct amdgpu_device *adev,
 					bool stall);
 void kfd_dbg_trap_deactivate(struct kfd_process *target, bool unwind, int unwind_count);
 int kfd_dbg_trap_activate(struct kfd_process *target);
+bool kfd_set_dbg_ev_from_interrupt(struct kfd_dev *dev,
+				   unsigned int pasid,
+				   uint32_t doorbell_id,
+				   uint64_t trap_mask,
+				   void *exception_data,
+				   size_t exception_data_size);
 bool kfd_dbg_ev_raise(uint64_t event_mask,
 			struct kfd_process *process, struct kfd_dev *dev,
 			unsigned int source_id, bool use_worker,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index fdad1415f8bd..0bbaf262ea19 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -133,6 +133,8 @@ static void kfd_device_info_set_event_interrupt_class(struct kfd_dev *kfd)
 	case IP_VERSION(9, 4, 0): /* VEGA20 */
 	case IP_VERSION(9, 4, 1): /* ARCTURUS */
 	case IP_VERSION(9, 4, 2): /* ALDEBARAN */
+		kfd->device_info.event_interrupt_class = &event_interrupt_class_v9;
+		break;
 	case IP_VERSION(10, 3, 1): /* VANGOGH */
 	case IP_VERSION(10, 3, 3): /* YELLOW_CARP */
 	case IP_VERSION(10, 3, 6): /* GC 10.3.6 */
@@ -146,7 +148,7 @@ static void kfd_device_info_set_event_interrupt_class(struct kfd_dev *kfd)
 	case IP_VERSION(10, 3, 2): /* NAVY_FLOUNDER */
 	case IP_VERSION(10, 3, 4): /* DIMGREY_CAVEFISH */
 	case IP_VERSION(10, 3, 5): /* BEIGE_GOBY */
-		kfd->device_info.event_interrupt_class = &event_interrupt_class_v9;
+		kfd->device_info.event_interrupt_class = &event_interrupt_class_v10;
 		break;
 	case IP_VERSION(11, 0, 0):
 	case IP_VERSION(11, 0, 1):
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v10.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v10.c
new file mode 100644
index 000000000000..e954245e9c21
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v10.c
@@ -0,0 +1,402 @@
+/*
+ * Copyright 2022 Advanced Micro Devices, Inc.
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
+#include "kfd_events.h"
+#include "kfd_debug.h"
+#include "soc15_int.h"
+#include "kfd_device_queue_manager.h"
+
+/*
+ * GFX10 SQ Interrupts
+ *
+ * There are 3 encoding types of interrupts sourced from SQ sent as a 44-bit
+ * packet to the Interrupt Handler:
+ * Auto - Generated by the SQG (various cmd overflows, timestamps etc)
+ * Wave - Generated by S_SENDMSG through a shader program
+ * Error - HW generated errors (Illegal instructions, Memviols, EDC etc)
+ *
+ * The 44-bit packet is mapped as {context_id1[7:0],context_id0[31:0]} plus
+ * 4-bits for VMID (SOC15_VMID_FROM_IH_ENTRY) as such:
+ *
+ * - context_id1[7:6]
+ * Encoding type (0 = Auto, 1 = Wave, 2 = Error)
+ *
+ * - context_id0[24]
+ * PRIV bit indicates that Wave S_SEND or error occurred within trap
+ *
+ * - context_id0[22:0]
+ * 23-bit data with the following layout per encoding type:
+ * Auto - only context_id0[8:0] is used, which reports various interrupts
+ * generated by SQG.  The rest is 0.
+ * Wave - user data sent from m0 via S_SENDMSG
+ * Error - Error type (context_id0[22:19]), Error Details (rest of bits)
+ *
+ * The other context_id bits show coordinates (SE/SH/CU/SIMD/WGP) for wave
+ * S_SENDMSG and Errors.  These are 0 for Auto.
+ */
+
+enum SQ_INTERRUPT_WORD_ENCODING {
+	SQ_INTERRUPT_WORD_ENCODING_AUTO = 0x0,
+	SQ_INTERRUPT_WORD_ENCODING_INST,
+	SQ_INTERRUPT_WORD_ENCODING_ERROR,
+};
+
+enum SQ_INTERRUPT_ERROR_TYPE {
+	SQ_INTERRUPT_ERROR_TYPE_EDC_FUE = 0x0,
+	SQ_INTERRUPT_ERROR_TYPE_ILLEGAL_INST,
+	SQ_INTERRUPT_ERROR_TYPE_MEMVIOL,
+	SQ_INTERRUPT_ERROR_TYPE_EDC_FED,
+};
+
+/* SQ_INTERRUPT_WORD_AUTO_CTXID */
+#define SQ_INTERRUPT_WORD_AUTO_CTXID0__THREAD_TRACE__SHIFT 0
+#define SQ_INTERRUPT_WORD_AUTO_CTXID0__WLT__SHIFT 1
+#define SQ_INTERRUPT_WORD_AUTO_CTXID0__THREAD_TRACE_BUF0_FULL__SHIFT 2
+#define SQ_INTERRUPT_WORD_AUTO_CTXID0__THREAD_TRACE_BUF1_FULL__SHIFT 3
+#define SQ_INTERRUPT_WORD_AUTO_CTXID0__THREAD_TRACE_UTC_ERROR__SHIFT 7
+#define SQ_INTERRUPT_WORD_AUTO_CTXID1__SE_ID__SHIFT 4
+#define SQ_INTERRUPT_WORD_AUTO_CTXID1__ENCODING__SHIFT 6
+
+#define SQ_INTERRUPT_WORD_AUTO_CTXID0__THREAD_TRACE_MASK 0x00000001
+#define SQ_INTERRUPT_WORD_AUTO_CTXID0__WLT_MASK 0x00000002
+#define SQ_INTERRUPT_WORD_AUTO_CTXID0__THREAD_TRACE_BUF0_FULL_MASK 0x00000004
+#define SQ_INTERRUPT_WORD_AUTO_CTXID0__THREAD_TRACE_BUF1_FULL_MASK 0x00000008
+#define SQ_INTERRUPT_WORD_AUTO_CTXID0__THREAD_TRACE_UTC_ERROR_MASK 0x00000080
+#define SQ_INTERRUPT_WORD_AUTO_CTXID1__SE_ID_MASK 0x030
+#define SQ_INTERRUPT_WORD_AUTO_CTXID1__ENCODING_MASK 0x0c0
+
+/* SQ_INTERRUPT_WORD_WAVE_CTXID */
+#define SQ_INTERRUPT_WORD_WAVE_CTXID0__DATA__SHIFT 0
+#define SQ_INTERRUPT_WORD_WAVE_CTXID0__SA_ID__SHIFT 23
+#define SQ_INTERRUPT_WORD_WAVE_CTXID0__PRIV__SHIFT 24
+#define SQ_INTERRUPT_WORD_WAVE_CTXID0__WAVE_ID__SHIFT 25
+#define SQ_INTERRUPT_WORD_WAVE_CTXID0__SIMD_ID__SHIFT 30
+#define SQ_INTERRUPT_WORD_WAVE_CTXID1__WGP_ID__SHIFT 0
+#define SQ_INTERRUPT_WORD_WAVE_CTXID1__SE_ID__SHIFT 4
+#define SQ_INTERRUPT_WORD_WAVE_CTXID1__ENCODING__SHIFT 6
+
+#define SQ_INTERRUPT_WORD_WAVE_CTXID0__DATA_MASK 0x000007fffff
+#define SQ_INTERRUPT_WORD_WAVE_CTXID0__SA_ID_MASK 0x0000800000
+#define SQ_INTERRUPT_WORD_WAVE_CTXID0__PRIV_MASK 0x00001000000
+#define SQ_INTERRUPT_WORD_WAVE_CTXID0__WAVE_ID_MASK 0x0003e000000
+#define SQ_INTERRUPT_WORD_WAVE_CTXID0__SIMD_ID_MASK 0x000c0000000
+#define SQ_INTERRUPT_WORD_WAVE_CTXID1__WGP_ID_MASK 0x00f
+#define SQ_INTERRUPT_WORD_WAVE_CTXID1__SE_ID_MASK 0x030
+#define SQ_INTERRUPT_WORD_WAVE_CTXID1__ENCODING_MASK 0x0c0
+
+#define KFD_CTXID0__ERR_TYPE_MASK 0x780000
+#define KFD_CTXID0__ERR_TYPE__SHIFT 19
+
+/* GFX10 SQ interrupt ENC type bit (context_id1[7:6]) for wave s_sendmsg */
+#define KFD_CONTEXT_ID1_ENC_TYPE_WAVE_MASK	0x40
+/* GFX10 SQ interrupt PRIV bit (context_id0[24]) for s_sendmsg inside trap */
+#define KFD_CONTEXT_ID0_PRIV_MASK		0x1000000
+/*
+ * The debugger will send user data(m0) with PRIV=1 to indicate it requires
+ * notification from the KFD with the following queue id (DOORBELL_ID) and
+ * trap code (TRAP_CODE).
+ */
+#define KFD_CONTEXT_ID0_DEBUG_DOORBELL_MASK	0x0003ff
+#define KFD_CONTEXT_ID0_DEBUG_TRAP_CODE_SHIFT	10
+#define KFD_CONTEXT_ID0_DEBUG_TRAP_CODE_MASK	0x07fc00
+#define KFD_DEBUG_DOORBELL_ID(ctxid0)	((ctxid0) &	\
+				KFD_CONTEXT_ID0_DEBUG_DOORBELL_MASK)
+#define KFD_DEBUG_TRAP_CODE(ctxid0)	(((ctxid0) &	\
+				KFD_CONTEXT_ID0_DEBUG_TRAP_CODE_MASK)	\
+				>> KFD_CONTEXT_ID0_DEBUG_TRAP_CODE_SHIFT)
+#define KFD_DEBUG_CP_BAD_OP_ECODE(ctxid0) (((ctxid0) & 0x3ffffff)	\
+				>> KFD_CONTEXT_ID0_DEBUG_TRAP_CODE_SHIFT)
+
+static void event_interrupt_poison_consumption(struct kfd_dev *dev,
+				uint16_t pasid, uint16_t client_id)
+{
+	int old_poison, ret = -EINVAL;
+	struct kfd_process *p = kfd_lookup_process_by_pasid(pasid);
+
+	if (!p)
+		return;
+
+	/* all queues of a process will be unmapped in one time */
+	old_poison = atomic_cmpxchg(&p->poison, 0, 1);
+	kfd_unref_process(p);
+	if (old_poison)
+		return;
+
+	switch (client_id) {
+	case SOC15_IH_CLIENTID_SE0SH:
+	case SOC15_IH_CLIENTID_SE1SH:
+	case SOC15_IH_CLIENTID_SE2SH:
+	case SOC15_IH_CLIENTID_SE3SH:
+	case SOC15_IH_CLIENTID_UTCL2:
+		ret = kfd_dqm_evict_pasid(dev->dqm, pasid);
+		break;
+	case SOC15_IH_CLIENTID_SDMA0:
+	case SOC15_IH_CLIENTID_SDMA1:
+	case SOC15_IH_CLIENTID_SDMA2:
+	case SOC15_IH_CLIENTID_SDMA3:
+	case SOC15_IH_CLIENTID_SDMA4:
+		break;
+	default:
+		break;
+	}
+
+	kfd_signal_poison_consumed_event(dev, pasid);
+
+	/* resetting queue passes, do page retirement without gpu reset
+	 * resetting queue fails, fallback to gpu reset solution
+	 */
+	if (!ret) {
+		dev_warn(dev->adev->dev,
+			"RAS poison consumption, unmap queue flow succeeded: client id %d\n",
+			client_id);
+		amdgpu_amdkfd_ras_poison_consumption_handler(dev->adev, false);
+	} else {
+		dev_warn(dev->adev->dev,
+			"RAS poison consumption, fall back to gpu reset flow: client id %d\n",
+			client_id);
+		amdgpu_amdkfd_ras_poison_consumption_handler(dev->adev, true);
+	}
+}
+
+static bool event_interrupt_isr_v10(struct kfd_dev *dev,
+					const uint32_t *ih_ring_entry,
+					uint32_t *patched_ihre,
+					bool *patched_flag)
+{
+	uint16_t source_id, client_id, pasid, vmid;
+	const uint32_t *data = ih_ring_entry;
+
+	source_id = SOC15_SOURCE_ID_FROM_IH_ENTRY(ih_ring_entry);
+	client_id = SOC15_CLIENT_ID_FROM_IH_ENTRY(ih_ring_entry);
+
+	/* Only handle interrupts from KFD VMIDs */
+	vmid = SOC15_VMID_FROM_IH_ENTRY(ih_ring_entry);
+	if (!KFD_IRQ_IS_FENCE(client_id, source_id) &&
+	   (vmid < dev->vm_info.first_vmid_kfd ||
+	    vmid > dev->vm_info.last_vmid_kfd))
+		return false;
+
+	pasid = SOC15_PASID_FROM_IH_ENTRY(ih_ring_entry);
+
+	/* Only handle clients we care about */
+	if (client_id != SOC15_IH_CLIENTID_GRBM_CP &&
+	    client_id != SOC15_IH_CLIENTID_SDMA0 &&
+	    client_id != SOC15_IH_CLIENTID_SDMA1 &&
+	    client_id != SOC15_IH_CLIENTID_SDMA2 &&
+	    client_id != SOC15_IH_CLIENTID_SDMA3 &&
+	    client_id != SOC15_IH_CLIENTID_SDMA4 &&
+	    client_id != SOC15_IH_CLIENTID_SDMA5 &&
+	    client_id != SOC15_IH_CLIENTID_SDMA6 &&
+	    client_id != SOC15_IH_CLIENTID_SDMA7 &&
+	    client_id != SOC15_IH_CLIENTID_VMC &&
+	    client_id != SOC15_IH_CLIENTID_VMC1 &&
+	    client_id != SOC15_IH_CLIENTID_UTCL2 &&
+	    client_id != SOC15_IH_CLIENTID_SE0SH &&
+	    client_id != SOC15_IH_CLIENTID_SE1SH &&
+	    client_id != SOC15_IH_CLIENTID_SE2SH &&
+	    client_id != SOC15_IH_CLIENTID_SE3SH)
+		return false;
+
+	pr_debug("client id 0x%x, source id %d, vmid %d, pasid 0x%x. raw data:\n",
+		 client_id, source_id, vmid, pasid);
+	pr_debug("%8X, %8X, %8X, %8X, %8X, %8X, %8X, %8X.\n",
+		 data[0], data[1], data[2], data[3],
+		 data[4], data[5], data[6], data[7]);
+
+	/* If there is no valid PASID, it's likely a bug */
+	if (WARN_ONCE(pasid == 0, "Bug: No PASID in KFD interrupt"))
+		return 0;
+
+	/* Interrupt types we care about: various signals and faults.
+	 * They will be forwarded to a work queue (see below).
+	 */
+	return source_id == SOC15_INTSRC_CP_END_OF_PIPE ||
+		source_id == SOC15_INTSRC_SDMA_TRAP ||
+		source_id == SOC15_INTSRC_SQ_INTERRUPT_MSG ||
+		source_id == SOC15_INTSRC_CP_BAD_OPCODE ||
+		client_id == SOC15_IH_CLIENTID_VMC ||
+		client_id == SOC15_IH_CLIENTID_VMC1 ||
+		client_id == SOC15_IH_CLIENTID_UTCL2 ||
+		KFD_IRQ_IS_FENCE(client_id, source_id);
+}
+
+static void event_interrupt_wq_v10(struct kfd_dev *dev,
+					const uint32_t *ih_ring_entry)
+{
+	uint16_t source_id, client_id, pasid, vmid;
+	uint32_t context_id0, context_id1;
+	uint32_t encoding, sq_intr_err_type;
+
+	source_id = SOC15_SOURCE_ID_FROM_IH_ENTRY(ih_ring_entry);
+	client_id = SOC15_CLIENT_ID_FROM_IH_ENTRY(ih_ring_entry);
+	pasid = SOC15_PASID_FROM_IH_ENTRY(ih_ring_entry);
+	vmid = SOC15_VMID_FROM_IH_ENTRY(ih_ring_entry);
+	context_id0 = SOC15_CONTEXT_ID0_FROM_IH_ENTRY(ih_ring_entry);
+	context_id1 = SOC15_CONTEXT_ID1_FROM_IH_ENTRY(ih_ring_entry);
+
+	if (client_id == SOC15_IH_CLIENTID_GRBM_CP ||
+	    client_id == SOC15_IH_CLIENTID_SE0SH ||
+	    client_id == SOC15_IH_CLIENTID_SE1SH ||
+	    client_id == SOC15_IH_CLIENTID_SE2SH ||
+	    client_id == SOC15_IH_CLIENTID_SE3SH) {
+		if (source_id == SOC15_INTSRC_CP_END_OF_PIPE)
+			kfd_signal_event_interrupt(pasid, context_id0, 32);
+		else if (source_id == SOC15_INTSRC_SQ_INTERRUPT_MSG) {
+			encoding = REG_GET_FIELD(context_id1,
+						SQ_INTERRUPT_WORD_WAVE_CTXID1, ENCODING);
+			switch (encoding) {
+			case SQ_INTERRUPT_WORD_ENCODING_AUTO:
+				pr_debug(
+					"sq_intr: auto, se %d, ttrace %d, wlt %d, ttrac_buf0_full %d, ttrac_buf1_full %d, ttrace_utc_err %d\n",
+					REG_GET_FIELD(context_id1, SQ_INTERRUPT_WORD_AUTO_CTXID1,
+							SE_ID),
+					REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_AUTO_CTXID0,
+							THREAD_TRACE),
+					REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_AUTO_CTXID0,
+							WLT),
+					REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_AUTO_CTXID0,
+							THREAD_TRACE_BUF0_FULL),
+					REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_AUTO_CTXID0,
+							THREAD_TRACE_BUF1_FULL),
+					REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_AUTO_CTXID0,
+							THREAD_TRACE_UTC_ERROR));
+				break;
+			case SQ_INTERRUPT_WORD_ENCODING_INST:
+				pr_debug("sq_intr: inst, se %d, data 0x%x, sa %d, priv %d, wave_id %d, simd_id %d, wgp_id %d\n",
+					REG_GET_FIELD(context_id1, SQ_INTERRUPT_WORD_WAVE_CTXID1,
+							SE_ID),
+					REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_WAVE_CTXID0,
+							DATA),
+					REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_WAVE_CTXID0,
+							SA_ID),
+					REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_WAVE_CTXID0,
+							PRIV),
+					REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_WAVE_CTXID0,
+							WAVE_ID),
+					REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_WAVE_CTXID0,
+							SIMD_ID),
+					REG_GET_FIELD(context_id1, SQ_INTERRUPT_WORD_WAVE_CTXID1,
+							WGP_ID));
+				if (context_id0 & SQ_INTERRUPT_WORD_WAVE_CTXID0__PRIV_MASK) {
+					if (kfd_set_dbg_ev_from_interrupt(dev, pasid,
+							KFD_DEBUG_DOORBELL_ID(context_id0),
+							KFD_DEBUG_TRAP_CODE(context_id0),
+							NULL, 0))
+						return;
+				}
+				break;
+			case SQ_INTERRUPT_WORD_ENCODING_ERROR:
+				sq_intr_err_type = REG_GET_FIELD(context_id0, KFD_CTXID0,
+								ERR_TYPE);
+				pr_warn("sq_intr: error, se %d, data 0x%x, sa %d, priv %d, wave_id %d, simd_id %d, wgp_id %d, err_type %d\n",
+					REG_GET_FIELD(context_id1, SQ_INTERRUPT_WORD_WAVE_CTXID1,
+							SE_ID),
+					REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_WAVE_CTXID0,
+							DATA),
+					REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_WAVE_CTXID0,
+							SA_ID),
+					REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_WAVE_CTXID0,
+							PRIV),
+					REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_WAVE_CTXID0,
+							WAVE_ID),
+					REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_WAVE_CTXID0,
+							SIMD_ID),
+					REG_GET_FIELD(context_id1, SQ_INTERRUPT_WORD_WAVE_CTXID1,
+							WGP_ID),
+					sq_intr_err_type);
+				if (sq_intr_err_type != SQ_INTERRUPT_ERROR_TYPE_ILLEGAL_INST &&
+					sq_intr_err_type != SQ_INTERRUPT_ERROR_TYPE_MEMVIOL) {
+					event_interrupt_poison_consumption(dev, pasid, source_id);
+					return;
+				}
+				break;
+			default:
+				break;
+			}
+			kfd_signal_event_interrupt(pasid, context_id0 & 0x7fffff, 23);
+		} else if (source_id == SOC15_INTSRC_CP_BAD_OPCODE) {
+			kfd_set_dbg_ev_from_interrupt(dev, pasid,
+				KFD_DEBUG_DOORBELL_ID(context_id0),
+				KFD_EC_MASK(KFD_DEBUG_CP_BAD_OP_ECODE(context_id0)),
+				NULL,
+				0);
+		}
+	} else if (client_id == SOC15_IH_CLIENTID_SDMA0 ||
+		   client_id == SOC15_IH_CLIENTID_SDMA1 ||
+		   client_id == SOC15_IH_CLIENTID_SDMA2 ||
+		   client_id == SOC15_IH_CLIENTID_SDMA3 ||
+		   (client_id == SOC15_IH_CLIENTID_SDMA3_Sienna_Cichlid &&
+		    KFD_GC_VERSION(dev) == IP_VERSION(10, 3, 0)) ||
+		   client_id == SOC15_IH_CLIENTID_SDMA4 ||
+		   client_id == SOC15_IH_CLIENTID_SDMA5 ||
+		   client_id == SOC15_IH_CLIENTID_SDMA6 ||
+		   client_id == SOC15_IH_CLIENTID_SDMA7) {
+		if (source_id == SOC15_INTSRC_SDMA_TRAP) {
+			kfd_signal_event_interrupt(pasid, context_id0 & 0xfffffff, 28);
+		} else if (source_id == SOC15_INTSRC_SDMA_ECC) {
+			event_interrupt_poison_consumption(dev, pasid, source_id);
+			return;
+		}
+	} else if (client_id == SOC15_IH_CLIENTID_VMC ||
+		   client_id == SOC15_IH_CLIENTID_VMC1 ||
+		   client_id == SOC15_IH_CLIENTID_UTCL2) {
+		struct kfd_vm_fault_info info = {0};
+		uint16_t ring_id = SOC15_RING_ID_FROM_IH_ENTRY(ih_ring_entry);
+		struct kfd_hsa_memory_exception_data exception_data;
+
+		if (client_id == SOC15_IH_CLIENTID_UTCL2 &&
+				amdgpu_amdkfd_ras_query_utcl2_poison_status(dev->adev)) {
+			event_interrupt_poison_consumption(dev, pasid, client_id);
+			return;
+		}
+
+		info.vmid = vmid;
+		info.mc_id = client_id;
+		info.page_addr = ih_ring_entry[4] |
+			(uint64_t)(ih_ring_entry[5] & 0xf) << 32;
+		info.prot_valid = ring_id & 0x08;
+		info.prot_read  = ring_id & 0x10;
+		info.prot_write = ring_id & 0x20;
+
+		memset(&exception_data, 0, sizeof(exception_data));
+		exception_data.gpu_id = dev->id;
+		exception_data.va = (info.page_addr) << PAGE_SHIFT;
+		exception_data.failure.NotPresent = info.prot_valid ? 1 : 0;
+		exception_data.failure.NoExecute = info.prot_exec ? 1 : 0;
+		exception_data.failure.ReadOnly = info.prot_write ? 1 : 0;
+		exception_data.failure.imprecise = 0;
+
+		kfd_set_dbg_ev_from_interrupt(dev,
+						pasid,
+						-1,
+						KFD_EC_MASK(EC_DEVICE_MEMORY_VIOLATION),
+						&exception_data,
+						sizeof(exception_data));
+	} else if (KFD_IRQ_IS_FENCE(client_id, source_id)) {
+		kfd_process_close_interrupt_drain(pasid);
+	}
+}
+
+const struct kfd_event_interrupt_class event_interrupt_class_v10 = {
+	.interrupt_isr = event_interrupt_isr_v10,
+	.interrupt_wq = event_interrupt_wq_v10,
+};
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
index e092563f22de..33f6d319ce1d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
@@ -23,10 +23,40 @@
 
 #include "kfd_priv.h"
 #include "kfd_events.h"
+#include "kfd_debug.h"
 #include "soc15_int.h"
 #include "kfd_device_queue_manager.h"
 #include "kfd_smi_events.h"
 
+/*
+ * GFX9 SQ Interrupts
+ *
+ * There are 3 encoding types of interrupts sourced from SQ sent as a 44-bit
+ * packet to the Interrupt Handler:
+ * Auto - Generated by the SQG (various cmd overflows, timestamps etc)
+ * Wave - Generated by S_SENDMSG through a shader program
+ * Error - HW generated errors (Illegal instructions, Memviols, EDC etc)
+ *
+ * The 44-bit packet is mapped as {context_id1[7:0],context_id0[31:0]} plus
+ * 4-bits for VMID (SOC15_VMID_FROM_IH_ENTRY) as such:
+ *
+ * - context_id0[27:26]
+ * Encoding type (0 = Auto, 1 = Wave, 2 = Error)
+ *
+ * - context_id0[13]
+ * PRIV bit indicates that Wave S_SEND or error occurred within trap
+ *
+ * - {context_id1[7:0],context_id0[31:28],context_id0[11:0]}
+ * 24-bit data with the following layout per encoding type:
+ * Auto - only context_id0[8:0] is used, which reports various interrupts
+ * generated by SQG.  The rest is 0.
+ * Wave - user data sent from m0 via S_SENDMSG
+ * Error - Error type (context_id1[7:4]), Error Details (rest of bits)
+ *
+ * The other context_id bits show coordinates (SE/SH/CU/SIMD/WAVE) for wave
+ * S_SENDMSG and Errors.  These are 0 for Auto.
+ */
+
 enum SQ_INTERRUPT_WORD_ENCODING {
 	SQ_INTERRUPT_WORD_ENCODING_AUTO = 0x0,
 	SQ_INTERRUPT_WORD_ENCODING_INST,
@@ -84,12 +114,29 @@ enum SQ_INTERRUPT_ERROR_TYPE {
 #define SQ_INTERRUPT_WORD_WAVE_CTXID__SE_ID_MASK 0x03000000
 #define SQ_INTERRUPT_WORD_WAVE_CTXID__ENCODING_MASK 0x0c000000
 
+/* GFX9 SQ interrupt 24-bit data from context_id<0,1> */
 #define KFD_CONTEXT_ID_GET_SQ_INT_DATA(ctx0, ctx1)                             \
 	((ctx0 & 0xfff) | ((ctx0 >> 16) & 0xf000) | ((ctx1 << 16) & 0xff0000))
 
 #define KFD_SQ_INT_DATA__ERR_TYPE_MASK 0xF00000
 #define KFD_SQ_INT_DATA__ERR_TYPE__SHIFT 20
 
+/*
+ * The debugger will send user data(m0) with PRIV=1 to indicate it requires
+ * notification from the KFD with the following queue id (DOORBELL_ID) and
+ * trap code (TRAP_CODE).
+ */
+#define KFD_SQ_INT_DATA_DEBUG_DOORBELL_MASK	0x0003ff
+#define KFD_SQ_INT_DATA_DEBUG_TRAP_CODE_SHIFT	10
+#define KFD_SQ_INT_DATA_DEBUG_TRAP_CODE_MASK	0x07fc00
+#define KFD_DEBUG_DOORBELL_ID(sq_int_data)	((sq_int_data) &	\
+				KFD_SQ_INT_DATA_DEBUG_DOORBELL_MASK)
+#define KFD_DEBUG_TRAP_CODE(sq_int_data)	(((sq_int_data) &	\
+				KFD_SQ_INT_DATA_DEBUG_TRAP_CODE_MASK)	\
+				>> KFD_SQ_INT_DATA_DEBUG_TRAP_CODE_SHIFT)
+#define KFD_DEBUG_CP_BAD_OP_ECODE(ctxid0)	(((ctxid0) & 0x3ffffff) \
+				>> KFD_SQ_INT_DATA_DEBUG_TRAP_CODE_SHIFT)
+
 static void event_interrupt_poison_consumption_v9(struct kfd_dev *dev,
 				uint16_t pasid, uint16_t client_id)
 {
@@ -168,14 +215,16 @@ static bool event_interrupt_isr_v9(struct kfd_dev *dev,
 	uint16_t source_id, client_id, pasid, vmid;
 	const uint32_t *data = ih_ring_entry;
 
+	source_id = SOC15_SOURCE_ID_FROM_IH_ENTRY(ih_ring_entry);
+	client_id = SOC15_CLIENT_ID_FROM_IH_ENTRY(ih_ring_entry);
+
 	/* Only handle interrupts from KFD VMIDs */
 	vmid = SOC15_VMID_FROM_IH_ENTRY(ih_ring_entry);
-	if (vmid < dev->vm_info.first_vmid_kfd ||
-	    vmid > dev->vm_info.last_vmid_kfd)
+	if (!KFD_IRQ_IS_FENCE(client_id, source_id) &&
+	   (vmid < dev->vm_info.first_vmid_kfd ||
+	    vmid > dev->vm_info.last_vmid_kfd))
 		return false;
 
-	source_id = SOC15_SOURCE_ID_FROM_IH_ENTRY(ih_ring_entry);
-	client_id = SOC15_CLIENT_ID_FROM_IH_ENTRY(ih_ring_entry);
 	pasid = SOC15_PASID_FROM_IH_ENTRY(ih_ring_entry);
 
 	/* Only handle clients we care about */
@@ -194,7 +243,8 @@ static bool event_interrupt_isr_v9(struct kfd_dev *dev,
 	    client_id != SOC15_IH_CLIENTID_SE0SH &&
 	    client_id != SOC15_IH_CLIENTID_SE1SH &&
 	    client_id != SOC15_IH_CLIENTID_SE2SH &&
-	    client_id != SOC15_IH_CLIENTID_SE3SH)
+	    client_id != SOC15_IH_CLIENTID_SE3SH &&
+	    !KFD_IRQ_IS_FENCE(client_id, source_id))
 		return false;
 
 	/* This is a known issue for gfx9. Under non HWS, pasid is not set
@@ -247,6 +297,7 @@ static bool event_interrupt_isr_v9(struct kfd_dev *dev,
 		source_id == SOC15_INTSRC_SDMA_ECC ||
 		source_id == SOC15_INTSRC_SQ_INTERRUPT_MSG ||
 		source_id == SOC15_INTSRC_CP_BAD_OPCODE ||
+		KFD_IRQ_IS_FENCE(client_id, source_id) ||
 		((client_id == SOC15_IH_CLIENTID_VMC ||
 		client_id == SOC15_IH_CLIENTID_VMC1 ||
 		client_id == SOC15_IH_CLIENTID_UTCL2) &&
@@ -302,6 +353,13 @@ static void event_interrupt_wq_v9(struct kfd_dev *dev,
 					REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_WAVE_CTXID, SIMD_ID),
 					REG_GET_FIELD(context_id0, SQ_INTERRUPT_WORD_WAVE_CTXID, CU_ID),
 					sq_int_data);
+				if (context_id0 & SQ_INTERRUPT_WORD_WAVE_CTXID__PRIV_MASK) {
+					if (kfd_set_dbg_ev_from_interrupt(dev, pasid,
+							KFD_DEBUG_DOORBELL_ID(sq_int_data),
+							KFD_DEBUG_TRAP_CODE(sq_int_data),
+							NULL, 0))
+						return;
+				}
 				break;
 			case SQ_INTERRUPT_WORD_ENCODING_ERROR:
 				sq_intr_err = REG_GET_FIELD(sq_int_data, KFD_SQ_INT_DATA, ERR_TYPE);
@@ -324,8 +382,12 @@ static void event_interrupt_wq_v9(struct kfd_dev *dev,
 				break;
 			}
 			kfd_signal_event_interrupt(pasid, context_id0 & 0xffffff, 24);
-		} else if (source_id == SOC15_INTSRC_CP_BAD_OPCODE)
-			kfd_signal_hw_exception_event(pasid);
+		} else if (source_id == SOC15_INTSRC_CP_BAD_OPCODE) {
+			kfd_set_dbg_ev_from_interrupt(dev, pasid,
+				KFD_DEBUG_DOORBELL_ID(context_id0),
+				KFD_EC_MASK(KFD_DEBUG_CP_BAD_OP_ECODE(context_id0)),
+				NULL, 0);
+		}
 	} else if (client_id == SOC15_IH_CLIENTID_SDMA0 ||
 		   client_id == SOC15_IH_CLIENTID_SDMA1 ||
 		   client_id == SOC15_IH_CLIENTID_SDMA2 ||
@@ -345,6 +407,7 @@ static void event_interrupt_wq_v9(struct kfd_dev *dev,
 		   client_id == SOC15_IH_CLIENTID_UTCL2) {
 		struct kfd_vm_fault_info info = {0};
 		uint16_t ring_id = SOC15_RING_ID_FROM_IH_ENTRY(ih_ring_entry);
+		struct kfd_hsa_memory_exception_data exception_data;
 
 		if (client_id == SOC15_IH_CLIENTID_UTCL2 &&
 		    amdgpu_amdkfd_ras_query_utcl2_poison_status(dev->adev)) {
@@ -360,9 +423,23 @@ static void event_interrupt_wq_v9(struct kfd_dev *dev,
 		info.prot_read  = ring_id & 0x10;
 		info.prot_write = ring_id & 0x20;
 
+		memset(&exception_data, 0, sizeof(exception_data));
+		exception_data.gpu_id = dev->id;
+		exception_data.va = (info.page_addr) << PAGE_SHIFT;
+		exception_data.failure.NotPresent = info.prot_valid ? 1 : 0;
+		exception_data.failure.NoExecute = info.prot_exec ? 1 : 0;
+		exception_data.failure.ReadOnly = info.prot_write ? 1 : 0;
+		exception_data.failure.imprecise = 0;
+
+		kfd_set_dbg_ev_from_interrupt(dev,
+						pasid,
+						-1,
+						KFD_EC_MASK(EC_DEVICE_MEMORY_VIOLATION),
+						&exception_data,
+						sizeof(exception_data));
 		kfd_smi_event_update_vmfault(dev, pasid);
-		kfd_dqm_evict_pasid(dev->dqm, pasid);
-		kfd_signal_vm_fault_event(dev, pasid, &info, NULL);
+	} else if (KFD_IRQ_IS_FENCE(client_id, source_id)) {
+		kfd_process_close_interrupt_drain(pasid);
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 82b28588ab72..e50b472460ad 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -926,6 +926,10 @@ struct kfd_process {
 	uint64_t exception_enable_mask;
 	uint64_t exception_status;
 
+	/* Used to drain stale interrupts */
+	wait_queue_head_t wait_irq_drain;
+	bool irq_drain_is_open;
+
 	/* shared virtual memory registered by this process */
 	struct svm_range_list svms;
 
@@ -1088,12 +1092,19 @@ int kfd_numa_node_to_apic_id(int numa_node_id);
 void kfd_double_confirm_iommu_support(struct kfd_dev *gpu);
 
 /* Interrupts */
+#define	KFD_IRQ_FENCE_CLIENTID	0xff
+#define	KFD_IRQ_FENCE_SOURCEID	0xff
+#define	KFD_IRQ_IS_FENCE(client, source)				\
+				((client) == KFD_IRQ_FENCE_CLIENTID &&	\
+				(source) == KFD_IRQ_FENCE_SOURCEID)
 int kfd_interrupt_init(struct kfd_dev *dev);
 void kfd_interrupt_exit(struct kfd_dev *dev);
 bool enqueue_ih_ring_entry(struct kfd_dev *kfd,	const void *ih_ring_entry);
 bool interrupt_is_wanted(struct kfd_dev *dev,
 				const uint32_t *ih_ring_entry,
 				uint32_t *patched_ihre, bool *flag);
+void kfd_process_drain_interrupts(struct kfd_process_device *pdd);
+void kfd_process_close_interrupt_drain(unsigned int pasid);
 
 /* amdkfd Apertures */
 int kfd_init_apertures(struct kfd_process *process);
@@ -1365,6 +1376,7 @@ uint64_t kfd_get_number_elems(struct kfd_dev *kfd);
 /* Events */
 extern const struct kfd_event_interrupt_class event_interrupt_class_cik;
 extern const struct kfd_event_interrupt_class event_interrupt_class_v9;
+extern const struct kfd_event_interrupt_class event_interrupt_class_v10;
 extern const struct kfd_event_interrupt_class event_interrupt_class_v11;
 
 extern const struct kfd_device_global_init_class device_global_init_class_cik;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index c7d0ecbf2f57..6e347c0e4f44 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -856,6 +856,8 @@ struct kfd_process *kfd_create_process(struct task_struct *thread)
 		kfd_procfs_add_sysfs_stats(process);
 		kfd_procfs_add_sysfs_files(process);
 		kfd_procfs_add_sysfs_counters(process);
+
+		init_waitqueue_head(&process->wait_irq_drain);
 	}
 out:
 	if (!IS_ERR(process))
@@ -2068,6 +2070,47 @@ void kfd_flush_tlb(struct kfd_process_device *pdd, enum TLB_FLUSH_TYPE type)
 	}
 }
 
+/* assumes caller holds process lock. */
+void kfd_process_drain_interrupts(struct kfd_process_device *pdd)
+{
+	uint32_t irq_drain_fence[8];
+
+	if (!KFD_IS_SOC15(pdd->dev))
+		return;
+
+	pdd->process->irq_drain_is_open = true;
+
+	memset(irq_drain_fence, 0, sizeof(irq_drain_fence));
+	irq_drain_fence[0] = (KFD_IRQ_FENCE_SOURCEID << 8) |
+							KFD_IRQ_FENCE_CLIENTID;
+	irq_drain_fence[3] = pdd->process->pasid;
+
+	/* ensure stale irqs scheduled KFD interrupts and send drain fence. */
+	if (amdgpu_amdkfd_send_close_event_drain_irq(pdd->dev->adev,
+							irq_drain_fence)) {
+		pdd->process->irq_drain_is_open = false;
+		return;
+	}
+
+	if (wait_event_interruptible(pdd->process->wait_irq_drain,
+				!READ_ONCE(pdd->process->irq_drain_is_open)))
+		pdd->process->irq_drain_is_open = false;
+}
+
+void kfd_process_close_interrupt_drain(unsigned int pasid)
+{
+	struct kfd_process *p;
+
+	p = kfd_lookup_process_by_pasid(pasid);
+
+	if (!p)
+		return;
+
+	WRITE_ONCE(p->irq_drain_is_open, false);
+	wake_up_all(&p->wait_irq_drain);
+	kfd_unref_process(p);
+}
+
 struct send_exception_work_handler_workarea {
 	struct work_struct work;
 	struct kfd_process *p;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index 6e3e7f54381b..77a6a03c949a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -330,6 +330,7 @@ int pqm_create_queue(struct process_queue_manager *pqm,
 		kq->queue->properties.queue_id = *qid;
 		pqn->kq = kq;
 		pqn->q = NULL;
+		kfd_process_drain_interrupts(pdd);
 		retval = dev->dqm->ops.create_kernel_queue(dev->dqm,
 							kq, &pdd->qpd);
 		break;
-- 
2.25.1

