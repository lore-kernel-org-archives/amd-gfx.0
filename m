Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C57C9C624D1
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2026 18:29:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A4A8A10EA73;
	Mon, 31 Aug 2026 18:29:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="p2CqAS++";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010062.outbound.protection.outlook.com [52.101.61.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 441FF10EA45
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 18:28:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xnER0x9tcexX5eZ8YUDHp4pajMS4RO73RbotaLZfzMSGLqEsa6AGhKc1Xo6YuFcqX5DG0OHiSyIKnmduoluoLkt6Blg5NmJtUU11C6nnuh6MpUBwZnzZ3R8SIGpBXu140rxnI2RXtVdNlTDqhsdZt5lKZGmrKLLRm5yGvTtb7fBkdyXqwetwt483f3ak7L3RQM0XsoezC9R4lQj0sCC1CbeahOS71QmnyU6jt7l+32mT3JAhCLyJuyCIXXpE9lTKXJ+JrjDQYWW3GlfCK1V4S8R4Yt7Aptxwfuex7F4XvVw0gAPXYMutg+dprPCfSlx8y2Yric17PU1ZZQAJIC587A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nEzZTe5ASUcReC/VMIaho+K+KzB3md+Nd/ButyREn84=;
 b=fxPvGYAcNxCzVTsm2bHBqoqN55yyego12YFJfXDoph2BhZ9iAewBGm/ky+x6rCL887NvII/DUAuExS81tlrZSXomYHSzSlLT3iSxGm5iLWbwKRf3lnffpjKeEOk5MgIhMQaBN9MuvRS7ShjjArFxihYLqzYk/rnROYv6mtuO2OuCwb8JgqHynra6i1cLSgb+O5gbbMluBmbMIMDjrW/twNUKda71l+QlTda/HiYORN9Ji7BwhpqAFMuGlj1jM36QihNEckG0fTkD75jp6rFWTD1Jdy0ADu/nbpumV9VOQtw6tqz9NgQyGYzXT2RTGRso99Nfn5/QtBzddSelndcEZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nEzZTe5ASUcReC/VMIaho+K+KzB3md+Nd/ButyREn84=;
 b=p2CqAS++7EENmfN2piBluzk5POd1zIO7WBSiE7OrjlFsbvjHR1svoLz7pDKAyLr2ImoVca1K2O2D77HdnCz8iW0eQ2ZGGaYO2xRQ3NeQYAWdjoeY+9L6IOKO1U5AKPnLBlDUVbEgUw1Na5jjs5zLPespLmsP6UTGcguBqWyRZK0=
Received: from BN9PR03CA0141.namprd03.prod.outlook.com (2603:10b6:408:fe::26)
 by IA1PR12MB7757.namprd12.prod.outlook.com (2603:10b6:208:422::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 18:28:52 +0000
Received: from BN3PEPF0000B072.namprd04.prod.outlook.com
 (2603:10b6:408:fe:cafe::4d) by BN9PR03CA0141.outlook.office365.com
 (2603:10b6:408:fe::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Mon,
 31 Aug 2026 18:28:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B072.mail.protection.outlook.com (10.167.243.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Mon, 31 Aug 2026 18:28:51 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 13:28:34 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 13:28:34 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Mon, 31 Aug 2026 13:28:33 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mukul Joshi <mukul.joshi@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 44/95] drm/amdgpu: Create a drm client for UALink NPA BOs
Date: Mon, 31 Aug 2026 14:27:03 -0400
Message-ID: <20260831182754.1089811-45-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831182754.1089811-1-alexander.deucher@amd.com>
References: <20260831182754.1089811-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B072:EE_|IA1PR12MB7757:EE_
X-MS-Office365-Filtering-Correlation-Id: 35dc4607-87f6-44c3-ef37-08df078db4f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700016|23010399003|82310400026|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Qj0B+OmJiV+Ps4r/C10ahV+YHBMEearGmSEtYN1HNITXEfCVhLRZ8ZS/abiBU8VX6FfIAFVhsQUs3+jf7QtqN3EmuRohLEAMp8JbfGX8DLyJa7vaWNJyinmygjCEwTGO8w40rGVp1rWsnJ+tQVEaeiGMh5qnMIbCZWqo9h5dHWy5+cL4l8sSqrEcSBkN5o5tLVDWf8/GyEY/0taBrGZz+etyDZpyVbaiUYbL8Rx4zw5EirJik1o8i0w9zFNrw68mstswH7IWjHrvY4z3lz2pxbyS+SSTB8qz/iDucxVvmUks1c8ZVA9G6+TwmMuWu69HztjMBFIw+yX59yNpXFOn5/lva3CphjSBY4Nu9hzuc3cn/Vs4Uo2SRrP0+F7nPUkF0ZjVP+xAkt6mgqoLwzhExFs2VFju8OdOZBQrZpf1m/LpOm9sG5GCXTGHt9msU1tV5hlXd/JeP4XXJwApKiZEz7D/e6fTZ2lGYseYdrrXruAn4Cb6ZxY6JHphI7V77yZ3x9IVEuf7IrkHK7sElUJNsna6XUdr1skxYg15hjDGtC28E/8obUufMxNGd/WrX1CBqLH1Z2QYxGVsNwty2lIZ/s51foZaNMaoMY1pOhdsnm4tvAzDXVniU4tp5mXwUDw2Wg7ERPWRMkpkqW8isKuTqQ4JX5seA96kTqLwKR1bro6X7dO9v0aP5X4JiIQR7Z1yWC2r0uBf9mWFLrpUbfz3Lw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700016)(23010399003)(82310400026)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: WF/MhWU8Nd09O/ieIJMh/yoaNpJ6xuY6A6olldkYREl8mGhj9op7VVOm7Tph7XGlJHAvLx4bjnWqGjBmaEkhQpFi1Xf1rQuZUMFybkxZ+XAa2cm4O77k/KkIfS38SI3qdMKcEO9hyo9mQHJeYcrrS7TTQQdwdc4bjgzt1O144bS54NB1zdFWpkhc1AEUJFAcv0PDW3fWzImEfh8pbHevYt1Hw7vzbvzXj7fTOIEUajiumZlnXlFQAk9PMvD9pCfz5exybpqir9X475SMYExOzFNr+7jOsHfiXVinnFb2KHta8ocdQjzjrJcnxtDSFqyf+aBYxiNXyB9QeqYt0einaLxLVNT9bF9bG1g3FFqMhmW5ILSqk2LYAP1wbKc4QePBOFNpmDYgVLMj10UEEzwEF0ksE86f+yRHXB/a7qOjDkTHT3AbpXXQ/YQU5B6mfZMX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 18:28:51.7463 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 35dc4607-87f6-44c3-ef37-08df078db4f8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B072.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7757
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

From: Mukul Joshi <mukul.joshi@amd.com>

Create a drm client for storing the GEM handles corresponding
to NPA BOs. We always want to keep one GEM handle alive for
the NPA BOs during the lifetime of the BO.

Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c | 28 ++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h |  3 +++
 2 files changed, 31 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index d424c71905ff2..51078e83e3e1a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -31,6 +31,27 @@
 #include <linux/sysfs.h>
 #include <linux/string.h>
 
+static const struct drm_client_funcs ualink_client_funcs = {
+	.unregister	= drm_client_release,
+};
+
+static int amdgpu_ualink_drm_client_create(struct amdgpu_device *adev)
+{
+	int ret;
+
+	ret = drm_client_init(&adev->ddev, &adev->ualink.client, "ualink",
+			      &ualink_client_funcs);
+	if (ret) {
+		dev_err(adev->dev, "Failed to init UALink DRM client: %d\n",
+			ret);
+		return ret;
+	}
+
+	drm_client_register(&adev->ualink.client);
+
+	return 0;
+}
+
 int amdgpu_ualink_init(struct amdgpu_device *adev)
 {
 	int r;
@@ -62,6 +83,13 @@ int amdgpu_ualink_init(struct amdgpu_device *adev)
 		return r;
 	}
 
+	r = amdgpu_ualink_drm_client_create(adev);
+	if (r) {
+		dev_err(adev->dev, "Failed to create UALink DRM client: %d\n",
+			r);
+		return r;
+	}
+
 	r = amdgpu_ualink_init_interrupt(adev);
 	if (r) {
 		dev_err(adev->dev,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
index 3fde1b80c3e92..cb971ac8bdd9e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.h
@@ -186,6 +186,9 @@ struct amdgpu_ualink_mgr {
 	/* NPA-VM used on the exporter.*/
 	struct amdgpu_vm npa_vm;
 
+	/* DRM client for UALink to manage GEM handles for NPA BOs */
+	struct drm_client_dev client;
+
 	/* Sequence number to track the need for TLB flushes */
 	atomic64_t last_flushed_tlb_seq;
 };
-- 
2.55.0

