Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B788BE77180
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Dec 2024 14:26:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D95AA10EDF8;
	Thu, 12 Dec 2024 14:26:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UvK0FiS6";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20613.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::613])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DDF2010EDF8
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Dec 2024 14:26:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ct897YMiNLYW0L+2D4xoWmTyr3M0lnwUeDbiNLRJbnV+sdzGHqA3354XlfLpcZPQFL699LYvwI8RNkm8L+sUEgTiV04YXXGDzuIAb9n7QUCPgn/JWmfugVpwG6zohBWHBlV6GVOYip7WgBXZc9+tMMXcpAwMn7oq4P36A2/rtEJeQXasfPrVt3UUo4EqignAXqzGDLAXl3XMV/1bNdbjKdoDhT5gA29+MFJ1h44hV/QYwX4v22RCKZg1xpuY9z/Q6+mtgSPNt8HhpbzhkDOSMuWN9FYEvwUt7hoOEMJnlCWZayHfjcLYm3mAqlo4USNnXkRukHJZJCLb6QBJkS2P5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ivjWVNdrfJOemzre7sDelVkmFbNRN3xX2JeXqfxYfUY=;
 b=f19ZnwrzDmw9vrRwQeqQdddNWu9ePbdIAdG9EkoWwBQ0WX+VJc5xbbi+jxuyL8mWJGai3lf12tMT1ozjU7pF3YtGxCrwXCrUln06WItG/670OhwdP4X2RTyT/uY+PFiz9WgYRa+/4D1scmBi77ZVlFnli+gGhVom79jjIy0QOg8DUiCQzmSIFihCcQC05vxpAeHF4wf8hkh5stUodih8IYzFdVGEF84iUdVc3Vy3wtVmX+nvhyLtNxKCWp2uBBF/HzU6soLDdExulbf19gC25k5OhkDS6MX2ImNHBvQpTt8JIACynHeD6YCC16prKMn9+Qu6SSgQnRkfsSfTtGEdXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ivjWVNdrfJOemzre7sDelVkmFbNRN3xX2JeXqfxYfUY=;
 b=UvK0FiS6vLm8ovqhWud/WZz3WAq/dbkQCQkI8BQeft3d9yom2a67SrKGuqL8YZKcH2JOFIwTWAEmhgUQvkYT01hg9gPMApC0pqKtvMb+DTss/Uu9FjhKKcs/JisZAZMx4OOGJJId2ZQv7I1H7NMlXOK3b4M5kCP/K1mnHICwAPY=
