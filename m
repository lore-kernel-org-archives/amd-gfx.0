Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91215C2BB85
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Jun 2024 22:14:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E423510E501;
	Mon, 17 Jun 2024 22:14:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OB2vjCQX";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2042.outbound.protection.outlook.com [40.107.244.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9015410E501
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Jun 2024 22:14:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OuGviSlv8Fggje9/2rBmfxywwkIFw90RE4cUcr3Cb6eNd//jh1vKxqhRRy3iIF8PMJ+0OnEqc9YNNEbxvYatOyrOL/c365hW6Evbm28Zbct4Un3fVu6fSSwk6Kq3ScjHnWGvPIRQx2MDSkxWTxi7UhVyuQrPc9HAuQ2Pxath5TjQJMeh5tpwA3UZ99bXDx7p31thQ24XqABU0HbOiH7XbpwYm+TjITjYNeUVkxZBED8oLcsq1eRXrpFbYq/O8FKm1spFks9XZEHJhvOSqdc1n0LmGwVQx1gNFUBup+mC3Oq6XiwTyNlR0Zonm9aPZz14EryoN5eZcLS/zm8SX3+KUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TXWlA0qkpZ0R/XAxj3YvI+3j0A97RTADiKLOm5+4CPo=;
 b=eqIh4DsCVoMA5NyAL1bRoNl3uTehuJmnRzIzQQNCI7Y7LXbBKIc6GI7xs6m8BB2TO/63U0KQQO6Bu1IkxBIU0XMd9w2koSoCu6+qgbKFgzCAuRpUdvLRIwgula3jq2MUPfCYoKxH2FmCBE62CnyAbf+g4ZUPEqyzppvp1J34mNlLiprBfsbLxdSA2qoa3MLPcqsJta3fO16mTETrQskFCnnjglcsRSa7gwZ/UWVrf+H6tpu3/dEeBR1P/a1j4ltNuaFBioY6QYDC280OzIFNx2zsUnDmz2KDzJRcZWD+hkYtDTKUVRL+5dysy2E5fZu5DzRhTdq6ddnz1n3HDmg2SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TXWlA0qkpZ0R/XAxj3YvI+3j0A97RTADiKLOm5+4CPo=;
 b=OB2vjCQXTrjcI2qL9SWF5+VUQn89xyhBFe87SETAeFMde/AjHvRspBAmoZU7Nz3Wyg/l3brCLHmGXPpj2hnC9/38/4AgtHEYTOckLGGJiNMrqZu5jZRMRbrs6dJwiP6Bk7kfOiGP+enYjakfHFd6FSqjaVa+99JeYj5Ev6JYsWM=
