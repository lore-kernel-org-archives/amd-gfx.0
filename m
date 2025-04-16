Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAB6EC369B1
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Apr 2025 05:32:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 757C810E832;
	Wed, 16 Apr 2025 05:32:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TZ8LsLGT";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2067.outbound.protection.outlook.com [40.107.237.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B40310E82F
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Apr 2025 05:32:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RpGAlG0f2zbPdW5sA1W4zP0IVoV3Di6yGWqQepriKqwMEojRJya1d0REdWrT44h5XihWktONO/8CsJRuE++/EF7wDfmZjWuC4UEtLbTjbOuA0Sn4UwCEb8cNKvf+6zSNFNqDgwZzGNub1DKUeHxxg6kzIu3BQueHcLcjwTYjTqeOVMgeqVBhbDQSA2xU7e1lqzjzoaA8uwzFQPZe/GQXnF8RVqhVYKUNV8bU7kNLhcq4d6IIPmcWKiRJ56wTZY9A7kTEvAz2qVgv+yWvgub4j74l7we29vOCrL8KWPQrVSxqm3z3YgiTyKH9g97Nodx5UZlO0NROZ0mgVd4eXtru3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7df0fNUvB56uaIh38gKu4j+VeISPAlRg0q29P+N5Iac=;
 b=ZhTGXDIKujOqgjS94EY0GJD2ZFa1MpoH6zOKpQ/fhWZYjzL+0eIz1+E4BASv0y5ewcJM1wOC7P7aFJ1mshVoo9mN2Lq2y5C6NDxCZtv+KkhrLnRGY9ksGmnR0lSGY4FyMgfvxAq58ZRRAyvr80sH3nWe4eXrrPrU6hjIjbLzdfiE9xHw3dV6FQzGqikv2a+zux3eW0Vde9ZzShl4yXkaZqXAFFNF1iopkAw5hpW39qcq0JfmE4Gi4hw5sAmpdt2gz44ZBbbeu6+BvjLL8fX4UJSG810Si51Ofs1IngMOhHlW0+Y6qqb6/FHVNxXokCDuwj0JHwSvqWCBodin9u2vng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7df0fNUvB56uaIh38gKu4j+VeISPAlRg0q29P+N5Iac=;
 b=TZ8LsLGTi4qK1s0c0yxJi23hofEOA7y4XCskHHDm5s43ImegAeFJHxnEhRXYe9g89Pdji5zMstq1AWmLBoFa2lY1G5rU585w5ZtnQHNU2sYgQNqS5a3FoNH1YZCwqIflYFuPHbm915SXvlMdH04yqktQc929JPkywqM/8TLQat4=
