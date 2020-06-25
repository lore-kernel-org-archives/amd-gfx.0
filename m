Return-Path: <SRS0=ju5j=AG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58B22C433DF
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jun 2020 03:19:05 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E808B20789
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jun 2020 03:19:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="uXFBqzKq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E808B20789
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C9D86E32D;
	Thu, 25 Jun 2020 03:19:04 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2053.outbound.protection.outlook.com [40.107.237.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3908C6E32D
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jun 2020 03:19:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EvX7m1gkEMNyv/EfONsb6G2rgybsc71HgHUdYKCKxCfhgZJwfHBK0OPrZ/JZJomXjlMfmsYKLBYnxsGmCArSrP53Nc6/lDjeBAEaSR6w7VusKXT7CjmLLVT7QGLH9gOcjlvfQtAsGgzCXQfK/vcTh3IiaN4zZ8FDJv3iT+1UsKYMMERFkPI6f1djUgzNzWL1M72f9Su1SzvLyyHxPtTXw8nYERF+RpSPyZveWB2Qm82rWZEu8Fuv3YJILD+FYhFlSrx893H3iG8B38jaIH90q2G3Foj6EX+x6hMx2yOPfMNgjiIGtX7MUs5t5ij8W3mosAuaYhO29Hf4ML6npLek0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fsp2ud7kQmL+SLi47lBwDCuP3D9f/+D3S6wVtkE49dY=;
 b=P/udXPQjDQ1wQdg+cq9+epzwUcDc4rSjq5D0aLACgaM2K7M2H/hH0dRKWbP471mlEa1aGcHaR7TftWqIldXQfmYiAyMfc9rdoKz1Ie+Ryazjf+l7niVyFbAlCHCIqreOGiwf817CoN1pC/V6pL8h1iZ3E3N9NWIKcTD3UC2yWLqCjwybjZ6G8odcvMe3IldMzyzxId7/Z5S83GFYuAIGAVUCYwHlcHjzyDbZdNLXaNmM635/OZdhYNj6THCwiC1j1hZxeZWCI7EuV1zjT+a6nWUmo9hKHQ4QgjM5dvpA1gdPSZob5KGei98DAEw43EeH3phNI4jwudKuhEo2ZY4rcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fsp2ud7kQmL+SLi47lBwDCuP3D9f/+D3S6wVtkE49dY=;
 b=uXFBqzKq/mIilqnU+AYV/eAjqlRSF7wn4wmL9+KIYyIDS/IB7PG8nJqJ3ozGeEZr7la1Yo0CZMpFEicS3A0VGKK//ZTUqpTmUqwEHonyawO8NUeAvSWKizM6nGTtm8YVjzDICKca8knFh9frmN4JokZAqNhkfmbUVe27iEdL5S8=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2414.namprd12.prod.outlook.com (2603:10b6:802:2e::31)
 by SA0PR12MB4430.namprd12.prod.outlook.com (2603:10b6:806:70::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.23; Thu, 25 Jun
 2020 03:19:01 +0000
Received: from SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::18d:97b:661f:9314]) by SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::18d:97b:661f:9314%7]) with mapi id 15.20.3109.021; Thu, 25 Jun 2020
 03:19:01 +0000
From: Felix Kuehling <Felix.Kuehling@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amdgpu: Clean up KFD VMID assignment
Date: Wed, 24 Jun 2020 23:18:33 -0400
Message-Id: <20200625031834.16122-1-Felix.Kuehling@amd.com>
X-Mailer: git-send-email 2.26.0
X-ClientProxiedBy: YTOPR0101CA0066.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::43) To SN1PR12MB2414.namprd12.prod.outlook.com
 (2603:10b6:802:2e::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Harpoon.amd.com (165.204.55.251) by
 YTOPR0101CA0066.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:14::43) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21 via Frontend
 Transport; Thu, 25 Jun 2020 03:19:00 +0000
