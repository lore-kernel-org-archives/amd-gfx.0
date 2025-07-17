Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 820DAC83F1A
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Jul 2025 17:59:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 173FA10E319;
	Thu, 17 Jul 2025 17:59:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GEbFnC5P";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2043.outbound.protection.outlook.com [40.107.92.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E310910E319
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Jul 2025 17:59:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C7fQzm/TT8/aKGKmRWAsOYY7Rg2vEp+4NMhGtngaRgcqf7DgVhGH0bYVb+uEygREwJGmNn+KmJcOjwK5WQuRKU/3iGWdt8gkiv8aTz3BXgOKP6vFAmP6PMYl50HqI/GQVe5VNWtClX0YhspZ2XestGRjMttI5b6elCShdfkiZ7V1s8EGLTsAX9ojEEmmGgtpNDGwi+C6bgfCmBgu/ataXm11f2dhwOLob8KlNzTeDun2cL7wqRgQcBur6PO2Wmhz0QZ41ow0dYiGMdufpZAD6gDjmctztkN8MA08TQMEounQm68WSPZ2/ImyhzSw70WD7JOD/p6m2yO+R9b56P5Uog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H4R4TFWEB7tdve8eX0Xg9Uc+E4gJbIa6PaYH+u3VLps=;
 b=iu+r0QTjypMRkB7z5LTu8PkiE6FlVm6xCrRX0fxwQ+5FKCPynGt1azrGtcCOTIMbYNL6oIQ0WEek3bitRB+5+SRveN2YYe+upq6umdISqljaGbKcUbEbhLAOsTbLBRo9XxueJk5N0cBMSyreThgsp6etWE/AsqLtlUMt8mCQmZ71OOgUz9Kn1DsEl8k2J5Ndjj7ioprMUDdBtz+hMdy9ttGJ5GZOR+TW6oDXhiDGzZZhsvgf24zDRZ4p0Y1nqgmcBzioyGzkEO1LKfk5JruBU42UxOeeUL8Ah5AuYzCtiBdQ68NOqb9I6Kkik0XclbR5I46a2802lQgNblNMuRXYGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H4R4TFWEB7tdve8eX0Xg9Uc+E4gJbIa6PaYH+u3VLps=;
 b=GEbFnC5PrX1qVXDsqnRnClbSI12k4iQJ/k3W2fLl52Z4x2tJm6j0Vh/ULfAIigPOzSQzE1km51D9Za3CB4Ht4Jq7mYRd+xoHVNFRC1qqkaMq33e5VeO1yjS5sfGZVtU+ubOiTetfcsMWDvqtHdULKlWTrqFZ8L1ZKfGGpTVz+Nw=
