Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5A60C79FA1
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Sep 2026 11:43:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5ED3E10EB71;
	Tue,  8 Sep 2026 11:43:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cx8Zd+ut";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011069.outbound.protection.outlook.com [52.101.52.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 08E1710EB71
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Sep 2026 11:43:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UfMfAHC9XuDlKcEFA4uILFn8ShIaI2wQxxV+XQKig55QoWfDx7UbVTbP6KMrIFzWVu0hsIUPmdIm3LBuaTJGd0QsI3dsoKz+4npPOYyzvwWBrvh686Sz+Z/YudOZYjoUiHSuwxqQq7KM9dgUUoxDED89+ZjXfZgmMMVNNeWFz2HKu/xgbw46hqDhKJPPMbTWLjtdp/s0fKAV/k50Ri4E7RV8+dkV3P1Tu0xOuPl4GcgtZf3l6bH8LA4EA2ijfhZCmM7nJ+vKTLXEpvPbcFGPopeiGnCo2HplQAbXxdujYNPFmTeNSjfR9N8vbTutkIgpazvugLcFWghWfnzGhx8TkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XLo9m3RIE+OhId5nGTZxTiE8qaiV1fSOKCRTS8m1Xk4=;
 b=FtxxxhOk1bR1SdBWOj48ITNbU5uUybfMXsUIZEp5OH5OZwUoFELkohpYtpPQlxZRZqYURLK9G13F8RAjbmhuP6tArdfBes9DbrABWVGUbWr9evrKswH1jHo6eI6p3Ww62HdnPRoZSJL7uu9fCA2S2yUDOaPdZL6PTQqyNI777BfdNON6tzX+a5qiR1OYhontKJUQQeG3aGmQNahwD/NzilNw7kG9IIN3S4Vk4b/DhP8qMPynafx1mBoSi9c1BUgeyC9JDrzRLO5xZ3wn1YqJZijx61fDd6rf27xOGrF/P7g/EsunwKuDNEI8FtooDWFgfIi9EOK2lyOEkv7AWcOG0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XLo9m3RIE+OhId5nGTZxTiE8qaiV1fSOKCRTS8m1Xk4=;
 b=cx8Zd+utTtw/NCp8LWhS3AjDbib4phhHT/+dhcD3H0mkZ3W5vzIl1mvCjZE/JQX55kh3jukscVlH6+X2DbmdYJdi5a3raSkALY4FtkAF1OORlhiMreXB2Uf65gwACDHjXGoWM/qoQ+DUpZlzOmIlAkbdog+2GEYQhBFsgtR8W4w=