Received: from BL1PR13CA0119.namprd13.prod.outlook.com (2603:10b6:208:2b9::34)
 by PH7PR12MB9074.namprd12.prod.outlook.com (2603:10b6:510:2f4::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 22:14:35 +0000
Received: from BN3PEPF0000B36F.namprd21.prod.outlook.com
 (2603:10b6:208:2b9:cafe::bf) by BL1PR13CA0119.outlook.office365.com
 (2603:10b6:208:2b9::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.25 via Frontend
 Transport; Mon, 17 Jun 2024 22:14:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B36F.mail.protection.outlook.com (10.167.243.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7719.0 via Frontend Transport; Mon, 17 Jun 2024 22:14:30 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 17 Jun
 2024 17:14:26 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 17 Jun
 2024 17:14:26 -0500
Received: from aaurabin-suse.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 17 Jun 2024 17:14:26 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <rodrigo.siqueira@amd.com>, <harry.wentland@amd.com>,
 <aurabindo.pillai@amd.com>
Subject: [PATCH 1/2] drm/amd: Add reg definitions for DCN401 DCC
Date: Mon, 17 Jun 2024 18:14:25 -0400
Message-ID: <20240617221426.3136257-1-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: aurabindo.pillai@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36F:EE_|PH7PR12MB9074:EE_
X-MS-Office365-Filtering-Correlation-Id: 141bc714-d1ef-4633-5761-08dc8f1adc2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230037|376011|36860700010|1800799021|82310400023; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VIaXKOmGGXK1a4SnhFJW7/2g3xHRDM4bPKHa+G5pwe+IFMg198NdBQbxblky?=
 =?us-ascii?Q?kQ1Yq4UfdTzAjHqfx3j/obzVg5j3bHimpkQp7XzVmfyoBpSGQ2azoNAGpWv2?=
 =?us-ascii?Q?p/0WlyzQDYYUlgRKXSDS0aKa0pJ2EUj9Jy7jjf6JVBzMn6CQxsMQOR6atRKf?=
 =?us-ascii?Q?A7cBOeLs95D7xdCdqY2VeyYdGsofuiJP3hbTu/1mQP5czEGeFWoBYuVOMQoa?=
 =?us-ascii?Q?7itnL0MLzbh/HisuB9SF8k7UKP4CLmYLJvPXAV2NbLTgFb1Z4Nav+NmBALOV?=
 =?us-ascii?Q?i9ZJ/bVJiyLJj84Yu9yZTIyVZLqdIqXxE0y+DYByacjxowe06eOOVV8f8PG6?=
 =?us-ascii?Q?V9MoOhkbT/QE0I1IB/jgQKvF7QX/PxjPYEEhca7F3PgnYyXyS4FlsAi4lFj/?=
 =?us-ascii?Q?QxLo5VihR+IbtOHlir9L5s0CFe0xq/9E7tQSFoWbKa7SpU/IqQNiZLAWGJxq?=
 =?us-ascii?Q?xPT3TUmj7OSAnBDzXOXeFgGT1ptL8Z0bosiltDwTctFbLhPw9XS3LMb/0c5x?=
 =?us-ascii?Q?wCF99S99RkofptDYFU3IA9JRU2T/FYEj3X12B+OtXilF7ywfvCGxIqjvt2Ak?=
 =?us-ascii?Q?zKwp745AiRCMhx18GpCoXvhPnV0on9ffhgeX/S9/5fJWZjz00f4SCpX33Qie?=
 =?us-ascii?Q?h87IGqVa07cFHSQKQdlyVkkXHF+78i3JqC0QQP7BkFFVZYDYbC8UIq6TgzRa?=
 =?us-ascii?Q?hSmPxOBT5yh1njwDadD0EZCITdnNyMeILXD8ZZqNFZNXGHqAiMlNq+T1Nvfy?=
 =?us-ascii?Q?LEhR/NcYZgE0m4EzACQbLoo7Pjt9YzrksfiYwTpR1N/lMGmP230JBobeoSV4?=
 =?us-ascii?Q?/U7sJJW8N8xPXWYD+VSQ5I7Yq4qzB5uPAoClME/ChWhY8Si9PZ3qUVw5yyVC?=
 =?us-ascii?Q?CJ2WtSXVmC4nkAden/jKg3e7NIf7ci5SjgQ8hR4OHd1n3ig+VV6qj+k60FgZ?=
 =?us-ascii?Q?j36eAMNOSWry97y9+EzrDYXZSrQMrAzQc2hqAMr8cJ9XGMb2JduJ5SjdSJ+t?=
 =?us-ascii?Q?KL/8qFkzHnfTjElwELZ6bn7mG4nvCkXjs06ZU28guHnalAAVf1xPPMbS+HEA?=
 =?us-ascii?Q?ks5kmd/Oo/Jy88edMhT26y7fv1tHePQs1+fxsVALma5AVoUXJW1QN2LzqmcT?=
 =?us-ascii?Q?jgCKaYXxpDnJkj+HD2p7No5a6iqo+KeN1KRGnQgxOgySxyBkW/8qJPA7bNpI?=
 =?us-ascii?Q?xiiSsi2aI+aLewAgp7qxdKkQ4nT2TBgol+bWxgQgAjjDH9zWeYhyJAmnyH+w?=
 =?us-ascii?Q?jNmpaBLY3UilfsM3zDNllReaG0eCw2GYaB8y8hiXZOk7qdikNe1gbO6PmzTA?=
 =?us-ascii?Q?sqMymJiEC++8ztrdqWGQLMplab2hzXLGZQz/GVkJnWyHNK4LsRopLutdkTef?=
 =?us-ascii?Q?0IhnlU4=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230037)(376011)(36860700010)(1800799021)(82310400023); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 22:14:30.4842 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 141bc714-d1ef-4633-5761-08dc8f1adc2f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B36F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9074
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

Add the necessary register definitions to enable DCC on DCN4x

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
2.45.2

