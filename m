Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E67DBCAC582
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Sep 2025 08:49:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6EB6310E49C;
	Mon,  8 Sep 2025 08:49:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="o5TQXnBR";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2069.outbound.protection.outlook.com [40.107.220.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D3F910E498
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Sep 2025 08:49:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gXv5bXPEdB6QPD+11zZtELK6LYK1K9edOqp0Ze0LOiCP1V4HkR2MLB5Y+fqHzodnRm2szWb2zjaBPeMZ4qwvePgLaayGY+uI1Fgd3W3K/Ev3vu2VPA27jAVct3HB5lIeNQQhr5c1XeIaNGWca2qdXh1fXiiEDSSAUSuR3sJZEDS8tqJgbEy7xu+ZlOos/72ZUm3V7alpSyUtFcb7EpX/CFaULETz/jNiiiH00HVZlikoASdFrmBQmd6bnR602xY95EdWBM5Y4Qr7EhzQ239cFbkwskDVThEP/EqrllFtppYliEfVX+IPveKME59x2HN6+jvhkhG7NQ2KzNGP5pHPyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D4Lslb8+H3F1ZxA85gTaui1s/JR0H1aEdKCeXZQh2II=;
 b=uTFa8M+DMWdm8XpUaV1rjetIhk5OhObMpc3+RByZvyUbKVl4T4X+bPS2xacdurs0Kot7y9rC3eJoITt6uUCMP3nszeMKPvmY75bY5+5cTRcRH5UFrd/4SG1BoiGRIW52YFo5CtQWEef2geRP0zJ5+83Lyx8PcCoArVqwkboS16yfD87Ww7VEl4dr+slO/Xbd1E+0JAOSlHJZJjRG/EDZOqp9mHoVxLdgxs/2/tUu2oPyhmqMS8XlP3fSVO1Enup9gf+O20zM/U7bCR+Xp7B6KUM0fAvKpdMPsM23eBIGEm3KO6LJOeXFKQ96aszXkmAPe62MVTR0Xkczie/KSwbJlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D4Lslb8+H3F1ZxA85gTaui1s/JR0H1aEdKCeXZQh2II=;
 b=o5TQXnBRcYEsJ38gGY5aVVhWA2DjfCDx9mKss9zHQqLf/6HsN8nnymrZTa1CFrjs/w+kwHqABqsroMZo8N9lbHm6C25ro4nVSA4S3IFZpbYitI8tCKlcO4EdcsNc3dUD2VkOR03RMT7JgBObK8FafBtXaQvTR5GKUs2H44//dHM=
Received: from CY5PR19CA0078.namprd19.prod.outlook.com (2603:10b6:930:69::25)
 by DM4PR12MB6159.namprd12.prod.outlook.com (2603:10b6:8:a8::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.19; Mon, 8 Sep 2025 08:49:28 +0000
Received: from CY4PEPF0000EE37.namprd05.prod.outlook.com
 (2603:10b6:930:69:cafe::87) by CY5PR19CA0078.outlook.office365.com
 (2603:10b6:930:69::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Mon,
 8 Sep 2025 08:49:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE37.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Mon, 8 Sep 2025 08:49:28 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 8 Sep
 2025 01:49:17 -0700
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <christian.koenig@amd.com>, Prike Liang
 <Prike.Liang@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH v10 12/14] drm/amdgpu: clean up the amdgpu_userq_active()
Date: Mon, 8 Sep 2025 16:48:44 +0800
Message-ID: <20250908084846.1873894-12-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250908084846.1873894-1-Prike.Liang@amd.com>
References: <20250908084846.1873894-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE37:EE_|DM4PR12MB6159:EE_
X-MS-Office365-Filtering-Correlation-Id: 40e2d9fd-47ea-4a53-845c-08ddeeb49eeb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qqz2s7yb3w0I8OKV9LOZbKLnCas5HUMpAtV+SBgfq0V+nFwtOys3ua0mYcrz?=
 =?us-ascii?Q?HZ7cCoPKEaaZSWOEr+gUb6ENnolM41zcLDUE0t6tBDTPTVKbElQnsBVjkIqc?=
 =?us-ascii?Q?94GzuKnigM+oJcoP+bkFNYI706riC0gPEfxrUUUhsgAzQLoeiuK6s9ycqAnU?=
 =?us-ascii?Q?upFcfcVe47AEwSTfl+JWJM0GdKR9kEPgT15heNbT8HxlZUyKRQcK3N5H3MHQ?=
 =?us-ascii?Q?NphhZh9pYSX93Ic4nK9RwuvVM8EpDZecv3evDgbZirQ1tvTaTsRybWt4LXq7?=
 =?us-ascii?Q?ddlE0FKhja+VANmTeKBNwfIxtFhVNyY3jNImJ296PRHrtK7X7jK1N4ncJsN6?=
 =?us-ascii?Q?6CdUCBNNUTvXacFnev18rKkar3K+ifxW6+qZIS4HwuyZY98HCy1dqvDacm27?=
 =?us-ascii?Q?Ttjx2Yx8kUi1+UvzrejHfqasPpL4Tobjneh+0U3GO/908DHSMiRw2NRs2EeK?=
 =?us-ascii?Q?K5UrsXR0l3FnMQgvlwIvaLZMoZ1r9Bqto4s/of2RJDuDgqqPN+RBjd1aUNCw?=
 =?us-ascii?Q?fSkB9kb4lJzqZtOoSCB5IiQN5V2lDjxj0EryrC99kAxQzuaz6sce3gQCBLhx?=
 =?us-ascii?Q?8GU/LH6v2n8ygvYhi0ZGuWsXiv4bvvic1jL6uk1JoCTb3H9BxZDvRmNjIrEs?=
 =?us-ascii?Q?WHx9GnOH+a5X4yNTdnY654oUgu8zx3TMX3oIIUCeTrm+8ryg3Kto9KGR3GnB?=
 =?us-ascii?Q?m5qwoloh1y0zDbGdz5xLBPg+WGpwWnCWgmJbfFVbXGrH21R5FqG8yRDukqs/?=
 =?us-ascii?Q?Kzd2HMRGf2XhbHmH/88E69fyryYFQ92E8PSf5JVbsASURxN7IPO0U1KqCVbX?=
 =?us-ascii?Q?M2wAqNlJ0olIU+Ni/79cx5Dv5S/ZU/zanNfOzRCu15jUY52eGLrGlh47ILlb?=
 =?us-ascii?Q?5rtDOTTIU9yOSAf5qJhHgKTGYNUd6nc9ufeAIpvge56xztNgP37weoF44PtC?=
 =?us-ascii?Q?sRP6eQZJROlug9V2rdfkzOGRyjAAY52jg4Jr0v/4PLLCy/wxEuOki4rGuTDF?=
 =?us-ascii?Q?p/LJnme3KQrLlRnTVrwFIHbW3fKukMuxyRS8VXz/T4U3DQTYL/edljGyDFfN?=
 =?us-ascii?Q?Hiz+ZIDLtF2B02Bn4L5zaH0p1rkcj4ZKYXNkbu1BlE7E8avvBgfNS1ILCJZe?=
 =?us-ascii?Q?HwcAEMGaQFTt42aVqo1L72coU7FFmFmto5x5X3UZLXrbxXcb0gPdrBuMqEh7?=
 =?us-ascii?Q?BIFYQpWFTkLJQO7caizViukVcKER5KDVnmK2DOxKsyk7gUsF/B3lIR1nj6rn?=
 =?us-ascii?Q?l6wXgf3kja599jECkQjc+vJFriO9/3rO5Ht6hmAjOmJbMLCyPUNdFYQSYbga?=
 =?us-ascii?Q?mtm6wq9cPDOThyl8auCF8v18jvg6CuzLJZtpRQxqF2fLHu3bhP1h2jzml2Zz?=
 =?us-ascii?Q?mgqRujs/VQU0Pms7G7YHUQzvIoyeyFvVE2q1d4aI7tpdoRoie+XvGKA0xH86?=
 =?us-ascii?Q?hnQf66lAsTSoxfye1XIznWKnSCMchl5W4kDhTYeLyx+MUtV7NW1zFSxh+XAM?=
 =?us-ascii?Q?ueXnVtDJvCCQgYx5Z6xtSMAf9ScKRV02nfaJ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 08:49:28.3360 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40e2d9fd-47ea-4a53-845c-08ddeeb49eeb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE37.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6159
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

This is no invocation for amdgpu_userq_active().

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 16 ----------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h |  2 --
 2 files changed, 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 3b62675a4ee3..ed4067df12cd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -319,22 +319,6 @@ amdgpu_userq_cleanup(struct amdgpu_userq_mgr *uq_mgr,
 	kfree(queue);
 }
 
-int
-amdgpu_userq_active(struct amdgpu_userq_mgr *uq_mgr)
-{
-	struct amdgpu_usermode_queue *queue;
-	int queue_id;
-	int ret = 0;
-
-	mutex_lock(&uq_mgr->userq_mutex);
-	/* Resume all the queues for this process */
-	idr_for_each_entry(&uq_mgr->userq_idr, queue, queue_id)
-		ret += queue->state == AMDGPU_USERQ_STATE_MAPPED;
-
-	mutex_unlock(&uq_mgr->userq_mutex);
-	return ret;
-}
-
 static struct amdgpu_usermode_queue *
 amdgpu_userq_find(struct amdgpu_userq_mgr *uq_mgr, int qid)
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index 39d9bc6fc47a..27066906526a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -122,8 +122,6 @@ void amdgpu_userq_destroy_object(struct amdgpu_userq_mgr *uq_mgr,
 void amdgpu_userq_evict(struct amdgpu_userq_mgr *uq_mgr,
 			struct amdgpu_eviction_fence *ev_fence);
 
-int amdgpu_userq_active(struct amdgpu_userq_mgr *uq_mgr);
-
 void amdgpu_userq_ensure_ev_fence(struct amdgpu_userq_mgr *userq_mgr,
 				  struct amdgpu_eviction_fence_mgr *evf_mgr);
 
-- 
2.34.1

