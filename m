Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17F68C4345F
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Apr 2024 20:37:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F4CD112F1B;
	Tue, 30 Apr 2024 20:37:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sBHQ1yh6";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2086.outbound.protection.outlook.com [40.107.236.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D67C1124A6
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Apr 2024 20:37:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d5nqXdhBIfqKzO7e3pjjlgUEBeoMTAASUo8Fk/QuNYAUk42ve0x+nd/ZFKHCA7JrBqGT/dYNZZbn9vVE9y+AIWkq3TRcbFWGWZd1QT9ZKVb5B7yd2VNFankbUhQTYYaNAUJHfi+2XNytnPdclu6t3GpYdVvoSTa4XslXtbuoh53+lbXpWGfCZAM14JYKO6DxOUAeYB+WYhtpMrSh/as+Am5vkTqCb4Z6gpLayzlP4PQD2g1ykyYt8MRvxZI2Yez7UVbR76DPpssKq8qQMBDeFjDWRaZx2PhsxqC/6NMA5GhGKA3M3G8OCjNaUly+79RQlL+bWwHwkTOMJH/uyNfCmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S32bUgPsXsNWFcxRbd7TtA3JiX8RMmXL1rIWI4S3QF0=;
 b=E4Cr+/yaBkY83T01t54JPOtkVX8eHNQT7HIn8PrYDbWyfZ5UzfiGniS1rOZLG8HnSR3g9qAMDQyG+mPLk8nIjerDMHTDkwArfnALZbiRq/6zgIbJv259io2zZ4CF5X+o+T7nSQcxcL7q96SvWz7XnmdAFClTfg/XJ6A6nupSHsgZ5xtYrfRtCOY5oNgOz15aVRaD2ruw0hSDB9en7Xa7jHkXfohoMzHr+VXfXK28EuclxQ8wPdL+WTVw6nXz9ravQKN7Lo2pnuK8co6rMvJZKyfAZSiX5LXjEHjtAYdQ/T5esIElnwVsKpSsyAkAEGdwFQLGu/YwBiKDNu+N1JDUJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S32bUgPsXsNWFcxRbd7TtA3JiX8RMmXL1rIWI4S3QF0=;
 b=sBHQ1yh6e8URfphsJECXZqY3kRVtxisFPXgvORU+27aoRDKI++F88ATLenec3C/QvKnmETHuR0DqeSZGS13pvEA5ZBMIfq7oOs3HaG7Dg8goz8ZkjEBAMebYAwYgnx48Jt2vaEuTooqD2lrlVTuXDgtTXVNrEFOrrlxsK0I93wQ=
