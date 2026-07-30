Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B38BC55162
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2026 17:17:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FD7B10F00B;
	Thu, 30 Jul 2026 17:17:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="i2IRtEFr";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010034.outbound.protection.outlook.com
 [52.101.193.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 666B010F00B
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jul 2026 17:17:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pQfhvemVf2qjWKscNtE8/GF9hxd8CUk8EIKUIRAPHu2tBgcvRjcILHtzS1CNr4PREg3TwBw8VhTMeVuag5Ti+e+GkFOdBMxnkJ17VOLEVG2GnBmmGm/9gN99o6PfldK+Ta3CO3wTxEPUgAd1VNgBTFzL3dH45dDTLEAnBSYELjPVodBcKiUdjM4k1lPTbQPczSIyWcays9/f5VIz/i25GaubyjnTdbgzbyq+A9hidxtJAKBEWGDKwn5AbUnX7GAWtO2MwAOExsXTxMpHLNkRz4MIyLiZCDgICKCbg8PE9Z0WaPwBmTGV2tdzNkMR05mK+ZchSN6WmIUTlYUO6bru+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6ceU3YbujD8zZNYFQ+Ccc9A8UtpizjSnBE0C52FIYSA=;
 b=GaeG1pZsrecfk1N1OlOIzT4huQGg63I6KUROfoCV949aFBujXUoeyQTkdJ7BfrqUvwCX2sqqoU5tTvbFiPAQY3SOc4+7wgG0irU3jkt87Eq/f/0Yea+VH2SZ3rcaQ6cwRxP9/Vnc8TbWFpzVqLTsXnWNksNBNrFezCkhZHGrUutkmcyAmkeM+Ew6x6qzTKqqg0jktvQ77E5N3mekwJWtUucvwGEo/5bDGTDycIm7Sjk8sDSn70LAwhd9WiSaOAJVlskZ9G7URzubAGno7bkJQ0j1DKnbAnvqRFJLaeUELVU6dTvPyrHGZw/zO04J0rej75g16hdS//8MpUDSGkX8NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ceU3YbujD8zZNYFQ+Ccc9A8UtpizjSnBE0C52FIYSA=;
 b=i2IRtEFrF/OtQyXv4VJWG9BJ6W6UioK5/e5CJDnhVskFRxVZjmflXEEz4cI8HD4dkX2h2h6a4kkUmLjkLqOQpHINKbFTbwRXDmDt3MxGaGuNIIdejOmSCIjc4qP+91jYfnrKc6zz5ESx6a2zXdCDUKwXk9T9Txkig7ZDpKuNAlg=
Received: from BN9PR03CA0211.namprd03.prod.outlook.com (2603:10b6:408:f8::6)
 by MN2PR12MB4093.namprd12.prod.outlook.com (2603:10b6:208:198::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Thu, 30 Jul
 2026 17:17:33 +0000
Received: from BN3PEPF0000B071.namprd04.prod.outlook.com
 (2603:10b6:408:f8:cafe::3a) by BN9PR03CA0211.outlook.office365.com
 (2603:10b6:408:f8::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.13 via Frontend Transport; Thu,
 30 Jul 2026 17:17:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B071.mail.protection.outlook.com (10.167.243.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Thu, 30 Jul 2026 17:17:33 +0000
Received: from jzuo.laptop (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 30 Jul
 2026 12:17:32 -0500
From: Fangzhi Zuo <jerry.zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <harry.wentland@amd.com>
CC: =?UTF-8?q?Tomasz=20Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>,
 Fangzhi Zuo <Jerry.Zuo@amd.com>, Bernhard Berger <bernhard.berger@gmail.com>
Subject: [PATCH 2/4] drm/edid: parse HDMI 2.1 gaming (ALLM/VRR) capabilities
 from HF-VSDB
Date: Thu, 30 Jul 2026 13:17:52 -0400
Message-ID: <20260730171754.704049-2-jerry.zuo@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260730171754.704049-1-jerry.zuo@amd.com>
References: <20260730171754.704049-1-jerry.zuo@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B071:EE_|MN2PR12MB4093:EE_
X-MS-Office365-Filtering-Correlation-Id: dde1bcee-b149-4b1a-d7a2-08deee5e71bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|23010399003|82310400026|1800799024|6133799003|56012099006|5023799004|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: QKhwIYdvazFovGME/Y9gUhwH7M7NjfOBMZfhiRrhklnA0HnGF269uyoBMPwiCoZfV/q1ixo887dolSMnjlkr/zO6QptcPaxALISbDM3vjiZjbaS7x1eHd9k9s/4w2xiEhKu61lhpJLY8Th9s3tgw6iC97zSEEN4y/QgMfIvauC525Myahot+g0kiinUf1hNCzYBGtUhNORCmxvevzJmPMvSdUU0uFogmWN3CXFl7/+yBjRl3hYDy2/1UdWBp3YHmEP0Wm3qJ9vSGEODTA7H0IYiWnfvVm9Te7uVmfMDBx4ANEZiH5J9pA1cNj7Eg/GyTG9FI32rydbdZmeD+VEKDIdh+ADVYeobzi3++N0xZoZczQBqvQEurXg0FAPSeZoXvJ4CzEFY/FpmQ69XfmKx4lgecCk6FnG8o+gFwYE9S2ChX7WVVJoivNntlS7KphH5g2QdNg00qgMt/9GhbGScDuL8YNqchNhHIAUJQW90nkZ6tNKAGdmjmSXNKwEQNXYQocV2MrZhWKvjCOBO7hK/Xpo+9E2omjRAlK64KSsH7A73EcIMBevpBbsqVvR8UyrCxiXzWCveb70hxJ3j9yWxUry/tpDIUfmWw09r6VncgATvLuUlQpT1i/+5Hysan3XMq9uZfx157V//GxQMd/rTHjUhq5r7S8YU1qprYZ3w01CSBip1FKEKAQJw4y98chE2N4eZv+hRsI6RsH8G5RxBo1g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(23010399003)(82310400026)(1800799024)(6133799003)(56012099006)(5023799004)(11063799006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: s/235MbmDCMiDgQq9L63VfQpnmUXQC2mR/75+qTGYYtc3B8qj3m/jWHWN/GhcPkhZZS1PS3tZ6MF4F8lxQVWqLacZuDvNPcXcuh8LoN5IjMCupAXP5K+d1/jskHm5V3PDR16O5Q/hvPOL9r7SclhMr4RqqlnvPRqc/am65GOoKrlLbwcTbkTck06ZRUFDqrChNOmTjfhLiD+mE0/EW/VaE1dWQBc3B6tWMJqJHb3oYx8gVI7SgGzkWx4GIPnvnSxcEB2+pZyVg+fcvPlcOVVcse/fDeH4thdapZtax2Gq+82JSDNTgeheYS/gWkut6qZO3okbxLGo3gqVCmJ4l4H6HouoyfjNZy7hHYELmrQjN3IGX2nXQCvdUR5ehZ4uVcIOhQBgG39bu6+a1z2eD4rn4TmZOhpjlatRgt3VzApLViyRMr+wrFQ2qGC5dYV3CXY
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 17:17:33.5236 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dde1bcee-b149-4b1a-d7a2-08deee5e71bb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B071.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4093
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

From: Tomasz Pakuła <tomasz.pakula.oficjalny@gmail.com>

Parse the HDMI 2.1 gaming-related capabilities advertised in the HDMI
Forum VSDB (HF-VSDB) and expose them through struct drm_hdmi_info so
drivers can consume them.

Add struct drm_hdmi_vrr_cap describing the sink's VRR capabilities: Fast
VActive (Quick Frame Transport), Negative M VRR, Cinema VRR, MDelta, and
the VRRmin/VRRmax range, together with a "supported" flag derived from
that range. Add the fapa_start_location and allm (Auto Low Latency Mode)
flags to struct drm_hdmi_info.

drm_parse_hdmi_gaming_info() reads byte 8 of the HF-VSDB for the
FAPA/ALLM/FVA/CNMVRR/CinemaVRR/MDelta flags and bytes 9-10 for
VRRmin/VRRmax. Per HDMI 2.1, VRR is considered supported when VRRmin is
within 1-48 and VRRmax is either 0 (maximum based on the video mode) or
>= 100. It is invoked from drm_parse_hdmi_forum_scds(), and the parsed
values are logged for debugging.

Signed-off-by: Fangzhi Zuo <Jerry.Zuo@amd.com>
Signed-off-by: Tomasz Pakuła <tomasz.pakula.oficjalny@gmail.com>
Tested-by: Bernhard Berger <bernhard.berger@gmail.com>
---
 drivers/gpu/drm/drm_edid.c  | 42 +++++++++++++++++++++++++++++++++
 include/drm/drm_connector.h | 47 +++++++++++++++++++++++++++++++++++++
 2 files changed, 89 insertions(+)

diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
index a9d480981c8f..7f810b08a091 100644
--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -6182,6 +6182,33 @@ static void drm_parse_ycbcr420_deep_color_info(struct drm_connector *connector,
 	hdmi->y420_dc_modes = dc_mask;
 }
 
+static void drm_parse_hdmi_gaming_info(struct drm_hdmi_info *hdmi, const u8 *db)
+{
+	struct drm_hdmi_vrr_cap *vrr = &hdmi->vrr_cap;
+
+	if (cea_db_payload_len(db) < 8)
+		return;
+
+	hdmi->fapa_start_location = db[8] & DRM_EDID_FAPA_START_LOCATION;
+	hdmi->allm = db[8] & DRM_EDID_ALLM;
+	vrr->fva = db[8] & DRM_EDID_FVA;
+	vrr->cnmvrr = db[8] & DRM_EDID_CNMVRR;
+	vrr->cinema_vrr = db[8] & DRM_EDID_CINEMA_VRR;
+	vrr->mdelta = db[8] & DRM_EDID_MDELTA;
+
+	if (cea_db_payload_len(db) < 9)
+		return;
+
+	vrr->vrr_min = db[9] & DRM_EDID_VRR_MIN_MASK;
+	vrr->supported = (vrr->vrr_min > 0 && vrr->vrr_min <= 48);
+
+	if (cea_db_payload_len(db) < 10)
+		return;
+
+	vrr->vrr_max = (db[9] & DRM_EDID_VRR_MAX_UPPER_MASK) << 2 | db[10];
+	vrr->supported &= (vrr->vrr_max == 0 || vrr->vrr_max >= 100);
+}
+
 static void drm_parse_dsc_info(struct drm_hdmi_dsc_cap *hdmi_dsc,
 			       const u8 *hf_scds)
 {
@@ -6308,6 +6335,8 @@ static void drm_parse_hdmi_forum_scds(struct drm_connector *connector,
 
 	drm_parse_ycbcr420_deep_color_info(connector, hf_scds);
 
+	drm_parse_hdmi_gaming_info(&connector->display_info.hdmi, hf_scds);
+
 	if (cea_db_payload_len(hf_scds) >= 11 && hf_scds[11]) {
 		drm_parse_dsc_info(hdmi_dsc, hf_scds);
 		dsc_support = true;
@@ -6317,6 +6346,19 @@ static void drm_parse_hdmi_forum_scds(struct drm_connector *connector,
 		    "[CONNECTOR:%d:%s] HF-VSDB: max TMDS clock: %d KHz, HDMI 2.1 support: %s, DSC 1.2 support: %s\n",
 		    connector->base.id, connector->name,
 		    max_tmds_clock, str_yes_no(max_frl_rate), str_yes_no(dsc_support));
+	drm_dbg_kms(connector->dev,
+		    "[CONNECTOR:%d:%s] FAPA in blanking: %s, ALLM support: %s, Fast Vactive support: %s\n",
+		    connector->base.id, connector->name, str_yes_no(hdmi->fapa_start_location),
+		    str_yes_no(hdmi->allm), str_yes_no(hdmi->vrr_cap.fva));
+	drm_dbg_kms(connector->dev,
+		    "[CONNECTOR:%d:%s] Negative M VRR support: %s, CinemaVRR support: %s, Mdelta: %d\n",
+		    connector->base.id, connector->name, str_yes_no(hdmi->vrr_cap.cnmvrr),
+		    str_yes_no(hdmi->vrr_cap.cinema_vrr), hdmi->vrr_cap.mdelta);
+	drm_dbg_kms(connector->dev,
+		    "[CONNECTOR:%d:%s] VRRmin: %u, VRRmax: %u, VRR supported: %s\n",
+		    connector->base.id, connector->name, hdmi->vrr_cap.vrr_min,
+		    hdmi->vrr_cap.vrr_max, str_yes_no(hdmi->vrr_cap.supported));
+
 }
 
 static void drm_parse_hdmi_deep_color_info(struct drm_connector *connector,
diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index 745cd917fe40..61ea6e866ea0 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -254,6 +254,44 @@ struct drm_scdc {
 	struct drm_scrambling scrambling;
 };
 
+/**
+ * struct drm_hdmi_vrr_cap - Information about VRR capabilities of a HDMI sink
+ *
+ * Describes the VRR support provided by HDMI 2.1 sink. The information is
+ * fetched fom additional HFVSDB blocks defined for HDMI 2.1.
+ */
+struct drm_hdmi_vrr_cap {
+	/** @fva: flag for Fast VActive (Quick Frame Transport) support */
+	bool fva;
+
+	/** @mcnmvrr: flag for Negative M VRR support */
+	bool cnmvrr;
+
+	/** @mcinema_vrr: flag for Cinema VRR support */
+	bool cinema_vrr;
+
+	/** @mdelta: flag for limited frame-to-frame compensation support */
+	bool mdelta;
+
+	/**
+	 * @vrr_min : minimum supported variable refresh rate in Hz.
+	 * Valid values only inide 1 - 48 range
+	 */
+	u16 vrr_min;
+
+	/**
+	 * @vrr_max : maximum supported variable refresh rate in Hz (optional).
+	 * Valid values are either 0 (max based on video mode) or >= 100
+	 */
+	u16 vrr_max;
+
+	/**
+	 * @supported: flag for vrr support based on checking for VRRmin and
+	 * VRRmax values having correct values.
+	 */
+	bool supported;
+};
+
 /**
  * struct drm_hdmi_dsc_cap - DSC capabilities of HDMI sink
  *
@@ -330,6 +368,15 @@ struct drm_hdmi_info {
 	/** @max_lanes: supported by sink */
 	u8 max_lanes;
 
+	/** @fapa_start_location: flag for the FAPA in blanking support */
+	bool fapa_start_location;
+
+	/** @allm: flag for Auto Low Latency Mode support by sink */
+	bool allm;
+
+	/** @vrr_cap: VRR capabilities of the sink */
+	struct drm_hdmi_vrr_cap vrr_cap;
+
 	/** @dsc_cap: DSC capabilities of the sink */
 	struct drm_hdmi_dsc_cap dsc_cap;
 };
-- 
2.53.0

