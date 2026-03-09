Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14612F417EE
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Mar 2026 14:57:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5F1B10E522;
	Mon,  9 Mar 2026 14:57:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="320OwxM9";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012008.outbound.protection.outlook.com
 [40.93.195.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 813DA10E522
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Mar 2026 14:57:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W9dv5/1qdoToX/hw7m+zZlwjmHsgZ3qlSeyQTzS0pQjZTZ9IW1/esVcSKjTYe1s5JxhzzYBr0fRokcLDAWLrF72+lmwE6SEYWkIXRPk834jw3Q0pf1DfOIN6ny86gFeGEls7uGiIb8lbtAwfWiiQTBkK9n4D7DhWxoO12mVZPCVxTTni4xKXQyOdxq5LHnuGBmEYiSAxcDPzUHMNT1KzoqySdMI+Kw3G25neZxsZODFOVCJCaAmbI29ttDNFnweaDZyNr4hkSRrQ5HFkuBqKiYvEyodjnHeGJdl17YmJKcjWkHundKY18dTaRBHmu5rmqc7TAF9QMbHAr3+iD0/yGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ZnZ0ERQMnn9qvyAPb6rxvnUZuSR5sBH1m79gaL/now=;
 b=gTsM0rUwXQTHBfdx33QmEIGceOHX4ZIuEgHFX5nbPvOilnkOl/2wrDQWz6bxm9xARCvbeKw39Uh39MjY4RjSYSJ8fYa9xB+xzXOqPt/Q+FFVPK9S3BQCVfJfKoBp7I7EvMzWtqt4rA6dz6tpUSrQNXOQJOVrogkTXeuxBjFs0Zv5Uy4ikxxMRPdq/JRrZcvMCO/v7T/cUz5o55wgGnE3YRYgCQHy1HdxdSqsrmESH+C3cPc87b77xPBdsz1T7T07Ek+4f9+mUNUyY0xdnegi67Qx56W3MJkk+9Xh5385ZO9aXS+TAfz9/9qL+0p01eur5pHFc7cwOFa9bU40Nwwtmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ZnZ0ERQMnn9qvyAPb6rxvnUZuSR5sBH1m79gaL/now=;
 b=320OwxM9BK8/iaBus8P/e8g5vSupLMHUvYdNYt/qKEt7CZ4n9Js/cQDNM+VZ7+VTuEOW7fR397RnYamGV1OJ5lVZM7JeL0YXJYY9Xp0F+vG4QekpWVuOqBZ2zXwg9M9NjUMN05tc5vTj04P2iXFuHale7HUIUoFNnlJPYMvGGdk=
Received: from SJ0PR03CA0381.namprd03.prod.outlook.com (2603:10b6:a03:3a1::26)
 by SA3PR12MB7924.namprd12.prod.outlook.com (2603:10b6:806:313::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Mon, 9 Mar
 2026 14:57:13 +0000
Received: from CO1PEPF000066EB.namprd05.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::31) by SJ0PR03CA0381.outlook.office365.com
 (2603:10b6:a03:3a1::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.24 via Frontend Transport; Mon,
 9 Mar 2026 14:56:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000066EB.mail.protection.outlook.com (10.167.249.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Mon, 9 Mar 2026 14:57:12 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Mon, 9 Mar
 2026 09:56:50 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Mar
 2026 09:56:50 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 9 Mar 2026 09:56:50 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Hawking Zhang <Hawking.Zhang@amd.com>, Likun Gao <Likun.Gao@amd.com>, Alex
 Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu/gmc12: Init vram_size for A + A
Date: Mon, 9 Mar 2026 10:56:27 -0400
Message-ID: <20260309145629.2844495-17-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309145629.2844495-1-alexander.deucher@amd.com>
References: <20260309145629.2844495-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: alexander.deucher@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EB:EE_|SA3PR12MB7924:EE_
X-MS-Office365-Filtering-Correlation-Id: 33cdd972-bea6-4c69-66ca-08de7dec2571
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700016; 
X-Microsoft-Antispam-Message-Info: PPjeKtM8hMPtAez0BRtArXe0Em5LIUarJ0qCVB4CzmQLjYUU5pYiQAM+NoAHNQFlP+XZSgNxfz87BbmYmc7SzGih2Vn3ZI3+26yeEvtNgwgt18r62NH853vbl1mYuCealnPKDsNinXjGDYSK7N8jxGhPnn1MBxeBILdrBDYM9xkQKEWKqgEWW4PCzwj9vvUuN5b0yVtV4jPrKy/keYR1fbaCU9tgRnW/iRbGHzEENBUef4h5ou1YM/OK2dNosLQseKzieIOFmr+yshQ5+blaa5n09WtP67eXpH1JaAwek9djonyixXwy3eNl8ksNvAbehCTx/AWcv/KQ4ofPQrgzABssIe1NP7r2DuOkxe4ia7zfZonqEoAkPJKEooVtUXKlAUByB5b+9t8dByNrNRGRD9OJ5QRvl6kfO9GrUEEEL1W2ZhYfWwvbcjdxJatETk98+DIOngcP5WeqAQg80bLaz91SGJNZkee8eCByOjflOpWKJZ0Y9PaRbofuGSBoTRPnUv1ncLykl+VwT+CywT1RhwHdk5/t/AUHREcxTooru4gx3RMaQB8/mvMDSQPrAvxUK4W/YHQ1iIyt8j7cRHY2YbDWcMRwezYQQRsFE2IcfLqY1DP+aR4bVygpYtAl6jpQo7ZdHy0sDRu5DLn7yai6enAFQbpo/AzlR5H+5veNWgxi56+UpVUI0qF8HHkNY4u5phcLiTvimzjvzJ6JpbrFtb0C+2UCejOoAFtWJDz8oIEZf9tM6n0ZJFDx6m27F7CfQhPbeyTlv7FFxe2i0FO95g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: IpsWf0XNSLMHtnKFjLhDRehuB3497mVDAKyTOx8FB80pZNO0N5AyucPyBitfrNF6AtOIQ2/DB8Y9iv56mVdFXr9Rq8FbG1MAP433xQB/V3e0p0vjf+h7Utw9eGFw4wMejoBhW/0hWAuead259oD0WzPUE+V5U5IDtqS68voR3rtWswuR0tk9TG1bkaiT4rIhOM7+W03hApxp/IYyVbtp4w7UeX/RZ3vAcECriq8/W7PZktGyi2GAL6vAXvaV0jAXHtamwPuy8XgkQV1sArLwTb+tzF9oMwVI5LVNkQcWBZBRlckiJIKC5TlHYltLI8k/S6gda8lUPSRdtuG1et+K1E5QhVGw5vQqKgXOPL4dVg/thJklg6lMaQvWuOOxTm8wlkSiSj9bH55awg8nmbT7vt3twS2SXRXUmxmPTrxhUB3ozzzKlz79/oryh3vTXjTQ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 14:57:12.5709 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 33cdd972-bea6-4c69-66ca-08de7dec2571
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066EB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7924
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

From: Hawking Zhang <Hawking.Zhang@amd.com>

Calculate vram_size using the XGMI node segment size
and node count for A+A configurations

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Likun Gao <Likun.Gao@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
index 2b5f01f15fac3..ac39011d1268c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -728,9 +728,13 @@ static int gmc_v12_0_mc_init(struct amdgpu_device *adev)
 {
 	int r;
 
-	/* size in MB on si */
-	adev->gmc.mc_vram_size =
-		adev->nbio.funcs->get_memsize(adev) * 1024ULL * 1024ULL;
+	if (adev->gmc.xgmi.connected_to_cpu)
+		adev->gmc.mc_vram_size =
+			adev->gmc.xgmi.node_segment_size * adev->gmc.xgmi.num_physical_nodes;
+	else
+		adev->gmc.mc_vram_size =
+			adev->nbio.funcs->get_memsize(adev) * 1024ULL * 1024ULL;
+
 	adev->gmc.real_vram_size = adev->gmc.mc_vram_size;
 
 	if (!(adev->flags & AMD_IS_APU) &&
-- 
2.53.0

