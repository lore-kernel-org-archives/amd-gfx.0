Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 866D7D374B1
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Dec 2025 21:49:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF3C010EBC3;
	Fri,  5 Dec 2025 21:49:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OqrwW83k";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012058.outbound.protection.outlook.com [52.101.48.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4251C10EBBF
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Dec 2025 21:49:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KNcNPjd7TOXJQcNtCh5R3Nop737KMB5v3HN4bBWYsLwMGAIYpWrkwE5uLnqypmW4/68v3FFRc2Ga4pOMo1BQ4ScKO8Bks+mZE4qKhw2N8eAEwTSX/1SFhOPtYXTZx8VKdkfjYQPEICwiAg5cSLtI3n1kwnq8R/REAwThd04GXKvC6P8JbUFiA2LU5bcXSu2XO2W0XtjtriJSXlCsJKKHC3gGa/Hv5EcCpc9LxVWYwEnyZcv+CLvU0riImKZpKnU+JjdJB4mQyK86BxU8599P9pQEb+JuX3fab7UGXwxJmj62T3QePnmLjg9LUg4LQ0SKbcTP2745jZA7ValE2spHbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6o+M3Ezb0YQtZ5YeqByc8+mr+f2+UhkZGgp3MXjYCbY=;
 b=W1VRSkgP4td0+hT72qNuTHiHiIr/NTuANqkr6ZQRdchEkeQFrTguwoJ3/0hYbNA4p4OFh90aT2rSDjAPAWwNBmXf+PAKDEGcSr0vOVwEw/vrDZXYMGt/TND6sALvpx2XGzaK0MaC+W7VBCcA7ioG2Mk9iQqiaarAGjw7MaJny52Rq9ahmGm96uDTBRkKCUhTiIIGiJICtX5TNry5QSOXy3xw19z/sLZue8wfV8qs75rYqxxWhQ6jkVsR/XsiAAB4NyBDsoqSZZFbcTfPiPU9OIM4iLC3dxgLLTKlnrNsH/UdZHMpI5yF6j1YlfPlk9OAzxtxlC9g9VmKXBFeNhmJPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6o+M3Ezb0YQtZ5YeqByc8+mr+f2+UhkZGgp3MXjYCbY=;
 b=OqrwW83k+rHb4BX5rfXASftp98bhs+QOToomw5zZrBdrqyozrGuToqyepADh4kRA+VrEGyugI4foqEElZ6TvZ1BBfsmRJyNAfBdt+efuBAnlRnM8cE2TnYfLGvE/pChfufHSMH6pRvl4yOP2WKW5QkXMD9It+39HpMMdOc6mL6Y=
