Return-Path: <SRS0=BZXp=2K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5A31C2D0C0
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Dec 2019 08:30:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC55B227BF
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Dec 2019 08:30:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Ajkexxor"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC55B227BF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0087A89C68;
	Fri, 20 Dec 2019 08:30:24 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2069.outbound.protection.outlook.com [40.107.220.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 18F1889C0D
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Dec 2019 08:30:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dEDa9XEb9sRKf1teJKnRsYI+1RWJwZNnOt3+pn3Y/TrQ1lRaEunGxrCj+bcVUjL08n679XCS/GeBDDL9Zdhcg/gtqbv5ua2P/Fz5pt5rDF3ItUsiNMS+2HFL+qheAs9FQ/XZ88RE9BYQXn687aIuQUw2SQ0vot5pJoHoTE/7mgrdodmGZvJXHJqiPJ5rarKCvBX1MyKk1/YzPuwpn+5SeUe43FZyizFSV0g/vRklLcp5AVN8r1DwR12IQC+htlNFGtEYGNfPlI4bSz+M7MUB8mnWkRuOw05wlMNhRHMkhG6SUhulYTGcwzU81wjhNlIqKCK74l5lJAm5NRIyklpGNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QYbz3fpXQSzGXkYvMu83300yOEFuVs8/ojTQqxoU3hQ=;
 b=nLDzMSAFghbiSMSA76prV4jCapqK4xJPEcXHKGkwluoCr79MBMQBnZ6C/n9DYBM/4jiQKFGZo8eJGhZYHLZZSENz09FUZMJmoOIiiBITni/VI5lIGrN7vBaxGLnT94xBi20UcvlRDw2WNNUXyhlzvxSURg/oaruCtt7KdDc3RG5yiKBpLFD/53wY7Fk4F3PgDV9Nya7OEqFJPbKMnQhG7o/5A5Q1ZZGw0LZn+1BKWoxQP+XcirTtuCIBysvHVilI0WOkLiR/V+FEvDTImKTfXwZBnHPlJ97Wfjc5ANBMXQy/BPwxYK1zaHjR0e+vViRmmTtuw/fj2eNyC0DTj3FCKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QYbz3fpXQSzGXkYvMu83300yOEFuVs8/ojTQqxoU3hQ=;
 b=AjkexxoribDhnZsoqZ5+xEVEBGrgu+pg6SLgXTEyvdz4cA5V2hvnIlSG3HCrNqlVAv6lp7ay07X6ZSj9RU/IyhhjCEUhAjZFdwCZs+d7e1oP/Lm/t2NCD11lIQZMH12vJsdyiOWYL6cyf+cgUOsmmHnnTrUDrq2jsuHAZx1q/ck=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Felix.Kuehling@amd.com; 
Received: from MN2PR12MB3949.namprd12.prod.outlook.com (10.255.237.150) by
 MN2PR12MB3215.namprd12.prod.outlook.com (20.179.82.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.15; Fri, 20 Dec 2019 08:30:22 +0000
Received: from MN2PR12MB3949.namprd12.prod.outlook.com
 ([fe80::d5cc:e5d3:2351:5c08]) by MN2PR12MB3949.namprd12.prod.outlook.com
 ([fe80::d5cc:e5d3:2351:5c08%6]) with mapi id 15.20.2559.015; Fri, 20 Dec 2019
 08:30:22 +0000
From: Felix Kuehling <Felix.Kuehling@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/4] drm/amdkfd: Improve HWS hang detection and handling
Date: Fri, 20 Dec 2019 03:30:00 -0500
Message-Id: <20191220083001.30607-3-Felix.Kuehling@amd.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191220083001.30607-1-Felix.Kuehling@amd.com>
References: <20191220083001.30607-1-Felix.Kuehling@amd.com>
X-ClientProxiedBy: YTBPR01CA0008.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::21) To MN2PR12MB3949.namprd12.prod.outlook.com
 (2603:10b6:208:167::22)
