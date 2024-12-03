Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27D15E74ADD
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Dec 2024 21:41:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C755610EB4F;
	Tue,  3 Dec 2024 21:41:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OkIoEyqy";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2087.outbound.protection.outlook.com [40.107.243.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 187AF10EB4F
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Dec 2024 21:41:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vPKgQHGS6LtYT1Z09utb5HftIrXwPxoj7DW1AXMHT4kVlyEKYWpMD+6k8rbrCnnZBbGeBYxiSAIjW4dimt/m58UPegAqYRctQqwO6IQwVcJErndFv9+r0gfKqa9t37PejxvLqXnhJ6cV4FqKSiEnFUiCexfrRff1ZAx9Fsi68CGYq3vtgBd/UPkyfsL0vd8WIYUH1o3OHupDB5yH1V1rvGEyzYngBgyjk45z6p722QLP6DoMzF9oP6UeddMsOzlsIT0hB6K63Ndzzn7ObVC5NKaeOekTPh689Sf+Nd0zC8FUQOX4vSCk0m5au/aAdSNNLU9u4j+n09azjbtl3F53gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YlnN5Gl/sBkffjN04Y7jPytvesaNSNLQpxeMoXpawrc=;
 b=Re7J9nCWKI02CZsPv044ks8u8HnGpYzbA7OcqB/9u+7DX8oIJEjK2vVbhr5/24hdnDAAyG6VclHM4K22iMZaZtJplG1uG47zGuDTMwj8prkWdLvpyztwkHDYB/t+b3qN3wO4skWb7hxM4ugw1YiFRRQjyiKevD4Zskb31hb6iJXNvzX67lYSZ88Ry3w0eJeYjPwbM/ke0OgdB5SgJhjVDMQeJgChH5QxH+dPvpX5F5OuMs3PYD8YfSVDK/h15NCns9dy9VE2HZhgjaFeRrc8XmES8xzfXuF6QMR1V/dRDPMjosJ73zQKgMl4Xr4VbHj4/iK64YmuEUwJbb6rqBR7yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YlnN5Gl/sBkffjN04Y7jPytvesaNSNLQpxeMoXpawrc=;
 b=OkIoEyqyQxZKElxsYgRwYwtgcVNbbZio5OFZWb9dpIvwYd1UntvjOqLGWik8Uopue7fOu73XGOEzrlwqrLUQSJeHJ2+l8njlX90YEtI2vdz6MwOP0gammpvBT8OIDsb//tW9MSPfVDtH1qRrAbROWN7kXV4VU1RDlP8SardBexI=
