Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4E17D690EC
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Nov 2024 09:16:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7FAFA10EC54;
	Thu, 28 Nov 2024 09:16:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YDYFd52O";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2073.outbound.protection.outlook.com [40.107.220.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2303010EC54
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Nov 2024 09:16:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lo5oP4M/rSTBbCiNjFVMylnKwvyxipXEzstMPwOmZve2quC6AimMIDABWiGrD9QFjwSH3k1lbwZHGalO4x8rrfim2bN1oBrkj0gdOwWk6l1X+jFFX1XeGetQa4pXv/3uvKYT97ogUMOuKkV36/ieSIfCSgzeyhf5+pj68/nVbRiKHiv/Z9fYGirkwd/3qUbYPEdIUmEa68H2747H2l/Gp23gPBU1r3wmXzi1+t1kaLQs7cbejghjFUSS2NO/9+dDTkraOEDA15xahJDCgGvqkzzw4uNq/Dhp+AFVDZ2se8QJnIF+i6ppEzZq6LzR4PjejD+CyuHQB6gI54tPsIAQgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ivjWVNdrfJOemzre7sDelVkmFbNRN3xX2JeXqfxYfUY=;
 b=agZzX7JA17O0DmhuizjShUznBMwouARveu0rDoE9QHvSA2Zh+siKUm1fc8lJKwxnY1Xa4TmY/YMAdkRZ//ARZjNKPK2FQW8/+h1E6kM9tBb++KBxwhPvjdw90Qz8S68QVJY16mAHCNq1BdOMkuXTaXlzH1Ggy5H/OaWzNIHi+7T6rUkzOKZZMvVroT9pTHFlczL2YLuTY9lGthsiEv6crJlxiH2fxgdBNGQy6TydSqZpCo8x5Maogewxr7ZB3syyiC05iWzpeUA1NHZGnpbiOBHHjUUpt0093oOi45G3How4X+5FhpHCRdsm6aF35EjsKCFZntIS9x7Tak6GmgXu8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ivjWVNdrfJOemzre7sDelVkmFbNRN3xX2JeXqfxYfUY=;
 b=YDYFd52ODIij55jJ770VWKB61vO8yEH06XXrkUbH800TSyMsDuQHK6ZlWr6Rdk8M70PYa4LpCWoPuGavcBWJuZnHX7kDqf25oC967auEC8KHGGpdrH8/f09BMUYtVnPsXTnk2N566c/3OjkRdMS842jh0c6VLt5zESAZVH8cJiU=
