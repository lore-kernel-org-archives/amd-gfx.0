Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0618C4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Nov 2022 18:17:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0175B10E11F;
	Tue, 29 Nov 2022 18:17:52 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 867F210E11F
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Nov 2022 18:17:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HgXsaV8TKgvvhwjFMACUe4zzirwMSNTsdUkIKXob6wrpEKQAW3Zn7OvspgeyEvr/J8dtzaLutwm1pvbQqFL9IWPuiQktU7A9n9FIGKkjpH5y6lzZpL009k3v+1OWKAHe4va1HFfKJXKfR1b6oEO7M9DMwoAD/75KrYovt1tFpgsAmHV6t+UgjXdjYOFJr8YKLlizf5gIRL5+1wOLVL2L9eKb+tOOksRbPh0pXXSty3IQY3JOWQ1Eo5NNdNemACnYqcGFbNllr0CckAI5N+JbgLid7w5GzJGFG1Q6V0l2qNqyCslRkY/Ys41gmqVspZTRydq1iyjqR8anohSiqFjDlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xBcgsO8wFvy05Xe+JQwTtN90DceGrPdfUFQhsfURPXc=;
 b=a8VzFZovuYO8zHt8pCiBJWQjK6Kmn++d+/jADmIi2QhBCzU27j9CB69hSjR2cC233bv5SDUh+pT2PbbltVgAdgv6ap4g0djz/L6a5wgFfVeTzxv7hmPQ4jCtLCFAv6um9zuUW+oGwmvjso7c+xcIDEAJNhCIzH7kzIxOu3MFXoFhmPiPrE+U8BYqcIgGRv+3VWmR4Tx3rFOcPLWgnQnYta94qH6d8a5tpOGQ/AVJDLJS/g4w4+lIIqxCCgG1tfNpqJvX3xSAHriksiRAds0QiG53xcEvEJzifksw5ERcOVa44UyX09AcDD6pCQaiq2/WKzaiZsU37PPmthr3rPX88A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xBcgsO8wFvy05Xe+JQwTtN90DceGrPdfUFQhsfURPXc=;
 b=X8rMm/HzYp1GMim/6a34MSxaUwnqv2P6VxPlx/HmuZT3ikW3X6cuLoeRyJNKuf8uK5fbbI5Qn+jlrw+ym8Oyv5dpK1L33GVEp/LybKEtBKCjdDw4EXJPQ/a/c5I5vm5dtwyrzPArH+DzUJ5v8x6vuyyPY7EZGKXRaX8OGWbxwe4=
Received: from MW4PR03CA0258.namprd03.prod.outlook.com (2603:10b6:303:b4::23)
 by CH2PR12MB4923.namprd12.prod.outlook.com (2603:10b6:610:6a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Tue, 29 Nov
 2022 18:17:47 +0000
Received: from CO1NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b4:cafe::46) by MW4PR03CA0258.outlook.office365.com
 (2603:10b6:303:b4::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23 via Frontend
 Transport; Tue, 29 Nov 2022 18:17:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT012.mail.protection.outlook.com (10.13.175.192) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5857.18 via Frontend Transport; Tue, 29 Nov 2022 18:17:46 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 29 Nov
 2022 12:17:45 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/display: use the proper fb offset for DM
Date: Tue, 29 Nov 2022 13:17:16 -0500
Message-ID: <20221129181716.2442984-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT012:EE_|CH2PR12MB4923:EE_
X-MS-Office365-Filtering-Correlation-Id: 59380573-e421-4467-ceaa-08dad236041e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GBNTQKQ6sWZFPqYVczKKX3kfeVB1WomFIMV8iEfc7cVEIS9/qy+UQqpuOhragxK2vh+NOTa90v4DcZJRUWuAwAzS5lr4F026ZArnMI81AvrPNwj0oBNI3SadO/Wv0oyj9yQisQmKFjxaJiRGyRVKyOaTF69Db952R9icazuhizyxA4ticOk3L8PagoQB7W9HC1N9FsjHMTHSWRZQASBvLWQY9MYhjkUgVAF4fZx/2q2uRWqkd0TRIUnPc/5M2tFf2IWqklGlAv2bb8WfG3WNYttA7xoPzcWy80i6PQZz5sgXnwDuMoFMI8nUyKqfsSDhOUeKkIwHArBdUsYqaADfgPysSav26an2IW6fGt8foQ6Mjk67An/by8bGhMlp6IwlOt3t3kmTc0xuE7zzLwTg2XoaYd7lnz/c840paQ/oLxyccVQWyIMdDr2ABPotqUCcH88Nl0jsxDj5dY6Trj4wls0hqnsfq2Knp5VPouo9aRERyM578RJMy0f/2eAIQZbMc+FIGZClrsikFWvvOMQNEx76qdZbj9bIy3PPyTznpc1Suc5zqamE75x8Pel/QgB+s2Jw7sucgEEN2euWnwOtNv6V8SrcjJAKKvQoKWiwTpBq5lRYkuK41MH58STBvVUx+jpWL8uxMsRbKk8BJcLsRjwroVKQ6s/KQLGZbpo9sBWcz5gHAC3MjxMOcQXOW/JPqHEkjmc7X+HNaYcraA6k3oc40PdZTf/Y+bNVcsNcs0A=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(396003)(39860400002)(376002)(346002)(451199015)(46966006)(36840700001)(40470700004)(5660300002)(8676002)(4326008)(8936002)(41300700001)(6916009)(40460700003)(81166007)(356005)(36756003)(2906002)(478600001)(316002)(70586007)(70206006)(336012)(86362001)(26005)(16526019)(2616005)(186003)(7696005)(1076003)(36860700001)(82310400005)(426003)(82740400003)(83380400001)(6666004)(47076005)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2022 18:17:46.3978 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59380573-e421-4467-ceaa-08dad236041e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4923
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

This fixes DMCU initialization in APU GPU passthrough.  The
DMCU needs the GPU physical address, not the CPU physical
address.  This ends up working out on bare metal because
we always use the physical address, but doesn't work in
passthrough because the addresses are different.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 3792a181253b..850432e220a8 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1096,7 +1096,7 @@ static int dm_dmub_hw_init(struct amdgpu_device *adev)
 	/* Initialize hardware. */
 	memset(&hw_params, 0, sizeof(hw_params));
 	hw_params.fb_base = adev->gmc.fb_start;
-	hw_params.fb_offset = adev->gmc.aper_base;
+	hw_params.fb_offset = adev->vm_manager.vram_base_offset;
 
 	/* backdoor load firmware and trigger dmub running */
 	if (adev->firmware.load_type != AMDGPU_FW_LOAD_PSP)
@@ -1218,7 +1218,7 @@ static void mmhub_read_system_context(struct amdgpu_device *adev, struct dc_phy_
 	pa_config->system_aperture.agp_top = (uint64_t)agp_top << 24;
 
 	pa_config->system_aperture.fb_base = adev->gmc.fb_start;
-	pa_config->system_aperture.fb_offset = adev->gmc.aper_base;
+	pa_config->system_aperture.fb_offset = adev->vm_manager.vram_base_offset;
 	pa_config->system_aperture.fb_top = adev->gmc.fb_end;
 
 	pa_config->gart_config.page_table_start_addr = page_table_start.quad_part << 12;
-- 
2.38.1

