Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3A17C5B549
	for <amd-gfx@archiver.kernel.org>; Fri, 30 May 2025 07:55:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72F8210E7F2;
	Fri, 30 May 2025 07:55:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vkEi+8r6";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2077.outbound.protection.outlook.com [40.107.94.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E6D510E7F2
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 May 2025 07:55:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D41/a+Keq4UPMdCJiBgXw0tWyEhO1sZTbIQ9B99gxzL4g3013wFOXyOLyOqy1ZY9aww+HpU4wk8xHK6WujukRYnthosds1T+PELaEND0efe3sYh21eQ4VMgRXsQdpPCdSrBDtohxLk+z3kTCA+uikWt7RwsultjfHLFKh1PMkgrC88dOSqc5/lXMvUYvYqfqiGvFQBrGcP4PZxKEZUcanTmQXg//G3sfsPPgC5ig9ru5Aq9I1kg0MiLKAc+KXIcgWyq1A/dVq5KERFsZnv5F1JtYO+RPbW8Qt80RNiLLim3L4DuW89mKXkMt9o8BTCan9P/OiH2XVSfK2UskfRirkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wX7PKmYpDJQAv8y4aOZ+oEHAf5bItfK3qU+d0mDlvFc=;
 b=NoGEoNTu90Am4cBHPnn1zxIk0V1ZVYVhMtAzxomMmd9t5KzN1dUsKoQTlk1tUVQqKyoDp36HzJp9x4DCNxhB4jvnB4sU7ZQOuVTECAw9d7L8hKCGK/EmGZSqyl1b0PMgpJNoAgS/TM2P5C4PhHT+g+zOWUIfNmOw8FFbQf3AreaajxhKphSqPhIisADCmsrPAaskQyV6VuFeMwWC/9ignWx/nGMIuxGFfVMjGQ8IUCAU1KChv0ehQguUfRahbUoyW5Hc86Qr1UehJsIZB9o8Vvk2pNGxww90kmv3Hd6L0bn0zzL4wYBGgKQetaq81qlxyknficoMJ/sJW8KjCqq9PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wX7PKmYpDJQAv8y4aOZ+oEHAf5bItfK3qU+d0mDlvFc=;
 b=vkEi+8r6KbRTsxkm3P8QspmS266Os/32kflJ+8LR7hnRdNwBRO+Y+FBZaeEYfA3xZ1TGz5hbvdPQODB9zkO5GO+KIH6rHr1i4hwaC+R4lYE/zX7poQFb3fbtnv1WFk1bSdnVwKAaXpQrh0pGHHi+wGCFmx96zyrIxfIbyfz0gw0=
