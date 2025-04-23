Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B77BEC369CB
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Apr 2025 09:34:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4388710E415;
	Wed, 23 Apr 2025 09:34:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dtiVfncf";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2060.outbound.protection.outlook.com [40.107.236.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0224C10E415
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Apr 2025 09:34:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Th+a8CTVK8J3mJ/tmIyvGfU3Cngp4b/ajefrBtd+JMHWLtaIGNazxTt7n/nJ31RiucSh/vdvW535Oxl58R58H5ANA1LfnGHS5MnPGEL69fOjInZ734rFWCd95D+gNmHUd5oMqbm4denhoeb9CmLka1aA1imElIpLUEvSWC2c+j0Ma4PFd0giDJDqzH5MhlO1gm7x5+ocvQyjl0L3kYNNhnBVs7uqO9NX8ia+aQTr+lNQKhXSbiUqcYPdL5svd8lBqmLYqk3WxPy+BA4+yQZ4XrRgYV3MXqVjvWUD/jJ2MaR/NXvNhA/06b1OmvqYQHphKnSP2BebOyxxCXGhYyn/jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J3Rv/TR8MbDmO/ssskaRoIV9uHvlm7YpH3PHQg4Rlww=;
 b=rFdNvqA4s2cRT0SE7FGvElC3nR+o/E4bZjWeoeDvrwMyGQswjgc5RuNVg9PQnc5sXzbmZZU8Gg01erD40gWhxnL8fl3tBFo37vHaj1OnQbH1T0CxST2iPSDRHZKBIYANOqorK7BuIqH5pNpcpxLlMEE4rfG0+zmnw7LXuoqgcXewMkSyldtHTrtsCqN468pPcgiBHc4CqOT9qKl070GAtU2E37FsShj0mpAriW8531oUt7RnWPu7T+qvHH3eYF1cwFlVHj6UU+Lf+jum3rd661BOlhW9P/jV06WQX8fbYIfIMrIWNvb9fBg/0krNplSav3tw95D6tLO73Ao/xAITDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J3Rv/TR8MbDmO/ssskaRoIV9uHvlm7YpH3PHQg4Rlww=;
 b=dtiVfncfNRaIQlk5dqG4EAF+0vY0cBvgA8EvAu7j1h7lgp4gv5J1xEZd7mD5YydtQMJvF8+C5WQt31qI3p3yCr7C3Q0hLwAS0uMPbPdH0vaWDeUC/cx2OJmAFefmGl5omNGH98Qj8I6vyGG/a4kYb0qGlEjpim1B/rECb7DHHv4=
