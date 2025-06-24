Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B0FCC7EE32
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Jun 2025 08:46:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E70DC10E535;
	Tue, 24 Jun 2025 08:46:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PeyfhB0Y";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2058.outbound.protection.outlook.com [40.107.96.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6825610E533
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Jun 2025 08:46:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VYYXDX19LQlxzVyw9m13yvw0kLNiSL/vIKcKAD0GsXsVZYrbw+KKhCZiWYy6o0nH5SerJJLMusbwgUY1dbiv2MGJ+YjyNzmax6sE1guNyq8Cqh+7JYmSTwsQqBguZvzXKTaUjbUlJR+UtKcxmxvkHNHsC9QE11kmy6KEFbJHFMDjfVCZqEef8MCFTb9ZvnJV41Dfb7S+4qyeLwuIacJW8bRKKC5IgI64JY9Oph+YEznoJRhdGbpg0TFTixv19Swxvk0pJxRC0PNeJtehcmKwPmt5q0yx8B0OGPCGxSyMK3TQdul8juocnhkvHFeStYZhq0ylEtSfQOJVOmwhjpPP2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=piRDEbOnYxgoGHlvtis5VVVqD2DLr7jJQd3FYXvnra0=;
 b=FMuNpbTykuYKq7gIuftAWqAnlBl48ipTrMBa3YXIAj3x3z1ek+MAve0mEyYl/0eKjW67LSg0dxLXwJCaJFQmHrdkLTXu6DNDZuZ8jISdzxGyjMmm6xsWe+H0axx/Cs+QfqhGuVAZrm/ic0cbeK7MZodpemWDN/6cHpAThnr8X+NAUTdtHPauCuM91bXkCPpCbF8t+eU2yRkkL4L0BpqHjTyAidCy2jSq1/P7bd3Fjd5Z/Tvt2ecv24s/3TnMpOneMxEpqi1mE6CU6N157LmgH9A4MWbYrrGYSfZjVYvQ617EtHyWUQBmUAuKHMYDX/H446BpT46PM4gWCxXuF2QD0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=piRDEbOnYxgoGHlvtis5VVVqD2DLr7jJQd3FYXvnra0=;
 b=PeyfhB0YSQzUMJG7HJ8y5PAQ3zylW1+6vPIybM8DvWLaPddCl1EjTN+L1JnPCEkI/DQ3J/Auq+aTJOYaCY34/gj+t3yH9XWRqjauhzd+V6EhmdgqrVAgwvP81IOiPZCgLjM+NNg4viYBCTMr7p00z+PLTeYMXZqycu8wGkyU9ps=
Received: from PH2PEPF0000385F.namprd17.prod.outlook.com (2603:10b6:518:1::6d)
 by DS0PR12MB6607.namprd12.prod.outlook.com (2603:10b6:8:d1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.21; Tue, 24 Jun
 2025 08:45:59 +0000
Received: from CY4PEPF0000E9D4.namprd03.prod.outlook.com
 (2a01:111:f403:f912::4) by PH2PEPF0000385F.outlook.office365.com
 (2603:1036:903:48::3) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.16 via Frontend Transport; Tue,
 24 Jun 2025 08:45:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D4.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Tue, 24 Jun 2025 08:45:58 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 24 Jun
 2025 03:45:56 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH v4 08/11] drm/amdgpu: add userq va unmap validated helper
