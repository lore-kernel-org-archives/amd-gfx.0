Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E72E8E77180
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Dec 2024 03:06:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C38910E0C1;
	Thu, 12 Dec 2024 03:06:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nYUzJrvM";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2085.outbound.protection.outlook.com [40.107.244.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D0BF910E0C1
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Dec 2024 03:06:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lnd6VtWJ/oZPtPWTNNk6GNBo44RdUZtCkFAd9XJdyWcbXCI7J4DtlZ/FEH2aWTBtm0432kzJKH8Zu/UXT9n82lzp466WD8is4KVPN+BjTTN2M0QBPAvnZ7+EmgzxZDI15T4f8vk5V2CzN18ksHHBIMCQMPwt2k6GvqD2bVvYcn88mMdCkffJLx43k3tlhYavCAZyNM1fNj59hKxIwMuPKy1LINOXsZ7R9oUN9ej5qAPlzd1gSLIx/C1Jz4o+9qQP7peat64Y+sjlwScF5ToRgZ+bM93dw++XMiSbyoSL/dNT05aOUkC5pLdFBsZYgnAUrKFoqnNgUUp62n9wAEXBlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9f+qMa1iyATaaX5RNyPolQTV464/vqwBA1vUAmqpVvQ=;
 b=qAO35Ba+sU/np3ThhwXQGrfXnXG7rmhZdVVrL5/7FtRQ+HeYESWUAj/OpXjXXHI6lPE2HgxhJOUecmpDeEmrLyFgvm6V0MSMk+cwvcHH6gZXV07gE4VTy8QFcrcKSeMuzSkJCxNs7ek89w8FA8eMs5Ndau24cTyRjEFb3UQHlZlSG5Qeqi9taVI6swymqAtfIUIrpTMCo9f5ver8v7YHLT6pi0rdqC3IvhWxl9am1mhgXqlFkvqgR1lZABFVGOm8JpXyDQQBM81wvdtpcEfKHSv+kOroGZc4Pgrbxm8PvolqgTgZzY4piEJEW2goLaTVdVYSll2mPMsB6LQTsbScEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9f+qMa1iyATaaX5RNyPolQTV464/vqwBA1vUAmqpVvQ=;
 b=nYUzJrvMai57XHymCyWlKYNHijKZoV71OF2gXM9rd2orj1O3q5ZlaBLrhlnIjin64VmFf2UJTmiWMmfhG6Svl5oEpicZporv8tiWinN7pgsN6HQToAAH42i7mCD+7bFX85mX8Hie0Uo96PtfaKab8cbc5f4MlLJxiaPRt1OGpRQ=
