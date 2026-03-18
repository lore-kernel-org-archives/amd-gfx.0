Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71783103E18B
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2026 14:11:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0858010E83E;
	Wed, 18 Mar 2026 14:11:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UsgnBLIC";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012030.outbound.protection.outlook.com
 [40.93.195.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3BC110E837
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Mar 2026 14:11:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DfDo88oZeuu4le7fmosEfkpG7c+T0zlq0nUrTxKP0ptMx746rfAzGHMOBlhABjF+LYaTXAAlkOOMfzJhvvcqz3P/vpvGHnWOpXeBvoMk9+XW1E/jecJ/PWSzg/7aP5kEp/xgk5wG9yc8YC5JmPxGCqpFHfqVVVI+BilhlUZ0qvFEjgsY9pkpdQPQH6WwBlm4S4IfU/MW/vxrCEfRX6ae1A1zfhbam58zrsdNo8F/0zol3C+TynbqSrqAqoLY2+r/2/InUFgc7hnxIkLoZuiO5qDT+ZOwSeovFLROjVMkkBuN9mktpln5ZrKKKeKgrneExvSFZ1zhKX47Ekh9DLMqSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cU45nP/BAPCyRvxEMUHS9O+i26049xnfgzuvsWtNbTc=;
 b=BqFW4RYVEfCPrV8KFuL6vU0a24r9CgB3OdRvb0zjmzxXYlfa/7DGfwQT0q8IfILTCTzfBZ6YC6aXPEOMJ9BqBc4RFeK6jExPBneIKf2T01X4GTBOclSPV9ILjqinB1CQzK90NO3WGvLvxOmiv0snu0C28tciWSNRMS5D0K+YDZwUWOFijmblumrQLiituIGfGssoc6mgeKIJhSVuHtdDy77qnTlBGgiOwjwLjjRBkO3P5QJISlh/yR3N+BKBcsegcw366shBaq0dtMdWpAW3D2AN+k5UYwqEb3+FwWsuzrXd7rXhJUie+hew8THxMDABWkvrQHv6s0xRnkHp5zPm1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cU45nP/BAPCyRvxEMUHS9O+i26049xnfgzuvsWtNbTc=;
 b=UsgnBLICp5wmFs1ZttAas1Jvx8/W0JdbrrFz/wi1cWkj4DjuL+iVbDZsL+4Ve4gIC5BTLG087nFmy46qX6suUrdG+RHAIfjjwM2n+6vS//4rNtRkgx+81ikaAay28RQFtOAueReC11NrD4+RoFuGtcXl0r4qbkRp0a9p6uyMx+c=
Received: from BYAPR07CA0055.namprd07.prod.outlook.com (2603:10b6:a03:60::32)
 by CY8PR12MB7562.namprd12.prod.outlook.com (2603:10b6:930:95::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 14:11:43 +0000
Received: from CO1PEPF00012E65.namprd05.prod.outlook.com
 (2603:10b6:a03:60:cafe::38) by BYAPR07CA0055.outlook.office365.com
 (2603:10b6:a03:60::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Wed,
 18 Mar 2026 14:11:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF00012E65.mail.protection.outlook.com (10.167.249.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Wed, 18 Mar 2026 14:11:43 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Wed, 18 Mar
 2026 09:11:42 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 18 Mar
 2026 09:11:41 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 18 Mar 2026 09:11:41 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/9] drm/amdgpu/cik_sdma: set SEM_WAIT_FAIL_TIMER_CNTL to a
 non-0 value
Date: Wed, 18 Mar 2026 10:11:22 -0400
Message-ID: <20260318141129.583333-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260318141129.583333-1-alexander.deucher@amd.com>
References: <20260318141129.583333-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: alexander.deucher@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E65:EE_|CY8PR12MB7562:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d3449f8-0048-43a3-1f72-08de84f8483a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: St7cKDaFk/yOYIYSzq+D2BJKrVrcsZEw77ZC4zE0hjkiNwZFy1mjL0QnJ59SNdQIEaRS1GnxLGeFaTXqwu1KR4KlyoBWW8AYSfNn6yjJ3Nier36ee/S8a3QObk123x0Y8sZCwVhVRJ99IQwNb1HjZZVvDwM9CrLaKL3IBadWalDo3AYzi2cP9DPbZvLsKxyOp31NPNpm7poxIwWILIb5MdsMs355HZhziCoyy4Q7G/NPXP1kFct7w29GLTP95BzNWQBP5HrLITV5nRomGoFc17Ze595QDDc1JH6dvHgHRstfHv97wOwYv7Txc+WgBodQk2wOrblOnWLq/mChWQgKD2rRrkJKjcH6jLCvkcn+4VcQgMEQ4oh5oDID6gF39kz0Bguf5F98Tku98dnQ9fIT7jPk5MTcuVDRhYRqm4HOFc4zJP2zTbpPOlwH1gVRC8i7pWl76ab4xGRntT+NRChDa9sfhFx2SNp3cWBN379zJoAqlXejBgOeW1FYqOsOSFaUsO0hhq6UHCYJ938w+s/fIlrrhtfFw+PvoyMiUpDfuAlD9WKZ/SZ9Nh4IPogNcm2zzJAs3Khz6leJD4jPY2GyQXeLM3vpr8wHprBe2HmbrEL37KiWPG6hCWpFMuVPPPID4bo1re8kRXARBNrbY/9bNXeAK61rCn9yOi3sjVJC2EKLwwh4abDdU+pRDL311Ab9oTvvASxllX2Yw2abzDsiVT3amI7IbPLQFLJVQLoqz+j3eHCntmXiLn4InOpcA8awfBBt0n2XqHRzr6pfq7Id7g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 8G5PTAyWPchmAIF3iytAigT9yyjMDa2d43QGbPN2Op432hbaGqf88NsdA/HNgWZLRESeJ3NQ/xseyfRcuiSuT8gG46VuyNSQohbs07f6pOLt7Ed1abE3T0K6iMWUBBxMQmoTe1jJHKcjKG+xXnEH+6D3zOthhYig7UO+qrZ7YVb9vRYvfyjqgjoZOyAiLbLe5IX7Ahr37mfu3In0ocpC+J/mLXv5di3jRsScxdp3euCogk3n3FKFRfHnB2CzCE8No1MSr9bLVzPaYQ8C7Me9Mf/6TTtN+UsFVgrp/iaJqz1dMgzPHLADZrHkl5+JUX3hZZ0MsMGpu8EHezpRAtiU4g+m/iAGVlBll4lEIOsOHi6aqsutrb4mwFFWepH43z//WtYa4pbQWQ1MnHSizIFQG0AS/OJt67WW52BB3KgpgG+MfuFJiIGWUG+8una/vqhE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 14:11:43.0297 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d3449f8-0048-43a3-1f72-08de84f8483a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E65.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7562
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
 drivers/gpu/drm/amd/amdgpu/cik_sdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
index 22780c09177d8..849fc68aebd47 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
@@ -447,7 +447,7 @@ static int cik_sdma_gfx_resume(struct amdgpu_device *adev)
 		       adev->gfx.config.gb_addr_config & 0x70);
 
 		WREG32(mmSDMA0_SEM_INCOMPLETE_TIMER_CNTL + sdma_offsets[i], 0);
-		WREG32(mmSDMA0_SEM_WAIT_FAIL_TIMER_CNTL + sdma_offsets[i], 0);
+		WREG32(mmSDMA0_SEM_WAIT_FAIL_TIMER_CNTL + sdma_offsets[i], 10);
 
 		/* Set ring buffer size in dwords */
 		rb_bufsz = order_base_2(ring->ring_size / 4);
-- 
2.53.0

