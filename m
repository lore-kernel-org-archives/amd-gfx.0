Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 092A4D2E010
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Oct 2024 04:54:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B34E810E71F;
	Wed, 23 Oct 2024 04:54:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JA7lBX2H";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2073.outbound.protection.outlook.com [40.107.243.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3060410E71E
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Oct 2024 04:54:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oJTssrjHUcS97B4ni/vdMXTu+7ZdV9Pd8ss/Dn6Je3NpHHVTE34kM+lqTp/N03ddf2P52zBjnr8DshWWITE307y8ro6YOD9ggnRAmQsYjcJk7mIDSGlTZ0QjJYMyZZmidO55jnEvZtymUzrtOx5ZULZCYH0A85LGLb4l82SLje2qIhUBMYhL8vjiApQPkETVqS6Z4TmEVsf3jdS5nnLS0jkTQUGBs/xk/qgElW2fCT95erFPfaFsSR6OzR074afUEZ9KrxU6U+WFC3SGv5Sx8sPJ/l+ktDn2glR+4olb1oZKMdIMJLetZe/jnfifCcHEqZ8f6T1QokCKE+YOqzxEQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YBblA/1fvr3lMr1z5l/2e3edjQIrUoDeMYkDjM5FGZk=;
 b=QYbyfSc6jWdZr89OTLdyq8keXq+UXN/etoz2B1azFzmCKAUwIOv4kQdRsjdxwh5w50Z1hzhs5Z8a2iRJt23i1Zw3NOVUs3NSXitLS8zLMz9Pvt7wRewBqvOH+9emZ/xZVAi1p0vMrn3jiEydRxL1NVGlNy/if1qAFwbGj5R19f+BCABKK/wn6x+/CXfZ+xGCZKkcTBKtH/vxqlMAJNgHsStJBQt0vfzA5qEL4z9JE1gymp2JxS/WgXt0D5WxTplGXHpQGaiicXrNe2ffzWW8pwXQL7FTIGOOMar+Ed02JhzHRiTckblw17zukTK/74xPJ5WXLWhGpSkokypaBapLlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YBblA/1fvr3lMr1z5l/2e3edjQIrUoDeMYkDjM5FGZk=;
 b=JA7lBX2HA5mnlMnGGzo+/79IVIjc2lplXSVJ84KxzHkVGs1wSWZOiBv3MoCNdJN2mpTU8wP/nOerCq2fYK6o5c1qUA9l8sImNG3CvjmnOBbLW4O4CqFDJo8HnvzanfmgZzHJpUH5kh+ADodL1yBGMIKUl9W6lUzvfobabRXvY0M=
