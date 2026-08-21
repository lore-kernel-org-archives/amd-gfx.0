Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F34E8C5DF94
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2026 16:08:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E25A10F360;
	Fri, 21 Aug 2026 16:08:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UckF8CKD";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012045.outbound.protection.outlook.com
 [40.93.195.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C811610F35E
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2026 16:08:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uZ04pUh3rjRRWBpn8Ytgn1XiA2nCYHfjAHQfqQDp5/wKjBwTu0C0tvBCheTmwr88ftHeiAJaVnpJPVrC9rShybbPia7ErwEy9fqRBcoyqZdh89DCQ8j7+NEXb7YbUV8itE92plZAw1DzO8tPAmUZYiUY6cyuTEalLZTJU6GZ6obg2dB7Arje4oOMNxpB3XpyGGKzKq55ZQc8jhmVlal3PYe2ZJe3zXpVgei1FpgacsOGZAPgRC/awh/1SzoJiHi74pNNx89dIWXR1VMIgHZ/hbckUGYK3a73Q1Iz56xUqpUCS+S05eLWLqlQYvWqapJVhb0wX8KbVMxBKYCoROz+6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8JQV2vEwo0RsK6+Lcnf3s24L7/U68fiHheusajuOa2M=;
 b=KUOIwUyVsz1Kyg5hdGj6CXpHKVjez3wkyS8/dlNDVu3g6TCdLhDH71PC+ltocwfkMI+6FYB2FLX3iqXvQurx4VEJWUF5Do/cTZbBzk1+xRpsIePB7uOhvImdo9a+pEuEHTjYEDypfeRxFZT2nxZ3bBDb9zVdMSgwhFktoW0s8CaRHiDb10KvZys/mQ5CZ2z5N5pysFfeLT/kary9Zilv+684qlgCDGuCNlIhOm/v2WyLX8bq1gLEG/n/sSQ3qh8GNMWplzBr6hHOfPj5RwDbUUnABS8HzzckllSCcUqOR7MobtTKwTqGrdxOqE59qzWd+FfDMg6/0x2iVOWQAme6Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8JQV2vEwo0RsK6+Lcnf3s24L7/U68fiHheusajuOa2M=;
 b=UckF8CKDixANmMG8XAXUUojUb48K5vnzkWVL9iUxv596GoUyw+wrVSFo6N1eg97x7iNUpnTWYzslQdo0bPLbpIiTwWfkHXSq4Wg8fkhrmbNzgYq/zhKiNkNht1fCYOv3qVAdgNcLnnunHYoC6+SBIE6GvVSnaBRNlnX7KLlU+lw=
Received: from SJ0PR03CA0060.namprd03.prod.outlook.com (2603:10b6:a03:33e::35)
 by DS0PR12MB9421.namprd12.prod.outlook.com (2603:10b6:8:1a1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Fri, 21 Aug
 2026 16:08:34 +0000
Received: from SJ5PEPF00000206.namprd05.prod.outlook.com
 (2603:10b6:a03:33e:cafe::1d) by SJ0PR03CA0060.outlook.office365.com
 (2603:10b6:a03:33e::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 16:08:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF00000206.mail.protection.outlook.com (10.167.244.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 16:08:34 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 11:08:34 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 21 Aug
 2026 11:08:33 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Fri, 21 Aug 2026 11:08:33 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Sierra <alex.sierra@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 3/3] drm/amdkfd: disable debug before retiring MES process
 context on teardown
Date: Fri, 21 Aug 2026 12:08:21 -0400
Message-ID: <20260821160821.752678-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821160821.752678-1-alexander.deucher@amd.com>
References: <20260821160821.752678-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000206:EE_|DS0PR12MB9421:EE_
X-MS-Office365-Filtering-Correlation-Id: 074e6835-f38a-4af4-a932-08deff9e739e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|23010399003|1800799024|10086099003|10067099003|56012099006|5023799004|11063799006|18092099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: qPKhP0d1gq6kNa3gGGjDdnvq8Oe/AsR5Uh2s+1BW3IMcWc7J0SHT7AMs+sgLQKfw93eI6ZT+NBXRjv/2Z9VNvgNdKBEqtgufsDWF+taQkJc+4gUveNOXN2vf0eOnCX3D2hapkUgt7CXEM7CuWCOWMARSbiHc3QZ2HcXY302UA59WzDWEEmb7apnJgv6Ssc5lstdtrvV1CMyfZ28d104Edy9Fwv79yAazFSwbWRI+FaARfC3tHixpt8VywoS0/cCaI+RJ14q8VN0O/xVtyOx4HMgtrvWbA8JHGZGt7/bX/JMs0+02JjepFBOjLPhNbD7s3zXaU2Zt5j+1TrjIlTPnBdAkOmEzMG9JIBgci8iJRDgfbSmqS5BWWFpk5Zn52Esw9HFzC8FG+kHjiF8gIUu4unqm6UHb9jSkoqTNJUK7egGxyhB9FZYoIptvc2o5ePzekF5oBbLBcPxyPy5eD3QHWSx2RWqEYgA6SHvrsjpc2JIQLhDMVmuuH8sYJdOytBxd2+433JZ2G5CPUBT/GuAnJpMVMxHXxSZszC9rQoWAyPmL8BzBhYUaMTA6WZR7ko/wgA6yT4E56R5jhEfSH9nmz9TKqYat/QgXnw1+fNi+QQZ5Po/a+m+fk8EG/cIKk+/EJRZJEFvFcqb77flW8PpA/aLtiGzQsZHbMgNvzF14IO4jlpBIy76bw3rvDRFWUXheq6gyBN4SzHfmxMJIfxX/Ew==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(23010399003)(1800799024)(10086099003)(10067099003)(56012099006)(5023799004)(11063799006)(18092099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: LgrZ3RQnzC04pJdu0Z9IcDN5uvykEfVYlNjMElusSz/XuXYidqv3lkyMdYLjKK/wm0vzjbwZ5/kGsOcrnuUHlFXq2wIYaM6Q4oaXFYq5dB662mNIpcTDUOaTrh/AMKHxPay1Rvrlr7+oR/9A87mardtA5TSSFpGPnk6JJRJRK/STJ5S+n2wZ+W/tDk7w/OJn81Dw0IFTE6P6yoh/e7uhX2a1UYc9Hqu4ocboaRsaGL4hJdZNfTwOYWtl7bpkl8Wg+FVQxdDA4pZGD9Z8Wxk2sO6jL9zSPR3bFub0Q4IOlNSgIg+EhlGNDuKP38jJNojNAHkGkiVBwREqLdQ1N8Ofx5GOwGkEY9/AaWmz9659dpV2x84t3/fAuWQXuyvU5wqxvIeW+cH5LDZfBjCVaIJ0WTwXtR+IFyjsLZDhKsJo8/5lWb4psy/DFXSbRgHMRABV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 16:08:34.1855 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 074e6835-f38a-4af4-a932-08deff9e739e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000206.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9421
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

From: Alex Sierra <alex.sierra@amd.com>

On process teardown, kfd_process_notifier_release_internal() called
kfd_process_dequeue_from_all_devices() (which issues the MES
SET_SHADER_DEBUGGER process_ctx_flush=1 that retires the process context)
before kfd_dbg_trap_disable(). For a process under a debugger, the debug
teardown path (kfd_dbg_trap_disable -> kfd_dbg_trap_deactivate) then issues
several SET_SHADER_DEBUGGER process_ctx_flush=0 packets (reset wave launch
mode, clear debug flags, reset MES debug mode). Because those packets carry
the process_context_addr, MES re-adds the process to its scheduler list
after the flush had retired it.

Teardown then frees proc_ctx_bo, and a later MES scheduling pass dereferences
the freed process context, producing a GPUVM page fault (vmid 0, GC_UTCL2)
on the freed page. This is intermittent because it depends on an MES pass
landing on the process before its GART page is reused. It is specific to the
debugger path, where queues are added with skip_process_ctx_clear=1 so the
last REMOVE_QUEUE does not clear the context and delisting relies on the
flush.

Reorder teardown so debug is disabled first, and the process context is
flushed/retired last, so nothing re-adds the process after it is retired.
kfd_dbg_trap_disable() now runs while queues still exist, which matches the
normal live debug-disable ordering.

Signed-off-by: Alex Sierra <alex.sierra@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 44 +++++++++++++++---------
 1 file changed, 28 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 0a7c1900da959..dd938788bdd9a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1408,23 +1408,16 @@ void kfd_process_notifier_release_internal(struct kfd_process *p)
 		kfd_unref_process(p);
 
 	/*
-	 * Dequeue and destroy user queues, it is not safe for GPU to access
-	 * system memory after mmu release notifier callback returns because
-	 * exit_mmap free process memory afterwards.
+	 * Disable debug BEFORE dequeuing/flushing the MES process context.
+	 *
+	 * kfd_dbg_trap_disable() -> kfd_dbg_trap_deactivate() issues
+	 * SET_SHADER_DEBUGGER (process_ctx_flush=0) packets that re-add the
+	 * process to the MES scheduler list. kfd_process_dequeue_from_all_devices()
+	 * sends the process_ctx_flush=1 that retires the context. If debug
+	 * teardown ran after the dequeue, those packets would put the process
+	 * back on the MES list and, once proc_ctx_bo is freed, MES would fault
+	 * on the freed process context. Retiring the context last avoids this.
 	 */
-	kfd_process_dequeue_from_all_devices(p);
-	pqm_uninit(&p->pqm);
-
-	for (i = 0; i < p->n_pdds; i++) {
-		struct kfd_process_device *pdd = p->pdds[i];
-
-		/* re-enable GFX OFF since runtime enable with ttmp setup disabled it. */
-		if (!kfd_dbg_is_rlc_restore_supported(pdd->dev) && p->runtime_info.ttmp_setup)
-			amdgpu_gfx_off_ctrl(pdd->dev->adev, true);
-	}
-
-	/* Indicate to other users that MM is no longer valid */
-	p->mm = NULL;
 	kfd_dbg_trap_disable(p);
 
 	if (atomic_read(&p->debugged_process_count) > 0) {
@@ -1445,6 +1438,25 @@ void kfd_process_notifier_release_internal(struct kfd_process *p)
 		srcu_read_unlock(&kfd_processes_srcu, idx);
 	}
 
+	/*
+	 * Dequeue and destroy user queues, it is not safe for GPU to access
+	 * system memory after mmu release notifier callback returns because
+	 * exit_mmap free process memory afterwards.
+	 */
+	kfd_process_dequeue_from_all_devices(p);
+	pqm_uninit(&p->pqm);
+
+	for (i = 0; i < p->n_pdds; i++) {
+		struct kfd_process_device *pdd = p->pdds[i];
+
+		/* re-enable GFX OFF since runtime enable with ttmp setup disabled it. */
+		if (!kfd_dbg_is_rlc_restore_supported(pdd->dev) && p->runtime_info.ttmp_setup)
+			amdgpu_gfx_off_ctrl(pdd->dev->adev, true);
+	}
+
+	/* Indicate to other users that MM is no longer valid */
+	p->mm = NULL;
+
 	if (p->context_id == KFD_CONTEXT_ID_PRIMARY)
 		mmu_notifier_put(&p->mmu_notifier);
 }
-- 
2.55.0

