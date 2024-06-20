Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1004C2BA1A
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Jun 2024 16:15:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 33C3810EAF3;
	Thu, 20 Jun 2024 16:15:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jUrNh58M";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2068.outbound.protection.outlook.com [40.107.223.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E37410EAF3
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jun 2024 16:15:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N6IQcl2KdWhWT3TZi4oa++cjwnXocWqvHbQVTmgLRAtEY+5SDEUu6mXhkteSwI3S0F/Hy94BzHuRPLzOjEXmBLojgW9dgLvTTmFRs/MTuUlH3v+anByMywPOtBFS39NZNuEg1sM9GexYY/d4i+Z28LiUaffDgpMBaoxBX7HbsmxSJ/CwLUanR65tjUiHd5dxtHZXUfs5m+CWWak+uIiD8Yvk3VXkTNczm1MH8xMhEIld+9NJGOa9RzHyMA8YvC3Ic1OFOeSsAvGH7ddhIapF3chhhq2JC11rQKbVXiBKIq8O0yjJvAm55W0D0/O3jgX+H8d4DqkV9Ev9Cx2ptfpBnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4xriXNdXTdmyuKXd/JkwofNEPpi6rKzLJGyO3m86cKI=;
 b=IZw2+mThxcKHw9KStuXta6lSSrEQbpL70GEDqqKWg4iVX1RNyj+iH3ysQMgfNwq9wTo2tmY9OYB2xhoIscaUPBstRtT+3h0jyhVFV0gh1Co1C9RoyJ962wcfcWxxkkwgE/3YNvkSPj1Y/0eVXK28VJyBJH0VmnI6QG7EeBKaPofdZYxWSLR2oQ0lP33t4McA28EsUNGwy4ud//r/KoPlAjlwqIhC+6tO7ct25qPqxkeAB/4Pnu9+jjmxhV6cUJNipWiRv04hSy7e2erSVPybrRSOf5Ugwice8RYew+Po2+RW+V7jgh6hCO0atSFPO3pY7ld94jWTtoOscPIj5hmNmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4xriXNdXTdmyuKXd/JkwofNEPpi6rKzLJGyO3m86cKI=;
 b=jUrNh58MjNhsC+ZynhC6cK1LnFF70YkDenvKjDPyyYGjH7SXrkt+kQTSdldY4Hk5BqfyveNbgKJpRCp7OqRsp3cGsn8W0n0Xmt1lZ3OFhf1xxBJlx5OaAInAhCtb5wFKGAw/TKhrf0fId3dIHNmWLVisTR8eXNV1m0uI2l7w1L4=
