Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FBC8C27C55
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jun 2024 12:06:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1937D10E91D;
	Thu,  6 Jun 2024 12:06:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RQEXCFML";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2074.outbound.protection.outlook.com [40.107.237.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB5ED10E91D
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jun 2024 12:05:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bcVgEJHZUXY5zE0Pe6FPTjVM3+bmviem6rZwYHIq+PnliR/q2B9+iElPrhHb600ZdrqAu+0iiT/e+f0wvnA3zxWabOsBhNrwUaGa4yHUBl0XzuJWB6CRkIxxnho6BCLstvUpEOeubCG6TRRR/oe9H5GPdeASXAquW0g53bGi5/JjU7ED3YfCOZoJLqybDZKu2O43wIE0kB5juDhpXq4Ey9jgccEL5RIQlXgNtpeflechK0UeZPmcdc7sRU3IKyBSMTGfZ0fea1jCs18Kuz0pUmkkZg8d7nfYlnyNEPbY3LVxjyz9sOdd02EGLbsbc2R38tFMXoLNNOJ5aPCFVAZc+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q2ZmKcH5MP7/6ZRIh7meSlfJziQgD7rzefgu5rYd5U4=;
 b=mQ/Zx/XZJGt41xw509cCz6XudUKtkdXYRD2UuXuIOiLvZnixGAGc2B2Se4+JV+7Gaa4Bk0XJdWvyKX8l8vBMCqMKlUkFN62Vlq5TTwZexDvWmw3tzDnOeHahUxVOqjL+QxD4LwqD9qgtVqavPvoZnHumQDTUiLEHx8Aqo/9Rs3x02NihXqY/3rBytFmxJxbI/cznW1OamyP7cNhV+rgfruqGyNATWOV+HxnFGve+NWaBNUIp2+CAW/xsVZ2HEDT7ogmoum6BcZxZ7UIVGsvWg4P5ym0OZUSHBxayxdUQUiTsBogmLoX52yCeeF23ys+uBC+YxS66sgTCXJ5iGOzafQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q2ZmKcH5MP7/6ZRIh7meSlfJziQgD7rzefgu5rYd5U4=;
 b=RQEXCFMLqz4hy7GYhIGLEWsDDZXB2SEgUYDU8+KJJAzJ+Ip7IcNqf66eosZU6HVT7rrkD90qNpL2zZYauBHcoTxAMwsl7XiFvtUo91YxPgViza3Om1ZF51DM2ZYNW/mJfgWwNkqhwXMpwl9pzU6N6OcFxgKUAWqIokBKM3afxCQ=
