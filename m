Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BED6E776D4
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Oct 2023 00:25:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A53310E12F;
	Tue,  3 Oct 2023 00:25:03 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2048.outbound.protection.outlook.com [40.107.243.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5332910E107
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Oct 2023 00:25:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L8vpPcelXwvhdtZc7+LAZDy7IWcU9AahqFjja9y44JpLO7iU3l3xsup0r1KAQILdaIbj+F9+IBZoJaFHXXpDidG7U4aJccxTjwqlWlJG+9kTOMCDyyLNBUoftHj424X6rpH0Zw8TNs3GIaNXPz3W5XQ9wzzdsZHEfhxc6QDD0VGzBNQliPWGCOPEd88zeonN1UiBHtVAQG5SRSJtHPROQSKqkdGazH8t0kA+QMVKs3Z+naWuCNpwKN/tAbXvl6yEjxzJCa7sHje3uosd1LWLPHviw7tgW9u4ungwUW55x08f2DHM7PsRyHDoqQpeYretrfQZbAs4rkrxyvHX4iTl7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qnNTGdi2tT9kEreEsYvAiWWTvCNgYweiPnlRPFjo2Tk=;
 b=YXWSHmmCzNAUeM4/DD/gneEwElJDR6URgUBDBGrGbOwYcDJPdAwCj+XvCmhawq9mNB7eX0fBDis0KFAQptf4Uv2R2TXkurqcJppOWA0yC/nMNLdZoNPEyZdQaBh0dOJAUI2hNgnKQgOZMBSsbfc7O/gjEOHlZBoVX12bdm/CePbmHb/jwG7+KzciW8xl+EZ25Ue3pAcyCINk+A5gfb1zTijnZJH30jdOXEuvTy2dgz7OOW3C+AmGVtheUIa/BKcQwh/3uWoyNb29VUFQZnuIJNfcnkCBCBR5ueRR9DA8pdFcDDYWBWEdPbjBCEq50dj6e24J4pveQ7ZkO++oKVqS8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qnNTGdi2tT9kEreEsYvAiWWTvCNgYweiPnlRPFjo2Tk=;
 b=esdrNa7o+Ryvzvdq3mpYuLpotYwFvxvOjdGAKFirn3agPJKRevnETPjjmA0rVyyhLL9MA1yxIK7sI+QJPRfjrUnGBLJS2NF1v2jB93nAn6Ig+Z3s+s/VLnTyqUB+O9qtx8KXyJsVKbJ+hdbF5v+J0MWcOtBj/JcAMJSdl6xzUSk=
Received: from CY5PR22CA0006.namprd22.prod.outlook.com (2603:10b6:930:16::9)
 by SA1PR12MB7366.namprd12.prod.outlook.com (2603:10b6:806:2b3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.22; Tue, 3 Oct
 2023 00:24:57 +0000
Received: from CY4PEPF0000E9CF.namprd03.prod.outlook.com
 (2603:10b6:930:16:cafe::82) by CY5PR22CA0006.outlook.office365.com
 (2603:10b6:930:16::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.32 via Frontend
 Transport; Tue, 3 Oct 2023 00:24:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9CF.mail.protection.outlook.com (10.167.241.142) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Tue, 3 Oct 2023 00:24:56 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 2 Oct
 2023 19:24:55 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 1/3] drm/amd: Add support for prepare() callback
Date: Mon, 2 Oct 2023 17:44:47 -0500
Message-ID: <20231002224449.95565-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231002224449.95565-1-mario.limonciello@amd.com>
References: <20231002224449.95565-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CF:EE_|SA1PR12MB7366:EE_
X-MS-Office365-Filtering-Correlation-Id: c3675dde-626d-4714-e689-08dbc3a72c0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l4087rrneW9B13Aybw5q5qVS3+HFdx4j4+PRO7z2SHK7FoFbiizZSZr2WGbkqkNfx+qOx89dE3LiN719vgfiMHUOy1rTJHvQYZ2p3c8VVwkViZFGvIkbJFnfugJQ2eoDK77CWqkYV/M91p/G5NrEGPgV1LUCpBtgQH5JGZJoiGnTxmmCSjsdM+qU6Vk7bkpReZ1K86kdvyC5qijyzr215co2a8kiliyX8Zo1xHf6H5x6zi8UYIcnORAIl73CmaRILzbv3Ei/bEy+z6h3Qh5Cp8qX8V7YXwEgS9gOvgL2zg1Z+J3QE5nrlm/QDP6ZrGiFBhAvCvgmlZwheeGb+N/ZLSPFtjyfaEQEE5nevWvncDy+e6cU1K1CINRL2nQ8Q71JSIp4Zu07gDARSTu2AnMQ84i+MKHdrXnkLRw36NlsyRM+jw7WnavEt7pYa133T8/jeYglwQLxXhhWB8GnFl1sy+3Vq/sIhv6/Fi7TV+Dmqmiuc3b5647UoyHtao/1ZxvkC0mwS/OqSd1NVkb2DWth7YS2AhHFfkcTvzvJUUW+eE6V8MLWHTLjKzc7Yn25Ii2ERxPZ6xGkdPurXEnf6/m9t0BLML6KeVpitNraiiIw7k5aCvvDs0Z9lgh8e1/UPljvbdDfXcV6sBte4g521QibUKJdEN7m/AfzVxw1HWz7FKLyx4WOWO7xoKvxMk1H2Ig2aVvZSZ+NthJMZLkiknnGEP7GgHGlM9qktMCt984Kj0bL8udKEOSjn3bWuwy+YX77qdSNh648w8LNpOFkoo44OQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(136003)(39860400002)(376002)(396003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(82310400011)(40470700004)(46966006)(36840700001)(6916009)(41300700001)(316002)(44832011)(5660300002)(54906003)(70206006)(26005)(336012)(36756003)(1076003)(16526019)(2616005)(70586007)(426003)(6666004)(40480700001)(478600001)(7696005)(40460700003)(4326008)(8676002)(8936002)(2906002)(47076005)(83380400001)(82740400003)(36860700001)(356005)(81166007)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 00:24:56.8313 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c3675dde-626d-4714-e689-08dbc3a72c0f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7366
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
Cc: Harry.Wentland@amd.com, Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Linux PM core has a prepare() callback run before suspend and complete()
callback ran after resume() for devices to use.  Add plumbing to bring
prepare() to amdgpu.

The idea with the new vfuncs for amdgpu is that all IP blocks that
memory allocations during suspend should do the allocation from this
call instead of the suspend() callback.

By moving the allocations to prepare() the system suspend will be failed
before any IP block has done any suspend code.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 20 ++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |  7 ++++---
 3 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 73e825d20259..d32df70f0561 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1415,6 +1415,7 @@ void amdgpu_driver_postclose_kms(struct drm_device *dev,
 void amdgpu_driver_release_kms(struct drm_device *dev);
 
 int amdgpu_device_ip_suspend(struct amdgpu_device *adev);
+int amdgpu_device_prepare(struct drm_device *dev);
 int amdgpu_device_suspend(struct drm_device *dev, bool fbcon);
 int amdgpu_device_resume(struct drm_device *dev, bool fbcon);
 u32 amdgpu_get_vblank_counter_kms(struct drm_crtc *crtc);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index bad2b5577e96..c41d69e7a8f5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4259,6 +4259,26 @@ static int amdgpu_device_evict_resources(struct amdgpu_device *adev)
 /*
  * Suspend & resume.
  */
+/**
+ * amdgpu_device_prepare - prepare for device suspend
+ *
+ * @dev: drm dev pointer
+ *
+ * Prepare to put the hw in the suspend state (all asics).
+ * Returns 0 for success or an error on failure.
+ * Called at driver suspend.
+ */
+int amdgpu_device_prepare(struct drm_device *dev)
+{
+	struct amdgpu_device *adev = drm_to_adev(dev);
+	int r;
+
+	if (dev->switch_power_state == DRM_SWITCH_POWER_OFF)
+		return 0;
+
+	return 0;
+}
+
 /**
  * amdgpu_device_suspend - initiate device suspend
  *
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index e3471293846f..175167582db0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2425,8 +2425,9 @@ static int amdgpu_pmops_prepare(struct device *dev)
 	/* Return a positive number here so
 	 * DPM_FLAG_SMART_SUSPEND works properly
 	 */
-	if (amdgpu_device_supports_boco(drm_dev))
-		return pm_runtime_suspended(dev);
+	if (amdgpu_device_supports_boco(drm_dev) &&
+	    pm_runtime_suspended(dev))
+		return 1;
 
 	/* if we will not support s3 or s2i for the device
 	 *  then skip suspend
@@ -2435,7 +2436,7 @@ static int amdgpu_pmops_prepare(struct device *dev)
 	    !amdgpu_acpi_is_s3_active(adev))
 		return 1;
 
-	return 0;
+	return amdgpu_device_prepare(drm_dev);
 }
 
 static void amdgpu_pmops_complete(struct device *dev)
-- 
2.34.1

