Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B90CE7717F
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Dec 2024 07:53:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2640C10E5AB;
	Tue, 10 Dec 2024 07:53:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PbJuAXeL";
	dkim-atps=neutral
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2086.outbound.protection.outlook.com [40.107.96.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3011210E5AB
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Dec 2024 07:53:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uuMDE3Zr/FuoULteuCZCDa8G8tfnAzFbJhqOaLlrIh7ZTtNSPZvWTNBq8+qUc9Gqt5gP6RhXstnHkQUEIsXydwvf1LsWZgqaZUta/CWkqvRZ92ONlYNk1DBPrnr+oTsb0PJsglnpTG6XPxFngM87Ssgf/EWWUVcDij0RQwOj9xdSi2T7IYuTC3UM1JggGW0XRnPT6wiDUjdvEkaXmJOwI7mihUxwzEigp/Rz89tJcafMAO/6Lg54yniLRSvyQbYDTJcNcy8tYajtfzQEksEnqGletqf0JjiysXNnTJeQPR3Fti4a+GpzYsnC/xUkGXd84lKxKXSn3DAtwOrpMbwAzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D/dzIJjPNS7lY+LHlgefyuQQuo+vtA2z/BILNvKXQeU=;
 b=J3R8szZvygjX6ubWj0xoT3xfUPUeTgtXsyjEBmOUWWdyE54+DDIG1TKhuovZKF1FHpdmF4IICGwL6a0cLadUZKpeGHjo3aUSL/0PKaL80eQeONB8liNak4WUPsKBcOVjb2VXhZRWAXA72RhzYzeXVSNTuDbb6tH53mbfYMpM0W1fuuDZ4g3o4SSpmgPyRtUzIkqbO/oRpcwlXAX2JTkq+CbiiE6CcDkxx5X5KemFdcvBH+frG+UTyvyTDbYEUKT1ZEiOGHnYAmbdzzgo/v/bXvHZluuI2OfJgV3ijx2ZxlV4GggKBRB4lmDqxcFu9poWm1I2PEtVexTczuk4RWIxZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D/dzIJjPNS7lY+LHlgefyuQQuo+vtA2z/BILNvKXQeU=;
 b=PbJuAXeL/Fhny9fPGBD0H3Fu/mmL6eJcdtAOwQZCcQLS8QslXFAKA2f17JqUHEGPWGatphHDO6yzqeNeemAr5bWAnLKRfS0SMlgaW/Xg94fQ0oJK3z2Rdd92RgfaEBTWZM5KvII8wblvtbe/HOmpPoSc9QdhC9J8nq6gGOeWFoo=
Received: from BN1PR14CA0007.namprd14.prod.outlook.com (2603:10b6:408:e3::12)
 by BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Tue, 10 Dec
 2024 07:53:28 +0000
Received: from BL6PEPF0001AB58.namprd02.prod.outlook.com
 (2603:10b6:408:e3:cafe::d6) by BN1PR14CA0007.outlook.office365.com
 (2603:10b6:408:e3::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.13 via Frontend Transport; Tue,
 10 Dec 2024 07:53:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB58.mail.protection.outlook.com (10.167.241.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Tue, 10 Dec 2024 07:53:27 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 10 Dec
 2024 01:53:27 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 10 Dec
 2024 01:53:26 -0600
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Tue, 10 Dec 2024 01:53:25 -0600
From: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jiadong Zhu <Jiadong.Zhu@amd.com>, Prike Liang <Prike.Liang@amd.com>,
 <Tim.Huang@amd.com>, "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
Subject: [PATCH 2/7 v2] drm/amdgpu/sdma7: implement queue reset callback for
 sdma7
Date: Tue, 10 Dec 2024 15:53:24 +0800
Message-ID: <20241210075324.2183183-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB58:EE_|BL1PR12MB5753:EE_
X-MS-Office365-Filtering-Correlation-Id: 30e5bc2c-f670-44c0-0303-08dd18efbb77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qbi1jr6Hanng1MLqdxoIHkZVFqa3SlnkrUew3b0D92PfR/WuSECjihpgW2D+?=
 =?us-ascii?Q?yDr+TPXCXYxTy29bM4OBVs9PUYHvwDLu1Ejs3eXAdLl7YC8VjAvnlYdHF7qv?=
 =?us-ascii?Q?c3g7thR0Q0eRROejBIo52Tz3N01R0r6mydOQju1H4a3DCHBubd1+mH868AY3?=
 =?us-ascii?Q?BWL79pGYX2/L0L/KZTvMQsWGb6IEKjldxEXMqRjG8egTBkPrMEq3yH0lRN33?=
 =?us-ascii?Q?HmC+iqNt01kEqJIlY9mMeRV3y3D+vUIgLQbRdv4WisdeU73T/GjRrUCEpvkH?=
 =?us-ascii?Q?7FudzDICHM6XU41arWra1cYW7y4qv+m6hLkoeU7udGPaBqGOj2aqEzEbfWXv?=
 =?us-ascii?Q?nLsKcMyIK/N5eL9UY8ri3cXbNgp1GdqkEShbOyUjeYyP5jbMNukhI+MQBXTq?=
 =?us-ascii?Q?b3UnLLZAPMWADlYQ8jaflyeqOUKUbKL1icpiuU8KRcVtvgWE+g7KHEcd0aUy?=
 =?us-ascii?Q?HjdXVtdX9g3cH3cVZg53mdOFCb2jneLu7tCm5+ivW7zeCC1zMGnyZT1Jmnq/?=
 =?us-ascii?Q?6FQfDhm38LWtEeKaLzVFR0ghjydyex8i4xeuF7Ys0S2gtvDTt6zvmHGJwubo?=
 =?us-ascii?Q?Ol93HOEV53F00wpIp6ksg/wEmk8qIU3Bti4ewQIJrT8W9MVmJ0cTxrCiuhJZ?=
 =?us-ascii?Q?81XH5uhsM9WAQ9ymVosr4F4h7LHLOeyd79Ug4Jl4wPa9IoFtsRziGzucvPRj?=
 =?us-ascii?Q?RXifkYhkYHpLCzjE08EXZUkZvg7RxtEoeppLl31m1JMQptRw+xlvxX2YcgD5?=
 =?us-ascii?Q?EJ0P3McWqNw1noXLPjN9CG1/IUesjGiaKvRoPSeiVXl0MtUD31SgJPcFUxLZ?=
 =?us-ascii?Q?IysDzOPtkHedSTFzq+4BvQcI92Ihtlvs9TdvOj/lKh/x49dp7hwA5e8aEX8r?=
 =?us-ascii?Q?Gb6S1qPuxJ4uM5IhY+VS+8FC9okLhXo0tY9bfiMTYSFAqhbQb0b8+PKE01rI?=
 =?us-ascii?Q?OrZ37uZSpxaFKOHCt+TIFn8kSQ/xt5uQ4DGsN9+dcMleoOjPpY4A8VHuEqvL?=
 =?us-ascii?Q?eyV4aCV3caLsenkGMuwO9XsfpGwNPUXOfH85Mi641/vl/3YItEGEYfA4is1N?=
 =?us-ascii?Q?7Sx3TSGxGUdNrDA5C7EkAmRDKAkAV/buIa/AxVRw9L8Tny+XcLKHtmZ2inQ/?=
 =?us-ascii?Q?m8KhnmzJgM1CArhBOz49INqMs64gtATUZUd9SFHhcc3dYaTh4AN7qK/VqoL9?=
 =?us-ascii?Q?/ufQnaPv91C4s5VJY2ZRIwyE0r+rNz2YfZtNYb9CjtaVkNa1Ase1NkJersB5?=
 =?us-ascii?Q?yuA5BfquFoU/kjHM1gknF4/WWPG4AHADgbQ42IsfBeXtDJadw6xQFRACmi2M?=
 =?us-ascii?Q?E6wsaFvExEapH7OGEfbWnHmapI0rvHOKDwRodUis4mYQDl/jnj+zyQnaXwBB?=
 =?us-ascii?Q?krTEIPQRtDzEisxex9k09LpyJRKY8bbRtkl04OlO404zYrHURPviieol+CxF?=
 =?us-ascii?Q?XkCdFRg5LkpfUYuIdPWK/zEroEaLuLFD?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 07:53:27.7086 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30e5bc2c-f670-44c0-0303-08dd18efbb77
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB58.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5753
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

Implement sdma queue reset callback by mes_reset_queue_mmio.

Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
index 8cc8eaff0680..627e0173b64d 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
@@ -830,6 +830,31 @@ static bool sdma_v7_0_check_soft_reset(struct amdgpu_ip_block *ip_block)
 	return false;
 }
 
+static int sdma_v7_0_reset_queue(struct amdgpu_ring *ring, unsigned int vmid)
+{
+	struct amdgpu_device *adev = ring->adev;
+	int i, r;
+
+	if (amdgpu_sriov_vf(adev))
+		return -EINVAL;
+
+	for (i = 0; i < adev->sdma.num_instances; i++) {
+		if (ring == &adev->sdma.instance[i].ring)
+			break;
+	}
+
+	if (i == adev->sdma.num_instances) {
+		DRM_ERROR("sdma instance not found\n");
+		return -EINVAL;
+	}
+
+	r = amdgpu_mes_reset_legacy_queue(adev, ring, vmid, true);
+	if (r)
+		return r;
+
+	return sdma_v7_0_gfx_resume_instance(adev, i, true);
+}
+
 /**
  * sdma_v7_0_start - setup and start the async dma engines
  *
@@ -1668,6 +1693,7 @@ static const struct amdgpu_ring_funcs sdma_v7_0_ring_funcs = {
 	.emit_reg_write_reg_wait = sdma_v7_0_ring_emit_reg_write_reg_wait,
 	.init_cond_exec = sdma_v7_0_ring_init_cond_exec,
 	.preempt_ib = sdma_v7_0_ring_preempt_ib,
+	.reset = sdma_v7_0_reset_queue,
 };
 
 static void sdma_v7_0_set_ring_funcs(struct amdgpu_device *adev)
-- 
2.25.1

