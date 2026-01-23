Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31EFBD77892
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Jan 2026 17:20:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B554310EB70;
	Fri, 23 Jan 2026 17:20:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kkidmq7K";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011026.outbound.protection.outlook.com [52.101.52.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E604C10EB68
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Jan 2026 17:19:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LBSZrD2KrGpmzE3pKSBUrLcslPvJNLeAR4ADofFimrCJMPaHwW/sdhztz3vedFEGGXe3mlNWSBU9gjbONJblsGTC2eEmfF97tyTpfMgyLpSWXLtLIWvocoIeSmwW/drk9OEiXV0VMg8vjLPzU3KoYgtLUzCZB+D9NvTYfQW8p6FWO2NKgyRLhqKCvsNwOm5fWpmXVu0S0HRQAhOHSGKS8YV5sL6b34w5JJKI4WMVKkgHmhe8DAhj+yl+w5jWmYUbnvSL3kmYLoO+ANqyWqwwq7+o3zW0Vlp4Q+t1qoJ+PlLbtozXYQ9FkZuGcl/Xa9N21O5Bmk6j6umizXeoAkwBOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g7l0V7E0f9P6IPe4wJx1PyLxW0Dbs4dkSQY8Z1o1T7w=;
 b=imZTVmQrLvcie9iVmidYgk15VOSwB11A84Jruf+WuMsXMijtY60gxv5bCgP6TIApQc7Xdb6Wq/EyfitEE1EyWLj7rwUIFcraSgH+J3ZZ26QaaHz5JTLUAQUCNe3N0IX1Ha1CjjbfYccc17pcCv5q/j2a1X4zfYDazoVqiJ0jWelrYvedgI+jZIY96t4Ow6P+leFzVwgaTbFnigBJr1W5k8Nm1PN1geHlLOPdyAV+O8tQJZGu03QgsCES1PnR0BCLHmVhirwAzXONWIsc1Wv+QYEbW3bUQcG1WEAh43G57oBr+Dmakvdp4e7Spku/YJebfFXh88pBl3Q40ffL6lrTQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g7l0V7E0f9P6IPe4wJx1PyLxW0Dbs4dkSQY8Z1o1T7w=;
 b=kkidmq7KyxOu0FkEkCD4U93JcwKKdg6JjjydUQKmcT3XvmAWv0M2s/iZgQrSWKLnS41s8hJrxC8poHPeSCPVztHzao9e4+kl6Fd0lJe+gzBd7VeYWrKtILKJJADo1IUemucYosXrjdOkIEEyeNhOHGUe+I5lKgGhGtQGKHURqJY=
