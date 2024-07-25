Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8264C52CD8
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jul 2024 15:01:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 601C610E868;
	Thu, 25 Jul 2024 15:01:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qN5Yn8Jc";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2056.outbound.protection.outlook.com [40.107.92.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6713310E84A
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jul 2024 15:01:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KUnj5RAnAK8D7it81aVB9AVGV/6ux4Ytdko0tMa3RP4k9dIlD1R0d07szGK2FVSG6YpMceVLt6GwAtX+Tk1BmGyIyt++iWyfFJtgoPpxHgf4wM/sk/yl4wb8F60y+aybi//zgotzbehhrWB9hbM2fEHoDT3DjDZx29Nv99j7m0dvAjVZ5NU4hVU5qiVLgfOE+a6+La5zMq7PcuZtwMqR8FE5Bdi+ug2q68HX2zK5GIgDht9E/5Q1i7Nqh7/LON9X9R7XCk9VVb/vh6z9H0Ryp9054QCf/GWigLk+QJgITFXCddcMhJckIh6HErKMbDP/VU8TxqfPvuhGoRjVk3OLmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P8QiEQYslRjTFPhEG1iSRNb2SXl2vW1Y1aEpBcBB8tU=;
 b=eQUEz/w8oZLbfU5cdkUwVs3rdCtikht9jLe/idGtsETCDNJC6WS83fdCVWcGHVadmIlBVMbsdabvoLuvc3hpbw/J5yl8ChrXzzxjEKcoTMqS5v7ftye/RPmxWJDfQ8/eOGAlewLbORwbuqgOEu/pD3+dF5F6yfXSYnNhBPjI/8OhRb6vy5+RSQ5PlWqcrSEUAwKaLCpf4WohaCGT6dMDEh3x3/OOQCu0cpITLCow2upf6gXnsVBCl2ZpUk+bnTBVeYb6I75r08RvR0zG+9NNS0qSi1rpYJHeDwxC7JaT7YLYYm5OMLzhrLHKgtoeLwUQW/TtCFXZzzg7sMx9+LLf5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P8QiEQYslRjTFPhEG1iSRNb2SXl2vW1Y1aEpBcBB8tU=;
 b=qN5Yn8Jc9JCG7+yor38vvdtQ3iSxGwaQpo3cDjWZJyaRoaxccyfaDt6l4YfeMpyPmZQKbPMYbatVIxOb62D8ryVZ2Xclr3snkHkIo5rfUn9d8IDq8ZhU07HUESMfLOR35KIMam2kiwAL4DhNO84k2BQu0E1BnKg71+3eMFmybZY=
