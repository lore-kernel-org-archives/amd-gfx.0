Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3838CD8CB9
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jun 2026 09:49:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7258110E876;
	Wed, 10 Jun 2026 09:49:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="04/91j2R";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011023.outbound.protection.outlook.com [52.101.52.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F0BB010E876
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jun 2026 09:49:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bQrSbA/SSb/TTqbl7ihq566JZKesPE4d2Jo4473GcRFybJkxoYUD8zwWyQYJ0AwDhz20VpfwpmC9GcShBjIhIpGJb9oR4niyxl3LzR5gYMYVDLhHAY8UkblhRuUZmPl0A7fwBiiU+QFkK6SpA2yvEORmULH3EoVGmcHRcEUT46JowVisaGVNlog3m6VmA7BOm6pbF4ba3o8ZE1cm8cDXblJdO0Y/qy+WE768z73qaq8HudVysqBrM94q/YiGYVigFzbGRLUAk9zZu2NUWXlxq8CUU2SNbexMmb+eGMRj9kmO7qA5qDURA/GjpYakPQWLwTPg1p8R/fYX4hvnOF+Grg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O4iEErztvxZHEWIxAnqCQRbQuWJic8TSdlZ/QE8/DXo=;
 b=OujyaOTpIwfgksonKaEcQ4fxk7nwin27MPFos19VdSw2tR9l/1NQztWpXGXk95UMrAdnCsQX8r3gJ0PpL7q9wMUswyLZ3EbxqgngIS3kbptz72M1SSbyTSO8jXBWCNDA/xi3Sz/ZXVFy0R/8tnRPjQhMS8wt+kRtfVsQUYoD4wBl6kX7umtc2IW5EChBtDAC9nUahwVEUP+s87FTqjAud4H1LjqJCVHq0h+V/e20BDcAQCbNk9M2MVYkD12LMNQY2kTF9IBbz38sYnIpFoavGwhxeYfINpW51gH4fpztZVuSeTrHdtTNlvKH4Ow+fQraDzFCO5Y7dUIagMLwwDq8sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O4iEErztvxZHEWIxAnqCQRbQuWJic8TSdlZ/QE8/DXo=;
 b=04/91j2RDoiF4zQ7roHw8yEtKyF8756EGwzjaydeGv8K2tlL5iCyR7Xz7JfkEIu4ciMIEmMgR7fOvJuh2jVv0rpHn1vqgaqhHxQ8HimBbJ52/ASfY65vWIRNZP3TVZUDfXMUVnVEoiL8BnJapnJL2FUcPlvSnfqgPkOrXm0wpNs=
Received: from BN9PR03CA0428.namprd03.prod.outlook.com (2603:10b6:408:113::13)
 by BY1PR12MB8446.namprd12.prod.outlook.com (2603:10b6:a03:52d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Wed, 10 Jun
 2026 09:49:10 +0000
Received: from BN2PEPF00004FC0.namprd04.prod.outlook.com
 (2603:10b6:408:113:cafe::98) by BN9PR03CA0428.outlook.office365.com
 (2603:10b6:408:113::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.10 via Frontend Transport; Wed,
 10 Jun 2026 09:49:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FC0.mail.protection.outlook.com (10.167.243.186) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Wed, 10 Jun 2026 09:49:10 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 10 Jun
 2026 04:49:09 -0500
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 10 Jun 2026 04:49:00 -0500
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>,
 "Chenyu Chen" <chen-yu.chen@amd.com>
Subject: [PATCH 08/32] drm/amd/display: Extract audio code to amdgpu_dm_audio
Date: Wed, 10 Jun 2026 17:44:52 +0800
Message-ID: <20260610094639.1965367-9-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260610094639.1965367-1-chen-yu.chen@amd.com>
References: <20260610094639.1965367-1-chen-yu.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FC0:EE_|BY1PR12MB8446:EE_
X-MS-Office365-Filtering-Correlation-Id: 179b86e1-36b8-467c-b6bc-08dec6d58580
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|23010399003|36860700016|6133799003|18002099003|22082099003|3023799007|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: i7ItqPfFaEqTDXtBcmc1vLD+SmWK0iQSTTO7aUaYOS6hJ6Fk17ZhVLexs2c54gOFKLcL+obpmnBLYpZXoW7XZwbivHS1oQg/k5QEvsBwZQTTQ2NBfoMtaq9epcDjIQMj6o7IXn6YS201XBlBqMpZVTjo7EAAIdMRWqYrrti3cG8HHZFT/xxNGVNAW5ynx5db3zlM4s0uhdI3XSrE4krCOr+QnuPqoh6fOoKPMCBgkZvxCtGFnaeRWtIyz0eM8Kp4yd77GMnkIib5Ss3S5g+9WDJkhcqeNma1ttavpWYA0UJv49xGSBdDofdnt46S68C8dgH91dBo8sPWKLlZJlrQG9I0eo0+cleXbiwb5PwXwRQQYSo/ON7iKMbLQ2rsA7YG/hAahlQB7xUi9/eL0DEfC6ikVlwv6MB9jN0Rc6VFLRXDj5hvkszt65O7scUz/5V0SV0WHo1UmORbHHalh5XzvqJEJo2Q/TgeHowi8rDUy7X+Rfh/bz3s5o9ZaRegE7MfEv+/PEqxwvyrenF5OkUf/k3Et7mZf0eK4nQ+gBkGex8vrN11eyzGOkcL8If2/U1iexnYCyAk4FS+PAIXJ7MlBJL0ZsDh3FtxPq8SdSrTyZAL+dOe0lgdWlNBTYJO82g6+cEoRMV/00rYycb1xlI/GDKOBrTLudR7d/VVhimuJ9u05TAXvNz/lazgz/imrgRMB+kzAhsWy4l7YhCEou9fjWBzoQIie4F0FHz/xCnoO/w=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(23010399003)(36860700016)(6133799003)(18002099003)(22082099003)(3023799007)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: vWej861joG+b/XBxkVT+9pujGmJraXsnaeG7+5qk3c9nMYLN6cS0wpKUd1YLVKnf4Xo8YLfz97LZ7t7SqBkJhNAj8OqtqVYSewZZs8j1sX6h9KnObaSn5X1zZi84cT83i6sLonhWpZPgacmFG7DlokIBohAKvLVzbfr6EMvGxWZFbnawnInhmUCC8ALGHDeX8485Od1xZvgC62F9DhRrhQmP6veFvIPcLAIW/PNYNgajVS73shCgwl8DYjGmWjXnYtvEnyRVTlrHAgMu46xYj5oudrPvYw+RI3nSCZNIGufloVA2DjgYfdbOu/Wv5bcv6rQG75K9NKnG20Gp87k1JXceN9vfwI+nk5imo4EakuoYfhh6I4b16wZISd/eq9vJ1pq30mdtMXBH19CyBsZfjXZjhExSzZoBJWMUvldR7Z0QrPE4K0gL2C6CcLrNzc5T
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 09:49:10.2928 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 179b86e1-36b8-467c-b6bc-08dec6d58580
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FC0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR12MB8446
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

From: Alex Hung <alex.hung@amd.com>

Move audio component, init/fini, ELD notification,
fill_audio_info, and commit_audio functions from
amdgpu_dm.c into a dedicated amdgpu_dm_audio.c file
with its own header.

No functional change intended.

Assisted-by: Copilot:Claude-Opus-4.6

Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/Makefile    |   3 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 268 +---------------
 .../amd/display/amdgpu_dm/amdgpu_dm_audio.c   | 302 ++++++++++++++++++
 .../amd/display/amdgpu_dm/amdgpu_dm_audio.h   |  44 +++
 4 files changed, 350 insertions(+), 267 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_audio.c
 create mode 100644 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_audio.h

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/Makefile b/drivers/gpu/drm/amd/display/amdgpu_dm/Makefile
index 2953c59d85e7..83a7d03a0348 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/Makefile
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/Makefile
@@ -42,7 +42,8 @@ AMDGPUDM = \
 	amdgpu_dm_wb.o \
 	amdgpu_dm_colorop.o \
 	amdgpu_dm_ism.o \
-	amdgpu_dm_backlight.o
+	amdgpu_dm_backlight.o \
+	amdgpu_dm_audio.o
 
 ifdef CONFIG_DRM_AMD_DC_FP
 AMDGPUDM += dc_fpu.o
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 100e1fb572b1..a07820ba5759 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -67,6 +67,7 @@
 #include "amdgpu_dm_psr.h"
 #include "amdgpu_dm_replay.h"
 #include "amdgpu_dm_backlight.h"
+#include "amdgpu_dm_audio.h"
 
 #include "ivsrcid/ivsrcid_vislands30.h"
 
@@ -95,7 +96,6 @@
 #include <drm/drm_mode.h>
 #include <drm/drm_utils.h>
 #include <drm/drm_vblank.h>
-#include <drm/drm_audio_component.h>
 #include <drm/drm_colorop.h>
 #include <drm/drm_gem_atomic_helper.h>
 
@@ -1107,144 +1107,6 @@ static void amdgpu_dm_fbc_init(struct drm_connector *connector)
 
 }
 
-static int amdgpu_dm_audio_component_get_eld(struct device *kdev, int port,
-					  int pipe, bool *enabled,
-					  unsigned char *buf, int max_bytes)
-{
-	struct drm_device *dev = dev_get_drvdata(kdev);
-	struct amdgpu_device *adev = drm_to_adev(dev);
-	struct drm_connector *connector;
-	struct drm_connector_list_iter conn_iter;
-	struct amdgpu_dm_connector *aconnector;
-	int ret = 0;
-
-	*enabled = false;
-
-	mutex_lock(&adev->dm.audio_lock);
-
-	drm_connector_list_iter_begin(dev, &conn_iter);
-	drm_for_each_connector_iter(connector, &conn_iter) {
-
-		if (connector->connector_type == DRM_MODE_CONNECTOR_WRITEBACK)
-			continue;
-
-		aconnector = to_amdgpu_dm_connector(connector);
-		if (aconnector->audio_inst != port)
-			continue;
-
-		*enabled = true;
-		mutex_lock(&connector->eld_mutex);
-		ret = drm_eld_size(connector->eld);
-		memcpy(buf, connector->eld, min(max_bytes, ret));
-		mutex_unlock(&connector->eld_mutex);
-
-		break;
-	}
-	drm_connector_list_iter_end(&conn_iter);
-
-	mutex_unlock(&adev->dm.audio_lock);
-
-	drm_dbg_kms(adev_to_drm(adev), "Get ELD : idx=%d ret=%d en=%d\n", port, ret, *enabled);
-
-	return ret;
-}
-
-static const struct drm_audio_component_ops amdgpu_dm_audio_component_ops = {
-	.get_eld = amdgpu_dm_audio_component_get_eld,
-};
-
-static int amdgpu_dm_audio_component_bind(struct device *kdev,
-				       struct device *hda_kdev, void *data)
-{
-	struct drm_device *dev = dev_get_drvdata(kdev);
-	struct amdgpu_device *adev = drm_to_adev(dev);
-	struct drm_audio_component *acomp = data;
-
-	acomp->ops = &amdgpu_dm_audio_component_ops;
-	acomp->dev = kdev;
-	adev->dm.audio_component = acomp;
-
-	return 0;
-}
-
-static void amdgpu_dm_audio_component_unbind(struct device *kdev,
-					  struct device *hda_kdev, void *data)
-{
-	struct amdgpu_device *adev = drm_to_adev(dev_get_drvdata(kdev));
-	struct drm_audio_component *acomp = data;
-
-	acomp->ops = NULL;
-	acomp->dev = NULL;
-	adev->dm.audio_component = NULL;
-}
-
-static const struct component_ops amdgpu_dm_audio_component_bind_ops = {
-	.bind	= amdgpu_dm_audio_component_bind,
-	.unbind	= amdgpu_dm_audio_component_unbind,
-};
-
-static int amdgpu_dm_audio_init(struct amdgpu_device *adev)
-{
-	int i, ret;
-
-	if (!amdgpu_audio)
-		return 0;
-
-	adev->mode_info.audio.enabled = true;
-
-	adev->mode_info.audio.num_pins = adev->dm.dc->res_pool->audio_count;
-
-	for (i = 0; i < adev->mode_info.audio.num_pins; i++) {
-		adev->mode_info.audio.pin[i].channels = -1;
-		adev->mode_info.audio.pin[i].rate = -1;
-		adev->mode_info.audio.pin[i].bits_per_sample = -1;
-		adev->mode_info.audio.pin[i].status_bits = 0;
-		adev->mode_info.audio.pin[i].category_code = 0;
-		adev->mode_info.audio.pin[i].connected = false;
-		adev->mode_info.audio.pin[i].id =
-			adev->dm.dc->res_pool->audios[i]->inst;
-		adev->mode_info.audio.pin[i].offset = 0;
-	}
-
-	ret = component_add(adev->dev, &amdgpu_dm_audio_component_bind_ops);
-	if (ret < 0)
-		return ret;
-
-	adev->dm.audio_registered = true;
-
-	return 0;
-}
-
-static void amdgpu_dm_audio_fini(struct amdgpu_device *adev)
-{
-	if (!amdgpu_audio)
-		return;
-
-	if (!adev->mode_info.audio.enabled)
-		return;
-
-	if (adev->dm.audio_registered) {
-		component_del(adev->dev, &amdgpu_dm_audio_component_bind_ops);
-		adev->dm.audio_registered = false;
-	}
-
-	/* TODO: Disable audio? */
-
-	adev->mode_info.audio.enabled = false;
-}
-
-static  void amdgpu_dm_audio_eld_notify(struct amdgpu_device *adev, int pin)
-{
-	struct drm_audio_component *acomp = adev->dm.audio_component;
-
-	if (acomp && acomp->audio_ops && acomp->audio_ops->pin_eld_notify) {
-		drm_dbg_kms(adev_to_drm(adev), "Notify ELD: %d\n", pin);
-
-		acomp->audio_ops->pin_eld_notify(acomp->audio_ops->audio_ptr,
-						 pin, -1);
-	}
-}
-
 static int dm_dmub_hw_init(struct amdgpu_device *adev)
 {
 	const struct dmcub_firmware_header_v1_0 *hdr;
@@ -6526,51 +6388,6 @@ static void fill_stream_properties_from_drm_display_mode(
 	stream->content_type = get_output_content_type(connector_state);
 }
 
-static void fill_audio_info(struct audio_info *audio_info,
-			    const struct drm_connector *drm_connector,
-			    const struct dc_sink *dc_sink)
-{
-	int i = 0;
-	int cea_revision = 0;
-	const struct dc_edid_caps *edid_caps = &dc_sink->edid_caps;
-
-	audio_info->manufacture_id = edid_caps->manufacturer_id;
-	audio_info->product_id = edid_caps->product_id;
-
-	cea_revision = drm_connector->display_info.cea_rev;
-
-	strscpy(audio_info->display_name,
-		edid_caps->display_name,
-		AUDIO_INFO_DISPLAY_NAME_SIZE_IN_CHARS);
-
-	if (cea_revision >= 3) {
-		audio_info->mode_count = edid_caps->audio_mode_count;
-
-		for (i = 0; i < audio_info->mode_count; ++i) {
-			audio_info->modes[i].format_code =
-					(enum audio_format_code)
-					(edid_caps->audio_modes[i].format_code);
-			audio_info->modes[i].channel_count =
-					edid_caps->audio_modes[i].channel_count;
-			audio_info->modes[i].sample_rates.all =
-					edid_caps->audio_modes[i].sample_rate;
-			audio_info->modes[i].sample_size =
-					edid_caps->audio_modes[i].sample_size;
-		}
-	}
-
-	audio_info->flags.all = edid_caps->speaker_flags;
-
-	/* TODO: We only check for the progressive mode, check for interlace mode too */
-	if (drm_connector->latency_present[0]) {
-		audio_info->video_latency = drm_connector->video_latency[0];
-		audio_info->audio_latency = drm_connector->audio_latency[0];
-	}
-
-	/* TODO: For DP, video and audio latency should be calculated from DPCD caps */
-
-}
-
 static void
 copy_crtc_timing_for_drm_display_mode(const struct drm_display_mode *src_mode,
 				      struct drm_display_mode *dst_mode)
@@ -7172,7 +6989,7 @@ create_stream_for_sink(struct drm_connector *connector,
 
 	update_stream_scaling_settings(dev, &mode, dm_state, stream);
 
-	fill_audio_info(
+	amdgpu_dm_fill_audio_info(
 		&stream->audio_info,
 		connector,
 		sink);
@@ -9980,87 +9797,6 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 	kfree(bundle);
 }
 
-static void amdgpu_dm_commit_audio(struct drm_device *dev,
-				   struct drm_atomic_state *state)
-{
-	struct amdgpu_device *adev = drm_to_adev(dev);
-	struct amdgpu_dm_connector *aconnector;
-	struct drm_connector *connector;
-	struct drm_connector_state *old_con_state, *new_con_state;
-	struct drm_crtc_state *new_crtc_state;
-	struct dm_crtc_state *new_dm_crtc_state;
-	const struct dc_stream_status *status;
-	int i, inst;
-
-	/* Notify device removals. */
-	for_each_oldnew_connector_in_state(state, connector, old_con_state, new_con_state, i) {
-		if (old_con_state->crtc != new_con_state->crtc) {
-			/* CRTC changes require notification. */
-			goto notify;
-		}
-
-		if (!new_con_state->crtc)
-			continue;
-
-		new_crtc_state = drm_atomic_get_new_crtc_state(
-			state, new_con_state->crtc);
-
-		if (!new_crtc_state)
-			continue;
-
-		if (!drm_atomic_crtc_needs_modeset(new_crtc_state))
-			continue;
-
-notify:
-		if (connector->connector_type == DRM_MODE_CONNECTOR_WRITEBACK)
-			continue;
-
-		aconnector = to_amdgpu_dm_connector(connector);
-
-		mutex_lock(&adev->dm.audio_lock);
-		inst = aconnector->audio_inst;
-		aconnector->audio_inst = -1;
-		mutex_unlock(&adev->dm.audio_lock);
-
-		amdgpu_dm_audio_eld_notify(adev, inst);
-	}
-
-	/* Notify audio device additions. */
-	for_each_new_connector_in_state(state, connector, new_con_state, i) {
-		if (!new_con_state->crtc)
-			continue;
-
-		new_crtc_state = drm_atomic_get_new_crtc_state(
-			state, new_con_state->crtc);
-
-		if (!new_crtc_state)
-			continue;
-
-		if (!drm_atomic_crtc_needs_modeset(new_crtc_state))
-			continue;
-
-		new_dm_crtc_state = to_dm_crtc_state(new_crtc_state);
-		if (!new_dm_crtc_state->stream)
-			continue;
-
-		status = dc_stream_get_status(new_dm_crtc_state->stream);
-		if (!status)
-			continue;
-
-		if (connector->connector_type == DRM_MODE_CONNECTOR_WRITEBACK)
-			continue;
-
-		aconnector = to_amdgpu_dm_connector(connector);
-
-		mutex_lock(&adev->dm.audio_lock);
-		inst = status->audio_inst;
-		aconnector->audio_inst = inst;
-		mutex_unlock(&adev->dm.audio_lock);
-
-		amdgpu_dm_audio_eld_notify(adev, inst);
-	}
-}
-
 /*
  * amdgpu_dm_crtc_copy_transient_flags - copy mirrored flags from DRM to DC
  * @crtc_state: the DRM CRTC state
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_audio.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_audio.c
new file mode 100644
index 000000000000..70b7dbded275
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_audio.c
@@ -0,0 +1,302 @@
+// SPDX-License-Identifier: MIT
+/*
+ * Copyright 2026 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ * Authors: AMD
+ */
+
+#include "amdgpu.h"
+#include "amdgpu_dm.h"
+#include "amdgpu_dm_audio.h"
+#include "dc.h"
+
+#include <linux/component.h>
+#include <drm/drm_atomic.h>
+#include <drm/drm_audio_component.h>
+#include <drm/drm_connector.h>
+#include <drm/drm_edid.h>
+#include <drm/drm_eld.h>
+
+#include "dc/inc/core_types.h"
+
+static int amdgpu_dm_audio_component_get_eld(struct device *kdev, int port,
+					  int pipe, bool *enabled,
+					  unsigned char *buf, int max_bytes)
+{
+	struct drm_device *dev = dev_get_drvdata(kdev);
+	struct amdgpu_device *adev = drm_to_adev(dev);
+	struct drm_connector *connector;
+	struct drm_connector_list_iter conn_iter;
+	struct amdgpu_dm_connector *aconnector;
+	int ret = 0;
+
+	*enabled = false;
+
+	mutex_lock(&adev->dm.audio_lock);
+
+	drm_connector_list_iter_begin(dev, &conn_iter);
+	drm_for_each_connector_iter(connector, &conn_iter) {
+
+		if (connector->connector_type == DRM_MODE_CONNECTOR_WRITEBACK)
+			continue;
+
+		aconnector = to_amdgpu_dm_connector(connector);
+		if (aconnector->audio_inst != port)
+			continue;
+
+		*enabled = true;
+		mutex_lock(&connector->eld_mutex);
+		ret = drm_eld_size(connector->eld);
+		memcpy(buf, connector->eld, min(max_bytes, ret));
+		mutex_unlock(&connector->eld_mutex);
+
+		break;
+	}
+	drm_connector_list_iter_end(&conn_iter);
+
+	mutex_unlock(&adev->dm.audio_lock);
+
+	drm_dbg_kms(adev_to_drm(adev), "Get ELD : idx=%d ret=%d en=%d\n", port, ret, *enabled);
+
+	return ret;
+}
+
+static const struct drm_audio_component_ops amdgpu_dm_audio_component_ops = {
+	.get_eld = amdgpu_dm_audio_component_get_eld,
+};
+
+static int amdgpu_dm_audio_component_bind(struct device *kdev,
+				       struct device *hda_kdev, void *data)
+{
+	struct drm_device *dev = dev_get_drvdata(kdev);
+	struct amdgpu_device *adev = drm_to_adev(dev);
+	struct drm_audio_component *acomp = data;
+
+	acomp->ops = &amdgpu_dm_audio_component_ops;
+	acomp->dev = kdev;
+	adev->dm.audio_component = acomp;
+
+	return 0;
+}
+
+static void amdgpu_dm_audio_component_unbind(struct device *kdev,
+					  struct device *hda_kdev, void *data)
+{
+	struct amdgpu_device *adev = drm_to_adev(dev_get_drvdata(kdev));
+	struct drm_audio_component *acomp = data;
+
+	acomp->ops = NULL;
+	acomp->dev = NULL;
+	adev->dm.audio_component = NULL;
+}
+
+static const struct component_ops amdgpu_dm_audio_component_bind_ops = {
+	.bind	= amdgpu_dm_audio_component_bind,
+	.unbind	= amdgpu_dm_audio_component_unbind,
+};
+
+int amdgpu_dm_audio_init(struct amdgpu_device *adev)
+{
+	int i, ret;
+
+	if (!amdgpu_audio)
+		return 0;
+
+	adev->mode_info.audio.enabled = true;
+
+	adev->mode_info.audio.num_pins = adev->dm.dc->res_pool->audio_count;
+
+	for (i = 0; i < adev->mode_info.audio.num_pins; i++) {
+		adev->mode_info.audio.pin[i].channels = -1;
+		adev->mode_info.audio.pin[i].rate = -1;
+		adev->mode_info.audio.pin[i].bits_per_sample = -1;
+		adev->mode_info.audio.pin[i].status_bits = 0;
+		adev->mode_info.audio.pin[i].category_code = 0;
+		adev->mode_info.audio.pin[i].connected = false;
+		adev->mode_info.audio.pin[i].id =
+			adev->dm.dc->res_pool->audios[i]->inst;
+		adev->mode_info.audio.pin[i].offset = 0;
+	}
+
+	ret = component_add(adev->dev, &amdgpu_dm_audio_component_bind_ops);
+	if (ret < 0)
+		return ret;
+
+	adev->dm.audio_registered = true;
+
+	return 0;
+}
+
+void amdgpu_dm_audio_fini(struct amdgpu_device *adev)
+{
+	if (!amdgpu_audio)
+		return;
+
+	if (!adev->mode_info.audio.enabled)
+		return;
+
+	if (adev->dm.audio_registered) {
+		component_del(adev->dev, &amdgpu_dm_audio_component_bind_ops);
+		adev->dm.audio_registered = false;
+	}
+
+	/* TODO: Disable audio? */
+
+	adev->mode_info.audio.enabled = false;
+}
+
+static void amdgpu_dm_audio_eld_notify(struct amdgpu_device *adev, int pin)
+{
+	struct drm_audio_component *acomp = adev->dm.audio_component;
+
+	if (acomp && acomp->audio_ops && acomp->audio_ops->pin_eld_notify) {
+		drm_dbg_kms(adev_to_drm(adev), "Notify ELD: %d\n", pin);
+
+		acomp->audio_ops->pin_eld_notify(acomp->audio_ops->audio_ptr,
+						 pin, -1);
+	}
+}
+
+void amdgpu_dm_fill_audio_info(struct audio_info *audio_info,
+		     const struct drm_connector *drm_connector,
+		     const struct dc_sink *dc_sink)
+{
+	int i = 0;
+	int cea_revision = 0;
+	const struct dc_edid_caps *edid_caps = &dc_sink->edid_caps;
+
+	audio_info->manufacture_id = edid_caps->manufacturer_id;
+	audio_info->product_id = edid_caps->product_id;
+
+	cea_revision = drm_connector->display_info.cea_rev;
+
+	strscpy(audio_info->display_name,
+		edid_caps->display_name,
+		AUDIO_INFO_DISPLAY_NAME_SIZE_IN_CHARS);
+
+	if (cea_revision >= 3) {
+		audio_info->mode_count = edid_caps->audio_mode_count;
+
+		for (i = 0; i < audio_info->mode_count; ++i) {
+			audio_info->modes[i].format_code =
+					(enum audio_format_code)
+					(edid_caps->audio_modes[i].format_code);
+			audio_info->modes[i].channel_count =
+					edid_caps->audio_modes[i].channel_count;
+			audio_info->modes[i].sample_rates.all =
+					edid_caps->audio_modes[i].sample_rate;
+			audio_info->modes[i].sample_size =
+					edid_caps->audio_modes[i].sample_size;
+		}
+	}
+
+	audio_info->flags.all = edid_caps->speaker_flags;
+
+	/* TODO: We only check for the progressive mode, check for interlace mode too */
+	if (drm_connector->latency_present[0]) {
+		audio_info->video_latency = drm_connector->video_latency[0];
+		audio_info->audio_latency = drm_connector->audio_latency[0];
+	}
+
+	/* TODO: For DP, video and audio latency should be calculated from DPCD caps */
+
+}
+
+void amdgpu_dm_commit_audio(struct drm_device *dev,
+			    struct drm_atomic_state *state)
+{
+	struct amdgpu_device *adev = drm_to_adev(dev);
+	struct amdgpu_dm_connector *aconnector;
+	struct drm_connector *connector;
+	struct drm_connector_state *old_con_state, *new_con_state;
+	struct drm_crtc_state *new_crtc_state;
+	struct dm_crtc_state *new_dm_crtc_state;
+	const struct dc_stream_status *status;
+	int i, inst;
+
+	/* Notify device removals. */
+	for_each_oldnew_connector_in_state(state, connector, old_con_state, new_con_state, i) {
+		if (old_con_state->crtc != new_con_state->crtc) {
+			/* CRTC changes require notification. */
+			goto notify;
+		}
+
+		if (!new_con_state->crtc)
+			continue;
+
+		new_crtc_state = drm_atomic_get_new_crtc_state(
+			state, new_con_state->crtc);
+
+		if (!new_crtc_state)
+			continue;
+
+		if (!drm_atomic_crtc_needs_modeset(new_crtc_state))
+			continue;
+
+notify:
+		if (connector->connector_type == DRM_MODE_CONNECTOR_WRITEBACK)
+			continue;
+
+		aconnector = to_amdgpu_dm_connector(connector);
+
+		mutex_lock(&adev->dm.audio_lock);
+		inst = aconnector->audio_inst;
+		aconnector->audio_inst = -1;
+		mutex_unlock(&adev->dm.audio_lock);
+
+		amdgpu_dm_audio_eld_notify(adev, inst);
+	}
+
+	/* Notify audio device additions. */
+	for_each_new_connector_in_state(state, connector, new_con_state, i) {
+		if (!new_con_state->crtc)
+			continue;
+
+		new_crtc_state = drm_atomic_get_new_crtc_state(
+			state, new_con_state->crtc);
+
+		if (!new_crtc_state)
+			continue;
+
+		if (!drm_atomic_crtc_needs_modeset(new_crtc_state))
+			continue;
+
+		new_dm_crtc_state = to_dm_crtc_state(new_crtc_state);
+		if (!new_dm_crtc_state->stream)
+			continue;
+
+		status = dc_stream_get_status(new_dm_crtc_state->stream);
+		if (!status)
+			continue;
+
+		if (connector->connector_type == DRM_MODE_CONNECTOR_WRITEBACK)
+			continue;
+
+		aconnector = to_amdgpu_dm_connector(connector);
+
+		mutex_lock(&adev->dm.audio_lock);
+		inst = status->audio_inst;
+		aconnector->audio_inst = inst;
+		mutex_unlock(&adev->dm.audio_lock);
+
+		amdgpu_dm_audio_eld_notify(adev, inst);
+	}
+}
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_audio.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_audio.h
new file mode 100644
index 000000000000..efd412bba178
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_audio.h
@@ -0,0 +1,44 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Copyright 2026 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ * Authors: AMD
+ */
+
+#ifndef __AMDGPU_DM_AUDIO_H__
+#define __AMDGPU_DM_AUDIO_H__
+
+struct amdgpu_device;
+struct drm_device;
+struct drm_atomic_state;
+struct drm_connector;
+struct audio_info;
+struct dc_sink;
+
+int amdgpu_dm_audio_init(struct amdgpu_device *adev);
+void amdgpu_dm_audio_fini(struct amdgpu_device *adev);
+void amdgpu_dm_commit_audio(struct drm_device *dev,
+			    struct drm_atomic_state *state);
+void amdgpu_dm_fill_audio_info(struct audio_info *audio_info,
+		     const struct drm_connector *drm_connector,
+		     const struct dc_sink *dc_sink);
+
+#endif /* __AMDGPU_DM_AUDIO_H__ */
-- 
2.43.0

