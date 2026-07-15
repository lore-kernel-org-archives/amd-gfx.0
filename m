Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2866C44508
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2026 13:49:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91EC710F0B5;
	Wed, 15 Jul 2026 13:49:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0DcmwM6A";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011066.outbound.protection.outlook.com [52.101.52.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BAC1310F0B5
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 13:49:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kaS3SmU09ulMwAY6b7lRY3ktMIZE/L9HKCD1aub42TG0fs7t5WG2HSpyYW28l2NJTJYFr2IPQlL+93BMuwHVEPpjSc6V0U4NGE3mbOkuXeqH4ClcZeFluBUfNDknc/EYJU2Dab2Nu2nRwRe82yWnXXjvM2GVYLaRMG0t/7PCdYp0lnRaRGyyPCKV6uvuCv902Ifx1+PSRr74tlW+MxltbbjdwXRb+1scrtAYO+uJ8aInSxxTi6lgguT2dn/XvB2gMQBXcNvpdi0dcGeBcbDsD/8V2sGOAxGMcnQhO5Bp9INKv1IFKdmbR6ijj4j6fVGYIPG1KO+WA/auUsJrqibx2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oY19Y4Xiy2HM0kmTb2AniqJTDfzV3YPXY3aSVZfw19o=;
 b=CRUsfyFIpqm87sgTt+QMUFyrQ/ZEBTNdwGUyN9thbXg7tcp5SulPVWFqelDyu/a4W9RMMpmft5nrzns38vA+S77GL9xhbuiPp5JJ+JME9IN6i1EMgHceewfoJfbRxYrs/4n+USaOVkGe06eZa+HjjYaCnLQc4TOueayjQD1RYaK38HBDCOr+nHjRYwTiIq4kgovUI1w7ys6qdUiU029+dLgmqQ0+DtdihcI4QiH6HTLgcvz1c7lDJH2ExmOwSUb2X+2eX3DcvU6ZSfO1E06iC59SJe2R/kI36zXsiaBY9Trm8cpaFrWXayRdGzDfZrKXgQbzKRLfcmxRSoUaESBk1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oY19Y4Xiy2HM0kmTb2AniqJTDfzV3YPXY3aSVZfw19o=;
 b=0DcmwM6AzabPZmkaneam3b4Xp0Zq0ISOc3x5dT5jjLCsJwuP0B1+ZVLyp+Ke6csCpSYZXwXZm7OkosuqyvGKzlx8gAHEeRPZ4+0kWtOyAZ5LqRPIqY808xvpGvfhLpr1LLh1OfhPKAN85S8iKdrF3IfCGwP1AslBeS8aOYFlS9k=
