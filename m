Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73415C5475B
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Mar 2024 19:41:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0267113985;
	Fri,  8 Mar 2024 19:41:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JiLa0iuQ";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2064.outbound.protection.outlook.com [40.107.243.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3AF08113985
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Mar 2024 19:41:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XR35CvmYyY/q3tvM2XERhlxLT6wJ07CAdXAXEJA8au4ILCkglltHBQHh8Vh8PowuHdy0+LSL53Zzlg8/hrvD1+LW2P6zu1E9no7ZDj/Di0CKzzkRfYZuy02hTFuPV0ZnGh5MpYKow6GVyGmU3mYnU8xZyKgcuUe+Qyd4bBUAsiLS5PyDvwJBNRhBuX9fco6qc4NmnWvm64wUtDSIj5jOxhkgGoqLuU7r78/dNPWVVe3Rb9y2tV95DMqYWulrMDOvjLXiThUzdyqfafobNurA9GUj4/JsYK8zmupN/80g8V1mB1oekCNNi2zoBRkEqHDghsP4ZMZzGIrj1itvimM+5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4zoXslcOZlkImh/XrfRLqkkjALMd7sQllKnDER4Nxfk=;
 b=i22yU+Lr3wFo656adtVHZu1IOtxPUH9SklxfVR6jmVrqRuXc8w6IRc1AOIZZUgCFrndKuBj/hmnXLiJyipFz1Sugr5V276MQXXGPaXA2xehUoW5Lv+WNGG4ICdIi9BzDe42VsPewzC3n2DKsxhIAYbTOU56mkIpV+CFb8GxQRLVKl7bQ2B08SRsmmavzJ9bxISvlUxWDUf1Gf2jDIdMblL3nPXtwFL1nxK5cWL+ZyreuTxVKgDviQ9MRMhSFWD5il1TGRjb5NeRp2syYhLwZe2tjwORnRHyUJE49WavCzTPgBdswYfsPjMhlS3hcyXdAk48/VxSRvSmqG0uPUoqIXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4zoXslcOZlkImh/XrfRLqkkjALMd7sQllKnDER4Nxfk=;
 b=JiLa0iuQPCgo85hqckSO0aKCsPAto9w58WbbbulzxCuNA4My+m/ltdflZIWbyBsXfRxJmY3f+7UF1/J1GTcDh/yWQ7u7v1/EPTFecnB67xNzNjWauMcW5LtvKLMhMk9wdA5HLDCdmKrX+FCk4Q9rp9+0Bg9H7KUayx1ZNlsiSaw=
Received: from PH1PEPF000132E7.NAMP220.PROD.OUTLOOK.COM (2603:10b6:518:1::27)
 by BL1PR12MB5946.namprd12.prod.outlook.com (2603:10b6:208:399::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.29; Fri, 8 Mar
 2024 19:41:25 +0000
Received: from SN1PEPF000252A0.namprd05.prod.outlook.com
 (2a01:111:f403:c801::1) by PH1PEPF000132E7.outlook.office365.com
 (2603:1036:903:47::3) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38 via Frontend
 Transport; Fri, 8 Mar 2024 19:41:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A0.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7362.11 via Frontend Transport; Fri, 8 Mar 2024 19:41:24 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 8 Mar
 2024 13:41:24 -0600
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v2] drm/amd/display: Use freesync when
 `DRM_EDID_FEATURE_CONTINUOUS_FREQ` found
