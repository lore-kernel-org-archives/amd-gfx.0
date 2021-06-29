Return-Path: <SRS0=w1A1=LX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DEE4C11F67
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Jun 2021 15:19:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E360B61DA6
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Jun 2021 15:19:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E360B61DA6
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A3DB76E8B4;
	Tue, 29 Jun 2021 15:19:30 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2054.outbound.protection.outlook.com [40.107.102.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43BEC6E8B4
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Jun 2021 15:19:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iAPyGDroAscwXSHu5jKlNZZmf2I2ZLdZQcgZ3Z9AEO7/QT6THVcZqBUcb8QtHbSuNyrcLEIIxWTcLhEoUUANwDXBuV/xq996g99JuMAEPL3tG7nGFANqtx9RD1qVuKQgWY67wbaIJhztGfU4tNKjarErbxmXc8yZzaDE3oBc3G/XnDau4999O2XmA7B2iNyXeyGFC1myAFJcxG539lC8afO7qH1rHkehO2FqCsC8/k+5Y7q34gG0+1BCIJPe8qpks+s9re7c/0/7wTJHhv+2tfq6342PuXQEcDt7nYfPi3MZkMoOzAQjjw7xN8lq/Id1tf7Ialc6a0aHzGKw65P6OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wy6mH426aWLPEAauiVW8i0Tzbe2KW6g3JfNpz1Vvbg4=;
 b=BeL+GAEIKqvZ+wfxpdC93nsoGkbmh0IxCI6uLbK+Jk+pn0GCyfJvI0eT18jOfoMzaQ/50LRX5+nMHbipNjFhotjh1ahYkpEkErBkR9aGZqvEdRNx6JGpsNEG8H/qIK2xtBFQKDnBAVgQCAdHRC/oFckJtuGC4YcMpUK34jutzMuGwZRlXx5slcp1yW7s0Rvz4vHvFksTF4bXhrcwpNp22qOZGLmn1m2w6Ew7cwYK3CeqzcVQ4S1pNxkmSDK2I2Oukeynt9alOO5Rxk57sq706pjDGCP5gbDcvPyphIUXD/zaDklElvD2qtLiLewP7/3PI6sgMM8wFljio+DhIIgVzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wy6mH426aWLPEAauiVW8i0Tzbe2KW6g3JfNpz1Vvbg4=;
 b=AOBlG/YXB+UdD+oDJsTOm27CaR9+g2NFntbftZrA5VzWRLCnCUuhdYUMsPORA6XIOqCi+Ticgp9YKCdlCqwYLAH5aPudl7rcR/+EBE/PKONYVd0pz4fiIWv3A8KZZ82+GdJVTchdO5rpUYLCD7Q8SXEkp44eNqHKcRRIiUN37tE=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by DM4PR12MB5229.namprd12.prod.outlook.com (2603:10b6:5:398::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.23; Tue, 29 Jun
 2021 15:19:24 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::901b:72bb:a15:2a68]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::901b:72bb:a15:2a68%4]) with mapi id 15.20.4264.026; Tue, 29 Jun 2021
 15:19:24 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amdgpu: separate out vm pasid assignment
Date: Tue, 29 Jun 2021 17:19:07 +0200
Message-Id: <20210629151907.4251-2-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210629151907.4251-1-nirmoy.das@amd.com>
References: <20210629151907.4251-1-nirmoy.das@amd.com>
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
 Transport; Tue, 29 Jun 2021 15:19:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8a56d89b-d865-4b6d-bc88-08d93b1146bb
