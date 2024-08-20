Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F185C531DC
	for <amd-gfx@archiver.kernel.org>; Tue, 20 Aug 2024 20:25:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A013B10E293;
	Tue, 20 Aug 2024 20:25:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vXs7pApQ";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2040.outbound.protection.outlook.com [40.107.100.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB84910E27D
 for <amd-gfx@lists.freedesktop.org>; Tue, 20 Aug 2024 20:25:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bP9fV/iYDriMRXb3YS+zcQ79LIhV5lT5w/zzkPnjBMN5asdU7OSax3NWPxyqAd0aJIwKnvPSiBJKdPWNDLvgNTxbnJhtwza+s+FHQhftmb1BbCD759KZl0+D0+mzJ2SD3nFokATxW7Qo/50NUKd2KSbSXLiWY82qMQx87xdH/fEtdeyuNcL2DvrYdwpSn/w/Uedx9hA73Cqf0kPsrGJ3WTmrBwK8F/Vj/88M/wWrR9kqh+RbEyI6jXKlC6JN+ivb5Y45i2S2lQHrg4wzu60vHniop0ijJPwrsA2+l7d71jQzO/9K5x+fJ0uPEFMutjtdGCHHTlIcUxihUxDK8pNHYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EwKlUM9RXDIFwpwaA8qxEGhXKXJuZY7bkNn4GQktvtU=;
 b=SFSi/RylYbVcN73MsP0UF+0kltCk6sNawlG/PiiydlfxKpG4LbwTKoKkCWJ2GQgJ2YYSvSOpqz/F10TQCU87ZsUxdIbgKufYOhDNDaNcclBFk0+LL6MFCHdaI0ZuxuOZySseBeAo19QD/7lTPT9PlO63ssCeF+jHJ2F/I0nz5r2MVmQPogcYj6wLHoTNiCuooyaobl47GJHzZAAXm4As8VbAWPccQ6skzjrN4Fh6J8Kj5EM6jI9XFhubHDOHV48lYqPpPbJKlTLBvsbGqGcFbFvhKf2D70zp8d3Ok4hFONm5kMY72PpX78qOsztyJq8w4zszw7MFImAyZlF5lWR/Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EwKlUM9RXDIFwpwaA8qxEGhXKXJuZY7bkNn4GQktvtU=;
 b=vXs7pApQhDqjtm0tiFjrHeMWBIxyL7B+uQ8S3Mz1nUwwm4AmkD2I1puhIoB4rMOhnWt9c9Z2odF3ZxJfYPEdXB5/aMOJARC/NXJTbgD1YzuznPRZOwwmmxUFyTzmXUJmDQHMh9VPR1haNgoyIltBqBgV+GCOo8nr0MTaANu2zSM=
