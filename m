Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E012EC3DA61
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jul 2024 21:06:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 93BB710EB2E;
	Thu, 18 Jul 2024 21:06:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="P3kwkNz/";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2044.outbound.protection.outlook.com [40.107.92.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54F1C10EB25
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jul 2024 21:06:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LRwlZoxONj7AC7UoR+meAzsBBVL0PSf7iKuc+9hZ9aTmIueOnJFpztUWXpxhvhBeK9jk2ozY2k1GE3Jm67MIfawSqvAzzmlKrt14u/ngwYf2RuaspPmGwQJcCWLSgNXjrN1rlnsyflQvA4LPrVnj1WDLvRm/1OuZQA/qzkp3Dm4GB9Kc4rc/JZgLo3KNIXE7o4gdA06TeqtmXiolPoJqAm+GPt3yaT1JPdDisqMZRjLGvIi1b8QMFj3iVH9G/RNK2bKRsC7So9UbMXxI85i+0MD0FOINAH2vDA7tryM+7T7Z1AaSBZjPPJWi7yOHcyniFIsQlugFv/r5b+t5+Wr1ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BK6QtKTVi6BLixDfp7LA0vTmJCtsZHeyce+EnOSxVzo=;
 b=BISKZvSFEBA7Z/D4SGowiWoES7p279q1vYKEroY8v7aTBQ8L7Mqhkw0MpkCQONnS/6TlPoVcqhj5E0CAWEEtXkDvuQTT3akqz7XrPEWcrFrMgbEe/ZZH+CEfcTf5/JpT4zSw8CYB7J5C60Cn3DxXMfxnp1CtPPkM1xqhHSalcWosjLa/4m2VOfWZw5bV1pZmWxawgoR5yV7xOZhNP1lj7NIGLpk7qNqf+SQsA0XfzFCFUyUQyDfAH5uBLYhqPIFnAyRxr6OlTRheXGBZtnIa13+xvWjmUBv+JKZU6l+YincOqBCq1BnP4puEoVVq4t1IpNgIIduQMCzHRew6n/7dAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BK6QtKTVi6BLixDfp7LA0vTmJCtsZHeyce+EnOSxVzo=;
 b=P3kwkNz/K/BFaoeQ8lsGRLGt+Y8s67yF1b53Qcwb5mwtQiZnngl63N3Cvp68tibffBT589Ud0VF/nQLIlb36ViJsFrToarfWJwN/AKfNTzIdTsZjLaM4sfd/ceC34rU/aZ06aJ8fZXkS4LoIy7BgKWQ5EkYBpxeImtqBBcGwgv0=
Received: from SA0PR11CA0111.namprd11.prod.outlook.com (2603:10b6:806:d1::26)
 by BL3PR12MB9052.namprd12.prod.outlook.com (2603:10b6:208:3bb::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.19; Thu, 18 Jul
 2024 21:06:16 +0000
Received: from SA2PEPF00003AE5.namprd02.prod.outlook.com
 (2603:10b6:806:d1:cafe::5d) by SA0PR11CA0111.outlook.office365.com
 (2603:10b6:806:d1::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29 via Frontend
 Transport; Thu, 18 Jul 2024 21:06:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003AE5.mail.protection.outlook.com (10.167.248.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.11 via Frontend Transport; Thu, 18 Jul 2024 21:06:15 +0000
Received: from Philip-Dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 18 Jul
 2024 16:06:13 -0500
From: Philip Yang <Philip.Yang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Felix.Kuehling@amd.com>, <Alexander.Deucher@amd.com>,
 <christian.koenig@amd.com>, Philip Yang <Philip.Yang@amd.com>, Felix Kuehling
 <felix.kuehling@amd.com>
Subject: [PATCH v2 4/9] drm/amdkfd: Validate user queue buffers
Date: Thu, 18 Jul 2024 17:05:53 -0400
Message-ID: <20240718210558.26340-5-Philip.Yang@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE5:EE_|BL3PR12MB9052:EE_
X-MS-Office365-Filtering-Correlation-Id: 14e53131-cd5f-4179-3d2f-08dca76d7665
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lVVtQSxDrMdyJOLMrV5COJBSav6eZFnNuiSI11YMjakH3eeG8reGCt5ajQcF?=
 =?us-ascii?Q?/6HnaLO7qh6kxVeflul7KWV4MCgBFPSM9AIfqWO4C5f5JeC+qtRbDOXgkn0g?=
 =?us-ascii?Q?UpQcYa2vKldmvhpRKP1QZ204le2cqRO3hNSDsGcsACYVDtT+otWJRQDrL197?=
 =?us-ascii?Q?Sy1iRGo88lIaFxVPhlREg8ZzlRmbNwZPXxwm9vbeu7N9r/JaxEKQr55KMU8/?=
 =?us-ascii?Q?F8bfGgHjMykVHowBoYlN4VHxPG31dkxTc+nxETtHmS30ZABtfToK+5rqnX1W?=
 =?us-ascii?Q?0t1Nupbxtk2CPPvrBjcJYpfA59TuNh2HFLV0cQb16YQZ7tn9HGWqrX4ACFgs?=
 =?us-ascii?Q?7VtY/lkWjXz7LGjBt/VKv/aqV0YJeELqHiAM4NrlXOIcFjzjeK7PD3wn/4KZ?=
 =?us-ascii?Q?0D67sK8lKMI4svgNKAqvVL2KvixYDN8frCSdNXmwIEiM97hEhkSoKtb9HX+q?=
 =?us-ascii?Q?DGP82685LfWFd22zM1fSeWDWAsFwrqv7+OhNDNBDhjTys/Lw3HPWoPeFrPq3?=
 =?us-ascii?Q?Z8s/Q0dWJjDt4fMmTiwxJr9LaZ8u6kHWQMSVtXLiC+fZ2woxSWNtcArgQiZN?=
 =?us-ascii?Q?O9mbH7O3+/HErdK/vMICVYTlJyN/kBGk+1VimCBxM13wV1e1co47tvi2faq6?=
 =?us-ascii?Q?Fny3WHt8lpXae4lfXymGq/WfWAmEntyfHGDIDjYCNgJNil1aMZBrykVoS5tg?=
 =?us-ascii?Q?yIXom+ivkW7lJ2C56i8DuFOdMKrIZmCW+0VjETXtWhGzg2Byi+N5iTCQPk78?=
 =?us-ascii?Q?nOeuAaW96zGgr7Im2DMgk0aiAbPGvi0354wgfD90x/Z7F9Wtq5FBcvBPGeam?=
 =?us-ascii?Q?DQDGZnWKgvzbGy+3xK8Tgy1OLEfIFfEUVgRRvddLoQ5NqGFpwyE9DNF58QYz?=
 =?us-ascii?Q?tKPsfvbcDn4YIqcCXwvFhPyLtLZn3LnZY5aqheNblnS2qx97sGqoH/JklPyU?=
 =?us-ascii?Q?eb7NCZBnrCrznBOf3c9Fo65EykM9UQe4nXU0uY8/qA5nNyVsrHkJRq5wRgcv?=
 =?us-ascii?Q?xjRnE5CpbBjN+FUndvs8q4rdtfEevVtPro7HWjEynUq4DdmcHhOWGfZf6The?=
 =?us-ascii?Q?S3rGqDha+jrCmvS6HjOVlKJCaudh/xXbnXLOri1o1oFRehXt6lBLESLoU081?=
 =?us-ascii?Q?9foFar/VM5Z7SJ2iywxHNKDilmV76+xgUmxXB34evrSDbvGz14NCSlZTjS0k?=
 =?us-ascii?Q?XAu0dr0Yzd3hAy1vExHjq4jkyYStn6D9HFrpuNAWMBDD0r6tuJAcqD3+kgo0?=
 =?us-ascii?Q?6w6iG43Vcpn7GxnC5d/4yJjKOIvmk1fdrIG020nXhzs8KoIZuy0/TPY3hvNE?=
 =?us-ascii?Q?VEwNd+jxk/zEu10r7V2qDCjQuzOeP1jPRrEKjHwVw21HuxKYCbb2Z9eHdQaI?=
 =?us-ascii?Q?5rV2zNvl0DYzK7RjWAdbCobIW0KQMqzNOhXcjnfuU6cDXWVRVtlGs+F22G4M?=
 =?us-ascii?Q?VX4ihBZu354=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2024 21:06:15.8606 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14e53131-cd5f-4179-3d2f-08dca76d7665
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB9052
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
index aba9bcd91f65..80d8080c5764 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -524,6 +524,10 @@ struct queue_properties {
 	uint64_t exception_status;
 
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

