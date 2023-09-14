Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBB25EEAA5D
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Sep 2023 18:22:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A449810E2AE;
	Thu, 14 Sep 2023 18:22:31 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20626.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::626])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F55210E2AC
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Sep 2023 18:22:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M2SBe5bo8BdxQIRrGSmmFoUvx/dAUHi9nV8yXqPZoDAxMnnkkKN8XcqH6h9kImSjjjiGY78yD/s2jwZ4/N59d7S3+BVCuN3UIBSkbz4aFu0eeoYYu1w6dn7LWgEGHi86IPk5xnGQugqjkFWYLVu6Ecc51qlmwY5SJWzAc+TZc4+Pa9WaW0MYiv2ZWiYuH8g6LgWX0cj6/26XbwNELmWIYWbe4sf+IRqjfJ1jMirn/qE6NwlU72rpHri46cx5g476clVRGuZ+f9sKCJ77FFLbQbUPdM0AtKIhlWkOtZLapGksl87t9PUuWWnE1RZAke5sX+TQMGXZxaLPwB7xZNORwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W8gfENjH5zMNSTf7hZUr8EVGd5852V2pqRmepos2RVU=;
 b=lzJbqEWRdcsaOMwjMsje26bClSU9xuXN4nla3Wy+6KqhZD3/6mN61+CesGZ0S8BmJTIcQOD+gmi/fvWgPJC4jwJpOouXNAih58TYINVhdc3DAXSZQvAShyfJFti+1IZN4T3A+0jovSJZ7UzEp5NjRIQzkN7c7URRsT6wbmt6kAoC9H7Oln0i9qno1PT0GiFnH/eaujM/xE0M4cYoDzaR7Zy6EH7apmiJqOB6oEkEBfoHaFUXXuWHgLvhBB3f162z8hHPmqTAp2tfADuuhsumCrm3jetpRsMh3xSQp2eF50UL9Xxxkb9Cr8mDHnpMGwJu9jDxN+9p1ltbDUOh/0bRmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W8gfENjH5zMNSTf7hZUr8EVGd5852V2pqRmepos2RVU=;
 b=CtqmYymGzapmOOrjGIsPB39byPLkkLBDRk14icfTLnuLFd/82kP8oj70hZoNL+mXtjcvyhVHIRH6khJiw5/e4WWLiQmBZXhStgxNxC3klu6wWzBwDXaef4md+cS92Zh1Wq7L82fVyu2a94UsuX3XMn/4TLfSdSemp/6mbwo5v9s=
Received: from CH0PR04CA0063.namprd04.prod.outlook.com (2603:10b6:610:74::8)
 by IA0PR12MB8424.namprd12.prod.outlook.com (2603:10b6:208:40c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35; Thu, 14 Sep
 2023 18:22:25 +0000
Received: from DS3PEPF000099DA.namprd04.prod.outlook.com
 (2603:10b6:610:74:cafe::a0) by CH0PR04CA0063.outlook.office365.com
 (2603:10b6:610:74::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20 via Frontend
 Transport; Thu, 14 Sep 2023 18:22:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DA.mail.protection.outlook.com (10.167.17.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Thu, 14 Sep 2023 18:22:25 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 14 Sep
 2023 13:22:24 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/4] drm/amdgpu/gmc11: set gart placement GC11
Date: Thu, 14 Sep 2023 14:21:58 -0400
Message-ID: <20230914182200.679059-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230914182200.679059-1-alexander.deucher@amd.com>
References: <20230914182200.679059-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DA:EE_|IA0PR12MB8424:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f6f01e3-518c-466b-2744-08dbb54f8bb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PtCJhNKhH+8GGXl0XbfsCqdQs9/xYULrdF3/VcrK1ESfwvyRBUnqUrRoyenU/Akjh1dgv4W0A5eNLeNl2KRE7QcyBW9bz4154WSuMMg2om5bWZnH/G6kwNmZxitL7Yn3oRuC7zPDPnFhZy09U55rrISwAJP8CV2WKmfRfqnFR+G1vyXqbLZp9GkfuSBO5ubj0pWgsq+4Zeef7EY1mZj73c4acpa7HT+fSR4QSuti8ElbKb4N8U5KqDCECkTyVQhbutXBxV1IufP26oOLna6Gx/vEW9dSeqEdK5tDVJK0D186mNpmcJHszIUtZKVrePmpTE6e6/W44WxfowoGeJh7cGFfAc4gD0DAf54EknXtATsdmi1XAUqiMb2/ZAXidBpsBe4nPbK08At45+yXwz1UH32hW2oaPpPizmI+hw/1BdND4s5hoWci9kaxOD3Gu5MY8BFA+g8gm+gdpS2rufFRFE7rLKLMyHatvX0EpvH60RGuq3NDGlHIoeJdMzsi8/ZuSRPai4lXKNABINfzhaehyE3neQvwD4In7YAPq6h8TC9aUliD1zXabd5rkdxJxO1ozBKJW7ho8mM5Byy/a0Op8plzfmq8v4HLHM7BRd9LmIXv127ydlOGs427jCECKO5nUe7w7UNxqmVKZAmanG7d0+VRFEIxdJ2xUR0Jl12nFweC+L832+e7bw3ltckW9WvMrunZ0kocBwe2oylbMk8qb35TvwcF5uMg1jXCfDqL58wisSli+s0lbttHH5Sf2QmVFCZ5bNM6aitEU0XHqpdNUg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(376002)(396003)(136003)(346002)(1800799009)(82310400011)(451199024)(186009)(36840700001)(40470700004)(46966006)(356005)(6666004)(7696005)(2906002)(478600001)(36756003)(2616005)(5660300002)(4744005)(16526019)(41300700001)(426003)(316002)(6916009)(70206006)(70586007)(336012)(4326008)(8676002)(8936002)(81166007)(82740400003)(40480700001)(36860700001)(40460700003)(47076005)(26005)(86362001)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 18:22:25.3224 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f6f01e3-518c-466b-2744-08dbb54f8bb5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8424
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

Needed to avoid a hardware issue.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index e1f47f9c1881..6947b598e9b2 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -740,6 +740,12 @@ static int gmc_v11_0_mc_init(struct amdgpu_device *adev)
 	else
 		adev->gmc.gart_size = (u64)amdgpu_gart_size << 20;
 
+	/* force GART to avoid a hw issue in GC11 */
+	if (adev->flags & AMD_IS_APU)
+		adev->gmc.gart_placement = AMDGPU_GART_PLACEMENT_LOW;
+	else
+		adev->gmc.gart_placement = AMDGPU_GART_PLACEMENT_HIGH;
+
 	gmc_v11_0_vram_gtt_location(adev, &adev->gmc);
 
 	return 0;
-- 
2.41.0

