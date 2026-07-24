Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAC8CC531D0
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Jul 2026 02:52:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 404F210E61F;
	Fri, 24 Jul 2026 02:52:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Pe/W7X/J";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010039.outbound.protection.outlook.com [52.101.201.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C81D10E61F
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Jul 2026 02:52:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wv5dcHBav4yGfQvg6l+6TsTwYP3lTszEhp3FqQRrQMG2F7HxIBYx2/IXtfG91t8ClIo2g2aGn4oejAeEOwYV2KUhrX4dDBojJMil8Ym7T48amdcVht/7/vR2iXk/aFmx9fUXAmZmTGN2H8g8LP7zI47sK2KpinaIplbwQXvxUJXv1M4z6BqoqJhmUuGzzzLvu/nLsuoKxokj9yedf9sxOHtz0HTH0nz/x1d1lPCYK6uv9sZLTx2l1ER7OCflXgqm/SCI38wc0ygN+OYpdYEVq5PL4Obekrfj1DeV93b0cOg9esALrpc2fYMrFnG1w+iJvwFXyN9v9XUmJUZ4Us4Ekg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kDso3vM2pdIjtRQ0mitM5tMsNwFGof0ayA2cwdKeY8o=;
 b=e/7cB5OxdRjM9Nt8dBSg0AEMy3hD0EHv1RSnX7FDLzT9CnyqcCJUedI1M+0Lut9YD/Q0AYEz6KmNCNzybkA0ddxE8BxeM4++DuiLFShw8e7wij5Flyv7u/uzDCS03PyBR95a9iIPX9X3Dv3/I3PqO/AWSDjjdi7MEPt3PIx+XPKMM7FzY6gU/Qp701WzLSRDU6gfyjlgiWhRCcrtInAKZS0Iap8uYWJ6OLpc2kD3TX5vnkWC1Lr0efX7+9oOWq9C2MhMb2/TlZyh74GxlWENV7mFTqw+LRldswTiF9EdUeuOvkMud29D8HvwAPu0qnPeaHByD2B6q4mxK7eK4e7Wkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kDso3vM2pdIjtRQ0mitM5tMsNwFGof0ayA2cwdKeY8o=;
 b=Pe/W7X/Jfyl7tL7g5lWZet+dpxBXiSj3HNQrYVGWp/3gAGt6hWaujbKzlERRC2he/UYqHbpFFMFEz858woGysFL1r3G8dUILZl81cREsufp1lTgJwXsqNqP7LG4t9MJaDeyinDp5aNNC9pNX+V91S8i4d3HqzYWoHlNbNZg/0+s=