X-MS-TrafficTypeDiagnostic: DM4PR12MB5229:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM4PR12MB52298221D96490FB2D2D451E8B029@DM4PR12MB5229.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yp+UqZc3wy8ZAByZ7zmG8YP//bNr22KWd/HTe/efcu8HxmiK5wwC72RWZ3i+o3jZyZckN9fhiWt0+WzKGwosPmF5PELwl3Bu7H/G8PFo5VdMhSR1fMGX6WqfnnhgWLWs1ORMVEGnK8J4wIU0ihmGsikxeZWjG/jyaP1jkMR9zkDGUO9jdXnDMW60413kVYSfzk8buV9m7m8703Ffx8quMCCO7KirRNT8MSeBhUKxGrTjwe0V3esKsTQABchyRC5pL6D+z5qraft0jcv3vv5hsjmVcHt6p3I7cHswIuI2GGDHqpQK3YqXLdBk4ODytdsUeo99JizQx2u6rx6ZXPOa1pyeScyrE+h1uTXLyafN+btXiZgNi2qPJbQFWrJFe84WGtOVJKYYhU336eQdogV7Mpi4heLyPZkGQLnCAgqoNXAtnp+MS5idYesGR2JKksfQFYAUE9iBrexKyY5FlqLXTeS18E+WQ+R05BNdS54VX46Y38tKbHX10PmhrQ16M6VGmrQsiGWFhiK3Z8h3egHLyjmDOUoplxMgYMidOZaOjuY4KQSJhJBjaranrGUGFy39GLFUwty4WjY0drHV2nDqoy47P7UHE5c7ty5UFRULGK7b5BeRDQ25x+/kEWAT4c6xh8sWSQ9585wj5x6W1i/u5qNWUOBuDu/LuScp74JLgQt4HKviLqr7w62/wnfHRa8s6T+/GrbvHvTfsCVyQdXzSA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(346002)(39860400002)(376002)(366004)(396003)(956004)(186003)(66476007)(66556008)(2616005)(66946007)(4326008)(86362001)(16526019)(52116002)(6506007)(6512007)(1076003)(44832011)(26005)(83380400001)(6486002)(36756003)(6666004)(8676002)(2906002)(8936002)(38350700002)(478600001)(5660300002)(316002)(38100700002)(6916009);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rpHug8wjvgRX4BCLq3reutzLR1lCjgiLag0j8Y7GQbUFcOsCGu33dSM3jevy?=
 =?us-ascii?Q?jRARPDktfYq3A1NjSqwWWyRIXXcMe0Qha463QW7J9dJKN5ZidQ5jo9rxjTS7?=
 =?us-ascii?Q?Si2QpPnel7SBHjlAhE+4PRvW3W8sTSw7DX5pp+zg3w5z2XPW8aC7c/eCOGnk?=
 =?us-ascii?Q?p81BzEWt5xpnyyljrDaesOhZ97E6b13pTWfNJXFaZ7DFlYWu+Jtnrg5QHYpZ?=
 =?us-ascii?Q?3k81gUZ+hVTneSONd5BVmV1/yg1TpBL8DgACKG9rOcV2pjSzD8xf3omBEHyk?=
 =?us-ascii?Q?e3TCDe3GdiCCrYNoirN7J6TIat8W2fecJew8bWnFmXZp4Y5ZBxaHy2VJhBw7?=
 =?us-ascii?Q?NuihP+cEPOsXgNOkPOwKvVWAG5A+6HBY/sbRwnrNG+in/kWu2d+pFfYKCaF/?=
 =?us-ascii?Q?amAyxN1QKAOLqamOQjLf0MiOx2B/at9l3Pp8xJ+7yNNPd5HxNFLWUGkedEx3?=
 =?us-ascii?Q?Bt8yBt8D0aPpYqKgwC91ARZQ9gtLNtTb7NsLqF9p+QecKQhz/XpLWyKxdIjC?=
 =?us-ascii?Q?8UCngPI+EvZpd+kjKFx1qU/X56j2U7kUFC/Mj0ZZEYkUs1GqJ2w6wVgd0YyI?=
 =?us-ascii?Q?9DNmZW9vZtAyqn1OACkpcXKcG3sPIedeXRgd4frSDo8/d9WuC3LqQe1q6DYn?=
 =?us-ascii?Q?t07/KsJ9KxKlfDiFzBUwXpTj235ZE1NX97kcngwnjCa1VPP49uZaLr2PW5Nu?=
 =?us-ascii?Q?ye2KYo84hmnl0tIcH/J7/HEkvHpTL1CACPE6oN4wPmxn2VcHbdLJp3q63dqq?=
 =?us-ascii?Q?8g85iu3QkPxgljw/uhnvKJF3fEt1VC0gJjACtD4J22hVUenFPaaZdePEKcCN?=
 =?us-ascii?Q?AQUXXlazwNfiuzGc5SxdtlXr2dxs/xkUz4J7GgLsXv+KfRAsTUW+oJGg7CFl?=
 =?us-ascii?Q?FrGMm9nggjYqPfA7BXlig91CJfnJhhsoVih1UlmU7c/02zbPEgNsh0uYLsIi?=
 =?us-ascii?Q?JJFcB+D5n2kONCbMcEwC1uzRGr3C44Yox+caUlxu/N2wcsrxWuZeb1rXwQu+?=
 =?us-ascii?Q?WtBWG1yOLzfo/1xcoHI+YzVMKayGegs71D+OYdXpAzA0C1t0Hjmfz5WfKDt7?=
 =?us-ascii?Q?aCETnAVcaEDv0yupIJZ93NCc+5Cm9s9EQ00NjdUHRzKpoH2qmCJbhXNxAI6/?=
 =?us-ascii?Q?J5vvS9rNDUjzDivyxeEYkogk2iqOS6PkqBVlj7gs+5Nmp+PnghC5H033ifGf?=
 =?us-ascii?Q?x1zUAgIbvifxey6FP3f9aWK3pPw/WajOmxpQoUvd2jwdzuiuGc23Jg7nCuvl?=
 =?us-ascii?Q?KmNDck8x4oEW/zcrdvLjOe/3Axg6E1SlLNICJ+WxyFyYCKfYGINBDTJvDReF?=
 =?us-ascii?Q?zUPquVnfJRALm9NEFA7MRTaf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a56d89b-d865-4b6d-bc88-08d93b1146bb
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2021 15:19:23.9216 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EN/0TxOZpO1HN1P+87/dOhAZnBUXWqUby5fJaOIjB8z0JkMxp7ADBQQ6j0GT7p8Tvwq4GlYIYvlIQ0HKBE8WMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5229
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
index fd92ff27931a..1dccede6387e 100644
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
index 8e8bc132e590..a0bceccaa6b5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -378,8 +378,8 @@ int amdgpu_vm_set_pasid(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 			unsigned long pasid);
 
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
