Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2AFCE77182
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Dec 2024 22:54:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52D3D10EA04;
	Tue, 10 Dec 2024 22:54:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MicbmmZM";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2048.outbound.protection.outlook.com [40.107.92.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B7AB110E9F2
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Dec 2024 22:54:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EkEI3qnVWAq7oLeTo1UJF1nteaktdCG6/VhiO2xmOkZdlHglChxMxy4a2lgaqZerpI+5MM5oYivA0j1kH/HclM4jYsbgJmoaAuj1Q2/WfZOs9Vs5XQXlR0bzEk/cKp8AJvGFl0oLoM+/PYEbv7tGKEYb3xgWnjgaOyycG96QT4KD+sNva7FXk7aKMmbMRdmSGX9kVLqcwENbgXUhEngtv5rZSOjD21dyAQZRrERaBMwNNlg4lkK5gP4KLp4RFEdlcXqd1/nTdnOu6gcmfMUzWHRNYGHXCUXPETCRoKRT+bwWrCEjcIgTOSedhsE5AaXodq7GRZDD+ygzkH/hdpXV7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hNuggq03ZJGa0ChLKLiTqwOCjcshO6877Qrjc5WPkSg=;
 b=bSKR5HRofTztd7Z0916j2MRIkiwcdacs4khU8rQoT8p4OnIGYKVvD/jcDnP7ZPKHTrT2c/4boyJ8geiMmJb5GJrcTUZTXy/IlgUWTT0qsgE25zeZYFYGuCvMPUiL/yy7HVBg/zjku2yBWGkX2A9D4VUntVH82L0Y3p0uXbxp2UyJq0aAMxlu78v6bCKlPFacN7eoXGnNLYD8Xx8TWX8f14NRBNJ7oWHcyKGAXlpSXaWUyHUBhIzv03idQhvM5ID4hxYIiYRyKz74pC3uWV4JI2BU5IKBdbjNVabtiAIU69U5MEfYkPuhko5dHE7XylfrgmU1NBPU4yZDRKAXXhkqTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hNuggq03ZJGa0ChLKLiTqwOCjcshO6877Qrjc5WPkSg=;
 b=MicbmmZM7wzr6Bb2Pgrmqoy3ze4baellOdN2JXf+xETu3OHt3Jfllfg9fxvghVXIiTsy/WK3rt8QAynValQ/IiXe79TGwLGlriWq8nff/6WHbicfwEFyKQoZJ15HBZf7n5AHTdo0h+e+BMO7Uy7dvB+nq/1vOaxqAcDdpn3Ihqk=
