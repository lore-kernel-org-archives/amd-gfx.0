Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38D2ACD4F5B
	for <amd-gfx@archiver.kernel.org>; Tue, 19 May 2026 19:41:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3A5310E0B6;
	Tue, 19 May 2026 19:41:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5QxyVT4d";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010035.outbound.protection.outlook.com [52.101.56.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B43410E3DA
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2026 19:41:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L/gQ5GcxIoW9FCnPeqb73L+zZi0MU9jwPEeGToB2zQM1H2sBliEJmPHw+8hrmlB5f6RBGNw9HxwXC2jU2FSaHFmC4U9HURzmusgsxDdR7MXi0E68vIJiW/StNAuyvmBb3BmzemWhc3Ounw5ZwDDxm3x/n/i8IvgyHxdc1gyDYT9RQppCEEGOEUZqXUaD5Kwv5G7i5/LYu8JAer4RUBRVWjjEUMS/0bl1DrqPq/fp85cnUHeBKGWbErGgGx/6gI/Lw4tQou8FWG8dOAzce4B/kordqAgZr1ejQYs+Poi64atT+GDvvwsQzbdDHdhK/65UhPJENlrdRPPynDBTBCwR2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ejiXOn1NbA4BCX2d6K2DtoR29Q1nvTc8BcB9A31QnYc=;
 b=E4ytk8B8QPaMYmHZkWjBlYhQLhydYhZHeQ0sWoWRbaS9RM8bfV+uuBgS8LzhXz8NXnGX9+hP8c5I6NSf+eAH6myb3BOsPX5nf+RogYVkkn7R9kjLqpWD7+dzpvYX11D7n6Wq743/KNZiq8oivOSFvoa/RjUpMmH1udsTHOfSVE9t0PnLvTSP0qB872QsIl5aZH7F+e2ixqejfvQqyONcdvO091chuRCVCXQTVbHYjtKlkZxuVD2nQQA5oeEzX8pHO32X/IlI+ZVRbx5aIlomBtPinDscRv8xEyyCwolES5g+vJlUwNY4QkPi891o1nhISydB8PIUvy8McQGY4kIFJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ejiXOn1NbA4BCX2d6K2DtoR29Q1nvTc8BcB9A31QnYc=;
 b=5QxyVT4dKu9nWfGW+vePJEw5Tx6SLUyzh+FneALewlE4LC+7juj6wusQp8cgtJQsiTCBk6eFGIORKLUoCh5MUVFmqHeoHe/WKnPJA5l+ApIiMcH0yHjgLUGXcrdeIP0Q9rWbxeMtHjvKki7kaOrowOjuNcgOq1MCb9dy5tHzizU=
