Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFAC6C44506
	for <amd-gfx@archiver.kernel.org>; Thu,  9 Jul 2026 21:02:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3460F10F6EA;
	Thu,  9 Jul 2026 21:02:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XIQ/lnlN";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012070.outbound.protection.outlook.com [52.101.48.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37A6510F6D8
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 Jul 2026 21:02:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EOJpC1Lti62Iwo+WZ/IlWnq7yH7exe48HAunwCgAs2PZKZRV9e9FBEgXA+aqqrfyStqHxk0QwtsBcI/9IEyIqXut+YBPmeBJSWl8I1GJSIEj7CrL5WJXSK15ioL3M7JZIBQxGPjI36EytB9NkTG+SAwfc3MCimtmWYDNJcvI/v/zEGATkWRk8b+lk/XbO0CRwAjM2TeKVBQ25Q2cDrvxFsyqfWnjV9hIj/z6UHHOfciWKyHHZxg80xuhzMzzo6mqx2mbOGsMjXWUIWaHjHaZSxFCIlVirlI2cRx/q2SSl0SYEr+I62ff1tRKpW0u2xJhPbiZs0f5LTud9SkDT6CwMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tWEBnHnLYUf/q+WZiZJSJe5qNUV2EUoXL+A/INNhy0M=;
 b=Bs5dMFEuo3gXc6EoCIYjpwE57vjPt5KDkbxG7IQ89UoterrHNBVtNVkGSAcNRBdY0aJ/ssTz9/d1PsNM2bvTaVNnHd0KMaCnCh4Zb1mqYDiBKyo7SlcWL4TrBnZsBTRQYTpWWjwNTC53SSkBSmygqcjb7/3Nn6cVcWZXFV5xwMhlqDDTof5z7sVWms96t1uzvvgEGOMn1UsYYg65KKMRCOF4McIXaRc40MedbMwaTFPKACHoLrTMKGqRz62MGHsFbWPv1trzQpJFJFbE6mGNhLmb2zBVb/JWja/Lhs0Xkleppb96qe/2PqniFjQ8YjTYIcr7jRGrpw+Sl/2i9FPUDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tWEBnHnLYUf/q+WZiZJSJe5qNUV2EUoXL+A/INNhy0M=;
 b=XIQ/lnlNUeAZV/FSoSebvYy8wqqLcOqjaYAX3bC1nBMWhKWHZGtz3mQERo41ShGoRW27vPn3wjb20WBlptDPp4xHRQn8yCHFK52TKoaE5dyWnk9kD3CIA0Qcm4s1/IhxK0hXhkBJEDN1WP+u4S5X7K7r2PXkIlAjMevlZ2Jmwq4=
