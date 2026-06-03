Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 914B3CD6E6A
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jun 2026 11:45:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 00A7F10FC83;
	Wed,  3 Jun 2026 11:45:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aiRXEXdL";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012016.outbound.protection.outlook.com
 [40.93.195.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 18F9110FC82
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Jun 2026 11:45:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nJXHVtUxZ7H9kbQ9J4uHp/wpCpRyJd9bggn8iTLN9RwkRgAMjCKitxm+qWhGMMUqvmtTb5FLxJBUnPNDGU6c9OI72Yi1M0PchqvNNHQIMkyfedbP10G+43IMcbrl8ttNkOSa+Kx7GmPdCsOUOxnQcOeVHg1E4loH7ec/w2jpvaK89De5e/sOOIqp8QB/0A7Io6flhf1G6AKE6RCYBFq87P95rK2yExD1HWq/EmPJA1S4M36CFvoJU4orfRKqn8B8oLRafKpSdHGPeINyYUr9p5Etz6MTQnSOFhr0hOk2wEQV1J/Yp+34qi922I7EFFLhWV+AvM0qbHH+/npAOSxaOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0nrL7dsWB4CT6mLsPzNM5RbsWwXaR2tNLrZLE3awls0=;
 b=stjwdAX4NnYBNrjdDpU44sylOvP/2sMp/JyNkKtd/4cvY87NZ+jHv5LTLmvqa4DjjtmF9FOnblzA5NHwIR9NC7JcnSxVcbMwAbP5NdlygNWNyMtc/nQqBi1Iy9A2jlVXUqvAlhKW/0IJUt4535wF7/tE8HaFbYMIWbx4XcOaJEE9OZ5h4koZE7HK4eDu0uvUWdD3yBr93hFkZCFeBrvxpIjIn6HtglVHLw0wRC5PfpkCabkD1FNnnhG/rkVDowiqGdCi5mGb1igKFbzlbBmUp/fZ8Q11N3O/cqyn4JkXGuSvpLFJVPGLPwhE049w6q9lETG8KSForRLOHddek2XD5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0nrL7dsWB4CT6mLsPzNM5RbsWwXaR2tNLrZLE3awls0=;
 b=aiRXEXdL4nYAW9ErTlvqApNxzAbi80UWythmY7UOsIt3PDop147NmSjYq1w6I81mnadHzG1bRhrV6ioJiGMZupchg0GfOGTAHIB6yaW2SY2DehS+qhT93NPnKQVbOZlb3NKd4cHjGubKxKHWYTnp4OOMNE3OQFqsx6lWabmeQlI=
Received: from BY3PR10CA0004.namprd10.prod.outlook.com (2603:10b6:a03:255::9)
 by SJ2PR12MB9138.namprd12.prod.outlook.com (2603:10b6:a03:565::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 11:45:15 +0000
Received: from SJ5PEPF000001CE.namprd05.prod.outlook.com
 (2603:10b6:a03:255:cafe::9c) by BY3PR10CA0004.outlook.office365.com
 (2603:10b6:a03:255::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Wed, 3
 Jun 2026 11:45:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001CE.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Wed, 3 Jun 2026 11:45:14 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 3 Jun
 2026 06:45:14 -0500
Received: from asad-mlse-vm.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 3 Jun
 2026 04:45:12 -0700
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <lijo.lazar@amd.com>, <hawking.zhang@amd.com>, <le.ma@amd.com>,
 <shiwu.zhang@amd.com>, <alexander.deucher@amd.com>, <kevinyang.wang@amd.com>, 
 <asad.kamal@amd.com>, <Tom.StDenis@amd.com>
Subject: [PATCH v3] drm/amdgpu: Gate debugfs MMIO access on kernel lockdown
Date: Wed, 3 Jun 2026 19:44:59 +0800
Message-ID: <20260603114459.938031-1-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CE:EE_|SJ2PR12MB9138:EE_
X-MS-Office365-Filtering-Correlation-Id: 4feb2b12-b40d-4728-abd7-08dec16593d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|18002099003|3023799007|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: Z0is2SiqpjVDRQaNecbThcjWjlBly7oMnxFD22//1zEPXVg7ZVw9qVXUr2nBaKZLmpYK5Z5NbPzpsZ1YIxVevVwe1oR7lFDNUOghMNyIbZuVhOjLKq7Ib+y/OJy5kM2ob99IJNMSdJL1NHUumqbXoQ8hTPP3e5ZAUSFueXCdVtSv/fYSw6QKn+9HOlKAKKtd5oJIV3l3HqUY59oC67aC/x1lT/JknSm08e2tMh6jKpj2YUW1Qng7A1oVVe8S0V0VHhucI4WS/p64I12Yth8GlKrfPtVIc5SC/Sn4ILAe+RTMSCFqHircQaiIjFuiqP3FhMBhbRtr7QPGDN3GigKd1TN0x4VsirFTNR8WS9gRr7liDu7/S2ADEo69cUxWx1EVbqnu6wZRX1OgLYN+PlgCF/uKcWiBrQKrBdr28Iv1sF8NTywdV3XtZW0LynQSL4rz6pO29FBBxNpRMDRAesfnW0hmzhPM+Laesdkf2Vnj29DBw6B/jomxLx0g6gCTM2NSKz/PDmdgq+iDxgiDMlL6fGV4QO3iSbWPFcFB81KRacE64tvS2DbXAnmEkaCMIacfaJHc+mZzkZtg2cdyD7LEhgRGGMrHKNTVfehCRroqrCB8kc2/zzAPYdVdG0R6jUGuquDsCaQa7RnXogu2CIe1cIfu3Jn9Fo1S+M2O/shUl7Xgw8daPytSjA+ON2NGI6blLRpLp89Ha8+Q1+2ZjhImD4jCWGsxdQJd2jYTIEMRHjI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(18002099003)(3023799007)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: IMDP+BMzDkpBmqVU60z3K/GpZXun2kSr6pwlnomboL/J7DbV41Z/MMiAJipKo2/4Knujx9PcY4e4AMKK94AQ3U6nV0RhT7G9b+BkxF0LWQ2d8jDV791pfY9lL/C/9zERMzY57Kiz2uQQlZqhU1pGS2ZDaknNdaPgehARZLcZPxqCYbnz8JY2xUs1KoYmIxuEpKo+0r6wZx2JWvlbHpctJ0wTzBJ78OY8ejz3ounLEToBZhEC9Jj+KBP1dhn2gauI9UtVtNajn3IzrAT10Gd6RmJMXWZy1Bd7IYgaMyb57k/7BG5qTfYIHf/CnZQpQhfnG5xYhZOqRyNXLgP+hrX7BQaHWCD0nwWP64zYsBk9kxsan/JYuQ4V9HlJPjomsWRvUHaIkzAF4DmvatceaBijlKBDpZ3AJjtspsCxQHIuvsuDYePygsJLvYYCVWI7DvvL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 11:45:14.8105 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4feb2b12-b40d-4728-abd7-08dec16593d2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9138
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

amdgpu_regs, amdgpu_regs2, and related debugfs nodes allow
arbitrary MMIO read/write via RREG32/WREG32 without checking
security_locked_down(). On kernel_lockdown=integrity systems
this bypasses the same restrictions as /dev/mem and PCI config
space sysfs.

Check LOCKDOWN_PCI_ACCESS (matching pci-sysfs) at the entry of every
debugfs handler that performs direct register access.

v2: Use consistent check as per previous check to use
LOCKDOWN_DEBUGFS(Lijo)

v3: Do not create any entry from amdgpu_debugfs_regs_init() if
LOCKDOWN_PCI_ACCESS is active and log once. (Lijo)

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 0ce6e2e4342c..5c4d4ff001ea 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -26,6 +26,7 @@
 #include <linux/kthread.h>
 #include <linux/pci.h>
 #include <linux/uaccess.h>
+#include <linux/security.h>
 #include <linux/pm_runtime.h>
 
 #include "amdgpu.h"
@@ -1739,6 +1740,12 @@ int amdgpu_debugfs_regs_init(struct amdgpu_device *adev)
 	struct dentry *ent, *root = minor->debugfs_root;
 	unsigned int i;
 
+	if (security_locked_down(LOCKDOWN_PCI_ACCESS)) {
+		drm_info(adev_to_drm(adev),
+			 "amdgpu: HW debugfs nodes disabled (kernel lockdown)\n");
+		return 0;
+	}
+
 	for (i = 0; i < ARRAY_SIZE(debugfs_regs); i++) {
 		ent = debugfs_create_file(debugfs_regs_names[i],
 					  S_IFREG | 0400, root,
-- 
2.46.0

