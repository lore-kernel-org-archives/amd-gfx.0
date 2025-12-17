Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F118FD65C4F
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Dec 2025 13:55:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 90D8B10ECD0;
	Wed, 17 Dec 2025 13:55:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="K7R4r49f";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010068.outbound.protection.outlook.com [52.101.46.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F2AA10ECD0
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Dec 2025 13:55:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UpDPzZD5a+xqgJh027gU8jPUljaPhe2SNGYpZnsW3UoDuJNLLoqTH+mte1jaUQ3qF6QaICtXMn+bBByLeLSuZgYXP1+CYMQom7nbmClqu8pw9pPf5fNYzyCagYTLsRQD3pHit0gs6TfaavkLBVVH+VnIdciFMi8XcRVzdvgmd5YpN3201EHjseQim/8gWYk48VTzSAIboshSsj3w0nuKBQAz79vK/47qPjlNeHlhZWwv8e4okPIpfm9IZ19W6XkQHCOd7ZR+ZfLVMDyQKN3HSfIaTX1LKhK9xFH5oA7G7ZRIhrYIllIcuz+qp1kRGe8CV+syy4cCtz1mz5FOR2Gzmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V8+h/NHVhR/6gyJKtrA4+D+CRnPAjiYOkTlBP/EkrCM=;
 b=sdpOZDKr9S7yiLdDNsmAgfmrCDXbyXgPPv2nZdTRbsg1aTeg8PVMFjVvn9myka4QmcDZxH1k8Li49VPa3mljyVW1iduNO6i3W6v2M2GNIzcZRd6k1ECNP8c+x3brF/FGva948tyGxX6Pe+CU3UpibcUY/8sjRYUJCMsPkeV16FOJbG8t2eoX/rZAj+ha8Yu/CwohV+Yc8xCLl9100BQegUs4TzHuNoH31vlyebv97mCH+RTmq5Ds4p8r+5aQVx9RcofPeiAhw3am5wy0y1LlWZrCuoiO9iZHeluFjYGfMEdmBLhbJwox63JgfoiQjcBe5WZTKcSK2O26sNsdjZVJcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V8+h/NHVhR/6gyJKtrA4+D+CRnPAjiYOkTlBP/EkrCM=;
 b=K7R4r49fIHId4PmjrAsYMIrx7Tz3zinT3DajFBSSFRViIcAyY8uL4t6dS3ooikNYwq/JLWZEi/bTR20d04fUC1JSSUJfzcfsc2G531fRPg+SWnVPYQhSyZS7fiP0j7Qqo+6jZCuvU6t8Xwq6oZmaUDbsIi+2di3l/TVxARXI7Fg=
Received: from CH5P222CA0011.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::26)
 by DM6PR12MB4105.namprd12.prod.outlook.com (2603:10b6:5:217::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 13:55:11 +0000
Received: from CH2PEPF00000141.namprd02.prod.outlook.com
 (2603:10b6:610:1ee:cafe::d7) by CH5P222CA0011.outlook.office365.com
 (2603:10b6:610:1ee::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.7 via Frontend Transport; Wed,
 17 Dec 2025 13:55:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF00000141.mail.protection.outlook.com (10.167.244.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Wed, 17 Dec 2025 13:55:11 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 17 Dec
 2025 07:55:09 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <kevinyang.wang@amd.com>
Subject: [PATCH 10/21] drm/amd/pm: Drop legacy message fields from SMUv11
Date: Wed, 17 Dec 2025 19:18:03 +0530
Message-ID: <20251217135431.2943441-11-lijo.lazar@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000141:EE_|DM6PR12MB4105:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c624403-cb4f-485b-4cf7-08de3d73e5a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gLZS/gmCAowwoK8ctcKAMzj0qrTSxdH3hMD2WgNfSnR0ijJn8mDGI9cj+aHm?=
 =?us-ascii?Q?ixqmz4Y09Gd2VOvXbRJY1bstsLDPe5dr7//xOa5t0asB+halPcL8SmSWUTiK?=
 =?us-ascii?Q?yDhr/wIwXVlprcQy5ob8dx7O9vFXgYjccQx+37MZZPQVM7LPET8Y1SedUNUJ?=
 =?us-ascii?Q?3eduqU8pRAkb4FfwPvUkcscrgKttMFlkJAogtwBvKiC0iLW6tIdUEAg8Y1Q+?=
 =?us-ascii?Q?6In4URGbl/JqeUXj0nbX2z25ntiQMeWbFwqtkeyhOVfhdpE2P8DRvG5mMw+z?=
 =?us-ascii?Q?wgiW2wZuNZs1PFY1SUQ+8qPgakkQmo2eYpFgUjGCedfWHopPPmdRLHSpmUHK?=
 =?us-ascii?Q?fnm74ix58t0rA5qcPk8+z/1GNjW5zG4IRccPsEXlQCYupuPFLtDMM0N42AFF?=
 =?us-ascii?Q?bz0WJTxZ6eO1/AlKPau8CqYwqwy8npbXGHZHlylWG8DmQcIgy0sj9Cjg9kAu?=
 =?us-ascii?Q?6Uga8qThSy5sVGVxonVRni2OZsLpFQL3IKptiYH1MpUbBOnB9EE6JdppFHX5?=
 =?us-ascii?Q?CTjV5WpCKqsJWQIjhiXiJOKd68yFKHxkl4ZDeXYin7iG+6252aRxvKQk9BCJ?=
 =?us-ascii?Q?q1+Z8LZqlPGyGI1f7U+r5apSCrYE3L5hMaFH/7V++hpX93464rERvA9pwfWM?=
 =?us-ascii?Q?glQL08um+x+QNGegs6di/LVBp5LfYXQr/ErFIqh/mU/A5ifX6jPaFceQmsfe?=
 =?us-ascii?Q?OH8z0kMFNoIoJoi/kvJMrxm3B9PT6OewTpxc73nFFXmNKb9sLP6GQySIzFJ8?=
 =?us-ascii?Q?JIHQSl9fdwsnOUit9NWkpGY6dc8pHzy2wj1y/z/nMP9gwIPZmXRcjrSpuUOA?=
 =?us-ascii?Q?8+AH/0qFIH7ZxelaNoEdqPM5gyD5J7a+jnfb2fCCHjHvU6ZSWHCx4hUUK7Bf?=
 =?us-ascii?Q?0AjRJGKnDk1Oywe5dZ5Ga/AnPhZLM+D6Vz/iqAmIAOLHzsZGkJrqLuAqV9Pm?=
 =?us-ascii?Q?ivjSzqIF780MfmhUM5+uDOk5ED/DDbdUyKzQvHpjJLJTj+mBdKuiad1sq0KU?=
 =?us-ascii?Q?CMbLvQKTGLiZXjciv17DkIkeexZ6wan+8Fu8iMBNEa39mfKFbbsfUVDoOqu4?=
 =?us-ascii?Q?5+bDgSwPThYAQJwMdRLndph6wCGn182t34e3xP2RdLIb8s+pC78+CsPnlr1G?=
 =?us-ascii?Q?/TMyw686Yk9u7psPr6eEdRDtReiWfzJ3kHiyZVSkmqLQrj2PmARbQ3s3/dFU?=
 =?us-ascii?Q?yZY9JpnEFHQxqD0N9H4mymU4BMeBZF5SM5/ALdI8SDHkkACCGcm1jOZLU4xt?=
 =?us-ascii?Q?eI0flHvGtEOl4QBOInfvX1XQ/XL3V02bqIf+kUjV+EQScY/dv5F6nmVkdHdH?=
 =?us-ascii?Q?Ll610oUhz0HOpmX5uPY2JFCFJmYRNhlQ9/4mrH79FZ9vGkmxDokRZEbr2rtC?=
 =?us-ascii?Q?lzrYmRSJxJZzIX4EVNxSKFzrmjAaKosMOeElDN1Xaq7N7vZ8CiWvFWnUEcGV?=
 =?us-ascii?Q?dc1yINoeLdn/Q7Lc8APZZTVPMJzIQCZTz+Yc7+ZXTB8dOBYwvbEveKNm+0ev?=
 =?us-ascii?Q?GoPw+DW7p4MMB1IhQAJj9YCA3Y6+KASlejrj9WUifTz6B0JGNHh5PbJj1gav?=
 =?us-ascii?Q?IQotHzKDXs1PpJOOKRU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 13:55:11.6024 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c624403-cb4f-485b-4cf7-08de3d73e5a2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000141.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4105
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

Remove usage of legacy message related fields from SMUv11 SOCs.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h            | 1 -
 drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c       | 2 --
 drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c | 2 --
 drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c         | 2 --
 drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c | 2 --
 drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c          | 9 ---------
 drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c        | 2 --
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c                  | 4 ++--
 8 files changed, 2 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h
index 97c19005952c..7c1701ed3e11 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h
@@ -282,7 +282,6 @@ int smu_v11_0_handle_passthrough_sbr(struct smu_context *smu, bool enable);
 
 int smu_v11_0_restore_user_od_settings(struct smu_context *smu);
 
-void smu_v11_0_set_smu_mailbox_registers(struct smu_context *smu);
 void smu_v11_0_init_msg_ctl(struct smu_context *smu,
 			    const struct cmn2asic_msg_mapping *message_map);
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index eadd81e413aa..4de7ae6f7c8e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -1959,12 +1959,10 @@ static const struct pptable_funcs arcturus_ppt_funcs = {
 void arcturus_set_ppt_funcs(struct smu_context *smu)
 {
 	smu->ppt_funcs = &arcturus_ppt_funcs;
-	smu->message_map = arcturus_message_map;
 	smu->clock_map = arcturus_clk_map;
 	smu->feature_map = arcturus_feature_mask_map;
 	smu->table_map = arcturus_table_map;
 	smu->pwr_src_map = arcturus_pwr_src_map;
 	smu->workload_map = arcturus_workload_map;
-	smu_v11_0_set_smu_mailbox_registers(smu);
 	smu_v11_0_init_msg_ctl(smu, arcturus_message_map);
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
index 5ae6ee87de04..15968b057469 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/cyan_skillfish_ppt.c
@@ -601,9 +601,7 @@ static const struct pptable_funcs cyan_skillfish_ppt_funcs = {
 void cyan_skillfish_set_ppt_funcs(struct smu_context *smu)
 {
 	smu->ppt_funcs = &cyan_skillfish_ppt_funcs;
-	smu->message_map = cyan_skillfish_message_map;
 	smu->table_map = cyan_skillfish_table_map;
 	smu->is_apu = true;
-	smu_v11_0_set_smu_mailbox_registers(smu);
 	smu_v11_0_init_msg_ctl(smu, cyan_skillfish_message_map);
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index fe43aada7b8a..8829fcd52fbf 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -3372,12 +3372,10 @@ static const struct pptable_funcs navi10_ppt_funcs = {
 void navi10_set_ppt_funcs(struct smu_context *smu)
 {
 	smu->ppt_funcs = &navi10_ppt_funcs;
-	smu->message_map = navi10_message_map;
 	smu->clock_map = navi10_clk_map;
 	smu->feature_map = navi10_feature_mask_map;
 	smu->table_map = navi10_table_map;
 	smu->pwr_src_map = navi10_pwr_src_map;
 	smu->workload_map = navi10_workload_map;
-	smu_v11_0_set_smu_mailbox_registers(smu);
 	smu_v11_0_init_msg_ctl(smu, navi10_message_map);
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 087b4b6ce857..90aba9adc24f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -3182,12 +3182,10 @@ static const struct pptable_funcs sienna_cichlid_ppt_funcs = {
 void sienna_cichlid_set_ppt_funcs(struct smu_context *smu)
 {
 	smu->ppt_funcs = &sienna_cichlid_ppt_funcs;
-	smu->message_map = sienna_cichlid_message_map;
 	smu->clock_map = sienna_cichlid_clk_map;
 	smu->feature_map = sienna_cichlid_feature_mask_map;
 	smu->table_map = sienna_cichlid_table_map;
 	smu->pwr_src_map = sienna_cichlid_pwr_src_map;
 	smu->workload_map = sienna_cichlid_workload_map;
-	smu_v11_0_set_smu_mailbox_registers(smu);
 	smu_v11_0_init_msg_ctl(smu, sienna_cichlid_message_map);
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
index 579b1dbd36ac..eb1b9faf8e5c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
@@ -2168,15 +2168,6 @@ int smu_v11_0_restore_user_od_settings(struct smu_context *smu)
 	return ret;
 }
 
-void smu_v11_0_set_smu_mailbox_registers(struct smu_context *smu)
-{
-	struct amdgpu_device *adev = smu->adev;
-
-	smu->param_reg = SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_82);
-	smu->msg_reg = SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_66);
-	smu->resp_reg = SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_90);
-}
-
 void smu_v11_0_init_msg_ctl(struct smu_context *smu,
 			    const struct cmn2asic_msg_mapping *message_map)
 {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index fe1924289040..4ca211ea628f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -2557,11 +2557,9 @@ static const struct pptable_funcs vangogh_ppt_funcs = {
 void vangogh_set_ppt_funcs(struct smu_context *smu)
 {
 	smu->ppt_funcs = &vangogh_ppt_funcs;
-	smu->message_map = vangogh_message_map;
 	smu->feature_map = vangogh_feature_mask_map;
 	smu->table_map = vangogh_table_map;
 	smu->workload_map = vangogh_workload_map;
 	smu->is_apu = true;
-	smu_v11_0_set_smu_mailbox_registers(smu);
 	smu_v11_0_init_msg_ctl(smu, vangogh_message_map);
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index 355e5cf6bdb8..65115ef19fa1 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -540,10 +540,10 @@ int smu_cmn_to_asic_specific_index(struct smu_context *smu,
 	switch (type) {
 	case CMN2ASIC_MAPPING_MSG:
 		if (index >= SMU_MSG_MAX_COUNT ||
-		    !smu->message_map)
+		    !smu->msg_ctl.message_map)
 			return -EINVAL;
 
-		msg_mapping = smu->message_map[index];
+		msg_mapping = smu->msg_ctl.message_map[index];
 		if (!msg_mapping.valid_mapping)
 			return -EINVAL;
 
-- 
2.49.0

