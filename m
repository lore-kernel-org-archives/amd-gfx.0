Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AFD6C55174
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jul 2026 21:16:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B303910F41D;
	Fri, 31 Jul 2026 21:16:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NyA0NG2i";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011031.outbound.protection.outlook.com [52.101.57.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1C7410F41D
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jul 2026 21:16:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L4NDJovVTdcrFE3pUuIhCWb83dqfcA9KtX/jWrkBDyJWac379X5wIN4jgzXjx3Unr2+dNVqvC7328wme9/FdpxAld+yDUaAdjFYfj2eLDuLGbGMq4yH25IwIG7AgxdR+71i7RpQ0q0Km70O2bNqc8t8kwJNuqxoPZ3x1wYP7dcvreENPghfInVgwr5qpjW9WyMAFVxB7pt0KwudthhrPxVZGn0yDZ3ZPdfPg0Qwdt83tRC4A3K3qITuX1c6G5fuyW+s69/rhr9EMB/NwyYeNC8ovxu32Nejlllnyqj0k1pvIxI/XYTZcHXzmTKYygSzoHXrHZXftu6nQzFepJeFBbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xj7oa45ivg7hPm5jBEckQKmvp+JrhWyH7wHHZp3oFeE=;
 b=I9hZlXCJYCE0c5lTgtHuGMIFEJb5KApkikTBpttmrc571qU10EDmB8Grfh9QccxaiYYM6QjfIFjXQ8tC8bVkatRXhFga9r8InodSVwN5x/iYE4YnJhVjOB0N/uq5INHk7WssxPq6GR57olEqBSRRfSvEWnOTKk5y7dKpJKXFmRyIcAOD6OwPXM6Xp56FUgTs5oxdTuSKM6TQZg/9LMhud23ff11Hf1WiDbz5zBl57NxJdtfoMvnEiO9C0W6mmNSbxK7tgrGyeZ2IOsDwIHHsdQgbzInEPG7NCyz4HBiYKXDGZP7Kt4GUQtVDRUGifiQhzJtFpFGMUcFBlBVE+BlX0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xj7oa45ivg7hPm5jBEckQKmvp+JrhWyH7wHHZp3oFeE=;
 b=NyA0NG2iI1IQjShVrZf0Jbi1G8W6uTahtmxTuG83d8n8SsyuWhkH1VXDOlDgWH4ARZMgRa3NggRP7rJXOiDjJxV7O56RBVHN+eNVUXu3E2CX/Ayv3FPx7ZdL35CnsXqn2ejqwnK+L8QWj/HAHnf3JpE0rJAZeEhunLj1Ml49OEw=
