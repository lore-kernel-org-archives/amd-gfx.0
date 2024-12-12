Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17B36E7717F
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Dec 2024 14:26:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B59C610EDFB;
	Thu, 12 Dec 2024 14:26:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="07sJUzs5";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20605.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::605])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D54010EDF9
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Dec 2024 14:26:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ug+XU2r/F++QqPYLKYbRTo+/pt1YpipPN1NWB7H4kKVniqhR+MoHw2Ano8EyivYUAmdt33vUD/MhKJIsgCTM2sY8umi/FdSXGczA1H6Ga+wBgUtxSIsuxl+iemXADHK2hbiyNH64S6pOitsDGpn5fqhS5+Hg7LUwDIJhHYdZsg3vKuqvakB7nx/pLTCqYjywmacr0qcyM3XXcxaAUGANLNIiBanEBmlufHuKiD3bE3zEj4V3TxcFhyk9Jtn6nwk4TFU09Ljc2H09dXZB8xl5boDSYKcQWMYFNQ9M+nowByDiTN4NGPF8YMJNaJ4V2zbKlEsE5GVAaumJgCUPXg06kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i/+3SZOJygGmv3tKmtjs5EZyGqpQhcJFAlwbjaYmJB0=;
 b=Py7bAC3kgEOkLxntpGGMKQMKqnEiHeK373sqJvnK+LvfUU/O5WqKMUJq6rIlJNFaUQzTGraLhOgtAbZ/7le9rbleo8EZbljka10sWW667Llq54eDragADKw0Mfy17aMmmADOwv+8FOdz2xL0HXmtkDVqyjTPvNND0pG6LDXANskICGRpzPoQQJf2Hv7S74WnamzajgDttY0NYnqWm+PACn4ddZArqf/8x5BLshnFWb7peqUEzc1w++cJWQ7Xv0nfigF3saSyFVWZLOz/kXPKqURclk5Rs32VTzSPra8ZFZq18vgiTWghvzanXX/gg7iThaAfjNCgfqTwQhbjKymA4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i/+3SZOJygGmv3tKmtjs5EZyGqpQhcJFAlwbjaYmJB0=;
 b=07sJUzs5FtCpT8wpleLkSUmSykQNZoyFcMJ/A1nfoR7H8p0+JIZVJZ+7NCvniUbZjlkVyrZnHU2Q2eQGdoMW5LtHwFg/nYlqc2odt5veP7YEd6vqEy6EgWZ5H/AY975YLkNmQXSIZe2jJMmoQzw5/e7ZMWyKvGWWA9d2/+rFwBQ=
Received: from CH0P221CA0024.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11c::20)
 by DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Thu, 12 Dec
 2024 14:25:57 +0000
