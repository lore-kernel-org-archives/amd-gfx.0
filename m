Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F29BFEA814
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Mar 2026 07:10:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C2A0F10E7AD;
	Wed, 25 Mar 2026 07:10:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HXZ/QoKb";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011031.outbound.protection.outlook.com [52.101.52.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C191A10E7AE
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Mar 2026 07:10:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yUkqigkO8RNtf6TyJYeCcVegabJ52oXU79S8Wq7wt0fimM0HNzcSNQGMNaIHsqi/OYbcS1WPjR5/VqDANULqzebH/SevPa59D2RdCf6el8GHYAPQPalfhM1eUpdDgRO+UfBQqdW0h66qfCu4IlWISlF6Z+galn95KL32tfzRe/rKTVpyLA3e24V+h2XiVHxxA5+6LBvRmW2m95Y0YoFe8tkNqLCGxeGaKlSiYls3/m/OmHZrPdHclAvv6p3gh4yLCdW0+MBAmJNHrqZ5nSiyfa84RF64lBZgFggtHCDQSrDy8CArCg4oPvPEnOb7IovBJLoRzAE869xNP4z2tHTJnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4XUif1BHkbZtufMNJJVbH2kGWxOg8iKhJbsjoji2KVc=;
 b=JfWDa/BHadPbvGQwGD6LEFEuYzy7OjwHZTnFG+0s5tGA8hcu2vx8YahMYIKNG1mVJqJ9LXtQVRmhhxdadEUFtVigjic42+XSGPrblUpHQ3fKBM5GEvBuAUDoAPxUTcmwvAOQMpX5L8FClSHFNspk8c7GYXbozddVU9ms+nyNLrwmLoyM3Z+NQiR5Pda3FmsFTsGXC0h//jHHoUJUxCsv+N7UdBu9K6+BV9mDnoCk8LQI3oEDIaFmEsOf78VG+2zZqZLgBbkKJap2ot0wfPCjO5o9MCc9kS23Rip9i5znWYZh4ANIL4mv5Fn+NopPYRDMV5yP4MdxSqTDVHNNGxfRSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4XUif1BHkbZtufMNJJVbH2kGWxOg8iKhJbsjoji2KVc=;
 b=HXZ/QoKb8P8f0KAYH2uhonoF/IALEbFPNGPu4TNszTWI7x3xlbRQGVnpjcZBROYkioed6fPn/Z3xZp5Yfn3iZabcbKbWiaoGxY67Bruiddby/3D5ljGPz1r8uOeowoiSmMqqvCAbD4PELzBZZGcNBd2izVWctL5y/VXqHK99T5s=