Received: from PH7P220CA0034.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32b::7)
 by PH7PR12MB5854.namprd12.prod.outlook.com (2603:10b6:510:1d5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.19; Thu, 25 Jul
 2024 15:01:33 +0000
Received: from CY4PEPF0000E9CD.namprd03.prod.outlook.com
 (2603:10b6:510:32b:cafe::1b) by PH7P220CA0034.outlook.office365.com
 (2603:10b6:510:32b::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.17 via Frontend
 Transport; Thu, 25 Jul 2024 15:01:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9CD.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Thu, 25 Jul 2024 15:01:32 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 25 Jul
 2024 10:01:29 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 40/53] drm/amdgpu/gfx12: per queue reset only on bare metal
Date: Thu, 25 Jul 2024 11:00:42 -0400
Message-ID: <20240725150055.1991893-41-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725150055.1991893-1-alexander.deucher@amd.com>
References: <20240725150055.1991893-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CD:EE_|PH7PR12MB5854:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b488a5f-1d0a-41a9-f49b-08dcacbaac0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UREYJ86O9UYBytTFqjHHkZ6Zuyf3DJ2bXI+Z1mNjrjZX3q2R3M8ILldB9GYi?=
 =?us-ascii?Q?wBh6XYZNk68GG/GIAUdakDMDxUzoT+smjbYHgx6PDBB2hNH1VdIggNpnksZJ?=
 =?us-ascii?Q?483YucPCQLWnryeGQHVYgzlDhwbQH+v/K/hv9rRu8KGkwgkE7XGvoOT0Re2k?=
 =?us-ascii?Q?i7r4gmrrapD7bW7wMoeqdPFEPAvZvvLTxn3/9bp07G/F3hbFuvyh6bTub/Fd?=
 =?us-ascii?Q?rxgWsR/AYycQd8mNgxSN1+e9Q8KkNnsTY7ZUazQBZqFqGcP9lQ3nbngOIOlf?=
 =?us-ascii?Q?+XBprqSIUHq8yYoPSNjBQ3qj5o4S8Q+V2ksi1zAtWSYHAb+G9WUWqytOZSyK?=
 =?us-ascii?Q?uiHAQuG3apeKtnX4KntqBE5LhsY5aO9Qij8chs+9UAHo5evgLqbpc95Kvj8r?=
 =?us-ascii?Q?NewLq/xjRvdX8srq2QtnPQHkGu5xIHBRUczKMYVhw9JM3exXnhbpc6lx+xCu?=
 =?us-ascii?Q?JfFXuIt8S6VgmpoDIRt1Wz15Z5zj43JXlqNfdxpFEJyjRmg+FEK6IHSixFnn?=
 =?us-ascii?Q?3pd422rj6/dhE3dyEuBplxKshwSaAoCW13ivR583fXZdDysX4L3jCosLmi8H?=
 =?us-ascii?Q?IW6idDrKlQCkavNdmjtg6fYqi5Ue1Dkbgtw+jnFYzq0+gqMILO7+Q6coAPpy?=
 =?us-ascii?Q?WkIrzLsDBMnDQl4gKmMW5aXL9NXcJqWH4VoYAt2/vKzpVmHCHJDy+gMx2SE5?=
 =?us-ascii?Q?Wl6fPajsh0BIStD/X2Ack3c+Gm2f6PF5UDyHy6qNa70cLzfawbQsAL7N0t9H?=
 =?us-ascii?Q?C6DELl4kPm9qQMC96+wp2N+IuDDEldXMjzKv/P71Cy3sbM/ln7qhQelLQqfR?=
 =?us-ascii?Q?1CSWrVVUndEspJ4sSpgayJvXtsQiHrUrvSn8eaE300UEr4G75vvOZHdAmWpQ?=
 =?us-ascii?Q?5+I/Q5oLR6peVj6KD8041y1CvkFcAj7AbIbVhGag5vKnKyAedQ1fmxUsoJhP?=
 =?us-ascii?Q?LMFj1aAOOQClWbXR/a3yz8Hhqj9P650I/0zO8K2qL1P2qTj+vxbyXGX8baPS?=
 =?us-ascii?Q?E9zLZURZrj9KI/h/1UQr7QOneWlNuifTys0lAPVQi0hFo88gtu03e3Zv61+q?=
 =?us-ascii?Q?a4T5xYSqqOldfujaHJO6EaoX2KnECJqsDTnii7rSMSXryOgs7QzKW75B2gDC?=
 =?us-ascii?Q?05SCJZUQPzB2kYttxfig1huST0Vhvsmgnii06M3pghNYycRQdh6rtTW4qE74?=
 =?us-ascii?Q?l7FNpdmbCz52o/lxijMbc+4xk+9bCUZ08iHhZmzaD7bc4Safq8REar0kdi1S?=
 =?us-ascii?Q?gZwgQAX4+gOMNs2CANuHqIZz8nYs5+q4KnTDMYPP9cG9kJ96gRkR7AK6OjtU?=
 =?us-ascii?Q?hfK8AViYttF66Fu8euwCfTkvKtPe8JQG6HABdb9M2tE6aFvE17DAky6IdUGu?=
 =?us-ascii?Q?lsE8FfBhWMl6UPh+AJMHbIr4lFA9kwIjC1WPHFcFiLNXpob+GAj+fD8uWJFh?=
 =?us-ascii?Q?423LFBYhCCuFjS16ZMSo/xzqB4AZp485?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2024 15:01:32.9164 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b488a5f-1d0a-41a9-f49b-08dcacbaac0d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5854
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

It's not supported under SR-IOV at the moment.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 02efb0a2e625..7812c9256566 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -5140,6 +5140,9 @@ static int gfx_v12_0_reset_kgq(struct amdgpu_ring *ring, unsigned int vmid)
 	struct amdgpu_device *adev = ring->adev;
 	int r;
 
+	if (amdgpu_sriov_vf(adev))
+		return -EINVAL;
+
 	r = amdgpu_mes_reset_legacy_queue(ring->adev, ring, vmid, false);
 	if (r) {
 		dev_err(adev->dev, "reset via MES failed %d\n", r);
@@ -5177,6 +5180,9 @@ static int gfx_v12_0_reset_kcq(struct amdgpu_ring *ring, unsigned int vmid)
 	struct amdgpu_device *adev = ring->adev;
 	int r, i;
 
+	if (amdgpu_sriov_vf(adev))
+		return -EINVAL;
+
 	gfx_v12_0_set_safe_mode(adev, 0);
 	mutex_lock(&adev->srbm_mutex);
 	soc24_grbm_select(adev, ring->me, ring->pipe, ring->queue, 0);
-- 
2.45.2

