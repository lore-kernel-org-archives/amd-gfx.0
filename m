Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57CABC5B549
	for <amd-gfx@archiver.kernel.org>; Fri, 30 May 2025 09:04:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E84CA10E82C;
	Fri, 30 May 2025 09:04:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kEcwh559";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2063.outbound.protection.outlook.com [40.107.237.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 932AF10E831
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 May 2025 09:04:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CPEc4PLhtTnSKiwlvKQvdyOaIFVNc1z1b0Alhk864udogwyx4XxjPs8JA44Hrb90da9PxaiwfDxcEuNxJowzcKSbdWdlxp7iXRzKQgzJgTjaLNhhgIrqp/yfCt0EIrc/OWlHXxauMsuhuwVWvA8TkU1vvPjb5VSGmkmcERH6tzGGPVV9gC7Fk2tYBtR6ItoF5z/chuQmTVmqa/DCuGM70tqYFM285cwwuRhc91claxwB+KobwGawyNkrsLXiXWObzrKQx/0sLq4AK+44V2KBQuqCPHOt2TbzfXh1oxqnkxRwM3HOnhqI9EIx7D8p5W5IFmdqo8FEGv5kX6NBnOcM9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AvJD+lHhKikRFQBfb4bIkRBHlWps/pHDepeCM7gaoYU=;
 b=Fovx81X06UNDbezGvz6KaEuU8GViNAQIu8vum2sxY3ePEfHFKpkoYhXPssteu8hfpaTkXiy1LtfHC1vlgE2uAducutPZyAcHmXr7rp8wznoYlWaDu9xAa6qTtHNq61xClubehaZ/YhqqRDUSZb+9OHk6hsEs8OvyGbZ9Fp/8PtVEa5yCf51xa9b+F4o8cXsQ84P3TI1IWP31njBsW31152SINOJdgshbSBi2TbykKQ3lKYTh+dKzmZv2ukdpgbeTNEHqNR3Un9hkGCFdQ68c/Yp8NmvoTmK/3c8h6Jt5BYG2Jv6gQcFwarrH1fdnk9+GVmkvvpzUhcyrnHxRGLEzng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AvJD+lHhKikRFQBfb4bIkRBHlWps/pHDepeCM7gaoYU=;
 b=kEcwh559AYdTTb+CbA/9nQxESLTFQG0LoFY76/ZqMfFi2Hi94Re+/BUCfpwTCqH0sTmGjpJD0HRaXjcq+yb8K7Z85l43q3G/4DOFYQOsArsU+YEhw6ZdFE3UqJNtOJkDJLmi7AyuvKTLbHWPd1s0OgB6uGspdlu7hhX53oT5EjQ=
