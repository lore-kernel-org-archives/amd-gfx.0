Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAC10FF4934
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Mar 2026 03:12:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72B2C10E255;
	Mon, 30 Mar 2026 03:12:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AnJeCUEQ";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012056.outbound.protection.outlook.com [52.101.53.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 56E5410E255
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Mar 2026 03:12:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BgDD3MYZ1JRLuB0cHAqBr37Twv3fY8g2AeQOc285jCDv6zspgNkVbD9O/gDgrGqDDIZKqeQspzO+/I89vBxoBuUnhxj6nptcPhC/A6cVPDV6vauIQWdEmapxfVbQMCpZALydhIq79OtUZ2YsoddHcz9fL+kTujq0lC3TwkugSj2jFdUzaSi4uOyaYida8ugiJ7PdzGQOk6Fg245fifSLfmlmbSD+fA+HBWPEXAprW4lL6ZXqy5nVhJdA+4+ZU5sGmICd3cWi6hUZ+lk0M4b9Fm8bUh+qGyWWJBBJbNf46hj7x+huog5izMruzOVyecl1iuzi0mwl6C/gBXhy/wirjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PxTpOt4sqIDoqRt8IxOikQqJc7hoWrevstgsiXPzhMs=;
 b=X42Rv3vv00hQeIUvFwiQe7ebiL6imPyBou3YfLPg8LfMest6BLFeMgLyRodHyN5n7PB+BGBY4TnXOPRPhY5DxmfpnUzo8xJWJr8pYoz8Pu4giTTwW4Ht9MEqNPmwcSs2d5t538nuxhfYCOhTjd4Gg1iWqQkBdzFXS5zBJo92n/0O/U3yVA6xO9AwsGhTuVPLbZKQWqZZqKYxk/SalMt+3K+12kQAuOvw5fEmvjpuBqBVu12TPSqQuV7WtxtvTM6C9PJENZ4KIlrUZqQ3ea6doYBWTNrjXhtI0/D4MxBh2lpslSM97HxnBm5Ipeq6cAhuU6kvSZBZ7uMPQGabcbNRAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PxTpOt4sqIDoqRt8IxOikQqJc7hoWrevstgsiXPzhMs=;
 b=AnJeCUEQi0b3HTvp7tCqPgu+mDieEow+5BBi9LLpHWJTeGQlIKvgXjE8ItprFDG7i6xVE/RcTfRxBySBbJHUW15WaJ7VvwpGX4HgznfTwKegTqD1O5R3wlkrwUI98z+aOpnvgRiymgkP1QaenuVItqu8HdFsibZYJKXM9iYA9Sw=
