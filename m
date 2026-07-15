Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B730C44501
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2026 13:48:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D493810F09C;
	Wed, 15 Jul 2026 13:48:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DNv7UZn2";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011066.outbound.protection.outlook.com
 [40.93.194.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3464410F09C
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 13:48:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZZKnnkgWthTi3QLY5tbNhuxlFrWSMGMFJVyLA9rOXM542+2ZMPZdcSHTCTLtqHpuvp/VepjUHXOWEZqUORHdDfSpaY8oY+90pnD8YyXxJgOvfJbPwII5dAdmELppqA+c/CxSH27Dk9J6hGAh5eQHQaWrMosW4B+f7lLgcT7qYow8So72XPPufXYDjPlFcHoDBhhAE2aGyPBvi9ZKTcDL3jFItu15GiG99vOoDgvUuMGsAXOUml9WmU5HXTC4rWbpeAS8h+FrgJe48qmVlLY5U8E8xCy6zrjGUXKO/036bhhaVzKNPNalKKkKpTMBEQjfHfVv070PGfm0by/o2CsWIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=udgAWZtak7x5WmcUNlXqXTozScc6VoWaY8DntFO3mm0=;
 b=nsOVdt4HDjWb24FTCYbKLfeCFV4Inp9ZElay4d2RdtUlrFrxJV+nQI6u4Ccb9HSIZMv/OIqDL19k9U5wuOj+nY9Wz7EPHRg5sg2eoTTHWSXXwqYHP8qehUzm/n7UEhcy66TaR3TUckUpvI4Ri+4ef74kZabpHdx88hXnuWzMlUK9i63Y/olTXW4miXGi+rLfD/RB3xR8gMISdDrWMb0rkvQHM+Ly1PoeWe7ld/d0V1g+jgV+u9RbAaCZLmeZX8v/bBxlo8iWR83o6hqKyyOmKJSvPp+R7OR/eYZoQomS+R1xv6YXi0lxPRBKMAkabaprYKxVJYaSnu6I1gzdMBw2og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=udgAWZtak7x5WmcUNlXqXTozScc6VoWaY8DntFO3mm0=;
 b=DNv7UZn2zqGrwfi+JFaMqpqfcc2tCLBp7x/0ljlKgwZuhgHl2bV9vZlC/9xVKLRYDCm/VOhm8SiWwJAOJUn2ywiGkyoFIWxi2cQDCLtrZi26g+nC5nWZs/5/od0vcGR2zlVPkkGft6+hI7BcFFKYOQLN+fLwUFCWj+A2ZC1YvCM=
Received: from SJ0PR03CA0237.namprd03.prod.outlook.com (2603:10b6:a03:39f::32)
 by CH0PR12MB8552.namprd12.prod.outlook.com (2603:10b6:610:18e::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.10; Wed, 15 Jul
 2026 13:47:45 +0000
Received: from SJ5PEPF000001F1.namprd05.prod.outlook.com
 (2603:10b6:a03:39f:cafe::63) by SJ0PR03CA0237.outlook.office365.com
 (2603:10b6:a03:39f::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.11 via Frontend Transport; Wed,
 15 Jul 2026 13:47:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001F1.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Wed, 15 Jul 2026 13:47:43 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 15 Jul
 2026 08:47:42 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 15 Jul 2026 08:47:39 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 45/70] drm/amd/display: Add mode helper tests for connector
Date: Wed, 15 Jul 2026 21:37:55 +0800
Message-ID: <20260715134432.1975118-46-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260715134432.1975118-1-Wayne.Lin@amd.com>
References: <20260715134432.1975118-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F1:EE_|CH0PR12MB8552:EE_
X-MS-Office365-Filtering-Correlation-Id: d845c0d0-97be-4b4c-c6ce-08dee277a538
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|36860700016|82310400026|11063799006|5023799004|3023799007|56012099006|18002099003|22082099003|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info: VcXadOSnVHIn/kdLCzAPNqyni50kOaSIdmPKd0vnZWZLwAFLBLSei5/oYyCzIqQQwfjUyasJiiNAilDAQmLjQZ8N57fBFvPFnyYCgddNxrHZoAvRsNJHmcvUmHJlCjZWRcnV6DFpyHqoG8Sa8ZeAbozEcbULB+2WUqiYu1ayOwDJFaXfcdCKB0nUV6TVTZgC8xrkTZBivAOBiFc/rA0lsCgOQvVXfpB2X1TgLtcTgb1qdcpKzMhVfKBFfdUvzJ43DSJNA5O6JO9WkJFrbk1lKSNnpU46nBjz3qc8eUDZYgZMbyx/ggAFeE08Eb17xMiKFm7z+I7SOVlPbGHXhgdYOC4Nw72SAWA98j5CQsBuW1NxXc7z9GB2lw1kNhgc5nhu3dmyLelirDc1bHycrOUjX7h5+a4CoX73k4SQVRhjppY+fk5Zp1jKh0S791pTY0zPXgQbuVlh0m1aRqiILPeXxqB6r6R9nw6TGmr4yF8utfQiwPhkW7+dtOdpaHi3CV4EWuzIQFoc+c+8RudTwDsNJ+MFxB171NbNwbWEqCa+YyNNiAuXqbXrNsJyoixzO6usjm8uS7N7cpRo/1hRaXJg+uB5G5vCqTpwUF3CdwS4YZsFfrKCQxaCQdPIJbdskvowcOlsoTG13PGDl7lqwKGPqRbXRqQikdsUTn1NAzCqekMwb7moEDCmb+NBjT9L24krQGiW95zna3SJKjZQFOvjdQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(36860700016)(82310400026)(11063799006)(5023799004)(3023799007)(56012099006)(18002099003)(22082099003)(6133799003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: MRBdN8cYhMklnVqJlbFmAVr/+05wDZCVnC/Yo1vl7FXhclaGR3bNjssGHryycYMYOedszaKD8FQGcU58M/WRhmeUx7+EPyeY2npdJYgUp5LSaXYM9Z7vL5UDCKhb+bkNxW1cjhLT+Bl4WgjHP1Xkdll4RiPEcrgf34JFRCk+RkjG5IqkehVdt6lwrSe66zhjTOf8QJraw3WUoLugjpCH5DlFbefWxjZqFvOBXXBukIamIjhJvH+PCkXzgvla8dLSGqxETfTn1A0PM7kVZP/hyttGiJ2WZkpNJneUFmXDLS6nU75ugNqbsoLObZq2JPuPHCf3Jy/5D0XLld2agzFi6+ophWavQZALS2D4Qs6Z6YzDrTKC5ar2rLA+9v68ddY8LFuduEkoP4MND2/07oPtuiPXmhjGbK7XNAxwB36oZ2iwoPraEtuU6sKvdD4eoMgR
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 13:47:43.2751 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d845c0d0-97be-4b4c-c6ce-08dee277a538
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8552
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

From: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>

Add KUnit coverage for the connector mode helpers:
amdgpu_dm_connector_funcs_force(), dm_validate_stream_and_context(),
amdgpu_dm_connector_to_encoder(), amdgpu_dm_get_native_mode(),
amdgpu_dm_create_common_mode(), amdgpu_dm_connector_add_common_modes(),
amdgpu_dm_connector_ddc_get_modes(), add_fs_modes() and
amdgpu_dm_connector_add_freesync_modes().

Assisted-by: Copilot:Claude-Opus-4.8
Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 .../display/amdgpu_dm/amdgpu_dm_connector.c   |  27 +-
 .../display/amdgpu_dm/amdgpu_dm_connector.h   |  15 +
 .../tests/amdgpu_dm_connector_test.c          | 309 ++++++++++++++++++
 3 files changed, 342 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
index 6d358cb84961..557cc6492529 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
@@ -1914,7 +1914,7 @@ amdgpu_dm_connector_late_register(struct drm_connector *connector)
 }
 EXPORT_IF_KUNIT(amdgpu_dm_connector_late_register);
 
-static void amdgpu_dm_connector_funcs_force(struct drm_connector *connector)
+STATIC_IFN_KUNIT void amdgpu_dm_connector_funcs_force(struct drm_connector *connector)
 {
 	struct amdgpu_dm_connector *aconnector = to_amdgpu_dm_connector(connector);
 	struct dc_link *dc_link = aconnector->dc_link;
@@ -1950,6 +1950,7 @@ static void amdgpu_dm_connector_funcs_force(struct drm_connector *connector)
 			&dc_em_sink->edid_caps);
 	}
 }
