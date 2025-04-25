Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9805DC369C2
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Apr 2025 18:34:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A87F10E33E;
	Fri, 25 Apr 2025 18:34:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WgQIYbmG";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2089.outbound.protection.outlook.com [40.107.212.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 863F910E33C
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Apr 2025 18:34:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XHzIyTLtaHCPsqVPJft2Kjs10qT7vuPmzTyH7cB9HfYYmGOt3so4qs79k7dRXexB++kMFVq+EBrzqpqU1P/LIL2F4B9iijjKRtBYK+6VgqvQENWIo+tEh5b+JBQrUw86dHKDDRscuEKohC3FMyAQPWn+MEJIbNdl8I/6H6JjMaIBub9lPcf9eVOmOtBZnMNAUpjQCEA2NXbIBgcAd8GBP199ZlWHUyrmXAfWOe3Wyu8rwfmamuLiZDm0wmO/m0/Z7y2RkF5jxkIM0x9z98flaDbQc+cLxHPz8Ab7MboHiJV/bRWmBespffINQ4/zaVm2CQGojgVjzg0TVJKUiR26hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UUgHfgQtsc3Tb6EKpxKZdDzsuWRmPZaqTUpUag3lhL0=;
 b=omqy/rq8M6JK/yCkpXdmjgbLYkvcwOgezU9h8GyP0mERCiK1l/8bfOaZkpBlzJMJ2R8R6xPuE/pCLt+qkLh0d0+YdDuk9hnAOIdR5tZUpW86HWK9RaGcx8Mo/zEKHpRCrtPli7TgmMLx5/WKLnWtgDTGr5uJpO2Zsn4xjuFTqKbAQezs2NVY5rhc7mP8oPq6+4OEgECEhWI4cabXFQpnCdeBzMW8rasnWw9mUg6jsmnF8MM2yo4fTiUT36/EEtWw94cTTgqQXERKl1zFi/HhKt45NkE+kVLnrsAj7LCrdGSp2dAU5AK5ZC9+/j27f3mUWETjFwLDOwmKs605iewfUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UUgHfgQtsc3Tb6EKpxKZdDzsuWRmPZaqTUpUag3lhL0=;
 b=WgQIYbmGEKeNjOf1AvnIFTpxYiTH2xT7EPEkitSsWGlh5fBg3thNnAR7r1s3vPdFD2xLzPXjBoNMzug1Bo7hsbxLnA5FT7ekLalJd4+R2LQ3QC0gNM4JnxjqOxKRQE2r69pyVMP/EPj/IVPxL2fPzwr9EGFhYTzmC7r6ilzij2U=
Received: from LV3P220CA0018.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:234::19)
 by DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8678.27; Fri, 25 Apr 2025 18:34:44 +0000
Received: from BN2PEPF00004FC0.namprd04.prod.outlook.com
 (2603:10b6:408:234:cafe::40) by LV3P220CA0018.outlook.office365.com
 (2603:10b6:408:234::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.38 via Frontend Transport; Fri,
 25 Apr 2025 18:34:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF00004FC0.mail.protection.outlook.com (10.167.243.186) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Fri, 25 Apr 2025 18:34:43 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 25 Apr
 2025 13:34:42 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/2] drm/amdgpu/userq: take the userq_mgr lock in
 suspend/resume
