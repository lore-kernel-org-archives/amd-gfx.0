Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 589F8C0219C
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jan 2025 16:58:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3956A10E421;
	Fri, 31 Jan 2025 16:58:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KuJ9TghV";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2064.outbound.protection.outlook.com [40.107.237.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5EC5010E3C6
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jan 2025 16:58:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oDI6SZrzgKnn+EN23xDF+u/TKwpKkGx5T3qzk9ki95QsYbODQC/RoIG8T3BqSgm6Zmol80VMYAC9y3nJX3gksxhmqpDlbbT/avPDEJFe8RXZH8zP8CSAd4L9T3XlpgX1rPLOElicmMq78VuBmhOJrWp5lVZWZiBAtcSYKHkpKcNpOLgV3kVqI76x0oxFdOZkIhsluo4K+FqLVuNXCf7qLda6FRGjIwdHp3Ny+LquDCSVkUqDFhpVMramef6RkEfRbBIzR9BU7tZtAI6KeubS5GgqInh5iJWEIPw/25z9dv5ahU0IJUz/olRz8Eui7wjpomdKDT1oaoUEsdRshM6e3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T8D2IfZGxUCX6bUZcI0IfTEXuoSZ9Is52ZUkf+QJp5Q=;
 b=OzaKY9Diz6ipfVlcCVRPqelLTa0Pf/OIIHo/QekJELqT9gMmEao0Wlbbo4BWAXLor9O4sEat5sU29xG1AY86ccl7Z2vgPJpnSwJYacxV/C+ibkZct+dpHya1s9Y7oNbw2gBMa40qoX13DeoeaGMSjtlzLCh+JzTyWuV33iBVNZdku+gPQweaSdMJnNSqLxykMu5iR7aNCQ8ryAjF6okHbAQSTZ3h1t39ODjjjbnskaGFjSjf/ESb2KzbTx+ARgWbazbzPJFcoCl3PBLlgIB/S149eX3ITcqf+NC2FBVtkyOAs5PD0LCP7k8qm17vfK9MI4lZlUVYPNghXZJIc9Qmtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T8D2IfZGxUCX6bUZcI0IfTEXuoSZ9Is52ZUkf+QJp5Q=;
 b=KuJ9TghVYx8UsIWlDpDAKNBmNMIEQUIsBl6M5l6/40uX4IWGMdrHoPNFsYbb1rOtcaRP5mdYGSuKw0eSD0J88T1d7rkUYqyjwJZqcXeGbbFLMHkaEXjC/3Cs1dv6BHiW4ALJdCuD3ZNSQn4WQbnYmT8N8fCdsUoANUSQVenbiMs=
