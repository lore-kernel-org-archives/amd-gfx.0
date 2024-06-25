Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53604C2BBCA
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Jun 2024 18:22:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 642C610E21E;
	Tue, 25 Jun 2024 18:22:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Jvckx12i";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2058.outbound.protection.outlook.com [40.107.92.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D31E010E21E
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Jun 2024 18:22:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U3meEKuB81v429BrAhPTtO5eYsLMWMdztCUnhlw2v2cMy02/dKNjmwmPxall74ElpqmUV+JUQoOH11nJ9v3QDTXgsl4QcpANVTJusH2z2PgEoeGdI1sd43o3Ge6GL2ZSwhLm/VEY1LE3+lE4uGFYqMF0b5wqlJTfXgJqeu9VTa8AqIiMyepSr0gPRPpJDNtzzST+Zyd1BrX1T+1VDyx/7KGsg889jqv9wt3LO4uCGEKy86f+e4FOj1Wu+F1nD2SHcXbwJPqkJVofUnUH5KqUL7t37pIez7EwagnYzX/Qow7wK4C5yDtwP9hLqJa5xQ6/PfPzoPkm1nclwYyhPBTOcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NtlNK9WPG+35qsUpVcWuLxfGm0xEDm9jTVP2FXr6ag4=;
 b=AXMTAN/775USQbtjKfWwSQSfxKD3xWLiuJ6T2H2z4UpUOmD079nR6RihCT8Lsum7NMvEhftvtjsBLwT6M1XciK6XABpqATVylIsvFU2ey3lLA86y69VQvQGFOnIsdNcURFU++6ehenT1l0rRCBcTcqTtzAzfhbeQHMHPhAvI/TQWohUgmKAtKK6oLPkoi0vtn3+bYJd1EZMg5MU4t51JL1m9SXJpHhxCI4dlTJ67kAITGPdbbmEJy9iOC3d9Mn3nVUkjTLriPEOW85LkVSDYRqJYvpGw4lAinWL/YAqCiMMZ8w+7bu/5MRBjCnkgS9+UKShKCQskJOM4LyKWfD2lIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NtlNK9WPG+35qsUpVcWuLxfGm0xEDm9jTVP2FXr6ag4=;
 b=Jvckx12iFkCBXfFANLqY0nR026zzcxis9EK7OE/iWkL+hLVHDWn+P7Wm8f2O97D0jOfQKf7j46srrD7Zv8APfdzsg3Wwc5wP48qwiVErb6Y+pb4fOYMSa2h4hLEjtK/K6JQI4zgrVJD+0j/d0T8IRmX/vpukYTqqsBE1V4KMR6Y=
