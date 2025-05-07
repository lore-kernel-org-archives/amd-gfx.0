Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42305C3ABBF
	for <amd-gfx@archiver.kernel.org>; Wed,  7 May 2025 18:38:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E11689701;
	Wed,  7 May 2025 18:38:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ld3y9+MP";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2055.outbound.protection.outlook.com [40.107.243.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3087789701
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 May 2025 18:38:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t9fC1q5sbCEUq1BU3VCwMurR298QZus8RC+qVSLkLj/e/BpQrZ3/pKLpmrxv9Wc/80IXzbYFI2M8pkZaF1gH3P66gyQDr3+3X6q9JHPPnj9kv/TPL2HP3NIjT3+pDmX+xKEJ/oDUyjSwpK9vpuAPxzeXYeOgaScoT+YEiRCrsS323KX39JK+c4MN4j264z6zNRvneSkZ2piFyZFSb1ILxvaE/n9TlVqrhA4mP1PN17nI+XRbPvf4weVOd3Tyfx0I+4XAxCy3AmXTJztISGiJt/oqp5rSebiUx8QdtTnPhlldAUu34RClEwj5Z9WhjE2mPSojEvY25nYWfjMWgSsb+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DUkxyXLv3CMbvhWc+uWmVlU8QrXl3OpTZq2o9qQhX3o=;
 b=dRZ8IhlxGRpddHHX8Y+DqC70TN94R9EGy6XDo7FotrmhIpZ6GyWndc811Obxc/6euqP/kUjXwthCb263zMRVMK8Q0gKZUcPLr38oTyBFSn4vjsJ3PSAjP0aYWstNF2zFzmnishmVsMKKL2KVWM4uK/cMuUiZMaHVDGktyBeAXXEtfDyI6SVlhzv9ZYqpXmLEwdEaavqX8DvVYGRgWRQ8KRmv7l537C5IbbeOUN7rNR8k7/49av2IPUctJkWE/+RW8UtayhwGOKWo3sTnIjupLwNycozl3uuVx1I7cAn7Y7aLtCU4FII+3t2dUHyq5PSkhEI1TyWTsuULslDiYS/i9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DUkxyXLv3CMbvhWc+uWmVlU8QrXl3OpTZq2o9qQhX3o=;
 b=Ld3y9+MP76WXRrwbLaJDtaoG3Sd68BaGNkmhCjlTUlXwOQXVsVCNuHLmb3qslgKzywpkJpaypCE9BoJl/CwMvIsWmWfaqyoYS6paEMg+7l2NvjjRvJlZlabkInBTOrvRpKF7WXreph1AXZ8sCR/WFpsAEv7yPBYhM8RBVYzVZ+o=
