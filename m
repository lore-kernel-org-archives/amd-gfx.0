Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56329ECAAA1
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Oct 2022 16:25:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E773410E2FA;
	Mon, 31 Oct 2022 16:25:08 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D3CB10E2F1
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Oct 2022 16:24:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XzuqIuGKqxzR8eStY7fRTj7zSw9OgPF0t6asfgZAyH9XsbkgsbMQ99IF1EO/HU0/yLhuB84d1CJdOJyJRyN9tWqWebNdqw5tLjzOg6jpZGywRjEa+/pTq4g5i8NuExAcwKbkirnp8RaIdHvQ2tVzzB5aGY/h1iWxzuV+/4Sm38NfUBeg4W9scfSvf/imtymCB/qAGVxwOO7eJhALVTnbglnDVZHdu8es+6gX2kpM0nEsw0HvmPAlLn0gXfpVwolXOKBr/HzSFgkK5XPRxvPFx1s9M7Ln+BR7AWg/5VvKSNYWyn0B0IwRMEPLMJyMq9rc7fDC42D5XPyuLRa354CJLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7EoXMj3YuxUgUwRGgwSs5FlMimJ2w7VhPTlzWHhRcaY=;
 b=VcVvFtuvN5cuSquwo0KlJJ8UhWJGbW4bAyQqAQFcY/cE2Y+mKrLtqJk5x+6Ng2OWUjutWNetkFIUvO5ZXevnZNUGfaWfRQXt4xKJu9Fw3rkCSCNA0wh/5ZGRYD7TTaYNBCjSQzyNnZxvDip05gjPJR2Lv2DjdsUV7W58rCwbGUOqRX1QFKX4n5/xw3MHCRm/tO9C/N+dyYvzE098/ZOi0QzGMOgAAwf5ur57KaJ6tg87KRXe1ri2DJl5FuyZMUs1ZRKMlKR5yWnDObsdIwt/VI7fn3mG7mZnVYhKZ/k0pEO8qdcyMFLzxmFiaMhVP0NKKMStPec9ipQLPGnmZd/yXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7EoXMj3YuxUgUwRGgwSs5FlMimJ2w7VhPTlzWHhRcaY=;
 b=ko/Uvv9hf+O4aK0LslSdAusuZjeblmKCevdaqlXJD+dXdfhVPy4w/8jga1ClEB1EqEi+1WL1NdtAw/c+PpXS+Q13cPBDDBxhTWKP1NL81K+0UM1iQJJgnadl+XOfnzOuwB5zKQAkpbV0Dk9K+gK1DqnvNbnkHtN2hLnerQZcS3I=
