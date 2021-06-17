Return-Path: <SRS0=/AY/=LL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87C7DC48BE5
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Jun 2021 13:03:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 504A6613A9
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Jun 2021 13:03:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 504A6613A9
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D8B46E231;
	Thu, 17 Jun 2021 13:03:57 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2050.outbound.protection.outlook.com [40.107.94.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 29C176E139
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Jun 2021 13:03:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VSGBMxCrsJqky1I6Tp0NZua5s5hOvQym+tEYV//xbvXkqjEZ7ZugaRTNYqNqlfi7x95ScYGMUvibhP8dby/Orfc4UaaQHNF4/ooSWX2EIl0/PpcYhyPXa+DdvhkKuULD2eHRoRUN3LkPY0VVb5VG/eQ0CXuo92miZjI0gpyuWL2jvuv7VNkrGhhnXgJAPDy9dm6X7E3GdnFKLrROhYg7MwaOPCE/Xod6YaXctUDvYCKXH4OLpFtHAoNRUWacz3ez2HyfQWApTU9/p1S93wNPDde/wQlB1RcFUZcRpm5IeWLJivnx+orfjp7jSKo9ZfGObQvkuIsrh2asTUBzeMSAFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=42do5e5mRY2z1YWnjgYDg0n8ZywIdHmmzwNcfSdTqF0=;
 b=MREFbIzhVFsN5RG1ILEu7um3n0iY28KF9GcAoRbO3xpbcYRV5DapE2qhKM+rackxY/CMNQmlMEK4NCOWsUAbwL5mcWbeFQ739zosA3//S+5I17QgrlfI+jUelYzHjTKjkxj12Wdtt51hfttaemDoS8XX6VxrJ5vjiiqLzwOHtwyd9VoiKmOn/03+WZq45ClmzifLyQRkC9Wyw35tll7lPthRjsOxxx3rmr/sfOlHfJY0Fxyu4aUiYlPLI0HsLgpMVxmbBKR6ilFtR8+9l+OVG3SyIzBsTXvrPVN2H4HzgMoUFMz6nnNDQwHwuyMGcD4hS+twy/1ihxGFqoR0kzcLXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=42do5e5mRY2z1YWnjgYDg0n8ZywIdHmmzwNcfSdTqF0=;
 b=ANi/ZfiFcTeX6dA9GXSDa7BGQAltnO92WNJuJTJB7chFD0rh1pS5Mj2gj5OVAVFxzrPxV5xNbPJHOTdeygHpmsu7TCDPGHm6KhTdgLE6SE9Rp94XPSt7422ipvAGv5znB9qEGyXf7pQTSsRT5cdQnaYV8+SdeIe2wseGeeTN63w=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by DM4PR12MB5374.namprd12.prod.outlook.com (2603:10b6:5:39a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16; Thu, 17 Jun
 2021 13:03:53 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::901b:72bb:a15:2a68]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::901b:72bb:a15:2a68%5]) with mapi id 15.20.4242.021; Thu, 17 Jun 2021
 13:03:53 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/1] drm/amdgpu: add helper function for vm pasid
