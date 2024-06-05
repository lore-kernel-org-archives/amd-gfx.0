Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A35AC25B76
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Jun 2024 15:46:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C42210E221;
	Wed,  5 Jun 2024 15:46:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DRXP/fPm";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2053.outbound.protection.outlook.com [40.107.237.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 032BC10E221
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Jun 2024 15:46:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OcNE3exF59Z3eGztdYq8X/ki0ZM/sGZCxtPViygnikb9GheTwLxjMFN9L0f3XnYgrzocEBdYj+CQXmLMiNGNxz/L4ONeEbm1UDxcu7tsvMqKxersQ6wFGftpPTi2i5V2Atgv64zRhAHe1RJtx2cVo42f4mxRCw6cZnONU0UhQbRxE/py20UpCdgUphOoilZpxLz3i5dTZf1O0zBTDdNhvSEjE8nAh3ESu93npmbTdT5gYm26CMcqLkaP6rmqEh9gxA7J9T6DOTyBRi2PQwcDMQ+VKSn0kIsW/0CwkY3mT8dvB/zxkbeWOOv7IxL2AYTCMNAqGwH1xGURMtfRwgALVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=usbLIbhoP8fQZa5f+OR3iPChyxNEx1f/Ok2VJOmuv+c=;
 b=QekxdYPNdciHgyFkr+42OomSbJAwWghrjikzTfc5FlAWN5TsMNQOb1Fn5if0oWcBl789zEWz7skdYlnpVQHpysAVBUZ2g0AWuNUnvoMuhbcVeqACi0hHKKRh8RM78TBRUul2A6EYty892zsQM6DO5kNo/9XvtgHO1QjFhdTibSr55A7bVvzKyUAUtOwR5nouseeUVe5qCX6FiV10fZvqC6ZZQ6mzW8gs84fEqVJUL9iz/ZgPt9/Avdu2TChQhgfN0my7NrKcrGlNV2iZVtPOHa0YDEhro1WXU1PXDL3WTLoV5E5i18H3ndr4rHcGao/DnhVCl5CVLfJth6OGpZYnIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=usbLIbhoP8fQZa5f+OR3iPChyxNEx1f/Ok2VJOmuv+c=;
 b=DRXP/fPmSeT96iPBpvu1XAmxY5M2UBK9eJjwQjrH/CS8RSsh7cFSLeXMZulcrbziEgZzILHrVc68zZhKw47n7iN2XQrppwHQSG5/PYIYxg6k1sX4fVlbor+AwvlBPPAUINSa7QkJNadWUmsM5jPov2ljF1koCOn5Zr8U6bmDQU4=
