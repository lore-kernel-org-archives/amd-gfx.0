Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7631C28B20
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Mar 2025 11:52:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5725D10E9EF;
	Fri, 28 Mar 2025 11:52:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AEbljiVU";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2064.outbound.protection.outlook.com [40.107.237.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C79B10E9EF
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Mar 2025 11:52:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gefIJ035UAZB2bRSwqnzMbf597tdGALJE2XCW5i5UR4cArb4S5aEouiYsQVjJrMUwagZnBes/eKG301aQW24voHtdFM6YEGzftN85FJcczfU1iMhRXlU88hq2l5tpVNI11nlveKIa8HGwdwPiGSb0f/a5ThOVffNdyR3T7cCXDN4tOncL/q4OFznCyx/CdkgvE3lO0PsWwisO9Gn9TVIZGXxQiptcsDcAoUkdI/MSFbntMEDtrLIFMH1cq2BrTCE4xwuOsQFuXVccnL1r1IDcMCXIZ+061MEKyqm3UZosopfZLk+9W6aEnV6+Enxbryy74dsqBFu/DKCUrK0d/BHQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xg8ibBCDZuvn26SnZNet8zCwgqO7ZWVTJrW2LQotJD8=;
 b=t920RtjxjInk9t/ye2fVYr4XmAHC/67HjLMbCG4AikTESbTsN7uUsLF6/5HrIwB9zJIuelapPpQQCZcRtr3L9f8qzHgLZ6sTp7xCBu6+zPZjwdpbNAnaYqlJO12m5F73mJmOFDYa1yr8G2JX+VzR0tiLd+A3ClMjtkiZihirpFjcJ+B+OCflS67zd3iX7b6t9uouiSTepz3dH2IXXggwYHu9GmtcRNYcIbrRXNBPg6WrLaXL1j9lx8jOp24hJYR/GRz66LqQoNL9Ql7+BV5eoISypSq+fTeFQdnNOyiFA3W2dmJ9ZvxdA5bE2KjYDgviFPKY8l5t8uC0/xbyVT5nbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xg8ibBCDZuvn26SnZNet8zCwgqO7ZWVTJrW2LQotJD8=;
 b=AEbljiVUkdoTZNherUwHCKarMahNrOQT+u0h7ClRMrh3VhqPcAxeO5wi8MTEFBM5Pku8NCZ8jRA7/NilZarKwH3X4gO7epqDYTpu8K2LB+PHAZdVFGqW+XVw6LJDPWEOkpk/CbBK0FOihPMm+8LbEddbEwaBe45TbOAkQck2XX4=
