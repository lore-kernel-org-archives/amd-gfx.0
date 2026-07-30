Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4269C55164
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2026 17:17:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3AC0510F011;
	Thu, 30 Jul 2026 17:17:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zZ4g3AbB";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012070.outbound.protection.outlook.com
 [40.93.195.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BFD0A10F010
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jul 2026 17:17:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kfo4M2XAxQ8MMLwtEgN3iDfFdPN5LmYsEtU0QGHwbEeLtJLgeoaIFGUvl4LJfBXtlfTMGBnlXrzBC1nfHtVZkjje53pisN18k17AvWk3ZHiJi0PwJt/a1RzzR6+RbOqlvxPnQ6KE/c5Q4XjcBCFH9bAUhr3EfRleJNE7dMZX06/ZSUz+JeJ6yrVuMTlNf7s5wWKvRajYlawWD2JQAOGKH6wmMiqNygl+Fb9tdr7B1mVNHsKiG3YlP2XjjGsblmP5vxLSmgmZKXt+zmliWCKhxJ4DH9zTLEvLvIVwvc9l6/YO28+3gUlPkdHtoxwkEX5CAMSxK0joezfZPKl9ZW05eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kejghn4P5nKKuwXr8S+xy3yxAQ33yale2RAbu2gQHGo=;
 b=pBarBMCHWmveHjs5TXRpBLkp0k9si828/6TdOWazn9gWYZ0R6CySYEtHqzV1Vcg2IoI719oDdUFIu+7GaKQ5sBTlDrFHTFYD9FV5rIovEMmoLMVMhS+91hLiHT4IzJdSE0U7hnZujcZgcKk1Dqg6kCrmgqljwltHVa6/Gd/9AcsZq1cDWO0TedvKY2+j2FTBas1dOE51H5UeWcjBBAPGMU5HfScoChRG/2NrdsGh5MSeSJ2C5GXWdtYyda1XUiXmzWzuoXXW6a2X9uYdCrzjkwrSwepFr5YRS8yiKsx79DocFvtsg6xRKAB1DXY2Iauk5GcWosaZ+Lge5ur4FM/zKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kejghn4P5nKKuwXr8S+xy3yxAQ33yale2RAbu2gQHGo=;
 b=zZ4g3AbBWgDuHsKGgsQvNKz7v9ty9YJ38fTcABpJEdMf/HTHRG18H6R2qUOXBSl2jbNFPfM64ukPn3mJJZiAoCQf+E+C5YGq2ZJkCwpsmO6852ldmKI59ORF56A6fYLcBe/H+ZK9pKKEH4BwkhLJ2WRCEBb1UemD25/OO1tWbNA=
Received: from BN9PR03CA0220.namprd03.prod.outlook.com (2603:10b6:408:f8::15)
 by DS0PR12MB8454.namprd12.prod.outlook.com (2603:10b6:8:15e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.14; Thu, 30 Jul
 2026 17:17:34 +0000
Received: from BN3PEPF0000B071.namprd04.prod.outlook.com
 (2603:10b6:408:f8:cafe::39) by BN9PR03CA0220.outlook.office365.com
 (2603:10b6:408:f8::15) with Microsoft SMTP Server (version=TLS1_3,
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
CC: Fangzhi Zuo <jerry.zuo@amd.com>, Fangzhi Zuo <Jerry.Zuo@amd.com>
Subject: [PATCH 3/4] drm/amd/display: Add HDMI 2.1 VRR support from HF-VSDB
Date: Thu, 30 Jul 2026 13:17:53 -0400
Message-ID: <20260730171754.704049-3-jerry.zuo@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260730171754.704049-1-jerry.zuo@amd.com>
References: <20260730171754.704049-1-jerry.zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B071:EE_|DS0PR12MB8454:EE_
X-MS-Office365-Filtering-Correlation-Id: 63747c0b-feb7-4df7-7b50-08deee5e71e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|23010399003|1800799024|82310400026|6133799003|11063799006|5023799004|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: nDLYZPAxdI+KdjtlWAzKyWn73mwDVUlRiUCTYiZcGVHYMlKzzmlzb0cWw+K748Fnv4swrgEG6Z8U+P4+r2sq6CRN74sNnalXLu9AB4uX/K8vcLJoIfSda7AsXvhOVBRDbYloLL7iuLLtlSC7+qZI3wwnBOOz5nqTdo1S5Ws1mgUKaNB0saL0QMlheX9nPj3+6cpK438mItkd+V6a4R8NIHuN6FDn3etjIqVy8Y6TpHpagCtPdvD9EwXVUPbh4wJAMI8xcUf1dyHXyqn7cDvEiCuNQTU6mRF5FdZmtpzrnV6Fgk5IUL1EUzsaqVSqofYjtXRayz/P61IcZXQq6Md9NDPwROPTOxQy66fb8UniJuy846kLwtInHyZz8i6sBXXMDUarRRjETv4gnbb9pb+dKByNfgHYXbb+zfPgO7iv5IVocJH2nUu7VPzKpG1qPJ8bcACsVhrX+rUprEsUGMGJ3LapnzozafM2e+iP2fVsmJ8BCuS+iiJUI4a0xxbNYNmdToR7Y39CQeqCaYuZXT08WnWnR4KSlm3mpcskQTig0+gZDvFO+BUFgwT4FGidyve961PIUlW7dFSwI03GL3FupJkEqbAdafTmQx98QbeEq7SmzYGC0+L+1+iogNtPTzgRKzQyYmgLm7zIq9R3GEVBQ5sbG/h21KXRcl7jaF+Qp2xPJ85qpQj3hm9Fs0erY02jgofNRBfnCgaRJxquPbaXww==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(23010399003)(1800799024)(82310400026)(6133799003)(11063799006)(5023799004)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: UDkT8RNdl+XT7PSOLdbW4Wg/PIrv0Bi4masFepVd9DKHDQsb20TCV/YCQviyJP8DgHxSIiDTUyO+4reFa9xkPftYyeu6jzYT+AkfUda26MYl/Bxqnpk61ZTbOSO3f3HO9fQLMAndmIoZLX+NirOvnKiIF94SqM7GdAXuvmHNwBlvsCpkLamHWkvtiqt1U2MIWvRMvjyUiKOXYMyoZRgXyxaIRFOlCnZhDmzy/G3o6UmcDRnf+n/c/WbCr4UzvTQOIV7NuD13pYaEwnyj57Q9K0W6IHBPuGa8hTu5v4W3+iII1ljEYe+PPCWfgD12d39oP34fxS0Vzt1LLyeb9ip9h3aDsjuIedDgSTtj2UH/BUgwmOribVEyryNFt0qMfAeU3gcood8dEDh2YrwTk80xt4NsPEcVeGkO3mNcDzcASuVo+Ns797DrF+rg5JXGEX8X
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 17:17:33.8171 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63747c0b-feb7-4df7-7b50-08deee5e71e8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B071.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8454
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

why:
HDMI 2.1 sinks advertise their VRR range in the HDMI Forum VSDB
(HF-VSDB), but amdgpu derived FreeSync capability only from the AMD
VSDB. Sinks that expose just the HDMI Forum VRR capability (e.g. HDMI
compliance EDIDs) were therefore reported as not VRR capable.

how:
- In amdgpu_dm_update_freesync_caps(), when the AMD VSDB does not
  provide a valid FreeSync range, fall back to the HDMI 2.1 VRR range
  parsed by DRM core from the HF-VSDB
  (connector->display_info.hdmi.vrr_cap). VRRMAX = 0 means "up to the
  Base Refresh Rate"; when the EDID provides no monitor range maximum
  either, fall back to the Base Refresh Rate (the highest refresh-rate
  mode of the preferred timing) so a valid VRR range is still reported
  to userspace.
- Add VRR debug logging along the FreeSync capability and config paths.

Signed-off-by: Fangzhi Zuo <Jerry.Zuo@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  8 +++
 .../display/amdgpu_dm/amdgpu_dm_connector.c   | 67 +++++++++++++++++++
 2 files changed, 75 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index ccf882a22a57..223b562f7005 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -5781,6 +5781,14 @@ STATIC_IFN_KUNIT void get_freesync_config_for_crtc(
 	}
 out:
 	new_crtc_state->freesync_config = config;
+
+	drm_dbg_driver(new_con_state->base.connector->dev,
+		       "VRR: cfg vrr_enabled=%d vrr_supported=%d fs_capable=%d vrefresh=%d min=%d max=%d state=%d\n",
+		       new_crtc_state->base.vrr_enabled,
+		       new_crtc_state->vrr_supported,
+		       new_con_state->freesync_capable, vrefresh,
+		       aconnector->min_vfreq, aconnector->max_vfreq,
+		       config.state);
 }
 EXPORT_IF_KUNIT(get_freesync_config_for_crtc);
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
index 2deb5abae264..ebead39939a6 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
@@ -3605,6 +3605,15 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
 	if (!adev->dm.freesync_module || !dc_supports_vrr(sink->ctx->dce_version))
 		goto update;
 
+	drm_dbg_driver(adev_to_drm(adev),
+		       "VRR: enter signal=%d hdmi_vrr=%d mrange[%d-%d] hdmi.vrr_cap[sup=%d min=%d max=%d]\n",
+		       sink->sink_signal, connector->display_info.hdmi.vrr_cap.supported,
+		       connector->display_info.monitor_range.min_vfreq,
+		       connector->display_info.monitor_range.max_vfreq,
+		       connector->display_info.hdmi.vrr_cap.supported,
+		       connector->display_info.hdmi.vrr_cap.vrr_min,
+		       connector->display_info.hdmi.vrr_cap.vrr_max);
+
 	/* FIXME: Get rid of drm_edid_raw() */
 	edid = drm_edid_raw(drm_edid);
 
@@ -3649,6 +3658,59 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
 				connector->display_info.monitor_range.max_vfreq = vsdb_info.max_refresh_rate_hz;
 			}
 		}
