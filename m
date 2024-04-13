Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC3C2C4345F
	for <amd-gfx@archiver.kernel.org>; Sat, 13 Apr 2024 23:40:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B696A10F50B;
	Sat, 13 Apr 2024 23:40:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="h3tlslBB";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2060.outbound.protection.outlook.com [40.107.236.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CAE8010F515
 for <amd-gfx@lists.freedesktop.org>; Sat, 13 Apr 2024 23:40:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nvYfEN1Lt3eBfGxEGwv5X/sjuGqMY3LZ5IMWp2OKDQhE4/ZXdsA1rhr3DoVeKSFtcjtu9osA72MpsQ+J3ub7pFBPTG+GoIdLDdKGwxXv8/b8nlZP+yhIn9pZktAyo+B2uZ+bVFvcjSjlUOKDuap6Ed/b5s4KLfVta/D0mLPVODq1QGiZpQfEcqPxhNrf33M4P75+5eChT0tH0K2Qd2aXzwcGxk3F5d9FBt0wTe8zU/+2OZz+afWaZ9C478nX+IRPwdHfikGuAuxHgTvR74pNLjBQRU13/gaBwTEHt4ryzkF/l2XCdI/8oD/ROJkzQQujlw8lX5/SHQ2TXgZHclurXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wu1pfkJim4ryYlLHtTiW/cm3TDMA14hnbh0iItFNV6k=;
 b=RixwJpPoX6X8m35YkGelqlsTPZiClrd7GEzLRqVZdI+oQpEwS1dQPV1Hc8b6YakzocogdjeqHGodBQzdlkse5d7q5Nb6VLzkDGN3CIQUrEs/lu2cfVzj/j+P1sbH+gldsJQ3iSVQq4leu6jVhzXtpoimBNlQg8lZS06osYk3ffn/DXtDQxstcjaLYDXq+cr0jEa0HkNgt0DfObGks+01wh1bSB3AP5xxQMQBJDWuLANlXqglGjB/eq8awfZ9QsrtgimQpbz8UAmc++V+rtccR+4nuOAymNsXyIc+JUgVUksLxrDrIRX81IOBsUJvAfLo7AyJErFxZLUOD5pkkphDjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wu1pfkJim4ryYlLHtTiW/cm3TDMA14hnbh0iItFNV6k=;
 b=h3tlslBB+jNhALYGOoGsWlLlsQFEsqze0MCgbDfCExp6T8QumXTwTxDXZ6NoAFSve5Uu9NDUen62WX0958dx8w3iPftsY9nYtc7GsArFpsSObYU/u146WNgDoF5GQYB1e35Or4+12Nwk31zT/GiTVmx4VmT/jh8iFu/HXAKePRo=
Received: from BY5PR04CA0019.namprd04.prod.outlook.com (2603:10b6:a03:1d0::29)
 by SJ2PR12MB9244.namprd12.prod.outlook.com (2603:10b6:a03:574::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Sat, 13 Apr
 2024 23:40:24 +0000
Received: from SJ5PEPF000001D5.namprd05.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::33) by BY5PR04CA0019.outlook.office365.com
 (2603:10b6:a03:1d0::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.31 via Frontend
 Transport; Sat, 13 Apr 2024 23:40:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D5.mail.protection.outlook.com (10.167.242.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Sat, 13 Apr 2024 23:40:24 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Sat, 13 Apr
 2024 18:40:22 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Likun Gao <Likun.Gao@amd.com>, Kenneth Feng <kenneth.feng@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 6/7] drm/amd/swsmu: support SMU_14_0_2 ppt_funcs
Date: Sat, 13 Apr 2024 19:39:44 -0400
Message-ID: <20240413233945.4002886-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240413233945.4002886-1-alexander.deucher@amd.com>
References: <20240413233945.4002886-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D5:EE_|SJ2PR12MB9244:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f15868d-acdf-460d-377a-08dc5c131725
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4KWm68xJRVa4oXmcCAz1t3klgSYftkWYyfy3J0m07DW9ndRW6HE1vUCp5CYmmQp6LO5wV5VmJI0UJGXyZha+AoLfr2W4RxElq4NmlZf/iKZt632kx0EFGqP94kk6EmFKbiiDGaqwPY4/dB3lmU4O9b/tV5wFPA53nFn5O16qo0vGElryJgcKpy++18VXCaNSrug+1Wc8NqJ+71QpiAdUnT9SyvtZcnZrmMIK6vPOEdoDRc6mFlo8ZjhMymcigd/DSvLTG5nNreRM9+uKyCwyrUilP8/gutZ8nOTGlxu06pWoH33wsz5O6vk6LGZ8UAND97W2ZlCq6rLLGGgcWBIJw5JdtLzdHpNbUV6uBYiJbgFRN+2YH2VF6A76zzJcvUpbUGZHWuq2897h0acaCyEiCNjgj+p85XlWf4hFkRSfT6jWImMl1+9dIRaBIkfrgbadh/tZltb2g8NZJyA/7w3XkUv3lk6WzEXVDSfT2wosOdwig1y1/WvBbf15sMscb67jA7hPufujY/KXs1ayC0wEq/cVGRlQov5W4/Tq3MfG1CGCsGTqJprWV+L2SKicrgjw70xLlyZQ4Ssujz2weiCwgKYjXCbXdrFZwtUXjoi9rgnHHTZ+OIDP2vzcpq500M31EhWKrk3Mhz9vcYvPZcwtzTkTYROiRe8lN48zqEumY9qxq740LJceiw9rHYc3GP2kWFWgwuxUlW237XRq8RireTWnFbDcx9jiQR7RSA5B7QdlfKT4yAmw5PRyQ5P7vY7f
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(1800799015)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2024 23:40:24.1123 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f15868d-acdf-460d-377a-08dc5c131725
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9244
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

From: Likun Gao <Likun.Gao@amd.com>

Add smu v14_0_2 ppt fucs support.

v2: squash in updates (Alex)

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index dc2a864b0f512..7789b313285c4 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -45,6 +45,7 @@
 #include "smu_v13_0_6_ppt.h"
 #include "smu_v13_0_7_ppt.h"
 #include "smu_v14_0_0_ppt.h"
+#include "smu_v14_0_2_ppt.h"
 #include "amd_pcie.h"
 
 /*
@@ -715,6 +716,10 @@ static int smu_set_funcs(struct amdgpu_device *adev)
 	case IP_VERSION(14, 0, 1):
 		smu_v14_0_0_set_ppt_funcs(smu);
 		break;
+	case IP_VERSION(14, 0, 2):
+	case IP_VERSION(14, 0, 3):
+		smu_v14_0_2_set_ppt_funcs(smu);
+		break;
 	default:
 		return -EINVAL;
 	}
-- 
2.44.0

