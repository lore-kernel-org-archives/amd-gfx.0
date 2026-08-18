Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FF66C5DF81
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2026 20:23:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A8C9210EC87;
	Tue, 18 Aug 2026 20:23:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EzFjYbCo";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010054.outbound.protection.outlook.com [52.101.46.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DCE610ECDB
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Aug 2026 20:23:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XZHjSBdzORLjSyG99rr5s4YvRO4giNCMwb7jy3z7mxikRkr90G8cpbP5hKIPx+KNRiJnRvr4WpyPLwTqYJIZ6KbAfAVF4yoOAphf2v+dYnMTDSn20DMbkbglxawT1w2mnY7yZrims2ZSjP//cPh3/g6WXyTxfz9QAiBeqtAB2lK0N5FwM3ZAwS/JuV89fNQvBHvvHOQI7l/MjrxKD1l4y1EIvc8rrbrkxcdEFCC/zs2j4u1n5wEedOPSgxytKhb/+wuUv6WrAnKWJsJ5mVe6TowH6cUwnf96ukd5NeT18au4Cn2XAN4d8a/RdPfu9b4eH9/hT927s4wdVfb6GcxR7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RbBXXxqn09HmPoK7DEeiRqgWuGAq+ou6sA7wAWEmd+I=;
 b=qWHLyiBOc5ObPaH1KQhMXZZNV/lFaCDCpq4s4wCTVWj/iNrwvqvC4AncsD0cqI8sUBJnzRdOiQ303n0UILUq/0ZCB3Wh7WSbOJKbqcYINvIAEe5Weu+eI2L3CyapXLmqlR6vIJAp6Xr/5zCIj8m+jp4KBkr17reGpMgadyRG3/vbSfO3edVnGDqpeZ+mrp/GVssytSjRTY/Yl1HNi8gMp/7WUoAB2An1zCSRqzZPAPT9ay8V8VvpU1U5WzX/4kG3TzIldbsVj7CjLmdNQNhIjyVeFnp8wSQquuIzCDPgThERd6yt1m6S2kc4c/NP7rEqXitwZgXiILWhj9Ujpk3VXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RbBXXxqn09HmPoK7DEeiRqgWuGAq+ou6sA7wAWEmd+I=;
 b=EzFjYbCou4F2SYwQDNlYH8goadVgUCSqfN44j2d9uaVO6FmpG0UyeZ0ZgYNh7OR4x7KgL6i6jnrnH1B207/dwi3nkPCtcy/snjm/s3DwM2+omY9hot2M82gh42jm8Oc+//dVUb/mbQH2jXwAzDtwngdL9D7UQeyeswNaOHrouYo=
