Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D32A5C7EE30
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Jul 2025 18:45:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5B5B10E602;
	Tue,  1 Jul 2025 18:45:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="n5T4rquk";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2075.outbound.protection.outlook.com [40.107.92.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8477B10E601
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Jul 2025 18:45:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KSCObJairZ3MDv3olLdVV4lRZOXTspxMmNWQvorKtnnFf4jYQxD8GgK/jzslaBbO092ufz5ocURRVLfrBgjafnUicWhikyHmhd1COc+WrmInpHsZO08CgasCj4Vej1LeG2/zFGPct5uKx00hzDN1s7fLoSAsDaVS8FnB+8jUiKG3VV6Kiexp1k7otr+V6ewFKyYvRGwRHZtpiGKflzL6o45n9/hIBnBEYR5C9cJse4DugCQ0C0LptEX5DEtNVmesfhWVqsdYdCDKiP2xF+Wu2jKYTISi/G+yWq0vBTF2mhCcSE5KyKh48gs80lDJHVeRinfbQQQn5LkMe/cN/MlYDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pWQzEbubS0Ktshsefj0mnpMih5UIXaeeCNlZ4AMkQEo=;
 b=xHOHyMNNQUw/2ZzpQzb7zYfWlerf7XZkjKTtXzGk5Yid1BQQaP4oj5JFl6Z56qRQwK9tS8+d45CA/clQ+Ft8orSSClPKpc9Oz/xjYtN9k7iL1aOf/nhA8rrX+F5CgmTygE7QfSVUeOFNavSKj8olrbK8OIK3okWJtLHRXC/9wdhzW3U22JEsxKDXLUbfGRWVk7QPegqKhPcI5p8YSeUkhdO/arDgmbN/INYcENYFCY7l+oNJJ5Y1Vhfn2gaRMDlcF51XT1HtJdxgiP6hibasonrahdLr0MaQLs7f92RXBMGYlTQcjZc1e8hiHwjan2Jm9w4Ux+fMY1r/B6CboBogxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pWQzEbubS0Ktshsefj0mnpMih5UIXaeeCNlZ4AMkQEo=;
 b=n5T4rqukEkfHvWJUQKT7YBRMsPsoAjuQQIy4FYC/nqFM3VRMiYjgPGD2cam63MsTnrfyQ5EcWOliSFFMoJBwAPlW+TYUJVe9rbtINs4GQnUOvWp0Ij/tl95WxO+BWlc46AJISOx5wpRtzm9PA3g2IEBNpJUb4AFIB9S/YvlxKr0=
Received: from SJ0PR03CA0126.namprd03.prod.outlook.com (2603:10b6:a03:33c::11)
 by MW4PR12MB6780.namprd12.prod.outlook.com (2603:10b6:303:20e::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.29; Tue, 1 Jul
 2025 18:45:09 +0000
Received: from SJ1PEPF00002312.namprd03.prod.outlook.com
 (2603:10b6:a03:33c:cafe::3a) by SJ0PR03CA0126.outlook.office365.com
 (2603:10b6:a03:33c::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.19 via Frontend Transport; Tue,
 1 Jul 2025 18:45:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002312.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Tue, 1 Jul 2025 18:45:08 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 1 Jul
 2025 13:45:05 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 01/28] drm/amdgpu/sdma: consolidate engine reset handling
Date: Tue, 1 Jul 2025 14:44:24 -0400
Message-ID: <20250701184451.11868-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250701184451.11868-1-alexander.deucher@amd.com>
References: <20250701184451.11868-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002312:EE_|MW4PR12MB6780:EE_
X-MS-Office365-Filtering-Correlation-Id: 8182a1f9-7b4b-4fb1-082b-08ddb8cf6743
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?w2/cLXtyxyUZIkrDkXHLdSqrnBmMC9a8RwijiAiTsE4wBODtdEK2AeRdD4WI?=
 =?us-ascii?Q?nmdPWPb3BYsr7gk4bxsFE6wx/eg20TbuJ+4+FzZE1AOij/Zp8XzBNGkbYqwj?=
 =?us-ascii?Q?RxOkGpiT8rGxb8Bf/6M6mSWgH2Mlfqt3UwvEz9sAXgPFRifpbUVCCDZ+Occv?=
 =?us-ascii?Q?PFF9VFCR/6t4qe2hOioiPUMHO3Sd+YIxUyam4q/a+L4NP5PlQPzyYub/PpBZ?=
 =?us-ascii?Q?18cgSWHXL/bX4gNvafsRoQgmrKgQNoSXCCQ9sVzwI6z7feyujlyjn6v+rxyF?=
 =?us-ascii?Q?ejG5ARtuWAbpTa3TMUf+boyhdoVjjmFFKNCMwpNBSObQJnUj6A5EsNf68uaR?=
 =?us-ascii?Q?s/v7Mb0OSKg2TjBSylQRL1lvxyhZJrF5ve0tpWdGv81WcJDbGhcnknb0ijjw?=
 =?us-ascii?Q?yUcgoG5UTE7W4FT6O809jYnnt/kK+H5rCYSkmG+ci9y54PWcZ5IC4l6sOrJV?=
 =?us-ascii?Q?IeIax8V/tEW2EOS1WjSNHYpro8dCwcE1f/yAz/TQM9Cbr+DFfpUKnwUSjYtd?=
 =?us-ascii?Q?Uu/AoI3eHWHI8fEwBELCzpxoVQc58dFM3dPpGwI+aNV6YzSO4KYTZRvTzlzI?=
 =?us-ascii?Q?zG1aRfzuwrgIjwoH+NtyKgPYk16c+Wsz9WuYLRPqw2GNTfEpPxYo6QAd5C3A?=
 =?us-ascii?Q?TOmbKN+k7Vnq8ljqhE4HzrPLQOVsRct95k65b086wcZrFUFKiXnuLy962zSm?=
 =?us-ascii?Q?fMU0ke4w2TZjYUdvDmre6WmTw6lQ5xpTNbH+/Cq4mlcAr5RHm7uwP6A3JHnw?=
 =?us-ascii?Q?JzuWYTkvUY1CQsiDMgOzPBUPO6tyqV2HgJw5VQxv/qo0nr5R+wAZAqXeZNg7?=
 =?us-ascii?Q?lMDc4WPtaU+OWL7nVrqw+aSe3LcGanoLLeqdu+PfEAUTiErrr5wVVjwx9GRh?=
 =?us-ascii?Q?u32YJiDfMVi/6+XnkfWJyRIFYywWYYHSCacxlg8qVsUzYfVKb2TeXTeRJaeR?=
 =?us-ascii?Q?VKctTZMvZI1Sr+MiDduaW8NHW7CMXkXgb8KCipa/vZU8kwrhbwiolXw9n4x/?=
 =?us-ascii?Q?ykdXPWtJdvZKD5aq0w0Q/8GBlGxZorMrOnAIgy6o72NqOZKaHZgccjlPn1H9?=
 =?us-ascii?Q?5nTE6Hj5EIsNOfgM/TG0XGYFpCmbf0STByK6f1Rdzt/w9uCoZ2eGVtM9QyxR?=
 =?us-ascii?Q?+G9sZ+hL0pEZel3s5pmHWDCCkZfQSyiNeBE0WRhGieozjLCZYeLsYW5kR9F8?=
 =?us-ascii?Q?FZdzClbzETtX2kiZJCKDuUaTQxhbTHW4IUc50vBCmu/LAm5sTbC1vgZOdt8x?=
 =?us-ascii?Q?kX9WBnR25GWkCdRi4LcWiK8wMJ10ytCyew7chdY5yr5gY7nUjUvCRZ8y4Ke7?=
 =?us-ascii?Q?TZIoxAlJjSv5qEGz6I3J+8uxq7hJv1xE/SLUpAnYIdkOosZfuZBUy7vg0OnS?=
 =?us-ascii?Q?KxLV4aaqybr/SXUIVIMo75sp5zf19ojDJjWgGrjyR3JuBzNAFit/XmDJ84vX?=
 =?us-ascii?Q?bEKtkyCSjCcKp91sfkUtL8m4pNMeP+lYODnnC3rwG7qtAsS/sm7Tr+WQJEso?=
 =?us-ascii?Q?tV46ZrFY+XqCZz+cvOYbJggOcRFWQ2WhG+Pv?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 18:45:08.5321 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8182a1f9-7b4b-4fb1-082b-08ddb8cf6743
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002312.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6780
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

Move the force completion handling into the common
engine reset function.  No need to duplicate it for
every IP version.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c |  5 ++++-
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 17 +----------------
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c   |  6 ++----
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c   |  6 ++----
 4 files changed, 9 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
index 89a849640ab91..91e8f45fe886e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
@@ -573,9 +573,12 @@ int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id)
 	 * to be submitted to the queues after the reset is complete.
 	 */
 	if (!ret) {
+		amdgpu_fence_driver_force_completion(gfx_ring);
 		drm_sched_wqueue_start(&gfx_ring->sched);
-		if (adev->sdma.has_page_queue)
+		if (adev->sdma.has_page_queue) {
+			amdgpu_fence_driver_force_completion(page_ring);
 			drm_sched_wqueue_start(&page_ring->sched);
+		}
 	}
 	mutex_unlock(&sdma_instance->engine_reset_mutex);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index d3072bca43e3f..572d105420ec3 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -1714,7 +1714,7 @@ static int sdma_v4_4_2_stop_queue(struct amdgpu_ring *ring)
 static int sdma_v4_4_2_restore_queue(struct amdgpu_ring *ring)
 {
 	struct amdgpu_device *adev = ring->adev;
-	u32 inst_mask, tmp_mask;
+	u32 inst_mask;
 	int i, r;
 
 	inst_mask = 1 << ring->me;
@@ -1733,21 +1733,6 @@ static int sdma_v4_4_2_restore_queue(struct amdgpu_ring *ring)
 	}
 
 	r = sdma_v4_4_2_inst_start(adev, inst_mask, true);
-	if (r)
-		return r;
-
-	tmp_mask = inst_mask;
-	for_each_inst(i, tmp_mask) {
-		ring = &adev->sdma.instance[i].ring;
-
-		amdgpu_fence_driver_force_completion(ring);
-
-		if (adev->sdma.has_page_queue) {
-			struct amdgpu_ring *page = &adev->sdma.instance[i].page;
-
-			amdgpu_fence_driver_force_completion(page);
-		}
-	}
 
 	return r;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index 4d72b085b3dd7..ed1706da7deec 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -1618,10 +1618,8 @@ static int sdma_v5_0_restore_queue(struct amdgpu_ring *ring)
 
 	r = sdma_v5_0_gfx_resume_instance(adev, inst_id, true);
 	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
-	if (r)
-		return r;
-	amdgpu_fence_driver_force_completion(ring);
-	return 0;
+
+	return r;
 }
 
 static int sdma_v5_0_ring_preempt_ib(struct amdgpu_ring *ring)
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index 42a25150f83ac..b87a4b44fa939 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -1534,10 +1534,8 @@ static int sdma_v5_2_restore_queue(struct amdgpu_ring *ring)
 	r = sdma_v5_2_gfx_resume_instance(adev, inst_id, true);
 
 	amdgpu_gfx_rlc_exit_safe_mode(adev, 0);
-	if (r)
-		return r;
-	amdgpu_fence_driver_force_completion(ring);
-	return 0;
+
+	return r;
 }
 
 static int sdma_v5_2_ring_preempt_ib(struct amdgpu_ring *ring)
-- 
2.50.0

