Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3F19C3DA49
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Jul 2024 15:31:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 954A010E9D2;
	Fri, 26 Jul 2024 15:31:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AVlIwzUW";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2063.outbound.protection.outlook.com [40.107.220.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBAA810E9D1
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Jul 2024 15:31:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nLKGFh4pMkkS+XW2hpeDAQunNmaaEnxsyqyO08a5Dmy5YMVwDrtjYizJaB6W8WynyYPhTCx7MJYqUW3zpZLN2zV+bYatqhpcD/iyN+Brm54uJMjoncB/unKbacvx1f+4R0KabjOCOevmv+b5EcYYWqq1kPixw0KvVdqo84jJ67X3CGyCGxFxVExJrDHu8LPnJt+1gR8Hsnvzz3mN+osVc+sFvs7pL2JpFBZw5+n7efIaUum1Z5+4Av/a656c9iU5Q4c6pBcIxgU357wT/pc3opEH66Felqau0CIB3I14ExmKKaaR38OU3l18Xlnx16TosTi4/hUFS5AoEzNxA8v9XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xEdszdedBPyX9qNdbyXqBcSMnKqQVSwOtqghxKNigKI=;
 b=hvcf/uzAdUj3gkCJ9Q95u0iDCmxMyg3xxODamuJW07SH2dyEwsddNlI/zIEGOVYo9RAi9i2LHZCw0h46aphruwSbuSREdUII94i30Wf5pES3Oi8eHvsHyQKnjRv8bQZODAa0AmPbH6kj5nSYePCU6/602aekR0LTNH2fbC85KfxFpfCI7ydaBsWusf7rHy+1N0TVLE3SIOynFgw8GwoP6PchGSb7Eap090b/HQZFN/mv/dXXE8al0ybew4XQXWM9prjrGkVYxRaaaEoUQ0+5yC3I7HYceQxQK7sOADhzwNau+pT18Fy7iErYcBcqfDn1ruNblCUYaIg+9Ktn60P4aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xEdszdedBPyX9qNdbyXqBcSMnKqQVSwOtqghxKNigKI=;
 b=AVlIwzUWjYqhH9OTBCNiX9GF7Nw1LU5N0A3xcdxva1m5+gBVlJa+cdozdP2J65x2L5m68nyztvWK8Z9mgbNExXpK+QlWxNjMiqxXezPY5D/E2x+r7SwJMsHOpIoNdUKh8x50l9UaroLe0BmJlTKVTrG4n42oFvLSW8yxok5zeFs=
