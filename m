Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97845CFC501
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Oct 2024 07:49:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3DD5210E3AE;
	Mon, 14 Oct 2024 07:49:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CC0oEokr";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2056.outbound.protection.outlook.com [40.107.95.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF18A10E3AE
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Oct 2024 07:49:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AOL95UsafEr1LE8Pj0oyX1gF50G32ST5dtlNlahEyG51jjGZ6BFQKI1LtYIq1No3VLQaJu4dvEyAB/dRkoeluLczX14bYBF4cqb/sK1yhzI6NrsmtrPWRg/pjoPTrjI+a8dSpDlZ8AYkWchPJAv306ucRTOuh+XW+pgDOLGW2CbxDMcCGDRZFWuNPgdAzAJRPv3ntD0dcnXDBL+kazJDg0PXdiyyeVJPbYK6KVwkA7npCF/ouMEgKqyg1gQCxBCgBahhHSNg+R1PNUpOlwFasRQezfjVQ/m4I0a9EqrL6khKiZ/3FUqJ6xUGI/UC5D5d2KlHV9+bRoMKOFy4gQi4XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=72uuzUdaQJwD5X10X71L1B5VMT5EO9njkb7Q/Z9DIOY=;
 b=t6peVRZsaNsuIYM2IqddudL5/O960hKMWEupZYsw6Gbx3h9ICQsFmCYg7JVu+MMRe24NixX7LcfIhw7esK5cJvDY/lcIz1pWxrlY3d8d0Q28Y8qc4B+wLgeYD9IHHRSrn05E/HhoRa7GpxOHqNKlPvN5K1HTbDi+geJ7CPvAKtH/YLpWyj14wFBdl/FXgR94TdiDqWUAWS0AzBrB3HjxRBEyJueVrDK7tN5lWD+yelKyduL6khDVWw4R9S6jXXoqUf0Io95x7bNoIgVL1YyM0QHfICW5mx2BzK76Mtgj4z60hJ+BC5fMCQCV0B72vyE7qT48L7eS3WFme8vg+MTNmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=72uuzUdaQJwD5X10X71L1B5VMT5EO9njkb7Q/Z9DIOY=;
 b=CC0oEokrMT9m5/YahP/TEV6VYfZvVQIU7FQS5iRZupsV6Z0EDvR3fSyxy7WSmXaDfCMdb79kSDCtAxL8v6y66/2tUWWnbyxAnZAvWeEfMHFyzpKltkV2Gy81ApUYFXyBnREhVphkCZXbJD2onAVcBht2WJ36Wht4T3/eLid1qpA=
