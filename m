Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34F55C5B572
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Aug 2026 04:37:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD41110E03B;
	Thu, 13 Aug 2026 04:37:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4Kke2lP3";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011065.outbound.protection.outlook.com [40.107.208.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 921AD10E03B
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Aug 2026 04:37:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eli/tYSUulOEaSfD/nVBtSsNiuwAU7GIPcCj4oS7Ei1DPWC9o/FXobibgi1tS5xLAgXNJgrV4NKhwHUAQpMlCAsQH0M7QX2Qt4BqJIrFwh5xGlCedN79KSEMA2nU4h0CBUKaR8hXq/6fOj78NfDGNJoVdIQm9JL/Q7NBUdL5f1P8ABuF+kgsFvCNm9b2mctGUg0wRrUpx5cQSwK2/eo2y2tmWURW6ovcUsq1x4pHjTfZ6fm4dEfudN69AhXjYpeDLsJfDqud/0uuN3/4335JgO6Atiqt5449aoIZqv+h1+1VGZ0gEzPcvPJ9h4xCo2vZkuamnSrc6/AuBpj/tYLJSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=59NZF3vw0CxWwEnYQVWmDgstAkda5S7HbtyhxJbdQeU=;
 b=yp59PHct5HIEb81VaeS/ro0qsVfRB2+yi1N3GxlaMTwtbRHFOY3K28HqQUnOHQl+bU3Oxs7sN6UKbblMDBWId8GbAD6f607VSvrQlruhkUk2Rwiizlmr9vMertJLsILtV6rb4m+PqwfwDMx5GbxSh4mUBFfSu5vh3aqeNd0bpGqjEKaoqOQdYEH6XCEovvAgwCXKBX66685FaokNMAMerxsbvlIH+QwmfJYX8xEsn7M1ejZvAR2vQeYuD2nTgb3HVwtHqameBnguuymHGQOmb/bRUJXwJL95Qxx8msw7jRaQrekyElt/C6J2JFyG0rDN8QKBC6FQO2ZVApXushskUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=59NZF3vw0CxWwEnYQVWmDgstAkda5S7HbtyhxJbdQeU=;
 b=4Kke2lP3NDIuTj4qgUoaFoCqqQ8wY63/vmTREWRHBLOhr7Wnm/y5BbevihXVskqgD9tL9ivU16jP0IThoQ123mBUjZioxsdkx3w6owBTP+T7TXi9ubnHT/87mUgYwY/qb3bjoNARjo3OSJrdYpylLLJ1PBW3eKHPN3eCz5Ck8cc=
