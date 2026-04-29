Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FF65FF8875
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Apr 2026 01:54:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A4BC10EE20;
	Wed, 29 Apr 2026 01:54:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bCXSlu+4";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012007.outbound.protection.outlook.com
 [40.107.200.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3FB1610EE20
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Apr 2026 01:54:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LQE3AbxxJExL0x3+9iPibgU5vpGcyGm4XAtD/NDLlAOdntFzqbHV2NhRMunhmU0Z6wzpWTJqqhE60YdKiawWi/al+5f76c/Ud/O9lIyER5SqpN1fZN3gAw7d+Luw9EZ31TAzAlwPdv8oTDcTrh7+NTF+h9pTSbfEAp3kU4luV/bxhNMpba73VQmYiseo7YjnON8lpU/dK86b8CcxYPGlytlDwl5S6vm/00vFOOItEVqupYlrrsiyy2DrmwDFyi/Bqd37tHeb4OZe29rmwvKOBR8h23pQWQWFytuPcYPXQNbqzVsUgpfz8pHLby0DhdDZWc+CE/gzW7Km9GZOZW5q6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zaXdjffCaV6CjrHyP9gy1vH1ZyNLs3rb0pPw4zYA9HA=;
 b=eZ2to5uG6V41AOKbsyHLJ8wSKELNw9VRjXyKJFiXfLsgjB+gAzIJ60qDd0uLZW6rTtWHj4JbwWdgGCRlfHy8jGu6+dGiOa3Ak/zkMjv51URUtfgfvyS7v3tdD8SelXSTE4b9MCEjkK92GOTi3A4OQid9Tv+RS3MgGMpdnSEsT9c8/BqV/g/Pqyr3VoljjDYs7NBZGwdaipWDqlbZ71bGsu6LxyAM+S8ENhkJyO1/ht96ytkw/IYDRJO2ttPb8vp61NVWuYGdSAmj0hoKsXHryQo4K2H4R0Yi476x6eCsYGNXuhrnuJ2yBVqU5SnM7ALeXMSL6ZThVrmM3wEYkX0ggw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zaXdjffCaV6CjrHyP9gy1vH1ZyNLs3rb0pPw4zYA9HA=;
 b=bCXSlu+4LAvzw0BfQE6aJsOrmOvic2N6A0xqjcDMAdbPhyxhtYDKzuJxn0+bm+TNT/hEHnsWMQlAadqL7QLqBTIy3OovPwcekuXW5/n//j9I0AJ3fjXK0kKPElucTD1wnmbUqqHwiP/qzR8bkceQxjUAR5jRbntuPOzXXRraJfk=
Received: from BN9PR03CA0978.namprd03.prod.outlook.com (2603:10b6:408:109::23)
 by PH0PR12MB8030.namprd12.prod.outlook.com (2603:10b6:510:28d::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.18; Wed, 29 Apr
 2026 01:54:32 +0000
Received: from BN1PEPF00006001.namprd05.prod.outlook.com
 (2603:10b6:408:109:cafe::26) by BN9PR03CA0978.outlook.office365.com
 (2603:10b6:408:109::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.26 via Frontend Transport; Wed,
 29 Apr 2026 01:54:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00006001.mail.protection.outlook.com (10.167.243.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Wed, 29 Apr 2026 01:54:31 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 28 Apr
 2026 20:54:31 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 28 Apr
 2026 20:54:30 -0500
Received: from james-Birman-PHX.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via
 Frontend Transport; Tue, 28 Apr 2026 20:54:22 -0500
From: James Lin <PingLei.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Taimur Hassan <Syed.Hassan@amd.com>, James Lin
 <pinglei.lin@amd.com>
Subject: [PATCH 17/17] drm/amd/display: Promote DC to 3.2.381
Date: Wed, 29 Apr 2026 09:19:26 +0800
Message-ID: <20260429012055.2065869-18-PingLei.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260429012055.2065869-1-PingLei.Lin@amd.com>
References: <20260429012055.2065869-1-PingLei.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: PingLei.Lin@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006001:EE_|PH0PR12MB8030:EE_
X-MS-Office365-Filtering-Correlation-Id: 12c93cf1-5a68-4f67-a50a-08dea5924194
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: d1Eycd7k6WDMWL54+fluDpVX33CKPbGBimdd7W0izbLOOZWRHk+/31y0YpQgfAJr8RhE4uZOZHXWQgJKtyY/7MgwC2k2W1t/MLqYFZY6yQuxL9UmkYbNnCJv0fxDPHV8j9YtvU3b/I7K0oa5BHlsLQzfHRzM9pNFy2jCstihH23ejyo+WKxqVn5pdJZ0I5QO/Cs8QlRJ09+twccRs/jsodT/oAqAwwzbkXL63j/A1nHk9gpC2K4iOTV/WMjZJEa3uAvshmYv4dJTwINZFyBm43xKp20C/6xPZvs21PnKeO2P6Oaes3gdl+eiZKM69T6FZVSFr+kvDkLtG7UbYlIWqfEuA1yLBdJXM0ex9ogH1EGDyqhGDeEdshJCaCxMOmFgMrpUUtN8XKcl474nEt1hlJqBFnTuKvB3xLKIthYM/SbUGZV0GvVB0qROFxgwiNaOCHDDadXHqcJA2iatydwJOK2KDJL9Gxjyo2iL8Y4TUvYNI8ffEvETGzQSL/IOFGa3yQdYeZELCPOwXf5Yj7JJ37kNYVs5TqpDgW1c2CxEEHzOUU8e+w+afTiO0Puo97i+bXHFqBzAE4c/ezAnuywfLOE3tmaNFKw4dULqVUr16kjsbe6IBFhodk/GJ5XVmUrMMEbNPrUO/h8Tv+nKyP5CSBsaplF+U5UiNmZ+HWH0XhAf0A77rIUymgsIW3/MJZxbGN077eV8dYeedwgxAl4a48IyFz3J7mKOcvk5vikdJuVtWPhi/aMDxtNYYwh+y8g8v3lyE/2K2TvwU0AtAl7uGA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Zx9g5PN95gIRlDHkxyepcRd9CdakeZimqPUfyHQoWyypj9pfgz+bWw91OYK6TlAFREyTvhVRIN5rV/sQgJ3xa9nMPy9B0qLUhKsbISZ0Q6opL5LJXuVNioZbbtzyS2SzU1L8hf4dbgtYvpBkf7OlIBqcoe/OdGcBTiOgEqYAfIZCWMa020F4hfNUnz/kxwOL5fpk6e20xfdCJ+T0L6aDm9yOsi5uh6LWip4xHupq1ncCOD8bPwRnEFHpJrC/ouf6WCQvUgNEv5DlqcdbKoEeM+EokN2S9j/ADOBU4wghzEDpIo+xy3hF9yKYq1G2ilrTy/9vwg64D0bd/JXT/FyL+LYdbw9Gkh5R2umgsSoZPtrUaqAah7hp0hpV2ZTmp4tE8xG/2Fab+DA7XmvxTE/7DuwNRvH3nLlDj8xsF+I50VoBv/reS4bRtyJxspJwf70P
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 01:54:31.6814 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12c93cf1-5a68-4f67-a50a-08dea5924194
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00006001.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8030
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

From: Taimur Hassan <Syed.Hassan@amd.com>

This version brings along following update:
-add max bandwidth budget to QoS interface
-Update tmz field for LSDMA
-fix buffer overruns warnings
-add memory bandwidth override debug interface
-Find link encoder for flexible DIG mapping cases
-Fix type mismatches using guards and explicit casts
-Fix type mismatches in DC and DMUB modules
-Skip HDR metadata update when Smart Power OLED enabled
-Rename backlight_properties to pwr_backlight_properties
-remove watermark range notify
-Clean Up Legacy DML Content
-Implement block sequencing infrastructure for modular hardware operations.
-Do DML float narrowing explicit
-Fix type mismatches in DML and normalize loop bounds
-Remove unused state param from enable_link_analog
-Fix Color Manager (3DLUT, Shaper, Blend)

Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Taimur Hassan <Syed.Hassan@amd.com>
Signed-off-by: James Lin <pinglei.lin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index cc288eb19d04..01e30c35c240 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -63,7 +63,7 @@ struct dcn_dsc_reg_state;
 struct dcn_optc_reg_state;
 struct dcn_dccg_reg_state;
 
-#define DC_VER "3.2.380"
+#define DC_VER "3.2.381"
 
 /**
  * MAX_SURFACES - representative of the upper bound of surfaces that can be piped to a single CRTC
-- 
2.43.0

