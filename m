Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52B23D6AAEC
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Apr 2026 18:33:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8B8F10F2F1;
	Thu,  2 Apr 2026 18:33:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="E8/geE0u";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010009.outbound.protection.outlook.com [52.101.201.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B36BB10F2EF
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Apr 2026 18:33:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QZyijzrO8/z+bVaU+f1hhIkCpV1EolNYnybSSYSx9LMpWdSwUT23Q+VlrcMfB2ruM8L53dwbDj7EFHKTl2o87nb0pOIYbxRAVelOWjzLVsiaQBcNxVtmKk5+mSqf0xde4eas4fuufD9UU224QaSfMB/kHfBXY30vxB/naMHQ+/axTGMaG+Htm9oe/YJTPa05n/e09WRwYRFqOfWvnq7LJc2ahrzHSuBgItgC4l4M8fNtI2f3i3BHOup3r11VtUkQsFiIZ28SvEKyiXx5oQ7nKp+bJN9Y/x8z+trNh7edlI9ZiD2vuTehGytPb2m91OvkSOEn2Dpym757kk2QXdm3Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HyPDTus3NBHH1oJleyy1GUyrmy5uNcWk8UdOSAaG+5U=;
 b=bAUjo7Pm3viB/x6e4BOLJNFubUdj8K/UvS10GolfVwuVvR5Qndi/qUTEQDkAXDafL1My9FH6BVw6TiHFH8Tfhbk0dAYASwrnFz96i7SG3UgMV+CSR3ZCh5l2dd4kJUvYbLcgVRoRPYu5CXUHM80DYCoLoWdLZVLpZuKeK0/giBne2/99no8AUI3NmR2rVAuaF1bwdmS20VBTbrUVSIOYwQ5owSkLEqEBSBd0/S3nULrffGYH8zVUrarHxmD4Gjg/i3ldovRNWaA0a9I+KNGijqHfUsYwIAyaEjTuWFaqOVeBjOJZfLZIfg69lFyZj/HZWykgRbl6DKoq3pVY6JQAZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HyPDTus3NBHH1oJleyy1GUyrmy5uNcWk8UdOSAaG+5U=;
 b=E8/geE0ueh55jg7n8a2UDp4PpEFLhBoGegUuzFvwZwS8mDaz91zaItOxJpKqI7Cp1pfArEfj9OaEBhxiYFCTi/HAQJb/5KLP/nZl+TOoyzhN46rCyJA3QMD+eQHzK9Dne6GZuCPOfeIpNn5N/jdL6R1lQIfGrXvURfd0IgUbaN8=
Received: from CH2PR07CA0049.namprd07.prod.outlook.com (2603:10b6:610:5b::23)
 by IA1PR12MB7760.namprd12.prod.outlook.com (2603:10b6:208:418::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Thu, 2 Apr
 2026 18:33:39 +0000
Received: from CH2PEPF0000013D.namprd02.prod.outlook.com
 (2603:10b6:610:5b:cafe::62) by CH2PR07CA0049.outlook.office365.com
 (2603:10b6:610:5b::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.31 via Frontend Transport; Thu,
 2 Apr 2026 18:33:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000013D.mail.protection.outlook.com (10.167.244.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 2 Apr 2026 18:33:39 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Thu, 2 Apr
 2026 13:33:35 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 2 Apr
 2026 13:33:34 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 2 Apr 2026 13:33:34 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Chuanyu Tseng <Chuanyu.Tseng@amd.com>, Charlene Liu
 <Charlene.Liu@amd.com>, Dillon Varone <dillon.varone@amd.com>
Subject: [PATCH 03/22] drm/amd/display: update dcn42 bounding box
Date: Thu, 2 Apr 2026 14:32:55 -0400
Message-ID: <20260402183314.1388755-4-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260402183314.1388755-1-Roman.Li@amd.com>
References: <20260402183314.1388755-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Roman.Li@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013D:EE_|IA1PR12MB7760:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ce61db9-c22e-4f40-464b-08de90e65bfa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: tMRmhMCF8DGks+XX3fvNgwKT43Eg3wtBUa8E/d7XsMbTn5REXziI2bUG78pIFq7cO7cN0+jAOwSGmLLFunoj02KTeHyl+pSBgFNGHwCXQkW7Rcyck5teOnTkWOAAEosSeHZGMWm+UVYXCv67dicVF5y5zUkRUTKi5Yyltt/lu6z3C17fJg/ENMCOaEBYHZejr5DHvA+8RB22DQjwX4qtRAPPIwYlO/mj4nijcBnBxtO0Hk2QzV9OAWxZgRua+gK6HXAQsLS2LWvsnRkbPhbaqzUSj0J6g40xX1paWpYKesTgDBaqkfE4ah9gxtuxnHrCGWrL0ZS0EjpFZ+pDyL98w+ouckcX/8hroISsfdU8QccY7ucAXp85TjORAyUji6XFCUj5jxZmKqHejqsfvG2iiHXqSuvBqlbslM+hrVoQ6gsN9Qd4I3zYuXixnelLETWjEGSjdBbNbPTIjvGEfVtucIOz8BZeP/lutA1vbl5P26M/ODNukHAqbXLmag79B8Obn2WYIFoHriDvVAU2PB+r+MWn86qyhv64IQEMsck0SWv6XWwgDw5wnBpK36xt7s3XAWSkDvtknilSnwb8eeHQzaI+pnymJjE9j0FdEOCil34BQsFx9uaSTk/XKQSbR2rSkcrv0OhRyJpdzvkiDbVhZ0YQi9cKWDfPWdobbjqOcZciKf0uc8HleUIQO3xqutgYNcV7SuZXc9pLiq+hrbS92yfTWh1MGkHdcMnPrO6J2J9EmOwXGPkaE91pAsL+0umH/LpZpgg6THiuYR2NunSiVQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: StEd7b7JcjBQk9GrdavEKCl7Hp8jb94Evh10wQt9qbDwL0+nEo+8csTnCMNUpG/1qRnW01w0IeLZAFfozKGIHMpTyb5P6+EIfztMpussWAbWSb/mc7RhLl0yvct6AFUAoyKlFIZj2K02hSRwAs4adq/jbNltDKiTnymdYokCjmudoPJtF0ToMYAQxRVrRz9YJ5uaWJx/h1cVZuwcAD1IXN+J+sK52DYRazjsBhtRRa2YIBUOhiLle9mi+gZTpcURQpJz/1i148p5mMV2UfLHhcAlCoZIJRN5JSET+9xgX8qe978n7iA+P4cbSEoW9TBc6bnHeQ0I9Oq37wltFUMOJY4icdJtuVrfYNQtZHCGx9MfNkVaLeugH4LI6tVzHNvmRVRLuQFfAEBdtDP1M1gXzOw4sGqN9NWi1tJuAiFkza9Y87pShioyZn0Ox/0VSnyj
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 18:33:39.2907 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ce61db9-c22e-4f40-464b-08de90e65bfa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7760
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

From: Charlene Liu <Charlene.Liu@amd.com>

[why]
update according hw spec.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 .../display/dc/dml2_0/dml21/inc/bounding_boxes/dcn42_soc_bb.h | 2 +-
 .../display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4.c    | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/bounding_boxes/dcn42_soc_bb.h b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/bounding_boxes/dcn42_soc_bb.h
index c75778ea7a2c..deea5608c08e 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/bounding_boxes/dcn42_soc_bb.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/bounding_boxes/dcn42_soc_bb.h
@@ -234,7 +234,7 @@ static const struct dml2_ip_capabilities dml2_dcn42_max_ip_caps = {
 	.config_return_buffer_segment_size_in_kbytes = 64,
 	.meta_fifo_size_in_kentries = 32,
 	.compressed_buffer_segment_size_in_kbytes = 64,
-	.cursor_buffer_size = 24,
+	.cursor_buffer_size = 42,
 	.max_flip_time_us = 110,
 	.max_flip_time_lines = 50,
 	.hostvm_mode = 0,
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4.c
index fda01b0800d6..858e7bbc511f 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4.c
@@ -135,7 +135,7 @@ struct dml2_core_ip_params core_dcn42_ip_caps_base = {
 	.cursor_64bpp_support = true,
 	.dynamic_metadata_vm_enabled = false,
 
-	.max_num_hdmi_frl_outputs = 0,
+	.max_num_hdmi_frl_outputs = 1,
 	.max_num_dp2p0_outputs = 2,
 	.max_num_dp2p0_streams = 4,
 	.imall_supported = 1,
@@ -155,7 +155,7 @@ struct dml2_core_ip_params core_dcn42_ip_caps_base = {
 	.min_meta_chunk_size_bytes = 256,
 
 	.dchub_arb_to_ret_delay = 102,
-	.hostvm_mode = 1,
+	.hostvm_mode = 0,
 };
 
 static void patch_ip_caps_with_explicit_ip_params(struct dml2_ip_capabilities *ip_caps, const struct dml2_core_ip_params *ip_params)
-- 
2.34.1

