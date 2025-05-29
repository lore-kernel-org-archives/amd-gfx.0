Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67074C5AD49
	for <amd-gfx@archiver.kernel.org>; Thu, 29 May 2025 20:08:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD48110E77D;
	Thu, 29 May 2025 20:08:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="f3u7RUQP";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2075.outbound.protection.outlook.com [40.107.236.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6A0A10E25D
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 May 2025 20:08:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fQNonEapC5H/YbLBKzUV+J6UqA4WU1STmb050+mH/wNg2RIvvIyTfY+cnNNv3rdaGa6tl7DNsKGQLkEGP7U7DIyx4zZYfdtYGAf/LNZ9ibhnH+CSPNFjcNyDIDKevqf7ZQ0JbeFcGGJH0Evyt7aGAshiG9VbV+vL3yM6BMlcLK1PmbE/gq77NUdTwD1drZTbyzWQdOmaozUWh1dl1xM0IK+GK2sV+ZswXuoGdIp2EQnRnthBgvrlIPNMR6SY9N7/BFBBBff2YJ5fIBIWwxKAa9vIQqi3RCCTzYV4t3U3GkCBWEN1sqpv2cFU+g+xf9ydc/j5bnQNuPL+fHVZ8GPTMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S5+X59AK7RhNdAn63RvPw0UVqXp0dHHrb6/rOR8KPo8=;
 b=QrUL/Bt5MIlL/d5Woh3wkp3c2AXf2plaarbq3eM4P9Cv+98ZnjyML3bvLz8eUBclHhdLOqZ0oN41kLzcEucPuxa/52hFHNBtar3IkaKAl2+gdVcgCiGLFdxREjFvibpjUUigO1OgOJ1jEitcvdrgbDIQwP6lbY7CovHJMC6qfECZ6Oy25yrLoIp+F4siwQbRe+pTGNlzcvHqTSd0UgCD7Q9XftDRVRhF9SH7YZIgUJmmS0yzJUPi8p8mczJCfb8BnxVABDBeeOE7fqxHZvAaHFYXvgf8f5nUSJEF+ybcsuioaiI7fqEpYNApZEiP13USOIoZdSl8PaQXO5tQQLWNZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S5+X59AK7RhNdAn63RvPw0UVqXp0dHHrb6/rOR8KPo8=;
 b=f3u7RUQP9pjOw/nzDMHTNTRkn5wTvQEO6UgLUMlm+HHL4GWEhbNHcwEp8Sh24iJEtdwvKz5IXkf09NfI8XtJWExinp0WIFJPt10Y9W8qQCdg0sIoDVk/yShlPstt6n44r1owdDqhLDjW+Wn++YTaSQK4nPeRdjrL0n7E/HAQyRA=
Received: from MW4P220CA0026.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::31)
 by PH7PR12MB8054.namprd12.prod.outlook.com (2603:10b6:510:27f::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.27; Thu, 29 May
 2025 20:08:26 +0000
Received: from SJ1PEPF000026C6.namprd04.prod.outlook.com
 (2603:10b6:303:115:cafe::9b) by MW4P220CA0026.outlook.office365.com
 (2603:10b6:303:115::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.24 via Frontend Transport; Thu,
 29 May 2025 20:08:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF000026C6.mail.protection.outlook.com (10.167.244.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Thu, 29 May 2025 20:08:26 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 29 May
 2025 15:08:22 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 11/28] drm/amdgpu/gfx9: re-emit unprocessed state on kcq reset
Date: Thu, 29 May 2025 16:07:41 -0400
Message-ID: <20250529200758.6326-12-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250529200758.6326-1-alexander.deucher@amd.com>
References: <20250529200758.6326-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C6:EE_|PH7PR12MB8054:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d8fc280-c5c5-480e-8156-08dd9eec9287
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4OOKzVnazpbX7O41z4bFNZOi8VWPJWs+w/VI5vvlJdd2BaiG/SBPw7XAvOQw?=
 =?us-ascii?Q?4FUmcH5dmm5Lh8kzUHUPBi81BTNKQyIZfyC7vQm47b3td/MZEu/A74VsCbdR?=
 =?us-ascii?Q?1BIkf64mQh9C2ptdopO333Car4tWxHc5aSvQbwEcnuDqZro9RcobpJtxfgOH?=
 =?us-ascii?Q?3dyB3okIbErB7FjDAfQNoiVWWXxIho+JxzcKVVzsH1iUE9ILKMtb3/Z9TRFT?=
 =?us-ascii?Q?HTC2MAYNC52D1qKzc3I3wA8nfQ+PICBrITrEfXgn5t69LY2TGMFX9VjOXKuf?=
 =?us-ascii?Q?yypQWy7D9jJrKf5AkhEsgrPnknuBRI6vZgUcBxAEeM3RJfIJrRAfJkNGIm4r?=
 =?us-ascii?Q?0FjcujgTYlcZ8uQhOwhiaNpqZCoysyjy91P786GBPYn5eHqNFwQGyPYwq+WQ?=
 =?us-ascii?Q?NoLg4Wrhrd6bNbchRnED2nU2HxTxWwt9YfpL6hNruOqYGhIo7BIepEsQ78Hf?=
 =?us-ascii?Q?3x67865W7Tg0c/GiTe5gc4dFRG88zrPVvFB0lLyt/ySAIuLC6xjSrUeP63k9?=
 =?us-ascii?Q?pw+bLYfZkycpuwiCM7SVpNbEzBjSFHgFwv229jGrizw6/7tYqdDLCkO7HSP3?=
 =?us-ascii?Q?MvGxob4czrm2fwUaLnii+YaR4Q32xkHkjLffnbv7x+hSRUNVWY68iAa+PjoF?=
 =?us-ascii?Q?tRC0V1wKum6IX1iXbSON/p5kqQjYsr39c6r3D56Niul+aBA6BAZz+9hopPgP?=
 =?us-ascii?Q?KAiPDomaQvGVLwfKzDkUKiYo1xSLmrujLNav8l1FEJ+kLxFlQsc45lj7krLK?=
 =?us-ascii?Q?yeGa+N2zx1kH4FhEd5ajjSv2m48oo0cOytJ9FAJ8WdWtjBYX4Vid2ugFJErj?=
 =?us-ascii?Q?dl9aQZfRGjPi72pJyJToIuR0gQrQ7/DQ5a4eFNQqs71GIAcI/AyC+Uo/O033?=
 =?us-ascii?Q?4lNdbQzUYU7tkqEBE6weYeFmFMgyW3O8AfozzK8hei7JHr7F69P8oGynfpm9?=
 =?us-ascii?Q?72VrZKwwbD5j7SuO6Krw6pEEHigW4ya60Ibs1zmQ7Yl/cZM1cq2g0HFcI0S3?=
 =?us-ascii?Q?l+ZuL8eu8NBSmgWh46rsocO0W0cT8uDI9dKmMHxPvu93cx8wuwX+oAMm7bnN?=
 =?us-ascii?Q?O0aYFae3hoT++tFzBHfpCBUoM0IDx19o1doTKL0gQVdReUNAjrWCpE5ZXyyM?=
 =?us-ascii?Q?BRTZD1TzGmFl/XVck4OUkUssD2UmaySWqtVbXc1tMKbdAttHIA+26ZjhMk0l?=
 =?us-ascii?Q?60ze2L2rc1VRSzC3lGtiQmsM5bfGiVXLEguVIy/zlP7UeUDHs/aGVpDhILkV?=
 =?us-ascii?Q?WOUBU2SvKtVUIFsJHkElubyoYYYVdeid8pBpzktYOYYOYSzvdBEfUv2nLBKO?=
 =?us-ascii?Q?bAElw/yVSvp0Ob8JzhgEdGz8G3qDpuUk9a/KuIcKEBv4lFEHt8u3Mo9FbtE8?=
 =?us-ascii?Q?kxA1Dkwstj62gBb8JksfD4/gwNy8LNuHjvwZdI5xhHVeEfUWDZinpMk2Rws8?=
 =?us-ascii?Q?F3O6FUZfqcr7YhhyodXh1YRCOXBP2YtlBsCP39Ll6tkdvUc9JKJCqcswM3hb?=
 =?us-ascii?Q?gUUdPY0IEFAA9muZ8QQ/uB6hJ0mbTmta3Boo?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2025 20:08:26.3034 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d8fc280-c5c5-480e-8156-08dd9eec9287
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8054
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

Re-emit the unprocessed state after resetting the queue.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index d50e125fd3e0d..0bf8613b937f1 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -7216,13 +7216,14 @@ static int gfx_v9_0_reset_kcq(struct amdgpu_ring *ring,
 	}
 	kiq->pmf->kiq_map_queues(kiq_ring, ring);
 	amdgpu_ring_commit(kiq_ring);
-	spin_unlock_irqrestore(&kiq->ring_lock, flags);
 	r = amdgpu_ring_test_ring(kiq_ring);
+	spin_unlock_irqrestore(&kiq->ring_lock, flags);
 	if (r) {
 		DRM_ERROR("fail to remap queue\n");
 		return r;
 	}
-	return amdgpu_ring_test_ring(ring);
+
+	return amdgpu_ring_reemit_unprocessed_jobs(ring);
 }
 
 static void gfx_v9_ip_print(struct amdgpu_ip_block *ip_block, struct drm_printer *p)
-- 
2.49.0