Received: from SJ2PR07CA0013.namprd07.prod.outlook.com (2603:10b6:a03:505::15)
 by CY5PR12MB6622.namprd12.prod.outlook.com (2603:10b6:930:42::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Wed, 15 Jul
 2026 13:49:15 +0000
Received: from SJ5PEPF00000203.namprd05.prod.outlook.com
 (2603:10b6:a03:505:cafe::43) by SJ2PR07CA0013.outlook.office365.com
 (2603:10b6:a03:505::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.12 via Frontend Transport; Wed,
 15 Jul 2026 13:49:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF00000203.mail.protection.outlook.com (10.167.244.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Wed, 15 Jul 2026 13:49:15 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 15 Jul
 2026 08:49:08 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 15 Jul
 2026 08:49:08 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 15 Jul 2026 08:49:05 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 67/70] drm/amd/display: Fix missing dc_3dlut forward
 declaration
Date: Wed, 15 Jul 2026 21:38:17 +0800
Message-ID: <20260715134432.1975118-68-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260715134432.1975118-1-Wayne.Lin@amd.com>
References: <20260715134432.1975118-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000203:EE_|CY5PR12MB6622:EE_
X-MS-Office365-Filtering-Correlation-Id: 219d1039-8fb9-4314-c8fd-08dee277dc3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|376014|36860700016|1800799024|6133799003|10067099003|56012099006|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info: l7SRDs4xLMi1yNNx7TrRl8s957fKv8hP9pTSPwb0Y9u9ox8GQTUjigMO7GrKYxPzyV8eIgF0wSxt0h9M72THND8j1pzgmM001WL38v5ADgB+voCqknnGrll1qQmaN8LyIhv1IzM7LH9eXR4eB+w8wbBsPqNMHLzhh8loH891z/KZKJ6MszleN0fCIgd8zxcD3Na10MIAtWn9FoEfoDnDvkd29tkulxanat+Ocrk6qcv5Vpa3nfPu6QvinzvswaWItPepM51iHBI4CaUqjAY+nFz15NLj5tFUe9iL9fp5fihXsr5/nHP7ETwm9RL3RGPyoxdoDL1kxJAZvu3EJZXZBULxzAMvRHdrM70aODLIW+u5MKfQHON+/vXG5tM/TpFO0fguJmOyXhoAqUMBu48NQOSNSBM2KnKUQnHmFd59X6JtGglEhDxf2xQmJOdV+9aTPGvBm/BOk1qgDyN0EIuS71hOyoaapcaCxJuliGt+djF9VB9EFL5wFd/uNb528ElL4Y53Ei6kK1GBfKZrUM1Xe5kMMzcCn2qGbGPnQUidRlkoR7Qj40tNOZedSRL6iw5gD/A3mrAZVi8gd0P219EXzG+LTT6cAV+qfwoqSz6bSjRIqW2hxb9CplgUXmDcTMJlWRiLxNwi8iwogFEuTdb4wzlNKviF8qdous3v4meiZIiQxgExCvEjSrqO13hwiFfIhRSjzNsREd8x8I+YQJ8ATw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(376014)(36860700016)(1800799024)(6133799003)(10067099003)(56012099006)(18002099003)(22082099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 5DoF/JjqsnfhBvi4lkZrVTpFRq5JSCeI91CRg4Nz3eWMkgPvkAP7wismcfEWViomR0KklXQiiDadBgmQ4LesaH5jqnE5yQYVIYckP0l1zT8Pt7YD5gePXfhRdAxKbaKrTL/icMjPi/PCq1OhF8RO94lWteOqcaPjtC4Uo4IXZxT8cjBCO3KtXJpJnEWu7NUOMcP9PxeNR62sQHnA+SRft7nFggwe8WHVZMB19OPIO8/HX6cRGRGE94f0M3/IhWxOARlRGb6AmtCyQ3KtwM6Nt1xDzhd2uBB7sBm8IqDsJcS2+wX9dZPq0ltAYPz3vuSqROEnl3qxu5KCxuM/YVUG08h0KfCj6Gth97qjn8gGWQZqV+BwDTwIPgEwj+34PzGFicqVsbb52wBmtQJgXHWG4F72WV61+e5WrWKgkfdN9Ik+ULFiW9dtp/uxbf2vCtvU
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 13:49:15.5953 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 219d1039-8fb9-4314-c8fd-08dee277dc3d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000203.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6622
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

From: Alex Hung <alex.hung@amd.com>

[WHY]
The __set_colorop_3dlut() prototype in the KUnit-test section of
amdgpu_dm_color.h references struct dc_3dlut, but no forward
declaration for that struct exists in the header.

The forward declaration was originally present but was repurposed
into struct dc_plane_cm when the adjacent amdgpu_dm_atomic_lut3d()
prototype was updated, leaving __set_colorop_3dlut() without a
declaration for struct dc_3dlut.

[HOW]
Add back forward declaration of struct dc_3dlut alongside the other
forward declarations at the top of the header.

Fixes: 67b15f11ae60 ("drm/amd/display: Fix conflicting types for dc_plane_cm functions")
Cc: Alex Hung <alex.hung@amd.com>
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.h
index 1a8b06bdaf44..cec23a020c3d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.h
@@ -44,6 +44,7 @@ struct dc_plane_state;
 struct fixed31_32;
 struct tetrahedral_params;
 struct dc_transfer_func;
+struct dc_3dlut;
 
 #if IS_ENABLED(CONFIG_DRM_AMD_DC_KUNIT_TEST)
 /*
-- 
2.43.0

