Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86708CD1299
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Apr 2024 19:51:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6EE90112E7C;
	Wed,  3 Apr 2024 19:51:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bkdrVILg";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2074.outbound.protection.outlook.com [40.107.237.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF777112E7A
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Apr 2024 19:51:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cm8rK0b7M+tHr8ovlziiCwAAH3cLw/pfG0jTnUJbEyK5Rxgfzgo8Wh05RJj4plIl/jRTbhNx+VZVLSns4/HdDmrYDZ0CNv1YvsNvNtb3aWvgh0UtEVYV5LnjI3p5eB0wpNf81yhQczjLEPgOoIvAt3AvbfG7KcqGGNgYj16emhXRIVnsoYVSIJL7dyqTc2uDmp5EDpfMsoPBffigive0w2CMqz5beUTMs3CuW4MgbyhJ7sNdzagGBHYSe2UXhzwDXcq7/7n1KuUrM8QNQcmSd8XWSwll0VpXkhBQGddaKYhWvNkzNBCKRnr7qryJ0K3hKmTAxeYlYySEdyO5WqiYRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XqJzgR0PmJKqvuPhQ1ZFHeLfAbongaXucmj+b0rIZiY=;
 b=hJ6tD2B9t8sLoyxff6gjz9HOzLFBHnjKVkJGR+Rwk6w9jVumL/lx06EmlHuHbBVOAklvBAJpDoXos6TX1YRL5SWPm3B8bqQ/E+RjflSaxhw6lZm4FNuF1qqFQwbJwFsvo49G2IRiYhgeIYkySALj3TNXNA4yQ5KF4bA5Xe24PV+YSXcQec+9r63oMPN2KO3UKKtriUcEF1MKjt+JS54EiI1fJ7qAotqggeAVDgdrdjTz3HHctbTrDlcNkezAwHkUQvBIuCspfGFZRarr6bvp5yfsgO16zfrcuzh/l6LglQeAe2ZjDXMbxipJHuFB3gTdB3oKcUx1ZMa1C9j9TBY52Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XqJzgR0PmJKqvuPhQ1ZFHeLfAbongaXucmj+b0rIZiY=;
 b=bkdrVILg00+1FvMkOgp3b90xDjScJSf8QN0HMoRDLmzRlmJ0BDQqLAU2Ac2ixL6cqJFX60uGOM9AZ1TOCe4mo25MI80q2rAxxeO7w/4vAJ4rZQFaD5RcD7kYpDi6ZP4ml+A/twm5judir3e/LN2nBLd0dvEWCfWMY9/Wp78279U=