+EXPORT_IF_KUNIT(amdgpu_dm_connector_funcs_force);
 
 static const struct drm_connector_funcs amdgpu_dm_connector_funcs = {
 	.reset = amdgpu_dm_connector_funcs_reset,
@@ -2034,7 +2035,7 @@ STATIC_IFN_KUNIT void handle_edid_mgmt(struct amdgpu_dm_connector *aconnector)
 }
 EXPORT_IF_KUNIT(handle_edid_mgmt);
 
-static enum dc_status dm_validate_stream_and_context(struct dc *dc,
+STATIC_IFN_KUNIT enum dc_status dm_validate_stream_and_context(struct dc *dc,
 						struct dc_stream_state *stream)
 {
 	enum dc_status dc_result = DC_ERROR_UNEXPECTED;
@@ -2096,6 +2097,7 @@ static enum dc_status dm_validate_stream_and_context(struct dc *dc,
 
 	return dc_result;
 }
+EXPORT_IF_KUNIT(dm_validate_stream_and_context);
 
 struct dc_stream_state *
 amdgpu_dm_create_validate_stream_for_sink(struct drm_connector *connector,
@@ -2460,7 +2462,7 @@ STATIC_IFN_KUNIT int to_drm_connector_type(enum signal_type st, uint32_t connect
 }
 EXPORT_IF_KUNIT(to_drm_connector_type);
 
-static struct drm_encoder *amdgpu_dm_connector_to_encoder(struct drm_connector *connector)
+STATIC_IFN_KUNIT struct drm_encoder *amdgpu_dm_connector_to_encoder(struct drm_connector *connector)
 {
 	struct drm_encoder *encoder;
 
@@ -2470,8 +2472,9 @@ static struct drm_encoder *amdgpu_dm_connector_to_encoder(struct drm_connector *
 
 	return NULL;
 }
+EXPORT_IF_KUNIT(amdgpu_dm_connector_to_encoder);
 
-static void amdgpu_dm_get_native_mode(struct drm_connector *connector)
+STATIC_IFN_KUNIT void amdgpu_dm_get_native_mode(struct drm_connector *connector)
 {
 	struct drm_encoder *encoder;
 	struct amdgpu_encoder *amdgpu_encoder;
@@ -2499,8 +2502,9 @@ static void amdgpu_dm_get_native_mode(struct drm_connector *connector)
 
 	}
 }
+EXPORT_IF_KUNIT(amdgpu_dm_get_native_mode);
 
-static struct drm_display_mode *
+STATIC_IFN_KUNIT struct drm_display_mode *
 amdgpu_dm_create_common_mode(struct drm_encoder *encoder,
 			     const char *name,
 			     int hdisplay, int vdisplay)
@@ -2523,6 +2527,7 @@ amdgpu_dm_create_common_mode(struct drm_encoder *encoder,
 	return mode;
 
 }
+EXPORT_IF_KUNIT(amdgpu_dm_create_common_mode);
 
 static const struct amdgpu_dm_mode_size {
 	char name[DRM_DISPLAY_MODE_LEN];
@@ -2542,7 +2547,7 @@ static const struct amdgpu_dm_mode_size {
 	{"1920x1200", 1920, 1200}
 };
 
-static void amdgpu_dm_connector_add_common_modes(struct drm_encoder *encoder,
+STATIC_IFN_KUNIT void amdgpu_dm_connector_add_common_modes(struct drm_encoder *encoder,
 						 struct drm_connector *connector)
 {
 	struct amdgpu_encoder *amdgpu_encoder = to_amdgpu_encoder(encoder);
@@ -2590,6 +2595,7 @@ static void amdgpu_dm_connector_add_common_modes(struct drm_encoder *encoder,
 		amdgpu_dm_connector->num_modes++;
 	}
 }
+EXPORT_IF_KUNIT(amdgpu_dm_connector_add_common_modes);
 
 void amdgpu_set_panel_orientation(struct drm_connector *connector)
 {
@@ -2621,7 +2627,7 @@ void amdgpu_set_panel_orientation(struct drm_connector *connector)
 						       native_mode->vdisplay);
 }
 
-static void amdgpu_dm_connector_ddc_get_modes(struct drm_connector *connector,
+STATIC_IFN_KUNIT void amdgpu_dm_connector_ddc_get_modes(struct drm_connector *connector,
 					      const struct drm_edid *drm_edid)
 {
 	struct amdgpu_dm_connector *amdgpu_dm_connector =
@@ -2653,6 +2659,7 @@ static void amdgpu_dm_connector_ddc_get_modes(struct drm_connector *connector,
 		amdgpu_dm_connector->num_modes = 0;
 	}
 }
+EXPORT_IF_KUNIT(amdgpu_dm_connector_ddc_get_modes);
 
 STATIC_IFN_KUNIT bool is_duplicate_mode(struct amdgpu_dm_connector *aconnector,
 			      struct drm_display_mode *mode)
@@ -2668,7 +2675,7 @@ STATIC_IFN_KUNIT bool is_duplicate_mode(struct amdgpu_dm_connector *aconnector,
 }
 EXPORT_IF_KUNIT(is_duplicate_mode);
 
-static uint add_fs_modes(struct amdgpu_dm_connector *aconnector)
+STATIC_IFN_KUNIT uint add_fs_modes(struct amdgpu_dm_connector *aconnector)
 {
 	const struct drm_display_mode *m;
 	struct drm_display_mode *new_mode;
@@ -2743,8 +2750,9 @@ static uint add_fs_modes(struct amdgpu_dm_connector *aconnector)
  out:
 	return new_modes_count;
 }
+EXPORT_IF_KUNIT(add_fs_modes);
 
-static void amdgpu_dm_connector_add_freesync_modes(struct drm_connector *connector,
+STATIC_IFN_KUNIT void amdgpu_dm_connector_add_freesync_modes(struct drm_connector *connector,
 						   const struct drm_edid *drm_edid)
 {
 	struct amdgpu_dm_connector *amdgpu_dm_connector =
@@ -2767,6 +2775,7 @@ static void amdgpu_dm_connector_add_freesync_modes(struct drm_connector *connect
 		amdgpu_dm_connector->num_modes +=
 			add_fs_modes(amdgpu_dm_connector);
 }
+EXPORT_IF_KUNIT(amdgpu_dm_connector_add_freesync_modes);
 
 static int amdgpu_dm_connector_get_modes(struct drm_connector *connector)
 {
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.h
index f7ec4b906e13..b237e8f864db 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.h
@@ -146,6 +146,21 @@ int amdgpu_dm_encoder_init(struct drm_device *dev,
 			   uint32_t link_index);
 
 #if IS_ENABLED(CONFIG_DRM_AMD_DC_KUNIT_TEST)
+void amdgpu_dm_connector_funcs_force(struct drm_connector *connector);
+enum dc_status dm_validate_stream_and_context(struct dc *dc,
+					      struct dc_stream_state *stream);
+struct drm_encoder *amdgpu_dm_connector_to_encoder(struct drm_connector *connector);
+void amdgpu_dm_get_native_mode(struct drm_connector *connector);
+struct drm_display_mode *amdgpu_dm_create_common_mode(struct drm_encoder *encoder,
+						      const char *name,
+						      int hdisplay, int vdisplay);
+void amdgpu_dm_connector_add_common_modes(struct drm_encoder *encoder,
+					  struct drm_connector *connector);
+void amdgpu_dm_connector_ddc_get_modes(struct drm_connector *connector,
+				       const struct drm_edid *drm_edid);
+uint add_fs_modes(struct amdgpu_dm_connector *aconnector);
+void amdgpu_dm_connector_add_freesync_modes(struct drm_connector *connector,
+					    const struct drm_edid *drm_edid);
 void hdmi_cec_unset_edid(struct amdgpu_dm_connector *aconnector);
 void create_eml_sink(struct amdgpu_dm_connector *aconnector);
 void handle_edid_mgmt(struct amdgpu_dm_connector *aconnector);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
index 59f2f8235486..459f0eda9a69 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_connector_test.c
@@ -11,8 +11,10 @@
 #include <drm/drm_connector.h>
 #include <drm/drm_crtc.h>
 #include <drm/drm_edid.h>
+#include <drm/drm_encoder.h>
 #include <drm/drm_kunit_helpers.h>
 #include <drm/drm_mode_object.h>
+#include <drm/drm_modes.h>
 #include <drm/drm_property.h>
 #include <linux/hdmi.h>
 
@@ -4379,6 +4381,291 @@ static void dm_test_handle_edid_mgmt_non_dp_leaves_caps(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, (int)ctx->link->verified_link_cap.link_rate, 0);
 }
 
+/*
+ * Context for the connector funcs / modes tests: a managed DRM device with a
+ * registered connector and a managed encoder attached to it, so helpers that
+ * walk connector->encoder relationships resolve correctly.
+ */
+struct dm_test_modes_ctx {
+	struct drm_device *drm;
+	struct amdgpu_dm_connector *aconnector;
+	struct amdgpu_encoder *aenc;
+};
+
+static struct dm_test_modes_ctx *
+dm_test_modes_ctx_alloc(struct kunit *test, int connector_type)
+{
+	struct dm_test_modes_ctx *ctx;
+
+	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx);
+
+	ctx->drm = dm_test_alloc_drm(test);
+	ctx->aconnector = dm_test_add_connector(test, ctx->drm, connector_type);
+
+	ctx->aenc = kunit_kzalloc(test, sizeof(*ctx->aenc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ctx->aenc);
+	KUNIT_ASSERT_EQ(test,
+			drmm_encoder_init(ctx->drm, &ctx->aenc->base, NULL,
+					  DRM_MODE_ENCODER_TMDS, NULL), 0);
+	KUNIT_ASSERT_EQ(test,
+			drm_connector_attach_encoder(&ctx->aconnector->base,
+						     &ctx->aenc->base), 0);
+
+	return ctx;
+}
+
+/**
+ * dm_test_funcs_force_no_edid - Test force() leaves drm_edid NULL when no EDID
+ * @test: The KUnit test context
+ *
+ * A headless force-on DisplayPort connector reads no EDID, so the cached
+ * drm_edid pointer must stay NULL after the force callback runs.
+ */
+static void dm_test_funcs_force_no_edid(struct kunit *test)
+{
+	struct dm_test_edid_ctx *ctx =
+		dm_test_edid_ctx_alloc(test, DRM_MODE_CONNECTOR_DisplayPort);
+
+	amdgpu_dm_connector_funcs_force(&ctx->aconnector->base);
+
+	KUNIT_EXPECT_NULL(test, ctx->aconnector->drm_edid);
+}
+
+/**
+ * dm_test_validate_stream_null_stream - Test NULL stream returns unexpected
+ * @test: The KUnit test context
+ *
+ * With a NULL stream the validation jumps straight to cleanup without ever
+ * dereferencing the dc handle and reports DC_ERROR_UNEXPECTED.
+ */
+static void dm_test_validate_stream_null_stream(struct kunit *test)
+{
+	KUNIT_EXPECT_EQ(test,
+			(int)dm_validate_stream_and_context(NULL, NULL),
+			(int)DC_ERROR_UNEXPECTED);
+}
+
+/**
+ * dm_test_to_encoder_no_encoder - Test connector with no encoder returns NULL
+ * @test: The KUnit test context
+ */
+static void dm_test_to_encoder_no_encoder(struct kunit *test)
+{
+	struct drm_device *drm = dm_test_alloc_drm(test);
+	struct amdgpu_dm_connector *aconnector =
+		dm_test_add_connector(test, drm, DRM_MODE_CONNECTOR_HDMIA);
+
+	KUNIT_EXPECT_NULL(test,
+			  amdgpu_dm_connector_to_encoder(&aconnector->base));
+}
+
+/**
+ * dm_test_to_encoder_returns_attached - Test the attached encoder is returned
+ * @test: The KUnit test context
+ */
+static void dm_test_to_encoder_returns_attached(struct kunit *test)
+{
+	struct dm_test_modes_ctx *ctx =
+		dm_test_modes_ctx_alloc(test, DRM_MODE_CONNECTOR_HDMIA);
+
+	KUNIT_EXPECT_PTR_EQ(test,
+			    amdgpu_dm_connector_to_encoder(&ctx->aconnector->base),
+			    &ctx->aenc->base);
+}
+
+/**
+ * dm_test_native_mode_no_encoder - Test native mode resolution is a no-op
+ * @test: The KUnit test context
+ *
+ * Without an encoder there is nothing to copy into, so the call must return
+ * cleanly without dereferencing a NULL encoder.
+ */
+static void dm_test_native_mode_no_encoder(struct kunit *test)
+{
+	struct drm_device *drm = dm_test_alloc_drm(test);
+	struct amdgpu_dm_connector *aconnector =
+		dm_test_add_connector(test, drm, DRM_MODE_CONNECTOR_HDMIA);
+
+	amdgpu_dm_get_native_mode(&aconnector->base);
+}
+
+/**
+ * dm_test_native_mode_empty_probed_zeroes_clock - Test empty probed list clears mode
+ * @test: The KUnit test context
+ *
+ * With no probed modes there is no preferred mode to copy, so the encoder's
+ * native mode is memset to zero (clock becomes 0).
+ */
+static void dm_test_native_mode_empty_probed_zeroes_clock(struct kunit *test)
+{
+	struct dm_test_modes_ctx *ctx =
+		dm_test_modes_ctx_alloc(test, DRM_MODE_CONNECTOR_eDP);
+
+	ctx->aenc->native_mode.clock = 148500;
+
+	amdgpu_dm_get_native_mode(&ctx->aconnector->base);
+
+	KUNIT_EXPECT_EQ(test, ctx->aenc->native_mode.clock, 0);
+}
+
+/**
+ * dm_test_native_mode_copies_preferred - Test the preferred mode is copied
+ * @test: The KUnit test context
+ *
+ * The preferred probed mode is duplicated into the encoder's native mode.
+ */
+static void dm_test_native_mode_copies_preferred(struct kunit *test)
+{
+	struct dm_test_modes_ctx *ctx =
+		dm_test_modes_ctx_alloc(test, DRM_MODE_CONNECTOR_eDP);
+	struct drm_display_mode *mode;
+
+	mode = drm_mode_create(ctx->drm);
+	KUNIT_ASSERT_NOT_NULL(test, mode);
+	mode->type = DRM_MODE_TYPE_PREFERRED;
+	mode->clock = 148500;
+	mode->hdisplay = 1920;
+	mode->vdisplay = 1080;
+	drm_mode_probed_add(&ctx->aconnector->base, mode);
+
+	amdgpu_dm_get_native_mode(&ctx->aconnector->base);
+
+	KUNIT_EXPECT_EQ(test, ctx->aenc->native_mode.hdisplay, 1920);
+	KUNIT_EXPECT_EQ(test, ctx->aenc->native_mode.vdisplay, 1080);
+	KUNIT_EXPECT_EQ(test, ctx->aenc->native_mode.clock, 148500);
+}
+
+/**
+ * dm_test_create_common_mode_overrides - Test common mode inherits native timing
+ * @test: The KUnit test context
+ *
+ * A new common mode takes its pixel clock and porches from the encoder's
+ * native mode but overrides the visible resolution and clears PREFERRED.
+ */
+static void dm_test_create_common_mode_overrides(struct kunit *test)
+{
+	struct dm_test_modes_ctx *ctx =
+		dm_test_modes_ctx_alloc(test, DRM_MODE_CONNECTOR_eDP);
+	struct drm_display_mode *mode;
+
+	ctx->aenc->native_mode.clock = 148500;
+	ctx->aenc->native_mode.htotal = 2200;
+	ctx->aenc->native_mode.type = DRM_MODE_TYPE_PREFERRED;
+
+	mode = amdgpu_dm_create_common_mode(&ctx->aenc->base, "800x600",
+					    800, 600);
+	KUNIT_ASSERT_NOT_NULL(test, mode);
+
+	KUNIT_EXPECT_EQ(test, mode->hdisplay, 800);
+	KUNIT_EXPECT_EQ(test, mode->vdisplay, 600);
+	KUNIT_EXPECT_EQ(test, mode->clock, 148500);
+	KUNIT_EXPECT_EQ(test, mode->htotal, 2200);
+	KUNIT_EXPECT_FALSE(test, mode->type & DRM_MODE_TYPE_PREFERRED);
+	KUNIT_EXPECT_STREQ(test, mode->name, "800x600");
+
+	drm_mode_destroy(ctx->drm, mode);
+}
+
+/**
+ * dm_test_add_common_modes_non_edp_noop - Test non-eDP/LVDS adds no modes
+ * @test: The KUnit test context
+ *
+ * Common scaled modes are only added for eDP/LVDS panels; an HDMI connector
+ * is left untouched.
+ */
+static void dm_test_add_common_modes_non_edp_noop(struct kunit *test)
+{
+	struct dm_test_modes_ctx *ctx =
+		dm_test_modes_ctx_alloc(test, DRM_MODE_CONNECTOR_HDMIA);
+
+	ctx->aenc->native_mode.hdisplay = 1920;
+	ctx->aenc->native_mode.vdisplay = 1200;
+
+	amdgpu_dm_connector_add_common_modes(&ctx->aenc->base,
+					     &ctx->aconnector->base);
+
+	KUNIT_EXPECT_EQ(test, ctx->aconnector->num_modes, 0);
+}
+
+/**
+ * dm_test_add_common_modes_edp_adds - Test eDP adds the smaller common modes
+ * @test: The KUnit test context
+ *
+ * For an eDP panel with a 1920x1200 native mode every common mode strictly
+ * smaller than the native one is added (10 of the 11 entries).
+ */
+static void dm_test_add_common_modes_edp_adds(struct kunit *test)
+{
+	struct dm_test_modes_ctx *ctx =
+		dm_test_modes_ctx_alloc(test, DRM_MODE_CONNECTOR_eDP);
+
+	ctx->aenc->native_mode.hdisplay = 1920;
+	ctx->aenc->native_mode.vdisplay = 1200;
+
+	amdgpu_dm_connector_add_common_modes(&ctx->aenc->base,
+					     &ctx->aconnector->base);
+
+	KUNIT_EXPECT_EQ(test, ctx->aconnector->num_modes, 10);
+}
+
+/**
+ * dm_test_ddc_get_modes_null_edid - Test a NULL EDID resets the mode count
+ * @test: The KUnit test context
+ */
+static void dm_test_ddc_get_modes_null_edid(struct kunit *test)
+{
+	struct drm_device *drm = dm_test_alloc_drm(test);
+	struct amdgpu_dm_connector *aconnector =
+		dm_test_add_connector(test, drm, DRM_MODE_CONNECTOR_HDMIA);
+
+	aconnector->num_modes = 5;
+
+	amdgpu_dm_connector_ddc_get_modes(&aconnector->base, NULL);
+
+	KUNIT_EXPECT_EQ(test, aconnector->num_modes, 0);
+}
+
+/**
+ * dm_test_add_fs_modes_no_preferred_mode - Test no preferred mode yields no modes
+ * @test: The KUnit test context
+ *
+ * A writeback connector has no highest-refresh-rate mode, so add_fs_modes()
+ * cannot build any FreeSync video modes and returns 0.
+ */
+static void dm_test_add_fs_modes_no_preferred_mode(struct kunit *test)
+{
+	struct amdgpu_dm_connector *aconnector;
+
+	aconnector = kunit_kzalloc(test, sizeof(*aconnector), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, aconnector);
+
+	aconnector->base.connector_type = DRM_MODE_CONNECTOR_WRITEBACK;
+
+	KUNIT_EXPECT_EQ(test, (int)add_fs_modes(aconnector), 0);
+}
+
+/**
+ * dm_test_add_freesync_modes_null_edid_noop - Test NULL EDID adds no modes
+ * @test: The KUnit test context
+ *
+ * Without an EDID the FreeSync video modes cannot be derived, so the mode
+ * count is left unchanged.
+ */
+static void dm_test_add_freesync_modes_null_edid_noop(struct kunit *test)
+{
+	struct amdgpu_dm_connector *aconnector;
+
+	aconnector = kunit_kzalloc(test, sizeof(*aconnector), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, aconnector);
+
+	aconnector->num_modes = 7;
+
+	amdgpu_dm_connector_add_freesync_modes(&aconnector->base, NULL);
+
+	KUNIT_EXPECT_EQ(test, aconnector->num_modes, 7);
+}
+
 static struct kunit_case amdgpu_dm_connector_tests[] = {
 	/* get_subconnector_type */
 	KUNIT_CASE(dm_test_subconnector_type_none),
@@ -4608,6 +4895,28 @@ static struct kunit_case amdgpu_dm_connector_tests[] = {
 	/* handle_edid_mgmt */
 	KUNIT_CASE(dm_test_handle_edid_mgmt_dp_sets_link_caps),
 	KUNIT_CASE(dm_test_handle_edid_mgmt_non_dp_leaves_caps),
+	/* amdgpu_dm_connector_funcs_force */
+	KUNIT_CASE(dm_test_funcs_force_no_edid),
+	/* dm_validate_stream_and_context */
+	KUNIT_CASE(dm_test_validate_stream_null_stream),
+	/* amdgpu_dm_connector_to_encoder */
+	KUNIT_CASE(dm_test_to_encoder_no_encoder),
+	KUNIT_CASE(dm_test_to_encoder_returns_attached),
+	/* amdgpu_dm_get_native_mode */
+	KUNIT_CASE(dm_test_native_mode_no_encoder),
+	KUNIT_CASE(dm_test_native_mode_empty_probed_zeroes_clock),
+	KUNIT_CASE(dm_test_native_mode_copies_preferred),
+	/* amdgpu_dm_create_common_mode */
+	KUNIT_CASE(dm_test_create_common_mode_overrides),
+	/* amdgpu_dm_connector_add_common_modes */
+	KUNIT_CASE(dm_test_add_common_modes_non_edp_noop),
+	KUNIT_CASE(dm_test_add_common_modes_edp_adds),
+	/* amdgpu_dm_connector_ddc_get_modes */
+	KUNIT_CASE(dm_test_ddc_get_modes_null_edid),
+	/* add_fs_modes */
+	KUNIT_CASE(dm_test_add_fs_modes_no_preferred_mode),
+	/* amdgpu_dm_connector_add_freesync_modes */
+	KUNIT_CASE(dm_test_add_freesync_modes_null_edid_noop),
 	{}
 };
 
-- 
2.43.0

