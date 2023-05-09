Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB4DDC77B75
	for <amd-gfx@archiver.kernel.org>; Tue,  9 May 2023 22:18:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 490FF10E429;
	Tue,  9 May 2023 22:18:52 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EAAFE10E428
 for <amd-gfx@lists.freedesktop.org>; Tue,  9 May 2023 22:18:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NIzQuef9okVSNadvbQgKxxWzi/F6u6A3yviALeNehYXgA/YY78j9P8cTVMtyZvepC1I9lortJT3KN9/vYpCq8ow0WsYwtaoBC51YCr4QDuxZKi/PP4+pXdpt0zi1Xf4924S343qSGKkDNjoz082d+ivF2nfc/wLEFPOjc53uZJbkpj0BtSj5aqaT1SxuBgLXEyFr9Cu9mYncpuq7CLyTgc9fY5mQBqN3UOPYSg6F/fc+K3Eb+LjrKc77K9TYcZGtMxzUgklWYFyP6QkfK0pQjNkw0YWc9dyBDJDWnMB6MhKvXsJSVF7F7P8SCLVtW5pXtha/bzmWJTEEps1HqdnrVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mk3GGYCKIiHoqRd3abkN2z9+WWnoTwZT/j0looaav1w=;
 b=Ru6G4U6WlygQKOlXPERr4pvf1AI5t7EaKxrFcd/5Q2bPaExYgUW5cH8CgGrULzvoNb4PwoVk34jB4UBI6MNNOMYnZ/GjgTlcZ23cNPe+ixsejkw/ltGhSri46eLUtH2t4Q+/3434aAGTLoqQ77soI6Yl0t8PwBQyWopeWbW+oh8N8nMq6iLa57v3rSMqVsbh3BG6FbPU7Lvz9KYKjcCtjIgeNMJ7KenIH3ebt79fAVFlqMh4SItMCOdnjwSdDRz0FgrwYgKa5KHJ00qScX/MOWnCC0/HViH3KS4NVEaymGsBnhKJHk1uPMsC/sqhYTjJMFVDDg+QQddKGmL3J2+7zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mk3GGYCKIiHoqRd3abkN2z9+WWnoTwZT/j0looaav1w=;
 b=zT/ujXKL4QaU7zQCZRjpFNBw81XtbYMmQmR0GeU29PEVMN35+vBV7dfYF2sQooMnja4KJdDGhfvA4xnzKJonNZFVzvlQVDCHFMySMh1HX6s5sv1qP5fSKNKTrImIjEqJpF3eKq2SQ2OewIHWComxFH8MmFJtdvUuyYo6vAWjoeM=
