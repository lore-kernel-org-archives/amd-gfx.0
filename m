Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2690C61CE2
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Aug 2026 22:14:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DDF4F10E594;
	Mon, 24 Aug 2026 22:14:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OD624hck";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011025.outbound.protection.outlook.com [52.101.52.25])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E83010E587
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Aug 2026 22:14:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BJGK88dZDrHvoCEfCQhARsdY/vsmzDA3GXkqxVf/eXL7weOilFV/j5lNY+IABJG8l6LHoeu9mi+zk8kmAhF5K3kqro2G8dm4U/X/fdDSvPide8YUm4FBtIaC3oZ4OkNw5l3MQbsGaX/8M7i7lWFev83u1bUbY7CGTDGQtciw0OxRn2jSdtuXl/ammL3dzwfiZWs4ukoUDXO17YErls6nIy4sHr7n1ztnyRhSyORIu26Dl8HQtzjYiTpWJ4w2Xm2kpNGECTuCm48ZOEFM4cXYMmYNU5QJdQYXkV5S4SaeXWw5pWuB9nptmW7lWZPMTYh4w+GlDQ/YD/I9J5laSTTAYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qkg0lbSPv2HEvqLZ4lHdIw6vHo50gqSieep5eOyOPX8=;
 b=enmNjOBH7FxTjXr5eCULVSQC63d3BzJ8V52oU0Hhzr58O9I+sMeTTxReXaJBmi+sAsoN0wJJarf8ekm6WoPemFkDR4nst5uhUq2UBgHFW93TdeyLqw7wAXYS/murqS3rH0f8Dp0VKKViJqp06vChzd3+qbqOYLsD1Uba61ftgeF7HmBuOffkZwgssNNJUvuT3gKIjEF/FmDGzPTzYj7rFzAENWCmN7w6EBmHX4gv6M37x0FfDr1dlbErdKouVEWKDN0vwyP4bn8ULsSKEsVo4mrJM+lrRwou1zd0MJ+DjuqLTBHGnAOcYdhNTACUfDQUmFHRXma/fHL1gRqODaovVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qkg0lbSPv2HEvqLZ4lHdIw6vHo50gqSieep5eOyOPX8=;
 b=OD624hck0oekhwzW0EG+QVh2hIc2yp1O/xSu2TClWYSDTpCBH/HIVI/5EOg1bUVvD6KAYlpK/2qvwy8uBBX2HNtVyJ/6EWMo0XrPdZt227bC+UVH3QBkpxqwTUNRiru1unfYur2Z4SNProPECwtNv+PDPXKYUfL1fvWATBtUNpc=
