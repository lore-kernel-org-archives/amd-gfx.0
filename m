Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D586B10AB82A
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Mar 2026 21:38:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 766AD10E315;
	Thu, 26 Mar 2026 21:38:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="c3ccN9v0";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012022.outbound.protection.outlook.com [52.101.43.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E8E0F10E315
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 21:38:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xCOE64T05DDb8OXpjAR4Qs0Bag1Mx20X/Tl/Pb1U0AzhymZeHKaykF5rS1eYFhbMsjgLgxCuj52ckPVXiWpuMAcUMVvD9z2wNNS3c8ji5wQJ0sD20L/6KIoVo9uV3Rad79MjJAD3ocjAYbO+iFag2kDIV6v3RwV7nVITggYu10f2DpO/NRS6/jhrUynG/li6r6Yqn71oSpiPxIm+ncr0/JJzX+LuzuPsDOrEpEuIZ5AfBmLBm/oqF6ue/MrMEDcuSGS8sBDi3L847Kpuu5oHsqvpPesAPX+oq7hVoZLzezpyL1G+C2R7tXR7wdIJ9ieXaiiG2QcOq6m7R/64hYjaIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Alk1OhKJd6h8hiq/SjVxI13je0RatHNc0kCy/DSL/jE=;
 b=lEa+bn1E6sxGK9PSSFQPQ1htKHcUQevr3yAjjmwx//cf+/yc2nA2AgQ6P5Gr/OarWtBJleNP6RyHEa5vEsvleNrPUpvtp/pgCMhWjMpTQng7fQOMDnQSCUWH4hwGt/lL43k8nue7fVqSbar1kI6Y6B/D3hDgJTUGSHMAoaN4rNBSSXhOsrDcmSuMdTKICcThj8yETMqw3mXHQFEBOX/OjKn1M2MK2pHCuxgkp19JA6AR4bOZNT3cJnek1ZwF5QQE3r8qCtmPXIXhF0vckvLwnpk7C7qcgLTQhT9vyclEpx2jMvYZoydDv5VSaO8ET1oWCcQNYnr+LFhyZuJ0YCoEbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Alk1OhKJd6h8hiq/SjVxI13je0RatHNc0kCy/DSL/jE=;
 b=c3ccN9v0ZOPqU6/OHbDF2p2mH4TWEzwRbAe44tsrumGiVT3CEUURygf/vRXBOe1w3/+32yk4ubBCFVEuLbSqB5MBYTWhoXxXBip5WehzMuQG0JTosAngJAGznx0rsJG0l+ZsW8sJGritUvny67KrcE0teDhP6uyuKLIOmNYag0s=
Received: from BN9P222CA0026.NAMP222.PROD.OUTLOOK.COM (2603:10b6:408:10c::31)
 by MW4PR12MB6924.namprd12.prod.outlook.com (2603:10b6:303:207::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.8; Thu, 26 Mar
 2026 21:37:55 +0000
Received: from BN1PEPF0000468C.namprd05.prod.outlook.com
 (2603:10b6:408:10c:cafe::51) by BN9P222CA0026.outlook.office365.com
 (2603:10b6:408:10c::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Thu,
 26 Mar 2026 21:37:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF0000468C.mail.protection.outlook.com (10.167.243.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Thu, 26 Mar 2026 21:37:54 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 26 Mar
 2026 16:37:54 -0500
Received: from AB350-desktop.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 26 Mar 2026 16:37:53 -0500
From: <vitaly.prosyak@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Vitaly Prosyak <vitaly.prosyak@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: add CONFIG_GCOV_PROFILE_AMDGPU Kconfig option
Date: Thu, 26 Mar 2026 17:37:46 -0400
Message-ID: <20260326213751.5741-1-vitaly.prosyak@amd.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468C:EE_|MW4PR12MB6924:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e783b4b-1c96-40a4-a2c6-08de8b7ff095
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: d7lQptTmYgdhUMFU1PI0krin1CKSA5xjHUBH/1uzvSrqLB77dX7qkI174EgFtbRMOEfxobgdZOdCOtELOsYHpMbOi6oNLiBVgWRiNgCdeIXAUWoqE6yYa0Xm6Z//Omy5p5Nphl8f44bl6g682QpgNTFE1wbblQElHhnMEeFWMm3INKxe6nAS3fXsr8d3EbEsn/5Ogh9A5incDqyxQSy3m0c+oXu21XUsdz5ivFAR9r/P9doAWdFPA1WATJvlCt0yre3KnfvgdLxWE+Q2vDIboIhl1vchy359+faB7TKTvVuAP58Dj9BFs44xsIGXPUQ2iYRXv/+xAw9HbUZcK4NVdwKsMOJNihdPU/GtBieyDi9wmloV7/Hgof2JFX6Da7n+E8kegJTxPdoGGYwWw4k5M55zqiVl1Ft9zEBR46YYCeMY7lMlHu7n89uK/Kw1YzOPtAdSdhL/8t0FiXC46Ji4lRa/xfINSK9vRkhlGefCvtMSK/j7grZlW6SJR2BDRtmZ5CiCazOPjglrSYIbLIfMa5wnKiMBIcFReV17ImKxWAwu0ImNixCpDCAS+wdARO4bFqb6B8HrhasaAevObX2K6eHlWQ7/q4svX6QC6RQpPFYTW6/o2L4WrEUo1aeB/sgTga5+JKoUV9gx2Kqjkx5zVB0jPd+79mnOeH6jpPLMvKHbAe6wmKvQJPSyxoJl6q2VZqLJ1xXaR8mGXwK/w8a4K2I/1allhAuSmnfKaKJPALhrXyyMjnQhH7Wn7rw2OiGvLp9wdLJKMQ0I+S6uGhrfvg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 1oFzwocl2wJGR1FTbvQYWxmTIR9VkRX+waw9uobExLW+8kUIV8c6lkMsWYzCsoFnUMaT4Gn06zI8IysQTWvrKIrMQj46w3wjUC4COuK8mCH8y5B2eETyIQFv+4iUAg2odjJUW5ZKhmVSyilnYGeXM7uhyrOkHlaqD9X7NQBfkjcRd6uRQGHJPpO9xxB9OlK8eWfE3p1etsr7e5ik9UH46PgVOsN0fhminVPHPzdazUJseJFhsWHJi8Co59mcIa5pTQSzLah+MJX+VWkRuCrBkPerL3AaNOC/sLBlEWJ/KE0KsQMd6XRqnTUxsYEIOJPCeJu3Fww26orYMGh+tV5ZU6UXKmwCjQsgRd62+ukBeEF/jz3tEmitM9b6jxrSNLnMNFrZgP0Evgby/dF+DtCIjN0ibSukgic4rCLDKwqHDYkGC72Tbg6/nKDU2YU9fNvj
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 21:37:54.6212 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e783b4b-1c96-40a4-a2c6-08de8b7ff095
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6924
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

Add a Kconfig option to enable GCOV code coverage profiling for the
amdgpu driver, following the established upstream pattern used by
CONFIG_GCOV_PROFILE_FTRACE (kernel/trace), CONFIG_GCOV_PROFILE_RDS
(net/rds), and CONFIG_GCOV_PROFILE_URING (io_uring).

This allows CI systems to enable amdgpu code coverage entirely via
.config (e.g., scripts/config --enable GCOV_PROFILE_AMDGPU) without
manually editing the amdgpu Makefile. The option depends on both
DRM_AMDGPU and GCOV_KERNEL, defaults to n, and is therefore never
enabled in production or distro builds.

Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Kconfig  | 17 +++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/Makefile |  4 ++++
 2 files changed, 21 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/Kconfig b/drivers/gpu/drm/amd/amdgpu/Kconfig
index 7f515be5185d..7fb0b93bc1ca 100644
--- a/drivers/gpu/drm/amd/amdgpu/Kconfig
+++ b/drivers/gpu/drm/amd/amdgpu/Kconfig
@@ -103,6 +103,23 @@ config DRM_AMDGPU_WERROR
 	  Add -Werror to the build flags for amdgpu.ko.
 	  Only enable this if you are warning code for amdgpu.ko.
 
+
+config GCOV_PROFILE_AMDGPU
+	bool "Enable GCOV profiling on amdgpu"
+	depends on DRM_AMDGPU
+	depends on GCOV_KERNEL
+	default n
+	help
+	  Enable GCOV profiling on the amdgpu driver for checking which
+	  functions/lines are executed during testing. This adds compiler
+	  instrumentation flags to all amdgpu source files, producing
+	  .gcda/.gcno coverage data accessible via debugfs.
+
+	  This increases the amdgpu module size by ~50% and adds ~2-5%
+	  runtime overhead on GPU submission paths.
+
+	  If unsure, say N.
+
 source "drivers/gpu/drm/amd/acp/Kconfig"
 source "drivers/gpu/drm/amd/display/Kconfig"
 source "drivers/gpu/drm/amd/amdkfd/Kconfig"
diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index 6a7e9bfec59e..db66c6372199 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -27,6 +27,10 @@ FULL_AMD_PATH=$(src)/..
 DISPLAY_FOLDER_NAME=display
 FULL_AMD_DISPLAY_PATH = $(FULL_AMD_PATH)/$(DISPLAY_FOLDER_NAME)
 
+ifdef CONFIG_GCOV_PROFILE_AMDGPU
+GCOV_PROFILE := y
+endif
+
 ccflags-y := -I$(FULL_AMD_PATH)/include/asic_reg \
 	-I$(FULL_AMD_PATH)/include \
 	-I$(FULL_AMD_PATH)/amdgpu \
-- 
2.43.0