Received: from BLAPR03CA0140.namprd03.prod.outlook.com (2603:10b6:208:32e::25)
 by SJ0PR12MB5661.namprd12.prod.outlook.com (2603:10b6:a03:422::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.27; Fri, 30 May
 2025 09:04:33 +0000
Received: from BN2PEPF00004FC0.namprd04.prod.outlook.com
 (2603:10b6:208:32e:cafe::97) by BLAPR03CA0140.outlook.office365.com
 (2603:10b6:208:32e::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.24 via Frontend Transport; Fri,
 30 May 2025 09:04:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF00004FC0.mail.protection.outlook.com (10.167.243.186) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Fri, 30 May 2025 09:04:32 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 30 May
 2025 04:04:32 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Fri, 30 May 2025 04:04:31 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH 14/14] drm/amd/amdgpu: Improve compute queue reset handling
Date: Fri, 30 May 2025 17:00:15 +0800
Message-ID: <20250530090322.3589364-14-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250530090322.3589364-1-Jesse.Zhang@amd.com>
References: <20250530090322.3589364-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Jesse.Zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FC0:EE_|SJ0PR12MB5661:EE_
X-MS-Office365-Filtering-Correlation-Id: 16d024a1-0845-458e-2f80-08dd9f58fe58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Gh4oh6LJ0rVsS6dEdOhU7GCfRVALh+3NVd8nhrUQykgLj3vKrW1ZMklN7Xav?=
 =?us-ascii?Q?aYsh2K4MExn3t0ZOlHQ1+gRdLlCbWko7mSjuQEQ4vpyeVvize63R4iXPu5My?=
 =?us-ascii?Q?11E7kZz5AQ/JTzwKifszY+dWe0YPzXl4/RgSpja0RP2AZdeylJaGiINdkZlQ?=
 =?us-ascii?Q?FmjbpZkVWl/YKsVpT4jMeeVCCPE4bX/KDJLXZBlIvAVHROpaTZLGGdaQUk6d?=
 =?us-ascii?Q?VYyynKqkYSdc/fUO30INmdjau5U2i0n4zlqBj/omUENNAC49qdWnA1/aRPxN?=
 =?us-ascii?Q?v6SV1+oi3I+6Q/nNWhO0PlN8XiWE1t1hKeSwEP7pMMpFWiID3SK7nQHpRTO9?=
 =?us-ascii?Q?x7ngksa65XaAi7r8R1qUOGarwyKhzpapQDXKzAWA0tTYmHC1bCjxmYN7v2xv?=
 =?us-ascii?Q?vDbbCi+qWjMWj7efwN+ZceT1QJypy8pO8J5GiE1XBH/fYxe//Xf1CwOwdE+z?=
 =?us-ascii?Q?pg4srw+hifuwey3U22ZaclQOTnGlSasITNTbZtIkeyFTjBsaOe1KexGpawzE?=
 =?us-ascii?Q?dUJjt8HHbPK7Omzlr8hq0kpaEqjmjMe6fdSLJuQFgwtoABImAfTzcCmqbQpP?=
 =?us-ascii?Q?zkltthigN0gtsvEx8vFHw0cMnnfXsy8ub/H7OdnTICq/geyLhOBjUlCLQXlo?=
 =?us-ascii?Q?1I5CQnMkgktH2nwJi/8nEbxvxB24WJuMdUt4BQjAdUkiKlKiAyEAKy65Mzbj?=
 =?us-ascii?Q?sv4/8gwqdKJ27MXpfpLEjMZI466ZTF+LXOcOHlVSoDfSEIgq/1gHBnF1BfN9?=
 =?us-ascii?Q?l6F1Tm6GFc0MGHdt7dP7KX0QjGLvXKGbtcJvl7P7AUbfRCIp1tF/z3fKiO8/?=
 =?us-ascii?Q?hLT0adXUlhPyix0fNJ4yV+vnXj95j8Jq8SvMHwK3bPgLCn6TnpjEYfcB5d+f?=
 =?us-ascii?Q?U9opk3j73M6zdI46oeZGf2qlWb4+vAoY50HUoNG4T52ujQ2s279DpSRX+xX0?=
 =?us-ascii?Q?lTCNpS5hulOw+dEhD6Bzr8C+16cvVIr1bxYpA0fHNmn1geluUflN4Ria4q0y?=
 =?us-ascii?Q?Jey/p2CsT/50zv9rC512WoPRYrVOIHQWgY8zBrLYzFok/z3Tmnl8Sgb9mAdm?=
 =?us-ascii?Q?gI+RC4ntacN3pcclBUFcbSfY1PyWUsYDhsQ3rUpS1HlelwYFv0n6V6XrFvfd?=
 =?us-ascii?Q?uTUzCF0VAcXLT0oh0TdzbB7cGQ7Qg6X35YcNN1ViFi8UglXlWjJdUvdC9Oiy?=
 =?us-ascii?Q?Ef/egTIIva4hRtAQEEANqZaczWEX/qZOIp5LGbNNMQBLHvXOxJXAoA03ez/k?=
 =?us-ascii?Q?z15xDgYkB3fSFcTa1EAYEFOXU2nhp9taWGdwKhncSwpZD4KQerc5/QrV5YqX?=
 =?us-ascii?Q?RKZCvIAaKya/+JCplTfKc+Q8mWKIrNwXgUpqkmgbeQ04wfbyZC08mHv/nOgQ?=
 =?us-ascii?Q?T2tufy6hh7DfHPQGwl8dgXBn+Msb/pi6kWBn0NsW2LuzEG5d/8DdYw9iVlHk?=
 =?us-ascii?Q?a10Mw7HcpAVySmdDvMkFLxDuwAX8g9I5XQ1VlapiIAVi/6f8Iw9m4fSZZ0P8?=
 =?us-ascii?Q?lEGJ0mG3ouyeEoisEHMc6TrOArzvRhYcrNGb?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2025 09:04:32.9177 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16d024a1-0845-458e-2f80-08dd9f58fe58
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FC0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5661
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

This commit enhances compute queue reset reliability by:

1. Adding hang detection verification before compute queue resets
   - Checks HQD address match to confirm actual hang
   - Returns early if no hang is detected
   - Prevents unnecessary resets of healthy queues

2. Implementing MES suspend/resume during compute queue reset
   - Suspends MES before resetting compute queues
   - Resumes MES after reset completes
   - Prevents potential race conditions during reset

3. Enabling MMIO path for compute queue resets
   - Sets use_mmio flag for compute queue resets

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c  | 18 ++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c |  3 ++-
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 028989e1538c..6d3597244ac4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -142,11 +142,25 @@ amdgpu_userq_queue_reset_helper(struct amdgpu_userq_mgr *uq_mgr,
 	const struct amdgpu_userq_funcs *userq_funcs =
 		adev->userq_funcs[queue->queue_type];
 	bool gpu_reset = false;
+	bool gpu_suspend = false;
 	int r;
 
 	if (unlikely(adev->debug_disable_gpu_ring_reset)) {
 		dev_err(adev->dev, "userq reset disabled by debug mask\n");
 	} else if (amdgpu_gpu_recovery && userq_funcs->reset) {
+		if (queue->queue_type == AMDGPU_RING_TYPE_COMPUTE) {
+			if (!amdgpu_userqueue_detect_hang(uq_mgr, queue)) {
+				dev_err(adev->dev, "userq not detected hang\n");
+				return true;
+			}
+
+			r = amdgpu_mes_suspend(adev);
+			if (!r) {
+				dev_err(adev->dev, "userq suspend gangs from MES succeeded\n");
+				gpu_suspend = true;
+			}
+		}
+
 		r = userq_funcs->reset(uq_mgr, queue);
 		if (r) {
 			dev_err(adev->dev, "userq reset failed\n");
@@ -157,6 +171,10 @@ amdgpu_userq_queue_reset_helper(struct amdgpu_userq_mgr *uq_mgr,
 			amdgpu_userq_fence_driver_force_completion(queue);
 			drm_dev_wedged_event(adev_to_drm(adev), DRM_WEDGE_RECOVERY_NONE);
 		}
+
+		if (gpu_suspend)
+			amdgpu_mes_resume(adev);
+
 	} else if (amdgpu_gpu_recovery && !userq_funcs->reset) {
 		gpu_reset = true;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index 2b5bd3691766..997b25f9fe45 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -360,7 +360,8 @@ static int mes_userq_reset(struct amdgpu_userq_mgr *uq_mgr,
 	queue_input.queue_type = queue->queue_type;
 	if (queue->queue_type == AMDGPU_RING_TYPE_GFX)
 		queue_input.hang_detect_then_reset = true;
-
+	else if (queue->queue_type == AMDGPU_RING_TYPE_COMPUTE)
+		queue_input.use_mmio = true;
 	amdgpu_mes_lock(&adev->mes);
 	r = adev->mes.funcs->reset_hw_queue(&adev->mes, &queue_input);
 	amdgpu_mes_unlock(&adev->mes);
-- 
2.49.0

