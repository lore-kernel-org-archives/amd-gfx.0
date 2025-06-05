Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64056C5AE59
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Jun 2025 09:49:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1A8010E85D;
	Thu,  5 Jun 2025 09:49:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rTZSrYGj";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2059.outbound.protection.outlook.com [40.107.243.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66E2910E85D
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Jun 2025 09:49:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n2BAS2UW72em77/EUFxTRREj4rz7f8dhqu86lteAv5j9JpfMGSJrz2oMQPWDHiylQ6/+Ip4B++DHnhET5iB7av9a7o4ox240d+awtvBxfOexN3vcgnUtHfa97KG7/W1BHKhPFdO42RvvvPHEt5gP0eUlyQWctlJBI9jFhmmPl7yLiS0qdDzp3Q87JOor6NVMUHwCXiUMnOxprAmWw6DmOzb4Ry696hyPiTUPrrDfd4cwpKmr1ka1qJCnOFgfNbe/ZslEMZpEwvVr0KzumuIzWQjXvKtyL3wDBGg8A5IYC9Bd95f/IW7xDNcmjAQLe0kzHbkPNlvCTl1AAvkS9Veftw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ri2MlZYZTi/r3MH8uZx3PEY0A91fMo1+99a4xrktvPk=;
 b=ak/nm997LmhkB9csEiQOqb2gPdSt5Fbqp5rBOSxaegEQIwMV+NSHZZkIIH+AN1lmG6zHuVrJAgau2Ag3q0lc2rCZY7dcU3JhrqI/cMgz3gYEbbu1AfT0op/w/2lQNNDg0b2gnmqgZrngJJg7S6Cdq+5tNvyz8WL9r1jugQDdCJlu2OYUngNcjnHwOC4g7hhvY/xFDDuCbVUPuEyConpbILJCzQzM4ryBXmSMU26hh9KGERQr+siRZb9z04LHQP7hHIFlgHyC/9/B5uImqZmt8kaJ5N1ahPWmdzyIgotzH5r7RgwBpapqx6N1f7d2ZJdXwcdWw7XYROu+kp1nbD6CWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ri2MlZYZTi/r3MH8uZx3PEY0A91fMo1+99a4xrktvPk=;
 b=rTZSrYGjn17iHWBFdiBKmn5nHp7oj5jXf3xK1TgjqDRKmQbp2bYOMMQ1nTPC3PW+kmuj6b3MUrzsuPQpSpdE7wgHntyK/qL+E3e2stg6JyxJ2RP6PXMBlLs4rTLX44IzM9aXh0Pkmuvklx/iwwL5wgdVYvrSamrGJUqNm2z5gbM=
