Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 559DACD6E4C
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2026 05:55:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DDB80112DE1;
	Mon,  1 Jun 2026 05:55:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="H7yncMBt";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011008.outbound.protection.outlook.com [52.101.57.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 22B5A112DE1
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2026 05:55:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j9v4ee/UuACXyRti23dG+d9vKo5FISfg2NRyWjWwQ9jVSUCzqG+JYDdLDIqqmaFBxRJYAH25E16JQGg1/tf02DnuMUZrF+adxjT0Mp4CQl1oowP/zCkhq8V8ctaHPpFl7dhBMR069yKKUls5X/yXWXh1Q2eylsZRQlEGhTKci/7l4Q75owaECgV6vo4aegw69cTlGxG87NOATewm4kZyZAx4bWAAdtRoPr9/QM0gybHr4QnnbScmfsNE27eiNRo98E6wH49iWLH2j7CF/vQkW2LQY/crJuHslchSqCnfwXQmPETKtgHGP77PG1wvsMHWxjNiROuOq9rTg/m2GwyBUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tT0luo7faXGEoPd8+xEI4SQgr4PDrkaLCSc+iYf5ng4=;
 b=vcVBoMD7QPApimnoeu72IpXvJ0eF4gpxcSQBp0rGU8+tB7aLCSZVCJPrQpWDO3W12p3+JkfCAIxujhBy7WkI8U6ymkhZQBtw/8a8TlVqiGkGS0UZ7nIEulrKAO2yTmZROLTLm0BHmpeVZcPG4yuWApa3VuPPLY6nAWJjvcUCISu3HOwRKcvOx2mvcubWBnQn0RJINBrgMW3EqPy+vemyTbGNKnGxGWF0WJrCooTSgGHd8qyDBo+XeQLUJrnWuddzJwam/GXgucG+SAORK93uLlnq0eKEsYPAYF6xtFvFQNQ7Cave1NM+ApnPlyVOaKnNGrizzJkvgqERdRpETbv0+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tT0luo7faXGEoPd8+xEI4SQgr4PDrkaLCSc+iYf5ng4=;
 b=H7yncMBtXzS5NR9MX025V9km7UmMUS+ApJsGq5JQn0HHE5fRY35YPGpVyzbLP7qqqVzdCMt8dzgn0ZxlgY6cFWfkKEawqLCxSZSLRoiSGC+FNLXVtq5iaCD/HcI1zqeoSkefkn4IUXL9ChkssTEp1pPO89sRLp/XJWwr6DAIP1Q=
Received: from DM6PR02CA0165.namprd02.prod.outlook.com (2603:10b6:5:332::32)
 by IA1PR12MB6650.namprd12.prod.outlook.com (2603:10b6:208:3a1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Mon, 1 Jun 2026
 05:55:35 +0000
Received: from DS3PEPF0000C381.namprd04.prod.outlook.com
 (2603:10b6:5:332:cafe::2f) by DM6PR02CA0165.outlook.office365.com
 (2603:10b6:5:332::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.16 via Frontend Transport; Mon, 1
 Jun 2026 05:55:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS3PEPF0000C381.mail.protection.outlook.com (10.167.23.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Mon, 1 Jun 2026 05:55:34 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 1 Jun
 2026 00:55:28 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Sun, 31 May
 2026 22:55:28 -0700
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 1 Jun 2026 00:55:21 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH v2 40/42] drm/amdgpu/mes12: enable compute MMIO pipe reset
Date: Mon, 1 Jun 2026 13:49:26 +0800
Message-ID: <20260601055034.3700921-40-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260601055034.3700921-1-Jesse.Zhang@amd.com>
References: <20260601055034.3700921-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C381:EE_|IA1PR12MB6650:EE_
X-MS-Office365-Filtering-Correlation-Id: 13bc289c-27c0-4037-6d7c-08debfa265fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: yjR92v6QHUd+68YkRaI2KO2LEZV0rPwSWNTXRTnR/I7d3KfGfCX5+8ky1dLF+/l3+iG3TOLhRzoLoNT1/W6eEv9R0gbvWhTIItc+zRbvEfZRtwJdtmJEgC0g6vKwP8I0id4c/AI/LgTkjapv+fe+tVfHSHMkSP32i6zbFQS/2gIzoqo8kuoMfT8NQJwteg5LNXfIxPLyzWJJsq8c7P0jIonrzRPnpaycpYtTDWMFnz30acoBQ3bF6g9CGy8um7Gw9DqCRQg8Zipp/5al2K0O5p8Rx44FgVbVgmcwdwnmg4NSqQmidRJ39Z3+98rX9Isssd2LyVl+D3rrE7ib9n/9h3JACIAnIFNByqSFy+1V+2VZ177Ckr5Wsj8KlMQccz/9irwLu+EePW8SJngqTmJsVGJZwlKPOogqfSiybrKrSRrdjGDfUFiP9B4NusOBHTuyxq1mD6GHCyCQrYEJ1ReYR1gHFGMjczqzf1CxIco5O3IaJYzBe4DyoQdu9vj7ETbJoIhAPFuQ0zk7QyqUdEIax2ZLamxznVC5pXvuNPhrZ3IkXipG5QfRaF0hRd9T3fNZkc9EZ9fEc13MY3wlVFWcl2wwMYQxtYMDxc1x4ji4vfDdoCkXySswxxNDQHqkZu47i3B+wxmpVx9QWACoztF7euwylir0hRhcA/vuw2OLOGkJwtKX7o/xsBZOyqsKLX/ai81Y67OJX46CbaqS6ZBTl8FHIFPe5z6E0v+maN1fsyI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: sH/AFJKMAzJrRcfA7jXlyHgNd4+o7eQhXZW1WYJ90kPTCm4cEdPwlQFIL3tbkrj45+K7Pj030nDLVslw0wCwgLk1VjqlQCce2hjIfyKJEJsDIeVz+H7WzNvAJrT6yvNS6k/26l+pSS05noypCoaYOY0WFGXN0vtgoNKD/OVri9qCQlQqv6BoTQ9z0gqHnDhiOrBvUhFpb63MYNgXxuDdvj7rQyK0ZIS282Obrv1wkVxWgapgVvX4k1kLcFMBKxkAaOUp6DU+Wp2sBXLs38p/AmBtoDxqkYE1QEvoboDpTjwB7MAqc8HF3OYdRfG8e7cg95p9/lywLWHstBNcPBbaAbzlkqRurqpDA6wGw8QC59rlSLQNpmRyEyneSfIAp43gpuyLhWaXpHK5VJs7WKeABHlixQdn5cOgOQcxFWGKTg53IVpjG3scjv9PGljDdYJC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2026 05:55:34.9152 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13bc289c-27c0-4037-6d7c-08debfa265fb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C381.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6650
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

From: Alex Deucher <alexander.deucher@amd.com>

Enable MMIO pipe reset for compute pipes.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/mes_v12_0.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
index 1eedd697fee0..c8f56ce928e8 100644
--- a/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_0.c
@@ -502,9 +502,6 @@ static int mes_v12_0_reset_compute_pipe_mmio(struct amdgpu_device *adev,
 	uint32_t reset_val, clean_val;
 	int r = 0;
 
-	if (!mes_v12_0_pipe_reset_support(adev))
-		return -EOPNOTSUPP;
-
 	amdgpu_gfx_rlc_enter_safe_mode(adev, 0);
 	mutex_lock(&adev->srbm_mutex);
 	soc24_grbm_select(adev, me, pipe, queue, 0);
-- 
2.49.0

