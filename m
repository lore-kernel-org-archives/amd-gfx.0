Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E202C4828D
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Feb 2024 04:55:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C099A10E0D3;
	Wed,  7 Feb 2024 04:55:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qyfCt8yf";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2049.outbound.protection.outlook.com [40.107.237.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B27AD11310E
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Feb 2024 04:55:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L9hKdgfjeyQOV7CVv9cN3Ito8pYfOWovKK9f1JTQNia//AMaaQ5WYmzxvyS3gyXknS/mWQCLZeqXYcQsfFkDk4c+qU3kVnsA1rg6BIqQ6wFqQgXmfheW4wk/9/EgASaTYX+UIDppy9dzOaguZnUDNgZOLmFLUkivaxdJiXYpJKYbyt1/54hxN75uv8y0GLMGiyUlz5pM9EexV+5Frnv4L1Ph0t4ZonJOEw9FXoiq6YuKCXCpp+aVROseR9mKXqxOikeJWSlMspptjK8RT03JSCWm5T7sNlKrRAcJHV8+AiC2/fd5Kk7BZYB4JcM9XGCEr8GaEOnlQGdnRzCgbQJFZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=crfzzPv+diu1Y4AfnvpnAmOQvDBTgIBopO3t8IMKkRo=;
 b=T2A9qvmZ0KvRYAWJNVBAuoIGMKhT+tKQpyFpdMvD8wmMyj2S3xLdLDSZlsKMw6vbKjlOwgce3s8i0oIStCnRCWzJRVhMQho0zvJ3Ukh/UC51W/Os/Wn4yyjJieDQSHAkoMUgYB6J4STrajLq9apdA+vT9d9QuNI7rA0kXarmpOHKoT6O4q6BvAXVV3AS0OW2MCRtC12h87CZy66sJy4rwsnR4vrIg1V33UW2BOhY1m7OJW9PosUT1lR2sjs/UdWLF8Mu80NQ+wbUa4uDhEvp+8f7Ax37CI182WjE68wO51ErXt7S8Gk6BEQPiLBFR7jIVOY4iifEn3xPX8DISDDb7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=crfzzPv+diu1Y4AfnvpnAmOQvDBTgIBopO3t8IMKkRo=;
 b=qyfCt8yfSAIjuM8zHqL6oL5lMmhNSLfJGx5qX7izUINNh9AqmcmZcvSDR3QaqdVpmnWh/WsBfM9+2wxuiRBIkwBLPdn/VBTlMDRjNSCvEFG4GOBXyHWsawjuxKEGgjpiUpS0sGkd/m+2TDdycpQvGqZl1Ls8r1g+Yq7UmM1ZNpg=
