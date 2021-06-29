Return-Path: <SRS0=w1A1=LX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26C08C11F67
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Jun 2021 15:19:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D25AE61DA6
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Jun 2021 15:19:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D25AE61DA6
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 925486E8A3;
	Tue, 29 Jun 2021 15:19:26 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2046.outbound.protection.outlook.com [40.107.243.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A38E96E8A3
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Jun 2021 15:19:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LryOVTezTMPQmBOhcmwbE8Na+6ud7WIcOs5Mz3i6pY8S8ILBPr76bRwqubR+m7vyFuPiTQ71Ve+dSSeryBYX9ElnwPT4GqDtYdQAy0LR6+uFpqupIdHTmpKFzeQbMejH92ciOpo03zUuF4irooAOrJBjqdPNsDYcl0IIpoH5v1Ic0BPG56uhlvpWM341cqb00us01lpRJlfB7z7OrFrjcPtsvWilQUZo1RfIxaSybGMIoUtqXP+8MTNmaCoEViJVlEFBZvV07v9M51Os+l5lK7aUEjMkN3fBBUxVw/LV8pSzGQo8n6tg8GPWU6jfQsDtFpBRGqcrVR2+Mdouluf/0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XH5SOAjw4+JWHu0lJJbk9Be5jYvJLeoXbLm3bsh4778=;
 b=OSUxM3iFwCZTX/YNdiJfS8QLrKAgxK76zj0DbPbel8JsZMSKW1zeaC4jr2Oy/n1lQgBf8EWG0HOS9TA6xdSJVgNYCoM1HcFDpZZjzxuOSCEhOmfWT7kvJLCOvfZfRpMIQDUX7RsXwPwPU2hm0JeMWF/HOh2F+2XT+RO+SFFW6+/WiYIN+DrjAlQiWiLtDEkJYb9jM3UNN6CwgoGdc9UkeYk+X/qkp9sF8n4/rxgHKQ/T5wMoSx0mnesLQn1aX1Oefr9dVqk7J8+Lgw6I/8HhpWiHCM/osaSiE+ko4+6a77ZUvsJKeRCfrXDUz1BOF29OpBDBMf2SREs3clEBeNe+ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XH5SOAjw4+JWHu0lJJbk9Be5jYvJLeoXbLm3bsh4778=;
 b=ALOjc7TUCUujHZuNp6zNhlMhTqUAJBjS9EA/mbssj8bfRkYbc4FpuyObyqGAf5CT+ixG0E6EvNRPkIjYS6KOdPe7mUm0uWg6xpgC93AdYGvZALlpxVjoSYX4GhtAwuEiuXE8IDj+VYClckdTj2TQ3tScOIR2mzIlRgB9osHUF6g=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by DM8PR12MB5431.namprd12.prod.outlook.com (2603:10b6:8:34::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4264.20; Tue, 29 Jun 2021 15:19:22 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::901b:72bb:a15:2a68]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::901b:72bb:a15:2a68%4]) with mapi id 15.20.4264.026; Tue, 29 Jun 2021
 15:19:22 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amdgpu: use xarray for storing pasid in vm
