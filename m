Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC5DBF9EDF7
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Apr 2026 21:52:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C1F810EAA7;
	Wed, 22 Apr 2026 21:52:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5FrYdN1W";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011000.outbound.protection.outlook.com [52.101.57.0])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15BC010EAA6
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Apr 2026 21:52:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yylxMaO6TDeWCbTgao6+hkDglbAE654PzWdioinpmUA/rBg2fMOWlzw//43jhpPzFiS8nuceDBp5UYI0pGYHUknvlITriwCL5teG73QuVmpbuKFiIIfc/JqPJfR7JW9ZeNuzUxuXJAB8Qc53eOtu2ITnpttQmW5tHmx2R3gpuzxgVaGIFXxa6E1fCr3uF4nMbsmg7zeXVUrYBrHO3lP+VktpbSHoaoRde3z4t2t5ocFw2wDEbZE0Rb/1W+XazhHKPXPwtrcrvYOenmg1x9m0BCNYTp8DTTW8JHNs0r6MyqimbK/k3rGlkK3y2D21rHupR81urUkTRepHzikkdMPxXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y+Uwo3qPEAi9vCrgomPx/+vrS0XtWZXG8pEa1wqi+aA=;
 b=hqnyfanv55aRFf9aGkx+AY2XC5WSI+r+FOqbRrNhSIGoIzus454YhYssEQlpBpj4BlstEq0NF3WS1utVz1k5HoL5g4S59Z77tdJnBfINiriToNv7nLfATtVHD8GI+PyDiicf6C25Iq/n0/N6MTRt5btcT+pdNpDE98rBHP4+A+P0UwdQ+IuO8O9Fnch9bJ4md5V2/yvDCp79L0WiGzhWKQx/C4eKx/g9ZtfqOblF+kxAoFofHBqtVNHPa+sDnRtFAKwoGpNgkGqP9ZZTGrVTbsABwAYkf102o/tBun+EE9apIFiFk6l+SNdlgrHj7k5JYUJchOBMevBsuLCNNycB9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y+Uwo3qPEAi9vCrgomPx/+vrS0XtWZXG8pEa1wqi+aA=;
 b=5FrYdN1WpUYq8LYTQlK8I25gQ5npprMRM4w5LvWEG9Hn/vrV6J0XSSIJ+UdoQTDwgQ2MW3utXGboSflhdRpvXnutFiEtJJc45iUKknnQfKg7ZApJEopNo2TXlJUTGPU9E7nrVdoyV5Lz48Q5b7AQih/IkzlkYVN88kQmH9DWeN0=