Received: from PH7P220CA0143.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:327::25)
 by CY3PR12MB9654.namprd12.prod.outlook.com (2603:10b6:930:ff::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 03:12:53 +0000
Received: from CY4PEPF0000EE3B.namprd03.prod.outlook.com
 (2603:10b6:510:327:cafe::d1) by PH7P220CA0143.outlook.office365.com
 (2603:10b6:510:327::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Mon,
 30 Mar 2026 03:12:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE3B.mail.protection.outlook.com (10.167.242.14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Mon, 30 Mar 2026 03:12:51 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 29 Mar 2026 22:12:48 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Alex Hung <alex.hung@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Ray Wu <ray.wu@amd.com>, Leo Li
 <sunpeng.li@amd.com>, Roman Li <roman.li@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Mario Limonciello <superm1@kernel.org>
Subject: [PATCH] drm/amd/display: Fix parameter mismatch in panel self-refresh
 helper
Date: Mon, 30 Mar 2026 08:42:29 +0530
Message-ID: <20260330031229.2157972-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3B:EE_|CY3PR12MB9654:EE_
X-MS-Office365-Filtering-Correlation-Id: c93ccdec-6e1e-4985-0477-08de8e0a3ac0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: kd5z2sjGzN+r188JeT8tTDwey/V3TNuPQnRatCueXq7ztzRVbT/R+pzN4qBHsK2U0DNuCCiindS8oIDAvzLBXmn4HkTZvFMvZFlDr04tg7BDV0kGaiXEJUt4YiooIHohXyPbQqC73PDstO3xl1k8xxV/LpugyZ2GuiW3N1zIw5RTNdYcjIw8tF47n+gpVF1JgEFKG3Bc6UXFCq17FzBV2AyytLYGtMLMKbtmiQ9LzATm5C8MaWZy7oi9fbKDkvUgdUKbPDdW/7vbAYBIOCPGGRKnVgA7VF750hIcWcunsWb+LsuexTug1KaiMr2tzZYJ4I9TlGuznHRl076twbjsac9W7bZTIvluo5gpGEfsAAKPYQwnC8BWUJS8CHOFB8F5fU+aIBK+vC188SVav+rrU/i7927sNNSfUF7krBVs7pHzRR1723BiyRO0YQSQHphF1kMgDlhfYFfr3tca5Nz1n+Y0I5vM4T3odcZ8nkRwFf+gYZd8kBXK5cKdQlZbBLH/qaGKg9aCbVFZi9BbDAtSoj7oCRgJ7FnyuTsfSXhkqXPgSbXtTfuqPIx+/T8eBhIDiZKQXwBpfPiCdR+Uplt+rpXa3V4T8YSfFs732xaBEZgSeBfAlJwsBGInHp0GBuh+LnyHGgrevKNK8HXy+6mhhnI3+TMwpWHJYVTSJmFOuJSHlPP1vb1++27FyiPtv9eoSkc6KUXbO03uGheTB6GzhW+J6yijpnWYFwqU+JgChWxtlDEsCVeLvHa1cK0pi/05nOBRTLeIV8Aw4ZyCOOAzww==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: BNRFwH14UfIdrrXa7bQRRPHeGQ/R+KNKDfJgy4AeW6f4pH/wWDyXV3HZ3LPun726x616x/EpUq2BTS6Hcwriw7Fu0CP0lHbP7MJ8st+pBtNe3Dz/rBNjzLk+PWorFAgJh+N8rgKSwC0Pnln1RXjZuM08N3rXe1jThrbPK5OfU1efXGQ/TBXuXEn+JZ/k/zHKVFGnrczK5m+TfPW70Vp96wbLEjR0VY/GfR2JWUtSeI+bp0n+ylQGCkQoWhMyVXYtdQ92zoGDa03wQEunikQvYwiCZbMlHvgqlP48GASf0zqNBLknS+h1HQyXx8IfFENzUGyUUyCXWMZDIPyBr5c5iueazxs1bhUrNlK0DT8EXKaMD2G7umqnT6F/N62nSg1sdK/JPYa9it5qb8yx5AT6hiUTU1yuyHSgYNA1c5snuDHGl7JW8qgbukj5V6RRcu0X
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 03:12:51.8797 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c93ccdec-6e1e-4985-0477-08de8e0a3ac0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9654
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

Align parameter names with function arguments.

The function controls panel self-refresh enable/disable based on vblank
and VRR state.

Fixes the below with gcc W=1:
../display/amdgpu_dm/amdgpu_dm_crtc.c:131 function parameter 'dm' not described in 'amdgpu_dm_crtc_set_panel_sr_feature'
../display/amdgpu_dm/amdgpu_dm_crtc.c:131 function parameter 'acrtc' not described in 'amdgpu_dm_crtc_set_panel_sr_feature'
../display/amdgpu_dm/amdgpu_dm_crtc.c:131 function parameter 'stream' not described in 'amdgpu_dm_crtc_set_panel_sr_feature'
../display/amdgpu_dm/amdgpu_dm_crtc.c:131 function parameter 'dm' not described in 'amdgpu_dm_crtc_set_panel_sr_feature'
../display/amdgpu_dm/amdgpu_dm_crtc.c:131 function parameter 'acrtc' not described in 'amdgpu_dm_crtc_set_panel_sr_feature'
../display/amdgpu_dm/amdgpu_dm_crtc.c:131 function parameter 'stream' not described in 'amdgpu_dm_crtc_set_panel_sr_feature'

Fixes: 0b572a6bf04a6 ("drm/amd/display: Add Idle state manager(ISM)")
Cc: Ray Wu <ray.wu@amd.com>
Cc: Leo Li <sunpeng.li@amd.com>
Cc: Roman Li <roman.li@amd.com>
Cc: Alex Hung <alex.hung@amd.com>
Cc: Tom Chung <chiahsuan.chung@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Mario Limonciello (AMD) <superm1@kernel.org>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_crtc.c    | 21 +++++++++----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
index 08f06342b01e..26f3d513576b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
@@ -101,23 +101,22 @@ bool amdgpu_dm_crtc_vrr_active(const struct dm_crtc_state *dm_state)
 
 /**
  * amdgpu_dm_crtc_set_panel_sr_feature() - Manage panel self-refresh features.
- *
- * @vblank_work:    is a pointer to a struct vblank_control_work object.
- * @vblank_enabled: indicates whether the DRM vblank counter is currently
- *                  enabled (true) or disabled (false).
- * @allow_sr_entry: represents whether entry into the self-refresh mode is
- *                  allowed (true) or not allowed (false).
+ * @dm: amdgpu display manager instance.
+ * @acrtc: CRTC whose panel self-refresh state is being updated.
+ * @stream: DC stream associated with @acrtc.
+ * @vblank_enabled: Whether the DRM vblank counter is currently enabled.
+ * @allow_sr_entry: Whether entry into self-refresh mode is allowed.
  *
  * The DRM vblank counter enable/disable action is used as the trigger to enable
  * or disable various panel self-refresh features:
  *
  * Panel Replay and PSR SU
  * - Enable when:
- *      - VRR is disabled
- *      - vblank counter is disabled
- *      - entry is allowed: usermode demonstrates an adequate number of fast
- *        commits)
- *     - CRC capture window isn't active
+ *   - VRR is disabled
+ *   - vblank counter is disabled
+ *   - entry is allowed: usermode demonstrates an adequate number of fast
+ *     commits
+ *   - CRC capture window isn't active
  * - Keep enabled even when vblank counter gets enabled
  *
  * PSR1
-- 
2.34.1

