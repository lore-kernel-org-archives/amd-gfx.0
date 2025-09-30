Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D949CAC5B8
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Sep 2025 08:27:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B50610E539;
	Tue, 30 Sep 2025 08:27:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="c4pKful3";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010041.outbound.protection.outlook.com
 [52.101.193.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA77F10E525
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Sep 2025 08:27:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eJ25e2qT+FGww8yeoEgQ12PM+qiK6meyA+7DNJunjfPLFSTBPmNoql3mTYR8HuM8VNEdsMDn1pLF9+XaD1IBk/ygCtPUYZvGhOqsuGUyRvstqo4XDJvN1lOVnQwwIJstDGSJD0DYlR9+uCT+GvwnVThFVrtvYqsgB3t0Dnc0dEXwj6hhLvAr7MiLwmKwd/wXjIoMjgkF+H/IRH1FFCzFV5dIuHQJqAwH8gG+YLsTa20Nj22Fhf7gU8CPkC3uQQ4njSjOceDYFeBjojResZUeoIoQe0RVwOWlz0DFgcJwPm/ycYeQu5dw3IrH2cEuHcHNs4IpjMFUzvji4h9NSjvAZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fq54VINHKOUDijq9UjwZC+bPJ8MWMVVMjLpsmE7kQcs=;
 b=gjDTt/pU3smQMCS9iqoglsqI9LYlKajakXJTKa6DvjZvleOa9ZxjmQIg5d8UNXAfssg3xymFRoVGNJQ/fqa1EQbNfZM0d73hy+8G0WJaO+z56TRV6unXvUTbmaqaI2dO7/cNkYLQK6G+tWQGpPmQ5LY1oGz4okPZ6hXDIebznD0OLWrACbzRM1zwoLZmBKEnasCKglfLlYDNp6I/cQafVbcDFMh5audw/qa3aJUrkNcuL8IvPWniuHfx0mL3vr7HqmgYEQfZGe6AssQbofyd4XHTswbIW25kVb2027TxfHUf1H5Ud0YYy0LiyBbO+QFjHPXNJ5FvM6hXVfjVxJayLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fq54VINHKOUDijq9UjwZC+bPJ8MWMVVMjLpsmE7kQcs=;
 b=c4pKful3qkkgn/rbk4OOvU2Px7u81/V6wRXyJWIqVkgq7bb1lNih8bmnbrvEE4runqzZWjX9pEJiqdLICciYhTe/qrRcX1NjiCDLvEsQJYeF3aJWxdOiaHLr4NIhIWjbGNg3ApwV6W5Wzga5nyNEYrSGXbgJsXCbexQKrirTYrc=
Received: from BLAPR05CA0004.namprd05.prod.outlook.com (2603:10b6:208:36e::8)
 by DS7PR12MB5910.namprd12.prod.outlook.com (2603:10b6:8:7b::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.16; Tue, 30 Sep 2025 08:26:59 +0000
Received: from BL6PEPF0001AB71.namprd02.prod.outlook.com
 (2603:10b6:208:36e:cafe::6d) by BLAPR05CA0004.outlook.office365.com
 (2603:10b6:208:36e::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.13 via Frontend Transport; Tue,
 30 Sep 2025 08:26:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB71.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Tue, 30 Sep 2025 08:26:59 +0000
Received: from amd-02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 30 Sep
 2025 01:26:48 -0700
From: YiPeng Chai <YiPeng.Chai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Tao.Zhou1@amd.com>, <Candice.Li@amd.com>,
 <KevinYang.Wang@amd.com>, <Stanley.Yang@amd.com>, <Jinzhou.Su@amd.com>,
 YiPeng Chai <YiPeng.Chai@amd.com>, Tao Zhou <tao.zhou1@amd.com>
Subject: [PATCH 2/3] drm/amdgpu: Add ras module files into amdgpu
Date: Tue, 30 Sep 2025 16:25:24 +0800
Message-ID: <20250930082525.118197-2-YiPeng.Chai@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250930082525.118197-1-YiPeng.Chai@amd.com>
References: <20250930082525.118197-1-YiPeng.Chai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB71:EE_|DS7PR12MB5910:EE_
X-MS-Office365-Filtering-Correlation-Id: ff0a1769-3f53-4c8a-91fe-08ddfffb1ff2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?j8CH1ZWjuZfXb56Q/d54/rBVqBTSrlymvGpej4AmzxCJNVN++Pf8igt/kG7g?=
 =?us-ascii?Q?Zns6AQbJe6yv4XPxv8vIuKvEBXiRDq7zD3btlEf5AHrFqVJRA2+1Ly8CmIU5?=
 =?us-ascii?Q?MAAJy+vdUnWDJkayHjzwzyPULMLVwiYyhVOpgTnkI4CKooGgMdPq3M5cVTxd?=
 =?us-ascii?Q?c1mU+D+pIz8Dw/J3J0c39WRzfI/3XKRvS2F8Vsu2+9qs09PCW9HrPS5DHDsk?=
 =?us-ascii?Q?ZWa8luPyem3trwsIR7Vetguc8A13OTxqBU+zo577J3uIg6hOlxGkICwp2qOk?=
 =?us-ascii?Q?w5ySSzD+PE9XtQ43EJ6ZrvVdmRVvZRO37lawdp4RsM4wTfRGgPpYa9IJfHX8?=
 =?us-ascii?Q?fW5U3ThMgGuGz03q1CHjFSH7wNPrtH+XEs8lYJ+u9lfEEnhMxqFRHg/kkQ5i?=
 =?us-ascii?Q?sDWyBGb5MnbWrNj130HkYjnVgCntWv/TMyoP1hbr/Y/UIUaBlsknA4PKt6cf?=
 =?us-ascii?Q?qcPBIbJKmVIgqzSFN+tl/prDPQ7n1sTqG7lRYeADKY1OzYrHEElUUU4TUpnU?=
 =?us-ascii?Q?x27T157L53ZkUoKq6mR9CMC9B+F0/QpH3AIUHtzKCz8nKHJwM0qBpZJTAXie?=
 =?us-ascii?Q?UomrWUXy9RdALQiaNa6AGYo2684lrkoPYb/vwWBhLpcl1k5XRkFh01p4cWCW?=
 =?us-ascii?Q?Iuwdf9D8oyRqm0JPj5X/saPoHHz3lYzmaVUTqfyVGKPIgRLYti1LV/r5NYKZ?=
 =?us-ascii?Q?lQVXFAun+jDh4fWG3FllPC7DNj11Xlko/YCL2wsf9BxvzRb+L1D1tbVH5xdV?=
 =?us-ascii?Q?bGmV2wtGTN2NIkIybL2UkzE7yMSnSwVnJmgC8Z3TC5TNDXhF0ioMwLZLn+LU?=
 =?us-ascii?Q?MNCROUPX3w9YyR85zZ3wLNhmteM7eBA7TIV1tDu+F9a+Swo1ScEU52mAI/VX?=
 =?us-ascii?Q?t05aoQjC1NSi6tj/fJ8hSDU4hhsevq6fZxohAZ4AjWXYKRqt5g47Xdvsk5mG?=
 =?us-ascii?Q?kowDVTlFhFdmDJDhRjGCpdFWPvlJph2ZSjo2QcZ8ln5497KJgYrtDiJFmKUD?=
 =?us-ascii?Q?wRilbbcASzn9rBoHh3V3a8sGnEzjvyPavf+viN9p79nr45NlscxPpckcxmFN?=
 =?us-ascii?Q?FTuqv/WKnbmUBY5itlv0tLJmLvtr+9sVJsg5d3p2iw2NtTNTBYQA61sQfuUr?=
 =?us-ascii?Q?ji0KGLR7L4O4r29lSy2IwQ8XdUZK/YLLXy1nBlHTOjcdj5M1DaCqh/hCx2RE?=
 =?us-ascii?Q?+ZVMNQJVUBLvltn2+3XFXwoshVgcwMrfYmYyb5oO1OGxL9EgbhV7pBqO521s?=
 =?us-ascii?Q?G2VUfAVB0pKTizwtQNr9WSAyMpmSdG2iItYnFcE29Pl8AA3BdHpTtsezgZTt?=
 =?us-ascii?Q?zztQgzXQWJ6MPwb/0V0k2Fe6doPkU5bhLSObuA2GzyTybt3QW81v1nKVEgs0?=
 =?us-ascii?Q?UjqCpUc7UdH0GD//TearAhPgpyNYkkGKoYzmPYjkTXykRhiTny9rQkl2gXlk?=
 =?us-ascii?Q?a5+o1WZUFDx+vYUkgVCMbXSz4Dua9zX6yslLL2YZguXiIaLg7rrCC488Q1A1?=
 =?us-ascii?Q?pddPodo8NFMm7Lc9PxiIN0dkI+UYdah7YeA1xytkWQTF1v89XkUISkK1aJOh?=
 =?us-ascii?Q?0oVAAmv8Eb+HF25xVXE=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2025 08:26:59.3916 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff0a1769-3f53-4c8a-91fe-08ddfffb1ff2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB71.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5910
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

Add ras module files into amdgpu.

Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>
Reviewed-by: Tao Zhou <tao.zhou1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile     | 8 +++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h | 1 +
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index 64e7acff8f18..ebe08947c5a3 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -37,7 +37,8 @@ ccflags-y := -I$(FULL_AMD_PATH)/include/asic_reg \
 	-I$(FULL_AMD_DISPLAY_PATH)/modules/inc \
 	-I$(FULL_AMD_DISPLAY_PATH)/dc \
 	-I$(FULL_AMD_DISPLAY_PATH)/amdgpu_dm \
-	-I$(FULL_AMD_PATH)/amdkfd
+	-I$(FULL_AMD_PATH)/amdkfd \
+	-I$(FULL_AMD_PATH)/ras/ras_mgr
 
 # Locally disable W=1 warnings enabled in drm subsystem Makefile
 subdir-ccflags-y += -Wno-override-init
@@ -324,4 +325,9 @@ amdgpu-y += \
 	isp_v4_1_1.o
 endif
 
+AMD_GPU_RAS_PATH := ../ras
+AMD_GPU_RAS_FULL_PATH := $(FULL_AMD_PATH)/ras
+include $(AMD_GPU_RAS_FULL_PATH)/Makefile
+amdgpu-y += $(AMD_GPU_RAS_FILES)
+
 obj-$(CONFIG_DRM_AMDGPU)+= amdgpu.o
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
index 6cf0dfd38be8..9f21b6cf8724 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.h
@@ -504,6 +504,7 @@ struct ras_critical_region {
 };
 
 struct amdgpu_ras {
+	void *ras_mgr;
 	/* ras infrastructure */
 	/* for ras itself. */
 	uint32_t features;
-- 
2.34.1