Received: from MN2PR01CA0065.prod.exchangelabs.com (2603:10b6:208:23f::34) by
 LV8PR12MB9262.namprd12.prod.outlook.com (2603:10b6:408:1e7::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Thu, 9 Jul 2026
 21:02:35 +0000
Received: from BL02EPF0001A0FE.namprd03.prod.outlook.com
 (2603:10b6:208:23f:cafe::2f) by MN2PR01CA0065.outlook.office365.com
 (2603:10b6:208:23f::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.10 via Frontend Transport; Thu, 9
 Jul 2026 21:02:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A0FE.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 9 Jul 2026 21:02:35 +0000
Received: from georzhanmkm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 9 Jul
 2026 16:02:23 -0500
From: George Zhang <george.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>,
 "George Zhang" <george.zhang@amd.com>
Subject: [PATCH 61/80] drm/amd/display: Test MST coverage gaps
Date: Thu, 9 Jul 2026 16:48:29 -0400
Message-ID: <20260709205936.5719-62-george.zhang@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260709205936.5719-1-george.zhang@amd.com>
References: <20260709205936.5719-1-george.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FE:EE_|LV8PR12MB9262:EE_
X-MS-Office365-Filtering-Correlation-Id: e77511d7-c652-475b-811a-08deddfd66bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|23010399003|36860700016|11063799006|22082099003|6133799003|3023799007|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: 18GCp15UZeZe5Wf9FHK00jqCT0UlsDOJjdKSnmwSLQKK9VUVLj7A3TrT8W+UIql7hkM2xJal2G4f4oGt5ABpvoDSxc2gLscRok8rHS7GLtaycQqlAYDsnOvP3N4lzT9AW3n3Gh9dGfT20Vc9s5nDhs6ohwiPI208fov1CWJoUAoV5SKdd803det2u+d9T1tQYMq6CuQ6iAX6K8ksMAOEz/xOKrivC44/5IniLVtzLbGWfAMPRAItT3LBSWM8Aw7FHh+CxlXjbupESPqFEsYsFfu5RkQo3GF2/wTlxk3E/4pnHlDy+2hLgDkI/zbUs/2PLVnKzpKK2/rgKwr5fHNuhAkGlgboyQUbFEnec3za9Bhv65kw2sVdmr2e2R/UIOujCBhzNMaPflZZIlMw3eJA3O7dh+fDvp0cOVn9ChwaH+0Vs1aatDiPrs28SrSN26MBJKQlxzW5mVwsBOqSnQ4rQjA/gS2Zn7WC6o/riUCYacKUMAzVhLESA1par2n3LRfz17TVzcE7TXH3bJAzyr6olZdZGJyU5zbbdh5cTDLgKJquvTyovIEiva6d53vG/F9PTIE+7+poOpR/lJ6crUQlnn10gTt71IVDLOcWun1kJMnYsGBGYKRim3feCivj/ON7RrwUjjx3N5spNmvtsrC7wR63M9w+IL/FENhsPsQsCu2qYmWmC/Mphcysma7GPetlMOfn3hzfalWDYoZripA93w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(23010399003)(36860700016)(11063799006)(22082099003)(6133799003)(3023799007)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: T1BzLnRUbn8rI6Z9nKimpFjk7YlOQG8Oc0TYLg5abQT4sdeipNziTOzK17/tzEea6d01RrNfJO4j+ZweYJp+q6AgH7+J/n9K3UYm+ovaSUpuw6GdBwwNNK8Cy2ZVIwdRQgaDELTRcd/ZkfZt45o/+hKY5pTPXcTXfH6UHOqf3ob5e+NKYgLvzbiyqqBwWJDwkPNbHUMisCY7pLrXCwGuK+AzF1neabSXfllc2mNOt6Roc4ainA9zARiQptxHaX/K7ecY7UKLCnCL5f7kNnx6fnBsuf/NmQITA/WmOeGQdf4uKi9kKlThLKT9yn579WpsGr0YQgHJ1Bjyf2vNwu8P59gmNL7JQlRW0BF5F7Ek+H3GPfG9Z/KlbmD5F8eJ1+pWyHUzAuGpFa63UTYs47u6aLq8xmKxDTCDe7947ToBaADMKeV25NDSc8KmQIACE/mB
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 21:02:35.2913 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e77511d7-c652-475b-811a-08deddfd66bc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9262
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

[WHAT]
Add KUnit tests for uncovered MST paths:
- dm_mst_get_pbn_divider with non-null link
- retrieve_downstream_port_device AUX read failure
- dm_dp_aux_transfer non-ACK reply handling
- dm_handle_mst_sideband_msg_ready_event ESI read
  failure and ready-bit without MST state
- dm_handle_mst_down_rep_msg_ready wrapper
- amdgpu_dm_initialize_dp_connector eDP early return
- amdgpu_dm_initialize_dp_connector non-eDP MST init
  path (dc_link_dp_get_max_link_enc_cap,
  drm_dp_mst_topology_mgr_init and subconnector
  property attach)

The non-eDP MST test uses standard DRM KUnit helpers to
build a full fixture (drmm_mode_config_init plus
drm_connector_init), which the topology manager and
subconnector property require, and stubs the DC link
service get_max_link_enc_cap callback.

Assisted-by: Copilot:Claude-Opus-4.8
Reviewed-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 .../display/amdgpu_dm/amdgpu_dm_mst_types.c   |   4 +-
 .../display/amdgpu_dm/amdgpu_dm_mst_types.h   |   1 +
 .../tests/amdgpu_dm_mst_types_test.c          | 371 +++++++++++++++++-
 3 files changed, 356 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index 0392c71eab63..a7679675dd32 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -862,10 +862,11 @@ void dm_handle_mst_sideband_msg_ready_event(
 }
 EXPORT_IF_KUNIT(dm_handle_mst_sideband_msg_ready_event);
 
-static void dm_handle_mst_down_rep_msg_ready(struct drm_dp_mst_topology_mgr *mgr)
+STATIC_IFN_KUNIT void dm_handle_mst_down_rep_msg_ready(struct drm_dp_mst_topology_mgr *mgr)
 {
 	dm_handle_mst_sideband_msg_ready_event(mgr, DOWN_REP_MSG_RDY_EVENT);
 }
+EXPORT_IF_KUNIT(dm_handle_mst_down_rep_msg_ready);
 
 static const struct drm_dp_mst_topology_cbs dm_mst_cbs = {
 	.add_connector = dm_dp_add_mst_connector,
@@ -900,6 +901,7 @@ void amdgpu_dm_initialize_dp_connector(struct amdgpu_display_manager *dm,
 
 	drm_connector_attach_dp_subconnector_property(&aconnector->base);
 }
+EXPORT_IF_KUNIT(amdgpu_dm_initialize_dp_connector);
 
 uint32_t dm_mst_get_pbn_divider(struct dc_link *link)
 {
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.h
index f0887812ae60..faca88bdc469 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.h
@@ -111,6 +111,7 @@ void dm_dp_aux_fill_payload_flags(u8 request, struct aux_payload *payload);
 ssize_t dm_dp_aux_transfer(struct drm_dp_aux *aux, struct drm_dp_aux_msg *msg);
 u8 dm_mst_msg_ready_mask(enum mst_msg_ready_type msg_rdy_type);
 void dm_mst_select_esi_dpcd(u8 dpcd_rev, int *dpcd_addr, u8 *dpcd_bytes_to_read);
+void dm_handle_mst_down_rep_msg_ready(struct drm_dp_mst_topology_mgr *mgr);
 struct drm_encoder *dm_mst_atomic_best_encoder(struct drm_connector *connector,
 						 struct drm_atomic_state *state);
 int dm_dp_mst_atomic_check(struct drm_connector *connector,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_mst_types_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_mst_types_test.c
index 3f591e3914d9..f1e1f46b9e2d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_mst_types_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_mst_types_test.c
@@ -8,7 +8,11 @@
 #include <kunit/test.h>
 
 #include <drm/drm_drv.h>
+#include <drm/drm_fixed.h>
 #include <drm/drm_kunit_helpers.h>
+#include <drm/drm_atomic_helper.h>
+#include <drm/drm_connector.h>
+#include <drm/drm_mode_config.h>
 #include <drm/display/drm_dp.h>
 #include <drm/display/drm_dp_helper.h>
 #include <drm/display/drm_dp_mst_helper.h>
@@ -31,7 +35,9 @@ static u8 dm_mst_test_dpcd[0x10];
 static u8 dm_mst_test_desc_dpcd[0x10];
 static struct aux_payload dm_mst_test_last_payload;
 static int dm_mst_test_aux_transfer_raw_result;
+static u8 dm_mst_test_aux_transfer_raw_reply;
 static enum aux_return_code_type dm_mst_test_aux_transfer_raw_operation_result;
+static ssize_t dm_mst_test_aux_transfer_override;
 
 static int dm_mst_test_aux_transfer_raw(struct ddc_service *ddc,
 						struct aux_payload *payload,
@@ -41,6 +47,7 @@ static int dm_mst_test_aux_transfer_raw(struct ddc_service *ddc,
 
 	dm_mst_test_last_payload = *payload;
 	*operation_result = dm_mst_test_aux_transfer_raw_operation_result;
+	payload->reply[0] = dm_mst_test_aux_transfer_raw_reply;
 
 	if (dm_mst_test_aux_transfer_raw_result)
 		return dm_mst_test_aux_transfer_raw_result;
@@ -64,6 +71,7 @@ static void dm_mst_test_setup_dm_aux(struct amdgpu_dm_dp_aux *dm_aux,
 {
 	memset(&dm_mst_test_last_payload, 0, sizeof(dm_mst_test_last_payload));
 	dm_mst_test_aux_transfer_raw_result = 0;
+	dm_mst_test_aux_transfer_raw_reply = 0;
 	dm_mst_test_aux_transfer_raw_operation_result = AUX_RET_SUCCESS;
 	link_srv->aux_transfer_raw = dm_mst_test_aux_transfer_raw;
 	dc->link_srv = link_srv;
@@ -87,6 +95,11 @@ static ssize_t dm_mst_test_aux_transfer(struct drm_dp_aux *aux,
 					struct drm_dp_aux_msg *msg)
 {
 	size_t i;
+	ssize_t ret;
+
+	ret = dm_mst_test_aux_transfer_override;
+	if (ret)
+		return ret;
 
 	switch (msg->request & ~DP_AUX_I2C_MOT) {
 	case DP_AUX_NATIVE_READ:
@@ -103,6 +116,53 @@ static ssize_t dm_mst_test_aux_transfer(struct drm_dp_aux *aux,
 	}
 }
 
+static struct amdgpu_dm_connector *dm_mst_test_alloc_sideband_connector(struct kunit *test)
+{
+	struct amdgpu_dm_connector *aconnector;
+	struct link_service *link_srv;
+	struct dc_link *link;
+	struct dc *dc;
+
+	aconnector = kunit_kzalloc(test, sizeof(*aconnector), GFP_KERNEL);
+	link_srv = kunit_kzalloc(test, sizeof(*link_srv), GFP_KERNEL);
+	link = kunit_kzalloc(test, sizeof(*link), GFP_KERNEL);
+	dc = kunit_kzalloc(test, sizeof(*dc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, aconnector);
+	KUNIT_ASSERT_NOT_NULL(test, link_srv);
+	KUNIT_ASSERT_NOT_NULL(test, link);
+	KUNIT_ASSERT_NOT_NULL(test, dc);
+
+	mutex_init(&aconnector->handle_mst_msg_ready);
+	link_srv->get_status = dm_mst_test_get_status;
+	dc->link_srv = link_srv;
+	link->dc = dc;
+	link->dpcd_caps.dpcd_rev.raw = DPCD_REV_14;
+	link->link_status.dpcd_caps = &link->dpcd_caps;
+	aconnector->dc_link = link;
+	aconnector->dm_dp_aux.aux.name = "dm_mst_test_sideband_aux";
+	aconnector->dm_dp_aux.aux.transfer = dm_mst_test_aux_transfer;
+	drm_dp_aux_init(&aconnector->dm_dp_aux.aux);
+	drm_dp_dpcd_set_probe(&aconnector->dm_dp_aux.aux, false);
+
+	memset(dm_mst_test_dpcd, 0, sizeof(dm_mst_test_dpcd));
+	dm_mst_test_aux_transfer_override = 0;
+
+	return aconnector;
+}
+
+static uint32_t dm_mst_test_dp_link_bandwidth_kbps(
+	const struct dc_link *link,
+	const struct dc_link_settings *link_settings)
+{
+	return 4320000;
+}
+
+static const struct dc_link_settings *dm_mst_test_dp_get_verified_link_cap(
+	const struct dc_link *link)
+{
+	return &link->verified_link_cap;
+}
+
 static ssize_t dm_mst_test_desc_aux_transfer(struct drm_dp_aux *aux,
 					     struct drm_dp_aux_msg *msg)
 {
@@ -254,6 +314,35 @@ static void dm_mst_test_pbn_divider_null_link(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, dm_mst_get_pbn_divider(NULL), 0U);
 }
 
+/**
+ * dm_mst_test_pbn_divider_uses_link_bandwidth - Test pbn_divider with link cap
+ * @test: KUnit test context
+ *
+ * Verify that dm_mst_get_pbn_divider() uses the DC link service to derive the
+ * fixed-point PBN divider when a link is present.
+ */
+static void dm_mst_test_pbn_divider_uses_link_bandwidth(struct kunit *test)
+{
+	struct link_service *link_srv;
+	struct dc_link *link;
+	struct dc *dc;
+
+	link_srv = kunit_kzalloc(test, sizeof(*link_srv), GFP_KERNEL);
+	link = kunit_kzalloc(test, sizeof(*link), GFP_KERNEL);
+	dc = kunit_kzalloc(test, sizeof(*dc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, link_srv);
+	KUNIT_ASSERT_NOT_NULL(test, link);
+	KUNIT_ASSERT_NOT_NULL(test, dc);
+
+	link_srv->dp_get_verified_link_cap = dm_mst_test_dp_get_verified_link_cap;
+	link_srv->dp_link_bandwidth_kbps = dm_mst_test_dp_link_bandwidth_kbps;
+	dc->link_srv = link_srv;
+	link->dc = dc;
+
+	KUNIT_EXPECT_EQ(test, dm_mst_get_pbn_divider(link),
+			 (uint32_t)(dfixed_const(1000) / 100));
+}
+
 /* Tests for amdgpu_dm_mst_reset_mst_connector_setting */
 
 /**
@@ -331,6 +420,7 @@ static void dm_mst_test_retrieve_downstream_present(struct kunit *test)
 	memset(dm_mst_test_dpcd, 0, sizeof(dm_mst_test_dpcd));
 	/* PORT_PRESENT = 1, PORT_TYPE = 2 (0b101) */
 	dm_mst_test_dpcd[DP_DOWNSTREAMPORT_PRESENT] = 0x05;
+	dm_mst_test_aux_transfer_override = 0;
 
 	aux->name = "dm_mst_test_aux";
 	aux->transfer = dm_mst_test_aux_transfer;
@@ -345,6 +435,35 @@ static void dm_mst_test_retrieve_downstream_present(struct kunit *test)
 			(int)aconnector->mst_downstream_port_present.fields.PORT_TYPE, 2);
 }
 
+/**
+ * dm_mst_test_retrieve_downstream_aux_error - Test downstream read failure
+ * @test: KUnit test context
+ *
+ * Verify that retrieve_downstream_port_device() returns false when the AUX
+ * DPCD read fails.
+ */
+static void dm_mst_test_retrieve_downstream_aux_error(struct kunit *test)
+{
+	struct amdgpu_dm_connector *aconnector;
+	struct drm_dp_aux *aux;
+
+	aconnector = kunit_kzalloc(test, sizeof(*aconnector), GFP_KERNEL);
+	aux = kunit_kzalloc(test, sizeof(*aux), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, aconnector);
+	KUNIT_ASSERT_NOT_NULL(test, aux);
+
+	dm_mst_test_aux_transfer_override = -EIO;
+	aux->name = "dm_mst_test_aux";
+	aux->transfer = dm_mst_test_aux_transfer;
+	drm_dp_aux_init(aux);
+	drm_dp_dpcd_set_probe(aux, false);
+	aconnector->dsc_aux = aux;
+
+	KUNIT_EXPECT_FALSE(test, retrieve_downstream_port_device(aconnector));
+
+	dm_mst_test_aux_transfer_override = 0;
+}
+
 /* Tests for retrieve_branch_specific_data */
 
 /**
@@ -710,6 +829,55 @@ static void dm_mst_test_aux_transfer_hpd_discon_quirk(struct kunit *test)
 			DP_SIDEBAND_MSG_DOWN_REQ_BASE);
 }
 
+/**
+ * dm_mst_test_aux_transfer_non_ack_reply - non-ACK AUX reply is logged.
+ * @test: KUnit test context.
+ *
+ * A successful read with a nonzero reply byte should still return the backend
+ * byte count while exercising the non-ACK reply handling path.
+ */
+static void dm_mst_test_aux_transfer_non_ack_reply(struct kunit *test)
+{
+	struct amdgpu_dm_dp_aux *dm_aux;
+	struct amdgpu_device *adev;
+	struct ddc_service *ddc;
+	struct dc_link *link;
+	struct dc *dc;
+	struct link_service *link_srv;
+	struct dc_context *ctx;
+	u8 buffer[2] = { 0 };
+	struct drm_dp_aux_msg msg = {
+		.address = 4,
+		.request = DP_AUX_NATIVE_READ,
+		.buffer = buffer,
+		.size = sizeof(buffer),
+	};
+	ssize_t ret;
+
+	dm_aux = kunit_kzalloc(test, sizeof(*dm_aux), GFP_KERNEL);
+	adev = kunit_kzalloc(test, sizeof(*adev), GFP_KERNEL);
+	ddc = kunit_kzalloc(test, sizeof(*ddc), GFP_KERNEL);
+	link = kunit_kzalloc(test, sizeof(*link), GFP_KERNEL);
+	dc = kunit_kzalloc(test, sizeof(*dc), GFP_KERNEL);
+	link_srv = kunit_kzalloc(test, sizeof(*link_srv), GFP_KERNEL);
+	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, dm_aux);
+	KUNIT_ASSERT_NOT_NULL(test, adev);
+	KUNIT_ASSERT_NOT_NULL(test, ddc);
+	KUNIT_ASSERT_NOT_NULL(test, link);
+	KUNIT_ASSERT_NOT_NULL(test, dc);
+	KUNIT_ASSERT_NOT_NULL(test, link_srv);
+	KUNIT_ASSERT_NOT_NULL(test, ctx);
+
+	dm_mst_test_setup_dm_aux(dm_aux, ddc, link, dc, link_srv, ctx, adev);
+	dm_mst_test_aux_transfer_raw_reply = DP_AUX_NATIVE_REPLY_NACK;
+
+	ret = dm_dp_aux_transfer(&dm_aux->aux, &msg);
+
+	KUNIT_EXPECT_EQ(test, ret, (ssize_t)sizeof(buffer));
+	KUNIT_EXPECT_EQ(test, dm_mst_test_last_payload.address, 4U);
+}
+
 /**
  * dm_mst_test_fill_payload_flags_native_write - native write request decode.
  * @test: KUnit test context.
@@ -843,36 +1011,192 @@ static void dm_mst_test_select_esi_dpcd_esi(struct kunit *test)
 static void dm_mst_test_sideband_msg_ready_no_ready_bits(struct kunit *test)
 {
 	struct amdgpu_dm_connector *aconnector;
+
+	aconnector = dm_mst_test_alloc_sideband_connector(test);
+
+	dm_handle_mst_sideband_msg_ready_event(&aconnector->mst_mgr,
+					       DOWN_REP_MSG_RDY_EVENT);
+
+	KUNIT_EXPECT_EQ(test, dm_mst_test_dpcd[1], (u8)0);
+}
+
+/**
+ * dm_mst_test_sideband_msg_ready_read_error - Test ESI read failure path
+ * @test: KUnit test context
+ *
+ * Verify that dm_handle_mst_sideband_msg_ready_event() returns cleanly when
+ * the DPCD read fails before a ready bit can be handled.
+ */
+static void dm_mst_test_sideband_msg_ready_read_error(struct kunit *test)
+{
+	struct amdgpu_dm_connector *aconnector;
+
+	aconnector = dm_mst_test_alloc_sideband_connector(test);
+	dm_mst_test_aux_transfer_override = -EIO;
+
+	dm_handle_mst_sideband_msg_ready_event(&aconnector->mst_mgr,
+					       DOWN_REP_MSG_RDY_EVENT);
+
+	KUNIT_EXPECT_EQ(test, dm_mst_test_dpcd[1], (u8)0);
+	dm_mst_test_aux_transfer_override = 0;
+}
+
+/**
+ * dm_mst_test_sideband_msg_ready_without_mst_state - Test ready bit no-op path
+ * @test: KUnit test context
+ *
+ * Verify that a DOWN_REP ready bit is filtered and then ignored when the MST
+ * topology manager is not enabled.
+ */
+static void dm_mst_test_sideband_msg_ready_without_mst_state(struct kunit *test)
+{
+	struct amdgpu_dm_connector *aconnector;
+
+	aconnector = dm_mst_test_alloc_sideband_connector(test);
+	dm_mst_test_dpcd[(DP_SINK_COUNT_ESI + 1) & 0xf] = DP_DOWN_REP_MSG_RDY;
+
+	dm_handle_mst_sideband_msg_ready_event(&aconnector->mst_mgr,
+					       DOWN_REP_MSG_RDY_EVENT);
+
+	KUNIT_EXPECT_EQ(test, dm_mst_test_dpcd[(DP_SINK_COUNT_ESI + 1) & 0xf],
+			 DP_DOWN_REP_MSG_RDY);
+}
+
+/**
+ * dm_mst_test_down_rep_msg_ready_wrapper - Test DOWN_REP wrapper
+ * @test: KUnit test context
+ *
+ * Verify that dm_handle_mst_down_rep_msg_ready() forwards to the generic MST
+ * sideband handler with the DOWN_REP event selection.
+ */
+static void dm_mst_test_down_rep_msg_ready_wrapper(struct kunit *test)
+{
+	struct amdgpu_dm_connector *aconnector;
+
+	aconnector = dm_mst_test_alloc_sideband_connector(test);
+
+	dm_handle_mst_down_rep_msg_ready(&aconnector->mst_mgr);
+
+	KUNIT_EXPECT_EQ(test, dm_mst_test_dpcd[1], (u8)0);
+}
+
+/**
+ * dm_mst_test_initialize_dp_connector_edp - Test eDP initialization path
+ * @test: KUnit test context
+ *
+ * Verify that amdgpu_dm_initialize_dp_connector() initializes the DP AUX state
+ * and exits before MST topology setup for eDP connectors.
+ */
+static void dm_mst_test_initialize_dp_connector_edp(struct kunit *test)
+{
+	struct amdgpu_dm_connector *aconnector;
+	struct amdgpu_device *adev;
+	struct ddc_service *ddc;
+	struct dc_link *link;
+
+	adev = dm_kunit_alloc_adev(test);
+	link = dm_kunit_alloc_link(test);
+	ddc = kunit_kzalloc(test, sizeof(*ddc), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ddc);
+
+	adev->dm.adev = adev;
+	adev->dm.ddev = &adev->ddev;
+	link->ddc = ddc;
+	aconnector = dm_kunit_alloc_connector(test, adev, link);
+	aconnector->base.connector_type = DRM_MODE_CONNECTOR_eDP;
+
+	amdgpu_dm_initialize_dp_connector(&adev->dm, aconnector, 5);
+
+	KUNIT_EXPECT_TRUE(test, aconnector->dm_dp_aux.aux.transfer == dm_dp_aux_transfer);
+	KUNIT_EXPECT_PTR_EQ(test, aconnector->dm_dp_aux.aux.drm_dev, &adev->ddev);
+	KUNIT_EXPECT_PTR_EQ(test, aconnector->dm_dp_aux.ddc_service, ddc);
+	KUNIT_EXPECT_PTR_EQ(test, aconnector->mst_mgr.dev, NULL);
+	KUNIT_EXPECT_NOT_NULL(test, aconnector->dm_dp_aux.aux.name);
+	if (aconnector->dm_dp_aux.aux.name)
+		KUNIT_EXPECT_NOT_NULL(test, strstr(aconnector->dm_dp_aux.aux.name, "5"));
+
+	drm_dp_cec_unregister_connector(&aconnector->dm_dp_aux.aux);
+	kfree(aconnector->dm_dp_aux.aux.name);
+}
+
+static bool dm_mst_test_dp_get_max_link_enc_cap(const struct dc_link *link,
+						struct dc_link_settings *cap)
+{
+	return true;
+}
+
+static void dm_mst_test_connector_destroy(struct drm_connector *connector)
+{
+}
+
+static const struct drm_connector_funcs dm_mst_test_connector_funcs = {
+	.reset = drm_atomic_helper_connector_reset,
+	.destroy = dm_mst_test_connector_destroy,
+	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
+	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
+};
+
+/**
+ * dm_mst_test_initialize_dp_connector_mst - Test MST root initialization path
+ * @test: KUnit test context
+ *
+ * Verify that amdgpu_dm_initialize_dp_connector() initializes the MST topology
+ * manager for a non-eDP DisplayPort connector. This exercises the path past the
+ * eDP early return, including dc_link_dp_get_max_link_enc_cap() and
+ * drm_dp_mst_topology_mgr_init(). A fully initialized DRM mode config and
+ * connector are required because the topology manager registers a private
+ * atomic object and the subconnector property is attached to the connector.
+ */
+static void dm_mst_test_initialize_dp_connector_mst(struct kunit *test)
+{
+	struct amdgpu_dm_connector *aconnector;
+	struct amdgpu_device *adev;
 	struct link_service *link_srv;
+	struct ddc_service *ddc;
 	struct dc_link *link;
 	struct dc *dc;
+	int ret;
 
-	aconnector = kunit_kzalloc(test, sizeof(*aconnector), GFP_KERNEL);
-	link_srv = kunit_kzalloc(test, sizeof(*link_srv), GFP_KERNEL);
-	link = kunit_kzalloc(test, sizeof(*link), GFP_KERNEL);
+	adev = dm_kunit_alloc_adev(test);
+
+	ret = drmm_mode_config_init(&adev->ddev);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	ddc = kunit_kzalloc(test, sizeof(*ddc), GFP_KERNEL);
+	link = dm_kunit_alloc_link(test);
 	dc = kunit_kzalloc(test, sizeof(*dc), GFP_KERNEL);
-	KUNIT_ASSERT_NOT_NULL(test, aconnector);
-	KUNIT_ASSERT_NOT_NULL(test, link_srv);
-	KUNIT_ASSERT_NOT_NULL(test, link);
+	link_srv = kunit_kzalloc(test, sizeof(*link_srv), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, ddc);
 	KUNIT_ASSERT_NOT_NULL(test, dc);
+	KUNIT_ASSERT_NOT_NULL(test, link_srv);
 
-	mutex_init(&aconnector->handle_mst_msg_ready);
-	link_srv->get_status = dm_mst_test_get_status;
+	link_srv->dp_get_max_link_enc_cap = dm_mst_test_dp_get_max_link_enc_cap;
 	dc->link_srv = link_srv;
 	link->dc = dc;
-	link->dpcd_caps.dpcd_rev.raw = DPCD_REV_14;
-	link->link_status.dpcd_caps = &link->dpcd_caps;
-	aconnector->dc_link = link;
-	aconnector->dm_dp_aux.aux.name = "dm_mst_test_sideband_aux";
-	aconnector->dm_dp_aux.aux.transfer = dm_mst_test_aux_transfer;
-	drm_dp_aux_init(&aconnector->dm_dp_aux.aux);
-	drm_dp_dpcd_set_probe(&aconnector->dm_dp_aux.aux, false);
-	memset(dm_mst_test_dpcd, 0, sizeof(dm_mst_test_dpcd));
+	link->ddc = ddc;
 
-	dm_handle_mst_sideband_msg_ready_event(&aconnector->mst_mgr,
-					       DOWN_REP_MSG_RDY_EVENT);
+	adev->dm.adev = adev;
+	adev->dm.ddev = &adev->ddev;
 
-	KUNIT_EXPECT_EQ(test, dm_mst_test_dpcd[1], (u8)0);
+	aconnector = dm_kunit_alloc_connector(test, adev, link);
+
+	ret = drm_connector_init(&adev->ddev, &aconnector->base,
+				 &dm_mst_test_connector_funcs,
+				 DRM_MODE_CONNECTOR_DisplayPort);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	amdgpu_dm_initialize_dp_connector(&adev->dm, aconnector, 7);
+
+	KUNIT_EXPECT_TRUE(test, aconnector->dm_dp_aux.aux.transfer == dm_dp_aux_transfer);
+	KUNIT_EXPECT_PTR_EQ(test, aconnector->mst_mgr.dev, &adev->ddev);
+	KUNIT_EXPECT_PTR_EQ(test, aconnector->mst_mgr.aux, &aconnector->dm_dp_aux.aux);
+	KUNIT_EXPECT_EQ(test, aconnector->mst_mgr.max_payloads, 4);
+	KUNIT_EXPECT_TRUE(test, aconnector->mst_mgr.cbs != NULL);
+
+	drm_dp_mst_topology_mgr_destroy(&aconnector->mst_mgr);
+	drm_dp_cec_unregister_connector(&aconnector->dm_dp_aux.aux);
+	kfree(aconnector->dm_dp_aux.aux.name);
+	drm_connector_cleanup(&aconnector->base);
 }
 
 /**
@@ -1038,11 +1362,13 @@ static struct kunit_case dm_mst_types_test_cases[] = {
 	KUNIT_CASE(dm_mst_test_needs_dsc_aux_workaround_zero_sink_count),
 	/* dm_mst_get_pbn_divider tests */
 	KUNIT_CASE(dm_mst_test_pbn_divider_null_link),
+	KUNIT_CASE(dm_mst_test_pbn_divider_uses_link_bandwidth),
 	/* amdgpu_dm_mst_reset_mst_connector_setting tests */
 	KUNIT_CASE(dm_mst_test_reset_connector_setting),
 	/* retrieve_downstream_port_device tests */
 	KUNIT_CASE(dm_mst_test_retrieve_downstream_no_aux),
 	KUNIT_CASE(dm_mst_test_retrieve_downstream_present),
+	KUNIT_CASE(dm_mst_test_retrieve_downstream_aux_error),
 	/* retrieve_branch_specific_data tests */
 	KUNIT_CASE(dm_mst_test_retrieve_branch_no_parent),
 	KUNIT_CASE(dm_mst_test_retrieve_branch_reads_oui),
@@ -1056,6 +1382,7 @@ static struct kunit_case dm_mst_types_test_cases[] = {
 	KUNIT_CASE(dm_mst_test_aux_transfer_partial_write),
 	KUNIT_CASE(dm_mst_test_aux_transfer_error_result),
 	KUNIT_CASE(dm_mst_test_aux_transfer_hpd_discon_quirk),
+	KUNIT_CASE(dm_mst_test_aux_transfer_non_ack_reply),
 	/* dm_dp_aux_fill_payload_flags tests */
 	KUNIT_CASE(dm_mst_test_fill_payload_flags_native_write),
 	KUNIT_CASE(dm_mst_test_fill_payload_flags_native_read),
@@ -1068,6 +1395,12 @@ static struct kunit_case dm_mst_types_test_cases[] = {
 	KUNIT_CASE(dm_mst_test_select_esi_dpcd_esi),
 	/* dm_handle_mst_sideband_msg_ready_event tests */
 	KUNIT_CASE(dm_mst_test_sideband_msg_ready_no_ready_bits),
+	KUNIT_CASE(dm_mst_test_sideband_msg_ready_read_error),
+	KUNIT_CASE(dm_mst_test_sideband_msg_ready_without_mst_state),
+	KUNIT_CASE(dm_mst_test_down_rep_msg_ready_wrapper),
+	/* amdgpu_dm_initialize_dp_connector tests */
+	KUNIT_CASE(dm_mst_test_initialize_dp_connector_edp),
+	KUNIT_CASE(dm_mst_test_initialize_dp_connector_mst),
 	/* dm_mst_atomic_best_encoder tests */
 	KUNIT_CASE(dm_mst_test_atomic_best_encoder),
 	/* dm_dp_create_fake_mst_encoders tests */
-- 
2.55.0