MIME-Version: 1.0
Received: from Harpoon.amd.com (165.204.55.251) by
 YTBPR01CA0008.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=) via Frontend Transport;
 Fri, 20 Dec 2019 08:30:21 +0000
X-Mailer: git-send-email 2.24.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 46444fe2-789d-4c97-c2dd-08d78526da4f
X-MS-TrafficTypeDiagnostic: MN2PR12MB3215:
X-Microsoft-Antispam-PRVS: <MN2PR12MB321538AF043192937BA57AE0922D0@MN2PR12MB3215.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-Forefront-PRVS: 025796F161
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(346002)(376002)(39860400002)(366004)(396003)(199004)(189003)(43544003)(1076003)(52116002)(6666004)(5660300002)(36756003)(186003)(16526019)(2906002)(7696005)(6486002)(316002)(66556008)(66476007)(478600001)(6916009)(956004)(26005)(66946007)(2616005)(81156014)(8676002)(86362001)(8936002)(81166006);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3215;
 H:MN2PR12MB3949.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: et0PnKDrMLL1xhVELtsTQkbr1mYbmLhzFgWyw95Bpl3mNnrB2HKMZ8yq8UccY7ducDud2nRampZB6ylEkf4ysbR9uVP6F+Phbd5saPCK69Q9biKSaZJBL4o7vYCagAkM67wlT+fkwqrb6Gjj4f1jXv7v1XWHkZCblgmzt8CgGsaCj661kolEE7QL8szLkQdyDg8sS3DRoUUffYfHfo5ShexEHzlSxG9+ZT4s50kXhC3mWM7rSSEZhQcFWde3epEFyFfyEoUiPEJ58VfOq/7xHbs1gqyDlOalw5mDr+Lll9XCVUL+3T/XjCkNVZb/oKL4x3wY6btxyd4qkyVWEDmegN0IIKo+TLLdjvBZu9CC/Cf0W72Ml6dC4Y9pfQC4Awk8C7PbayZYacfSfEmZ3UycdN8FbZsVlX8L0cgCmS9IRKYH8xqk0zpdhLlXHR2+qWBEKmSuuKNqgcDsLF4UcjbRuTG5/pBdtW9Faiie5DNJimOBj+BeQd4pAoEXqBmpjo35
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46444fe2-789d-4c97-c2dd-08d78526da4f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2019 08:30:21.7394 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6rxA1x9fOUXTWchzGvZ7cDBw4WUv48PlcdYBibEO0TuO4cqi+Pvt5xJjrXrIdPP82oYWc9G3UbemRfQV1MsbMQ==
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Move HWS hand detection into unmap_queues_cpsch to catch hangs in all
cases. If this happens during a reset, don't schedule another reset
because the reset already in progress is expected to take care of it.

Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c       |  3 +++
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 27 ++++++++++++++-----
 .../drm/amd/amdkfd/kfd_device_queue_manager.h |  2 ++
 3 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
index c6b6901bbda3..2a9e40131735 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -728,6 +728,9 @@ int kgd2kfd_pre_reset(struct kfd_dev *kfd)
 {
 	if (!kfd->init_complete)
 		return 0;
+
+	kfd->dqm->ops.pre_reset(kfd->dqm);
+
 	kgd2kfd_suspend(kfd);
 
 	kfd_signal_reset_event(kfd);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 558c0ad81848..a7e9ec1b3ce3 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -952,6 +952,13 @@ static int stop_nocpsch(struct device_queue_manager *dqm)
 	return 0;
 }
 
