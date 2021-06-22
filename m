Return-Path: <SRS0=0Dgm=LQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B016C2B9F4
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Jun 2021 06:57:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD2686112D
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Jun 2021 06:57:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD2686112D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7363989B9E;
	Tue, 22 Jun 2021 06:57:30 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2040.outbound.protection.outlook.com [40.107.92.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5E3989B9E
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Jun 2021 06:57:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ALiu5dqpUiVPuz4QHYLrnoI3CbZRIEu7VZAXAN/3ErDwvhEGa6Je2TnimuSBfHqIitsOqO5AHexu2ZwCbUcfDSURP6/tKTCLEgfqnoOZzKC2Tt+SSqBOym3KN2vqWMsrK1czctNcDDy/0tJm/RKVW1en35qe6v1UPxYV58URu30rhL3laPXtGIlvxYWQcA8fNLiJE7uX7uL8olv1V2aVW6gxBI+JtUCke7OAjZGwWGCbJulrY2f6pm9OujVmdZzDYa+ArJzDnieFq4Otb3tl014v3vEoHJbyjVAC5dm3jsTTtuETw6tWlgYylB0SF7t1i1mbhVExqMna6SsDy9udow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9pWyR8bhvYhmiUGDNsBhohq1r4lmeYTuGfnj2RxhbGw=;
 b=X0QO4wBDU8lvYgrN3lT0Dn63iQk3LeMFLcIWJaL/UGfZ4uSB5ctduHqz3jnR8BZbjHDa9XC1ZllDFJqqsX3jCDjcbYDnsHevY9aK2lSCuKhey4oGX97p30adUiLV6DrAaZZ9gvyimRJOa2qAq6rF56aaWlEqEoYEu2cBoTAa/CCoalFFLe546kJ6VAsfNB3t7tG3AQbnIx4ZG5PNEFeVilwqqqfUfMgMd8SCa4mtOYp4WKJcUIc0z4TJySxBY3opS2XjTUbITPSfaEDguAkEiaUlyrBTQbEAs6EsQFrtjU6bpBa8k8QR78izCO/sxZx/Gm3zopx3QvTWIvLEVWhwWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9pWyR8bhvYhmiUGDNsBhohq1r4lmeYTuGfnj2RxhbGw=;
 b=c276ZZCohcNXzDVMXKRn4hTda2lL8PDnStD4y4Xaf2anQ/bLCd2bEzYvBlPuRSy8lcQ0ufKAbdpXdu/SudkqeF7JRLLckyDzXtDpHZTeFv5ydeEyygjDVWHImF3zvKc0RDT+0G03qRSfkfoy8oDDccP+lldFWhVSdTCNOjKLoZ4=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by DM4PR12MB5085.namprd12.prod.outlook.com (2603:10b6:5:388::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18; Tue, 22 Jun
 2021 06:57:26 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::901b:72bb:a15:2a68]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::901b:72bb:a15:2a68%5]) with mapi id 15.20.4242.023; Tue, 22 Jun 2021
 06:57:26 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/1] drm/amdgpu: add helper function for vm pasid