Received: from DSZP220CA0011.NAMP220.PROD.OUTLOOK.COM (2603:10b6:5:280::17) by
 MW4PR12MB7261.namprd12.prod.outlook.com (2603:10b6:303:229::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.34; Thu, 5 Jun
 2025 09:49:26 +0000
Received: from DS1PEPF00017099.namprd05.prod.outlook.com
 (2603:10b6:5:280:cafe::78) by DSZP220CA0011.outlook.office365.com
 (2603:10b6:5:280::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.35 via Frontend Transport; Thu,
 5 Jun 2025 09:49:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017099.mail.protection.outlook.com (10.167.18.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8792.29 via Frontend Transport; Thu, 5 Jun 2025 09:49:25 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 5 Jun
 2025 04:49:23 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Tao.Zhou1@amd.com>, <Hawking.Zhang@amd.com>, <YiPeng.Chai@amd.com>, "Ce
 Sun" <cesun102@amd.com>
Subject: [PATCH] drm/amdgpu: Fix the gpu recover deadlock issue in abnormal
 situations
Date: Thu, 5 Jun 2025 17:49:14 +0800
Message-ID: <20250605094914.83819-1-cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017099:EE_|MW4PR12MB7261:EE_
X-MS-Office365-Filtering-Correlation-Id: 9187fbb8-f1dc-4b54-8794-08dda416418e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?F1E985LssCHC6Xy0YWDslyZlhn8telvXwrbJQZwQIPsvWyUJBvtZbns9Zuuz?=
 =?us-ascii?Q?dMN0gZhgjcZfkNso8V4cH/+oWwuk5eHzf7z+QYjW+ECUevWE7WQn+sZaruvS?=
 =?us-ascii?Q?wQFy35TO/Xb5GIlDNVzsyo5qMXYXcfF8Km8R5V2c5b8iMV3WkglO6jMH2fVk?=
 =?us-ascii?Q?CP5ZuQlgubvx+CIhJD/FPkU8LIXGEOkeBcm8o9e9zD/sTqmNZWs1LBCmb3zW?=
 =?us-ascii?Q?vpyqp124r4IVd0EPO3j7ZexiJCYwQR62qqGRovNMHp/ukidOG5orvdFMwP7q?=
 =?us-ascii?Q?7/Ll5E9D+5SxtUXY4sgm3F45Lcu8MN0CPwX3LjqMLM9Xbl4CpUgjvL+XTPu8?=
 =?us-ascii?Q?tGXfcYjWoVM2xwQBMbN9q5qgj9nzPlt5SX6AF5WNiDTvnHUI3u6qYyEX3ZzP?=
 =?us-ascii?Q?/GLR/KtRoo173HZPxTD8J1sYIO9N+RQxNB58q63iDONzKdKwAaHXD5Kct5yi?=
 =?us-ascii?Q?nldsvXbYdoc9aUEV5OKr5KWMVrah3uvD+IT37VmF7fZNuoAaxu7rwzWquaAT?=
 =?us-ascii?Q?SQnlhIw2qFM/D97DVDLTc1L07r/rxE+vrSSuo2EadQVslSKko+TG4rIJKElK?=
 =?us-ascii?Q?D2yMTaUpH0wZlCWBkSKQX1bqvKgmB4xxfE3Jh0PMVXR5kXa5mzCuM/9cCylD?=
 =?us-ascii?Q?yLJjGnxHoGMRYMJoCFfXPPWR8EHanKdrKGjYMVpwK7sqHO0kx4rYGq173Ge6?=
 =?us-ascii?Q?mGlPtJhjrSY/obStcIla4CW+X48bv7JQSLXt746ZkGisRBJEAqEabKcbPh55?=
 =?us-ascii?Q?cxZ5t19bY9Xkea10nYN29sKvJprHIALQgW+/nGQDIGRtBQoCXa5ZmZvPM26p?=
 =?us-ascii?Q?4+7gD2IoxpezRTPptE99CbFbZ0TTN10aQM0uJFfqg9kidl0H//Oc4JVa796u?=
 =?us-ascii?Q?yXkXmdltidkslTvkbbpGE+5C+dqLrUXL57SmjPxiS5Bu6BUVHgpDm3oE0hIo?=
 =?us-ascii?Q?lRSogCcoXxW/1ggGjxE+LNodnveKgaTfC0jVKoZunFzP19F0ycNwU+NqpivQ?=
 =?us-ascii?Q?iAvhyqeMSDLFuhjRCY3L+3Eavu3YHrlem2LwGxcbcY6hKS03v5vunbzVFiqA?=
 =?us-ascii?Q?VSCZdUlgh0Dr/m2VuruieZhzkoVJVw8lF0WwRlyWWDRExAdNyhEJtTASs4A6?=
 =?us-ascii?Q?qj/kbcBXdfdypCf95sbgtcen1W8qlPIqiS9mmdcJFBUH2D7stoiu57XGDIGC?=
 =?us-ascii?Q?oTv0rqcwnR9eK5MxC5l/CXsxf3YuCi2gYtaR5UmJyb+gOfnke4QEiqZTO8cK?=
 =?us-ascii?Q?r9O1MwNHMI8vTT1FX65Q01tTjDw7FvmcX8J+WHZY9VEa32Sm0WUBCpFGbUD4?=
 =?us-ascii?Q?ORIhCc5MMYA8sCZ9rCuN+3XStnUqvnEfGkktgFBobpbsxsUhsRI0/e1PDHti?=
 =?us-ascii?Q?F7fxUQnJFbuDq1N8w/i3rW4NTGbXvYnqn58ZdAHwVsMRJ4Q2/NyzU1HvMhwu?=
 =?us-ascii?Q?r00PrLjWu/oYxeOgHVNH+AhO/fnuSMtqb/JtxdwFmCRBjx8k0mXYI2GaNRBq?=
 =?us-ascii?Q?f4II6V8jfxixC1G9n6o553doe+PYoLbafOcp?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2025 09:49:25.1770 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9187fbb8-f1dc-4b54-8794-08dda416418e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017099.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7261
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 2b84df8da61a..7fee5190fbcd 100644
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
-- 
2.34.1

