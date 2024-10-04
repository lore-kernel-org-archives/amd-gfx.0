Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 019A5CF8854
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Oct 2024 18:45:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EFED310EA96;
	Fri,  4 Oct 2024 18:45:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4DRMGvQq";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2049.outbound.protection.outlook.com [40.107.236.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 65F0110EA90
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Oct 2024 18:45:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J+VGejCppIy4gDsTTezb2HsW0IQPhHlL834v+31iykKz+qKU6L1v0g1zPqyaMKDxlAYiqhowny5xbQEaZiETuiYPSxRlxwag6/ImD0CvDAETyLBmGSrI6tdr31sQ0Q4sHgILKurRGEN7SMvBeY6t3AGRKV3bXMgWfeb3OdTGgRN3Eh58aNEujnIKKRyvJxnqSiqdQRGifgzHRei1zGu3IDjF1YuInLTmFwsDn6hqj8x0KrZZ/2dlaMlD6t0fEWkG1G7BCcYlSDH59mSbEaxWK3BB3t7VSKSPvm/+ZhRJu411ObMsPiEfePaydeCGuMO+2gLDy9ZEgzxUSpdBaYoYvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TFGwixck59Pbe42gNRP7hcc+ag25QJaiuoOsUNA14wU=;
 b=tu5sAQ7e4vc3YSCEWgOi1HpybdMwhQGzC7Qv54PUwuE0mxz517dFHluUUAeANyDz6O4Hv1YSNaQGwXyW3VstQQ2q1hrMfDt+Z/HtQqvjaFALa3BYU4QncXe+jVE35PHihprQKZQ2UWIVy1KUDRp+RQunarDG68Yf4jIDQhsN/nYKAkqgghmq9c/xyPiJ9kekQh8OM8QSS2Hoyi0C+GhAPGYiSLE2ojzEn4job6tIJNp6UyvbxvS+7vdHg7NXFf5AYUHjD1caKj50AnjVMbtfHHhS/W5CfaN379LNRRumHtMU0qFLfao95kel2WhVpEOPKKvAdDFBqsCUf/FLn7XpYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TFGwixck59Pbe42gNRP7hcc+ag25QJaiuoOsUNA14wU=;
 b=4DRMGvQq8fa70E7Cg9AMvRL2kbHerOFqSlgCmsR/aRrJGlG9qRlpZz1tisd2MNN6I2RZZ+uSO/NJa77WBn6D7zDd1GsHp6Uxemg82NtrKSG9YEozR3Vat907NJ8Ztyjy6shKZwKNg1WTCxMby+IBU4zKioCN29WhbH5u3EyDDe8=
