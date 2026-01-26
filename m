Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B803D19519
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Jan 2026 20:08:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 42A4E10E3C8;
	Mon, 26 Jan 2026 20:08:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yRjOdGYG";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012032.outbound.protection.outlook.com [40.107.209.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 726CF10E258
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Jan 2026 20:08:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yKXvtaJbGYq8CPZihNwrJ7+2FdHy29Hpe05pt87ERLbUa0cmts+jfeOKXsx2hKXrOVz3VXjiQpPgRfNkOBm8LBOPpSzT6WCHfF/g7GcS3s30VBHDdF3Fum9UlCF3g1E9HY0boVNT6X9J6+riUFD/yhNNQleuXEX0DngRAhK61isdjpXXiFmgiJ9G339IXPZYVsIDbpeiinDFnq5fcsaYxpdZJk0nLNMZNdmfCNwyxWKEOr9u0dH0bnci08IBtvZnZF6/hpN3GXFaoz35UuGCM78JNWGK3Gp83NiRaO5wQWmqIo9wTgSQKgZiUAaMhuMoM9vjkfab3KlN+Nx1ZIUH2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UufTiMceoaxGYDzUM30bszKLQeWrFgT/SlZ+hFrUV7E=;
 b=iBktwBrmUtQWlCcIFU6Fv6JE6GjcbfRpbE6S0ChB03O9+KPpGv+Ra6HbGST2F4+lQjh2hpV7QnZ7iREThsz/7cK3DTuKB7T2+MCqKAx7PDEb9EpLI98dYAsC4Kxj/oyKti5/6H0PExa1A8jmxGCOItVb3glqJwwDqZnnKp87xFvtaLK3AtclXFk8WlcOmjioA40gzG1TrwKX0ZtELUGlgwGAAk1YcsauRajJUXly5ebyBC9AgFNpcSooytaiuT2P4vqdvvJkyL52SwZDoXSq2OP15hPYfa/KV2uMSQ4HnY8ImZNkh8AFDY2LlPlHSp2p4M4eVfSC2OfsrrvLKQz/Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UufTiMceoaxGYDzUM30bszKLQeWrFgT/SlZ+hFrUV7E=;
 b=yRjOdGYGSNZN2YyBJsRdbL/eEAGi9WoVeMCFw9rlTX5eVs43JdTEFm792lLFYeXZ0/aoQ8U4i/pJwoCBViRmciPJV89t5Mg/HcFfNv/dQkAPN3m45iBovUy6Vu+wtrnCepf3TWw1QYke4L2k9QBz+2T/R6jn8UIn2WzkW7IUx0o=
