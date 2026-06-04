Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75BFDCD6E7B
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jun 2026 14:55:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E2DC5112847;
	Thu,  4 Jun 2026 14:55:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="E8EsRgWl";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010048.outbound.protection.outlook.com
 [40.93.198.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1821D112843
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Jun 2026 14:55:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RBWDaDJ+x+7qt55DwGDaZPbL9M4eAr2o+9IWWGWYR2YbFXSYBUE8Z+LK2TdJ6koYbIuMEKTIb2GY3ihh9z51Vl4HMfWmFLNT+dmWYstW86ucaGiD1yMTmht/et/VWlXB0U2JfW2BL7KmH9Bs7OjpRTV+MmUs/+OBe8LcybkNiPUSU3Lb2mmlW3R3MaRLhkWN2uZeI1uaBTOx9N9x91F408jO7vyucWlI4iTAS4gbHnOBj/CuThWWbYoGpeZFpPhdD3SuiglQI513jF9Xuys+NUpyPOghEua4R3tPAs5tsAHcDGOJvYc5xXkHscYYchVOqhMda+qBnzQ6KJdnYp2w9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=whSHoQClzl7kPGAZpeGz7/kdRuXoaM3h2Bz8P2ySBjw=;
 b=x9r4dOJZJqkTe1L5zHSFg0R0E2ZusIxzwMCUctgXnN4DdG5tLaH5Rv7VMFq2tIiduW6x822HUEABYQLckMTYtXKhGSeSFfv1dHLfTOwcxlGtZF9AHOLRRWU244XJJ/K2v9iGjfMY7m5ggZyOpnrVDp2bR8SpFzT9fiMYwmw3Ue/foBcVQ2b0N6JzTbHDZv8g4iSwuk44t0/4vMKAsVTLJs/HULVPExnIh6tvQzQISVAXWaqzKu596tHj98IrgFgM2aLsWxCED8sIYqieVSMut7bD7ap3xYuQg+blpXTa9uk5poADWioLQ6CQojK5pk7lIjfcrZ5GhUPyruR1iym0SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=whSHoQClzl7kPGAZpeGz7/kdRuXoaM3h2Bz8P2ySBjw=;
 b=E8EsRgWls/ddbaFBnHR4SmafwqUl/Nw/wRdWX385oKkOTVguiBYXlkv1a+YzTsqfDDGjrXOK3F4xmdvoa7KXCKkqsiGM5DpAhQPugGVujenIPrH0b7VnESUKxRZdMcCPHPbWCzsDCYu7mi5AzE1P2SNP4XO56ew3oyYIHCf9QP8=
Received: from BN9PR03CA0227.namprd03.prod.outlook.com (2603:10b6:408:f8::22)
 by SJ2PR12MB9162.namprd12.prod.outlook.com (2603:10b6:a03:555::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Thu, 4 Jun 2026
 14:55:16 +0000
Received: from BN1PEPF00004689.namprd05.prod.outlook.com
 (2603:10b6:408:f8:cafe::b) by BN9PR03CA0227.outlook.office365.com
 (2603:10b6:408:f8::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.8 via Frontend Transport; Thu, 4
 Jun 2026 14:55:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00004689.mail.protection.outlook.com (10.167.243.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Thu, 4 Jun 2026 14:55:16 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 4 Jun
 2026 09:55:04 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 4 Jun
 2026 09:55:03 -0500
Received: from aaurabin-tumbleweed.king-squeaker.ts.net (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41
 via Frontend Transport; Thu, 4 Jun 2026 09:55:03 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Subject: [PATCH 13/24] drm/amd/display: Extract DPRX CRC transition helpers
 for KUnit testing
Date: Thu, 4 Jun 2026 10:52:07 -0400
Message-ID: <20260604145428.809959-14-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260604145428.809959-1-aurabindo.pillai@amd.com>
References: <20260604145428.809959-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004689:EE_|SJ2PR12MB9162:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c0ae1d9-8b8b-4e4a-0822-08dec2494a3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|376014|6133799003|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: +/9CxOCWUt2EIy5YINmXrpQ9FY5aQSkym4Zsjz4a/FAZGUO+vYaLJYysI0A0/8PjJ75+RrZcmw72L8bTItAxw8kiPacnhhoc45jCZAXpAmN0c8/73n3RAMJwEo7iEH1lDzdw8kWfuILxXIrry4hzsPoY6J1XJNH18A7KIdNZbsRaE3UnyUZhBiOViyXtS4NEU4wJbXoOuRHxqWotr6I0JmKPLeB2e/h+BdKit7LUjyhwQUUe8VOPKQPHvtLlofoIDWM5JFPa4c8BLKqFDO/5TLFDZdzEUIe4k50B8qGdcwALbiU4+GAF+Oqo0VCXubscp4r3iZTiZrn87nZsER8hJvOLjueGc/qCRXsXS8N1lLshNa+xUYv2VrY8zbN+TOEJZ8adOfgAMl1lAunD8YucEYg+0GIqU0CV41UY8bESntkTVMtZzYqUyP6ofz3Jjjze1O5wDBz6JeP6GkeYLys8Pk+xNbZWMySbL0PavTCjrPtiuBtImurgVFHP0HszBXZR0sRDc5F0xs+UOxfmIVpPVZudHf2I5a0Fq5bVl3IAsQtz0C7j8o1YOvqbGnYmTZMXoRx3VmYsbUtGR0ogf1IhA/31pUSolhRJ5X+CbsD42HmZBcBtZaWdJQyaeUbyIhBbcEQBGW220K3qnEu9Xtga9nJfFGEWP7fprYES5FEP5UUvuG4+otmWM0gMNZhRUtcYrfKApawMJdb57qpGARXy7XnDgcm4hkAiTvroG7Rl7Uw=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(6133799003)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ynaaui6kuAMt8qH/uez4o5ex0TG0f/chdfI8KXCf7330rlC3+ZZ5yQEzVwlV+IAbKFC102j0/jI9fJOLW3o411fBIZ91DvySNgsLhgQDAT+UpaUZuk7S7gTiN0vxsFSvzlbNzkK5fa9bSoyu9fltMsk4EJGPurQ0psreqZb7BGFGTtwASkeyz2VT1NPi3UJf7l/CAAG7EgjSLkclx3jVa3OPmUrsZDc76POK4IOMentxDfU2hPcvX3thf3gjaiDaETIQD/X9z6ih9Tvb2i64pLWfG0YKHz88U86xgoXvuxBUq2KDlFbnOQeAEoTriVUehsgV80FhYWs1MM/HC50G5d1AXgeMTp7yAFRpn3oxZEkhZXHL3yYSToxltOvdnNCOjNl1FX4skzv8TiJMsgMKErMu6pPJ7qLRXNZsWjeobVWNaEku36rq5CaG8RGzgZg6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 14:55:16.6581 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c0ae1d9-8b8b-4e4a-0822-08dec2494a3b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004689.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9162
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

Extract three pure predicate functions from amdgpu_dm_crtc_set_crc_source():
- dm_need_dp_aux
- dm_crc_source_should_start_dprx
- dm_crc_source_should_stop_dprx

Refactor set_crc_source() to use these helpers, replacing the nested
if/else if structure with flat, mutually-exclusive branches driven by
the new predicates.

Add KUnit test cases covering all relevant source combinations for each
helper, including the regression case where DPRX→NONE must trigger
drm_dp_stop_crc().

Assisted-by: Copilot:Claude-Sonnet-4.6
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c |  92 ++++++++++---
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_crc.h |   6 +
 .../amdgpu_dm/tests/amdgpu_dm_crc_test.c      | 122 ++++++++++++++++++
 3 files changed, 203 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
index d6d38c97fbad..7b0604e9216a 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
@@ -87,6 +87,65 @@ bool dm_need_crc_dither(enum amdgpu_dm_pipe_crc_source src)
 }
 EXPORT_IF_KUNIT(dm_need_crc_dither);
 
+/**
+ * dm_need_dp_aux() - Does this source transition require the DP AUX handle?
+ * @source: Requested CRC source.
+ * @cur_crc_src: Current CRC source.
+ *
+ * Returns true when either the new source is DPRX-based (starting DPRX CRC),
+ * or the current source is DPRX-based and the new source is NONE (stopping it).
+ *
+ * Return: true if the DP AUX handle is needed, false otherwise.
+ */
+STATIC_IFN_KUNIT
+bool dm_need_dp_aux(enum amdgpu_dm_pipe_crc_source source,
+		    enum amdgpu_dm_pipe_crc_source cur_crc_src)
+{
+	return dm_is_crc_source_dprx(source) ||
+	       (source == AMDGPU_DM_PIPE_CRC_SOURCE_NONE && dm_is_crc_source_dprx(cur_crc_src));
+}
+EXPORT_IF_KUNIT(dm_need_dp_aux);
+
+/**
+ * dm_crc_source_should_start_dprx() - Should drm_dp_start_crc() be called?
+ * @source: Requested CRC source.
+ * @cur_crc_src: Current CRC source.
+ *
+ * True when CRC is transitioning from off to a DPRX source
+ * (!enabled && enable && is_dprx(@source)).
+ *
+ * Return: true if drm_dp_start_crc() should be called, false otherwise.
+ */
+STATIC_IFN_KUNIT
+bool dm_crc_source_should_start_dprx(enum amdgpu_dm_pipe_crc_source source,
+				      enum amdgpu_dm_pipe_crc_source cur_crc_src)
+{
+	return !amdgpu_dm_is_valid_crc_source(cur_crc_src) &&
+	       amdgpu_dm_is_valid_crc_source(source) &&
+	       dm_is_crc_source_dprx(source);
+}
+EXPORT_IF_KUNIT(dm_crc_source_should_start_dprx);
+
+/**
+ * dm_crc_source_should_stop_dprx() - Should drm_dp_stop_crc() be called?
+ * @source: Requested CRC source.
+ * @cur_crc_src: Current CRC source.
+ *
+ * True when CRC is transitioning from a DPRX source to off
+ * (enabled && !enable && is_dprx(@cur_crc_src)).
+ *
+ * Return: true if drm_dp_stop_crc() should be called, false otherwise.
+ */
+STATIC_IFN_KUNIT
+bool dm_crc_source_should_stop_dprx(enum amdgpu_dm_pipe_crc_source source,
+				     enum amdgpu_dm_pipe_crc_source cur_crc_src)
+{
+	return amdgpu_dm_is_valid_crc_source(cur_crc_src) &&
+	       !amdgpu_dm_is_valid_crc_source(source) &&
+	       dm_is_crc_source_dprx(cur_crc_src);
+}
+EXPORT_IF_KUNIT(dm_crc_source_should_stop_dprx);
+
 const char *const *amdgpu_dm_crtc_get_crc_sources(struct drm_crtc *crtc,
 						  size_t *count)
 {
@@ -650,9 +709,7 @@ int amdgpu_dm_crtc_set_crc_source(struct drm_crtc *crtc, const char *src_name)
 	 * CRTC DITHER  | XXXX        | Enable CRTC CRC, set dither
 	 * DPRX DITHER  | XXXX        | Enable DPRX CRC, need 'aux', set dither
 	 */
-	if (dm_is_crc_source_dprx(source) ||
-	    (source == AMDGPU_DM_PIPE_CRC_SOURCE_NONE &&
-	     dm_is_crc_source_dprx(cur_crc_src))) {
+	if (dm_need_dp_aux(source, cur_crc_src)) {
 		struct amdgpu_dm_connector *aconn = NULL;
 		struct drm_connector *connector;
 		struct drm_connector_list_iter conn_iter;
@@ -714,23 +771,24 @@ int amdgpu_dm_crtc_set_crc_source(struct drm_crtc *crtc, const char *src_name)
 		goto cleanup;
 	}
 
-	if (!enabled && enable) {
-		if (dm_is_crc_source_dprx(source)) {
-			if (drm_dp_start_crc(aux, crtc)) {
-				DRM_DEBUG_DRIVER("dp start crc failed\n");
-				ret = -EINVAL;
-				goto cleanup;
-			}
+	if (dm_crc_source_should_start_dprx(source, cur_crc_src)) {
+		/* !enabled && enable && is_dprx(source): CRC off → DPRX on */
+		if (drm_dp_start_crc(aux, crtc)) {
+			DRM_DEBUG_DRIVER("dp start crc failed\n");
+			ret = -EINVAL;
+			goto cleanup;
 		}
-	} else if (enabled && !enable) {
+	} else if (dm_crc_source_should_stop_dprx(source, cur_crc_src)) {
+		/* enabled && !enable && is_dprx(cur_crc_src): DPRX on → CRC off */
 		drm_crtc_vblank_put(crtc);
-		if (dm_is_crc_source_dprx(cur_crc_src)) {
-			if (drm_dp_stop_crc(aux)) {
-				DRM_DEBUG_DRIVER("dp stop crc failed\n");
-				ret = -EINVAL;
-				goto cleanup;
-			}
+		if (drm_dp_stop_crc(aux)) {
+			DRM_DEBUG_DRIVER("dp stop crc failed\n");
+			ret = -EINVAL;
+			goto cleanup;
 		}
+	} else if (enabled && !enable) {
+		/* Non-DPRX source (e.g. CRTC) turning off: release vblank ref */
+		drm_crtc_vblank_put(crtc);
 	}
 
 	spin_lock_irq(&drm_dev->event_lock);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.h
index c9aa0c82038f..8bb8a6f6c148 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.h
@@ -156,6 +156,12 @@ enum amdgpu_dm_pipe_crc_source dm_parse_crc_source(const char *source);
 bool dm_is_crc_source_crtc(enum amdgpu_dm_pipe_crc_source src);
 bool dm_is_crc_source_dprx(enum amdgpu_dm_pipe_crc_source src);
 bool dm_need_crc_dither(enum amdgpu_dm_pipe_crc_source src);
+bool dm_need_dp_aux(enum amdgpu_dm_pipe_crc_source source,
+		    enum amdgpu_dm_pipe_crc_source cur_crc_src);
+bool dm_crc_source_should_start_dprx(enum amdgpu_dm_pipe_crc_source source,
+				      enum amdgpu_dm_pipe_crc_source cur_crc_src);
+bool dm_crc_source_should_stop_dprx(enum amdgpu_dm_pipe_crc_source source,
+				     enum amdgpu_dm_pipe_crc_source cur_crc_src);
 #endif
 
 #endif /* AMD_DAL_DEV_AMDGPU_DM_AMDGPU_DM_CRC_H_ */
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crc_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crc_test.c
index bba8b1a8fa1c..a6fd3a6fd803 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crc_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_crc_test.c
@@ -95,17 +95,139 @@ static void dm_test_is_valid_crc_source(struct kunit *test)
 	KUNIT_EXPECT_FALSE(test, amdgpu_dm_is_valid_crc_source(AMDGPU_DM_PIPE_CRC_SOURCE_INVALID));
 }
 
+/**
+ * dm_test_need_dp_aux() - Test dm_need_dp_aux().
+ * @test: KUnit test context.
+ *
+ * Verifies that dm_need_dp_aux() returns true when the transition starts or
+ * stops a DPRX CRC source (requiring the DP AUX handle), and false for
+ * non-DPRX transitions such as CRTC or NONE→NONE.
+ */
+static void dm_test_need_dp_aux(struct kunit *test)
+{
+	/* Starting a DPRX source always needs AUX, regardless of current source */
+	KUNIT_EXPECT_TRUE(test, dm_need_dp_aux(AMDGPU_DM_PIPE_CRC_SOURCE_DPRX,
+					       AMDGPU_DM_PIPE_CRC_SOURCE_NONE));
+	KUNIT_EXPECT_TRUE(test, dm_need_dp_aux(AMDGPU_DM_PIPE_CRC_SOURCE_DPRX,
+					       AMDGPU_DM_PIPE_CRC_SOURCE_CRTC));
+	KUNIT_EXPECT_TRUE(test, dm_need_dp_aux(AMDGPU_DM_PIPE_CRC_SOURCE_DPRX_DITHER,
+					       AMDGPU_DM_PIPE_CRC_SOURCE_NONE));
+
+	/* Stopping a DPRX source (NONE requested, DPRX was active) needs AUX */
+	KUNIT_EXPECT_TRUE(test, dm_need_dp_aux(AMDGPU_DM_PIPE_CRC_SOURCE_NONE,
+					       AMDGPU_DM_PIPE_CRC_SOURCE_DPRX));
+	KUNIT_EXPECT_TRUE(test, dm_need_dp_aux(AMDGPU_DM_PIPE_CRC_SOURCE_NONE,
+					       AMDGPU_DM_PIPE_CRC_SOURCE_DPRX_DITHER));
+
+	/* CRTC transitions do not need AUX */
+	KUNIT_EXPECT_FALSE(test, dm_need_dp_aux(AMDGPU_DM_PIPE_CRC_SOURCE_CRTC,
+						AMDGPU_DM_PIPE_CRC_SOURCE_NONE));
+	KUNIT_EXPECT_FALSE(test, dm_need_dp_aux(AMDGPU_DM_PIPE_CRC_SOURCE_NONE,
+						AMDGPU_DM_PIPE_CRC_SOURCE_CRTC));
+	KUNIT_EXPECT_FALSE(test, dm_need_dp_aux(AMDGPU_DM_PIPE_CRC_SOURCE_NONE,
+						AMDGPU_DM_PIPE_CRC_SOURCE_NONE));
+}
+
+/**
+ * dm_test_crc_source_should_start_dprx() - Test dm_crc_source_should_start_dprx().
+ * @test: KUnit test context.
+ *
+ * Verifies that dm_crc_source_should_start_dprx() returns true only when CRC
+ * is transitioning from off (!enabled) to a DPRX source (enable &&
+ * is_dprx(source)), and false for all other combinations including
+ * already-enabled or non-DPRX targets.
+ */
+static void dm_test_crc_source_should_start_dprx(struct kunit *test)
+{
+	/* CRC off → DPRX: should start */
+	KUNIT_EXPECT_TRUE(test,
+		dm_crc_source_should_start_dprx(AMDGPU_DM_PIPE_CRC_SOURCE_DPRX,
+						AMDGPU_DM_PIPE_CRC_SOURCE_NONE));
+	KUNIT_EXPECT_TRUE(test,
+		dm_crc_source_should_start_dprx(AMDGPU_DM_PIPE_CRC_SOURCE_DPRX_DITHER,
+						AMDGPU_DM_PIPE_CRC_SOURCE_NONE));
+
+	/* CRC already on (any source) → DPRX: should NOT start (already enabled) */
+	KUNIT_EXPECT_FALSE(test,
+		dm_crc_source_should_start_dprx(AMDGPU_DM_PIPE_CRC_SOURCE_DPRX,
+						AMDGPU_DM_PIPE_CRC_SOURCE_CRTC));
+	KUNIT_EXPECT_FALSE(test,
+		dm_crc_source_should_start_dprx(AMDGPU_DM_PIPE_CRC_SOURCE_DPRX,
+						AMDGPU_DM_PIPE_CRC_SOURCE_DPRX));
+
+	/* CRC off → CRTC: not a DPRX start */
+	KUNIT_EXPECT_FALSE(test,
+		dm_crc_source_should_start_dprx(AMDGPU_DM_PIPE_CRC_SOURCE_CRTC,
+						AMDGPU_DM_PIPE_CRC_SOURCE_NONE));
+
+	/* Disabling: should not start */
+	KUNIT_EXPECT_FALSE(test,
+		dm_crc_source_should_start_dprx(AMDGPU_DM_PIPE_CRC_SOURCE_NONE,
+						AMDGPU_DM_PIPE_CRC_SOURCE_DPRX));
+}
+
+/**
+ * dm_test_crc_source_should_stop_dprx() - Test dm_crc_source_should_stop_dprx().
+ * @test: KUnit test context.
+ *
+ * Verifies that dm_crc_source_should_stop_dprx() returns true only when CRC
+ * is transitioning from a DPRX source (enabled && is_dprx(cur_crc_src)) to
+ * off (!enable), and false for non-DPRX disables, DPRX starts, and no-op
+ * transitions.
+ */
+static void dm_test_crc_source_should_stop_dprx(struct kunit *test)
+{
+	/* DPRX → off: should stop */
+	KUNIT_EXPECT_TRUE(test,
+		dm_crc_source_should_stop_dprx(AMDGPU_DM_PIPE_CRC_SOURCE_NONE,
+					       AMDGPU_DM_PIPE_CRC_SOURCE_DPRX));
+	KUNIT_EXPECT_TRUE(test,
+		dm_crc_source_should_stop_dprx(AMDGPU_DM_PIPE_CRC_SOURCE_NONE,
+					       AMDGPU_DM_PIPE_CRC_SOURCE_DPRX_DITHER));
+
+	/* CRTC → off: not a DPRX stop */
+	KUNIT_EXPECT_FALSE(test,
+		dm_crc_source_should_stop_dprx(AMDGPU_DM_PIPE_CRC_SOURCE_NONE,
+					       AMDGPU_DM_PIPE_CRC_SOURCE_CRTC));
+
+	/* off → DPRX: not a stop */
+	KUNIT_EXPECT_FALSE(test,
+		dm_crc_source_should_stop_dprx(AMDGPU_DM_PIPE_CRC_SOURCE_DPRX,
+					       AMDGPU_DM_PIPE_CRC_SOURCE_NONE));
+
+	/* DPRX → DPRX: no transition, not a stop */
+	KUNIT_EXPECT_FALSE(test,
+		dm_crc_source_should_stop_dprx(AMDGPU_DM_PIPE_CRC_SOURCE_DPRX,
+					       AMDGPU_DM_PIPE_CRC_SOURCE_DPRX));
+
+	/* off → off: not a stop */
+	KUNIT_EXPECT_FALSE(test,
+		dm_crc_source_should_stop_dprx(AMDGPU_DM_PIPE_CRC_SOURCE_NONE,
+					       AMDGPU_DM_PIPE_CRC_SOURCE_NONE));
+}
+
 static struct kunit_case dm_crc_test_cases[] = {
+	/* dm_parse_crc_source() */
 	KUNIT_CASE(dm_test_parse_crc_source_none),
 	KUNIT_CASE(dm_test_parse_crc_source_crtc),
 	KUNIT_CASE(dm_test_parse_crc_source_dprx),
 	KUNIT_CASE(dm_test_parse_crc_source_crtc_dither),
 	KUNIT_CASE(dm_test_parse_crc_source_dprx_dither),
 	KUNIT_CASE(dm_test_parse_crc_source_invalid),
+	/* dm_is_crc_source_crtc() */
 	KUNIT_CASE(dm_test_is_crc_source_crtc),
+	/* dm_is_crc_source_dprx() */
 	KUNIT_CASE(dm_test_is_crc_source_dprx),
+	/* dm_need_crc_dither() */
 	KUNIT_CASE(dm_test_need_crc_dither),
+	/* amdgpu_dm_is_valid_crc_source() */
 	KUNIT_CASE(dm_test_is_valid_crc_source),
+	/* dm_need_dp_aux() */
+	KUNIT_CASE(dm_test_need_dp_aux),
+	/* dm_crc_source_should_start_dprx() */
+	KUNIT_CASE(dm_test_crc_source_should_start_dprx),
+	/* dm_crc_source_should_stop_dprx() */
+	KUNIT_CASE(dm_test_crc_source_should_stop_dprx),
 	{}
 };
 
-- 
2.54.0

