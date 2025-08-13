Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEB07C87FCF
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Aug 2025 23:28:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5DC4510E7E7;
	Wed, 13 Aug 2025 23:28:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vJOfxhYw";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2053.outbound.protection.outlook.com [40.107.236.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FB5910E7E7
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Aug 2025 23:28:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=luR2qPl6MEwl6EVdae1d8kl2rtXke/oo7d3BRI4PXsYVamBaj1ZsFPJjMCrDJUMehlDhqu32TcQbGC4EiYDUTi4MZ3WE+7irM3yntTWNvnPl/Xnm8AXUwVSxIkjpebhlfpun4otej1o+Wq5ap15xFkPw5Qn/JhWS1OfLkUykx8kxLjo0aNINwTEplQRxTlYr4WmlupFp4l+m/XkHqOOYnwhfO1S/CBlUWm17uEug3XlitR16bjx7VK3sveRfiGvzbTWFyey7bbF8IAyNLaGEuLv5gbiPfibdsljcNBkGUBMjH2F3DWYGgBCUDkRVw8cW/g1XGwFYuIiZKkaH8aXeOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bXscb0t1cD4UX5/qTd2e56sTUyardSIx3J9zA/1Mm/k=;
 b=NlS7imWuPeDv3JJRyTf0NwqH6oUAemDD4Rk+3A13FZU5Bg6sGNc7xlRNF7HrS3bGdpFRDFevTEqGw3mExsdJ73AJPfibyBH6BZetRNJnxvuKQOyRVDiY4IEfXoR9ZQfeIDi6XxKfTAClVJc6Pi8AEZ9BThrfgILSi86nzEQICkiI3lVPypkFW/XuqTaup2SQjRNTRVQasQjTAUWdoqScb4kW2sG6rHwE+6u+VbgqVY6BOranuxcdpnIvz9TlPToNFo5YZM+/bSXhr3Lzur2gW2Uy1Wq6mZUWwmMU1gmPArOZjPVpTeglUhmWubtCsU4GRU3RRvTD2CkzfMVVwZlC/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bXscb0t1cD4UX5/qTd2e56sTUyardSIx3J9zA/1Mm/k=;
 b=vJOfxhYwtOi1+pt5hnZ667hFQcWA3X3x9yv5PsUQb4m0Q4/ifhzaS2CgQbta8i8kFsOTn7/I5n2fdbOFWFpHoVkiOR4BiUbH51/z0O3J864lHB4+OLOfRRiQXV3fhfpnrPmTTplu3aYYNR4BxRODbAhmeqxS26J7Y5fc5r6Gi0g=
