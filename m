Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A3E4103E189
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2026 14:11:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1EC2310E837;
	Wed, 18 Mar 2026 14:11:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="r5RYxBdZ";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010055.outbound.protection.outlook.com [52.101.46.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A41210E83A
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Mar 2026 14:11:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L8Kamih9UfUG95Hw4F+1MBfc0V7+bJmyFtygRJoWlEpQCHwKa54LlQUHb75RrLSc34iYgLK2UCuBJLpWG2siw6B5TGPfsrghXlY28mP2n1oeoGAmlyRVmQwxEcshpvA3iR+u7rU22FAdHIDj1ubeCaRV3NRKxSjE7o6p/qZnm/p5dkf7Yd0ijz721kjyO+l1RwrFsOJeW8mlyFE0Q6RkCzjF7yC3UgmUfZE16qmCjmbIniURlqm7UTmHCv8nn4w6Po7qTebZVRBnmPLrM7TX0mn6YBfbN9812171Z82vL9dVIllWFMiLPM6vgeIk9TXo1OB/DGcfv60lvNRMv1hOew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zuDewrXWrPCswxQ5ub17CswWakUfjHXRPGtVBxq5NQk=;
 b=NNSwGwho6UBaLpNoIyvUykv7efwgQPtdRVq62wgv22qkHybSB4APPybGELqivCZPf0FGUs6SwV46rvGqfVaQ9/FEuAMUSx5MiYhJ2n5/4Yeo3zxhcGaVjyDNZInvnLfwHsjnkQES+DhgE6XZsICEyKC3FFdNjzU4oH1KWcGiIirGVYh6kAorijbk2KFzIlUCNzsHGNiZac19+KdlRbV+el+b/eteLf6g3tgEEM2+iu1wAK8WSfJH/9d6YiSLb8ki+Zg1ROe2s7oPOo5Y62oZKgwUP/lmCjdIlxrWRb/6O1A4BiaERHcZUwOZjBENX5zd2ZflKcPky7+jtP0VuZRXiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zuDewrXWrPCswxQ5ub17CswWakUfjHXRPGtVBxq5NQk=;
 b=r5RYxBdZl+uvDXoj6r/7THROv4Zh9xolx2LR4V+yl6TjpGXshJvN2d/USk66Cs/CKRnpV6Qs6j7a1K21irrfHDrVvnOp4P9BMxw6jxkrc5s/GHSpZPG12oVq4BNb7+7RsPsNzLpO5vTEeawwpmuoL0UzMrjybh5jENsEg5QJAZY=
Received: from BN0PR04CA0123.namprd04.prod.outlook.com (2603:10b6:408:ed::8)
 by SA1PR12MB5637.namprd12.prod.outlook.com (2603:10b6:806:228::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Wed, 18 Mar
 2026 14:11:44 +0000
Received: from MN1PEPF0000ECD8.namprd02.prod.outlook.com
 (2603:10b6:408:ed:cafe::66) by BN0PR04CA0123.outlook.office365.com
 (2603:10b6:408:ed::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Wed,
 18 Mar 2026 14:11:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECD8.mail.protection.outlook.com (10.167.242.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Wed, 18 Mar 2026 14:11:44 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 18 Mar
 2026 09:11:43 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 18 Mar
 2026 09:11:43 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 18 Mar 2026 09:11:43 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6/9] drm/amdgpu/sdma_4.4.2: set SEM_WAIT_FAIL_TIMER_CNTL to a
 non-0 value
Date: Wed, 18 Mar 2026 10:11:26 -0400
Message-ID: <20260318141129.583333-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260318141129.583333-1-alexander.deucher@amd.com>
References: <20260318141129.583333-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD8:EE_|SA1PR12MB5637:EE_
X-MS-Office365-Filtering-Correlation-Id: 51a4aee7-c6fd-4aff-fe3a-08de84f848da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: tcsEEOem6mcngTGcnQN6AJjSbJj/iqFW+rE4XkGvPOUEoGhAhoDzSGLYLLygAsFRv4owhzQ4lyt1cc+uEg5IheqOaKwybO1hYDvTg2F9Y+QWekdv59JLbdQ3ZKM4XtRWvwVjLzueaBi+XbgtC+XMVDR8GPQSc+oSIdOrzeKLdc7bCWEjlJu985sk60e+sT9MNHts+iVexgf02KK18EQOYXi/78nn+015yJuIk6tXdB1RHxnS2Sgdaqvr4CIidNAUNB6dLNqqPAxLnORGIPtWEldnquQ+uln1+NMPDkKf8/2PdMjrRazKUQqY4LPKWcg0EV0d9BOpFgjVJMgi3WUOqn8TuqvuQMETZgN5qQaAzbg/kVzHrXc15KhK+gwRTeecYVU95GNY5lQD7Mv666egnYMYOzmICyOBL+vtCnUe4lNJuJs13PZ8fLxN6vYFK8pRNVy5mZv+qc1qvxicbOMUCV517T2q/Gntbb5t5YZ8EO4SsfxkTlJIBaLL2q4kvesXEalpo1ipho6QFOsJNgQ9/TQxeXrMaTcmhUyrUbWcknFW+6bqeugLSbYyijJuntrWZLYJ7MZ2VewLOgmtOYoHa4YJxhLTfT1FCGhAGXeljlxetaEFj4vny7oL2bM1rMl5pRvP4Xzr2naYGug8yR4ZlUxw2URl2SlHc8ps4E34QCrMqq+pV2QMWpwy9c34nokTquuqvFepuWke81j66RvDqh+ET141Xk/5NUawoPYG3ndUyr5K2vzbCazWqlcxfzYbhBp0bJSb/45frveCUIA0Ww==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 5cVBhDsqaiypLPyYnQbVuY5BrPzvFAY0Gm0crHi0zoOWiW+r9l9eQmY6mtnJBuG5hIX9GWWlIUZ97SOV3Cag0ltUWqYlpi6jnvWnUyzDy1sllXyPHcIxaWan6IU91Os3qQcPUFaXFbRTfQyq3GxRuNRTIr1NlH91lmnJRvanCckP54Unp21BieqgSWIKSVfa1bnoXIxqy5hyWlwdd0rervfsob8KzMI7D0EmNQVlUZN5lEhuSMzabsge9V5jRjiKW0Ze1+WYfwkZJf05PRsDluDWB2u9P62hGY5RIm6d/Ys9v1Di4OXVlxgiSmJTYkXmSupgUv1wGP9hie8czg0o/TFDyJBZYAuPHhyJ67VHWp9aB0zkczcMb9MNvWgIYGyXDDkDRxHjQk3JYpxpIG+NNhOHKuvFEMpI5+E7vWQP+bymanscHNKKlmUAh0cgqa+E
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 14:11:44.1784 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51a4aee7-c6fd-4aff-fe3a-08de84f848da
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5637
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

0 waits forever.  We don't actually use the HW semaphore anymore,
but if someone uses the packet, set a time out value so we
eventually time out and avoid a potential queue or GPU reset.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index 78bdfed0a7fd3..cf4ad97a93652 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -992,7 +992,7 @@ static int sdma_v4_4_2_inst_start(struct amdgpu_device *adev,
 	for_each_inst(i, tmp_mask) {
 		uint32_t temp;
 
-		WREG32_SDMA(i, regSDMA_SEM_WAIT_FAIL_TIMER_CNTL, 0);
+		WREG32_SDMA(i, regSDMA_SEM_WAIT_FAIL_TIMER_CNTL, 10);
 		sdma_v4_4_2_gfx_resume(adev, i, restore);
 		if (adev->sdma.has_page_queue)
 			sdma_v4_4_2_page_resume(adev, i, restore);
-- 
2.53.0

