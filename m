Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D740C61CE7
	for <amd-gfx@archiver.kernel.org>; Thu,  5 Jun 2025 01:46:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF4E510E9D4;
	Thu,  5 Jun 2025 01:46:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VKgtevqx";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2062.outbound.protection.outlook.com [40.107.236.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 458C510E9C3
 for <amd-gfx@lists.freedesktop.org>; Thu,  5 Jun 2025 01:46:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GlzFG8SoLoEpoLWFJ5P8WCyCsXLNlI3VNmdnwxNX/0TaBa+hCQ24XBI0+iae5qejXYhXQPehuGILOirRYjxbvYwWxBgUla8/bZ5XCe1ZnFoF/MVLQ1qeVC5yoMDu4lmncOXXuWY8xDDdRwzw65IxQJx50CWZLKIIcWdukmz0/118zwNXtzmjhEyc/bjczA3iWStRH0P8VOI1Cj6W33kA0RyKa7qsQ64Cd9qaloZOZzuBTjXfNqg36pQKkkiDsrmGWamjA2iteRp4Vb1mjnWXuQowQWs2pGq56ZfEaTCCAcMFJFIdc6EiAeHKQs12ezU4KO19/SI7AMnqWzSnpYyipQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kX+cMqSjvyVkH1larurs5v2ktSlAmFaVaGmCJLagtpA=;
 b=Nj+XnUGwzk5kOzpo/E2JG/wFleaElByL2qorNUjDw95E5gLSTo3LFYFHI/RK4S3DiZWGQkEnnOlTVfA98lrXU8UfeOsySLFdyrI6oQs4WGue/igeCeEO4sWYFk56dxU4YN1n3OyAJwp1pL3c2cjcvP+lRGSHYIadW8/r7S9tgYJ2HDoHAVUUU4zDqH0VQW45kywwqSI2aaE2HF5dksMk8MycyqFRv72GZF7TIQmomRRwWbmoAOmr5cHE9LgWiY97c1HfvCHXdyGpldJ8P/gaWwIAFjPLNVyzARMB9cq63lRlo9dY5rcGbmqSGfq49DQwMOcfxAOTL9gR/K0Ais0WFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kX+cMqSjvyVkH1larurs5v2ktSlAmFaVaGmCJLagtpA=;
 b=VKgtevqxfI4hi5sG2eca/z4BdQ+rshiyf/zf0ZkyrY4RJgcpSu/yuFrOvV/ur1YkkioW/qbUxuR8Q3JY0Cn9VFamuI6uEYJLOUYi5brziYFoi7FC0x50EWC2isabPD5OtZCz07ZP4gHGScFZON3HZI1B/+HMW8JZW2a4wj3zUok=