Received: from PH8PR02CA0010.namprd02.prod.outlook.com (2603:10b6:510:2d0::21)
 by CYYPR12MB8701.namprd12.prod.outlook.com (2603:10b6:930:bf::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.21; Thu, 20 Jun
 2024 16:15:28 +0000
Received: from CY4PEPF0000E9D9.namprd05.prod.outlook.com
 (2603:10b6:510:2d0:cafe::b2) by PH8PR02CA0010.outlook.office365.com
 (2603:10b6:510:2d0::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.33 via Frontend
 Transport; Thu, 20 Jun 2024 16:15:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D9.mail.protection.outlook.com (10.167.241.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Thu, 20 Jun 2024 16:15:28 +0000
Received: from 10.254.92.128.in-addr.arpa (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 20 Jun 2024 11:15:25 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Alex Hung <alex.hung@amd.com>, Rodrigo Siqueira
 <rodrigo.siqueira@amd.com>
Subject: [PATCH 14/39] drm/amd/display: Check HDCP returned status
Date: Thu, 20 Jun 2024 10:11:20 -0600
Message-ID: <20240620161145.2489774-15-alex.hung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240620161145.2489774-1-alex.hung@amd.com>
References: <20240620161145.2489774-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D9:EE_|CYYPR12MB8701:EE_
X-MS-Office365-Filtering-Correlation-Id: 01582f29-ef3a-4809-b025-08dc91443332
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230037|1800799021|82310400023|376011|36860700010; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Kiayav4XUVFSXFnqISyI6Wn41PreqBxwjcL7LN3KScu07yNKqYYkYj/7PHhF?=
 =?us-ascii?Q?PsdugnZNQaLv0G2w2GwKWwlGrQGbaeUJHod7svXJ4lzU5eabNcg6BujhwHw6?=
 =?us-ascii?Q?4cyEHPFQfJZYV5TF0rV5W0VYUT5d/zUy4wX1k1JDEEekgJDg7iI0AETCEiUX?=
 =?us-ascii?Q?HALkwmwN/vqJbcvdB03VlwJ4BV4KwI9/zr8jc+fhIus384i9I/62yGZgqhQX?=
 =?us-ascii?Q?YP0iG9Nr7GUxOC77W3tS8Z+Tm7ZLrle9E7JyT26UDFOJBiB9gt50HTftyE6U?=
 =?us-ascii?Q?SoI1hTHwTTJvwvy6mCUOLgZtT0hne4OdkMopuivF+XoqtDtyOEUTdeKE4u03?=
 =?us-ascii?Q?kTvxl/FIe+lz9JPlE5xJLQOui0FQHiaPLyLidK+1BYYv8r1DVv3RBf0FwlpQ?=
 =?us-ascii?Q?0HnLBk+7gx4h/s6sKbmsdrU1Ou0Eu/Iu2/16205D9DD3sgd8rdrJsV82njt8?=
 =?us-ascii?Q?7ZMTM3Jw3ksLs4NwOM1IS/h/dl+Lid823ZI8t3ztMu9Lm1okBi5ErSkATrQr?=
 =?us-ascii?Q?RHGr7dPlC/HT9KFIGAB8mnlDySWanesFpRYQIdgSmYZMqLKpQ52fXsh06MVp?=
 =?us-ascii?Q?Qlzqs66xgb0Qh+g7KVhWWdI8sj9c2+PBtzkSJ1Gh0E+SwLuO2Xdh4OiV2/6I?=
 =?us-ascii?Q?6dqbc0hgv7RtQCbVLLd4gQDo4EhzVWT7d6A+6Nk+3uydAZPfL9a4LPLjPM19?=
 =?us-ascii?Q?lc/jjh4cqJRBzELOUnPmC2sECdAcX7Enmg+utbMNTOHSbH3OskUORDSOh6P+?=
 =?us-ascii?Q?XO4am0mgcmpPHjbpFMUhy7kWwPmE3K4+i5pz9ma9pTLTkGQrDQfouvlJ6jpK?=
 =?us-ascii?Q?UCLhOYDzbo+APv/HBaqrCh2eyXUefN1SYX5zNjXZWx4kB3XK+YDhUytukxza?=
 =?us-ascii?Q?9iKYSqc1J9Agr58//T3ysxXlo3KUE0tfkled2l3s/GtKOdJ/CiaHzoKjh0Oc?=
 =?us-ascii?Q?0cAsgOVkMX2UfnP6HgVtTxMjzZ2bocjjAD+D9EaKKxHEUp1yi0ZQ+eXSNaGm?=
 =?us-ascii?Q?P6TE6u7P0613PuUt48ZNr7xDqTCRU4yVDBLHmRRbZL7BkRmGMYSplujSh++l?=
 =?us-ascii?Q?wRlILurdXbopfYl4MfrVfikM6ciufrRBAUvgBWydhLGO6/oLQ28D30Qw4iWb?=
 =?us-ascii?Q?dqhF4ZlOyRJlNFWdnbp4VFdpAV+jRzBtKLs4vCend3mVJimtKaJ8cR+YKhDJ?=
 =?us-ascii?Q?ZP6eRU+HxpmSeZjWAYpREvPDxLmU7RhfQyv4PD6f/M40s6zvWCtz7Fad2Yuo?=
 =?us-ascii?Q?n8ndLgSrVNGNL4V8MOG94Knv5xLT1kGfgAxlSkGPm/f+wjjwbdC8mSiv54LF?=
 =?us-ascii?Q?+JKRCCxCHtDLQ2ALPyC+Yq/Ez7WZtcsbZf/IaKN0BY8xTjuZ69F5PCQQufSo?=
 =?us-ascii?Q?1x8gSdk/ZBmKz/oFGnLOg+WNO2b4EacN31rtxlCcfLk0lkY3mA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230037)(1800799021)(82310400023)(376011)(36860700010); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 16:15:28.1437 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01582f29-ef3a-4809-b025-08dc91443332
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8701
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

[WHAT & HOW]
Check mod_hdcp_execute_and_set() return values in authenticated_dp.

This fixes 3 CHECKED_RETURN issues reported by Coverity.

Reviewed-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../amd/display/modules/hdcp/hdcp1_execution.c    | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c
index 182e7532dda8..d77836cef563 100644
--- a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c
+++ b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c
@@ -433,17 +433,20 @@ static enum mod_hdcp_status authenticated_dp(struct mod_hdcp *hdcp,
 	}
 
 	if (status == MOD_HDCP_STATUS_SUCCESS)
-		mod_hdcp_execute_and_set(mod_hdcp_read_bstatus,
+		if (!mod_hdcp_execute_and_set(mod_hdcp_read_bstatus,
 				&input->bstatus_read, &status,
-				hdcp, "bstatus_read");
+				hdcp, "bstatus_read"))
+			goto out;
 	if (status == MOD_HDCP_STATUS_SUCCESS)
-		mod_hdcp_execute_and_set(check_link_integrity_dp,
+		if (!mod_hdcp_execute_and_set(check_link_integrity_dp,
 				&input->link_integrity_check, &status,
-				hdcp, "link_integrity_check");
+				hdcp, "link_integrity_check"))
+			goto out;
 	if (status == MOD_HDCP_STATUS_SUCCESS)
-		mod_hdcp_execute_and_set(check_no_reauthentication_request_dp,
+		if (!mod_hdcp_execute_and_set(check_no_reauthentication_request_dp,
 				&input->reauth_request_check, &status,
-				hdcp, "reauth_request_check");
+				hdcp, "reauth_request_check"))
+			goto out;
 out:
 	return status;
 }
-- 
2.34.1

