Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4C4AC88E4D
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Sep 2026 17:56:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4211010F470;
	Fri, 11 Sep 2026 17:56:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bsP9ZgVY";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010046.outbound.protection.outlook.com [52.101.61.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 25CB510E4CA
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Sep 2026 17:56:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YrCJgLy5zH6FEqWDFH7vdI8lqU9GNv2GqzXecWw5AdNCzr4pIxfTFqrjzntOL7NvEJwELn33VsDSVJhcLNB5IlRT4pMujxrq2upz1SWxIiBlNZ05AVsdn4sucebsFl6D3NMdjcMFyZ4wbggmdA5x7Y6+1nnhrGn3M1lGU6tB5leebyj14u8lO2/Q4N6I/A2JATW3fS8nd2XbnaFeKavBeRZquj8V0P/QVdL0ueEUZCf3vB6aPjsKn4hIPV75e6SasfsuBl8CwGsLr3gWmA1SsnApxCP6dqZnKx2LArBvBL1cw2FK1kwNrcee4SiT2nvU95a34qfoaK1YnJG/5lPbkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=76oZRnDLJuKV4Cm78ZiDfkkDUF47wo2VISiDCpK11pg=;
 b=Ws7g4H8voPHmz6/REE8n+0vlvi3iEKoCbRT8Z+0x00YU3MF+ucMrvwu4Nf+wAasguiRGhlc1on5jBMDTvzs27JI0RUg84tG4HCquk0d1i0NTFViFiYB0Sueo+BhQ1F5p4hxpVZtTtWxL19DxUfMjId0hbWsKLFEyC9JqUHbBJUM/GzArcDbufUH8OzUJ+R49/1h1ZqM3zpVnQyzcsjS03YidmANgaiew5I+t5VkSELLbouc8FpYrqq477INfvR0UBlu6e/4B7IWxGiJ/4i3XF1OLNhs4ACt8+tPo5S9pe+M8AO3mXv+pYbnhdx8UdPdd46ptshfCI0xSt7zrM6fZlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=76oZRnDLJuKV4Cm78ZiDfkkDUF47wo2VISiDCpK11pg=;
 b=bsP9ZgVYzm1LoOU6VQXgElNmylJYN5fZaAhImzJ1aqgDbhokPqfdjABlK1ahNzD51hWRWeezmm3exyUiyRAFws66KyJ2aOb3y7EQLvQBAYtixvTC39dlEuMN12c5ODX61kPq4kRqBU+DfGXxwWFmAIeKo58cVItdmdy4I3ZiJHY=