Received: from MW4PR04CA0285.namprd04.prod.outlook.com (2603:10b6:303:89::20)
 by DM4PR12MB7717.namprd12.prod.outlook.com (2603:10b6:8:103::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Tue, 9 May
 2023 22:18:45 +0000
Received: from CO1NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:89:cafe::de) by MW4PR04CA0285.outlook.office365.com
 (2603:10b6:303:89::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33 via Frontend
 Transport; Tue, 9 May 2023 22:18:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT068.mail.protection.outlook.com (10.13.175.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6387.18 via Frontend Transport; Tue, 9 May 2023 22:18:45 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 9 May
 2023 17:18:43 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/3] drm/amdgpu: Return error on invalid compute mode
Date: Tue, 9 May 2023 18:18:29 -0400
Message-ID: <20230509221830.477324-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230509221830.477324-1-alexander.deucher@amd.com>
References: <20230509221830.477324-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT068:EE_|DM4PR12MB7717:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d2c8939-5d22-43ec-1b5a-08db50db5ab8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0w1PqtSnKFILUbx5rdNRpTtDmcz0aji1r1Vt7crZUp4onnCoDFT8OMpiHeI8kKuEGtdx7xWP+wybjcQ2aDgUS5Rye7GHZxVo7T4k/zGKqllOgd9q6sfyt1bHNtsDfW7ZG6KYbkiVolWGPY8fqBS+i15GsxZ6mT6W1eMOQtlrXCkLvHmCsbdiyzmtBYgyqgYQHzZ1STXYk55P8w+7jQTuo+AskxIOs2InygIxaygXf594p4yZus+yJZrMAVU2gmFuhvJe9uq/OPMm2C8tI+55q2ejjCNw+rh4NEOhBifRBECD2Qav5J+N/1sJw3HUb3T4x1GQ7V55btATL/0T3NDEO5cmcvK50YrZZ8bR4Ls7yTQsNdkZ0avUyRXT0l7dU/QemcM6QNkDcxKzgt6vAoUgBkHTdFweOEkPmGMDIUpyYq076mYX0PcX9A/vC8wpA/VgWslYBz11RspukcduZRoL5XodAipyT/euHlgLxI5lxYp8YOC9Ajza5q1DJHMNnSpyJ/l6UIG0w99XrnSHdjJRYP4PW+8bbqKsfgkOio44YeCEUT6MaFKJNPBJ4G5Xkzre8zWtAnSD/XetscG/39SpYfnKic6CFaM+heE4GZlzTOBracPr/IcuGOEc91YCcR2z48WrpBQ696x5k8Mfj9AQWmX9TiJt2UOXzX6vRfMZ5cKuJS1aT1Ok+gWif+s8vuyZq9CraP28fGtasRaju2gCNxF3N8++yfpZFHQcZOWOegI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(136003)(346002)(396003)(39860400002)(451199021)(36840700001)(40470700004)(46966006)(6666004)(6916009)(5660300002)(316002)(41300700001)(81166007)(82310400005)(4326008)(82740400003)(356005)(70206006)(26005)(86362001)(70586007)(54906003)(1076003)(2906002)(8936002)(8676002)(186003)(16526019)(7696005)(36860700001)(36756003)(478600001)(47076005)(83380400001)(40460700003)(426003)(336012)(2616005)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2023 22:18:45.1413 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d2c8939-5d22-43ec-1b5a-08db50db5ab8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7717
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Le Ma <le.ma@amd.com>,
 Lijo Lazar <lijo.lazar@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lijo Lazar <lijo.lazar@amd.com>

Return error if an invalid compute partition mode is requested.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Le Ma <le.ma@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/aqua_vanjaram_reg_init.c | 8 ++++++--
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c             | 6 +++++-
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram_reg_init.c b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram_reg_init.c
index a165b51e9e58..848049db00ab 100644
--- a/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram_reg_init.c
+++ b/drivers/gpu/drm/amd/amdgpu/aqua_vanjaram_reg_init.c
@@ -328,10 +328,14 @@ static int aqua_vanjaram_switch_partition_mode(struct amdgpu_xcp_mgr *xcp_mgr,
 	adev = xcp_mgr->adev;
 	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
 
-	if (mode == AMDGPU_AUTO_COMPUTE_PARTITION_MODE)
+	if (mode == AMDGPU_AUTO_COMPUTE_PARTITION_MODE) {
 		mode = __aqua_vanjaram_get_auto_mode(xcp_mgr);
-	else if (!__aqua_vanjaram_is_valid_mode(xcp_mgr, mode))
+	} else if (!__aqua_vanjaram_is_valid_mode(xcp_mgr, mode)) {
+		dev_err(adev->dev,
+			"Invalid compute partition mode requested, requested: %s, available memory partitions: %d",
+			amdgpu_gfx_compute_mode_desc(mode), adev->gmc.num_mem_partitions);
 		return -EINVAL;
+	}
 
 	if (adev->kfd.init_complete)
 		flags |= AMDGPU_XCP_OPS_KFD;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index 81ab3cd2f229..d0ddcd751432 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -1933,7 +1933,11 @@ static int gfx_v9_4_3_cp_resume(struct amdgpu_device *adev)
 	if (amdgpu_xcp_query_partition_mode(adev->xcp_mgr,
 					    AMDGPU_XCP_FL_NONE) ==
 	    AMDGPU_UNKNOWN_COMPUTE_PARTITION_MODE)
-		amdgpu_xcp_switch_partition_mode(adev->xcp_mgr, amdgpu_user_partt_mode);
+		r = amdgpu_xcp_switch_partition_mode(adev->xcp_mgr,
+						     amdgpu_user_partt_mode);
+
+	if (r)
+		return r;
 
 	num_xcc = NUM_XCC(adev->gfx.xcc_mask);
 	for (i = 0; i < num_xcc; i++) {
-- 
2.40.1

