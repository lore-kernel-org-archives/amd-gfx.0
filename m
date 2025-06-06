Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39CB4C5B559
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Jun 2025 06:44:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B018310E9D8;
	Fri,  6 Jun 2025 06:44:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lXfn8Wm6";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2062.outbound.protection.outlook.com [40.107.236.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B09210E96B
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Jun 2025 06:44:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dv0R73VdCxZRbohCfzg/a89GWDkAYzngI8Y9tQcbsxnu4yKY3Rrsw5phoMfFU7FrzjdSt/kT4Jktzs253wbKX8xAN30e9T2cCsr6q0i7c7V8+kF/f0pClRfpUF9Dsvbaqa2u8aW09OBG8TeK384JRF4C83cKpQwjFlCzlwACHgz7yM/pPtV6CNC+IUabIt+h+qPlIqzxtECg7OHgKkRyqiGlE4847JS3K3LxlA84RVVm9c+fIelq9BGIRJvb4hGvj46n1klpfd7rZcC6oVG19jlYthCQYd3ilPuwjn6cQliDfmx3OfMWAf1/7wk8RLy7KE1kV+VXaTxa578n4GtfuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VRDbsDS3BsQqnHwNWolDWhccqP3JLNYbxzNQOqvhNww=;
 b=tMWKyJ89u/umgg+f4gbZpon3zHfciZ5eD4hpk6nzyRJekKHHpNJQqg0/BvsneuP0hR/GoBm2UjPUaPYHNQ//ItvTf56zsKfZ8HSKZ/J+3Datfalc4/JwbCdiI7jXAo2GVyHMh+oV9ubywKX2nNMgzSaWsMJInhzxw5uqXYMmuqm8FD+r6kIO4WSBI5UjXo2ja+Mur0UXO/ZKenZJjr01ctAt+lX/a90jCcizeRGRWfc/yYbo9PbqQDkojMc8yCqfXtybFgq6fmuiXsB/HR4V01TWxGrXvNZ3xni9dQ/55+tGKXXzcWlRHObmQvaFXx8M6uvp/vCteoMYuvtybqvz7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VRDbsDS3BsQqnHwNWolDWhccqP3JLNYbxzNQOqvhNww=;
 b=lXfn8Wm6/0Eiih1t8y2EgknyldXU/48OGHfV3UhF+JY/e+JGRnhCmsaZMcrcplagRVkATlw93qSffxLRlEWsfXIiRJs3iVXoxHuPejMvvwZ+BjF4KeEd9eNgeLQe8hGDXH+9HEwkjcH6UZp8lQvGIPhctwwtVzeE36Kr7wcjy/s=
