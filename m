Return-Path: <SRS0=gNHI=NR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0BE2C432BE
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Aug 2021 18:22:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 629C461004
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Aug 2021 18:22:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 629C461004
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B8B076E896;
	Thu, 26 Aug 2021 18:22:56 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2058.outbound.protection.outlook.com [40.107.92.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6DE66E896
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Aug 2021 18:22:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ErRJwfn8aZxkcdtMfVSt9/GjN13hpz5Hzw5fHSkjcwABltBIIz8CFaumXRmvDcakQZsYYiQxqvHm/8E0XvnEIFwLw7SpP/hUVtU2JDmiQKChuRSJRmZSvFkQ44A4PgphB1fFBshvgQCM/oqavYNqGbs2WcGAfik6y29z6lYOqosD44mW+hjZ+bEKYCeSlAPZJd9OqNwIrcDeKP5Q4OW1sT0NQQn6jx8ClRpXkehoIhMC77vicH1EYjYcCLTWnhMZTSBT0zqaewXe6NRjR8MOial3NNgFGrO1XIvL34zPvpwzc7fg0FRIgbmNdu9WmzcNrcgZfsvdjdZlqW6WVK9/Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5lCyAhvAeiQibG9UT2azNJf+IDoZi+nzwAE8DyBzR08=;
 b=n09oXW8riePxs/2dQlSJ9FtZMiKjYO8EOdCo+Osb+cvC1pYnRsemWvhflug0LRXd4C0IInydVXIpJVBnN0sUiAh4L5wt3etLUgyfzKF1YEiHcfAU62v0O4f3RNznoGV2RVuA6PQHmCiNqK+HPVBJnT7uGhOlJE4JBA3lyuycan9CyRgrEnqk763XcMkkT9Gawdgi3uu4sR6nrwIWHMlPP3AKdJMMD8VyohDflYLNMT8z3adZsAcqkLBr6/BX5N/Dd/j6MGIamkQxIKOd+pNwB4EsBNAtW3NWwKp6bIWUkqeHcUo34tGxvaP/hei23EkwIst1FEz96Crw46dCPLPG0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5lCyAhvAeiQibG9UT2azNJf+IDoZi+nzwAE8DyBzR08=;
 b=FFqbOwKeKftvaK/ME7W2de4p49kpoQO0jehEa+dwsEBoH4aRqRYyZ/P+KtNukWzeJMDJXy/0ihPze0fRKttkwQGqaHUJLB9iqsdh2xelf1QX86eewhOnhAa681/j5fmltxYVUZZBRARGsKByfP95diQ6GmDiQ/gP4mdne6gWSzk=
Received: from MW4PR04CA0208.namprd04.prod.outlook.com (2603:10b6:303:86::33)
 by BN9PR12MB5132.namprd12.prod.outlook.com (2603:10b6:408:119::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.23; Thu, 26 Aug
 2021 18:08:13 +0000
Received: from CO1NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:86:cafe::6c) by MW4PR04CA0208.outlook.office365.com
 (2603:10b6:303:86::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.19 via Frontend
 Transport; Thu, 26 Aug 2021 18:08:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT031.mail.protection.outlook.com (10.13.174.118) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4457.17 via Frontend Transport; Thu, 26 Aug 2021 18:08:13 +0000
Received: from ETHANOL-DEBUG-X.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Thu, 26 Aug
 2021 13:08:10 -0500
From: Rajib Mahapatra <rajib.mahapatra@amd.com>
To: Harry Wentland <harry.wentland@amd.com>, Nicholas Kazlauskas
 <nicholas.kazlauskas@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 <hersenxs.wu@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Rajib Mahapatra <rajib.mahapatra@amd.com>
Subject: [PATCH] drm/amd/display: Set the domain as GTT when VRAM size <= 32 MB
Date: Thu, 26 Aug 2021 23:37:54 +0530
Message-ID: <20210826180754.3193315-1-rajib.mahapatra@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2fd41a8f-2bee-43f5-89e3-08d968bc788f
X-MS-TrafficTypeDiagnostic: BN9PR12MB5132:
X-Microsoft-Antispam-PRVS: <BN9PR12MB5132B8E71AFEA831EB950A18F2C79@BN9PR12MB5132.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cz9nAKVSjztFPAcrfdVCXXunqaiw+CHRQx3XZw0dQD5r3d7YdDc1qsvrHXP8PrkfOe34e8E3qoEtMkGXixuwZP5jBiM/C27STplf5ibKuhN99A3XztpmiqThYx4e/vyAwXaLXICxP7v1qGu0JU2WYLqKI0PoAPCDX+DL5QpiXHHN7c5YlwTrVh1FmnE/JMkJ6ZkEeIKbrKGoHRG6VXvdvApa+bvs30W0kdTEzOWKkyo0Fv2l+VjJYCsX/aAJPQNcIgjY2csci7EdDJ2196SaFiDEM7cC3OPCAiYOhT+WHeUHzuNlY989jPRIPn6JnFbk7XiHsKQLf406UW2cx+yuGBboVOAY3yJJsXjwVrcXiagxFUr7RtTPbaifjq6VR0jKpAp1BerXBwW4qNeQJcq60vWsBhhmgKecZPMyCv7LjgXEKlNQHwFBQG4YKfreuiZsY67x0d4If87FL3tcKsit96qiSxyPg2v6Ge/YQJN+hk3Xqyoa0QqE+4fujxYhwjQ8uG2UvTrET6SZEvcGh0NPz/V85rN9u0qedrwluK62440MyL5JJ2a5/X1TnfeenGK+2/RL9sZYrVzVx8/iXmSSUy+Tg37FUY9kKAh2rMGq3mHIO4BhfVFVf/loEeWlINIaVY1xctpTXZUIhyWJPM9Jqrbq9xZJKMVdiWOK2royDtyHRs6IgvxZQqghapjEQJfN/Ntbdp/ThAgwE9bb0jQRaCsRHddtxPVd8ie+A6VYAeI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(346002)(136003)(396003)(46966006)(36840700001)(8676002)(336012)(7696005)(8936002)(426003)(16526019)(83380400001)(26005)(186003)(36756003)(1076003)(81166007)(36860700001)(6666004)(2616005)(4326008)(82310400003)(316002)(82740400003)(54906003)(110136005)(6636002)(356005)(70206006)(5660300002)(44832011)(2906002)(70586007)(86362001)(47076005)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2021 18:08:13.3919 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fd41a8f-2bee-43f5-89e3-08d968bc788f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5132
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

[Why]
In lower carve out (<= 32 MB) devices, it was unable to pin framebuffer in
VRAM domain for some BO allocations. The device shows below error logs and
sometimes it reboots too.

amdgpu 0000:02:00.0: amdgpu: 00000000d721431c pin failed
[drm:dm_plane_helper_prepare_fb] *ERROR* Failed to pin framebuffer with error -12

[How]
Place the domain as GTT when VRAM size <= 32 MB.

Signed-off-by: Rajib Mahapatra <rajib.mahapatra@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h               |  1 +
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 10 +++++++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index dc3c6b3a00e5..d719be448eec 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -236,6 +236,7 @@ extern int amdgpu_num_kcq;
 
 #define AMDGPU_VM_MAX_NUM_CTX			4096
 #define AMDGPU_SG_THRESHOLD			(256*1024*1024)
+#define AMDGPU_VRAM_MIN_THRESHOLD		(32*1024*1024)
 #define AMDGPU_DEFAULT_GTT_SIZE_MB		3072ULL /* 3GB by default */
 #define AMDGPU_WAIT_IDLE_TIMEOUT_IN_MS	        3000
 #define AMDGPU_MAX_USEC_TIMEOUT			100000	/* 100 ms */
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index e1e57e7465a7..f71391599be1 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -7106,8 +7106,16 @@ static int dm_plane_helper_prepare_fb(struct drm_plane *plane,
 		return r;
 	}
 
-	if (plane->type != DRM_PLANE_TYPE_CURSOR)
+	if (plane->type != DRM_PLANE_TYPE_CURSOR) {
 		domain = amdgpu_display_supported_domains(adev, rbo->flags);
+		/*
+		 * Handle devices with lower carve out.
+		 */
+		if (adev->gmc.real_vram_size <= AMDGPU_VRAM_MIN_THRESHOLD) {
+			domain |= (domain & AMDGPU_GEM_DOMAIN_GTT) ? domain :
+				   AMDGPU_GEM_DOMAIN_GTT;
+		}
+	}
 	else
 		domain = AMDGPU_GEM_DOMAIN_VRAM;
 
-- 
2.25.1

