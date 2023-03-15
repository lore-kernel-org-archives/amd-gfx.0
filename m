Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78A97C6FD1D
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Mar 2023 11:05:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18C9B10E9A5;
	Wed, 15 Mar 2023 11:05:01 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2079.outbound.protection.outlook.com [40.107.237.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6515110E9A5
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Mar 2023 11:04:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NX30iww8/EnBv6XK+6Wz769ykcnTCHMHwvJCrk5KBYOe6bp+H7lClMB7/KPNsvFGofE7pwpp4mQOVQwkn2GN0U+LREnhWC5uXvYEN2Ye/gH6xGVWlO4bWKDjgxtamQkwictKqqvudpPI/C1dSifmZcU9lvlfa0QsP2h4PttkS7xbIZcKvIwNo8KMZBTJWn6rojz/0UfZdxMB9PIm0SwrE9cy7yJNsk5//ENgbdmmCB+TyyqmuwB1S4RvwHcbl2ePI3jDXnDcyltvZNxHLE3Ou3YnXC5kghz7xr2kOtvh6p3afVZwWFoHm7IMzPXiFYZtwQelfk8vCkIwsLgcPYkZFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ep1ysSO9DoiUmbYPgACtImMH2ng3eIk5XZYfMbgNfjk=;
 b=G67WnLXv0F7S+KlvNHbY/rKyZokzkFicSI22iG/Fws3fhOi7E+Bz7/tk4siJp543rp8eqf+POHSEiJOIdBpTl2y5J6/5TB6LuYAS7bOmZWS3oEZV+/4A0d+Am5nK5Xl1HdvNFcbHhEu0sY6DwO545bPF6quzCcrWqbI65fl/utUlZ3ZePn7g+dhH3JDt4Eb2UloSkIv/V3u2IeYLlWrxaWIe78oOPde9bQ0F9P5j6pA4CwbGKUMEaHjzRveL9CaN7Ee+yJB6mK30v4JfXSdZUZtQJbFvaAHRddKkdt2IDzgZLNpgU439mdQpjYvtQAYH+WfK4Kt4PhWvWcHq4PMTSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ep1ysSO9DoiUmbYPgACtImMH2ng3eIk5XZYfMbgNfjk=;
 b=nQfBSM4cRfkLhzZXIpOqZyrWfs7mRvFEfCRGOLkQdamSdKAqb7DKzbYu6T9CSz3SOqDqoZ2O5lXjW46HGL4kgx9WaHWyPZ9V1EVDrifzn7yA5kU93KDLpMQ7WUiOoFADji51d9eH4vpFy9711LA0rNcU/X48ayP5huJHssIGKD4=
Received: from MW4PR03CA0025.namprd03.prod.outlook.com (2603:10b6:303:8f::30)
 by DM4PR12MB5892.namprd12.prod.outlook.com (2603:10b6:8:68::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.29; Wed, 15 Mar 2023 11:04:55 +0000
Received: from CO1NAM11FT092.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8f:cafe::86) by MW4PR03CA0025.outlook.office365.com
 (2603:10b6:303:8f::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.26 via Frontend
 Transport; Wed, 15 Mar 2023 11:04:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT092.mail.protection.outlook.com (10.13.175.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6199.11 via Frontend Transport; Wed, 15 Mar 2023 11:04:55 +0000
Received: from ldev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 15 Mar
 2023 06:04:53 -0500
From: Tim Huang <tim.huang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amdgpu: reposition the gpu reset checking for reuse
Date: Wed, 15 Mar 2023 19:03:40 +0800
Message-ID: <20230315110341.248166-1-tim.huang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT092:EE_|DM4PR12MB5892:EE_
X-MS-Office365-Filtering-Correlation-Id: a0c9e633-9cc1-4521-94c3-08db25451c10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zpnVbNxmqmp8mjmdNMNy2GPnbEeU8WZU2PZ4gaWY2SWAqBUl9NfTzSB1AXQGMsYUNlS8WCF/LwlEQmP0AcfqLBvu7bR4DxJd6pWZipzRxz95OH1cG5HRBdpxdTe79OERCLK6vg/ZvZZOGSrd3CM9FbK2dcYs394yjtUEWWjim3Kjelr1rLG0JHWsiDp1Hj7Zqa1oDgUSQi6EpjVPco+WvrwTGoDx1ByRpuK+PwsUwW9HtycN78rNMRIKleAdJrSfELB7ZAsi/+jB8K+Xd1U4i8LhchsaVK6Mw2bjif3LzAVOrDG6Dt2JD7qXcj0n2Rw0hW1/cyzPiyhrDUXXCB8NT4EPUIjJhvh/1uH6YCrw2H5BPnngyU6+UEwmw30aYJtSz5ewnQ0Erb6mAiqG8nAfZ3gsWPpOKmkdhnkBiKG/skTRO1oM+EKiwhw0ttzzn2mvjvQxHLsGS536tGiic2VY+EK+B83Aqw5mkwm6LIbdrc9xv+32c+yUYfJ9TJyfgzBamS9nZFwMgGtg3bXCxJJKdqhOiT7QwkA7SqrqHNMdW+j2dP3qRQ7K0UQLSlEUnSqvr5yWITb3wryKhW8MmQLrdQkriDvIoQO/kMw8zEbsaSuyvgvYPn3mf+Spc0O/JovqDTteoahHztzahS6Y6vgVmHSAv9q+/HHKB+8ThrMkXpivta/76QIChdFmCBPdkZIBXFeF/iA6BxM3jSOpDnSzKOUrrHQzE1TC5lJWaohK+ME=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(39860400002)(346002)(136003)(396003)(376002)(451199018)(36840700001)(46966006)(40470700004)(478600001)(83380400001)(186003)(6666004)(8676002)(336012)(47076005)(426003)(16526019)(2616005)(54906003)(70206006)(70586007)(316002)(7696005)(1076003)(26005)(6916009)(4326008)(41300700001)(36860700001)(44832011)(8936002)(5660300002)(40460700003)(82740400003)(81166007)(2906002)(356005)(82310400005)(36756003)(86362001)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2023 11:04:55.5470 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0c9e633-9cc1-4521-94c3-08db25451c10
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT092.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5892
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
Cc: Alexander.Deucher@amd.com, Yifan1.zhang@amd.com, mario.limonciello@amd.com,
 Tim Huang <tim.huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Move the amdgpu_acpi_should_gpu_reset out of
CONFIG_SUSPEND to share it with hibernate case.

Signed-off-by: Tim Huang <tim.huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h      |  4 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 40 +++++++++++++-----------
 2 files changed, 24 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 5c6132502f35..5bddc03332b3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1392,10 +1392,12 @@ int amdgpu_acpi_smart_shift_update(struct drm_device *dev, enum amdgpu_ss ss_sta
 int amdgpu_acpi_pcie_notify_device_ready(struct amdgpu_device *adev);
 
 void amdgpu_acpi_get_backlight_caps(struct amdgpu_dm_backlight_caps *caps);
+bool amdgpu_acpi_should_gpu_reset(struct amdgpu_device *adev);
 void amdgpu_acpi_detect(void);
 #else
 static inline int amdgpu_acpi_init(struct amdgpu_device *adev) { return 0; }
 static inline void amdgpu_acpi_fini(struct amdgpu_device *adev) { }
+static inline bool amdgpu_acpi_should_gpu_reset(struct amdgpu_device *adev) { return false; }
 static inline void amdgpu_acpi_detect(void) { }
 static inline bool amdgpu_acpi_is_power_shift_control_supported(void) { return false; }
 static inline int amdgpu_acpi_power_shift_control(struct amdgpu_device *adev,
@@ -1406,11 +1408,9 @@ static inline int amdgpu_acpi_smart_shift_update(struct drm_device *dev,
 
 #if defined(CONFIG_ACPI) && defined(CONFIG_SUSPEND)
 bool amdgpu_acpi_is_s3_active(struct amdgpu_device *adev);
-bool amdgpu_acpi_should_gpu_reset(struct amdgpu_device *adev);
 bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device *adev);
 #else
 static inline bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device *adev) { return false; }
-static inline bool amdgpu_acpi_should_gpu_reset(struct amdgpu_device *adev) { return false; }
 static inline bool amdgpu_acpi_is_s3_active(struct amdgpu_device *adev) { return false; }
 #endif
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
index 25e902077caf..065944bdeee4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
@@ -971,6 +971,28 @@ static bool amdgpu_atcs_pci_probe_handle(struct pci_dev *pdev)
 	return true;
 }
 
+
+/**
+ * amdgpu_acpi_should_gpu_reset
+ *
+ * @adev: amdgpu_device_pointer
+ *
+ * returns true if should reset GPU, false if not
+ */
+bool amdgpu_acpi_should_gpu_reset(struct amdgpu_device *adev)
+{
+	if (adev->flags & AMD_IS_APU)
+		return false;
+
+	if (amdgpu_sriov_vf(adev))
+		return false;
+
+#if IS_ENABLED(CONFIG_SUSPEND)
+	return pm_suspend_target_state != PM_SUSPEND_TO_IDLE;
+#endif /* CONFIG_SUSPEND */
+	return true;
+}
+
 /*
  * amdgpu_acpi_detect - detect ACPI ATIF/ATCS methods
  *
@@ -1042,24 +1064,6 @@ bool amdgpu_acpi_is_s3_active(struct amdgpu_device *adev)
 		(pm_suspend_target_state == PM_SUSPEND_MEM);
 }
 
-/**
- * amdgpu_acpi_should_gpu_reset
- *
- * @adev: amdgpu_device_pointer
- *
- * returns true if should reset GPU, false if not
- */
-bool amdgpu_acpi_should_gpu_reset(struct amdgpu_device *adev)
-{
-	if (adev->flags & AMD_IS_APU)
-		return false;
-
-	if (amdgpu_sriov_vf(adev))
-		return false;
-
-	return pm_suspend_target_state != PM_SUSPEND_TO_IDLE;
-}
-
 /**
  * amdgpu_acpi_is_s0ix_active
  *
-- 
2.25.1

