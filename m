Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C78CC10F1A
	for <amd-gfx@archiver.kernel.org>; Thu,  9 May 2024 09:37:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AAFB810E4DD;
	Thu,  9 May 2024 09:37:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gmbX9XYm";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2086.outbound.protection.outlook.com [40.107.223.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D94B10E4DD
 for <amd-gfx@lists.freedesktop.org>; Thu,  9 May 2024 09:37:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bre792/QPX8PFlaT56tzBxKbUrn5ASgDT3xuffaixa5XfsWYSE+At/9ISn++jUewQUHHxiPUTFvYIzzueEHepdMwHHFMlWUD7id1Ww8/3gK5H7xPXbVbElY6ifL5dQmBXDLmXd4NJh5CoG7EAsfufNuL9whIOCO/IO3ONd5KBVFRdeHdRJsSyT8sk+EeGblkQzwVAWfgpSj8oxTQ3RPPh/jGun/hyrm/eKLE+1Bh/Ui1w/SemACv5QRWEh8Xy3G/eHPzWWGMvpap1NvpTKi4g/gz5WQHKgsDIMJ+m/ICulQaDzYdPmiYBEl6W1biDZeVyiHphU2FRUZnDbp6vtRvaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yXoTrDUb/h8F4UnHW6b+yMKbh/ApOvxpUL48o7Y3Ghw=;
 b=VS0S9zUwUpIsBNY8QJmgrMMTuq5AYE3TFiEHJ/QAfs5mJIIx+dakBkn5ryYqTA+i5qI8AhGgKTcfeQPJjQhrO+RHdMuA+Pwj8ZSnmpJVnQJ4m4o5LppVAhg+gEzUbwjVo2NQ206TBs5ThFPysnIqf/hPhQKYg2dCiW60k4Qk00KKjsekuaGhd7CPx3prb+cPeTg1wtUHz1uozdznlLPExwAWpOHSxShpHeR/3JspFF2a39OfsSqzBoxHr8z4wxNT7xoJTMAt8/X4k2HYLGQTBh4fhSJFnMqYuHnqMJqQwaZIhWZt7bWgAHFJp/gjKtCyAIEglUJEsho6iDaStZokpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yXoTrDUb/h8F4UnHW6b+yMKbh/ApOvxpUL48o7Y3Ghw=;
 b=gmbX9XYmVEfUFsqHrOZp2uWyoj1vDTd8JZQYAjL9uL/LEvRSRDAFN0FHCpsirNCb8DtnyelmcxPHOVBS59npgu/p4OG5ZIpyjWqTVs8bQOyiGt4AXyJp9zKvebUZSd+TR6Sz3aF5VKjpP1lizyV/CuNw8n2J70P60kDosegckc0=
