Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1DDACA0EE4
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Aug 2025 09:43:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B6D710E420;
	Mon, 18 Aug 2025 09:43:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kc9NMLyO";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2061.outbound.protection.outlook.com [40.107.102.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DBF0510E41B
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Aug 2025 09:43:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YAudJmuyBBgUHL8/bo0PnJUo+irWKLKV6qWZWumwN9PQ1K5Js8ORIXUte07heH4SWAJS/v85nO9VWJCN9Ubpnu7NGGfmQghjcLk5V2pRIa4vMKzwzb6pJdShKM/5ZI8JUFeXdnAmg2fcB6wazEHNgahbdSxktLLOYt3+stG0dHdcAhYFx9kDFR4u6HvBhUtgz2ze92wHHdIPfeHbF9lNslkA8cKg9RMICQn37PWSV6PgzXOQ5zrjtrq0kZiNSH4/qqzPb9c8GSc3dRN0HObfrPhMHJk5vIvNfhhyg6fyiK2yl91Fs39NllqxsbETW9rM3rEqKDb+cXMHO0rt08Bssg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S/+6glvGNjlVoHrl6lyXhk8G8GQxy8AKtSIuHEnw0yg=;
 b=EAq1bwvcE1iMAA8eVOE6n8y1l3dr4lvtMQwybgBPSKMLFqI+2HL2g9HtA8Iw/Aj2NX4tgtIx5axNIoXm2t4CA50ueMxRpiwl8V4UpbqAHuGJLP+aYbNyeHTvc5xuRt9NKJCTqkvqVaVlLrMt/BwPzAPI5mJ8eqMiSqbDPzIyyU7pE83XDxzLYcigxJGUJd7TdUh2Fg5HODqJ6ZX/Li26qXZV928CPKyFrwNfgmV2qtf5VSXrwoCzCaKpBAeQqh3waNqD+3hPzlDa0AYxbMgC/Bxp5gG4kbxp/tPmHecSXak+jKCQxWsCrXghvHNRibKnkhTXufrs9yF7gXYgJ1uKlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S/+6glvGNjlVoHrl6lyXhk8G8GQxy8AKtSIuHEnw0yg=;
 b=kc9NMLyOGsars8TGR8GAfRC+oI/LtVaPNAoiZbK+qQVMOado054W0jsaxwxQK41EZn4MwpZZr8zb5THu9GwQOwoWKpzkgExfsxzJf0ZboFJxGeTLHO8BjXkKSrxhUUnk2s8UEFPq1aLrYFhVSHaI2e5K13Q2Qb5XxIYHOtkRI/8=
