Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FB99D41D51
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Nov 2024 19:58:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3F8910E640;
	Tue, 12 Nov 2024 19:58:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OLnbbGke";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2060.outbound.protection.outlook.com [40.107.93.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E3E610E63D
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Nov 2024 19:58:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rgHFWOvj5KmdKjIIBwWwF+wSlGYOfhBS5eAwPmdl0IDUlaGTPtt4+Pd6rZ95ywfM+0yVHrXDYn/gkdY1d8kpSaWYaRxxJ9unjATmGdQuPD2pFvl8uApTWJ222n8gSSFOMysID25ye5ybZnvfslV2zDy+Qvf9PVwmKSSfWdZ0ELi+t4Tg7/EBt6vCDCa14ZQpnaW3O64CbUHYGJwmMYm/Q0L0TCYPQKKSeSorQr1xFo0Wf/ZoOviOTHu0XkUAZ+e3s8IvUqhVhuUGGAxb6DsrAAgk9FTaMiKm9E7U0Excos8URGhWepAk1+1JHBh0dNBpff/bayb40/+SVFY5qHc9pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1tQ0LlkaeWxN0lgBWQw4ezS8YVDlzeKmMUXIzb5DQxg=;
 b=GAh1uEfaXlr93iTpTj4KXqH0zS/v2osZ56MohJzjP6mxfdtuFUHjs5XKp/bKRDEBrrdnumELEjMb+iFS9bBVruwUWO2v3f2KHg+yoFaNY19oIHekPQL3mwTdjVFh5WHCajNEsNp3fo3L5s45bRiShwKDDx65irc1mxiNK3mIGhOqNAomFQI9Z0SxXhY2iHpNJh+tgoXEMzrks/CFiNAvs9+yZ2wj0MUuaPG5R+0b2z9RVez0rsNzgBAo9N2ibwil3OajnpZ0/ysTQzh09lpW6WYi6eUMj824UxF1QQR/fyFu/30uLnLOTFy/iNPsE/WvgdyYzny975C3xkklZDdnWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1tQ0LlkaeWxN0lgBWQw4ezS8YVDlzeKmMUXIzb5DQxg=;
 b=OLnbbGkeACt+Ad2rP2t//UmlDozCXhQ8HuA8weUfEtI/mmE+NrokLtSb6bRM7FR1w36ic+S7lcvqObTIIYR6U1hEn86LqsYbKjsVQrWNNHlwdu4OZo4UPC+RwoFoN20V32l634HeHO1693ItmBo6iPX6J+OEHRQLqBF7Y4p2jhA=
