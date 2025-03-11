Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF57DC28B2E
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Mar 2025 08:33:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 30EAD10E0A1;
	Tue, 11 Mar 2025 08:33:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2IQl8HQ+";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2089.outbound.protection.outlook.com [40.107.223.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96D8210E0A1
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Mar 2025 08:33:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YZB8xDVfRrkEBymwt5KE/oucdxt9EkiIcVbGtpRSUQFj6UvQuD7o4LQIjO/2LzcnuKEMNpcWq0kPKcfrbfr8tw+Bs9TzzPGdp04hMM4YgrIhmkvqZVXgKmQ1A0h6sX3HNEgEoS/PoASi/yPoGevAVNHDJerFUIM8afaVA/WhKe2l8uee64cePL5oE6LlJNVgsfXR0G9Fyxvca+/5p6SpA9tMyV/ZSoQt6ylIzQr8vsMNJTAiG1hlI2zVaxO8OfDib7PjefA15L8UI9b2ovVn+SdIy9eiGLvr8AYWXghoDTeJ4SbQJtEAg9P8DsOHtOXzIbnRfvbcMNG04qNFezgSng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HbmpnXAciLShfhllCgDkBZzIdv6wDGfBQ9ZHsddgykI=;
 b=TsdV5MHUzLsrTmAoG5ahBQoQm3qhYnpejeOV/cSqGosnhK1nZnBaVBsQC2yJ1xuiSXfp8UG2Cn1Py3OqIA8bmHMe+xkNFvpeRECgr2iF8qipj/HQxOZ0S09I6v3r2DSEukdo72w1hoV9gsV4tMNibsZGYK8Ac+t/yUVc1fVWMyHucuApFJlHE+uKqtSiX+O9M08NvErALlshXOYpuvH/SvfXksb+XeePnA05T2aAlijLAXZk33z4DDKYhWnZmt9hQdV9srdrGy4QTYcdPQ4DMWdrLqGSA+p5VAhP5+gs/FuAEXqmwt6NGX0OD3vjlwlQdoj0aBW1bhdcfOR6T6WnEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HbmpnXAciLShfhllCgDkBZzIdv6wDGfBQ9ZHsddgykI=;
 b=2IQl8HQ+KIX9E9CQzywTCgSxP4PzCAGyx7DET/yR/sS6YJ5YB9sbeFmUlfqIMQjrCYX0c3Bwxf8t7e1aZnjrCs+W+0e4zbOVskTsiMRe7sopRFN/2niiOtd/0TDpwO9RFwe2qWRbr/zOEzNW5GjGfzI3XbESV7m9C8pvv5G8Fcc=
