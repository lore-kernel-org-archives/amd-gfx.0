Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DD8BD4415C
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Nov 2024 13:23:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA90510E63A;
	Tue, 19 Nov 2024 13:23:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Q/JzGCEW";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2059.outbound.protection.outlook.com [40.107.243.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C44A10E638
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Nov 2024 13:23:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QM1uilYecEl5JWsE0y+bCNIycA6JQn5B7DjhZtV7PWGjkwVeAttHquG5SCVEuuAlw6AFwE+RD/kEKdVxMnvhpLQP0RCPz09mQtSekHptVWoI88WuZPkNdfI/LI6vGxzVkM4qkqp+/yVgChE8d//jaXm0S2g5//FXTC34axjVIoK9f0fE8629ItUgS0jVk5eZTEyFX5jfXPeo0CMDbWlMPJsUdCP1lon7y6kKvfKERSqAASipq/MS8WaWHRoPoG/QBbde99HmE6MKI24YzEGloH51chbSFhgGWpIXTPfKlYsWLHwkeR2L1lFSthckH03YcyeGvwG7I9UsJkIaEy3fKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TfytzbRp7/Fl6U3JtuHcCefKSVuJrhiOdxkn1os1IqA=;
 b=OJlQwautOGO3hhsLLwYwP5WnhXjRcaRKuedF+SF2VYgmD583DEXkVXSDZfXolOilgldkC1kb2ducoVf9Tm2gHWx78Pba40ytblf66w0/hPohxnxt6Uc9bE8fF7i7qODz7OppCLizKR9oAeHuyAZhoZpJMnabP4eGniVkBmZ/KyvdS2xl65+xmtORAmyTJZLOpfFoMIQvh4qKnYM7ppzgPcprcCKCg9ke0wLzbJcjp9ZeDK8YzFO5mdnQ8YkfEV7o2MOO2ShlCcAOO4fwtakQZH1sKg4KNbfubnep0BRt79hR4nn5+Aau8K2dII+q0Cookzgr4pS5XejLGmXRiaQNDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TfytzbRp7/Fl6U3JtuHcCefKSVuJrhiOdxkn1os1IqA=;
 b=Q/JzGCEW/5+51lq7u0ggLL4EPr8PTbUkhaA65c0bj7P/XMPEG4Pl2CbvvRW2FrSiKVbqMBKVh4q6AAVMdbIMprSwA0IfDjcDrR4x65GQklvqaLvcnRBcFBfMfSTvp0xi3UR3NKKbahQLLsSxe12DZw8U3y/+Ro7lfgBj1ccmMmQ=
