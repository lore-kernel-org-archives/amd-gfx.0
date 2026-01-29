Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DA04D3566C
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Jan 2026 04:35:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 911CD10E7BE;
	Thu, 29 Jan 2026 04:35:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zStCUwso";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011023.outbound.protection.outlook.com [52.101.62.23])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 17BDD10E7BE
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Jan 2026 04:35:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mMPG+8zl/oYsB1jNIvdK32ptQ5R0tkgxkuv9uZV+wVhBq/Jix5bDqZevBriDKFUrjueFSMnpcL4fjMOedb3XWOEyWt2N3ljF+keuZbvwABZ+z4nVSxjDEzweT+wIpcbpMeiNtiGUpX6VHOkAFUW0el8j0tEwTtz3xYoIsApzcYOZMtXY/Z+bHdORntc9Sz70nJUjiwpVEj5tu3IiZNh6M6X7gsCZ2vFE3oDbN2jfHDqrdNHlEn6t90bhRRg9+MgZlg0SeJ4iH6kjs24p+9IR+Qwg7xwWzARCXh77q+aGLiJl/SJnu8Afv42MypkAeW5HrfjL+AY2b3OSQGL1W4PHPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8IvbEwBMAvpVYt5soEXc/SwHICv7OicjP7G6V43aEbE=;
 b=s7yyxKE+EDhj49IhM82hXpLzkOANVdDYM8c4shYRrCQ44Ikbalyr796x8yIH3+wfDJNL2maJn818ILe8guts/Tah72Jd5JpLe9DX8tRZDQXrHHBoLt1brrRTwQishVtUTFm2Gy2UeZ/+wmrv8FeTo6tSPkOX0WtdZQ9BMFYYyrV8sZ+xpMH7mPdzYRiVYxjFOw52h768RRI4RNy7g7BRJj2RWsUHMt6LVBOT3WYzqH/0mWusWchHXwUXC7FkoR18Eipdt1rVZJJLUYnw8DQTeA64SQSmZxonV5HzMd1ain/+fjP2xbnIHgGvasI8Ym5Lk9OjknuqX4Aj4eX6FeAYYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8IvbEwBMAvpVYt5soEXc/SwHICv7OicjP7G6V43aEbE=;
 b=zStCUwsoZWTlwKKcHTWyKkLO56giXjx5CA5KAkn+H0qnHFcud89O3uXwPxU3JhgSK+MHBktiFqsj9JPrb6BwPtyEy1hr8mBQw3eRo/ewhfpYC5jgR0tNrUXu8Bx3pZhXPoFfzWr5xgXYKgeXjlIAYf+T0kqWBkvLMBMqbQRV388=
