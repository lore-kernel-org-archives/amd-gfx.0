Return-Path: <SRS0=miQW=OD=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 976B4C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Sep 2021 05:55:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A7AC60F4B
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Sep 2021 05:55:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5A7AC60F4B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 491DF6E0DA;
	Mon, 13 Sep 2021 05:55:42 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2087.outbound.protection.outlook.com [40.107.92.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 754EC6E0DA
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Sep 2021 05:55:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BwvCNGMTTmIAmBen7qcPbPuvokd9CaSA5y/MDdoI/MtLu48wFeG/ZaFW0rodMs2H4CDKmlS2BwPlCR3tJnXQaSa7Pp+nSAxR+0j9hzJJF8WYXBiIfBa4QBAEte2TKTqEYGGtvIE+q2dxHyXhLOvxXmd3VFCXawh8LdMGxeOPl/yZliNAMfhb2J1Ggo4Ba4WhktnB89z6Q5Hu15wzYggw9iq3QzXgewC8WKH40NuAAQihMH5H3qffqWjDHZkIIwnBuq6bLKP+AsDMhV8mZbb8w73hywk7JPkkWTrXAX92x5VZyrPq/sKitEZ8ZHSIICSF/vw3dIZtwwbp7G/oAzk97Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=HcwhJ1oQBDqKFl+RTHQtb9KI0rThSlqbf/QgceMS2PU=;
 b=T+ulIkqbxWQdlL5uy3b10E9W+8/HfjH/fW/r5glwytkiakyyFsC1GdZc+m0flnxjTG6NPfN2sInW5/YqpLQsfkqITpGpbMw+FTFALSPpel5vNUoqB2m9SZPEoEh8wb4l2KefcLXIeNvsSzUxce7HNP7DNr/KAXffPeMiSe3Xf4cvz8oQqOBnDmRfoFYrV1RPLyj+yHCp5DdVduAkxfypAouoOYR28NwuLaB++bLc/j3bUPSmVQjsJn6bGtszGEDao+P8lCPE/BK95q2i5kezMaU19+IttTf4PLxj5bCIOjQiuFJ0VqsI3zkgYlkFDduTg2sxiTjSofuPqEVL+yJbBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HcwhJ1oQBDqKFl+RTHQtb9KI0rThSlqbf/QgceMS2PU=;
 b=i3+JNliDlXmqbwUMq73/+ROgAZRoyDFF54AM5RCXIA/Loh3BJL1Bf5sFCMgZOuVyQxlvF4HxCv7sYczv9J7ryn1pqpNgQmqu/cTEZocNs4y3yAMirDCKN3LHBXD6cWWCUwmxtYQ8afzj8BH8Q5V0SUC0DrE2Kp6MxwyJkOT58V4=
Received: from MWHPR18CA0031.namprd18.prod.outlook.com (2603:10b6:320:31::17)
 by BN8PR12MB3492.namprd12.prod.outlook.com (2603:10b6:408:67::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.18; Mon, 13 Sep
 2021 05:55:38 +0000
Received: from CO1NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:320:31:cafe::9) by MWHPR18CA0031.outlook.office365.com
 (2603:10b6:320:31::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend
 Transport; Mon, 13 Sep 2021 05:55:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT050.mail.protection.outlook.com (10.13.174.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4500.14 via Frontend Transport; Mon, 13 Sep 2021 05:55:38 +0000
Received: from pp-server-two.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Mon, 13 Sep
 2021 00:55:35 -0500
From: xinhui pan <xinhui.pan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <christian.koenig@amd.com>,
 <lijo.lazar@amd.com>, xinhui pan <xinhui.pan@amd.com>
Subject: [RFC PATCH 2/2] drm/amdgpu: protect ring from concurrency access
Date: Mon, 13 Sep 2021 13:55:21 +0800
Message-ID: <20210913055521.27341-2-xinhui.pan@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210913055521.27341-1-xinhui.pan@amd.com>
References: <20210913055521.27341-1-xinhui.pan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9a410e39-5530-44f8-5ec2-08d9767b1cc5
X-MS-TrafficTypeDiagnostic: BN8PR12MB3492:
X-Microsoft-Antispam-PRVS: <BN8PR12MB34924E1E3D3E3035BD749B3E87D99@BN8PR12MB3492.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MKAPkRhDz+lGw4JMppsXriyFBDy3ew1FA29tr50yPwRhSND+WNRdHeERrOwUg/Cyoq/Z3jc0FZq/3UwwnjFjsQk/kPXKOkOtZ0XJpBbNhAXFREgwuby9kMgt8uahurCb6m3jwntX89szfJ45AugXyZxzk81cjx16F9zmoMKfz8WGXQGphxEVtYq/YuCNIxm7zRp5Tyz6sQCNZxW04fdABnbYZqCZDyMEOXE7Hxqcl78p1Qbr3I2tkc6EiFQZE+LfykrIuhRCvEqWSDS+jY7WKL6QCtst5LR3BTuaP6VyIE2FjHqXHt8E0hrwz1yNXCy3dciEqrAg2NsESnOzygQyPEzGrW0iQrYe/UOCKvSWvL1z1YVTX3JiTCYKpwieWMiJP3lmj8peM/ZeRi4yn/7GyLT6052AXHNcEcxl8MSL7qcvIRINk9m5FOR/pY5+7Ql8mnCzEeR1TAMWIVx/hQcEoUK9fxGSMj1LtF32CzHy0tIpBckBjnSHjt2K+J2oAWOH9FC8Sr0qpndtxZQukqNPkzsK/gY2IKH8mhepFQ8aAbR7i/4gwckBcXFEt5DHyRQSPIUv/nCBCLSPOCHV6t4LpyfwoO51TPbS5VBEJvIYNmOc0laj5fhyOYHYEYWXUwIkQTXArmMh7ywyZ5/AT4fOdUAK+g+NPMiVFZ+nJpT3ygS4hl1YgcVu9mmFLHFVCu4Drgr8nXDpqW3RhDg+q09AKnFXZEiYto8/dcyowhot+bo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(346002)(396003)(39860400002)(136003)(46966006)(36840700001)(4326008)(6666004)(356005)(8936002)(478600001)(47076005)(2616005)(5660300002)(83380400001)(316002)(82310400003)(54906003)(81166007)(36756003)(6916009)(36860700001)(7696005)(2906002)(426003)(336012)(26005)(8676002)(16526019)(186003)(86362001)(70586007)(82740400003)(70206006)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2021 05:55:38.3828 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a410e39-5530-44f8-5ec2-08d9767b1cc5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3492
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

Park the ring scheduler thread before accessing the ring.
And unpark it only when we finish accessing the ring.

The right sequence should be like below.
lock ring
park ring thread
direct access ring
[unlock ring, do something, lock ring]
unpark ring thread
unlock ring

Signed-off-by: xinhui pan <xinhui.pan@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 30 ++++++---------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c      |  6 +++++
 2 files changed, 14 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 19323b4cce7b..5138d5b52c9e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -1349,7 +1349,7 @@ static int amdgpu_debugfs_test_ib_show(struct seq_file *m, void *unused)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)m->private;
 	struct drm_device *dev = adev_to_drm(adev);
-	int r = 0, i;
+	int r = 0;
 
 	r = pm_runtime_get_sync(dev->dev);
 	if (r < 0) {
@@ -1362,15 +1362,6 @@ static int amdgpu_debugfs_test_ib_show(struct seq_file *m, void *unused)
 	if (r)
 		return r;
 
-	/* hold on the scheduler */
-	for (i = 0; i < AMDGPU_MAX_RINGS; i++) {
-		struct amdgpu_ring *ring = adev->rings[i];
-
-		if (!ring || !ring->sched.thread)
-			continue;
-		kthread_park(ring->sched.thread);
-	}
-
 	seq_printf(m, "run ib test:\n");
 	r = amdgpu_ib_ring_tests(adev);
 	if (r)
@@ -1378,15 +1369,6 @@ static int amdgpu_debugfs_test_ib_show(struct seq_file *m, void *unused)
 	else
 		seq_printf(m, "ib ring tests passed.\n");
 
-	/* go on the scheduler */
-	for (i = 0; i < AMDGPU_MAX_RINGS; i++) {
-		struct amdgpu_ring *ring = adev->rings[i];
-
-		if (!ring || !ring->sched.thread)
-			continue;
-		kthread_unpark(ring->sched.thread);
-	}
-
 	up_read(&adev->reset_sem);
 
 	pm_runtime_mark_last_busy(dev->dev);
@@ -1650,13 +1632,14 @@ static int amdgpu_debugfs_ib_preempt(void *data, u64 val)
 	if (r)
 		goto pro_end;
 
-	/* stop the scheduler */
-	kthread_park(ring->sched.thread);
-
 	resched = ttm_bo_lock_delayed_workqueue(&adev->mman.bdev);
 
 	/* preempt the IB */
+	mutex_lock(&ring->lock);
+	/* stop the scheduler */
+	kthread_park(ring->sched.thread);
 	r = amdgpu_ring_preempt_ib(ring);
+	mutex_unlock(&ring->lock);
 	if (r) {
 		DRM_WARN("failed to preempt ring %d\n", ring->idx);
 		goto failure;
@@ -1686,8 +1669,11 @@ static int amdgpu_debugfs_ib_preempt(void *data, u64 val)
 	}
 
 failure:
+	/* make sure thread is not unparked accidently. */
+	mutex_lock(&ring->lock);
 	/* restart the scheduler */
 	kthread_unpark(ring->sched.thread);
+	mutex_unlock(&ring->lock);
 
 	up_read(&adev->reset_sem);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
index 9274f32c3661..ea83b3aef8fb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
@@ -402,7 +402,13 @@ int amdgpu_ib_ring_tests(struct amdgpu_device *adev)
 		else
 			tmo = tmo_gfx;
 
+		mutex_lock(&ring->lock);
+		if (ring->sched.thread)
+			kthread_park(ring->sched.thread);
 		r = amdgpu_ring_test_ib(ring, tmo);
+		if (ring->sched.thread)
+			kthread_unpark(ring->sched.thread);
+		mutex_unlock(&ring->lock);
 		if (!r) {
 			DRM_DEV_DEBUG(adev->dev, "ib test on %s succeeded\n",
 				      ring->name);
-- 
2.25.1