Date: Tue, 24 Jun 2025 16:45:32 +0800
Message-ID: <20250624084535.1178476-8-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250624084535.1178476-1-Prike.Liang@amd.com>
References: <20250624084535.1178476-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D4:EE_|DS0PR12MB6607:EE_
X-MS-Office365-Filtering-Correlation-Id: 894b2d42-3365-4f03-ddc3-08ddb2fb8a9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?khoLPTSEYdQ3dId6DKPbnX95RCeVZmeZ2H9qTNHTXxk9ly3vORWbP7jdkLST?=
 =?us-ascii?Q?OWxmjPPUso7HxtkaErH9Ma5ViZveafB7lbaCjvyPpNbHiYI8LHTxlmJ/uCZM?=
 =?us-ascii?Q?L1OH+9OOzCE7hPKIgPRgfMImHjaXGZk0/mX6trkaeP0S6BNaQAEAwBT6t+Zc?=
 =?us-ascii?Q?SiWahLs+WgGZExJ65kRv05ckEHIkNKrCT3bgQZGlJ7qFzs4XUciGE+Y6dgu+?=
 =?us-ascii?Q?NJ2AaMLnVQnqa15Qrvn3ew1qE+BdyGIO9pZIPEWwiPBBmSEBc/7JPlzldW5Y?=
 =?us-ascii?Q?2g4FJ+l3ZUW+atHOu42zYOqosVl83MFUIs8wl9e/0ITrAOH0iohFTrHN+Vjb?=
 =?us-ascii?Q?/qG5IFp4YM6YCk80gDAoJkU5nXJNbL2sAx8CCln6ciOSa/gB2AEtL6AbYFgX?=
 =?us-ascii?Q?mzP2I/NNt/sWhWUT6gUJ8lrAKpM/rCfR1nCR9AG7toiJCBf7HZi/AYbo2NAw?=
 =?us-ascii?Q?TzqBhZ4HsEboE7Rv2Ez8i9ziR8M7rTDKFCVizdJCWZI5bZrEPMKPnn9oGOZL?=
 =?us-ascii?Q?A+3EFIMEHRPCHgvY456hrcYTXZ0n0lYrxXtcJbA0kaAtz7sEj5N8MX6tBm4V?=
 =?us-ascii?Q?P+1rG3pHfVIoQ3IwNRRslXN6KNvJB5syocs8hM8X9uqTMEP5rEaa4A20+KqJ?=
 =?us-ascii?Q?v1mH5w0jQbAcikuK+ImLq8jTfJ2BXjRYABp1SraQ5maQnPxrsU5OjTCBNbqI?=
 =?us-ascii?Q?DsZqDFAx9cS5j+SKKQtNSkTjfoIZ9HpZCElOx5Om7+yN7q4LrlrMPcSG2nJm?=
 =?us-ascii?Q?Lk7N0MRdIji1UcEUDBJyTXikJAGkUbkAYToQwI7ZuUFZWI6LIrTVgMFTUfKw?=
 =?us-ascii?Q?FOALkeosNh6qdRwe/qFjPWDR71cVp4iTxuTIw7/k5HKLAUyjwR8J1PuckqfU?=
 =?us-ascii?Q?Z7eF9394KgEvJURLIXqsps6SFLEdR39ktqJQDkfD+SrPHxLyxrCJDoCl6t9K?=
 =?us-ascii?Q?If/RbMrcU+ntmZBcdMGxXdTyHhG0UfWWh1764I5fFXwA4musp2u5NhaboHPr?=
 =?us-ascii?Q?6Xgf/J/Xxe2N6EvFeuOm2aciicc9USTTDy3vRS9Ll1CZtsJt6+S+1G1eP8Ls?=
 =?us-ascii?Q?iOiWHXBkcmWBtOTZScblvpU/+cBOef985YFkb/0mWxPNpTtbLvrisBwOsA7B?=
 =?us-ascii?Q?TrjIyR/GZJtn6MYCxoAhUeMr5+wWq49qhjVhy1wXCLHNcLHI7q3W/y+JDMYl?=
 =?us-ascii?Q?nwEE7YPETLy1IYm/uTo7Olw1L08CWh/4GwY/Ed5yW7YBy3RQex045/DPtuec?=
 =?us-ascii?Q?PKIs/VSjMWrRTVg/J7Jxalo2zfaA/lTeKO8QBQs5QnZT4pMp7I2paQcvJlei?=
 =?us-ascii?Q?C5ndRNDbXPcvsClBsxO/10TFSyQu+LCpJVoEEjJTU8r3DfegDMPDpFgPTP6n?=
 =?us-ascii?Q?lbIaA/XErsVhUaNS4UH3YAQ+1tWI82egNs5X/zhk6AhTPbRduj0B/CExb+sT?=
 =?us-ascii?Q?Sw251t+GsQAbTeMbPlDx3JFqzUGF1bcl4jTSbxdAtnH4PeO93aEt4PI/y6iX?=
 =?us-ascii?Q?t7PwvABJEBf3SbKc83ONLUcovM/7YkNTNq69?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 08:45:58.7735 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 894b2d42-3365-4f03-ddc3-08ddb2fb8a9d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6607
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

