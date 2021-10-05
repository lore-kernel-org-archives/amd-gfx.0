Return-Path: <SRS0=e3IM=OZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04ED8C433EF
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Oct 2021 07:58:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1F3561165
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Oct 2021 07:58:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B1F3561165
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C8356F5A6;
	Tue,  5 Oct 2021 07:58:52 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2056.outbound.protection.outlook.com [40.107.101.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 93C5B6F59E
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Oct 2021 07:58:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bgf4Nx95UI099Rh67n0T6Z6VFjuaFhR0v4SFm4CAL5bu7FzjfIzXK7mjRM8548TndlhNkKHEIr6Y9pLSLTA0081zGclLw7PzHs9AVXtKzZca7wXhrCqngecPqfiocFdT5ZhUbkZMQDLqS8VI2u0GDLECsawXmV0wsfZmdxuuJT4I4thImfKNc1mUGq/AOwj402jYMNDFfKv9h6Sod4sgxmZrvxzGaixw/xtOoEluxLu9UwuVARK2IImjALOQ82BDdS1DBS2oWhmDso/jNooBeeLveACJkBE74Ezbl0wRDolTHlCHGo5osNEJB22s3/v4a153xr7aqbPMjtvNr5yU0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d28hGITk++Y03Hu/M9dwIrUgVOhDkJatOO0zCvQmEhA=;
 b=CENbcSFOqK5pEljbZX5PClxFFDFL80X0ImgRGbfokUuMYwWzbR9LlE/gFRJYUjQ9vvQzBOboODUVcK1OXo9Qbfs0dZnal61RaB5dOFAE/devz9pBVqzIHG9BX0Pwox/qw+rgNeO+3ApCvHjCopZdHItlRLzCp7IgwBnN02lphah/aAKfrvGad5vDHZ5ociwoPVb+rVWrtZtbT+h343jgRCDxCnmFTx88xHG5NcqjSUjPdmSqgHjFes82db/Kx5CFvvnKQ5tCkur6sy/e+QOSd72XKhJQzEbeLiQkqpoOU67LFk9vFbmppqZDA+Rg8McUc9YAfTE6slUivCzOsFBQfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d28hGITk++Y03Hu/M9dwIrUgVOhDkJatOO0zCvQmEhA=;
 b=tqT/DRP0ZHnwnzczHIfuRG2C+dWFNuCUrZOCmCNnIs+QbLppga1yFYKJenjcQlwoU9MGmA0c3irGJR8Nz+6NKYgDi5IVJkKfQaF8BgikM723tXIjGmKHgE2/uI4eIyhVRM0MP6DFtZx0Kzp2qP1lFCRqZZvIx5rPfSSAuxbBeTQ=
Received: from BN9P221CA0005.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::28)
 by BN9PR12MB5130.namprd12.prod.outlook.com (2603:10b6:408:137::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.13; Tue, 5 Oct
 2021 07:58:49 +0000
Received: from BN8NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10a:cafe::6a) by BN9P221CA0005.outlook.office365.com
 (2603:10b6:408:10a::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.22 via Frontend
 Transport; Tue, 5 Oct 2021 07:58:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT040.mail.protection.outlook.com (10.13.177.166) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4566.14 via Frontend Transport; Tue, 5 Oct 2021 07:58:49 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Tue, 5 Oct 2021
 02:58:48 -0500
Received: from wayne-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2308.8
 via Frontend Transport; Tue, 5 Oct 2021 02:58:35 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <Harry.Wentland@amd.com>,
 <nicholas.kazlauskas@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <wayne.lin@amd.com>, <stylon.wang@amd.com>, <jude.shih@amd.com>,
 <jimmy.kizito@amd.com>, <meenakshikumar.somasundaram@amd.com>, Jimmy Kizito
 <Jimmy.Kizito@amd.com>, Jun Lei <Jun.Lei@amd.com>, Wayne Lin
 <Wayne.Lin@amd.com>
Subject: [PATCH v2 15/23] drm/amd/display: Read USB4 DP tunneling data from
 DPCD
Date: Tue, 5 Oct 2021 15:51:57 +0800
Message-ID: <20211005075205.3467938-16-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211005075205.3467938-1-Wayne.Lin@amd.com>
References: <20211005075205.3467938-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7ae7ef1a-9d75-4359-c45b-08d987d5f6fc
X-MS-TrafficTypeDiagnostic: BN9PR12MB5130:
X-Microsoft-Antispam-PRVS: <BN9PR12MB51301A3F885E305B1BA66B29FCAF9@BN9PR12MB5130.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RfJiJ6cQtya34tSJf6smPmkWHnbyIQUbn5sU0Ti/mFfiEggO0VMnBE11/yvCUlir6v2Mj1j7JcH7yqJvH+lD5TO+FrOUIxKLR5BA+lct5TPa60YIrx99Xf3ZPttOOQvNUyzco/CpZ0j+RHYvYtHFX1iNJ4ytDu/RliifjrU+JB1HWYKvWS4t65aNklsCzAoC0meQKsJ6IgSlzFRHMdsEVsTvjwpp73qeK7oFr2y4+m/ur45shGfrpmbHTFhLaEV9v09oR/lAiX3R4Tw/4dqZqCZ8ggNOKWPcxm4/7h+31RxBz0AV8xMXI73sVLM6qeAc6wiGNIz70Gud93WelQnLbKT5hBvCYhIt4EugQ+l10GvsIr6eQ7tC822NQs4+iIVN+Dg0z6cIMznbraByhkUiACuoaAuxmqT4t183UOvQdlfbcKd4ru+H7feWkW+if26Nk6ytQzeNfu5uHUweRIn9muXTwU5M+HMOvBijQcTRIK+zNaxY2pSKsNqJkfYbMAtObNfZnrxg6X6/qFoJ0Ce2d9BH3Y2B9VNs7MFKp4h70w2kHaK4cVexLYaWWnZ7ehNZzWbCB6mpihaAmWudQfXOGGx49CpU4DIFiCvovS6WF/kWwXn4D52SvZCiozPSHLfXKdCBgloO/5Qpi22EvEeIwMG6CIkBLKCK087FP8+szNylgmV4LLtLeSK6PPC/xBoQCnALLUqC4Mxpa8Fy6j0HQvn8u24kgsUjdX69PDXf5nE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(8936002)(4326008)(7696005)(83380400001)(8676002)(66574015)(508600001)(82310400003)(316002)(36860700001)(47076005)(1076003)(26005)(5660300002)(6666004)(54906003)(70586007)(426003)(86362001)(81166007)(2906002)(2616005)(6916009)(36756003)(356005)(70206006)(336012)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2021 07:58:49.0750 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ae7ef1a-9d75-4359-c45b-08d987d5f6fc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5130
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

From: Jimmy Kizito <Jimmy.Kizito@amd.com>

[Why]
We requires information from DPCD in order to identify USB4 DP
tunneling targets.

[How]
Add USB4 DP tunneling fields to DPCD struct and populate these fields
during sink detection.

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Wayne Lin <Wayne.Lin@amd.com>
Acked-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Jimmy Kizito <Jimmy.Kizito@amd.com>
---
 .../drm/amd/display/dc/core/dc_link_dpia.c    | 29 +++++++++++++++--
 drivers/gpu/drm/amd/display/dc/dc.h           |  1 +
 drivers/gpu/drm/amd/display/dc/dc_dp_types.h  | 31 +++++++++++++++++++
 .../gpu/drm/amd/display/dc/inc/dc_link_dpia.h |  7 +++++
 4 files changed, 66 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dpia.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dpia.c
index a7fc60565bda..fb0d8b8a840a 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dpia.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dpia.c
@@ -33,14 +33,39 @@
 #include "inc/link_dpcd.h"
 #include "dm_helpers.h"
 #include "dmub/inc/dmub_cmd.h"
+#include "inc/link_dpcd.h"
 
 #define DC_LOGGER \
 	link->ctx->logger
 
 enum dc_status dpcd_get_tunneling_device_data(struct dc_link *link)
 {
-	/** @todo Read corresponding DPCD region and update link caps. */
-	return DC_OK;
+	enum dc_status status = DC_OK;
+	uint8_t dpcd_dp_tun_data[3] = {0};
+	uint8_t dpcd_topology_data[DPCD_USB4_TOPOLOGY_ID_LEN] = {0};
+	uint8_t i = 0;
+
+	status = core_link_read_dpcd(link,
+			DP_TUNNELING_CAPABILITIES_SUPPORT,
+			dpcd_dp_tun_data,
+			sizeof(dpcd_dp_tun_data));
+
+	status = core_link_read_dpcd(link,
+			DP_USB4_ROUTER_TOPOLOGY_ID,
+			dpcd_topology_data,
+			sizeof(dpcd_topology_data));
+
+	link->dpcd_caps.usb4_dp_tun_info.dp_tun_cap.raw =
+			dpcd_dp_tun_data[DP_TUNNELING_CAPABILITIES_SUPPORT - DP_TUNNELING_CAPABILITIES_SUPPORT];
+	link->dpcd_caps.usb4_dp_tun_info.dpia_info.raw =
+			dpcd_dp_tun_data[DP_IN_ADAPTER_INFO - DP_TUNNELING_CAPABILITIES_SUPPORT];
+	link->dpcd_caps.usb4_dp_tun_info.usb4_driver_id =
+			dpcd_dp_tun_data[DP_USB4_DRIVER_ID - DP_TUNNELING_CAPABILITIES_SUPPORT];
+
+	for (i = 0; i < DPCD_USB4_TOPOLOGY_ID_LEN; i++)
+		link->dpcd_caps.usb4_dp_tun_info.usb4_topology_id[i] = dpcd_topology_data[i];
+
+	return status;
 }
 
 /* Configure link as prescribed in link_setting; set LTTPR mode; and
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 082706c921af..c6b5d4535cb4 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1187,6 +1187,7 @@ struct dpcd_caps {
 	struct dpcd_dsc_capabilities dsc_caps;
 	struct dc_lttpr_caps lttpr_caps;
 	struct psr_caps psr_caps;
+	struct dpcd_usb4_dp_tunneling_info usb4_dp_tun_info;
 
 #if defined(CONFIG_DRM_AMD_DC_DCN)
 	union dp_128b_132b_supported_link_rates dp_128b_132b_supported_link_rates;
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dp_types.h b/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
index a5e798b5da79..4f939578c739 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_dp_types.h
@@ -859,6 +859,37 @@ struct psr_caps {
 	bool psr_exit_link_training_required;
 };
 
+/* Length of router topology ID read from DPCD in bytes. */
+#define DPCD_USB4_TOPOLOGY_ID_LEN 5
+
+/* DPCD[0xE000D] DP_TUNNELING_CAPABILITIES SUPPORT register. */
+union dp_tun_cap_support {
+	struct {
+		uint8_t dp_tunneling :1;
+		uint8_t rsvd :5;
+		uint8_t panel_replay_tun_opt :1;
+		uint8_t dpia_bw_alloc :1;
+	} bits;
+	uint8_t raw;
+};
+
+/* DPCD[0xE000E] DP_IN_ADAPTER_INFO register. */
+union dpia_info {
+	struct {
+		uint8_t dpia_num :5;
+		uint8_t rsvd :3;
+	} bits;
+	uint8_t raw;
+};
+
+/* DP Tunneling over USB4 */
+struct dpcd_usb4_dp_tunneling_info {
+	union dp_tun_cap_support dp_tun_cap;
+	union dpia_info dpia_info;
+	uint8_t usb4_driver_id;
+	uint8_t usb4_topology_id[DPCD_USB4_TOPOLOGY_ID_LEN];
+};
+
 #if defined(CONFIG_DRM_AMD_DC_DCN)
 #define DP_MAIN_LINK_CHANNEL_CODING_CAP			0x006
 #define DP_SINK_VIDEO_FALLBACK_FORMATS			0x020
diff --git a/drivers/gpu/drm/amd/display/dc/inc/dc_link_dpia.h b/drivers/gpu/drm/amd/display/dc/inc/dc_link_dpia.h
index 76b6b1e23575..790b904e37e1 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/dc_link_dpia.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/dc_link_dpia.h
@@ -34,6 +34,13 @@ struct dc_link_settings;
 /* The approximate time (us) it takes to transmit 9 USB4 DP clock sync packets. */
 #define DPIA_CLK_SYNC_DELAY 16000
 
+/** @note Can remove once DP tunneling registers in upstream include/drm/drm_dp_helper.h */
+/* DPCD DP Tunneling over USB4 */
+#define DP_TUNNELING_CAPABILITIES_SUPPORT 0xe000d
+#define DP_IN_ADAPTER_INFO                0xe000e
+#define DP_USB4_DRIVER_ID                 0xe000f
+#define DP_USB4_ROUTER_TOPOLOGY_ID        0xe001b
+
 /* SET_CONFIG message types sent by driver. */
 enum dpia_set_config_type {
 	DPIA_SET_CFG_SET_LINK = 0x01,
-- 
2.25.1

