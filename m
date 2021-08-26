Return-Path: <SRS0=gNHI=NR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C0FAC432BE
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Aug 2021 07:04:18 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FEA561053
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Aug 2021 07:04:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3FEA561053
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D033E6E525;
	Thu, 26 Aug 2021 07:04:17 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2083.outbound.protection.outlook.com [40.107.220.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9FE86E525
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Aug 2021 07:04:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g6IctUQGgbdlzrMbmziIw+bDqA1vWyiEDVJmI+9oEQcfMmI1SO50cQX7UclWCdVQuciSQ1nrpo2LKaiT3MckDfnbNaCcKM6hdpXuDtqOkmeoY0F2V1qgS7y/PuM+X9CvvhVBcKjlIc9O/o5grNnFidMjJrsXkBedYPGXdsO0hmebRCVKZHV+V1XFAYxW6cMYQwZTbIV+lPHqgErUakJRsCDJtYD/3ANDW3tuZSuE5QxDrck6Mf+wWaC+mfGmPTRlNphutl5sNoKwrU/HjQBce1CLKWVYeG+wtLPn9SOJJ8QNU8aFqDl3LiWcgaYLEKJ35OmyxKLGMyi7NqhUgFmPKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NNfxKH9kYiI3G4SWbetPoVqbfmvnHwrmudlNPq922z8=;
 b=TWsv7vREKmKkUODjhjozv4yxeZFkOOCAaIWvcF+knZGXqTJ43FkKbST1dXyduBQKgrgG/tK4U0scjQPhcjwnkHmWTQrCVCxVavivkq3Ntl+6Bb6607BxifkIJ129e5ujIshJDmUPlfkEKIVa78iNqOgOVr3/5j06VImfhrFG+npH7j29zpIQII8SDC1ixfb6wLle3hRrqdBRy5teJlnenpeYSq9ZHwHiW4XYs3dfGzRqI0bg4u+QQMh71fF3JniAXQQydvxcotDV0q0p3aLYZ3s/s8GcaevWMJ+whSNAmzOf0U9B1E1HG0SZh6q/fG8IOxzekL4ExT/mWR8Y4MAhFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NNfxKH9kYiI3G4SWbetPoVqbfmvnHwrmudlNPq922z8=;
 b=SVixbQqEwySG/0GG2nS8JqGvOUzvFB/XUeZdgwCCNY6e2gYI0Y9S1SsGl520B/L52P3bQbXbgU9jdgXXdUOGkKBblv94Qf/jiQ5JK9QInG6+A8r3BMzW7MH94+8o0lLKXiTghh3AIQ1cBjNrjsJHs0VhCjDrVmjAEWzEclJ/7ic=
Received: from BN9P220CA0012.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::17)
 by MN2PR12MB3981.namprd12.prod.outlook.com (2603:10b6:208:165::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.22; Thu, 26 Aug
 2021 07:04:14 +0000
Received: from BN8NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13e:cafe::17) by BN9P220CA0012.outlook.office365.com
 (2603:10b6:408:13e::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17 via Frontend
 Transport; Thu, 26 Aug 2021 07:04:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT006.mail.protection.outlook.com (10.13.177.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4457.17 via Frontend Transport; Thu, 26 Aug 2021 07:04:14 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Thu, 26 Aug
 2021 02:04:09 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Thu, 26 Aug
 2021 02:04:08 -0500
Received: from hawzhang-System-Product.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.12
 via Frontend Transport; Thu, 26 Aug 2021 02:04:07 -0500
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, John Clements <john.clements@amd.com>
CC: Hawking Zhang <Hawking.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: disable GFX CGCG in aldebaran
Date: Thu, 26 Aug 2021 15:04:05 +0800
Message-ID: <1629961445-2951-1-git-send-email-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c66a26a7-ef7a-4228-c3db-08d9685fb69a
X-MS-TrafficTypeDiagnostic: MN2PR12MB3981:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3981513782D3C48BE45F02E3FCC79@MN2PR12MB3981.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1107;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FJVUDSxNInZ7DQgZ6qiY7auE2/4VgVKddRwK8soW+li6r/gA9la+O9Nn4GlNmQ3unnYyatevOheSIXEzqMz8Ft7vuVY98/YbAUBwW8y6LbyrnRLFRgp0IrC84lXG5IRFCL6nBSJyjLVAI8WeTtEA19tUFASFWcSs5hkrN71xu2U/KUFkhuuclmVxGgjckM3ANAj/5ND3oYShJy9OPn70KJumNis/ZPbe2BOqIxlWOrvn39dFZJSTehgUk5Jd4GJJXgkkfwRgr6T2zOeOvpXcvFhjG+eR7VbCvJ20yrOKEzb+JoFlhz3UTG1xxQJPecO/qukFAwzhV4sh5FdZIl7OZY2L3g1YZS+jmDujCS7/ZNbhTJZK+CvYG0Y30yd7ywp4L/44ptVdeIYbAxg3KRy1uuT3GX6wZEXfnfvdWEdgHsQkVO0ISwsdYx/ci4q0TIwmFDR5VLvJXQg4owaDRg4mGUhOARw25ZMPIo/Zp9cZz2S3K4FWtg4fDq63x3A759Zg+NwTWdYIWjj/Kaph7QTIMsPxR8ZfH81wcqYWUA7sEs5nao7a7pNovoVD9B+FTfUKc2iB2lG29lKAL9wgPYAOl35qhr5ETm5/6b6yZAkXN9676wr1R079MtxBO2CODBjJyGEkXk5MKm2sFHz0e96NS1WLZqNiSU5f87Ig09HwfLJjoZahWQveUwY8wUwYJ9izL+vg5l523PAm5TRI96Rm3ghQb77KvcPtj5OMWz/URmE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(396003)(376002)(346002)(39860400002)(46966006)(36840700001)(83380400001)(2616005)(2906002)(82740400003)(82310400003)(356005)(81166007)(6636002)(26005)(5660300002)(186003)(426003)(86362001)(4744005)(478600001)(70586007)(8676002)(70206006)(8936002)(4326008)(36756003)(36860700001)(47076005)(316002)(110136005)(336012)(7696005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2021 07:04:14.3983 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c66a26a7-ef7a-4228-c3db-08d9685fb69a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3981
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

disable GFX CGCG and CGLS to workaround
a hardware issue found in aldebaran.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc15.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index f7b56a7..0fc97c3 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -1353,8 +1353,6 @@ static int soc15_common_early_init(void *handle)
 		adev->asic_funcs = &vega20_asic_funcs;
 		adev->cg_flags = AMD_CG_SUPPORT_GFX_MGCG |
 			AMD_CG_SUPPORT_GFX_MGLS |
-			AMD_CG_SUPPORT_GFX_CGCG |
-			AMD_CG_SUPPORT_GFX_CGLS |
 			AMD_CG_SUPPORT_GFX_CP_LS |
 			AMD_CG_SUPPORT_HDP_LS |
 			AMD_CG_SUPPORT_SDMA_MGCG |
-- 
2.7.4

