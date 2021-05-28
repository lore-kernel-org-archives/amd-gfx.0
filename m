Return-Path: <SRS0=bbC/=KX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 400C6C4708D
	for <amd-gfx@archiver.kernel.org>; Fri, 28 May 2021 10:56:46 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBBED611BD
	for <amd-gfx@archiver.kernel.org>; Fri, 28 May 2021 10:56:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBBED611BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 937356F405;
	Fri, 28 May 2021 10:56:45 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2087.outbound.protection.outlook.com [40.107.223.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 51EE56E3EC
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 May 2021 10:56:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cs34zQAWy6o//sOJ8jyHj1SbCFcZwLDLQmlq7wKvaR7KlB1c/dRxPHzu/8fZAcArHh0pT0mfbZ4lIKYxqHCRaoPnsWTcSL6Q38uIhH7keffb+jXiNM3QOrqtmQ3VFcH1MnckTbC67L8JZwo6k63eNgZrxXmd5+mZrdNPejZxg8kBRYtf1A2uw6M8A04aPVrcZIMs9wG2+RdpMDUNMIIzKxQdjI171CE5HvYEiECSlObnK84RnPh1WzTTmmod9T2k0hA8+lzVkcWkobG5GBMwcSbf3j8zKsgb1IDUtzQ/a7gwhjzqeptx5aIbinNwyz4Gu4w6ncKVJD4f9PUdrlGiWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BZQtYpFw8vg28hRDWsu9LRUwCBCPFWRMaappt673WUc=;
 b=eKOlBzd2YzDX04ljre23zTIkOw7FKz0iHvJ0f87xwjcrBaPW2kjxpXzB87yT2XDX5apxCZOb2/ksK2DRgzsZD3pOhSTQVgqEj3ZVS2OGR2J+B4eq2i5pfUrK/vbn4kPcUu/sixaPfeK+gp4Fg4pIbsyAhwqWICrvG78v3Y9wAohAIC7S4ir19BQ41gTIDhWedcD+W97RKuFdIySWHuF+jAxlEknjo7UTHfCcuEEqc1sBwDs5Glf4FwPjIgAKH5Z0LrhFKtlpKT08rEFp9c7TAmUjdlUWETmIDwHekT5dfIrzzogvVVFRF24airauR4+vFRxvceoVcGwt+bHwlVDppA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BZQtYpFw8vg28hRDWsu9LRUwCBCPFWRMaappt673WUc=;
 b=sZUOoxgjS8yH/RDhLC5Ww/+SSJUFW5C4IXE+Pug9q8WZe4oYT1TH7CzitSIunjjGwh5+zwCHDNjRlKJFmDKQy6mSP7bp4aGdZLY211ZkvdTkYYAQ6Dl5SuMbN7jP8W3sEqrmRX/HdiWT4BhF4ikk0TNALBOLTaQU4jvv8jwn6w0=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by DM8PR12MB5416.namprd12.prod.outlook.com (2603:10b6:8:28::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.27; Fri, 28 May
 2021 10:56:43 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::4074:4943:244:a5fa]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::4074:4943:244:a5fa%6]) with mapi id 15.20.4173.022; Fri, 28 May 2021
 10:56:43 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v4 4/6] drm/amdgpu: switch to amdgpu_bo_vm for vm code