Received: from MN2PR07CA0004.namprd07.prod.outlook.com (2603:10b6:208:1a0::14)
 by DS0PR12MB6461.namprd12.prod.outlook.com (2603:10b6:8:c7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Tue, 8 Sep 2026
 11:43:05 +0000
Received: from BN7PEPF000000A2.namprd04.prod.outlook.com
 (2603:10b6:208:1a0:cafe::ac) by MN2PR07CA0004.outlook.office365.com
 (2603:10b6:208:1a0::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.12 via Frontend Transport; Tue, 8
 Sep 2026 11:43:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN7PEPF000000A2.mail.protection.outlook.com (10.167.248.154) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 11:43:05 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 06:42:47 -0500
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Tue, 8 Sep 2026 06:42:38 -0500
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Gabe Teeger <gabe.teeger@amd.com>, Matthew Stewart
 <matthew.stewart2@amd.com>, Dillon Varone <dillon.varone@amd.com>, "Chenyu
 Chen" <chen-yu.chen@amd.com>
Subject: [PATCH 57/66] drm/amd/display: Remove MALL capabilities from DCN42B
 bounding box
Date: Tue, 8 Sep 2026 19:31:50 +0800
Message-ID: <20260908113338.2433445-58-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260908113338.2433445-1-chen-yu.chen@amd.com>
References: <20260908113338.2433445-1-chen-yu.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PEPF000000A2:EE_|DS0PR12MB6461:EE_
X-MS-Office365-Filtering-Correlation-Id: 918fd13f-1462-4b03-9f96-08df0d9e587c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|23010399003|1800799024|6133799003|18002099003|22082099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: BtJb3MYVLCaDnnZc8lYxwgL3H50AKY18MO0kHgXzqNZ2H+hbqkIwiEShMM8zvTpea8Cm68b+PGlaGlLFwHuJHYWeGftkW0QVr6HJiwil+vVDF63iQuMmA3d6skm6aACxh8QVa+BuHsFjpKHwUyyjf5x7muLozIoWFCLuLcZ4D9Fj2/vwfoaJht/SowYM+1u4moHbANCkqSiIY9Gw5+RPMFjzWAy2Ow9v/jdyOVdoz9r5Tq6jLxchyKcSWF+K3BvP5hVhraajESVFWYwTEfnCZW4m/PyQ8lYiK3mjPz1p5P1qdxQLxRW1K/IGEjopdG7vL3UbGzd5isD9fr3tAKmSKNCM0O5Hjd5A6T12uBmyC+Tbdg47YljWk6SaQLKu+2giHiA3UTM0RmNcq4hLJJPnUUHKsKXb+dIvEOC5zoDz0GUY8+LAsAq3TMzVNydY0JmlVbc0fsGeNsD2GH+DKhkRupFyjAbEYhCic6FK6bTWqNgS3aIxPF4IbklN0Gs7u1PVfZfQ/VeBXLTCp618s3pFXzSVfZE8kkPWDC/7C6MyS93eolhTlZ0Bs2nNKqL/6WAbaOmlexBb50rWOFjsgUGVWugDouZnE49OSspt2oslpsj4mdJ9SF/im4EM8l2H793jWSkbEIRVSVvV4lmW/6JT1rc7GwRN6ZLkiJwRvAs6f9/nDW7/Bf7DEBUqU7KJGM/eMh3Ff/+ANeD6fc7nDGdM3w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(23010399003)(1800799024)(6133799003)(18002099003)(22082099003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: OOgVREnBbSURFfTqCKREeM5Jn9syTQ0+H0AS30na8kiCwFgnsJcz/xq0WuoY2Nh7Cm6qXgi5437Pcern/kUV+QgorRqqt6MzjiTqBNiX8RP/uFl0EAnKq8MkZd9Ck+QoEVpMhl+MzLn2k2ACSD30ICq/28xmGSDCM4RGRsBJEElStd0SdCyvDLxC3bzsrnp2LBmqqASGLgJZxbrWjdeSZ6toApLwNhR8N6ZXt07rdy1FlJjkaQ61CNPTY96B9Sx/GVW2141KvvtnmPZ2aT+N/KCVU1Nl8eqnsm+2js7vRtCPFXEEJR3VjlSqEyHGfk7NbWykKfKo1Zjo9cqQkzeIwNGvKVgXQU+cFIaR2xuiYk0ktZY0iICUcNVnM8Q28TN62yhUP/K+QSBU7BUR6N62RKZHkUgqqAH9Rha7nSOaaBnzZkdxpCzDHEUZ8IS1326n
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 11:43:05.0033 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 918fd13f-1462-4b03-9f96-08df0d9e587c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN7PEPF000000A2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6461
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

From: Gabe Teeger <gabe.teeger@amd.com>

[Why]
DCN42B has no MALL, but MALL capabilities are non-zero.

[How]
Zero out MALL capabilities in the dcn42b bounding box.

Reviewed-by: Matthew Stewart <matthew.stewart2@amd.com>
Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Gabe Teeger <gabe.teeger@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
---
 .../display/dc/dml2_0/dml21/inc/bounding_boxes/dcn42b_soc_bb.h  | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/bounding_boxes/dcn42b_soc_bb.h b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/bounding_boxes/dcn42b_soc_bb.h
index 0f8666788bbb..e83a9ac018db 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/bounding_boxes/dcn42b_soc_bb.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/bounding_boxes/dcn42b_soc_bb.h
@@ -202,7 +202,7 @@ static const struct dml2_soc_bb dml2_socbb_dcn42b = {
 	.xtalclk_mhz = 24,
 	.pcie_refclk_mhz = 100,
 	.dchub_refclk_mhz = 50,
-	.mall_allocated_for_dcn_mbytes = 64,
+	.mall_allocated_for_dcn_mbytes = 0,
 	.max_outstanding_reqs = 256,
 	.fabric_datapath_to_dcn_data_return_bytes = 32,
 	.return_bus_width_bytes = 64,
-- 
2.43.0

