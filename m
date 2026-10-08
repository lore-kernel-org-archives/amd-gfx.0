Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79291CA6007
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Oct 2026 06:53:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2E7E10FC7C;
	Thu,  8 Oct 2026 06:53:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BxLcOMLr";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011056.outbound.protection.outlook.com [40.107.208.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73DA110FC7C
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Oct 2026 06:53:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HSBCyDcMSwEaXvVePQRJjuWlcw2JiOLmTqV9QVlp3U5WVhLnXymA2GRiEtY9hk6qBVEMzyUeSOEV/v/GF6ZjS5NDSHFrV4zQKKCZD5XcYcrdrQ7O4MtZKKXqP8HNbgO9VdYz1fvH4164Gez1NdaBKRhO6BZPFtlxg086UVCOdcORV4u0Ti8ah9u0oX5Ep700frPAupcfRr9TWtjaC+kzPeREY79a7aV9Lkv4nKb7h2qdGXxiF0kH8aZEFWi+83i/PlWz1CPChOEROZ496a9sTP0qBSpGxyYwdF8qhgGH9Hur9nnt30BT8YHJtk4Y9cp1X0fvmCdgrr60l4iP+XG5mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c+Sb/YpeSEb+MhU9rmDFTvoa/kQbv3NZm7mTLjY8D4I=;
 b=IsjZXC7BNRgI5xq130ilGIJoWfjzIp1a9ww93AaniOBUMRBuL4eEZTeMmEbn8+vewdTVVTPv/Ph4Yi2+RM0ZVmvOMtdA9faFBMCtEG/fyoBuOCyQYHYiBbU7pcPCBaOx+zPHpPM5Q09irl8ZGroIe0VIA8qQoG7iR5JMzgNJEA8khMAPTqSlTDX0YUZo+Ogr6oIdwbBcUiKV5eHNe0H5W7mifhgxFuwfkxItBhXMg0GOX0L65YLRwKHI9TAwYsZ8Eyn16AwrQ1V5x5H5UE9w5+wmuUVgDXp1fGNfrtp00O5c/RE6xrJFY2Wr0Ss85TFE+/T95kC860K+9Zp4x/biFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c+Sb/YpeSEb+MhU9rmDFTvoa/kQbv3NZm7mTLjY8D4I=;
 b=BxLcOMLr4llNDrSVkYQSqOCMR73Aqr1NsAPFVQAetPbEhUjnjI+SJksT1CunseBJG1KvFn2wKM7WzcMLM3oi5iyG9r8gvO2o6cEQUj7sgylpBp4YHNDtiV5IymYOO4m2sRmN9+KtIjbFdH+JrYXLuuhzztTUrVlKOuu8NJnK5a0=
