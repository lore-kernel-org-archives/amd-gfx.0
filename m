Return-Path: <SRS0=BT7C=ID=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF095C433E6
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Mar 2021 15:06:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A64F365013
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Mar 2021 15:06:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A64F365013
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3AB396EBA2;
	Fri,  5 Mar 2021 15:06:39 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2049.outbound.protection.outlook.com [40.107.220.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 769C26EB97
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Mar 2021 15:06:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FGNTh1I3dhVnV8SKmp8BT2sx87yxWh7SokS5/kuO3OV9sDOfASaFlZ/RToLiFekxHjKEio0HU4Eb1L56FJBbMJWhSnutLIelzppxB13n816NNzIM8zjwaeRv8RHhGjRX3jiyuMHaktjF80nB0Xce7+OhA510zQoIPFYDTPJ4RuIYJHhpg0j4Y7HTPupSfL5w5moPQri5OlbEE19fqzbkiKjJDnBaldXuGW3cnf1u/vS0/qIjJ6B8x29/HeT6PttlXjpyei89RU0fpIdppDiOMpuI5/QJpp2o/+Fs/fbL7orqQWOD6r7YN7aqXCrcm+Y+OXPt7xqxzYOKZ+E5VB1bog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6dz8Ix95YiS32/HdLIkBCvyP6AKJ7oN+wBH/GQVAr2I=;
 b=WcxTe80bnXxap6g4Cm0myEazZ45fhBLGpmKUXiyinL0bHvN/HtN8Y33nnzWXkjfFgAlTRkdqwas6xb98hwxc6Q7QYUX61xD4mkj1HRvqAYMIdoD9YZMqtkTkb6UHF6jTMQPuG4LkMeoD0NTU/Bn4eqzSwRQ595o9j7KnokKC7OdjNJxe1jmVvuhtBrFctQC0Z6I/NptCMycp+NyuWo3cdnq8GN6atvu8KwA7Z7v/U7sJqmD4clSEUcnw+/GX1tY91Tc9LAn5Ix/3PM7i9BXw7Go0XMOonjyj/WyUOArN1KF2woQdcyKpo/xxP0pRwpP6TByWwF6rjR56wWJap+gQ+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6dz8Ix95YiS32/HdLIkBCvyP6AKJ7oN+wBH/GQVAr2I=;
 b=PMGe3QIVJMjz7+PlfkrdE6aCFgwqpNcYa9oGWQ4ooUeHDfxMPND+yhXaKRMGG7WKRlvcE9GI+L+IPAGrlDx/UJ1sSOGGbUae9LB3icSiokd8/v3h00jMBHMVfUn/e8bMSUwsplVMAe4iJf3LC2AEL1S7QZNMTVEPP2B0Pz/wWZk=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1463.namprd12.prod.outlook.com (2603:10b6:910:e::19)
 by CY4PR12MB1208.namprd12.prod.outlook.com (2603:10b6:903:3d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Fri, 5 Mar
 2021 15:06:36 +0000
Received: from CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::6504:7fc4:d02f:77f2]) by CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::6504:7fc4:d02f:77f2%3]) with mapi id 15.20.3890.030; Fri, 5 Mar 2021
 15:06:36 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: Christian.Koenig@amd.com
