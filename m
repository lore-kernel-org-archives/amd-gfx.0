Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3F90FF8868
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Apr 2026 16:00:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4026310E800;
	Mon, 27 Apr 2026 16:00:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jDzB8HWx";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010030.outbound.protection.outlook.com [52.101.61.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3E9D10E801
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Apr 2026 16:00:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mNAPBMYZoq4wHjyUrOJPp47zWWTKA7hue/7ufng8APlk5oVns23/fh80wxzLmFghwIubKZAy2uVBn1tVBBrVkQxhQGNLHMjb1rXrQyl8yRuPkHHHsb8NHvONE8ZBs7DRcIV7cZF/FIaYP1cpg03xym8fEWaPW0ZrDPeg2zW/es3Q3eBGLYgLBqlvnKWF8qc/qE3M8I7iCRXjeCqAFaV00b18KETr3sXR3hASZEtTUYdj9E6iaS2x+1dbzazPLme9tlLVBlaw7voBFV1OMI90rF5uWzM7rifbUJ/3CNDc7bZptYJLvWdSiHTWMx6PMZzwTX7YCAO04M0ceL0zXMXgTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BCVu+iYckPR2fJh199CDF86m1/jGieuEMhWtZAa7aog=;
 b=y53r9EGCYsZogXVa0LBu3DjlcZB0sZWm6bkx1TzMOiN0Vk+64SpCR9h5/rfrDea4mPG8U07yJt8eMP9M6xyXqK1TWz9hpik0RsmP9AQsO6TAcqIR27WdpU8XB7tqn436EvEb8kM1gEMFfKrzARK1yxyz3liAEPTDjM2cEhDIGpgq4HB3hIKVCeWV044QBAL3C+kxC4xgcbWGuikp5UIZchGsI/q4HBwvby2Rg4jM6qFc4dT2jfP6G+S3CFuBPufmV2m3HvqVrTLkdI7Tyfjd/Onysdl9FI47n60mnxeK4jvgf9NNr3/3jjKTvQbU5mx5P+1o5gtER+vj1CocYd90ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BCVu+iYckPR2fJh199CDF86m1/jGieuEMhWtZAa7aog=;
 b=jDzB8HWx1mKRYle/5BHXze68BRDvxlL819NEGhwiliLdYpXuvO6q/t+RDqjBUU3oO1SOLGvDJYDXfURU3IHRU8NiIiApWGgSyz3gpHZBEcJ83/jSggOEU8vq7PuCw5rBIbRIUgEdJB6q+reIjf7ouDsX+s/D17JaNSUSNlNRJ94=
