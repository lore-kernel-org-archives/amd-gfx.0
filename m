Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BE11C27C4F
	for <amd-gfx@archiver.kernel.org>; Sun, 30 Jun 2024 14:40:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4077510E060;
	Sun, 30 Jun 2024 14:40:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jsTzgkLv";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2935210E060
 for <amd-gfx@lists.freedesktop.org>; Sun, 30 Jun 2024 14:40:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MK4bWFs8/cBuFH25HowPQZbU9seNRD7LlmAH9bUOYlIv3F5zedm1rPQpzMjxtJ4SsMwDIn/nnjk8OHoKfZLAFOpVgVIvEy2Ob4D7xqJDLkdpu9wzHSsqcpqKtu5L7lqQC2B9BWilYmuZwmA4y+ax4ncPLRURy3QZQ8GcTPIvjzhSdIEdpiep4TfVA3iaZSbpu58E0joLWzMgiNgG7FqgLsZr+eLXibQLBg1p1dgr1j1bJCw3ZeRMUhgLyhHU/PdcZ/WI+A3u4ZbKef/lh266bMkPjZUGQVKF0pKmv1va1nW2Ni9l+RC6sADkkp43hVf2UMt1sSCJsiDzpGWy0ZJocw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/kk4XT+iyI6Z6PS92z2ORdsNdo8OS3cPOPOaRyGeY9s=;
 b=cVY9H3PXRTUGOubmdkXHVCa2iHnqjnsvmQDatmlC7czUpLq18HLfn4tUBvEikuBD/uJ18NGgIIjDPTeFKkhToAL5EvUP0YfvWqeuiaRFd4JFuvOYtQ0m7/iAgED9RTtQVHDTrwX/6x2iMHW8TaWCi3dckiXOB2OIrMlPd1aGToKJRFjT9iOC+ojnnynwNjULzcdMF1TMKxP4Csk4SSNuSYz1sD3AvueTKLGnAuE9wkEolSwyYim3b38gjHqWZEmd/OEjw1Q241cD0ELHZC9RoeyK3Z9v3uGSYvu90MZEzqzzmrl1JeMiz+IVM3uOA5bTgsgQw46kD+9/pvGDZCzkrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/kk4XT+iyI6Z6PS92z2ORdsNdo8OS3cPOPOaRyGeY9s=;
 b=jsTzgkLvp5f+vx29PklcZpd/ZMq+h2RXQ/OUX6o0Maa8ojXy2kf8tkwLRVES8lo4uuwKJlU6LvR+sjc5JRpaUHXP/ba6LxjtFqLvvgMyutj8pNcZ0cTTUtLX8Jj5GVn3xlHPRx5nBBqHabT11q+ccCUvEDjiVIb6NxSkxJIPgzg=
