Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04312C2BA1A
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Jun 2024 16:21:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E65B10EB2B;
	Thu, 20 Jun 2024 16:21:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="A0rV1hmG";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2055.outbound.protection.outlook.com [40.107.223.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6332F10EB2B
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Jun 2024 16:21:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M9P4zH2a/RLxbZDhzCwl6ooInX5e8/cazNdvy7fBWByO5gpxFoxYO6CT1Il3XnY/K9vbpstGmcs5zisGFpDfiIIwV0ZmQl/wun31yb3Ck0LMeVtOzfmTCXOg6NYeaAXXDVDbGcckp9LznmUefr9+xlTRta5+zz3wU4tamVYiX1Aqcl1Fm+yhgi0drz7LOyylrTOAQvPO/9PDL8BWJS/alldzrFdn9YPdqu9DW9uHRQ6rT7OmBNepHMHxTVqQo+M7Sg/xbbVXRL3HpJ55ywuDOJyLP1nSFM5JBtItgoGm09CiKbqEIIx3MEhgT4cyvSpz6nwm2XYYb8Kv0rxrP9Twyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ioUv/5/JNqtg/9YiI3TYT3PWrTMEHZjxWL5uDF2cZX8=;
 b=YkAz7m/7I1AvaO/Zdedd86g8X+TKsQc3Q5KfXZ6PsuaVYctFGaX0L5rSjK28libDPaYTBcP6MkjXR1YiIrWZ6fbQwFhnnW+fMFGUpCUwtVyOPLNHcLnxh4Pxew5EI8DEoaMTK7Bge9iMiH99RQBhfubuDuibTWytUK6zor98Q+FqdOcOVg3H3eqCygDLfpRC5ABUOV83DCYhYANZVoCtkBudA/w1u8kr/1HV1t2rewgoWCdvNPEC6Zxeo9c/06z1NvmavoF8aia4q/JyywWJj8lxAGUhAMK+yETE6jSM6PujEdxXkE2nBQng0camKpt3o6ritm1pMwymDKxb6Y66kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ioUv/5/JNqtg/9YiI3TYT3PWrTMEHZjxWL5uDF2cZX8=;
 b=A0rV1hmG3PT+AJcym5gbskWIXjEJvQeuXwwoGaQLb+7Oo0b/3Dox//K4W1fTRx9v70/jTUkoDZIcFJQmugKDbbN/w4uFL+3AIDj2QabX+Wl6TmgU4IU+5sWPjaTMH1QGasIINJUc1gGkPpE6dFFLR9ayly9/wnwa/m+APFwP8hE=
Received: from CH5P222CA0005.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::16)
 by MW4PR12MB7165.namprd12.prod.outlook.com (2603:10b6:303:21b::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.21; Thu, 20 Jun
 2024 16:21:00 +0000
Received: from CH2PEPF0000009C.namprd02.prod.outlook.com
 (2603:10b6:610:1ee:cafe::70) by CH5P222CA0005.outlook.office365.com
 (2603:10b6:610:1ee::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.33 via Frontend
 Transport; Thu, 20 Jun 2024 16:21:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000009C.mail.protection.outlook.com (10.167.244.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Thu, 20 Jun 2024 16:20:59 +0000
Received: from 10.254.92.128.in-addr.arpa (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 20 Jun 2024 11:20:57 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>, "Rodrigo
 Siqueira" <rodrigo.siqueira@amd.com>, Alex Hung <alex.hung@amd.com>
Subject: [PATCH 37/39] drm/amd: Add reg definitions for DCN401 DCC
Date: Thu, 20 Jun 2024 10:11:43 -0600
Message-ID: <20240620161145.2489774-38-alex.hung@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009C:EE_|MW4PR12MB7165:EE_
X-MS-Office365-Filtering-Correlation-Id: 8672403a-d57a-4d9e-13fd-08dc9144f8d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230037|36860700010|376011|1800799021|82310400023; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?otevfMPsIEJXe2oY2ABwSezmnmVH7dhsz+yVEr3+PviqM6Qb8pe6GvncdmJj?=
 =?us-ascii?Q?KsBgJ43ZLkVG/BAOiRdq4rzVBJhvhlkezYcACTWz4VudrLdM/lSQr18nefSb?=
 =?us-ascii?Q?T0OjfYcgEcxb81fa2qEF6LY84JRn7KerbHTqQIZny6KXGT7jyUuH5CUpBcsZ?=
 =?us-ascii?Q?nYkOEriOP+81L/dkH9py6D/DHUoExIt/ZIKEXQknX+54DTQAhSaQE+KyzRbX?=
 =?us-ascii?Q?pS5JM2zFMaNLaH9TE8nq7P9V7RKPLV4OW+Z+O1LdHN4Hj6fdQVGKh3FtdaeQ?=
 =?us-ascii?Q?bgWEuZ+TmSRhVXe3DPEniKPLhJP64Z97GOnLcnstud0cA66WYTDPqVel+gZm?=
 =?us-ascii?Q?vnNCUeFGYezAxixbaWPASXhE9NZhSGQ0GU/oYwRlHnKAZ4YVrtRxsbyZGTlw?=
 =?us-ascii?Q?UD65oq+R3RfqFK+wK1oxepSKGg55XaiOTIUe7gCyLuRduS0RD7Q5apxsyevD?=
 =?us-ascii?Q?hC1ABAx9ui5HHnnOBtN9E8NTdwnEvWoFnw2rpjmOrBBxZbg4SaLVeZzXWMT5?=
 =?us-ascii?Q?n/wIlAP6LoORp03894hMHUheFjHcSp72Ghh1dMfmqTavs/K4Pmbs95PMBUL8?=
 =?us-ascii?Q?mmPA46Dlp5LipphoG3knw+Xd3fqpa1TTTgbHgIgt7Z6UHWU6WX2BXbEurTqm?=
 =?us-ascii?Q?J55h6LPe5xUs1sBaHbqzCziPXUWa1Lz6Bb31hYRj9t8KCOtXYHicbvtF9RKQ?=
 =?us-ascii?Q?hyTt7TGn5DfDs5hqwOD/2eaaO6FVfj1a+q8hXpjwQDph+oQtaC+6Qo8+6WlF?=
 =?us-ascii?Q?IhNGuuEBetgGcTyQhKQv6LmETf4bFWDYbrwHOz8P4rWDM6WUARYPVMsDardx?=
 =?us-ascii?Q?ln7aJX3qwMS2X8OfrgilQeDNeeCwJnH+/L1moM50ao18KwYCzjBnvP13iwQQ?=
 =?us-ascii?Q?2EJWvm77jB+uvlgmRx4lDub1aLtErhIzwWhj9hUDNIa1M+IyRKJHMMT076qB?=
 =?us-ascii?Q?DStk0wZmRePJbsD5HU6s5pE2dlJmLeOmAd/MGxkgRpjd/rmNK3SJAbwyOVUr?=
 =?us-ascii?Q?FQj/1i7cmk7d8pKlDqEDdXnnEmnbWYxTIqUBOZqA/8Ziq2GSR5AjHtEmrj9f?=
 =?us-ascii?Q?AsrJFCp7GIGtkLvUszKm2enylPiZnkcmU8wPxwgA3JBuw9K6rXS/7m750GQh?=
 =?us-ascii?Q?A9+MlleHrh/jeZYhYE593k6pKdkrfF7kR8yMS3EDPdoRdf/8CHc6MH+QDKgs?=
 =?us-ascii?Q?/CiTgOgvh+Fyp6LCgkTK0ylODrfAfMAsS1tZtouk5oCg9M1fuaD1ETV52IGf?=
 =?us-ascii?Q?Lr2X8tyxvpZBj6o0zVI+bSZr8LV/e5R9CUaTBqdszqRBJ1bzV/fBc1iOmfgK?=
 =?us-ascii?Q?Aa73xigo2GNVyQ0GATM76J5yklyxDNojiPZr+CPEBiQZLdJPY5Wvem7YXOB6?=
 =?us-ascii?Q?bUwXLAAvTyQBSENA/IEcafBbZGoQFB7ZyarF5JXQvMifNgctXw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230037)(36860700010)(376011)(1800799021)(82310400023); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 16:20:59.7307 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8672403a-d57a-4d9e-13fd-08dc9144f8d2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7165
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

From: Aurabindo Pillai <aurabindo.pillai@amd.com>

[WHAT]
Add the necessary register definitions to enable DCC on DCN4x

Reviewed-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../include/asic_reg/dcn/dcn_4_1_0_sh_mask.h  | 110 ++++++++++++++++++
 1 file changed, 110 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_4_1_0_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_4_1_0_sh_mask.h
index 0c68f5d818bb..f42a276499cd 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_4_1_0_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_4_1_0_sh_mask.h
@@ -6430,6 +6430,28 @@
 //DCHUBBUB_SDPIF_MEM_PWR_STATUS
 #define DCHUBBUB_SDPIF_MEM_PWR_STATUS__DCHUBBUB_SDPIF_MEM_PWR_STATE__SHIFT                                    0x0
 #define DCHUBBUB_SDPIF_MEM_PWR_STATUS__DCHUBBUB_SDPIF_MEM_PWR_STATE_MASK                                      0x00000003L
+//DCHUBBUB_SDPIF_MCACHE_INVALIDATION_CTL
+#define DCHUBBUB_SDPIF_MCACHE_INVALIDATION_CTL__DCHUBBUB_SDPIF_FLIP_AWAY_MISSING_PIPE0__SHIFT                 0x0
+#define DCHUBBUB_SDPIF_MCACHE_INVALIDATION_CTL__DCHUBBUB_SDPIF_FLIP_AWAY_MISSING_PIPE1__SHIFT                 0x1
+#define DCHUBBUB_SDPIF_MCACHE_INVALIDATION_CTL__DCHUBBUB_SDPIF_FLIP_AWAY_MISSING_PIPE2__SHIFT                 0x2
+#define DCHUBBUB_SDPIF_MCACHE_INVALIDATION_CTL__DCHUBBUB_SDPIF_FLIP_AWAY_MISSING_PIPE3__SHIFT                 0x3
+#define DCHUBBUB_SDPIF_MCACHE_INVALIDATION_CTL__DCHUBBUB_SDPIF_MCACHEID_INV_ERR_CLEAR_PIPE0__SHIFT            0xc
+#define DCHUBBUB_SDPIF_MCACHE_INVALIDATION_CTL__DCHUBBUB_SDPIF_MCACHEID_INV_ERR_CLEAR_PIPE1__SHIFT            0xd
+#define DCHUBBUB_SDPIF_MCACHE_INVALIDATION_CTL__DCHUBBUB_SDPIF_MCACHEID_INV_ERR_CLEAR_PIPE2__SHIFT            0xe
+#define DCHUBBUB_SDPIF_MCACHE_INVALIDATION_CTL__DCHUBBUB_SDPIF_MCACHEID_INV_ERR_CLEAR_PIPE3__SHIFT            0xf
+#define DCHUBBUB_SDPIF_MCACHE_INVALIDATION_CTL__DCHUBBUB_SDPIF_MCACHEID_INV_ERR_ENABLE__SHIFT                 0x1c
+#define DCHUBBUB_SDPIF_MCACHE_INVALIDATION_CTL__DCHUBBUB_SDPIF_MCACHEID_INV_VREADY_MODE__SHIFT                0x1f
+#define DCHUBBUB_SDPIF_MCACHE_INVALIDATION_CTL__DCHUBBUB_SDPIF_FLIP_AWAY_MISSING_PIPE0_MASK                   0x00000001L
+#define DCHUBBUB_SDPIF_MCACHE_INVALIDATION_CTL__DCHUBBUB_SDPIF_FLIP_AWAY_MISSING_PIPE1_MASK                   0x00000002L
+#define DCHUBBUB_SDPIF_MCACHE_INVALIDATION_CTL__DCHUBBUB_SDPIF_FLIP_AWAY_MISSING_PIPE2_MASK                   0x00000004L
+#define DCHUBBUB_SDPIF_MCACHE_INVALIDATION_CTL__DCHUBBUB_SDPIF_FLIP_AWAY_MISSING_PIPE3_MASK                   0x00000008L
+#define DCHUBBUB_SDPIF_MCACHE_INVALIDATION_CTL__DCHUBBUB_SDPIF_MCACHEID_INV_ERR_CLEAR_PIPE0_MASK              0x00001000L
+#define DCHUBBUB_SDPIF_MCACHE_INVALIDATION_CTL__DCHUBBUB_SDPIF_MCACHEID_INV_ERR_CLEAR_PIPE1_MASK              0x00002000L
+#define DCHUBBUB_SDPIF_MCACHE_INVALIDATION_CTL__DCHUBBUB_SDPIF_MCACHEID_INV_ERR_CLEAR_PIPE2_MASK              0x00004000L
+#define DCHUBBUB_SDPIF_MCACHE_INVALIDATION_CTL__DCHUBBUB_SDPIF_MCACHEID_INV_ERR_CLEAR_PIPE3_MASK              0x00008000L
+#define DCHUBBUB_SDPIF_MCACHE_INVALIDATION_CTL__DCHUBBUB_SDPIF_MCACHEID_INV_ERR_ENABLE_MASK                   0x10000000L
+#define DCHUBBUB_SDPIF_MCACHE_INVALIDATION_CTL__DCHUBBUB_SDPIF_MCACHEID_INV_VREADY_MODE_MASK                  0x80000000L
+
 
 
 // addressBlock: dcn_dcec_dchubbubl_hubbub_ret_path_dispdec
@@ -7084,6 +7106,11 @@
 #define HUBP0_DCSURF_PRI_VIEWPORT_START__PRI_VIEWPORT_Y_START__SHIFT                                          0x10
 #define HUBP0_DCSURF_PRI_VIEWPORT_START__PRI_VIEWPORT_X_START_MASK                                            0x0000FFFFL
 #define HUBP0_DCSURF_PRI_VIEWPORT_START__PRI_VIEWPORT_Y_START_MASK                                            0xFFFF0000L
+//HUBP0_DCSURF_VIEWPORT_MCACHE_SPLIT_COORDINATE
+#define HUBP0_DCSURF_VIEWPORT_MCACHE_SPLIT_COORDINATE__VIEWPORT_MCACHE_SPLIT_COORDINATE__SHIFT                0x0
+#define HUBP0_DCSURF_VIEWPORT_MCACHE_SPLIT_COORDINATE__VIEWPORT_MCACHE_SPLIT_COORDINATE_C__SHIFT              0x10
+#define HUBP0_DCSURF_VIEWPORT_MCACHE_SPLIT_COORDINATE__VIEWPORT_MCACHE_SPLIT_COORDINATE_MASK                  0x0000FFFFL
+#define HUBP0_DCSURF_VIEWPORT_MCACHE_SPLIT_COORDINATE__VIEWPORT_MCACHE_SPLIT_COORDINATE_C_MASK                0xFFFF0000L
 //HUBP0_DCSURF_PRI_VIEWPORT_DIMENSION
 #define HUBP0_DCSURF_PRI_VIEWPORT_DIMENSION__PRI_VIEWPORT_WIDTH__SHIFT                                        0x0
 #define HUBP0_DCSURF_PRI_VIEWPORT_DIMENSION__PRI_VIEWPORT_HEIGHT__SHIFT                                       0x10
@@ -7244,6 +7271,23 @@
 #define HUBP0_DCHUBP_MALL_SUB_VP2__SUB_VP_HEIGHT_NEXT_S1__SHIFT                                               0xc
 #define HUBP0_DCHUBP_MALL_SUB_VP2__SUB_VP_HEIGHT_CURR_S1_MASK                                                 0x00000FFFL
 #define HUBP0_DCHUBP_MALL_SUB_VP2__SUB_VP_HEIGHT_NEXT_S1_MASK                                                 0x00FFF000L
+//HUBP0_DCHUBP_MCACHEID_CONFIG
+#define HUBP0_DCHUBP_MCACHEID_CONFIG__MCACHEID_REG_READ_1H_P0__SHIFT                                          0x0
+#define HUBP0_DCHUBP_MCACHEID_CONFIG__MCACHEID_REG_READ_2H_P0__SHIFT                                          0x4
+#define HUBP0_DCHUBP_MCACHEID_CONFIG__MCACHEID_REG_READ_1H_P1__SHIFT                                          0x8
+#define HUBP0_DCHUBP_MCACHEID_CONFIG__MCACHEID_REG_READ_2H_P1__SHIFT                                          0xc
+#define HUBP0_DCHUBP_MCACHEID_CONFIG__MCACHEID_MALL_PREF_1H_P0__SHIFT                                         0x10
+#define HUBP0_DCHUBP_MCACHEID_CONFIG__MCACHEID_MALL_PREF_2H_P0__SHIFT                                         0x14
+#define HUBP0_DCHUBP_MCACHEID_CONFIG__MCACHEID_MALL_PREF_1H_P1__SHIFT                                         0x18
+#define HUBP0_DCHUBP_MCACHEID_CONFIG__MCACHEID_MALL_PREF_2H_P1__SHIFT                                         0x1c
+#define HUBP0_DCHUBP_MCACHEID_CONFIG__MCACHEID_REG_READ_1H_P0_MASK                                            0x0000000FL
+#define HUBP0_DCHUBP_MCACHEID_CONFIG__MCACHEID_REG_READ_2H_P0_MASK                                            0x000000F0L
+#define HUBP0_DCHUBP_MCACHEID_CONFIG__MCACHEID_REG_READ_1H_P1_MASK                                            0x00000F00L
+#define HUBP0_DCHUBP_MCACHEID_CONFIG__MCACHEID_REG_READ_2H_P1_MASK                                            0x0000F000L
+#define HUBP0_DCHUBP_MCACHEID_CONFIG__MCACHEID_MALL_PREF_1H_P0_MASK                                           0x000F0000L
+#define HUBP0_DCHUBP_MCACHEID_CONFIG__MCACHEID_MALL_PREF_2H_P0_MASK                                           0x00F00000L
+#define HUBP0_DCHUBP_MCACHEID_CONFIG__MCACHEID_MALL_PREF_1H_P1_MASK                                           0x0F000000L
+#define HUBP0_DCHUBP_MCACHEID_CONFIG__MCACHEID_MALL_PREF_2H_P1_MASK                                           0xF0000000L
 //HUBP0_HUBP_MEASURE_WIN_CTRL_DCFCLK
 #define HUBP0_HUBP_MEASURE_WIN_CTRL_DCFCLK__HUBP_MEASURE_WIN_EN_DCFCLK__SHIFT                                 0x0
 #define HUBP0_HUBP_MEASURE_WIN_CTRL_DCFCLK__HUBP_MEASURE_WIN_PERIOD_M1_DCFCLK__SHIFT                          0x4
@@ -8013,6 +8057,11 @@
 #define HUBP1_DCSURF_PRI_VIEWPORT_START__PRI_VIEWPORT_Y_START__SHIFT                                          0x10
 #define HUBP1_DCSURF_PRI_VIEWPORT_START__PRI_VIEWPORT_X_START_MASK                                            0x0000FFFFL
 #define HUBP1_DCSURF_PRI_VIEWPORT_START__PRI_VIEWPORT_Y_START_MASK                                            0xFFFF0000L
+//HUBP1_DCSURF_VIEWPORT_MCACHE_SPLIT_COORDINATE
+#define HUBP1_DCSURF_VIEWPORT_MCACHE_SPLIT_COORDINATE__VIEWPORT_MCACHE_SPLIT_COORDINATE__SHIFT                0x0
+#define HUBP1_DCSURF_VIEWPORT_MCACHE_SPLIT_COORDINATE__VIEWPORT_MCACHE_SPLIT_COORDINATE_C__SHIFT              0x10
+#define HUBP1_DCSURF_VIEWPORT_MCACHE_SPLIT_COORDINATE__VIEWPORT_MCACHE_SPLIT_COORDINATE_MASK                  0x0000FFFFL
+#define HUBP1_DCSURF_VIEWPORT_MCACHE_SPLIT_COORDINATE__VIEWPORT_MCACHE_SPLIT_COORDINATE_C_MASK                0xFFFF0000L
 //HUBP1_DCSURF_PRI_VIEWPORT_DIMENSION
 #define HUBP1_DCSURF_PRI_VIEWPORT_DIMENSION__PRI_VIEWPORT_WIDTH__SHIFT                                        0x0
 #define HUBP1_DCSURF_PRI_VIEWPORT_DIMENSION__PRI_VIEWPORT_HEIGHT__SHIFT                                       0x10
@@ -8173,6 +8222,23 @@
 #define HUBP1_DCHUBP_MALL_SUB_VP2__SUB_VP_HEIGHT_NEXT_S1__SHIFT                                               0xc
 #define HUBP1_DCHUBP_MALL_SUB_VP2__SUB_VP_HEIGHT_CURR_S1_MASK                                                 0x00000FFFL
 #define HUBP1_DCHUBP_MALL_SUB_VP2__SUB_VP_HEIGHT_NEXT_S1_MASK                                                 0x00FFF000L
+//HUBP1_DCHUBP_MCACHEID_CONFIG
+#define HUBP1_DCHUBP_MCACHEID_CONFIG__MCACHEID_REG_READ_1H_P0__SHIFT                                          0x0
+#define HUBP1_DCHUBP_MCACHEID_CONFIG__MCACHEID_REG_READ_2H_P0__SHIFT                                          0x4
+#define HUBP1_DCHUBP_MCACHEID_CONFIG__MCACHEID_REG_READ_1H_P1__SHIFT                                          0x8
+#define HUBP1_DCHUBP_MCACHEID_CONFIG__MCACHEID_REG_READ_2H_P1__SHIFT                                          0xc
+#define HUBP1_DCHUBP_MCACHEID_CONFIG__MCACHEID_MALL_PREF_1H_P0__SHIFT                                         0x10
+#define HUBP1_DCHUBP_MCACHEID_CONFIG__MCACHEID_MALL_PREF_2H_P0__SHIFT                                         0x14
+#define HUBP1_DCHUBP_MCACHEID_CONFIG__MCACHEID_MALL_PREF_1H_P1__SHIFT                                         0x18
+#define HUBP1_DCHUBP_MCACHEID_CONFIG__MCACHEID_MALL_PREF_2H_P1__SHIFT                                         0x1c
+#define HUBP1_DCHUBP_MCACHEID_CONFIG__MCACHEID_REG_READ_1H_P0_MASK                                            0x0000000FL
+#define HUBP1_DCHUBP_MCACHEID_CONFIG__MCACHEID_REG_READ_2H_P0_MASK                                            0x000000F0L
+#define HUBP1_DCHUBP_MCACHEID_CONFIG__MCACHEID_REG_READ_1H_P1_MASK                                            0x00000F00L
+#define HUBP1_DCHUBP_MCACHEID_CONFIG__MCACHEID_REG_READ_2H_P1_MASK                                            0x0000F000L
+#define HUBP1_DCHUBP_MCACHEID_CONFIG__MCACHEID_MALL_PREF_1H_P0_MASK                                           0x000F0000L
+#define HUBP1_DCHUBP_MCACHEID_CONFIG__MCACHEID_MALL_PREF_2H_P0_MASK                                           0x00F00000L
+#define HUBP1_DCHUBP_MCACHEID_CONFIG__MCACHEID_MALL_PREF_1H_P1_MASK                                           0x0F000000L
+#define HUBP1_DCHUBP_MCACHEID_CONFIG__MCACHEID_MALL_PREF_2H_P1_MASK                                           0xF0000000L
 //HUBP1_HUBP_MEASURE_WIN_CTRL_DCFCLK
 #define HUBP1_HUBP_MEASURE_WIN_CTRL_DCFCLK__HUBP_MEASURE_WIN_EN_DCFCLK__SHIFT                                 0x0
 #define HUBP1_HUBP_MEASURE_WIN_CTRL_DCFCLK__HUBP_MEASURE_WIN_PERIOD_M1_DCFCLK__SHIFT                          0x4
@@ -8942,6 +9008,11 @@
 #define HUBP2_DCSURF_PRI_VIEWPORT_START__PRI_VIEWPORT_Y_START__SHIFT                                          0x10
 #define HUBP2_DCSURF_PRI_VIEWPORT_START__PRI_VIEWPORT_X_START_MASK                                            0x0000FFFFL
 #define HUBP2_DCSURF_PRI_VIEWPORT_START__PRI_VIEWPORT_Y_START_MASK                                            0xFFFF0000L
+//HUBP2_DCSURF_VIEWPORT_MCACHE_SPLIT_COORDINATE
+#define HUBP2_DCSURF_VIEWPORT_MCACHE_SPLIT_COORDINATE__VIEWPORT_MCACHE_SPLIT_COORDINATE__SHIFT                0x0
+#define HUBP2_DCSURF_VIEWPORT_MCACHE_SPLIT_COORDINATE__VIEWPORT_MCACHE_SPLIT_COORDINATE_C__SHIFT              0x10
+#define HUBP2_DCSURF_VIEWPORT_MCACHE_SPLIT_COORDINATE__VIEWPORT_MCACHE_SPLIT_COORDINATE_MASK                  0x0000FFFFL
+#define HUBP2_DCSURF_VIEWPORT_MCACHE_SPLIT_COORDINATE__VIEWPORT_MCACHE_SPLIT_COORDINATE_C_MASK                0xFFFF0000L
 //HUBP2_DCSURF_PRI_VIEWPORT_DIMENSION
 #define HUBP2_DCSURF_PRI_VIEWPORT_DIMENSION__PRI_VIEWPORT_WIDTH__SHIFT                                        0x0
 #define HUBP2_DCSURF_PRI_VIEWPORT_DIMENSION__PRI_VIEWPORT_HEIGHT__SHIFT                                       0x10
@@ -9102,6 +9173,23 @@
 #define HUBP2_DCHUBP_MALL_SUB_VP2__SUB_VP_HEIGHT_NEXT_S1__SHIFT                                               0xc
 #define HUBP2_DCHUBP_MALL_SUB_VP2__SUB_VP_HEIGHT_CURR_S1_MASK                                                 0x00000FFFL
 #define HUBP2_DCHUBP_MALL_SUB_VP2__SUB_VP_HEIGHT_NEXT_S1_MASK                                                 0x00FFF000L
+//HUBP2_DCHUBP_MCACHEID_CONFIG
+#define HUBP2_DCHUBP_MCACHEID_CONFIG__MCACHEID_REG_READ_1H_P0__SHIFT                                          0x0
+#define HUBP2_DCHUBP_MCACHEID_CONFIG__MCACHEID_REG_READ_2H_P0__SHIFT                                          0x4
+#define HUBP2_DCHUBP_MCACHEID_CONFIG__MCACHEID_REG_READ_1H_P1__SHIFT                                          0x8
+#define HUBP2_DCHUBP_MCACHEID_CONFIG__MCACHEID_REG_READ_2H_P1__SHIFT                                          0xc
+#define HUBP2_DCHUBP_MCACHEID_CONFIG__MCACHEID_MALL_PREF_1H_P0__SHIFT                                         0x10
+#define HUBP2_DCHUBP_MCACHEID_CONFIG__MCACHEID_MALL_PREF_2H_P0__SHIFT                                         0x14
+#define HUBP2_DCHUBP_MCACHEID_CONFIG__MCACHEID_MALL_PREF_1H_P1__SHIFT                                         0x18
+#define HUBP2_DCHUBP_MCACHEID_CONFIG__MCACHEID_MALL_PREF_2H_P1__SHIFT                                         0x1c
+#define HUBP2_DCHUBP_MCACHEID_CONFIG__MCACHEID_REG_READ_1H_P0_MASK                                            0x0000000FL
+#define HUBP2_DCHUBP_MCACHEID_CONFIG__MCACHEID_REG_READ_2H_P0_MASK                                            0x000000F0L
+#define HUBP2_DCHUBP_MCACHEID_CONFIG__MCACHEID_REG_READ_1H_P1_MASK                                            0x00000F00L
+#define HUBP2_DCHUBP_MCACHEID_CONFIG__MCACHEID_REG_READ_2H_P1_MASK                                            0x0000F000L
+#define HUBP2_DCHUBP_MCACHEID_CONFIG__MCACHEID_MALL_PREF_1H_P0_MASK                                           0x000F0000L
+#define HUBP2_DCHUBP_MCACHEID_CONFIG__MCACHEID_MALL_PREF_2H_P0_MASK                                           0x00F00000L
+#define HUBP2_DCHUBP_MCACHEID_CONFIG__MCACHEID_MALL_PREF_1H_P1_MASK                                           0x0F000000L
+#define HUBP2_DCHUBP_MCACHEID_CONFIG__MCACHEID_MALL_PREF_2H_P1_MASK                                           0xF0000000L
 //HUBP2_HUBP_MEASURE_WIN_CTRL_DCFCLK
 #define HUBP2_HUBP_MEASURE_WIN_CTRL_DCFCLK__HUBP_MEASURE_WIN_EN_DCFCLK__SHIFT                                 0x0
 #define HUBP2_HUBP_MEASURE_WIN_CTRL_DCFCLK__HUBP_MEASURE_WIN_PERIOD_M1_DCFCLK__SHIFT                          0x4
@@ -9871,6 +9959,11 @@
 #define HUBP3_DCSURF_PRI_VIEWPORT_START__PRI_VIEWPORT_Y_START__SHIFT                                          0x10
 #define HUBP3_DCSURF_PRI_VIEWPORT_START__PRI_VIEWPORT_X_START_MASK                                            0x0000FFFFL
 #define HUBP3_DCSURF_PRI_VIEWPORT_START__PRI_VIEWPORT_Y_START_MASK                                            0xFFFF0000L
+//HUBP3_DCSURF_VIEWPORT_MCACHE_SPLIT_COORDINATE
+#define HUBP3_DCSURF_VIEWPORT_MCACHE_SPLIT_COORDINATE__VIEWPORT_MCACHE_SPLIT_COORDINATE__SHIFT                0x0
+#define HUBP3_DCSURF_VIEWPORT_MCACHE_SPLIT_COORDINATE__VIEWPORT_MCACHE_SPLIT_COORDINATE_C__SHIFT              0x10
+#define HUBP3_DCSURF_VIEWPORT_MCACHE_SPLIT_COORDINATE__VIEWPORT_MCACHE_SPLIT_COORDINATE_MASK                  0x0000FFFFL
+#define HUBP3_DCSURF_VIEWPORT_MCACHE_SPLIT_COORDINATE__VIEWPORT_MCACHE_SPLIT_COORDINATE_C_MASK                0xFFFF0000L
 //HUBP3_DCSURF_PRI_VIEWPORT_DIMENSION
 #define HUBP3_DCSURF_PRI_VIEWPORT_DIMENSION__PRI_VIEWPORT_WIDTH__SHIFT                                        0x0
 #define HUBP3_DCSURF_PRI_VIEWPORT_DIMENSION__PRI_VIEWPORT_HEIGHT__SHIFT                                       0x10
@@ -10031,6 +10124,23 @@
 #define HUBP3_DCHUBP_MALL_SUB_VP2__SUB_VP_HEIGHT_NEXT_S1__SHIFT                                               0xc
 #define HUBP3_DCHUBP_MALL_SUB_VP2__SUB_VP_HEIGHT_CURR_S1_MASK                                                 0x00000FFFL
 #define HUBP3_DCHUBP_MALL_SUB_VP2__SUB_VP_HEIGHT_NEXT_S1_MASK                                                 0x00FFF000L
+//HUBP3_DCHUBP_MCACHEID_CONFIG
+#define HUBP3_DCHUBP_MCACHEID_CONFIG__MCACHEID_REG_READ_1H_P0__SHIFT                                          0x0
+#define HUBP3_DCHUBP_MCACHEID_CONFIG__MCACHEID_REG_READ_2H_P0__SHIFT                                          0x4
+#define HUBP3_DCHUBP_MCACHEID_CONFIG__MCACHEID_REG_READ_1H_P1__SHIFT                                          0x8
+#define HUBP3_DCHUBP_MCACHEID_CONFIG__MCACHEID_REG_READ_2H_P1__SHIFT                                          0xc
+#define HUBP3_DCHUBP_MCACHEID_CONFIG__MCACHEID_MALL_PREF_1H_P0__SHIFT                                         0x10
+#define HUBP3_DCHUBP_MCACHEID_CONFIG__MCACHEID_MALL_PREF_2H_P0__SHIFT                                         0x14
+#define HUBP3_DCHUBP_MCACHEID_CONFIG__MCACHEID_MALL_PREF_1H_P1__SHIFT                                         0x18
+#define HUBP3_DCHUBP_MCACHEID_CONFIG__MCACHEID_MALL_PREF_2H_P1__SHIFT                                         0x1c
+#define HUBP3_DCHUBP_MCACHEID_CONFIG__MCACHEID_REG_READ_1H_P0_MASK                                            0x0000000FL
+#define HUBP3_DCHUBP_MCACHEID_CONFIG__MCACHEID_REG_READ_2H_P0_MASK                                            0x000000F0L
+#define HUBP3_DCHUBP_MCACHEID_CONFIG__MCACHEID_REG_READ_1H_P1_MASK                                            0x00000F00L
+#define HUBP3_DCHUBP_MCACHEID_CONFIG__MCACHEID_REG_READ_2H_P1_MASK                                            0x0000F000L
+#define HUBP3_DCHUBP_MCACHEID_CONFIG__MCACHEID_MALL_PREF_1H_P0_MASK                                           0x000F0000L
+#define HUBP3_DCHUBP_MCACHEID_CONFIG__MCACHEID_MALL_PREF_2H_P0_MASK                                           0x00F00000L
+#define HUBP3_DCHUBP_MCACHEID_CONFIG__MCACHEID_MALL_PREF_1H_P1_MASK                                           0x0F000000L
+#define HUBP3_DCHUBP_MCACHEID_CONFIG__MCACHEID_MALL_PREF_2H_P1_MASK                                           0xF0000000L
 //HUBP3_HUBP_MEASURE_WIN_CTRL_DCFCLK
 #define HUBP3_HUBP_MEASURE_WIN_CTRL_DCFCLK__HUBP_MEASURE_WIN_EN_DCFCLK__SHIFT                                 0x0
 #define HUBP3_HUBP_MEASURE_WIN_CTRL_DCFCLK__HUBP_MEASURE_WIN_PERIOD_M1_DCFCLK__SHIFT                          0x4
-- 
2.34.1

