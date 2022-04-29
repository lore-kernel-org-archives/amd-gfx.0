Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22FC9C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Apr 2022 17:47:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CB8F10F665;
	Fri, 29 Apr 2022 17:47:18 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2084.outbound.protection.outlook.com [40.107.243.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8924710F3BE
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Apr 2022 17:47:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U59KpZ8EJCifpAjhh05SJHnOWXOq1QOUWoylXp4DJsJ9fteoxDaZwcILqJWJzUi2qHFz/VbdOfG6BOLsSNbh/Tue2sb7h4rdxMm5CyM2hs/WBkYCQhQKw4ga19dg+kpSF5fZLHuDYe84ao7HxhF89qnfMb+etnlpKd1RLFHXvIeFOlARZSt09iRApb3vhr4Gk3wThG+EESOGoITRdNPJxNZwddNIOF+nlWyNvrq6SrhakQ0DShX/AuM3p647hdUkW8ab5e/ItGdsHdu7OQXMzSrbczSsdYQQ0Hq9ubGe80g7JzA37ypV9Zs+rCGpcyBoNj/EZuZfqlNZCazdy8x0xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5jHbOFtdZDflo6ttg/5kdUFBXObWFKGOzj+A65FWQzY=;
 b=m+qVY7txuPnR8SuHC0XZ6bhkOTv1A4xlcucxXNyOgWbYSX6CBr94xaB7T6iuptM7Slw7Q+WkQVVQLtySIAEFFFBDZa07QGstDdpYMcct+nLYlAlbYIOVwQg6vFV6jtIM64XPNm1A2+n33fUtZJJE+aBOz6Qk4vNsHFaVCk0TdXx3jWklKRCgaN/TWzsA1eMZEUK0GfT3PqGVosS7GeT6VFq7wFMBaZtkUVGO7TgcMfm8WOmpneqs8NwUIh3GmZGTVCfA+detcFWLVrnSUwr/DB8t8yCSlBM1/8vkeEwmrzDXNss8GE9fDUVqmW1BVvjDHL0NDJ5jFKDru23vymtAwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5jHbOFtdZDflo6ttg/5kdUFBXObWFKGOzj+A65FWQzY=;
 b=tG/QpYq7BayLhtHYlv+J+aZf5tgEn2AQGZQdgrquvhKBnDf9boXyh/0Q7d2Q5XY+ycpBEadDvqFWIoKZuXOt0Y2SFm7TGGOUIWxt9F+7YTyV2JjY6a6SOyMH9sG1MWUrp6XNPwRa/r8qFdppWDmlSyUcDJOEPDnsuXG/nyApdXE=
Received: from DS7PR06CA0006.namprd06.prod.outlook.com (2603:10b6:8:2a::7) by
 BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5206.13; Fri, 29 Apr 2022 17:47:02 +0000
Received: from DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2a:cafe::8d) by DS7PR06CA0006.outlook.office365.com
 (2603:10b6:8:2a::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.12 via Frontend
 Transport; Fri, 29 Apr 2022 17:47:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT050.mail.protection.outlook.com (10.13.173.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Fri, 29 Apr 2022 17:47:01 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 29 Apr
 2022 12:46:59 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 39/73] drm/amdgpu/mes: manage mes doorbell allocation
Date: Fri, 29 Apr 2022 13:45:50 -0400
Message-ID: <20220429174624.459475-40-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220429174624.459475-1-alexander.deucher@amd.com>
References: <20220429174624.459475-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 355513ba-520e-4fce-5adb-08da2a084448
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB46140AC69082E20F9B522018F7FC9@BYAPR12MB4614.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sjX3Rm0JJFoe/yfbixzG8IRE3XPZXURk7e+ORbVhJVQuZ7iOCMOazOdQx9xR9SgzvvcOgqS6YDaikGmBACMALAYFUVOd+WiPpv6GoTg80c6mmor+pkj9mbLrJffQVUy4eY5rjvreVnKdE6TPp5O1lDS/tF75VI+Yyj5ICKeUz3s7GcJ1+zuJdUAJ1PtD5XeasM3yry5NM0wCbT/yx5s61K/yAGoSJljW2OZ0ZGG5ApNhZk+x3mmltcJ9nQO9C81DAKgYzor7AkU3/BzdWc9N7TOYW48vOVimjXnBrGXh5bwfl00B0w7iCgViHKte6SoQuCpGEnKcPe62hcO8U5sF31A0Wt0qi2tJzWwcvu3DZlbNn3LRcN8B3z7xWfrwVct0O5P7gKIvw6vHtIn5kBIk0+uhmmmyzeITucxrxm/xgNLSPNqqJiYguz2YdfXd4aeVkisrE+i9KCNWyjwGXSpo57/Kj7/Bd6IL6KLjKbj1db4y1+gNgDEb/u8uKnE1cdsYVto+YIHcq7+TzbAl/e63gZZ6ic7BPZTPBm8vp4KvBmh7g9udED67hR8RHm0z7/I6H2C3o/dNEegxyvlKpTQvkm2jNJqbVCO0Aap2/lBuN7IpduTM5XDydcIMEjBIusDv2cign+wPxv/xr+yU89XCacmNW6m2hKQJNBOz5d7d/swx0watmb/0m8PvlBbeDhyY9K6mOE2+Z141/uALoK+nHQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(336012)(8676002)(47076005)(5660300002)(426003)(70586007)(86362001)(4326008)(316002)(2616005)(356005)(66574015)(8936002)(70206006)(2906002)(16526019)(186003)(81166007)(83380400001)(1076003)(40460700003)(36756003)(82310400005)(7696005)(6666004)(508600001)(36860700001)(26005)(54906003)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 17:47:01.8794 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 355513ba-520e-4fce-5adb-08da2a084448
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4614
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Jack Xiao <Jack.Xiao@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Jack Xiao <Jack.Xiao@amd.com>

It is used to manage the doorbell allocation of mes processes and queues.
Driver calls into process doorbell allocation to get the slice doorbell
for the process, then the doorbell for a queue is allocated from the
process doorbell slice.

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
Acked-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile     |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 133 ++++++++++++++++++++++++
 2 files changed, 134 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index 7a1b13fabebb..803e7f5dc458 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -144,6 +144,7 @@ amdgpu-y += \
 
 # add MES block
 amdgpu-y += \
+	amdgpu_mes.o \
 	mes_v10_1.o
 
 # add UVD block
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
new file mode 100644
index 000000000000..1c591cb45fd9
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -0,0 +1,133 @@
+/*
+ * Copyright 2019 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ */
+
+#include "amdgpu_mes.h"
+#include "amdgpu.h"
+#include "soc15_common.h"
+#include "amdgpu_mes_ctx.h"
+
+#define AMDGPU_MES_MAX_NUM_OF_QUEUES_PER_PROCESS 1024
+#define AMDGPU_ONE_DOORBELL_SIZE 8
+
+static int amdgpu_mes_doorbell_process_slice(struct amdgpu_device *adev)
+{
+	return roundup(AMDGPU_ONE_DOORBELL_SIZE *
+		       AMDGPU_MES_MAX_NUM_OF_QUEUES_PER_PROCESS,
+		       PAGE_SIZE);
+}
+
+static int amdgpu_mes_alloc_process_doorbells(struct amdgpu_device *adev,
+				      struct amdgpu_mes_process *process)
+{
+	int r = ida_simple_get(&adev->mes.doorbell_ida, 2,
+			       adev->mes.max_doorbell_slices,
+			       GFP_KERNEL);
+	if (r > 0)
+		process->doorbell_index = r;
+
+	return r;
+}
+
+static void amdgpu_mes_free_process_doorbells(struct amdgpu_device *adev,
+				      struct amdgpu_mes_process *process)
+{
+	if (process->doorbell_index)
+		ida_simple_remove(&adev->mes.doorbell_ida,
+				  process->doorbell_index);
+}
+
+static int amdgpu_mes_queue_doorbell_get(struct amdgpu_device *adev,
+					 struct amdgpu_mes_process *process,
+					 int ip_type, uint64_t *doorbell_index)
+{
+	unsigned int offset, found;
+
+	if (ip_type == AMDGPU_RING_TYPE_SDMA) {
+		offset = adev->doorbell_index.sdma_engine[0];
+		found = find_next_zero_bit(process->doorbell_bitmap,
+					   AMDGPU_MES_MAX_NUM_OF_QUEUES_PER_PROCESS,
+					   offset);
+	} else {
+		found = find_first_zero_bit(process->doorbell_bitmap,
+					    AMDGPU_MES_MAX_NUM_OF_QUEUES_PER_PROCESS);
+	}
+
+	if (found >= AMDGPU_MES_MAX_NUM_OF_QUEUES_PER_PROCESS) {
+		DRM_WARN("No doorbell available\n");
+		return -ENOSPC;
+	}
+
+	set_bit(found, process->doorbell_bitmap);
+
+	*doorbell_index =
+		(process->doorbell_index *
+		 amdgpu_mes_doorbell_process_slice(adev)) / sizeof(u32) +
+		found * 2;
+
+	return 0;
+}
+
+static void amdgpu_mes_queue_doorbell_free(struct amdgpu_device *adev,
+					   struct amdgpu_mes_process *process,
+					   uint32_t doorbell_index)
+{
+	unsigned int old, doorbell_id;
+
+	doorbell_id = doorbell_index -
+		(process->doorbell_index *
+		 amdgpu_mes_doorbell_process_slice(adev)) / sizeof(u32);
+	doorbell_id /= 2;
+
+	old = test_and_clear_bit(doorbell_id, process->doorbell_bitmap);
+	WARN_ON(!old);
+}
+
+static int amdgpu_mes_doorbell_init(struct amdgpu_device *adev)
+{
+	size_t doorbell_start_offset;
+	size_t doorbell_aperture_size;
+	size_t doorbell_process_limit;
+
+	doorbell_start_offset = (adev->doorbell_index.max_assignment+1) * sizeof(u32);
+	doorbell_start_offset =
+		roundup(doorbell_start_offset,
+			amdgpu_mes_doorbell_process_slice(adev));
+
+	doorbell_aperture_size = adev->doorbell.size;
+	doorbell_aperture_size =
+			rounddown(doorbell_aperture_size,
+				  amdgpu_mes_doorbell_process_slice(adev));
+
+	if (doorbell_aperture_size > doorbell_start_offset)
+		doorbell_process_limit =
+			(doorbell_aperture_size - doorbell_start_offset) /
+			amdgpu_mes_doorbell_process_slice(adev);
+	else
+		return -ENOSPC;
+
+	adev->mes.doorbell_id_offset = doorbell_start_offset / sizeof(u32);
+	adev->mes.max_doorbell_slices = doorbell_process_limit;
+
+	DRM_INFO("max_doorbell_slices=%ld\n", doorbell_process_limit);
+	return 0;
+}
-- 
2.35.1