Received: from SJ0PR03CA0137.namprd03.prod.outlook.com (2603:10b6:a03:33c::22)
 by DS0PR12MB8785.namprd12.prod.outlook.com (2603:10b6:8:14c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.35; Thu, 5 Jun
 2025 01:46:35 +0000
Received: from SA2PEPF000015C6.namprd03.prod.outlook.com
 (2603:10b6:a03:33c:cafe::ca) by SJ0PR03CA0137.outlook.office365.com
 (2603:10b6:a03:33c::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.24 via Frontend Transport; Thu,
 5 Jun 2025 01:46:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8792.29 via Frontend Transport; Thu, 5 Jun 2025 01:46:34 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 4 Jun
 2025 20:46:30 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 24/31] drm/amdgpu/jpeg4.0.3: re-emit unprocessed state on ring
 reset
Date: Wed, 4 Jun 2025 21:45:54 -0400
Message-ID: <20250605014602.5915-25-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250605014602.5915-1-alexander.deucher@amd.com>
References: <20250605014602.5915-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C6:EE_|DS0PR12MB8785:EE_
X-MS-Office365-Filtering-Correlation-Id: 42247cad-f0b7-435d-bd0c-08dda3d2cdd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LlTZZcZ4d/LlH/K9PZLQ+oYDQotve2GqUOp6EH1uSmwByyFpCzAplqH2xDTI?=
 =?us-ascii?Q?qbrIXFjzAS3/PdhGMMRsmdu5gA5Tkiev3zBg5ptBnLM1nWUFzLdP/6geoLMs?=
 =?us-ascii?Q?b309VDAuuXRwaoUkHO3qWpFrclveoHBGiAJB/9E+aLFCTPP1XWlfa/tSfs9f?=
 =?us-ascii?Q?VPUMguAvNdfp9VUr03eWHyC7r1zz3B1AzwZ8syW2YqKZdRClAquy4FSwaUfs?=
 =?us-ascii?Q?EZjd484qjyOHLnR4qb4UJzgOAQryoE7TZztgUrvtyWAggPuF5S14IlEG+22G?=
 =?us-ascii?Q?DVERGg8SvMpc7o3B3qLv1hviApwo2EnMiBfUqzE4nNwp7aTkfT7sNz47pga+?=
 =?us-ascii?Q?G4Wivt7Jun9r6z0mBXVk/pPeZyltEnr1YpjrD3Bgizcgu3hd/2ffOlggT9dT?=
 =?us-ascii?Q?S+VF5NaDeX8KmWaKRWIM5BLy0oOu/CMyVcPox/B07zlQL9+UKJzIGbhnf6pK?=
 =?us-ascii?Q?YGUtCmi2Gd2nX1/kR0avW2jkb1H1x5NxoUgkTZ0pMi8LTAlSAw2+lv4IHgpk?=
 =?us-ascii?Q?af1ii22jwOYQf2F8FMbDJZ93hhFQlT3IyvpVrOOqoT19JDEkM9s8sKA7h58y?=
 =?us-ascii?Q?o6tPrtxPg1mQsL7eSf443BypnFVwuWnX/mgk0V5xkPczRMWDldxQ+EQ9D/TX?=
 =?us-ascii?Q?mIdrswM/0fm4IMG5w2LnL6gKzf0dIZxdf5j/Wlzr0mThIACSL+iqKD2cJxuZ?=
 =?us-ascii?Q?ksoUXiY0iprkkE6UBdNZSpaenHBcr+z5mTe/t4HAswG3XOusFeu2fDTaZG5u?=
 =?us-ascii?Q?pZio5bwjfebzdRM3AaFMJFO5MAj9q0riZA8HZrs55GVrazwwHdRDXikCaNyl?=
 =?us-ascii?Q?Ad1E/dBbiXzxWL5XWjqOCDs3YpjF/krjYX11/EGOmKhpbSO2XjvD1P4R3clG?=
 =?us-ascii?Q?NPmA5Qh1jHOWFj7Es9MECqdKg3SpKBExTDxd5KhCJbdKQnQ6a12x1WEZw57s?=
 =?us-ascii?Q?SUGxH50Y0XSPp3RGSPJfR324Ln7HQoXATmUZeXo77obtHtTrnnjBZUiqjqv+?=
 =?us-ascii?Q?NC+hdZ7PvaEuD8Qp/zjYWFxOYkTjcwVHntMsEdkzsUCdkh2W8A/NPAkcRm1L?=
 =?us-ascii?Q?Coa1u8zBtK2TnVtWEW/pR5nK6/PLLKaPreWBiOZn6hOh2Z9H6ZKkv0uh4nI9?=
 =?us-ascii?Q?CkQ61g9fJ/O0JH5TQjuA4ejs+Aj7knpSR0y8/o/+PlFmkW9HaFLFE/J4xVZD?=
 =?us-ascii?Q?IhHYNixH+gBoQJuA751ttll01zN37DGyePKQit8It/s9ksXNjM3gLucw7O2T?=
 =?us-ascii?Q?PXlCfv4po0caAS7oqT1TGtmBToRCBZ/u76QygDA7rwjy9gwlODJPy6T8Cj2/?=
 =?us-ascii?Q?jpP2mQ4rpVS0dr4AETxee+L7YSRpuaUYsKeoth1Jtb7v/+AArAjIDIxy3iZo?=
 =?us-ascii?Q?O9PKNnMVlgZYveXmOgtedFs51C9yIVVbxAlZwauTQfpsFfh9VuFq3B4JdClh?=
 =?us-ascii?Q?XNfJaLmgKa0aegU4ZVznAqRto7ZvTjXmvwgY6XwGRgC6agkoylMqx+WtcHYt?=
 =?us-ascii?Q?yKX/WqcC5yW9HU4zwIXxwXiGykrQ1pUE+FPY?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2025 01:46:34.7284 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42247cad-f0b7-435d-bd0c-08dda3d2cdd1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8785
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
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
index ef5075e111300..986fcfb2ca726 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0_3.c
@@ -1150,8 +1150,8 @@ static int jpeg_v4_0_3_ring_reset(struct amdgpu_ring *ring, unsigned int vmid)
 
 	jpeg_v4_0_3_core_stall_reset(ring);
 	jpeg_v4_0_3_start_jrbc(ring);
-	amdgpu_fence_driver_force_completion(ring);
-	return amdgpu_ring_test_helper(ring);
+
+	return amdgpu_ring_reemit_unprocessed_jobs(ring);
 }
 
 static const struct amd_ip_funcs jpeg_v4_0_3_ip_funcs = {
-- 
2.49.0

