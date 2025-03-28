Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87B54C28B20
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Mar 2025 18:24:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C70010EA9E;
	Fri, 28 Mar 2025 18:24:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RUWIiCYw";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2078.outbound.protection.outlook.com [40.107.94.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F75410EA9D
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Mar 2025 18:24:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pm8vlcsH+oXb+dKoJ42/zNfDk5hcOIkn7dypF7mllUpn3ABg7kyOtikfIet+SLJyEvQswRL1E+xmEiV8emSNiK7AK6Yy7Z1/wRFF+NZwyldiHmENKPR5bCKiQCdI05pmedRj28Pf8CGeb7NiBsMsIwCVUtlQE6DissnWFmfwQdH7zBEXLAy6/oDbSRosWKZiSEHymbT/HB77wlZf0jkjsCZhVhbt1wdr4X2k/UlkjiE2WYrq4akk9RKevZp/fuV000f+GfblKX7dIu4rNdVNb5XMdEPHO2KN/vSb/KA7RHPD9dfT8pTG9mnwXbdhWkTlWLN6t40NiTHg/FypGGb1Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=71E50pu88hRTl4e1uKKuYvoQE+JNzp7lC/qLTvvBeB0=;
 b=DK8ulDfwxKNxzQ1SEwySzPJ7oVNRnjYYsnEZ7HXYa1hcZGav2UK6yTU0RbNsY9hv9JkOQyTHvPRS3a/14sPcQcRVmUkXuN9NBJNGGJHv8XbG3c1a308ORvEB0m3S13ttbcHcaqENxJ2TmnY6uyYYdY+lI6aH0gbUAlPLsDI1/wYTR5uOLD+OggwaE1+RWi+747ZaSD7AHJepaolhcmFHVSn9q/wzisrxbOZOYaJNAwiX65Outb7sHMBxOtYLzgmvpMj8SQcdRZs5T/MOnYAr/2oNSZeuM7o+zVTIJql1YZPLxUuSuWCVKBlD6mr3b7nTMyLHr1ncBg+mHCEfkPnUUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=71E50pu88hRTl4e1uKKuYvoQE+JNzp7lC/qLTvvBeB0=;
 b=RUWIiCYwprIcOBg9oAIVGYdwgOT62XH4p9mHx4D3J6hB905UJidEtZ5ZzXlITowuhCFmy6JjMlkJJcf+K5feqL8Yd0wcvugfvOAe6ycgew10UJT8pVmuCRkCCRj8tbo6n4mTAz6lDHJudmNVmZnH5aGy0ZqGAQzDpMsV5+9Fdb8=