Received: from MN0P220CA0012.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:52e::35)
 by SJ0PR12MB7006.namprd12.prod.outlook.com (2603:10b6:a03:486::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Fri, 4 Oct
 2024 18:45:05 +0000
Received: from MN1PEPF0000F0DF.namprd04.prod.outlook.com
 (2603:10b6:208:52e:cafe::3) by MN0P220CA0012.outlook.office365.com
 (2603:10b6:208:52e::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.19 via Frontend
 Transport; Fri, 4 Oct 2024 18:45:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0DF.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Fri, 4 Oct 2024 18:45:05 +0000
Received: from atitest-Rembrandt.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 4 Oct 2024 13:45:02 -0500
From: <boyuan.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <leo.liu@amd.com>,
 <christian.koenig@amd.com>, <alexander.deucher@amd.com>,
 <sunil.khatri@amd.com>
CC: Boyuan Zhang <boyuan.zhang@amd.com>
Subject: [PATCH 06/18] add inst to amdgpu_dpm_enable_vcn
Date: Fri, 4 Oct 2024 14:44:32 -0400
Message-ID: <20241004184444.435356-7-boyuan.zhang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241004184444.435356-1-boyuan.zhang@amd.com>
References: <20241004184444.435356-1-boyuan.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DF:EE_|SJ0PR12MB7006:EE_
X-MS-Office365-Filtering-Correlation-Id: e43e409d-4367-45be-a001-08dce4a4a9d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zPLUugc71oDzKZvj7ERuyvp7sDMUIFXuGBM/kp6BeVODIxousyz+83kyqEZO?=
 =?us-ascii?Q?jQnso/LFz60tagOcSpgYvDxwqD+TyVBdhzyuKt2KucRHo/VZchDZXXlrA9jL?=
 =?us-ascii?Q?nhmqMhnm1Mq592QUbPY11oyL3CYZtJBVbMLpKgpjN2uvGcKjhocHmJTXMTF4?=
 =?us-ascii?Q?2qp5aJuzCFy/K7n96GnXcjt0tIPzdJvL21aQE0Iw31CwKq7cp+g0+Le0fzr6?=
 =?us-ascii?Q?OYpLNrT2RVQm2uf3ci0faAYbYnU3GumnRedO6ZdeIQaV9kPM+Y2mDNYAEDwR?=
 =?us-ascii?Q?nfTKiCbKHJQThC2sdU8k05mxiSMtLJTNHVnEKuPWsP3w2YuV62X8CaPAtcdG?=
 =?us-ascii?Q?jDNmfhD6on+PO9bw1FS5mAoT+YVwGKgbjjTTmAQkzw+i6I3VNphhCPUHbSwD?=
 =?us-ascii?Q?bBG3VWieYozCh145pXXR3x0G/jK6hZ7VxH5/6wgQvDUSYMpeTC/0rJTSlmF0?=
 =?us-ascii?Q?EbQx1ChpSXDYRx3ugUGn0Nl8d+kvAp3E65qPRSxl592Wjdjmxa9iaWgxRztd?=
 =?us-ascii?Q?nQRENEI962b/VDgzygXgF4kCMv89av0i02NIB/07TP6TAKzXTqw+JEnKKvCC?=
 =?us-ascii?Q?haCn+1VMPsDXwS3JEgc5Ir+xVkJKDa4TvkfOlhUptUCboYddadwUqY7Y5b82?=
 =?us-ascii?Q?VVePfGxfU5IgLmyYaDPuz/QpzJEAx4dBgaA9fTRemcN/hMLc1YADz0vq+++6?=
 =?us-ascii?Q?ZXLNPI3uZvs+m1IAHzextcHgUdec6eg8XL1zt+nP8c76GDrmaaDZoWiW1UgS?=
 =?us-ascii?Q?4LdaM2Em2mJpddJRO/HkLTepg8b/JEBFiJorp91PG7TOTRsmJdGRZaAmtSBJ?=
 =?us-ascii?Q?wXXNlRRr2VGukdQQGE59YgLZ6CK/YfezzsLepiE7viqQVJVM3Zf/9Lj3fv8M?=
 =?us-ascii?Q?9mstRUZsUHJhIpcUw+3YXrdpIiUe8qTdPMCjk8loMkESDuvl8V8qXAha4Vre?=
 =?us-ascii?Q?znFWdEpG9pws5ruluEIwYDV6mPsIYOiA2xCjs+tPhhEHWV30d4azQVBVVfL+?=
 =?us-ascii?Q?O/XTDAnUhIne+x8pcrTlecVRJMI1gLQMP35dK0rwixHpo97o5yu1OFJq2UVD?=
 =?us-ascii?Q?FkOtfW6CAo29JH6aTdqOyfBtCTU/z79qjPsdMlGv6bn/BMGjS5UeR3CCP+PR?=
 =?us-ascii?Q?3nr9W//dNJ6x7GPs5WIBusMX9q+ehManitNW3rVKKXCz/anE1lEbXMSLsYVF?=
 =?us-ascii?Q?lwyCGP0MCQ2h6Gd4zPf27yTQu3BWhHi1nsfk8MvZ7KtXAc5zbr44BlhD6w6o?=
 =?us-ascii?Q?m5t45ztlzm6uPpEkl1LCHHaC6Zp1zJA9dEAkQH3mz3YubRkehFkJu2aIpHCz?=
 =?us-ascii?Q?qJURAnYfba0gAfm6fyZ5uejVaZX7UHZwuxQO3iLVchY4N2UaOuayOtfhZbhg?=
 =?us-ascii?Q?9CiH29g=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 18:45:05.3858 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e43e409d-4367-45be-a001-08dce4a4a9d6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7006
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

Add an instance parameter to amdgpu_dpm_enable_vcn() function, and change
all calls from vcn ip functions to add instance argument. vcn generations
with only one instance (v1.0, v2.0) always use 0 as instance number. vcn
generations with multiple instances (v2.5, v3.0, v4.0, v4.0.3, v4.0.5,
v5.0.0) use the actual instance number.

v2: remove for-loop in amdgpu_dpm_enable_vcn(), and temporarily move it
to vcn ip with multiple instances, in order to keep the exact same logic
as before, until further separation in next patch.

Signed-off-by: Boyuan Zhang <boyuan.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c   |  6 +++---
 drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c   |  4 ++--
 drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c   | 12 ++++++++----
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c   | 12 ++++++++----
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c   | 12 ++++++++----
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c | 12 ++++++++----
 drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c | 12 ++++++++----
 drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c | 12 ++++++++----
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c     | 12 +++++-------
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h |  2 +-
 10 files changed, 59 insertions(+), 37 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
index 746b3d282ca3..1d5b0f4e5b1a 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v1_0.c
@@ -303,7 +303,7 @@ static int vcn_v1_0_suspend(struct amdgpu_ip_block *ip_block)
 	idle_work_unexecuted = cancel_delayed_work_sync(&adev->vcn.idle_work);
 	if (idle_work_unexecuted) {
 		if (adev->pm.dpm_enabled)
-			amdgpu_dpm_enable_vcn(adev, false);
+			amdgpu_dpm_enable_vcn(adev, false, 0);
 	}
 
 	r = vcn_v1_0_hw_fini(ip_block);
@@ -1856,7 +1856,7 @@ static void vcn_v1_0_idle_work_handler(struct work_struct *work)
 	if (fences == 0) {
 		amdgpu_gfx_off_ctrl(adev, true);
 		if (adev->pm.dpm_enabled)
-			amdgpu_dpm_enable_vcn(adev, false);
+			amdgpu_dpm_enable_vcn(adev, false, 0);
 		else
 			amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,
 			       AMD_PG_STATE_GATE);
@@ -1886,7 +1886,7 @@ void vcn_v1_0_set_pg_for_begin_use(struct amdgpu_ring *ring, bool set_clocks)
 	if (set_clocks) {
 		amdgpu_gfx_off_ctrl(adev, false);
 		if (adev->pm.dpm_enabled)
-			amdgpu_dpm_enable_vcn(adev, true);
+			amdgpu_dpm_enable_vcn(adev, true, 0);
 		else
 			amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCN,
 			       AMD_PG_STATE_UNGATE);
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
index d0c3895dcf6b..d87e5505cf51 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_0.c
@@ -978,7 +978,7 @@ static int vcn_v2_0_start(struct amdgpu_device *adev)
 	int i, j, r;
 
 	if (adev->pm.dpm_enabled)
-		amdgpu_dpm_enable_vcn(adev, true);
+		amdgpu_dpm_enable_vcn(adev, true, 0);
 
 	if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG)
 		return vcn_v2_0_start_dpg_mode(adev, adev->vcn.indirect_sram);
@@ -1235,7 +1235,7 @@ static int vcn_v2_0_stop(struct amdgpu_device *adev)
 
 power_off:
 	if (adev->pm.dpm_enabled)
-		amdgpu_dpm_enable_vcn(adev, false);
+		amdgpu_dpm_enable_vcn(adev, false, 0);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
index d4c062983bfe..ad0922eb16c0 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v2_5.c
@@ -1012,8 +1012,10 @@ static int vcn_v2_5_start(struct amdgpu_device *adev)
 	uint32_t rb_bufsz, tmp;
 	int i, j, k, r;
 
-	if (adev->pm.dpm_enabled)
-		amdgpu_dpm_enable_vcn(adev, true);
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		if (adev->pm.dpm_enabled)
+			amdgpu_dpm_enable_vcn(adev, true, i);
+	}
 
 	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
 		if (adev->vcn.harvest_config & (1 << i))