Received: from PH7P223CA0014.NAMP223.PROD.OUTLOOK.COM (2603:10b6:510:338::24)
 by PH8PR12MB7350.namprd12.prod.outlook.com (2603:10b6:510:216::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Thu, 8 Oct
 2026 06:53:17 +0000
Received: from SJ1PEPF000023CE.namprd02.prod.outlook.com
 (2603:10b6:510:338:cafe::8a) by PH7P223CA0014.outlook.office365.com
 (2603:10b6:510:338::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Thu, 8
 Oct 2026 06:53:17 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023CE.mail.protection.outlook.com (10.167.244.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Thu, 8 Oct 2026 06:53:16 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 8 Oct
 2026 01:52:51 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 8 Oct
 2026 01:52:51 -0500
Received: from JesseDEV.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Thu, 8 Oct 2026 01:52:49 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Yongqiang Sun <Yongqiang.Sun@amd.com>, Jesse Zhang <Jesse.Zhang@amd.com>
Subject: [PATCH] drm/amdgpu/mes: wake the GPU before toggling mes_dbgext from
 debugfs
Date: Thu, 8 Oct 2026 14:51:58 +0800
Message-ID: <20261008065244.3608002-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CE:EE_|PH8PR12MB7350:EE_
X-MS-Office365-Filtering-Correlation-Id: b1b3c492-f2dc-49cc-b9cd-08df2508d4d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|36860700016|82310400026|1800799024|56012099006|11063799006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: fG7hkrmPBrPtoZmLyIU4tYwW/E1Wrcqkum6o7s4D7i0tMVpTWIsJjBHhHoPb6TJ0Afjb1E43wt7FE6aSSDjvL6oEEt6VfNVbTswCQkTztQaiNIADRyuUzH0EwHsOQnlSmZYxrUyP4nIlRhh93zkDR6WlGCM7X3ngarB+Upg4g+tv6DbNmltBJxROVd/WgFqQxDc1rGNfmTSw/VLDsw44ax76A+DHLyDbOXZ2pUnXO5mvezfGeCWsTJE7oP1C6AhZVrLZ2SFxOvs/I7+pd85fUuIQFWzMbqfZf+8awD9FetA4NT0ZY2IKziXXJQwb2017jTlhpKM38SAvBqIWYY7wbkotsElq6vF6/A4Q8gJFFGIbmx6ZcVLgH127UXl0APk5ABgQt3aWAefgbkd8yG3pvR28T2EquayIiSgnaLdPDckF+0F0fNtOS3QWa5nGkUS4LdGspgTfzz5slbGjnYZJc78o/2koXC5nyI4X/o5HyMmduMHTES2nND190W5h1uaZKEcV3x4Rtg0s/OOAN+d6+tJfwlXnjh0f/ULnKsFdccvtrH1fc3g3UROXcsNJH8vAbw3NkXQ524ZYRlb/RCoMaBVbQgI7i4H7j74+bhc6W9UzugMyj4asv26Vsyq9W4bD9DLAWe3HO/EBUonp0gOh4iCLkqCicrfxlxhhfLF0Ie3SKa9cuNODNuANwvCn3iwgJJ6PxUcOKrOt8AuGbWP2ZA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(36860700016)(82310400026)(1800799024)(56012099006)(11063799006)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: iuSVU+FjmWa9eWmzz2a8xqhQcKUmvKJZZ4uZjS3XF6c+4ss2VdZntUlthYc93UALUfHFb0II3kFDbQ8qiT4oUADc28af2pBaII3e7HQuZyLTQmCLCUxzzrR/IIdRlpHud0eQiOXhWirjqbNdhNVXfM49yNvg7EBdeJtzfpL9rtqM7e24qUB22tK5TOWmZ2oQxmEBbJoPT7CPo1h0/N2bmnFxJwWtZgDAsrBpxEMQnb5F0xPV7nyxd59mJc41C2vF3nk+a6w5aChfSV2+aVF75ahzvIsOBecLeqLgYEQNvucdbJM+AUpx3kw92sxakLR7piPjnbUZibQEmDBurG2ivsCFsw79nGigj8XLs9jPDwY4AO7jzne4wLy1YwJObrWPflZYTw3292pO3tJ0GwNdHIrWr+JJI8akuXd0ijewXKLLPDlR2fPDahG5r6JQTKyD
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 06:53:16.9942 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1b3c492-f2dc-49cc-b9cd-08df2508d4d5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023CE.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7350
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

The amdgpu_mes_dbgext debugfs write handler programs CPC_INT_CNTL and
sends MISC packets to the MES without holding a runtime PM reference.
If the GPU is runtime suspended the MES never answers, so enabling the
log fails:

  amdgpu 0000:03:00.0: MES failed to respond to msg=MISC fence_wait_ret=0 status=0x0
  amdgpu 0000:03:00.0: failed to setup mes_dbgext in FW on xcc0 (-110)

and the write returns -ETIMEDOUT.

Resume the GPU before starting or stopping the log.

Fixes: 21593a22a09a ("drm/amdgpu: add mes_dbgext core support")
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
index 8d813c68450b..b93b4be05178 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -23,6 +23,7 @@
 
 #include <linux/firmware.h>
 #include <linux/kthread.h>
+#include <linux/pm_runtime.h>
 #include <linux/delay.h>
 #include <linux/sizes.h>
 #include <linux/slab.h>
@@ -1955,6 +1956,13 @@ static ssize_t amdgpu_debugfs_mes_dbgext_write(struct file *file,
 	if (!mes->funcs || !mes->funcs->misc_op)
 		return -EOPNOTSUPP;
 
+	/* Arming and detaching the firmware talks to the MES. */
+	PM_RUNTIME_ACQUIRE_IF_ENABLED_AUTOSUSPEND(adev->dev, pm);
+
+	r = PM_RUNTIME_ACQUIRE_ERR(&pm);
+	if (r)
+		return r;
+
 	mutex_lock(&mes->dbgext_lock);
 	if (enable) {
 		mes->dbgext_runtime_kb = amdgpu_mes_dbgext_buffer_size ?
-- 
2.50.1

