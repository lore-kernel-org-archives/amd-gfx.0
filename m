Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C765CC021A9
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Feb 2025 15:27:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7671010E170;
	Mon, 17 Feb 2025 15:27:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Hh5answn";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2074.outbound.protection.outlook.com [40.107.92.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 79F3910E170
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Feb 2025 15:27:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tsX7wiGPzVsiymIBo5bV5IfW7GrFNlijzhcox/Kb1yE7/XAKNBSHaYRw55toFSMCpQsPwylMfODtt8XED5cj38x4iS7QAMhJox/3r+23GKkPUmtDFK4Xp/utPK4LMz5ao/Rbg+1Z6kVCly2p/GMVqhIhDHzbCcdcCeOWapkuAT51hJzVaUek0Sw3FkQ8OfwAIP1voec6e4d9Eh4XR0WP/aKas9ZA88fs5p9muZXksG0YkY+cvsRSqH4kwuYXvsWVO403h/0ad1tNbdmxJVIuOdna1zzXz8TA+i3E6fh7J2ZFwPwaIBdq+RdPGDWYIpelXTz2v2TOcz2K4LdBpzSXHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VaYHPewO3KAvn4gR7QGtwqEN36oSYVXAm2v9S192Bnk=;
 b=UMZNvzzTfTj9yvyZvulfkdUVwjvQfslTuzbmn5eemIpE0Pt1QoUTFt/mq/g7X43clRsJ1Rx0iIuhbMepWo4RoC05hhpqK/rrIffMB4Sq3SBuS8VoaQtCal43aCMn4XWzypWd1++A0eyRogU43ukQkSLHGoOiGTwZ1QJ+W0gZkrXZ+0oQ6zGPC1O/gbMZ37lrlOh++u1uPER4lxTE5Xya7awiIb0qIkDx23XPMvDF7NlPFPhwgL3yh6knr+Im5oh/Ne6ll3gprzkRRVQz8Q+NFCfYQbzvL8KaPbdsJIGGembCWJmo49OBkmpjjz0QDEYx5OWVJGha8o51g4mLJJaRIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VaYHPewO3KAvn4gR7QGtwqEN36oSYVXAm2v9S192Bnk=;
 b=Hh5answnFCB1Hd3PVaEjRG6V0ifDh4VZ7PimRaOtoYT7XWadkNYG4XHzhPT6rJnzX7xRjxcsaSuF0YeVlLjomCpY6QRXDM4i8FM79pPoEg6NB6IGSh4ZEIyJ2hzWqMsq/hd8nRJaBn0JtVYUr4HU4c0jsN5dZVFJB+p77GSTFAI=
