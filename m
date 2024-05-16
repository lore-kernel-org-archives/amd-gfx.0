Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20728C25B74
	for <amd-gfx@archiver.kernel.org>; Thu, 16 May 2024 19:27:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B17210EDC5;
	Thu, 16 May 2024 19:27:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CHSUKrAy";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2057.outbound.protection.outlook.com [40.107.243.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D195810EDBB
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 May 2024 19:27:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bmIjBs4cadhbA0urghKXT0xp7ymWq+Uxa1+i+i0tAYtZdkN+cayiWV7F9KIdmbwPljhf0SYvYWUf7hADNVLDipz335vzQbZVg/ig9/IVX32bkTwxQ73QQAaOMTVBNnFTqq/qLrT6p+/u60lBQWPHL76Ol0/YoTxT+FVtZ/RZW4ZQu6cxUHtqLQcFR8nXI5JswKIU431kFqutHEoc8KTSrvMKdxJWpHe3d2p4EVQiXY8uwfBRgUVUbpX2h6MPBXr3xCxQxpgEAKY+pQLThCXPSd5r/L8KN1iWja8gpuL+oCWqMDaTwTfeFUfD58KCIHEfkt85iAtAdjJsGITCl1KSbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2322cHGElefxDZSoFDWAKk0locmJujKgAUkL0A8CDOA=;
 b=jMvOpTTUy8LiXeqDKVY/VjAPDKNf2WdiJYVJjgvcjA9zIMhFdDCH6kqK0AE06SswoOKftMMDqvMBwFKh3CRBfTQo1MlL0R5jpQ56ixhvym0m76+BPOa7HEbXJM8XeBVeh9yGQWJ4b12ngr4kj+Dwjeqqmq3GHCmfK2SDbFkNEORRLx1CzGAzCEl/owI4tr/vEMHnDQTi01EyTBmQJS1gkml5DfeozGT8iIbEUZIYVg23q2XNV1Vyp8psVTsRcr7WcJ3Zh2oUZHhMa3E03XW70/80hKlkwbuKIoYDHBNkH7n9wUtLetoLziJ5ZgAO+a2agdEZjFwUpvjcL32XovKx+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2322cHGElefxDZSoFDWAKk0locmJujKgAUkL0A8CDOA=;
 b=CHSUKrAypiY6bDZWyKU+WuHr8zT2E15L9RoF38TxJBkoTCKFJfwObHoaB56IXl/rHRWDJNQfDL85NSUNeCCeQhj/H7TAkL9IAOCW5my5gXTWrov+ob4gzLVCMq9gpU08IhqR490EBwjlmT2EplqD2wlQ+r1KbLDlgkfINKb2Z2U=
