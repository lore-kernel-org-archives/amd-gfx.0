Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E302FF8869
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Apr 2026 16:00:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0690710E7FA;
	Mon, 27 Apr 2026 16:00:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kOnvUSZa";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011043.outbound.protection.outlook.com [52.101.52.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3AC7310E7F7
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Apr 2026 16:00:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FGldagSvHj+Hpk/qGTp5Y1DyV2vLL3p4SKZposbEaRDZ5Ek8Lepx96m6cX+Z/NqxMLX0bYPJdz7OxCtGd/mYKkN4/Sdwc11ml5lLJ7CUFnoZS7tZgiT3cFid+I+Cnb0qBvlMO7kKx+Vi4sub4PWCbuaLRo9ytFJM2Ez3ZBFPLL0ouQX2HmVLGeCHZ4EsNgqscXF07QEtMFjtL7B6qXAON+KFFrdCmQxTN4kutqvWE7ZPWdWFKkIHWRwgZr+51Bm6CSR5Hoal9ezxizjaFf9S9U8+WWyS5e5TivdlFq4R6eD6tf3lpjDf1goOrpa5V/2fZznoLrKEJeKhhh5wSwOz7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jef/mxwhk0CSKQIYqY4ok8SI38TE2z8Ei4llGVpcORY=;
 b=DDK3dhdjpIwZfqVoiH+kth8xFA0Tt0DtytxRyQBMUsRdxTUgP0cLQoDoBYFeNY1IB5Ch+H6LJNoziCrWH55TD5vY9qbNGiFd4UL50T23WAZtS+tkBLy/kGUF2Z05liUwgCIEHi816NKsHzMFb8GSzOt6vOOPhoH4NrSxePOza5BW9M/G9pQwgS9TZR2RIqSWwwIcZ1N8VtMOEyrkiuXQEeulJj55Du6Rr48P6BjDJWBtDGP2oG9+JX21DOq6jGjc2/rq71dQNztVcVcoN88CoQ5j/cPSPwpr5PKxMooSeUFFdwN5CvJPxIPo2NujvAA2XvwSxAvnbYZHenWRIyfF4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jef/mxwhk0CSKQIYqY4ok8SI38TE2z8Ei4llGVpcORY=;
 b=kOnvUSZakRReeldHpaHC9JfRzAa5XU5Yr9C63ON5qIP3OehIyM+zqEkxs0MQgkb37c7L8Xj6qKpCqaRu/72uo/j4wv/f47ahRTcCiNorHiESzsnKGgbL7GPgcFk8VkUxw/nb+Ei0jaf7rWPqRDw/jWvdwdhD3GtXy4tFO8ZfZyU=