Received: from BY5PR03CA0019.namprd03.prod.outlook.com (2603:10b6:a03:1e0::29)
 by PH7PR12MB6881.namprd12.prod.outlook.com (2603:10b6:510:1b7::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.36; Tue, 30 Apr
 2024 20:37:34 +0000
Received: from CO1PEPF000042A7.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::8d) by BY5PR03CA0019.outlook.office365.com
 (2603:10b6:a03:1e0::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35 via Frontend
 Transport; Tue, 30 Apr 2024 20:37:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042A7.mail.protection.outlook.com (10.167.243.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Tue, 30 Apr 2024 20:37:33 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 30 Apr
 2024 15:37:32 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Gui Chengming <Jack.Gui@amd.com>, Kenneth Feng <kenneth.feng@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 4/4] drm/amd/pm: add pstate support for SMU_14_0_2
Date: Tue, 30 Apr 2024 16:37:12 -0400
Message-ID: <20240430203712.800427-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240430203712.800427-1-alexander.deucher@amd.com>
References: <20240430203712.800427-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A7:EE_|PH7PR12MB6881:EE_
X-MS-Office365-Filtering-Correlation-Id: 830568e9-4997-44e8-3298-08dc69555d5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|82310400014|36860700004|376005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/B3No94SUDlhef6YETi97NvHRMxrNZloyQjt4fEPUR2entq9HgUWmAOiUmSd?=
 =?us-ascii?Q?2lynTLQaAEElSZlqf4yAnjCWh4cE5mS1YaSRSPwwLlkpXBIPPJYn7aSTGm1T?=
 =?us-ascii?Q?X7Vi0B9vkHoDgMjX1fukQJH7g4hjU3vGatNj3/zOBVtzgATewD8XpY+V/jKE?=
 =?us-ascii?Q?4x9OBiD0QNIE2r79v/PI0kowRZBIKYO0A0ZDe24rdV7EndHBMtenbhYJ1hbL?=
 =?us-ascii?Q?c8ij6tqoyz1dqJQmEio0xQH52eYquRQBYzDbvD2fWma79cIfJ9YlXIvQMn5E?=
 =?us-ascii?Q?E3KZ5Ss5EueTFc2mT8F7ozvc2yJJz9j4KdzqKJRMbegh7sze17+UcLyRDXru?=
 =?us-ascii?Q?4DfY4WmRB/N66OluoZBvGZOud/lXCHN+3aBpbRSoAKwaMwpL9ffxuddkPAOY?=
 =?us-ascii?Q?zrfb+WDZjgWgM50LmjM8SkKcocOxRaogmmFRvpB/Hgt+BwkT8kd+Rnoo1j6g?=
 =?us-ascii?Q?+DbARbfPn3rFzuKl1Kllp04Q2EcnV3veyGP5UfKqNRombSuUIohAoqcEOHWS?=
 =?us-ascii?Q?+020HuN6F8Ny/+V+kDZNq7H+iDZTjU/T7fEeGtmFWWP/Cs0fZrk5GF/Rd8bY?=
 =?us-ascii?Q?+MLgqc2xAk2KfgXxOYYchIRmNcONcfdL4W+cD4j5fghQDhNJkM117RYpiZfE?=
 =?us-ascii?Q?Ples5x88b4VyP7eWqEWZmzNn5DPlBPxRm7d0/iN6pMvHV2CflciL+86UKkIG?=
 =?us-ascii?Q?sXQa928kGdrdSErVjUJuS+NrgfebWkhz+rZOU4lDJ5wwX5VgCio/rUW82HcI?=
 =?us-ascii?Q?Ob+lKwpXI8lLNJUDx8xBH0d4G2bNkr/iIphuS69m9qA6ZyduIaWOKfyNd2D/?=
 =?us-ascii?Q?wDKxdbHoPOwK+5V+ospB729NAjowwTGcnKVF+GjPjPiEFOnGoPUmqLT5IyKr?=
 =?us-ascii?Q?Hm74gLnWYpjbQ1uKuxbKjtYXTLCSx1RprxOOpBkBGtMJmxqG+t7ZA+9tng3l?=
 =?us-ascii?Q?OfBqTA3oE16Ntqafp7hUHjFDOWIAvkYLtAIhr5JCWCkS9aq5R+tdJwoPfmKa?=
 =?us-ascii?Q?XAhp744aL7PxX0xRafCwJ2YPUsTyghzYaSG7YnK6jEZ8fcHnz4px4iTLsyK7?=
 =?us-ascii?Q?jXCQ3+RMrkHpsoGoIEeycIcUNK4P2e2kdq4hyVnhP5iMKoGeuv6KW8qGJAqJ?=
 =?us-ascii?Q?rCTejITbzrQEhc+Onlye07Ctr44/4ury8i+Go5JPcZblSXRCXCbcVnw9EC1a?=
 =?us-ascii?Q?uqN9d+0xzpcdVeZxdXVWgrHXUf2RGTBVRyJM3rAF5+POMopwgW+WYWpjxHHp?=
 =?us-ascii?Q?OG9LhhBBaJYS3O2wHD4yCpQVfx2K7q3xq5pqPDkVrxAjEgjTTwCLIMJ8GL69?=
 =?us-ascii?Q?dPd0kgsxNWIeRsNzcMGBWssvQoj0RxK6OYy/63FuElZtQbhpbT7joGZIqyoW?=
 =?us-ascii?Q?NVT0EdsUjkSqXUYVDkuD6LPtd117?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(82310400014)(36860700004)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 20:37:33.7015 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 830568e9-4997-44e8-3298-08dc69555d5e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042A7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6881
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

From: Gui Chengming <Jack.Gui@amd.com>

Populate pstate clock.

Signed-off-by: Gui Chengming <Jack.Gui@amd.com>
Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>
Change-Id: Ib95b7a334c1bd51592535b40fd2e7b8f6802571f
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c  | 54 ++++++++++++++++++-
 1 file changed, 53 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
index 83bca23c3ebee..0d5ad531c764f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
@@ -1232,7 +1232,59 @@ static int smu_v14_0_2_get_thermal_temperature_range(struct smu_context *smu,
 
 static int smu_v14_0_2_populate_umd_state_clk(struct smu_context *smu)
 {
-	// TODO
+	struct smu_14_0_dpm_context *dpm_context =
+		smu->smu_dpm.dpm_context;
+	struct smu_14_0_dpm_table *gfx_table =
+		&dpm_context->dpm_tables.gfx_table;
+	struct smu_14_0_dpm_table *mem_table =
+		&dpm_context->dpm_tables.uclk_table;
+	struct smu_14_0_dpm_table *soc_table =
+		&dpm_context->dpm_tables.soc_table;
+	struct smu_14_0_dpm_table *vclk_table =
+		&dpm_context->dpm_tables.vclk_table;
+	struct smu_14_0_dpm_table *dclk_table =
+		&dpm_context->dpm_tables.dclk_table;
+	struct smu_14_0_dpm_table *fclk_table =
+		&dpm_context->dpm_tables.fclk_table;
+	struct smu_umd_pstate_table *pstate_table =
+		&smu->pstate_table;
+	struct smu_table_context *table_context = &smu->smu_table;
+	PPTable_t *pptable = table_context->driver_pptable;
+	DriverReportedClocks_t driver_clocks =
+			pptable->SkuTable.DriverReportedClocks;
+
+	pstate_table->gfxclk_pstate.min = gfx_table->min;
+	if (driver_clocks.GameClockAc &&
+	    (driver_clocks.GameClockAc < gfx_table->max))
+		pstate_table->gfxclk_pstate.peak = driver_clocks.GameClockAc;
+	else
+		pstate_table->gfxclk_pstate.peak = gfx_table->max;
+
+	pstate_table->uclk_pstate.min = mem_table->min;
+	pstate_table->uclk_pstate.peak = mem_table->max;
+
+	pstate_table->socclk_pstate.min = soc_table->min;
+	pstate_table->socclk_pstate.peak = soc_table->max;
+
+	pstate_table->vclk_pstate.min = vclk_table->min;
+	pstate_table->vclk_pstate.peak = vclk_table->max;
+
+	pstate_table->dclk_pstate.min = dclk_table->min;
+	pstate_table->dclk_pstate.peak = dclk_table->max;
+
+	pstate_table->fclk_pstate.min = fclk_table->min;
+	pstate_table->fclk_pstate.peak = fclk_table->max;
+
+	if (driver_clocks.BaseClockAc &&
+	    driver_clocks.BaseClockAc < gfx_table->max)
+		pstate_table->gfxclk_pstate.standard = driver_clocks.BaseClockAc;
+	else
+		pstate_table->gfxclk_pstate.standard = gfx_table->max;
+	pstate_table->uclk_pstate.standard = mem_table->max;
+	pstate_table->socclk_pstate.standard = soc_table->min;
+	pstate_table->vclk_pstate.standard = vclk_table->min;
+	pstate_table->dclk_pstate.standard = dclk_table->min;
+	pstate_table->fclk_pstate.standard = fclk_table->min;
 
 	return 0;
 }
-- 
2.44.0