Received: from MN2PR07CA0006.namprd07.prod.outlook.com (2603:10b6:208:1a0::16)
 by IA1PR12MB6211.namprd12.prod.outlook.com (2603:10b6:208:3e5::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Tue, 18 Aug
 2026 20:22:58 +0000
Received: from BN3PEPF0000B372.namprd21.prod.outlook.com
 (2603:10b6:208:1a0:cafe::12) by MN2PR07CA0006.outlook.office365.com
 (2603:10b6:208:1a0::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.8 via Frontend Transport; Tue, 18
 Aug 2026 20:22:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B372.mail.protection.outlook.com (10.167.243.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.0 via Frontend Transport; Tue, 18 Aug 2026 20:22:58 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 15:22:55 -0500
Received: from box-0.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Tue, 18 Aug 2026 15:22:55 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Taimur Hassan <Syed.Hassan@amd.com>
Subject: [PATCH 82/82] drm/amd/display: Promote DC to 3.2.395
Date: Tue, 18 Aug 2026 16:16:14 -0400
Message-ID: <20260818202139.4172592-83-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
References: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B372:EE_|IA1PR12MB6211:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c76295b-2f7b-4130-0d6f-08defd667e89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|23010399003|376014|36860700016|18002099003|22082099003|56012099006|3023799007|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: Lf18Z+DqdftYK6rOaVPtrsS06LPglXmmQcHl6Q0MmN3ZAYTEo8ha9tqyBiA5GrN+TkS+LrS0QHHhMbIiJAjSD6lAG4k7ksadW9SByGJKvJQyaw4oXZVzpIqFsj0PepgyFxvIL2AXYx3K3lnyIt4zz/qWsCpKTHcah/3KHm7x6yb6F32/dkqRQrvrvHj2fu1TWNjfB0rcPwXQQiO+WOcNwS6ip1UzmAoP9Nafjzj5r2nMt4hMvZF+RX1snF5aFoEGaKhJBZsk6d2U4zrx3BSglcHrU1WMvACyv4pNcyLx1ok01d7I4PuQQFZS1IGgMLyI9C7XR1GlVj59MWYfifLqxvDj6E3Z4i26Mddg4aSLuEk8cWdIba52VeOpxOLAs+SYZMyk80xm9OVe7CsgvB43az455P0HCnoCcf7ua8ks752XWjnlVLGgIpgoFJ1znS4JtlfPcSb+fYytLHtqDDwkD6Rpms3JMouPZ18JvCNx8VErsT1t95/rtrZ5dStBTCOJecZw8zOo9TgWHbsokz/PR5trfqnkgZeNRAOhZWozU+AKImUpeJNxnr0o+nm/0T2HUo/H51T88NVxUD80PXM4maslnl7xUanrjZRrKfl+x0R1GwkxmrWv5oo5NH2LWKMZLFo9x9ycoNC/xp9grdQTfwEDaK+4x/2UzpLgej0+eKnZPVgdZ9af8giLCGrEMWKQFatKsqCIWkR9LpffDxW70g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(23010399003)(376014)(36860700016)(18002099003)(22082099003)(56012099006)(3023799007)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: V9rzNFQsUrNI8QMijWc0r8kvCG9/mIoxzCztrjtV1kGVzsshNmJTDKTWrRbx1SFtVNIelaQvEt9KcSWFXsFcIdlIB5dIf76swgp3+ent4RP6IDjQ50ucRkrB1g53LmUhB5M0xYmBSufupDxPU5abx6iz0flTmLOatHR9AUuwlPJmgExQRGdM0UYF389MPeou1qrJGjWORMyt7Cf2tw3BUxkLSlgzfvljjARSYCZnEBPhQcSIXX5/luMnx14nwq0cKsvFRqpWnpXTHSvlKGuoxU93F4qO5Q4JX4tX/PVTLTbob/LtPUUpZZ+9JL4A+HJ/c78rLl5zRrtR0wlo+u+0kwFt6+uqtgfnfHLXKR3ilAHROiDMXMgUpJP6Ydhj0e2v/O9Ga66zHT57aDuFDlY9ZAqnWWfOLPVdfFiaPXWzTiYfYU/hJ6BJWiu0OyL+SR4v
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 20:22:58.4161 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c76295b-2f7b-4130-0d6f-08defd667e89
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B372.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6211
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

This version brings along the following updates:

 - Fix HPO test regressions.
 - Refactor DPP_SET_INPUT_TRANSFER_FUNC to drop pipe_ctx params.
 - Use fast update path for address-only plane flips.
 - Split OPTC_PIPE_CONTROL_LOCK into smaller helpers.
 - Fix DPREFCLK override when SMU isn't available.
 - Fix CalculateFlipSchedule calculation.
 - Add hook to disable alt-ch in PMO.
 - Update alt-ch size calculations.
 - Enable min dispclk ODM on DCN42.
 - Remove RMCM tetrahedral cube from dc_plane_state.
 - Fix mismatch number of OPP/DPP accounting.
 - Adjust vblank_nom policy for HW SDP throttling.
 - Add passthrough visual confirm.
 - Expand amdgpu_dm KUnit test coverage across cursor, MST, EDID, HDMI,
   IRQ, i2c, framebuffer, tiling/modifier and HPD paths.
 - Various fixes for Kunit tests related to HDMI FRL, IRQ and cursors.

Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Taimur Hassan <Syed.Hassan@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index d59c23971ef8e..a5a9791ee1000 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -66,7 +66,7 @@ struct dcn_dsc_reg_state;
 struct dcn_optc_reg_state;
 struct dcn_dccg_reg_state;
 
-#define DC_VER "3.2.394"
+#define DC_VER "3.2.395"
 
 /**
  * MAX_SURFACES - representative of the upper bound of surfaces that can be piped to a single CRTC
-- 
2.43.0

