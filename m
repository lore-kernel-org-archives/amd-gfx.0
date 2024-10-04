Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FBD4CF8849
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Oct 2024 15:50:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 16B4810E027;
	Fri,  4 Oct 2024 15:50:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CNbcSnak";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2089.outbound.protection.outlook.com [40.107.92.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 74CD210E027
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Oct 2024 15:50:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C+EW3FZOUQUwdlBWk7FuB8mTKBBYgGsat2lEdSlnL1d7fFsvonFflxW5uhKxd2v0+brf/rRd6XnaQee1gpP4kqHEZarhfMlQNEdZpQHOkJl/FGYTULUK6TiV5/i44bs3LpY6WVlJ635PAlXVu4sjko848roivsSY4JfjxKLp2wFK8aTsTbufFxX06GbAVf8bsqP5azQQe1RBb1+1JdHFxppGTNZ5C+dIHeDakTgdf2EazvXXW1rK/E8HH3SbJYZ4Urcn4Zc9kqnTt9tmqNVTU/vOTLt0NONKt7ALXmLvrVN3yVoQQhmLPgAKUkjp5HrEatyBEK6kL8lbbg3uqXmuqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GlRkce2/1AtGkluau51hFOVqMmqDEWiBHxP4dgZEVus=;
 b=tOaeMnEaL4wZmWP/MGPYb2hGOGpvLGoSH9V4vhfMCkQyKOSk3uvljMrTbwMNkw1ZlhIXYjTHAcN6KuMbRE62Ak0NP9WNNEGqhl3sGrq+bGzuCAGXNJIim6rqq9CK6EAb/DhhtIpjlhrW3MUUaU49lQyCh3DoC9RzVk5M7oGn0h8DIBb5qt1BP94G230UxChDmhDwjuPnLzrjHwXOkFUQ1lO0hRbJ+urqOZJqo3fY4oTMXuhTtCJCKl/L44tNa32fGrJBywrtpsvt2DpCMcG8TmuZIy+LC8ItFz0IpkH9eVVK6k8tjf7+qNwqU3g7TLrKii5aoyF5/bBOTzNGHWFh4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GlRkce2/1AtGkluau51hFOVqMmqDEWiBHxP4dgZEVus=;
 b=CNbcSnakwDAba0qnWzKa2xBem4MTSKu9QPru7HUSY0a1J00jgcJPucN+6SShuttbQ/cAxv0i0yObuGtlaAHOxeB1Wcxah9nZbTGtvTYvRi5staztlQV/pghLsT1SsIIc/40KSxA0PCfhu6fOeh/3+boKK2b73jqAGbzph8iZX8s=
