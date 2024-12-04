Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F312EE7716E
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Dec 2024 15:10:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1CFE10E4D9;
	Wed,  4 Dec 2024 15:10:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KyTKu4cD";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2078.outbound.protection.outlook.com [40.107.244.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BF9510E4D9
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Dec 2024 15:10:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZZqWotQddmt9dggcei/CeVePtjay7R0VTFyP80WRmhfgNM1keGP/OTTx2dZA3xv2deMFW+Vvpe9YDb965R0KSPWc4ZoxxCgUSi+BoIiEJWc1aRHjCV5Gtbv4VY7zAyi3thJ3BLqZblqEwYIjE/llR4c818VryUzDlTi/rl7DZ3+UJnB+QgRVC5cpzSVV4AqVVKKYFwKQMiqWF87hi7ODttKhYuK175DnRKLeGmX3IvrmNZuqKVeF6KOcCzyYfTOwJ4guKzMRyQntenM/iMhSy4F9hVJ9wot9hgzHwxQD3qbCXNrNEUQwxc/IhFNqlquDqBIvWuHF9PWxnLpawF6MlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cHnTNChOzb6ir7kV26icbxLNP8yZsonN4SwfZpBox7Q=;
 b=Ngp6mqX8iakQKjeShKHth75G91VoquNHxhE2ufmoInKteQGgOYVKKgB2xvzi1uOSuyimE4iPtnTQnkD3lTqCVbLVoE2fjC4Aw5h/sIxLgQJA71QQ66dmhmK+VLofK+omkkMx3xwDOlslycQn0Oe8xC6CytchDa2LsaIuHTCNnv3NWAwbuWC7cHKIg+E6MoHin0llTtgCDjZWFtvnVefq1A2soXzNn7TMZKIaCrvY1kMUEpVe06RLcmyEWAiZYWyg9/x5ujSjbXWLi/KFPBy08fiMsBiMwhNaLDZ6VdvMQggmQu5S9Z7e7kOlb9qVv4d55q2z+jbF+1T8xWXkmZtycA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cHnTNChOzb6ir7kV26icbxLNP8yZsonN4SwfZpBox7Q=;
 b=KyTKu4cDq20gV7l9h1OW5qNLAGXqsYhCEJ0mrS7341/z0g3A0yT11WIMgRzxyRm0f3tFcKfQfMlu1pyAKrn01k5blz1kUchwfYPtPPrpGS7xVyB3+CeJl/ZjMUaantqwYeHMNoZL9uGkraIdT8ZuIPyFnXLpN1NBnLzI/4Sk20k=
