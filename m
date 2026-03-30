Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6781DFF4934
	for <amd-gfx@archiver.kernel.org>; Mon, 30 Mar 2026 02:56:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E75D210E10A;
	Mon, 30 Mar 2026 02:56:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CAHEIEgX";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010050.outbound.protection.outlook.com [52.101.61.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7764F10E101
 for <amd-gfx@lists.freedesktop.org>; Mon, 30 Mar 2026 02:56:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eaAAqCK5utvhCRbjL7XExdD7eBO9WLY1zowmqNBVhkuyiuP6qruTn9jUQsTUyMfR8A96T+9U+zOs4hn45MsMtK2l1wxy3YmOybQcYFaZTC5u4m85I91avDjV57EQ8FUdxJW3i9xN8alZBopGm7tM295yg696mb8otNu58iP5Mngeqq9YNlPlbMVpS31D129BphHXhwzYnSP/jOqtsHb8l3Bu7Q8+DhVtaZmB4z5csN6DnTntT52pBsJPBYO4XFrcTXsYpUrlKAuA/bvKl8OYUee8IvDf663gBUNUmashwnsxa+ur183r+ht5JaH4in+EWixz9p5wEjc/9GQHDtrp2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bE+WDcQiO46AwN+9PObj5UmTWfCEL/EeczvQkT/e6e0=;
 b=vSKRNPoqzYTg6VUb0wrOgAVsNG/maKHanZdgJ3nfGn1tekBbSxH0MtpnnZ4CwrZFwutukPBGysjzaODAI9VDvKmLX6FXIHrphb6SubeN6rfwi6EVTVbZwtZk/cDHLCWH6OtzqNeatGpNNX3UBkGrVRelsCTzr3EQ6rus664M8jkvsfxvCLqk4uGbjZdIGMrmuLiarJzUcJWjFUhTRr3w2rbebPUGdMkstoyJZq5IaLloHyVW8PMojM4cPJbip6qz0CpoFwQgrWGJ4zc0PpeEoC0+zLtSVM3ESm7eweXoZCDMO+F49eF0tuNpbUyKUROC7zb1dM8rnEH5ytc8UOO41A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bE+WDcQiO46AwN+9PObj5UmTWfCEL/EeczvQkT/e6e0=;
 b=CAHEIEgXe0Ndb9zPo+aNpxV7wxJ4hTLodaXj3MoZ+ZzwluIy1AaQ2aLvvYytMEXFLOhKGI/MbfR8fTTP0wz+cUGFoJ6d25GD/zcNEcNbYRob4oPeUPQSOkYY95sxQSYBjfedX6uTnUfrNTMCtL080XOdOdjqR17MINfcfhNqnXA=