Received: from CH2PR18CA0022.namprd18.prod.outlook.com (2603:10b6:610:4f::32)
 by CH3PR12MB7714.namprd12.prod.outlook.com (2603:10b6:610:14e::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18; Fri, 4 Oct
 2024 15:50:48 +0000
Received: from DS3PEPF000099DB.namprd04.prod.outlook.com
 (2603:10b6:610:4f:cafe::61) by CH2PR18CA0022.outlook.office365.com
 (2603:10b6:610:4f::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.19 via Frontend
 Transport; Fri, 4 Oct 2024 15:50:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS3PEPF000099DB.mail.protection.outlook.com (10.167.17.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Fri, 4 Oct 2024 15:50:48 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 4 Oct
 2024 10:50:47 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 4 Oct
 2024 10:50:47 -0500
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Fri, 4 Oct 2024 10:50:41 -0500
From: Xiaogang.Chen <xiaogang.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <felix.kuehling@amd.com>, <philip.yang@amd.com>, <kent.russell@amd.com>,
 Xiaogang Chen <xiaogang.chen@amd.com>, Xiaogang Chen <Xiaogang.Chen@amd.com>
Subject: [PATCH v2] drm/amdkfd: Not restore userptr buffer if kfd process has
 been removed
Date: Fri, 4 Oct 2024 10:54:01 -0500
Message-ID: <20241004155401.18978-1-xiaogang.chen@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DB:EE_|CH3PR12MB7714:EE_
X-MS-Office365-Filtering-Correlation-Id: 01119e9f-ad6e-4e77-d6e4-08dce48c50dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?sto4bXKP9+0elXThmSgM3v3OYfcjyI5Zylik6fanAbnvyfd4L3ZLSM6cHBHn?=
 =?us-ascii?Q?qmGFmECXFf8TGmq7Ngt2RfMVAL7s38LCgpUFAypaRsBZfqfeq6HtAlDwxoli?=
 =?us-ascii?Q?eHZ6aBDp3y4Z2SJb/n/XXtXu7x06JvmASLEwEEdqpeMKF+Qms0N9IR4spAn6?=
 =?us-ascii?Q?Kz8ASDWG1dHNN7fDjbxJHHVATDezS0hQiMU6tbCItg9N83HnN9ECGTDw3gY1?=
 =?us-ascii?Q?ZNZIE8JSIZVGkWin4mOgHDGI+Dsmqn/INUTB5ZVJfl7ZVV6F+OKeqCoD2jET?=
 =?us-ascii?Q?/6A9+QIxY0AIESvh2okNEojcGMxD5A5BdTrbl0c8qN07PtWxdlb2D3eTfwnj?=
 =?us-ascii?Q?kWsZCZ4GwlC/Wed0hY6s0ya16igVrrW7Z+RhoGTMkPfsf/35CbLxDtbQfYXE?=
 =?us-ascii?Q?wE9NK//mOZBbn34y786I4yMttf1bAeErynSFWbPSF5Ff59JiGZigN8w1UOe7?=
 =?us-ascii?Q?aPh5ykA4QjynWRLFdt9I9smtiQX+cZqaZeF9OJC0mJYxvRPc1WQVpgLOWy5o?=
 =?us-ascii?Q?F2V+mbrZrJjBj1TRIY+PSjJvg4OcNWh1Ae8AVnLMje/XiKGlfbtbJufU/meR?=
 =?us-ascii?Q?dMB9J3LRfwiq/7S6wsHkM5k51nf9Ks06APPHvGJ51t6httg508ldsPhvj8ZQ?=
 =?us-ascii?Q?o6Rl/dIJy04VHeOgV5tN3CR5nqWPTP6rCQa8L2pflkYdGJWVEkF/qWhoszeC?=
 =?us-ascii?Q?FndZ+k7p4/TZjKdRfurcMnwe4O5FZSsDwGWTUnbmiVkqRvJauEJlYowNGvma?=
 =?us-ascii?Q?TZbfyA0XzYH7V5YXM2SBLgVHPIgCZl+xP+9RoaQqDhgfwssTNiERvRnth8aw?=
 =?us-ascii?Q?8ZUp2IMEpS26SmD2QBfrdfnLJth4DnUm+ddQQiHb8FuQi20JUhP+hIBqvuJk?=
 =?us-ascii?Q?gucqIahletSvzXjRiiW4uR/nO2VrtfHOu+atNiZTzIqPiF9paB5iNOQSTqKZ?=
 =?us-ascii?Q?vGkyDYaw/cMloRgOLOQom3NAvTVHjIGn9WEBCLSu/rkUqdiOpN4hvAcAe8I5?=
 =?us-ascii?Q?52RiVZAz+cPDgfglXhMLvJTI+uP8KI4a+VqPDMgy3UkquTRKOJ2LAu3X4Yb9?=
 =?us-ascii?Q?Ft83i75pr7VN2E0d9itIRFy4k+3dhX9voXq+UMeMP5zkOrYCZCgPybJbFWfB?=
 =?us-ascii?Q?gH2fgxhAB54syyHvjVph0Gm44pCiNJdgod5upZspMQbE97+6/rF49hNWqjxM?=
 =?us-ascii?Q?1EPg//eQkBWccJc2TSl1q/0H1C/fR5k3gA6K/ughh2FxLXW67AHo8iz/Ny4G?=
 =?us-ascii?Q?yS25P3bhIl6i4s3EOVgwTMaMwkJqEb+tgSdPSxlPmFCxwOztMzEBAlyCEgjM?=
 =?us-ascii?Q?c5t40pqCjL+Xh/zWEYG2cxykrLdskkz/Qdl2LaC8jXBJ5OIyKjoNRrk4cllI?=
 =?us-ascii?Q?rwCsFGzWrmXsk/9lVIzU+TyDrKOX?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 15:50:48.1878 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01119e9f-ad6e-4e77-d6e4-08dce48c50dc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099DB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7714
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

From: Xiaogang Chen <xiaogang.chen@amd.com>

When kfd process has been terminated not restore userptr buffer after mmu
notifier invalidates a range.

Signed-off-by: Xiaogang Chen<Xiaogang.Chen@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index ce5ca304dba9..6b4be7893dfb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -2524,11 +2524,15 @@ int amdgpu_amdkfd_evict_userptr(struct mmu_interval_notifier *mni,
 		/* First eviction, stop the queues */
 		r = kgd2kfd_quiesce_mm(mni->mm,
 				       KFD_QUEUE_EVICTION_TRIGGER_USERPTR);
-		if (r)
+
+		if (r && r != -ESRCH)
 			pr_err("Failed to quiesce KFD\n");
-		queue_delayed_work(system_freezable_wq,
-			&process_info->restore_userptr_work,
-			msecs_to_jiffies(AMDGPU_USERPTR_RESTORE_DELAY_MS));
+
+		if (r != -ESRCH) {
+			queue_delayed_work(system_freezable_wq,
+				&process_info->restore_userptr_work,
+				msecs_to_jiffies(AMDGPU_USERPTR_RESTORE_DELAY_MS));
+		}
 	}
 	mutex_unlock(&process_info->notifier_lock);
 
-- 
2.25.1

