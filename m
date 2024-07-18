Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37B9FC3DA6F
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jul 2024 14:08:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA99410E8D6;
	Thu, 18 Jul 2024 14:08:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Cie3dW9n";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2059.outbound.protection.outlook.com [40.107.237.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06C0110E8C5
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jul 2024 14:08:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tp65gp0GsCM7yuLgCLyxual6W6qA2SDRXWu/+/1UEFNbyqw4xDEKTv3RSeqxVK0d2HI6ltDKgyaIQmBeZua4RxjL6fWIWcvtEJ0HhGsCpkEFRSYHL3E4GO1m7SWNUIqed61sm7no67RqyrKCjRF/Q/vQwWTqSRKDyxmf3keNRaNS9N4ORwREI53a2S64l3+I7LdFSEItWuEtAmy9R2M7l4k4WLCd8x+DcwhYDusO3GHG82X0FEku8rAVysAMm0oua1NXDMpNPzsH4Bp9Gg82inc1q11D0E6FFiw0yUlrakFTHiFCG2iBWQ7z+9wxcwmMecxZrq1dYXlPCNif4Xf3Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ANlUx+adte0HU0UDvl7R3yEqwUtR0cqyMXa+AQZnGk=;
 b=o6ADsEQ9WlUnXt+cr3dRoUK4YnPuBvJNFYf5CtO5D5vws4DpM8yNOmT7GGmiLoaHCLMOMLqGlivAMLkXqXim+Auh4XmVmi1rOtvQLAM59kpPYgLorW9sbfxsWNKywY9jL8iHAggB5Hj5MJDI8cg9aaDjDmxFK6JEnPC9J1s0KbnoFawD4C1h8TBBmiKcQK6cpG84BZY4lVdg1sSOiVz+kxlw5a+dUJokfwUuTbRjQWhRNS4Ml4ARMd6me/4ifSZy82zsC+koGHkAki++C6ed/LFHiuLk7PXewyH30/9Una/ojwN6LtRRYjI1yMoqQ6HDAYSmMaKXDUhNT4qqrW8DpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ANlUx+adte0HU0UDvl7R3yEqwUtR0cqyMXa+AQZnGk=;
 b=Cie3dW9nQfoRPKvk9n6FZv0vcRvNZXxMECAB5Ac9j/v+LfnEgTHPZwX7qDNp8M4pkQSUKmIRrgsMZs6WJ3Uh9s+WVg3E2AVQt+0l7HM6LN5RWUKE5wqMNL62MdTHFFhYUV7Ezht7sdZApqVf8LSUOV6MFjtWbdYdl3olhncB1hI=
