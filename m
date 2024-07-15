Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9569C3DA5D
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Jul 2024 12:36:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E21110E397;
	Mon, 15 Jul 2024 12:36:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="h1kLLxh5";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2079.outbound.protection.outlook.com [40.107.100.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FDE110E392
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Jul 2024 12:36:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eRCTmrBELuiUBh5xSJ9LkkYPgk0PokNdP29rV3miYeIH4sbiqFoYnqUoGZh5S6CpCT/M2R0P2xoj+Tf5rmKOq2BR3q8PNBLihWJVVbNNIWJmGiqhhURmYTD85JRuZTGmZOld3S6m9tShxLxo3WNd8n9NduH2OFTJSqaIuGLVSXj8AKp9/K+BXjq2/k4FI7PiiRn33wMmA+TWVFc/7MxvHyVxbV+WTJWNOmYiQxeXAjXNXenmOe6NCbiuelZi+40IB3xpOJTR8NnzKGjjYtcfAOqh9hQq7JBY3DeSyx/dGnipIDopDwSdgAxtqAFIjZlVg7eSAkx4d+jJsW7lbHTP1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QM857r4A4wFRGibfy1ZlS9Cp7UFRxQznnKwDHDOV6OU=;
 b=aig3FrRT6H3iliNke1GqV5nMsbhNNUOOwuMgWQ6H8k+TCOA7jIgQN1fyn8pFgFofXij57gM6hEe9nRhEpt5kh3qiHVtHsmP/Xv6YDQYZttMjsAREUhlhqzGPE+TYHxo24sbPxKOmqFoFuHAcMJq3lisWhdbLYJpFIbN9mMaK0iAg+kICiAye49kqLxpsgCjCSNXPdw0jh3jkZ+Icjt9LwIQDH/2GfgrWlcUrl1HvMFnPYKt6gXpOLT+H5yhp6ILCUL6cTekwtdly69IY7WgZE1MHGqK50n5zfArwiTLyCfK3HnF/iNT1OD5DVpSXkox2uTqAc/w8a+c5pf4fWFm/VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QM857r4A4wFRGibfy1ZlS9Cp7UFRxQznnKwDHDOV6OU=;
 b=h1kLLxh5u7SNTBIeUnVS34e1WlP+Cg8jQNBR2PrlNJqVDLFzpcXZ+gwe7QAgNOMZtW2cyxncOJ3+e4ZlhQWEfrv9YR+0unsAxuDo4FD4hkKp5jxzZivRPVkwFWpddG2aruBRfrP/JYxPTipYVnpOjBlXCJpuLGwxP2cnFF1KTwc=
Received: from BL1PR13CA0308.namprd13.prod.outlook.com (2603:10b6:208:2c1::13)
 by MW5PR12MB5684.namprd12.prod.outlook.com (2603:10b6:303:1a1::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Mon, 15 Jul
 2024 12:36:29 +0000
Received: from BL6PEPF0001AB56.namprd02.prod.outlook.com
 (2603:10b6:208:2c1:cafe::73) by BL1PR13CA0308.outlook.office365.com
 (2603:10b6:208:2c1::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.13 via Frontend
 Transport; Mon, 15 Jul 2024 12:36:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB56.mail.protection.outlook.com (10.167.241.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Mon, 15 Jul 2024 12:36:28 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 15 Jul
 2024 07:36:27 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <Alexander.Deucher@amd.com>,
 <christian.koenig@amd.com>, Philip Yang <Philip.Yang@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>
Subject: [PATCH 4/9] drm/amdkfd: Validate user queue buffers
Date: Mon, 15 Jul 2024 08:34:57 -0400
Message-ID: <20240715123502.7013-5-Philip.Yang@amd.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240715123502.7013-1-Philip.Yang@amd.com>
References: <20240715123502.7013-1-Philip.Yang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB56:EE_|MW5PR12MB5684:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b4b9911-7b09-448a-0bce-08dca4cabfd6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Gj8vR+V7UQKgbJbn3l5/g1V4SG0YFULOtUgZR7W1Ipzp63fTmQYV0hRAswLP?=
 =?us-ascii?Q?tl4H+4QFHxcj2olEMrbOAtUFpAplD4pIq347KKDvaeNZKNfrd6CsYjiNPU4Q?=
 =?us-ascii?Q?77FRPrp5uk0KPgBE8EGyNWhREh7GRqQ7yVJcUxSKB8D5AH/hrXJuNLiPV3EU?=
 =?us-ascii?Q?rMgv3INnbdOWQAbSdhxG9sEEbpfwuS9vt1HLEGH6wLDn59xjlVkXT4k2Y2Pp?=
 =?us-ascii?Q?kEO6sdgTsRRfzy1BQ3G/N9k6J3k+xcurOIrGdlOH0K1icm4G04ogabpzIpLG?=
 =?us-ascii?Q?wUPiLZpMYRV5LzLFoj/XBSY10EVhCsK6Zl8fubwK47EGkhNy8NmplFdW1+hs?=
 =?us-ascii?Q?HmM6i929na0hhkNs7hLSXtG1HjmKeI3opbt3egrS76Emq3qtMf9pJWMvUe6H?=
 =?us-ascii?Q?SKtqDEY6e8f0tD8VilbZ9dO+3WnXRm0EdEY9rPuIUcSgmuBBHmTQIj6l24CZ?=
 =?us-ascii?Q?mcqnh2+cFQoX+VwOkfyc5mP8ayTlH6RNL8jWnlerUaC2RH4MTxGFwPttLoec?=
 =?us-ascii?Q?awzugEHAF9t1+e44VpDSOzkuUkiMtiZ5iyUGxOdr6XsXrwAgrTJC+PMoW3nl?=
 =?us-ascii?Q?Cuo+k041NKLp4r6F56AO35tmmmaTOoVNUXJQvTt2XaaLf8+7kSDt4HjkljJ/?=
 =?us-ascii?Q?EedqcZ7J2jB/RFqeUy27o0UE29EMVp/A7KIusY0ReZk4FP5sr2KLFbeG+h1K?=
 =?us-ascii?Q?nQf8llbW3WYussARIpLqeFxieAa4mVlXj16cpyNLXWQ8biMOaqbd6/rUTxPi?=
 =?us-ascii?Q?bgjp5HygrZDw3yENDVNATt+YIIQKryP7Xk2SWvMsL8jPzfnTAs9tSwKZeUZT?=
 =?us-ascii?Q?YI4EBErEOsfIM2iWWnouCSOzAI8KrODFZ5Z8ffCRSH24fic0umdtvYKuE/FE?=
 =?us-ascii?Q?Ips4AcHwM8vQiDGP4kYcAk1MScvlAk2DKnyqX0y5zCX/2zW9776JmEVQ8KqR?=
 =?us-ascii?Q?fr//NJMht3xKETjb300bCgKt2Gd0ZUFSDd9VpOz74zwthnKwxxv13We0uxCq?=
 =?us-ascii?Q?ldK0H31H20OPlJeHnN/HSoSL4AFgtjrbP2xZW2TszYHeRor2/X+goTlrSE2o?=
 =?us-ascii?Q?o8yonajzrvE2mlGjSVr9t2piWiM+bH4VVveBZ3CKO8HYvQAvsm9F4Dbr9K15?=
 =?us-ascii?Q?YfmtXbBhpWPjJxuPgyAai+ZR7/w1zsWuji7ObgN77WSOoV3SboO1KlrFtq3C?=
 =?us-ascii?Q?PJC6hII8swchGb+fOiNVdhnLJjraekiPccxofG5QAisnptrVXDlRYEPT+JIi?=
 =?us-ascii?Q?Aqz0OiFvkoU/HTjyXcfg0p7tVno3O37udRfY0BKinQ0yMf+k3qL9IxnWiGw/?=
 =?us-ascii?Q?2ZDrB62iBPYtH/2qpQts9ei4HmCWs6sqEpckMaPzd8NZm0iJ/3822Z44ny18?=
 =?us-ascii?Q?uzdCohDb5vjBqbxU769giYmVkt0f+UbMc5VtmsBYbnA4K/lQDMEfDODLzgtA?=
 =?us-ascii?Q?ILcYRLVNSW4=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2024 12:36:28.6874 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b4b9911-7b09-448a-0bce-08dca4cabfd6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB56.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5684
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

Find user queue rptr, ring buf, eop buffer and cwsr area BOs, and
check BOs are mapped on the GPU with correct size and take the BO
reference.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h  |  4 +++
 drivers/gpu/drm/amd/amdkfd/kfd_queue.c | 38 ++++++++++++++++++++++++--
 2 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index c98ff548313c..d0dca20849d9 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -525,6 +525,10 @@ struct queue_properties {
 
 	struct amdgpu_bo *wptr_bo_gart;
 	struct amdgpu_bo *wptr_bo;
+	struct amdgpu_bo *rptr_bo;
+	struct amdgpu_bo *ring_bo;
+	struct amdgpu_bo *eop_buf_bo;
+	struct amdgpu_bo *cwsr_bo;
 };
 
 #define QUEUE_IS_ACTIVE(q) ((q).queue_size > 0 &&	\
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
index b4529ec298a9..0e661160c295 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_queue.c
@@ -97,7 +97,8 @@ int kfd_queue_buffer_get(struct amdgpu_vm *vm, void __user *addr, struct amdgpu_
 	if (!mapping)
 		goto out_err;
 
-	if (user_addr != mapping->start || user_addr + size - 1 != mapping->last) {
+	if (user_addr != mapping->start ||
+	    (size != 0 && user_addr + size - 1 != mapping->last)) {
 		pr_debug("expected size 0x%llx not equal to mapping addr 0x%llx size 0x%llx\n",
 			expected_size, mapping->start << AMDGPU_GPU_PAGE_SHIFT,
 			(mapping->last - mapping->start + 1) << AMDGPU_GPU_PAGE_SHIFT);
@@ -124,18 +125,51 @@ int kfd_queue_acquire_buffers(struct kfd_process_device *pdd, struct queue_prope
 
 	err = kfd_queue_buffer_get(vm, properties->write_ptr, &properties->wptr_bo, PAGE_SIZE);
 	if (err)
+		goto out_err_unreserve;
+
+	err = kfd_queue_buffer_get(vm, properties->read_ptr, &properties->rptr_bo, PAGE_SIZE);
+	if (err)
+		goto out_err_unreserve;
+
+	err = kfd_queue_buffer_get(vm, (void *)properties->queue_address,
+				   &properties->ring_bo, properties->queue_size);
+	if (err)
+		goto out_err_unreserve;
+
+	/* only compute queue requires EOP buffer and CWSR area */
+	if (properties->type != KFD_QUEUE_TYPE_COMPUTE)
 		goto out_unreserve;
 
+	/* EOP buffer is not required for all ASICs */
+	if (properties->eop_ring_buffer_address) {
+		err = kfd_queue_buffer_get(vm, (void *)properties->eop_ring_buffer_address,
+					   &properties->eop_buf_bo,
+					   properties->eop_ring_buffer_size);
+		if (err)
+			goto out_err_unreserve;
+	}
+
+	err = kfd_queue_buffer_get(vm, (void *)properties->ctx_save_restore_area_address,
+				   &properties->cwsr_bo, 0);
+	if (err)
+		goto out_err_unreserve;
+
+out_unreserve:
 	amdgpu_bo_unreserve(vm->root.bo);
 	return 0;
 
-out_unreserve:
+out_err_unreserve:
 	amdgpu_bo_unreserve(vm->root.bo);
+	kfd_queue_release_buffers(pdd, properties);
 	return err;
 }
 
 int kfd_queue_release_buffers(struct kfd_process_device *pdd, struct queue_properties *properties)
 {
 	amdgpu_bo_unref(&properties->wptr_bo);
+	amdgpu_bo_unref(&properties->rptr_bo);
+	amdgpu_bo_unref(&properties->ring_bo);
+	amdgpu_bo_unref(&properties->eop_buf_bo);
+	amdgpu_bo_unref(&properties->cwsr_bo);
 	return 0;
 }
-- 
2.43.2