Received: from BN9PR03CA0343.namprd03.prod.outlook.com (2603:10b6:408:f6::18)
 by SJ2PR12MB8160.namprd12.prod.outlook.com (2603:10b6:a03:4af::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Tue, 3 Dec
 2024 21:41:36 +0000
Received: from BN3PEPF0000B075.namprd04.prod.outlook.com
 (2603:10b6:408:f6:cafe::65) by BN9PR03CA0343.outlook.office365.com
 (2603:10b6:408:f6::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.17 via Frontend Transport; Tue,
 3 Dec 2024 21:41:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B075.mail.protection.outlook.com (10.167.243.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Tue, 3 Dec 2024 21:41:35 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 3 Dec
 2024 15:41:34 -0600
Received: from aaurabin-suse.king-squeaker.ts.net (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Tue, 3 Dec 2024 15:41:29 -0600
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>, Wayne Lin
 <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Fangzhi Zuo
 <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Wayne Lin
 <Wayne.Lin@amd.com>, HaoPing Liu <haoping.liu@amd.com>
Subject: [PATCH 05/19] drm/amd/display: Fix phy id mapping issue for secure
 display
Date: Tue, 3 Dec 2024 16:39:43 -0500
Message-ID: <20241203214120.1161810-6-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241203214120.1161810-1-aurabindo.pillai@amd.com>
References: <20241203214120.1161810-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: aurabindo.pillai@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B075:EE_|SJ2PR12MB8160:EE_
X-MS-Office365-Filtering-Correlation-Id: 39e567f7-a919-4a21-aa4b-08dd13e342b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qzedQTdR6rEO/bCPG8pwQYw3WyOOimI1wrj7S7s68VwJyXmrG+3EaEUS25Sw?=
 =?us-ascii?Q?CxEJi4dfKwrTUFBTyuDQwUoOe+w1EZOR/zv7DwgGorw2jnMfnuSI5BFurMmn?=
 =?us-ascii?Q?qv+ASz7f6It4SsNtVr6YmR2/3X547XIAGzzPM8rl6GIrf2ANntZHehxZi4J0?=
 =?us-ascii?Q?cCqR0OsZgfqmT1TF0Jlv4HDnelz2+24z4onitj5ZFCdGyendn0hTfxHRQjQH?=
 =?us-ascii?Q?Y8s18AfVJFeYDRrSIg6Re1CKTosvT2eibZTOrmCbvmAiB26gw4R0I3mT9bah?=
 =?us-ascii?Q?MP18twntEEQ+T5zj/W00puFB0CS8N9stLkvH2yUTDwZp6X3YuB0tYQ7BoASA?=
 =?us-ascii?Q?VmY5pwuaMvQg1L8MciPKr7RSVdP8PBHJF1gUTzMuqsriaeXXdbLWgBOhEkX+?=
 =?us-ascii?Q?sGiT68s/c6kPH7pmJAPbOhi3Vm6lQyowXm+QlZUJ+kKw9Rl0+CT9ePK4dukt?=
 =?us-ascii?Q?8jYeqgWeKQAb5pdCQCsqT5dWWdSbVPevs2XlbVEOMWi3DF+8uP2ifpEPm53K?=
 =?us-ascii?Q?lmVJrCcckogZjKBXYjMMlAeVCJSykd5FMWwhLE6BMKNjph+8n+T+1YBKdVOd?=
 =?us-ascii?Q?FNaNGteVDgJ46RYmFJImqQ8govjRqWj4OCeSUOJ8W2iJFGeJaJfdKmqKokTp?=
 =?us-ascii?Q?/4/2Cp22xzr+gwyANoYcGuhhJoLVxizCfViVg9X4V3SaRAClTWmoPcM5x9fS?=
 =?us-ascii?Q?x3o8ZV72a8wpxTZazvoZEDU67jXk5DKh/xoo6UY9xh06SB+r8HQnCkOJcf2N?=
 =?us-ascii?Q?LnR+HiPrA78AMQwGt1qqQqs18WvBqPeOLwziSCtyE3kHnMpEKwsrTB7yxXIJ?=
 =?us-ascii?Q?hWXr0HJoawmxJMVNFnDQ+sZcmPmU68gCjnQQBUyVbW4c8aFVft8f1ciBTKJR?=
 =?us-ascii?Q?xcN9twRIympYlP15wJZxbCFNKgKqvZlvEbPyCi3RPaQ1aVsyVb08dEwxn6k1?=
 =?us-ascii?Q?94aUg+zQE10lFu6tTN1JDr1/fsYqBa7KIgE6xne07sb0dhwtXEmGpxhPdI1G?=
 =?us-ascii?Q?OdKnD7bJIsdxlRMVnGd1Wy9MzXdT4aLUavQxArr7dnoU2+E61CyqarFBhEZz?=
 =?us-ascii?Q?2l8SRN3V81dgYwKVR8jvmgVs+MEu0choGOFLCRy8td/Bx9+Qjxg+ypoIuOv8?=
 =?us-ascii?Q?N4S2GRHvJ92FTfJ2XwbYKx1YbzlSjOxHVs3P8t8WkP0Ip4xbeB5lZMOIMcrb?=
 =?us-ascii?Q?O2Z4CgOq4F3TDwA/4RhYRz/2mKQx7xbt5velZcMn9GigRN1QwAsQfTDdfa1V?=
 =?us-ascii?Q?oThvEaYaV4TxHCndGpxmp14uV6Uo+TihDg+oOJxzngunFEFMGdNillq7YpHl?=
 =?us-ascii?Q?rTUQMxQPdGqhZqgP1kFDhmVqZs4fCM2GxcAzJI82/jbRFogM5Jcn0gj9DT6a?=
 =?us-ascii?Q?UbFOBYGgEovbAVpvnHU5VwqZbC0U+ooE5RT2gNnM4gBo7/AqOHNVfC5f3nsi?=
 =?us-ascii?Q?sPbjh4NmdDM6eakZJY4GCvSylF+46+5T?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 21:41:35.3271 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39e567f7-a919-4a21-aa4b-08dd13e342b3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B075.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8160
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

From: Wayne Lin <Wayne.Lin@amd.com>

[Why]
Under mst scenario, mst streams are from the same link_enc_hw_inst.
As the result, can't utilize that as the phy index for distinguising
different stream sinks.

[How]
Sort the connectors by:
link_enc_hw_instance->mst tree depth->mst RAD

After sorting the phy index assignment, store connector's relevant info
into dm mapping array. Once need the index, just look up the static
array.

Reviewed-by: HaoPing Liu <haoping.liu@amd.com>
Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   4 +
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c | 264 +++++++++++++++++-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_crc.h |   9 +
 3 files changed, 273 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index 6464a8378387..cbd7a1cb34af 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -547,6 +547,10 @@ struct amdgpu_display_manager {
 	 * all crtcs.
 	 */
 	struct secure_display_context *secure_display_ctxs;
+
+	bool secure_display_phy_mapping_updated;
+	int phy_id_mapping_cnt;
+	struct phy_id_mapping phy_id_mapping[AMDGPU_DM_MAX_CRTC];
 #endif
 	/**
 	 * @hpd_rx_offload_wq:
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
index 2679ce9a0980..066054caa4c7 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
@@ -83,13 +83,226 @@ const char *const *amdgpu_dm_crtc_get_crc_sources(struct drm_crtc *crtc,
 }
 
 #ifdef CONFIG_DRM_AMD_SECURE_DISPLAY
+static void update_phy_id_mapping(struct amdgpu_device *adev)
+{
+	struct drm_device *ddev = adev_to_drm(adev);
+	struct amdgpu_display_manager *dm = &adev->dm;
+	struct drm_connector *connector;
+	struct amdgpu_dm_connector *aconnector;
+	struct amdgpu_dm_connector *sort_connector[AMDGPU_DM_MAX_CRTC] = {NULL};
+	struct drm_connector_list_iter iter;
+	uint8_t idx = 0, idx_2 = 0, connector_cnt = 0;
+
+	dm->secure_display_phy_mapping_updated = false;
+
+	mutex_lock(&ddev->mode_config.mutex);
+	drm_connector_list_iter_begin(ddev, &iter);
+	drm_for_each_connector_iter(connector, &iter) {
+
+		if (connector->status != connector_status_connected)
+			continue;
+
+		if (idx >= AMDGPU_DM_MAX_CRTC) {
+			DRM_WARN("%s connected connectors exceed max crtc\n", __func__);
+			mutex_unlock(&ddev->mode_config.mutex);
+			return;
+		}
+
+		aconnector = to_amdgpu_dm_connector(connector);
+
+		sort_connector[idx] = aconnector;
+		idx++;
+		connector_cnt++;
+	}
+	drm_connector_list_iter_end(&iter);
+
+	/* sort connectors by link_enc_hw_instance first */
+	for (idx = connector_cnt; idx > 1 ; idx--) {
+		for (idx_2 = 0; idx_2 < (idx - 1); idx_2++) {
+			if (sort_connector[idx_2]->dc_link->link_enc_hw_inst >
+				sort_connector[idx_2 + 1]->dc_link->link_enc_hw_inst) {
+				aconnector = sort_connector[idx_2];
+				sort_connector[idx_2] = sort_connector[idx_2 + 1];
+				sort_connector[idx_2 + 1] = aconnector;
+			}
+		}
+	}
+
+	/*
+	 * Sort mst connectors by RAD. mst connectors with the same enc_hw_instance are already
+	 * sorted together above.
+	 */
+	for (idx = 0; idx < connector_cnt; /*Do nothing*/) {
+		if (sort_connector[idx]->mst_root) {
+			uint8_t i, j, k;
+			uint8_t mst_con_cnt = 1;
+
+			for (idx_2 = (idx + 1); idx_2 < connector_cnt; idx_2++) {
+				if (sort_connector[idx_2]->mst_root == sort_connector[idx]->mst_root)
+					mst_con_cnt++;
+				else
+					break;
+			}
+
+			for (i = mst_con_cnt; i > 1; i--) {
+				for (j = idx; j < (idx + i - 2); j++) {
+					int mstb_lct = sort_connector[j]->mst_output_port->parent->lct;
+					int next_mstb_lct = sort_connector[j + 1]->mst_output_port->parent->lct;
+					u8 *rad;
+					u8 *next_rad;
+					bool swap = false;
+
+					/* Sort by mst tree depth first. Then compare RAD if depth is the same*/
+					if (mstb_lct > next_mstb_lct) {
+						swap = true;
+					} else if (mstb_lct == next_mstb_lct) {
+						if (mstb_lct == 1) {
+							if (sort_connector[j]->mst_output_port->port_num > sort_connector[j + 1]->mst_output_port->port_num)
+								swap = true;
+						} else if (mstb_lct > 1) {
+							rad = sort_connector[j]->mst_output_port->parent->rad;
+							next_rad = sort_connector[j + 1]->mst_output_port->parent->rad;
+
+							for (k = 0; k < mstb_lct - 1; k++) {
+								int shift = (k % 2) ? 0 : 4;
+								int port_num = (rad[k / 2] >> shift) & 0xf;
+								int next_port_num = (next_rad[k / 2] >> shift) & 0xf;
+
+								if (port_num > next_port_num) {
+									swap = true;
+									break;
+								}
+							}
+						} else {
+							DRM_ERROR("MST LCT shouldn't be set as < 1");
+							mutex_unlock(&ddev->mode_config.mutex);
+							return;
+						}
+					}
+
+					if (swap) {
+						aconnector = sort_connector[j];
+						sort_connector[j] = sort_connector[j + 1];
+						sort_connector[j + 1] = aconnector;
+					}
+				}
+			}
+
+			idx += mst_con_cnt;
+		} else {
+			idx++;
+		}
+	}
+
+	/* Complete sorting. Assign relavant result to dm->phy_id_mapping[]*/
+	memset(dm->phy_id_mapping, 0, sizeof(dm->phy_id_mapping));
+	for (idx = 0; idx < connector_cnt; idx++) {
+		aconnector = sort_connector[idx];
+
+		dm->phy_id_mapping[idx].assigned = true;
+		dm->phy_id_mapping[idx].is_mst = false;
+		dm->phy_id_mapping[idx].enc_hw_inst = aconnector->dc_link->link_enc_hw_inst;
+
+		if (sort_connector[idx]->mst_root) {
+			dm->phy_id_mapping[idx].is_mst = true;
+			dm->phy_id_mapping[idx].lct = aconnector->mst_output_port->parent->lct;
+			dm->phy_id_mapping[idx].port_num = aconnector->mst_output_port->port_num;
+			memcpy(dm->phy_id_mapping[idx].rad, aconnector->mst_output_port->parent->rad,
+				sizeof(aconnector->mst_output_port->parent->rad));
+		}
+	}
+	mutex_unlock(&ddev->mode_config.mutex);
+
+	dm->phy_id_mapping_cnt = connector_cnt;
+	dm->secure_display_phy_mapping_updated = true;
+}
+
+static bool get_phy_id(struct amdgpu_display_manager *dm,
+			struct amdgpu_dm_connector *aconnector, uint8_t *phy_id)
+{
+	int idx, idx_2;
+	bool found = false;
+
+	/*
+	 * Assume secure display start after all connectors are probed. The connection
+	 * config is static as well
+	 */
+	if (!dm->secure_display_phy_mapping_updated) {
+		DRM_WARN("%s Should update the phy id table before get it's value", __func__);
+		return false;
+	}
+
+	for (idx = 0; idx < dm->phy_id_mapping_cnt; idx++) {
+		if (!dm->phy_id_mapping[idx].assigned) {
+			DRM_ERROR("phy_id_mapping[%d] should be assigned", idx);
+			return false;
+		}
+
+		if (aconnector->dc_link->link_enc_hw_inst == dm->phy_id_mapping[idx].enc_hw_inst) {
+			if (!dm->phy_id_mapping[idx].is_mst) {
+				found = true;
+				goto out;
+			} else {
+				/* Could caused by wrongly pass mst root connector */
+				if (!aconnector->mst_output_port) {
+					DRM_ERROR("%s Check mst case but connector without a port assigned", __func__);
+					return false;
+				}
+
+				if (aconnector->mst_root &&
+					aconnector->mst_root->mst_mgr.mst_primary == NULL) {
+					DRM_WARN("%s pass in a stale mst connector", __func__);
+				}
+
+				if (aconnector->mst_output_port->parent->lct == dm->phy_id_mapping[idx].lct &&
+					aconnector->mst_output_port->port_num == dm->phy_id_mapping[idx].port_num) {
+					if (aconnector->mst_output_port->parent->lct == 1) {
+						found = true;
+						goto out;
+					} else if (aconnector->mst_output_port->parent->lct > 1) {
+						/* Check RAD */
+						for (idx_2 = 0; idx_2 < aconnector->mst_output_port->parent->lct - 1; idx_2++) {
+							int shift = (idx_2 % 2) ? 0 : 4;
+							int port_num = (aconnector->mst_output_port->parent->rad[idx_2 / 2] >> shift) & 0xf;
+							int port_num2 = (dm->phy_id_mapping[idx].rad[idx_2 / 2] >> shift) & 0xf;
+
+							if (port_num != port_num2)
+								break;
+						}
+
+						if (idx_2 == aconnector->mst_output_port->parent->lct - 1) {
+							found = true;
+							goto out;
+						}
+					} else {
+						DRM_ERROR("lCT should be >= 1");
+						return false;
+					}
+				}
+			}
+		}
+	}
+
+out:
+	if (found) {
+		DRM_DEBUG_DRIVER("Associated secure display PHY ID as %d", idx);
+		*phy_id = idx;
+	} else {
+		DRM_WARN("Can't find associated phy ID");
+		return false;
+	}
+
+	return true;
+}
+
 static void amdgpu_dm_set_crc_window_default(struct drm_crtc *crtc, struct dc_stream_state *stream)
 {
 	struct drm_device *drm_dev = crtc->dev;
 	struct amdgpu_display_manager *dm = &drm_to_adev(drm_dev)->dm;
 	struct amdgpu_crtc *acrtc = to_amdgpu_crtc(crtc);
 	bool was_activated;
-	uint8_t phy_id = stream->link->link_enc_hw_inst;
+	struct amdgpu_dm_connector *aconnector;
+	uint8_t phy_id;
 
 	spin_lock_irq(&drm_dev->event_lock);
 	was_activated = acrtc->dm_irq_params.window_param.activated;
@@ -107,7 +320,13 @@ static void amdgpu_dm_set_crc_window_default(struct drm_crtc *crtc, struct dc_st
 		/* stop ROI update on this crtc */
 		flush_work(&dm->secure_display_ctxs[crtc->index].notify_ta_work);
 		flush_work(&dm->secure_display_ctxs[crtc->index].forward_roi_work);
-		dc_stream_forward_crc_window(stream, NULL, phy_id, true);
+
+		aconnector = (struct amdgpu_dm_connector *)stream->dm_stream_context;
+
+		if (aconnector && get_phy_id(dm, aconnector, &phy_id))
+			dc_stream_forward_crc_window(stream, NULL, phy_id, true);
+		else
+			DRM_DEBUG_DRIVER("%s Can't find matching phy id", __func__);
 	}
 }
 
@@ -118,7 +337,9 @@ static void amdgpu_dm_crtc_notify_ta_to_read(struct work_struct *work)
 	struct ta_securedisplay_cmd *securedisplay_cmd;
 	struct drm_crtc *crtc;
 	struct dc_stream_state *stream;
+	struct amdgpu_dm_connector *aconnector;
 	uint8_t phy_inst;
+	struct amdgpu_display_manager *dm;
 	int ret;
 
 	secure_display_ctx = container_of(work, struct secure_display_context, notify_ta_work);
@@ -134,8 +355,19 @@ static void amdgpu_dm_crtc_notify_ta_to_read(struct work_struct *work)
 		return;
 	}
 
+	dm = &drm_to_adev(crtc->dev)->dm;
 	stream = to_amdgpu_crtc(crtc)->dm_irq_params.stream;
-	phy_inst = stream->link->link_enc_hw_inst;
+	aconnector = (struct amdgpu_dm_connector *)stream->dm_stream_context;
+	if (!aconnector)
+		return;
+
+	mutex_lock(&crtc->dev->mode_config.mutex);
+	if (!get_phy_id(dm, aconnector, &phy_inst)) {
+		DRM_WARN("%s Can't find mapping phy id!", __func__);
+		mutex_unlock(&crtc->dev->mode_config.mutex);
+		return;
+	}
+	mutex_unlock(&crtc->dev->mode_config.mutex);
 
 	/* need lock for multiple crtcs to use the command buffer */
 	mutex_lock(&psp->securedisplay_context.mutex);
@@ -165,6 +397,8 @@ amdgpu_dm_forward_crc_window(struct work_struct *work)
 	struct amdgpu_display_manager *dm;
 	struct drm_crtc *crtc;
 	struct dc_stream_state *stream;
+	struct amdgpu_dm_connector *aconnector;
+	uint8_t phy_id;
 
 	secure_display_ctx = container_of(work, struct secure_display_context, forward_roi_work);
 	crtc = secure_display_ctx->crtc;
@@ -174,10 +408,22 @@ amdgpu_dm_forward_crc_window(struct work_struct *work)
 
 	dm = &drm_to_adev(crtc->dev)->dm;
 	stream = to_amdgpu_crtc(crtc)->dm_irq_params.stream;
+	aconnector = (struct amdgpu_dm_connector *)stream->dm_stream_context;
+
+	if (!aconnector)
+		return;
+
+	mutex_lock(&crtc->dev->mode_config.mutex);
+	if (!get_phy_id(dm, aconnector, &phy_id)) {
+		DRM_WARN("%s Can't find mapping phy id!", __func__);
+		mutex_unlock(&crtc->dev->mode_config.mutex);
+		return;
+	}
+	mutex_unlock(&crtc->dev->mode_config.mutex);
 
 	mutex_lock(&dm->dc_lock);
 	dc_stream_forward_crc_window(stream, &secure_display_ctx->rect,
-		stream->link->link_enc_hw_inst, false);
+		phy_id, false);
 	mutex_unlock(&dm->dc_lock);
 }
 
@@ -260,6 +506,10 @@ int amdgpu_dm_crtc_set_crc_source(struct drm_crtc *crtc, const char *src_name)
 	struct drm_crtc_commit *commit;
 	struct dm_crtc_state *crtc_state;
 	struct drm_device *drm_dev = crtc->dev;
+#if defined(CONFIG_DRM_AMD_SECURE_DISPLAY)
+	struct amdgpu_device *adev = drm_to_adev(drm_dev);
+	struct amdgpu_display_manager *dm = &adev->dm;
+#endif
 	struct amdgpu_crtc *acrtc = to_amdgpu_crtc(crtc);
 	struct drm_dp_aux *aux = NULL;
 	bool enable = false;
@@ -404,6 +654,12 @@ int amdgpu_dm_crtc_set_crc_source(struct drm_crtc *crtc, const char *src_name)
 	/* Reset crc_skipped on dm state */
 	crtc_state->crc_skip_count = 0;
 
+#if defined(CONFIG_DRM_AMD_SECURE_DISPLAY)
+	/* Initialize phy id mapping table for secure display*/
+	if (!dm->secure_display_phy_mapping_updated)
+		update_phy_id_mapping(adev);
+#endif
+
 cleanup:
 	if (commit)
 		drm_crtc_commit_put(commit);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.h
index 748e80ef40d0..82afb551632b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.h
@@ -40,6 +40,15 @@ enum amdgpu_dm_pipe_crc_source {
 };
 
 #ifdef CONFIG_DRM_AMD_SECURE_DISPLAY
+struct phy_id_mapping {
+	bool assigned;
+	bool is_mst;
+	uint8_t enc_hw_inst;
+	u8 lct;
+	u8 port_num;
+	u8 rad[8];
+};
+
 struct crc_window_param {
 	uint16_t x_start;
 	uint16_t y_start;
-- 
2.47.1

