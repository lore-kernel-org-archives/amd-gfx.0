Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79002C44506
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jul 2026 21:03:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D9D9610F713;
	Thu,  9 Jul 2026 21:03:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uDobtnJQ";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010014.outbound.protection.outlook.com [52.101.61.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B76410F6F3
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jul 2026 21:02:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZrTWC3itQfTEpDnNjoyUGgNlV9Kz9xLdukx1zOyJtajpSJk3Ex0LEjMUpkFS/4v2oyZF+zuzWDGnnnuXMsaFRkb9QL/4YiqwvLR3KXFfHIEpoZFi4X2h7OtMpxjO6I6lTanCSrWOBsQqDpVBeSiV6yDFV15ALE5mdYYqh6wpBKCU5zTF9t7y74b+qzlRniX+c5CAzLpoIv0RJirsOmo9oG/6sLptR2Q/FchPXbW6DV45HPXnOIxXP+X8Qaa1ibtruRm/mU2xw+JRpGMxf9Ayfq+MyE1T8pntn3eA/9UvCzd8Wml3gy58VbCnqgJcqhra1LH3Mw4e3SruxNjhYcTU/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rYzAq9asAzIiRphOJ7vIlLtUnhvqcEBklk4dsgT7iCo=;
 b=rSmkivMdlh8gq7wtrGlmaHy+XW4kxOQbBKsXEVhKezykY0XEmMI2UU7TySz2hi+yVDywqPuWfwpj/aYxKuWrUBvIezc2JsIbjOs/tq5ljZCKqlasU/wd8xAgzNR98vjHXFqNwuQXVR686+DlLomPEH2rjisQCqYOQ7Xulh6Fp+J5ayikMkTYQpxaN7SS6t2kVBsy0qBfyxGkwwb/jC2vaGGlVmYp02VKvFaWM4bSyB35DmW6+HuVjwAGHEkzw7Lbc2uq2Pb379x6ACBMmpXQZ/WxDhr5Hs/O6TEydByHC3pB9x2UDC1uxdjkCd4MYA8it3S0lCb7naGhqF1fZEx9HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rYzAq9asAzIiRphOJ7vIlLtUnhvqcEBklk4dsgT7iCo=;
 b=uDobtnJQ6fxJQR/7jzHtLX343cwmR+WbqdyaDdjK0X6cMkQPBU5d/5cagwOHIbPrK0OOtDB+A1JxlVv0AFv3h4+YRrOb+Wi73XeCSn6lTqvuGiqaUzzwtL7ZSvod1+lCDvcNx6RU9QHk5n0WUEhYR1HI247VcH120ahw1YWs/Fs=
