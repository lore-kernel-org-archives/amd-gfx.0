Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57388E7718D
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Dec 2024 08:08:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED04410E36E;
	Wed, 25 Dec 2024 08:08:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Ct9+ONmT";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2071.outbound.protection.outlook.com [40.107.244.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DBC410E36E
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Dec 2024 08:08:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Taskzb55BF0DyMfELeFCL40sXjGkywA9uU8hqFDPCORkMDzeo3EYBrs5DhiYabUTkU2tPt0CB4muPhBEV+KChjARIBOqwc8bN9bNB3ogEv0pVLVXxUiU7lldSS47uPXrRWjBrvAxLuWQFiSlvPDH1LWZLzpBdmWmEU28cnA2CSvXmM6y7veu2TuTUCFdiYkyGyQS5Pt8NLNrDD4XDkqbmlifbYisFrB7dCpkFTtuSwNQa1LI37DNwxbz0cgp4K8js2qZD8OzzlZXX9pSKs2koWkLVK2esqVMletJ2ym36taadMVG5TVRKCnYej2FWnxTttg4x83+x6CWdYUiJ15R3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FKAPrm34QQuJ0fRI3XuU6oeaSXqM8GZSpSOgtQC1ZIQ=;
 b=q7F9ckiYLEnqX325r1byQ/emjKs0Ad3m6/mIX6p2YJ9vemsiO9QWwFkh2fjsG7kmjsbvcQBspF9Exlqq5yu+QxVNqDC9mBEOZk6mvYksihkWEtyHnDu2ANXvPkzt+Ukco+Cix72cMLo0qAbASLewCHq6oJJxHBUceXuyzrS0m68TKOdL45p8ejH7l6pc11rJJDJRk999ifuEkjnYeZN6mJa6jGjP0sx3BSldncQFagWlKFF4ustsMfjosXvdebaSoPZE2rt9diydLsROULGPKnEbDO66s+ehIwrfW3api7ocQq5bbu/R15RdZiZ/IzXjhykP+1CQcu1sDhLoxESOoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FKAPrm34QQuJ0fRI3XuU6oeaSXqM8GZSpSOgtQC1ZIQ=;
 b=Ct9+ONmTs7SwTRQXcNowohlyyC/7WckB5RSAJOlUXs1xYa3tPaGNxKOniwKQwESzj8jIXP27jXmNcsHn3i53rTIJ9wu9yoe4CaFZJDelCpU1HA+jrnCnW5odRUOJolhF+t8tywDHWhoQKH6jkLQ3ERIvF8JvHUhDfOODsDPlfzI=
