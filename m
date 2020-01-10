Return-Path: <SRS0=i8pd=27=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0A6BC282DD
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2020 00:43:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A42062075D
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jan 2020 00:43:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="c4NsQ7vo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A42062075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ADF4F6E98A;
	Fri, 10 Jan 2020 00:43:51 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690059.outbound.protection.outlook.com [40.107.69.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 22FE46E95A
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jan 2020 00:43:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dw6DBq/cxJVbJ8BAgFsqzUTS9IHIlD6ytHY/tv6rGYEYgN0F9j1LTPe5ES34dJp1PhBnSD0a/EkT+dLZpu/tCY42rIRIw+qUlP7lfmwPie8luoTBHGxtw/GvfFswGlj/rzJ9Cejt6pFWzlkgEq1IJhWu8kb+GIp75TaR8eJwYOodIslcTA1cjQHjUankPBAFQUD7LUr/bdUUrXv/PlMUAb7DxdgntqDRL89pdzKSUHL7kyzCg3D06CupX2USaQhOGq9mFm3ILRihQbYOUpQpXpizkrjTcCnRMcXwwrgzxofN7h8FgPsgQWdJvx/xf+2AkcsXLIbu1GuH4nyPnWJcJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d+Gbzscwey6YKBY1Cubb84nc3wHuAMWXK6D1MDFqj7Y=;
 b=BhKym0UdhZvnmaJk9uCks88JQ158JzOcX491qmZUO94KzmhYNEZjwqHMMOIa91vtBaHX4BK4jxx2ZE/ZvlyeU6oxJRA/cUPDVoIycjehKBTjB78Vh9Ojocj2+0l34CM872eNWc7lPHD6STxVKrbj2yuhEhd+Y14KUx2mSI+G7zmmkU7RC/xKjCdGK0wPbdMmGDvKgRsRQ6G8bYnjmQAvi+PkBrUuxZNXOp20qcWZnSHTA9V0GPIuOaq4Ts51ojxLgSHfz6hmJV5aS74gT2vLRWBEXCQdjtIGj34Xw1It/xAkqwpIWyLpzDQqm1847ucj4HceOOE05+z37at3H/2YJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d+Gbzscwey6YKBY1Cubb84nc3wHuAMWXK6D1MDFqj7Y=;
 b=c4NsQ7voWTtZGNVZ7ZmNpIOscmkhV+xiQ8qU6T72nvijv+RAQnmbaEigIjRVu8Sdu/2fsFTfERD8klmq+E6lbhgTj69wsmsXXf7Osa6bmA5TM0lnegtKZjcubt6dUg6Qkxet26IszCJWlwd15XwO498R0F0QA1hJXCe5FVZxU9A=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Alex.Sierra@amd.com; 
Received: from SN6PR12MB2621.namprd12.prod.outlook.com (52.135.105.15) by
 SN6PR12MB2672.namprd12.prod.outlook.com (52.135.103.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Fri, 10 Jan 2020 00:43:49 +0000
Received: from SN6PR12MB2621.namprd12.prod.outlook.com
 ([fe80::8923:17de:add5:1490]) by SN6PR12MB2621.namprd12.prod.outlook.com
 ([fe80::8923:17de:add5:1490%6]) with mapi id 15.20.2623.008; Fri, 10 Jan 2020
 00:43:49 +0000
From: Alex Sierra <alex.sierra@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 4/8] drm/amdgpu: flush TLB functions removal from kfd2kgd
 interface
Date: Thu,  9 Jan 2020 18:43:31 -0600
Message-Id: <20200110004335.113095-4-alex.sierra@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200110004335.113095-1-alex.sierra@amd.com>
References: <20200110004335.113095-1-alex.sierra@amd.com>
X-ClientProxiedBy: SN6PR2101CA0017.namprd21.prod.outlook.com
 (2603:10b6:805:106::27) To SN6PR12MB2621.namprd12.prod.outlook.com
 (2603:10b6:805:73::15)
MIME-Version: 1.0
Received: from alex-MS-7B09.amd.com (165.204.77.1) by
 SN6PR2101CA0017.namprd21.prod.outlook.com (2603:10b6:805:106::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.4 via Frontend
 Transport; Fri, 10 Jan 2020 00:43:48 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0b226e3f-03af-429b-3f2f-08d795662837
X-MS-TrafficTypeDiagnostic: SN6PR12MB2672:|SN6PR12MB2672:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB2672283030E682D54AFA8493FD380@SN6PR12MB2672.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1107;
X-Forefront-PRVS: 02788FF38E
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(346002)(39860400002)(396003)(376002)(366004)(199004)(189003)(30864003)(8936002)(26005)(5660300002)(7696005)(316002)(86362001)(1076003)(186003)(2616005)(16526019)(956004)(44832011)(2906002)(36756003)(52116002)(66556008)(478600001)(66476007)(6916009)(6666004)(6486002)(66946007)(4326008)(81156014)(81166006)(8676002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:SN6PR12MB2672;
 H:SN6PR12MB2621.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XhSWldJhkIBfwrhP0or67f7nz4OewBhBXbHnyyeubW8MXUqVKDiyMTNGQ09UI26ZASoCQlOJO1Do9SQGyxN3HszODAjF4rsEDzGEARcBAk2pABvGMhRBRPrBwTgBZZsJWgIPA0beHC+CJGyHTPzz9lyfPC/rl8dkxT4tsKzr59x0Po2tG5GcDGVMBIywACNkDs1N0Icis6wKcPdUnSt4ZAHOyolTNZjN0c1ClRhEt4qG0ouiAw6IVxNGzcvM3KGAizhmfZmHtwJYVkr/rJkyF38rZnaslZ00XJvrbbKIiPXkUf1xKbXVXg1+5jC+qDSv4ICR7pisevhIm0wg2rnsEoykXPXPYEZv05jSx9SE8qg9EdPubAIL5+X2ss5S9bG25/y5LFSlEBxE25+Bfz5RzreUaKzOzBLAGSne6OHWqNd8dtOKoypikyFx/K+JTEvS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b226e3f-03af-429b-3f2f-08d795662837
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2020 00:43:49.2275 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XpViU5BBxiI/RoMIM2VitJ0D6t5oD9p5VzIL7V11EYjQyJuaH0yHoezjA7/FtKDI1qEElJ9KN2lD01lQic46ZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2672
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
Cc: Alex Sierra <alex.sierra@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
kfd2kgd interface will be deprecated. This removal only covers TLB
invalidation for now. They have been replaced in amdgpu_amdkfd API.

[How]
TLB invalidate functions removed from the different amdkfd_gfx_v*
versions.

Change-Id: Ic2c7d4a0d19fe1e884dee1ff10a520d31252afee
Signed-off-by: Alex Sierra <alex.sierra@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 .../drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c   |  2 -
 .../drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c    | 67 -------------
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c | 41 --------
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c | 41 --------
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c | 96 -------------------
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h |  2 -
 .../gpu/drm/amd/include/kgd_kfd_interface.h   |  2 -
 7 files changed, 251 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
index 2b26925623eb..1c7e9bb7feb3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_arcturus.c
@@ -317,7 +317,5 @@ const struct kfd2kgd_calls arcturus_kfd2kgd = {
 			kgd_gfx_v9_get_atc_vmid_pasid_mapping_info,
 	.get_tile_config = kgd_gfx_v9_get_tile_config,
 	.set_vm_context_page_table_base = kgd_set_vm_context_page_table_base,
-	.invalidate_tlbs = kgd_gfx_v9_invalidate_tlbs,
-	.invalidate_tlbs_vmid = kgd_gfx_v9_invalidate_tlbs_vmid,
 	.get_hive_id = amdgpu_amdkfd_get_hive_id,
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
index 61cd707158e4..6132b4874498 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
@@ -686,71 +686,6 @@ static bool get_atc_vmid_pasid_mapping_info(struct kgd_dev *kgd,
 	return !!(value & ATC_VMID0_PASID_MAPPING__VALID_MASK);
 }
 
-static int invalidate_tlbs_with_kiq(struct amdgpu_device *adev, uint16_t pasid)
-{
-	signed long r;
-	uint32_t seq;
-	struct amdgpu_ring *ring = &adev->gfx.kiq.ring;
-
-	spin_lock(&adev->gfx.kiq.ring_lock);
-	amdgpu_ring_alloc(ring, 12); /* fence + invalidate_tlbs package*/
-	amdgpu_ring_write(ring, PACKET3(PACKET3_INVALIDATE_TLBS, 0));
-	amdgpu_ring_write(ring,
-			PACKET3_INVALIDATE_TLBS_DST_SEL(1) |
-			PACKET3_INVALIDATE_TLBS_PASID(pasid));
-	amdgpu_fence_emit_polling(ring, &seq);
-	amdgpu_ring_commit(ring);
-	spin_unlock(&adev->gfx.kiq.ring_lock);
-
-	r = amdgpu_fence_wait_polling(ring, seq, adev->usec_timeout);
-	if (r < 1) {
-		DRM_ERROR("wait for kiq fence error: %ld.\n", r);
-		return -ETIME;
-	}
-
-	return 0;
-}
-
-static int invalidate_tlbs(struct kgd_dev *kgd, uint16_t pasid)
-{
-	struct amdgpu_device *adev = (struct amdgpu_device *) kgd;
-	int vmid;
-	uint16_t queried_pasid;
-	bool ret;
-	struct amdgpu_ring *ring = &adev->gfx.kiq.ring;
-
-	if (amdgpu_emu_mode == 0 && ring->sched.ready)
-		return invalidate_tlbs_with_kiq(adev, pasid);
-
-	for (vmid = 0; vmid < 16; vmid++) {
-		if (!amdgpu_amdkfd_is_kfd_vmid(adev, vmid))
-			continue;
-
-		ret = get_atc_vmid_pasid_mapping_info(kgd, vmid,
-				&queried_pasid);
-		if (ret	&& queried_pasid == pasid) {
-			amdgpu_gmc_flush_gpu_tlb(adev, vmid,
-					AMDGPU_GFXHUB_0, 0);
-			break;
-		}
-	}
-
-	return 0;
-}
-
-static int invalidate_tlbs_vmid(struct kgd_dev *kgd, uint16_t vmid)
-{
-	struct amdgpu_device *adev = (struct amdgpu_device *) kgd;
-
-	if (!amdgpu_amdkfd_is_kfd_vmid(adev, vmid)) {
-		pr_err("non kfd vmid %d\n", vmid);
-		return 0;
-	}
-
-	amdgpu_gmc_flush_gpu_tlb(adev, vmid, AMDGPU_GFXHUB_0, 0);
-	return 0;
-}
-
 static int kgd_address_watch_disable(struct kgd_dev *kgd)
 {
 	return 0;
@@ -832,7 +767,5 @@ const struct kfd2kgd_calls gfx_v10_kfd2kgd = {
 			get_atc_vmid_pasid_mapping_info,
 	.get_tile_config = amdgpu_amdkfd_get_tile_config,
 	.set_vm_context_page_table_base = set_vm_context_page_table_base,
-	.invalidate_tlbs = invalidate_tlbs,
-	.invalidate_tlbs_vmid = invalidate_tlbs_vmid,
 	.get_hive_id = amdgpu_amdkfd_get_hive_id,
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c
index 6e6f0a99ec06..8f052e98a3c6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v7.c
@@ -696,45 +696,6 @@ static void set_vm_context_page_table_base(struct kgd_dev *kgd, uint32_t vmid,
 		lower_32_bits(page_table_base));
 }
 
-static int invalidate_tlbs(struct kgd_dev *kgd, uint16_t pasid)
-{
-	struct amdgpu_device *adev = (struct amdgpu_device *) kgd;
-	int vmid;
-	unsigned int tmp;
-
-	if (adev->in_gpu_reset)
-		return -EIO;
-
-	for (vmid = 0; vmid < 16; vmid++) {
-		if (!amdgpu_amdkfd_is_kfd_vmid(adev, vmid))
-			continue;
-
-		tmp = RREG32(mmATC_VMID0_PASID_MAPPING + vmid);
-		if ((tmp & ATC_VMID0_PASID_MAPPING__VALID_MASK) &&
-			(tmp & ATC_VMID0_PASID_MAPPING__PASID_MASK) == pasid) {
-			WREG32(mmVM_INVALIDATE_REQUEST, 1 << vmid);
-			RREG32(mmVM_INVALIDATE_RESPONSE);
-			break;
-		}
-	}
-
-	return 0;
-}
-
-static int invalidate_tlbs_vmid(struct kgd_dev *kgd, uint16_t vmid)
-{
-	struct amdgpu_device *adev = (struct amdgpu_device *) kgd;
-
-	if (!amdgpu_amdkfd_is_kfd_vmid(adev, vmid)) {
-		pr_err("non kfd vmid\n");
-		return 0;
-	}
-
-	WREG32(mmVM_INVALIDATE_REQUEST, 1 << vmid);
-	RREG32(mmVM_INVALIDATE_RESPONSE);
-	return 0;
-}
-
  /**
   * read_vmid_from_vmfault_reg - read vmid from register
   *
@@ -771,7 +732,5 @@ const struct kfd2kgd_calls gfx_v7_kfd2kgd = {
 	.set_scratch_backing_va = set_scratch_backing_va,
 	.get_tile_config = get_tile_config,
 	.set_vm_context_page_table_base = set_vm_context_page_table_base,
-	.invalidate_tlbs = invalidate_tlbs,
-	.invalidate_tlbs_vmid = invalidate_tlbs_vmid,
 	.read_vmid_from_vmfault_reg = read_vmid_from_vmfault_reg,
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c
index bfbddedb2380..19a10db93d68 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v8.c
@@ -657,45 +657,6 @@ static void set_vm_context_page_table_base(struct kgd_dev *kgd, uint32_t vmid,
 			lower_32_bits(page_table_base));
 }
 
-static int invalidate_tlbs(struct kgd_dev *kgd, uint16_t pasid)
-{
-	struct amdgpu_device *adev = (struct amdgpu_device *) kgd;
-	int vmid;
-	unsigned int tmp;
-
-	if (adev->in_gpu_reset)
-		return -EIO;
-
-	for (vmid = 0; vmid < 16; vmid++) {
-		if (!amdgpu_amdkfd_is_kfd_vmid(adev, vmid))
-			continue;
-
-		tmp = RREG32(mmATC_VMID0_PASID_MAPPING + vmid);
-		if ((tmp & ATC_VMID0_PASID_MAPPING__VALID_MASK) &&
-			(tmp & ATC_VMID0_PASID_MAPPING__PASID_MASK) == pasid) {
-			WREG32(mmVM_INVALIDATE_REQUEST, 1 << vmid);
-			RREG32(mmVM_INVALIDATE_RESPONSE);
-			break;
-		}
-	}
-
-	return 0;
-}
-
-static int invalidate_tlbs_vmid(struct kgd_dev *kgd, uint16_t vmid)
-{
-	struct amdgpu_device *adev = (struct amdgpu_device *) kgd;
-
-	if (!amdgpu_amdkfd_is_kfd_vmid(adev, vmid)) {
-		pr_err("non kfd vmid %d\n", vmid);
-		return -EINVAL;
-	}
-
-	WREG32(mmVM_INVALIDATE_REQUEST, 1 << vmid);
-	RREG32(mmVM_INVALIDATE_RESPONSE);
-	return 0;
-}
-
 const struct kfd2kgd_calls gfx_v8_kfd2kgd = {
 	.program_sh_mem_settings = kgd_program_sh_mem_settings,
 	.set_pasid_vmid_mapping = kgd_set_pasid_vmid_mapping,
@@ -717,6 +678,4 @@ const struct kfd2kgd_calls gfx_v8_kfd2kgd = {
 	.set_scratch_backing_va = set_scratch_backing_va,
 	.get_tile_config = get_tile_config,
 	.set_vm_context_page_table_base = set_vm_context_page_table_base,
-	.invalidate_tlbs = invalidate_tlbs,
-	.invalidate_tlbs_vmid = invalidate_tlbs_vmid,
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
index e7861f0ef415..932ae85d97e2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.c
@@ -617,100 +617,6 @@ bool kgd_gfx_v9_get_atc_vmid_pasid_mapping_info(struct kgd_dev *kgd,
 	return !!(value & ATC_VMID0_PASID_MAPPING__VALID_MASK);
 }
 
-static int invalidate_tlbs_with_kiq(struct amdgpu_device *adev, uint16_t pasid,
-			uint32_t flush_type)
-{
-	signed long r;
-	uint32_t seq;
-	struct amdgpu_ring *ring = &adev->gfx.kiq.ring;
-
-	spin_lock(&adev->gfx.kiq.ring_lock);
-	amdgpu_ring_alloc(ring, 12); /* fence + invalidate_tlbs package*/
-	amdgpu_ring_write(ring, PACKET3(PACKET3_INVALIDATE_TLBS, 0));
-	amdgpu_ring_write(ring,
-			PACKET3_INVALIDATE_TLBS_DST_SEL(1) |
-			PACKET3_INVALIDATE_TLBS_ALL_HUB(1) |
-			PACKET3_INVALIDATE_TLBS_PASID(pasid) |
-			PACKET3_INVALIDATE_TLBS_FLUSH_TYPE(flush_type));
-	amdgpu_fence_emit_polling(ring, &seq);
-	amdgpu_ring_commit(ring);
-	spin_unlock(&adev->gfx.kiq.ring_lock);
-
-	r = amdgpu_fence_wait_polling(ring, seq, adev->usec_timeout);
-	if (r < 1) {
-		DRM_ERROR("wait for kiq fence error: %ld.\n", r);
-		return -ETIME;
-	}
-
-	return 0;
-}
-
-int kgd_gfx_v9_invalidate_tlbs(struct kgd_dev *kgd, uint16_t pasid)
-{
-	struct amdgpu_device *adev = (struct amdgpu_device *) kgd;
-	int vmid, i;
-	uint16_t queried_pasid;
-	bool ret;
-	struct amdgpu_ring *ring = &adev->gfx.kiq.ring;
-	uint32_t flush_type = 0;
-
-	if (adev->in_gpu_reset)
-		return -EIO;
-	if (adev->gmc.xgmi.num_physical_nodes &&
-		adev->asic_type == CHIP_VEGA20)
-		flush_type = 2;
-
-	if (ring->sched.ready)
-		return invalidate_tlbs_with_kiq(adev, pasid, flush_type);
-
-	for (vmid = 0; vmid < 16; vmid++) {
-		if (!amdgpu_amdkfd_is_kfd_vmid(adev, vmid))
-			continue;
-
-		ret = kgd_gfx_v9_get_atc_vmid_pasid_mapping_info(kgd, vmid,
-				&queried_pasid);
-		if (ret && queried_pasid == pasid) {
-			for (i = 0; i < adev->num_vmhubs; i++)
-				amdgpu_gmc_flush_gpu_tlb(adev, vmid,
-							i, flush_type);
-			break;
-		}
-	}
-
-	return 0;
-}
-
-int kgd_gfx_v9_invalidate_tlbs_vmid(struct kgd_dev *kgd, uint16_t vmid)
-{
-	struct amdgpu_device *adev = (struct amdgpu_device *) kgd;
-	int i;
-
-	if (!amdgpu_amdkfd_is_kfd_vmid(adev, vmid)) {
-		pr_err("non kfd vmid %d\n", vmid);
-		return 0;
-	}
-
-	/* Use legacy mode tlb invalidation.
-	 *
-	 * Currently on Raven the code below is broken for anything but
-	 * legacy mode due to a MMHUB power gating problem. A workaround
-	 * is for MMHUB to wait until the condition PER_VMID_INVALIDATE_REQ
-	 * == PER_VMID_INVALIDATE_ACK instead of simply waiting for the ack
-	 * bit.
-	 *
-	 * TODO 1: agree on the right set of invalidation registers for
-	 * KFD use. Use the last one for now. Invalidate both GC and
-	 * MMHUB.
-	 *
-	 * TODO 2: support range-based invalidation, requires kfg2kgd
-	 * interface change
-	 */
-	for (i = 0; i < adev->num_vmhubs; i++)
-		amdgpu_gmc_flush_gpu_tlb(adev, vmid, i, 0);
-
-	return 0;
-}
-
 int kgd_gfx_v9_address_watch_disable(struct kgd_dev *kgd)
 {
 	return 0;
@@ -793,7 +699,5 @@ const struct kfd2kgd_calls gfx_v9_kfd2kgd = {
 			kgd_gfx_v9_get_atc_vmid_pasid_mapping_info,
 	.get_tile_config = kgd_gfx_v9_get_tile_config,
 	.set_vm_context_page_table_base = kgd_gfx_v9_set_vm_context_page_table_base,
-	.invalidate_tlbs = kgd_gfx_v9_invalidate_tlbs,
-	.invalidate_tlbs_vmid = kgd_gfx_v9_invalidate_tlbs_vmid,
 	.get_hive_id = amdgpu_amdkfd_get_hive_id,
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
index 02b1426d17d1..dfafa28b7559 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v9.h
@@ -57,7 +57,5 @@ uint32_t kgd_gfx_v9_address_watch_get_offset(struct kgd_dev *kgd,
 
 bool kgd_gfx_v9_get_atc_vmid_pasid_mapping_info(struct kgd_dev *kgd,
 					uint8_t vmid, uint16_t *p_pasid);
-int kgd_gfx_v9_invalidate_tlbs(struct kgd_dev *kgd, uint16_t pasid);
-int kgd_gfx_v9_invalidate_tlbs_vmid(struct kgd_dev *kgd, uint16_t vmid);
 int kgd_gfx_v9_get_tile_config(struct kgd_dev *kgd,
 		struct tile_config *config);
diff --git a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
index 2cd217e60125..a01ef836ad58 100644
--- a/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
+++ b/drivers/gpu/drm/amd/include/kgd_kfd_interface.h
@@ -307,8 +307,6 @@ struct kfd2kgd_calls {
 
 	void (*set_vm_context_page_table_base)(struct kgd_dev *kgd,
 			uint32_t vmid, uint64_t page_table_base);
-	int (*invalidate_tlbs)(struct kgd_dev *kgd, uint16_t pasid);
-	int (*invalidate_tlbs_vmid)(struct kgd_dev *kgd, uint16_t vmid);
 	uint32_t (*read_vmid_from_vmfault_reg)(struct kgd_dev *kgd);
 	uint64_t (*get_hive_id)(struct kgd_dev *kgd);
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
