Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66F8CC5DF97
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Aug 2026 23:35:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CED2210EE6E;
	Wed, 26 Aug 2026 23:35:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tSJm53cj";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012037.outbound.protection.outlook.com
 [40.107.200.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45F9B10EE6E
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Aug 2026 23:35:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nxELK0+eOveyOMsk0C2nEa6EdI4VVwuZJovGURNqIzecB8+isin+hJLjPcZcFNgabMZk/PFmQ+a8pl78dW38nbTmSCCl4jwfU+Y1gkshsDKpSr0Cyg419/eumm5G19m2PGqG0Cky+xSWpJQHbRZmaBClNQIxideHs+KTuVKGNQuj9yelMvfo/kyo2+XYT9SPLYBpPTagFkC+jGErqYm6lv85Tg4rAXa8tY0CzBBYvMMY3U4fY82EjnU+tule6frDo6ZMvbzUfIpW3jsd9spXbM3oQBZYWZE5ltp87OwCyQ42FLUyqFeTX3AxaJQVpclZquQ4+vJQ/iVYOJqDCrFCbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9QqMgDecKl/hl97EEBt7zxgXxy6v+HIPkd1TVnh1jnc=;
 b=mMwY1JZt1BQ+NY55+nQB5ubK/EfN+z2NpbBmPJKA8Le28C8Og8Fm0nVFf6d130OQUhUVJjrWtPqMIQsRkvlDlV0ghojLrw3xqskTxCVtU5z05H0N40dMMzymLj9ABNYfnPWo4qhWACVrIKWJEevHdFfd6dz2by/W25x0y+DBDeWgZ3M8F4WFKXrvFzmTFsDKXEJpzC8dfp1s7/dfG/ixXk6ZvvKn/D1TSSpwrMsDSv+K7c7aQNUpPw/Ak4AIcMUOrvH7NEvtka/Q7pxw4fEKemxWadETuwzfXCXFC7dnRGAUy2nGQUQqqtsMbf+t6KPvJgD8UtAXPR5HJadv2zVsPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 149.199.90.133) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=quarantine sp=quarantine pct=100)
 action=quarantine header.from=amd.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9QqMgDecKl/hl97EEBt7zxgXxy6v+HIPkd1TVnh1jnc=;
 b=tSJm53cjlBw1lGVC9eJOojLYzt3wHGPDgjhp8UJqUnC/UDQoTF8pEKMXqlKWKKhzGT/SCe6G7fBUVHdqwzmHvqDHVy9KWb9J0SdUGdL+6wcH5caxEBYD67gZJQhjavAJzlECmJ8UPKH0UaZRmGeMvRxWlVsATx2Epu+huqwH7Yw=
Received: from MN0P221CA0022.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:52a::35)
 by SA1PR12MB6701.namprd12.prod.outlook.com (2603:10b6:806:251::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.9; Wed, 26 Aug
 2026 23:35:40 +0000
Received: from BL6PEPF0001AB4D.namprd04.prod.outlook.com
 (2603:10b6:208:52a:cafe::4d) by MN0P221CA0022.outlook.office365.com
 (2603:10b6:208:52a::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.10 via Frontend Transport; Wed,
 26 Aug 2026 23:35:40 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 149.199.90.133) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 149.199.90.133 as permitted sender)
Received: from satlexmb07.amd.com (149.199.90.133) by
 BL6PEPF0001AB4D.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Wed, 26 Aug 2026 23:35:39 +0000
Received: from localhost.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 26 Aug
 2026 18:35:33 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Taimur Hassan <Syed.Hassan@amd.com>
