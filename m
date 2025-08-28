Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3640C8303F
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Aug 2025 09:22:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7126C10E950;
	Thu, 28 Aug 2025 09:22:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Tyq8K7aM";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2081.outbound.protection.outlook.com [40.107.237.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E075B10E950
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Aug 2025 09:22:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o3obQFdbnFFAJYsEQw4r1P0tRz4GD2cMbROE5B6l15j/NNlzqwWjCF3zQIcWRtuVqQMCSOWZBrKZrOMprsBX0xPkHElSoyxBkvNxJxb6b1Inb98/1SKJGANdSeus0wJmmjeUUL+IDsKdp8Zdjp1jgxdeGHihl7ZM+aKg/QGEE0/bIBJVVKaHFXLwLaxL99zJeC28rBUiNS1Tauu93yFORSVaIPkSmPtB31pPxpVlos7TPn3oKJ0hIX6Nwcwa3zg7lOAeAy6Ipw915XxoT8DF6edUbYJRpnhWsWN45qIhAAXYsRSl7aukAV+5nbNsLleR20u4hGMKBwDcIlEeDz479A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qDODB/dVZvCaF2BJ0EiCcrH6SUvQbwa+9imZKu1wnOw=;
 b=WpgChHKwQ86SmvKTssssBWIRMITqp/qOk0hjfr3HZxX8DJAKXwgWM16sfZIwo99OCEBjVBs60RGMZBVCDD8RpDuYoY5mRZrPaN3qqPtLSsQlGn7dDT8F0OS5zJhvLGh8g0oju+7GfTyv0yZHf0WQpDZQr6hgDBvEhPm1ex1l6DCDHwkSYNxFgrnNzs7BMaHPneMYIMqbl8HomhVvoe7/4zdguOBMktKgCU3+3Se2lhLCZorbnJgftfY8kfxomeKGb43rguXqcJ4CwGfIz9bVlwYVMD8fC49xehWcKQesd8vk+28JZM/9UCoLtVSkqFQQvTkKw8wOLpC5vIREt1lqhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qDODB/dVZvCaF2BJ0EiCcrH6SUvQbwa+9imZKu1wnOw=;
 b=Tyq8K7aMToqlQi1Fwf0HfPNntIRz2HaxDZ+EH/qDy4Yk6CW8dso+l6rzrHoSdhqjdHigARoc4QIQ2acDqZZrCNHL13cC+/ZSpzIzUIS4uYZV6YonvbY9st3+RqRBdfQkCYSrNa+PhJIzwDldifWFYF1SB1tThpqK95ypbFwN/EU=
