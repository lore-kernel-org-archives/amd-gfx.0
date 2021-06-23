Return-Path: <SRS0=KKXi=LR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 178C9C48BE5
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Jun 2021 12:25:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D941A6102A
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Jun 2021 12:25:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D941A6102A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D9CA6E8D0;
	Wed, 23 Jun 2021 12:25:27 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2060.outbound.protection.outlook.com [40.107.92.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4830E6E8D0
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Jun 2021 12:25:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DItDtAMOHj9Vr6cBNVgw3f17Ef4E8ZhBswp/B0NzI0EZOeC5pBDP4vLTQKfhaHuBQabpdr6oaj9VwSqU3a8mz/DlrPudSB35PNzOYZI4ztl8cxvZGoZVzy3DXvRu3gXu6yA2q0mszUN8pY8mMGwk+y0FSwFw9N0SkgTx8UBzCJ4hr+SrtpAqvFVOx9USJjdRz6wgX3jEjx2cg7Mfdm1KIGbmv5YAMROZNM93aAEZ95Iw9wJyQ8vjKsRbgUgmrWhJwdpkEwavvFb2wLi4HCjOewVam+DrizZZlHN7logxQYU7vCAIy4B8oQifEhs71/bf0jK0mlmdqrHHXvtqTgEnSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YvH0EJGZ+ouQbvjOyEU7900EIVM570Mh9feo+gkHBvs=;
 b=dShc9ZoYl6yX4yMyOZDtLwEgC9VXaRbzh1Jenebjb/mhEg5aPbRF3SJVHP2B1rSg5Q/P5yUNMZBCPFtzyr0fCXrSUgorfilZY++oGivXu1FNLbGngr42WpnRtkhGqCAYsgYmPWhmbF9NNarohHXsfBOVCLtRGJDsBjvMkuCDWkDrSpWgGvYTKCYaz2U22acEYGpf7nEaz/WqOZgS8tUi+WCnZ4zCrWyGJG0OKBuQ6Jr+9S2wozJuYbIKvWJjhiGpk1d/WIxfdUMTGTDeDrUqRcocuUwyAqUzeLlz5wEQd9bQsRvQ4kjoMJbfL8nfTYOkO+h+AqBD6pFtV0bCtmctKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YvH0EJGZ+ouQbvjOyEU7900EIVM570Mh9feo+gkHBvs=;
 b=3u41Ezxi+FFF7uYd1hazKiO6KI6uFvpqio+wYvRnnR9oSFMm7JWh37/9kXhjDt+paYOHCKi6kIqM7KCjktgeHXUPkzubP325mHd+R5fBHTsLTI4iaHg6yf8XyQRyBoy4NzUnBXl2uClRhJLlfUqqbs9vsMc+K2jg0A2iRlLmod4=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by DM8PR12MB5477.namprd12.prod.outlook.com (2603:10b6:8:35::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Wed, 23 Jun
 2021 12:25:24 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::901b:72bb:a15:2a68]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::901b:72bb:a15:2a68%4]) with mapi id 15.20.4264.019; Wed, 23 Jun 2021
 12:25:24 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amdgpu: use xarray for storing pasid in vm
