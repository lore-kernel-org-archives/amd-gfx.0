Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2245ED374B0
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Dec 2025 21:49:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AFE5710EBBF;
	Fri,  5 Dec 2025 21:49:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5aC7yFNz";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011033.outbound.protection.outlook.com [52.101.52.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7B7E10EBC2
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Dec 2025 21:49:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hc8KSXKuXlRSpLThh2yzI4+3HoSo3F1w/O7IFjjofdjIJGGIjW3cn57KiAgoJjbeyHk8J2VJaNdFUrwAF8z2q7g9bg+u9v0Sm7nc6JzuERcuFsWEe8rlIHpGgu//PWu/5A86O3pZrjexerQP0sjzm6XbNs3Fa/rc7P9sFFjmQwlLXvNb9nXsqyAlXmvz8hzL5V9zhWnEEr75Egrfh9P8fjtBbeMsNx1mRcA6NPKQhoaV8tfrVirPjzrbainLqsw3yTJ3rS0aVG/I2a473t8lO0pHH9XMEtL4E7KXa6YmxwmV7KsnQ3B5boV/9aVYoJ+QIQVNHRLywAAlPs69W3QqmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S9gLHHQvLSbrpu1+p+Y07cPTAsY3wg0LVPBljR77uEk=;
 b=QMmf4lN7tHJbcEQHuS+2ekQBVMp4WDsjVAAjW7BVKZI0v3x+Z38idajPVc+uWt/EqkESx5i6jhpMjAi0GsyJ6X1CrGGrBVe0A9/DPskBeUsdk6NYQz2x1BYqF6UBbUR/TrsUfmrovV35L2dRerdTtmLShkIWS6W0KxABvZ4lXet6PrrOaje9Dr6etTRh8LrYmBwy/IuO8z7cHNj+L0tG4ytXLpbDjvHR52Vf6vE7C3fouAORxG5ES3Nd0XAGbo9Yp445IOhuI3BGGaViSVMH06PHp9M/MN8ipyXxGrRD/lXtBjZFSZZf+oOSoYhu0trK6SzHVv97d6kU3YIIUV//ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S9gLHHQvLSbrpu1+p+Y07cPTAsY3wg0LVPBljR77uEk=;
 b=5aC7yFNzORuN03zX6mpFCMkQQPQZozd52lnKUOBJUTfDJs108rlFofvS72wV+AgAl2OYdoHkTEcT7oeYiBTKni11Mp7N7rL8je9o2EM9hrJ5iCer/54xG1WmQlU7fy00wanjOswFu1gA0HCEcYRW+YEou6D8sFHxNtZDJ2Qn4kc=