Received: from BL0PR02CA0020.namprd02.prod.outlook.com (2603:10b6:207:3c::33)
 by DS7PR12MB6287.namprd12.prod.outlook.com (2603:10b6:8:94::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.43; Thu, 9 May
 2024 09:37:28 +0000
Received: from MN1PEPF0000F0DF.namprd04.prod.outlook.com
 (2603:10b6:207:3c:cafe::3b) by BL0PR02CA0020.outlook.office365.com
 (2603:10b6:207:3c::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.47 via Frontend
 Transport; Thu, 9 May 2024 09:37:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0DF.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Thu, 9 May 2024 09:37:28 +0000
Received: from majun-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 9 May
 2024 04:37:26 -0500
From: Ma Jun <Jun.Ma2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Kenneth.Feng@amd.com>, <Alexander.Deucher@amd.com>,
 <kevinyang.wang@amd.com>, <christian.koenig@amd.com>, Ma Jun
 <Jun.Ma2@amd.com>
Subject: [PATCH 2/2] drm/amdgpu/pm: Check input value for CUSTOM profile mode
 setting on legacy SOCs
Date: Thu, 9 May 2024 17:37:05 +0800
Message-ID: <20240509093705.414124-2-Jun.Ma2@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240509093705.414124-1-Jun.Ma2@amd.com>
References: <20240509093705.414124-1-Jun.Ma2@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DF:EE_|DS7PR12MB6287:EE_
X-MS-Office365-Filtering-Correlation-Id: e828fd21-ff01-44ec-22ef-08dc700ba461
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|1800799015|82310400017|376005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?l32RiyyraQ6SvSLwWja8dWMNTMD6eoq9NgT7novJiZZCUuu78xLKCpXdDeEB?=
 =?us-ascii?Q?wS56jGTkw3L+Ahd4v1654aPKEAo3s4ECUc+xGPWCqJD8hivQcylAZwxaAWvJ?=
 =?us-ascii?Q?UaCjQHcSYZEcbK1phkUNuJ2Gw6HkFQQidBU5bTJZzRnyHfYjs+nV4Av4CvGC?=
 =?us-ascii?Q?nJsWVc56pCTuHwCiXOn/J+CteZJw/9wSp6Qq4yEW3onMhoB8jb317jEs/D6w?=
 =?us-ascii?Q?NVvaFBFMfErhQW0tSLjJDMZM3oHasPCrxR/nIfyi4qnDO0qd+lfLd2vxI/HS?=
 =?us-ascii?Q?1eoHPodDNI3JJiw54PxAdryO0+ZNOdlWdvTQ32wmcwvCaibX6UlYEwdKEwC1?=
 =?us-ascii?Q?buPdM8pnMck/6Jjh61Sfq+jwKgleE1lvjJncMKjq9RzZ1ptB+4a+Qhw2njeE?=
 =?us-ascii?Q?pJC912QCeNY+SiFvfyjHYvUQQB7xma8398I4eM/PHcxLzXASYCGb6U7PUpEh?=
 =?us-ascii?Q?rBogQd7V6TObX/2rSEQf8su1jIAkPcDYfPTl//uS8nusCtAlFCR+nGEeYGsj?=
 =?us-ascii?Q?8GzUBFU85gy9TR7Wprjth+1+XdXqmAuWBzS3H8EGqnNUuCSZqToHamRfJWiw?=
 =?us-ascii?Q?iVjfwEaIVlSRCNZ/H0DEsSp5q1L0XX0ZQfGkZwTSWU0brcgy41EIJ/gDX3zf?=
 =?us-ascii?Q?CFbLZA2Ucdp53IlDWnyvHp2OTrT6mbpLTCsKgP37kH7R+fM+1cef0fh3eGNJ?=
 =?us-ascii?Q?vnGog67Tg1NmwHU33bi0d7Bh7AuqtI9bYhvNH0vxuX05xUAXPhFZ0q4RhCvc?=
 =?us-ascii?Q?ihZN33d+uwW68VVVFpdPax3lCBfLdnCfpQ/mIgKsklyaMmF1lRIXkcoPkp82?=
 =?us-ascii?Q?BUnBcSPL5wvRRnjgrxgWDRpn4e/+hcHBqVmAzl58iSz7iqAqRlqqlj43zw9g?=
 =?us-ascii?Q?Wf+pctbVJGmPbLyfnSpKKCsYTZUsoNNvlfg/D6VDbWPhydaQXJ7OqalJFiQX?=
 =?us-ascii?Q?2UaowPP77KJpxAflHfVrC+w/xDSmDAHo7ElyudFJsf50QSuRUlbAvbeykUne?=
 =?us-ascii?Q?EQAFFzkE/BZyUBDgkM1V8O8cIUhOHI6dT//H//HU32BQrxTTuVu3Q5VH6ytA?=
 =?us-ascii?Q?RddzbDu8NQr6TqECA4jd8b3WsioSwb4rP0DHtAFs+Q9Ji8M4FAXQs6VcfheE?=
 =?us-ascii?Q?wRCrzKEcSqak00eQLxbKm89ZAytZW7HEpkGRosRMncgE81beHmHB6vZ77CwP?=
 =?us-ascii?Q?J/DGOacoKBzgwreL/mWNhWE4iARH7nM8lOzLKZ/eYsuAf5SQqUAyhq2D+cEN?=
 =?us-ascii?Q?r64ZMQqzxtp82yD/h534m5lcJUBYl+vVVfwx6gTPNNgbcYkKUwdkgTk1niN+?=
 =?us-ascii?Q?wR04XkWq14ARomp/mASkECzpVRj9STx2ZChbmVI5vYSTbvKxlxVKTuY8fSDB?=
 =?us-ascii?Q?Ch5FKys=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(1800799015)(82310400017)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2024 09:37:28.4235 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e828fd21-ff01-44ec-22ef-08dc700ba461
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6287
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

Check the input value for CUSTOM profile mode setting on legacy
SOCs. Otherwise it may cause out-of-bouds read error.

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
---
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c     | 2 +-
 drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c   | 8 ++++++--
 drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c       | 5 +++++
 drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c         | 4 ++++
 drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c | 4 ++++
 5 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
index 5c95eda6cbd2..52ac95f8a84f 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
@@ -5647,7 +5647,7 @@ static int smu7_set_power_profile_mode(struct pp_hwmgr *hwmgr, long *input, uint
 	mode = input[size];
 	switch (mode) {
 	case PP_SMC_POWER_PROFILE_CUSTOM:
-		if (size < 8 && size != 0)
+		if (size != 8 && size != 0)
 			return -EINVAL;
 		/* If only CUSTOM is passed in, use the saved values. Check
 		 * that we actually have a CUSTOM profile by ensuring that
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
index bf1b829f9d68..baf251fe5d82 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
@@ -4102,9 +4102,11 @@ static int vega20_set_power_profile_mode(struct pp_hwmgr *hwmgr, long *input, ui
 	if (power_profile_mode == PP_SMC_POWER_PROFILE_CUSTOM) {
 		struct vega20_hwmgr *data =
 			(struct vega20_hwmgr *)(hwmgr->backend);
-		if (size == 0 && !data->is_custom_profile_set)
+
+		if (size != 10 && size != 0)
 			return -EINVAL;
-		if (size < 10 && size != 0)
+
+		if (size == 0 && !data->is_custom_profile_set)
 			return -EINVAL;
 
 		result = vega20_get_activity_monitor_coeff(hwmgr,
@@ -4166,6 +4168,8 @@ static int vega20_set_power_profile_mode(struct pp_hwmgr *hwmgr, long *input, ui
 			activity_monitor.Fclk_PD_Data_error_coeff = input[8];
 			activity_monitor.Fclk_PD_Data_error_rate_coeff = input[9];
 			break;
+		default:
+			return -EINVAL;
 		}
 
 		result = vega20_set_activity_monitor_coeff(hwmgr,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
index 6d334a2aff67..623f6052f97e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c
@@ -1416,6 +1416,9 @@ static int arcturus_set_power_profile_mode(struct smu_context *smu,
 
 	if ((profile_mode == PP_SMC_POWER_PROFILE_CUSTOM) &&
 	     (smu->smc_fw_version >= 0x360d00)) {
+		if (size != 10)
+			return -EINVAL;
+
 		ret = smu_cmn_update_table(smu,
 				       SMU_TABLE_ACTIVITY_MONITOR_COEFF,
 				       WORKLOAD_PPLIB_CUSTOM_BIT,
@@ -1449,6 +1452,8 @@ static int arcturus_set_power_profile_mode(struct smu_context *smu,
 			activity_monitor.Mem_PD_Data_error_coeff = input[8];
 			activity_monitor.Mem_PD_Data_error_rate_coeff = input[9];
 			break;
+		default:
+			return -EINVAL;
 		}
 
 		ret = smu_cmn_update_table(smu,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index c06e0d6e3017..01039cdd456b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -2021,6 +2021,8 @@ static int navi10_set_power_profile_mode(struct smu_context *smu, long *input, u
 	}
 
 	if (smu->power_profile_mode == PP_SMC_POWER_PROFILE_CUSTOM) {
+		if (size != 10)
+			return -EINVAL;
 
 		ret = smu_cmn_update_table(smu,
 				       SMU_TABLE_ACTIVITY_MONITOR_COEFF, WORKLOAD_PPLIB_CUSTOM_BIT,
@@ -2064,6 +2066,8 @@ static int navi10_set_power_profile_mode(struct smu_context *smu, long *input, u
 			activity_monitor.Mem_PD_Data_error_coeff = input[8];
 			activity_monitor.Mem_PD_Data_error_rate_coeff = input[9];
 			break;
+		default:
+			return -EINVAL;
 		}
 
 		ret = smu_cmn_update_table(smu,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index e426f457a017..d5a21d7836cc 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -1722,6 +1722,8 @@ static int sienna_cichlid_set_power_profile_mode(struct smu_context *smu, long *
 	}
 
 	if (smu->power_profile_mode == PP_SMC_POWER_PROFILE_CUSTOM) {
+		if (size != 10)
+			return -EINVAL;
 
 		ret = smu_cmn_update_table(smu,
 				       SMU_TABLE_ACTIVITY_MONITOR_COEFF, WORKLOAD_PPLIB_CUSTOM_BIT,
@@ -1765,6 +1767,8 @@ static int sienna_cichlid_set_power_profile_mode(struct smu_context *smu, long *
 			activity_monitor->Mem_PD_Data_error_coeff = input[8];
 			activity_monitor->Mem_PD_Data_error_rate_coeff = input[9];
 			break;
+		default:
+			return -EINVAL;
 		}
 
 		ret = smu_cmn_update_table(smu,
-- 
2.34.1

