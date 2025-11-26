Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0111D10F50
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Nov 2025 13:29:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 92EBF10E5FF;
	Wed, 26 Nov 2025 13:29:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tmpMjqRG";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010040.outbound.protection.outlook.com [52.101.201.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 89DB010E5FF
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Nov 2025 13:29:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CaV6x3UsXRQmzVJd766Sq7Dwlq8xscws3WRWu7IKrkO4VOJIfamDUBUZdT9l3xrL8NdSKqw31OQ/PHQa9yMyx2cghcbguvBDg3JCjFnRE5s8EiQBJx5WKFoViStmadAqzrpz4L+fNLLYN1g1FvoEJCDQY9XRpIS3WXWYEt49PJuskMjeeYi4cailC+TZwEObZ0mV2q9hJuhYg5gvjPjqgiHbwyW/rjILIimVjTjN6LjvmwaItMgSiF1EKKWp53YPYKrd1Ne3J09YZX0RsuyIWzWn7WEj+3bMUUvgx/5h+tDG8EGIa7k3xQ73mmUxgnppMz8H6p0yRdXfWfwV+MeUyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ttwrLz6zQwsbzoH3ZKvNBpB398/d7dHTH8ouOD3S1UM=;
 b=lYrSkSrNwOb0EuJQgdFt3vcGYBvFJIbwlUPiwnFt0IS1wdFboegQc3gVsqb4M1IxrsqXkqiMSydlkv4DoBwI3e01Ebp0DUdZQCM/SQIrtcPNZERjVJMubzVsrqSZkdCpIFN50o52RFbXbzdOyOKoMIMjjJ+X8ZJ6C4cpIzyYsEb8PjzVGblA0LjVKN9jp6eyzq5StVY81Jrxvl2s25LO9VmKSvm0K7HzyTjStvSMOrUGLQO+zHUe+jHjgovvxCTk29b3SQsguGio2zUYQ2ajQNA8NMH9Q5Ag/BNVgTt2/+bmB8XiUsQV6zn50qdhSUUb4FBvyw2ilEhwIz3+XpWxtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ttwrLz6zQwsbzoH3ZKvNBpB398/d7dHTH8ouOD3S1UM=;
 b=tmpMjqRGQbAGY+Q+hBRzEAxMLrIe8y+uPk018gUyCvJFs2X5H2oVVD3ELIGg+OrLrIpIeRGsgtSZRX+cN+7a1A3iYUYW1w6WpGdxdgrfPr5KCKFnNeEqoxa6Uszb3Tf29B/8HQl8hVDqAshmdW3QuUUTmnCCB7b/s3fzo3YhMhI=
