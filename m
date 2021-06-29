Return-Path: <SRS0=w1A1=LX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8717EC11F66
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Jun 2021 07:49:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FA7361CC1
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Jun 2021 07:49:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FA7361CC1
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA3C3895C4;
	Tue, 29 Jun 2021 07:49:29 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2049.outbound.protection.outlook.com [40.107.96.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E8A4894A7
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Jun 2021 07:49:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M9Nmn2WIupX2sKF42DKXJdweYsq34n7qchzs3cVXcdnAitrgVwUVT5cgHFQYHZxdPyTPkZLD6iluxV/y/iOUtXhS2RCA82oS5IHO2D3vLLECO5KFViRCrPPPuRT08j9py1kKEfgMDVpi1DJSXNptSVUBslnCSI5tm25DNhywB50wSR4gjmzuXdSmoeQiXMU2rxRQS9g1UFZfTAk2pUVaAYbNOlrzyh7yQrRp4zFnC0g1Pti/tsbWBfPSskIhCt31Lh5lz8U/55Z1v6E/DVExw+8Mj+4bTCbT7xed2pMNFLw5o/2/Sq398z7RWYYU17qINXx02IQnTMLeG+NO3/H+dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XvXllk7k4fF+jTXqRHKxZjcy7u3GoWwB+QrN9ntx/+E=;
 b=KhoCZiVZHQLdcWvdALe15K4c6hWjCZqfr/byX8FUMmodf6wcdo1BjSok8cRlwXKGjn7+QbJyrRtP3Ouet/iaQBEc03AwsiHR8VCb/qn6gBbDFi8C+OJ0KDeNjDXzsXjMXhjQZj1EeWPGhLg+NgoKFzwB4vn54Ix1UPDCIL+/t15Ll91gls63mQ+C//t16tOA72SH+WPDRs5CELMiwa9yiBPIQ7sBYIDFihhZA5HO/xm6dO80xEZV8PFFPf4E6aIheijMrJeqo5LtFv2JWy0BKqYgEyY3+BSx0bioO5efwR99n0kmHoYgYCVSn+xA4YtwvoS4YEwmRXYZd0eXbadUow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XvXllk7k4fF+jTXqRHKxZjcy7u3GoWwB+QrN9ntx/+E=;
 b=sr2DR90lTsJuqNxq7gvP3xNtt/m8+oPxGDyAWMvH7gUbnvvc16mDF4J9plS0h0KTFDSpnSGVNL4QNrIBKiC5GDjc5W2TepOpaVlHX53A9K4b7ggvapcwSKifIGsJvEbHSTTbRTM936KTFbc8xtDzzJJy+49tAXy6taNmrrU92PQ=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by DM4PR12MB5088.namprd12.prod.outlook.com (2603:10b6:5:38b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18; Tue, 29 Jun
 2021 07:49:27 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::901b:72bb:a15:2a68]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::901b:72bb:a15:2a68%4]) with mapi id 15.20.4264.026; Tue, 29 Jun 2021
 07:49:27 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amdgpu: use xarray for storing pasid in vm