Received: from BL1P222CA0003.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:2c7::8)
 by PH8PR12MB7207.namprd12.prod.outlook.com (2603:10b6:510:225::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.15; Wed, 25 Mar
 2026 07:09:58 +0000
Received: from BL02EPF00021F69.namprd02.prod.outlook.com
 (2603:10b6:208:2c7:cafe::a6) by BL1P222CA0003.outlook.office365.com
 (2603:10b6:208:2c7::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Wed,
 25 Mar 2026 07:09:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F69.mail.protection.outlook.com (10.167.249.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Wed, 25 Mar 2026 07:09:57 +0000
Received: from maxMSI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 25 Mar
 2026 02:09:54 -0500
From: ChuanYu Tseng <ChuanYu.Tseng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Charlene Liu <Charlene.Liu@amd.com>, Ovidiu Bunea
 <ovidiu.bunea@amd.com>, Chuanyu Tseng <chuanyu.tseng@amd.com>
Subject: [PATCH 21/29] drm/amd/display: correct unknown plane state patch
Date: Wed, 25 Mar 2026 15:06:27 +0800
Message-ID: <20260325071003.4022594-22-ChuanYu.Tseng@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260325071003.4022594-1-ChuanYu.Tseng@amd.com>
References: <20260325071003.4022594-1-ChuanYu.Tseng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F69:EE_|PH8PR12MB7207:EE_
X-MS-Office365-Filtering-Correlation-Id: e8056151-c3ca-460a-c247-08de8a3d85f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: 6yLnA7OacLxlMsmw1qaNqJJxc+J+v8zyEXUKLUMLla6digwgp1x7ej5ZY+DivIpcQY0uFX65Ri1/XRvP13MrcSoEgDljAKOt6j0zmbAeiF5pR4twIfrAKpXwqNoCGGQG76TMjnEW09QykevNYxIkXpfgEY4z3URqsWWNYnJOtvFkxMpbr0bKsArf5+8JkpYhjyss+F/9n/hAJuAJvT0u1y80+FQxhGOWrehctXTE7h/MX8aaIdyXlXhdfFCir56zM9Vxb2SK9oC4BtoUwbAIS8uSMP0QIsxuSvimWcOVf4uV3/Y8JphxNSplIZr7dz0xWe+g692lLRQpGX/kFadf5eOHTMbAtWT8Kzf4uFG9jijdQjQGGVKzG9z5hERZ9HWlugW3zsZ3cl+5owtrBtQ79P+QwY6ogGWxtv2NoYYkxfbGLUlgIYYFJjNtB4k6ksyJJbmsyFx3f8RSDJg2hlFcuPb9ZkcXUmeMkjeOEOTw1DGd3mgZMhN0y4fEd2W2bytS7E6Nm57PtNl5qaSPIwa5HhwMvYjJhl01nkxgJDtcefleWW1PVw86Rll1iySDMckOLlV/qoCnJFILTXyFjmBqSQ376zTFETuGojAUSjrHw8bRud7s4M0XOEnhkbiGIRdS5G9RhwLEWmv09ozm4hmmeXAdUni4OLIkebkUsvK5XY/6QMaD3CCHMISdwhczj6sQx53J13Ax2w4oA0zPP4Day+lUNRazQCHcRjjzT2mCT3c7zWkBPaMAodhuo6bnRNRWpSG1J5i5XRsKnQNgI3maDw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: xxXRxfgBBeLH22LeXQ2qFUOiBOvZPmcJ/wVRXaukDn4PlluTFhe++9pyj72z+3CC3ufNUuMqlpYb22+DmLYqUPdu5t4pSW9JN747iAsboRR+ekVAWzR4KJVGOy4cXL62VfZM7lJ7KTK30FBYZqMqf3eSllyCFvCfKXMfD+xgp7YqmB4vTM9+Dcb8ADR+FoslgbwaDZngEAkXJGYePXCWKTdAOewVdnRdPg8buI9lJJH31zrgSnP6n6TylrHpWUjXpB7D/ZPvAbDUOHc4cGgRd/ipO9q/8Vqs+LjSJj2tyxLwQrBcIIYWtXHyaM3HHl+CYEKjUjW+trypQ1ziyy/u9l2TnWtBOMbAMoGq8viOjVkLLAVjJmbcBlsISF0fjSmC2Kp71Mj5DaNCP3BnLUGSYBH2gaGCgdbPTRZUn1fY7mMMmHtRitcuqpy5ADn/xPh6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 07:09:57.8061 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8056151-c3ca-460a-c247-08de8a3d85f8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F69.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7207
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

From: Charlene Liu <Charlene.Liu@amd.com>

[why]
dcn42x is using same gfx as dcn35, i.e. not use gfx_address3.

Reviewed-by: Ovidiu Bunea <ovidiu.bunea@amd.com>
Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
Signed-off-by: Chuanyu Tseng <chuanyu.tseng@amd.com>
---
 drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c
index f2a6e260f061..9d6a989d6dd2 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c
@@ -1785,7 +1785,7 @@ static struct resource_funcs dcn42_res_pool_funcs = {
 	.acquire_post_bldn_3dlut = dcn32_acquire_post_bldn_3dlut,
 	.release_post_bldn_3dlut = dcn32_release_post_bldn_3dlut,
 	.update_bw_bounding_box = dcn42_update_bw_bounding_box,
-	.patch_unknown_plane_state = dcn401_patch_unknown_plane_state,
+	.patch_unknown_plane_state = dcn35_patch_unknown_plane_state,
 	.get_panel_config_defaults = dcn42_get_panel_config_defaults,
 	.get_preferred_eng_id_dpia = dcn42_get_preferred_eng_id_dpia,
 	.update_soc_for_wm_a = dcn30_update_soc_for_wm_a,
-- 
2.43.0

