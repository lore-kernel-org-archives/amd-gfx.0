Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD24AC3600C
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Apr 2025 20:08:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8752F10E05E;
	Thu,  3 Apr 2025 20:08:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MwLUloVT";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2080.outbound.protection.outlook.com [40.107.244.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1022310E05E
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Apr 2025 20:08:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t4mW2NTgs0K/Kq6qq2ph/1EpD1mU9bp7Psn8XBUYZO97Xo/VELSlrmiw2eGQX7K9ZZ6+Z0+mqSp2efMw6pkq/Q8qh1NtPOaayejCRjgYhM6kAq3AvdtiBW02XHu+hj5Oz8tfC7u0zl/T84lhBG/CzY9bvSp5fcwon9A+ZJ5L6FYZi34iVDkvq/W70+adbZsRpJFlRp8vhMwyJnT2wR5BO0Rk4jtg1LCp3QNxWasz3ZgMDU+tcmxcHov/nZzNryBu1Rl+wRqwrRKaXzSfti5DlyE7aOudnbFR75VWPxXSQRebEJNBjEE9+fWdjPhtJlD1/n7im8EEjvr/fmo/tTX3Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cpz3ie+SWDfIkzIzCQjcbBY5PN1ce+udFezQn5SqkEc=;
 b=B7Neu6TLZpVmdKLo6NRRIDPR2aeu04oNjAC+MTi2+8K/exwg0+t2KUesPYFyVlYC2kyadCQ9C7uZPpEiS0jrMONlX7YxUQDHYqG4inrgjgBcap/MBjpil5oRXk3csTjD9zQq4rVtTuysy61s0A5SnoKntvlxcs39tdIH+PMuzVqY9kSiU8eY509nSxc+lPnPbNKDcDf0kHegf3rjkn5BnxNAsnSdeFuVxiq33jtK4ZXNhEQ5GvanUpQukeYejl5MdWPR9ZsCHZ8N+l/2dsU9l3QtFWSNE8WM1TolZpcGr0baz+J8+wPyekI9i0EA+moRqxc6oNxgcplwabRYoeki7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cpz3ie+SWDfIkzIzCQjcbBY5PN1ce+udFezQn5SqkEc=;
 b=MwLUloVTHOUMYl0yL9f0IRNnkd06cGLxjYBUmWpr6rbsJs4g7yEch3ddP3e0yw+LtipdlJKlTAoaN8mFN41RIReWMEo9vMtW9xtPngEDt+zaRkeeqR4R9GnFwA+gZxUPMMXaf2PBslhDaIy4gayqy2ptZ/AFl6qNdg8ti3s+bQ0=
