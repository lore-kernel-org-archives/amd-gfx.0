Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 282D8C61CE2
	for <amd-gfx@archiver.kernel.org>; Sat, 21 Feb 2026 05:19:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87DC010E021;
	Sat, 21 Feb 2026 05:19:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zwQ+JnKP";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013065.outbound.protection.outlook.com
 [40.107.201.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 540C210E021
 for <amd-gfx@lists.freedesktop.org>; Sat, 21 Feb 2026 05:19:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x+ghfoIbq83DS0YfP9VFlxJQ/hczWMIvvDQUPJiZE6wE8dg++XIZQVvPmMBfhyAO316j51dmSuTlF5cu52o5t33AqG+L8hgNGVr/faJxhP1FrpHSXv5zoDmRs9edfPIT6rsr73oJywgKzwY9TMNWveIcwJXzJuJBVm2xFDxNo9kPaxktcJobnAFA120FBpJJnOjQ2VZ5L+/gF5hMcHnYJAl3r6z5gXnm1FDUNaCbIahY6HSJda1A8WJ0nJuw2qxwITpWfxiGF6SOw+Cp2JoRaPsAWmL3S+fx6eVFhaf7b4Vg3wYQxpETKlG/JBlkpOxglPsdr4Hh6pynHvYt65eidQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=37so/w2cv940CU8PyJX97cqBEv3JbhP2c0DSJK0Ah2E=;
 b=vjPqwuzzeKDvuTEYnzG250iUjlmeN/7TPXzUZdX4BXGFBR5VJ+Z0O44GtQP/yFotSjtTngcFSgSubbKp26bftPUo23/XHjmFmzEazzTiffFzXAIfvg85XeeYxLD+bEzOITypNKV3znlDwBMPYGh5ol50aVjZU645ybQtxd4eOsGYEF/l2LHG7JnVeYo/1HzlamfVd5Xun4xA0cIddIs2+6TLagFVKWKO7dhw8eoyI5zQ/WeC5Y7VdBaKeXxcjeT+Cl0uAujliLNTz1Nlw6j2ABcfwCrJ3AyQOwP0KKPVrK7mnnehFUAnyq5QbdGowGf5wqU45b2lzGq8o855MxfYkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=37so/w2cv940CU8PyJX97cqBEv3JbhP2c0DSJK0Ah2E=;
 b=zwQ+JnKPZXtLrgDddeACWdi5V+jXV0w2+PStJcf6tCMzP4ZxV5dxIQRWhGd7vx1eODMhRSRlC784w9+fljS6wT4ZFC7ONY/rpirqJ//0JZMRQfio40kaWgSKnsAL3puv/7YSG4cbp2r/fYV+I64goQCIoTwGza0/Gb4JFumYlfw=
Received: from SJ0PR13CA0235.namprd13.prod.outlook.com (2603:10b6:a03:2c1::30)
 by CY3PR12MB9553.namprd12.prod.outlook.com (2603:10b6:930:109::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.17; Sat, 21 Feb
 2026 05:19:49 +0000
Received: from SJ5PEPF000001D6.namprd05.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::e) by SJ0PR13CA0235.outlook.office365.com
 (2603:10b6:a03:2c1::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.16 via Frontend Transport; Sat,
 21 Feb 2026 05:19:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001D6.mail.protection.outlook.com (10.167.242.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Sat, 21 Feb 2026 05:19:49 +0000
Received: from suresh-X570-AORUS-ELITE-WIFI.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 20 Feb 2026 23:19:47 -0600
From: sguttula <suresh.guttula@amd.com>
To: <Alexander.Deucher@amd.com>, <amd-gfx@lists.freedesktop.org>
CC: sguttula <suresh.guttula@amd.com>
Subject: [PATCH] drm/amdgpu: Enable DPG support for VCN5
Date: Sat, 21 Feb 2026 10:49:29 +0530
Message-ID: <20260221051929.2176524-1-suresh.guttula@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D6:EE_|CY3PR12MB9553:EE_
X-MS-Office365-Filtering-Correlation-Id: bcec18e2-bfec-49d6-eedd-08de7108d5db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013|43062017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Adidx1IJWcVIrddKdUbUzFhh1gknCf3X2DXwOhkKOiyWyKf4cCGKWTFqZjkX?=
 =?us-ascii?Q?COMvWP7oc9t+zgJ86AZc9ZIF4+AjuXEFt6zpBsRGl7u0axpPCa6+SPNs8+/6?=
 =?us-ascii?Q?vjLYrtM72AaGBa1G8+kHFFEdPcq32aace9T38BXVpKMvmVLCPCKerR25tcXc?=
 =?us-ascii?Q?z6c6bh4rWtwfXHzGCR7eL7zI68kpREWmJwa5gVlpp4VijFzT8j8CaY9Jp22A?=
 =?us-ascii?Q?k+HHO5eVtyg0rniTWgSE7u35V5A9B7ezsXCB1aAoVHuGQdjmfKU/lKE7Jb1O?=
 =?us-ascii?Q?YUCQYS1La/DVci36pE71zb3/Um0AOkTXKX11z9m9YTzO5+JF5GIjz00Y1uYk?=
 =?us-ascii?Q?nYW8jCIV+pJrp5H9BeYyskD6IRJDuRUHP3yey2qpcsvrVYbmyPv0p91/Jwp+?=
 =?us-ascii?Q?T235ptBl+gk+tjMO3GJXMtnRliGFCoFLcr+A7or73zAqItLGnKYL857DOb4F?=
 =?us-ascii?Q?rqln4r6fGOKB3rt/jTP4gsfDCXcoU7LhQBAWKUs1TK91znDfQiBhLVYJvNkm?=
 =?us-ascii?Q?uP/+12+4tD0qThOd6CE+d4EHMLOW/n1Su8ozJ/bZppz4h6PcLf2/O8QX1sZb?=
 =?us-ascii?Q?ylUvdyP6zirfwobq2IfDAUxioUZJoUB/ehXU2Cy8wYNSZhTXr3FgR9klSlUn?=
 =?us-ascii?Q?2AgFogM5ivNtQss47746Y57iDqcKuUNuMIAhUuauIDXkZAStO3MCgiKu/NWz?=
 =?us-ascii?Q?dmWUpahlk6aC+qpcnQKOiWKq3IQx5Yolg3oqxWGR6/NyQ3OfdPqVRcMMnFuq?=
 =?us-ascii?Q?RT1AZhAS0nsm5MB/RBANqf70YpmtHJq9kgsCrHwOTgRknxg38sPVRhMnQmox?=
 =?us-ascii?Q?p8OwaZEaZ0+r6eCyaJQnIPSgF+ocP5DgBvHN7g+su7n6DHJFGijmKW+uPX9F?=
 =?us-ascii?Q?EcZPNdPlz4zJIB1ef4cieL98RVJqDUjFsDxeXo231Bl1lhwW5PiiHIA/2P26?=
 =?us-ascii?Q?XdS7bP0eVbN1prLVfpdYRcm4OyQ2WUWW1tvUBN8gL4M0xaRC16GUWpPumW2A?=
 =?us-ascii?Q?j9Ay9YN//h72m9RUR6fHEEavkzDMczZg4wL/BBVoC/7ZQw5GRzhm9MKwPiZ1?=
 =?us-ascii?Q?a0CBC6gk5FjJvm29hdFeY1i8pvbwUVhIIIoZueHVC0e7ja+9A8qEOHtUGPZS?=
 =?us-ascii?Q?H2kQ6U83VdZ1O8exmrvaNv0QbUJCcLuvgUQtreN3hTo+dpUl8rw0qjjd/Cga?=
 =?us-ascii?Q?v4XyR6OwWNNDJFrgZL4pO4A1houm7/GUF+YOtiPVOlN2tHIrb+ifCzGNWYSN?=
 =?us-ascii?Q?UJnRttYWmo9tLRppEhWPUFI5XP7g2gGGqM2ZIu9Hak3eAoEtr6NGpe6CGVz+?=
 =?us-ascii?Q?sbqUw20YvKOS7zNcwcF8BD/CMknNhN+P8xqtsKU8FH6P6f8x/2EcWzPXnxbR?=
 =?us-ascii?Q?LxRCHvAmiUYvz3wieL6MWssPAH0LpdesIv4kZKrjiu1Md/HjRxipZrgw3Z3Y?=
 =?us-ascii?Q?QsUtKIB7Khg1c2kly3NLqUZ3VV5tTBW6rR9Q2XBmr2SQmSTH/BfRacYYoOrh?=
 =?us-ascii?Q?PeuaY0EaGIwA0AP0iw0TlA606IGhYxxAfBCrgBfdCua53Rn0Ln0ggNtuQ65V?=
 =?us-ascii?Q?tULCgUhTS2eEdtZx6xDM6DiMcta8lry8sy9/gjpPpi/X/xzskgQ2Ulyv1xBm?=
 =?us-ascii?Q?lLv4DfwZ2CHsBrjWk3088yQL9t9qNeEKylqJbqtDfdDJyuJjXEEyXidzu+3L?=
 =?us-ascii?Q?3QB4AyS7ed69qVWckWqUqiIGpbw=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013)(43062017);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 5RPJVrkxMXBFVKxS7xk1xqGZFdsp57ODP+ZIgZ3wgMwQSbcVl7wHk0nxdB5ldXrx8JpMRG3lbrWOvxWXd4yxlBQu02JT//boKqI1JeaLHn6/8cUOXpdjFjObOHNkhqu8ws7zsrcO+8f+no38vIYa+987WKNe62pjN79Q0uQ0UNFV1WJgulJcToX0joxOiHWzfnIducNJLU2SRKTwTq8D8e4+iMcYfdATBQMNTY8zjyqkMIa91fJ7zvmv5q0hEv+qfTyPRTv7FM8vlTbY948VreKmQVGBYCRrkbXD56edqNgC/P1TFGfwlm/Eg3Dry0Bk6EAlvvZc7JTriox3m/d+uM8wjZ/o7T7Z0eJENKQItRTc8/Lm7gikiCZlOrnp7wExN7yS+m1IHGOq3IDkhYj+K8pXNEfA53FQaHucoKA0b4mS37ttNT41gYrTs81ynK0A
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2026 05:19:49.3479 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bcec18e2-bfec-49d6-eedd-08de7108d5db
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9553
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

This will set DPG flags for enabling power gating on GFX11_5_4

Signed-off-by: sguttula <suresh.guttula@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/soc21.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/soc21.c b/drivers/gpu/drm/amd/amdgpu/soc21.c
index 8122a5cacf07..a0ad1f8a76f0 100644
--- a/drivers/gpu/drm/amd/amdgpu/soc21.c
+++ b/drivers/gpu/drm/amd/amdgpu/soc21.c
@@ -858,7 +858,9 @@ static int soc21_common_early_init(struct amdgpu_ip_block *ip_block)
 			AMD_CG_SUPPORT_IH_CG |
 			AMD_CG_SUPPORT_BIF_MGCG |
 			AMD_CG_SUPPORT_BIF_LS;
-		adev->pg_flags = AMD_PG_SUPPORT_VCN |
+		adev->pg_flags = AMD_PG_SUPPORT_VCN_DPG |
+			AMD_PG_SUPPORT_VCN |
+			AMD_PG_SUPPORT_JPEG_DPG |
 			AMD_PG_SUPPORT_JPEG |
 			AMD_PG_SUPPORT_GFX_PG;
 		adev->external_rev_id = adev->rev_id + 0x1;
-- 
2.43.0