Received: from BN7PR06CA0040.namprd06.prod.outlook.com (2603:10b6:408:34::17)
 by DM4PR12MB6061.namprd12.prod.outlook.com (2603:10b6:8:b3::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.23; Wed, 7 May 2025 18:37:50 +0000
Received: from BN1PEPF00004682.namprd03.prod.outlook.com
 (2603:10b6:408:34:cafe::53) by BN7PR06CA0040.outlook.office365.com
 (2603:10b6:408:34::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.20 via Frontend Transport; Wed,
 7 May 2025 18:37:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00004682.mail.protection.outlook.com (10.167.243.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Wed, 7 May 2025 18:37:50 +0000
Received: from rtg-Splinter.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 7 May
 2025 13:37:47 -0500
From: Arvind Yadav <Arvind.Yadav@amd.com>
To: <Christian.Koenig@amd.com>, <alexander.deucher@amd.com>,
 <sunil.khatri@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Arvind Yadav <Arvind.Yadav@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Arvind Yadav
 <arvind.yadav@amd.com>
Subject: [PATCH] drm/amdgpu: Fix NULL dereference in
 amdgpu_userq_restore_worker
Date: Thu, 8 May 2025 00:07:22 +0530
Message-ID: <20250507183722.76789-1-Arvind.Yadav@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004682:EE_|DM4PR12MB6061:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e02ab66-a00a-4e7f-3cee-08dd8d96452a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ekJ1MFJBTTAvdlp0OEZaSitEcndqSVdMSmJCSGRjdGZPTnNiMkdPQU96R0t2?=
 =?utf-8?B?dnVIWUdtZ25CMXpWWXZnZlRvNVU4SnVyaVA5NElwbkxHeE8zelY5d3pSbitp?=
 =?utf-8?B?SkRkVEl0V1hTZ2xLYUVYK2M1SlRuTEpHOGg2YnpRell1RHZzeTN0aW5uYnow?=
 =?utf-8?B?K09LV24rWHAyMFBtczU3cXVDRnN1N3F0WFlDYllhTjRjYnNkYTZjMVM1YnFj?=
 =?utf-8?B?QmlBTzFFS1p5Vk9oTTg5aE9pMTZKTkVqSlErNE9GNTRiMVRabW5JSkl6ZDkx?=
 =?utf-8?B?T2NlbmdSQ3RDS1BuemlUVHJiS0dhSzFHdlRDei9PRldGbkN6eGs2TGV4TjF2?=
 =?utf-8?B?d0lQdktXcFBjT2RhWWovOGZ1V1dKc3dFbzdxZDJRdnpsc3hFMEEyN0c3dHV0?=
 =?utf-8?B?T3dTMjk1MWVQNWRwWVN5VTAxVFFaWWdCRG82Ty90eFhXS3JuVTVISHd6VEUw?=
 =?utf-8?B?eStiVkZQOVBxVFVjaUJUeTJ3a2hYMG5wZ2ZnT3JKbENpcjlBZm5SVmlXbEJl?=
 =?utf-8?B?VG91SkdVL3RVVnhCdDNYdGwrZnhYekw2LzBSeXZ0YWNoZlRsK1ZyTEorTTM0?=
 =?utf-8?B?LzQva3AvakpwYnE4NW5uTlZnV25odUJzZ2VCUk1ZRkFRMk9qS0JHS3VMSUZz?=
 =?utf-8?B?ckxYOVRiL1FZRWdiVHBRNXkraWw1UkMyN0U0U0xvNXZYRkhMOFRpUjA0OWQv?=
 =?utf-8?B?d0NMcUF3alYwQWhvRVg4OUd6Vyt2SkZkdHlhcy9NUThja1d5U250d0RuWG53?=
 =?utf-8?B?Tnp6OFBtS2NtQSswREZ3d1N3bCt5OFF1a29mYTROVWlGb25WQTFGL3hJTzAr?=
 =?utf-8?B?cXA0Z2ZvdVJSdUFNaWloeUZBMlVJcjdnRnhxSmVhT3dteG85RURCUFVTODBD?=
 =?utf-8?B?eUJweUlwMGVlSTNNMk1UNG9mczJmYlAxTE5WdVFjWXRBQjZ2amRBTFFlOENa?=
 =?utf-8?B?TS8rdG1jVTZRMWlFcFlSQUgvdXVHWkJreEVweTZDZ0dSYXFyL2lQQUhKSVFT?=
 =?utf-8?B?S21QT3VVRDRtYmVxYTZEUFF4QTdWNGhXMTRsVjR5YS83MXV2K3VmdHM1NjM5?=
 =?utf-8?B?QkNCTnhndkhsSEExS20renlidC9nOUo4SVdpcTdYNXVicnZTQndmaDFralVi?=
 =?utf-8?B?OGp0ZTJaTUJNY2UyczNHMk5WN05TRmgrR2padTlsUjhlZUtZVkRBMDNLcjFH?=
 =?utf-8?B?enlSelJCQ2NkWEUxU0pkay9KVllzYkZQZmw1dXY1TWtXQ2lMYkV3OFVVY0RC?=
 =?utf-8?B?SVlPLzlKa0I2VXBPanUvbjZ0TXZ0WVZwcldDZUpROVpNazQxZ2k4MFRMZzN0?=
 =?utf-8?B?SjF6anBHVXZCeVdnUHBWdzhEcldnN3E3UHUvZlRLa2tMZVN6RjBFZm8rS3J3?=
 =?utf-8?B?ZXgxNkJyUXhxamJNZjhneFF0K200b0UzWHVqU1NHTXB4WDNMREk2Q1lNR0tJ?=
 =?utf-8?B?ZmhNdENyQU5jb0FNOGZxM1RZWHJoYjAySkVYMHFrdU9ieExwWE1BaFdXc0dQ?=
 =?utf-8?B?c2pwd09HRmpsQ3RPWS9mNHBwTWVPZm5nSE5IQTd6UndnNUFJVzBMTHVTQjhH?=
 =?utf-8?B?M2lhaHhzWlhPL1o5S2pZWEdKY0s2QUU0aU96ZHNqbjNOelNCWWZKeFAwWHJl?=
 =?utf-8?B?cURMS0pKRjc3NlVpbHVjREYxN01HWW5GK1k0c2JkNnJmQWt1eVlQVHhycWk4?=
 =?utf-8?B?K3AxTXMyTEd6czRUQ1FRVFNPT2xjdTFKanFHTjVrSUZNZDIvYUI4MFRKMDd4?=
 =?utf-8?B?azh6YnR6T2U0N2d0U1d3SUN5dVdpdnBOajFLK0NmUTU0aGRlVmM5TkhoMTNv?=
 =?utf-8?B?TDhSMmk5UHcxR2loOVlKWVhYNW1qQnBsTWRRanhWYlZrMDBReUVEZFNvM1Jt?=
 =?utf-8?B?eEFBM2luOFUyYUpFSkRzdjF5aXhYZVRXbE5lVm52VU92UmlqSjg5eXNNSVZP?=
 =?utf-8?B?aXh5ZEtwQVF2L1htWE83NjNIYzA3ZUZ1TXdwdmF0d05YMVhpU2VVbFA4bU03?=
 =?utf-8?B?S0dKRzF2VUljOFRoRk4yTU5ERkQ1ZEpNLzVKckYwME8zOWR3WTVMTmJadzF2?=
 =?utf-8?Q?ZsVVd6?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 18:37:50.1046 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e02ab66-a00a-4e7f-3cee-08dd8d96452a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004682.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6061
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

Switch cancel_delayed_work() to cancel_delayed_work_sync() to ensure
the delayed work has finished executing before proceeding with
resource cleanup. This prevents a potential use-after-free or
NULL dereference if the resume_work is still running during finalization.

BUG: kernel NULL pointer dereference, address: 0000000000000140
[  +0.000050] #PF: supervisor read access in kernel mode
[  +0.000019] #PF: error_code(0x0000) - not-present page
[  +0.000021] PGD 0 P4D 0
[  +0.000015] Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
[  +0.000021] CPU: 17 UID: 0 PID: 196299 Comm: kworker/17:0 Tainted: G     U             6.14.0-org-staging #1
[  +0.000032] Tainted: [U]=USER
[  +0.000015] Hardware name: Gigabyte Technology Co., Ltd. X570 AORUS ELITE/X570 AORUS ELITE, BIOS F39 03/22/2024
[  +0.000029] Workqueue: events amdgpu_userq_restore_worker [amdgpu]
[  +0.000426] RIP: 0010:drm_exec_lock_obj+0x32/0x210 [drm_exec]
[  +0.000025] Code: e5 41 57 41 56 41 55 49 89 f5 41 54 49 89 fc 48 83 ec 08 4c 8b 77 30 4d 85 f6 0f 85 c0 00 00 00 4c 8d 7f 08 48 39 77 38 74 54 <49> 8b bd f8 00 00 00 4c 89 fe 41 f6 04 24 01 75 3c e8 08 50 bc e0
[  +0.000046] RSP: 0018:ffffab1b04da3ce8 EFLAGS: 00010297
[  +0.000020] RAX: 0000000000000001 RBX: ffff930cc60e4bc0 RCX: 0000000000000000
[  +0.000025] RDX: 0000000000000004 RSI: 0000000000000048 RDI: ffffab1b04da3d88
[  +0.000028] RBP: ffffab1b04da3d10 R08: ffff930cc60e4000 R09: 0000000000000000
[  +0.000022] R10: ffffab1b04da3d18 R11: 0000000000000001 R12: ffffab1b04da3d88
[  +0.000023] R13: 0000000000000048 R14: 0000000000000000 R15: ffffab1b04da3d90
[  +0.000023] FS:  0000000000000000(0000) GS:ffff9313dea80000(0000) knlGS:0000000000000000
[  +0.000024] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  +0.000021] CR2: 0000000000000140 CR3: 000000018351a000 CR4: 0000000000350ef0
[  +0.000025] Call Trace:
[  +0.000018]  <TASK>
[  +0.000015]  ? show_regs+0x69/0x80
[  +0.000022]  ? __die+0x25/0x70
[  +0.000019]  ? page_fault_oops+0x15d/0x510
[  +0.000024]  ? do_user_addr_fault+0x312/0x690
[  +0.000024]  ? sched_clock_cpu+0x10/0x1a0
[  +0.000028]  ? exc_page_fault+0x78/0x1b0
[  +0.000025]  ? asm_exc_page_fault+0x27/0x30
[  +0.000024]  ? drm_exec_lock_obj+0x32/0x210 [drm_exec]
[  +0.000024]  drm_exec_prepare_obj+0x21/0x60 [drm_exec]
[  +0.000021]  amdgpu_vm_lock_pd+0x22/0x30 [amdgpu]
[  +0.000266]  amdgpu_userq_validate_bos+0x6c/0x320 [amdgpu]
[  +0.000333]  amdgpu_userq_restore_worker+0x4a/0x120 [amdgpu]
[  +0.000316]  process_one_work+0x189/0x3c0
[  +0.000021]  worker_thread+0x2a4/0x3b0
[  +0.000022]  kthread+0x109/0x220
[  +0.000018]  ? __pfx_worker_thread+0x10/0x10
[  +0.000779]  ? _raw_spin_unlock_irq+0x1f/0x40
[  +0.000560]  ? __pfx_kthread+0x10/0x10
[  +0.000543]  ret_from_fork+0x3c/0x60
[  +0.000507]  ? __pfx_kthread+0x10/0x10
[  +0.000515]  ret_from_fork_asm+0x1a/0x30
[  +0.000515]  </TASK>

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Sunil Khatri <sunil.khatri@amd.com>
Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index afbe01149ed3..711e190a6a82 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -774,7 +774,7 @@ void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr)
 	struct amdgpu_userq_mgr *uqm, *tmp;
 	uint32_t queue_id;
 
-	cancel_delayed_work(&userq_mgr->resume_work);
+	cancel_delayed_work_sync(&userq_mgr->resume_work);
 
 	mutex_lock(&userq_mgr->userq_mutex);
 	idr_for_each_entry(&userq_mgr->userq_idr, queue, queue_id) {
-- 
2.34.1

