Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11CB7D6AAEC
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Apr 2026 18:34:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABC8A10F2EC;
	Thu,  2 Apr 2026 18:34:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Q3+dzVtG";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010053.outbound.protection.outlook.com [52.101.61.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44D1D10F1BD
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Apr 2026 18:34:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AWmUvY56xPR1YYtBX5k31lN6jQa/T6aCwBSYe1tNlT6kCKa6U37CbWnie2ff6GDQ34z1V2Q6AqYQOFpJe0bw0jB0dUXddgMn/eXRhgvTc3e8DfUaLfUor7rr/rFsbiOhWK2EJqVvF2SZMwocXZgJHuL7FwBcjV63QvdMExH9sXqgzBt2q3lRqyp1bsK/D3p5DnldPyr11clEBpIy68GrQzi9VqS4d8DyAvS/X+JGr7T2YBpJu4L7TBcl1JiA4fP/KzuZ5qklr9u4o05A0prZRaJSCC/VXjQUi6OKOLYP0inia1Fr2JfWRhWQkZmbtA2J+Q/N0HGwDGKKZkNlZMVEng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NuuFkfHWVJEIrtnUQwRGbG2t2HR1FKUtXhAzI8VKYI8=;
 b=Hq5JWtZssQCRPpoTuFD44RqElVZlYvMKST2XMwRYeV0Hl2vOXhWXWpSMtQs4MrI6yx2gxyyZNB7R1/lQSdGsnVRxkNQXOf025RyJVmqVQaSVAqlTRDTvcRizUuuZ+FPiWxP39ATHlm6KCwGV4e9NxzEa3kENjQRRShtYlMBNn1M8jZTAJEbQLfAUiPAC2l2AKn/tUlanCq50aSyEARv8RyQAiL1KpuKVrZPeETq9YCVPhUZa79gdMwbkZbjx5Y3i7fQgsvK5Gnucf+MmSRCj/XViVQ9dhKOE/xbZi8eQ6VDlasezGPCZiATveQlFOb9oyRRFFXEOTk2xUMGJlZkRcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NuuFkfHWVJEIrtnUQwRGbG2t2HR1FKUtXhAzI8VKYI8=;
 b=Q3+dzVtGEuFg5uIa3MgQeQzOwi1NbPj+VMBX5CQLVzv72AP9stvjGjTR69QwuWTO8g54A0+y906+JfI8ufUWvW8CZ251cCF3d2/+4zUK0PUVQT1RtyO3k5MmrExqXrkUsGvjvOyChaFKfTH4sh6iNn8g94Ove8CIUfMXbN9Rad4=
