Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68661C87FDA
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Aug 2025 08:41:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 091CA10E4E4;
	Mon,  4 Aug 2025 08:41:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ak3LuYlO";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2058.outbound.protection.outlook.com [40.107.220.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 01C3C10E4E4
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Aug 2025 08:41:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LiCDjxhyVIx4pNIZUymbbz+9fB6X6EnQ4toskArjvPShDDmCNJgOPipBrIrI9S2PNJZc4sHmi6RXenjn6yxZWmHlWaWn40s3WHC2VhEZeku5AIb8lSpyK3WBXIxH0yS9qHlzEGj9n6fwOaw6imyha+KXeDKkxjioTvE2xWiOuguHsToP1+QOvqvuwBf0pBegglKr9cNP2akArba3PsPUpDYTJbvQWicGoOwkCASdezzOJ9ZpeFNPzqLodBZizVdHuiIDQ4K2O3kH7y2igHwItXqBXTldNw8lnzJ44ziEtJ6NOPPbeiJ2kaiC24WCxkYQzPKwump5DaTTpRbpatNZlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=isakGMHdGx3NTgZ+ipyWXaslO4LX2Gr0mGjk9iAjXy8=;
 b=VFLpnXrhB3faO5Eq9QXCJiW8ExriqmR0hs+9Xq/RbKr+ZfN4bR87aWDr8HLW7pWD8w6EACbF7sfRD1gMkjmFMQgxQyUkXWGjZCvede3w+Oa8gw/6PvCjtSIXadANOiS4VH1zAAEWp55YQ220y1Vmmv9pxMVNWItNFguFCvGyUON7tNHbYkoMIDQ+l3lK1KGnjEv6081gCKOV1WzSRvVbsLLWTDXJGOeToCUzc4774Y6BlUgsKpQfF5WXOwLiiRAvSw7L1DuXineFJ2f4d/IPssHTRb92BAL9JVOA6TXsZN2grkSbYcXhaSbzOaEWfweOH6CbuxS44pOSO9ZeZi4A9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=isakGMHdGx3NTgZ+ipyWXaslO4LX2Gr0mGjk9iAjXy8=;
 b=ak3LuYlOQMmGA23d7HMJuL82IMcBgEyklgvdyMz9AhiehT8O8XVK81KafS7d62+9rIg0juqSlrK3KEcYzq+rt4so/hkzfzYVw5VrEPg71EOUr4Rnfa3kWHYiG9zWRcGEHVt7OfFOc0zsgOqNf4mkaWWV+WeVyQ4GPuHo0OKf2Oc=
Received: from MN0P221CA0026.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:52a::14)
 by LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Mon, 4 Aug
 2025 08:41:16 +0000
