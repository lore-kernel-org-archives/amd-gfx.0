Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C2CBC79FA1
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Sep 2026 11:38:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1646110EB55;
	Tue,  8 Sep 2026 11:38:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hAm1nuQh";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013006.outbound.protection.outlook.com
 [40.93.201.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3FFE10EB55
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Sep 2026 11:38:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jFoPuGglvqj/Sb2SwjAsDBxhqd4dwSY+vPd8tuah7dOFpXpJ6/bGONTkvqI1PJhaTG12C/Rttn0tRO5mX7Xu1faPBVv0yppRPT93ecATlEltHzClsexAe4j6pGcreEyW1Bof09IXdktBU4wRGhi0Fr9AYnA+pEdtirKOU16kzoZiX6XjRrVzQaW0wPgJl2bRF6zFa5YGS9JajCSoSCcYI0Z28x0PltaAyLzIB+tErP+FIf0YTP9X8n2qmbw1hXTp0tYDAoXD+k53C2d8eBzeouPGu8ylSM7Ekyr5NmD+ioTLAZ1/7r+lSZeR0OGls2yzSw633vsAa1+iVIgFFEYRuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8ZG5cwOEyj2BpXOKNL35FW9dr7YJpxYBAY0IXe5WNqk=;
 b=E9MEZoSu61e1PY5rjoTG/1YPlkJDb8jam01znte0r9uRFzNlXWvjaaYgjqGQR/0R/Ie2+muUvRwDlDFOT1JQKL0xP+rSuQA+foo/qfWmCLw+Zzc4bd2hT20sYc8EqP8tc2mm86GD96uzgZoNuIdLPTmGHCndH1Pe3m1jtB8XD/c52kUvDsDwmKxh8XGoGRoMYeN/JXTE9Zoj2Gi0Q8D8DfwKDEA6gCiQa6Z2bJsForymgw+iPEVprGe30Rz+UVX74Xb9yPvw0NqM3AdResJW6frMmPygoUGQW/kdffjAz0E1T3RBmrHIVDMopqW/KwiKUFcN/w6i3vype+8XWqPtXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ZG5cwOEyj2BpXOKNL35FW9dr7YJpxYBAY0IXe5WNqk=;
 b=hAm1nuQhxy1Suwj/6l7qlYXHdL8FTHvqV9uxnoRkw9DlBrE6GflpHVKMmneZkEuFFmhis7yqWqpvnYQuWBVrydsBoYz1vtWFOZdnCJhuPEOU0SaHCHaaA9MYouF5WJOYWveZwTUvd9s4z89H0N9haHFITBbjX4VkpDM1UajWQD4=
Received: from BL1PR13CA0219.namprd13.prod.outlook.com (2603:10b6:208:2bf::14)
 by DM6PR12MB4204.namprd12.prod.outlook.com (2603:10b6:5:212::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 11:38:41 +0000
Received: from BN2PEPF0000A891.namprd04.prod.outlook.com
 (2603:10b6:208:2bf:cafe::28) by BL1PR13CA0219.outlook.office365.com
 (2603:10b6:208:2bf::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.6 via Frontend Transport; Tue, 8
 Sep 2026 11:38:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000A891.mail.protection.outlook.com (10.167.248.183) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 11:38:40 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 06:38:40 -0500
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Tue, 8 Sep 2026 06:38:32 -0500
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Chenyu Chen <chen-yu.chen@amd.com>
Subject: [PATCH 33/66] drm/amd/display: Honor forced RGB pixel encoding
Date: Tue, 8 Sep 2026 19:31:26 +0800
Message-ID: <20260908113338.2433445-34-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260908113338.2433445-1-chen-yu.chen@amd.com>
References: <20260908113338.2433445-1-chen-yu.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A891:EE_|DM6PR12MB4204:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ff27cef-2eb7-4970-9844-08df0d9dbb17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|23010399003|1800799024|6133799003|10067099003|56012099006|11063799006|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: dYjk2wOxwAudf0k+SPEjJxiYOUOGDQzHgFLSlAJpzatK9q++s/Ilwtexv1dJS//Sq9sYpEUtI5YV7bckMEYjLwa4QRsCVPbDIedHeXRB05BVRIGKZte4P9PTWlyf/k4opt5qFwCeRkWowzJ8czn+VxbYiqwX0hSynMzCUbU9eYMoHVI18Sr88aeM6zuIBGRBW6x6pC+2YXVELxa6XRWdgdxxHlYp3tUa0g+5f2bA9E7YDe5POHQCsc2FHaaWKqb5SjFYSwI22RH+yiS+8hJoWmjPxMBpnQ04StZofBrzaOWrhRA0PHbhdpcMenM0Uqnctelj6y26Pj+Mv8FKqqTo9jhrskjtiz5qlkcxoLJ4Qp8YmJdUiwywPWzXWT/2uvB62txHjAduWoVj0LPn4tm5KQuNJR8c1qO/IyftlcCCa4/E+bvRaFzJCU++steXZfrBbI6H1vG98yw8DpVO9CVBShmwEFLzjyYYVN0FtxVAFEdM5Iq/FMRWB/aEX3DAC0LgBaUdfG2C3AVgc5CaI/pjqz83zThwKN+F7m1opkjUINdBgjS43VctoTHX+/Pw/h9+RvIZSG046buZ6rzyaKNQDM3yYyxJWkRo3YnIEgD+1dPdLsyRpK72WuY+RNif33Fd64MIra3HWv+D4SifCDA/vOjq9DYGqZvcU23OTehEFzRUJfhFVLO8xXgSpWOvNaLlXVSWWIsexjb00zAs9CouSg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(23010399003)(1800799024)(6133799003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: OBUArDNV/3NH4jHIHA1NAYAcKPfUmeLVmSZKgR37GxloUrxjQgksZH1y5bcvKX+eIXA/Vq1J9ZBUtIKFLKSQspKfT1AbTEso2yL42YvWODd2SR7LM8Sgh/jOQVxjjs6rgjt0Q9U/GdG1M8pLGnLJAq+VH3252/iZ3UY8eiaFUV/ye60IWLcoOuQm1K+9EaUQh7iFn3rVhoyIZHev4w/fbaBS6pYVzEQluzcfLzDISnVCsA3Rilm5f/t6hCvK/i8zLY/aQspegE2+k+acLZraLtMpGOOZgmsRSIUJ0i+16um2m4icS214JMtCLdZjCh3nk8GaZErlw3h+NuttxMCNk7LDH1IgEBf6BsYMumcwmnO0s5TDgrIVHYTc3+HEtlVHePW82u/JSWU5D74BHyiS/pr5QM47vVLGKZC5W6mcgDu+cIOucFe3ZI1Dl7bc2v3U
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 11:38:40.9388 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ff27cef-2eb7-4970-9844-08df0d9dbb17
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A891.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4204
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

From: Ivan Lipski <ivan.lipski@amd.com>

[Why&How]
Forcing RGB format via debugfs on a monitor supporting YUV444 is ignored.

Similarly to YUV format forcing, only use RGB pixel encoding if it is
specified in the force_yuv_pixel_formats debugfs.

Reviewed-by: Jerry Zuo <jerry.zuo@amd.com>
Reviewed-by: Leo Li <sunpeng.li@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
index 4fb992871b95..c9c8db972922 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_connector.c
@@ -2289,7 +2289,9 @@ amdgpu_dm_create_validate_stream_for_sink(struct drm_connector *connector,
 	 *    (drm_mode_is_420_also() clear), as required for HDMI compliance
 	 *    testing; dc_validate_stream() still rejects anything the link
 	 *    genuinely cannot carry. The YCbCr422/YCbCr444 forces stay gated on
-	 *    the sink's advertised caps.
+	 *    the sink's advertised caps. An RGB force pins to RGB alone and is
+	 *    always honoured, since RGB is the mandatory baseline every sink
+	 *    (DP or HDMI) supports.
 	 */
 	if (drm_mode_is_420_only(info, drm_mode) ||
 	    aconnector->force_yuv_pixel_format == PIXEL_ENCODING_YCBCR420) {
@@ -2301,6 +2303,8 @@ amdgpu_dm_create_validate_stream_for_sink(struct drm_connector *connector,
 		   (info->color_formats & BIT(DRM_OUTPUT_COLOR_FORMAT_YCBCR444)) &&
 		   is_hdmi_ep) {
 		encoding_mask = BIT(PIXEL_ENCODING_YCBCR444);
+	} else if (aconnector->force_yuv_pixel_format == PIXEL_ENCODING_RGB) {
+		encoding_mask = BIT(PIXEL_ENCODING_RGB);
 	} else {
 		encoding_mask = BIT(PIXEL_ENCODING_RGB);
 
-- 
2.43.0

