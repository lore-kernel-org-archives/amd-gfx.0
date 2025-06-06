Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85492C5B543
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Jun 2025 02:31:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04B2810EA89;
	Fri,  6 Jun 2025 02:31:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="X29aWVxN";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2078.outbound.protection.outlook.com [40.107.244.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE1B910EA89
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Jun 2025 02:31:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qYlRpDwzGFIzIhT3264MJ+V5JyscXZLT4AQmfErIjKoOdCW3rkZJyouS4lozpgg082ETIisG4hZd5l2Iy0+hIWzniN2CxgSnOheetPzPrB+YIAIJY6FV9fhtUEFHSCHsjS7354sP1gk9mHGn8/j2CbHT0/rBtF5K+YwEp3vqz9HGGmdHASttIwFy0ptuND2FFgcQobBAs48EnOOuivHxBOcSSlDg9Z4GUQK6Z3ScfOJe28Qu5fWwfK90eo/2EWi0gq8pAM7ZHXosrWSL2jd8vd0egg0QmCKrdCVE0xdV4BR9EMGpnNZTq8GOLJUrKg+RKEOm0OusFPjKgAQTVwIKQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3/OcGLJ9ujToGvMIlvTPMbQyf0+ZARSdUgiZLj7CQfw=;
 b=WtWR0C1dqrs/NQfl5vYVmAAuYAYsL4GcUjkAFAouj04T+OPjUGiwN3rp2NoSaeHQrELmAphWekeZIroaT8kCx74a1vZwfAIYFVJoy+qlBDINPOgKIpFNDxHvyGXHqBlc7c42xjCBAbno5wM6rFrdyzBYtT/7WelbHMVFcTJCISiF2jEXOx0liWFbm87OLXnKVwK3tu5Lw/Fh5NYCg0zAsNNIIt2OAZp7/Q851UCtIy37cFDptJApmKl3LebhxHANVY+RRQ6S8KCMgeQENeBDUeGRy0r3Kvw/BkvUVy0zB6aQzVDmM8+Sht9euB50e7PQOS7SLMfzPT3bCm7oQDBPvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3/OcGLJ9ujToGvMIlvTPMbQyf0+ZARSdUgiZLj7CQfw=;
 b=X29aWVxN08bUPRjT9p+Igf/yA56UgoC4uw++wRJqVVC7+Mi3JYGp2n7/g9DK/YnOyHD4rbHHcBM5rw+/1AL2y1MJ3D+Be+OmMb306Ihk+Jg8Fs9lygfjw5wbUdHp8Ck5KNxjldb8qSBqS8JkBUgTFKgEioj+qRRvE0OSLKCn/q8=
Received: from SJ0PR13CA0170.namprd13.prod.outlook.com (2603:10b6:a03:2c7::25)
 by SA1PR12MB5658.namprd12.prod.outlook.com (2603:10b6:806:235::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.35; Fri, 6 Jun
 2025 02:31:22 +0000
Received: from CO1PEPF000044FD.namprd21.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::71) by SJ0PR13CA0170.outlook.office365.com
 (2603:10b6:a03:2c7::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.19 via Frontend Transport; Fri,
 6 Jun 2025 02:31:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.2 via Frontend Transport; Fri, 6 Jun 2025 02:31:22 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 5 Jun
 2025 21:31:18 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Tao.Zhou1@amd.com>, <Hawking.Zhang@amd.com>, <YiPeng.Chai@amd.com>, "Ce
 Sun" <cesun102@amd.com>
Subject: [PATCH] drm/amdgpu: Fix the gpu recover deadlock issue in abnormal
 situations
Date: Fri, 6 Jun 2025 10:31:10 +0800
Message-ID: <20250606023110.144842-1-cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FD:EE_|SA1PR12MB5658:EE_
X-MS-Office365-Filtering-Correlation-Id: cc9fb96c-4c9c-4ac0-91bc-08dda4a23a1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wYwrBFLy7l7CAcoECX+G84DOmYLREHX5J+hY6SsL/oUlvuLTEdLJP2vlAx8T?=
 =?us-ascii?Q?Zeyn4jkmFRjVorjIhpa7D5KZkHReuavN3+zn26pd551SS4U0n+wArkCyAE/G?=
 =?us-ascii?Q?FujLHVbn6GGD+w6Ww1MDvHprtw1a90E7AiGa31Gg6cSknuw7O6jOnzTP9WF7?=
 =?us-ascii?Q?Dv5/foSWnYTRbLcTS1HXWwz96+ufY+ll6H3MaIa+AEUE8dJq9JNLWaOPUKYZ?=
 =?us-ascii?Q?YEO0yWcCLw3uns4gjLE+j1435aaz6az6YE6cbSls+yBliZhkONx/SVIWwvQc?=
 =?us-ascii?Q?rw/SZP1C405Le58IPiOE5EvC/BZKxLE3Kw6u9/FuDm81s4a/1EETb2pUpcXt?=
 =?us-ascii?Q?ZOmqTDs8O9KwwZaEWfLxyWmFYik1qjyH8tbSIMfoNDYLhKBW52jmnTFQR3d1?=
 =?us-ascii?Q?XQDAAHUl/9W6JTbBDblUGIxQXx5aWcJg2TxrBZYZqhsjymqMSwHDwUQW2t3I?=
 =?us-ascii?Q?YkXN9vzlvOafvKLs6elq3Elw2sJs2KYzyrTPotcyRxx6QgFDuGefggCxanay?=
 =?us-ascii?Q?AjkrEJfQcZeEY0bIqREh6MGnEKHfm+zU0Iiifw3lejVytc92AKRXZ/ZvEk14?=
 =?us-ascii?Q?Q0o3rGjALGXesadZW3Qs9agzGt6aSxw6vdZTfdCJMa6aawDvfMRiNCwTqM1k?=
 =?us-ascii?Q?aZvaClR4O5d4aVg2cHiIsRsMRp9AG8fXjUi1X/6/4mFhwwYKApI4e6+x2dRp?=
 =?us-ascii?Q?Mzu4tozq+mja4PFERfuelB5WwgbIj8H0KKHRRa2gK4ehm5QilSLIOyCSraVx?=
 =?us-ascii?Q?D6ZPJDU7BmoE09T2eSNDSvDH+/D/z38eV/FT4UTaqhx00Jne65rHMDIkyhW2?=
 =?us-ascii?Q?w8Lvd5XVakKlSgwb+uQ4CEhE8+wA7V04SmOsnXWBBlxUGKMS5P+6TbNcpCK1?=
 =?us-ascii?Q?5NnnjTo7ItYjlICdkSXH9wot5cgAbDUb+PqmTINU5Kt6uWRoYyyBAhi+sh35?=
 =?us-ascii?Q?SxoQMyCNwLaQ9aeJSMQf4nXlejZOXTY7iF6V5GX/s7QTSjA2Dl5ObuAUBZHu?=
 =?us-ascii?Q?tfL/HycgMK+BC3Oa/xYTcDR/3ZTLrz0Cb2iaP+JaJG4q6BLfoWVaV3wUOBz6?=
 =?us-ascii?Q?LTGzmtoHNyr/3nfk7N6Oi8zCGe8K4mLCAEz3v4Tqt0bYNZOznJ+DQOr7tu3T?=
 =?us-ascii?Q?Vsyuq0iVc6fzAqz7GTwJFhJTcExAgmKRK9H7GocaD012NoHaVSfIUd7Mp5t5?=
 =?us-ascii?Q?19ZsMm/7Rd6jL8k68lRU3GjJj3HHT8QjmnWP8zxChdkpuL6BPGqI+PpsWPFK?=
 =?us-ascii?Q?uYDTQCDaNJ0n/ZGLtJ+3n6GPEH0h/qtYDpwQGokxfV17+JH1GKDQqR1Uu5qp?=
 =?us-ascii?Q?Dgz3Z+xchTrVD5ef6vl1yCtxUPT95ZBQmcUwMFqlJ+2JfrRDgHavJSlIBb7R?=
 =?us-ascii?Q?xuKmGscwf013zfj6C0SL2UruWuuLAc7lDrhTyg8aumI4k2KN4/UlmXZyukkh?=
 =?us-ascii?Q?yFxQ5vW+5ZwuRD+eM8eySMB1NqEP9nFLGUoBk9a5HgoN0NVcneJnulOLtgE/?=
 =?us-ascii?Q?NDSmhO6QVpRh5mMIaN71Gi04SeRGHdX05isZ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2025 02:31:22.1625 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cc9fb96c-4c9c-4ac0-91bc-08dda4a23a1c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FD.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5658
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

rma occurred in the RAS records exceed threshold device. When the
device was performing gpu recover, the reset domain lock was not
released, resulting in kernel panic

[  630.141619] INFO: task umc_page_retire:9472 blocked for more than 122 seconds.
[  630.157663]       Tainted: G           OE      6.9.0-0_fbk6_brcmrdma11_125_gfecec9d12677 #1
[  630.176213] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  630.193591] task:umc_page_retire state:D stack:0     pid:9472  tgid:9472  ppid:2      flags:0x00004000
[  630.214251] Call Trace:
[  630.219673]  <TASK>
[  630.224326]  __schedule+0x589/0xad0
[  630.232070]  schedule+0x67/0xb0
[  630.239038]  schedule_timeout+0x22/0x100
[  630.247740]  ? __smp_call_single_queue+0x36/0x100
[  630.258195]  ? wake_up_process+0x7df/0x1190
[  630.267477]  ? wait_for_common+0xa4/0x150
[  630.276371]  wait_for_common+0x99/0x150
[  630.284881]  __flush_work.llvm.6727378282878825097+0x20a/0x290
[  630.297826]  ? rcu_work_rcufn+0x20/0x20
[  630.306338]  amdgpu_ras_page_retirement_thread+0x469/0x4e0 [amdgpu]
[  630.320344]  ? amdgpu_ras_do_recovery+0x5f0/0x5f0 [amdgpu]
[  630.332587]  kthread+0xdd/0x120
[  630.339552]  ? __sched_group_set_shares+0x160/0x160
[  630.350373]  ret_from_fork+0x2f/0x40
[  630.358303]  ? __sched_group_set_shares+0x160/0x160
[  630.369128]  ret_from_fork_asm+0x11/0x20
[  630.377831]  </TASK>
[  630.382796] INFO: task kworker/u1536:1:10591 blocked for more than 123 seconds.
[  630.399018]       Tainted: G           OE      6.9.0-0_fbk6_brcmrdma11_125_gfecec9d12677 #1
[  630.417554] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  630.434935] task:kworker/u1536:1 state:D stack:0     pid:10591 tgid:10591 ppid:2      flags:0x00004000
[  630.455594] Workqueue: amdgpu-reset-hive amdgpu_ras_do_recovery [amdgpu]
[  630.470537] Call Trace:
[  630.475958]  <TASK>
[  630.480609]  __schedule+0x589/0xad0
[  630.488347]  schedule+0x67/0xb0
[  630.495313]  schedule_preempt_disabled+0xa/0x10
[  630.505362]  rwsem_down_write_slowpath+0x2ba/0x510
[  630.515994]  down_write+0x2b/0x30
[  630.523346]  amdgpu_device_halt_activities+0xef/0x400 [amdgpu]
[  630.536363]  amdgpu_device_gpu_recover+0x124/0x230 [amdgpu]
[  630.548797]  amdgpu_ras_do_recovery+0x5af/0x5f0 [amdgpu]
[  630.560653]  process_scheduled_works+0x184/0x370
[  630.570900]  worker_thread+0xc6/0x3f0
[  630.579022]  ? __ipv6_chk_addr_and_flags.llvm.7715710786076949193+0x160/0x160
[  630.594857]  ? __ipv6_chk_addr_and_flags.llvm.7715710786076949193+0x160/0x160
[  630.610693]  kthread+0xdd/0x120
[  630.617660]  ? __sched_group_set_shares+0x160/0x160
[  630.628483]  ret_from_fork+0x2f/0x40
[  630.636413]  ? __sched_group_set_shares+0x160/0x160
[  630.647232]  ret_from_fork_asm+0x11/0x20

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 2b84df8da61a..6b82b5805e3d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -6305,7 +6305,6 @@ static void amdgpu_device_gpu_resume(struct amdgpu_device *adev,
 	tmp_adev = list_first_entry(device_list, struct amdgpu_device,
 					    reset_list);
 	amdgpu_device_unlock_reset_domain(tmp_adev->reset_domain);
-
 }
 
 
@@ -6396,12 +6395,8 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 	}
 
 	r = amdgpu_device_asic_reset(adev, &device_list, reset_context);
-	if (r)
-		goto end_reset;
 skip_hw_reset:
 	r = amdgpu_device_sched_resume(&device_list, reset_context, job_signaled);
-	if (r)
-		goto end_reset;
 skip_sched_resume:
 	amdgpu_device_gpu_resume(adev, &device_list, need_emergency_restart);
 end_reset:
@@ -6938,8 +6933,8 @@ pci_ers_result_t amdgpu_pci_slot_reset(struct pci_dev *pdev)
 		if (hive) {
 			list_for_each_entry(tmp_adev, &device_list, reset_list)
 				amdgpu_device_unset_mp1_state(tmp_adev);
-			amdgpu_device_unlock_reset_domain(adev->reset_domain);
 		}
+		amdgpu_device_unlock_reset_domain(adev->reset_domain);
 	}
 
 	if (hive) {
-- 
2.34.1

