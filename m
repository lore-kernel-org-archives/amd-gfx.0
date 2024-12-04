Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DC1DE77171
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Dec 2024 08:32:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A9CF410EC52;
	Wed,  4 Dec 2024 08:32:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="W6iPzD/5";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2064.outbound.protection.outlook.com [40.107.236.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B5CF10EC48
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Dec 2024 08:32:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Co1CLJCjIl4xpc8//tP+wgkM0siox4x9fYZyuBSgugQzFW86HxF5rF47udZ3CaxCm0I34lvDQtuKmljVZc/aHNpJCKpXcTAYPMNkGs5Lg40Q681V27SIG8GiFpZ8uCJr1nDUFoGd0j/aFNV62oOMgx1vkJbxFM0EP11cfPiZI/NE9RYAMkfDWfwPblP4QssGwSmFxpPQ1WfG1bs0dsewdWynq9d88rY40TCUaYx9BcfdtS0wyRdIXbhj2FXYfG/lo4YsOBM5UzmyYE2Xi6e1961IN8KfVDn3rpB/bswreknhZ+t51xtIENanVbzw78/BoFwsbH9OpXp9YwnFO86log==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A+PMozbiMHFziYvs2RxKRs6kPwjw4gonA0j420+Yitc=;
 b=uIh2Af9BVBw7WHaoMOBMg6K5vcqU+0+cNiyyR2ics9wp5bUKsFyZ40Vj0Ofb70m24puijujzfUlZK1jIt9wn817ludsSRd8O6ZAE8scc+mnFpeNbhIqlTeCxZt6HwVGkzrAli9UJhbJH9G6YZYsPLsWf6FYRfjxjlM/cTTaxEotnWi6OLlQmVXVqmosyYMItgC58JEc8ujo6jDCbm3fLLLk45xmajQQsF3vMB0LTA7hrv6gV6aqRzpYZKj1wRu9TCHMIimps0on4YyxdOmotXlgvlXz7Hua9/VwTyyx6oU33t76i9LtAYq/rEEXAY7EkTkhDbbr4fMttph5ZRoDB/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A+PMozbiMHFziYvs2RxKRs6kPwjw4gonA0j420+Yitc=;
 b=W6iPzD/5FFGCSqO2aPNfi5w57TGJw/N8K2QAvZ7RkOnvCrym1Cb3Gr1piekFO2vWkKWxB46wW/uk5y6Vst58vFIbY4hB4t/NOBA87iF/PPSGiciaAN4kwxjpu++pWgmeRKz14ahSBFPQLX5aSJ27MMkBVgHqJdqz6y7AqGLm52c=
Received: from BN9PR03CA0409.namprd03.prod.outlook.com (2603:10b6:408:111::24)
 by BL1PR12MB5828.namprd12.prod.outlook.com (2603:10b6:208:397::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Wed, 4 Dec
 2024 08:32:05 +0000
Received: from BN3PEPF0000B069.namprd21.prod.outlook.com
 (2603:10b6:408:111:cafe::c5) by BN9PR03CA0409.outlook.office365.com
 (2603:10b6:408:111::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.19 via Frontend Transport; Wed,
 4 Dec 2024 08:32:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN3PEPF0000B069.mail.protection.outlook.com (10.167.243.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.1 via Frontend Transport; Wed, 4 Dec 2024 08:32:05 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 4 Dec
 2024 02:32:04 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 4 Dec
 2024 02:32:04 -0600
Received: from kenneth-mlse-vm.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via
 Frontend Transport; Wed, 4 Dec 2024 02:32:03 -0600
From: Kenneth Feng <kenneth.feng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <kevinyang.wang@amd.com>, <lijo.lazar@amd.com>, Kenneth Feng
 <kenneth.feng@amd.com>
Subject: [PATCH v2] drm/amd/pm: Set SMU v13.0.7 default workload type
Date: Wed, 4 Dec 2024 16:31:58 +0800
Message-ID: <20241204083158.1312554-2-kenneth.feng@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241204083158.1312554-1-kenneth.feng@amd.com>
References: <20241204083158.1312554-1-kenneth.feng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: kenneth.feng@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B069:EE_|BL1PR12MB5828:EE_
X-MS-Office365-Filtering-Correlation-Id: b622e033-e4b4-41e6-329f-08dd143e228d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TMoe8H9gINhNFuZECFYjrm0kki607KW2ha8FVRibEskdsjiU7W2KrSQ9tyHd?=
 =?us-ascii?Q?nqoZ8t+3mKFyC5PkavQ32FowmdXsDc0kKT0u6jq3bCPwhecU78m6LjX2/bLu?=
 =?us-ascii?Q?NLxosW/5hrFO0j5G0+l2/qE0AGrQFSyNICgMGwGmu/Y3WiDmnYRmgGR8YVA+?=
 =?us-ascii?Q?8WAEjUsKcicJ9r6uyiJDCg7xdYFXZr4td7L+FciiW1OuUt4Aup51EY0U2O12?=
 =?us-ascii?Q?i/T1210aMbDoENTQPXKtTSg32KlPp1UK0BEOe90sNc5Ip5B2S1laiX17Pe2A?=
 =?us-ascii?Q?8RyCk2KubAg1bgnDd2F5MivcLRZOdVqoghc17QmhkvGJR/jtli3nkyLM40Ju?=
 =?us-ascii?Q?oxLyEW7BhMctXzeI7ChAErermkJe95zsFp5qukvMCxXGFDXnODtg6R6xOfLp?=
 =?us-ascii?Q?xxz63bonM1Sp9+LkXS2Q00mAqGcc5mzN77jnXF9li/z2BZtCEHuC+DRuEJtV?=
 =?us-ascii?Q?GikgKq9phgzbESl70Uor14vi5S85o4edd9UBAFARRo1fPfHV+uHd9TrfiSgl?=
 =?us-ascii?Q?C/nLRsyUfTGE2v49Bwnwsg9DtYgCXXxPfSaLevUzS8wU/lZQDB5B6zhXlYHQ?=
 =?us-ascii?Q?Op/VDlE14z124ZRFLtyRQYZWKN1xQLeVIX+mGqvlUBzUnABeEkY8IxoB+R/w?=
 =?us-ascii?Q?H7qgw7HbKCGfTUdoyMKtNzhhGSYG+1Ttt1LbpbHyaqqFLFsQrx7Iteou837u?=
 =?us-ascii?Q?3Eo1NYQjrpye0Ba+VtU2LfieD51F9rdTdBkJ9sXeb1jQADY8r/a/zbKFhZue?=
 =?us-ascii?Q?l+Jgt6U6ZmvAWxjS0mXyv/0Mm2VPUPGLTvEchnF0szz7C1P43+2sIJaiZ+6h?=
 =?us-ascii?Q?ZupKxfDKnBDI3JLQrDW24a3+tm/Blx6r4KfQ1CAPQd4Wdzczc2qtrA3fdqrw?=
 =?us-ascii?Q?0W3AS31Jc+w0D7d7CRgqHvpa5a3g1TrcNw9WpZ2iLxPZF2Y34buUpP837qw9?=
 =?us-ascii?Q?yyRVuE+JnF1wZutnM9B3ZPR3ak46lTArnOkjYIvVF+fNwQdAFHS0BKTz4IC6?=
 =?us-ascii?Q?ySHXMkJAx5dbc8e56R69kCkXMe301oT2BPuyF9V6Dgb1aQHS7EVgE6ZGx45U?=
 =?us-ascii?Q?ihKNWwpFVI4YjTl21znpyNbfsFNXRn2PxuLu0usH5rmjfIDOagtayzickCf4?=
 =?us-ascii?Q?DYIOKD62JG1KoKO3Vzz5Qq5DReAbuW/XNZf0fwkmvJOg5/5BzEdpIluI5F0B?=
 =?us-ascii?Q?5F5AdSGKa8nHCRNrFvirNpz85NdF+LINQK0/gdRI4HX2Y9hUUxtF2ezgmMUr?=
 =?us-ascii?Q?7EWRYwle+6Odr9jt7FaimHq9b2DS21Ln12wLb75ytQBWR8hOKoUFh+dBMTBd?=
 =?us-ascii?Q?9D9NVN1VJ/hQNOf/Ix+I6WMfBoAaUV2YL7pVgLojQVpCJjnsfa7gKAIZCX+t?=
 =?us-ascii?Q?BZzI8eyQ3M9Ywt3iD7sRLNI00pyLZzP7UJiZKBqsKDQglO/GTf2cfmciWWL3?=
 =?us-ascii?Q?nvdkNyL883atrEz97NdUlH3Yr8vGGnyM?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 08:32:05.5903 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b622e033-e4b4-41e6-329f-08dd143e228d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B069.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5828
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

Set the default workload type to bootup type on smu v13.0.7.
This is because of the constraint on smu v13.0.7.
Gfx activity has an even higher set point on 3D fullscreen
mode than the one on bootup mode. This causes the 3D fullscreen
mode's performance is worse than the bootup mode's performance
for the lightweighted/medium workload. For the high workload,
the performance is the same between 3D fullscreen mode and bootup
mode.

v2: set the default workload in ASIC specific file

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index f4ac403b8b36..aabb94796005 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -2810,4 +2810,5 @@ void smu_v13_0_7_set_ppt_funcs(struct smu_context *smu)
 	smu->workload_map = smu_v13_0_7_workload_map;
 	smu->smc_driver_if_version = SMU13_0_7_DRIVER_IF_VERSION;
 	smu_v13_0_set_smu_mailbox_registers(smu);
+	smu->power_profile_mode = PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
 }
-- 
2.34.1