Received: from BLAPR03CA0081.namprd03.prod.outlook.com (2603:10b6:208:329::26)
 by SA1PR12MB7320.namprd12.prod.outlook.com (2603:10b6:806:2b7::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Mon, 18 Aug
 2025 09:43:13 +0000
Received: from BL6PEPF0001AB72.namprd02.prod.outlook.com
 (2603:10b6:208:329:cafe::91) by BLAPR03CA0081.outlook.office365.com
 (2603:10b6:208:329::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.20 via Frontend Transport; Mon,
 18 Aug 2025 09:43:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB72.mail.protection.outlook.com (10.167.242.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Mon, 18 Aug 2025 09:43:12 +0000
Received: from work.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 18 Aug
 2025 04:43:11 -0500
From: David Rosca <david.rosca@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: David Rosca <david.rosca@amd.com>
Subject: [PATCH 2/2] drm/amdgpu/vcn: Allow limiting ctx to instance 0 for AV1
 at any time
Date: Mon, 18 Aug 2025 11:42:54 +0200
Message-ID: <20250818094253.10105-3-david.rosca@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250818094253.10105-2-david.rosca@amd.com>
References: <20250818094253.10105-2-david.rosca@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB72:EE_|SA1PR12MB7320:EE_
X-MS-Office365-Filtering-Correlation-Id: 45062242-55a6-4a96-5838-08ddde3ba613
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gE6832skufj9hGStzjEnJLDUEGP3k8NYiFZq7WtJGzVkAiUOKA8ZmyVNqLwO?=
 =?us-ascii?Q?vev51EJxXxwSXFEIize7F5VQIVapQvmSoSsE98YEGIxnt6VxGSczt+cn+6S7?=
 =?us-ascii?Q?XbQcxjKUa2YhCqiV0t1o8o4iIodzhHUAS+c3BI0BAWN581ggR94hR90VX/MI?=
 =?us-ascii?Q?/cjtQLj1bA9MubsXXeqlD7EHRzujqHdjW9Gm9CS34hp5QmEaXiko1nK5OUMA?=
 =?us-ascii?Q?uGKWq+bYeSoZL4ZEtvYOSoKBVLam8J9kUOvXqpdKN2N7UVxihk/Hy1thUaqp?=
 =?us-ascii?Q?HSRcNT0pTt01e2CRMsYrJ7vZZf4cwmpoaaaWUdohmKFB/Gn/WPZy8uc/T5ku?=
 =?us-ascii?Q?UhSwgWwo6zFJRG+NsBhfk5p84eJEfAPz5CnrfHNbXuYc29/ZtgjBQASPnvYw?=
 =?us-ascii?Q?JxL10hbUmd2YS6SIcZcv8U5hI96kAKopSSBU/c/4b87CaDq/gQm21wVbILhG?=
 =?us-ascii?Q?D6ct5kdaCAg4FzbpC7WLzb7awpV/rtRX27mk7Kj7fd78OMZg6enbm2W17958?=
 =?us-ascii?Q?DrB4ZsNu3Y7OjfYh9EkId/+MG/gBxj50mpf77PAuYZ9sbeWLePILTxAOi9cB?=
 =?us-ascii?Q?iM9ES3/25ONtjYBdS83JgmGpTp559urZo5vKWVygVrOrN2ak7f72qw8Xysvx?=
 =?us-ascii?Q?bsilIuZjgOys2ZWvkW2fbbuFMy4XOQj265pg/dMytZ83D3DQ94U15ZZ17n0o?=
 =?us-ascii?Q?2rFyg6SDmt5KsuUuou8TtxH93NjQzNsw45opiPfpo7WCQMeh08pstaUKLVOf?=
 =?us-ascii?Q?ELxn1YirSUBd79eVRfbR73K1bxpK43XmhS9FxkDGx4/P80uJc8R9Y1qmOjDw?=
 =?us-ascii?Q?Z6q2cb7YO8rHvo344go6DgMy/udd99jfoXBwMqmwibHat1XORuSNLgxLPJWV?=
 =?us-ascii?Q?c3bwSzQpUJdF0yWsrmDJ9ylwkZonbr63rRlnDmvM5uFMU9o2W79pbIM1H29r?=
 =?us-ascii?Q?6er6odFuUIdupPvCcZTc6f+ym1qlgBm/Z3SQ2paunj4d93VVgdGZsFm/A+6a?=
 =?us-ascii?Q?C24tmzJch01uczSBxG6Qxby7pc3dmSiUc0fU3PpeRz1c8lVStlULgt9l+Q97?=
 =?us-ascii?Q?Kf/FPP5U2NXiQlttgkl7MmbDGjhzfFcfA3ktR3JX6441JamjGbbiXHKu7Iy/?=
 =?us-ascii?Q?wn7DyI3Rvt4CP+upWED1AFGiDlwEkuyLYO3iiIRPI1ZgCkFWDBltrwGJGr/E?=
 =?us-ascii?Q?H5vRyT4mnMk5WF1bDrHQBqa11rXwKTElI6IiTZptw9qexjZ4j2ALnt8Se0+l?=
 =?us-ascii?Q?zRPI8vqXIXUZ69JvPS0i9EIgTbf/+VXxXsbf7VwpZ/cpPxyA19hkjzIa1pyH?=
 =?us-ascii?Q?5Y048PW1M1WhJo+xwzzmteN4t0hdSl2BLjba21IqDhzyjMB2mKEoVF3jKqrx?=
 =?us-ascii?Q?7rQmNQMca0Fv/a5E93IJc1tloHK+Bw46kM5/DKrXMbIJwDZixtz12gVH9NvN?=
 =?us-ascii?Q?1TRoFDlorZQRpdgu1Lj+2YhOyRhoteaOk5k9Jq3Bx/pczHStE63/THrGy2dH?=
 =?us-ascii?Q?DvNdhaRj6oxJngoUC7eZ3vetpxzgMSChglQ3?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 09:43:12.6772 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45062242-55a6-4a96-5838-08ddde3ba613
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB72.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7320
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

There is no reason to require this to happen on first submitted IB only.
We need to wait for the queue to be idle, but it can be done at any
time (including when there are multiple video sessions active).

Signed-off-by: David Rosca <david.rosca@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 12 ++++++++----
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c | 12 ++++++++----
 2 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index 95173156f956..f3085137ba08 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -1886,15 +1886,19 @@ static int vcn_v3_0_limit_sched(struct amdgpu_cs_parser *p,
 				struct amdgpu_job *job)
 {
 	struct drm_gpu_scheduler **scheds;
-
-	/* The create msg must be in the first IB submitted */
-	if (atomic_read(&job->base.entity->fence_seq))
-		return -EINVAL;
+	struct dma_fence *fence;
 
 	/* if VCN0 is harvested, we can't support AV1 */
 	if (p->adev->vcn.harvest_config & AMDGPU_VCN_HARVEST_VCN0)
 		return -EINVAL;
 
+	/* wait for all jobs to finish before switching to instance 0 */
+	fence = amdgpu_ctx_get_fence(p->ctx, job->base.entity, ~0ull);
+	if (fence) {
+		dma_fence_wait(fence, false);
+		dma_fence_put(fence);
+	}
+
 	scheds = p->adev->gpu_sched[AMDGPU_HW_IP_VCN_DEC]
 		[AMDGPU_RING_PRIO_DEFAULT].sched;
 	drm_sched_entity_modify_sched(job->base.entity, scheds, 1);
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index 23b98f011879..235fc9e01dd7 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -1805,15 +1805,19 @@ static int vcn_v4_0_limit_sched(struct amdgpu_cs_parser *p,
 				struct amdgpu_job *job)
 {
 	struct drm_gpu_scheduler **scheds;
-
-	/* The create msg must be in the first IB submitted */
-	if (atomic_read(&job->base.entity->fence_seq))
-		return -EINVAL;
+	struct dma_fence *fence;
 
 	/* if VCN0 is harvested, we can't support AV1 */
 	if (p->adev->vcn.harvest_config & AMDGPU_VCN_HARVEST_VCN0)
 		return -EINVAL;
 
+	/* wait for all jobs to finish before switching to instance 0 */
+	fence = amdgpu_ctx_get_fence(p->ctx, job->base.entity, ~0ull);
+	if (fence) {
+		dma_fence_wait(fence, false);
+		dma_fence_put(fence);
+	}
+
 	scheds = p->adev->gpu_sched[AMDGPU_HW_IP_VCN_ENC]
 		[AMDGPU_RING_PRIO_0].sched;
 	drm_sched_entity_modify_sched(job->base.entity, scheds, 1);
-- 
2.43.0

