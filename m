Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0707BD73E87
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Jan 2026 20:38:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B75610E303;
	Thu, 29 Jan 2026 20:38:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pyH0yt+m";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011040.outbound.protection.outlook.com
 [40.93.194.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4673310E332
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Jan 2026 20:38:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T5ga+4lI/hOKYu2vwry7LyvarwxoGP5HPvL3pWLDVf8iTvuA5DKBInH0ew0WBy6FD3dm+n59749+f16FuG1TBEwsCrKJthYVTMoL28Zl6bpIlMPidviVAI9DxNxSVW6V/s6T1JwRGH9YoK1GQLVsy11RP09hybeDZM/Drd85wlo6SIR0slK1clBvJLfs5Fa1pTo60Ev0Ii709mdNLUpkYxmxY+ohyPvjGhs3JmHG+BaJM57RYhC/tmdKkVBebvhjTRKfX1d0ntA1+tIY0r8icPf38F6ZnKZhTzVRQgIhvaVY5cXswGc/lwEXehCNcUh//3mweMCljjo/UW4aPNaugA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N21i0kJ/EkPoJL75fS/xcD0mp1i7huURWXoaBlqBfBo=;
 b=stFNiz7jm0yDZwLccioDWNjbGIQJA4YLYMXlYsr4KRlDV4DfVsAIpbyi1DzwOXSXea9DOIBmew4ljSUbdHXE5n+3X/Pq5OJwTi/KH/ZBaIHIheWWT1EsSpXM1KnluTi2ihgf8VxQB3j57WNNHK3IV/yB/wcKQ3sR6AS9fvrCaX1YvxYhxPqqYPphlaI3vTxu2GHMCHvgZO/xg9FrxCoim1XyxmeTKHdi869t4TPtrv91YfRrIjnwDYY+kwI4TyIrpRuA2NoMz27DPlzw9HEnw3NdzP0qIXxLdDBXWP8owMGHQj6vJx0C6TL3yjW0yoI8rxtyAoO6yv8KcV2Laj4IXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N21i0kJ/EkPoJL75fS/xcD0mp1i7huURWXoaBlqBfBo=;
 b=pyH0yt+m+OYzL7bUAy9uP8SW5TJwsvQomDNj4f5yh0TUZnpuWgnIIdNLxWQGM9UPWYwXLvEyaClQGhcAc4Ht4awpZXBYo4W7GWc2NcOrEgX59SyVM077KUnNiAA0puv1W6s2EXxnFCcE4/VwI0HmCIFK9YxNAq8jGfMHILZvAos=
Received: from DS7PR03CA0325.namprd03.prod.outlook.com (2603:10b6:8:2b::34) by
 DS2PR12MB9592.namprd12.prod.outlook.com (2603:10b6:8:27c::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.15; Thu, 29 Jan 2026 20:37:55 +0000
Received: from CH3PEPF00000014.namprd21.prod.outlook.com
 (2603:10b6:8:2b:cafe::d0) by DS7PR03CA0325.outlook.office365.com
 (2603:10b6:8:2b::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.10 via Frontend Transport; Thu,
 29 Jan 2026 20:37:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000014.mail.protection.outlook.com (10.167.244.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.0 via Frontend Transport; Thu, 29 Jan 2026 20:37:54 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 29 Jan
 2026 14:37:53 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 29 Jan
 2026 12:37:53 -0800
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 29 Jan 2026 12:37:53 -0800
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH 06/12] drm/amdgpu/cs: return -ETIME for guilty contexts
Date: Thu, 29 Jan 2026 15:37:25 -0500
Message-ID: <20260129203731.21506-7-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260129203731.21506-1-alexander.deucher@amd.com>
References: <20260129203731.21506-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000014:EE_|DS2PR12MB9592:EE_
X-MS-Office365-Filtering-Correlation-Id: 2281fbd0-4150-43ab-b4cb-08de5f7647da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?C6NI3PNVMCP0objfYm45wmZcaCfKQ/Og+jvIPDwZsKrWFGUidQRK69BxxEh7?=
 =?us-ascii?Q?sg5Pyl1xpFgIKStIv0/tY8zKFuDrVghmmO7dI38zE+bHzi1eR3pZRXxBYpcf?=
 =?us-ascii?Q?bbzc15at+HFVGpgWULSObrUlPCZFGxldKPpjft74b/P3BHt++rkIpFr5+q2D?=
 =?us-ascii?Q?Xejktv79ElgMeWysObP/AhVt0TDI+wKHg5YsYQU9hz68npZUzM/TlcS8fg1W?=
 =?us-ascii?Q?NJD/rYttoR3ADEVAspHGhxgwI96Kyg9Yh9UuzYB6ejEtrtT3HTLv+862VCKL?=
 =?us-ascii?Q?eHShIsBWde8AkS8D6QuasBh8ESnqVZd9HGLKkwY9Dc2FLC12yDDgGCvcuHWL?=
 =?us-ascii?Q?mt5eVKSXd5UKJVunH0Lrpk/AAlr4ikC3aFXlPjxS8OvkYY7Lyk58P0Lvjakk?=
 =?us-ascii?Q?qJZLBOvSX03IjqXz97tZsF6rUI76QCuSUzif491jIeTbfU495owLxJB1hzu5?=
 =?us-ascii?Q?5TzW+YrLv2yKoRJP4k0o9jSwoIakt9LgrE5lLpifEDdoEkBQtszr4ocZiANQ?=
 =?us-ascii?Q?WpFJ8uhBCBq1B/GPGfaZ8FQFNekAv+enxbR5UXp+SD9ZCBVtttRETCRww+nT?=
 =?us-ascii?Q?MDmYQ8f/G75cECbvdMezYNSrTdwaWTqqdhxbLi0eaSrPuQPBy4gBd6X5RyY6?=
 =?us-ascii?Q?iqDPS1FzeoYb9Ya4/9TqEZrG44JghTjzAq2V4fqpqQyrD+pCNi82v0SUxTKB?=
 =?us-ascii?Q?w9JMvV5+jN6Z4NcQ9MyYmfoZMZKn0sGRZUnngLL2mNQHR33Np4l1ECs3YJHy?=
 =?us-ascii?Q?PNWwT/YHLQohT24vBaz8x7wNDsOQMjPZwF9p2Gj0uoC3WpL7Yy1gbAymIPSZ?=
 =?us-ascii?Q?8Pc8WDBS7Tsyj/jSlrSsBK7FkmN3HQvYdOjsmNGcxdCmA2TaJqpdauM20NaX?=
 =?us-ascii?Q?O2Owp5Y4F/aEG74FnU9nBXmRhnBtSVPBf7lsbpqEWlJkM3a7Ne9TA8Dfzaar?=
 =?us-ascii?Q?R1SZmivdH9hUvUER4i/y9IL7cpkPixfogoxwL20JgpS/axVD9Ky6wCfmzLZJ?=
 =?us-ascii?Q?e3HQhXWg5T0KUw7GwTeazWzfZMJOvPkLTm4sGKhYb/nqLdWf28UHQyt2GoIO?=
 =?us-ascii?Q?+tbMOf2W/J4eVvFziDPGUlt082WqMFYvvLEldb2u4y0GoNFPmKAL9NZIUoEW?=
 =?us-ascii?Q?DlXXReVS/Qo7FW86v98p3sc7G4UxRjXm19qfGcvGFgeHpdf0JWwKzhHvVScN?=
 =?us-ascii?Q?r3udZA6HfGyxq0iDfwqf3C7WNwaashXtNPjMEaE97mucz7qfu1ys6sfyBU8Q?=
 =?us-ascii?Q?QJmkEZkDsfNM3ky/cUaUKuxXxhR1hML9zLxZ3DvQvJR4Xf7oOBw/Z2HqKtUB?=
 =?us-ascii?Q?6UMg3+46a6iaKnDEn5FGnS4jhm4mlotiIurVeMNoBKBjizpjODwZlDuscSgw?=
 =?us-ascii?Q?GSHY97w55eFlaKVfaqhOCGmGU5dgUEcn+mXKorbJYTPZ2e6qT+3vrDxn0v72?=
 =?us-ascii?Q?OY6sE0RNS4XQ7s5i0A24wDMnj/69zQkna1ZRdANJ/8qyjA+iF1ALCfPhIQjC?=
 =?us-ascii?Q?1SP3+l0jxTuFlVGKSHVwULrQoubl8f/bRniqurV7SO++UAdvByOyU3vyks52?=
 =?us-ascii?Q?VzK8a4PQIXzUP++f2WkwjhDL42GbewYGzfLPfubOLmvBPm+zGTY2rJtE/AA7?=
 =?us-ascii?Q?acWbDoVgSI5HE4ZZKJ+HnM37MtJp7zUdRm7KQbilC2CFxqzJ5jaGe5RKs9Fz?=
 =?us-ascii?Q?2Hlcfg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: MZg7XI740VkziY4Qt3d5ftGJbyoyIXo1g6j0VP71Mb1vSowTVNRs4/jXlu8f/PKmhokt5IdGQDDViKX+CSf2oNj+AikcPFhftk9kjXNuY2GJjqX/1EF2MmA1ZRqRi5dmgR3Zu3tpGKjjLZMfechsPugtU1YL8xoZA5vzDRqIrdEgGQude0H+1T9j0fZRDqOOG0MYuYDBsKKRgbq0k+YciP39EZJsM6JnxKfO4xFEkCb1ArSgtqelsl8LDfqD6XEHbgCGCU4ZvSWKM2lifae+JWvVIcrNqq5czB7ZBbJyXvrNfQRBPGYdJy+Hxjn8I95JaTWVuVqjSFa4UrutOwnpmxo1lzi7wqYAuOADRDlkSpNXI6G0CT+b5HujMl3Pkez1HlKvT3kNwouQaIKYTDnjyEQFcJ8Exv0Z+QCoXwWzRyVmAqLNXjXEk8f+0zfy6SE1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 20:37:54.9240 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2281fbd0-4150-43ab-b4cb-08de5f7647da
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000014.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9592
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

Return -ETIME rather than -ECANCELED for guilty contexts.
Userspace only considers contexts to be guilty if they
return -ETIME.  Returning -ECANCELED means the context was
innocent.

Reviewed-by: Jesse Zhang <jesse.zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 4d53d9cb8490d..3112a7c5be81f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -62,7 +62,7 @@ static int amdgpu_cs_parser_init(struct amdgpu_cs_parser *p,
 
 	if (atomic_read(&p->ctx->guilty)) {
 		amdgpu_ctx_put(p->ctx);
-		return -ECANCELED;
+		return -ETIME;
 	}
 
 	amdgpu_sync_create(&p->sync);
-- 
2.52.0

