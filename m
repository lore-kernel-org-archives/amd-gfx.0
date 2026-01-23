Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B59CD7788E
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Jan 2026 17:19:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A81489153;
	Fri, 23 Jan 2026 17:19:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YpfUUO6P";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010004.outbound.protection.outlook.com [52.101.61.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A79089153
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Jan 2026 17:19:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vx0hyWs7bB0oAFgIjT+0MPI0RxiNU4h6MyWdwXH/leVn0hJaq7//3uYAsJmRXZTsoeGZjGt9qpVsJp+PnIcpHl+DRKXDNwa0nckxwll4VAuIetK73Pl4cscqNku4pxPs7c6XoTgpBGQK2xII4oUDxfHMgHSPYA03Jr4QmsETirAK1imWAPK1k3HYkzpDBlOk4O7QVekQYTxKhmY8eLkLOI+5/f1BUza1K3xO0KeojJPdUGRYD/qNU1mYqKPosbBXjDEL89Nz1Spk4wQ6Pk93067/ou4BMuTtU8+cUq7spRwkNoloFTz6OrMQYbmyQPugZW/UTTM2qIJR2w0cwzSqwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DX8UwwivK6sZb7ssCWzZ9STgRpW8u7EWikwsnfyHut0=;
 b=BPs+L6mO4mALYFpn+jnkYPNbzKGhlflSQkOkRMhcLGEQUhsrx1rEyqUFDPGZTduGpc6guPMz/KohAZiEgW7clxaYuwxSziRI3XrzIu2epYD3Y4ZtYIPNM4/Pj64TB///WxbuyMWo4v2/6CBXODusVhFKTYZpX4h2kJs9Xci6/XkRKwwgkydQzH5ahCHSPvgQQ0F6fegN/xQL04gTVw0sZgIDaMhvQKhBfDDZ8fQvx58EUh6HzPglcM+IyeXgqD3HgmhxeaskFHfUl/ucn9+45pcaUBnPbUlCsxkQXbuiD0B9NNTIpggKG69dv2+cEwcZrfhoUIGnefe+PJmQez2SEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DX8UwwivK6sZb7ssCWzZ9STgRpW8u7EWikwsnfyHut0=;
 b=YpfUUO6PLgVGpe83d+ggc0L6x6M4gynx5HUst2NDrSnZ7LmTwxOIpKEk6hqbdin/Xg3nEM/dy2Qox+4P6Pb+Q1t4qhtKtZCAcsTGkzweSPTzT1TaNmbNEbP4CaM2oHzYAMgXsMwtmmrtZoiYh/bvzkmRgJEUOMyUBJK1kGnG4iY=