This helper can validate the userq whether can be
unmapped prior to the userq VA GEM unmap.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 57 +++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h |  3 ++
 2 files changed, 60 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 0208c6b8a8e0..534a9c98c011 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -1150,3 +1150,60 @@ int amdgpu_userq_start_sched_for_enforce_isolation(struct amdgpu_device *adev,
 	mutex_unlock(&adev->userq_mutex);
 	return ret;
 }
+
+static bool amdgpu_userq_gem_va_unmap_queue_retrieve(struct amdgpu_usermode_queue *queue,
+							uint64_t va)
+{
+	if (amdgpu_userq_va_align(queue->queue_va) != va &&
+	    amdgpu_userq_va_align(queue->wptr_va) != va &&
+	    amdgpu_userq_va_align(queue->rptr_va) != va &&
+	    amdgpu_userq_va_align(queue->eop_va) != va &&
+	    amdgpu_userq_va_align(queue->shadow_va) != va &&
+	    amdgpu_userq_va_align(queue->csa_va) != va)
+		return false;
+
+	return true;
+}
+
+int amdgpu_userq_gem_va_unmap_validate(struct amdgpu_vm *vm,
+				uint64_t va)
+{
+	struct amdgpu_fpriv *fpriv = vm_to_fpriv(vm);
+	struct amdgpu_userq_mgr *uq_mgr = &fpriv->userq_mgr;
+
+	if (vm->is_userq_context && &fpriv->vm == vm) {
+		struct amdgpu_usermode_queue *queue;
+		int queue_id, r = 0;
+
+		if (mutex_trylock(&uq_mgr->userq_mutex)) {
+			/* If here the userq bo is busy and needs to deactivate and prevent reusing it.*/
+			idr_for_each_entry(&uq_mgr->userq_idr, queue, queue_id) {
+				struct dma_fence *f = queue->last_fence;
+
+
+				if (!amdgpu_userq_gem_va_unmap_queue_retrieve(queue, va)) {
+					dev_dbg(uq_mgr->adev->dev, "queue(id:%d) not belond to vm:%p\n",
+						queue_id,vm);
+					continue;
+				}
+
+				if (f && !dma_fence_is_signaled(f)) {
+
+					dev_warn(uq_mgr->adev->dev, "try to unmap the busy queue(id:%d):%p under vm:%p\n",
+						queue_id, queue, vm);
+					/* Need to set a resonable state for avoiding reusing this queue*/
+					queue->state = AMDGPU_USERQ_STATE_HUNG;
+					r++;
+				}
+			}
+			mutex_unlock(&uq_mgr->userq_mutex);
+			return r;
+		} else {
+			/* do we need a try lock again before return*/
+			return -EBUSY;
+		}
+
+	}
+
+	return 0;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index 194ec7a6b3b2..08c49d738ec1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -31,6 +31,7 @@
 #define to_ev_fence(f) container_of(f, struct amdgpu_eviction_fence, base)
 #define uq_mgr_to_fpriv(u) container_of(u, struct amdgpu_fpriv, userq_mgr)
 #define work_to_uq_mgr(w, name) container_of(w, struct amdgpu_userq_mgr, name)
+#define vm_to_fpriv(v)  container_of(v, struct amdgpu_fpriv, vm)
 
 enum amdgpu_userq_state {
 	AMDGPU_USERQ_STATE_UNMAPPED = 0,
@@ -148,4 +149,6 @@ bool amdgpu_userq_buffer_vas_mapped(struct amdgpu_vm *vm,
 int amdgpu_userq_buffer_va_put(struct amdgpu_vm *vm, u64 addr);
 int amdgpu_userq_buffer_vas_put(struct amdgpu_vm *vm,
 			struct amdgpu_usermode_queue *queue);
+int amdgpu_userq_gem_va_unmap_validate(struct amdgpu_vm *vm,
+				uint64_t va);
 #endif
-- 
2.34.1

