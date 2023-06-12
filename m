Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D528BC7EE2E
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Jun 2023 14:55:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C94410E29C;
	Mon, 12 Jun 2023 14:55:32 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2071.outbound.protection.outlook.com [40.107.93.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EEAB110E29C
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Jun 2023 14:55:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O+0PVQcKNZrrupBgXjm5p31cuFDUfFYrx1ZTal/feKDRxOicO8Rkn3u63ZCYFgh1H38qRbtYx//KSMYToUhj2un84+ifiTp7ZjqbgCgB3Dz4YcPvagTIsNKlZ91axZbzxTrA4KQSOD/9l6Kts0fNP9Z2/CI9ayLXb1z1izwuICRgFimzwObrADBlnRQMKPlabEdvOyTDv5F0zEiU3BmoSX264j3/ncwNV+i8kTxXPezBRsjA/jLTyI1nFBuMkmyrs5eOWIWt2I/59nCAagixVD3dlAyl7/V/gg5ju4PfMHAQw8y29hGtmpo7xgHVm4whUnTokuHvsC18pFWF0ClKIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gYcDwtdFBgLz/r2O/eu6Ob9SJLbz7xbPkhzP+PKpUaM=;
 b=FeYSlwXipflw2NIF4p2LmIF3Ur4OO9DuWfEu/64xvA/qcUr9ylrSxx41ystNpPK95ZhDEDN4K2mmyEU4rGPGCBohE+Zs538wKsOuE4RXjPIcCx7+YKfqKuTDF0gQlyPRNkvhzgKkpLn5aYcABWUT7QI8sMNedQGJGssVsrJjrIbL/fzv2XhFhAY8Pfo5qLVM2Lg6epH99igyZ5rIqPlCuzLiqfXZ0UeZ0DeG1EvD7R44WHxV59N8eDLaNMdLm8no5iSLfMyunTlHBvTDuYK2WT7dICSRBnDbrLYaf05L00fnqvNS1i1cSc5q9onkcRdJ5fLrM+wGWTDNvfuD8mFhOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gYcDwtdFBgLz/r2O/eu6Ob9SJLbz7xbPkhzP+PKpUaM=;
 b=RvnhSIXcsa403HLUpy6qgkywMmyxN6PaxkV3AbGAHYWk5C0BhJz/3iX1s6cvtNCG0zEQp58DqTYgu3vEhyplW50L6NllyZoUN0OC915qwyepUBgMsvKepvw1u7Khnx60mWwoWVxApb3JGl0/KmqHg9xer2O+CJbTrAOoeT/1AyQ=
Received: from DM6PR08CA0050.namprd08.prod.outlook.com (2603:10b6:5:1e0::24)
 by LV3PR12MB9260.namprd12.prod.outlook.com (2603:10b6:408:1b4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Mon, 12 Jun
 2023 14:55:26 +0000
Received: from CY4PEPF0000EDD3.namprd03.prod.outlook.com
 (2603:10b6:5:1e0:cafe::81) by DM6PR08CA0050.outlook.office365.com
 (2603:10b6:5:1e0::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.33 via Frontend
 Transport; Mon, 12 Jun 2023 14:55:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EDD3.mail.protection.outlook.com (10.167.241.207) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.21 via Frontend Transport; Mon, 12 Jun 2023 14:55:25 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 12 Jun
 2023 09:55:24 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/display: don't free stolen console memory during
 suspend
Date: Mon, 12 Jun 2023 10:55:12 -0400
Message-ID: <20230612145512.752279-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD3:EE_|LV3PR12MB9260:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bc81127-b869-427f-1ced-08db6b550e61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7AXJphy1BasQu6VBhQmkkuFGCzV/7tK67upuwGK/VxLotUuo62FbdqE/0ze6o+hPl6qqGipWGaEUBY2jZr1MjXrMNTFmjUEKmoc6P36E0fITIuGG/aUU7146gAJiPZy570YQDtSH33yVjT3erw3vcfnkDIBHmCupfRU9IpZ696SKeMRILpA2Fxji4hzVa3mUOix/7qCl08Du+6LH3y/hR/+zMyF2ukYk0N3+08PWHbjbFKpmYkvv+6tXmI9eIzn0Wn71XWMx7wlTxIg/qGyK57aGD28l7pn1ejc+juS+zW9FC2HuSXfBsMQlBeHOfmYbpgyq39ta74PSgY3SWFm0y/2l/7s3ivkmNlMhvb44oE1y/Qgh+HdmLuRTvFeWkqOWp7cfqYqXxHSCpRujngKvq0VvFLakMdt3froUo4yCNPM1Va/Mp/7wft1x6mVfT935/25XXUeA4xkUBq+4T7CEMApxIy3pWYZ/tnXAmQVclgqLPTe+NtR+7ZhYDQlQzISBuPJI4YNtumelc5xl3hieZhf4HaLqbzJwwPEz15Xx2wrtGkQOoLQDkzEhnbbz2zRxNWh7iwHpVj2G787UlJrXVN8YSzzr1nUlCPNsW5LyzBNh5aPK2K9Vm/mrKwb3l7JYDSdQrQ68f17HpU7iRBouJWrGhrurTsQXQoV0CklUmyxhFzqT5JbH/btyRQk6yKbPa2gX4kEmWLhgavYnwu34AIlWkQ9Br6ECbWicnef/biY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(346002)(136003)(376002)(396003)(451199021)(36840700001)(46966006)(40470700004)(82310400005)(36860700001)(40480700001)(47076005)(336012)(83380400001)(426003)(356005)(4326008)(82740400003)(81166007)(41300700001)(36756003)(316002)(7696005)(6666004)(966005)(1076003)(26005)(6916009)(70206006)(70586007)(2906002)(5660300002)(40460700003)(86362001)(8936002)(8676002)(478600001)(15650500001)(186003)(16526019)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2023 14:55:25.9600 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bc81127-b869-427f-1ced-08db6b550e61
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9260
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Don't free the memory if we are hitting this as part of suspend.
This way we don't free any memory during suspend; see
amdgpu_bo_free_kernel().  The memory will be freed in the first
non-suspend modeset or when the driver is torn down.

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2568
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 0454e94d5680..fc0dd31785cb 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -8963,10 +8963,17 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 
 	drm_atomic_helper_cleanup_planes(dev, state);
 
-	/* return the stolen vga memory back to VRAM */
-	if (!adev->mman.keep_stolen_vga_memory)
-		amdgpu_bo_free_kernel(&adev->mman.stolen_vga_memory, NULL, NULL);
-	amdgpu_bo_free_kernel(&adev->mman.stolen_extended_memory, NULL, NULL);
+	/* Don't free the memory if we are hitting this as part of suspend.
+	 * This way we don't free any memory during suspend; see
+	 * amdgpu_bo_free_kernel().  The memory will be freed in the first
+	 * non-suspend modeset or when the driver is torn down.
+	 */
+	if (!adev->in_suspend) {
+		/* return the stolen vga memory back to VRAM */
+		if (!adev->mman.keep_stolen_vga_memory)
+			amdgpu_bo_free_kernel(&adev->mman.stolen_vga_memory, NULL, NULL);
+		amdgpu_bo_free_kernel(&adev->mman.stolen_extended_memory, NULL, NULL);
+	}
 
 	/*
 	 * Finally, drop a runtime PM reference for each newly disabled CRTC,
-- 
2.40.1

