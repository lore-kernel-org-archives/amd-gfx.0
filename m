Return-Path: <SRS0=u9ZA=5T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05A93C43331
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Apr 2020 05:03:02 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6C5720787
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Apr 2020 05:03:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="v8XEgoYs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6C5720787
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5DD856E1B3;
	Fri,  3 Apr 2020 05:03:01 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2077.outbound.protection.outlook.com [40.107.236.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFA426E1B3
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Apr 2020 05:03:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QTuniht+dQUUHlVYHuCRELBKpPcweGmX3eCdh2W7xuhlY90iPJKTMX9Y7kfAUGxgliqBZJ4A/zzr6XD31QxmnGghWXBqFJzTLSHwhuBz07SU5jg2+dOfunW/ylbt2KibnvoIVoPja+t6zFeGuYaup3/nHnbAFFXGIqBbANDHAa7lwouk92Eq1a3L9clOO2ha0VcVrIW9j58mFF92uSEPaI/TQqSAIdhPfT0HDG8HOGZG3SOokCA1E0cDPIsrvjkgewFDR8jTc9YKRqfGFNb8LHz16Gdyn/IArlGqnofjnXlEFbsRaFwUePm0jZFZ8odvj2fZSZQnXGOtGxJtnpIfTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SqO8nBHmvlQ0bk1b5oWluDhGY55vWp/5m4ayDJCsgMM=;
 b=a6DRSm13Keja4BGYVHZK5dk43ZERmIgTCMencXx0577WBNm+QykQClPcoRQrVPpTonvjRc0lYQugjyR94ODJvh//kqSHR5zVKBX7PIFBp9MHzqyLRA266Sa8FeQUhfQyMPjUrI+6R9IX1Wlxycr4AfhyX3HVFfCu5l0ELKGAj7PgjURtuTFMMtchnvGGDWkMw2zve8KefRnxHa6BSzAYatEvZISJvVTtWmxcfDy1JKInhUnu8A12wkUQzkG3uVUvAjfwI/hVck+sCrZCLJFOr2PF3vX72MdzzDYI6PYIm6Nz4Cw5wnetcQjJPRYLfsSBkfBIw/kb9W7qZPURBCqUQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SqO8nBHmvlQ0bk1b5oWluDhGY55vWp/5m4ayDJCsgMM=;
 b=v8XEgoYsOH1Z3rPoSnYQqEN+4uINpFLwUc0Z3UzyjeCjkYFRD3uqCfb4zxOo7lIA/1pFiEb6gGm11ix9kANnySbFqwsqdkyrd6c4Q/bwR+pQqLSMAyUQkBjqVyC+Q19yR1BrNouOfcV5vvRHjZxVNfG3O/AKeSw6/IB/hFwS5XQ=
Received: from DM5PR15CA0039.namprd15.prod.outlook.com (2603:10b6:4:4b::25) by
 SA0PR12MB4495.namprd12.prod.outlook.com (2603:10b6:806:70::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2856.20; Fri, 3 Apr 2020 05:02:58 +0000
Received: from DM6NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:4b:cafe::ab) by DM5PR15CA0039.outlook.office365.com
 (2603:10b6:4:4b::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15 via Frontend
 Transport; Fri, 3 Apr 2020 05:02:58 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT027.mail.protection.outlook.com (10.13.172.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2878.15 via Frontend Transport; Fri, 3 Apr 2020 05:02:58 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 3 Apr 2020
 00:02:57 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 3 Apr 2020
 00:02:57 -0500
Received: from ubuntu.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Fri, 3 Apr 2020 00:02:56 -0500
From: Jack Zhang <Jack.Zhang1@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu/sriov add amdgpu_amdkfd_pre_reset in gpu reset
Date: Fri, 3 Apr 2020 13:02:53 +0800
Message-ID: <1585890173-10429-1-git-send-email-Jack.Zhang1@amd.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(39860400002)(346002)(136003)(376002)(396003)(428003)(46966005)(70586007)(81156014)(478600001)(8936002)(82740400003)(316002)(81166006)(70206006)(2906002)(2616005)(426003)(336012)(8676002)(7696005)(86362001)(6916009)(5660300002)(4326008)(47076004)(356004)(6666004)(26005)(36756003)(186003);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6f1ea58a-9e21-4edd-4c58-08d7d78c471e
X-MS-TrafficTypeDiagnostic: SA0PR12MB4495:
X-Microsoft-Antispam-PRVS: <SA0PR12MB4495332A43BE9AFCA33B3439BBC70@SA0PR12MB4495.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:773;
X-Forefront-PRVS: 0362BF9FDB
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8m9ukuTMM9tWFcvWrR7K8ECrIGiCekjzfEZ7cOLDKyUKXbuXOF6XIyfQaWL+lNHFvjzUT1TnNNZPbPk+xp/WCvPRue93eoeNOYPNpNGDeIgazhw5QSESDOEvWZjLJi5rG1FMJRPznUzcgpHZsSi6w8elLLt/hyWfXLgb9qWplt4W38Q08V19ouijWJseSNcSX8y//RiNAFZ0PyONudnXBpSRUNLgK9ZyW40QGSTpRUrnNY3BIfD9tOEuNhH6TQAj4G5czd4kKHDWPlj2GC3CX5x8zM9pGCW2AH1biDGDgRFedKY4Fdf5J7SQyffbjO8ZiaKgIBsHXiYR7BwjxQGa7+rKgtHbeqpcYrCoab0lusZy5kHEi7B9/Uy+1Rd86vsz66bzNRFHfJ6uuc4Ex5FP4ou4AL1U/PAhukVXqXcoN/Xs580Xc+jwMqPRPK34u5QdNEDtgh8I1Snmu4oiAmzlbUt9bcNYTubrlB1r5i4czForzXkS4F7qKm3hsoSLN+RfKDpUoQl/GlQ2MIfeQH5xlw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2020 05:02:58.3866 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f1ea58a-9e21-4edd-4c58-08d7d78c471e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4495
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
Cc: Jack Zhang <Jack.Zhang1@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

kfd_pre_reset will free mem_objs allocated by kfd_gtt_sa_allocate

Without this change, sriov tdr code path will never free those allocated
memories and get memory leak.

v2:add a bugfix for kiq ring test fail

Signed-off-by: Jack Zhang <Jack.Zhang1@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c | 3 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c  | 3 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c         | 2 ++
 3 files changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
index 4ec6d0c..bdc1f5a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
@@ -543,6 +543,9 @@ static int kgd_hqd_destroy(struct kgd_dev *kgd, void *mqd,
 	uint32_t temp;
 	struct v10_compute_mqd *m = get_mqd(mqd);
 
+	if (amdgpu_sriov_vf(adev) && adev->in_gpu_reset)
+		return 0;
+
 #if 0
 	unsigned long flags;
 	int retry;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
index df841c2..c2562d6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
@@ -541,6 +541,9 @@ int kgd_gfx_v9_hqd_destroy(struct kgd_dev *kgd, void *mqd,
 	uint32_t temp;
 	struct v9_mqd *m = get_mqd(mqd);
 
+	if (amdgpu_sriov_vf(adev) && adev->in_gpu_reset)
+		return 0;
+
 	if (adev->in_gpu_reset)
 		return -EIO;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 8faaa17..e3f7441 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3854,6 +3854,8 @@ static int amdgpu_device_reset_sriov(struct amdgpu_device *adev,
 	if (r)
 		return r;
 
+	amdgpu_amdkfd_pre_reset(adev);
+
 	/* Resume IP prior to SMC */
 	r = amdgpu_device_ip_reinit_early_sriov(adev);
 	if (r)
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
