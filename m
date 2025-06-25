Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C47EC7EE31
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Jun 2025 21:07:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08DDB10E808;
	Wed, 25 Jun 2025 21:07:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Pa/EO7Ky";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2070.outbound.protection.outlook.com [40.107.100.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C43810E7EA
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Jun 2025 21:07:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mw9FNn3bBdK64vpJ54p1EiGGaQBExbxMwtKQAJKe5ZXoKW5/i6posfj6E7hcZjKCdyzErYnqoEeHimsUfGGdXgQ1WnQUhGn+sefoLXQ6DWmflKKswl68ty+eiTaOd28pdbfqgiOKsiyeDYBvWLczRdqQdRydhp3QFgLmC3qCU3xBLHlvATkAyfJ95+iKfj5Of6aoAMf1qkgRgXwO8Cc0JCmKQSX+JzQxs2IIp64VjSj2Ddia8YzG+kD6PVTNR0aYRD4/8T2Pcz1CTyHFAj96Oyhfx9RYrqp/ySIwBcbtMOBx1ntuAktV3z/PmrMDFNxT2h0GCvVHdIOT7WnK4PORPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q3EvccLbvPS1ED9jhnJtEaPieN2D0f9AeRsD7gZl2l0=;
 b=CE+vgBwMvqqR18FgBqZAr2WygIBcHHM4hSnc4shCfDq9oB8ceKUH9noKZa1JjFDETZQ2pRCqPV1vUPQI0hMQ5G5d7FKSOuIA2PPj0b2jDLgG8AoNV/1AjpokYUpT8+yeC0Wql/7McvdO7hBVqjSqqLi4nOhic+CZ9S6H4E0LREk4PKgBoh/L1HtkDTy4UfxcIdrBF472g/U5rivWn4a/y5Ac0bYKgj1Y3EMOFCLSmmFiFV1NuYNuSq8C6b83RcaDv9K6f2BU4Uk7U6QZSO7L2SZ4smv503nGzjaKXV6dEJy7v2LirG/8lMcnnGVbp//bxA9QG17IDZzjJuPJpfi5cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q3EvccLbvPS1ED9jhnJtEaPieN2D0f9AeRsD7gZl2l0=;
 b=Pa/EO7KyybRqcOkgAHamxGF6sMBDUXpjAh3zMT074ze+dAATgAgX6VCK8h0Rf0NA/Ky+BvnhKg9WE/KatyQlyaH/zlqrafL8TlL7qYhgRewKviLCJmZlkVKlCMkwJkB2bN6PdOzElazFoJuNnE9ELSRjtY89Aq8/pulc97OBpTk=
