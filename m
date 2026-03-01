Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 684E7FD0060
	for <amd-gfx@archiver.kernel.org>; Sun,  1 Mar 2026 12:50:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0BBD610E254;
	Sun,  1 Mar 2026 12:50:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ODgSAXxE";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011011.outbound.protection.outlook.com [40.107.208.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4661010E254
 for <amd-gfx@lists.freedesktop.org>; Sun,  1 Mar 2026 12:50:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CPopATtF7Wz9Br8e/8kgMjiUIMEU8eKwwqrJruxfpqxY1L7LqE0XnY6TlP7WSObLLP5r8vBi5yjRi8BZXHlSbW0qVNSHj1jaN+eEKPg7bcguPElb+zNJNONtZijwrGD198qXm01140YNA3HotjTtnFVH3tznDBpbpgEzfUq5Z68mt+GmySDlGB6tblc9jjZ8PFG0tEFRIss4GWx/3Wme1pSTXu9yaROAqjvva+pJKDuOooFBATKYaT07P0HbmYOsscRRvx1tFZrdV7Z7gQYS6znkbg7tIt1VyBKnXjN9C/GIUn0iPDB23qLAE70XoDGbb3NGYCGTxh6JAbw0SCpvcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mlS2KCmhJKqsbNUHiLbWQkECWmZDU0Pb/+FVodEj8L4=;
 b=nT8xQsui/RcBRofGi3ShgC5T6j1da3F9pvMjN/0k4U40enhPVoEgGQQ0/EVxAFgQwFtYwuw1bnLNmHUToxLuVedKkDEvAYQ2iP40WhicllaWdHh/C7xSmdCHEuvMw/kIw8z3eT4vVUxXgGLd7sahi+H2t3B5utm6jpkfLCxVpWuA+fdDsCxFfFegHyIZJbZkvl2OppsUHBWnoHDTkDSrHeOSgJzni1QrABz7kEXVtL7LI0Gj0At6PclfrU4XXp1WH0PsS2z1hfzTTr6SjPDj/ia0y3Y0PY97P7XEkJPEUkFK700Xl1Rpl24+r/Ly8oa0BRUhjfjldGtr4VfMM5QFUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mlS2KCmhJKqsbNUHiLbWQkECWmZDU0Pb/+FVodEj8L4=;
 b=ODgSAXxE39+ZYxo/T//rjN6hyKsaPjETvNtZld57QBVQ/TiixGeKee4dUATS2ITVQ49UY2PC4zOMu0s6iuhdeFf/TG4MTBlbBjCRo+i2VkfWf0ztlA7eOoS15ohu9xiRVdEuQr1qMK4k6mouwSkIDuzrMzpY6TA8+JTyG0/FXJI=
