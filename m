Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12137C02180
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jan 2025 17:08:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 864D910E78A;
	Wed, 15 Jan 2025 17:08:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iip0v5ZK";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2062b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2418::62b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1815F10E0A6
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jan 2025 17:08:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nvc9bI2mVxiPR6XlNOb3iYUGuCR1Rk9QewEpEKC2xpzwYzmJNQkOPseoOce5NJCtqlElkWbwBjSqd5xRll/JOgvglq5IrdW3GCQkyxC3d3QslRFKNCyJIWSqniYhWlmE6w/EwuB/gxqYupD/Z1XrjLpX2XO5KjGBaPJB3mA7dNyleE8G98oj9QJQ92m5Hjhn8C6q9g0vJzivphx7A0Shg7CBp+AP9YsXZWMzDWe8rhteOV7317NmV7XkgN1kqHR/IYwi8ULQAM2Sn5RLRZtLEQJbMvNsOJgnjoA/Shriy5uPr7RIXA07WWh8+sdzZStbP7qWH/LMHG30o8RDct+7HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vwRAd7y69pkmzQyGpfp8Wrp8+JGTBImgbHIvtdEEIk4=;
 b=x6pUMg+y46R5gc7xULG4wJ/JSU5vWegERACSuNf3SJXtgQM0iwIp27kAoF+dJOhVN8zoBI+ZL8MRtho65MqssPInXWXVBYIb3zW1qFgangYgVhEKsbDYKWgyheR/yisQPUejKB4Ug/tdeHfPyoJjPqLQ0/VS17Ci8tAkQIpAOwZAeIOe/gn9aKx9q9GiHUnZU2U3DvcPtPMBjnwD18Y94/UcB2kWUsN+KSUGzCW4qNtkxlEiHW8LYHRZ4HKS3+g8+e5SD1aKUppMnEWhzFUgpWPO7kcyZMem2Kt7HIcTuMXr/J2Mnh6aGHxRLp5IDcucBTqMr9ahfmpoolm95dEarQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vwRAd7y69pkmzQyGpfp8Wrp8+JGTBImgbHIvtdEEIk4=;
 b=iip0v5ZKt1L0xjIy0Z2tFNki3tI6WcEy+x0PaBQlHeR6AvwvlxDrf6pJcV8Oz1rJaLpw/l7X/nZl6mJ2n+OTGYW9c2IdjNhIG1psW3WSa6QmTb4EQSakB6+v6DkYnGFK0dZB/nqLi50GpusMX1biqhFBaYud9gGl1jyHGbaAOU0=
