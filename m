Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADC61C5B549
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Jun 2025 19:38:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49D8210E7B7;
	Wed,  4 Jun 2025 19:38:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XPulJWKD";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2045.outbound.protection.outlook.com [40.107.95.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62B0F10E7A9
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Jun 2025 19:38:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U3U+qye1qEj8gGVpAh3Ps3P+60P+bhkXIJNZvJueP63F6mnTlg7QMBf0nx42r9yPR4oZ5pwRFUxAVVbawKZ8jFNFX1QrqMegIZwimTh1uCVp3KW7oOspHNaw8wZk7zQPL9rV7/jfCI+48foimwYz9TjU0+sy2il0+JCo37pURjSc/zTHfDgV2AO5C9K8ZyptiBcIJBBQ3M90ae49Fe5xsoz/mB9v5ND8TGXfKjtvket2Z3uSpOC2Muv9cTgbxGwdBke99jN5mBx/W3zMuiYpiianv9xjncagKgEsm0T34So8dZ7ZnMo+PXHf2TfohyjN3wOilP1bZ08CHkdurMOo+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YRgKZv/y2IUrXkIVgemrVAB0Tf/4HpYTrtFgqbiLsa4=;
 b=h9EjTgT9Ynv4UPHxpnJdoDPjYImv9Ga/9ZfykRT0PQiOn2M4GYi7QyXtvNRAGJ98m2M2tH0bpKUZmO85F1eRVfXlTFl5BxQDIADOc4+0Zr88tQIotaUquXdHwug2n/wLQ99eqVRoe0OfcqC+ZrkhuXAC+Pd7xxlXF/2I3lUNyeTfP7SR97eOK497qBhhzLswVE25rlISdXPt8m1XMUymIlc//8bvOJSk0NyYkHR3F64Mpm9HbmUqy2n2DhnU35Kqlof1p7g6lwkX5wWdoV5ZJCaBIEe0iMs2u3Y96OexOoNxJukLO/zbdKcqDtN86UkNzLHgoEVje2oaqhMaZhAfYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YRgKZv/y2IUrXkIVgemrVAB0Tf/4HpYTrtFgqbiLsa4=;
 b=XPulJWKDtoC7k6zS+DiA8RR2k63PDZ7NPdsqGbzGsRVW5ZWFn7jCNHOaDveBduuFJ9os2CL968Gu3kzR4SJsxzFjeoMbOhFgjhINTrfIN3QEPepR1BDwbLm+6llleEIOm0oNLROG2BTwX1F7wuwc94x7l7ERRfoCZrTJigUpdKM=