Received: from SJ0PR03CA0233.namprd03.prod.outlook.com (2603:10b6:a03:39f::28)
 by PH0PR12MB7488.namprd12.prod.outlook.com (2603:10b6:510:1e9::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.15; Wed, 7 Feb
 2024 04:55:30 +0000
Received: from CO1PEPF000042A7.namprd03.prod.outlook.com
 (2603:10b6:a03:39f:cafe::26) by SJ0PR03CA0233.outlook.office365.com
 (2603:10b6:a03:39f::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36 via Frontend
 Transport; Wed, 7 Feb 2024 04:55:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042A7.mail.protection.outlook.com (10.167.243.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Wed, 7 Feb 2024 04:55:29 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 6 Feb 2024 22:55:27 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Wenjing Liu <wenjing.liu@amd.com>
Subject: [PATCH] drm/amd/display: Initialize 'wait_time_microsec' variable in
 link_dp_training_dpia.c
Date: Wed, 7 Feb 2024 10:25:01 +0530
Message-ID: <20240207045501.3344729-4-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240207045501.3344729-1-srinivasan.shanmugam@amd.com>
References: <20240207045501.3344729-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A7:EE_|PH0PR12MB7488:EE_
X-MS-Office365-Filtering-Correlation-Id: 807724b3-6909-4c96-5051-08dc27990239
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G/lZPYst5YKHF8O5nJfZa3yawL+KsWo/JIBABddcq+Rplm9TMgahssJr9lud0DgvSNCS3OnscVANuUtwV+BjrVs73OM+5bdkWzgs+qQX3lepVMg2uAIuZyLMjMvmmwaBlI+NEw7HxFw86O6q6OGUg00m5kdcBW2Joh59TtdROYK/PPWwhZRUHbJEimUwyEa7E+UqVyeh9DjyTqwDqhAD7f/rKcBbEXz8DAwOU+KCLOg2QeVc/DXinVS/taPSnZN/I+rQ+FefeZwPcZTeqYalBTE4qXayWP9BiJYH73jbgCrAGsfOpYVNPLUz/6xGNHel4qZyW1y3tFj5Zd/P0ukWNZU/AmelKNLF64BcchpeoFUwN4F4GtYghMyynXw2bUUIg8FbZwA0Voeh6EjXo8wbN+Tj88ofRi92Ng0kvCVRlotnRudppECmaE8R/zodFBeL8KE1CNj/4JrW4lu+MNM8EHy++QM6ntCJISiJy2t69scXZkzPVy2AdWMPFyADIkapuT9KdCLYk8dhrpDe9tlHRiii9g0bnVtnf16pfZCkZu9ic30Be4kqlLMAs01OVjaOwN/p09Uy0fInuDwAprMpRIsWAqo7BokShWOocKH+QSgj93kGOc/7u5y9FjbNHKY/XMya/Q1G4rUKxM7ORLGJbPKbDM6Ta6gQQSyvJdb5bqWS8K/jmRp4hARnwt6KrrWhqcXeBi5oK0+3ZPbBeMZugp8zhFpdM2jvPxKwI58wspay56QfRZf5REoj9G+zQ4qxUj6/z8vuMXmbOZji2omWjQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(396003)(346002)(39860400002)(136003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(82310400011)(46966006)(36840700001)(40470700004)(478600001)(1076003)(6666004)(36756003)(7696005)(2616005)(26005)(82740400003)(81166007)(36860700001)(426003)(41300700001)(356005)(83380400001)(86362001)(16526019)(47076005)(336012)(4326008)(8676002)(8936002)(40480700001)(2906002)(44832011)(5660300002)(40460700003)(316002)(70206006)(110136005)(70586007)(54906003)(6636002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2024 04:55:29.9151 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 807724b3-6909-4c96-5051-08dc27990239
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042A7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7488
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

wait_time_microsec = max(wait_time_microsec, (uint32_t)
DPIA_CLK_SYNC_DELAY);

Above line is trying to assign the maximum value between
'wait_time_microsec' and 'DPIA_CLK_SYNC_DELAY' to wait_time_microsec.
However, 'wait_time_microsec' has not been assigned a value before this
line, initialize 'wait_time_microsec' at the point of declaration.

Fixes the below:
drivers/gpu/drm/amd/amdgpu/../display/dc/link/protocols/link_dp_training_dpia.c:697 dpia_training_eq_non_transparent() error: uninitialized symbol 'wait_time_microsec'.

Fixes: 630168a97314 ("drm/amd/display: move dp link training logic to link_dp_training")
Cc: Wenjing Liu <wenjing.liu@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 .../drm/amd/display/dc/link/protocols/link_dp_training_dpia.c   | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_dpia.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_dpia.c
index e8dda44b23cb..5d36bab0029c 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_dpia.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_dpia.c
@@ -619,7 +619,7 @@ static enum link_training_result dpia_training_eq_non_transparent(
 	uint32_t retries_eq = 0;
 	enum dc_status status;
 	enum dc_dp_training_pattern tr_pattern;
-	uint32_t wait_time_microsec;
+	uint32_t wait_time_microsec = 0;
 	enum dc_lane_count lane_count = lt_settings->link_settings.lane_count;
 	union lane_align_status_updated dpcd_lane_status_updated = {0};
 	union lane_status dpcd_lane_status[LANE_COUNT_DP_MAX] = {0};
-- 
2.34.1

