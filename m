Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0BD6C54FB3
	for <amd-gfx@archiver.kernel.org>; Thu, 29 May 2025 20:08:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B47410E788;
	Thu, 29 May 2025 20:08:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SUaOggqf";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2073.outbound.protection.outlook.com [40.107.220.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F037710E76C
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 May 2025 20:08:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LGXpc8me4D9oGVEKn5U0ykqoyPpDr99QSG+fNJgTu6CvdPKw7r2nR5N+iBfIGDpXpaIidnTIWlpMrBlBrXAQ3bFoUMQy7o8R8DTPAovud5saiJe67y9t5sA/OhVj8gZ2hkq6zi5seoFjFYjzryL0ZYYxeZLmEhGO740ZwT8hRRqhewC2FWy4FaSDulq1G04B6qmbgdyAHWE/x4X2fn61R2MFM1zFpcDm3ArUR/WJiWW3nR2eBcRmSXN8EyCTUYOuwQVeC24Rel4N6Kt6dOXg6U1y/OGZaSl2bRihaXmI8v3MvDKLZXETIiK6NcAC6aAUVAPfdGrHpnTQolu+pyTXVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KPnogiG3Yq1w0t9FGmhF1riMEH9fJ9O7clCrYfnDiLQ=;
 b=vOrifPwXeG3Fba+GEB7FpMIREJOE3SgAPEcUNniVV9uvlvzE+GWRuLXzU76Y5NQONQm6tMpylRvAwGxJIGnvPKIQOTJePqVZoFLHZ20G+0dx+mEpWdrr3IDQgMl0FI/f3D4K6ou6WFSJxvmVL0aP7Sv8Nksr0w4Bjbd/gy/6sS31IiZpvZ9H7uXV8uKUnSfSlEdjbY6f0jp077DOK2W5nWIdCXBuc92G29rbd9aBy5gvZtFstw4KDtfdmt+m9INHZn2A6GfWiLwXnXdDkL3sfrzPtcX3o3d8+/h99u2Ma/cuvLP7X0lF6YpdMasU/jvGyVWCLTYpohnlCmXav/gyLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KPnogiG3Yq1w0t9FGmhF1riMEH9fJ9O7clCrYfnDiLQ=;
 b=SUaOggqfPrxxhg0uRAQ2BIjkcUD/isbFF/cr3EB2FZEnho4CQLkVTaQSr6xDRGPEcdV7qHQR0pZsHJm+dWhq8BNe9gfeA38rFwVHeSxAYRSIjfoT/8g5s6KO2cYqJvsUaBQAecaq1P7j5d22gytN5bFgHmivxeJemiKbNLNvSH0=
