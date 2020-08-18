Return-Path: <SRS0=CyhX=B4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 317EBC433DF
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2020 16:09:03 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAD032076E
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2020 16:09:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="s63mQSh8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAD032076E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 710216E0A5;
	Tue, 18 Aug 2020 16:09:02 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2050.outbound.protection.outlook.com [40.107.220.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 987106E083
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Aug 2020 16:09:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DxpHVdimMJEtrZP76Xjmvp61kX55x4fRrwLoo1tjwtkavsNEDdkm7StdR5zZZ/qQ+1sNb6dGR5AfkIo8yrxh5YX+XczSo/W0BJdZHBidF8cLiyQdAmHLPxidnvI2jDqConODxVzVAwqdzDVUGOtYWm7IhtwQ8ettTzrRunKMYTdgKTD1z/nkHzpvdmUjdJIP3W7j2hcdNOChnCewno3oONOvqgMt1MGzx69s/dLIOdxydSPndcDxVwocMGaPn4d604b5xBLR2e+tCWSfH+QzTfQjgJC9o3UeKB7zmHtlEqaHPMkIoSt37WACn4G6DA+EuPsFU8KWW0GJwOVXwR/cGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0VCx4pEIdC4pb4xlSI2FPRmxNdfS0E/cgYh1SPW8AVA=;
 b=GjgK5/aBrN1xuT2Oqc8GhK1aKs2hFKwttAo43urrBQakJz0JcYqDKsRxfwnOg0SDc+iV7er8TvBaDnXNXJWFSagGFryXhl5gPMEx/HBh7SsmrVEKvWwBecCs3qQG/3nPVM9itJ7vF5sUsQFCRtBSz9Fy2G38A3jLpT037aSrJhLZh6fh2qA+U55uuL5hfvI1RWi8h5/3VToFIxpv17GZzM6Hxr8jiHx0tl2DabwoAigjq/xvF2bu8Xl/vaEnzSlT35QjIBdE/qvXsix3TXTJV8RsdqiJeXjHzJVB55lWZXuF1CM7nEg+BuC7OV/YmndDS84wPvY/Xs/HrodKf0FajA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0VCx4pEIdC4pb4xlSI2FPRmxNdfS0E/cgYh1SPW8AVA=;
 b=s63mQSh8fon0S0DTC5vfuEelK5KdXszeFZ3DEwJzFEwAVe4H3+MtI3bKGRrVZok4R7DIeotgUBDCHYI0k2nKbTM5o1lV3XmrAgeGjCQ/kBEJcnxQu3LpoiIDU5g3lqCqz23lX8kv49OcDQb/edY106iDwY7vQylI1mTIY73mh54=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BN7PR12MB2738.namprd12.prod.outlook.com (2603:10b6:408:2d::11)
 by BN8PR12MB3219.namprd12.prod.outlook.com (2603:10b6:408:9b::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.20; Tue, 18 Aug
 2020 16:08:58 +0000
Received: from BN7PR12MB2738.namprd12.prod.outlook.com
 ([fe80::89a3:6be6:c99:23a4]) by BN7PR12MB2738.namprd12.prod.outlook.com
 ([fe80::89a3:6be6:c99:23a4%7]) with mapi id 15.20.3283.028; Tue, 18 Aug 2020
 16:08:58 +0000
From: Mukul Joshi <mukul.joshi@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v3] drm/amdkfd: sparse: Fix warning in reading SDMA counters
Date: Tue, 18 Aug 2020 12:08:45 -0400
Message-Id: <20200818160845.27134-1-mukul.joshi@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: YTOPR0101CA0059.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::36) To BN7PR12MB2738.namprd12.prod.outlook.com
 (2603:10b6:408:2d::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Ryzen-3700X.amd.com (165.204.55.251) by
 YTOPR0101CA0059.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::36) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24 via Frontend
 Transport; Tue, 18 Aug 2020 16:08:58 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c6d04c10-1396-4451-13fc-08d8439103d0
