Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95CF4C5AD49
	for <amd-gfx@archiver.kernel.org>; Thu, 29 May 2025 13:08:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 320C510E069;
	Thu, 29 May 2025 13:08:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Yk1jFR+p";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2066.outbound.protection.outlook.com [40.107.237.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC0C710E069
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 May 2025 13:07:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AthqMfbZbeRX2EKsU4H+cR1i2xerf2z/KnF4vwrQxuQ/NRAFwuUPQxVD2LbdS3DJod7oG+vxNhmBOJlLDezKBi/P71M3uMlQUYd3HAC6gNottaHHadW69ajc3li97Pg2x60lJ0az9gmtXwyxC4b7LJ4v6anFmefgOg4yWwPA1QP+GpB51SvmUa7FWboeY+aFP1TuqASRliH0MtITN2heCrVdJOyVy2UPznve0dNyfg9IB2NX/cxA2xEmFpSE079zy2LQEqLlSDMwCTvKW8BYhjL6w3S5OT9IDFSNJcmyr8sW36KIq0bT0pnc6EKvybCzZBkLkU7+6vOKD28uca9bVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V/9JnASuOG2LeVFUkVItySYKXB//G9sYIWvVcQ0oLiU=;
 b=aKYlh3A+BXBisnkHTldEjoL3skmhtvwFS6aSkas9if+4reY3p+T2O5IZLr44BqT6697Lom87zqNUJAr8Un5XMHEv6v2875MBqdWicIqAvjlKOmzMJHdjXygY+OjQVrgFs2660wPRxWDRDIoxa4V7p7ZyNo1NngczeQqA4RsKjTXZ2my5rG4VYSAE4MfLrTC5fMGAIcjNcF//2i3jAw7sZlr3qcwM04H1FnnIQ4bg2A8UTVgEv+lKNC1F1713KrqJiD47ENnWHyejJ6wb0Kfbx1wheJiEMV5b0+ZepmimF0BVGbeX7EZqP0vGGX0iwBQGknWtynRfINiX6hC7TI+pHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V/9JnASuOG2LeVFUkVItySYKXB//G9sYIWvVcQ0oLiU=;
 b=Yk1jFR+pBI8hck+sAqaTSZxg3AW9EtM5T5gc6lN0p/q8Zi3NW/UJVMiv/ov+d5yazxC6KGlsitWh/GCmVMhrTNkQBQ5lLSBLdjIVNrGGnsCCvDkDl2qQow4afHbedSCtTX7PQ70OV79FtpWpeuowgqGfKOqWe3K5ZMgp7iHNs+Q=