Received: from MW4PR03CA0301.namprd03.prod.outlook.com (2603:10b6:303:dd::6)
 by SJ2PR12MB9244.namprd12.prod.outlook.com (2603:10b6:a03:574::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 3 Apr
 2025 20:08:21 +0000
Received: from CO1PEPF000066EC.namprd05.prod.outlook.com
 (2603:10b6:303:dd:cafe::fe) by MW4PR03CA0301.outlook.office365.com
 (2603:10b6:303:dd::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.32 via Frontend Transport; Thu,
 3 Apr 2025 20:08:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000066EC.mail.protection.outlook.com (10.167.249.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8606.22 via Frontend Transport; Thu, 3 Apr 2025 20:08:20 +0000
Received: from dell-1e707-d05-15.mkm.dcgpu (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 3 Apr 2025 15:08:19 -0500
From: Masha Grinman <masha.grinman@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Masha Grinman <Masha.Grinman@amd.com>
Subject: [PATCH] drm/amdgpu: Move read of snoop register from guest to host
Date: Thu, 3 Apr 2025 15:08:03 -0500
Message-ID: <20250403200803.55726-1-masha.grinman@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EC:EE_|SJ2PR12MB9244:EE_
X-MS-Office365-Filtering-Correlation-Id: 0949f6b1-9a97-4018-46ae-08dd72eb47fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?r4Uwe1XlXmMcMrkhxivyuGaSDGQ8/sbv1hIunNEBOe/PnQfV4q+IlPNrMYyl?=
 =?us-ascii?Q?TM8kS5cNncOHrFiEH0vWPdb8mNBIx6s3jUJOkS5h2GBGn94E0FOSILPSEXRm?=
 =?us-ascii?Q?OZ133DYen3jtbZCzzguxXhjZ3Suz5QgwkRzNTKUU5vxgfHzfsir4Ky2PchGU?=
 =?us-ascii?Q?f5WdkTsG7+TduYgYIyRQCgasVegIDTOjrAmIb07fTFlwV57J8caOAXiihuvZ?=
 =?us-ascii?Q?B1l8th4vYncciPk19YuEvy1GleHsM7XNJzp+FKH8fzQfg8FFAexYtROW8Q2q?=
 =?us-ascii?Q?lihXCDam/thUcNsm1TySUjDen42wOH/Vbszc1NAHNgXQX6HmnEKQlx72rKGm?=
 =?us-ascii?Q?TB1W1P0ff8d2yrTUfSrN6xM1xAeeHxk6V1eLSpEJP70dNj5RwSM61aGXVy4p?=
 =?us-ascii?Q?vonOxb3p1KCAlAFPup7IsKT2oKo6HcmpRfa85gN/jK/cBHvz8u+ZaNZg1m3c?=
 =?us-ascii?Q?DHNOmDWE8sU5vdD+31mxcB1Ilh5oBxPkSRkGg0mByox5t1sjRY71zm7Hd7Mj?=
 =?us-ascii?Q?WnH91quNJiBJB411NLTiK+qc85pzLGA7ibU8gn0iXL0ZIAZc7s5vug87iQG1?=
 =?us-ascii?Q?bc9ImIx6ArCNHsgsDQgi/q4aIpm0IdGJ1zSNg+d+rgjFeC+rXdBXYuVm5AC5?=
 =?us-ascii?Q?LG4I5n7IbpZDauVgs7tKAYXMbasivOdJfEH0ZRxEfu/dPat/QFhqYRACVjLx?=
 =?us-ascii?Q?cB0fZj+MHAE7SpKyJen9UWVE58cccYWkUkAov4gbF+KyMGSuY5FfYspQ30vd?=
 =?us-ascii?Q?x9FFXjkDr2SNVvT3ATu3lqns+6okQEKQ2/8G/ghcpJLlRDx6FfuyPhS1yRSJ?=
 =?us-ascii?Q?8jlsAASlVXztKyl9k73fG62IariMnfarRUTofXju/jSoQibkNRNcrXUeckrE?=
 =?us-ascii?Q?vUJ2sqolbvvURbs5WV9iRT/bJu1lAj+ge3qKzS5Lpa5XddAJlKusVUNPsIqX?=
 =?us-ascii?Q?anXlYOikhlekT+A3oXNPIMY56WJKoUKe7PHvAvzhREUShY5JyOCGAx3BXCbv?=
 =?us-ascii?Q?a+wEUrVTtRECC49i1AJQCtGtZdvYCoFt9oTiFT5piN9t+LbtymJ5a0VoW5A9?=
 =?us-ascii?Q?DhvsF9wHFz83AqjbUcn0tCLz4eFY5PGNwmJOtQf/Xsw/XEYaZjhG0rkGB48s?=
 =?us-ascii?Q?tRTJSvgxftmyTsMBUyBtjuyAPLUjRHFJG8QFrMMsRJ0Evrx1rs14A/BiuxQz?=
 =?us-ascii?Q?80IGwGKdLRgylPBbbmLRQXMhrbRRJkdev6PL+oO1dqDY09qX8Xn/sQlz6OAm?=
 =?us-ascii?Q?5EX3O4I1C3GUZzL1Plv11IPkW0fvyONsJDX2CEiB1EU3Xk/Ul7wDkMImpMU9?=
 =?us-ascii?Q?OFCxMGoevBAN4lBwcB70gp/am1WhdzUb90r5kBQAbuLHRSWcFm2AnmxGM/5E?=
 =?us-ascii?Q?P7+UsezjIX7t1X3dlKV9uwrS07NADD7Ak1UjgR9sHw8cPxInEdCbJY4A7SHS?=
 =?us-ascii?Q?MpjPmQYRVrUt5bUb9Kb2rZ0j0fpDpu7GsxElQ13gvNLu5GW0gdpuSw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2025 20:08:20.5799 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0949f6b1-9a97-4018-46ae-08dd72eb47fe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066EC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9244
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

From: Masha Grinman <Masha.Grinman@amd.com>

Change-Id: I1d5773ffa6187a961994b3403d4cde5b1641369f
---
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
index a54e7b929295..6dc3896fd61f 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
@@ -221,6 +221,9 @@ static void mmhub_v1_8_init_snoop_override_regs(struct amdgpu_device *adev)
 	uint32_t distance = regDAGB1_WRCLI_GPU_SNOOP_OVERRIDE -
 			    regDAGB0_WRCLI_GPU_SNOOP_OVERRIDE;
 
+	if (amdgpu_sriov_vf(adev))
+                return;
+
 	inst_mask = adev->aid_mask;
 	for_each_inst(i, inst_mask) {
 		for (j = 0; j < 5; j++) { /* DAGB instances */
-- 
2.34.1

