Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3EECC3DA6E
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jan 2024 15:56:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 328DC10E12A;
	Wed,  3 Jan 2024 15:56:58 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2068.outbound.protection.outlook.com [40.107.102.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 555B510E12A
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Jan 2024 15:56:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SNfc7n6kKoZQmtN0jb4wGCk+6EBPwLpr2zdZJDsJYrdE4QutkThdFE1g4x5QJXM7cb/4ptPsvuE3Q983GjwuLhFIOhP3pvtvRDTMdAhXCuLELpyiOwCBJ7Y2ggBIGLY+9W6Z78DpEebYEGVWvl5kiCv2+0MVcWVodv8vH363XZ4XtAhaVnFJeB7GbOkWDXkPvVRDJ8AJd790LxYJTUwSV88hS5PGVI4aPW4Qw81sS4iCXwAwvX+GKMLz+Heho5aBXFqO/wiZC4MkTRaWL9waAz1oK1W+Y3gxtV64BKPryk9uA9P7KxZGIhi6/Q0YKQfNcasA7T08bsrYl7qIt4YiUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lR5iQN4NT+MJZeYrxfY8q/kZHMzOvo1XBv2hfHvTyF4=;
 b=P5OV1B13FOQVwxje1snEw6+TEHATlOeRXZuP/CuDSlHZSAcDLYgV4bH19F1VJeZK/S5Kv7f8qTV/N3c/bINs0MO+X8VNXooi5xuEMtZw2TM7X3h/+R/qNz5hZ9/+1qlEpNC2A6xYVgn6BjrLB1wF9ByA7aQSpiur+delv3fSDM80om6Oe0kMjrY6IJc8Mu9fyOSCWZ259+88GiuJlhLPSNtV5fVCeRVOJrcigNfUfUCafKOrU5W1oROlu56ntqFoDZnbJHj+jQW+ORXcV1cNjUy6v3mQwqaINbXVHNa5V/3b/c5Un9jfz2jDmkv6f/R3vz/v9fKanyVpLXyJX2bQFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lR5iQN4NT+MJZeYrxfY8q/kZHMzOvo1XBv2hfHvTyF4=;
 b=neLu0PRrc2gwSjQWb8RNsra7cd2dCwAqf8YK1uik+Kmo0+bBEQUer1kErfQbd5fT5HwYCiqb7/fzQYZ3tkVCL7VtNRRoaldbOpoLhsULdG/4zfh77EeTK/+pwTWC6dwmvoG7A2K3qzoCzejpXFoCfe58nnLLB34AYRUVFMWZeQk=
Received: from PH8PR05CA0012.namprd05.prod.outlook.com (2603:10b6:510:2cc::11)
 by CY8PR12MB7756.namprd12.prod.outlook.com (2603:10b6:930:85::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Wed, 3 Jan
 2024 15:56:53 +0000
Received: from SN1PEPF0002BA4C.namprd03.prod.outlook.com
 (2603:10b6:510:2cc:cafe::f9) by PH8PR05CA0012.outlook.office365.com
 (2603:10b6:510:2cc::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13 via Frontend
 Transport; Wed, 3 Jan 2024 15:56:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA4C.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7159.9 via Frontend Transport; Wed, 3 Jan 2024 15:56:53 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 3 Jan
 2024 09:56:52 -0600
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdkfd: Fix lock dependency warning with srcu
Date: Wed, 3 Jan 2024 10:56:28 -0500
Message-ID: <20240103155628.11347-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4C:EE_|CY8PR12MB7756:EE_
X-MS-Office365-Filtering-Correlation-Id: 9079897d-ca0d-4698-dd4d-08dc0c749ae5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fdMByWcyiw5+wP/ON6kOs6zElmOkcEQSPavnEbgmFIK8VKYMHII/HrM1Lp8AvzVYVlqGLc4/3mx1Ku1Hvi4MwWTywmxv15AX0EjEc59d42J+RN/IVzK4irHiFSZ/jFmCgDza0NsE1f8NSzTvmPfV4xEd3nZRy4vaKRiMAOx2DK5hY1X8w3Vkb6grX0trZKrp40YpDUwrPP19bnL05x8DKF3evlC8spplOOAoqn0+idInZbjRvQazkwPt+vdTWucirySEu/eTcJlVjz5k8Q9mfr2XoxWSugjR0SocAuxDuzCx3O9PJGnNEle455sB+8iBtqb/3JNBxykXfXU9AGI6dsV8pJmsUPV1NXFXM3naeZjCQ2INz1dC3OTyDWXipBId3jyG7A4DLSA9W9laTQbK17l0QXfbyfkil3hbfi15rWq4uh/l1muhTRIbEOy9nucIKJexNWSUQK6QBSGQ6hi/Kysg0g6kTG0/JjkxJwBLQmpmJOryX4aTQh5cUcCEjvMkiM8ZC5Atqu5kxfeoJSDIamgNnWlN7mCCtLY2oDNpJ53eO2/E9FEecxvTOqJUjEaIX9vKCwRn/CqAzdMuugyD/H9nVNvt47FqzYT+nFU3/F3Zi2luJvzPnKTOW4d4XJffDWR6sf1dVN641fYf1Y/lnSUXIyVl5wmTZL9opy4xuQyjIGL71l35Aqqm8OIyOwIpJREuTYJef25eAgFXbOk7rl6e2PhMcmcHOdcbNjlrSQXmxMt/lOjnUPyezY8L0AKU9MEdZ9NCAGWL9WG8oUTLRwbsr4tBMMcGzXooXZsM5/2fYrRU2gORZ5zgstQrWrv1
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(136003)(346002)(396003)(376002)(230273577357003)(230173577357003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(82310400011)(36840700001)(46966006)(40470700004)(2616005)(47076005)(1076003)(83380400001)(6666004)(26005)(81166007)(41300700001)(82740400003)(356005)(8936002)(5660300002)(8676002)(316002)(54906003)(4326008)(36860700001)(2906002)(478600001)(6916009)(7696005)(70586007)(70206006)(16526019)(336012)(426003)(86362001)(36756003)(40480700001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2024 15:56:53.3638 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9079897d-ca0d-4698-dd4d-08dc0c749ae5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7756
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
Cc: Philip Yang <Philip.Yang@amd.com>, Felix.Kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

======================================================
WARNING: possible circular locking dependency detected
6.5.0-kfd-yangp #2289 Not tainted
------------------------------------------------------
kworker/0:2/996 is trying to acquire lock:
        (srcu){.+.+}-{0:0}, at: __synchronize_srcu+0x5/0x1a0

but task is already holding lock:
        ((work_completion)(&svms->deferred_list_work)){+.+.}-{0:0}, at:
	process_one_work+0x211/0x560

which lock already depends on the new lock.

the existing dependency chain (in reverse order) is:

-> #3 ((work_completion)(&svms->deferred_list_work)){+.+.}-{0:0}:
        __flush_work+0x88/0x4f0
        svm_range_list_lock_and_flush_work+0x3d/0x110 [amdgpu]
        svm_range_set_attr+0xd6/0x14c0 [amdgpu]
        kfd_ioctl+0x1d1/0x630 [amdgpu]
        __x64_sys_ioctl+0x88/0xc0

-> #2 (&info->lock#2){+.+.}-{3:3}:
        __mutex_lock+0x99/0xc70
        amdgpu_amdkfd_gpuvm_restore_process_bos+0x54/0x740 [amdgpu]
        restore_process_helper+0x22/0x80 [amdgpu]
        restore_process_worker+0x2d/0xa0 [amdgpu]
        process_one_work+0x29b/0x560
        worker_thread+0x3d/0x3d0

-> #1 ((work_completion)(&(&process->restore_work)->work)){+.+.}-{0:0}:
        __flush_work+0x88/0x4f0
        __cancel_work_timer+0x12c/0x1c0
        kfd_process_notifier_release_internal+0x37/0x1f0 [amdgpu]
        __mmu_notifier_release+0xad/0x240
        exit_mmap+0x6a/0x3a0
        mmput+0x6a/0x120
        do_exit+0x322/0xb90
        do_group_exit+0x37/0xa0
        __x64_sys_exit_group+0x18/0x20
        do_syscall_64+0x38/0x80

-> #0 (srcu){.+.+}-{0:0}:
        __lock_acquire+0x1521/0x2510
        lock_sync+0x5f/0x90
        __synchronize_srcu+0x4f/0x1a0
        __mmu_notifier_release+0x128/0x240
        exit_mmap+0x6a/0x3a0
        mmput+0x6a/0x120
        svm_range_deferred_list_work+0x19f/0x350 [amdgpu]
        process_one_work+0x29b/0x560
        worker_thread+0x3d/0x3d0

other info that might help us debug this:
Chain exists of:
  srcu --> &info->lock#2 --> (work_completion)(&svms->deferred_list_work)

Possible unsafe locking scenario:

        CPU0                    CPU1
        ----                    ----
        lock((work_completion)(&svms->deferred_list_work));
                        lock(&info->lock#2);
			lock((work_completion)(&svms->deferred_list_work));
        sync(srcu);

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 2ac0c7788dfc..6c0e6d654a26 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -2340,8 +2340,10 @@ static void svm_range_deferred_list_work(struct work_struct *work)
 		mutex_unlock(&svms->lock);
 		mmap_write_unlock(mm);
 
-		/* Pairs with mmget in svm_range_add_list_work */
-		mmput(mm);
+		/* Pairs with mmget in svm_range_add_list_work. If dropping the
+		 * last mm refcount, schedule release work to avoid circular locking
+		 */
+		mmput_async(mm);
 
 		spin_lock(&svms->deferred_list_lock);
 	}
-- 
2.35.1

