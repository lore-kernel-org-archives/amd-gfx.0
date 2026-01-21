Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 269D7D262B9
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Jan 2026 03:01:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 10E0810E69E;
	Wed, 21 Jan 2026 03:01:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XWcwdJB6";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010048.outbound.protection.outlook.com [52.101.85.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D47B310E68A
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Jan 2026 03:01:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f29J9AqJCl0JiPRUAAiJ4+TAZhLWgLh1ECGXEBwqVJa/VG3mwMdhSVO/InEFA8rZykORB9b9L38yhNT8cvfB522UTk8RmXEyH90mdsB7e55cuKvN3FyBQmVB7ELQjruhhybY6v2QQzCtoqZwBHcyr6IG9LtTD6vLVaUajZZtvh1OGtgjfh/WqlKQgSQVPBysZ0fRCo4nPRBk3mQ6azysVGwupEwTIH9/bTUBbrDPvkyKnZk3CsS6+JYQBWxHQIGB9g8iXz/4uX3G1rplO4egSBEroQ/t935GAU8ONQu0PCtfYS9GYcGoI4+oEjs4YRQWPrXvX9lYRsicSCU/gqHF4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ffqJlupYO6QWFwXuE5La3Z1P8MI+yJffR1WzVyzgqYI=;
 b=TumJquwS3sadXFdUYCH7zlMaoUdvU0dERaWL8PowRUMz4lBh/kxqe5pAkgyJLjTWuJSNitcKr04qgDBllAuxu4vbO/KDoF+j06JwcYqBEZaNjGAaib5b4ReB+UrFgRiQIcV2vcGxEJu893gT/JPOBIz0seHkLpDdZx3re/wvyR1g3bdjRQGref/fF4FkeWxYaq0DIeCwx1kJuqnegyrsDP06U98HpBXmK8HpoGFN/VMcXpslb82cS/43ddCUZeDVVzuXS7PYpsqiXUJO09IIjpJuowZ3HyiW+1VfoniZR+Zl83NKhafhaIf84tMcwA1BeKdXUUVa9HWxGHT5Psu8aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ffqJlupYO6QWFwXuE5La3Z1P8MI+yJffR1WzVyzgqYI=;
 b=XWcwdJB6juQTUCVZ9DzaQvf77ZRlbrmRjlw3nFSO++9pZEqs0f2O83ed9FAPKVjjQHIe9WUdAwSsB0F+JkBLLVxScNXKBxeVjbw1Om+s4OLM5wJxKs6OIUSNtmRg47e2R+7ga+vcXN8wgC299//CXVsjOqug+vQPIKQ5XgBQveg=
