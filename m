Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 615FDC54F32
	for <amd-gfx@archiver.kernel.org>; Wed, 21 May 2025 20:24:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E9C510E74C;
	Wed, 21 May 2025 20:24:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jeEI5wAN";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2067.outbound.protection.outlook.com [40.107.95.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3492810E71D
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 May 2025 20:24:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gnvmt/Nr8quQahHuCV9bKL4qkLkEFf/cGqOOZB+Cw4OLI7oC8hlaJeYKb7Zinrf64+O3MUZ67oqjb592S8bEfnUyOxezGjSHzisrYPlbwhwXYazyR1mKg1tjlVnfBkkkymvJ3a09h5QlxyRO6Vd7qMebv8DhClRMwld8tJ9t5NI3ASCZ1mZa+135hv9gz/3rF/gl/3JfFuG+n/k5W80qADS4yWaW0l4UzMvQ7v+AB7sHZKSueAo+rnoBa3q0Iyxstf3tcDhwD7qMyIGF2R6h+sMzTrVYNd9YkenTXud/a7bQoj/KYdFcbBV8VGCxEJtDlfVOS/BdmSEQv9DicrrybA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J0x8FfOlERiBO4h8y9inta9BLKeGHaaItrrPzHg443o=;
 b=B2dsq4M7YWPuNSA1o0Es4GaQczY9NbhgqJpGiujGJjX7JfaAXBmxIvhKySx+YfBN5Hwc4UFGLvk8fNs5zqyYhZgArQwizaLFT35VYscOnURgpSyTUG1ISo61jkS4aG090OrmWA+401Ap8ACmS4lPaZ6KA3bRxURvldmls+badc9aH8kHowkpYwr3krVWKa+lTHKNfQbVsv7lNigZjvzfbhh6kTBdw7ZyjRfIr5L5Oap0pXNp+8T/nvshceS+vLQFkbcgo7MIBVICr2FmGoTmcBoK5vCmW7uUFqwt6k4G6SGbf4gBynGVcws3wFsHXa8r7qqNYS2UE49CvQCZCHro2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J0x8FfOlERiBO4h8y9inta9BLKeGHaaItrrPzHg443o=;
 b=jeEI5wANLHG0PunHYCr2RCREP1IqtnmXX5YnmzzghiRExbkcMIPHJkiYg2oCZiIU7uPZv+E/1NiWPc5hx2NUacUga1Iv/7pHOKVT/DmpXQ/JCAzdPUUR4M0YVJPzsL2HmA55v7Ng856yTEmfmH5Wh6pEhZ2qvUizStZgTFtprbI=
