Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADF4FCD4F26
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Jun 2026 17:17:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2950810F6B7;
	Fri, 19 Jun 2026 17:17:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="E9ruVNXZ";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011024.outbound.protection.outlook.com [40.107.208.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 029FE10E0DC
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Jun 2026 17:17:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fHi1SNrSW3xnlnYxAwdck/CQt3Jf+eueNZdtls3MyL9T/v8wBhfyAQW6n2DCLQ5cwkGPg5YXjV1x9NM8JUJ+kt9TpzzoO2ut2IqXZRAuZUtXYKtGgTOMIhnhW9IFqkJhZwkZ3V0Eko6NBE5ExiVgRq6mX9b/sddMHuTNu6vcygOqvNwR+NK1WuWwWaNvIBOPNhReLlX+rtB07Yrd0IzSa7E/o3OSIHGHj7LI+bYLT75JpNRUpyONaML+AUN0dJZGLWdnGv8i2jY7r8Vj2+H07loq4ssLHAvbAgyExELUBQCEoN7P/X29pIbQ8Zp1X5WReqMqpa2dh7sPc9Q8CgtMCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zS/8kjs5J/MHXywNsPUbEs2ACRq/FaBVDsEB7IIbyQ4=;
 b=XG//rDHXvwvczxaJllZOEpvy7uFX9Qfe1A6pnvz4/sctrPqVYNZA0xZyUFn01vfsWbeB1hloSUL8M1kxkyOVbeTEtzhjoOcjCj8RUP83zd4yPKfT41ZGdsHyeBfiXBDjyWmWTdvI47Hi5f9AxpIWqPOwifR2uoqOpmO6afZdWFW9k2cKQKuqD0YJisynjT8znkKzWwiDllycux7F5T7B6MrBmoDs7s2SUFFziHY+2dYPx+qnzsbAbq5NVmyi1POvg9UD4/IZRxunLGWFPg4a9h37sHdfaPA0XKMW3WYUM6qfBxYjzpv5onV9YPaIE4cwu1lEhUlvIr0y5m+5Nl04LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zS/8kjs5J/MHXywNsPUbEs2ACRq/FaBVDsEB7IIbyQ4=;
 b=E9ruVNXZnXy0Lz6hXxWOi+YEmyDe4HDV3As4s82ob2UMDhQrYv/k0HG1jFn4bjspZkmw//ZCn9iSc1VFiiu5zSN0pxFNy34cEzar3In6U30RHUSDLZ4FYPH67mnyPkgGRV/u7hX+U3UatoJJpa1H7vsZpH1Zmzt4w4vaZ9Oh1J4=
Received: from CH3P220CA0024.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1e8::30)
 by SA1PR12MB6945.namprd12.prod.outlook.com (2603:10b6:806:24c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.21; Fri, 19 Jun
 2026 17:17:51 +0000
Received: from DS2PEPF00003447.namprd04.prod.outlook.com
 (2603:10b6:610:1e8:cafe::7a) by CH3P220CA0024.outlook.office365.com
 (2603:10b6:610:1e8::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.14 via Frontend Transport; Fri,
 19 Jun 2026 17:17:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF00003447.mail.protection.outlook.com (10.167.17.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Fri, 19 Jun 2026 17:17:50 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Fri, 19 Jun 2026 12:17:48 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, =?UTF-8?q?Timur=20Krist=C3=B3f?=
 <timur.kristof@gmail.com>
Subject: [PATCH] drm/amdgpu: Reduce stack usage in IP block soft reset
Date: Fri, 19 Jun 2026 22:47:33 +0530
Message-ID: <20260619171733.2976352-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003447:EE_|SA1PR12MB6945:EE_
X-MS-Office365-Filtering-Correlation-Id: 440f01ac-3774-43fa-1eac-08dece26b138
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|82310400026|376014|1800799024|18002099003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: PPZMcXuWu04/F7VXpWlgIZdoSxiIioxTiJCbUSTVDRJpK+hMtwWs3f9/KieP4A8gzAaxq77YfZ3YO3OwsJiaJ9hdYQHzXs5yTOCdV4DCzUAOvlSVQyhyV81vUbMD7IJPXAyLKW8tXRSZB6P2NEneBfBN5yGM+wjCdPTsf4VIl76CFIesI/Ve6+QDGqAAJbZVH6rJv3ZQ1BF/uC6Nf47v1vx30pEGlkdCjycKHofxzxX08PrKbmiyRmiPDvutCE9KjO72SJ4cg6PSoCwQXL+MQK28xbuG+t2WA2H3NPs28StC7KnbsvAwRcgzGr/bH9+JgGd2vZFON/eOt0z99PugYoovTbFtg34yKuFh9rYDF5TGmVHI3tMyLMlzQbba4fnnou8JI7ay8Q+MMruK3saDWzZFtQsG8BK0mFtXx8bhxlsbtklZ99lIbGFyY7oxAna1z03xDtL5/6Q09Wu2l6+O2uBcA1ioDGIRW/XyZhUZ8Dg+vJXoOlBgp0cOhHbp8E42rM2F+CBFqSDezCBiTzV5LAfs+rTpSZWFmqFlkrNP3p9We2YO4BdN6ffeHpfvn3uJgrY0+6W0ixZdUdHEmx8x+RDemLSFk/pGbg9Cqw6ZCM3whhaSi7C1bvdTnYvE+f1yviNzb/h6Hih4X2mZnY6lbF8rELDqHJceBRjfEc07KYRuufkHlff1pAGrkEv1ooOvhFdP3DGy7OMQHP1vbNEpLA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(82310400026)(376014)(1800799024)(18002099003)(11063799006)(56012099006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: VTbY8mw+5wS3vDA8D4Wc+kj3lr3/XQ2fLLzmGIahnxejgssdKvhEORykgmvPUGvELrZH3jykiQEGtx1Gtrm9JlDDvA3sk8BATBR2989VCs8P+AaqqiZmjIgBaBEJwxxCg6YMpsrTTB2X2uZSjcJnDZAN7kK+MYWTE7o97o//nLWuqamoMNn8m76Fgj7+rvO8Mq898vQJgt4VubxitvRris4yB0mwjPK2OWg1+lmP1DMODKNaWqpU2JJOAShHzLx6E38CrrZyuWXBO/dszavXDLkPuXPKriAvUGd3xjTeeYPHJgmkI6bOuBC8jsFtcBgmS/FQXUILQafx0h3ZhwOsar1qgOiiXWomApX0x46mXmItOvP8bFEw1DliNDQuTEMGegRgZE0DC15QBa/pnUz+cvPqLaRJ10S7AusPxpY5ILHWmi9JsHW8aUel2gKPMJK3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2026 17:17:50.9716 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 440f01ac-3774-43fa-1eac-08dece26b138
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003447.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6945
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

amdgpu_device_ip_soft_reset() allocates an array of AMDGPU_MAX_RINGS
ring pointers on the stack. On 64-bit builds this consumes around 1280
bytes and triggers:

warning: stack frame size (1304) exceeds limit (1024)

Move the temporary ring pointer array to heap allocation to reduce stack
usage.

Fixes: a6319ac34a13 ("drm/amdgpu: Add IP block soft reset as a GPU recovery method")
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Timur Kristóf <timur.kristof@gmail.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c
index 65505bc50399..eeb9383b1010 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ip.c
@@ -524,7 +524,7 @@ int amdgpu_device_ip_soft_reset(struct amdgpu_ring *guilty_ring,
 				struct amdgpu_fence *guilty_fence)
 {
 	struct amdgpu_device *adev = guilty_ring->adev;
-	struct amdgpu_ring *rings[AMDGPU_MAX_RINGS];
+	struct amdgpu_ring **rings;
 	struct amdgpu_ip_block *ip_block;
 	enum amd_ip_block_type ip_type;
 	u32 num_rings, ring_type_mask;
@@ -539,6 +539,10 @@ int amdgpu_device_ip_soft_reset(struct amdgpu_ring *guilty_ring,
 		return -EOPNOTSUPP;
 	}
 
+	rings = kcalloc(AMDGPU_MAX_RINGS, sizeof(*rings), GFP_KERNEL);
+	if (!rings)
+		return -ENOMEM;
+
 	dev_err(adev->dev, "Starting %s IP block soft reset\n",
 		ip_block->version->funcs->name);
 
@@ -546,20 +550,25 @@ int amdgpu_device_ip_soft_reset(struct amdgpu_ring *guilty_ring,
 	amdgpu_filter_rings(adev, ring_type_mask, rings, &num_rings);
 
 	amdgpu_device_lock_reset_domain(adev->reset_domain);
-	amdgpu_multi_ring_reset_helper_begin(rings, num_rings, guilty_ring, guilty_fence);
+	amdgpu_multi_ring_reset_helper_begin(rings, num_rings, guilty_ring,
+					     guilty_fence);
 
 	r = ip_block->version->funcs->soft_reset(ip_block);
 
-	r = amdgpu_multi_ring_reset_helper_end(rings, num_rings, guilty_ring, r);
+	r = amdgpu_multi_ring_reset_helper_end(rings, num_rings, guilty_ring,
+					       r);
 	amdgpu_device_unlock_reset_domain(adev->reset_domain);
 
 	if (r) {
 		dev_err(adev->dev, "Failed %s IP block soft reset: %d\n",
 			ip_block->version->funcs->name, r);
-		return r;
+		goto out_free;
 	}
 
 	dev_err(adev->dev, "Successful %s IP block soft reset\n",
 		ip_block->version->funcs->name);
-	return 0;
+
+out_free:
+	kfree(rings);
+	return r;
 }
-- 
2.34.1