Received: from DS3PEPF0000C37B.namprd04.prod.outlook.com
 (2603:10b6:610:11c:cafe::f4) by CH0P221CA0024.outlook.office365.com
 (2603:10b6:610:11c::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.15 via Frontend Transport; Thu,
 12 Dec 2024 14:25:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF0000C37B.mail.protection.outlook.com (10.167.23.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Thu, 12 Dec 2024 14:25:57 +0000
Received: from amd-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 12 Dec 2024 08:25:55 -0600
From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, <alexander.deucher@amd.com>, "Arunpravin
 Paneer Selvam" <Arunpravin.PaneerSelvam@amd.com>
Subject: [PATCH v2 4/7] drm/amdgpu: Fix out-of-bounds issue in user fence
Date: Thu, 12 Dec 2024 19:55:30 +0530
Message-ID: <20241212142533.2164946-4-Arunpravin.PaneerSelvam@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37B:EE_|DS0PR12MB7726:EE_
X-MS-Office365-Filtering-Correlation-Id: afab9b5b-de4b-407b-006b-08dd1ab8e52a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LvAlS3oybx5VDs/9l5qy0BFMjOOo9kPHGiJRlzGXBZnPkWyO8pqtv4YHhBmW?=
 =?us-ascii?Q?78uqZnMBEBHjMoldqbLOJGThqHXTnJNiZu5zl9om0qhFrEuStTy9kCh1YdXy?=
 =?us-ascii?Q?8TngO1rfnoZxhZs6BbY9YJxLU1SjOwgrsx27tPbYOyq2CDoUCSz4cUJddPdt?=
 =?us-ascii?Q?VWyBfAhwEHFiuD8Xa1WKsxnnkB228uKgvxRi3g6lWGbi5D3Xn4PojX+9wBCA?=
 =?us-ascii?Q?vnaiNoYb5iTrpxvpoSAABA4gVaIvhp7uuDxsNoWbnQbUfdusj5J28w+R56xO?=
 =?us-ascii?Q?cP+stDg4a/U8rTPx5LJSZ3lw7mG3ylVMi6ZMu1+2/Y9XxCAP1ksuYhlGolDr?=
 =?us-ascii?Q?rsZPeC0iBYQpwgwbYVL6YYsJh5RRd6haxW0uQvY7wDLGEwIvwYMeSE9hKTn0?=
 =?us-ascii?Q?fcaElZJRmtDLbpYsN4mDX42l6+PS65+SITtydYpkPEvqcSy687Yur/C+8ZMM?=
 =?us-ascii?Q?lLlIAAgFRmym3rLX1/pMF5ZUuYbVS7CwXUVvDrQH+GheJvo3gyErkxedawXc?=
 =?us-ascii?Q?3fbH7QxnVc+xm7WK9XIUGCqQIQJTVGpHfgPcSs32ca0yYAgeDkhS5vg6VtCJ?=
 =?us-ascii?Q?9Ja0VN9RramLrNZJcl3wA9gNlI8YX5i7OpICUZm2csUGaRt8FX7KQLRyQwLc?=
 =?us-ascii?Q?b7V7leufTR71vmEnDJRLtdg5GsNtrT+8JULJcLEwHisAMJ0h6PO9zufZRilo?=
 =?us-ascii?Q?cTeKPM/LkH8VX51nuV04D6Q/cF8nrwo16oKfbwyelsh6PurBQIep3afKKMBA?=
 =?us-ascii?Q?hbE7NwwIzQ01wuuX11ivKLWddjtD9PJKp3QnZ5mo5Hg12FFft8hDFyKIcdFV?=
 =?us-ascii?Q?C+EzLe1LV70vRkYnM0Bi1sGBIgInRx2tS9tcpRHLPBuyuMW5WPb3zBygLQFD?=
 =?us-ascii?Q?LfZ7HAFJghTIx4xD/Sg4bY+DD/7DYGfzKKNzO2rXmg3hJCh0spRTE7fvvpeT?=
 =?us-ascii?Q?YWzqkAiv/3+ukh2PwAWaGn11UXHUdGy/Fk+31qx9emo21mhVhvPu5qKkLoLn?=
 =?us-ascii?Q?zGr0zzz9f4D8KIkcRT6vn3fNsc1lLdnqqFwD709WHXkUVxbFkSKmqwHqC7yx?=
 =?us-ascii?Q?usUmW0AqIzlRM8kh7elbUCukdMeegdHuqhqAIBPiiUYAErNtK7LflhkbsZgA?=
 =?us-ascii?Q?e8VZQ4LCYgxPT4qrCSeKZY+WCaxs0o/DUY4mPTw6j+7zFrR+vKHr3uYbr+RX?=
 =?us-ascii?Q?3ScriFtpwdW7P6Zlt0OzzuvEkezpUcJUGjVKJBbyLYpBbU0mEAMraLnkkxfm?=
 =?us-ascii?Q?WGG8x6AF1FDjn8O44RLAE9iWcJeQQX0JmlmSkvQpIrBK4Y8m0TjtCSOXeMyZ?=
 =?us-ascii?Q?mghV5MYNNTTw5aUf8VocpRjlMVBD2UlZBwP8yq6mafp70l6TSIXbbetwREOG?=
 =?us-ascii?Q?sQlfvNNtPHpG9ZB5H9+9AEaK+Huh5AWJpM7oJlLUs89To/Y8/P0n5o9aIZBU?=
 =?us-ascii?Q?Cl7/yR112JQXoxjxOwzX13iUdPlXS9Cz?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 14:25:57.6424 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: afab9b5b-de4b-407b-006b-08dd1ab8e52a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7726
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

Fix out-of-bounds issue in userq fence create when
accessing the userq xa structure. Added a lock to
protect the race condition.

BUG: KASAN: slab-out-of-bounds in amdgpu_userq_fence_create+0x726/0x880 [amdgpu]
[  +0.000006] Call Trace:
[  +0.000005]  <TASK>
[  +0.000005]  dump_stack_lvl+0x6c/0x90
[  +0.000011]  print_report+0xc4/0x5e0
[  +0.000009]  ? srso_return_thunk+0x5/0x5f
[  +0.000008]  ? kasan_complete_mode_report_info+0x26/0x1d0
[  +0.000007]  ? amdgpu_userq_fence_create+0x726/0x880 [amdgpu]
[  +0.000405]  kasan_report+0xdf/0x120
[  +0.000009]  ? amdgpu_userq_fence_create+0x726/0x880 [amdgpu]
[  +0.000405]  __asan_report_store8_noabort+0x17/0x20
[  +0.000007]  amdgpu_userq_fence_create+0x726/0x880 [amdgpu]
[  +0.000406]  ? __pfx_amdgpu_userq_fence_create+0x10/0x10 [amdgpu]
[  +0.000408]  ? srso_return_thunk+0x5/0x5f
[  +0.000008]  ? ttm_resource_move_to_lru_tail+0x235/0x4f0 [ttm]
[  +0.000013]  ? srso_return_thunk+0x5/0x5f
[  +0.000008]  amdgpu_userq_signal_ioctl+0xd29/0x1c70 [amdgpu]
[  +0.000412]  ? __pfx_amdgpu_userq_signal_ioctl+0x10/0x10 [amdgpu]
[  +0.000404]  ? try_to_wake_up+0x165/0x1840
[  +0.000010]  ? __pfx_futex_wake_mark+0x10/0x10
[  +0.000011]  drm_ioctl_kernel+0x178/0x2f0 [drm]
[  +0.000050]  ? __pfx_amdgpu_userq_signal_ioctl+0x10/0x10 [amdgpu]
[  +0.000404]  ? __pfx_drm_ioctl_kernel+0x10/0x10 [drm]
[  +0.000043]  ? __kasan_check_read+0x11/0x20
[  +0.000007]  ? srso_return_thunk+0x5/0x5f
[  +0.000007]  ? __kasan_check_write+0x14/0x20
[  +0.000008]  drm_ioctl+0x513/0xd20 [drm]
[  +0.000040]  ? __pfx_amdgpu_userq_signal_ioctl+0x10/0x10 [amdgpu]
[  +0.000407]  ? __pfx_drm_ioctl+0x10/0x10 [drm]
[  +0.000044]  ? srso_return_thunk+0x5/0x5f
[  +0.000007]  ? _raw_spin_lock_irqsave+0x99/0x100
[  +0.000007]  ? __pfx__raw_spin_lock_irqsave+0x10/0x10
[  +0.000006]  ? __rseq_handle_notify_resume+0x188/0xc30
[  +0.000008]  ? srso_return_thunk+0x5/0x5f
[  +0.000008]  ? srso_return_thunk+0x5/0x5f
[  +0.000006]  ? _raw_spin_unlock_irqrestore+0x27/0x50
[  +0.000010]  amdgpu_drm_ioctl+0xcd/0x1d0 [amdgpu]
[  +0.000388]  __x64_sys_ioctl+0x135/0x1b0
[  +0.000009]  x64_sys_call+0x1205/0x20d0
[  +0.000007]  do_syscall_64+0x4d/0x120
[  +0.000008]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[  +0.000007] RIP: 0033:0x7f7c3d31a94f

Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index 3a88f754a395..49dc78c2f0d7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -229,6 +229,7 @@ int amdgpu_userq_fence_create(struct amdgpu_usermode_queue *userq,
 		unsigned long index, count = 0;
 		int i = 0;
 
+		xa_lock(&userq->fence_drv_xa);
 		xa_for_each(&userq->fence_drv_xa, index, stored_fence_drv)
 			count++;
 
@@ -240,12 +241,13 @@ int amdgpu_userq_fence_create(struct amdgpu_usermode_queue *userq,
 		if (userq_fence->fence_drv_array) {
 			xa_for_each(&userq->fence_drv_xa, index, stored_fence_drv) {
 				userq_fence->fence_drv_array[i] = stored_fence_drv;
-				xa_erase(&userq->fence_drv_xa, index);
+				__xa_erase(&userq->fence_drv_xa, index);
 				i++;
 			}
 		}
 
 		userq_fence->fence_drv_array_count = i;
+		xa_unlock(&userq->fence_drv_xa);
 	} else {
 		userq_fence->fence_drv_array = NULL;
 		userq_fence->fence_drv_array_count = 0;
-- 
2.25.1

