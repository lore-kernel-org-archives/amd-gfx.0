Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB058D3748A
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Oct 2024 13:21:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A08210E820;
	Thu, 17 Oct 2024 13:21:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qi+wZt9X";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2048.outbound.protection.outlook.com [40.107.236.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 486A410E81F
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Oct 2024 13:21:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RuCDSRAQNUqS9bZDuryuiut05kvteIJSbkZVrCrdkPSH4nNzS4+7iNlkyq8ygwnZjRdTGDulTBRdeQVqdHBuAT6AkDPfSUEC4Di9gk/wiieMQCqvxbSx/ZBnfSqLSRJypzXZkhPsUBjB8fdyAzh30Hsy2rV5sHcxF9fZYNRjWaPQvR/AGdUlQJypiAP+GUR0qeX5jswPg8A58n6HbLg9aIBzzzllKnkJHtIgH2PE8hEilCb01WYLIWoW9ULZdVvVqP4vxUxseSIqaE6At0BmAb1y0EI125M5mMBe56asBLmH5SLWRiUGnfme8DivOq5EbvZBWJ7DtjaNrWWogehAig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MKxMIqXHuqlu/CsSGUyD75UnE0d+/8wK9qJ2DKAsLcI=;
 b=DzVnSV8pCdg0Sys/3/wGa1Nm2HCJXVshIDLN3+26Aju9uIZfqSsvlfvDZMBqsF72r/gPphDTeKpNvo0Azoc5e70dL0NTFtbvjHJaCeRGsd5CaDZPEWdg0SoCdRtv+b0So2U44y2xBJYWu/S4VUtSyyu0MgPOMu9tW46Cm7dQo0DpdHjmw0EqprJRRMux4iIu7D5ofvA1TswioWzW/un4pB/xp37EIzSb2KJFGeH54HvQbBXGWzXPsSAS6MZDlF1SU2p5k2o+t/G+XsjvEfLOc1O6bxnSn0Bodjj7VTNm76pRNfbEIeihAbmWkcbfb9qFrTccsV0Da9So3nkwJ2vqWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MKxMIqXHuqlu/CsSGUyD75UnE0d+/8wK9qJ2DKAsLcI=;
 b=qi+wZt9XCbrhaEUnXdMt52/c2ST3/EfZTeBt337bvN6eN1xX4i9c3hNsUAuplDriMigZdMY6w6RuZBocy3GDAbsAEe5JqMJNHufCyYOU9/BD1fHGeWUOM6IwoVbgxyX/UtAH47uVqyVc0Ye1w48/+PBrtWxDQYctJU/1O9hrwYY=