Received: from BN9PR03CA0757.namprd03.prod.outlook.com (2603:10b6:408:13a::12)
 by CY1PR12MB9649.namprd12.prod.outlook.com (2603:10b6:930:106::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.13; Mon, 27 Apr
 2026 16:00:05 +0000
Received: from BN3PEPF0000B06B.namprd21.prod.outlook.com
 (2603:10b6:408:13a:cafe::2b) by BN9PR03CA0757.outlook.office365.com
 (2603:10b6:408:13a::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.26 via Frontend Transport; Mon,
 27 Apr 2026 16:00:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B06B.mail.protection.outlook.com (10.167.243.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.0 via Frontend Transport; Mon, 27 Apr 2026 16:00:05 +0000
Received: from yinjiyao-dev24.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 27 Apr
 2026 10:59:58 -0500
From: Yinjie Yao <yinjie.yao@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, <alexander.deucher@amd.com>,
 <leo.liu@amd.com>, <ruijing.dong@amd.com>, Yinjie Yao <yinjie.yao@amd.com>
Subject: [PATCH v2 15/19] drm/amdgpu/jpeg: set no_user_fence for JPEG v4.0.5
 ring
Date: Mon, 27 Apr 2026 11:58:53 -0400
Message-ID: <20260427155857.1370151-15-yinjie.yao@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260427155857.1370151-1-yinjie.yao@amd.com>
References: <CADnq5_MPJG=S+B4kg6v64xD+8pDEbG5z1Q7j-2A+CfStmuejTg@mail.gmail.com>
 <20260427155857.1370151-1-yinjie.yao@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06B:EE_|CY1PR12MB9649:EE_
X-MS-Office365-Filtering-Correlation-Id: 441dda56-d5e0-4ceb-3439-08dea4760c53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|82310400026|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: aSk3UEFWuTPwKkeHW92g3xY38jt6/JnqpKXLwACBcixGF8gKvl/6NnxcMsj5rzbYCOpLIh+tw9yxilTcgLVEcSGgcU98QvhArvAciub8xJEpuOzb9tgI4T3ZTw9xtwoACzdljgaEfJ7Tst5acsPo+1DsnkpRHFDh0S6zqQwRUCMGdIp2ku9W4ulE8N076DXUobCDwY7doAbVddVahzVWk+OOW+zWVtxLkSbHQeZ/01QKXOw0oMgZk20MVH765zEpou++cb2qmU2uQFKtfP0C/tBBNmmUZWFF0myd2BjFAylV62J7HvTHfbBaURz3kseg7TtaSXrTtpl7BaMU9is8SJLakkvNu3d1D30E0tgwByayRUP1nehEJF8yeRcxxTczlzLctsc2YetUozmZe2zWDRd/hh5SqinyXuzWw9MJrmyhz3EKUQ3pYdcCFpHIa9BaNr9C0krFsnqMgvDIuBcZU/CVycWhDGxfLx/uTCtibgHU6wHOGRw6wFnAT0MO+w1cJATQTu/lnckq0jmZNhJHVorwo5X1GfshPI5aa8k/1XrfOs2sLLSyvSi+XwIddwN2oV97oHqTmWIdNvVxxB81Pqqc5QNmy0MVu6cTK1/np9W0L0g1D4B9qxuVe8Ixm4xlS9e6eBC7eQVrhQz2RDiOKvOA5SF7z3HtjOOv7Ks7Zy66lA+NHCzuZTX+XPz0em1sddoLI+tFkcS49/0+ME7llEyC83y3ZYH7SjFaORyBHmdM05zzsl9YoIrh2YRyckK98NBn0o3jz7J4L3YQvdfYWQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: EA1kPUFtmKXIwVQLOGJvrSkCDVvB7ZWwIQ2KYsEbiKayA985Exqfmgkv2QZ8GxZt3gGHLZGkmFm/FrEu3vUZ9/MTetrdDQFawUL/t5IxiMOtWE7832kbpfzLEU0dN758wMqxybFQMlKxkVYypY//T05EZzNGUPCFr7kTVkD73EVbQfzxgk+t25Uj2+pdimqxRujI68yjQQWVfR3B5Jk784coUTKm9aUZT154+Ss23rmFUSoGcsT6zL9waBkIlW2rrl0w6vry9jILnuYc4iycUVRlRh1x/bC2yFu951XTFutxuG7xvFLB20FJ428mgQfggAHRu3cxaOaJ4sb4a6VlqL8Lm8RrwaF2Ch8izkZSAmTBLAZucFKgd8l4IKc2s8+M5O1y9xdD0+zJdDPd1VqdXOPNmm4ukqcYUDH26fdty9gNlNge7kz6JfmIr62G9qVA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 16:00:05.2800 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 441dda56-d5e0-4ceb-3439-08dea4760c53
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06B.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9649
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

JPEG rings do not support 64-bit user fence writes, reject CS
submissions with user fences.

Fixes: 8f98a715da8e ("drm/amdgpu/jpeg: add jpeg support for VCN4_0_5")
Reviewed-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Yinjie Yao <yinjie.yao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
index 54fd9c800c40..a43582b9c876 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_5.c
@@ -804,6 +804,7 @@ static const struct amd_ip_funcs jpeg_v4_0_5_ip_funcs = {
 static const struct amdgpu_ring_funcs jpeg_v4_0_5_dec_ring_vm_funcs = {
 	.type = AMDGPU_RING_TYPE_VCN_JPEG,
 	.align_mask = 0xf,
+	.no_user_fence = true,
 	.get_rptr = jpeg_v4_0_5_dec_ring_get_rptr,
 	.get_wptr = jpeg_v4_0_5_dec_ring_get_wptr,
 	.set_wptr = jpeg_v4_0_5_dec_ring_set_wptr,
-- 
2.43.0

