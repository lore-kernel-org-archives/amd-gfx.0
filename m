Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0402AC25B10
	for <amd-gfx@archiver.kernel.org>; Thu,  9 May 2024 09:37:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 324AC10E3D7;
	Thu,  9 May 2024 09:37:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xXXOlMpl";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2061.outbound.protection.outlook.com [40.107.236.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06FAE10E4DD
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 May 2024 09:37:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eLOYnFQffEa/dU0zaEEyTwlZKMZ40AsPfQFgZkS5xlI5CvCosfT+gPnMcu1ct0X1VRe6t3vS7z1CZq/Mw7nfE1xRbNhE6SmlWt6amoSivvJZiG1kM0EvGO+eACkXrnrLy1vEZ3WVQ1RzfcjDSniin3ZWfvWJqXd8p8kkxWkHqoDi3ciZqBz7Cn/krjbCwi09xOpL3VTAcbk+ECGlVrJUj+vxJwkP6N8zD33PKh8rdUka/kALPm91E0nzmJlT3aVEjfuNs302Rb15LJrvi3LT3R0gNj9TziUZpGABvDxf0BfPHiP1Fj5j4DxZlYGBkkUDmB4XWME58reNPF/D+Iuqow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QL27gwzGBXQ1S1JQa7LA7T4Q/5O5Zk0jxlohDmt1Ze0=;
 b=W934F8wdZm/W5lirAOMkimEpR0W/EQn4++giEJ6e6VkXFaxnHe+Un7WPWUO7HtirrM+r1HbZIu7oAqRFAkzcHybx0EGJh46ONFuKt/VrN3r/mWkvOuiPN4o7Jsg1lodJmdUdR+2kltJpWKwhlus54aSziJ19Shm9jQX35YSWHHCA0DVeSF9OErgXRj443KRIVtL5ij2oh9AuK/SiPMStf4ip2OUGPsQrsQCsp6TK+xXI7kQLhrBn0nwBwTvwazynv15zDNDEgsThyybW2GUILbfdhmICILIV67jcEk8tspdmjpGNhTPkNmxS6e20uJCnWirbnUPbSv6TjfQjhEe+rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QL27gwzGBXQ1S1JQa7LA7T4Q/5O5Zk0jxlohDmt1Ze0=;
 b=xXXOlMplO1KhmRY2DWzwVWo+8BDxA1zlVFjY755LIclCeu5udYJOm3TWHbG/S9s8iBGuJ01dOaplbkhBSL1t2tquyiGH81G2MNjC0hr0KLEQrok7t0YGsRoBvboSHGICAhQHPGdXmLeUdTQpgaM9VtxwoDFC0lfqj6I/6lZCZs4=
