Return-Path: <SRS0=mUog=3Z=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FACBC35247
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Feb 2020 23:29:35 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50A4B2082E
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Feb 2020 23:29:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Y8luewJe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50A4B2082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 20E8F6F97B;
	Wed,  5 Feb 2020 23:29:35 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2043.outbound.protection.outlook.com [40.107.244.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 716B76F97B
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Feb 2020 23:29:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W+rAGpUSZOe53NeyejmdqkNXfBselhWVJr3HRRedI63/FHkkt6kxkjzHpNbFOnj3NXFiCiYtsMbkiTqErYWB/oP65Z1tcFiEGGjI8Y/0oR3YBraysTYKuJG+Q5cp5Y5uVv3h4k2nWCSJWiynciURPM4bLW0NbeZ53DTH3YB6x3qmFkwN0B2Ley0s5IxybnNcDclZP3jqwcZtUZehM7+1tmLz8t+ZZ4Snc8WMcYtjkj8Gzp43pzYSAZ+MVJPqkFtpyEfZ/eEt7vFs3zfOHfOHXNOv0wj9Utz+hjvsolxBy2ZP0LZ0Idunei11pWoGkgiWG7AiWjxCIoxyBO4zDKJ1RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BgrvGtU5ssSe0DwsWSzuvarCGDCI707fuEBEjMPFFnI=;
 b=Ifqgst1l8ZDQMPGX22LgTOSGs+AbDTthKLq87QsATexD7uQj1AgbVe+dFvRBjvXn5q/kXub94JR/6DpDkahtnWBvJYANbrtOLC3kT+LvITHsch5UfCfE+QaJyN2h7jd7k6iBOuoNwprlZCaNsBZXRvhOPkiubKB0gaWZPLlF5Vmx3ZwXl5rh0+LemQyivF3//1dcskJcGIGw5pEmjJ1mLn7Em0pPYFok8ZvASpl71IRsBO1w+8mF/M5lSUIyc14rV19WLEwrSJZRL1dcGT93W34uIXegrnp8efVHzqvY1+flBqrWXQo2UmXp3r0blPs2TLiUelCmiip0Knf6/IRtcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BgrvGtU5ssSe0DwsWSzuvarCGDCI707fuEBEjMPFFnI=;
 b=Y8luewJeOKxMvYlaWC7TvZlWRs09QyTktJg+DanM2rCFhHrSNbJFkxdS0xDHrjC25KFycVLhiJdum8odHOFsaTvg4i6zPZqg364Rb4ssGFNfxk2AA3XzWi8eyqk2zf+MEKt36vlQ2Xmq8iqXPYEpYwt8etz5HHuspoRbmmJihxw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yong.Zhao@amd.com; 
Received: from CH2PR12MB3926.namprd12.prod.outlook.com (52.132.245.30) by
 CH2PR12MB4248.namprd12.prod.outlook.com (20.180.17.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21; Wed, 5 Feb 2020 23:29:32 +0000
Received: from CH2PR12MB3926.namprd12.prod.outlook.com
 ([fe80::81de:623c:a226:a92d]) by CH2PR12MB3926.namprd12.prod.outlook.com
 ([fe80::81de:623c:a226:a92d%4]) with mapi id 15.20.2686.031; Wed, 5 Feb 2020
 23:29:32 +0000
From: Yong Zhao <Yong.Zhao@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/6] drm/amdkfd: Avoid ambiguity by indicating it's cp queue
Date: Wed,  5 Feb 2020 18:28:28 -0500
Message-Id: <20200205232832.26226-2-Yong.Zhao@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200205232832.26226-1-Yong.Zhao@amd.com>
References: <20200205232832.26226-1-Yong.Zhao@amd.com>
X-ClientProxiedBy: YQBPR01CA0115.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:1::15) To CH2PR12MB3926.namprd12.prod.outlook.com
 (2603:10b6:610:27::30)
MIME-Version: 1.0
Received: from yong-dev.amd.com (165.204.55.251) by
 YQBPR01CA0115.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:1::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21 via Frontend Transport; Wed, 5 Feb 2020 23:29:32 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 31380fec-55f2-4797-9618-08d7aa9340f6
