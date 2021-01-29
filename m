Return-Path: <SRS0=nuNM=HA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70091C433DB
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Jan 2021 02:49:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E935464DFD
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Jan 2021 02:49:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E935464DFD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03CE96E372;
	Fri, 29 Jan 2021 02:49:41 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2070.outbound.protection.outlook.com [40.107.237.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A36846E372
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Jan 2021 02:49:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EELjjTs8Y+Orv333qN7rmoH6BqTBb4pT23UH9oTmjnYrkolEG14wNtCRM9zdVJ+TsLsTVW18xtELcCl0PIAz0vQmFc6lMbxWSQjUqZQ8paJXo5yxrqMdRkZKWtSWYqUO+Jb1zDe8vJDSc1diRWNbY4vA1vJ/QspRIiPPr6bz78lGjpYkhgxdMicVIVWS7Zx86p0XcjYjR/cRjmlgnXTHwu6c9UEKLXVYVEvhhkeBb86oKCB9KF95c5wwTfGks/ljTaxSBoe1RjBsln9lXXTcG9aRoA1pE7pIq2xVk9qRHyZtP6ZEOjVTIROnjzDN10fifXuxz5kk3R8v1GT1lJqmKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NouEBTq0OFfUJCONSO7KI3EWGVt2kgZI8riUQlTzmNc=;
 b=AmwVzY8IJ99md9g7k5VnDUZXTKgk77809nJPHJjRLB1tlw1FIzzb9bmM+7NwxeJg3zf3AX5J9UkExwOUhEtSXQ7HoUypLOUxQUHKggwJqye6Y1K1e5yjMyr2/bWJZ8LG7kkkWjsHaI1XrE7CEJ0fuBLudC9U9Lt0n+n5X47FcI26WwBWa1VfQnQePzHuDm2W42f+WdPiM8iYhjuuuRh30jfJ+apDGj1bvD5pWJklnbJ7mRH6Rf48wukP+kJvgZ6mkvaHaZVHGTP+k/F2Ti1pIFfcxM270lfaUWrp+h48PWzkl6B5614/HgQh/Fnafh71kEqnkO+CGwOWpaCUQ1FHpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NouEBTq0OFfUJCONSO7KI3EWGVt2kgZI8riUQlTzmNc=;
 b=Uy18RlekCL5iIajCfoc/778izUzi8opVBN6Im0r90xD4nk+39N/E9k+r3m3Ld4t2RnSoKA+DldjWOgulzTd6Fd0qUy1J/6ha4fgcH58Y0HD3SC2SvdVqNUSLnp4vCcuHhbyK916DT8nFCMjNpAJiv5Hq3fcyyNfzkTmhPGVRE1M=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2672.namprd12.prod.outlook.com (2603:10b6:805:6f::25)
 by SN6PR12MB2608.namprd12.prod.outlook.com (2603:10b6:805:68::25)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.12; Fri, 29 Jan
 2021 02:49:38 +0000
Received: from SN6PR12MB2672.namprd12.prod.outlook.com
 ([fe80::f1c5:dcb5:37df:ac2c]) by SN6PR12MB2672.namprd12.prod.outlook.com
 ([fe80::f1c5:dcb5:37df:ac2c%5]) with mapi id 15.20.3784.019; Fri, 29 Jan 2021
 02:49:38 +0000
From: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amdgpu: Enable pinning of a BO and building an
 sg_table off of it as separate peer services
Date: Thu, 28 Jan 2021 20:49:24 -0600
Message-Id: <20210129024924.3353-1-Ramesh.Errabolu@amd.com>
X-Mailer: git-send-email 2.29.2
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: SA0PR11CA0150.namprd11.prod.outlook.com
 (2603:10b6:806:131::35) To SN6PR12MB2672.namprd12.prod.outlook.com
 (2603:10b6:805:6f::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from RErrabolDevMach.amd.com (165.204.77.1) by
 SA0PR11CA0150.namprd11.prod.outlook.com (2603:10b6:806:131::35) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17 via Frontend
 Transport; Fri, 29 Jan 2021 02:49:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a7665127-843d-421c-2d9a-08d8c400851c
X-MS-TrafficTypeDiagnostic: SN6PR12MB2608:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB26089306918332161F156D22E3B99@SN6PR12MB2608.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Mj8dIFzfuNX3rrr/KvA8ZySnVAzhlwEtUqox+VuTu8AZcD1OabBhVekRk8pxlMu/+6PmEL4xw0nAMsRxA8jsmukYDKMrYRFXVirpKwZ9K93QmDr4FwsRAuXFqUV87VYNzZbthTi6apVnI6zMw0elrZ0T1hX+GK7OmfwgZrVfWfNBl76FVjJcPw98SE2wWr+U6LRnbxiLLCveAbAsCbmFsykq4I7UMbMpceAn9wvL4pCt1FzTSAvwPcGSO/xyT1XtulYDF+v36Z+dhBMr3ca2lrtw6rknYJ3ZE1iRCOC6ArJcA+wXfuJNW+5r6Z9Qz+A541QiVgnegdSh6LEHLa0vYNtaNyv3KrvgJAAcOH9+8Jb+FJ/XM2Xk49NzA+JyIrk9J+X+8lcW7JY9LjbDxv0mBQCSrWHs8snsHFtt7xu4ZDJGwBAqBkCE5dQMcrBCJYbi0hCNpX9dXU0OAi0AeTDRrAJdIHrklyNPc5q9YDr7+nbhDl/hLbwbSyYrr95guyc5vKDfUxujCyyI6aovwARkBg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB2672.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(376002)(39860400002)(136003)(366004)(2906002)(52116002)(8676002)(86362001)(186003)(16526019)(26005)(956004)(66946007)(7696005)(2616005)(36756003)(83380400001)(1076003)(478600001)(6916009)(66476007)(6486002)(6666004)(5660300002)(4326008)(66556008)(316002)(8936002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?avsKutLTA1ZgmQrqxFz78rUM5vljLofqfIKeMpv2aSvx5qtn5CNAnvqCBiBI?=
 =?us-ascii?Q?BoFqvTRZtQ+N3bVm34JvFJL/Y43/DK7KVyrs33TWk50JVRCKPmFfshcMk61H?=
 =?us-ascii?Q?sbh8Z17PuR3nbMujJWM7jJ+pzvTEkJLj65A5i52eX9tQewkvCHlLJNtwyPyt?=
 =?us-ascii?Q?CeHFCXRWeFP1sG18jB5Db86yf6vVpL/9cT9zZ04YyaXlK1MmjluqrRpNIRmS?=
 =?us-ascii?Q?BMiBEdpv8QLedI6eadpIWFxJXarnVzlTRW/rycUYduLLstJkA9pxOMg3ttYC?=
 =?us-ascii?Q?7784mTVzQ01jaA1Lv0cPrPhNUGqrJqqsru9Ca1TcDUj1Yb0/xbpeE6JwTNnq?=
 =?us-ascii?Q?xpZVx62UtZIhfh51qfKMQXErGnSBXy5ME009YmNolEi77P6Xcd9QI3aAYlxS?=
 =?us-ascii?Q?1+Vz1tcioRk35l0JaaDVwY2zkbKw+dBJe3JExEmgxzK8GuoBm1hz21FI5paZ?=
 =?us-ascii?Q?QjJ4n/QVdK34i5tANa3XNgrMq2FbZKSE/ECaEBW0MhM2Ba4Ay+u8UNq2qkpZ?=
 =?us-ascii?Q?KK88PMk4zor1Lwdz2VOhZiTNsEU2+E9cwYk6lz3BNt9yzDopxd5+Wk5J+rCg?=
 =?us-ascii?Q?VHdmLX4HwOYN3d1qx6dTKJHGM24qMlh+Ls1V4I0DnBff5cR+rO433fAHoxq5?=
 =?us-ascii?Q?8RklqTifHwM2jQVPWTTEp+EnT/Q6ogd6hQf49DS076kBmBwkVONzBwtHoEMG?=
 =?us-ascii?Q?pbp1bbZMwtanbQW/CEoGtnziSjhQufA9650C0hIU2QmHwCkdMMD/KlQ6l410?=
 =?us-ascii?Q?UKPG2xhJsnLO46eKMb/PZqSyCRyeB8mjEK/jq9iKQ7NdUpEsvjk2s+NDgyKl?=
 =?us-ascii?Q?bXByxUU8pnSF9N34TfVFoqNoU/+5kJoJ9LwgKlE3TmvHXyTbeL7J5y9jILoe?=
 =?us-ascii?Q?+7iJDe/me5QQnjSdu6hqIKMxt5KuzgKDTSb1xNcRdIW7L+L+sUmk5yamnYP+?=
 =?us-ascii?Q?8yMN0sxddS/bw+qSZS+GO+VknWkGoYcG1sMgiE0eO/DzKaa1cY2EOUp+qEn+?=
 =?us-ascii?Q?DWa1OlLSqUCzDeYJy9fL48ECAcgplVO2ytXFM9pgJk7RPBP8eXT5z4HGcNHS?=
 =?us-ascii?Q?Cl5ecX2M?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7665127-843d-421c-2d9a-08d8c400851c
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2672.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2021 02:49:38.6954 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HpoZSRhmUFzRLe8l6OI9drMd8QZfDMLFGXTDbPNkkizmIDfrjZYZIZs0m8B28xy1xybt3Ft7L3XLrfbyRonbCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2608
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
Cc: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
Enable users to determine the use and sequencing of these services.
Not all uses of pinning need to be followed by building of sg_table

[How]
Rename and refactor the implementaions of gpuvm_pin_get_sgtable() and
gpuvm_unpin_put_sgtable() apis in gpuvm.c

Signed-off-by: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h    | 12 ++++++----
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 23 ++++---------------
 2 files changed, 12 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index 8013470d7c8d..92860b16c14b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -249,11 +249,13 @@ int amdgpu_amdkfd_gpuvm_restore_process_bos(void *process_info,
 int amdgpu_amdkfd_gpuvm_get_vm_fault_info(struct kgd_dev *kgd,
 					      struct kfd_vm_fault_info *info);
 
-int amdgpu_amdkfd_gpuvm_pin_get_sg_table(struct kgd_dev *kgd,
-		struct kgd_mem *mem, uint64_t offset,
-		uint64_t size, struct sg_table **ret_sg);
-void amdgpu_amdkfd_gpuvm_unpin_put_sg_table(
-		struct kgd_mem *mem, struct sg_table *sg);
+int amdgpu_amdkfd_gpuvm_pin_bo(struct kgd_mem *mem);
+void amdgpu_amdkfd_gpuvm_unpin_bo(struct kgd_mem *mem);
+
+int amdgpu_amdkfd_gpuvm_get_sg_table(struct kgd_dev *kgd, struct kgd_mem *mem,
+		uint64_t offset, uint64_t size, struct sg_table **ret_sg);
+void amdgpu_amdkfd_gpuvm_put_sg_table(struct sg_table *sg);
+
 int amdgpu_amdkfd_gpuvm_import_dmabuf(struct kgd_dev *kgd,
 				      struct dma_buf *dmabuf,
 				      struct kfd_ipc_obj *ipc_obj,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 702cad576728..0d1984357451 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1726,7 +1726,7 @@ int amdgpu_amdkfd_gpuvm_get_vm_fault_info(struct kgd_dev *kgd,
 	return 0;
 }
 
-static int pin_bo_wo_map(struct kgd_mem *mem)
+int amdgpu_amdkfd_gpuvm_pin_bo(struct kgd_mem *mem)
 {
 	struct amdgpu_bo *bo = mem->bo;
 	int ret = 0;
@@ -1742,7 +1742,7 @@ static int pin_bo_wo_map(struct kgd_mem *mem)
 	return ret;
 }
 
-static void unpin_bo_wo_map(struct kgd_mem *mem)
+void amdgpu_amdkfd_gpuvm_unpin_bo(struct kgd_mem *mem)
 {
 	struct amdgpu_bo *bo = mem->bo;
 	int ret = 0;
@@ -1852,33 +1852,20 @@ static int get_sg_table(struct amdgpu_device *adev,
 	return ret;
 }
 
-int amdgpu_amdkfd_gpuvm_pin_get_sg_table(struct kgd_dev *kgd,
+int amdgpu_amdkfd_gpuvm_get_sg_table(struct kgd_dev *kgd,
 		struct kgd_mem *mem, uint64_t offset,
 		uint64_t size, struct sg_table **ret_sg)
 {
-	int ret;
 	struct amdgpu_device *adev;
 
-	ret = pin_bo_wo_map(mem);
-	if (unlikely(ret))
-		return ret;
-
 	adev = get_amdgpu_device(kgd);
-
-	ret = get_sg_table(adev, mem, offset, size, ret_sg);
-	if (ret)
-		unpin_bo_wo_map(mem);
-
-	return ret;
+	return get_sg_table(adev, mem, offset, size, ret_sg);
 }
 
-void amdgpu_amdkfd_gpuvm_unpin_put_sg_table(
-		struct kgd_mem *mem, struct sg_table *sg)
+void amdgpu_amdkfd_gpuvm_put_sg_table(struct sg_table *sg)
 {
 	sg_free_table(sg);
 	kfree(sg);
-
-	unpin_bo_wo_map(mem);
 }
 
 int amdgpu_amdkfd_gpuvm_import_dmabuf(struct kgd_dev *kgd,
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