Received: from BN9P223CA0030.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::35)
 by PH0PR12MB7932.namprd12.prod.outlook.com (2603:10b6:510:280::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.19; Wed, 22 Apr
 2026 21:52:15 +0000
Received: from BN3PEPF0000B076.namprd04.prod.outlook.com
 (2603:10b6:408:10b:cafe::cd) by BN9P223CA0030.outlook.office365.com
 (2603:10b6:408:10b::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Wed,
 22 Apr 2026 21:52:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B076.mail.protection.outlook.com (10.167.243.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Wed, 22 Apr 2026 21:52:14 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 22 Apr
 2026 16:52:13 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 22 Apr
 2026 14:52:12 -0700
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 22 Apr 2026 16:52:12 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>, Philip.Yang
 <Philip.Yang@amd.com>, Felix Kuehling <felix.kuehling@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 1/3] drm/amdgpu: Set chicken bit for gfx_v12.1 xnack
Date: Wed, 22 Apr 2026 17:51:57 -0400
Message-ID: <20260422215159.2242821-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B076:EE_|PH0PR12MB7932:EE_
X-MS-Office365-Filtering-Correlation-Id: 9511a4e5-730c-4703-59d1-08dea0b96a2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|1800799024|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: HlUK4InJ+jXMjHvUDe5Uqmln+Tk9B3hC3dPCNcbafBiXTpwyYWz/iotH61zSJtXfrC/2geLQIY3Eb/mcBqWSmECDnQpYrT/6qO/Mya101JMsP3jxdRTHZz4jPcKltUOp2O0IsJeodZKN3iICK82AqiaSvQ3cx8iUroF5V2efPgkzYLRUvAmbvK4wqupR0e2+9xk8KAc8sMS5GMYcn3dGSPtKY0TEHvfJq9I60rXDqFe8zIgbCVXI+XsdtMsggh9zcXEfxpO0Ybw7Z5BBcFl6MIETuLB5N/FxWMaOVxPji/hXXwHXOedHu9wgYVEClsYI9KPxQJp8XFWHb6kofhafX45A7obhx5MoMSjSUrN2/HAgzUvOQd5LrQQ0DnmydStY6lQz4XO5Pq9K1mt2R5jDZojO5OTOD0gO/e+oFqQCr0xUdwRvVWFUz9UWbw7/cID7jnt+PhDd7Wg0eIC9XNvtfdBQOD6oLvzIU32K8KuDj/YC7nEqXCj7YO7mp7NBsTB1ZcG6Qf7VI1sRGslk6aTbmCHiU9FemGpnyhZja6YYjQRpE7hrqnlhOXzIF6o8sKh21w6S3aMnksECNI49j/wmoZlyv9ax3oW9Y69YqskE6+OeebIUdmx43QLlmIEh+8k8dtd4w7xVBA6Yle4SefTpDRkr8d6UqYpuNYnpkQIrq5DLvAmG0GBCXGuBdjsGsmhKZ2Q0xYj2iJI758BdCV292Oa9YqJSqvHLZ6X6OkpsrazxFzUA22tLuQP4XzRvKR0Iesohi03F5rbOyr9DM1t/Xw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +FsJRSdkE7WngVn/QW2scezRRArg9rRCHbayhy/lfp5HSQXG7cQqdm+HXeKKwljtd8MgcxgBMCK8iIWxGVY8odfLzoQjZYIXAEF3o/W7F4sw0jzCXLtPSlPunVNl4DvqKG6XnHUUKoJN7VSb6KvN2g+N9sCKLwJQ7Lkv6+SrPHfqQNWvxZhqigQSGZ6tEt4JAUHFQwg89laQ4CsG6cx8Zob52ZAYiybCDeOKp72UviWucqEvnAwDAnM2ifZqsKwgKUFBeAELHOG/E2iHngFTRLoHDT0neneZZ+6EdXOZsx2aXfNLE/CSJNFuVGf5WRALm+bwa+9zq3/s9/JK8L7WpLgstGZS+a4J5afbIutyO5u8dyVyFEZtz3HLHDIOl9R/CFBYO29K5lT0buFMemoBzFSBSo8FEr45Zo8JQUX2eN0OOZjF/zVlYRF/9+hWrBT1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 21:52:14.3597 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9511a4e5-730c-4703-59d1-08dea0b96a2e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B076.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7932
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

From: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>

For xnack on, set TCP_PERFCOUNTER_FILTER.COMPRESSION_ENABLE to 1
For xnack off, set TCP_PERFCOUNTER_FILTER.COMPRESSION_ENABLE to 0

Signed-off-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Reviewed-by: Philip.Yang <Philip.Yang@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
index 5412a528f78be..5b5bfc379e9dd 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
@@ -1475,6 +1475,19 @@ static void gfx_v12_1_get_tcc_info(struct amdgpu_device *adev)
 {
 }
 
+static void gfx_v12_1_xcc_xnack_set_chicken_bits(struct amdgpu_device *adev, int xcc_id)
+{
+	/* NOTE: COMPRESSION_ENABLE is used a chicken bit to enable/disable xcc xnack */
+	mutex_lock(&adev->srbm_mutex);
+	if (!adev->gmc.noretry) {
+		WREG32_FIELD15_PREREG(GC, GET_INST(GC, xcc_id),
+				      TCP_PERFCOUNTER_FILTER, COMPRESSION_ENABLE, 0x1);
+	} else
+		WREG32_FIELD15_PREREG(GC, GET_INST(GC, xcc_id),
+				      TCP_PERFCOUNTER_FILTER, COMPRESSION_ENABLE, 0x0);
+	mutex_unlock(&adev->srbm_mutex);
+}
+
 static void gfx_v12_1_xcc_constants_init(struct amdgpu_device *adev,
 					 int xcc_id)
 {
@@ -1502,6 +1515,8 @@ static void gfx_v12_1_xcc_constants_init(struct amdgpu_device *adev,
 	mutex_unlock(&adev->srbm_mutex);
 
 	gfx_v12_1_xcc_init_compute_vmid(adev, xcc_id);
+	gfx_v12_1_xcc_xnack_set_chicken_bits(adev, xcc_id);
+
 }
 
 static void gfx_v12_1_constants_init(struct amdgpu_device *adev)
-- 
2.53.0