Received: from SJ0P220CA0004.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::9)
 by MW4PR12MB7481.namprd12.prod.outlook.com (2603:10b6:303:212::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.17; Wed, 25 Jun
 2025 21:07:00 +0000
Received: from MWH0EPF000989E8.namprd02.prod.outlook.com
 (2603:10b6:a03:41b:cafe::6) by SJ0P220CA0004.outlook.office365.com
 (2603:10b6:a03:41b::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.17 via Frontend Transport; Wed,
 25 Jun 2025 21:07:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E8.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Wed, 25 Jun 2025 21:07:00 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 25 Jun
 2025 16:06:56 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sasundar@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 08/30] drm/amdgpu/gfx9: re-emit unprocessed state on kcq reset
Date: Wed, 25 Jun 2025 17:06:16 -0400
Message-ID: <20250625210638.422479-9-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250625210638.422479-1-alexander.deucher@amd.com>
References: <20250625210638.422479-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E8:EE_|MW4PR12MB7481:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f2827b7-bd8b-4437-fbe1-08ddb42c3a0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nTE0FbNV9JYcx72vgi36sC4E9AX7Wzu3DNmD3+4EUmw66MNsQaA8e834ofKa?=
 =?us-ascii?Q?cnlCrJ81sWWBG1XRekCIxGibmQgDVhg7TbZGkeToYa71T0K+oSJ0f1zGfwA5?=
 =?us-ascii?Q?yVvQ2rSLU1N8qYbM36MUf4CNU99jiP2Kuf0x40hKv7+91Wl4g+yX5eka66Ms?=
 =?us-ascii?Q?dRZIDEqlC5lgWhnViI1AK4IIak0hHK2osdd3GFo/yv7MVeLQqOUZR7nfWl1g?=
 =?us-ascii?Q?haKGmm8P2hhiCr13pSIjWIYm1JPdd7UITis/jk6LavLMv0ZtTgeYVQ+tj4IA?=
 =?us-ascii?Q?F+3cHzqom8szLZgm+UHG/65rD7skyiqW57oO1CVpoLuLZ08h3AloKae8n0Xq?=
 =?us-ascii?Q?L8ddi6KcQDraxUuQAj5ZQQFA6i6QIUcCuvfXp7loJCEE0bzwbvwFDxYGnVrZ?=
 =?us-ascii?Q?Y7hfIJsr96iSl+P6kjmnT4H69P50IS1VXyn896X7NgcXTnjgQY1ZcyoUpyAj?=
 =?us-ascii?Q?61Hjc7c1zD5gvS9C+ux/cGCGau4WJ11vbrZ5pBNLdDYkiOHnor4YgWH2h40a?=
 =?us-ascii?Q?thxyk3rjQkNm/I/7cFvJy7AKjKiiEiwWygLlLKE3iCJEr8qz0BnuEBxgnBNN?=
 =?us-ascii?Q?eW1cK0pHLRicJ4D57igPKu+Eo6fAZTrg5w8z6Olpfoek6+Swerg4yw+5lvga?=
 =?us-ascii?Q?vqKJZ5JK0qjczsvfYoZ9vjmrJlyBm/Y+ONiMTOCergMpgGRfxQXmgDAvMrKN?=
 =?us-ascii?Q?CW+bYr/WcabDJYDD+yrqJVMm3dsibyjMkzCBmTPL2hbemWz6SCZNyFwlUd7x?=
 =?us-ascii?Q?nQe1KKHq6Ic275gy7p9QhdOgj+9qKd3fL+nIlSDgI59KaQTGdcC1cZP1cew+?=
 =?us-ascii?Q?6SAov3q/RuyEmRgPh9O1g8UHDvPpvn8m4T7rk28PuUFpa6uaGpY1WpntQsUW?=
 =?us-ascii?Q?bYYYnRGHapYNmpU7qgjNBoQb2mW8S1b55vjydiszjjBTHu7dBz8Y3MNB0tE9?=
 =?us-ascii?Q?E/8gApbuVODiwyuoUdZSEd7cVlg6QXdppPSce9RUjQK1AXOCikYsaqCPSdf7?=
 =?us-ascii?Q?x9YJAWNOcQxB0SSP3ZjL4vCHOJGpBjJ9jwYtSGyNHIA2sTSxW61CVo0lmIUd?=
 =?us-ascii?Q?N0sTrztm+GtZ2H9EktD3bzd3saLOhiE3ipfbqLHPJPhyTCnaO8q6jVEeZ8O9?=
 =?us-ascii?Q?P9hfRSYWINm9GRAXz9iT/coRIAy36RjQ6hQ1rdkFNISeCA15w0mUYxC5dueV?=
 =?us-ascii?Q?YsOSe1V+EP5pvaGWWRM7Y1tFSoOH8N47XHL0xWK8+/3yREgHBmUdtwjKdLEa?=
 =?us-ascii?Q?84vauGt26K5SHsfdymL7P07bc9eNzyD6GqbISEd0jUAduP5AnKkflta5KJgk?=
 =?us-ascii?Q?q6plV2aG94afG3nkNy6wmwS9YBOAdiJ4oknB2rLR0D3r6vWse7EB1xn0ADWZ?=
 =?us-ascii?Q?Ar1yHwRiBfA7X5t6rZRiUcnSPIQ/M6hJkZ73GA/TSAxYyODVPAKA8FcMvL48?=
 =?us-ascii?Q?KK37MDuaxHQYkoX/02EvI9Gn+1D9XtphRVYFISbUAAtG63oZrMeQ5b/4d/MD?=
 =?us-ascii?Q?WndVGJUjvqN0T14NvtmIspVbVYjSlRtC8H0P?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 21:07:00.0698 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f2827b7-bd8b-4437-fbe1-08ddb42c3a0d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7481
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
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 76ba664efecb3..30f6b04cf82e4 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -7187,7 +7187,7 @@ static int gfx_v9_0_reset_kcq(struct amdgpu_ring *ring,
 	if (!kiq->pmf || !kiq->pmf->kiq_unmap_queues)
 		return -EINVAL;
 
-	drm_sched_wqueue_stop(&ring->sched);
+	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
 
 	spin_lock_irqsave(&kiq->ring_lock, flags);
 
@@ -7238,19 +7238,13 @@ static int gfx_v9_0_reset_kcq(struct amdgpu_ring *ring,
 	}
 	kiq->pmf->kiq_map_queues(kiq_ring, ring);
 	amdgpu_ring_commit(kiq_ring);
-	spin_unlock_irqrestore(&kiq->ring_lock, flags);
 	r = amdgpu_ring_test_ring(kiq_ring);
+	spin_unlock_irqrestore(&kiq->ring_lock, flags);
 	if (r) {
 		DRM_ERROR("fail to remap queue\n");
 		return r;
 	}
-
-	r = amdgpu_ring_test_ring(ring);
-	if (r)
-		return r;
-	amdgpu_fence_driver_force_completion(ring);
-	drm_sched_wqueue_start(&ring->sched);
-	return 0;
+	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
 }
 
 static void gfx_v9_ip_print(struct amdgpu_ip_block *ip_block, struct drm_printer *p)
-- 
2.50.0

