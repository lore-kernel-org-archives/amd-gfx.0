Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE867D6DDE7
	for <amd-gfx@archiver.kernel.org>; Fri, 15 Nov 2024 08:03:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46ECA10E3AD;
	Fri, 15 Nov 2024 08:03:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3ScNaP4I";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2064.outbound.protection.outlook.com [40.107.93.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7608810E3AD
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Nov 2024 08:03:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O/Z60281yB/bWPbh3leBu4r74RGjPmp2GyDxXFLFXU6m75cH/TgOBdWpD7M19rkzOC9htTCSuhfxkzjA4UO+0C91RxiqbvuRmlN+uZBXmsFyW6drX2lo2PPSFaF5pZZPoXRGrSUlvih7e89S+ZAIDY1mCDvrlodIwEgEswR7YV/0cT43K1ZsnI1kqt533pPt7+ZOdJqX6yCIWkFl8ytOuknUbxCUE6wHKsg0G1yzhwU7Yj5bgrHhHV89IAnGSV3PwtCQaNVTKFQHkcq6ereflY/F3z69hx5P84IxCy3H2WEzRuBf4naGeeXDS51H0eeI/LHvFM4eF1yzxKBzEkG8Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tKVr1ag08Xn7U/Aa/CWibElwRTK4V+nmfLiKbtP0qpk=;
 b=undP4VSnlm7HgI3ot/dTNmqDwpvP4btHRUKyz7TP1G7hMQweHJKF//TR5M7UfXZb6yHlmCT/98i9Lmad08IZvKYbn1ka0PXbUdQ8kyp/dtYOTt59rXsdhkDlxe4biZ+5Sh68LWn8KQ+PK6vPl0MXSWULZATABYxI51vv6om6woncyfnVfpb8tsgQy23n6UgwjgEUVtdmiiIyUZT6hUNJtW6y8y3MKD1Zf1OId7aWEJsQF5eQnRdVmTiUcc6v30s+CWQFGRyQDN16kxuZPkcoNp+G8CYRiIPQRXdysn8jzeBNuOPG9SRGBbQ1g7BmcDqym+hZ/qO/NjKNIo+zXIEfcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tKVr1ag08Xn7U/Aa/CWibElwRTK4V+nmfLiKbtP0qpk=;
 b=3ScNaP4IpYMAu5BvpILCyyVPh83WZgMvkUm9TnlTEtjjw8Qegv9BDew+MriG1RgpxHKB7FOLkwjLqRAEUw+5JnoEMGRLd7SQMQOvyyQ10u0tIacB2dvQocwAiNaxnzRjA+xJTrmwbI7UIjh4W5AAeosWRBqSYKFE3yxOU84mE/U=
