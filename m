Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D2D4C35FF1
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Mar 2025 18:46:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8FF4210E08E;
	Fri, 14 Mar 2025 18:46:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4mIqKzcf";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2072.outbound.protection.outlook.com [40.107.237.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 350B210E08E
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Mar 2025 18:46:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HTt0Nf9Lh9iZa0q2BixLY5gYIz8i1j+AVEYEu3Msd1fWXL5ZMCagEhKDQ1sYBFGd6FW0pTk6k1kf6nI7wkk/dKg68I02KclUB6NKK323lnl7HQWaY65xRU0vzkAA9BDCSiJbTzEGAyzH+gOaZn5M9HoCT55FMa9KURU+RKSO1dI0H/l/v+KGujHkd9o5Fdd75h1zh1l0Cr5oeS3NVnhpJUCF9mFnBMZmSjfKxvcunrtiTrod5egUzi0AGWNb7gV9W8VIhm9rgdbGwSYfIlEJHqn3PIQEOdr7+DTJ3NOBgry4VkEK+VOku0b9Gb/eMytDHpWxLo84+ux8rtoN+Lev/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eYe+FWMDeYy9UQF6goxQELZtD8dXZQRUuPNlixqH3xw=;
 b=yHn7m0THnzyRzheyyj044ZF24MNeUjtqfurj+FAQmHZqi3qPy5NpYnXfpI9SiBD8/kAUS3MzFWE+/KSJFuaGZAWPaedMNx+CnxZM+oV93PKgePARHmmK/iQBRoOK3vzXYHgvm6aeSrMT8eJ6ZZ++ta/n+516+oA4oT4lGMecBlvGFdid/c6lBBKFCXvCJYSNzRRV2nyAc2A57wQP6YbB8CL8JwhuExgGgKYn0gHlxrR7GZ9KKbsRsOooP1PlXIs2qLktjZT9yVmg+orW+B08GpxUCrd5E17BlmVs2uyJIYPmbw1j7fPmTF9M2CIqSG35ITdVl+Xl15PVeCOss3UM3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eYe+FWMDeYy9UQF6goxQELZtD8dXZQRUuPNlixqH3xw=;
 b=4mIqKzcfRArCUHYgYlaJpugAyH3qadEO5OIIkOtEb2onem1LOhw97JVhYZx47gVISJMbtp8S23fRLShYlLrBbMko18npOTzBpoaq+rXVdNLTxVFU7105EL5MXqLlZQX9X3cYNqc91PAOkPfM7mr8QfcZfAFF/OA6+ziFafWYEy4=