Received: from SA1PR02CA0018.namprd02.prod.outlook.com (2603:10b6:806:2cf::26)
 by PH8PR12MB7157.namprd12.prod.outlook.com (2603:10b6:510:22b::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Fri, 28 Mar
 2025 18:23:58 +0000
Received: from SN1PEPF0002BA4E.namprd03.prod.outlook.com
 (2603:10b6:806:2cf:cafe::83) by SA1PR02CA0018.outlook.office365.com
 (2603:10b6:806:2cf::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.50 via Frontend Transport; Fri,
 28 Mar 2025 18:23:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA4E.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Fri, 28 Mar 2025 18:23:57 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 28 Mar
 2025 13:23:56 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/3] drm/amdgpu/pm: add workload profile pause helper
Date: Fri, 28 Mar 2025 14:23:40 -0400
Message-ID: <20250328182342.17110-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4E:EE_|PH8PR12MB7157:EE_
X-MS-Office365-Filtering-Correlation-Id: 8444a3e7-255b-4f0a-82fc-08dd6e25b457
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|34020700016|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HPy0IL+clnoUJ8SW7biBqC+fJe/iPGC6pUCwnAVEl72/GG3E2tiPcW/GM6xh?=
 =?us-ascii?Q?3luuREKWwndApwB+nPQs3NmqtwMlyQBntCgvJHrjJpIkZFzhocauoUOsZYd1?=
 =?us-ascii?Q?isvRRWi2RICOzyg6hdtVZPxZB8k8l8kYyPK7QnCGeoxONTNn6xDTp7iuxUAL?=
 =?us-ascii?Q?Z97+PCmfpTt0IwMOH8e5sQqV3rWD0450ElMdMiOVkb8GHt8yU5RqjWt1xgUI?=
 =?us-ascii?Q?70J3M+Dh33+9gpUbXE8y3KuQSuUDGVLP2kYPTIY5kkfhazq189OiNaO2n2dF?=
 =?us-ascii?Q?wHVmsKpwbwwilCCTA8GB0YT2PIpDgeht4Ms8XwOHsWODSpjATzOxx7WPeyJe?=
 =?us-ascii?Q?zQDzgvNm0+8rr/k+hTF5hx7fFl6+1yd4WvKSwTRY5SYjSiKgK8bQk4+dyL0H?=
 =?us-ascii?Q?2vszOS7MAjrX0DIEchqnlfwfJy1v68L4ZohqUvtiwrA2q8s1fxjMJocoovtx?=
 =?us-ascii?Q?23XX7oZImDC1AGN69wzT2YfMXLgrigow766xlPFppgi7mYzTjb6zhWgDQOQ3?=
 =?us-ascii?Q?GTPngUyQJolhNA86GZySQPhXUhL9thVqaSqcvLD0tctunGsyDXUtE0pv7Z37?=
 =?us-ascii?Q?vsOe/Huh9n3YGig0UCiEETknxHCU2hTO++1sRcvD8foq2Ht18RIVHgT1xVrG?=
 =?us-ascii?Q?Jr41SAMqHNPapeMD/k07jiN/QRHXonT8SOTVthBPr0jcgkA8n5+uO4SiPqTA?=
 =?us-ascii?Q?g2Fap7PalGYzwgMAGpVPzGX9Mb/yLTT7LH2WWf07prI1zafrHuIWAkyytXs+?=
 =?us-ascii?Q?G0OmYsMwsFDq2jlivxH3s5gxruNlejRHPOy+nDhKxoCcLkIXu5r12v+aIKdN?=
 =?us-ascii?Q?hejouVluRjgg0sHsTbaVDR88NDn7H/6Qj3CZkniqPWhIebehxN8Kyqau7SRx?=
 =?us-ascii?Q?fg+hZwmACEnBjgertSJf1MUaPjob3YxRVC+RBdLs6S93xrGKPzPA4bIfB5Ux?=
 =?us-ascii?Q?OUFo3i1NQBsTKMPXMBtZ0qB5ZhC4ob9nhskwaJU5tNe0F/nXA6FzBkmPPZFj?=
 =?us-ascii?Q?eTQx/yb3NWFmv+zEQuDa84DEvbxVuUPTutITO0VVFci5jgHGMCuYcitBcBY/?=
 =?us-ascii?Q?CTv6RASMx66qvMJ/1Dtvk5dA9fzevzw6o/vpthvgOKXuKK21n/+enUFiAhmR?=
 =?us-ascii?Q?H3JFk6xZxqu6079cnWSH1nqF7dAPdXzM8FPv7YJHjCGKTlWH0L502uMmlAZx?=
 =?us-ascii?Q?IYsHGz/Eb/LuAUfJkQYTSTbnk/0TIvKAqHUp6tYEPtdyO0hx6dZo4keleeNs?=
 =?us-ascii?Q?UQ6JXmr7ZLWh72c6gwCOkKuypnlCZYCADMYOdf9OatZn8TeW3v2tA+lOiEap?=
 =?us-ascii?Q?ABkfYtX3tPk1+Bu+mIoSut3PAwoSNj9bmh0Uv2TSE8k4+UHT7iJEJaekZ16r?=
 =?us-ascii?Q?HRmJ6Jebf7d4lfFcUwStB/i7FvZqkYZw5UbhTgf7f5r2QiZJv5SwYNnRE31i?=
 =?us-ascii?Q?tReuR8Xb8zc0hCuw1C1XpqG3BHyyPS/sJbRTKR7BSAdCUNR/+JzhxQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(34020700016)(1800799024)(36860700013)(376014)(82310400026);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2025 18:23:57.4176 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8444a3e7-255b-4f0a-82fc-08dd6e25b457
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7157
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

To be used for display idle optimizations when
we want to pause non-default profiles.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/include/kgd_pp_interface.h    |  1 +
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c           | 19 +++++++++++++++++++
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |  2 ++
 3 files changed, 22 insertions(+)

diff --git a/drivers/gpu/drm/amd/include/kgd_pp_interface.h b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
index 2a9606118d899..21dc956b5f35d 100644
--- a/drivers/gpu/drm/amd/include/kgd_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_pp_interface.h
@@ -429,6 +429,7 @@ struct amd_pm_funcs {
 	int (*set_pp_table)(void *handle, const char *buf, size_t size);
 	void (*debugfs_print_current_performance_level)(void *handle, struct seq_file *m);
 	int (*switch_power_profile)(void *handle, enum PP_SMC_POWER_PROFILE type, bool en);
+	int (*pause_power_profile)(void *handle, bool pause);
 /* export to amdgpu */
 	struct amd_vce_state *(*get_vce_clock_state)(void *handle, u32 idx);
 	int (*dispatch_tasks)(void *handle, enum amd_pp_task task_id,
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index 0bcb82b2f3ae0..0e4d243641c8f 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -381,6 +381,25 @@ int amdgpu_dpm_switch_power_profile(struct amdgpu_device *adev,
 	return ret;
 }
 
+int amdgpu_dpm_pause_power_profile(struct amdgpu_device *adev,
+				   bool pause)
+{
+	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
+	int ret = 0;
+
+	if (amdgpu_sriov_vf(adev))
+		return 0;
+
+	if (pp_funcs && pp_funcs->pause_power_profile) {
+		mutex_lock(&adev->pm.mutex);
+		ret = pp_funcs->pause_power_profile(
+			adev->powerplay.pp_handle, pause);
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
index 72565fab60673..df8850a01ea6b 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -410,6 +410,8 @@ int amdgpu_dpm_set_xgmi_pstate(struct amdgpu_device *adev,
 int amdgpu_dpm_switch_power_profile(struct amdgpu_device *adev,
 				    enum PP_SMC_POWER_PROFILE type,
 				    bool en);
+int amdgpu_dpm_pause_power_profile(struct amdgpu_device *adev,
+				   bool pause);
 
 int amdgpu_dpm_baco_reset(struct amdgpu_device *adev);
 
-- 
2.49.0

