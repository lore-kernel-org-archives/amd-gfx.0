Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DB0CC3DA7F
	for <amd-gfx@archiver.kernel.org>; Thu, 15 Aug 2024 19:38:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A825F10E531;
	Thu, 15 Aug 2024 19:38:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qM90RoLC";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2041.outbound.protection.outlook.com [40.107.102.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67DF010E531
 for <amd-gfx@lists.freedesktop.org>; Thu, 15 Aug 2024 19:38:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M4M/D/0CDpqeNdGtJBgWz9uFKC7HwSvj7xPAqe5vJKMka0DpfdZ2GgasmexLrJIoOIuQUlyPLtq73yPXuLku5/VAlnji+n4EJXg2o610k1YBVpp2UyklyXo+DNcSmxAfbcstSSBiMBkcylgWQPB4u7QBjFa12RYPZyEZcSkcL3cddAdHAmCwC9bHPfpswYuw2NSmKo2clUJ99otpmJemlpAy59Nho8OzDyfOpDL98fkHoXNrUtOg4mRov7kD6Gj0vBz21WzqXXapG7578Ga4/bKCgV/hb98r+r0lkZ5zgcF9m3B5ulv2Acz6KAUaZOC5MA5mNBQWtLO6Zzk8IlvRuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YQHt99N/W6doXEUYuwjDvFfvW7ilL5DM/+WOw3qfD/8=;
 b=M+BiW5kolcPU8xQcbEupIIixHC6cHhev7wawRUxoxg6q9FOlhLHu0fHYZVuXfGAULdhMII21arNMRtK3BpLqlDisa4tAn00dPmImhLm44CunL2f2WR7bp6GLw8bve6eiCh+yclvCU+8BYmMT+PvzoxfOPW6DEiSnspu10VWMDc5l5ANhvzjHRd18/ubqSDdLwbbM4/Nudgqc3TTaMaB0YQo2Vt6/OpCjDb1h0dgQijqVhNXTUMdYy9pSM2eU11DZ5wpxpVwGxLXYfn2xIJDoKgBilCW9yN1mJlVHZ2aaYMtTCBnDwpX+m0mu9zMzEQDjdiPYGAl+2gikcvghqQHDBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YQHt99N/W6doXEUYuwjDvFfvW7ilL5DM/+WOw3qfD/8=;
 b=qM90RoLCMciqsIfMxaHH/tnE0G5uCqTGJnItL54RehrWTdgUCcQNzsTpxbjCO5I85I7Dq8Zy/DLDKw8iiekKC4a3fyD5eql47gifEIAmtU3uvwL3Cd5G/BOtMlrG+gpPk34b8mfUbLPI6zd8PsmWWndrLobL2asjyQfmiIkhPog=
