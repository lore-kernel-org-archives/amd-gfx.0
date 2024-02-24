Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A470C5478C
	for <amd-gfx@archiver.kernel.org>; Sat, 24 Feb 2024 06:40:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8BAB310E174;
	Sat, 24 Feb 2024 06:40:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Eu4V8MRf";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2087.outbound.protection.outlook.com [40.107.244.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B1E4B10E175
 for <amd-gfx@lists.freedesktop.org>; Sat, 24 Feb 2024 06:40:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eg6Hk3NK5PtthWzo+eYJUEcYVEOr01C+1SOlRsxvQcfVd4qMDyOPxO6n9uedPhUw+/qqmew3fdi/BCBrguFsE36ug8KvcQ6k1R1BJkLbEpyK2HSBzDKSAeAbaLBgJktgIORLvUQqLwj9I/8/BBJZfHX2Cb3pOqc65Yyd0dS1uwTkNEG7IeVxZJmEkQGP6ESIQk0+Y+00wqPZHYL0YGQP6vq5TenMhvTTUHV/oG5VPnMBUUZMISuUlfqeP5/0sNMlDRCtUt0rIhgYD/7dsw7LbkilnQS4Qa4Ss3c609gHpH6tmDablLDFI+sb7qs7KVl2Yj8cX4H4mtXxIAEuvSpxEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZOTxIi1y6ODWlpvU3DqdCS++JLNGwaBSgwQtpXMytPo=;
 b=HM/crfiInRAhWl5KDUh/mCnswH0gWWlQOq1lT3dzOsHzk/eXBQuOW4y8e0rXId8qG1omXhcRxvVW4MWDObmAcNdHSyTM8mqvrqlDxPpMBmbBQnFQabtZAl87RP9qyFmADLBBVMUdKSDI+PPF8UdffdYw+pedQVaHOQPAZZkgR3oYxuANFptfaJPwOV4GUeWl0YvcPZWySXhE1IwZySltUllm76Apo/B1g1iHOlY7TTJdctNq2pnfzcEkpDwSdHkNBjKD0cl1BcQx0o7KsqWaexUfwH5hGZcqXgyvMMqwFgMBnwi3BfHlUggjpJ/ZsFff05vGnq018XojQMWb0nwm+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZOTxIi1y6ODWlpvU3DqdCS++JLNGwaBSgwQtpXMytPo=;
 b=Eu4V8MRf6W8VrqYhy1CfyEJaoqaoZfbkSQgrPh+j90fAviCsrVDBI3Gru1OV78UO30cVdEsY8jJnzSQSh9MQ9ATTUiy8AdcvD62fsd4/Iu/xZYY0BfdITxlxeyXbn/xS861aKmFHztNacvPalX2/kWw4PYOaTR6rjn8exxC/rGE=
