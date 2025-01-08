Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 030BBE77188
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jan 2025 03:50:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6873610E7E5;
	Wed,  8 Jan 2025 03:50:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qwJNKAKA";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2047.outbound.protection.outlook.com [40.107.243.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 049C410E7E5
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jan 2025 03:50:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KplLKxK5yNXMe3Y6dhAMg7dHtG8geSKk2UarmAjzAz4OhwTxLS0u6ur9Toyz9WR02hk0hYS4RNNm5JolEdlbcOuwtJ8Ja9YYYv1+5K6cJAKWuFflO8zPFuE+Ia/8tUrjYYOGwd0evyx2rStgR/SjMYI4ow0WEWIwHJly6JBib/ebWiS7KYDyrlX2ZjsJ5d9MCTNDPcaM0s/tIG9Pdx5hcxJQevOpu+Kg3nNKO45QioP539RCXPeUmhdhtoyK6ZW25j8pKFFF8cQFW1NHoxTOK3iycYVFT9gCDV/1mlTR6PYmPY/wI+bZFJb6d/hf868eqyBgCbpm2Erluiiff9k1CA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J0nP2jv7WUJ0RdsIvgHZZ6a20eRvyLgkG0/JhmV1Y9Q=;
 b=uGUYK/JnZIasH4nzSNzYoZMPliC5FZpATv04YeTu4CX6TBOadczVQiVpvnSv0L3K9LQ/DGN4VDm4aWmLROvAmEScZDTepRkBgYyj4hjZPgoE5KYNxQ+5sygIi3taSTpifnityBfC6czYOI7pYMPnegg8slqyW7SxYyyhU7AzwY2NQuf+vX/NtHVMmHYD5WUKjawtWEIWOgi3NXVij60iZKcyC4p12Q0mZoy8/MHBvvtj7GRiO907DtWYohDsoSkfuvq9E2vXq85FDO/wlHgmzAJGhKoRHQ+uR5hhxyDoGhzSt6t0nn8boDOh+Cj6mdcoDCI3hy9C7P23LnqJmonmtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J0nP2jv7WUJ0RdsIvgHZZ6a20eRvyLgkG0/JhmV1Y9Q=;
 b=qwJNKAKAu3Z/fWNm0jhmxuQQ0AcYMfC31ndSEiXx5PJCoEMDEkoqSyzYduN5JJWWzxs+WwNOSTgp/2s3plEufICwkyioG4TpiBDInSqckD1d4s+2iKmdyYwXR9tI3S6qYCd/i4X3mz2ooysxUUonYJDkKR0HefaD6e/Zgt5deuI=
