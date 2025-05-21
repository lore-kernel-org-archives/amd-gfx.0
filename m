Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10367C54E65
	for <amd-gfx@archiver.kernel.org>; Wed, 21 May 2025 09:51:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80F7D10E6E3;
	Wed, 21 May 2025 09:51:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TDihsAco";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2043.outbound.protection.outlook.com [40.107.223.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1789110E6E3
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 May 2025 09:51:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YPivhp8Pj99ZoVIuRvYbhrzc3a2NqfRzfAJtenx008HElIOhBZD/vlIXTp1bHfvrjh/Pqx4ajNr/FVvd6nacjXMOUBhchP/qrW0tK8QDCde86ycy+08G1AyRtIm6xZhcnRKTqtSsW2rPkt1kF+uGStWbOz6PQaxkTxO0fjGPrFP2kh7Djbj+BuW5NO2k4mJaJIcPp4GFWIotqh95nJPOkelaTrIYjBXBmX/6jrpqQZecGwfVAXM4Dan7CPk/5tj6NCL8OqqVFZ3Ioqe4bo/PETyWWw9kx0nazmHCLcgZR/jsNd8A66SRyJOrUuMN+wIpZLb4bNWi6veAT4VaFGMHxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Gox2xdQovAZQpaODFoacH0siYTmxco2ATI6v9Cb5Rw=;
 b=tlOeXj3gJF6x1B6MstlvXapvy9AdE0nk5WwbDToO9V1+falGL6UJSc85y9jE+paUVQ6e6d7FLJeA20Z8sAMEUfXWchPSltW2zCDcky9vXOEgYjDlKv7NwSxsOErTh0egGAQjGQnSYVEAjHUf9sZkz4XFy1tPBiuhBmJA3jhXKfU6RQCINJhhazI8aBaB2FmxuggEDoBPW7VsunXejAQtAUPpZTKNQHLOHRj1nqRvYI/x8FYSNPzydO2dPopJTww9hEpSOEv3fosXZ7a7cL+e8Z7F6/C+Kr8YNtfk/TV8rUhEza07WgTd5R2MNzj6iJlzGp8oGqKoxNysB/pfPAaFgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Gox2xdQovAZQpaODFoacH0siYTmxco2ATI6v9Cb5Rw=;
 b=TDihsAco1dG83T5sd9hoFnx63xQI1ikfxERFhcT7C9x2OZgV5dL3yZuE8tyvJd2dlQNVEsW2Hmx8rRjDWSZZ4JsAq6/1X9UG4IAgBVTKqrUM+ujv8ljVJt33YjuiBNwJoeIuh+23oLjYRvU8aUPKq7UEk8cqKNTGI6BERWy1Wns=
