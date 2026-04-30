Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC926CD13D3
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Apr 2026 20:18:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 504F010F45A;
	Thu, 30 Apr 2026 20:18:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MnoJl7Zy";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012010.outbound.protection.outlook.com
 [40.107.200.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB2EF10F457
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Apr 2026 20:18:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oW736F0E5+tSKjeYIhHEBvm0KB3SFOeh5+00y1imowAQ2lcR/YTz09DVSbNcxKbLbrPHNzweJciRmYnJwRSiMnQ5NShS9CIoBe/ILBSzEHSlnzhe0e15BlzMwGq07jtetijZLIODopzwAc7dO+OeVS9/Uxl5MTKI/Vq81l2RN+tB3RfN/F9JHTAcGPcmjBcBgxD+2QoFYnAFw2bNyfUuAjPrxbfoSFMQrI0PwHREzbFbclQ/4aMYBiKdTZWteQmQ7cHNis03r6eSUC5t4r495PRg8xstQG7eywuZeU43POripOfsnVkWhCxiM9w1VLXJM3K1YI597562zuAki/G9fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HXjXmjtxIIxp5oP8zvmyHQfGiWrVOTpCz6/abDHnJ0s=;
 b=U79CAuC2tY2qnJV2aEYIO79vANs1+u8Z93etY0XMaQxSHFBEBjBKcTPftJpLOclRveNdeWcl5J0b2QlRf8hPmwrx+EOv7qTgNn0GCiSrMr0Pq6NNOVcra3Y7wK8tpN0lGsxAG9OAJzEyHBIKJUsC4ghSxmWCb09I0R74Hyu4CCZNJNk+tE+EP95BEpnSKkFkTsNr8oo1XSHO7ZnZcV4OXqUCkUzc/P9FTZXNqphLr7IIiCggKje5U1IOvXZWOwLMkHSaeuTeQdXqyMY/zTjIJ/WVJi2217Qt8GR1n9FolazXIe4XPWcl3aUGCBgI/9LN/s+fVdj6nPoqY8n/9bqtcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HXjXmjtxIIxp5oP8zvmyHQfGiWrVOTpCz6/abDHnJ0s=;
 b=MnoJl7Zy+/ovihazMAVRcbk1OnJ9rXNGvqN0qh4r7RLMEnZsdCnf+a1w6jTOwD/Xe3H2JlXE6TuqZMPXYAZLZXaYr29t+Ng9V58I3/KosnHYl0HbTfL8wNxNLgIHT11xAghlcJ3Y+kBaJSupipkwDjThC1ptacpoAN+7z2YHNHY=
Received: from BLAPR03CA0043.namprd03.prod.outlook.com (2603:10b6:208:32d::18)
 by SN7PR12MB6864.namprd12.prod.outlook.com (2603:10b6:806:263::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.22; Thu, 30 Apr
 2026 20:18:09 +0000
Received: from BN2PEPF000055DE.namprd21.prod.outlook.com
 (2603:10b6:208:32d:cafe::af) by BLAPR03CA0043.outlook.office365.com
 (2603:10b6:208:32d::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.30 via Frontend Transport; Thu,
 30 Apr 2026 20:18:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000055DE.mail.protection.outlook.com (10.167.245.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.0 via Frontend Transport; Thu, 30 Apr 2026 20:18:09 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 30 Apr
 2026 15:18:07 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 30 Apr
 2026 15:18:07 -0500
Received: from AB350-desktop.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 30 Apr 2026 15:18:07 -0500
From: <vitaly.prosyak@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Vitaly Prosyak <vitaly.prosyak@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>, Alex Deucher <alexander.deucher@amd.com>, "Jesse
 Zhang" <jesse.zhang@amd.com>, Vitaly Prosyak <vprosyak@amd.com>
Subject: [PATCH 3/3] drm/amdkfd: Add input validation for SET_XNACK_MODE ioctl
Date: Thu, 30 Apr 2026 16:14:26 -0400
Message-ID: <20260430201803.90458-3-vitaly.prosyak@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260430201803.90458-1-vitaly.prosyak@amd.com>
References: <20260430201803.90458-1-vitaly.prosyak@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DE:EE_|SN7PR12MB6864:EE_
X-MS-Office365-Filtering-Correlation-Id: 374e1156-fdae-44ba-2d22-08dea6f59897
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700016|82310400026|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: Cwh2j/AYvmukk1jEyD0pqM/qa/n7f5o7qqfR7KkjGJc9hXCzA9jEX+lGlIl7SfrYSCUr/BeuG/d+FrQKm/zh7Xq0rZDkn0U2ZUik0tC5mXrsOnj6MM1KMXKG7GG8QzwqLfr3qrh5MH0S1hgm8lZ6auvNpjezzely+q1K8U93c1QYRptIJ6xk81SXBAKkyrwS7mCYO7cKDwQ1IREUEk5rJHRMhNTsXcBdXejDwDO195zuJpFiFekSfhbc4l19/O4wWjnLmMT1Tp4IV4SrLZ7mfz4pUEvL3G/gd3JC7sMVsZPZrjZ8IixSKfk9C6mjVq76yn2kev5JZ8Bc67L4OVmTBHqjiXLUX7u0shOlr9y1diJvD0CZT48dJ1mhv/dkIS/RdFzqZl1VRA48aUUQv8V7tU/kV/IL7yhNL5aSg/REug/1Dk03P1eTkIU9sj1NWkxV3T+TBJbwaJQXDH5fITM5RGR9QTkmVjJ74FZ69X9fycjZ8cpuOudQZG1hfi+YInAxJGHq+JPTxBZJzinQZQ5NtCvYi5utRMww39lH+mL52zyZx4ol7rW19c8/Jg4RZU2SPTi5aH7AEriMFlkBbc+BW74wHcddwlzT26BJIbBdEYjwbtySOiSK6E1u9QkKD62moN2WcYBu8SXdaEHZQFn6AIz2toIHWJbkpyEVWg0wh9XXenS2xCG14T8aTx0VPTRT
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700016)(82310400026)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: UG1UD78F8rTxWmO48jt1dT47yTBYsoXhrzOfk7y17q3ZGpopXuqp/gCLhLeJyvIJqmwt1GEyxHQR0ZSvRweMFbfYDLPCm5WFvxKFJPYsWztm8QSLHp03iEOiwIUl1SIXfR3ie4BgqxJAHngf6tliv/NTj/MW6SPoGG5VGPnb5jCw3FFwsfy//9pNWKTzpi2bvESPDVAaTZ2arXzGibBp9ePPHY/XpuqE3m2Gl3Osrc46S/YWFaTWDEkbOkkFExF6tHKQGxyrBWGwX5Y3FkHY6tyLxayBdnrm/GzL/SwV+j4msdgEP6WQTJhpylfNOQO3yterdyTms/Ay/uLov/PPsWob2cieaS9IVEPM3P1E7Fc5pHWSzEl+W6M+2JxwS759nsQg9wcDf891YPX/Y0WL4//u8uMzhe1jUTFQtQK0GuB/kkP9TESpaSvJ4sUh6gI8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 20:18:09.0005 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 374e1156-fdae-44ba-2d22-08dea6f59897
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DE.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6864
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

From: Vitaly Prosyak <vitaly.prosyak@amd.com>

The AMDKFD_IOC_SET_XNACK_MODE ioctl accepts any arbitrary 32-bit value
without validation. According to the UAPI documentation, only three values
are valid:
  -1: Query current XNACK mode (read-only operation)
   0: Disable XNACK mode
   1: Enable XNACK mode

Currently, the ioctl accepts invalid values like 0xDEADBEEF, 0xFFFFFFFF,
0x7FFFFFFF without returning an error. While the kernel internally treats
any positive value as "enabled", accepting garbage values violates the
principle of strict input validation at the kernel/userspace boundary.

This patch adds validation to reject values outside the documented range
[-1, 1], improving robustness and catching potential userspace bugs early.

Discovery: Found through systematic fuzzing of KFD IOCTLs using the
IGT amd_fuzzing_kfd test, which revealed that all fuzz patterns
(0xDEADBEEF, 0xFFFFFFFF, etc.) were accepted without error.

Cc: Felix Kuehling <felix.kuehling@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Jesse Zhang <jesse.zhang@amd.com>
Signed-off-by: Vitaly Prosyak <vprosyak@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 881ea252b3ad..57bd1e78b3e5 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1716,6 +1716,13 @@ static int kfd_ioctl_set_xnack_mode(struct file *filep,
 	struct kfd_ioctl_set_xnack_mode_args *args = data;
 	int r = 0;
 
+	/* Validate input: only -1 (query), 0 (disable), or 1 (enable) allowed */
+	if (args->xnack_enabled < -1 || args->xnack_enabled > 1) {
+		pr_debug("Invalid xnack_enabled value: %d (must be -1, 0, or 1)\n",
+			 args->xnack_enabled);
+		return -EINVAL;
+	}
+
 	mutex_lock(&p->mutex);
 	if (args->xnack_enabled >= 0) {
 		if (!list_empty(&p->pqm.queues)) {
-- 
2.43.0

