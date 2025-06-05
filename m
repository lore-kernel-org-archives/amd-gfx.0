Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90541C61CE8
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Jun 2025 01:46:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05B6410E9DA;
	Thu,  5 Jun 2025 01:46:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="w3ssVILP";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2061.outbound.protection.outlook.com [40.107.237.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9227810E9C3
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Jun 2025 01:46:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jnGgAGR10Ga6lKABzhZmd20253xmLyCBnMTnr0He3dXavcd1w/A5BYim7FCNIc1gwZXir9ItlpvSaupnTk4eV1uJuSOTVfW01lugsJgWSCoXFVhbvfXIDIh1N3Oaua0eqXIMmX5adm5cpVV1UKgUnsabvQCu1V3XSR6HIsXJHth59qPnI++FaiX0ewyHiBfYTiwfCnDcFACJLXQo23rF3ZuZQVafl7l3YNN9mxCgZjDS1TXj+CGG2nk8wPagNMVBQqXrl1G3xFeSrCB/+Bs8PWWjV0dx0Jus/uNdFZ08JtjreI3eNKxJ5yi4T2+5Nb2xsxe/QAEE4HFlVErSbrHo6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KPnogiG3Yq1w0t9FGmhF1riMEH9fJ9O7clCrYfnDiLQ=;
 b=nYWaqF4K7sEh8iGZa5igM3LHB5rpJekTOzQSFq/7XvbnukbuCVY2mfBEPG7jDbU3kbbdjKHPt6hM6j52KFkkdKLm7HowAgxFrzq0L46pbQEuZMQvVjli6cI52LGkRNHhu9FytRFtwOmx29XZedyx1GxMoMXCovM41bQfUvOMr5ScaOwZj3Uk5KWMIbUGRnISRLxigw/ibkIlweVee7p/2h+W5tB6+muvBPjSIpijetPLEpjoG9NbZGnJmEgDXmOQkc4XiVTkkF4eN4UUszingZ1BPZdEa0pWklen0/pXyrKnkll6VyUQsnx4GM6wRziVqILI2ueJIKBPGHPodN8rBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KPnogiG3Yq1w0t9FGmhF1riMEH9fJ9O7clCrYfnDiLQ=;
 b=w3ssVILPRwQLBlgFPHeoOss6ap8Ly1tSAtrcJoKX/P+myvAfCDC7ij7BEVq4vsr04IIx5rqCEpDbTj4/SV7KnoW1stFIBbKtMHS9Z/lW7DJIwzye72sebMbt+qH4TmqocdpNRx430FsA84bR9PjY/Kfcni5dS4SOLweXg9qRAgw=
Received: from SJ0PR03CA0139.namprd03.prod.outlook.com (2603:10b6:a03:33c::24)
 by DS0PR12MB8319.namprd12.prod.outlook.com (2603:10b6:8:f7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Thu, 5 Jun
 2025 01:46:37 +0000
Received: from SA2PEPF000015C6.namprd03.prod.outlook.com
 (2603:10b6:a03:33c:cafe::92) by SJ0PR03CA0139.outlook.office365.com
 (2603:10b6:a03:33c::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.24 via Frontend Transport; Thu,
 5 Jun 2025 01:46:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8792.29 via Frontend Transport; Thu, 5 Jun 2025 01:46:37 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 4 Jun
 2025 20:46:33 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 29/31] drm/amdgpu/vcn4.0.3: re-emit unprocessed state on ring
 reset
Date: Wed, 4 Jun 2025 21:45:59 -0400
Message-ID: <20250605014602.5915-30-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250605014602.5915-1-alexander.deucher@amd.com>
References: <20250605014602.5915-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C6:EE_|DS0PR12MB8319:EE_
X-MS-Office365-Filtering-Correlation-Id: 89994ddf-9c0f-4fc7-8da1-08dda3d2cf5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9TWcCLT/cM3OP6YPz71R7BA+tZWzxpvpxxK8jEE4hSfN61gWZ3VOonT983zy?=
 =?us-ascii?Q?i1ZRpqw11fj3/EkhDOZAkuWiPiWG4CJYIi/I85W7H7uSF8qQoVeI6kLEGyTx?=
 =?us-ascii?Q?OwweHIAD3y7Gdctod4A6fN6LFfhG+HioaZnA3QY5Cq8mX0pxMBf0Q/x6R0a7?=
 =?us-ascii?Q?lZVBpZNY9Yb1AUTLD3VGok9U71DcmpywJrZNz8mDocB9avfgyYcvcKzFjEuX?=
 =?us-ascii?Q?THfQFPB2RS2A9MwncJ0r6wtzUbhOCUHBHnve18nRFX/16GtJQsutUjmrGU5U?=
 =?us-ascii?Q?k6iIxUSpPFofOwkcNt+2nx4zakI5RTkOD5d4/poRyxYXeUwnbcj+weiEvduM?=
 =?us-ascii?Q?xV8xm0zkMgSfE1rTsZblQHI7EE9F96Hol6oxIeAFRYwu/lOAi/mvbkuiL0TI?=
 =?us-ascii?Q?84xqvq9ltWqsBD2knwSC2WounfvZqoSyvOeRTD4yN86lfL4lEhxKgvTrdehr?=
 =?us-ascii?Q?Kk/sUeWRs+4mUGRJCL5VKBE1tRpbW+nDgM1csegpTmqPM4GHsdB39p3JWOtq?=
 =?us-ascii?Q?1q/deUo6pgmiqI4nvNgNLJJwx0st+w0ATPYHabCwdCavuEcg3fbWjkc7O9mB?=
 =?us-ascii?Q?C7Ybt6VLRQFpIgNs7WEv4A/X0PfZ+oloJgq6kOEpM+gwfj4lrH6h7WoddWlA?=
 =?us-ascii?Q?6lVa4iSkSmKoxqswDuPE3CuWZZwcDJ0qESnaniIH3EGaNEg4idSXT5KEx4lv?=
 =?us-ascii?Q?ncBWlI135GpvnT5BD6mJeVncn3sgLxsLFbY87ev0HHWQQhHsftOGLH4HWpD2?=
 =?us-ascii?Q?wsalAHwDqdhNgp+ZrOSYNtH1A+PWoSto05f7gFs7ol2KiZZQNI4zZ+YVaYdS?=
 =?us-ascii?Q?Tf5hQMMoG/bXkVKv6Qaa0slYWIo3fQdT9EbBmAEtVtX1nu5gfDxUNapXRghM?=
 =?us-ascii?Q?LpC7vses8E08OqFlJyZ7xKlI0M5RPcTcEDiDzASOajwgOsJJOPpv/GxMtRTu?=
 =?us-ascii?Q?5SA/mEeWctfLOJA+Hsl2uBk5RE5lOUlcK490Q0tgbMCjhqR2d/73CtwEAqb9?=
 =?us-ascii?Q?iE1EL0fVPgjuMkDlQzWSLnuQ56glR47Pt4yBXk5vZLwFuWHaRxtDAr1dVZzS?=
 =?us-ascii?Q?A07GA4EKOboCs+OsU1C0Fh1mD96vwTN2CvocrnhzPUAj/faXSRys0SVq8ygn?=
 =?us-ascii?Q?jpVllTzq8GQLvF4VL8xNc1DL8Hqn2SMXbU5NneWuxS4REk/MQFUz5m9X7tgU?=
 =?us-ascii?Q?z+H5fAVElzihZeTqdEXUgVAHKyCuGY2Bm93mvuJhNl5l5R4LOD9X4rQcAD/f?=
 =?us-ascii?Q?zaghiNmzxAIcbX9O5EmNyJps/GoBzc5eR9xY1i80eoCVrwypwifuymnRYNrq?=
 =?us-ascii?Q?dlmxjQN17IYJJ3ngLltV22cq+JQ7Lgk23oqgC1SLmbJBZYJzcSiBJ6cCYbBa?=
 =?us-ascii?Q?f95xGxm7iX6/LigCNnxNGCFskRqExeiORAKHblHQGtktLO92rzDScWwoWnUX?=
 =?us-ascii?Q?8a/OLd27jEiQUquNTFQrIR8DfQELlk7/z3+9kwivukanKbNb9mTr1GYE1yZ+?=
 =?us-ascii?Q?wIlb2uhg7xig8H9dxc32LSn7VvfN+2xjz/iT?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2025 01:46:37.3147 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89994ddf-9c0f-4fc7-8da1-08dda3d2cf5c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8319
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

