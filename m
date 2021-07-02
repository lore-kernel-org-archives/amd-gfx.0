Return-Path: <SRS0=VIdG=L2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BFAFC11F68
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Jul 2021 09:25:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 494426120C
	for <amd-gfx@archiver.kernel.org>; Fri,  2 Jul 2021 09:25:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 494426120C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D63816E082;
	Fri,  2 Jul 2021 09:25:40 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2056.outbound.protection.outlook.com [40.107.100.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 626436E086
 for <amd-gfx@lists.freedesktop.org>; Fri,  2 Jul 2021 09:25:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fq8702JsHfh1gA6cuJ0VGOmamkafrYidfnQNA0FOqm5QPRw2Qx9cKU242oMBr9cQBq1b251w3HQvJStex5Y1+/8YnDQQH0Aa+8VEaFifLwlfwn+XScM2HsG1+PCr4FHA7kXLx0BTvR4i3kbrHUzqz3AA6/uftFXi2bfwBOWlZRoH0hxzuAutVRGpY9AbjUJ10rfJH/9kt/226Gs/AsCURaTJdK8/4gOncErxtcgH9wJqEFr7LzRzqlkJpl46kBxoXV2UHOD5po9Mcp+vzGAVdW/hD6N74/1F5bqLAbUWlZGOBDohdAigaK76RwW8NqM/9hh+IghdM8LPD9PMHBr5OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=79wsVsZUehAS1FYVRWaBGwZYeccbMnXTiMjAbobA9hY=;
 b=JwwfqfprRmzLm2qs92ymmfDseSCdjTw7AxqmUgd32QOcGCr9hdx7CVwriMX4XIHYTQMRsCZgZuXbfV0Lqw3uK0aa9J7tbr8pP91qdrU7LTSeNX/cXKCRugee8M1x34rBRcOHz1NwghJKPtAo+5jgRqe+MskKI7JJiPneElMBSWULPMztMxObr1TzIf3WiEPRlUkgQhD/6rKh7iEe9qjejm3oIobcFun7adoxOfMi+329etxYVeU40Wicj16idJ0TAL/f9tJ+60aNsUvn2UljVyzJFJktoDtCULhNurfjCY+h+x3/4ptjlCPSeJOcAM+fThqWHuG/pNaMLoPSL9gbPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=79wsVsZUehAS1FYVRWaBGwZYeccbMnXTiMjAbobA9hY=;
 b=a01NvM22ff7GHU+V5R3/m7Sz71GWbylu7bqeirny9diT7MqoCPevgpWX9Am70kgt8XeNpQAsAnkx3VuG4dDpqmoQPX8ctUyWGLYnd/vIsGs2BNAJp7xGClwZpV7oQEHPDZREd02V0SPbk/r7zF0z3z51lLk0Z3sk/xr25iAlv0I=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by DM4PR12MB5166.namprd12.prod.outlook.com (2603:10b6:5:395::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.22; Fri, 2 Jul
 2021 09:25:37 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::fde0:6f07:7dfc:8097]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::fde0:6f07:7dfc:8097%5]) with mapi id 15.20.4287.026; Fri, 2 Jul 2021
 09:25:37 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amdgpu: separate out vm pasid assignment