Received: from CH2PR11CA0010.namprd11.prod.outlook.com (2603:10b6:610:54::20)
 by IA0PR12MB9011.namprd12.prod.outlook.com (2603:10b6:208:488::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Fri, 23 Jan
 2026 17:19:54 +0000
Received: from CH2PEPF0000013B.namprd02.prod.outlook.com
 (2603:10b6:610:54:cafe::82) by CH2PR11CA0010.outlook.office365.com
 (2603:10b6:610:54::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.11 via Frontend Transport; Fri,
 23 Jan 2026 17:19:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000013B.mail.protection.outlook.com (10.167.244.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Fri, 23 Jan 2026 17:19:54 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 23 Jan
 2026 11:19:49 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 23 Jan
 2026 09:19:49 -0800
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 23 Jan 2026 11:19:49 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>, Jesse Zhang <jesse.zhang@amd.com>
Subject: [PATCH 09/11] drm/amdgpu: Call drm_sched_increase_karma() for ring
 resets
Date: Fri, 23 Jan 2026 12:19:35 -0500
Message-ID: <20260123171938.16814-10-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260123171938.16814-1-alexander.deucher@amd.com>
References: <20260123171938.16814-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013B:EE_|IA0PR12MB9011:EE_
X-MS-Office365-Filtering-Correlation-Id: d25f3a42-35d3-47e8-3628-08de5aa3a023
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qqN8KsaHXoWIKpN0oZgcDTf6DkKap6G4iW2LoaYBbPk1sfDDSS5Nnvpzqodm?=
 =?us-ascii?Q?dFCCqk7n1sHpRCa2TyVRtWaE+E882K2VN2aeTdY//ZNP7t9l2C+tCRsjPUsL?=
 =?us-ascii?Q?xHrsGrTeK44MSLWmlWpRH9UGBkmc/6CQU8vTJFW+SvB8JRVWqGWedu/26NlJ?=
 =?us-ascii?Q?HMESWC2rZny/RMkvqVD8MKw5geosi0z5D7KPB7OaYho0WuJJShfbJwkO+ZV9?=
 =?us-ascii?Q?CLRdYUGuCtKJdtxhzb87PnoasvmorlHOiM0mSMoDUZfubuzfYlo435l3Wt5M?=
 =?us-ascii?Q?oLTmwMm/t+dppHGLHgmWjHLV0qpSpRwjqVd5HWUL0YdVr75WQ02lTJEPsg40?=
 =?us-ascii?Q?mPsfKcPBnopRVQ7oxce/EH8qUwSi6Jm/ANMsxX0GkyEMRoAeoGlQo5W5/Nhl?=
 =?us-ascii?Q?Q9aIPTkKWGKYRBwmopyxvMHaNlCIggaDZQjw46mwqZmMNGIEmRa1qfw9kIPy?=
 =?us-ascii?Q?t1gBVhQ8ct3CmAxbJgcvNgxacO4mHnulIsl4y4ENc2+K6Cc9UgJBC26g3lvB?=
 =?us-ascii?Q?7PSbM4NocADP/+1Qg6mIjYqMXPH+9KbdZUQeX7wnYS0H0nWZ1g8X/FrbN9uW?=
 =?us-ascii?Q?bQ6RhkZGh/G9eqYgbQDs4aoAMfnGSxjBnChO9oyE+SRJcn87XZaV/d7aQStR?=
 =?us-ascii?Q?XE63GYH+DpRqltscpLPhgKsZPkSxxH6PnMO9HZH96YRRz4fzIkOPpXmvdZB3?=
 =?us-ascii?Q?IbkYUiqhgZfU0JTrTbQ5c3GUp2Loz1H55ytMU3ELE8tUY+2CPa/9A/GsDBkj?=
 =?us-ascii?Q?0HjbF9R1kv+oGaonT6yT2oyc3gMqV/2WGfokARjwu9ze1HwHInhSjNuPK53e?=
 =?us-ascii?Q?gNDBm92xMo2IrsNGs9RVIpg0lJPkAIdsXgpptO3gaW57jaKjcnu5v+uNW1hi?=
 =?us-ascii?Q?PdqvXERdk+DFx0jaeN/9FS+TPzfAYByw79dOwmvDtPf2EcSLCzhGit+nghOq?=
 =?us-ascii?Q?pa4t3hfq5u1D+loKuskOBIN4IQ+8LApm9dYafUVAOg37YJ1j5ZR73Jm+cBwb?=
 =?us-ascii?Q?Eo4UU+4PCqrZWms5JTTHsBa9tGEAJlm47dUc5epxDtEuv/QstWJQFETs+BAC?=
 =?us-ascii?Q?jZxlqBGoy+sj9Xpn/Ccm//Kst7Rl47U7uyxsqafmqc3dibHD1m6oZ6F8vFz5?=
 =?us-ascii?Q?4xrVVeoMv59JJvmDPDgPCHUhM/sUIKM/6/jqqqD/wxRmni3cBfRpz6aQndd4?=
 =?us-ascii?Q?GCSZOadNOyc2x0OK3gqt5aOJ3RsQUh8C71lZb5VLRxfRG1z0vTGADn5ddECr?=
 =?us-ascii?Q?7Ic2VYnj4mMu/XCpOnZE9skOrFhNfqhsbYz9uZlMmRn53T9zds6l4v6IuMPe?=
 =?us-ascii?Q?QP8pWN020FuoxIy4qZcrtvfFW1CYJfo85H4MI0wGjSIV/7XCVqTvlTkihdPj?=
 =?us-ascii?Q?YHsQ0RvTPsR3fI7eG+eFc6OCkDag9zWp6corG/rRHPt3SuL2i02C8Hs34YDw?=
 =?us-ascii?Q?ZN1Y0dFY+5M2i/C09XciKh21Qb3NhiplVftjNyE26bZKwg/wkbMS7qC1PC8Z?=
 =?us-ascii?Q?wGDRINYh9LzrXiD6GdlEszqyq0Rh9re02SLQ3sluTt7JaXTArcpXG9LWlV9F?=
 =?us-ascii?Q?u6G+XUss1MNDiZVIqg2ysrG4eDQS5N2WSgwL3X8Uz2tvIw0lTm09MwrOsTyq?=
 =?us-ascii?Q?34yJtfR5vBltOXjpw0IvxSFcz8RT3w/z0v9MOy8wqVf37eq8DpD1W4UFL5Rg?=
 =?us-ascii?Q?W5/tVg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 17:19:54.5466 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d25f3a42-35d3-47e8-3628-08de5aa3a023
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB9011
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
index a323071762822..3c4b148d4f6ca 100644
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

