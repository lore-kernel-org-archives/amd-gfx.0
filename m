Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B89DD2594B
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Jan 2026 07:18:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27A5610E249;
	Tue, 27 Jan 2026 07:18:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4gAZcby4";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010066.outbound.protection.outlook.com [52.101.56.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE0EE10E249
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Jan 2026 07:18:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m/nv5XPRA3wJu4eHWi3hBXDpKrBV5URouT+fd7tDcOLOrYvdsLcSLk9IEfsyiRV1TdtYVJ6IZFKvuDXQkFMPak6un8NAgKJR3Tc+D7dyK9tdMkTFUA4ysuJhNAm2Tvy48ZPs6LxwAt8WWaPDp/pRc3I8F/56mmXLOd+ULXAph6J+zghJW2WKgm0yn5NqZVKF0ngsGIHscc3eyCMDtS5Z1ZtC+q5jjP0pi1IQ3cHHavHHbqtL+pN3h6sKZw627CZiq7IK+rVAYOYZ5EiKyqfQTe+wbM2vRHVAt6tEhF4slACk10LPvdwCjQLboFgtNObkBaJhOJMZR3ZIp3NaFsZzrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WOUk5WqUQoduptM+GsDjBur+yG3BUaVCtI2Zdnc5TcQ=;
 b=T90iwdo8Hfy0WaU+m88Xz/hWOW/66oiCiyOyBB+HeY3rjBPgLecTVUMFUX0Ja59J24pZORfxz10z2mmBh1x09ckZUdEoTtDcyZpoM5as45cpa+7l6ml1Qf6RcVJ3rGJmFS4Q4woX2+XKFkCf1VDDi+cA1R2H2DfidVl4GdkEOH9zGs2Id/pWWJBe6MqvVtRxR8Vw0HbViPAfl6sRzMOM6evUNnMrn+zzC56Y0kDeIYSaZhk/8DZFZ2KCXSjFq2omIkyQG/z0muTMJdJiedLYaQulz6Sr6UPX9XXvjxgfYYXphTCvviTHE19Jjv0dYackNfbNLee5hXPSTTZJvYjcsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WOUk5WqUQoduptM+GsDjBur+yG3BUaVCtI2Zdnc5TcQ=;
 b=4gAZcby4CooXIkS45ON4OcDslTv0TLzyzmsO7LazABEIpdC5QTTiK7NersnEJurkVEXReUwXqblzc+o4rSwE38yhOpLRx9UFLgkIsM75PA2eQLIKpV8PvPTJmk3HVjCXSV+cyApT10B9vNwuqGosZ48rQo8KXHPIA+55fAGsUqU=
