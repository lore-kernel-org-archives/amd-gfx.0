Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7786CFD318
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Nov 2025 17:05:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5393910E036;
	Mon, 24 Nov 2025 17:05:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QMH7Nk3J";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010053.outbound.protection.outlook.com
 [40.93.198.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A4F810E036
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Nov 2025 17:05:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XkI23wTXBmqTgHHXeKrXkeBMsOaAMnQaiRzsMKLal8gcS3AQGROQDYG/hI2l0hGDJWNfA+AxSIZEXsuBWtK+q6fuv/2VcqzehALj1jRlWqJ8Z+Wt2Pb66qpTDghP0wz3ON8Y7lgE80TKydSaz/NdKEmzDig1C3TYTmmjKSPTftL3CbhmkrWWQcSNwExFrB7NCyyBqg6imxR5iiiHIx8xRqIYtW/ZrW4q1DWst486r6gwjwDgQX9S7LBGIY16GCdkd0dMPml77YFxHHYmQ/tkgSDtJjgkuNX8NEzChJLY5iwYA48IlVl3cBwr3PcTc9wZNpVP0kJwneBDaD7KOxo4qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZDDkMaYFxfFZNggnBxdxbxTfZXh+FCdSZ0JV0m1g1ss=;
 b=TrihmRCUf7j8NTz5QTaTBoIU6oNTDDOwSmrkjyN69O+evwe4YbY7TBHV4qXiCIw42TIUos405jJXRxeaL6DRt5qnO8kumqNGo414UP0WbP4sy1IIL8ciAPesi30+UpMNsXUg5ytizf9xOJ3YgaaO8MJheRiTfGJI8uxl+KU27Wo5dmsePhDNB+5x9lsXg6d41VJn1jOxNpiLSeH+JhhNIgp8rV1Bl0JUeY6dTjSKDV9MSj4Hu1GFHzJRLmwijUDQY9DwVXTj884EUnUITS78waMHqjSGTrla/dWO+GMWkhr2TScev8/xJyQpzRK2jFm0C3pex2kS3l10NvLMDLfPmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZDDkMaYFxfFZNggnBxdxbxTfZXh+FCdSZ0JV0m1g1ss=;
 b=QMH7Nk3JbcKtda06nR56YXK066+Yxr/1ZWs+4O+BM8EZnSHq5qEnCKDIDR4Mv4SXg7ZTJ21q24acOuEY9UDQzQkebHFF9nIhy9rBpaQCZkNLWcnNICnBRTvRLjbQE16WI9tqyeZa6/qK5PwHbX4UPvj2vNckHw49VnSSVP4Wc5s=
Received: from BN9PR03CA0630.namprd03.prod.outlook.com (2603:10b6:408:106::35)
 by DM4PR12MB6399.namprd12.prod.outlook.com (2603:10b6:8:b7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.16; Mon, 24 Nov
 2025 17:05:31 +0000
Received: from BN2PEPF000044A7.namprd04.prod.outlook.com
 (2603:10b6:408:106:cafe::4) by BN9PR03CA0630.outlook.office365.com
 (2603:10b6:408:106::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.17 via Frontend Transport; Mon,
 24 Nov 2025 17:05:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF000044A7.mail.protection.outlook.com (10.167.243.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Mon, 24 Nov 2025 17:05:31 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 24 Nov
 2025 11:05:30 -0600
Received: from tr4.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 24 Nov
 2025 09:05:30 -0800
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu/hubs: cast register values to u64
Date: Mon, 24 Nov 2025 12:05:09 -0500
Message-ID: <20251124170509.450426-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A7:EE_|DM4PR12MB6399:EE_
X-MS-Office365-Filtering-Correlation-Id: 759a5ce5-7d29-4a42-78cb-08de2b7bacb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?S40L+8abh6p7oXUtU2tFd5aEalb8iCWtTkVfFrptGJHHewcJe8ODnmarAxDU?=
 =?us-ascii?Q?GRMyfVamUZEk5RFhmMcT5Ul2EG++k5583zYlkArQMzOkrXaWOCsB4awNi2rr?=
 =?us-ascii?Q?Zz9fDnLQK0107F/Wetg5/WxZ8v1lBB1RBKgH77KkEetsg9ZIHUJZ8tdgjEjc?=
 =?us-ascii?Q?k6L5mpcm2UyVZDp8OJwE5pANn5bVOGkLJWTs8Eu/2B608QI7WvS78FGNBlia?=
 =?us-ascii?Q?jPcW53AmbiRPhL/DP9KffyvWfxUR2JWrvhFaD672RVppsUSJdSOly4BdDEdd?=
 =?us-ascii?Q?H1QlUoggwphdn8sEpNO+mPkMg3R9jorbkywNTaVe6I+6sAu3c8tFB6oq6x15?=
 =?us-ascii?Q?0QA3oug+x+WDqW4zj8Hnf6d74PAGHLkEbDwR6Odjn7P0vBZQZWPqfHHmliWn?=
 =?us-ascii?Q?p2AmP693mhCYfGTL/f3N2u7QGDjyGkCjmXBZgfu0HOXXQvLN+jxj+Zy65Jdz?=
 =?us-ascii?Q?JdTBIrQlfFbcG2EJGooyDf6ek3YfeDMywJCq6kUMxPTt9YfnnqNHDsiZn7Tt?=
 =?us-ascii?Q?onhIXOg2cTR1GBKbVZJsR1KyOMoMoXC9q6g2fGuYMI8y6I//BM1Ale78oZbx?=
 =?us-ascii?Q?4aW4pb9WcnJU60qXXeNTBmFukyvlHz2narFXClN8WyLAVlhzJ7GeFDUwgmTn?=
 =?us-ascii?Q?gxC0qpwwQ1nP+SudSEt+FrQhHvZ6AdTHUSCSD42oqzUxlWon84M1a3tSs8Zu?=
 =?us-ascii?Q?w5/qWk2EpBM5c8o8a8/fX/3nkUf3ctis8bhBnwV0N2T6dOyTOKPNDBgQmQOP?=
 =?us-ascii?Q?6bAz5XCWhNof/ad+/fHY/yHBbR3Zoy7/biu/1QOuU8qMMhwwPWwFP2q540CY?=
 =?us-ascii?Q?D908pRptfz/TEN/olfsucp70Ag3AZ00kOADD6iP6A7SM5DgyO/8zwHE2iugw?=
 =?us-ascii?Q?L0mfGsPjaCHNFvElBA83Tkxdtv1jh5PVtWwrVEMSa3ICnIn2UuK/MW/8nquu?=
 =?us-ascii?Q?xgqbVE86ngDWcnCueRRmbzhsBcI5TiIXlFJjkr99PcRs86NrjpdIlgYlkc+R?=
 =?us-ascii?Q?IFfQAWm40UlabbIIlYuhuHnehfzslUO5gXj+8uwydo4RmvO18yiZu1aC016z?=
 =?us-ascii?Q?NqcWc/4rqmGPTnt3cze9od+fUlhS5Ho1zus4q6CdUKpx0AdnqfS8cCx43grh?=
 =?us-ascii?Q?Cy5RTF3lwvesN+SNuAcyNhtAw0TkUNJHt3z4PQlcAVVhVFSeF/cFut1vOiW7?=
 =?us-ascii?Q?d44Z1/z2JdX++tgylxT5FOWRwnXp1urBK4Q3jafZNUtsBOnrNKQaNBe0v+Cf?=
 =?us-ascii?Q?IZz+N0m5S277PO7DI6R7fPHDkLYOSyN+73G9YXl8veQCHPsP1VDfKba/sdN2?=
 =?us-ascii?Q?eKU4yqBqMAasjURL8eQbYddoBm8jfFVJPl21p9D/8FXDWL5Z3zWt3lqkJR32?=
 =?us-ascii?Q?b0XquhHpWGQlLznNrjYx0ceynlcK1SZclh9S9WzO1kE/uQia3oBGirrpFxHB?=
 =?us-ascii?Q?qVVR2xqkNf+yxN0JTk68ydJ5YwTEQA+XXf7lHTfHVTQgSuX8DD0up4xpJ9F7?=
 =?us-ascii?Q?e4r5B3lI50Xcka671//2TCqf/blZMfVN5aCtm0AzOx2vhwnkPB3ZF0oGKHLC?=
 =?us-ascii?Q?L8BUhMjujTNELju1yiY=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2025 17:05:31.1175 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 759a5ce5-7d29-4a42-78cb-08de2b7bacb3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6399
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

Cast the register value to u64 for the shift.

Fixes: da0020bf6deb ("drm/amdgpu: Add gc v12_1_0 ip headers v4")
Fixes: 3148d9bb913a ("drm/amdgpu: Add initial support for mmhub v4_2")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c | 6 +++---
 drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c
index 4c59da7f2ccb1..ceb7eb562ef0a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_1.c
@@ -45,9 +45,9 @@ static u64 gfxhub_v12_1_get_fb_location(struct amdgpu_device *adev)
 	base &= GCMC_VM_FB_LOCATION_BASE_LO32__FB_BASE_LO32_MASK;
 	base <<= 24;
 
-	base |= ((GCMC_VM_FB_LOCATION_BASE_HI32__FB_BASE_HI1_MASK &
-		  RREG32_SOC15(GC, GET_INST(GC, 0),
-			  regGCMC_VM_FB_LOCATION_BASE_HI32)) << 56);
+	base |= ((u64)(GCMC_VM_FB_LOCATION_BASE_HI32__FB_BASE_HI1_MASK &
+		       RREG32_SOC15(GC, GET_INST(GC, 0),
+				    regGCMC_VM_FB_LOCATION_BASE_HI32)) << 56);
 	return base;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c
index 23f0042125008..24582b8d90ffd 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v4_2_0.c
@@ -81,9 +81,9 @@ static u64 mmhub_v4_2_0_get_fb_location(struct amdgpu_device *adev)
 	base &= MMMC_VM_FB_LOCATION_BASE_LO32__FB_BASE_LO32_MASK;
 	base <<= 24;
 
-	base |= ((MMMC_VM_FB_LOCATION_BASE_HI32__FB_BASE_HI1_MASK &
-		  RREG32_SOC15(MMHUB, GET_INST(MMHUB, 0),
-			       regMMMC_VM_FB_LOCATION_BASE_HI32)) << 56);
+	base |= ((u64)(MMMC_VM_FB_LOCATION_BASE_HI32__FB_BASE_HI1_MASK &
+		       RREG32_SOC15(MMHUB, GET_INST(MMHUB, 0),
+				    regMMMC_VM_FB_LOCATION_BASE_HI32)) << 56);
 
 	return base;
 }
-- 
2.51.1