Received: from BN9PR03CA0265.namprd03.prod.outlook.com (2603:10b6:408:ff::30)
 by DS0PR12MB6608.namprd12.prod.outlook.com (2603:10b6:8:d0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.30; Thu, 16 May
 2024 19:27:11 +0000
Received: from BN2PEPF000044A7.namprd04.prod.outlook.com
 (2603:10b6:408:ff:cafe::2a) by BN9PR03CA0265.outlook.office365.com
 (2603:10b6:408:ff::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.26 via Frontend
 Transport; Thu, 16 May 2024 19:27:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A7.mail.protection.outlook.com (10.167.243.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.21 via Frontend Transport; Thu, 16 May 2024 19:27:10 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 16 May
 2024 14:27:09 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 16 May 2024 14:27:09 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Cruise <cruise.hung@amd.com>, Wenjing Liu
 <wenjing.liu@amd.com>
Subject: [PATCH 22/24] drm/amd/display: Not fallback if link BW is smaller
 than req BW
Date: Thu, 16 May 2024 15:26:45 -0400
Message-ID: <20240516192647.1522729-23-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240516192647.1522729-1-Roman.Li@amd.com>
References: <20240516192647.1522729-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Roman.Li@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A7:EE_|DS0PR12MB6608:EE_
X-MS-Office365-Filtering-Correlation-Id: f79b7f22-3210-42a6-17ae-08dc75de2ee4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|82310400017|36860700004|376005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uShdxGtsGv8ugjgeCj45qqKybJOKYuNwX8L3txdxQ6kd+r28f8Fk84neLAVV?=
 =?us-ascii?Q?k5qj1nBrZCuTt5GPrRlHLW+DuhI4UGanPjQtP/Fygv5tHu7KpraO4E/G8/ut?=
 =?us-ascii?Q?IeWcIQ1dLQ1gl3DCNS0xv5CV7L3hL2UQHr9ewxig7ky34JcymUomvITOqwpi?=
 =?us-ascii?Q?yab63DNK4gIBtYxFXgI4yQkOSfNjp4kM90fARduMsLs7fscWW2P1Gy8d8ruK?=
 =?us-ascii?Q?M3+yTYm4epEeCt27txx6Z5zwV2/aWncnunHlel9IomcFRaeGfTqOmzUzKZZM?=
 =?us-ascii?Q?hujzh4t2Lj58TI1I/yavGGyO1EkmHYKjGqjne/fI1dTKkKafSAOeDgzJNEbv?=
 =?us-ascii?Q?pbvmlC6egwrQEC3UZcRpm105OvBb6gnW6Blzpk+uy+ETyJmDkRkMCZaXAKUa?=
 =?us-ascii?Q?owyIWyDvnlCz1pyPnmaEZl9XjYkAZyPBeKRXl8hleDIjWw9eI/tvMWCEuL24?=
 =?us-ascii?Q?iEkzVn6G73htle8DXh6yKmcCUlCbT9R5jAOjKfPOgju5EOpE5rOnVYfZ1MJ5?=
 =?us-ascii?Q?NO8TM6mVnZYdThodCaQIVexK2rXPibuk+CwfI5xzntLhtefI+YbfANRyrk9o?=
 =?us-ascii?Q?EWOljZXj0sFkoW3JX784ytwnmykFVYHDya4drlXGSA1j8M1wOf2CQTPndu3v?=
 =?us-ascii?Q?Tt5PdH5xPezaaoWCk89g2M1wUZ8KFWAvZBmFWDfk+xybd668MB4W9OKoZs1D?=
 =?us-ascii?Q?ieOafvFwDirQsz8GaBCRpcogZ9KKPtxtLQ/vaBgdZXcWepTfd+5KRe/BPOcI?=
 =?us-ascii?Q?K/7fw0H454iHvBrwlbxM/QxfUypibaLisSlzn0WjwkhjniyNwyS/TdNWznq4?=
 =?us-ascii?Q?wxTlEzSU9FpXDR9EvbMBQLzWDPPtLUHAXTJQYVtKejs4qG6EuvH6sP8So8Sx?=
 =?us-ascii?Q?HyqqwONH1y+XFQX6y1p3MsG1c9uwBbLX0bXzPTlt/qP5COkKZZC6WP5LZhxt?=
 =?us-ascii?Q?UMSiDJeVxX18JEzG/xDdOAI24pUb5HfOWSjxSH+OUbtTb3suhXkma6KuuLzP?=
 =?us-ascii?Q?sanfwMv0ihJXjmEyFJ4Kn+A+JmrjKVAAYQYMhwTFco4tYSbV2bJqQUPeIYPQ?=
 =?us-ascii?Q?vQwm/nyHiRiUg+TToCfn7cIH839XKFRAy7qqasmm5lj2qS20IUkhNSduDDxq?=
 =?us-ascii?Q?tlkmOKVrVGqKjQtAgksYM2OJmKsHiVhElAYTrFc2CjllKsQ01RZfdK9gvjAm?=
 =?us-ascii?Q?2w7AJqmICHU0juWFXf3JXhgsuUNDcA4UEYb28FhBKoph7rPpG4qJQw/l5ZOK?=
 =?us-ascii?Q?V4eA0hz5o1w6m5uL4FjrKy3AFVCjOXEwnDKe17RJVoRWbkgjn8xZ+0MwYewb?=
 =?us-ascii?Q?cx2+6eb7F4FsTc3bC8tazJ6zL4kTqZYlmm3O2fW0VoPJ90jt2YeF16EmrJzW?=
 =?us-ascii?Q?ZDaAweKVbCRyUaljkflJmJhLoaYb?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(82310400017)(36860700004)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2024 19:27:10.9188 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f79b7f22-3210-42a6-17ae-08dc75de2ee4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6608
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

From: Cruise <cruise.hung@amd.com>

[Why]
When the link BW is smaller than the request BW,
the DP LT just kept running and fallback to lower link config.
DP LT just aborted if is_hpd_pending bit is high.
But is_hpd_pending bit indicates a new HPD event received.
It doesn't mean the HPD is low.

[How]
Abort the DP LT if the link BW is smaller than the request BW.
Remove checking is_hpd_pending bit in DP LT.

Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Acked-by: Roman Li <roman.li@amd.com>
Signed-off-by: Cruise <cruise.hung@amd.com>
---
 .../display/dc/link/protocols/link_dp_training.c |  5 ++++-
 .../dc/link/protocols/link_dp_training_dpia.c    | 16 ----------------
 2 files changed, 4 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
index b8e704dbe956..a93dd83cd8c0 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
@@ -1704,10 +1704,13 @@ bool perform_link_training_with_retries(
 			is_link_bw_min = ((cur_link_settings.link_rate <= LINK_RATE_LOW) &&
 				(cur_link_settings.lane_count <= LANE_COUNT_ONE));
 
-			if (is_link_bw_low)
+			if (is_link_bw_low) {
 				DC_LOG_WARNING(
 					"%s: Link(%d) bandwidth too low after fallback req_bw(%d) > link_bw(%d)\n",
 					__func__, link->link_index, req_bw, link_bw);
+
+				return false;
+			}
 		}
 
 		msleep(delay_between_attempts);
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_dpia.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_dpia.c
index edb21d21952a..cd1975c03f38 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_dpia.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training_dpia.c
@@ -430,10 +430,6 @@ static enum link_training_result dpia_training_cr_non_transparent(
 		retry_count++;
 	}
 
-	/* Abort link training if clock recovery failed due to HPD unplug. */
-	if (link->is_hpd_pending)
-		result = LINK_TRAINING_ABORT;
-
 	DC_LOG_HW_LINK_TRAINING(
 		"%s\n DPIA(%d) clock recovery\n -hop(%d)\n - result(%d)\n - retries(%d)\n - status(%d)\n",
 		__func__,
@@ -537,10 +533,6 @@ static enum link_training_result dpia_training_cr_transparent(
 		retry_count++;
 	}
 
-	/* Abort link training if clock recovery failed due to HPD unplug. */
-	if (link->is_hpd_pending)
-		result = LINK_TRAINING_ABORT;
-
 	DC_LOG_HW_LINK_TRAINING("%s\n DPIA(%d) clock recovery\n -hop(%d)\n - result(%d)\n - retries(%d)\n",
 		__func__,
 		link->link_id.enum_id - ENUM_ID_1,
@@ -731,10 +723,6 @@ static enum link_training_result dpia_training_eq_non_transparent(
 				lt_settings->hw_lane_settings, lt_settings->dpcd_lane_settings);
 	}
 
-	/* Abort link training if equalization failed due to HPD unplug. */
-	if (link->is_hpd_pending)
-		result = LINK_TRAINING_ABORT;
-
 	DC_LOG_HW_LINK_TRAINING(
 		"%s\n DPIA(%d) equalization\n - hop(%d)\n - result(%d)\n - retries(%d)\n - status(%d)\n",
 		__func__,
@@ -822,10 +810,6 @@ static enum link_training_result dpia_training_eq_transparent(
 				lt_settings->hw_lane_settings, lt_settings->dpcd_lane_settings);
 	}
 
-	/* Abort link training if equalization failed due to HPD unplug. */
-	if (link->is_hpd_pending)
-		result = LINK_TRAINING_ABORT;
-
 	DC_LOG_HW_LINK_TRAINING("%s\n DPIA(%d) equalization\n - hop(%d)\n - result(%d)\n - retries(%d)\n",
 		__func__,
 		link->link_id.enum_id - ENUM_ID_1,
-- 
2.34.1

