Return-Path: <SRS0=Hy8X=AR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8D28C433DF
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jul 2020 09:39:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 716FF2073E
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Jul 2020 09:39:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ydbIgaMJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 716FF2073E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 223E289144;
	Mon,  6 Jul 2020 09:39:50 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2070.outbound.protection.outlook.com [40.107.237.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7339089144
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Jul 2020 09:39:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VaHlLi11B99h6/bUw+fdb/+tVOH+XfmFAsrlTVg9CzJ5yIWzJwe+zFB/V5g+7bqzOi2gmrbG57hTV+tSjtqvafg/6aoxX8wvpqg0Mje9gWkQ7iQ98kWrX3mfyy7hU5HLf26siGUJvqiba4G/StagwQqG4fLBnhX+Im36qkWKdrZ27ITIR2ioS7rP0S9Apr316VrY7zmqW4Xa4rZgwDCHPCCa5vIiru2oX0D3sXZqCYYRYWiorgmDP+78+4NFRRFQi3ESRqQp1S3SHKcUDve4cf+y61axFdAJQ2YT7SxV9pMqzcbAp6PsPg4fZi8SqNrNwrMwv+iD3UDR7IG2EiKXfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FyHXTrMLnl6dDhmoBU7Xmn6ZsJ1M6WYtOPVtv23Q+Fs=;
 b=jw3PLQMYe7l2ZwDGOhK5R4v+mOAbcIZdbcqtTZ5s74mL5r2Fa1BWHpSgtcAzujVKjbnSt9fTW934onEpMTw07FQmSU6e8NJ8Ghup/w+Sr1Vfyn4KhSRIxe3AqjRRd75h6TxFnWHfcB4SDcFT1cT/qfC1o11OTu5DLCASuIrD+A0bgZcvnucGl4B8PU6ZQ9lHzBTxmehm3lAgL7sMb3z0ocgoaUOg7TsICCSyZmLX5V7k6xx1iclJlPahCCnjWe4OtY4+SN3fA5CRdawICo+qK88RXi9fPPQb/HdTNgbuiszX0czaBSfgp6YMhsSu2inYn1DUzxV8aQiftLQjIg7VdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FyHXTrMLnl6dDhmoBU7Xmn6ZsJ1M6WYtOPVtv23Q+Fs=;
 b=ydbIgaMJn3DHahkpqtNndKv3bPnIzMAZ9BGbDXYrKdzR//toDxKVa6bwIqLIoaxbqMXrO+OzP5qz0KGUoGMrlI5qZeYcrRhwiDhRPjq1CjVJiOFXeaXSzHR2EPRD6FJl1y4919kiLZNl3go0qnJ9h2A7fqdTqJ6R57JVNbKikEk=
Received: from CO2PR05CA0096.namprd05.prod.outlook.com (2603:10b6:104:1::22)
 by BY5PR12MB3890.namprd12.prod.outlook.com (2603:10b6:a03:1a7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.27; Mon, 6 Jul
 2020 09:39:40 +0000
Received: from CO1NAM11FT046.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:1:cafe::e2) by CO2PR05CA0096.outlook.office365.com
 (2603:10b6:104:1::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.8 via Frontend
 Transport; Mon, 6 Jul 2020 09:39:40 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT046.mail.protection.outlook.com (10.13.174.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3153.24 via Frontend Transport; Mon, 6 Jul 2020 09:39:40 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 6 Jul 2020
 04:39:39 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 6 Jul 2020
 04:39:38 -0500
Received: from yajunl-gv.amd.com (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Mon, 6 Jul 2020 04:39:31 -0500
From: Dennis Li <Dennis.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <Alexander.Deucher@amd.com>,
 <Tao.Zhou1@amd.com>, <Hawking.Zhang@amd.com>, <Guchun.Chen@amd.com>
Subject: [PATCH] drm/amdkfd: change to return status when flush tlb
Date: Mon, 6 Jul 2020 17:39:22 +0800
Message-ID: <20200706093922.21542-1-Dennis.Li@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(346002)(376002)(39860400002)(136003)(46966005)(5660300002)(83380400001)(426003)(2616005)(2906002)(86362001)(4326008)(36756003)(82310400002)(47076004)(70206006)(70586007)(356005)(82740400003)(81166007)(8936002)(6666004)(26005)(1076003)(336012)(6636002)(7696005)(186003)(8676002)(316002)(54906003)(110136005)(478600001)(2101003);
 DIR:OUT; SFP:1101; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 59f9b252-c4f4-44e0-47fd-08d821908157
X-MS-TrafficTypeDiagnostic: BY5PR12MB3890:
X-Microsoft-Antispam-PRVS: <BY5PR12MB3890351C6B02C9C9DDC6B200ED690@BY5PR12MB3890.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 04569283F9
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cDsRpc02kP3BXGWdDRfzViiGmr7VMO9nCKg9MXlXsB2NFlKQAEr0u8qdPJdWdV64KE/BcIdsbzpTSfgPVx+SH4ap3K2e6cmHCuWaOgkT5sfHxjTEhst+8rIkzt3gW3bVY9MVUImQJQgjOu1E6fr3jGB/xhchBq8pBx1ipPaIfRdVOiqUZ9ZCzWmvVEQ2A1sQNTPOuNVe/BiEpeZnVqQHOZZDzq9dINh7wVXWGGnyyIiC1TLVm1WyyeCxG4vnM52AlVg66ltjml8neYs1SXVI9IteE9yleqOtht0F2ZMnmLYiJrtr9UxVTFHxH2cS8j1I7AV5cv7td965sDgq8PA1pBQAxShUdyFmFIY90sesstH+iwCLe47KWRUC0OqUFYhdpgUODBAUkN9qBXuOfwqTORP7uDAMyuFtfShNm4MMSbI=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2020 09:39:40.0224 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59f9b252-c4f4-44e0-47fd-08d821908157
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT046.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3890
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
Cc: Dennis Li <dennis.li@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

If GPU hang, driver will fail to flush tlb, return the hang error
to callers, make callers have a chance to handle the error.

Signed-off-by: Dennis Li <dennis.li@amd.com>
Change-Id: Ie305ad0a77675f6eab7d5b8f68e279b7f4e7a8b9

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index e9b96ad3d9a5..18e243183b5e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -1488,7 +1488,7 @@ static int kfd_ioctl_map_memory_to_gpu(struct file *filep,
 		peer_pdd = kfd_get_process_device_data(peer, p);
 		if (WARN_ON_ONCE(!peer_pdd))
 			continue;
-		kfd_flush_tlb(peer_pdd);
+		err = kfd_flush_tlb(peer_pdd);
 	}
 
 	kfree(devices_arr);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 21eb0998c4ae..d636cbf7d32f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -263,6 +263,7 @@ static int allocate_vmid(struct device_queue_manager *dqm,
 			struct queue *q)
 {
 	int allocated_vmid = -1, i;
+	int ret = 0;
 
 	for (i = dqm->dev->vm_info.first_vmid_kfd;
 			i <= dqm->dev->vm_info.last_vmid_kfd; i++) {
@@ -295,13 +296,26 @@ static int allocate_vmid(struct device_queue_manager *dqm,
 			qpd->vmid,
 			qpd->page_table_base);
 	/* invalidate the VM context after pasid and vmid mapping is set up */
-	kfd_flush_tlb(qpd_to_pdd(qpd));
+	ret = kfd_flush_tlb(qpd_to_pdd(qpd));
+	if (ret) {
+		pr_err("Failed to flush tlb\n");
+		goto pro_failed;
+	}
 
 	if (dqm->dev->kfd2kgd->set_scratch_backing_va)
 		dqm->dev->kfd2kgd->set_scratch_backing_va(dqm->dev->kgd,
 				qpd->sh_hidden_private_base, qpd->vmid);
 
 	return 0;
+
+pro_failed:
+	/* Release the vmid mapping */
+	set_pasid_vmid_mapping(dqm, 0, qpd->vmid);
+	dqm->vmid_pasid[qpd->vmid] = 0;
+
+	qpd->vmid = 0;
+	q->properties.vmid = 0;
+	return ret;
 }
 
 static int flush_texture_cache_nocpsch(struct kfd_dev *kdev,
@@ -326,12 +340,17 @@ static void deallocate_vmid(struct device_queue_manager *dqm,
 				struct qcm_process_device *qpd,
 				struct queue *q)
 {
+	int ret = 0;
+
 	/* On GFX v7, CP doesn't flush TC at dequeue */
 	if (q->device->device_info->asic_family == CHIP_HAWAII)
 		if (flush_texture_cache_nocpsch(q->device, qpd))
 			pr_err("Failed to flush TC\n");
 
-	kfd_flush_tlb(qpd_to_pdd(qpd));
+	ret = kfd_flush_tlb(qpd_to_pdd(qpd));
+	if (ret) {
+		pr_err("Failed to flush tlb\n");
+	}
 
 	/* Release the vmid mapping */
 	set_pasid_vmid_mapping(dqm, 0, qpd->vmid);
@@ -795,7 +814,9 @@ static int restore_process_queues_nocpsch(struct device_queue_manager *dqm,
 				dqm->dev->kgd,
 				qpd->vmid,
 				qpd->page_table_base);
-		kfd_flush_tlb(pdd);
+		ret = kfd_flush_tlb(pdd);
+		if (ret)
+			goto out;
 	}
 
 	/* Take a safe reference to the mm_struct, which may otherwise
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 51ba2020732e..31ea72946d06 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -1081,7 +1081,7 @@ void kfd_signal_vm_fault_event(struct kfd_dev *dev, unsigned int pasid,
 
 void kfd_signal_reset_event(struct kfd_dev *dev);
 
-void kfd_flush_tlb(struct kfd_process_device *pdd);
+int kfd_flush_tlb(struct kfd_process_device *pdd);
 
 int dbgdev_wave_reset_wavefronts(struct kfd_dev *dev, struct kfd_process *p);
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 8616a204e4c3..3919cc88813c 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1444,21 +1444,24 @@ int kfd_reserved_mem_mmap(struct kfd_dev *dev, struct kfd_process *process,
 			       KFD_CWSR_TBA_TMA_SIZE, vma->vm_page_prot);
 }
 
-void kfd_flush_tlb(struct kfd_process_device *pdd)
+int kfd_flush_tlb(struct kfd_process_device *pdd)
 {
 	struct kfd_dev *dev = pdd->dev;
+	int ret = 0;
 
 	if (dev->dqm->sched_policy == KFD_SCHED_POLICY_NO_HWS) {
 		/* Nothing to flush until a VMID is assigned, which
 		 * only happens when the first queue is created.
 		 */
 		if (pdd->qpd.vmid)
-			amdgpu_amdkfd_flush_gpu_tlb_vmid(dev->kgd,
+			ret = amdgpu_amdkfd_flush_gpu_tlb_vmid(dev->kgd,
 							pdd->qpd.vmid);
 	} else {
-		amdgpu_amdkfd_flush_gpu_tlb_pasid(dev->kgd,
+		ret = amdgpu_amdkfd_flush_gpu_tlb_pasid(dev->kgd,
 						pdd->process->pasid);
 	}
+
+	return ret;
 }
 
 #if defined(CONFIG_DEBUG_FS)
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
