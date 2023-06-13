Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77E3FEB64D7
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Jun 2023 16:42:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C218F10E3F3;
	Tue, 13 Jun 2023 16:42:12 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2081.outbound.protection.outlook.com [40.107.95.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FD6710E0DF
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Jun 2023 16:42:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BwHKboNcu0N2PdbJVz4uTBQSD9cIV9rnGkppySiL+SPFWFv7ck+TZvhy17VNVU+a1e6IUGCI3ToUsATlR98Svhqim1a1Slbvyrb1SgM+cKDY3OUIMm83hK/TbfbE3IiWOKjoypu7esFZLl8ZCTCDfv8mNDDuyVPI+pOvvGjOfWCULDnTfST4Ew7MCPdTcoEvt0ys9Pq1PuKC7/gNtsi5/fzbtoEVMR8t5gcPeryjQokj2yZUj8f11FsnXqSgiwbbog4+9jBN+cjtAzaamVe0a14Oxi2c21wONFwPStE++t0vda3t7dO7E16yHKpKg9K1p1E71NzutMj6OA2ZePMY9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2x5tqixepVRSUMJQ5KtD7WykBhEIfsgpseqNZZsoMEo=;
 b=hf6HjCMYV2lfzxoCifighjokTeuj/VZdGr8cpiblA9To6i10wjrc8C4aVT23Od/fblqZtEE04OVE0fcfPHTJYZXzdtDkiNh7KM5YT+Iti9ByqGxBlkZwFW52wHmHfbD4BNCJSWruLOk8mntj7KiEzQaJF6cvhIRRD8u3tu+Kvr1g478jDZIhlg5vviAKZ+8d2aCP76Ub3GXCPFVVOuC443/m0EiG0YtKHfYzVs341TNvXK+WVnX+3vz9DdwCFyy99EyO98z0ts7KjDlo+SgMI2Hi3ND50sKuB6BUEBBA0kPalPJfcLq9/FYJAQ0NZs3EyyHTME1lVDRyhDUreL0SrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2x5tqixepVRSUMJQ5KtD7WykBhEIfsgpseqNZZsoMEo=;
 b=yTuRhZAFNkY92hjVA+tDF4Lj9vjFc1oglnpqM6w3k1yweovlW9I/oqCAE4M2qwOEEQYdqEuOJXWHhKgPyTB6ReaFJUYAcjyU2sjJmhB/QwHyLgw0FIg2OEfv/ZNGd5V2V+iIud87MLxbLdKLHwkl/Y2XAXJWk7PFBjCO7bmGO9w=
Received: from SN7PR04CA0219.namprd04.prod.outlook.com (2603:10b6:806:127::14)
 by BN9PR12MB5337.namprd12.prod.outlook.com (2603:10b6:408:102::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.46; Tue, 13 Jun
 2023 16:42:07 +0000
Received: from SN1PEPF00026368.namprd02.prod.outlook.com
 (2603:10b6:806:127:cafe::27) by SN7PR04CA0219.outlook.office365.com
 (2603:10b6:806:127::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.35 via Frontend
 Transport; Tue, 13 Jun 2023 16:42:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00026368.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.23 via Frontend Transport; Tue, 13 Jun 2023 16:42:06 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 13 Jun
 2023 11:42:05 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amdgpu/pm: make mclk consistent for smu 13.0.7
Date: Tue, 13 Jun 2023 12:41:48 -0400
Message-ID: <20230613164148.2631132-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230613164148.2631132-1-alexander.deucher@amd.com>
References: <20230613164148.2631132-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026368:EE_|BN9PR12MB5337:EE_
X-MS-Office365-Filtering-Correlation-Id: a6298ee2-c651-4efd-af76-08db6c2d1fe0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pU8IzEiaX1s5gKny+v1zbwDmJXpqbbTtE/Jqjk6IlGBeNE5Elq0gMLXoDj7dP/QOoPmZF7lx+VHdjNQgC5KYI/uqzw8KXwM2HqjL3fXITv/+JIWApyDAnwD7aMfNb/ViQ1nORxMdT78iKvS8firwyPVtMrJ33puu1m14ly856FkTdB+6eH+L/U+WFc3MOWaplLSuZeLJktpus7Ux/35Aiw0M2lntRMiEHPr9PCoU01EuvvN74COP9QGx4IhssdgiGkBOY4Q6wxVCrkn5eqbo2izg+P3OqgGLCUsfww0tv5oScaoLt80Cd9BIX1kPL6FdrrkD0IMYDLsl+kz65Kd+nRjVlu39CCFDNh/yKs6srk304tMz4h/5A9eOeAftgICPvGslYVP0etB7TL5jrrQSWx63N1/3AHCMeGGunlSsccwi7kD8XwLXFu7m5/nWPhHu5GsiYT2TzpzAHTRmVefDzSHe3+nhUBUbegWMgXQeCEIsZmbql4LTOTQFYjLVegbfXBgMlTqPCY2vT2/+FbSIqm3tyjuwa/hLuBXZ4bVJ81ehBnMfrSQTtxmT0UoIEvizVZ40nVY6emutMb0BtzH5rrtMsbIp/y+nhNMZM6XIC4atMsUcnf4KYzHYnn5BVT0qoFS8acvOHfpHVotEf5BGudA6FoY+w7+MWyjqs6sEA9bYlXSYdW+ITAIyWbYYzC8gtd1U5Z0KzaUSUClt6uZeOwZi5Jy7Q1M+u6LMzGp4MOfs0XnkVoZuBbQnR/MW4eHBe6J612UODl9vHi9eHqr8CA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(346002)(39860400002)(396003)(376002)(451199021)(36840700001)(46966006)(40470700004)(82740400003)(40460700003)(6666004)(7696005)(478600001)(36860700001)(47076005)(186003)(426003)(26005)(336012)(1076003)(83380400001)(36756003)(16526019)(82310400005)(86362001)(2616005)(356005)(81166007)(40480700001)(5660300002)(8676002)(8936002)(316002)(41300700001)(2906002)(4744005)(4326008)(6916009)(70586007)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 16:42:06.6578 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6298ee2-c651-4efd-af76-08db6c2d1fe0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00026368.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5337
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

Use current uclk to be consistent with other dGPUs.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index cda4e818aab7..8eb8c30e6c69 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -949,7 +949,7 @@ static int smu_v13_0_7_read_sensor(struct smu_context *smu,
 		break;
 	case AMDGPU_PP_SENSOR_GFX_MCLK:
 		ret = smu_v13_0_7_get_smu_metrics_data(smu,
-						       METRICS_AVERAGE_UCLK,
+						       METRICS_CURR_UCLK,
 						       (uint32_t *)data);
 		*(uint32_t *)data *= 100;
 		*size = 4;
-- 
2.40.1