Received: from CH0PR04CA0072.namprd04.prod.outlook.com (2603:10b6:610:74::17)
 by DM3PR12MB9349.namprd12.prod.outlook.com (2603:10b6:0:49::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 3 Apr
 2024 19:51:48 +0000
Received: from CH1PEPF0000AD74.namprd04.prod.outlook.com
 (2603:10b6:610:74:cafe::53) by CH0PR04CA0072.outlook.office365.com
 (2603:10b6:610:74::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46 via Frontend
 Transport; Wed, 3 Apr 2024 19:51:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD74.mail.protection.outlook.com (10.167.244.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Wed, 3 Apr 2024 19:51:48 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 3 Apr
 2024 14:51:40 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Harry Wentland
 <harry.wentland@amd.com>, <stable@vger.kernel.org>, Joshua Ashton
 <joshua@froggi.es>, Xaver Hugl <xaver.hugl@gmail.com>, Melissa Wen
 <mwen@igalia.com>, Agustin Gutierrez <Agustin.Gutierrez@amd.com>, "Hamza
 Mahfooz" <hamza.mahfooz@amd.com>
Subject: [PATCH 11/28] drm/amd/display: Program VSC SDP colorimetry for all DP
 sinks >= 1.4
Date: Wed, 3 Apr 2024 15:49:01 -0400
Message-ID: <20240403195116.25221-12-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240403195116.25221-1-hamza.mahfooz@amd.com>
References: <20240403195116.25221-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD74:EE_|DM3PR12MB9349:EE_
X-MS-Office365-Filtering-Correlation-Id: 79708715-ba1d-4ce9-c90d-08dc54177f95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ybu7PX8I/EhzdauRfFPYIupO4O/mzv2qK7I9aEh42hfPVdeAqMVtNY+ShW6Svm27G5Bnp0QMcjpBnmug1tr8nUqPlDhsbACS3DuxbgIl1q3LYaup0kZ2x/MOWSacpc633ABI2iE+L+t208wGBERymsvSoB58SNGJEx6Arv6DtLcO5qy8TKIpyo1tDgG7eqYCT4oae+A2YP6psp8FCMhd5alABWd2JYmWEevzKiXdZh0Sb2hUpCnCAiZPFMpwJlKkCbq2drad6MGU7k1PT1smLKy3mK9mH4+6EPjjvA/j6vAixjR9QOQUiALsALpAtyzEc3rM8yfKT+hC7ovSnhXPqaGDiWayBq5FeST6WtiHX/NPj9g9evSL5E8WQ4JPaf7PdgjnZY2bXtwzkigD4mk8vCm2FS3S8KExncWTFCpYvLaQxn5oJvPfAQzqPQBzKx0BFoW23YV7ZwTSiPtpirr9mJ1SAlAst73qA3ss0plAF9SKxleeW7ddJgeL9ClTb1t8qDWWFb3hrqGqh2yBREVXTSalFCgQtTx+dRmTbBHN7iI8K3STCFzvOEH9gGRi2JYXgtPXgY954FtEidOfFQc7cgtUjnDvYNkZQ2+uB73lFoScbZ6CUu23DIruWy/7HabwEniGAtSF0kIoQ2uJtzPRzbNf6J3ASN6ip4KUVsbiWQP2zvh6W0reGCjVDyR+vY0pUAkL/e1qd1ScdOZWVX9xhvEJdxxNUOr8JPD+VeF/zlJ7GbJu8RToSXSaB2q618H1
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(1800799015)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2024 19:51:48.0490 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79708715-ba1d-4ce9-c90d-08dc54177f95
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD74.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9349
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

From: Harry Wentland <harry.wentland@amd.com>

In order for display colorimetry to work correctly on DP displays
we need to send the VSC SDP packet. We should only do so for
panels with DPCD revision greater or equal to 1.4 as older
receivers might have problems with it.

Cc: stable@vger.kernel.org
Cc: Joshua Ashton <joshua@froggi.es>
Cc: Xaver Hugl <xaver.hugl@gmail.com>
Cc: Melissa Wen <mwen@igalia.com>
Cc: Agustin Gutierrez <Agustin.Gutierrez@amd.com>
Reviewed-by: Agustin Gutierrez <agustin.gutierrez@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Harry Wentland <harry.wentland@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 9220acbdf981..56779e6544b0 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -6326,7 +6326,9 @@ create_stream_for_sink(struct drm_connector *connector,
 	if (stream->signal == SIGNAL_TYPE_HDMI_TYPE_A)
 		mod_build_hf_vsif_infopacket(stream, &stream->vsp_infopacket);
 
-	if (stream->link->psr_settings.psr_feature_enabled || stream->link->replay_settings.replay_feature_enabled) {
+	if (stream->signal == SIGNAL_TYPE_DISPLAY_PORT ||
+	    stream->signal == SIGNAL_TYPE_DISPLAY_PORT_MST ||
+	    stream->signal == SIGNAL_TYPE_EDP) {
 		//
 		// should decide stream support vsc sdp colorimetry capability
 		// before building vsc info packet
@@ -6336,7 +6338,8 @@ create_stream_for_sink(struct drm_connector *connector,
 			stream->use_vsc_sdp_for_colorimetry =
 				aconnector->dc_sink->is_vsc_sdp_colorimetry_supported;
 		} else {
-			if (stream->link->dpcd_caps.dprx_feature.bits.VSC_SDP_COLORIMETRY_SUPPORTED)
+			if (stream->link->dpcd_caps.dpcd_rev.raw >= 0x14 &&
+			    stream->link->dpcd_caps.dprx_feature.bits.VSC_SDP_COLORIMETRY_SUPPORTED)
 				stream->use_vsc_sdp_for_colorimetry = true;
 		}
 		if (stream->out_transfer_func.tf == TRANSFER_FUNCTION_GAMMA22)
-- 
2.44.0

