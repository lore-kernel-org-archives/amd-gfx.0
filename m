Return-Path: <SRS0=Jh+1=BW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78DACC433DF
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Aug 2020 09:19:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F220207DE
	for <amd-gfx@archiver.kernel.org>; Wed, 12 Aug 2020 09:19:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="IuXx5tPA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F220207DE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF4CC6E25B;
	Wed, 12 Aug 2020 09:19:57 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2079.outbound.protection.outlook.com [40.107.244.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C60BE6E25B
 for <amd-gfx@lists.freedesktop.org>; Wed, 12 Aug 2020 09:19:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZlG4f6uxNXMMbSEJQ1WFhtZ1Qh5neTbUk70xY5QnAcYiirqj7rAl8mxE9wAw3w72/nivEnLCvJBaaDdBZj4TK72/Jkl6SatGS6KfOZTSZhEDt1zKwJYhPbS30vvvoN5m/qXeVOVD7Rdu2ePXbdREFtFKEWDxzR/iXBRaZvkF4FQ0Ke65oamf8IZnPOPOa3ifIKJ4STESX+R7+4oFRxRcjuaGKXj21KhJXa7UbsgZzog4bG8Q4Qyd2SPW+6EMSDRw81J5x2ccnaBJWNEc0Bf4s0/iy0kFPffn8a5Oy9Jjv1bHMM0BwX1uSVwv+bq67XgVrQ2WwapAp4h9JpL9STwIaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ttteb4DTgPmu0hVsIB/0sJksRK+R+eMfSsqMftxyce8=;
 b=aPe5plwHHst2L1RCG0fneGIcfvC3Sb47CdGAkf1n0Gh8P7KN2mwLpS0/OIuq9mpWCAbLhWklO/D941N4YJjT5Kr5erL/FvybTDNqyI4HkGEOrtNwEF/L++XVCKkpFCb/xPRAj8fNa5Xo2Ex9G/Q8RfP2BFt0kQSkCA3N7nw23uk1XV1icmMCS9880XKkKG9YqTyo5YQYY6rz0nWO9RIA9cgwCcdBcuhWgIdonrt9zRA0s0Phmq1e3ksW+CL5a3vg6Py8i/eGcrXlNxEaw1JbgTXzXXuOjBNh9RzJZSmefDXNS9bSrycWZWTvsCaEt59kCz8wLbbWpeBws8RO6UgOOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ttteb4DTgPmu0hVsIB/0sJksRK+R+eMfSsqMftxyce8=;
 b=IuXx5tPA2uoI4BoNRXEjr0Zg4P9IYUXVh7RjooCKerFVhbjlT1EY7+2HPGibv/hz9EgJV09q6IY7n0onREtmciBQNl3Sew9fRIqnQz/epKdQRy4IKtorIclo9tgnbSu1g2Ls5HUvWXBidUOP6O1e39lMaI2dvcWVGIarinwrNbg=
Received: from MWHPR15CA0040.namprd15.prod.outlook.com (2603:10b6:300:ad::26)
 by SN6PR12MB2847.namprd12.prod.outlook.com (2603:10b6:805:76::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.22; Wed, 12 Aug
 2020 09:19:54 +0000
Received: from CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:ad:cafe::91) by MWHPR15CA0040.outlook.office365.com
 (2603:10b6:300:ad::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.19 via Frontend
 Transport; Wed, 12 Aug 2020 09:19:53 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB02.amd.com (165.204.84.17) by
 CO1NAM11FT044.mail.protection.outlook.com (10.13.175.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3261.16 via Frontend Transport; Wed, 12 Aug 2020 09:19:53 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 12 Aug
 2020 04:19:52 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 12 Aug
 2020 04:19:52 -0500
Received: from emiy-Z10PA-U8-Series.amd.com (10.180.168.240) by
 SATLEXMB02.amd.com (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3
 via Frontend Transport; Wed, 12 Aug 2020 04:19:51 -0500
From: Emily.Deng <Emily.Deng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amdgpu: Fix repeatly flr issue
Date: Wed, 12 Aug 2020 17:19:43 +0800
Message-ID: <20200812091943.438905-1-Emily.Deng@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: efa69246-8bae-4b91-b275-08d83ea0df7a
X-MS-TrafficTypeDiagnostic: SN6PR12MB2847:
X-Microsoft-Antispam-PRVS: <SN6PR12MB2847A47A90B78A6FEFF0B5608F420@SN6PR12MB2847.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8nxbA1GMcAdJAHns4F1fcA89t98vro5+gWg67IzYCkfJjTkw4AQij3YFbU1ex6mjX0qgyk43h4MLouyH1cSyAiNA6dByQPz8/j7/YggxqBLOVfvKl1tWGpNj+RAen92hKun3eBJklpB9bekJeWPqq9rLys1scv+D48CARKx+l7lWgl3s2jqWxUsDbwKktjUQY0rT43m8q4EarfhPRemCli6++9Frn1hYcI+H/F74LUgyHzEXBIZr9FCgcb3Aw9QAFUCIDn5Wnzgqfz8NkbZU5cCYaJgtxx5qmAgLmu3sgSCt+bkySaKDW8Mz+/zC6wE4NXIuodsO1xKNBuH7F9F9F3igxvDhTM10w/5OePYAKHVbuCTtAMvre6Mn2r54zF6wCNbYtxkJpGi9rMiJfnk56A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB02.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(376002)(396003)(136003)(346002)(46966005)(4326008)(81166007)(2906002)(6916009)(356005)(316002)(47076004)(70206006)(86362001)(82740400003)(82310400002)(36756003)(478600001)(83380400001)(26005)(186003)(426003)(6666004)(70586007)(5660300002)(7696005)(8936002)(336012)(2616005)(1076003)(8676002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2020 09:19:53.6375 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: efa69246-8bae-4b91-b275-08d83ea0df7a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB02.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2847
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
Cc: jqdeng <Emily.Deng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: jqdeng <Emily.Deng@amd.com>

Only for no job running test case need to do recover in
flr notification.
For having job in mirror list, then let guest driver to
hit job timeout, and then do recover.

Signed-off-by: jqdeng <Emily.Deng@amd.com>
Change-Id: Ic6234fce46fa1655ba81c4149235eeac75e75868
---
 drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c | 20 +++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c | 22 ++++++++++++++++++++--
 2 files changed, 39 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
index fe31cbeccfe9..12fe5164aaf3 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_ai.c
@@ -238,6 +238,9 @@ static void xgpu_ai_mailbox_flr_work(struct work_struct *work)
 	struct amdgpu_virt *virt = container_of(work, struct amdgpu_virt, flr_work);
 	struct amdgpu_device *adev = container_of(virt, struct amdgpu_device, virt);
 	int timeout = AI_MAILBOX_POLL_FLR_TIMEDOUT;
+	int i;
+	bool need_do_recover = true;
+	struct drm_sched_job *job;
 
 	/* block amdgpu_gpu_recover till msg FLR COMPLETE received,
 	 * otherwise the mailbox msg will be ruined/reseted by
@@ -258,10 +261,25 @@ static void xgpu_ai_mailbox_flr_work(struct work_struct *work)
 
 flr_done:
 	up_read(&adev->reset_sem);
+	for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
+		struct amdgpu_ring *ring = adev->rings[i];
+
+		if (!ring || !ring->sched.thread)
+			continue;
+
+		spin_lock(&ring->sched.job_list_lock);
+		job = list_first_entry_or_null(&ring->sched.ring_mirror_list,
+		struct drm_sched_job, node);
+		spin_unlock(&ring->sched.job_list_lock);
+		if (job) {
+			need_do_recover = false;
+			break;
+		}
+	}
 
 	/* Trigger recovery for world switch failure if no TDR */
 	if (amdgpu_device_should_recover_gpu(adev)
-		&& adev->sdma_timeout == MAX_SCHEDULE_TIMEOUT)
+		&& (need_do_recover || adev->sdma_timeout == MAX_SCHEDULE_TIMEOUT))
 		amdgpu_device_gpu_recover(adev, NULL);
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
index 6f55172e8337..fc92c494df0b 100644
--- a/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_nv.c
@@ -259,6 +259,9 @@ static void xgpu_nv_mailbox_flr_work(struct work_struct *work)
 	struct amdgpu_virt *virt = container_of(work, struct amdgpu_virt, flr_work);
 	struct amdgpu_device *adev = container_of(virt, struct amdgpu_device, virt);
 	int timeout = NV_MAILBOX_POLL_FLR_TIMEDOUT;
+	int i;
+	bool need_do_recover = true;
+	struct drm_sched_job *job;
 
 	/* block amdgpu_gpu_recover till msg FLR COMPLETE received,
 	 * otherwise the mailbox msg will be ruined/reseted by
@@ -279,10 +282,25 @@ static void xgpu_nv_mailbox_flr_work(struct work_struct *work)
 
 flr_done:
 	up_read(&adev->reset_sem);
+	for (i = 0; i < AMDGPU_MAX_RINGS; ++i) {
+		struct amdgpu_ring *ring = adev->rings[i];
+
+		if (!ring || !ring->sched.thread)
+			continue;
+
+		spin_lock(&ring->sched.job_list_lock);
+		job = list_first_entry_or_null(&ring->sched.ring_mirror_list,
+					struct drm_sched_job, node);
+		spin_unlock(&ring->sched.job_list_lock);
+		if (job) {
+			need_do_recover = false;
+			break;
+		}
+	}
 
 	/* Trigger recovery for world switch failure if no TDR */
-	if (amdgpu_device_should_recover_gpu(adev)
-		&& (adev->sdma_timeout == MAX_SCHEDULE_TIMEOUT ||
+	if (amdgpu_device_should_recover_gpu(adev) && (need_do_recover ||
+		adev->sdma_timeout == MAX_SCHEDULE_TIMEOUT ||
 		adev->gfx_timeout == MAX_SCHEDULE_TIMEOUT ||
 		adev->compute_timeout == MAX_SCHEDULE_TIMEOUT ||
 		adev->video_timeout == MAX_SCHEDULE_TIMEOUT))
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