Received: from MN2PR06CA0020.namprd06.prod.outlook.com (2603:10b6:208:23d::25)
 by CH3PR12MB9171.namprd12.prod.outlook.com (2603:10b6:610:1a2::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Tue, 20 Aug
 2024 20:25:32 +0000
Received: from BL02EPF0002992C.namprd02.prod.outlook.com
 (2603:10b6:208:23d:cafe::5f) by MN2PR06CA0020.outlook.office365.com
 (2603:10b6:208:23d::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.17 via Frontend
 Transport; Tue, 20 Aug 2024 20:25:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0002992C.mail.protection.outlook.com (10.167.249.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Tue, 20 Aug 2024 20:25:31 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 20 Aug
 2024 15:25:31 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: add experimental resets debug flag
Date: Tue, 20 Aug 2024 16:25:17 -0400
Message-ID: <20240820202518.2110483-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992C:EE_|CH3PR12MB9171:EE_
X-MS-Office365-Filtering-Correlation-Id: 69790680-1f0b-419d-4efc-08dcc1563d45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YKKW+7TanuphAWCdpeQv6UTtlUNxMNGC1MyTty7H3YLRlZEO26ITrYbJD+Gv?=
 =?us-ascii?Q?o3betzj+Pc3zs9toOZ4BK1YNJj2VmeLi2E+X36qZEgsi6NrDDSuAogMTFKr3?=
 =?us-ascii?Q?N7tOwUWdiRhpTGdd9HmaZb4ru3gg32NYikR7w2t6O6t8r7slBtouL4e9PhmT?=
 =?us-ascii?Q?XRPYE4Zx0UnppkxuKbtmx1tJJ6pxZp5S6ZOaCz83+IAGYGSUVFeVPhFYbwKt?=
 =?us-ascii?Q?Wn0pMc0g1u5e2sJ1LSCnbQUfUkNK2QDhD9JnO3yVoQ44x748c+gnUIpJJB02?=
 =?us-ascii?Q?6EDmLFJQf2bkiZtQxmCdLYK8QWc1SePswZJAKG9eTWXiHjpi7a0dfNsQfUu+?=
 =?us-ascii?Q?135AIFJ2LXuaMDupUl7+WtF7gtgMAJrYGFuBBvTyexlpOIZCYM8KQNuVSAvl?=
 =?us-ascii?Q?VQzSvQrGoXiYi6MiCgJM+Wpumrw/QVwEWVdMXusvQ/51tA/+3xK3DROuZPBP?=
 =?us-ascii?Q?YrwQ++7V12pkd7g+YTVlIiXDyQgmXpqXm7shTJqKPy7tsD1IRW7vmwbJIcjT?=
 =?us-ascii?Q?thVV066F0GnDEwu69yuJfuRclxlJuuD8s8Idx9EGqxHjm8D3R1rArHaeDQ8o?=
 =?us-ascii?Q?EgEUO85sy8KieiENYdxXNFInpVRlP+i2GpnLzkwidD7jv6bIvyAV35pmkdvJ?=
 =?us-ascii?Q?1XvGk7AyZckWHXskRiVgCP6LEWYXwN03w9ntUAdss9IvYVCgmdf+45SDmCj6?=
 =?us-ascii?Q?AHP/KkgKp40g0xKOSkJ3KALsd8YhADRC6l0t0e0WCF5Rj68ybFadDchHXDJD?=
 =?us-ascii?Q?VDPeM5XivTiD4w4hcUjsV+GolWf9ilotujI+UV1Efj41I4A179dM9BdNSMYN?=
 =?us-ascii?Q?RFQU7UZvf3eDVuKgpfbAKwd2PCjEFhDypPTJT8iqv7ZrlQGUsnwsXCuGSj91?=
 =?us-ascii?Q?+GqM9yICllMq+H+2E9z09Yer784SWBxoiDE3QTKZgzQA+lpWzcb/Tjl7tWj0?=
 =?us-ascii?Q?ZDb1NdZIATchWXEz1JbsOJELbfR7CsiSioHMhuOQ7ZTA1o2yvepByvbLdLrb?=
 =?us-ascii?Q?OnzPj48gwmRENqug5gbI2O4/7EMNjb83PpCyy7pjwAkXpcycqc4XKj1ggtew?=
 =?us-ascii?Q?q8ztnQU6n5s/YIcvyNuuPsiM77+pb4zcfffR58ab1XmgECSLI+VktStxVL1b?=
 =?us-ascii?Q?5RrLbkthZDX+/kWh91r25QASElsWybiarShyOYnJFrGjOae1p5fR3rysYaL/?=
 =?us-ascii?Q?073YqW2SFyov1zz08FQwDaQ1pcKvc8vdkb5E8pSCzh7XI9cb2l5bX/JrA24y?=
 =?us-ascii?Q?G2dHIbgfwBjqjuEOEnLriT9/9NEzGnltH9lhT+/Vc6MASc9nZeBCg+msveF9?=
 =?us-ascii?Q?8pXjO9/fM5fWjak9DVjT3aCApXt4d9lov0aoOhiuPulyrYtDhZdN7C9Zw3lv?=
 =?us-ascii?Q?9Thk2segw0rN4BAbmp88l6gZYAUnzr713mYnjsBaBcWztSDucAaWa4uu1t5D?=
 =?us-ascii?Q?ec4UsN26DDhaJg1PshzUTkQM1D7czu9l?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 20:25:31.8287 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69790680-1f0b-419d-4efc-08dcc1563d45
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0002992C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9171
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

Add this flag to enable experimental resets for testing before they
are fully validated.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     | 1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index e8c284aea1f25..6e6580ab7e04a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1164,6 +1164,7 @@ struct amdgpu_device {
 	bool                            debug_disable_soft_recovery;
 	bool                            debug_use_vram_fw_buf;
 	bool                            debug_enable_ras_aca;
+	bool                            debug_exp_resets;
 
 	bool				enforce_isolation[MAX_XCP];
 	/* Added this mutex for cleaner shader isolation between GFX and compute processes */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index b9529948f2b20..82bde5132dc68 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -132,6 +132,7 @@ enum AMDGPU_DEBUG_MASK {
 	AMDGPU_DEBUG_DISABLE_GPU_SOFT_RECOVERY = BIT(2),
 	AMDGPU_DEBUG_USE_VRAM_FW_BUF = BIT(3),
 	AMDGPU_DEBUG_ENABLE_RAS_ACA = BIT(4),
+	AMDGPU_DEBUG_ENABLE_EXP_RESETS = BIT(5),
 };
 
 unsigned int amdgpu_vram_limit = UINT_MAX;
@@ -2200,6 +2201,11 @@ static void amdgpu_init_debug_options(struct amdgpu_device *adev)
 		pr_info("debug: enable RAS ACA\n");
 		adev->debug_enable_ras_aca = true;
 	}
+
+	if (amdgpu_debug_mask & AMDGPU_DEBUG_ENABLE_EXP_RESETS) {
+		pr_info("debug: enable experimental reset features\n");
+		adev->debug_exp_resets = true;
+	}
 }
 
 static unsigned long amdgpu_fix_asic_type(struct pci_dev *pdev, unsigned long flags)
-- 
2.46.0