Received: from BL6PEPF0001AB57.namprd02.prod.outlook.com
 (2603:10b6:208:52a:cafe::68) by MN0P221CA0026.outlook.office365.com
 (2603:10b6:208:52a::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.21 via Frontend Transport; Mon,
 4 Aug 2025 08:41:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF0001AB57.mail.protection.outlook.com (10.167.241.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Mon, 4 Aug 2025 08:41:15 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 4 Aug
 2025 03:41:14 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Mon, 4 Aug 2025 03:41:07 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.Zhang <Jesse.Zhang@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [v6 08/13] drm/amdgpu: adjust MES API used for suspend and resume
Date: Mon, 4 Aug 2025 16:38:26 +0800
Message-ID: <20250804084029.863138-8-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250804084029.863138-1-Jesse.Zhang@amd.com>
References: <20250804084029.863138-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Jesse.Zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB57:EE_|LV5PR12MB9779:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d2c39bb-82a3-4f72-a637-08ddd332acdc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4zdWO74/MNoYo5C3LxAK9Om/0wQvutnUBE5WOdFGjiwJCuzZawxsSAM1Wz25?=
 =?us-ascii?Q?xJn4vzUJk44jIT0r3SsJlmC/rlJ9HgUyl+I48kEoqsk1ZjQ8zVX1VlSZ5LVZ?=
 =?us-ascii?Q?2PiBucg/fOELj0N9a18dA5yOve72er8+5IIXSYz1dWCiNVy5XawhSuaEuIiP?=
 =?us-ascii?Q?iAwQWH36xXTwWmRZ9GfiOWOoLjcvfnoUInWXyQt+vAgbOX+1Xftat3NsU8Ag?=
 =?us-ascii?Q?M3Uz5fzWHOWfdlH+dzvJh1YOSAuNPeX4tZZeNmJDw7LNV4kOr4VGfowFFaBm?=
 =?us-ascii?Q?VLJ4azwTJNZesrKSaecF//z/288+FpW4S1OqiBOACI4f8/2r91N7q7mjzoZL?=
 =?us-ascii?Q?wun3mo8EB8k8TobkElcYUVpDyoPxIR/xprNgTnp1fpqIV+5eqKMGFHYIl/rD?=
 =?us-ascii?Q?UjxNjCdUlxlQQDkvli+mFcL1BHgixNO0joI/KIHobrkjFTxTXvoE8doTIwuc?=
 =?us-ascii?Q?/KskjAnQG+JXdQt/u7tcI7NReKq2bvHG2mIGh74GreJ/XbFt779i7Oh0w+Iy?=
 =?us-ascii?Q?m7t8RS6vORto4J/J1ZNqy5mvjcF0f71lS0Tj7WD94WIZohxOC+DPmRc+LK2X?=
 =?us-ascii?Q?PYOXAfjjLsRPky7SNtirn2gyKMzNL0eeLiRybezcxOD+yJdtIblkvBo+tABm?=
 =?us-ascii?Q?P7AAg2XgmE5G+D5PVfFevHS+9MSFTaedCVr8z93ITESCHb0hu63D9VFRSDeN?=
 =?us-ascii?Q?zFzYQf4fm1r36uv6o5+XMP7Px41uzs88z5sMGBeocfRUszH8d0CUtM45Ig6F?=
 =?us-ascii?Q?VbzDxZY2SSf2lBtyI+qmH4SZHgQTv8vh2r6K8wF4EvUi/YzvKNLSk/kiKqjx?=
 =?us-ascii?Q?GEvDAzVVhhPrLNhXsLNuFKZDyKbWj99jCC9lysVrxzp8IA2hApNKolrRzmkD?=
 =?us-ascii?Q?3BwU7+jGGchtJ4tpEbt6PdGZQCCtDC9y7I3QWht/gMrfdpqd6bDjTRfaK1Jj?=
 =?us-ascii?Q?3hHtXInXiH72247FhbKXAPAVHXLjBEslmO0dN1D5nl6zKdyn56kGjoGIoz7m?=
 =?us-ascii?Q?0Jju0EllQzkdR4+tWpUkzUEpgBthJkrE0No7Jk4GYOUXLd6rGfLEgosrGURS?=
 =?us-ascii?Q?PF73nxuv7LN3UlZWnbTf8lBY/DqKWsI//sOJVgCMcGc+WKtRBuNfvlALzZXv?=
 =?us-ascii?Q?5nDeHWTR7B7cxVlZxvHPr1swVCD3ZsSK3dETJmC2rWKhCR5uj7IWcYgTOWD2?=
 =?us-ascii?Q?Im4rCvReiIrnGTJURVYoO8fOErLLluht9mB1uJhWrUIeCGRCNy8Ma2XSTZNM?=
 =?us-ascii?Q?Qt1+ll6k/oC0yvYDcvL0d65NrV/hUMQqov7SbasG5homhtgtSbTGYnO4ROTP?=
 =?us-ascii?Q?w75Cusyd83FAg670JFm6g+MSCpGBY4/E6/pBn2nAFLqlwF3mL+oRGLLu6yKW?=
 =?us-ascii?Q?h5fXErER8adGKM9pKQ2KrXZHzIgAQe66h1XMNaKQuS46Vr3wkVxzIg3ntZE+?=
 =?us-ascii?Q?6pJXoWQqWLLEGWKEKnC9Rmhm7KupUo+WaiU3ZQtGv1yY67Wm3dHQOikkPz08?=
 =?us-ascii?Q?li+yRmHzpaR9RbVqXkQkzGhesteYwTZMD/aC?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 08:41:15.8008 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d2c39bb-82a3-4f72-a637-08ddd332acdc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB57.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9779
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

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 51 ++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index a871bac71e1e..8934d7113d58 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -395,10 +395,61 @@ mes_userq_mqd_destroy(struct amdgpu_userq_mgr *uq_mgr,
 	amdgpu_userq_destroy_object(uq_mgr, &queue->mqd);
 }
 
+static int mes_userq_preempt(struct amdgpu_userq_mgr *uq_mgr,
+			     struct amdgpu_usermode_queue *queue)
+{
+	struct amdgpu_device *adev = uq_mgr->adev;
+	struct mes_suspend_gang_input queue_input;
+	struct amdgpu_userq_obj *ctx = &queue->fw_obj;
+	int r;
+
+	if (queue->state != AMDGPU_USERQ_STATE_MAPPED)
+		return 0;
+	if (queue->state == AMDGPU_USERQ_STATE_PREEMPTED)
+		return 0;
+
+	memset(&queue_input, 0x0, sizeof(struct mes_suspend_gang_input));
+	queue_input.gang_context_addr = ctx->gpu_addr + AMDGPU_USERQ_PROC_CTX_SZ;
+	queue_input.suspend_fence_addr = queue->fence_drv->gpu_addr;
+
+	amdgpu_mes_lock(&adev->mes);
+	r = adev->mes.funcs->suspend_gang(&adev->mes, &queue_input);
+	amdgpu_mes_unlock(&adev->mes);
+	if (r)
+		dev_err(adev->dev, "Failed to suspend queue, err (%d)\n", r);
+	return r;
+}
+
+static int mes_userq_restore(struct amdgpu_userq_mgr *uq_mgr,
+			    struct amdgpu_usermode_queue *queue)
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
+	.preempt = mes_userq_preempt,
+	.restore = mes_userq_restore,
 	.detect_and_reset = mes_userq_detect_and_reset,
 };
-- 
2.49.0

