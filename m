Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C430C636D6
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Feb 2023 19:09:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F04F710E895;
	Fri,  3 Feb 2023 19:09:36 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20623.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::623])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2531D10E895
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Feb 2023 19:09:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZKjjH1OFaUPby2fsY3kgYpAl6IJftFz/ObslzWBoOtVvgpo92uLBX9AGzmfbp7ODLVJIPykG6t5aAGL0zRct9NZ8CAbA1960GTs/8eTv08TL5EyeCSo6C1OvU6sn88wVd4F+fQx/JrpcLdv+pWVNzdqYYnrN63fXFuCUyP19FfZkuLW6Xi9jsMSBrROnrTh0vXIq9CriXifCYrdw6tF950yRB/XysOv0raVUQ5LIY/dhnmh3gAH6Z0xZdOedeKVSeY2130x2f4F516dlRoKjrwAPEaYkQ3eSinz3eSvgUveblnZTZ5Y6XNB9m4tWSs8Bjk+sRPh7Zk55C+3eZ34I9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2MrFTa7wwoqvzeLIj4Zea0IAC4/T8UH3kHL6Kc1s37A=;
 b=OTCKf17MRtMCFGfWN8n7jXlu+muL3ghKCqgfJ45vyPlu0RnXKY6x4VM2TZHTA/niGhlergoWNFPZNGD9293mKw5xCQArO+ZUJ9dZHCA3VaI9nYEuRFsRceKmyJuoGkEmKU+o7PihgAR2L4WeFgxInoxXCesASVNWXDQ0b9fEdoo3pnnOac5wTe0Gfw4ASyHpr05XIsu0wtBQAgwhYJHcna6e2LqjMvm7XjfMnTEEw80i3PoJ1iWhBp7KYgwFhTKWPoc2k7Q3w7AgnTPfCvBiEHenJyqlBVni/cPfpbo6IcsC6GhVXArJ7b6jKzPgdTg+jK0KiQed6QJTnNBn7/GvLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2MrFTa7wwoqvzeLIj4Zea0IAC4/T8UH3kHL6Kc1s37A=;
 b=BPATOyS4caLePqjw5CFYKV7/7Ygh1qbaAvYoo0/PnKe7UFugX8Ns9mMxG8ZLTgNAu+6B/ZayqsEVuCXAMe6R69CxAyzrpz6YCQ3B94LoAkvduezcyGxnQ9OkUDwVUPSaY4rBS3rGandyK+bRv5v1rlwJVXcT2fkb4kbBK9n4QQE=
