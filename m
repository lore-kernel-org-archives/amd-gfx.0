Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AF1AC43334
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jun 2022 21:57:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6319A1138D1;
	Wed, 15 Jun 2022 21:57:45 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2058.outbound.protection.outlook.com [40.107.220.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E96CD1138AE
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jun 2022 21:57:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kbVLzH3YFnL7OReekgcmMwAE8rWFXBv0XwVyVKkZUzxGkZX36X4MSiebPyhFj3WUPbWpYEgXh55YzBHh4WXRRiYbRg6fCRnnlvCX9yF3CKiG+t3cX3dzxJjKASZYqsB7F1adp7upcOm7oC2f4W0hVC2ja49B069O5/B+mcCwuCdGLdpk/8XMUmflE16Dg5GgWon5XrupDdl00xiRy/G1hSj4/rfnRaCyYw8Xu0hOhFwrpZUcYksq+9E8caxDjW4vDyY/AKlVDCgwTHVwlVMrQBxdUSGuNgZMaSeytZ8fc2UQmYGMOykgHmb+kQmC7a+ZOga0Hdnwwcto2ulsgi2Kng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cbGwxzWCRLkrDbdoWYDyBNvozh/QI3f3QCmCaNeB3RE=;
 b=FB/S730BLBSgIebfBpAIwnvWEQFFp6d9fn+5DvbXpqK9cTkecN+G6vfcGwLqBz8EpgwIpC8MtJnMVIMPekTkvArtHKPsEUtJppZBhm74Z1X0GJzjknOeOjciBpLMubpdPIvKhkP2LuVWYGYC0cL6LAHu7vMeVasMcFFIv2mXF6OIM6TCNGdAWEhE7R6pz7c84mvkJoXZW063y9ZqcbRavtlA5tWJmAbe2/I6hnD9jXgY2pH+vu6LGnRIvJrbo34aMr0MSqRYQSWJwKACV4XSXPcfA/XiE/vWRKE8vMvpTOv9whQX5UOWDEOjogkQkzLfmzd10gUJVxZmMJRLkblOZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cbGwxzWCRLkrDbdoWYDyBNvozh/QI3f3QCmCaNeB3RE=;
 b=wYKE1/xkH9u9B4MoIF6OuZKOqdmgWFt4InVkDmHzvViHOt+09KNsU6DuSyw7FTIb1zI92631t4aG8/8CoFPp2pvZmZ+0Pc+w4Cn9qJZaw8MNPl89UPuV1Dyqets0ye4Or5h9nBmvtj3bgmZpBMVacixPTVelF/nK2AHllu9TmqM=
Received: from DM5PR04CA0036.namprd04.prod.outlook.com (2603:10b6:3:12b::22)
 by BN6PR12MB1860.namprd12.prod.outlook.com (2603:10b6:404:100::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.16; Wed, 15 Jun
 2022 21:57:39 +0000
Received: from DM6NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:12b:cafe::db) by DM5PR04CA0036.outlook.office365.com
 (2603:10b6:3:12b::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.15 via Frontend
 Transport; Wed, 15 Jun 2022 21:57:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT032.mail.protection.outlook.com (10.13.173.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5332.12 via Frontend Transport; Wed, 15 Jun 2022 21:57:38 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 15 Jun
 2022 16:57:37 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdkfd: Free queue after unmap queue success
Date: Wed, 15 Jun 2022 17:56:51 -0400
Message-ID: <20220615215651.14502-2-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220615215651.14502-1-Philip.Yang@amd.com>
References: <20220615215651.14502-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 05c2e840-518b-4af2-4fd1-08da4f1a106d
X-MS-TrafficTypeDiagnostic: BN6PR12MB1860:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB18605A4ED3996990A95850F6E6AD9@BN6PR12MB1860.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LQcUYMKMBMbGUBti+jioOp7LWdZpbKt+R38LwKfzjXx08dX4w7NJifr04DCLLVq/9ORpaaMZsn8R4+wBxoQu/GRFAAr932BqM4tT/fNCrhSrtrzXLkD31C3GXFInXlZ21KmK3rB1C2Z0VYC1GZXDHOCh3+aIIVstTbyFpLbYMFsy7AyWXx+Spu68ngpRA964zQT2qeO4WfLI0fVJA46pmSvqoX7dYJgJmfPRaByQBlyGDmhLfdUkgReVOyKYky8Id0INj9oWbx5GVWErZcq+tXHuDsyy1lTy0YH+Uj5FIGdiQB4Hu63D0BYpbEbzCUc8P8HeosW77aU1f4E83crqxSxUg9oYsU28F4opxi0P1uEhXQOgsU3OQk+N0j2oHHd1D90GoZ8fNlzRc6AjPqNcphP/453Kbd5UR9/WQYFRBhi/IOyTnxEejdHvZleh9GDzAe1ibByXgIOwCRqxR98K6IfQOzIx4b8hXJcmoghMBV8wTEDh9w0AScqCqn/c4rzYehvWeS0wgKmkUJOV3EUAYBRUN4eGGwb7euxlah86nEK93PivKa96qbF45H3OUwW+SrVmxn6RlYiFEj7Bm2i/pQ6TZwVUu+e7Ki6duCNx0oY2NCnMz3nloXe5+6osIO/PLH8z+uYtXRdss8LzhSdPtOehHvXcBhg2ZdkVtJ0MSOa/98+3PzGJfKnpyeH38ENsJJNhDTkTQeLQuohWpnqoXA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(36840700001)(46966006)(40470700004)(2616005)(81166007)(7696005)(1076003)(26005)(316002)(82310400005)(2906002)(5660300002)(40460700003)(8936002)(36756003)(6916009)(8676002)(6666004)(4326008)(86362001)(356005)(16526019)(186003)(83380400001)(70586007)(70206006)(47076005)(508600001)(54906003)(426003)(36860700001)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2022 21:57:38.8752 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05c2e840-518b-4af2-4fd1-08da4f1a106d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1860
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
Cc: Philip Yang <Philip.Yang@amd.com>, Graham.Sider@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

After queue unmap or remove from MES successfully, free queue sysfs
entries, doorbell and remove from queue list. Otherwise, application may
destroy queue again, cause below kernel warning or crash backtrace.

For outstanding queues, either application forget to destroy or failed
to destroy, kfd_process_notifier_release will remove queue sysfs
entries, kfd_process_wq_release will free queue doorbell.

 refcount_t: underflow; use-after-free.
 WARNING: CPU: 7 PID: 3053 at lib/refcount.c:28
  Call Trace:
   kobject_put+0xd6/0x1a0
   kfd_procfs_del_queue+0x27/0x30 [amdgpu]
   pqm_destroy_queue+0xeb/0x240 [amdgpu]
   kfd_ioctl_destroy_queue+0x32/0x70 [amdgpu]
   kfd_ioctl+0x27d/0x500 [amdgpu]
   do_syscall_64+0x35/0x80

 WARNING: CPU: 2 PID: 3053 at drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_device_queue_manager.c:400
  Call Trace:
   deallocate_doorbell.isra.0+0x39/0x40 [amdgpu]
   destroy_queue_cpsch+0xb3/0x270 [amdgpu]
   pqm_destroy_queue+0x108/0x240 [amdgpu]
   kfd_ioctl_destroy_queue+0x32/0x70 [amdgpu]
   kfd_ioctl+0x27d/0x500 [amdgpu]

 general protection fault, probably for non-canonical address
0xdead000000000108:
 Call Trace:
  pqm_destroy_queue+0xf0/0x200 [amdgpu]
  kfd_ioctl_destroy_queue+0x2f/0x60 [amdgpu]
  kfd_ioctl+0x19b/0x600 [amdgpu]

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 27 +++++++++++--------
 .../amd/amdkfd/kfd_process_queue_manager.c    |  2 +-
 2 files changed, 17 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 67ae5b6385a2..d6914a78348d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -1875,6 +1875,21 @@ static int destroy_queue_cpsch(struct device_queue_manager *dqm,
 
 	}
 
+	if (q->properties.is_active) {
+		if (!dqm->dev->shared_resources.enable_mes) {
+			decrement_queue_count(dqm, qpd, q);
+			retval = execute_queues_cpsch(dqm,
+						      KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES, 0);
+			if (retval == -ETIME)
+				qpd->reset_wavefronts = true;
+		} else {
+			retval = remove_queue_mes(dqm, q, qpd);
+		}
+
+		if (retval)
+			goto failed_unmap_queue;
+	}
+
 	mqd_mgr = dqm->mqd_mgrs[get_mqd_type_from_queue_type(
 			q->properties.type)];
 
@@ -1888,17 +1903,6 @@ static int destroy_queue_cpsch(struct device_queue_manager *dqm,
 
 	list_del(&q->list);
 	qpd->queue_count--;
-	if (q->properties.is_active) {
-		if (!dqm->dev->shared_resources.enable_mes) {
-			decrement_queue_count(dqm, qpd, q);
-			retval = execute_queues_cpsch(dqm,
-						      KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES, 0);
-			if (retval == -ETIME)
-				qpd->reset_wavefronts = true;
-		} else {
-			retval = remove_queue_mes(dqm, q, qpd);
-		}
-	}
 
 	/*
 	 * Unconditionally decrement this counter, regardless of the queue's
@@ -1915,6 +1919,7 @@ static int destroy_queue_cpsch(struct device_queue_manager *dqm,
 
 	return retval;
 
+failed_unmap_queue:
 failed_try_destroy_debugged_queue:
 
 	dqm_unlock(dqm);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index dc00484ff484..99f2a6412201 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -419,7 +419,6 @@ int pqm_destroy_queue(struct process_queue_manager *pqm, unsigned int qid)
 	}
 
 	if (pqn->q) {
-		kfd_procfs_del_queue(pqn->q);
 		dqm = pqn->q->device->dqm;
 		retval = dqm->ops.destroy_queue(dqm, &pdd->qpd, pqn->q);
 		if (retval) {
@@ -439,6 +438,7 @@ int pqm_destroy_queue(struct process_queue_manager *pqm, unsigned int qid)
 		if (dev->shared_resources.enable_mes)
 			amdgpu_amdkfd_free_gtt_mem(dev->adev,
 						   pqn->q->gang_ctx_bo);
+		kfd_procfs_del_queue(pqn->q);
 		uninit_queue(pqn->q);
 	}
 
-- 
2.35.1

