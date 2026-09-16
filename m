Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E87BC88E7F
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2026 17:52:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 858EA10E521;
	Wed, 16 Sep 2026 17:52:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3RsYM4zW";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010045.outbound.protection.outlook.com [52.101.85.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9AF110E521
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2026 17:52:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wmNerWcdAjwDIL3pa/1mlcgM5qFZi2OMthy65fwWYZRaNLe0csQwXEQJAUzW2q1mCPLmObsI74hI1MHfIgjI4FTMkgnOavVoPtNLQL89zd6TCMSeEr6lBBAjsUpFPcW/bs7/9BbfuoHGH7gjkuMfnt8uRrsQhwx4MHyst50aVtfaZLPOK0sVJeyIz77Hnxc4aOSF89uRyeJg4LgHDzV224Phiuaza0QFop8Nu8wnpcE4TjyUSy/8okmO5QVd9UCpaWEpIRkXPCgUNJxxybLU5UI4OGKeAR1rET2EMjIModHYnTo6U50JDcxGpLyg3B/6MW5uz3fEzhgIrKS0wdP5aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mc4mVDxmB7doDpp92zdgvw2q3f8Y6uFms2yiL2+Onqs=;
 b=PM8lSyddn7Hv0GKhyhI1f5PcGUmYe8FwzsPAt9rqJBKioOdZ/aHp9hGLDnUjFwN0H86a3/BCNRbcb9KVvzUzwFV7ZlOVYi3T0sMBN1JGdiWEf0xqHEnDYxOo3CepVPI/wLyAZb+ySPIEbgJCOxgvo3XDQK0NDFQJlliGW0SeOakdkYvLU6CaTzTGZY1Fi8K79GkatZeXYTX2OupTNzBhi92WnGea59Noqe+q9jHR5SMA01HqMOLVC8d5eK+Yi+U742AHiqHqkk6tJcfifxSKlWp7RERUmpGPX7JVCwTubU7vAWg34id0ChT2ei6c2QTQgBj2CHslwT5zDB34+KdPrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mc4mVDxmB7doDpp92zdgvw2q3f8Y6uFms2yiL2+Onqs=;
 b=3RsYM4zW3/DeFSnxlVm2Gm8x+oRl29q3n69sYhpzUMtqr02vjmBJSHCXmJgfriybp33tN+1K51sMCAjCkwTVI4IWSELRa3ZjC43o9Te6o5SAu+VdfqCXe6BNpCoSUIHi+Jd3G0MhrTZflEafgxfsHg29aiALKGCZlPH/pRGx5rU=
