Return-Path: <SRS0=t0+e=BV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BFD9C433DF
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Aug 2020 13:27:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D419D20658
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Aug 2020 13:27:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="wwdsIzt4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D419D20658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8749D6E508;
	Tue, 11 Aug 2020 13:27:43 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2050.outbound.protection.outlook.com [40.107.92.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5F9A6E508
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Aug 2020 13:27:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oOD1cSfbvWesIcxoSQzsXOyHPfllqGW0XSTi3T3KfLxo9r6F62UANHZi0htja/U7Muv4GiVN1WHY4c7EkpIkEPhTVu6aRTnEfCF4OAgcvhi2rkknaDYGt6fcu/cMZREIGYR9Dr7gwmwY7UPbruxtkCAmQ10R1S74jfZfvzZFNEDdWX4Xk+fzhwiy0Th6t/a4Lv1zrR4JUIoicd4UGpMllC5miKyZY3tggBn1TFoAdKsnE9f9eEFeTBaHwU2uCIZZ2VoLyq8QrNW4LaqDnlE+7mGpxERFUSC4KQkYr20Y/8JJk7Giw9EZpdfQAiNcIxjr412xCAqfFYu14vUfwFnswA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LE0nmbpjqkd2apSpk80qDUChr57MvrAZ91q/31hvfpA=;
 b=fkC/MgG+0qvsSeR4dePamIflVN6dwDhwVrv9HTBWYlwcfbH9rUZZsgbbkTVGAnY+88pBtT3j1I0er6ueMfp+Cl6vcaHxTR9F9ctgv/6fBS80yd5Ph/G1sEM3DOfxa0/exBdARPgNGfKDu7Aw8rnSm9pQpl4uE/M4h8wlrnkbQaxkPjbhYlkpa3DOVqLLFnC8Hr+hCYB6pxEOOsGr/uKAeOpwNob0vQSNp1MHnIY7MUt4/piNlcGAr5rJj+ymZdjajpQHwDKiYm55Hp2vw+G4QPr5ZasOLNQg1XFA+EBc4AqcGfV/420/PzBMELaBsLzG4nbZ70x988rHMg8eFfo3uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LE0nmbpjqkd2apSpk80qDUChr57MvrAZ91q/31hvfpA=;
 b=wwdsIzt4ViivSh6bGuwNEZg5G01L8YPWkumXOOFHC04APiUf1K7xIQHleF+GA+QIn/3Xj8pyZqnuMlazB2J/Eh+O8dwnh75WCpdId+dZMLGMG0rJvf5/D1UDvOPVzOxrPJ36KpgZHeiRrkQ39ttkhX5wP/LqFqlpHKJbK8CRq8Y=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3916.namprd12.prod.outlook.com (2603:10b6:5:1ca::21)
 by DM5PR12MB1595.namprd12.prod.outlook.com (2603:10b6:4:3::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3261.20; Tue, 11 Aug 2020 13:27:40 +0000
Received: from DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::e8b8:d8a1:5adb:614d]) by DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::e8b8:d8a1:5adb:614d%4]) with mapi id 15.20.3261.024; Tue, 11 Aug 2020
 13:27:39 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [RFC PATCH 1/1] drm/amdgpu: add initial support for pci error handler