Received: from MN0PR03CA0005.namprd03.prod.outlook.com (2603:10b6:208:52f::12)
 by SA1PR12MB8164.namprd12.prod.outlook.com (2603:10b6:806:338::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 22:14:07 +0000
Received: from MN1PEPF0000F0E0.namprd04.prod.outlook.com
 (2603:10b6:208:52f:cafe::24) by MN0PR03CA0005.outlook.office365.com
 (2603:10b6:208:52f::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.12 via Frontend Transport; Mon,
 24 Aug 2026 22:14:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MN1PEPF0000F0E0.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Mon, 24 Aug 2026 22:14:06 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 24 Aug
 2026 17:14:05 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 24 Aug
 2026 17:14:05 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Mon, 24 Aug 2026 17:14:05 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 01/30] drm/amdgpu/gmc9: disallow gfxoff around TLB flushes
Date: Mon, 24 Aug 2026 18:13:23 -0400
Message-ID: <20260824221352.1793542-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260824221352.1793542-1-alexander.deucher@amd.com>
References: <20260824221352.1793542-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E0:EE_|SA1PR12MB8164:EE_
X-MS-Office365-Filtering-Correlation-Id: 36ce2bbd-0e9c-4886-fd4d-08df022d034d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|1800799024|36860700016|376014|10067099003|56012099006|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: VC2D29W9O1k4GdclkmszPxSnXzpKXBiolt0J3Ehjq9uCq+TdaSNrCNZFHU2y9G8m/Nmjk/izLTsXv05bLDtjI+tMdvlCiW4cy1PANLizO0iOsbZVWj+sm1WLBknQBUWVgh3EAkSNUHsYjXE52y/Ac34scPt3RhHbtetd5gwEp8Crs5QTXWf0i2tvsxRdK6A70O7yvS05fRMBhNjjqsoxKRqIUIh55IyT6n6dobVTftGerr88cNxTZ2UjMvxT8rrtMJNkMtDNP7lKiam1knD3q7vjtgRMUMHsLwkTGtCkG+aYTDhlc89Yq3YESYnTHFz+dXvXFCJwZCXBFP6kajJkI30bvZ0x2p5fZZZX0fYcQiy1JfxWY7/oMo5GFCrP1GMaZxwOF/X3JqNxJcRwm4LbrmILLYvzfavL7zeQPxOx6bH8F9wQL4l8G4aLLPtDR9x+OFenG0rLkpzmXHZD9cgRQgx/PiSWTq+vLg3EH8AL2SPS6/7gfE/KN3hYtRdu4HeBDqS+mpaHuaBvGpi9ZJUvRQ/FXC19dbcolFvhWjaBMHXdd+82x3E+VdDPrxhIjDcZqVVbjM6LBRqZauKAxmv8DRyVlKpeRoW/rHKEuBlOk2NUc/gU2MNB65plF4yu6uFjPZeJHowpdRwxZZhBYvXeMBtcvRGNxnc4P+/uZXqGAJwcPkWj+O1DsTpxaV1pZsQ6HgOThmqrEgrAzXxAsY/Nlg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(1800799024)(36860700016)(376014)(10067099003)(56012099006)(22082099003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: JFE8kZX0Q0XOnLZ9K3LHLUB5vpjrMrbh6Vv1UGzMqoPnqlaXrdgQEnqfApbZcrDqMOx0nZ33nVWOcPsvnpUvQZHy6PtC/PKzjeV2nI7FGDsLXGAGaPBv6zLaLFh+xS0vHCMiXoT4DMxmFtvVnYGvfc8FPSFEaX94e3UOoajb5DlDCHoRwDun7RUtUHQD6Y04XoEj+rU+tq5IQXTXe/9m1LHMSqHKsIvg+cBW8rQhq8kkNTzIj1szaDcp+6C+XUzbgrVHmJ1jz/9TcKNALGyBc8bJUP6M7TKmKylO1lbfmnBAeMbTkDyYO6xW1TC0qfv2h6fMc//UHVDGHu1BPoZ7RX0M+01En5wlrNbkr1ZtVu13QHOk9oNVFoeIyqqyVlQlaaergZmC9YkQ6jrqMqUvjiZPKjgEVeTAkPjesijx+YEW+nCsUez4yODF/aO0lcot
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 22:14:06.1641 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 36ce2bbd-0e9c-4886-fd4d-08df022d034d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8164
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

We need to disallow gfxoff if we touch GC MMIO registers.
At the moment we use KIQ or MES for TLB flushes so
no intended functional change.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index b46b87291c512..80f1cf1f21736 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -808,6 +808,10 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 		return;
 	}
 
+	/* disabllow gfxoff when we invalidate */
+	if (vmhub < AMDGPU_MMHUB0(0))
+		amdgpu_gfx_off_ctrl(adev, false);
+
 	/* This path is needed before KIQ/MES/GFXOFF are set up */
 	spin_lock(&adev->gmc.invalidate_lock);
 
@@ -873,6 +877,9 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 
 	spin_unlock(&adev->gmc.invalidate_lock);
 
+	if (vmhub < AMDGPU_MMHUB0(0))
+		amdgpu_gfx_off_ctrl(adev, true);
+
 	if (j < adev->usec_timeout)
 		return;
 
-- 
2.55.0

