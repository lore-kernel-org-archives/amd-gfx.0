Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B13E8CD4855
	for <amd-gfx@archiver.kernel.org>; Tue, 12 May 2026 08:48:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E85710E9C3;
	Tue, 12 May 2026 08:48:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XrfzSdKi";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012031.outbound.protection.outlook.com [52.101.53.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B13210E9C3
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 May 2026 08:48:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jGBxX6OdGQxyZy1/mpBB4hJClwmT32QwaGm/HBgNnCCr3ngBkGf+RvDT8+V2fDpySFMjyfWrugtikSQAN+rDWztUBCTWbrR8Adu6f3TbqysJkVIgrgG9CspvjjwJmkcuMg8KPVu3sF9H8wXU16mztVUxEwwegc2wVjXRXAsAkDqrcjag6WguqPt3XaMFRKRgzCu8qh+D7O05j1XyNZeGlhBo9DsFmXSRK2oMWWG75vE8gwnZPOMkIvHQWG3wBlsCgLGU6CmzWHnbxXDMS2zEkL+YXSDxkp3oHyIlhzdI8YRIQdQeZN8Oe1ae42VcHCNXIG6RFyggdbfOm3cdgp0YhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sTQnOBygBgKRr5FbPOGaA62xDGnrz3FMFC+HWeD0xmc=;
 b=FYtQnesUedFTRJMo+6jpYzUFa8H6wF0NZ9LfGVeV60SSd3sQLt5l1jmta13Ts8UkiUZIydnEoOJZgbCFXmA+dVxW14yIFpX0AVq4CKcILWS1rPHfbQcfC1PdZyxDXekKDrzyPg1YWN3C/b4+CTZHD3tI6cxDmRKCPGkOD3C3nHJnaAX5IIYvoFpTHn62EzTo/P3xTemP2Nv0r2NeU8uEQTEifEwr43iNHKYU5RtGVVmzcevhhOaThhxUxnSWV/p9ni8zQxNzY3kV9cLBFdr4VrU8r7FB5O26OjQPXUqP05g2prIzkKImAhVIjGfP7YnkZL5efjhzimVlGz3Ecl4QjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sTQnOBygBgKRr5FbPOGaA62xDGnrz3FMFC+HWeD0xmc=;
 b=XrfzSdKiWS25jon3+DsmacOuBLQMrfw+CzeT9tJXYelIz1lyU8wWt7Tj3xOsSKeYA8Fhk6eSK+df+NmD5yTLXwVLMT+d2EDfKsFa1GYdUnq2p1zdRPPLCaR2crWpeV+ab8pjoVt4Aq5tkVL1ry08T2YIInGifuoB/3tsgItqeE4=