@@ -1485,8 +1487,10 @@ static int vcn_v2_5_stop(struct amdgpu_device *adev)
 			~UVD_POWER_STATUS__UVD_POWER_STATUS_MASK);
 	}
 
-	if (adev->pm.dpm_enabled)
-		amdgpu_dpm_enable_vcn(adev, false);
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		if (adev->pm.dpm_enabled)
+			amdgpu_dpm_enable_vcn(adev, false, i);
+	}
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index 1da9a7dfb667..19c7f9cd4c15 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -1141,8 +1141,10 @@ static int vcn_v3_0_start(struct amdgpu_device *adev)
 	uint32_t rb_bufsz, tmp;
 	int i, j, k, r;
 
-	if (adev->pm.dpm_enabled)
-		amdgpu_dpm_enable_vcn(adev, true);
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		if (adev->pm.dpm_enabled)
+			amdgpu_dpm_enable_vcn(adev, true, i);
+	}
 
 	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
 		if (adev->vcn.harvest_config & (1 << i))
@@ -1632,8 +1634,10 @@ static int vcn_v3_0_stop(struct amdgpu_device *adev)
 		vcn_v3_0_enable_static_power_gating(adev, i);
 	}
 
-	if (adev->pm.dpm_enabled)
-		amdgpu_dpm_enable_vcn(adev, false);
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		if (adev->pm.dpm_enabled)
+			amdgpu_dpm_enable_vcn(adev, false, i);
+	}
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
index a04a64442809..e97d7f4ae371 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0.c
@@ -1088,8 +1088,10 @@ static int vcn_v4_0_start(struct amdgpu_device *adev)
 	uint32_t tmp;
 	int i, j, k, r;
 