Received: from MN0P222CA0001.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:531::6)
 by BN5PR12MB9461.namprd12.prod.outlook.com (2603:10b6:408:2a8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Tue, 27 Jan
 2026 07:18:50 +0000
Received: from BN3PEPF0000B374.namprd21.prod.outlook.com
 (2603:10b6:208:531:cafe::d9) by MN0P222CA0001.outlook.office365.com
 (2603:10b6:208:531::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.16 via Frontend Transport; Tue,
 27 Jan 2026 07:18:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN3PEPF0000B374.mail.protection.outlook.com (10.167.243.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.0 via Frontend Transport; Tue, 27 Jan 2026 07:18:49 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Tue, 27 Jan
 2026 01:18:49 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 27 Jan
 2026 01:18:48 -0600
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Mon, 26 Jan 2026 23:18:37 -0800
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.Zhang <Jesse.Zhang@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH v3 4/6] drm/amdgpu/gfx12: add CU mask support for compute MQD
 initialization
Date: Tue, 27 Jan 2026 15:17:26 +0800
Message-ID: <20260127071800.2395621-4-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260127071800.2395621-1-Jesse.Zhang@amd.com>
References: <20260127071800.2395621-1-Jesse.Zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Jesse.Zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B374:EE_|BN5PR12MB9461:EE_
X-MS-Office365-Filtering-Correlation-Id: 55bdb0cd-d67c-4c7b-a7d1-08de5d745156
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jz1vv9JKHD8wHEAbSHJ8i2X4SKZGifhF3Ok0CPxZ5kNCce7e2RaYdKezPL2a?=
 =?us-ascii?Q?T6NEVvEohsbRRzNadOqY5ZZSNHgn+YLTRZPX9QY/7I2BdivpF3DVRp7xTAxA?=
 =?us-ascii?Q?rWPkawyUARXOgqf6f7sBBveiPdlfrycRcG9YcQNV+FDke5KSYaB4ax6NB09i?=
 =?us-ascii?Q?GmY+dIsJck30VQQYbRVhBRnbpoWqEDFZWAyIC1wqX4sRGWICIU2Q1Vaq4IsX?=
 =?us-ascii?Q?oRwhQcmM8j1FXhy85PLBeCXCBmto/QbxP/0TG+cwgs1KG9hJtTgLYzJXuAJA?=
 =?us-ascii?Q?ZWBqvxR6w73qm/1kkYogzTylfh+7A4D7mIteF1b30/fFIHNtgiW75NHU1QQq?=
 =?us-ascii?Q?FNIoSkSz/6QO0KuKY1htAxzWL9/atie88moB4/e/ne0Zih6YVx0dTKp7ds31?=
 =?us-ascii?Q?mFjVO5LY49vCgyc/rCFUlwnCTcUPNRuZw2kkHAQzAJqrXMeyud2UPEZZUfx1?=
 =?us-ascii?Q?u0WRNRJz3FzJnjE0dJdexAgfAU0KhCTvygos7JIaP5Qk/eDnhpPjCj3snaB9?=
 =?us-ascii?Q?ZLe92yYB4w9eeMLpJkONMR1bM3ARUdqF+ljK5fvB1DkNiSKRt/gz4zahYQ4J?=
 =?us-ascii?Q?a1yyWlfdZLFobUSFRdCny7LW0lMfUOCaCTpchO8C6ksXl9ryfWQf/ctZi1tM?=
 =?us-ascii?Q?GBISOJP4zvmnXFkkPzwV55PFa/rQmFpdHzGXbX0QpmaSdMZXi/Bp1IzsX0VG?=
 =?us-ascii?Q?B/NrplZ6eROXTdH5Cc4rSSBhBkgDP7O6HhvMSFqvZmASNPShEQMDwK1onoxS?=
 =?us-ascii?Q?XivzlUFiJQOt6mUHc4Yw4oWtEuNURCv13Q1cjPTwClBQkcFhXxuD0FKlNxxV?=
 =?us-ascii?Q?jZOIY89BJw8xPRIe2br5GqxGyXRbJeAgQ6FTzwAko4lQo4cmV3pVcuAwj6Tt?=
 =?us-ascii?Q?TEY4Y+xuWNdnKU41eLCMuYp/XRzpS94KbMNIxE7ruZ+ohT0Q6EQteQDf7gVC?=
 =?us-ascii?Q?W1maJHzyBaeYFNDAAkSNuPrdeT11RpDo+j1qRSPOyfcGyLAma9f05IKeY2mi?=
 =?us-ascii?Q?d+8daf9rjGskuBQ9L21Ktw7OwNidkXmvoiZpcGCwWfhAK9hyLRU0WQPLsvEx?=
 =?us-ascii?Q?yNFtQPDLSln8ainkOEmLF8xPt6ajWnjat4AUhFJzjnH16IfOdySuMVVwSJec?=
 =?us-ascii?Q?/Am4ULpfONHoklRwVKsJunmhwtI4iRke/dHH8RTNzf606A0lbAVny5Pgi+b0?=
 =?us-ascii?Q?tkk96wH55Y0DlA23YTFXa6I6S4sik7I2PMxPGqU4ZD9Up63sj9iZq30XaiSJ?=
 =?us-ascii?Q?kKANqiGzJ0MIhfbOPOiRCeusnOL71Ju5Gc2VWrQK7EZm9zgV63jTygqPLZY1?=
 =?us-ascii?Q?jxrCVdok5CvI9r1Ejsyuu9WCC+OfuAmr2a8kQ2+622R8MHXy6ycg40VfiL6j?=
 =?us-ascii?Q?91y5pp6Vv1SFePveh61EEruW0PzLQnQVDFwX2xhkAAQrBVgP1diHJjuWD3EO?=
 =?us-ascii?Q?+lUw4w2iACRJs8PA6NaWVa197EPCFvuRWcXGqWVlYLGV+BQvFyKLk9aGIgiE?=
 =?us-ascii?Q?mjJrUAhOEXw+Tzw8xcuqZBTTuzzaI4bJ4LkS2/zDryWmN78TE5MYo/YNfh+I?=
 =?us-ascii?Q?THAZNwupDAWSiVccme2zO7TIWAavhTdD84zokbPNIwSiz9HQ1FS7p6b4IuvB?=
 =?us-ascii?Q?MoBOnfoCk7PCgrHy+Q46yaml1LYnEa2sHH2CuLecXUhbg6YLfvhkIpZbmA/b?=
 =?us-ascii?Q?d02DhA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 07:18:49.4989 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55bdb0cd-d67c-4c7b-a7d1-08de5d745156
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B374.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9461
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

Extend the GFX12 compute MQD initialization to support
Compute Unit (CU) masking for fine-grained resource allocation.
This allows compute queues to be limited to specific CUs for
performance isolation and debugging purposes.

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 33 ++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 6cd16f016c37..73478dd0f6ad 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -3110,6 +3110,37 @@ static int gfx_v12_0_cp_async_gfx_ring_resume(struct amdgpu_device *adev)
 	return gfx_v12_0_cp_gfx_start(adev);
 }
 
+static void gfx_v12_0_compute_mqd_set_cu_mask(struct amdgpu_device *adev,
+					      struct v12_compute_mqd *mqd,
+					      struct amdgpu_mqd_prop *prop)
+{
+	uint32_t se_mask[8] = {0};
+	uint32_t wa_mask;
+	bool has_wa_flag = prop->cu_flags & (AMDGPU_UPDATE_FLAG_DBG_WA_ENABLE |
+					  AMDGPU_UPDATE_FLAG_DBG_WA_DISABLE);
+
+	if (!has_wa_flag && (!prop->cu_mask || !prop->cu_mask_count))
+		return;
+
+	if (has_wa_flag) {
+		wa_mask = (prop->cu_flags & AMDGPU_UPDATE_FLAG_DBG_WA_ENABLE) ?
+			  0xffff : 0xffffffff;
+		mqd->compute_static_thread_mgmt_se0 = wa_mask;
+		mqd->compute_static_thread_mgmt_se1 = wa_mask;
+		mqd->compute_static_thread_mgmt_se2 = wa_mask;
+		mqd->compute_static_thread_mgmt_se3 = wa_mask;
+		return;
+	}
+
+	amdgpu_gfx_mqd_symmetrically_map_cu_mask(adev, prop->cu_mask,
+						prop->cu_mask_count, se_mask);
+
+	mqd->compute_static_thread_mgmt_se0 = se_mask[0];
+	mqd->compute_static_thread_mgmt_se1 = se_mask[1];
+	mqd->compute_static_thread_mgmt_se2 = se_mask[2];
+	mqd->compute_static_thread_mgmt_se3 = se_mask[3];
+}
+
 static int gfx_v12_0_compute_mqd_init(struct amdgpu_device *adev, void *m,
 				      struct amdgpu_mqd_prop *prop)
 {
@@ -3243,6 +3274,8 @@ static int gfx_v12_0_compute_mqd_init(struct amdgpu_device *adev, void *m,
 	/* set UQ fenceaddress */
 	mqd->fence_address_lo = lower_32_bits(prop->fence_address);
 	mqd->fence_address_hi = upper_32_bits(prop->fence_address);
+	/* set CU mask */
+	gfx_v12_0_compute_mqd_set_cu_mask(adev, mqd, prop);
 
 	return 0;
 }
-- 
2.49.0