X-Mailer: git-send-email 2.26.0
X-Originating-IP: [165.204.55.251]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7da5ce44-5b43-4ce7-6d2b-08d818b6815e
X-MS-TrafficTypeDiagnostic: SA0PR12MB4430:
X-Microsoft-Antispam-PRVS: <SA0PR12MB4430D4ACABF03BF6F857F32592920@SA0PR12MB4430.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:275;
X-Forefront-PRVS: 0445A82F82
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GdbKmIvYann92dvmhVPYOIrucwMnstQ+IKqsZNeRBxkFnH4PylnWo3yWTQfWMx1nuSsawKxymO15xLkPlzhD/4aNLi3jwDpsJBJsIf7MFXQFwmU7aW+6Yt1eL5FwIMG16SoGitnk88PmdkXfJsYdfCQVSOZvxZe1ypXX523VfDzAgSxyQ8lQYyIQ0qCp4+rcNRwjGURmOfUWKClWSB1ejQ+F1MroMPPSjK4YJgtcRBNqF6PGTAhc5EJa9McYGK8WHhLnAulXJuO9L3Emh6/SFvjlG+7BBphXQzLFE50wXHG3bGGG0QzrBtq9hX1PLH2IlYrhZEWUp+qSR60YhbwksE+Xcau1IuFXGf40ael4MJ5Z8TPXeI6sooYkrkyl8r8c
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2414.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(346002)(136003)(366004)(396003)(39860400002)(8936002)(36756003)(5660300002)(2616005)(26005)(6666004)(66476007)(478600001)(956004)(2906002)(16526019)(83380400001)(66946007)(66556008)(6486002)(186003)(1076003)(316002)(30864003)(52116002)(7696005)(6916009)(8676002)(86362001)(21314003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 0uAYb8F4YgF5CCGo2E0LJC+OV9GcXyx9l5H+JmaP2wSqhZSQCh6R3lxtZ4dYGgSQxXpr/5WFJDr31Id0W0oo/zkadkuPHWi4Mubm7uUs5SFWKuW8DJTRdbUA77vn/Z2VrecO2CMIoi6jfM6L6PsyeddGKgrzQAzT/APa2eV/4QlFPUIDgswSmqm/mrLxDeYjOx2G6KH17e6BjdC/SeKFkGTHvWsAqDEPjij6yemd/1FBIxAtfm+5AIDc26h+JoB1434jaFNWXyJ1CGBuEatwGRIri7PvDWAxAYyp45BtOc2qTN5y1HdMEN+LCcOqHDHwhvtypo1aBZPYB2UdIZ6Ry3z5l67xvaKtIAK71WLXFHoBLbqJX+ZcPkr9d1hJaDROJwtzLws9Oiytx1y0fXQQoJrJCNJ/ngkzY2JUcsUlyhu9KJ+hfFJPcUd0IscPOZkKlEPyjWgGl38rW6IZXVm7ODivffPSKSBs3GaRN/BFKTS3A/z8Sjsovcie2bVmgIa/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7da5ce44-5b43-4ce7-6d2b-08d818b6815e
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2414.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2020 03:19:01.0956 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ptb8121Q4Y1ZIrs/HO+M01RsnCWyf1l9e6QVTSUWr94jJGyVX7VW2DjzAfneqcJXYowFfVTQHnYA47KNUWaubQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4430
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The KFD VMID assignment was hard-coded in a few places. Consolidate that in
a single variable adev->vm_manager.first_kfd_vmid. The value is still
assigned in gmc-ip-version-specific code.

Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 12 +++++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c    |  3 +++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h     |  1 +
 drivers/gpu/drm/amd/amdgpu/cikd.h          |  2 --
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c     |  6 ++----
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c      |  6 ++----
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c      |  6 ++----
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c      |  6 ++----
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c     |  5 +----
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c      |  2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c      |  2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c      |  2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c      |  7 +------
 drivers/gpu/drm/amd/amdgpu/si_enums.h      |  1 -
 drivers/gpu/drm/amd/amdgpu/sid.h           |  2 --
 drivers/gpu/drm/amd/amdgpu/vid.h           |  2 --
 16 files changed, 22 insertions(+), 43 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index ad59ac4423b8..1b865fed74ca 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -31,8 +31,6 @@
 #include "amdgpu_xgmi.h"
 #include <uapi/linux/kfd_ioctl.h>
 
-static const unsigned int compute_vmid_bitmap = 0xFF00;
-
 /* Total memory size in system memory and all GPU VRAM. Used to
  * estimate worst case amount of memory to reserve for page tables
  */
@@ -113,7 +111,9 @@ void amdgpu_amdkfd_device_init(struct amdgpu_device *adev)
 
 	if (adev->kfd.dev) {
 		struct kgd2kfd_shared_resources gpu_resources = {
-			.compute_vmid_bitmap = compute_vmid_bitmap,
+			.compute_vmid_bitmap =
+				((1 << AMDGPU_NUM_VMID) - 1) -
+				((1 << adev->vm_manager.first_kfd_vmid) - 1),
 			.num_pipe_per_mec = adev->gfx.mec.num_pipe_per_mec,
 			.num_queue_per_pipe = adev->gfx.mec.num_queue_per_pipe,
 			.gpuvm_size = min(adev->vm_manager.max_pfn
@@ -637,10 +637,8 @@ void amdgpu_amdkfd_set_compute_idle(struct kgd_dev *kgd, bool idle)
 
 bool amdgpu_amdkfd_is_kfd_vmid(struct amdgpu_device *adev, u32 vmid)
 {
-	if (adev->kfd.dev) {
-		if ((1 << vmid) & compute_vmid_bitmap)
-			return true;
-	}
+	if (adev->kfd.dev)
+		return vmid >= adev->vm_manager.first_kfd_vmid;
 
 	return false;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
index 267fa45ddb66..7521f4ab55de 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
@@ -574,6 +574,9 @@ void amdgpu_vmid_mgr_init(struct amdgpu_device *adev)
 		INIT_LIST_HEAD(&id_mgr->ids_lru);
 		atomic_set(&id_mgr->reserved_vmid_num, 0);
 
+		/* manage only VMIDs not used by KFD */
+		id_mgr->num_ids = adev->vm_manager.first_kfd_vmid;
+
 		/* skip over VMID 0, since it is the system VM */
 		for (j = 1; j < id_mgr->num_ids; ++j) {
 			amdgpu_vmid_reset(adev, i, j);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index c8e68d7890bf..770025a5e500 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -324,6 +324,7 @@ struct amdgpu_vm {
 struct amdgpu_vm_manager {
 	/* Handling of VMIDs */
 	struct amdgpu_vmid_mgr			id_mgr[AMDGPU_MAX_VMHUBS];
+	unsigned int				first_kfd_vmid;
 
 	/* Handling of VM fences */
 	u64					fence_context;
diff --git a/drivers/gpu/drm/amd/amdgpu/cikd.h b/drivers/gpu/drm/amd/amdgpu/cikd.h
index 5f3f6ebfb387..55982c0064b5 100644
--- a/drivers/gpu/drm/amd/amdgpu/cikd.h
+++ b/drivers/gpu/drm/amd/amdgpu/cikd.h
@@ -54,8 +54,6 @@
 #define BONAIRE_GB_ADDR_CONFIG_GOLDEN        0x12010001
 #define HAWAII_GB_ADDR_CONFIG_GOLDEN         0x12011003
 
-#define AMDGPU_NUM_OF_VMIDS	8
-
 #define		PIPEID(x)					((x) << 0)
 #define		MEID(x)						((x) << 2)
 #define		VMID(x)						((x) << 4)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 323285eb1457..8366c506a8b5 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -4512,8 +4512,6 @@ static u32 gfx_v10_0_init_pa_sc_tile_steering_override(struct amdgpu_device *ade
 }
 
 #define DEFAULT_SH_MEM_BASES	(0x6000)
-#define FIRST_COMPUTE_VMID	(8)
-#define LAST_COMPUTE_VMID	(16)
 
 static void gfx_v10_0_init_compute_vmid(struct amdgpu_device *adev)
 {
@@ -4529,7 +4527,7 @@ static void gfx_v10_0_init_compute_vmid(struct amdgpu_device *adev)
 	sh_mem_bases = DEFAULT_SH_MEM_BASES | (DEFAULT_SH_MEM_BASES << 16);
 
 	mutex_lock(&adev->srbm_mutex);
-	for (i = FIRST_COMPUTE_VMID; i < LAST_COMPUTE_VMID; i++) {
+	for (i = adev->vm_manager.first_kfd_vmid; i < AMDGPU_NUM_VMID; i++) {
 		nv_grbm_select(adev, 0, 0, 0, i);
 		/* CP and shaders */
 		WREG32_SOC15(GC, 0, mmSH_MEM_CONFIG, DEFAULT_SH_MEM_CONFIG);
@@ -4540,7 +4538,7 @@ static void gfx_v10_0_init_compute_vmid(struct amdgpu_device *adev)
 
 	/* Initialize all compute VMIDs to have no GDS, GWS, or OA
 	   acccess. These should be enabled by FW for target VMIDs. */
-	for (i = FIRST_COMPUTE_VMID; i < LAST_COMPUTE_VMID; i++) {
+	for (i = adev->vm_manager.first_kfd_vmid; i < AMDGPU_NUM_VMID; i++) {
 		WREG32_SOC15_OFFSET(GC, 0, mmGDS_VMID0_BASE, 2 * i, 0);
 		WREG32_SOC15_OFFSET(GC, 0, mmGDS_VMID0_SIZE, 2 * i, 0);
 		WREG32_SOC15_OFFSET(GC, 0, mmGDS_GWS_VMID0, i, 0);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
index 4aec76049a60..04eaf3a8fddb 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
@@ -1850,8 +1850,6 @@ static void gfx_v7_0_setup_rb(struct amdgpu_device *adev)
  *
  */
 #define DEFAULT_SH_MEM_BASES	(0x6000)
-#define FIRST_COMPUTE_VMID	(8)
-#define LAST_COMPUTE_VMID	(16)
 static void gfx_v7_0_init_compute_vmid(struct amdgpu_device *adev)
 {
 	int i;
@@ -1869,7 +1867,7 @@ static void gfx_v7_0_init_compute_vmid(struct amdgpu_device *adev)
 			SH_MEM_CONFIG__ALIGNMENT_MODE__SHIFT;
 	sh_mem_config |= MTYPE_NONCACHED << SH_MEM_CONFIG__DEFAULT_MTYPE__SHIFT;
 	mutex_lock(&adev->srbm_mutex);
-	for (i = FIRST_COMPUTE_VMID; i < LAST_COMPUTE_VMID; i++) {
+	for (i = adev->vm_manager.first_kfd_vmid; i < AMDGPU_NUM_VMID; i++) {
 		cik_srbm_select(adev, 0, 0, 0, i);
 		/* CP and shaders */
 		WREG32(mmSH_MEM_CONFIG, sh_mem_config);
@@ -1882,7 +1880,7 @@ static void gfx_v7_0_init_compute_vmid(struct amdgpu_device *adev)
 
 	/* Initialize all compute VMIDs to have no GDS, GWS, or OA
 	   acccess. These should be enabled by FW for target VMIDs. */
-	for (i = FIRST_COMPUTE_VMID; i < LAST_COMPUTE_VMID; i++) {
+	for (i = adev->vm_manager.first_kfd_vmid; i < AMDGPU_NUM_VMID; i++) {
 		WREG32(amdgpu_gds_reg_offset[i].mem_base, 0);
 		WREG32(amdgpu_gds_reg_offset[i].mem_size, 0);
 		WREG32(amdgpu_gds_reg_offset[i].gws, 0);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index efb759b62d21..33f1c4a46ebe 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -3686,8 +3686,6 @@ static void gfx_v8_0_setup_rb(struct amdgpu_device *adev)
  *
  */
 #define DEFAULT_SH_MEM_BASES	(0x6000)
-#define FIRST_COMPUTE_VMID	(8)
-#define LAST_COMPUTE_VMID	(16)
 static void gfx_v8_0_init_compute_vmid(struct amdgpu_device *adev)
 {
 	int i;
@@ -3710,7 +3708,7 @@ static void gfx_v8_0_init_compute_vmid(struct amdgpu_device *adev)
 			SH_MEM_CONFIG__PRIVATE_ATC_MASK;
 
 	mutex_lock(&adev->srbm_mutex);
-	for (i = FIRST_COMPUTE_VMID; i < LAST_COMPUTE_VMID; i++) {
+	for (i = adev->vm_manager.first_kfd_vmid; i < AMDGPU_NUM_VMID; i++) {
 		vi_srbm_select(adev, 0, 0, 0, i);
 		/* CP and shaders */
 		WREG32(mmSH_MEM_CONFIG, sh_mem_config);
@@ -3723,7 +3721,7 @@ static void gfx_v8_0_init_compute_vmid(struct amdgpu_device *adev)
 
 	/* Initialize all compute VMIDs to have no GDS, GWS, or OA
 	   acccess. These should be enabled by FW for target VMIDs. */
-	for (i = FIRST_COMPUTE_VMID; i < LAST_COMPUTE_VMID; i++) {
+	for (i = adev->vm_manager.first_kfd_vmid; i < AMDGPU_NUM_VMID; i++) {
 		WREG32(amdgpu_gds_reg_offset[i].mem_base, 0);
 		WREG32(amdgpu_gds_reg_offset[i].mem_size, 0);
 		WREG32(amdgpu_gds_reg_offset[i].gws, 0);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 99ffc3e1fddc..cb9d60a4e05e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -2463,8 +2463,6 @@ static void gfx_v9_0_setup_rb(struct amdgpu_device *adev)
 }
 
 #define DEFAULT_SH_MEM_BASES	(0x6000)
-#define FIRST_COMPUTE_VMID	(8)
-#define LAST_COMPUTE_VMID	(16)
 static void gfx_v9_0_init_compute_vmid(struct amdgpu_device *adev)
 {
 	int i;
@@ -2484,7 +2482,7 @@ static void gfx_v9_0_init_compute_vmid(struct amdgpu_device *adev)
 			SH_MEM_CONFIG__ALIGNMENT_MODE__SHIFT;
 
 	mutex_lock(&adev->srbm_mutex);
-	for (i = FIRST_COMPUTE_VMID; i < LAST_COMPUTE_VMID; i++) {
+	for (i = adev->vm_manager.first_kfd_vmid; i < AMDGPU_NUM_VMID; i++) {
 		soc15_grbm_select(adev, 0, 0, 0, i);
 		/* CP and shaders */
 		WREG32_SOC15_RLC(GC, 0, mmSH_MEM_CONFIG, sh_mem_config);
@@ -2495,7 +2493,7 @@ static void gfx_v9_0_init_compute_vmid(struct amdgpu_device *adev)
 
 	/* Initialize all compute VMIDs to have no GDS, GWS, or OA
 	   acccess. These should be enabled by FW for target VMIDs. */
-	for (i = FIRST_COMPUTE_VMID; i < LAST_COMPUTE_VMID; i++) {
+	for (i = adev->vm_manager.first_kfd_vmid; i < AMDGPU_NUM_VMID; i++) {
 		WREG32_SOC15_OFFSET(GC, 0, mmGDS_VMID0_BASE, 2 * i, 0);
 		WREG32_SOC15_OFFSET(GC, 0, mmGDS_VMID0_SIZE, 2 * i, 0);
 		WREG32_SOC15_OFFSET(GC, 0, mmGDS_GWS_VMID0, i, 0);
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index f7e66bf0f647..bfe62985afff 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -49,8 +49,6 @@
 #include "mmhub_v2_0.h"
 #include "athub_v2_0.h"
 #include "athub_v2_1.h"
-/* XXX Move this macro to navi10 header file, which is like vid.h for VI.*/
-#define AMDGPU_NUM_OF_VMIDS			8
 
 #if 0
 static const struct soc15_reg_golden golden_settings_navi10_hdp[] =
@@ -905,8 +903,7 @@ static int gmc_v10_0_sw_init(void *handle)
 	 * amdgpu graphics/compute will use VMIDs 1-7
 	 * amdkfd will use VMIDs 8-15
 	 */
-	adev->vm_manager.id_mgr[AMDGPU_GFXHUB_0].num_ids = AMDGPU_NUM_OF_VMIDS;
-	adev->vm_manager.id_mgr[AMDGPU_MMHUB_0].num_ids = AMDGPU_NUM_OF_VMIDS;
+	adev->vm_manager.first_kfd_vmid = 8;
 
 	amdgpu_vm_manager_init(adev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
index a75e472b4a81..538e7ee35cdf 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
@@ -878,7 +878,7 @@ static int gmc_v6_0_sw_init(void *handle)
 	 * amdgpu graphics/compute will use VMIDs 1-7
 	 * amdkfd will use VMIDs 8-15
 	 */
-	adev->vm_manager.id_mgr[0].num_ids = AMDGPU_NUM_OF_VMIDS;
+	adev->vm_manager.first_kfd_vmid = 8;
 	amdgpu_vm_manager_init(adev);
 
 	/* base offset of vram pages */
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
index bcd4baecfe11..e18296dc1386 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
@@ -1052,7 +1052,7 @@ static int gmc_v7_0_sw_init(void *handle)
 	 * amdgpu graphics/compute will use VMIDs 1-7
 	 * amdkfd will use VMIDs 8-15
 	 */
-	adev->vm_manager.id_mgr[0].num_ids = AMDGPU_NUM_OF_VMIDS;
+	adev->vm_manager.first_kfd_vmid = 8;
 	amdgpu_vm_manager_init(adev);
 
 	/* base offset of vram pages */
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
index 26976e50e2a2..a9e722b8a458 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
@@ -1177,7 +1177,7 @@ static int gmc_v8_0_sw_init(void *handle)
 	 * amdgpu graphics/compute will use VMIDs 1-7
 	 * amdkfd will use VMIDs 8-15
 	 */
-	adev->vm_manager.id_mgr[0].num_ids = AMDGPU_NUM_OF_VMIDS;
+	adev->vm_manager.first_kfd_vmid = 8;
 	amdgpu_vm_manager_init(adev);
 
 	/* base offset of vram pages */
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 11e93a82131d..6e10b42c57e5 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -68,9 +68,6 @@
 #define HUBP0_DCSURF_PRI_VIEWPORT_DIMENSION__PRI_VIEWPORT_WIDTH_MASK                                          0x00003FFFL
 #define HUBP0_DCSURF_PRI_VIEWPORT_DIMENSION__PRI_VIEWPORT_HEIGHT_MASK                                         0x3FFF0000L
 
-/* XXX Move this macro to VEGA10 header file, which is like vid.h for VI.*/
-#define AMDGPU_NUM_OF_VMIDS			8
-
 static const u32 golden_settings_vega10_hdp[] =
 {
 	0xf64, 0x0fffffff, 0x00000000,
@@ -1251,9 +1248,7 @@ static int gmc_v9_0_sw_init(void *handle)
 	 * amdgpu graphics/compute will use VMIDs 1-7
 	 * amdkfd will use VMIDs 8-15
 	 */
-	adev->vm_manager.id_mgr[AMDGPU_GFXHUB_0].num_ids = AMDGPU_NUM_OF_VMIDS;
-	adev->vm_manager.id_mgr[AMDGPU_MMHUB_0].num_ids = AMDGPU_NUM_OF_VMIDS;
-	adev->vm_manager.id_mgr[AMDGPU_MMHUB_1].num_ids = AMDGPU_NUM_OF_VMIDS;
+	adev->vm_manager.first_kfd_vmid = 8;
 
 	amdgpu_vm_manager_init(adev);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/si_enums.h b/drivers/gpu/drm/amd/amdgpu/si_enums.h
index 790ba46eaebb..4e935baa7b91 100644
--- a/drivers/gpu/drm/amd/amdgpu/si_enums.h
+++ b/drivers/gpu/drm/amd/amdgpu/si_enums.h
@@ -121,7 +121,6 @@
 #define CURSOR_UPDATE_LOCK             (1 << 16)
 #define CURSOR_DISABLE_MULTIPLE_UPDATE (1 << 24)
 
-#define AMDGPU_NUM_OF_VMIDS                     8
 #define SI_CRTC0_REGISTER_OFFSET                0
 #define SI_CRTC1_REGISTER_OFFSET                0x300
 #define SI_CRTC2_REGISTER_OFFSET                0x2600
diff --git a/drivers/gpu/drm/amd/amdgpu/sid.h b/drivers/gpu/drm/amd/amdgpu/sid.h
index 5f660f0c819f..ca2e9d661b28 100644
--- a/drivers/gpu/drm/amd/amdgpu/sid.h
+++ b/drivers/gpu/drm/amd/amdgpu/sid.h
@@ -48,8 +48,6 @@
 #define SI_MAX_TCC               	16
 #define SI_MAX_TCC_MASK          	0xFFFF
 
-#define AMDGPU_NUM_OF_VMIDS 		8
-
 /* SMC IND accessor regs */
 #define SMC_IND_INDEX_0                              0x80
 #define SMC_IND_DATA_0                               0x81
diff --git a/drivers/gpu/drm/amd/amdgpu/vid.h b/drivers/gpu/drm/amd/amdgpu/vid.h
index 7a01e6133798..80ce42aacc0c 100644
--- a/drivers/gpu/drm/amd/amdgpu/vid.h
+++ b/drivers/gpu/drm/amd/amdgpu/vid.h
@@ -67,8 +67,6 @@
 #define HPD4_REGISTER_OFFSET                 (0x18b8 - 0x1898)
 #define HPD5_REGISTER_OFFSET                 (0x18c0 - 0x1898)
 
-#define AMDGPU_NUM_OF_VMIDS			8
-
 #define		PIPEID(x)					((x) << 0)
 #define		MEID(x)						((x) << 2)
 #define		VMID(x)						((x) << 4)
-- 
2.26.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
