Return-Path: <SRS0=1/L1=MS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A960C4338F
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Jul 2021 12:33:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3391B60F44
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Jul 2021 12:33:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3391B60F44
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C452C6E51D;
	Mon, 26 Jul 2021 12:33:33 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam08on2061.outbound.protection.outlook.com [40.107.101.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4727E6E51D
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Jul 2021 12:33:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QJnciA0gzfK140epBv1+DBRbZCAlUZlg2yGIh+WLJsVOHEWeBjjd1rtsMXb1HCe1c+1bsIV4Rcs7phYIzGG8p8yjpFmUUJdzxh1XDlqveJU9XUVygiLBPVfFVrt9aG2mEYjDGUmsvILCgfgreNIuxWyg/5gFygvhYNyW5fVolItk6+lKboBR5tD70fjnb4+BOZ1VSnD+l5l2DIxGcyJ7KLpjfmdJO35TyWRZ2zxBRZi4g6uPq32WO/5yNgK5tB3eHheqlgrVbXJ9Ea4DGZOrkBJ3ogex9cZpTUjcVdrRybFDlafOWT/XtIyYSbkaz4TgiAay82BCKmbC/qE5E7FFLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MgIts8D0RP6IrlD+XpnOyn4zFjC1IuZdvXDqGfd32xQ=;
 b=C2udBKxAuo9ZhKQOLH0ihgeE9O58HT/PcOHKsjpPTo++4RvMmflnyKG9PmQbB84InKmD4ceNw9gmE5nBQtD0zY+imL25946IrQZ6xN4xXg/uNBqcjk6QsoIkVo3J/Nt2mLxP/O5/vz5tAnVcIolodZwIhkkxLOQyX0iGrhuuupkU1RBDzzsJ4Yf0yF3E3stk3zzO0EgqU3paSITOqTXqRCT7PUXAnni2NVVadzlHoGHQ+oL3oxhY6boFxlZqdzoAS6+gJ069bnd1TIJekMXk7kqL5eSUktibrM4/qqOv45Xah7eV6Dg40WXFP3RdCpsgneD8byQpPf5HLNHcNMiXAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MgIts8D0RP6IrlD+XpnOyn4zFjC1IuZdvXDqGfd32xQ=;
 b=yvxAis0V0vDv5Rz/yKG2jtl99Xn/zm3/ZcQ1AH+F/h1BXvyT6V2J4LG7HkBlk9AaDYKMFTsCYjZG1Ah3ETqxIySZMFFFQryPiwwVyYppKFbLgTggj/t4guS8vzzDgVKHg4VQ/hMuFHm0fr3c+7HY638BKBuWOmACD/ttfv21pug=
Received: from MWHPR15CA0037.namprd15.prod.outlook.com (2603:10b6:300:ad::23)
 by CY4PR12MB1688.namprd12.prod.outlook.com (2603:10b6:910:8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.29; Mon, 26 Jul
 2021 12:33:30 +0000
Received: from CO1NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:ad:cafe::b0) by MWHPR15CA0037.outlook.office365.com
 (2603:10b6:300:ad::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.26 via Frontend
 Transport; Mon, 26 Jul 2021 12:33:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT054.mail.protection.outlook.com (10.13.174.70) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4352.24 via Frontend Transport; Mon, 26 Jul 2021 12:33:30 +0000
Received: from ETHANOL.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Mon, 26 Jul
 2021 07:33:27 -0500
From: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
To: <Alexander.Deucher@amd.com>, <Lijo.Lazar@amd.com>,
 <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Rename amdgpu_acpi_is_s0ix_supported
Date: Mon, 26 Jul 2021 18:03:13 +0530
Message-ID: <20210726123313.3722569-1-Pratik.Vishwakarma@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 27d57624-78ce-4027-0a12-08d95031933f
X-MS-TrafficTypeDiagnostic: CY4PR12MB1688:
X-Microsoft-Antispam-PRVS: <CY4PR12MB16888CA1F63E99B8BBEE67F180E89@CY4PR12MB1688.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b4o8pfEhmIGoP3sxrtwy4N8FSNjrTigeGzAoAbekIJc7ZFHdnhg0COBrh2Kt1MWalDnl9L8iSoKetwRzfm6NEsJVMoZz7iqjisN5iJAcTthCX8sXCWUl959f3lmSm8xDa1LCXUINL4pJbCeg70PzNS6yqcMZjfAEtS8Ld3sAQDgqJphW5vP6UZZrVsug12T68vbEwi99bG9GPnQUb47AOr/wPMfjy6E7hwHB2SfXNoPTXNycDevcMIVxHF/XztYkykPl0IikpOR3MIfL2ejGiA36XfiblytR6hlr59aljKTiT31A9uLEgyMHW1KiyhvHwGRE9diWfXIYk6qJMBa1WrY1oOl1i+HfmebElwzm2U2iM9T8Wm5ZzZIwPmhF/p/ta1bEwLEmvqAKph9P8VYYFK/OTuG2OuNUqwGjS+FLLyJvkHIbFeuArRRD6Z0kcH6OZFvXnuA0cPaMZt52TBy+qIbJcUz+4xClHnHvLddPp1Pk2/bwWf2GmdVJ0Vdf9mNM7dCb0yHGN3opN4VnHtl/hUtbZwGNVRAOXgnzo880WoP2PMEcidquj/t2necK5ZjWf/4lI7+qa5e13MMirt0pVIH/jWU0laanozskO1rVQC6D4nXpvmwEWJcFPzbNosp4SW9veoBYRlO3UmTf820H+Kucs4tpSEnGMnsQ3Ag2HSOXZN1SrWjvT5iC2NapP+XrdYBKDcrYG96J3+XreU4QijVuyHOFt9DbRD7xpHm/zBM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(356005)(8676002)(186003)(316002)(70586007)(70206006)(1076003)(47076005)(36860700001)(16526019)(26005)(8936002)(81166007)(86362001)(2616005)(7696005)(2906002)(6666004)(36756003)(426003)(110136005)(83380400001)(82310400003)(336012)(5660300002)(4326008)(508600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2021 12:33:30.2068 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27d57624-78ce-4027-0a12-08d95031933f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1688
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Rename amdgpu_acpi_is_s0ix_supported to better explain
functionality by renaming to amdgpu_acpi_is_s0ix_active

Signed-off-by: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h      | 4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c  | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index dbaa79ddd468..d10baa3338bc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1390,12 +1390,12 @@ int amdgpu_acpi_smart_shift_update(struct drm_device *dev, enum amdgpu_ss ss_sta
 int amdgpu_acpi_pcie_notify_device_ready(struct amdgpu_device *adev);
 
 void amdgpu_acpi_get_backlight_caps(struct amdgpu_dm_backlight_caps *caps);
-bool amdgpu_acpi_is_s0ix_supported(struct amdgpu_device *adev);
+bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device *adev);
 void amdgpu_acpi_detect(void);
 #else
 static inline int amdgpu_acpi_init(struct amdgpu_device *adev) { return 0; }
 static inline void amdgpu_acpi_fini(struct amdgpu_device *adev) { }
-static inline bool amdgpu_acpi_is_s0ix_supported(struct amdgpu_device *adev) { return false; }
+static inline bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device *adev) { return false; }
 static inline void amdgpu_acpi_detect(void) { }
 static inline bool amdgpu_acpi_is_power_shift_control_supported(void) { return false; }
 static inline int amdgpu_acpi_power_shift_control(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
index bf59bb263816..0c281c7f5cea 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
@@ -1031,13 +1031,13 @@ void amdgpu_acpi_detect(void)
 }
 
 /**
- * amdgpu_acpi_is_s0ix_supported
+ * amdgpu_acpi_is_s0ix_active
  *
  * @adev: amdgpu_device_pointer
  *
  * returns true if supported, false if not.
  */
-bool amdgpu_acpi_is_s0ix_supported(struct amdgpu_device *adev)
+bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device *adev)
 {
 #if defined(CONFIG_AMD_PMC) || defined(CONFIG_AMD_PMC_MODULE)
 	if (acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index af1710971ff3..bbc6bfadafd6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -1468,7 +1468,7 @@ static int amdgpu_pmops_suspend(struct device *dev)
 	struct amdgpu_device *adev = drm_to_adev(drm_dev);
 	int r;
 
-	if (amdgpu_acpi_is_s0ix_supported(adev))
+	if (amdgpu_acpi_is_s0ix_active(adev))
 		adev->in_s0ix = true;
 	adev->in_s3 = true;
 	r = amdgpu_device_suspend(drm_dev, true);
@@ -1484,7 +1484,7 @@ static int amdgpu_pmops_resume(struct device *dev)
 	int r;
 
 	r = amdgpu_device_resume(drm_dev, true);
-	if (amdgpu_acpi_is_s0ix_supported(adev))
+	if (amdgpu_acpi_is_s0ix_active(adev))
 		adev->in_s0ix = false;
 	return r;
 }
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