Received: from BY3PR03CA0028.namprd03.prod.outlook.com (2603:10b6:a03:39a::33)
 by DS0PR12MB8344.namprd12.prod.outlook.com (2603:10b6:8:fe::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.15; Mon, 26 Jan 2026 20:07:58 +0000
Received: from SJ5PEPF000001EF.namprd05.prod.outlook.com
 (2603:10b6:a03:39a:cafe::63) by BY3PR03CA0028.outlook.office365.com
 (2603:10b6:a03:39a::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.16 via Frontend Transport; Mon,
 26 Jan 2026 20:07:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001EF.mail.protection.outlook.com (10.167.242.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Mon, 26 Jan 2026 20:07:58 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 26 Jan
 2026 14:07:57 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 26 Jan 2026 14:07:57 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Yifan Zhang
 <yifan1.zhang@amd.com>
Subject: [PATCH 03/12] drm/amdgpu/gfx10: handle gfxoff in interrupt set
 functions
Date: Mon, 26 Jan 2026 15:07:38 -0500
Message-ID: <20260126200747.13527-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260126200747.13527-1-alexander.deucher@amd.com>
References: <20260126200747.13527-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EF:EE_|DS0PR12MB8344:EE_
X-MS-Office365-Filtering-Correlation-Id: 496190f9-a342-4738-5914-08de5d1699b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wFGlL4lUqAvYZepTiD6pHk3DMwqVKpTakkLBTe29EGTBADeNPq8hkon+y06T?=
 =?us-ascii?Q?m29jiofDCtvdprbmfK9WZhB/E4r/jikSWObcfqeImPlc2ifnAQ9iWkW5tqhy?=
 =?us-ascii?Q?zaaWWY/dgOFUWufjhH59+U68eE8G95aGUUph95HUTHl+4eNvgFepAsm7J+T+?=
 =?us-ascii?Q?oDBfnNpHJd2dtVQeykj1O4yYvrfxHztGXC+u/l5XKgHrBN4Kn0sZXigTxPqH?=
 =?us-ascii?Q?hLzKPA+g+cwfGwPpdYC1feYlG7TW4l/+T4seQMqJ/KZQ3msjIunIfs49K4Kc?=
 =?us-ascii?Q?GCRLrkH0hLAcjYEKGGoiLbbQJ6Xxo7U/OCv12auv4t/rkom6v9EOSnsRMfHa?=
 =?us-ascii?Q?jvCnbbhQf3hzEKCagYXllMyGA0bcmz7lFEvZGX/uPIoKI64/4KAwTzr8Q+vX?=
 =?us-ascii?Q?7xwWs4Oqa17fAXNFh/TmMC5XZ63PICjmj8goyWB+MpMRtVTjzWKAzqW9I0+s?=
 =?us-ascii?Q?U8lVysaBKTj8hiJyoesc636Y2R5q5IzfvNRWwOQ55L7YH43Gl9ep9mT0P81A?=
 =?us-ascii?Q?1Uwq3zB7YSiFDEeIBFgJQ8Z2O9BuGG4Ag9Ug3znzUL1+wUShuSOIa8Y1UXur?=
 =?us-ascii?Q?3XqRLKiLYpFedYZ3dzuznwpAEtJui15lwOzXgGfja2MA+tDOWvwb8leRcm+N?=
 =?us-ascii?Q?FBzkR1AYpoEX+4yN7eGaMAB7Fddzkdh3fKTfCFV1ZXN7F9dcuQe/cAMbbu0I?=
 =?us-ascii?Q?bHiojFENPa6QfUfV6E6BHe5mLoV1CpwfHNqqJ0Ez8GGsTLDT0k6Vsaa0iGYd?=
 =?us-ascii?Q?+j9Xo3WGHZtjCc9+/h29gzWEOVGAUE+czjAdhlMQv0b5qnXDEq7+Q+E+j/sk?=
 =?us-ascii?Q?+Ah+cyzlgMKSJgcbRAEv70+llV0+0Hri7cTRX8yLwoJpPx/BOuQoVgFAu8Ca?=
 =?us-ascii?Q?FNGvSLGELH+RwnVnHDuDIVEnqpK07V0139jqL1yIJesNgLH7qU1yJ2TkLcl/?=
 =?us-ascii?Q?NFsBaWWAaXD3ffehoZoDzB1V36zO/H10j6Cvytudu0V23tfK8R1VRmQiU0B2?=
 =?us-ascii?Q?d7BQTNkjsx9lbpUGeYxg3WvDt0jgoDR6EEDy5l5WWw5kNy8kWstEAVHe3PIq?=
 =?us-ascii?Q?LrBuxxHy/0EgvRxevhlA5o3sJTTAYXrxvt6qAPU0gLc3eik6kW1UHHVzXFDE?=
 =?us-ascii?Q?DYXhEMxrlLWWlFDrIjkLlilviY8apBBO3uW0gCHb6Z3yoTUEKD3wqammQU92?=
 =?us-ascii?Q?aImsibtCN17fIdCIvUoANR4K6aARLYF3fkyc0jMtkafVxGoPxwrPaM3YsKYT?=
 =?us-ascii?Q?NrIxiX418zOAsreuYlrsTSeOyyN8nF9XSMvD7UTo0KgWxsLLflPH1nu1w3UZ?=
 =?us-ascii?Q?jX5WWuDOOPtCyD3/xUn7mKCOGZ3nwnYXAwCcDuCS1C+d1yTdA2ALrbu/hb3s?=
 =?us-ascii?Q?7zOSKvL5HPPy/wIusq90Z0bbUft/TCEmdX/tMPxuXyU9mJzH3/veR8V9ItGX?=
 =?us-ascii?Q?eKf1ZODm6ABduaWj4GSaySPz5eTDW/pY6d4v7SPOosq9T3chaBIfDMisSdZn?=
 =?us-ascii?Q?rBJvqa2F+wHAnjhX888fQJYJfyuWcXK5Df0gBSc3SGImmucS8lvqrvZqZfRl?=
 =?us-ascii?Q?QF7ibmjEw9GDiENj/Q4pwJdH0chlXSICKngMoUNqgNJdLS3u2c8qbTQUY69L?=
 =?us-ascii?Q?NdD6hssx0Nmfla71+fb+3Il6VJYFDI8q5POQChAFP18VrZByISHmttbtrDq8?=
 =?us-ascii?Q?v3Eekw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 20:07:58.1553 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 496190f9-a342-4738-5914-08de5d1699b5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001EF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8344
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

Need to make sure gfxoff is disallowed when we touch GC
registers over MMIO.

Cc: Yifan Zhang <yifan1.zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 496121bdc1de1..31dd0aeef509d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -9141,6 +9141,7 @@ static int gfx_v10_0_set_eop_interrupt_state(struct amdgpu_device *adev,
 					    unsigned int type,
 					    enum amdgpu_interrupt_state state)
 {
+	amdgpu_gfx_off_ctrl(adev, false);
 	switch (type) {
 	case AMDGPU_CP_IRQ_GFX_ME0_PIPE0_EOP:
 		gfx_v10_0_set_gfx_eop_interrupt_state(adev, 0, 0, state);
@@ -9175,6 +9176,8 @@ static int gfx_v10_0_set_eop_interrupt_state(struct amdgpu_device *adev,
 	default:
 		break;
 	}
+	amdgpu_gfx_off_ctrl(adev, true);
+
 	return 0;
 }
 
@@ -9226,6 +9229,7 @@ static int gfx_v10_0_set_priv_reg_fault_state(struct amdgpu_device *adev,
 	u32 cp_int_cntl_reg, cp_int_cntl;
 	int i, j;
 
+	amdgpu_gfx_off_ctrl(adev, false);
 	switch (state) {
 	case AMDGPU_IRQ_STATE_DISABLE:
 	case AMDGPU_IRQ_STATE_ENABLE:
@@ -9260,6 +9264,7 @@ static int gfx_v10_0_set_priv_reg_fault_state(struct amdgpu_device *adev,
 	default:
 		break;
 	}
+	amdgpu_gfx_off_ctrl(adev, true);
 
 	return 0;
 }
@@ -9272,6 +9277,7 @@ static int gfx_v10_0_set_bad_op_fault_state(struct amdgpu_device *adev,
 	u32 cp_int_cntl_reg, cp_int_cntl;
 	int i, j;
 
+	amdgpu_gfx_off_ctrl(adev, false);
 	switch (state) {
 	case AMDGPU_IRQ_STATE_DISABLE:
 	case AMDGPU_IRQ_STATE_ENABLE:
@@ -9306,6 +9312,8 @@ static int gfx_v10_0_set_bad_op_fault_state(struct amdgpu_device *adev,
 	default:
 		break;
 	}
+	amdgpu_gfx_off_ctrl(adev, true);
+
 	return 0;
 }
 
@@ -9317,6 +9325,7 @@ static int gfx_v10_0_set_priv_inst_fault_state(struct amdgpu_device *adev,
 	u32 cp_int_cntl_reg, cp_int_cntl;
 	int i, j;
 
+	amdgpu_gfx_off_ctrl(adev, false);
 	switch (state) {
 	case AMDGPU_IRQ_STATE_DISABLE:
 	case AMDGPU_IRQ_STATE_ENABLE:
@@ -9337,6 +9346,7 @@ static int gfx_v10_0_set_priv_inst_fault_state(struct amdgpu_device *adev,
 	default:
 		break;
 	}
+	amdgpu_gfx_off_ctrl(adev, true);
 
 	return 0;
 }
@@ -9410,6 +9420,7 @@ static int gfx_v10_0_kiq_set_interrupt_state(struct amdgpu_device *adev,
 	uint32_t tmp, target;
 	struct amdgpu_ring *ring = &(adev->gfx.kiq[0].ring);
 
+	amdgpu_gfx_off_ctrl(adev, false);
 	if (ring->me == 1)
 		target = SOC15_REG_OFFSET(GC, 0, mmCP_ME1_PIPE0_INT_CNTL);
 	else
@@ -9444,6 +9455,8 @@ static int gfx_v10_0_kiq_set_interrupt_state(struct amdgpu_device *adev,
 		BUG(); /* kiq only support GENERIC2_INT now */
 		break;
 	}
+	amdgpu_gfx_off_ctrl(adev, true);
+
 	return 0;
 }
 
-- 
2.52.0

