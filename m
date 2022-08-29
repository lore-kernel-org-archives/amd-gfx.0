Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BF2DECAAD5
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Aug 2022 14:31:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D858110F322;
	Mon, 29 Aug 2022 14:31:28 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2057.outbound.protection.outlook.com [40.107.244.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7EED010F2EE
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Aug 2022 14:31:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EaXvIpfh8aGIQzQ2NQmyM8Pj7oEnidi10d8MpCOZ2w8xxplFlaXQc0mj387MgB38RReJOFdPbortFrLx3mxuBM6MHvTZQb7G73NTO/VETnDscYsN7rmaxHtYMcO7hgtHXYloJHJrKMRu5WQxsIh/y/rdol7QK/rSTtnIWGvua8TIqdr4F1t7Qyu6pSV3H/Nyxy7NdwdynLyX5BTSuRna7mndPXz3i4uiDaaI9Zat6G9p1QmMp/rVYEleYRBJirY44cHSagkSgXrlTAGzwqFaIPCGCqopX4/lrohpdfP/sE8eI4pUUiggaceYkgg7B+u66RpCvnq2PZDqHLgmB9X9MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uDmIw0zlBafTYBZRqgyM4DaNvUJOyPhTT34yGSkSyN8=;
 b=IQCDvwx8oIRndsiQIJf+ZbrWGKQ1J9Eb1EBG4ZfnkIfs13Mx3xoAbxxvmXFJ3T2gSvhe7YRHApnlJ2F9sx8wnuUrN13jSm9OtdE/vyth/626Q6MYe/SEpSde7ROfkgGHYyrsZMHr8sV1Yms2LWMgDLlJ9QkslRxhFHRharMGPC/y7Gztb57nnDGWqKG/j8cLWQSqU7xFV/liLIQ+cASdGP6687hE9CQyjysdvNK8gNf/DNBzw8Cc0azuITF9sGtJ06cm9SnlIs9gZ8oL6vSdoA1lFwTJtDs6bVFd+AEoSftUXmXC5fdv0drCMZ0kNFSl6vHq3i8otgihus5XuBqJNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uDmIw0zlBafTYBZRqgyM4DaNvUJOyPhTT34yGSkSyN8=;
 b=YS1+Qkvzdpmm++rVgsX0gd7HKbO/EAZvfpieXEh/mdTU/bIjilbTp/Rdkge14OFZi2/mP5qOTlfEcmw49eNSf/oCYZ+fq9FQlHnHhgytGWWMvqEbPSnLFbbD8eI1XbyzMuVSD9GUFJuwObjuaIrUfXgDhSZIV5Dj7/jirtj/wbU=
Received: from MW4PR04CA0301.namprd04.prod.outlook.com (2603:10b6:303:82::6)
 by PH8PR12MB7374.namprd12.prod.outlook.com (2603:10b6:510:216::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14; Mon, 29 Aug
 2022 14:31:17 +0000
Received: from CO1NAM11FT100.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:82:cafe::3) by MW4PR04CA0301.outlook.office365.com
 (2603:10b6:303:82::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15 via Frontend
 Transport; Mon, 29 Aug 2022 14:31:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT100.mail.protection.outlook.com (10.13.175.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.15 via Frontend Transport; Mon, 29 Aug 2022 14:31:17 +0000
Received: from jonathan-KFD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 29 Aug
 2022 09:31:11 -0500
From: Jonathan Kim <jonathan.kim@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 26/29] drm/amdkfd: add debug query exception info operation
Date: Mon, 29 Aug 2022 10:30:23 -0400
Message-ID: <20220829143026.1509027-27-jonathan.kim@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: af60f11f-df20-488e-a3da-08da89cb226b
X-MS-TrafficTypeDiagnostic: PH8PR12MB7374:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FJe6jxNikjKSFHr2nirY4o8jdFAPr7zX/MHdfnzuB6kNwadcSjr4D+oRppgKT9Ob7TxVfHO2k+QzOPZ7wdrT4LrGGQJ5IU1btsbUcyjf8EERbhICWw05J8XgTVC3RqmJJnnCk9E9PaiH9L2bjAMhEl0EEYs32AbnVEeocBpepLC0opPdT/BRuU5XQJ2F2HWaOMGou+NZtDeX4CnW4w/avDWtoXfd1hS2TU0LbPV3VhgPv9GIAr2iwk7So3GolJiRwQ2nmngqv691ZpwMpiKEPlgsxhsXwE+FZW6ZuNhVmVhNNxgLONODOB7VTPCp46TNTzVAMoQVMtc8z37gX69vS/18aADZXrnvvLPOhwkPgXw7QGAuQNa4JKOkRIXx1Qzd5FEWeo2ZMCFRgUshEu//JW5iGbKs/8rY8sdJhiwUgD9yzU7vnA6FH9bwKieaF1EECUhb6hP11YVNnD+iz21I5oZzpeQ/WYWMBXjO7VsyFU6w2yKN/UUv/7NYzIAbzQOznnBTJQtIvi9KGHqQ/1lSSgdgP8PNYCeQV5XLmwGImH/55vv6T8JrZzBI7y6gmAg6OUKbIzec0rGgHAY4uC38/DLItq0Sdj3+2u85lLS48fEnNkr35d1u/6DP5oEM28vODDlEv+NScbqFQDR+uW5l8KIOlHnkzyOZZ+CJrqelniNIFYBe2H7ZPju75zJ78CLmvPEZw4jm9/lOqH21zVSNa3sbTGQUkE8//OwTVefZbeL0/ykVv3huChZPDO/hwAP4XYOOzgvRVFyKcMP9DFavkFpQUn4bub/vIdRIuP41QYc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(346002)(39860400002)(376002)(396003)(36840700001)(46966006)(40470700004)(1076003)(316002)(81166007)(54906003)(6916009)(86362001)(4326008)(70586007)(8676002)(40460700003)(70206006)(5660300002)(478600001)(36756003)(356005)(8936002)(41300700001)(44832011)(2616005)(6666004)(82740400003)(82310400005)(26005)(7696005)(2906002)(426003)(36860700001)(40480700001)(83380400001)(47076005)(16526019)(336012)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2022 14:31:17.3317 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af60f11f-df20-488e-a3da-08da89cb226b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT100.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7374
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
index 042cb0f6426b..1017bf076e1f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -2922,6 +2922,13 @@ static int kfd_ioctl_set_debug_trap(struct file *filep, struct kfd_process *p, v
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
index 3b15159421cc..8590f7b21aa7 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
@@ -742,6 +742,126 @@ int kfd_dbg_trap_set_wave_launch_mode(struct kfd_process *target,
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