Date: Tue, 29 Jun 2021 17:19:06 +0200
Message-Id: <20210629151907.4251-1-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.32.0
X-Originating-IP: [217.86.118.245]
X-ClientProxiedBy: AM0PR02CA0164.eurprd02.prod.outlook.com
 (2603:10a6:20b:28d::31) To DM4PR12MB5136.namprd12.prod.outlook.com
 (2603:10b6:5:393::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brihaspati.fritz.box (217.86.118.245) by
 AM0PR02CA0164.eurprd02.prod.outlook.com (2603:10a6:20b:28d::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.22 via Frontend
 Transport; Tue, 29 Jun 2021 15:19:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 501ebdbd-a027-43bb-e251-08d93b1145ed
X-MS-TrafficTypeDiagnostic: DM8PR12MB5431:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM8PR12MB54310F1D2EEA35FF9F1D2EED8B029@DM8PR12MB5431.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oJumLhiukB5NlO+AeGw0lMbqVDwVI/pAUF9q1sIpB31el67m69KpnYRDSQC2qBcDR2QuKW3SjXhaDHffw3PvCfxbtNlabvx9uP4XtaIjznagfFT1kYn8XJTwF3qheV62/Tw4Cq9McVWo/yR/eTeD8+u9X5ivj+yn+jo5o4f+Y1lJ25BiKC+g8AsR4et52dSX8kUE9ln53EkOD3EvJ96gYwzdP7olp1ZqBr0pTq5UWVYgRqWou0GqJ5eyPnASQCWNucT5JookqkdkRdCkD1gx+vf+TVEy0jV8L0urtdqyJuMyQsdkDWv5R2DFIGeUm6YTmBalKEU8RWRBtF3xJgRaPvi0w1az1uexYIpHqdlc/aVvm6HgHLm6TJ977tmFEuTOAp1hZY5AaSd4p6Fl3PZWpMMs8oa1ld/S5V7T6nlRadoMjuOXWqzQ6DtfYKHTCsjhZqexTtYMBKhRZFYNR084TNrY/y9sSa3FGHwFsIndZVjZTLj3vgX/y9F6wzAE5HD0eZfMpPyAmKofigkLIBLNuRjd7V4zMbioSCV5VJzly71Ek6U0mXKDRbHb7SZ292gEfebCnty+JXTk92c266AX7hVnU079P77Z+gBE3m8p334/vVNE3f66zNuvdeD/Iq2vZnkmH0eWtIQj54pcbiaAT5/y5+oIb4J5oFIzHjeePixd2u/IViiTGitcdzyy2Yyi6B1lu6zHJPox0hyiWacMOQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(346002)(136003)(396003)(366004)(6506007)(1076003)(44832011)(52116002)(2616005)(8936002)(38100700002)(2906002)(38350700002)(5660300002)(478600001)(956004)(83380400001)(8676002)(6666004)(66476007)(6916009)(16526019)(6512007)(66556008)(36756003)(6486002)(26005)(186003)(66946007)(86362001)(4326008)(316002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WvvkPnnXt+eCO+UdZfzWJJF2nReZ04boANpa5v/ge4ik709SH9CsgFkpgx95?=
 =?us-ascii?Q?SV9cxwHLJ+TYm4p8P0icu/i/R5LlYbrCZJKheiTRbpcIU+E35oZMw51VQC8s?=
 =?us-ascii?Q?wlLH4U9CNBa6ZSMU1sUTIIaiSSoer+s5ixeD+yAKHIS17hOkI9bQl2wz5msR?=
 =?us-ascii?Q?M2RWA9peRihFT+l6AQQdNZ3lxPH536pREZdU0+4G5YzuqGo1cwIhJBHe8S+K?=
 =?us-ascii?Q?aDvmUEYDjEesEtUTIo+TdVmlnVa55RrGCCfYbTYJr9uXVmIrJzT9SWZJR8fF?=
 =?us-ascii?Q?LxbfdqT1PW3MJilt4SatPQLwO3ZUI6CQrNbhfa/qSSNosfHdZQBOGYxILqc2?=
 =?us-ascii?Q?mwIncf5tnxyHmvAI7Ak0RlSOR2ayGTOatmPpGUdYUVGHVHB0p31B8ClOwElf?=
 =?us-ascii?Q?fLZfekRF9TnKTDRnM8P0pB/BzbLfBoqdIvocTzp+XPo8u6GjbMT+WxMbIuyq?=
 =?us-ascii?Q?8ow/NZml/LB6jmRPTTtTO9MI7jntiw1BH/y0R/XjT09A57co+cPG6MuVS7CN?=
 =?us-ascii?Q?RIvrJDq+kg4qJfOnnzBvlufbLap32rfCtxTvtxkCN3FL+Axs+XV3UnIviVJv?=
 =?us-ascii?Q?2MhkifTNmj+/5sEsLx3plxIzoNYqdQpvdX0crb+6SCAI+9R+MO2HDZ9YIvbc?=
 =?us-ascii?Q?CnO4+/i0NuAs7PqVZ8TEdiu1mD0eQwEL+AoofGXXlzKlkCMBXnfC0aQqI2fQ?=
 =?us-ascii?Q?1j3RN1rlX2Yuj2zs0IQ6gO7HTcZz8CcBjVSuwmETld/MJ8WKADC6D0pXoN/r?=
 =?us-ascii?Q?tqyhRnlBlpl9Gxsn968P1Y1IptNFUNbI+1AIAzrbLndlXcVA8U9b2/P1ExE+?=
 =?us-ascii?Q?j1HM93+GXuH5krEJki4nBepkPa5lSrpmty+AjHzBdbACSf8793/Ru0lHKqmB?=
 =?us-ascii?Q?xVfNkO2MUvEjroIOsctJszMQ+0mkhZ2b4Cj0FlddZbypdvgtULlQ5xPlKPof?=
 =?us-ascii?Q?778Up0+crLhdAiv0knyOiYupgF/bBHLmt+NGX5457KkqFO88diGrbsVFmHiX?=
 =?us-ascii?Q?q5tqXCS4XnrkLzeWEJHNgsGPvi1Fljej22va+froNMQKOhMVhMprmNZdUSOf?=
 =?us-ascii?Q?x9nKt2qQp5zbmia8HZMWAsNrVGTwgYoCemIjkAF/25PuSuN2tGimM6tTZkyM?=
 =?us-ascii?Q?z/2gi7PlxFKb8mKhSshpXsiJkYdmV3GJRaS6yDX7RzpI39CdV0pA73x44mAZ?=
 =?us-ascii?Q?GjXFHIP42/7NFcwTby77+MyjmvTO0WFX2Kj4LPFtYuin0NhzO1EZ6JAXuJAl?=
 =?us-ascii?Q?C6jcBcT32mFUe5APswbye9eQBRkX2Hp2CpM+nCcjIA9aveh4IQ46vinF2+aA?=
 =?us-ascii?Q?/LkGxbt8j579dza1ctX++koC?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 501ebdbd-a027-43bb-e251-08d93b1145ed
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2021 15:19:22.6492 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lSfFyGVk9c/wl7gNgq0fzepgaLBStfhgLpKgNbhLWEaggPWYLrqRrSQC1Gdb9q+BCFW7CzzPqSLsJEzE70+bcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5431
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 149 ++++++++++++-------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h |   6 +-
 2 files changed, 73 insertions(+), 82 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 63975bda8e76..fd92ff27931a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -87,6 +87,46 @@ struct amdgpu_prt_cb {
 	struct dma_fence_cb cb;
 };
 
+/**
+ * amdgpu_vm_set_pasid - manage pasid and vm ptr mapping
+ *
+ * @adev: amdgpu_device pointer
+ * @vm: amdgpu_vm pointer
+ * @pasid: requested pasid
+ *
+ * Each pasid associats with a vm pointer. This function can be use to
+ * create a new pasid,vm association or to remove an existing one. To remove an
+ * existing pasid,vm association, pass 0 as @pasid.
+ */
+int amdgpu_vm_set_pasid(struct amdgpu_device *adev, struct amdgpu_vm *vm,
+			unsigned long pasid)
+{
+	int r;
+
+	if (vm->pasid == pasid)
+		return 0;
+
+	if (vm->pasid) {
+		r = xa_err(xa_erase_irq(&adev->vm_manager.pasids, vm->pasid));
+		if (r < 0)
+			return r;
+
+		vm->pasid = 0;
+	}
+
+	if (pasid) {
+		r = xa_err(xa_store_irq(&adev->vm_manager.pasids, pasid, vm,
+					GFP_KERNEL));
+		if (r < 0)
+			return r;
+
+		vm->pasid = pasid;
+	}
+
+
+	return 0;
+}
+
 /*
  * vm eviction_lock can be taken in MMU notifiers. Make sure no reclaim-FS
  * happens while holding this lock anywhere to prevent deadlocks when
@@ -2940,18 +2980,9 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm, u32 pasid)
 
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
 
@@ -3039,18 +3070,15 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm,
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
@@ -3061,7 +3089,7 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 				       to_amdgpu_bo_vm(vm->root.bo),
 				       false);
 		if (r)
-			goto free_idr;
+			goto free_pasid_entry;
 	}
 
 	/* Update VM state */
@@ -3078,7 +3106,7 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		r = amdgpu_bo_sync_wait(vm->root.bo,
 					AMDGPU_FENCE_OWNER_UNDEFINED, true);
 		if (r)
-			goto free_idr;
+			goto free_pasid_entry;
 
 		vm->update_funcs = &amdgpu_vm_cpu_funcs;
 	} else {
@@ -3088,36 +3116,13 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm,
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
@@ -3133,14 +3138,7 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm,
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
 
@@ -3164,15 +3162,7 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 
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
 
@@ -3254,8 +3244,7 @@ void amdgpu_vm_manager_init(struct amdgpu_device *adev)
 	adev->vm_manager.vm_update_mode = 0;
 #endif
 
-	idr_init(&adev->vm_manager.pasid_idr);
-	spin_lock_init(&adev->vm_manager.pasid_lock);
+	xa_init_flags(&adev->vm_manager.pasids, XA_FLAGS_LOCK_IRQ);
 }
 
 /**
@@ -3267,8 +3256,8 @@ void amdgpu_vm_manager_init(struct amdgpu_device *adev)
  */
 void amdgpu_vm_manager_fini(struct amdgpu_device *adev)
 {
-	WARN_ON(!idr_is_empty(&adev->vm_manager.pasid_idr));
-	idr_destroy(&adev->vm_manager.pasid_idr);
+	WARN_ON(!xa_empty(&adev->vm_manager.pasids));
+	xa_destroy(&adev->vm_manager.pasids);
 
 	amdgpu_vmid_mgr_fini(adev);
 }
@@ -3337,13 +3326,13 @@ void amdgpu_vm_get_task_info(struct amdgpu_device *adev, u32 pasid,
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
@@ -3385,15 +3374,15 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
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
@@ -3411,11 +3400,11 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
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
