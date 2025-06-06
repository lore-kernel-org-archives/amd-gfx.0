Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 053F3C5B549
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Jun 2025 06:55:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 671CB10E90A;
	Fri,  6 Jun 2025 06:55:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SQdKu2fR";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2052.outbound.protection.outlook.com [40.107.244.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71F6210E904
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Jun 2025 06:55:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HoLB+2VnVmXVD+ni4uMIPCygdl5cH+sNh09w1DkOvphAB1QUZcEKKV+n0cF8Kz8DPKLOz6kjPE+fCBpQ1oUF0OgPwQF4lFw1owbXgupxsxmLqAcita63KGy6KFNXJbSurVoVq+Xss8RnWNNHNdyPu46UvqpMhwd5LQY5zzMg/HYsKf2vURXqwlUe6nxrpCYX4vq/YQY5WJeuG9E1o1rQNbS3QGqLGJYG3YsT4fBIr9oiBniUMurxHJWhRUuXHqHoN0Ymc+9vKANQQrFbjOQuEDc0TQ7/C5O5A1AMhijhjdFg1Bc4Pp5Bgc8rCvINLberPCdXiW2AjLDRrM64a9pZTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9VUw2Y+0A57kDIZC4VtJXCMW6sTG6yuMH36DsnzHZos=;
 b=DWcrwwjevyNc7++i+HOkgCB1eV/WjYjzIAJhlXkVg612HzgZJXhVQn5dlET9CIE6u6qw2S9qBpnkROSnmeql7GWec8qoGdm1HTi5O0VjDaraSjHhWbOgYqDxJb09WuRAat0H3q8+Dlr7rlPhC59wcdML3MZssBQWiVUt4bk4tQ43BijSbtKkHOTxnLoU2FWKoGfS4qZjs4On3WSXKjIspIQ/IyDnYgyKWVT5deJx+ZLd8Whm2qAUEMSnAgAf5lMLqCX9OE9TIECLPwHqpR+dtVir8s/oe+mCC+TrgxN7dUjf/bRUwqq6TTsL1xw1CSl+JC0QvaWoGX0GGrtiOWyEAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9VUw2Y+0A57kDIZC4VtJXCMW6sTG6yuMH36DsnzHZos=;
 b=SQdKu2fRrgkYgqNqds4BErlCAlFgTncqK518FBLbfc6MoC9M/b/pV9D0bn8hkIiJMUhYtvarjSYAQ12PcPDSCWwtEAVgulJ9lcldjpz4FLboVsMUXwlNLWQNB5pcV1RdgvH19cU7xefLiKWFh+Jg/ccgALqgoLdmDPjPlXyFeoo=
