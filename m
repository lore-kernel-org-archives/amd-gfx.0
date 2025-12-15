Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE07ED5B865
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Dec 2025 18:16:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 48EEF10E4DB;
	Mon, 15 Dec 2025 18:16:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TMJsjNrH";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013008.outbound.protection.outlook.com
 [40.93.201.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE63B10E4E2
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Dec 2025 18:16:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XhWaNWnfZPR1MpQvfx3YDjd7sdduWBGjPltUcKQ57RGbnwm4U6wL1TYzAXtiaQ7Qmj5HukcZAQ0R4HFAW7IvZLf5URK9zlo1tC2UgOgr+Fbi3HHI1YsHWEVQGegDCenBkYb3KtIR9+Z9lVXpgNCCypfIURjKxSZ6q/qV1DL7wOW8qahffrMXJh1SMxtmh5+wC25miC2b59evnJ2gls4n1dhVmDXo4Qjqzqq/0gkQ1uX1Vlx2I95k/NoeK8vTMY6satScB8zRHjePYD4/yek6hNJbawMjYZcrhChrS+0JCUnMIu8Rt0YsGiv6xcvT9nhtezRkFFW6dGNVtWGBkayc5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jbjmzXRjsmz0rPITQvQbPLmpXVIJ/VUwRKucnmjFXRs=;
 b=kbfFvSkyAGozG3i4SuymbrxyGV1XxnWPluO5wHIhmzneXtqEA+qs9yoitKbhN5X0HFPJbGconIaC29LZVGWskHzHiGO0R7q+v5gCFioQDmCjj2H062uRNldyybEUGHTfLOMi4U6Cai4QwdNYxfZIeBLdCBohMPAdCh6j9mJt5tmRXMYMxWxBAVGLlKeU5EpAlHnPiTdgp4oJ/M4QuOMsAdo3hYH+Yovu0Vul/ze6sUX5zGGzGYTDQ5DKsukh/f0MCnAuZ+fl02VsTeLnZZ4sqKs0cIH24Exn9a0hrotkb4ueyRu6PTcORTsYkAPyV6dLdS/uJ/rqYUEKK0dg8nIhxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jbjmzXRjsmz0rPITQvQbPLmpXVIJ/VUwRKucnmjFXRs=;
 b=TMJsjNrHtWnCdL+Ia3Nu74eCiK9/6VMAkT+9oXgJWbXrJFAKrLcRL3c5kp6PH7kfkZyoY/DReb9v+OOQ2FNPfb1wGz3IoEpmQygS2y5mLqqtBRSlT9jH04NfPNKFQNz+NH3Q9Tf4Za/ZIllpdIHBjoZKP6YzP8iGB13DZ/ukTYs=
Received: from BL1PR13CA0229.namprd13.prod.outlook.com (2603:10b6:208:2bf::24)
 by PH8PR12MB7109.namprd12.prod.outlook.com (2603:10b6:510:22f::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 18:16:40 +0000
Received: from BL6PEPF0001AB74.namprd02.prod.outlook.com
 (2603:10b6:208:2bf:cafe::89) by BL1PR13CA0229.outlook.office365.com
 (2603:10b6:208:2bf::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.6 via Frontend Transport; Mon,
 15 Dec 2025 18:16:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB74.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Mon, 15 Dec 2025 18:16:39 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 15 Dec
 2025 12:16:30 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Hawking Zhang <Hawking.Zhang@amd.com>, Le Ma <le.ma@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: Do not initialize imu callback for vf
Date: Mon, 15 Dec 2025 13:16:06 -0500
Message-ID: <20251215181607.29132-19-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251215181607.29132-1-alexander.deucher@amd.com>
References: <20251215181607.29132-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB74:EE_|PH8PR12MB7109:EE_
X-MS-Office365-Filtering-Correlation-Id: 37c7017f-1ab3-442a-3ef5-08de3c0617a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?SnIb76mDco5zZ1Clb2MMucD3ifOcWGtWKj7M80QVg66GnQ7SMnZ1HtMpdNjh?=
 =?us-ascii?Q?O+CqcbML+p63HUgpTZeGAMkNa+6sqnC32jBacyJ4PfIMHzyWmRnMB2vGUsPq?=
 =?us-ascii?Q?5Q/wBr/XzvHmhimS7PwsMx4/076yh7yM9PitRP/46d+K/eNoyvTjy60ZIBe8?=
 =?us-ascii?Q?o6NDQhNhnBh0O7xOBA+mvpi/QgThfuWZsjnhFHYfJiiBdZN177eR/wd3TjcB?=
 =?us-ascii?Q?C4hapja91lbrw7JMDvEOb7datVk5pfQOp/+IXnVmTvQSC80NN8vF2RXq+tl4?=
 =?us-ascii?Q?qz0S2COPcWoCHElzTiryGl9FQw8Zc6oLXy7FeMeT3g/pSnwdtGIlITiNHTtK?=
 =?us-ascii?Q?SrEtDpi93y3Ti7dwQbos4NOWD7Vv9pU7J8/vAj8QW+6Kj9fg9I1sDChwe2VF?=
 =?us-ascii?Q?mnE/iikN8GdJS8qVMTEBY2FjtethIcXX1tRZuz/0fBpeQfHTS+Tu2b/W/B7S?=
 =?us-ascii?Q?duw36JJl0KtTbgBZGj+vyjA2rOtEs5XK7HRN20ZxBQvU+EdDc+QmoBFzuoW1?=
 =?us-ascii?Q?MFCK5RJ5/T5pKMpPwRLDT5GYFZ6yYdQEa+U2q3fJZql6mT2XR4IOFVAahUQ9?=
 =?us-ascii?Q?9Fqu4x6gMLOKaepDko/eVcp7Sl7YZZilCzOuU7UIzpHvBkH1IpuRdW8d3yUl?=
 =?us-ascii?Q?dLaCcOkbh88puA7eWQDVUtesioYdgw6l34idEif2P9az4kRCnM+rlbXrbUkI?=
 =?us-ascii?Q?669uxz57F7Ku0LSqsXPcP4fiZkDsDxKkZNp7gj0555GfU4s2X6An7VayZnTY?=
 =?us-ascii?Q?h5jUkQsqGbYcbIZU7PDaHSxm1Ec1yLY+gpmSOom9gHHPy6zaFTDKDlq9J3aK?=
 =?us-ascii?Q?FZTZTfyHwkMgD/OJJIICegtPc5WX/RPh7U9rnjbQUgzo9KJ1cEL04ug3TeJV?=
 =?us-ascii?Q?MOK9gRDodO988k4GgB+i25wIQTYkDdsq1q+LOLjnyW/IPpb2qkH2HU2egIPS?=
 =?us-ascii?Q?BTXQ1Fd9ijSSmp4J4SzT8wY5MsVVggGijCtg/+mRS2VGNbdM2Dj4pfXpuOyZ?=
 =?us-ascii?Q?/xzTZxkO7pn2qv5pvsDGm6Nv3senXhAPFcDLS4QtDWF31n7M2kmIvX3cLu2a?=
 =?us-ascii?Q?krItEwqJ+G1YMCaZCrKs8symCRAmiMzjMde43ppI330rcOlliFOiTcDYVJDe?=
 =?us-ascii?Q?v9UAmydHA1t6Vd+EVjW8+Ez0T3k92njkmRMeV4dVP1ioYSP/KgZSvBBcmGxU?=
 =?us-ascii?Q?rE8u0Q4aL4ZvRA+fnRAFryMBkHvBK91yDt5J5lmiQgeH121Dbw/CqzuOXioR?=
 =?us-ascii?Q?DJ3gMc1Ulg0S9CqsrOAqnWtAv5DufnxoNYhyVI/m9bUSZPEQCaljh07KT9T/?=
 =?us-ascii?Q?6p6TdbRNB/XbiOp5CBaq93w0HxEVfpendIlXGOwZxKKkPiLkiH5m99aCoWVq?=
 =?us-ascii?Q?hD1j4kMMrfA/lWjgxftcIZwvu5V9DgMPYvwmFxPt6OsxijtV9PiulZZ9fCAg?=
 =?us-ascii?Q?e7PaknAgKXqIiGDSb3z+fflmiw4OtCqkD9AaHP8WQQ+WsI3y5/EEig9URosx?=
 =?us-ascii?Q?H6O73SfWNPF1Mp9woe1hZGOBJBtivGQ8L45pAQO7JPF3hbaIlOXZDkYWf2JN?=
 =?us-ascii?Q?9cXhoQTeLwRs4HIy0BQ=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 18:16:39.6796 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37c7017f-1ab3-442a-3ef5-08de3c0617a3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB74.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7109
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

From: Hawking Zhang <Hawking.Zhang@amd.com>

Not needed in guest environment

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Le Ma <le.ma@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
index ae65d70c3d10c..ed6c2aae3c486 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
@@ -3873,8 +3873,8 @@ static void gfx_v12_1_set_imu_funcs(struct amdgpu_device *adev)
 		adev->gfx.imu.mode = MISSION_MODE;
 	else
 		adev->gfx.imu.mode = DEBUG_MODE;
-
-	adev->gfx.imu.funcs = &gfx_v12_1_imu_funcs;
+	if (!amdgpu_sriov_vf(adev))
+		adev->gfx.imu.funcs = &gfx_v12_1_imu_funcs;
 }
 
 static void gfx_v12_1_set_rlc_funcs(struct amdgpu_device *adev)
-- 
2.52.0