Received: from CH0PR03CA0202.namprd03.prod.outlook.com (2603:10b6:610:e4::27)
 by DS0PR12MB999264.namprd12.prod.outlook.com (2603:10b6:8:42e::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Wed, 16 Sep
 2026 17:52:17 +0000
Received: from CH3PEPF00000010.namprd04.prod.outlook.com
 (2603:10b6:610:e4:cafe::59) by CH0PR03CA0202.outlook.office365.com
 (2603:10b6:610:e4::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Wed,
 16 Sep 2026 17:52:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000010.mail.protection.outlook.com (10.167.244.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Wed, 16 Sep 2026 17:52:17 +0000
Received: from georzhanmkm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 16 Sep
 2026 12:52:13 -0500
From: George Zhang <george.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Alvin Lee <alvin.lee2@amd.com>, George Zhang
 <george.zhang@amd.com>
Subject: [PATCH 02/64] drm/amd/display: Expose 3 overlay planes on DCN6
Date: Wed, 16 Sep 2026 13:51:17 -0400
Message-ID: <20260916175301.368306-3-george.zhang@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260916175301.368306-1-george.zhang@amd.com>
References: <20260916175301.368306-1-george.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000010:EE_|DS0PR12MB999264:EE_
X-MS-Office365-Filtering-Correlation-Id: c5d42a4c-41bd-4896-aec9-08df141b3f6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|23010399003|36860700016|10067099003|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: ENyL9e1MENNuL6vxq/WFurlzRUUoYut3ZrBUlvu8V5sBVBdQ0Po6vTIxNR44IsFOvf6osjUlZU7zXPApyG3yU9vEwBbIfrcrgMiP1mrA8unyO3Q0StZh2CLfBAFm64FwPZsV/UUDhk4mK0/qRL1XciPmuo54bEDPOrNFC0dsrU6WUHUZLGxEFPdlQ6ylG2cktckhfOT8Vl3tvrM9KZ46eqgPxsH0Iv2DWDwgiIEQohdWocyEUgTcZEJHVYM0N4PPcgQ1XJ182ZxwLB7RUlqeaXB2/Rfp1DwPuO4W52996r42p7visC0tc7MXRrh2dB9ZJMuf0q/wwehjNvmtJKjCw5FNj+aB7SaU3a/RwdJECgbso/Gv79UZSHbHhckg7fdgma47XNVGjpt6+R1AHL7wQzlrJ4ABtV87lXmo4pUW+VvimJCY57eYh3IBTSWyySgLXqmmS0GoiOyY/3hBF2DjdpYiHN9uxsC+1t1nVZwQno5tpkAUTEZx/Mg+c0LQ0zAHeLK9m4MheV8s2BY0bmLpz/ZSW9xvGuhVSb3E/G9q6mefj436g5rAUzwOv9AB2mv3JEr7kzrLii1uOYcSTq00TOxTQrlfmjupJ/IAiwWyp6X36oT2nhoiQYALUfkW0wOwoyYHnH4K8IwUpmyBcjwDPOgqkuS1nOE5KCOk/Yuo92ztzia8Rr+kpancRWRYW+Piq071WyEuYY4VrrPA9yBgUw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(23010399003)(36860700016)(10067099003)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: vEb7zHrlrGoQVK7Xwtqw3YeP9E1Efqyp7wBBFqc8QiCNm8gmO6+deu8NMAEZp+q+7B91BxNu54TT0wQF2Unv5NRXq951IKMCRxZgln6DciSnTqtX1cPqlyi8jkCgrVuanfiT7+Km46cCCMDrFvdfwExzjIOesVg3m3gfHUK7bcLMnH37P6zn6TzM5j0yXsSnxz2TGa8oRIc8Fisiuv9aj+s5doGdGoGgkb7YO+XzdaxKhjOxGpgaNw/ICxv96gF96WYwcPW0B24HCUIbzWBmYqOo+kETAVjZzQRYBVeKdUF0nJ0GqlnDyB8l4lpGBoYUTKHG42pddpiei0rVRKdnvwMVeZdUmWhx3Ve3XkGtu8kfZ8bLJPSgd8W0wNIkf0A7GT6GjTLsz7XpJ8AOtk2+NukiYjNiPC8c7sL6b7sh1ruypg+LUN6iHfzr14GJIWL5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 17:52:17.0123 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c5d42a4c-41bd-4896-aec9-08df141b3f6c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000010.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB999264
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

From: Ivan Lipski <ivan.lipski@amd.com>

[Why&How]
DCN6 has 4 pipes, so we should be able to use 3 overlay + 1 primary plane.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 .../gpu/drm/amd/display/dc/resource/dcn60/dcn60_resource.c  | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn60/dcn60_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn60/dcn60_resource.c
index 21292af6a0c0..4e043343a819 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn60/dcn60_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn60/dcn60_resource.c
@@ -2038,9 +2038,9 @@ static bool dcn60_resource_construct(
 	dc->caps.cache_line_size = 64;
 	dc->caps.cache_num_ways = 16;
 
-	dc->caps.max_slave_planes = 2;
-	dc->caps.max_slave_yuv_planes = 2;
-	dc->caps.max_slave_rgb_planes = 2;
+	dc->caps.max_slave_planes = 3;
+	dc->caps.max_slave_yuv_planes = 3;
+	dc->caps.max_slave_rgb_planes = 3;
 	dc->caps.post_blend_color_processing = true;
 	dc->caps.force_dp_tps4_for_cp2520 = true;
 	dc->caps.hdmi_hpo = true;
-- 
2.55.0