Received: from MW4PR04CA0160.namprd04.prod.outlook.com (2603:10b6:303:85::15)
 by IA0PR12MB8894.namprd12.prod.outlook.com (2603:10b6:208:483::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Tue, 19 Nov
 2024 13:23:31 +0000
Received: from SJ1PEPF000023D7.namprd21.prod.outlook.com
 (2603:10b6:303:85:cafe::a) by MW4PR04CA0160.outlook.office365.com
 (2603:10b6:303:85::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8158.24 via Frontend Transport; Tue,
 19 Nov 2024 13:23:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 SJ1PEPF000023D7.mail.protection.outlook.com (10.167.244.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8207.0 via Frontend Transport; Tue, 19 Nov 2024 13:23:30 +0000
Received: from amd-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 19 Nov 2024 07:23:28 -0600
From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: <alexander.deucher@amd.com>, Arunpravin Paneer Selvam
 <Arunpravin.PaneerSelvam@amd.com>
Subject: [PATCH 3/3] drm/amdgpu: Fix PF issue when xalloc fails
Date: Tue, 19 Nov 2024 18:51:14 +0530
Message-ID: <20241119132114.163314-3-Arunpravin.PaneerSelvam@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241119132114.163314-1-Arunpravin.PaneerSelvam@amd.com>
References: <20241119132114.163314-1-Arunpravin.PaneerSelvam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D7:EE_|IA0PR12MB8894:EE_
X-MS-Office365-Filtering-Correlation-Id: fade6eac-d7a6-4007-7d98-08dd089d5c51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?EqIVFMvqA7oF5ZIQPh2PR81zdjxcoP1BhHmlb3ivanINHYV6RWDnAdg1uFdo?=
 =?us-ascii?Q?kozjndfkvC6PPQ/sQDmK3tfBEegZUUtBe3lfK5N5EvzZ3dXcmpSTwTvOC4wC?=
 =?us-ascii?Q?xakKe5nb3rqeQhJDFK4oipTE92cpPeDLq+BVwTpXT9xqMv6+/mNce1DWk2wc?=
 =?us-ascii?Q?JnWNGnJ0dF0KeZiwDAG1+z+90LQ8kKgiUPND6xTV79unvgnw85dqdGun5LqG?=
 =?us-ascii?Q?ZU0qtYEb/O+oRaOJN8YH18DhWeYr0b9WfWj2XbWZZQj69mTDkHZibjgenJbm?=
 =?us-ascii?Q?XD0yT1G7hZKghsUto5xVUSdWyD81AowMDNNwVEeSHZI/nbi+J9AKmNCVZZRq?=
 =?us-ascii?Q?HYJzozNU9YyABPBdTwmM+f46hHWVz7J1ODYLqWvDIoqvnxY0xjW9KS7ejLRL?=
 =?us-ascii?Q?cRwTzseL25AvB9ZOyML9K9I6vwAu7HUY6iragK3A1hmZBIF5aIOkrCZsD1oD?=
 =?us-ascii?Q?SvO7NiHp/aGl73BpzNxXmPRS9WY9zMjfWjsyx/YtcxJhoFeMuv1o8Y1Yf1/i?=
 =?us-ascii?Q?PlBFri04nldcHFpWxHcGo/DoBKN9Ne4mpfHmrlO4lp5ibjtVJdEveEMuPf0Y?=
 =?us-ascii?Q?00KPUIIJJOyUy2d8cEqv8O7wn1XPEmK6sp6c5C7sUyW1aN15ammXqxQ0d2Lm?=
 =?us-ascii?Q?c3VBWi+vtz/AYHBQouKB/amVxBJ4OmaDJ03RnRYnFV6FV/Qzt4z37lcj8iMs?=
 =?us-ascii?Q?rIySnDWsUB1HSaXR9PlBB4gvtWXn1TjWYJMhp84VMe/rCQuQEvk/H7yH2qQp?=
 =?us-ascii?Q?53j/ym4BV2zf5use2srsz+Ia5wtkYuBUtAnjFn3vGfYPW0aUYD0Ym/LnFCME?=
 =?us-ascii?Q?a4lls3RW5aTd1WsmePza9CnQ86desiwQVUPuXjQ1q6/jwrmf9ERa+w6iPpc/?=
 =?us-ascii?Q?98Z0GluJCu8fvsB1uIa9veHmvb5Kg6qBJ1efJoB058iVWd21P0i7JqaUlsKz?=
 =?us-ascii?Q?7pg+U4gClUjesP6dnyqOsNi0GMj3gak5EpHj+y5iaYGRjkG4RFI/Razi+qgw?=
 =?us-ascii?Q?z3OgU+iDzgxZfyEaVHS7yzXurQ6Nn0wntebFdrjJlmfOmTX75PprxWgGESZQ?=
 =?us-ascii?Q?5KFOQ8zyNYUXBGFkEv5yNmt2MdSdgNZvbAxnmXVtdvosU5KKyQZ8esV55nhk?=
 =?us-ascii?Q?VYQtCJn+HvWk+VwXhCHaC/dl+szqASypPxyGhEux2SDxvS3lpCWQjfWsKvod?=
 =?us-ascii?Q?SENz5SChqwp0wWpeGzHbQwHFBHobxzmnqWLjrh0wdQ7l9LxfBxufUIV56KMD?=
 =?us-ascii?Q?hrooVk4oQWHdV8l1aKotoEzH5ZzBhSuFxWd57p6rXvrNzBpa2jVLMUAUTt1F?=
 =?us-ascii?Q?cpAWGZcm+lvTQHuNR7WYfTxlnHdrkZT5gjD1Xoy/O3xPZDnRcQiSg5f4sEdB?=
 =?us-ascii?Q?V9Oymbzlpe/opatL+rcAZ6VzEvhN7C+9XxBJXe6ygI8SoMfAcg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.12; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:atlvpn-bp.amd.com; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 13:23:30.6648 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fade6eac-d7a6-4007-7d98-08dd089d5c51
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.12];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D7.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8894
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

Fix the Page fault and warning issue when xalloc fails to store
the fence_drv.

Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index 76f7babd7a54..ea067b006770 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -842,12 +842,12 @@ int amdgpu_userq_wait_ioctl(struct drm_device *dev, void *data,
 			 * have any more space left and crash.
 			 */
 			if (fence_drv->fence_drv_xa_ptr) {
-				r = xa_alloc(fence_drv->fence_drv_xa_ptr, &index, fence_drv,
-					     xa_limit_32b, GFP_KERNEL);
-				if (r)
-					goto free_fences;
-
-				amdgpu_userq_fence_driver_get(fence_drv);
+				xa_lock(fence_drv->fence_drv_xa_ptr);
+				r = __xa_alloc(fence_drv->fence_drv_xa_ptr, &index, fence_drv,
+					       xa_limit_32b, GFP_KERNEL);
+				xa_unlock(fence_drv->fence_drv_xa_ptr);
+				if (!r)
+					amdgpu_userq_fence_driver_get(fence_drv);
 			}
 
 			/* Store drm syncobj's gpu va address and value */
-- 
2.25.1

