Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66425C77B7F
	for <amd-gfx@archiver.kernel.org>; Mon, 23 Jun 2025 09:52:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09C2610E34D;
	Mon, 23 Jun 2025 09:52:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sH8semtp";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2076.outbound.protection.outlook.com [40.107.243.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9861410E34D
 for <amd-gfx@lists.freedesktop.org>; Mon, 23 Jun 2025 09:52:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dFhsP/7cBhHjKkc7akhpntBQERgFHqkAEGmAfm/PKGhPQ2ozNOAxRxmqDmKzCL3yV/WKPFRtivIy+pdT08z3vKir4ZLAeeDFGo97nfunHXQsIuIsso5SXwNUuEPFBTE6cKql1D7p5YfKJ8EGccOS2lGNVxahjI2db7Li7gwAr6LOphbnRROEPO9T5JUAflMv3V7qee6CN+GmXPSH/BDCoJSoQS2du+udX2MdCPahZzmZC+P3pnmulAUMZeKybD8hXjObdEqVHgWess44M7Ub3iTooJLXFbVnn7cTaNkd88bHmDRV05ZNvLFuKKzvtaTzTLZ1y2kYw36Ew5G3HZ5DGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dm08ut3arInLzHaqrK3Ta6LqTHEsX5Q/lM48yH6R0Sg=;
 b=TGQ1+4FI8YklLY1Eh6CCFiE5wQO5b2olbTRw2Zvi4HFBvaQhA8FfkeprwJ+GKeR1rKxKr3YHpeCL2uBGz23ruvarnqPEZfhZhGQD8LdRpkTG2Uy+cr1aB9fT1A8OQFRpG2gKUV8vo8eowMryacRgK6klnVsWD4c5DF/cMPc7h91oO88mvBW0UTj+YdcPGntRVjRT6e/1HhMrVtl637M/lU5ZjhIS7n0uo0Lugkmmj9KnwCc2m0G6lvm65RMzj+YBTYG2dv39FkKLFoDWexdr+/u0C+xxqBpJQpx3AjOrT/78JWaasJPcqFdAI34EsDEpCW6jrV+L57rfdqrN6DPWIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dm08ut3arInLzHaqrK3Ta6LqTHEsX5Q/lM48yH6R0Sg=;
 b=sH8semtpPJPYQ9nMEhaiDJzA34T9IJAu3olecE7slntN4/u1NilNEt28sq8tla/bK2xeGaWAx80NlH+AW32WUmRMQ50r/cGLJA3CawtsQA0XlTzsQXmdgo4wP+9cS9u1gnoZeKK9hZZ70cVRmonoJxm7w5wZytK6y2JJl7E+j2o=
