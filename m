Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CCFBD1489F
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Jan 2026 04:49:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DE5310E681;
	Thu,  8 Jan 2026 04:49:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tUWmJpp4";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010006.outbound.protection.outlook.com [52.101.61.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0741F10E681
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Jan 2026 04:49:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dLPXqoWpfNUISbpMohxRT0LWFVlOZes/rD5My2I/F2Nq+zVNbEE7dJW2A/IojfJhquUS3NejI1BMx0afXeQaWmdsQAA4ZlOFFfIYnpShLYnBxxpGdG5o4EA4t32SwFAbNaFY9EdWui3zAPhOY6PAms4/4EXCik1MqBRTNlo/CjCK81JGwnzDX0mgbkOeNkcayQdbVrCagB5v5g3HwJMLK/G8uQUwIIIrRjwJI+9d1OqctsurOJTUzjdUusA62DXUXn53SIObUdn311ndiTFod7t8D4k2xA3JFg4WnyA92zlTL3D9ffIJuG5jsiDfiRJSyoxdT8e007dsKxVPwuC0jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bgfUfHizFHelRv6Esyfk4uxDaSDMw3wqJKc/uzvlqN4=;
 b=CRJlELB/zXnLZvw98qOZbmBWLSFdccbvEZNNc6kiFOpOnPGIl+h0zPALsU7SUnHudGChaoCZ55uA8tEJVaJm1Jggdh+Mj5NskAItza4czleCicjJDVxFxgaGxubk772NM6Pk2FmHQ5/h81WEn8RxBv1tWoZHj82U2HRMhdLMW6dwJJgG6zZqmmwYYIU4wSztcor6DXzYx+A3bI/QceuaHeDdE+zqNEnC93D25IE0tlgGkp421j4zGLo4cKArMqPKx1ThWixt2AIOliAdKL0O2Gi1A4DCoUre5x+uIGi9S1XTBVse/X4xodqHWtUsc6kpacMR0oabPnpsnmkSdIPWQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bgfUfHizFHelRv6Esyfk4uxDaSDMw3wqJKc/uzvlqN4=;
 b=tUWmJpp4j3slLgw3S9YLzJa9bTDsrdjERM6uWdDu3LC+pEUui8ni7rZYRNtIK1fPbzJAPkluOGGY90WcoWuXuFgSIRcTZLSaPPwsLdxsMWMlI3sKdc/prKlKRtCVijUibxKJonOyZkAID20TT56qTSYJK9KPo1TnZQ9lFAt/wDY=
