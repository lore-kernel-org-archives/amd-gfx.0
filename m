Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 113E9C021A4
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Feb 2025 03:01:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7A0F10E9C9;
	Thu, 13 Feb 2025 03:01:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RaMEzw7K";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2078.outbound.protection.outlook.com [40.107.236.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C408D10E9CA
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Feb 2025 03:01:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=adHRRVMLZNi+ynDQWt3ijXA4ovzschFEOaPMYWXlqAOxfd5CtCo7GWcVWWfC3TWe8syitVrdfpZF/cs4CHMjstY/2o7dxzfPVb5fN+lzT8fN9OnGc8VPYOY0q2Wft1ERsXiiB0RCRIxqLCi3+8qzGa75THhfTUDSDeFA+EHyitkEoGUqejMkhOBZtOsbIxFhOt6DrQ7Y63iq+EmQY/OG5gWlDNp5tPIKMx4Bxr+dgbgBaStO8iqEy0D1bAgQA3FQiWayJZy8hhB6A+nU7nQtgqrY6Vdlpn+hXM+sHwhqXxKVeY/lmfjbLqmxsrkZ26DLBgHxTlpS3CLrLwzwXJK6Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lLUuRoDxkvop8UAiphTHJyjoZharTkUxUOSJMYg7KKw=;
 b=wl9eKlfx+iCria496ZeIjJb6sqyZ7t8cEBcBcs+MPfS6e4UnOfdiFVPPmeAwnGT+RVxIJ36ivjep7R/MbLZsrmqF5weyuu4Z3pIUmRKsvVnz7D4tAU8sjFxzXt6DYMW1v4H0v/bjOBiWSInJqM3VKV9VnAJN2XOlKZutoeHWuV9xBBcpSeCQyVgxH232Gr3PEQTipaAgvqG0pN593GESP7kXSGjjLTTtcwtBm7JIOL/z67RxRFiRAc3IobSQPz4Z29JFvu+0LPXR+bOLt/3WPT5ZvPurrd+9D+tVRKVI9QTRytzziXRJKCpv5wm2oIw9b/OhokWSCOJhOpnVVsmXLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lLUuRoDxkvop8UAiphTHJyjoZharTkUxUOSJMYg7KKw=;
 b=RaMEzw7KFqrXy5RW/MeC43Z3Rx+MgzZeuh3YSkoc2v5PsD39jWqgysubHHA4MFHK2hg4Fw1MVkDm+J1ByAo/uCyEhoeNTDszoA73wwynADgcVR1Vm7erbgmxi/9VBm2mZlz0z8lwmJ1cxtJ+eGlx6cwI1tCGCzE6nrN0hLTykmU=
