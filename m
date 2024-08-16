Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34E16C531DC
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Aug 2024 18:02:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D802410E81B;
	Fri, 16 Aug 2024 18:02:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aQ0np1b1";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2084.outbound.protection.outlook.com [40.107.243.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D24210E81C
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Aug 2024 18:02:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bzfhpMmHA6utxymE8CHqoExS2uDki72JXM8B1QWYCwqrUxVHbmzE1Hw+MNE8D2SfpiboAdFAZRqozX3Up/z8Mi8yalcU5NhBcCBXYM/X/wL+SJAI2kkbOYgVuCpruo2vEL7rCvCtFfE1p+JeqDeOmw4K2uSDqTPoSzXa0vdwYH/AJN3V9qjYdEQ9XAp0a8NaPtdPaTnGTUWOEmbbtsprqHZVHyBZvkQDYUoE6VqtQ9z4bQ7Lc6biktslF9PyaIIDeIS4DN4yoisyickeINoDDzlh0OSOOo3tiGYUzu4wytZ3Ysuz5Mp4K95zWfLOUy4OLtF/B6z0dFcJPrh7udYj7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aZmx1sw3S5dWyP0V0wFH+0uPNnRB8Dpo5SPzN7fqQ5k=;
 b=k6nNloV78U0kF/VTkl1soCipESrcH09cl4R+v7t5Ac1l8e2wTCXfQOTESP50Ie6vlJ6n95XfmjGPiWSwpfxny5zmSJYvRkzbAfU4y2OGhbF9uyBIi+uPq+m7r3klFmRi6ugFp1URTAUt/wOkHNOAkijB1Qo3qrILLT21qWf9VkJBYpQmXGsNtkXSSRjZIqC9iInvwp/NZSa5Y03ehCXg9fiI2//PYXfBBC0fCYtTZazn0bB9GMwUrMffmRy8wPnxqDuC3kp/r0TCQ5517fYC4dBSdLwouz1OGj6l82e37sxE9yZS3AyCQSx+ELKCswnzAqIOCdb0qjv6gytodkD9qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aZmx1sw3S5dWyP0V0wFH+0uPNnRB8Dpo5SPzN7fqQ5k=;
 b=aQ0np1b14RLAnu4m08RsieFfa7wn08fYGY0dzpV14FFt77LqKQOb0sPRF7W3CdO2k/gGKDI3Fokph4BXj93/h8WmxFSSGjTJOCNuoa2Et7FKujoGA8gRySAuEa/V/xwQgFakLT5odEqKEOv+YBUONTs6/+7ak/rZz427ZsaobvY=