Received: from MN2PR03CA0011.namprd03.prod.outlook.com (2603:10b6:208:23a::16)
 by SA0PR12MB7463.namprd12.prod.outlook.com (2603:10b6:806:24b::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Fri, 23 Jan
 2026 17:19:46 +0000
Received: from MN1PEPF0000F0DE.namprd04.prod.outlook.com
 (2603:10b6:208:23a:cafe::35) by MN2PR03CA0011.outlook.office365.com
 (2603:10b6:208:23a::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.11 via Frontend Transport; Fri,
 23 Jan 2026 17:19:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MN1PEPF0000F0DE.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Fri, 23 Jan 2026 17:19:45 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 23 Jan
 2026 11:19:45 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 23 Jan 2026 11:19:45 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH 01/11] drm/amdgpu: re-add the bad job to the pending list for
 ring resets
Date: Fri, 23 Jan 2026 12:19:27 -0500
Message-ID: <20260123171938.16814-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260123171938.16814-1-alexander.deucher@amd.com>
References: <20260123171938.16814-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DE:EE_|SA0PR12MB7463:EE_
X-MS-Office365-Filtering-Correlation-Id: c5167622-986b-4f58-a357-08de5aa39ae6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4UdCll55tMvxh9BZPZShv2Ipd1mEX+1FU1DmDrun0P52cVQlMiTUjTRvuJZL?=
 =?us-ascii?Q?wclQHJ/iuwexoHKdPtXE0NRYw1+1nNMrZloIgxJ8Uo1NolMUC++ywic+Ox6i?=
 =?us-ascii?Q?FZ/XseLElzAalH/1y/WVDDMEoZsdX7HwfwKekInHDVvxPfG4zcOOS99v/fRs?=
 =?us-ascii?Q?Ipu2v7tdGo9Z0shec1w52V8z+chsuFqDpp6D/8NLmEeSN8G2Rppy6b+f1KnL?=
 =?us-ascii?Q?JsLWNWf7Xo50XNZtxpbnLKIcydxuBYhZCP7/a3edvaXO/e57pIibSf++94M2?=
 =?us-ascii?Q?XzhGeEIIYGnNN2GpwUNAQxYn1CGGl2/C+zrG60JJKnhr9UMBiGs9lrPrSDSJ?=
 =?us-ascii?Q?f56FGa2ZKkHISRbLLu89qxdA9xZ7iMIdF7kgm8Nlv9HQ1FL8WQAQ1bGX/psV?=
 =?us-ascii?Q?HNF4Rgk8lGxVZUa3w7FluHccAG8sba4Q2/jO4zP33lhkPNgQTO4u4Rr7upPL?=
 =?us-ascii?Q?eSLQF+2cGLdKg3cUpqRLcmXk9EdDnR9mDE87jb+eXsfH7f7dveFRZIWtoiLu?=
 =?us-ascii?Q?8Cn5Rbl4W6iINr26T+XSJ9QlDt4X36VmrSJ1VRZiqPY1Epd8h5AC2AB4CmOT?=
 =?us-ascii?Q?OVfYJylC+x4uK/X+XAJcjl7qIwt/DxW/y6B9nutveDwmR8BPCOAOnftYEE0Y?=
 =?us-ascii?Q?wJyXDGgYz9kQAYjo6Yh1ijNV81x8rRgzPDHFq1SQjWo7H2uIJrK5VpbhVgIy?=
 =?us-ascii?Q?BHIe/WJHWtLdypchP2ljFoanL5aeUd0gjwUNt7fxsz7KDEYt8onIW7CQ9PWM?=
 =?us-ascii?Q?LljFCNzyufN19GfO/imnEZEVo75Eqd63ED5BBRSqZyX3HP3AsZzprzjgdPEs?=
 =?us-ascii?Q?+gW1aUz1lEZ1UecgAgEP6Ze7v3LklIT2cs4Sniguurbh8nPSgjA+pux1FyUc?=
 =?us-ascii?Q?SEj7a/FStr2zw8TM0KuUnhix+DYoKMQ1GxWgoERCXpqj/Xwhioqz1yNF61xO?=
 =?us-ascii?Q?9j4tXrTKorOfY8kmwJEd8fx33hIRbIj/0srySxUtgK14zSVoy5yPNaMuJmVH?=
 =?us-ascii?Q?iZJlmqu/NS5jnVEbaGeEcJyF6nGy/SLyWjJoriO0OHrgLEWc0U5435yN365N?=
 =?us-ascii?Q?Kzyhc6LL8/jNeBTqflHvzUKRwieJ4JuLrcG6v5e/p9YIhY4KWM9oMxJCXH7c?=
 =?us-ascii?Q?k94YqrJAFUNdrgasy1s+CpKNV8ey7SEkJMgoHx2C34n7cUAbrPSKYy7UxpMV?=
 =?us-ascii?Q?APnBM6WfbGmDuz/a89knprLO0trwVcijJEnZa/cs75Lx10EL9dvBq5ZkftIS?=
 =?us-ascii?Q?5pv8YOTHvFYzJ9C7aj5GY6KkEpugoVgOr2HDx1B9V46jGtRo0CBKB09XA78L?=
 =?us-ascii?Q?Vkx+rmmX824lTY7TSFYE0VDvTablhh+fzNm1XeKOOqfJyREl+oJ11HQ0mh57?=
 =?us-ascii?Q?6MpQZ/nURnChnzvkhi54zzCoi8T5eteFtHb2b4O/ILW3AUnUS89ZHPwUsqQD?=
 =?us-ascii?Q?QpHF89c8D/r+BR/rZGl3JomnnEWbLh7vtFm/zYGukglcuSrtNgOxFDntQbRM?=
 =?us-ascii?Q?Ip643XPlWUzu37LWPvwyJqX1JLxBvYnN54f4r8ywSDGF/4usmgJWOrhNc64a?=
 =?us-ascii?Q?DI9A+miUL+p7f1Xw9FQGSv/knnSR9/+3SaPUPsD6KVDQ8V9+Njcc+cWUydZM?=
 =?us-ascii?Q?NUDIqTWzteBngCy/VRSDULzvPz9efC1mYCZ7bYmYaYjDYS9JYaD4bJs2I7ae?=
 =?us-ascii?Q?yx8vhg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 17:19:45.7728 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c5167622-986b-4f58-a357-08de5aa39ae6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7463
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

Need to re-add the bad job to the pending list before we
restart the scheduler.

Reviewed-by: Jesse Zhang <jesse.zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c  | 6 ++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c | 4 ----
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index 1daa9145b217e..ec8d74db62758 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -135,8 +135,14 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 	    ring->funcs->reset) {
 		dev_err(adev->dev, "Starting %s ring reset\n",
 			s_job->sched->name);
+		/* Stop the scheduler to prevent anybody else from touching the ring buffer. */
+		drm_sched_wqueue_stop(&ring->sched);
 		r = amdgpu_ring_reset(ring, job->vmid, job->hw_fence);
 		if (!r) {
+			/* add the job back to the pending list */
+			list_add(&s_job->list, &s_job->sched->pending_list);
+			/* Start the scheduler again */
+			drm_sched_wqueue_start(&ring->sched);
 			atomic_inc(&ring->adev->gpu_reset_counter);
 			dev_err(adev->dev, "Ring %s reset succeeded\n",
 				ring->sched.name);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index b82357c657237..129ad51386535 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -868,8 +868,6 @@ bool amdgpu_ring_sched_ready(struct amdgpu_ring *ring)
 void amdgpu_ring_reset_helper_begin(struct amdgpu_ring *ring,
 				    struct amdgpu_fence *guilty_fence)
 {
-	/* Stop the scheduler to prevent anybody else from touching the ring buffer. */
-	drm_sched_wqueue_stop(&ring->sched);
 	/* back up the non-guilty commands */
 	amdgpu_ring_backup_unprocessed_commands(ring, guilty_fence);
 }
@@ -895,8 +893,6 @@ int amdgpu_ring_reset_helper_end(struct amdgpu_ring *ring,
 			amdgpu_ring_write(ring, ring->ring_backup[i]);
 		amdgpu_ring_commit(ring);
 	}
-	/* Start the scheduler again */
-	drm_sched_wqueue_start(&ring->sched);
 	return 0;
 }
 
-- 
2.52.0