Received: from BYAPR04CA0035.namprd04.prod.outlook.com (2603:10b6:a03:40::48)
 by MW4PR12MB6897.namprd12.prod.outlook.com (2603:10b6:303:20a::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Thu, 6 Jun
 2024 12:05:56 +0000
Received: from SJ5PEPF000001CA.namprd05.prod.outlook.com
 (2603:10b6:a03:40:cafe::d1) by BYAPR04CA0035.outlook.office365.com
 (2603:10b6:a03:40::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.16 via Frontend
 Transport; Thu, 6 Jun 2024 12:05:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001CA.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Thu, 6 Jun 2024 12:05:56 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 6 Jun 2024 07:05:53 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH] drm/amdgpu: Move SR-IOV check into
 amdgpu_gfx_sysfs_compute_init
Date: Thu, 6 Jun 2024 17:35:32 +0530
Message-ID: <20240606120532.2499698-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CA:EE_|MW4PR12MB6897:EE_
X-MS-Office365-Filtering-Correlation-Id: e4cd2ed1-1d2b-4598-1c99-08dc86210560
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|36860700004|1800799015|82310400017; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WHo5VnpaMHhSNSswUVUySHdFKzkzVDZPeHNaMXpkczhFbzQrYjlLRGxad2Ra?=
 =?utf-8?B?RTcxRWpxc0F5SFJhNGRQY3dhelpsL0lrYlgxcm5uRkxBamtUMi9sQ0wxb2FH?=
 =?utf-8?B?WXZSd1h2YjRQdjRNQ09UYWt0cHRueFRhMTRKNkp1SlorUUZJL2pyYm1VcDRh?=
 =?utf-8?B?aHNVNGFRd0tRWHFScUZZMkJZbzZlOXpFVzZLbUJrL21UaWF1TVlQZzdmanRr?=
 =?utf-8?B?eTJxeWlWQ0x5dXhLakljYkNqQjRYd3lXSEpkZzlrVUp4V0wyK0RTdDRJSVpM?=
 =?utf-8?B?SnFPSDloOXMydmhLaGZVeDFXb3htTkdkNFNpaUEvV1hqMTBiS1hRSWIrWU16?=
 =?utf-8?B?b0tjNFdxUGllaWpvdEFzZFNTNW02dW9MeThNYzZVNnhBRU9LeGEwb2lueHRC?=
 =?utf-8?B?Wmx2VHJYaStCY2d0MkY2eGd4TWIrV2Q2Y3pRZjdOakFZRFZORE10K3F5cVY4?=
 =?utf-8?B?QXRDSWFpZ21Tcm5YNFBPdldhVEorYzVjdTA3R2hUd1BFWDE5cUJ3RGlZdDFI?=
 =?utf-8?B?YUczb0pzUjB5L29hZXNpNXZIOGVUUkUrcVNPZmdZVU1PZFlrVkdPY1dURmJu?=
 =?utf-8?B?UkxpbnptRm1OUElwVDNncjMwc0wycGNTUUllSDBCd1AzekJscWU2Q2E0UlF6?=
 =?utf-8?B?SzJ3Y0V0dHl2SHUzcktRWnI1aG1CbjdoeUpZRU5iQ0JWS2NaWTc4VUFyYlZZ?=
 =?utf-8?B?VUNtczYwZlRnbHBLdGNFSFlTbEc3dERyYmpISFRtQjJTbHRlQXpiV2JKdmZS?=
 =?utf-8?B?ZGh1MnZaL1piQXBUNUxneTlua09ZRXFTMnBGNU1QeDVwVGtzckhyaFAzMWpB?=
 =?utf-8?B?N3BQY2xWanc5RUxhYU5JOFRUVUM3R09JL1g1TjdZWHluY0FUQ0RNaDRMZUI4?=
 =?utf-8?B?TC9McWRxcjh5OVZtcGpjWHpTb2VtMEthQ3BHMmIxSmU2ckQ1YUNib2NDRHRU?=
 =?utf-8?B?WHIzQUZyV1ZBcVFNakJwZElQT2tHTm5ydmFDTjhzTVZEV3B5ZUtXS3M3L2VI?=
 =?utf-8?B?dVNTVHRMSEV5UXlqNHlBSFNKU1RzcjdpRmo1bWxqbGZLZ095Wk9CTVlrRnlv?=
 =?utf-8?B?UEVZNUpkeEZuNnIzUGlEbTdYeXp3a05TR2ZqVmtPTTUxcWViR0lML09iemNF?=
 =?utf-8?B?eEFDRXpsQWxwdUZtZ2Q5OVYvbFNwRmh0YzEwaUZmWjR3VHZMbWc5WEUrR05C?=
 =?utf-8?B?YXhFNUZndSt2Y3Q3Skw0MEJ6OHN4WDAzVnRBVXNlRVpyWjFJWkxabTE5TEFT?=
 =?utf-8?B?YzhBZmJGNEFRd1FaT1VlNUMwenBkYTBPTzRxdGE0L08rSnVJOS9pRDJCMWRi?=
 =?utf-8?B?YlQ2UWl1ckgwMUg1dlJjUEo5WjBJU3VDV1NYQ2ttcXhJQWlHU3A3aFdDZytD?=
 =?utf-8?B?emFKS3NZWW1oYklYRUlOenhMQXNTN0h3ZFBXMWNxYlp6SExUT2JJdnJtdGFt?=
 =?utf-8?B?dnNPWmtPUFFXUURFdDRxWmFxcko0VFFUYTE5SGdiUEZzZFVMVW9LYUFiV3dG?=
 =?utf-8?B?Y0JQdThiV3FJVk5pRmNnbkRiZmo3MllzZHgwejJ1SjZiZ01uQXYySlNpNWFC?=
 =?utf-8?B?YXVhQXA5cjNpUzUxcVJGeXJsRkJEeTVZNVVPSGFYYmMvQ3MrQkt6a3ZSVDFw?=
 =?utf-8?B?SjAySUo5Nk81VjBHU0I4RUlaZ0M0VTlZY0hPUjNQVm12TWNybEtrcTBEdHRG?=
 =?utf-8?B?TEE0dU9IRDFVaFd1TG1OMk9rTEppWGVpc3hycmphY2IxKzRTZnc1bVlQQ1Jy?=
 =?utf-8?B?cG11czRjMnJlMWF6Y0c4eDFIRWNpSnJnRDMxZVRQWWgyU3ZWN1NaampCZlpY?=
 =?utf-8?B?UVpQb3FzZVF3YjN5Q1QyNmIraDlybGR2SVMzaG9JbzNuOFhJLy92dUpnajBz?=
 =?utf-8?B?MjJoZXpZcEp6cTRGQy90OG9rNUtnV2ZaRFZCSm9JWTA0NkE9PQ==?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(36860700004)(1800799015)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 12:05:56.0432 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4cd2ed1-1d2b-4598-1c99-08dc86210560
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6897
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

Previously, this check was performed in the gfx_v9_4_3_sw_init function,
and the amdgpu_gfx_sysfs_compute_init function was only called if the
GPU was not a VF in SR-IOV mode. This is because the sysfs entries
created by amdgpu_gfx_sysfs_compute_init are specific to compute
partitions, which are only applicable on GFX9 and not on a VF in SR-IOV
mode.

By moving the check into amdgpu_gfx_sysfs_compute_init, we make this
function responsible for deciding whether or not to create the compute
partition sysfs entries.

This change improves the code organization and maintainability. If in
the future the  conditions for creating the compute partition sysfs
entries change, we  would only need to update the
amdgpu_gfx_sysfs_compute_init function.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 24 +++++++++++++++---------
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h |  4 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c | 11 +++++------
 3 files changed, 22 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 19b1817b55d7..72477a5aedca 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -1376,21 +1376,27 @@ static DEVICE_ATTR(current_compute_partition, 0644,
 static DEVICE_ATTR(available_compute_partition, 0444,
 		   amdgpu_gfx_get_available_compute_partition, NULL);
 
-int amdgpu_gfx_sysfs_init(struct amdgpu_device *adev)
+int amdgpu_gfx_sysfs_compute_init(struct amdgpu_device *adev)
 {
 	int r;
 
-	r = device_create_file(adev->dev, &dev_attr_current_compute_partition);
-	if (r)
-		return r;
+	if (!amdgpu_sriov_vf(adev)) {
+		r = device_create_file(adev->dev, &dev_attr_current_compute_partition);
+		if (r)
+			return r;
 
-	r = device_create_file(adev->dev, &dev_attr_available_compute_partition);
+		r = device_create_file(adev->dev, &dev_attr_available_compute_partition);
+		if (r)
+			return r;
+	}
 
-	return r;
+	return 0;
 }
 
-void amdgpu_gfx_sysfs_fini(struct amdgpu_device *adev)
+void amdgpu_gfx_sysfs_compute_fini(struct amdgpu_device *adev)
 {
-	device_remove_file(adev->dev, &dev_attr_current_compute_partition);
-	device_remove_file(adev->dev, &dev_attr_available_compute_partition);
+	if (!amdgpu_sriov_vf(adev)) {
+		device_remove_file(adev->dev, &dev_attr_current_compute_partition);
+		device_remove_file(adev->dev, &dev_attr_available_compute_partition);
+	}
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index 6b0416777c5b..b65c459b3aa9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -533,8 +533,8 @@ int amdgpu_gfx_poison_consumption_handler(struct amdgpu_device *adev,
 						struct amdgpu_iv_entry *entry);
 
 bool amdgpu_gfx_is_master_xcc(struct amdgpu_device *adev, int xcc_id);
-int amdgpu_gfx_sysfs_init(struct amdgpu_device *adev);
-void amdgpu_gfx_sysfs_fini(struct amdgpu_device *adev);
+int amdgpu_gfx_sysfs_compute_init(struct amdgpu_device *adev);
+void amdgpu_gfx_sysfs_compute_fini(struct amdgpu_device *adev);
 void amdgpu_gfx_ras_error_func(struct amdgpu_device *adev,
 		void *ras_error_status,
 		void (*func)(struct amdgpu_device *adev, void *ras_error_status,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
index aecc2bcea145..07ce614ef282 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c
@@ -939,11 +939,11 @@ static int gfx_v9_4_3_sw_init(void *handle)
 	if (r)
 		return r;
 
+	r = amdgpu_gfx_sysfs_compute_init(adev);
+	if (r)
+		return r;
 
-	if (!amdgpu_sriov_vf(adev))
-		r = amdgpu_gfx_sysfs_init(adev);
-
-	return r;
+	return 0;
 }
 
 static int gfx_v9_4_3_sw_fini(void *handle)
@@ -964,8 +964,7 @@ static int gfx_v9_4_3_sw_fini(void *handle)
 	gfx_v9_4_3_mec_fini(adev);
 	amdgpu_bo_unref(&adev->gfx.rlc.clear_state_obj);
 	gfx_v9_4_3_free_microcode(adev);
-	if (!amdgpu_sriov_vf(adev))
-		amdgpu_gfx_sysfs_fini(adev);
+	amdgpu_gfx_sysfs_compute_fini(adev);
 
 	return 0;
 }
-- 
2.34.1

