Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6497CD1039E
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Oct 2024 02:36:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6FB910E9CC;
	Fri, 25 Oct 2024 02:36:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sh5+D1A/";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2085.outbound.protection.outlook.com [40.107.237.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A7C710E9CC
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Oct 2024 02:36:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oHNYbIAD+4zlvYWIi6mICAii9z9K+gzk986sgO9ZepJyLOehtmzZsRe53OJp5alP+HA5/7xZGb7OfIl9nSTPlneuQMBcWswEvozzNqfAL10CpzPqV7YrLhO8oEywdlsMi+elPFZ/NyAvrHxnnNjXP2+DhCTMImXg5q4crIvnKUxmEvICUE77GrITHsj9mdQZN5CS1qk58/2kianpHtfYcqprbDbgNYAGVj73EcfX6FezMAW8aICved7Z66FqQZk2oSobnG7IntxckN3QYCc5EbVqIVQhlH/oVUqWwKAmgsASr9eXJc8R+Ohdzu8RRD3JpFI5TvHHTj1Ryf3sMFj1/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uNzzTB6ONVZhlvSWDHmVsMycgd1I9TAIoyxeYFwC83I=;
 b=ZL1oYsgy6kqT5LFattYoGdkjigigf4P1/Ta/BrMzzfEjB03470K22fNtPw3Nbs0UlUu7vawY3yBA0SV3kKOCCqtbeBrguF4lv8uJApo7AXkErDTnhmcmy5C0/GZcnuFjBTZly4K/Ovo4NwhaH9nffSmqkCxmdqHZdWwkzi4LSgBqmbzo/kbrvIXKw9VzmKc2hyJChZHdsn9Of3HX+sPTovJcK177PHPWCG1AAXVtBSMCxNEk1CmmZ05EF03dc/S0CdECAok2klOPRUolnRMLXu9bQhGL8UCtF6T7O+sIkzmk8ZHS43wtZHNajCDysL/bQ8yDmcW0S4h3vs+zL/6wPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uNzzTB6ONVZhlvSWDHmVsMycgd1I9TAIoyxeYFwC83I=;
 b=sh5+D1A/fiLJleBldoG4MA+eK5o+E2uWBgvLY02OvtEFVXvCEv4c0te7ws6DHjqLXKZPtgJAuHO2mSEG1zE8N5SrjrTzVGypNwfeeXxv/vNhIR9Dq2QQzigfIMuvFBlUmYoEw0XYaRx5Iwj40GJ3lNgeEcurxtf6j7ZvpF8Z2jI=