Received: from SA0PR11CA0198.namprd11.prod.outlook.com (2603:10b6:806:1bc::23)
 by CY5PR12MB6575.namprd12.prod.outlook.com (2603:10b6:930:41::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.14; Wed, 21 Jan
 2026 03:01:31 +0000
Received: from SA2PEPF00003F68.namprd04.prod.outlook.com
 (2603:10b6:806:1bc:cafe::23) by SA0PR11CA0198.outlook.office365.com
 (2603:10b6:806:1bc::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.12 via Frontend Transport; Wed,
 21 Jan 2026 03:01:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SA2PEPF00003F68.mail.protection.outlook.com (10.167.248.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Wed, 21 Jan 2026 03:01:30 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 20 Jan
 2026 21:01:30 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 20 Jan
 2026 21:01:30 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 20 Jan 2026 19:01:30 -0800
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 09/10] drm/amdgpu: Call drm_sched_increase_karma() for ring
 resets
Date: Tue, 20 Jan 2026 22:00:56 -0500
Message-ID: <20260121030057.1683102-10-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260121030057.1683102-1-alexander.deucher@amd.com>
References: <20260121030057.1683102-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F68:EE_|CY5PR12MB6575:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cde404c-851f-4101-e212-08de589960cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?x4sPvVrnfO57mjPZB6+yTlX0dPMD7gOduxbT1fLWOmefJdg/AZBNzvo6RfnA?=
 =?us-ascii?Q?9tDm2EUJDf5Vo4a0wIK5nBcKp9BdO2MONalD71wmPDP1mu2nreN70B95MiR4?=
 =?us-ascii?Q?H9DUPI6hER5b8w/YISyoiSKPM+bnsfE0kspYz6keCU9xu3CRmdE+6KGNLypf?=
 =?us-ascii?Q?CUoBYnpX69uyMEFoMic175xUs96i1Rd9Mkw8Szp/kY6fPtzvSGHCrurIK1qU?=
 =?us-ascii?Q?nOKkY3FUziDUJGXvYZOfUkCdiOOU0rx0bXnVlYQK8ZDE5Q/3G8iP3KWkz6kx?=
 =?us-ascii?Q?AE7CU0vQXvGj4FRyJJ1a5MRebon3Dx8El2DvqMDG+z8y6iJT6TWl151kBas+?=
 =?us-ascii?Q?ViFFqmHlVH92n28v61hs87g75EUJ0TXIbsKvuWmZ8/TFSgEwa3G2QYW0ogVj?=
 =?us-ascii?Q?7Vrret9WgcxDzXPT5gFSTg3xqvpZ8GTCUll+OrnfKLUoqlTbpbmWvK4BPD5p?=
 =?us-ascii?Q?Dgex4cFIbZH1dE3X0G6NAQdYGQdrHD0DEJKzQNOaeDrJ/sIqkgrUC+Bp5ZP7?=
 =?us-ascii?Q?OAqNuXphwL3HF6rjOqSQ+bPHBd8do9qIe/JelIVHQtGsMuwjUCsFdOPsudbF?=
 =?us-ascii?Q?SA1vR6S4vQistIRgHTYTdq2knbq3IRyvcdV74QIDXpf+FpjcIppdS/RBO7AL?=
 =?us-ascii?Q?gmEh/dKYJ7HESpJTysKPZl6T15QVIa2RzWEhn2+Di37GZSz67jdCSZlYL6rA?=
 =?us-ascii?Q?WbQXFqlUazSpTu3NNqDpv44lx79bcgVsNOLUpm1TftYqfYEET1DPCRsC61tB?=
 =?us-ascii?Q?ZBdOU54QIkPPSCXGCscMQQzPRaryoMUz5cQTchdVSZQF8qkjz5RxkzMhCwfy?=
 =?us-ascii?Q?QkVKxDHSMxOeWoN7iDCMlbdsnqH8eOh/chuJLmOWwvAADHcM6bPEpviIG8Zb?=
 =?us-ascii?Q?HymDNgjhWLytqWcJJxjyawz/AOXE5M9mATRrEr2ZgqmKb9VEgTSj3VUt6u4v?=
 =?us-ascii?Q?cPzwUx9HBrQiHX0HCTtr5TzN8FR1QllriOgdMwcf1HE7+kcRK+7Jwo/TIAX5?=
 =?us-ascii?Q?fjmwDnbrUx2jghyskCl/L25sNB6B+Y25mHrnCf1NQuuVeZ+5GdxTi1tu2bfw?=
 =?us-ascii?Q?oBkJJ/vAgDUrv+6WHkJ13xzoBdj2YdxS1VWB0Yyk9/0ITDXspxHpCmolFrhn?=
 =?us-ascii?Q?b6AJ577uxYaLSXLu5NtSbEIBZMA4YhrqcA8NGQPDzl76RHbM944VXyp4iTA1?=
 =?us-ascii?Q?g9eslE97WmpaKOlClP54tYOldKoCjONYj90fiPUcfAa0+7mLjXzZ3+5U5L5S?=
 =?us-ascii?Q?ClGvjYsCcoE+0ehzYF5Jt3IqQwuTkFCoLjEiHVhDyCQ7GCG3LYDs9yq5EBEl?=
 =?us-ascii?Q?jQphJ79owMTOy0H0+RdIeQnqNNIUVhKpnF3ul4AesRgUJx5gD5dr6dSbllln?=
 =?us-ascii?Q?aIy+gmNON7zYAwn8vGd15gK/pmxpiNfAwP0ZAitvpKMx31FL9JUHg0nSE4U/?=
 =?us-ascii?Q?NGw8XiI5ESf2OrrpidMg67qiW6Ag0eFHusPRzrvU/pRATwT4kRbv8IipU66m?=
 =?us-ascii?Q?kK1Lzvpeqx9XZZ/kxuOfZrYIZ0RWMIso9v1QQs++MUEoG1qv4nbTk11DRKdM?=
 =?us-ascii?Q?Jw04KUC7iqmaaqvUSF+dnYfXfTDdfTOIWArUiQZQGY54kXtqb5iHhlIe11Af?=
 =?us-ascii?Q?Ju7nEzz+WnoQ0UtHg2wIysrAwdLgHIpt2HfWgFygtnrDtMBSRh+pi4a147O7?=
 =?us-ascii?Q?dYkbYg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jan 2026 03:01:30.9920 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cde404c-851f-4101-e212-08de589960cd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F68.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6575
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

