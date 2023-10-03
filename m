Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C10EE8FDB3
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Oct 2023 20:57:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC0EE10E312;
	Tue,  3 Oct 2023 20:57:34 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2073.outbound.protection.outlook.com [40.107.96.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F37D910E314
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Oct 2023 20:57:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IN2DVPr1/F2OnBK47EuaxFwipkGwJZi6g6aldh8ziH9ce4n0f84H2xEZvahz53+nyrxbqDYE4Ry+UEMRVLRWpneYbZuellLoMPWi2lkJNziaUax9Zp3aKueX85XkdmgQ1AzBJTeIZBItjQAI8lhXixFKAzD1cIwoHFapIe/PKU9CAS/oOD/CjSPJejSFxCYYjCe9tRy2kMl2992gbEPLa7AVlIi/xS824j6bdO1pC/HGpF0LjnSp3Xbyk7zAQZ6AS4Xk3ncBKHm3X+DrdVSy9HPBg/wC7RcGSYhlkpMtPGeOeU3BIsY/PPThxKBOHslXMJLLgECJg7ddubLLs37V0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IeY91DCos//x9yB1NQxfbPTJzWjmfuvz/W/OPwjPk5Y=;
 b=Icja+n/eVd6JicoUL4obX4QwXUQJmDl2X9lAvN7KQl343bykBAT5xwXaTxHKRHf/AktHq0iAzUW+npl/8e5Wr4iDSSxX/BHPirEvJibyBqekCZhFN/A2ndQpfRIYqBs9xcY31TG239iP1cCfLwxYaI4IVDx+wOZdsLUkzqPltrtQBf2czTejtyj3tzLW8CHhTbIaybP9/GXZaCBS2mFrxT9f/pZAAS+ljMplogevtlaW+t+lK+sZiUrihbJox3Nxc0PSEdGhMwzAmKZfQsWbKq0lZzhhLeGSG5ceGIhvmWXiLHDh26c2uX5Qckm+PIItDxD8+wucEuqzzNf0LaSyxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IeY91DCos//x9yB1NQxfbPTJzWjmfuvz/W/OPwjPk5Y=;
 b=fZAdJK6RvvfqLuTrlrZzPEXAwMPanfeDpbrdIrrkHhFFnCQ2ZKfuXJOMyXGRYVHmdEZ8infX/iehFJXPlI3vdhRHQniP1dn5awllvwAy5xYKLLgXjkZlEx96LKwTqVzTOkpQfA4vfOl2GbqHyXqH0Cvk+z8aTiXlS9dQdPycm8A=
Received: from CYZPR12CA0002.namprd12.prod.outlook.com (2603:10b6:930:8b::13)
 by SA1PR12MB6726.namprd12.prod.outlook.com (2603:10b6:806:255::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.29; Tue, 3 Oct
 2023 20:57:29 +0000
Received: from CY4PEPF0000EE3F.namprd03.prod.outlook.com
 (2603:10b6:930:8b:cafe::c2) by CYZPR12CA0002.outlook.office365.com
 (2603:10b6:930:8b::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.25 via Frontend
 Transport; Tue, 3 Oct 2023 20:57:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3F.mail.protection.outlook.com (10.167.242.19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Tue, 3 Oct 2023 20:57:28 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 3 Oct
 2023 15:57:27 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 1/4] drm/amd: Add support for prepare() and complete()
 callbacks
Date: Tue, 3 Oct 2023 15:54:34 -0500
Message-ID: <20231003205437.123426-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231003205437.123426-1-mario.limonciello@amd.com>
References: <20231003205437.123426-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3F:EE_|SA1PR12MB6726:EE_
X-MS-Office365-Filtering-Correlation-Id: 70fc2c40-242d-4782-6e9e-08dbc4535af8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xsNJgZpTWmhpBocvv1cOwnmMdnKenxVRgB92tOnobBL87VCmHEnMWTReyCx26CuOUPv94atW//kG/YlPnvihdlxqE/nH617rC72vu8PO3opnX/2nUnqpwJ321h2tXrHlEO49HrIxQUj4GyOhm5laqSUslS4y8hSwZEHbzTL4btMuBjDR7e5I0rOrwYCzpYmz9Smrg9oBX9Py8LaguR5SbaU6zstv0wXYQ36C1yXLyDQM8F7GrkoCxvHSpB0Er+BYm0rqLekhMd7Kr5tnwJ4KmlxuU59XkWuaeEu6RNdXLMLkeRNqiyXUa/p4a7hia4GAnxWNGjd70Yl+aXlTdqQWuZD+PpYwLT+LOhwyTRb5RzfAPFPsN4z7lDlHbG8SKcl274weoz2zZhZL7MOKZIW//SPwAp6Kq72ErB8eNtg064v7elztou/L0CgIC28yeajEdFAEzyLEkDnOLnEuYVZE1G7o8wShb7TXGwjdX2DrGXIcZkO5+nSZcXjagnFnEySm3xA72KorSZB4wmvgcNxu42kO0MnB6Fdl7+n7OW7MqGyZrhhV7llD/4FOt6R0qxHEnTxChFffOlRStnmPmCX/qwzYTS63b3M4PTY+FlGX6ywoc4XJuc5r214KjKV1AY9P23zq77kn3hmPbyKXvTsna+aojZXonyUHIUorG7AWtHynYuo1FcOVTJJ2E2/DCGUd7XblGZiuRFN1Q+qI6eF9aXuN4h9snWw2s73f79ezYpoyAMmV1Mknb9x84UyWm9zzVrjq9GFPXIFH9OewwVTKCw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(136003)(396003)(39860400002)(376002)(230922051799003)(186009)(451199024)(82310400011)(1800799009)(64100799003)(36840700001)(40470700004)(46966006)(70586007)(70206006)(2906002)(8936002)(44832011)(5660300002)(54906003)(6916009)(4326008)(8676002)(41300700001)(478600001)(7696005)(6666004)(16526019)(26005)(36860700001)(336012)(426003)(1076003)(2616005)(40460700003)(316002)(47076005)(83380400001)(356005)(81166007)(82740400003)(40480700001)(86362001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 20:57:28.9523 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70fc2c40-242d-4782-6e9e-08dbc4535af8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE3F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6726
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

If the suspend fails, then do any cleanups in the complete() callback.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  2 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 39 ++++++++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 11 +++---
 3 files changed, 46 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 73e825d20259..5d651552822c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1415,6 +1415,8 @@ void amdgpu_driver_postclose_kms(struct drm_device *dev,
 void amdgpu_driver_release_kms(struct drm_device *dev);
 
 int amdgpu_device_ip_suspend(struct amdgpu_device *adev);
+int amdgpu_device_prepare(struct drm_device *dev);
+void amdgpu_device_complete(struct drm_device *dev);
 int amdgpu_device_suspend(struct drm_device *dev, bool fbcon);
 int amdgpu_device_resume(struct drm_device *dev, bool fbcon);
 u32 amdgpu_get_vblank_counter_kms(struct drm_crtc *crtc);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index bad2b5577e96..f53cf675c3ce 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4259,6 +4259,43 @@ static int amdgpu_device_evict_resources(struct amdgpu_device *adev)
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
+	adev->in_suspend = true;
+
+	return 0;
+}
+
+/**
+ * amdgpu_device_complete - complete the device after resume
+ *
+ * @dev: drm dev pointer
+ *
+ * Clean up any actions that the prepare step did.
+ * Called after driver resume.
+ */
+void amdgpu_device_complete(struct drm_device *dev)
+{
+	struct amdgpu_device *adev = drm_to_adev(dev);
+
+	adev->in_suspend = false;
+}
+
 /**
  * amdgpu_device_suspend - initiate device suspend
  *
@@ -4277,8 +4314,6 @@ int amdgpu_device_suspend(struct drm_device *dev, bool fbcon)
 	if (dev->switch_power_state == DRM_SWITCH_POWER_OFF)
 		return 0;
 
-	adev->in_suspend = true;
-
 	/* Evict the majority of BOs before grabbing the full access */
 	r = amdgpu_device_evict_resources(adev);
 	if (r)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index e3471293846f..4c6fb852516a 100644
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
@@ -2435,12 +2436,14 @@ static int amdgpu_pmops_prepare(struct device *dev)
 	    !amdgpu_acpi_is_s3_active(adev))
 		return 1;
 
-	return 0;
+	return amdgpu_device_prepare(drm_dev);
 }
 
 static void amdgpu_pmops_complete(struct device *dev)
 {
-	/* nothing to do */
+	struct drm_device *drm_dev = dev_get_drvdata(dev);
+
+	amdgpu_device_complete(drm_dev);
 }
 
 static int amdgpu_pmops_suspend(struct device *dev)
-- 
2.34.1

