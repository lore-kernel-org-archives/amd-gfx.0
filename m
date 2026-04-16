Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20D1DF8A14D
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Apr 2026 10:28:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B0FC10E184;
	Thu, 16 Apr 2026 10:28:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Zu0dYWdB";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013052.outbound.protection.outlook.com
 [40.93.196.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7905210E184
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Apr 2026 10:28:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DNavHVoH59Tj0QWb4VgWJBYoO/qtqXiuM8Ke0U0s0OK9PE5k8DYDzvHXvruKY8a6lF7Utm5ZWdeomGHo1KOAuUYMpQfyouhUWUJ9KcUY5bcroFb/xoOZd0Dwz24qiDmZTt92gdct4W8oUAN9Cqy69VSIvnHh/0vGaK8ta0/6gcxEvYlkKZqw9uzJB1LpOKJbZjc6uBvqjUlPWhUuL+BLtHTlSt/aA4IBJerQdL9VdK1yLlA3HSu7bZxIP8ISZw/B5pH9LwW7qwjyUCnpOHPPNP9/jtPUE3cQqyXxLQKgOY7qABANADvekDll2WEOamrMrZW3EexnevYESJfb8ZzdhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AiaQsLWkTH4CG3+8UP72bA/F/k28S3HBD0l0ikqysVY=;
 b=q36JaJDmqQT7VtIip9kh/M+WwLOyJ7sJ0r0mycfAXoiZSvrUNKqih9TSRNWqiBC6XaxoB7gLTOoaaNI1toF+SeXckZ5ojEo9dOwlynbP2XnWbMNWwP1eUJbPOezATlMpY0TSEdB2VceHjIp8zMQJdFC+4eVBtrVjFL0hpJRctrzdntXF4I+SgMO7gX98x/TDDQbJY3SyBXjwziuwi9HWOOluzH9+QMAM5gAumXFWAD/Av7hGYpduzmCMTD86e405BYt+eONfcdZ/eKPxvn5NJnHpIyM3mAaoIoGndDU01AnGgP84ILCUUEdZ/t2bblncnMuLgZ6ZRwTB8BK1LySaFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AiaQsLWkTH4CG3+8UP72bA/F/k28S3HBD0l0ikqysVY=;
 b=Zu0dYWdBqcsAy82JpVP3dcosiNo2YFQDwrLCyYVliFx8rtp3xsEmWcgq6oPCC7zI7to4XusmHFgPFR5pTNGXbdz/xVtTXj72vs/osa6jxKhdVgO++MnnBsYIn7/ggtmApOzmhHAHrKP0yM/lHhtZ4GuJmYKONxnJuQRHdc4ySyQ=
Received: from DM6PR05CA0056.namprd05.prod.outlook.com (2603:10b6:5:335::25)
 by PH7PR12MB6394.namprd12.prod.outlook.com (2603:10b6:510:1fe::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Thu, 16 Apr
 2026 10:28:28 +0000
Received: from CY4PEPF0000E9D3.namprd03.prod.outlook.com
 (2603:10b6:5:335:cafe::43) by DM6PR05CA0056.outlook.office365.com
 (2603:10b6:5:335::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.52 via Frontend Transport; Thu,
 16 Apr 2026 10:28:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9D3.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 16 Apr 2026 10:28:27 +0000
Received: from kevin-mlse-vm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 16 Apr
 2026 05:28:25 -0500
From: Yang Wang <kevinyang.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <hawking.zhang@amd.com>,
 <kenneth.feng@amd.com>
Subject: [PATCH] drm/amd/pm: fix runtime PM imbalance issue in amdgpu_pm.c
Date: Thu, 16 Apr 2026 18:28:08 +0800
Message-ID: <20260416102808.71041-1-kevinyang.wang@amd.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D3:EE_|PH7PR12MB6394:EE_
X-MS-Office365-Filtering-Correlation-Id: a0571370-524b-4ea2-b18d-08de9ba2e5e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|376014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: BWdxRvcchrc4OEk1YVUrTM993VLd/tccstbreq3jhWTZkLguW/KLJGcUoct9YRBiu7e5ekuZrakoZ4uh0nbHDsMz1jr1RoyGDe68N7pc3fmDY/yo8KIE3POGqRleRuCobItpSQ8rSKLc0BoyojQCEdroRpnAQnW/RlM0vA0HEO34PrjmQGGqxsB51BvRrYepi+hrmm3BepKE2nra2G2t512sCGPywTsOW2mJksSndoBGemKVYw84SgdKnk4ZkUJnvP6NIfHCK0DZA/0e0vZOfbQsOB0NhhmGB76ZIrnIbGAnIODmtAfJTcZfya4JkIQmoWNddGfJ07FfGnhVsLcyIuKapz5PQtKybgEwwO1FuxgjHiKh39b44PpsPsoM33wfl8lJsKGeG049FhytVEVYZdqXqeLKh6nqrayf0+WBVLau0MMLGrquTTKe95scedwssrAOJPQHG8032elmmZdLsWjrRi9371vYXnQJqk8675JvoD5L2y+iUlSEllZVvwQC3B36c0oej2ZiHtIinz39u2uNeRzfYL+6IFUtELfKgSSNCTYMptfzIlpoexiwHYKSuObFXSVH1kHEG3GjlCjKgXEphMHyiLAWJZVlAvDfjd/C3FEnPwpCDw9u7bb5NfEsq9T5F43qgaOnossdAPKP1r7/gScVRZHz9RWn0VkQ14wa6OLWhbrubvF9tUQdrnHybi+iSMzF8s2OS4Kx2Qi4/mdXPV9q958nC3jzR3VMf8DH2TA0JonZOcAgwI4C9BHDq9dnrtfe9PZd430TqcbMtA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: zR1V91PAr+UsRF2wQByg9BrNfQB3lJ6j3whYV8MoEPWq20aQ0EWAAtRWWyNZylZg2sVcPDdtUBkQTOjiJTHBx6aGxAxaxyG7ho5Q3U+nl2JqG5DyYZd3l/pI2PJy3OtqC8bV1SeI8MDfRj7qyzLYdsIPfF2x1rG/TVx8xjEIEaDSwNz4vUV5KNT+r69TrvLvD2G10FFxnKoIBXH9aHje8a6X3L65xb9EbJvEIGao9B/+VQHqsE4NmJb3m+3bAVeueOc0gVqZJErZl0r++yA3ja+q1gYLzeBDfM9/OZbIftW5cokMwvHRhaNGnf+F3NW7zzG8jy/4iU/5HT2FfzgWgkShj+Ll7FQRG5bhms9zsPBl526wfBoqxRnd+tis8i41YfSpBP/LFMjLzR/amTTSk71MoT3v6tfBC6LgBL2SUsXvuTo8tlKr7dvvM/J1NCGC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2026 10:28:27.6099 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0571370-524b-4ea2-b18d-08de9ba2e5e1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6394
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

Fix runtime PM counter imbalance to prevent device from failing to enter low power state

Fixes: a50d32c41fb2 ("drm/amd/pm: Deprecate print_clock_levels interface")

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index afbfb8e7adf5..fd2e63530e8c 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -995,12 +995,15 @@ static ssize_t amdgpu_get_pp_dpm_clock(struct device *dev,
 		return ret;
 
 	ret = amdgpu_dpm_emit_clock_levels(adev, type, buf, &size);
-	if (ret)
-		return ret;
+	if (ret) {
+		size = ret;
+		goto out_pm_put;
+	}
 
 	if (size == 0)
 		size = sysfs_emit(buf, "\n");
 
+out_pm_put:
 	amdgpu_pm_put_access(adev);
 
 	return size;
@@ -3902,11 +3905,14 @@ static int amdgpu_retrieve_od_settings(struct amdgpu_device *adev,
 		return ret;
 
 	ret = amdgpu_dpm_emit_clock_levels(adev, od_type, buf, &size);
-	if (ret)
-		return ret;
+	if (ret) {
+		size = ret;
+		goto out_pm_put;
+	}
 	if (size == 0)
 		size = sysfs_emit(buf, "\n");
 
+out_pm_put:
 	amdgpu_pm_put_access(adev);
 
 	return size;
-- 
2.47.3