Date: Fri, 8 Mar 2024 13:40:57 -0600
Message-ID: <20240308194057.23494-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A0:EE_|BL1PR12MB5946:EE_
X-MS-Office365-Filtering-Correlation-Id: 241d154a-2688-4cf1-0c0c-08dc3fa7bd74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fF34m495rylGRhYk/bKFG8xVZmlOU8HXGD53pDed2wGtfzjJtcI9mqZRYQm/OLYW1+JNx/ydHcXT+nLfq/3yEZ6WLcU7Jp+4/IQVvaOq/Fadn4l19rs040hnyq9rCwN/PNTYICHeHphtN159q1+FzW94mhrPwmlnVY0AuXZRfAi4oQXq+/3xrxFQmHEPl1HaBkG1j+JxNr8ayO+Dtxp7PEjAh+2aEWlOOsZSve5GbMXN8EINYGYtoxwxcMn7dEIGwO6gEEdTuHeCcEjejZfpghc+ZFlxA2vn5MY4sQ+DQF51R9M5XlYW8YTBACxgE9PngUqnTRILZrlkqCK7bmINVqBrQ0eU3KOsukexzZ6BeF+pzHkLWPY1AY8p3fAzDarfovXmftTGqYWAGvqXyvyRJjdMWlemQnH5MQ4pIsAnN0suprSsZsFvTHcrFVmQgbgK987XKz4dk7Jbq0CL/alGOcqW90nhrGzG4obrOX6UCZ9Hv+CLSFq3pvKT9CIZHuODMbEVkJZ7CnnzXwbzbpuFcWGSEzslNBJUYsDZ3QVy54YoYFwi5jx3e825XWeZAJDymQwYeLiInOpfGQxUdu1nXqbHDx7FBGO6xnYcaDx+5GoEDF5K+KtKV3GBEIjXwTI4dbGH4xiAd1txIPNuljQrs0ZcJBQkqQPZzV6KjHvInr2TMOYjbul8VJx8P/VhvuKoifaHw5Q1snspSjeqZ+cK+g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(82310400014)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 19:41:24.9573 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 241d154a-2688-4cf1-0c0c-08dc3fa7bd74
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5946
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

The monitor shipped with the Framework 16 supports VRR [1], but it's not
being advertised.

This is because the detailed timing block doesn't contain
`EDID_DETAIL_MONITOR_RANGE` which amdgpu looks for to find min and max
frequencies.  This check however is superfluous for this case because
update_display_info() calls drm_get_monitor_range() to get these ranges
already.

So if the `DRM_EDID_FEATURE_CONTINUOUS_FREQ` EDID feature is found then
turn on freesync without extra checks.

Closes: https://www.reddit.com/r/framework/comments/1b4y2i5/no_variable_refresh_rate_on_the_framework_16_on/
Closes: https://www.reddit.com/r/framework/comments/1b6vzcy/framework_16_variable_refresh_rate/
Closes: https://community.frame.work/t/resolved-no-vrr-freesync-with-amd-version/42338
Link: https://gist.github.com/superm1/e8fbacfa4d0f53150231d3a3e0a13faf
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v1->v2:
 * Use is_dp_capable_without_timing_msa() as well for new case
 * Move edid checks up a level
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 5b7293da5453..4e1633a18f2c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -11233,18 +11233,21 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
 	if (!adev->dm.freesync_module)
 		goto update;
 
-	if (sink->sink_signal == SIGNAL_TYPE_DISPLAY_PORT
-		|| sink->sink_signal == SIGNAL_TYPE_EDP) {
+	if (edid && (sink->sink_signal == SIGNAL_TYPE_DISPLAY_PORT ||
+		     sink->sink_signal == SIGNAL_TYPE_EDP)) {
 		bool edid_check_required = false;
 
-		if (edid) {
-			edid_check_required = is_dp_capable_without_timing_msa(
-						adev->dm.dc,
-						amdgpu_dm_connector);
+		if (is_dp_capable_without_timing_msa(adev->dm.dc,
+						     amdgpu_dm_connector)) {
+			if (edid->features & DRM_EDID_FEATURE_CONTINUOUS_FREQ)
+				freesync_capable = true;
+			else
+				edid_check_required = edid->version > 1 ||
+						      (edid->version == 1 &&
+						       edid->revision > 1);
 		}
 
-		if (edid_check_required == true && (edid->version > 1 ||
-		   (edid->version == 1 && edid->revision > 1))) {
+		if (edid_check_required) {
 			for (i = 0; i < 4; i++) {
 
 				timing	= &edid->detailed_timings[i];
-- 
2.34.1

