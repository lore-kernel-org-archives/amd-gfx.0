Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67450C4707B
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jan 2024 14:34:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F084D10E82B;
	Thu, 18 Jan 2024 14:34:50 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2055.outbound.protection.outlook.com [40.107.94.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0CB0810E829
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jan 2024 14:34:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tw5pkvBN27f/H1Exh3iVpsL19j4W0TjHxbai2tqW0MIl48kiDJ7kiIqc2M+eDjtHBY+plLwMmInmmvZnn2ZzkcJ6U5z0qWPFq7rxoZu/bKPVmy54kaVJUrgKBCSsITf/ERDZipV5kuoHqFe7QZcbCT40l/nq50tjGS5yYpdQR3mM8PcQDnbis6aqhNLRzAYVHVtihBXLKJlMrmzEGMmaovNjKIkvICrg2wcmtH4Puwzwp1D2QrwB+G5CU3kEB/aZO332VfxGMo42C4Az9aHPXia6EcbS5V72FYFv/yRPbb6sGNQVp0ial0x/43F2XAD0lMd/wjbqYnREHy4/Zh57XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rQfONAyF0LmwpOUhnpEb5xqMhuxlBpkssuju1q/TwrI=;
 b=mwaFB3F2eMdvvVK4tOMdMwgRJJPVvA7fnzFUspUDnlLL2Iuh2JXDZqegSsLTCmjvspCxELncsjDzbCst3zVkOnVO/gCF2CLBnwoFUrpVpqSusZZsnQ6760qbd+8yzlYyAYh+7O0OHZduiYAT5ti+usqx2unE7nGeO6XDOlcnBVFADr5NaVEfQaasLTVmpuTE/iJuj5a3UDmd6a4lIASOLEyZS/p18MCbUR1EvVEeYuxoSkV5wnHXYivGzlagDYFTbbmwaq+TPrsn01FlcHIjnbMfyUT0bgKhKn9lkMm4opRsKQXlgpKkfjTqL87m8aCR+XZMdMOzrqCRtmQTgCxo4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rQfONAyF0LmwpOUhnpEb5xqMhuxlBpkssuju1q/TwrI=;
 b=BhJ5cADdkT9F+KZet8J1w0ub6Wde2Wc8qVcGo5ajuTuEFOhmRuVVSOc2IhKyM7XrgjQQfR3xsM4NodfFZpkGHQmSqaLdPAAOLcmRnCKLacnm/9clApf8IOggxQwAOGfys0WRahGNtUd9i0g1fAzRHsxcXO9rBQg7KeAP1iht8tY=
Received: from PH0PR07CA0109.namprd07.prod.outlook.com (2603:10b6:510:4::24)
 by SA0PR12MB4430.namprd12.prod.outlook.com (2603:10b6:806:70::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Thu, 18 Jan
 2024 14:34:43 +0000
Received: from SN1PEPF0002529F.namprd05.prod.outlook.com
 (2603:10b6:510:4:cafe::b9) by PH0PR07CA0109.outlook.office365.com
 (2603:10b6:510:4::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24 via Frontend
 Transport; Thu, 18 Jan 2024 14:34:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF0002529F.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Thu, 18 Jan 2024 14:34:43 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 18 Jan
 2024 08:34:40 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 18 Jan
 2024 08:34:39 -0600
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.34 via Frontend
 Transport; Thu, 18 Jan 2024 08:34:38 -0600
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 01/12] drm/amd/display: Fix timing bandwidth calculation for
 HDMI
Date: Thu, 18 Jan 2024 09:33:49 -0500
Message-ID: <20240118143400.1001088-2-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240118143400.1001088-1-Roman.Li@amd.com>
References: <20240118143400.1001088-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529F:EE_|SA0PR12MB4430:EE_
X-MS-Office365-Filtering-Correlation-Id: 054cc7e4-b447-46f5-6e21-08dc18329c7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qgol7NfLWZ7589iml+p/C8QUI1RzXDymQ6XfeGopnW3IL1fUnYz8xvRb/JR+uZevm4WbCL7MIFXn1YfarlzlFSOJErZlAmSUY1QV+4uCx1HX9Zv0xESST+xxt3cMTb2HDJ+tDYRhUfHLoJEDnHHOOKIhNRrDHidsS82DBf83l05SBlOSZCz/BmGrW41fhR0WnmhmTwnS9vbWcVbrHUBaQGtaKbEPpCr+WcuxN88O1dlgcTavHZ8kcCTFj+VEL/a024fOVS084jx8/fMhLxMV+u505Q6EUu5ttgYBzDm1zVPfjLGQ0032peeIa3L8z2fEoPQZNbTaXaDCwIdNYvsyQ4h4TWMHl/CBkuiPPu+ZcBsaxDzLg89N8WMgqCmGiYVee+mEg60ccPSqzA7EnLxbBjSQN0EAsXasFOCzaKYZBF/QTwdiG870S4tV56OwYbwcAJ4GFUFF5IP4KRhBZ8VsQ3QJnbMzq7j2OFcvTY9MYga0CaqbgLK2VgLOUKTu+cxos2OiFTt6f+6vhR0acHiJEQDyxt0vU08Ih9wECCXqPcGQ2UCIeAxzx+VPXfVBota9uLZWA8s5VCapcwMFBgz7whQjjae4e4i8UwDQbbRC/qO+g4/1MFfIt6aRl0dlpvxBpmBWE53RwimxH5/xwt6mVK5v5zFtevPhz5n3aJJ4hmGnb4p/a3FRn6V/YtCDLdgRqit79H2a9EKFel5zAjrGC5QGPMFsy1KbFsoMVXBATACgG5b878Mi8gYsa0k9fLz2u46RIc/8ivmiIXJ+Ire59g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(39860400002)(396003)(376002)(136003)(230922051799003)(82310400011)(186009)(1800799012)(64100799003)(451199024)(40470700004)(36840700001)(46966006)(356005)(70206006)(4326008)(8936002)(8676002)(54906003)(70586007)(478600001)(36860700001)(82740400003)(81166007)(26005)(2616005)(6666004)(7696005)(1076003)(316002)(86362001)(6916009)(336012)(426003)(83380400001)(2906002)(2876002)(40480700001)(40460700003)(36756003)(5660300002)(47076005)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2024 14:34:43.2040 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 054cc7e4-b447-46f5-6e21-08dc18329c7d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4430
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
Cc: Chris Park <chris.park@amd.com>, chiahsuan.chung@amd.com,
 Sunpeng.Li@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 jerry.zuo@amd.com, Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com,
 wayne.lin@amd.com, "Leo \(Hanghong\) Ma" <hanghong.ma@amd.com>,
 Harry.Wentland@amd.com, agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: "Leo (Hanghong) Ma" <hanghong.ma@amd.com>

[Why && How]
The current bandwidth calculation for timing doesn't account for
certain HDMI modes overhead which leads to DSC can't be enabled.
Add support to calculate the actual bandwidth for these HDMI modes.

Reviewed-by: Chris Park <chris.park@amd.com>
Acked-by: Roman Li <roman.li@amd.com>
Signed-off-by: Leo (Hanghong) Ma <hanghong.ma@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h | 1 +
 drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c  | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_hw_types.h b/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
index 811474f4419b..fb4db3158e8f 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
@@ -942,6 +942,7 @@ struct dc_crtc_timing {
 	uint32_t hdmi_vic;
 	uint32_t rid;
 	uint32_t fr_index;
+	uint32_t frl_uncompressed_video_bandwidth_in_kbps;
 	enum dc_timing_3d_format timing_3d_format;
 	enum dc_color_depth display_color_depth;
 	enum dc_pixel_encoding pixel_encoding;
diff --git a/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c b/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
index 0df6c55eb326..ac41f9c0a283 100644
--- a/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
+++ b/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
@@ -137,6 +137,11 @@ uint32_t dc_bandwidth_in_kbps_from_timing(
 	if (link_encoding == DC_LINK_ENCODING_DP_128b_132b)
 		kbps = apply_128b_132b_stream_overhead(timing, kbps);
 
+	if (link_encoding == DC_LINK_ENCODING_HDMI_FRL &&
+			timing->vic == 0 && timing->hdmi_vic == 0 &&
+			timing->frl_uncompressed_video_bandwidth_in_kbps != 0)
+		kbps = timing->frl_uncompressed_video_bandwidth_in_kbps;
+
 	return kbps;
 }
 
-- 
2.34.1