Date: Tue, 29 Jun 2021 09:49:13 +0200
Message-Id: <20210629074914.4114-1-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.32.0
X-Originating-IP: [217.86.118.245]
X-ClientProxiedBy: PR3P192CA0009.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:102:56::14) To DM4PR12MB5136.namprd12.prod.outlook.com
 (2603:10b6:5:393::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brihaspati.fritz.box (217.86.118.245) by
 PR3P192CA0009.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:56::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4264.19 via Frontend Transport; Tue, 29 Jun 2021 07:49:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9248a52c-2f24-4358-1019-08d93ad26b7a
X-MS-TrafficTypeDiagnostic: DM4PR12MB5088:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB508835517521B3F3E529FFD78B029@DM4PR12MB5088.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lJLBTuTQS+wDwYLBHsez9WJGjkV2LbaIC3a915AhXHrcKKN2GKMUlsxoBncI4xPLf1q9zoV0UFgbB/1tvEz4l4RqU9FyoSbXVQpMCdAootLv5XdQmu/HTUu2gUWAMHKaS6in3ucSWqiylXDXJ3N8TVFETTOLmeu9x3pm9dPjEIRFM0RLVZiMvZWqH5nSbRKeU3RI4UwRJ2bQNUboFtfHzlG3fUpNrGDA6FjG4JKIP3JsgTZhgFY0IFSY9zurlzyssR8bQE5aI0WTqPeTBXvX6oX9i9lihXIt+D4JFOOfK0BX3SALRDqmiQlNxDnRtX9uN2dXXVht8ZYxJ4prjcTqiZWaVF3CbNTy+dpre2VXiqWTWC+Jtgpvrf6cCBU9JCGUN0CN7ltv9UsOh49/xHQNvxE0RbwOqnbEG30MhNFw/hrQl/pmY0Q9kfJNO8/kdYHNK4DfeSYOyGAfoazk2Y39xDT8sQTnRxMiSJlH8FvLKXeVR4NwdOxfo+vYvY4LpGKf6ky5TOihNvqP/Uo+F7e6uERF+fM9ECFRNzSZbYARTj3CmiExR/yR3aNaI8Zk5kZw8E5e3J+2x69qREur4Ze4hRtjd7UsvAUWV/DsoiYtrYPeqYLTitdXKMzpqWDVzhB3Pe9yLMtJlaIZl0f8YUAmhxsu9S8VuAeZkUyxmtvhZORm/WKKDT7kCB1lWeqWawr5I3Ma+Eu+3TizlHGU//N2bw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(346002)(39860400002)(376002)(396003)(52116002)(6486002)(44832011)(8676002)(6506007)(316002)(8936002)(4326008)(6916009)(16526019)(186003)(956004)(6512007)(26005)(2616005)(478600001)(38100700002)(66946007)(1076003)(38350700002)(6666004)(36756003)(66476007)(66556008)(5660300002)(83380400001)(2906002)(86362001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vqQiYxGoCbN/bt4CqNieu9WXO9wZvjFSh6Cvs1uY4Qv+cBy7h+kUPqW3JwID?=
 =?us-ascii?Q?iiFzO9aX1+Ek3T9jAvQV6Yi1Shi2XIuKpKH2weA2jEbisLhGqrxJ7eMubSWS?=
 =?us-ascii?Q?hK2EBtK0CLLDL6YEE5+3P3Gi7cMBgNWe4DecfgAhYjbhbHiFLLhGb+VDKqJi?=
 =?us-ascii?Q?SHYjCmcC3LJCtdI1geMOJdsura6iEaFyxDO+v2GW9u7gDrl+uDsUZAlSFOWH?=
 =?us-ascii?Q?3TkBm7Jj2likGDZ/GwqsznaVTjpDTBUlWpLl30lTBU1oahTVfmE2BuW8QWav?=
 =?us-ascii?Q?oU9RK6WBgwiJ5rl+TWnQyBiVMUoqg0imtvAs9uy9mRJ2E6bEYv73nSCNhImt?=
 =?us-ascii?Q?2Lu1qz1Pl0W5O8xjrqdrREAztkVTAV4b1bVeewm8i/LDnrvAPE7jDSpeGKMA?=
 =?us-ascii?Q?8BevPJdvrNw0edsyWSfiXL3znuHhwbxwzeQrt4f3/oHBna7AQhplTnQGRLAp?=
 =?us-ascii?Q?7Jvq7+22NjBF6DjXxSyn3tCpVG/vPEYFQPPhVtDNskcZnCq6Mw0NFwQmtPqY?=
 =?us-ascii?Q?4iBMku/GeQrSlB01GD9zqG11+LMAJ9haT8Ayp2h8YO493/4yjJwA6sN8306n?=
 =?us-ascii?Q?Z0ifpjYJONAhBw/VhEb9ux9wVXe05DtgvK3pxvCNCbDSfZmc1TzPKtODUThK?=
 =?us-ascii?Q?nN812fbsEUEBXBpHCLjEDMxSqQ+qk8AxecDJD42UYQYOGcPsDClMNvS8gMlm?=
 =?us-ascii?Q?SbT5MwqXt68CJt6hFDQVeEh0Ig6BRLJYYLVfDsC3js5XQakNQABLDHQiXC+h?=
 =?us-ascii?Q?qU8wREFAa8u4EgXchpB6nC1s7Ex9cz2CqbWIFxvQDalPA4ugU5Pw1qbjlwa7?=
 =?us-ascii?Q?kIuD7G1t8OHeoF6BdXYZWxVayAXFfF5S8wq5FTMXDvCpmGNmcvTFyHe7PIRS?=
 =?us-ascii?Q?UbZP3027yg9Dw/roOKJwPrheb0/GsguZWZDYWsWMYaIhBx0H3Y7P1mNOtQUK?=
 =?us-ascii?Q?8pK9e0Ni9WjtxXf9JQcIf5PY8qdoh4mDD8EWeBAkCjiu9ObN5x07mv4vIgj4?=
 =?us-ascii?Q?Kly9ApeSEO96/8EgiE3HHnPmCBbqa2/dE2tusd9HmeIms8jgGpdLDzyfjAEt?=
 =?us-ascii?Q?rsILDVGD2/jX+Yr7f03iM57g0uoeFMrNRggALGBK7pVzsrP2qHCoQRrn7E/Q?=
 =?us-ascii?Q?slw2EXOpMG4pEVmba+TtNoUWG1tOQqVnrNZvd+1gh/DC/VU8l7flyEp8+oWi?=
 =?us-ascii?Q?HjJZTOJ9JGjPAaXhKKQfoZDTVwWDI0Vk3ciadhssPz20vioiUZBiWx0V9KMy?=
 =?us-ascii?Q?QfmuECmGsKIe/rAONNhFqkH4wkmsLZY6xTybRMIsVTXhSPi6E4r/jC97FxX3?=
 =?us-ascii?Q?nUHE40TowqICZAbJV5V2nFfd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9248a52c-2f24-4358-1019-08d93ad26b7a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2021 07:49:27.2710 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wiPbaPznlNzaOhDUr556Xz26pRy9GSxqTEh4ry8egj84H7hkro6rzrBx5nKKM4zzu3ncGvSbq6xm8gOfMpGgrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5088
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
Cc: Felix.Kuehling@amd.com, Nirmoy Das <nirmoy.das@amd.com>,
 Christian.Koenig@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Replace idr with xarray as we actually need hash functionality.
Cleanup code related to vm pasid by adding helper function.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 136 ++++++++++---------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h |   6 +-
 2 files changed, 60 insertions(+), 82 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 63975bda8e76..9b0e8a9d7f86 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -87,6 +87,33 @@ struct amdgpu_prt_cb {
 	struct dma_fence_cb cb;
 };
 
+int amdgpu_vm_set_pasid(struct amdgpu_device *adev, struct amdgpu_vm *vm,
+			unsigned long pasid)
+{
+	unsigned long flags;
+	int r;
+
+	if (vm->pasid == pasid)
+		return 0;
+
+	if (vm->pasid) {
+		r = xa_err(xa_erase_irq(&adev->vm_manager.pasids, vm->pasid));
+		if (r < 0)
+			return r;
+	}
+
+	if (pasid) {
+		r = xa_err(xa_store_irq(&adev->vm_manager.pasids, pasid, vm,
+					GFP_KERNEL));
+		if (r < 0)
+			return r;
+	}
+
+	vm->pasid = pasid;
+
+	return 0;
+}
+
 /*
  * vm eviction_lock can be taken in MMU notifiers. Make sure no reclaim-FS
  * happens while holding this lock anywhere to prevent deadlocks when
@@ -2940,18 +2967,9 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm, u32 pasid)
 
 	amdgpu_bo_unreserve(vm->root.bo);
 
-	if (pasid) {
-		unsigned long flags;
-
-		spin_lock_irqsave(&adev->vm_manager.pasid_lock, flags);
-		r = idr_alloc(&adev->vm_manager.pasid_idr, vm, pasid, pasid + 1,
-			      GFP_ATOMIC);
-		spin_unlock_irqrestore(&adev->vm_manager.pasid_lock, flags);
-		if (r < 0)
-			goto error_free_root;
-
-		vm->pasid = pasid;
-	}
+	r = amdgpu_vm_set_pasid(adev, vm, pasid);
+	if (r)
+		goto error_free_root;
 
 	INIT_KFIFO(vm->faults);
 
@@ -3039,18 +3057,15 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	if (r)
 		goto unreserve_bo;
 
-	if (pasid) {
-		unsigned long flags;
-
-		spin_lock_irqsave(&adev->vm_manager.pasid_lock, flags);
-		r = idr_alloc(&adev->vm_manager.pasid_idr, vm, pasid, pasid + 1,
-			      GFP_ATOMIC);
-		spin_unlock_irqrestore(&adev->vm_manager.pasid_lock, flags);
+	/* Free the original amdgpu allocated pasid,
+	 * will be replaced with kfd allocated pasid.
+	 */
+	if (vm->pasid)
+		amdgpu_pasid_free(vm->pasid);
 
-		if (r == -ENOSPC)
-			goto unreserve_bo;
-		r = 0;
-	}
+	r = amdgpu_vm_set_pasid(adev, vm, pasid);
+	if (r)
+		goto unreserve_bo;
 
 	/* Check if PD needs to be reinitialized and do it before
 	 * changing any other state, in case it fails.
@@ -3061,7 +3076,7 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 				       to_amdgpu_bo_vm(vm->root.bo),
 				       false);
 		if (r)
-			goto free_idr;
+			goto free_pasid_entry;
 	}
 
 	/* Update VM state */