Received: from SA9PR13CA0015.namprd13.prod.outlook.com (2603:10b6:806:21::20)
 by IA1PR12MB9465.namprd12.prod.outlook.com (2603:10b6:208:593::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Tue, 19 May
 2026 19:41:17 +0000
Received: from SA2PEPF00003F67.namprd04.prod.outlook.com
 (2603:10b6:806:21:cafe::3c) by SA9PR13CA0015.outlook.office365.com
 (2603:10b6:806:21::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.15 via Frontend Transport; Tue, 19
 May 2026 19:41:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003F67.mail.protection.outlook.com (10.167.248.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Tue, 19 May 2026 19:41:17 +0000
Received: from atitest-Rembrandt.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Tue, 19 May 2026 14:41:16 -0500
From: <boyuan.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <leo.liu@amd.com>, Boyuan Zhang
 <boyuan.zhang@amd.com>
Subject: [PATCH] drm/amdgpu: fix division by zero with invalid uvd dimensions
Date: Tue, 19 May 2026 15:41:02 -0400
Message-ID: <20260519194102.667522-1-boyuan.zhang@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F67:EE_|IA1PR12MB9465:EE_
X-MS-Office365-Filtering-Correlation-Id: 9173496c-ff46-4d7e-5eb9-08deb5de980e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|11063799006|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: Qj4ohp4itRJIz2vZBM3TvO8gsYGULXHbMAJVTtBXZpHLo+iGH4CLo+yrnepeSTCAowHrdF48awZA1Fd9ZK6ZDuEuZK1S3C6rI+vfyhZ/gNNhN2DWwnLHZfvGAym6fWmGvfK8DU8qkVaFxHqSGFFQc6NfsxpZn5WeAYZrMDoPXFddx39P6ABRXfyfJ8c1rWCVQDWQB7LMevtXhOy24ygmiysF4XciH5yPS/qcXb4MqVmNHjMu2Z+aSPP4XvGpyfX9FlIqvM/ECBCr30X758SMLrXLk/W/DKSwxhf/yikeLlVtmi3TWfTdIisWQcQalIsmvQI1auqNMX3JGYWvHWqPHdrYBiSVCepSfjg4XWUoumfnG4okaZkI/eiCq0yVJ9Fng5u15tVB9TKxECbkcsIc9xZ7e3rg8RNnHaNfK8WnnmVMXouhQQa0RGZ1H3PkzCSdEngrlTQl3wm3I47eW+/P+QtNZbMk/tE5FUlztsx6wtnucMKpElXBw9sN2Qq/wkf/iy85fAjwu9MoB2GrzF16fSoi5HCimsg10w3SzXtAeK7YPb5KSZZT12KVapckrpClmoNAABDsy1OihyXrph9W7YnfPy2VD7Nzm1uNZ3c5v+MNzOn6nSeJAmvAaZe81Apu93GR0e3EpU2yQ6wV9VdRZGCmMMh1oTxwYCwQoat732HdBq/WhkoYFo83VtnAl0My6h0h93v2MhIhnKiyH5NGyILOI4f9utF37GDu5UnIuKI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(11063799006)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: AFoZw4Xbdsr/Sb4bxhRQyxx81CoPEsOE9xcb3VDggNT8+IjAfJRgskQ96iSmyYK1BruKHrwHLXSswm1YcufX00oculmPWdKHduYzsyVDdoY5suxBqruNhk6sIU0IRGIITrgNPzAOOYjtydvuIrZv7hyGq8I3ZVHiMXTXmek+dBrWrlYc9PF2McJdGY/dlsoTDPZh0ftKHL0GQQlW8JiEnaj039frh/r2qa/5L8+CalS512sdM/NRV0NxJKPx0AeFwems5Zm8cFPHWTrNDQZ/XZ9P4Damo4egLoMhvgrKoVFrVUC4JxtUPlnlpBEiimT5XFTufYAKbhYk8Yri8PMUFMsgC1KwY3+6ZIkRgRtlhIYG1P6Jt3WvARve3mJ5p0ketOwUrEQ2Z7CPIqB7/pqdLWUkKS3UTObpTLM7fWNLtsLJei8ZTfP0YRp3/mr6J5Fe
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 19:41:17.1274 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9173496c-ff46-4d7e-5eb9-08deb5de980e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F67.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9465
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

From: Boyuan Zhang <boyuan.zhang@amd.com>

When width or height is less than 16, width_in_mb or height_in_mb
becomes 0, leading to fs_in_mb being 0. This causes a division by
zero when calculating num_dpb_buffer in H264 and H264 Perf decode
paths.

Add validation to reject frames with width < 16 or height < 16
before performing any calculations that depend on these values.

V2: Format change - move up all vaiable definitions.
V3: Use warn_once to avoid spam.

Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
Reviewed-by: Leo Liu <leo.liu@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
index 3a3bc0d370fa..25fcaffb2164 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
@@ -635,6 +635,14 @@ static int amdgpu_uvd_cs_msg_decode(struct amdgpu_device *adev, uint32_t *msg,
 	unsigned int image_size, tmp, min_dpb_size, num_dpb_buffer;
 	unsigned int min_ctx_size = ~0;
 
+	/* Reject invalid dimensions to prevent division by zero */
+	if (width < 16 || height < 16) {
+		dev_WARN_ONCE(adev->dev, 1,
+			      "Invalid UVD decoding dimensions (%dx%d)!\n",
+			      width, height);
+		return -EINVAL;
+	}
+
 	image_size = width * height;
 	image_size += image_size / 2;
 	image_size = ALIGN(image_size, 1024);
-- 
2.43.0