Received: from SN1PR12CA0070.namprd12.prod.outlook.com (2603:10b6:802:20::41)
 by PH7PR12MB6585.namprd12.prod.outlook.com (2603:10b6:510:213::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18; Fri, 15 Nov
 2024 08:03:51 +0000
Received: from SA2PEPF000015C9.namprd03.prod.outlook.com
 (2603:10b6:802:20:cafe::98) by SN1PR12CA0070.outlook.office365.com
 (2603:10b6:802:20::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18 via Frontend
 Transport; Fri, 15 Nov 2024 08:03:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C9.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Fri, 15 Nov 2024 08:03:50 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 15 Nov
 2024 02:03:48 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <Tao.Zhou1@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: Add init level for post reset reinit
Date: Fri, 15 Nov 2024 13:33:31 +0530
Message-ID: <20241115080332.3373091-1-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C9:EE_|PH7PR12MB6585:EE_
X-MS-Office365-Filtering-Correlation-Id: 64e926a1-d47e-4445-a135-08dd054c0a4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/puLk8DJ458aYqss+VXS0La+aIoK1te+n1s4Hvt65s5gXAclNTgOnQK3Oiw8?=
 =?us-ascii?Q?lFenwZzkXP1QWIxO+HJpFFgsD2iaGdVHCc823MlN/LUCOMlQdd3dlYoKgajR?=
 =?us-ascii?Q?9kOq3NghL1J4/aUmzAQN2vyY3XrN4fiKKt8ia09LP6dUaLdeyyXQA4aTrK3q?=
 =?us-ascii?Q?xUU43nlVnnVrndt8UbSYcYT3yTAqOyeCIP6XZvpR5xzZpUA9SkzJoL+qSypE?=
 =?us-ascii?Q?fetdBTo1JYunltrTsTD60YuTmSYw0/aVHQKXB2GV36N+r4dwvqYj+iGTEVNd?=
 =?us-ascii?Q?f2Cz4NzHCgVR3nR3D1DyiD/P9jJ9t11db5vLDe6O56urfMhesvtEOgRGbG1v?=
 =?us-ascii?Q?bzleD0j0EYb569A7TbfryAM4QzmwS73LhFxAfI8z2mas4U7f7rFwAG9372kc?=
 =?us-ascii?Q?OWBz3MFSFejT7rGwuHKYYKFU/lgPdiX/j2aZg6HQszwluGUfAKUbS4loEkz4?=
 =?us-ascii?Q?60OjgzK4osEmivRBWBZnjI/qw49YM89aMpXMDlVu7qq3qw4sf8xR74znhWAD?=
 =?us-ascii?Q?rpol3hb6UFAJp9K0/bfD+6EEyIjlf9Zkqx8HLle2Hb3b/lcTyIN4jG/9Tdke?=
 =?us-ascii?Q?mTdsjWVoXmAgufJ4CPTjNg8HJVOiVcqrpyddisZmozES3eebZGnSoAnKcnCM?=
 =?us-ascii?Q?E3LiM+zB9rtjBulF39m7T561tC9Z0vXpmoMAmgbff0PNGu9Vr/TTBA1YLWG2?=
 =?us-ascii?Q?sK7aRTqJSWdYxNhW25H9Ef5wqFgh0UliY2i8oFni3D//r66ZdOpbHq4/iOla?=
 =?us-ascii?Q?08G4uvNxzqP+Rpi5eOmb1pXE2ov1H+44rCravI3WiztEit6n1P1ethwY7taZ?=
 =?us-ascii?Q?cviCDYE10liGvceMNYmz2czomMh95h0MVzH2R643lYTqyJesOKqVnFK418lQ?=
 =?us-ascii?Q?ECKS5TIzjp+yoQrQM95+Gmi8ZBMdIHeg6ZiuIUd7heymUwQyStOxoO4Kf+o8?=
 =?us-ascii?Q?w7vNlduuKK9s/ynRKeWOgWnSVwsv84JlLDsR8p2S3lSGcTmKOs0i+COprJnd?=
 =?us-ascii?Q?7uy4myknJgJv111Mi2/yaOkqqwHhIcFT0FEVGWgKvwNrF4/Md437WQePRrqz?=
 =?us-ascii?Q?WlsJh8Ut75zCjmSFHeDy+mHB+yFHEVcEXXLgWCYzUMKnB5Lh9xbMLbtEr5YL?=
 =?us-ascii?Q?Cjd5G47L86Az2kgYTbPn1T6IrG7d8msqwSmWCrmrSuN76YXtRwjaagbALZRf?=
 =?us-ascii?Q?Qv/bXH3/xQu5D3ya0NoUahhsAPdbzYg4ke9rPFxl0/1rIboptgqSvPgPVOI4?=
 =?us-ascii?Q?bHt/1k3+TeJnYs2T8KNLzZMXLvcbn89BkOwgNKLs9Tb31/4/mjNM0/vdBuhA?=
 =?us-ascii?Q?/BUSRvGixDUTjwonGERe7yOJZ9Fw9eiMBxLrrKJBLWGeoSJB3VyvHpq7ZkSf?=
 =?us-ascii?Q?kWuMlTYceJC4UH6n0j6soF1Z2xRkyu792wvWSZzxp7KDvKZM+w=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 08:03:50.4119 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64e926a1-d47e-4445-a135-08dd054c0a4e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6585
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

When device needs to be reset before initialization, it's not required
for all IPs to be initialized before a reset. In such cases, it needs to
identify whether the IP/feature is initialized for the first time or
whether it's reinitialized after a reset.

Add RESET_RECOVERY init level to identify post reset reinitialization
phase. This only provides a device level identification, IP/features may
choose to track their state independently also.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/aldebaran.c      |  4 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu.h         |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  | 24 ++++++++++++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c   |  5 +++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h   |  2 ++
 drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c |  2 ++
 drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c   |  2 ++
 7 files changed, 37 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/aldebaran.c b/drivers/gpu/drm/amd/amdgpu/aldebaran.c
index 6a2fd9e4f470..57c1ca055388 100644
--- a/drivers/gpu/drm/amd/amdgpu/aldebaran.c
+++ b/drivers/gpu/drm/amd/amdgpu/aldebaran.c
@@ -330,6 +330,8 @@ aldebaran_mode2_restore_hwcontext(struct amdgpu_reset_control *reset_ctl,
 	}
 
 	list_for_each_entry(tmp_adev, reset_device_list, reset_list) {
+		amdgpu_set_init_level(tmp_adev,
+				      AMDGPU_INIT_LEVEL_RESET_RECOVERY);
 		dev_info(tmp_adev->dev,
 			 "GPU reset succeeded, trying to resume\n");
 		/*TBD: Ideally should clear only GFX, SDMA blocks*/
@@ -377,6 +379,8 @@ aldebaran_mode2_restore_hwcontext(struct amdgpu_reset_control *reset_ctl,
 							tmp_adev);
 
 		if (!r) {
+			amdgpu_set_init_level(tmp_adev,
+					      AMDGPU_INIT_LEVEL_DEFAULT);
 			amdgpu_irq_gpu_reset_resume_helper(tmp_adev);
 
 			r = amdgpu_ib_ring_tests(tmp_adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 4f72ad4e843f..b8ef89d64704 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -846,6 +846,7 @@ struct amdgpu_mqd {
 enum amdgpu_init_lvl_id {
 	AMDGPU_INIT_LEVEL_DEFAULT,
 	AMDGPU_INIT_LEVEL_MINIMAL_XGMI,
+	AMDGPU_INIT_LEVEL_RESET_RECOVERY,
 };
 
 struct amdgpu_init_level {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 0419b37e75a8..415c469c2d80 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -155,6 +155,11 @@ struct amdgpu_init_level amdgpu_init_default = {
 	.hwini_ip_block_mask = AMDGPU_IP_BLK_MASK_ALL,
 };
 
+struct amdgpu_init_level amdgpu_init_recovery = {
+	.level = AMDGPU_INIT_LEVEL_RESET_RECOVERY,
+	.hwini_ip_block_mask = AMDGPU_IP_BLK_MASK_ALL,
+};
+
 /*
  * Minimal blocks needed to be initialized before a XGMI hive can be reset. This
  * is used for cases like reset on initialization where the entire hive needs to
@@ -181,6 +186,9 @@ void amdgpu_set_init_level(struct amdgpu_device *adev,
 	case AMDGPU_INIT_LEVEL_MINIMAL_XGMI:
 		adev->init_lvl = &amdgpu_init_minimal_xgmi;
 		break;
+	case AMDGPU_INIT_LEVEL_RESET_RECOVERY:
+		adev->init_lvl = &amdgpu_init_recovery;
+		break;
 	case AMDGPU_INIT_LEVEL_DEFAULT:
 		fallthrough;
 	default:
@@ -5445,7 +5453,7 @@ int amdgpu_device_reinit_after_reset(struct amdgpu_reset_context *reset_context)
 	struct list_head *device_list_handle;
 	bool full_reset, vram_lost = false;
 	struct amdgpu_device *tmp_adev;
-	int r;
+	int r, init_level;
 
 	device_list_handle = reset_context->reset_device_list;
 
@@ -5454,10 +5462,17 @@ int amdgpu_device_reinit_after_reset(struct amdgpu_reset_context *reset_context)
 
 	full_reset = test_bit(AMDGPU_NEED_FULL_RESET, &reset_context->flags);
 
+	/**
+	 * If it's reset on init, it's default init level, otherwise keep level
+	 * as recovery level.
+	 */
+	if (reset_context->method == AMD_RESET_METHOD_ON_INIT)
+		init_level = AMDGPU_INIT_LEVEL_DEFAULT;
+	else
+		init_level = AMDGPU_INIT_LEVEL_RESET_RECOVERY;
 	r = 0;
 	list_for_each_entry(tmp_adev, device_list_handle, reset_list) {
-		/* After reset, it's default init level */
-		amdgpu_set_init_level(tmp_adev, AMDGPU_INIT_LEVEL_DEFAULT);
+		amdgpu_set_init_level(tmp_adev, init_level);
 		if (full_reset) {
 			/* post card */
 			amdgpu_ras_clear_err_state(tmp_adev);
@@ -5544,6 +5559,9 @@ int amdgpu_device_reinit_after_reset(struct amdgpu_reset_context *reset_context)
 
 out:
 		if (!r) {
+			/* IP init is complete now, set level as default */
+			amdgpu_set_init_level(tmp_adev,
+					      AMDGPU_INIT_LEVEL_DEFAULT);
 			amdgpu_irq_gpu_reset_resume_helper(tmp_adev);
 			r = amdgpu_ib_ring_tests(tmp_adev);
 			if (r) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
index 4fc0ee01d56b..59a29fa12db3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
@@ -343,3 +343,8 @@ void amdgpu_reset_get_desc(struct amdgpu_reset_context *rst_ctxt, char *buf,
 		strscpy(buf, "unknown", len);
 	}
 }
+
+bool amdgpu_reset_in_recovery(struct amdgpu_device *adev)
+{
+	return (adev->init_lvl->level == AMDGPU_INIT_LEVEL_RESET_RECOVERY);
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
index f8628bc898df..4d9b9701139b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.h
@@ -158,4 +158,6 @@ extern struct amdgpu_reset_handler xgmi_reset_on_init_handler;
 int amdgpu_reset_do_xgmi_reset_on_init(
 	struct amdgpu_reset_context *reset_context);
 
+bool amdgpu_reset_in_recovery(struct amdgpu_device *adev);
+
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c b/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c
index 9b01e074af47..2594467bdd87 100644
--- a/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c
+++ b/drivers/gpu/drm/amd/amdgpu/sienna_cichlid.c
@@ -220,6 +220,7 @@ sienna_cichlid_mode2_restore_hwcontext(struct amdgpu_reset_control *reset_ctl,
 	int r;
 	struct amdgpu_device *tmp_adev = (struct amdgpu_device *)reset_ctl->handle;
 
+	amdgpu_set_init_level(tmp_adev, AMDGPU_INIT_LEVEL_RESET_RECOVERY);
 	dev_info(tmp_adev->dev,
 			"GPU reset succeeded, trying to resume\n");
 	r = sienna_cichlid_mode2_restore_ip(tmp_adev);
@@ -237,6 +238,7 @@ sienna_cichlid_mode2_restore_hwcontext(struct amdgpu_reset_control *reset_ctl,
 
 	amdgpu_irq_gpu_reset_resume_helper(tmp_adev);
 
+	amdgpu_set_init_level(tmp_adev, AMDGPU_INIT_LEVEL_DEFAULT);
 	r = amdgpu_ib_ring_tests(tmp_adev);
 	if (r) {
 		dev_err(tmp_adev->dev,
diff --git a/drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c b/drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c
index e70ebad3f9fa..70569ea906bc 100644
--- a/drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c
+++ b/drivers/gpu/drm/amd/amdgpu/smu_v13_0_10.c
@@ -221,6 +221,7 @@ smu_v13_0_10_mode2_restore_hwcontext(struct amdgpu_reset_control *reset_ctl,
 	int r;
 	struct amdgpu_device *tmp_adev = (struct amdgpu_device *)reset_ctl->handle;
 
+	amdgpu_set_init_level(tmp_adev, AMDGPU_INIT_LEVEL_RESET_RECOVERY);
 	dev_info(tmp_adev->dev,
 			"GPU reset succeeded, trying to resume\n");
 	r = smu_v13_0_10_mode2_restore_ip(tmp_adev);
@@ -234,6 +235,7 @@ smu_v13_0_10_mode2_restore_hwcontext(struct amdgpu_reset_control *reset_ctl,
 
 	amdgpu_irq_gpu_reset_resume_helper(tmp_adev);
 
+	amdgpu_set_init_level(tmp_adev, AMDGPU_INIT_LEVEL_DEFAULT);
 	r = amdgpu_ib_ring_tests(tmp_adev);
 	if (r) {
 		dev_err(tmp_adev->dev,
-- 
2.25.1