Received: from DM6PR06CA0093.namprd06.prod.outlook.com (2603:10b6:5:336::26)
 by DM4PR12MB7599.namprd12.prod.outlook.com (2603:10b6:8:109::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.3; Thu, 8 Jan
 2026 04:49:40 +0000
Received: from DS2PEPF0000343D.namprd02.prod.outlook.com
 (2603:10b6:5:336:cafe::b5) by DM6PR06CA0093.outlook.office365.com
 (2603:10b6:5:336::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.3 via Frontend Transport; Thu, 8
 Jan 2026 04:49:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF0000343D.mail.protection.outlook.com (10.167.18.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.1 via Frontend Transport; Thu, 8 Jan 2026 04:49:40 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 7 Jan
 2026 22:49:38 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <kevinyang.wang@amd.com>, Asad Kamal
 <asad.kamal@amd.com>
Subject: [PATCH v3 12/24] drm/amd/pm: Drop legacy message fields from SMUv12
Date: Thu, 8 Jan 2026 10:17:28 +0530
Message-ID: <20260108044839.4084279-13-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260108044839.4084279-1-lijo.lazar@amd.com>
References: <20260108044839.4084279-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343D:EE_|DM4PR12MB7599:EE_
X-MS-Office365-Filtering-Correlation-Id: 84f1518d-a65c-4a0d-e3a1-08de4e71558e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0KrdSJGdgANfEEJXaR9fktvO6REGMMeVK1FXe3vngTGiws6IAbcwOaP1hnz2?=
 =?us-ascii?Q?RV2O6TaOeY2255EQMP+DRopUcqr0ZrO097AQZyIanuuo4urVtprFEC1h4PSJ?=
 =?us-ascii?Q?ZXdjUAt0gsoTjI3WNJ2FqwKxnJ8Bq9mVjWaxRcVjZEPjfckJ17SvT6xtNuum?=
 =?us-ascii?Q?CtGOATmH0gjova+brLkxkszMyM/TjLhcxeYQDx9O2nY82otaiI4TA3tm9pzq?=
 =?us-ascii?Q?mxVb/7vH+o0QtzaMtQix59+oDHPJuUA72/pIB569c6ORmwPPfautT948xPKX?=
 =?us-ascii?Q?3p9/kjvk3ZHMajskWkzD5D7Ta3hRuk2o8Drh8KQduenOEdn7NEJT6LI+CoVY?=
 =?us-ascii?Q?KHGWZG8JHeyDgSX0cMHrhzcNd37MZYiDbJq5zDP1RglpLcAexvq/N8pDRte4?=
 =?us-ascii?Q?N9slnjwMyKWCzm7DCmof4H24VZLCugM3u/O6M/f0WzS+etQLo7G44Pk3cNUJ?=
 =?us-ascii?Q?jXL+S8O44K62Qgi9DC5H9Ipsg+Qw0GCgVvjx+vcNXPcbpRJMyxPXyOenNRcp?=
 =?us-ascii?Q?D9ZgNOTcez4f7ZYNraSnFxwDFVW8Sz9axFDS0jN3rjc5u6AKueflyPW8cHcu?=
 =?us-ascii?Q?eywcA8EpSrcmzgE7IQv9fd7DPtRsSfgBGVrsEbc26SULtR1bSOhriFm9wXGy?=
 =?us-ascii?Q?0VpehY88dN2AuxFkTJYTSRW+J39wvZ1CCUS8hmsPYLLqjRN3Pn8RoSpO4Mzq?=
 =?us-ascii?Q?JNsQ/JhSYW6Ucix03bz+Gt9a6UjVuHSizIRUvcJkVIO6mOVkI8WEcbBrK654?=
 =?us-ascii?Q?6XfY4+nAjXsvoBSiCW1THNiYFw2BgFGC+c4XCU1bSrMzKN782O73d/X45Gc1?=
 =?us-ascii?Q?egh7QC6e5gRxCZmGYSmvFPcJO2YU3g1q6m7P2ekPU3CYX0+KeeX0yAzY6Ac4?=
 =?us-ascii?Q?gq6T0OKhulYwjN8jfr0YRHFSAqVqpphAkZwMrtbRJjlnDdqdhzw2HOAtnslg?=
 =?us-ascii?Q?XQejZG1+y42BlEzezBMRbHdkLutpMIlDjgRYCvNl9vuf86tpfKZ07VNJnlqA?=
 =?us-ascii?Q?qvGgpTSRV943JjyEUCSdzXPSGsNrnq8uUZxAEjObIVO4FyYHNfeDLHjudmfx?=
 =?us-ascii?Q?MnUHpYMkiFGS1CDxI53PNtxixxFIyhzF3xIpXJYYGDfZeSzqJxI5yqmMgk1f?=
 =?us-ascii?Q?9JeTHCKxNl6f8K4nQiI0lLAb30BWViIC4uyk7ewwxYtJIpikM/ZSrlxsJURz?=
 =?us-ascii?Q?YhJ767xTCm81cOsnf1OOem+MeIEScblug7dg4KfWTaPYr8dXf6Gh/KApbcd+?=
 =?us-ascii?Q?x3gt05Zg4gLlXxgDQQxMTXwg8Aa7IRrE+KSrxD7g9mw+YLCfrvx5Ue6gqgQG?=
 =?us-ascii?Q?70j0eI5r90Co7YYcaCv7QMbKxqPDkt0/xa1V6N4rln1uRs9yPsZwLbLs5mN0?=
 =?us-ascii?Q?jLhUuslrXsarYQiaWqNZSPIgDm8XBxj6KFgFRakqRhyrYfNDvMZ3QN7QwKbz?=
 =?us-ascii?Q?5WLSDMi3CWD/O9HGCJh/kqiNx52er4wjPgsDzfKUh97GrkB7GksnW85udqCL?=
 =?us-ascii?Q?qGgMO6uQvhcwr/95C7X0ETLLeFUj/ovrLGmkI81MhbHmdh07wHZrgW4aN0cB?=
 =?us-ascii?Q?JkhVP+F2iWZVY2Wq8qA=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 04:49:40.6091 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84f1518d-a65c-4a0d-e3a1-08de4e71558e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7599
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
Reviewed-by: Asad Kamal <asad.kamal@amd.com>
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

