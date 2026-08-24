Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8BBEC5DF81
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Aug 2026 04:23:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 54A2410E122;
	Tue, 25 Aug 2026 04:23:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Zh8qj7qt";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013037.outbound.protection.outlook.com
 [40.107.201.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA07710E122
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Aug 2026 04:23:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZKhlJ1XRgutVV62g8iz9qwrW7wPysrRgd+sRyu4Z7wVjed9Qiau+T9RtHhoGZ38nMu4YQZAlhj1qlMe1k6SrEkgD12USqMEwcY6YcS1opikx+6AQBgBNY8ajoLWGm31tpjkZQSpSna7RMZ4j3JLLaaKhahBnvSTbPccnp96oXL0b3MvrkuRFTP9AAi+DwwP9fjGU2NtiNvbBnkGB3t0o/k+qAirXyLvBGBSK50In0JWgFLswie6xt3qlheY+eW7lQ8laE94Gj6ZkZwTjMDVp0YvvTxqcV2rr991fA4H2ViU+mKTArC+0DqTOn+KhYbZJJSGqnZaczAvhVE3TdEUW/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dqsZ500wGfWBYKY+D1Mcvf13SiIa4mZ1DNB7jHzn9Y0=;
 b=Y7kouWtGrSv/0L0D+2veLUxFsYZ0T7pz3YDqcX2/0rAsfRrWaB+ChUdzB5uVlyvcLj/gd6NCjHm5gz90CTPW+D2mkNQf65VzXrpLfqEuSRmjFcfPw4HRQp9KfRJureFc/lEJnrnAoLHZLFvvcEBt8r/rPABQCKvUhQF3GYq+5kRdJHZMdRhm6leyYDw/ak0qCf+u8KHThR/jMV197t33oN1xyyJUlioha8Ok6O+7DJX2sc5tNGq92cPkPSffm/xokorf7i6s7qsyroIK44ErLAnLRAwZi9nwkOcwCn1XILif0xaQsbZ/aQOoKhbT+XuNH3+doPDY/kEcQG00H+VOaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 149.199.90.133) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=quarantine sp=quarantine pct=100)
 action=quarantine header.from=amd.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dqsZ500wGfWBYKY+D1Mcvf13SiIa4mZ1DNB7jHzn9Y0=;
 b=Zh8qj7qtSeEjccs7vcqozBlIzQNZcS46itdZdVqzxyRTga8TjjmTYspeaeW2vkv9sfBARoJqczhp1AQpiMSYwBJYNOPdiuoof19RCetCIO64MAa04MpGqV/UaBr2lmNPFDEEJQLhRyCYKBJyFiPUv0LtUvra4gjhhcY31HtHmeo=
Received: from MN2PR15CA0052.namprd15.prod.outlook.com (2603:10b6:208:237::21)
 by CH1PPF7A6EE32B1.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::616) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Tue, 25 Aug
 2026 04:23:03 +0000
Received: from BN1PEPF00006003.namprd05.prod.outlook.com
 (2603:10b6:208:237:cafe::6f) by MN2PR15CA0052.outlook.office365.com
 (2603:10b6:208:237::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.12 via Frontend Transport; Tue,
 25 Aug 2026 04:23:03 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 149.199.90.133) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 149.199.90.133 as permitted sender)
Received: from satlexmb08.amd.com (149.199.90.133) by
 BN1PEPF00006003.mail.protection.outlook.com (10.167.243.235) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Tue, 25 Aug 2026 04:23:03 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 24 Aug
 2026 18:30:50 -0500
Received: from AB350-desktop.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Mon, 24 Aug 2026 18:30:48 -0500
From: <vitaly.prosyak@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, <alexander.deucher@amd.com>, Vitaly Prosyak
 <vitaly.prosyak@amd.com>, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH 1/5] drm/amdgpu: reserve dma_resv slot before adding eviction
 fence