Received: from DM6PR12CA0013.namprd12.prod.outlook.com (2603:10b6:5:1c0::26)
 by DM6PR12MB4466.namprd12.prod.outlook.com (2603:10b6:5:2ae::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.14; Wed, 13 Aug
 2025 23:28:33 +0000
Received: from CY4PEPF0000E9D0.namprd03.prod.outlook.com
 (2603:10b6:5:1c0:cafe::b1) by DM6PR12CA0013.outlook.office365.com
 (2603:10b6:5:1c0::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.16 via Frontend Transport; Wed,
 13 Aug 2025 23:28:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D0.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Wed, 13 Aug 2025 23:28:33 +0000
Received: from SATLEXMB03.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 13 Aug
 2025 18:28:31 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Taimur Hassan <Syed.Hassan@amd.com>
Subject: [PATCH 09/11] drm/amd/display: [FW Promotion] Release 0.1.23.0
Date: Wed, 13 Aug 2025 17:18:17 -0600
Message-ID: <20250813232532.2661638-10-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250813232532.2661638-1-alex.hung@amd.com>
References: <20250813232532.2661638-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D0:EE_|DM6PR12MB4466:EE_
X-MS-Office365-Filtering-Correlation-Id: 033eeefe-db65-4dfe-fb68-08dddac11e78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lBeDR/2IETVQsqKbHmJ8+B1sLxEKat5xwZbDKHW0sWFjdXdRWhvdud6uBmWy?=
 =?us-ascii?Q?ETM5zIgjRo3blfljuB1Ozie+UCXtPasI5l08QnSxrAoITpMFVn3lasf0PeSb?=
 =?us-ascii?Q?DaR+XbmLD/5RViohmJavFCLyZ4DtoS3TNQk6ZZcHQ3BzzoiSgAFOKcDbSjm2?=
 =?us-ascii?Q?gkDlXTD1JeRFe4qyWEq+WNOCk32xvJvNIoHpbZD+8LbhdPvB/rnZ10sxL56p?=
 =?us-ascii?Q?j8snximAcPKFxMlPLd9laTEtR/mTEOWBx/VaiZnsqODBiThrOOnnIdvu2Lzk?=
 =?us-ascii?Q?lKI9c1eC2XeWkcI1erSXYRPqRAMjr8LUSbXiQAX4iA/5M/31ECnTamlFhySR?=
 =?us-ascii?Q?40sVcf6jjZ+4NIfW9FKDtarOqRVoUaS60E+npUU3XrZpRBehABIpldb+qzMu?=
 =?us-ascii?Q?aEn2SYLfolT4zti7DUaVWrxydg9ro1KEIllaysUyZOrZsdM5ic71RzkqyTRU?=
 =?us-ascii?Q?k+f68m5E/eDJ79pXbWbpHI4KNnPqUdmf1UpkGehnV6KOWxx40dZ+ADQi/KES?=
 =?us-ascii?Q?a/zHzyPeXDCFlz8ET3hmZKDw3dtEGJJO7IgEuCE/uV+lna5Ul0Q/wG+x2ejP?=
 =?us-ascii?Q?bh8537GluOz/5+JvJazy6rZpZc6fyPtvDQVDHsxZcnPxke06aVKQIl9S031e?=
 =?us-ascii?Q?1RccnGzqtS0Zu6X8uHEFtVznWzTJwwVIR1ANl9NJ8uH9W3i9dW1vgXhRFZES?=
 =?us-ascii?Q?GV0YrcsbzVV+fMv/MZCiQz6L3x/LZR14gx9danrn7pLzT/CdeIz+o6/KjAQz?=
 =?us-ascii?Q?bVeHzmSQxXK7+OItHt6hNcXh1QgDUIX1zdf19bqnx3t4aMcqeciLsqNC++8d?=
 =?us-ascii?Q?PMoekXsov9B8v9I4FdTk5ngFk/yfTEkxVW0eaEEX0BQ7JMUqcw64pleF6nW2?=
 =?us-ascii?Q?0KH+ZffGc8oLHhGLcvacIQLGS+mlXoCbAV5HNIPMj59DBDSh/maFJV4/DfaI?=
 =?us-ascii?Q?XY3Vmu0m70OMBtag6QCdWO4MXLG8NhXXTbyhHJAm3rgGmknpGCFoqANwziA8?=
 =?us-ascii?Q?0kQ7ZdogJN5qPFXoudzSMsoXLwsmga0k6b221EXGB/RUUo+n6zWIotN/kwky?=
 =?us-ascii?Q?gHY2iouqK7bhaEC0NRk8EwGOwhTyfa/TSdXQwNpsByP0DD8DpRAAiIb/wZZy?=
 =?us-ascii?Q?7cHbp2GhEVHwN2RWKRW2aTgGKaSPuiNDnAV5LpKAGY3TS/5Ew3niNP/WZ469?=
 =?us-ascii?Q?An5UsOmdzUWOgTtasFfXh7V8Wp67thS/JeDCHuADH8BfcvseFTrF8RIUcxY5?=
 =?us-ascii?Q?Sbza+fcANnEGibynxm+sF+OJO5X6W6AzqHU3BwMOY3H2TiZmOA45c8kcqEh4?=
 =?us-ascii?Q?DaFHBKLF5pYj36n0ZaSNM9ACBNt7NDURS830Ew4fakrcQMbqCqYcI7mIqv9v?=
 =?us-ascii?Q?FynqV8aQHDLCPt9N9GpTTWI/poPHHmvVMQNquH6R+mbBEyO34WYfKw7Gee2Q?=
 =?us-ascii?Q?c8XqWSgTNnq77OxGOuY/2S3WXf3k4Z1ARcIqnkbwgYkdSlv7l3kJ5KSfY+e1?=
 =?us-ascii?Q?hAPZACfS+mSAmWT7OWBXCem+xacRGV3h2G+x?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 23:28:33.0396 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 033eeefe-db65-4dfe-fb68-08dddac11e78
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4466
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

From: Taimur Hassan <Syed.Hassan@amd.com>

1. Fix loop counter.
2. Check whether rb->capacity is 0.

Acked-by: Sun peng (Leo) Li <sunpeng.li@amd.com>
Signed-off-by: Taimur Hassan <Syed.Hassan@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../gpu/drm/amd/display/dmub/inc/dmub_cmd.h   | 21 ++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
index 52295efdba63..d7008d84c1ec 100644
--- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
+++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
@@ -6542,15 +6542,18 @@ static inline bool dmub_rb_full(struct dmub_rb *rb)
 static inline bool dmub_rb_push_front(struct dmub_rb *rb,
 				      const union dmub_rb_cmd *cmd)
 {
-	uint64_t volatile *dst = (uint64_t volatile *)((uint8_t *)(rb->base_address) + rb->wrpt);
-	const uint64_t *src = (const uint64_t *)cmd;
+	uint8_t *dst = (uint8_t *)(rb->base_address) + rb->wrpt;
+	const uint8_t *src = (const uint8_t *)cmd;
 	uint8_t i;
 
+	if (rb->capacity == 0)
+		return false;
+
 	if (dmub_rb_full(rb))
 		return false;
 
 	// copying data
-	for (i = 0; i < DMUB_RB_CMD_SIZE / sizeof(uint64_t); i++)
+	for (i = 0; i < DMUB_RB_CMD_SIZE; i++)
 		*dst++ = *src++;
 
 	rb->wrpt += DMUB_RB_CMD_SIZE;
@@ -6575,6 +6578,9 @@ static inline bool dmub_rb_out_push_front(struct dmub_rb *rb,
 	uint8_t *dst = (uint8_t *)(rb->base_address) + rb->wrpt;
 	const uint8_t *src = (const uint8_t *)cmd;
 
+	if (rb->capacity == 0)
+		return false;
+
 	if (dmub_rb_full(rb))
 		return false;
 
@@ -6620,6 +6626,9 @@ static inline void dmub_rb_get_rptr_with_offset(struct dmub_rb *rb,
 				  uint32_t num_cmds,
 				  uint32_t *next_rptr)
 {
+	if (rb->capacity == 0)
+		return;
+
 	*next_rptr = rb->rptr + DMUB_RB_CMD_SIZE * num_cmds;
 
 	if (*next_rptr >= rb->capacity)
@@ -6683,6 +6692,9 @@ static inline bool dmub_rb_out_front(struct dmub_rb *rb,
  */
 static inline bool dmub_rb_pop_front(struct dmub_rb *rb)
 {
+	if (rb->capacity == 0)
+		return false;
+
 	if (dmub_rb_empty(rb))
 		return false;
 
@@ -6707,6 +6719,9 @@ static inline void dmub_rb_flush_pending(const struct dmub_rb *rb)
 	uint32_t rptr = rb->rptr;
 	uint32_t wptr = rb->wrpt;
 
+	if (rb->capacity == 0)
+		return;
+
 	while (rptr != wptr) {
 		uint64_t *data = (uint64_t *)((uint8_t *)(rb->base_address) + rptr);
 		uint8_t i;
-- 
2.43.0

