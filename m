Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BD8FCD5BB5
	for <amd-gfx@archiver.kernel.org>; Fri, 22 May 2026 00:21:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08D3E10E56A;
	Fri, 22 May 2026 00:21:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wbho+M8Z";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012062.outbound.protection.outlook.com [52.101.48.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3203410E55F
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 May 2026 00:21:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ljs39UhWC8cLdRBJg9R6phmzpIEnGD0aeOZCuj0iC99/w1MoC/CP0wqi0OLHjjSRololmcWvO/Nss5AGms7oz+ylAmec0V8bPvp6utKSvFTIW18iiuobglG9agGMgSpl3utK4fDKv4MwtLsGTPgdU5Ul2oYIn5KGPhP1ofF9x4ULYnQGd3koEmdSgjzTyXyYWucHwIV2slYvhG9Yghfcy4VvIJhgvQCQ2qg/pBcY9jI13quLwIPHkIYSGmDSnHI9uVR1Fmg5boXPTZa+5DDGfapEYsZHVrQyeNms0tjdjGM1Y9CFh5TD8c5DVHFUmE9qaikLX5SKZkpNu2wrNMpGAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mS4sivLn5WL5eoBl4lGRcEvWHVajgel7SH3pQn7Dbck=;
 b=mpMfBQYgTpHuYTSb5qfc/3PHG1UxPcI0C+b4R+pVyvTVJZsQ12jsBRS3ir8tbtxW3eRUDg1VuVr2xFLQYX7gtCktkmODt7xuWig4MDTfERQ1hR/B5JCVASOuJFbWZw9xzYNV81g8jQttase1jE+x6P8ykb0Rz8R9MtwnoDnoGydjuRyPf7NJwr0j7vRI0RQIZ/o1RZz9cltwIEpmWgBOTUPW3wBA72syjerAnGJoX+6nqlAdocA/TS7fPpMRs/bsjMgCVxe2cUVkc9Op2O3S/4p2aygYzrSOdWOQ8NWtu/BIAGr22F2EOraMUJ/T4nsPLKXP5jCjOYbfq2Xg8D1LDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mS4sivLn5WL5eoBl4lGRcEvWHVajgel7SH3pQn7Dbck=;
 b=wbho+M8ZDrEFuZ+9Dub/koRMoVFQV0qk0vSZzcj1nS/UZWu7kPbTQXG9XjrZGkbOi+uZgWtGuhPDO3az4ZxWyLnhfEG96rsqOAIL3Px2TTbXE5UAABD9YW+/YmTVwOZjmTbl/yIA6yrQJcbnM3+ASYd0vjnIwF7/2T2UtXbKDv4=
