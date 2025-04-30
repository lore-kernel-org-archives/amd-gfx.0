Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30221C3ABA9
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Apr 2025 15:48:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C80EC10E302;
	Wed, 30 Apr 2025 15:48:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yNvh6Ydc";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2053.outbound.protection.outlook.com [40.107.237.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC63810E00F
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Apr 2025 15:48:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AU0ASeQSU6RxhTKBWrjGa9+/yDqzYCMc4yXPEDWBrDSvlI3O7QDaRqCyVyur5T9b9fsKbHy2Wkepi63/6qGoVXxxZ8b75tYAVCq4ug6+98KuGJZivZsmPcNhGPKoYqJ/jAoYRNPR4zA2f8GwwrPzdn8HSDUxPjSPtdXXoTgAT2khd7ktVfj4ec6vdH9pdL8QbWXFSvH328IQaYRU01r1bPSVhRrAyMinoXqL+b3ZHzsMxFT2Plh/H+Zk6BfazF1TbBz0O2XFYqoML0PhXb6Q4KOxUSHA9pD4myZYeD8qI4Zlblv9NpEtyOw7F8dCY9/D9xy0HRnj+HJOvtENcVggxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=siK7sWgkGZjF6ADsJ2jJzFBW5FCvGO/jrjzAHJh8//Y=;
 b=U34DFSmGOh7nZY7NMCJLwiqYI65BWiW7JfB4dULa0tQdql8CNmFL8ADCro+ZaqvfwWjcekqEq6RaI6Xeo96guzr7n0u4xePCYtuwXml0iO5+k8YPi2oa8L9FyZCSCrNpwqFuAniz9d1HtxANzdxtFJgJ3DAIQpaHt+Qfydg9s74Ugs/P8wjRln6L/b/gaGnx2Hs/OOMddpFwtYufvxXum/hvNGYb+/Ki8fN1UJmrfG1u/cXt6ciV37NUoN63e7jwEK8/qWgESgleyhNFsQ1LMVZx6qNLw3PS91KeXf9EH3+BlJ9meZp+cnKyjM5Lz+zMn/dA+QUisnKI+dDMdBW9ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=siK7sWgkGZjF6ADsJ2jJzFBW5FCvGO/jrjzAHJh8//Y=;
 b=yNvh6Ydcux8NZT9NUtAPq7NJpRDxSCus1cP0G3ZVvQwXZFb9SC7jkb67sll5EIMkedrizgpUP9tlr9MBdqnZikm7ml7eIe3w1sNzrGLzxQT3uHH4Kibp1r83TDoP1P0lhFrkMBjsSpRRp4vZqodlmfozC9vwwPc6MNBA/Srsni8=
