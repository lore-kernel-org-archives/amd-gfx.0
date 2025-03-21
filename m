Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EE1BC35FFF
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Mar 2025 10:52:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1976E10E784;
	Fri, 21 Mar 2025 10:52:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="k+qy/scB";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2073.outbound.protection.outlook.com [40.107.237.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09E2410E784
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Mar 2025 10:52:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dEtVrRNuTHdL0juybNutvNyd1mDl9I+lNXwZOOnKp3nrv+HSgbCtQMy0WrRV3GKNpFQKJQsQ+ww5R1v3Ahyi4DumVMJQEZeXc/yK6ZT3TK3YHlmZrQC44IK/L7TMd2empQeyyzA8eiJ2KJne9QbreZSfg+ppZC2NNKgclo6KlP3gPq7uKrdhveJuENL4QSopyqazAl92/x07HTQ2Nq8syalniVhOxZWOk+o//REzJztJAdaVCq5wPN4C95NAH1IFz4eI+KxDYZ6uiPAjfU9GfWhkapUCvus79CREnUmscvpQHb1rPNet/VDCWsOuhKXq/cJgPpxbj/o9TioaRBhH4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gVEN76pCzaULhzSCZ7LET6K4IEa9qfuk2cuZcyr2cOA=;
 b=uLO7GR/55qS9fkZnd2kGpPZ+oEWPHTKs2DWDsr1vazLQlY493M2gJAT4/6LkknEMQhwERDNBsHBWEBwbU2w7DLv6b7GhTG3WwMm0uByl2dUg/dgE26qiDImgChVEPXKYBs+KrhPc+svuLvBovoSoournfZ4owEKHUdF+/rHrnuaATES9+u7/+jMQ+TLQWPwYxw5h1UC/1Ieu1Vl2VGReE90Q3EMqurdvl6RhvzQSo+KCDhquka9V/jZIXRBdYPTmH6lgD6MQhQvPJrh+U66Dt3qPnmbUtZXxzJSdeMNj9JR/WVBE9ChcjYto7N22yYiD3xSZwFDj5wwVvyo4/UN1OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gVEN76pCzaULhzSCZ7LET6K4IEa9qfuk2cuZcyr2cOA=;
 b=k+qy/scBHak2R3Ci8xShxk+AB8P9ZL61cCYkVFY95FTx7Rhsm7Yanqca3eXFWu2xzZY8JHw1i7x0nFDFInIxXCjeezkrzGluAb92LXapioFbLOUv1/aitWyeEJVaXuXr7NuAz4sOMAK4xUimBqRyOiXuOhCi66PiH6neDRfjfrY=
Received: from MN2PR11CA0019.namprd11.prod.outlook.com (2603:10b6:208:23b::24)
 by DM6PR12MB4403.namprd12.prod.outlook.com (2603:10b6:5:2ab::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.36; Fri, 21 Mar
 2025 10:52:03 +0000
Received: from BN2PEPF000044A2.namprd02.prod.outlook.com
 (2603:10b6:208:23b:cafe::8c) by MN2PR11CA0019.outlook.office365.com
 (2603:10b6:208:23b::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.35 via Frontend Transport; Fri,
 21 Mar 2025 10:52:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF000044A2.mail.protection.outlook.com (10.167.243.153) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Fri, 21 Mar 2025 10:52:03 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Mar
 2025 05:52:02 -0500
Received: from SYS-7048GR-TR.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 21 Mar 2025 05:52:01 -0500
From: Emily Deng <Emily.Deng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Emily Deng <Emily.Deng@amd.com>
Subject: [PATCH] drm/amdkfd: Fix some kfd related recover issues
Date: Fri, 21 Mar 2025 18:52:00 +0800
Message-ID: <20250321105200.1661803-1-Emily.Deng@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Emily.Deng@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A2:EE_|DM6PR12MB4403:EE_
X-MS-Office365-Filtering-Correlation-Id: adc300ed-4222-47b4-fedc-08dd68666a0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1sHOy+juvQ9Vy2mfzDe074/4hk9ZztRngLOzVftDkXiXHHe6gnaR2Gn+mXTb?=
 =?us-ascii?Q?SQwkHDz4fizvXKFXeUgZ0o722y3EWReMh+sfKv0NN/iHvVEQz9zUOFJ6vHEO?=
 =?us-ascii?Q?J+VBMSsyzkNN2HNLR9wRfOCQO8F3XLVWodMxvKq9q3TxNErrWCm5rU9h4tJG?=
 =?us-ascii?Q?LuhQlCQTsSaqzCnwzfC+l6FSe3ECZNLgu2lr0AokVTd4ILFRwp91A3ZwyE8c?=
 =?us-ascii?Q?6Qvg7JdxgSkcHL2ynWoBPy7hNcYipnE0JAr+8TkBtEvH8UWc7QK2yErtJpRX?=
 =?us-ascii?Q?R4ZHyo45dYr2zh5nSRPRQ7AsLMWjIH/30uFQHDb5ryzNfqTQ7qAt/R/KRNYZ?=
 =?us-ascii?Q?GXHvWogWJ4DqwC+SZr/lgJyembLJXZDb3MBg8D+Hq0rs9VTjszu51kVBfHh/?=
 =?us-ascii?Q?ag9ABHzP0a+20k+uEd3WQWPSekatQt4UNFekm1Yyq85kYzBRGRUjey1Rusj9?=
 =?us-ascii?Q?2CwjEg7T6/IRn1EUJOkydB0zLI3xdcLPjbpIffi6yhP2aXw/+HFzWBuzuC0Z?=
 =?us-ascii?Q?KPX+tj9ERBflaVsDE4oFJm/p3TbgkSJJmoAhbjQ0wDYDdELGJOjk0ncKSxy8?=
 =?us-ascii?Q?TkJIIi7qPLyq8qR3QEK51raAOWW5GLpklsHfronQrCy6h3kZmqqtIQOQGyqn?=
 =?us-ascii?Q?gKCKKTgYW4wKhjIowhBa9792rBFuLH0Fu0cv1YJUlWgIQR05nXB4SdCzEgVf?=
 =?us-ascii?Q?p/Kuvg1Q46pKme4xLc91wB44AoRsWyiJ911G/LSU+DkIVf7Fnh1Eo4wwGxIs?=
 =?us-ascii?Q?tWXDORO8M2ScSYN3ismMPwNsiHQ4T9ZbwnkSbx3jHLsNS9KOtre/Gu18xPmu?=
 =?us-ascii?Q?fyMLWJ/f6Se+lzyGNC3QyCsjFUqmKQZC2Qn5fFilqOx12+Ulkb5LwIeUm0/v?=
 =?us-ascii?Q?M0jS8oaFqhXSLMnF1Dc8uPP2193xHT2NTfqUy5kBs07IygqDuILWOSDVqsFk?=
 =?us-ascii?Q?1tG8U2z/ksBEUsOFAvPJG8wGC2iJXEBTpA2Iw8srbEZoHvXfkEFEs79+1oTz?=
 =?us-ascii?Q?UH4FRTd88h1srMvDtIS40nWX2WPChmE8iFEgHK/gQsZFQJRzRo7Bm7b4txlf?=
 =?us-ascii?Q?0sD3npbYbaQ3YvvZrVn3dbsF4WPPDN/eAuPJ3ZzaJEr8k7rW1j2KKgFP1Lr8?=
 =?us-ascii?Q?rTAeL+vVcSSTGvufI/BQ5fWnmYKvY70cbFpWXkmhFPkKSFOjKj8RNxZI5dCW?=
 =?us-ascii?Q?HRhoetaO6SDnzyyWYkyhdCtl2MLvqV2TUtnhyvP/c2u5eXxlfzL4F05ZJXFE?=
 =?us-ascii?Q?FncXew0ZKCHAljIsTqMN+ZKSdq3q+je6Pk6BMOXfLAI0I+k7f4wjbu7gKmY9?=
 =?us-ascii?Q?V+N9VI1ZHpF2ighhFrFsDVe2zNyEZuAlzzz17lG4IjYfwkqV0XFB5JmReucP?=
 =?us-ascii?Q?iP6oXHuLptrtd/xLpxsdTKjUbvrMsCKEJD4oGdMRUh1z06M/daTEt8u5V0y9?=
 =?us-ascii?Q?sKa1rNOUZSLlKeAo4QJ3TGiptImhjNrta/IbTc2A/tNEfu6MbucNPHaw4vO1?=
 =?us-ascii?Q?x6r54XY+tSkcWgA=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2025 10:52:03.1133 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: adc300ed-4222-47b4-fedc-08dd68666a0b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4403
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

It need to check whether kq has been initialized correctly in kq_acquire_packet_buffer.
Or it will hit memory corruption during recover, as for recover, it will uninitialize
kq first.

Need to flush tlb after recover successully, as it maybe has create bo and
map bo during recover.

Signed-off-by: Emily Deng <Emily.Deng@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c       |  1 +
 drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c |  4 ++++
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c      | 22 +++++++++++++++++++
 4 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index b9c82be6ce13..eb2df5842618 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -1000,6 +1000,7 @@ int kgd2kfd_post_reset(struct kfd_dev *kfd)
 		return 0;
 
 	for (i = 0; i < kfd->num_nodes; i++) {
+		kfd_flush_all_processes(kfd->nodes[i]);
 		ret = kfd_resume(kfd->nodes[i]);
 		if (ret)
 			return ret;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
index 2b0a830f5b29..5e4ae969818e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
@@ -238,6 +238,10 @@ int kq_acquire_packet_buffer(struct kernel_queue *kq,
 	uint64_t wptr64;
 	unsigned int *queue_address;
 
+	if (!kq) {
+		pr_debug("kq has not been initialized\n");
+		goto err_no_space;
+	}
 	/* When rptr == wptr, the buffer is empty.
 	 * When rptr == wptr + 1, the buffer is full.
 	 * It is always rptr that advances to the position of wptr, rather than
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index f6aedf69c644..6c073ead2b06 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1059,7 +1059,7 @@ int kfd_process_evict_queues(struct kfd_process *p, uint32_t trigger);
 int kfd_process_restore_queues(struct kfd_process *p);
 void kfd_suspend_all_processes(void);
 int kfd_resume_all_processes(void);
-
+void kfd_flush_all_processes(struct kfd_node *node);
 struct kfd_process_device *kfd_process_device_data_by_id(struct kfd_process *process,
 							 uint32_t gpu_id);
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 7c0c24732481..4ed03359020b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -2110,6 +2110,28 @@ int kfd_resume_all_processes(void)
 	return ret;
 }
 
+void kfd_flush_all_processes(struct kfd_node *node)
+{
+	struct kfd_process *p;
+	struct kfd_process_device *pdd;
+	unsigned int temp;
+	int idx = srcu_read_lock(&kfd_processes_srcu);
+	struct amdgpu_vm *vm;
+
+	hash_for_each_rcu(kfd_processes_table, temp, p, kfd_processes) {
+		pdd = kfd_get_process_device_data(node, p);
+		if (!pdd)
+			continue;
+		vm = drm_priv_to_vm(pdd->drm_priv);
+		if (!vm)
+			continue;
+		atomic64_inc(&vm->tlb_seq);
+		kfd_flush_tlb(pdd, TLB_FLUSH_LEGACY);
+	}
+	srcu_read_unlock(&kfd_processes_srcu, idx);
+
+}
+
 int kfd_reserved_mem_mmap(struct kfd_node *dev, struct kfd_process *process,
 			  struct vm_area_struct *vma)
 {
-- 
2.34.1

