Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D1E7EB64D7
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Jun 2023 15:04:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC31F10E219;
	Mon, 26 Jun 2023 15:04:35 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2057.outbound.protection.outlook.com [40.107.243.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AEDEF10E217
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Jun 2023 15:04:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mB6UDcWn+oGNXZIPYhzNVNVAQdG8tfsmqOJALoWIgH6N6NRLUZUeJ2kSKfSYFtRH1r5yOAB9SPhywA8scNpSfmP7HZ08PZ/Xbj9PGhIRst51RSKUl4Nt09cCf3cHB8AwOC0oryubKb45dRU2Ztx47AmqWx1lyQRB0dnJykKhKqdIynHWRJXJ7f7DuUTjCpT/g5WTPzQrf9nLTJS6awD9HYNIyo7EWOxdApPyTVfpFQDEQ7WCPzSpESC/Vs5ea9ytBQ/CfB2TmjAcny7nny7GPY7zJoWKhQy4708WJLLgTV/iFRxhRZldm8dqut5+GxHd2mqy6QEw1mgIjFym10ckLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=StTWxidWPIA9d4x7/CQ7XSt5bLlFoxoiYduJXpeG6RY=;
 b=WIcfBoa8bg9QqyKztq46fU9W6lER4/4WL+idemvAQa+fE2gN15ahH+7sUWpoEPNcVohDXMj1f0SJmWvsxUguj8OogrqA8Hoc7bZVNxWvfYYqag4X4lzNghyABkI7JgA4qkUYwDcc+3weVaI9jbliQyyhVRvrvA1aPyWjVifvYyC/UXHaTGdqEEPF7TQwbMjj2mKsbm5uceyHAd2YjpAAPyDMEfZaN2qW4ByEAhqaGiFHs4hSyhZLfAurx5ANPbNXMvuu/tLfpk/VJRTJz0p01zkBqpG9u300g6DhVc07X/XAzgs3Dqt0jnINUmx65c1RsLLj21b3MtVZoBbUHdmSWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=StTWxidWPIA9d4x7/CQ7XSt5bLlFoxoiYduJXpeG6RY=;
 b=N+xlK8Q3hJAIyyA4XpShI7oDHC78IaYAZau7tQDWXBACCDky4xfHM5o9bxaCPIuZEpszFm7Ykv83w04WaaObpyup0L3KcpwmN+07LAxcgKUYhkBlUXpQMqclxcVOrAMHTmgmS3MMMEF3H7t8/ODlSj8hV1IVyk3wxt1RePBEuWY=
Received: from MW4PR04CA0343.namprd04.prod.outlook.com (2603:10b6:303:8a::18)
 by DM6PR12MB4385.namprd12.prod.outlook.com (2603:10b6:5:2a6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.21; Mon, 26 Jun
 2023 15:04:28 +0000
Received: from CO1NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8a:cafe::65) by MW4PR04CA0343.outlook.office365.com
 (2603:10b6:303:8a::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.33 via Frontend
 Transport; Mon, 26 Jun 2023 15:04:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT018.mail.protection.outlook.com (10.13.175.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.47 via Frontend Transport; Mon, 26 Jun 2023 15:04:28 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 26 Jun
 2023 10:04:25 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 5/5] drm/amd: Add documentation for how to flash a dGPU
Date: Mon, 26 Jun 2023 10:04:07 -0500
Message-ID: <20230626150407.1447-5-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230626150407.1447-1-mario.limonciello@amd.com>
References: <20230626150407.1447-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT018:EE_|DM6PR12MB4385:EE_
X-MS-Office365-Filtering-Correlation-Id: af137971-4c69-42aa-b7d1-08db7656a347
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m/spltY47QpDmfM3emZ21OlhmLKH8DbZI+IpYkeubwnNoGF1XVdQBiUOQZ3y+68qbSuYtfrcR4Xg654a/Ya0ZIv9QEfyxRJJE5G83VRw0CMQeEOsOkogHyjI9gprpQ5oRs+wntfdRCqJDuFLVAYS04T4rbD3DVgpHrmujYEoekKAfrljG3bxIGgOvZNl8T9pkAlhkUdUUmKF6WfMzc9gfSGVnFG89GF2VxzJ7hBw02yZgnqUtMWptQl/4vys6Khd4tA3m+Yo8/lIyStXB66gPOCZShwomFN8OL/NO7UTDBVzB3RrHq5S9QOr+na/GqHGgKsJ64Cohr9bjKxUE1hUnF5zlzidLCe2z32HgtLLhlHq1wpL5QS6uUutm2Rop0zhAu1/Y/RPhn6tiKmiuHVHyaCUu+thQ2Wl/hdAjckdOHJQQVtC9ZHMI2jl5WHT0XCHABB6/gEOFA4BwReqaMrOyhPam7EF/sBA/YhWjBDsOh/wtyDDD/5TdFFIluFJzF9t5Izuq7dU5f+KH/T7hZjnSCyOFBxeb9MHC358Raz1Gwt+egre6q8S2+nNAfwTkooRwTTOARUKAoSJ7LrA/TQ6kWeqVE8yhxdj4c8076yDaPoeTDAMbEBMaOBC2IoKMBz2xR7OtqzCLvaqKvdsVvM0KTiu3vlv4R0kOqE0v9ehOoEGVVS9OeMQOUojxroxgLxveWueKTIZhOAAGsb36M8guI6slOrkhZ2XWZvevmug1DTNzNmlpfpzG8FWiftQ9IEK3u1ABG4fvCccQ67/aJs+Jw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(346002)(136003)(39860400002)(376002)(451199021)(40470700004)(36840700001)(46966006)(82310400005)(36860700001)(40460700003)(47076005)(478600001)(6666004)(7696005)(2616005)(426003)(83380400001)(336012)(26005)(186003)(1076003)(16526019)(2906002)(5660300002)(70206006)(44832011)(36756003)(356005)(4326008)(40480700001)(82740400003)(70586007)(81166007)(316002)(86362001)(8936002)(8676002)(41300700001)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2023 15:04:28.0146 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af137971-4c69-42aa-b7d1-08db7656a347
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4385
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
Cc: Mario Limonciello <mario.limonciello@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 Documentation/gpu/amdgpu/flashing.rst   | 33 +++++++++++++++++++++++++
 Documentation/gpu/amdgpu/index.rst      |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 16 ++++++++++++
 3 files changed, 50 insertions(+)
 create mode 100644 Documentation/gpu/amdgpu/flashing.rst

diff --git a/Documentation/gpu/amdgpu/flashing.rst b/Documentation/gpu/amdgpu/flashing.rst
new file mode 100644
index 0000000000000..bd745c42a538f
--- /dev/null
+++ b/Documentation/gpu/amdgpu/flashing.rst
@@ -0,0 +1,33 @@
+=======================
+ dGPU firmware flashing
+=======================
+
+IFWI
+----
+Flashing the dGPU integrated firmware image (IFWI) is supported by GPUs that
+use the PSP to orchestrate the update (Navi3x or newer GPUs).
+For supported GPUs, `amdgpu` will export a series of sysfs files that can be
+used for the flash process.
+
+The IFWI flash process is:
+
+1. Ensure the IFWI image is intended for the dGPU on the system.
+2. "Write" the IFWI image to the sysfs file `psp_vbflash`. This will stage the IFWI in memory.
+3. "Read" from the `psp_vbflash` sysfs file to initiate the flash process.
+4. Poll the `psp_vbflash_status` sysfs file to determine when the flash process completes.
+
+USB-C PD F/W
+------------
+On GPUs that support flashing an updated USB-C PD firmware image, the process
+is done using the `usbc_pd_fw` sysfs file.
+
+* Reading the file will provide the current firmware version.
+* Writing the name of a firmware payload stored in `/lib/firmware/amdgpu` to the sysfs file will initiate the flash process.
+
+The firmware payload stored in `/lib/firmware/amdgpu` can be named any name
+as long as it doesn't conflict with other existing binaries that are used by
+`amdgpu`.
+
+sysfs files
+-----------
+.. kernel-doc:: drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
diff --git a/Documentation/gpu/amdgpu/index.rst b/Documentation/gpu/amdgpu/index.rst
index 03c2966cae798..912e699fd3731 100644
--- a/Documentation/gpu/amdgpu/index.rst
+++ b/Documentation/gpu/amdgpu/index.rst
@@ -10,6 +10,7 @@ Next (GCN), Radeon DNA (RDNA), and Compute DNA (CDNA) architectures.
    module-parameters
    driver-core
    display/index
+   flashing
    xgmi
    ras
    thermal
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index 7872004ed7f9b..047760bafcc23 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -3476,6 +3476,11 @@ void psp_copy_fw(struct psp_context *psp, uint8_t *start_addr, uint32_t bin_size
 	drm_dev_exit(idx);
 }
 
+/**
+ * DOC: usbc_pd_fw
+ * Reading from this file will retrieve the USB-C PD firmware version. Writing to
+ * this file will trigger the update process.
+ */
 static DEVICE_ATTR(usbc_pd_fw, S_IRUGO | S_IWUSR,
 		   psp_usbc_pd_fw_sysfs_read,
 		   psp_usbc_pd_fw_sysfs_write);
@@ -3569,6 +3574,11 @@ static ssize_t amdgpu_psp_vbflash_read(struct file *filp, struct kobject *kobj,
 	return 0;
 }
 
+/**
+ * DOC: psp_vbflash
+ * Writing to this file will stage an IFWI for update. Reading from this file
+ * will trigger the update process.
+ */
 static struct bin_attribute psp_vbflash_bin_attr = {
 	.attr = {.name = "psp_vbflash", .mode = 0660},
 	.size = 0,
@@ -3576,6 +3586,12 @@ static struct bin_attribute psp_vbflash_bin_attr = {
 	.read = amdgpu_psp_vbflash_read,
 };
 
+/**
+ * DOC: psp_vbflash_status
+ * The status of the flash process.
+ * 0: IFWI flash not complete.
+ * 1: IFWI flash complete.
+ */
 static ssize_t amdgpu_psp_vbflash_status(struct device *dev,
 					 struct device_attribute *attr,
 					 char *buf)
-- 
2.34.1

