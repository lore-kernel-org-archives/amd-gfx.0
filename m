Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFA3EFCC048
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Mar 2026 17:24:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CEF910EDEC;
	Fri,  6 Mar 2026 17:24:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="L5oCXuZH";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010018.outbound.protection.outlook.com [52.101.61.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A56F10EDE5
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Mar 2026 17:24:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B1v3ArZuEK17arv6YMLLLXNUbuInku8VDYZiv4IyWuSg4QHbNWyNWteIeyCtkUl9O7qP+4zzpH4EWfaixMJNHX+nAiK++vPEZOUp3qwgDmo6kJzS0DwrJrkcPSTCVXUiPMxYKOd3x6DEbfplnpczTz8xHbAu6qQlrjBXxkHa+2o+le2UIvwCTVreY8rrtdZXD8bBK5RqtyxpYNP9Qobb1DoiEhXjr6n2tJ1+0FwNUlOywCqfh37qCNbEWuQG6SNDzxVjJQDbCEAc47Vaq2fvR5xr6mtE3RQqmBrcfzUwcAIj1u33twfSSml5B1EDLyK8UTT2QdD3WFPqJ2YGoDZJsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZMguu6zAoBPVJO4iYSp/R0nVP+Ums67ZAXt8YJgfDYM=;
 b=VhE1f7XnhO/R60M7ork+6piX9I55z1a96VHFNq1uemHPqCIdLB6t5WQ4QsQM9d8qcX9XD3DLGMR5FCbY5iS6or7ryQPCsmS1aFPWw7wRTqUvXRF8nb2xP7bJijpWpXDktF/3BepSYP74kT1ka3dBnFC74OK8WZ7FctNBTk3ih0j+F6Q6jgIUZTQPItPS+6iW/cD+e1KYFcT/TCFigubNkS8COy5kGXEF7f/rmkpX/vZAFL0kLtPOu9krMHQqun864bB3uQdVdcjG5s47SH/hpnYAgJGSh/tRfnRI2K+Tc0kG0v9nmNhe7gJCFDpt2edXBtTONNXIAIKbJVsQZSGzCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZMguu6zAoBPVJO4iYSp/R0nVP+Ums67ZAXt8YJgfDYM=;
 b=L5oCXuZHwceYjnyqCvC0KNX/3PWXfg5TlrT6RrqoslyhHldnFHk1pHL7mOs0P6tAJFZ0/jAjAUgwQ+PXPJoerNwZzcDHNj3/oqfrA1CrFqhn+bYO+UyGiblzmsOhheOBeTQ8Sf/eN8XzG5z8bYvRNxBfOHkB8iw9BqCS0TKHLWU=
Received: from BL1P223CA0009.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::14)
 by LV9PR12MB9808.namprd12.prod.outlook.com (2603:10b6:408:2e7::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.5; Fri, 6 Mar
 2026 17:24:30 +0000
Received: from BL02EPF0001A106.namprd05.prod.outlook.com
 (2603:10b6:208:2c4:cafe::d4) by BL1P223CA0009.outlook.office365.com
 (2603:10b6:208:2c4::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.19 via Frontend Transport; Fri,
 6 Mar 2026 17:24:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL02EPF0001A106.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Fri, 6 Mar 2026 17:24:29 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 6 Mar
 2026 11:24:28 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 6 Mar 2026 11:24:27 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 9/9] drm/amdgpu/sdma_6.0: set SEM_WAIT_FAIL_TIMER_CNTL to a
 non-0 value
Date: Fri, 6 Mar 2026 12:24:17 -0500
Message-ID: <20260306172417.325169-9-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260306172417.325169-1-alexander.deucher@amd.com>
References: <20260306172417.325169-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A106:EE_|LV9PR12MB9808:EE_
X-MS-Office365-Filtering-Correlation-Id: aa3b51ba-1f2a-4329-b37a-08de7ba539a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700016; 
X-Microsoft-Antispam-Message-Info: 6Q+FxdAbG95ddJoYzfH9RBUBCggb3Nu5CpZW+WkDzA9Q3mVq9nnneo7TIsSNnJtu6w38n3LmLpDWsW3R7OYV8esutrB9KT5mc/pxl0G9k1WBPbnRaM9PhIO/xONSdl8i2bjR5cHtBQN3a7YJHmX0e+hIjClNErl2NljRgO4BSOaj1zuVTDp1DZSxsJ+KugPmqrQELGboviRJyNhGyULM3Ar8UI5bHxXS3PRnhWHkK05hZ8UxWLieiHQLyPDTQPMfONan4HwSbAn7DD3/d8ww1aWGeAoX8PlWZEKcmeuN/ktFPlfHVTJUqHik4xY/t7U1J5Ntd/ACz677O1U/x/po8kPF1JnJYD6k8zYdNqIQ1+TsypvX5VRmgwVghKVlFuzGqf5ZncGsNJYwh9ASXQkFZiZfmZYd8JBKHQwnU8lCuou3aGDESs5n+0hetIzmpHhl2L3ixnzndqAd9cJrAUhctfmYEs78omdRD4HzUYD71bkaR9AuxAH2Z2v8bNoMl9jeSzlM5ouHs7v5cFHQk7RBh8KbgHq7qsM790xfR86S2AjJ41NZLEW+uG/7c1SEUkKtOqWNV3BEjvOi+n0/yMHpyUM7zaqD6Om8hRiHvbCiT//un56sxTbTOnlSniZEPnn3VDBkxNNSkeW7q6O0qXlpjxsiQA7vumZJK2Hgef7q0SYmd8zs1q+8pILk6hydRnWgo6+j5P38Z+KoVUcnk8j4/1/wrVjzwXiWObF5sFqkW4BWfxlRrb1KsQTEHMO5LUG4ZPOnlcAB5J7A6sdSNHLPVA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: aWGkXMw2RGYRBTtjC67E8i5i5/0c6VkrPx5sU6dpfu0yOIF1waUCrMhQOjKHG/zCP13I+E063O4f082r2lVIPRfVktcuX/b/S53QV+fkG4GHboNEnItsnKqNVgRgqP47qaGpBJQ9P9MY4LX4nUhYKANVPCHjHTpgp5K2RcsilWdLlMohc1jZQvFrz3mfbziFdRFNGLnpJPmlWZbwTcw5X9mlhg3qEnlRjWbynnoG72cocEZf/n6qvQisvbex8IStUM1RD3zleu620TruGLYglHERh4DhxrNmzaI0EDgOrP48Yc3t0ugbUFvg6y/UhJvr/uvht35qyh0y24kvcWOHCM7eBfcKx5YlB4nXXwgGwnseZFcl0QLxW1LYp+jdbILN1WwzWkQcAoHBH1RrShQkTSgQ3izH/0qdUXFfEuj5IWbumfkjyE8HAdO+aYwo86EL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 17:24:29.9672 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa3b51ba-1f2a-4329-b37a-08de7ba539a4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A106.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9808
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

0 waits forever.  We don't actually use the HW semaphore anymore,
but if someone uses the packet, set a time out value so we
eventually time out and avoid a potential queue or GPU reset.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index b005672f2f96b..f94fa52404e59 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -491,7 +491,7 @@ static int sdma_v6_0_gfx_resume_instance(struct amdgpu_device *adev, int i, bool
 
 	ring = &adev->sdma.instance[i].ring;
 	if (!amdgpu_sriov_vf(adev))
-		WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_SEM_WAIT_FAIL_TIMER_CNTL), 0);
+		WREG32_SOC15_IP(GC, sdma_v6_0_get_reg_offset(adev, i, regSDMA0_SEM_WAIT_FAIL_TIMER_CNTL), 10);
 
 	/* Set ring buffer size in dwords */
 	rb_bufsz = order_base_2(ring->ring_size / 4);
-- 
2.53.0