Received: from PH7P222CA0019.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:33a::22)
 by IA0PR12MB7604.namprd12.prod.outlook.com (2603:10b6:208:438::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20; Fri, 16 Aug
 2024 18:02:07 +0000
Received: from CY4PEPF0000EDD1.namprd03.prod.outlook.com
 (2603:10b6:510:33a:cafe::d3) by PH7P222CA0019.outlook.office365.com
 (2603:10b6:510:33a::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20 via Frontend
 Transport; Fri, 16 Aug 2024 18:02:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD1.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Fri, 16 Aug 2024 18:02:06 +0000
Received: from mukjoshi-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 16 Aug
 2024 13:02:05 -0500
From: Mukul Joshi <mukul.joshi@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <alexander.deucher@amd.com>, Mukul Joshi
 <mukul.joshi@amd.com>, Harish Kasiviswanathan
 <Harish.Kasiviswanathan@amd.com>
Subject: [PATCHv3 3/3] drm/amdkfd: Update BadOpcode Interrupt handling with MES
Date: Fri, 16 Aug 2024 14:01:38 -0400
Message-ID: <20240816180138.1171558-3-mukul.joshi@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20240816180138.1171558-1-mukul.joshi@amd.com>
References: <20240816180138.1171558-1-mukul.joshi@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD1:EE_|IA0PR12MB7604:EE_
X-MS-Office365-Filtering-Correlation-Id: bee80215-da10-4a2b-c084-08dcbe1d8a78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Hek9SEmsOYV+pyL7rY7ODNg+dKtDTBLyWaLxyHYwXkl7HW+5A47yDUyPIMC3?=
 =?us-ascii?Q?ZUsBsLoD2yM8rebYfbZaxNi4L+zR+rez/Nlf0V2HAfpVQLhKBDkx+yF6pcYU?=
 =?us-ascii?Q?AndJzMkyn02jNT1YcAa6WEQuVYwQOqDdffmMr/LAnIAlmGsUTQ52ZSby3mxW?=
 =?us-ascii?Q?5waZDXzP+lcobB4O/djw64zXT68GoIseBYGwTUiEqTFxfOrMo4/zvEKuVJDo?=
 =?us-ascii?Q?TrURDErxgg4PRYeg5DRM6gMTZ14UDi+di/Cmhv784MjwLTf4Y3BZDZMxhSiL?=
 =?us-ascii?Q?TE2i7KXeYtMi+GUFdCKU0Py0SCzMGJin3I6noiaLJsOzzjeVspf+h7GpjCl9?=
 =?us-ascii?Q?iMLcEiiZdLR+5BbCf0M53BnYaNUAeVaZj1pI7E46S48dil8SxLQM5xD4Iurv?=
 =?us-ascii?Q?/FOKehYxm3008i6sDwNrGXoHG9x31q3fsmDepNfCqZudmkCTERIaU7s5613p?=
 =?us-ascii?Q?7kRxmYJzpKI7yUSpPLM+s90SDfvepdUzxYRqy7SVKpXnj47OVjPppc4PWuZ0?=
 =?us-ascii?Q?R671TsC86Viquqc4R9a3xgEyEP5lbaYQ5FDmrT/HKk4ZugzXcJA6NQOrshmp?=
 =?us-ascii?Q?I4v0pEHbJ1CjDYJ41K7xlZj6+u3MCFo908IP/CP1Z0U2wInNvsCeLwaN5zp2?=
 =?us-ascii?Q?wUq3qQbHTZHPENSIEdFyMtmtEZXPNkvdWRUP+sOKPYLkdNKc1ry3VpdSwyMa?=
 =?us-ascii?Q?EGx4QqBofzXphG2o0hA512qPVaDM6ENmwUV8XiIhIFnJpRJKAEPacuaL4AfR?=
 =?us-ascii?Q?U7dbzagXEfStAqpvW3uoaJrTOLiZnKIRZ+jEcneyFZI5bPIAsPmxrPNFp/JE?=
 =?us-ascii?Q?5pSIHgH7LgqyoKi9aOzgF1F1ZiBGrZ/Gd2NFz97DTJV2ssu1ipo/kpDkSw5i?=
 =?us-ascii?Q?lOnGRL0RJRtRC4PCZ8GuumT4sMbbjYu1hqQnc4n65dDrtqNanOVhi1I+q4BQ?=
 =?us-ascii?Q?dGkPslmDY5HoDfq3Ayq2jRwiitZZRGAGGWxY5em6VHo/66OgY/4+4h6+70aK?=
 =?us-ascii?Q?O4aFt1nvfIfGCJTfGVE+oIXpOLrBEMl0ThVwlJKbbfYbxfp4OmigBMG9XMcG?=
 =?us-ascii?Q?fHU/FV58YYailgt0PbcN3wWN4hqgKGM8J3oZY7QZ3sX9rPTylxUHRotNiV1I?=
 =?us-ascii?Q?5jYULHH1C6RsPxHjIwQDpgWWXHZbI16sJagQVHX5evaAdM0DXkQGZAb8orWa?=
 =?us-ascii?Q?QCWpRQs5ateHp5ioulATxKbQ55YlJ6bTfXU7Xt6z8d+3eEvm9Bcbi/mKmcqR?=
 =?us-ascii?Q?KZTUWGEDLl4sTfwASP91QZ87N8G+rqvzPCmHOtITLJwuhUq6PuWneFneTOuc?=
 =?us-ascii?Q?Rj5f0L4s5uoJV0iGNeoYp77DcokVVTW8e5iuqIr1ZQUPsBZJtKwx0OH4pSKI?=
 =?us-ascii?Q?GKoGyEky5Yon8C1w+qjI2eQh3xjbc3DzT9DseItiSpknffQO5zc+zTVlDIJD?=
 =?us-ascii?Q?hZ49VoPzoCKF3LaQgGY47jariU92SmGt?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 18:02:06.5016 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bee80215-da10-4a2b-c084-08dcbe1d8a78
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7604
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

Based on the recommendation of MEC FW, update BadOpcode interrupt
handling by unmapping all queues, removing the queue that got the
interrupt from scheduling and remapping rest of the queues back when
using MES scheduler. This is done to prevent the case where unmapping
of the bad queue can fail thereby causing a GPU reset.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Acked-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
---
v1->v2:
- No change.

v2->v3:
- No change.

 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 51 +++++++++++++++++++
 .../gpu/drm/amd/amdkfd/kfd_int_process_v11.c  |  9 ++--
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  1 +
 3 files changed, 58 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 0ca933d2099c..d7db33f378e2 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -2875,6 +2875,57 @@ void device_queue_manager_uninit(struct device_queue_manager *dqm)
 	kfree(dqm);
 }
 
+int kfd_dqm_suspend_bad_queue_mes(struct kfd_node *knode, u32 pasid, u32 doorbell_id)
+{
+	struct kfd_process_device *pdd;
+	struct kfd_process *p = kfd_lookup_process_by_pasid(pasid);
+	struct device_queue_manager *dqm = knode->dqm;
+	struct device *dev = dqm->dev->adev->dev;
+	struct qcm_process_device *qpd;
+	struct queue *q = NULL;
+	int ret = 0;
+
+	if (!p)
+		return -EINVAL;
+
+	dqm_lock(dqm);
+
+	pdd = kfd_get_process_device_data(dqm->dev, p);
+	if (pdd) {
+		qpd = &pdd->qpd;
+
+		list_for_each_entry(q, &qpd->queues_list, list) {
+			if (q->doorbell_id == doorbell_id && q->properties.is_active) {
+				ret = suspend_all_queues_mes(dqm);
+				if (ret) {
+					dev_err(dev, "Suspending all queues failed");
+					goto out;
+				}
+
+				q->properties.is_evicted = true;
+				q->properties.is_active = false;
+				decrement_queue_count(dqm, qpd, q);
+
+				ret = remove_queue_mes(dqm, q, qpd);
+				if (ret) {
+					dev_err(dev, "Removing bad queue failed");
+					goto out;
+				}
+
+				ret = resume_all_queues_mes(dqm);
+				if (ret)
+					dev_err(dev, "Resuming all queues failed");
+
+				break;
+			}
+		}
+	}
+
+out:
+	dqm_unlock(dqm);
+	return ret;
+}
+
 static int kfd_dqm_evict_pasid_mes(struct device_queue_manager *dqm,
 				   struct qcm_process_device *qpd)
 {
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c
index f524a55eee11..b3f988b275a8 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c
@@ -330,11 +330,14 @@ static void event_interrupt_wq_v11(struct kfd_node *dev,
 		if (source_id == SOC15_INTSRC_CP_END_OF_PIPE)
 			kfd_signal_event_interrupt(pasid, context_id0, 32);
 		else if (source_id == SOC15_INTSRC_CP_BAD_OPCODE &&
-			 KFD_DBG_EC_TYPE_IS_PACKET(KFD_CTXID0_CP_BAD_OP_ECODE(context_id0)))
-			kfd_set_dbg_ev_from_interrupt(dev, pasid,
-				KFD_CTXID0_DOORBELL_ID(context_id0),
+			 KFD_DBG_EC_TYPE_IS_PACKET(KFD_CTXID0_CP_BAD_OP_ECODE(context_id0))) {
+			u32 doorbell_id = KFD_CTXID0_DOORBELL_ID(context_id0);
+
+			kfd_set_dbg_ev_from_interrupt(dev, pasid, doorbell_id,
 				KFD_EC_MASK(KFD_CTXID0_CP_BAD_OP_ECODE(context_id0)),
 				NULL, 0);
+			kfd_dqm_suspend_bad_queue_mes(dev, pasid, doorbell_id);
+		}
 
 		/* SDMA */
 		else if (source_id == SOC21_INTSRC_SDMA_TRAP)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index f7c12d4f0abb..7bba6bed2f48 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1324,6 +1324,7 @@ struct kernel_queue *kernel_queue_init(struct kfd_node *dev,
 					enum kfd_queue_type type);
 void kernel_queue_uninit(struct kernel_queue *kq);
 int kfd_dqm_evict_pasid(struct device_queue_manager *dqm, u32 pasid);
+int kfd_dqm_suspend_bad_queue_mes(struct kfd_node *knode, u32 pasid, u32 doorbell_id);
 
 /* Process Queue Manager */
 struct process_queue_node {
-- 
2.35.1