X-MS-TrafficTypeDiagnostic: BN8PR12MB3219:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR12MB321922F81F53808207C933A6EE5C0@BN8PR12MB3219.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:478;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: puDhqFawgpaxUd/30Sz6otnmNiIrMU+ocRcMRCRCEkx9H/SDEVGGi7aTbr/ibQZcLYFbw4fh2lPR3A+zzTALMEd0EtCg+FevkmtPa5Gjy6aG7eeesJ0hCaRKIMKpvmi0uxLOD546LIbTNbCKKc5H0cOOq2HUQG+4eXj3vGWyJ9o44wFKdymbXzB2PHD4yOqGbpvFYG2WK72Sn74LwxqGWwdeNFM3H4Fto2vJVxfA9vi824iS5+sMH0XB+O3bKwasy4jXu3fjaiTKSJNdsMiTgk4UQAXSQ7tRnlX3tzgT+6QL0R+SSzjCVjOUxWEKzkGFov5sTTj0iq/VEqan+mq1Yg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PR12MB2738.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(366004)(396003)(346002)(136003)(376002)(4326008)(956004)(16526019)(86362001)(186003)(6666004)(8676002)(2906002)(478600001)(2616005)(5660300002)(6486002)(66556008)(52116002)(7696005)(66476007)(83380400001)(8936002)(36756003)(1076003)(26005)(44832011)(6916009)(66946007)(316002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: t8Ltjo3OBu6yQdvy7Wm77VW1qsj2R4zLaBR0ipFamgKJ8kEuzga+eEHWDbD4D0/ke3SbPrtg51c5ilqPmYI7yjBeK9/JODoFU27TswK0MqxF8ts0J40lN7tjbp/kKiAE32saGhaDpIN3cSbKWVzahtsFyfSGOgkOM7FsqN63blcSIf1uknWbYbENIRsPtdb43q89dTGdT7HrwMuZ3TzkUgwoO0bogNW+/jdGLAv1i6nhvyAf0tBY4xuc+F3bKhJEwc+SgT1ZFnGMYHHx/J19LWo+14tvlQCbZMfpNxVvhaseLnskjOiR+vOZG7KQub9RoCoiQhU53cxVyLJ1sxl8vwodDsOZOJ6jDmpTUmvdZlX+/On3vBkI1rDQmwGVPQp8uS6OotIkAdS0BxYb0LfVZIK0FMt8SLcEsOods6WZZ0nYmm+CEZWpNBM5v1yn575XhSmPg6lalZiQ3NZe8OwwKGSlONwVk/pm6t/bjh5sd0DM+kkSG1i9XuIGRcONiT2nMnX4/wZ+ZbM0Oftxd7XJCvLa7hsIIPQp7oGVkie8RDKcIGjC0Q7l9ftpp25YwF7WrDj+7O5+uKbyrOCun2yXP92puug/xmUeOAvSNYx44C2fz+B7nxbQh3ucbgQ0RfSerVvaIcO2b5oTdr4+J1ISMQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6d04c10-1396-4451-13fc-08d8439103d0
X-MS-Exchange-CrossTenant-AuthSource: BN7PR12MB2738.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2020 16:08:58.8471 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bFIyx1Uh1vcGHPrqEHXjUHZtbQpxl7olACiMhfrM3ub7rXVLRNWE3gHMt4jw2m3s4kSR7cmF9urp8pr2NoCGqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3219
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
Cc: Mukul Joshi <mukul.joshi@amd.com>, Felix.Kuehling@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Add __user annotation to fix related sparse warning while reading
SDMA counters from userland.
Also, rework the read SDMA counters function by removing redundant
checks.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Mukul Joshi <mukul.joshi@amd.com>
---
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 28 ++-----------------
 .../drm/amd/amdkfd/kfd_device_queue_manager.h |  8 +++++-
 drivers/gpu/drm/amd/amdkfd/kfd_process.c      |  6 ++--
 3 files changed, 12 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index e0e60b0d0669..560adc57a050 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -153,30 +153,6 @@ static void decrement_queue_count(struct device_queue_manager *dqm,
 		dqm->active_cp_queue_count--;
 }
 
-int read_sdma_queue_counter(uint64_t q_rptr, uint64_t *val)
-{
-	int ret;
-	uint64_t tmp = 0;
-
-	if (!val)
-		return -EINVAL;
-	/*
-	 * SDMA activity counter is stored at queue's RPTR + 0x8 location.
-	 */
-	if (!access_ok((const void __user *)(q_rptr +
-					sizeof(uint64_t)), sizeof(uint64_t))) {
-		pr_err("Can't access sdma queue activity counter\n");
-		return -EFAULT;
-	}
-
-	ret = get_user(tmp, (uint64_t *)(q_rptr + sizeof(uint64_t)));
-	if (!ret) {
-		*val = tmp;
-	}
-
-	return ret;
-}
-
 static int allocate_doorbell(struct qcm_process_device *qpd, struct queue *q)
 {
 	struct kfd_dev *dev = qpd->dqm->dev;
@@ -552,7 +528,7 @@ static int destroy_queue_nocpsch(struct device_queue_manager *dqm,
 	/* Get the SDMA queue stats */
 	if ((q->properties.type == KFD_QUEUE_TYPE_SDMA) ||
 	    (q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI)) {
-		retval = read_sdma_queue_counter((uint64_t)q->properties.read_ptr,
+		retval = read_sdma_queue_counter((uint64_t __user *)q->properties.read_ptr,
 							&sdma_val);
 		if (retval)
 			pr_err("Failed to read SDMA queue counter for queue: %d\n",
@@ -1473,7 +1449,7 @@ static int destroy_queue_cpsch(struct device_queue_manager *dqm,
 	/* Get the SDMA queue stats */
 	if ((q->properties.type == KFD_QUEUE_TYPE_SDMA) ||
 	    (q->properties.type == KFD_QUEUE_TYPE_SDMA_XGMI)) {
-		retval = read_sdma_queue_counter((uint64_t)q->properties.read_ptr,
+		retval = read_sdma_queue_counter((uint64_t __user *)q->properties.read_ptr,
 							&sdma_val);
 		if (retval)
 			pr_err("Failed to read SDMA queue counter for queue: %d\n",
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
index 49d8e324c636..16262e5d93f5 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.h
@@ -251,5 +251,11 @@ static inline void dqm_unlock(struct device_queue_manager *dqm)
 	mutex_unlock(&dqm->lock_hidden);
 }
 
-int read_sdma_queue_counter(uint64_t q_rptr, uint64_t *val);
+static inline int read_sdma_queue_counter(uint64_t __user *q_rptr, uint64_t *val)
+{
+        /*
+         * SDMA activity counter is stored at queue's RPTR + 0x8 location.
+         */
+	return get_user(*val, q_rptr + 1);
+}
 #endif /* KFD_DEVICE_QUEUE_MANAGER_H_ */
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 4480f905814c..ff7686250ae0 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -87,7 +87,7 @@ struct kfd_sdma_activity_handler_workarea {
 };
 
 struct temp_sdma_queue_list {
-	uint64_t rptr;
+	uint64_t __user *rptr;
 	uint64_t sdma_val;
 	unsigned int queue_id;
 	struct list_head list;
@@ -159,7 +159,7 @@ static void kfd_sdma_activity_worker(struct work_struct *work)
 		}
 
 		INIT_LIST_HEAD(&sdma_q->list);
-		sdma_q->rptr = (uint64_t)q->properties.read_ptr;
+		sdma_q->rptr = (uint64_t __user *)q->properties.read_ptr;
 		sdma_q->queue_id = q->properties.queue_id;
 		list_add_tail(&sdma_q->list, &sdma_q_list.list);
 	}
@@ -218,7 +218,7 @@ static void kfd_sdma_activity_worker(struct work_struct *work)
 			continue;
 
 		list_for_each_entry_safe(sdma_q, next, &sdma_q_list.list, list) {
-			if (((uint64_t)q->properties.read_ptr == sdma_q->rptr) &&
+			if (((uint64_t __user *)q->properties.read_ptr == sdma_q->rptr) &&
 			     (sdma_q->queue_id == q->properties.queue_id)) {
 				list_del(&sdma_q->list);
 				kfree(sdma_q);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
