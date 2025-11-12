Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DCF3CCF9E3
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Nov 2025 15:28:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2587310E75C;
	Wed, 12 Nov 2025 15:28:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2uEVZiQf";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013012.outbound.protection.outlook.com
 [40.93.196.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B0DC10E75C
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Nov 2025 15:28:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=flFUYLZ0SOylKKt3jm8HgnEKkQzKIXdgIIGqPzmunlVjqQJ9Z2xkDeBPUOUf8dASXIIzKn0gqP6pT29pbDocevGID0JtnyY2S8TD+FrtaFNViJx3dGz0/ML2hYLnCu1cdsDbfma7py/q9un2dj3u35Lwr6fQZzaO5hnddZLlJwUGsSHiRLd05szFeI1WagKEvJmwSBRNnHg/LbaEuNv8cYuhYYRDMfmKEQBtR2/iN3J/bnU2P1wcfhoiQA8CKcZpo6pUnMVF3oRhFYjM/57MnFBzx2I/v+mGtKGV3XsidMfDGsfpuZ+L7kmlFM9xgFnoNSjIH/4KKopwzg79zoIS3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yn8vGKQb7xC4XT6cyM79meV2L0R+UamMm3hIn8RdMcU=;
 b=V6oweRVBvtIgmCyyVpcSc6sigDvIbTBAvBMoEpMjg+lCQwqXxFsm0ssNTc5sjSym+4LsCYRs8BLJHQFi1FbG6nqBLtOnzQF1XNH/YelirBv0tG2kivzG9tm6sZWJiFFKAUGW/EUJEvepXPuQSLLOmdk6IFuV8x12izuCC3bXzbPeczFe2wI0VQ73cwKUdvIqya4u7hYFgvFDkUNtX+RXUVNxF18ure25vfq9suwmEE/2xlihhHOf2AD/GUZ9L/7K3mK8djhDBjPir8UCy4dGn7Gejqj0Xb/EtYeJDuGjYWSTTgECQFit9DsIEcgBiS/ayeRAIbuxiNNNPAk7RiEdDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yn8vGKQb7xC4XT6cyM79meV2L0R+UamMm3hIn8RdMcU=;
 b=2uEVZiQft5TmMSOlwGXIYuKJgU9CegGCrLbLAGI4+xEB8RZuzuQaMarqymCh97bjs8CaHv4g2tnhlPa4sVLER/GwAp+c11ElgVZxu1SGg1FlZlgRrJDureEJpAtuoIJai4z3FfwsNmqghFSbu+MLVuWKm4EoHfnoLtN2NHfL6c4=
Received: from BYAPR05CA0070.namprd05.prod.outlook.com (2603:10b6:a03:74::47)
 by CH3PR12MB8187.namprd12.prod.outlook.com (2603:10b6:610:125::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Wed, 12 Nov
 2025 15:28:48 +0000
Received: from SJ1PEPF00002314.namprd03.prod.outlook.com
 (2603:10b6:a03:74:cafe::38) by BYAPR05CA0070.outlook.office365.com
 (2603:10b6:a03:74::47) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.15 via Frontend Transport; Wed,
 12 Nov 2025 15:28:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002314.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 15:28:48 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 12 Nov
 2025 07:28:35 -0800
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <lijo.lazar@amd.com>, <hawking.zhang@amd.com>, <le.ma@amd.com>,
 <shiwu.zhang@amd.com>, <alexander.deucher@amd.com>, <asad.kamal@amd.com>,
 <KevinYang.Wang@amd.com>
Subject: [PATCH v2 4/4] drm/amd/pm: Enable system power caps for smu_v13_0_12
Date: Wed, 12 Nov 2025 23:28:15 +0800
Message-ID: <20251112152815.203110-4-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20251112152815.203110-1-asad.kamal@amd.com>
References: <20251112152815.203110-1-asad.kamal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002314:EE_|CH3PR12MB8187:EE_
X-MS-Office365-Filtering-Correlation-Id: e1546d80-a744-442a-cff5-08de22002d4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QQz7vnIsnVZdui/hWRY89Liwz47pB9EZdjgqVYaxlnumeeT1kFVrU/v+CbyA?=
 =?us-ascii?Q?jquK71hX6Gz6hAUlU26tUMydxjjymy1b3ddtV2/zvGKLK6t1XPONHXVEt3gZ?=
 =?us-ascii?Q?TtJUmBA3BLMIuKzVFNLm0d9PhzJtYiWImqXgKMAbNflO/9ZIK7xiecIMeegN?=
 =?us-ascii?Q?rYfXzu+7i1Nzit+0wMiPtjSrlNl6vUz6N+UUufsEYUxjRVT4QAZuBuiSCCws?=
 =?us-ascii?Q?jWAPWEyh1lRXJyBVh2ct3PI3ASyFX5aOqjoc0JMqBr+5An0/dTUcpGy1V6mU?=
 =?us-ascii?Q?GOk5ABf18p9e6CHlCfSZU+IvqxyLeV+bKrmI7cCtIaB1vBSjXIhxBFnKIGVV?=
 =?us-ascii?Q?H1jJHSYU4o5ZZbeljvIJHEKSrQbNy9+T3uy30vOJFyt7oRjh4kd53Kb23vZE?=
 =?us-ascii?Q?vg+6+gY+Y8cJWPjJv3j5kbaOi6u1Xu/bnrRouOyLAnqhrtcLAhQfxAwxaH4k?=
 =?us-ascii?Q?eNMYmIjInh+e45oHEUSc+SNKMrlJrHgrCBN2nfyKkZ1bWI8EoRPMZuZh+uPt?=
 =?us-ascii?Q?HPFMejFJPZfxOUWMlfyEJqagJBJY4IfUglEJcCptZEO8UfxT9mrYoeteJ/FT?=
 =?us-ascii?Q?Y+sNxGvpzTgYkyXqFpcaj15JDwPqlJ0b5sgJQ5R3mwuPayfGJLl6xPKuV0r7?=
 =?us-ascii?Q?lzW00GJR3HKA3lq7xQcZr7BgpgzGDaFw99iXGbOCMljcVuJwqrLxXW3xLNsx?=
 =?us-ascii?Q?TcCjVXh/GI9pZc0r+cI1w38n3li8jTsuNFu5EA3iDWNJxDL56saMxnrvaPZa?=
 =?us-ascii?Q?VHXhTNrcO3F/2O3cPiZHFLCJ1jSJUEuUT1TDJr2FaQxSNZt8CiG92aFuhJvr?=
 =?us-ascii?Q?Hsj/7EGCzefbyyWR1Psqsp/CQQdDg/LQHuq8PU1hMO5pkEt++gKl1XZOO0AO?=
 =?us-ascii?Q?5iIcCxscnuVsRxDdhq1x3HFRVDuN2UKy1itlvDK17B9uz03qXnVCE6ggNAH5?=
 =?us-ascii?Q?ehvduDID/ts0qEIQTWx/YGmDt7sgyIKp5YVmvznm9JEiuVu7sJWNjRS8M/N/?=
 =?us-ascii?Q?qxy7zSkYEdVM+426bwu2/9RU0Crle0b354khs2vh+iJXzOlwjRJ+T04qPRb8?=
 =?us-ascii?Q?iKSCY04MaB/PO9Igajk+vRbuKx6nzI4tXqrpTpSqFIKrzzvWGl1kAen36DGN?=
 =?us-ascii?Q?ffozlCLC8nZlnpU4M73+moUcx+06c+mrUlEV4NcMYYR/6uQGmHKJIcBq5q8R?=
 =?us-ascii?Q?FGWdalJ1WxhHXg4u2+GbrD+ef6DkqNMlqj6NZEzf2kLqi3Fj5dPFsP28sDeq?=
 =?us-ascii?Q?WRDwKv8POGcXViF9HXrMdFhM/oYP5Uk0VXQpI7IKTG1llye+gpiqVQTZjVJ6?=
 =?us-ascii?Q?N8Imx7jNyLxgvJviNZxYVl/nNzf7pV2C36LIh3NIYFWJFFZGFDs3bZKps3hU?=
 =?us-ascii?Q?frYbROmw1OOvMea53eDjF3mGtBh994BHjzsHaMLyLWp1zfS6gM7mGGWNidMV?=
 =?us-ascii?Q?6flf3GrOcW37VKszjpsht77qvRmxXkRFawahUjGtyNcnBXqwTIR+ztDKz8/K?=
 =?us-ascii?Q?KLYFhONZIg6XQkjFZ9CTBl/Z3/jBdFYytsQRsfG2+HShRjCbRErvS5oLkw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 15:28:48.7070 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1546d80-a744-442a-cff5-08de22002d4a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002314.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8187
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

Enable system power caps to fetch system power and threshold for
smu_v13_0_12

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 2fefd258bc0e..a3ceecbe5d68 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -356,8 +356,11 @@ static void smu_v13_0_12_init_caps(struct smu_context *smu)
 	if (fw_ver > 0x04560900)
 		smu_v13_0_6_cap_set(smu, SMU_CAP(VCN_RESET));
 
-	if (fw_ver >= 0x04560D00)
+	if (fw_ver >= 0x04560D00) {
 		smu_v13_0_6_cap_set(smu, SMU_CAP(FAST_PPT));
+		if (smu->adev->gmc.xgmi.physical_node_id == 0)
+			smu_v13_0_6_cap_set(smu, SMU_CAP(SYSTEM_POWER_METRICS));
+	}
 
 	if (fw_ver >= 0x04560700) {
 		if (fw_ver >= 0x04560900) {
-- 
2.46.0

