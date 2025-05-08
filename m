Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8630CC3ABC0
	for <amd-gfx@archiver.kernel.org>; Thu,  8 May 2025 05:36:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 196FB10E324;
	Thu,  8 May 2025 05:36:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lIxSHKkh";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2089.outbound.protection.outlook.com [40.107.223.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C71A310E324
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 May 2025 05:36:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yE7FGklvD2RPZafgOBheIovIV1YR/I8OfW5cOoT80CkIRBB38sY/XveRuWaKl3mzYJcOWiVLqKV+dmb7EFk8oGALhe1KN4kwIaXLY0uSJVKyoZJ/bkD2NyFot4ki54+s6+H97mDhzd+m2KZNbeG52kWtkMtStJCdwa0gKRXHfGCM+mj6qQg0Abl1d+Is/QOEkYAmBtoig/qDN35imFxCe4gWzd+/+YhkFTyQsyTwpd+BaRgCfS9FwM6I9kMfgGOb2jVq0Qafz+nkxBnHvIjtHXfJa5NfJ6/kSdtbzGoQxebCR9ubtlYOW888B7hRx0369/QsvuXItiPtsP7kyaCQCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jiXY2URYvUQuMG5rUTtTr0+TLnVeJiIRvg0o9O1MaTA=;
 b=HWlpQSaNFnSc0ZFOgBovY2VmZt38j4tmXX3mdE5iDHRrFPyF4hhisLYH9QIjVK6KX4bVYbKnJK8LsgUUtbglZU+hcw3OEhl+vhg4mlBU7qifVutDBCdTC3N9/idso2fYQ6BAix9I+GCj4cfwRcesZepQYwglJzjQXeOwQhQIwfdEdD/d7pEJup81XMux4a2iyK3OXBVgllJGW4Q6uzOtK/jhlTg197PIQvGFYPFXXzf7oo7noE3S+6eOOnbqUIuOdqeJc3cH0xQ2pydKfHnIvSQt3u2vIUU0pcJg9JraDFMfXLEGeZ05lUpt+kAiWoaYcFQB+5AfZSQ+7Tg0crUi+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jiXY2URYvUQuMG5rUTtTr0+TLnVeJiIRvg0o9O1MaTA=;
 b=lIxSHKkhMtS8DDALesaqhgHmrybSdMT2Z+q56nuZhwYuiIz6/HIwa2vkRYIgwMwI855/O+V1LvTcRX91q82J0W0d+IRm0Fx4YtDSBlnAD3ZdLzhICCB+zpIlcS2mBwtFrt+Gj+IRmf18mjvI+ZtLF76Pm/BDA9sVsKRvYTjGmVQ=
