Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EAE7C624D0
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2026 18:28:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4AED710E9B0;
	Mon, 31 Aug 2026 18:28:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rgQR6Fz5";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010041.outbound.protection.outlook.com [52.101.56.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DDFEA10E4CA
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 18:28:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xLioKPRZAJlKw6oUwhGErEEmQSFSn+WxSfqsM3rCQNfBEW3lZgtLfUs1aJ+G8K9ToQ3ovCVvJvyjEDqJRGKd/DlId6DA3XYEvJN2zK1XnL7uWd7CvTLDDzGixu6Xv3rhYhCpAPiVFpxFkoCFjov2DVLfYSCysFJxRPsGjYrD5bHTZFRRjm26z2ODjMjyPotAfRHX8v0oe10fB15KpQeajQmnZsmjGVyZt6bH4V0mzvL6BfN6up1kwy3MMRRBf6iR9gSeSVAl/teYNJusGepb8sAd3z1251OSzyTpS3WwIktctxJTnVHwbO4w/nom9gX1kxwnEBMjTo2XzeyhHFrN+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Syq1XOc69ANWnCDkOOnRn5jE/cM5vNf9I/QB1Gxob6Y=;
 b=hkvUebmGqdhnjk5aMG4N7iT2hVeX5CAkH0zhENJG+DucxOeWNHryqAEAeOCdDZ5lpJtmXYw+65uLG1yyyZ2zpSqhISqPoQM/DvGGF/t7cKxHlp5G5hQgVlucxrxU4KG4p4MmJV7UKGJKW4fdxiN88RgT7fkP3YpsiHxcG568VkNAXb5u8+wwgZZ9u2tBhHQmcW0lpNxObadg+MqqSX1PKcsPXRTE8khskxcfLy9qyxAcGXupGR0v96k/TZJvGRfyxcy6UatiS+/sA812ZLWUokuNFnFHCmkKuuz4aLnkz/23r7yByDNI8DDknDuWKVPTZv/plUfPlvedgRkLUzUMvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Syq1XOc69ANWnCDkOOnRn5jE/cM5vNf9I/QB1Gxob6Y=;
 b=rgQR6Fz5KtgqEqyBjq0rMAkbRcnr6Zd2WBXNnFYGb3egAwK1FJpI/jx6Q1mEw/i08twFLvahKYN+wc7Fsr+sBQGzJ0yAusbZUHIiy3Y4mH7Ps9mIgOBWV9e26vfrIiR4lPuJCPelxvj7EUUSt6X2nD7OaP1kmevIIzzITOLX4D8=