Date: Thu, 17 Jun 2021 15:03:34 +0200
Message-Id: <20210617130334.15366-1-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.32.0
X-Originating-IP: [217.86.117.75]
X-ClientProxiedBy: PR2P264CA0015.FRAP264.PROD.OUTLOOK.COM (2603:10a6:101::27)
 To DM4PR12MB5136.namprd12.prod.outlook.com
 (2603:10b6:5:393::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brihaspati.fritz.box (217.86.117.75) by
 PR2P264CA0015.FRAP264.PROD.OUTLOOK.COM (2603:10a6:101::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4242.18 via Frontend Transport; Thu, 17 Jun 2021 13:03:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6835a419-d7c0-4cfd-5cfd-08d931905b86
X-MS-TrafficTypeDiagnostic: DM4PR12MB5374:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB53740B24741EAB50B5435EDE8B0E9@DM4PR12MB5374.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Tf/KzD0WjlspMzQEos/PgV0y3glFUoo3g3hf0vLYMsoxc68cygJTfD8ZAq6FT6zi6OaYtzZ43y+m45kVCpnHK+W77rwjBFhZvUPjnHehQP8MMiNz3Pb8q6184ctE09GzmdyTMBqWZ0ZoMfEW7roxzpbIP5+6PwqTVAv/w+8cgB1cl3unPSNA4OP32Qb4pN+P49D8C1kdUUW6+rxTVnutjBIKbkcCaZQzyO3PW1p69ubNogDX6x5Lp+BMiye7N78h+yZIcndoB/1PBM0nvnNtXg7xksIhsfSOCtW+7CxRt8q07gIoqbjJBzcOdLbZP5KaChw/1xtlWGayEJd+5GoTT25AI4m0AtWBvD8ywOsiQL5avFqOPoXHDC1Fhyibk0SRPGKwJD6zWkr+1Bc6/QyhkVl8ITHX4eoLe3kzuLCnxcKTJR/C2gJ8uAIUa6XoV0gW0ZNC425OK7Do8ZUDJZQWmZ0s0CNmD4sbrfhu5vsDzd6JFhNCXByOhjS3gv8gVsOkuzEkQ3YT1ahFjxQ6PVgR6kCff33K80NNpxQgH//ZEFp1jwUsyYPjL+7PQtDO7tksVlzgVu+AkBVXfDn5o4/Bnk2R2Oy9qPaHAM/9N7HNCSjuPioulKib9DQqxFp/vwdjr7Mte8LDW/FzF5TjnWyicg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(346002)(366004)(376002)(39860400002)(36756003)(6916009)(1076003)(83380400001)(316002)(8936002)(38350700002)(66476007)(30864003)(38100700002)(66946007)(6666004)(2906002)(478600001)(5660300002)(6486002)(186003)(8676002)(86362001)(16526019)(4326008)(6506007)(44832011)(2616005)(66556008)(52116002)(26005)(6512007)(956004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ogd/cNV93jsQikfKVv4D3BhSu3CvSxMKEN0KglfMUWSeavf0OagoRYb+XSUq?=
 =?us-ascii?Q?+/QeL5onqy0+xId8261vP07LgZQfGWHCpRKM1fZBzfDevMCMfBTjV08/oTHa?=
 =?us-ascii?Q?pHrsGKtYacHZhsZHKTrgEQBMmGihgCZ/qqgPzco2WHOP6uo5teJj8bQNwsYq?=
 =?us-ascii?Q?K+DV5hX7CF6CHZnnLxmaDvTpBgun3gLVGCbgr91xFMTwHWddWLQ3PtGntUCz?=
 =?us-ascii?Q?FegR6H2lgcdwihH3zbdmmMrTdC3/7w4o26RRhxoqwlPmW+5/CxczoYiLbWdA?=
 =?us-ascii?Q?N3MtwvaW4XZkH4Zk7ockUVAQiddD63SjKBJdTLhvKSbhQxpbKhCabEM7eqMy?=
 =?us-ascii?Q?KsSK5+cMeMMfIe4YUcpHmEDZvMkLw0EiHwrwdLEiYdqI1twMDXGxL1eGeaGq?=
 =?us-ascii?Q?qcaq0XxTBTa2klCSFSPcvc9YzwQcakR2kbiLRBuds4XPSLAWWhnAHc+CLpEn?=
 =?us-ascii?Q?Yd4d1+FXigV95hTTfDhWedtDG2jBQ+tzR2PGGHBTKpoMZqKrWPs5ECJkEjQ1?=
 =?us-ascii?Q?IWFE/Lk94Qq+Hw+oZwq/Y+1t0nKcxZJFsEWelaH83XnvVJZ8YY1KfOHHmU5R?=
 =?us-ascii?Q?Y2VEOe8kcePyU06xtL7z4IOYNb2iES52/PN+wxsVc/wSymrwxSgHLckJfWTs?=
 =?us-ascii?Q?8QG1K1aKRhnXgpoBYXYZaxvVh9Mz/ixpwVWOEwyQwhCml/wQszPFhV43Trg3?=
 =?us-ascii?Q?8x0Hr4wDcnO5jQqxYF6F1hdka0YG6YpBSqdwmk/9f2greL72g/3SXl9zG1Hp?=
 =?us-ascii?Q?QoIWyjp/nZYsf/90Fo2fL1Nf9CRtlAceWgdgZT4D+kxLJR7kk0L6ZOlbvWBN?=
 =?us-ascii?Q?o0GG6BlzgjY0JVWbd0q8lMF9S7/+qroNMdt+tUnxGOjfaagNdfRzK3OPQcYx?=
 =?us-ascii?Q?XLI4THxCHKh0flPjBU6IvzY/s6yyW0FgzKTwNaA34mQo7HVF2xxJW+3aQYHQ?=
 =?us-ascii?Q?eElwlHXZTuPv/16f/7MrORklP8Jq5+51trsDY/sKYxs8DCV3twuXQbGFcDJz?=
 =?us-ascii?Q?RNZtjpJsb0PD1JgP8edbXPfNlmtLdQ9M6Bw/iMSV9wt7BQ2hieEu4igACdN2?=
 =?us-ascii?Q?ac/mNU0ORNNqVZEgbpHYXoAREcj9xO48JdC36UK5rGaOQufgF0JVJxmL577o?=
 =?us-ascii?Q?PuFLlxUl16aoQGokITe3c4Y+tUYJUYgRA+x1pYjz51f3MM7tmnjq6L2lFN49?=
 =?us-ascii?Q?URISmEjqHiEXklNP78CdjKMtIS8bvlk+gX7noBKQyFI3P8MTxbr3GYTGZ6lm?=
 =?us-ascii?Q?VCMpt2WHHxae9cHDpmzU4zTm6qNYy9gTktIV1Va2Bx40RiqrmAJ/EQhRLiFp?=
 =?us-ascii?Q?yXLfYuORcN+VQ5zKD8ObPOPR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6835a419-d7c0-4cfd-5cfd-08d931905b86
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2021 13:03:53.3246 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l2KpTJiFfJGJMRMOuj6a4v8oSY4ZP0pYhRqrCTsoQtftCV6F+FD+tPNq6gLAse3oirtLT5HcSN4oVFZttVzuDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5374
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

Cleanup code related to vm pasid by adding helper function.
This reduces lots code duplication.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c |  17 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  | 176 ++++++++++++------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h  |   2 +-
 3 files changed, 96 insertions(+), 99 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index cbb932f97355..27851fb0e25b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -1149,7 +1149,7 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
 {
 	struct amdgpu_device *adev = drm_to_adev(dev);
 	struct amdgpu_fpriv *fpriv;
-	int r, pasid;
+	int r;
 
 	/* Ensure IB tests are run on ring */
 	flush_delayed_work(&adev->delayed_init_work);
@@ -1172,15 +1172,9 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
 		goto out_suspend;
 	}
 
-	pasid = amdgpu_pasid_alloc(16);
-	if (pasid < 0) {
-		dev_warn(adev->dev, "No more PASIDs available!");
-		pasid = 0;
-	}
-
-	r = amdgpu_vm_init(adev, &fpriv->vm, pasid);
+	r = amdgpu_vm_init(adev, &fpriv->vm);
 	if (r)
-		goto error_pasid;
+		goto free_fpriv;
 
 	fpriv->prt_va = amdgpu_vm_bo_add(adev, &fpriv->vm, NULL);
 	if (!fpriv->prt_va) {
@@ -1208,10 +1202,7 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
 error_vm:
 	amdgpu_vm_fini(adev, &fpriv->vm);
 
-error_pasid:
-	if (pasid)
-		amdgpu_pasid_free(pasid);
-
+free_fpriv:
 	kfree(fpriv);
 
 out_suspend:
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 63975bda8e76..562c2c48a3a3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -87,6 +87,69 @@ struct amdgpu_prt_cb {
 	struct dma_fence_cb cb;
 };
 
+static int amdgpu_vm_pasid_alloc(struct amdgpu_device *adev,
+				 struct amdgpu_vm *vm, unsigned int pasid)
+{
+	unsigned long flags;
+	int r;
+
+	if (!pasid)
+		return 0;
+
+	spin_lock_irqsave(&adev->vm_manager.pasid_lock, flags);
+	r = idr_alloc(&adev->vm_manager.pasid_idr, vm, pasid, pasid + 1,
+		      GFP_ATOMIC);
+	spin_unlock_irqrestore(&adev->vm_manager.pasid_lock, flags);
+	if (r < 0)
+		return r;
+
+	vm->pasid = pasid;
+	return 0;
+}
+static void amdgpu_vm_pasid_remove_id(struct amdgpu_device *adev,
+				      unsigned int pasid)
+{
+	unsigned long flags;
+
+	if (!pasid)
+		return;
+
+	spin_lock_irqsave(&adev->vm_manager.pasid_lock, flags);
+	idr_remove(&adev->vm_manager.pasid_idr, pasid);
+	spin_unlock_irqrestore(&adev->vm_manager.pasid_lock, flags);
+
+}
+
+static void amdgpu_vm_pasid_remove(struct amdgpu_device *adev,
+				   struct amdgpu_vm *vm)
+{
+	amdgpu_vm_pasid_remove_id(adev, vm->pasid);
+	vm->pasid = 0;
+}
+
+static void amdgpu_vm_pasid_free(struct amdgpu_device *adev,
+				 struct amdgpu_vm *vm)
+{
+	if (!vm->pasid)
+		return;
+
+	amdgpu_pasid_free(vm->pasid);
+	amdgpu_vm_pasid_remove(adev, vm);
+}
+
+static struct amdgpu_vm *amdgpu_vm_pasid_find(struct amdgpu_device *adev,
+					      unsigned int pasid)
+{
+	struct amdgpu_vm *vm;
+	unsigned long flags;
+
+	spin_lock_irqsave(&adev->vm_manager.pasid_lock, flags);
+	vm = idr_find(&adev->vm_manager.pasid_idr, pasid);
+	spin_unlock_irqrestore(&adev->vm_manager.pasid_lock, flags);
+
+	return vm;
+}
+
 /*
  * vm eviction_lock can be taken in MMU notifiers. Make sure no reclaim-FS
  * happens while holding this lock anywhere to prevent deadlocks when
@@ -2859,17 +2922,17 @@ long amdgpu_vm_wait_idle(struct amdgpu_vm *vm, long timeout)
  *
  * @adev: amdgpu_device pointer
  * @vm: requested vm
- * @pasid: Process address space identifier
  *
  * Init @vm fields.
  *
  * Returns:
  * 0 for success, error for failure.
  */
-int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm, u32 pasid)
+int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 {
 	struct amdgpu_bo *root_bo;
 	struct amdgpu_bo_vm *root;
+	unsigned int pasid;
 	int r, i;
 
 	vm->va = RB_ROOT_CACHED;
@@ -2940,19 +3003,15 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm, u32 pasid)
 
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
+	pasid = amdgpu_pasid_alloc(16);
+	if (pasid < 0) {
+		dev_warn(adev->dev, "No more PASIDs available!");
+		pasid = 0;
 	}
 
+	if (amdgpu_vm_pasid_alloc(adev, vm, pasid))
+		goto error_free_pasid;
+
 	INIT_KFIFO(vm->faults);
 
 	return 0;
@@ -2960,6 +3019,10 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm, u32 pasid)
 error_unreserve:
 	amdgpu_bo_unreserve(vm->root.bo);
 
+error_free_pasid:
+	if (pasid)
+		amdgpu_pasid_free(pasid);
+
 error_free_root:
 	amdgpu_bo_unref(&root->shadow);
 	amdgpu_bo_unref(&root_bo);
@@ -3039,18 +3102,11 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	if (r)
 		goto unreserve_bo;
 
-	if (pasid) {
-		unsigned long flags;
-
-		spin_lock_irqsave(&adev->vm_manager.pasid_lock, flags);
-		r = idr_alloc(&adev->vm_manager.pasid_idr, vm, pasid, pasid + 1,
-			      GFP_ATOMIC);
-		spin_unlock_irqrestore(&adev->vm_manager.pasid_lock, flags);
+	r = amdgpu_vm_pasid_alloc(adev, vm, pasid);
+	if (r ==  -ENOSPC)
+		goto unreserve_bo;
 
-		if (r == -ENOSPC)
-			goto unreserve_bo;
-		r = 0;
-	}
+	r = 0;
 
 	/* Check if PD needs to be reinitialized and do it before
 	 * changing any other state, in case it fails.
@@ -3088,19 +3144,7 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm,
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
+	amdgpu_vm_pasid_free(adev, vm);
 
 	/* Free the shadow bo for compute VM */
 	amdgpu_bo_unref(&to_amdgpu_bo_vm(vm->root.bo)->shadow);
@@ -3111,13 +3155,8 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	goto unreserve_bo;
 
 free_idr:
-	if (pasid) {
-		unsigned long flags;
+	amdgpu_vm_pasid_remove_id(adev, pasid);
 
-		spin_lock_irqsave(&adev->vm_manager.pasid_lock, flags);
-		idr_remove(&adev->vm_manager.pasid_idr, pasid);
-		spin_unlock_irqrestore(&adev->vm_manager.pasid_lock, flags);
-	}
 unreserve_bo:
 	amdgpu_bo_unreserve(vm->root.bo);
 	return r;
@@ -3133,14 +3172,7 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm,
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
+	amdgpu_vm_pasid_remove(adev, vm);
 	vm->is_compute_context = false;
 }
 