Subject: [PATCH 5/5] drm/amdgpu: use metadata members of struct amdgpu_bo_user
Date: Fri,  5 Mar 2021 16:06:17 +0100
Message-Id: <20210305150617.20144-5-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210305150617.20144-1-nirmoy.das@amd.com>
References: <20210305150617.20144-1-nirmoy.das@amd.com>
X-Originating-IP: [217.86.122.77]
X-ClientProxiedBy: FR2P281CA0022.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::9) To CY4PR12MB1463.namprd12.prod.outlook.com
 (2603:10b6:910:e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brihaspati.fritz.box (217.86.122.77) by
 FR2P281CA0022.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:14::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3933.14 via Frontend Transport; Fri, 5 Mar 2021 15:06:35 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 31ba4a2c-32f5-4e8e-4af5-08d8dfe84546
X-MS-TrafficTypeDiagnostic: CY4PR12MB1208:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB1208F47F418F6DD4F75E3DE78B969@CY4PR12MB1208.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GuwOlkI8m+fcf3pSotQ+W1SQxPwfDq/qMVRaEcfZs+zOeffkUZ3VNt7+miI8czZLJoamK8V/L53lxzGsojcOU7DiN2Dq+CX6glGFZBajxwXb5TelhJXE3vizz4x0INiYF03wn0D2wk0T3AifXSoRNZHCZynp0UDM/soiebCYu5IXpl/yw/5h9TOqYU/brvdkZQhSKdDl6J78J25PPUONJoX7UmxnqSHnDkfH1xgrB2sWEcB6UErunpS/hSLLLTzlXIJcTPrfxEtcHZwQxTMAMTVlS9dv4z4WO91V+feHq49NJf7Vu6892SU7IWdMbvBMEdkEqPtPo2kutZsDoxzXid3ezC9TR2Nw/H8mxCbsJ+NDT/HAxgmu+9WXOtFzShjTwt1KkjTaXl4tT/U5Mw96s8TO9EmeFP2CZZYMeK9mZT1sO60sd48STH8JlY4Z9wKVrLgc78qx5h56T2s324jS3gJOKCsMq2KvKJf7u8Lp4OeJTEoBgsTeTiXP0F1VrfEtOnRleEFa+FDAcZ2EUCAULw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1463.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(39860400002)(346002)(366004)(136003)(6486002)(5660300002)(6512007)(52116002)(6666004)(8676002)(1076003)(6636002)(37006003)(66946007)(316002)(66556008)(66476007)(478600001)(956004)(2616005)(186003)(36756003)(26005)(4326008)(83380400001)(44832011)(86362001)(2906002)(8936002)(6506007)(34206002)(16526019);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?PJakv9ncLwHnEFRNmdEpwslLNa0mUNA4NVoDxpnTfhCFBVPNHB9c59dCYB7M?=
 =?us-ascii?Q?iUNiP1/1SCBEE81Y4dDkJ4YdZZevvDATctaeBam827HwMen+R4NjaQ7aCbyO?=
 =?us-ascii?Q?YZZt8v0m7cgx9lwiFEF3YY4xViim9T2Nlb77fMH4GN/w7+o4/MCx2S4AcM92?=
 =?us-ascii?Q?bi1WnE9d90pASQ0icxl4kUVq+tY0EslXchxeWIsh1Pvd+0LftLyWJ71EQl+L?=
 =?us-ascii?Q?KmadT0QDtRTlf4EHrM/j+gSV3NhfWDdWDPvsqGk1u7/t/O6s4ZJ4jfBnRGwR?=
 =?us-ascii?Q?NniTpP+pOzSx6w5qYMAJi3UeYmt5i4NZ8EWzukWVuXCJei6BdEWgSwmjBV8e?=
 =?us-ascii?Q?Rp2PlS+IXMNG29oqtxyxN3mAuICOyqq7a51wVNGjK3fqvZDTsRy9/IWsDOya?=
 =?us-ascii?Q?PuXSwu7RCGHofrlSgR7qFTZJugX54XTS5/BmWU/cP8+zZOSH4V7u06v7F7XR?=
 =?us-ascii?Q?7roeQLXfkxDi2G4h05Wvaq73e9cikqYIB3KRH/TUmQEgkRAKjISacj2EnTfk?=
 =?us-ascii?Q?D23puY6SZ2u3BN4zSOUWLAFgjM5ZK0AJKwMxDYlSdHG9CN3YH7oiEqzNFntQ?=
 =?us-ascii?Q?wLZo28Rjez6rSlgjCFpuQR4dsHjn1LIe/sdA01AEd8q8tCn8NEla69Ou8Nnw?=
 =?us-ascii?Q?cnxLpW8BhfJyfF3xu+sxNwdsQJj0DMJFx3+CdOgTDbpClkXrOXqvPtC3TkGT?=
 =?us-ascii?Q?bd7RB+LYuLym5mGX2Aq6Ke9ljlhlG3f37XNm1DJJvcnY6xlQ0QbrBsNN/ied?=
 =?us-ascii?Q?H+HeKLzeUelJWSK8mOwD+GrMiQmD3v74xo0ZK3qKFH2CUmuvdmYk8PPlrjuk?=
 =?us-ascii?Q?oOiFAHKk9d5tRJNTqT0c+cYU+HRo01/aqFQ0YX1ElLBChqNkrQGr7QurSwwm?=
 =?us-ascii?Q?HFWeJ54aoS4CaxC+JXCQYEJSMZ9bXZwHYCIMZei0Y6+O1BdDiNTE3Acc0HUY?=
 =?us-ascii?Q?9gtYuafCTcuGktXbxF2upSIob/3YUDc6qF4ZLQAivTK2T6qQE/Y4e2qALe7Y?=
 =?us-ascii?Q?2ItZgPqtQddI3HhSyC0GXGP8CPRkbKeikMXBrTnNghPXBMlM+FSX+6VjuyrG?=
 =?us-ascii?Q?TobCiq24d11bLv6mfDQknOzHncWqfBqHCEbdMK70xOG+rXe3HJFDgfwbUXeN?=
 =?us-ascii?Q?B0s3VB2BTYiM7IAwG9ZvSRLwm9yKnF3DRQoUv5+41sZauuXN5P5tW86GDGRI?=
 =?us-ascii?Q?wQMGDjNgxycLH0v69qadnYT8z4rK8OOO/tPSke+tz1Kml/YUkc+nQJwKuX+B?=
 =?us-ascii?Q?V5BOsyCamHPWHHu5E6TM1gUhCyp7hemAkCdS6oMb1zeJWEAM/uIX7KJKHK40?=
 =?us-ascii?Q?uE9HbRdaVgwJIRSz/ijIyu4S?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31ba4a2c-32f5-4e8e-4af5-08d8dfe84546
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1463.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2021 15:06:36.2655 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I5wEfxHfnmp/bXYIrVDtrRl9ACuVud4jO2DPa4iVAzYaJiJhMIoC9lEKjvgqYe4dyacz+J1oPC6tvhMJzkN7SQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1208
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
Cc: felix.kuehling@amd.com, Nirmoy Das <nirmoy.das@amd.com>,
 amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

These members are only needed for BOs created by
amdgpu_gem_object_create(), so we can remove these from the
base class.

CC: felix.kuehling@amd.com
Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c |  2 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 48 +++++++++++++++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |  3 --
 3 files changed, 34 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index c5343a5eecbe..f8c8cbd8ab59 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -494,8 +494,6 @@ int amdgpu_amdkfd_get_dmabuf_info(struct kgd_dev *kgd, int dma_buf_fd,
 		*dma_buf_kgd = (struct kgd_dev *)adev;
 	if (bo_size)
 		*bo_size = amdgpu_bo_size(bo);
-	if (metadata_size)
-		*metadata_size = bo->metadata_size;
 	if (metadata_buffer)
 		r = amdgpu_bo_get_metadata(bo, metadata_buffer, buffer_size,
 					   metadata_size, &metadata_flags);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index ca60943312dc..7c744d90ed34 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -77,6 +77,7 @@ static void amdgpu_bo_destroy(struct ttm_buffer_object *tbo)
 {
 	struct amdgpu_device *adev = amdgpu_ttm_adev(tbo->bdev);
 	struct amdgpu_bo *bo = ttm_to_amdgpu_bo(tbo);
+	struct amdgpu_bo_user *ubo;
 
 	if (bo->pin_count > 0)
 		amdgpu_bo_subtract_pin_size(bo);
@@ -94,7 +95,11 @@ static void amdgpu_bo_destroy(struct ttm_buffer_object *tbo)
 	}
 	amdgpu_bo_unref(&bo->parent);
 
-	kfree(bo->metadata);
+	if (bo->tbo.type == ttm_bo_type_device) {
+		ubo = container_of((bo), struct amdgpu_bo_user, bo);
+		kfree(ubo->metadata);
+	}
+
 	kfree(bo);
 }
 
@@ -1236,13 +1241,20 @@ void amdgpu_bo_get_tiling_flags(struct amdgpu_bo *bo, u64 *tiling_flags)
 int amdgpu_bo_set_metadata (struct amdgpu_bo *bo, void *metadata,
 			    uint32_t metadata_size, uint64_t flags)
 {
+	struct amdgpu_bo_user *ubo;
 	void *buffer;
 
+	if (bo->tbo.type != ttm_bo_type_device) {
+		DRM_ERROR("can not set metadata for a non-amdgpu_bo_user type BO\n");
+		return -EINVAL;
+	}
+
+	ubo = container_of((bo), struct amdgpu_bo_user, bo);
 	if (!metadata_size) {
-		if (bo->metadata_size) {
-			kfree(bo->metadata);
-			bo->metadata = NULL;
-			bo->metadata_size = 0;
+		if (ubo->metadata_size) {
+			kfree(ubo->metadata);
+			ubo->metadata = NULL;
+			ubo->metadata_size = 0;
 		}
 		return 0;
 	}
@@ -1254,10 +1266,10 @@ int amdgpu_bo_set_metadata (struct amdgpu_bo *bo, void *metadata,
 	if (buffer == NULL)
 		return -ENOMEM;
 
-	kfree(bo->metadata);
-	bo->metadata_flags = flags;
-	bo->metadata = buffer;
-	bo->metadata_size = metadata_size;
+	kfree(ubo->metadata);
+	ubo->metadata_flags = flags;
+	ubo->metadata = buffer;
+	ubo->metadata_size = metadata_size;
 
 	return 0;
 }
@@ -1281,21 +1293,29 @@ int amdgpu_bo_get_metadata(struct amdgpu_bo *bo, void *buffer,
 			   size_t buffer_size, uint32_t *metadata_size,
 			   uint64_t *flags)
 {
+	struct amdgpu_bo_user *ubo;
+
 	if (!buffer && !metadata_size)
 		return -EINVAL;
 
+	if (bo->tbo.type != ttm_bo_type_device) {
+		DRM_ERROR("can not get metadata for a non-amdgpu_bo_user type BO\n");
+		return -EINVAL;
+	}
+
+	ubo = container_of((bo), struct amdgpu_bo_user, bo);
 	if (buffer) {
-		if (buffer_size < bo->metadata_size)
+		if (buffer_size < ubo->metadata_size)
 			return -EINVAL;
 
-		if (bo->metadata_size)
-			memcpy(buffer, bo->metadata, bo->metadata_size);
+		if (ubo->metadata_size)
+			memcpy(buffer, ubo->metadata, ubo->metadata_size);
 	}
 
 	if (metadata_size)
-		*metadata_size = bo->metadata_size;
+		*metadata_size = ubo->metadata_size;
 	if (flags)
-		*flags = bo->metadata_flags;
+		*flags = ubo->metadata_flags;
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
index 67c1634fa8bd..5005bb4480e9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
@@ -91,9 +91,6 @@ struct amdgpu_bo {
 	struct ttm_bo_kmap_obj		kmap;
 	u64				flags;
 	unsigned			pin_count;
-	u64				metadata_flags;
-	void				*metadata;
-	u32				metadata_size;
 	unsigned			prime_shared_count;
 	/* per VM structure for page tables and with virtual addresses */
 	struct amdgpu_vm_bo_base	*vm_bo;
-- 
2.30.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