Received: from DS7PR05CA0033.namprd05.prod.outlook.com (2603:10b6:8:2f::20) by
 SJ2PR12MB7822.namprd12.prod.outlook.com (2603:10b6:a03:4ca::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.27; Wed, 23 Oct
 2024 04:54:26 +0000
Received: from CY4PEPF0000FCBF.namprd03.prod.outlook.com
 (2603:10b6:8:2f:cafe::bc) by DS7PR05CA0033.outlook.office365.com
 (2603:10b6:8:2f::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.5 via Frontend
 Transport; Wed, 23 Oct 2024 04:54:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000FCBF.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Wed, 23 Oct 2024 04:54:26 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Oct
 2024 23:54:25 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 22 Oct
 2024 23:54:24 -0500
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 22 Oct 2024 23:54:21 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <rodrigo.siqueira@amd.com>, Hamza Mahfooz
 <hamza.mahfooz@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Roman
 Li" <roman.li@amd.com>, Wayne Lin <wayne.lin@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed
 <zaeem.mohamed@amd.com>, Solomon Chiu <solomon.chiu@amd.com>, Daniel Wheeler
 <daniel.wheeler@amd.com>, Samson Tam <Samson.Tam@amd.com>, Alvin Lee
 <alvin.lee2@amd.com>
Subject: [PATCH 08/16] drm/amd/display: fix handling of
 max_downscale_src_width fail check in SPL
Date: Wed, 23 Oct 2024 12:53:28 +0800
Message-ID: <20241023045336.1557443-9-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241023045336.1557443-1-chiahsuan.chung@amd.com>
References: <20241023045336.1557443-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: chiahsuan.chung@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBF:EE_|SJ2PR12MB7822:EE_
X-MS-Office365-Filtering-Correlation-Id: f8746017-8016-464b-0c7c-08dcf31ec534
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VyfYemuvOw0/wExMPJzaLmLAg8h8J4i5HFg2xGRjeiB2lDwGy3+UT7aCyVFM?=
 =?us-ascii?Q?453UyOWvq/6Na2loF0KK+MsuuOYsBcZxRthEVmmdVDwhuICbdWytsUx75fL7?=
 =?us-ascii?Q?fgTxXeDHHLyeLRhCql6I3by67KXCQvlshLGJ3Sf86RYCxOUgoOjYOdo9Ug3O?=
 =?us-ascii?Q?DRxsJ8kFKUtKjpPmDk7g6hNWXk/X7BNuk2b9o+3d9vtPNZWOhkfY0okcbZEq?=
 =?us-ascii?Q?p2PVYa9L8fnn6zAMW/g5AdhijPt6xkjDMYf9fKxWCG6CxgzkcDPL9maKieJn?=
 =?us-ascii?Q?x4svQGfZGRKgXtR8xfFykjFbrjhDfUHvKzy0OhQu+ddO4+7O1AWYBBr4F62p?=
 =?us-ascii?Q?U5KE2Qvpq824/kas5DQR0XsQiR70CPrwn406FA1qjCgjw5ms6mBtzQ9VoAG1?=
 =?us-ascii?Q?7JOtNbTJWYowSKuMs75b35cN2cNd5MVbrwinTYOVB33VUb0Ru03xW7hnKl0e?=
 =?us-ascii?Q?waRtFAj3nPTBizO7bpOJmC1GQclnvvWKH60ZQRT+9VT1w0WCvpTq9IKBtccm?=
 =?us-ascii?Q?cp+jzUilaCEVoDwgo/PDnPp+xj2rnHpW/EHDT5UPsuhaCW976IrIIMcZpv2F?=
 =?us-ascii?Q?l/w0HdH8tOv1n+loh4Zpv9jQumKjUGivEqnxFYm3BH1Veag2j+NcKSSELZUc?=
 =?us-ascii?Q?0ETZsb/GaBG4ZgBQjo1MM1xCMSqUwPt0RKCw6mWDxbPLqJ9Aul43rWdwlHos?=
 =?us-ascii?Q?XJtBkNWKNyliIBkWRXKU7GQOZ/53XAk8dgA2xUg4FAd9PwdZr8OmMdMbTEFT?=
 =?us-ascii?Q?eoeuQoKGphmBrPoooySoVS/338lZt+CKsshhd7+Y4R0cGs06OXiD5BQ9FfxC?=
 =?us-ascii?Q?zcQfP7TMNg5xuqTlyYPN+BDTWxb/RindVjICdHcdISIHnCCj+D7U7MOlLK5J?=
 =?us-ascii?Q?4o9Td5D6v+sl/e6aV7dQLkWyLYdiHm1g3bypRJKFwIugYIE8Ay6aapUV2K2X?=
 =?us-ascii?Q?xRDLNm2jk0YTvE2fXFzBmQazQbxcWfeAMUpNZ3mMfxzg6RtTctY4m42GDkDw?=
 =?us-ascii?Q?giRFOoBVgg4J+qLlnvGUZMWZtF29nW911gdJi+IezcRiNfzxp9gLllLrOjWG?=
 =?us-ascii?Q?4tm61jJds57UpKY3TpVyHhiJXx0LjxMQF8XSdrvtyRzapvuFPgl8mwvDZPdV?=
 =?us-ascii?Q?vvEctXk4qE6qhJOcvA0OJy5S/zK6wAzxlDJoXAKz6W1eXNRqBF+HPgUJJCkT?=
 =?us-ascii?Q?T4Y7h3e45L3CKGVC/0dKJib2yIAW29DoNyoyBKqGVCdpAbCdZTQNoxJ3yCtJ?=
 =?us-ascii?Q?OoOfhmJ98MlKzphrdV4fXiiLC4bd74swZoByqJQzD3MbUTe6Utx4IwjbaLE9?=
 =?us-ascii?Q?9Qf9+/T6G/9y97Xxi++J3khkr+nPvG4ZALY07nHpYAI+s1dlIKujhUbbvLUF?=
 =?us-ascii?Q?+MtdksSuJ+hLjvcQO26ldjvdTGaeAtFiUgfx7T5mzi/Bn4Xwsg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 04:54:26.0983 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f8746017-8016-464b-0c7c-08dcf31ec534
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCBF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7822
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
If max_downscale_src_width check fails, we exit early from
spl_calculate_scaler_params but dscl_prog_data is not fully
populated. If viewport is left at 0, it can cause crash in dml.

[How]
Call spl_set_dscl_prog_data before we exit early from
spl_calculate_scaler_params to populate dscl_prog_data
Populate taps in spl_get_optimal_number_of_taps

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Samson Tam <Samson.Tam@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/spl/dc_spl.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/spl/dc_spl.c b/drivers/gpu/drm/amd/display/dc/spl/dc_spl.c
index f043c7e32e16..403fd1221803 100644
--- a/drivers/gpu/drm/amd/display/dc/spl/dc_spl.c
+++ b/drivers/gpu/drm/amd/display/dc/spl/dc_spl.c
@@ -882,8 +882,13 @@ static bool spl_get_optimal_number_of_taps(
 
 	if (spl_scratch->scl_data.viewport.width > spl_scratch->scl_data.h_active &&
 		max_downscale_src_width != 0 &&
-		spl_scratch->scl_data.viewport.width > max_downscale_src_width)
+		spl_scratch->scl_data.viewport.width > max_downscale_src_width) {
+		memcpy(&spl_scratch->scl_data.taps, in_taps, sizeof(struct spl_taps));
+		*enable_easf_v = false;
+		*enable_easf_h = false;
+		*enable_isharp = false;
 		return false;
+	}
 
 	/* Disable adaptive scaler and sharpener when integer scaling is enabled */
 	if (spl_in->scaling_quality.integer_scaling) {
@@ -1765,12 +1770,12 @@ bool spl_calculate_scaler_params(struct spl_in *spl_in, struct spl_out *spl_out)
 	// Clamp
 	spl_clamp_viewport(&spl_scratch.scl_data.viewport);
 
-	if (!res)
-		return res;
-
 	// Save all calculated parameters in dscl_prog_data structure to program hw registers
 	spl_set_dscl_prog_data(spl_in, &spl_scratch, spl_out, enable_easf_v, enable_easf_h, enable_isharp);
 
+	if (!res)
+		return res;
+
 	if (spl_in->lls_pref == LLS_PREF_YES) {
 		if (spl_in->is_hdr_on)
 			setup = HDR_L;
-- 
2.34.1