Date: Mon, 24 Aug 2026 19:30:01 -0400
Message-ID: <20260824233040.125300-2-vitaly.prosyak@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260824233040.125300-1-vitaly.prosyak@amd.com>
References: <20260824233040.125300-1-vitaly.prosyak@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006003:EE_|CH1PPF7A6EE32B1:EE_
X-MS-Office365-Filtering-Correlation-Id: bece6e66-38bd-4009-83b3-08df02608e00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|23010399003|376014|36860700016|6133799003|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: e7FV6A8jB+z7iVI1oEr/BuY6WijWW8vrZe4l/Kio8FcexGVUbrG50OlHAEu/cCqCvMRFmzTo+eYmpst6eXgItVLdUSOe3WdpFXvU3QraX7Q8ZYk440hLNdvQ/ee19tIOkqPZ6beJBnf/z+y1/A+KeeMW3hpV4t63L/AgK3z4dZ5x+8YagtBU8tUqWB0fVBe7xa2wQdvSwJaKJSuhaEbOYqG5jSvuaSIe5ywJtmTcMw9qAYMPnLAUpqqohcBcJvgfKrQvziGO8o+SSjeuau9buvny7OXVjLqUG2XOzkD/v5325qsGBr+4CTlntYIuT0Bnwk/5g3BgzsPueExBNf6rZdLYMHQi0XW8KRlNxl9gcZDCO5t6I0e2qAbfjNWiAs3zZFN7dGhoAGyRB/bx9RLNCj/9SafGu8LagtMqofThrjbm2wGfRSqspNUq3uwrZISU4ViRMK21yxAt4qRXOt1jeNgkS3hGBKPd7ZlvAb4HqfxFWXpp51xZKreJmWpmPXxDNYGPXEBuRaui98LiGsy/h/37w4n4vCm0pQQdL2Fk2P/ykPNGIyAvPmCafATzzKBCCJFQMHxotPIDvPjBTArSmxC8+/6ol9dtZ7x4U8jW9IuKDFgmFNIiJumCe3y1Y9/3/VA6FJ9azJiESsmrIop9mWSha1f6DJvWPAnM3lXafIsYZrgTnBCWfcUTzWjOPXp4CHb58RzU4xwompAeQUSuJg==
X-Forefront-Antispam-Report: CIP:149.199.90.133; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:unknown-90-133.xilinx.com;
 CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(23010399003)(376014)(36860700016)(6133799003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ecdsslyCP9gaWJBRqRTaFkhMnPxMet7nh87v25b1utraDOWVXEwu+3RUPsEaHZfnlk6S2SreZ/bDOmb75LwhCieujBONbmb5urXholKY4pAajZcBRoOdUWWU04OPFCue1Mx7qs6IjYbeSFPIA97tW6Nx94WMKGyiDH4ZRk80Ltk1XmrTEhMeOj0JsRUvSDJg7siC46p9hBkxprA3LWuzjX8xgzETJWX7x8LjDc1Yl5ENQnpeEjCvqsiD7Cfm8ktbXa8KZymjS5h8DL/tUhMurvNzOASY2ra58T3zztQhPEOO9mZVv8Dt95wmCwClfUDP3VNSeCV+jA7fOqDe0pvSkSKaTxNm0kQQdb2gIu/2bgZMEml74Dm95D+mzlCPAtjjLIOLS08vT0A623Ff1d3lx3p0WxNtyA9xeKh7OwU5kbLCVDAHzw8cJpJypWnsL8PW
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 04:23:03.0673 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bece6e66-38bd-4009-83b3-08df02608e00
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[149.199.90.133];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00006003.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF7A6EE32B1
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

From: Vitaly Prosyak <vitaly.prosyak@amd.com>

dma_resv_add_fence() requires the caller to pre-allocate space with
dma_resv_reserve_fences(). amdgpu_evf_mgr_attach_fence() omits this
call, so when ttm_bo_validate() consumes all pre-allocated slots the
subsequent dma_resv_add_fence() triggers:

  kernel BUG at drivers/dma-buf/dma-resv.c:319!
  BUG_ON(fobj->num_fences >= fobj->max_fences)
  Workqueue: events amdgpu_userq_restore_worker

Add dma_resv_reserve_fences(resv, 1) after ttm_bo_validate() and before
dma_resv_add_fence() to guarantee a free slot.

Cc: Christian Koenig <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Sunil Khatri <sunil.khatri@amd.com>
Signed-off-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
index 4c5e38dea4c2..26b52378e053 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_eviction_fence.c
@@ -105,6 +105,8 @@ int amdgpu_evf_mgr_attach_fence(struct amdgpu_eviction_fence_mgr *evf_mgr,
 
 		amdgpu_bo_placement_from_domain(bo, bo->allowed_domains);
 		ret = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
+		if (!ret)
+			ret = dma_resv_reserve_fences(resv, 1);
 		if (!ret)
 			dma_resv_add_fence(resv, ev_fence,
 					   DMA_RESV_USAGE_BOOKKEEP);
-- 
2.54.0