Received: from PH8PR20CA0019.namprd20.prod.outlook.com (2603:10b6:510:23c::25)
 by CH2PR12MB4166.namprd12.prod.outlook.com (2603:10b6:610:78::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Sun, 30 Jun
 2024 14:40:51 +0000
Received: from SN1PEPF0002529E.namprd05.prod.outlook.com
 (2603:10b6:510:23c:cafe::7c) by PH8PR20CA0019.outlook.office365.com
 (2603:10b6:510:23c::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29 via Frontend
 Transport; Sun, 30 Jun 2024 14:40:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002529E.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7741.18 via Frontend Transport; Sun, 30 Jun 2024 14:40:50 +0000
Received: from ldev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 30 Jun
 2024 09:40:48 -0500
From: Tim Huang <Tim.Huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Yifan1.zhang@amd.com>, Tim Huang
 <Tim.Huang@amd.com>, Yifan Zhang <yifan1.zhang@amd.com>
Subject: [PATCH 3/7] drm/amdgpu: add tmz support for GC IP v11.5.2
Date: Sun, 30 Jun 2024 22:38:32 +0800
Message-ID: <20240630143836.2015991-3-Tim.Huang@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240630143836.2015991-1-Tim.Huang@amd.com>
References: <20240630143836.2015991-1-Tim.Huang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529E:EE_|CH2PR12MB4166:EE_
X-MS-Office365-Filtering-Correlation-Id: e2f8bea1-26d1-4dd7-54b7-08dc9912a2f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Ha1YvCDH+MRhYIdrkZbUWYJPXnT6Pn0dBzuy5RzKybYDwM9caMgha+p2iWWu?=
 =?us-ascii?Q?vc2abRI6U2Odrk0/5gFkMQXjtV1Y8rRV1rWe70uZZ6l8A6pOwuhs8or0fv6h?=
 =?us-ascii?Q?Ygag2cpbOWpK7mERsRb9sgRCZTNduznUjdo/d2ra26pzfAoLySrShsyKQo10?=
 =?us-ascii?Q?1P6J3/u1YEObXm22D61bl5KMQlSq3/NqROFhXcgiO144yVv34zqpbJZ7DDkr?=
 =?us-ascii?Q?0+d1jTSEieKS38A8Ae4l9akyGPmmL4AA6gRBCRTkudOwQCYtNLaHkETCkACo?=
 =?us-ascii?Q?oW5QneMX9SSiy5Y0aPSrVH7obqkX3KRZM0Jtpy8Z+CWs2fOVrGHHTxodWiU0?=
 =?us-ascii?Q?Tvn05L41YTQ36ai3pbrRVhNBCgBaGYF++mzBS4g18LAcVlJjiGOvUhK74HtO?=
 =?us-ascii?Q?WHWSt+mFA8bPrN5dGbHiQHqqXNyYSe5sboi3kTCcDyqVaBIcRc9SxtxoPlbW?=
 =?us-ascii?Q?yFGArExnCAw6iQPUuhPZiQiIpQ2240c90XRM5Zo5xa1F61MlMOHBytS+oHQe?=
 =?us-ascii?Q?0AuQCXa03SYpHH1gdHNHoVN9skbnkdasbBzqHtOmoePjmm4xEVpE3hw8Wqqq?=
 =?us-ascii?Q?QHp/WUq4S7tO/kGiPzO+5AuJocnwB7jEinEBwnv1HSEmWbYwnlGlURsExKuJ?=
 =?us-ascii?Q?92FWjiLld8WdrFuVqGFPWuXOGV0rWGUZ2qweAmeEpesxqm9nC8Dblbb5LCFo?=
 =?us-ascii?Q?48HGusPs5sZpzKpCQefIvAaMGbqDdbYXCWT6u6Ehf6cemNq8PlmDKU9tWp8b?=
 =?us-ascii?Q?9XYOFYDpRisaKp3Irr0BoA5dbt4y8h9BEKadrQEzLLMMkAF4lhpHWYthwDoZ?=
 =?us-ascii?Q?s2tHELHm+9mzCer3ynTQQhVe5GIrrzYxUTa4j8gFf389Hrf3tk8ZAS+595J/?=
 =?us-ascii?Q?FYB1jUnoN2gp3yBo8yHc53h9vEL/K7dZ2rPDOGk8rWXDFomxqB08dNtekiI1?=
 =?us-ascii?Q?wnZa/p8e+3s6fMb1yIVSy4o8JNDcSUqHs79BnwT5TDWJFXAn0eEa1Ej9JtVz?=
 =?us-ascii?Q?DppWJdVUCROMGXvpWQJnn6PJc9Zk1osYzFE0eG/8lJY1vPMoE9dVLmZgxrbI?=
 =?us-ascii?Q?gzeXrJoCmliW7mMsJLcpVfa4QWtltXklii9X/3CAeRx77goDfn4X1iC+3Brd?=
 =?us-ascii?Q?WlBSjIlO0snNUcvQ6vME01mEY9M2MlKqZVwhLMv51L0gCDLuMVi9apRYZfoZ?=
 =?us-ascii?Q?oEqPE8yACWBooNJyOrZ5BJWUx5KYceEs3cX6FQBLzmrQ1aLgeQ0eOnlz6t74?=
 =?us-ascii?Q?OaOI/YAEPrH8s1xGKhVwnEpCNPpKsx/Dtpxb5795GjgieQxqsvPq7Dq6TsH+?=
 =?us-ascii?Q?qfjhRPSMLF2X7eCT6Rb7IK+otIQrnli1mFUEjTQbueqzummBnnWhZ3nhGKgT?=
 =?us-ascii?Q?ewcIIFrS7oYgZiQNvymoyA/T4P5iMC0juD7cgYtncP0Rldlx2uUBDPJPJUCt?=
 =?us-ascii?Q?AvXv9vY7GNKAMZ5obGxgOOCG22J4OTZb?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2024 14:40:50.1237 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2f8bea1-26d1-4dd7-54b7-08dc9912a2f2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4166
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

Add tmz support for GC 11.5.2.

Signed-off-by: Tim Huang <Tim.Huang@amd.com>
Reviewed-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 3a7622611916..c02659025656 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -848,6 +848,7 @@ void amdgpu_gmc_tmz_set(struct amdgpu_device *adev)
 	case IP_VERSION(11, 0, 4):
 	case IP_VERSION(11, 5, 0):
 	case IP_VERSION(11, 5, 1):
+	case IP_VERSION(11, 5, 2):
 		/* Don't enable it by default yet.
 		 */
 		if (amdgpu_tmz < 1) {
-- 
2.43.0

