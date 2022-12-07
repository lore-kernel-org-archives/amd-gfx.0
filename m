Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69372C4708E
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Dec 2022 16:22:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B785510E3F1;
	Wed,  7 Dec 2022 16:22:11 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20629.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::629])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1930510E3F1
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Dec 2022 16:22:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GcXoESTl/1mgsOv8kexywmIU8k9wPlujDBDnCObwIq1UpqZuybesq3miO1BwBS/v8o0aLqsff5qoyOtNwVsJ95IOv5vSXUSylaDd9wpNiLDTY27CtHjKaIZIxHtYd0esH8aa17ICPq67YgOYr18SJyaVpVdodA42jlryvdBAc5nczH3zQ7DLQiAK1syJ6RHCk8h4N+lIfYFn485BlXz1V5jLBW/QgqFGmUGPxAmpUOZUwYzwG2C3/gReVmAcalNGeYXvKBaoxVrFIP+TtUKtwHt8aMxHVKXqngfadJiEggwqXQWuqjeumcOvrzXtumcwnsGHvP8BvZoOESN8LJTk0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z0h5VutrSH9nLlCqDs3FM7HzYobgoiU0thJGYD8di1U=;
 b=mHl/r6G11OvOUtmK0cCo83vZDL+o6oJHb3qEKIGX/amO4sPRswGni/y9+wYFxnLxTCRqopMLzmCOGnsJXQAuoqFdIiTqJhF5kYulu8kCX/u/OW54b+8PyklRAweih34w/bxNSjeNGMbIX/8x77Nba2kmTmkeo/BwkqIIVKk+kXxQtuNOxxTUbw++OULdXn4JYQAtJuIq6nQ6/PddjQ7y62na0Ye3C33Qz/VPc4phloqrGjBXSIYcgYFq9NnC4vn/na0V9QqyTnDbibMpMMxbHk3LkTnral2tm73F/7BoYyIt3jTdTpTZsLR0XG5eDWzlzCYFEVoWkG5f/yzm9AyGQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z0h5VutrSH9nLlCqDs3FM7HzYobgoiU0thJGYD8di1U=;
 b=JxCRZEG4KhNqE5eI7Yb1hZfFNZEV70XIRDxGMXd1JF632Dg7w29kpaN7Q+ozM87Jy8UQvYnmHpSMsYjM3K1cJfBAPIHTJXc0qTRoo/BxHtkHFYs4MzxeAoqNcPV2TSYow3JpdlalUg2jW7TbX/Qq7bgGg1qbXNMh2i6y+iM58as=
Received: from DM6PR06CA0009.namprd06.prod.outlook.com (2603:10b6:5:120::22)
 by PH7PR12MB7307.namprd12.prod.outlook.com (2603:10b6:510:20b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Wed, 7 Dec
 2022 16:22:04 +0000
Received: from DS1PEPF0000E653.namprd02.prod.outlook.com
 (2603:10b6:5:120:cafe::f3) by DM6PR06CA0009.outlook.office365.com
 (2603:10b6:5:120::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14 via Frontend
 Transport; Wed, 7 Dec 2022 16:22:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E653.mail.protection.outlook.com (10.167.18.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5880.8 via Frontend Transport; Wed, 7 Dec 2022 16:22:03 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 7 Dec
 2022 10:22:02 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: make display pinning more flexible (v2)
Date: Wed, 7 Dec 2022 11:21:35 -0500
Message-ID: <20221207162135.3290795-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E653:EE_|PH7PR12MB7307:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c8291ba-b010-4114-40b3-08dad86f2d42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mnEJ1c6qKcyTq9l64S8Mze1kPdJtxQaFYuJrUepARQqlEFOti1k3sMfDI9nONABu3hu8ajy4SNK/R3H2Kccr000ASYmS7X/lQ9Q2qEbxKqAPM8cQ+7uFntO/D6e1lUQcmNEtYiIrqMzV94EuOMZeg1hd64tE+kGAtmroYPRzKPesm2YOSIwiYDvqXbc19173BMzeAA/KH3M6mAPOsAvx8C04LWCZe4v7Z0VHIMS2DuQJWvO8bieYPeDCM7AfmmToQNXsi+6VKWquyCBRgTLXcbfY7ogJZ0CI7yLw/2dwUduOYGt0YaAuyOk3Vi6Wwy7BH8poqLp9RT4HdeRnq/nuAA7xI7kBpklN988yqjCnM8M6DC0WqdpCuqPv0KshF6XBspO4U3gdKomF+LGmx6PrmwBWXPvVkPj6mUExsb9zaWJvX9jPAWjP/tIPEwjMPRFYecEJQABJqmLrvRIwrdado1XQiVTZ5xaDBkGVM2Kwk8wmJ4mA3QoPb9GinSw2GqPtDnueYes2tOHabmG/u5OfWu4ou5YEWi6cLN1XIYoA40yYwYOU2dMuChU7fVjfe1MuZeIujBi8+XFM7BUMzFZLrpQtYZXxLZsr3MfWgYUiuAUAy8xjaz5Z19wu1gcM3LudBTwx5jn+KxuGtIv0clNNBXw3OtmDfBvbJQpOp050F92H8ONfRKPTRzSlJTlmZQQ/A3pGPpmtwZTwYD5UHIgg0GqbI8RybwoVj3ICFH2fOr0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(376002)(39860400002)(136003)(346002)(451199015)(36840700001)(40470700004)(46966006)(36860700001)(478600001)(6666004)(2906002)(86362001)(40480700001)(36756003)(40460700003)(82740400003)(82310400005)(81166007)(16526019)(83380400001)(356005)(47076005)(426003)(1076003)(2616005)(336012)(41300700001)(316002)(8676002)(70206006)(70586007)(4326008)(26005)(6916009)(7696005)(186003)(5660300002)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2022 16:22:03.7851 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c8291ba-b010-4114-40b3-08dad86f2d42
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0000E653.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7307
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

Only apply the static threshold for Stoney and Carrizo.
This hardware has certain requirements that don't allow
mixing of GTT and VRAM.  Newer asics do not have these
requirements so we should be able to be more flexible
with where buffers end up.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 919bbea2e3ac..2df55cc7e07f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -1506,7 +1506,8 @@ u64 amdgpu_bo_gpu_offset_no_check(struct amdgpu_bo *bo)
 uint32_t amdgpu_bo_get_preferred_domain(struct amdgpu_device *adev,
 					    uint32_t domain)
 {
-	if (domain == (AMDGPU_GEM_DOMAIN_VRAM | AMDGPU_GEM_DOMAIN_GTT)) {
+	if ((domain == (AMDGPU_GEM_DOMAIN_VRAM | AMDGPU_GEM_DOMAIN_GTT)) &&
+	    ((adev->asic_type == CHIP_CARRIZO) || (adev->asic_type == CHIP_STONEY))) {
 		domain = AMDGPU_GEM_DOMAIN_VRAM;
 		if (adev->gmc.real_vram_size <= AMDGPU_SG_THRESHOLD)
 			domain = AMDGPU_GEM_DOMAIN_GTT;
-- 
2.38.1