Date: Tue, 22 Jun 2021 08:57:11 +0200
Message-Id: <20210622065711.4589-1-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.32.0
X-Originating-IP: [217.86.117.140]
X-ClientProxiedBy: PR3P192CA0021.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:102:56::26) To DM4PR12MB5136.namprd12.prod.outlook.com
 (2603:10b6:5:393::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brihaspati.fritz.box (217.86.117.140) by
 PR3P192CA0021.EURP192.PROD.OUTLOOK.COM (2603:10a6:102:56::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4242.18 via Frontend Transport; Tue, 22 Jun 2021 06:57:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a5e55b23-6b26-4eee-0309-08d9354afe8c
X-MS-TrafficTypeDiagnostic: DM4PR12MB5085:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB508531904E3EE00D4C12C4D48B099@DM4PR12MB5085.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aUN0o5IlsSvpLjSX7wXWBG8CZ7TH/XcTmJ5H9/Omz3KreoeVqCXHtEd4SBlJsFS9wkOsyRyRUIx2qxKUdCab39zBdOKWacRusjnxRh4O2NSV72InZwKrz11/WOZiRpyhJixjPsEcd8g/MjhNSfU4xUP37TPzt8nxHBdNsBSuFXPQ8hIKMC/gFqojeeGUjUIvU1hNkmL0y6KDXI+K2i4/Slo/nHGnO1OY5vZxhV9pG1M82g5u1DEmWNr8EOk/WWGjCJZHsH2yfmoe+om9/oQXkMI1KP7Rri7Whgd4UwyclWDLvjJogp2WumjZn+BiT2JliiFJnYz9wDtcw96gcdhEOmqNlGFqAX+aq+v5OD1G1lyWMGIIozHBtlsnqqWKqNxGjfLCiiZKKH55k/kvhdpJmQsnhHrlwjB/Ss2ChcEYSaJ0+rFBi/zeuODKY/p12AKLNn0uS8qOKrM737Du4U5m0/djeVpAif6qLLZgjv3cekKWaBw0HZ66QE1lZ7uxS9Dm3TEx3Gsmz0DZcky/R76LCVnmyo47Ucok0akOf2aYuZ+9/yi3Gxm0E+Vwq82/q/QrB5PLqt59gOXbl+gs3fVt3gQtkBs+pkip6fmAV2EoqssRImWzJShHXA47PNj9zB7fLB7x9x2pXxuv5u93TekWc3a89uDR27yK+8dX8pVV6Pw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(39860400002)(136003)(376002)(396003)(38350700002)(38100700002)(16526019)(186003)(316002)(2616005)(6916009)(4326008)(478600001)(44832011)(6506007)(26005)(52116002)(6486002)(956004)(2906002)(8936002)(8676002)(6512007)(5660300002)(6666004)(83380400001)(66556008)(66476007)(66946007)(1076003)(86362001)(36756003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4lMU+Atui+zK6UJ/XLuXzBddYo3iCr7j5r6rWQfwxzV5C5ZpyuAR3olLUHpo?=
 =?us-ascii?Q?xJx54S6djcGwzkbNDHQvRmbsQdRxJC4gZY9vFaUfJphyirqy1gT6ep2yY7tR?=
 =?us-ascii?Q?aMDdodiQxQoQXenrM5UOfGxnVJHzB4ui8smonhbxqdehOfWUb05deuOkMfQv?=
 =?us-ascii?Q?+9LDHtyvRWP7QS91YEUpv4/81Nt4pVGkzQWtAP6fkOQglHUifBrbq52vXKkS?=
 =?us-ascii?Q?njxFwRNoW+6VArgGRHSjWxTtXaDMHtGwkYloMG22s6QC/J9+xEeg1bNwm+So?=
 =?us-ascii?Q?9v8Faa7p2r8ZIpBJPe6cjDS8iEypHerhvKxa/nOAVvOYBuZMne2pTRX5wnFT?=
 =?us-ascii?Q?a2as36xJoFHzuf+WEA6fGjQ0B87jJwkPn9+FwuOlIapELKCfQIv4RFfYSwlo?=
 =?us-ascii?Q?KsGKKuGwAL32o02G+8xJclVwq0lJf8O89xSHVRgzu2AEySLdv/RMtBmVzeo2?=
 =?us-ascii?Q?EekvcSOSyC3yFnmcNF3pr0NnQAiB63HcnkIFGkFRE3OVtnQ+mbf/JUTvd4RN?=
 =?us-ascii?Q?MwD/9c8gch/kmU5Oj6E0jT2E2MGS0aQu5euXAC1L8AUQrb7em6utcgMM7Kv6?=
 =?us-ascii?Q?gH53A7UNIeLWBi62nP0vSaoy0RHqrXGpBFB98HYJhwH8SLKvNPTSq+ZrdjFK?=
 =?us-ascii?Q?j3BXpFB/24bkgHro1gt80foL301SiVE9cHAeMTSj4YCeWhh7TUDSfANhd4Y6?=
 =?us-ascii?Q?4z0vhVVaGLGcv7jSQgTQT91R+Q/q9i5UO5FuvP5rDq9PmCFsIZm5WgdEgr8w?=
 =?us-ascii?Q?jyt95NsSE4ToEEeqAx+9GPgCij/89CfF9XcAL2N97KtTBjyXrtUwdB+ao/67?=
 =?us-ascii?Q?lPsVMAQOlnkn+JXatJam9zxZjZ626MPJC20E+iqURwtz6VXk3Kgi0x8N3vAa?=
 =?us-ascii?Q?N+rBY+NTFpZkI7F6k+T5c3UN0K+QlyXFZ+cjP4nHeR63mGcdTg3dzFU+l0y9?=
 =?us-ascii?Q?zgW0D50Guq0WTYsZrxptyTQWA8bsGm7V/4ZAxGjXwcnLBPfVn+LgokEgnPnY?=
 =?us-ascii?Q?FhAKxo9h5SmnVOgR3CIR5i+GYXvElUVVLW+zwIdM4Ni/ejjlOkMWpTfWutk3?=
 =?us-ascii?Q?zBb2qislDZK42UeX/o4mx6+SsJQS2rA8TKj25hbME2j4E51qStVXutPcaRXD?=
 =?us-ascii?Q?xaG9L55OfkvS/eKLYFELoXEpxufDi0c4acrRW/cVoAvY9wU2SYFDzbd7LNCN?=
 =?us-ascii?Q?/1xMJvWE/w0q4Xw8iZYItL97EDgtYTRz3+rtmYnMLw28GOj4dxu6TukC+0gY?=
 =?us-ascii?Q?2UU5wA0FaudQidB9evUPc5KF58Q+dt2hspEn61ODsDvdVmb96u62d/A3GGSP?=
 =?us-ascii?Q?QSmMY+u+Wx8yIRwvdxTNWzyp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5e55b23-6b26-4eee-0309-08d9354afe8c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2021 06:57:26.5400 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v/fiFon4VS/f/HtGu8oiJySZ4Ifv2Kft6KhBuUofI4UkIrEUw28WWbDZLAcGVgGlIeH2tu14cTnidNzTAWlTEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5085
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

Cleanup code related to vm pasid by adding helper functions.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 105 ++++++++++++-------------
 1 file changed, 50 insertions(+), 55 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 63975bda8e76..6e476b173cbb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -87,6 +87,46 @@ struct amdgpu_prt_cb {
 	struct dma_fence_cb cb;
 };

+static int amdgpu_vm_pasid_alloc(struct amdgpu_device *adev,
+				 struct amdgpu_vm *vm,
+				 unsigned int pasid,
+				 unsigned int *vm_pasid)
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
+	if (vm_pasid)
+		*vm_pasid = pasid;
+
+	return 0;
+}
+
+static void amdgpu_vm_pasid_remove(struct amdgpu_device *adev,
+				   unsigned int pasid,
+				   unsigned int *vm_pasid)
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
+	if (vm_pasid)
+		*vm_pasid = 0;
+}
+
 /*
  * vm eviction_lock can be taken in MMU notifiers. Make sure no reclaim-FS
  * happens while holding this lock anywhere to prevent deadlocks when
@@ -2940,18 +2980,8 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm, u32 pasid)

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
+	if (amdgpu_vm_pasid_alloc(adev, vm, pasid, &vm->pasid))
+		goto error_free_root;

 	INIT_KFIFO(vm->faults);

@@ -3038,19 +3068,11 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	r = amdgpu_vm_check_clean_reserved(adev, vm);
 	if (r)
 		goto unreserve_bo;
+	r = amdgpu_vm_pasid_alloc(adev, vm, pasid, NULL);
+	if (r ==  -ENOSPC)
+		goto unreserve_bo;

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
+	r = 0;

 	/* Check if PD needs to be reinitialized and do it before
 	 * changing any other state, in case it fails.
@@ -3089,35 +3111,23 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	vm->is_compute_context = true;

 	if (vm->pasid) {
-		unsigned long flags;
-
-		spin_lock_irqsave(&adev->vm_manager.pasid_lock, flags);
-		idr_remove(&adev->vm_manager.pasid_idr, vm->pasid);
-		spin_unlock_irqrestore(&adev->vm_manager.pasid_lock, flags);
-
 		/* Free the original amdgpu allocated pasid
 		 * Will be replaced with kfd allocated pasid
 		 */
 		amdgpu_pasid_free(vm->pasid);
-		vm->pasid = 0;
+		amdgpu_vm_pasid_remove(adev, vm->pasid, &vm->pasid);
 	}

 	/* Free the shadow bo for compute VM */
 	amdgpu_bo_unref(&to_amdgpu_bo_vm(vm->root.bo)->shadow);
-
 	if (pasid)
 		vm->pasid = pasid;

 	goto unreserve_bo;

 free_idr:
-	if (pasid) {
-		unsigned long flags;
+	amdgpu_vm_pasid_remove(adev, pasid, NULL);

-		spin_lock_irqsave(&adev->vm_manager.pasid_lock, flags);
-		idr_remove(&adev->vm_manager.pasid_idr, pasid);
-		spin_unlock_irqrestore(&adev->vm_manager.pasid_lock, flags);
-	}
 unreserve_bo:
 	amdgpu_bo_unreserve(vm->root.bo);
 	return r;
@@ -3133,14 +3143,7 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm,
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
+	amdgpu_vm_pasid_remove(adev, vm->pasid, &vm->pasid);
 	vm->is_compute_context = false;
 }

@@ -3164,15 +3167,7 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)

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
+	amdgpu_vm_pasid_remove(adev, vm->pasid, &vm->pasid);
 	dma_fence_wait(vm->last_unlocked, false);
 	dma_fence_put(vm->last_unlocked);

--
2.32.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
