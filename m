Return-Path: <SRS0=r7JW=B7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 394ECC433E1
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2020 08:57:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1E9C207DF
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2020 08:57:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="zjGGe5zY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1E9C207DF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9191F6EAA1;
	Fri, 21 Aug 2020 08:57:38 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760079.outbound.protection.outlook.com [40.107.76.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41E376EAA1
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2020 08:57:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EcupP5LiRwe6caGmNqnKFgGe0kmyvuBwGaNdLor5K7DMF5QXgODexCKYC+uHABxPhy4O/sM6Um6ygEi3KZYuKHaw5JFBp/hp2iHaW5+bnubl0VbKVdLiI9envfQEyiO9kIsTSeInrvCV1/qP4EB7ogeC4a38olfbEgykVHerusH2gcy4mYE1AZqC6rZrvzorQOuuAfDw7YEQ6vvo9WL1KTerQMDSEb+mfP2EgtxIWPNcCWnVt/H4h9QVyKpfXmiN9V+4rbnEXI6Ffnhj/Cgf0yI2Ppr4CGNUBY8fPqAbtex4tEa2DKX5ixCyAYP6fXA4IU/2fYMsq+g+YNhcHogdFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QoKsCiDW9hHr/W0XUEoOuNwLiodrmXsGOz8aDkRriis=;
 b=e4txSBmYqCil5bjI0R+nFUBP6zG++ETg/3TlFq15qiMAmZOhhPljzYBM/e9PHV2diqGL5uVkSD+5+toEOLIuXKQZB2BrYcG26S3ekAgFfOWmdJfOAAqI5pMwgwg4p++PcXvsPx7CtrJEZP1jJJ/R6cK7ruSYri00ivV/QOmkoywi/KpVV/D8XNjdBaUhGXFWR3sAnbPRCBW98dF7DO11FVGq8Ci0v7A+vXP2K6R32Ypfpp0zUosueWLEWGXXnpmC2OXHC0+whFstA8SMuC2t8KAhqpFsM9g7ddqb+zv2slPL9B5HmiVHjo4g9WX1uwvGWSVL6BqAfPiUiPwF3COgkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QoKsCiDW9hHr/W0XUEoOuNwLiodrmXsGOz8aDkRriis=;
 b=zjGGe5zYwKqiB8vs8IcrcrpmFuI7TxB0RKEkWciHJBlFtYv8PD01JTeJbIrkNl1XRXSRzd0V6f1JgPyG13xHlMojYFm8t0gZO+9gbQczZy5xT6v6oHot6Lg8V0LCWLenCTQNY1jWSuei44Qqcsqd5Jkb9yXKiQUISx6pqv335r0=
Received: from MWHPR11CA0022.namprd11.prod.outlook.com (2603:10b6:301:1::32)
 by BYAPR12MB3608.namprd12.prod.outlook.com (2603:10b6:a03:de::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.22; Fri, 21 Aug
 2020 08:57:30 +0000
Received: from CO1NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:1:cafe::ea) by MWHPR11CA0022.outlook.office365.com
 (2603:10b6:301:1::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24 via Frontend
 Transport; Fri, 21 Aug 2020 08:57:30 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT056.mail.protection.outlook.com (10.13.175.107) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3305.24 via Frontend Transport; Fri, 21 Aug 2020 08:57:30 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 21 Aug
 2020 03:57:29 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 21 Aug
 2020 03:57:29 -0500
Received: from yajunl-gv.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Fri, 21 Aug 2020 03:57:27 -0500
From: Dennis Li <Dennis.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>,
 <felix.kuehling@amd.com>, <Hawking.Zhang@amd.com>, <christian.koenig@amd.com>
Subject: [PATCH] drm/amdgpu: skip scheduling IBs when GPU recovery
Date: Fri, 21 Aug 2020 16:57:16 +0800
Message-ID: <20200821085716.17887-1-Dennis.Li@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d5d932b9-84d2-46e6-9906-08d845b03caf
X-MS-TrafficTypeDiagnostic: BYAPR12MB3608:
X-Microsoft-Antispam-PRVS: <BYAPR12MB3608B84593BDD6760CB4D42AED5B0@BYAPR12MB3608.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:765;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /MFWCcKypznT57WFYr+5Q2VyI37DYF7jgJBg2P43iMhgenVGPr6tMt5AyvRGcOx71Fyl+I8NqPl6x9kMoXO7xqZIoN1ea/x9Z1uvPE7Xbbh8D1t/XXAgUAowK9DxdSgNNxML4clecorJx8jZ8K/qMSRI7SFYsy8NR5nAO2aurs5KEJuMyw+zOSMN+2sMU/NXVAt33ua7NNV4gLyh5jREBmZ0ZSUAbIrNNM+pG5uBlIFETS9erMqMG1+YJka4bdD/vRujO7lf37xe41QiEqStBvyxQs1Ngd+DLUFCiWCIyLaUEQHQc73SQB7/G2Q8MsbPKCJ72cXmW4HD+S+Z92VAe+D2Ng1q5Mf2Osmlr0IZgCfYkHHEsYZNJa40QLnqG+pBJiKEUhCprPO7rfUa0PHqielJrcXH52wyYVue4PkXr2E=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(376002)(346002)(39860400002)(136003)(46966005)(110136005)(5660300002)(6636002)(8936002)(4326008)(86362001)(82740400003)(2906002)(8676002)(2616005)(81166007)(6666004)(83380400001)(478600001)(336012)(426003)(82310400002)(26005)(36756003)(356005)(70586007)(70206006)(186003)(7696005)(1076003)(47076004)(316002)(2101003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2020 08:57:30.6047 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5d932b9-84d2-46e6-9906-08d845b03caf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3608
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
Cc: Dennis Li <Dennis.Li@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

If GPU begin to do recovery, skip scheduling IBs. Otherwise
GPU recovery randomly fail.

Signed-off-by: Dennis Li <Dennis.Li@amd.com>

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index dcfe8a3b03ff..054d7b0357fd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -212,6 +212,7 @@ static struct dma_fence *amdgpu_job_run(struct drm_sched_job *sched_job)
 	struct dma_fence *fence = NULL, *finished;
 	struct amdgpu_job *job;
 	int r = 0;
+	int locked;
 
 	job = to_amdgpu_job(sched_job);
 	finished = &job->base.s_fence->finished;
@@ -220,6 +221,10 @@ static struct dma_fence *amdgpu_job_run(struct drm_sched_job *sched_job)
 
 	trace_amdgpu_sched_run_job(job);
 
+	locked = down_read_trylock(&ring->adev->reset_sem);
+	if (!locked)
+		dma_fence_set_error(finished, -ECANCELED);/* skip IB as well if GPU recovery */
+
 	if (job->vram_lost_counter != atomic_read(&ring->adev->vram_lost_counter))
 		dma_fence_set_error(finished, -ECANCELED);/* skip IB as well if VRAM lost */
 
@@ -231,6 +236,10 @@ static struct dma_fence *amdgpu_job_run(struct drm_sched_job *sched_job)
 		if (r)
 			DRM_ERROR("Error scheduling IBs (%d)\n", r);
 	}
+
+	if (locked)
+		up_read(&ring->adev->reset_sem);
+
 	/* if gpu reset, hw fence will be replaced here */
 	dma_fence_put(job->fence);
 	job->fence = dma_fence_get(fence);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
