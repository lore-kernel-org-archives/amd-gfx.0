Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC87BC8300F
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Jun 2025 21:07:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2296510E822;
	Wed, 25 Jun 2025 21:07:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="l3bO+VRs";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2074.outbound.protection.outlook.com [40.107.94.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA60610E7ED
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Jun 2025 21:07:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ez6Zps4nwkpTtpSeAGZOJ365xUPNMzMqrrPjaR6qJ3Ta6W0h8Di+U7etYQEhRm7ZY9Yxhkzuj/VIJHGCPnhTn5YuvjX5bUq+L15dEkZkTyDf7z84VUiI81rREwyq7v4RPx7b4Jxv8TD/2Pm/uhAsgYDG77FQgl7/EwVAm+D8H4EjsQv+sg/48HjYUJu0+a2YO7taTAIp/zxGOKMNOkTvuFP6xG88AnvnTF+31gI+BC2P05O2g2ejXtr7qEMvpYe2aqe/ywwqjYd+mBI8BqpZITIOp3qNrvCWYl85yqEk+eiyOaf2aPB7F685bF7yYa++cBFMCUBQ0zKLILyo0+QFQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yKra5JSPgZKJaqQ8ouDFDfjsID6k4vQp0phYGWJQGQg=;
 b=hWLqjk/KoeukFCJDxwBnt4rEm9897YbkojDtZXD3Rkk7X+cVXusVbvowf07hmCxC3dKyT2GfRgzXX1EqJASyDS3n8h9/HlZ7FzATaL/Ah8JRu6G41dROgg2c4BSHxVczU1NOFEJVjEqelPtUSZcCL8i3JIKUT8CRF1Nrh4ZisT9s0XSJ2H3fqAmpAE1vpG6SHOcSLpOWlxNfzB29tdzBKBtBNK6yG5AGg1O4GwcInLRUlif2f1bomH2HfIucLvyU3GDvXDFjwhq5A1ve0RUYQUfXR8otMPE8L/BbvnlCJB0O8vM0pBLzMoIOwTY37m/9OeOQIBmmnGzWMXoJcMV5QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yKra5JSPgZKJaqQ8ouDFDfjsID6k4vQp0phYGWJQGQg=;
 b=l3bO+VRsov8sthf59DRkDSFI0+EsAw2DhkB7p88U5acVKyFsQ2vwoBU3LTUpU31SFulFfGTROmvTjL/fOCxMSxqPrzOIdeKIY7aF/P4xj3Nnh6wY0s5wPZN5Aavb/DgpTc6Gldt7AumwOS5jMXhDM8XD3XvDBUeGzK1EBA+E9hY=
Received: from BYAPR02CA0064.namprd02.prod.outlook.com (2603:10b6:a03:54::41)
 by SA0PR12MB7003.namprd12.prod.outlook.com (2603:10b6:806:2c0::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Wed, 25 Jun
 2025 21:07:09 +0000
Received: from MWH0EPF000989E9.namprd02.prod.outlook.com
 (2603:10b6:a03:54:cafe::f6) by BYAPR02CA0064.outlook.office365.com
 (2603:10b6:a03:54::41) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.17 via Frontend Transport; Wed,
 25 Jun 2025 21:07:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E9.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Wed, 25 Jun 2025 21:07:09 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 25 Jun
 2025 16:07:02 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>
Subject: [PATCH 17/30] drm/amdgpu/jpeg3: re-emit unprocessed state on ring
 reset
Date: Wed, 25 Jun 2025 17:06:25 -0400
Message-ID: <20250625210638.422479-18-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250625210638.422479-1-alexander.deucher@amd.com>
References: <20250625210638.422479-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E9:EE_|SA0PR12MB7003:EE_
X-MS-Office365-Filtering-Correlation-Id: 54df4b58-e9d5-4852-1059-08ddb42c3f7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KmFSQ01ZZgM80sK9Mpu1T91N+g9yq++o5ibhhNqwSPBXemweQH0saTGXSafK?=
 =?us-ascii?Q?667WAA27JVBIC/p4xBp8nxF5BPfh9UvkDqO0g4OnPfzJxAv45lBk/wNiGAAn?=
 =?us-ascii?Q?j8Rv+jWUpRCxYmRrao9L3Lb/XFTS7lTpOmLDWxt0eRU0uANVcNPAsgWVdICV?=
 =?us-ascii?Q?NpGE2eA2Iuu+BCOA04pn7P4JNLCTqRfT3D1dyKuoNNxtiu8wZ8DtTLzwTWw3?=
 =?us-ascii?Q?Ngt77wYpH39ipYlIqtmQ4X3LzJ7wKhj04SzbB2w3/DbSw19WmXWHT4Hg+uKi?=
 =?us-ascii?Q?7709bQA9LbAhAvstIMnlR2EoxfqfTiFkfRPx3we8YYVxa5K7g4OBsioNWQo0?=
 =?us-ascii?Q?PZUR/r2SW16UbwMuJccj8I7pJAkFA60OBo6mCigpmEKp6gs86teRP+zcZWQ3?=
 =?us-ascii?Q?9nOe1qwdrsfL5jq8sM0dHh0SzjRqrKweCMdQQpfux7AcQwJkOjvhP99PdxuE?=
 =?us-ascii?Q?zNuBMGvjPfRabtCeTciBdzAW/hnX5uqJ+zqDxdQGuTL/MVbiQQjWhYgr1F9I?=
 =?us-ascii?Q?bEgUVOMN8CUNyBDdnzwVqZIQvZF6hPz2h/QBDJmX4OBv5emRGLkWD4xigH9J?=
 =?us-ascii?Q?5wIMIP37IoSLB1gCXX8wiCUWIIrgcQhMA+5ISSINB+f8xbFf3KmPOAasakcH?=
 =?us-ascii?Q?3+l2Vvk9ByF0NSk1LuXg/xgxlZxpeCAO46NWUx46gbKICKbMm0fipWKrZN0Y?=
 =?us-ascii?Q?GPjMLQTACFKICk/pCWANkloZhl+TD0TOXUKFogtWk64oeRjKoe1d2aFcSJvk?=
 =?us-ascii?Q?LoOx5SsxoM/0JvV8iPcQQYx7NLXiogzseGCPryChq8MzEg5Uwp+m5/NorNA4?=
 =?us-ascii?Q?pfn3fvhuop1THtA+7nbxaHEmkJOY5vH/COb7PqjHQUwCmb+pZe/UTsC1IFoF?=
 =?us-ascii?Q?tvSUABvqebzsQXePk2aEGTBTqa+pau4ZNFbcTVDAHUwE4WQoiSP0RqILT5y8?=
 =?us-ascii?Q?4Pgz1x7knjZdwBfKnqq5RO94PkFerKdc6pD3EsLKZMDY2K+oRH2ExZdWvTxO?=
 =?us-ascii?Q?p2TmolZ4WeGO25XWar9C1vpRYrf8Mdc/qztTBJPxmAsiJK/kyr4hWDP1ibgI?=
 =?us-ascii?Q?dIDdN5LOa6hybUUhyW1+YP3VpErDxUj16CfTlLMrBdL7Qjie45tGiBYKgMb2?=
 =?us-ascii?Q?EykeTQChJ52/bYpYnzvzfGHVlFYkcPNPlCwmnP7+VZp9j5jqFl0jYSErfopF?=
 =?us-ascii?Q?wRMc4JXrDxle+temoN1DfT0TgXL22NbC1cIw2Vo9JE3nsECjH28sLn1ZUuFF?=
 =?us-ascii?Q?hRNstMnmbxFwO3LYfec6KpWI2inHZCHUkmq5rgGtl/hujHfupqIlJI00JCLf?=
 =?us-ascii?Q?5SMEo3FjxRD5o3jsfiiuUom4YoA1QjbWD6ZvPfsu8N/wBPiOGNxSL2fEAgqr?=
 =?us-ascii?Q?JYvVxx/x7uyBD1juKuKEcE6IahGKnweS9iOjYhFf9mnB+xkQlcBz5fAlh7v3?=
 =?us-ascii?Q?1IsuD4HiCFXVp7OYTO/NMkLktF7YPAi6WZDhm6m8fjwxZw+dNxSdXqTaB1h+?=
 =?us-ascii?Q?O63wl3Cd+GTOOpCV3JAZkkP0xtHAZijdjpna?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 21:07:09.1658 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54df4b58-e9d5-4852-1059-08ddb42c3f7a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7003
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

Reviewed-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
Tested-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
index a24bd833d6442..5598fa40764a7 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
@@ -559,17 +559,10 @@ static int jpeg_v3_0_ring_reset(struct amdgpu_ring *ring,
 				unsigned int vmid,
 				struct amdgpu_fence *timedout_fence)
 {
-	int r;
-
-	drm_sched_wqueue_stop(&ring->sched);
+	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 	jpeg_v3_0_stop(ring->adev);
 	jpeg_v3_0_start(ring->adev);
-	r = amdgpu_ring_test_helper(ring);
-	if (r)
-		return r;
-	amdgpu_fence_driver_force_completion(ring);
-	drm_sched_wqueue_start(&ring->sched);
-	return 0;
+	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
 }
 
 static const struct amd_ip_funcs jpeg_v3_0_ip_funcs = {
-- 
2.50.0

