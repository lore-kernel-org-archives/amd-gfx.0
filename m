Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8468CD4F3F
	for <amd-gfx@archiver.kernel.org>; Wed, 13 May 2026 14:34:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 449CC10EEE6;
	Wed, 13 May 2026 14:34:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="b0hDsEhF";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010063.outbound.protection.outlook.com [52.101.201.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 70E5010EEE8
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 May 2026 14:33:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JeeNtbXVV8qXrGY4PLCvTQqjLY3mQNtLZKqqfMonc7TgCxObcb+PXH33f/NtB0IOvCO+hqSr7MV0pOyUs/sU6n6aDMP4oPZc+d1eVb+g1GB+XLHv21rv3p2q//CdX3pnCfW60oEOgixOBvRTkWkUYlFKjudy9IweZKQ4KQt386mHuw+hPQTkprai2WqNHJyHkA9yn2IyR2XBeSAqrKN+Iw/DXNp5Ku8s3HssMLNKZpwl/7yqDZG0XxTBGyw7DNFc//Ad7sL2BOrPnZ9Zrx5MZ2ityBkuQYrD3r+dy3+J0ggLTLnIQNUjvF8Nu11X+S6zPeO/q55eK7RkoDQ61o7uwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A2y4b+KxoF35p7CRSYoRGKS1s/qyZb9vyGKH89T7qew=;
 b=qX1F2VToDYWSinjRcG1Qc6I61O0nauapvmrt4A+IU/NRPX9gMrZeUdfZAaJWhxQdVG/F4q0LfMD8xUopFyqv8cTvrvey2f9mbcOd/6cWoCtlrwJtpL0c+v8e2uBK+5sc+JT5q/1bmRoLuvta/T+CBTfB+Y4I9RqHE2Bhqwf5gPH0kq++FPOsxtbkwc7wpweUYAPFGSBosy3/UdhQirqZ10aBsSBpT9fqXOGo319NZ93oRl8u5H3UlptUthOCMLCk346ZlN/hS4+WY254wmo0XmoaDAkSlefde475R5R5+tDgkAC8+cusw5f7QgHScwdFPld3FJvzyP9XTPa9ifBpOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A2y4b+KxoF35p7CRSYoRGKS1s/qyZb9vyGKH89T7qew=;
 b=b0hDsEhFJlZCaTpOTjfVarw++5zFzhFpqndwaoeYFcl30N8xnDJ5cQgs5qUP78j+1+WBYFRgRBDAle9AAiZappDBl49AzkjF4bTUOx+FbZP/9o4lLA3hoZJkaieXON1CIKQl3G/55yWM7ty3pdSp1WYfwpNarGnKRlM4L+GLZS4=
Received: from SJ2PR07CA0008.namprd07.prod.outlook.com (2603:10b6:a03:505::8)
 by CY5PR12MB6456.namprd12.prod.outlook.com (2603:10b6:930:34::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Wed, 13 May
 2026 14:33:51 +0000
Received: from MWH0EPF000C6190.namprd02.prod.outlook.com
 (2603:10b6:a03:505:cafe::fe) by SJ2PR07CA0008.outlook.office365.com
 (2603:10b6:a03:505::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.18 via Frontend Transport; Wed, 13
 May 2026 14:33:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000C6190.mail.protection.outlook.com (10.167.249.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Wed, 13 May 2026 14:33:51 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 13 May
 2026 09:33:42 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 13 May
 2026 09:33:42 -0500
Received: from box-0.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 13 May 2026 09:33:42 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Wenxian Wang <wenxian.wang@amd.com>, Ilya Bakoulin
 <ilya.bakoulin@amd.com>
Subject: [PATCH 27/28] drm/amd/display: Add ADDR3 swizzle modes
Date: Wed, 13 May 2026 10:29:49 -0400
Message-ID: <20260513143213.1852892-29-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260513143213.1852892-2-IVAN.LIPSKI@amd.com>
References: <20260513143213.1852892-2-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6190:EE_|CY5PR12MB6456:EE_
X-MS-Office365-Filtering-Correlation-Id: 97c52b63-a084-4f54-2f31-08deb0fca70c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700016|18002099003|22082099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info: P9AeDGC2WTZUam4sElxFhZ37bT1z0LUOztpUVVq9CVfQxAYnIXomo9WOdkUWrsaL3DPTSq6lhwupc6k1UeMdmdYJX03q7gpF7jt2XY1HjmMuP0rOcRPWifnUXcB3opB9H9WPu2xGlWEEfUNTOuCUoeIlW3S4OyLAojye2NBhAQl9/pIBwnMgu1++kbvREUl36euvh9IXW+a2G6IKQeqm6HPkQe722UVKNkGxkPpROogEWIZVnXx8jtDKJ6c+6ORyu5ntO5w+wCahgNlwJSsAxKYoUXPz2MYQ+8bu2P1ujE0Fv2iZ20LUlWOq7vB6qTohNgLYUVvappvO1d5ifQCJdfoYTs+ZZK6RBTXr0EIYxuiWqwlW5kH4eFB0sXniWkufTNDMyLByf2f4rTxJnCwPl2blwfxYBTnaOyXrPJpheVxjkj2ByENtA9CYk4UZZ8hNYysOtxkH2GOh+L3EZGwr5UafPf7SuafuPH/71920WRv29w8Tl0Jl9VPHrec7Tk6fDkZWWiCFtoJ8l8ELPHh3/ZYdW5sAAtO9e2DpjVXWqzhtCC8KidGbADXPv9Z9xqJycBnMlThRw/GTrUoc4q+sutZfnV+Lr0Y+jBqw60Tb5AQbjiaHjPw9TM3emiTDqrlyJiZVzBQFRUbFRU0T5OZkrvJJu0N0C1bGEUEgGNl4lmtx3WlWdPiS6xNqnpZt8MvZapu8islsTZKYSEeJqP3PRFirjuvL0Mbx/ClpbV4AcIY=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(18002099003)(22082099003)(56012099003)(11063799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Tqy/5jCc02R4rHrE70dWTVICQ/pds8VRNMdavkNCqIlha5qKPod/llr6O5Zl1afm6K3bQ6I1YFhbOR2X93Y0PmnVYjfswUBA9tY9RCHiAaA0qT+PK05945eNbid34/8txWl2sKE80C8mbo1ZFHfyxVGYSBol5e1HDpDv+vJJ8ffzgri6sf9HnI/YdSHPGePOol9IoAwiGoBUFzdfAQ0Fk0+ITjQ1lO+M3K1skFNadYKnyo6YLPKXUIgKkNjHDU+9P7gBDXMsJo3ixECdPapW0KVNUKZ3hpydG0rVH7NXjf80APGxLFfsc3UFPwAANuXWf0t0peHxSQHL3pJqEqBBeVjwel4rPWwZ1RUHZ42DANBOG3ULOwuZlt8hhA3OnIK4eI7j9I5L/ykL5SUM9nnNQ0YwT3rsCcf0mZefOI6VxMOmFx43SACd2dWct+FbagVJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 14:33:51.2572 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 97c52b63-a084-4f54-2f31-08deb0fca70c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C6190.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6456
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

From: Wenxian Wang <wenxian.wang@amd.com>

[Why]
New swizzle modes are needed for ADDR3 block support.

[How]
Add DC_ADDR3_SW_64KB_2D_Z and DC_ADDR3_SW_256KB_2D_Z enum
values to dc_hw_types.h.

Reviewed-by: Ilya Bakoulin <ilya.bakoulin@amd.com>
Signed-off-by: Wenxian Wang <wenxian.wang@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h                 | 4 +++-
 drivers/gpu/drm/amd/display/dc/hubbub/dcn401/dcn401_hubbub.c | 2 ++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_hw_types.h b/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
index c2ca08d26e37..fa64bf6e711c 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
@@ -346,7 +346,9 @@ enum swizzle_mode_addr3_values {
 	DC_ADDR3_SW_4KB_3D = 5,
 	DC_ADDR3_SW_64KB_3D = 6,
 	DC_ADDR3_SW_256KB_3D = 7,
-	DC_ADDR3_SW_MAX = 8,
+	DC_ADDR3_SW_64KB_2D_Z = 8,
+	DC_ADDR3_SW_256KB_2D_Z = 9,
+	DC_ADDR3_SW_MAX = 10,
 	DC_ADDR3_SW_UNKNOWN = DC_ADDR3_SW_MAX
 };
 
diff --git a/drivers/gpu/drm/amd/display/dc/hubbub/dcn401/dcn401_hubbub.c b/drivers/gpu/drm/amd/display/dc/hubbub/dcn401/dcn401_hubbub.c
index e12ed7591848..bf30a1bb61b7 100644
--- a/drivers/gpu/drm/amd/display/dc/hubbub/dcn401/dcn401_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/hubbub/dcn401/dcn401_hubbub.c
@@ -617,7 +617,9 @@ bool hubbub401_dcc_support_swizzle(
 			swizzle_supported = true;
 		break;
 	case DC_ADDR3_SW_64KB_2D:
+	case DC_ADDR3_SW_64KB_2D_Z:
 	case DC_ADDR3_SW_256KB_2D:
+	case DC_ADDR3_SW_256KB_2D_Z:
 		swizzle_supported = true;
 		break;
 	default:
-- 
2.43.0

