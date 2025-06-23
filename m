Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4096C7115B
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Jun 2025 16:15:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D5BA10E417;
	Mon, 23 Jun 2025 16:15:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OLhdqMyk";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2052.outbound.protection.outlook.com [40.107.95.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43A2B10E417
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Jun 2025 16:15:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=APBWhxkf2CZn2I77v4BWiOUoPQjj6PZgZHuhp1rleixsnJk275Ko/CHoGEn1sFfiCoGi8tfck3qEBtuUorDSo6sUYefFF+cWHp8Rnbrp8J/CSPQGf+iRhlbbnXha1rXXcCA3I6dnQt+oBvC56F9+QzW0Wg76zQTnM9oDC/8ZC2KDcqHhjFf2HVDba4kUcP0civlx0Jl1/i1LSZ8DhcG8GEzRBxb3w8vNv+UcKOYqXni4vw8kQKUYchbO87X4K/j0mHH5ms9ny9/pHzqJe4z/Uatt/P0SBwXkhUNty5DdhpGdckem/yt5M+/dC/0Ej2ux7Tx+eDM4GVxk/4RNiyB4MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pmG3qc/pCLgkNaYTgb75UBxHkC0uh649o+/xVOQKaC4=;
 b=EQY+lmiB1sjMJsDJ3udJjdU86RoTaEKvfq1z/dLadf3zLxFmAXi118YqSuLs5g2bwMTuHbqLPF4WmVFjJ4AQ2wbyFEPpx4HQD27Y5GP4T+RUyadScnfTepSTYT3bXnbzYtjqizGLN7QuxnRJP78fNl+QZzgHfHzBp91tDE2bgh2Rq2iZM9vl04v2IG2DR15qcCM9oqANA/vwwInkbhqfNxXbqBHaLsu5Dnh59Epsck0z3hzXSxz/guFUw0+l+Mo/tbltghcrtjZJqfHK1SEoMBG82YYrCr5ZFejonwXU7XzesDZqxrdtaESjP9MUYOlxsChBml2V10wH6G8DtlnUtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pmG3qc/pCLgkNaYTgb75UBxHkC0uh649o+/xVOQKaC4=;
 b=OLhdqMyk45t7SZnKZxxr2lktdvbBajtwB8PG8JDBZyrT2lkL0UK6PB0p6RlVpMsbGtMJXPjFDyJehmsx6ZYKXSQlDAqGPHsZFsYv81OhERi6PddhP2HlHb/cbdAbEGmD1GMfpEpXCEoxGBSUq9RhyO+JgAieyTUdDQmc6+VEZEc=