X-MS-TrafficTypeDiagnostic: CH2PR12MB4248:|CH2PR12MB4248:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB424891748356EDD532C5DB61F0020@CH2PR12MB4248.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 0304E36CA3
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(136003)(396003)(366004)(376002)(39860400002)(189003)(199004)(6666004)(1076003)(86362001)(2906002)(52116002)(478600001)(4326008)(7696005)(186003)(16526019)(316002)(6486002)(66476007)(6916009)(8676002)(66946007)(5660300002)(26005)(81166006)(66556008)(81156014)(2616005)(36756003)(8936002)(956004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CH2PR12MB4248;
 H:CH2PR12MB3926.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 347sh6nEKYrHPlkOgFVSW3+OMpg6OHxJYcMoTday0zyYlEHSWuu+vXWONWxbMxaF4YJZDIJSJiNTonnTRXmje76SMi9cZpVQwgxTEmiIESIOzBHXkHO1OwUbeXuGavNhy5f1NPsZUGXTg+cbxpvf8eLDubVl0JOvGySdPQq6W4jHbM+cpSO1W+Iv0zd495inYvSOw6acmjxjrr9VKQDljU9dAtCOcnao/FNl6PmtX80BqXxlH+j1ekvSTIv8HjArBckSLql3eBMSwWmvkqxZYBdfALY6nAf3zdwB4hjFgvQOKc/uRR3mdNpVz7rFvKAn4Mgg2dQ3CbJpYIKVvxctRg4iAO/bY/gevmHuWnomJ6C6ZpFzwlQAB0/sHMigni+g9CzWF+6Q3w4iuJMQ+CZxnohcwFhqJCXOXWIDTER5+hyOyrKTw6mkaujIJrTKlFeI
X-MS-Exchange-AntiSpam-MessageData: by4+jZuH8iGhAEwYDFsQUFdWvuaHRrpwgcRjvkLKClgu+iZcEQ7QXkY8nbqA/d4RgAh1WUbR8RPwZjNuTj8RqwHbEr8Id5CzyrBXvRiXz6VEm7mxYeoWOyGzIvswBx9IVEjGh5/JDoAdXemxZtNAaA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31380fec-55f2-4797-9618-08d7aa9340f6
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2020 23:29:32.4430 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c8mlFaOtqiWgQkSAI6h6yLacQLqrTgP5Kp4BQ8WpbkskNWzmJyUl6L3gpcFEF2ew
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4248
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
Cc: Yong Zhao <Yong.Zhao@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The queues represented in queue_bitmap are only CP queues.

Change-Id: I7e6a75de39718d7c4da608166b85b9377d06d1b3
Signed-off-by: Yong Zhao <Yong.Zhao@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c           |  4 ++--
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c    | 12 ++++++------
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.h    |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c      |  2 +-
 .../gpu/drm/amd/amdkfd/kfd_process_queue_manager.c   |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c            |  2 +-
 drivers/gpu/drm/amd/include/kgd_kfd_interface.h      |  2 +-
 7 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 8609287620ea..ebe4b8f88e79 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -126,7 +126,7 @@ void amdgpu_amdkfd_device_init(struct amdgpu_device *adev)
 		/* this is going to have a few of the MSBs set that we need to
 		 * clear
 		 */
-		bitmap_complement(gpu_resources.queue_bitmap,
+		bitmap_complement(gpu_resources.cp_queue_bitmap,
 				  adev->gfx.mec.queue_bitmap,
 				  KGD_MAX_QUEUES);
 
@@ -137,7 +137,7 @@ void amdgpu_amdkfd_device_init(struct amdgpu_device *adev)
 				* adev->gfx.mec.num_pipe_per_mec
 				* adev->gfx.mec.num_queue_per_pipe;
 		for (i = last_valid_bit; i < KGD_MAX_QUEUES; ++i)
-			clear_bit(i, gpu_resources.queue_bitmap);
+			clear_bit(i, gpu_resources.cp_queue_bitmap);
 
 		amdgpu_doorbell_get_kfd_info(adev,
 				&gpu_resources.doorbell_physical_address,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 7ef9b89f5c70..973581c2b401 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -78,14 +78,14 @@ static bool is_pipe_enabled(struct device_queue_manager *dqm, int mec, int pipe)
 	/* queue is available for KFD usage if bit is 1 */
 	for (i = 0; i <  dqm->dev->shared_resources.num_queue_per_pipe; ++i)
 		if (test_bit(pipe_offset + i,
-			      dqm->dev->shared_resources.queue_bitmap))
+			      dqm->dev->shared_resources.cp_queue_bitmap))
 			return true;
 	return false;
 }
 
-unsigned int get_queues_num(struct device_queue_manager *dqm)
+unsigned int get_cp_queues_num(struct device_queue_manager *dqm)
 {
-	return bitmap_weight(dqm->dev->shared_resources.queue_bitmap,
+	return bitmap_weight(dqm->dev->shared_resources.cp_queue_bitmap,
 				KGD_MAX_QUEUES);
 }
 
@@ -908,7 +908,7 @@ static int initialize_nocpsch(struct device_queue_manager *dqm)
 
 		for (queue = 0; queue < get_queues_per_pipe(dqm); queue++)
 			if (test_bit(pipe_offset + queue,
-				     dqm->dev->shared_resources.queue_bitmap))
+				     dqm->dev->shared_resources.cp_queue_bitmap))
 				dqm->allocated_queues[pipe] |= 1 << queue;
 	}
 