Received: from BYAPR01CA0036.prod.exchangelabs.com (2603:10b6:a02:80::49) by
 PH0PR12MB7815.namprd12.prod.outlook.com (2603:10b6:510:28a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Wed, 16 Apr
 2025 05:31:55 +0000
Received: from SJ1PEPF00002318.namprd03.prod.outlook.com
 (2603:10b6:a02:80:cafe::e5) by BYAPR01CA0036.outlook.office365.com
 (2603:10b6:a02:80::49) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.33 via Frontend Transport; Wed,
 16 Apr 2025 05:32:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002318.mail.protection.outlook.com (10.167.242.228) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Wed, 16 Apr 2025 05:31:55 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 16 Apr
 2025 00:31:52 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <lijo.lazar@amd.com>
CC: <hawking.zhang@amd.com>, <le.ma@amd.com>, <shiwu.zhang@amd.com>,
 <asad.kamal@amd.com>, <alexander.deucher@amd.com>
Subject: [PATCH v2 6/7] drm/amd/pm: Add voltage caps for smu_v13_0_6
Date: Wed, 16 Apr 2025 13:31:26 +0800
Message-ID: <20250416053127.377955-6-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250416053127.377955-1-asad.kamal@amd.com>
References: <20250416053127.377955-1-asad.kamal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002318:EE_|PH0PR12MB7815:EE_
X-MS-Office365-Filtering-Correlation-Id: d0d2f91f-f92a-44de-3b0a-08dd7ca80018
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?iJ33LF1Fb2tyEdmCKBCbdUwKVyvK/F1IJrjXQocQKtwkdMgqURoRHsfA1AHM?=
 =?us-ascii?Q?5RHhxKq9deZZas1MjkgPULR9kQuehsYSlPo+XY2RnidWUkKsr8YA3jdnCsmX?=
 =?us-ascii?Q?hs/VFefF87gdN803cunP4hIMINy/xklAQztphMzDEc7+bLpsEvpHEPjsEAqh?=
 =?us-ascii?Q?6EaJNu9I68lVSCrdRtsg0rFTJp/KKmxh1PNv2W7BdZiur/CyRJjnkXLA0cZr?=
 =?us-ascii?Q?nfIoSzYkF//S8iOMXHBZ541sW60opsyJ3cz7ui58+ZgcQTjDDvG3w6aRKwly?=
 =?us-ascii?Q?feRltDL9PFS2vH81K/rUn8m9eCsTQ9xLu7qcW/Q2aJgEa5zCj3cLDYGzpAnb?=
 =?us-ascii?Q?E1KHaQXjo0pln3DyMD4wIEzCKUhXl/i5tAZAkk42uazm9BtaMDF08tp7Du1V?=
 =?us-ascii?Q?6RCDEP0nAY27S+Fu4lT3OZzXfPOxTU8Kfx9894ExKqKS/U9ouNEzKjXcbJbv?=
 =?us-ascii?Q?XrqXLcF/peyvWPyZInpjOM2PI8eyAt3K2Fr4uTJNR/5tCnXrRdgXmyO8SHyr?=
 =?us-ascii?Q?TdQXlBJ8GvcTkafwCmR2pkgNNzJQKvr043S/h6k66shh4qgJBKrLT2zDLe5c?=
 =?us-ascii?Q?c4OuDA7ToUJk+MgaR3km/40wLnxHRRYpEdFqNnSchMUC0OOl4ZqO9Nnk+eFG?=
 =?us-ascii?Q?S2iAJR2EhQ/Rq61AsFAKaLgtxl7wwJ1si5D9mIbALXy+oGansLW4+ws5pDYm?=
 =?us-ascii?Q?ODfTe7XjE/+gUI31qVDA6XQ0nPjDATJKeMZeWWfzzZ63RRsOy5V8RBA2w88Q?=
 =?us-ascii?Q?LJFbqK7qVQbf5no1iT8zgowAiNpV2KiBQD6inputRuVD78MQ73ICFAntdg1f?=
 =?us-ascii?Q?w1MeEvYKn7jzTLmUkyJwRBuZwUOF3JAxzH4bpSg7lvhFcinBmIwf3pyCRbmD?=
 =?us-ascii?Q?Yopm/phkzb3L5zTH2l5lgUU1E+ZkHE2OFrMMt8k5k8AtC0I6jim9UmM2QIMc?=
 =?us-ascii?Q?RDp8Vy1PwDWbpCrs9a74n3m+j+OHRUw8E2RMfRvIbaC79WRayQqtFhTmgJW6?=
 =?us-ascii?Q?O49SI0Pr9YCFYiRYiE3LvNVRqqf1eXAHi8sFlMJyXVvzjiPx1gu1xhrdtUpt?=
 =?us-ascii?Q?eYNl9pjOel7KJ1EvZRMynCT1XyAmDUagYFJvUG0AnZ9A4C/saNy6RS5zixIC?=
 =?us-ascii?Q?X9giXc0SHxOFb200VUct9M3NGLIhk2/jMp4jneXn9iLbENAldL9N44A69KVW?=
 =?us-ascii?Q?7qYVswswfKbHEEV9tR9tERVQgcYRs9P8gEbT0krki9Ig1THOBsOsh5IW/KQN?=
 =?us-ascii?Q?3v18xg9be2rDC80ANHW4srzwDVpnluVslmEw/F6ljBaoDFjLMi2vzhO7xbj5?=
 =?us-ascii?Q?wQzjyt2TIww2mhl1o61ad3/uhw6w1E+77dx/aP/RGHlhrMndDvHbWWBc6BKh?=
 =?us-ascii?Q?oBJQ9RY7bRsaeCAYs+ZYk8a4kjn/OMM0TKYQfz4aG1n2lHtSxYG/pE42UDb8?=
 =?us-ascii?Q?0V8FuTUjKGekIeWNrBB2BkMszmR9IyWCJmBlL2eGMe3ZUoTOupbALB+rpHM4?=
 =?us-ascii?Q?/bEGFXF+vsctHk0d+Y6P8G73DQwLpLd6hVjL?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2025 05:31:55.3010 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d0d2f91f-f92a-44de-3b0a-08dd7ca80018
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002318.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7815
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

Add & enable board voltage caps for smu_v13_0_6

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 4 +++-
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index cbbeae9f05f9..4df35bc1a902 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -392,8 +392,10 @@ static void smu_v13_0_6_init_caps(struct smu_context *smu)
 		if ((pgm == 7 && fw_ver >= 0x7550E00) ||
 		    (pgm == 0 && fw_ver >= 0x00557E00))
 			smu_v13_0_6_cap_set(smu, SMU_CAP(HST_LIMIT_METRICS));
-		if (fw_ver >= 0x00557E00)
+		if (fw_ver >= 0x00557E00) {
 			smu_v13_0_6_cap_set(smu, SMU_CAP(STATIC_METRICS));
+			smu_v13_0_6_cap_set(smu, SMU_CAP(BOARD_VOLTAGE));
+		}
 	}
 	if (((pgm == 7) && (fw_ver >= 0x7550700)) ||
 	    ((pgm == 0) && (fw_ver >= 0x00557900)) ||
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
index c7a07aa5ef14..5313206ae4bb 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
@@ -66,6 +66,7 @@ enum smu_v13_0_6_caps {
 	SMU_CAP(SDMA_RESET),
 	SMU_CAP(STATIC_METRICS),
 	SMU_CAP(HST_LIMIT_METRICS),
+	SMU_CAP(BOARD_VOLTAGE),
 	SMU_CAP(ALL),
 };
 
-- 
2.46.0

