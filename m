Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AD91C4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Feb 2022 18:59:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 105EC10EAFA;
	Fri, 11 Feb 2022 18:59:47 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2058.outbound.protection.outlook.com [40.107.92.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCED010EAF5
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Feb 2022 18:59:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KCQow7xrYtaVw/svfHEVN2GX1DgOZi7G0E7IYM1fOG0paU5we1juOZ7MGXT5TuicMGPV60YNhZZRi1bimHHo2OcH7402PrFnqJfGIRj4a96ijS1zk0HfPGUhzR4nAj3iz62v4m2irw7tjbmxu/K6ej0314UF2UmotZI8Ju/pd2ueNCPAIc2g4QeukMG9xzBgcbJiERIkMz61fEXDosnmmsw2yWQezWQbJrTenEz/5sp+E0YqMricIAC965Ku2ij4uw6Lt80T0yZ079X0lugImhYUuMMBd1q86XhKyKp6l2HkCof4fMaWLjD52D3+qFCpMq0iRAXrXP027q9mCe0VGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hTcQ8s18eFo65thvAR6X0JjqhIgfA10ABMWacXvnFYc=;
 b=XaKzMxRdFaCeQeNcGwKoV7McZflIQza15197XvZGZISr9lGR1zeaYDU4+C96+a2QlCe7QX7Lrj7w5+Bhyb5TgoLl4kKudZLK/UAKIATbYRUWzyxzB3gTYqeBxOFNfMkuX0uTGR/5ekeERQIkMZMU76NO8k3R4V+vy+7gYbXP55cwARYwoeED92wRQTlcvRMuppyCfKui9OBFS7lkkOeaujFM2uSAMWFnJCrkQOYAQ3oEv/uh/X+m5cIacZ2i4IF0Ev0q7JiEDVmGGd9DBYZ6r9VsiSlaWAq3klXHe1Z1FGBtDAwtN6prhQ0nC2P4HYzMigxuBKPwmeBE6K6qllqb8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hTcQ8s18eFo65thvAR6X0JjqhIgfA10ABMWacXvnFYc=;
 b=xjhbw0U62cNOmYxdB7Grf7RjOQtgK/FhQqkPBXXPCuCc2kU4s7p5CXzsHDg+non+EfOXdJ7f3NIDhPfGHDXAXkqpv6IE/Lmlwtjpav8d1hMog6amO54Qv3zfF8NxdX4jy6JNc+PB95yqDB0pTjwVYPfn3gMmOXLuJmipFrQDTgA=
Received: from MW2PR16CA0050.namprd16.prod.outlook.com (2603:10b6:907:1::27)
 by MN2PR12MB3070.namprd12.prod.outlook.com (2603:10b6:208:c1::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.17; Fri, 11 Feb
 2022 18:59:40 +0000
Received: from CO1NAM11FT035.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:1:cafe::80) by MW2PR16CA0050.outlook.office365.com
 (2603:10b6:907:1::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.22 via Frontend
 Transport; Fri, 11 Feb 2022 18:59:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT035.mail.protection.outlook.com (10.13.175.36) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Fri, 11 Feb 2022 18:59:39 +0000
Received: from rajneesh-desk.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 11 Feb
 2022 12:59:37 -0600
From: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/4] drm/amdkfd: updade SPDX license header
Date: Fri, 11 Feb 2022 13:59:23 -0500
Message-ID: <20220211185925.4178-3-rajneesh.bhardwaj@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220211185925.4178-1-rajneesh.bhardwaj@amd.com>
References: <20220211185925.4178-1-rajneesh.bhardwaj@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9d1c2b8d-8daf-4161-1d55-08d9ed90a7b7
X-MS-TrafficTypeDiagnostic: MN2PR12MB3070:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB30706BE49E6B63B7182EDC1AFE309@MN2PR12MB3070.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:820;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Rl2yl2l3lvsb7w2jkab8evGJG4Zz4hofKSb5CQrUfidWhUNfUp2x+pr3Wn7GWIdsBRF1iv/3YYCY9WEWR97Xnjd5F6XpMBcdIYSHGz2RiGFvnetK8IkB6qW8zkUfbHvlAsyBEdRrO1SJSZoa0id3DFjk0kyguhSP+bCQKygaB2Y/BVKYewF4TTZwCbwQHevcaUau/uLbJX4RZl7lgS2ryt26zb/r/WwF84d2QKSVwUwJWvWApO1jUyipufmThBzAMmWTFLzOj2n3hkbN7ML3CvmuZn7POJaPP2138ShufdCzcBCZiu7veq4pMpvD9HNzP1ASAd8U6YcAtWj5wzpPVF+510hapdByaZ3mri54T5kiGvQ9W4KfLp8yI+3ntWuE8WWRNQpU1EZjH0ls2eOqLX63gCp8hwmqrT2yQQAnIohtLTSZ6/rJ4h4Au777H3v/kBEAu1FosXz75MYfp2xIhsAPrKSYfsTzFWGHbDvFWFvS6D06SS1P2K4yl9jQ41WB/m00QicbMtC45sckVpjPZRCe+AMwQTfuswiGftsKcr28UXpAAq0zk64ZBR0dGuX82nlAtlhjXVoXNUjw9o+tBNR1Tf2SWVTLrND+0aTSauY2/nVjoTxuOOaTkAgvcpsCZl3u6cHk8frcsKSu5xNJ+dNZnCqTV8ibClzG583j792l664W/ggf26/jAPvmiOKV/uVap8rB3Fdtw301DXvBqQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(2616005)(47076005)(16526019)(83380400001)(36860700001)(8936002)(70206006)(36756003)(8676002)(26005)(336012)(426003)(1076003)(186003)(44832011)(70586007)(81166007)(5660300002)(40460700003)(316002)(508600001)(356005)(6666004)(86362001)(2906002)(4326008)(7696005)(54906003)(30864003)(82310400004)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2022 18:59:39.2630 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d1c2b8d-8daf-4161-1d55-08d9ed90a7b7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT035.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3070
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
Cc: felix.kuehling@amd.com, Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Update the SPDX License header for all the KFD files.

Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c                  | 3 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c                     | 3 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_crat.h                     | 3 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c                  | 3 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_device.c                   | 3 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c     | 3 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h     | 3 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_cik.c | 3 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v10.c | 3 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v9.c  | 3 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_vi.c  | 3 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c                 | 3 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_events.c                   | 3 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_events.h                   | 3 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c              | 3 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c           | 3 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c                | 3 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_iommu.c                    | 3 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_iommu.h                    | 3 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c             | 3 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.h             | 3 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_module.c                   | 3 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c              | 3 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h              | 3 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c          | 3 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c          | 3 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c           | 3 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c           | 3 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c           | 3 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c        | 3 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_vi.c        | 3 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_pasid.c                    | 3 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_pm4_headers.h              | 3 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_pm4_headers_ai.h           | 3 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_pm4_headers_aldebaran.h    | 3 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_pm4_headers_diq.h          | 3 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_pm4_headers_vi.h           | 3 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_pm4_opcodes.h              | 3 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h                     | 3 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c                  | 3 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c    | 3 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_queue.c                    | 3 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c               | 3 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h               | 3 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c                 | 3 ++-
 drivers/gpu/drm/amd/amdkfd/kfd_topology.h                 | 3 ++-
 46 files changed, 92 insertions(+), 46 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 54d997f304b5..33bd13a75bb5 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1,5 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
 /*
- * Copyright 2014 Advanced Micro Devices, Inc.
+ * Copyright 2014-2022 Advanced Micro Devices, Inc.
  *
  * Permission is hereby granted, free of charge, to any person obtaining a
  * copy of this software and associated documentation files (the "Software"),
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
index bb6e49661d13..093305534d04 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -1,5 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
 /*
- * Copyright 2015-2017 Advanced Micro Devices, Inc.
+ * Copyright 2015-2022 Advanced Micro Devices, Inc.
  *
  * Permission is hereby granted, free of charge, to any person obtaining a
  * copy of this software and associated documentation files (the "Software"),
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.h b/drivers/gpu/drm/amd/amdkfd/kfd_crat.h
index d54ceebd346b..015ada3a0d54 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.h
@@ -1,5 +1,6 @@
+/* SPDX-License-Identifier: GPL-2.0 OR MIT */
 /*
- * Copyright 2014 Advanced Micro Devices, Inc.
+ * Copyright 2014-2022 Advanced Micro Devices, Inc.
  *
  * Permission is hereby granted, free of charge, to any person obtaining a
  * copy of this software and associated documentation files (the "Software"),
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c b/drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c
index 673d5e34f213..36371fb03778 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_debugfs.c
@@ -1,5 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
 /*
- * Copyright 2016-2017 Advanced Micro Devices, Inc.
+ * Copyright 2016-2022 Advanced Micro Devices, Inc.
  *
  * Permission is hereby granted, free of charge, to any person obtaining a
  * copy of this software and associated documentation files (the "Software"),
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 7f1746289989..8e3efb8518fb 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -1,5 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
 /*
- * Copyright 2014 Advanced Micro Devices, Inc.
+ * Copyright 2014-2022 Advanced Micro Devices, Inc.
  *
  * Permission is hereby granted, free of charge, to any person obtaining a
  * copy of this software and associated documentation files (the "Software"),
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 7f6f1a842b0b..33d8389701e0 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -1,5 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
 /*
- * Copyright 2014 Advanced Micro Devices, Inc.
+ * Copyright 2014-2022 Advanced Micro Devices, Inc.
  *
  * Permission is hereby granted, free of charge, to any person obtaining a
  * copy of this software and associated documentation files (the "Software"),
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
index 05a9c17daa3e..977e1d471c50 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
@@ -1,5 +1,6 @@
+/* SPDX-License-Identifier: GPL-2.0 OR MIT */
 /*
- * Copyright 2014 Advanced Micro Devices, Inc.
+ * Copyright 2014-2022 Advanced Micro Devices, Inc.
  *
  * Permission is hereby granted, free of charge, to any person obtaining a
  * copy of this software and associated documentation files (the "Software"),
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_cik.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_cik.c
index 0d26506798cf..b1ab5b0775e1 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_cik.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_cik.c
@@ -1,5 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
 /*
- * Copyright 2014 Advanced Micro Devices, Inc.
+ * Copyright 2014-2022 Advanced Micro Devices, Inc.
  *
  * Permission is hereby granted, free of charge, to any person obtaining a
  * copy of this software and associated documentation files (the "Software"),
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v10.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v10.c
index ad0593342333..d5aa4c30e87d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v10.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v10.c
@@ -1,5 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
 /*
- * Copyright 2018 Advanced Micro Devices, Inc.
+ * Copyright 2018-2022 Advanced Micro Devices, Inc.
  *
  * Permission is hereby granted, free of charge, to any person obtaining a
  * copy of this software and associated documentation files (the "Software"),
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v9.c
index f20434d9980e..d119070956fb 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_v9.c
@@ -1,5 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
 /*
- * Copyright 2016-2018 Advanced Micro Devices, Inc.
+ * Copyright 2016-2022 Advanced Micro Devices, Inc.
  *
  * Permission is hereby granted, free of charge, to any person obtaining a
  * copy of this software and associated documentation files (the "Software"),
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_vi.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_vi.c
index 3a7cb2f88366..d7d45832df0f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_vi.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager_vi.c
@@ -1,5 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
 /*
- * Copyright 2014 Advanced Micro Devices, Inc.
+ * Copyright 2014-2022 Advanced Micro Devices, Inc.
  *
  * Permission is hereby granted, free of charge, to any person obtaining a
  * copy of this software and associated documentation files (the "Software"),
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c b/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
index 0dbcf54657ed..5401b6317f25 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_doorbell.c
@@ -1,5 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
 /*
- * Copyright 2014 Advanced Micro Devices, Inc.
+ * Copyright 2014-2022 Advanced Micro Devices, Inc.
  *
  * Permission is hereby granted, free of charge, to any person obtaining a
  * copy of this software and associated documentation files (the "Software"),
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
index b5eda1e04f34..deecccebe5b6 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
@@ -1,5 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
 /*
- * Copyright 2014 Advanced Micro Devices, Inc.
+ * Copyright 2014-2022 Advanced Micro Devices, Inc.
  *
  * Permission is hereby granted, free of charge, to any person obtaining a
  * copy of this software and associated documentation files (the "Software"),
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.h b/drivers/gpu/drm/amd/amdkfd/kfd_events.h
index c8fe5dbdad55..1238af11916e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_events.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.h
@@ -1,5 +1,6 @@
+/* SPDX-License-Identifier: GPL-2.0 OR MIT */
 /*
- * Copyright 2014 Advanced Micro Devices, Inc.
+ * Copyright 2014-2022 Advanced Micro Devices, Inc.
  *
  * Permission is hereby granted, free of charge, to any person obtaining a
  * copy of this software and associated documentation files (the "Software"),
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c b/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
index 2e2b7ceb71db..c8aefeb37a38 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_flat_memory.c
@@ -1,5 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
 /*
- * Copyright 2014 Advanced Micro Devices, Inc.
+ * Copyright 2014-2022 Advanced Micro Devices, Inc.
  *
  * Permission is hereby granted, free of charge, to any person obtaining a
  * copy of this software and associated documentation files (the "Software"),
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
index 68ee923a440b..34a185269ff6 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_int_process_v9.c
@@ -1,5 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
 /*
- * Copyright 2016-2018 Advanced Micro Devices, Inc.
+ * Copyright 2016-2022 Advanced Micro Devices, Inc.
  *
  * Permission is hereby granted, free of charge, to any person obtaining a
  * copy of this software and associated documentation files (the "Software"),
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c b/drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c
index 81887c2013c9..9defdbbb4ff8 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_interrupt.c
@@ -1,5 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
 /*
- * Copyright 2014 Advanced Micro Devices, Inc.
+ * Copyright 2014-2022 Advanced Micro Devices, Inc.
  *
  * Permission is hereby granted, free of charge, to any person obtaining a
  * copy of this software and associated documentation files (the "Software"),
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_iommu.c b/drivers/gpu/drm/amd/amdkfd/kfd_iommu.c
index fe62407dacb2..fbd0afe4da42 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_iommu.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_iommu.c
@@ -1,5 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
 /*
- * Copyright 2018 Advanced Micro Devices, Inc.
+ * Copyright 2018-2022 Advanced Micro Devices, Inc.
  *
  * Permission is hereby granted, free of charge, to any person obtaining a
  * copy of this software and associated documentation files (the "Software"),
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_iommu.h b/drivers/gpu/drm/amd/amdkfd/kfd_iommu.h
index afd420b01a0c..8cf0fcbe87c2 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_iommu.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_iommu.h
@@ -1,5 +1,6 @@
+/* SPDX-License-Identifier: GPL-2.0 OR MIT */
 /*
- * Copyright 2018 Advanced Micro Devices, Inc.
+ * Copyright 2018-2022 Advanced Micro Devices, Inc.
  *
  * Permission is hereby granted, free of charge, to any person obtaining a
  * copy of this software and associated documentation files (the "Software"),
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
index 16f8bc4ca7f6..bcf7bc3302c9 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.c
@@ -1,5 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
 /*
- * Copyright 2014 Advanced Micro Devices, Inc.
+ * Copyright 2014-2022 Advanced Micro Devices, Inc.
  *
  * Permission is hereby granted, free of charge, to any person obtaining a
  * copy of this software and associated documentation files (the "Software"),
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.h b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.h
index f4cfe9f1871c..383202fd1ea2 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_kernel_queue.h
@@ -1,5 +1,6 @@
+/* SPDX-License-Identifier: GPL-2.0 OR MIT */
 /*
- * Copyright 2014 Advanced Micro Devices, Inc.
+ * Copyright 2014-2022 Advanced Micro Devices, Inc.
  *
  * Permission is hereby granted, free of charge, to any person obtaining a
  * copy of this software and associated documentation files (the "Software"),
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_module.c b/drivers/gpu/drm/amd/amdkfd/kfd_module.c
index 5e90fe642192..09b966dc3768 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_module.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_module.c
@@ -1,5 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
 /*
- * Copyright 2014 Advanced Micro Devices, Inc.
+ * Copyright 2014-2022 Advanced Micro Devices, Inc.
  *
  * Permission is hereby granted, free of charge, to any person obtaining a
  * copy of this software and associated documentation files (the "Software"),
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
index 9b7544ddced7..3f95c4354cfb 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.c
@@ -1,5 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
 /*
- * Copyright 2014 Advanced Micro Devices, Inc.
+ * Copyright 2014-2022 Advanced Micro Devices, Inc.
  *
  * Permission is hereby granted, free of charge, to any person obtaining a
  * copy of this software and associated documentation files (the "Software"),
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h
index d81ae0699300..57f900ccaa10 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager.h
@@ -1,5 +1,6 @@
+/* SPDX-License-Identifier: GPL-2.0 OR MIT */
 /*
- * Copyright 2014 Advanced Micro Devices, Inc.
+ * Copyright 2014-2022 Advanced Micro Devices, Inc.
  *
  * Permission is hereby granted, free of charge, to any person obtaining a
  * copy of this software and associated documentation files (the "Software"),
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c
index 06aae5df6a37..4889865c725c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_cik.c
@@ -1,5 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
 /*
- * Copyright 2014 Advanced Micro Devices, Inc.
+ * Copyright 2014-2022 Advanced Micro Devices, Inc.
  *
  * Permission is hereby granted, free of charge, to any person obtaining a
  * copy of this software and associated documentation files (the "Software"),
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
index 88228009ded4..c354d6bb7553 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v10.c
@@ -1,5 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
 /*
- * Copyright 2018 Advanced Micro Devices, Inc.
+ * Copyright 2018-2022 Advanced Micro Devices, Inc.
  *
  * Permission is hereby granted, free of charge, to any person obtaining a
  * copy of this software and associated documentation files (the "Software"),
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
index dff58ee53557..0778e587a2d6 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_v9.c
@@ -1,5 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
 /*
- * Copyright 2016-2018 Advanced Micro Devices, Inc.
+ * Copyright 2016-2022 Advanced Micro Devices, Inc.
  *
  * Permission is hereby granted, free of charge, to any person obtaining a
  * copy of this software and associated documentation files (the "Software"),
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c
index 86fc5decacf0..589ee9594728 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_mqd_manager_vi.c
@@ -1,5 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
 /*
- * Copyright 2014 Advanced Micro Devices, Inc.
+ * Copyright 2014-2022 Advanced Micro Devices, Inc.
  *
  * Permission is hereby granted, free of charge, to any person obtaining a
  * copy of this software and associated documentation files (the "Software"),
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
index 1439420925a0..a8a1ac5aff48 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
@@ -1,5 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
 /*
- * Copyright 2014 Advanced Micro Devices, Inc.
+ * Copyright 2014-2022 Advanced Micro Devices, Inc.
  *
  * Permission is hereby granted, free of charge, to any person obtaining a
  * copy of this software and associated documentation files (the "Software"),
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
index 7ea3f671b325..fee1c91bff15 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_v9.c
@@ -1,5 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
 /*
- * Copyright 2016-2018 Advanced Micro Devices, Inc.
+ * Copyright 2016-2022 Advanced Micro Devices, Inc.
  *
  * Permission is hereby granted, free of charge, to any person obtaining a
  * copy of this software and associated documentation files (the "Software"),
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_vi.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_vi.c
index 3c0658e32e93..324624a8537c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_vi.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager_vi.c
@@ -1,5 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
 /*
- * Copyright 2014 Advanced Micro Devices, Inc.
+ * Copyright 2014-2022 Advanced Micro Devices, Inc.
  *
  * Permission is hereby granted, free of charge, to any person obtaining a
  * copy of this software and associated documentation files (the "Software"),
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_pasid.c b/drivers/gpu/drm/amd/amdkfd/kfd_pasid.c
index af5816f51e55..e3b250918f39 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_pasid.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_pasid.c
@@ -1,5 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
 /*
- * Copyright 2014 Advanced Micro Devices, Inc.
+ * Copyright 2014-2022 Advanced Micro Devices, Inc.
  *
  * Permission is hereby granted, free of charge, to any person obtaining a
  * copy of this software and associated documentation files (the "Software"),
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_pm4_headers.h b/drivers/gpu/drm/amd/amdkfd/kfd_pm4_headers.h
index e50f73d25de6..7274edfd3f38 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_pm4_headers.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_pm4_headers.h
@@ -1,5 +1,6 @@
+/* SPDX-License-Identifier: GPL-2.0 OR MIT */
 /*
- * Copyright 2014 Advanced Micro Devices, Inc.
+ * Copyright 2014-2022 Advanced Micro Devices, Inc.
  *
  * Permission is hereby granted, free of charge, to any person obtaining a
  * copy of this software and associated documentation files (the "Software"),
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_pm4_headers_ai.h b/drivers/gpu/drm/amd/amdkfd/kfd_pm4_headers_ai.h
index 4d7add843746..a666710ed403 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_pm4_headers_ai.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_pm4_headers_ai.h
@@ -1,5 +1,6 @@
+/* SPDX-License-Identifier: GPL-2.0 OR MIT */
 /*
- * Copyright 2016 Advanced Micro Devices, Inc.
+ * Copyright 2016-2022 Advanced Micro Devices, Inc.
  *
  * Permission is hereby granted, free of charge, to any person obtaining a
  * copy of this software and associated documentation files (the "Software"),
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_pm4_headers_aldebaran.h b/drivers/gpu/drm/amd/amdkfd/kfd_pm4_headers_aldebaran.h
index f795ec815e2a..38f5cb6a222a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_pm4_headers_aldebaran.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_pm4_headers_aldebaran.h
@@ -1,5 +1,6 @@
+/* SPDX-License-Identifier: GPL-2.0 OR MIT */
 /*
- * Copyright 2020 Advanced Micro Devices, Inc.
+ * Copyright 2020-2022 Advanced Micro Devices, Inc.
  *
  * Permission is hereby granted, free of charge, to any person obtaining a
  * copy of this software and associated documentation files (the "Software"),
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_pm4_headers_diq.h b/drivers/gpu/drm/amd/amdkfd/kfd_pm4_headers_diq.h
index a0ff34878163..f9cd28690151 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_pm4_headers_diq.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_pm4_headers_diq.h
@@ -1,5 +1,6 @@
+/* SPDX-License-Identifier: GPL-2.0 OR MIT */
 /*
- * Copyright 2014 Advanced Micro Devices, Inc.
+ * Copyright 2014-2022 Advanced Micro Devices, Inc.
  *
  * Permission is hereby granted, free of charge, to any person obtaining a
  * copy of this software and associated documentation files (the "Software"),
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_pm4_headers_vi.h b/drivers/gpu/drm/amd/amdkfd/kfd_pm4_headers_vi.h
index 5466cfe1c3cc..40971c5ecced 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_pm4_headers_vi.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_pm4_headers_vi.h
@@ -1,5 +1,6 @@
+/* SPDX-License-Identifier: GPL-2.0 OR MIT */
 /*
- * Copyright 2014 Advanced Micro Devices, Inc.
+ * Copyright 2014-2022 Advanced Micro Devices, Inc.
  *
  * Permission is hereby granted, free of charge, to any person obtaining a
  * copy of this software and associated documentation files (the "Software"),
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_pm4_opcodes.h b/drivers/gpu/drm/amd/amdkfd/kfd_pm4_opcodes.h
index b72fa3b8c2d4..5bfd0f9cbe23 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_pm4_opcodes.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_pm4_opcodes.h
@@ -1,5 +1,6 @@
+/* SPDX-License-Identifier: GPL-2.0 OR MIT */
 /*
- * Copyright 2014 Advanced Micro Devices, Inc.
+ * Copyright 2014-2022 Advanced Micro Devices, Inc.
  *
  * Permission is hereby granted, free of charge, to any person obtaining a
  * copy of this software and associated documentation files (the "Software"),
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index b6790a637f5c..08df70452379 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1,5 +1,6 @@
+/* SPDX-License-Identifier: GPL-2.0 OR MIT */
 /*
- * Copyright 2014 Advanced Micro Devices, Inc.
+ * Copyright 2014-2022 Advanced Micro Devices, Inc.
  *
  * Permission is hereby granted, free of charge, to any person obtaining a
  * copy of this software and associated documentation files (the "Software"),
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 8c6a48add76e..59c04b2d383b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1,5 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
 /*
- * Copyright 2014 Advanced Micro Devices, Inc.
+ * Copyright 2014-2022 Advanced Micro Devices, Inc.
  *
  * Permission is hereby granted, free of charge, to any person obtaining a
  * copy of this software and associated documentation files (the "Software"),
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index 70ea4849e6a2..c3f252fc337b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -1,5 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
 /*
- * Copyright 2014 Advanced Micro Devices, Inc.
+ * Copyright 2014-2022 Advanced Micro Devices, Inc.
  *
  * Permission is hereby granted, free of charge, to any person obtaining a
  * copy of this software and associated documentation files (the "Software"),
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
index 6dcd621e5b71..0f6992b1895c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
@@ -1,5 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
 /*
- * Copyright 2014 Advanced Micro Devices, Inc.
+ * Copyright 2014-2022 Advanced Micro Devices, Inc.
  *
  * Permission is hereby granted, free of charge, to any person obtaining a
  * copy of this software and associated documentation files (the "Software"),
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
index 329a4c89f1e6..f9eafc796e70 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
@@ -1,5 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
 /*
- * Copyright 2020 Advanced Micro Devices, Inc.
+ * Copyright 2020-2022 Advanced Micro Devices, Inc.
  *
  * Permission is hereby granted, free of charge, to any person obtaining a
  * copy of this software and associated documentation files (the "Software"),
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
index bffd0c32b060..dfe101c21166 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
@@ -1,5 +1,6 @@
+/* SPDX-License-Identifier: GPL-2.0 OR MIT */
 /*
- * Copyright 2020 Advanced Micro Devices, Inc.
+ * Copyright 2020-2022 Advanced Micro Devices, Inc.
  *
  * Permission is hereby granted, free of charge, to any person obtaining a
  * copy of this software and associated documentation files (the "Software"),
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index 948fbb39336e..9d10d0c04ecc 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -1,5 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
 /*
- * Copyright 2014 Advanced Micro Devices, Inc.
+ * Copyright 2014-2022 Advanced Micro Devices, Inc.
  *
  * Permission is hereby granted, free of charge, to any person obtaining a
  * copy of this software and associated documentation files (the "Software"),
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.h b/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
index f0cc59d2fd5d..4f80d2ea1000 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.h
@@ -1,5 +1,6 @@
+/* SPDX-License-Identifier: GPL-2.0 OR MIT */
 /*
- * Copyright 2014 Advanced Micro Devices, Inc.
+ * Copyright 2014-2022 Advanced Micro Devices, Inc.
  *
  * Permission is hereby granted, free of charge, to any person obtaining a
  * copy of this software and associated documentation files (the "Software"),
-- 
2.17.1