Received: from PH0PR07CA0003.namprd07.prod.outlook.com (2603:10b6:510:5::8) by
 DM4PR12MB8572.namprd12.prod.outlook.com (2603:10b6:8:17d::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.15; Thu, 12 Dec 2024 03:06:53 +0000
Received: from CY4PEPF0000E9DB.namprd05.prod.outlook.com
 (2603:10b6:510:5:cafe::83) by PH0PR07CA0003.outlook.office365.com
 (2603:10b6:510:5::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.16 via Frontend Transport; Thu,
 12 Dec 2024 03:06:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9DB.mail.protection.outlook.com (10.167.241.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Thu, 12 Dec 2024 03:06:52 +0000
Received: from localhost.localdomain.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 11 Dec 2024 21:06:49 -0600
From: Zhu Lingshan <lingshan.zhu@amd.com>
To: <Felix.Kuehling@amd.com>, <alexander.deucher@amd.com>
CC: <ray.huang@amd.com>, <amd-gfx@lists.freedesktop.org>, Zhu Lingshan
 <lingshan.zhu@amd.com>
Subject: [PATCH] amdkfd: wq_release signals dma_fence only when available
Date: Thu, 12 Dec 2024 11:06:11 +0800
Message-ID: <20241212030611.8513-1-lingshan.zhu@amd.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DB:EE_|DM4PR12MB8572:EE_
X-MS-Office365-Filtering-Correlation-Id: d53e4dfe-020e-40b9-92a5-08dd1a5a073d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Gp6P9BaNwjGFyC6DAm5cVbZiT4DGMhQrVA3LGOFWGHdGBx98v4GLqWhrGKqz?=
 =?us-ascii?Q?0oncsFM2tHcoMdu/EyqlixcELqRAIF3FRXrq9b6Q6C/t6bFyu0sHfm2FbdDq?=
 =?us-ascii?Q?9C2RhX234Nn6kQENFE0yDFioTXJTfhPEXH8r76T8pMujmfLS6wIV42q+0CQy?=
 =?us-ascii?Q?2QaN2G3PW4COLTsRJCqxUs7v3cXPO4IVcqHrx6WnoK2diX6fmLK7/bdkIlTK?=
 =?us-ascii?Q?e4Na4a6qn31qVLehirkmbbP5hBBS2ShsfFkV2kMvjpK/GRsLPbT2wy8f1PMc?=
 =?us-ascii?Q?PdcqIQVxlffXj6uovM6yB32B+sJCe1UxRF8RcjRTASxgtbwWtjFWHxG4IL46?=
 =?us-ascii?Q?UAgYuQ/Q8g6aOUT4BcgDcVKUuTqBwwBlydWIFcSJOvr96dVfQfvntaNdgat1?=
 =?us-ascii?Q?30o/y0C+dRA0+6FGt11zH0muaVEbjSGSgKfsBMqD5BAwK1Lj/juZCAAxXOmu?=
 =?us-ascii?Q?4vSOOVBrKPJ3qMc3JjHCil67P6Cee5+/STTkKQFjbfjMnaEk2gEAYluTzX6y?=
 =?us-ascii?Q?EnO6Vpd8s3thexh7lIQgMfAoVqxZwHDLSVJO2s5PAsjGg+TXK/CgrrCz1Co2?=
 =?us-ascii?Q?laAiRtEN4VzoPj+jYAq4uJWDoeU6gpQ7cp1ilZRqJ2V+A5DUhPqnNbfKbqm7?=
 =?us-ascii?Q?OVnxidT9Lt4mvrotDCGQ+KNraut0dCQRZrnRf+kG7QGVCB2z4wcXMaZcKGmj?=
 =?us-ascii?Q?tZh9IhS/sTS0yytDk/BxHjH16PnMRhCNg7dlawL84saSs/3xujaFbSvOqJxr?=
 =?us-ascii?Q?Xp+967vc1rKY4kX7YF4/r3bvFMj0DDDyu6poYUw/88T/WJ4S19Cikh+qXfLK?=
 =?us-ascii?Q?PlrAVtV21onFkZ5skK8dCHM5ZlHQeeVieejJMkxvk19C9hXk8sZ/t8p4/e/3?=
 =?us-ascii?Q?ocvyl/DW2zTXgEoekxjn01XsfdhJUq5OIwXZcSLEzoN85r8SRvBZ56NeYqdi?=
 =?us-ascii?Q?u0e22Kv+VLs7akm1wJdoe7IkrX5pnFnZVnXhbuGuuERZXq6ywC2GpvNUDR33?=
 =?us-ascii?Q?IGJy/nvdoSM4on0rxceq+Jo7nkGG9fDD+POOkAULkLLYN7KHRFWbPnzgFeAX?=
 =?us-ascii?Q?L+uF0tDGK6R+tF51ECRvqhJwzclNQXd4Q10jhJ7oECudyd3dszB5Q5hgBd4N?=
 =?us-ascii?Q?02PA7UCZdRo7T4u4506zgRpqpD83MoSgz8uMSEn34rmrHok3GgeJTuoQMju8?=
 =?us-ascii?Q?xsG+NrJGIiNimJx2Gy+BKUvSjZQ+edFXVeiLS/5vB5i31VPdFwwtwoiHihDQ?=
 =?us-ascii?Q?2/cKT7PfjWaJCHKkapXsTkO6hRWt5oJnKGD84EgDChYosIAzbopJP32z1VP0?=
 =?us-ascii?Q?u79D0minGl3hRAhT5/oOO8x4ihVdpi7vrkK2j0DeO0ODjIlEjjxpMSUq2GvB?=
 =?us-ascii?Q?wZI779q1M1FRXR7C6mYMOeGZsApVs1nwZSXOaKi0weh4KnAnYtbzTvmQ0FsW?=
 =?us-ascii?Q?sWbFvaNXI/c=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 03:06:52.5770 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d53e4dfe-020e-40b9-92a5-08dd1a5a073d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9DB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8572
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

kfd_process_wq_release() signals eviction fence by
dma_fence_signal() which wanrs if dma_fence
is NULL.

kfd_process->ef is initialized by kfd_process_device_init_vm()
through ioctl. That means the fence is NULL for a new
created kfd_process, and close a kfd_process right
after open it will trigger the warning.

This commit conditionally signals the eviction fence
in kfd_process_wq_release() only when it is available.

[  503.660882] WARNING: CPU: 0 PID: 9 at drivers/dma-buf/dma-fence.c:467 dma_fence_signal+0x74/0xa0
[  503.782940] Workqueue: kfd_process_wq kfd_process_wq_release [amdgpu]
[  503.789640] RIP: 0010:dma_fence_signal+0x74/0xa0
[  503.877620] Call Trace:
[  503.880066]  <TASK>
[  503.882168]  ? __warn+0xcd/0x260
[  503.885407]  ? dma_fence_signal+0x74/0xa0
[  503.889416]  ? report_bug+0x288/0x2d0
[  503.893089]  ? handle_bug+0x53/0xa0
[  503.896587]  ? exc_invalid_op+0x14/0x50
[  503.900424]  ? asm_exc_invalid_op+0x16/0x20
[  503.904616]  ? dma_fence_signal+0x74/0xa0
[  503.908626]  kfd_process_wq_release+0x6b/0x370 [amdgpu]
[  503.914081]  process_one_work+0x654/0x10a0
[  503.918186]  worker_thread+0x6c3/0xe70
[  503.921943]  ? srso_alias_return_thunk+0x5/0xfbef5
[  503.926735]  ? srso_alias_return_thunk+0x5/0xfbef5
[  503.931527]  ? __kthread_parkme+0x82/0x140
[  503.935631]  ? __pfx_worker_thread+0x10/0x10
[  503.939904]  kthread+0x2a8/0x380
[  503.943132]  ? __pfx_kthread+0x10/0x10
[  503.946882]  ret_from_fork+0x2d/0x70
[  503.950458]  ? __pfx_kthread+0x10/0x10
[  503.954210]  ret_from_fork_asm+0x1a/0x30
[  503.958142]  </TASK>
[  503.960328] ---[ end trace 0000000000000000 ]---

Signed-off-by: Zhu Lingshan <lingshan.zhu@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 87cd52cf4ee9..47d36f43ee8c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1159,7 +1159,8 @@ static void kfd_process_wq_release(struct work_struct *work)
 	 */
 	synchronize_rcu();
 	ef = rcu_access_pointer(p->ef);
-	dma_fence_signal(ef);
+	if (ef)
+		dma_fence_signal(ef);
 
 	kfd_process_remove_sysfs(p);
 
-- 
2.43.5