Received: from BYAPR02CA0010.namprd02.prod.outlook.com (2603:10b6:a02:ee::23)
 by DS0PR12MB7677.namprd12.prod.outlook.com (2603:10b6:8:136::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Fri, 6 Jun
 2025 06:55:13 +0000
Received: from SJ5PEPF000001C8.namprd05.prod.outlook.com
 (2603:10b6:a02:ee:cafe::a7) by BYAPR02CA0010.outlook.office365.com
 (2603:10b6:a02:ee::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.19 via Frontend Transport; Fri,
 6 Jun 2025 06:55:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001C8.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8792.29 via Frontend Transport; Fri, 6 Jun 2025 06:55:12 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 6 Jun
 2025 01:55:08 -0500
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <Asad.Kamal@amd.com>
Subject: [PATCH] drm/amd/pm: Show default gfx clock levels
Date: Fri, 6 Jun 2025 12:24:53 +0530
Message-ID: <20250606065453.690462-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001C8:EE_|DS0PR12MB7677:EE_
X-MS-Office365-Filtering-Correlation-Id: 67e7fe25-f19e-46dc-440c-08dda4c7158d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wYu6TevjbuOMzvZh3FxdVnKVB93cPdVIeNkLlUDjlO5oTIMS+B4MUrb79T6k?=
 =?us-ascii?Q?pbdiXnwreHVy57LOqLiaFP8qFUH05ffP2HOQwCke+OdZHETZ/Mh9TBHZlg+h?=
 =?us-ascii?Q?je2yhxnImLsmV+lPk5rQbTwfJMwtORHSZYMyoULmSs7VzpG/lVuprElXcrXn?=
 =?us-ascii?Q?NgjXcU5Q/ouLElb+SG7WNMETLod7Ux9HOOT1ghViWnyisHpA/DPTcGmKPthG?=
 =?us-ascii?Q?HLO9x5JPkZMSUqTXdO2QAIBHEZZNPjnyuzG+2OOYAU9Es5bthEkUe3tPbj+J?=
 =?us-ascii?Q?6KSL5omqs70n/kTgY3dlA0I1Orb02mxZFGTSYBvA9GTRaOA7ENJN7qzQXNPg?=
 =?us-ascii?Q?IAjqQuB7duhgabtmvYfbk7AMODZeII62CYu0NFtj5pmYWmuYcy96/ulSt480?=
 =?us-ascii?Q?L3CA2qfXe6+G/KMdO0ossi020BJcL7WDrr9kjseyxrBZPPJfXHjwwQyvBdco?=
 =?us-ascii?Q?WXf8CAZoUfxLccUpEawG9YgN+IrDYWXwaCY4V4OwyBtfJU+t0/cVOLU7dKhC?=
 =?us-ascii?Q?ORdGIHCJy6r8xt9Ydp1SFr/nyoe6hSKu/AVXTb8UElKFNKJUootjzy0WAMF4?=
 =?us-ascii?Q?5R4X+FyCk2UDn3b9P7ogSBfhLa4bUyjQVnb4KnJmLXOvmcnqOthzHFwdwWtM?=
 =?us-ascii?Q?hu8UvnkgaK7FFaBd3Fm89eX9UCFESjxV10H3aMX//xYvKkycqzUc1AHTnYwd?=
 =?us-ascii?Q?wnN3PPBonsnkjKHP4igKMdhTy6Fz0qQo/GFprmObi3/HkSQ0M296i7CLfu2c?=
 =?us-ascii?Q?nkgGGYrcVY47oje5KP2gI5Yav2jnAxvIFVAO3vat0CSuYW9IiL4W+oU7Ztrt?=
 =?us-ascii?Q?DhEGi1p04ndXAKsVHGSRimOUqE/vXbktMtxwiXwz/CCU4HB0scZ7QrnG1g4j?=
 =?us-ascii?Q?4LJu3K8voguPJbM/1wJZVyFy+SHaAW8m5lkhLykvQHr8m/pFXTI8P7PwbJWu?=
 =?us-ascii?Q?Gjpzm40GjtinHjkMdDcrNGUDSiUu85i9lLO504J861niguAxkLELp7qQDwE+?=
 =?us-ascii?Q?TKDmYYDrI3dLw51vvDxWM1pIOwl+Yuwq5yjOO3tU9LOyzcJnopXjPCXtcldJ?=
 =?us-ascii?Q?7cI8BDIUBjyx6k0iK0APsPLdoVMSUdLj2IPlfXYL4l3CV4QS1du1vTA321m6?=
 =?us-ascii?Q?3oMPDgcvaXiDcEGe+WDhJVq88UMxwJVN35Nb7EgzHs6GS/auHgoXXikL9JRB?=
 =?us-ascii?Q?qvIvFVT8AFP9QYbe0oO9Rz1GqzdQyB1oVyI8apm8Z4tC2zOzsTv5UYcPQvi9?=
 =?us-ascii?Q?vwdwEIUtNMK+yYG/e/jmqQ7PCxGjGUH6j4Q4k4C4ZnjYU0Xqr19F66wJ2to9?=
 =?us-ascii?Q?hv1J7DZhYwMKsNd088woQhQjW3kpyGo8uf0DjIWtKgEarjOSo31ATMtALC3j?=
 =?us-ascii?Q?DRrH9BF6Q9/MxhhpKzHP300PBCY91XqalUcNi9FeldMnUlInG9E2/b2kegp9?=
 =?us-ascii?Q?IiHqkCwgtEkWnxvcrbNCiHyDiCPk+a/mBM5nS73kt2xv0Cm0xlPRd19GoK1p?=
 =?us-ascii?Q?lBsHxuHznuiN9fQmSzZSpnfwkjEEckdOzThQ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2025 06:55:12.2765 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67e7fe25-f19e-46dc-440c-08dda4c7158d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001C8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7677
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

For SMU v13.0.6 SOCs, always show default clock levels for gfx in
pp_dpm_sclk. Any custom min/max levels set by user will be available in
pp_od_clk_voltage

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 32bdffa360ee..36f210698bea 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -1416,8 +1416,9 @@ static int smu_v13_0_6_print_clk_levels(struct smu_context *smu,
 			return ret;
 		}
 
-		min_clk = pstate_table->gfxclk_pstate.curr.min;
-		max_clk = pstate_table->gfxclk_pstate.curr.max;
+		single_dpm_table = &(dpm_context->dpm_tables.gfx_table);
+		min_clk = single_dpm_table->min;
+		max_clk = single_dpm_table->max;
 
 		if (now < SMU_13_0_6_DSCLK_THRESHOLD) {
 			size += sysfs_emit_at(buf, size, "S: %uMhz *\n",
-- 
2.25.1