Received: from CY5PR15CA0171.namprd15.prod.outlook.com (2603:10b6:930:81::17)
 by CY8PR12MB8313.namprd12.prod.outlook.com (2603:10b6:930:7d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29; Fri, 25 Oct
 2024 02:36:04 +0000
Received: from CY4PEPF0000FCC2.namprd03.prod.outlook.com
 (2603:10b6:930:81:cafe::7d) by CY5PR15CA0171.outlook.office365.com
 (2603:10b6:930:81::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21 via Frontend
 Transport; Fri, 25 Oct 2024 02:36:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC2.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Fri, 25 Oct 2024 02:36:03 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 24 Oct
 2024 21:36:02 -0500
From: <boyuan.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <leo.liu@amd.com>,
 <christian.koenig@amd.com>, <alexander.deucher@amd.com>,
 <sunil.khatri@amd.com>
CC: Boyuan Zhang <boyuan.zhang@amd.com>
Subject: [PATCH 01/29] drm/amd/pm: add inst to dpm_set_vcn_enable
Date: Thu, 24 Oct 2024 22:35:17 -0400
Message-ID: <20241025023545.465886-2-boyuan.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241025023545.465886-1-boyuan.zhang@amd.com>
References: <20241025023545.465886-1-boyuan.zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC2:EE_|CY8PR12MB8313:EE_
X-MS-Office365-Filtering-Correlation-Id: 4da7e282-54d0-44b9-45c7-08dcf49dc57d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RmM5UEpBV2ZWMVFJRzkzRk1kUmhyVFAvdUpneWVyVGNvbXBlMFczc09PZk54?=
 =?utf-8?B?Z1Z3YUVURG1ESjJ5NEtCNllKVGRVV2RnNVdYRTM4Y2U3c0dVaXpGZ3o2bk41?=
 =?utf-8?B?TlpWUUxzMFJMOUVYL21ZdGd5R3ZaeEZtUGJ5THYrdndSUkdmWDl0dUdVY05U?=
 =?utf-8?B?OGxrV1M4Y0VMZVdUTTM4Tk0yUHlYWWtURjNZVG5TVXVkQ29tR0hmNXlJejFo?=
 =?utf-8?B?eUhSWHVuVE4zNUNPVXZCQzdOVExYNGdJbDhSeDJtTDd6UHFMdjdDbTVkOElD?=
 =?utf-8?B?RUVManFJVGRJVEhJNmlrK3MxckZrQTdsOUpOU1R3QUpFK0JEVlJsYXFNcGhX?=
 =?utf-8?B?MDQraGlHbitHZ3dzTXRUWkk0ek9rQ2tZTTltaU5ybzAvb1dlZlZEU0hlWFVx?=
 =?utf-8?B?QUtzTWpGK3Z4ak85cThuZmpzK1VCQUJKT3JxcG0wN2pUcVpPV3N2akJVOHRC?=
 =?utf-8?B?USsvT2JXbDM3R0N5UUdCV0RCbGZ2MDh0VWxJaXV5VkVkbDlMU2plZ2QwTWlZ?=
 =?utf-8?B?YkkvRGlCeFIySjE5eStVejRoWU02eEFZS2RiSlZSY0ZXamtHVGl5aHhVQWxy?=
 =?utf-8?B?a0VRT1JWNllqZUZpeldLTk5YcGpZM3A2UVZMRWtkbFdPZ2liMlVFS0RjWUxi?=
 =?utf-8?B?VnM0a0JVVFY2d2k2OUNzUTZCa3FzdjZxdzEzemVVK0g2K0dNTzlYQlVvc2lR?=
 =?utf-8?B?QTJ1a1NkVlJLaDNVdDZhVHNqSWlEMUdnTlRXTGQwRENBdWo4Um1KM3h3QlB6?=
 =?utf-8?B?NnZGRWVhOGRZMEh6Q29vMkJWUlRVbExmaVhTUE0xVGxUSWdieHNmMXg2eE5m?=
 =?utf-8?B?L0UvMmJuMW5Pa215UC8zaVVFV214RE00ZVZZSVpnbGwxaHhJeXpqM2ZTZkRZ?=
 =?utf-8?B?dVFWa2V1SXdGTGMwZEV5cUx3Z2RKN3RFNTdLY1QxWkpKZU5jODRGdy9vby9Q?=
 =?utf-8?B?YmovdFl0T0NsWjNwdE5OVTNTNFZSdU1PY2NvZzc5VjJxcU15ZEwrVU1KdTBD?=
 =?utf-8?B?bmg3OGZYdktXSS9IKzczcy9zUU4vNjVIb1RFakhBYklsemRxT0sweTk0bGdt?=
 =?utf-8?B?RjdEd3ROUkp2bWdzN3ZOTENSR1RoZnJQWmRuY1BrM3c1dzU4TjZ3OHlKT0dL?=
 =?utf-8?B?NjhaRStwMjhVNDJ1dGR4aCt0VEYwQW00MzBoQS9uT0hwZDhtVmJtblo0V1hJ?=
 =?utf-8?B?SDlraDZGWTFpNnNsclJxNEZ1eVN3YXpwWXVZV1lsQnVyVElHUUZoWXNUVTNr?=
 =?utf-8?B?RkI5QnNpZTEwNTNaaWFqbHhaZVN5NWdDRlRCZ2ZXRUN2TFZLZHdJVTU1cnli?=
 =?utf-8?B?dzd0cUx0Y0NUZEVlYk5ubFdzaVRqNDhFaWRzam5SR3ZpMnBCTTZoK3lYeU1M?=
 =?utf-8?B?UnhFd2pSQVUxYzE5ejA3TVVYZ3M4QThGMUFBY3E2M1Q5VGZjTC8wNnVSKzNY?=
 =?utf-8?B?QkNSY1kwckcxSWlmZGVybkJtWG9EVUN3eDEyMlhzMTJGUlB4MHl4cEhkcnpv?=
 =?utf-8?B?V3NJZ0VlKzZ0b0RNZ3p0WnlrMFEzMFlYa3d1d0lQVFk0dytxcm5uSFVzTnRm?=
 =?utf-8?B?RHhMRnNFaEZ3clA0dWdmTHFaWTBxL2RsNWpkRHV2cVB6aWpVa0x1K0ZKVCs4?=
 =?utf-8?B?NnJ2S3h1NnVjR05qSTRBMlBRSkxJelRsc1MxcTNuL3VxdnhGZ0I2bHhMd3Ey?=
 =?utf-8?B?cENnUzVBeFR6U2JyL3V0T2ZvbURXcjh5d3hiVWpJV2FQZFllSllwUlRNb2Ry?=
 =?utf-8?B?R2hXSHVSQjBwblJXa2VXdWZva2pZQ2lHSjJtM1FtMXFxQUx0NklleWNPK1lT?=
 =?utf-8?B?MzdDS2x6OFNWK3ZRZGtwQnVkc3kvL29rT3JqY3MyaTF4VkYzZXFjQVk4TmRT?=
 =?utf-8?B?SDU3WkxGTmg1STFueHVUWlpkelUvVHdrMkVvUjVwcVo4b1E9PQ==?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 02:36:03.8100 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4da7e282-54d0-44b9-45c7-08dcf49dc57d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8313
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
Acked-by: Christian König <christian.koenig@amd.com>
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
index 8d4aee4e2287..fe2a740766a2 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -252,7 +252,7 @@ static int smu_dpm_set_vcn_enable(struct smu_context *smu,
 	if (atomic_read(&power_gate->vcn_gated) ^ enable)
 		return 0;
 
-	ret = smu->ppt_funcs->dpm_set_vcn_enable(smu, enable);
+	ret = smu->ppt_funcs->dpm_set_vcn_enable(smu, enable, 0xff);
 	if (!ret)
 		atomic_set(&power_gate->vcn_gated, !enable);
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index 8bb32b3f0d9c..4ebcc1e53ea2 100644
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
index 044d6893b43e..ae3563d71fa0 100644
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
index 07c220102c1d..0546b02e198d 100644
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
index 9fa305ba6422..faa8e7d9c3c6 100644
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
index 77e58eb46328..a9cb28ce2133 100644
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
index a333ab827f48..a1ef63878cc3 100644
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
index 0b210b1f2628..a34797f3576b 100644
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
index 6cfd66363915..2bfea740dace 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -2104,7 +2104,8 @@ int smu_v13_0_get_current_pcie_link_speed(struct smu_context *smu)
 }
 
 int smu_v13_0_set_vcn_enable(struct smu_context *smu,
-			     bool enable)
+			      bool enable,
+			      int inst)
 {
 	struct amdgpu_device *adev = smu->adev;
 	int i, ret = 0;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
index a71b7c0803f1..f5db181ef489 100644
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
index 71d58c8c8cc0..73b4506ef5a8 100644
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
index f7745eaf118e..ecb0164d533e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
@@ -1507,7 +1507,8 @@ int smu_v14_0_set_single_dpm_table(struct smu_context *smu,
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

