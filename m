Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5FF9EB2700
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Feb 2026 21:48:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 33D4D10E5FA;
	Tue, 10 Feb 2026 21:48:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0QsxMpgG";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013003.outbound.protection.outlook.com
 [40.93.196.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 58E1210E11F
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Feb 2026 21:48:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KaDcPEWSewye7e2C5UrV03hc8iwZsZgeyAhU/hVqHiJUUvMx39hEBxUkaueYBNr3ZgVJzMYRzx0zDemS0lZctPfGbPo8I9/gS7BJObAcF9NAoTBKOD8ZsHBPUcJoGwti7XmOHZ8iMIbIa/118liF5wlyn6TyAQ65LAi1Y/SrddaFk6lRIbdon6nkGhIgRHg0TwNXb4ACJrbveKjysIY3cB2Hg5GZPvHBCGZTIYqrlXIf/eaMmPStkgcbhUSLuelA/stG79TLNwyekkC+h4smLfvvaQU3eJij3uvMlrN86LoZFklPB/GY2doM69nZKLsx0ilIRtmyhQVO+MzHptKppQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gX4xk8ePQuLkzmtNseF/aE2Rn/aPz33yy3WLK9ClwzU=;
 b=LG0SCLKSXmMqfQhq743/ynvVhqs1wPWqqcIaui1cITRwPIorcIuOgNLzxuYSpfGHNaAuJylKZDA0ZG6L+n4OipuGdQsD7nLSjK0LaEKW3DsEDL7JXioSbbTBt5UIMtkUIGpxMaiahWLsWCEhJ/LelCsgEu4KgkKctotw8WQOqUsqP06S5128n+rRVhMZvGV9cZLklyid9g/sttAkiECFelERwXsN0gwZogd4T5VUls1EfoHUhNvaAKSkOSIncKk25PfmDC7N6mG9p00paDexOim5H2aHCZnDuetiBijr1XBD7mxiaX11E9vo8epOIrVQsesCONBeONAfxgZVup1rlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gX4xk8ePQuLkzmtNseF/aE2Rn/aPz33yy3WLK9ClwzU=;
 b=0QsxMpgGXxs+fz6kunH69uYGcgJ8/naPupqktcTQaB5BdNrWgRBQJdXuFXLk5AC9zV6OwjdYd/sJyTH+UoZW4ofnf5xnaUUDhCAjKTAq3JhI0dWt9BdsWpx/Eu2QHnmgL+/CiBLQB/OnPWjXe34iVIKmTH+bEl729y7Vv2msVG4=
Received: from BYAPR02CA0026.namprd02.prod.outlook.com (2603:10b6:a02:ee::39)
 by PH7PR12MB8016.namprd12.prod.outlook.com (2603:10b6:510:26b::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.20; Tue, 10 Feb
 2026 21:48:05 +0000
Received: from SJ5PEPF000001CE.namprd05.prod.outlook.com
 (2603:10b6:a02:ee:cafe::b2) by BYAPR02CA0026.outlook.office365.com
 (2603:10b6:a02:ee::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.8 via Frontend Transport; Tue,
 10 Feb 2026 21:48:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001CE.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Tue, 10 Feb 2026 21:48:05 +0000
Received: from david-B650-PG-Lightning.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 10 Feb 2026 15:47:58 -0600
From: "David (Ming Qiang) Wu" <David.Wu3@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Christian.Koenig@amd.com>,
 <alexander.deucher@amd.com>
CC: <leo.liu@amd.com>, <Boyuan.Zhang@amd.com>, <David.Wu3@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH 05/14] drm/amdgpu: use amdgpu_user_queue instead of
 amdgpu_umsch_mm
Date: Tue, 10 Feb 2026 16:47:20 -0500
Message-ID: <20260210214729.80964-6-David.Wu3@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260210214729.80964-1-David.Wu3@amd.com>
References: <20260210214729.80964-1-David.Wu3@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CE:EE_|PH7PR12MB8016:EE_
X-MS-Office365-Filtering-Correlation-Id: 08247aa1-38dd-4fb5-50d5-08de68ee1281
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K2MyMU12ZmFoZXVSKzdvaEhQdkRhMzhnSkxoclN4SU9odGFCckVoSG5GWUIr?=
 =?utf-8?B?U25ERzFqcmtuZUM5RDJsWGJjdUFrWnBIWnByc3NVeHN0ZVNzQUdQOVlsOUJz?=
 =?utf-8?B?ZlVqR01KeXJUM0ZTRUt1MytaRDJGQlA5L3poMU93d2xvWDRCN1BiVkVNTWov?=
 =?utf-8?B?NGw3cDB4VUJqQnFkR3YyZy9FcWxjamhod2lMcWNCWkQwMS93MHlLMkMray8r?=
 =?utf-8?B?Z0xBanM3WVBTM2dNSDJCU0JGWUpGbWpDOFNLSC9TVkc2cnVCZnRDc2RFQ0RZ?=
 =?utf-8?B?Y085a3RuL3ZBeFRvVlB6OTBDUnprREZVWU1uZklpb2VVNGVxTzFPVjMreXlz?=
 =?utf-8?B?bk41d0o5aEFVUVZoazk2WlJIQWdNOXFrL3BYTGEvN1BmRFZzekRteWhHSHlw?=
 =?utf-8?B?bG1Wb2o3TmlBdC80Zk5FQlJyaFpSVzdHdW00dHV4SzFWVFo3cVBiRlNoQkUw?=
 =?utf-8?B?Z09qMjRldmNXR3QwbXBxY1JoaXZoU2NOU1JaZFhxRWZHbFdvL3BaWnR4cDk3?=
 =?utf-8?B?dXlhb1lnYWJCWHRsQVdFK0FnOFdzUXRWL3AvanVtRXdLcjlRVlU4N1hNOWFG?=
 =?utf-8?B?REpoclBSdXRnTlc3Vzk5bGNhYWNlQXllTjgycmkvZ2pzeXhUU2trWUhqYnUv?=
 =?utf-8?B?eXlqTW5RcitCN0ZGb3BwclZDT0NUaGxIa2JIcm9RdVUzbXJRSkZ2Vk5kcHRv?=
 =?utf-8?B?SFhnWUo4blpwSzhtaFU5N1hLeE4wNGFRWXJ5ZFd2dlhPUDRGZHFCbyt2K05h?=
 =?utf-8?B?anJ2Z2RvY0xPZFhuNldRZFR5NWpuMEdZeGxlQUpYQTZRcDB1K0FCcFhoalRn?=
 =?utf-8?B?K1JRbTdPNGprQmp6VG8xZThhQlAzQ0xHRXgzZk80QUZVdVhjZDMwNDVkUUZ1?=
 =?utf-8?B?NWxQclhUT2VGRERpeEpLSUhrU0NZV2NCVTVCa1FrWDV4YXBzekZNeENBYWNv?=
 =?utf-8?B?MzMvOGhnUnBQMm1jT1c2dG1ZTklTcWJCZVEwUjc1WloxSmtYS2QzZjVkZ1ND?=
 =?utf-8?B?Mkd3UVJ5WVJ0WDVKejZmZ21lTU0wMjZ6VUlGUGJvN1N6ZnQ4b21HQk9BUHFC?=
 =?utf-8?B?dG5nZFgwRm82WDdvdjBURHl0Rnc3UUYydW1YbGNwb3NrekttTlNQT2RKVFNu?=
 =?utf-8?B?c1pMUm0zQ1ByVHp3RU9rZmdoMzNTUmxWMkc5YmIvUUNNOWorb2NzRFE0RXBL?=
 =?utf-8?B?Qm5iVTZtNXJnY0VLMFN5a1l4TUo3ODZzd0JXMXk3TlYvdHc0NzlQMXNXSXFT?=
 =?utf-8?B?NlRkVFZlM2lWY2xRT3hrS25jK0k0L0gzenI0N1oybVloVSt1NzBzN0JWMTVi?=
 =?utf-8?B?Mk1oc3pTNGJGN3hGckJTNkJZVHZiRkdONldzZUNvbGxBemp1aTZHNW5ldUli?=
 =?utf-8?B?NGhCZDNvdWxJaVUzN0xGamVlRHcwM0lLamdDNGRzbnoxdFJwWEF5TzFmRmg5?=
 =?utf-8?B?aU00L3htYUFReFpHVDBkaHNOeEVDY0ZZWnIzZlFscGxlMlErUHErTzMvSWJ5?=
 =?utf-8?B?VFZsNXdxZU9mWmxIM1ZrYnlyaUdBTFQvalhVSWJBdEI5K0trYkp1aWU1QUli?=
 =?utf-8?B?UW9CNFdYWTg1cHVHek1mOTl5UVZ4N3NSMXpGZWQwRjlRWXpzR1lkUWpLbE8r?=
 =?utf-8?B?empkY0NrOGw4NXhsOU1YTklYVGVFemtBaUZyWWtneGo3VXl0b2FmRUZRYTRw?=
 =?utf-8?B?dG1JR2NuSzd4NGZZKys3dEYzVW41anRtdGVkeUc3aDZzRXQ0T1NobngvUDAr?=
 =?utf-8?B?dXJQaHNQcndEcG1ZdFZ1bnJyelkyQzVETXdtWmw0UUJCNHVKZ2k0N1k1Y3VI?=
 =?utf-8?B?eW92SlZyajNpeUZ4R1lXUnlPaTJJZFdoMVBvMU1mNmx2SjAvSGk1VzZ3MWx3?=
 =?utf-8?B?Y0dsV1Z4VFY0ZTNGWThTb005SkpGUjhLajArbWpiV21qU1U0Zi9hQUJuMXdu?=
 =?utf-8?B?UTE5SWlkN2xYOXZYTDdWOXY0TXpkU1IvQXZwSnloZWtzeDdWamVONytNSU1I?=
 =?utf-8?B?WjNEM2pDTFZDSG9MMWVpcTJ6UHpDNUlmSXRsSk1QNG5zelNaVStOc2owV2Y3?=
 =?utf-8?B?UnVndjFmeVN4YnZFZk5EOCtXK21lRUlIY0dsbVJvVEpNa1A1Z0hnUlBrYjl5?=
 =?utf-8?B?Q2JSTDF5enRCY0Z0REQxeW9ta0xkZkkyTS9HbWtqa1c4TjZNVVRWZm8xakQ5?=
 =?utf-8?B?Sms3OWszdFBqL05ucDBJSXdCM0VkNGtFbHIrK0ZxS0dxYmRPaTBoSVJ4QXNn?=
 =?utf-8?B?V2ozR0wyV25UM2lwWXhJMEQ0VnRRPT0=?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: JGeAPq0CmvRUNO/dXrgP62YJYa26VRzRQ3lj7HS6BVi94s+oKZHXSxc7wCxIqTikIyPk4iwUcA5cxPm8wSMya1+1YeENxleu1DEmK+2SRRKpFT1chxIIgtnjQUWdDzQRlF4yDkyLPxfH/mKcevNy8Kw0X4g6WBTATs9vdeP3yI9Jrvp9ET8WcmQCL/u9Y/6Zzzk+bNFZ+VtnQBT0rvBU1A0esAAPYkguQ7X76iCH3jbZMoA4Be0FUF9QFmlfnRzhcbpE7EGuAFw82RQZpwWpGHZQKn39gqly0uCmzFIcYDS0d1rmrQg1C97/fhrCTxBpEi+HhBfan7sbVGB2Mu1Iy4DhgUK9KkIV/DBTF1q1L/QxGtn+Py70gP2XhedBr/6+6g5Nc1hcQhbkWF6hjkBnn+KbGDYWzvsktMJDh8d59c5gN0QExDqT83Fa7j8Crm4F
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 21:48:05.3813 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08247aa1-38dd-4fb5-50d5-08de68ee1281
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8016
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

amdgpu_umsch_mm is retired and use common module parameter
amdgpu_user_queue for umsch user queue enablement

Signed-off-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           |  1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       | 10 ----------
 4 files changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index aeefc13fd36b..57d0e08d829a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -256,7 +256,6 @@ extern int amdgpu_num_kcq;
 #define AMDGPU_UMSCHFW_LOG_SIZE (32 * 1024)
 extern int amdgpu_vcnfw_log;
 extern int amdgpu_sg_display;
-extern int amdgpu_umsch_mm;
 extern int amdgpu_seamless;
 extern int amdgpu_umsch_mm_fwlog;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index aeb90708f229..b23e140b12d3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -2069,7 +2069,7 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
 		amdgpu_debugfs_vcn_fwlog_init(adev, i, &adev->vcn.inst[i]);
 	}
 
-	if (amdgpu_umsch_mm & amdgpu_umsch_mm_fwlog)
+	if ((amdgpu_user_queue == 1 || amdgpu_user_queue == 2) & amdgpu_umsch_mm_fwlog)
 		amdgpu_debugfs_umsch_fwlog_init(adev, &adev->umsch_mm);
 
 	amdgpu_debugfs_vcn_sched_mask_init(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 41e63c286912..98ca952a8bbb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -2647,7 +2647,7 @@ static int amdgpu_discovery_set_umsch_mm_ip_blocks(struct amdgpu_device *adev)
 	switch (amdgpu_ip_version(adev, VCN_HWIP, 0)) {
 	case IP_VERSION(4, 0, 5):
 	case IP_VERSION(4, 0, 6):
-		if (amdgpu_umsch_mm & 0x1) {
+		if (amdgpu_user_queue == 1 || amdgpu_user_queue == 2) {
 			amdgpu_device_ip_block_add(adev, &umsch_mm_v4_0_ip_block);
 			adev->enable_umsch_mm = true;
 		}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 67b8c33d5ee3..442af4fd85aa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -236,7 +236,6 @@ int amdgpu_use_xgmi_p2p = 1;
 int amdgpu_vcnfw_log;
 int amdgpu_sg_display = -1; /* auto */
 int amdgpu_user_partt_mode = AMDGPU_AUTO_COMPUTE_PARTITION_MODE;
-int amdgpu_umsch_mm;
 int amdgpu_seamless = -1; /* auto */
 uint amdgpu_debug_mask;
 int amdgpu_agp = -1; /* auto */
@@ -976,15 +975,6 @@ module_param_named(vcnfw_log, amdgpu_vcnfw_log, int, 0444);
 MODULE_PARM_DESC(sg_display, "S/G Display (-1 = auto (default), 0 = disable)");
 module_param_named(sg_display, amdgpu_sg_display, int, 0444);
 
-/**
- * DOC: umsch_mm (int)
- * Enable Multi Media User Mode Scheduler. This is a HW scheduling engine for VCN and VPE.
- * (0 = disabled (default), 1 = enabled)
- */
-MODULE_PARM_DESC(umsch_mm,
-	"Enable Multi Media User Mode Scheduler (0 = disabled (default), 1 = enabled)");
-module_param_named(umsch_mm, amdgpu_umsch_mm, int, 0444);
-
 /**
  * DOC: umsch_mm_fwlog (int)
  * Enable umschfw log output for debugging, the default is disabled.
-- 
2.43.0