Received: from BN0PR04CA0030.namprd04.prod.outlook.com (2603:10b6:408:ee::35)
 by PH7PR12MB7939.namprd12.prod.outlook.com (2603:10b6:510:278::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.33; Wed, 21 May
 2025 09:51:00 +0000
Received: from BN3PEPF0000B069.namprd21.prod.outlook.com
 (2603:10b6:408:ee:cafe::ec) by BN0PR04CA0030.outlook.office365.com
 (2603:10b6:408:ee::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.31 via Frontend Transport; Wed,
 21 May 2025 09:51:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B069.mail.protection.outlook.com (10.167.243.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8792.4 via Frontend Transport; Wed, 21 May 2025 09:51:00 +0000
Received: from FRAPPELLOUX01.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 21 May
 2025 04:50:59 -0500
From: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <alexander.deucher@amd.com>,
 <christian.koenig@amd.com>
CC: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Subject: [PATCH v1 4/7] Revert "drm/amdgpu: add the evf attached gem obj resv
 dump"
Date: Wed, 21 May 2025 11:49:06 +0200
Message-ID: <20250521094912.6714-4-pierre-eric.pelloux-prayer@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250521094912.6714-1-pierre-eric.pelloux-prayer@amd.com>
References: <20250521094912.6714-1-pierre-eric.pelloux-prayer@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B069:EE_|PH7PR12MB7939:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d7d749b-ab41-4ba7-e899-08dd984cfe51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MJ6pLUCjshudE2z65FZJjhnbqUGG1wnU4hYV7XgCA2Dg42B+Cuyqu7yLntIN?=
 =?us-ascii?Q?ajMkInGeWZYZl5Vv9DT0oli+fDFNPFXoitnZWhFMD9r71hsFbcM6zpLCUB2G?=
 =?us-ascii?Q?F7Al1OC1C6z4SacnITMEJH6F9zcRff0zrod7tWZKPG+C+R9OlqD63wCcswdY?=
 =?us-ascii?Q?dFiJhJZq/4kmr5nMPnye3r7RJXDOcO3cAM/RGzV0optLRXefQLQzfXiLWwBO?=
 =?us-ascii?Q?3omtVkxGpMpYG7AaVIw0P86NHDJPNq9E14UIZB+zkujvswv/WxS1eu/jS13S?=
 =?us-ascii?Q?koe2GcArNiQbNlILS794l1zXzRFtBYBXd/SkrjwbCeqOM6D6BrWjUpvXqzx2?=
 =?us-ascii?Q?5iJWY8KbhaKCVKeShcDkf+u1SFVRoc8k/nGWLCIR5Pd6rKDsmLw05RBTXUmL?=
 =?us-ascii?Q?bP0famP5b+qewB+WJNmoWXrj7ObAHWMdwmP5VkUAGJJ7B3YjI/MEFehXri7+?=
 =?us-ascii?Q?l0K/2C12nSB/aaC2S5B2AQOrrF+ZW7axaTstbhZ+KyXd8qS4RwVIgHLUm4dx?=
 =?us-ascii?Q?vEL6W5S0GjfZ8ey1BXDgUXdg6frSTlbL8FuoRwss9HFR8WTbH26sKotvJeaa?=
 =?us-ascii?Q?Xi2gylfAi04UW7q7KnGLH7L5DcYZOQWDFixTcS6sjUcYLFUtwG6/rcKpHA6K?=
 =?us-ascii?Q?7n+BgqVslm13XwKRQ4KJocbT3jybVBNybL+imZMRxH6zT34CrxsKPJatQcPA?=
 =?us-ascii?Q?wtS3040C9Q48PJ/ZsggHSmJwWHjgBwZAXvme2+PZo7eom/nBqyUk5N1iywtj?=
 =?us-ascii?Q?GkeY9xC35nUUEpot+A8AGnB2Wl0k8eIleoO1ZoVLV/xzvPXIWKYdqjlPp6fq?=
 =?us-ascii?Q?ub8b3LRkLe8zzLU5ktBKCol8Ijz4N/UVUxw7EIHrH0niFucwdGbtv867fSDh?=
 =?us-ascii?Q?IKPLsCrz31TFj/qA0HEP/siqvQiUqtMtSg4CzNszb3Xa78A4brA7DbnFA1K6?=
 =?us-ascii?Q?KhxKvenypO2aBGh2uaq8GpDsqaL4z24SVMu80Bzp1T8mzkODTNuYZaY4Xb4z?=
 =?us-ascii?Q?6tok3Yz/wvPbCMEJFBQ1NmziZv27YdfcoohxMPK0yO8bIIpnF+qH0shwfI7j?=
 =?us-ascii?Q?xcLl3jpMkmjr8WxsMKXM8hKF66HwqoK7M1cgvOyGZptbTHHlEQ7eJQ75Bw+7?=
 =?us-ascii?Q?tRJnt3ytWIyToNk9jtYCVnuxBJILZklfVkVBayo0khdehUgbEW3fS/vaZ1Qb?=
 =?us-ascii?Q?QjxAIOQLGHcSWsvctxAwW/N3jVCcVVXiAQwAX2TUz1MK+NT6gQgsYrdYd95h?=
 =?us-ascii?Q?8F4H1E1BuszVEU+JRLJyIuEquh9r/PUwDzpAJtCT1badJKKAZmqdED3fYxVU?=
 =?us-ascii?Q?sy7S5hpyftZNsXATKKafhZxb3A5S/uOih3xpmC1XU9row1Jf88nfJmFOhHpG?=
 =?us-ascii?Q?h67GEcffwHOawl+pmAyy335r/sDz5Ec8RZobGrzHkVZYxnVwo1gZog9qa6JN?=
 =?us-ascii?Q?/5u1eVpuFq7jgLwox6lK49Dbfa3b674CVrrWFPu/QEoAbA0SKlsXkaI+JnU5?=
 =?us-ascii?Q?+zKrDQtELInsOUo807uYmMcEJkz/Pdx/EPQp?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 09:51:00.7773 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d7d749b-ab41-4ba7-e899-08dd984cfe51
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B069.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7939
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

This reverts commit b75818d0d28f1e06ca396cc2b8a38601b44c4788.

dma_resv_describe outputs new lines so it breaks the "one line
per BO" formatting.

Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 73403744331a..3339703f40b7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -1645,11 +1645,7 @@ u64 amdgpu_bo_print_info(int id, struct amdgpu_bo *bo, struct seq_file *m)
 	amdgpu_bo_print_flag(m, bo, VRAM_CONTIGUOUS);
 	amdgpu_bo_print_flag(m, bo, VM_ALWAYS_VALID);
 	amdgpu_bo_print_flag(m, bo, EXPLICIT_SYNC);
-	/* Add the gem obj resv fence dump*/
-	if (dma_resv_trylock(bo->tbo.base.resv)) {
-		dma_resv_describe(bo->tbo.base.resv, m);
-		dma_resv_unlock(bo->tbo.base.resv);
-	}
+
 	seq_puts(m, "\n");
 
 	return size;
-- 
2.43.0

