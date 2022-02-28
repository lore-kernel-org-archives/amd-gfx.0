Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA7E2C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Feb 2022 22:15:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 348BC10E593;
	Mon, 28 Feb 2022 22:15:55 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B474610E593
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Feb 2022 22:15:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wk99ooVcYhYCYkgTdv8f/+OqAI4QJ/fqEdl7zh8d9zUnYI2RhuxdINiK1FINHupPrZcgAOjZBcesDS+8tb6FDy6A4c3A7QoUlPcnZCrwmqSlhLVKOEhS1VJn8rhV3z/CaPEWGSC1U4a5TVbeP3bY+MNJBBKHVWEZW4a3WvZmnVxArZCSbiQEncSo6lsCXA015AaOFQtl9li8uwpcFgx0gFgaSagCvrxRE5oRh7NAuA/VT3nmC1ELJQoDHXEXJw+AWd2E8ew8QSv4gm/kES1rUPyBso2DwCGSBIkIwKKXRCbFyn50yXQW/tQDMk9sh8QATcQBKrNdU1l9zqrhiBONDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZpLkwXwG/hJEzEy8tffJE8dCoUL295ixSAYIPD7YUy4=;
 b=aj3ATJmfpeLvfO6PLfDUJ8LpiiL1SmuSfkDFKBckN48HW7A0BngwWXxlH7gz1dIWDpCspwJQ4PjWvnvV7jjnZD7Q0+gRWVB3loNPbl+Xq09UcP80h1KSMGp0pdA60MnulyPchzfpCZEXdarU4T5nbUFqcxeqohuAIAJ6higULMFxY6CxQeLRu7g0jh9oNNIvZShigsWe5k6Njp1/xv5JbsIbHrP89D9kJ/RDNistvwO6O19civ7ufuJ1LI6pvSOsudwEUG+yK2ZVbXtE2dpzEY5nI+yXqPH0qH0DWifWoBf2sVCTcROMB5TpTl9BaMLNtZnweahrWWq6wskEniwyJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZpLkwXwG/hJEzEy8tffJE8dCoUL295ixSAYIPD7YUy4=;
 b=t6v08NlymaqbsnnN2Nit6+pWZe0y2oYW+CZAGWgBi4O5CU5iO2N+ZaveHUAsDlXa+XxORrmkIFL+VBwrN/ddmLDeimXRqyZU1pEph1ym8J8WAuYiEzsEIrc4EOG00cKDW4Y586xTL90e5KBtkC43vS4cUlDiY8D+xulEXXWLzzI=
Received: from DM5PR13CA0051.namprd13.prod.outlook.com (2603:10b6:3:117::13)
 by DM6PR12MB3531.namprd12.prod.outlook.com (2603:10b6:5:18b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.26; Mon, 28 Feb
 2022 22:15:49 +0000
Received: from DM6NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:117:cafe::77) by DM5PR13CA0051.outlook.office365.com
 (2603:10b6:3:117::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.9 via Frontend
 Transport; Mon, 28 Feb 2022 22:15:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT017.mail.protection.outlook.com (10.13.172.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5017.22 via Frontend Transport; Mon, 28 Feb 2022 22:15:49 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Mon, 28 Feb
 2022 16:15:46 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Use IP versions in
 convert_tiling_flags_to_modifier()
Date: Mon, 28 Feb 2022 17:15:32 -0500
Message-ID: <20220228221532.1002763-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: deda4208-6604-40bc-0c4d-08d9fb07e001
X-MS-TrafficTypeDiagnostic: DM6PR12MB3531:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB3531E8E7B39D6B7A96AB518CF7019@DM6PR12MB3531.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HodKe7EqstmAvy4t5fYL1gEfy9QgCr3yo0XHYwxFEybGwXD+TMbyr5BbIfIBY16qqzA+sWrJl5IJWnHDXiR0Rz3Du1ZMYGr8ZvU9CKIlQFX2sM9mAAJ81jRYajtxben5i/qeTyV3PdMcAq/nqroVDd/XA1K2t4tq3HCnx+e+EP1A9TuuxINwi4VnX9+IOy1VLAqkHjIaAOpVoGlhT0nApHm79M9mZ/GkEiG1tJ1ThvjLNkn/sHIXXzAjdtKvAGWFhHchsiBW9op6FzYtcZh0Wa+b/ZX0Kln4ajcS/E612WTDBS7+tdkxG52LHJXkn8+v+e1oRJmQ/xQShzMVtM3q1jWWin811KAb9x/w/s8wc0Q6dhbDp2Et2ZRH031p4lTWXTPuTZu5isMAh6rQBlOh9u/oSbn1cN2gJv6P82qLEn0TGK7VqKZc0q9PHv657TR/cf6mBjpqi+SfHRxxs1EASwh3lARBlI6r3uC7GwGzLvnF3IV8pW7HgBiwNXgMPmyeA0/+hex4WehjQF+3tbc/rfTnYKGpKJUnMqkoR6nJJbEVgkdDEu2jI3AetOg+W8RZHYcFuF+xXCiBwrLhzOPGAYRAgAU8LbhQP8d1SJ5Hgg3+Uw27WeMzGbu+nhE8k0BV1yKkL8OPnWVSES59cxbnnUoUkg3ZgJQEqFAMnnxyiA9ss2ibk7lRKaxMZ6k3GkjASn4eP9IszTPazPM8ijwVow==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(186003)(1076003)(40460700003)(86362001)(26005)(7696005)(5660300002)(4326008)(70586007)(8676002)(70206006)(16526019)(36860700001)(83380400001)(36756003)(47076005)(82310400004)(6916009)(336012)(426003)(81166007)(356005)(6666004)(8936002)(2616005)(316002)(2906002)(508600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2022 22:15:49.0050 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: deda4208-6604-40bc-0c4d-08d9fb07e001
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3531
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

Rather than checking the asic_type.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
index 448e9b46417c..dd70c85b8205 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@ -691,9 +691,9 @@ static int convert_tiling_flags_to_modifier(struct amdgpu_framebuffer *afb)
 			return -EINVAL;
 		}
 
-		if (adev->asic_type >= CHIP_SIENNA_CICHLID)
+		if (adev->ip_versions[GC_HWIP][0] >= IP_VERSION(10, 3, 0))
 			version = AMD_FMT_MOD_TILE_VER_GFX10_RBPLUS;
-		else if (adev->family == AMDGPU_FAMILY_NV)
+		else if (adev->ip_versions[GC_HWIP][0] >= IP_VERSION(10, 0, 0))
 			version = AMD_FMT_MOD_TILE_VER_GFX10;
 		else
 			version = AMD_FMT_MOD_TILE_VER_GFX9;
@@ -787,7 +787,7 @@ static int convert_tiling_flags_to_modifier(struct amdgpu_framebuffer *afb)
 				if (adev->family >= AMDGPU_FAMILY_NV) {
 					int extra_pipe = 0;
 
-					if (adev->asic_type >= CHIP_SIENNA_CICHLID &&
+					if ((adev->ip_versions[GC_HWIP][0] >= IP_VERSION(10, 3, 0)) &&
 					    pipes == packers && pipes > 1)
 						extra_pipe = 1;
 
-- 
2.35.1

