Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB71FD1D467
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Jan 2026 14:49:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A35210E76B;
	Thu,  8 Jan 2026 14:49:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eK575ivH";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012023.outbound.protection.outlook.com [52.101.48.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7F6010E772
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Jan 2026 14:49:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WTyVFAehLWBiMWTnIj/Yw4ZZM0+w9sYeiIu+8iRpYX919nPwuvQlXqOqg21rsIg5Kp3RbxOMlKFTmmBRifQ6iLbKQShYo0JluIhF08FZiRPUbxgI/MkzgscjR6z58/IWauI+zFeLPhGVkfdmJMaqJj2FvIsFnBsiaRuJgP8TCOe5z7aZ6KqmgQ7z7uqiK6W/1sKTJbbi1/HCIRnowDcPVQqAiGtgRDJn0GoPMsnGHEW3qH7eN6zmhIu+Yw7ZacSW3tI7XTSnDhkHgnunCDKoBe7myWiwSAddvH1x3n5FY38QVL5U/iMfBzvHrQ45bxLKRu+bkMGOBHpo/loexsRYig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SS4W4Eb8GesEcU2u0zt2Ldtl43L1ssQgNQwBegpPeBk=;
 b=LmhcTo5ZWT9rqXtuGPKdL3SSWCYv4Cl3QCuQOTpXzNohDonq61Whs9Pvgd7ylvOPRbMR3eqbDkNcuj0BY1VyIU9zt0SO8Xk+4Sj1xVKKKXioIv7j+REYaboA3f1okMU/C+upwEFrqoVuXoZdTjc+iFFxIViqc5Rz2oev9ZkhcR7wjJnUW/Yu/pn1ptB8Z/v1KoXGkHXhGr4hTS2+MhcqJYnBNQXK4g1UdOZus/rNdtDmPWKJRuoyjm9CZhwr7iHYxi7arzB28NampQyXYum/S/uysbQ/eKj+sWzPORDuvvxCIJCZIRDi8Lwqx8s30cvQ5oEmhbwfsGab1LcmuLvpgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SS4W4Eb8GesEcU2u0zt2Ldtl43L1ssQgNQwBegpPeBk=;
 b=eK575ivHBKmjL3eSZ8CJHsp7mljsTpAWnfV4JGyqYwq6UV33pr602JkhHWYUiNviogqgG29K/392p3YTxqeQxNsJD4eG/+EFCHq1PHN0wcXPoGVSUL4zXrz6Lxm0u214/kasHDl3OypYpkjTb9gVy5tYUvXLzFho9lLS3muI310=