Received: from DM6PR11CA0041.namprd11.prod.outlook.com (2603:10b6:5:14c::18)
 by IA0PR12MB8207.namprd12.prod.outlook.com (2603:10b6:208:401::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.25; Mon, 14 Oct
 2024 07:49:15 +0000
Received: from DS1PEPF00017090.namprd03.prod.outlook.com
 (2603:10b6:5:14c:cafe::33) by DM6PR11CA0041.outlook.office365.com
 (2603:10b6:5:14c::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26 via Frontend
 Transport; Mon, 14 Oct 2024 07:49:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017090.mail.protection.outlook.com (10.167.17.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Mon, 14 Oct 2024 07:49:14 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 14 Oct
 2024 02:49:13 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Lijo.Lazar@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH v2 2/2] drm/amdgpu: clean up the suspend_complete
Date: Mon, 14 Oct 2024 15:49:02 +0800
Message-ID: <20241014074902.1837757-2-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241014074902.1837757-1-Prike.Liang@amd.com>
References: <20241014074902.1837757-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017090:EE_|IA0PR12MB8207:EE_
X-MS-Office365-Filtering-Correlation-Id: a860747f-826a-4207-5a48-08dcec24b33a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jIzf4FcYHmVnUJ0e5K8nvLMmojh9ZWfBpaQhmoTpWE1O49hTbIgUrxec8o9v?=
 =?us-ascii?Q?mPOIiue1nhyyNeTivjRE4vTcKF3GGU0fLgfDrKzNmhpWukddmpP2DpG3Nocl?=
 =?us-ascii?Q?O2qJNNpfLRrjx6edy2u52kh7bBiSJcsH1TFQT7U0P078orj3n9Y4P1BXo668?=
 =?us-ascii?Q?dvcfmREavF6+3yIPLfI2Yu7gNDsb/cxRUe2I9/moil5bRW+9nEDv5bzi4V11?=
 =?us-ascii?Q?eAY/AQx2a8ueOfFRYINa4rPJymaMEV7Ta8Ow8QReLIzJk9nmK0WRv05GWcON?=
 =?us-ascii?Q?Lx8ZFpbHld8brlOhsKOREa5PemvbRHeYkaYFEcnuTmqvqfIdo7+8abNl/Bzg?=
 =?us-ascii?Q?zKw95GBOI38iduMdGT3eT/VhWDVQZbXE1YFctQrvm7qPioqqTTnGv6/mJH6D?=
 =?us-ascii?Q?dXCLbZTRFlP6SIQDrIAwowasAarJfB5bmxnYWOhT2wSG0hSXxGrHaQ5qu9AP?=
 =?us-ascii?Q?9Q9vY42zT9pgLxTgub8MrFvNvou4H2B24GCDp3OT/64FwgSGQUilAYF0Gej7?=
 =?us-ascii?Q?Lxe23shVOihGI3Z/p4gsfEiH9rFpenQCJ2jBWqRj04iG2GrL7Yr9z7Ua3AVj?=
 =?us-ascii?Q?xJ7bZs3Nspg8ZaXh15u1z/irvZAhetB8yKmWfyz3/qLFUBXoTycnY0VINRXd?=
 =?us-ascii?Q?WYzcjjOyOzA+/2nEXb5MY/z/kzBjXgSzepkIre7XAWYxfNeBZEL/qr9IO7IV?=
 =?us-ascii?Q?IjqxDrU1CRz07uzoiGX/Tt51guSnTQlyRQEsI0bc5Pr2ILOlQGNoVqb1aVGw?=
 =?us-ascii?Q?Il6REbtM3aiKinf2ERRCyLVghQg64nT6LUT/wEx48X6H0jqqSPbW88rgcvZt?=
 =?us-ascii?Q?5lrD1y7qF26E1Uq6n3KjsDsSu+aEpYEkWsyMaXMlVBDMxSf3WdIHIqeCEMQV?=
 =?us-ascii?Q?gnfw1hPBV4OrQ90iJz/8XTLCXwbX4yfCf7TO26Az4cd8NqYWwr95t6eeuWlp?=
 =?us-ascii?Q?/zsmuLupgLYhXYFlla/Y9LqG6s5UBPifdOsuXloWvdUzPrIIx0/zdNrQ/E1a?=
 =?us-ascii?Q?o5yJ3+4+3tlrqfwVnDshsngXqyynmTYNVN+mq+drfl9eGTYz1IXTpr68sWjz?=
 =?us-ascii?Q?gkkcjn2yVHD2cbkTNHiUOXTc+5nZ+2Pk+MxN/bCAWujdBq7LXKKhYqFcKye2?=
 =?us-ascii?Q?mzDpYAD9BGf3Q/W3XZgBhns/Wg1HNuyx3vZzT6lCqTCqwS0nJgQM4PPETbhK?=
 =?us-ascii?Q?92DLW6Xa17rFSfdsVyR6gQ66/0TrEGW5P7QjrSS43UBz/iC2P22lOlKwtkb+?=
 =?us-ascii?Q?dsUHvz4++IBscMYYJpfOQrqPRuLBToMPSUwAQW9BGpZzo9rs/Daq6RmnGb7n?=
 =?us-ascii?Q?rnMMlBpSaj8ZbGzfV53neuegrAg9R+K8tnhmmeK9xYweJnMJvL2nUFICeAqC?=
 =?us-ascii?Q?lkGXK0sjb87DizniMmKE7vcR5Kx+?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 07:49:14.8753 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a860747f-826a-4207-5a48-08dcec24b33a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017090.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8207
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

To check the status of S3 suspend completion,
use the PM core pm_suspend_global_flags bit(1)
to detect S3 abort events. Therefore, clean up
the AMDGPU driver's private flag suspend_complete.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h     | 2 --
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 2 --
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   | 4 ++--
 drivers/gpu/drm/amd/amdgpu/soc15.c      | 7 ++-----
 drivers/gpu/drm/amd/amdgpu/soc21.c      | 2 +-
 5 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 48c9b9b06905..9b35763ae0a7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1111,8 +1111,6 @@ struct amdgpu_device {
 	bool				in_s3;
 	bool				in_s4;
 	bool				in_s0ix;
-	/* indicate amdgpu suspension status */
-	bool				suspend_complete;
 
 	enum pp_mp1_state               mp1_state;
 	struct amdgpu_doorbell_index doorbell_index;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 680e44fdee6e..78972151b970 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2501,7 +2501,6 @@ static int amdgpu_pmops_suspend(struct device *dev)
 	struct drm_device *drm_dev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = drm_to_adev(drm_dev);
 
-	adev->suspend_complete = false;
 	if (amdgpu_acpi_is_s0ix_active(adev))
 		adev->in_s0ix = true;
 	else if (amdgpu_acpi_is_s3_active(adev))
@@ -2516,7 +2515,6 @@ static int amdgpu_pmops_suspend_noirq(struct device *dev)
 	struct drm_device *drm_dev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = drm_to_adev(drm_dev);
 
-	adev->suspend_complete = true;
 	if (amdgpu_acpi_should_gpu_reset(adev))
 		return amdgpu_asic_reset(adev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index be320d753507..ba8e66744376 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -3276,8 +3276,8 @@ static int gfx_v9_0_cp_gfx_start(struct amdgpu_device *adev)
 	 * confirmed that the APU gfx10/gfx11 needn't such update.
 	 */
 	if (adev->flags & AMD_IS_APU &&
-			adev->in_s3 && !adev->suspend_complete) {
-		DRM_INFO(" Will skip the CSB packet resubmit\n");
+			adev->in_s3 && !pm_resume_via_firmware()) {
+		DRM_INFO("Will skip the CSB packet resubmit\n");
 		return 0;
 	}
 	r = amdgpu_ring_alloc(ring, gfx_v9_0_get_csb_size(adev) + 4 + 3);
diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
index 12ff6cf568dc..d9d11131a744 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc15.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
@@ -584,13 +584,10 @@ static bool soc15_need_reset_on_resume(struct amdgpu_device *adev)
 	 *    performing pm core test.
 	 */
 	if (adev->flags & AMD_IS_APU && adev->in_s3 &&
-			!pm_resume_via_firmware()) {
-		adev->suspend_complete = false;
+			!pm_resume_via_firmware())
 		return true;
-	} else {
-		adev->suspend_complete = true;
+	else
 		return false;
-	}
 }
 
 static int soc15_asic_reset(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index c4b950e75133..7a47a21ef00f 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -904,7 +904,7 @@ static bool soc21_need_reset_on_resume(struct amdgpu_device *adev)
 	 * 2) S3 suspend got aborted and TOS is active.
 	 */
 	if (!(adev->flags & AMD_IS_APU) && adev->in_s3 &&
-	    !adev->suspend_complete) {
+	    !pm_resume_via_firmware()) {
 		sol_reg1 = RREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_81);
 		msleep(100);
 		sol_reg2 = RREG32_SOC15(MP0, 0, regMP0_SMN_C2PMSG_81);
-- 
2.34.1

