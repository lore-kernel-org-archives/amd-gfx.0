Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15E7EC77B7A
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Jun 2023 14:31:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 82F7110E143;
	Thu,  1 Jun 2023 14:31:51 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2060d.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7ea9::60d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D42010E143
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Jun 2023 14:31:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ird5pp48emG0jQpissE9ts3jDz2/iExy9HqeXrZEachqp5IYMXMdOedx6tFk0b5VDOexiiFEsA2ZYzdbW2kVRbmtmHwKL5irG1Wb+UdGSv/zmYKv5lwbVa5h83I004iW379UTkocY3CA464GwkzNUxbpNNp5ghwEQu9sYhKZyBX1GpEQJWawwjhbd7I5NriNwMkNR9QgjhGnGNj5KY84Dsr717Pp0T/zr2lkA56zPjdh3Jxft1mk+VcRivszqvgatSUNOdqynHkhT5qpVKIGztS66Z1DDMNpv2bUa9sU0Wp7xf3v12DxPkhShftJi9MFlIQwP8CqmpHJmJjsJULD+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UKsxwF1yTwA50958dMfu5/XUOvilzScLEClFa7meR1c=;
 b=KiBr7WVlHu0Tm3BgAHc+agqD0jJbRXwny+cNDRBCCBOgtfFNL01SyOnSdL53saa5tmYR0V1d87N/Vv4xxUaT/+9w5B4QMkDHDKi8e8NXRKtGvsy6mv0Dowj6Aa/K9A0SfwRq+/ouDZdn2xL69H0JXOz6HScVpZwvFJPJt/hKJGMC5yIKYWjm8Kd7n85GJg13uu4a8GDBFQGp/3PQJzW6DwbklfsFVruv3UaV/kCltoxHoh6hsRjFEwAdEC4sA1f6pCKwx4HP/RPblaAmgszhaTm7LWwqXg5kV+qjU5sE75Ulq6QTxtW6m4dvQLRm1xG4MKPE0EgPuYfgJqGHdBRJrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UKsxwF1yTwA50958dMfu5/XUOvilzScLEClFa7meR1c=;
 b=UVDBN7Bm2B3b+bbx75aL/nonc2ymdY1ONcQnLAN9tkG2q7x9LDUSvX4xwHAIQfXv5IyXnm2zom752ajUAUXORWoyNaYSSS/7r8qe3LbQkoguhWDSDoVHs2FftGNEGEcsKOh6RfNp6d9iTmphFEFHxGCKKynXGTnDQOQn0Pwms2I=
Received: from SJ0PR13CA0144.namprd13.prod.outlook.com (2603:10b6:a03:2c6::29)
 by DM6PR12MB4451.namprd12.prod.outlook.com (2603:10b6:5:2ab::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22; Thu, 1 Jun
 2023 14:31:46 +0000
Received: from DM6NAM11FT097.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:2c6:cafe::8f) by SJ0PR13CA0144.outlook.office365.com
 (2603:10b6:a03:2c6::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22 via Frontend
 Transport; Thu, 1 Jun 2023 14:31:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT097.mail.protection.outlook.com (10.13.172.72) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.23 via Frontend Transport; Thu, 1 Jun 2023 14:31:46 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 1 Jun
 2023 09:31:45 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 1 Jun
 2023 09:31:45 -0500
Received: from hawzhang-System-Product-Next-Generation.amd.com
 (10.180.168.240) by SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP
 Server id 15.1.2375.34 via Frontend Transport; Thu, 1 Jun 2023 09:31:44 -0500
From: Hawking Zhang <Hawking.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: Fix power context allocation in SMU13
Date: Thu, 1 Jun 2023 22:31:37 +0800
Message-ID: <20230601143137.8633-1-Hawking.Zhang@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT097:EE_|DM6PR12MB4451:EE_
X-MS-Office365-Filtering-Correlation-Id: 081bb2a7-9a0f-4e3b-dfdd-08db62aced9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kB3F/FOIAYsSIV4bDL22iAUCOfAMpJykCTjQPujgF10IjTWSrVfABgNXKZ96bJdNsvcxI4GCmYWwsnt6yy0cK3xyE5xSFKfY+LOnuho/3tfK1LBus5b3EeF4OeqSPdJoPPWqOm5yZcBFnIok+78c1KzOXS3ub1hlCVZMbvTfJWCRRK1zYaqdKmhyymemmyXOfChCum9AFzW1g+CvBaA87YVSqrtdgxdDNlPwZxG2X2vhUtL468zcOZne546T1KWw/qN5rV0mZu+8w+3BP70BJtOtpGKNS1dMfmbDP6FSGhqRhAhYlXbO7yS5ILI8k4wuArQnSD92dFcI6u/fn7fxh6vTjgA8VSLLizQJ5Vly37TuznaV1IApTVu+6IKC/k3A+xBZvmaoCeF44Q1y1JJnHVanDEQGDHGxPCnNKihSfRu01kKoiFeTeccR8FIQg5PmA2N2oSF6DyNnyg3mHw3XpJC47aJHLEa9+Xs6g2UsD2/yKW0HRjGPgKmlGn8IqoHIWRyDZ/d/Xc+cesS5HgqF8qKDUTIt4kRmsWtKVSH7G0Kdo7ob7+RVnNEupIFv2aF1oFUApLbX25gvQ7mDLUmnWfM83dJvGABk5bYCkoqW/kS0m70IXXKtzzy68R98kp7OXac4J1dnRlb5nUxjJsvGc3pbXrATnFmKKhWagfbmvLKVYxcWCFu8VyGNoUy+VkbWZ9mg9agOi3HcJ0rIwdXyuMdJJqy7fjCGxVHB3Xv2PgS4LjAOJJw7wlhZu/B3TBeXw2buwZ4pF9UE7WI5YKT/lQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(39860400002)(346002)(136003)(396003)(451199021)(46966006)(36840700001)(40470700004)(82310400005)(316002)(356005)(1076003)(81166007)(186003)(7696005)(40480700001)(82740400003)(8676002)(41300700001)(40460700003)(6666004)(5660300002)(26005)(8936002)(83380400001)(47076005)(36756003)(36860700001)(2906002)(6916009)(70586007)(70206006)(54906003)(2616005)(4326008)(86362001)(336012)(478600001)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 14:31:46.2406 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 081bb2a7-9a0f-4e3b-dfdd-08db62aced9d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT097.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4451
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
Cc: Lijo Lazar <lijo.lazar@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lijo Lazar <lijo.lazar@amd.com>

Use the right data structure for allocation.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index da059b02a153..09ac66ab9c34 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -534,11 +534,11 @@ int smu_v13_0_init_power(struct smu_context *smu)
 	if (smu_power->power_context || smu_power->power_context_size != 0)
 		return -EINVAL;
 
-	smu_power->power_context = kzalloc(sizeof(struct smu_13_0_dpm_context),
+	smu_power->power_context = kzalloc(sizeof(struct smu_13_0_power_context),
 					   GFP_KERNEL);
 	if (!smu_power->power_context)
 		return -ENOMEM;
-	smu_power->power_context_size = sizeof(struct smu_13_0_dpm_context);
+	smu_power->power_context_size = sizeof(struct smu_13_0_power_context);
 
 	return 0;
 }
-- 
2.17.1