Received: from DM6PR17CA0028.namprd17.prod.outlook.com (2603:10b6:5:1b3::41)
 by DS0PR12MB7607.namprd12.prod.outlook.com (2603:10b6:8:13f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Fri, 22 May
 2026 00:21:24 +0000
Received: from DM2PEPF00003FC3.namprd04.prod.outlook.com
 (2603:10b6:5:1b3:cafe::9d) by DM6PR17CA0028.outlook.office365.com
 (2603:10b6:5:1b3::41) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.16 via Frontend Transport; Fri, 22
 May 2026 00:21:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DM2PEPF00003FC3.mail.protection.outlook.com (10.167.23.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Fri, 22 May 2026 00:21:24 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 21 May
 2026 19:21:12 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Thu, 21 May 2026 19:21:12 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>,
 <sunil.khatri@amd.com>, <Amber.Lin@amd.com>, <Jesse.Zhang@amd.com>,
 <Shaoyun.Liu@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 05/42] drm/amdgpu: amdgpu_ring_set_fence_errors_and_reemit()
 handle NULL fence
Date: Thu, 21 May 2026 20:20:11 -0400
Message-ID: <20260522002048.98506-6-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260522002048.98506-1-alexander.deucher@amd.com>
References: <20260522002048.98506-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC3:EE_|DS0PR12MB7607:EE_
X-MS-Office365-Filtering-Correlation-Id: 48dedfbe-3f73-4fc4-4f18-08deb7980ed1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|11063799006|6133799003|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: j3vSYg7kyFicalNpFQWmrNjownKvA6miib6Bsr7yW76V1wSgEzVyqXlqpSM4ZZMyZE8B7bvrhIjD1K0qE/zuMiuofCQiv7clTb5cqcez/tostYhYk7MDS+bFWTngbCLP6SYUskR0KJbq9qe8YCGi7OTEgHmPvPRv/uOjqbZm4LbE4z69Tub8MEqi+e1JTz24dcLEA5Wc69z8G0CegxnQXXXK2REm7dQ31uiHnad4s2GYtUoSIT2NJgagL1ZEBI77/Zmt7ihYJIofEhnmgk85ijtvnT+QJxZm0r0mr6mGpsq2zMkGUVPs+2RtgzuShuatuC/85PZHCk/PNeqgKl3CN1U2Z4hk2StQmk8eCjLftOUm0QnrM2g2hdvF49voi7tR0OGW/AHZwUISInKj3au/UNVeNW2ST3W2d0Ff54aUh0dGmJWLzvyLUbPJSACeBc0N13NARor4DnpwitFgdF3Uxr0Bhvk9GusKcpbQngLHlFVLHphmKggqENb9pJMLFPPe5DeoNVeYOTv27LCNOg8pyY+dxHDiDC6hS4dsI+RKm4csCjogz3kmjAAsHEvfFYuXwgWfuQJuiamuMjaxGFGI2gZ3526+dNpgEpRaci2g6c8OsbRyJV6jhnrEhxUWPRJAvbLWgz+TJJCIVN3gVEbhiNC+qhEAvhQx8yNu+s0gugTzPvYCHiJcHWCl4B7hMIOwt1i5QJ42tP/rsCERBo/t6hsPpXw5HkDzFoE0UMmBmOM=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(11063799006)(6133799003)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: fZwd2ydr+zjqrilYKnocTaED/KS+NbXJUJcos1S+HTRq1IDVKiAEIjYvzYChNExRIlc6dj6eBxnLQDJZpzMT9pINiptu0TPbtiMzy/jiQxh6FN47+mOKhGmWTD82A43kQ87BxbjCka/G5PLcZI+jFtdOHFqvudFhCVscoyFX0TKJ7lI8NYyYDHwMVTGfKHnNf2mJOockAaNX+qHzBAGTuGDD5EFLY7k2k5ItF9HMzjvjm7+YoJMUHV+UqLAZcHbKi5OFPrxdbd5NuFEg8rU7X38R2L5r6aFP+6I18G+xKeWyg6jsATdIUgfUmBaKBJbJcrOrX89wVC52A2u/u5Fk3E1MHquViyC4NBUg9Vug8u4X5hF7PuaSrxIAhGY8+WJ0oro8W+yd9OZLUuXsxBd+l+vdmwBiGsMpfjBgcFprEFYhs/mwKdpDdTAnruvsGwwf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2026 00:21:24.3960 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48dedfbe-3f73-4fc4-4f18-08deb7980ed1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM2PEPF00003FC3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7607
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

All the guilty fence parameter to be NULL.  Will be needed for
future functionality.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index 733e9b668ed8f..8569c1c637a2b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -750,7 +750,8 @@ void amdgpu_ring_set_fence_errors_and_reemit(struct amdgpu_ring *ring,
 		if (unprocessed && !dma_fence_is_signaled_locked(unprocessed)) {
 			fence = container_of(unprocessed, struct amdgpu_fence, base);
 			is_guilty_fence = fence == guilty_fence;
-			is_guilty_context = fence->context == guilty_fence->context;
+			is_guilty_context = guilty_fence ?
+				(fence->context == guilty_fence->context) : false;
 
 			/* mark all fences from the guilty context with an error */
 			if (is_guilty_fence)
-- 
2.54.0

