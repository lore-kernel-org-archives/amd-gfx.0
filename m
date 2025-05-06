Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6300FC3ABAC
	for <amd-gfx@archiver.kernel.org>; Tue,  6 May 2025 08:43:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3CB810E1D7;
	Tue,  6 May 2025 08:43:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Y067e5m2";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2076.outbound.protection.outlook.com [40.107.243.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46D3410E1D7
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 May 2025 08:43:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CXTYuz/K4kSzjRyq1YSU6mTAUau372xos/kB0mn35aItpsa1Sv8F4e0lGpvN01EOAXWO1Pss8OqNQDR8Hl5EmMFvE1aZfA3T/nkPdmrVWLVXvJ/Yyg7mNukcNRcM/deE+We3qnI9cjEEzObb0wUkXv7d1PTmG6p3s0Di1S+feOsVxoOnKZVNt/LzeAOEqDPdCGlq3a3Oj8r18YJarB6nk7r7e2sfeXu+gqYikFgKizLZLqKIHtizOrlRxS4dLtiT+wdN4aWUSijOa0yeU0BouSqDFsHgv2KeTCqz52907724zyIOdEXmWQM9VKadbCPuzOvhMI+4t1ZtusfvfwUicQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FYoQ7MpQDmiD/zcp0VkG+A2aVfZDyJIySg15g1xE4zM=;
 b=lN7JkBUEL2d3lVBzg2G6LGqPxHwAHzptWdj3BgrG7Ss9AXMFub4ErFgilSIrI9Uf0ny71e2rzyaR32eo8p+u2+WqWBwCPqrvsE9A/BlSe49dvAMUxkgexDNpkOzZBez3TH5zldLcAye3uAbp37KdRjYEFvfbQ8SbNUGf53Xy7yz5nrR3vSTk3ygA7DSVaxiud+AqRO2V5hwi283EpRFWofTlSRHqmBPVY9Nh9vKP8SE/jBBxXT2fmelrYVOCqBg4wMZ/Ew0DG0R89yHZAw7m1JKvfNAAvW9mtQiROsOqUY2hvyDQ036dAmb/aLMsZTa6N5KbCdpPUQ2UlSdyruUc/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FYoQ7MpQDmiD/zcp0VkG+A2aVfZDyJIySg15g1xE4zM=;
 b=Y067e5m2uIHMJ9HFo9nXCrr9ugogmCeZhfKNKd0WqI100MQ8IVlrpbWQlH1b8px9VaKltk+oNm7v15ZrWdZ6qoa2Idfl8QHhY+Q4pXjdef2vUgx6a6mPpQFmaewvTb28RNobkZFAHD88W3FUUq1RyTzKaoEeaCN8Q+QixmX/Qw4=
