Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F318AC61DB4
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Aug 2026 22:14:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBB3C10E858;
	Mon, 24 Aug 2026 22:14:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="csSGXrhr";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012071.outbound.protection.outlook.com [40.107.209.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 42A7E10E5AB
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Aug 2026 22:14:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mu1THeoVwj0/7I8adCEW2ARRzCs7jFDjDo9j5N2WzfjQq0pVMh8hLsRHpYy3O/s7gJ2/Dl1l2dWRo8xpzGOwYLTOp8mx2ybkCjiP3fT30ECKuCiPFtrOj9l4WZhpfk3b4G2visceXVMc0vq4iuxv347lOSEX094MKRtfpJgwtYosR3LxeV5/TMGGQGVcNF08p6MHjdul3t5TXdbSjPVLY56UKNMr7GzjAwACuk1/hqlBl+e2o75fKR+Qah7fwFFQwtB2ffHxcMpsQRO50NWUKK5Iv8+oeE5ryahI8XSfx6SertiHliyvF0h+/f+Dt0HSYbV18kT+2/3dHbfbctLbgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ChLUnq+55C4JIdnMwoVoFbvBmdQh82nkqbpuWF2GBDw=;
 b=Sihej4ua9l9hXOJmT8TJWRZFi7Cg/OJTpf2q+/hVjDmVAf5skjcJLdR8kVOmAjUNrcADmaAqJdfsR/VnVSY1iDogguTwALds7+fGkR4HUjxO9vZU887WihrT48UDXxXpWSpr31esMVINNvoggKq7klhyDnAZOdRkT90SGxWpM1vWuTgLOMXhArC5Q6++wcvZmSJG9Bn6seQRUDS2BLQJUbQKAgYtnZRU+qjcO/I1MV0WM6jFKNhSmQi3wK+PkSewtYuPIJxj1JMtqMBI3DFZGUE8enU95ZDOplQ7YSVWnRnWmfXZQehpyc7mGiv1YTOkVvMbLtmO1071fZ5UoD1/NQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ChLUnq+55C4JIdnMwoVoFbvBmdQh82nkqbpuWF2GBDw=;
 b=csSGXrhrtlweM8eW1f88QwPNy2OAAbQU8Wy+LSB/pCYCWQiMFOmPGKTVj39R2RH4QwpgLP0dGiVZxc2OPe5U8DakpeDvu8QW136DN7ic7bapxmnkJTn5KPSt3pY0/i6haplblZepIEASuHn2pD6Y7/kaROIaIzEcQKJzwMozeso=
Received: from DS1PR03CA0016.namprd03.prod.outlook.com (2603:10b6:8:233::6) by
 PH0PR12MB5677.namprd12.prod.outlook.com (2603:10b6:510:14d::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.12; Mon, 24 Aug 2026 22:14:10 +0000
Received: from SN1PEPF0002BA4B.namprd03.prod.outlook.com
 (2603:10b6:8:233:cafe::4a) by DS1PR03CA0016.outlook.office365.com
 (2603:10b6:8:233::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.12 via Frontend Transport; Mon,
 24 Aug 2026 22:14:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002BA4B.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Mon, 24 Aug 2026 22:14:10 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 24 Aug
 2026 17:14:09 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Mon, 24 Aug 2026 17:14:08 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 08/30] drm/amdgpu/gmc11: use MMIO for TLB flushes
Date: Mon, 24 Aug 2026 18:13:30 -0400
Message-ID: <20260824221352.1793542-9-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260824221352.1793542-1-alexander.deucher@amd.com>
References: <20260824221352.1793542-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4B:EE_|PH0PR12MB5677:EE_
X-MS-Office365-Filtering-Correlation-Id: ec29e269-4c73-4557-5815-08df022d05ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|23010399003|1800799024|56012099006|10067099003|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: orqpmrp0k2OyCnMK0USg4fo/6MSJ6zvAnxsMEHmASK+fdDZdoDwQHZJbclQw4Sqaf8LBtm87nwJePUfuHtmTqTvY2N8EzSkC4+SUq7kc+xWIw76VFw73FhnAAJ53j1/CyRLldM21X3anai86KAsUzJiTKwyhRWd55o/MeUwGu0ibzEj4+IzGlDDTocxp3cW5xgx13Gh9vRlwKmSrToMxuoWJ15I7xaGFBgOax10NNs1tZmH5cT9nyj/3ojerB4rdJI/kqaqbSN2F4GhmybjZWYWM5BUEOrTjsMT7G+i3azeZAPxBRCPLr9Ie61kh57Bk2XyypIbjSnsmoBMQJkfhiAyQ6jQh1s0wRarURCyn3A9603AbPZ4PtRHRuCqdcqpe+/ZUMkumrYCWeIrZSMPCtLfhi3dX7kKPDZXHaWNW9pVK5gk8liQapvhC9iLHTxWesU4NRhr4lHlF81a+uCeqOvRNBOAWKBO1MUsA/uJeh9Bv2qJiSW2bdtnV9fCqInn/iANOBDCotEIFq/SAVHMwSVPrep7tEdbuc7shldSW//oItvRfHIb+VWvHxRmgJbWJ0SSvqaevrmoZ/3boLlKX2oD7A+Q5dqBOfKHFPbljcEHi17YNVkCbwUdjez7lqqhlY5p8xTzzuu4bnZOwXFaVmVMv5xxh7ER0HdWWlbpaRgG7xDjZgJwABM3FflbVmGnFo9/Bh+ZShoS9g3pamfb/9A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(23010399003)(1800799024)(56012099006)(10067099003)(22082099003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: FTVwEoUpYcW61ISNJ8mw3KUEDQvMzfFjcUsQdMMVOaYqN7NhCiODj+9DdxB7SY9E6iRNsYcR+b75oqC4QI3ciftHE526xEBn2TsGX0puNAJvU6et+N+Ac57UgzEMTc5Po8HpfFNnnwFCfOhy+Rb/b/Stkp9oFPPGmp7YhrSqtrao3Gik7Ikudn2Qx5isAHf/T/Wwy1WQRT04S1hDDDqD0he189f3mzvgRG/pn52u4jqvrlyzqQgxfr6b0RHuAzPNGCulCHMcjYIwXUoiccsu/00M/VdrNGqspSBYBYv/9fX2GnuTeRsVBir2D/AWg6EsmtUuBOQYQAjPmbgNRaTy615A61X8eiIb9nWgv6poy4yjxQFyoCODqfI9jeMEF8seYJ8+TMYnZUOXCyFZgnXh9iSls55dIvCWSO0/Ilv8b2h8MJjwuSMNGFagJIU43fLM
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 22:14:10.1169 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec29e269-4c73-4557-5815-08df022d05ab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5677
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

MES only has one pipe on GC 11 which handles scheduling
so it can get delayed if there are a lot of queues active.

MES was used to avoid disallowing GFXOFF, but since the
MES will wake GFX anyway, just disallow it when we
flush and use MMIO.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index fc730504be5f0..098e1340554c5 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -866,7 +866,7 @@ static int gmc_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
 		return r;
 
 	adev->gmc.use_mmio_for_tlb_flush =
-		!(amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev));
+		!amdgpu_sriov_runtime(adev);
 
 	return 0;
 }
-- 
2.55.0

