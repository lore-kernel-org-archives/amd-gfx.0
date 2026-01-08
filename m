Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB83CD1489F
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Jan 2026 04:50:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD45B10E68C;
	Thu,  8 Jan 2026 04:50:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ILcbqxAx";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010053.outbound.protection.outlook.com [52.101.201.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8930A10E68B
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Jan 2026 04:50:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t6aRYGRWqCeFOHVa/AvyyX0L3cjLiHi6gzkSLUTiIb1pdmTm5tAYubgG+qzsZkyMVnHn68HP5nBor3wVLOmijR5IOweFJV9rSSDKfxyu0KxBRrzTnUWcNxKZg6d8LB618+vN8zrKK2sE0UKpg0r5m2iHjoNhIYoH9zOymDBURuIZ1JiTV7tAMRyvDpOBIvZ2IC/EE8s7CCRtlEvqJ6FPW5ZQkaGA1MHVK96fJ+0/6h5b9ID2MzR8n+FuTLMqrpAJhRRzKunbwfVs7AuRek8GHktOK5+9atumjTLvkGaMa5NUjgMzgSlGcFeO4+EDlB77prcu1l8/O1li9BkeXs5YvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BltQcKWqTfKKK+iJjHcuoXeuvRdah9uexJ9HH+Sg94I=;
 b=yDRxByLUoHa/TaGC0v7iNDanVShs4YyZK+9Gi9nMb2/RDmERZS+O7vWeTyDlGOJZOon4SGXRSfZL3pjjahHOylDLBkAW2zigkEpmHHnHBEIVS+xt9UD485El07wFw5ix1W/JOcn/yvR4r6ithGAjGVDCV3Al0VnexUNSMVQf9EgEQj/ru5JEZGp3QT5ZTV+j/lSiJnmhgJEcpcorNObOAUjsDt7AX+5aLQHc5QIBWRAK4jN0ivsIfJiQpyBdqzK5+eNSM7fBTBtCYpuRnjCcrIa5KyA27Kh2LkYOQWFbgu5mVBtZSRh7Do+nvk0OxSNYGYhBiT0l7bYwK8xFY5zNGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BltQcKWqTfKKK+iJjHcuoXeuvRdah9uexJ9HH+Sg94I=;
 b=ILcbqxAxVck3z5h4CPkRZvAeFywqzkcJnyi7JCtKdWAlhNtBc5Sb3Ggt+W7HUpQIIDpX3f2Z49Cf5QF1naeoxyipH64iuirY0ZbHwlqLjFrNGtBXYMVv46lKtVNI5acKWGiuJ04n56ejxIwdGDv7yUxrdSWiuW1nxxfR75L+Q5c=