Received: from BN9PR03CA0175.namprd03.prod.outlook.com (2603:10b6:408:f4::30)
 by CH3PR12MB8535.namprd12.prod.outlook.com (2603:10b6:610:160::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Thu, 17 Oct
 2024 13:21:17 +0000
Received: from BN2PEPF000044A7.namprd04.prod.outlook.com
 (2603:10b6:408:f4:cafe::38) by BN9PR03CA0175.outlook.office365.com
 (2603:10b6:408:f4::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18 via Frontend
 Transport; Thu, 17 Oct 2024 13:21:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A7.mail.protection.outlook.com (10.167.243.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Thu, 17 Oct 2024 13:21:17 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Oct
 2024 08:21:16 -0500
From: <boyuan.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <leo.liu@amd.com>,
 <christian.koenig@amd.com>, <alexander.deucher@amd.com>
CC: Boyuan Zhang <boyuan.zhang@amd.com>
Subject: [PATCH 01/32] drm/amd/pm: add inst to dpm_set_vcn_enable
Date: Thu, 17 Oct 2024 09:20:22 -0400
Message-ID: <20241017132053.53214-2-boyuan.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241017132053.53214-1-boyuan.zhang@amd.com>
References: <20241017132053.53214-1-boyuan.zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A7:EE_|CH3PR12MB8535:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bdc86fa-df62-44f3-cc69-08dceeae952e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QnVOdVVyV0k2Q2x3SGVuajloYXN6aVB0akFRT1FMcVlWVEVnbU1TZk4yZndx?=
 =?utf-8?B?UzF2R0UzbTZ3MjhVM0IrSEJOaXR4bzBTbklWQmhnMzFrK2pFelQrYmhzM3NP?=
 =?utf-8?B?Mk1ReFpWclFDMEo4V1FHWWtKWnNNOWk0YUlpdGpORUF6KzhscG95SGdsRHNQ?=
 =?utf-8?B?Y0JtdGJDdVJCcG1QcTR5bmF3WldjR3F5enV3SFJ6TXF5b09xTjJLK0ZEd0ZS?=
 =?utf-8?B?NkpvSGJPUkc2c2xqSkV0bjUwR1VYWTI3bTdONHE3MU80SmdkMkNGcXp4a1dz?=
 =?utf-8?B?T05nWkkyby9lRHpEUnpqa2JxMHFJU25IVWFCbXpqRGpOQkI3UUlYSnNHS3Zi?=
 =?utf-8?B?SGNiZFYvNUtuQ3owSVJCTnRkeTEzd3NwWm5NTHRKZjZMQlhBc09Galp3MHRV?=
 =?utf-8?B?bGlZSUhDb09OemVISVZqalNMc0kvWTJrQlpNZUdpVzZIY2kzQzVMcGpiaTlD?=
 =?utf-8?B?dTdIdGtLQ0wvUE42WDRwOVJjcXZJUHNSU21VelRSWEZTUG8wS2grdGxPamJ2?=
 =?utf-8?B?VmxIc0NDeE5UNUdaRDZ6aUc2NEJia1RCL2Y1QjhXRzNLVUIwWDFaK0laZjNj?=
 =?utf-8?B?R3NsK2k5TTdlVmxtNzZIZExMQ3J1RTducy95MkdaN3VyU0RwcUtuUUI2NWpR?=
 =?utf-8?B?NWlnMGZuM3d5NUQwaGwzWCtOdTV5cWVMa3k2ekdiZkoxRDZvenRpeTBJaFYz?=
 =?utf-8?B?bVkwNHd1SUxNZU8vdklvR3BPcTViOS8vbFIyUldzMVIrWXhRZVJPbnlNS1Nj?=
 =?utf-8?B?SnFSUFVKRno5TkxYSEgyLzYyc3pGQm9lbGlpbzZiQ0gwUUhXdThOcDlUY2hN?=
 =?utf-8?B?aEVSZDQrMStNc2VQRlRRTDNWVXl1TStPUlQ5dFNxL2U2N0lNbmxTcmt3REVX?=
 =?utf-8?B?Z2FHNGJkcHNJMW5PNE1pNi9HUFhnS1dIbVpTRUZiNk5Jd0NYYUlsQ3FpNEpQ?=
 =?utf-8?B?bkNyRjZwUEQwSVhuTm55TmEwZCsvMWdFRy95VE5ITnRFRWgySlBPT3FoekNY?=
 =?utf-8?B?aHFuM1R1SS9kMkNra1VZbko2RHlWZ1BxYXc4VHdla2t2OFhCMi9LU0pnN3Js?=
 =?utf-8?B?azR1MVpNUHUyTXpGQnNZYnFDalV6dEhpZ29LWDhUYWZXdGxDNkVSK2RvRTVD?=
 =?utf-8?B?azRPbkV3Mllqa05jYWFYUkNRa1pHVDA4bVZIb1FPWDZUdHhoNy9JK1RhNjMv?=
 =?utf-8?B?MGlsSGdoSS82bElLek1XTisyVTJqOFU4Z2YyWUc0V2FMZ2Y0UlJNT0paQUFG?=
 =?utf-8?B?YjYzZUMxMlVGcThldWtZYUJNRXlYeUJsbFFIZ2haZkFwbzBveG1qYTA5TUFX?=
 =?utf-8?B?Z1NKazdsY3pSK1JEQ0NOdTFrVXJZSGpsbU9ONnhLL1FsbS9kSlgraUpId25D?=
 =?utf-8?B?VUROREs0aTNRY21JOW9uc0IyTGdkd1Arc216aEJMY1ZGR29uSXQ1eEM5a1lr?=
 =?utf-8?B?RHI0VDN4SnlzUjFzTWpYdHcrY1MxbmJnNDQyQXJuVkowRXIwZGIvVGhoUi9m?=
 =?utf-8?B?UlVROGROa2dteHZVb1RQQ29uS0o0Und0Vzg4SnJWRWYxTGUrbkk5VW5PYlgx?=
 =?utf-8?B?WWZyNGIrZHEyWHIrdW1pQi94K0QzYm5NMk1qUHVyZk1tdWZkWWIrZXF4WmFz?=
 =?utf-8?B?WWNmQkRFbWdUb3BQa3JmeW9qRWVlYU9JMXN6UndERWIzck9uSHpmRHRaRzQx?=
 =?utf-8?B?ZGd4MFJnQXcyZmNiQkdwQ0R3L3NnV0ZEaklxeDIrTy8vVHlPcXExS3RTY3hK?=
 =?utf-8?B?U2tmRDRDTjJoMmxaTm5QVFA3RDZSRTdUY1JxOGI2RW5idjdrT053RExDdzZK?=
 =?utf-8?B?RVR1VEFpTmdDSXNxOFMzdUFPNEVySS9Ia3BPTi93SVhSTWhXR3ZBdCtnVVJy?=
 =?utf-8?B?TXhvL29TN1Z2L1psZnh1YUxuTkg4V1JGdGpQaFE5a0xnR0E9PQ==?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 13:21:17.3266 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bdc86fa-df62-44f3-cc69-08dceeae952e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8535
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

Add an instance parameter to the existing function dpm_set_vcn_enable()
for future implementation. Re-write all pptable functions accordingly.

v2: Remove duplicated dpm_set_vcn_enable() functions in v1. Instead,
adding instance parameter to existing functions.

Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
Suggested-by: Christian König <christian.koenig@amd.com>
Suggested-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c               | 2 +-
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h           | 2 +-
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h            | 3 ++-
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h            | 3 ++-
 drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c       | 4 +++-
 drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c         | 4 +++-
 drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c | 4 +++-
 drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c        | 4 +++-
 drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c         | 4 +++-
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c          | 3 ++-
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c    | 4 +++-
 drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c    | 4 +++-
 drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c          | 3 ++-
 13 files changed, 31 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 5b0cdda96b38..6305fd7d2573 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -251,7 +251,7 @@ static int smu_dpm_set_vcn_enable(struct smu_context *smu,
 	if (atomic_read(&power_gate->vcn_gated) ^ enable)
 		return 0;
 
-	ret = smu->ppt_funcs->dpm_set_vcn_enable(smu, enable);
+	ret = smu->ppt_funcs->dpm_set_vcn_enable(smu, enable, 0xff);
 	if (!ret)
 		atomic_set(&power_gate->vcn_gated, !enable);
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index 727da0c37e06..0f074b6c8b58 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -739,7 +739,7 @@ struct pptable_funcs {
 	 * @dpm_set_vcn_enable: Enable/disable VCN engine dynamic power
 	 *                      management.
 	 */
-	int (*dpm_set_vcn_enable)(struct smu_context *smu, bool enable);
+	int (*dpm_set_vcn_enable)(struct smu_context *smu, bool enable, int inst);
 
 	/**
 	 * @dpm_set_jpeg_enable: Enable/disable JPEG engine dynamic power
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
index e58220a7ee2f..229b9d16452f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
@@ -255,7 +255,8 @@ int smu_v13_0_wait_for_event(struct smu_context *smu, enum smu_event_type event,
 			     uint64_t event_arg);
 
 int smu_v13_0_set_vcn_enable(struct smu_context *smu,
-			     bool enable);
+			      bool enable,
+			      int inst);
 
 int smu_v13_0_set_jpeg_enable(struct smu_context *smu,
 			      bool enable);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h
index 46b456590a08..c7071159f8ec 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h
@@ -210,7 +210,8 @@ int smu_v14_0_wait_for_event(struct smu_context *smu, enum smu_event_type event,
 			     uint64_t event_arg);
 
 int smu_v14_0_set_vcn_enable(struct smu_context *smu,
-			     bool enable);
+			      bool enable,
+			      int inst);
 
 int smu_v14_0_set_jpeg_enable(struct smu_context *smu,
 			      bool enable);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index 5ad09323a29d..6c8e80f6b592 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -1571,7 +1571,9 @@ static bool arcturus_is_dpm_running(struct smu_context *smu)
 	return !!(feature_enabled & SMC_DPM_FEATURE);
 }
 
-static int arcturus_dpm_set_vcn_enable(struct smu_context *smu, bool enable)
+static int arcturus_dpm_set_vcn_enable(struct smu_context *smu,
+					bool enable,
+					int inst)
 {
 	int ret = 0;
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 16af1a329621..29a3b96ffaec 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -1135,7 +1135,9 @@ static int navi10_set_default_dpm_table(struct smu_context *smu)
 	return 0;
 }
 
-static int navi10_dpm_set_vcn_enable(struct smu_context *smu, bool enable)
+static int navi10_dpm_set_vcn_enable(struct smu_context *smu,
+				      bool enable,
+				      int inst)
 {
 	int ret = 0;
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 3b29cb74c47b..2438f813d6db 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -1152,7 +1152,9 @@ static int sienna_cichlid_set_default_dpm_table(struct smu_context *smu)
 	return 0;
 }
 
-static int sienna_cichlid_dpm_set_vcn_enable(struct smu_context *smu, bool enable)
+static int sienna_cichlid_dpm_set_vcn_enable(struct smu_context *smu,
+					      bool enable,
+					      int inst)
 {
 	struct amdgpu_device *adev = smu->adev;
 	int i, ret = 0;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
index 22737b11b1bf..656505d2404b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c
@@ -459,7 +459,9 @@ static int vangogh_init_smc_tables(struct smu_context *smu)
 	return smu_v11_0_init_smc_tables(smu);
 }
 
-static int vangogh_dpm_set_vcn_enable(struct smu_context *smu, bool enable)
+static int vangogh_dpm_set_vcn_enable(struct smu_context *smu,
+				       bool enable,
+				       int inst)
 {
 	int ret = 0;
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
index cc0504b063fa..8d9fb80f36f7 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c
@@ -645,7 +645,9 @@ static enum amd_pm_state_type renoir_get_current_power_state(struct smu_context
 	return pm_type;
 }
 
-static int renoir_dpm_set_vcn_enable(struct smu_context *smu, bool enable)
+static int renoir_dpm_set_vcn_enable(struct smu_context *smu,
+				      bool enable,
+				      int inst)
 {
 	int ret = 0;
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index e17466cc1952..1d37b9e251d4 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -2088,7 +2088,8 @@ int smu_v13_0_get_current_pcie_link_speed(struct smu_context *smu)
 }
 
 int smu_v13_0_set_vcn_enable(struct smu_context *smu,
-			     bool enable)
+			      bool enable,
+			      int inst)
 {
 	struct amdgpu_device *adev = smu->adev;
 	int i, ret = 0;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
index 9c2c43bfed0b..3204917f91bf 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
@@ -193,7 +193,9 @@ static int smu_v13_0_5_system_features_control(struct smu_context *smu, bool en)
 	return ret;
 }
 
-static int smu_v13_0_5_dpm_set_vcn_enable(struct smu_context *smu, bool enable)
+static int smu_v13_0_5_dpm_set_vcn_enable(struct smu_context *smu,
+					   bool enable,
+					   int inst)
 {
 	int ret = 0;
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
index 260c339f89c5..0890951351f9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
@@ -220,7 +220,9 @@ static int yellow_carp_system_features_control(struct smu_context *smu, bool en)
 	return ret;
 }
 
-static int yellow_carp_dpm_set_vcn_enable(struct smu_context *smu, bool enable)
+static int yellow_carp_dpm_set_vcn_enable(struct smu_context *smu,
+					   bool enable,
+					   int inst)
 {
 	int ret = 0;
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
index 865e916fc425..5e1165ecdf7b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
@@ -1492,7 +1492,8 @@ int smu_v14_0_set_single_dpm_table(struct smu_context *smu,
 }
 
 int smu_v14_0_set_vcn_enable(struct smu_context *smu,
-			     bool enable)
+			      bool enable,
+			      int inst)
 {
 	struct amdgpu_device *adev = smu->adev;
 	int i, ret = 0;
-- 
2.34.1

