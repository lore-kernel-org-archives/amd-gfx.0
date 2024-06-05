Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62722C25B76
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Jun 2024 14:53:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CDB6710E692;
	Wed,  5 Jun 2024 14:53:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Q8rOCJHy";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2043.outbound.protection.outlook.com [40.107.237.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B06710E688
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Jun 2024 14:53:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i3hHqpnyvMmEPBgum6V9jlnECYRv0WCLgwNYBXE2BHMGibF0yId6eBVzfmqmN801dV4LHyasCgqFxQmHNWmCpaBxJKvwyLdtEDmgZsFBXGsaDcmXRe3bCx0AcHtVJ2F4NrYKULq2m6y7KeJnSLsTlb0b3QcendjzJ7zKeXPyGtYxTyZ4TPNTH4dtN2rHFxNDr3nt0//WxIFEfex6vyfHQHCy8i+X59aEcX5tNMIZINKxPxSW/n/COOKjyY2lAcRn+KZctGMjfvfcaOXyOYtmQbYkMSVw3JLjf18X4ggQ5Q1hcloCBHWJl9qJNxdd+0rqOvLXeKUh8aL/qJovdKBZAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c9Dr05HOkz1WfCw/ZU6hpD9dSkIudHh/I41yMWMwmwc=;
 b=PjPHedpCPzjJnHhQpSAh9QBjEFNWYlixCUV2hj3emXlUnOG47CmAx5Lgb+/MjSdwa5z0kIKo7K3yfLvWFUu0mSsX2J/QOnPZsBYftf7Il3Ch7a67GkdwluNqIcm5CJC10NhuASJmeMQ9FnzU7r36MLXhcfup7Ih2Tzbrt3JB35I2XeclAFXWHjiRASRHq+8FnHc2uoy5fD0nA5Ie06Efff4d3yxyDz2CxurwdvtpxQu+eI/woNF4BEHrAEMhrb9dv0A2AigAxdnyZEx5CL8CR/ottO4QGqBs5VMFtL/ssBOb9eVFr1zs5PjjtMCkIIOU8olQKbwXGBNmffFJ672N1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c9Dr05HOkz1WfCw/ZU6hpD9dSkIudHh/I41yMWMwmwc=;
 b=Q8rOCJHy3DDHNAe8XaRzA1M4pRoZLQYQBI/0RtBxUiQWiIqnCe2aOoagnx+M8+9DJjZzvCf0jNuIFDVEWiqdNKBlx6eB+sXIWGEIgHzTexM8S7HxZKgnbBpNqdiaF6hu5NDxOPfCDjgISSC6iCPLXz4SVr08n6PZlkS9ws9j9hI=