Received: from MW4PR04CA0283.namprd04.prod.outlook.com (2603:10b6:303:89::18)
 by SJ2PR12MB8034.namprd12.prod.outlook.com (2603:10b6:a03:4cb::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.18; Mon, 17 Feb
 2025 15:26:53 +0000
Received: from CO1PEPF000042AA.namprd03.prod.outlook.com
 (2603:10b6:303:89:cafe::7) by MW4PR04CA0283.outlook.office365.com
 (2603:10b6:303:89::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.17 via Frontend Transport; Mon,
 17 Feb 2025 15:26:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AA.mail.protection.outlook.com (10.167.243.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Mon, 17 Feb 2025 15:26:52 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 17 Feb
 2025 09:26:51 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: "chr[]" <chris@rudorff.com>, "Maciej S. Szmigiero"
 <mail@maciej.szmigiero.name>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] amdgpu/pm/legacy: fix suspend/resume issues
Date: Mon, 17 Feb 2025 10:26:38 -0500
Message-ID: <20250217152638.672864-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AA:EE_|SJ2PR12MB8034:EE_
X-MS-Office365-Filtering-Correlation-Id: f79cd4ab-f0de-4939-7342-08dd4f67816f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HRzCc09UoAkBxAiKLo9t8hw6ULUDDTy25BMoipOiyH3Q9iirwl55ap3GMx00?=
 =?us-ascii?Q?P8K0ERRSr7ZB8RFBv+ja9AZnl3wZGiM412hzo+elMN3bLZYZWMa4iuQTOyL7?=
 =?us-ascii?Q?2y3BnRh1V8ot3UNhuGjF8v+jh8a9TRUGv0z/y3ZjF6PjrGytYIeutCWrCMxA?=
 =?us-ascii?Q?V8zPWyuvlI8Kixcm+dbwY2kavnoHARUa8+beIKA0XFQUbN8HKjTBo+GU6UKO?=
 =?us-ascii?Q?HLAZti8xm0W5jh5n2fnT8Tq3l2txVnJe+o46JXPvJ2rpozHx1+I4mwfPZolO?=
 =?us-ascii?Q?9cDCPKH/YCriA5jXe8pxnQ4Zq5EznXd0o+DQv81mf9H+nWFCh+EFlbgIE5B1?=
 =?us-ascii?Q?fFnUj6c2P5D+z4ipTPgHgZAKhbZBT3UcDGkgA9/tnV5LHcQt2pNt5C0Bamrd?=
 =?us-ascii?Q?nY8hhIQDbA4J/bNjfIU6KdljXISP9AwFkIlY03CeOsN2RT9Ge1ZQkHybMv2X?=
 =?us-ascii?Q?ozvHzwRfdzEvHCxSxgrh8+IVO0Qtgq0p7nZMl50wJZSRxEOLSoGpLmzDxquo?=
 =?us-ascii?Q?7FGQlgxWM3DIFMcXQqCYDlwW4JgBpCYXukaiNQQYV4l7bZX7hT9SPG/pIT2Y?=
 =?us-ascii?Q?9hYBA+na4kj2NCJh/nPRTOaQQGq18GZfhDKXYalyI0uicqTHXzsmy4sLrgKo?=
 =?us-ascii?Q?Z2ZEgXui01BDd6CHjxQvTk51IizwNtbsVQRWqKMoyIHJynemK/gDKgc+Tnpw?=
 =?us-ascii?Q?eWOsfvm8R+NKrC/PRN4yzsYTSf3Jny2W4aGApeVW8zr7Jjyavkrb5S9wycDA?=
 =?us-ascii?Q?Rm9SS+qEdCDv3tFwmDgaPFDEELLrUS7pljHizyKXBrhuytiPoPNtmiM22Ye9?=
 =?us-ascii?Q?bWv1KZv2DPK2jdGkM429gOjNHng6DmrAz9N+D2oOg7L18CW0VE2f5pODGDIa?=
 =?us-ascii?Q?BBXOWr+ice7Dl6pXP36juz9JDKDsVnDBV58V+Xyq7giQdCmWNU0HKhiJJZ4t?=
 =?us-ascii?Q?W9Iif6xybozrHv3pLbO/52i5WAGN/BA09ZLWxKZ23eEn617y9J64ABETvdtK?=
 =?us-ascii?Q?9ceuR9F9nckHkhKv0/El5npyIVSVSpPDz0qllXqSAnTZLikWwVWtDIOF8mKy?=
 =?us-ascii?Q?9GbP4n7F9txsVIRUUwhnSE6twKDGpUeg1FsQnJVJg/hl0b0lZVYeO0KJ6Ibc?=
 =?us-ascii?Q?6Jz9ytyh0UfK2BlaIvAQ7PbIoQY7kiz+ZH01klb4siAoGZDtEyf50raZnpLU?=
 =?us-ascii?Q?GY9u1VUlvym+YWy9YWPfpyfsY3t4vmts2dQw6OUNfciMLBITuDusbBLfRigu?=
 =?us-ascii?Q?uK5+ZhSGsLYpGC521I6q12bCOGaRbis67RZ8u97MVYMJgdCe9jkv4IRRhBwe?=
 =?us-ascii?Q?5RZaYF8fpGAc93fdp/ouhUr78/9+IsBRIhlRo86P9qCmteNbomxr/wjDpu0l?=
 =?us-ascii?Q?/Pty2GwMO5y3fUCRK3x+n1Ty33uM6n0QWXwvVoAJzYbsCFAEQUXcTrE2AWei?=
 =?us-ascii?Q?HG17pfeLvpk=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 15:26:52.6706 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f79cd4ab-f0de-4939-7342-08dd4f67816f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8034
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

From: "chr[]" <chris@rudorff.com>

resume and irq handler happily races in set_power_state()

* amdgpu_legacy_dpm_compute_clocks() needs lock
* protect irq work handler
* fix dpm_enabled usage

v2: fix clang build, integrate Lijo's comments (Alex)

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/2524
Fixes: 3712e7a49459 ("drm/amd/pm: unified lock protections in amdgpu_dpm.c")
Tested-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name> # on Oland PRO
Signed-off-by: chr[] <chris@rudorff.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c    | 25 +++++++++++++-----
 .../gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c    |  8 ++++--
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c    | 26 ++++++++++++++-----
 3 files changed, 45 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
index 67a8e22b1126d..e237ea1185a71 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
@@ -3042,6 +3042,7 @@ static int kv_dpm_hw_init(struct amdgpu_ip_block *ip_block)
 	if (!amdgpu_dpm)
 		return 0;
 
+	mutex_lock(&adev->pm.mutex);
 	kv_dpm_setup_asic(adev);
 	ret = kv_dpm_enable(adev);
 	if (ret)
@@ -3049,6 +3050,8 @@ static int kv_dpm_hw_init(struct amdgpu_ip_block *ip_block)
 	else
 		adev->pm.dpm_enabled = true;
 	amdgpu_legacy_dpm_compute_clocks(adev);
+	mutex_unlock(&adev->pm.mutex);
+
 	return ret;
 }
 
@@ -3066,32 +3069,42 @@ static int kv_dpm_suspend(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
 
+	cancel_work_sync(&adev->pm.dpm.thermal.work);
+
 	if (adev->pm.dpm_enabled) {
+		mutex_lock(&adev->pm.mutex);
+		adev->pm.dpm_enabled = false;
 		/* disable dpm */
 		kv_dpm_disable(adev);
 		/* reset the power state */
 		adev->pm.dpm.current_ps = adev->pm.dpm.requested_ps = adev->pm.dpm.boot_ps;
+		mutex_unlock(&adev->pm.mutex);
 	}
 	return 0;
 }
 
 static int kv_dpm_resume(struct amdgpu_ip_block *ip_block)
 {
-	int ret;
+	int ret = 0;
 	struct amdgpu_device *adev = ip_block->adev;
 
-	if (adev->pm.dpm_enabled) {
+	if (!amdgpu_dpm)
+		return 0;
+
+	if (!adev->pm.dpm_enabled) {
+		mutex_lock(&adev->pm.mutex);
 		/* asic init will reset to the boot state */
 		kv_dpm_setup_asic(adev);
 		ret = kv_dpm_enable(adev);
-		if (ret)
+		if (ret) {
 			adev->pm.dpm_enabled = false;
-		else
+		} else {
 			adev->pm.dpm_enabled = true;
-		if (adev->pm.dpm_enabled)
 			amdgpu_legacy_dpm_compute_clocks(adev);
+		}
+		mutex_unlock(&adev->pm.mutex);
 	}
-	return 0;
+	return ret;
 }
 
 static bool kv_dpm_is_idle(void *handle)
diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c
index e861355ebd75b..c7518b13e7879 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c
@@ -1009,9 +1009,12 @@ void amdgpu_dpm_thermal_work_handler(struct work_struct *work)
 	enum amd_pm_state_type dpm_state = POWER_STATE_TYPE_INTERNAL_THERMAL;
 	int temp, size = sizeof(temp);
 
-	if (!adev->pm.dpm_enabled)
-		return;
+	mutex_lock(&adev->pm.mutex);
 
+	if (!adev->pm.dpm_enabled) {
+		mutex_unlock(&adev->pm.mutex);
+		return;
+	}
 	if (!pp_funcs->read_sensor(adev->powerplay.pp_handle,
 				   AMDGPU_PP_SENSOR_GPU_TEMP,
 				   (void *)&temp,
@@ -1033,4 +1036,5 @@ void amdgpu_dpm_thermal_work_handler(struct work_struct *work)
 	adev->pm.dpm.state = dpm_state;
 
 	amdgpu_legacy_dpm_compute_clocks(adev->powerplay.pp_handle);
+	mutex_unlock(&adev->pm.mutex);
 }
diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
index a87dcf0974bc1..d6dfe2599ebea 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
@@ -7786,6 +7786,7 @@ static int si_dpm_hw_init(struct amdgpu_ip_block *ip_block)
 	if (!amdgpu_dpm)
 		return 0;
 
+	mutex_lock(&adev->pm.mutex);
 	si_dpm_setup_asic(adev);
 	ret = si_dpm_enable(adev);
 	if (ret)
@@ -7793,6 +7794,7 @@ static int si_dpm_hw_init(struct amdgpu_ip_block *ip_block)
 	else
 		adev->pm.dpm_enabled = true;
 	amdgpu_legacy_dpm_compute_clocks(adev);
+	mutex_unlock(&adev->pm.mutex);
 	return ret;
 }
 
@@ -7810,32 +7812,44 @@ static int si_dpm_suspend(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
 
+	cancel_work_sync(&adev->pm.dpm.thermal.work);
+
 	if (adev->pm.dpm_enabled) {
+		mutex_lock(&adev->pm.mutex);
+		adev->pm.dpm_enabled = false;
 		/* disable dpm */
 		si_dpm_disable(adev);
 		/* reset the power state */
 		adev->pm.dpm.current_ps = adev->pm.dpm.requested_ps = adev->pm.dpm.boot_ps;
+		mutex_unlock(&adev->pm.mutex);
 	}
+
 	return 0;
 }
 
 static int si_dpm_resume(struct amdgpu_ip_block *ip_block)
 {
-	int ret;
+	int ret = 0;
 	struct amdgpu_device *adev = ip_block->adev;
 
-	if (adev->pm.dpm_enabled) {
+	if (!amdgpu_dpm)
+		return 0;
+
+	if (!adev->pm.dpm_enabled) {
 		/* asic init will reset to the boot state */
+		mutex_lock(&adev->pm.mutex);
 		si_dpm_setup_asic(adev);
 		ret = si_dpm_enable(adev);
-		if (ret)
+		if (ret) {
 			adev->pm.dpm_enabled = false;
-		else
+		} else {
 			adev->pm.dpm_enabled = true;
-		if (adev->pm.dpm_enabled)
 			amdgpu_legacy_dpm_compute_clocks(adev);
+		}
+		mutex_unlock(&adev->pm.mutex);
 	}
-	return 0;
+
+	return ret;
 }
 
 static bool si_dpm_is_idle(void *handle)
-- 
2.48.1

