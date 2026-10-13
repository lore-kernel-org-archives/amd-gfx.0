Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E235CC6B03
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Oct 2026 11:20:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A022610F780;
	Tue, 13 Oct 2026 11:20:20 +0000 (UTC)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012021.outbound.protection.outlook.com [40.107.209.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E918110F7AA
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Oct 2026 11:20:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MHo+Rv7IE9DgydWEfL/sEifIQ4/j5dguKNEByyUF78LyQfwT+tMjaiuMiVERPg16HYpoE2BivHhffsWgB9HDbdZmAJQmxUbO995f1AZ0boNNCr+Jd1C/AnbtRA4X06jF/KIC48ybcWkJzcsKqg9HIV92KZ1hqgAhaoqmbpTWbJMD9VLg2L8iDoFoCBsmfQFyKu0CY127ffOnRHy3S3+DWKLs6O9wVVdsPupA0lpuuEeAcDSGk4p6e+c6isC8/F2WFbziWhkBaAC1uIIsHpyQ1Rol70DhJPFKs6hR7v1/f3g5d38Hgs5q0EhdvRreG9CtY9ThBbD61ZX31XIk9T6aIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DHiDzj/S2Lav1FzwlU+4gbHE5gdeA/xpFWO+rfP+A1Y=;
 b=qwssp3qbqOWamznDoLcYy4mFAfZbEgLWxdeME4xoENJqEsZ+0x2/SsbbaD+IDa86wM4Bl84JLsjna/887BCzOfKAYdvQEtNsBaFgNFnZmrSFpO2ZZSmGqRUAtrWeiNEkzElmV70WN+YeDiO1z21ASafbav6BfAx57AiEwSBldtPPxZGe1366P7X1gAWXfNfTEz+rzYijCTAUz6aHE343wwYt5NJA+/iKOEuZv4iCJnx/pfakjjAu7ImAI8645SjAHuk7sT6gI0tBoNfKWgX22wIRLNAWamJmNOZPUzPegTuzTqJ6xLXECJYapS9u4W24mKZxYBEV9xem3nMoNCjZAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DHiDzj/S2Lav1FzwlU+4gbHE5gdeA/xpFWO+rfP+A1Y=;
 b=Z6EffyxXfCI8w0vmvUklF3aIUxcVIUsB7vEQb/7KbmQt/khKncq2KzWhV/pCNN1+cG6rmcZH14SI8tdNp2msKy9HxMiRrXQusAptTONBCCwjPeJsPpMz46FTFER9UrNDcu4xLUln2GkPKzh18u3ptwGIiI58uywcc9dcPSmks/k=
Received: from DS7PR03CA0289.namprd03.prod.outlook.com (2603:10b6:5:3ad::24)
 by PH7PR12MB6884.namprd12.prod.outlook.com (2603:10b6:510:1ba::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 11:20:10 +0000
Received: from DM3PEPF000265BF.namprd03.prod.outlook.com
 (2603:10b6:5:3ad:cafe::44) by DS7PR03CA0289.outlook.office365.com
 (2603:10b6:5:3ad::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Tue, 13
 Oct 2026 11:20:10 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DM3PEPF000265BF.mail.protection.outlook.com (10.167.23.180) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Tue, 13 Oct 2026 11:20:10 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Tue, 13 Oct
 2026 06:20:03 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Tue, 13 Oct 2026 06:19:54 -0500
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Samson Tam <Samson.Tam@amd.com>, Alvin Lee
 <alvin.lee2@amd.com>, Ray Wu <ray.wu@amd.com>
Subject: [PATCH 27/30] drm/amd/display: handle UPSP chroma upsampling in DML
Date: Tue, 13 Oct 2026 19:08:14 +0800
Message-ID: <20261013111616.2267344-28-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013111616.2267344-1-ray.wu@amd.com>
References: <20261013111616.2267344-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PEPF000265BF:EE_|PH7PR12MB6884:EE_
X-MS-Office365-Filtering-Correlation-Id: 31eb3251-9556-4b32-d244-08df291bf16b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|82310400026|36860700016|56012099006|11063799006|261009223027099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: UJBnOcEVeSFb6gVDnEBuvRZR2nX0hrjbFnYML3wFm1nltpP6KD6fSl1ixKxWFPI9lo4gm7IA0jU4S5Ug0kEu7RuVWjIAzcIxEBBhBJ1Sh/WvA9s/8KZ7bvpdVvePXBAkBYHrsymjAQUb3J0WQwIX6rXlq06x0siGn76yuyiJknsvHwm7hMwh2BC8c836lpBdKAGuZxaDP+mYTgzSFJydyJXxRxwA9h2iimI1pLFeyg+L2WOLYpOJmqTHsv2Wtcf5bNMhLunKGCFEnaGxVM8HxtK7ffvWCRhbSlGKnVqUSLe8QSZ/ljkwsbI/+6VBvtHD0su5Qz1cwdZfThKtgdqQksv6VsmEwzVL7M1wE88tUWG4bMwu69Xdfvr6z6lKmXOD8lbfIqS1N+B1WqgGBKlZWK0D/lYuFb6YCXzKKUTYfYX+thyVQrNfqpEi+kcKORBw1K5LpSDgncyZvTkIW6yBZsLosvZ9Kh04EVe7umJKILiHtj7uKlA0o1lzqU+uZTCBog1ibpgITFqIT24POx5N411dKX/9GPzaQBke+w+zzIui/ALcuTKmVyO5eyEwsncQ5GUxvsEkC+KNnQ3e4YmSDCu59o0NNrBc0kmnKQirM4FX+8e/lrSd7Gxd5mC9xM/RW/TxKlIMoteGHGxarkqOapVD6DKZS1Qbfe9FRrBSUljHxu54VYaDFH0XZknzxsDWMDQreW/LpHRqqxE5OzVoXw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(82310400026)(36860700016)(56012099006)(11063799006)(261009223027099003)(10067099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 3yKcrK4HugI92t0SiN9loCnIyzM3cYyJzhAsQyjJLtI835B/jY+JWZBst8tyFKabvPIgYANoUqusJ1HzWS1WN0QLh6ywBb7SMVFdEukGQoDQhofDphyOAI4CZ+KbyKKCOaVND2HesHiSCCt7I4aMblkHgTfedjY26hRKcZqL42PG9PHxL1nDYlMK+qNcKi+lZByCtEZPT1WDDKNQR621mOJp1xsm4O32XoSO1sZ+ZAI6pP7ApqF0G739gVGhS99ARudrmykZJLnbk9V67OJEpfFdRxKt60JnlZDdDvVGXN/qkVEB+FiIgZq1jbLT1N7ZiUBGA9dc44DzBC9gGyb9AS1HB9BE9fY2h4TcBZ09yoNrqW5Po11TKsAMufNNdHZvJKMPXYEfxI+vBv6mKOJY8ERV2iu6hJf01gile/iZrDYm5ebo0tCJfdg1bZx9UoIV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 11:20:10.0518 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31eb3251-9556-4b32-d244-08df291bf16b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3PEPF000265BF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6884
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

From: Samson Tam <Samson.Tam@amd.com>

[Why]
420 video at 1:1 has chroma scaling.  DML has check to
enforce 420 video must be scaled.  When UPSP does
chroma upscaling for 420, SPL treats 420 video at 1:1
as not being scaled.  But this triggers DML check to
fail validation

[How]
Add check for UPSP in DML 42x scaler validation
If 42x is not being scaled but UPSP is enabled, then
do not fail validation

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Samson Tam <Samson.Tam@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 .../dml21/src/dml2_core/dml2_core_dcn6_funcs_mode_support.c    | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_funcs_mode_support.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_funcs_mode_support.c
index 71d14fb8c830..50ca620a4c41 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_funcs_mode_support.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_funcs_mode_support.c
@@ -126,7 +126,8 @@ bool dcn6_ms_check_scaler_support(
 	for (k = 0; k < display_cfg->num_planes; k++) {
 		plane = &display_cfg->plane_descriptors[k];
 		if (plane->composition.scaler_info.enabled == false
-				&& (dml2_core_utils_is_420(plane->pixel_format) || dml2_core_utils_is_422_planar(plane->pixel_format) || dml2_core_utils_is_422_packed(plane->pixel_format)
+			&& (((dml2_core_utils_is_420(plane->pixel_format) || dml2_core_utils_is_422_planar(plane->pixel_format)
+					|| dml2_core_utils_is_422_packed(plane->pixel_format)) && plane->composition.scaler_info.upsp_enabled == false)
 						|| plane->composition.scaler_info.plane0.h_ratio != 1.0
 						|| plane->composition.scaler_info.plane0.h_taps != 1.0
 						|| plane->composition.scaler_info.plane0.v_ratio != 1.0
-- 
2.43.0

