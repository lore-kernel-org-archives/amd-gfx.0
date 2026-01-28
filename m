Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87401D35693
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Jan 2026 10:59:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2310C10E651;
	Wed, 28 Jan 2026 10:59:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="w5VvawXl";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011057.outbound.protection.outlook.com [40.107.208.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 183B910E650
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Jan 2026 10:59:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uBTG6/zVg86/kBJSlzmB2EsOU12auXqnZjUeNwRj8OwC2FldBbrSqbQSt+krIEmQjEZP0/e0JQyXf+027GXtlj7vvtzkqZga6TkrC9Vy/U28vY+x3sITuGadeiCZlqCiIYupplEF7Ljz+0VbTGy1ONw9zyeASv+G7Pqk4mRl+LwiJw0q32XAHLD5WlYtrq4A0Db37sKl63Yt8sTFAy5AP4wBdfzWhkUupd4LsxJ/ZIkXYbNWwYcvpc/UoZN5tBKqRnp6WPtDd2pBeUqicXhB9FvWyODRK094Ci8cEZFsMG8/KfteW5SfiQGKLMFCZFOann5Bh/DxU/38Vyhg08olLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cz5pKLw4QMBZpebUjaT3iojsG4Qp9gFrd82KneQNeY4=;
 b=qAFsiZ/bswQEOhwoJLJIS6t+EXTcJezDi5LhcEkbj0rXjWL1EGHQy4DRLPW4cyqNhx0RyviDjhGkdL6R41y0Jks61en8hJ9WF5IXYjuwczbvZ9+euo5g7oB1zvUxE/9fGeRGok6mIA/fIZl9t2r3CBGycDbDTAOXThULxkKe2e2uDz1rivMpCETxlmE5bm7M18eR/5zYiRMKZOJXChPgkAUR3SB25WM19QLkM51Fui+vibZmHUCfk0loe0/LAeVJ3DP264Axea83ddVxVFw4FzZAhYsJBQ45aWJLvHfRJMkBewDWVn++AJDP4gb92nqRWC8lfC5nqwUpSb2uIl59cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cz5pKLw4QMBZpebUjaT3iojsG4Qp9gFrd82KneQNeY4=;
 b=w5VvawXl2n8Xag/tn4+b+/Tji9myib8ALyT6vmW0w8pqXRTN7oKZJDlhfWDdIQsNjC/CVoGEqjcOuLJ5Egcg8vkf+ZUhT5k/dZqiJcCEfVqI7d3PgTYbWnxxcm+QgykSzdGMJsQzl/l/LOEnhU/XO+6BzPEl2wCQ1KFDizUw4qk=
Received: from CH5P223CA0014.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:1f3::16)
 by DS0PR12MB8479.namprd12.prod.outlook.com (2603:10b6:8:155::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Wed, 28 Jan
 2026 10:59:01 +0000
Received: from DS2PEPF0000343C.namprd02.prod.outlook.com
 (2603:10b6:610:1f3:cafe::88) by CH5P223CA0014.outlook.office365.com
 (2603:10b6:610:1f3::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.16 via Frontend Transport; Wed,
 28 Jan 2026 10:58:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS2PEPF0000343C.mail.protection.outlook.com (10.167.18.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Wed, 28 Jan 2026 10:59:00 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 28 Jan
 2026 04:58:59 -0600
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17
 via Frontend Transport; Wed, 28 Jan 2026 02:58:48 -0800
From: Jesse.Zhang <Jesse.Zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, 
 Jesse.Zhang <Jesse.Zhang@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH v4 1/6] drm/amdgpu: add mqd_update callback to AMDGPU user
 queue interface
Date: Wed, 28 Jan 2026 18:58:24 +0800
Message-ID: <20260128105847.2898288-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343C:EE_|DS0PR12MB8479:EE_
X-MS-Office365-Filtering-Correlation-Id: e7b59a2b-b588-44f3-2a0e-08de5e5c3e2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?aDq9Gtb+W6AGZNq3jn5Nq+cthyRTXRd+0XotMs+/I37DFePplUHkhbMlnj+w?=
 =?us-ascii?Q?aZzy09krNH9mtBDkcrixe3YmdRe5L2RC1X9pD2/rU80Odf091cKjUoezkr6D?=
 =?us-ascii?Q?KaSJr8nXkjkhEKzfbkVgNI/sXFzGI2E2NLZiyMMiQhAlMYx3UvjzHUH3GhmO?=
 =?us-ascii?Q?CEcY3kP2DEoc6dRpizsx4M4TFSIPa7CV2h2imPL4PbeT1W/M88SRxYx+Wcuu?=
 =?us-ascii?Q?AdJo+JY8JA40nG4g7AJ9v/pUjBtUIIPv9RSm/f8hoM7CWJvTdUhcAWHHyXa7?=
 =?us-ascii?Q?U1r2Rs38vZBuSmmRp0XkaSuU+qKgOFdF12MIBpldNDxSv5vZrtN3VTRYmung?=
 =?us-ascii?Q?xJIdRcxirdRiDuQ1yR/W9B6G+s+3UlY+Zh76b2tWh8BlPO/eG6ugwa3uISfN?=
 =?us-ascii?Q?Ncz7U4xqiFR1Gmd/aILbxkeBSDtt8e0BDzLkjKGTR3fa8WWfdgZlNnPZj2IS?=
 =?us-ascii?Q?1/p//xiJ7OuEOH/xUlF0GvJElBLwMom6vxeNQOR/YW/+0IfnKPMzSOpIqGKz?=
 =?us-ascii?Q?XbkXL7jmnZY1csAj5P6XbP3qmtB91/xgsUIsvvvR1UgUHJqjU6k59Od70rLc?=
 =?us-ascii?Q?YWWR/T1oWd5AP6z9ZEKd3Qzd2TBMk7EX++WwgXd9But7UepLw6zloJpv2Fqa?=
 =?us-ascii?Q?ndPEwjm5Xp7sUrUzotxLMZcjjnD36iydvYVc203wzZzrggCY2HdFImYy5u+R?=
 =?us-ascii?Q?cCoCvzO9qsD4mZM3vU/XOCuRid242TGuUKC4wqD6I5pZpmD8Uwn+ybHuhcM/?=
 =?us-ascii?Q?jDbT27fxzeVQ562IYUtrkobm0jtDsfNW0GIdlNTmrL126tNnobDGpAsnvA9k?=
 =?us-ascii?Q?qwT/xfpkvSi31pKmWi/XrktQ5WaHRRrTQFBfzMuMs2gXzhSJeCg26zdRTmze?=
 =?us-ascii?Q?uTJOkvYEu9TNy7FLE1pWYgC+6rcT3Sixk3G95Bg2eXa1nEGHd/0uY603dicO?=
 =?us-ascii?Q?YbPVwp20RnfRJGZt5BPFGeDRvyk1zN6OOcf9Hx+ftjeIrV2MnP5lDSWD/kMB?=
 =?us-ascii?Q?edSsotQ7J0L6yo7iu3yDPqe3TY6o1Wzx9H1YRjqKsbY0iDH7TnnRB4iIPl+z?=
 =?us-ascii?Q?hp3MjJ3RbAvcWlkFkizk2VVtrSjVzWU67KTMAggdkLFi+bHAuorztUdBWoI5?=
 =?us-ascii?Q?XQj0TgrdnQtW5GQyPH/culNZoUCZPuBm1oS+G+E9RyuUjkviz7pd6UfDUrBR?=
 =?us-ascii?Q?v2yDLuMAMK2BOGnFT0OZHRxWYY8yPtpMyHTroSMK+D+NidBs7U4JZFsSRQV2?=
 =?us-ascii?Q?eanjJ+UkPV1PQs5r7xOgeD+f2t8Z+bPlWbbzKdx8yQ7VuNTNG1NDALfkAvxy?=
 =?us-ascii?Q?4dnuXvJHr/zR9KMjEMTXeGAvMHwdOOX1QzMDNu8HlFQD6/b8cSP2JgIXrJ5o?=
 =?us-ascii?Q?vQL4FXH8oO6qDzk29AHEndZ5nZs44sQymv8WDq99kXlNcpZIKT/531oGd5Sd?=
 =?us-ascii?Q?HDZTkoHKygD5BV+WK1GJD7KBPGjHo9hP1pvIOc23kRCJICBpl28U4nvTI45g?=
 =?us-ascii?Q?M8/InQ2HaZcxUpRT6oDp8ADuyCsT1EP/5thXbTFXbveMSqsL5DkrqAl4VhhU?=
 =?us-ascii?Q?8/jnzg8zIKb+edWER7BEbTNPNJwBfPxxiSXAp89dikyoWgQ+L2c73wkMXpm0?=
 =?us-ascii?Q?ESociWx1QRgBWe9f5yvUAWiIMDRDLHJIOaGO88WeuLI8KRe0wlmDYF/fRzir?=
 =?us-ascii?Q?gI42Bw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 10:59:00.5663 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7b59a2b-b588-44f3-2a0e-08de5e5c3e2f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8479
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

Extend the AMDGPU user queue function interface to support MQD
updates by adding an mqd_update callback.

v2: add the input paramter struct drm_amdgpu_userq_in in mqd_update

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index 95ace14e458c..833468b58603 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -79,6 +79,8 @@ struct amdgpu_usermode_queue {
 struct amdgpu_userq_funcs {
 	int (*mqd_create)(struct amdgpu_usermode_queue *queue,
 			  struct drm_amdgpu_userq_in *args);
+	int (*mqd_update)(struct amdgpu_usermode_queue *queue,
+			  struct drm_amdgpu_userq_in *args);
 	void (*mqd_destroy)(struct amdgpu_usermode_queue *uq);
 	int (*unmap)(struct amdgpu_usermode_queue *queue);
 	int (*map)(struct amdgpu_usermode_queue *queue);
-- 
2.49.0