Received: from CH0PR13CA0046.namprd13.prod.outlook.com (2603:10b6:610:b2::21)
 by LV9PR12MB9781.namprd12.prod.outlook.com (2603:10b6:408:2f6::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Thu, 2 Apr
 2026 18:33:57 +0000
Received: from DS2PEPF00003442.namprd04.prod.outlook.com
 (2603:10b6:610:b2:cafe::a6) by CH0PR13CA0046.outlook.office365.com
 (2603:10b6:610:b2::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.17 via Frontend Transport; Thu,
 2 Apr 2026 18:33:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS2PEPF00003442.mail.protection.outlook.com (10.167.17.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 2 Apr 2026 18:33:57 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 2 Apr
 2026 13:33:54 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 2 Apr 2026 13:33:48 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Chuanyu Tseng <Chuanyu.Tseng@amd.com>, Wayne Lin
 <Wayne.Lin@amd.com>
Subject: [PATCH 08/22] drm/amd/display: Read sink freesync support via mccs
Date: Thu, 2 Apr 2026 14:33:00 -0400
Message-ID: <20260402183314.1388755-9-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260402183314.1388755-1-Roman.Li@amd.com>
References: <20260402183314.1388755-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003442:EE_|LV9PR12MB9781:EE_
X-MS-Office365-Filtering-Correlation-Id: e91a5b0e-45e1-4beb-a8f0-08de90e6669a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|82310400026|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: oji92pnTCRXGrd+TBp/fgld048dkrkJLC3M5URHA0NBEIjWE6w4tbhTiTcvA/+CWlgelYfySHOUp6MEoLqfHjeGtyCQtfwEWnMYUc2sxlssXH6hzuA3qzI6dqxSIChScTE2+vnyyr3mW26cuaBtiTzgcG1U0tnt16zW/CfribrPhj+wCnsBf3gtxuGuvnZYOiMUVFnlmezKQQIx4xY8Zl4mnBF/T22qyKrG5QlEElCEJJ3UJx+8g0uJQuuRo7X0lB1rpaFXDdnxzhT3jWqIlroetxkvztKjp+zRgahfpNkEKX6qHCaE6bzXfe4iAy3FQZVWK9PR8mXUhb5sMsv+0m5HvUj465IDgsP+Tctwzou4HRWteenyROETbIcr3VZDdgRgSn+hSoEqNhVegFbAgfX+uUt09iYc+nP3vsJgbAoGrRWqag4PLfLd97qh/zc9riEbgwucslFnysclCefBq6KJXHmPb0I5EXXf9d+Ha/4mOLZAw3JHbvDW7mPiB7wHlHvsobVMbRwFfYWMA0DkSR/wOtiefCgXz/0g0RNvfU0BwMlE/R+UpmpzjeZ4plQbkg1i/ER8huzCbobc7UJbjg8Tcj89s+qCW+7S+RSUwKfllcfWysunQKAiLD1avIOCGpNFkZC6/nrH0QM7SeuVuVTLXYo2XR3PkLLwci9rcziuAaN3njWGeB0NhJsgSfdCf4VOCXwfVLCBl4T6+gpd8QtJAxodw8ksjFAUAlO0xz0ewEcKbvcCL3FBcr9TLuWeZBuhfWNvi2efVX96jPBWULg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: wMEZsT1VlaE05IW5GzNKUSLb5DabBLnPCKfaPUN3GJjWHceMT6pcdp+HSETuhkBxWyHPUraXX62DEu0XM+rsqhtZwJgn02wDoicbFZIT4yq4MnCjlTtFGuKnEm1Cd621FwT+XPiT4+A2IdNlNsVEMC9m1rgDQIKoTgGBd3Ocr0xmm7nTxsP2aBLTxII0dXyFS352+wdsMfLl/rc9TNthofNhe/49AvoFr41t5u76u30jRj7EmTpa7zMLPWU0z9xG4NOaCgtQqIGIPXRB8uH+8isxWok/GjxHKPVoocucXG9vPFEWQD3mpCmNzVwv5xPrpcFIGXxvw7tgwpmqY/+1mdQ9ET+odB7GP1Tlb7cKz2KepWxKj0T7Kh7h2lNA4+K3uaInbynCigoI/mWa8JRQRJIgP5vD59TmRhAaaCVag9ucRWDIXyP1qms5NzEexp8x
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 18:33:57.0763 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e91a5b0e-45e1-4beb-a8f0-08de90e6669a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003442.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9781
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

If EDID AMD VSDB declares that sink supports MCCS method for freesync
usage, send mccs request to understand sink freesync current supporting
state.

If sink supports freesync but user toggles OSD to turn off it, disable
freesync.

If HDMI sink doesn't support MCCS method for freesync usage, disable
freesync as well.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   8 +
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 165 ++++++++++++++++++
 drivers/gpu/drm/amd/display/dc/dc.h           |   1 +
 drivers/gpu/drm/amd/display/dc/dc_types.h     |   4 +
 drivers/gpu/drm/amd/display/dc/dm_helpers.h   |   5 +
 .../drm/amd/display/dc/link/link_detection.c  |  14 ++
 6 files changed, 197 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index c613deb7c88a..ceef9b6e1599 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -13372,6 +13372,14 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
 		}
 	}
 
+	/* Handle MCCS */
+	dm_helpers_read_mccs_caps(adev->dm.dc->ctx, amdgpu_dm_connector->dc_link, sink);
+	if ((sink->sink_signal == SIGNAL_TYPE_HDMI_TYPE_A ||
+		as_type == FREESYNC_TYPE_PCON_IN_WHITELIST) &&
+		(!sink->edid_caps.freesync_vcp_code ||
+		(sink->edid_caps.freesync_vcp_code && !sink->mccs_caps.freesync_supported)))
+		freesync_capable = false;
+
 update:
 	if (dm_con_state)
 		dm_con_state->freesync_capable = freesync_capable;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index 6de2eb34f862..0146e894a15a 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -49,6 +49,45 @@
 #include "ddc_service_types.h"
 #include "clk_mgr.h"
 
+#define MCCS_DEST_ADDR (0x6E >> 1)
+#define MCCS_SRC_ADDR	0x51
+#define MCCS_LENGTH_OFFSET 0x80
+#define MCCS_MAX_DATA_SIZE 0x20
+
+enum mccs_op_code {
+	MCCS_OP_CODE_VCP_REQUEST = 0x01,
+	MCCS_OP_CODE_VCP_REPLY = 0x02,
+	MCCS_OP_CODE_VCP_SET = 0x03,
+	MCCS_OP_CODE_VCP_RESET = 0x09,
+	MCCS_OP_CODE_CAP_REQUEST = 0xF3,
+	MCCS_OP_CODE_CAP_REPLY = 0xE3
+};
+
+enum mccs_op_buff_size {
+	MCCS_OP_BUFF_SIZE__WR_VCP_REQUEST = 5,
+	MCCS_OP_BUFF_SIZE_RD_VCP_REQUEST = 11,
+	MCCS_OP_BUFF_SIZE_WR_VCP_SET = 7,
+};
+
+enum vcp_reply_mask {
+	FREESYNC_SUPPORTED = 0x1
+};
+
+union vcp_reply {
+	struct {
+		unsigned char src_addr;
+		unsigned char length;			/* Length is offset by MccsLengthOffs = 0x80 */
+		unsigned char reply_op_code;	/* Should return MCCS_OP_CODE_VCP_REPLY = 0x02 */
+		unsigned char result_code;		/* 00h No Error, 01h Unsupported VCP Code */
+		unsigned char request_code;		/* Should return mccs vcp code sent in the vcp request */
+		unsigned char type_code;		/* VCP type code: 00h Set parameter, 01h Momentary */
+		unsigned char max_value[2];		/* 2 bytes returning max value current value */
+		unsigned char present_value[2];	/* NOTE: Byte0 is MSB, Byte1 is LSB */
+		unsigned char check_sum;
+	} bytes;
+	unsigned char raw[11];
+};
+
 static u32 edid_extract_panel_id(struct edid *edid)
 {
 	return (u32)edid->mfg_id[0] << 24   |
@@ -1441,3 +1480,129 @@ bool dm_helpers_is_hdr_on(struct dc_context *ctx, struct dc_stream_state *stream
 	// TODO
 	return false;
 }
+
+static int mccs_operation_vcp_request(unsigned int vcp_code, struct dc_link *link,
+				union vcp_reply *reply)
+{
+	const unsigned char retry_interval_ms = 40;
+	unsigned char retry = 5;
+	struct amdgpu_dm_connector *aconnector = link->priv;
+	struct i2c_adapter *ddc;
+	struct i2c_msg msg = {0};
+	int ret = 0;
+	int idx;
+
+	unsigned char wr_data[MCCS_OP_BUFF_SIZE__WR_VCP_REQUEST] = {
+		MCCS_SRC_ADDR,				/* Byte0 - Src Addr */
+		MCCS_LENGTH_OFFSET + 2,		/* Byte1 - Length */
+		MCCS_OP_CODE_VCP_REQUEST,	/* Byte2 - MCCS Command */
+		(unsigned char) vcp_code,	/* Byte3 - VCP Code */
+		MCCS_DEST_ADDR << 1			/* Byte4 - CheckSum */
+	};
+
+	/* calculate checksum */
+	for (idx = 0; idx < (MCCS_OP_BUFF_SIZE__WR_VCP_REQUEST - 1); idx++)
+		wr_data[(MCCS_OP_BUFF_SIZE__WR_VCP_REQUEST-1)] ^= wr_data[idx];
+
+	if (link->aux_mode)
+		ddc = &aconnector->dm_dp_aux.aux.ddc;
+	else
+		ddc = &aconnector->i2c->base;
+
+	do {
+		msg.addr = MCCS_DEST_ADDR;
+		msg.flags = 0;
+		msg.len = MCCS_OP_BUFF_SIZE__WR_VCP_REQUEST;
+		msg.buf = wr_data;
+
+		ret = i2c_transfer(ddc, &msg, 1);
+		if (ret != 1)
+			goto mccs_retry;
+
+		msleep(retry_interval_ms);
+
+		msg.addr = MCCS_DEST_ADDR;
+		msg.flags = I2C_M_RD;
+		msg.len = MCCS_OP_BUFF_SIZE_RD_VCP_REQUEST;
+		msg.buf = reply->raw;
+
+		ret = i2c_transfer(ddc, &msg, 1);
+
+		/* sink might reply with null msg if it can't reply in time */
+		if (ret == 1 && reply->bytes.length > MCCS_LENGTH_OFFSET)
+			break;
+mccs_retry:
+		retry--;
+		msleep(retry_interval_ms);
+	} while (retry);
+
+	if (!retry) {
+		drm_dbg_driver(aconnector->base.dev,
+			"%s: MCCS VCP request failed after retries", __func__);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+void dm_helpers_read_mccs_caps(struct dc_context *ctx, struct dc_link *link,
+		struct dc_sink *sink)
+{
+	bool mccs_op = false;
+	struct dpcd_caps *dpcd_caps;
+	struct drm_device *dev;
+	uint16_t freesync_vcp_value = 0;
+	union vcp_reply vcp_reply_value = {0};
+
+	if (!ctx)
+		return;
+	dev = adev_to_drm(ctx->driver_context);
+
+	if (!link || !sink) {
+		drm_dbg_driver(dev, "%s: link or sink is NULL", __func__);
+		return;
+	}
+
+	sink->mccs_caps.freesync_supported = false;
+	dpcd_caps = &link->dpcd_caps;
+
+	if (sink->edid_caps.freesync_vcp_code != 0) {
+		if (dc_is_dp_signal(link->connector_signal)) {
+			if ((dpcd_caps->dpcd_rev.raw >= DPCD_REV_14) &&
+				(dpcd_caps->dongle_type == DISPLAY_DONGLE_DP_HDMI_CONVERTER) &&
+				dm_is_freesync_pcon_whitelist(dpcd_caps->branch_dev_id) &&
+				(dpcd_caps->adaptive_sync_caps.dp_adap_sync_caps.bits.ADAPTIVE_SYNC_SDP_SUPPORT == true))
+				mccs_op = true;
+
+			if ((dpcd_caps->dongle_type != DISPLAY_DONGLE_NONE &&
+				dpcd_caps->dongle_type != DISPLAY_DONGLE_DP_HDMI_CONVERTER)) {
+				if (mccs_op == false)
+					drm_dbg_driver(dev, "%s: Legacy Pcon support", __func__);
+				mccs_op = true;
+			}
+
+			if (link->connector_signal == SIGNAL_TYPE_DISPLAY_PORT_MST) {
+				// Todo: Freesync over MST
+				mccs_op = false;
+			}
+		}
+
+		if (dc_is_hdmi_signal(link->connector_signal)) {
+			drm_dbg_driver(dev, "%s: Local HDMI sink", __func__);
+			mccs_op = true;
+		}
+
+		if (mccs_op == true) {
+			// MCCS VCP request to get VCP value
+			if (!mccs_operation_vcp_request(sink->edid_caps.freesync_vcp_code, link,
+					&vcp_reply_value)) {
+				freesync_vcp_value = vcp_reply_value.bytes.present_value[1];
+				freesync_vcp_value |= (uint16_t) vcp_reply_value.bytes.present_value[0] << 8;
+			}
+			// If VCP Value bit 0 is 1, freesyncSupport = true
+			sink->mccs_caps.freesync_supported =
+				(freesync_vcp_value & FREESYNC_SUPPORTED) ? true : false;
+		}
+	}
+}
+
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 5ceadcdca524..7d170eaeb163 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -2725,6 +2725,7 @@ struct dc_sink {
 	struct stereo_3d_features features_3d[TIMING_3D_FORMAT_MAX];
 	bool converter_disable_audio;
 
+	struct mccs_caps mccs_caps;
 	struct scdc_caps scdc_caps;
 	struct dc_sink_dsc_caps dsc_caps;
 	struct dc_sink_fec_caps fec_caps;
diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index 5b7490a7dc7a..7672ee88be82 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -1315,6 +1315,10 @@ struct dc_panel_config {
 	} rio;
 };
 
+struct mccs_caps {
+	bool freesync_supported;
+};
+
 #define MAX_SINKS_PER_LINK 4
 
 /*
diff --git a/drivers/gpu/drm/amd/display/dc/dm_helpers.h b/drivers/gpu/drm/amd/display/dc/dm_helpers.h
index 2818df555e62..3aa2b11f559b 100644
--- a/drivers/gpu/drm/amd/display/dc/dm_helpers.h
+++ b/drivers/gpu/drm/amd/display/dc/dm_helpers.h
@@ -181,6 +181,11 @@ enum dc_edid_status dm_helpers_read_local_edid(
 		struct dc_link *link,
 		struct dc_sink *sink);
 
+void dm_helpers_read_mccs_caps(
+		struct dc_context *ctx,
+		struct dc_link *link,
+		struct dc_sink *sink);
+
 bool dm_helpers_dp_handle_test_pattern_request(
 		struct dc_context *ctx,
 		const struct dc_link *link,
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_detection.c b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
index 714370e773c1..794dd6a95918 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_detection.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
@@ -1234,6 +1234,20 @@ static bool detect_link_and_local_sink(struct dc_link *link,
 		if (dc_is_hdmi_signal(link->connector_signal))
 			read_scdc_caps(link->ddc, link->local_sink);
 
+		/* When FreeSync is toggled through OSD,
+		 * we see same EDID no matter what. Check MCCS caps
+		 * to see if we should update FreeSync caps now.
+		 */
+		dm_helpers_read_mccs_caps(
+				link->ctx,
+				link,
+				sink);
+
+		if (prev_sink != NULL) {
+			if (memcmp(&sink->mccs_caps, &prev_sink->mccs_caps, sizeof(struct mccs_caps)))
+				same_edid = false;
+		}
+
 		if (link->connector_signal == SIGNAL_TYPE_DISPLAY_PORT &&
 		    sink_caps.transaction_type ==
 		    DDC_TRANSACTION_TYPE_I2C_OVER_AUX) {
-- 
2.34.1