Received: from MW2PR16CA0011.namprd16.prod.outlook.com (2603:10b6:907::24) by
 MN0PR12MB5906.namprd12.prod.outlook.com (2603:10b6:208:37a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.20; Thu, 28 Nov
 2024 09:16:24 +0000
Received: from SJ5PEPF00000203.namprd05.prod.outlook.com
 (2603:10b6:907:0:cafe::58) by MW2PR16CA0011.outlook.office365.com
 (2603:10b6:907::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.13 via Frontend Transport; Thu,
 28 Nov 2024 09:16:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF00000203.mail.protection.outlook.com (10.167.244.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8207.12 via Frontend Transport; Thu, 28 Nov 2024 09:16:23 +0000
Received: from amd-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 28 Nov 2024 03:16:21 -0600
From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, <alexander.deucher@amd.com>, "Arunpravin
 Paneer Selvam" <Arunpravin.PaneerSelvam@amd.com>
Subject: [PATCH v2 3/4] drm/amdgpu: Fix the use-after-free issue in wait IOCTL
Date: Thu, 28 Nov 2024 14:45:45 +0530
Message-ID: <20241128091546.462159-3-Arunpravin.PaneerSelvam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241128091546.462159-1-Arunpravin.PaneerSelvam@amd.com>
References: <20241128091546.462159-1-Arunpravin.PaneerSelvam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000203:EE_|MN0PR12MB5906:EE_
X-MS-Office365-Filtering-Correlation-Id: 75327f40-73a1-4926-6b7c-08dd0f8d5490
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?sVp2rSA132d1FSg3GsHOW5az6La9nIuDawBPq9jnmJXbQ9UxwSi+fI2IJZ7B?=
 =?us-ascii?Q?UZuL7mGZ30vpAP6FRfTDxWkxbzPhbnJ3gcPVmgkHIvFxpBIuwC/UAGTjDzD9?=
 =?us-ascii?Q?so98RpKh7ShsPOmm4416W+6/DQYtMJsnQjOnFHgCSlJBd6DwqVAucENauyuZ?=
 =?us-ascii?Q?O5Osdi4bG5bcsgwRwW63mRt8NT/4gj2ackP6lIxS22fXApqsg+r4ldFT1YrC?=
 =?us-ascii?Q?ZM5XahPc+b5t3Ge2B35s5WDTORxJpDLlu+ZJ59kWCDD5vQYeeNhnzMqAv5ss?=
 =?us-ascii?Q?7qvg9pgdVppL+H2kruFwSrHsriivRKjz9hcXAOLqAgEb810sw44O9IVihzPA?=
 =?us-ascii?Q?6+iC3WgEWHtoAsUei/vRzHoOSFVC0Qc8ffzOg4gp6S3sYSLi79Niehyy0YNN?=
 =?us-ascii?Q?/IbKF5E1/wauD7lq3KLXJz4VdlRuYS0xtVKX3z1O7zsi80Kw6IX5U8RBrfXs?=
 =?us-ascii?Q?wa9sLGZhmkimhFVTOOj/tFeRNkTib/xtIlpA4No7aPFC7JmA+HvHHn5QEOUl?=
 =?us-ascii?Q?iyyu+TZW1HYRj7Qr4twuF7xbkWhfpe2qAszRBMiRua6Oz1MUJuGw0RWsh3Ua?=
 =?us-ascii?Q?Dp9Qx9vedEOhvOeWKIueIELmkj5laaNb004ody//khI02KYVUY8qFLXSzsPJ?=
 =?us-ascii?Q?LeMEFm7t2v8oAweCFtZYeMG+i95tdYrLqWhiChfdC7OAZhpWbcCsFXinh1Ec?=
 =?us-ascii?Q?dkYg1gxlawFCPKWSb7Bm1yOuP4+hkDhTyunjE/LVSfD6WuKUQWl2tq7DYAm9?=
 =?us-ascii?Q?66BLYITjKjLX8BF9FHBkzOBcoVqeCcbiUqodTDQpCZ9kGbWL/9VkZzftgEa1?=
 =?us-ascii?Q?tmyq9czO2tsXlc43DNmgjxFvObjmJVtmIjt/zJbK15PARNF1R4tNjmuOpZVF?=
 =?us-ascii?Q?I47bLPMLk+7CqnWJdDWcHHTDob0ZTGzA6sk+8oZPcef5Pls/dddUw7eXjEIb?=
 =?us-ascii?Q?vidf5kYn+u8UPxKyVHgK6UoCikVQbBLrGVxfdYJ2MLCNVQtZvkF371dVjHfp?=
 =?us-ascii?Q?xKMvltLMEJxWtvY8utY/bYqFXmId/h5PLZIM5vvaPm0f1JG75ktxaCaInG9g?=
 =?us-ascii?Q?CEvXV+yG06bopDjM8XcmbK0UmurYhRFOiBZ2e8v5kIwj7uYfvZiXmSEN0Ot5?=
 =?us-ascii?Q?C4PUZaYRju7N70GpWvWpriKTvolTbFfVbXCAqvoMZiDhn69VTdMoQlud/ta/?=
 =?us-ascii?Q?4AmFdsVtW9VoIPFEiN0WW1COU6yGAKmug288zvLH/w7LskWPxGKsL0GmZ2pE?=
 =?us-ascii?Q?2dXDqRDCdJCvKTgKI7Jhb6AAxT2oA+fXyooxtcNHdH5Rzl9Pg1Q8ld2PvKlU?=
 =?us-ascii?Q?f8wlKQG8qamvS8mUfckf6+O22FWqUhvuM/OmnPa+G/l/puJLDKR34hNQvTMC?=
 =?us-ascii?Q?6/+SPwtLCt3Dif0/mxu9MlBzTOW0gnHSqb6CeATRPohZMYugDmM77OvSAzVR?=
 =?us-ascii?Q?8OFkPaInRrSr0/5Md4wFcWTNCjDgKn04?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2024 09:16:23.8472 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75327f40-73a1-4926-6b7c-08dd0f8d5490
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000203.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5906
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

The xarray pointer which has the userqueue xarray structure
reference should be cleared when the userqueue gets
destroyed. Otherwise, we may access the freed xa memory and
see the below warnings.

warning 1:
BUG: KASAN: slab-use-after-free in _raw_spin_lock+0x7a/0xe0
[  +0.000044] Call Trace:
[  +0.000017]  <TASK>
[  +0.000016]  dump_stack_lvl+0x6c/0x90
[  +0.000025]  print_report+0xc4/0x5e0
[  +0.000025]  ? srso_return_thunk+0x5/0x5f
[  +0.000024]  ? kasan_complete_mode_report_info+0x60/0x1d0
[  +0.000030]  ? _raw_spin_lock+0x7a/0xe0
[  +0.000023]  kasan_report+0xdf/0x120
[  +0.000023]  ? _raw_spin_lock+0x7a/0xe0
[  +0.000025]  kasan_check_range+0xf7/0x1b0
[  +0.000025]  __kasan_check_write+0x14/0x20
[  +0.000024]  _raw_spin_lock+0x7a/0xe0
[  +0.000023]  ? __pfx__raw_spin_lock+0x10/0x10
[  +0.000024]  ? amdgpu_userq_wait_ioctl+0xac0/0x1f30 [amdgpu]
[  +0.000442]  amdgpu_userq_wait_ioctl+0x18fc/0x1f30 [amdgpu]
[  +0.000428]  ? __pfx_amdgpu_userq_wait_ioctl+0x10/0x10 [amdgpu]
[  +0.000424]  ? __pfx_idr_alloc_u32+0x10/0x10
[  +0.000027]  ? srso_return_thunk+0x5/0x5f
[  +0.000024]  ? __kasan_check_write+0x14/0x20
[  +0.000025]  ? srso_return_thunk+0x5/0x5f
[  +0.000024]  ? idr_alloc+0x72/0xc0
[  +0.000023]  ? srso_return_thunk+0x5/0x5f
[  +0.000023]  ? fput+0x1c/0x2f0
[  +0.000025]  drm_ioctl_kernel+0x178/0x2f0 [drm]
[  +0.000065]  ? __pfx_amdgpu_userq_wait_ioctl+0x10/0x10 [amdgpu]
[  +0.000425]  ? __pfx_drm_ioctl_kernel+0x10/0x10 [drm]
[  +0.000064]  ? srso_return_thunk+0x5/0x5f
[  +0.000023]  ? __kasan_check_write+0x14/0x20
[  +0.000025]  drm_ioctl+0x513/0xd20 [drm]
[  +0.000058]  ? __pfx_amdgpu_userq_wait_ioctl+0x10/0x10 [amdgpu]
[  +0.000428]  ? __pfx_drm_ioctl+0x10/0x10 [drm]
[  +0.000061]  ? __pfx__raw_spin_lock_irqsave+0x10/0x10
[  +0.000027]  ? __count_memcg_events+0x11f/0x3a0
[  +0.000027]  ? srso_return_thunk+0x5/0x5f
[  +0.001040]  ? srso_return_thunk+0x5/0x5f
[  +0.000969]  ? _raw_spin_unlock_irqrestore+0x27/0x50
[  +0.000966]  amdgpu_drm_ioctl+0xcd/0x1d0 [amdgpu]
[  +0.001352]  __x64_sys_ioctl+0x135/0x1b0
[  +0.000966]  x64_sys_call+0x1205/0x20d0
[  +0.000968]  do_syscall_64+0x4d/0x120
[  +0.000960]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  +0.000962] RIP: 0033:0x7f42af11a94f

warning 2:
WARNING: at lib/xarray.c:1849 __xa_alloc+0x13a/0x150
[  366.491409] RIP: 0010:__xa_alloc+0x13a/0x150
[  366.491434] Call Trace:
[  366.491437]  <TASK>
[  366.491440]  ? show_regs+0x6d/0x80
[  366.491445]  ? __warn+0x91/0x140
[  366.491450]  ? __xa_alloc+0x13a/0x150
[  366.491453]  ? report_bug+0x1c9/0x1e0
[  366.491459]  ? handle_bug+0x63/0xa0
[  366.491463]  ? exc_invalid_op+0x1d/0x80
[  366.491467]  ? asm_exc_invalid_op+0x1f/0x30
[  366.491476]  ? __xa_alloc+0x13a/0x150
[  366.491484]  amdgpu_userq_wait_ioctl+0xe0e/0xfe0 [amdgpu]
[  366.491743]  ? idr_alloc_u32+0x97/0xd0
[  366.491749]  ? __pfx_amdgpu_userq_wait_ioctl+0x10/0x10 [amdgpu]
[  366.491912]  drm_ioctl_kernel+0xae/0x100 [drm]
[  366.491942]  drm_ioctl+0x2a1/0x500 [drm]
[  366.491961]  ? __pfx_amdgpu_userq_wait_ioctl+0x10/0x10 [amdgpu]
[  366.492127]  ? srso_return_thunk+0x5/0x5f
[  366.492132]  ? srso_return_thunk+0x5/0x5f
[  366.492135]  ? _raw_spin_unlock_irqrestore+0x2b/0x50
[  366.492139]  amdgpu_drm_ioctl+0x4f/0x90 [amdgpu]
[  366.492288]  __x64_sys_ioctl+0x99/0xd0
[  366.492295]  x64_sys_call+0x1209/0x20d0
[  366.492299]  do_syscall_64+0x51/0x120
[  366.492303]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  366.492418] RIP: 0033:0x7f86f3b1a94f

Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
index cba51bdf2e2c..311d536a7079 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
@@ -73,6 +73,7 @@ amdgpu_userqueue_cleanup(struct amdgpu_userq_mgr *uq_mgr,
 	}
 
 	uq_funcs->mqd_destroy(uq_mgr, queue);
+	queue->fence_drv->fence_drv_xa_ptr = NULL;
 	amdgpu_userq_fence_driver_free(queue);
 	idr_remove(&uq_mgr->userq_idr, queue_id);
 	kfree(queue);
-- 
2.25.1