Received: from BN0PR10CA0004.namprd10.prod.outlook.com (2603:10b6:408:143::18)
 by BL3PR12MB6428.namprd12.prod.outlook.com (2603:10b6:208:3b7::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 02:56:20 +0000
Received: from BN3PEPF0000B075.namprd04.prod.outlook.com
 (2603:10b6:408:143:cafe::71) by BN0PR10CA0004.outlook.office365.com
 (2603:10b6:408:143::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Mon,
 30 Mar 2026 02:56:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B075.mail.protection.outlook.com (10.167.243.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Mon, 30 Mar 2026 02:56:20 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 29 Mar 2026 21:56:17 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Alex Hung <alex.hung@amd.com>, Aurabindo Pillai <aurabindo.pillai@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Roman Li <roman.li@amd.com>, Tom Chung
 <chiahsuan.chung@amd.com>, Dillon Varone <dillon.varone@amd.com>, "Rafal
 Ostrowski" <rafal.ostrowski@amd.com>
Subject: [PATCH] drm/amd/display: Fix dc_is_fp_enabled name mismatch
Date: Mon, 30 Mar 2026 08:26:03 +0530
Message-ID: <20260330025603.2145115-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B075:EE_|BL3PR12MB6428:EE_
X-MS-Office365-Filtering-Correlation-Id: e5ce58ee-209d-432b-3c1f-08de8e07ebb2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|376014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 6UYuXN6OOatF3fBjaPEqeib/Ph+uKcfSw4blhSQilBGZWfKh+nuAc7OAC+JWfVdMi0dZFEvnC5++FSTZEW2vqhVCtFV3Na1gViru41LVf1YQ3hChX85JU5RuvwTCPR69CoFt+w5vuF0WTDREIi8QN31ry0eSaNhQGBALyfVFBWE0OpE+K3/LvQvUF5c629qP5lCEHOKWnQgveJNyKXxJ0sy3+z07NCL8l/w2oZdHtjR2hxh2pfvCIehZSbojKcQN1TcWn79wsHA1NUwkLaV2VZJN14NFC2DiKCeUkewvR2U6Xid0HtW8C+uO7aUxCPPkqFQigNR0NAtKb1IZuRoNf/BlIA043vOPhbpp7QDezCpPNPmzhpKEIBXMsVRH53yyfnOhEKduXrgfYIFvgiuriqjtGZaN0gLTq9P5BMzPH+Zhqeu3QWLkGM+EErPaRb/y7KKeQGyDDz4mCe0tp1df13fGTGAJWZEqeJVOMWCBo0v5YwNWZ1cxZ49U8DmUGBhQSO/gILg0JA/8fx+nY4hPmUJgxN8RNGeXH6YZ0Yp98P0Oio/MxNQozTdw2mGKTuO5/BDdqnJsKrSrCGbi6/ynaB4bWPpYNX+2KXUGNoNrvXTE7s1WNlbH77Vk9ZHYJ58uSxhJ1kUcm4mtDLwRXYC8NE0H2tspkGqaecr27nMye+wikaCsf9DRm+4J0T7EbdQ5Jd4O7hDGLuLuPu9q/CHwo+MkFFu1ZANlFWo+1X2kVx9bXZuKrVH7QScOyDjhQRsQ1rGLY2m0X8CKVLxz4QMZmw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: TnseeLl7u883X5jJkkVI1L++228t3vdPjLbWGETZRGAqlc3trFGLeyzl98NiDJihIR8yr6Fas96C9YlmbHCsdU3g7ZoyYpydNp4YwvcxaleQE0WBB7e61/njDRReShTME8peJlA0f1oqiV9fci8rUZxP7WGrp9XVilsmaW+9A/YIgh2YS8ARFuTjIIOGj3ODDQIXDSpgdaujfGcMAYfLmSC0NfW7kWwmiVal0Q9wHn1HH6EzUBkEs8MA1s8fFtwChKEezWOB7Ci91wb5CxyyF2cBecm0dgUZ7sW9RkRXAUDkrZWmZVa5khwwTk3KNnH0aP9lp4l9vLCBd9GArTkae/dVNXKT6UGqTrAssDfEMJYM2cPr2LXpOnFEO496ZScRuXIING2IhhKjqUuKjiFP+iRepV2bsTX73Dk0COopPNIrM3EBubT97jdd/bZxtUee
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 02:56:20.3004 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e5ce58ee-209d-432b-3c1f-08de8e07ebb2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B075.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6428
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

Fix incorrect function name in comment to match dc_is_fp_enabled.

This function checks if FPU is currently active by reading a counter.
The FPU helpers manage safe usage of FPU in the kernel by tracking when
it starts and stops, avoiding misuse or crashes.

Fixes: 1489d86d9ac9 ("drm/amd/display: Move FPU Guards From DML To DC - Part 1")
Cc: Roman Li <roman.li@amd.com>
Cc: Alex Hung <alex.hung@amd.com>
Cc: Tom Chung <chiahsuan.chung@amd.com>
Cc: Dillon Varone <dillon.varone@amd.com>
Cc: Rafal Ostrowski <rafal.ostrowski@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c b/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c
index 8ba9b4f56f87..172999cc84e5 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c
@@ -59,7 +59,7 @@ inline void dc_assert_fp_enabled(void)
 }
 
 /**
- * dc_assert_fp_enabled - Check if FPU protection is enabled
+ * dc_is_fp_enabled - Check if FPU protection is enabled
  *
  * This function tells if the code is already under FPU protection or not. A
  * function that works as an API for a set of FPU operations can use this
-- 
2.34.1

