Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4075AE7716F
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Dec 2024 04:20:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C1CB510E03D;
	Fri,  6 Dec 2024 04:20:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0u+1ZloC";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2089.outbound.protection.outlook.com [40.107.243.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A2C1010E03D
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Dec 2024 04:20:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eBnsOIbiIcgRoJvOzrW0n1lyjbZ3TxpvrU1vXv6Dqs4hcuemLF7h0yUTkzr62unlQhMP9pQln8rPXSwpjXnA5jrNLS0dhmFUF9ZSlwZZWAdKWJo2R8Byu5H0T14MYBaYFAIKq4WJEaqhe+fkrNko2B3mUtFCBUGbb0HCF8/xbDHaxah4LnNRmWbq7EeTOsyMXToGBViAvlNSLijdEM+FWHZUSp2bc9I0IXH7EKwxuulm+FrDKyrAp1Ui/Rp3tdxgIjSI1SrrXA5J6vrf8dS5kA+P96RbGieTYEbHukx3OCZuB3R9MNm3JFEXxpzm1h998BLKQqZZyw7j+JVuX0V59A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rkoWYIa7TPl9VAnJshQdBfXsbWs7ePj13f/SPteBF8c=;
 b=odS+acHtNETQ+6Nj9Zk5flsj7KLWOa3Kpu8+KyM4+sJqx8xjSekGCOSqoBK3hHnXCUZrxcK6aKX2nSv72b9Bxjmaz4FvQrC2WwhhLj357WH/WIvB9KufxqqfjzrUM5bNOEmEC4kPY0f1hNYeslObXvoysq5m8DyhjDFvOciQnrqHisnrY+qVjISobMqvV3J32T5DJXAZKuY6UNgBt0489obCvmGif5wlM9O7Af9qbzCU7aUPbowSC+AN3PxplHs77QCKQ6v6kur5rdQBsYzwKDZd0VqEigISmw8DlJkk3ESLxmh/xgw8wUraOJJHk8HR3p9QG6FTjoRHFA+Vgl617A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rkoWYIa7TPl9VAnJshQdBfXsbWs7ePj13f/SPteBF8c=;
 b=0u+1ZloC9UVgj7IoRYjWJLzXMFvofs/0bdRxYHxAF+Mb0NW3loz1LiDNUO5TBPdZuhr6I9R9g1Pxd16s8eFvzW+GoI/3JWpIuo3ZKv6R0kEAkJEng4A/n28jN1wfMahe04tKkeD0/mxOjj/DPX8ly+2LZGaMx2FSn0KHbJIlj0Y=