Received: from BL1PR13CA0026.namprd13.prod.outlook.com (2603:10b6:208:256::31)
 by SA1PR12MB7102.namprd12.prod.outlook.com (2603:10b6:806:29f::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.26; Sat, 24 Feb
 2024 06:39:59 +0000
Received: from MN1PEPF0000ECDA.namprd02.prod.outlook.com
 (2603:10b6:208:256:cafe::c8) by BL1PR13CA0026.outlook.office365.com
 (2603:10b6:208:256::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.26 via Frontend
 Transport; Sat, 24 Feb 2024 06:39:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECDA.mail.protection.outlook.com (10.167.242.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Sat, 24 Feb 2024 06:39:58 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sat, 24 Feb 2024 00:39:55 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Roman Li <roman.li@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>
Subject: [PATCH] drm/amd/display: Fix logical operator in
 get_meta_and_pte_attr()
Date: Sat, 24 Feb 2024 12:09:38 +0530
Message-ID: <20240224063939.1512278-2-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240224063939.1512278-1-srinivasan.shanmugam@amd.com>
References: <20240224063939.1512278-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDA:EE_|SA1PR12MB7102:EE_
X-MS-Office365-Filtering-Correlation-Id: c89f45f6-ec4c-45ba-34e1-08dc35036ba8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5+ysbWUfCEl+Eus2MurwhySAT6hXmxeFlT1ESz8OJqEngRkpajKfo4xCJU++edBuQXAgGDS2HTz70zL5x7wOE/ix3/iARBbDGx//rysv8NjiJAQmn4lCR+LUvNW5CaS5/cLmiaLRjb7tqMj6DtMmIbUJnFHLxb9qqDiqNBqINqxX6qwdwiIYxNWGDINKvLQzQDsSSXU7Aejuj26+brLTPCoVpBYOnPDxibH/r7WqNBJoy71035zoggUhT+E6nQdzNtzS2nVh+XOVN2NKrkGXJrIpwgiKE209bfiGj+hnhdVHPdGw23C/twXVhgQD9X3CqtqO4hPN4lg58vC1VzIK5AbBjBYcVwtgYdpBiBP7pg/xn9DRokUipSMrTCl4o3BgPRDESf8bXU02zHDOpFe7JKYcf8EklFNcY+QfqZChH0hK9VnhMCF7HBjscvKq5LnwsPmHXpX4x+bNCTNsA753BjtJBF3RK+fFSmGGg7PzaCYEmKm6vDPlJHU5SDC4DBvyFls6kwN8iqhfhTutJfMoKcysObce0MS6w8MKK5v79solOxlnj24alSya+tAIPrQBwNbkBnuI5iL8c8mIie2uRtX4mrGiraPbM/bUHcqi1wLowbWV2TPQy7bfMCb894G0WXICzvDRjK7GX9BV3m4Czg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(46966006)(40470700004); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2024 06:39:58.6658 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c89f45f6-ec4c-45ba-34e1-08dc35036ba8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECDA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7102
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

logical operator in a condition check in the get_meta_and_pte_attr
function bitwise AND operator '&' was used in an 'if' statement, but the
logical AND operator '&&' was likely intended.

The condition check was changed from:
    if (!surf_linear & (log2_dpte_req_height_ptes == 0) & surf_vert)
to the below:
    if (!surf_linear && (log2_dpte_req_height_ptes == 0) && surf_vert)

This ensures that the 'if' statement will be true only if all three
conditions are met, which is the typical use case in an 'if' statement.

Fixes the below:
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn20/display_rq_dlg_calc_20.c:656 get_meta_and_pte_attr() warn: maybe use && instead of &
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn20/display_rq_dlg_calc_20v2.c:656 get_meta_and_pte_attr() warn: maybe use && instead of &
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn21/display_rq_dlg_calc_21.c:662 get_meta_and_pte_attr() warn: maybe use && instead of &
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_rq_dlg_calc_30.c:627 get_meta_and_pte_attr() warn: maybe use && instead of &
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn31/display_rq_dlg_calc_31.c:622 get_meta_and_pte_attr() warn: maybe use && instead of &
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn314/display_rq_dlg_calc_314.c:710 get_meta_and_pte_attr() warn: maybe use && instead of &

Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Roman Li <roman.li@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 .../gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20.c  | 3 ++-
 .../drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20v2.c    | 3 ++-
 .../gpu/drm/amd/display/dc/dml/dcn21/display_rq_dlg_calc_21.c  | 3 ++-
 .../gpu/drm/amd/display/dc/dml/dcn30/display_rq_dlg_calc_30.c  | 3 ++-
 .../gpu/drm/amd/display/dc/dml/dcn31/display_rq_dlg_calc_31.c  | 3 ++-
 .../drm/amd/display/dc/dml/dcn314/display_rq_dlg_calc_314.c    | 3 ++-
 6 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20.c
index 548cdef8a8ad..e689afdf9e7b 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20.c
@@ -653,7 +653,8 @@ static void get_meta_and_pte_attr(struct display_mode_lib *mode_lib,
 
 	// the dpte_group_bytes is reduced for the specific case of vertical
 	// access of a tile surface that has dpte request of 8x1 ptes.
-	if (!surf_linear & (log2_dpte_req_height_ptes == 0) & surf_vert) //reduced, in this case, will have page fault within a group
+	if (!surf_linear && log2_dpte_req_height_ptes == 0 &&
+	    surf_vert) //reduced, in this case, will have page fault within a group
 		rq_sizing_param->dpte_group_bytes = 512;
 	else
 		//full size
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20v2.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20v2.c
index 0fc9f3e3ffae..6d105a8bd4c7 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20v2.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_rq_dlg_calc_20v2.c
@@ -653,7 +653,8 @@ static void get_meta_and_pte_attr(struct display_mode_lib *mode_lib,
 
 	// the dpte_group_bytes is reduced for the specific case of vertical
 	// access of a tile surface that has dpte request of 8x1 ptes.
-	if (!surf_linear & (log2_dpte_req_height_ptes == 0) & surf_vert) //reduced, in this case, will have page fault within a group
+	if (!surf_linear && log2_dpte_req_height_ptes == 0 &&
+	    surf_vert) //reduced, in this case, will have page fault within a group
 		rq_sizing_param->dpte_group_bytes = 512;
 	else
 		//full size
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_rq_dlg_calc_21.c b/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_rq_dlg_calc_21.c
index 618f4b682ab1..5d604f52a948 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_rq_dlg_calc_21.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_rq_dlg_calc_21.c
@@ -659,7 +659,8 @@ static void get_meta_and_pte_attr(
 	if (hostvm_enable)
 		rq_sizing_param->dpte_group_bytes = 512;
 	else {
-		if (!surf_linear & (log2_dpte_req_height_ptes == 0) & surf_vert) //reduced, in this case, will have page fault within a group
+		if (!surf_linear && log2_dpte_req_height_ptes == 0 &&
+		    surf_vert) //reduced, in this case, will have page fault within a group
 			rq_sizing_param->dpte_group_bytes = 512;
 		else
 			//full size
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_rq_dlg_calc_30.c b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_rq_dlg_calc_30.c
index 0497a5d74a62..6f6de729b195 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_rq_dlg_calc_30.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/display_rq_dlg_calc_30.c
@@ -624,7 +624,8 @@ static void get_meta_and_pte_attr(struct display_mode_lib *mode_lib,
 	if (hostvm_enable)
 		rq_sizing_param->dpte_group_bytes = 512;
 	else {
-		if (!surf_linear & (log2_dpte_req_height_ptes == 0) & surf_vert) //reduced, in this case, will have page fault within a group
+		if (!surf_linear && log2_dpte_req_height_ptes == 0 &&
+		    surf_vert) //reduced, in this case, will have page fault within a group
 			rq_sizing_param->dpte_group_bytes = 512;
 		else
 			rq_sizing_param->dpte_group_bytes = 2048;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_rq_dlg_calc_31.c b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_rq_dlg_calc_31.c
index 4113ce79c4af..72432df8484e 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_rq_dlg_calc_31.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_rq_dlg_calc_31.c
@@ -619,7 +619,8 @@ static void get_meta_and_pte_attr(
 	if (hostvm_enable)
 		rq_sizing_param->dpte_group_bytes = 512;
 	else {
-		if (!surf_linear & (log2_dpte_req_height_ptes == 0) & surf_vert) //reduced, in this case, will have page fault within a group
+		if (!surf_linear && log2_dpte_req_height_ptes == 0 &&
+		    surf_vert) //reduced, in this case, will have page fault within a group
 			rq_sizing_param->dpte_group_bytes = 512;
 		else
 			rq_sizing_param->dpte_group_bytes = 2048;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_rq_dlg_calc_314.c b/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_rq_dlg_calc_314.c
index b3e8dc08030c..cd0f861619ef 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_rq_dlg_calc_314.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_rq_dlg_calc_314.c
@@ -707,7 +707,8 @@ static void get_meta_and_pte_attr(
 	if (hostvm_enable)
 		rq_sizing_param->dpte_group_bytes = 512;
 	else {
-		if (!surf_linear & (log2_dpte_req_height_ptes == 0) & surf_vert) //reduced, in this case, will have page fault within a group
+		if (!surf_linear && log2_dpte_req_height_ptes == 0 &&
+		    surf_vert) //reduced, in this case, will have page fault within a group
 			rq_sizing_param->dpte_group_bytes = 512;
 		else
 			rq_sizing_param->dpte_group_bytes = 2048;
-- 
2.34.1

