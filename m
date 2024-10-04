Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFDA5CF8854
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Oct 2024 18:45:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5EA7210EA87;
	Fri,  4 Oct 2024 18:45:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ocNbTrix";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2078.outbound.protection.outlook.com [40.107.236.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 70F3D10EA86
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Oct 2024 18:45:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NUdITbBf7rSZ1iyzsgSmRS5tQz34CBA3SDfX5rILieqxOGYyRFRQCZJngSAnZncHSwwTpsftF47Jagcx0X9kFpxcbXdoUe6YysJ37061naN1rsdn1CzmKfwTS0sW43IGdH4I6ZrrZGT8ThhL2Whv9Tibpkwq3T3J+m3srXX17FCE/OPiA/LqSeeEA9g7JSamSEPGQbNleroel01BjeIoR6tlJiuCOfgYTII6TUEXXevdlwTL7ZPmD4n8CC66T42KTkuic7e07++8ujhDB/uphHluiY+GyqNFDu8g+TJ6ugvuYaLnFWCtgXX4wMHhp2j4yl6XRl0NJir8HBv20oWeTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MKxMIqXHuqlu/CsSGUyD75UnE0d+/8wK9qJ2DKAsLcI=;
 b=K3MAwzFbpZOod5a1lPFUWHpFhh9WU73D6Gcg8I7RmJQ+2HvnGKS82sVabcZA922uXZuvL1UQazRl/PKSKlft5DA71ODFqai2DddN6sh0UIOC8W+l1pTnVm5ix5S/ATEuZ/Zql6fEBsmlFxmoac+lFoijhyAyfuDe1WPO4OtSOZfvwGnQYaG4jhqju0TRUwZLJsFYlytORqxi0NPQFWFS/uqpEoAgtJRXI+dsMABZICTRnMhrNb4z4KfMDRvnsCFSKsSUR6KGEPXaYk6Y6zTzUey4uOdfGJ0c6qwlNN6Vq3kxr+iuzA5mo3JEBjeC0NPTWk+sM3Li5Gj/P05G1Cy1Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MKxMIqXHuqlu/CsSGUyD75UnE0d+/8wK9qJ2DKAsLcI=;
 b=ocNbTrixjL38nTEXAxRRtFEo4VqtVzDnMAFtQxZzSevODe56gLPwp9rjIj7DSwtYVsLJZ1dWMX0ui8whTJjqDzw2HBj4wtU6ZaJGMx+isM/8YZNq22RBA9viwsrIONuz4UFZakziB4MJNNi2mThqB0y1NuRXYjmj736wbXabIBY=