Received: from DM6PR03CA0032.namprd03.prod.outlook.com (2603:10b6:5:40::45) by
 DM4PR12MB8500.namprd12.prod.outlook.com (2603:10b6:8:190::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.17; Fri, 5 Dec 2025 21:49:45 +0000
Received: from DS1PEPF00017090.namprd03.prod.outlook.com
 (2603:10b6:5:40:cafe::8e) by DM6PR03CA0032.outlook.office365.com
 (2603:10b6:5:40::45) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.17 via Frontend Transport; Fri,
 5 Dec 2025 21:49:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00017090.mail.protection.outlook.com (10.167.17.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Fri, 5 Dec 2025 21:49:45 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 5 Dec
 2025 15:49:41 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Likun Gao <Likun.Gao@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: disable graphics doorbell range for gfx v12_1
Date: Fri, 5 Dec 2025 16:49:18 -0500
Message-ID: <20251205214926.146844-5-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251205214926.146844-1-alexander.deucher@amd.com>
References: <20251205214926.146844-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017090:EE_|DM4PR12MB8500:EE_
X-MS-Office365-Filtering-Correlation-Id: f11c5289-e960-4c73-bd55-08de34483447
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/3y+Jv8v2zdFphyCsZnS2GfgF+Sns2NLRLw5blr3MbKHJVkDhCAL4uzXqB2Q?=
 =?us-ascii?Q?ZNsX3Fg7Cokkc4kgnSWLaur/3MJ5LUwxfwS2PQBR3qABz1y6WXOnL6IEaEeB?=
 =?us-ascii?Q?v8dfip1CHZAYg6T/nX0EV58An+k2f2N7+Wo9mD1ovoGGZLKo2c94oOkk6Ai2?=
 =?us-ascii?Q?TbSf5wbpiOKN2YfuY499xYvMDP+DVvr4+/hVwHZD31YB0psp1ne7QTZ50lfw?=
 =?us-ascii?Q?GLJfsyxYtjyK7oGuBBDomLFq8Y+UU0sdbF/RhjxH9xQ3CVFig4Ft+okz5PI/?=
 =?us-ascii?Q?+euCQYVo2A7U9rruCercLWSax8aL9oziQtXwBEED+vtU9NzyrJg/X1KR1Rco?=
 =?us-ascii?Q?92kmPy9zwg3TWQ7gjqyd1BxlGyO/CZBsuk2FAvqevLDkzCdalfP8iNoX3LBc?=
 =?us-ascii?Q?COGhsmcB0hLS8qE72xMKgbl5aPlclnbQ/RphZuZqjuqek+iDu6YvqgqZ9QVG?=
 =?us-ascii?Q?dAepPV+GR8o1kZNk1uEWjwSKk8k1fFsfB4qvz7OgdM+TkzMaH23o3j3MkBda?=
 =?us-ascii?Q?olSK/B8bWXGKFL0HjUgfj2ocXyUDG8SrT2plYIeO125pQ+Tlb5NrJgZ5ikhj?=
 =?us-ascii?Q?w0SyIFAQvAkYFBd3jUtjrND+NepTiAwavR2YgxgcA0h2VWAKZ7jj8DUNvRlW?=
 =?us-ascii?Q?ByZ4mZFmUZzpJnsyxQs7QhOQyYctns1dstComkyxX565MouSKi1sMbVolWiH?=
 =?us-ascii?Q?bxE6a1rhSUJkE43o2HicMvBZ/KvR00JJ33zpybGEkz/x+n2NaL1iB7F15HUT?=
 =?us-ascii?Q?GkZw4xJbL0e4sF1f9NebpRV+kh8syS2D4r+/3AGLWbwSmflmi/KAOZQ+YmfB?=
 =?us-ascii?Q?vZ9zjydoyWB4uj4aJVbuSO7tvJ9kQkdLPOlR3Xj5IOUnfu4uDVkk87fJJXMn?=
 =?us-ascii?Q?QpfjE4i8zG9tPEPyGQwSTmbbWx+0UF0lOGXnxOOTbtiqxYHq9bhgM/Uy8Tgp?=
 =?us-ascii?Q?SASodE8a5JtNsQIuSB5x9J5DzQyp3Dvg0yB7fA0UEy55IAj3/GVh13QwIYdN?=
 =?us-ascii?Q?fQbdWAAY5rI9ZVscxCH6sRbpNUvo83X8NzIm6LT6Xz8on1FL77sGdrcgdO/K?=
 =?us-ascii?Q?Ze6C9jx0uJsiWZUTvUKJLuUk/ulXFW0y7WhEMegyCQOfTbo+2MxwoQW7E/Bm?=
 =?us-ascii?Q?2WvRBKU7FXVvfiIJfyScxsj15VjhV1PbzXYlZvB5KnFYIpxFianWbdB8+5FE?=
 =?us-ascii?Q?nxUyXHREkmcVgtfjZS7urMC/c3ih7W08z7LrO4GKV3LFrv0+kq8A0rnzC1yi?=
 =?us-ascii?Q?cFmHXMr/ojb5DKc1xHGoBlcQP2EcgyRtZ7SMYdrxYIWIpECEAqjC6cYjdmy2?=
 =?us-ascii?Q?dpAvF215iTVJpKNsKFLBfHvI98OoIxolaVl4wLwANXuyy1V3vIU2BfQS/iER?=
 =?us-ascii?Q?j2RFz4PYNrGj0HjmqsTXP/snOTWqp/dzwLHNxG7rf+/r2tx1G8qQsbi2QN2O?=
 =?us-ascii?Q?Y4zPuzkJ1udkTcT1XH5VZO26yrImjcMSDD+vlrV68Yg2hrgHmlM1UFdIFA/M?=
 =?us-ascii?Q?uzGEs9jGNOGP1zR9WygPdjqAvnS5Cr1ob3qfOcaAj+B0eJG05Vyje8zSiuUO?=
 =?us-ascii?Q?JkXYJJkjTnj6Va8ueB0=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 21:49:45.1800 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f11c5289-e960-4c73-bd55-08de34483447
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017090.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8500
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

From: Likun Gao <Likun.Gao@amd.com>

Disable doorbell range for graphics engine on gfx v12_1.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
index b6932073ff721..876cd9be19149 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
@@ -1998,6 +1998,10 @@ static void gfx_v12_1_xcc_kiq_setting(struct amdgpu_ring *ring,
 static void gfx_v12_1_xcc_cp_set_doorbell_range(struct amdgpu_device *adev,
 						int xcc_id)
 {
+	/* disable gfx engine doorbell range */
+	WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_RB_DOORBELL_RANGE_LOWER, 0);
+	WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_RB_DOORBELL_RANGE_UPPER, 0);
+
 	/* set compute engine doorbell range */
 	WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_MEC_DOORBELL_RANGE_LOWER,
 		     ((adev->doorbell_index.kiq +
-- 
2.51.1