Received: from MN2PR01CA0031.prod.exchangelabs.com (2603:10b6:208:10c::44) by
 SA0PR12MB7073.namprd12.prod.outlook.com (2603:10b6:806:2d5::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.20; Tue, 10 Dec 2024 22:54:17 +0000
Received: from BN2PEPF000055E1.namprd21.prod.outlook.com
 (2603:10b6:208:10c:cafe::f8) by MN2PR01CA0031.outlook.office365.com
 (2603:10b6:208:10c::44) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.14 via Frontend Transport; Tue,
 10 Dec 2024 22:54:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000055E1.mail.protection.outlook.com (10.167.245.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8272.0 via Frontend Transport; Tue, 10 Dec 2024 22:54:17 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 10 Dec
 2024 16:54:13 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 41/48] drm/amdgpu/vcn5.0.0: use generic set_power_gating_state
 helper
Date: Tue, 10 Dec 2024 17:53:30 -0500
Message-ID: <20241210225337.75394-42-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241210225337.75394-1-alexander.deucher@amd.com>
References: <20241210225337.75394-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055E1:EE_|SA0PR12MB7073:EE_
X-MS-Office365-Filtering-Correlation-Id: 4818ee69-fd4c-4250-0fbc-08dd196d938f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?r37X2/hF99rJKhBfGaEOUmw5p5G6lrq9AfukP4mTmflXNMAPLbK68/v92MrB?=
 =?us-ascii?Q?UMzn2ym6w2sTSin/MAXXamxC/NJIbj6k5DwXYPc/suvBonIDy96nEji3h7rW?=
 =?us-ascii?Q?BzR2IUjdp8lFcwiv4Jg9Cjx57/bd4y8Aq3sRDkIwc8njGZCAkniTFtM+3Fcv?=
 =?us-ascii?Q?T0s9hH4ndZFgJhuuu6WYovs9CDXYXfsX/vY3WgiuMGxU1IQBg8iZ5VHYsOm3?=
 =?us-ascii?Q?GJZWvMSYvGAgFNCSRKKJ9RM5GQKwxSKRYnalTmsXcVvY9UmLcErmZ/inuv/R?=
 =?us-ascii?Q?4FhKyPLAn7sIRm/+B1hrF/oTRzCCYjpCv4V6WtOtbZnpOiKtySNNhwGlueaK?=
 =?us-ascii?Q?eSRPriwwCDqKKlqArl/9wU+vmz05jDMQLyiZ6IuiYPNtn0XDtdgN7JtT+nHe?=
 =?us-ascii?Q?QDwgKtlmn9maB3d+a0O9iOp+RKzFBUk0mN8Mae0VlajWIfWy3+oKeDRxD2fg?=
 =?us-ascii?Q?FwwyvoUcu7cdBCC3wDiPNn13oY+bNA1dSqPLID8iKx7f84hcW6jvqcqR27AI?=
 =?us-ascii?Q?cp/mB/QefkPlk9ATG405MXjQ7l8neg8FT//qDLrrwdpoL0G8pwCQSFDN5eqn?=
 =?us-ascii?Q?KkcLacMjR6g1mxKaj3Q0Ajst2iHu3fmK9DKE/iGak+0tH+uRHvijqTbRmjPz?=
 =?us-ascii?Q?RlHjdBzrnn70FzPDYlDEU78N77aglqqE312uyd+dxg2NaBlHaL6SW4d2uWRn?=
 =?us-ascii?Q?BMusBP5c46N0ar1+QgOjjlglQK0TAke93AZJOHLKqpOlMZ3j94MkffUJvjci?=
 =?us-ascii?Q?sYxEcmjFyi+Zbv659rgTYByqqtLOu0P7Kh2BnCaJ1qDVGFrJeB7vUrWwsBQ6?=
 =?us-ascii?Q?9/RQTAHDVmgnIwYUCdvOQNYKb924cCZ0l970es6PTmPUpjJr1NgTJqtThkVD?=
 =?us-ascii?Q?lyPSq53Bj/aexFoaimj/rHX5a3qzZqGzCtuafSH8nXFGWX0Xrw0ye3WusUbt?=
 =?us-ascii?Q?wrNBUbL311EUyILKOxCNpv7P5SDH4DjWsuqdghC+cK8P1t4RGKp5nmBwnlzM?=
 =?us-ascii?Q?ap8+bke0dhDnx1XztjhJ7X0xnTj8CkWZBzWaazsFWO2OiD9Ak7yLs7RCUETh?=
 =?us-ascii?Q?KPgVusLmAxm0DFto9+oTFtzUCVLRQtrflTX/yBT/5ggYSwCMDKjitrmMVb7E?=
 =?us-ascii?Q?9m6nrdj8Lxo50QEMJCdgA1YltqO/RQfMEycVQJFhXrEoY09QuayCylpVbTjd?=
 =?us-ascii?Q?95hAmFvGGBOebLdqBzUnaIhzzohW+XD6TXM3sHrNUv9xSHExVLwXE06pRBsI?=
 =?us-ascii?Q?GEhfPBqeAWu0RI8BxvDPjyjTc9Cre+F1JWb6h7UdI15nBUbUuUEEw2NUtHb6?=
 =?us-ascii?Q?KIXOQ/ZjFHeFv0HO13k7dzTzOGuiEzPtA+ReY9OHEwGc0WiIRb38XpkfXSXX?=
 =?us-ascii?Q?8OtYU8FwzNp7UJIJvJRxQjvKK9+QVqtcUVEYqyjQyhSeWV5VHA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 22:54:17.3607 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4818ee69-fd4c-4250-0fbc-08dd196d938f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055E1.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7073
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
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c | 27 +------------------------
 1 file changed, 1 insertion(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index 9588153079675..4a2854238c618 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -80,8 +80,6 @@ static void vcn_v5_0_0_set_unified_ring_funcs(struct amdgpu_device *adev);
 static void vcn_v5_0_0_set_irq_funcs(struct amdgpu_device *adev);
 static int vcn_v5_0_0_set_pg_state(struct amdgpu_vcn_inst *vinst,
 				   enum amd_powergating_state state);
-static int vcn_v5_0_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
-					    enum amd_powergating_state state);
 static int vcn_v5_0_0_pause_dpg_mode(struct amdgpu_vcn_inst *vinst,
 				     struct dpg_pause_state *new_state);
 static void vcn_v5_0_0_unified_ring_set_wptr(struct amdgpu_ring *ring);
@@ -1319,29 +1317,6 @@ static int vcn_v5_0_0_set_pg_state(struct amdgpu_vcn_inst *vinst,
 	return ret;
 }
 
-/**
- * vcn_v5_0_0_set_powergating_state - set VCN block powergating state
- *
- * @ip_block: amdgpu_ip_block pointer
- * @state: power gating state
- *
- * Set VCN block powergating state
- */
-static int vcn_v5_0_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
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
  * vcn_v5_0_0_process_interrupt - process VCN block interrupt
  *
@@ -1483,7 +1458,7 @@ static const struct amd_ip_funcs vcn_v5_0_0_ip_funcs = {
 	.is_idle = vcn_v5_0_0_is_idle,
 	.wait_for_idle = vcn_v5_0_0_wait_for_idle,
 	.set_clockgating_state = vcn_v5_0_0_set_clockgating_state,
-	.set_powergating_state = vcn_v5_0_0_set_powergating_state,
+	.set_powergating_state = vcn_set_powergating_state,
 	.dump_ip_state = vcn_v5_0_0_dump_ip_state,
 	.print_ip_state = vcn_v5_0_0_print_ip_state,
 };
-- 
2.47.1