Received: from MN0P220CA0030.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:52e::24)
 by IA1PR12MB8336.namprd12.prod.outlook.com (2603:10b6:208:3fc::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.19; Fri, 4 Oct
 2024 18:45:01 +0000
Received: from MN1PEPF0000F0DF.namprd04.prod.outlook.com
 (2603:10b6:208:52e:cafe::2f) by MN0P220CA0030.outlook.office365.com
 (2603:10b6:208:52e::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.19 via Frontend
 Transport; Fri, 4 Oct 2024 18:45:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0DF.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Fri, 4 Oct 2024 18:45:01 +0000
Received: from atitest-Rembrandt.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 4 Oct 2024 13:44:59 -0500
From: <boyuan.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <leo.liu@amd.com>,
 <christian.koenig@amd.com>, <alexander.deucher@amd.com>,
 <sunil.khatri@amd.com>
CC: Boyuan Zhang <boyuan.zhang@amd.com>
Subject: [PATCH 01/18] drm/amd/pm: add inst to dpm_set_vcn_enable
Date: Fri, 4 Oct 2024 14:44:27 -0400
Message-ID: <20241004184444.435356-2-boyuan.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241004184444.435356-1-boyuan.zhang@amd.com>
References: <20241004184444.435356-1-boyuan.zhang@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DF:EE_|IA1PR12MB8336:EE_
X-MS-Office365-Filtering-Correlation-Id: d76b1fad-7565-4194-7f98-08dce4a4a76f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y3JyTEEzdE0rK09FbFNYZlhOWUQxWGVkVzBzL2xmUW5YRFJoTWo4TkJ1Mytq?=
 =?utf-8?B?VDl6dm1pMlZUaWpyc3Fja2FtcjdyVzcyYUd3ZDNpMEw3WTh6djl2aFovcDFv?=
 =?utf-8?B?RVpNNGlub1lqUU9mZ0I4a1VVWHNmK1I0c2c0dGZRcmI5a3ZPRDdZaCtvUGNw?=
 =?utf-8?B?WGtZSFhCQkFmUDBLYmZlSGtuM3FKTzdQWkdUTEZ4RTlHSnhSTWJpRU92SS9D?=
 =?utf-8?B?bFYxanN4OVF4UnZiT0ZycnMxb0tYaUxURTVuQzBXbkpGQUtJRDMxdTlJVmpp?=
 =?utf-8?B?b1g2NmpYdnBUcVRBckZLSXNhQXd5ek1naTlacUFZbDBvTDIvNFVTY2dMWVlu?=
 =?utf-8?B?SHdXdFA5b0FJRXhic0NqK0dsdnNwbVdocklqajRGOWVXV0orUkZ3SFJRNGpJ?=
 =?utf-8?B?VDIyZUtYS3Q1VHBHdjhKYk4vUmMrRWJZeFQwWXlUaVdiVTdVdGp5RmVFMUxs?=
 =?utf-8?B?eWVzTmQyVkcvbFI4b0NrcUp3Vk9Gd1BhTkVrMThYZVhWNEUrODR2U2liMVBh?=
 =?utf-8?B?ZXBTWDduSDNUYXRlRzJqdHFreUxMejRyUlZMbTJmNGorUSs3WXVCdWZHR3o1?=
 =?utf-8?B?Tit6NDFIRnpaSjB2Y0dRaUlTb0E1dUtGTk0xcVIwYUg5NTBiTC8zbXNaU3Fi?=
 =?utf-8?B?RU9zaW5GSmIrd2MzWTFSWkF1a1gyVHlJa0psMlJPdDNWVGhNQkszbWpvdGJw?=
 =?utf-8?B?ck9EYjhiS0d6a0JQTEtYYXVuRlBSMHdiYlY0Q3UrSmJZK2svVktWWDdTQkp1?=
 =?utf-8?B?SWlzY3BNU1lRVHVlK2NGdXJxYnRZSE1qUEVsZWdvV2Jnc25nNC9FTjVRVTZ6?=
 =?utf-8?B?Wk8wTmppWFZFc2dZb2RSK3dUU1IrdVFlWExtTlBHMGVrMi9vdjFjQWNPQ0Z0?=
 =?utf-8?B?b20wNy9WclNiTWtwdFFjMHJFTUdsQ2hTeXgzeXVLamUvM0dydjBGZjQxR2lx?=
 =?utf-8?B?a3NWeGVISUt0b3pDbjhNUDBPZUl1MlZMSUo0VnMvOWR0SEJNTExuM29kS3Nr?=
 =?utf-8?B?VjhlYytSaGxVODB0VVdIRUtCSHRKcTNVdnE4L2VMaTZuVXNHWEh3WmVVVWVZ?=
 =?utf-8?B?L05wTE12Y3orYzJvWTlVRUtPUnNCQWZjVUxvbzVURnQxZDFLV0poVit2bm9I?=
 =?utf-8?B?Q3hYcmpYc2JOaHdWdlZGWnJXVzZPNm9kTzd1NUtxelpEYzdTOThOZm5kWXRy?=
 =?utf-8?B?NTRQTUkzVENTSTd4N3RkdExwcmxMK1NYd0ZaN1NwM2ZaU0JuMitlWXZnOWhD?=
 =?utf-8?B?eVIwTmlIRHRpY2lrN0J4ZFVaRzJ1VHkvQXNEOHR3U3V4QU9aU2tJRU12cEFO?=
 =?utf-8?B?WG56WnRQZjMwWE81T2VGcmtOeDI3eFVVMEY4K0djTkp0em1KekVMeExFdmNw?=
 =?utf-8?B?TExZQUZZeXAvZUk4aXVEekJLQ3hnalAwQllxMyt4Z0NNMkN4WEVyV3doQXhP?=
 =?utf-8?B?TDFsbE4wRjNrK3FDVGVFYWVzbFAxbFRVTkZUT2k1NUpHQXVCckF5amtoVG5Q?=
 =?utf-8?B?Q1JvS1NxYVppcU55dGdEa1FwSllFZnFlZEtmY0w5WEg3YmZHS1ZuMjRNSjRw?=
 =?utf-8?B?LzhqNytGd3NOTHdTWnk5NmFKTEwxc1oxSlFNSXhzMFRMU2I2WllOVEF6WHdF?=
 =?utf-8?B?RVEybGR2c09xTE5nZmdkY3pmT3c1VFllc1l5NXArd2Vka2wxTHpMUDBIb0Nt?=
 =?utf-8?B?RHFrSFIzaG5Ebi8vT0xYZFg1em16QW1kcU4xUFBPSTdJYTAvbVJoRDQ5YWI2?=
 =?utf-8?B?UGVkeDRSTVZ5aHBwWDBTRGJhZFU0QXFpUklBZXVUMWhydTBTV0tKekRHUnJj?=
 =?utf-8?Q?DZSRPGxPPhDnEYJL9BW5MPjJsqACEGR6QLL6s=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 18:45:01.3077 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d76b1fad-7565-4194-7f98-08dce4a4a76f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8336
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