Date: Fri, 25 Apr 2025 14:34:27 -0400
Message-ID: <20250425183428.162862-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FC0:EE_|DS7PR12MB6048:EE_
X-MS-Office365-Filtering-Correlation-Id: c1839e8a-af9c-4f45-4d8b-08dd8427d8ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zxVBsxTD//CXoGNfEqJxrSnFLIFZFId/EwkCIM5iJtt4DV3jwEHxH+uGaTH1?=
 =?us-ascii?Q?OTNO8aOgZhDp9XAQ0UyC+5d6VtrCQyqYUvJwxo/ffc7uMcQbubU3A6u3UzdS?=
 =?us-ascii?Q?9O0xKVsIp3aQlc9CptHzyETQQibbsd1MRXprNDyzimWMTWXU2Kce47SHEB3/?=
 =?us-ascii?Q?ADKCpC375huQJLNfPJUECYLjjMScMpLFvDHCRXrgmqGR2QnsagGournckU6x?=
 =?us-ascii?Q?oCRrdOauwYUU3n9r8tF9iZtLlkXoroQUAkKRbckSWr9oLPF/RAp67XNOA6Qn?=
 =?us-ascii?Q?Q/Wv5igIuMYnbD4ThjvWKgOfRE/EK9B6N7CveTpSEhBZYaMRTEAndAwNCkE0?=
 =?us-ascii?Q?mfWCjVYzOYOZbctNFaA2bLPOSYR/zD8bwWHk/wt3//WikPx2nk6exHBAAGH0?=
 =?us-ascii?Q?/NOdDJYa4MtgibjHty/tQmqvd1fX6WkDsUHKMVq8vNK7i5X+YN/ZkUFwZxTj?=
 =?us-ascii?Q?DA1g1J06ltFSXb9OzGcu7iiNEEpmzByQh0pjHuALInjkMKWpXxlKjHDJsaD/?=
 =?us-ascii?Q?zo01q2ppiCZGhacN9rlplC5G0SlSbIJsMEfhn5VeqUVSsbP1KUdBzPTM9ybp?=
 =?us-ascii?Q?p5cawwNjJdo1ZLjG070h/s75MWxaOTDRFiYJiQXaLvm2xD3H1vWTRenZozxN?=
 =?us-ascii?Q?3qnjzejqBP1P1stVhz1zOSgWBrXs0nI+BOLuu+S3LD8twUcBlejqvgzI2cxx?=
 =?us-ascii?Q?m5AMdfQ3qNnEUa+w2lcGsewF7zUKEPJcNsP4CbdE81VyTockhJKlfK20YHRD?=
 =?us-ascii?Q?e1hT9CZ/ZJkgE9KCwQOO+/sJRDC8i8k3ACUQLFpjYX+Oz8MmbBBEUUu2e9Qs?=
 =?us-ascii?Q?pzpp41Oh8Cp8qWS4Bt8kHxaIFBOnxEtzUcuFODEdpaHZVzVPlQdA+TdBurjD?=
 =?us-ascii?Q?FFbGlY0VzwAbaVNavHeF1GNOnaMRdqfEnrOhbMMX9VbU7HkaGLuFQ3e1u+vF?=
 =?us-ascii?Q?sjTtg8mOHr8tzgMWtGGkPJw9j0/pJps30pL80qLwsT0SUaakN+AfTq6sAfiO?=
 =?us-ascii?Q?H5Y/BHVB+1h/VLgmY0OxPogk/WwLdNetvwvmAdKxpoD08enNkQ7ltPTydFkE?=
 =?us-ascii?Q?TCD2Bzid1AFnf4omVCkrvl5yj/vUHrhynqsIrr2ns0LiiKlzFVeA6MEkdNqv?=
 =?us-ascii?Q?fUJZoUc7Pi59TBRE/P8cC/rY7yj5kOYrecsliwnbcLLJ4iFQvV5yMwjEKQ2v?=
 =?us-ascii?Q?DlehHewPj6HMdTnbyNVQy8rQFmjNNluC1J0ffRm95FSNOrj1WQqEivHyL7hd?=
 =?us-ascii?Q?jMyY48hfJDFUStZuAzUjJp12rHoBpFPSQOCj0zuleVd2grTNOi4h3StZphg2?=
 =?us-ascii?Q?ubeo+DFHnoEV/rBZY83C+xP11sRJfWRNDdZso9Jl7C7zyaZpo8wYGbD0x3sB?=
 =?us-ascii?Q?wbyuYCdLe5rMgfFi3mGHgTMBH5RXjJUpueihczPdlXyivRErbaK91/SgTa7f?=
 =?us-ascii?Q?OhkQhkVbG6pbQjFTPuPOlbjyBe43Fctp42wbjMNufiCk8iw8m8Cik62tZEdF?=
 =?us-ascii?Q?VM4ydYolKN92/ticIWbPFDKyzuLShdMTh5lx?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2025 18:34:43.4252 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1839e8a-af9c-4f45-4d8b-08dd8427d8ee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FC0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6048
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

Add the missing locking.

Fixes: 73e12e98ec0c ("drm/amdgpu/userq: add suspend and resume helpers")
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 451890ee3fb79..1fa9d2be87f39 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -809,11 +809,13 @@ int amdgpu_userq_suspend(struct amdgpu_device *adev)
 	mutex_lock(&adev->userq_mutex);
 	list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
 		cancel_delayed_work_sync(&uqm->resume_work);
+		mutex_lock(&uqm->userq_mutex);
 		idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
 			r = amdgpu_userq_unmap_helper(uqm, queue);
 			if (r)
 				ret = r;
 		}
+		mutex_unlock(&uqm->userq_mutex);
 	}
 	mutex_unlock(&adev->userq_mutex);
 	return ret;
@@ -832,11 +834,13 @@ int amdgpu_userq_resume(struct amdgpu_device *adev)
 
 	mutex_lock(&adev->userq_mutex);
 	list_for_each_entry_safe(uqm, tmp, &adev->userq_mgr_list, list) {
+		mutex_lock(&uqm->userq_mutex);
 		idr_for_each_entry(&uqm->userq_idr, queue, queue_id) {
 			r = amdgpu_userq_map_helper(uqm, queue);
 			if (r)
 				ret = r;
 		}
+		mutex_unlock(&uqm->userq_mutex);
 	}
 	mutex_unlock(&adev->userq_mutex);
 	return ret;
-- 
2.49.0