Received: from BN9PR03CA0265.namprd03.prod.outlook.com (2603:10b6:408:ff::30)
 by PH0PR12MB7472.namprd12.prod.outlook.com (2603:10b6:510:1e9::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.16; Fri, 31 Jul
 2026 21:16:18 +0000
Received: from BL02EPF00021F6E.namprd02.prod.outlook.com
 (2603:10b6:408:ff:cafe::2f) by BN9PR03CA0265.outlook.office365.com
 (2603:10b6:408:ff::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.16 via Frontend Transport; Fri,
 31 Jul 2026 21:16:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F6E.mail.protection.outlook.com (10.167.249.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Fri, 31 Jul 2026 21:16:18 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 31 Jul
 2026 16:16:18 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 31 Jul
 2026 16:16:18 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Fri, 31 Jul 2026 16:16:12 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Wayne Lin <Wayne.Lin@amd.com>
Subject: [PATCH 35/41] drm/amd/display: Configure all CRC engines in pipe CRC
 source path
Date: Fri, 31 Jul 2026 17:12:56 -0400
Message-ID: <20260731211302.3040343-36-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260731211302.3040343-1-Roman.Li@amd.com>
References: <20260731211302.3040343-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6E:EE_|PH0PR12MB7472:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f5ecc44-5377-4322-2826-08deef48f698
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|23010399003|36860700016|376014|22082099003|18002099003|11063799006|56012099006|3023799007|10067099003;
X-Microsoft-Antispam-Message-Info: uUvEcfwCy73lwvOv+Ic6XaKT+qimFTAF1ocABYnPQSVuk6yKcTQ8ubTkXGvO2xUNLt5H9Yi1BOq79i2BbkNaEcEOvtCC1CwbXZXQHq8hn3Zh9toBF1YuzbnjvRZV4yX/11iVBoK6dSKjIK97boJVZOupBNExYiUlKlCMUuNCj1YBNxWj/RAw6BMQW2W8TxgNT+oOQFflh1IU7at02bccMRfvFQwl0dlyMSwnE9FeQnK6TjDRYFAvL8E1IZXJvhcFTseikYEpJy4Fp07ueKPLRNsxh2+KIMUYOB9OyevYHjQW4jBgdPXgmA/cnDN68ao0tKUob0sBUU0LoOc1IJlp5Xezqz8Daf7FSxXnNS/CjpnOkViWnGzw2ssGcp9uRCY99JU0RRrXWkvu9+FE5rReFMEH2+TDF/BjlaLjgmaeLd+CP/FuzQNODZe5rvvU8N8dl49xhOkbZskPbRBu8RwXonmZWIQsWAOStofdYaQzaObS40QQmG6y3+pKLAmTfECCJXFYIpPNHcKZ3ljGmtbPKFAdQjgDJ0gg0vHWJYzzr4MIiA62AnsXlrO3o0HXFulmFgm3OtkdgDFyoitG8oMKx8gK68TUk617IeB2k+dHTLjM5yosmn1NUsUa2oK8gKW4DMJNhg4SbH3ogH82LdflzpjgVjf58qub6WhIrhYojmVotmjeph69I6o90wIr0XR8DM/Ypl4gKsPnacdcrc7TuA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(23010399003)(36860700016)(376014)(22082099003)(18002099003)(11063799006)(56012099006)(3023799007)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: gDK4ouh1fPF3+9J2RVJRjNXl93byh7C8ywpp7F84NUOoNBB5QKPMMRVvruBpzb0ddhMom9Dbjd9ku/IuqvBas3aZZt5td2AwDoNIivVfFafJ6sjBjk1r+vfIxBf7JxZ5dZ+3xUSgjPVhf30ojoTtMUiR+FFpoY0WA2ONZsgAEp/36vu6tF3QjBZjQ7ujVemYmLsi1IX6SkbQPhiHzKjtM7fFcP0hkavJ4YuDX0GHV4oBGIqy8hMjQJ4+Oyd8VuCAbxSLiUD7kZmhWnHjdjaSVki6YuXvTpj+ahwHifA1/1Oq8H8P0YMLomVSEG9mrpzL0/A97cT/Lh79r9lfzAFFQUMw40cNrpEyqHEFrUOwvTMP4neNrxAOf0FrzXznqdgttMCnPnCpG9Mm5Z4yy5t2XsGec9gQFM8I1S1YrC9zRad9vvslgRuulTtK4Ai4zapa
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 21:16:18.6569 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f5ecc44-5377-4322-2826-08deef48f698
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7472
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

Iterate every CRC engine instance when enabling or disabling the pipe CRC
source so DCN31x OTG_CRC1_EN is handled alongside OTG_CRC_EN, matching the
legacy shared enable behavior used by DisplayCRC multi-ROI.

Reviewed-by: ChiaHsuan (Tom) Chung <chiahsuan.chung@amd.com>
Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c   | 13 +++++++++----
 drivers/gpu/drm/amd/display/dc/dc_types.h           |  3 ++-
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
index 05387bedf24a..db546dd44b91 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crc.c
@@ -604,10 +604,15 @@ int amdgpu_dm_crtc_configure_crc_source(struct drm_crtc *crtc,
 
 	/* Enable or disable CRTC CRC generation */
 	if (dm_is_crc_source_crtc(source) || source == AMDGPU_DM_PIPE_CRC_SOURCE_NONE) {
-		if (!dc_stream_configure_crc(stream_state->ctx->dc,
-					     stream_state, NULL, enable, enable, 0, true, crc_poly_mode)) {
-			ret = -EINVAL;
-			goto unlock;
+		int i;
+
+		for (i = 0; i < MAX_CRC_WINDOW_NUM; i++) {
+			if (!dc_stream_configure_crc(stream_state->ctx->dc,
+						     stream_state, NULL, enable, enable,
+						     i, true, crc_poly_mode)) {
+				ret = -EINVAL;
+				goto unlock;
+			}
 		}
 	}
 
diff --git a/drivers/gpu/drm/amd/display/dc/dc_types.h b/drivers/gpu/drm/amd/display/dc/dc_types.h
index b14d882e08d4..7da673111ed9 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_types.h
@@ -1045,9 +1045,10 @@ enum backlight_control_type {
 	BACKLIGHT_CONTROL_AMD_AUX = 2,
 };
 
-#if defined(CONFIG_DRM_AMD_SECURE_DISPLAY)
 #define MAX_CRC_WINDOW_NUM	2
 
+#if defined(CONFIG_DRM_AMD_SECURE_DISPLAY)
+
 struct otg_phy_mux {
 	uint8_t phy_output_num;
 	uint8_t otg_output_num;
-- 
2.34.1