+static void pre_reset(struct device_queue_manager *dqm)
+{
+	dqm_lock(dqm);
+	dqm->is_resetting = true;
+	dqm_unlock(dqm);
+}
+
 static int allocate_sdma_queue(struct device_queue_manager *dqm,
 				struct queue *q)
 {
@@ -1099,6 +1106,7 @@ static int start_cpsch(struct device_queue_manager *dqm)
 	dqm_lock(dqm);
 	/* clear hang status when driver try to start the hw scheduler */
 	dqm->is_hws_hang = false;
+	dqm->is_resetting = false;
 	dqm->sched_running = true;
 	execute_queues_cpsch(dqm, KFD_UNMAP_QUEUES_FILTER_DYNAMIC_QUEUES, 0);
 	dqm_unlock(dqm);
@@ -1351,8 +1359,17 @@ static int unmap_queues_cpsch(struct device_queue_manager *dqm,
 	/* should be timed out */
 	retval = amdkfd_fence_wait_timeout(dqm->fence_addr, KFD_FENCE_COMPLETED,
 				queue_preemption_timeout_ms);
-	if (retval)
+	if (retval) {
+		pr_err("The cp might be in an unrecoverable state due to an unsuccessful queues preemption\n");
+		dqm->is_hws_hang = true;
+		/* It's possible we're detecting a HWS hang in the
+		 * middle of a GPU reset. No need to schedule another
+		 * reset in this case.
+		 */
+		if (!dqm->is_resetting)
+			schedule_work(&dqm->hw_exception_work);
 		return retval;
+	}
 
 	pm_release_ib(&dqm->packets);
 	dqm->active_runlist = false;
@@ -1370,12 +1387,8 @@ static int execute_queues_cpsch(struct device_queue_manager *dqm,
 	if (dqm->is_hws_hang)
 		return -EIO;
 	retval = unmap_queues_cpsch(dqm, filter, filter_param);
-	if (retval) {
-		pr_err("The cp might be in an unrecoverable state due to an unsuccessful queues preemption\n");
-		dqm->is_hws_hang = true;
-		schedule_work(&dqm->hw_exception_work);
+	if (retval)
 		return retval;
-	}
 
 	return map_queues_cpsch(dqm);
 }
@@ -1769,6 +1782,7 @@ struct device_queue_manager *device_queue_manager_init(struct kfd_dev *dev)
 		dqm->ops.initialize = initialize_cpsch;
 		dqm->ops.start = start_cpsch;
 		dqm->ops.stop = stop_cpsch;
+		dqm->ops.pre_reset = pre_reset;
 		dqm->ops.destroy_queue = destroy_queue_cpsch;
 		dqm->ops.update_queue = update_queue;
 		dqm->ops.register_process = register_process;
@@ -1787,6 +1801,7 @@ struct device_queue_manager *device_queue_manager_init(struct kfd_dev *dev)
 		/* initialize dqm for no cp scheduling */
 		dqm->ops.start = start_nocpsch;
 		dqm->ops.stop = stop_nocpsch;
+		dqm->ops.pre_reset = pre_reset;
 		dqm->ops.create_queue = create_queue_nocpsch;
 		dqm->ops.destroy_queue = destroy_queue_nocpsch;
 		dqm->ops.update_queue = update_queue;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
index 8991120c4fa2..871d3b628d2d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
@@ -104,6 +104,7 @@ struct device_queue_manager_ops {
 	int	(*initialize)(struct device_queue_manager *dqm);
 	int	(*start)(struct device_queue_manager *dqm);
 	int	(*stop)(struct device_queue_manager *dqm);
+	void	(*pre_reset)(struct device_queue_manager *dqm);
 	void	(*uninitialize)(struct device_queue_manager *dqm);
 	int	(*create_kernel_queue)(struct device_queue_manager *dqm,
 					struct kernel_queue *kq,
@@ -198,6 +199,7 @@ struct device_queue_manager {
 
 	/* hw exception  */
 	bool			is_hws_hang;
+	bool			is_resetting;
 	struct work_struct	hw_exception_work;
 	struct kfd_mem_obj	hiq_sdma_mqd;
 	bool			sched_running;
-- 
2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