Subject: [PATCH 59/59] drm/amd/display: Promote DC to 3.2.396
Date: Wed, 26 Aug 2026 17:05:30 -0600
Message-ID: <20260826231519.881949-60-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260826231519.881949-1-alex.hung@amd.com>
References: <20260826231519.881949-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4D:EE_|SA1PR12MB6701:EE_
X-MS-Office365-Filtering-Correlation-Id: 76374041-b591-4793-8d2e-08df03cabcb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|82310400026|36860700016|10067099003|22082099003|18002099003|56012099006|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info: PWs2xTLbs6LeuxyqytF2BIuwCvVLGlIWJnUZywF8wenugZ2PoQ5GSGEIEpGOk8P+XPQYuj/vrCeZz+3dcWXPwcoBGI2sj7vKC0QH13Y2T5GNp8t2Fo5G8kA+25VPdrSMiafhWjBJ3c+TcsBI6S8v9EyL76TFB9uxrSEXTe65FgZ1NPaR/mL3SWDEXva1FQa0veg2QTb0mdDjyevTDhq+6RRg1h6HAVAKB4z3RHil9qNTJynHGP/lHfEDPi4zYcaAmCvVq7CVUjD4R6DR5DfECbueujYdFnL93LTzYELE2BSU1JPXA0YaHUodwO3Eavb0PBEK70SoK09ZYP8RJ2CPvqukwayYRwVfb//WSBxc3qTWuThABTn9pxvdPtZ7IkqZed4n3JW2L5w1sH4PKBOVHJnFxKc4hx3v7Ep94DmhdgWfX7fnFORrHEOGAZjLoq2WF2sFNRPqLXisj4VIbEmqT4MNzRkztUysrfYOwhRu8UfNWTtz0rIsKzoCbu8iLS1cYqqsbyfSdJYYdUX9MfwVT0GlvJ1kU0EAirhpH2TuTQBzg9x8B27827ivMISdZLBbGDh/0jj1FU9Nnpi9qUHSByvR8ypqHJzqVO+J4KSkcf5sWB0nvSRF4oV/pSVpHoiBe/5lNkTp7LKWWmG4pTiRvAv3nA6EdzZ8nGPfvE1u0BTk7IzFToR/CS3J90wB885rDQ2DvUBtB3CtykuPohHAJw==
X-Forefront-Antispam-Report: CIP:149.199.90.133; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:unknown-90-133.xilinx.com;
 CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(82310400026)(36860700016)(10067099003)(22082099003)(18002099003)(56012099006)(11063799006)(5023799004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: VE8FAdwYPhLoT75dM9+TJ31tu3HxgGD3PnExEDxkX+Xxktucc7U5jBLxbljWOOXIdRs6RdJuxgd8i+zbI/sv2DhU8Wc/6Lgpdvgqto9nr1nxYf4XsFQvAIS8HqDv8RM235IMQY+7oY3se8iO1zjWllD/osOONCQtQWBbJ+yf3U1y37kEGXwHZmLBLw+fG79sP2dAKI/gMfPfmXTSwXI59yPzZNbUchD4zhebUIK/6/x8ybzmKfYSqKFkYmOSwYIoaoTN6+G60Ye+XTCkLZ7gQF81y1qfpLE6I9aLvqyj36qOmz2CJ0teAXDhPqx0bNqrzzLo94N2Xdj/8pB4nbSiGT06xthJz5PEc6CrB/TWGpmyjRy9bSa3IvCnMhzwBgDvQ7YUjdZU2x4utfvJJkifFq7TwW95P+IFQyC6IZ03RCr/pLvtRvNlTAnejX8yR5l2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2026 23:35:39.2365 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 76374041-b591-4793-8d2e-08df03cabcb1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[149.199.90.133];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6701
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

 - Move the DML wrapper out of DML2 into its own component.
 - Expand amdgpu_dm KUnit coverage across DM init, teardown and IRQs.
 - Add KUnit tests to cover amdgpu_dm_* modules
 - Remove fixpt and custom float duplicated code.
 - Move custom float structures from opp.h to custom_float.h.
 - Fix the DPP PRE_GAM register offset on DCN60.
 - Update HDMI link rate and DSC handling for DCN60.
 - Fix DCN5/6 DML2 compilation warnings.
 - Fix order of operation in CalculateFlipSchedule.
 - Clean up the per-DPM struct.
 - Remove the const qualifier from non-pointer fields.
 - Model ASSERT as a path terminator.
 - Set the gpuvm min page size to 4K on dcn35/36.
 - Fix backlight control for luminance-capable OLED panels.
 - Restore the native cursor mode early return for disabled CRTCs.
 - Move cursor SDR white level calculation out of the hwss executor.
 - Avoid a NULL hubp deref for the remaining mpcc_id assignment.
 - Guard DAL port idle optimizations by ASIC revision.
 - Change RBBMIF timeout control conditions.
 - Re-enable multi-dwb support.
 - Remove the pipe_ctx param from MPC_VISUAL_CONFIRM.
 - Add a debug bit for force p2cpm.
 - Add a max_downscale_src_width debugfs for IGT validation.

Signed-off-by: Taimur Hassan <Syed.Hassan@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index c7d5d60ff4c6..e1f1b0602b6d 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -66,7 +66,7 @@ struct dcn_dsc_reg_state;
 struct dcn_optc_reg_state;
 struct dcn_dccg_reg_state;
 
-#define DC_VER "3.2.395"
+#define DC_VER "3.2.396"
 
 /**
  * MAX_SURFACES - representative of the upper bound of surfaces that can be piped to a single CRTC
-- 
2.43.0