Received: from BL0PR02CA0132.namprd02.prod.outlook.com (2603:10b6:208:35::37)
 by IA1PR12MB6330.namprd12.prod.outlook.com (2603:10b6:208:3e4::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.4; Thu, 8 Jan
 2026 14:49:12 +0000
Received: from MN1PEPF0000ECD7.namprd02.prod.outlook.com
 (2603:10b6:208:35:cafe::c7) by BL0PR02CA0132.outlook.office365.com
 (2603:10b6:208:35::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.3 via Frontend Transport; Thu, 8
 Jan 2026 14:49:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECD7.mail.protection.outlook.com (10.167.242.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Thu, 8 Jan 2026 14:49:12 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Thu, 8 Jan
 2026 08:49:03 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 8 Jan
 2026 08:49:02 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 8 Jan 2026 08:49:02 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 28/42] drm/amdgpu: rename
 amdgpu_fence_driver_guilty_force_completion()
Date: Thu, 8 Jan 2026 09:48:29 -0500
Message-ID: <20260108144843.493816-29-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260108144843.493816-1-alexander.deucher@amd.com>
References: <20260108144843.493816-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: alexander.deucher@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD7:EE_|IA1PR12MB6330:EE_
X-MS-Office365-Filtering-Correlation-Id: fda72152-4809-41c3-efb3-08de4ec51699
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Z8Di16Ft5lJbHpgtQBwaMZRQAFnIbx0OG57+RZjfzF3yGyQVHPTDwt7NL57o?=
 =?us-ascii?Q?GiyQIj7/670D7LEWd4TwiNeDNDlkYGZ7sD0Du1B0oTnqz24DpDvOOOt3CatH?=
 =?us-ascii?Q?zuDWGiLd8gyICI8D4McLqm252E1YYwaP2gp4tcY4yFOhUF315FHYI+sFK2Nw?=
 =?us-ascii?Q?oRhUWs/B9iviyvYcaUbMDqVdFbQ6IRdZy9JTJ3TpV42vBYLdoKwjC+b4QfGM?=
 =?us-ascii?Q?KtVe6i/cJi0oRw/Y4hqHfC0b7zCWil+m3vSHQuZNB/DVdRqz9ca7hPk+CFMK?=
 =?us-ascii?Q?8bWteu3xMibLe7uDzwLennQdi9TitQCj9ButW3/vbGTIKXy9rkl9mLL4syT2?=
 =?us-ascii?Q?lK1EEJmq6tmLr2FYHOKC5a4YppbqtaMg7ZVW3v+SRJByy3U9L7hmJ0kmUAG2?=
 =?us-ascii?Q?uEqF/mqFQpnkFugHGeiDk/wDltNMEKYOh6GEN1jFEE7YaxYPLU3Fn/ZVBqjt?=
 =?us-ascii?Q?Eo4Q+uwH8zNGyxeHxtSwIAs05tF8ZhN8eJAvvf2jQ2vwNzfg+2rwCnfzzt1s?=
 =?us-ascii?Q?LP2PDYJa4rSmscYPtBU+yi+NEGKdv7snTVCaKsH8gaIDQhXe1SmR2aVkkBUP?=
 =?us-ascii?Q?kgxc17i3pImL2zuYGit4QnM4liU2iJmMw2b2v+xCOOP02bw+Eh18QkMn12R+?=
 =?us-ascii?Q?TS76InaaxmRthsJ6JqCD3q+e9x8sSIxL9Iozoa1lQTtj36Z6EI9r3nZE6Ese?=
 =?us-ascii?Q?J57rxNLzmlNaeiGAlPC7ixyyzYpVw43d9j96/p9fAxkktpJtink2XD/47R9o?=
 =?us-ascii?Q?zNehdgoUBEdYNMQ/xjL7xaCgGkmXvN2pmeymG8effDNa8+PVDvtW2K/vkNPp?=
 =?us-ascii?Q?UE4HOnn0qJEwaYq5MDnE6oGr39qZxxbTHfLR9hFWYoJPx/5RLV7rAMM169EJ?=
 =?us-ascii?Q?3H9zzlRGKjfzNX2KdeO+P+wN8hlVgxsfs8bF3avDrR671Zz1IsBdCMvTntxh?=
 =?us-ascii?Q?Yz7niqbelburl35/KyK5eXmTRHex/HJieiJlIWSqOvsh0iOC46drIDM4VTW/?=
 =?us-ascii?Q?0po3KyNlVYN3pwcOrVU1dNtquPqTJxDHPrEVV4ZcA1NBUUr0yScII3cY+Nga?=
 =?us-ascii?Q?3sFwWS6W21EJuUsprR5kDkniQgNWrTIJQKnM7PhdXsAECBxeCugLXQLIiBEf?=
 =?us-ascii?Q?hKv3emHdL7OjPHYqGt939bh4RsU6LZ7T/ZkMkCIWlPc21bv8DF59jrAc29oP?=
 =?us-ascii?Q?dLpXDx6GDxlwJsWAo5Ioq7QdSyn/C1t22oRNhtIeW9I0CrFxkXpXy6QeolCl?=
 =?us-ascii?Q?ohQmp7Aj5igDLzYxQTPiWhr8+3jb/UFgwNAfpZ+E7DwsMqG3xppQPHmh0Dtu?=
 =?us-ascii?Q?P7ihmIAHb1cbi/DeqrBWYOy8B4TN/CEgX9KsoISk2ktJ2zMYHiM4ZBt5mX0j?=
 =?us-ascii?Q?3raMKG9xcGqEQRMCup4ij1QKTZgaGfFlpV7+YhxaEn/SHXm+lvQpxO/vzn5X?=
 =?us-ascii?Q?PkyQBZZOBIHXwz2mMJmhpWbvgseV4mSs6AIgc92kCVyapH9x55Y5UgELGerb?=
 =?us-ascii?Q?+MKGynLOm52hA5rOqXgFJ+mBt1VT9VU9JB7AuHG7nODtK0WxSkcjrO026sKB?=
 =?us-ascii?Q?84uvGRl73pOWA7Jln1Y=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 14:49:12.7455 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fda72152-4809-41c3-efb3-08de4ec51699
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6330
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

The function no longer signals the fence so rename it to
better match what it does.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 6 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c  | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h  | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index 3a23cce5f769a..6f37fc45458a3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -709,12 +709,12 @@ void amdgpu_fence_driver_force_completion(struct amdgpu_ring *ring)
  */
 
 /**
- * amdgpu_fence_driver_guilty_force_completion - force signal of specified sequence
+ * amdgpu_fence_driver_update_timedout_fence_state - Update fence state and set errors
  *
- * @af: fence of the ring to signal
+ * @af: fence of the ring to update
  *
  */
-void amdgpu_fence_driver_guilty_force_completion(struct amdgpu_fence *af)
+void amdgpu_fence_driver_update_timedout_fence_state(struct amdgpu_fence *af)
 {
 	struct dma_fence *unprocessed;
 	struct dma_fence __rcu **ptr;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index 5defdebd7091e..b03e3f5d40000 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -874,7 +874,7 @@ void amdgpu_ring_reset_helper_begin(struct amdgpu_ring *ring,
 	amdgpu_ring_backup_unprocessed_commands(ring, guilty_fence);
 	/* signal the guilty fence and set an error on all fences from the context */
 	if (guilty_fence)
-		amdgpu_fence_driver_guilty_force_completion(guilty_fence);
+		amdgpu_fence_driver_update_timedout_fence_state(guilty_fence);
 
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index cf56babb2527a..86a788d476957 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -161,7 +161,7 @@ extern const struct drm_sched_backend_ops amdgpu_sched_ops;
 
 void amdgpu_fence_driver_set_error(struct amdgpu_ring *ring, int error);
 void amdgpu_fence_driver_force_completion(struct amdgpu_ring *ring);
-void amdgpu_fence_driver_guilty_force_completion(struct amdgpu_fence *af);
+void amdgpu_fence_driver_update_timedout_fence_state(struct amdgpu_fence *af);
 void amdgpu_fence_save_wptr(struct amdgpu_fence *af);
 
 int amdgpu_fence_driver_init_ring(struct amdgpu_ring *ring);
-- 
2.52.0