Received: from CH0PR13CA0031.namprd13.prod.outlook.com (2603:10b6:610:b2::6)
 by SJ1PR12MB6313.namprd12.prod.outlook.com (2603:10b6:a03:458::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Wed, 8 Jan
 2025 03:36:17 +0000
Received: from CH2PEPF00000140.namprd02.prod.outlook.com
 (2603:10b6:610:b2:cafe::ef) by CH0PR13CA0031.outlook.office365.com
 (2603:10b6:610:b2::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.10 via Frontend Transport; Wed,
 8 Jan 2025 03:36:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH2PEPF00000140.mail.protection.outlook.com (10.167.244.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Wed, 8 Jan 2025 03:36:16 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 7 Jan
 2025 21:36:15 -0600
Received: from kenneth-mlse-vm.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via
 Frontend Transport; Tue, 7 Jan 2025 21:36:14 -0600
From: Kenneth Feng <kenneth.feng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <aurabindo.pillai@amd.com>, <alexander.deucher@amd.com>, Kenneth Feng
 <kenneth.feng@amd.com>
Subject: [PATCH v2 1/2] drm/amd/pm: add the interface to set and save the
 bootup workload type
Date: Wed, 8 Jan 2025 11:36:06 +0800
Message-ID: <20250108033607.13506-1-kenneth.feng@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: kenneth.feng@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000140:EE_|SJ1PR12MB6313:EE_
X-MS-Office365-Filtering-Correlation-Id: 652f4fcb-be36-4de6-164a-08dd2f959bc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Yte/dj0Cn7c0lpihfXohsgxx/EBiXiS/BBs7HgsjTizM9T6GBWPPJvqj+I64?=
 =?us-ascii?Q?ve1MZelccO5ZF+b3dU+ui7yBrLJ7LMj7p2lSzR4wtRtWM+WXEHvHVw1A2M7z?=
 =?us-ascii?Q?EtRmasXeL7UsFwFvxzawaLT9//cmn6qMkvUGFqcfdtGAnix2TKQCCgEG4/YC?=
 =?us-ascii?Q?WvMGeWYlaPQcHjMrI2hCZwqBAZLLIPJ8iEycvNrrhOaco7rKOMhPEkAOwlI1?=
 =?us-ascii?Q?+pc8omDp2XIRuPRI9qBvE56lsJZh4tBIaoE5puSLGwyzjz1jySchwrRsK80g?=
 =?us-ascii?Q?ZAA5sAIoLdUyyyVNY9dgoFpLsFpVlYBjtRLucBQmS02+uRo7YGghjME7h4ht?=
 =?us-ascii?Q?uxCYfIG/T916lLZSXc1WUnUEzeeW6o7+3CJaSCFkX0iwhf5EbuBcnBkIc5kt?=
 =?us-ascii?Q?3AtflnLSHKFvKrzr3PtcFsnRNXDFdzJZQT3B5lMVLjrD5ra1iDem8aCyiZUK?=
 =?us-ascii?Q?9mW1BDQ9QT4+6PfOULn81+LlkLoiyJhFJY4iVHwqm5rtkDAhWz19Gbdqvvq1?=
 =?us-ascii?Q?yUMDDTPAQqX9+F17S5nydZpWLbyOTug+qTQJBdSMC3+NaUMZDFlJ5XNnQfEB?=
 =?us-ascii?Q?rt6YDW+DMw/AAsWAGQHMySHJHub/pw2O9Iq4RKWqLeg/VibGufpB6rs4PtKK?=
 =?us-ascii?Q?VLC8SJTVwauxz5aL4goiq5wqktt9+NBc7NiyycmOLutM0kmI8+/UNqYQBquq?=
 =?us-ascii?Q?PDcNGM3MIfvnVKOYuzgLc2SkZCSGf/vEMBSA6g0ay/qAXFiw8MDbNGV2T9zy?=
 =?us-ascii?Q?gFlj7bi6IIb0kXrJXx2tOrbvHZ0oVvgnvd7mplJ4CIRRCKDq925Mhbu+Km+5?=
 =?us-ascii?Q?yr3IeoeJvKkrrrJWHxPyuTRqmWlsjCTef8UZIK1OW5emAKzn+na/+gY5z7aR?=
 =?us-ascii?Q?RLwmUPWG3MeKKvc6vTCwJwbpXMK0AJgEuQ2oW4ClW7IA2eQcYqXutGB+cvMZ?=
 =?us-ascii?Q?4tAQ5FVMnaVwS6s/px/cplLVi4/VQj+SMk5iUA+1EpdV449FTW0WXajIT0DT?=
 =?us-ascii?Q?rh7opdIa34LFjM/tR1geziOJf3igcWRK/HEfruf8JQIia27cBhcbk/IHZfnB?=
 =?us-ascii?Q?TxOchm1mej5Yg7dmWvFh/DrlLCT891HYO0Rru2+OLG7BCOss/5B6NL21EbtD?=
 =?us-ascii?Q?3tHqB+bj1q5xyh0CIZaQUnRkLzmM1KBblyug8J1Q3mB2ZxS6rfBHF6rSNMG0?=
 =?us-ascii?Q?8zE9ZHCBbM+eJNvv20RyiKU/oJqdzdpidqwVHejGfHelKk6jqhONahRovxSl?=
 =?us-ascii?Q?T0S2sT4TFnVEPNZfI8zclaxs2aOO/GMoC9Z4xOxfyzKw+MdrRLiuVGn1WGLc?=
 =?us-ascii?Q?Pxd49TW74QoflsMWqBhYohVbA+QUJTNj4xeGsXbYExA2Pc2HtcM2qtwNjQ8n?=
 =?us-ascii?Q?+uhdGXluUePaNVM0tovw2CBFasShdOiJBcNPth9ui1UVdavByJNb8+URFKHp?=
 =?us-ascii?Q?SlCNMC4mUP4U+zc/Uvw45ZSR1KVTQOG+kx8sJny3Y6Fy6bml17FGXGk4q0pO?=
 =?us-ascii?Q?qjE9nNWsG9VmS/w=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2025 03:36:16.5754 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 652f4fcb-be36-4de6-164a-08dd2f959bc8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000140.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6313
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

add the interface to set and save the bootup workload type
v2: add is_support_sw_smu check and pm mutex lock.

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c           | 39 +++++++++++++++++++
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |  3 ++
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |  1 +
 drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h |  1 +
 4 files changed, 44 insertions(+)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index 6a9e26905edf..94e92e496e55 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -349,6 +349,45 @@ int amdgpu_dpm_switch_power_profile(struct amdgpu_device *adev,
 	return ret;
 }
 
+int amdgpu_dpm_set_and_save_bootup_power_profile(struct amdgpu_device *adev,
+						bool en)
+{
+	if (!is_support_sw_smu(adev))
+		return -EOPNOTSUPP;
+
+	struct smu_context *smu = (struct smu_context*)(adev->powerplay.pp_handle);
+	int ret = 0;
+	int current_profile_mode;
+	int saved_profile_mode;
+
+	mutex_lock(&adev->pm.mutex);
+	current_profile_mode = smu->power_profile_mode;
+	saved_profile_mode = smu->saved_power_profile_mode;
+	mutex_unlock(&adev->pm.mutex);
+
+	if (en && current_profile_mode == PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT)
+		return 0;
+
+	if (!en && current_profile_mode != PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT)
+		return 0;
+
+	if (en) {
+		ret = amdgpu_dpm_switch_power_profile(adev, current_profile_mode, !en);
+		mutex_lock(&adev->pm.mutex);
+		smu->saved_power_profile_mode = current_profile_mode;
+		smu->power_profile_mode = PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
+		mutex_unlock(&adev->pm.mutex);
+	} else {
+		ret = amdgpu_dpm_switch_power_profile(adev, saved_profile_mode, !en);
+		mutex_lock(&adev->pm.mutex);
+		smu->power_profile_mode = saved_profile_mode;
+		smu->saved_power_profile_mode = PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
+		mutex_unlock(&adev->pm.mutex);
+	}
+
+	return ret;
+}
+
 int amdgpu_dpm_set_xgmi_pstate(struct amdgpu_device *adev,
 			       uint32_t pstate)
 {
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
index 1f5ac7e0230d..5fe404bbb033 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -410,6 +410,9 @@ int amdgpu_dpm_switch_power_profile(struct amdgpu_device *adev,
 				    enum PP_SMC_POWER_PROFILE type,
 				    bool en);
 
+int amdgpu_dpm_set_and_save_bootup_power_profile(struct amdgpu_device *adev,
+				    bool en);
+
 int amdgpu_dpm_baco_reset(struct amdgpu_device *adev);
 
 int amdgpu_dpm_mode2_reset(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 8ca793c222ff..a6f748361198 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -1272,6 +1272,7 @@ static void smu_init_power_profile(struct smu_context *smu)
 				PP_SMC_POWER_PROFILE_FULLSCREEN3D;
 	}
 	smu_power_profile_mode_get(smu, smu->power_profile_mode);
+	smu->saved_power_profile_mode = smu->power_profile_mode;
 }
 
 static int smu_sw_init(struct amdgpu_ip_block *ip_block)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
index 3630593bce61..c58fc31fb1d7 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/amdgpu_smu.h
@@ -560,6 +560,7 @@ struct smu_context {
 	uint32_t workload_mask;
 	/* default/user workload preference */
 	uint32_t power_profile_mode;
+	uint32_t saved_power_profile_mode;
 	uint32_t workload_refcount[PP_SMC_POWER_PROFILE_COUNT];
 	/* backend specific custom workload settings */
 	long *custom_profile_params;
-- 
2.34.1