Received: from MW4PR03CA0214.namprd03.prod.outlook.com (2603:10b6:303:b9::9)
 by DS7PR12MB5791.namprd12.prod.outlook.com (2603:10b6:8:76::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15; Mon, 31 Oct
 2022 16:24:34 +0000
Received: from CO1NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b9:cafe::f) by MW4PR03CA0214.outlook.office365.com
 (2603:10b6:303:b9::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19 via Frontend
 Transport; Mon, 31 Oct 2022 16:24:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT004.mail.protection.outlook.com (10.13.175.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5769.14 via Frontend Transport; Mon, 31 Oct 2022 16:24:33 +0000
Received: from jonathan-KFD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 31 Oct
 2022 11:24:30 -0500
From: Jonathan Kim <jonathan.kim@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 26/29] drm/amdkfd: add debug query exception info operation
Date: Mon, 31 Oct 2022 12:23:56 -0400
Message-ID: <20221031162359.445805-26-jonathan.kim@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221031162359.445805-1-jonathan.kim@amd.com>
References: <20221031162359.445805-1-jonathan.kim@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT004:EE_|DS7PR12MB5791:EE_
X-MS-Office365-Filtering-Correlation-Id: f8afb3cf-37c4-422f-ebf3-08dabb5c6581
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hqae2wz0YiL7W1M2yUbnDXLx/ZoE2i5jSoyecsH7jjcfsqNHU+lzbC5e1W1jyGgNWBPBz3RzkZ5L5df53G5UTFDqha5tMb+1W+zlu1rjU62AEGP6ixjpQkfa/HvucTodr2omcxmH7pszBot62yQjbQpiIcMLh4zRe4NW02/AvDbM4ykrgPLph8DU8XOLDLDTeyQuouNPz+/Qmpg+fVoYDAeyoFwBfijxFOXMngmk9ghry0lxqkRaFX1o7WiWhlMUS4W3prT7cmXEQeexnJ/t1vlzxhCaiC/7EaI9q+E9hQfTSDkU9vXU+amrGZiA+DNr4nJHMRrr+jK3c4eFVJZ6Denr4zyrvNchrMIa/zkAm8v4+UZ1t3G5ywdyNoZIDUsx0N/9SMAHI1MClAmiHmxbzCqtsJOZ4a9jDyLKh1Gi15fp6/dAd3z2m6xHdt6Cw9kEr/mGt7L7j76MqAKH3clOtM7UWm1bRc38nb5fJ7j6FQG4I62ImoaiOrEJvtSBmSfJ4vMfl7VNibfi3DmRcO0DMIjadPWDhtaRX+Exi9292X6v7+zesx1uytVVrbMamPQ9FpONuEYvm8G7Zw2x+TIVWXOlB9KI6TehfrmENZRjJBrQ5i+7LsvwJbZ8aKq4lsMJnRijHBBAo86fPhXVJ9U31YAIbPWnh/04b+Hj+/KGUiMpk0zpOjBlZXJ+YzsV72vGqaqauNGNHzNrFvzlfw3XwDdkCFV4mneSGj+kgtYZ8k+hDAqOn0w6aCMKA3iMh23JHPlM77vQEa2fsiiPsKICeQwDJfNUfeCrDZ7kk4sEXP8=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(136003)(39860400002)(376002)(396003)(451199015)(36840700001)(40470700004)(46966006)(7696005)(2616005)(6666004)(26005)(36860700001)(186003)(47076005)(40460700003)(70586007)(83380400001)(2906002)(478600001)(44832011)(426003)(40480700001)(1076003)(8676002)(6916009)(16526019)(316002)(336012)(8936002)(82310400005)(70206006)(41300700001)(5660300002)(4326008)(86362001)(36756003)(82740400003)(356005)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2022 16:24:33.9182 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8afb3cf-37c4-422f-ebf3-08dabb5c6581
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5791
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
Cc: Felix.Kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Allow the debugger to query additional info based on an exception code.
For device exceptions, it's currently only memory violation information.
For process exceptions, it's currently only runtime information.
Queue exception only report the queue exception status.

The debugger has the option of clearing the target exception on query.

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c |   7 ++
 drivers/gpu/drm/amd/amdkfd/kfd_debug.c   | 120 +++++++++++++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_debug.h   |   6 ++
 3 files changed, 133 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index b918213a0087..2c8f107237ee 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -2953,6 +2953,13 @@ static int kfd_ioctl_set_debug_trap(struct file *filep, struct kfd_process *p, v
 				&args->query_debug_event.exception_mask);
 		break;
 	case KFD_IOC_DBG_TRAP_QUERY_EXCEPTION_INFO:
+		r = kfd_dbg_trap_query_exception_info(target,
+				args->query_exception_info.source_id,
+				args->query_exception_info.exception_code,
+				args->query_exception_info.clear_exception,
+				(void __user *)args->query_exception_info.info_ptr,
+				&args->query_exception_info.info_size);
+		break;
 	case KFD_IOC_DBG_TRAP_GET_QUEUE_SNAPSHOT:
 	case KFD_IOC_DBG_TRAP_GET_DEVICE_SNAPSHOT:
 		pr_warn("Debug op %i not supported yet\n", args->op);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
index 6985a53b83e9..a05fe32eac0e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
@@ -768,6 +768,126 @@ int kfd_dbg_trap_set_wave_launch_mode(struct kfd_process *target,
 	return r;
 }
 
+int kfd_dbg_trap_query_exception_info(struct kfd_process *target,
+		uint32_t source_id,
+		uint32_t exception_code,
+		bool clear_exception,
+		void __user *info,
+		uint32_t *info_size)
+{
+	bool found = false;
+	int r = 0;
+	uint32_t copy_size, actual_info_size = 0;
+	uint64_t *exception_status_ptr = NULL;
+
+	if (!target)
+		return -EINVAL;
+
+	if (!info || !info_size)
+		return -EINVAL;
+
+	mutex_lock(&target->event_mutex);
+
+	if (KFD_DBG_EC_TYPE_IS_QUEUE(exception_code)) {
+		/* Per queue exceptions */
+		struct queue *queue = NULL;
+		int i;
+		
+		for (i = 0; i < target->n_pdds; i++) {
+			struct kfd_process_device *pdd = target->pdds[i];
+			struct qcm_process_device *qpd = &pdd->qpd;
+
+			list_for_each_entry(queue, &qpd->queues_list, list) {
+				if (!found && queue->properties.queue_id == source_id) {
+					found = true;
+					break;
+				}
+			}
+			if (found)
+				break;
+		}
+
+		if (!found) {
+			r = -EINVAL;
+			goto out;
+		}
+
+		if (!(queue->properties.exception_status & KFD_EC_MASK(exception_code))) {
+			r = -ENODATA;
+			goto out;
+		}
+		exception_status_ptr = &queue->properties.exception_status;
+	} else if (KFD_DBG_EC_TYPE_IS_DEVICE(exception_code)) {
+		/* Per device exceptions */
+		struct kfd_process_device *pdd = NULL;
+		int i;
+
+		for (i = 0; i < target->n_pdds; i++) {
+			pdd = target->pdds[i];
+			if (pdd->dev->id == source_id) {
+				found = true;
+				break;
+			}
+		}
+
+		if (!found) {
+			r = -EINVAL;
+			goto out;
+		}
+
+		if (!(pdd->exception_status & KFD_EC_MASK(exception_code))) {
+			r = -ENODATA;
+			goto out;
+		}
+
+		if (exception_code == EC_DEVICE_MEMORY_VIOLATION) {
+			copy_size = min((size_t)(*info_size), pdd->vm_fault_exc_data_size);
+
+			if (copy_to_user(info, pdd->vm_fault_exc_data, copy_size)) {
+				r = -EFAULT;
+				goto out;
+			}
+			actual_info_size = pdd->vm_fault_exc_data_size;
+			if (clear_exception) {
+				kfree(pdd->vm_fault_exc_data);
+				pdd->vm_fault_exc_data = NULL;
+				pdd->vm_fault_exc_data_size = 0;
+			}
+		}
+		exception_status_ptr = &pdd->exception_status;
+	} else if (KFD_DBG_EC_TYPE_IS_PROCESS(exception_code)) {
+		/* Per process exceptions */
+		if (!(target->exception_status & KFD_EC_MASK(exception_code))) {
+			r = -ENODATA;
+			goto out;
+		}
+
+		if (exception_code == EC_PROCESS_RUNTIME) {
+			copy_size = min((size_t)(*info_size), sizeof(target->runtime_info));
+
+			if (copy_to_user(info, (void *)&target->runtime_info, copy_size)) {
+				r = -EFAULT;
+				goto out;
+			}
+
+			actual_info_size = sizeof(target->runtime_info);
+		}
+
+		exception_status_ptr = &target->exception_status;
+	} else {
+		pr_debug("Bad exception type [%i]\n", exception_code);
+		r = -EINVAL;
+		goto out;
+	}
+
+	*info_size = actual_info_size;
+	if (clear_exception)
+		*exception_status_ptr &= ~KFD_EC_MASK(exception_code);
+out:
+	mutex_unlock(&target->event_mutex);
+	return r;
+}
+
 void kfd_dbg_set_enabled_debug_exception_mask(struct kfd_process *target,
 					uint64_t exception_set_mask)
 {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.h b/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
index c64ffd3efc46..58a5f14d1258 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.h
@@ -63,6 +63,12 @@ int kfd_dbg_trap_set_dev_address_watch(struct kfd_process_device *pdd,
 					uint32_t *watch_id,
 					uint32_t watch_mode);
 int kfd_dbg_trap_set_flags(struct kfd_process *target, uint32_t *flags);
+int kfd_dbg_trap_query_exception_info(struct kfd_process *target,
+		uint32_t source_id,
+		uint32_t exception_code,
+		bool clear_exception,
+		void __user *info,
+		uint32_t *info_size);
 int kfd_dbg_send_exception_to_runtime(struct kfd_process *p,
 					unsigned int dev_id,
 					unsigned int queue_id,
-- 
2.25.1