Received: from BN9PR03CA0389.namprd03.prod.outlook.com (2603:10b6:408:f7::34)
 by BY5PR12MB4097.namprd12.prod.outlook.com (2603:10b6:a03:213::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.18; Thu, 15 Aug
 2024 19:38:02 +0000
Received: from BN2PEPF00004FBF.namprd04.prod.outlook.com
 (2603:10b6:408:f7:cafe::8d) by BN9PR03CA0389.outlook.office365.com
 (2603:10b6:408:f7::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.33 via Frontend
 Transport; Thu, 15 Aug 2024 19:38:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF00004FBF.mail.protection.outlook.com (10.167.243.185) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Thu, 15 Aug 2024 19:38:01 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 15 Aug
 2024 14:38:00 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>, Alex Hung <alex.hung@amd.com>, Mario Limonciello
 <mario.limonciello@amd.com>, Wayne Lin <Wayne.Lin@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>
Subject: [PATCH v3] drm/amd/display: use drm_crtc_vblank_on_config()
Date: Thu, 15 Aug 2024 15:37:27 -0400
Message-ID: <20240815193727.294435-1-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBF:EE_|BY5PR12MB4097:EE_
X-MS-Office365-Filtering-Correlation-Id: 08feda9a-3bf5-4a42-9bbd-08dcbd61c672
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Bi/1z1PWSB6kWuH3n3h8Ug5F3m/gTisu4dVnefJdGMWPHIitAibr5YwLK+xt?=
 =?us-ascii?Q?kFEZeXggwJFDgmuezhB4XQq+TyyIlhoIC7bXDOLYHXxFRg4Ah/0qsD+IoWU+?=
 =?us-ascii?Q?i0DY0B6K00jYL2vqOJ9ulXysRzohHLU65tzrO55fF1W45X1XEzgQHdUDrK/9?=
 =?us-ascii?Q?lyWv7xz4BN71Zn+kpQrGu33b/cBCHc2LC4GyD86EhjZHOhZcr/pPprpqr4qg?=
 =?us-ascii?Q?nifSaiis9/QOZKQIMfru31dyYirp6qDXG1hLpHkfB90r/GlMBWvZzqCK08dG?=
 =?us-ascii?Q?keJBnNLi31RJICrbceCj/37dQ99V2EWUXAw5g0VHCreExJ5h9v5ntiwZybVh?=
 =?us-ascii?Q?v89nkd7Zp4PCbOkMEtPusWkdnnyoXAfj47JApBCYKCz86OF+RNZgPcukKzLi?=
 =?us-ascii?Q?X9gCMeRsQJP7UdsfQFBYC12WIslpXBDXN6kw9bBf5yP9h8e1OhOBFTFaKJUC?=
 =?us-ascii?Q?UMMIbEknqIPXF99TZ8I9M5S1HRDCpd4Z7TX7DdZ7zQB5NIcFnJLsmFzL7dJZ?=
 =?us-ascii?Q?zjwnJGaKCBfxVDHnkX11y4RVXOG6plIZsN0GwwguRWwrsHPky/ZCWTz0go78?=
 =?us-ascii?Q?7mbhuCH73jmG4bs1jOoNQCeYdbJXTNbxzulAtaAg2OQZNVl9+HwThMe+BSDT?=
 =?us-ascii?Q?PmJAGPo8ekvONwD4Uf2bbERGYw8b8TkZ9rfFBo18lAmoI0NpONSPNtXRGret?=
 =?us-ascii?Q?g2WG48Cmp+/qm4EBdEeNl7AhWSpxm/lZl8t2I6Zhqq9F2ZWoZ9qDjyZdOSWv?=
 =?us-ascii?Q?w4bGu63Wy4ZPErEUtOiKDJJRtF2JNQAyedF39j1A2PE8ihAenD5+c7hjJGcf?=
 =?us-ascii?Q?uIEpeOkaOJF4Duu5incto2NrtxyOJBwa7TTOj6z8rWY9XTgjOuIv45jQJ94f?=
 =?us-ascii?Q?mgz/FRuzd0bGUuvfvGyroD1NuW0x58CmZFVLQ5cmKxcfJs9RQReLGXuEM6/K?=
 =?us-ascii?Q?2v5dLyJR1hjVPKoqujfMCllFMf3em1TFyM28ozndid2njQ7P1Rt5vZDHUmJO?=
 =?us-ascii?Q?AgPPeFDpGvrR90+a2eX0Itr6nogdTfMYPMW8m72w0+hoR2q0YlsaOuQxE7it?=
 =?us-ascii?Q?IvmIs6YDHw6PRXhTLfjtwi0YN2KmWiFvQ6COhmUKpvQKoDA3cjRmQynBqgaz?=
 =?us-ascii?Q?Ni0IyS9uWEQ3sFCUuX1H4ZV2mlCoZCbL6iLIQOTpR+lpZNaeA/AX8iO7hnEX?=
 =?us-ascii?Q?cLfN/J1J63LeEo/xwW+8zeCQ6GUkyYOuTUcbFbRBDc6eTCw3AhaXjUtI9qJR?=
 =?us-ascii?Q?KINIGlCbxAyKJAL/9fhZodLpDII3AABwudqum8N5VnPMosrMoLrvOzqykT2p?=
 =?us-ascii?Q?OPThitIoOdcAW9rwn0mXI9/Fha3OU8i5eQ2nEacx8K5HysGleReR69D6r73M?=
 =?us-ascii?Q?RfOgyFUJOaCvGXGH5Nqd7bO9ZL5oS9TwzNCYMs8bZKSUO7xybU//muYMLhIM?=
 =?us-ascii?Q?L98Uu6O442ddBKahwcjk0MMZj4jpQyz2?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 19:38:01.8019 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08feda9a-3bf5-4a42-9bbd-08dcbd61c672
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FBF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4097
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

Hook up drm_crtc_vblank_on_config() in amdgpu_dm. So, that we can enable
PSR and other static screen optimizations more quickly, while avoiding
stuttering issues that are accompanied by the following dmesg error:

[drm:dc_dmub_srv_wait_idle [amdgpu]] *ERROR* Error waiting for DMUB idle: status=3

This also allows us to mimic how vblanking is handled by the windows
amdgpu driver.

Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
---
v3: use a less conservative policy
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 38 ++++++++++++++++---
 1 file changed, 33 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 7e7929f24ae4..b8f57b466c35 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -8232,7 +8232,7 @@ static int amdgpu_dm_encoder_init(struct drm_device *dev,
 
 static void manage_dm_interrupts(struct amdgpu_device *adev,
 				 struct amdgpu_crtc *acrtc,
-				 bool enable)
+				 struct dm_crtc_state *acrtc_state)
 {
 	/*
 	 * We have no guarantee that the frontend index maps to the same
@@ -8244,9 +8244,36 @@ static void manage_dm_interrupts(struct amdgpu_device *adev,
 		amdgpu_display_crtc_idx_to_irq_type(
 			adev,
 			acrtc->crtc_id);
+	struct drm_vblank_crtc_config config = {0};
+	struct dc_crtc_timing *timing;
+	int vsync_rate_hz;
+	int offdelay = 30;
+
+	if (acrtc_state) {
+		timing = &acrtc_state->stream->timing;
+
+		vsync_rate_hz = div64_u64(div64_u64((timing->pix_clk_100hz *
+						     (u64)100),
+						    timing->v_total),
+					  timing->h_total);
+
+		if (amdgpu_ip_version(adev, DCE_HWIP, 0) <
+		    IP_VERSION(3, 5, 0) ||
+		    acrtc_state->stream->link->psr_settings.psr_version <
+		    DC_PSR_VERSION_UNSUPPORTED) {
+			if (vsync_rate_hz)
+				/* at least 2 frames */
+				offdelay = 2000 / vsync_rate_hz + 1;
+
+			config.offdelay_ms = offdelay;
+			drm_crtc_vblank_on_config(&acrtc->base,
+						  &config);
+		} else {
+			config.disable_immediate = true;
+			drm_crtc_vblank_on_config(&acrtc->base,
+						  &config);
+		}
 
-	if (enable) {
-		drm_crtc_vblank_on(&acrtc->base);
 		amdgpu_irq_get(
 			adev,
 			&adev->pageflip_irq,
@@ -9320,7 +9347,7 @@ static void amdgpu_dm_commit_streams(struct drm_atomic_state *state,
 		if (old_crtc_state->active &&
 		    (!new_crtc_state->active ||
 		     drm_atomic_crtc_needs_modeset(new_crtc_state))) {
-			manage_dm_interrupts(adev, acrtc, false);
+			manage_dm_interrupts(adev, acrtc, NULL);
 			dc_stream_release(dm_old_crtc_state->stream);
 		}
 	}
@@ -9835,7 +9862,8 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 		     drm_atomic_crtc_needs_modeset(new_crtc_state))) {
 			dc_stream_retain(dm_new_crtc_state->stream);
 			acrtc->dm_irq_params.stream = dm_new_crtc_state->stream;
-			manage_dm_interrupts(adev, acrtc, true);
+			manage_dm_interrupts(adev, acrtc,
+					     to_dm_crtc_state(new_crtc_state));
 		}
 		/* Handle vrr on->off / off->on transitions */
 		amdgpu_dm_handle_vrr_transition(dm_old_crtc_state, dm_new_crtc_state);
-- 
2.46.0