Received: from DM6PR03CA0030.namprd03.prod.outlook.com (2603:10b6:5:40::43) by
 LV2PR12MB5800.namprd12.prod.outlook.com (2603:10b6:408:178::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Fri, 5 Dec
 2025 21:49:43 +0000
Received: from DS1PEPF00017090.namprd03.prod.outlook.com
 (2603:10b6:5:40:cafe::8) by DM6PR03CA0030.outlook.office365.com
 (2603:10b6:5:40::43) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.12 via Frontend Transport; Fri,
 5 Dec 2025 21:49:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00017090.mail.protection.outlook.com (10.167.17.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Fri, 5 Dec 2025 21:49:42 +0000
Received: from tr4.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 5 Dec
 2025 15:49:40 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Likun Gao <Likun.Gao@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH] drm/amdgpu: revision doorbel range for gfx v12_1
Date: Fri, 5 Dec 2025 16:49:16 -0500
Message-ID: <20251205214926.146844-3-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017090:EE_|LV2PR12MB5800:EE_
X-MS-Office365-Filtering-Correlation-Id: f9505a24-e657-4fb6-0cc7-08de344832f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YM/40v7NNik6EuqevlrA0FNKEDgHS6NAUcQ/OxPSRsEdAPu/XY057wbDyYcP?=
 =?us-ascii?Q?XiKmVKnS9dZm0AeoZ6VUW+neW8TxbxnOQ27KpvZnHHilAXHMn980P/53pUaX?=
 =?us-ascii?Q?865SJFV9i446RdxLTWqmkyTTxAvUUWfXtySCWT9J78sytUFKQ6x6P2VNJ+if?=
 =?us-ascii?Q?S3t4wpnIuF0t8f3XojcOx3M8FE+gfTmb9ocOPPivgWlHdlPI2Mc11SD1jQ0K?=
 =?us-ascii?Q?SKpl4Ov/SsHKBtOw2kv5QP2rlynMighOfaSAQUg10NlZYe1os9dMTZl/7bZR?=
 =?us-ascii?Q?ZnNuXvFFSz8xWTOHbPVzu1jxQDx7UQQ0hE69GCPotVNL8AlQ4SVxG+T/3iD2?=
 =?us-ascii?Q?RQZxT7PuoqcP5LG/7BGgtmoCu9ERKR8AfGySCv8DF+LnnJXVwe111Et/1afz?=
 =?us-ascii?Q?GSxuPxADF8yMrhhAxFumpYSkTEEPfRmD7ZsON2KkOCXT0KeHvg1pM/NQ09Ex?=
 =?us-ascii?Q?SzkreEWKq0hpvo9UQhBtUm2I3tSYk+0XsXHtDjbuPPIVRe9OyJNbcInR8iw+?=
 =?us-ascii?Q?HikL8yRtjltNct/B1lTyMJDg8e7pfAYgmFd2FvrLZRMbPCVZx0yIlI4REuM/?=
 =?us-ascii?Q?d/F3AekD/hLI8lsA/MACVCyVD3oYG9G461BaDVVCVVJT2Dmbaxe6w+8o6Atq?=
 =?us-ascii?Q?RatNL2OGOLN3r8bIl16Q8xAJj3s6nKBGPojrDSRfhBieGyJ6pL62TrAKokqh?=
 =?us-ascii?Q?3hZV6E54Y9Oijl1Rs1gEGV63MctiOuFbI4/soXkIO1bfC1T0fY0u+Ov/ESDc?=
 =?us-ascii?Q?BXj2elJ6dQLAv/tu6QZa7++dZVN3jGtZxJgskL1x90kSVfsCRTD7r3W7X2lO?=
 =?us-ascii?Q?JQ/q/702U/mWz8gorWeXgRt3Juvq33u+l3ipx5oA6VLboqtl31DAVxzO//Yp?=
 =?us-ascii?Q?/BB0ZJwPLKdDkLImtAyLuyIFZIdtzfPxY4pDfkGtYOi6YaTvePxtVLVtqgzs?=
 =?us-ascii?Q?Vx/DSon7Aus6TlbYXsLYr2UmaTTv4pmCsV0/T7TFdUgbPORV0dlWYrdR9aKB?=
 =?us-ascii?Q?bFvyhq2vQZ/S+0F7xkbUUr2D4EOcTs08/CVyn6Ns3/M7rWmRMtF3FmB1lT1H?=
 =?us-ascii?Q?os04fxylejxd/2xwoJjVdgGyP53+eBRiCpZhDy76iZyMuQNmSi3GGANHqIhl?=
 =?us-ascii?Q?qGtgmTMuswmtgfz1MiOceGmWMQp9x89VaRe0VVktls97omKX5J+cc4hABcLl?=
 =?us-ascii?Q?iL7+FGKNLSdi5vsyMP5/zsIidF3TLQprf2E5LJnQDMpj/dOmx/L+RHXqoKRB?=
 =?us-ascii?Q?mn/ueD4xe8YTeWI8I6A2o/ICjvT6zOnoI5Zri31RCNMAna5c7Xu1c/cnjcrZ?=
 =?us-ascii?Q?SJHflxQ6jYwqZWNVhGP7sD8lzl4wvq8SRYqAmtae708ZtbR/WwoE8OxlEhfl?=
 =?us-ascii?Q?aIeZKKBGZ6T6JYMxd/8uckbxEZS6ObqiFmuChRPTl+5S58Eqc0W1WVOGM/Bg?=
 =?us-ascii?Q?+4T613FcYQkSJuKCev7oQkqO5aGzZL4or59OcjfX3Dsnp8GGq/9r5he2jBg3?=
 =?us-ascii?Q?zYGJVIgCWW/lLeXCWaKKby55TnqE1+Oc997S5lu0160121a1TeQC1EtmMkIg?=
 =?us-ascii?Q?ThSCCsLBdbGOPKdg3G4=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2025 21:49:42.9420 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9505a24-e657-4fb6-0cc7-08de344832f2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017090.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5800
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

Revision doorbell range on muti-XCC mode for gfx v12_1.
Clean up doorbell range set for graphics engine.
V2: Remove doorbell range set from gfx_v12_1_xcc_kiq_init_register.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c | 22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
index 2ef0fce100676..b6932073ff721 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
@@ -1998,17 +1998,15 @@ static void gfx_v12_1_xcc_kiq_setting(struct amdgpu_ring *ring,
 static void gfx_v12_1_xcc_cp_set_doorbell_range(struct amdgpu_device *adev,
 						int xcc_id)
 {
-	/* set graphics engine doorbell range */
-	WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_RB_DOORBELL_RANGE_LOWER,
-		     (adev->doorbell_index.gfx_ring0 * 2) << 2);
-	WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_RB_DOORBELL_RANGE_UPPER,
-		     (adev->doorbell_index.gfx_userqueue_end * 2) << 2);
-
 	/* set compute engine doorbell range */
 	WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_MEC_DOORBELL_RANGE_LOWER,
-		     (adev->doorbell_index.kiq * 2) << 2);
+		     ((adev->doorbell_index.kiq +
+		       xcc_id * adev->doorbell_index.xcc_doorbell_range) *
+		      2) << 2);
 	WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_MEC_DOORBELL_RANGE_UPPER,
-		     (adev->doorbell_index.userqueue_end * 2) << 2);
+		     ((adev->doorbell_index.userqueue_end +
+		       xcc_id * adev->doorbell_index.xcc_doorbell_range) *
+		      2) << 2);
 }
 
 static int gfx_v12_1_compute_mqd_init(struct amdgpu_device *adev, void *m,
@@ -2218,14 +2216,6 @@ static int gfx_v12_1_xcc_kiq_init_register(struct amdgpu_ring *ring,
 	WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_HQD_PQ_WPTR_POLL_ADDR_HI,
 	       mqd->cp_hqd_pq_wptr_poll_addr_hi);
 
-	/* enable the doorbell if requested */
-	if (ring->use_doorbell) {
-		WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_MEC_DOORBELL_RANGE_LOWER,
-			(adev->doorbell_index.kiq * 2) << 2);
-		WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_MEC_DOORBELL_RANGE_UPPER,
-			(adev->doorbell_index.userqueue_end * 2) << 2);
-	}
-
 	WREG32_SOC15(GC, GET_INST(GC, xcc_id), regCP_HQD_PQ_DOORBELL_CONTROL,
 	       mqd->cp_hqd_pq_doorbell_control);
 
-- 
2.51.1