Received: from SJ0P220CA0001.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::7)
 by DM4PR12MB7527.namprd12.prod.outlook.com (2603:10b6:8:111::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.11; Wed, 26 Nov
 2025 13:29:04 +0000
Received: from SJ1PEPF00002313.namprd03.prod.outlook.com
 (2603:10b6:a03:41b:cafe::24) by SJ0P220CA0001.outlook.office365.com
 (2603:10b6:a03:41b::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.12 via Frontend Transport; Wed,
 26 Nov 2025 13:29:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002313.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Wed, 26 Nov 2025 13:29:04 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 26 Nov
 2025 07:29:02 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <Jesse.Zhang@amd.com>
Subject: [PATCH 13/20] drm/amd/pm: Use emit_clk_levels in SMUv14.0.2
Date: Wed, 26 Nov 2025 18:54:00 +0530
Message-ID: <20251126132822.3266730-14-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251126132822.3266730-1-lijo.lazar@amd.com>
References: <20251126132822.3266730-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002313:EE_|DM4PR12MB7527:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ee56393-bacb-42ae-fc01-08de2cefc4bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qhC9cp0xYixeDzGNKuboiQisTfrpmagEl/CrCSGClp87bOBNoKopZDbhM3V/?=
 =?us-ascii?Q?YBig4PkMElHCFcf+84lgu5hX+DoCKd2w2oWimjwvBOqExhbPwI2Z0pJE7zEl?=
 =?us-ascii?Q?Kn9mhTJZNopOYiJBsTFUWJHsDYJ63W7qf1YyspY+JVns3YROuubTLb2Yd0t9?=
 =?us-ascii?Q?D4Ff1nJwH2WSoLPVNoP/cWEZ3iFOWIU+zCnR6EsGp+RUwNcwhOGGh9LnFads?=
 =?us-ascii?Q?afZ5eO1ugBSWzwcTCODsg0z0xGJ77jQaUycGKjvQfePujptXrJGNMBSqsMml?=
 =?us-ascii?Q?0gJjCQc41EFLOWXbz3hKF8E6XCV5AWCg17iSAj65DLe6WOJF256t5oaumlTa?=
 =?us-ascii?Q?LOC9NVPZP5vh1mO6u17jN4Uatr3c2cnN3fNXDNf3jmXIKZ59cMpjIo8eJRmi?=
 =?us-ascii?Q?z0nEIvwmENVAOzdJRT+3lezL0iwieit80oP2fhhxO4MEy70DnWGxPpgzz/nH?=
 =?us-ascii?Q?u6ddzm4VAFOYZsefJ5Th2V/FRLnfuyV+IAxhpbu2n9HcvZ/7OtM2y1b2MFDv?=
 =?us-ascii?Q?BXZ4y0vv5YfmdLzC4Se8YAU2T67k6iN1YKd9glA7p0PljA/7TD0ajOE+bJaQ?=
 =?us-ascii?Q?tUSkr9xe/QP404nLNqDlU6TwTUZ600C8oWwEyTTTpA7mGqamTdbjcaKsyW+Q?=
 =?us-ascii?Q?R2V+Ain2JFE6WE7ZAXMKu0K2X5HJYhE9cnJ0OyN2VP1SpAxWow8ZE4vcCK/m?=
 =?us-ascii?Q?QfwUp/ZTaBpACnW2RFui/mDfMDxvyWED4L3y+e+CxWCHxOg2KyHFEZ9lri0j?=
 =?us-ascii?Q?Rt3vm265t7RlRKy88TBvyKyIOJaWnABBCkwgy5PXY7rkDij2qJBX+FiXdWke?=
 =?us-ascii?Q?k4DyM+tq7Rg0yS6ukxVfxYcbEYEmTUJvCNViZXU9l3ys5UwNMHRoMsoYID3l?=
 =?us-ascii?Q?4VmJ/IBwoU1fISD/5vElW8ivuqL0/LHUaMHgedJ4U92Pl8ianobmqO0vlosy?=
 =?us-ascii?Q?r27IMjGQeCSuNXRCtehsWADEZ8p/710DOImcQwRndCr+x8okFmmkBQlrzIZS?=
 =?us-ascii?Q?fBs4RfUbgLnn/5Dt7QTkThu1eZncp8yYdLoZkT1ovt6PDkz81Gb96o+1crp5?=
 =?us-ascii?Q?ZyuD2N9cdBJHnlUDjWfSUtIaFpLBk6yBKmCKiPk7ZHhK7FtL8vdHgyEnUD6i?=
 =?us-ascii?Q?0vcs9IaWOx3yPjZbQGqjnuq3R7zj7PQ9S854libVEh2e+MCJBP56/ffe0R1o?=
 =?us-ascii?Q?EOd9ayqic5GO5Q9PXBAqFB97JmA4zYn1IRgh0SA0Xy0sUCM4d05SIkYTx2Qk?=
 =?us-ascii?Q?0soUD6jS8Hi1JarpHp9a/X5OFLjpiRlc+3xTosxzX2zLT+KIoKAuYWpKNd9t?=
 =?us-ascii?Q?O6tCwraFNLCps0qUw8mBrzb78Vd0Mp0CuRaCkd+AvAyeHyI59CU6fitV+NQ7?=
 =?us-ascii?Q?P+hYZtN8Bbf9ThZUTQgE0F7T+iFLpctMoF3AcMDM72rFWc07LGjZCYRoAsFj?=
 =?us-ascii?Q?Zt5cL67lkB4/HM8QWlUlWKMqlzqPFxT0ePGLrLbYlbRu3NM77Wag70uzklPE?=
 =?us-ascii?Q?7y7p/3odx9SpDFssyjuPafkOUCw1+diZ21wF1Y5Owhyzizrv0tCPzQW7SSU+?=
 =?us-ascii?Q?5pIL3qvbgbXe9qZxNsE=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2025 13:29:04.1913 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ee56393-bacb-42ae-fc01-08de2cefc4bd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002313.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7527
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

Move to emit_clk_levels from print_clk_levels

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c  | 21 +++++++++----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
index 2cea688c604f..ab57bb2e5dcf 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
@@ -1045,9 +1045,9 @@ static void smu_v14_0_2_get_od_setting_limits(struct smu_context *smu,
 		*max = od_max_setting;
 }
 
-static int smu_v14_0_2_print_clk_levels(struct smu_context *smu,
-					enum smu_clk_type clk_type,
-					char *buf)
+static int smu_v14_0_2_emit_clk_levels(struct smu_context *smu,
+				       enum smu_clk_type clk_type, char *buf,
+				       int *offset)
 {
 	struct smu_dpm_context *smu_dpm = &smu->smu_dpm;
 	struct smu_14_0_dpm_context *dpm_context = smu_dpm->dpm_context;
@@ -1056,16 +1056,13 @@ static int smu_v14_0_2_print_clk_levels(struct smu_context *smu,
 	struct smu_14_0_dpm_table *single_dpm_table;
 	struct smu_14_0_pcie_table *pcie_table;
 	uint32_t gen_speed, lane_width;
-	int i, curr_freq, size = 0, start_offset = 0;
+	int i, curr_freq, size = *offset, start_offset = *offset;
 	int32_t min_value, max_value;
 	int ret = 0;
 
-	smu_cmn_get_sysfs_buf(&buf, &size);
-	start_offset = size;
-
 	if (amdgpu_ras_intr_triggered()) {
-		size += sysfs_emit_at(buf, size, "unavailable\n");
-		return size - start_offset;
+		sysfs_emit_at(buf, size, "unavailable\n");
+		return -EBUSY;
 	}
 
 	switch (clk_type) {
@@ -1375,7 +1372,9 @@ static int smu_v14_0_2_print_clk_levels(struct smu_context *smu,
 		break;
 	}
 
-	return size - start_offset;
+	*offset += size - start_offset;
+
+	return 0;
 }
 
 static int smu_v14_0_2_force_clk_levels(struct smu_context *smu,
@@ -2873,7 +2872,7 @@ static const struct pptable_funcs smu_v14_0_2_ppt_funcs = {
 	.get_vbios_bootup_values = smu_v14_0_get_vbios_bootup_values,
 	.read_sensor = smu_v14_0_2_read_sensor,
 	.feature_is_enabled = smu_cmn_feature_is_enabled,
-	.print_clk_levels = smu_v14_0_2_print_clk_levels,
+	.emit_clk_levels = smu_v14_0_2_emit_clk_levels,
 	.force_clk_levels = smu_v14_0_2_force_clk_levels,
 	.update_pcie_parameters = smu_v14_0_2_update_pcie_parameters,
 	.get_thermal_temperature_range = smu_v14_0_2_get_thermal_temperature_range,
-- 
2.49.0