Received: from MW4P221CA0004.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::9) by
 DM6PR12MB4420.namprd12.prod.outlook.com (2603:10b6:5:2a7::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.11; Fri, 6 Dec 2024 04:20:49 +0000
Received: from CO1PEPF000075ED.namprd03.prod.outlook.com
 (2603:10b6:303:8b:cafe::52) by MW4P221CA0004.outlook.office365.com
 (2603:10b6:303:8b::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.12 via Frontend Transport; Fri,
 6 Dec 2024 04:20:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000075ED.mail.protection.outlook.com (10.167.249.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Fri, 6 Dec 2024 04:20:49 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 5 Dec
 2024 22:20:48 -0600
Received: from JesseDEV.guestwireless.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Thu, 5 Dec 2024 22:20:46 -0600
From: "Jesse.zhang@amd.com" <jesse.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>,
 <Tim.Huang@amd.com>, "Jesse.zhang@amd.com" <jesse.zhang@amd.com>, Yunxiang Li
 <Yunxiang.Li@amd.com>
Subject: [PATCH V4] drm/amdkfd: pause autosuspend when creating pdd
Date: Fri, 6 Dec 2024 12:20:46 +0800
Message-ID: <20241206042046.761332-1-jesse.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: jesse.zhang@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075ED:EE_|DM6PR12MB4420:EE_
X-MS-Office365-Filtering-Correlation-Id: 66d58c4b-b7e6-48ec-2801-08dd15ad5d4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zZuVNdC+x5g8Df4a+GmAR0VELa01fZkB1LJ1pHpwqPCBc3lK1+HADxQUWt/e?=
 =?us-ascii?Q?3Y4m9U+UaeDdOJG0UDL2wsXAoMR0IOl+f7GM8mMe8ZvJCgz/xoRP0Jqlmn0C?=
 =?us-ascii?Q?hzuzVyD28MExqLmfr33Hbzf0Mnra3aJFVT7B/D33phebYXpRIdfE/7RFb6PP?=
 =?us-ascii?Q?c5uhG2r7zFomK+CRoTYRi/BaW9798N9THJrrjkG52nSeulYHTc7j1/OFc6q6?=
 =?us-ascii?Q?oQJQ9FwbawGtaeq7xkzTCcAhauCeQKFA1m2euG64uFEGSpinNXpZlq2wsSQp?=
 =?us-ascii?Q?pItn6T/PbGU+H6exiNGHAVrwjx15HQCpVex9MZQHKlFtnxw6EBAXqgWUQ7/B?=
 =?us-ascii?Q?S2vKj1IpajjAapRBF4In4e0wACTLAvVmA9TT68guYULjGBdfWGBYXcLg9uK/?=
 =?us-ascii?Q?YFeNHPqCnw7C4dCTCu/vbO50Cz74bt8Rt3HaZS7/CLd/QFJp/Dos89lKILf/?=
 =?us-ascii?Q?AZHdmx23joGk6Tnf35UT4KYPVcFRZyxMVQOF/rGTFTzQB7rqOabPjO9NLbGz?=
 =?us-ascii?Q?LNEfXFZQ4DJq3fayDJSsd+SBSCtlEgPg+NQdeCPxNFnYDz5rbjv0+4+46E1K?=
 =?us-ascii?Q?z6dIAtBi6kHVH8jo2CoctiRRNt6eZ5KWSP86/RWD3FG+mLpbLhdSKtz6qJOV?=
 =?us-ascii?Q?Oirv5l04Vk1JgFJf6BIVWMhWno2rb/+rURM2JtbO8lZQhK0FP5Zf7xZDHk78?=
 =?us-ascii?Q?UBCIdGzxmU+1qdIrxrid0Ez9QGPZA6+jyFpYwAbF5QY2gU0WetyBE0qV9kOm?=
 =?us-ascii?Q?CchZ4F7F60+oTG5M2hQ8cpED/v/bB0EXp6dKbuv8k/H80sOchL03wWDg8Wcp?=
 =?us-ascii?Q?sJ+3klcI0/DoxFW6g9d3hS8qERfNYL4pSXplydI9L2TLEQ8ZkvLYZthGnf/o?=
 =?us-ascii?Q?555qTvYm2zhguMVL30P8oqGWmxCTXHFMdAUFdOPdeK9PR/4MhqqyES52W9bZ?=
 =?us-ascii?Q?X8SL14UcviNx/ywGypG+lZle2VhmqEJ28Ndb+M/OA1ezAZLdWDHMIOEhk1VN?=
 =?us-ascii?Q?N9JoUiQSI1WR64HmVIFwcflDsklPUPmTjRHgs1cXsMVBw/e1m8AQ1Evtqdqx?=
 =?us-ascii?Q?0BCgIDv4XbrEuQJ+wAKRr1RgWI7WvopIdPgi5dW3onuNfiXsqVvtPVzuCyPo?=
 =?us-ascii?Q?di+6+q/QdO6LKI2zFDtXxqLecGZDhsx4Lf4GfN+fX83f8aLMVETeDutpNGw5?=
 =?us-ascii?Q?gXT4GY+7MEYm7a8X7P0GSWgGhAZltatkolr2Y2AC45NHAoSpB73joKA0pauB?=
 =?us-ascii?Q?Dh8Vyrpf6F0/RXT0vQDkxPMLwDZIHwhWBzKH4JVM3/jkt+Z+MBv2L/F7o+a+?=
 =?us-ascii?Q?r6Q0PwgyGR+t9vUwC29e3YE/OSmOR2PmgS07+aWFLureMBZFChmwLMqgqWOO?=
 =?us-ascii?Q?og2NsOZPoPT6Mhr5WOQ84hNkE0HRx2aMMyKPcIFdLVCqVDQ7WOOo4sPIfzgF?=
 =?us-ascii?Q?+Rqxzx0gXA6YPlzpMRoLoDTs4akb6KiQ?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2024 04:20:49.3582 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66d58c4b-b7e6-48ec-2801-08dd15ad5d4a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075ED.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4420
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

When using MES creating a pdd will require talking to the GPU to
setup the relevant context. The code here forgot to wake up the GPU
in case it was in suspend, this causes KVM to EFAULT for passthrough
GPU for example. This issue can be masked if the GPU was woken up by
other things (e.g. opening the KMS node) first and have not yet gone to sleep.
Fixes: cc009e613de6 ("drm/amdkfd: Add KFD support for soc21 v3")

v4: do the allocation of proc_ctx_bo in a lazy fashion
when the first queue is created in a process (Felix)

Signed-off-by: Jesse Zhang <jesse.zhang@amd.com>
Reviewed-by: Yunxiang Li <Yunxiang.Li@amd.com>
---
 .../drm/amd/amdkfd/kfd_device_queue_manager.c | 15 ++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_process.c      | 23 ++-----------------
 2 files changed, 17 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index c79fe9069e22..16b5daaa272f 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -207,6 +207,21 @@ static int add_queue_mes(struct device_queue_manager *dqm, struct queue *q,
 	if (!down_read_trylock(&adev->reset_domain->sem))
 		return -EIO;
 
+	if (!pdd->proc_ctx_cpu_ptr) {
+		r = amdgpu_amdkfd_alloc_gtt_mem(adev,
+				AMDGPU_MES_PROC_CTX_SIZE,
+				&pdd->proc_ctx_bo,
+				&pdd->proc_ctx_gpu_addr,
+				&pdd->proc_ctx_cpu_ptr,
+				false);
+		if (r) {
+			dev_err(adev->dev,
+				"failed to allocate process context bo\n");
+			return r;
+		}
+		memset(pdd->proc_ctx_cpu_ptr, 0, AMDGPU_MES_PROC_CTX_SIZE);
+	}
+
 	memset(&queue_input, 0x0, sizeof(struct mes_add_queue_input));
 	queue_input.process_id = qpd->pqm->process->pasid;
 	queue_input.page_table_base_addr =  qpd->page_table_base;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index 785d68b76f69..0976b5b0e8e8 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -1076,7 +1076,8 @@ static void kfd_process_destroy_pdds(struct kfd_process *p)
 
 		kfd_free_process_doorbells(pdd->dev->kfd, pdd);
 
-		if (pdd->dev->kfd->shared_resources.enable_mes)
+		if (pdd->dev->kfd->shared_resources.enable_mes &&
+			pdd->proc_ctx_cpu_ptr)
 			amdgpu_amdkfd_free_gtt_mem(pdd->dev->adev,
 						   &pdd->proc_ctx_bo);
 		/*
@@ -1608,7 +1609,6 @@ struct kfd_process_device *kfd_create_process_device_data(struct kfd_node *dev,
 							struct kfd_process *p)
 {
 	struct kfd_process_device *pdd = NULL;
-	int retval = 0;
 
 	if (WARN_ON_ONCE(p->n_pdds >= MAX_GPU_INSTANCE))
 		return NULL;
@@ -1632,21 +1632,6 @@ struct kfd_process_device *kfd_create_process_device_data(struct kfd_node *dev,
 	pdd->user_gpu_id = dev->id;
 	atomic64_set(&pdd->evict_duration_counter, 0);
 
-	if (dev->kfd->shared_resources.enable_mes) {
-		retval = amdgpu_amdkfd_alloc_gtt_mem(dev->adev,
-						AMDGPU_MES_PROC_CTX_SIZE,
-						&pdd->proc_ctx_bo,
-						&pdd->proc_ctx_gpu_addr,
-						&pdd->proc_ctx_cpu_ptr,
-						false);
-		if (retval) {
-			dev_err(dev->adev->dev,
-				"failed to allocate process context bo\n");
-			goto err_free_pdd;
-		}
-		memset(pdd->proc_ctx_cpu_ptr, 0, AMDGPU_MES_PROC_CTX_SIZE);
-	}
-
 	p->pdds[p->n_pdds++] = pdd;
 	if (kfd_dbg_is_per_vmid_supported(pdd->dev))
 		pdd->spi_dbg_override = pdd->dev->kfd2kgd->disable_debug_trap(
@@ -1658,10 +1643,6 @@ struct kfd_process_device *kfd_create_process_device_data(struct kfd_node *dev,
 	idr_init(&pdd->alloc_idr);
 
 	return pdd;
-
-err_free_pdd:
-	kfree(pdd);
-	return NULL;
 }
 
 /**
-- 
2.25.1