Received: from BN9PR03CA0145.namprd03.prod.outlook.com (2603:10b6:408:fe::30)
 by SA1PR12MB8162.namprd12.prod.outlook.com (2603:10b6:806:33a::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.21; Wed, 25 Dec
 2024 08:08:24 +0000
Received: from BL02EPF00029929.namprd02.prod.outlook.com
 (2603:10b6:408:fe:cafe::1) by BN9PR03CA0145.outlook.office365.com
 (2603:10b6:408:fe::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.21 via Frontend Transport; Wed,
 25 Dec 2024 08:08:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00029929.mail.protection.outlook.com (10.167.249.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8293.12 via Frontend Transport; Wed, 25 Dec 2024 08:08:23 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 25 Dec
 2024 02:08:23 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 25 Dec
 2024 02:08:23 -0600
Received: from kenneth-mlse-vm.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via
 Frontend Transport; Wed, 25 Dec 2024 02:08:21 -0600
From: Kenneth Feng <kenneth.feng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <aurabindo.pillai@amd.com>, <alexander.deucher@amd.com>, Kenneth Feng
 <kenneth.feng@amd.com>
Subject: [PATCH 2/2] drm/amd/display: set the workload based on MALL status
Date: Wed, 25 Dec 2024 16:08:14 +0800
Message-ID: <20241225080814.1692482-2-kenneth.feng@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241225080814.1692482-1-kenneth.feng@amd.com>
References: <20241225080814.1692482-1-kenneth.feng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00029929:EE_|SA1PR12MB8162:EE_
X-MS-Office365-Filtering-Correlation-Id: e55b3afb-d717-4e38-174f-08dd24bb4dcc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/YxMJ8xUytRWBSi1JvfWfXLS2r1L7gykpZ2xQNBH607s80vt6bLGKqk5Eek/?=
 =?us-ascii?Q?g7MLzbd9RguPee0RZAKlV4hwIGdeKDMGmOxgHDlWWv4XlICTn+u1QuG0fLhL?=
 =?us-ascii?Q?PwqDzX8VoYsAApNXddu8KefkTLmaBaH1Xd5lR5NzUN7LYygo3g4pjCIPURhb?=
 =?us-ascii?Q?0nAhnu4IDDYG8xuUTil5QDc8Z+9Xphpp2xacHvoyUZ5Em9j1y/gtSUhtdKAf?=
 =?us-ascii?Q?iGuSbJpCALpjrkx5Jdbtwi3pXRPf9tAll2GVzKeEygYJr2Lj5hwmiWIMGYow?=
 =?us-ascii?Q?l5Gw7b1b9/rQUYbCF3Wa5m0QCIyDtXTM7giPAe306xWTWZGhBlWnHypSjuP9?=
 =?us-ascii?Q?m7EuaoGfiSkQxwJ/Wat/eISqI1mCiI6hFXkml9wfEyp5OreY2HIiI5COMtVi?=
 =?us-ascii?Q?r72/ZrquLS234b0P3QYGEeVdi4wieX883lITHhoGEEeDGdboBsPrqu6Jz/mg?=
 =?us-ascii?Q?BS0ERgLqNMRjt58IqRCaZFw8z42ScO0l2pK9i2ZYqBz5rwbchm/zcJQ/cUSt?=
 =?us-ascii?Q?FpWg4jUnVWrtWdGrhZOwcVGb/X+RbrgsaUQ/sJmTzLPj1kkFbUVuMkKVvRI7?=
 =?us-ascii?Q?b7ZXRryAfYU+dMmxr8tstzsGQyhKKsft6V7GUsgu2JdJjnaNgfJyuB8O0Mmm?=
 =?us-ascii?Q?8UVbZBqCbqKJLi5b119WkscrUFK8Az+31nRv3aCD4R0PCHruFvOM/WgXTBKC?=
 =?us-ascii?Q?O7YfQWcK/zJGNOVkwMEpEvkllL3puk96+yhPCyVd5VRmTU9UGyj/uV8mKFky?=
 =?us-ascii?Q?18RuYWTN9at0aM8RMxGgjuPn1KWivhM3diQIaBzbS5AJE8s7R4ev+lO764+k?=
 =?us-ascii?Q?o7v9+uhLgwT++08nHaXNdJv7toMN1NJ7GYrXfFtjuyha0ZHLj1yQt2aZ8uII?=
 =?us-ascii?Q?8Syl0h779CMDX/1UYiEP5AAHR7hvIXepgrn11lo+L4zUrZvNRYEydd7evD1M?=
 =?us-ascii?Q?VGHa9SzzihbTBG1pY7vB310BpsDJ8vhYDPMTcgjU4oU4VvYmHIrsPbN4o0kN?=
 =?us-ascii?Q?vWT+r3jMRzscURe/AmLkSe66yLA7AFOk9dvRt79NH6SqFtyEaFl3dBvBLyqb?=
 =?us-ascii?Q?FC870CqqabIF5HhKNZWMpSuycPFHTGrFaiGkTkhndVc7o0EjxrciaLPNrKxU?=
 =?us-ascii?Q?qP/uNRU45mLj5uTyMRwrHVuvCuLcl1nOK5ZMP0aG5lpaZqEHsQyt1+nuvX67?=
 =?us-ascii?Q?I9W31Wq9RbibjaFQxp15hk0ySVZSBKnArrXdKg0jSp8CqVJrCR3P4B+1dUM9?=
 =?us-ascii?Q?GmwUJBzhUivTBqAlTFwY+CohVW2BZvxHWlFREnqXcMbIzcjmYVxGCNlVEdG5?=
 =?us-ascii?Q?s+SCT/kun1XhCvwdnQp73NoChPjH4lijho0UWmXed5vF0Ds3XuxitJauOWDB?=
 =?us-ascii?Q?vhlzaTz1X0vlDnU3yXmOkSAsys1htZ+CuwFICl5Q96SbefbdvUSb0XDu55RG?=
 =?us-ascii?Q?FhbuDWGrPkF/lW6gqEPYV01e1nRYYXZIgHhYDt8FeMYQzV+wuvG+cSIqi+Sy?=
 =?us-ascii?Q?KY1owJqaawR6cto=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Dec 2024 08:08:23.8402 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e55b3afb-d717-4e38-174f-08dd24bb4dcc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00029929.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8162
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

set the workload based on MALL status

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
index 8bc73922e3a6..c569c8b4bdf9 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
@@ -244,6 +244,8 @@ static void amdgpu_dm_crtc_vblank_control_worker(struct work_struct *work)
 	struct vblank_control_work *vblank_work =
 		container_of(work, struct vblank_control_work, work);
 	struct amdgpu_display_manager *dm = vblank_work->dm;
+	struct amdgpu_device *adev = dm->adev;
+	int ret;
 
 	mutex_lock(&dm->dc_lock);
 
@@ -252,8 +254,14 @@ static void amdgpu_dm_crtc_vblank_control_worker(struct work_struct *work)
 	else if (dm->active_vblank_irq_count)
 		dm->active_vblank_irq_count--;
 
-	if (dm->active_vblank_irq_count > 0)
+	if (dm->active_vblank_irq_count > 0) {
+		ret = amdgpu_dpm_set_and_save_bootup_power_profile(adev, false);
+		if (ret) {
+			dev_err(adev->dev, "(%d) failed to exit bootup workload\n", ret);
+			return;
+		}
 		dc_allow_idle_optimizations(dm->dc, false);
+	}
 
 	/*
 	 * Control PSR based on vblank requirements from OS
@@ -271,8 +279,14 @@ static void amdgpu_dm_crtc_vblank_control_worker(struct work_struct *work)
 			vblank_work->acrtc->dm_irq_params.allow_sr_entry);
 	}
 
-	if (dm->active_vblank_irq_count == 0)
+	if (dm->active_vblank_irq_count == 0) {
+		ret = amdgpu_dpm_set_and_save_bootup_power_profile(adev, true);
+		if (ret) {
+			dev_err(adev->dev, "(%d) failed to set bootup workload\n", ret);
+			return;
+		}
 		dc_allow_idle_optimizations(dm->dc, true);
+	}
 
 	mutex_unlock(&dm->dc_lock);
 
-- 
2.34.1