Date: Fri, 28 May 2021 12:56:21 +0200
Message-Id: <20210528105623.28148-4-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210528105623.28148-1-nirmoy.das@amd.com>
References: <20210528105623.28148-1-nirmoy.das@amd.com>
X-Originating-IP: [217.86.100.114]
X-ClientProxiedBy: PR3P189CA0081.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:102:b4::26) To DM4PR12MB5136.namprd12.prod.outlook.com
 (2603:10b6:5:393::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brihaspati.fritz.box (217.86.100.114) by
 PR3P189CA0081.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:b4::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4173.20 via Frontend Transport; Fri, 28 May 2021 10:56:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a2efef6d-0f93-4d72-52c0-08d921c74741
X-MS-TrafficTypeDiagnostic: DM8PR12MB5416:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM8PR12MB5416A400D1D8DA7CE32BB1438B229@DM8PR12MB5416.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IgMnnUn2bTOHHNrvHGD0iXCEAGOjiCHyH/MqHYv07rEQCs5NYNIU0f0ijrfIKwznyf01H0/1xQb9NyPjSOAHc8+elIPqaNlX/4AoEg9XGvtxVde+GqJivks/6waPij5z8tJsivDnS/gfOjwhavru8YdiAY4mvE6HeUibBp1Zd/jSepOHoaaXhhnHOkwt/Rmedhcoat9zR771fnT1herKj9Wtq1fBnCYXWjfhvtqsTf0Wuxp8zEsnNxW4OsLGn6I3lFcWaCLlSlnZpib6s9gioh73vqw9abkC4xpn8O1jarojGiVusgznmyLEzYhDJOdgI3gOZAWRopWpqWCmFq4Hilbsf38GqbOT32epu7CMPE18PzTfKghQ1p55rJd8lnNZqIcou1z6pffs1JN3DPFKhuqYYJWATaKBLpwWSMMNXC7eoeqCDZQGohBrehaa0XsVau0x646yDADhTkN03glkMTswPHILAxJQb39d1gnKHN4luv6B1CEKBM/nOmQqe9oxQWzxvFN/DkvCHq78h6od4rl9fSklsLsAyXXP6HtfwEJq5y6Ff51jGAQ2aHewSxpcGv5siPv+9wdNLhl87oG2qZMRES+kUYiVWB9zPmzciqGzgNJh9MgeaywqMM4HoMCTTHftfhTwmo+XSAliTYeF4N/2YNrZoV1XcFM0VvruW9s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39850400004)(366004)(346002)(136003)(376002)(6486002)(2906002)(6512007)(38350700002)(38100700002)(6916009)(36756003)(44832011)(16526019)(5660300002)(66476007)(186003)(66556008)(30864003)(66946007)(86362001)(956004)(2616005)(26005)(8936002)(83380400001)(6506007)(478600001)(52116002)(1076003)(8676002)(6666004)(316002)(4326008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?FzH/4JQTy3zDPKqMWybxbfX+nOCGNMSut18Hoss+vQo9TNrN4Kys9cQQddXR?=
 =?us-ascii?Q?SEpzhRqIIn8aAjjmEbNUbNlQ1MnfXLiFUI12X/vihaDbmcED5a5BfJqgpjbp?=
 =?us-ascii?Q?BZ9akzarGUjxPkTqlrxAJ/K74SU6/Q5aB7bxoSG62pLnt3/qBUR/lpbkf0en?=
 =?us-ascii?Q?jSOy2yidKF1bP0sQGxZsUjpBZwZQIK9PD9R7ptNW+LNWiXcpHMHGnQC2pVGP?=
 =?us-ascii?Q?gz7PP/YHg7ogcskg2oTSaMLpIVKgpQ8bNFcnXeN/5YLuunRpQEIUCKXtwTuD?=
 =?us-ascii?Q?VH1ZS2pz1YB74/NQ+FG6rrJfto8QU4kQzz/+pJpLuZ5HbAp+vhCB4V1KfGNE?=
 =?us-ascii?Q?jH/JI77jhb2kYYMN29pwQUrJFGXF6c3Hj0pxR9TveJ65/4lbA3iiYE3SAa95?=
 =?us-ascii?Q?Zv52wslFsTFhoebHh9R4Fcx3nssjuusBtGE3BkvQfPP5TG83DiYUCeqSGUa5?=
 =?us-ascii?Q?FKZYhuDvAFvDdDt74R6yfEyJnuARCvLLMX1zVUVfNyeKQGYfPOa3zAKQ4LI0?=
 =?us-ascii?Q?VeYHjXgUc7wYt7Gzb4iBcDyjGEBlTL75AWVoq5+gGmVmhziyqceGrIDwZPfA?=
 =?us-ascii?Q?6e9XLgAG8gHgZ5JDk2SFMI+3NGuezc9N8M0AY1YFKBCn3IVAJKKLGW8qMUPm?=
 =?us-ascii?Q?B5mzw2z6x4zSNoSjpEg6Z36jGtO6eA55J6d34bBxX4J7RCYPKVufjuzPFkpI?=
 =?us-ascii?Q?VNpiGSf4NuPENpfsbhOE3LVkkVYHKIGKU2sYu5ugMZDgBo1W9gMu3TSlmyrT?=
 =?us-ascii?Q?qsi6HcbUdoaZFjom9cfW5TWm4cHLycSjep4qhTq/TaeWgaZeaxb3fSCxbDwI?=
 =?us-ascii?Q?BVtwj4sbENFBpbI5YTv+BUlqOlg9seXJPVV1Lm2BMnlPJFJfr03+OSIljaDd?=
 =?us-ascii?Q?Lq7fdgOLydk3KrSXwcjJu4y/eUqbzMbHLizAOZyLJ6X+pnkxKFX5UDS2bmHj?=
 =?us-ascii?Q?Kel0/oMPgwmXLzoNUZPEUVkQuC1bE80+gsT3qEG4IL6IAlyNm2uwyGvjTHHQ?=
 =?us-ascii?Q?JKAIzX92CLZapsQ2F5iIKQ6CDBj9k/d78tgD9w9/D7jULgS16/KhXcfmcsUr?=
 =?us-ascii?Q?krxUq2gNqNHQfzjPPvD9Kk8DCbDGLbQ5wRo2hVrEEkdDo7M0RvpqLKo7/0fM?=
 =?us-ascii?Q?vdao+hEvLTMnhmEmiv+T8COKvPJCN34q3yMMcScW9JpVk60YIyTfEDZ2Ez3j?=
 =?us-ascii?Q?6C9T06zXFVRP+s232KN1sPO3417EJze7o5YU8J0R+e5PuayxDN/D2HD1eO1W?=
 =?us-ascii?Q?ZnNn93KXMHg4BnmeysaR9cOQdezdk6FNukJEMD5lh+wNBZ1UCwGBQyO8LgfK?=
 =?us-ascii?Q?y3ZIP2p3BpBgoD/P+WZgiPB2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2efef6d-0f93-4d72-52c0-08d921c74741
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2021 10:56:42.8850 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nQAwqHLipgvwagWX0Oiy7OnCQO0oiuDMjKfqSAtsfOS86RSvLvpRQvuBwdCrXf8wDbCE80cDYMRMJeGM7MeVdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5416
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
Cc: alexander.deucher@amd.com, Nirmoy Das <nirmoy.das@amd.com>,
 Christian.Koenig@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The subclass, amdgpu_bo_vm is intended for PT/PD BOs which are also
shadowed, so switch to amdgpu_bo_vm BO for PT/PD BOs.

v4: update amdgpu_vm_update_funcs to accept amdgpu_bo_vm.
v3: simplify code.
    check also if shadow bo exist instead of checking bo only type.
v2: squash three related patches.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c      | 123 ++++++++++++--------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h      |   5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c  |  14 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c |  19 +--
 4 files changed, 96 insertions(+), 65 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 6bc7566cc193..223c63342ecd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -652,15 +652,15 @@ void amdgpu_vm_move_to_lru_tail(struct amdgpu_device *adev,
 	spin_lock(&adev->mman.bdev.lru_lock);
 	list_for_each_entry(bo_base, &vm->idle, vm_status) {
 		struct amdgpu_bo *bo = bo_base->bo;
+		struct amdgpu_bo *shadow = amdgpu_bo_shadowed(bo);

 		if (!bo->parent)
 			continue;

 		ttm_bo_move_to_lru_tail(&bo->tbo, &bo->tbo.mem,
 					&vm->lru_bulk_move);
-		if (bo->shadow)
-			ttm_bo_move_to_lru_tail(&bo->shadow->tbo,
-						&bo->shadow->tbo.mem,
+		if (shadow)
+			ttm_bo_move_to_lru_tail(&shadow->tbo, &shadow->tbo.mem,
 						&vm->lru_bulk_move);
 	}
 	spin_unlock(&adev->mman.bdev.lru_lock);
@@ -692,12 +692,13 @@ int amdgpu_vm_validate_pt_bos(struct amdgpu_device *adev, struct amdgpu_vm *vm,

 	list_for_each_entry_safe(bo_base, tmp, &vm->evicted, vm_status) {
 		struct amdgpu_bo *bo = bo_base->bo;
+		struct amdgpu_bo *shadow = amdgpu_bo_shadowed(bo);

 		r = validate(param, bo);
 		if (r)
 			return r;
-		if (bo->shadow) {
-			r = validate(param, bo->shadow);
+		if (shadow) {
+			r = validate(param, shadow);
 			if (r)
 				return r;
 		}
@@ -705,7 +706,7 @@ int amdgpu_vm_validate_pt_bos(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		if (bo->tbo.type != ttm_bo_type_kernel) {
 			amdgpu_vm_bo_moved(bo_base);
 		} else {
-			vm->update_funcs->map_table(bo);
+			vm->update_funcs->map_table(to_amdgpu_bo_vm(bo));
 			amdgpu_vm_bo_relocated(bo_base);
 		}
 	}
@@ -737,7 +738,7 @@ bool amdgpu_vm_ready(struct amdgpu_vm *vm)
  *
  * @adev: amdgpu_device pointer
  * @vm: VM to clear BO from
- * @bo: BO to clear
+ * @vmbo: BO to clear
  * @immediate: use an immediate update
  *
  * Root PD needs to be reserved when calling this.
@@ -747,13 +748,14 @@ bool amdgpu_vm_ready(struct amdgpu_vm *vm)
  */
 static int amdgpu_vm_clear_bo(struct amdgpu_device *adev,
 			      struct amdgpu_vm *vm,
-			      struct amdgpu_bo *bo,
+			      struct amdgpu_bo_vm *vmbo,
 			      bool immediate)
 {
 	struct ttm_operation_ctx ctx = { true, false };
 	unsigned level = adev->vm_manager.root_level;
 	struct amdgpu_vm_update_params params;
-	struct amdgpu_bo *ancestor = bo;
+	struct amdgpu_bo *ancestor = &vmbo->bo;
+	struct amdgpu_bo *bo = &vmbo->bo;
 	unsigned entries, ats_entries;
 	uint64_t addr;
 	int r;
@@ -793,14 +795,15 @@ static int amdgpu_vm_clear_bo(struct amdgpu_device *adev,
 	if (r)
 		return r;

-	if (bo->shadow) {
-		r = ttm_bo_validate(&bo->shadow->tbo, &bo->shadow->placement,
-				    &ctx);
+	if (vmbo->shadow) {
+		struct amdgpu_bo *shadow = vmbo->shadow;
+
+		r = ttm_bo_validate(&shadow->tbo, &shadow->placement, &ctx);
 		if (r)
 			return r;
 	}

-	r = vm->update_funcs->map_table(bo);
+	r = vm->update_funcs->map_table(vmbo);
 	if (r)
 		return r;

@@ -824,7 +827,7 @@ static int amdgpu_vm_clear_bo(struct amdgpu_device *adev,
 			amdgpu_gmc_get_vm_pde(adev, level, &value, &flags);
 		}

-		r = vm->update_funcs->update(&params, bo, addr, 0, ats_entries,
+		r = vm->update_funcs->update(&params, vmbo, addr, 0, ats_entries,
 					     value, flags);
 		if (r)
 			return r;
@@ -847,7 +850,7 @@ static int amdgpu_vm_clear_bo(struct amdgpu_device *adev,
 			}
 		}

-		r = vm->update_funcs->update(&params, bo, addr, 0, entries,
+		r = vm->update_funcs->update(&params, vmbo, addr, 0, entries,
 					     value, flags);
 		if (r)
 			return r;
@@ -863,14 +866,16 @@ static int amdgpu_vm_clear_bo(struct amdgpu_device *adev,
  * @vm: requesting vm
  * @level: the page table level
  * @immediate: use a immediate update
- * @bo: pointer to the buffer object pointer
+ * @vmbo: pointer to the buffer object pointer
  */
 static int amdgpu_vm_pt_create(struct amdgpu_device *adev,
 			       struct amdgpu_vm *vm,
 			       int level, bool immediate,
-			       struct amdgpu_bo **bo)
+			       struct amdgpu_bo_vm **vmbo)
 {
 	struct amdgpu_bo_param bp;
+	struct amdgpu_bo *bo;
+	struct dma_resv *resv;
 	int r;

 	memset(&bp, 0, sizeof(bp));
@@ -881,7 +886,7 @@ static int amdgpu_vm_pt_create(struct amdgpu_device *adev,
 	bp.domain = amdgpu_bo_get_preferred_pin_domain(adev, bp.domain);
 	bp.flags = AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS |
 		AMDGPU_GEM_CREATE_CPU_GTT_USWC;
-	bp.bo_ptr_size = sizeof(struct amdgpu_bo);
+	bp.bo_ptr_size = sizeof(struct amdgpu_bo_vm);
 	if (vm->use_cpu_for_update)
 		bp.flags |= AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED;

@@ -890,26 +895,41 @@ static int amdgpu_vm_pt_create(struct amdgpu_device *adev,
 	if (vm->root.base.bo)
 		bp.resv = vm->root.base.bo->tbo.base.resv;

-	r = amdgpu_bo_create(adev, &bp, bo);
+	r = amdgpu_bo_create_vm(adev, &bp, vmbo);
 	if (r)
 		return r;

-	if (vm->is_compute_context && (adev->flags & AMD_IS_APU))
+	bo = &(*vmbo)->bo;
+	if (vm->is_compute_context && (adev->flags & AMD_IS_APU)) {
+		(*vmbo)->shadow = NULL;
 		return 0;
+	}

 	if (!bp.resv)
-		WARN_ON(dma_resv_lock((*bo)->tbo.base.resv,
+		WARN_ON(dma_resv_lock(bo->tbo.base.resv,
 				      NULL));
-	r = amdgpu_bo_create_shadow(adev, bp.size, *bo);
+	resv = bp.resv;
+	memset(&bp, 0, sizeof(bp));
+	bp.size = amdgpu_vm_bo_size(adev, level);
+	bp.domain = AMDGPU_GEM_DOMAIN_GTT;
+	bp.flags = AMDGPU_GEM_CREATE_CPU_GTT_USWC;
+	bp.type = ttm_bo_type_kernel;
+	bp.resv = bo->tbo.base.resv;
+	bp.bo_ptr_size = sizeof(struct amdgpu_bo);

-	if (!bp.resv)
-		dma_resv_unlock((*bo)->tbo.base.resv);
+	r = amdgpu_bo_create(adev, &bp, &(*vmbo)->shadow);
+
+	if (!resv)
+		dma_resv_unlock(bo->tbo.base.resv);

 	if (r) {
-		amdgpu_bo_unref(bo);
+		amdgpu_bo_unref(&bo);
 		return r;
 	}

+	(*vmbo)->shadow->parent = amdgpu_bo_ref(bo);
+	amdgpu_bo_add_to_shadow_list((*vmbo)->shadow);
+
 	return 0;
 }

@@ -933,7 +953,8 @@ static int amdgpu_vm_alloc_pts(struct amdgpu_device *adev,
 			       bool immediate)
 {
 	struct amdgpu_vm_pt *entry = cursor->entry;
-	struct amdgpu_bo *pt;
+	struct amdgpu_bo *pt_bo;
+	struct amdgpu_bo_vm *pt;
 	int r;

 	if (cursor->level < AMDGPU_VM_PTB && !entry->entries) {
@@ -957,8 +978,9 @@ static int amdgpu_vm_alloc_pts(struct amdgpu_device *adev,
 	/* Keep a reference to the root directory to avoid
 	 * freeing them up in the wrong order.
 	 */
-	pt->parent = amdgpu_bo_ref(cursor->parent->base.bo);
-	amdgpu_vm_bo_base_init(&entry->base, vm, pt);
+	pt_bo = &pt->bo;
+	pt_bo->parent = amdgpu_bo_ref(cursor->parent->base.bo);
+	amdgpu_vm_bo_base_init(&entry->base, vm, pt_bo);

 	r = amdgpu_vm_clear_bo(adev, vm, pt, immediate);
 	if (r)
@@ -968,7 +990,7 @@ static int amdgpu_vm_alloc_pts(struct amdgpu_device *adev,

 error_free_pt:
 	amdgpu_bo_unref(&pt->shadow);
-	amdgpu_bo_unref(&pt);
+	amdgpu_bo_unref(&pt_bo);
 	return r;
 }

@@ -979,10 +1001,13 @@ static int amdgpu_vm_alloc_pts(struct amdgpu_device *adev,
  */
 static void amdgpu_vm_free_table(struct amdgpu_vm_pt *entry)
 {
+	struct amdgpu_bo *shadow;
+
 	if (entry->base.bo) {
+		shadow = amdgpu_bo_shadowed(entry->base.bo);
 		entry->base.bo->vm_bo = NULL;
 		list_del(&entry->base.vm_status);
-		amdgpu_bo_unref(&entry->base.bo->shadow);
+		amdgpu_bo_unref(&shadow);
 		amdgpu_bo_unref(&entry->base.bo);
 	}
 	kvfree(entry->entries);
@@ -1284,7 +1309,8 @@ static int amdgpu_vm_update_pde(struct amdgpu_vm_update_params *params,
 	level += params->adev->vm_manager.root_level;
 	amdgpu_gmc_get_pde_for_bo(entry->base.bo, level, &pt, &flags);
 	pde = (entry - parent->entries) * 8;
-	return vm->update_funcs->update(params, bo, pde, pt, 1, 0, flags);
+	return vm->update_funcs->update(params, to_amdgpu_bo_vm(bo), pde, pt,
+					1, 0, flags);
 }

 /**
@@ -1364,9 +1390,9 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
  * Make sure to set the right flags for the PTEs at the desired level.
  */
 static void amdgpu_vm_update_flags(struct amdgpu_vm_update_params *params,
-				   struct amdgpu_bo *bo, unsigned level,
+				   struct amdgpu_bo_vm *pt, unsigned int level,
 				   uint64_t pe, uint64_t addr,
-				   unsigned count, uint32_t incr,
+				   unsigned int count, uint32_t incr,
 				   uint64_t flags)

 {
@@ -1382,7 +1408,7 @@ static void amdgpu_vm_update_flags(struct amdgpu_vm_update_params *params,
 		flags |= AMDGPU_PTE_EXECUTABLE;
 	}

-	params->vm->update_funcs->update(params, bo, pe, addr, count, incr,
+	params->vm->update_funcs->update(params, pt, pe, addr, count, incr,
 					 flags);
 }

@@ -1562,9 +1588,9 @@ static int amdgpu_vm_update_ptes(struct amdgpu_vm_update_params *params,
 						    nptes, dst, incr, upd_flags,
 						    vm->task_info.pid,
 						    vm->immediate.fence_context);
-			amdgpu_vm_update_flags(params, pt, cursor.level,
-					       pe_start, dst, nptes, incr,
-					       upd_flags);
+			amdgpu_vm_update_flags(params, to_amdgpu_bo_vm(pt),
+					       cursor.level, pe_start, dst,
+					       nptes, incr, upd_flags);

 			pe_start += nptes * 8;
 			dst += nptes * incr;
@@ -2674,7 +2700,7 @@ void amdgpu_vm_bo_invalidate(struct amdgpu_device *adev,
 	struct amdgpu_vm_bo_base *bo_base;

 	/* shadow bo doesn't have bo base, its validation needs its parent */
-	if (bo->parent && bo->parent->shadow == bo)
+	if (bo->parent && (amdgpu_bo_shadowed(bo->parent) == bo))
 		bo = bo->parent;

 	for (bo_base = bo->vm_bo; bo_base; bo_base = bo_base->next) {
@@ -2843,7 +2869,8 @@ long amdgpu_vm_wait_idle(struct amdgpu_vm *vm, long timeout)
  */
 int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm, u32 pasid)
 {
-	struct amdgpu_bo *root;
+	struct amdgpu_bo *root_bo;
+	struct amdgpu_bo_vm *root;
 	int r, i;

 	vm->va = RB_ROOT_CACHED;
@@ -2897,16 +2924,16 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm, u32 pasid)
 				false, &root);
 	if (r)
 		goto error_free_delayed;
-
-	r = amdgpu_bo_reserve(root, true);
+	root_bo = &root->bo;
+	r = amdgpu_bo_reserve(root_bo, true);
 	if (r)
 		goto error_free_root;

-	r = dma_resv_reserve_shared(root->tbo.base.resv, 1);
+	r = dma_resv_reserve_shared(root_bo->tbo.base.resv, 1);
 	if (r)
 		goto error_unreserve;

-	amdgpu_vm_bo_base_init(&vm->root.base, vm, root);
+	amdgpu_vm_bo_base_init(&vm->root.base, vm, root_bo);

 	r = amdgpu_vm_clear_bo(adev, vm, root, false);
 	if (r)
@@ -2935,8 +2962,8 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm, u32 pasid)
 	amdgpu_bo_unreserve(vm->root.base.bo);

 error_free_root:
-	amdgpu_bo_unref(&vm->root.base.bo->shadow);
-	amdgpu_bo_unref(&vm->root.base.bo);
+	amdgpu_bo_unref(&root->shadow);
+	amdgpu_bo_unref(&root_bo);
 	vm->root.base.bo = NULL;

 error_free_delayed:
@@ -3034,7 +3061,9 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	 */
 	if (pte_support_ats != vm->pte_support_ats) {
 		vm->pte_support_ats = pte_support_ats;
-		r = amdgpu_vm_clear_bo(adev, vm, vm->root.base.bo, false);
+		r = amdgpu_vm_clear_bo(adev, vm,
+				       to_amdgpu_bo_vm(vm->root.base.bo),
+				       false);
 		if (r)
 			goto free_idr;
 	}
@@ -3078,7 +3107,7 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	}

 	/* Free the shadow bo for compute VM */
-	amdgpu_bo_unref(&vm->root.base.bo->shadow);
+	amdgpu_bo_unref(&to_amdgpu_bo_vm(vm->root.base.bo)->shadow);

 	if (pasid)
 		vm->pasid = pasid;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 39d60e3c4e32..bee439dd673a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -39,6 +39,7 @@
 struct amdgpu_bo_va;
 struct amdgpu_job;
 struct amdgpu_bo_list_entry;
+struct amdgpu_bo_vm;

 /*
  * GPUVM handling
@@ -239,11 +240,11 @@ struct amdgpu_vm_update_params {
 };

 struct amdgpu_vm_update_funcs {
-	int (*map_table)(struct amdgpu_bo *bo);
+	int (*map_table)(struct amdgpu_bo_vm *bo);
 	int (*prepare)(struct amdgpu_vm_update_params *p, struct dma_resv *resv,
 		       enum amdgpu_sync_mode sync_mode);
 	int (*update)(struct amdgpu_vm_update_params *p,
-		      struct amdgpu_bo *bo, uint64_t pe, uint64_t addr,
+		      struct amdgpu_bo_vm *bo, uint64_t pe, uint64_t addr,
 		      unsigned count, uint32_t incr, uint64_t flags);
 	int (*commit)(struct amdgpu_vm_update_params *p,
 		      struct dma_fence **fence);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
index ac45d9c7a4e9..03a44be50dd7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
@@ -29,9 +29,9 @@
  *
  * @table: newly allocated or validated PD/PT
  */
-static int amdgpu_vm_cpu_map_table(struct amdgpu_bo *table)
+static int amdgpu_vm_cpu_map_table(struct amdgpu_bo_vm *table)
 {
-	return amdgpu_bo_kmap(table, NULL);
+	return amdgpu_bo_kmap(&table->bo, NULL);
 }

 /**
@@ -58,7 +58,7 @@ static int amdgpu_vm_cpu_prepare(struct amdgpu_vm_update_params *p,
  * amdgpu_vm_cpu_update - helper to update page tables via CPU
  *
  * @p: see amdgpu_vm_update_params definition
- * @bo: PD/PT to update
+ * @vmbo: PD/PT to update
  * @pe: byte offset of the PDE/PTE, relative to start of PDB/PTB
  * @addr: dst addr to write into pe
  * @count: number of page entries to update
@@ -68,7 +68,7 @@ static int amdgpu_vm_cpu_prepare(struct amdgpu_vm_update_params *p,
  * Write count number of PT/PD entries directly.
  */
 static int amdgpu_vm_cpu_update(struct amdgpu_vm_update_params *p,
-				struct amdgpu_bo *bo, uint64_t pe,
+				struct amdgpu_bo_vm *vmbo, uint64_t pe,
 				uint64_t addr, unsigned count, uint32_t incr,
 				uint64_t flags)
 {
@@ -76,13 +76,13 @@ static int amdgpu_vm_cpu_update(struct amdgpu_vm_update_params *p,
 	uint64_t value;
 	int r;

-	if (bo->tbo.moving) {
-		r = dma_fence_wait(bo->tbo.moving, true);
+	if (vmbo->bo.tbo.moving) {
+		r = dma_fence_wait(vmbo->bo.tbo.moving, true);
 		if (r)
 			return r;
 	}

-	pe += (unsigned long)amdgpu_bo_kptr(bo);
+	pe += (unsigned long)amdgpu_bo_kptr(&vmbo->bo);

 	trace_amdgpu_vm_set_ptes(pe, addr, count, incr, flags, p->immediate);

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
index a83a646759c5..422958152c2b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
@@ -33,11 +33,11 @@
  *
  * @table: newly allocated or validated PD/PT
  */
-static int amdgpu_vm_sdma_map_table(struct amdgpu_bo *table)
+static int amdgpu_vm_sdma_map_table(struct amdgpu_bo_vm *table)
 {
 	int r;

-	r = amdgpu_ttm_alloc_gart(&table->tbo);
+	r = amdgpu_ttm_alloc_gart(&table->bo.tbo);
 	if (r)
 		return r;

@@ -186,7 +186,7 @@ static void amdgpu_vm_sdma_set_ptes(struct amdgpu_vm_update_params *p,
  * amdgpu_vm_sdma_update - execute VM update
  *
  * @p: see amdgpu_vm_update_params definition
- * @bo: PD/PT to update
+ * @vmbo: PD/PT to update
  * @pe: byte offset of the PDE/PTE, relative to start of PDB/PTB
  * @addr: dst addr to write into pe
  * @count: number of page entries to update
@@ -197,10 +197,11 @@ static void amdgpu_vm_sdma_set_ptes(struct amdgpu_vm_update_params *p,
  * the IB.
  */
 static int amdgpu_vm_sdma_update(struct amdgpu_vm_update_params *p,
-				 struct amdgpu_bo *bo, uint64_t pe,
+				 struct amdgpu_bo_vm *vmbo, uint64_t pe,
 				 uint64_t addr, unsigned count, uint32_t incr,
 				 uint64_t flags)
 {
+	struct amdgpu_bo *bo = &vmbo->bo;
 	enum amdgpu_ib_pool_type pool = p->immediate ? AMDGPU_IB_POOL_IMMEDIATE
 		: AMDGPU_IB_POOL_DELAYED;
 	unsigned int i, ndw, nptes;
@@ -238,8 +239,8 @@ static int amdgpu_vm_sdma_update(struct amdgpu_vm_update_params *p,

 		if (!p->pages_addr) {
 			/* set page commands needed */
-			if (bo->shadow)
-				amdgpu_vm_sdma_set_ptes(p, bo->shadow, pe, addr,
+			if (vmbo->shadow)
+				amdgpu_vm_sdma_set_ptes(p, vmbo->shadow, pe, addr,
 							count, incr, flags);
 			amdgpu_vm_sdma_set_ptes(p, bo, pe, addr, count,
 						incr, flags);
@@ -248,7 +249,7 @@ static int amdgpu_vm_sdma_update(struct amdgpu_vm_update_params *p,

 		/* copy commands needed */
 		ndw -= p->adev->vm_manager.vm_pte_funcs->copy_pte_num_dw *
-			(bo->shadow ? 2 : 1);
+			(vmbo->shadow ? 2 : 1);

 		/* for padding */
 		ndw -= 7;
@@ -263,8 +264,8 @@ static int amdgpu_vm_sdma_update(struct amdgpu_vm_update_params *p,
 			pte[i] |= flags;
 		}

-		if (bo->shadow)
-			amdgpu_vm_sdma_copy_ptes(p, bo->shadow, pe, nptes);
+		if (vmbo->shadow)
+			amdgpu_vm_sdma_copy_ptes(p, vmbo->shadow, pe, nptes);
 		amdgpu_vm_sdma_copy_ptes(p, bo, pe, nptes);

 		pe += nptes * 8;
--
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
