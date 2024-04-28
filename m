Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9705DC4345F
	for <amd-gfx@archiver.kernel.org>; Sun, 28 Apr 2024 09:55:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E813B10FA52;
	Sun, 28 Apr 2024 09:55:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oKhGnnRD";
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2072.outbound.protection.outlook.com [40.107.102.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0453810FA52
 for <amd-gfx@lists.freedesktop.org>; Sun, 28 Apr 2024 09:55:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m5nW/wnXl8CJKoOdumca5fWLHRUS+9CYhE4pYR9qXr0WnpRUdaoCzfl03Ei3lfVPj/6DlFg/7S+c1PWYouFiDLIKbMxsxftseMWAJOWhiyauCkGcBBZWcdccQj5XeTLlWQG1Ex42ydbxk2YSXHy/5h7rN3Q2uHgzw58/FvpWccqcHPGg3R6XKo/MlaHQCZlU1liCDEdhIIVOryVL2q2ypEkMZJvEQ/ynJwINNQ+iJSxxa9biRlPnaMbhStlrBZ67Lrd+HMtzQv1HwpQxiiHnfaGWo9zX3TDMZrik0AhLPVFHwPpJnUGA978dtnzJSo2vrAePfeO4K9cnMVs3LFkb6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t12xjiVHRsKj40fNAa7KxrYaTGLFlFfkhIeb7s89g0o=;
 b=FnWTfHij8ULwZHQzQ3hOqmwCVIAWnpmwpCiew55cHzBWAm1lf7wKFRZ1Dji+zFgq9rBxn1h1LsrtXhF0KhMCSTm+qo7NLzMezwfTWyBYaR6dUhNhYO56O2E7VFFkaxc1L1abjPF/IrMmc4qLJ6P5O7kbcxLxiqV7pS/SoJd5JbBON9FjdOK0WFfWCU5cfALmIFAhsGVNjpV3ozlhyyU0Ys3sgNDFpnnPJyAxJd9G5UJeOilHWAfQIP+NbFKL9DBxIun3y8eKNKALH9Vi7Oj0+cm8tJJ8mrov7gGD7rs69dSt1YgWX6OKMkjhG7lqkCcRlvOfqhvoUGcTsVJxhASKNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t12xjiVHRsKj40fNAa7KxrYaTGLFlFfkhIeb7s89g0o=;
 b=oKhGnnRDAck+HYR2m1bvJpjskCzzfFSl6hUZaf3UVheFb1MHpV0sfgWaT7VgxfG9q50Ct6lgnSlLmprop3ooJcH2b6HC8Hdxu7gYkBAOTgEsUQZa+t71cp0v9lAW3OozpXtl9Vj1/tG5ALxJtuoHI7/pRF4RpoEnOWyTkCI1WiU=
Received: from MN2PR14CA0029.namprd14.prod.outlook.com (2603:10b6:208:23e::34)
 by SJ1PR12MB6026.namprd12.prod.outlook.com (2603:10b6:a03:48b::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.32; Sun, 28 Apr
 2024 09:54:59 +0000
Received: from BL6PEPF00020E65.namprd04.prod.outlook.com
 (2603:10b6:208:23e:cafe::f0) by MN2PR14CA0029.outlook.office365.com
 (2603:10b6:208:23e::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34 via Frontend
 Transport; Sun, 28 Apr 2024 09:54:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E65.mail.protection.outlook.com (10.167.249.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Sun, 28 Apr 2024 09:54:58 +0000
Received: from majun-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Sun, 28 Apr
 2024 04:54:56 -0500
From: Ma Jun <Jun.Ma2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Kenneth.Feng@amd.com>, <Alexander.Deucher@amd.com>,
 <kevinyang.wang@amd.com>, <christian.koenig@amd.com>, Ma Jun
 <Jun.Ma2@amd.com>
Subject: [PATCH 1/2] drm/amdgpu/pm: Fix uninitialized variable agc_btc_response
Date: Sun, 28 Apr 2024 17:54:34 +0800
Message-ID: <20240428095435.126980-1-Jun.Ma2@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E65:EE_|SJ1PR12MB6026:EE_
X-MS-Office365-Filtering-Correlation-Id: bac73084-f908-4d0d-e022-08dc676943f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|376005|82310400014|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LafHo+jQVbbN40WMivIXu4xnMPA1//GRsVgW608+Al0gxg2MjxufITDEowsf?=
 =?us-ascii?Q?/QEHoFF+MXwGUVr4OueudsLFDmTpgUGLV2iVTy9lIzI1ji4T4yegUZ5iik6D?=
 =?us-ascii?Q?9g9H6LhhzECeCGxfimAZnIWNYrthaCaZRG2r/oDAzXxCAliy15GYcWvgeomW?=
 =?us-ascii?Q?ywL4Xp2t5XlmKsWHKGWa8cQIvf+kCoNyfCbYy3A9PQY0RLOWhnO5afHe3up5?=
 =?us-ascii?Q?HnwL2SD7z8sQ5vOIJZswPNA9GiSoAg1gWEUJhmvBIeVkoesmqaCOH6SpJG+O?=
 =?us-ascii?Q?s6Bhf15Ncyqus0vnczpDTviO+iaof6YfvEmwhBAPKfaNXcZWEcZieqwMGbd6?=
 =?us-ascii?Q?gR+g6qxvjqT+o/cN54gO4HSg/+9ezUqqBXp8seCyhBjAPutbxMB1jQQrodqW?=
 =?us-ascii?Q?iK1eVSHq7QDh35cF3rDkOOva+3dWI393SIbkQHxrqKz+YAzzbp+rSndg+07Q?=
 =?us-ascii?Q?o5J3sBIJ/WjM5vGGTs8sSWkBibJe7gf0wNJ4CbZSPyFCQZGf7pH0wRl6UKbm?=
 =?us-ascii?Q?9rUuBvc771N3OcUk0zRCYbGfNhqcycMdMP17IxDBCW6oy+HRPzYpqwb+k4kV?=
 =?us-ascii?Q?+mK7xsllIP0GJrQcooo96lqLyTGTfg1ukc9XJBwTQOfrSCBvoKE8siVMo+NN?=
 =?us-ascii?Q?R5UVKQaBzWXgBRAmDlKhNem64UGk8EVMiH+4uPkGpO82mW1o4XGM0V4hJ7sQ?=
 =?us-ascii?Q?TrGF1WrhP51V/U2RSgxRfagfudLegQZW2IsERZWjzOD9GgBO2suTMVKRr7hy?=
 =?us-ascii?Q?Y103arFmXwDxUetGFZN/Wqdwu4qFl7BtPfHI3RmWeyUFZfidAUg2wjQb0yEk?=
 =?us-ascii?Q?esUM29V4tN624GvQcWtLwz/r0IiNWb3hkyH29dOo6fZgh0ZNUzcwmCBUj6Wp?=
 =?us-ascii?Q?jKYoUV6br6PKbBoj3lsNy1IySZ29IzRI+USulJ+oaChPVB+L/86Tc6WuKO0a?=
 =?us-ascii?Q?UkfH3kKNjUM0Dc8jo6FUp833i+o2AUq2L2NIT6Me36KBkS/yh9ysMjqUKC49?=
 =?us-ascii?Q?Js/5dgkBpzKMt337rQGy9/bG6aSd9bnLujCZL56WIO2U4WGQIiXX2tO1KNYg?=
 =?us-ascii?Q?UaQpbgYdxs4Jtze2dG4wldLm9smf68JtiTyjNVxTFF3zfFhsgia44kKOWNMo?=
 =?us-ascii?Q?I4MUrE5w+HF2onGyEZ4RTlslaNVslIBUbB2ExFFQcgJZOMTxBFrIkGupBy5P?=
 =?us-ascii?Q?xBn7AfKEyZ5tGn1tWi+Omh483kxQFXuBbLC8kp+9xQFxIJ84HRtG2SK7fi+J?=
 =?us-ascii?Q?mCBBbFViqqYsUIV2+mB7YGoNdoG7gprsWQmglHkDnrKxAXQOaBG+sDh7QCNf?=
 =?us-ascii?Q?b9mQVSfR1RE0C2kOx+p9O7h5kpQodLT9ectdKAAlJHs9JVDu9VypskTA7dXN?=
 =?us-ascii?Q?mWjWV9k=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(82310400014)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2024 09:54:58.8975 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bac73084-f908-4d0d-e022-08dc676943f9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E65.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6026
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

Assign an default value to agc_btc_response in failed case

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
---
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
index 9f5bd998c6bf..74a33b9ace6c 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
@@ -2350,15 +2350,20 @@ static int vega10_acg_enable(struct pp_hwmgr *hwmgr)
 {
 	struct vega10_hwmgr *data = hwmgr->backend;
 	uint32_t agc_btc_response;
+	int ret;
 
 	if (data->smu_features[GNLD_ACG].supported) {
 		if (0 == vega10_enable_smc_features(hwmgr, true,
 					data->smu_features[GNLD_DPM_PREFETCHER].smu_feature_bitmap))
 			data->smu_features[GNLD_DPM_PREFETCHER].enabled = true;
 
-		smum_send_msg_to_smc(hwmgr, PPSMC_MSG_InitializeAcg, NULL);
+		ret = smum_send_msg_to_smc(hwmgr, PPSMC_MSG_InitializeAcg, NULL);
+		if (ret)
+			return ret;
 
-		smum_send_msg_to_smc(hwmgr, PPSMC_MSG_RunAcgBtc, &agc_btc_response);
+		ret = smum_send_msg_to_smc(hwmgr, PPSMC_MSG_RunAcgBtc, &agc_btc_response);
+		if (ret)
+			agc_btc_response = 0;
 
 		if (1 == agc_btc_response) {
 			if (1 == data->acg_loop_state)
-- 
2.34.1