Date: Tue, 11 Aug 2020 15:30:53 +0200
Message-Id: <20200811133053.71123-1-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.27.0
X-ClientProxiedBy: BN6PR03CA0101.namprd03.prod.outlook.com
 (2603:10b6:404:10::15) To DM6PR12MB3916.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brihaspati.amd.com (165.204.84.11) by
 BN6PR03CA0101.namprd03.prod.outlook.com (2603:10b6:404:10::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.15 via Frontend Transport; Tue, 11 Aug 2020 13:27:38 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [165.204.84.11]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 667463db-338a-4ab2-3e9b-08d83dfa51b8
X-MS-TrafficTypeDiagnostic: DM5PR12MB1595:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB159560E248E3D375CBAD9C078B450@DM5PR12MB1595.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Rt5ia4bcsKlLQdXqSt+5DcChRr3ujJvNM6pb8bkjL0oE3GVl5ru4l1so3jaIas67yeIZZB3y/eobChjBoryaeESQeH8mVzyd373ig3TKlSAabjvlHSBF2g9rVU0xMSI7Dowp8t9SYtAv+/NfBcxa/ZFNCA3X4pp4S/SnPzZV965nbA8Ycb1twPm+dIiNCxLKTtTurEYuy4M6vhCfkfDKRTcXitzNOx1RriVLuep/bTvTU2CLyr7iq8mT+eKOwsIBeoOg1Pbk+z3b7LymCu6nZWSYMXH/kyZEi9cOoridk5vvvvQSDVt0RHNpx0bWRTDjxsXLFR+Y76DADbGD32ptRA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3916.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(376002)(346002)(396003)(136003)(366004)(956004)(1076003)(4326008)(83380400001)(66476007)(26005)(316002)(16526019)(186003)(66556008)(44832011)(2616005)(6666004)(66946007)(478600001)(8676002)(36756003)(7696005)(5660300002)(52116002)(86362001)(2906002)(6916009)(6486002)(8936002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: +YCFSrzQZMUhYcHiavddkiwD9ZQ4k/aYM3cfd3XooMaRwrQfl9oAdj7LnApabmHVLIeD8M1JaWGWXmJD36DpWVQDIEFo4GLK1Khqfo5uuMe2SMZ8C8UpoFMkhoNWjWcDZWSviLjyDbvY3eFt9io1YrA2lMGcsOqg6JFfxiFI/7pyfAQdHADKPHu3GOObjz6TVLfXldrtHw07HPzqUsjsH6aynb+LR7kVs0MLqlhU8oXEqX5IeTMcDlFrgWtzyQzPg5+tfwTDHDBy/Bfm8s8UQ+pLLTrJFhjMWJJ0WS1decRvueLgclpE6ftyuQEaeP6HOYNI3Zrt2AqE5h6oEpZPAnrMxfjxFuaXetDzIPzQAFRUbHVE49ACQv3sep9T4zs+8OsdTQg5pCCKRo6Zpu062VYKex2qeO2L0nOkIfzviPOwIZTzHPmjrkJiPcB+mLD6BfxICbWNghW//hLhtyhCieOnJGCC05057mYHNQ2s2D3GBJc9dKM5uJsQRTBKzWuq8C8rmw/JVrJQBIvtfH9V/fGekIM9jsi9hDMzeecyl5K/Ykn++bGNs5AK5AxrkA6V5282/ydaWbAbOO96lEJLeMVYKJBnlL9Dm8+ACz3R+TD6Z9fNZI6iQEbQdwejqrjR1qhi6xJznDHnuzGRh/Zhyw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 667463db-338a-4ab2-3e9b-08d83dfa51b8
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3916.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2020 13:27:39.8570 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lHXWelZad6hjvW9HJzX6TiNivXeoEPmAqSemr9540HsYmi5/bbLyeA7CVAiLKLnqHAv+VcbiijzxhHX4YVmYZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1595
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
Cc: alexander.deucher@amd.com, Nirmoy Das <nirmoy.das@amd.com>,
 christian.koenig@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This patch will ignore non-fatal errors and try to
stop amdgpu's sw stack on fatal errors.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 56 ++++++++++++++++++++++++-
 1 file changed, 54 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index c1219af2e7d6..2b9ede3000ee 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -35,6 +35,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/vga_switcheroo.h>
 #include <drm/drm_probe_helper.h>
+#include <drm/drm_atomic_helper.h>
 #include <linux/mmu_notifier.h>
 
 #include "amdgpu.h"
@@ -1516,6 +1517,58 @@ static struct drm_driver kms_driver = {
 	.patchlevel = KMS_DRIVER_PATCHLEVEL,
 };
 
+static pci_ers_result_t amdgpu_pci_err_detected(struct pci_dev *pdev,
+						pci_channel_state_t state)
+{
+	struct drm_device *dev = pci_get_drvdata(pdev);
+	struct amdgpu_device *adev = dev->dev_private;
+	int i;
+	int ret = PCI_ERS_RESULT_DISCONNECT;
+
+	switch (state) {
+	case pci_channel_io_normal:
+		ret = PCI_ERS_RESULT_CAN_RECOVER;
+		break;
+	default:
+		/* Disable power management */
+		adev->runpm = 0;
+		/* Suspend all IO operations */
+		amdgpu_fbdev_set_suspend(adev, 1);
+		cancel_delayed_work_sync(&adev->delayed_init_work);
+		for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
+			struct amdgpu_ring *ring = adev->rings[i];
+
+			if (!ring || !ring->sched.thread)
+				continue;
+
+			amdgpu_job_stop_all_jobs_on_sched(&ring->sched);
+		}
+
+		if (adev->mode_info.mode_config_initialized) {
+			if (!amdgpu_device_has_dc_support(adev))
+				drm_helper_force_disable_all(adev->ddev);
+			else
+				drm_atomic_helper_shutdown(adev->ddev);
+		}
+
+		amdgpu_fence_driver_fini(adev);
+		amdgpu_fbdev_fini(adev);
+		/* Try to close drm device to stop applications
+		 * from opening dri files for further IO operations.
+		 * TODO: This will throw warning as ttm is not
+		 * cleaned perperly */
+		drm_dev_fini(dev);
+		break;
+	}
+
+	return ret;
+}
+
+static const struct pci_error_handlers amdgpu_err_handler = {
+       .error_detected = amdgpu_pci_err_detected,
+};
+
+
 static struct pci_driver amdgpu_kms_pci_driver = {
 	.name = DRIVER_NAME,
 	.id_table = pciidlist,
@@ -1523,10 +1576,9 @@ static struct pci_driver amdgpu_kms_pci_driver = {
 	.remove = amdgpu_pci_remove,
 	.shutdown = amdgpu_pci_shutdown,
 	.driver.pm = &amdgpu_pm_ops,
+	.err_handler = &amdgpu_err_handler,
 };
 
-
-
 static int __init amdgpu_init(void)
 {
 	int r;
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