Received: from DS7PR03CA0024.namprd03.prod.outlook.com (2603:10b6:5:3b8::29)
 by MW3PR12MB4348.namprd12.prod.outlook.com (2603:10b6:303:5f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.13; Thu, 13 Feb
 2025 03:01:21 +0000
Received: from CY4PEPF0000FCC1.namprd03.prod.outlook.com
 (2603:10b6:5:3b8:cafe::7d) by DS7PR03CA0024.outlook.office365.com
 (2603:10b6:5:3b8::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.31 via Frontend Transport; Thu,
 13 Feb 2025 03:01:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC1.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Thu, 13 Feb 2025 03:01:20 +0000
Received: from sathish-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 12 Feb 2025 20:59:58 -0600
From: Sathishkumar S <sathishkumar.sundararaju@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Leo Liu <Leo.Liu@amd.com>, Koenig Christian <Christian.Koenig@amd.com>,
 Alexander Deucher <Alexander.Deucher@amd.com>, Sathishkumar S
 <sathishkumar.sundararaju@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>, Leo Liu <leo.liu@amd.com>
Subject: [PATCH v3 2/6] drm/amdgpu: Add ring reset callback for JPEG4_0_0
Date: Thu, 13 Feb 2025 08:24:04 +0530
Message-ID: <20250213025408.2402828-3-sathishkumar.sundararaju@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250213025408.2402828-1-sathishkumar.sundararaju@amd.com>
References: <20250213025408.2402828-1-sathishkumar.sundararaju@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC1:EE_|MW3PR12MB4348:EE_
X-MS-Office365-Filtering-Correlation-Id: 209e46bd-cdc5-4af3-8e7a-08dd4bdab185
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bEVoUVQ4RytwdjlxWlNXWHk5YmZMbTltWURrakY1SHgwQnYyVkRick1SY1c5?=
 =?utf-8?B?aXRiOWJybGhPVHpEWUcvRHlUaWhlYW1YNDdVbHAwWlVqeDBOZUFwTDZXbkxW?=
 =?utf-8?B?M2trNnNYT2JBZm1mU0ZwaUx1TjN0K1h5cHVRUXNyL1ZLb3ExOUVuN0tneE9J?=
 =?utf-8?B?OG1EN0FrVVBNZU5DNFJRQXJWTmthZlhRRmpkbXBpTHQyV3B2bmhsN1luV0Ev?=
 =?utf-8?B?VjZEamc4VTUzQ3dFTlJKc3c1eXFzeklZclZuVVpiWDZpZytveFVyTGIvN3Rz?=
 =?utf-8?B?WUtDSk5WQkFEdW94YU52bzlHdFJLRHorVEZIVEZ2M0YxVktkd1l6ckt0OURD?=
 =?utf-8?B?bmY2NmtyeEp1SEtUMUw3bVRmVE13T0lRNGR5OHFsQUxhRUVkWFNUaTFHRGNW?=
 =?utf-8?B?SzR5a2RUWUlpWG9yTTV6UUdYcGxqaXhZbFlNd0cxcjJqdjdwT0F0TmxUa0Y5?=
 =?utf-8?B?ZHRNb25qUWRnb3o1RC9uSWRXeExibkQyZ2RLMkNpaVVuU3UyamdBNFZja1hO?=
 =?utf-8?B?ZUNPV1JKcHMwNkJOQVhRNnN2cFZkRFZ3R1dPYnRxN3g2cnpOQXVIb2Y5UmdG?=
 =?utf-8?B?WGg1SlNHSHkwRXR3ZGc0Wk1XUmhrelkyUHNrWldSWVdVUFdyOS9KcFdrWm5P?=
 =?utf-8?B?b0RvWUZQT2dLUGdpakNNditXZEtNdi94bWVpa2dWWmpZTTdZTzd2SkQ5dzMr?=
 =?utf-8?B?ajdaai9PNXExOFhjMGZrQm5teGUxR3Q2eTR0Z2VlRkM2b0hGa0FCZVZoRGZW?=
 =?utf-8?B?d3d6SFZQTXA3Sk5aMEE3VkYwUTNMUXovT2lFMkJHMnFmUFN1Vmx0UDErRlJ2?=
 =?utf-8?B?M2RzOEFvazNhb21naVZrUWxKVnkyRnduRnNBNlZ0TFFDUGwzSjRyUXhmajVa?=
 =?utf-8?B?NUhDRlhKT1o3VnhoWmIyOVdPQXVSNzE5TVdSckRDaTZDMTF1cWo4V3pIVEtS?=
 =?utf-8?B?WnVkT1dKaGlIR1UrVmhyeVVKd0t1LzlNRlZCY28rN3Q5MExOVHBDNTIzRWlE?=
 =?utf-8?B?WGlrVzdOaGpNZUErWTNRSDkxdnR0c2tkNEd5c25mN3lHakNjU1V2QW53cUFa?=
 =?utf-8?B?WFJGTG44M0UxU0QyejUzUnFSODJmdkg3WlNJYjBHYy9IcmNhK28yWjBGZGlN?=
 =?utf-8?B?Y0tIa3RCSXRnRitKK25oZzFWaGlaaDdQMFh6RW1UUjFHMGd6aFBSVTY5V0Zi?=
 =?utf-8?B?c2thZ3lEU1BhbVJKZUVpU3A5YmYyWk5FalJUSHQyLzZsT1FJak1UVjFGSUdE?=
 =?utf-8?B?SkdXeHZ4YXJGc01jbWVCMW5OcGpJeGJMS3VpYWFGSkJySzVSbzVKdFpRUEpp?=
 =?utf-8?B?S1hSTlBNVWpPZTlmaE5mQ2IwUXZGejFFWlE2S1JEak85ZHNRMkNhVHpaTitP?=
 =?utf-8?B?Y2lDS0VhdFVMTHRTWkJoNWNCbEdCWFF4QVlOclJPTVpINGhJdWJIajlVc1NK?=
 =?utf-8?B?OTh2bDQwRGtTYWpyQW5BVFoxVlNsaXY5b05ja2hSLzJYMFd5QVFwV2loTU5Y?=
 =?utf-8?B?LzlsUVNPTTNIWFk2bS85cXNiY3BVRFFMbW1Rcmc1MDduUkNsMVE2NTI1M0Qv?=
 =?utf-8?B?UDZ5dGpHVjgzS3ZSL1pLMCs2OXlIdk84Z0lQNm9zRjFqaU90d3Z1cHd4N244?=
 =?utf-8?B?OEJEL2tPR1pDNGRXRUkrM2lkTUJlNGMyTU1ZaEZJcXlGQjdSKzRCSkJxZHl6?=
 =?utf-8?B?MlhuMXorMGhpQlo2VUtKT01vVlU5T3Nkc3FsK1cyWGpwY01DdjFkak0zTXBQ?=
 =?utf-8?B?cDY1OGcwMDh6L0FaYkh5eXZiZy9uVVJ6QWVPbFlUUXgyZEZxYkRRMjBZb3B3?=
 =?utf-8?B?ZlU3UTFaV1R5cXlrMVZ2dTBlc1BuUWxSZzQ2SlhFOVZ0QnJ1dVc4ZzQvUzh3?=
 =?utf-8?B?a1VzS240bzNxWUtTSExtQzZsRVQrYk4vOVNEOTZhNjBISUxZbVBvK3hCR2Rm?=
 =?utf-8?B?THgrTjlVaGdvVjVJQVFNc3JtOFRMMHpTaTgrWlhaSHQ1K1NWOURNRVB1ZTEz?=
 =?utf-8?Q?obqluQ/tLya5feeisuWk3CVqcKHOAQ=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 03:01:20.8033 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 209e46bd-cdc5-4af3-8e7a-08dd4bdab185
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4348
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

Add ring reset function callback for JPEG4_0_0 to
recover from job timeouts without a full gpu reset.

Signed-off-by: Sathishkumar S <sathishkumar.sundararaju@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Leo Liu <leo.liu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
index b0666090f52c..292d4a234ea6 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
@@ -143,14 +143,10 @@ static int jpeg_v4_0_sw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 
-	/* TODO: Add queue reset mask when FW fully supports it */
-	adev->jpeg.supported_reset =
-		amdgpu_get_soft_full_reset_mask(&adev->jpeg.inst[0].ring_dec[0]);
+	adev->jpeg.supported_reset = AMDGPU_RESET_TYPE_PER_QUEUE;
 	r = amdgpu_jpeg_sysfs_reset_mask_init(adev);
-	if (r)
-		return r;
 
-	return 0;
+	return r;
 }
 
 /**
@@ -724,6 +720,16 @@ static int jpeg_v4_0_process_interrupt(struct amdgpu_device *adev,
 	return 0;
 }
 
+static int jpeg_v4_0_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
+{
+	if (amdgpu_sriov_vf(ring->adev))
+		return -EINVAL;
+
+	jpeg_v4_0_stop(ring->adev);
+	jpeg_v4_0_start(ring->adev);
+	return amdgpu_ring_test_helper(ring);
+}
+
 static const struct amd_ip_funcs jpeg_v4_0_ip_funcs = {
 	.name = "jpeg_v4_0",
 	.early_init = jpeg_v4_0_early_init,
@@ -769,6 +775,7 @@ static const struct amdgpu_ring_funcs jpeg_v4_0_dec_ring_vm_funcs = {
 	.emit_wreg = jpeg_v2_0_dec_ring_emit_wreg,
 	.emit_reg_wait = jpeg_v2_0_dec_ring_emit_reg_wait,
 	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
+	.reset = jpeg_v4_0_ring_reset,
 };
 
 static void jpeg_v4_0_set_dec_ring_funcs(struct amdgpu_device *adev)
-- 
2.25.1