Received: from MW4P220CA0014.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::19)
 by CH2PR12MB4088.namprd12.prod.outlook.com (2603:10b6:610:a5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.31; Thu, 29 May
 2025 20:08:35 +0000
Received: from SJ1PEPF000026C6.namprd04.prod.outlook.com
 (2603:10b6:303:115:cafe::77) by MW4P220CA0014.outlook.office365.com
 (2603:10b6:303:115::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.19 via Frontend Transport; Thu,
 29 May 2025 20:08:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000026C6.mail.protection.outlook.com (10.167.244.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Thu, 29 May 2025 20:08:35 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 29 May
 2025 15:08:32 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 26/28] drm/amdgpu/vcn4.0.3: re-emit unprocessed state on ring
 reset
Date: Thu, 29 May 2025 16:07:56 -0400
Message-ID: <20250529200758.6326-27-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250529200758.6326-1-alexander.deucher@amd.com>
References: <20250529200758.6326-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C6:EE_|CH2PR12MB4088:EE_
X-MS-Office365-Filtering-Correlation-Id: 065eb965-5631-4283-94bf-08dd9eec97f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BqP7R8xU0HzTK64qwhTzONU8+fJi8l1GBW0Edrq9/PVFMvobPsdXJS5W5yWb?=
 =?us-ascii?Q?gv923tdgirCiLQm5UkRE4Bj2B1YiqbBg5+4yajYUEV9aWjKwV4oc3Yu/JLyJ?=
 =?us-ascii?Q?GLhR8N0tzZiEnkv0Y6eCTDAcuPkQYEE0HZe+lCf56x1+HInGAjPM4vl9l5g9?=
 =?us-ascii?Q?ItihbXgnWwqaKcwW49BFtU/AC2uZoQOC0DzmBdJ3q0o+8A+U0zVf4ZgwBaI+?=
 =?us-ascii?Q?Xl9+d0x1ni4GPnprA8tJOwiWephETIS4CSUcmey85/5x0oB351I+Kd9nIoBY?=
 =?us-ascii?Q?To+qxyMltee4IG3T6cXudaa5mxleFuKnI0WTibezsPpmMK+8DnOYWs9OTJXk?=
 =?us-ascii?Q?OpixUYnOYxeYe01Yr9zH9neMbgXKR7hzhurK76W7clMSZRPazZNay5UAsOqJ?=
 =?us-ascii?Q?qzRrOOLkr75lXBCMJAz6fayCRXqppu3GGLvjYdYZLyZgmV4sdRsrKPkLorsW?=
 =?us-ascii?Q?jAEbpfVtlz/xJ/frLnjuiEaY7CLkbiu101lAR/ZhsH2LegznVAGqMPr/fvLl?=
 =?us-ascii?Q?NlbNqpePxvYf6BhtUwHmdO6Mqz2iCiO9uUezSUbMLvptgR1QTe1QzJmgir2I?=
 =?us-ascii?Q?puLmOmG7zZMBgZ/UaWRhoUqbkkGa8BqXJPeJqqPvb3G6CQce1gG+LRn5G74H?=
 =?us-ascii?Q?ZvNZnUqs2Qu4VtNYyzapvBll0qyuA3IeszuYFiaJM+6MaBnQe8GmP/YBgfke?=
 =?us-ascii?Q?T4UmIeo1Uw7ibsdfXUEDdQp73AaCZyg6TxIhELhc6bPeE3cTBvv0dmWHmmhZ?=
 =?us-ascii?Q?5zuCQUGzuraaenNycIxG6Udm+pA/CCw8pWp/hcRFBRLppRIhAJZd7SZDrZwN?=
 =?us-ascii?Q?7NkAhHSxL5/vIDB4TLG7uXKtJ6Y2UhJmekiVJHm7trIzHKiiHifj1x2c0cxD?=
 =?us-ascii?Q?lW8ksygRGiQnJSgY7QvBNBd6SOVNCxqI8RzDiBefP8x/Fa+v3y35t7sJZYwF?=
 =?us-ascii?Q?Exzub/dJF2aQUUXApOAgm3g3lH7oYtS2wHuMluoAsY/zouidcMxLZaFvQrUN?=
 =?us-ascii?Q?tKgQKz0Zo00tp0BnzaLrtnK2gq3aRnvdlBtXRgnEwS0NhD2xifXdUpc5F7nZ?=
 =?us-ascii?Q?QjBJhjvb1VsGRFSdCni5ZUGDTLsD3Qm8NXeIZtxtvZp7H+l3XbpDNhWVejNO?=
 =?us-ascii?Q?IxxgeCbmTikAD6oLW9eODoUQvcxsF2aTapcD5drdd9bJ6GxKhLT19rx8XT0J?=
 =?us-ascii?Q?+rvKor0l924UbAlioH1knhNqjYpVEWVWB04QgKXzEVS7gkj43Sfhqym71khy?=
 =?us-ascii?Q?iKIDsgmjbrPIHkmGij+OP0LNNVNO5q0tuSGF/aYGX0STXn2POQeNHHSUD2FY?=
 =?us-ascii?Q?TIC7bLmXRkaesHbcxqHhBx3dh+BuQ67SZMaFSjK3Wxi7tTBPVc7/RFvRxDYZ?=
 =?us-ascii?Q?WHjWSAVprB/4SLY7V6lFKhJAspvpXx3kCxXUIYbPqPDA4Yk8TAvSvv/p2QMA?=
 =?us-ascii?Q?fTZzZ/sw2a4lhQZvR7m/1do11vmrg9XLbR5PkjvRCKbJi/FdYxgCzrrCCNSk?=
 =?us-ascii?Q?qpxQuizdYpVF9TbIkDrnbp6PA8yqtRzQkLxw?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2025 20:08:35.4010 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 065eb965-5631-4283-94bf-08dd9eec97f3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4088
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

Re-emit the unprocessed state after resetting the queue.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index 6ef5944584e56..aa0ae2cd65da4 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -1620,8 +1620,8 @@ static int vcn_v4_0_3_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
 		adev->vcn.caps |= AMDGPU_VCN_CAPS(RRMT_ENABLED);
 	vcn_v4_0_3_hw_init_inst(vinst);
 	vcn_v4_0_3_start_dpg_mode(vinst, adev->vcn.inst[ring->me].indirect_sram);
-	amdgpu_fence_driver_force_completion(ring);
-	return amdgpu_ring_test_helper(ring);
+
+	return amdgpu_ring_reemit_unprocessed_jobs(ring);
 }
 
 static const struct amdgpu_ring_funcs vcn_v4_0_3_unified_ring_vm_funcs = {
-- 
2.49.0