Received: from MW3PR06CA0017.namprd06.prod.outlook.com (2603:10b6:303:2a::22)
 by PH7PR12MB8123.namprd12.prod.outlook.com (2603:10b6:510:2bb::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.30; Fri, 30 May
 2025 07:55:28 +0000
Received: from CO1PEPF000075F2.namprd03.prod.outlook.com
 (2603:10b6:303:2a:cafe::ec) by MW3PR06CA0017.outlook.office365.com
 (2603:10b6:303:2a::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.18 via Frontend Transport; Fri,
 30 May 2025 07:55:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000075F2.mail.protection.outlook.com (10.167.249.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8769.18 via Frontend Transport; Fri, 30 May 2025 07:55:27 +0000
Received: from prike-code-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 30 May
 2025 02:55:24 -0500
From: Prike Liang <Prike.Liang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Christian.Koenig@amd.com>,
 <Lijo.Lazar@amd.com>, Prike Liang <Prike.Liang@amd.com>
Subject: [PATCH 6/9] drm/amdgpu: track the userq bo va for its obj management
Date: Fri, 30 May 2025 15:55:02 +0800
Message-ID: <20250530075505.882004-6-Prike.Liang@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250530075505.882004-1-Prike.Liang@amd.com>
References: <20250530075505.882004-1-Prike.Liang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F2:EE_|PH7PR12MB8123:EE_
X-MS-Office365-Filtering-Correlation-Id: 7223cfba-ce49-4dd0-4694-08dd9f4f579d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xKzL4Ah7B4jrJB/OrZ/EKGQ26J/UG1diAGqRplPYHUfV5HnZPpWTLD8TuxwX?=
 =?us-ascii?Q?/ajy48GOR+vIFFzbr3TI2eYI6LB/Ey7eAc2Q930zWDUW6vWqkWpWVN+9Z23t?=
 =?us-ascii?Q?GRamxx9c/wzXtUI4S4bsUgBRb6OGTXOpXhDrPBx2jfR0PSa5aMSmi7xtb6RS?=
 =?us-ascii?Q?TDdPmed8/XUiFkCmligMnDL/Fw32r4/OgO7A5IEDjtR81ilcdOYMYUDcJJST?=
 =?us-ascii?Q?2J/FPyLQVj/zs99jPS3XQEnfZZbNAnG4uSiKpBQOP4oQ6DkT/zDKqG1MHRS4?=
 =?us-ascii?Q?I2TDe6qDGd6HnctLHGZkJHeRGkiwOFRiAHtrJahmp9hKBHyEmP9cBbBYDSCv?=
 =?us-ascii?Q?m1YtEf5r4pKitYk9uhiYU4ZpszYVyDQHyYJEZYfYD2jhqTgjqFczFAOrchPn?=
 =?us-ascii?Q?NnzwiLKMi5kohwQ95/BOKvBEOnmtvW/F6GGdedHpuDHQD5aVgA0CuQuUH2ja?=
 =?us-ascii?Q?bz14boEAu4GhUMoVQPBvLC7I+ijsjwdkJFXMiA2zDLxFEq4Wx/00XvdX7w9/?=
 =?us-ascii?Q?K6BxLar1tlmGJybibZ8i+UtG7bv+2YOo5U0YSBUwNYWd39a6QFdsRNqrGXlJ?=
 =?us-ascii?Q?KOz/UvsEJ3vYsVHtMLXGZqYsBPYbTaAsOq0QntqPgiCRf3oMoxbuNestEX2N?=
 =?us-ascii?Q?4SZ1JfJZBBWPQrfzL+V9eeo+z3XloQZbzMapUk9oJ7swwX6Ql6XwfMlawXgt?=
 =?us-ascii?Q?jRz47nB/3VAqydDo9txDYvZvsE9mNx8JsPILKojJvArbItA2ERE+tCFoNjfw?=
 =?us-ascii?Q?BCVBN5dXfdIT6LHJstkCyVGIvl2h73gwz6K9eTO8urOQkUX3GBzlhduzqXrL?=
 =?us-ascii?Q?tP7vEHhgDuiPeZn4ocpl0vAwuwyRroS7PixQzr9NHH3HBHBuT6g20pZ29Eqw?=
 =?us-ascii?Q?oNPatxuwep03ahCKE4aoXZghKtgbIvsibLEzO00ik4GbqtNAh5QB8h5Z1xE6?=
 =?us-ascii?Q?rO9dwKVof9IxCRyAHgQC6TpyYpuGFK++ffp60vSkB8217b0YpBSdNYZtuwjt?=
 =?us-ascii?Q?SLe0iAhCaS+et80vlmVDVlIh2aNXTDpGeJEZVZxi4naaNkPDfCeJwnOK4r5K?=
 =?us-ascii?Q?2w+WPv1+WTc1vSZ4awnD5IUsSLLQA05egXzHXHkCaWdKvTsgz2GdvKtLM4ds?=
 =?us-ascii?Q?N/yph35g9HVZ2mKRLmCUqRkrsZqIeMBxmBY/l68BoZfAAMcY7AKQXk33y2qK?=
 =?us-ascii?Q?wSwbgIHb68C8xK+waPj4UcUSU2N55Ixo3Hqvhp//LYxz5J5x25wDew0Ht7H/?=
 =?us-ascii?Q?I4dAIGnko7PwlxbgmbwIQ2zrgP3CBUqu5LBOnYCLbmKfi+6QYE0wPuYNQwOp?=
 =?us-ascii?Q?TdHOInJ4d0qJ99Zv+KQJ0k+4Dk9024fSyeZgqwpNEw7LWni5AcfX2gHhWJfI?=
 =?us-ascii?Q?YH89WLsig24l160IURXRpfxN/boIbrvGK8YO/Ja3x5VQlVhpsjuAR8yRHB86?=
 =?us-ascii?Q?mHVRWeEUu9eLG8KazcqFjHlTMdVKb3cijF8ATcZSVllu+sr814+VbeVR+mco?=
 =?us-ascii?Q?K+YSZVb0pJV4BInvojnKBOCQs6/t0rq5vCha?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2025 07:55:27.6133 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7223cfba-ce49-4dd0-4694-08dd9f4f579d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8123
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

The user queue object destroy requires ensuring its
VA hasn't been unmapped illegally prior to the queue
being destroyed. Otherwise, the kernel driver should
report an invalidated error to the user IOCLT request.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 3854b1696d4d..6267993deb8c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -470,6 +470,17 @@ amdgpu_userq_destroy(struct drm_file *filp, int queue_id)
 		amdgpu_bo_unpin(queue->db_obj.obj);
 		amdgpu_bo_unreserve(queue->db_obj.obj);
 	}
+
+	/*
+	 * At this point the userq obj va should be mapped,
+	 * otherwise will return error to user.
+	 */
+	if (!amdgpu_userq_buffer_vas_mapped(&fpriv->vm, queue)) {
+		drm_warn(adev_to_drm(uq_mgr->adev), "the userq obj va already unmaped\n");
+		mutex_unlock(&uq_mgr->userq_mutex);
+		return -EINVAL;
+	}
+
 	r = amdgpu_userq_unmap_helper(uq_mgr, queue);
 	if (r != AMDGPU_USERQ_STATE_UNMAPPED) {
 		drm_dbg_driver(adev_to_drm(uq_mgr->adev), "Can't unmap the queue for destroying.\n");
@@ -477,6 +488,8 @@ amdgpu_userq_destroy(struct drm_file *filp, int queue_id)
 		/*TODO: before return may need to a reset*/
 		return r;
 	}
+
+	amdgpu_userq_buffer_vas_put(&fpriv->vm, queue);
 	amdgpu_userq_cleanup(uq_mgr, queue, queue_id);
 	mutex_unlock(&uq_mgr->userq_mutex);
 
@@ -600,6 +613,12 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 		goto unlock;
 	}
 
+	/* refer to the userq objects vm bo*/
+	amdgpu_userq_buffer_va_get(queue->vm, args->in.doorbell_handle);
+	amdgpu_userq_buffer_va_get(queue->vm, args->in.queue_va);
+	amdgpu_userq_buffer_va_get(queue->vm, args->in.rptr_va);
+	amdgpu_userq_buffer_va_get(queue->vm, args->in.wptr_va);
+
 	qid = idr_alloc(&uq_mgr->userq_idr, queue, 1, AMDGPU_MAX_USERQ_COUNT, GFP_KERNEL);
 	if (qid < 0) {
 		drm_file_err(uq_mgr->file, "Failed to allocate a queue id\n");
-- 
2.34.1

