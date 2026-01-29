Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44BABD73E88
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Jan 2026 20:38:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D27A410E343;
	Thu, 29 Jan 2026 20:38:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="w0pz83U9";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010008.outbound.protection.outlook.com
 [40.93.198.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82DE810E303
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Jan 2026 20:38:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oG6zyR3ZS486W/niqG57pj73+xPkplTqL/wX9AmbDouognjo5q2VjgZb/RkJwdEgaITXQvzKgf2mG5ty0NXsJP/q2IdLCiCI5u+GO13cqBOFY40OCVXvUViUKal4I5FGaM0mj8FU5PuSY4u1Wm5ijHgc+sYoDiglMLmsR6jqGr2LyOKsi9OtM0HDWCLY73yOdaOVCGxOvZ1Byo+mtGmvY767lFgrWWf1M6x/dppiGXoUkBsKAOApU9O02zpsN/YXjzwpfoepzOu9YIP1r2X7hHtYCdZG35cvsZo6eIRBZVnLnMSgDCgTbDzotXxl6U+wDPLZN/QWa4IZS6Dj7mrYdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KtSqMMekBkttke5I8iP2d//Jcln9ifU27eNliZsT3OY=;
 b=uIbXxdCtg7Ht6Kh/TBUolIqyn+ven0zjm8SwFqs3h2rdyMYPs2XXCeyrOY/4N/n24lqYnTE0VaMc4UphyI0aSY9vhflZvO2544FZUh7mNJkqUjQK2fxf2r+L/h1Ko85ovJ9dVF2pnGwHzvEXASbqqsyBOcuReA5Mql0RQUanJb0u6vqWCyuxa8wOfiHhLxY12GCObgZZBN68UHDvvXjIRG78hnpn2jMBZnMagGCJjyRiCKInTcnWiHZL6A4IUuK/3Foy1Jrk3CfPpu5cd9q+Bh0CUy+5X7CNAwKf1VF7YprTjnlU1u91vfrwgcCunmPXZd57PLpYXoLRlj+cu+e0OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KtSqMMekBkttke5I8iP2d//Jcln9ifU27eNliZsT3OY=;
 b=w0pz83U9gc8xnWOsE9NS/ASV6MJnQnfMO6fXn//VF1FOd0gRiyAta0Fe8jq8hrGw/Va535GgMThqIBsMXMymBPfJB5fXjKfm8/225PZYJq2mVcI810PSOG/EFTGSvjADCYJ009FhTjQyigL7EoM9J1a+RFvr+LQMEMK2lQdhEnI=
Received: from DS7PR03CA0322.namprd03.prod.outlook.com (2603:10b6:8:2b::29) by
 DM6PR12MB4386.namprd12.prod.outlook.com (2603:10b6:5:28f::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.11; Thu, 29 Jan 2026 20:37:59 +0000
Received: from CH3PEPF00000014.namprd21.prod.outlook.com
 (2603:10b6:8:2b:cafe::27) by DS7PR03CA0322.outlook.office365.com
 (2603:10b6:8:2b::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.10 via Frontend Transport; Thu,
 29 Jan 2026 20:37:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000014.mail.protection.outlook.com (10.167.244.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.0 via Frontend Transport; Thu, 29 Jan 2026 20:37:59 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 29 Jan
 2026 14:37:55 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 29 Jan
 2026 12:37:55 -0800
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 29 Jan 2026 12:37:54 -0800
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <christian.koenig@amd.com>
CC: Alex Deucher <alexander.deucher@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH 09/12] drm/amdgpu: Call drm_sched_increase_karma() for ring
 resets
Date: Thu, 29 Jan 2026 15:37:28 -0500
Message-ID: <20260129203731.21506-10-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260129203731.21506-1-alexander.deucher@amd.com>
References: <20260129203731.21506-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000014:EE_|DM6PR12MB4386:EE_
X-MS-Office365-Filtering-Correlation-Id: 2950ca72-987f-4e0f-d166-08de5f764a58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6kVDSYydF3waVXD5Q+pgBJ+9upXw9rjTfHjI5w7rlTuXLZFxz6rEQt1v0Rgd?=
 =?us-ascii?Q?EgQ7+RXGAsEUw4pd0ufCYEiutKJmdaZpeSBVcGJBUwlNl+4YBtsTPeD06AHR?=
 =?us-ascii?Q?DWJajVaFE8v3ZZfcA5Rl1InQzwPPQQFotKt5FrItK1UMiXhW/uW++o+LcJqy?=
 =?us-ascii?Q?adaLuL+UQm4cVWcGBVhPh4BQ4D+CdNf+QUiiUhOSxbr6izXoBgx9Pkr7FBbL?=
 =?us-ascii?Q?XoQfMZ7PitIVof43qu9CEyALQ8VudZjdyOA0FpvvvQEfZW8OJxJ64g8MEJez?=
 =?us-ascii?Q?EzbZ0WleCKzmMx5CZqGYCd+33ARyIN8RvhYkaRh4aS2o2soH48rUK6DdOkNA?=
 =?us-ascii?Q?5rSwziYs5/Fkv1bOy1mCCw2uHWW/qwVII5xlB49mXzZGyHrpDMPaTUwvlSoI?=
 =?us-ascii?Q?poW1x/JQBJq4qJ1cAY5nih+GdP9rboI7gM9Owt1/Scm9fzJp3M2F/D6cWwJ9?=
 =?us-ascii?Q?xJc1ByjJE2qqxZ0qUIqkpY4DjA+79Pd3bOkFe/aoYLlJENEDrT6zljG6Eppe?=
 =?us-ascii?Q?cCxc7aJHEc6WRrUnp9EXCK1G93S4Z7BECBf1wpoycBdhVYWrfFeTdCtxunb0?=
 =?us-ascii?Q?JDfeNETbyBVC6kl0bDHvg/flGRXZ+MsHvG8SmGismShqPTe7xL2qgbLdWLzE?=
 =?us-ascii?Q?YwgB5Rro1zYWwKZdtnp7/+WmgWp67/BSUcII9htFlGC97ybsv2BlKCVPIYiU?=
 =?us-ascii?Q?OTE2MLNYpFTpVXdL9ffHxnA3IX3XS6BudGMKPDNS4JJQx5AliEIMaul2MaJx?=
 =?us-ascii?Q?9lkddzSmoD+COHetB8YafQPKvXsemRufkWIiCa10zZDjxAKOq805nLwhVGFu?=
 =?us-ascii?Q?MsoXHFu0M4BIyfIOJkmGYfwFj+OzuCKid6Ul1s1LbTDDSLUIW8q39MOWRsaZ?=
 =?us-ascii?Q?wocwRUDHoN/FpuvAaH5M7aKOlEVkrBij5Tm7qdkZG19jhGQVrtwJ9SzsoeyM?=
 =?us-ascii?Q?HUdhkbK4iK5+tiDX3s85bYi6dTEMFeiLteRByFq0b4Dkw69pEITval2r/Yet?=
 =?us-ascii?Q?DgFvu2s3qrZvdpeLjUJSEjti14L4Brlc4LHCbk4XTfgX1hFt2QIqS4hhAAtM?=
 =?us-ascii?Q?ljLAPAGtdVVfbIvMXlu2dPtCkBaMjk42JRxrARK4ZqyQ9d1zoqWJduw4wN6+?=
 =?us-ascii?Q?7YFWMjDCxWjEkcUT/C9wcdwI9WlzYwlo9vJoQKkXnDzA5PTRVvw6569C9/qy?=
 =?us-ascii?Q?4xnUBI8hoZ4kmz4TvWKpFL0rPqQEtO9JT1+/kE+21fyu1Npukx8YnN0B2hD1?=
 =?us-ascii?Q?OUbEShR9vWFB1TuD7b+eAk5Ulv1EPTgIHeiE1lJZH3GmDBiU5N5UqpRMavzS?=
 =?us-ascii?Q?hAXcBeyQbAYWhESjmcAUmK9WQIEACcGRug5We1gF+r4VKVbR8CVOrs6VPjsl?=
 =?us-ascii?Q?Qn6Paz9rrbiybF80JK0y8FmztEu9j+mOwX5zYzRgfU2+Z8sWmdsNpDIJLqQZ?=
 =?us-ascii?Q?eSVsjnZbcowfx+kRz6VQ3pwH4xdQE+uW4z9uzFqyavFDU0ofXaAaJCp9gNQv?=
 =?us-ascii?Q?Ei7Vu01Ar+H/aekpDiz4zhoEckMjI6lpbD3o0wMyp8c21tAt1bU/8XwvGS0U?=
 =?us-ascii?Q?t2dzC36aNUqMJ8FmSBvrhRF0Vm//Itp89HjFuPCKlJCEeihSYuG7sgZYwTC8?=
 =?us-ascii?Q?FGUvsSuGtW0rjOTOTQp040toqJzzpoBaZV/lx76+bMVvJeEciVcN8C7CsU4x?=
 =?us-ascii?Q?IQbJqA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 9PEQ6IFp/WioyRkaHKbjQ9O+W9FanfyIJ7IR8iYnPGAs9Ytjk/lWKimn0itP3xju2cA3bUs1gptFyk4sO/BcVsH3LEkxUk/0vZgjj8LThbdxjlPxNJwjnmQ1McYs1RUlnWjjEmmvKYqolwVI1BSwvg4y4nsC57RP2iQ+GTdXVycrO+SIy4iH47e4cIV+dKqznAkvzqkGfffT7OD5Zuk4lf6fzGWGQaWrR6EKS1ORePCAjiIKQJJ3Fdv16x04zrlLz0TCfqpv+Kt6JGs2dFqrtVb8G5IXkcmYl59QwNVn3FGVzM60xQTkO7Bt0vOzoBwS+OhDnm5WzVF6F7Rda08jUNJ8OuSw3ggnQvMMwN8Y+TNaF5O+EqwuNIkOHURTr8aJ037WalhPita8qQFT8Yq2KyLGXiwopbO3V0kpisff//JRWAwLv9VJLXNCRA5ZRBSS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 20:37:59.1023 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2950ca72-987f-4e0f-d166-08de5f764a58
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000014.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4386
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

Mark the entity as guilty.  Align with adapter resets.
This only makes sense now that the CS IOCTL returns -ETIME
rather than -ECANCELED.  Without that patch, this would
break userspace.

Reviewed-by: Jesse Zhang <jesse.zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index ef1e1da5df658..3416eb717954d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -137,6 +137,8 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 			s_job->sched->name);
 		/* Stop the scheduler to prevent anybody else from touching the ring buffer. */
 		drm_sched_wqueue_stop(&ring->sched);
+		if (job->vm)
+			drm_sched_increase_karma(&job->base);
 		r = amdgpu_ring_reset(ring, job->vmid, job->hw_fence);
 		if (!r) {
 			/* add the job back to the pending list */
-- 
2.52.0