Received: from BN9PR03CA0178.namprd03.prod.outlook.com (2603:10b6:408:f4::33)
 by IA0PR12MB7675.namprd12.prod.outlook.com (2603:10b6:208:433::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 17:56:03 +0000
Received: from BN1PEPF00018071.namprd04.prod.outlook.com
 (2603:10b6:408:f4:cafe::ae) by BN9PR03CA0178.outlook.office365.com
 (2603:10b6:408:f4::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.10 via Frontend Transport; Fri,
 11 Sep 2026 17:56:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00018071.mail.protection.outlook.com (10.167.245.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Fri, 11 Sep 2026 17:56:03 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 11 Sep
 2026 12:55:56 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Fri, 11 Sep 2026 12:55:56 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 02/23] drm/amdgpu/gmc10: disallow gfxoff around TLB flushes
Date: Fri, 11 Sep 2026 13:55:23 -0400
Message-ID: <20260911175544.1314467-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260911175544.1314467-1-alexander.deucher@amd.com>
References: <20260911175544.1314467-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00018071:EE_|IA0PR12MB7675:EE_
X-MS-Office365-Filtering-Correlation-Id: 05b2b3f2-0a94-46f4-5f24-08df102df261
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|23010399003|1800799024|36860700016|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: BQeWoqh2bmAH5vvaEfXOLM4JpWOXqt+WWgip7Vo7BtjytBS9PFwrPJOc+g3ixfay/MLroMlDNveegvNFoM3PHEmNm1vywF2UDYWNlKU38VI5Khc+Q9Tyf2cmGwp1Ybfdv4jhSD9WZbIvzgGGqa+NqlkvYIoa3rg/k7muI+ljDO1uVz3uHDwH6jcAWQjdIoMc2R2XdK+Bg+LFlVAP0DlzUNyuw9X34bCyHEArX4sprt9ok+Yp48j2yTg4zJwNQO6ntJTtsTu90QHDa8zqdmI+D2jUQkQGHsujvZPkILLYfsIVVQWyWIt7Vz0TqwmmU4E+NP0p05pEuIfqX4+TIGamayVi4ggpDta8yro/Moym34hk2guZJQmqDNQ3BqFEPiaTcbojSedgTViPf2E4QEPchajmxLkCPE5Pa6JUg6ND2BpIMafi0yIuvo15WQdTxVobCHxoI2xj9M2XXXeoy9tNxYn/12PNb6/2g3MhsIPIr3PYFGkInaRukoYjRfb5sgqX4V6AiB6YxmiY8p1Rs/h3u41Uaarr43UE7ird7j2WdksagsiV6nS+7AB4VW+pDIncRv8jB2Zq4FPxMrnKJSxnu9cy5/SCNKl4X1mfOvN57gpbn1qYPAaubhAQkHs6qBK3ksPrSuip++aeBeQNn+sTG6gBmAixjoQJ1Mll25SNi+4EXZMPBEVzLmBqak8CoWKVipC6+gXjNHE5LgEN7iiJUw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(23010399003)(1800799024)(36860700016)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: kNR5NZ+De10TLpo4x3N8q6bq6j3bBNupNELNk6V02TQbZ6Qzieq1p2IDIvEX/c00LVelUDTfhOBJi4VK46W3rpaqceZqUWUgU3JIEiAyGWN4z9VjZ2nLE9WOxOGd8rkzdcte6C/q0e5Ym34l1tssHcg+3uRNUhnln+WlQzjnXh6OHeQaTNUIfT7UN3C8xqr8WDBNVKTk+sZ3O+Ls9Mn2585H4KH8hh1LzlgBlSVn9UqN9xzfJ1NPbqh/l04sTbSf0dAQQssP78Wh2WEsi3fxgniRrHbI+Xk2smICTTrlvQjzy6rwPq24dat4LON1oaKJQjjPhpQP9zuhuPn1OEfs/QT/q+s/1UdHcLRbga/CjgAXxFVqYPbN1axxGc/sHgmfl2h0vyWfy0R2PyD9ngkMLrMks2/Wmdzj3evP6XlMiXdOBRCG7nF9y3/ulBgmuoBF
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 17:56:03.5521 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05b2b3f2-0a94-46f4-5f24-08df102df261
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00018071.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7675
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
At the moment we use KIQ for TLB flushes so no intended
functional change.  This just protects the MMIO access if
the KIQ is not available.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 9a8a7921ce982..4f287e9118893 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -265,6 +265,10 @@ static void gmc_v10_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 	/* This path is needed before KIQ/MES/GFXOFF are set up */
 	hub_ip = (vmhub == AMDGPU_GFXHUB(0)) ? GC_HWIP : MMHUB_HWIP;
 
+	/* disabllow gfxoff when we invalidate */
+	if (hub_ip == GC_HWIP)
+		amdgpu_gfx_off_ctrl(adev, false);
+
 	spin_lock(&adev->gmc.invalidate_lock);
 	/*
 	 * It may lose gpuvm invalidate acknowldege state across power-gating
@@ -313,6 +317,9 @@ static void gmc_v10_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 
 	spin_unlock(&adev->gmc.invalidate_lock);
 
+	if (hub_ip == GC_HWIP)
+		amdgpu_gfx_off_ctrl(adev, true);
+
 	if (i >= adev->usec_timeout)
 		dev_err(adev->dev, "Timeout waiting for VM flush hub: %d!\n",
 			vmhub);
-- 
2.55.0