Received: from BN9PR03CA0761.namprd03.prod.outlook.com (2603:10b6:408:13a::16)
 by PH8PR12MB6699.namprd12.prod.outlook.com (2603:10b6:510:1ce::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.15; Mon, 27 Apr
 2026 15:59:56 +0000
Received: from BN3PEPF0000B06B.namprd21.prod.outlook.com
 (2603:10b6:408:13a:cafe::3c) by BN9PR03CA0761.outlook.office365.com
 (2603:10b6:408:13a::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.26 via Frontend Transport; Mon,
 27 Apr 2026 15:59:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B06B.mail.protection.outlook.com (10.167.243.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.0 via Frontend Transport; Mon, 27 Apr 2026 15:59:55 +0000
Received: from yinjiyao-dev24.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 27 Apr
 2026 10:59:52 -0500
From: Yinjie Yao <yinjie.yao@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, <alexander.deucher@amd.com>,
 <leo.liu@amd.com>, <ruijing.dong@amd.com>, Yinjie Yao <yinjie.yao@amd.com>
Subject: [PATCH v2 10/19] drm/amdgpu/jpeg: set no_user_fence for JPEG v2.0 ring
Date: Mon, 27 Apr 2026 11:58:48 -0400
Message-ID: <20260427155857.1370151-10-yinjie.yao@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06B:EE_|PH8PR12MB6699:EE_
X-MS-Office365-Filtering-Correlation-Id: 05857cab-bf06-4909-3be2-08dea476065f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|82310400026|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: AU02VQhnIPaH215PIJizSBD0Nc7DpEyS8buDRtM+dijL54Swuy6hxuM3cbQ4dChlhmGSnF90Ejc/M4hTCPvHNYoxWSTcR/BsXF0ujew+I8sCMqa52lkXJ1Hq8ph0w4DiBu1Dz5cdYEJZtX5FcGIyKMpMbJofJGEczrCclso7n9XXC0JR1VjMuUp7gis5ESFpXo6xMLsgY+adb74/9qB8zqUyDG70gYj9jRRHz+ZnktlrWSWBdtwJ7aOrPzdcpem0tvIw5gMuhd5lMFUwiyrFuaajv74G/tcpD+lgIIgkKczAohrg8rj20KN7ztcqVHFw0uJB9Rc5iGc2vEvX2FlLX4w0GE5DY3l3Oh5rTjqcor1PDNc9hC43E/pJx1Ti+s5lwLdEPBMGlzACjO4+8ro79sMyEDsvlHZ8cwM7yu/YSYrd3p93KTfnZ2araWARBzPqIpHwTk969Ywt3+YUDi74afyD2tORMvLmGoH6kCphY3+Mo9seiaTISfe8l1qaa1aMGsZVwv12W7PmH6g/+5ltMpR8xA2AO41a50h4+9cP3Iooi+SSdUbKBz6vtGCaxnWCT4b2k/56bwZ1MhXdPcYijjMiBWotU0y8tQMQo6Nr3yLhpBSrYqnjYEEN4KC8SJgwQxPcdInfqwNvaamiF5qLqgZEGX3/mSSvDfdRXpOkFQl7zf940kO8Bu/MYwhjUvLx+x91BH/6UjItNeE+TUH5pWBoAcdqYALotA4ZKZHJL228vF+BVbJKZXpV+wu9xqmg4TRVNvOoOjMqGg8gceX2iQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: M+uCl9AkvCnzrCPEIT68VKaNMzbTDjO0YnkTuuel6lSNVHHYjcimGYvyYceZYJCvIqBf3q98jxA5TRTnDJDqei9Mbs+bp+koS4oMhXYnbLwouHV8ah77MUZ1YMjKKz/jN2BY+Yvtn60dMtpt38ZL+FRfwA/B9SK21x+08iYRlGRUUrMgJsCJMSEL3xSSSYf+xILDQ6f1kq90FrAphSfvchnhma6MmNTcNjMdqq3iCYI0+An6fXr8U338NeujGADK0LbtduhEmL+CMVMoGRpQbjNF8LrVEN6A7tJeVNTdxX4cAlOsvBKMKU6PhoB5W3xL9DmMfQLPlxLfkUUfdKi8nR2eo9B66rvELGm0EmaUB90XWDXpvQfCaDaojQQMpeS6g9mRKi1O9qcqH4thzx5m/rM1d3b5UTQx0AHmyEDW/ox7pP7kdHTnxRnEnU8oxAHh
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 15:59:55.2749 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 05857cab-bf06-4909-3be2-08dea476065f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06B.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6699
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

Fixes: 6ac27241106b ("drm/amdgpu: add JPEG v2.0 function supports")
Reviewed-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Yinjie Yao <yinjie.yao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
index 9fe8d10ab270..cffb1e6bab35 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
@@ -802,6 +802,7 @@ static const struct amd_ip_funcs jpeg_v2_0_ip_funcs = {
 static const struct amdgpu_ring_funcs jpeg_v2_0_dec_ring_vm_funcs = {
 	.type = AMDGPU_RING_TYPE_VCN_JPEG,
 	.align_mask = 0xf,
+	.no_user_fence = true,
 	.get_rptr = jpeg_v2_0_dec_ring_get_rptr,
 	.get_wptr = jpeg_v2_0_dec_ring_get_wptr,
 	.set_wptr = jpeg_v2_0_dec_ring_set_wptr,
-- 
2.43.0