Received: from BL1PR13CA0424.namprd13.prod.outlook.com (2603:10b6:208:2c3::9)
 by SJ2PR12MB8012.namprd12.prod.outlook.com (2603:10b6:a03:4c7::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Wed, 5 Jun
 2024 14:53:49 +0000
Received: from BN3PEPF0000B074.namprd04.prod.outlook.com
 (2603:10b6:208:2c3:cafe::b7) by BL1PR13CA0424.outlook.office365.com
 (2603:10b6:208:2c3::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.15 via Frontend
 Transport; Wed, 5 Jun 2024 14:53:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B074.mail.protection.outlook.com (10.167.243.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Wed, 5 Jun 2024 14:53:48 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 5 Jun 2024 09:53:45 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Dan Carpenter <dan.carpenter@linaro.org>,
 "Tom Chung" <chiahsuan.chung@amd.com>, Roman Li <roman.li@amd.com>, Hersen Wu
 <hersenxs.wu@amd.com>, Alex Hung <alex.hung@amd.com>, Harry Wentland
 <harry.wentland@amd.com>
Subject: [PATCH] drm/amd/display: Add null check for 'afb' in
 amdgpu_dm_update_cursor
Date: Wed, 5 Jun 2024 20:23:28 +0530
Message-ID: <20240605145328.1785663-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B074:EE_|SJ2PR12MB8012:EE_
X-MS-Office365-Filtering-Correlation-Id: 5970302f-1d85-49d5-54ac-08dc856f4ed1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|82310400017|376005|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Fkdmyy+YVo+i1W5q+PfMzo1FtoPysF6D9zIfFVGCSS1Ze8UZxkIzVb+Iy2x4?=
 =?us-ascii?Q?QPl3Opy/Rvt2TNCdMl8lQdOCk4Oa++0YLe3N/zYDwm9GirS+ItP5AsxGa/Gj?=
 =?us-ascii?Q?EAcMph4bvS7oBmq/mcBtcPWDSBR/4eIVkm+LkZDiUOvFOm1Ow2xjRKOQ9dlw?=
 =?us-ascii?Q?GwAoqN1ImDE2u58carwadzp/ATEQvVqEpojlH0smkEZkmLpCvknZdlE203nA?=
 =?us-ascii?Q?9z6i+JKjO1Hw8xVtaHbIkaRFWgubPlL0SAq0BZNiz89t/dpMQ/utPGGHIT6j?=
 =?us-ascii?Q?z9+TuHC1cgKVJFUJ1rWaPr6C5SmZ6mFofmdcORyqM+lBPCGc8d8BK3WRu++f?=
 =?us-ascii?Q?ASp7cfDtHqQcVHNXOO33FsI2ajBSO8GPRkJ65wU2GAyy0hJ5IwOWPUWZvKyi?=
 =?us-ascii?Q?JmXNP+84GZCqfr6oSsp1GznI5ZmswVb/ygVOMVgBXJz6KX7TKyDfsN2b8dbe?=
 =?us-ascii?Q?0tWNAbZTMMxYZffIh/2H1FUhJ82cJAqerkcjYhBb26rMzrQGiKBSsDUzTQN1?=
 =?us-ascii?Q?/WGMCgzqgcjgibxr4RAncBx+UO1C8iFTyf076ahq2Gtcryn+dlWJV4wQYiTe?=
 =?us-ascii?Q?ehwhdNiQ4nqRIigp0JG23TxWD5HPAiqO0iusPoYEcw0vUPCxmh0kgJBkHkqq?=
 =?us-ascii?Q?Vgyw8ytZ1t2xi4heGybLS/4yZbapj2gbNQjaXjftBRnwKavo7Qj6IWaK4j23?=
 =?us-ascii?Q?wt6GGyd0bbAYC49OJdlmI6Br7yxlfemci67r5z8MycUibOiZ2nRoDD1b0crU?=
 =?us-ascii?Q?WIzXQaG5yV5KOCl1bq3i48cj9OCEFg2CSCUe/idAf99WKuM1uR/fnYGXnFhH?=
 =?us-ascii?Q?g6/XZ7D+UQ/0aP0uFWAuCc0WdaMYO60pHlEePRFyO+dUK9G+ylLv+MLwt/E0?=
 =?us-ascii?Q?PYGZPcEwKMNRw697VT2kzIgsdYvuMfS7sVQtl6zGrKeZUjIHfaX7YvRFFg6n?=
 =?us-ascii?Q?xx4yvWDG0XQ77+lB+KaRQmlrtf8bSefCnoMyRpjDfiEPti664WLcgR6OuUSr?=
 =?us-ascii?Q?KN2l+uzf4uHJJQYlUR82ynjnl3tmUKErtb18G8+sPjCQgUs9FgCCoNyHQd/B?=
 =?us-ascii?Q?2UMfS/LXv5VaT06arm3qgKrUXeJfBMSrVHPOJExZzbkoIHz/RvGsV/vDptUS?=
 =?us-ascii?Q?fNqW1l6ljpe4tBkyQeOnlWCrwqFGuqhbhwoqaTtySqcSNNi7aTrYDMw772iv?=
 =?us-ascii?Q?ihwEshcVE1OOv4OCVgf1yy7Ar/Dfe1hxq9o8bV6AE1C32DTjjDAasxfFW8ID?=
 =?us-ascii?Q?hnzgFCqo9n0mi4SYcHGwGzU+A+j3sIh0Qwsw1huKoxKfUv+0UPeYZ36RjLGQ?=
 =?us-ascii?Q?BYNfgg/wCc1HAjnIJPOaCbU67fAqIP4CmV0o8auV9XqPwDexkFWKdKRybtrN?=
 =?us-ascii?Q?bnpmYX0cz11RVNm2IBfB6JmxKkq9LK0ZL/hzT0UOOva2e2LtHQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(82310400017)(376005)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2024 14:53:48.9348 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5970302f-1d85-49d5-54ac-08dc856f4ed1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B074.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8012
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

This commit adds a null check for the 'afb' variable in the
amdgpu_dm_update_cursor function. Previously, 'afb' was assumed to be
null at line 8388, but was used later in the code without a null check.
This could potentially lead to a null pointer dereference.

Fixes the below:
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:8433 amdgpu_dm_update_cursor()
	error: we previously assumed 'afb' could be null (see line 8388)

drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c
    8379 static void amdgpu_dm_update_cursor(struct drm_plane *plane,
    8380                                     struct drm_plane_state *old_plane_state,
    8381                                     struct dc_stream_update *update)
    8382 {
    8383         struct amdgpu_device *adev = drm_to_adev(plane->dev);
    8384         struct amdgpu_framebuffer *afb = to_amdgpu_framebuffer(plane->state->fb);
    8385         struct drm_crtc *crtc = afb ? plane->state->crtc : old_plane_state->crtc;
                                         ^^^^^

    8386         struct dm_crtc_state *crtc_state = crtc ? to_dm_crtc_state(crtc->state) : NULL;
    8387         struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
    8388         uint64_t address = afb ? afb->address : 0;
                                    ^^^^^ Checks for NULL

    8389         struct dc_cursor_position position = {0};
    8390         struct dc_cursor_attributes attributes;
    8391         int ret;
    8392
    8393         if (!plane->state->fb && !old_plane_state->fb)
    8394                 return;
    8395
    8396         drm_dbg_atomic(plane->dev, "crtc_id=%d with size %d to %d\n",
    8397                        amdgpu_crtc->crtc_id, plane->state->crtc_w,
    8398                        plane->state->crtc_h);
    8399
    8400         ret = amdgpu_dm_plane_get_cursor_position(plane, crtc, &position);
    8401         if (ret)
    8402                 return;
    8403
    8404         if (!position.enable) {
    8405                 /* turn off cursor */
    8406                 if (crtc_state && crtc_state->stream) {
    8407                         dc_stream_set_cursor_position(crtc_state->stream,
    8408                                                       &position);
    8409                         update->cursor_position = &crtc_state->stream->cursor_position;
    8410                 }
    8411                 return;
    8412         }
    8413
    8414         amdgpu_crtc->cursor_width = plane->state->crtc_w;
    8415         amdgpu_crtc->cursor_height = plane->state->crtc_h;
    8416
    8417         memset(&attributes, 0, sizeof(attributes));
    8418         attributes.address.high_part = upper_32_bits(address);
    8419         attributes.address.low_part  = lower_32_bits(address);
    8420         attributes.width             = plane->state->crtc_w;
    8421         attributes.height            = plane->state->crtc_h;
    8422         attributes.color_format      = CURSOR_MODE_COLOR_PRE_MULTIPLIED_ALPHA;
    8423         attributes.rotation_angle    = 0;
    8424         attributes.attribute_flags.value = 0;
    8425
    8426         /* Enable cursor degamma ROM on DCN3+ for implicit sRGB degamma in DRM
    8427          * legacy gamma setup.
    8428          */
    8429         if (crtc_state->cm_is_degamma_srgb &&
    8430             adev->dm.dc->caps.color.dpp.gamma_corr)
    8431                 attributes.attribute_flags.bits.ENABLE_CURSOR_DEGAMMA = 1;
    8432
--> 8433         attributes.pitch = afb->base.pitches[0] / afb->base.format->cpp[0];
                                    ^^^^^                  ^^^^^
Unchecked dereferences

    8434
    8435         if (crtc_state->stream) {
    8436                 if (!dc_stream_set_cursor_attributes(crtc_state->stream,
    8437                                                      &attributes))
    8438                         DRM_ERROR("DC failed to set cursor attributes\n");
    8439
    8440                 update->cursor_attributes = &crtc_state->stream->cursor_attributes;
    8441
    8442                 if (!dc_stream_set_cursor_position(crtc_state->stream,
    8443                                                    &position))
    8444                         DRM_ERROR("DC failed to set cursor position\n");
    8445
    8446                 update->cursor_position = &crtc_state->stream->cursor_position;
    8447         }
    8448 }

Fixes: 66eba12a5482 ("drm/amd/display: Do cursor programming with rest of pipe")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Tom Chung <chiahsuan.chung@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Roman Li <roman.li@amd.com>
Cc: Hersen Wu <hersenxs.wu@amd.com>
Cc: Alex Hung <alex.hung@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c    | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 6196de6cebbf..6d468badb669 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -8637,14 +8637,22 @@ static void amdgpu_dm_update_cursor(struct drm_plane *plane,
 {
 	struct amdgpu_device *adev = drm_to_adev(plane->dev);
 	struct amdgpu_framebuffer *afb = to_amdgpu_framebuffer(plane->state->fb);
-	struct drm_crtc *crtc = afb ? plane->state->crtc : old_plane_state->crtc;
-	struct dm_crtc_state *crtc_state = crtc ? to_dm_crtc_state(crtc->state) : NULL;
-	struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
-	uint64_t address = afb ? afb->address : 0;
+	struct drm_crtc *crtc;
+	struct dm_crtc_state *crtc_state;
+	struct amdgpu_crtc *amdgpu_crtc;
+	u64 address;
 	struct dc_cursor_position position = {0};
 	struct dc_cursor_attributes attributes;
 	int ret;
 
+	if (!afb)
+		return;
+
+	crtc = plane->state->crtc ? plane->state->crtc : old_plane_state->crtc;
+	crtc_state = crtc ? to_dm_crtc_state(crtc->state) : NULL;
+	amdgpu_crtc = to_amdgpu_crtc(crtc);
+	address = afb->address;
+
 	if (!plane->state->fb && !old_plane_state->fb)
 		return;
 
-- 
2.34.1

