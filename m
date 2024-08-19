Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 747A3C3DA4A
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Aug 2024 19:23:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A61110E345;
	Mon, 19 Aug 2024 19:23:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Y9Bz0NCM";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2069.outbound.protection.outlook.com [40.107.95.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 68DF210E343
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Aug 2024 19:23:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=whi7IM9eutUrtz+CWvALu9+Y2dl3w/GxzRkL7xUt40xUW3C2DA0elnUf9VQStA0b2HRrInlmiNhdx2tIgbF+c0578wmvFQrH2hJsNCRqTmkkl5oP4sGW++jJkNyVqjQQVn5WZdOC+JO8BjiSKYOtpund09U1iZmTw7eUhPf6zSq70c+A/7ly5EvUwYe7Q8blVYuacS9tkq4rFfaMENZIGuUN7xOaezeyr7RUKQBftLlO4AuRFyNAesEmH5910Qstv7E07dvlRHTfhn6OqEGCFTRtaD+jehs2DCaohY9iXuaCS/kenMWhpX1Nn2ocz+kgwwjLjJgSAS2twSFFxHlY5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vQkWoPE1FpEGxMAIpnsgv/EsYfUnLLI9Xk+Py7ktEdc=;
 b=rUilOLoPc5/Zt2e6Em0AOlozw84WpEFeLb63Hp/2VqIfNjF8q/fAGezkENXnEigT0uhqN8nE7uzikSJvof4JalSCC1QpqyIocf28gsli/nkFr5JllXJKJ6nw7UjOaa8P1PEk639UrUUbBKY0lQBw4GRCY3jGxBHA7eKFGJxAoYY4/P7wzdDqC8BYBs4d7AVNssEj47uhMw2N4E0wgBA2CF3fzncZEYJ5J+0oGGHJR6BcBusr1yAeD1jz2j1Bcx5htlu1OeIE7ffiAjEttTIQTu4lviuBmPt/qpTtF7xUgfQhJzMzQv7GSH2+tXgHjyqiMlg7F4bftoNd/lfZJmtfJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vQkWoPE1FpEGxMAIpnsgv/EsYfUnLLI9Xk+Py7ktEdc=;
 b=Y9Bz0NCMzT9jy80GXKQZ+yAFAhiaVO7v4qWMmW1kWu9DWaPFWB8dx8SQaQ6ckvORSYwPAoAnu7BqZEgChZxdR5isLMFJG/dNl+7OULnArXUFUad2+vLzksY/fXd6JFwM5CaVnsx6zQY9N/vhzMAdqWJv5ki8ClnJUe4jjJ4UzU0=