Received: from MN2PR20CA0019.namprd20.prod.outlook.com (2603:10b6:208:e8::32)
 by CH2PR12MB9541.namprd12.prod.outlook.com (2603:10b6:610:27e::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.31; Wed, 30 Apr
 2025 15:48:25 +0000
Received: from BL6PEPF0001AB4B.namprd04.prod.outlook.com
 (2603:10b6:208:e8:cafe::a4) by MN2PR20CA0019.outlook.office365.com
 (2603:10b6:208:e8::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.35 via Frontend Transport; Wed,
 30 Apr 2025 15:48:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4B.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8699.20 via Frontend Transport; Wed, 30 Apr 2025 15:48:25 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 30 Apr
 2025 10:48:23 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Sunil Khatri
 <sunil.khatri@amd.com>
Subject: [PATCH 3/7] drm/amdgpu: add mes userq reset callback
Date: Wed, 30 Apr 2025 11:48:05 -0400
Message-ID: <20250430154809.2665473-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250430154809.2665473-1-alexander.deucher@amd.com>
References: <20250430154809.2665473-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4B:EE_|CH2PR12MB9541:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ff97671-2600-4cdc-3fd1-08dd87fe7181
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?IaryhtkI6SyvYV2Z27BpMvYzJIQZSJ7DVnztYrP+WuO/ByFxZquG+iMZB6pP?=
 =?us-ascii?Q?cvVTGQfbttJ3vsLF5PYA9fA/YmBvzf4KAp0UPJrjYqdB+adCTBcegG2bzPBi?=
 =?us-ascii?Q?iradF9ZBDIe2K9aa3KAB88rDjFJBrxWnelqV/22ZQH3WmpU8nA67SsScmYUe?=
 =?us-ascii?Q?WQqn+rW0pegJF/pMhIW43HziYoMdtG3VYUgNrTmrtW7Gs9sOPijicYdM5zYH?=
 =?us-ascii?Q?wvT797N87CPnlGuczJdoObiir7Blrhs+JECl1OhImGCAx7ymsHEhX1qiHhPy?=
 =?us-ascii?Q?GNDqJIbmSaCVhNSbkyeCZeOlssbHA0KlCAsaLQPN7pP9/t3GcEIfbLKxN5WX?=
 =?us-ascii?Q?mu1HNOgwgkkE492cvBUGN3nO1Fn+fUMtl0lhpbtWtzVfhPv8gyb9Irpi1j6Q?=
 =?us-ascii?Q?1u9DmFQ87W47/JuH/3dAlCELh2gQGB/mEAPGSnyxs9A9f/xzg8wUHKo/1/qq?=
 =?us-ascii?Q?4fTexJGmbsYwxHzSu7lm8GTz6Nzl0fc8fY3OYaaLnU2nT7OKAYQz/TOfUZvz?=
 =?us-ascii?Q?uTjdpzsXz42HDnu2ao/yApoBuQxqWmbAO6arTILTdaEt0ByCb/PClx3Phb90?=
 =?us-ascii?Q?gaXzptFbOrzpjmShtaUzqh9Wl9pglbEVBht2ZThzjv/tk4nJMJZ8ksFNbUrt?=
 =?us-ascii?Q?+PcS6o8SrY6k+ZYhPjNUvBuD02ZYZLqxbZjAlzdkX9ehDt7OI44S0lT+quFr?=
 =?us-ascii?Q?rWDeriqGVp3oLheJi4ukOBXBPbkuzFNEqfm6Z+187mtHHI64HVKY6SzEReIb?=
 =?us-ascii?Q?B54+qGXEQ+CJ/G/U61eyq8wMv/ECJStTY5B/kg5gsiFwmVpOWbWJrYRwX6/a?=
 =?us-ascii?Q?OMx77l1kFHQ9Cw2N9PJP7hAkZWUiKP3DqVaai6uZucX2WYlq97SS9mYYT1IS?=
 =?us-ascii?Q?vce10nQiPHESDpuQt2IprHRtNe4tMKjBYs53s/5BAwVYQYX9GXqOsmipdxm1?=
 =?us-ascii?Q?btG6hfd27/bDSfV2p1ncVWXtuiHmfw93WSekyMbItn7Twm7GkYfey6SVeXrK?=
 =?us-ascii?Q?nxbcVbmVd9NjDV/huEvORoxH/uSIo+WSodNtnoFN0OeOXm18zKExAF5HIbU+?=
 =?us-ascii?Q?1jiX0+kVWqIax6XzaH2yXnj/SUVZbqxgG62cXBxQnqRLyFCJo3jl0jSjUcYB?=
 =?us-ascii?Q?rYyljcbNGF+vbUIv3aIipNMW9vec1n5a3LfjTbXK/ZZkgDLL6/NtqhF7muCE?=
 =?us-ascii?Q?faoQkAFTvZyZbxiUNt4ZiJlSa2xprrb3pIGE38hqA4oqvrKKpN0nNaDRNOoZ?=
 =?us-ascii?Q?egwEuCIQ0OF6A6VHrurNmeR2Pxr4T0+59E6/LTIZzMFA1AJNLYh0pfT+qUo9?=
 =?us-ascii?Q?oKBOR7BD1UPdfWEbHrDGXDsZ62Dqknka0i4VPNXm1FGIiOVlREPAscp0mO95?=
 =?us-ascii?Q?tcLLdloHH9POUbRbnxUZasAJGO+9qTyh2JO3EjRo7MT9vGLe7xi/pjZbEJ2u?=
 =?us-ascii?Q?2WQfhX4zpUdtgpOmDST2Vk0YfmVm2eul2u053UggAYT5CIjBsqRv1Ok0zuEX?=
 =?us-ascii?Q?HzX2pbb0LL8D0K8HFot8adqLQhMu/dGdn7ja?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 15:48:25.1761 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ff97671-2600-4cdc-3fd1-08dd87fe7181
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9541
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

Used to reset a hung queue.

Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index d6f50b13e2ba0..650fdb68db127 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -347,9 +347,30 @@ mes_userq_mqd_destroy(struct amdgpu_userq_mgr *uq_mgr,
 	amdgpu_userq_destroy_object(uq_mgr, &queue->mqd);
 }
 
+static int mes_userq_reset(struct amdgpu_userq_mgr *uq_mgr,
+			   struct amdgpu_usermode_queue *queue)
+{
+	struct amdgpu_device *adev = uq_mgr->adev;
+	struct mes_reset_queue_input queue_input;
+	int r;
+
+	memset(&queue_input, 0x0, sizeof(struct mes_reset_queue_input));
+
+	queue_input.doorbell_offset = queue->doorbell_index;
+	queue_input.queue_type = queue->queue_type;
+
+	amdgpu_mes_lock(&adev->mes);
+	r = adev->mes.funcs->reset_hw_queue(&adev->mes, &queue_input);
+	amdgpu_mes_unlock(&adev->mes);
+	if (r)
+		dev_err(adev->dev, "Failed to reset queue, err (%d)\n", r);
+	return r;
+}
+
 const struct amdgpu_userq_funcs userq_mes_funcs = {
 	.mqd_create = mes_userq_mqd_create,
 	.mqd_destroy = mes_userq_mqd_destroy,
 	.unmap = mes_userq_unmap,
 	.map = mes_userq_map,
+	.reset = mes_userq_reset,
 };
-- 
2.49.0

