Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA33EE74AC3
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Dec 2024 17:59:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A487C10E456;
	Tue,  3 Dec 2024 17:59:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="atCnrDN2";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2078.outbound.protection.outlook.com [40.107.223.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8688C10E47C
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Dec 2024 17:58:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rI8s9hfEbzaXijU6GRtDZButgBEYcoKUen+yTR05z8yDJmbQKwUdzhGK3V9fgl+G0lu+NVZ6zSOz6+159rBlnjPzb62uDKbjA5v6hdjPVpf4mUYovst4JFj8+s6hh4xroQaPpJzycbwW23tDuXY1XQorXeP25HAVBZ4DKVTsv76+z1eyAc3Oao/If+cGlkHdhDVebze0bT8+wTym8pAswaTt9vD/V9E0Xr/ITNwzVwI7FXU3KqNrKAraL/dBd0pIWpxymDSJDG67GGN5/HcrBBtY0747EwKlQwGzpGMFVYpvQSJQ8ZM5/WTUPvcXdnX0hsPdlT8E3fjFHo/TfgIp6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NECd92Yx9ziWKk4Y8ZcjhcaUs9g3E+WbEAu+gOaPMdA=;
 b=ILYhK7s+7WTxvbrSL0u73Mo1r3UQl/PE4ub45dt68nbdQO+JqnaJdinITqNaxkncZSnaqxMWZvVU+IoH3gWYQ7LrdeMdUgRbPNo1fAVJXFCMpZgHO7/Y65O7hoo/1s22EB29tXOM97Xh8oytiXkOo1kTXbpruSriVwJxHmrpSPtHfd1H6iDwn2K/jeoB247soAbmDy97xe9b2XnGJiODMxT5uy5KDvVu/RFBxp8pzSf9Cnx3heLStAMsqdfmUMFxMkzv+1IZauXdAwgocNdM4kDT+DYbHfcgs+RwqBn7YE7OLlMcnFkpQgJTvVf30+3zCt+bzSXpV6JePYewpACLhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NECd92Yx9ziWKk4Y8ZcjhcaUs9g3E+WbEAu+gOaPMdA=;
 b=atCnrDN23GTsqNxd6xL63Rx4QCL0YXFbcNUoyh251152AAALGtLeTrO/u1BGrOQfLFT81pIHIlaKXEgl5grYGYcSqqEYTDLUh6P2CFCn9lMGODADoPPP9akoppAOih3uUmbILRPqdR8y1V7otFncQrhbyYuS4cECz8L2L4gUqms=
Received: from CY8PR10CA0030.namprd10.prod.outlook.com (2603:10b6:930:4b::21)
 by MN2PR12MB4336.namprd12.prod.outlook.com (2603:10b6:208:1df::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.20; Tue, 3 Dec
 2024 17:58:46 +0000
Received: from CY4PEPF0000EE38.namprd03.prod.outlook.com
 (2603:10b6:930:4b:cafe::e9) by CY8PR10CA0030.outlook.office365.com
 (2603:10b6:930:4b::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.19 via Frontend Transport; Tue,
 3 Dec 2024 17:58:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EE38.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Tue, 3 Dec 2024 17:58:45 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 3 Dec
 2024 11:58:44 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 3 Dec
 2024 11:58:44 -0600
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 3 Dec 2024 11:58:43 -0600
From: Xiaogang.Chen <xiaogang.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <felix.kuehling@amd.com>, <christian.koenig@amd.com>,
 <jonathan.kim@amd.com>, Xiaogang Chen <xiaogang.chen@amd.com>
Subject: [PATCH v3] drm/amdkfd: Have kfd driver use same PASID values from
 graphic driver
Date: Tue, 3 Dec 2024 12:03:09 -0600
Message-ID: <20241203180309.192263-1-xiaogang.chen@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE38:EE_|MN2PR12MB4336:EE_
X-MS-Office365-Filtering-Correlation-Id: acbcb62d-e76d-4448-4e81-08dd13c421c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NQ/VjJpGl5m/c6T0gBggBHpJiBEoe1BqxE5IUDfr/7+D4V7SVJYWoxopzxDB?=
 =?us-ascii?Q?KCCmIKviLJn3G4ptqyFiK9TosU2Qj1VeM2/H+J8tMXqTT74gjb/3yxrGc1kV?=
 =?us-ascii?Q?DiSon4CgDW5HcA5Ep9NaGxAT9K5oLg61Hi1m3n4EcV/SmdPZolkknRmqARr6?=
 =?us-ascii?Q?+1cY32CkySijKSQ9VQnedVy4kXjBg7E4AgaCfv8/rZvtGDK1DRQlymh93AOk?=
 =?us-ascii?Q?vofNup00x3ijzkr98MO4HuMWY9urKdEVf+Rij76bxum6bOQZTKK2hENyPAvr?=
 =?us-ascii?Q?HyWiRIjVFCZGtTvhA3yDR0oyXoHBsoaznuVD4kPL9Y9TYUhyab/sHcIEXcF9?=
 =?us-ascii?Q?bjnG7xWi64RyirmkDzWsRuzIIcbortXfmrXVUlYpJjuwRsIyhNa67MCHkfdj?=
 =?us-ascii?Q?/XIo4YueSC8fao6VxaKnKvs0X7tsqmIPbreVIbvMNkrSkf2Fh3GIiortYqMt?=
 =?us-ascii?Q?+UvTVk95BoNkWWlmRo18w4RgsTVzXurDB5U9sGEjd4DQJZ2GY5MMLNiiINZN?=
 =?us-ascii?Q?KwDVttAoHR4/wrnrBGuYlPZmUUWHexFrP0yoLvh/9krHuc2iMifPXi9EX4Gd?=
 =?us-ascii?Q?jue8huH2BrfJ/fGVvXWQQ5kgoankple74V2GI8L/Wds6xt1A/mmoSZKxRwEO?=
 =?us-ascii?Q?ynnO8GXCSYCeVSMkbqMA3r9TQ3h0EG6U6Opan4GMVsFXXyAQyNzluwZRhL8h?=
 =?us-ascii?Q?kEwtf645lwCls2ShiUuJlVUhvn12Ar6Gqv4fSt2yi/ZmT7ZYiQY3XRjinaNB?=
 =?us-ascii?Q?Qg+AZumKMd8ALBhUzQ/RV9YeHPXt/SK6uYsQn1SBA+nVPuZMbZaKuIJMAFm/?=
 =?us-ascii?Q?ZjzKeXJx05DGra+eadFI3PpF7ahzTmpFFfcDsk9YWToQ/++b6s9whQ89aUp8?=
 =?us-ascii?Q?QSlK/Ur/HGwafmr7kH2+1tV3kx+3Rpe+0pP1luL0kTYDHiQzNDltdzbHcVLH?=
 =?us-ascii?Q?jeloFfKin5UthF/KHpdwEx6ATL3MJOCtIqJL9p48NCgy9YjlyRxNveK6pCTq?=
 =?us-ascii?Q?kJw+ld7OpCcDUCUBT5bIpWxdbgcgIgpLNCx+Qs+LdQktxROHJ3+RyBqjXXz7?=
 =?us-ascii?Q?8MeV8rjTfX5DQ4biCIobgrgEnd1H6UyF4KsT76u0EJ9Mtv8Kk/NYKiSytZ2o?=
 =?us-ascii?Q?Ecj4LJpclJBLJ4A+frCfG+5phZLOlIuK5LKkzVVMQONil6Brim16xa7V+H4Q?=
 =?us-ascii?Q?ppVptT6jXJeRsr+ZbJPTA3G79b2VyT7H2gmoWO/e7wPRDr31/1fYmyoCXcOl?=
 =?us-ascii?Q?cfIlk5sQMzBN3Knh1NuRbFMf9PNj/v2dwbTIfuvbkM7+MugwJNaEEht9r96x?=
 =?us-ascii?Q?FGywYZN9jCgZPRJIsv6sg0k9oF8ofRhdKa5tyg2N8bvytb9kTha/x1QwXqg2?=
 =?us-ascii?Q?NHtz9DLJJCMXJmeqR/aGlCUDGfKbESMvcap34ghlc3JVF0zTpiqIJr12jy0c?=
 =?us-ascii?Q?8Tm6MZ/QB1vtNbdOlsKvYtkIt5uUVJnk?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 17:58:45.5659 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: acbcb62d-e76d-4448-4e81-08dd13c421c2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE38.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4336
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

From: Xiaogang Chen <xiaogang.chen@amd.com>

Current kfd driver has its own PASID value for a kfd process and uses it to
locate vm at interrupt handler or mapping between kfd process and vm. That
design is not working when a physical gpu device has multiple spatial
partitions, ex: adev in CPX mode. This patch has kfd driver use same pasid
values that graphic driver generated which is per vm per pasid.

These pasid values are passed to fw/hardware. We do not need change interrupt
handler though more pasid values are used. Also, pasid values at log are
replaced by user process pid; pasid values are not exposed to user. Users see
their process pids that have meaning in user space.

Signed-off-by: Xiaogang Chen <xiaogang.chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    |   3 +-
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  |  21 ----
 .../gpu/drm/amd/amdkfd/cik_event_interrupt.c  |  14 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c      |  25 ++--
 drivers/gpu/drm/amd/amdkfd/kfd_debug.c        |  14 +--
 .../drm/amd/amdkfd/kfd_device_queue_manager.c |  77 ++++++------
 drivers/gpu/drm/amd/amdkfd/kfd_events.c       |  43 ++++---
 .../gpu/drm/amd/amdkfd/kfd_int_process_v11.c  |   2 +-
 .../gpu/drm/amd/amdkfd/kfd_int_process_v9.c   |   2 +-
 .../drm/amd/amdkfd/kfd_packet_manager_v9.c    |   4 +-
 .../drm/amd/amdkfd/kfd_packet_manager_vi.c    |   3 +-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h         |  11 +-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c      | 115 +++++++++++-------
 .../amd/amdkfd/kfd_process_queue_manager.c    |  10 +-
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c          |  19 +--
 15 files changed, 191 insertions(+), 172 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index 4b80ad860639..c1bc77f5bea4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -47,6 +47,7 @@ enum TLB_FLUSH_TYPE {
 };
 
 struct amdgpu_device;
+struct kfd_process_device;
 struct amdgpu_reset_context;
 
 enum kfd_mem_attachment_type {
@@ -299,8 +300,6 @@ bool amdgpu_amdkfd_compute_active(struct amdgpu_device *adev, uint32_t node_id);
 	(&((struct amdgpu_fpriv *)					\
 		((struct drm_file *)(drm_priv))->driver_priv)->vm)
 
-int amdgpu_amdkfd_gpuvm_set_vm_pasid(struct amdgpu_device *adev,
-				     struct amdgpu_vm *avm, u32 pasid);
 int amdgpu_amdkfd_gpuvm_acquire_process_vm(struct amdgpu_device *adev,
 					struct amdgpu_vm *avm,
 					void **process_info,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index f30548f4c3b3..08a97f1b7ebd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1529,27 +1529,6 @@ static void amdgpu_amdkfd_gpuvm_unpin_bo(struct amdgpu_bo *bo)
 	amdgpu_bo_unreserve(bo);
 }
 
-int amdgpu_amdkfd_gpuvm_set_vm_pasid(struct amdgpu_device *adev,
-				     struct amdgpu_vm *avm, u32 pasid)
-
-{
-	int ret;
-
-	/* Free the original amdgpu allocated pasid,
-	 * will be replaced with kfd allocated pasid.
-	 */
-	if (avm->pasid) {
-		amdgpu_pasid_free(avm->pasid);
-		amdgpu_vm_set_pasid(adev, avm, 0);
-	}
-
-	ret = amdgpu_vm_set_pasid(adev, avm, pasid);
-	if (ret)
-		return ret;
-
-	return 0;
-}
-
 int amdgpu_amdkfd_gpuvm_acquire_process_vm(struct amdgpu_device *adev,
 					   struct amdgpu_vm *avm,
 					   void **process_info,
diff --git a/drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c b/drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c
index 795382b55e0a..b6efe7437e55 100644
--- a/drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c
+++ b/drivers/gpu/drm/amd/amdkfd/cik_event_interrupt.c
@@ -107,10 +107,16 @@ static void cik_event_interrupt_wq(struct kfd_node *dev,
 		kfd_signal_hw_exception_event(pasid);
 	else if (ihre->source_id == CIK_INTSRC_GFX_PAGE_INV_FAULT ||
 		ihre->source_id == CIK_INTSRC_GFX_MEM_PROT_FAULT) {
+		struct kfd_process_device *pdd;
 		struct kfd_vm_fault_info info;
+		struct kfd_process *p;
 
 		kfd_smi_event_update_vmfault(dev, pasid);
-		kfd_dqm_evict_pasid(dev->dqm, pasid);
+		p = kfd_lookup_process_by_pasid(pasid, &pdd);
+		if (!pdd)
+			return;
+
+		kfd_evict_process_device(pdd);
 
 		memset(&info, 0, sizeof(info));
 		amdgpu_amdkfd_gpuvm_get_vm_fault_info(dev->adev, &info);
@@ -118,9 +124,11 @@ static void cik_event_interrupt_wq(struct kfd_node *dev,
 			return;
 
 		if (info.vmid == vmid)
-			kfd_signal_vm_fault_event(dev, pasid, &info, NULL);
+			kfd_signal_vm_fault_event(pdd, &info, NULL);
 		else
-			kfd_signal_vm_fault_event(dev, pasid, NULL, NULL);
+			kfd_signal_vm_fault_event(pdd, &info, NULL);
+
+		kfd_unref_process(p);
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 065d87841459..8b1fd8e7452b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -155,8 +155,8 @@ static int kfd_open(struct inode *inode, struct file *filep)
 	/* filep now owns the reference returned by kfd_create_process */
 	filep->private_data = process;
 
-	dev_dbg(kfd_device, "process %d opened, compat mode (32 bit) - %d\n",
-		process->pasid, process->is_32bit_user_mode);
+	dev_dbg(kfd_device, "process pid %d opened kfd node, compat mode (32 bit) - %d\n",
+		(int)process->lead_thread->pid, process->is_32bit_user_mode);
 
 	return 0;
 }
@@ -361,8 +361,8 @@ static int kfd_ioctl_create_queue(struct file *filep, struct kfd_process *p,
 		goto err_acquire_queue_buf;
 	}
 
-	pr_debug("Creating queue for PASID 0x%x on gpu 0x%x\n",
-			p->pasid,
+	pr_debug("Creating queue for process pid 0x%x on gpu 0x%x\n",
+			(int)p->lead_thread->pid,
 			dev->id);
 
 	err = pqm_create_queue(&p->pqm, dev, &q_properties, &queue_id,
@@ -415,9 +415,9 @@ static int kfd_ioctl_destroy_queue(struct file *filp, struct kfd_process *p,
 	int retval;
 	struct kfd_ioctl_destroy_queue_args *args = data;
 
-	pr_debug("Destroying queue id %d for pasid 0x%x\n",
+	pr_debug("Destroying queue id %d for process pid 0x%x\n",
 				args->queue_id,
-				p->pasid);
+				(int)p->lead_thread->pid);
 
 	mutex_lock(&p->mutex);
 
@@ -468,8 +468,8 @@ static int kfd_ioctl_update_queue(struct file *filp, struct kfd_process *p,
 	properties.pm4_target_xcc = (args->queue_percentage >> 8) & 0xFF;
 	properties.priority = args->queue_priority;
 
-	pr_debug("Updating queue id %d for pasid 0x%x\n",
-			args->queue_id, p->pasid);
+	pr_debug("Updating queue id %d for process pid 0x%x\n",
+			args->queue_id, (int)p->lead_thread->pid);
 
 	mutex_lock(&p->mutex);
 
@@ -695,7 +695,7 @@ static int kfd_ioctl_get_process_apertures(struct file *filp,
 	struct kfd_process_device_apertures *pAperture;
 	int i;
 
-	dev_dbg(kfd_device, "get apertures for PASID 0x%x", p->pasid);
+	dev_dbg(kfd_device, "get apertures for process pid 0x%x", (int)p->lead_thread->pid);
 
 	args->num_of_nodes = 0;
 
@@ -747,7 +747,8 @@ static int kfd_ioctl_get_process_apertures_new(struct file *filp,
 	int ret;
 	int i;
 
-	dev_dbg(kfd_device, "get apertures for PASID 0x%x", p->pasid);
+	dev_dbg(kfd_device, "get apertures for process pid 0x%x",
+			(int)p->lead_thread->pid);
 
 	if (args->num_of_nodes == 0) {
 		/* Return number of nodes, so that user space can alloacate
@@ -3365,12 +3366,12 @@ static int kfd_mmio_mmap(struct kfd_node *dev, struct kfd_process *process,
 
 	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
 
-	pr_debug("pasid 0x%x mapping mmio page\n"
+	pr_debug("process pid 0x%x mapping mmio page\n"
 		 "     target user address == 0x%08llX\n"
 		 "     physical address    == 0x%08llX\n"
 		 "     vm_flags            == 0x%04lX\n"
 		 "     size                == 0x%04lX\n",
-		 process->pasid, (unsigned long long) vma->vm_start,
+		 (int)process->lead_thread->pid, (unsigned long long) vma->vm_start,
 		 address, vma->vm_flags, PAGE_SIZE);
 
 	return io_remap_pfn_range(vma,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
index 312dfa84f29f..e96e3895056e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_debug.c
@@ -204,11 +204,12 @@ bool kfd_set_dbg_ev_from_interrupt(struct kfd_node *dev,
 				   size_t exception_data_size)
 {
 	struct kfd_process *p;
+	struct kfd_process_device *pdd;
 	bool signaled_to_debugger_or_runtime = false;
 
-	p = kfd_lookup_process_by_pasid(pasid);
+	p = kfd_lookup_process_by_pasid(pasid, &pdd);
 
-	if (!p)
+	if (!pdd)
 		return false;
 
 	if (!kfd_dbg_ev_raise(trap_mask, p, dev, doorbell_id, true,
@@ -238,9 +239,8 @@ bool kfd_set_dbg_ev_from_interrupt(struct kfd_node *dev,
 
 			mutex_unlock(&p->mutex);
 		} else if (trap_mask & KFD_EC_MASK(EC_DEVICE_MEMORY_VIOLATION)) {
-			kfd_dqm_evict_pasid(dev->dqm, p->pasid);
-			kfd_signal_vm_fault_event(dev, p->pasid, NULL,
-							exception_data);
+			kfd_evict_process_device(pdd);
+			kfd_signal_vm_fault_event(pdd, NULL, exception_data);
 
 			signaled_to_debugger_or_runtime = true;
 		}
@@ -276,8 +276,8 @@ int kfd_dbg_send_exception_to_runtime(struct kfd_process *p,
 		data = (struct kfd_hsa_memory_exception_data *)
 						pdd->vm_fault_exc_data;
 
-		kfd_dqm_evict_pasid(pdd->dev->dqm, p->pasid);
-		kfd_signal_vm_fault_event(pdd->dev, p->pasid, NULL, data);
+		kfd_evict_process_device(pdd);
+		kfd_signal_vm_fault_event(pdd, NULL, data);
 		error_reason &= ~KFD_EC_MASK(EC_DEVICE_MEMORY_VIOLATION);
 	}
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index c79fe9069e22..22a807718fd4 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -208,7 +208,7 @@ static int add_queue_mes(struct device_queue_manager *dqm, struct queue *q,
 		return -EIO;
 
 	memset(&queue_input, 0x0, sizeof(struct mes_add_queue_input));
-	queue_input.process_id = qpd->pqm->process->pasid;
+	queue_input.process_id = pdd->pasid;
 	queue_input.page_table_base_addr =  qpd->page_table_base;
 	queue_input.process_va_start = 0;
 	queue_input.process_va_end = adev->vm_manager.max_pfn - 1;
@@ -527,6 +527,7 @@ static int allocate_vmid(struct device_queue_manager *dqm,
 			struct qcm_process_device *qpd,
 			struct queue *q)
 {
+	struct kfd_process_device *pdd = qpd_to_pdd(qpd);
 	struct device *dev = dqm->dev->adev->dev;
 	int allocated_vmid = -1, i;
 
@@ -545,9 +546,9 @@ static int allocate_vmid(struct device_queue_manager *dqm,
 
 	pr_debug("vmid allocated: %d\n", allocated_vmid);
 
-	dqm->vmid_pasid[allocated_vmid] = q->process->pasid;
+	dqm->vmid_pasid[allocated_vmid] = pdd->pasid;
 
-	set_pasid_vmid_mapping(dqm, q->process->pasid, allocated_vmid);
+	set_pasid_vmid_mapping(dqm, pdd->pasid, allocated_vmid);
 
 	qpd->vmid = allocated_vmid;
 	q->properties.vmid = allocated_vmid;
@@ -799,6 +800,11 @@ static int dbgdev_wave_reset_wavefronts(struct kfd_node *dev, struct kfd_process
 		return -EOPNOTSUPP;
 	}
 
+	/* taking the VMID for that process on the safe way using PDD */
+	pdd = kfd_get_process_device_data(dev, p);
+	if (!pdd)
+		return -EFAULT;
+
 	/* Scan all registers in the range ATC_VMID8_PASID_MAPPING ..
 	 * ATC_VMID15_PASID_MAPPING
 	 * to check which VMID the current process is mapped to.
@@ -808,23 +814,19 @@ static int dbgdev_wave_reset_wavefronts(struct kfd_node *dev, struct kfd_process
 		status = dev->kfd2kgd->get_atc_vmid_pasid_mapping_info
 				(dev->adev, vmid, &queried_pasid);
 
-		if (status && queried_pasid == p->pasid) {
-			pr_debug("Killing wave fronts of vmid %d and pasid 0x%x\n",
-					vmid, p->pasid);
+		if (status && queried_pasid == pdd->pasid) {
+			pr_debug("Killing wave fronts of vmid %d and process pid 0x%x\n",
+				 vmid, p->lead_thread->pid);
 			break;
 		}
 	}
 
 	if (vmid > last_vmid_to_scan) {
-		dev_err(dev->adev->dev, "Didn't find vmid for pasid 0x%x\n", p->pasid);
+		dev_err(dev->adev->dev, "Didn't find vmid for process pid 0x%x\n",
+			p->lead_thread->pid);
 		return -EFAULT;
 	}
 
-	/* taking the VMID for that process on the safe way using PDD */
-	pdd = kfd_get_process_device_data(dev, p);
-	if (!pdd)
-		return -EFAULT;
-
 	reg_gfx_index.bits.sh_broadcast_writes = 1;
 	reg_gfx_index.bits.se_broadcast_writes = 1;
 	reg_gfx_index.bits.instance_broadcast_writes = 1;
@@ -1060,8 +1062,8 @@ static int suspend_single_queue(struct device_queue_manager *dqm,
 	if (q->properties.is_suspended)
 		return 0;
 
-	pr_debug("Suspending PASID %u queue [%i]\n",
-			pdd->process->pasid,
+	pr_debug("Suspending process pid %u queue [%i]\n",
+			pdd->process->lead_thread->pid,
 			q->properties.queue_id);
 
 	is_new = q->properties.exception_status & KFD_EC_MASK(EC_QUEUE_NEW);
@@ -1108,8 +1110,8 @@ static int resume_single_queue(struct device_queue_manager *dqm,
 
 	pdd = qpd_to_pdd(qpd);
 
-	pr_debug("Restoring from suspend PASID %u queue [%i]\n",
-			    pdd->process->pasid,
+	pr_debug("Restoring from suspend process pid %u queue [%i]\n",
+			    pdd->process->lead_thread->pid,
 			    q->properties.queue_id);
 
 	q->properties.is_suspended = false;
@@ -1142,8 +1144,8 @@ static int evict_process_queues_nocpsch(struct device_queue_manager *dqm,
 		goto out;
 
 	pdd = qpd_to_pdd(qpd);
-	pr_debug_ratelimited("Evicting PASID 0x%x queues\n",
-			    pdd->process->pasid);
+	pr_debug_ratelimited("Evicting process pid 0x%x queues\n",
+			    pdd->process->lead_thread->pid);
 
 	pdd->last_evict_timestamp = get_jiffies_64();
 	/* Mark all queues as evicted. Deactivate all active queues on
@@ -1200,8 +1202,8 @@ static int evict_process_queues_cpsch(struct device_queue_manager *dqm,
 	if (!pdd->drm_priv)
 		goto out;
 
-	pr_debug_ratelimited("Evicting PASID 0x%x queues\n",
-			    pdd->process->pasid);
+	pr_debug_ratelimited("Evicting process pid 0x%x queues\n",
+			    pdd->process->lead_thread->pid);
 
 	/* Mark all queues as evicted. Deactivate all active queues on
 	 * the qpd.
@@ -1259,8 +1261,8 @@ static int restore_process_queues_nocpsch(struct device_queue_manager *dqm,
 		goto out;
 	}
 
-	pr_debug_ratelimited("Restoring PASID 0x%x queues\n",
-			    pdd->process->pasid);
+	pr_debug_ratelimited("Restoring process pid 0x%x queues\n",
+			    pdd->process->lead_thread->pid);
 
 	/* Update PD Base in QPD */
 	qpd->page_table_base = pd_base;
@@ -1343,8 +1345,8 @@ static int restore_process_queues_cpsch(struct device_queue_manager *dqm,
 	if (!pdd->drm_priv)
 		goto vm_not_acquired;
 
-	pr_debug_ratelimited("Restoring PASID 0x%x queues\n",
-			    pdd->process->pasid);
+	pr_debug_ratelimited("Restoring process pid 0x%x queues\n",
+			     pdd->process->lead_thread->pid);
 
 	/* Update PD Base in QPD */
 	qpd->page_table_base = amdgpu_amdkfd_gpuvm_get_process_page_dir(pdd->drm_priv);
@@ -2136,7 +2138,7 @@ static void set_queue_as_reset(struct device_queue_manager *dqm, struct queue *q
 	struct kfd_process_device *pdd = qpd_to_pdd(qpd);
 
 	dev_err(dqm->dev->adev->dev, "queue id 0x%0x at pasid 0x%0x is reset\n",
-		q->properties.queue_id, q->process->pasid);
+		q->properties.queue_id, pdd->process->lead_thread->pid);
 
 	pdd->has_reset_queue = true;
 	if (q->properties.is_active) {
@@ -2970,19 +2972,18 @@ void device_queue_manager_uninit(struct device_queue_manager *dqm)
 int kfd_dqm_suspend_bad_queue_mes(struct kfd_node *knode, u32 pasid, u32 doorbell_id)
 {
 	struct kfd_process_device *pdd;
-	struct kfd_process *p = kfd_lookup_process_by_pasid(pasid);
+	struct kfd_process *p = kfd_lookup_process_by_pasid(pasid, &pdd);
 	struct device_queue_manager *dqm = knode->dqm;
 	struct device *dev = dqm->dev->adev->dev;
 	struct qcm_process_device *qpd;
 	struct queue *q = NULL;
 	int ret = 0;
 
-	if (!p)
+	if (!pdd)
 		return -EINVAL;
 
 	dqm_lock(dqm);
 
-	pdd = kfd_get_process_device_data(dqm->dev, p);
 	if (pdd) {
 		qpd = &pdd->qpd;
 
@@ -3015,6 +3016,7 @@ int kfd_dqm_suspend_bad_queue_mes(struct kfd_node *knode, u32 pasid, u32 doorbel
 
 out:
 	dqm_unlock(dqm);
+	kfd_unref_process(p);
 	return ret;
 }
 
@@ -3056,24 +3058,23 @@ static int kfd_dqm_evict_pasid_mes(struct device_queue_manager *dqm,
 	return ret;
 }
 
-int kfd_dqm_evict_pasid(struct device_queue_manager *dqm, u32 pasid)
+int kfd_evict_process_device(struct kfd_process_device *pdd)
 {
-	struct kfd_process_device *pdd;
-	struct kfd_process *p = kfd_lookup_process_by_pasid(pasid);
+	struct device_queue_manager *dqm;
+	struct kfd_process *p;
 	int ret = 0;
 
-	if (!p)
+	p = pdd->process;
+	dqm = pdd->dev->dqm;
+	if (!p || !dqm)
 		return -EINVAL;
+
 	WARN(debug_evictions, "Evicting pid %d", p->lead_thread->pid);
-	pdd = kfd_get_process_device_data(dqm->dev, p);
-	if (pdd) {
-		if (dqm->dev->kfd->shared_resources.enable_mes)
+
+	if (dqm->dev->kfd->shared_resources.enable_mes)
 			ret = kfd_dqm_evict_pasid_mes(dqm, &pdd->qpd);
 		else
 			ret = dqm->ops.evict_process_queues(dqm, &pdd->qpd);
-	}
-
-	kfd_unref_process(p);
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
index ea3792249209..f1a0562c4ca8 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
@@ -727,7 +727,7 @@ void kfd_signal_event_interrupt(u32 pasid, uint32_t partial_id,
 	 * to process context, kfd_process could attempt to exit while we are
 	 * running so the lookup function increments the process ref count.
 	 */
-	struct kfd_process *p = kfd_lookup_process_by_pasid(pasid);
+	struct kfd_process *p = kfd_lookup_process_by_pasid(pasid, NULL);
 
 	if (!p)
 		return; /* Presumably process exited. */
@@ -1128,8 +1128,8 @@ static void lookup_events_by_type_and_signal(struct kfd_process *p,
 
 	if (type == KFD_EVENT_TYPE_MEMORY) {
 		dev_warn(kfd_device,
-			"Sending SIGSEGV to process %d (pasid 0x%x)",
-				p->lead_thread->pid, p->pasid);
+			"Sending SIGSEGV to process pid %d",
+				p->lead_thread->pid);
 		send_sig(SIGSEGV, p->lead_thread, 0);
 	}
 
@@ -1137,13 +1137,13 @@ static void lookup_events_by_type_and_signal(struct kfd_process *p,
 	if (send_signal) {
 		if (send_sigterm) {
 			dev_warn(kfd_device,
-				"Sending SIGTERM to process %d (pasid 0x%x)",
-					p->lead_thread->pid, p->pasid);
+				"Sending SIGTERM to process pid %d",
+					p->lead_thread->pid);
 			send_sig(SIGTERM, p->lead_thread, 0);
 		} else {
 			dev_err(kfd_device,
-				"Process %d (pasid 0x%x) got unhandled exception",
-				p->lead_thread->pid, p->pasid);
+				"Process pid %d got unhandled exception",
+				p->lead_thread->pid);
 		}
 	}
 
@@ -1157,7 +1157,7 @@ void kfd_signal_hw_exception_event(u32 pasid)
 	 * to process context, kfd_process could attempt to exit while we are
 	 * running so the lookup function increments the process ref count.
 	 */
-	struct kfd_process *p = kfd_lookup_process_by_pasid(pasid);
+	struct kfd_process *p = kfd_lookup_process_by_pasid(pasid, NULL);
 
 	if (!p)
 		return; /* Presumably process exited. */
@@ -1166,22 +1166,20 @@ void kfd_signal_hw_exception_event(u32 pasid)
 	kfd_unref_process(p);
 }
 
-void kfd_signal_vm_fault_event(struct kfd_node *dev, u32 pasid,
+void kfd_signal_vm_fault_event(struct kfd_process_device * pdd,
 				struct kfd_vm_fault_info *info,
 				struct kfd_hsa_memory_exception_data *data)
 {
 	struct kfd_event *ev;
 	uint32_t id;
-	struct kfd_process *p = kfd_lookup_process_by_pasid(pasid);
+	struct kfd_process *p = pdd->process;
 	struct kfd_hsa_memory_exception_data memory_exception_data;
 	int user_gpu_id;
 
-	if (!p)
-		return; /* Presumably process exited. */
-
-	user_gpu_id = kfd_process_get_user_gpu_id(p, dev->id);
+	user_gpu_id = kfd_process_get_user_gpu_id(p, pdd->dev->id);
 	if (unlikely(user_gpu_id == -EINVAL)) {
-		WARN_ONCE(1, "Could not get user_gpu_id from dev->id:%x\n", dev->id);
+		WARN_ONCE(1, "Could not get user_gpu_id from dev->id:%x\n",
+			  pdd->dev->id);
 		return;
 	}
 
@@ -1218,7 +1216,6 @@ void kfd_signal_vm_fault_event(struct kfd_node *dev, u32 pasid,
 		}
 
 	rcu_read_unlock();
-	kfd_unref_process(p);
 }
 
 void kfd_signal_reset_event(struct kfd_node *dev)
@@ -1253,7 +1250,8 @@ void kfd_signal_reset_event(struct kfd_node *dev)
 		}
 
 		if (unlikely(!pdd)) {
-			WARN_ONCE(1, "Could not get device data from pasid:0x%x\n", p->pasid);
+			WARN_ONCE(1, "Could not get device data from process pid:0x%x\n",
+				  p->lead_thread->pid);
 			continue;
 		}
 
@@ -1262,8 +1260,15 @@ void kfd_signal_reset_event(struct kfd_node *dev)
 
 		if (dev->dqm->detect_hang_count) {
 			struct amdgpu_task_info *ti;
+			struct amdgpu_fpriv *drv_priv;
+
+			if (unlikely(amdgpu_file_to_fpriv(pdd->drm_file, &drv_priv))) {
+				WARN_ONCE(1, "Could not get vm for device %x from pid:0x%x\n",
+					  dev->id, p->lead_thread->pid);
+				continue;
+			}
 
-			ti = amdgpu_vm_get_task_info_pasid(dev->adev, p->pasid);
+			ti = amdgpu_vm_get_task_info_vm(&drv_priv->vm);
 			if (ti) {
 				dev_err(dev->adev->dev,
 					"Queues reset on process %s tid %d thread %s pid %d\n",
@@ -1300,7 +1305,7 @@ void kfd_signal_reset_event(struct kfd_node *dev)
 
 void kfd_signal_poison_consumed_event(struct kfd_node *dev, u32 pasid)
 {
-	struct kfd_process *p = kfd_lookup_process_by_pasid(pasid);
+	struct kfd_process *p = kfd_lookup_process_by_pasid(pasid, NULL);
 	struct kfd_hsa_memory_exception_data memory_exception_data;
 	struct kfd_hsa_hw_exception_data hw_exception_data;
 	struct kfd_event *ev;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c
index b3f988b275a8..c5f97e6e36ff 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v11.c
@@ -194,7 +194,7 @@ static void event_interrupt_poison_consumption_v11(struct kfd_node *dev,
 	enum amdgpu_ras_block block = 0;
 	int ret = -EINVAL;
 	uint32_t reset = 0;
-	struct kfd_process *p = kfd_lookup_process_by_pasid(pasid);
+	struct kfd_process *p = kfd_lookup_process_by_pasid(pasid, NULL);
 
 	if (!p)
 		return;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
index 0cb5c582ce7d..b8a91bf4ef30 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
@@ -146,7 +146,7 @@ static void event_interrupt_poison_consumption_v9(struct kfd_node *dev,
 {
 	enum amdgpu_ras_block block = 0;
 	uint32_t reset = 0;
-	struct kfd_process *p = kfd_lookup_process_by_pasid(pasid);
+	struct kfd_process *p = kfd_lookup_process_by_pasid(pasid, NULL);
 	enum ras_event_type type = RAS_EVENT_TYPE_POISON_CONSUMPTION;
 	u64 event_id;
 	int old_poison, ret;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
index 1f9f5bfeaf86..d56525201155 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
@@ -47,7 +47,7 @@ static int pm_map_process_v9(struct packet_manager *pm,
 		packet->bitfields2.exec_cleaner_shader = 1;
 	packet->bitfields2.diq_enable = (qpd->is_debug) ? 1 : 0;
 	packet->bitfields2.process_quantum = 10;
-	packet->bitfields2.pasid = qpd->pqm->process->pasid;
+	packet->bitfields2.pasid = pdd->pasid;
 	packet->bitfields14.gds_size = qpd->gds_size & 0x3F;
 	packet->bitfields14.gds_size_hi = (qpd->gds_size >> 6) & 0xF;
 	packet->bitfields14.num_gws = (qpd->mapped_gws_queue) ? qpd->num_gws : 0;
@@ -106,7 +106,7 @@ static int pm_map_process_aldebaran(struct packet_manager *pm,
 		packet->bitfields2.exec_cleaner_shader = 1;
 	packet->bitfields2.diq_enable = (qpd->is_debug) ? 1 : 0;
 	packet->bitfields2.process_quantum = 10;
-	packet->bitfields2.pasid = qpd->pqm->process->pasid;
+	packet->bitfields2.pasid = pdd->pasid;
 	packet->bitfields14.gds_size = qpd->gds_size & 0x3F;
 	packet->bitfields14.gds_size_hi = (qpd->gds_size >> 6) & 0xF;
 	packet->bitfields14.num_gws = (qpd->mapped_gws_queue) ? qpd->num_gws : 0;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_vi.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_vi.c
index c1199d06d131..347c86e1c378 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_vi.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_vi.c
@@ -42,6 +42,7 @@ unsigned int pm_build_pm4_header(unsigned int opcode, size_t packet_size)
 static int pm_map_process_vi(struct packet_manager *pm, uint32_t *buffer,
 				struct qcm_process_device *qpd)
 {
+	struct kfd_process_device *pdd = qpd_to_pdd(qpd);
 	struct pm4_mes_map_process *packet;
 
 	packet = (struct pm4_mes_map_process *)buffer;
@@ -52,7 +53,7 @@ static int pm_map_process_vi(struct packet_manager *pm, uint32_t *buffer,
 					sizeof(struct pm4_mes_map_process));
 	packet->bitfields2.diq_enable = (qpd->is_debug) ? 1 : 0;
 	packet->bitfields2.process_quantum = 10;
-	packet->bitfields2.pasid = qpd->pqm->process->pasid;
+	packet->bitfields2.pasid = pdd->pasid;
 	packet->bitfields3.page_table_base = qpd->page_table_base;
 	packet->bitfields10.gds_size = qpd->gds_size;
 	packet->bitfields10.num_gws = qpd->num_gws;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 9e5ca0b93b2a..b6aba42d1f6b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -849,6 +849,8 @@ struct kfd_process_device {
 
 	/* Tracks queue reset status */
 	bool has_reset_queue;
+
+	u32 pasid;
 };
 
 #define qpd_to_pdd(x) container_of(x, struct kfd_process_device, qpd)
@@ -908,8 +910,6 @@ struct kfd_process {
 	/* We want to receive a notification when the mm_struct is destroyed */
 	struct mmu_notifier mmu_notifier;
 
-	u32 pasid;
-
 	/*
 	 * Array of kfd_process_device pointers,
 	 * one for each device the process is using.
@@ -1034,7 +1034,8 @@ void kfd_process_destroy_wq(void);
 void kfd_cleanup_processes(void);
 struct kfd_process *kfd_create_process(struct task_struct *thread);
 struct kfd_process *kfd_get_process(const struct task_struct *task);
-struct kfd_process *kfd_lookup_process_by_pasid(u32 pasid);
+struct kfd_process *kfd_lookup_process_by_pasid(u32 pasid,
+						 struct kfd_process_device **pdd);
 struct kfd_process *kfd_lookup_process_by_mm(const struct mm_struct *mm);
 
 int kfd_process_gpuidx_from_gpuid(struct kfd_process *p, uint32_t gpu_id);
@@ -1331,7 +1332,7 @@ void device_queue_manager_uninit(struct device_queue_manager *dqm);
 struct kernel_queue *kernel_queue_init(struct kfd_node *dev,
 					enum kfd_queue_type type);
 void kernel_queue_uninit(struct kernel_queue *kq);
-int kfd_dqm_evict_pasid(struct device_queue_manager *dqm, u32 pasid);
+int kfd_evict_process_device(struct kfd_process_device *pdd);
 int kfd_dqm_suspend_bad_queue_mes(struct kfd_node *knode, u32 pasid, u32 doorbell_id);
 
 /* Process Queue Manager */
@@ -1486,7 +1487,7 @@ int kfd_event_create(struct file *devkfd, struct kfd_process *p,
 int kfd_get_num_events(struct kfd_process *p);
 int kfd_event_destroy(struct kfd_process *p, uint32_t event_id);
 
-void kfd_signal_vm_fault_event(struct kfd_node *dev, u32 pasid,
+void kfd_signal_vm_fault_event(struct kfd_process_device * pdd,
 				struct kfd_vm_fault_info *info,
 				struct kfd_hsa_memory_exception_data *data);
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 87cd52cf4ee9..de963b8b2e09 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -282,8 +282,8 @@ static int kfd_get_cu_occupancy(struct attribute *attr, char *buffer)
 	cu_cnt = 0;
 	proc = pdd->process;
 	if (pdd->qpd.queue_count == 0) {
-		pr_debug("Gpu-Id: %d has no active queues for process %d\n",
-			 dev->id, proc->pasid);
+		pr_debug("Gpu-Id: %d has no active queues for process pid %d\n",
+			 dev->id, (int)proc->lead_thread->pid);
 		return snprintf(buffer, PAGE_SIZE, "%d\n", cu_cnt);
 	}
 
@@ -327,12 +327,9 @@ static int kfd_get_cu_occupancy(struct attribute *attr, char *buffer)
 static ssize_t kfd_procfs_show(struct kobject *kobj, struct attribute *attr,
 			       char *buffer)
 {
-	if (strcmp(attr->name, "pasid") == 0) {
-		struct kfd_process *p = container_of(attr, struct kfd_process,
-						     attr_pasid);
-
-		return snprintf(buffer, PAGE_SIZE, "%d\n", p->pasid);
-	} else if (strncmp(attr->name, "vram_", 5) == 0) {
+	if (strcmp(attr->name, "pasid") == 0)
+		return snprintf(buffer, PAGE_SIZE, "%d\n", 0);
+	else if (strncmp(attr->name, "vram_", 5) == 0) {
 		struct kfd_process_device *pdd = container_of(attr, struct kfd_process_device,
 							      attr_vram);
 		return snprintf(buffer, PAGE_SIZE, "%llu\n", atomic64_read(&pdd->vram_usage));
@@ -1056,8 +1053,8 @@ static void kfd_process_destroy_pdds(struct kfd_process *p)
 	for (i = 0; i < p->n_pdds; i++) {
 		struct kfd_process_device *pdd = p->pdds[i];
 
-		pr_debug("Releasing pdd (topology id %d) for process (pasid 0x%x)\n",
-				pdd->dev->id, p->pasid);
+		pr_debug("Releasing pdd (topology id %d, for pid 0x%0x)\n",
+			 pdd->dev->id, (int)p->lead_thread->pid);
 
 		kfd_process_device_destroy_cwsr_dgpu(pdd);
 		kfd_process_device_destroy_ib_mem(pdd);
@@ -1172,7 +1169,6 @@ static void kfd_process_wq_release(struct work_struct *work)
 
 	kfd_event_free_process(p);
 
-	kfd_pasid_free(p->pasid);
 	mutex_destroy(&p->mutex);
 
 	put_task_struct(p->lead_thread);
@@ -1523,12 +1519,6 @@ static struct kfd_process *create_process(const struct task_struct *thread)
 	atomic_set(&process->debugged_process_count, 0);
 	sema_init(&process->runtime_enable_sema, 0);
 
-	process->pasid = kfd_pasid_alloc();
-	if (process->pasid == 0) {
-		err = -ENOSPC;
-		goto err_alloc_pasid;
-	}
-
 	err = pqm_init(&process->pqm, process);
 	if (err != 0)
 		goto err_process_pqm_init;
@@ -1582,8 +1572,6 @@ static struct kfd_process *create_process(const struct task_struct *thread)
 err_init_apertures:
 	pqm_uninit(&process->pqm);
 err_process_pqm_init:
-	kfd_pasid_free(process->pasid);
-err_alloc_pasid:
 	kfd_event_free_process(process);
 err_event_init:
 	mutex_destroy(&process->mutex);
@@ -1722,15 +1710,18 @@ int kfd_process_device_init_vm(struct kfd_process_device *pdd,
 	if (ret)
 		goto err_init_cwsr;
 
-	ret = amdgpu_amdkfd_gpuvm_set_vm_pasid(dev->adev, avm, p->pasid);
-	if (ret)
-		goto err_set_pasid;
+	if (unlikely(!avm->pasid)) {
+		dev_warn(pdd->dev->adev->dev, "WARN: vm %p has no pasid associated",
+			 avm);
+		goto err_get_pasid;
+	}
 
+	pdd->pasid = avm->pasid;
 	pdd->drm_file = drm_file;
 
 	return 0;
 
-err_set_pasid:
+err_get_pasid:
 	kfd_process_device_destroy_cwsr_dgpu(pdd);
 err_init_cwsr:
 	kfd_process_device_destroy_ib_mem(pdd);
@@ -1816,25 +1807,53 @@ void kfd_process_device_remove_obj_handle(struct kfd_process_device *pdd,
 		idr_remove(&pdd->alloc_idr, handle);
 }
 
-/* This increments the process->ref counter. */
-struct kfd_process *kfd_lookup_process_by_pasid(u32 pasid)
+static struct kfd_process_device *kfd_lookup_process_device_by_pasid(u32 pasid)
 {
-	struct kfd_process *p, *ret_p = NULL;
-	unsigned int temp;
 
-	int idx = srcu_read_lock(&kfd_processes_srcu);
+	struct kfd_process_device *ret_p = NULL;
+	struct kfd_process *p;
+	unsigned int temp;
+	int i;
 
 	hash_for_each_rcu(kfd_processes_table, temp, p, kfd_processes) {
-		if (p->pasid == pasid) {
-			kref_get(&p->ref);
-			ret_p = p;
-			break;
+		for (i = 0; i < p->n_pdds; i++) {
+			if (p->pdds[i]->pasid == pasid) {
+				ret_p = p->pdds[i];
+				break;
+			}
 		}
+		if (ret_p)
+			break;
+	}
+
+	return ret_p;
+
+}
+
+/* This increments the process->ref counter. */
+struct kfd_process *kfd_lookup_process_by_pasid(u32 pasid,
+						 struct kfd_process_device **pdd)
+{
+	struct kfd_process_device *ret_p;
+
+	int idx = srcu_read_lock(&kfd_processes_srcu);
+
+	ret_p = kfd_lookup_process_device_by_pasid(pasid);
+	if (ret_p) {
+		if (pdd)
+			*pdd = ret_p;
+		kref_get(&ret_p->process->ref);
+
+		srcu_read_unlock(&kfd_processes_srcu, idx);
+		return ret_p->process;
 	}
 
 	srcu_read_unlock(&kfd_processes_srcu, idx);
 
-	return ret_p;
+	if (pdd)
+		*pdd = NULL;
+
+	return NULL;
 }
 
 /* This increments the process->ref counter. */
@@ -1990,7 +2009,7 @@ static void evict_process_worker(struct work_struct *work)
 	 */
 	p = container_of(dwork, struct kfd_process, eviction_work);
 
-	pr_debug("Started evicting pasid 0x%x\n", p->pasid);
+	pr_debug("Started evicting process pid 0x%x\n", (int)p->lead_thread->pid);
 	ret = kfd_process_evict_queues(p, KFD_QUEUE_EVICTION_TRIGGER_TTM);
 	if (!ret) {
 		/* If another thread already signaled the eviction fence,
@@ -2002,9 +2021,9 @@ static void evict_process_worker(struct work_struct *work)
 				     msecs_to_jiffies(PROCESS_RESTORE_TIME_MS)))
 			kfd_process_restore_queues(p);
 
-		pr_debug("Finished evicting pasid 0x%x\n", p->pasid);
+		pr_debug("Finished evicting process pid 0x%x\n", (int)p->lead_thread->pid);
 	} else
-		pr_err("Failed to evict queues of pasid 0x%x\n", p->pasid);
+		pr_err("Failed to evict queues of process pid 0x%x\n", (int)p->lead_thread->pid);
 }
 
 static int restore_process_helper(struct kfd_process *p)
@@ -2021,9 +2040,11 @@ static int restore_process_helper(struct kfd_process *p)
 
 	ret = kfd_process_restore_queues(p);
 	if (!ret)
-		pr_debug("Finished restoring pasid 0x%x\n", p->pasid);
+		pr_debug("Finished restoring process pid 0x%x\n",
+			 (int)p->lead_thread->pid);
 	else
-		pr_err("Failed to restore queues of pasid 0x%x\n", p->pasid);
+		pr_err("Failed to restore queues of process pid 0x%x\n",
+			(int)p->lead_thread->pid);
 
 	return ret;
 }
@@ -2040,7 +2061,7 @@ static void restore_process_worker(struct work_struct *work)
 	 * lifetime of this thread, kfd_process p will be valid
 	 */
 	p = container_of(dwork, struct kfd_process, restore_work);
-	pr_debug("Started restoring pasid 0x%x\n", p->pasid);
+	pr_debug("Started restoring process pasid 0x%x\n", (int)p->lead_thread->pid);
 
 	/* Setting last_restore_timestamp before successful restoration.
 	 * Otherwise this would have to be set by KGD (restore_process_bos)
@@ -2056,8 +2077,8 @@ static void restore_process_worker(struct work_struct *work)
 
 	ret = restore_process_helper(p);
 	if (ret) {
-		pr_debug("Failed to restore BOs of pasid 0x%x, retry after %d ms\n",
-			 p->pasid, PROCESS_BACK_OFF_TIME_MS);
+		pr_debug("Failed to restore BOs of process pid 0x%x, retry after %d ms\n",
+			 (int)p->lead_thread->pid, PROCESS_BACK_OFF_TIME_MS);
 		if (mod_delayed_work(kfd_restore_wq, &p->restore_work,
 				     msecs_to_jiffies(PROCESS_RESTORE_TIME_MS)))
 			kfd_process_restore_queues(p);
@@ -2073,7 +2094,7 @@ void kfd_suspend_all_processes(void)
 	WARN(debug_evictions, "Evicting all processes");
 	hash_for_each_rcu(kfd_processes_table, temp, p, kfd_processes) {
 		if (kfd_process_evict_queues(p, KFD_QUEUE_EVICTION_TRIGGER_SUSPEND))
-			pr_err("Failed to suspend process 0x%x\n", p->pasid);
+			pr_err("Failed to suspend process pid 0x%x\n", (int)p->lead_thread->pid);
 		signal_eviction_fence(p);
 	}
 	srcu_read_unlock(&kfd_processes_srcu, idx);
@@ -2087,8 +2108,8 @@ int kfd_resume_all_processes(void)
 
 	hash_for_each_rcu(kfd_processes_table, temp, p, kfd_processes) {
 		if (restore_process_helper(p)) {
-			pr_err("Restore process %d failed during resume\n",
-			       p->pasid);
+			pr_err("Restore process pid %d failed during resume\n",
+			       (int)p->lead_thread->pid);
 			ret = -EFAULT;
 		}
 	}
@@ -2143,7 +2164,7 @@ int kfd_process_drain_interrupts(struct kfd_process_device *pdd)
 	memset(irq_drain_fence, 0, sizeof(irq_drain_fence));
 	irq_drain_fence[0] = (KFD_IRQ_FENCE_SOURCEID << 8) |
 							KFD_IRQ_FENCE_CLIENTID;
-	irq_drain_fence[3] = pdd->process->pasid;
+	irq_drain_fence[3] = pdd->pasid;
 
 	/*
 	 * For GFX 9.4.3, send the NodeId also in IH cookie DW[3]
@@ -2173,7 +2194,7 @@ void kfd_process_close_interrupt_drain(unsigned int pasid)
 {
 	struct kfd_process *p;
 
-	p = kfd_lookup_process_by_pasid(pasid);
+	p = kfd_lookup_process_by_pasid(pasid, NULL);
 
 	if (!p)
 		return;
@@ -2295,7 +2316,7 @@ int kfd_debugfs_mqds_by_process(struct seq_file *m, void *data)
 
 	hash_for_each_rcu(kfd_processes_table, temp, p, kfd_processes) {
 		seq_printf(m, "Process %d PASID 0x%x:\n",
-			   p->lead_thread->tgid, p->pasid);
+			   p->lead_thread->tgid, (int)p->lead_thread->pid);
 
 		mutex_lock(&p->mutex);
 		r = pqm_debugfs_mqds(m, &p->pqm);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index c76db22a1000..1f98c16e0fe9 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -69,8 +69,8 @@ static int find_available_queue_slot(struct process_queue_manager *pqm,
 	pr_debug("The new slot id %lu\n", found);
 
 	if (found >= KFD_MAX_NUM_OF_QUEUES_PER_PROCESS) {
-		pr_info("Cannot open more queues for process with pasid 0x%x\n",
-				pqm->process->pasid);
+		pr_info("Cannot open more queues for process with pid 0x%x\n",
+			pqm->process->lead_thread->pid);
 		return -ENOMEM;
 	}
 
@@ -425,8 +425,8 @@ int pqm_create_queue(struct process_queue_manager *pqm,
 	}
 
 	if (retval != 0) {
-		pr_err("Pasid 0x%x DQM create queue type %d failed. ret %d\n",
-			pqm->process->pasid, type, retval);
+		pr_err("process pid 0x%x DQM create queue type %d failed. ret %d\n",
+			pqm->process->lead_thread->pid, type, retval);
 		goto err_create_queue;
 	}
 
@@ -520,7 +520,7 @@ int pqm_destroy_queue(struct process_queue_manager *pqm, unsigned int qid)
 		retval = dqm->ops.destroy_queue(dqm, &pdd->qpd, pqn->q);
 		if (retval) {
 			pr_err("Pasid 0x%x destroy queue %d failed, ret %d\n",
-				pqm->process->pasid,
+				pdd->pasid,
 				pqn->q->properties.queue_id, retval);
 			if (retval != -ETIME)
 				goto err_destroy_queue;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 3e2911895c74..a443c5d8ae1d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -563,7 +563,8 @@ svm_range_vram_node_new(struct kfd_node *node, struct svm_range *prange,
 	int r;
 
 	p = container_of(prange->svms, struct kfd_process, svms);
-	pr_debug("pasid: %x svms 0x%p [0x%lx 0x%lx]\n", p->pasid, prange->svms,
+	pr_debug("process pid: %x svms 0x%p [0x%lx 0x%lx]\n",
+		 (int)p->lead_thread->pid, prange->svms,
 		 prange->start, prange->last);
 
 	if (svm_range_validate_svm_bo(node, prange))
@@ -2969,7 +2970,7 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 		return -EFAULT;
 	}
 
-	p = kfd_lookup_process_by_pasid(pasid);
+	p = kfd_lookup_process_by_pasid(pasid, NULL);
 	if (!p) {
 		pr_debug("kfd process not founded pasid 0x%x\n", pasid);
 		return 0;
@@ -3232,7 +3233,8 @@ void svm_range_list_fini(struct kfd_process *p)
 	struct svm_range *prange;
 	struct svm_range *next;
 
-	pr_debug("pasid 0x%x svms 0x%p\n", p->pasid, &p->svms);
+	pr_debug("process pid 0x%x svms 0x%p\n", (int)p->lead_thread->pid,
+		 &p->svms);
 
 	cancel_delayed_work_sync(&p->svms.restore_work);
 
@@ -3255,7 +3257,8 @@ void svm_range_list_fini(struct kfd_process *p)
 
 	mutex_destroy(&p->svms.lock);
 
-	pr_debug("pasid 0x%x svms 0x%p done\n", p->pasid, &p->svms);
+	pr_debug("process pid 0x%x svms 0x%p done\n",
+		(int)p->lead_thread->pid, &p->svms);
 }
 
 int svm_range_list_init(struct kfd_process *p)
@@ -3618,8 +3621,8 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
 	bool flush_tlb;
 	int r, ret = 0;
 
-	pr_debug("pasid 0x%x svms 0x%p [0x%llx 0x%llx] pages 0x%llx\n",
-		 p->pasid, &p->svms, start, start + size - 1, size);
+	pr_debug("process pid 0x%x svms 0x%p [0x%llx 0x%llx] pages 0x%llx\n",
+		 (int)p->lead_thread->pid, &p->svms, start, start + size - 1, size);
 
 	r = svm_range_check_attr(p, nattr, attrs);
 	if (r)
@@ -3727,8 +3730,8 @@ svm_range_set_attr(struct kfd_process *p, struct mm_struct *mm,
 out:
 	mutex_unlock(&process_info->lock);
 
-	pr_debug("pasid 0x%x svms 0x%p [0x%llx 0x%llx] done, r=%d\n", p->pasid,
-		 &p->svms, start, start + size - 1, r);
+	pr_debug("process pid 0x%x svms 0x%p [0x%llx 0x%llx] done, r=%d\n",
+		 (int)p->lead_thread->pid, &p->svms, start, start + size - 1, r);
 
 	return ret ? ret : r;
 }
-- 
2.25.1

