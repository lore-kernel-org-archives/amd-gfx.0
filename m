Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 626F0C25B10
	for <amd-gfx@archiver.kernel.org>; Mon, 13 May 2024 08:56:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB11910E542;
	Mon, 13 May 2024 08:56:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CN2m3w4n";
	dkim-atps=neutral
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2043.outbound.protection.outlook.com [40.107.212.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20E1D10E53D
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 May 2024 08:56:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h2arLPdVW33bdxbVrqSx+tiLVIV1WFcNmDoe3IgOh/wjTouOnyzIQLXhrxcQepMgExeglHJDfKAd96v8wM4NHb+gx4B6/88l8wqYdI7ARF/j4F1oOeNvOgHYdpf0/0j9x8PYwddKUaeSfCPva0Cqm+9lihZJvq56/7wmEKM6q4VgChQQqamtPgWFVTbFNk2bhJ8FJ6uaxNcOuThTN6MbH1AJ4POwk0eVoIKxuMPG0DSVhjLr1bktLnQ8FrT//loB89Hm8mx40Pi5VvdFDSSgKiB1PWdHV+K3/L6wEbyNC3fQqqLQaKgM7kxiVj4Td23LEXWXdiLhZwlzU7fmjSm5Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zAWbD3346mIovTNc+Ef5Tjjgv2+DPlErkhv28tb2G3c=;
 b=oCALk3cBHxEvGAw8/mKhHGSjesCEjDqYOTcNkFDHJavJ23jJTtxj+Z0sX84mqNd7nOzkFCoOJJYJJxblUFnuvqQHNy5zBRW+rGhKkQ8IblyoLff+dzP2kVVjPDiZajtp4QOfyBTj24JYjSNLAxPEfkL3r9/MJlooVXsnLzYcZbZY3ord+HomVjYJYWirrdorO2yJDkWghzL+bUfUG/GufqpOobbZ5AdgnnNx662Tyu+eZuxKWQ8PP6SBBj6d9tUJWTZd2+Vn//jpypeWddKKeDJvrqHntqXV5+rdUp4vx1wtJs46ywWa4ZU9YqhZ4g6hCplsU7t4RlUan+hNfsyjDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zAWbD3346mIovTNc+Ef5Tjjgv2+DPlErkhv28tb2G3c=;
 b=CN2m3w4nFjzVDsXP0UzM/r9Gldaft/Rx3hkfrncMYFeHZ+Snd5bBtCdeh/aSpeKxTB1UmYtiLoTB6SC+ShLsti33c+XIi+KPOJexZYWfJsWeqd25P29XWPKP1xKZNcrOzDkRbOcIPpswjC15cG5YGIHpOIfwmy6A42nV37eRog0=
Received: from DS7PR06CA0012.namprd06.prod.outlook.com (2603:10b6:8:2a::22) by
 PH8PR12MB7304.namprd12.prod.outlook.com (2603:10b6:510:217::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 08:56:44 +0000
Received: from DS2PEPF00003441.namprd04.prod.outlook.com (2603:10b6:8:2a::4)
 by DS7PR06CA0012.outlook.office365.com (2603:10b6:8:2a::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.55 via Frontend Transport; Mon, 13 May 2024 08:56:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003441.mail.protection.outlook.com (10.167.17.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.21 via Frontend Transport; Mon, 13 May 2024 08:56:44 +0000
Received: from majun-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 13 May
 2024 03:56:40 -0500
From: Ma Jun <Jun.Ma2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Kenneth.Feng@amd.com>, <Alexander.Deucher@amd.com>,
 <kevinyang.wang@amd.com>, <christian.koenig@amd.com>, Ma Jun
 <Jun.Ma2@amd.com>
Subject: [PATCH 2/5] drm/amdgpu: Fix the null pointer dereference to
 ras_manager
Date: Mon, 13 May 2024 16:56:13 +0800
Message-ID: <20240513085616.584249-2-Jun.Ma2@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240513085616.584249-1-Jun.Ma2@amd.com>
References: <20240513085616.584249-1-Jun.Ma2@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003441:EE_|PH8PR12MB7304:EE_
X-MS-Office365-Filtering-Correlation-Id: c2990f18-91ba-4100-daec-08dc732a9d58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|376005|82310400017|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?eI8X7GJva+E+jrGQJOA4rGFA7GppGjylVwsKIRPxWjVZ7X8juQgb7ydvbya9?=
 =?us-ascii?Q?xZbj3O69GrnpqHyfPbEcoGfhtZjVcywsOp1iQTTSLj0Sz6XP47vXpIzL8pZ1?=
 =?us-ascii?Q?qwLCmktrwky+kYjhK4y6FL7bOX24/mn7f8TdwKaNIise3uvr0FU4unO/IEaT?=
 =?us-ascii?Q?FPXGfKKIVTTQe9xxMVGMdLPScB8iLrPrIJ0r+B1y5GKDlbtoV6U2mOp5KRF/?=
 =?us-ascii?Q?3HC8enHgQLHX4xzK9j3y3cG5SrsW9u4Vv8NoZkjMj5a/hNyNk4GYhqM+dNis?=
 =?us-ascii?Q?misF83yTSmg4wWFc9V9E0MX1LsdxipY6v8qD2JgZ45c/NpzZtldG+9sKs04w?=
 =?us-ascii?Q?AjG8gsloOymGTRkv9WCILy5nuCHYnEfyvSquqZo769kgF4c7KFLgF9Pdea6+?=
 =?us-ascii?Q?o8UINUhiRiiP08BkwyOb/aOVNUTFa82qUEYoz4DqFOqT2i/xr1MUIQUu6ncK?=
 =?us-ascii?Q?1gWbst2Lq8/LudH8ruwPAVkWqGMe5xKZBnnUeq/cHrr3zwSXNmCk4ulmLRfK?=
 =?us-ascii?Q?ZIb6kSYFuh86XQrt4O8kbwxaexstM4W2U2HCdIlBBssKpLKU3YIL0Ic+8R3D?=
 =?us-ascii?Q?40KRIUV/d8l27Qsb61iyE7/RWx1IzeMINgnJ4kVQyKgp2ZzR1IlDpcQQYJCN?=
 =?us-ascii?Q?F2vkx8h/VuOmkakTW/pZlFdDxBBaTzKonup1ntrIK4GG/C9TDv5pARyLoCPG?=
 =?us-ascii?Q?GlJvuUoYtErx2KPwk4mtpfSAtjaheordq+7o9Ka+5jDHS4FI6AC14D8fzvHf?=
 =?us-ascii?Q?umqyIxd/nTK942BAS4MVq5Y+/tpWJ1PbmYIOHDGkSaxh1AZFm69Du1aQ0z0z?=
 =?us-ascii?Q?6+dKHTM9G4t6VaR7FjEcLQxnRGlLH9lVERGuUTRFHC/ANZRpIGaa6wMpYU4j?=
 =?us-ascii?Q?POeDlPjCfm/WyDN+TVB/R1g0Fajc2XySzo3BsoeaVAawsTF6eIzGnuux0QMS?=
 =?us-ascii?Q?6DjKO9TwC2LBBmr/XnDwG2FgEQ3CoJqtPkr8+dvPoAAOMXQI4kVaTKpx2rX/?=
 =?us-ascii?Q?QstOPKm4uwcIu5FK5yldnyKzkAcmt8Wim8b/7arHVGXbY8p1nqbJtcZJDkxB?=
 =?us-ascii?Q?v3sE+IGZNV7HlM5vP8HZCJI+1cDW3SrJlibUO9pO75sXZzp4RFjWbmP9O9ZL?=
 =?us-ascii?Q?u9R/8ZcA7OLVnpMT0to8u52CesbHZr/WzYPvLcebxZIGXqOz0HjiBDNKmoNC?=
 =?us-ascii?Q?bCgoPZxQoBQjcP/oT9g5csGCooa4CiqFSi0Cs3XCsuDkUvZJXli7ZfoF87oE?=
 =?us-ascii?Q?ZZhv76Y3N7OgbJWKJ2r1Wm9mPGnuFLR1cP7eygRh9p1hytwyWqY4C4YTIa2T?=
 =?us-ascii?Q?ovWnM7PCD9YFXgBrSL4WPTNxO8xFGH6bOZiIZHoH1X5IahAzwDZDbQYYbOGW?=
 =?us-ascii?Q?KDq+6m19sMVYTaCBARjkI8b9EjbX?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(82310400017)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2024 08:56:44.1684 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2990f18-91ba-4100-daec-08dc732a9d58
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003441.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7304
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

Check ras_manager before using it

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 1dd13ed3b7b5..6da02a209890 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -2172,12 +2172,17 @@ static void amdgpu_ras_interrupt_process_handler(struct work_struct *work)
 int amdgpu_ras_interrupt_dispatch(struct amdgpu_device *adev,
 		struct ras_dispatch_if *info)
 {
-	struct ras_manager *obj = amdgpu_ras_find_obj(adev, &info->head);
-	struct ras_ih_data *data = &obj->ih_data;
+	struct ras_manager *obj;
+	struct ras_ih_data *data;
 
+	obj = amdgpu_ras_find_obj(adev, &info->head);
 	if (!obj)
 		return -EINVAL;
 
+	data = &obj->ih_data;
+	if (!data)
+		return -EINVAL;
+
 	if (data->inuse == 0)
 		return 0;
 
-- 
2.34.1

