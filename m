Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57FCAC77B7D
	for <amd-gfx@archiver.kernel.org>; Thu, 18 May 2023 12:21:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE56E10E51C;
	Thu, 18 May 2023 12:21:53 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on20613.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8b::613])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C813510E515
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 May 2023 12:21:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LFgbheKH0SjRyFDO5hGio8xHv9pA1oQw2veYiO8P7mvqulMAZxOceWdn6c+7djQ3sAIdb27O3NcH6ZCVi6ZuILtfiPBiu7EFOMcL8j++vG/75yNc1QlFryvUbqbMW/4rah8NghULIi1+4jfuEnS2xRDpswdBVB0RxGZ8dpcFjHGHXWbqd9b2xJC0n8pbcUyxPQI/3bC9BXpO/OK9B/qEzCZhpq6LpUzLGWK19owuXKlcVUg57EBt1tTQPNlmGhmHMIwaNGYU8toXt9mfMIBgfYaS/dzD69e8VRhL1ynjLbaBuiOGZnr/rhkn+dDJPAdLgVJMccpBypnXAMnC0O4MNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VBS51Cfe9OoKDeF7zGDBMp9KaYSzu6+ngJPEXhUsu68=;
 b=DMpehgQuvQT5/nn6ENu+ct9BjVW20m/u5jmTVrU2xLq/piKY0q1VJdbOd6rFlHWC3Hrr/mTFZklZreuZHWlBNsdUNBxscmNfTHqx4KHvfDfJgLD8YKrFV/MxytC6YDcxGaxuwehJjwzOpy3BoRrer6h+d1264ow1/9FJj5vNsV1n607tFpgEvNEAE8Jm1rrYclHyrFikMf7/n9clt0ZQ/jmgvHocSiUUvP/j6gxh8V1rz5bAdE5/OTTSaVm7XzgqKuzEHBsnNP2J8F6sUAk0kJn8CuQkjvxjkVdR1iOx5t6izt+ip/WywdkX4dIX0ZXM44BFMXnGrI6gR4get5ejXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VBS51Cfe9OoKDeF7zGDBMp9KaYSzu6+ngJPEXhUsu68=;
 b=LONUinnhOlkd4nh0vikWMrG+eJmIvSZrocfk/Iu8+u/ZDCeYxGVvwv5jETVijhH6MYhXVGeFKWoRtnMNwufZQfGlHJcf/FOsi5aPR4xxapja2hTrOR0TTERtsp0VNlu0WAabB/lY6abb1dqtY2n826y5WfQVmtHsK3757TzEK9E=
Received: from MW4PR03CA0025.namprd03.prod.outlook.com (2603:10b6:303:8f::30)
 by SJ0PR12MB5663.namprd12.prod.outlook.com (2603:10b6:a03:42a::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19; Thu, 18 May
 2023 12:21:47 +0000
Received: from CO1NAM11FT091.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8f:cafe::7e) by MW4PR03CA0025.outlook.office365.com
 (2603:10b6:303:8f::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.18 via Frontend
 Transport; Thu, 18 May 2023 12:21:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT091.mail.protection.outlook.com (10.13.175.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6411.19 via Frontend Transport; Thu, 18 May 2023 12:21:47 +0000
Received: from lnx-ci-node.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 18 May
 2023 07:21:45 -0500
From: Shiwu Zhang <shiwu.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 3/6] drm/amdgpu: skip pcie bar resizing for gfx_v9_4_3
Date: Thu, 18 May 2023 20:20:56 +0800
Message-ID: <20230518122059.28815-4-shiwu.zhang@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230518122059.28815-1-shiwu.zhang@amd.com>
References: <20230518122059.28815-1-shiwu.zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT091:EE_|SJ0PR12MB5663:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cf0dccb-fd06-4442-4037-08db579a7331
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zxTSLc9RUEkpMM19nksHkr2QE3z64JDQI2vrbw4d/LoLC3o3jf7aJbgHEUwbgJWso5XXcP6vruhPCBsoZ0zWbJk6ZiM5MzDa1eYgs5SjSkOeJFMqCjw+WBEmMDbZ7EXtG3Erca3f2FicWcqoC+Sudf8cesIiL3Rxbue0g2T+FhSOQp/eF51s6XykY83+x+hceVQq8R6J9duZlDcvp7ffBtO4gGiKPTkOQHTAGU0HTFVkCPOaZxbLJKKGH/ljEVdfdFUnQBkk0H3BVzZqcFkBeHHvCFhKr12MCi0uWcrR0lBUCqieTQWEObEe1VRYpAmRGcoC2HC7JcIRVldZnZcWdMZ0cnhh1pjbTXNUtCWJ7H69sciExSjROMf9qNGf8kHusBia414miuYPf8oj+CLFKSx4UyEGX5UyYUGYtAO0dv9yEgip9xrJ79/B8ZOoTdrQdgs3RFZAJsyB8RAqYKsYXJa6chEEPmmK1XtKdXKMsi3wSiPCCZjH7jmDlDHX/VRNS3vYdoWAWdtPRkEQwsPtDiErRIYGRB5WK0fa2m/A4YX4KgROINgQXAoPxCONigM6QuRBUSAczShD16fg0xAMajmUZFS8PI27rpJUN5hs95qhZ1ZoyFP2IdVYg/7Y4A3GqSMVyoX90WkOzwgTghKF9cJUrjL5ItXRm3h6+SjVU1t5TqINvxxS24tVFjpoTazZLRAzNJbSQ2wJwtkD7qZhN6V0buA4RN4seJXLQEOZLhINs2aMLaD+d607p0Spk1f3uS+Px8ZG3moRLfjfwf+PMg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(136003)(39860400002)(376002)(346002)(451199021)(40470700004)(36840700001)(46966006)(4744005)(316002)(2906002)(478600001)(41300700001)(8936002)(8676002)(6916009)(44832011)(6666004)(70206006)(70586007)(5660300002)(7696005)(1076003)(26005)(40460700003)(82740400003)(356005)(186003)(16526019)(81166007)(2616005)(83380400001)(336012)(40480700001)(47076005)(36860700001)(36756003)(82310400005)(86362001)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2023 12:21:47.0838 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cf0dccb-fd06-4442-4037-08db579a7331
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT091.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5663
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

This feature has not been verified yet so it is better to
skip it for current phase.

Signed-off-by: Shiwu Zhang <shiwu.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 3b6b80d784c6..4ec85c85c29c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1710,7 +1710,8 @@ static int gmc_v9_0_mc_init(struct amdgpu_device *adev)
 	adev->gmc.real_vram_size = adev->gmc.mc_vram_size;
 
 	if (!(adev->flags & AMD_IS_APU) &&
-	    !adev->gmc.xgmi.connected_to_cpu) {
+	    !adev->gmc.xgmi.connected_to_cpu &&
+	    !(adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 4, 3))) {
 		r = amdgpu_device_resize_fb_bar(adev);
 		if (r)
 			return r;
-- 
2.17.1

