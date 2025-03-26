Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA555C36010
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Mar 2025 19:53:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BFB5810E1B5;
	Wed, 26 Mar 2025 19:53:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="b4QviD3O";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2081.outbound.protection.outlook.com [40.107.243.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 56A7710E1B5
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Mar 2025 19:53:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YT/y8I22PkyIcpwrjE4A36+Vsda5r4EQDP93N+0uCGb+ZifCicAY2m8BMcAvbts8NDzNjavp82/MUQoXblVlZx9UWHqwKgsj7RqAaK/eYk3vsNhYyyf85gctLUDf8gNBMOZ/mPOmjTz5caNWHfNPe3Hsfo0qoiBAHGUwppOqEiWjkActQVNgzNCBnU1nzHqS/ulfjZ/+0eLUoM2Kg6AuQGy4CTfoXvv+ByKqU6Wf7RemOXs5owCfZBz1l60G9ggVT/61qTZh44T1hCSqBzm1mGikRnfIf/aK9dJzeWFOevlXcIslRfXA7mUzzvXTv6e+W/XyRRJ586GR6SpXObMR3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HEg7+gnUAANMUkbEA2mHC7dBObM4XGYua1Cngj9pxFA=;
 b=xy1jc4wnTjlQP8L0tlwqM7HG71UKD2MVuxHFREpI8SPM50u8yZsCXNe+mGlxIvYErIMjJGxt/4YAzwfFj+mV3aIWW5bbQAJ2lblvt8lGPF114SE58zKGr4fHYxckjdcTvDleIcFMvGcuSSrzQaFmiqk7kvMB0vgMUY5hkHD6BJ79bRRjrYN2/vzAd0fpRxKTpBmZ33DxT6UZD3NsVBQD0oU/tj6vIKMpbjzvu7qOrKS4ZqeOOzViBS4/8jOGZx2vb2kvqdKaZJUIgjGS0dc+CAfJAldjvwrMLqnrLQ2a4VHHvheG3rHFP324REmU4G9bDsdJZA65ypma5hN2ADB5rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HEg7+gnUAANMUkbEA2mHC7dBObM4XGYua1Cngj9pxFA=;
 b=b4QviD3O70gqJtA1jO8Kxqrl5uOJ1AffK5u0mbfxYlIKNX1rUIUUHPw0ANq5xgSVrgqfSdqk/lFoKMX7EiEtmdksrvCPxrQQBHFDPEnfgy60n0S4aU18vvIaJ2t5eZsS95wr4ZiH5ykUmfO6pEFCucLWSRdTph6oyGPajMMO/+0=
Received: from SJ0PR13CA0153.namprd13.prod.outlook.com (2603:10b6:a03:2c7::8)
 by BL4PR12MB9505.namprd12.prod.outlook.com (2603:10b6:208:591::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 26 Mar
 2025 19:53:10 +0000
Received: from SN1PEPF00036F3D.namprd05.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::de) by SJ0PR13CA0153.outlook.office365.com
 (2603:10b6:a03:2c7::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8583.26 via Frontend Transport; Wed,
 26 Mar 2025 19:53:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF00036F3D.mail.protection.outlook.com (10.167.248.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Wed, 26 Mar 2025 19:53:10 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 26 Mar
 2025 14:53:08 -0500
Received: from jzuo-linux.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 26 Mar 2025 14:53:08 -0500
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Alex Hung
 <alex.hung@amd.com>
Subject: [PATCH 03/17] drm/amd/display: use drm_err in
 create_validate_stream_for_sink()
Date: Wed, 26 Mar 2025 15:49:00 -0400
Message-ID: <20250326195202.17343-4-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250326195202.17343-1-Jerry.Zuo@amd.com>
References: <20250326195202.17343-1-Jerry.Zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Jerry.Zuo@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3D:EE_|BL4PR12MB9505:EE_
X-MS-Office365-Filtering-Correlation-Id: 366be152-f5c4-40a9-f261-08dd6c9fd5f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?i2IW0xp1nOIZ3F2fMjZOlDyt6aumYvZEpzZmzkJHlFTfkdyEtMcHw2XvXqp0?=
 =?us-ascii?Q?dyubgeOJjaubH5Sa4TJ/w2VLLHH80yDTrpvQNr7tQm/32xCVKuiKClxMtMWQ?=
 =?us-ascii?Q?xbKEfmaP3I2HqNHl1dvfgYuj8e/BphzQAoV+BL1iNOmfbcOPresJ1H/erYdU?=
 =?us-ascii?Q?VPxhlVdELE8SDtkVIPbhGCkE60KYhq1bM9RT2yDfd4FbHVZOvateSc63Gvcb?=
 =?us-ascii?Q?cLGPFljEo0HT/pw057ncMeeAZ/hbI4nkyt+JXEo6DKb755i/fowGmnfAHYTy?=
 =?us-ascii?Q?ODmaH3ye6DpZ/kEZ2nnkusPYzc+Qc68KslxVMQEI7U5aebaRZaTl06yVn6DF?=
 =?us-ascii?Q?EZYTXwhey8jQbF4gMGWGu43qrs99KZLrpZE7oF5UxpW+clG8mDnNM7xjzvxO?=
 =?us-ascii?Q?l2/NmkgQoJ/2xeTkJkPYL0d/vhFFWSHXo5LHMLplbNQBVX/Rd0sX9mzxk5WP?=
 =?us-ascii?Q?UMBwpRPZL1NyWlBACZKVZpEYLp0BJjOO9y9LqcRZHjdj6INF33mtLvJx6Iai?=
 =?us-ascii?Q?mtaCX+LGZxwQxDD7rC4soh+hulZsK+q4Ah5VAuob9bAVRR2pET0N/qnnka+I?=
 =?us-ascii?Q?aUwnwkxw1JT9CbGdXEDAphxTu6Nk5c6fuvf710K+gdUUuI+zJr7RmeVux7hA?=
 =?us-ascii?Q?NtE5e33ktkkJjBBlKM8+NkelHnHARV6yWORN7dvjXsKWu6yd8WWYL4qOjd3g?=
 =?us-ascii?Q?skDr/LRxJNBqydflP9tKiycTD3L3sJo8cvkHnH6es334JuWyEwfS3/GN7Ocq?=
 =?us-ascii?Q?VBpb7oO0l+VmT1aZfXUcuOkNBm7Sr06obb17A/VRXMmeoGMQKZ40w9BMgGdI?=
 =?us-ascii?Q?RpaboSTMb2axe21Yzs/Mi7CgGqurbdqB+7cy62CGA1411VbbceVuWg0VE+m5?=
 =?us-ascii?Q?aBuhBFPXrMjwf7i5afcL3FyPn7c90rZ7GrNHlHFzlf1auJZKyl/raW5xplne?=
 =?us-ascii?Q?hVq5q4hEOIc98/X8Ejd0Niv50wEFhjrNux1AQ7K603ZOZye5+9SfopVdMCxX?=
 =?us-ascii?Q?da/7mmZNtnP1G58oPcxYA2K/SQhm+7yez/lMF61lHVwWxs/n2qjp7xjDDoTb?=
 =?us-ascii?Q?6Kk5EsOmWH9oI3ZJSaLniEXqfeK+Hp7lWBcInD3AvkzduKVprcez1KuGP+5e?=
 =?us-ascii?Q?857boUX++8w+7drrsvjmGQCAxqA66/fNGWmbc0je62WTAunFv6kfoDPeFkND?=
 =?us-ascii?Q?rtxvCZo1ErKhkbyMzzuU2yUVjeESyZHBAk6QDXlW/jB1IAQkawPfwfKFwF5T?=
 =?us-ascii?Q?sX60zW5TzzuJHkSew/zrMjjxjO2RRyaZCcDtVRCJDvN7pZOS0M4o/S8Awlai?=
 =?us-ascii?Q?nz4mv0buVsCKdGyDR/MB21A/ELUnLIRUbSjTR18g5qQeP5tS8Fv07kw4dlQR?=
 =?us-ascii?Q?oeEydxGmHfh8ZTs58+h9OnaHk5ZEBrj295yPelvEeT2M49PLXBO3QVRXwMZL?=
 =?us-ascii?Q?CjD41Gio52rSqJze/c2VUZ67PQwKvG3N3toIw1pc2mpPkdnbNmS60Cu05w8x?=
 =?us-ascii?Q?CWEYIPKr0eK0TP0=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 19:53:10.0690 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 366be152-f5c4-40a9-f261-08dd6c9fd5f8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F3D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9505
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

From: Aurabindo Pillai <aurabindo.pillai@amd.com>

make the drm device available in create_validate_stream_for_sink()
so that drm_err() can be used

Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 16e2823f83b1..639b1c01cbf9 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -6506,7 +6506,7 @@ decide_crtc_timing_for_drm_display_mode(struct drm_display_mode *drm_mode,
 }
 
 static struct dc_sink *
-create_fake_sink(struct dc_link *link)
+create_fake_sink(struct drm_device *dev, struct dc_link *link)
 {
 	struct dc_sink_init_data sink_init_data = { 0 };
 	struct dc_sink *sink = NULL;
@@ -6516,7 +6516,7 @@ create_fake_sink(struct dc_link *link)
 
 	sink = dc_sink_create(&sink_init_data);
 	if (!sink) {
-		DRM_ERROR("Failed to create sink!\n");
+		drm_err(dev, "Failed to create sink!\n");
 		return NULL;
 	}
 	sink->sink_signal = SIGNAL_TYPE_VIRTUAL;
@@ -6872,6 +6872,7 @@ create_stream_for_sink(struct drm_connector *connector,
 		       const struct dc_stream_state *old_stream,
 		       int requested_bpc)
 {
+	struct drm_device *dev = connector->dev;
 	struct amdgpu_dm_connector *aconnector = NULL;
 	struct drm_display_mode *preferred_mode = NULL;
 	const struct drm_connector_state *con_state = &dm_state->base;
@@ -6895,7 +6896,7 @@ create_stream_for_sink(struct drm_connector *connector,
 	memset(&saved_mode, 0, sizeof(saved_mode));
 
 	if (connector == NULL) {
-		DRM_ERROR("connector is NULL!\n");
+		drm_err(dev, "connector is NULL!\n");
 		return stream;
 	}
 
@@ -6913,7 +6914,7 @@ create_stream_for_sink(struct drm_connector *connector,
 	}
 
 	if (!aconnector || !aconnector->dc_sink) {
-		sink = create_fake_sink(link);
+		sink = create_fake_sink(dev, link);
 		if (!sink)
 			return stream;
 
@@ -6925,7 +6926,7 @@ create_stream_for_sink(struct drm_connector *connector,
 	stream = dc_create_stream_for_sink(sink);
 
 	if (stream == NULL) {
-		DRM_ERROR("Failed to create stream for sink!\n");
+		drm_err(dev, "Failed to create stream for sink!\n");
 		goto finish;
 	}
 
@@ -7609,7 +7610,7 @@ create_validate_stream_for_sink(struct drm_connector *connector,
 						dm_state, old_stream,
 						requested_bpc);
 		if (stream == NULL) {
-			DRM_ERROR("Failed to create stream for sink!\n");
+			drm_err(adev_to_drm(adev), "Failed to create stream for sink!\n");
 			break;
 		}
 
-- 
2.43.0