@@ -3078,7 +3093,7 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		r = amdgpu_bo_sync_wait(vm->root.bo,
 					AMDGPU_FENCE_OWNER_UNDEFINED, true);
 		if (r)
-			goto free_idr;
+			goto free_pasid_entry;
 
 		vm->update_funcs = &amdgpu_vm_cpu_funcs;
 	} else {
@@ -3088,36 +3103,13 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	vm->last_update = NULL;
 	vm->is_compute_context = true;
 
-	if (vm->pasid) {
-		unsigned long flags;
-
-		spin_lock_irqsave(&adev->vm_manager.pasid_lock, flags);
-		idr_remove(&adev->vm_manager.pasid_idr, vm->pasid);
-		spin_unlock_irqrestore(&adev->vm_manager.pasid_lock, flags);
-
-		/* Free the original amdgpu allocated pasid
-		 * Will be replaced with kfd allocated pasid
-		 */
-		amdgpu_pasid_free(vm->pasid);
-		vm->pasid = 0;
-	}
-
 	/* Free the shadow bo for compute VM */
 	amdgpu_bo_unref(&to_amdgpu_bo_vm(vm->root.bo)->shadow);
 
-	if (pasid)
-		vm->pasid = pasid;
-
 	goto unreserve_bo;
 
-free_idr:
-	if (pasid) {
-		unsigned long flags;
-
-		spin_lock_irqsave(&adev->vm_manager.pasid_lock, flags);
-		idr_remove(&adev->vm_manager.pasid_idr, pasid);
-		spin_unlock_irqrestore(&adev->vm_manager.pasid_lock, flags);
-	}
+free_pasid_entry:
+	amdgpu_vm_set_pasid(adev, vm, 0);
 unreserve_bo:
 	amdgpu_bo_unreserve(vm->root.bo);
 	return r;
@@ -3133,14 +3125,7 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm,
  */
 void amdgpu_vm_release_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 {
-	if (vm->pasid) {
-		unsigned long flags;
-
-		spin_lock_irqsave(&adev->vm_manager.pasid_lock, flags);
-		idr_remove(&adev->vm_manager.pasid_idr, vm->pasid);
-		spin_unlock_irqrestore(&adev->vm_manager.pasid_lock, flags);
-	}
-	vm->pasid = 0;
+	amdgpu_vm_set_pasid(adev, vm, 0);
 	vm->is_compute_context = false;
 }
 
@@ -3164,15 +3149,7 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 
 	root = amdgpu_bo_ref(vm->root.bo);
 	amdgpu_bo_reserve(root, true);
-	if (vm->pasid) {
-		unsigned long flags;
-
-		spin_lock_irqsave(&adev->vm_manager.pasid_lock, flags);
-		idr_remove(&adev->vm_manager.pasid_idr, vm->pasid);
-		spin_unlock_irqrestore(&adev->vm_manager.pasid_lock, flags);
-		vm->pasid = 0;
-	}
-
+	amdgpu_vm_set_pasid(adev, vm, 0);
 	dma_fence_wait(vm->last_unlocked, false);
 	dma_fence_put(vm->last_unlocked);
 
@@ -3254,8 +3231,7 @@ void amdgpu_vm_manager_init(struct amdgpu_device *adev)
 	adev->vm_manager.vm_update_mode = 0;
 #endif
 
-	idr_init(&adev->vm_manager.pasid_idr);
-	spin_lock_init(&adev->vm_manager.pasid_lock);
+	xa_init_flags(&adev->vm_manager.pasids, XA_FLAGS_LOCK_IRQ);
 }
 
 /**
@@ -3267,8 +3243,8 @@ void amdgpu_vm_manager_init(struct amdgpu_device *adev)
  */
 void amdgpu_vm_manager_fini(struct amdgpu_device *adev)
 {
-	WARN_ON(!idr_is_empty(&adev->vm_manager.pasid_idr));
-	idr_destroy(&adev->vm_manager.pasid_idr);
+	WARN_ON(!xa_empty(&adev->vm_manager.pasids));
+	xa_destroy(&adev->vm_manager.pasids);
 
 	amdgpu_vmid_mgr_fini(adev);
 }
