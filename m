Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83876C43211
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Jun 2026 20:41:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2376610E40A;
	Fri, 26 Jun 2026 20:41:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="F/QSOuX+";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012063.outbound.protection.outlook.com [52.101.48.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94E6F10E3F2
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Jun 2026 20:41:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=McXoOc2pHrUGoo5kYCQrdqAG84ONrO/Mw4tGbem9Q/VlCVTsnSfz1X6mmyifhZE38ZKqlxGtDXvxdx7Y1Jnu1xGlFEjWytXQqFYFXBafQLOz4KzHgQGymGCumkmoXuqkz7W2KoMHcsC1Wn3GxSZUJ9DCr2guRff65uoa9y0lP+NnBpdCC2IggbR9gfs4oNBOHdYlJmXOgE9GRN97oKkcVaOdjUiET3GDiYcVljWDhDhbvYOAXgMDfnuPZ3QSScEYvzmvt2Y3vUK3ouVHJtCgMBLLe4UqoaIFqTOc46vNgJ1sBb1eyHhRkt35jNe8aCRys6s8gt17CzjQ2XIawa5Uow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wBAz16NVpSRC5T8Qt8vJqeEsAP/U3ir26OjX3ulw2S8=;
 b=UTbCCFwlm/hM2C/FpkQ1UK8NPhKlvZvODGiRfVc/sHKL4RHBOELu2TFQhTt7f/NOaVeaDgm1PmO+fKN03J6KI521LGNIfBrTm1gCgcM7e/T3zsaIwi//seySEiX33ecmq4m6EjL9aFBUGLR/aEkvMLDZA125sdya2+5u0J3BPje4QkT8FtpdObXdIH/UcRAJ8oZARkgNvN8rcNHUadLZKj+jej5mMos44VZ0K571W3TjXWRHWGXaV2FBVzoNfqOxtLqQEMR/ybjVsvpWynNyifZMBP+Ls+hFkdD0bHGs0p5pjova6jMZ552oZTvpaiGQd3aXm1Fee4+eBIXWJQC8Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wBAz16NVpSRC5T8Qt8vJqeEsAP/U3ir26OjX3ulw2S8=;
 b=F/QSOuX+NbIW9i97wZfweswxG4RivlnFwXJzWZCGRQQ3xXpTysvXuqcxuj0oSKcCKhtpqpU1vZV8hrWZNVRV9ypagVIAHAftatzMeKnu2uMd/fH5xrNYzBy6T23DzTWIEoKHF+UhHcp6wGnEu8hDhNOgCxX4cvUbZv/SQyifr2A=
Received: from CH0P221CA0040.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11d::20)
 by SJ2PR12MB7824.namprd12.prod.outlook.com (2603:10b6:a03:4c4::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.17; Fri, 26 Jun
 2026 20:41:15 +0000
Received: from CH1PEPF0000AD83.namprd04.prod.outlook.com
 (2603:10b6:610:11d:cafe::e) by CH0P221CA0040.outlook.office365.com
 (2603:10b6:610:11d::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.17 via Frontend Transport; Fri,
 26 Jun 2026 20:41:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH1PEPF0000AD83.mail.protection.outlook.com (10.167.244.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Fri, 26 Jun 2026 20:41:14 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 26 Jun
 2026 15:41:09 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 26 Jun
 2026 15:41:09 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Fri, 26 Jun 2026 15:41:09 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 3/4] drm/gfx12: Program DB_RING_CONTROL
Date: Fri, 26 Jun 2026 16:41:00 -0400
Message-ID: <20260626204101.31172-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260626204101.31172-1-alexander.deucher@amd.com>
References: <20260626204101.31172-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD83:EE_|SJ2PR12MB7824:EE_
X-MS-Office365-Filtering-Correlation-Id: 28418651-645d-424f-8b82-08ded3c34411
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|376014|82310400026|1800799024|3023799007|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 36Rv+XhOUfb0OETV3eAa7h7h7d0N0Kk3pP2tdJumMdbNN2nnpCRNeEPVM9UYi3IW/KLYoKGq69BkdegdTNWkFJvYMF7nemwV3PbX10761dJSsHvQEIcRr/lR7nGk39rwHzDdsOLRfBliFOZiPkr4jLujwi5Eu6HCr+FNbeEDRUNvks6xMcULze+OM+PBXsIJn5WFqlkCxFQ/nBMfAXsxKtfGs0vi55Tvzb5VrMTSaFiCHVTPa9/vCQbUrhfLA7O84s/JNT/EAhEn/Cz9PsPtOYZAK0ju+A3GdkNDfeGUGTsyc+BzXxshDfOVDQ+dd4Pg1gjmay10Y4Z9D9mbz4DZcl0Ym2JUZgGkRuHKbe7KxOByB3hnqPhCMKevxKFl/a3RiLnpwecBFJR17OrxIKgBoStQPBcUwar1ajMzkhGq8XC73HgkfXgSMnNw8gJoeUaV20HlUA6mQi+RK9pgxXWRPIlrFfGJDFJpXsm60ox062T17IJfYHvPrvtuFUTy/ehk9MPXwHaFO6YQlLd6XD0SaPCi23K+vx/XXzZ4XtZjzd1Amo0IIpXupHzE4H3QxqHRaN9oD6FkcRXl2EenS3cZGCNZbgG7u57oR56Vs5ZrwWcbkqWNcYP2lcj/Ns0TO7CxxHK2XFJAPhQEDvFTbVRL3YfygkON8nCllyfKZmTVEDtc109d7vGGEXruoxOlyjBIXbDvJOPFmbu2T2FNoqq8mQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(376014)(82310400026)(1800799024)(3023799007)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: d5pGi+I3wWfo9FPNdvPnCmW0/WWicJt0iv2iobSKzJj2UfUJxbQoIXN+iVfV8hBNiyI9j41MFIxQPuK02j1Z2586SbqyR0+Jvojle0/9w8vr6jBATNBvni3yP9dLM6To6l3aE+h0b4q9lLmHu+smf7MhOokigePwGaUtS7up7IubSUc+pzouGciKT2pTDFK1CM/2zoNnDl0M46O5yce6GKa2n0iGKXnexQG0vQzA6uNYKuV6quCVdhNpdGhislgmlt/H9rGlpWivO209UnLxJCmtq4K3YkE1VItMg1Nin7Yq7vb8kBvzOC0t2rc9KzHevan6hoM/04nm8e6bW3jda0JMD2gf5rq/1B7um3/RC24T+VNBQ5i11zfR8399OXLMhrwuVisBzp5gzJaPQX0I+vSI6cZJJinXnN/9UpiSePDF+kHeauIjpJwiCZcDKmm+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2026 20:41:14.6727 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28418651-645d-424f-8b82-08ded3c34411
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD83.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7824
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

This is needed to allocate occlusion counters across
both gfx pipes. GFX 12 only has one gfx pipe, so no functional
change since the default value is 1.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index a2f0960b23fae..9ae9b1e4d291e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -1826,6 +1826,9 @@ static void gfx_v12_0_constants_init(struct amdgpu_device *adev)
 	gfx_v12_0_get_cu_info(adev, &adev->gfx.cu_info);
 	gfx_v12_0_get_tcc_info(adev);
 	adev->gfx.config.pa_sc_tile_steering_override = 0;
+	/* program DB_RING_CONTROL for multiple GFX pipes */
+	WREG32_FIELD15_PREREG(GC, 0, DB_RING_CONTROL, COUNTER_CONTROL,
+			      (adev->gfx.me.num_pipe_per_me > 1) ? 0 : 1);
 
 	/* XXX SH_MEM regs */
 	/* where to put LDS, scratch, GPUVM in FSA64 space */
-- 
2.54.0

