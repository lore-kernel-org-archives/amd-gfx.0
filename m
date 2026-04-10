Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3D87F44855
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Apr 2026 12:40:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69AEA10E226;
	Fri, 10 Apr 2026 12:40:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Bu7i5PmM";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011058.outbound.protection.outlook.com
 [40.93.194.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F0E0110E226
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Apr 2026 12:40:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XMv6vjY3ReRccSjXDm5LLRJDcNnTHR/7PDCSJyY+RB9C5zi+me8zOXLaoX31gZUmDrAAgccAFShmwXTARorxID6SSw7ylXO1eTc9PH/iEL9J29S/rJ3CSY3I0NMycPD5uxJpMvKNs90XuAb/LWC3wt1/dc+J5T1eUHHPuBnsXK6i7Q+I5fKS2sCoWhmUnW0aDFv/Wh3LgLEHa6ZUa1eU/0oqZpvy47dgfv2xpL8L2EXlVRc6AZl5vIZ6yEuFKD0O7LDjJm8BF3oA+VDiRSRvoHiFm7LMyHpX0F5pTlgBhrI1bGAzE6zpu1spWoZ65+2LIe5OA5zLGmQgvYUjAnnImg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=72FJajRxRORgi4daDn6BKwJn0O2NkYi1of3NLTYL2CM=;
 b=N6cPAdPXagrAqhlcgPSrqSo39LzxQ+dl6YFwFoMHa/9YcEslqMsQE50pk6MvoBR7yfLZrIlMXWFrdMwJNaDkdLNBr4Skujpx5jx2Dy/7rlD6rcEaPenX6LAlLJ6f8F8L/kdZnWO3nofQY4oRzaoXwbsPWAA6TKkB3B0fAb0pj4MMeL86qFW8s7dF5Z0Qr9xO5t0JShAkJWYBnejfTTQunrua3dqMc2mzlPBHfEc0jy66BtM/hF4Cz3u+4fSxh4XE3NS7uM67yfbWA6cBljYraJaKmkCMR+I5f3zb5M935owageyb6RHdVh/zOHNBWELNi7SKib3QezxK0rv3hl/Leg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=72FJajRxRORgi4daDn6BKwJn0O2NkYi1of3NLTYL2CM=;
 b=Bu7i5PmM9w1wMPEKG27XZIKcOLC8tejT5tStlNwcEGZDOCZnNK+CnYZRCgkGlJApdJAaQQAJ+TvDueiaHlJvR5QWICe8bEDVD8PC1QtqTiDPaAiOwS/qxjJLTbUWjWtQvM2eplJMZYa81ViRkI5+6pQsQpjIAkfZ3Detb8fqv2o=
Received: from PH8PR07CA0046.namprd07.prod.outlook.com (2603:10b6:510:2cf::24)
 by PH7PR12MB7212.namprd12.prod.outlook.com (2603:10b6:510:207::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.42; Fri, 10 Apr
 2026 12:40:24 +0000
Received: from MW1PEPF00016159.namprd21.prod.outlook.com
 (2603:10b6:510:2cf:cafe::f0) by PH8PR07CA0046.outlook.office365.com
 (2603:10b6:510:2cf::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.43 via Frontend Transport; Fri,
 10 Apr 2026 12:40:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MW1PEPF00016159.mail.protection.outlook.com (10.167.249.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.0 via Frontend Transport; Fri, 10 Apr 2026 12:40:23 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 10 Apr 2026 07:40:21 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Dan Carpenter <error27@gmail.com>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH] drm/amd/pm: smu7: Remove stale error check in
 smu7_hwmgr_backend_init
Date: Fri, 10 Apr 2026 18:10:06 +0530
Message-ID: <20260410124006.2293461-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW1PEPF00016159:EE_|PH7PR12MB7212:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b6c6df9-9c1b-4bdd-584b-08de96fe55d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: k3W6vD+gD6NuaL5sVD3CJS6CecgLTktsBuOURRuYWm8UeAAqVbvZDSNl7nX8o0QoqVVYBQrku9G3uyLNiy9l3D7WdsOOmI+KrZ7ujNhk5WbQhlCb8wYqRl+yCmt/1Vt6EHajOAS84G05e/IqBDOj7ztUmcALcT2OkjhswTT/JoiF2RJ5bDu+ZNzq/ieJRf9Co0pkvxGk9KPbmbkonHbCfqessz1CoDJSnPKRVW5yc8Q5fAAI5d1BHzb5x4ERPznZZ6i+TXOeaS9PLNGMYdT10+R7mGV0RI5ewBcouMrJKx4K2NeaMB5ZEVR6+LMe/MPsQUDorjVyXEL/2EoZw59rrPOvId+howFiCkqfBkRUK4pXai1UMOI8yfnMqlFOsia8DijiD0xKrxO3FFVlH9+TCdFXxM5B3XciUPwukpAdZWx0sDA/H/82aO2y/spjWn5vF0kLQuggb/L+vxT33FYlTurz7QWbIrtfQ8ygY+JurIaR/35MtB0RiKH+2Y1c9Qa/mCmJKk3+XnAHvoZtvZIZa/584mXzdt3ntHKQR2xUmHOEmowVdsy6XihXSPlCPgtPs9QLYc7cs0XmBBmQ1Pls9KwhJ0Z8Ou5durreCHy6e8s8+hdXwjf9SPmWi6KYCFOYccBJAQNn4YuO40/bX9O/0O7YAbCAqHLKqC3ciUrqu/V0esE5uwbzwA1WZ0ryokCCGrcMwvWNn1QljRQO7kvdpm9AZy9canCLN12iYg1MdiCoEOFk0B3WH9YWsMdGdZRwuGb0qUDDvOQB9E0UsnFxVg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ImgRRdTw7B1N4dFF1eLnIcpOi4vGAs/QVK2EU2XejNG8NBBGLi2wCDvX9FEMOl3lewC3rvTrjrlb4IWkDLigIllxUtuH6cYJ1MDlb/bDKE6erUdKyKrBRhOKNDOVunq6/wYMwA5hP/1ERnS0C/48EXQxJcr3KcrvCgMzB4L4C/WmTt+gnJRxe1uUUNtH/du+hs5EUmWJPBlSvJdQiIXKd5dscgQ5BW/YMw/PPmHTr/axp2r0DkLidQ5UG2p9SSyQZH0msl3zf4aTS4mbKw1JmAV0T3BmDnOybQSmbJdyOa+bct66SUFIYn2+mepouxoL4RLrmDR8EL1nRkQdhOE2ZxMCGRBkMbChcNrJRSK77D4Xml8RoO4BAGo0wKwAernuycipD/9NqaO4saffUH/yUJxjmniOV8S+jjbxTTRK638/CeiYSnyu2qlL4t9ap5q/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2026 12:40:23.7495 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b6c6df9-9c1b-4bdd-584b-08de96fe55d2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MW1PEPF00016159.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7212
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

smu7_hwmgr_backend_init() is responsible for initializing the SMU7 power
management backend. It allocates and sets up the backend structure,
initializes voltage tables, configures dependency tables, and prepares
platform-specific power and clock parameters.

The function follows a typical pattern where each initialization step
returns a status in "result", and failures are handled via a common
"goto fail" path that performs cleanup.

Commit 2c21648bb814 ("drm/amd/pm/smu7: Remove non-functional SMU7
voltage dependency on DAL") removed a function call in this
initialization sequence, but left behind the corresponding error check.

As a result, "result" is checked twice without being updated in between:

    result = smu7_init_voltage_dependency_on_display_clock_table(hwmgr);
    if (result)
        goto fail;

    ...

    if (result)
        goto fail;

The second check is redundant and unreachable for any new failure, since
no operation modifies "result" between the two checks. This triggers a
Smatch warning about a duplicate zero check and reduces code clarity.

Remove the stale error check to keep the control flow correct and
readable.

Fixes: 2c21648bb814 ("drm/amd/pm/smu7: Remove non-functional SMU7 voltage dependency on DAL")
Reported-by: Dan Carpenter <error27@gmail.com>
Cc: Timur Kristóf <timur.kristof@gmail.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
index 1381902547b8..4436ab2bb51f 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
@@ -3062,9 +3062,6 @@ static int smu7_hwmgr_backend_init(struct pp_hwmgr *hwmgr)
 		smu7_set_private_data_based_on_pptable_v0(hwmgr);
 	}
 
-	if (result)
-		goto fail;
-
 	data->is_tlu_enabled = false;
 
 	hwmgr->platform_descriptor.hardwareActivityPerformanceLevels =
-- 
2.34.1

