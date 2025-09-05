Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E75C6CA1012
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Sep 2025 03:20:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 801DD10E26B;
	Fri,  5 Sep 2025 03:20:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="v1Taw4Lp";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2081.outbound.protection.outlook.com [40.107.92.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D291E10E26B
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Sep 2025 03:20:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oICRqtHlPPiH+vx0aQs2r/9CMNyWW48DDdMih3+EWwGzTw/YKFkv36rgjifPsZG2TXW1H1yE+OnqsfpGGr7Hwr3GTemlWq3tyqztiYT9qPh3+BcMvdkOxAvUfHSBHccFu5X/Rwgn1sMTN0Oo6+g0UmuYJRE3wu8ApeXJUIUiQl31P0KrFEJ2PPNk7kOF3dBGLbxPE6BBjDyK0fI3EN2wuitvICMk5WrFQl3ixrJ/S1r3leFn2P6QW0sk65m4E9XhxtFFuBdn+ZY6ltdWUQcct56TQ4xOFPYNRMcBRcLI59ZJgRXIBvAJqpLWNGIahnqYTsm7xaRRwrW8eNM2pJGu1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=292RZt+aMk2PMty0Obky6ITwki7ZpZy50FvM6RAUv84=;
 b=lRiGbXnO8J5+F6azRgHtVIxqf6FYJ1jgNVh9vlGcW1UsPWwbyBYXMAvUvqbk6yMiwcxblGrwg/mMj111/c+3nhYPCCGwcyMTDnSGUAv3G/PgO9Ih+reWBCntrODf0OPgsliJuSQ2GJRcxVj/2p3BSFlTxKJyuDjQDhfYIx36TSjdAAwxDEq15Rftsieeaj4VCLqCZhvXUyf79Nq5b8elO9qFPrj9FDTNGrdLrVLXR1jQwBqwJ/UTVwmhXHQXi/JZr+MuQl4iJeuNmRnQTn+FPuucWGChvOomnXlRVg/SYb5TrrUHiwu+DgaFB4b+coZkMq10FrbISzMzQpBYXmfi9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=292RZt+aMk2PMty0Obky6ITwki7ZpZy50FvM6RAUv84=;
 b=v1Taw4Lp5InmRlF42kSlMcc5iFW6x86apoT33jdqKkp6SQ3wyp1ztOx8n0zmxNbal0xA2LvhHtjiHj5Co/p9kLY1hGNoyOSbvcEKN4u/VVRP8KQNnRH9RD2vf9pPj4Zo83gueIlhN63cfg6yYcVyDWFJhBF3sYoJUw6c1QRD1Ok=
Received: from CH0PR03CA0063.namprd03.prod.outlook.com (2603:10b6:610:cc::8)
 by BL4PR12MB9535.namprd12.prod.outlook.com (2603:10b6:208:591::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Fri, 5 Sep
 2025 03:20:35 +0000
Received: from CH2PEPF0000009D.namprd02.prod.outlook.com
 (2603:10b6:610:cc:cafe::9) by CH0PR03CA0063.outlook.office365.com
 (2603:10b6:610:cc::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.18 via Frontend Transport; Fri,
 5 Sep 2025 03:20:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH2PEPF0000009D.mail.protection.outlook.com (10.167.244.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9094.14 via Frontend Transport; Fri, 5 Sep 2025 03:20:34 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 4 Sep
 2025 22:20:33 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Thu, 4 Sep 2025 22:20:27 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.Zhang <Jesse.Zhang@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/3] drm/amdgpu: adjust MES API used for suspend and resume
Date: Fri, 5 Sep 2025 11:19:25 +0800
Message-ID: <20250905032026.3256999-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Jesse.Zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009D:EE_|BL4PR12MB9535:EE_
X-MS-Office365-Filtering-Correlation-Id: b4570401-5a30-4e2c-9464-08ddec2b2d66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TjI1isJ8/coaNiWBGgJ1UNlq+57m1g13vmu9mi218I+3IuTsXWSg+68jZkk4?=
 =?us-ascii?Q?BUPOYLItqiMFket8+fRA9qdYXdQ9mzLWV4MSi14iMJKAA1s58BY+BVJ3V1ct?=
 =?us-ascii?Q?ay5to8iCoY+WvJuCQ3uz/NiXeBzGJsAswrmkwmUReyjXtwukgh0ScQO+X22J?=
 =?us-ascii?Q?8eyWyDvKMXVMSdga4BEW6aBKDOU33Fpr5ibhf4PSSP/HnTVXO/gpDHe0xw2M?=
 =?us-ascii?Q?6rV3D5lkWxRW11Gzw05Jziy5Y+myaovQRl+e+UICJoZwt618gfDwTMiaKKyo?=
 =?us-ascii?Q?XZlVAnvjjJ97KZDqvwHWn4EG/yqItxWNAZaTHU4DThbsiayBAASChYwRQsa0?=
 =?us-ascii?Q?dvju4VNJQOngkw5s5kKGH6k1BAx6a/yQFrAK9+S1XS7YuBHkOybptRoszf/H?=
 =?us-ascii?Q?uURetoZ9+4Red/tfHzaEa9wkMZ7nLWRVDN6RZAfmHX7jnJ62vC2W306M2vLo?=
 =?us-ascii?Q?VI5kWzT9lhFzOHw/C0g4LIPR8htbyZ53u7+7R3cktIS44BkqNghqUd6JVGd4?=
 =?us-ascii?Q?715+c+8Cse/ZrKaW7k5DrB6lK6ZMgu62Zf5j1/C0VRatnWgVj4H4mRoxDIfe?=
 =?us-ascii?Q?reHGfvJls2grYO6pyxZThRq1j+M5n/e/6DHhbPa30ioOMn4nxWlKv1PMmTvI?=
 =?us-ascii?Q?P5GirSYWKhiyM12MZv3cOLJcA1ye2yz1sUeymqpKfHdwK3VyKNfktV1ywHFS?=
 =?us-ascii?Q?e227tPA+gbuYL4RWPHi62cOxZf0q9vbpfXtrNF/QyVcvBcAwengwFuTL6Lqb?=
 =?us-ascii?Q?/LvW+LoyP4ZD20zchMmrF/uHcnKBLvUx4syEPSIHPVoW4yMmHhVVf8UAa8me?=
 =?us-ascii?Q?h4A3AeeiNbnO2nnEwWiSFSZLbMZtbRkO/C2d6TZ+p5dErmtZTcw2/LT8Kb3N?=
 =?us-ascii?Q?xP9capARuJ00uvmcxwdwDum/8CopEe8xh0AwpakTO7lNg7ce8HM98IX/Kjmj?=
 =?us-ascii?Q?m4yCMXuhe6rygbAJCpClArBDoIJa8RC3OE8XSpD7SDgJ0CTsfkEOpe4tG2Z7?=
 =?us-ascii?Q?kXyv5JJmJBUH5q5dILOh6kqe7xR6s54XOQgiA5G+3dxt8vAqIWtYd7c/rYLL?=
 =?us-ascii?Q?17yl4lRXavc9sds5+C6FtEbBjyrch/FeihZDDrLDlVo2Tj+5MaxMjiptEfhC?=
 =?us-ascii?Q?0bZwZdnkwcr7ME+hYd+tAh/+UfMA26t3mPPT0bmUI+mU1fzlolnLJnlBeexz?=
 =?us-ascii?Q?NVRkoEzmKRwexTFBlbXuauygzTkHHPgNSAnJJdvPEF7LfW5BbQ4uphDzNCL+?=
 =?us-ascii?Q?aknBTk8czOoTTLSJ6byslxiIxI2probgRpJrlRFtiRmI58ff5Sypq5Dt8fRV?=
 =?us-ascii?Q?qFgYjC8q9UBGWaO4JFHH9YrQ0huM/Bh/fXHRCjRv7DbD1yXc4+VlUov+0WV4?=
 =?us-ascii?Q?6iSKSF+u49rjgzCuMs0P9ep3ZAdFlyekk3EKOVYE/4GXx9HCLU5zTUqvAT9a?=
 =?us-ascii?Q?y8l4NbeJF4mpktMxoOB6ErV/9cMkzSg8f8lurVyBlbigIglVc5vkr+TscnWu?=
 =?us-ascii?Q?m1jIs1A30wqjUnFO7Ik/w97s+OZ82z0mJrUJ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2025 03:20:34.5358 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4570401-5a30-4e2c-9464-08ddec2b2d66
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9535
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

Use the suspend and resume API rather than remove queue
and add queue API.  The former just preempts the queue
while the latter remove it from the scheduler completely.
There is no need to do that, we only need preemption
in this case.

V2: replace queue_active with queue state
v3: set the suspend_fence_addr
v4: allocate another per queue buffer for the suspend fence, and  set the sequence number.
    also wait for the suspend fence. (Alex)
v5: use a wb slot (Alex)
v6: Change the timeout period. For MES, the default timeout  is  2100000; /* 2100 ms */ (Alex)

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 72 ++++++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index aee26f80bd53..10126edd534c 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -395,10 +395,82 @@ mes_userq_mqd_destroy(struct amdgpu_userq_mgr *uq_mgr,
 	amdgpu_userq_destroy_object(uq_mgr, &queue->mqd);
 }
 
+static int mes_userq_preempt(struct amdgpu_userq_mgr *uq_mgr,
+                            struct amdgpu_usermode_queue *queue)
+{
+	struct amdgpu_device *adev = uq_mgr->adev;
+	struct mes_suspend_gang_input queue_input;
+	struct amdgpu_userq_obj *ctx = &queue->fw_obj;
+	signed long timeout = 2100000; /* 2100 ms */
+	u64 fence_gpu_addr;
+	u32 fence_offset;
+	u64 *fence_ptr;
+	int i, r;
+
+	if (queue->state != AMDGPU_USERQ_STATE_MAPPED)
+		return 0;
+	r = amdgpu_device_wb_get(adev, &fence_offset);
+	if (r)
+		return r;
+
+	fence_gpu_addr = adev->wb.gpu_addr + (fence_offset * 4);
+	fence_ptr = (u64 *)&adev->wb.wb[fence_offset];
+	*fence_ptr = 0;
+
+	memset(&queue_input, 0x0, sizeof(struct mes_suspend_gang_input));
+	queue_input.gang_context_addr = ctx->gpu_addr + AMDGPU_USERQ_PROC_CTX_SZ;
+	queue_input.suspend_fence_addr = fence_gpu_addr;
+	queue_input.suspend_fence_value = 1;
+	amdgpu_mes_lock(&adev->mes);
+	r = adev->mes.funcs->suspend_gang(&adev->mes, &queue_input);
+	amdgpu_mes_unlock(&adev->mes);
+	if (r) {
+		DRM_ERROR("Failed to suspend gang: %d\n", r);
+		goto out;
+	}
+
+	for (i = 0; i < timeout; i++) {
+		if (*fence_ptr == 1)
+			goto out;
+		udelay(1);
+	}
+	r = -ETIMEDOUT;
+
+out:
+	amdgpu_device_wb_free(adev, fence_offset);
+	return r;
+}
+
+static int mes_userq_restore(struct amdgpu_userq_mgr *uq_mgr,
+                           struct amdgpu_usermode_queue *queue)
+{
+	struct amdgpu_device *adev = uq_mgr->adev;
+	struct mes_resume_gang_input queue_input;
+	struct amdgpu_userq_obj *ctx = &queue->fw_obj;
+	int r;
+
+	if (queue->state == AMDGPU_USERQ_STATE_HUNG)
+		return -EINVAL;
+	if (queue->state != AMDGPU_USERQ_STATE_PREEMPTED)
+		return 0;
+
+	memset(&queue_input, 0x0, sizeof(struct mes_resume_gang_input));
+	queue_input.gang_context_addr = ctx->gpu_addr + AMDGPU_USERQ_PROC_CTX_SZ;
+
+	amdgpu_mes_lock(&adev->mes);
+	r = adev->mes.funcs->resume_gang(&adev->mes, &queue_input);
+	amdgpu_mes_unlock(&adev->mes);
+	if (r)
+		dev_err(adev->dev, "Failed to resume queue, err (%d)\n", r);
+	return r;
+ }
+
 const struct amdgpu_userq_funcs userq_mes_funcs = {
 	.mqd_create = mes_userq_mqd_create,
 	.mqd_destroy = mes_userq_mqd_destroy,
 	.unmap = mes_userq_unmap,
 	.map = mes_userq_map,
 	.detect_and_reset = mes_userq_detect_and_reset,
+	.preempt = mes_userq_preempt,
+	.restore = mes_userq_restore,
 };
-- 
2.49.0