Received: from MW4PR03CA0163.namprd03.prod.outlook.com (2603:10b6:303:8d::18)
 by DM3PR12MB9414.namprd12.prod.outlook.com (2603:10b6:0:47::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 19:23:12 +0000
Received: from SJ1PEPF000023CD.namprd02.prod.outlook.com
 (2603:10b6:303:8d:cafe::5c) by MW4PR03CA0163.outlook.office365.com
 (2603:10b6:303:8d::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21 via Frontend
 Transport; Mon, 19 Aug 2024 19:23:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023CD.mail.protection.outlook.com (10.167.244.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7897.11 via Frontend Transport; Mon, 19 Aug 2024 19:23:12 +0000
Received: from thonkpad.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 19 Aug
 2024 14:23:07 -0500
From: <sunpeng.li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <chiahsuan.chung@amd.com>,
 <hamza.mahfooz@amd.com>, <roman.li@amd.com>, <aurabindo.pillai@amd.com>,
 <rodrigo.siqueira@amd.com>, Leo Li <sunpeng.li@amd.com>
Subject: [PATCH v2 4/5] drm/amd/display: Implement DMUB_IPS_DISABLE_DYNAMIC
Date: Mon, 19 Aug 2024 15:22:16 -0400
Message-ID: <20240819192217.18799-4-sunpeng.li@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240819192217.18799-1-sunpeng.li@amd.com>
References: <20240819192217.18799-1-sunpeng.li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CD:EE_|DM3PR12MB9414:EE_
X-MS-Office365-Filtering-Correlation-Id: dddf3f3f-e5fc-40dc-ea12-08dcc0845de9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PLwKloTqazSIAdnUqsO61219K9gEOuuCoZJLm4HiZUt+2GAYFKHAYP2Wo9tb?=
 =?us-ascii?Q?lx5dTn+z6eQfAoN06X4dv3TFKp+jNE3IS/JUGekV8GfrYiygwazt66MoeIZr?=
 =?us-ascii?Q?XYyoPzv2bt2UZEmm96AMKwzFSSWHcZgVmIwtvZVTrqenrDh4t44REnuai7md?=
 =?us-ascii?Q?7hVYFo9vYXriEp9pKHVHy2yJ1RLEItg8cCCy35G+K5OdUN9qxhdG9EmyuMrk?=
 =?us-ascii?Q?ZMMq0ArqBDSIY36cZfCWyz/nLe7LdbRBiBxfK1BXnABtN1wF+z1/JC1skeYV?=
 =?us-ascii?Q?BlFp/n7zA57CA2gwiics6VL9oX7WKE6xQ39ReNqkDLw+9u1y3yl581M/PHpd?=
 =?us-ascii?Q?7lLaMEWth+LDBKBtqIJLaic4KAFRZWt778EiasThhLcxqfjDQT8qUpn0vR4q?=
 =?us-ascii?Q?6z6YnMFGF9RC9qArODh8r9Tm41KQIuhGUMtd3YwQvWVyECpYZRipHH2mL+6n?=
 =?us-ascii?Q?iIx3+sd/tPTGOUCdUzijQ2q0URkAe4jceMeloBJR2sJ4Xm/5gIzSfzawthfL?=
 =?us-ascii?Q?1ISCPjQeAxW9PYYKhxD5aTXoHfWfZrWw1jiP4n4mR+v1yyc50ZKqt8Qucpi0?=
 =?us-ascii?Q?2ZCuWLbRVwWQGmV/Mg3OEYNefk5WSGomeihlG9szFVW35fkhPPaM0A6mOlgN?=
 =?us-ascii?Q?vZbcBYpdmVNoD6a5gJ6iXgpV2jxS/KwXXVZUx2gtP0j0jmJ2Xe0cpu9ATiHJ?=
 =?us-ascii?Q?ct1BYWEYuewnkVro2SJWvXG1otmgQIWLW9bcM2WPA0BX384vesaUPHrFRNCg?=
 =?us-ascii?Q?V8yiDKLcXstkjrkrMIMKOVUN5uAs1hhA5aNagjimYm5+yiXqieGWEWTKm9DN?=
 =?us-ascii?Q?L8MQcSXUlajvI+kxpq71mAnObpRN47b6DcxJ7izbjkUvfqE+/bq52IPZgMC0?=
 =?us-ascii?Q?rMinDt4PRDqnY0pgE6f3+kdApIs6Acx/qtjRg2Lktg1HEOhoXx6fQu9U2VF+?=
 =?us-ascii?Q?sB68UKWbuTwVX5C8BpX4/ZFbAKQzFwUN/ngvLmFAYjIqBqQ9OBgXNSykljlW?=
 =?us-ascii?Q?k52p4oNIZa0Zz4Dpj1uyNTDY/eGiZChgfG04YaC53PaIUYS5XcvsC29DIUO8?=
 =?us-ascii?Q?FVTtEoQlFVl+F+l7RNsOXKJpuHcw7r7j5Zp3XjerFqhC5qyRgXJ3iXD+JDCa?=
 =?us-ascii?Q?GUMdGOagh7yzeMnzN/k62Z+jeYxMdBEAM6vLX7sCFmmdpu5ZLo4KwANkG2Zc?=
 =?us-ascii?Q?yf52u+WKLKnaRetzka1fQjNR4k40/VMQGybLEMT6YHMd1L+qkIHWBbhy+oyo?=
 =?us-ascii?Q?E/zwBqKC/4kH6rmx3zBGW3l2PQqDifcjHXOEQmuWvl1O95a8sgwhn7w++zM3?=
 =?us-ascii?Q?1xJo9XU6Ac0+1E2Slm8EvKR68jY6NfQR9EP2KzTudvSg4eSvsJpV5yxIZcFL?=
 =?us-ascii?Q?Ef9pM1nRUgg3M1Y859OJWmmRy/uFNiJ7p586pmUolcQflpsKdXiHxutpOrGU?=
 =?us-ascii?Q?iud12qMyezlG0W/hvSg8JflM1JJklxDh?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 19:23:12.2188 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dddf3f3f-e5fc-40dc-ea12-08dcc0845de9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023CD.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9414
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

From: Leo Li <sunpeng.li@amd.com>

[Why]

The IPS_DISABLE_DYNAMIC configuration disables IPS in all cases except
for when the driver is put into d3 for s0ix.

[How]

Now that we have a common entry point into dc_allow_idle_optimizations
from dm, implement said configuration there.

Signed-off-by: Leo Li <sunpeng.li@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 42 +++++++++++++++----
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  5 ++-
 2 files changed, 39 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index c99cff3650f14..f9b5966746c73 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -247,10 +247,38 @@ static bool
 is_timing_unchanged_for_freesync(struct drm_crtc_state *old_crtc_state,
 				 struct drm_crtc_state *new_crtc_state);
 
+/**
+ * dm_allow_idle_optimizations_internal() - Allow or disallow idle state entry
+ * @dc: pointer to display core struct
+ * @allow: If true, DC is allowed to go into idle power states. If false, DC
+ * will immediately exit idle power states
+ * @suspend_resume_path: Set to true if the caller is part of the suspend or
+ * resume path
+ * @caller_name: Function name of the caller - for debugging purposes
+ *
+ * Debug flags are considered in this function, so any DM callers should go
+ * thorugh this rather than call dc/dmcub interfaces directly.
+ */
 void dm_allow_idle_optimizations_internal(struct dc *dc,
 					  bool allow,
+					  bool suspend_resume_path,
 					  char const *caller_name)
 {
+	/*
+	 * We can early-return here if IPS support exists, and DISABLE_ALL debug
+	 * flag is set.
+	 *
+	 * We also need special handling for IPS_DISABLE_DYNAMIC in DM to allow
+	 * IPS only for the suspend/resume call path.
+	 *
+	 * The rest of the debug flags are handled in `dc_dmub_srv_notify_idle`,
+	 * which if IPS is supported, will eventually be called.
+	 */
+	if (dc->caps.ips_support &&
+	    (dc->config.disable_ips == DMUB_IPS_DISABLE_ALL ||
+	    (!suspend_resume_path && dc->config.disable_ips == DMUB_IPS_DISABLE_DYNAMIC)))
+		return;
+
 	dc_allow_idle_optimizations_internal(dc, allow, caller_name);
 }
 
@@ -2891,7 +2919,7 @@ static int dm_suspend(void *handle)
 	if (amdgpu_in_reset(adev)) {
 		mutex_lock(&dm->dc_lock);
 
-		dm_allow_idle_optimizations(adev->dm.dc, false);
+		dm_allow_idle_optimizations_suspend(adev->dm.dc, false);
 
 		dm->cached_dc_state = dc_state_create_copy(dm->dc->current_state);
 
@@ -2918,8 +2946,9 @@ static int dm_suspend(void *handle)
 
 	hpd_rx_irq_work_suspend(dm);
 
+	/* IPS2 entry is required for standby */
 	if (adev->dm.dc->caps.ips_support)
-		dm_allow_idle_optimizations(adev->dm.dc, true);
+		dm_allow_idle_optimizations_suspend(adev->dm.dc, true);
 
 	dc_set_power_state(dm->dc, DC_ACPI_CM_POWER_STATE_D3);
 	dc_dmub_srv_set_power_state(dm->dc->ctx->dmub_srv, DC_ACPI_CM_POWER_STATE_D3);
@@ -3091,9 +3120,8 @@ static int dm_resume(void *handle)
 	bool need_hotplug = false;
 	struct dc_commit_streams_params commit_params = {};
 
-	if (dm->dc->caps.ips_support) {
-		dm_allow_idle_optimizations(dm->dc, false);
-	}
+	if (dm->dc->caps.ips_support)
+		dm_allow_idle_optimizations_suspend(dm->dc, false);
 
 	if (amdgpu_in_reset(adev)) {
 		dc_state = dm->cached_dc_state;
@@ -3142,7 +3170,7 @@ static int dm_resume(void *handle)
 		commit_params.streams = dc_state->streams;
 		commit_params.stream_count = dc_state->stream_count;
 		if (dm->dc->caps.ips_support)
-			dm_allow_idle_optimizations(dm->dc, false);
+			dm_allow_idle_optimizations_suspend(dm->dc, false);
 		WARN_ON(!dc_commit_streams(dm->dc, &commit_params));
 
 		dm_gpureset_commit_state(dm->cached_dc_state, dm);
@@ -3216,7 +3244,7 @@ static int dm_resume(void *handle)
 		} else {
 			mutex_lock(&dm->dc_lock);
 			if (dm->dc->caps.ips_support)
-				dm_allow_idle_optimizations(dm->dc, false);
+				dm_allow_idle_optimizations_suspend(dm->dc, false);
 			dc_link_detect(aconnector->dc_link, DETECT_REASON_RESUMEFROMS3S4);
 			mutex_unlock(&dm->dc_lock);
 		}
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index 3fc3c12b3a4a1..da7283c67b13c 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -1009,8 +1009,11 @@ bool amdgpu_dm_is_headless(struct amdgpu_device *adev);
 
 void dm_allow_idle_optimizations_internal(struct dc *dc,
 					  bool allow,
+					  bool suspend_resume_path,
 					  char const *caller_name);
 #define dm_allow_idle_optimizations(dc, allow) \
-	dm_allow_idle_optimizations_internal(dc, allow, __func__)
+	dm_allow_idle_optimizations_internal(dc, allow, false, __func__)
+#define dm_allow_idle_optimizations_suspend(dc, allow) \
+	dm_allow_idle_optimizations_internal(dc, allow, true, __func__)
 
 #endif /* __AMDGPU_DM_H__ */
-- 
2.46.0

