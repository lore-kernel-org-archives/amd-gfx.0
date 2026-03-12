Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 734E5FED2E4
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Mar 2026 08:18:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 170BF10EA01;
	Thu, 12 Mar 2026 08:18:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aMoBZoxG";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013067.outbound.protection.outlook.com
 [40.93.201.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8FB2910EA01
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Mar 2026 08:18:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J3D2ObQRpWwBicLcNy/YYN3d14XFfYvGfYS0xvK1khfjMyerVRMmjf4LFsaQYzVX1WbO4zR8jRBtnEZ2URkTk+pmeB4HyLHCjhNB6C6ysu9PwDWuKcFdQ9d3eUKWPOq19SRfM7Y5rEnP5dHG/ldE4Iigd5tGAoYOYIpjvoWZKqotSr7FYToA/eJOvf+LpssYCN1YdgLbm+A3jEPOHjaHhoJlED/eM6+lmTeApuyjFkKgj/4M20XMmOawjQOKIZUyWbQl0fMW7CFm9Dn8AdIGVNwe4TlFHxpTOOOoMW1oqHxp0omKrxQXBZJvYlIF4pGfWKXHhA9yXPpSXHkIZ0JgvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SIbeTURLhTkxwEG9+fbAY6SYZqN4sUTxETFdQg2XTYM=;
 b=WNfej+xgCJ1J04TiJJfRoI7l9oAOgjiLA9w/BbJzEsTKnXvbhcQ+QM5BtabUfVYjEAr2UBX4gGzL6Iumzc6BuS/fmeIqj2ERVHmrBJr+pdO3uiWpwAYrr8lLhQxWqafQ1doqllkjU5FoEWgZJprXSLYcP02I72QV+c2O680k43vKiQ7uhwOLodEo7Tg6OIhGPlEKoQk9y4WzzYq5SNrwyYMhsiXSMopaQQi7jk/gg+VYPlLgKpGx6jWSeeBjXnUNnwDrR2RM8Pssu73BgNAMObytJ7H7UqZurWMWHHGBXrtE8w8DBDF7qFOkPu6kzW5U8L7+Ac5BV/6+/UrGAcg2bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SIbeTURLhTkxwEG9+fbAY6SYZqN4sUTxETFdQg2XTYM=;
 b=aMoBZoxGPBSXrdJIb18OzOezN1t+Y826gx/z7WsaXV6RbKwEjLf/2cbuBJzt9csEf69flkVsgMIM2L2QpSP4o85URpaqO1PonfzC4Xc+tzyokyVjByzBSg1O4Ti3MLHe68KAn5u90jlrh2RyiexkwwkpVs4+I8eeg3ah8xno8ss=
Received: from PH8PR07CA0035.namprd07.prod.outlook.com (2603:10b6:510:2cf::22)
 by PH7PR12MB8105.namprd12.prod.outlook.com (2603:10b6:510:2b7::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Thu, 12 Mar
 2026 08:18:44 +0000
Received: from SJ1PEPF000023D3.namprd21.prod.outlook.com
 (2603:10b6:510:2cf:cafe::2b) by PH8PR07CA0035.outlook.office365.com
 (2603:10b6:510:2cf::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.27 via Frontend Transport; Thu,
 12 Mar 2026 08:18:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023D3.mail.protection.outlook.com (10.167.244.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.1 via Frontend Transport; Thu, 12 Mar 2026 08:18:43 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Thu, 12 Mar
 2026 03:18:29 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 12 Mar
 2026 03:18:29 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Thu, 12 Mar 2026 03:18:28 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu: add overflow check for BO list array allocation
Date: Thu, 12 Mar 2026 16:18:16 +0800
Message-ID: <20260312081827.1484742-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Jesse.Zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D3:EE_|PH7PR12MB8105:EE_
X-MS-Office365-Filtering-Correlation-Id: 615fb81d-ceaf-4d2f-8818-08de800ff972
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: qdMHBdc8WfvMsK/IBRCAtXCoBhy+NXuD1gB0l/o9VwLlQ1bGfkfkVph4r2qySmtyO+3BqnQCtvvONzS9J1N91HKfPhYFmFz/oiY8cdFf6udvi9R0PqU1Rq0abFlRwtuchKvTnkIQFakuTxjllY/+1XiiSFKd63sCbsUC1Dk0BagD0r7zDa827yljlrH0IJcapTE0gv9gGT7+epWFx7XoihA/Y/5Wpd+/Tw6+I4bFGvi22ts89k7Yy5iHyG5fnGuEuKFMpS6IBE6GpWEfl67i5EJOVxhVe72DdLBIPASWjzjCYIOO+kJezl3lJXBh+UATxJTowU7N/2oezWh9e/0A151DClCnhkxX1pSB99JM3cSlbf5bLyLG5twg83KmE9PTTFMzPSebTgs2JjanZpCcYA6uVk71TkheFExCnetzA3DWzlc50KzGp4/RVw1CjFJ4XeotIHwLa7zB118iGGNcdJ7qB39GJFMUQUmscp6+5odbKfzKhytpPQaDCV0q1LPxScCe6TFRgcRhXjCkbnHF086uww/YkRlabJumXoiFSnxF/wFo5/03lzbFIdfpxdwP4rV2oSFcFuhS6NTrt7x0dbRE6lC+RvR3poRzyZ3bbCqhRVpTtXqqnylOWhvbHax8nL3yuyJEAGeGpB677h5g5BGNiMNrS2Gp00EKjyGMs2uArAoFrb4MKnCdWeX3PsfI3O8cbbuNJ4bEOpHDNtS9b64bE5vmHBD31+4/FB/7wHeqNpebt4ilSNMJvfZlQ8+KpOk68q4qBlEC7O8g0cnBqA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 5MK0rmiDMnPk5kkNEEfCHFZNYABzlbsAmk5CxCc8artJZLrqmjlM1TqWyH+KYytRmwsz6KYkalUjjAUpWbvcxo8XwNqXH19QMJc+f5f5zxwNsEXbjBVdxH5il4BKsblJv6wrNVigWvMGB/jz9MWToS6dpgXrtglalC5WOc3bSg4AuSnvPP1cOSBQCq30S3PyuFvL4nl/vBJYJuQio0OF6vSRiTN26GiacjQPo5fAUllJYarP2H46rx3GAtKo9U+EUMzFL/aPITLfiqwPcDNBYUmpzY6gbiNNxBC+D77xtpyLMfxUydH5PphrL1flL9PprAxXVg1cY1Os2dpdCbFIxLzkTrrm9nCyqPCczUhamAbW67sKB6HqalMywcC611qjaFXImRFvqT+ut/Hup9cbGq12jxXVkTCK5fTnCKsBs7iDw6A5MrhAXRKkdFXUZYHk
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 08:18:43.0251 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 615fb81d-ceaf-4d2f-8818-08de800ff972
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D3.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8105
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

When allocating memory for a BO list array, the multiplication
bo_number * info_size may overflow on 32-bit systems if userspace
supplies large values. This could lead to allocating a smaller buffer
than expected, followed by a memset or copy_from_user that writes
beyond the allocated memory, potentially causing memory corruption or
information disclosure.

Add an overflow check using check_mul_overflow to detect such cases.
Also ensure the resulting allocation size does not exceed INT_MAX,
as the subsequent user copy operations may rely on this limit.
Return -EINVAL if either condition fails.

A crash log illustrating the issue:

[ 2943.053706] RIP: 0010:__kvmalloc_node_noprof+0x5be/0x8a0
...
[ 2943.053725] Call Trace:
[ 2943.053728] amdgpu_bo_create_list_entry_array+0x42/0x130 [amdgpu]
[ 2943.053947] amdgpu_bo_list_ioctl+0x51/0x300 [amdgpu]
[ 2943.054277] drm_ioctl+0x2cb/0x5a0 [drm]
[ 2943.054379] __x64_sys_ioctl+0x9e/0xf0

The overflow occurs in the allocation inside
amdgpu_bo_create_list_entry_array, leading to a crash in
vmemdup_user (via __kvmalloc_node_noprof).

Signed-off-by: Jesse.Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
index 87ec46c56a6e..efab39ba7f51 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
@@ -29,6 +29,7 @@
  */
 
 #include <linux/sort.h>
+#include <linux/overflow.h>
 #include <linux/uaccess.h>
 
 #include "amdgpu.h"
@@ -187,6 +188,11 @@ int amdgpu_bo_create_list_entry_array(struct drm_amdgpu_bo_list_in *in,
 	const uint32_t bo_info_size = in->bo_info_size;
 	const uint32_t bo_number = in->bo_number;
 	struct drm_amdgpu_bo_list_entry *info;
+	size_t alloc_size;
+
+	if (check_mul_overflow((size_t)bo_number, (size_t)info_size,
+			       &alloc_size) || alloc_size > INT_MAX)
+		return -EINVAL;
 
 	/* copy the handle array from userspace to a kernel buffer */
 	if (likely(info_size == bo_info_size)) {
@@ -201,7 +207,7 @@ int amdgpu_bo_create_list_entry_array(struct drm_amdgpu_bo_list_in *in,
 		if (!info)
 			return -ENOMEM;
 
-		memset(info, 0, bo_number * info_size);
+		memset(info, 0, alloc_size);
 		for (i = 0; i < bo_number; ++i, uptr += bo_info_size) {
 			if (copy_from_user(&info[i], uptr, bytes)) {
 				kvfree(info);
-- 
2.49.0

