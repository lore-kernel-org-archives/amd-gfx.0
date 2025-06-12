Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36281C61CE8
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Jun 2025 15:10:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC9D210E880;
	Thu, 12 Jun 2025 15:10:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QpqcxJHw";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2050.outbound.protection.outlook.com [40.107.236.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 701CA10E880
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Jun 2025 15:10:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tY8UggSfcPGLrFDEJUe8IOEFQS38ScIcnVRaipz3Z+/eAZ3SGG6Wr/5dQQQ9q05s2/NxXE2xXlV39/0PXXiTB1bqb6c0k1dK9xjuBwoz3qgyE1NCDooLfiWsl1pDAlRlraWH+73fQgOojWugPEkKQKxFLiTy1r/rFO2YhCXiMeEmFswh0B7ia0m7sPQut3b6ASwmjo8OrZ5Xq8IrdkTvAooAy5JKaKd3m8xvNzkhPMm6obIe6x0CXx5WkEIm4J7LRmFUNtndmeDlknt0wW8VKir5xD72d7/FJXDgrC80EV69nJHKATHX7XNKDm2BEgbHyoRM9VwdWhN2vf0uaK51ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IYPTc007MPWMjsbVYN2ieCzy5SoDKcvrQN1qwHp/OFg=;
 b=VYurBJC2ePL0+Vh1DDVLRMj6vn4kASC3sOqouViJPiwYpY3TpRffNJfC1+EEHWsMHG6oHtTD73FM74FpVdFKxDYO1GVh9aDdU+KlAfOSKBQCplMUQf3aBWyR6JB/ztpgBNTI9W5Y3/A3CWMZksmgUBLitnYoJAEH/v4FPBrrf5SCaOcVLjf8SctLr/l5f3n6qFKWEgFy/gT/iECZYeuHLXo6rzIxmB1F8oNcQetyuR0WkueVJsBFObx/SJYLj2qFPH5/ruAI//W80DZCmBoVkyHRn1f5Q1bENpVEC514hMezYTjgc58JGzLV5WDofkBCRKscQgMmQboRRDpDhZjLwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IYPTc007MPWMjsbVYN2ieCzy5SoDKcvrQN1qwHp/OFg=;
 b=QpqcxJHw8Mazb6ZZ1BjPjSbo/EcIZDJrkJwC8ymUhZazTLKPlzo82Yvfr+dHZdLuxN0FW1TelHlquJ0s9vMKRN2564fsfUiG28lRMjLixLcevCSgGCXLXQemmr3UYNm7XGsx37/cdCpaaDpvRi/GdZFYgCApLjmNPeDBxzTaGcs=
