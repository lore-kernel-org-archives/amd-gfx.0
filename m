Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 545EAD65C4F
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Dec 2025 13:55:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E5E5210ECDC;
	Wed, 17 Dec 2025 13:55:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2IyTZywu";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013042.outbound.protection.outlook.com
 [40.107.201.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0FAE10ECDC
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Dec 2025 13:55:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v42AIRcOpDuAdM6pdXsn8SCR/rYX/daBwmf9/OzNlB+pD0M3EoRErBd/yVZ1Xqc5q86/XHzMraNAKQJH5PhPvqVTp3HZwIGdumi1oL4CA94YfImx/MXmCpPMKreYUcdq0GBCEEzND1G2Gj7wmp3iLoOuVltAK/AKrGfqVTMXmykHnuEDCsSJdzwUtahac3zh1Vwk5bWiZfpYCsoudVdis1MV3QTtizUvEhRM/eYd2nNLoZrT9AtG29iHVYFyR/euOVdi/clultI8FcIr5V0pgXosRvmNU1Nvjp1kTtKUX0lMBoj/nJxAEVunXMBi36lw8Ec4A68z/ylyL7U/bCypSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9P7/Yy1jo8tlsKY8eWbUzDxT87X4zujzs7HkvtP01xM=;
 b=RdLO3FNNWnryFlr4zB/ur8ENLwdgO5IVkEtF4OUzHVsF91NDeXYIj72NC2ipZLIsQbMAURg4QGogidrOi6MT3/hyCcUCzvaBbduB5Mz6NrfdDnEO/Pue4mk9a/dkceDV5omkiYewi4ljaN9K9CVv1ZvUkth5mO3Dh++89SbKR8XzJbqxYjYHX7oMVwHzcuS/MZlT08NCvLhbmg57avmsW6Q78LiXE6Bsx+X/xw+jxbIHbcIgQP/6KPnHADjgZioL08PpI5mkjhv8DoWEn8N9Jhws18oa2VqbCW/dYRKE5mvt3EoBk5HuQkehI4L/t5xQogq77hgDf/TZ/OEmTTNxrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9P7/Yy1jo8tlsKY8eWbUzDxT87X4zujzs7HkvtP01xM=;
 b=2IyTZywu9NfX7c9bTKzIrNesd7ERdT+HoVb98najKy56KTGl6bjhNxvM7Td+xyKo0FbCUqatpOrkqIe3vlc+cVEbuo823VUEOMMgFkQxVCiHAF/M7SccMa/tzSGqtucOPt7AQI1hFMAgyTDk2Rc6e4Q+rXJtDQygLGbCNRgjf3U=
Received: from CH0PR03CA0073.namprd03.prod.outlook.com (2603:10b6:610:cc::18)
 by CY1PR12MB9675.namprd12.prod.outlook.com (2603:10b6:930:105::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 13:55:19 +0000
Received: from CH2PEPF0000013E.namprd02.prod.outlook.com
 (2603:10b6:610:cc:cafe::a6) by CH0PR03CA0073.outlook.office365.com
 (2603:10b6:610:cc::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9434.6 via Frontend Transport; Wed,
 17 Dec 2025 13:55:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000013E.mail.protection.outlook.com (10.167.244.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Wed, 17 Dec 2025 13:55:19 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 17 Dec
 2025 07:55:17 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>,
 <Asad.Kamal@amd.com>, <kevinyang.wang@amd.com>
Subject: [PATCH 14/21] drm/amd/pm: Drop legacy message related fields
Date: Wed, 17 Dec 2025 19:18:07 +0530
Message-ID: <20251217135431.2943441-15-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251217135431.2943441-1-lijo.lazar@amd.com>
References: <20251217135431.2943441-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013E:EE_|CY1PR12MB9675:EE_
X-MS-Office365-Filtering-Correlation-Id: 4879294a-6272-4177-7251-08de3d73ea3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qRifUKnrjE+y+JXfhYe2ki0HQfC54poHAhmh83FI+rnO3UhTPsfVwiPgvWIE?=
 =?us-ascii?Q?S1DibeBQcMhpGVxXejvR8OkgXzbGf6lyeagdz/6s1UtJCzQsQWAjXdIFRRKA?=
 =?us-ascii?Q?W95SM/KdiI32sUIXx3q+EmP+POTO27NndT/gRZ8BIdIfUyOU5Xz2GxM1yXLQ?=
 =?us-ascii?Q?mRkAJH7n9gyvEh2s5s5pgUD630WwJi3KeiLe3x2ADQL+WNwiqjPHMt5oFBD0?=
 =?us-ascii?Q?Mo7B8/CUlZZTyqWIlmLo47v3XnaCkDUU17fEmqZ/muVdc3/q1t9s8v7MY9h7?=
 =?us-ascii?Q?YpGdVo9+FOeEPmictNfuQRE6UAgfiMUF7kwIqivlsz0eHVhpT4GRqcJ2/83+?=
 =?us-ascii?Q?RyKLd09nKTsq9oZjJ6HpYgzgbCM/cBvTtmjEL9qcZe6p65U1mRILzB877Dsj?=
 =?us-ascii?Q?vjHXnHpoGgOvx15fsiqql9Qg3/JTqlCr8GHQvhIxIbh+rMfMN3VThbXc2B5c?=
 =?us-ascii?Q?AFxjGM7Fjuloi6+5LDp+cky6w774+8IEqvINNnb1mfDjPoSIt1lJU8d0T1xH?=
 =?us-ascii?Q?C77VK5ug4Q+wGbSSAkX01BPaRrOwzq8fCjBWETLwmo8hAOJRCj16ksDPB91Q?=
 =?us-ascii?Q?mI3QVVosu+vnmsUR88oRRfhL55B+FlvKTPJWBw+tKcSKu6XPqg6+5KmBz9LA?=
 =?us-ascii?Q?1mV0fWV6elXS5q9bS5tHhffhlT8f9BIpUlsGG3Qqcv3TLRVs9mOAV0CKyTzN?=
 =?us-ascii?Q?0HrZLxlAFdAU0Ta5CIuJgbnE9sJ5Hzm/dIUaL7lXVPm7j1t+HLMoa0/xmcaV?=
 =?us-ascii?Q?WqO7Zu1s9HVxAKtWFlJJzMR8uNYUp0bcF+psfbgsSXGqmcJtWEr9kNJ0W5Rs?=
 =?us-ascii?Q?D1mDbJVYVKgIF4nmPy7ShndMWkokwRqY6ahmD9tTPKnQ/SZR0YbcFG62iC2l?=
 =?us-ascii?Q?mXwuaU3m26rj1BE8uMetVtHmo8Zs4EK8dN6SvfIFXjEID5NDPu6TMVuSo5pk?=
 =?us-ascii?Q?gLJiPSaZjeIoEqzhLBxL9Ag6FTBqo+SQo5Qf6NLIZXN+04wwunvieLt/Fcjl?=
 =?us-ascii?Q?2bRnT7ZC+qeiFUZ6frldoLa5PQ3g2oJgCGaV7RlKD9jjEQtM5QeDFSfpEwUO?=
 =?us-ascii?Q?53c5n5n64z8ERtP6B1ZPDn9eAXRWVzZ0B7vh/SG+werDR9Pmat3z0/o9r/E7?=
 =?us-ascii?Q?uR0LY5Ubm/yJgSf1mtwTJYgiuGGgcBQW2xhMDV8VIFQ2KjvWWIf4CVBw1inw?=
 =?us-ascii?Q?kp47O5qxeog72e99uEA1LfL+IxwT/UUhMLaUFyi1PSxMoxzloAJZ1uf6B0Gq?=
 =?us-ascii?Q?94DiyWr6aTJPvhlBrvtB/xUdjCs+/WWGBeGt5z8pSdYQ3ZZLgivtmk2yST/y?=
 =?us-ascii?Q?mrnnIKMYYMKHLBVxoqp+vrkIPE/XXesbazfQ80B4WQBi1/r6qZhfiFgZ1s+2?=
 =?us-ascii?Q?mhRdOEK5e1ndB0S7bCxZZpe6WhqA1oKLmd5HtQRekDdxZyzU8TXtTs/VFpUl?=
 =?us-ascii?Q?ahWERD2YSWxuiTB4hVLxdhuLpZRMf4SpOiF9PMLczWn1xtQlLHOa/StPHRYX?=
 =?us-ascii?Q?8OpPUkT0gtMVniSFwdufIMln1Jl2rrWEU5qsPwZXwM/1wJ5VUDGwV/CSrFZI?=
 =?us-ascii?Q?1pH5exdHQ+UKrLUVlRU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 13:55:19.3067 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4879294a-6272-4177-7251-08de3d73ea3d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9675
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

Remove legacy message related fields from smu context.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     | 2 --
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h | 6 ------
 2 files changed, 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 39f90317b5d7..7817dccfc7b9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -822,8 +822,6 @@ static int smu_early_init(struct amdgpu_ip_block *ip_block)
 	smu->user_dpm_profile.fan_mode = -1;
 	smu->power_profile_mode = PP_SMC_POWER_PROFILE_UNKNOWN;
 
-	mutex_init(&smu->message_lock);
-
 	adev->powerplay.pp_handle = smu;
 	adev->powerplay.pp_funcs = &swsmu_pm_funcs;
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index e98a1e765f1c..a403e3a45e59 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -655,13 +655,11 @@ struct smu_context {
 	struct amdgpu_irq_src		irq_source;
 
 	const struct pptable_funcs	*ppt_funcs;
-	const struct cmn2asic_msg_mapping	*message_map;
 	const struct cmn2asic_mapping	*clock_map;
 	const struct cmn2asic_mapping	*feature_map;
 	const struct cmn2asic_mapping	*table_map;
 	const struct cmn2asic_mapping	*pwr_src_map;
 	const struct cmn2asic_mapping	*workload_map;
-	struct mutex			message_lock;
 	uint64_t pool_size;
 
 	struct smu_table_context	smu_table;
@@ -745,10 +743,6 @@ struct smu_context {
 
 	struct firmware pptable_firmware;
 
-	u32 param_reg;
-	u32 msg_reg;
-	u32 resp_reg;
-
 	u32 debug_param_reg;
 	u32 debug_msg_reg;
 	u32 debug_resp_reg;
-- 
2.49.0

