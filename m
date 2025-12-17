Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E573FD65C49
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Dec 2025 13:55:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B47410ECD4;
	Wed, 17 Dec 2025 13:55:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="stOCVaO6";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010060.outbound.protection.outlook.com [52.101.46.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9173E10ECD4
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Dec 2025 13:55:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dJ0gs0cHfhy5o8CwP/JBBWv+0mhgdiST0KlbnYcLTv1Ax40miCzZ5uSE07NabNjDvrl1ck5+5ik6zLXEX6JX19mHdCVveCQHtQ0oysidQ+/UfwWtFPapDyb547BR5Ed6z6UJmSYbAE3ZENO29MoNGxVX/aKLc/fHgvumTgS02tfTDs9xx05xSC4lmLT+72ZZaM+UYNTKVh81Az40N7kYCCe/C0PDHEXhvxa1e4DHhwBVJZIiGtLsUjqNiW5wXny1nHzip4c7JDwiUL2jqsgyJpXfdfOxwI3Bg1IH72qxtL7OoHPOlmsNMWjyF0Lhkg+++QHwj4pE2RHCsAG8XKGwFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ml8p9hWiw1IzCQcV75LYXfBF1DRbQrs+LZijOa2Sfc=;
 b=ZK0XSkksh5qCYk2nJnSV7z53Bz+gq5A3BNEDd3j6Ym4m7o4QmbxM9QhITaWjat++Xv4Wus0O+vEk8769sh4W+rzLHC8kjFuz6K6gTqvqRGAj1B9vrzPAGjKE4lXGY9g1y6+v37Cn6OuAA8YuuE+rSsIuzNTG9UkgvY7X0QNFrtYdSEvdKQnK9Fu6OrMlWTPUH5ychcFkvRiSEzNTzgEY87u4lGFrNFeo2TEGFDfbbH2SGIZ+VDTY8XNE7cw2izNFnDKIyIx/sOS1RTShqfRWWBwn4fASEPnD3tOQOTRTJ/JxX8pfLBU2w4+vM3jxfulipbfv9D5owyG5BxM3+FZv6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ml8p9hWiw1IzCQcV75LYXfBF1DRbQrs+LZijOa2Sfc=;
 b=stOCVaO6pHxUgM6ogM+kyhDHm0i+k4BQXoSWHE+J7PbOFSabhKIg8I6rxbKrC/EOqaXJWCZt+DghwzENwSL80J0Z+tSzqvsa1VQVFOPL7UucA49DErAaE3DIt3Wbm5MABEavWHqPw8dkfDQe15dnm5zZwpVZP7U/JB+fNKpskhQ=
Received: from CH5P222CA0010.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::28)
 by PH7PR12MB8180.namprd12.prod.outlook.com (2603:10b6:510:2b6::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 13:55:13 +0000
Received: from CH2PEPF00000141.namprd02.prod.outlook.com
 (2603:10b6:610:1ee:cafe::fd) by CH5P222CA0010.outlook.office365.com
 (2603:10b6:610:1ee::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.7 via Frontend Transport; Wed,
 17 Dec 2025 13:55:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF00000141.mail.protection.outlook.com (10.167.244.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Wed, 17 Dec 2025 13:55:13 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 17 Dec
 2025 07:55:11 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <kevinyang.wang@amd.com>
Subject: [PATCH 11/21] drm/amd/pm: Drop legacy message fields from SMUv12
Date: Wed, 17 Dec 2025 19:18:04 +0530
Message-ID: <20251217135431.2943441-12-lijo.lazar@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000141:EE_|PH7PR12MB8180:EE_
X-MS-Office365-Filtering-Correlation-Id: 60b73e0a-b529-4f93-6419-08de3d73e6cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?trZh0DCHw2MeiY0pUHbb6TESD1IDC3UQXkuXtdDRcvgjyh+x0lmEnBvVAC4b?=
 =?us-ascii?Q?Wc4RLKzpvV0ZD9QiNvCwefIARBGQjqWIB+qWqmDZUlH+ok0lhjpbSOXpE7se?=
 =?us-ascii?Q?IivF0LVeBdPx4GxK8ifAymMSOmTt7JaFcPC5ASRfV1sojW4jL/u7Fb2hTmcs?=
 =?us-ascii?Q?hUH20Skhe9j1IWVnmpGrRaJ7d+f2RmnXixzBIsGTKTP33afOiX8wdWEiHHpK?=
 =?us-ascii?Q?NcSkmAkpcOf20jg+7235+y+16xPcu4LT41wNMSmVW7dOS5G72MdxTa61hnOl?=
 =?us-ascii?Q?IaLfnvV9BacNe3pN90uC1pXPvMytIG5FMbpSFYITlr/Rel/Estv9ylF/3hxd?=
 =?us-ascii?Q?M2Bi4iarW3vgXZGM+eBJ7RvnNatXjWvjQczZZVJpLlnaWRY+YpPGUlB6sx8+?=
 =?us-ascii?Q?gv4eBNNBK10c7JWr+Q/q+fsFm+B/A/7GOb0lUKlS+fEpkFtwDNYTeKIl+py9?=
 =?us-ascii?Q?yBfqr2KT4DbLvhNZmPLk1OuFSRaO+5hW4O9QiOIcsuL/Kcwaz+DwGrOiy1DV?=
 =?us-ascii?Q?6fhqgZPFzbhEJ36PXd8bhRiUoBZyjTPwjNWvm6Z1MLjwMXBDBfKlivph4BKk?=
 =?us-ascii?Q?yNm9DdHWBQ/Gn686pIdB+uRd4DWezufZnfV1+MeUrY61Ztm6yd17f41+oK1P?=
 =?us-ascii?Q?Ewi1bKp68Fj97f5jiqPwGTuyWimXGYNROKtrR1Lf7O5FyO+1lzBrGJx0W/Rt?=
 =?us-ascii?Q?sRHhIHLdHCLGRU3jaRa4r3pcsJpavLLQnSpA6VXzM5nPpK/YoOMwhR5WFdyx?=
 =?us-ascii?Q?WHiiDkOPS3Ubvx1SqrFg2XyH3rXFjhKv8vJN/sEtdvxqemkCLjXHgmmeavDC?=
 =?us-ascii?Q?YaRpyuW8t6/ptsBODSGKnTRoXXz02u2LM7fcmjHMHVjIWSs/QbPtUbVkopy3?=
 =?us-ascii?Q?9ABsX3MG3JYoiBgdOSJmzpo72i6DWuDInIU0Qnp9ySWKbQ9pNm7SoNG70vD+?=
 =?us-ascii?Q?//Ab1QZ5SrzypDyuWeOXKwhJw+zqCs7n9E9kVVHQnYu3Hdvnvfi4Y/qT+wfb?=
 =?us-ascii?Q?SiyvQh656V2jmyvp1mNIl8UdgygdUDAO11Sa6DEHtn6jKfsqq+vFK/4fDAel?=
 =?us-ascii?Q?NsplVgbamTB2LMsSCetjy7kMMyM/UB7OM8OqoTth3BHEdvKapafXwOPQhyaH?=
 =?us-ascii?Q?M9WPmDjQ9XkjiHwtygkIaR7GeOB8byajsw036Mg6oUmdgtRjrKF0MPF0DCqx?=
 =?us-ascii?Q?u6gfhVFHaTQEAnxIRd6+btlAyb/mUBAMwqmHfUTKHhQTmvuqVKmSdTxIvKLA?=
 =?us-ascii?Q?BFIEmaPrapGleNaJMcjeR2WUnK/ooH/E8Oxa2cMf1sGYGSx4i1mVps3B0Rdk?=
 =?us-ascii?Q?fkXwJFXxOt4dtyw3KoPM2ZAQHhtxA2JoC5iDTdKZ6NDiUVLZe3gFwPgUxVci?=
 =?us-ascii?Q?UAPk1RGTtoi5P3/PrbLsDfIU6UHPzxR5KYhx2f5mRitLGtoVuWb+01bx1Esq?=
 =?us-ascii?Q?vl9U48XIpWRqlpiPz+hfZqWmXLbNmHM3Yboxk3qMeGqWdkHMgv1loWFllfm5?=
 =?us-ascii?Q?bjn/GZpHtqW/oGTJAT7+KC9zBdsvhPgskrX7YpAS2PfkUY8d9pwF7VktJQg8?=
 =?us-ascii?Q?tfqaM3rhPfEKe/pbO0A=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 13:55:13.5565 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60b73e0a-b529-4f93-6419-08de3d73e6cc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000141.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8180
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

Remove usage of legacy message related fields from SMUv12 SOCs.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
index 7e41991f140e..a81360abc2f0 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
@@ -41,15 +41,6 @@
 #undef pr_info
 #undef pr_debug
 
-#define mmMP1_SMN_C2PMSG_66                                                                            0x0282
-#define mmMP1_SMN_C2PMSG_66_BASE_IDX                                                                   0
-
-#define mmMP1_SMN_C2PMSG_82                                                                            0x0292
-#define mmMP1_SMN_C2PMSG_82_BASE_IDX                                                                   0
-
-#define mmMP1_SMN_C2PMSG_90                                                                            0x029a
-#define mmMP1_SMN_C2PMSG_90_BASE_IDX                                                                   0
-
 static struct cmn2asic_msg_mapping renoir_message_map[SMU_MSG_MAX_COUNT] = {
 	MSG_MAP(TestMessage,                    PPSMC_MSG_TestMessage,                  1),
 	MSG_MAP(GetSmuVersion,                  PPSMC_MSG_GetSmuVersion,                1),
@@ -1495,17 +1486,11 @@ static const struct pptable_funcs renoir_ppt_funcs = {
 
 void renoir_set_ppt_funcs(struct smu_context *smu)
 {
-	struct amdgpu_device *adev = smu->adev;
-
 	smu->ppt_funcs = &renoir_ppt_funcs;
-	smu->message_map = renoir_message_map;
 	smu->clock_map = renoir_clk_map;
 	smu->table_map = renoir_table_map;
 	smu->workload_map = renoir_workload_map;
 	smu->smc_driver_if_version = SMU12_DRIVER_IF_VERSION;
 	smu->is_apu = true;
-	smu->param_reg = SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_82);
-	smu->msg_reg = SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_66);
-	smu->resp_reg = SOC15_REG_OFFSET(MP1, 0, mmMP1_SMN_C2PMSG_90);
 	smu_v12_0_init_msg_ctl(smu, renoir_message_map);
 }
-- 
2.49.0

