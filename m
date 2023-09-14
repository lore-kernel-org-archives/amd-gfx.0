Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C3A0EEAA74
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Sep 2023 20:23:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96EEA10E2B5;
	Thu, 14 Sep 2023 20:23:27 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C364910E1BD
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Sep 2023 20:23:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TIl+KOFmKfNIupoXMzCnnnjKnY3ZH49NQKBwziSl/1HLJEtVvbA+za3DUDYxiAlRCGfqm2t8JWwVaMHwcgcbigFGh0vb8k4dafqNVxn8Y8Ubhzay95kHGtHpQgVhKYGOdRF4utohdWNbpCFthVZ4Rbs7AQRjJFsP++goZLnnOC1/73wGx6vx196XiP0ffyZD17xFlBGRqhzBw+rc7nMHwJVXCfu6N0SYJZduhUom+oEWbHKU9+kHzop79ChO/SpPLiwHQjkuEwME34drJTpQB07c7QxdGMpfSmsS699B/Nzc+rU0bWVJGlTMjFf3ypdRmtrt+f5Tp4PAnUeJsBQaRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AWmDhNOokDGwSJlxhM4/yz6WVu8TMUbHKA9MtXIqCRo=;
 b=ElDGmMIycggZOo1nygMR2Ip2cavwq/2afyNFvCTaAMgPl7iErq5Jj4q2gOq8m9Usytu5U3M9P3azxqwQZe6BuPKWFZkvUWwX5FoRehs7kchieO6Dkva8uVnn5px+Qt3Ht0frKKRF5cePh2Zls1VCO+N6i8JIEvx/GqXRZfNQ2z6uLORK9naTqpz5sgxdQWr8bs9Z+yUz2CmSrYvW3pPRWDtFExjkAgAxEEzAVpNiREHTGG4uGGgqsJE5fFYWAWHM2IibghokHsoM3IFbjl0IxRb4yIYoPW6Ikx/3SE2V2hjJ29CFouJkztlrtqz/AyBmTdqkCVL+rfXhHjqVXQKDSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AWmDhNOokDGwSJlxhM4/yz6WVu8TMUbHKA9MtXIqCRo=;
 b=uz6DQDBcc42FKGd0wWmIF97crTF0Kmvu2LW9/CUfUgi/tbI8+l1K1D9qDVu8gOdxvki/h7dnkKh6+cWTBHp69A0QbyA7E7OzIdMNabKKQXDw/v2MUdO0IrXn9dOa2dfZwm/KpXR6jowo10Fb1cVvMxBRrV3XhaUHl1Usn82zG20=
Received: from PH7PR17CA0003.namprd17.prod.outlook.com (2603:10b6:510:324::23)
 by SA1PR12MB6775.namprd12.prod.outlook.com (2603:10b6:806:25a::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.40; Thu, 14 Sep
 2023 20:23:20 +0000
Received: from SN1PEPF0002BA4E.namprd03.prod.outlook.com
 (2603:10b6:510:324:cafe::20) by PH7PR17CA0003.outlook.office365.com
 (2603:10b6:510:324::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21 via Frontend
 Transport; Thu, 14 Sep 2023 20:23:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA4E.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Thu, 14 Sep 2023 20:23:20 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 14 Sep
 2023 15:23:18 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 4/4] drm/amdgpu/gmc11: disable AGP on GC 11.5
Date: Thu, 14 Sep 2023 16:23:04 -0400
Message-ID: <20230914202304.695340-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230914202304.695340-1-alexander.deucher@amd.com>
References: <20230914202304.695340-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4E:EE_|SA1PR12MB6775:EE_
X-MS-Office365-Filtering-Correlation-Id: aaa89806-dcb1-4980-d90d-08dbb5606fea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AwDm2TNV93PfXrgkw5ULwbgNbYhZbdkXAeFLo9fy4ynkUke4tYMn1tQaccZNghD5sq0FZ0fOsehO02ksoIzaDX80N9p46XT5d6xCw10E4AHPrwvYqGBdrPP1OKoIdZyEaTVO16cmh93Uh7FB1pok7fp9X6VsKInhS3DKwz+aF+m4dc3OePAH0Yyd2jbjxi+59LoHA7wNREHWYcPXeeBY9ONvb0gsWP+jfSfPGYvdnlC2K0q5PKY97VIYyUHrr+yOkEcRfs8yxxJrHeyHXOfCCQib62/S25GhkWM4jU5Dm9BHTMvMQwni5AyPMtSCYF+0acBB03sQwnuG6Z7VYKjxDSCKuIB2/NVuxub1MY7V4MUTqWFdVjp+Uo2m57msJHaHzRkkn95Uvk9s4ylRKNWhixb2ALauiMYYErG/32a+SypPjrIYSR3swVNcOamF2sC+k+QV+5k+Wv6kDkuBv/R7CLQ2ZLBXv0DQ0psaBuuvscYKXmJJNleU+7GjwkpPCXeArDEx9v8UzCcrpmZyUoivEk7MiAQzosshbE43gyf4e9Z4peffbA5ZNryzmhBXBuBkf/2K6fkvQGbgJv0Ab6/+fdgAQfyJDWNYanY4LhMV1ynI4y1cOP0bNrV6U4JPEbsMeXkxGRBu9E46pCpK+9meN0kHD9OAcsD8M5bBDYOTJSBsmPJb27h8NM1oZJNmqkW3vlDrP09VjQANUetb3Ib8vl2OzDaU7QdFhtTe7G3yd+4Lw9v4VafepyyFq/9m2exm2HSxlO6T6SHJst/sIN1xMQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(39860400002)(346002)(136003)(376002)(186009)(451199024)(1800799009)(82310400011)(40470700004)(46966006)(36840700001)(36860700001)(40460700003)(47076005)(2906002)(4744005)(36756003)(86362001)(82740400003)(81166007)(40480700001)(2616005)(16526019)(8936002)(4326008)(8676002)(26005)(1076003)(6666004)(41300700001)(70206006)(356005)(6916009)(70586007)(316002)(336012)(7696005)(426003)(478600001)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 20:23:20.1581 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aaa89806-dcb1-4980-d90d-08dbb5606fea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6775
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

AGP aperture is deprecated and no longer functional.

v2: fix typo (Alex)

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index e8dc002b5a79..e04ae66fef1c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -742,6 +742,9 @@ static int gmc_v11_0_mc_init(struct amdgpu_device *adev)
 
 	/* force GART to avoid a hw issue in GC11 */
 	adev->gmc.gart_placement = AMDGPU_GART_PLACEMENT_HIGH;
+	/* AGP aperture is removed on GC11.5 */
+	if (amdgpu_ip_version(adev, GC_HWIP, 0) >= IP_VERSION(11, 5, 0))
+		adev->gmc.no_agp = true;
 
 	gmc_v11_0_vram_gtt_location(adev, &adev->gmc);
 
-- 
2.41.0