@@ -3337,13 +3313,13 @@ void amdgpu_vm_get_task_info(struct amdgpu_device *adev, u32 pasid,
 	struct amdgpu_vm *vm;
 	unsigned long flags;
 
-	spin_lock_irqsave(&adev->vm_manager.pasid_lock, flags);
+	xa_lock_irqsave(&adev->vm_manager.pasids, flags);
 
-	vm = idr_find(&adev->vm_manager.pasid_idr, pasid);
+	vm = xa_load(&adev->vm_manager.pasids, pasid);
 	if (vm)
 		*task_info = vm->task_info;
 
-	spin_unlock_irqrestore(&adev->vm_manager.pasid_lock, flags);
+	xa_unlock_irqrestore(&adev->vm_manager.pasids, flags);
 }
 
 /**
@@ -3385,15 +3361,15 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
 	struct amdgpu_vm *vm;
 	int r;
 
-	spin_lock_irqsave(&adev->vm_manager.pasid_lock, irqflags);
-	vm = idr_find(&adev->vm_manager.pasid_idr, pasid);
+	xa_lock_irqsave(&adev->vm_manager.pasids, irqflags);
+	vm = xa_load(&adev->vm_manager.pasids, pasid);
 	if (vm) {
 		root = amdgpu_bo_ref(vm->root.bo);
 		is_compute_context = vm->is_compute_context;
 	} else {
 		root = NULL;
 	}
-	spin_unlock_irqrestore(&adev->vm_manager.pasid_lock, irqflags);
+	xa_unlock_irqrestore(&adev->vm_manager.pasids, irqflags);
 
 	if (!root)
 		return false;
@@ -3411,11 +3387,11 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
 		goto error_unref;
 
 	/* Double check that the VM still exists */