Received: from MW4PR04CA0157.namprd04.prod.outlook.com (2603:10b6:303:85::12)
 by DM6PR12MB4076.namprd12.prod.outlook.com (2603:10b6:5:213::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.11; Wed, 4 Dec
 2024 15:10:13 +0000
Received: from CO1PEPF000066E6.namprd05.prod.outlook.com
 (2603:10b6:303:85:cafe::2e) by MW4PR04CA0157.outlook.office365.com
 (2603:10b6:303:85::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.9 via Frontend Transport; Wed, 4
 Dec 2024 15:10:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000066E6.mail.protection.outlook.com (10.167.249.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Wed, 4 Dec 2024 15:10:12 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 4 Dec
 2024 09:10:10 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Shiwu Zhang <shiwu.zhang@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Enable xgmi for gfx v9_5_0
Date: Wed, 4 Dec 2024 10:09:56 -0500
Message-ID: <20241204150956.3425438-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E6:EE_|DM6PR12MB4076:EE_
X-MS-Office365-Filtering-Correlation-Id: d4ea4747-44e0-4169-7d62-08dd1475c047
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?w9/nJvNhFpXstJnarb1St5poSn7/fBPERs5HDz+UW+Y7paXQ2HEt6XZCdIeF?=
 =?us-ascii?Q?kr8wl8ceDAjmLmpCVbp9RHwoX9/YxtttMe6qEHxHUYQtMpYl+rxnHKADCc44?=
 =?us-ascii?Q?OcCqAzD4eyxvqW/DFtsdj/V2E16i8JfwI8lQSNePt5KSHEDpzl/1sNRsAXeV?=
 =?us-ascii?Q?QYwcmEDNmhTkUZWLrVqw+6y70CG00UkM6dUvIIQgzrBfEAv/u0Nfn5qWi8S5?=
 =?us-ascii?Q?wn6HObdvRQ4Elq2dIya9MUz7RQC7tlvYHsvTpJz0+sa+eLr0LG2K+9WyetCB?=
 =?us-ascii?Q?ygFQIg5EYW80KNhZJRl0Ny2+8gKEUqGBTCmjjCSsbam1XZGdT4YUpt3KzJ1K?=
 =?us-ascii?Q?l1w1mFZgLzhMiCF+IJ5KYMYnYWodN6ncXStG71XgYWig/G09+3f6uJNpSw/r?=
 =?us-ascii?Q?+lczSOIqPepG54gFEvM+PdH0l2nJwBE7TfNEF+64t1bFPlpQHTj/YeXqUNCw?=
 =?us-ascii?Q?jn9GPJahGweQI+FpL0npRS+yPLxxq9E1BrZsa42x1y74Yh/UHf1Os8f74tdh?=
 =?us-ascii?Q?Y9PJ5MKJ/JI2MSyHCeMbnuLyOGD6nzQWP+qLPKdeOStAxgasHHBoM+mY1NAR?=
 =?us-ascii?Q?cHYWkp7R1ltNyOCz+j2q0Fo1tjx/0zZUiTKpdVt6nuz1T+ht3NnRN7qRIHJn?=
 =?us-ascii?Q?2Whvp+WkEGWd7LYZmCsMyM/OlMiHdA7HZjZjbj3qAoNrMNAWol8elMKlDO2k?=
 =?us-ascii?Q?zaWTd5rrdKotFhWiysfMIWpSjZqVh5+oKIF1ElzvI/ZGs2c/LWCqCiQhXa7O?=
 =?us-ascii?Q?yjKGvcqrkEPOca1l+Z560QG1PAiT/lpW/rXOqtNgA7M5hPr3hbKLLr1ZT5Lk?=
 =?us-ascii?Q?/d9bjAJ7fQoVy8lAaCwY6QN+9mV65fE0apf5OZ96KFjpF6aSDjRQjtberTge?=
 =?us-ascii?Q?/giHhvwgMitdYnoaYzSOJXK1E7AmbqXG/xtmSgdAWq6m3YTh/sxk6eVEtP/n?=
 =?us-ascii?Q?gix7NMuIGHIePjukaf9cOa5RDVyf9ApQVLgkPf/ysUs8UbpWr5cIjt+FAaMZ?=
 =?us-ascii?Q?ON5kDCdbWwu2Y0sFlvUJ4mJt2ZqtEaCxop7sjZMtOEhtNxqzR2asQGnfXR/+?=
 =?us-ascii?Q?DcpjT+ymafu02MyBIh7giWUo1YRl8R2hshym3sBtT2BhaZ298lof10XeBngN?=
 =?us-ascii?Q?BCUhKaHcNsw2dnpvPN0ImA3qPCNKtsTKcGNg+NJJJW8ej/tRswubKYD0v0gV?=
 =?us-ascii?Q?qTdqWCyTa0aliePfPqdMSjaSQ5jKMS6WSTlF7DNVqb6VyP4zdp8ID2JcE83P?=
 =?us-ascii?Q?uFglHc3skKreHq/0EUCjwj4kWJ5zGjJ7GpNJ0DY5MU5uzxBGmcfqy2SVGV5/?=
 =?us-ascii?Q?KSptWPusH8rNF/PVG+TJpHnD9nQEaVkGdv1B8acL5p1dYR5QCP27G3JExSpE?=
 =?us-ascii?Q?bkoVaTLRRl/YaSjINcnD8YE0vE0NVgupuYPBSA+OVMk5jCgMQZd/Y/CJrb3g?=
 =?us-ascii?Q?plK5RTnUFeqHXrNrgRSHRDw12u0iNnM9?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 15:10:12.4711 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4ea4747-44e0-4169-7d62-08dd1475c047
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066E6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4076
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

From: Shiwu Zhang <shiwu.zhang@amd.com>

Enable xgmi for gfx v9_5_0

Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Shiwu Zhang <shiwu.zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 1ecba0de12b76..39e008e3f0af1 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1622,7 +1622,8 @@ static int gmc_v9_0_early_init(struct amdgpu_ip_block *ip_block)
 	if (amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 0) ||
 	    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 1) ||
 	    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3) ||
-	    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 4))
+	    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 4) ||
+	    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 5, 0))
 		adev->gmc.xgmi.supported = true;
 
 	if (amdgpu_ip_version(adev, XGMI_HWIP, 0) == IP_VERSION(6, 1, 0)) {
-- 
2.47.0