Received: from BY1P220CA0002.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59d::6)
 by PH7PR12MB7428.namprd12.prod.outlook.com (2603:10b6:510:203::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.37; Thu, 12 Jun
 2025 15:10:35 +0000
Received: from SJ1PEPF000023D3.namprd21.prod.outlook.com
 (2603:10b6:a03:59d:cafe::f4) by BY1P220CA0002.outlook.office365.com
 (2603:10b6:a03:59d::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.23 via Frontend Transport; Thu,
 12 Jun 2025 15:10:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000023D3.mail.protection.outlook.com (10.167.244.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8857.0 via Frontend Transport; Thu, 12 Jun 2025 15:10:35 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 12 Jun 2025 10:10:32 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Aurabindo Pillai <aurabindo.pillai@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Roman Li
 <roman.li@amd.com>, Alex Hung <alex.hung@amd.com>, Harry Wentland
 <harry.wentland@amd.com>
Subject: [PATCH] drm/amd/display: Fix annotations for dc state functions
Date: Thu, 12 Jun 2025 20:40:19 +0530
Message-ID: <20250612151019.106734-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D3:EE_|PH7PR12MB7428:EE_
X-MS-Office365-Filtering-Correlation-Id: 932a58a7-dc7a-4198-1338-08dda9c34861
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?a8S71Go2xhSsd+4L6XpyXWjb+ksVPdgvIiHvdN5KFkJZFSpWlVjYxAYfJk9k?=
 =?us-ascii?Q?BfGReo/9rIA8Q7SwOOdbTOGeMJpFydMYSIm5KZoVyHMgoY6/8/MR2qet4ixV?=
 =?us-ascii?Q?pSdhPQcO+YTotL+AkIb6DsdJfeq3mdBtshYwAu24lrjlYARi/KnhWa6UkCp6?=
 =?us-ascii?Q?FqMameZwm5Ggz/TzkH/yIQulZn9377J3h2xlthAvypbEnk+KeqLsgcPQIcev?=
 =?us-ascii?Q?uFS2raDYzmCBlAs4b7ZNW6SIPECGeqb4d19J6fh8Am4Zca8VxdnxO5v4paag?=
 =?us-ascii?Q?aeFWwFEr591YvTRjOF5LgE+qBpMwAd3cmIJYfNQkB81MznyZmKMCIXs6VJPf?=
 =?us-ascii?Q?msMimqq4KFpSzvae+qzXi6WWGNrv+IE5gLxInVn6Vb0dhu9LdfxY3akw+wIU?=
 =?us-ascii?Q?Hu8Pr8X6I6ORzpRbses0onVldrvQQDf2FM9DtRL0kvI9jkXpkZLNmaGnZZO+?=
 =?us-ascii?Q?IjSxtml/HDhMPl/mephEhxzaoUG3Monw8f6CvOOmkoRlRgnQc4Fcw1B9ISJR?=
 =?us-ascii?Q?pMCDjr3xc3R1ikveA3uLPSjozBckFMLkpUc81z8Hll2eWeXt2M3f8Q9L1dDg?=
 =?us-ascii?Q?8Oqj2nZihv9qsSvN9nAovy+NfgNwW2QY2lzV/1JLZECjuWe21qYlIDvu1HtM?=
 =?us-ascii?Q?FkOjjZjgdhAzkvSom/z8bNwDD9+j9gzZLwJ3Z3llVyGidpED8FiI7IDGfYOU?=
 =?us-ascii?Q?J7s03lO1BwKg6r+HQfcxB3uurYacVkjRjWtg8wh4xfYz70lVJNZvp+yBQoWq?=
 =?us-ascii?Q?YCouF1E41tJiGtF4AlUUSJ8Niay504vgCp2101+G8LWTF7pPTxWjjiT7Yz2Y?=
 =?us-ascii?Q?2+oFcyuRY24zSFgI/7oLu8m/W+kXQe2daoSHqyDRV33AN3nICTrQ6apPVF4G?=
 =?us-ascii?Q?+qux4coPOTLaxYDHbnMZptOTAAYjqnidcrYQBVpukGsb/t2AHpSaXLQNQelU?=
 =?us-ascii?Q?cChGjQQa8HHo4fLeR+sEmFyipO1U51QMpewZhlQtVjBdIbWqJ/T8XeoV/X0Y?=
 =?us-ascii?Q?8dKTeLj4ylrEfuMmaZGFYOcFjMFss5+oApwxnKyfq9b2Dhf5GDKrEtni/Cvk?=
 =?us-ascii?Q?PqJnyceM42G7M2027njhUdjynrrZTCP9Vq5KjVmbcZ3a+HXlXKWYIMoVSi8M?=
 =?us-ascii?Q?YacVbomDIlOkRYnCkZFE8jE1iQ5HoOS/qRSm7zV4loyANh/jqs/w++Xlngyi?=
 =?us-ascii?Q?VlJkToE1n89bmIm2E3XzNOlmtgcxyu1HWmfXRJM3G5tDtM6VnV3KjBcQ24kZ?=
 =?us-ascii?Q?j3gk5iIx0W7WuC8j3L85AHgrTuFg6ehQEAHNc8hjQx8zzKrwaeGcVT4taFQS?=
 =?us-ascii?Q?FdbDsUrqHjuVyoPEtPvt3Hsea/YHOKk7Xp5Egon0/ilhnqPpuCSPLaoeBahQ?=
 =?us-ascii?Q?eTFxfi1vyFxL9MBJP9G40OPEO9JOzBwSnI3C8VsXzt9FhKk6NAEvDByrbbH1?=
 =?us-ascii?Q?ADdAx+h0M05qHV+nyhM/dIRCKkPO6PszsxWa5oqN2mTrnD5hBmU6Fg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2025 15:10:35.3255 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 932a58a7-dc7a-4198-1338-08dda9c34861
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D3.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7428
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

This patch addresses inconsistencies in the annotations for the
following functions:

- **dc_get_power_profile_for_dc_state**: Standardized parameter and
  return value annotations.
- **dc_get_det_buffer_size_from_state**: Clarified parameter
  documentation for better understanding.
- **dc_get_host_router_index**: Corrected parameter descriptions to
  follow documentation conventions.

Fixes the below:
drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:6386: warning: Cannot understand  ***************

Cc: Tom Chung <chiahsuan.chung@amd.com>
Cc: Roman Li <roman.li@amd.com>
Cc: Alex Hung <alex.hung@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 25 ++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index eaf44e6046b5..0146ad4e23c8 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -6343,13 +6343,14 @@ void dc_set_edp_power(const struct dc *dc, struct dc_link *edp_link,
 	edp_link->dc->link_srv->edp_set_panel_power(edp_link, powerOn);
 }
 
-/*
- *****************************************************************************
+/**
  * dc_get_power_profile_for_dc_state() - extracts power profile from dc state
  *
  * Called when DM wants to make power policy decisions based on dc_state
  *
- *****************************************************************************
+ * @context: Pointer to the dc_state from which the power profile is extracted.
+ *
+ * Return: The power profile structure containing the power level information.
  */
 struct dc_power_profile dc_get_power_profile_for_dc_state(const struct dc_state *context)
 {
@@ -6365,13 +6366,14 @@ struct dc_power_profile dc_get_power_profile_for_dc_state(const struct dc_state
 	return profile;
 }
 
-/*
- **********************************************************************************
+/**
  * dc_get_det_buffer_size_from_state() - extracts detile buffer size from dc state
  *
- * Called when DM wants to log detile buffer size from dc_state
+ * This function is called to log the detile buffer size from the dc_state.
+ *
+ * @context: a pointer to the dc_state from which the detile buffer size is extracted.
  *
- **********************************************************************************
+ * Return: the size of the detile buffer, or 0 if not available.
  */
 unsigned int dc_get_det_buffer_size_from_state(const struct dc_state *context)
 {
@@ -6382,18 +6384,17 @@ unsigned int dc_get_det_buffer_size_from_state(const struct dc_state *context)
 	else
 		return 0;
 }
+
 /**
- ***********************************************************************************************
  * dc_get_host_router_index: Get index of host router from a dpia link
  *
  * This function return a host router index of the target link. If the target link is dpia link.
  *
- * @param [in] link: target link
- * @param [out] host_router_index: host router index of the target link
+ * @link: Pointer to the target link (input)
+ * @host_router_index: Pointer to store the host router index of the target link (output).
  *
- * @return: true if the host router index is found and valid.
+ * Return: true if the host router index is found and valid.
  *
- ***********************************************************************************************
  */
 bool dc_get_host_router_index(const struct dc_link *link, unsigned int *host_router_index)
 {
-- 
2.34.1

