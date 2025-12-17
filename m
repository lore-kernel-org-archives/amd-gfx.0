Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEB56D65C72
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Dec 2025 15:42:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 64EA010ED01;
	Wed, 17 Dec 2025 15:42:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JFg6/Bb+";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010044.outbound.protection.outlook.com
 [52.101.193.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2528C10ECB4
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Dec 2025 15:42:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TJQAQJ3mU3KJz3iUQ7leh5bBMvomZCsb57REjn9NpHSwHD+7JjONLXC1mkCBjDZBNBo6ZgX+mN+ifAm278xsw8xFkXhujgVnUhLT8r/thT6iTg5IALJTMUM9BJpZ76P8bDIE5BhxX+/PF9V5en/umT3zOLooBW/acCwnhrVH2k/pT5uvgdr2tM5tObzjCDcrSsTlXMKzEyKzetF4kgkK1UU+Ge8QjcHAHeIFVSfK0L8k+PHdIit7JkmzfqDgDYCZdpDL45U+Aft4VkvWyneRkOT1kbpaCHUdvc4AXWSEWgFSpAV6Uljf8W8fBb/T3jChtKtYtt3H4VMC+E65Rqc7CQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fgjT1jxNO6c0Vrcm8zFtfM682UZZBMJXEQREpjkm1o8=;
 b=efS8EDeD2hCTmJWT9s1StGHFtCkix2zC5wwaPeWkrhHV3PLEBR81JyRJQi0BLCozXB6moYINcoX4ir5WuDJup3I4lglPbk4WbXGPYT96dB8jP82cLOqgyn91gpFEYpOUZr/gw5S0/mxAmC4DqryUC2fTeSBF/r4Or93lHWUvIq6/QfyrvmbftRHp8a9zFCWUesx5BGiCv/cjtWhGfY8tYkGXX8dowVK6ocXPY2D5f7PRQ7GGiKPBPI0fuck8CmfYu4iDMsApYSqUyt81sitLvAHWCEtwO7nY7d/1y0ANUu0J3ppSJrphsz1DjNRmKcVhTJlUCXev84D7lVEbLhLISw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fgjT1jxNO6c0Vrcm8zFtfM682UZZBMJXEQREpjkm1o8=;
 b=JFg6/Bb+5swY1feFwCp6FByxrEVjgx0B2sKOBoO8xFE4OvBhDYD+hygmgCjZtLzpmpnrb53RW06tvwVT55FOJmrNZVW0IgeC5v3AwZTsE1iaI7OoEx1KFZ4mHIk3zASPuDaF4BHH0OtUhMHEtRTA9EDvO5dXYZhM3vCzozEL0ns=
Received: from SJ0PR13CA0092.namprd13.prod.outlook.com (2603:10b6:a03:2c5::7)
 by MN0PR12MB6294.namprd12.prod.outlook.com (2603:10b6:208:3c1::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 15:42:15 +0000
Received: from SJ1PEPF000023D7.namprd21.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::f3) by SJ0PR13CA0092.outlook.office365.com
 (2603:10b6:a03:2c5::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.6 via Frontend Transport; Wed,
 17 Dec 2025 15:42:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023D7.mail.protection.outlook.com (10.167.244.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9456.0 via Frontend Transport; Wed, 17 Dec 2025 15:42:13 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 17 Dec
 2025 09:42:04 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 3/3] drm/amdgpu: Skip SMU init for backdoor loading
Date: Wed, 17 Dec 2025 10:41:51 -0500
Message-ID: <20251217154151.2018978-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251217154151.2018978-1-alexander.deucher@amd.com>
References: <20251217154151.2018978-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D7:EE_|MN0PR12MB6294:EE_
X-MS-Office365-Filtering-Correlation-Id: 760ccab4-82dc-4592-6071-08de3d82d9a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?//wqAXQKL2Y0lLLIuxWgxF+smkXZoB0vJWlf89EEA9Zr7wcR84eJMUI/h4Cq?=
 =?us-ascii?Q?jEyUgrckBFZeK572wjwz+xNdkf/kwF3gXpqqvN4ervtUem5IJutlxGkA3+Au?=
 =?us-ascii?Q?0l7zbhfQlLeNJJrKkPQv+Mpwx/CUwTkm3aXN+MeRphE5uGVDyBUEiaCksz4T?=
 =?us-ascii?Q?zK8toYJLJRnwlQviSZvfh4onYzFOx46GcmWNlOj0lM3wtitTHCDrHThQZYzu?=
 =?us-ascii?Q?6blyGuDClxW0FSFHjyQTI2CcfSd6ayhBZCGYisDP5ltplHBX1NvPIvA44VkR?=
 =?us-ascii?Q?daXeWZOW6F6RZTYVebIIo531sdbFyY2tIjFB4Vu+7A1SVB5q6um1TwQtXzqJ?=
 =?us-ascii?Q?KzyHBQXWSRrjUcijWt2CvUb2iRcIu6Vm10IUsfWMd8fhAN5Jas6C2yz2bHvR?=
 =?us-ascii?Q?mCjhJxRVvk9nefVnJyiQpga8bU1w8GBvCN3Id49uaPbx5sfhztOdtPjzmpiT?=
 =?us-ascii?Q?sEhRt/iUiMOU2wkXwSvnrReZ9opWhRqsO+ZIM2w5SDDB/iRMdbf19Z0qCcAu?=
 =?us-ascii?Q?GpmObK+4tt4plM8RdtRJkG//aWzM3Cwma1XgniLs49FfWYAqcEAy6CFEdP9q?=
 =?us-ascii?Q?kW9Oeapt0ZsJ5sDTWN4885FyR3bawFw1PC1MFA04hJGXUaLFxE+ey7N9Rd06?=
 =?us-ascii?Q?aIQW/L6s9C7uqujzALlew3vuz7u6dtSrw2akwYgsyDUbkBPUTvp7awAcBwng?=
 =?us-ascii?Q?zUP08qmaAo3bZsmSHTOdThYwoC0p8ibRN88gVO0BRMqnRrbUqhiQH/26Vtnw?=
 =?us-ascii?Q?68mVqno7Iaof9UQ9Shmgq6LpFg34Rr5pSECPJc03gFXTx4eDOdJSUUizNMxK?=
 =?us-ascii?Q?r4Hd+G+Z59j68PB3gdFgBtmNnCpY8dL1cXSgG+QIehWKepuT92FU/TV5gjED?=
 =?us-ascii?Q?x3dx96Irg34c9RG71czS9Q+iNnSISSB99mN1qf/0yXgJ8SQW+aERU1Sj95Np?=
 =?us-ascii?Q?txD6RmjXeWsJBWtyuPV7OstpbRbZL2rOWepcF/hhiX5JtaBLI5QlNyYHY0hc?=
 =?us-ascii?Q?KAn6T03xq5I6fxjVo9U08xRD2F18onMClnlmj5ylL/rtYJY0bQf9gAdxaoXv?=
 =?us-ascii?Q?gNEd16/d+U9qnUq2WiXXvvqqCxb+SAZ/ul2JvVNf2HSWEtTbQbsliIbeHtIq?=
 =?us-ascii?Q?yjp6l625g8CbTYGt/NG3Y2c/dp31ohbb+FSnCdnI3wOTFUBNoq6vruFWccv9?=
 =?us-ascii?Q?a7foKGJA1ppIL5IanT7p+YlK6CDyI+TV6M9rZ/qlo9+nG3EQHjJsJQT4MO+A?=
 =?us-ascii?Q?spZw6DHRixHGx2CzmtbfsNo/cRvj3oi7PRkUBRG0txPkYF31NrFiGaWBQaZ2?=
 =?us-ascii?Q?z2vS17330RFSVCQ4elxvGwuZSpiQUwX8pGDkZtFeT+zHqZw61nSIv22r3eoB?=
 =?us-ascii?Q?7AnlHvZpGnOZUM5Pg/0WgyWUH/eM7J324n8mb0o6TUGUeJY117YJWMW/VzMW?=
 =?us-ascii?Q?K50Z4ZLIYQwzeRGpB4kNSri32mZP3VSQa0t3rcA54heGrIEyGZWMpCmQzPBZ?=
 =?us-ascii?Q?aB3c69gkQkgzvaw8YHFhyMpS49BBFAhjD8BAWGR14i1eXedsnoE4vkKO+veo?=
 =?us-ascii?Q?XqGMMF9G7AksiTeVOHU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 15:42:13.8322 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 760ccab4-82dc-4592-6071-08de3d82d9a4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D7.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6294
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

From: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>

Handle backdoor firmware loading in smu init.

Signed-off-by: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index b7dfd98d387d3..6ff593dd163da 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1921,7 +1921,10 @@ static int smu_hw_init(struct amdgpu_ip_block *ip_block)
 		smu->pm_enabled = false;
 		return 0;
 	}
-
+	if (adev->firmware.load_type != AMDGPU_FW_LOAD_PSP) {
+		dev_info(adev->dev, "Do minimal SMU init for backdoor loading case\n");
+		return 0;
+	}
 	ret = smu_start_smc_engine(smu);
 	if (ret) {
 		dev_err(adev->dev, "SMC engine is not correctly up!\n");
-- 
2.52.0

