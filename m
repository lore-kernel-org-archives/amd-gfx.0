Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0759C02195
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jan 2025 16:58:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B35A10E3E0;
	Fri, 31 Jan 2025 16:58:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="q2tu+wVl";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2047.outbound.protection.outlook.com [40.107.220.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72EDE10E3DC
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jan 2025 16:58:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rc+Q3rs4aSotdXV1hx1DxSeTokkE0m46XqYtbqkA03/NSBTndlgYViARV2eUV9vdFxHu0n8kHxps+13zVuJMBA62W8CHh8LVG3AtMLk8AKQRGz7ysMuziWhXz3WCuGF5ukP5+mg0tiR0UaWkwpuiRMlFKdxSp7kr+Ee/PlNpL6/BmiNGUTiCfrICzvTWrZN1NKO+Jn1rduBvqwPugU0YY6VXYx+0MKRwFvOF4ZK8hbKBbJj1/EORHzVGlb5e0hVl5El2CBOvyAKP9o87xZKQhve708AlS+5NQvgFo6znUf1WvAaqlwIT0+4qVCMqBvVRZKTxhgAGwyinLDg/kf7FVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V8Meid6F0hq4nxH+chpXt6fk7SKNVIRANN2/a+zVfsg=;
 b=xVH7BIZtsXpghZcjU7B21IjJpTmCesU+WTLQlHrnF3knt53FKrDp6EHvBHd6D4BoCXr8q0jLEKOwRxciHCmTMa1U8dzG7czaWkQYZKOelXa07GuSdsq2Qs/6BET53F//PfU8QG7yfjnheGx3d9Pml1Aj8pW3X2HfdLPWYNlAIYB1NXxB2C/pDHTAORUfG758VaZDElhN/SEMJPpdw2CiPATRtfGsF0GDfUJ7KWzTOdUoXL2gr8do/t23ZehCB3mXe65F30HtV/eo09jofFtapNQzFILHo1SQHKwh+Wmk7aeZRfjzMroLo+54nyWMW1WXhbho1g24UgEEzgIx9ZTvDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V8Meid6F0hq4nxH+chpXt6fk7SKNVIRANN2/a+zVfsg=;
 b=q2tu+wVloekJTUjAN5okVu8kIBhZONEsA4MwY+2B9XWTTy2WdTODQ3cCx9PI05A283dZ21a5UFUr/oYdrnRE18+/vZZSADxe/ZDtgL7/Y8ofQ5mzWWBW+iW8DQN0t/e7oHb60ng1XTVULYfKQcd6kLwZdollEgNNCpgcmx9GasM=
Received: from CH5P220CA0008.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::12)
 by CYXPR12MB9425.namprd12.prod.outlook.com (2603:10b6:930:dc::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.18; Fri, 31 Jan
 2025 16:58:25 +0000
Received: from DS2PEPF0000343F.namprd02.prod.outlook.com
 (2603:10b6:610:1ef:cafe::c5) by CH5P220CA0008.outlook.office365.com
 (2603:10b6:610:1ef::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.20 via Frontend Transport; Fri,
 31 Jan 2025 16:58:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343F.mail.protection.outlook.com (10.167.18.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Fri, 31 Jan 2025 16:58:24 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 31 Jan
 2025 10:58:21 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 35/44] drm/amdgpu/vcn2.0: use generic set_power_gating_state
 helper
Date: Fri, 31 Jan 2025 11:57:31 -0500
Message-ID: <20250131165741.1798488-36-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343F:EE_|CYXPR12MB9425:EE_
X-MS-Office365-Filtering-Correlation-Id: 6be6af1e-38db-49c3-e2f9-08dd421879f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?70XwA0vjiHFc5/pUB7+OjSCttigQ635MEyAt2p7gZLMWSOuvW6IUZaE2aL55?=
 =?us-ascii?Q?8lbhf2XO8dNIU8qXKaHJmgtqEvObQaJjb5vkz6rgAoUnmad2D1w5HS6qmt3y?=
 =?us-ascii?Q?rjv5FnzxNMJL7e/EaIFJ1ZKN8IA4OWMNHmptPpnTLMLXD/HTnfYufS7Rq6K7?=
 =?us-ascii?Q?iFNO7+KRXKdhmtEJiC0q2Vus1Ynft9mtwjgi7guKAweqf53mEQ1VHnvx1TFy?=
 =?us-ascii?Q?Q4HzHEupRiM1dwDLXr2mabHEpv7S8QBpIp2je97H6fTRs7d4sTHwaZyb423A?=
 =?us-ascii?Q?OEnTmwn/qXTQVePNmviB+hYjd5eeUX7zG4jeTsMY1PLwAdPQL6vUsCopymfb?=
 =?us-ascii?Q?OhHl+yZ+A86t/XYyVOVyXrWxI68svQgHE0Yy/3HXWyzX/Xz5hS+cXeA00PIs?=
 =?us-ascii?Q?fj95Bo+g8Mk7N/W44hiVQYePZbrqWeBk23ylg5q4WnqBFqdd0GIjFA04jbVO?=
 =?us-ascii?Q?nJMsQcsibS0otBPq7zTefU2qcxYRtSHik4gpkjoFU67tA2vZHrfOveuMtaCU?=
 =?us-ascii?Q?61k3T2iNVeCdnYkTrV5Ee2aK1xT5M0I+xeznQLIPmZxPUzRXd90gsNWDirlp?=
 =?us-ascii?Q?ceLRiZW9Xj40swRKjzonsVom54pjMk9xPHUZv5QkxlQM0oIoK07oHJR0xWhU?=
 =?us-ascii?Q?kIUE2PadHnwHPjcWjgaS+um9z3XlSOO4qufwP8kujksXe4kQ/6R0sjljYO7i?=
 =?us-ascii?Q?xSCwYJ1Eg1+X8BA6C4RKApaa/e2uVc2253OPVN+ueydSjD+kHAO0wOrTkOdp?=
 =?us-ascii?Q?eNiYYoPzZZghZk1gdsvWR5NVQZWFeyzOKiZiTIh+GGPMxXnpZaOZ3Pr9W5EI?=
 =?us-ascii?Q?q57YP5CZDV8QW2ididx+CTDXm1a11pV1gjchyFg0kx3rbpaJkumzR71t/rMS?=
 =?us-ascii?Q?hzkZrhX8vN53jAcTrGW097lY2BKkZEEL5YVpFdCG4Xu4qm7aa5TsNOmmkhqK?=
 =?us-ascii?Q?SNjlEcYqNoKH1aI/5MZxe5tBDzC9fh/FTlYzU/dV04XkrEvlEOSg0igSHdMV?=
 =?us-ascii?Q?kRYzpdTwcVgBo+jroM3Y/VL1QLZ4eOQgTslebJN1Cw7Y9cRiaB4B5z93u/Zk?=
 =?us-ascii?Q?xESw+J9OhBOF87Tt3z39ghVGWz6ylj5uR0+JCN5pow4nwTdzbL+JH2mEwe3o?=
 =?us-ascii?Q?IwUqUJwPjdCUlAfmd2F5vNqU9hDDiEl0OXHO3gnc7ET6MyAXm0udnb0ELqG5?=
 =?us-ascii?Q?G2NPcIoeIOqOgwfru6r6Fp+8udMIuG3Ekd1B5uHUduOmJ3k7Gszlwukg8e+s?=
 =?us-ascii?Q?c/rDHtTXDImDE2lFZ5MK85rsg+hSE3wKuhYjodV2Cegn6cUKYQBNxAHkilSp?=
 =?us-ascii?Q?yMTCkbQNSDTYgCeoeu8UvRUCw0qeKnkCpOhPJL9NsQ7DDcdBCQCKk0N73kIh?=
 =?us-ascii?Q?yeZ2Z2noOAc/q6PEYGv1qBmXbmujeg+QfLxq4sa8GZc/sPVMYvf9yUV1Q4l6?=
 =?us-ascii?Q?tVvHmk3SPuHrMtae+nlaJKaWsrz5Lnvc4eZxfm2maOfwE0TVJfvn8g=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2025 16:58:24.8150 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6be6af1e-38db-49c3-e2f9-08dd421879f2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9425
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
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index ecbf0dd0b6603..5409a8779457f 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -94,8 +94,6 @@ static void vcn_v2_0_set_enc_ring_funcs(struct amdgpu_device *adev);
 static void vcn_v2_0_set_irq_funcs(struct amdgpu_device *adev);
 static int vcn_v2_0_set_pg_state(struct amdgpu_vcn_inst *vinst,
 				 enum amd_powergating_state state);
-static int vcn_v2_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
-				enum amd_powergating_state state);
 static int vcn_v2_0_pause_dpg_mode(struct amdgpu_vcn_inst *vinst,
 				   struct dpg_pause_state *new_state);
 static int vcn_v2_0_start_sriov(struct amdgpu_device *adev);
@@ -1846,15 +1844,6 @@ static int vcn_v2_0_set_pg_state(struct amdgpu_vcn_inst *vinst,
 	return ret;
 }
 
-static int vcn_v2_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
-					  enum amd_powergating_state state)
-{
-	struct amdgpu_device *adev = ip_block->adev;
-	struct amdgpu_vcn_inst *vinst = adev->vcn.inst;
-
-	return vinst->set_pg_state(vinst, state);
-}
-
 static int vcn_v2_0_start_mmsch(struct amdgpu_device *adev,
 				struct amdgpu_mm_table *table)
 {
@@ -2132,7 +2121,7 @@ static const struct amd_ip_funcs vcn_v2_0_ip_funcs = {
 	.is_idle = vcn_v2_0_is_idle,
 	.wait_for_idle = vcn_v2_0_wait_for_idle,
 	.set_clockgating_state = vcn_v2_0_set_clockgating_state,
-	.set_powergating_state = vcn_v2_0_set_powergating_state,
+	.set_powergating_state = vcn_set_powergating_state,
 	.dump_ip_state = vcn_v2_0_dump_ip_state,
 	.print_ip_state = vcn_v2_0_print_ip_state,
 };
-- 
2.48.1