Received: from BN9PR03CA0952.namprd03.prod.outlook.com (2603:10b6:408:108::27)
 by MW4PR12MB6951.namprd12.prod.outlook.com (2603:10b6:303:209::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.25; Mon, 23 Jun
 2025 16:15:07 +0000
Received: from BN3PEPF0000B078.namprd04.prod.outlook.com
 (2603:10b6:408:108:cafe::4a) by BN9PR03CA0952.outlook.office365.com
 (2603:10b6:408:108::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.35 via Frontend Transport; Mon,
 23 Jun 2025 16:15:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B078.mail.protection.outlook.com (10.167.243.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Mon, 23 Jun 2025 16:15:07 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 23 Jun
 2025 11:15:02 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 15/31] drm/amdgpu/sdma7: re-emit unprocessed state on ring
 reset
Date: Mon, 23 Jun 2025 12:14:21 -0400
Message-ID: <20250623161438.124020-16-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B078:EE_|MW4PR12MB6951:EE_
X-MS-Office365-Filtering-Correlation-Id: b0bc7acb-2fd4-4221-9686-08ddb2711ee6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/zF/6kZyAkgPI9+zKe57C7ZN4Rhc0Stm56plUXsvjkJs+xSPNbuwD0YiAJPi?=
 =?us-ascii?Q?tSYOPMMNE465KnehXV0TonghNgeNheGWdBcT+FEqchjZwGUX0gQ+j8zyrbft?=
 =?us-ascii?Q?iWHFgulH3+o+smuLsycyLb+XpmguTtbgsi1r6HwbkwhGREZ2ODbcF94UDTSr?=
 =?us-ascii?Q?ymXkE2E3w68dHE1AzFDa5qgmPeX9O0F8Tu1zjpMzNjvYumgCyAG/twpxwAg3?=
 =?us-ascii?Q?ineQGdSsA8FKFik6OLppyX0bQYXReQnHPNfWITZpvCORPmNQZbqPxwG92/am?=
 =?us-ascii?Q?fNlAWUxxecNd3CHpTEPEyqmhzASquCkXmLX+Yi9WvvWPgM2bgCALpllzAKNa?=
 =?us-ascii?Q?00jnHjh7jRNj/Rp2pl3a1UtFT5T3ZthURIAiOf+1u1qvgWFqJXHMulHSlQ9z?=
 =?us-ascii?Q?LgGHY8JbpsaGtxPZba/QPHKib8sN9y/5bgurz9iGEB6loBDy17vAEBFYVTLD?=
 =?us-ascii?Q?fvYgK8JlPl1iIGczigzIdzDw8Olv81iYfNKIBWNni6imi1B54bHVzfiFfzwh?=
 =?us-ascii?Q?EnyceTuv+/hIWHGKy9xRgMv7Q5H+slkY3UiKeTTE+hqFPtAzPlv1H3S2L3IE?=
 =?us-ascii?Q?NwxHF503kC2pviDvsZZM9f7v4qoroKVkAJ0SWAn3qFcp4GaTvzv5twEWTGBs?=
 =?us-ascii?Q?zqLq0j/5xmgy85dTorQ5qDxOIe9XcKt3WKfYT80iWNuz7L3kMjuRZ66r7N9B?=
 =?us-ascii?Q?W6fENXy/aOw354/7mLJMgtdf1z3ZiT/f8y9KhJk05UicXnLHV/e2lUkM6WpQ?=
 =?us-ascii?Q?yi4QSSaUsh9W3c71WqRLTI/gL8rj9feZoI1AztL+YUEt9NNhkTzXO3qJUPOY?=
 =?us-ascii?Q?G2iR4gjrjhJBjE2bpPt1Vk0N75QCXoVug5DtAMVb+UuHOoM/hy8XEwIjRFN/?=
 =?us-ascii?Q?uz+2iVv83hW1Raw0IshY2CTiJfj1gvicPw7smS5Dmv8WEhyblxIgUqQJAfCz?=
 =?us-ascii?Q?vKYiJUR7A/DxCWfHIGRGdvZtPeCXB52XTjOuKU5wMyE9/LvLdcclpi8kDCMy?=
 =?us-ascii?Q?udkZHpeiY1OMpYDf9Kkw9/X29W11nfct/Iu58IcB8yJ81u/e03k/XjnWWVHJ?=
 =?us-ascii?Q?SuFMrzO1C2QaTwSDt8P/dj5zQy68FmhSCXzNrOdrDk9LpHXgg4ujcnO6in2j?=
 =?us-ascii?Q?QE3NhobAPTaTL+FYLjZYrCFYhTxHZRSw6FkUfq5zex1TflaLTDN1KsvoGGly?=
 =?us-ascii?Q?Mjw8xQaLweWU8E35bikzBTAv8ixG1l6uKxn2fV3P4I+qBzGxS84wosfLI19z?=
 =?us-ascii?Q?f8j0gvuuYOKO5maDRHHXW7vADiaZO7JfbSlmsPskP+a+x8hOIuGrorcbE05a?=
 =?us-ascii?Q?Rr37pXT0Xm4w/3G9wIGpcrx/ULVRubA5oYCXcyWSVmENHOF3EcUz7JKB1rrH?=
 =?us-ascii?Q?4LIuspv35qHiTN4MAGT447XLisdR8vJSDMtsDinOZPGLf6AgaikdiP9//bf5?=
 =?us-ascii?Q?zyA/qIss+6XVKR9xcZg1N8Voi4wC5au0YWKQIL8req7cPgf/Ve61OQyoDsXB?=
 =?us-ascii?Q?sjSclRS9JxOALHjtEUSkHs9Gj2tY+KyJVDFS?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 16:15:07.5460 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0bc7acb-2fd4-4221-9686-08ddb2711ee6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B078.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6951
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
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
index d51833f942427..db687121077e6 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
@@ -802,11 +802,23 @@ static bool sdma_v7_0_check_soft_reset(struct amdgpu_ip_block *ip_block)
 	return false;
 }
 
+static bool sdma_v7_0_is_queue_selected(struct amdgpu_device *adev,
+					uint32_t instance_id)
+{
+	/* we always use queue0 for KGD */
+	u32 context_status = RREG32(sdma_v7_0_get_reg_offset(adev, instance_id,
+							     regSDMA0_QUEUE0_CONTEXT_STATUS));
+
+	/* Check if the SELECTED bit is set */
+	return (context_status & SDMA0_QUEUE0_CONTEXT_STATUS__SELECTED_MASK) != 0;
+}
+
 static int sdma_v7_0_reset_queue(struct amdgpu_ring *ring,
 				 unsigned int vmid,
 				 struct amdgpu_fence *timedout_fence)
 {
 	struct amdgpu_device *adev = ring->adev;
+	bool is_guilty;
 	int i, r;
 
 	if (amdgpu_sriov_vf(adev))
@@ -822,7 +834,8 @@ static int sdma_v7_0_reset_queue(struct amdgpu_ring *ring,
 		return -EINVAL;
 	}
 
-	drm_sched_wqueue_stop(&ring->sched);
+	is_guilty = sdma_v7_0_is_queue_selected(adev, i);
+	amdgpu_ring_reset_helper_begin(ring, is_guilty ? timedout_fence : NULL);
 
 	r = amdgpu_mes_reset_legacy_queue(adev, ring, vmid, true);
 	if (r)
@@ -831,9 +844,8 @@ static int sdma_v7_0_reset_queue(struct amdgpu_ring *ring,
 	r = sdma_v7_0_gfx_resume_instance(adev, i, true);
 	if (r)
 		return r;
-	amdgpu_fence_driver_force_completion(ring);
-	drm_sched_wqueue_start(&ring->sched);
-	return 0;
+
+	return amdgpu_ring_reset_helper_end(ring, is_guilty ? timedout_fence : NULL);
 }
 
 /**
-- 
2.49.0

