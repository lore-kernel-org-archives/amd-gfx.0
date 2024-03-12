Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13B08C54E5D
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Mar 2024 15:24:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8DBB5112401;
	Tue, 12 Mar 2024 15:24:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="chcMDwsn";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2052.outbound.protection.outlook.com [40.107.244.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 324D7112401
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Mar 2024 15:24:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ec7pDWBb3PR04MrGOSP6bvX3slUQ5in+bPI3eaWmXgyHQvqei1NTaaJwyRiY1zomfH3OeZKj9p+AImLuF8hz2KOyUUNbc41mD1tVsVs+qsQ6BOKFRSK8yzECtlsDHkMlIe0lcW3pxP6esPkVouGK+qzN+mvSb6807EhKQ6JCmf2Jz0ob0DCECcOn+sEE19JsMfNYFCr8+w9KHtPcHGe94y6OoIUthLTzXMYZvZn4nlW8FkM0O492Ry5JunwxkE39IxpCbDUaCma8h8IaLx4tgYR30KgTh2NOViav4tp54C93HjZ4VkVqVJjsorQWafEecm9lixeKI8UXV+XqjC2lzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2S0dOsZcJrShJFsxrXH16MKEisKz5VXxd3EegTXbjwg=;
 b=CS4eypr+8GNpRr0h26wCz5vnin4RtrtYZnLzz4HqwckNkNc2k+A52mjIrpsAthrCrYMnBg60xq+0F111iDSD+7w1gemUXmbwEKYEV+4kiKUPKzU2DyBZlwSd5Gw+kNxApdExF0gcOcI2ApyDQJnNHh1+Nhyy3pUa4StNRf0TwaP45LZ7yRpY+HqfQ+T5oPzloihWeLi2YSfQ75dWKb21rVkUnM2xnxXwzRU97N/l5LUYL19q3ar7Nn99hOnX42vwBqoGKF7MnqUfg4I/qYRASyZOv0y4VLRgi3HFGoSFk2bYHXS/8SOfGMfYElzJant1QT1KpPLf8vwW9eBFGpiQig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2S0dOsZcJrShJFsxrXH16MKEisKz5VXxd3EegTXbjwg=;
 b=chcMDwsnDOP/oRWXP3nYfKxf2LA0njBZgtkuTsOqwj2H3VjDjVr08TcvNUjNTs4VG+O0FoXLYIscrp2SY6UhO5kZW/rsPyFz9Xq8kreEA0T4LB06LykUD+kfl6w3jeB6gZc+k6v135PN55Il/S0tUZiiq0X06ja4cwlXu5b+yIk=
Received: from CH2PR18CA0025.namprd18.prod.outlook.com (2603:10b6:610:4f::35)
 by SA3PR12MB7974.namprd12.prod.outlook.com (2603:10b6:806:307::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.18; Tue, 12 Mar
 2024 15:24:29 +0000
Received: from CH2PEPF00000140.namprd02.prod.outlook.com
 (2603:10b6:610:4f:cafe::78) by CH2PR18CA0025.outlook.office365.com
 (2603:10b6:610:4f::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36 via Frontend
 Transport; Tue, 12 Mar 2024 15:24:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH2PEPF00000140.mail.protection.outlook.com (10.167.244.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Tue, 12 Mar 2024 15:24:28 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 12 Mar
 2024 10:24:28 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 12 Mar
 2024 10:24:27 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 12 Mar 2024 10:24:27 -0500
From: Harry Wentland <harry.wentland@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>
Subject: [PATCH] Revert "drm/amd/display: Fix sending VSC (+ colorimetry)
 packets for DP/eDP displays without PSR"
Date: Tue, 12 Mar 2024 11:24:25 -0400
Message-ID: <20240312152425.171452-1-harry.wentland@amd.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: harry.wentland@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000140:EE_|SA3PR12MB7974:EE_
X-MS-Office365-Filtering-Correlation-Id: 61e33aa4-a4aa-4823-36ca-08dc42a8824c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GYGe6M0HApJt7EMhYhpEkCV4QDfjaicm0L/InE6C82De93XT6FELwnnXMLttOdGoJ0Vrk5krg3N7cmrBQrbaevuX9mNF2yg6JiY+2UYQiiE1j+y+0SrsNLtbFcSk7IDm+HKumm/qu4KRBE8uE7RQOMCvIytZ4KEfNc/5jhAHAlMReI2JyUejKJzLWSylVaAPIjAwEoeUf6xFa/ImJO+UND2yCB2jVP7PZrq6s6/2HPTbtmCIYhiGNl5OBlp8/R/HrGY/GUhwvvR7YfWuO+PN3GhvIDtpu+9CB6Y5R6yvHBEH/knagyYU15cDoYgWnI7uiiAW9W+zvS1jNknaibOz/JHYYVwjpWT7Kmly93Adli5pnpFXvYfxcxQP02facKhrfVyLYSpR47JPlnSkX9yS5+8bu7Igpvw9+6rTouU6ctqVo7WO5S/fU9dvuItOad0nDj3oWZE/9FKfUYuDEAWJyQl4nMytXB2T0b9uilFdB1kemjUQwcdL0O0hp9iA3efViGttWqxShx0tBU1QKKurlzEOmHDrpbD0WbuWm/5dSaRz/K3dt2cl6F6nZ6KkFCf4b43GgqRcuCVR/haqI48AdJhzW+4DyfoJpDkRXa3eNo/W019tEdwKkr3zzYgcr6NWkP32yu4N//FqpHJLAwQAoMvjrQqMfP1AH1Wja63BCDb5rjnX+zlhwhuX5AEOurlDYDiwZo5JxVKEj4OlZ3FLKQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(376005)(36860700004)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 15:24:28.7114 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 61e33aa4-a4aa-4823-36ca-08dc42a8824c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000140.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7974
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

This causes flicker on a bunch of eDP panels. The info_packet code
also caused regressions on other OSes that we haven't' seen on Linux
yet, but that is likely due to the fact that we haven't had a chance
to test those environments on Linux.

We'll need to revisit this.

This reverts commit bfd4e0b7eb4467f9db5bb37268565afec6cf513e.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3207
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3151
Signed-off-by: Harry Wentland <harry.wentland@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c   |  8 +++-----
 .../amd/display/modules/info_packet/info_packet.c   | 13 +++++--------
 2 files changed, 8 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index cffb2655177c..6a61eb4148ad 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -6302,9 +6302,8 @@ create_stream_for_sink(struct drm_connector *connector,
 
 	if (stream->signal == SIGNAL_TYPE_HDMI_TYPE_A)
 		mod_build_hf_vsif_infopacket(stream, &stream->vsp_infopacket);
-	else if (stream->signal == SIGNAL_TYPE_DISPLAY_PORT ||
-			 stream->signal == SIGNAL_TYPE_DISPLAY_PORT_MST ||
-			 stream->signal == SIGNAL_TYPE_EDP) {
+
+	if (stream->link->psr_settings.psr_feature_enabled || stream->link->replay_settings.replay_feature_enabled) {
 		//
 		// should decide stream support vsc sdp colorimetry capability
 		// before building vsc info packet
@@ -6320,9 +6319,8 @@ create_stream_for_sink(struct drm_connector *connector,
 		if (stream->out_transfer_func->tf == TRANSFER_FUNCTION_GAMMA22)
 			tf = TRANSFER_FUNC_GAMMA_22;
 		mod_build_vsc_infopacket(stream, &stream->vsc_infopacket, stream->output_color_space, tf);
+		aconnector->psr_skip_count = AMDGPU_DM_PSR_ENTRY_DELAY;
 
-		if (stream->link->psr_settings.psr_feature_enabled)
-			aconnector->psr_skip_count = AMDGPU_DM_PSR_ENTRY_DELAY;
 	}
 finish:
 	dc_sink_release(sink);
diff --git a/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c b/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
index 738ee763f24a..84f9b412a4f1 100644
--- a/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
+++ b/drivers/gpu/drm/amd/display/modules/info_packet/info_packet.c
@@ -147,15 +147,12 @@ void mod_build_vsc_infopacket(const struct dc_stream_state *stream,
 	}
 
 	/* VSC packet set to 4 for PSR-SU, or 2 for PSR1 */
-	if (stream->link->psr_settings.psr_feature_enabled) {
-		if (stream->link->psr_settings.psr_version == DC_PSR_VERSION_SU_1)
-			vsc_packet_revision = vsc_packet_rev4;
-		else if (stream->link->psr_settings.psr_version == DC_PSR_VERSION_1)
-			vsc_packet_revision = vsc_packet_rev2;
-	}
-
-	if (stream->link->replay_settings.config.replay_supported)
+	if (stream->link->psr_settings.psr_version == DC_PSR_VERSION_SU_1)
 		vsc_packet_revision = vsc_packet_rev4;
+	else if (stream->link->replay_settings.config.replay_supported)
+		vsc_packet_revision = vsc_packet_rev4;
+	else if (stream->link->psr_settings.psr_version == DC_PSR_VERSION_1)
+		vsc_packet_revision = vsc_packet_rev2;
 
 	/* Update to revision 5 for extended colorimetry support */
 	if (stream->use_vsc_sdp_for_colorimetry)
-- 
2.44.0

