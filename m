Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F19BFC5AD49
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Jun 2025 03:54:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8424910E2A7;
	Fri,  6 Jun 2025 03:54:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="w0IkAhA8";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2073.outbound.protection.outlook.com [40.107.237.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E33F10E2A7
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Jun 2025 03:54:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ND4LUofke1o39iDT7C95rhMte7hokRU82VybsApD/ZauDgA0OCCiV4bHvfNV8aZRsq80GmuoJiI++sYcGiBhAw+03Q+adkt1tmX5BK4cs3r8SP1acu7cA6xKgDscF8KmaSPGTKSDEWGBowO0DJHbjnmKK72fHQwqGlgHeT8lXn4on0nn99OQITJQCogM6pQLCWsNkMg18Sxvqn6aGokzfsQVL0brdOP5hYK5Bzul7rQ9uLGRkeeKL06GfanzqcMZEQzJNiV/DVUbEgM+IO6nnLazZr5BKFg3d5PK8NO0gKadvrbFrMnoIuguuLvKaWVrMAkGs9b0O5CYs1TjsplZzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3/mMrAcBnkNarPO9Vz4/ruyDOKsYErxjYHtnpgTPoyM=;
 b=rtrEQayOFUH8XTobUT57LlNNlZtASTGE7XYGzIDSZnrEq5pd3GTs8P1y4sgD9HyvBGFYw7Dbl2u5vujQPSis12eZLFTZ5sVUpkHPZg3s71+W1z02qnZhpwayK29fMaz/Gvhc1uAe98BjpTzpre9y72l7zUyuyG2w4v3Ak/X5xPop5obYVu+8TJKpxnJFixvH4UVgfDtJrmb6ed1bev5TmQXCLKpA869qF+Ed1EZKX1gIMMVXdFf2/6BOrHffAMUOV6US6701nGBjGt/BUGX43Q4gOeknGe0FouTrs2/YdBip/0vvCBwiGjTgNy8kHmflBm+T7zsjUzUmRlQQxQlsKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3/mMrAcBnkNarPO9Vz4/ruyDOKsYErxjYHtnpgTPoyM=;
 b=w0IkAhA8HoCrBGpI0FI1l5Jzs2SwZdr9HaXAFLk1Wl8StKCsFXwHjNM+dKPtIf8puV8IwzB7QFe8nUKdqL+sEziXdpqdMrQE4xLq39bG80q2CIkAQVAJPqfkGOVVqySnXXfmtZ9Cj+sqguSG/f/mPwWJ91uhn/5/1W8P8Tay/LY=
Received: from PH7PR17CA0013.namprd17.prod.outlook.com (2603:10b6:510:324::6)
 by MW3PR12MB4379.namprd12.prod.outlook.com (2603:10b6:303:5e::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Fri, 6 Jun
 2025 03:54:28 +0000
Received: from CY4PEPF0000E9D1.namprd03.prod.outlook.com
 (2603:10b6:510:324:cafe::7f) by PH7PR17CA0013.outlook.office365.com
 (2603:10b6:510:324::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.23 via Frontend Transport; Fri,
 6 Jun 2025 03:54:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D1.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8792.29 via Frontend Transport; Fri, 6 Jun 2025 03:54:28 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 5 Jun
 2025 22:54:26 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Tao.Zhou1@amd.com>, <Hawking.Zhang@amd.com>, <YiPeng.Chai@amd.com>, "Ce
 Sun" <cesun102@amd.com>
Subject: [PATCH v2] drm/amdgpu: Fix the gpu recover deadlock issue in abnormal
 situations
Date: Fri, 6 Jun 2025 11:54:12 +0800
Message-ID: <20250606035412.145081-1-cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D1:EE_|MW3PR12MB4379:EE_
X-MS-Office365-Filtering-Correlation-Id: 746c14bc-5f8e-4c7f-5db2-08dda4add5ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nA+FxNUcsMgh/sSKFRVsWtOuQXbgDLn4xuvLYL+p92gBADnbeEt27bE9az8d?=
 =?us-ascii?Q?Y/yuaUeb42zuFjIJYFlZaf+Pvlt/byuYnkHww3auBbL84d58vASTYa98v8+4?=
 =?us-ascii?Q?h4QCngTEHs/m/g2vcPu4sgCUFr4lUnEAd2AkD6gG4n5X37Pb6YuMZnigRW6f?=
 =?us-ascii?Q?AiO4YNWy1iYg6E2iWGZhoTjgEzPp84JlUeg608NwColVAm05+qfRNNlYox/Q?=
 =?us-ascii?Q?Pcv/0kSL5RTpdAIHkacsP9OIW7vKAQ/iecXG+NfcwoerCDle+EnErKlpMdM7?=
 =?us-ascii?Q?KpAzwP0B5q5ltIs7o7IVadJlrc4CEdKWLKljJ40hdLYRun/FO6R2PM86U0v7?=
 =?us-ascii?Q?3/sY3aOq/XOHzM1bH/yMeizwDKekBOxeSfEfgZWpohaIJNy4sX8XzBri3p8M?=
 =?us-ascii?Q?PhzD7FRLRy8hVeIFeGurk0mnVtaezhpxQtUMo6I011ABGdM0dzMnwWRSFGlY?=
 =?us-ascii?Q?Tqj76n2k/IaLIXC2a6j31SdgNJYzZ7gK2gwJs2mOWbJXSdNngQqcR8eIWQiX?=
 =?us-ascii?Q?lUxSabEYERkaBn4SiHdHRcl0r4GIts2fdaBu80VoBfC5eiEhY17XHb/p+bT/?=
 =?us-ascii?Q?eQqClTHmOmZoZ0qpwit7sYzWjROrICnuoN8cThX4repjdv3+SxKENvg0y/Ww?=
 =?us-ascii?Q?s0vE8VI1+rg9VuAhPHcQfnEgi+q6jQD+BF7pcJHUFc7aXLO1Ud3StXlF9giR?=
 =?us-ascii?Q?J3YUj7m2JmOw/iI+a39qD/2ivxZmJ7enn4NW63iIgUrTurOHV4kiKaIdAU1e?=
 =?us-ascii?Q?TePlkohbaUtH0i5U6RGuPk4tugV6E1BxrdVr7xZj+KGWT02SZTv/ZqWe9VfA?=
 =?us-ascii?Q?USzs25Md/AgPV9sCRiy9KzVkdi+mR6L/dHPjsF1MFkXUQk+CLwvQWHpRk6WB?=
 =?us-ascii?Q?vsSdYsRUncHFa+i61Ev4d1Vnu2HV3AimdidrVdcmNKN2BqImlsgSpy/fZH67?=
 =?us-ascii?Q?uSa4465CbHsOEUFU7YcxYjW5sYbgKi0UX3xFpODUE6NqWyVMrXtqrf0rdRRN?=
 =?us-ascii?Q?w01FjsYkCta4YCJnpYzA2q6wGOUHgIZVQjtXu8haTEsGFZFkRA70SiCktWSh?=
 =?us-ascii?Q?1Xyw5HAnfP57fm3rNUNLoGHljXGlxZ+z1tp+TVlIZFI17twfn8yXtFOwcWaY?=
 =?us-ascii?Q?gd5vRISs3Obz3i7/zsLC9KYZ83zozYUbfsxO3c5jIP0DubII+rz5sPH41kj4?=
 =?us-ascii?Q?tnmr0vdtm2tx5y40xgAqu7q/FDH5TNoKFtGZcMyJA/v0tsko+yGQ9wsKYuSY?=
 =?us-ascii?Q?9MBJK2wbAI2XW8zg7LmKInYbHK/DPgdR6VYtE7DnpqV9DDo5NGU6RGeIMXcz?=
 =?us-ascii?Q?vB0ixN3R3lge6rkBGLkkBiCxipz7xqU4MFW4wwdllaRiywLBanR1SyjMHV4n?=
 =?us-ascii?Q?3zUq5nHd2FfIiPHKWSRtcty+1avQ40F+kmGFFooaJgfO7ju6AruBcADHhNsm?=
 =?us-ascii?Q?0HOYnGVTIQiQNizMFUfzcEJnE0qRAUn3xw3wYHcyCBpA2bkPdpJTMhsQtOUI?=
 =?us-ascii?Q?NY5ZGoRSIKB62hbTml3HE5Gc4FnDi9Myv/Ng?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2025 03:54:28.1003 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 746c14bc-5f8e-4c7f-5db2-08dda4add5ef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4379
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 2b84df8da61a..f5e69132bce8 100644
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
@@ -6938,8 +6933,10 @@ pci_ers_result_t amdgpu_pci_slot_reset(struct pci_dev *pdev)
 		if (hive) {
 			list_for_each_entry(tmp_adev, &device_list, reset_list)
 				amdgpu_device_unset_mp1_state(tmp_adev);
-			amdgpu_device_unlock_reset_domain(adev->reset_domain);
 		}
+		tmp_adev = list_first_entry(&device_list, struct amdgpu_device,
+						reset_list);
+		amdgpu_device_unlock_reset_domain(tmp_adev->reset_domain);
 	}
 
 	if (hive) {
-- 
2.34.1

