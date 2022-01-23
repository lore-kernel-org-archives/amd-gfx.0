Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13244C433FE
	for <amd-gfx@archiver.kernel.org>; Sun, 23 Jan 2022 18:21:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C5A5F10E7F6;
	Sun, 23 Jan 2022 18:21:17 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2043.outbound.protection.outlook.com [40.107.236.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9AD0210E7F6
 for <amd-gfx@lists.freedesktop.org>; Sun, 23 Jan 2022 18:21:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R12xYZse5FbJsT6vlRK5EfSnJq+ypvBpWS2rX++v55pjOhbDyTHet0tqGnp6qMOAI0UVYuyq2/FdlVjEcjyxwUOMZx3Zpz1ezl5VfUEq63NKiNHFplbgP1L4h0elAex7k+wlC6dIOmrgX4VqOeGwi8hyQpavBI2IJ3caSOLoi4SxCK1/hJo2oZ1DHV39ALVX2n+HtsuECy6BgZbwLNwxR/FTN64vtpTjgvT9l8+qvpHKsi7sCIZsl4d8PYdKPE9J+gAH5lfcYWEr3DOplFpOiYiBBzEVwR9xIdLUQcHSHdV6h3ZKiMDVldOWKE5ipJLlAFtjV3lgY1J+HRTh505CGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DR6GS292JFywXK0HbwkfNFxPU1ix2eCR73gU2sAVAwQ=;
 b=ac1Nx0a0mzNoeIFZ/MfR6vwaNNYdmUCSwgNzVb+gNDl+fvfez2HZb6VV5U2rTnJGT+5iMvH9iFIHbr/6lhVJjCl28ieQ6mHK3tgBvW3w/J5Rb/vKj5mOT8ZSuA37bZackNnVj2tYZNpBYbKz/y/h3AMCJWGS5LqANBzrISqwZxFytXxsDcJr5+94p9HVdei4AW1D0QiOhcAS/pSOccGgQDoNXIuyw580FaWQ8A3kK5U3m9JoU8Q2Tkpi/A5KHgERckoi6elivH+J6t4U0WFLTyQMHotgymym9H652yJFsQ4swS3Lu5odUc+Kr2nkjB2JhjNIat1MthlglK7wcd5wwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DR6GS292JFywXK0HbwkfNFxPU1ix2eCR73gU2sAVAwQ=;
 b=R1YRhHX04euByNiXgw0cP+k4pZDdTWT66jVS8ugCRVZgk+QqhlLAZEvi1XhXazeHg0FSYpN97lD8oOFEzd1gRlBcvpCSboFc9WIDO/h1u1+A9KHejwMsX9HSp9Iy0j9ju3ZrI2OTXvby+k7W2lv4ptPhPiVJe47yaMgzzY8Jygk=
Received: from BN6PR13CA0050.namprd13.prod.outlook.com (2603:10b6:404:11::12)
 by MW2PR12MB2347.namprd12.prod.outlook.com (2603:10b6:907:7::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Sun, 23 Jan
 2022 18:21:06 +0000
Received: from BN8NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:11:cafe::82) by BN6PR13CA0050.outlook.office365.com
 (2603:10b6:404:11::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.14 via Frontend
 Transport; Sun, 23 Jan 2022 18:21:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT041.mail.protection.outlook.com (10.13.177.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4909.7 via Frontend Transport; Sun, 23 Jan 2022 18:21:05 +0000
Received: from atma2.hitronhub.home (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Sun, 23 Jan
 2022 12:21:03 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 11/24] drm/amd/display: Add DSC Enable for Synaptics Hub
Date: Sun, 23 Jan 2022 13:20:08 -0500
Message-ID: <20220123182021.4154032-12-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220123182021.4154032-1-Rodrigo.Siqueira@amd.com>
References: <20220123182021.4154032-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1b5a955b-e80a-474f-7946-08d9de9d1e96
X-MS-TrafficTypeDiagnostic: MW2PR12MB2347:EE_
X-Microsoft-Antispam-PRVS: <MW2PR12MB2347917527BFB7BB75C24A3A985D9@MW2PR12MB2347.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: owZ1m/dCvgo6h/bPbEJd3eADExnjNLIaR4jT53L0K49mT4xsWmvaKJuWhN7z3FenQH+xE0WsAgVVxVT6odWpxbEeP2oH59W6q3d6QWSI5e67mvQdQw28e4N1GWXMgm6MYCGvduXnNEY+f8sgY9qukqWANp3K9ojnpc9xrWZZxDQZQMp5sWrJWlrqaZhKpasg/1webZN+pJyxalqOXVQdgizGLIknfQncIu0tBkWwYIDTt+QxNCakcE0SniJUgQJ/1mKAKms82dIrLFlcX8Fuvk+WqzeR7vFfzeVAKe9Sjx6hA9ELCU6DoxRMHukc9P+HsvQhz5I6GOXOxChe8YPCdaWKBvyvuAmHJ5EKhZpJw+81M5SElqOIMQvbwURVdB5jLOO7Jqpu6zuXw4RoI4jtQbsaPVf0C66YTSZBohYNt/v1VfA4W6jBDOd8vFSV1G3tIT0MgOS3ts+uopiBz/KRqkrfZ+hv2hrWLPVKixnF+8PdiNz/48bokdz7cgrHJm0tep+p5q5ev7x79U/nOkwodfpcwWc1f+bI2Fzf6swnEH8Ns8CFtqTTchvVQ66SQ4IbFfI2iogjE2rX58X6mk02nwNdQM+P74hZb1rTpndWb1UwMPj8HZwJaW+S8csY0B76yOikHvUYYRgDvIriptfh1YmjcnbYFbTPpe6CunHv+K5o5P/wOToyw2vgOwVzmnMpGZGNSqOLobSCEmQLH7Etrh2231q4HErpWUDfmwKpW7ugBzTYVPYtGzyUNNlWhlknnn2Nj2GTWhvWhPkVOMpW+a1FbsVlCY59JBoFv6v8s0w=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(40470700004)(8676002)(316002)(70586007)(70206006)(36860700001)(4326008)(356005)(81166007)(54906003)(8936002)(1076003)(40460700003)(508600001)(336012)(82310400004)(86362001)(426003)(36756003)(2616005)(47076005)(26005)(6916009)(5660300002)(186003)(16526019)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2022 18:21:05.3576 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b5a955b-e80a-474f-7946-08d9de9d1e96
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2347
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Fangzhi Zuo <Jerry.Zuo@amd.com>,
 Aurabindo.Pillai@amd.com, Hersen Wu <hersenxs.wu@amd.com>, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Fangzhi Zuo <Jerry.Zuo@amd.com>

DSC sequence for non virtual dpcd synaptics hub

Reviewed-by: Hersen Wu <hersenxs.wu@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Fangzhi Zuo <Jerry.Zuo@amd.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 48 +++++++++++++++++++
 .../amd/display/include/ddc_service_types.h   |  3 ++
 2 files changed, 51 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
index b760c0b199d5..32fbd3902e93 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
@@ -39,6 +39,7 @@
 #include "amdgpu_dm_mst_types.h"
 
 #include "dm_helpers.h"
+#include "ddc_service_types.h"
 
 struct monitor_patch_info {
 	unsigned int manufacturer_id;
@@ -537,6 +538,7 @@ bool dm_helpers_submit_i2c(
 	return result;
 }
 
+#if defined(CONFIG_DRM_AMD_DC_DCN)
 static bool execute_synatpics_rc_command(struct drm_dp_aux *aux,
 		bool is_write_cmd,
 		unsigned char cmd,
@@ -669,6 +671,43 @@ static void apply_synaptics_fifo_reset_wa(struct drm_dp_aux *aux)
 	DC_LOG_DC("Done apply_synaptics_fifo_reset_wa\n");
 }
 
+static uint8_t write_dsc_enable_synaptics_non_virtual_dpcd_mst(
+		struct drm_dp_aux *aux,
+		const struct dc_stream_state *stream,
+		bool enable)
+{
+	uint8_t ret = 0;
+
+	DC_LOG_DC("Configure DSC to non-virtual dpcd synaptics\n");
+
+	if (enable) {
+		/* When DSC is enabled on previous boot and reboot with the hub,
+		 * there is a chance that Synaptics hub gets stuck during reboot sequence.
+		 * Applying a workaround to reset Synaptics SDP fifo before enabling the first stream
+		 */
+		if (!stream->link->link_status.link_active &&
+			memcmp(stream->link->dpcd_caps.branch_dev_name,
+				(int8_t *)SYNAPTICS_DEVICE_ID, 4) == 0)
+			apply_synaptics_fifo_reset_wa(aux);
+
+		ret = drm_dp_dpcd_write(aux, DP_DSC_ENABLE, &enable, 1);
+		DRM_INFO("Send DSC enable to synaptics\n");
+
+	} else {
+		/* Synaptics hub not support virtual dpcd,
+		 * external monitor occur garbage while disable DSC,
+		 * Disable DSC only when entire link status turn to false,
+		 */
+		if (!stream->link->link_status.link_active) {
+			ret = drm_dp_dpcd_write(aux, DP_DSC_ENABLE, &enable, 1);
+			DRM_INFO("Send DSC disable to synaptics\n");
+		}
+	}
+
+	return ret;
+}
+#endif
+
 bool dm_helpers_dp_write_dsc_enable(
 		struct dc_context *ctx,
 		const struct dc_stream_state *stream,
@@ -687,7 +726,16 @@ bool dm_helpers_dp_write_dsc_enable(
 		if (!aconnector->dsc_aux)
 			return false;
 
+#if defined(CONFIG_DRM_AMD_DC_DCN)
+		// apply w/a to synaptics
+		if (needs_dsc_aux_workaround(aconnector->dc_link) &&
+		    (aconnector->mst_downstream_port_present.byte & 0x7) != 0x3)
+			return write_dsc_enable_synaptics_non_virtual_dpcd_mst(
+				aconnector->dsc_aux, stream, enable_dsc);
+#endif
+
 		ret = drm_dp_dpcd_write(aconnector->dsc_aux, DP_DSC_ENABLE, &enable_dsc, 1);
+		DC_LOG_DC("Send DSC %s to MST RX\n", enable_dsc ? "enable" : "disable");
 	}
 
 	if (stream->signal == SIGNAL_TYPE_DISPLAY_PORT || stream->signal == SIGNAL_TYPE_EDP) {
diff --git a/drivers/gpu/drm/amd/display/include/ddc_service_types.h b/drivers/gpu/drm/amd/display/include/ddc_service_types.h
index 57f92bd2814f..fb289a5c873a 100644
--- a/drivers/gpu/drm/amd/display/include/ddc_service_types.h
+++ b/drivers/gpu/drm/amd/display/include/ddc_service_types.h
@@ -123,4 +123,7 @@ struct av_sync_data {
 static const uint8_t DP_SINK_DEVICE_STR_ID_1[] = {7, 1, 8, 7, 3, 0};
 static const uint8_t DP_SINK_DEVICE_STR_ID_2[] = {7, 1, 8, 7, 5, 0};
 
+/*MST Dock*/
+static const uint8_t SYNAPTICS_DEVICE_ID[] = "SYNA";
+
 #endif /* __DAL_DDC_SERVICE_TYPES_H__ */
-- 
2.25.1

