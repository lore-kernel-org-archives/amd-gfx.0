Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B629E10BA451
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Mar 2026 09:01:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51E4710ED01;
	Fri, 27 Mar 2026 09:01:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LXOpt5DG";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013031.outbound.protection.outlook.com
 [40.93.196.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDC6D10ED01
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Mar 2026 09:01:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J4fCP7jkJo88othjHHDkY+csX7fovik/NayrSMenTkl5CCrJZp/08Br0s9zpXGkNEdsze1nOQnQfPlPVmvgppFwW+lg1v/egL5MOgL7F0d4K016kk2Axs1s0zKarzOOKxL5iEu/800Yfw3Z+Xla19OYCtAxYe2MFOokfk9p1Wb7jbSfhlwe8G7vftWQRsAEFrPBKUrSQOqEOSs/AzfSCLHsDSC4MFBr5mKiBkLxmLVTgON1mCGnTEYevAWUbRox0R7ucaO4szXVu2LBrqghpCiTXsuD/yCxb9GdV60xsCCt0eqF8Syjf9Haf2WOKU4sltcF6eCA8Zvvd9cHOu/Fbvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=96UuN7zRFm3uFq4pWv6LMCBqt1iAksplNZWTkegfxIo=;
 b=WqfzhD/rEVvDUCt7er1P9mXvnB/yZ5GIIYvs/nBMQcTJk40udYfb5WNd4eATOXFogXaEkua3OY9cp8Ag3YkHwLwu26mmY9wFBO6ZMCY+IHWKGUv3yyHJebs/kxzL5jdm1HsW8uifXvW9RzuXStkO42VHOhD45YKDh/tpQHnatYlvuc1tWo7qXjG1SbqduFN6/0rOEotBmOeYi1sHV+wv++VRN0Vz0tJShm4IaSAIQhLgPI+ZMj1Vb48bBDrsOsqjSBeIgMB62z36hSa/SvYVLaStV0N9S2pLx6Lsrdt1LKfMyaHX4UOWqatW6NmOKXkVz2MBlJmftP2tTbDSQLyggw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=96UuN7zRFm3uFq4pWv6LMCBqt1iAksplNZWTkegfxIo=;
 b=LXOpt5DG8kWz7NsL4oMvHmWaydagNnGMglSxC2yX3EqCt/ZYN5lrDqqHiPxtMkgq4tJyBP6Pbtg0DgONsNkbIbkKj1d/xZYdH2O1RbusoQLBHSj4hiCt1reXagV/yrMlY2BYrRnaPI5+QTbAweo6jHeHAqGUQim2D5sLXMemj5w=
Received: from BN9PR03CA0948.namprd03.prod.outlook.com (2603:10b6:408:108::23)
 by MN2PR12MB4144.namprd12.prod.outlook.com (2603:10b6:208:15f::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.10; Fri, 27 Mar
 2026 09:01:42 +0000
Received: from BN3PEPF0000B06F.namprd21.prod.outlook.com
 (2603:10b6:408:108:cafe::e3) by BN9PR03CA0948.outlook.office365.com
 (2603:10b6:408:108::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.22 via Frontend Transport; Fri,
 27 Mar 2026 09:01:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B06F.mail.protection.outlook.com (10.167.243.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.0 via Frontend Transport; Fri, 27 Mar 2026 09:01:42 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 27 Mar
 2026 04:01:42 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 27 Mar
 2026 02:01:41 -0700
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 27 Mar 2026 04:01:34 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Shaoyun Liu <shaoyun.liu@amd.com>, Michael Chen <michael.chen@amd.com>,
 Amber
 Lin <Amber.Lin@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>, "Jesse Zhang"
 <jesse.zhang@amd.com>
Subject: [PATCH v2 2/2] drm/amdgpu/gfx12_1: assign all KCQs to pipe0 MES slots
 at ring init
Date: Fri, 27 Mar 2026 17:00:44 +0800
Message-ID: <20260327090126.914208-2-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260327090126.914208-1-Jesse.Zhang@amd.com>
References: <20260327090126.914208-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06F:EE_|MN2PR12MB4144:EE_
X-MS-Office365-Filtering-Correlation-Id: e1acbebe-5782-4304-a9ee-08de8bdf76ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 3DrdgkVQUWYTwXZglZiw0ioaUH1WsywWdTUczjQJlqRUQICwjpEZ18MP9dUPSDGWPJ8GX4h5YOcLYHMpvJHKnAQ8mbU/3ITfHRXF5hKf91RGI9Kg2adn0PmAiF78mpThxjjnCqJoh+iJ5i9e9yIEbFHmNg1WiyRE35uLT7OlfqbqClTt4HPKS8y0b52+3d6LiKL8e5VWatbk0V2Eflth11Xd/8cwclyCDpi0l5JFRnIKBQS33knEtYAKMUrULIKZoF3GYWnHBX0r0oQxpDlBT/uV0DkiK/NrCpw/qdexK+wHcwbd45IqiGoM2s+ixB4759zM+T03by1vlAItgPT5jBYDTAinv2twt2SuGyOyd2ho1d4OYYJ/fslfcAhNj5orfytPOUfgGNPc9hghsHaDHqC7cmLSioHDkYM06hFIVzWdP3uO5zo32AFKzvNoHoyBTdQqlbCD7o4WAGwpTuGXt0lcPSAueS5I8gViNelrWseVO7z/PCjxK8/EtDijjxndA53bbRQn5vuvIr26eCtegUiEHjp2wGd9NX+voAHgXEXRC0dxe0OyeM/o47rGJPuE5GsmEkdgIMbm+EI2KHGtd59oEpFE48xjnFsXwP/t32mZ1rIFhSMyxF0Ij3lkS4FV8P10bPgezsc5VsFYzv18xrWGiy3X/MSQ00RjovLu+ITQSk4iKUGdlAt3xX0SVBa+xUywm4vEx+PVIAW3FMJtRC+N5aDSxOKgbYDz4Ptpq0XlHR4BM1u5SIGe/c1KHwdg+YjoxQMUzDPd4wNZukAN6g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 8462qsyHfPsbJFqqsYnbkJ7pz1+HaVym1vO/CYqUR41fC+xo3eucQ70opCX1slYyMKkB60F6PBbrJ9bdvYsPdXDuoh95pK8OzratomwqraD05jwY3BHk3seJ941c7GdbcSGQpJOS8q0q0pGjPo/UspIVUuUOzv2XYweuI7ZrB2EsUDhuxpkxVKWaJaJNCfnPE4oFfUw2+sNoCbMuhhYsthwG7Iwe2zzw0KxeWOskXu4T3wD/0oRMhiYZC7wcHRgdy28RMuAZRzB2wZ9v7Ufhx0wZAn2gckqkX4yWpG4OJPwLk/KA1XJTLxq1nXLbKiUIUbNbJv14Ye+p1X/Au28eVbgTyjAKaEcq73q3fvMgXU+h8N7jkVVANNhMhOHI7S4IvpzXfHkDJB85A+b63sqMsPjZhr6CmYgtQotFr4b12PSwR4GvNhmTCehDSzSK0M/B
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2026 09:01:42.2677 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1acbebe-5782-4304-a9ee-08de8bdf76ff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4144
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

when suspend_all_gangs is issued to pipe0 MES during
system suspend or runtime PM, pipe0 can only suspend and resume queues
it has tracked. KCQs registered with a non-zero pipe slot may not be
correctly handled, leaving them in an inconsistent state after resume.

Suggested-by: Shaoyun Liu <shaoyun.liu@amd.com>
Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
index db49582a211f..2df83e06cb31 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
@@ -777,8 +777,19 @@ static int gfx_v12_1_compute_ring_init(struct amdgpu_device *adev, int ring_id,
 	/* mec0 is me1 */
 	ring->xcc_id = xcc_id;
 	ring->me = mec + 1;
-	ring->pipe = pipe;
-	ring->queue = queue;
+
+	/*
+	 * Assign all KCQs to pipe0 slots sequentially by ring_id so there
+	 * are no slot conflicts and pipe0 MES can correctly suspend and
+	 * resume all KCQs via suspend_all_gangs.
+	 */
+	if (ring_id < adev->gfx.mec.num_queue_per_pipe) {
+		ring->pipe  = AMDGPU_MES_SCHED_PIPE;
+		ring->queue = ring_id;
+	} else {
+		ring->pipe  = pipe;
+		ring->queue = queue;
+	}
 
 	ring->ring_obj = NULL;
 	ring->use_doorbell = true;
@@ -792,9 +803,14 @@ static int gfx_v12_1_compute_ring_init(struct amdgpu_device *adev, int ring_id,
 	sprintf(ring->name, "comp_%d.%d.%d.%d",
 			ring->xcc_id, ring->me, ring->pipe, ring->queue);
 
+	/*
+	 * The EOP interrupt is wired to the physical hardware pipe, not the
+	 * MES pipe slot. Use the original 'pipe' argument for irq_type, as
+	 * ring->pipe may have been remapped to AMDGPU_MES_SCHED_PIPE above.
+	 */
 	irq_type = AMDGPU_CP_IRQ_COMPUTE_MEC1_PIPE0_EOP
 		+ ((ring->me - 1) * adev->gfx.mec.num_pipe_per_mec)
-		+ ring->pipe;
+		+ pipe;
 	hw_prio = amdgpu_gfx_is_high_priority_compute_queue(adev, ring) ?
 			AMDGPU_GFX_PIPE_PRIO_HIGH : AMDGPU_GFX_PIPE_PRIO_NORMAL;
 	/* type-2 packets are deprecated on MEC, use type-3 instead */
-- 
2.49.0