Received: from SJ0PR05CA0067.namprd05.prod.outlook.com (2603:10b6:a03:332::12)
 by MW3PR12MB4492.namprd12.prod.outlook.com (2603:10b6:303:57::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Fri, 6 Jun
 2025 06:44:25 +0000
Received: from SJ1PEPF00001CE4.namprd03.prod.outlook.com
 (2603:10b6:a03:332:cafe::4c) by SJ0PR05CA0067.outlook.office365.com
 (2603:10b6:a03:332::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.18 via Frontend Transport; Fri,
 6 Jun 2025 06:44:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE4.mail.protection.outlook.com (10.167.242.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8792.29 via Frontend Transport; Fri, 6 Jun 2025 06:44:24 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 6 Jun
 2025 01:44:20 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 22/29] drm/amdgpu/jpeg4.0.3: re-emit unprocessed state on ring
 reset
Date: Fri, 6 Jun 2025 02:43:47 -0400
Message-ID: <20250606064354.5858-23-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250606064354.5858-1-alexander.deucher@amd.com>
References: <20250606064354.5858-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE4:EE_|MW3PR12MB4492:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e36e474-8f83-4950-7264-08dda4c59384
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zTxCP6fdD6zdUgQdimw/EyaEnbPEq9Z9SNiauLR2J2qtCuIOuG9QruNA3Mo4?=
 =?us-ascii?Q?ljGm8ozVwCgSYSrBJMS+ZgBp9LxedigcXH7Hqb0hCgY2qz2gEKRn6p6rG5pD?=
 =?us-ascii?Q?tMtuZxyDG080jWDEhlHJv3cNG5JaGtVsdBITPZuWGIs/H+QrmIhtPXB8vB2g?=
 =?us-ascii?Q?x1u6/EbLkC38XRkFq46Jhy3uGZOArjhgAxT2nFOKJoDVRXjzrwN4XKMOrjGT?=
 =?us-ascii?Q?0S8H6Z9TH6r7ZWwZyzjSdNX9Dr/pPQowo62EbPWn7hsP+1JPNuFTcKnOQO7A?=
 =?us-ascii?Q?Do0mV+JRj7imiEseluBX2qWhRDQO6lo/9jaitGfxuAgLha1jY3AGxXjuke2d?=
 =?us-ascii?Q?X0rPEPcPmUBpMaD9iIQ2KTHiJ/jRxNhGoG6y7PbZ1OUCIlk2IAcJcOCVl92h?=
 =?us-ascii?Q?HpndhxjWgw1nENphhWn6OfhWiHeU+4strHDPT57q0TilyGkFKXlEUtofRl9V?=
 =?us-ascii?Q?GFyECUTMXuKFZunkl5eTJiw6XPPh7zGpVYHjXu5KMfOinC6P+Q3BVYKXOqlv?=
 =?us-ascii?Q?0ydpzbkINolzFL/TYbmuncBQGSISkurF0s0dZe+pCpJ2v3EmekUirgIDFub5?=
 =?us-ascii?Q?yRSDe4hkF82RZeqx2MRrfvmdcerksjy9jWlv+bTmrKEouviho4UPyoZ+DyEl?=
 =?us-ascii?Q?RjDGppEVKd/18aNwDWYRJPOAp2SquNqLS0SfdX9cXxt/A+TIGraHmJp2mzQg?=
 =?us-ascii?Q?efk6bcE6xxZEpizqROydlf9ys4XeaBBr1sBiqf0XbRyqmNlynD8i0t6oMf61?=
 =?us-ascii?Q?Kv7ocZxqeeNZs2a5nysGh56R9+M5oZeHEdBp+0ePrHMWLPab7aGFUNZEakBQ?=
 =?us-ascii?Q?tqMRB6hAzJeIWlyYbiHc+JN/k6BAaZkAXfOwnhYEsJdj0h30FpfxNLqiC0pL?=
 =?us-ascii?Q?RLp7PZ1YIx/QNx8ZOdXLGJszHgVnS/IqtUq0JzTIHgoQaVoGGNj1EV9P4qwC?=
 =?us-ascii?Q?eEG35HgcJqBKFVOeIOaqXX+YwrT4TFy0ZwjWixuEf/SnYO0LPFfkYhHzF2Aj?=
 =?us-ascii?Q?oe1X7mG/mhiCzLpS1o9n66GjNZUnvwtnR5PuOCVIDu5x90ZHjMweORoNFvHG?=
 =?us-ascii?Q?+ljisOSPTvAslIvZhhVxDpEAsxzmc6hsIEeyGlASY15T+Y0dTuBpbAJbVmIk?=
 =?us-ascii?Q?5wcZHgEkjVYrqHxu81SLf7aQ2Y3Bk1nBykRNXa5F4KPMUL8dUW6rFSTe1CHI?=
 =?us-ascii?Q?3ir5yqtdeyTlHFKVH5yvHvuBDBtu5c7qG67iCkAz8EpWa6i1nnEgGA/ouS+c?=
 =?us-ascii?Q?mW2t/eq0oIZ8MzWYKoxY1SC+Puu6v10tNJBE5nA1L9w9xTB83RnIVb682Mf9?=
 =?us-ascii?Q?V1PxM0dQbflBIn57Tqmip1xS9WwoOR+EaRX9xDHFJEGTs2FCTRqDwVpgH1D2?=
 =?us-ascii?Q?ahY/WlNbNrwQe+ZFd15ZYdKPppfUKMlZKTG02i0HAH4fikEevJ0Y+md98Acw?=
 =?us-ascii?Q?Revz9PR1NrR/L3kiHNgMD+N33PK0h4t51uoLMp1G8ho6HPdB4+LzFEpTP6cR?=
 =?us-ascii?Q?xibsnKje6ICr6q9cuP6YxlUPD3VJgCqCTSwR?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2025 06:44:24.5656 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e36e474-8f83-4950-7264-08dda4c59384
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4492
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

Re-emit the unprocessed state after resetting the queue.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
index c956f424fbbf9..e177760f8508b 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
@@ -1151,14 +1151,22 @@ static int jpeg_v4_0_3_ring_reset(struct amdgpu_ring *ring,
 	if (amdgpu_sriov_vf(ring->adev))
 		return -EOPNOTSUPP;
 
+	amdgpu_ring_backup_unprocessed_commands(ring, &job->hw_fence.base, true);
 	jpeg_v4_0_3_core_stall_reset(ring);
 	jpeg_v4_0_3_start_jrbc(ring);
-	r = amdgpu_ring_test_helper(ring);
+	r = amdgpu_ring_test_ring(ring);
 	if (r)
 		return r;
+
 	dma_fence_set_error(&job->base.s_fence->finished, -ETIME);
-	amdgpu_fence_driver_force_completion(ring);
+	/* signal the fence of the bad job */
+	amdgpu_fence_driver_guilty_force_completion(&job->hw_fence.base);
 	atomic_inc(&ring->adev->gpu_reset_counter);
+	r = amdgpu_ring_reemit_unprocessed_commands(ring);
+	if (r)
+		/* if we fail to reemit, force complete all fences */
+		amdgpu_fence_driver_force_completion(ring);
+
 	return 0;
 }
 
-- 
2.49.0