Received: from SJ0PR13CA0225.namprd13.prod.outlook.com (2603:10b6:a03:2c1::20)
 by IA1PR12MB9030.namprd12.prod.outlook.com (2603:10b6:208:3f2::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.16; Thu, 29 Jan
 2026 04:34:58 +0000
Received: from BY1PEPF0001AE1C.namprd04.prod.outlook.com
 (2603:10b6:a03:2c1:cafe::40) by SJ0PR13CA0225.outlook.office365.com
 (2603:10b6:a03:2c1::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.2 via Frontend Transport; Thu,
 29 Jan 2026 04:34:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF0001AE1C.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Thu, 29 Jan 2026 04:34:58 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 28 Jan
 2026 22:34:55 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 28 Jan 2026 22:34:55 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 3/3] drm/amdgpu/gfx12: fix wptr reset in KGQ init
Date: Wed, 28 Jan 2026 23:34:46 -0500
Message-ID: <20260129043446.33377-3-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260129043446.33377-1-alexander.deucher@amd.com>
References: <20260129043446.33377-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1C:EE_|IA1PR12MB9030:EE_
X-MS-Office365-Filtering-Correlation-Id: 2491ecc5-d7ec-4deb-fb08-08de5eefc25f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?sCz/eDGY3UVAv9VjQNSE41UnpcPip+b+11BRGgexsT0p1720jZF9iKFQ2aOL?=
 =?us-ascii?Q?VUcNrSheCGeSi1EM/zYFRXwVgqXjhutvTq101aFNZpdo9dE/G5Vt/0ThrQcn?=
 =?us-ascii?Q?v1K7TGawS7VlsfdUucWbFOREvF9B8/ttVUnvJ3RIagogSDItA47l5VuKm1nY?=
 =?us-ascii?Q?SN29/p9xCuNLxW+vnqpQbcQkSA9buzwVJVH1ncGuxHu8dM+noalLovwrqDnl?=
 =?us-ascii?Q?REyh0TX0d6mNuVi8eEjsXtGccxxmpUmV4VUhiO1JRVuzeJBbRmzcVmN1TIvV?=
 =?us-ascii?Q?+eug3qL7TbJ4cXVmv4NZnkJlFVDBUX1awQ9KI4R2hohhG9rl3kYny+XnV2Xz?=
 =?us-ascii?Q?zujIbK+G7oJ6WUob0tE8RgZFmhd5qAE3pkhfF87wZ+Kkk1HeLQhVCkCPrtRd?=
 =?us-ascii?Q?AN8QryiXLgKY5Sl4m1bLy1Kvm0v6YecCVH9o2xV4v0i9/dcYhdLbssBiuLVg?=
 =?us-ascii?Q?edTF6ZYcC65ucN0LAPmk+T5+1RE8j2TCNg44qjx5TInW/5vwFCtNPpxp+Z8z?=
 =?us-ascii?Q?pR9VEGhsOotFS/yRJcDsrcQbLNMfWWtJJ9YDpVvq+F79tM4yT1sPo+FYcjBn?=
 =?us-ascii?Q?eYPRVL/aYfgLUXRA0aTWLeF4yD+VfXMkPCX/aWU2PxT6SOA1LaXWn4ZcN+bv?=
 =?us-ascii?Q?JvQWuRR2FtRHL1vJQymFHDoVikOgcCAAkZ4k57iQdSzMTlhnWpHdkO1Iqzow?=
 =?us-ascii?Q?ghF95vQf7YI6U1zsI2cDVlpd4iXOGIgwf5zINY4CdgFqdMY5AZc6hOR2Zm7T?=
 =?us-ascii?Q?G+sXLYYg9//fFNWR9WmtAJCFrUsw+OidbXGm2jWaNMnHLNJS7SDJKPA9/mtZ?=
 =?us-ascii?Q?TgdrxrmuTHgVSCDX+r2a7/sC4OMXoMhJVwnIBRBllwHdAFrIQHy0FJwY1RzS?=
 =?us-ascii?Q?sbMTMdm3A0UkB28PQuDVEkarwTEmdBuiDXRVUv0iHdeC7ew7o0yawzsWMVh7?=
 =?us-ascii?Q?IlhKVyBWvAl3RSx3F45w7/fP+31sI1ZRqPO6woa6GLlfNWy+Owysnxbts02j?=
 =?us-ascii?Q?CCokZboQtXAyKQhlgBY4dosgJfj176+fDEV7pTbmTkNjQI+7hZHuqMut7h8/?=
 =?us-ascii?Q?xgBRwzm5KXrZyOxYxKFcMRFC39i/f/pmvuiLyksLq0KKCqXw+DWoHHGs309u?=
 =?us-ascii?Q?XeGOvRndVTE+CL6lA0hIzU46JJQxLfnKL6p/TAIQ8Yd+DlpN5CWfMfcbYvB9?=
 =?us-ascii?Q?JGtoeUym8VcepQhjEPxMV5Z4tIaGbjGd0dmM56vV35Kj8lfVHLTr9WVF7o3I?=
 =?us-ascii?Q?ehvvoAvSk6syVVqrPdl5DMXItQrJfAHm2BxMnAWlKTnzhL/6KHO1L9az91Gq?=
 =?us-ascii?Q?D60d7D4CJPlPNT/1ag+xhq/Cl5z/qcW76EV1m+TSLR/jjNiPhFvIFhR8jm+i?=
 =?us-ascii?Q?01twjVS5WJnXSax9RimW4BsdwfGVIxN1aF8j+sCYboje4PxiSeJbsc3Z8SWW?=
 =?us-ascii?Q?7b2lFHahaTTDuWypdqN684BngaVCRyzw3TlyylkF6Kg+QBHnzmv2Vh/fOgqL?=
 =?us-ascii?Q?9RXvvDGBzb3MCWjdfXLLSPvALYStKvgMfM39BWyP6GBajebWLH6izlZ2d6Ka?=
 =?us-ascii?Q?qHCD8ozeVAh75xU2WqespSgxy4hyL5BYaG8aR8edAvJRWvBMTt4Ok5X3imQ9?=
 =?us-ascii?Q?OWZ1XjvcskHcAlXIaBLusq48x9d10IUyYL013UefABUlG+j3xbTmxcNoChz4?=
 =?us-ascii?Q?uAuiQg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 04:34:58.2318 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2491ecc5-d7ec-4deb-fb08-08de5eefc25f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE1C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9030
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

wptr is a 64 bit value and we need to update the
full value, not just 32 bits. Align with what we
already do for KCQs.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 9e48045b036a4..d8ab93c82366d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -3096,7 +3096,7 @@ static int gfx_v12_0_kgq_init_queue(struct amdgpu_ring *ring, bool reset)
 			memcpy_toio(mqd, adev->gfx.me.mqd_backup[mqd_idx], sizeof(*mqd));
 		/* reset the ring */
 		ring->wptr = 0;
-		*ring->wptr_cpu_addr = 0;
+		atomic64_set((atomic64_t *)ring->wptr_cpu_addr, 0);
 		amdgpu_ring_clear_ring(ring);
 	}
 
-- 
2.52.0

