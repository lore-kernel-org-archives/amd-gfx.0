Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9AA7C3ABC0
	for <amd-gfx@archiver.kernel.org>; Wed,  7 May 2025 21:40:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 844B410E048;
	Wed,  7 May 2025 21:40:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="U34u6M1h";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2051.outbound.protection.outlook.com [40.107.237.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB50710E048
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 May 2025 21:40:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FRlM+0AY7gzgptrEGGHiSZVeYwc3aqt4cypqGky2sutb+KaHlJyq2s1EAiFfd/vJzPqKIUxaq9C4fXNBwZwMWkofZmX6VGX2Hchj5X1IEivWd9a+1vRp6U2FfnX7TWWoDwgULUxDoaUmqNpyGmE77JBI738ShhZv5v820bA8uTCSfC8R/qgJkboud2u29ePrGivFxlewyYRmjzv6VCSDp3J3hggHMgI+h2vBuKKZA4ULLcY9P65sWxXR+QoMxY1xO/lFWRO0SCWF8MlpvNzl7RusZFUlFzWwrdRMbEkBo8WOmSLGUI+RYqlxiMnkKaoP6D9OndrlSkx6X1a2wBmIyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aPGnueLZWew1CskUMfNx3PK1S6qX7g6hULBAA/eZ1cA=;
 b=wC5wTjhoBlE1BFdtgNbUYwuJ1RtgThMfuWdQCZYelQF48T4IG/KYMW5KPYtoe6m12flRebGThhlCHbzE8wZYsX7PWqUWPeO2NDHv00TqezNZ/3gPVckX/+QjKPxWlGmpjWa1fyJGyLJIDWi6fygkMkHc9TC86l4dTRtMZKG43Z5Y5ZSvZW7fcInq6RByXL6Zav+9ljc6GBWcdhpvrDKwkGMnTn+mYBrFDzswR5jZ1eDg3hRi1EH17qxNW7P/2/Q/md3CIQvCsgY+hpe+DE+l9sxW2I8NvYt0A4AE+9v90sT3PNHyufR1n2y1PZwc7en1JPLNSd8JvaWjfFk12g6Dvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aPGnueLZWew1CskUMfNx3PK1S6qX7g6hULBAA/eZ1cA=;
 b=U34u6M1hphtWdvgKHphR+EFO/s0Pz6a8sA4xkA2WM07q0r5kcjPS80/xFLx/n1gM1XoVf+HXG3npNgZqeSftLLpI1UjoLBt2TNvxOQBobmhrykzH6wEFoWp267YaFcMkLvencWXBSq/H2h8IitEH3E/cHdcR21Q8HUqf6Ld6I6w=
Received: from BN9PR03CA0728.namprd03.prod.outlook.com (2603:10b6:408:110::13)
 by SN7PR12MB6910.namprd12.prod.outlook.com (2603:10b6:806:262::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Wed, 7 May
 2025 21:39:55 +0000
Received: from BL02EPF0001A108.namprd05.prod.outlook.com
 (2603:10b6:408:110:cafe::72) by BN9PR03CA0728.outlook.office365.com
 (2603:10b6:408:110::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.26 via Frontend Transport; Wed,
 7 May 2025 21:39:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A108.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Wed, 7 May 2025 21:39:53 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 7 May
 2025 16:39:52 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <christian.koenig@amd.com>, Philip Yang
 <Philip.Yang@amd.com>
Subject: [PATCH] drm/amdgpu: csa unmap use uninterruptible lock
Date: Wed, 7 May 2025 17:39:00 -0400
Message-ID: <20250507213900.26723-1-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A108:EE_|SN7PR12MB6910:EE_
X-MS-Office365-Filtering-Correlation-Id: 947df39e-4659-449e-f846-08dd8dafb3fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cVnDX8D3HkmO7QCLLlkzrsi1zx6Wzrg8IhsYnF+oI4YfFwCx9P8vkVVT0zSx?=
 =?us-ascii?Q?4Bg/YN1dZvkMEJJG9qiNDaXez2WiT3ukEICM7rCeaTTEiZx8toXYqoc37qqO?=
 =?us-ascii?Q?YYs2Nbf2l9oMyPzQwAzw6Fuivu2SIVvMEth34I8cbLayH5qUyfRUe/iSXGxR?=
 =?us-ascii?Q?/tTTVYeYjgkHnsxa8PkGctynCjcgte9HULwQhbEWRKqrncXN672n1jMg4Of+?=
 =?us-ascii?Q?QV3ysfpAIkFUcdUXJTBAB1tBMDbWuvQ8DgiCeRneD1+0AzZddNAR7yyR475M?=
 =?us-ascii?Q?WvRilarG0CsdBZHViFS8/NcnrpSXvAlfJNZnnZ7BbYbMStD9m1AotdOHIIAy?=
 =?us-ascii?Q?4DBUTKk9NCvHqpYjws43Rau1MIw+RKod/Vaqz8JfxcOjnBxyXPF1iFyZzIFj?=
 =?us-ascii?Q?U36oZLankYB/+2BT6Rc3H6ZHz48sN6FLOahjDfag1LDgaznf2z/fKoDv2Y//?=
 =?us-ascii?Q?+TZQlOVm689xu3ii1WTjzXQ9a3GZy3VIFMZv9th6lqE7SA3DpB9Ddux/qQKd?=
 =?us-ascii?Q?GZaxm085t/LEKHjdzNYfu49DMhq+u1WgUhhRO7XGPx75BGjBlGcdkndcw4B/?=
 =?us-ascii?Q?f8PWNa1RPAK6I63XwwrYGrKAc+ZXIKM4oL9DN7k/gD2YBt2aFUPDe3S3wEe0?=
 =?us-ascii?Q?RLajTxejKi/GMf54WI5BlAg/lKIJIk0C29Eicid4FTxZZBpsuCpPYx6mkFYV?=
 =?us-ascii?Q?WWRyFHSRCTH2MkEs37Cao5ON61DaamxgQfUUHYxv/qOoHfIEnfvTXb5mlSh1?=
 =?us-ascii?Q?Qxrqkm5C7kc3wkdv4oek4/B8i/b//mHgdZYzv215ZhoY6PTkA1oba2jJSAzP?=
 =?us-ascii?Q?kY55ICgqImRl9VE3HFoDBRv31UPzuU4+JdLHZoXvopMX3NELZwthJ1qDi1Ex?=
 =?us-ascii?Q?U+JrdzLGtaLYA/vFBQDOOTeKQ1PyRo+XIFZMcIkDLCkxyJenngrGtxhPB/z+?=
 =?us-ascii?Q?bFDnhkVet53IjBW3MbHeHs4E9/C+YcMEe8rkSDm6JBy0k0InIKadE6XsKgt6?=
 =?us-ascii?Q?Oc7w1nhcCTeTvP2ZViMMzkjCXLtfDpWV+QIv/pcSTuw+xYCJ0kdcBwXigghF?=
 =?us-ascii?Q?0bTSogYP4tF0qpBVAlXJKG89bZvCYVrMbb19bxhYCXXwYmN55sET24/tUoIh?=
 =?us-ascii?Q?5sZsM90IPkuWPpdp1viAIzZpUL8CChd1+N+1U/pFWlTN5jd8jdv7dpcHn61e?=
 =?us-ascii?Q?oQX2NXFgVZ0KMhxZxoos04xsW0wquz8H1HxOFjG7LcEsaP7Mp5stVov0PQJM?=
 =?us-ascii?Q?RkJ2wkrhvHam6e+LgKb9SyGaLrqKCbzLG6u8h7hsxeIN2Jo9zVsWjQNR+sGY?=
 =?us-ascii?Q?/e5hhxIsBw+jUwwzM3/QjvikEzk2Ct5pLixstjK6J8jwJ1gCRhglDznjylND?=
 =?us-ascii?Q?DSuNoQuepE3vRDezAo7rTQrSnie6sgG1Ubb/Id33UMlamUenSWal4Xrl7iCu?=
 =?us-ascii?Q?1AqLA8g+XwUDvwu4gMnwqOYE6e0xn+50p0do8jtMN16nNy8U+4OtJt1Iy93Y?=
 =?us-ascii?Q?dK9ezd5jBZq1GIxLctDgS3X2tI/Bgibskfuf?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 21:39:53.4457 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 947df39e-4659-449e-f846-08dd8dafb3fb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A108.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6910
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

After process exit to unmap csa and free GPU vm, if signal is accepted
and then waiting to take vm lock is interrupted and return, it causes
memory leaking and below warning backtrace.

Change to use uninterruptible wait lock fix the issue.

WARNING: CPU: 69 PID: 167800 at amd/amdgpu/amdgpu_kms.c:1525
 amdgpu_driver_postclose_kms+0x294/0x2a0 [amdgpu]
 Call Trace:
  <TASK>
  drm_file_free.part.0+0x1da/0x230 [drm]
  drm_close_helper.isra.0+0x65/0x70 [drm]
  drm_release+0x6a/0x120 [drm]
  amdgpu_drm_release+0x51/0x60 [amdgpu]
  __fput+0x9f/0x280
  ____fput+0xe/0x20
  task_work_run+0x67/0xa0
  do_exit+0x217/0x3c0
  do_group_exit+0x3b/0xb0
  get_signal+0x14a/0x8d0
  arch_do_signal_or_restart+0xde/0x100
  exit_to_user_mode_loop+0xc1/0x1a0
  exit_to_user_mode_prepare+0xf4/0x100
  syscall_exit_to_user_mode+0x17/0x40
  do_syscall_64+0x69/0xc0

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c
index cfdf558b48b6..02138aa55793 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c
@@ -109,7 +109,7 @@ int amdgpu_unmap_static_csa(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	struct drm_exec exec;
 	int r;
 
-	drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT, 0);
+	drm_exec_init(&exec, 0, 0);
 	drm_exec_until_all_locked(&exec) {
 		r = amdgpu_vm_lock_pd(vm, &exec, 0);
 		if (likely(!r))
-- 
2.49.0