Received: from BL1PR13CA0428.namprd13.prod.outlook.com (2603:10b6:208:2c3::13)
 by LV3PR12MB9330.namprd12.prod.outlook.com (2603:10b6:408:217::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Thu, 9 May
 2024 09:37:26 +0000
Received: from MN1PEPF0000F0DE.namprd04.prod.outlook.com
 (2603:10b6:208:2c3:cafe::f2) by BL1PR13CA0428.outlook.office365.com
 (2603:10b6:208:2c3::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.45 via Frontend
 Transport; Thu, 9 May 2024 09:37:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0DE.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Thu, 9 May 2024 09:37:25 +0000
Received: from majun-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 9 May
 2024 04:37:23 -0500
From: Ma Jun <Jun.Ma2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Kenneth.Feng@amd.com>, <Alexander.Deucher@amd.com>,
 <kevinyang.wang@amd.com>, <christian.koenig@amd.com>, Ma Jun
 <Jun.Ma2@amd.com>
Subject: [PATCH 1/2] drm/amdgpu/pm: Check input value for power profile
 setting on smu13 and smu14
Date: Thu, 9 May 2024 17:37:04 +0800
Message-ID: <20240509093705.414124-1-Jun.Ma2@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DE:EE_|LV3PR12MB9330:EE_
X-MS-Office365-Filtering-Correlation-Id: 66a2c1f9-9ae8-409c-7277-08dc700ba2e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|36860700004|82310400017|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?F401eLxGnUGSM3fQgpkW69aw55N/Y+8AlLxgwcn05w0l0P5XVDauMWMCzQcK?=
 =?us-ascii?Q?uq7K6eXZugsVdzt4kctbmetsP0BSviURuqulvVi5K1U5T/BGfB9gBMgxKaOg?=
 =?us-ascii?Q?uMZW/+hGyjnu8g6B5BWcpqMdsVSkP5XA03qcahk3NZ2e6pcz395ccrf8ZQyl?=
 =?us-ascii?Q?puU1pdGVydp2Ug52c1AfheLLKORY0Rtnx0iBQPuZToQCgC97dvlPbZ34JS8l?=
 =?us-ascii?Q?bTVJU8Xzk29DGXwMM3xVPyBjwQhsoV4dCDqZVjvW4ZALrGsle3pS8Rawf5kg?=
 =?us-ascii?Q?yjpokfm0w5zqCj5SxpcDYpqivVg03/4vYUhk/5jpmLKgHxBTRDRYqTynhUiO?=
 =?us-ascii?Q?7AHplA6kTnVG+N5XfGGoOwOoRoblAWraGQX9hd/L3prCqzxXTfD7dElzY/TP?=
 =?us-ascii?Q?BFHSKwZP39fVunX8WciDxRUCQDNsHCHSARJ8O4UJk03N4JTO1Chf2tjtb263?=
 =?us-ascii?Q?NbpsTMvxKT/0jZXSaFQjpVv52nUsWmqVtSlWVYDpxBkRJdJAYIlRW+HZ3t74?=
 =?us-ascii?Q?zTLwPmywWCzjn67uRK0tDeW1xY64DWnEz9rBnkEaAAmVtpvpFN1F1M4LLaLe?=
 =?us-ascii?Q?Iu+dZ6264yoaoY+1d60VbrEBw++HAdYFnTJCdegKIDY23bSpwG75VpGR/Y1O?=
 =?us-ascii?Q?tNeoQBmWwxVKKKdycgUl3W4HaZyuc4w7GW1gRbc1EsRD14xHB1wfOGcnMdUJ?=
 =?us-ascii?Q?6heSF2H9Xl4WK79+sIspC8yUHqBHL0uDG21NYpuxHu1nfR57ZhDlb1AY1MRu?=
 =?us-ascii?Q?9FtcguXWBSgUKkZcYrqfi6dB9t26YH0gmopOv542zYmcNQ4v0MBJ3bn0p6mb?=
 =?us-ascii?Q?cPfZqbrxp9hRyZ20CKN8+jOikPk8KXE9q5HhK+F/r2sYjDF28zcFESKA0dy9?=
 =?us-ascii?Q?3gZCy7jyRvlc5edquNwzFGMhkDN348sQD9p2UqUMR4q/QNm7DjAzO6VQvLL1?=
 =?us-ascii?Q?06Sausdo8sQloiyWHaYk4RROPeM8LgqU31ZkWZINWAoq9JFhx7nWKXtoUFMP?=
 =?us-ascii?Q?h4gX4R7moFRHBm+/4v7Wr+/FIYOugxzI4fZZNnUCTb76uZoirwdOc8Zq9tF0?=
 =?us-ascii?Q?dRdYS2FfYav5TOw94TJ9LBVtgyKL+7GQimOITM1ryG2j7RK6xXNlfQL1OxNx?=
 =?us-ascii?Q?siGCLW/HlzKF1JIeLnQ3bqN0H1qFZ+bdouBPPjhwMovnq8I5mx2TPEAtFZ+4?=
 =?us-ascii?Q?TD0Pbf1PU1Hur2hsqOnUkb7JEm16T1dbAifPAfVdv7dLZ2pSDqZ3AolS0TVB?=
 =?us-ascii?Q?UkVPZznx1W0yhr1r6b6cU7FJjb64NqQv+3e2iZmkiES6DH9rL5E0d1n1BKP6?=
 =?us-ascii?Q?5NZ8Oavo4Ic5iTmUGyL03wJjKGXMSr8mO70coAtj6hNd8QxIcRx2ypIjWDFD?=
 =?us-ascii?Q?Zb8zPFE=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(36860700004)(82310400017)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2024 09:37:25.9090 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66a2c1f9-9ae8-409c-7277-08dc700ba2e1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9330
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

Check the input value for CUSTOM profile mode setting on smu13 and
smu14. Otherwise it may cause out-of-bouds read error.

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c | 5 +++++
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c | 4 ++++
 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c | 5 +++++
 3 files changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index e8b01662e164..6c24e2306383 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -2495,6 +2495,9 @@ static int smu_v13_0_0_set_power_profile_mode(struct smu_context *smu,
 	}
 
 	if (smu->power_profile_mode == PP_SMC_POWER_PROFILE_CUSTOM) {
+		if (size != 9)
+			return -EINVAL;
+
 		ret = smu_cmn_update_table(smu,
 					   SMU_TABLE_ACTIVITY_MONITOR_COEFF,
 					   WORKLOAD_PPLIB_CUSTOM_BIT,
@@ -2526,6 +2529,8 @@ static int smu_v13_0_0_set_power_profile_mode(struct smu_context *smu,
 			activity_monitor->Fclk_PD_Data_error_coeff = input[7];
 			activity_monitor->Fclk_PD_Data_error_rate_coeff = input[8];
 			break;
+		default:
+			return -EINVAL;
 		}
 
 		ret = smu_cmn_update_table(smu,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index e996a0a4d33e..4f98869e0284 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -2450,6 +2450,8 @@ static int smu_v13_0_7_set_power_profile_mode(struct smu_context *smu, long *inp
 	}
 
 	if (smu->power_profile_mode == PP_SMC_POWER_PROFILE_CUSTOM) {
+		if (size != 8)
+			return -EINVAL;
 
 		ret = smu_cmn_update_table(smu,
 				       SMU_TABLE_ACTIVITY_MONITOR_COEFF, WORKLOAD_PPLIB_CUSTOM_BIT,
@@ -2478,6 +2480,8 @@ static int smu_v13_0_7_set_power_profile_mode(struct smu_context *smu, long *inp
 			activity_monitor->Fclk_MinActiveFreq = input[6];
 			activity_monitor->Fclk_BoosterFreq = input[7];
 			break;
+		default:
+			return -EINVAL;
 		}
 
 		ret = smu_cmn_update_table(smu,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
index 0d5ad531c764..3f040a4d374e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
@@ -1418,6 +1418,9 @@ static int smu_v14_0_2_set_power_profile_mode(struct smu_context *smu,
 	}
 
 	if (smu->power_profile_mode == PP_SMC_POWER_PROFILE_CUSTOM) {
+		if (size != 9)
+			return -EINVAL;
+
 		ret = smu_cmn_update_table(smu,
 					   SMU_TABLE_ACTIVITY_MONITOR_COEFF,
 					   WORKLOAD_PPLIB_CUSTOM_BIT,
@@ -1449,6 +1452,8 @@ static int smu_v14_0_2_set_power_profile_mode(struct smu_context *smu,
 			activity_monitor->Fclk_PD_Data_error_coeff = input[7];
 			activity_monitor->Fclk_PD_Data_error_rate_coeff = input[8];
 			break;
+		default:
+			return -EINVAL;
 		}
 
 		ret = smu_cmn_update_table(smu,
-- 
2.34.1