@@ -1029,7 +1029,7 @@ static int set_sched_resources(struct device_queue_manager *dqm)
 		mec = (i / dqm->dev->shared_resources.num_queue_per_pipe)
 			/ dqm->dev->shared_resources.num_pipe_per_mec;
 
-		if (!test_bit(i, dqm->dev->shared_resources.queue_bitmap))
+		if (!test_bit(i, dqm->dev->shared_resources.cp_queue_bitmap))
 			continue;
 
 		/* only acquire queues from the first MEC */
@@ -1979,7 +1979,7 @@ int dqm_debugfs_hqds(struct seq_file *m, void *data)
 
 		for (queue = 0; queue < get_queues_per_pipe(dqm); queue++) {
 			if (!test_bit(pipe_offset + queue,
-				      dqm->dev->shared_resources.queue_bitmap))
+				      dqm->dev->shared_resources.cp_queue_bitmap))
 				continue;
 
 			r = dqm->dev->kfd2kgd->hqd_dump(
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
index ee3400e92c30..3f0fb0d28c01 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
@@ -219,7 +219,7 @@ void device_queue_manager_init_v10_navi10(
 		struct device_queue_manager_asic_ops *asic_ops);
 void program_sh_mem_settings(struct device_queue_manager *dqm,
 					struct qcm_process_device *qpd);
-unsigned int get_queues_num(struct device_queue_manager *dqm);
+unsigned int get_cp_queues_num(struct device_queue_manager *dqm);
 unsigned int get_queues_per_pipe(struct device_queue_manager *dqm);
 unsigned int get_pipes_per_mec(struct device_queue_manager *dqm);
 unsigned int get_num_sdma_queues(struct device_queue_manager *dqm);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
index 393c218734fd..377bde0e781c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_packet_manager.c
@@ -62,7 +62,7 @@ static void pm_calc_rlib_size(struct packet_manager *pm,
 		max_proc_per_quantum = dev->max_proc_per_quantum;
 
 	if ((process_count > max_proc_per_quantum) ||
-	    compute_queue_count > get_queues_num(pm->dqm)) {
+	    compute_queue_count > get_cp_queues_num(pm->dqm)) {
 		*over_subscription = true;
 		pr_debug("Over subscribed runlist\n");
 	}
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index 606b1a8aacad..b62ee2e3344a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -266,7 +266,7 @@ int pqm_create_queue(struct process_queue_manager *pqm,
 		if ((dev->dqm->sched_policy ==
 		     KFD_SCHED_POLICY_HWS_NO_OVERSUBSCRIPTION) &&
 		((dev->dqm->processes_count >= dev->vm_info.vmid_num_kfd) ||
-		(dev->dqm->active_queue_count >= get_queues_num(dev->dqm)))) {
+		(dev->dqm->active_queue_count >= get_cp_queues_num(dev->dqm)))) {
 			pr_debug("Over-subscription is not allowed when amdkfd.sched_policy == 1\n");
 			retval = -EPERM;
 			goto err_create_queue;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index 43a82cf76628..b70e6b25edc6 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -1318,7 +1318,7 @@ int kfd_topology_add_device(struct kfd_dev *gpu)
 	dev->node_props.num_gws = (dev->gpu->gws &&
 		dev->gpu->dqm->sched_policy != KFD_SCHED_POLICY_NO_HWS) ?
 		amdgpu_amdkfd_get_num_gws(dev->gpu->kgd) : 0;
-	dev->node_props.num_cp_queues = get_queues_num(dev->gpu->dqm);
+	dev->node_props.num_cp_queues = get_cp_queues_num(dev->gpu->dqm);
 
 	kfd_fill_mem_clk_max_info(dev);
 	kfd_fill_iolink_non_crat_info(dev);
diff --git a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
index a607b1034962..55750890b73f 100644
--- a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
@@ -123,7 +123,7 @@ struct kgd2kfd_shared_resources {
 	uint32_t num_queue_per_pipe;
 
 	/* Bit n == 1 means Queue n is available for KFD */
-	DECLARE_BITMAP(queue_bitmap, KGD_MAX_QUEUES);
+	DECLARE_BITMAP(cp_queue_bitmap, KGD_MAX_QUEUES);
 
 	/* SDMA doorbell assignments (SOC15 and later chips only). Only
 	 * specific doorbells are routed to each SDMA engine. Others
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
