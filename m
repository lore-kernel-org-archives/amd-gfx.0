Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 515DFCCF2DA
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Oct 2026 06:49:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7AE910E7D4;
	Mon, 19 Oct 2026 06:49:14 +0000 (UTC)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010052.outbound.protection.outlook.com
 [40.93.198.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A93E110E79F
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Oct 2026 06:49:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xsU2ZpDIKsXgYLuIQCCDRDG9VJX2A79Xu0/8IMbCfGvhmSUZ8aTobAbyNFsfPSlFl9ICilQgST85JrmSphYatQyYlDH/xQg5NKqgvuHEebjMBTUEu+pvX3pye57ikb0yYt72rGN3BjAoB5dTsLAqwMG/D8oK9KF/JtpubR7zt28cGo4TELhzrbciugX0I9GnHnBVyYC5hxpfFfHaz8O2A0n6WFJ2BqMeqW7Ujc4s1Q3TTaiMlM/ABinbHU5BKSThiLXbh7gk1gEgvTFHXXv3qptmDixwgE9AnQtq0v1uCFbnnCB+hIosxgr/6BMncON6XbDHCDaLqTJYN8UVdiWOuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z1OQ3GuUD3Jf4IoTwvwAaVTPVWFjOA0Q7R+1X74i3xg=;
 b=KVh4NP9V+el/zwdQtmkMA1NYhkAOOEJ+AWHgmNiIMbM7CYICtMx4hXHA7Zp+3gB4rqmr24RXofTvIzcYd8odr/9lvf9yrdZR/jBDuwvgKsRGBXnOKhKTEv0vzF0l2jTpPgsUVAXdxB7FFip91YNBKzISxhOPlk6gjqAeglB04kde+qfNg47MujUVqRaGwo/eNItPTXktEvw/TW/+dGx/zGYFeodwkDIE+HYiNHFUjXmMNiCCABYQNpKvGi7LVNqMd69kUDjsIrpJVqdXv01ZPG8TeE0BrG8PSb+72p22owvgyvS4/7hIkySpLqxrZx0wO60zS+xVdtX20zo3eq+luw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z1OQ3GuUD3Jf4IoTwvwAaVTPVWFjOA0Q7R+1X74i3xg=;
 b=oCI5XV0dNJK1eelcOXkSrd/FWyFVDgiTbi1f1dDguXXm+WSZl53bfzqRhJ+FtzLXK88sQToTwe6HT5QhyxW7h17AXmH2bFG+Z/Uwsl22IgACrIoniiynapjTssXcf0k5P+j/jRH0sBnnVqheEgCdIac9lRPjhOzuLs40YfgIE0E=
Received: from SJ2PR07CA0017.namprd07.prod.outlook.com (2603:10b6:a03:505::17)
 by PH7PR12MB7913.namprd12.prod.outlook.com (2603:10b6:510:27b::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.17; Mon, 19 Oct
 2026 06:49:03 +0000
Received: from EA8PEPF00000009.namprd05.prod.outlook.com
 (2603:10b6:a03:505:cafe::14) by SJ2PR07CA0017.outlook.office365.com
 (2603:10b6:a03:505::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Mon, 19
 Oct 2026 06:49:03 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 EA8PEPF00000009.mail.protection.outlook.com (10.167.249.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Mon, 19 Oct 2026 06:49:03 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 19 Oct
 2026 01:48:52 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Lijo.Lazar@amd.com>, <Vitaly.Prosyak@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH 05/10] drm/amdgpu: don't allocate or lock BOs in the UVD/VCE
 direct IB tests
Date: Mon, 19 Oct 2026 14:48:33 +0800
Message-ID: <20261019064838.2577746-5-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261019064838.2577746-1-Prike.Liang@amd.com>
References: <20261019064838.2577746-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: EA8PEPF00000009:EE_|PH7PR12MB7913:EE_
X-MS-Office365-Filtering-Correlation-Id: ddca5b9d-cdbb-4885-7b98-08df2dad102c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|23010399003|82310400026|261009221227099003|56012099006|11063799006|261009223027099003|261009221727099003|261009220027099003|261009223327099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: I5oka4V34mANgO0ZT59Ns+XyxuvAW2F7zfBHOIZsL6u1xczyYWA6QHHD8aqhihZ2kl55tlQ/cEsn331fv3fnORM8bVLM0gC7jxYJkqVIiXbC6d1tm35zY9X2L7bin6rZ+5B9XOjDFXVs/ypOL+z8Fz0j8I5HCyojHvrzBWCItzmak8hKGXesp+0lpbBjXyy+TG+xYKygNU6ptgMju65l3rTmkskTrSh7JbmCZ8eqyxBNC/ixZpbotX9H7dEZ43HjQvo9ww4B3kJUcGgV0/f8cIHFqdIZqfC8YvEu9ycljrkD/rSzoOu7BurTd9FhxV2+5SCcachs8QG9HIX6BdkcDnP4nQGLwfX67McjfWXyC0I9QpLgEDBU/bQ8C4fRshRSdMN9zpJ3+zcApf98y14jbnsf/IHS+PtT+PlpLkjOeLw6f0h0IOqPZDmlesFwI/qKQs3g6L2/0hqwwNd8EH33SJfiTlQPuIkqucvzZ0k7jWq+movjALOjwUZqiRYYDsbcV0wUwYujOLrRVw8QkM1z0lGkMfcqEf2Ez+LiWHBckOvvq/Jqmlbjz0USS+fcDuAY1+OrhXnmOXFZxZwBduBcTNqkEwToAX2QwUqFXZ3ffNl9p04RSCQa5NQOt0wP4QkXd4cRX+zvWs9Ilhml7xZgTbZNCN0ZiqXIJy4K0+cS0knLDPPuwT7L4M+VrgdMCNaDW+vthuuMzxoyTGCsbiM7dw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(23010399003)(82310400026)(261009221227099003)(56012099006)(11063799006)(261009223027099003)(261009221727099003)(261009220027099003)(261009223327099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0OjFSgJlnGTDhx/yYFdRmb5Faykq7vBvnMi+9mOzmrW55XT08JvPiK946XMsGPmiv/g+bdZGWXGL6rMBGx0+A74r/dNkakwjvJtkwVRSicgkZoW3RZ/KVSpvCAzK5G4VGCJrT/EnVw94FmANsUfEFiaSAw2L2filsPQ4x9uJJSlIt8oT2ze0rYwoj6eqdjRVyx4MWLKK1rolEdw/emB0ayVlUKuq25g9xxxKwiaHPmvzRFFcxRve5ssP6xEu3apr2NwKCKF8O9aWTqekUHSaP5zksmYgU6MQuQM9RAuZdkJENQdkrXhAH2uF8XBX/FVXQbPakH3eFzRLrP7yWMkwXPIGTFUYUX8wWb8N30cVEs8xDxYrmIwMY1/txEh59cD/qKeYlpJQhDSWBNJh3LQBpFzcM3bO4zIASzQMepI9sGYoXyTMKG7enrmn3jiA0eKe
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 06:49:03.3037 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ddca5b9d-cdbb-4885-7b98-08df2dad102c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: EA8PEPF00000009.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7913
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

The IB tests run inside GPU recovery, which must not allocate memory with
reclaim, take BO reservation locks or depend on eviction. The direct IB
pool and the job allocation use GFP_ATOMIC for this reason.

UVD and VCE still pass their scheduler entity for direct submissions, so
drm_sched_job_init() allocates a scheduler fence with GFP_KERNEL that the
direct submission never uses. UVD additionally reserves the message BO and
adds the fence to it, which takes the reservation lock, can allocate a
fence slot with GFP_KERNEL and falls back to a blocking dma_fence_wait().

Only pass the entity for scheduled submissions. The direct message BO is
only used by the IB test, which waits for each fence itself, so only fence
the BO for scheduled submissions.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c | 11 ++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c |  5 +++--
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
index ecd7caa95d4b..bc15fed6fb9b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
@@ -1114,7 +1114,8 @@ static int amdgpu_uvd_send_msg(struct amdgpu_ring *ring, struct amdgpu_bo *bo,
 	uint64_t addr;
 	int i, r;
 
-	r = amdgpu_job_alloc_with_ib(ring->adev, &adev->uvd.entity,
+	r = amdgpu_job_alloc_with_ib(ring->adev,
+				     direct ? NULL : &adev->uvd.entity,
 				     AMDGPU_FENCE_OWNER_UNDEFINED,
 				     64, direct ? AMDGPU_IB_POOL_DIRECT :
 				     AMDGPU_IB_POOL_DELAYED,
@@ -1159,11 +1160,11 @@ static int amdgpu_uvd_send_msg(struct amdgpu_ring *ring, struct amdgpu_bo *bo,
 			goto err_free;
 
 		f = amdgpu_job_submit(job);
-	}
 
-	amdgpu_bo_reserve(bo, true);
-	amdgpu_bo_fence(bo, f, false);
-	amdgpu_bo_unreserve(bo);
+		amdgpu_bo_reserve(bo, true);
+		amdgpu_bo_fence(bo, f, false);
+		amdgpu_bo_unreserve(bo);
+	}
 
 	if (fence)
 		*fence = dma_fence_get(f);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
index 1f7a98cdce5a..4c049e591f7e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
@@ -470,7 +470,7 @@ static int amdgpu_vce_get_create_msg(struct amdgpu_ring *ring, uint32_t handle,
 	uint64_t addr;
 	int i, r;
 
-	r = amdgpu_job_alloc_with_ib(ring->adev, &ring->adev->vce.entity,
+	r = amdgpu_job_alloc_with_ib(ring->adev, NULL,
 				     AMDGPU_FENCE_OWNER_UNDEFINED,
 				     ib_size_dw * 4, AMDGPU_IB_POOL_DIRECT,
 				     AMDGPU_KERNEL_JOB_ID_VCN_RING_TEST,
@@ -561,7 +561,8 @@ static int amdgpu_vce_get_destroy_msg(struct amdgpu_ring *ring, uint32_t handle,
 	struct dma_fence *f = NULL;
 	int i, r;
 
-	r = amdgpu_job_alloc_with_ib(ring->adev, &ring->adev->vce.entity,
+	r = amdgpu_job_alloc_with_ib(ring->adev,
+				     direct ? NULL : &ring->adev->vce.entity,
 				     AMDGPU_FENCE_OWNER_UNDEFINED,
 				     ib_size_dw * 4,
 				     direct ? AMDGPU_IB_POOL_DIRECT :
-- 
2.34.1

