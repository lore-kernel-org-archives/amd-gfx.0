Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22EE8C7EE2A
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Jun 2025 16:15:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABB1B10E41E;
	Mon, 23 Jun 2025 16:15:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="F1F6sOJo";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2040.outbound.protection.outlook.com [40.107.237.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61BB210E416
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Jun 2025 16:15:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hWRBky+VD8dZozorm9M2QA9QvIQxlVwlfKEMuTeDCTQgwGZZkD/oF0pJwF1Z6184vQ6Wa2LxgkaPb8XQxUzLNsPoCdBN88eMkmv/RvXzujY9VfVRk48nK2Q/MoywRkxAwA0ZvQoIHs+fIouH8rl/sfHQe8TmzJuQVezcPLF/5uHMPKfVMVPMolfbYwUQP3p01/npQRoYhpdPcbygqaAWFXH09lwM6qMhx0K66LmRzuvxHLeQdy3fUtQl50M3UlFcrfDHf5lqylrAyjeVG0U0oZ8uKmjbBgKS3GIKml0Evd5RfMReLJQH6lPKguqNDTXDuRn0X/J7ParYN96PdrtHBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9c9O7kt3vFUOJegfNJ5X7lxe+ElniCaM/YJWOJPZg50=;
 b=m5F6HmoohYASQJ1anzZ4y1ol2jFdccD+5hZWQeRF3hfMIAjV0TGRFL1b352VoR/st6HcIeW6Ba+sdTfcfVaZWeIvDDQPn4qC4apR+5DgUQhOdbL5lJaY6QKYwhxbxSrj4SuK2+bNELmOJ5ad3Q8+KLOcq4W4BYsUr+yoNy8StRjNX016kos3MHP7ZkVLmzPWOprIrkQm96d3RGrJY5TLWvaZhb6ng7BngAHf9eW/53I4jICd1X56ScvCgVfS/8X9W7hNNnCiZu5QPbjLsH+Y90Es9W9bg9RcMc9Mnvm744el8Y7gELcVzWVR3mQSOm9WltlPd+Uk6HA7CcL278yvVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9c9O7kt3vFUOJegfNJ5X7lxe+ElniCaM/YJWOJPZg50=;
 b=F1F6sOJooUVIBGQUENwOcRuD1PrffSbar35rUySZEpBBdMu9pGE4jMKeMn5VQsxH//jOeF82FohUwM8+Lrmkrd7AYDSBte3mTnSmuGmR1da6maoVCRoVBNK3Ghu2HIQaNC5zArQTjZRYq1g3jEagyoB4ETZjP0TLDBSuk8w7e7o=
Received: from BL1PR13CA0232.namprd13.prod.outlook.com (2603:10b6:208:2bf::27)
 by IA1PR12MB6387.namprd12.prod.outlook.com (2603:10b6:208:389::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.25; Mon, 23 Jun
 2025 16:15:05 +0000
Received: from BN3PEPF0000B073.namprd04.prod.outlook.com
 (2603:10b6:208:2bf:cafe::6e) by BL1PR13CA0232.outlook.office365.com
 (2603:10b6:208:2bf::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.15 via Frontend Transport; Mon,
 23 Jun 2025 16:15:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B073.mail.protection.outlook.com (10.167.243.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Mon, 23 Jun 2025 16:15:04 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 23 Jun
 2025 11:15:01 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 14/31] drm/amdgpu/sdma6: re-emit unprocessed state on ring
 reset
Date: Mon, 23 Jun 2025 12:14:20 -0400
Message-ID: <20250623161438.124020-15-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250623161438.124020-1-alexander.deucher@amd.com>
References: <20250623161438.124020-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B073:EE_|IA1PR12MB6387:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bc19a7a-3f8a-4239-aa78-08ddb2711d39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Ah4d/7uGSHvc7iIEzncdKvEn5N5/DIEnNKK/s7QbCiGVOawsNzQiNmfYFNGn?=
 =?us-ascii?Q?jkRVBFAjbHI9wGiYyqTckl8lb2TOL8IeRzo/Ok5Edf3pRqGrLR5u6S/zDU+k?=
 =?us-ascii?Q?c8AB9mrzDTDH0TqeAc63ZhI6irFfLd6JleHyL1BppgCyf47QAVrfz3I0XMZh?=
 =?us-ascii?Q?YUUPhfiF5BRTRTSO68hc81NFpJuko8DH399qWe44SXXZDmVBaYtQHCruUBke?=
 =?us-ascii?Q?PKDNiFqLAUY3zwWPiWjbqCFZtrjiRg5fVkWBpymCTCTcx+ZyIUlMY+LRXGR2?=
 =?us-ascii?Q?LHksYVw1P0LsIbiCtc/ZZ4LkI0CmwRQJ9qvVPWAPF8AvSUpaQBPLJl6Qz082?=
 =?us-ascii?Q?dSwTJ+b+n9IROo1In/84o46Y35OYIfXIe9mqc9CADQtSxTeZBzpjaYUbc9e6?=
 =?us-ascii?Q?ROgdEWVMqki9+vyrBqzVuUJ5PRihgJjrmyGVo7+tNuBMaa8WLtll5NO4LriZ?=
 =?us-ascii?Q?lKl89Jd0GaJpvWdbF7mhZ86UqaHU1HrqQm7O7zOpOdI4sNfItevZYJtRoS9H?=
 =?us-ascii?Q?yaMP9cWGKqFtG8gzfcNj+x1aI0vlfkjN293hh4vgesJYNoIY6tY2HUcUNdcA?=
 =?us-ascii?Q?CL2KIf4MW2RFoFbDnsRhvivoZLKz5R/Oyc4ruWKfAtjdXMVMK4UKr0p1E+Qc?=
 =?us-ascii?Q?H945yUFj7+pMWajM5whec+8vHxS/y1XoKQ8QGJll3dPn3NN+L4moIdwHmjrR?=
 =?us-ascii?Q?oN9Yv9GBIEe0nxXhPNcEIZ6V6Zlhmzw/D16qfBMnJRZe/yTJBK3pjq48QXLg?=
 =?us-ascii?Q?mJw8a+q39Yw2iROWOLiPIzLXBjj7LBIzoLLyeFtQouxeHMgFSLTX/ZdnbKQ3?=
 =?us-ascii?Q?sI64TkOTn/RB1zquM8oXBZ8xl6e0ZcmX+6rBxfi/x8HuzJorztpUq28lsAxy?=
 =?us-ascii?Q?wYXKnFT86zt+DDoB1ybPz/5UVB5lzw0iC9OIzlBP9aobWoPlk/ztS6AwWY44?=
 =?us-ascii?Q?t46ZY70yPrNzIf94AYyLOy3a38B8sjX4kgwiddWn2quwgtaYeqmUNWLxk3fj?=
 =?us-ascii?Q?758bxGhulSNLGWWPuzB14SHYeopPeIad/sd8r9PnoDuSt5xllysrSWsMkkXE?=
 =?us-ascii?Q?xOujtuYIJd3YI8v6un8gKawkv8REtjCa94pSYvVWqfDoGhBVygDJXcvafcTF?=
 =?us-ascii?Q?h79Cb4pX9WLgmFjQzkVRkmP2aianrgNAD2QDQfFEMZ5i60kR4+YXkX7WfuTo?=
 =?us-ascii?Q?3fvGJ8YKtiVQxDwoXFc9E3JrDiq2kB+i88UfznmHYOSTGWSiuFORE3f71Uqo?=
 =?us-ascii?Q?vQWwgPwf3j6kgA+Gkxq2E1BlAoj7aJv5BT9rFUbzUv9Dn95mtokQgCeoFdyp?=
 =?us-ascii?Q?8OSa1FppByHNibpxtV0ALgoDD8wodFw81m+XkWcITOW0GUNA5yiKhaAPB5Kp?=
 =?us-ascii?Q?QDWgE82TM1j1xr2SpHR0s9NUyQiFx9yIimuVDp7EZjqU50BZC08GYNNuyGBs?=
 =?us-ascii?Q?OzOXET7vQFm7m0aoeK21k/X8gzfHQaVVYz5m4eNQrmL0zub4Du0Xk/qYdJxf?=
 =?us-ascii?Q?9T7srOPjzghuB7VGQNsEZPZZ+fzxLgw7A+je?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 16:15:04.7428 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bc19a7a-3f8a-4239-aa78-08ddb2711d39
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B073.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6387
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
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index ffb90b42a3e34..7ff9f14691e57 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -1537,11 +1537,23 @@ static int sdma_v6_0_ring_preempt_ib(struct amdgpu_ring *ring)
 	return r;
 }
 
+static bool sdma_v6_0_is_queue_selected(struct amdgpu_device *adev,
+					u32 instance_id)
+{
+	/* we always use queue0 for KGD */
+	u32 context_status = RREG32(sdma_v6_0_get_reg_offset(adev, instance_id,
+							     regSDMA0_QUEUE0_CONTEXT_STATUS));
+
+	/* Check if the SELECTED bit is set */
+	return (context_status & SDMA0_QUEUE0_CONTEXT_STATUS__SELECTED_MASK) != 0;
+}
+
 static int sdma_v6_0_reset_queue(struct amdgpu_ring *ring,
 				 unsigned int vmid,
 				 struct amdgpu_fence *timedout_fence)
 {
 	struct amdgpu_device *adev = ring->adev;
+	bool is_guilty;
 	int i, r;
 
 	if (amdgpu_sriov_vf(adev))
@@ -1557,7 +1569,8 @@ static int sdma_v6_0_reset_queue(struct amdgpu_ring *ring,
 		return -EINVAL;
 	}
 
-	drm_sched_wqueue_stop(&ring->sched);
+	is_guilty = sdma_v6_0_is_queue_selected(adev, i);
+	amdgpu_ring_reset_helper_begin(ring, is_guilty ? timedout_fence : NULL);
 
 	r = amdgpu_mes_reset_legacy_queue(adev, ring, vmid, true);
 	if (r)
@@ -1566,9 +1579,8 @@ static int sdma_v6_0_reset_queue(struct amdgpu_ring *ring,
 	r = sdma_v6_0_gfx_resume_instance(adev, i, true);
 	if (r)
 		return r;
-	amdgpu_fence_driver_force_completion(ring);
-	drm_sched_wqueue_start(&ring->sched);
-	return 0;
+
+	return amdgpu_ring_reset_helper_end(ring, is_guilty ? timedout_fence : NULL);
 }
 
 static int sdma_v6_0_set_trap_irq_state(struct amdgpu_device *adev,
-- 
2.49.0