Received: from PH1PEPF00013305.namprd07.prod.outlook.com (2603:10b6:518:1::17)
 by SA1PR12MB7409.namprd12.prod.outlook.com (2603:10b6:806:29c::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 18:28:22 +0000
Received: from SA2PEPF00001507.namprd04.prod.outlook.com
 (2a01:111:f403:c801::2) by PH1PEPF00013305.outlook.office365.com
 (2603:1036:903:47::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Mon,
 31 Aug 2026 18:28:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SA2PEPF00001507.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 18:28:21 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 13:28:14 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 13:28:15 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Mon, 31 Aug 2026 13:28:14 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Felix Kuehling <felix.kuehling@amd.com>, Mukul Joshi
 <mukul.joshi@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 13/95] drm/amdgpu: Set virtual pod configuration to PSP
Date: Mon, 31 Aug 2026 14:26:32 -0400
Message-ID: <20260831182754.1089811-14-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831182754.1089811-1-alexander.deucher@amd.com>
References: <20260831182754.1089811-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001507:EE_|SA1PR12MB7409:EE_
X-MS-Office365-Filtering-Correlation-Id: 36d797fa-bdc1-48e1-0b74-08df078da325
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|23010399003|376014|22082099003|18002099003|56012099006|6133799003|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: EZG3zzrF3rQj7zN9SxErAcddY03PAyRPkEl9qvgbILFbjILaaTv+toJ6/FmThyBvyidMkahifAkl73icpsv1GerZkIcPmFa0AbHfPlGCETH6TL3BSz3OjXC18GRv+IyDKK/MTTphsvV9B7qudm8ZiJrk63Dl2+JKzLgvizocGU93sUhajwR4RxcBBa7gcKfZ4IPC8N3Apl0s6S78g47pqwz5LPM4GEJbXnmxMtV/ry+KYWfXLhrLasMBlFqMhRDA8ixgUjU2i74TVCwGpHNdj4T8MFeLgjUIZOQCoM7dcQxEXv1c3RO9/dFox8Gb/s1MgB4YCcjRiDxADpD6dBD6kCNnrV78KljFw/dbhlGoAqPmT7LQ7rC9Eu8dSSRpqfDVD4/eAsHUeZ44IhiHt57lyA6H+0ZSS2YkYW11KIYdG5p/xxRZKe3Sxv70vp4AUaU7mWofGXkz56AeNVX4k23A5kDuEaV1idgnaeEIpPPn7G0pWiiC+mHDETFk44N0bdNko6P4xZe6Xky8Ze88EBEbJY7TmSoYVQLhxfyCe5FotbyeDVWdIWU+Lcc1bDYb0aLIGOn8evkNuECBxkVRXRYDR6cVTzyUAyOEA3uRvBYRnaORbj2rbx8QjL56sBPoPTkmptKkMYkWPNdUr0ncCByxZtfN2xBQLBAiezSzFxV4cuczO7FbAhJV0mvhQ5Qwz8O3
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(23010399003)(376014)(22082099003)(18002099003)(56012099006)(6133799003)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: wiADo+9A3rEix56bh9rEGje/kiD3WCtOzKOodai/v6ZcgPvpBFNMP2oEZ0EEmHV1Fkb+N5LYRorQK3KHT7thTUMKsVpeUw+Kzbd3JDx8VzYXTDYU+4xMmLarBA752z5qDOBdH8KVh9/8fy2D4Te1uQrVUeHRpX/+uzfEnG/+0+NQxzohtOfS6fVBJVjSqMfAZfP2+QV8QTo0w9BH/hkv0w/MTNZqRkKSaHJG7C5hAFtwNGRjGW1joERgElineh9AhZ7qudfTkMJXHhLnjsMbqfN5IcmJYU0xPNfMLai15Lv8lwrJbwNixwvHLz15IdK4W7nzrc5RoC6OsjgakpvhX/tvd5v7IFBduFvojs0Y7vLwVv+9IP5SOyEoSSAyDPO97CtS9MlAoxtO6aEpMyrhw8iBbB+WmAr4MGvOHLPCXF+gGoLhNlgfG9JUX6r/Tw5p
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 18:28:21.8479 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 36d797fa-bdc1-48e1-0b74-08df078da325
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001507.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7409
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

From: Felix Kuehling <felix.kuehling@amd.com>

Set the virtual pod configuration to PSP in the commit store callback.

Signed-off-by: Felix Kuehling <felix.kuehling@amd.com>
Reviewed-by: Mukul Joshi <mukul.joshi@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index 6fd1238a50691..657323427f0ee 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -705,6 +705,7 @@ static ssize_t ualink_vpod_config_commit_store(struct kobject *kobj,
 	struct device *dev = kobj_to_dev(info->kobj.parent);
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = drm_to_adev(ddev);
+	int r;
 
 	if (!sysfs_streq(buf, "true"))
 		return -EINVAL;
@@ -713,10 +714,13 @@ static ssize_t ualink_vpod_config_commit_store(struct kobject *kobj,
 		return -EINVAL;
 	}
 
-	/* TODO: instead of just copying the info, call ASP vpod config API
-	 * and query ASP for the updated info
-	 */
-	info->vpod = config->vpod;
+	r = psp_ual_set_vpod_config(&adev->psp, adev->ualink.psp_if_ver,
+				    config);
+	if (r)
+		return r;
+	r = psp_ual_query_info(&adev->psp, adev->ualink.psp_if_ver, info);
+	if (r)
+		return r;
 
 	/* The integrity check makes sure each new GPU is consistent with the
 	 * other GPUs already in the vPod. All known local GPUs can become
-- 
2.55.0