Received: from DM6PR05CA0066.namprd05.prod.outlook.com (2603:10b6:5:335::35)
 by MW3PR12MB4362.namprd12.prod.outlook.com (2603:10b6:303:5d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.18; Fri, 31 Jan
 2025 16:58:29 +0000
Received: from DS2PEPF0000343E.namprd02.prod.outlook.com
 (2603:10b6:5:335:cafe::18) by DM6PR05CA0066.outlook.office365.com
 (2603:10b6:5:335::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.20 via Frontend Transport; Fri,
 31 Jan 2025 16:58:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343E.mail.protection.outlook.com (10.167.18.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Fri, 31 Jan 2025 16:58:28 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 31 Jan
 2025 10:58:24 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 42/44] drm/amdgpu/vcn5.0.1: use generic set_power_gating_state
 helper
Date: Fri, 31 Jan 2025 11:57:38 -0500
Message-ID: <20250131165741.1798488-43-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250131165741.1798488-1-alexander.deucher@amd.com>
References: <20250131165741.1798488-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343E:EE_|MW3PR12MB4362:EE_
X-MS-Office365-Filtering-Correlation-Id: bc984b0d-cdd7-4eb7-0cbd-08dd42187c30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Be9MSyqh7a5JBLqVCa0jkTnWOxf5+iLaBRMyvmWFdbpzaoIKFZxpYfA36DUg?=
 =?us-ascii?Q?jkRgyVYFpFHkVfu8/THWsrcFBUK9R6YcVOpdDX81J9RGtmI4oP4jNikhLq/Q?=
 =?us-ascii?Q?9susuw21X08fKqcL4yUVOSFl3dMiOUZwDsSMt22LELnEFF9MQq1SrsSs4OSz?=
 =?us-ascii?Q?NpUH1JV4FcXJ/v5PFvbRLfUOMRMb2PLHXBLtfCpl8fArOnDAZqFxLKjABqKL?=
 =?us-ascii?Q?kYGDKiVrCbuqD2gJjc7PRE/DXqK5tf27NbyiXE8o8UHJJUIVpsKZ2voHned+?=
 =?us-ascii?Q?TJCI3AA5qPPrannvsaK+8BWZJMFKcxg0WzDO0i1pygOYJmdS3luHBxoP6fKI?=
 =?us-ascii?Q?NsLCTWf6k0GDUYS10/QWijGfv/nGf0fVWUciidlDByQpHrgl32+xIwryJj7A?=
 =?us-ascii?Q?h4ulvObJqIj85QScroZj1NlmC5Tv5anSzbEzFe2aRwOhN2JUng0qJsrbSzNr?=
 =?us-ascii?Q?GGdx6AA46NpZGoYnTl3eFJaFHv0u0oRJZQgqN5OBrGJIcc2PoVvs/ztIYnnV?=
 =?us-ascii?Q?TmtEkEmQF0PC57WR0GWOs4VRzat7Ke8zRPpslGSas2mBvpqg1oCEBRGBruur?=
 =?us-ascii?Q?2sk4eM9uSyrBiXJHaPslTSwshQHxg3CUCJsqHaK+/W8nGOpXBInhDOHLuu8M?=
 =?us-ascii?Q?mu2Z9tNmuTog+NNG0IoZRmHOLCEe7vBbRGNXd9Bln/ubhO/cHm67FfLW99TH?=
 =?us-ascii?Q?c0nO2mHZDW8MmudKZ4w6DfeAr0yjOk74IrqSNmGKRXS047JmFnLJx7O5eJX7?=
 =?us-ascii?Q?nHLoFknwSjUgpNXuvLCirjg8RJ+5qIzBqAuXbLAV7uHlRnyS9mhZwgMfFm0I?=
 =?us-ascii?Q?60m8excQQjz7FzAYDrXxS1zwqkRjtq4EqswwHhz5+uAyZavt+hp/SfXQUV/W?=
 =?us-ascii?Q?cpmN3V+EakWP2UhIt9h6HnVgMm5k9zaDVMRXbkibVmNA5sbbAkC1viY5c9Q1?=
 =?us-ascii?Q?Nzh0IHmWK4pjxNHdSx3Z0fuZGPxYF7CiRSzDjckHClcvWnuoMPRoxD0oTiBW?=
 =?us-ascii?Q?4vM4Dlahcdj30wM3MTWvtVnf04qovXafLfLrBvhW/eGCCWlZmbtyFJiK4Hc3?=
 =?us-ascii?Q?9k7GGBtGJGyH+0Sjsf3SfuH21G1EQ7IGrM8xtiWhw4bFlq2YiP/5nkACPfQ0?=
 =?us-ascii?Q?fbL2NqqkYeqAV3t2SKJDxkIthxczLTY56c5gDknxvMzvNwsvYioVwgoWCRSJ?=
 =?us-ascii?Q?u7NAAkeVViEQpVoX7m8Sof54Esv5OQOygEfuSPxwCviB2hkMs4lwn96DcXdJ?=
 =?us-ascii?Q?M+PF4y7xCREamTB+iuDqCbqU7XawdhiI+PKD5nBETAlgTUlcjD1HlQe6BaR+?=
 =?us-ascii?Q?3bVGf/SYC2k+RIsgEHKfQTPLCus5+5+kgyph2Zopgsbizw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2025 16:58:28.5556 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc984b0d-cdd7-4eb7-0cbd-08dd42187c30
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4362
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

No need for an IP specific version.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c | 27 +------------------------
 1 file changed, 1 insertion(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
index 5ef267fde190c..b7e9d4e909d72 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
@@ -42,8 +42,6 @@ static void vcn_v5_0_1_set_unified_ring_funcs(struct amdgpu_device *adev);
 static void vcn_v5_0_1_set_irq_funcs(struct amdgpu_device *adev);
 static int vcn_v5_0_1_set_pg_state(struct amdgpu_vcn_inst *vinst,
 				   enum amd_powergating_state state);
-static int vcn_v5_0_1_set_powergating_state(struct amdgpu_ip_block *ip_block,
-					    enum amd_powergating_state state);
 static void vcn_v5_0_1_unified_ring_set_wptr(struct amdgpu_ring *ring);
 
 /**
@@ -1047,29 +1045,6 @@ static int vcn_v5_0_1_set_pg_state(struct amdgpu_vcn_inst *vinst,
 	return ret;
 }
 
-/**
- * vcn_v5_0_1_set_powergating_state - set VCN block powergating state
- *
- * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
- * @state: power gating state
- *
- * Set VCN block powergating state
- */
-static int vcn_v5_0_1_set_powergating_state(struct amdgpu_ip_block *ip_block,
-					    enum amd_powergating_state state)
-{
-	struct amdgpu_device *adev = ip_block->adev;
-	int ret = 0, i;
-
-	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
-		struct amdgpu_vcn_inst *vinst = &adev->vcn.inst[i];
-
-		ret |= vinst->set_pg_state(vinst, state);
-	}
-
-	return ret;
-}
-
 /**
  * vcn_v5_0_1_process_interrupt - process VCN block interrupt
  *
@@ -1148,7 +1123,7 @@ static const struct amd_ip_funcs vcn_v5_0_1_ip_funcs = {
 	.soft_reset = NULL,
 	.post_soft_reset = NULL,
 	.set_clockgating_state = vcn_v5_0_1_set_clockgating_state,
-	.set_powergating_state = vcn_v5_0_1_set_powergating_state,
+	.set_powergating_state = vcn_set_powergating_state,
 	.dump_ip_state = vcn_v5_0_0_dump_ip_state,
 	.print_ip_state = vcn_v5_0_0_print_ip_state,
 };
-- 
2.48.1