Received: from BYAPR06CA0029.namprd06.prod.outlook.com (2603:10b6:a03:d4::42)
 by DS7PR12MB8201.namprd12.prod.outlook.com (2603:10b6:8:ef::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Tue, 12 May
 2026 08:48:41 +0000
Received: from SJ1PEPF000023D5.namprd21.prod.outlook.com
 (2603:10b6:a03:d4:cafe::d6) by BYAPR06CA0029.outlook.office365.com
 (2603:10b6:a03:d4::42) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.23 via Frontend Transport; Tue,
 12 May 2026 08:48:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF000023D5.mail.protection.outlook.com (10.167.244.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.3 via Frontend Transport; Tue, 12 May 2026 08:48:41 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.41; Tue, 12 May
 2026 03:48:40 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 12 May
 2026 03:48:40 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 12 May 2026 03:48:28 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse Zhang <Jesse.Zhang@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH v2 1/5] drm/amdgpu: add pre/post helpers for MEC pipe reset
Date: Tue, 12 May 2026 16:46:14 +0800
Message-ID: <20260512084827.1630497-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB04.amd.com: Jesse.Zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D5:EE_|DS7PR12MB8201:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b43f58e-94f6-4c78-d1b4-08deb0034483
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|56012099003|11063799003|18002099003;
X-Microsoft-Antispam-Message-Info: 3iY92sd82wta9e6ZyBX6zTrUezGdochwdrvpfEUHslL/ImGGwUE9bgFoWiW9HF+D7V8ye10nH3eTjQGc912vvIuJ68fLLyvrck4o/3UwP115xLO33RDpJ+4r5x1xPwR9qC8dqgQVYtkX0KEJDOUma6YhnfGV+F+iZOw3m7fyYo2aRMqPuthRKeXxGfytCWROjahn7vRTRC4Mc7oYojgvgMT0WEXIzOM2QPCrOZJ+6AnUIrybxCzzHGIOZjnsCeIkipYOaWONrswkWHQsaDjwc0kJAcD/FA+mHL/h4qu8c8E7tN45uYOrCgSUdttC502IHS+4L2ct9JjppTDMA2s8+Dn4H0Dw67wmJ50401MyBOUVPIJtgwG0Ivegy1sgqifFaXKfIwr3WJsEBTGXnj6fhmesU6XVeYaP6mmHUK0cyX4vnBeeNqP+7pG1jsABUmMSzWhktBNiRNnJ/vk3GfR2dDcSjotzaVECeU3CqKxQxUaKSFOnh6ItY41qmZafvT3UvoRrrkN2fybNeJXHe/sfQXtD/rPAfl58OPA7S/Szlx6GvBvxit6OX8GfgEeaKSaDqaa5FjO1Rb85n0nZab2pXVCG9hqzyusBFHhDjrY0jxA2WlV66iCUOtlHE0kwNynLJoUkiqdzNKjZ1pvfUCLmizEC7WVJVbUH+RBZ9irZtk9PEEax4jfOmFsvsrSW6R5OFl2zkUrtlP+RHj94/IC44WsvWwpU6nw3OaQ06ckqFd4=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(56012099003)(11063799003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 1d3NjGyVJpgG3f/Uz6ngkAYW48VyXGkfDxyOnGGupZLSanKdDwgPao1SVGRRH/U2bant9PtzIHXXdUjEgjwt+wJ8tYPLcui/joe88suELtwzKQwukB0JQmb/H37oD6ETyazDFHqKIt/iqwEpY5j2QvN3EPi4mlSb1kimuMh9aZ/tqEOEBceZEoesXJr0GLHzcd7budUhKofIP30pGS0+j1u7dz5tNkjs+E/AkbXZkzIW+Q+uYKyj/AhOGNNcpLvE6ZKII12flJ+lQxYFNBwF6k7Kj+69MU/r9Wr1xGqJ3Xel1WageuecRUu2zO6zN78AxrR++PauYl+SX2TN0hJrAyEq44djXxQpOkzwnPk2YDN8RRIfoRIWTA1chqYMjT255IA+Xeo26Ca8uzj2TeUVDglnD1girHsYQ+VD/qnbBhX9g7LbFkyEKDzIdphKGmM8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 08:48:41.3225 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b43f58e-94f6-4c78-d1b4-08deb0034483
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D5.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8201
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

Introduce helpers to prepare for and recover from a MEC pipe
reset.  The pre‑reset handler stops the KFD scheduler if the KFD is
initialised, preventing new submissions while the pipe is being
reset.  The post‑reset handler iterates over all compute rings
sharing the same MEC pipe (on the affected XCC) and marks any
non‑guilty ring’s scheduler as faulted via drm_sched_fault().

v2: drop the stop drm scheduer, have a worker thread which schedules a call to
drm_sched_fault() for all of the affected queues (Alex)

Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 45 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  5 +++
 2 files changed, 50 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 515cc4a2aeb4..a9fd639e4cd6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -69,6 +69,51 @@ void amdgpu_queue_mask_bit_to_mec_queue(struct amdgpu_device *adev, int bit,
 
 }
 
+static bool amdgpu_gfx_ring_on_mec_pipe(struct amdgpu_ring *ring, u32 me, u32 pipe)
+{
+	if (!ring || !ring->funcs || ring->funcs->type != AMDGPU_RING_TYPE_COMPUTE)
+		return false;
+
+	return ring->me == me && ring->pipe == pipe;
+}
+
+static unsigned int amdgpu_gfx_mec_pipe_compute_ring_base(struct amdgpu_device *adev,
+							 u32 xcc_id)
+{
+	int num_xcc = adev->gfx.xcc_mask ? NUM_XCC(adev->gfx.xcc_mask) : 1;
+
+	if (num_xcc <= 1)
+		return 0;
+	return xcc_id * adev->gfx.num_compute_rings;
+}
+
+void amdgpu_gfx_mec_pre_pipe_reset(struct amdgpu_device *adev,
+				       struct amdgpu_ring *guilty)
+{
+	if (adev->kfd.init_complete)
+		amdgpu_amdkfd_stop_sched(adev, guilty->xcc_id);
+}
+
+void amdgpu_gfx_mec_post_pipe_reset(struct amdgpu_device *adev, struct amdgpu_ring *guilty)
+{
+	struct amdgpu_ring *ring;
+	unsigned int j, base;
+
+	base = amdgpu_gfx_mec_pipe_compute_ring_base(adev, guilty->xcc_id);
+	for (j = 0; j < adev->gfx.num_compute_rings; j++) {
+		ring = &adev->gfx.compute_ring[base + j];
+		if (!amdgpu_gfx_ring_on_mec_pipe(ring, guilty->me, guilty->pipe))
+			continue;
+
+		if (ring != guilty)
+			drm_sched_fault(&ring->sched);
+	}
+
+	if (adev->kfd.init_complete)
+		amdgpu_amdkfd_start_sched(adev, guilty->xcc_id);
+}
+
 bool amdgpu_gfx_is_mec_queue_enabled(struct amdgpu_device *adev,
 				     int xcc_id, int mec, int pipe, int queue)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index 77050f9884f2..1deb82836f02 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -603,6 +603,11 @@ int amdgpu_gfx_mec_queue_to_bit(struct amdgpu_device *adev, int mec,
 				int pipe, int queue);
 void amdgpu_queue_mask_bit_to_mec_queue(struct amdgpu_device *adev, int bit,
 				 int *mec, int *pipe, int *queue);
+
+void amdgpu_gfx_mec_pre_pipe_reset(struct amdgpu_device *adev,
+					struct amdgpu_ring *guilty);
+void amdgpu_gfx_mec_post_pipe_reset(struct amdgpu_device *adev,
+					struct amdgpu_ring *guilty);
 bool amdgpu_gfx_is_mec_queue_enabled(struct amdgpu_device *adev, int xcc_id,
 				     int mec, int pipe, int queue);
 bool amdgpu_gfx_is_high_priority_compute_queue(struct amdgpu_device *adev,
-- 
2.49.0

