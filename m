Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69C4DCC6B1A
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Oct 2026 09:20:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF60D10FC29;
	Wed, 14 Oct 2026 09:20:27 +0000 (UTC)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011047.outbound.protection.outlook.com [52.101.52.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C5A310FC29
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Oct 2026 09:20:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K+HBtghu4ZHRg1QKJN4fBSS4JlIkPPbvNh+HUwgJHcK/l8k1jGIu8DRdg03+2cVY3ypyymeyiEwAsqkJ9ofqts/n3qmB9gBEAN9B8HWkAJ6/SeLhCCcKYcRldlbBUOSLz3z96YFwpPC0bD1eTJdIGYSLGnFRteshKDCERVBGrBT1G8iW/DQiZBAx2JRRwGSWu5SCS9bAXBj8nOmxa7BKjPKCgNLpqKEK6dRdRTp7caWWpo1FRtAw49NocRDTSu8VIVF4SvfaRd0e0Wj5vMw6vd6Ya/YwBylMfxfw0pzwOeGenG9yCUOZyBVQYurTrcpenny4ly+r8PMGvfK6C1ADrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ac2pRxR4Ojnc0B96T47VNSktTMUGcpvEu6aspX/A/zc=;
 b=rykKXOa57J0BKKt6AeDC2sdn8oyDfQObPESfGixIayNE6+ZIoB8JeJiY9rpb57Zwiy8eTkaQDyuAY3iWSpUhJNGUnl8WhkEnbeWZhInAlCPNRIoB7agfRH9vyUpCgzRw/zTBfrYpwjo7uk8AeiYdfHMG784qkkYcRrhH8L2UDhF1tbXsfihZPszMvj/1f5R63HkRb0tnkOCPyP/8+OW7v9B/2oyCiYCSuX4k3E+s7v5hay2XhLtvwUZn66OF71WhyfungEcLowso7WR3yGpki/JI8sYdxCYUY3QykJ6Uevp9E5cjUBNGJWCGSO61Z3AT0MW/S3bqnrIl81HgvIV8gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ac2pRxR4Ojnc0B96T47VNSktTMUGcpvEu6aspX/A/zc=;
 b=mVi5Rr8aNzR7U6wm5jf6BfiCDKQv70pDPgpd5Qlmc0dKhPjlJfcsg/ZjZUMFLPjHtyEdhyzFZ5k7n4F4V3Y8ALAJRmydIw6AKZJJCy57lEBk5Q7f3HkvGBAY7yHg8zoLYhOjY/HYXUHqBsyFHcle76PUbpI1NamrusNBFPWdcbo=
Received: from PH7P220CA0022.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:326::23)
 by IA1PR12MB6187.namprd12.prod.outlook.com (2603:10b6:208:3e5::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Wed, 14 Oct
 2026 09:20:18 +0000
Received: from BY1PEPF0002695D.namprd05.prod.outlook.com
 (2603:10b6:510:326:cafe::ae) by PH7P220CA0022.outlook.office365.com
 (2603:10b6:510:326::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Wed,
 14 Oct 2026 09:20:18 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BY1PEPF0002695D.mail.protection.outlook.com (10.167.244.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Wed, 14 Oct 2026 09:20:17 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 14 Oct
 2026 04:20:05 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Wed, 14 Oct 2026 04:20:03 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Prike Liang <prike.liang@amd.com>, Sunil Khatri <sunil.khatri@amd.com>,
 "Jesse Zhang" <Jesse.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: return copy errors from AMDGPU_INFO_UQ_FW_AREAS
Date: Wed, 14 Oct 2026 17:19:58 +0800
Message-ID: <20261014092009.2933906-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0002695D:EE_|IA1PR12MB6187:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fc9a073-3846-410d-1f88-08df29d45cbf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|36860700016|1800799024|376014|18002099003|10067099003|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: AIZvxw+YxnuH7nmJmUEIxxK88FA2+vihLwb2ey8JjCWjOE2WU39Q6eDZ6mx4AgfmSj52r4UEgbXQ2zaqHz+C/srXHQgDvkswlejXGLoOAWrThgQyAUYuVJNQXawaoBagFrBGLaSqoVI7eAeB6xxfUMm005piHVLxzc0zr+s6Lscz/MlMBE2+LUWHu4ytBoDc4d83aOqAeDEm+wmWjlXONhNUjqWaA0rVSWCprMqb5wJ8q383vSFMCoaS9XotHgqj0ObJijnv2G3S8Ae/LjQ0/ELfrKCq+J78Z0uNfdkh0WjGTgRyuQEU0JOtZNJVKJDrwPQMo3DNk2GdHypARIeWgTkvfxM4NnGc5Nma8zTZNYZHxVIN9sNNrQVgm/M5KnT7UT1qDCDk2s00yE7pcj+1VrCbu6XsuN8Jjxf4HgYwjCLebSZqHq/9zFlRL7NUWWaK7PhBcIeur7UhQQPpYOs+4jxZkocUm7TpypBTf8n/17kSgqZ0rfcHDo49waEDH5Ty+6bldFmcvosbhpzI2OXcaH2NbeadrrP/g84gQqr1RMrVR5zzbst/PwyiWSq6b4sEAPGxyEO/yxWPysT+/44BKhD3ECQ2OUxZXiea6Bvm/HlSm1i8l9lTIR/J99pZsjtUztSyzz/YN5UMpYedtRfCCqoFdIwvGHxWtL+DWE7LOHmPvI3+Y+bQIG+E/02ae6JDcbPYHltueImdksqhWxIgFQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(36860700016)(1800799024)(376014)(18002099003)(10067099003)(11063799006)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /y/83AiaAFpj69HxNO9rkjM7TaGwNonDLhgYoJOKslbd6+N7vL9t6ipHbY+75n6yGnO0RWSWMf+7j+O/+vGGzk6kujdjag4hDHiBuSL9avmR8IaXNHBbu4C/DeYFnNU8pnDFp41n6/zSy6HHNlpnssYpLcQodyj0TkCk7EomXuRmUV/nW7uN0cAbvxGLA+Oby8MWsdwa0WTkSJLnm9C1tmI9zEYnergEJz5kbMOaxHmIDs6jh/Svd9mE/gufofbsWN4V21O7HN1m8qXgxXkCpB7QZzkm/EmPJ9liW9bnaAdoxaQPVcie+KID7MhJQ5z9tjF5MbOr5owbxRrB5KATu8+ByI+kw/ca6fDDGzy8SvIiRICX+DJy8dTR4zsu/K5JRBba0Q2fsnn3WvT1dOHimQWMlDvKKq83MMKdQ+ZSKQiY+2xW/IxjN3XQ43hhtNKm
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 09:20:17.4472 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fc9a073-3846-410d-1f88-08df29d45cbf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0002695D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6187
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

The GFX, compute and SDMA branches of AMDGPU_INFO_UQ_FW_AREAS work out
-EFAULT when the result can't be copied to userspace but return 0 all
the same, so the caller goes on with a buffer that was never written.

On navi31, querying any of the three into a read-only page returns 0,
while e.g. AMDGPU_INFO_DEV_INFO returns -EFAULT for the same page.

Return the result of the copy.

Fixes: 90c448fef312 ("drm/amdgpu: add new AMDGPU_INFO subquery for userq objects")
Fixes: 44b69cf1d35c ("drm/amdgpu: Update AMDGPU_INFO_UQ_FW_AREAS query for compute")
Fixes: 0030595c3e8b ("drm/amdgpu: Update AMDGPU_INFO_UQ_FW_AREAS query for sdma")
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 084d8517c194..0cf6bbc8c0ff 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -1432,7 +1432,7 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 
 			ret = copy_to_user(out, &meta_info,
 						min((size_t)size, sizeof(meta_info))) ? -EFAULT : 0;
-			return 0;
+			return ret;
 		case AMDGPU_HW_IP_COMPUTE:
 			ret = amdgpu_userq_metadata_info_compute(adev, info, &meta_info.compute);
 			if (ret)
@@ -1440,7 +1440,7 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 
 			ret = copy_to_user(out, &meta_info,
 						min((size_t)size, sizeof(meta_info))) ? -EFAULT : 0;
-			return 0;
+			return ret;
 		case AMDGPU_HW_IP_DMA:
 			ret = amdgpu_userq_metadata_info_sdma(adev, info, &meta_info.sdma);
 			if (ret)
@@ -1448,7 +1448,7 @@ int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 
 			ret = copy_to_user(out, &meta_info,
 						min((size_t)size, sizeof(meta_info))) ? -EFAULT : 0;
-			return 0;
+			return ret;
 		default:
 			return -EINVAL;
 		}
-- 
2.50.1