Received: from SJ0PR03CA0059.namprd03.prod.outlook.com (2603:10b6:a03:33e::34)
 by SA0PR12MB7004.namprd12.prod.outlook.com (2603:10b6:806:2c0::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Fri, 24 Jul
 2026 02:52:53 +0000
Received: from CO1PEPF000066EC.namprd05.prod.outlook.com
 (2603:10b6:a03:33e:cafe::a2) by SJ0PR03CA0059.outlook.office365.com
 (2603:10b6:a03:33e::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.11 via Frontend Transport; Fri,
 24 Jul 2026 02:52:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000066EC.mail.protection.outlook.com (10.167.249.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Fri, 24 Jul 2026 02:52:52 +0000
Received: from sunce-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 23 Jul
 2026 21:52:50 -0500
From: Ce Sun <cesun102@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <YiPeng.Chai@amd.com>, <Tao.Zhou1@amd.com>,
 <Stanley.Yang@amd.com>, Ce Sun <cesun102@amd.com>
Subject: [PATCH 1/2 v2] drm/amdgpu: avoid resource leak on SR-IOV VF with
 AMDGIM_FEATURE_RAS_CPER enabled
Date: Fri, 24 Jul 2026 10:52:41 +0800
Message-ID: <20260724025241.1091506-1-cesun102@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EC:EE_|SA0PR12MB7004:EE_
X-MS-Office365-Filtering-Correlation-Id: 86b76302-294f-4c13-c862-08dee92ea7c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|23010399003|18002099003|11063799006|10067099003|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: nvUSGVP7PTSIITTdT8vAQg7aE1ABMPXr6r9WozM38auYSK3fR1Gs+OaSa8YAOH30dUWCDLpSZKMCzNN4F1XbIbLmto/P2SYLNuH4vWvm3wroMvccipfLzqtBc/G7W0xE32ULBJLXOZilWncoxTvXThmCdqFvRTdKQtK7qwHVomBumALPb+jbTP4tihSL5+n2wwU3QM9QGFKCi9F8uUv28qCAXWYDNfb2/NFFCkJBPWctb+iqzE6v9NQi5LvMPpHKOlFwqghOwqT10OfQpyz9UQpbuiSb+6Cy7W0f1u/Ib9tSWTViDuSmPHFL625uY4rLz6pMaKmayVS3LvMBeqs6VoYTeTTwz7CyeHvA7NtTLWdS4scCohh7rDRfMRJWRk0eP6aypMxC2YThzR0zG9RDhELDxL5RLvI6AzbQkL/eF80zU27U78LQksVw962cfEg6c7KXHnTjZTdvFpRwEYQFnUW+wb2P0VEOD8qjaXXa7kXGEjQcTioZyuqEKh0zs9zvF7yZ7NFjVBNJawkeSi26wRXMs6yiciRvmj6EPWmGPX8VIi6Y67m5/aZB7cudtYKCGdPe8eM1pyR4hVmFRRHW3YqelQIt3BzEYtuFvn40ZRBrxEr4p0PHbD4XOH4L/NRbeP2TQGBZ+vj3BginJ/NkpbHAEUc3FzVIXUZ9TY8HWksi111x1sswV7p76ip6L1m+fXJP4cNC8JltvdKSKRfcAg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(23010399003)(18002099003)(11063799006)(10067099003)(56012099006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: nnQgzOA8GwaVYPEojYqLTkeK6NZSxcHdNfIptg0qzhByxQOyG8Bja4ONCUWLNyNtMKqduZmVX60K84nROdkoXfhwn61xZmInzsfM9+5TRTM3uCe4jVPeFi6QCjAnfnqM8NPHOTv42dxGUTGqdn1gztFLzb7r0GJvtIBsYyRDO9jnE9uazvJx9L6S8DYdJZK+Vc0HzzFkCUeF2I20MfTXpoO2oHDTfNSvH/1Vroerud3neapRtZ1CT6pejdwQXhKqbdrm/Lu9rxtdqJ2f5ZGL1A4lw/f6ICaOX4enP1RbyPq2uetx6zgZGfrO8XeWxtuxq+HcwYCZJDpuyGtglKBqWS6t7578xB6nfFeBypkhp7XjZJJJR91eXoP/VYvrelcH5nSNA5fEDrMQMrZKW5l2ameY4rTwzec4cc+f5vcIgNEiyI+QqeiJRffu3B9GjybD
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 02:52:52.4240 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86b76302-294f-4c13-c862-08dee92ea7c3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066EC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7004
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

Original amdgpu_cper_fini skips all CPER cleanup work for any SR-IOV VF directly.
When AMDGIM_FEATURE_RAS_CPER is enabled on VF side, CPER related buffers/workitems
are allocated during initialization, but the old code returns early without
releasing these resources, which leads to kernel memory leak.

Signed-off-by: Ce Sun <cesun102@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
index 0af8b7be326e..373e47050630 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cper.c
@@ -519,7 +519,7 @@ int amdgpu_cper_deferred_init(struct amdgpu_device *adev)
 
 int amdgpu_cper_fini(struct amdgpu_device *adev)
 {
-	if (amdgpu_sriov_vf(adev))
+	if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_ras_cper_en(adev))
 		return 0;
 
 	adev->cper.enabled = false;
-- 
2.34.1