Received: from CY5PR20CA0007.namprd20.prod.outlook.com (2603:10b6:930:3::26)
 by MW4PR12MB6684.namprd12.prod.outlook.com (2603:10b6:303:1ee::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.25; Fri, 3 Feb
 2023 19:09:32 +0000
Received: from CY4PEPF0000B8EB.namprd05.prod.outlook.com
 (2603:10b6:930:3:cafe::4a) by CY5PR20CA0007.outlook.office365.com
 (2603:10b6:930:3::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.31 via Frontend
 Transport; Fri, 3 Feb 2023 19:09:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000B8EB.mail.protection.outlook.com (10.167.241.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6064.15 via Frontend Transport; Fri, 3 Feb 2023 19:09:32 +0000
Received: from MUN-L-SHSHARMA.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 3 Feb
 2023 13:09:30 -0600
From: Shashank Sharma <shashank.sharma@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 11/13] drm/amdgpu: initialize doorbell memory pool
Date: Fri, 3 Feb 2023 20:08:31 +0100
Message-ID: <20230203190836.1987-15-shashank.sharma@amd.com>
X-Mailer: git-send-email 2.38.0.windows.1
In-Reply-To: <20230203190836.1987-1-shashank.sharma@amd.com>
References: <20230203190836.1987-1-shashank.sharma@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000B8EB:EE_|MW4PR12MB6684:EE_
X-MS-Office365-Filtering-Correlation-Id: 000655e9-bc91-4078-d468-08db061a2e9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CQfh8of2s407CuZWc0UjO/t3NSxshiQfHi8LF6tXmyETmpg2KVcm8SAwuP6CzGAGMg0qeI39I9y2di9H//5LKe5LdpqlOPF4Mm3sFcoQ6PkvblJzEoKBCjbGgtSrOnVh+v4D4IqPSAUhMlm8xeuU+dhnIgQuEP6vYt4RoOPMLk9m3zMtnI0UfsaqDMq4f0aPO8COQh2UPKVgBhJqQkYJJ9a2K8+tDCMoqizDHs4l1sUU18JgtA0kJvcQk4+TEEyXYKHFnhxYiGeBMnNOTZNP6afakl2AEghDoOuqGvA+XsapNx2j5xamj7aOS8090Cn17U0HFHP7Q8orRs5ExLNRxnKZaM5xEx3SAavszvi4d0N/4P6EeB6uVYlQGQ58/u+IyYeel6O3NRflcMfuuczuXUh18Ew9gFp0kvsOv14P1pSlnk4l1D+uN80FZOONIW0X+90djMW2W9BBgnKyW3oxi5rPJG1tdjRINSSsUaQzPDsS4F2Sl5JSrzomheTZPp+tVMqwwRNgrXvlvQ5rGVVQBUfWRFDuqIPGplzktrFNtz0gGWw7cTTsXaVXnDnt2RMQeTGtWA5TrcywmlB/uRqVoR/kFSWdjaGcx29e9WY0FZgquvbLojToxkXp9JA9yKKx/51Cqki30D/Wg94qfbiJLQC+/pZufgVLB8THCtRibTo8mC/k/IjcFrcuaxMt7RHsy1CDeNauGQOkHeyjRMwBpYRxsAJMtkIdpLMV/nbDkBg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(376002)(39860400002)(346002)(136003)(396003)(451199018)(46966006)(36840700001)(40470700004)(40480700001)(41300700001)(316002)(54906003)(82740400003)(70586007)(70206006)(6916009)(4326008)(478600001)(8676002)(36860700001)(7696005)(2616005)(26005)(40460700003)(186003)(16526019)(47076005)(426003)(1076003)(336012)(8936002)(83380400001)(82310400005)(44832011)(2906002)(5660300002)(81166007)(86362001)(356005)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2023 19:09:32.2844 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 000655e9-bc91-4078-d468-08db061a2e9b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000B8EB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6684
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
Cc: alexander.deucher@amd.com,
 Shashank Sharma <contactshashanksharma@gmail.com>, christian.koenig@amd.com,
 shashank.sharma@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Shashank Sharma <contactshashanksharma@gmail.com>

This patch initializes doorbell pool with bar manager, which will
divide all the doorbell memory into pages.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 71eff2f195a7..08355f981313 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1793,6 +1793,13 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
 	if (r)
 		return r;
 
+	/* Initialize DOORBELL pool with all of DOORBELL divided into pages */
+	r = amdgpu_bar_mgr_init(adev, AMDGPU_PL_DOORBELL);
+	if (r) {
+		DRM_ERROR("Failed initializing DOORBELL heap.\n");
+		return r;
+	}
+
 	/*
 	 * only NAVI10 and onwards ASIC support for IP discovery.
 	 * If IP discovery enabled, a block of memory should be
@@ -1829,6 +1836,9 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
 	DRM_INFO("amdgpu: %uM of VRAM memory ready\n",
 		 (unsigned) (adev->gmc.real_vram_size / (1024 * 1024)));
 
+	DRM_INFO("amdgpu: %uM of DOORBELL memory ready\n",
+		 (unsigned) (adev->gmc.doorbell_aper_size / (1024 * 1024)));
+
 	/* Compute GTT size, either based on 1/2 the size of RAM size
 	 * or whatever the user passed on module init */
 	if (amdgpu_gtt_size == -1) {
@@ -1927,6 +1937,7 @@ void amdgpu_ttm_fini(struct amdgpu_device *adev)
 	}
 
 	amdgpu_bar_mgr_fini(adev, TTM_PL_VRAM);
+	amdgpu_bar_mgr_fini(adev, AMDGPU_PL_DOORBELL);
 	amdgpu_gtt_mgr_fini(adev);
 	amdgpu_preempt_mgr_fini(adev);
 	ttm_range_man_fini(&adev->mman.bdev, AMDGPU_PL_GDS);
-- 
2.34.1

