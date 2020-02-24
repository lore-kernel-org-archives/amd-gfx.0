Return-Path: <SRS0=KDYH=4M=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24D25C38BFA
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Feb 2020 22:18:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8439218AC
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Feb 2020 22:18:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="deETiQFw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8439218AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 988686E882;
	Mon, 24 Feb 2020 22:18:58 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2066.outbound.protection.outlook.com [40.107.244.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BFE186E994
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Feb 2020 22:18:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AO87KBborDNi85bjy1ELPV3E9r1LyAPBVOz1LpPJuo7O4oU/slnv75lYYL9BM947OV5NHgEZMSYVIcZyVqWMrMiUbY7Sy8Qa9bPGBcGU/NaPAjTmiIIzzo9yqPig6iOPHRHKXPLpisR/IdTwo+kJr0GAqvGSObuA+F+p4AO2ST65Iiex6g0Ce9hMz8VCTtbnbX0OQJi/gJLb5RCZp7L+H7mBpq+E7TZ+pW05KoPme47CWjK0s/yznAoJ9cE+T6ePx/44qo3qdYDmlSWdiELBaPDchmbiq/rg5/uCuZoIT5Wxj8crDZPALNX7ipYtCKNTSV2SDFwQg9KXGBEO57ohLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BgrvGtU5ssSe0DwsWSzuvarCGDCI707fuEBEjMPFFnI=;
 b=eH/427At5uW8kMKsr2H9xCt1xJvuUpB8GLNIKryY8ebavpuRninuIABFsGHXDqF88GU7uOczHSUtWbP84GbQvf7ZNC56ejvlTc2w7VRF6EgKF3/CJc10r2XPYzuxoRvFKu8Zfp77fKOwIXwCNKkkuvFP/neSDaHZlNpR7T2hoTTvWNnshzQW9iXJBuTxUrIHenNURwcejuzoZCUv/Qxk1IZB++nN53sH+/pix+U4Fvoz11u47j468k20YVqZLJVAF/cnXz/Ejrmtf3LNOmqeMKKxxVuIah3RXylt9e6x2QpVwmxSH0wMWnZC/gfvVegArCOhQ/tn5I3wIryLUGiHtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BgrvGtU5ssSe0DwsWSzuvarCGDCI707fuEBEjMPFFnI=;
 b=deETiQFwzirsBdd+EPJK4Z11kdX0PnHb9UiOaVSDLm5n0qIEfCGcqnHR3EENRhwIKZVz8KeYX3hcIeSfzAz98dKyMiSCplNRGDWbjRMoDeHeyDfOMv/9PNd4OQ2O9ruB41QXV8r4vwYWkiU5PwolMCtEZqiOHj1FsinsVjL/9Z0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yong.Zhao@amd.com; 
Received: from CH2PR12MB3926.namprd12.prod.outlook.com (2603:10b6:610:27::30)
 by CH2PR12MB3749.namprd12.prod.outlook.com (2603:10b6:610:2a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.21; Mon, 24 Feb
 2020 22:18:56 +0000
Received: from CH2PR12MB3926.namprd12.prod.outlook.com
 ([fe80::81de:623c:a226:a92d]) by CH2PR12MB3926.namprd12.prod.outlook.com
 ([fe80::81de:623c:a226:a92d%4]) with mapi id 15.20.2750.021; Mon, 24 Feb 2020
 22:18:56 +0000
From: Yong Zhao <Yong.Zhao@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/6] drm/amdkfd: Avoid ambiguity by indicating it's cp queue
Date: Mon, 24 Feb 2020 17:18:38 -0500
Message-Id: <20200224221842.14110-2-Yong.Zhao@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200224221842.14110-1-Yong.Zhao@amd.com>
References: <20200224221842.14110-1-Yong.Zhao@amd.com>
X-ClientProxiedBy: YTXPR0101CA0021.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::34) To CH2PR12MB3926.namprd12.prod.outlook.com
 (2603:10b6:610:27::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from yong-dev.amd.com (165.204.55.251) by
 YTXPR0101CA0021.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::34) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.18 via Frontend Transport; Mon, 24 Feb 2020 22:18:56 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b80a829e-93f2-4d88-9909-08d7b9778a0c
X-MS-TrafficTypeDiagnostic: CH2PR12MB3749:|CH2PR12MB3749:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CH2PR12MB3749EA83F91C431C271E4EE5F0EC0@CH2PR12MB3749.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 032334F434
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(39860400002)(366004)(376002)(346002)(136003)(189003)(199004)(36756003)(52116002)(2906002)(5660300002)(86362001)(7696005)(66556008)(66476007)(66946007)(4326008)(6666004)(478600001)(8676002)(81156014)(1076003)(81166006)(26005)(6486002)(316002)(8936002)(186003)(6916009)(16526019)(2616005)(956004);
 DIR:OUT; SFP:1101; SCL:1; SRVR:CH2PR12MB3749;
 H:CH2PR12MB3926.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Dk6LV47/RWOREeQh1O2uDC4ygTYPZjpOMq+xSYlIVNLgCMkYIuCjylIIl7qiY6Du2sOCS1hbguacLGOPljj7Msy4Q/AvhqntMsIcmgRHgyxGFogEMj8PuW2tAFdz6KSVSv4/AQRwYjzgu9sP004WVtW+jiRN5P47xmbAihogQtCnCdP3TcdrGHxo70f7k932wpSary2xKhCRB7z6/s/BV4oH3rkqiq0QJhDAhgabQTDAaATmnSdTtqp7IxAccgjE2DD9Z5MCSNmFGwKYVKiFIy8CueghpPzzVyQBDumEFA8y/wcPadDT34pXesruIxuzZc0UFeGK84WfAoB84yyEY3gQTK1pSuMZmJ74pkZtfUR6SqGXlEM6aodw7AYxH8LGNmIJSSrCoAAJltMkYAUFkVtoyaJ5G8LI7VdNGc2KZ5P1dObzx5DAtiWF5zag8STw
X-MS-Exchange-AntiSpam-MessageData: Lw8vz7nGOlmFQ+4cBokiJMfAdKkqBDOExVphDLZ9omCvMrAlzU2vkDA2UIc1S47ecnnuke6AvsCFUGbvXRlwBWoT9vtiPmQatdp0Mismab0x3BV+XZh8tgVPE6KZ+CXeTkZ8oBY8GVLUJmO+/cnYHg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b80a829e-93f2-4d88-9909-08d7b9778a0c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2020 22:18:56.6751 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wSuQdlzKuOt8gKZ/CK/v08/5qizNYxVdvYTizvj+Z/36hig2/Nsx1nZ+eD6FhXDL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3749
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
