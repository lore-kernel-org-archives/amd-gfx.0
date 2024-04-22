Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E0DDC4345F
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Apr 2024 15:30:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 13786112BF7;
	Mon, 22 Apr 2024 15:30:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JaJitf33";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2052.outbound.protection.outlook.com [40.107.102.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 453AC112BF7
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Apr 2024 15:30:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RVlsO4QDqAPW/G/9pKqwUTybbHrE461PBX9A/1kv29wdDgHt+xiMjLYg/NwOVoPS502f195rHr7rwUV9hdUumoF/RlJLoUvEce1cEHfO29lhJ0Zc8oDk2qPG04UNvDfgTo8OoAQEOOLFBcmJrACUZQ1LmLFCQW67rZJ81zgpSRwHT30aLf9KS2qvXxbTMh2+aIyO7CP2xn/H8NXoBThEPKJyTv4kDphpiLlUqruntwIkIXmSzxcyTsVSxCv1Qy+oHcE+s3oteNzpFcWtFtaORGjVupAZx20sg4AOoIu1U09U6xIIYVU0ZmSZL7t16mrYWJhm1Ott3LvD9Hb/S0ujPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7icBvHMhKTKAT00a8302U2DoRA7bpidj34qTPnHi1v8=;
 b=NboGSInQNpMi+68ci3BWq1WMRdfIuftCBiMbEG0R0gtMvhDovirsbTApeBxrM1H/zHzDxj8GKU7vhruvKFT8ykBTqs9CY1YDVIvSmQ24QH0bnqNmFOm/rjHKvQveFJJa7k5X3Z099gx7hV/KnO6HUhWnXJBW1PZsNcrLnl7i6CY7FwsTitRl85OXmBS0CnPzeuQcRu90W2E/kP3NJvI+v8W15PTZz1f1TXfs1FR82ty0GNYowh0zZwFJK7VjxgKRmc6c65CMDEAKd3WQr2YtfbTkPHxK5fNUtwZg1p9RnAVHuep+mFzX1Md9Jx9SUspr7SbI0uqn0e2sGgry8qKwqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7icBvHMhKTKAT00a8302U2DoRA7bpidj34qTPnHi1v8=;
 b=JaJitf33Dis1kteCYr0009TKfnMAGxJ8uSRMeT9pErXRa3E/pMvc+ntfUKVMjevrcmABOfzkyO9SDc6/yKEuilD0VwjN42WOcQERuIBOrcDX78FIIArt1ufpovbE/qXQ0pn7EH1Jx1IlnOA15usbI4DX5k+nbpVIwuSa5aQCpOI=
