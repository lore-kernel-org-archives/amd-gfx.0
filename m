Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AA99C3DA49
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jul 2024 21:06:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 77EE710EB2A;
	Thu, 18 Jul 2024 21:06:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bxNKmGPH";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2043.outbound.protection.outlook.com [40.107.95.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC03910EB28
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jul 2024 21:06:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oVeu6Ad5/E+CcniUGjpz95vQT3a0xHFzy5kg343tEI5ZBGmI6/pbpWRYupXelR+ZW5dtJsIrbtaQBMgO6vRNjTWoAHUYH9ZT0VwqwdKLQ+VUYTb/x02I33SZpSpEspHeAE+NOi20V7wtAmXsdBG70RTwBsdBfVcx36wbwunbijTE4tdGUhVgzP85QOf77yRqan8KO4aaT9/0HmXprFRvR59N22xLb3FfDG/6iojO6vqh82owvAmnmDY0qhccPPL0NRDpBrQZDKDAOuvOz+HKUN4Se0VNRffAqRIPjcFeOzcjY7fSa/vqIhsyoTg8UaGG9dZxi/tJEinmN7CmBC70Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Knwe9v02oI8IOTg7wpr+YaGzH7H3vJTmk+Kjbg8CKzg=;
 b=qdgPqgLubRjp5ol2yemu4g4Eac56u+gSrAt+zAr9bF7Sm/dxCK00C998rgpB8VTB1+aO34+KwEdQyvfA6R5wPs2CjPP9Imks/I5IwfHt6RrVch7C0bjmzTpWKmFinEmbL6oZXdG9wa7yxUNYwc5rxlIn/it3wtZXhPh/bJlWZi6Iq4B6VFgam5/d030ixIOkou2G8F/euauNtY/VmUI8z5yFnoOufnY9cDsACSrAH+/NXmUMSeMO3jkfNiLKgyftpGnlCD+++afXlZtmHXv7EhprQgaGGqpWqUnrwJdOaXcP07WLQkKwuHow/MVNsFv32EBLkB/f6w1M/tkmpbPntQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Knwe9v02oI8IOTg7wpr+YaGzH7H3vJTmk+Kjbg8CKzg=;
 b=bxNKmGPHjqRcUnwe3YghP8AamCPQdQvz8fFqdmEZRsSpH5XByRW916IrUA0VpTEfx85ZoGHS8zUNaJgiBSQatT2i2OhUXR534ef85ly1dk2Wiq6U4pU4FOojyMl+MzrfYU8TlamD8z1aj/rwAdjD8uB4abhHC2HL4irWe+c/yKs=