Received: from SA0PR11CA0015.namprd11.prod.outlook.com (2603:10b6:806:d3::20)
 by CY3PR12MB9631.namprd12.prod.outlook.com (2603:10b6:930:ff::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Sun, 1 Mar
 2026 12:50:08 +0000
Received: from SA2PEPF00003F65.namprd04.prod.outlook.com
 (2603:10b6:806:d3:cafe::4c) by SA0PR11CA0015.outlook.office365.com
 (2603:10b6:806:d3::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.18 via Frontend Transport; Sun,
 1 Mar 2026 12:50:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003F65.mail.protection.outlook.com (10.167.248.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Sun, 1 Mar 2026 12:50:08 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 1 Mar 2026 06:50:03 -0600
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>
Subject: [PATCH] drm/amdgpu: Drop redundant syncobj handle limit checks in
 userq ioctls
Date: Sun, 1 Mar 2026 18:19:50 +0530
Message-ID: <20260301124950.1731192-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F65:EE_|CY3PR12MB9631:EE_
X-MS-Office365-Filtering-Correlation-Id: 433ee103-8247-423d-691e-08de77911188
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: kE+mXzTQoLdFd8VmASQbxvyohUHH0/duPFxiBhpHNy6jG2tdZsou1UBUv59qjlZeegbhqWMamaFi2fGHdv1TPHm+y6FfEuHasfOFjWSs1zgI0AbIGeiQjvebXeGJzHj12az+mLZVVLuNEJuaK22AGKzgM8pAz2HPqQHyPYfd7HWUKH7Gl8kWzjNd4DaPxsbcjx+dhLakG0QnMDMJInXg/Ao99vqM7YIgVXjxUG6aJvkENF8omh/c9wEaT3QLPHdBstCUpRMI9rOQArBsn0SFb5kMls48SpTFiAmgE9PGGi2uxf4FVrPBrfnLPyKjKWBZoqEfjR5WIEyMQhbzSCHaxgfbgnAU6FdRD/Dxi9KHb3V92vlG9UuEI6JkhLfEZroSesCgtJwbKeysYtZSLPvuDGB1aRZJb0B1g5MhBIkBvwwYRrhl47T/Ns6sE3rGFrUI1mm1YC+wNBBs+4KNwDdS7xvKPYklQ3T9eXaKtXy4iMS+Q9LzuM2bLW+/8zBMNr6dMGcgfZ662kKbiAHMj83muyfCDbQztOAT2wd2f3gSlxW41KrS9EnNIwJP0sgG3XczCS4nP93KxPr7ZALMn5d5061TWTvajZ9hbMCNMiYEVqF1uDqEmBzSDAajxf2KvXrtYEoMCdmFhKQpvF0OSSBEYxVob36PGxbqIKAYdSsMQr7mYRxMkghJiQnXlX0swIpmaZoSZntxRM8mqtXAOx2L63EZFGUTTbkayu/OXgpBprBUxqMhLsTCvpjtShEUNUfwMUGzjq2kKqNpJz6707XqLKHeay5sjKAevFvMPgNH/vvX/AVvzMFwBkrqEIvj6WKnqDnaTiS3H0kEG4bfh8laTQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: kUxsroIZZ6pEBAXmyD1xkVYub7cV0nC+qpobvmQPRmKnih2ifLAPXwm6h/hs9w1LDvVhMNI5z8TxqqvQR8D3w5wvXZfcukyKyAr3NHZzLfQiW5KSTcNjJI2nfSiSsJ6nEGzAVHeW0dwwWG1i1hE7EZXpZhZTPlVva9J+EW1nUHaYP0THy3goqC3C1OFv5mCOfoIPKfw5A9c7b8RMsvG3vT4nkMzq1+3v52/B9YVvRbXehffBShKDZgY/iADnEOegx/TEJMjnC1d6EDx/No7Jrf5JwEzY1pOEOfXFA02cdlJ8ON3vvkLBTlwWlLGeStZaN2arHcmes4ky22huX4c8P4P2ut6+UG/skdJE6bYkHZLXz3iDgYgqCTfE1ns9Ii1H2Hm9UEoV/8RbqUzAYgRK9m4a8F3HChohXB6hemISHWtq4XJ4Ex2uzgoeaF8/gLSk
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2026 12:50:08.0679 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 433ee103-8247-423d-691e-08de77911188
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F65.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9631
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

Clang warns that comparing a __u16 value against 65536 is always false.

num_syncobj_handles is defined as __u16 in both the userq signal and
wait ioctl argument structs, so it can never exceed 65535. The checks
against AMDGPU_USERQ_MAX_HANDLES are therefore redundant and trigger
-Wtautological-constant-out-of-range-compare.

Fixes: Clang -Wtautological-constant-out-of-range-compare in userq
signal/wait ioctls

Fixes: 2a235bc2e28e ("drm/amdgpu: add upper bound check on user inputs in signal ioctl")
Fixes: 7d79dc596e6e ("drm/amdgpu: add upper bound check on user inputs in wait ioctl")
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index 3c30512a6266..f90321fde665 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -480,8 +480,7 @@ int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
 	if (!amdgpu_userq_enabled(dev))
 		return -ENOTSUPP;
 
-	if (args->num_syncobj_handles > AMDGPU_USERQ_MAX_HANDLES ||
-	    args->num_bo_write_handles > AMDGPU_USERQ_MAX_HANDLES ||
+	if (args->num_bo_write_handles > AMDGPU_USERQ_MAX_HANDLES ||
 	    args->num_bo_read_handles > AMDGPU_USERQ_MAX_HANDLES)
 		return -EINVAL;
 
@@ -636,8 +635,7 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
 	if (!amdgpu_userq_enabled(dev))
 		return -ENOTSUPP;
 
-	if (wait_info->num_syncobj_handles > AMDGPU_USERQ_MAX_HANDLES ||
-	    wait_info->num_bo_write_handles > AMDGPU_USERQ_MAX_HANDLES ||
+	if (wait_info->num_bo_write_handles > AMDGPU_USERQ_MAX_HANDLES ||
 	    wait_info->num_bo_read_handles > AMDGPU_USERQ_MAX_HANDLES)
 		return -EINVAL;
 
-- 
2.34.1

