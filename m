Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D89CC28B30
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Mar 2025 20:36:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B67D10E688;
	Thu, 20 Mar 2025 20:36:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="S3LpfZt8";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2064.outbound.protection.outlook.com [40.107.236.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7BB9E10E6A6
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Mar 2025 20:36:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QNPwetrhLH6zfl8rxmlPEIv56Wmixq8+GAo1ExhPYqR1oeH0P3B4n6JJW1hGOxVr9Cjfa9tszWU4pZ/WWoB1h7M7osPcUNH+wpdv0aH5hv7RlbNo6x95QtZczlXQ7tmr3yU+YWCG787JE5eoIZLa15r125Q17U7DI0LhGA+chFqF5RBZ2HJ6uI9duQJbY/vg6g3ioj6TF4ZrQZg7YS3BVXDfqr6r+BUK7T01iRZCS4czw32IlbRZ3FYquoToENUVRUsoyWzQ3UfkHbMUBn+d7fe6Qe+pZFgJR+J8F5bdMIzgW8FrSsopO0gMcmhDfkwUXChMXSD2MYoqZ8uaQbYZEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XQFBIBqXrV/riBZFOUAiEXrEiAZysGGu2YsUFv2y3K4=;
 b=PJhfLGAQQtpHzSxIBcrMSW2L0JAIUaSpe3oJy19Qb5ACBlaaFsP+JHcE+eL4ICHZWClrJYsw5l813earqH390DqmrsBryMgydBa1MVWFDlUx48sR/5gzhKYJZZHWFyNXS1yjv97Zc9XxuIRpgoAGTsWkl0CvA5Y3ci31bGLos3UdU5CfPYZqU+plYcfZufyeXYeJu2ngFgehdJKQiXKJD5WUdFZNgV8FHmhRQ06pZ/gsFdNQjpCxvQU11+kITQ/HDjqPBSTIRriyV/iwZ59x1yvk7Y2yPny5UftPYjWugnCn66kSAD1oOfbhoG3uGwva2e6RPBeS8pu/4HaafK2dXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XQFBIBqXrV/riBZFOUAiEXrEiAZysGGu2YsUFv2y3K4=;
 b=S3LpfZt8/O+yNZFp2IgVqWH1b9OOhVWBSQpVftTt2lhcqfHsrAY3el2GCidYsOamdCXYfYXuuSEbmUv3uKdyFIkso/qUFicSbgoepFZFiUqhoWsQENNFMlEQSydfeoT2lET2uCVDx4RomiCvCIPBZQxVmNBtKeif4hGJeVZaZmY=
Received: from MN2PR15CA0037.namprd15.prod.outlook.com (2603:10b6:208:237::6)
 by PH7PR12MB7844.namprd12.prod.outlook.com (2603:10b6:510:27b::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.35; Thu, 20 Mar
 2025 20:36:11 +0000
Received: from BL6PEPF0001AB78.namprd02.prod.outlook.com
 (2603:10b6:208:237:cafe::80) by MN2PR15CA0037.outlook.office365.com
 (2603:10b6:208:237::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.36 via Frontend Transport; Thu,
 20 Mar 2025 20:36:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB78.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Thu, 20 Mar 2025 20:36:08 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Mar
 2025 15:36:04 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/3] drm/amdgpu/gfx: make amdgpu_gfx_me_queue_to_bit() static
Date: Thu, 20 Mar 2025 16:35:47 -0400
Message-ID: <20250320203549.1345822-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB78:EE_|PH7PR12MB7844:EE_
X-MS-Office365-Filtering-Correlation-Id: 1484921c-4583-41a5-e668-08dd67eed85e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jYHRq8gIGMY++vpjUVA+KF6zKPjwigHPaepjYZcyMnkJ2ZjBF2oQqfVeDO1U?=
 =?us-ascii?Q?1yHtiHbhRR0xz0llG78idtHKBhX38hRuv7TBu45ggyFmErKrPXjcrQKnyn7f?=
 =?us-ascii?Q?Tmo7PLE7aqxa4OPFzgmZLylmrSScKYP3OgcewY4siadpKJN3mlh+Xto1O5An?=
 =?us-ascii?Q?PBHgtYzMkrN6EaEefbqYApWWCmZJWp+W17pnb9rzrENq4W3kBrZIOGYYZb/E?=
 =?us-ascii?Q?dugord6dRi7QB583MrS5t3YwjjQ4rD84Z+9GnlhDxkcAo5bqu1ENWgCzq1T+?=
 =?us-ascii?Q?EJ1xlmeWCknfV5C5OXVGCKH1KJdIzmZZppirX2YZO6sWQ6fmcMVjlgnduiZf?=
 =?us-ascii?Q?RB8Kg2aFsC9G5ZXmHMs7/5jaf79/x+nN0It538mnpr0u2Wo1KPP8funrDZgY?=
 =?us-ascii?Q?4OYWPsUr1BnBvy6sL3SgHi0c3rcFDBXqybswRJqU/h4jBpl9FkggxW8vG111?=
 =?us-ascii?Q?jqJAE7iy9MyUO53tQxm6WFYtyPvceP3fVPzv+GU+ebe5LeSGg3Co79Ax/akw?=
 =?us-ascii?Q?r+UNvA5REDFaIK8nWnDj0o7ECfzg1CiEUa+B4Nk/IGuSLgJbr91tLaIZVGja?=
 =?us-ascii?Q?uqSgvuKXRyH/3yT3SXPfGIjHCQ9F7XqWb/x013ibcr/zSXCUGu3frKkIt+0s?=
 =?us-ascii?Q?AElkgZAThoy4OGOufp7blwh+7htIuaYyDvFabZ8Lr4YAh5tPyHKZjGPhrEhm?=
 =?us-ascii?Q?aYOEu3aEuVb0vJeMVK5O3q+QICo6ZuV5Xfh38updw3X12yLdFrCzH/KIQyOh?=
 =?us-ascii?Q?HlH4KG0JP+eg42yVOU8tYNFq35LmkXCqkRlH6Gb5LP9N/9yUw+T7QZrrVqBE?=
 =?us-ascii?Q?KtvIHkHkfNcX/UbdvzZqHSMHe1riGXi8QxuqPrCjnnP0jonCsgZ+AN2vsSTv?=
 =?us-ascii?Q?3KM7SU9+sqqcvFJXR0ka7iuo/M7sc+9ReMOGSAY7GB6V2VBPPnx2UM2EmsE3?=
 =?us-ascii?Q?okvoUGYPjXuypa3gzJ6OrtvN/6PdR0cKkhEm4/ujtEvZ9M2pqTCwuvHkZTyc?=
 =?us-ascii?Q?qjm8k8KKfsGe/Dt/0grZeOTeW78bUWiLp76jUhWdr0Bsa7xxcQZnbpp3LF2V?=
 =?us-ascii?Q?RmgWYorkjcUnd175a7AAkQAyY+rQQCjN/ss9exZWy6QCpzqhpVa0rJDI28lC?=
 =?us-ascii?Q?Rj7eQDECsxKb5pbTgiULlQpJB+1bp3CASLIYYWu9Ilabx3tQkLo3RZ8Uz9uQ?=
 =?us-ascii?Q?oAVvRj6RAwHYR8ynKG1qyp5tX4V3ZpvgLBujynumUGLDcVpm/AzGTcDo7kvT?=
 =?us-ascii?Q?+Td+ibLt+tvJYhsNvsEa0GUOc2hivovMjuqFsfnL0RPEBOwLK3kPm/nte+pZ?=
 =?us-ascii?Q?jH3PxOaPCiHeAthk9HE/aluyHohWWxVGkdeKlg7yY3EVYiqOa7yWKCxSfhOz?=
 =?us-ascii?Q?SCtUd6N9IYZnuHb/9LIk9Aq0lyueTkkEK8NIxUxnP5zKhnjBQaz4woFT99Od?=
 =?us-ascii?Q?9JKFZdzeR92coBS1heDkI1Cd3nye5TbcxhwdQoktV1U2jMAWPeIPvJ7ilLou?=
 =?us-ascii?Q?LMAFAwjkBCBg3+E=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 20:36:08.5985 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1484921c-4583-41a5-e668-08dd67eed85e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB78.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7844
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

It's not used outside of amdgpu_gfx.c.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h | 2 --
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 72af5e5a894a2..04982b7f33a8a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -74,8 +74,8 @@ bool amdgpu_gfx_is_mec_queue_enabled(struct amdgpu_device *adev,
 			adev->gfx.mec_bitmap[xcc_id].queue_bitmap);
 }
 
-int amdgpu_gfx_me_queue_to_bit(struct amdgpu_device *adev,
-			       int me, int pipe, int queue)
+static int amdgpu_gfx_me_queue_to_bit(struct amdgpu_device *adev,
+				      int me, int pipe, int queue)
 {
 	int bit = 0;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
index 75af4f25a133b..319e6e547c734 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
@@ -551,8 +551,6 @@ bool amdgpu_gfx_is_high_priority_compute_queue(struct amdgpu_device *adev,
 					       struct amdgpu_ring *ring);
 bool amdgpu_gfx_is_high_priority_graphics_queue(struct amdgpu_device *adev,
 						struct amdgpu_ring *ring);
-int amdgpu_gfx_me_queue_to_bit(struct amdgpu_device *adev, int me,
-			       int pipe, int queue);
 bool amdgpu_gfx_is_me_queue_enabled(struct amdgpu_device *adev, int me,
 				    int pipe, int queue);
 void amdgpu_gfx_off_ctrl(struct amdgpu_device *adev, bool enable);
-- 
2.49.0

