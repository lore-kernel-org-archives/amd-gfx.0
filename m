Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DE5BD65C4F
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Dec 2025 13:55:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF43410ECE0;
	Wed, 17 Dec 2025 13:55:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KlOXzR7W";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010051.outbound.protection.outlook.com
 [52.101.193.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FA4610ECDF
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Dec 2025 13:55:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oY/rn/fS5//ensiLtaVgshwHgCJUjcxDZYpG7ex6mobEdTGrz3n9qfrh5CTIs4zWyGFc5iQE8F9ftLTNv9TlMkLW9TDpa5pIrR2soWLLhGUDcW1qYk6xFmVnV3xVfiCoc/MuhYq0IX4C5t7kWlU0uen/oeLEPm7WNylS7V4DlubSFfLTonK/NUpqLE0kon+r3KuD3FyKMP5h0sHMqZXbmsyg0vj82EsDLPQSMwuMOArAdljf8LEUNmk+Wgb3cIknirG55giqlPwmv6UJGh4ivI2gCIKyhjePH/PdbYmR9ldNB0rnZmXIb5srnEuAXp5Yz85hDquHAoyTlocC31z03w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZF++AMp8op5ztiECXzQchrA2W6MW4sVPMNyW6YcrDjQ=;
 b=aY/DXZjWRzGliAyWGdyCqbFBfOsuFtfTUxP8KEjQv8QdBGySQ0Sy0eO8LqR3Gh+Xzrh8mBrpE21wofPS/F9Mjra2OMaHem2f7/Sxu04lu12IpcA0A9s8W2/xRBE8S55ZlfXl7c/r02DQ7WV3xdgUpiHdVQ3dn/XA9NCDlldpZYTLf9Rf9ufBwVsnwKYuo4ip29exn1aYersKF8ZGey52YdSIlyNRxFBhDUfknwZKy8XCWyxCsKwV+He/s7qbKTO1MA6D/gN8QgLFGXT7WCcJsl71cVxWlVSvOuS9R87kZg57ntfaBzxZEHmHtmj2Q0WpiNbssbUxuY6mGgFA2LE3/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZF++AMp8op5ztiECXzQchrA2W6MW4sVPMNyW6YcrDjQ=;
 b=KlOXzR7WQMHVBSIINZXmWkwXXZMn696+7T4k0xPBR3lrEo+VIJ10sL4vCqaWOyNW3/4PpQrThzcQnJyekLugIj5wWY229MUlvifZg2CTcfjPrz71yTMxygSI1DHZbJz6ipEouz2GiTwX5chAnd/MKSrejjpIUZudSpik6sGUvOY=
Received: from PH7PR17CA0011.namprd17.prod.outlook.com (2603:10b6:510:324::20)
 by SN7PR12MB7022.namprd12.prod.outlook.com (2603:10b6:806:261::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 13:55:25 +0000
Received: from CY4PEPF0000EDD1.namprd03.prod.outlook.com
 (2603:10b6:510:324:cafe::ba) by PH7PR17CA0011.outlook.office365.com
 (2603:10b6:510:324::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.7 via Frontend Transport; Wed,
 17 Dec 2025 13:55:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EDD1.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Wed, 17 Dec 2025 13:55:25 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 17 Dec
 2025 07:55:23 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <kevinyang.wang@amd.com>
Subject: [PATCH 17/21] drm/amd/pm: Drop unused ppt callback from SMUv13
Date: Wed, 17 Dec 2025 19:18:10 +0530
Message-ID: <20251217135431.2943441-18-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251217135431.2943441-1-lijo.lazar@amd.com>
References: <20251217135431.2943441-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD1:EE_|SN7PR12MB7022:EE_
X-MS-Office365-Filtering-Correlation-Id: 96b8f0fc-b7ec-4554-f46b-08de3d73edd8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?eN5e6AGgBGa068z4sofebbC2HyAuYSz64AwpQ/aOySajR6P9g/QvjBIBCviF?=
 =?us-ascii?Q?FfKkUKG3wn8H5NouloCH1V5mgrfBUzsldOyizDeQSXUPzzU34MrkU7JMm5yj?=
 =?us-ascii?Q?YVgzB3PUKDXLmxtc7rHLU1ya+Vl/MPA9j/Q/9LmVtVhLbsLqn5mTyTOR42PU?=
 =?us-ascii?Q?SBuel0ai1kN2jh9ZvFSOgZrtg90QeFhPUdxCbcCksckb31TPuFduEp+LCv1e?=
 =?us-ascii?Q?B8Hs8mwiuTetuByx/YxQX2uIQK0W96zdsEOMuDwJP3jalfxq83MNfcZrnLtC?=
 =?us-ascii?Q?dxUVCDN9wEXLrTY74VnOi83Xw4wIW3W4Zfr49LYBaFcYASCyxx762cenevjM?=
 =?us-ascii?Q?KwfgWZO/pOnRIJVI2aBSasiQOhujPyetqpnJa6Qnov47/IpZVi6qukfCBFht?=
 =?us-ascii?Q?mrNsge/GSSivEOo/MbWLQn9AjUScvHBOQvFZmTyFQV/Idg+LmV3qpvAsBG6f?=
 =?us-ascii?Q?UYCbxSfT3bRs8I/j8EJjyDYewxz7jrfWbR2xxJnWOCWl2FhoAzPArrHJtYNx?=
 =?us-ascii?Q?JL06/bDLIrzsLvgnRycNN3yLX/SPqNdfkS1MLO2qEcl0YdupZ+GWKDy2f/5i?=
 =?us-ascii?Q?FnecOSU2GHIuS4XVfgd69VRz3DcNa5JDMTbFeenaadKFMFK737Zc2LfNKkce?=
 =?us-ascii?Q?iwCAb8/c6oxwgQYOOq0LcoGqBSIf8gHp4VDABo5s3ftJIkL/SUM+HoXOvr4+?=
 =?us-ascii?Q?ooGxFIfeITNULtT+kSvUJFITli2is3aBwp3UipXn+Vi50NTAwqNMvU0BDGko?=
 =?us-ascii?Q?urhWvwnfVvNwj3PZlkPj4oVjey+CK/cVLAE3JeoCj0cegGZ+ZgvFykU+BO+g?=
 =?us-ascii?Q?mGdPk/D1sxGzhfcBzxNmGQvVOy4fp6DjqaC4ZMl++KWJ5JOAG6O440TVnyk/?=
 =?us-ascii?Q?9biFgAakPhD01Lg85UI4E4QMDB/j/Z5AJkiZKDSVYdKjt9+oX7InAuc+81ww?=
 =?us-ascii?Q?Ks4LlqNoqlm/3trC//UyLr/5QFWYjWvy154V2cCBY8aqP2Ibw78idCnSeYaU?=
 =?us-ascii?Q?N/9HW0oTg78oFdp631JO4KQjU91fnR+Q+vsbkV1spNmqvSEyejgnjWfT6Tis?=
 =?us-ascii?Q?IHhk3P9KW5H4Ih3C94K5IJYCbMI/hCbbeGAdxA0Kp/WtsQvqHP0GiIRCZqmV?=
 =?us-ascii?Q?7PTzWXrWBpUqqdr4ytgVDF1W47hMdZR42/CQh3z3usu88DBWxOO5NnVqYOT7?=
 =?us-ascii?Q?FAAJZFl8QLDW8KMhw+ymlTn//XLPWS6VCHkvmNpAXGdM94gSVGXW6t1bLDAl?=
 =?us-ascii?Q?G8L3hyAXWb+cZ7ERVZMdkG1K3NXfG63DB7TcYpUBi9Ftd92XkhEGO5MDFTYT?=
 =?us-ascii?Q?E5dh4JELOTkvk/TEkc2kfdIbtdLGAERcsFNGT0TDJpkbCesTqbECLg4FBL8f?=
 =?us-ascii?Q?wIhTWsp/ZzOaYhlUPGPFN2qfjhJnqLiM0GIobROobdkMj6D6uhMYOn8r4RNG?=
 =?us-ascii?Q?ik7wDHPwQVTuK2eIOgKn0PsPmv2P5q+R7iRq9OkiXMk5EOM/Kqkv006MG8Zo?=
 =?us-ascii?Q?8M868NUqOMB36pTiORiosn14sBdaw4uB6OafGoGV0XI4s5qUT2tzTzeHFW6u?=
 =?us-ascii?Q?kwMAUBdFnWYsSexJr0M=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 13:55:25.3262 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96b8f0fc-b7ec-4554-f46b-08de3d73edd8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7022
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

SMU message related ppt callbacks are not used. Drop from SMUv13.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c   | 2 --
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c | 2 --
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c | 2 --
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 2 --
 drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c | 2 --
 5 files changed, 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
index 94b8e5dd76b5..9de0b676bb7b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/aldebaran_ppt.c
@@ -1996,8 +1996,6 @@ static const struct pptable_funcs aldebaran_ppt_funcs = {
 	.set_tool_table_location = smu_v13_0_set_tool_table_location,
 	.notify_memory_pool_location = smu_v13_0_notify_memory_pool_location,
 	.system_features_control = aldebaran_system_features_control,
-	.send_smc_msg_with_param = smu_cmn_send_smc_msg_with_param,
-	.send_smc_msg = smu_cmn_send_smc_msg,
 	.get_enabled_mask = smu_cmn_get_enabled_mask,
 	.feature_is_enabled = smu_cmn_feature_is_enabled,
 	.disable_all_features_with_exception = smu_cmn_disable_all_features_with_exception,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
index 7ca9adfa2446..41c61362f7fc 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
@@ -1101,8 +1101,6 @@ static const struct pptable_funcs smu_v13_0_4_ppt_funcs = {
 	.fini_smc_tables = smu_v13_0_4_fini_smc_tables,
 	.get_vbios_bootup_values = smu_v13_0_get_vbios_bootup_values,
 	.system_features_control = smu_v13_0_4_system_features_control,
-	.send_smc_msg_with_param = smu_cmn_send_smc_msg_with_param,
-	.send_smc_msg = smu_cmn_send_smc_msg,
 	.dpm_set_vcn_enable = smu_v13_0_set_vcn_enable,
 	.dpm_set_jpeg_enable = smu_v13_0_set_jpeg_enable,
 	.set_default_dpm_table = smu_v13_0_set_default_dpm_tables,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
index 29ec02f2dd6a..e4be727789c0 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
@@ -1104,8 +1104,6 @@ static const struct pptable_funcs smu_v13_0_5_ppt_funcs = {
 	.fini_smc_tables = smu_v13_0_5_fini_smc_tables,
 	.get_vbios_bootup_values = smu_v13_0_get_vbios_bootup_values,
 	.system_features_control = smu_v13_0_5_system_features_control,
-	.send_smc_msg_with_param = smu_cmn_send_smc_msg_with_param,
-	.send_smc_msg = smu_cmn_send_smc_msg,
 	.dpm_set_vcn_enable = smu_v13_0_5_dpm_set_vcn_enable,
 	.dpm_set_jpeg_enable = smu_v13_0_5_dpm_set_jpeg_enable,
 	.set_default_dpm_table = smu_v13_0_5_set_default_dpm_tables,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index d76ac14a8a64..1e82c43c851a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -3860,8 +3860,6 @@ static const struct pptable_funcs smu_v13_0_6_ppt_funcs = {
 	.set_tool_table_location = smu_v13_0_set_tool_table_location,
 	.notify_memory_pool_location = smu_v13_0_notify_memory_pool_location,
 	.system_features_control = smu_v13_0_6_system_features_control,
-	.send_smc_msg_with_param = smu_cmn_send_smc_msg_with_param,
-	.send_smc_msg = smu_cmn_send_smc_msg,
 	.get_enabled_mask = smu_v13_0_6_get_enabled_mask,
 	.feature_is_enabled = smu_cmn_feature_is_enabled,
 	.set_power_limit = smu_v13_0_6_set_power_limit,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
index b4b55a66fb71..7f70f79c3b2f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
@@ -1333,8 +1333,6 @@ static const struct pptable_funcs yellow_carp_ppt_funcs = {
 	.fini_smc_tables = yellow_carp_fini_smc_tables,
 	.get_vbios_bootup_values = smu_v13_0_get_vbios_bootup_values,
 	.system_features_control = yellow_carp_system_features_control,
-	.send_smc_msg_with_param = smu_cmn_send_smc_msg_with_param,
-	.send_smc_msg = smu_cmn_send_smc_msg,
 	.dpm_set_vcn_enable = yellow_carp_dpm_set_vcn_enable,
 	.dpm_set_jpeg_enable = yellow_carp_dpm_set_jpeg_enable,
 	.set_default_dpm_table = yellow_carp_set_default_dpm_tables,
-- 
2.49.0

