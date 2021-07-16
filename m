Return-Path: <SRS0=OLwD=MI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 779CBC636CA
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Jul 2021 01:25:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26D76613C1
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Jul 2021 01:25:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26D76613C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 662386E8D6;
	Fri, 16 Jul 2021 01:25:30 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2087.outbound.protection.outlook.com [40.107.96.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 330C56E8D3
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Jul 2021 01:25:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kMQskrVmO1jQYJ5tWwEUcidvLvPH1tRz9oldIBKZ6flMazTfimV6JSnHt+TMz9jYr6ComCw+mHjTqd27HVWNpdAkWb+tBZm+sf/ZIewvo4bncLss7mr6Q7yydvqnkG+ZmeQMvMWfqE7cco1IrGKgNzvrJiOxsYk19qJVo5V6nNZQnwGFVF8hisjQJw2i4IpqncnfAYo+k/wBRXywcNb2fxv9VvuWxwjVZS8xUH6emRlnQEul1c3uivWfInvtd29NxZv3AfhvRV7XpZmArHtDGpn62/KynZ9QXcaw60GR5CFZf2F0aZ42H5MAhtVnREENsD2020VU+yYdH1Mcjn9Qxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E81LQVnGhV/QOuWYJW537YXizH/YYbiYbwjrfSdoFfw=;
 b=HnxEpF819Oi9BCavKgUK0UhqknAPpamakpUV7KoJhRrx1s0pFRV17JDbhyLkg5LdGVKC4iR63nlR2yEpqDmYWknqGrZ6k1Mz/8s9lzTQV0KgrNxcLEVlDipH3XCA+gMmICPsHb7SSmhK413CN2It0bOeTtYppkvqymqZQVGKZVL0ibpNAQ+tRpgEq0c8+/oCeZYzQMORvhhBjAq1FZX/EwbEj7wIRDKhVerK3qG0xPTzVNwjC440FArmyVAXfwnNcOL0pKrMN5Yzerzg6El0bC1/lFGzwFjozTHRqOHBdEqqtd0yYL86MFEsHg2D7zOJHu118W+EJQpf5ob3zQ2azg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E81LQVnGhV/QOuWYJW537YXizH/YYbiYbwjrfSdoFfw=;
 b=NH5GB76L+4tJZYiPaX0hbWIMH3VPIOjYRW/xHxDKbllRpLEbGSrfTHMsK9raS5Nq1q2YP3rRacb+mPLylUvgjpt0qZ08vjo5S2ttDfCb3u1nrCxL5PPlgmRcsn1y2FyMv19+Ea1ykBqZHYLLG915y/z8hnOfFIY9i9TvBeLZGjE=
Received: from BN9PR03CA0259.namprd03.prod.outlook.com (2603:10b6:408:ff::24)
 by CO6PR12MB5425.namprd12.prod.outlook.com (2603:10b6:303:13e::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.22; Fri, 16 Jul
 2021 01:25:26 +0000
Received: from BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ff:cafe::34) by BN9PR03CA0259.outlook.office365.com
 (2603:10b6:408:ff::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.22 via Frontend
 Transport; Fri, 16 Jul 2021 01:25:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT038.mail.protection.outlook.com (10.13.176.246) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4331.21 via Frontend Transport; Fri, 16 Jul 2021 01:25:25 +0000
Received: from ozeng-develop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 15 Jul
 2021 20:25:23 -0500
From: Oak Zeng <Oak.Zeng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/5] drm/amdkfd: Renaming dqm->packets to dqm->dpm
Date: Thu, 15 Jul 2021 20:25:13 -0500
Message-ID: <1626398715-6419-4-git-send-email-Oak.Zeng@amd.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1626398715-6419-1-git-send-email-Oak.Zeng@amd.com>
References: <1626398715-6419-1-git-send-email-Oak.Zeng@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 556ba809-fe32-4b4e-dd41-08d947f896d1
X-MS-TrafficTypeDiagnostic: CO6PR12MB5425:
X-Microsoft-Antispam-PRVS: <CO6PR12MB54257ACA2F645D9390E7A73C80119@CO6PR12MB5425.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:275;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JGR43pZOFR1v6Sqc+Wgj7MRhsqtSVfPTNySIgvZSiJCwtbaUnvQQw/cQU+hNsXXOmiWbMdF264X27+l/SZAwlv0dGhgrnA4+Rwxt3m7w1krdA0X4O8OiPEmO87IcH1mN5uUy3Z0YI6U6RTHoHC8l3v7dOI6XZ3lZCIjO64QKfHRcvub7ka+nYRKUskt3ZgVLJoFqMOcyK8VdjX8m9/PDrsLSkFjHr7WsK+0ebPhtsiFL7xqiv6Y4Lbb2Jdz5qlw9/iKLzBtqoqodcdoc92rS2jsSRN7pTfw/80nDWmN364euBZpyMrz4o/I6pEu7HB+D82i7xXPD7wa08VslQ4JatGWlNVdX8ROR1DgOCpUQa5j5/0e9PSR1ilv+B/S8atK14kLeuASwhGKFkHUrpoVw9tE7nNRr239MEbBf2YgUGsGBKEmepL9CTMOBQCgfWtlmpWXB2DEh9j+6ydCNbcr3KV7RxemCRv8/f1evPNU7z+Gpj7+RQSJlGqgE6xLmz5UndkZDp5e2KbguBtsnVSHV7f5J4VnOMUg5Ftft0rXCBv13AP473+BXmFGWVD7/g9fNASA6cjo52+yNEOPW7lmtdKYoKVJafx5zGtUL4MUJC/Hr29bf5C1TyukJH/ecxj5knAuWYUqYqQhuXVYCUhrsQiHCIeEUamQ0TYkeIcaWR4mONHu3CshTX3ruXeL1YE3PkcJdkxBJ9t3uN/GaxLjO5XcMFML32RHmnYowv7oLCfo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(36840700001)(46966006)(356005)(82310400003)(83380400001)(81166007)(8676002)(70586007)(4326008)(8936002)(186003)(6666004)(336012)(36756003)(478600001)(86362001)(16526019)(2616005)(6916009)(7696005)(316002)(36860700001)(2906002)(47076005)(54906003)(5660300002)(70206006)(26005)(426003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2021 01:25:25.6893 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 556ba809-fe32-4b4e-dd41-08d947f896d1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5425
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
Cc: feifei.xu@amd.com, Felix.Kuehling@amd.com, leo.liu@amd.com,
 Oak Zeng <Oak.Zeng@amd.com>, hawking.zhang@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Renaming packets to dpm (device packet manager) to
reflect the real meaning of this variable.

Signed-off-by: Oak Zeng <Oak.Zeng@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c            |  2 +-
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.c  | 26 +++++++++++-----------
 .../gpu/drm/amd/amdkfd/kfd_device_queue_manager.h  |  2 +-
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c          |  2 +-
 4 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index 9e4a05e..c51402b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -1390,7 +1390,7 @@ int kfd_debugfs_hang_hws(struct kfd_dev *dev)
 		return -EINVAL;
 	}
 
-	r = pm_debugfs_hang_hws(&dev->dqm->packets);
+	r = pm_debugfs_hang_hws(&dev->dqm->dpm);
 	if (!r)
 		r = dqm_debugfs_execute_queues(dev->dqm);
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 16a1713..f2984d3 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -260,7 +260,7 @@ static int allocate_vmid(struct device_queue_manager *dqm,
 static int flush_texture_cache_nocpsch(struct kfd_dev *kdev,
 				struct qcm_process_device *qpd)
 {
-	const struct packet_manager_funcs *pmf = qpd->dqm->packets.pmf;
+	const struct packet_manager_funcs *pmf = qpd->dqm->dpm.pmf;
 	int ret;
 
 	if (!qpd->ib_kaddr)
@@ -1000,7 +1000,7 @@ static int start_nocpsch(struct device_queue_manager *dqm)
 	init_interrupts(dqm);
 	
 	if (dqm->dev->device_info->asic_family == CHIP_HAWAII)
-		return pm_init(&dqm->packets, dqm);
+		return pm_init(&dqm->dpm, dqm);
 	dqm->sched_running = true;
 
 	return 0;
@@ -1009,7 +1009,7 @@ static int start_nocpsch(struct device_queue_manager *dqm)
 static int stop_nocpsch(struct device_queue_manager *dqm)
 {
 	if (dqm->dev->device_info->asic_family == CHIP_HAWAII)
-		pm_uninit(&dqm->packets, false);
+		pm_uninit(&dqm->dpm, false);
 	dqm->sched_running = false;
 
 	return 0;
@@ -1124,7 +1124,7 @@ static int set_sched_resources(struct device_queue_manager *dqm)
 			"queue mask: 0x%8llX\n",
 			res.vmid_mask, res.queue_mask);
 
-	return pm_send_set_resources(&dqm->packets, &res);
+	return pm_send_set_resources(&dqm->dpm, &res);
 }
 
 static int initialize_cpsch(struct device_queue_manager *dqm)
@@ -1164,7 +1164,7 @@ static int start_cpsch(struct device_queue_manager *dqm)
 
 	retval = 0;
 
-	retval = pm_init(&dqm->packets, dqm);
+	retval = pm_init(&dqm->dpm, dqm);
 	if (retval)
 		goto fail_packet_manager_init;
 
@@ -1197,7 +1197,7 @@ static int start_cpsch(struct device_queue_manager *dqm)
 	return 0;
 fail_allocate_vidmem:
 fail_set_sched_resources:
-	pm_uninit(&dqm->packets, false);
+	pm_uninit(&dqm->dpm, false);
 fail_packet_manager_init:
 	return retval;
 }
@@ -1213,10 +1213,10 @@ static int stop_cpsch(struct device_queue_manager *dqm)
 	dqm->sched_running = false;
 	dqm_unlock(dqm);
 
-	pm_release_ib(&dqm->packets);
+	pm_release_ib(&dqm->dpm);
 
 	kfd_gtt_sa_free(dqm->dev, dqm->fence_mem);
-	pm_uninit(&dqm->packets, hanging);
+	pm_uninit(&dqm->dpm, hanging);
 
 	return 0;
 }
