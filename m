Return-Path: <SRS0=Dt/2=AZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 956C5C433E8
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 04:38:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6859D21D90
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Jul 2020 04:38:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Prs7b+OF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6859D21D90
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 202846E8B5;
	Tue, 14 Jul 2020 04:38:26 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2044.outbound.protection.outlook.com [40.107.92.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E40AC6E8B5
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Jul 2020 04:38:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nJqHfpxOQsoe8DODVey+o2IYdCZ2kN3jX7wm/mJWr/buRcsPijVmaqcI21wbwpJyC/kNhztRkiZLsRScj6nL82B8GCXySEgWLcPDLdbJ7LNASBzGh7LCRnTs2Q5SUKAvdL2Jlhwj35yAcNrBYByMiGK+aAtotgzPkn4Wq6yI3ZUQb3kPjUJvJGIl+pu12NQg7V1dH1w3qAaN+zm0az85e7mJCnhFfGPbKejDPXw0C/YrvFVJHkKBcVqLzuDgnaFinmNc/s2Tehxd9CYV0qHsdcj0/IuQq+oIKRTNwfGS96lhXvEl6YjexF8oSSzBxC+YBi5X9X9gWOuuuGqzfSl1jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x3DXWCjjOKrTKcYrOtLApUAdmBSKyG741WxpnPUUtok=;
 b=NeDTg0dGRhfzNFg0TKr07gik/hUClBQwrRRxMaJXStNrI/u522L7yI/T/p5Tn2Yl4Wo+kV0rMZymFxrEQSMBJI4LKXHIDtcLUd6gONe7krSLL2fWfjTO1oEnLH/kpDVejkZjiL/qh44fqNVkj0xpnxWby9DFPDrH5Pzv2M5C0f4bnviFz6cV1ETCuRBgo5CfOvTSRhzjAJsWWllIDQe6sT1xEgO9TTOq6XcqNxdaHDXJhZDpOPs9wvZ2sqP42WpmWYtVnjjvRSr/HZ8wlu5y28Dw9JAI4QkYAqNIcrcRsPyweGzAw9d5evqTo3S7NroN7ciUpbahrUPsKOi1o7xpOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x3DXWCjjOKrTKcYrOtLApUAdmBSKyG741WxpnPUUtok=;
 b=Prs7b+OFj+fSZU8U7KI61903raRSZY8qYnNcLIrEjhKNC95sTQB7960O6TaYcZDwx1QrDpE3mwy6+7VDjoFr3TVffi2CDLxxa0c13i3fkE4gjdqKBAyrGHcNtcsan4cvDCkXPrzvBBJlbC5KhyYLH68RoD4Y7DKGrehrvso7vlg=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BN7PR12MB2692.namprd12.prod.outlook.com (2603:10b6:408:2a::10)
 by BN6PR1201MB0067.namprd12.prod.outlook.com (2603:10b6:405:57::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22; Tue, 14 Jul
 2020 04:38:17 +0000
Received: from BN7PR12MB2692.namprd12.prod.outlook.com
 ([fe80::e417:591:1184:f525]) by BN7PR12MB2692.namprd12.prod.outlook.com
 ([fe80::e417:591:1184:f525%7]) with mapi id 15.20.3174.026; Tue, 14 Jul 2020
 04:38:17 +0000
From: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdkfd: fix kernel-doc and cleanup
Date: Tue, 14 Jul 2020 00:38:03 -0400
Message-Id: <20200714043803.9967-1-rajneesh.bhardwaj@amd.com>
X-Mailer: git-send-email 2.17.1
X-ClientProxiedBy: YTOPR0101CA0019.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:15::32) To BN7PR12MB2692.namprd12.prod.outlook.com
 (2603:10b6:408:2a::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from rajneesh-desk.amd.com (165.204.55.251) by
 YTOPR0101CA0019.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:15::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21 via Frontend
 Transport; Tue, 14 Jul 2020 04:38:16 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5f9f777d-2fba-48dd-3406-08d827afba22
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0067:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR1201MB00675F2287D30137F34FB7D8FE610@BN6PR1201MB0067.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rDk/GaMQ3+kI3nxFhLrzq3FEiLQbXEG0h0eFJBiJ3eX+QQfOxjuQ1e7GUvwp0eqMjaGF7gbyIuaTynGMIbMmpgUxUndhPFw1PFvj73DsIcIMw1PkAPKTHPfL9OsC2WEhR2o22gZDEd75ivNfdF12O3IxDQwokrbfVNuRQ80xokNELjExdd+e2YdOwGuB7FPR6oYbVfHoZ3/UMnpjpAd65XfpTTW/winq0bETKXBfH0oGIf5/v7ODlj6EQCxUMl9Jjij/Z5bOZSKgP3niW+Eni2vGzFHsKU1pGDxzb66QKk/INsmF0L2V/tS8jpAJeZ4Z8d4V1KKA11Xx/DhKrlmsDQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PR12MB2692.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(346002)(136003)(396003)(376002)(366004)(2616005)(4326008)(6666004)(956004)(52116002)(7696005)(5660300002)(1076003)(2906002)(86362001)(44832011)(36756003)(83380400001)(478600001)(8676002)(8936002)(66476007)(6916009)(66556008)(6486002)(66946007)(316002)(16526019)(26005)(186003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: m/cLHtA6SIrmYRI4VANDkyNvdexQmKouBhmvFfAaTEKz7wSrKifWz3FHheaH421z1Kxepk4KWx8L6+rj36dnTf9xyJO6ANN8uyc4VEbO9fPmljdKBwmy25WOVsbEOKFp+WTJRDDcSfVnlQJe2EfYaVBHJ6CUa+L0yQ8MG5ToNKADXJa90MLMljmoiYDT4SBYZIep85JBV+H/E1gvlEz0lsRbC4dLVXcTml+Bh84o4f2DJ9hfjQaTmDBLM8vPii7PWhHGVwsnp9mPKbl1QUXqolEpxUsONDuRfmUhD1HWEyD7X1h3dAuOYtnq79u9Ltsuv0k6beZc7D5Aj5sF0jKK8xbws0lLF/tTZ8w7bP/qZUr5271mXR8jBOg4e4h4is7uC1+JVAtUuyGKxq8YNQFrvbcq5JggSCQpwr1KVkgHZy90G/3McD1xJ1xmD6FsS/MpKPEaTjmbGC7NXIbE8sbEeXKy0qxOt3z21FHuuFXain+1yn9+lhxYXyt5/wwkvWQY
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f9f777d-2fba-48dd-3406-08d827afba22
X-MS-Exchange-CrossTenant-AuthSource: BN7PR12MB2692.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2020 04:38:17.0320 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PWu7HkQltaRPO2TClZjWE1p3DlIdpEETryE6GBlifMhLLpD5z73T+vVZg/SpnqhwLTrXbYoVivVkpNuLVNYgxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0067
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
Cc: Alexander.Deucher@amd.com, Felix.Kuehling@amd.com, christian.koenig@amd.com,
 Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

 - fix some styling issues
 - fixes for kernel-doc type

Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h | 61 +++++++++++----------------
 1 file changed, 25 insertions(+), 36 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 51ba2020732e..4b86d912a5e1 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -97,7 +97,7 @@
  * Size of the per-process TBA+TMA buffer: 2 pages
  *
  * The first page is the TBA used for the CWSR ISA code. The second
- * page is used as TMA for daisy changing a user-mode trap handler.
+ * page is used as TMA for user-mode trap handler setup in daisy-chain mode.
  */
 #define KFD_CWSR_TBA_TMA_SIZE (PAGE_SIZE * 2)
 #define KFD_CWSR_TMA_OFFSET PAGE_SIZE
@@ -157,29 +157,19 @@ extern int debug_largebar;
  */
 extern int ignore_crat;
 
-/*
- * Set sh_mem_config.retry_disable on Vega10
- */
+/* Set sh_mem_config.retry_disable on GFX v9 */
 extern int amdgpu_noretry;
 
-/*
- * Halt if HWS hang is detected
- */
+/* Halt if HWS hang is detected */
 extern int halt_if_hws_hang;
 
-/*
- * Whether MEC FW support GWS barriers
- */
+/* Whether MEC FW support GWS barriers */
 extern bool hws_gws_support;
 
-/*
- * Queue preemption timeout in ms
- */
+/* Queue preemption timeout in ms */
 extern int queue_preemption_timeout_ms;
 
-/*
- * Enable eviction debug messages
- */
+/* Enable eviction debug messages */
 extern bool debug_evictions;
 
 enum cache_policy {
@@ -301,7 +291,7 @@ struct kfd_dev {
 
 	/* xGMI */
 	uint64_t hive_id;
-    
+
 	/* UUID */
 	uint64_t unique_id;
 
@@ -313,7 +303,7 @@ struct kfd_dev {
 	/* Compute Profile ref. count */
 	atomic_t compute_profile;
 
-	/* Global GWS resource shared b/t processes*/
+	/* Global GWS resource shared between processes */
 	void *gws;
 
 	/* Clients watching SMI events */
@@ -333,7 +323,7 @@ void kfd_chardev_exit(void);
 struct device *kfd_chardev(void);
 
 /**
- * enum kfd_unmap_queues_filter
+ * enum kfd_unmap_queues_filter - Enum for queue filters.
  *
  * @KFD_UNMAP_QUEUES_FILTER_SINGLE_QUEUE: Preempts single queue.
  *
@@ -352,15 +342,17 @@ enum kfd_unmap_queues_filter {
 };
 
 /**
- * enum kfd_queue_type
+ * enum kfd_queue_type - Enum for various queue types.
  *
  * @KFD_QUEUE_TYPE_COMPUTE: Regular user mode queue type.
  *
- * @KFD_QUEUE_TYPE_SDMA: Sdma user mode queue type.
+ * @KFD_QUEUE_TYPE_SDMA: SDMA user mode queue type.
  *
  * @KFD_QUEUE_TYPE_HIQ: HIQ queue type.
  *
  * @KFD_QUEUE_TYPE_DIQ: DIQ queue type.
+ *
+ * @KFD_QUEUE_TYPE_SDMA_XGMI: Special SDMA queue for XGMI interface.
  */
 enum kfd_queue_type  {
 	KFD_QUEUE_TYPE_COMPUTE,
@@ -406,9 +398,9 @@ enum KFD_QUEUE_PRIORITY {
  *
  * @write_ptr: Defines the number of dwords written to the ring buffer.
  *
- * @doorbell_ptr: This field aim is to notify the H/W of new packet written to
- * the queue ring buffer. This field should be similar to write_ptr and the
- * user should update this field after he updated the write_ptr.
+ * @doorbell_ptr: Notifies the H/W of new packet written to the queue ring
+ * buffer. This field should be similar to write_ptr and the user should
+ * update this field after updating the write_ptr.
  *
  * @doorbell_off: The doorbell offset in the doorbell pci-bar.
  *
@@ -477,7 +469,7 @@ struct queue_properties {
  *
  * @list: Queue linked list.
  *
- * @mqd: The queue MQD.
+ * @mqd: The queue MQD (memory queue descriptor).
  *
  * @mqd_mem_obj: The MQD local gpu memory object.
  *
@@ -486,7 +478,7 @@ struct queue_properties {
  * @properties: The queue properties.
  *
  * @mec: Used only in no cp scheduling mode and identifies to micro engine id
- *	 that the queue should be execute on.
+ *	 that the queue should be executed on.
  *
  * @pipe: Used only in no cp scheduling mode and identifies the queue's pipe
  *	  id.
@@ -527,9 +519,6 @@ struct queue {
 	struct kobject kobj;
 };
 
-/*
- * Please read the kfd_mqd_manager.h description.
- */
 enum KFD_MQD_TYPE {
 	KFD_MQD_TYPE_HIQ = 0,		/* for hiq */
 	KFD_MQD_TYPE_CP,		/* for cp queues and diq */
@@ -587,9 +576,7 @@ struct qcm_process_device {
 	 */
 	bool mapped_gws_queue;
 
-	/*
-	 * All the memory management data should be here too
-	 */
+	/* All the memory management data should be here too */
 	uint64_t gds_context_area;
 	/* Contains page table flags such as AMDGPU_PTE_VALID since gfx9 */
 	uint64_t page_table_base;
@@ -789,11 +776,13 @@ extern DECLARE_HASHTABLE(kfd_processes_table, KFD_PROCESS_TABLE_SIZE);
 extern struct srcu_struct kfd_processes_srcu;
 
 /**
- * Ioctl function type.
+ * typedef amdkfd_ioctl_t - typedef for ioctl function pointer.
+ *
+ * @filep: pointer to file structure.
+ * @p: amdkfd process pointer.
+ * @data: pointer to arg that was copied from user.
  *
- * \param filep pointer to file structure.
- * \param p amdkfd process pointer.
- * \param data pointer to arg that was copied from user.
+ * Return: returns ioctl completion code.
  */
 typedef int amdkfd_ioctl_t(struct file *filep, struct kfd_process *p,
 				void *data);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
