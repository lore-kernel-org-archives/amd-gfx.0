Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6B4F10BA445
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Mar 2026 09:01:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40B6310ECF0;
	Fri, 27 Mar 2026 09:01:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0c7+9NWN";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011055.outbound.protection.outlook.com [52.101.52.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9560310ECF0
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Mar 2026 09:01:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SdVqq9wckhNQ9t65LxH8j8hwOtHy5n2k966mkScBL77ZFaiKqTvaBLQxbyW6xHY1BnM3jFMFf+5Zqy/KO9KN7kM175M8tyR2nVtW9VyH9YBBIa266hbN2KyeWm/Z7VC0XBqhlFtOWAK5n2sdzEQJq5HdUgOmBFVeyRzHdONQwiOKcFcPPYP1CC+yFlrFuQNWRsnIRG8p41CdNW/HGfco7iUHxt4WGBIN3DCvFR5qgd6XwRfT+OMSn5x1M+woRmaSiFS/gTq37xyJ8Srm0pH2Roy7qz9JzCYCq85bBU8YkXC+k8p4L56Vm1xUnG2OuAfAhJL3lUNxaS4WvnXxbqUDtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NVLmpHNm9wQRvf3zuNsnE+g4ptPmsKoxg4e0i31UNt0=;
 b=Do4gXOPHTWsCmnXYy5diuwWqdOqi8JBCui1gR/GX0pVs2VWKUgmgGMVd99KU8QGG9caolFMKN0060rwZDN0rJc1U4MUQ3zDNPmKCTAqDWyZkeZZ6ASZOpHQ8/yFwZFtDACHeGyZHDgXPzFHob+KJU5lsKd1aCvP2YlmCc4nVjv1jt4MrhwkBJZPJyjfrliULhzhIZDYGBuM7Czh9jKxyWgH/tXrK0V0l/gT4QJjiHP3YdKQNBav5dNjLsNdhbsTMSjk0I38ajMauSQp7Qs540/ZnzsYDy65bpd6e6WuzV5Bx58w8AWWdFuxmZyBFcxpGol/pOoCYvT1UAeO2GzudUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NVLmpHNm9wQRvf3zuNsnE+g4ptPmsKoxg4e0i31UNt0=;
 b=0c7+9NWNuTz/Bradk5Ed+O3X5iqPlXDNUb4i1nKRZ7hV9fJgVmgoZObC5l/pYlwKBcUx6x4Mz7vsGDYkWCQxMmdpaPpOAHxQnSO55WMYCjDiyQYwUHh0QNu23pWojV5S/MpGxQVZgMuaP3CLP/+KWiLSh2PJM+pkvymmkB/DLXs=