Received: from CH0PR03CA0318.namprd03.prod.outlook.com (2603:10b6:610:118::26)
 by DS7PR12MB5720.namprd12.prod.outlook.com (2603:10b6:8:73::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Thu, 8 Jan
 2026 04:50:04 +0000
Received: from DS2PEPF0000343C.namprd02.prod.outlook.com
 (2603:10b6:610:118:cafe::72) by CH0PR03CA0318.outlook.office365.com
 (2603:10b6:610:118::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.3 via Frontend Transport; Thu, 8
 Jan 2026 04:50:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF0000343C.mail.protection.outlook.com (10.167.18.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Thu, 8 Jan 2026 04:50:04 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 7 Jan
 2026 22:50:00 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <kevinyang.wang@amd.com>
Subject: [PATCH v3 21/24] drm/amd/pm: Drop unused ppt callback from SMUv15
Date: Thu, 8 Jan 2026 10:17:37 +0530
Message-ID: <20260108044839.4084279-22-lijo.lazar@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343C:EE_|DS7PR12MB5720:EE_
X-MS-Office365-Filtering-Correlation-Id: b7f0435f-e1e8-4e9a-dc61-08de4e7163b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8Cak9JubGPe9mSzeg2NZOj79osO271x0g8CmEFjk9nV6JQjwzBJguS3yit3u?=
 =?us-ascii?Q?VvJRV/vxQs9R3ChciWPAM+grob+yuF4BN7Eal5AgHRLyOVpY287PvkGQ7ZMt?=
 =?us-ascii?Q?T0QHliYeHb6LEeRMZr03jXAiLBPwezuwUIHdDFAgbtE/61kJ/DMshi89MBkr?=
 =?us-ascii?Q?eYcIFR4JxXaKuwCEQpBxBq4YcimWCZp9puVw+7mJqA+XdK+mF3ldWhLy6nsX?=
 =?us-ascii?Q?At/uuuwZxS2DU1YuDaHxkzQzswaS4JwbsiH8nmqfWS68SaB501xTlNAHt6Gl?=
 =?us-ascii?Q?RcWT95ObuP9h2fzhI26CEZiMlA9YeVQCymZ9bqQg1Rtz8KoQLRuAyr2XoePr?=
 =?us-ascii?Q?QAOv+eyU+zfzBT8KBE4eAAJIc7Fow6YDje/vhDcg+HfzDnYwBUXDU12mYyK/?=
 =?us-ascii?Q?Qahsv3LJIXeQyueqt48tc5/4HXOT+FM5PG+eQiiuvc6rNkSXc5s1mvDB8mx1?=
 =?us-ascii?Q?UZbmBniZbmSh59K46Dur1MEaEsQ1/6sQBzKQ2gB8xb39YEX3ranigpZPbVIr?=
 =?us-ascii?Q?+4V0GeUD6rg9zmCrkKNSusC+c7eV1texy74wOZKpbwMyuozaXezZUpY+sehd?=
 =?us-ascii?Q?8aMA4aWM2y5tR1IMAgbz6RaBCm1a1/OM3HzLAV9cofqC2RvYMUOFsvJy75LJ?=
 =?us-ascii?Q?Gt49xLM1vaEcne02ik0U2ojA+pFwQ1U/+0J/lGT/NTCYj4b8tuvpL6M+RTtt?=
 =?us-ascii?Q?ZgEnNwexsGjxkg2KU/1wjqd3eQxKNLFT41VNzeX93ULD1AUswGa0dhu2Nj5U?=
 =?us-ascii?Q?+muvmrwAigrQauTClVSxG/d89fbP26NHqiKcjzBV1xrp7yiPI0XsmcMhBvOz?=
 =?us-ascii?Q?s7sPsWms4bTIhuAjUAy84Qj4TIpOO6n9ykYfKlRN6qbTFj6ej6i+gBjJp9i/?=
 =?us-ascii?Q?432MdaAevUIwWw27PK7q6tBmAomlyk+wzDvZozw1PDDIndRUK/pxZMLsOBnh?=
 =?us-ascii?Q?u9n1meyGVTxf8v7+uuvdcsy/luxIXafpsnV4SRSsDJAYI1WfpnFVS/tK694a?=
 =?us-ascii?Q?pBHAftnjBwRYzOMJekxR84bd86uuY6fzixuQC/4qcf9k+LVyCKrE8lNFiYKU?=
 =?us-ascii?Q?z6/CXi6gVcgEDoNLMJjzxNdC5qF7dMnxO2gdOvHuBUHF2dI4XEAI11KjKh0v?=
 =?us-ascii?Q?ToT7ohrtK6mUcGF/rDAnmkgr5Acn1JMptL52CTTKXBg+nqLq3gScTsaaVDP1?=
 =?us-ascii?Q?yWEuSodcICD6ziXncdgK5XaxyU2m8+NF6PHoGKWS4MFSwnmjQEC/hIBbw1b0?=
 =?us-ascii?Q?yyHzoX+J4ThtAViO0eQO/fbUMkZxIjWTmsJn1xpMMX3Bvn+Q2XVdQCAaIJnG?=
 =?us-ascii?Q?V1epy3UHUMLtUxTGLuhu3zhyMwD6a687aVsjqHo41i5U5nJD0YSO931dU0gX?=
 =?us-ascii?Q?rQMCPe4gl7FJDReAhzRbrefA8XYDqVsm0gI0hDy7XMDMvAM3czSxnd1YG4p8?=
 =?us-ascii?Q?ApvKgut/JWfpfNP5ybPzwdO3nkAx8PdWJV6tfxuldgNqdb0aA/jwznj4powh?=
 =?us-ascii?Q?dQMQ84Nh9XOqAhRs2smwV6wPzt/YP0/79JE4SpbSRoS2PDk5M//i8Qkuq0uf?=
 =?us-ascii?Q?dYi7zboYsrSpAtOF7pc=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 04:50:04.3581 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7f0435f-e1e8-4e9a-dc61-08de4e7163b6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5720
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

SMU message related ppt callbacks are not used. Drop from SMUv15.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
index 61387d2a65ef..95a693a4557c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu15/smu_v15_0_0_ppt.c
@@ -1307,8 +1307,6 @@ static const struct pptable_funcs smu_v15_0_0_ppt_funcs = {
 	.fini_smc_tables = smu_v15_0_0_fini_smc_tables,
 	.get_vbios_bootup_values = smu_v15_0_get_vbios_bootup_values,
 	.system_features_control = smu_v15_0_0_system_features_control,
-	.send_smc_msg_with_param = smu_cmn_send_smc_msg_with_param,
-	.send_smc_msg = smu_cmn_send_smc_msg,
 	.dpm_set_vcn_enable = smu_v15_0_set_vcn_enable,
 	.dpm_set_jpeg_enable = smu_v15_0_set_jpeg_enable,
 	.set_default_dpm_table = smu_v15_0_set_default_dpm_tables,
-- 
2.49.0