Received: from BLAP220CA0024.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::29)
 by BL1PR12MB5876.namprd12.prod.outlook.com (2603:10b6:208:398::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Fri, 28 Mar
 2025 11:52:34 +0000
Received: from BL6PEPF0001AB78.namprd02.prod.outlook.com
 (2603:10b6:208:32c:cafe::88) by BLAP220CA0024.outlook.office365.com
 (2603:10b6:208:32c::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.47 via Frontend Transport; Fri,
 28 Mar 2025 11:52:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB78.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Fri, 28 Mar 2025 11:52:34 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 28 Mar
 2025 06:52:32 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Prike Liang <Prike.Liang@amd.com>
Subject: [PATCH] drm/amdgpu: remove the duplicated mes queue active state
 setting
Date: Fri, 28 Mar 2025 19:52:19 +0800
Message-ID: <20250328115219.1763423-1-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB78:EE_|BL1PR12MB5876:EE_
X-MS-Office365-Filtering-Correlation-Id: 43f8baee-71c1-412c-20fb-08dd6def0729
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|34020700016|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dArFWU6tNsmdlqLPy3zvhXuv+TUy5s5yraArfKMicsbk5p/Rff8IgifS7AEw?=
 =?us-ascii?Q?aUJjdsTmjCNDuSL3qHpV2IU4mJ+8MRVIPiBACPEQVFfv1aB5LjWst57l/Nuw?=
 =?us-ascii?Q?vkWxnBvDM+AK98NMWRqbvidGIiaAuE5spZQh7clI8cj8ygqyNVQ7qVatQqFI?=
 =?us-ascii?Q?ggT4GwjvzZChAbKZf+MoQ9hcUtvhoLyUorOFFDP14kmnDV3M7mqi1e4gcpfw?=
 =?us-ascii?Q?0s727pPx84/IpdZnaJS0XfXPUEVM7ibsaLYSwKGGIu86kXIamhuEEo7f45lA?=
 =?us-ascii?Q?QNn60eQGV73cK8m6UrW77ZncD5y0816i6OG2kKiAHMph8e2UoWkR6nZbD68Y?=
 =?us-ascii?Q?TtV8gRO+/FG5bHRBczSPVc/+2J4e2xrSAozRA/rv1r2HG5JXOk8Yf1c9F96+?=
 =?us-ascii?Q?fwleS0Ha4iU34tH2vzbsMCCoo8KOojUVi7uHGDJDnw5HEPTNB4FM7Iw9jOWj?=
 =?us-ascii?Q?e3kLPJQ0M/L2zUzcK9Y9ina9GTZ6qrDpiWKq1YwH7JVEzvnUewvsCoTZEjbu?=
 =?us-ascii?Q?Ysd34I9h/WB0Nkyl8MhnUbfXkvsDrpq4f5abOmwHVz7AmG0wjHWixjD/WE0H?=
 =?us-ascii?Q?zZBR5pt8O1/LfnG/PtdeggYKoyBMrNfRwCXScjLtJwEh+kGiccNZmSVXvO9i?=
 =?us-ascii?Q?xC4JDnMM1/dEyurHlTNOTNDSyi689adskGvT0Zx3hyefmAl/qKLjUp72Tt4i?=
 =?us-ascii?Q?pv/4UeJMcDXQMU2ydQyG1zcNrAuZHheWng7OO11IJJ+MnnEZ3VW3rrfKYSLf?=
 =?us-ascii?Q?exWjYM/1QIU0hBiYNpGtdoHUeNEcljn6y5vsbCa9yDHp2SEBY3+ts40xYvQZ?=
 =?us-ascii?Q?n0egrcuhcJEnUmAG36Zu1D3WY+dKT5o4ylSbIKBEVhqMS8Jr5iqLE8zUZUOZ?=
 =?us-ascii?Q?aaGzi12XKImfdznT4u4zs8i613HdXCzlU+UN63zMrl11BbcRMF/W5GVtxN4R?=
 =?us-ascii?Q?i6LUtB26NUULjZTzMe0T4SoSy0glzaeS/K30JuXOMgwSFMrq8OWMsvO6j9l6?=
 =?us-ascii?Q?RN3pRWsDHHi5rsX5SlCIU1qM/nCwfDLKJnWV62OpJgey1LmBi/NtqeN0+0ji?=
 =?us-ascii?Q?gWq17tgY+rMKikEvz7isnDH9qAEqqWkvbjmQyguGMxCfOWr6LLsgCvLIWvBe?=
 =?us-ascii?Q?JvB/1+oQ5sC2m97Eo09Nb1vNxHRBWdntHCqHoJRa3AsGkrvw+BCjdQfaSw92?=
 =?us-ascii?Q?GwJ6PhVEqhutrkKYwvyfsLsGzaoM6iRMVypAnz0gRiC7RmRCyGgG3UXL21YP?=
 =?us-ascii?Q?/rg4ZfsBbKULiaN2nWbQY2EQIoanEK4leXV2tuks2A9zO2glHR/9TDP7dcHf?=
 =?us-ascii?Q?DXJHWu9Bj7FcNgyOi+mUvDJmcp9BsLCLHRR5EyH9hTRUBwwkIvixgk8T5xh0?=
 =?us-ascii?Q?sZM8UVd4nxFVIJ+5oLAvOmyhjo5OLYzp1+1fz+c2ifQ5HA15Wx77Gz4SYLpN?=
 =?us-ascii?Q?CBKl+m6LEmJQg40RY+uA1ptPTi/rg5hTFHuPxfrC7kqEXpi45t9GAef0voRr?=
 =?us-ascii?Q?IDOZe1mhFgulLms=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(34020700016)(82310400026)(1800799024)(376014);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2025 11:52:34.0913 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43f8baee-71c1-412c-20fb-08dd6def0729
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB78.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5876
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

The MES queue deactivation and active status are already set in
mes_userq_unmap|map(), so the caller needn't set the queue_active
bit again.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
index b469b800119f..b9705cbec74d 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
@@ -358,10 +358,8 @@ mes_userq_mqd_destroy(struct amdgpu_userq_mgr *uq_mgr,
 static int mes_userq_suspend(struct amdgpu_userq_mgr *uq_mgr,
 				   struct amdgpu_usermode_queue *queue)
 {
-	if (queue->queue_active) {
+	if (queue->queue_active)
 		mes_userq_unmap(uq_mgr, queue);
-		queue->queue_active = false;
-	}
 
 	return 0;
 }
@@ -379,8 +377,6 @@ static int mes_userq_resume(struct amdgpu_userq_mgr *uq_mgr,
 		DRM_ERROR("Failed to resume queue\n");
 		return ret;
 	}
-
-	queue->queue_active = true;
 	return 0;
 }
 
-- 
2.34.1