Received: from DM6PR02CA0064.namprd02.prod.outlook.com (2603:10b6:5:177::41)
 by CH2PR12MB9458.namprd12.prod.outlook.com (2603:10b6:610:280::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Mon, 23 Jun
 2025 09:52:16 +0000
Received: from DS1PEPF00017095.namprd03.prod.outlook.com
 (2603:10b6:5:177:cafe::48) by DM6PR02CA0064.outlook.office365.com
 (2603:10b6:5:177::41) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.29 via Frontend Transport; Mon,
 23 Jun 2025 09:52:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017095.mail.protection.outlook.com (10.167.17.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Mon, 23 Jun 2025 09:52:16 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 23 Jun
 2025 04:52:13 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>
Subject: [PATCH v3 07/11] drm/amdgpu: add user queue vm identifier
Date: Mon, 23 Jun 2025 17:51:50 +0800
Message-ID: <20250623095154.1150830-7-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250623095154.1150830-1-Prike.Liang@amd.com>
References: <20250623095154.1150830-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017095:EE_|CH2PR12MB9458:EE_
X-MS-Office365-Filtering-Correlation-Id: f1d28084-c2bc-42fd-558d-08ddb23ba309
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fHUFXmSNph/Zi0kAjOHn+Smtp5XGu/+EWmEPq/cg8ddTXSfTXkFLjdLSUB0W?=
 =?us-ascii?Q?mp7ID6CfXWURkxOC11Ho2tluN24u+ITmBMRo52pD7P9q4auwMpbV/NqeHBW6?=
 =?us-ascii?Q?vfQSim+SIuqZuyvvTB7wD2PX7fyz9lSaOwi2AulIn2nft6a3SmfTtVcAF3e/?=
 =?us-ascii?Q?oO7LbI0qrdTKt0PW4kzLWBe4OfwdwoSSSAa4ra6CfW+efAfXhA+C7LzyNF6f?=
 =?us-ascii?Q?Fy2TPzVCzjlr/9T/ClX4qJdP8dP0ZTqqLlO020ayJgErylX04mx0ugfwmNim?=
 =?us-ascii?Q?szPj2pPyv031ITXZUnKGxNZRWyvuQEidzXizzH4LHPJujrA6azP7PfJXmAV2?=
 =?us-ascii?Q?/ZbjItTbW0SpjE6nhdgkHLHCcrjeQcqLptZzJBPg5/D5qIIiB3psUPTdFp1T?=
 =?us-ascii?Q?BeiGhlNQHqXIwAdsZOrxfGNLLcZ6ISoXR/JUez6OKHZJ2aVJ2YBad8+1tCRu?=
 =?us-ascii?Q?uVQKTEx5BhykREZyomTJxPH1asMUh5zjvMVh8mX7Lb/MW0jQV3Mk0bndwx8O?=
 =?us-ascii?Q?fVk4cjkLsCFur6tvwO3nTanwvrA3ca9FMK5zNM/DWWeyZUXsGIjb54I3XKLS?=
 =?us-ascii?Q?kDfiKod2nv9F3lWdCGXzbpb7oaE0REQXQkz7F6e4rEqqZQ4J//iPZ0hgDZW6?=
 =?us-ascii?Q?6uctou2bfTGNY5eCUl4RjcLLKjqsV2bH3ALf+gvijBwtoHMaHUUj8QXLTWEh?=
 =?us-ascii?Q?Ua8GX62iNFTRCrDUQzNqErxztldEWkv5kzdGQkVspizNTd5OzKKCwAPoOXMA?=
 =?us-ascii?Q?aihIi3EmlT6JbjKC/SWx4WYJ3aWUKrJSrA7PcgvIWDmZa08nRR8AQjU4kjls?=
 =?us-ascii?Q?6F5dx63mdfgD7S+d67uymE7FevjMAW12IhHexzeAhQG/Wb+bLtJtJXHPeQAU?=
 =?us-ascii?Q?AayGR3So2dmMQ6sbWDIw1mKTk2zHvRRH9/DmEEOrXZ+6I5FfC+9+jQlqrbeT?=
 =?us-ascii?Q?a2ycAn8t6Xp3bs439z4AkOUrkEWDevwLUELXWr7d2cWzc2Z4F6rxMeYK9rgi?=
 =?us-ascii?Q?i9Ddf0mQZi88yyiQTkyRuFkpAe9o3QcLSVNhxUJwgefqZ2JqdZ6XVUfpLMtl?=
 =?us-ascii?Q?JU86SSNYDAICsmL3nAoKaQO+z9LAQGIDs+Gk5MKE8YTQAXYF18PwOaOMmHRL?=
 =?us-ascii?Q?d2fJ+WkZcfqg2zdat6SnKQJjiFbq5wubHHnM2r70oB9+jK/RuFzaJ1s301je?=
 =?us-ascii?Q?5Ybaxt/8Bm2r1sS09/ccNJVvnkXRROOGoYY6+6AoAhXElZfbPhBKnXHZpJGI?=
 =?us-ascii?Q?oZd9JUtvfwW6z0H4rAbI1REhk2nNyEGs/xySGolxEPpv15qjsuJrf41nWTpg?=
 =?us-ascii?Q?9f2y78Luj9b0xelUf4NHzKnxTh449gDlJFq+Zb2NtNM4qIltmKB3HUP4NXIY?=
 =?us-ascii?Q?AWElLjPUYMJWAloadCVBuwtFdAa0DFQdwu+PsUQbbX98TPBM+pX2bc2GgR7a?=
 =?us-ascii?Q?ivmynaGIf+tN6BzTh93oepIf62n/usYw2LmUP/oUEEu+6ol0tw51x1/0xsmq?=
 =?us-ascii?Q?vs3hGNdLHBrg/Z1S0JlDt5a+21+mu3FsvRFV?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 09:52:16.3776 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1d28084-c2bc-42fd-558d-08ddb23ba309
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017095.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9458
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

Add a user queue vm identifier for each userqueue
kms opt accessing.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 4 ++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h    | 2 +-
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 79b263c18eb1..0208c6b8a8e0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -501,6 +501,8 @@ amdgpu_userq_destroy(struct drm_file *filp, int queue_id)
 	pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
 	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
 
+	fpriv->vm.is_userq_context = false;
+
 	return r;
 }
 
@@ -535,6 +537,8 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 		(args->in.flags & AMDGPU_USERQ_CREATE_FLAGS_QUEUE_PRIORITY_MASK) >>
 		AMDGPU_USERQ_CREATE_FLAGS_QUEUE_PRIORITY_SHIFT;
 
+	fpriv->vm.is_userq_context = true;
+
 	r = amdgpu_userq_priority_permit(filp, priority);
 	if (r)
 		return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 3911c78f8282..5e075e8f0ca3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2560,7 +2560,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	ttm_lru_bulk_move_init(&vm->lru_bulk_move);
 
 	vm->is_compute_context = false;
-
+	vm->is_userq_context = false;
 	vm->use_cpu_for_update = !!(adev->vm_manager.vm_update_mode &
 				    AMDGPU_VM_USE_CPU_FOR_GFX);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index f3ad687125ad..1e3c0f85c98e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -422,7 +422,7 @@ struct amdgpu_vm {
 	struct ttm_lru_bulk_move lru_bulk_move;
 	/* Flag to indicate if VM is used for compute */
 	bool			is_compute_context;
-
+	bool			is_userq_context;
 	/* Memory partition number, -1 means any partition */
 	int8_t			mem_id;
 
-- 
2.34.1

