Return-Path: <SRS0=Rd3N=H3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B400EC433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Feb 2021 05:28:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 473E064E83
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Feb 2021 05:28:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 473E064E83
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D5FE76EC40;
	Thu, 25 Feb 2021 05:28:22 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2084.outbound.protection.outlook.com [40.107.244.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B1C66EC40
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Feb 2021 05:28:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W4CNWj41Jq7b8hxDh+YuAG5k4GiKBeeVqLazjKopFX8gikxg6c+ymDiRy0l/RkGfQFNU+kKrmS6U1xAvNPUADY2d/WyNoLGa1AsneA2m1ul8rkReIonRD5iAIRgbQDS/f0GUBNE2/K1fph5qq1jUo6ONpAGGTXwJJ6aDLdrDrfqC0tFoTT1RoH68ocZSdooUHxqBYvvnfeAy7xbi9oVYXe/ISVpG+kD7Gjkf2RNVcGn1aUN9icqyYzSd85ysV4tgaWMEIFHqTqlxHbdtKhncPd+w4xoyege4OgBvSrFKTyr9Eloa9Y6WElUufUpO4mjaES4NCOi9Xw6QDYwFPbb21Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kUqytTXcPz7s4bfjYKyTeU356WXoczcLyy6qPEDEHfc=;
 b=LAS7nrXXHOOxXJBc0XkxE4+5TwgAJNLbMrVycZU6WK8x+FMvg1XL/Dx2hOuSkSLLQwZDX6nZPLSSY9HE8XH0dadlWR4yNPYkbILF6twrXWLw5XwLmx/zcZlvBhrDq4nnfZf2zO18JWNYHDA1q6EXSL4viSvhnor02aftRfchEc0f7AC6JvlriJ7D8rBP7p4azJarYBgYYJOvo4yF2AkyYczCXTBUPGfsxozq3yuIQeROuQHv1jdLNklVV03rKfWJp1FJSkEDeZ//fCYo83+776fnJggZm6PtZWnIz5OLlLtApGL6B6cNn6oRWjXzwS//F67apYDg3w/ItkQRL26eTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kUqytTXcPz7s4bfjYKyTeU356WXoczcLyy6qPEDEHfc=;
 b=hwyP6BtT2qs/PAWSzqLQY9pxoji2eJqYIlDd04yNfJ6ptIuwWzR5EzGlSrvywWJZk1eTIYh143FHuNMlCcpDlg3bo5WvvPLKixnLGcU70QWdTcuPyqsHzJPiwHqJyxp4M2u73r0x/CuONUEgtuGVWhm1ohxbYBL3QkDjrkBUkVk=
Received: from DM5PR19CA0049.namprd19.prod.outlook.com (2603:10b6:3:116::11)
 by MN2PR12MB3215.namprd12.prod.outlook.com (2603:10b6:208:101::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.27; Thu, 25 Feb
 2021 05:28:18 +0000
Received: from DM6NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:116:cafe::b3) by DM5PR19CA0049.outlook.office365.com
 (2603:10b6:3:116::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend
 Transport; Thu, 25 Feb 2021 05:28:18 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 DM6NAM11FT064.mail.protection.outlook.com (10.13.172.234) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3890.19 via Frontend Transport; Thu, 25 Feb 2021 05:28:16 +0000
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 24 Feb
 2021 23:28:14 -0600
Received: from wayne-build.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Wed, 24 Feb 2021 23:28:13 -0600
From: Jingwen Chen <Jingwen.Chen2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm: add a flag to indicate job is resubmitted
Date: Thu, 25 Feb 2021 13:27:24 +0800
Message-ID: <20210225052724.36412-1-Jingwen.Chen2@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 29229d17-be49-4a75-5f5a-08d8d94e2772
X-MS-TrafficTypeDiagnostic: MN2PR12MB3215:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3215AA64A74E4AF32125D0CDB79E9@MN2PR12MB3215.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:411;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: biAHJggL0ovBRj3o75lRocDODuvPKTLQ5xuVw3PSal+v414xaRSVo6FL6GyN6hOFY3kjRrH2q5Bqyw7r0yUqai+QynZA5Yz/rlmGSIKvCtLOmqsuRlcDtgASzo+4eOHTybIvo2Q5p5LY0GfGbjC+h5qjbfJevhy7JIMlF0h2CCsxJzeU8IfsumSE9jLFjSvXWTIVoVS2OGpyXabQBo/HW36lBIZ/391PLBfg9xNKFkh9f5J88ZJaaeQ2HUBdAn+cgs+Fq3v0iBzUoOoml/zYipr9N3CH0bVO4uVD5wgV5HZpzxuhETkPVgJbBIVPezA5WHXOYXeesV+Gsv3Hqow2tMW+0bc/sgp+bZsGKyOcYJA613eXOBSDZiB98aSSD4zxgX+nvdMbCdhq/FIzk8GwZwqlx8f4vl0M0tXLoPMZjut740fccQ0FyLwzV3ET9bJBmQ7dgoajEGoWabiWmtA5xY2gV/U2HY7lxL1FhvanTzD7IC8YjUct01oYaLgYRJe+/7px+rH1NhbaOv5PsGuJJjorzOQ9Jdi9yqxeRGwSWgEMIx1UiYR4IDJj4uEijwM2M0pXUo89mHaCgv30FRDFQqsnF3XDA8tvhiUUQt9bkxrhcOqVC7PdNlzxMW1J7XOwIIwO/6slNczWYJZvpfPZfxl7WWFk0eOB36oaULLGwVrCURB6ANehIDQLLk6hCM3F
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(376002)(136003)(396003)(346002)(39860400002)(46966006)(36840700001)(316002)(36756003)(54906003)(1076003)(356005)(26005)(86362001)(7696005)(36860700001)(82740400003)(5660300002)(47076005)(8936002)(70206006)(4326008)(70586007)(478600001)(2906002)(6666004)(8676002)(82310400003)(426003)(186003)(6916009)(2616005)(83380400001)(81166007)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2021 05:28:16.4529 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29229d17-be49-4a75-5f5a-08d8d94e2772
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3215
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
Cc: Jingwen Chen <Jingwen.Chen2@amd.com>, christian.koenig@amd.com,
 monk.liu@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add a flag in drm_sched_job to indicate the job resubmit.

Signed-off-by: Jingwen Chen <Jingwen.Chen2@amd.com>
---
 drivers/gpu/drm/scheduler/sched_main.c | 2 ++
 include/drm/gpu_scheduler.h            | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
index da24c4e8b9fb..d59ac90f5081 100644
--- a/drivers/gpu/drm/scheduler/sched_main.c
+++ b/drivers/gpu/drm/scheduler/sched_main.c
@@ -517,6 +517,7 @@ void drm_sched_resubmit_jobs(struct drm_gpu_scheduler *sched)
 		if (found_guilty && s_job->s_fence->scheduled.context == guilty_context)
 			dma_fence_set_error(&s_fence->finished, -ECANCELED);
 
+		s_job->flags |= DRM_FLAG_RESUBMIT_JOB;
 		dma_fence_put(s_job->s_fence->parent);
 		fence = sched->ops->run_job(s_job);
 
@@ -565,6 +566,7 @@ int drm_sched_job_init(struct drm_sched_job *job,
 	if (!job->s_fence)
 		return -ENOMEM;
 	job->id = atomic64_inc_return(&sched->job_id_count);
+	job->flags = 0;
 
 	INIT_LIST_HEAD(&job->node);
 
diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
index 92436553fd6a..a22122f98c9c 100644
--- a/include/drm/gpu_scheduler.h
+++ b/include/drm/gpu_scheduler.h
@@ -29,6 +29,7 @@
 #include <linux/completion.h>
 
 #define MAX_WAIT_SCHED_ENTITY_Q_EMPTY msecs_to_jiffies(1000)
+#define DRM_FLAG_RESUBMIT_JOB (1 << 0)
 
 struct drm_gpu_scheduler;
 struct drm_sched_rq;
@@ -198,6 +199,7 @@ struct drm_sched_job {
 	enum drm_sched_priority		s_priority;
 	struct drm_sched_entity  *entity;
 	struct dma_fence_cb		cb;
+	uint32_t			flags;
 };
 
 static inline bool drm_sched_invalidate_job(struct drm_sched_job *s_job,
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