Received: from DS7PR05CA0057.namprd05.prod.outlook.com (2603:10b6:8:2f::21) by
 MN2PR12MB4423.namprd12.prod.outlook.com (2603:10b6:208:24f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.22; Wed, 23 Apr
 2025 09:34:35 +0000
Received: from DS2PEPF00003445.namprd04.prod.outlook.com
 (2603:10b6:8:2f:cafe::f1) by DS7PR05CA0057.outlook.office365.com
 (2603:10b6:8:2f::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.18 via Frontend Transport; Wed,
 23 Apr 2025 09:34:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003445.mail.protection.outlook.com (10.167.17.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Wed, 23 Apr 2025 09:34:34 +0000
Received: from rtg-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 23 Apr 2025 04:34:31 -0500
From: Arvind Yadav <Arvind.Yadav@amd.com>
To: <Christian.Koenig@amd.com>, <alexander.deucher@amd.com>,
 <sunil.khatri@amd.com>, <Arunpravin.PaneerSelvam@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Arvind Yadav <Arvind.Yadav@amd.com>,
 Christian Koenig <christian.koenig@amd.com>
Subject: [PATCH v2] drm/amdgpu: remove DRM_AMDGPU_NAVI3X_USERQ config for UQ
Date: Wed, 23 Apr 2025 15:03:59 +0530
Message-ID: <20250423093359.4424-1-Arvind.Yadav@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003445:EE_|MN2PR12MB4423:EE_
X-MS-Office365-Filtering-Correlation-Id: a9e28dd9-3171-43c1-34f3-08dd824a0f13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Tml/AJf8LnC/7GXAJd7GhTAdNijWJ2gUfIvC2qVzwTgVpPabHN3apJD8sEI3?=
 =?us-ascii?Q?xBOrYvhjjskKRY8lhFnwfXsl1rbe0u9YZi2fCy/8sKE1tsUi13bCdH+J7Q1c?=
 =?us-ascii?Q?GCG6SUrAKPa5QIMYGPygE32vVtz256d51kbJX3XhMQvqNr2ai1NXL6KyJz+7?=
 =?us-ascii?Q?pNiNRmHqItpccOmQ+l1eLRVwk9QKQwtOWGtLO2EwXG6R7x331Q8YRnqoEeAK?=
 =?us-ascii?Q?F9RDKPZZ7K5OjnHUzTOaCFLcxmzQxYzJ8DDFtuZ21/A3ldUxmWr+8wNbMgRx?=
 =?us-ascii?Q?Fr5IJBJ+8X7yVZvZyxL+EkIfkVDb6srLtrCU5bPbsc+hPtVPC09seaS3wk5I?=
 =?us-ascii?Q?UIUvpL9cTtXlGk99qmpWUbRcqWiyVFbdttKuF97ofJGTz7V5/JdKQXI64hoz?=
 =?us-ascii?Q?eVKblqBvGH0ehmPKUbKGJjOt62Io+YQ6ivlYRwv+qKFI4qr4YJML7TGQFP7F?=
 =?us-ascii?Q?B8uCF+UUmPAvULTCL3MdzTAwVncRRuk8G9Aq9ZGLOiT6jkfm1Ss2MmhUbaB0?=
 =?us-ascii?Q?mzx2tmRpzmGg0Xw1om5mDCenbSSUCzOWRN969GajYb2pCphP3Q1pLQb4P8VL?=
 =?us-ascii?Q?EJad2SwF6V1IEGLSyMzOavrf2Evm1omFs2nLhx7k41Awh8JMCWlXQW6LzLp+?=
 =?us-ascii?Q?fSHMIadEfyY+rJyRaOnHFFES539oLsx3UfWLGpHnpQdph7upo+B/5gYTmuri?=
 =?us-ascii?Q?xlFB+2GofFEe8X9Mth+d0IH+YIMlpwMiBeoHnkUELNBObD1XD4u7XKM7PTVU?=
 =?us-ascii?Q?duOpybDqo3RdIgQa93fo/W6U0X4l+fgIY/0PzkIHu2Gw/kzefLozTvZbz+df?=
 =?us-ascii?Q?j4qedIs9aQybPtsoD2Pg9Jr5kDZsamOkLiiPMkkVjwrNoDFEqAuM0MCG4Ktn?=
 =?us-ascii?Q?JW2k0Db/x+Z4SJFKlO2wm9ZBV485knCxFfEYMQriwFfWAVKnteXnR6TFOdpG?=
 =?us-ascii?Q?spwFn4as/q+xYHwL1woeHDFndSitDN9LdXzwNJYrjlP0GfY4nlsqC1uDyS7H?=
 =?us-ascii?Q?hU3z9Ggj1s/OzH2jEn2nQgs7MpNfFtDvAW8gh8iNfw9a4TASpPANjWd2Fk3l?=
 =?us-ascii?Q?db8bUDvnXBngTll0wrF77nwaScSgzBYb5uKWX2/T4vbq4BNSRcanOcOFOM3N?=
 =?us-ascii?Q?QdDk6jfuU+33KoVJEmzbb2hIkHTF3wvXsOhm/pj3SjdHZgva/1goJt5BuuQz?=
 =?us-ascii?Q?mxHIZOIqu9ObrAlRaOHri+I2rwbUmkk8ZtC2UD2uDTrYJeFCvocMUnOlkIbD?=
 =?us-ascii?Q?D+Lbilbg3exzTOmSFbDz5sQX64wysAb43fF6FK3xOsAvR05oim62nMWM0812?=
 =?us-ascii?Q?ZSEcCE0h5znFvEeoqb+eHCEbrXEZOZL5XsXWFfgPEFaXuoZRMAsE9R1P49CE?=
 =?us-ascii?Q?7m3nQ3V2UGMqV6ip/hX5/keyNNm0dIHWcycbY+oSu3ntrpFUfnDTVuTtLBuZ?=
 =?us-ascii?Q?CEd2d4IZL7vz/NSuaolOaC9zso8SHni+TmFvyG8JGc45OYQYlr2/SriADbSN?=
 =?us-ascii?Q?zMGhwcivpZhwmxAMRU6qfD6dFlxlZr887Qr2?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2025 09:34:34.7804 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9e28dd9-3171-43c1-34f3-08dd824a0f13
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003445.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4423
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

DRM_AMDGPU_NAVI3X_USERQ config support is not required for
usermode queue.

v2: rebase.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian Koenig <christian.koenig@amd.com>
Cc: Sunil Khatri <sunil.khatri@amd.com>
Cc: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
Signed-off-by: Arvind Yadav <Arvind.Yadav@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Kconfig             |  8 --------
 drivers/gpu/drm/amd/amdgpu/Makefile            |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c     |  7 +------
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c        |  5 +----
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c      |  8 --------
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c    | 18 ------------------
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c         |  4 ----
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c         |  2 --
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c         |  3 +--
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c         |  3 ---
 10 files changed, 4 insertions(+), 56 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/Kconfig b/drivers/gpu/drm/amd/amdgpu/Kconfig
index 7b95221d2f3d..1a11cab741ac 100644
--- a/drivers/gpu/drm/amd/amdgpu/Kconfig
+++ b/drivers/gpu/drm/amd/amdgpu/Kconfig
@@ -96,14 +96,6 @@ config DRM_AMDGPU_WERROR
 	  Add -Werror to the build flags for amdgpu.ko.
 	  Only enable this if you are warning code for amdgpu.ko.
 
-config DRM_AMDGPU_NAVI3X_USERQ
-	bool "Enable amdgpu usermode queues"
-	depends on DRM_AMDGPU
-	default n
-	help
-	  Choose this option to enable GFX usermode queue support for GFX/SDMA/Compute
-          workload submission. This feature is experimental and supported on GFX11+.
-
 source "drivers/gpu/drm/amd/acp/Kconfig"
 source "drivers/gpu/drm/amd/display/Kconfig"
 source "drivers/gpu/drm/amd/amdkfd/Kconfig"
diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index 8595e05c691b..87080c06e5fc 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -177,7 +177,7 @@ amdgpu-y += \
 	mes_v12_0.o \
 
 # add GFX userqueue support
-amdgpu-$(CONFIG_DRM_AMDGPU_NAVI3X_USERQ) += mes_userqueue.o
+amdgpu-y += mes_userqueue.o
 
 # add UVD block
 amdgpu-y += \
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index b96e0613ea7e..fe68ba9997ae 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3513,9 +3513,7 @@ static int amdgpu_device_ip_fini_early(struct amdgpu_device *adev)
 	amdgpu_device_set_cg_state(adev, AMD_CG_STATE_UNGATE);
 
 	amdgpu_amdkfd_suspend(adev, false);
-#ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
 	amdgpu_userq_suspend(adev);
-#endif
 
 	/* Workaround for ASICs need to disable SMC first */
 	amdgpu_device_smu_fini_early(adev);
@@ -5086,9 +5084,7 @@ int amdgpu_device_suspend(struct drm_device *dev, bool notify_clients)
 
 	if (!adev->in_s0ix) {
 		amdgpu_amdkfd_suspend(adev, adev->in_runpm);
-#ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
 		amdgpu_userq_suspend(adev);
-#endif
 	}
 
 	r = amdgpu_device_evict_resources(adev);
@@ -5156,11 +5152,10 @@ int amdgpu_device_resume(struct drm_device *dev, bool notify_clients)
 		r = amdgpu_amdkfd_resume(adev, adev->in_runpm);
 		if (r)
 			goto exit;
-#ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
+
 		r = amdgpu_userq_resume(adev);
 		if (r)
 			goto exit;
-#endif
 	}
 
 	r = amdgpu_device_ip_late_init(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index cb9ffb17ab98..cc5d6250ac69 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -1980,9 +1980,7 @@ static void amdgpu_gfx_kfd_sch_ctrl(struct amdgpu_device *adev, u32 idx,
 		if (adev->gfx.userq_sch_req_count[idx] == 0) {
 			cancel_delayed_work_sync(&adev->gfx.enforce_isolation[idx].work);
 			if (!adev->gfx.userq_sch_inactive[idx]) {
-#ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
 				amdgpu_userq_stop_sched_for_enforce_isolation(adev, idx);
-#endif
 				if (adev->kfd.init_complete)
 					amdgpu_amdkfd_stop_sched(adev, idx);
 				adev->gfx.userq_sch_inactive[idx] = true;
@@ -2040,9 +2038,8 @@ void amdgpu_gfx_enforce_isolation_handler(struct work_struct *work)
 		/* Tell KFD to resume the runqueue */
 		WARN_ON_ONCE(!adev->gfx.userq_sch_inactive[idx]);
 		WARN_ON_ONCE(adev->gfx.userq_sch_req_count[idx]);
-#ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
+
 		amdgpu_userq_start_sched_for_enforce_isolation(adev, idx);
-#endif
 		if (adev->kfd.init_complete)
 			amdgpu_amdkfd_start_sched(adev, idx);
 		adev->gfx.userq_sch_inactive[idx] = false;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index b0e8098a3988..451890ee3fb7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -129,7 +129,6 @@ amdgpu_userq_active(struct amdgpu_userq_mgr *uq_mgr)
 	return ret;
 }
 
-#ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
 static struct amdgpu_usermode_queue *
 amdgpu_userq_find(struct amdgpu_userq_mgr *uq_mgr, int qid)
 {
@@ -520,13 +519,6 @@ int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
 
 	return r;
 }
-#else
-int amdgpu_userq_ioctl(struct drm_device *dev, void *data,
-		       struct drm_file *filp)
-{
-	return -ENOTSUPP;
-}
-#endif
 
 static int
 amdgpu_userq_restore_all(struct amdgpu_userq_mgr *uq_mgr)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index be068e8e37d1..3288c2ff692e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -216,7 +216,6 @@ void amdgpu_userq_fence_driver_put(struct amdgpu_userq_fence_driver *fence_drv)
 	kref_put(&fence_drv->refcount, amdgpu_userq_fence_driver_destroy);
 }
 
-#ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
 static int amdgpu_userq_fence_alloc(struct amdgpu_userq_fence **userq_fence)
 {
 	*userq_fence = kmem_cache_alloc(amdgpu_userq_fence_slab, GFP_ATOMIC);
@@ -288,7 +287,6 @@ static int amdgpu_userq_fence_create(struct amdgpu_usermode_queue *userq,
 
 	return 0;
 }
-#endif
 
 static const char *amdgpu_userq_fence_get_driver_name(struct dma_fence *f)
 {
@@ -343,7 +341,6 @@ static const struct dma_fence_ops amdgpu_userq_fence_ops = {
 	.release = amdgpu_userq_fence_release,
 };
 
-#ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
 /**
  * amdgpu_userq_fence_read_wptr - Read the userq wptr value
  *
@@ -594,15 +591,7 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
 
 	return r;
 }
-#else
-int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
-			      struct drm_file *filp)
-{
-	return -ENOTSUPP;
-}
-#endif
 
-#ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
 int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
 			    struct drm_file *filp)
 {
@@ -968,10 +957,3 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
 
 	return r;
 }
-#else
-int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
-			    struct drm_file *filp)
-{
-	return -ENOTSUPP;
-}
-#endif
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index ac7ac58e25a6..519b82f77cff 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -1630,7 +1630,6 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
 	case IP_VERSION(11, 0, 0):
 	case IP_VERSION(11, 0, 2):
 	case IP_VERSION(11, 0, 3):
-#ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
 		if (!adev->gfx.disable_uq &&
 		    adev->gfx.me_fw_version  >= 2390 &&
 		    adev->gfx.pfp_fw_version >= 2530 &&
@@ -1639,7 +1638,6 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
 			adev->userq_funcs[AMDGPU_HW_IP_GFX] = &userq_mes_funcs;
 			adev->userq_funcs[AMDGPU_HW_IP_COMPUTE] = &userq_mes_funcs;
 		}
-#endif
 		break;
 	case IP_VERSION(11, 0, 1):
 	case IP_VERSION(11, 0, 4):
@@ -1647,13 +1645,11 @@ static int gfx_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
 	case IP_VERSION(11, 5, 1):
 	case IP_VERSION(11, 5, 2):
 	case IP_VERSION(11, 5, 3):
-#ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
 		/* add firmware version checks here */
 		if (0 && !adev->gfx.disable_uq) {
 			adev->userq_funcs[AMDGPU_HW_IP_GFX] = &userq_mes_funcs;
 			adev->userq_funcs[AMDGPU_HW_IP_COMPUTE] = &userq_mes_funcs;
 		}
-#endif
 		break;
 	default:
 		break;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index dfa0830a4eb1..f09d96bfee16 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -1416,7 +1416,6 @@ static int gfx_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
 	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
 	case IP_VERSION(12, 0, 0):
 	case IP_VERSION(12, 0, 1):
-#ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
 		if (!adev->gfx.disable_uq &&
 		    adev->gfx.me_fw_version  >= 2780 &&
 		    adev->gfx.pfp_fw_version >= 2840 &&
@@ -1425,7 +1424,6 @@ static int gfx_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
 			adev->userq_funcs[AMDGPU_HW_IP_GFX] = &userq_mes_funcs;
 			adev->userq_funcs[AMDGPU_HW_IP_COMPUTE] = &userq_mes_funcs;
 		}
-#endif
 		break;
 	default:
 		break;
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index 6bb36187a53d..da5b5d64f137 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -1363,11 +1363,10 @@ static int sdma_v6_0_sw_init(struct amdgpu_ip_block *ip_block)
 	else
 		DRM_ERROR("Failed to allocated memory for SDMA IP Dump\n");
 
-#ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
 	/* add firmware version checks here */
 	if (0 && !adev->sdma.disable_uq)
 		adev->userq_funcs[AMDGPU_HW_IP_DMA] = &userq_mes_funcs;
-#endif
+
 	r = amdgpu_sdma_sysfs_reset_mask_init(adev);
 	if (r)
 		return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
index 943c6446a0a7..befe013b11a7 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
@@ -1338,12 +1338,9 @@ static int sdma_v7_0_sw_init(struct amdgpu_ip_block *ip_block)
 	else
 		DRM_ERROR("Failed to allocated memory for SDMA IP Dump\n");
 
-#ifdef CONFIG_DRM_AMDGPU_NAVI3X_USERQ
 	/* add firmware version checks here */
 	if (0 && !adev->sdma.disable_uq)
 		adev->userq_funcs[AMDGPU_HW_IP_DMA] = &userq_mes_funcs;
-#endif
-
 
 	return r;
 }
-- 
2.34.1