Received: from MW4PR04CA0264.namprd04.prod.outlook.com (2603:10b6:303:88::29)
 by DS7PR12MB9474.namprd12.prod.outlook.com (2603:10b6:8:252::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.29; Thu, 29 May
 2025 13:07:56 +0000
Received: from MWH0EPF000989EC.namprd02.prod.outlook.com
 (2603:10b6:303:88:cafe::37) by MW4PR04CA0264.outlook.office365.com
 (2603:10b6:303:88::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.31 via Frontend Transport; Thu,
 29 May 2025 13:07:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EC.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Thu, 29 May 2025 13:07:55 +0000
Received: from jenkins-mali-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 29 May
 2025 08:07:53 -0500
From: Li Ma <li.ma@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Arunpravin.PaneerSelvam@amd.com>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Perry.Yuan@amd.com>, Li Ma <li.ma@amd.com>
Subject: [PATCH] drm/amdgpu: Fix potential dma_fence leak in
 amdgpu_ttm_clear_buffer
Date: Thu, 29 May 2025 21:07:38 +0800
Message-ID: <20250529130738.2352725-1-li.ma@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EC:EE_|DS7PR12MB9474:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c90a81c-ec51-4955-6834-08dd9eb1d40c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?eiDyrEm/mhLX7lKSfYdE0EmC9tQqGSiJOLJ7NrDHnYtBxuxbYQkjyRFMqMGq?=
 =?us-ascii?Q?ANShZaGymcEYGY2+G/wtZcFk4p3nM5ezLYGygQ+lX3qXZURSIKPvz43IG/jU?=
 =?us-ascii?Q?GlqGaOMSk9ES6lwm8CCGH4igUjEJ1P7NsBbTbDl4B6LpAAxj/KqhI1gEhyw0?=
 =?us-ascii?Q?xma2dyCQNd13bgdMUoQBKWB8hukx3i49SdplLSOUHOLpVvufX5H++DdjAHvh?=
 =?us-ascii?Q?M88iTBZlmkRIbe1Fv171LLZEh16D1KzcK7Zq+VH+WjHCYa25qWnczFFR3Oui?=
 =?us-ascii?Q?8NK0osOrF9qNOl7oNwyPpDXphCDpPrJ/g9UZmomk3+R8X9dstiJks6vHOZB3?=
 =?us-ascii?Q?i/9x75OI5oG31k2rDMoPuByB8Gh9k0Nhle7khnKFTJsF5vrjDvtb9LMVxXda?=
 =?us-ascii?Q?ThNlJqU0YeSb6I/TFMtl9IVy7OlDX7LUBNHj4YptG+dzr2pP+18RhUW2GoJr?=
 =?us-ascii?Q?H3eNAdVXn2UcOEI3NcJgKW0TS/AgCNeLCn3jvYeGRvOGoUhm6aCJtH5gziPv?=
 =?us-ascii?Q?Q8c6gfawCmJQ0pNkRUXhO5nb5U9zYHk26YWVbA5owxo0vytS0uN98NEU6Bxc?=
 =?us-ascii?Q?banovML68UrkTzGf18uSljvIRdaFTwdUKR02NeC3oouuPrJF9giquHRAcbTq?=
 =?us-ascii?Q?QbQqtiGd/jYclHV9VCtnn59NF9VC+wlbc4MA0+V14HN3fWSmyHDsIRWDHsjk?=
 =?us-ascii?Q?s1WzbOBLdPTxYhBIeDUWdvbFF/jcFpdHDphZYm4TWW1e7k/nt6dDJtkS/qtI?=
 =?us-ascii?Q?UKfsxagi2PjK3b6ts5dUJzWsLtLcZUuFFdzuDBAUrTCOmwGsn0JFxsj0+3qB?=
 =?us-ascii?Q?MDxVCz6uyeNen1OaW/vB9Fj7jq1UAOvp63/hG9aCL3OWuYdpTTurde/kJeI4?=
 =?us-ascii?Q?IU1jHxhtlc+fIIm4ho0xDaBMF1biZ2TZM/trRjZV+FmaBcivvcu9UaofK9YN?=
 =?us-ascii?Q?l5SIx1LfzLh5Jb+OZiAUwme3ZhNTzxw3G6HIC3Eat9r0HHx9im16mypl5sog?=
 =?us-ascii?Q?zKNfcVn/B80cUMMoqOwPKBU8bsNJ60BOumb4XRtH9UxhDecEaa457Ih4uQcx?=
 =?us-ascii?Q?vmcJIEBni3AcD3x+20xVo31oa+0mKdJkaz+E3/Fpz0NaFFfqzCrS/jTgEjwB?=
 =?us-ascii?Q?Z0ZX6+QLHu0XHXZIMyWAa9UYUbp8eWydLnsRl/gHBRLABkLhigv5A8l09dzy?=
 =?us-ascii?Q?A95dokgN2lHlO+Rgctzk1JyVvW5k/XOGWKBpRHus/8idEU363HDh0O/esGVG?=
 =?us-ascii?Q?czhesIrqEKPwI0iAh18drnD+EuC3M7W0niGQlybcTtr7VlxsY4pCjyHljBpk?=
 =?us-ascii?Q?5nIZU69tle/yuEqmIeIQK/VFQCaXK3nWl+gRXnrpmvCQBHv4olyRPS7B9Hht?=
 =?us-ascii?Q?NhKyEasAARq3JkYeEBFQDaEJyM+KSCorfBrMQIZGVLcVTKLnn4D8ewqu2db2?=
 =?us-ascii?Q?B4EMIYrggX17SqCXfz5h9bx06p8Ww97azadGIrGKdyrISXT8D21gjR/62tr0?=
 =?us-ascii?Q?2C9fFApEcDqGdUjOx31vEOrhp+V6Eqm2rgKb?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2025 13:07:55.8998 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c90a81c-ec51-4955-6834-08dd9eb1d40c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EC.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9474
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

The original code did not properly release the dma_fence `next` in case
amdgpu_ttm_fill_mem failed during buffer clearing.

Signed-off-by: Li Ma <li.ma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 9c5df35f05b7..b7284f0a5ac0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -2296,6 +2296,7 @@ int amdgpu_ttm_clear_buffer(struct amdgpu_bo *bo,
 	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
 	struct amdgpu_ring *ring = adev->mman.buffer_funcs_ring;
 	struct amdgpu_res_cursor cursor;
+	struct dma_fence *next = NULL;
 	u64 addr;
 	int r = 0;
 
@@ -2311,7 +2312,6 @@ int amdgpu_ttm_clear_buffer(struct amdgpu_bo *bo,
 
 	mutex_lock(&adev->mman.gtt_window_lock);
 	while (cursor.remaining) {
-		struct dma_fence *next = NULL;
 		u64 size;
 
 		if (amdgpu_res_cleared(&cursor)) {
@@ -2334,10 +2334,13 @@ int amdgpu_ttm_clear_buffer(struct amdgpu_bo *bo,
 
 		dma_fence_put(*fence);
 		*fence = next;
+		next = NULL;
 
 		amdgpu_res_next(&cursor, size);
 	}
 err:
+	if (next)
+		dma_fence_put(next);
 	mutex_unlock(&adev->mman.gtt_window_lock);
 
 	return r;
-- 
2.25.1