Date: Wed, 23 Jun 2021 14:25:06 +0200
Message-Id: <20210623122506.7397-2-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210623122506.7397-1-nirmoy.das@amd.com>
References: <20210623122506.7397-1-nirmoy.das@amd.com>
X-Originating-IP: [217.86.115.200]
X-ClientProxiedBy: PR0P264CA0222.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1e::18) To DM4PR12MB5136.namprd12.prod.outlook.com
 (2603:10b6:5:393::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brihaspati.fritz.box (217.86.115.200) by
 PR0P264CA0222.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100:1e::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4264.18 via Frontend Transport; Wed, 23 Jun 2021 12:25:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a6d54b5b-3f85-4dfe-efe7-08d93641f968
X-MS-TrafficTypeDiagnostic: DM8PR12MB5477:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM8PR12MB5477FC5629032E27FC5464828B089@DM8PR12MB5477.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MRsrvevBeDLphQEfDd5Wwq4Yde4CAfWq3iafZRAESF8S2+x3k0tpOloCZ6Nz9ojyWvL9UiqR/CdVyoHVSEIEnYHgyPSfN12oIWskpa1IL7bWNmiTxBcUIHn4oubm4S3+9n60VSSAzJJpQOTrWECBPa7sJAeroxCoSsI94cQ6rYGzRYP2W5iMtudNXSBCXTR1tFk7VwVetoG/8cMJl0EfAf0BjB8174n6Dw3QUGr8EgUKKElGFqXp0Exfl65GmlrP4m7tkpJ9wi5fiOmcIOdNJLlDzwgik6KFs+qZR924w4DSUviMweeWHrlbBwy2cqkFD5f4Ez2fR0mFJr4KPoYUEGe1toClaBBN69v0Su66PT9jsFGSyjdKTJlQlUlq2q6ymyRf4eO3XsE85Qomllqpo8ims81+wLyW5D36+AHGDYKLDFFFYXzqL/PM88/Rv5BPbQbcKuBlph6jFXWsYnvaEVTIn6Q0oCyQ74gkTsnWMwyzSjl4duOIAHrg6zu0dBRqxUxUidRO1yPOMV68gttQUO6pUuWjLIw/dTZS7NhZufMTbbEcnI6y/DMo5fMwZ9gPLujITH+8qRt5D7m1MzccLL6Q8yWtmatuuMR1K7CiS4t9n0t4LAew9Ht+j7PIzTgTzLyVXNij/SWnVWLa+fnmUlyWgqmECh9guDa8hUzyp2A=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(39850400004)(366004)(346002)(396003)(66556008)(6486002)(66946007)(66476007)(44832011)(956004)(8676002)(8936002)(316002)(6916009)(2616005)(2906002)(6666004)(1076003)(6512007)(6506007)(36756003)(186003)(26005)(16526019)(52116002)(4326008)(83380400001)(38100700002)(38350700002)(5660300002)(478600001)(86362001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3nF0zBmROK9ivV9aB97Vz7gjq4GrC7LilzTm/0ZFrkfWwHQO76j+NaOeGYK6?=
 =?us-ascii?Q?7KgOhV/htVzApp/oX61tGGRjLqMPXVEYhVz/kHGLrdM0nOL+cAC2nkH0OQFc?=
 =?us-ascii?Q?PVlIJVU2WgPYsf2ec0deD7t6cGuIsob9ho0e4yEDzXJqlLTeZcInZ7ff8PH5?=
 =?us-ascii?Q?duME43Z0qzmD2TF/IMR6siusye60NuLlY8ykJVXNlouUy2/ySVrQuyGe21NA?=
 =?us-ascii?Q?zbsayS1LoJuJj0O/Txfc/hFHu3GRFLDJzciXNh775dtnBA1+66FDsMkm8Vig?=
 =?us-ascii?Q?60xGJaoSQWvh4wUG7CB17K47Dr4g6k2Zn+YIS5saTV/OAG1tLnVP84fEU26/?=
 =?us-ascii?Q?m3W4k9DvRBTqTs4ABK+44oArGDhfv/oO8SxdKezgXkGLmv1uILXIf+lsQrZS?=
 =?us-ascii?Q?e/6gj2vzmtly/pNL/Bbcf1aP4wEE8kx7B7LZmfcLnpJlapXaBVhN+bjNGAQD?=
 =?us-ascii?Q?9bdxPxKKEIt7aqdLCkkf6b5qw2+BAYdJEk1aETZG7LKR+hQTVVHdLoXsvIYC?=
 =?us-ascii?Q?05mTllC9zDJEMyDnF21FOPjOE8qPpgi3uvkShS2bmflY9F2jq+CMKBioMMlY?=
 =?us-ascii?Q?hRog5+RRQR+vVwJMxnpGIO3//8+nzNBVXyPFBntYTli74VuG2Q488u65fiy7?=
 =?us-ascii?Q?+K8bFWs9usC6XMPFq2vJCEGt8h/RpuU3LHv/eLztmkK5ABFLCRKUpskba37Z?=
 =?us-ascii?Q?kOoMLKZd5R9QQVY3LmMxXsdKtNbu7CxnCM8j4g3oWDjhaI8LB+9LrUllYmUv?=
 =?us-ascii?Q?Ow48o5cz+VTNhlYNUwPnyiI6OqBVezZ9WdVA8UjOx5hNky00sk8gSJflAKf1?=
 =?us-ascii?Q?2OpX5UgCyIFFzwrzKe9a7xmsUTeefcfWMZkFSGZ5fjsED25p9HA7uEDZVVz0?=
 =?us-ascii?Q?hZRGFQd2VVXccw8zCyc3mYSRS7+nlPFgOLu9sXAKpEGRfGhBiKYVjrLbi3wd?=
 =?us-ascii?Q?vrAhm3bFrWfjCoZEOqdcpW2XzOeUQ2MArTm08UYyXwHZatLsCs8nasiRl6Oo?=
 =?us-ascii?Q?oL+X9qBcydMm+KpfUMOD7BzvtDOxx+0I2kmInU7zeoSQtJq7mSm6mJGNJhYb?=
 =?us-ascii?Q?qYr9Lt3E5ybsO3tV7NEaSVFF+f4sYcImKE/n+/zG1DGgM38HmbXHQeU9Pe1r?=
 =?us-ascii?Q?QiZeizO8ZVYiRlTCHFZ89o0Ot/JlkK1cp82C5ue2IXLmCCD4wpUlVnXHpnmR?=
 =?us-ascii?Q?KBymktjBygL37sTWAe1UnO2s/lVhi7hoP3UqRz33QBcKj/uqKLZzAGTS7501?=
 =?us-ascii?Q?nQGhCrNmtEZmbE9vsBdRk/Ku3n0ann3rFkuvcJyCpNoKIrHii5qrF/iRI6lW?=
 =?us-ascii?Q?gZNvdNulgpV+PW/oOKCQLWCm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6d54b5b-3f85-4dfe-efe7-08d93641f968
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2021 12:25:23.8099 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hs4xV2AEmExjwTounUdm1i+//JKX2XV+S6pssSK68S12h1LYnZCc+OKGRsOcwT+RLLTrNXu1xlZHdXLAWpkE2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5477
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 134 +++++++++++--------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h |   3 +-
 2 files changed, 60 insertions(+), 77 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index be841d62a1d4..e047e56a4be2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -87,6 +87,39 @@ struct amdgpu_prt_cb {
 	struct dma_fence_cb cb;
 };
 
+static int amdgpu_vm_set_pasid(struct amdgpu_device *adev,
+			       struct amdgpu_vm *vm,
+			       unsigned long pasid)
+{
+	unsigned long flags;
+	int r;
+
+	if (pasid) {
+		xa_lock_irqsave(&adev->vm_manager.pasids, flags);
+		r = xa_err(__xa_store(&adev->vm_manager.pasids, pasid, vm,
+				      GFP_ATOMIC));
+		xa_unlock_irqrestore(&adev->vm_manager.pasids, flags);
+		if (r < 0)
+			return r;
+	} else {
+		unsigned long index;
+		struct amdgpu_vm *res;
+
+		xa_lock_irqsave(&adev->vm_manager.pasids, flags);
+		xa_for_each(&adev->vm_manager.pasids, index, res) {
+			if (res == vm) {
+				__xa_erase(&adev->vm_manager.pasids, index);
+				break;
+			}
+		}
+		xa_unlock_irqrestore(&adev->vm_manager.pasids, flags);
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
@@ -2940,18 +2973,9 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm, u32 pasid)
 
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
 
@@ -3039,18 +3063,11 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	if (r)
 		goto unreserve_bo;
 
-	if (pasid) {
-		unsigned long flags;
-
-		spin_lock_irqsave(&adev->vm_manager.pasid_lock, flags);
-		r = idr_alloc(&adev->vm_manager.pasid_idr, vm, pasid, pasid + 1,
-			      GFP_ATOMIC);
-		spin_unlock_irqrestore(&adev->vm_manager.pasid_lock, flags);
-
-		if (r == -ENOSPC)
-			goto unreserve_bo;
-		r = 0;
-	}
+	/* remove previous {pasid:vm} entry first */
+	r = amdgpu_vm_set_pasid(adev, vm, 0);
+	r = amdgpu_vm_set_pasid(adev, vm, pasid);
+	if (r)
+		goto unreserve_bo;
 
 	/* Check if PD needs to be reinitialized and do it before
 	 * changing any other state, in case it fails.
@@ -3061,7 +3078,7 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 				       to_amdgpu_bo_vm(vm->root.bo),
 				       false);
 		if (r)
-			goto free_idr;
+			goto free_pasid_entry;
 	}
 
 	/* Update VM state */
@@ -3078,7 +3095,7 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		r = amdgpu_bo_sync_wait(vm->root.bo,
 					AMDGPU_FENCE_OWNER_UNDEFINED, true);
 		if (r)
-			goto free_idr;
+			goto free_pasid_entry;
 
 		vm->update_funcs = &amdgpu_vm_cpu_funcs;
 	} else {
@@ -3088,31 +3105,14 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	vm->last_update = NULL;
 	vm->is_compute_context = true;
 
-	if (vm->pasid) {
-		unsigned long flags;
-
-		spin_lock_irqsave(&adev->vm_manager.pasid_lock, flags);
-		idr_remove(&adev->vm_manager.pasid_idr, vm->pasid);
-		spin_unlock_irqrestore(&adev->vm_manager.pasid_lock, flags);
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
+free_pasid_entry:
+	amdgpu_vm_set_pasid(adev, vm, 0);
 
-		spin_lock_irqsave(&adev->vm_manager.pasid_lock, flags);
-		idr_remove(&adev->vm_manager.pasid_idr, pasid);
-		spin_unlock_irqrestore(&adev->vm_manager.pasid_lock, flags);
-	}
 unreserve_bo:
 	amdgpu_bo_unreserve(vm->root.bo);
 	return r;
@@ -3128,14 +3128,7 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm,
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
 
@@ -3159,15 +3152,7 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 
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
 
@@ -3249,8 +3234,7 @@ void amdgpu_vm_manager_init(struct amdgpu_device *adev)
 	adev->vm_manager.vm_update_mode = 0;
 #endif
 
-	idr_init(&adev->vm_manager.pasid_idr);
-	spin_lock_init(&adev->vm_manager.pasid_lock);
+	xa_init_flags(&adev->vm_manager.pasids, XA_FLAGS_LOCK_IRQ);
 }
 
 /**
@@ -3262,8 +3246,8 @@ void amdgpu_vm_manager_init(struct amdgpu_device *adev)
  */
 void amdgpu_vm_manager_fini(struct amdgpu_device *adev)
 {
-	WARN_ON(!idr_is_empty(&adev->vm_manager.pasid_idr));
-	idr_destroy(&adev->vm_manager.pasid_idr);
+	WARN_ON(!xa_empty(&adev->vm_manager.pasids));
+	xa_destroy(&adev->vm_manager.pasids);
 
 	amdgpu_vmid_mgr_fini(adev);
 }
@@ -3332,13 +3316,13 @@ void amdgpu_vm_get_task_info(struct amdgpu_device *adev, u32 pasid,
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
@@ -3380,15 +3364,15 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
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
@@ -3406,11 +3390,11 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
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
index ddb85a85cbba..31c467764162 100644
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
-- 
2.32.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
