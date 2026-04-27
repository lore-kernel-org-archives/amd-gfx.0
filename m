Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1A20FF8869
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Apr 2026 16:00:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34CFA10E808;
	Mon, 27 Apr 2026 16:00:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Phh0dowU";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011071.outbound.protection.outlook.com
 [40.93.194.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9162E10E7FC
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Apr 2026 16:00:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=czosiQEHvnRca2GAEvX4uy3GW95tugn2LOntv+/VSilXpMt7a8+VywLWrdcemSnOYCHIJh1gD9USRUgx2DSWAhmYLzTEhb35nLZ85ajXHgDKHJYnBGjFdlEjhQZ7zuXSjyR+lc7rJa/ZGHjZAKi+TYQq7tzsuDO8FBXjWwSkflLm4CJGTZ38UF/78aS/+hd21dp/CIbSKRWG5ays2k2w1DfalVbROdfbg4Olauqj1z0F89pI1NXRToUJ/MhM1lYW8iTK96wRp16hK/iPztrVsMyaPl8l/7Vq11WrqBbNEVx6miCwRKxrX+cmGwhf9HCV1V1G6F1yBbRkS2DXVsvZMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fBhV+PPDoLS62n8dLo3TvVjPu/kO0VDkh8SEvds50+0=;
 b=oiMZTotgB5jU/2dlWwDbxDSjssEzMxCnd8rvqxqTqrHqmzboA9PA4IDosz7B00Fo6aNFBMSsq7a/eGPB0O+3WckiITqsTLzLcALBPbt32SIHBzM/YO1E+j5L3yqXtoXmmvXRmvNmhO+ZPbXO5HyaF0j3UpRXYkAmA7135Yz7LpaWIdJxGQxVQ8WvbRphxtKXkV5TjVq36o95SMS65RGu4ye/R49rzSlc8itdkRJfLjtDoAIbmZNAB66vWhJDvTtkjE1OTZqa+/WJvaSs3YyCNy66y4DQ0mSdiasUYGrNxJpla//zQ9HjPQcgmnM6va8GVerrhmRcXDgCulG133b5Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fBhV+PPDoLS62n8dLo3TvVjPu/kO0VDkh8SEvds50+0=;
 b=Phh0dowUqKJ1u06IzEzLEBD5nhHRmydsgFEXO0k8MCqcU2ZyjZyWg5vbK3p/81tAOdrvc+PdSJmgwFyh0cJuz8X9aR55pRSa+VkRKjvg1409CjpF6bYnJJm8uhyVYSPQkOGb59Ha3+07qhMZMOSBWYQr+qBKQfZUHpFYPl4YQ3o=
Received: from BN9PR03CA0766.namprd03.prod.outlook.com (2603:10b6:408:13a::21)
 by IA1PR12MB7541.namprd12.prod.outlook.com (2603:10b6:208:42f::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Mon, 27 Apr
 2026 16:00:07 +0000
Received: from BN3PEPF0000B06B.namprd21.prod.outlook.com
 (2603:10b6:408:13a:cafe::1c) by BN9PR03CA0766.outlook.office365.com
 (2603:10b6:408:13a::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.26 via Frontend Transport; Mon,
 27 Apr 2026 16:00:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B06B.mail.protection.outlook.com (10.167.243.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.0 via Frontend Transport; Mon, 27 Apr 2026 16:00:06 +0000
Received: from yinjiyao-dev24.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 27 Apr
 2026 10:59:59 -0500
From: Yinjie Yao <yinjie.yao@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <christian.koenig@amd.com>, <alexander.deucher@amd.com>,
 <leo.liu@amd.com>, <ruijing.dong@amd.com>, Yinjie Yao <yinjie.yao@amd.com>
Subject: [PATCH v2 16/19] drm/amdgpu/jpeg: set no_user_fence for JPEG v5.0.0
 ring
Date: Mon, 27 Apr 2026 11:58:54 -0400
Message-ID: <20260427155857.1370151-16-yinjie.yao@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06B:EE_|IA1PR12MB7541:EE_
X-MS-Office365-Filtering-Correlation-Id: a8a9e9ee-5449-4771-6b9e-08dea4760ce7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|82310400026|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: u0QlyCKjHI6TWgrF1vKcdAh45FJMWc+CU6StOqsrJCz0tNMrONYUaBuqYcfBZXozuHy2lgjtaSZyRXekwtphdAX7Mlld/dOOZE7oIHs0RB5NAYf+AGsz4yUz5XzI4Z2w+1aKbIRDO0lN7kCQAALLbo2AkLGOmyuXMCCsCnCHOaHj517NORY/gW0FZgNXqYIzgWUzL/j3i8+hH+cUCkEjkKVr+vEf5K4LIcWSsC5LUQAV+S0BnlQvPNOT8aJMx+a6nxivIDqmYuDF7l+HcTPZ8HCIcZ5uFcq34MRpmIYQ2plFQ0Ah1XSWcOArZEKQbFnXe/nXMvj70YLjwVdu06bO6LI3t2R4nWTOEDpzQ5LWF7fWtRBu5h9t49fTaEvbil23AkFbtKzlwEYKuQk77VFDqMpfx1wgJF+9A+K+yoDXKHIEy1vRh2Hbdew7MPnigoKuBH5q6R7zqQRh5Z8t/aSmJG424znzaJknFeeEsHL7T5r0yNCqDGd4C2WnvJCnTI7RUy7wsQKpQ+it9f+qOAyj+R4iXDW7FQttjihJnCIjCHlv8D9OWTcdE5xItK9vBDjWti+YJIQHcONcFOI2KdO/sIPBVH+kl4aNrgArNHfDVn2FiFBJ5+11d+M2r07n/SfxvjFEIajcXgxQPVDqgWQPjH0PXl63RKJdnHWWdyfbLTOinLAVRCH7agxHWyV+N/72KI9aLKqNXNyPyC0eLuRq+PaQOPT7NaXqlYOjkaX4tKXSfexQH6o7Lquja9GGpGLKGwtCPQURu26IhzpOwNDSRA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +hCaWtwB9IO4QM4g5nzzweTgHqCtWz5uuF810i8uyruEzzhThG6t7CBYVEb21TkHR1f2Y4b6mqP988PfOKhP2Ie9jrtYi2/7bIN1cnwVTyOCyhMFcm8w6TUyQxXGPHSgOV6jjHbFefuvGUy3WQeO5aMaWJCrM/Eq5NkJNnXt+tyQ0A1YeenIeXdjNcW1T2u4KMjfR6yFA6wyKJMkp3vYeu9tDR+p/Y6Tv2Sl2fqd+MK2BXr4XPxYEZolErOoqFrCig9/i5YR8Dulg+FI+hKI2IoJqU58cCrXrVdZnZcna33Jgn1+GTm/ZxhCpdyQ++cgG8uB2pw1jGrxeLt/y2k/+rxkF2j0/2pDQKtEnrvE2EQG5envgeK0ec4pmbPM+BdGk3MK0HOitqQiDTywsDfXPeNPWtqdWuR3sd471WFP/EFoEAfTbT9+PEGgauKFvgSk
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2026 16:00:06.2338 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8a9e9ee-5449-4771-6b9e-08dea4760ce7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06B.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7541
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

Fixes: dfad65c65728 ("drm/amdgpu: Add JPEG5 support")
Reviewed-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Yinjie Yao <yinjie.yao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
index 46bf15dce2bd..72a4b2d0676f 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v5_0_0.c
@@ -680,6 +680,7 @@ static const struct amd_ip_funcs jpeg_v5_0_0_ip_funcs = {
 static const struct amdgpu_ring_funcs jpeg_v5_0_0_dec_ring_vm_funcs = {
 	.type = AMDGPU_RING_TYPE_VCN_JPEG,
 	.align_mask = 0xf,
+	.no_user_fence = true,
 	.get_rptr = jpeg_v5_0_0_dec_ring_get_rptr,
 	.get_wptr = jpeg_v5_0_0_dec_ring_get_wptr,
 	.set_wptr = jpeg_v5_0_0_dec_ring_set_wptr,
-- 
2.43.0