@@ -1390,7 +1390,7 @@ static int map_queues_cpsch(struct device_queue_manager *dqm)
 	if (dqm->active_runlist)
 		return 0;
 
-	retval = pm_send_runlist(&dqm->packets, &dqm->queues);
+	retval = pm_send_runlist(&dqm->dpm, &dqm->queues);
 	pr_debug("%s sent runlist\n", __func__);
 	if (retval) {
 		pr_err("failed to execute runlist\n");
@@ -1416,13 +1416,13 @@ static int unmap_queues_cpsch(struct device_queue_manager *dqm,
 	if (!dqm->active_runlist)
 		return retval;
 
-	retval = pm_send_unmap_queue(&dqm->packets, KFD_QUEUE_TYPE_COMPUTE,
+	retval = pm_send_unmap_queue(&dqm->dpm, KFD_QUEUE_TYPE_COMPUTE,
 			filter, filter_param, false, 0);
 	if (retval)
 		return retval;
 
 	*dqm->fence_addr = KFD_FENCE_INIT;
-	pm_send_query_status(&dqm->packets, dqm->fence_gpu_addr,
+	pm_send_query_status(&dqm->dpm, dqm->fence_gpu_addr,
 				KFD_FENCE_COMPLETED);
 	/* should be timed out */
 	retval = amdkfd_fence_wait_timeout(dqm->fence_addr, KFD_FENCE_COMPLETED,
@@ -1448,14 +1448,14 @@ static int unmap_queues_cpsch(struct device_queue_manager *dqm,
 	 * check those fields
 	 */
 	mqd_mgr = dqm->mqd_mgrs[KFD_MQD_TYPE_HIQ];
-	if (mqd_mgr->read_doorbell_id(dqm->packets.priv_queue->queue->mqd)) {
+	if (mqd_mgr->read_doorbell_id(dqm->dpm.priv_queue->queue->mqd)) {
 		pr_err("HIQ MQD's queue_doorbell_id0 is not 0, Queue preemption time out\n");
 		while (halt_if_hws_hang)
 			schedule();
 		return -ETIME;
 	}
 
-	pm_release_ib(&dqm->packets);
+	pm_release_ib(&dqm->dpm);
 	dqm->active_runlist = false;
 
 	return retval;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
index 71e2fde..14479e8 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
@@ -169,7 +169,7 @@ struct device_queue_manager {
 	struct device_queue_manager_asic_ops asic_ops;
 
 	struct mqd_manager	*mqd_mgrs[KFD_MQD_TYPE_MAX];
-	struct packet_manager	packets;
+	struct packet_manager	dpm;
 	struct kfd_dev		*dev;
 	struct mutex		lock_hidden; /* use dqm_lock/unlock(dqm) */
 	struct list_head	queues;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index b1ce072..748e82b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -1630,7 +1630,7 @@ int kfd_debugfs_rls_by_device(struct seq_file *m, void *data)
 		}
 
 		seq_printf(m, "Node %u, gpu_id %x:\n", i++, dev->gpu->id);
-		r = pm_debugfs_runlist(m, &dev->gpu->dqm->packets);
+		r = pm_debugfs_runlist(m, &dev->gpu->dqm->dpm);
 		if (r)
 			break;
 	}
-- 
2.7.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