Received: from CH0PR03CA0253.namprd03.prod.outlook.com (2603:10b6:610:e5::18)
 by IA0PR12MB7507.namprd12.prod.outlook.com (2603:10b6:208:441::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Wed, 4 Jun
 2025 19:38:05 +0000
Received: from DS3PEPF000099DD.namprd04.prod.outlook.com
 (2603:10b6:610:e5:cafe::bf) by CH0PR03CA0253.outlook.office365.com
 (2603:10b6:610:e5::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Wed,
 4 Jun 2025 19:38:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DD.mail.protection.outlook.com (10.167.17.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8792.29 via Frontend Transport; Wed, 4 Jun 2025 19:38:04 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 4 Jun
 2025 14:38:02 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Alex Hung <alex.hung@amd.com>, Cruise Hung
 <Cruise.Hung@amd.com>, Wenjing Liu <wenjing.liu@amd.com>
Subject: [PATCH 03/23] drm/amd/display: Add DPIA debug option for zero
 allocation patch
Date: Wed, 4 Jun 2025 12:43:14 -0600
Message-ID: <20250604193659.2462225-4-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250604193659.2462225-1-alex.hung@amd.com>
References: <20250604193659.2462225-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DD:EE_|IA0PR12MB7507:EE_
X-MS-Office365-Filtering-Correlation-Id: 253e1146-d50d-4043-d7d4-08dda39f5322
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hbst9B1ts6NlwBGt3sWOYx4HYzZvMhXQYWdUEXgk8jHXBEFzx0ScySs2cIic?=
 =?us-ascii?Q?k6lBNrJLlLzVtcOah3PNV+i3+mfj3H5AePrhyRIKFqNJ+KDzRSnfHnSJbq68?=
 =?us-ascii?Q?tEemIu95TuXAgKyORusD92NeycHGxWIBYS5nxgIngGlRxCFgRQpVEQCiu+ew?=
 =?us-ascii?Q?e5heLRxUjhrdCw7U7cFgO776QrKxeK38VewTvhVKedsd+hLrGaMmP2n6oDuG?=
 =?us-ascii?Q?VZUhii5LsAxrjfCaTnoDE51GPPP0+JBD2l49GQH/CDSaGKINRRZQJLgMg13r?=
 =?us-ascii?Q?8qoolof+eRBw0wxyOIJ5MNOJ0aaXmvgDvLs+AlJi/VkB10a0dYxnGv8qVgB+?=
 =?us-ascii?Q?+Dn/4rBuZkSNnq1jgtGwoGndlW2qh+/bFcg5ZKsm3fyMl7CDvfnZjvA9H4aL?=
 =?us-ascii?Q?dyuD9sJYVdGzJhflTPos2/NGzeclD7jylNy6Arc+AMVAfn06m+zqxvQwM7XJ?=
 =?us-ascii?Q?uf2cAhTGdlZqeeVFnrL0ZRw/1cwqoPcdp+Md6GiB/wq1YNbzMOQjYTwJOGXQ?=
 =?us-ascii?Q?ubu5D32MXpVduyT7I88mHU8/kLMAu5ufVULMwrv07QXgcI+bEUXum4hdQZIv?=
 =?us-ascii?Q?PnuarPVJCYoPLAIYoRASuf1Ae2Zr5itxyDE0WfZr5OjgPEwitGG9pjYlMrmI?=
 =?us-ascii?Q?bDmcL6pBak832uKMyvQ2h6D+C8Z9Af9GysFU1HuMi9cjZ8P/GnvZs69k67QN?=
 =?us-ascii?Q?j5OfZetPknwqdRwVvS7kAW6hdhUXw5D4ycRZoTxXne8nyY9C6h4bH5HeYttn?=
 =?us-ascii?Q?HS46xutLVxFl16Z5VIezjIeVS5xpjA7pZ1FGgFIiZRiAzTObwBxzJ2ktKsS3?=
 =?us-ascii?Q?1KOuRQajmeCg0tII0yLXNxcjxlJhf/w13PJY4/3ff3y/ZGJ07VWytPD2Osxe?=
 =?us-ascii?Q?OifLbEtknFZry6RbgU89nOEg/89vpMeM85fczMFOzqFgbi1i1cWhZBy63VP2?=
 =?us-ascii?Q?egn2ejfzZKoWy4nlG5z6MsffyeNvqZVpq4HufvOan30QF4gE33ze5AvnN0R3?=
 =?us-ascii?Q?Z83z5WmrJeqMhhKokKOWT+f3FaLVBkxCtzbd3LoJqm6sPtG4+V4XxOn+PWge?=
 =?us-ascii?Q?i09fV4cYv/2ZOO/g0uafA/wWjmEWyf3ga0fCcOafgNUxqLJtFwwoBl6MObTF?=
 =?us-ascii?Q?+sQw3m4FOc5+26FAoXmsDOuQIiwvIGeSxmvixP20g/+Kc3lqNpZvr2Ey7+hw?=
 =?us-ascii?Q?ZmkTVTYhlZL1dATOdeH04Jxu2lcFmA5TNMCLw77dGaI/8pjcQntiMK7/OHFc?=
 =?us-ascii?Q?E/zXxVh4mbw/YAPfBbKPm+hLMn9FY/FClQqkTs3wP4/kdRV/+8TAVa9bApOq?=
 =?us-ascii?Q?NJo3cURnbzqM0ha6eu0jkegd7kfIBkKud40BIF37218c2mj2ob9sZVpMYn1v?=
 =?us-ascii?Q?jh/Rt5vj5nx3CZRROjqqVXY3t1LDWXfhFCOzXCrnqUstNv9djKbaxK7WRlXe?=
 =?us-ascii?Q?EUW9b7JkqORoj8wrOEYmdBpgLQZn3OG/UK2QH+T/EHK1LzaoBR3WQ+AZ8XTY?=
 =?us-ascii?Q?028O/CdwU5xKwdnAMbTzoxE5R7L2Ak1xwyJz?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 19:38:04.5592 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 253e1146-d50d-4043-d7d4-08dda39f5322
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7507
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

From: Cruise Hung <Cruise.Hung@amd.com>

[WHY & HOW]
The BW zero allocation patch is no longer required.
Add a debug option to enable it in case we encounter an issue.

Reviewed-by: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: Cruise Hung <Cruise.Hung@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h            |  3 ++-
 .../dc/link/protocols/link_dp_dpia_bw.c        | 18 ++++++++++--------
 2 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 5c01a535b4fa..83ee6ddaddb7 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -824,7 +824,8 @@ union dpia_debug_options {
 		uint32_t disable_mst_dsc_work_around:1; /* bit 3 */
 		uint32_t enable_force_tbt3_work_around:1; /* bit 4 */
 		uint32_t disable_usb4_pm_support:1; /* bit 5 */
-		uint32_t reserved:26;
+		uint32_t enable_usb4_bw_zero_alloc_patch:1; /* bit 6 */
+		uint32_t reserved:25;
 	} bits;
 	uint32_t raw;
 };
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c
index 3af7564a84f1..642feac5a673 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_dpia_bw.c
@@ -304,14 +304,16 @@ bool link_dpia_enable_usb4_dp_bw_alloc_mode(struct dc_link *link)
 			link->dpia_bw_alloc_config.bw_alloc_enabled = true;
 			ret = true;
 
-			/*
-			 * During DP tunnel creation, CM preallocates BW and reduces estimated BW of other
-			 * DPIA. CM release preallocation only when allocation is complete. Do zero alloc
-			 * to make the CM to release preallocation and update estimated BW correctly for
-			 * all DPIAs per host router
-			 */
-			// TODO: Zero allocation can be removed once the MSFT CM fix has been released
-			link_dp_dpia_allocate_usb4_bandwidth_for_stream(link, 0);
+			if (link->dc->debug.dpia_debug.bits.enable_usb4_bw_zero_alloc_patch) {
+				/*
+				 * During DP tunnel creation, the CM preallocates BW
+				 * and reduces the estimated BW of other DPIAs.
+				 * The CM releases the preallocation only when the allocation is complete.
+				 * Perform a zero allocation to make the CM release the preallocation
+				 * and correctly update the estimated BW for all DPIAs per host router.
+				 */
+				link_dp_dpia_allocate_usb4_bandwidth_for_stream(link, 0);
+			}
 		} else
 			DC_LOG_DEBUG("%s:  link[%d] failed to enable DPTX BW allocation mode", __func__, link->link_index);
 	}
-- 
2.43.0