Received: from MN2PR01CA0038.prod.exchangelabs.com (2603:10b6:208:23f::7) by
 SJ2PR12MB8649.namprd12.prod.outlook.com (2603:10b6:a03:53c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.9; Thu, 9 Jul 2026
 21:02:41 +0000
Received: from BL02EPF0001A0FE.namprd03.prod.outlook.com
 (2603:10b6:208:23f:cafe::51) by MN2PR01CA0038.outlook.office365.com
 (2603:10b6:208:23f::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.10 via Frontend Transport; Thu, 9
 Jul 2026 21:02:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A0FE.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 9 Jul 2026 21:02:40 +0000
Received: from georzhanmkm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 9 Jul
 2026 16:02:36 -0500
From: George Zhang <george.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, George Zhang <george.zhang@amd.com>
Subject: [PATCH 79/80] drm/amd/display: don't re-evaluate cursor mode on
 cursor plane movement
Date: Thu, 9 Jul 2026 16:48:47 -0400
Message-ID: <20260709205936.5719-80-george.zhang@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260709205936.5719-1-george.zhang@amd.com>
References: <20260709205936.5719-1-george.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FE:EE_|SJ2PR12MB8649:EE_
X-MS-Office365-Filtering-Correlation-Id: a37c8a40-2565-4eb1-a080-08deddfd69be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|23010399003|82310400026|376014|18002099003|6133799003|22082099003|11063799006|5023799004|56012099006;
X-Microsoft-Antispam-Message-Info: iG1ud4SWVN0fiSU2Smypbz/AZQVoLyDEkDV3LbpGtq/svcT/Y7EXprPDK0gmFBuhnIKBWuOIXLoPUFOBzfTRZrcF2YiHY8dJyFLOzKk1tOyXnDm+DQwSW1lbad5kZhcYONXn6AROHwKln2OKrla4XR/v6XOl/ZuT2sbfs5RHjgSxQD/aRPM3Zf0o99iW4T6hv+khHr/TDmXIdcBomM/JWuJWH8czpIcQG8z23J0D96joRBwslAdlTrTW2QyFStDpTjv0WBPWh3DaLL1oRSTO9sNfT1lYWNfDZmjcRS+jJnw0SV2QWV1Waz+LANx+eWOOOBRq+d77C17fQRChkfBoaPFIgRhxhFSl5nvoucXSUd9ybXeK/QVki/eiI6NGfMOT8ffCAOCr/80ZF2c4Ir4zZksH1GFr9623sJyPwUiroFiim+FcG1XIwUo6NMvzPSq0gSk6Ao3HEur+YcJXob2BGsxRQQ5MksDXm+CgDP5pLY8ayjFGNuP+lSwwri4+Aic4I3OFLi/5eKO343UNL5bOIElmutvVYp8hcuZS3sa5e/O4GDpCIFGp8Pp9QWw34r/Ufqfmzl7KuOCR1olrAfGGvVWDDLmUgpeqFyM1Mif9GUJ8e7JhwMyN1SKPSDs6uwhyvM+CWwygR9rCmKf5NCnJDkHi4YCRRKwRb+K2Qedi/z2HYMhC6SWVMg0BDACDcZJNhmxHZOXgvT9KplVG63P7eg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(23010399003)(82310400026)(376014)(18002099003)(6133799003)(22082099003)(11063799006)(5023799004)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: zVuA9XhH/GYM6VTjrbmXFMF+9KqLpT7EBnd7bIIkWuXN4Uv6A5+5c6SzSvlskr2cJVf5ae7NPcDpuvqNkhfms/XtpKkFmm6sl56WXMR+oNZDL6/avC5K6iovpPXufLBKEYjq4/v6bj4XHjokhn2ISYEVxe2Gqhk3gW6lno7kYtcPTPK3FXrnOrdx3h4sSImsTFj17HyxOWGRejOJfhKHxbubSUSXWfwXnZ+HpRXLAVpC9cTQxvJgbQoUjV5r3n8hXQ4Sx1DFNF8nTmDv7vovuNR+1n4aWnj4JF/kiOLTH85Ey6+xthApfjYN4tsGdg3KlOQ1XibuiKKaoEHS4jkyMXHjf+lx4dHVsj5YM+mzi9chvVA1PD482g+qw/FvkzQVSeZsHQPrK3DW2ZWzlfCfQ8j20GElLAGrOMArkS5gmZBkVIpFMCFCDB4Vw2jWMznS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 21:02:40.3319 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a37c8a40-2565-4eb1-a080-08deddfd69be
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8649
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

From: James Lin <PingLei.Lin@amd.com>

[Why]
The cursor-mode re-evaluation added to dm_crtc_get_cursor_mode() also
checks the cursor plane's own destination rectangle. The crtc_x/y/w/h
check lives in the per-plane loop, which only flags the cursor plane via
cursor_changed and does not skip it, so the check fires whenever the
cursor itself moves.

flip-vs-cursor-legacy (kms_cursor_legacy) issues a stream of legacy
cursor moves and requires each to land on the fast path within a single
vblank. With the position check, every cursor move now sets
consider_mode_change and defeats the early return, forcing the full
cursor-mode evaluation. A legacy cursor move is a cursor-only commit:
the underlying planes are not in the atomic state, so the coverage loop
(for_each_oldnew_plane_in_descending_zpos walks only planes in the
state) sees nothing covering the CRTC, evaluates entire_crtc_covered as
false, and misclassifies the cursor mode as OVERLAY on a fully-covered
screen.

That spurious NATIVE->OVERLAY transition makes should_reset_plane()
return true (lock_and_validation_needed), pulls all CRTC planes into the
commit, and - because amdgpu_dm_plane_atomic_async_check() rejects async
updates in overlay mode - permanently knocks later cursor updates off the
async fast path. Each cursor move becomes a full atomic commit with DC
global validation, serialized against the page flip, so cursor updates no
longer fit in one vblank and flip-vs-cursor-legacy fails / times out

[How]
The cursor mode is a function of the underlying planes' coverage and
properties, not of the cursor's position, so cursor movement can never
change the correct mode. Restrict the destination-rectangle check to
non-cursor planes. A move/resize of an underlying plane (the case the
original change targets, e.g. amd_cursor_overlay@non-full) still
re-evaluates the mode correctly, while pure cursor movement returns to
the fast path.

Reviewed-by: ChiaHsuan (Tom) Chung <chiahsuan.chung@amd.com>
Signed-off-by: James Lin <PingLei.Lin@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 27 +++++++++++++------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index d184cc4de693..2cdc297e6cab 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -6656,15 +6656,26 @@ static int dm_crtc_get_cursor_mode(struct amdgpu_device *adev,
 		}
 
 		/*
-		 * A plane moving or resizing (without a scale change) changes how
-		 * much of the CRTC it covers. This can create/remove holes under
-		 * the cursor and thus flip the required cursor mode (native vs
-		 * overlay), so the destination rect must be re-evaluated too.
+		 * A non-cursor plane moving or resizing (without a scale change)
+		 * changes how much of the CRTC it covers. This can create or
+		 * remove a hole under the cursor and thus flip the required
+		 * cursor mode (native vs overlay), so its destination rect must
+		 * be re-evaluated too.
+		 *
+		 * The cursor plane itself is deliberately excluded: the cursor
+		 * mode depends on the underlying planes' coverage, not on the
+		 * cursor's position (see the entire_crtc_covered logic below).
+		 * Triggering on cursor movement would force every legacy cursor
+		 * update off its fast path, and in a cursor-only commit - where
+		 * the underlying planes are not part of the state - the coverage
+		 * loop would see no covering plane and misevaluate the mode as
+		 * overlay, regressing flip-vs-cursor-legacy.
 		 */
-		if (old_plane_state->crtc_x != plane_state->crtc_x ||
-		    old_plane_state->crtc_y != plane_state->crtc_y ||
-		    old_plane_state->crtc_w != plane_state->crtc_w ||
-		    old_plane_state->crtc_h != plane_state->crtc_h) {
+		if (plane->type != DRM_PLANE_TYPE_CURSOR &&
+		    (old_plane_state->crtc_x != plane_state->crtc_x ||
+		     old_plane_state->crtc_y != plane_state->crtc_y ||
+		     old_plane_state->crtc_w != plane_state->crtc_w ||
+		     old_plane_state->crtc_h != plane_state->crtc_h)) {
 			consider_mode_change = true;
 			break;
 		}
-- 
2.55.0