Received: from SA0PR11CA0113.namprd11.prod.outlook.com (2603:10b6:806:d1::28)
 by MW4PR12MB7357.namprd12.prod.outlook.com (2603:10b6:303:219::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Thu, 18 Jul
 2024 21:06:17 +0000
Received: from SA2PEPF00003AE5.namprd02.prod.outlook.com
 (2603:10b6:806:d1:cafe::d5) by SA0PR11CA0113.outlook.office365.com
 (2603:10b6:806:d1::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16 via Frontend
 Transport; Thu, 18 Jul 2024 21:06:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003AE5.mail.protection.outlook.com (10.167.248.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Thu, 18 Jul 2024 21:06:17 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 18 Jul
 2024 16:06:14 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <Alexander.Deucher@amd.com>,
 <christian.koenig@amd.com>, Philip Yang <Philip.Yang@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>
Subject: [PATCH v2 7/9] drm/amdkfd: Validate user queue update
Date: Thu, 18 Jul 2024 17:05:56 -0400
Message-ID: <20240718210558.26340-8-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240718210558.26340-1-Philip.Yang@amd.com>
References: <20240718210558.26340-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE5:EE_|MW4PR12MB7357:EE_
X-MS-Office365-Filtering-Correlation-Id: 50207210-4670-46c8-0dd5-08dca76d7718
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1IMisG3lrVA++PAfBUVrtyw1wG3X7xiF7iMh41I+Bz9jOqZBoXrYrNNQdG5c?=
 =?us-ascii?Q?KC8xHGil4uuVFO6Bd32oWhmsaAyvpEpqWIQm926ouZ03A+x61y6FR+aeUAi8?=
 =?us-ascii?Q?IVE2POoNmcnJl5/9H1NmYadeD4EeA8sxbO+kiBLA48h5H3J8xvAtVCyT5qXW?=
 =?us-ascii?Q?pMnLX9YMgKTEhC+ycX07pGPuZW5l2R3jbTHk9+N1r/OKCbfxJuX6ztptNi78?=
 =?us-ascii?Q?7Z5Ns4YMBXMYoQozQFDAdUNdTsr3FoJi+k9Hn74HrVWC59wATZQAnTv0iH+w?=
 =?us-ascii?Q?L7z8+02/Vxqb7h1j775gF8xlzn5/KzZjM0591tQ7T+U/XM1WT/niniAgUB91?=
 =?us-ascii?Q?k62dIkvADyJrahNcUna7ZrvEingn4jjf4b9W0x2S6P/SVyjdfWM3zXqlMd1W?=
 =?us-ascii?Q?CO4EUAenl8VSasz3aMEXvKIX6c13mx+cCNIcDkBStshJ+LmADlWdh3IkoQ6G?=
 =?us-ascii?Q?F8TqyMXLa9Mn7MMW06w8rJMXE5HbhXMfPzGFpshRcbHNWo0nA5mNWAoebZPZ?=
 =?us-ascii?Q?4kDPBbH6diMJW6Ef/+gBFiqvmq41ABF6ay2ouK56I1tj5syXGrAD3GolkpZl?=
 =?us-ascii?Q?H/C9rvrsQgLfL5vZUAobZD9wAKoiBus4poPBGoEKcoufCd7f22ILKi4vDnnV?=
 =?us-ascii?Q?FCxE3FxAwYcvmCgAM0jXFWMPA1Ua71o7qhgrsuCKGj4Tv/T+dDVu0Z6Is6qY?=
 =?us-ascii?Q?6HNV4x3COiYmYlFAvtRwh5qqfObbKY3WOKzvDvapwhofEpNG0aGTEgAAnKVa?=
 =?us-ascii?Q?UrcbpDnx8wStCkQ8nZE/akmFHwhcvEAFBNCRmR+QaoewtlajKFP9ehS2JAFn?=
 =?us-ascii?Q?egB/Jr9ftkzUQHPjkxBWJLcqRnaP/lyuKYcaBCBrSefyftfbNY1o3ofEuqbB?=
 =?us-ascii?Q?aIbs+Vx05YZ45OzKx4RSzAGxe/rPJjUG4ViAVwP5kMqBPO6HfKEkSYXnHdKG?=
 =?us-ascii?Q?tjRSzYOonBsO7bFD09N24kEctZ3GWdSDMRVaPwTj1b27Wn+4blkcbs9xQqlG?=
 =?us-ascii?Q?1dTNlgaKjRI6hOEPc8INU/zfKcrRyaiZWFW8p+3Jy3GWw4PX2pVnUN/K/nnR?=
 =?us-ascii?Q?wcLzQmeAGbyyRGgW3KszDrrpm/6YKF9HyJpPP9bN6AsiwZEiiF9g9euH66Us?=
 =?us-ascii?Q?NIVXbanlrvroYnRjVpTVzFGusr8zsb1nFVrVJbq84JlKqpHQbN0JWkN6JSan?=
 =?us-ascii?Q?0ondMna1ieJ/tLWnyytY7tJjfLz4DTK7jVDvBC9aeCTdwvr3veGrVuynLsy6?=
 =?us-ascii?Q?zMMNcF+ymz4ynXEF6Q957Vt6PMx2HJc1K6bGpVIXUGQuWFpXQfDMLtInrnuF?=
 =?us-ascii?Q?Sk/yoWjmCJTtFMVblEEd68PcQIRveEYGeVPlYWFmNbx2AMGe6wq8HQS4wDWo?=
 =?us-ascii?Q?3Xlm+NBEEEq2Nc0HL4AvJLdKcInJ/xCcCAmYNwdl1fEzTWNWmbI/rqj5Y7Wc?=
 =?us-ascii?Q?i2V+OLWgVD8Y55lormU4tWeCUgvks821?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2024 21:06:17.0169 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50207210-4670-46c8-0dd5-08dca76d7718
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7357
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

Ensure update queue new ring buffer is mapped on GPU with correct size.

Decrease queue old ring_bo queue_refcount and increase new ring_bo
queue_refcount.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
---
 .../amd/amdkfd/kfd_process_queue_manager.c    | 32 ++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
index 4947f28b3afb..9995dbb43359 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
@@ -549,11 +549,41 @@ int pqm_update_queue_properties(struct process_queue_manager *pqm,
 	struct process_queue_node *pqn;
 
 	pqn = get_queue_by_qid(pqm, qid);
-	if (!pqn) {
+	if (!pqn || !pqn->q) {
 		pr_debug("No queue %d exists for update operation\n", qid);
 		return -EFAULT;
 	}
 
+	/*
+	 * Update with NULL ring address is used to disable the queue
+	 */
+	if (p->queue_address && p->queue_size) {
+		struct kfd_process_device *pdd;
+		struct amdgpu_vm *vm;
+		struct queue *q = pqn->q;
+		int err;
+
+		pdd = kfd_get_process_device_data(q->device, q->process);
+		if (!pdd)
+			return -ENODEV;
+		vm = drm_priv_to_vm(pdd->drm_priv);
+		err = amdgpu_bo_reserve(vm->root.bo, false);
+		if (err)
+			return err;
+
+		if (kfd_queue_buffer_get(vm, (void *)p->queue_address, &p->ring_bo,
+					 p->queue_size)) {
+			pr_debug("ring buf 0x%llx size 0x%llx not mapped on GPU\n",
+				 p->queue_address, p->queue_size);
+			return -EFAULT;
+		}
+
+		kfd_queue_buffer_put(vm, &pqn->q->properties.ring_bo);
+		amdgpu_bo_unreserve(vm->root.bo);
+
+		pqn->q->properties.ring_bo = p->ring_bo;
+	}
+
 	pqn->q->properties.queue_address = p->queue_address;
 	pqn->q->properties.queue_size = p->queue_size;
 	pqn->q->properties.queue_percent = p->queue_percent;
-- 
2.43.2