Received: from SA9PR13CA0084.namprd13.prod.outlook.com (2603:10b6:806:23::29)
 by SJ2PR12MB7989.namprd12.prod.outlook.com (2603:10b6:a03:4c3::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.24; Wed, 5 Jun
 2024 15:46:46 +0000
Received: from SA2PEPF00001508.namprd04.prod.outlook.com
 (2603:10b6:806:23:cafe::23) by SA9PR13CA0084.outlook.office365.com
 (2603:10b6:806:23::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.15 via Frontend
 Transport; Wed, 5 Jun 2024 15:46:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001508.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Wed, 5 Jun 2024 15:46:45 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 5 Jun 2024 10:46:42 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Roman Li
 <roman.li@amd.com>, Hersen Wu <hersenxs.wu@amd.com>, Alex Hung
 <alex.hung@amd.com>, Harry Wentland <harry.wentland@amd.com>
Subject: [PATCH] drm/amd/display: Add NULL check for 'afb' before
 dereferencing in amdgpu_dm_plane_handle_cursor_update
Date: Wed, 5 Jun 2024 21:16:27 +0530
Message-ID: <20240605154627.1812156-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001508:EE_|SJ2PR12MB7989:EE_
X-MS-Office365-Filtering-Correlation-Id: c6f2ba33-f343-4e21-aedc-08dc8576b46e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|82310400017|36860700004|376005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?EUtCmxR4yWpfp+wPKUJrcGjNKwzbt/2N2ZXq1oL92U7Uv8J9glARz352YaaH?=
 =?us-ascii?Q?Z3kJkhkOJvrtBipsImpFmyfCxBvu0JFUdHrI3mzd0Ef/buoEDHxY13rwvX0+?=
 =?us-ascii?Q?gtCGK8wzowhE17nC/xQCQ2YaWkjMP2IfQYlIqiDFRRDLAeKF6uCxYkSm461p?=
 =?us-ascii?Q?WJTcmkP/czvSc8rPOJoiBz84yCgCFF2w7TEbvx7xQOli4GRLzrzwFKeR5M5/?=
 =?us-ascii?Q?tQFasuB+lUFbi7Gr7zZjtEuaTyu8Bdrk4W7A7fBcjfbVMXce8g0QdUoaQCIj?=
 =?us-ascii?Q?e72OZEWk2A8/Yt7UZSI6tbshC64P7SeXm+x8gxp/UfZ7oh+x+NDCLchMS/Bx?=
 =?us-ascii?Q?UWxIscfQ7rM35yN7L7RArQaAMQDbkSD9I80zaR1Fv4YbFqir40g97tsUgo/s?=
 =?us-ascii?Q?RlgH5jd+XZtaC/ODdkbnKI5hORvtxtsAlYLoU7wq1/ksdzxWePGFEIketCfC?=
 =?us-ascii?Q?NnmVEvoPI6BGfBptS0odRMWbyGtIyjUFM0FUEHQSNCiDk4QtoUf/fth33iO9?=
 =?us-ascii?Q?8B8nkjoGxq9t59LSAfFH8KpmMgk9uoiYVXgog7KdFva4o8GHh/H+mq3S89QC?=
 =?us-ascii?Q?i6I2/ddonOnIFumbgFU3cl3tPzHaDuB6/ksLudg7KhDxBPUoEI96IqTp2Z1O?=
 =?us-ascii?Q?Wss23Or2TdQQ/d6qHU3ByLtiSQjQcUql8pnj9W2jf5OwZTjzKcCAF+5TljU0?=
 =?us-ascii?Q?teyvhUTBKM+k/RtJUp112jpymfa/hHH922p1pd+hFUSGZPLL8zQy9vl9kA3Z?=
 =?us-ascii?Q?tGMdoLuRNb15WfMO5Lt9tlVz/imNCgg9fQELKpDEkM/5hiVnnM94KIPk9pNZ?=
 =?us-ascii?Q?jVG9zIpYBM5uMjYIeK4rZMXhe/6Zcx/YmO7iS4TdXCoK/Ic4xgSaIaq3ArRq?=
 =?us-ascii?Q?pmv1kxvk+eiVZMctDxA2/oHtO9EyQVTSkJqgi5NPJ1EkRIxekvYFFHRZkcXj?=
 =?us-ascii?Q?NXJJD8LxwIhrJ3jioHWRbap6UPD/ub+eo78qsBa/+ihGbOqByY0oojMVZ0Ek?=
 =?us-ascii?Q?b4HenrkUrfVmIvqKAwOWpddAQxPdlLFJVgmQqyMW8A7NllxOypj9uaLALA/G?=
 =?us-ascii?Q?YOA3aUlSCOEvUwu+1vfaz/DmrR1+QX8i4x6YycD5XWNjWQjZOqGQE+4YYdJK?=
 =?us-ascii?Q?4Aur0DKNvV7EVhli9UNOuzaNfd0n+ocyrFd7Wpcq/baqGdJ9/v6OceWuG/U+?=
 =?us-ascii?Q?JUiQXbHZkhELKPHu2QODxi65GJuMWIoD0X1gM6XEAovzzRq7XMsb+XETP9IC?=
 =?us-ascii?Q?TJ4hfB0miyGoWdhxtLi/W6IxvauZB8XgwQbeCzwPwnSRWRMUwpwpqbruKmXv?=
 =?us-ascii?Q?Li78BzbSigNuK5DoEKzkqX+qEeXKvH7+KgO7pGbxxIug3bgNHoeOF4UDFG5A?=
 =?us-ascii?Q?l4uiHQBumvBV+Ty7SB/ivvQIW8bHNsq5EMkdaREgoAUIqoJpMA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(82310400017)(36860700004)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2024 15:46:45.8774 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6f2ba33-f343-4e21-aedc-08dc8576b46e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001508.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7989
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
amdgpu_dm_plane_handle_cursor_update function. Previously, 'afb' was
assumed to be null, but was used later in the code without a null check.
This could potentially lead to a null pointer dereference.

Fixes the below:
drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_plane.c:1298 amdgpu_dm_plane_handle_cursor_update() error: we previously assumed 'afb' could be null (see line 1252)

Cc: Tom Chung <chiahsuan.chung@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Roman Li <roman.li@amd.com>
Cc: Hersen Wu <hersenxs.wu@amd.com>
Cc: Alex Hung <alex.hung@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c  | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
index a64f20fcddaa..b339642b86c0 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
@@ -1246,14 +1246,22 @@ void amdgpu_dm_plane_handle_cursor_update(struct drm_plane *plane,
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