@@ -3164,15 +3196,7 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 
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
+	amdgpu_vm_pasid_remove(adev, vm);
 	dma_fence_wait(vm->last_unlocked, false);
 	dma_fence_put(vm->last_unlocked);
 
@@ -3334,16 +3358,10 @@ int amdgpu_vm_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 void amdgpu_vm_get_task_info(struct amdgpu_device *adev, u32 pasid,
 			 struct amdgpu_task_info *task_info)
 {
-	struct amdgpu_vm *vm;
-	unsigned long flags;
+	struct amdgpu_vm *vm = amdgpu_vm_pasid_find(adev, pasid);
 
-	spin_lock_irqsave(&adev->vm_manager.pasid_lock, flags);
-
-	vm = idr_find(&adev->vm_manager.pasid_idr, pasid);
 	if (vm)
 		*task_info = vm->task_info;
-
-	spin_unlock_irqrestore(&adev->vm_manager.pasid_lock, flags);
 }
 
 /**
@@ -3380,24 +3398,16 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
 {
 	bool is_compute_context = false;
 	struct amdgpu_bo *root;
-	unsigned long irqflags;
 	uint64_t value, flags;
 	struct amdgpu_vm *vm;
 	int r;
 
-	spin_lock_irqsave(&adev->vm_manager.pasid_lock, irqflags);
-	vm = idr_find(&adev->vm_manager.pasid_idr, pasid);
-	if (vm) {
-		root = amdgpu_bo_ref(vm->root.bo);
-		is_compute_context = vm->is_compute_context;
-	} else {
-		root = NULL;
-	}
-	spin_unlock_irqrestore(&adev->vm_manager.pasid_lock, irqflags);
-
-	if (!root)
+	vm = amdgpu_vm_pasid_find(adev, pasid);
+	if (!vm)
 		return false;
 
+	root = amdgpu_bo_ref(vm->root.bo);
+		is_compute_context = vm->is_compute_context;
 	addr /= AMDGPU_GPU_PAGE_SIZE;
 
 	if (is_compute_context &&
@@ -3411,12 +3421,8 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
 		goto error_unref;
 
 	/* Double check that the VM still exists */
-	spin_lock_irqsave(&adev->vm_manager.pasid_lock, irqflags);
-	vm = idr_find(&adev->vm_manager.pasid_idr, pasid);
-	if (vm && vm->root.bo != root)
-		vm = NULL;
-	spin_unlock_irqrestore(&adev->vm_manager.pasid_lock, irqflags);
-	if (!vm)
+	vm = amdgpu_vm_pasid_find(adev, pasid);
+	if (!vm || (vm && vm->root.bo != root))
 		goto error_unlock;
 
 	flags = AMDGPU_PTE_VALID | AMDGPU_PTE_SNOOPED |
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index ddb85a85cbba..ee994e21dffa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -376,7 +376,7 @@ void amdgpu_vm_manager_init(struct amdgpu_device *adev);
 void amdgpu_vm_manager_fini(struct amdgpu_device *adev);
 
 long amdgpu_vm_wait_idle(struct amdgpu_vm *vm, long timeout);
-int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm, u32 pasid);
+int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm);
 int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm, u32 pasid);
 void amdgpu_vm_release_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm);
 void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm);
-- 
2.32.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