Received: from BL0PR05CA0016.namprd05.prod.outlook.com (2603:10b6:208:91::26)
 by SA1PR12MB8119.namprd12.prod.outlook.com (2603:10b6:806:337::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.24; Thu, 8 May
 2025 05:36:03 +0000
Received: from BN2PEPF0000449E.namprd02.prod.outlook.com
 (2603:10b6:208:91:cafe::81) by BL0PR05CA0016.outlook.office365.com
 (2603:10b6:208:91::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.18 via Frontend Transport; Thu,
 8 May 2025 05:36:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF0000449E.mail.protection.outlook.com (10.167.243.149) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Thu, 8 May 2025 05:36:02 +0000
Received: from rtg-Splinter.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 8 May
 2025 00:35:59 -0500
From: Arvind Yadav <Arvind.Yadav@amd.com>
To: <Christian.Koenig@amd.com>, <alexander.deucher@amd.com>,
 <sunil.khatri@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Arvind Yadav <Arvind.Yadav@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Arvind Yadav
 <arvind.yadav@amd.com>
Subject: [PATCH v2] drm/amdgpu: Fix NULL dereference in
 amdgpu_userq_restore_worker
Date: Thu, 8 May 2025 11:05:38 +0530
Message-ID: <20250508053538.57744-1-Arvind.Yadav@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449E:EE_|SA1PR12MB8119:EE_
X-MS-Office365-Filtering-Correlation-Id: 821d7d7c-9e86-4a0f-60d4-08dd8df23856
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K2FKZlo5WmFvQ1UxL000NXhmM1A5dWNaWG41NkkzY0VMWjhuUU4vampXanBQ?=
 =?utf-8?B?NGE5Z0pIWmtjWng3MWpsZE9wNlNhTkZqckVXc01lTnJrczVCSHYxV09Wc3hw?=
 =?utf-8?B?azlxa3J4dkxsbnFxVFBNNy8wTGM3V0pqQW9xRkJ0QXkvcjRwMHMzUFZoR3ZQ?=
 =?utf-8?B?aVl4SlJMRGFSRlN0TGUzVFE1UTlRWU5CaEJpNGVycjMrTEtYdCtiaDhNbUdU?=
 =?utf-8?B?Q0RzQ0o2TXdOL3JrVVNmTUROVGdVR3FzMnl1RGZUL08vTnl3c2RNUXhOUEFZ?=
 =?utf-8?B?aE1Id3pjQkhZZEd6UHg3NU80THhHVHhiUHdzR1I3YlZpOWgwa2lkaVZXMXRw?=
 =?utf-8?B?RWl0NVVscjUxVGVBK21IQnpoRzZtTjBUMCt0NHV2SEZlRjBXYm9aWUxkQnp1?=
 =?utf-8?B?OUFoQ0JFaVM1YmJ5dWhIeC8vQnRYbE1sOVhyU0RxKzJhazBORkdNLyt6WEVE?=
 =?utf-8?B?ZHc4V1U5TTFQeE52Tk5acXpxTHhDckRncE9yRVhTY1k1YWZVY3JwVjg4R3Zp?=
 =?utf-8?B?bXMwZlBFOFI3RDF4NXJUTkNYWURGQzB3SnR5WG5iNmtkcDJDZ1Q2aVp4aGhR?=
 =?utf-8?B?MmtXeDlBeEU2MkU5TStuczVIaWZQYlFmUkNSbm1QSXlTWDltdFhqZWVCMHlM?=
 =?utf-8?B?VVNRRnpXSmltK05IVUN3b3h4RUtsNVR1REpEb2I4K2RlKzZIcjJQelNwRkk3?=
 =?utf-8?B?Q1dWZDNFSENzdVpJamJWcU9CVitveDZFMXdvVCtlck9OYkdZZ3BZdURWZkRv?=
 =?utf-8?B?WWdwM2hIVmNGbjI4QmZxaDJNTVdYK0tXRkZDQm1FRm5mUmhlTnlWQUtjcjgr?=
 =?utf-8?B?TUtHSSt6dXptQXpuUjVmbnExRXhoOVNPSXBVTkU3TURCVk9wTE5CQjBHOEdh?=
 =?utf-8?B?cUxnVEhVd0UxYUxKZGlDb0NPR25FSGxkUmJwUkk4T0NML0hHWFFiYUE3cVFI?=
 =?utf-8?B?bHdhR0haczYwaThWQVFPVGhqU1podXR4YjlGbnhEWXFPMjNyelRLYnhnQXVV?=
 =?utf-8?B?SXMyNC9DVFpKT2N3TmJrRmNxSVRIQ21CcklKMGJRMm9jd1RjZnpTbEFMWDFy?=
 =?utf-8?B?RG5iVkdLUGNkWmNjUHJySTVCejJmUGRkYmVka2dxM095RmNnUUU3bkQ0TFhs?=
 =?utf-8?B?c083TUNDa2RVTG5NbWJ6Q25ZTHVGR3FpY3FKcXAwQmxwdlBrOFhXSEplQ3I3?=
 =?utf-8?B?UW1sS3pJS3BwRi9vTlNic0syblpMaXN1Wk5OVVBQVHUxWUVVTmxITzFSQ1o3?=
 =?utf-8?B?WldqaGl5MVV1dXRYSXpkNmFNMUZCN3ZJOWphOGZpakJuTDNRN0RrYUw5eWtB?=
 =?utf-8?B?REt0TVBTVjhocTFaRldDZzBTcG11TjYxR1NlUGM4ZVlIQVBTTkEyQmR1c0c2?=
 =?utf-8?B?MEV2ZTlVc2h4WDdpdjFqaVFRcGc2Qk5yNmNqQjJyVXRBZUxQaFp3QVB6WGZx?=
 =?utf-8?B?TzhFd2FnRFJhek56YzlzbDUyZUY3Wml6RjQ5TEtoRkpOOGRJbDFhakN4TDRh?=
 =?utf-8?B?K29UZXlkMUI5ZGZiWlRDbWlHMEVNMnpkdFFKRHRSUGlkQXppVlpudjZVcUdt?=
 =?utf-8?B?SmJVT3IyN0V1WmREMGIzZnRLSWt2OWtBWU1pMVV5b2xFL00wRTVTem90SEtM?=
 =?utf-8?B?VGI3c2RzNFhFTk5LVkxiV0xjZ0JjVG04U1FDUTZrWmM2QmpUZWNMa1RrZXB5?=
 =?utf-8?B?UzdLVTMvRHJhWEJNVkJlRGpSTmxPTE02aGVvVW5BVHB0QmVIRW1tczlaNUt0?=
 =?utf-8?B?MHBiTWcySWNjUEhMekxMZGFCZERKeWFVSUxPMTAwV25uVmZHNVRlVVVKKzZi?=
 =?utf-8?B?dHFHeEN5TVYrYWg4RjJGYXB2TGRmQ0J0L1ExdTI4eHZPOU1HSUJETm5lVFFx?=
 =?utf-8?B?RG5PbVpKL3BTcU9TeGN0emo4WGM5WjVSQ0RsTDNEbHU1UkV5M2pmZ0lNZGEv?=
 =?utf-8?B?QmZWU1k4cWplVHQyckNMSVl0QzhSbDBReHAyWXFIamg1bUxEYkVJS2swaGJE?=
 =?utf-8?B?VGdZelZ4VGI2dXZrSmUvUllNRERjcHdjUDlMSFg3cG1jU1JrS0VLVjJkRmk4?=
 =?utf-8?Q?kDEHdN?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 05:36:02.2820 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 821d7d7c-9e86-4a0f-60d4-08dd8df23856
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000449E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8119
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

v2: Replace cancel_delayed_work() to cancel_delayed_work_sync()
    in amdgpu_userq_destroy() and amdgpu_userq_evict().

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Sunil Khatri <sunil.khatri@amd.com>
Signed-off-by: Arvind Yadav <arvind.yadav@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index afbe01149ed3..c7c927db24ab 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -300,7 +300,7 @@ amdgpu_userq_destroy(struct drm_file *filp, int queue_id)
 	struct amdgpu_usermode_queue *queue;
 	int r = 0;
 
-	cancel_delayed_work(&uq_mgr->resume_work);
+	cancel_delayed_work_sync(&uq_mgr->resume_work);
 	mutex_lock(&uq_mgr->userq_mutex);
 
 	queue = amdgpu_userq_find(uq_mgr, queue_id);
@@ -745,7 +745,7 @@ amdgpu_userq_evict(struct amdgpu_userq_mgr *uq_mgr,
 	amdgpu_eviction_fence_signal(evf_mgr, ev_fence);
 
 	if (evf_mgr->fd_closing) {
-		cancel_delayed_work(&uq_mgr->resume_work);
+		cancel_delayed_work_sync(&uq_mgr->resume_work);
 		return;
 	}
 
@@ -774,7 +774,7 @@ void amdgpu_userq_mgr_fini(struct amdgpu_userq_mgr *userq_mgr)
 	struct amdgpu_userq_mgr *uqm, *tmp;
 	uint32_t queue_id;
 
-	cancel_delayed_work(&userq_mgr->resume_work);
+	cancel_delayed_work_sync(&userq_mgr->resume_work);
 
 	mutex_lock(&userq_mgr->userq_mutex);
 	idr_for_each_entry(&userq_mgr->userq_idr, queue, queue_id) {
-- 
2.34.1