Received: from BLAPR05CA0046.namprd05.prod.outlook.com (2603:10b6:208:335::26)
 by PH8PR12MB7184.namprd12.prod.outlook.com (2603:10b6:510:227::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.29; Fri, 26 Jul
 2024 15:31:05 +0000
Received: from MN1PEPF0000F0DE.namprd04.prod.outlook.com
 (2603:10b6:208:335:cafe::2c) by BLAPR05CA0046.outlook.office365.com
 (2603:10b6:208:335::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.28 via Frontend
 Transport; Fri, 26 Jul 2024 15:31:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0DE.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Fri, 26 Jul 2024 15:31:04 +0000
Received: from jonathan-KFD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 26 Jul
 2024 10:31:03 -0500
From: Jonathan Kim <Jonathan.Kim@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <Alexander.Deucher@amd.com>, Jonathan Kim
 <Jonathan.Kim@amd.com>, Jonathan Kim <jonathan.kim@amd.com>
Subject: [PATCH 2/2] drm/amdkfd: support the debugger during per-queue reset
Date: Fri, 26 Jul 2024 11:30:49 -0400
Message-ID: <20240726153049.1296575-2-Jonathan.Kim@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240726153049.1296575-1-Jonathan.Kim@amd.com>
References: <20240726153049.1296575-1-Jonathan.Kim@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DE:EE_|PH8PR12MB7184:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ccd7c91-5914-44e5-7118-08dcad87f65a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yzSxW+BmDEehAK1F6IkAPTo7b+oSa8nHdoZ6Da5K/iT5NbYuNBjpdg4Stn/C?=
 =?us-ascii?Q?9Mk07kHyRBW8qnpfYSiZc1WgrkmcnVOTwK+dnan3HVCkbTuYiGETcb+sxet9?=
 =?us-ascii?Q?v1PiiHO3EAFCgssJhgp92ruxdvOE6K1kLsnpFDnoW9dHS+kBYgBBc9veN/7/?=
 =?us-ascii?Q?Ij43lwNMN96fRPdq+CIrB4YqSnFTMTUVGG0ZpcONvKwrbJTw8lZCi18Ap9u3?=
 =?us-ascii?Q?3SQGO0tRDGD3caH8NRLF1mwW7I9lRgQ81toogcp+x4I9UNXL6TlHiSrHCQUQ?=
 =?us-ascii?Q?3UZcIvhXGQAsZKv9HOOkfsaD1gltbypUcrpbeKjeRLBFNxG3w7uFuLxDXjGK?=
 =?us-ascii?Q?sebNXOK3U6oiMHMtpFt9ATTkYMmQqWy2Ewv23iyKeC/M2VKYpDnAeD0cj2B6?=
 =?us-ascii?Q?CVKIE1had2EPvFsVcrQDS8Ax6crXOdy+obeqzYnkIl7pINuJjDgpFZ/EsNK9?=
 =?us-ascii?Q?lkqGZ/+rNlJt/G45ccsWNju0ulFZcBW7YfaghrKDLRkIEK/HIYwm+hcCIhCy?=
 =?us-ascii?Q?ou+NdsM567XLuYleH/zw0GOpXdAVlA8oDhT/9EW07Z/YqLKxOY3TRabow+bn?=
 =?us-ascii?Q?otybbSeA3X38TDc5Savpq0fGoMmlxb6aypInfe75/pk9JXh8jjWZSJMbF06d?=
 =?us-ascii?Q?BK/mcnxXjNFMmsL3LT2S1TthpWpjnffN6Kgkz08Tu9lPXPwqiGwdiURf43Dx?=
 =?us-ascii?Q?HCSmiQYI1FIaWMQCwd/3hR3mfgGS/EQ7pOvq5OqdM0I1uYlhoeUDO0P2wjEm?=
 =?us-ascii?Q?EfBiDgbZnnwvHslmB9THkMMoUEEgf1UrGkyNnmNZvkZ35etcVRPZYexNaJ8r?=
 =?us-ascii?Q?SdaLFZXjxgoX86celILOHnqTmr62eORh5gZ7lBCDimW2/l+9MP0uApnPLTgx?=
 =?us-ascii?Q?YiLwSLY6XQjwiga7BNJaefWH0fwR8GGI5E35GuMx8G8XS/PYQyBJg46Ub/dM?=
 =?us-ascii?Q?UvA9N8KJaavOG7+O7AaezNbE4ENlrlEbhICOEqN6lJAEAg4yRSQJ6CJvGDHF?=
 =?us-ascii?Q?2YU/LCMTXMiRfOqKE48Vv8K8xKc1jmqa/ava60pN5rRwq+QoLJCOiqmV6s/E?=
 =?us-ascii?Q?Y3ZUZMq1wBDKg8n7/MWcsbZ9V8rl2gZyTuMHESOb9gtMedmKwfhe61MBt5Fp?=
 =?us-ascii?Q?2hLS/J5R0f2ezzf9IVVsOriEoJh3ryCpyvrUGZjUgQcTdB6mEE9hPDyzO7cW?=
 =?us-ascii?Q?eYBMaQdtg94RK00IFw5IWR2FfKtNRgN1pDMRH1DARWs11VgdiooayTP/G3KI?=
 =?us-ascii?Q?FDhkGYA0RjZCZhymJiqVkZiCMzoTKfCO51zJSOio22wKRfIKoEsfxIOOsneM?=
 =?us-ascii?Q?a9I6swbqSgB2z+g5ij8erVSJt+lGsx5IW0WuzI5OUTQsCrsHkvE/LqhNJI9p?=
 =?us-ascii?Q?R61tGlNONUAzAOe6XrYLFY0wgcKkdCMGX8XAzQ6vURQcMohnnTIL0gQcznnb?=
 =?us-ascii?Q?EX2bJ93Ji4xOH0C2CJlFg0z9qkyK6XFe?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2024 15:31:04.3830 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ccd7c91-5914-44e5-7118-08dcad87f65a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7184
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

In order to allow ROCm GDB to handle reset queues, raise an
EC_QUEUE_RESET exception so that the debugger can subscribe and
query this exception.

Reset queues should still be considered suspendable with a status
flag of KFD_DBG_QUEUE_RESET_MASK.
However they should not be resumable since user space will no longer
be able to access reset queues.

v2: move per-queue reset flag to this patch
rebase based on patch 1 changes

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
---
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 31 ++++++++++++++++---
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  1 +
 include/uapi/linux/kfd_ioctl.h                |  4 +++
 3 files changed, 31 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index e335703eff84..cb7b5bbf5c40 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -164,6 +164,10 @@ static void kfd_hws_hang(struct device_queue_manager *dqm)
 			struct kfd_process_device *pdd = qpd_to_pdd(qpd);
 
 			pdd->has_reset_queue = true;
+			q->properties.is_reset = true;
+			kfd_dbg_ev_raise(KFD_EC_MASK(EC_QUEUE_RESET),
+					 q->process, q->device, q->doorbell_id,
+					 false, NULL, 0);
 		}
 	}
 