+
+		drm_dbg_driver(adev_to_drm(adev),
+			       "VRR: amd_vsdb i=%d fs_sup=%d min=%d max=%d fs_capable=%d\n",
+			       i, vsdb_info.freesync_supported,
+			       vsdb_info.min_refresh_rate_hz,
+			       vsdb_info.max_refresh_rate_hz, freesync_capable);
+
+		/*
+		 * If AMD VSDB didn't provide a valid FreeSync range, fall back to
+		 * the HDMI 2.1 VRR capability parsed from the HF-VSDB.
+		 */
+		if (!freesync_capable && connector->display_info.hdmi.vrr_cap.supported) {
+			struct drm_hdmi_vrr_cap *vrr_cap =
+				&connector->display_info.hdmi.vrr_cap;
+
+			drm_dbg_driver(adev_to_drm(adev),
+				       "VRR: HF-VSDB fallback: hdmi_vrr=1 vrr_cap[sup=%d min=%d max=%d] mrange_max=%d\n",
+				       vrr_cap->supported, vrr_cap->vrr_min, vrr_cap->vrr_max,
+				       connector->display_info.monitor_range.max_vfreq);
+
+			if (vrr_cap->supported && vrr_cap->vrr_min > 0) {
+				amdgpu_dm_connector->min_vfreq = vrr_cap->vrr_min;
+				amdgpu_dm_connector->max_vfreq = vrr_cap->vrr_max ?
+					vrr_cap->vrr_max :
+					connector->display_info.monitor_range.max_vfreq;
+
+				/*
+				 * VRRMAX = 0 in the HF-VSDB means "up to the Base
+				 * Refresh Rate". If the EDID also did not provide a
+				 * monitor range max, fall back to the Base Refresh
+				 * Rate (the highest refresh rate of the preferred
+				 * timing) so a valid VRR range is still reported to
+				 * userspace.
+				 */
+				if (!amdgpu_dm_connector->max_vfreq) {
+					struct drm_display_mode *brr_mode =
+						amdgpu_dm_get_highest_refresh_rate_mode(amdgpu_dm_connector, true);
+
+					if (brr_mode)
+						amdgpu_dm_connector->max_vfreq =
+							drm_mode_vrefresh(brr_mode);
+				}
+
+				if (amdgpu_dm_connector->max_vfreq -
+				    amdgpu_dm_connector->min_vfreq > 10)
+					freesync_capable = true;
+
+				connector->display_info.monitor_range.min_vfreq =
+					amdgpu_dm_connector->min_vfreq;
+				connector->display_info.monitor_range.max_vfreq =
+					amdgpu_dm_connector->max_vfreq;
+			}
+		}
 	}
 
 	if (amdgpu_dm_connector->dc_link)
@@ -3692,6 +3754,11 @@ void amdgpu_dm_update_freesync_caps(struct drm_connector *connector,
 	if (dm_con_state)
 		dm_con_state->freesync_capable = freesync_capable;
 
+	drm_dbg_driver(adev_to_drm(adev),
+		       "VRR: caps result: freesync_capable=%d min_vfreq=%d max_vfreq=%d\n",
+		       freesync_capable, amdgpu_dm_connector->min_vfreq,
+		       amdgpu_dm_connector->max_vfreq);
+
 	if (connector->state && amdgpu_dm_connector->dc_link && !freesync_capable &&
 	    amdgpu_dm_connector->dc_link->replay_settings.config.replay_supported) {
 		amdgpu_dm_connector->dc_link->replay_settings.config.replay_supported = false;
-- 
2.53.0

