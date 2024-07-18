Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84086C3DA63
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jul 2024 17:57:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CB1310EA8F;
	Thu, 18 Jul 2024 17:57:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="30dH+syw";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2046.outbound.protection.outlook.com [40.107.243.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B69C410EA88
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jul 2024 17:57:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BlBTXwxhEZXWwMfnPPGpE5Pann1Dur0B4VMqNRu25rwCAxZq7FHxZ6+HTcMzNviXrmOoZ0Fv6ErWpNXmH+jZfMWE9zytkeNUhj3tqzsGttuv/W/d4QHUhNz2skHg/h+mrTS/Fsg+lJtxeUVtEo0yoCqEvG0LWy38GweLsI5r1MgGVGo7EzNq1PHaB5ZRAFPYL5iqwm2sBpTqCTY1AE72ZPpTmPYjWTesvg1JnYw2STvruyrDPrFwdAVlzqVNGI5hgzHKnPg3p9d71Vh9NZ6XkfDvlqZagDdSbOOEsDCAbI4pE1PjV2u43CpoBIcO3gMqOfnH5ipoNzlJ0rV2LtxqNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vDzrUrfLdVETuLTajnjEPh5HKAj95ts8dF4z1ZGPCqk=;
 b=EwUeIjb9UIE0GHeMbsMhOoDsbVVHWns2xeyCs2HPSyAVPXF/0S89MaZi6Ws8V+dRjpPBFhrZnhoSNmvkYZZnDNzjsE9f0k3sPqd/DGscnNkxGfE9puHW8mmdA3ge3IrOxlC2h2ODv0XwqPKgWt+FX4IP2BllYuiejPdBsD4Sz/l7n7hOYXkwvWFe95y6mu0ZFl7eAiTKNa8H+uO4jxWtLZexVqSr9B8Nqb9Tkfr7lzBJ/mTLv24JvNuJ+cPp4/3Vxa/5VZ3ZiIOqVlWG5Zm75PtZUOS/zgKCHkQofMjFLifye1uAx6jRgQ0eW2fCkqrWY/gKdgpsgCzkaHGDVEqcpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vDzrUrfLdVETuLTajnjEPh5HKAj95ts8dF4z1ZGPCqk=;
 b=30dH+sywEOmZ6AssOiLbP8CjmeEXkfo3JQ6jIVw8LL2ZR5KwxMOySXY/veTPl9V7Gt6s+qdgW6ndl98hp2+MhxQ5T/Vd5Oj1869NEuzenGEWg3YK06CLs1+uJcblTBxx+ZmmKzgLAQoUh2b8RBKtZuf/ERpUZOaAZvUqOX58AIY=
Received: from SA9P223CA0013.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::18)
 by DM4PR12MB5724.namprd12.prod.outlook.com (2603:10b6:8:5f::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7784.17; Thu, 18 Jul 2024 17:57:06 +0000
Received: from SN1PEPF000397B1.namprd05.prod.outlook.com
 (2603:10b6:806:26:cafe::2d) by SA9P223CA0013.outlook.office365.com
 (2603:10b6:806:26::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29 via Frontend
 Transport; Thu, 18 Jul 2024 17:57:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397B1.mail.protection.outlook.com (10.167.248.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Thu, 18 Jul 2024 17:57:05 +0000
Received: from jonathan-KFD.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 18 Jul
 2024 12:57:04 -0500
From: Jonathan Kim <Jonathan.Kim@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Jonathan Kim <Jonathan.Kim@amd.com>, Jonathan Kim <jonathan.kim@amd.com>
Subject: [PATCH 2/2] drm/amdkfd: support the debugger during per-queue reset
Date: Thu, 18 Jul 2024 13:56:45 -0400
Message-ID: <20240718175645.1002418-2-Jonathan.Kim@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240718175645.1002418-1-Jonathan.Kim@amd.com>
References: <20240718175645.1002418-1-Jonathan.Kim@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B1:EE_|DM4PR12MB5724:EE_
X-MS-Office365-Filtering-Correlation-Id: 58d312b3-157b-48ff-8a54-08dca753093b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PKz+VJx2VgLWYMtt/eYSPENW3WIjlr9mpVfp4l7GowSvtGVdjMbZ/VZulukc?=
 =?us-ascii?Q?5Pwgraz+Ssi6Pm2vqVNv49c5QnEsQfstbrW1zDFJhi+uEvTAblWLop9g5OSF?=
 =?us-ascii?Q?XmjcCP0uH3HOl4Xiis7zAHLsw2SaFw4c3+pWQ8vaYwopETosd5NY3+eHvg29?=
 =?us-ascii?Q?Sbi0T4LTZ4LwUnL0U6Ao5JPAumM6AkkW8qRwXYdTncnVrBnzevLE2qW++R8D?=
 =?us-ascii?Q?W+skc1hM2SVDP6EItjXAvTb4XnYOKZ23t8xanhwPxQgwIrVTBJ+M+ZUz09BJ?=
 =?us-ascii?Q?N6qqdkSKp2rcJJatDhBUZwjwXnbC2Awb080t1UL7UxSseqGmEPoULhv23BET?=
 =?us-ascii?Q?zTN8Fg0ClxplDaKwmooXy2U9FrbUaX7sqmrzlAsDn36iLTa0XJm0mLK27T6G?=
 =?us-ascii?Q?XnuT2TDLg+7s1LfFPGSTlUVtavaesVXH12FxG/w1iM2RYgkTsefSigp/oMKu?=
 =?us-ascii?Q?/EKTGrD26d1UQi/uznUmx2q9MBlGL6nw9rlHPKkr3sscHWtCpQZi1NI4+DRX?=
 =?us-ascii?Q?BVOdyR8pUKQpQz25u40G2zJROoiCZyvGvojPCQD6rOpwJYofkdTNYnEfYgfq?=
 =?us-ascii?Q?6M2cDc9369qItURtkDCXJKHJo7rU5JBrANrk4+OgY955F8fNdsOG3+Or3FRn?=
 =?us-ascii?Q?mHqp6l6J+FBExLS1+buivxvhRfSL8lQGJvsqbAPfvKViIpa6Jv/9rf1XPny6?=
 =?us-ascii?Q?JlCfcLgvhtTgIdr3ropOocWEs23v0+5r3MnjOgDvjr/IIKxqjgzNoqFwNL8f?=
 =?us-ascii?Q?30pI4BQ0g+BMYa+npB8tHtyRvtt/UsZhL572PTP1SHQAkpST1jp+GpE1FwP+?=
 =?us-ascii?Q?y+torNi6pAuCa7W+g9sdxDMSM5hQOKLi1/KorVxvlo+3/q4Io1S54HnacF7R?=
 =?us-ascii?Q?v+8Q06oJwU07qWebGdcASwHwG8nIZ+ZvsJttfn0VY5KWSmPFVQ6Z4la54+MJ?=
 =?us-ascii?Q?eaQpheH90U0aHy4Ib+wl7n7l2o8N6rDyvcEKUvCBsKae3QxDuqon+KvKy8NZ?=
 =?us-ascii?Q?APHT0p8zjgt6sjT0Tb15vqL5YzzqHAGTVcndD7MOG00vWi8uCDugicDbjYbD?=
 =?us-ascii?Q?+Ym7KwrLzH79GYu3a5lKfb+ltr+l5RHJgFIy5idNzOYop03z5hYomxhhG/Mp?=
 =?us-ascii?Q?Y98lBVPTIvf0NcPWdxmC8q0ZJZNh6rGv8I5wDc5It/jegw0i2LCy8R49yH0T?=
 =?us-ascii?Q?5DCw6EWYy3MQCZZi0oghwKPKWTYgYk6ZN1Rd19x9NfzMBL3sOsgIPkyE4Fak?=
 =?us-ascii?Q?Y/u9yjgVVa63Mn6euyrkAn86p4HjN7ljuFJ3Ix9209xr+hB7hfxOoTjjCaov?=
 =?us-ascii?Q?NoeqyWMuPTx/MyvpIUSm6OjEIiI+u0VH8g4z1sIMmMA/Q7Tl+PT059q3N4DL?=
 =?us-ascii?Q?ag6ayAA0DIRB9wwzDHyH22QmWtq2NUivqkpoaGbjj7Mq5Ed58+45BiALAu3Q?=
 =?us-ascii?Q?9fDgQcVjJtvl0/o2ewrLyyWYQuFSMQFF?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2024 17:57:05.7538 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58d312b3-157b-48ff-8a54-08dca753093b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5724
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

Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>
---
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 30 +++++++++++++++----
 include/uapi/linux/kfd_ioctl.h                |  4 +++
 2 files changed, 29 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 037b75a64e66..8c41806df39e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -163,6 +163,10 @@ static void kfd_hws_hang(struct device_queue_manager *dqm)
 		list_for_each_entry(q, &qpd->queues_list, list) {
 			q->properties.is_reset = true;
 			q->process->has_reset_queue = true;
+
+			kfd_dbg_ev_raise(KFD_EC_MASK(EC_QUEUE_RESET),
+					 q->process, q->device, q->doorbell_id,
+					 false, NULL, 0);
 		}
 	}
 
@@ -987,7 +991,7 @@ static int suspend_single_queue(struct device_queue_manager *dqm,
 {
 	bool is_new;
 
-	if (q->properties.is_suspended)
+	if (q->properties.is_suspended || q->properties.is_reset)
 		return 0;
 
 	pr_debug("Suspending PASID %u queue [%i]\n",
@@ -1008,6 +1012,9 @@ static int suspend_single_queue(struct device_queue_manager *dqm,
 		if (dqm->dev->kfd->shared_resources.enable_mes) {
 			int r = remove_queue_mes(dqm, q, &pdd->qpd);
 
+			if (q->properties.is_reset)
+				return 0;
+
 			if (r)
 				return r;
 		}
@@ -1971,6 +1978,9 @@ static void set_queue_as_reset(struct device_queue_manager *dqm, struct queue *q
 		q->properties.is_active = false;
 		decrement_queue_count(dqm, qpd, q);
 	}
+
+	kfd_dbg_ev_raise(KFD_EC_MASK(EC_QUEUE_RESET), q->process, q->device,
+			 q->doorbell_id, false, NULL, 0);
 }
 
 static int detect_queue_hang(struct device_queue_manager *dqm)
@@ -3036,7 +3046,8 @@ int resume_queues(struct kfd_process *p,
 						queue_ids[q_idx] &=
 							~KFD_DBG_QUEUE_INVALID_MASK;
 					} else {
-						queue_ids[q_idx] |=
+						queue_ids[q_idx] |= q->properties.is_reset ?
+							KFD_DBG_QUEUE_RESET_MASK :
 							KFD_DBG_QUEUE_ERROR_MASK;
 						break;
 					}
@@ -3071,7 +3082,7 @@ int resume_queues(struct kfd_process *p,
 							queue_ids);
 
 					/* mask queue as error on resume fail */
-					if (q_idx != QUEUE_NOT_FOUND)
+					if (q_idx != QUEUE_NOT_FOUND && !q->properties.is_reset)
 						queue_ids[q_idx] |=
 							KFD_DBG_QUEUE_ERROR_MASK;
 				}
@@ -3118,6 +3129,7 @@ int suspend_queues(struct kfd_process *p,
 		struct qcm_process_device *qpd = &pdd->qpd;
 		struct queue *q;
 		int r, per_device_suspended = 0;
+		bool has_queue_reset_fail = false;
 
 		mutex_lock(&p->event_mutex);
 		dqm_lock(dqm);
@@ -3134,6 +3146,9 @@ int suspend_queues(struct kfd_process *p,
 
 				if (!err) {
 					queue_ids[q_idx] &= ~KFD_DBG_QUEUE_INVALID_MASK;
+					if (q->properties.is_reset)
+						queue_ids[q_idx] |= KFD_DBG_QUEUE_RESET_MASK;
+
 					if (exception_clear_mask && is_mes)
 						q->properties.exception_status &=
 							~exception_clear_mask;
@@ -3175,13 +3190,18 @@ int suspend_queues(struct kfd_process *p,
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