Date: Fri,  2 Jul 2021 11:25:18 +0200
Message-Id: <20210702092518.4251-2-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210702092518.4251-1-nirmoy.das@amd.com>
References: <20210702092518.4251-1-nirmoy.das@amd.com>
X-Originating-IP: [217.86.108.238]
X-ClientProxiedBy: PR0P264CA0079.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:18::19) To DM4PR12MB5136.namprd12.prod.outlook.com
 (2603:10b6:5:393::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brihaspati.fritz.box (217.86.108.238) by
 PR0P264CA0079.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100:18::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4287.22 via Frontend Transport; Fri, 2 Jul 2021 09:25:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dfd3a848-74e6-4633-4985-08d93d3b59cf
X-MS-TrafficTypeDiagnostic: DM4PR12MB5166:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB51669DE766ED01A44875D6848B1F9@DM4PR12MB5166.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y+boAhn7Exsp9kf+0JOqQ3f1NqX7dBOyNrRW4CyYuQ/ACkMkMGF9xlc0vj8vx2+kSXvOs/B8HxWO44XRdkbXhMUm+0bdHeR6btaEXiHAeMXriaxr29t2+q/VVYNlke48lFe5sK+nQsPrR4XF5C2Yxm55IgU/0Qs5xh8XV/2LaV31higkImoc6g+vbbjJSr4yPMQMU/arYlagdumu+MWoyF9iE9LWJYFf+EPJWViA941RD59BFszUVVuNuGwZFI+2h5dEnZZlvpy1EC9/MT6quG7IMrCPoC2tK9nicKpZ41jQw/OEPXF8AGkp5zBWFl6KfuFqmEgagAE9gBB9i4Ci+9e6v/QJU4Q2DEZbFUwursJL5V1DPbFVfJOSAkPhLdyhkDXKRqYMCGLYL4jy1cmlPu9uSyFWRngUGKIAxFZYmKTqU8XmNpdy0ZNW0GFZpNCB4IFlIztalx9GLcg7lPmN7yfBi1oAGbWnzX7BoS6GH9VDIPpsRIBKnMJ6IgxpBlhyKztvUrSEv62xyQaVLzf6HR6EXno6nEaE8OdaUOyfpnBkFdtTOWurcOKXgzXvBr/UwQY2tAXTYXXJPra7uVCwtbcuA41UvcHcf7Qd6GCcz6S6nT6SPmpTqD5BJfomfKrB7HEZ+22PGOikBVitQapYeUh3BGkAslE99HxHMBJcc8W8OqBHX1PZ786tceKxWlvnXkd4Km6ocg9i8wP/btStCw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(366004)(136003)(396003)(376002)(66946007)(66556008)(6512007)(66476007)(6506007)(5660300002)(2616005)(86362001)(6486002)(956004)(8936002)(83380400001)(1076003)(4326008)(8676002)(52116002)(6916009)(36756003)(6666004)(186003)(44832011)(16526019)(2906002)(316002)(38350700002)(38100700002)(26005)(478600001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?p4zt8s2k1ac4dxMIV6mX6OQQPzdW8n6JUIhdD62OjanNDwG/NYuZdOhe+jgW?=
 =?us-ascii?Q?NyvIDsJwUuQ6yWIujHi0fZj5JKa/smGHYU7y6QQuG0+C3lNR38KOk8jdXpBE?=
 =?us-ascii?Q?Z/N0mZMqL9zVQ+y+568vE7oukZUvcrgwWUk5JpBB2s6tP2CvF2TqZDU3ZYlH?=
 =?us-ascii?Q?549LKVgcANPVtg/s8L57Jt46eeCrNHIIvSKewu0zpHsfMnKJKnAdX/QtgW1z?=
 =?us-ascii?Q?Mea0xeSiBuIjf6FUMf34qJlN6UjEl2XfiiMYIO1eoQS2ZI2Dl23W2+8f5uUp?=
 =?us-ascii?Q?muTVcDsQtzIxKHD2S4bo2vgXdGEIHoT91OgcgyYl+8iHnhG/aQA7FaY1DjFC?=
 =?us-ascii?Q?U0gZ4mwQqBSvUemzmZOtyUN3ZRnDfksfGe86CjGuYmM2Oq2x/3S4filor6zi?=
 =?us-ascii?Q?stDO11fhj1o8ozd+JEzbWUzFXDnONIyfezL4fDGVgmWj9Ic4Str9RHIVOD+U?=
 =?us-ascii?Q?iMNtU7YBN2sHW31FaWf0S4PdaZDCFz5EAYIRksOCTedTq0WN4zll7rbckX99?=
 =?us-ascii?Q?r+NnfW01jd57maWDfyi5485uOAOOhE8hy+3dda+Tv+KnYA20JOFiDLSscrEN?=
 =?us-ascii?Q?vxSRo2LQ30brCh5S0fPekQzsKb7brJoKDsxB55avJoMdoN/mLQMhzqn2ivjK?=
 =?us-ascii?Q?7D8TDnMz/twuVatMw8JRKxoFMgT+JH/ycOStgiPDAhPSW5e6Ezi5xphbeioc?=
 =?us-ascii?Q?zxQgNEjFNPUpAOBrRYCUU06qJX4+J6HQ8n/n1BwzUzzfppCHsk4IV3sup3Ei?=
 =?us-ascii?Q?KwUfr4n3cDXyfNoEakQqVKZXkFfNy/nWP+0w1/DmhB8e1QbsF42i2YTsaTzN?=
 =?us-ascii?Q?QeIqzQZnp0QKTX1kpxT3GCS2R73r7+gWgxaZmcDC5Lou2LVgQTSusaWBMN9y?=
 =?us-ascii?Q?Qobj/uzXpzwzCl9QGEfsavbVdFBxpPqHpf1qtg/pkvl+QfcGy4w9w9xX67vf?=
 =?us-ascii?Q?7XEL+wy6MH2Sjy8aXfKid41p2bgSB06u+j8o4dJMyOkanFeFEZHMe4KU6xpu?=
 =?us-ascii?Q?JQQz1l6aTS7EqE0W03CUSPc1DIVbwVI4vCxTJN10/+HPu3Or7M6bFGjdeJ/l?=
 =?us-ascii?Q?cNJ6HSmcPylkvnwMIoe8xSUl7prdkODQzihagzY5++YupBe3Eho60fp2ZMtU?=
 =?us-ascii?Q?E6diCg4gxKNFbqfmjJItCy4gxWCjtwBKbWT5x4T5uoNo2iITniCvdq1poDA+?=
 =?us-ascii?Q?wv/LawuOCxM5Tmg4sqQ9D38oErChGNnC+sIB+Lo5OJLscH8wbCipMBxXJkUy?=
 =?us-ascii?Q?m3kzlgbmlYaBKPFlzuDdiSYrop8nL5allQNUJXmLsVmD010WD6W66FkC3jcv?=
 =?us-ascii?Q?8TZGn1g4jP89jo8+77nhW1JL?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfd3a848-74e6-4633-4985-08d93d3b59cf
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2021 09:25:37.0061 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LaWn2WWJgAb2FkdmHP5DMSMaVrru9/Qy6CEO1dktLwpJxwGouse9d3XCTepWkcJm9H6GbIolYo0l1Vraa1gvhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5166
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

Use new helper function amdgpu_vm_set_pasid() to
assign vm pasid value. This also ensures that we don't free
a pasid from vm code as pasids are allocated somewhere else.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 13 ++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       | 10 +++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        | 28 +++----------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h        |  4 +--
 4 files changed, 26 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index f96598279593..3a2ac7f66bbd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1287,11 +1287,22 @@ int amdgpu_amdkfd_gpuvm_acquire_process_vm(struct kgd_dev *kgd,
 	if (avm->process_info)
 		return -EINVAL;
 
+	/* Free the original amdgpu allocated pasid,
+	 * will be replaced with kfd allocated pasid.
+	 */
+	if (avm->pasid) {
+		amdgpu_pasid_free(avm->pasid);
+		amdgpu_vm_set_pasid(adev, avm, 0);
+	}
+
 	/* Convert VM into a compute VM */
-	ret = amdgpu_vm_make_compute(adev, avm, pasid);
+	ret = amdgpu_vm_make_compute(adev, avm);
 	if (ret)
 		return ret;
 
+	ret = amdgpu_vm_set_pasid(adev, avm, pasid);
+	if (ret)
+		return ret;
 	/* Initialize KFD part of the VM and process info */
 	ret = init_kfd_vm(avm, process_info, ef);
 	if (ret)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index cbb932f97355..66bf8b0c56bb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -1178,10 +1178,14 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
 		pasid = 0;
 	}
 
-	r = amdgpu_vm_init(adev, &fpriv->vm, pasid);
+	r = amdgpu_vm_init(adev, &fpriv->vm);
 	if (r)
 		goto error_pasid;
 
+	r = amdgpu_vm_set_pasid(adev, &fpriv->vm, pasid);
+	if (r)
+		goto error_vm;
+
 	fpriv->prt_va = amdgpu_vm_bo_add(adev, &fpriv->vm, NULL);
 	if (!fpriv->prt_va) {
 		r = -ENOMEM;
@@ -1209,8 +1213,10 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
 	amdgpu_vm_fini(adev, &fpriv->vm);
 
 error_pasid:
-	if (pasid)
+	if (pasid) {
 		amdgpu_pasid_free(pasid);
+		amdgpu_vm_set_pasid(adev, &fpriv->vm, 0);
+	}
 
 	kfree(fpriv);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 0f82df5bfa7a..565c8c59c995 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2899,14 +2899,13 @@ long amdgpu_vm_wait_idle(struct amdgpu_vm *vm, long timeout)
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
@@ -2980,10 +2979,6 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm, u32 pasid)
 
 	amdgpu_bo_unreserve(vm->root.bo);
 
-	r = amdgpu_vm_set_pasid(adev, vm, pasid);
-	if (r)
-		goto error_free_root;
-
 	INIT_KFIFO(vm->faults);
 
 	return 0;
@@ -3039,7 +3034,6 @@ static int amdgpu_vm_check_clean_reserved(struct amdgpu_device *adev,
  *
  * @adev: amdgpu_device pointer
  * @vm: requested vm
- * @pasid: pasid to use
  *
  * This only works on GFX VMs that don't have any BOs added and no
  * page tables allocated yet.
@@ -3047,7 +3041,6 @@ static int amdgpu_vm_check_clean_reserved(struct amdgpu_device *adev,
  * Changes the following VM parameters:
  * - use_cpu_for_update
  * - pte_supports_ats
- * - pasid (old PASID is released, because compute manages its own PASIDs)
  *
  * Reinitializes the page directory to reflect the changed ATS
  * setting.
@@ -3055,8 +3048,7 @@ static int amdgpu_vm_check_clean_reserved(struct amdgpu_device *adev,
  * Returns:
  * 0 for success, -errno for errors.
  */
-int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm,
-			   u32 pasid)
+int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 {
 	bool pte_support_ats = (adev->asic_type == CHIP_RAVEN);
 	int r;
@@ -3070,16 +3062,6 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	if (r)
 		goto unreserve_bo;
 
-	/* Free the original amdgpu allocated pasid,
-	 * will be replaced with kfd allocated pasid.
-	 */
-	if (vm->pasid)
-		amdgpu_pasid_free(vm->pasid);
-
-	r = amdgpu_vm_set_pasid(adev, vm, pasid);
-	if (r)
-		goto unreserve_bo;
-
 	/* Check if PD needs to be reinitialized and do it before
 	 * changing any other state, in case it fails.
 	 */
@@ -3089,7 +3071,7 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 				       to_amdgpu_bo_vm(vm->root.bo),
 				       false);
 		if (r)
-			goto free_pasid_entry;
+			goto unreserve_bo;
 	}
 
 	/* Update VM state */
@@ -3106,7 +3088,7 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		r = amdgpu_bo_sync_wait(vm->root.bo,
 					AMDGPU_FENCE_OWNER_UNDEFINED, true);
 		if (r)
-			goto free_pasid_entry;
+			goto unreserve_bo;
 
 		vm->update_funcs = &amdgpu_vm_cpu_funcs;
 	} else {
@@ -3121,8 +3103,6 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 
 	goto unreserve_bo;
 
-free_pasid_entry:
-	amdgpu_vm_set_pasid(adev, vm, 0);
 unreserve_bo:
 	amdgpu_bo_unreserve(vm->root.bo);
 	return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index bcbe362e7d5b..80cc9ab2c1d0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -378,8 +378,8 @@ int amdgpu_vm_set_pasid(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 			u32 pasid);
 
 long amdgpu_vm_wait_idle(struct amdgpu_vm *vm, long timeout);
-int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm, u32 pasid);
-int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm, u32 pasid);
+int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm);
+int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm);
 void amdgpu_vm_release_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm);
 void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm);
 void amdgpu_vm_get_pd_bo(struct amdgpu_vm *vm,
-- 
2.32.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
