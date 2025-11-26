Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E170AD111B6
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Nov 2025 23:06:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8509D10E73E;
	Wed, 26 Nov 2025 23:06:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vBj/o74t";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010022.outbound.protection.outlook.com
 [52.101.193.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 049FC10E733
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Nov 2025 23:06:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iaSdNrTkSD4bp0/iZMrxCm9jaEhfo0HcCINMgUD81UZpvO9suj/58HPF7NyBu/NHfk0yv7rsCDFVCwQvu3LC2Qf+SAOmVwVTf9lBuAl6naGTNRb6dFheQf8l+kqZCydZo4Y5J1q7LyeKO9bO/gJP2QWfQ6BMdegeIP3oD4LuwNXT7e/aSB99eGPzZp0ukmvy3aqSP6m+TuRwOsDog2u8SJA1Kod8zqa+j5g5RIEWTWVVRdH9ESWpj8oztff9iD1H5TRNDtnY3BFljpKEs13FuSqHAteKEXqeGwsRXrGwAISCAlvKVcybc9XJUX9T3+XjdqvaLFnooWMeTHMMQ44uJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S70K+yBfwkgVSnAEGqberZ0OxD/yIH3VZh9CYgvxC5I=;
 b=elhK89bYacOO5UnUu2YC4eHbC96b/yvF32cH3PJNhQwBtesOzaHmrTiBgs3VtC/iG+3ql9WDtqmib/TRZJ/7XNc2bfqbfcFF4zXyh/RCfn4R+4kaGAf4EW8df8LJBaCb0VGTPv3i+VjUd6vTMcOYP270+oFi5R84nE5Vq8PvVhg1UxNVqSHepX6I27uFGllCu139H1G2I+U52HIqssCgoov3uEtT08/lttw4IM0yqX39aikZKuq6fGtMRvYZsTU22eK47wDyWKCliLydXkziLvwYnmJg1JXMCTTiez3Pt1CINu+iRRFMLY0vvSO9AyVmElOPDgJFQiO7xRYS3kyfIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S70K+yBfwkgVSnAEGqberZ0OxD/yIH3VZh9CYgvxC5I=;
 b=vBj/o74tcFLUHx1LHTJvBTglmCKQPX8AdlTjPfIzijjECC9hefDgEK7AiJO6460RpIWokeGKVvSiI3qVDFQKPb1SdFFiGrVyzEs12QkKnL+8MBCsc6ZKDtJcVLXkwt8/2uM9FEMmn6uzbfy5x/vwh1p2LScmWtJlwia/n8H2K6I=
Received: from SA9PR03CA0008.namprd03.prod.outlook.com (2603:10b6:806:20::13)
 by PH7PR12MB8016.namprd12.prod.outlook.com (2603:10b6:510:26b::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.12; Wed, 26 Nov
 2025 23:06:46 +0000
Received: from SN1PEPF000397B5.namprd05.prod.outlook.com
 (2603:10b6:806:20:cafe::81) by SA9PR03CA0008.outlook.office365.com
 (2603:10b6:806:20::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.12 via Frontend Transport; Wed,
 26 Nov 2025 23:06:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SN1PEPF000397B5.mail.protection.outlook.com (10.167.248.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Wed, 26 Nov 2025 23:06:46 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 26 Nov
 2025 17:06:40 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 26 Nov
 2025 15:06:40 -0800
Received: from roman-vdev.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 26 Nov 2025 15:06:40 -0800
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Charlene Liu <Charlene.Liu@amd.com>
Subject: [PATCH 11/14] drm/amd/display: add register definitions in
 dcn_hubbub_registers
Date: Wed, 26 Nov 2025 18:06:11 -0500
Message-ID: <20251126230614.13409-12-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251126230614.13409-1-Roman.Li@amd.com>
References: <20251126230614.13409-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B5:EE_|PH7PR12MB8016:EE_
X-MS-Office365-Filtering-Correlation-Id: 321a3953-50f0-4050-5127-08de2d4078f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?R3IdoU0Si+kp/1YRs7odeSuZlkPR13i7PfK0l1K7vqv1Rd1EswRokUf5grZi?=
 =?us-ascii?Q?crde9k7W24m6qm/AFxGMAOWw3QKklTDALE3mLvxKXL7VcIdGeRF+KJ0hClo1?=
 =?us-ascii?Q?2cUv/dcCxe0bYlOXAo/ya4zkFI+qWyurM8up0P4NIW91tPl16lqY3KO86O31?=
 =?us-ascii?Q?+kZDgYU3bpfD0ssKERYRUI8mlPUIIDPkdJGIEDX/Te7KHtLeXEVePktGg3MU?=
 =?us-ascii?Q?afXYvoKIeKVCTC4NkPNsNOofpatQ8+p9dSQ1yC/O9zse5xe5YCGStoxeOvbY?=
 =?us-ascii?Q?yJUs54YZgm+CDIoQhh1ApDQJtYsNy9qfc9p1P6Bv83uIUt+0j0O/EQP7xZix?=
 =?us-ascii?Q?vZanZIGk6fXQcltdeAS22iFIdxbwMyQKsIpQtJGNWIZM+VT6+C1kKNxki9AO?=
 =?us-ascii?Q?hgS1uchz6/7DhTr0TerAdc0lRH0FAzCYE+hDMaUQUfCVEU/V1tpVZaRk987O?=
 =?us-ascii?Q?8Sd5mx0bP/kkQaEqOGVBHxfIc8f8b/wRnvnt4qm3y7zNhZy/RzZl/7pEekhC?=
 =?us-ascii?Q?wHwDp12K+CJ0xjpt7vXqyE6b93c9WaFGWwdkDKTniOrwy/yZQAwiAPKmXPOZ?=
 =?us-ascii?Q?H3NKar+Tm1dXaGIXGysITdgx1X6fQDrtl2KG5OIGXp57u4kuoj6Mp+OZw3BS?=
 =?us-ascii?Q?0PJR3bfcM29HXMB0nn9cNOzFUzCBjE2gsjpacm9CeYJEBW3pmiS8JV5064Of?=
 =?us-ascii?Q?9sLCDTSZstSOHcwppKfpK8U3gb+Tjcm1Yx7mh0b7/KMt8gCXysf6gK/Ryn9u?=
 =?us-ascii?Q?u6bF+/DmlcFqlftw5PyYtvf3pYUba5N9QnmyWHOKUr8BeoqBp8UQnxMK8s/G?=
 =?us-ascii?Q?9LcEwQZl+Z3LiMPyA6usGW5bPrix1Jhjzdz+1QBFdAz+UUAIY8rzOAqTiGa0?=
 =?us-ascii?Q?DK777MUTIU/gO0ycWIg3+7v6G5f7b+ZmDUnEsoBwZuaR6VlVGEXhCHIr91sW?=
 =?us-ascii?Q?8zbCvDxibN/+hbGHA5xc/SBxBqfehITkFMe2+Z4KlOUE+PBCp8CDYFBa+T89?=
 =?us-ascii?Q?nb9qVjGJGqkLk6qPA+EGefdaEHZIRKAVYed5VtbbpnXagLr1vGz49D1Gk0wd?=
 =?us-ascii?Q?r0GhJS9yG2dV+kljicFAxy4UxpW9kdntJA/1cygtyc98MpgVjQLNWozF8zNF?=
 =?us-ascii?Q?+FjoAFc2itK6MKrVx9SgFAF/VxLn5d46IMgG7fnimrhNKxbk2wjSlVZuvkCq?=
 =?us-ascii?Q?RSzVcKswTGsxNh4PQCk4cTqjjT/oliuNOPD6kZxnbUJ+dygHIGFxZtIDzr8R?=
 =?us-ascii?Q?ycpp1WacshKWtwTUKfL2cGUCqMKl/7L4xTco0mJJ+dzh77y9FP6rqX5nkGUI?=
 =?us-ascii?Q?Fcf2Sq337SMBIEzSIgYXmFh3dTFA+m9r2RMw7sNTWeGDTEC/DJZwKyPoWJMJ?=
 =?us-ascii?Q?oSTP+GVvz2KuSK97ODw11zv/cN58omUO8+fwcWA2O2CzXyTOx32mentn8HUg?=
 =?us-ascii?Q?QSyaqSFJF8pO848u/wDdTmDMX4S9uLmFb1c+5L+x9u9JPnzgnnlQ2Bq8/s2o?=
 =?us-ascii?Q?sy+zQSuMHGaHlRFx/CSIBfEvYYYrXZtgoQvQCc6I3jlR68fWuBtzR3LxNFdn?=
 =?us-ascii?Q?RrF2zQWiHcWNLJpKBaw=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2025 23:06:46.3535 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 321a3953-50f0-4050-5127-08de2d4078f8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8016
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

Reviewed-by: Roman Li <roman.li@amd.com>
Signed-off-by: Charlene Liu <Charlene.Liu@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 drivers/gpu/drm/amd/display/dc/hubbub/dcn10/dcn10_hubbub.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hubbub/dcn10/dcn10_hubbub.h b/drivers/gpu/drm/amd/display/dc/hubbub/dcn10/dcn10_hubbub.h
index fa5c4c18ed59..0a29a758d013 100644
--- a/drivers/gpu/drm/amd/display/dc/hubbub/dcn10/dcn10_hubbub.h
+++ b/drivers/gpu/drm/amd/display/dc/hubbub/dcn10/dcn10_hubbub.h
@@ -437,7 +437,9 @@ struct dcn_hubbub_registers {
 		type DCHUBBUB_ARB_REFCYC_PER_META_TRIP_A;\
 		type DCHUBBUB_ARB_REFCYC_PER_META_TRIP_B;\
 		type DCHUBBUB_ARB_FRAC_URG_BW_MALL_A;\
-		type DCHUBBUB_ARB_FRAC_URG_BW_MALL_B
+		type DCHUBBUB_ARB_FRAC_URG_BW_MALL_B;\
+		type DCHUBBUB_ARB_ALLOW_DCFCLK_DEEP_SLEEP_FORCE_VALUE;\
+		type DCHUBBUB_ARB_ALLOW_DCFCLK_DEEP_SLEEP_FORCE_ENABLE
 
 struct dcn_hubbub_shift {
 	DCN_HUBBUB_REG_FIELD_LIST(uint8_t);
@@ -447,6 +449,7 @@ struct dcn_hubbub_shift {
 	HUBBUB_REG_FIELD_LIST_DCN32(uint8_t);
 	HUBBUB_REG_FIELD_LIST_DCN35(uint8_t);
 	HUBBUB_REG_FIELD_LIST_DCN4_01(uint8_t);
+
 };
 
 struct dcn_hubbub_mask {
@@ -457,6 +460,7 @@ struct dcn_hubbub_mask {
 	HUBBUB_REG_FIELD_LIST_DCN32(uint32_t);
 	HUBBUB_REG_FIELD_LIST_DCN35(uint32_t);
 	HUBBUB_REG_FIELD_LIST_DCN4_01(uint32_t);
+
 };
 
 struct dc;
-- 
2.34.1