-	spin_lock_irqsave(&adev->vm_manager.pasid_lock, irqflags);
-	vm = idr_find(&adev->vm_manager.pasid_idr, pasid);
+	xa_lock_irqsave(&adev->vm_manager.pasids, irqflags);
+	vm = xa_load(&adev->vm_manager.pasids, pasid);
 	if (vm && vm->root.bo != root)
 		vm = NULL;
-	spin_unlock_irqrestore(&adev->vm_manager.pasid_lock, irqflags);
+	xa_unlock_irqrestore(&adev->vm_manager.pasids, irqflags);
 	if (!vm)
 		goto error_unlock;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index ddb85a85cbba..8e8bc132e590 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -359,8 +359,7 @@ struct amdgpu_vm_manager {
 	/* PASID to VM mapping, will be used in interrupt context to
 	 * look up VM of a page fault
 	 */
-	struct idr				pasid_idr;
-	spinlock_t				pasid_lock;
+	struct xarray				pasids;
 };
 
 struct amdgpu_bo_va_mapping;
@@ -375,6 +374,9 @@ extern const struct amdgpu_vm_update_funcs amdgpu_vm_sdma_funcs;
 void amdgpu_vm_manager_init(struct amdgpu_device *adev);
 void amdgpu_vm_manager_fini(struct amdgpu_device *adev);
 
+int amdgpu_vm_set_pasid(struct amdgpu_device *adev, struct amdgpu_vm *vm,
+			unsigned long pasid);
+
 long amdgpu_vm_wait_idle(struct amdgpu_vm *vm, long timeout);
 int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm, u32 pasid);
 int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm, u32 pasid);
-- 
2.32.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
