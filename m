Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3412EEB64D7
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Jun 2023 11:56:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D274910E45B;
	Fri, 30 Jun 2023 11:56:47 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2062.outbound.protection.outlook.com [40.107.223.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C238F10E45B
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Jun 2023 11:56:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d4VZsc5iu1hfZz6IZpG9nYg9VmaEW3KU+NOjGyPQLayrQG8OmMIsnpl37wmF3to3gq8ZauilBybFkJUSCYWps9VhwNWLisuUcZHiIGkm6Q4Rxlgl5hkfBIC+A9vYsqCS/ozqXXjYhgVBLEg9bt9pYfaTxgXfHXt77nHBr1Yw5Cn5qijmcut/j2D6gYW5q8GG8YfqmS1bfln4AAOTC+JPl+aSv5QBP5UEiq0CFt22hmIkaeEmzC6A5u3SyORSW98hpp8SgwU97Em5RtleZM1J7SoGf9RXGL8Kht0dT6KpwBU9TdADXKCdrbGdZiA/DCKcGxoimT8wiC+lZfIsn5ZMGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fINWKcNTZEjusRi7pZ5fza0ZwgIILrAeL9uPm+VPcQQ=;
 b=SToafwvaK6I3ucNfjKaBM7/AtuqJDQ258DeDDK3Dg6gUj2b0ZnSYHepE2YMo6QD/uEDZu/K9O1S/BdxOBdkM20R78gVFKRGL+XRaaNypRIRfykvPGEs6gqZkIszFEXuaNDIFnYQGXGUdyMVRIHqkkj9SoI9W9kQ2wXc3WTq7Ya4rzzB6ET663ryaKT4qtpe+oWNQhoHu8L67Ae3mrgS7UvLl0zo9Md0JkC8h2nSwcUFn/TV9DUx1mRxdo0gIMRq3vcj0uYVBHsQ6+iTRJ+DDgsUDQ4mHJ5CveJL0qRXC9FD9IwN6qwobq0xq3n2W42X2n//CchFvSg/NkL4xuLbDhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fINWKcNTZEjusRi7pZ5fza0ZwgIILrAeL9uPm+VPcQQ=;
 b=mX95DASJwYY2w87pgHaX+E3GWuOH/3SkpW2ZIcHU1HgRfC//+gCZXeWfnIj6T/MveSel4Ya8x9Ri4RlpbjY9FsyseWK4mSA0zCwI38kk/vnhBUz3bTWhNtTv0mOZrV5GYE+sDS7/CqpK0s3sQtSgy9x/ygFeT0f36XTn2NB4b7M=
Received: from BN1PR13CA0020.namprd13.prod.outlook.com (2603:10b6:408:e2::25)
 by PH8PR12MB6939.namprd12.prod.outlook.com (2603:10b6:510:1be::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Fri, 30 Jun
 2023 11:56:40 +0000
Received: from BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e2:cafe::a9) by BN1PR13CA0020.outlook.office365.com
 (2603:10b6:408:e2::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.10 via Frontend
 Transport; Fri, 30 Jun 2023 11:56:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT068.mail.protection.outlook.com (10.13.177.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.43 via Frontend Transport; Fri, 30 Jun 2023 11:56:39 +0000
Received: from TRX40-1.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Fri, 30 Jun
 2023 06:56:38 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 3/6] drm/amdgpu: Fix warnings in gfxhub_v2_1.c
Date: Fri, 30 Jun 2023 17:26:15 +0530
Message-ID: <20230630115618.2855618-4-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230630115618.2855618-1-srinivasan.shanmugam@amd.com>
References: <20230630115618.2855618-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT068:EE_|PH8PR12MB6939:EE_
X-MS-Office365-Filtering-Correlation-Id: 3350b84c-2d44-4966-8587-08db79611094
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: akeiHOsJHU89xsV9NPZFVUw5svmFtcgGyY0iiv4LyFLhw4Al+OIxbSXbjnv+hQKzTjaueT8eDn4yvhAYzn031r8lbQU38iF/rfoB90U1TnHKeateoDyY93TSf1/WdxG9ZB5YjurwnkPW4UJ9Wr1HOtzbcu6A5WZVfPYQi82/28vVrERzICmXGip4MzsyxfT1U++EuOwz4KQK/0mflWAURdv59z0dJvcCHrP1f/1dESV8nbwVsfutGmMvrXfDwyoXNSGKBPW2YP//Ez2tX9cGYAoL3biMW6bYGuocSyTqKYisJQWpWtZtLQ0mGCnj7Vrng5dsBKIGbhDk+3FzuI5r1m2TLIPupT/Mh3i0u8/7GnNK1CZy0Pbed4usEZRwofJn+J+PFfnJo6OFWulQGT1hS690RxKYTU09ajUwnM7v3ovVAR/f4RQMCGKECMsypb4Y3wWb6VEhtTLbTZO0tjq5MKfFMBXly29aXmipNCHoMoC7ed9PgPBYbnJArFm56GH9d6arts+R4xai6BJoVjksjysMsrQQxHdrEbpSgM47pVhhLdz1y92pz59etmLzxtDxLqhnpzGd4dIVubGtKeqPOVxKf3F9m8FEjSXMwNL7XklM3Y3Yk6I6JuKDZt+JbZWXjWeq/0slyC1sYEPMcCbQMDcMGTc+Jgc2Bgb9HwCOdTV7wezT5Bx5e4MCr0Y1LIWv9MhYaI/yzd611AVyeztqIVFVbCZw8Y9mTp5oJXSz8nZCUIufg+BLK45e4dWmgiTIOTK3nkSaKxiknEwzHv0ftw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(136003)(39860400002)(396003)(376002)(451199021)(36840700001)(40470700004)(46966006)(82310400005)(8936002)(36860700001)(26005)(4326008)(36756003)(82740400003)(44832011)(47076005)(70206006)(66574015)(86362001)(41300700001)(8676002)(6636002)(40460700003)(316002)(81166007)(40480700001)(5660300002)(70586007)(110136005)(356005)(6666004)(16526019)(83380400001)(186003)(2906002)(1076003)(7696005)(2616005)(478600001)(54906003)(426003)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 11:56:39.9702 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3350b84c-2d44-4966-8587-08db79611094
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6939
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
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix the below checkpatch warnings:

WARNING: static const char * array should probably be static const char * const
+static const char *gfxhub_client_ids[] = {

WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
+       unsigned i;

WARNING: Missing a blank line after declarations
+       int i;
+       adev->gmc.VM_L2_CNTL = RREG32_SOC15(GC, 0, mmGCVM_L2_CNTL);

WARNING: Missing a blank line after declarations
+       int i;
+       WREG32_SOC15(GC, 0, mmGCVM_L2_CNTL, adev->gmc.VM_L2_CNTL);

WARNING: braces {} are not necessary for single statement blocks
+       if (!time) {
+               DRM_WARN("failed to wait for GRBM(EA) idle\n");
+       }

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
index d8fc3e8088cd..7708d5ded7b8 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
@@ -34,7 +34,7 @@
 #define mmGCUTCL2_HARVEST_BYPASS_GROUPS_YELLOW_CARP				0x16f8
 #define mmGCUTCL2_HARVEST_BYPASS_GROUPS_YELLOW_CARP_BASE_IDX	0
 
-static const char *gfxhub_client_ids[] = {
+static const char * const gfxhub_client_ids[] = {
 	"CB/DB",
 	"Reserved",
 	"GE1",
@@ -341,7 +341,7 @@ static void gfxhub_v2_1_setup_vmid_config(struct amdgpu_device *adev)
 static void gfxhub_v2_1_program_invalidation(struct amdgpu_device *adev)
 {
 	struct amdgpu_vmhub *hub = &adev->vmhub[AMDGPU_GFXHUB(0)];
-	unsigned i;
+	unsigned int i;
 
 	for (i = 0 ; i < 18; ++i) {
 		WREG32_SOC15_OFFSET(GC, 0, mmGCVM_INVALIDATE_ENG0_ADDR_RANGE_LO32,
@@ -582,6 +582,7 @@ static void gfxhub_v2_1_utcl2_harvest(struct amdgpu_device *adev)
 static void gfxhub_v2_1_save_regs(struct amdgpu_device *adev)
 {
 	int i;
+
 	adev->gmc.VM_L2_CNTL = RREG32_SOC15(GC, 0, mmGCVM_L2_CNTL);
 	adev->gmc.VM_L2_CNTL2 = RREG32_SOC15(GC, 0, mmGCVM_L2_CNTL2);
 	adev->gmc.VM_DUMMY_PAGE_FAULT_CNTL = RREG32_SOC15(GC, 0, mmGCVM_DUMMY_PAGE_FAULT_CNTL);
@@ -616,6 +617,7 @@ static void gfxhub_v2_1_save_regs(struct amdgpu_device *adev)
 static void gfxhub_v2_1_restore_regs(struct amdgpu_device *adev)
 {
 	int i;
+
 	WREG32_SOC15(GC, 0, mmGCVM_L2_CNTL, adev->gmc.VM_L2_CNTL);
 	WREG32_SOC15(GC, 0, mmGCVM_L2_CNTL2, adev->gmc.VM_L2_CNTL2);
 	WREG32_SOC15(GC, 0, mmGCVM_DUMMY_PAGE_FAULT_CNTL, adev->gmc.VM_DUMMY_PAGE_FAULT_CNTL);
@@ -679,9 +681,8 @@ static void gfxhub_v2_1_halt(struct amdgpu_device *adev)
 		tmp = RREG32_SOC15(GC, 0, mmGRBM_STATUS2);
 	}
 
-	if (!time) {
+	if (!time)
 		DRM_WARN("failed to wait for GRBM(EA) idle\n");
-	}
 }
 
 const struct amdgpu_gfxhub_funcs gfxhub_v2_1_funcs = {
-- 
2.25.1