Received: from BN9PR03CA0216.namprd03.prod.outlook.com (2603:10b6:408:f8::11)
 by CH1PR12MB9647.namprd12.prod.outlook.com (2603:10b6:610:2b0::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.10; Fri, 27 Mar
 2026 09:01:35 +0000
Received: from BN3PEPF0000B06D.namprd21.prod.outlook.com
 (2603:10b6:408:f8:cafe::ef) by BN9PR03CA0216.outlook.office365.com
 (2603:10b6:408:f8::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.22 via Frontend Transport; Fri,
 27 Mar 2026 09:01:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B06D.mail.protection.outlook.com (10.167.243.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.0 via Frontend Transport; Fri, 27 Mar 2026 09:01:34 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 27 Mar
 2026 04:01:34 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 27 Mar
 2026 02:01:34 -0700
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 27 Mar 2026 04:01:27 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Shaoyun Liu <shaoyun.liu@amd.com>, Michael Chen <michael.chen@amd.com>,
 Amber
 Lin <Amber.Lin@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>, "Jesse Zhang"
 <jesse.zhang@amd.com>
Subject: [PATCH v2 1/2] drm/amdgpu/gfx12: assign all KCQs to pipe0 MES slots
 at ring init
Date: Fri, 27 Mar 2026 17:00:43 +0800
Message-ID: <20260327090126.914208-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06D:EE_|CH1PR12MB9647:EE_
X-MS-Office365-Filtering-Correlation-Id: b0286644-1063-475a-6c93-08de8bdf7291
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|1800799024|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 87vonENUHp0JYmGVgw0EuFf3lh0A8cROg7JTen75UQdlLp8xgkzipcb1L/WgYn1ICZifSLsGRv0n5IPBtMFLcROHrvNP3qRw4bkavvoXbgLQg6a6SXRZ83vy2njvlFhmq2fg/IyKEEDxpav9tZiVw1yAP5i+8hHh+3U4pdkR/lszNpDeGJMIiKjq/4olbTHqyoiJjcrRbZS7iPmu4OeXlVY3KI0yg1axNDBMt29mlBms3iof9yYNqCc8dwZSRdSGr+0st6OJ2UJ6ZUNSaFi5nx7lITLHll4lzcHQpWsB6KUVLvveVc6XlNpV6W++qk+/uTt3Em4j+m5rjmI8LpSti9LXgVEVgxeTm/45efRcTutXesQ3YXVzQXBNfTnBSKcLeo1lodRrnQPByZ5WiBCyhHZrSwD6qns/5KVyj5mXJp5AtHymr3+N8BHZOqZxgQWvYJMY0IjpYDo06JwE7l3JD9FccGmXZEF5C6aQY9FFdTGYC0kTOugyRiDqnqY7BU8mN7W59haObLL7L0UAouOyArrY/GNAo4Ot5Ns8H2Nx/9VgbnDAZBtyhxl0yiuT4dqY78s+UO7qoFz5bA5Bji5Zy5YChlBBO3SPDXHfJJQUVaAtROdjgS9WNvoi/uhL/EaT8VBJVcE03Op5K/nmeGRsF4rt9VwMAGuKeBmGfc+RACfAr+yZW59L104iwFJsST0GL4pKPwOQR96uyRPIO4ogYrMHxUJXaWx3/W/1x+x9ooRiLlzX55MHUg1R+B/XHVcV94jbXKCJwYKclhUvE2kiaw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Q5L61c0+FgDM7Zyy5zVfqWnbwXadK0FKb6bUz71AsiMOSNt/55+PpthbEnv9rpjVh8jxgJX9D0R/vj6U11K5EzG1wfzCm2VljO9meZN/D5u5pV/n6F1oqIrUmLuTslaXnURJ/TGj4v2m8ui75IHn4OpoXoBzKsd5o0DvyAv3ihd2C7B8ZZZAyrVHIYPiIGclWpDkR05qzDKsxiKxAYFxzny1XJ9K1gCK4JyPBaVeI4vawP8CSVGuOkaTJi03pZMQ+FSA353iRzVN1rfihODhz+Dc4s5a5oQnYj/PBd9lwPeJKL47ZdEAh9Ul6eJ226+kWP5nk9xp64kycriQbZ59xwnLpeorxfmY3T3peGOnKAJW/QrrgSQlS3fCm1EvEpZFTeYvtfiogjecF5/gMsuTM2VMSka6Udxhuh89nFhXkdCG9n9BS08DKi6I0ghC/S41
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2026 09:01:34.8897 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0286644-1063-475a-6c93-08de8bdf7291
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06D.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9647
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
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index a418ae609c36..d99757e06738 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -1007,8 +1007,19 @@ static int gfx_v12_0_compute_ring_init(struct amdgpu_device *adev, int ring_id,
 
 	/* mec0 is me1 */
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
+		ring->pipe = pipe;
+		ring->queue = queue;
+	}
 
 	ring->ring_obj = NULL;
 	ring->use_doorbell = true;
@@ -1018,9 +1029,14 @@ static int gfx_v12_0_compute_ring_init(struct amdgpu_device *adev, int ring_id,
 	ring->vm_hub = AMDGPU_GFXHUB(0);
 	sprintf(ring->name, "comp_%d.%d.%d", ring->me, ring->pipe, ring->queue);
 
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

