Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4525AC3DA41
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jul 2024 19:39:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE01B10E8B1;
	Wed, 10 Jul 2024 19:39:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="HJ1JLAvf";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2089.outbound.protection.outlook.com [40.107.92.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B448B10E8B1
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jul 2024 19:39:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W+MsPFFT4I0j53JDUwnxmcGqPCEOuo575V1F0xbD8Dk89PjfrDGVDCsd4cLAHvdJ7jJRvxhtWgxD5kfZgMIipHo8M6jlFesy19WFhkaBbYyD4NPjFJhb66rIJawaRScGltmyHpa5s0D1lZWmy2n/aTxkYtopDAWIMTV6nDw0UTylftOxYR+EFvSCgoyGin6INWUEU4ToMxpcYeAXLx5q0z0qRcRouaZvti5LfpwMuMDDEp9M2WolSqhfY3cil4Vu8mc0TnUiZktLekLH2P//L7uiVoGdxoR76KjgfmgYbtH+0CbViM0QpxAA5gnUtp9wxMsAPcqj/6nLLmBhR+Bqpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rkb0/RsqlrSsur8bg4JBO+5Tm/9AUf9VUC8b4CXBFh8=;
 b=KbVZWPYS+dO+6Ea6d9j/eRzJfc5mriCBKNwqSBtAyp0uIPRGy6pi21sGU3IvmFdIIP8kGrCOUN8+k3QpWfb4580Q1y41eFcVbtaYHBLF/16pIogXgw0FGy0Hu33wFjDS1eilnjiNezgGbmLBYpiT11GfGe+Z8XhG4KZ47Kmuh0OTY4nYduKZw2E4EE5t2BwnQz71OMh5MPyYXihuZkhb5PsaRFg5r5Lpt6NC2ua0s4qnVRS0C8mFlv6UtMaFvx0uqOhNWC4qLxUxgcqzzQcFQWSLpKnx+rcr/zr98XwVbWLv8JvtSOy3OPRo1kbwsZAcSUtLx4HhQOE0yUbDaAb+AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rkb0/RsqlrSsur8bg4JBO+5Tm/9AUf9VUC8b4CXBFh8=;
 b=HJ1JLAvf2IQyFqyZqFLc3CTAsMw4B5/bdOrYQ6os/yq6QSXmgqbPdjk6pw+GXIpknsPzV2kZf3K2NLLKjPQ0PSR4xDN686cfUOjzyA6gQPgW73adSPDJxNGHoz7Og9BWmDuL6/Jw6FrAvreuHh0rk7PTGlgltL6lbF0Fx3sDEM8=
Received: from MN2PR22CA0025.namprd22.prod.outlook.com (2603:10b6:208:238::30)
 by SJ2PR12MB8926.namprd12.prod.outlook.com (2603:10b6:a03:53b::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.19; Wed, 10 Jul
 2024 19:39:27 +0000
Received: from MN1PEPF0000ECD7.namprd02.prod.outlook.com
 (2603:10b6:208:238:cafe::38) by MN2PR22CA0025.outlook.office365.com
 (2603:10b6:208:238::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.21 via Frontend
 Transport; Wed, 10 Jul 2024 19:39:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD7.mail.protection.outlook.com (10.167.242.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.17 via Frontend Transport; Wed, 10 Jul 2024 19:39:26 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 10 Jul
 2024 14:39:25 -0500
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 10 Jul 2024 14:39:19 -0500
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Subject: [PATCH 28/50] drm/amd/display: Fix VRR cannot enable
Date: Wed, 10 Jul 2024 15:36:45 -0400
Message-ID: <20240710193707.43754-29-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240710193707.43754-1-Jerry.Zuo@amd.com>
References: <20240710193707.43754-1-Jerry.Zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Jerry.Zuo@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD7:EE_|SJ2PR12MB8926:EE_
X-MS-Office365-Filtering-Correlation-Id: 781d68b2-1029-4dc4-a98e-08dca1180224
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dMl6VyfrRRb919fSgYQAepLb5sP8smtZuKQtgkDubqYN5fO+SouLjmGH4KvV?=
 =?us-ascii?Q?tN5wr02qxw3lF6mE1aHdm1KGXWxmInDzy77CYyhY4Q4BBge1ap1TOvMR7yPF?=
 =?us-ascii?Q?bAvkw+eMQUO+R4732oeW4UZcytejHSKhe0KrUZUISgGpv0h0OpOYR8WS4ID1?=
 =?us-ascii?Q?cuGNKEg4JpYzsI0sG/SIjE6Gh1cyeOZlZltrKSYnrCDYbnTbqUhTlesH+qsi?=
 =?us-ascii?Q?QG2xhX1SWec95aj5sOUxwuelwADGzP+XrptH8SAs4H17e0kQFCJrKUSDFaL/?=
 =?us-ascii?Q?wGJJfTCRDz19xY47y2DrM1adDrHHtaZUCe/pZJRQ0r6fFxacPPjmqwKjjVrZ?=
 =?us-ascii?Q?XsU+xW4BSdAprXdk1+WFGRR7TY21oBFOj3E1Q5zb9xH26vDVuNsxVXR/iK5h?=
 =?us-ascii?Q?YYNE4f/MI6u7OqIDsiq4W/d6OY2WF0E5PELiCvzKdSYq/r428etZVa0VT5Ho?=
 =?us-ascii?Q?nFtYjj5vi0SoyAAQ1nWvrkaS5X7ogA71atGiQ8lNyUHHEv5m3865KxrpWw+j?=
 =?us-ascii?Q?iTRYrMUwCrd47HbVb7ncVYP+JznP1q0gWhnYZdXOod+xVXuXD0xGdcwPpddg?=
 =?us-ascii?Q?+CiUuWEEjfZrlmaT3IVOd1hVeSCF6+weu90xTPeXmnwElj0lU0pWjF+rtBfp?=
 =?us-ascii?Q?H780DwtN0oPUBrwhm1gnoErbNqcyqzm9hQMRMvb0j2kDW4pPllyKU003yIZN?=
 =?us-ascii?Q?JD8bbexTaEAvSVxpzadnMuaK2FhhIYoEgEzJWf0i8uCl3lXARBh2MMVOF9kj?=
 =?us-ascii?Q?6/md+0F71ppOXYqRXR9gJ8N6b02HGCm0jsOXRcWDwDO0OliCWMhjSv3CdXhh?=
 =?us-ascii?Q?1gjmyVl0+d3YlVKaeyWywqdlr1efH1zZP235sDLkUDnqoIMqWhlzIJ91h5I0?=
 =?us-ascii?Q?gZiVO2luCtXk0ism/nCH42gRGcmhUtLx1ovGHx8i6TUv2VkgwSH6PBk0ZOh4?=
 =?us-ascii?Q?TI5IJ+0LqjsAApCptSdg8MiHTrYWzU5/A7NgoDNMTEE/4p158JLb/qbuvUMm?=
 =?us-ascii?Q?FBZBi120+UdFXP/nlbx9T9T0MRcmkBvUKLxR1RTYwCjE7oyxtFfH6HXewzK8?=
 =?us-ascii?Q?Swwxg4LQi/n6dOF9bbeOjrdbBXWef/UlDG8dfvNqNUYZGHpaoSTfNw8BA6kC?=
 =?us-ascii?Q?YgoThJahTtMXSaKsOvpu91ce8rJe5Y0emgwI9ys7GBC9YALgP7Iy8lVu6W8V?=
 =?us-ascii?Q?6yqdSmBI11wLFFmrJiWBGojzLcTUO0Gpf55aRCKT+CKQ63gbhvbffVTZn6zK?=
 =?us-ascii?Q?++tTGtZjOAlgOrkXWmdiIuyhSX0HNr3UwCNliT4mDtNzy7X2gb2V9+v5W4mN?=
 =?us-ascii?Q?/UbHW+oC5QP7S1ms7wrnq9aZZ+56ewUA3gQ5WCeebOPxCEsWr6H54ZEYBKbw?=
 =?us-ascii?Q?HwkSiPvTX2m5PCBZzxErlHzB64+lzIhExYgVrFp+4yQtRScWLX+WROPGW//x?=
 =?us-ascii?Q?PgfQCRY7THezYHguhMD0bzma6ii4QPD4?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 19:39:26.4668 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 781d68b2-1029-4dc4-a98e-08dca1180224
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8926
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

From: Tom Chung <chiahsuan.chung@amd.com>

[Why]
Sometimes the VRR cannot enable after login to the desktop.

User space may call the DRM_IOCTL_MODE_GETCONNECTOR right after
the DRM_IOCTL_MODE_RMFB.

After calling DRM_IOCTL_MODE_RMFB to remove all the frame buffer
and it will cause the driver to disable the crtc and disable the
link while calling the link_set_dpms_off().

It will cause the dpcd read failed in amdgpu_dm_update_freesync_caps()
while try to get the DP_MSA_TIMING_PAR_IGNORED capability and think
the sink side does not support VRR.

[How]
Use the dpcd_caps.allow_invalid_MSA_timing_param flag instead of
reading from dpcd directly.

dpcd_caps.allow_invalid_MSA_timing_param flag is updated during HPD.
It is safe to replace the original method.

Reviewed-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Jerry Zuo <jerry.zuo@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 23 ++-----------------
 1 file changed, 2 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 18d6bb485cb1..fe5a96e5c70a 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -11722,25 +11722,6 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
 	return ret;
 }
 
-static bool is_dp_capable_without_timing_msa(struct dc *dc,
-					     struct amdgpu_dm_connector *amdgpu_dm_connector)
-{
-	u8 dpcd_data;
-	bool capable = false;
-
-	if (amdgpu_dm_connector->dc_link &&
-		dm_helpers_dp_read_dpcd(
-				NULL,
-				amdgpu_dm_connector->dc_link,
-				DP_DOWN_STREAM_PORT_COUNT,
-				&dpcd_data,
-				sizeof(dpcd_data))) {
-		capable = (dpcd_data & DP_MSA_TIMING_PAR_IGNORED) ? true:false;
-	}
-
-	return capable;
-}
-
 static bool dm_edid_parser_send_cea(struct amdgpu_display_manager *dm,
 		unsigned int offset,
 		unsigned int total_length,
@@ -12043,8 +12024,8 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
 		     sink->sink_signal == SIGNAL_TYPE_EDP)) {
 		bool edid_check_required = false;
 
-		if (is_dp_capable_without_timing_msa(adev->dm.dc,
-						     amdgpu_dm_connector)) {
+		if (amdgpu_dm_connector->dc_link &&
+		    amdgpu_dm_connector->dc_link->dpcd_caps.allow_invalid_MSA_timing_param) {
 			if (edid->features & DRM_EDID_FEATURE_CONTINUOUS_FREQ) {
 				amdgpu_dm_connector->min_vfreq = connector->display_info.monitor_range.min_vfreq;
 				amdgpu_dm_connector->max_vfreq = connector->display_info.monitor_range.max_vfreq;
-- 
2.34.1