Received: from MW4PR03CA0282.namprd03.prod.outlook.com (2603:10b6:303:b5::17)
 by BL3PR12MB6571.namprd12.prod.outlook.com (2603:10b6:208:38e::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.27; Tue, 12 Nov
 2024 19:58:26 +0000
Received: from SJ1PEPF000023D3.namprd21.prod.outlook.com
 (2603:10b6:303:b5:cafe::b7) by MW4PR03CA0282.outlook.office365.com
 (2603:10b6:303:b5::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28 via Frontend
 Transport; Tue, 12 Nov 2024 19:58:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023D3.mail.protection.outlook.com (10.167.244.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8182.1 via Frontend Transport; Tue, 12 Nov 2024 19:58:26 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 12 Nov
 2024 13:58:22 -0600
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>, Samson Tam <Samson.Tam@amd.com>, Navid Assadian
 <navid.assadian@amd.com>
Subject: [PATCH 7/9] drm/amd/display: allow chroma 1:1 scaling when sharpness
 is off
Date: Tue, 12 Nov 2024 14:56:02 -0500
Message-ID: <20241112195752.127546-8-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241112195752.127546-1-hamza.mahfooz@amd.com>
References: <20241112195752.127546-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D3:EE_|BL3PR12MB6571:EE_
X-MS-Office365-Filtering-Correlation-Id: 5dd92653-6734-45c0-5d73-08dd03545f34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?I95lD8FvvcA7hKl8s/87q9nAm1zxNHm6lsg2UoAqhPZJ7OdBntAM+k9+WyVS?=
 =?us-ascii?Q?NS5TJCwhR1XXhInh3HQEYNJye2FnAgBTYtb+waDIDy665JMsKYuic7Pq3M/U?=
 =?us-ascii?Q?cT0r8ozYaI7tR+E1zX7smUKkcDcY+ZpqmnOS99zDKUHgoG7ZKXvoLFNdbiol?=
 =?us-ascii?Q?UgPWZeHNibrsBVYd+Q+dKqp+ZE+F8YicO31lqYUj6FXLlAkyUZhKMfxTnXPc?=
 =?us-ascii?Q?k8sd3254Pa2CvyuOp/JUzlfcyseFRsbaCBZx8JLXkVQjmEhQ1uTPQsh15dxH?=
 =?us-ascii?Q?wAjBG0Whogsr8F9fSuYZ3NiSRpNcwkn9xSA703EzAUOTOL6vRhR8QLYdZNs+?=
 =?us-ascii?Q?oDJHHBUuRJd0WHSEqzgrFJFVbqwRA9a7BJt1X9Lq7ADPRb/9VDavV0ZCdg27?=
 =?us-ascii?Q?XkNQoKiylcaA4sog8pBa+iauQgV0Eljg02PqWbREZoOZBg+tKCcYjoHXQUkV?=
 =?us-ascii?Q?pipgSQVBLEpKIV64QJ0DS8ipBsjAOGYMSprq9VZZlKA+dKUzQ3uvzboHZfQt?=
 =?us-ascii?Q?tb3bODoi80txEULZx1568pvg49ON/ETXin2LZbs8W2W7kbd0fUkxiG8JM0So?=
 =?us-ascii?Q?NB+nVTjMWvmaDucqUfbzZcBYLVhK0W8OI2fUdcKGNfFVhUoCVo/3Hxf3TwaZ?=
 =?us-ascii?Q?9Q61we3lSiihbGGDhFwY7j4Kd13jMaGluKaBR6LawCMGm2lRZD1zxwqDS9R0?=
 =?us-ascii?Q?5GeBxPba5hG8SydT1Fq7Kz+bKuQ0mWnBW9uxxsr+MsLoas7I6UTAmQcMyNHl?=
 =?us-ascii?Q?++qP9Ob7zTsIdfwBjoavTBePRBkq/JuN+JsO78zZF/mapEyOFHI3u61xeAdo?=
 =?us-ascii?Q?3DPpJZPIcmekfE3HodlCoZffqYrtKPIVEU5N79WoDspjXpgNIKE74vjXxFqO?=
 =?us-ascii?Q?9ARIKuAX4LsMP0ydw3B0/8T80qAo6OOMUrHYkZGbRj53+GZJFgbQLjRUfhmX?=
 =?us-ascii?Q?CnMoa5IDKNMk+xEA6uEbrnTJr4T37Xtth5l6wLBHOM9qSPLbd0l4UCPJn3Lp?=
 =?us-ascii?Q?KTpCvkrVa7e8aaSq60jSBvhQvbtCIU6LqGNtmFLmWeRxgEEHC1IOkFq0+gqj?=
 =?us-ascii?Q?BtXSq8a57lrH29T7/1gjtRxt5ygv56aPv8luo+vsr8CsPXD5x8RIPiKYSyLi?=
 =?us-ascii?Q?h8gLEl4+s7R6Ov9+FJygygUo7p8zFVwad4Q0hZbXkrz7rjaf1b+90Rpi73Uf?=
 =?us-ascii?Q?Z6nebuywxs6cVTZly/eNMFaElcMvkRyo2b+7wLAUijUTGyw+pNIVSA9UYVP1?=
 =?us-ascii?Q?u7wvhRlXWjqORGtVR12ZfTyr+2Te3r9KRMfkYXue6JUrsUottiH2zOCtAufr?=
 =?us-ascii?Q?TwO2g6yoo7A+/P1KbUZUKm9WMNxHRhi/n2y3JmkbojYYhKHEg5jYWnc0fsrb?=
 =?us-ascii?Q?C3NGzJCWcXzhuxPanwB637nxrj+j+yWTBANyF7rmiIXhaqe2Vw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 19:58:26.4163 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dd92653-6734-45c0-5d73-08dd03545f34
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D3.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6571
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

From: Samson Tam <Samson.Tam@amd.com>

[Why]
SPL code forces taps to 1 when ratio is 1:1 and sharpness is off
But for chroma 1:1, need taps > 1 to handle cositing

[How]
Do not force chroma taps to 1 when ratio is 1:1 for YUV420
Remove 420_CHROMA_BYPASS mode for scaler

Reviewed-by: Navid Assadian <navid.assadian@amd.com>
Signed-off-by: Samson Tam <Samson.Tam@amd.com>
Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
---
 drivers/gpu/drm/amd/display/dc/spl/dc_spl.c | 34 ++++++++++++---------
 1 file changed, 20 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/spl/dc_spl.c b/drivers/gpu/drm/amd/display/dc/spl/dc_spl.c
index da477406a4b7..73a65913cb12 100644
--- a/drivers/gpu/drm/amd/display/dc/spl/dc_spl.c
+++ b/drivers/gpu/drm/amd/display/dc/spl/dc_spl.c
@@ -739,14 +739,13 @@ static enum scl_mode spl_get_dscl_mode(const struct spl_in *spl_in,
 			return SCL_MODE_SCALING_444_RGB_ENABLE;
 	}
 
-	/* Bypass YUV if at 1:1 with no ISHARP or if doing 2:1 YUV
-	 *  downscale without EASF
+	/*
+	 * Bypass YUV if Y is 1:1 with no ISHARP
+	 * Do not bypass UV at 1:1 for cositing to be applied
 	 */
-	if ((!enable_isharp) && (!enable_easf)) {
+	if (!enable_isharp) {
 		if (data->ratios.horz.value == one && data->ratios.vert.value == one)
 			return SCL_MODE_SCALING_420_LUMA_BYPASS;
-		if (data->ratios.horz_c.value == one && data->ratios.vert_c.value == one)
-			return SCL_MODE_SCALING_420_CHROMA_BYPASS;
 	}
 
 	return SCL_MODE_SCALING_420_YCBCR_ENABLE;
@@ -933,6 +932,7 @@ static bool spl_get_optimal_number_of_taps(
 	int min_taps_y, min_taps_c;
 	enum lb_memory_config lb_config;
 	bool skip_easf = false;
+	bool is_ycbcr = spl_dscl_is_video_format(spl_in->basic_in.format);
 
 	if (spl_scratch->scl_data.viewport.width > spl_scratch->scl_data.h_active &&
 		max_downscale_src_width != 0 &&
@@ -1074,10 +1074,9 @@ static bool spl_get_optimal_number_of_taps(
 
 	/* Sharpener requires scaler to be enabled, including for 1:1
 	 * Check if ISHARP can be enabled
-	 * If ISHARP is not enabled, for 1:1, set taps to 1 and disable
-	 *  EASF
-	 * For case of 2:1 YUV where chroma is 1:1, set taps to 1 if
-	 *  EASF is not enabled
+	 * If ISHARP is not enabled, set taps to 1 if ratio is 1:1
+	 *  except for chroma taps.  Keep previous taps so it can
+	 *  handle cositing
 	 */
 
 	*enable_isharp = spl_get_isharp_en(spl_in, spl_scratch);
@@ -1087,20 +1086,28 @@ static bool spl_get_optimal_number_of_taps(
 			spl_scratch->scl_data.taps.h_taps = 1;
 			spl_scratch->scl_data.taps.v_taps = 1;
 
-			if (IDENTITY_RATIO(spl_scratch->scl_data.ratios.horz_c))
+			if (IDENTITY_RATIO(spl_scratch->scl_data.ratios.horz_c) && !is_ycbcr)
 				spl_scratch->scl_data.taps.h_taps_c = 1;
 
-			if (IDENTITY_RATIO(spl_scratch->scl_data.ratios.vert_c))
+			if (IDENTITY_RATIO(spl_scratch->scl_data.ratios.vert_c) && !is_ycbcr)
 				spl_scratch->scl_data.taps.v_taps_c = 1;
 
 			*enable_easf_v = false;
 			*enable_easf_h = false;
 		} else {
 			if ((!*enable_easf_h) &&
+				(IDENTITY_RATIO(spl_scratch->scl_data.ratios.horz)))
+				spl_scratch->scl_data.taps.h_taps = 1;
+
+			if ((!*enable_easf_v) &&
+				(IDENTITY_RATIO(spl_scratch->scl_data.ratios.vert)))
+				spl_scratch->scl_data.taps.v_taps = 1;
+
+			if ((!*enable_easf_h) && !is_ycbcr &&
 				(IDENTITY_RATIO(spl_scratch->scl_data.ratios.horz_c)))
 				spl_scratch->scl_data.taps.h_taps_c = 1;
 
-			if ((!*enable_easf_v) &&
+			if ((!*enable_easf_v) && !is_ycbcr &&
 				(IDENTITY_RATIO(spl_scratch->scl_data.ratios.vert_c)))
 				spl_scratch->scl_data.taps.v_taps_c = 1;
 		}
@@ -1111,8 +1118,7 @@ static bool spl_get_optimal_number_of_taps(
 static void spl_set_black_color_data(enum spl_pixel_format format,
 			struct scl_black_color *scl_black_color)
 {
-	bool ycbcr = format >= SPL_PIXEL_FORMAT_VIDEO_BEGIN
-					&& format <= SPL_PIXEL_FORMAT_VIDEO_END;
+	bool ycbcr = spl_dscl_is_video_format(format);
 	if (ycbcr)	{
 		scl_black_color->offset_rgb_y = BLACK_OFFSET_RGB_Y;
 		scl_black_color->offset_rgb_cbcr = BLACK_OFFSET_CBCR;
-- 
2.46.1