Received: from BY1P220CA0001.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59d::14)
 by DS0PR12MB8766.namprd12.prod.outlook.com (2603:10b6:8:14e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Tue, 6 May
 2025 08:43:39 +0000
Received: from SJ5PEPF000001D4.namprd05.prod.outlook.com
 (2603:10b6:a03:59d:cafe::22) by BY1P220CA0001.outlook.office365.com
 (2603:10b6:a03:59d::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.20 via Frontend Transport; Tue,
 6 May 2025 08:43:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D4.mail.protection.outlook.com (10.167.242.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Tue, 6 May 2025 08:43:38 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 6 May
 2025 03:43:37 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH] drm/amdgpu: unreserve the gem BO before returning from attach
 error
Date: Tue, 6 May 2025 16:43:27 +0800
Message-ID: <20250506084327.357722-1-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D4:EE_|DS0PR12MB8766:EE_
X-MS-Office365-Filtering-Correlation-Id: e52dd20a-5a17-44a7-bf9b-08dd8c7a1914
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bEwLz/RqDhIdT2qi42qjYqm/XFY/fsY1W3Kk6bnv0VMdLUMYACVcRQSZtP63?=
 =?us-ascii?Q?xX9zdB8NyKF9slbsIzCPXX+pusnP7vjt458loTc10yrnhiyEyK86rWLD29Ow?=
 =?us-ascii?Q?6NqbvyHA+J8PKmmZ8NJd6/+Znbxpijp2w/r2aJZcupBzGEENx6DizbM+8t7L?=
 =?us-ascii?Q?tBw5XR7XLHafpY4BkBHO9Rgf7Vc1C0iViDpu2h4YKgyvPNJAnHzzwNOKkslJ?=
 =?us-ascii?Q?ie4Fo/x5HG+GhxgopVFNpPf179aFp6nQOQuaycUHcTJMvpcjGAHA7JAT5r+a?=
 =?us-ascii?Q?6FNKP5GJSJy1JJe20V0H9WQAJPyUKc4VOfA8bCYlyL7mueL9d1C3ZUA3K6Pb?=
 =?us-ascii?Q?Vr1OGhu8scWFOe0/2vokhRaszjeUnz42bwrcGiQFP0dlSPAudth4vAn6cn9a?=
 =?us-ascii?Q?HSQbslDTqXI93jTEA00V9uysU7EGfpJUAPOlOsgWThHOeztxmqrJBTf+GitX?=
 =?us-ascii?Q?SMnT15+P6WfQr5q1weJeWIFIfS4HrlJO9bohiw+xGtLFA72MaafZUKjURu1z?=
 =?us-ascii?Q?BQoopt6fNiD4f/Yr5Vk3CHZf2xMjDNRXPlbfLf59N6j9NtVlABYKFy0/ry1U?=
 =?us-ascii?Q?9h+HHRRb+4+KkH8ffyfJPevsxnE1WSD7PrCAKvcxTdcFrwoG7rjC1Kpn3Txu?=
 =?us-ascii?Q?wADbMxJOIeKxSJtOrMJKF6yNKh3N8hX7TxY1hFX8Mm/pnslE0FQsMpQ1cunM?=
 =?us-ascii?Q?6GUw7ZktoYrGsSFd6U2tdygK5Ep/+uCnTpkL6Pb0DBRyFIMhQ8+NlZxIAUsS?=
 =?us-ascii?Q?Egw0lx4uZxPKc+O283PzyOJDj6HkkuGXyHRAs8mL1AlgIakHkvEfkr+uVw5c?=
 =?us-ascii?Q?3/55NerB+GVPt+IUXi8aldoB+hcQ68IwKUu0+ceOMv21Zp0ScPF0PnZYPAlj?=
 =?us-ascii?Q?/1XrNyfuGtcVnjlXgu2u3SgVaNPZpomaS2XLMylJV4BZPK7+sm4YAqzdCVSA?=
 =?us-ascii?Q?IBLNjhzGYzcZ95C1qC16So4YBvvyeMXnQlrCKYs15r1Xs0Zjv9F5Lin+bxG3?=
 =?us-ascii?Q?pva6f2XOVa6i9NuAIilAvcGsZiyplo6+O76vRLm8A08jGhrQGCYL0+TcbJWA?=
 =?us-ascii?Q?TXn/JmbyCYe3eLFLppimd9Uyk0OoxhydRsbBjVoBFUppJMKFJlHPWJ11ECEw?=
 =?us-ascii?Q?YxgQfx84laZ43xtMINLz9pnZkDCrkrA7IfDYmNYqdjdPD306Co/GRQEK1Wrq?=
 =?us-ascii?Q?QzZfh3tWCixNy0DsoYamcPVbhdnns9PzCDJ38067Aylbez1vQ0gbtGr1DKdu?=
 =?us-ascii?Q?rfj4CkUAY4nHJQWvL7LIcyy7vHzFfs5bxN6Hgs1m2PiHzZlu8ewLRNl7MVDb?=
 =?us-ascii?Q?I8YMxJtwG221d/77GEeAPHkdf6xqZzySd6y2mnidT7U1cn0oDIXG6Brig8+y?=
 =?us-ascii?Q?F635YudlrUCwkCOtKfvk+udE7DsiCD6jMDvJiIVogDkIQsZt6Td/KP3JQwtn?=
 =?us-ascii?Q?brFnnbgt5phEnK50ZBqwsaMbHs0GxTKJwqVUXTgBzegVi6nBHj1vG+b66Jdq?=
 =?us-ascii?Q?9awKiuaZjCtK9kakA9/D3HweHEdS7yTGFnco?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 08:43:38.9827 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e52dd20a-5a17-44a7-bf9b-08dd8c7a1914
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8766
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

It requires unlocking the reserved gem BO before returning from
attaching the eviction fence error.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index f03fc3cf4d50..2c68118fe9fd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -298,6 +298,7 @@ static int amdgpu_gem_object_open(struct drm_gem_object *obj,
 	r = amdgpu_eviction_fence_attach(&fpriv->evf_mgr, abo);
 	if (r) {
 		DRM_DEBUG_DRIVER("Failed to attach eviction fence to BO\n");
+		amdgpu_bo_unreserve(abo);
 		return r;
 	}
 
-- 
2.34.1