Received: from CH0P221CA0042.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11d::26)
 by DS0PR12MB7558.namprd12.prod.outlook.com (2603:10b6:8:133::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.28; Fri, 14 Mar
 2025 18:46:19 +0000
Received: from CH2PEPF000000A0.namprd02.prod.outlook.com
 (2603:10b6:610:11d:cafe::a2) by CH0P221CA0042.outlook.office365.com
 (2603:10b6:610:11d::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.28 via Frontend Transport; Fri,
 14 Mar 2025 18:46:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF000000A0.mail.protection.outlook.com (10.167.244.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Fri, 14 Mar 2025 18:46:19 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 14 Mar
 2025 13:46:18 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/2] drm/amdgpu/gfx: adjust workload profile handling
Date: Fri, 14 Mar 2025 14:45:58 -0400
Message-ID: <20250314184559.3607419-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF000000A0:EE_|DS0PR12MB7558:EE_
X-MS-Office365-Filtering-Correlation-Id: a38f408d-22e9-467b-74c9-08dd63288254
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kgLbfc1w58fV1WjmL8Zx9Oy6wlTLzYNwDsjCuF0X0jkmE222CXLnBeEscd3V?=
 =?us-ascii?Q?zzAQNTCRBtVdM4D7p+gewefebWK+6ingF1nCFpitLj7SBCbpMMv9iq/gLo8N?=
 =?us-ascii?Q?/lykQOfv/O/uITqrqjuYRdzZF0Qimiu5l1Nl69N7GE3WEqAsFxueqST1xxX0?=
 =?us-ascii?Q?hzNQNrCAbBeeV79XqxKJeQ3sbl2YTN/oRcSVRK3+vYLlLt9fr1ZKHe2BH4KC?=
 =?us-ascii?Q?0Yk/iNn9SuJmeU1t5n6Rb3BIvzsRLYcpN7GTHzbj84+fGEJFbtxrRMABrf3R?=
 =?us-ascii?Q?qMZu/f0leKUgEYeHOG/hMMR4URG6mTl09PmBI7trkwm/CnvOkKQY8Lpjb3CJ?=
 =?us-ascii?Q?eyneZRodvcWvN7EmWW7Y11V6TANMvbuGuUJ5PWkOjlk9yU+eDvZqoGmx8tBE?=
 =?us-ascii?Q?xTKQZI4ggzcG0Ab8X/UccAJoaDlf0hKaqSw4PJXcNx3rYx8xcC7iCuPGWWmK?=
 =?us-ascii?Q?8IkKIc7FngIpkwBYrkhZIsCeXZ8qiPkgq2JHccb2FoxBwM0al9Qij0y+QDhT?=
 =?us-ascii?Q?W9RyQZRIOgM7DWPOc+X3z05CzYf9f3cxtmh4s0t1wAVz+Vwv9cYVkh7NtVk2?=
 =?us-ascii?Q?3pASPPAAz+MsxgmakVq5gGRep+zKRUoFg8RBVclqoxEqkLzoVAkWrBvIRbLL?=
 =?us-ascii?Q?Mo+8ouTQN4/ZdT6Cdk903mPKCGtyr8Vj4UUICuSnwOywwiR4u+mhKynuv+0i?=
 =?us-ascii?Q?5qZbxJ1PFZ32Vxk3IqVmFQI1ixKuoA/Bnkig3PxkWt1pQ7NqCkwTjW4ktLlQ?=
 =?us-ascii?Q?wlqZ2t+1QlFWMJAmcAASGPpRcOkoTpPZEuPKTsYZDjQrXQcLyhWFRQfIs3iP?=
 =?us-ascii?Q?WkMd6Mhg62+MmMoDtD/KTac1vJ9kDPz38scrlRCVvyQxfDd6qW2qU7PmW6zk?=
 =?us-ascii?Q?+qvoJUhbeewlcmWzTg71NEzVKyc+UYNPhy3lQAvHnRpatdecF04OkUn0ZaVA?=
 =?us-ascii?Q?XWM9KCHZ3C9Lu4yo9Xa1dLnKzNA5hBPWirEPxe/QfqMI+KDnBYrJBQyufdxj?=
 =?us-ascii?Q?f7buxR/WUJp3q2KbLPzFiJa8n1qibF6YhsSt1rjoW7afDmsiTjc+eitnw1FP?=
 =?us-ascii?Q?SZlI81iekkm/xI49hIc63HWxG+Ac9Ijxo32t0CCSTSgJ6Qjsm6ozS7YQi0sR?=
 =?us-ascii?Q?OjGlhToSnc2BEahtoZSMajIPgWaoVNRtnKVjXekhXHfUAmpWXaGNR8ri3PeN?=
 =?us-ascii?Q?6ry1nnU8P9+hwwKg2yv4hpx4sVeQ+e6xMKQs4oBNvbmadmN3EMQ47ThDxbzc?=
 =?us-ascii?Q?5pPtq2n/ui6TF6tiNQujtii3e/B4pU82oHwPUpuvlj/ya4OtSvH8qeqLRsBO?=
 =?us-ascii?Q?ZjjCPyLfrNYpL9EMd/cocjozpgTZaSlkzoQLwlYWopbjzc8Qb/7k4Cq9WE4D?=
 =?us-ascii?Q?1lmEkQv01e12Z970A81Sr28ni8fNo82IZ5lA37BUsLoD9M55AvKoUQv1x+SS?=
 =?us-ascii?Q?BNJhToc0lk77GK9bSlD+HGPYbNVbNPeiYyhj2uQg5duuv0l97j3P+jQq9dcO?=
 =?us-ascii?Q?07+QQJZ5wbxRUFA=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2025 18:46:19.2268 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a38f408d-22e9-467b-74c9-08dd63288254
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF000000A0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7558
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

No need to make the workload profile setup dependent
on the results of cancelling the delayed work thread.
We have all of the necessary checking in place for the
workload profile reference counting, so separate the
two.  As it is now, we can theoretically end up with
the call from begin_use happening while the worker
thread is executing which would result in the profile
not getting set for that submission.  It should not
affect the reference counting.

v2: bail early if the the profile is already active (Lijo)

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 29 +++++++++++++++----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 099329d15b9ff..4beb0609e7034 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -2188,18 +2188,25 @@ void amdgpu_gfx_profile_ring_begin_use(struct amdgpu_ring *ring)
 
 	atomic_inc(&adev->gfx.total_submission_cnt);
 
-	if (!cancel_delayed_work_sync(&adev->gfx.idle_work)) {
-		mutex_lock(&adev->gfx.workload_profile_mutex);
-		if (!adev->gfx.workload_profile_active) {
-			r = amdgpu_dpm_switch_power_profile(adev, profile, true);
-			if (r)
-				dev_warn(adev->dev, "(%d) failed to disable %s power profile mode\n", r,
-					 profile == PP_SMC_POWER_PROFILE_FULLSCREEN3D ?
-					 "fullscreen 3D" : "compute");
-			adev->gfx.workload_profile_active = true;
-		}
-		mutex_unlock(&adev->gfx.workload_profile_mutex);
+	cancel_delayed_work_sync(&adev->gfx.idle_work);
+
+	/* We can safely return early here because we've cancelled the
+	 * the delayed work so there is no one else to set it to false
+	 * and we don't care if someone else sets it to true.
+	 */
+	if (adev->gfx.workload_profile_active)
+		return;
+
+	mutex_lock(&adev->gfx.workload_profile_mutex);
+	if (!adev->gfx.workload_profile_active) {
+		r = amdgpu_dpm_switch_power_profile(adev, profile, true);
+		if (r)
+			dev_warn(adev->dev, "(%d) failed to disable %s power profile mode\n", r,
+				 profile == PP_SMC_POWER_PROFILE_FULLSCREEN3D ?
+				 "fullscreen 3D" : "compute");
+		adev->gfx.workload_profile_active = true;
 	}
+	mutex_unlock(&adev->gfx.workload_profile_mutex);
 }
 
 void amdgpu_gfx_profile_ring_end_use(struct amdgpu_ring *ring)
-- 
2.48.1