Received: from BL0PR02CA0017.namprd02.prod.outlook.com (2603:10b6:207:3c::30)
 by DM4PR12MB6010.namprd12.prod.outlook.com (2603:10b6:8:6a::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7784.16; Thu, 18 Jul 2024 14:08:00 +0000
Received: from BL02EPF0001A104.namprd05.prod.outlook.com
 (2603:10b6:207:3c:cafe::fe) by BL0PR02CA0017.outlook.office365.com
 (2603:10b6:207:3c::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29 via Frontend
 Transport; Thu, 18 Jul 2024 14:08:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A104.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Thu, 18 Jul 2024 14:08:00 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 18 Jul
 2024 09:07:55 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 08/34] drm/amdgpu: add per ring reset support (v2)
Date: Thu, 18 Jul 2024 10:07:07 -0400
Message-ID: <20240718140733.1731004-9-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240718140733.1731004-1-alexander.deucher@amd.com>
References: <20240718140733.1731004-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A104:EE_|DM4PR12MB6010:EE_
X-MS-Office365-Filtering-Correlation-Id: da0ddfc2-32ad-4f83-8ffe-08dca7330831
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Nj09HIEwZeZ6SAOugAHC2S4xZ174lc4LId49GjOX/lwDC+leBnneBB84DyDW?=
 =?us-ascii?Q?5Aw2bckEluC5XUFCjjJOD2LOLM5IB3os+TepGSvHJ86WzrMbR+wUv1YIClDY?=
 =?us-ascii?Q?5qUY14P22eUNbAPZKH2jKKzscmI1R2e9suZ7UWF73B4r+9Y7S5VJj3bfc/Zo?=
 =?us-ascii?Q?ijJVcmtdRkk9sHrZHAeaY6se5qG9mhhzF2fmoxRvcvC29ARSQquUkWe2GaTu?=
 =?us-ascii?Q?yJ5wGGSeJia3usWdrrgjCwQwxtNU2il5llV+wmBmWaS9KPxtieQRngRvCuFO?=
 =?us-ascii?Q?0jtcEG7qYfnFp9gt5Q9BCdpdND5iuxK5w/+xxRUi1O1gfm3gsLN5FzoY1Xa/?=
 =?us-ascii?Q?OoJtzp14D+gzhFfCFLs+05J11YyJLv+BLwdPSK2s4C8Ff70NSq7rqUkDvgxO?=
 =?us-ascii?Q?wX9jYv/sHVRPjchD0X4wKEthzPCHN1rmGLDTSQ78c3+X2UxgBmpUVZIxbM/4?=
 =?us-ascii?Q?gTtlA3RmpX/KGFl+iRwi2bORBpUM3gp3HY7CvTMz4qC5SBrmTZ4S5DmEUwgG?=
 =?us-ascii?Q?RErjorH5/vEIVI1Y0RWYjLwEldYJztvJHVfHcws9ScqZDgMjxqG2NHVcDJ5q?=
 =?us-ascii?Q?Gpo5jO3FG5gZihxg5d7s/4f7F9GbDPyE+B/zsd2XAbjPP/6Uk4tZI73p0d6+?=
 =?us-ascii?Q?EiTZ9ZQBQn0RwIkJIfWsw0Pr2M3Fhceq9i3VDW6zrYxJYO8qb/udIWtdiG7j?=
 =?us-ascii?Q?rJC/WJCSgSGUTTxGRkgHdiVtTMPwDQhyNIhU2HDnTZq2jDzXp/nDIn/BxiKS?=
 =?us-ascii?Q?sGioOW/Kmi5XZXcFyRT1LMCZNrw16JOGhqbmjer500XNonoWOn2OyMbh6oVB?=
 =?us-ascii?Q?ySr9r3C5ajt4yftISRe2Qtz2Bz3yyQqvbTyEOBVK1vEnwWKm5PkB6+EPRXRq?=
 =?us-ascii?Q?9XByMtU7Bu4CNqZOzl0FUFmH0946NMoKtKp7NSMjsMicA0pVIXIm6dCAZIVo?=
 =?us-ascii?Q?xC5BCfBL/dT12aGEi2lEeGi9RtvEB2viXeN9GMp03wO9rx7Z8N+1jZn8UW9f?=
 =?us-ascii?Q?l501ZqMUlJm3bRaDmzkO0ZGtSC4yqVss6MPAY0uaBlIIzMH37AbJPzzBrfvd?=
 =?us-ascii?Q?ufsGVTC59HsOjQrutBQQkihuaeEwxbJx++zRxGDvULAIPgikXuXy40QUQyyR?=
 =?us-ascii?Q?03zuyPB2/NH8G6i0cp6Rh4QjiN3V/Tm4xU6lzMIkPge6py9tSxQr+MqiG0o3?=
 =?us-ascii?Q?YRVaux68ExHqQ/G2I5SNFu+7kxhq5U/u6jPnBlCajCyxC6fjryH43JZGAOA2?=
 =?us-ascii?Q?uiU8gEuks9YqnVSqxTRCZ/5RjJePYwyra/RywOVFL3AD3J8x+OB8gujWl1+S?=
 =?us-ascii?Q?pj7DoOORzY2fpatdt95lTvAz4JFWSJnysQKJ4rQiqLqXlJVNKnIoTBK2v/eH?=
 =?us-ascii?Q?sGAzXD9XhVEVpGeBYZCqnYJoNW7brJKFz+gdWgokAgCpbVXSrnV6l4fAp6+q?=
 =?us-ascii?Q?aHpjKQdFFDKpq7JnCb/FeImoBPtKtI2C?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2024 14:08:00.1623 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da0ddfc2-32ad-4f83-8ffe-08dca7330831
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A104.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6010
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

If a specific job is hung, try and reset just the
ring associated with the job.

v2: move to amdgpu_job.c

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index e238f2832f65..5d4883df64d8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -72,6 +72,23 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 
 	dma_fence_set_error(&s_job->s_fence->finished, -ETIME);
 
+	/* attempt a per ring reset */
+	if (amdgpu_gpu_recovery &&
+	    ring->funcs->reset) {
+		if (amdgpu_ring_sched_ready(ring))
+			drm_sched_stop(&ring->sched, s_job);
+		r = amdgpu_ring_reset(ring, job->vmid);
+		if (!r) {
+			/* XXX: these are required for subsequent jobs to work */
+			amdgpu_fence_driver_clear_job_fences(ring);
+			amdgpu_fence_driver_force_completion(ring);
+			drm_sched_increase_karma(s_job);
+			if (amdgpu_ring_sched_ready(ring))
+				drm_sched_start(&ring->sched, true);
+			goto exit;
+		}
+	}
+
 	if (amdgpu_device_should_recover_gpu(ring->adev)) {
 		struct amdgpu_reset_context reset_context;
 		memset(&reset_context, 0, sizeof(reset_context));
-- 
2.45.2