Received: from CH0PR03CA0443.namprd03.prod.outlook.com (2603:10b6:610:10e::7)
 by MW3PR12MB4426.namprd12.prod.outlook.com (2603:10b6:303:58::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.29; Tue, 25 Jun
 2024 18:22:49 +0000
Received: from DS3PEPF000099D9.namprd04.prod.outlook.com
 (2603:10b6:610:10e:cafe::b4) by CH0PR03CA0443.outlook.office365.com
 (2603:10b6:610:10e::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.22 via Frontend
 Transport; Tue, 25 Jun 2024 18:22:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D9.mail.protection.outlook.com (10.167.17.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Tue, 25 Jun 2024 18:22:49 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 25 Jun
 2024 13:22:48 -0500
Received: from aaurabin-suse.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 25 Jun 2024 13:22:48 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <tom.stdenis@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <harry.wentland@amd.com>,
 <rodrigo.siqueira@amd.com>, <aurabindo.pillai@amd.com>
Subject: [PATCH] drm/amd: Add some missing register definitions
Date: Tue, 25 Jun 2024 14:22:48 -0400
Message-ID: <20240625182248.319867-1-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: aurabindo.pillai@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D9:EE_|MW3PR12MB4426:EE_
X-MS-Office365-Filtering-Correlation-Id: 450efefe-745f-4977-51d1-08dc9543d1d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230038|1800799022|82310400024|36860700011|376012; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bXEkm4MWtGFdhAOlOVB27YOZU2TbyjF4atBTXs+RQqe871I0AOSPhiyjx6rY?=
 =?us-ascii?Q?apkg/gGXhxlMwREkOUwTMnKKe9ZvMBUJcuWaM+iLc2BSnPkFSpcSEYinb5JH?=
 =?us-ascii?Q?o9D+5lFgGEL+rv3BPbc2Z+4vWGwpMfARuWF3/SjTQ6Z3fyILLZ92UxTJg2AO?=
 =?us-ascii?Q?uerCkJSL8Btwn3TM0zw2bRqZcwByR1RUtVrt5MKPtvt3+96GauBHJm+5zm9K?=
 =?us-ascii?Q?p4GB5Z0cPuwBeVDbhhKN9k7BYH7Y3JI9HkZfCnniG+LlRkHiqQC8CI2SAaJr?=
 =?us-ascii?Q?QHSVl6rSfelbZcnu9ZKCxoGRGIOlYsD0+DCiAkCpE97GDy3QmmsLuSDK3VlP?=
 =?us-ascii?Q?2A3NX7HUxkwZEiJJOySTyTjPNU0v2G4fBpLZ9LuYQyU59C6LNBtbbH30l2eQ?=
 =?us-ascii?Q?QZYtWakktdZvNTJtn6FnnSmogmBOePZg7E5YnX4vROA+J6iblZtI7sNnprZ+?=
 =?us-ascii?Q?CaZ5EukxvU2eZpvjnwl4nGPOl6jkxUod9WGM+IvEqijChaNyf+TYinue5vfa?=
 =?us-ascii?Q?EmpnqUC7GiGX+xd+6OeoqayjHHbcHvs6wt0O0nGkUo1x4Rn6xb2u4HBHEaag?=
 =?us-ascii?Q?EoFSVmRanSe3ROjPpIztnSg0LojMgpCG0rxgCBTLTjML80KrRVLTL3LLPtLB?=
 =?us-ascii?Q?1EDFm7gIUZpoknDRROzxHuSXtR/djUG4N6BJ2PIUON9zRqmmaTwroeuK6Esq?=
 =?us-ascii?Q?o1+3zm/9rHTMKHNPLKrkERM8iwJxEU34myacxaR41fwpiSlEBoSPS7Gyg68v?=
 =?us-ascii?Q?Byf6PdvUF/UAq5j2T9Is04gAK9P/oveJe2QyCyx/ZK35Ib2PZpiGaII8vVtG?=
 =?us-ascii?Q?+Z457Hx7q4nDkkUwyhSKuZHNk4KGV9PgHwyTGd3h3xpesfonnBTnNEPdhAqO?=
 =?us-ascii?Q?DBik0bcOPsO9mB1SPw5mICqiUTsFBqTUUTyLwiCgRu13YOhPWULEVpqZJSD0?=
 =?us-ascii?Q?Xcnw8Hvk4SCBZ/7T4BmlkBSqjLWs7L7LckzjXZS4LAwoquIjWDLdpj7bKkH2?=
 =?us-ascii?Q?i7+gF6vn06C+puh8NfSwCeIYu4GK2HWZOmULVDb0/Uajd0BihN6U9T1IEb3u?=
 =?us-ascii?Q?DUTrip7KzasI2DMXcC2qp0AYdpsR3pxC8pSzoEa4PMTIN92VSxhK+RY0Vuvw?=
 =?us-ascii?Q?ke8K7et25AyoGGqF2SpDVyKfFOyGAV7y72up047FheHF0Vz+K7mc7SqEAzEH?=
 =?us-ascii?Q?8Si5bhMcdVrABTp12OerQDL8Vnn5dEpB1iMvwYJlhEQU0iFegTYOMUmaHZhi?=
 =?us-ascii?Q?jIWdQN50GyaEKsqJQII2UbuoCe8C2B3//ibS071C6MFCkLGBRgJylgXr/y9I?=
 =?us-ascii?Q?RKUxPLSTBMSalc39ifgIoXK2vaWtFXdXlJAtDZ0xgsfbV271DqD3fPkJHGxI?=
 =?us-ascii?Q?bFTvkYuF4UMTLAtIIsubIBcJiTCb8L+db9IgokQATBT3dro4D4RpcYSjxR3C?=
 =?us-ascii?Q?oTjAdpXcg7gQX5jiQ664hocX2LIWWRZD?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230038)(1800799022)(82310400024)(36860700011)(376012); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2024 18:22:49.4464 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 450efefe-745f-4977-51d1-08dc9543d1d3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4426
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

Add some register offsets that are required for Display DCC on DCN401

Fixes: 000342e3a22 ("drm/amd: Add reg definitions for DCN401 DCC")
Reported-by: Tom St Denis <tom.stdenis@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 .../include/asic_reg/dcn/dcn_4_1_0_offset.h    | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_4_1_0_offset.h b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_4_1_0_offset.h
index 5dabf0abccce..15e5a65cf492 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_4_1_0_offset.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_4_1_0_offset.h
@@ -1777,6 +1777,8 @@
 #define regDCHUBBUB_SDPIF_MEM_PWR_CTRL_BASE_IDX                                                         2
 #define regDCHUBBUB_SDPIF_MEM_PWR_STATUS                                                                0x0487
 #define regDCHUBBUB_SDPIF_MEM_PWR_STATUS_BASE_IDX                                                       2
+#define regDCHUBBUB_SDPIF_MCACHE_INVALIDATION_CTL                                                       0x0488
+#define regDCHUBBUB_SDPIF_MCACHE_INVALIDATION_CTL_BASE_IDX                                              2
 
 
 // addressBlock: dcn_dcec_dchubbubl_hubbub_ret_path_dispdec
@@ -2089,6 +2091,8 @@
 #define regHUBP0_DCSURF_TILING_CONFIG_BASE_IDX                                                          2
 #define regHUBP0_DCSURF_PRI_VIEWPORT_START                                                              0x05e9
 #define regHUBP0_DCSURF_PRI_VIEWPORT_START_BASE_IDX                                                     2
+#define regHUBP0_DCSURF_VIEWPORT_MCACHE_SPLIT_COORDINATE                                                0x05ea
+#define regHUBP0_DCSURF_VIEWPORT_MCACHE_SPLIT_COORDINATE_BASE_IDX                                       2
 #define regHUBP0_DCSURF_PRI_VIEWPORT_DIMENSION                                                          0x05eb
 #define regHUBP0_DCSURF_PRI_VIEWPORT_DIMENSION_BASE_IDX                                                 2
 #define regHUBP0_DCSURF_PRI_VIEWPORT_START_C                                                            0x05ec
@@ -2121,6 +2125,8 @@
 #define regHUBP0_DCHUBP_MALL_SUB_VP1_BASE_IDX                                                           2
 #define regHUBP0_DCHUBP_MALL_SUB_VP2                                                                    0x05fa
 #define regHUBP0_DCHUBP_MALL_SUB_VP2_BASE_IDX                                                           2
+#define regHUBP0_DCHUBP_MCACHEID_CONFIG                                                                 0x05fb
+#define regHUBP0_DCHUBP_MCACHEID_CONFIG_BASE_IDX                                                        2
 #define regHUBP0_HUBPREQ_DEBUG_DB                                                                       0x05fc
 #define regHUBP0_HUBPREQ_DEBUG_DB_BASE_IDX                                                              2
 #define regHUBP0_HUBPREQ_DEBUG                                                                          0x05fd
@@ -2378,6 +2384,8 @@
 #define regHUBP1_DCSURF_TILING_CONFIG_BASE_IDX                                                          2
 #define regHUBP1_DCSURF_PRI_VIEWPORT_START                                                              0x06c5
 #define regHUBP1_DCSURF_PRI_VIEWPORT_START_BASE_IDX                                                     2
+#define regHUBP1_DCSURF_VIEWPORT_MCACHE_SPLIT_COORDINATE                                                0x06c6
+#define regHUBP1_DCSURF_VIEWPORT_MCACHE_SPLIT_COORDINATE_BASE_IDX                                       2
 #define regHUBP1_DCSURF_PRI_VIEWPORT_DIMENSION                                                          0x06c7
 #define regHUBP1_DCSURF_PRI_VIEWPORT_DIMENSION_BASE_IDX                                                 2
 #define regHUBP1_DCSURF_PRI_VIEWPORT_START_C                                                            0x06c8
@@ -2410,6 +2418,8 @@
 #define regHUBP1_DCHUBP_MALL_SUB_VP1_BASE_IDX                                                           2
 #define regHUBP1_DCHUBP_MALL_SUB_VP2                                                                    0x06d6
 #define regHUBP1_DCHUBP_MALL_SUB_VP2_BASE_IDX                                                           2
+#define regHUBP1_DCHUBP_MCACHEID_CONFIG                                                                 0x06d7
+#define regHUBP1_DCHUBP_MCACHEID_CONFIG_BASE_IDX                                                        2
 #define regHUBP1_HUBPREQ_DEBUG_DB                                                                       0x06d8
 #define regHUBP1_HUBPREQ_DEBUG_DB_BASE_IDX                                                              2
 #define regHUBP1_HUBPREQ_DEBUG                                                                          0x06d9
@@ -2667,6 +2677,8 @@
 #define regHUBP2_DCSURF_TILING_CONFIG_BASE_IDX                                                          2
 #define regHUBP2_DCSURF_PRI_VIEWPORT_START                                                              0x07a1
 #define regHUBP2_DCSURF_PRI_VIEWPORT_START_BASE_IDX                                                     2
+#define regHUBP2_DCSURF_VIEWPORT_MCACHE_SPLIT_COORDINATE                                                0x07a2
+#define regHUBP2_DCSURF_VIEWPORT_MCACHE_SPLIT_COORDINATE_BASE_IDX                                       2
 #define regHUBP2_DCSURF_PRI_VIEWPORT_DIMENSION                                                          0x07a3
 #define regHUBP2_DCSURF_PRI_VIEWPORT_DIMENSION_BASE_IDX                                                 2
 #define regHUBP2_DCSURF_PRI_VIEWPORT_START_C                                                            0x07a4
@@ -2699,6 +2711,8 @@
 #define regHUBP2_DCHUBP_MALL_SUB_VP1_BASE_IDX                                                           2
 #define regHUBP2_DCHUBP_MALL_SUB_VP2                                                                    0x07b2
 #define regHUBP2_DCHUBP_MALL_SUB_VP2_BASE_IDX                                                           2
+#define regHUBP2_DCHUBP_MCACHEID_CONFIG                                                                 0x07b3
+#define regHUBP2_DCHUBP_MCACHEID_CONFIG_BASE_IDX                                                        2
 #define regHUBP2_HUBPREQ_DEBUG_DB                                                                       0x07b4
 #define regHUBP2_HUBPREQ_DEBUG_DB_BASE_IDX                                                              2
 #define regHUBP2_HUBPREQ_DEBUG                                                                          0x07b5
@@ -2957,6 +2971,8 @@
 #define regHUBP3_DCSURF_TILING_CONFIG_BASE_IDX                                                          2
 #define regHUBP3_DCSURF_PRI_VIEWPORT_START                                                              0x087d
 #define regHUBP3_DCSURF_PRI_VIEWPORT_START_BASE_IDX                                                     2
+#define regHUBP3_DCSURF_VIEWPORT_MCACHE_SPLIT_COORDINATE                                                0x087e
+#define regHUBP3_DCSURF_VIEWPORT_MCACHE_SPLIT_COORDINATE_BASE_IDX                                       2
 #define regHUBP3_DCSURF_PRI_VIEWPORT_DIMENSION                                                          0x087f
 #define regHUBP3_DCSURF_PRI_VIEWPORT_DIMENSION_BASE_IDX                                                 2
 #define regHUBP3_DCSURF_PRI_VIEWPORT_START_C                                                            0x0880
@@ -2989,6 +3005,8 @@
 #define regHUBP3_DCHUBP_MALL_SUB_VP1_BASE_IDX                                                           2
 #define regHUBP3_DCHUBP_MALL_SUB_VP2                                                                    0x088e
 #define regHUBP3_DCHUBP_MALL_SUB_VP2_BASE_IDX                                                           2
+#define regHUBP3_DCHUBP_MCACHEID_CONFIG                                                                 0x088f
+#define regHUBP3_DCHUBP_MCACHEID_CONFIG_BASE_IDX                                                        2
 #define regHUBP3_HUBPREQ_DEBUG_DB                                                                       0x0890
 #define regHUBP3_HUBPREQ_DEBUG_DB_BASE_IDX                                                              2
 #define regHUBP3_HUBPREQ_DEBUG                                                                          0x0891
-- 
2.45.2