Received: from BL0PR05CA0015.namprd05.prod.outlook.com (2603:10b6:208:91::25)
 by DS0PR12MB8456.namprd12.prod.outlook.com (2603:10b6:8:161::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Thu, 28 Aug
 2025 09:22:32 +0000
Received: from BL6PEPF00020E63.namprd04.prod.outlook.com
 (2603:10b6:208:91:cafe::54) by BL0PR05CA0015.outlook.office365.com
 (2603:10b6:208:91::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.5 via Frontend Transport; Thu,
 28 Aug 2025 09:22:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF00020E63.mail.protection.outlook.com (10.167.249.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.11 via Frontend Transport; Thu, 28 Aug 2025 09:22:32 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 28 Aug
 2025 03:45:03 -0500
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Thu, 28 Aug 2025 03:44:57 -0500
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>
Subject: [v12 01/11] drm/amdgpu: Add preempt and restore callbacks to userq
 funcs
Date: Thu, 28 Aug 2025 16:42:07 +0800
Message-ID: <20250828084457.1999535-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Jesse.Zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E63:EE_|DS0PR12MB8456:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a80446a-3617-432c-0b20-08dde6146b30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?exF/uh6DXiSD0BELNITJELFZpjrebQw4MJyjfztFYxHc95tU/5c4m+Rq85KC?=
 =?us-ascii?Q?KKdYUYk0QnV0hmOheIL1l6LYsq78s0kfrNt4XmjPZHXwAZ6vcrqDtk4UewsA?=
 =?us-ascii?Q?gx2LlfIalkzNYAHT0Ww9aINOYxukP96Jc66dBdiMySDLOhIyQ/eSlUfLoDWO?=
 =?us-ascii?Q?riNHBaF4tQfqbAoC+9fm48mUgiKFnubVXWQ2hGiW0sc9jn14VpwuJK1phRR/?=
 =?us-ascii?Q?jGJHNiEEy4uoOqpnQ4uI3kGXT6Its3tOXKCmTBn5q3/BMhiBcMyjqtwz9/hX?=
 =?us-ascii?Q?bI5NXKdt0cI+aLM7qXMz2eTQRyah/s7U9jzc5PpKPltAsXRik2Uu8wXnjQZ7?=
 =?us-ascii?Q?xZn68BGVaI8tripbRMpfrJhzX+Jy1ccEfVRMNzUiScP+wEpp+lgRr5U3rxv8?=
 =?us-ascii?Q?DhkXUCo32Vdgbr0SybpJ2oRoJiWUKUVF3bp5cd5ycvIsaNWoVn0IKyJ4Ja3d?=
 =?us-ascii?Q?5VezLV+UwzcxTQzSDZahHwJeohOc1sWJdZK+ZjDmjb11x/6zXpp6EO5P/++D?=
 =?us-ascii?Q?h081vZxYknBaBf3GYWz4lNIm0u0dWr7mDcDviFhRjmKe1Uis6ZnlFLC+qRcj?=
 =?us-ascii?Q?yhoHV/bO1YNYxaK/HAcnTjqQvUXlXqPZLiU3NR8ajRQZ+fQtZf7V1mvxJ/Q7?=
 =?us-ascii?Q?W7XngopvXrZa5MMrqgpLoiJ0MdIl7QUBVU8bc3WivM+npNyTnddOlzrsT6hH?=
 =?us-ascii?Q?RLHKdoYGbKREqtqnbIiAopCamoCYIbGH5Ljr/rKzDEf3nfNH0Iu8xXkd82zd?=
 =?us-ascii?Q?Hjh1KKyntRa6GP8UAq8OXFGI+hRfRhCQlnvVcKM6QVTCQ5ZS1oNMBOtF7k46?=
 =?us-ascii?Q?L5pNsGUjs0uy04ysTR/wmFdVxkXhokJhZwYgeA9lzsn/U/JKc4aTVBV04TlY?=
 =?us-ascii?Q?nt7gik91hNpeCqL0FHpuuwRqb+pJThRiGtfMP8D/YxLwaCjLnde82D2ah5b3?=
 =?us-ascii?Q?b6ixvYe+6WGt/MN/e+3LcWcu2J3jVeuz0qClawK7I+YURIP7xSnQfZwgqtMi?=
 =?us-ascii?Q?VfQnMqn6Q6RMd1dgA2fjClIl0AORgRoynBGQ9DMXaoZREzuedjS4XZNCVT/F?=
 =?us-ascii?Q?+60GEkg+vkz2Bfz4T8IbNSGw7d44zOQJUCTTHvchTgmLjdPwkBbChFFKOXu+?=
 =?us-ascii?Q?RfmM+Ey9drNVvWHuJFnnr4ibMXa0/YadIBlk1ucjPSBIkQYYidy3mwXSXDa8?=
 =?us-ascii?Q?Mv01YB8BqGqfxS2z/jHsHk+LInpJWcUxNHCnr/Lf2A3EKGSGtL0Gyw0H8yqF?=
 =?us-ascii?Q?Xb2MvfBn4OrF6+JhArUVoUgjZwUTQorhyTR2cC/bIzW+G375d1Uwz4227jo9?=
 =?us-ascii?Q?HceR28SdLldNugsbl3HSX5GaoPV2uCmbqf2GTL449QBU88bunzMWwvCNQj+X?=
 =?us-ascii?Q?rYFoPZ9okAJiFdX9PZuNdYvxe9qbma8U3iIU5ZN8Q/lqHtLSwf6/QiX7mpfg?=
 =?us-ascii?Q?AnPRZJv7AaTzBNld1XZw1hznHJXSqFqG7PrY6heL7CSHKUHHZBhhs1vI5gE+?=
 =?us-ascii?Q?lcZrl8H6cEJblVN6aPMC+jpVFaFZ/w6QSxPJ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 09:22:32.8088 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a80446a-3617-432c-0b20-08dde6146b30
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E63.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8456
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

From: Alex Deucher <alexander.deucher@amd.com>

Add two new function pointers to struct amdgpu_userq_funcs:
- preempt: To handle preemption of user mode queues
- restore: To restore preempted user mode queues

These callbacks will allow the driver to properly manage queue
preemption and restoration when needed, such as during context
switching or priority changes.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index ec040c2fd6c9..5111d7dce86f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -77,6 +77,10 @@ struct amdgpu_userq_funcs {
 		     struct amdgpu_usermode_queue *queue);
 	int (*map)(struct amdgpu_userq_mgr *uq_mgr,
 		   struct amdgpu_usermode_queue *queue);
+	int (*preempt)(struct amdgpu_userq_mgr *uq_mgr,
+		   struct amdgpu_usermode_queue *queue);
+	int (*restore)(struct amdgpu_userq_mgr *uq_mgr,
+		   struct amdgpu_usermode_queue *queue);
 };
 
 /* Usermode queues for gfx */
-- 
2.49.0