-	if (adev->pm.dpm_enabled)
-		amdgpu_dpm_enable_vcn(adev, true);
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		if (adev->pm.dpm_enabled)
+			amdgpu_dpm_enable_vcn(adev, true, i);
+	}
 
 	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
 		if (adev->vcn.harvest_config & (1 << i))
@@ -1614,8 +1616,10 @@ static int vcn_v4_0_stop(struct amdgpu_device *adev)
 		vcn_v4_0_enable_static_power_gating(adev, i);
 	}
 
-	if (adev->pm.dpm_enabled)
-		amdgpu_dpm_enable_vcn(adev, false);
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		if (adev->pm.dpm_enabled)
+			amdgpu_dpm_enable_vcn(adev, false, i);
+	}
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index d433d2703995..ba22913398ec 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -1091,8 +1091,10 @@ static int vcn_v4_0_3_start(struct amdgpu_device *adev)
 	int i, j, k, r, vcn_inst;
 	uint32_t tmp;
 
-	if (adev->pm.dpm_enabled)
-		amdgpu_dpm_enable_vcn(adev, true);
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		if (adev->pm.dpm_enabled)
+			amdgpu_dpm_enable_vcn(adev, true, i);
+	}
 
 	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
 		if (adev->pg_flags & AMD_PG_SUPPORT_VCN_DPG) {
@@ -1365,8 +1367,10 @@ static int vcn_v4_0_3_stop(struct amdgpu_device *adev)
 		vcn_v4_0_3_enable_clock_gating(adev, i);
 	}
 Done:
-	if (adev->pm.dpm_enabled)
-		amdgpu_dpm_enable_vcn(adev, false);
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		if (adev->pm.dpm_enabled)
+			amdgpu_dpm_enable_vcn(adev, false, i);
+	}
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
index 133ebb3c14db..873672f64778 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_5.c
@@ -1000,8 +1000,10 @@ static int vcn_v4_0_5_start(struct amdgpu_device *adev)
 	uint32_t tmp;
 	int i, j, k, r;
 