Received: from SA9PR03CA0029.namprd03.prod.outlook.com (2603:10b6:806:20::34)
 by BL1PR12MB5850.namprd12.prod.outlook.com (2603:10b6:208:395::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.32; Wed, 21 May
 2025 20:24:30 +0000
Received: from SA2PEPF00003AEB.namprd02.prod.outlook.com
 (2603:10b6:806:20:cafe::ca) by SA9PR03CA0029.outlook.office365.com
 (2603:10b6:806:20::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.19 via Frontend Transport; Wed,
 21 May 2025 20:24:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003AEB.mail.protection.outlook.com (10.167.248.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Wed, 21 May 2025 20:24:29 +0000
Received: from david-B650-PG-Lightning.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 21 May 2025 15:24:27 -0500
From: "David (Ming Qiang) Wu" <David.Wu3@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Christian.Koenig@amd.com>
CC: <alexander.deucher@amd.com>, <leo.liu@amd.com>, <sonny.jiang@amd.com>,
 <ruijing.dong@amd.com>
Subject: [PATCH v3 3/9] drm/amdgpu: read back register after written
Date: Wed, 21 May 2025 16:24:08 -0400
Message-ID: <20250521202414.18251-3-David.Wu3@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250521202414.18251-1-David.Wu3@amd.com>
References: <20250521202414.18251-1-David.Wu3@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AEB:EE_|BL1PR12MB5850:EE_
X-MS-Office365-Filtering-Correlation-Id: b4a0b658-ca37-40f2-406f-08dd98a57d80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rpmIPbrfODjss1f+mXwIS2goChpiWTRsl/XNAP+YVvOBKQdR6+I4alkawuM+?=
 =?us-ascii?Q?gpmBjduwew1adbejgF92SQdEycsLuwCUHBbT59sFntkjNZA4wyvpvhY1xFp0?=
 =?us-ascii?Q?ICByjmrfy/Y9Zpwp6P6bgBEOk++9bkM8Iwwnw7l8n989sTuMTT6aXfT/sUHk?=
 =?us-ascii?Q?mmZX0XhXkaQvU4//QVO4UGUsNmQbkLsRNJc3tM+EMZTBLi2jyBt0ChP405U4?=
 =?us-ascii?Q?k4jdtcIIRV37VP1biMB65qmX3SweNukoegqj9jqRXc/Ko2qlEicuAN11jJ+8?=
 =?us-ascii?Q?HRaxpHIINlgA7tiuqMcP+6ZHFFKLEHtc6wBBo4UfB5xPZ43arHZABGDCA+Ks?=
 =?us-ascii?Q?PxA3VjIqW98Ic8jCwgEjqcr3OjRPmBkGC7ypKl9JWKMcfXSYDRXZ//Y62wI9?=
 =?us-ascii?Q?M1+weWm5h4BuHA3MQDC4rTwcWOPev+m3M9iwKYy1hktYIvc+nqt6cXQtwH/g?=
 =?us-ascii?Q?t7Pcx15LwmNwFxq3C/lUfOYN61u/F21wGY/Rwnu8zrk2HFaevVtzu3mVq759?=
 =?us-ascii?Q?c73B3Ikx0oy3SA0kQ2XQ0S22KBWVMuHj6BbyTTb5wy7L76yUtS062LqXOHJ2?=
 =?us-ascii?Q?6eIyH2br/c42qTYE1GsRzYfRWhmaCtbPwlsX4EsbsFLqpHYAv43OlzEzAYJ3?=
 =?us-ascii?Q?ktfYfXy3hrbe8s9Vsjm2A1lxibjnW6+7DZeKOw1dG3XTR0Rpi0tdGqhlv6eZ?=
 =?us-ascii?Q?B853neDffRk/NmDElt+tF4279kSsBcseg0YVeXR08ZbXnyux+9J6xD4hyQR6?=
 =?us-ascii?Q?ofQIRJq79V2rZx0bEAco1fQ948223veJWf8f2u86iNaupbmSRc9zuHMKWfMl?=
 =?us-ascii?Q?fx4zNCmJQL0CS4H3D0TYpFA75AsYMK2JobLrzuvhGmImGlkiWoeJYAm2JelE?=
 =?us-ascii?Q?Ap3KKqnVXVF5dTYzQEldcRAD6K86uzELPUPdtbHfUVnh4hN6CJkW1car2R7u?=
 =?us-ascii?Q?krV7pXUc23AOFVgzmZSEWBQ/7XhCkKdA1RCWWiQ9+koC8W49XJFAzSG7K+D3?=
 =?us-ascii?Q?S5wVdbNJ52GOgX6h/h6Tykfhe2H4QLj6EJ1kLZrGuO403JCJRaZsnIDNjad3?=
 =?us-ascii?Q?cheyZzyr1gYfpq8g9aPdQDmqwlIRt6718wfBQHoR/82aBjG4qC2LIiKfzXeD?=
 =?us-ascii?Q?CcHVlyjnhclfE3R5rl/XIPeF3O8ZO17Gxhm1+i0XhCBFa9qwIw1ZRNQL4wy8?=
 =?us-ascii?Q?utGbVSqtxCP27iiFXUY7iVvN9XtzUcEqFmoU8iMggZz7ztxTPx43PxdzcC9a?=
 =?us-ascii?Q?mKMwRMYQycPb1eFDxQo3NkUCYr7TGPBvJvx+xM8iPWcGCUqFTHW3WnopU5hi?=
 =?us-ascii?Q?0wGS7d0F9p4lgTWa+nifTk5UBWCXXB1XsJkE4IPIVmhcBi/K8TzteAbNp5Tj?=
 =?us-ascii?Q?/p5O5PlTe89InZkJIXhI2QNu05GNIvdxLSb9zpd6EdkvF0uHUwJdsLEzK0N+?=
 =?us-ascii?Q?b1w8FGi/Dzo//Ic3feHN8tYE8iA4N7/MmxWARf9rNeqLDLFRnAsLKeWQNG2q?=
 =?us-ascii?Q?DDjXNh6+YpHqorP/nh2GXuIxYv55eN2CGO8v?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 20:24:29.8323 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4a0b658-ca37-40f2-406f-08dd98a57d80
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AEB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5850
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

The addition of register read-back in VCN v2.5 is intended to prevent
potential race conditions.

Signed-off-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index 3eec1b8feaeea..58b527a6b795f 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -1158,6 +1158,11 @@ static int vcn_v2_5_start_dpg_mode(struct amdgpu_vcn_inst *vinst, bool indirect)
 	WREG32_P(SOC15_REG_OFFSET(VCN, inst_idx, mmUVD_POWER_STATUS),
 		0, ~UVD_POWER_STATUS__STALL_DPG_POWER_UP_MASK);
 
+	/* Keeping one read-back to ensure all register writes are done,
+	 * otherwise it may introduce race conditions.
+	 */
+	RREG32_SOC15(VCN, inst_idx, mmUVD_STATUS);
+
 	return 0;
 }
 
@@ -1343,6 +1348,11 @@ static int vcn_v2_5_start(struct amdgpu_vcn_inst *vinst)
 	WREG32_SOC15(VCN, i, mmUVD_RB_SIZE2, ring->ring_size / 4);
 	fw_shared->multi_queue.encode_lowlatency_queue_mode &= ~FW_QUEUE_RING_RESET;
 
+	/* Keeping one read-back to ensure all register writes are done,
+	 * otherwise it may introduce race conditions.
+	 */
+	RREG32_SOC15(VCN, i, mmUVD_STATUS);
+
 	return 0;
 }
 
@@ -1569,6 +1579,11 @@ static int vcn_v2_5_stop_dpg_mode(struct amdgpu_vcn_inst *vinst)
 	WREG32_P(SOC15_REG_OFFSET(VCN, inst_idx, mmUVD_POWER_STATUS), 0,
 			~UVD_POWER_STATUS__UVD_PG_MODE_MASK);
 
+	/* Keeping one read-back to ensure all register writes are done,
+	 * otherwise it may introduce race conditions.
+	 */
+	RREG32_SOC15(VCN, inst_idx, mmUVD_STATUS);
+
 	return 0;
 }
 
@@ -1635,6 +1650,10 @@ static int vcn_v2_5_stop(struct amdgpu_vcn_inst *vinst)
 		 UVD_POWER_STATUS__UVD_POWER_STATUS_MASK,
 		 ~UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);
 
+	/* Keeping one read-back to ensure all register writes are done,
+	 * otherwise it may introduce race conditions.
+	 */
+	RREG32_SOC15(VCN, i, mmUVD_STATUS);
 done:
 	if (adev->pm.dpm_enabled)
 		amdgpu_dpm_enable_vcn(adev, false, i);
-- 
2.34.1