Received: from BLAPR03CA0146.namprd03.prod.outlook.com (2603:10b6:208:32e::31)
 by IA0PR12MB8279.namprd12.prod.outlook.com (2603:10b6:208:40c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Wed, 15 Jan
 2025 17:08:19 +0000
Received: from BL02EPF0002992E.namprd02.prod.outlook.com
 (2603:10b6:208:32e:cafe::5c) by BLAPR03CA0146.outlook.office365.com
 (2603:10b6:208:32e::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.12 via Frontend Transport; Wed,
 15 Jan 2025 17:08:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0002992E.mail.protection.outlook.com (10.167.249.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8356.11 via Frontend Transport; Wed, 15 Jan 2025 17:08:18 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 15 Jan 2025 11:08:15 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Leo Li <sunpeng.li@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Roman Li <roman.li@amd.com>, Alex Hung
 <alex.hung@amd.com>, Harry Wentland <harry.wentland@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH] drm/amd/display: Fix error pointers in
 amdgpu_dm_crtc_mem_type_changed
Date: Wed, 15 Jan 2025 22:37:28 +0530
Message-ID: <20250115170728.2561339-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992E:EE_|IA0PR12MB8279:EE_
X-MS-Office365-Filtering-Correlation-Id: f5a21db6-b19c-4f65-18a1-08dd35873578
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?S6bbo9M48Ql5rALKr5DkXgWMZM4p2XVePF1MhLmU7Pz8+ZOOUF8JDFuj7CTQ?=
 =?us-ascii?Q?Nmps68cavoqRVdmHGJli9d2CfJGFIFdFOjoBEe0trmbYkQHfarzPz8S63n7/?=
 =?us-ascii?Q?QBmET6+2ssQhuDZWTO0v3DzIeMfOAwBc7UvkhHxfHYagsBdRxEgX/UJsXgrB?=
 =?us-ascii?Q?oKnjZJFY25ptq8lAIjxfwE5nD/HA0odMhMsyGDJSVxzxvu3niimP9UtV/BPP?=
 =?us-ascii?Q?b7eCTEUPcQEGjwSSLziDdKsEqpS9hM8eI2JriROP9HCU8ioZMH0FpayoHg/U?=
 =?us-ascii?Q?1Id3JeyIw92owafHl8amSYizGY4kRcZaXyofslK6BpuVa5V44xNB/NfkeHqg?=
 =?us-ascii?Q?xC8y7CLBO0NjMWg8fHnntLkDJBZta/w6astTNeibXa5DTN1JNqDWPS7Oyjgv?=
 =?us-ascii?Q?y1cKejeo+as6Jd6LVRtmiXzqXi3vOjmeY7HZnz7elQcM3yuQ6hCy+3hQf/15?=
 =?us-ascii?Q?7xGIvozN9WL053R+Q5FATQN33OYK1MYf9L3yZopqinZ9yKORzIFwy6NB6ZtY?=
 =?us-ascii?Q?Ej49rcfafAOW9I7hQjqXepXGy9hOZ+lv049OZm16WpJHLSdmS8yMOOGWjnKF?=
 =?us-ascii?Q?d96Nhfz+B23Nh0z/MX8feL9Q9G/LL9df6aO97i7wa8FHCUmsQ39ftAy/446B?=
 =?us-ascii?Q?C49wRc0ypDGcYBltKLeAk+VVApvjrIq3q26NMmXlxJaVbgyK8KWm86SJlrBy?=
 =?us-ascii?Q?SqAPabiRF8FZ3Jz5s9lXxTMXw5oxCgQ/dpihUBFe6h10jgY6Dw8zlnYkXyCd?=
 =?us-ascii?Q?YUtlljHo5WkX4d+G87zb7ew/gtlfLc+wckkEdHWafgthbOLbT6PQlBrDRiEk?=
 =?us-ascii?Q?idQDIg4VkS71djr9Xz213u/oSw+OK4RESCxaq7uSHNb3pxbLCPXlxUwIJd9/?=
 =?us-ascii?Q?2Y/oyq+JfYrJ77cRcMwynhVu9/6oxUjx+k/i1g36wa5cv7ZzbKzGeE8KTM+J?=
 =?us-ascii?Q?4N591WiAAj1EdulgogauCj8yKy3NC8Q34Kc1UWuAfyf6W7jnxZ0LBH+aEeBJ?=
 =?us-ascii?Q?NLkPzGXQJYxd4dJ9ZFoXo7X0duekAbQY2F26/ZXupJ7FLVh0pSr4GTHucLHP?=
 =?us-ascii?Q?duHX6oRmyOh0A2/exRz6wArRdXyxa/bZMtVBSvZ0MuM9+t4UVMnuwHF2gf/u?=
 =?us-ascii?Q?uARF3pQUcm/9SRJb/1iLt1xnK3YnBw9E6iFjKUcsH5YcwRQ9rCz2CwhSJUsK?=
 =?us-ascii?Q?ScruemT6j7Lg+zwVqqPeBV9MzKZ9arNn5qZN9oixq+vGOyABybmejtZr63/H?=
 =?us-ascii?Q?RRdVCxVAPO/pLHnVAbl5Z6GtTh0xdDBbnZh5Skhfeuk86fpAwXJ1H+uBCdRL?=
 =?us-ascii?Q?/mRhMKUH383Fz616jL/lHq5gfKuqi40mr5KyalyY9mMhloYvEVRM3ER8YNG3?=
 =?us-ascii?Q?Roo6cVKUHxeDumORcy17aKvdZ8Xlbivuxa/a8Ls90bvFzumH1B+P7w1tAfU0?=
 =?us-ascii?Q?tfWUcvWomURYES4hVIFKBYo8owJN4P0KIzYeBZciFzlNahPkR2QJanVfqxYn?=
 =?us-ascii?Q?BjNPCYZsVV4wy60=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2025 17:08:18.9617 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5a21db6-b19c-4f65-18a1-08dd35873578
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0002992E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8279
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

The function amdgpu_dm_crtc_mem_type_changed was dereferencing pointers
returned by drm_atomic_get_plane_state without checking for errors. This
could lead to undefined behavior if the function returns an error pointer.

This commit adds checks using IS_ERR to ensure that new_plane_state and
old_plane_state are valid before dereferencing them.

Fixes the below:

drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:11486 amdgpu_dm_crtc_mem_type_changed()
error: 'new_plane_state' dereferencing possible ERR_PTR()

drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c
    11475 static bool amdgpu_dm_crtc_mem_type_changed(struct drm_device *dev,
    11476                                             struct drm_atomic_state *state,
    11477                                             struct drm_crtc_state *crtc_state)
    11478 {
    11479         struct drm_plane *plane;
    11480         struct drm_plane_state *new_plane_state, *old_plane_state;
    11481
    11482         drm_for_each_plane_mask(plane, dev, crtc_state->plane_mask) {
    11483                 new_plane_state = drm_atomic_get_plane_state(state, plane);
    11484                 old_plane_state = drm_atomic_get_plane_state(state, plane);
                                            ^^^^^^^^^^^^^^^^^^^^^^^^^^ These functions can fail.

    11485
--> 11486                 if (old_plane_state->fb && new_plane_state->fb &&
    11487                     get_mem_type(old_plane_state->fb) != get_mem_type(new_plane_state->fb))
    11488                         return true;
    11489         }
    11490
    11491         return false;
    11492 }

Fixes: 1079bd90c55b ("drm/amd/display: Do not elevate mem_type change to full update")
Cc: Leo Li <sunpeng.li@amd.com>
Cc: Tom Chung <chiahsuan.chung@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Roman Li <roman.li@amd.com>
Cc: Alex Hung <alex.hung@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index fe75fbced027..f3f319238763 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -11523,6 +11523,11 @@ static bool amdgpu_dm_crtc_mem_type_changed(struct drm_device *dev,
 		new_plane_state = drm_atomic_get_plane_state(state, plane);
 		old_plane_state = drm_atomic_get_plane_state(state, plane);
 
+		if (IS_ERR(new_plane_state) || IS_ERR(old_plane_state)) {
+			DRM_ERROR("Failed to get plane state for plane %s\n", plane->name);
+			return false;
+		}
+
 		if (old_plane_state->fb && new_plane_state->fb &&
 		    get_mem_type(old_plane_state->fb) != get_mem_type(new_plane_state->fb))
 			return true;
-- 
2.34.1