-	if (adev->pm.dpm_enabled)
-		amdgpu_dpm_enable_vcn(adev, true);
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		if (adev->pm.dpm_enabled)
+			amdgpu_dpm_enable_vcn(adev, true, i);
+	}
 
 	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
 		if (adev->vcn.harvest_config & (1 << i))
@@ -1277,8 +1279,10 @@ static int vcn_v4_0_5_stop(struct amdgpu_device *adev)
 		vcn_v4_0_5_enable_static_power_gating(adev, i);
 	}
 
-	if (adev->pm.dpm_enabled)
-		amdgpu_dpm_enable_vcn(adev, false);
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		if (adev->pm.dpm_enabled)
+			amdgpu_dpm_enable_vcn(adev, false, i);
+	}
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
index c57894f1734a..893e66c2b9a5 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_0.c
@@ -761,8 +761,10 @@ static int vcn_v5_0_0_start(struct amdgpu_device *adev)
 	uint32_t tmp;
 	int i, j, k, r;
 
-	if (adev->pm.dpm_enabled)
-		amdgpu_dpm_enable_vcn(adev, true);
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		if (adev->pm.dpm_enabled)
+			amdgpu_dpm_enable_vcn(adev, true, i);
+	}
 
 	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
 		if (adev->vcn.harvest_config & (1 << i))
@@ -1008,8 +1010,10 @@ static int vcn_v5_0_0_stop(struct amdgpu_device *adev)
 		vcn_v5_0_0_enable_static_power_gating(adev, i);
 	}
 
-	if (adev->pm.dpm_enabled)
-		amdgpu_dpm_enable_vcn(adev, false);
+	for (i = 0; i < adev->vcn.num_vcn_inst; ++i) {
+		if (adev->pm.dpm_enabled)
+			amdgpu_dpm_enable_vcn(adev, false, i);
+	}
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index 8531e0993b17..5a9006bfc3cd 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -581,7 +581,7 @@ void amdgpu_dpm_enable_uvd(struct amdgpu_device *adev, bool enable)
 			  enable ? "enable" : "disable", ret);
 }
 
-void amdgpu_dpm_enable_vcn(struct amdgpu_device *adev, bool enable)
+void amdgpu_dpm_enable_vcn(struct amdgpu_device *adev, bool enable, int inst)
 {
 	int ret = 0;
 
@@ -599,12 +599,10 @@ void amdgpu_dpm_enable_vcn(struct amdgpu_device *adev, bool enable)
 		return;
 	}
 
-	for (int i = 0; i < adev->vcn.num_vcn_inst; i++) {
-		ret = amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_VCN, !enable, i);
-		if (ret)
-			DRM_ERROR("Dpm %s uvd failed, ret = %d. \n",
-				  enable ? "enable" : "disable", ret);
-	}
+	ret = amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_VCN, !enable, inst);
+	if (ret)
+		DRM_ERROR("Dpm %s uvd failed, ret = %d. \n",
+			  enable ? "enable" : "disable", ret);
 }
 
 void amdgpu_dpm_enable_vce(struct amdgpu_device *adev, bool enable)
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
index e7c84d4a431a..251b389dcf6e 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -442,7 +442,7 @@ void amdgpu_pm_acpi_event_handler(struct amdgpu_device *adev);
 
 void amdgpu_dpm_compute_clocks(struct amdgpu_device *adev);
 void amdgpu_dpm_enable_uvd(struct amdgpu_device *adev, bool enable);
-void amdgpu_dpm_enable_vcn(struct amdgpu_device *adev, bool enable);
+void amdgpu_dpm_enable_vcn(struct amdgpu_device *adev, bool enable, int inst);
 void amdgpu_dpm_enable_vce(struct amdgpu_device *adev, bool enable);
 void amdgpu_dpm_enable_jpeg(struct amdgpu_device *adev, bool enable);
 void amdgpu_dpm_enable_vpe(struct amdgpu_device *adev, bool enable);
-- 
2.34.1

