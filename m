Return-Path: <SRS0=ovQZ=MN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02F30C07E9B
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Jul 2021 02:05:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4AD26108B
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Jul 2021 02:05:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4AD26108B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 584CA6E845;
	Wed, 21 Jul 2021 02:05:29 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2078.outbound.protection.outlook.com [40.107.212.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2491E6E842
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Jul 2021 02:05:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ld1+QTIeSatKFajcH69UZg6IiNpfqJ7iW6IDPmRfBIJGmks26GKwAvwetK5c61qdjRTwJ8+jbpIP39mnCOQp2LN4ragsd4iN4w7nz4wM1H+O6RzCFAjYJlDt1pqXPtOxCn5QsexbjjBFTItXMYYOI6+ZWqyIuDaFNqqFFNEPsPCtYshTL2YJvL2fHp3rtQ9C0+VLW6J8ogJJ/ZxrGyW1VucuZWRQPDY5+A8zkMyAUM/LhCgw2JDwzsVJcGznKiXB0b4wdNMe6UkV58mkuH33FKx7PkX7e+HTczRuh2ZpQxNkzA4C3owBIYPii6iqgBE6bvIu69rMu4yP7w8Mh0pHLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wQShkWoIoi1QFZbgAIfUxNXEAS+hNyKOllxbeXkD004=;
 b=Vps8jmcmFB7nLXyh+BW9ZjUkUS3ZcCdn1qzviHzpgn8Pg1GbqXR2jxIdTttY//UiF1HmVVP7BFp6axPgVU+d2jvdMCs5EKlHbFfoyutUfUslbFz5vvgYKNmABPvj7f/P+mCDPfHJPv/sv0S4qAShLi5L9ivdj2Y52zIV/Nc+08lrctIK+HlQBYs7xWyBnmVkaKSsprag8cZpdn1b4KikqUX5z8RwJOGT1iB0FZ/qCeBfJeEYDn3JQKhSLq0G/9YGGiSFWVvwDj9BsG87EgDpbvu+ZIKDzCbFDsPJmml8DWQfBZBdqp/ktVR4x8HC1Uh8tR+10znZqtkNpuNmhIwwlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wQShkWoIoi1QFZbgAIfUxNXEAS+hNyKOllxbeXkD004=;
 b=3DtUMh+9RjhfWjDAeqJFoLDOZGHWpK+dbM3tqlpdpp0yzQD33QSwWkkmbv7GaBaHL3Faq4Pa2CPGb207FhtPrwBiQELgHguDJj2ErA9YH3Hzw+c/akgwcZOwsCEsONr55B52kI6ThYoFrTvLzJ/C5MJat8KHvVwXadF4iL9xNzA=
Received: from DM6PR02CA0139.namprd02.prod.outlook.com (2603:10b6:5:332::6) by
 MWHPR12MB1568.namprd12.prod.outlook.com (2603:10b6:301:e::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4331.29; Wed, 21 Jul 2021 02:05:25 +0000
Received: from DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:332:cafe::70) by DM6PR02CA0139.outlook.office365.com
 (2603:10b6:5:332::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend
 Transport; Wed, 21 Jul 2021 02:05:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT003.mail.protection.outlook.com (10.13.173.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4352.24 via Frontend Transport; Wed, 21 Jul 2021 02:05:25 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 20 Jul
 2021 21:05:24 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Tue, 20 Jul
 2021 21:05:24 -0500
Received: from wayne-build.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2242.4 via Frontend
 Transport; Tue, 20 Jul 2021 21:05:22 -0500
From: Jingwen Chen <Jingwen.Chen2@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] drm/amd/amdgpu: consider kernel job always not guilty
Date: Wed, 21 Jul 2021 10:05:05 +0800
Message-ID: <20210721020504.404046-1-Jingwen.Chen2@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bbaf4e37-42fb-4693-3c25-08d94bec0123
X-MS-TrafficTypeDiagnostic: MWHPR12MB1568:
X-Microsoft-Antispam-PRVS: <MWHPR12MB1568F2C24D12F9CFFEEC4C6CB7E39@MWHPR12MB1568.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KbFYgWTu6evA1/WU7QjBbfc6vNlARq5I/yqhutB8bbrrtep4gdCJmImMkt2JvJVaHsKn6ru+zMLYVf0BnVb4GCKCipWChuytH969iqNiZMAztUpiJRG4ZHlYFp7JXAxd/UQKlvy5PVFGX0GLQmjWOXh/r0T6WmA5gmRjx1fyjLzMNo7UYljeo94015l/lVIbdTZV8sS+cbkHMxmA+JTvYIih9fZzKDg807BOIRh17Ci0UCXF6x3C7uvf1XNTFa18QBbsDgaKCMFzhh/XQtbPfgtyb4ZCU8XbsvUAtU+nsG9wqclO/lDyAMMJ/VQ01zjJXMVlO8e/++8IVMwnlNSUvpogLWvBBlHiDPNxgZ1llU9QD9RO/zIDIZMTw841F4F48jjCzq8sbzarj5fsaEZMKRU617NF4clDaZvqpy/IQSF1f/yTNfKPMtbsLD2lEvWJIWGcSwuN0005IExqFJQCLyZXalrcZ/OaCYeD48wBa35MJNE9eCYS1bZzOA6C4YKAvlpecTbQkxPBrhsJVx6lZcvuZ/NVk7aPHA1jstPacjUZ6KkGR6ozlex+9BqIwrE11HjV/M7cRvtx/x0R6mBbpUw7dUW4nZtnA0wxYqi8wM9uh4qtUzQ6a8EtHLiYG77nYzBhEdzxDqHngFmRB+POOf+sIH/3XjkpBCy9BYtIWDZRKgIp52WLDtKvr+cNBjIr4VPW0eWjpxQFunCt6/kY/gRm01sGq0MHkHsqE6oK1HE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(376002)(136003)(396003)(36840700001)(46966006)(186003)(26005)(5660300002)(6666004)(356005)(70586007)(336012)(70206006)(7696005)(2616005)(478600001)(316002)(36756003)(1076003)(6916009)(82310400003)(8676002)(81166007)(426003)(8936002)(83380400001)(54906003)(82740400003)(36860700001)(2906002)(4326008)(47076005)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2021 02:05:25.2107 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bbaf4e37-42fb-4693-3c25-08d94bec0123
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1568
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
Cc: ckoenig.leichtzumerken@gmail.com, horace.chen@amd.com,
 Jingwen Chen <Jingwen.Chen2@amd.com>, monk.liu@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
Currently all timedout job will be considered to be guilty. In SRIOV
multi-vf use case, the vf flr happens first and then job time out is
found. There can be several jobs timeout during a very small time slice.
And if the innocent sdma job time out is found before the real bad
job, then the innocent sdma job will be set to guilty. This will lead
to a page fault after resubmitting job.

[How]
If the job is a kernel job, we will always consider it not guilty

Signed-off-by: Jingwen Chen <Jingwen.Chen2@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 37fa199be8b3..40461547701a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4410,7 +4410,7 @@ int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
 		amdgpu_fence_driver_force_completion(ring);
 	}
 
-	if(job)
+	if (job && job->vm)
 		drm_sched_increase_karma(&job->base);
 
 	r = amdgpu_reset_prepare_hwcontext(adev, reset_context);
@@ -4874,7 +4874,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 			DRM_INFO("Bailing on TDR for s_job:%llx, hive: %llx as another already in progress",
 				job ? job->base.id : -1, hive->hive_id);
 			amdgpu_put_xgmi_hive(hive);
-			if (job)
+			if (job && job->vm)
 				drm_sched_increase_karma(&job->base);
 			return 0;
 		}
@@ -4898,7 +4898,7 @@ int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
 					job ? job->base.id : -1);
 
 		/* even we skipped this reset, still need to set the job to guilty */
-		if (job)
+		if (job && job->vm)
 			drm_sched_increase_karma(&job->base);
 		goto skip_recovery;
 	}
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