Received: from SA1P222CA0161.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c3::9)
 by CH3PR12MB9455.namprd12.prod.outlook.com (2603:10b6:610:1c1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Mon, 22 Apr
 2024 15:30:07 +0000
Received: from SN1PEPF00036F3D.namprd05.prod.outlook.com
 (2603:10b6:806:3c3:cafe::b6) by SA1P222CA0161.outlook.office365.com
 (2603:10b6:806:3c3::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.34 via Frontend
 Transport; Mon, 22 Apr 2024 15:30:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF00036F3D.mail.protection.outlook.com (10.167.248.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Mon, 22 Apr 2024 15:30:07 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 22 Apr
 2024 10:30:06 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 22 Apr
 2024 10:30:06 -0500
Received: from aaurabin-suse.king-squeaker.ts.net (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35
 via Frontend Transport; Mon, 22 Apr 2024 10:30:00 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Sung-huai Wang
 <danny.wang@amd.com>, Robin Chen <robin.chen@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>
Subject: [PATCH 19/37] drm/amd/display: Handle HPD_IRQ for internal link
Date: Mon, 22 Apr 2024 11:27:28 -0400
Message-ID: <20240422152817.2765349-20-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240422152817.2765349-1-aurabindo.pillai@amd.com>
References: <20240422152817.2765349-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: aurabindo.pillai@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3D:EE_|CH3PR12MB9455:EE_
X-MS-Office365-Filtering-Correlation-Id: f71075ac-a622-406d-0894-08dc62e116f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qHlbEVf/kZuGxTGxTp/UfxCK4qcVaX9b7wpXRl34VFcWyFMSNTs6ZvW0scWl?=
 =?us-ascii?Q?bASsom4nSd0Qsbf79GZ4Ec1OqnYVUnrk4jkcI7BvxkWgEsdjOrFDvUkIFGH9?=
 =?us-ascii?Q?x1g8Bs9PaTY9xZrs0MLPd/mEbDaSgTmfY6+fI8EEqGAm6x+BbCHkAgFvpS19?=
 =?us-ascii?Q?AOXJ+o2no0yWL1YObTErv+pSzxUus/YetCNSJ/IVdtul+xfquC7JxIU6i5WU?=
 =?us-ascii?Q?/vraAd5vRYFjrWDWxPzuPeRHoa3oQu/CURtlBrTvGKta/7quEMd6HYWvQE3U?=
 =?us-ascii?Q?UOvKzOXNw/VYRNOwDKpEFAK0yuNvbOuq/WEnkT8ecfVFnIxgwRjYuWrVMszF?=
 =?us-ascii?Q?yoXxsHHPTFfAOyAmOmHGWMzvRWVkvJmr0bQn98T5uvEAIRArK9r8vgeyrPtg?=
 =?us-ascii?Q?UGkeJo7q1tEAK8sZiNYTLR0hdvzAMf48oP7A7EH4rqeKaXZThHP5SouGxxNC?=
 =?us-ascii?Q?y71CoYKLrF3smv6mSEvJp4DowOt6fgI+QevG0odq1sIF0VBGg95agcXnI/3u?=
 =?us-ascii?Q?qb8c30JshKfOz4ippm9VgVKI+Wbd96GEzjlndqm8n8fVgLcHVmLVTQikWKh6?=
 =?us-ascii?Q?DrgCCMeUm3KEm06Ok9YfU9LYV0trZyQF3JhvWZ8ywEVlfPfEX0ZLvuo+n3F3?=
 =?us-ascii?Q?2elRGwSQhB0LVbzoL3GwvURm+WDvl5oAFL/nv1UemkLgt37NmX08ZXhsX7rM?=
 =?us-ascii?Q?GdC31htxU5ZHbGwFAjcHLbyBO6efcxSoQG0+eA+Kro8IaAK+Kqp6H95DSBkO?=
 =?us-ascii?Q?jaIsRm6KsE7xiSF0vFoYbltVj2M/fjt7jrV+NoM/aCDzHMCtdKoOwqbEPSdX?=
 =?us-ascii?Q?OFJGeEw96bmDxmh0A6fI1GtJ0KybSquVuPzeFV1hDp6k4wBXZYcM7eP3uY+s?=
 =?us-ascii?Q?RJ+kCzclLf12wS23ZspfM+NZYITQP+GeMbbsnZTH4BTaTWfpgu/wrmJzeXHo?=
 =?us-ascii?Q?mkM3r1CTYr0rdMpCjByUhRZOtPK81bSLal7KD7E3/gkUoRQZg9TKuMkSixx4?=
 =?us-ascii?Q?aW9ckDqKZ+5/1Yb3aSbYiuqHmiPKZzV7by2QzlMzhDeKmWh3xW4wURqMuq1y?=
 =?us-ascii?Q?nocuTX74XfXj22730hXLRxlCA9gMy0ETpTD7PQSx9xeTolcGJYF7q2Nvaa2r?=
 =?us-ascii?Q?/KfUjFndXrHFBYvs+LSMtFoj3oJ9OJZFebLV5onUcoLPtXDFnyLA5zxVnYAR?=
 =?us-ascii?Q?hRD9O1P5DUXBuatF+kO8WpdePAvjjRWLmy9hKUCFwPXI2QBtmHfZW0U2IYNx?=
 =?us-ascii?Q?vHAX6cgxvdoX5O9dO8c5YaR4GA/h5z2H8KODFsfY/DzvBmd3Wym/QinVjSCS?=
 =?us-ascii?Q?tvhIKrftr0NOKSKUe8JJKGaLKmSaHhm4884TviqmiczQKsie4iGVjx5Gua7T?=
 =?us-ascii?Q?XhgiShU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(36860700004)(82310400014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 15:30:07.1438 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f71075ac-a622-406d-0894-08dc62e116f7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F3D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9455
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

From: Sung-huai Wang <danny.wang@amd.com>

[Why]
TCON data is corrupted after electro static discharge test.
Once the TCON data get corrupted, they will get themselves
reset and send HPD_IRQ to source side.

[How]
Support HPD_IRQ for internal link, and restore the PSR/Replay setup.

Reviewed-by: Robin Chen <robin.chen@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Sung-huai Wang <danny.wang@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
---
 .../dc/link/protocols/link_dp_irq_handler.c   | 25 ++++++++++++-------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_irq_handler.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_irq_handler.c
index ba69874be5a4..7dc7c25ac398 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_irq_handler.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_irq_handler.c
@@ -373,6 +373,7 @@ bool dp_handle_hpd_rx_irq(struct dc_link *link,
 	union device_service_irq device_service_clear = {0};
 	enum dc_status result;
 	bool status = false;
+	bool allow_active = false;
 
 	if (out_link_loss)
 		*out_link_loss = false;
@@ -427,12 +428,6 @@ bool dp_handle_hpd_rx_irq(struct dc_link *link,
 		return false;
 	}
 
-	if (handle_hpd_irq_psr_sink(link))
-		/* PSR-related error was detected and handled */
-		return true;
-
-	handle_hpd_irq_replay_sink(link);
-
 	/* If PSR-related error handled, Main link may be off,
 	 * so do not handle as a normal sink status change interrupt.
 	 */
@@ -454,9 +449,8 @@ bool dp_handle_hpd_rx_irq(struct dc_link *link,
 	 * If we got sink count changed it means
 	 * Downstream port status changed,
 	 * then DM should call DC to do the detection.
-	 * NOTE: Do not handle link loss on eDP since it is internal link*/
-	if ((link->connector_signal != SIGNAL_TYPE_EDP) &&
-			dp_parse_link_loss_status(
+	 */
+	if (dp_parse_link_loss_status(
 					link,
 					&hpd_irq_dpcd_data)) {
 		/* Connectivity log: link loss */
@@ -465,6 +459,11 @@ bool dp_handle_hpd_rx_irq(struct dc_link *link,
 					sizeof(hpd_irq_dpcd_data),
 					"Status: ");
 
+		if (link->psr_settings.psr_feature_enabled)
+			edp_set_psr_allow_active(link, &allow_active, true, false, NULL);
+		else if (link->replay_settings.replay_allow_active)
+			edp_set_replay_allow_active(link, &allow_active, true, false, NULL);
+
 		if (defer_handling && has_left_work)
 			*has_left_work = true;
 		else
@@ -477,6 +476,14 @@ bool dp_handle_hpd_rx_irq(struct dc_link *link,
 		dp_trace_link_loss_increment(link);
 	}
 
+	if (*out_link_loss == false) {
+		if (handle_hpd_irq_psr_sink(link))
+			/* PSR-related error was detected and handled */
+			return true;
+
+		handle_hpd_irq_replay_sink(link);
+	}
+
 	if (link->type == dc_connection_sst_branch &&
 		hpd_irq_dpcd_data.bytes.sink_cnt.bits.SINK_COUNT
 			!= link->dpcd_sink_count)
-- 
2.44.0