Received: from CH0P221CA0014.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11c::12)
 by PH8PR12MB6961.namprd12.prod.outlook.com (2603:10b6:510:1bc::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.14; Thu, 12 Dec
 2024 14:25:57 +0000
Received: from DS3PEPF0000C37B.namprd04.prod.outlook.com
 (2603:10b6:610:11c:cafe::6a) by CH0P221CA0014.outlook.office365.com
 (2603:10b6:610:11c::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.16 via Frontend Transport; Thu,
 12 Dec 2024 14:25:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF0000C37B.mail.protection.outlook.com (10.167.23.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Thu, 12 Dec 2024 14:25:56 +0000
Received: from amd-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 12 Dec 2024 08:25:53 -0600
From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, <alexander.deucher@amd.com>, "Arunpravin
 Paneer Selvam" <Arunpravin.PaneerSelvam@amd.com>
Subject: [PATCH v2 3/7] drm/amdgpu: Fix the use-after-free issue in wait IOCTL
Date: Thu, 12 Dec 2024 19:55:29 +0530
Message-ID: <20241212142533.2164946-3-Arunpravin.PaneerSelvam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241212142533.2164946-1-Arunpravin.PaneerSelvam@amd.com>
References: <20241212142533.2164946-1-Arunpravin.PaneerSelvam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37B:EE_|PH8PR12MB6961:EE_
X-MS-Office365-Filtering-Correlation-Id: a1158a22-5cc4-4509-9213-08dd1ab8e479
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?E0ECoK3c01UkEi3GMlf0Shr/YtglpfG/s/4gxIlh1076SYnz3XqRjxvVP7k6?=
 =?us-ascii?Q?OFSy/FYNIQsmgg8C2hKgVG7cip5SSKdZkjN5NrC2rIdjEokPwZKABJmQmAcT?=
 =?us-ascii?Q?MQBzTL79B2joNKOhcAB/UStb+FOxTxvCklUimxjPxC0P6OVYI52fIwXUqBSc?=
 =?us-ascii?Q?S/RnLz7NADX9oCN3tcEvmexNupiZSQXavT+2bycUSGQIJ6vuUSPo9sffMNYG?=
 =?us-ascii?Q?edadAQSGNPn4/e42tnsCz/3KJV0RW9fBLDEVJ8w90XKmGvtgt0ol6YWGhGz9?=
 =?us-ascii?Q?parfGwngNL7x4NKbeXQ4qhqitbv3gLEGEYLl10bzLUcg6iGKq+jebAzMVUp4?=
 =?us-ascii?Q?EMakpEUsyz09QF8IQPHzPhMkDjtSrE+p+GVhcd6eWYap+akEjFejTBoGHjQR?=
 =?us-ascii?Q?5wsQkI39rasRthan2Dq2Bjec381zrMBNs+xE5pcEBWmGkRJG9k2vtZOcL8Ej?=
 =?us-ascii?Q?nBGB2HoBPuvH9pEmwJzkgp7E0Z44wc0N1PzooE+jejk6F6BjMtj7o3IgneUD?=
 =?us-ascii?Q?VsUN3guYacqvYRyhNACiS2bCiELF05VVf24JjXKzbjkVhr8Q4Gz3jTynW6i6?=
 =?us-ascii?Q?2lB0Usqzdi6F1lu4bZ0zFNspFpfs1vCvxjaiMTJm4+MGOHPrWxQukYtHj3+E?=
 =?us-ascii?Q?YLfdk33xJnI0f1ePVLLrEgZ9Um8n+duErqJEplvfX4GOu3F67yUuqMghKtmM?=
 =?us-ascii?Q?gvFa/5F140YBAT2+/pPhLf9Yk2E9BlUusGjy69Yc92/hMirbd3AY7kPB+gZS?=
 =?us-ascii?Q?1Efr+S5GA2JrE8n+0tlg4X2k1ku4dvaGj8LW+CneeHWsBSkcFHO07IqXU+Fc?=
 =?us-ascii?Q?Q5dsD6pKp/weiZhJnblhj2yR+git8h/A1jNqVP3TluaC/5KbIeRne3bNucm3?=
 =?us-ascii?Q?jSo9BXIvcxm1VlMO9BM2GRVk+SLmPzOYE6+lvzHAc2UW2gAa0rhFFoOhGBfN?=
 =?us-ascii?Q?Hr/Z/YdXLpJXG0DCjSMGThQpclUfgpRdm+0Pzh5Lzu83WRqXtzGb5T7lrMaf?=
 =?us-ascii?Q?gPEc2FS7c7ncpEp++CFAzjt3MkwR6C+8e3wzlIxLb0Qldih+c4GN7w6P2Ywf?=
 =?us-ascii?Q?rafmp/dSUIqnAbnBSWstfnyFCowfhjm5YCi2A2rl4BPoWxVt8lz5NpMGMyOh?=
 =?us-ascii?Q?4hCE3U3aioVM+fz9ocp3sO1/c8Y0eqD7Asb+8M+w/+9rVSZNHFQfK0krCqfi?=
 =?us-ascii?Q?wboIGpwLQCEKnSOsxJ0jjtLPrxktwaecsf4jLRXaAmMHq9eN+Gf15yb4wTux?=
 =?us-ascii?Q?tgmLETq6yT0ZosjGyheblSo15mle0Lur0iOX6YS5JTL3E3tvt7k8w2whdRv/?=
 =?us-ascii?Q?IDY3xlbsnVUGe7HeMWjpesWbiDqNsUmBJBugBe1DxNHf2Un0f9G8bI0YNS0X?=
 =?us-ascii?Q?iH3P1+wMD9MEfYeT7bJ35cRTFqLsde2kw75gt5GYAzWa9CEQln1x1HSWopCH?=
 =?us-ascii?Q?wKijj7GT+nscKQVQpF++ZKqPQwU6J7Ds?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 14:25:56.4861 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1158a22-5cc4-4509-9213-08dd1ab8e479
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6961
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

