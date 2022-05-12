Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC748C433FE
	for <amd-gfx@archiver.kernel.org>; Thu, 12 May 2022 03:23:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CB7810F11E;
	Thu, 12 May 2022 03:23:13 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2086.outbound.protection.outlook.com [40.107.100.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1350F10F12F
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 May 2022 03:23:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d1VHANonai3f9FDhIgMP8suA6qQUb855lyzvtfsA+RO8KjtLthPPqjpLNnV6q97PHqdYa517+lOUQQlFM1P+cWclKcHzh1SHX+HscK7MgPtFa3/TdoC7GCiXXBvDIn2RaLQtlO8JthiNcLqnxjIRKFgOtr1h388zKIchpHYkUu158Vh4JrsdfENyJZmIQ2IGrlzLu7wBdNVJ2Q2r9pIL2qOWcb0+I/VfyxS9m7mNm6M06S0gj1TOqZ6S4K5S/s11F+n90xkFabpvOTS7QmcqIetFQ1eS0FUsvN6eFtds6V7YCm+ZUwTLM2jp1nCGlt469z1kUWeLUameXHGb5yn6WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NGzB8GE0sYkID5xvKW+qFaebmzg8eSNzYEC9lGnT8Hk=;
 b=KQzCZ8EV3yEvLh1r/hMop9Ra4QHe7Dw0arMrOLulY7JqIuQoeS7cmI0wy7OC3jmWok+JEvD9BlSZCmccwq02dH5QqTyriPIqKAX7J7/vTGRXmTTkClUowCse6Ht+DxtuZIcdxUV3QmI08B5loWx3zyCo6nJbDLVDKBqLYyO2Ky0Li2L4OfVQiNj70NHl5tVHZg1UbmomWa+URPWLURR0bChs5OLICmbBveNux0icXvogePrAAq6PxX5xyHTxPMdHJFzgxNdD4VmzDj4qmTuox1EqfO2iaKZgAxSwR26uxthWJvcLVmsvegFQt4VbLEvC05mXCencZaYtfGQUlZ9QSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NGzB8GE0sYkID5xvKW+qFaebmzg8eSNzYEC9lGnT8Hk=;
 b=YyH24K4RSvEn3JzM3eknEgZP7MkTkpoBAq/AR6sEXMGFla04r2uXGlJ3mZxHoTORsJa7kcJo7hIG4QlVHpW5mRt2YJGIJXJx7LyR9L/XdxnNwuuJbmEcHPBxwHZcQwpB+jYyXD3PHJXmk4uWh38VWTyIinbaQWKeBbbICOVeItI=
Received: from DM6PR11CA0065.namprd11.prod.outlook.com (2603:10b6:5:14c::42)
 by SJ0PR12MB5673.namprd12.prod.outlook.com (2603:10b6:a03:42b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Thu, 12 May
 2022 03:23:06 +0000
Received: from DM6NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:14c:cafe::23) by DM6PR11CA0065.outlook.office365.com
 (2603:10b6:5:14c::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13 via Frontend
 Transport; Thu, 12 May 2022 03:23:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT037.mail.protection.outlook.com (10.13.172.122) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5250.13 via Frontend Transport; Thu, 12 May 2022 03:23:05 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 11 May
 2022 22:23:04 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 5/8] drm/amdgpu/pm: enable swsmu for SMU IP v13.0.4
Date: Wed, 11 May 2022 23:22:44 -0400
Message-ID: <20220512032247.528556-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220512032247.528556-1-alexander.deucher@amd.com>
References: <20220512032247.528556-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 49f06a1e-ac03-4f26-0d93-08da33c6bad1
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5673:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR12MB5673C667603A50BF53576FD1F7CB9@SJ0PR12MB5673.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4Cz4gKXIodyFJK5zd35zDzRt1B3/Y7h47Vs9kmjDGrkCiR0YXjXh4y6+lAO0HtTkA0VeHmgxd1Qy8afedHkF5DfcIU9PIYbXRR9m7nnIVtcgOUFw8aibJCZ3zCJq8c3ERNHnwLC/dyfH6FP/ejl7vc6EuDdlocuKpritDIvBUGTtfTbZCQxOkUKkoppNJPRWOXfkBMi2REFpTlUhZsMzs5a5Wk7ia2pt1OrFGDjhk45N5bgrn31kA+bPfXYSHBUaAdIL9wplLp6qbi0sRil6mRIBc8byTqqGEwrHquM9SHhS8Zb3EN393xCA5km7v6ExAwCTu6PhGOmFAPgovRyqUy+YqjxpEfdlvS0UHvD7Ud9SPZGZBfmc+AP9qdZlP8eTNtv08rSPx/LZYuOWvc5jfJp25XITWZZhuOJA7gnwx3+PDLqAUwF2I973QhMfOCotKt4NweuBTFz4ChJCuMKQi6scJSy7mtlrJ2KVusaezI7wv4xN4xmGk/McCa1ZHkKHFzcH+zrDmMfGssVII8jCwjQD38/BAqfwoVzEjtHkBebIMGK+83E3/mczQNKAINyJKyuGwX+msfPw6ls99UD7hg6Rn/7P6I7mDnYfFRuinbk6zK1BKI1plVDJIBg3ciLEEMAYCfIIdgoXcSakWfuhOYQz+6D5+arunP1PEahv/ZKnubN6f8BM7LEQUy7wzz6GDjtKT+xK4s+SNM4+B9sz+A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(6666004)(508600001)(86362001)(7696005)(336012)(40460700003)(426003)(36860700001)(81166007)(1076003)(356005)(2616005)(26005)(47076005)(82310400005)(16526019)(186003)(36756003)(5660300002)(6916009)(54906003)(316002)(2906002)(8676002)(70206006)(4326008)(70586007)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2022 03:23:05.6056 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49f06a1e-ac03-4f26-0d93-08da33c6bad1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5673
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Tim Huang <tim.huang@amd.com>,
 Huang Rui <ray.huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Tim Huang <tim.huang@amd.com>

Add the entry to set the ppt functions for SMU IP v13.0.4.

Signed-off-by: Tim Huang <tim.huang@amd.com>
Reviewed-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 956062496202..ab32277f9108 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -38,6 +38,7 @@
 #include "yellow_carp_ppt.h"
 #include "cyan_skillfish_ppt.h"
 #include "smu_v13_0_0_ppt.h"
+#include "smu_v13_0_4_ppt.h"
 #include "smu_v13_0_5_ppt.h"
 #include "smu_v13_0_7_ppt.h"
 #include "amd_pcie.h"
@@ -550,6 +551,9 @@ static int smu_set_funcs(struct amdgpu_device *adev)
 	case IP_VERSION(13, 0, 8):
 		yellow_carp_set_ppt_funcs(smu);
 		break;
+	case IP_VERSION(13, 0, 4):
+		smu_v13_0_4_set_ppt_funcs(smu);
+		break;
 	case IP_VERSION(13, 0, 5):
 		smu_v13_0_5_set_ppt_funcs(smu);
 		break;
-- 
2.35.3

