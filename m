Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3EF5F327C2
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Apr 2026 08:45:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4002310E831;
	Tue, 21 Apr 2026 08:45:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="b7mJ6aOx";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012019.outbound.protection.outlook.com [52.101.53.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9314410EBEF
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Apr 2026 08:45:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J8aIanqtXaUlH+iZSrcogICLad8WodYPNj5NLXGcZLQ5cfc/e752HRYpqGa0Ydtg8T41RwXttPWCR62DnXefoG1Sb5Hqg0iArtDpIvCbvVhsJwmnisqEQ9Ii380XbaGQ+CNPDuatEuy7sLw/1b8reiBYx/MAIZQRdy31fyqel46mYvBg9hDEx/LsNBX2+hsqfBppbCRS4PtuPcuT7qkDaEsg80ySfg0sAFEq1oFGEB5CYu4oepNnH85hR4tx4fcg5BKP7kOcuUEufGXY/R3Ik8FRSFSpFRaGQTZqcZVRgIYgzqlkwxnvw3bruBQ5+17YSCWBPEByGY+lLuhIH6eZDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dF0N5bhK1OPVaTro8cKlgfS13qCrmiq34DbEV6G9ODE=;
 b=CI/xyiKcdHdVSlnWq5lcJzqoo3XOfNi7LcJsuABuSjyzNgoTlHISig+gF04AthSBZLaa00/m4dh6digVphX9wAljWaey9gySwixmnXAnt0OmTJI3dEcccNRvgQdcjA4GVeF21hNSg3xGHnhYglTD6iiN/2q5pxAKlSl15x+IhGV/+NdxW+6FkoFnL6J0Q+mOqdaIojK+shbtIaPadFvCgQwIxp7mGemuijgZ9ipN/PwT+N5JJq3U7zvOA6x+aw8l2/PtYyezCdgw1m5JdS1NVeX5lbXmDi6QR+GaIrJSBlDS7lSL99utDrdeQoGoeF+V3vcFfBTm/3L2X64jF9kitg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dF0N5bhK1OPVaTro8cKlgfS13qCrmiq34DbEV6G9ODE=;
 b=b7mJ6aOx3WQnWJUQ1TTPwyr3ssCXUafuUVc7eCAsH9uITGGwOo76ARrzm6yrMTHS5xH8GkmgldOxxE5DiUi6qW59yIO62dIDryDev9YHjq34sKx1kChGKGqckg2COmevTRPQXP00teDClFDYaD5g1v3gw5gdF/zlzks6JG3PUJc=
Received: from BY5PR04CA0024.namprd04.prod.outlook.com (2603:10b6:a03:1d0::34)
 by CH3PR12MB9077.namprd12.prod.outlook.com (2603:10b6:610:1a2::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Tue, 21 Apr
 2026 08:45:31 +0000
Received: from CO1PEPF000066E9.namprd05.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::2a) by BY5PR04CA0024.outlook.office365.com
 (2603:10b6:a03:1d0::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Tue,
 21 Apr 2026 08:45:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000066E9.mail.protection.outlook.com (10.167.249.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9791.48 via Frontend Transport; Tue, 21 Apr 2026 08:45:30 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 21 Apr
 2026 03:45:28 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>
Subject: [PATCH] drm/amd/pm: remove trailing semicolon from
 AMDGPU_PM_POLICY_ATTR macro
Date: Tue, 21 Apr 2026 16:45:16 +0800
Message-ID: <20260421084516.614258-1-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E9:EE_|CH3PR12MB9077:EE_
X-MS-Office365-Filtering-Correlation-Id: 657d04a3-541b-43de-459f-08de9f825817
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700016|82310400026|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: hD2dwKoAV2Nib4iUGA8/ZPJJKLNbXY66jC+l100aDlVDqlPbBZ7yVAW6TMLonfpYR5Qe4BmuYOSNkOhkPZiS1EOyp0zQ/g1E7kIRoe3RZFPYVHCVQHazrMZxVv4K6eYHW8d1id9biC3aQ4zQh022k0ZXYoNjeHkOI25tS5H6HUY1tofhaEQQ98LUV1NTbSxfCALAO7K5dO8PE0iBKWpW8jrXnhaIt7r15VxnWAF7KCPQVvG1iF8plTWOqzw7A5vwS628Xh9OXPcWfttbNR8QmdRq4EckE2RmsyjnsZPAbb9UCHbrnH1DN7AuaQT1RKbO3ANipUmAbLHEF7diRFXKUc3n08iUnd4xMyDahKpcsNM6vpCOs2I+uP4x+fiS96V2vgB2Ja44HBeOqbaX4DReVzCOCDYctBczlWguUok6ArW9avMZir2hEJzrLVHsEjDk24OiJysTrVjOXnZC7V6xbMuXo37O6sbcsas5zszAGFYejAZMjoyw0Pt8yXZWCuR1ZfAyjacn8P55aspd65EO5mj56FguGw/1ToqJr5yb3IyJcQfaRo/Isc/X9lkv+Jt9r1vKUIyS67/aD9yBKVdLBezLmOdublbMmCuFrrwnXwaQTrdNecYSVj9pfhNeosyxxdbR8EMqlbhh2LEJg/BamZYxNhCi92xMKNtSBv0fYzxT8u7F9rahi4VlGlwLkjOrbsLflHWTK+TUwfuZmb82p5q6lck2t75OAeoM/1hqtSgmFSJ6QUE4Z9HaIE+dvmJCZq1WJJum8aJK6j4kQ/ydBA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700016)(82310400026)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: oYKq3d96NPa42hNg96kxgUxZc81VSo6Mqo7S2Wr85PGfV0i/ja/rKToHKoawqgpC0FKxdbhuY1+/JOVOMbjxtoWRIPlPKmVrm5lhFp6U+kCdd4BZi6r6WWuzkPv5BpZao1a3ghzkSFsjgq3UGyyqO4QhjVcyaep/UnbnkuKQ9yS2+Iw+kM+BYcHp3UaDmKgiVU1drHtJbqAfwn/Z7I3iEeXiO4tWfqn+sYKibz+xhJXc1mnGaCxYgwQEVssWGzZiSKR2rAV1qzkPimQNskBAorPsrVufIXFp8LHyLiC3GOALxAgMlxpvJQYD+B8zNRCliWOPW8DRHQ7EfzvhmCQjBlMb2t82a/VZimZ3n/vY7X1LHsFgOC8ugNzk1XjhiXu7W7nVegVbXKUZQdBBk9suSoxAmJrMGyiNuJ7xtZuQiLTcIl2syChYYl4uFVd3tVVq
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 08:45:30.4329 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 657d04a3-541b-43de-459f-08de9f825817
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066E9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9077
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

macros should not include a trailing semicolon as per kernel coding
style (checkpatch.pl warning).

move the semicolon from the macro definition to the invocation sites instead.

checkpatch.pl logs:
WARNING: macros should not use a trailing semicolon
+#define AMDGPU_PM_POLICY_ATTR(_name, _id)                                  \
+       static struct amdgpu_pm_policy_attr pm_policy_attr_##_name = {     \
+               .dev_attr = __ATTR(_name, 0644, amdgpu_get_pm_policy_attr, \
+                                  amdgpu_set_pm_policy_attr),             \
+               .id = PP_PM_POLICY_##_id,                                  \
+       };

Fixes: 4d154b1ca580 ("drm/amd/pm: Add support for DPM policies")

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index ce9a326346e8..fd2e63530e8c 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2505,12 +2505,12 @@ static ssize_t amdgpu_set_pm_policy_attr(struct device *dev,
 		.dev_attr = __ATTR(_name, 0644, amdgpu_get_pm_policy_attr, \
 				   amdgpu_set_pm_policy_attr),             \
 		.id = PP_PM_POLICY_##_id,                                  \
-	};
+	}
 
 #define AMDGPU_PM_POLICY_ATTR_VAR(_name) pm_policy_attr_##_name.dev_attr.attr
 
-AMDGPU_PM_POLICY_ATTR(soc_pstate, SOC_PSTATE)
-AMDGPU_PM_POLICY_ATTR(xgmi_plpd, XGMI_PLPD)
+AMDGPU_PM_POLICY_ATTR(soc_pstate, SOC_PSTATE);
+AMDGPU_PM_POLICY_ATTR(xgmi_plpd, XGMI_PLPD);
 
 static struct attribute *pm_policy_attrs[] = {
 	&AMDGPU_PM_POLICY_ATTR_VAR(soc_pstate),
-- 
2.47.3