Received: from CY5PR18CA0023.namprd18.prod.outlook.com (2603:10b6:930:5::19)
 by IA1PR12MB6580.namprd12.prod.outlook.com (2603:10b6:208:3a0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 08:33:10 +0000
Received: from CY4PEPF0000EE31.namprd05.prod.outlook.com
 (2603:10b6:930:5:cafe::a1) by CY5PR18CA0023.outlook.office365.com
 (2603:10b6:930:5::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.27 via Frontend Transport; Tue,
 11 Mar 2025 08:33:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE31.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Tue, 11 Mar 2025 08:33:10 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Mar
 2025 03:33:08 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Mar
 2025 03:33:08 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Tue, 11 Mar 2025 03:33:01 -0500
From: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 <jonathan.kim@amd.com>, <jiadong.zhu@amd.com>, "Jesse.zhang@amd.com"
 <Jesse.zhang@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: Add SDMA queue start/stop callbacks to
 amdgpu_ring_funcs
Date: Tue, 11 Mar 2025 16:32:59 +0800
Message-ID: <20250311083300.2897523-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE31:EE_|IA1PR12MB6580:EE_
X-MS-Office365-Filtering-Correlation-Id: 36d83613-e137-44f6-9075-08dd60775b10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?E4Btq58/+0oHx1/Qy7wAoCJ8dmRBVnhIe2Fful61I7IyViUMYAyTCr0c4NuE?=
 =?us-ascii?Q?PejfLncsMsY8GsNeygeGuU+KtGxQcjHpP3lJGVNP/cLdUn5ceV6/JMYPFJ/1?=
 =?us-ascii?Q?UkfrVQVhtsh51fm/tVDvy0IHH/04Zj79UEGOYv+yVw4C7Y9YFhw9DBDdS16o?=
 =?us-ascii?Q?yMsdc9g6+sSArnu+XAa143wJ2tQoRoXwlbq4jaczeZ21WMih8oR4WUSaCGNK?=
 =?us-ascii?Q?G07z93SCG32725a8GsTfun2Q23ukNvYfgVl+Ws9Hu1a7u1Y+B8eqWcEUhtnl?=
 =?us-ascii?Q?u4TyPeqkcf0FdA/xS5BqII0yEXjj0oVNYXF+g3Hx/EH3vLXihMgM1zPXJI1Y?=
 =?us-ascii?Q?wt7Pr8z4Zxg/MkXDiWaKq96yGRqt4hS7c4cQA7nhDvhDHaM8tBkfgnHwaLCt?=
 =?us-ascii?Q?DEmSMaGaBE4oh6j8IWs7++zy8m1xu7CVPoQ9kbzptZlYyFm4gdBxMdf+X+Hs?=
 =?us-ascii?Q?JwudL2+b0r+Tz4Qkc1Kk0kx1oTXg712QIH1sy6jMmUJJI40Nw6sKQZWVUcZ+?=
 =?us-ascii?Q?Xvxyf9NdK/uXKTeOVzqfdtXEfn1KQxfCvUetfqqBvOsj8Z1q7M2c2/zy7f7s?=
 =?us-ascii?Q?WHz0L8k2B2AijXPr30aoCykv29OtxRDYqZ25jgUaoVSG/VDwFdC4fvrsegkp?=
 =?us-ascii?Q?VjeCAZF1iZNjzyGHHNWkzH/rfYVWtIYeyeoiuipAf4+CocrRN8W/Hf27SCAa?=
 =?us-ascii?Q?3zreatU4BgwDwFneaiXd5lDm7yAzIxYKOySyR6FiKlIeMmOeMk0Dm529LfmU?=
 =?us-ascii?Q?f9LoXGmA8pUjuI2QpjG/Z6AXkGLLXIt3rv9zsxJyeO9VMDA/0FQX85Z0S+P2?=
 =?us-ascii?Q?8CEvvtNSyUvRaGR508lkgQ0eSL5R4zU0Mbjo1+CG5SVKRqmT0OxsKADGSTh+?=
 =?us-ascii?Q?TUoipdi2/aQ7lXI64+XLtXQoIcS+e6OATH03aU+SucR+4fD7EdAx8RaKAmNC?=
 =?us-ascii?Q?Uw1e/mq8iZN8AddAOKTpJhlIjcOGATkNEaZiNTQJG0zZ5Ov9qrYZio80sfUX?=
 =?us-ascii?Q?LFJzwg5diCvdDKku+OPznef79nvwwEr2qVU+huGfR/NGLJQGoM80fjMxhSf7?=
 =?us-ascii?Q?mg0H361VtsyKS2yfpgGg5t8neYVga4YS4lQudiAaRwWgATaD/AtdugEkIFX5?=
 =?us-ascii?Q?daA+CW1GKAAqp5+CvxaoxH4/4BqM3pi4t/prQgNxARMdVl9Sa9BQHmjRwCh9?=
 =?us-ascii?Q?Nmjr/8Dts4TUThQwH4COpY/asUHHl38M0oc0UYebNg9gRQsEcFJRqW8wMNGX?=
 =?us-ascii?Q?KdgiTi1ItJcZwhpBRrFFmzrJN8lJllrUO6wGBc83cvboCkWMkJub+obhWWPB?=
 =?us-ascii?Q?WHmY8tqhJxKNRhQOhebfrSXvuY5MJ77S1Wx3EJ19kS1qupopI6U6jdwOrc0/?=
 =?us-ascii?Q?qobtY57urBz03GuaXqiugrd0EyGn0uLiS8a+TGD9qvQEnX9FSKwY6HplF0Gi?=
 =?us-ascii?Q?w1USU/r+BcCcULMm5iLOzTA1Plazv7zJWgHTgdUrCHymowCsGf9rXpG2ed37?=
 =?us-ascii?Q?fnBiD7Rj2b2ADzQ=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 08:33:10.0102 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 36d83613-e137-44f6-9075-08dd60775b10
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE31.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6580
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

From: "Jesse.zhang@amd.com" <Jesse.zhang@amd.com>

This patch introduces two new callbacks, `stop_queue` and `start_queue`, to the
`amdgpu_ring_funcs` structure. These callbacks are designed to handle the stopping
and starting of SDMA queues during engine reset operations. The changes include:

1. **Addition of Callbacks**:
   - Added `stop_queue` and `start_queue` function pointers to `amdgpu_ring_funcs`.
   - These callbacks allow for modular and flexible management of SDMA queues during
     reset operations.

2. **Integration with SDMA v4.4.2**:
   - Implemented `sdma_v4_4_2_stop_queue` and `sdma_v4_4_2_restore_queue` as the
     respective callback functions for SDMA v4.4.2.
   - These functions handle the stopping and starting of SDMA queues, ensuring that
     the scheduler's work queue is properly managed during resets.

3. **Purpose**:
   - The new callbacks provide a standardized way to stop and start SDMA queues,
     which is essential for handling engine resets gracefully.
   - This change simplifies the reset logic and improves maintainability by
     centralizing queue management in the `amdgpu_ring_funcs` structure.

4. **Impact**:
   - The addition of these callbacks ensures that SDMA queues are properly stopped
     and started during reset operations, reducing the risk of race conditions and
     improving the reliability of the reset process.
   - This change is a prerequisite for future improvements to the SDMA reset logic,
     including better coordination between the KGD and KFD during resets.

Suggested-by:Jonathan Kim <jonathan.kim@amd.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h | 2 ++
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index b4fd1e17205e..1c52ff92ea26 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -237,6 +237,8 @@ struct amdgpu_ring_funcs {
 	void (*patch_ce)(struct amdgpu_ring *ring, unsigned offset);
 	void (*patch_de)(struct amdgpu_ring *ring, unsigned offset);
 	int (*reset)(struct amdgpu_ring *ring, unsigned int vmid);
+	int (*stop_queue)(struct amdgpu_device *adev, uint32_t instance_id);
+	int (*start_queue)(struct amdgpu_device *adev, uint32_t instance_id);
 	void (*emit_cleaner_shader)(struct amdgpu_ring *ring);
 	bool (*is_guilty)(struct amdgpu_ring *ring);
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index fd34dc138081..c1f7ccff9c4e 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -2132,6 +2132,8 @@ static const struct amdgpu_ring_funcs sdma_v4_4_2_ring_funcs = {
 	.emit_reg_wait = sdma_v4_4_2_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
 	.reset = sdma_v4_4_2_reset_queue,
+	.stop_queue = sdma_v4_4_2_stop_queue,
+	.start_queue = sdma_v4_4_2_restore_queue,
 	.is_guilty = sdma_v4_4_2_ring_is_guilty,
 };
 
-- 
2.25.1