Received: from PH7P220CA0128.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:327::15)
 by MW6PR12MB8999.namprd12.prod.outlook.com (2603:10b6:303:247::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.13; Thu, 13 Aug
 2026 04:37:20 +0000
Received: from MW1PEPF0001615A.namprd21.prod.outlook.com
 (2603:10b6:510:327:cafe::b) by PH7P220CA0128.outlook.office365.com
 (2603:10b6:510:327::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.14 via Frontend Transport; Thu,
 13 Aug 2026 04:37:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MW1PEPF0001615A.mail.protection.outlook.com (10.167.249.85) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.0 via Frontend Transport; Thu, 13 Aug 2026 04:37:19 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 12 Aug
 2026 23:37:18 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 12 Aug
 2026 23:37:18 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Wed, 12 Aug 2026 23:37:11 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Shaoyun Liu <shaoyun.liu@amd.com>, Amber Lin <Amber.Lin@amd.com>,
 Jesse Zhang <Jesse.Zhang@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: force complete the KIQ ring fences on reset
Date: Thu, 13 Aug 2026 12:36:59 +0800
Message-ID: <20260813043706.3195196-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW1PEPF0001615A:EE_|MW6PR12MB8999:EE_
X-MS-Office365-Filtering-Correlation-Id: c0526638-6578-4a8e-94c8-08def8f48f74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|82310400026|36860700016|1800799024|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: /b0qFH47hKTjbnnUtTGUh6J517ovI7m23PQ4Vi6kJrF5IUxuF3auFl8sHnAZR9Six7zqjIc92UJj8RKE+Rd8Q7iaZezkF5N5s2qft/rkaR1W3F+t6ovP3Pey3uvx0X6dF9w5S9WPZjBte8jrPyN2g4pUYOD54na2cnHfcbwZR7CoLRVrv7KB4xsbQvMTKwOSVl+VvcYUUqnLVWoaaph/AVApJAZMgYctHeSB3jhzHjjVK0gK6xbWOOgf7I/0tx/UMWlzuQQvbcPumP4xu4fo8I2m4paavdodETZsCKh9yzmVPfjVXwq7XQhBAgy0D0HaWeIHVnDAf28wlTHCcMe9Ji0/M6OUnwZwlOCL8NmeU6y/ugRSW8ujwXsr8TSOb1i9LM9cOlFm6eDizYy8DLnCxnu9s3gzbpwSe8wnDSnqp1cxdhsoxPK7BVUYSRvaO83G/+1YmGf5kghBpx/7oV+Hkd8L/mNkQyukmJicSyZHnbkfBupHoKDiZdttR48FyZ6OKQbMpxUWd47EH8RX4wrUA2IETryRGVSdXj/fufjFTXNSZwi295kMCRrSqLcCltkJsQmO1Pj0NfNwugAKx0W3LkKjLt9CTuiMDFcIeMVpSTwkb0tJWmAHZdpnf3DS3ISa2X3kVf5cgGC881bB7WoxQnObNCJOTkrsGvBplDVoreOpzwleoz+uMBNiKEHJx6nFgN24BDFh1T/Gv6q/xqiNGQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(82310400026)(36860700016)(1800799024)(18002099003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: LhAmPxaaAn5nTlr+NacwaU0Zo7+4SoCCRHGRCFilvR9JMheTJUvzWZy94SPw1T6V1d33Urjhyuc1wslfmulzPzuKtvFS9e7czHkpde4lfD70SCLNx1ytC/pcfyfCdplZyYSVjwKHaLrnpei5JjAnnbqUaGa5Y3EKcnqUE5qgzXUoqpFGX4q14Mmg6DZkh9xl/RBkisiUMKi0Gse9MoXwbTxZQpcBZA35g9ppyopD4Xp/AWI2dELbsxUZtm/2T2lHxMVFaS7cWSZVDmTdpN5M0CvlWPWePzyZpqQgLlXxgoaS48okiemvbVc6Fc2LsyUN2bYHJBajQ1fAJyygIrEQ+1ymXpVEW3OZtIx8uC371LtU81UqngfW4rIgaGAc2YB6d4XNJGUuWTNjAUNy01X09/O5YJK4VmADlKyErpD1iySDd/5whw8aSP+chp8kXCaI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 04:37:19.4339 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c0526638-6578-4a8e-94c8-08def8f48f74
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MW1PEPF0001615A.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8999
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

Like the MES scheduler ring, the KIQ ring sets no_scheduler = true and uses a
polling fence, so it is skipped by the force-completion loop in
amdgpu_device_pre_asic_reset(). Its hw fence value lives in wb (GTT) memory and
survives a MODE1 reset while fence_drv.sync_seq keeps advancing, so after a
reset the first KIQ submission can poll forever on a seq that is never written
back.

Force complete the KIQ ring fences too so their hw fence is realigned to
sync_seq.

Suggested-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 168947747c5c..77426e814e08 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5049,6 +5049,18 @@ int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
 			amdgpu_fence_driver_force_completion(mes_ring, fence);
 	}
 
+	/*
+	 * KIQ rings are polling-fence/no_scheduler like MES, so realign their
+	 * fence too (one ring per XCC), otherwise the first post-reset KIQ
+	 * submission polls forever on a stale seq.
+	 */
+	for (i = 0; i < AMDGPU_MAX_GC_INSTANCES; i++) {
+		struct amdgpu_ring *kiq_ring = &adev->gfx.kiq[i].ring;
+
+		if (kiq_ring->fence_drv.initialized && kiq_ring->sched.ready)
+			amdgpu_fence_driver_force_completion(kiq_ring, fence);
+	}
+
 	amdgpu_fence_driver_isr_toggle(adev, false);
 
 	r = amdgpu_reset_prepare_hwcontext(adev, reset_context);
-- 
2.49.0

