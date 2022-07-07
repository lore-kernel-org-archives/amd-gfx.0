Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3C65C43334
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Jul 2022 21:24:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 70CCF11A2B3;
	Thu,  7 Jul 2022 21:24:15 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2069.outbound.protection.outlook.com [40.107.244.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7CA4E113F64
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Jul 2022 21:24:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NjjndzAM3Ah/FaNf9yM2WDIYv4lLJtrA8Tim0/dU4geGdYVM0q8a4fnO9ZJ/8Fko7Dz//T+ZMxGY2J0itd59GYPG7T3tOfSGDh6BEfapRnoPmPKipyqHLnTPhi1y7YsjoktWXcT2MTn3pyNRFrW7HtisPEz3ENC24VFaRGvPijya8kyPaHa1TsJuVfPafrWcG7DOo0uwLoKdBXeX7DfqcpAksWzCXnel8aO0qXU0QUZORr9Dxje/Q3eQK8zGCdPR4XlYrw8Z8ILFmRZ6HYSPsPwPzwiaFtsYmHH1V9S7DUHkOX8fSlpEPNmFrHoh4fzQQpBimhm8Ks5Ucc4yovkY8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XjahOqSGsZxWrNOrCOPMXBSCH3yj5Sboov7hgBG8ZS8=;
 b=myeq13wof+eB9yUlVNNe5kS2hs//rmXal4lrlqA3a9T59WbZr1nOsv5AApIglJmOX3cdF3S/agU1cL9yD5dheJsIEW2IGnp7WLx/CAAKCDkeg5EiBgEoVSlyuvY+JAYgBL8DTqrXDAlyeH7JzKmSk05h4Jx4C5wyr44Cuw4zR+zZZv/7e3ci2RHm2XDkeDU+/cTymEY2iNvsWJcnGDYBe6D1zq1F9mlOh7hNrftgNMzRjcyZKlot/eopGDunEdrksC9D7wR7lbKHhN4ZgNWcKPNilqj47QJ4eVy1JDB/CpebHTsZuCdikIUoGXD2yuGCcahrTbpiU10r7d54gvpmdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XjahOqSGsZxWrNOrCOPMXBSCH3yj5Sboov7hgBG8ZS8=;
 b=w+2d3eadbrldHH1b9dVXuyw1zuxCjiY6tzBbdMjhM7uY1TiHpmrOiLqNQVqrYncMvtbyNjfxtP2vUWMOHmakX9uxz9wYaNLtHQc7PGjJZXUuO/cUoPw/7h1nu/SriHgnoL5/ypDH3MbacsKp7W3Ajq30wHCe6+g6vf2GAeMhrFY=
Received: from BN9PR03CA0527.namprd03.prod.outlook.com (2603:10b6:408:131::22)
 by BYAPR12MB3208.namprd12.prod.outlook.com (2603:10b6:a03:13b::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Thu, 7 Jul
 2022 21:24:12 +0000
Received: from BN8NAM11FT005.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:131:cafe::14) by BN9PR03CA0527.outlook.office365.com
 (2603:10b6:408:131::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.17 via Frontend
 Transport; Thu, 7 Jul 2022 21:24:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT005.mail.protection.outlook.com (10.13.176.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Thu, 7 Jul 2022 21:24:11 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 7 Jul
 2022 16:24:10 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/1] drm/amdkfd: Process notifier release callback don't take
 mutex
Date: Thu, 7 Jul 2022 17:23:40 -0400
Message-ID: <20220707212340.23118-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3e4be2cb-3107-4bd1-46e8-08da605f090d
X-MS-TrafficTypeDiagnostic: BYAPR12MB3208:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uy9PaO6H0Ls05Mqo6o77Em8+pBMuKsL/uk2+T5hSerfla36yWlCg8cz/ZXGhN8PpIpSne3sNXc+Se0epiRHsCyPbFrCFApHxmpEJm9UZ/RoeK5dyibzAs0JdUQU/FONwed36uNJ3obcYxebJZKTKxvbdn6c/mmuC38bLTrKrFyd7XVxwAAwA+SSvVDOBUgw6t4oLYHQKreaJdPu2ejvr6CkUBYhzJyeU7mvzND6mwCfmvXDFKiBBo/uDhhNTNNJ/axZm9KxSy3veoKFGQJd8rCEfI+7krKw1JELPMEXhZr4VUQVagNml4D20JXt6HYFrQSMIZAM0UxRfijrqh32Tw/FgfFFVSpXCD9iDqmjoqy/r1UTF3goY5L1HeL+5PaAkmqsRbW+bON9/LRfilU4P9JPGcIA2hrRto3HjtrsAtMet/LTCvoI3ViaJiQXt1Vl6G4IdouA/woDxwlhXubtf9iyyLbFlC+/wi19EqIJJopVSN/lH4m/ffOXl654DTQtBEfXK4GNIUG9wMF3uvD+dAAF+Fiy+QGjjbtECZ6n183dN3uozaXjc7oWTuvNTyYZ4KYpx8A2F9c5JnP0yiiL0DhHyr2XhLEO6v+4PkND05fwwzU2FzvdSOMd6207unpdGFsbBtO4VrE9DaV+iLgggiP4VbdEmhkai3ceIhWs2lavOFpRVFKG7Joby1h/Wk+oNxSsoYXbQl3WwNo82C9bE8ULSIrQScIyyTPM2hEK/jtZZFK67xkUhF4LH+8DMCitQ+/yYnCgY0Mn2iG/J74QxCgNwpMoKXyuOFlK5uO/8AcRWRr+0EZCix8CifvXFGdgIsALI9TlipoemUcnpS/pD+rOiogZzxm5Z2vjwVxDTi36B08cH0l+1nHo4J6llmzb5
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(396003)(136003)(376002)(39860400002)(46966006)(40470700004)(36840700001)(5660300002)(81166007)(40480700001)(82740400003)(16526019)(336012)(186003)(82310400005)(83380400001)(54906003)(4326008)(316002)(47076005)(426003)(8676002)(36756003)(70206006)(34020700004)(36860700001)(356005)(70586007)(6916009)(40460700003)(8936002)(478600001)(26005)(2906002)(7696005)(86362001)(6666004)(41300700001)(1076003)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2022 21:24:11.5589 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e4be2cb-3107-4bd1-46e8-08da605f090d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT005.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3208
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
Cc: Philip Yang <Philip.Yang@amd.com>, felix.kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Move process queues cleanup to deferred work kfd_process_wq_release, to
avoid potential deadlock circular locking warning:

 WARNING: possible circular locking dependency detected
               the existing dependency chain (in reverse order) is:
      -> #2
        ((work_completion)(&svms->deferred_list_work)){+.+.}-{0:0}:
        __flush_work+0x343/0x4a0
        svm_range_list_lock_and_flush_work+0x39/0xc0
        svm_range_set_attr+0xe8/0x1080 [amdgpu]
        kfd_ioctl+0x19b/0x600 [amdgpu]
        __x64_sys_ioctl+0x81/0xb0
        do_syscall_64+0x34/0x80
        entry_SYSCALL_64_after_hwframe+0x44/0xae

      -> #1 (&info->lock#2){+.+.}-{3:3}:
        __mutex_lock+0xa4/0x940
        amdgpu_amdkfd_gpuvm_acquire_process_vm+0x2e3/0x590
        kfd_process_device_init_vm+0x61/0x200 [amdgpu]
        kfd_ioctl_acquire_vm+0x83/0xb0 [amdgpu]
        kfd_ioctl+0x19b/0x600 [amdgpu]
        __x64_sys_ioctl+0x81/0xb0
        do_syscall_64+0x34/0x80
       entry_SYSCALL_64_after_hwframe+0x44/0xae

      -> #0 (&process->mutex){+.+.}-{3:3}:
        __lock_acquire+0x1365/0x23d0
        lock_acquire+0xc9/0x2e0
        __mutex_lock+0xa4/0x940
        kfd_process_notifier_release+0x96/0xe0 [amdgpu]
        __mmu_notifier_release+0x94/0x210
        exit_mmap+0x35/0x1f0
        mmput+0x63/0x120
        svm_range_deferred_list_work+0x177/0x2c0 [amdgpu]
        process_one_work+0x2a4/0x600
        worker_thread+0x39/0x3e0
        kthread+0x16d/0x1a0

  Possible unsafe locking scenario:

      CPU0                    CPU1
        ----                    ----
   lock((work_completion)(&svms->deferred_list_work));
                                lock(&info->lock#2);
             lock((work_completion)(&svms->deferred_list_work));
   lock(&process->mutex);

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index fc38a4d81420..3c9cf9bdb63f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1115,6 +1115,15 @@ static void kfd_process_wq_release(struct work_struct *work)
 	struct kfd_process *p = container_of(work, struct kfd_process,
 					     release_work);
 
+	kfd_process_dequeue_from_all_devices(p);
+	pqm_uninit(&p->pqm);
+
+	/* Signal the eviction fence after user mode queues are
+	 * destroyed. This allows any BOs to be freed without
+	 * triggering pointless evictions or waiting for fences.
+	 */
+	dma_fence_signal(p->ef);
+
 	kfd_process_remove_sysfs(p);
 	kfd_iommu_unbind_process(p);
 
@@ -1179,20 +1188,8 @@ static void kfd_process_notifier_release(struct mmu_notifier *mn,
 	cancel_delayed_work_sync(&p->eviction_work);
 	cancel_delayed_work_sync(&p->restore_work);
 
-	mutex_lock(&p->mutex);
-
-	kfd_process_dequeue_from_all_devices(p);
-	pqm_uninit(&p->pqm);
-
 	/* Indicate to other users that MM is no longer valid */
 	p->mm = NULL;
-	/* Signal the eviction fence after user mode queues are
-	 * destroyed. This allows any BOs to be freed without
-	 * triggering pointless evictions or waiting for fences.
-	 */
-	dma_fence_signal(p->ef);
-
-	mutex_unlock(&p->mutex);
 
 	mmu_notifier_put(&p->mmu_notifier);
 }
-- 
2.35.1