Received: from BN6PR17CA0060.namprd17.prod.outlook.com (2603:10b6:405:75::49)
 by SA1PR12MB6847.namprd12.prod.outlook.com (2603:10b6:806:25e::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Thu, 17 Jul
 2025 17:58:57 +0000
Received: from BL02EPF0001A107.namprd05.prod.outlook.com
 (2603:10b6:405:75:cafe::6b) by BN6PR17CA0060.outlook.office365.com
 (2603:10b6:405:75::49) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.20 via Frontend Transport; Thu,
 17 Jul 2025 17:58:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A107.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8943.21 via Frontend Transport; Thu, 17 Jul 2025 17:58:57 +0000
Received: from Devmachine.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Jul
 2025 12:58:56 -0500
From: Gang Ba <Gang.Ba@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Philip.Yang@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
Subject: [PATCH v4] drm/amdgpu: Avoid extra evict-restore process.
Date: Thu, 17 Jul 2025 13:58:42 -0400
Message-ID: <20250717175842.1344076-1-Gang.Ba@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A107:EE_|SA1PR12MB6847:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b887eff-4fe8-442e-4a3e-08ddc55b99e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V1lDcUxwSFE3T0NVRWNvV254YkNPa2FSTG1OZWVtV2FSa0RYTUhyczJSMUNu?=
 =?utf-8?B?WlI3T2VMQjdkc1N3R2ZRV0ZzNlZBYi9vcmJ5dklGQytsbzhMRDhyN2Jvb05I?=
 =?utf-8?B?elc1SFVVcC9oODhwTkZ0V0c3clIrSWZnNzJKcXZNQ2NrTlpWTmRDM0hIckNl?=
 =?utf-8?B?czRpazQzSUZrYXdvTWFUZk1YYnpuZzhPZEFraWZScDg3MzNydlQ5dFFqb2Za?=
 =?utf-8?B?ckZYeU1KT2d6QTFYWktDdU84VVhGcDZCT1lCK2tjeEMyaTc4bExtRVFmdldU?=
 =?utf-8?B?WUllT0V6Ymt6b3J4eTVDRGFHdklFeUh4NGEybGJQWG1YZDZYbk1ucnVpdmFR?=
 =?utf-8?B?RGhCM0NPNTF6aXhKNnEwa2lkUGdNNk93cVZNZ0hGNjJWeU5JdkxtOGJubHpt?=
 =?utf-8?B?RDNoQjZSZmt2aTc1cWpyRjRCTHZuTk1DTTQ1aHVpUWxnNFJpeEhrcExOc1Q1?=
 =?utf-8?B?NEpoVzh5Z2ZRVjBveCtERkwwQkJjQTZmanFqV0lDbzJzOEUrbnZyb293bnBw?=
 =?utf-8?B?bVN4UkR0ZVNNbzUwT0p0L0VjVFZ2Y2N5enRkbzFSQXpmY0hOV2hXTDY3Sy9Q?=
 =?utf-8?B?VVZJR2txVzFYMXVtcWpOV01obkZDb1A2NU9ZcHBIWklha1pGZTBRRS91TUI1?=
 =?utf-8?B?czd1VlRnRDlRbXFvb3lhN1ZIMitvUlUwc2hLM2lMMURxcnZqbHFHNk0wNVRs?=
 =?utf-8?B?UVdkbHlsZkNRMHpJTE96cTA4WVlVaU8wcng3bGtZNWZhNGE0TU85Wm81ZGNj?=
 =?utf-8?B?YVJLNmtweXl4bFFxcG1jamlyVTA3UnBSc3VmS0I5RDJxa1paS2xIU29ZWlVH?=
 =?utf-8?B?byszRE5RRi9GSnEwUU1rWkRhaEI3WWEyQkxBaTIzS1NwdGlxeVJkTDRmQmtP?=
 =?utf-8?B?UFh0OEwrRDZQVGZVUXpVdk9mVnBVNzI5QUszNWN5dlMrTnk2WC9QY2gzOUdj?=
 =?utf-8?B?d21vTmhZNFFwcjRnYk5FR1AyQWpUM2NMZkl2YVZLenkyaHU2T0UwajJoU1lI?=
 =?utf-8?B?V3VyTDBlelgrekVmZHFPbmRoTGJwcVhhQW5CVlo1OXpUTlRtdG9YMW5lelBT?=
 =?utf-8?B?NVRBLzBDOXF0L1R2UElhSlhnRTdmR0ErZHkzazBKVWFzVEtIMkcvYjRKN0gx?=
 =?utf-8?B?NjR0WTlKcUF5S0lxV1U0dzQycU5rRkdyNVNRSXVpUVZJdEJHZ1RrKzFJMXJR?=
 =?utf-8?B?Mk9uVGIvZWpqbG1xVE55Wk52UjdIQi94K3UycHZ4L2NWU09IVVNUM0pxK3FQ?=
 =?utf-8?B?dVltOWJYRlliQWE5UktHUzJiOVhEY1lCM1dWYjltRzdJY1FLeTlVWDJxSm50?=
 =?utf-8?B?N2hSSmRhak14ZXJEZ2RtdlBCbklxZGtXOElJZ0tqQkpYdE01Q2dGeUZNa2pW?=
 =?utf-8?B?SC9iYlJ3VmFSR2JGakY1YmlzL0lxTmgxQzZndVZORk44OG9zbDE3dytWQ0FJ?=
 =?utf-8?B?MnRuT0VwSjg3dTlnVUhoWHorTEVpVjJXWkVnRnV4L1FKYWxTcE9VSEh6MWVz?=
 =?utf-8?B?OGVFbUZTZ3gzdzl6WUZBRDhSZmlpLzVWZTRVNG13UWtKeUIwdUkyWXMrVWtQ?=
 =?utf-8?B?eFd4RW9aQ0hKUWRNR0xHdHVRVk12bUNhb01sWGg5RWhjZEozZFEvVFlSVzJL?=
 =?utf-8?B?aHY2L3kwNlFVVXJxREhmRjUvdGYreDVPN3duUVd1ckJzak9LYlZOQnVNRFJC?=
 =?utf-8?B?QmRCSnVqdDBTRmpZK245Z3JIaWRBNmhOZGY0dTZtbkQrSEZaanE3RkxhWXda?=
 =?utf-8?B?cUVldEZROWdKUU9pVVJZbHNNU244OHJMdjRtRW9EZG9KQ1Z1RUt3TGRGQVR6?=
 =?utf-8?B?aVY3cHZZY2YyUWpyK2FSMDZOUmFvc3crM2VkTDlhMlhtZ2Ntc1RpOXl0eHJu?=
 =?utf-8?B?aWhTdG9ob3FtdldYaGVHRHphOTV4QWtROEZTLzVoL1dxcWFnRjkySFFobjU5?=
 =?utf-8?B?dXk5U092TDRFcGxVaXRMTnE1TzhkUGRDREtDS2xVUUc1em1WOHJLVndvWnh3?=
 =?utf-8?B?eWJjQ3p3SFo4eDM5SXBTeWExZGk5bkJLZGc1cnAyVWtxNmJlbVhtUFF4YU9h?=
 =?utf-8?Q?0FFJU6?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 17:58:57.0547 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b887eff-4fe8-442e-4a3e-08ddc55b99e3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A107.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6847
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

If vm belongs to another process, this is fclose after fork,
wait may enable signaling KFD eviction fence and cause parent process queue evicted.

[677852.634569]  amdkfd_fence_enable_signaling+0x56/0x70 [amdgpu]
[677852.634814]  __dma_fence_enable_signaling+0x3e/0xe0
[677852.634820]  dma_fence_wait_timeout+0x3a/0x140
[677852.634825]  amddma_resv_wait_timeout+0x7f/0xf0 [amdkcl]
[677852.634831]  amdgpu_vm_wait_idle+0x2d/0x60 [amdgpu]
[677852.635026]  amdgpu_flush+0x34/0x50 [amdgpu]
[677852.635208]  filp_flush+0x38/0x90
[677852.635213]  filp_close+0x14/0x30
[677852.635216]  do_close_on_exec+0xdd/0x130
[677852.635221]  begin_new_exec+0x1da/0x490
[677852.635225]  load_elf_binary+0x307/0xea0
[677852.635231]  ? srso_alias_return_thunk+0x5/0xfbef5
[677852.635235]  ? ima_bprm_check+0xa2/0xd0
[677852.635240]  search_binary_handler+0xda/0x260
[677852.635245]  exec_binprm+0x58/0x1a0
[677852.635249]  bprm_execve.part.0+0x16f/0x210
[677852.635254]  bprm_execve+0x45/0x80
[677852.635257]  do_execveat_common.isra.0+0x190/0x200

Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Gang Ba <Gang.Ba@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index ea9b0f050f79..ab295b22a669 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2414,13 +2414,11 @@ void amdgpu_vm_adjust_size(struct amdgpu_device *adev, uint32_t min_vm_size,
  */
 long amdgpu_vm_wait_idle(struct amdgpu_vm *vm, long timeout)
 {
-	timeout = dma_resv_wait_timeout(vm->root.bo->tbo.base.resv,
-					DMA_RESV_USAGE_BOOKKEEP,
-					true, timeout);
+	timeout = drm_sched_entity_flush(&vm->immediate, timeout);
 	if (timeout <= 0)
 		return timeout;
 
-	return dma_fence_wait_timeout(vm->last_unlocked, true, timeout);
+	return drm_sched_entity_flush(&vm->delayed, timeout);
 }
 
 static void amdgpu_vm_destroy_task_info(struct kref *kref)
-- 
2.34.1