@@ -986,7 +990,7 @@ static int suspend_single_queue(struct device_queue_manager *dqm,
 {
 	bool is_new;
 
-	if (q->properties.is_suspended)
+	if (q->properties.is_suspended || q->properties.is_reset)
 		return 0;
 
 	pr_debug("Suspending PASID %u queue [%i]\n",
@@ -1007,6 +1011,9 @@ static int suspend_single_queue(struct device_queue_manager *dqm,
 		if (dqm->dev->kfd->shared_resources.enable_mes) {
 			int r = remove_queue_mes(dqm, q, &pdd->qpd);
 
+			if (q->properties.is_reset)
+				return 0;
+
 			if (r)
 				return r;
 		}
@@ -1967,10 +1974,14 @@ static void set_queue_as_reset(struct device_queue_manager *dqm, struct queue *q
 	       q->properties.queue_id, q->process->pasid);
 
 	pdd->has_reset_queue = true;
+	q->properties.is_reset = true;
 	if (q->properties.is_active) {
 		q->properties.is_active = false;
 		decrement_queue_count(dqm, qpd, q);
 	}
+
+	kfd_dbg_ev_raise(KFD_EC_MASK(EC_QUEUE_RESET), q->process, q->device,
+			 q->doorbell_id, false, NULL, 0);
 }
 
 static int detect_queue_hang(struct device_queue_manager *dqm)
@@ -3037,7 +3048,8 @@ int resume_queues(struct kfd_process *p,
 						queue_ids[q_idx] &=
 							~KFD_DBG_QUEUE_INVALID_MASK;
 					} else {
-						queue_ids[q_idx] |=
+						queue_ids[q_idx] |= q->properties.is_reset ?
+							KFD_DBG_QUEUE_RESET_MASK :
 							KFD_DBG_QUEUE_ERROR_MASK;
 						break;
 					}
@@ -3072,7 +3084,7 @@ int resume_queues(struct kfd_process *p,
 							queue_ids);
 
 					/* mask queue as error on resume fail */
-					if (q_idx != QUEUE_NOT_FOUND)
+					if (q_idx != QUEUE_NOT_FOUND && !q->properties.is_reset)
 						queue_ids[q_idx] |=
 							KFD_DBG_QUEUE_ERROR_MASK;
 				}
@@ -3119,6 +3131,7 @@ int suspend_queues(struct kfd_process *p,
 		struct qcm_process_device *qpd = &pdd->qpd;
 		struct queue *q;
 		int r, per_device_suspended = 0;
+		bool has_queue_reset_fail = false;
 
 		mutex_lock(&p->event_mutex);
 		dqm_lock(dqm);
@@ -3135,6 +3148,9 @@ int suspend_queues(struct kfd_process *p,
 
 				if (!err) {
 					queue_ids[q_idx] &= ~KFD_DBG_QUEUE_INVALID_MASK;
+					if (q->properties.is_reset)
+						queue_ids[q_idx] |= KFD_DBG_QUEUE_RESET_MASK;
+
 					if (exception_clear_mask && is_mes)
 						q->properties.exception_status &=
 							~exception_clear_mask;
@@ -3176,13 +3192,18 @@ int suspend_queues(struct kfd_process *p,
 				continue;
 
 			/* mask queue as error on suspend fail */
-			if (r)
+			if (r && !q->properties.is_reset) {
+				has_queue_reset_fail = true;
 				queue_ids[q_idx] |= KFD_DBG_QUEUE_ERROR_MASK;
-			else if (exception_clear_mask)
+			} else if (exception_clear_mask) {
 				q->properties.exception_status &=
 							~exception_clear_mask;
+			}
 		}
 
+		if (!has_queue_reset_fail)
+			total_suspended += per_device_suspended;
+
 		dqm_unlock(dqm);
 		mutex_unlock(&p->event_mutex);
 		amdgpu_device_flush_hdp(dqm->dev->adev, NULL);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 892a85408c09..192e3102c152 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -504,6 +504,7 @@ struct queue_properties {
 	bool is_being_destroyed;
 	bool is_active;
 	bool is_gws;
+	bool is_reset;
 	uint32_t pm4_target_xcc;
 	bool is_dbg_wa;
 	bool is_user_cu_masked;
diff --git a/include/uapi/linux/kfd_ioctl.h b/include/uapi/linux/kfd_ioctl.h
index 285a36601dc9..4713f9a6796e 100644
--- a/include/uapi/linux/kfd_ioctl.h
+++ b/include/uapi/linux/kfd_ioctl.h
@@ -875,6 +875,7 @@ enum kfd_dbg_trap_exception_code {
 	EC_QUEUE_PACKET_DISPATCH_WORK_GROUP_SIZE_INVALID = 21,
 	EC_QUEUE_PACKET_DISPATCH_REGISTER_INVALID = 22,
 	EC_QUEUE_PACKET_VENDOR_UNSUPPORTED = 23,
+	EC_QUEUE_RESET = 29,
 	EC_QUEUE_PREEMPTION_ERROR = 30,
 	EC_QUEUE_NEW = 31,
 	/* per device */
@@ -907,6 +908,7 @@ enum kfd_dbg_trap_exception_code {
 				 KFD_EC_MASK(EC_QUEUE_PACKET_DISPATCH_WORK_GROUP_SIZE_INVALID) |	\
 				 KFD_EC_MASK(EC_QUEUE_PACKET_DISPATCH_REGISTER_INVALID) |	\
 				 KFD_EC_MASK(EC_QUEUE_PACKET_VENDOR_UNSUPPORTED)	|	\
+				 KFD_EC_MASK(EC_QUEUE_RESET)	|	\
 				 KFD_EC_MASK(EC_QUEUE_PREEMPTION_ERROR)	|	\
 				 KFD_EC_MASK(EC_QUEUE_NEW))
 #define KFD_EC_MASK_DEVICE	(KFD_EC_MASK(EC_DEVICE_QUEUE_DELETE) |		\
@@ -997,8 +999,10 @@ struct kfd_queue_snapshot_entry {
 };
 
 /* Queue status return for suspend/resume */
+#define KFD_DBG_QUEUE_RESET_BIT		29
 #define KFD_DBG_QUEUE_ERROR_BIT		30
 #define KFD_DBG_QUEUE_INVALID_BIT	31
+#define KFD_DBG_QUEUE_RESET_MASK	(1 << KFD_DBG_QUEUE_RESET_BIT)
 #define KFD_DBG_QUEUE_ERROR_MASK	(1 << KFD_DBG_QUEUE_ERROR_BIT)
 #define KFD_DBG_QUEUE_INVALID_MASK	(1 << KFD_DBG_QUEUE_INVALID_BIT)
 
-- 
2.34.1

