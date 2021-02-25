Return-Path: <SRS0=Rd3N=H3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A33AC433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Feb 2021 02:50:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D121C64ECB
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Feb 2021 02:50:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D121C64ECB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 547D96E8C0;
	Thu, 25 Feb 2021 02:50:12 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2054.outbound.protection.outlook.com [40.107.93.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5EC7D6E8C0
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Feb 2021 02:50:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gTfcGAkYRzsq/eYS7q/mLYeHVqZg1H7BtFr3VXHvClyNbAcCi+G/KqXOHTi/IRph8inc/H54kPDVRFXFAjeV4uyPYvPotrsH4U0ibcNoDJfHwTnh/kN0EomwavkxT9Ho1Ti2JioVoeHKIdqVXwJ2kK7reLwDuuL7fRnp92oXLroITghrXmyRLwnpKP4wmXpY1vji0v2d9gQ4KsIYhJjoQxLBUdNXwakynZWrIiuo60nUfTntzz9EmJvERyJ0gk2u5sWBe3iBTNQ6IzJRuZ9hHei6G+MpCDwKCF2IoGO+7HTyPtwoMOtHd03LfjHmMGJorxWxm4e83195kN/4rvAUDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wNYWZY+3pNIqw380zwk+D/yP+V+VjFZ1W1v0MZWKhM4=;
 b=aYELQ6AErrbLsukRDRY9oFs/xJGQjkssMm5DJ+ar7VAfO9F1AYGprPeJhXp746cmNvOm+hoOIZ/VN6972q2kvuyAKDwlEM3mM+LrEhCqA80JT8htxjNjf0I38vgno7kBSm6P28rOB4XitzH5k4k+oPWPMeXWS104bjznb32XeSAu+E9Refq1judjPcG+zXsKMUztgW/S8v6p10JufV6glpjXtlRp5BcsQgttC3hCSt3SotUkuyjUCiq2VhSywpm530Xfp5hMrAYClF9HVtaJ0IQvXKETw70bgUMaVLM4NjS1Ab9ND2V0tl/MVyednvLzINsDpV6A3rxy3OEmxuDimg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wNYWZY+3pNIqw380zwk+D/yP+V+VjFZ1W1v0MZWKhM4=;
 b=X81x/3ZwNR0OSv99HTWcQQrOdbukgF6iooDk8LwdyahQIVC5+o3e8uG5ou9YGlJO2vWWtMsbdQkRNSToKJ0uYeGvwVcXJKkX6HKDL0z2e2RbVoLNvqaYM7QbOdwTpxvPvqdtljQBYr2ESJWis/JTVERpYwNVb0oUme3HX13kmD4=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2672.namprd12.prod.outlook.com (2603:10b6:805:6f::25)
 by SN6PR12MB2670.namprd12.prod.outlook.com (2603:10b6:805:6b::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Thu, 25 Feb
 2021 02:50:08 +0000
Received: from SN6PR12MB2672.namprd12.prod.outlook.com
 ([fe80::f1c5:dcb5:37df:ac2c]) by SN6PR12MB2672.namprd12.prod.outlook.com
 ([fe80::f1c5:dcb5:37df:ac2c%5]) with mapi id 15.20.3868.033; Thu, 25 Feb 2021
 02:50:08 +0000
From: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: Remove amdgpu_device arg from free_sgt api
Date: Wed, 24 Feb 2021 20:49:56 -0600
Message-Id: <20210225024956.27425-1-Ramesh.Errabolu@amd.com>
X-Mailer: git-send-email 2.30.0
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: SN6PR08CA0036.namprd08.prod.outlook.com
 (2603:10b6:805:66::49) To SN6PR12MB2672.namprd12.prod.outlook.com
 (2603:10b6:805:6f::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from RErrabolDevMach.amd.com (165.204.77.1) by
 SN6PR08CA0036.namprd08.prod.outlook.com (2603:10b6:805:66::49) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3868.28 via Frontend Transport; Thu, 25 Feb 2021 02:50:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: eb64f3c5-146f-47d1-705d-08d8d9381029
X-MS-TrafficTypeDiagnostic: SN6PR12MB2670:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB2670F2E38A5A69AFA4EC50F5E39E9@SN6PR12MB2670.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CnqgPLu0RjqptiNDMbNlME/qz7nGDGUfueK5UZjiCeWuilKA4qU1Zgq/w5QUmFWwq747qsXwx9zTIzlKDeTBaNCxCzJIGIUuiibui1/MaVe4Oxz6hzGELqNaZkp4lkmB4muC2y1m/B1MLjhA1yXduLX0V8DDuAeBdTskO5dS2JQhhQsPlbD/jFx1EMxlifTAkYKDmUgnbGhRflZpFynblX+sKY7J7/s9NTTadfxlUyS9EGfovtmQhGRjcwegUqhmsVsrbfmWwI4CVcFc+wU2DpMyWzb0wlxmiJgFjpRfGapFb5sqHzGmWEtHr2UzwAYpXByom3jC99M9wlj/zXa2R9LfS6Fllekv5j/yjb0UU3g5BPywwQkNCVXFvNbHHQu5p/5Pw/VyiFRqV6g1nrRs2f34biSwOSC/J7YAyGdD+IZRKnTOZLmj/MuWxuLRNwYc9KZV3V6O69OhcEqtL5/Gqyi/0jQCKc+Xk79KhqdT82TZkKC3trTnpC+vuzPGcdQH5XF5uXdrcEKp+EONCn4Pyw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB2672.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(366004)(376002)(39860400002)(136003)(346002)(186003)(16526019)(2906002)(26005)(6486002)(1076003)(52116002)(7696005)(316002)(86362001)(6666004)(66946007)(8936002)(6916009)(4326008)(66476007)(66556008)(8676002)(5660300002)(83380400001)(2616005)(478600001)(956004)(36756003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?a6nzl83UGwQPg4XxUDNP18lb3xaJFZ9Zh3+yZI8ZdI/M0YLDX44wXZodnzAr?=
 =?us-ascii?Q?1AmBqr4IiUMu+xDO7zljUh8jCGT5ZOeOMt/5+HrMjHTNppEcltHUeKmz/tBX?=
 =?us-ascii?Q?8WR8G+r4etlecZIa5MXsCowkcMYeX72LTg6eTi8HpDHxQZWWLdGk91Dp7Y07?=
 =?us-ascii?Q?fcusfi0qbf2jsekIZC3jkFuf3/NoueO4vkfqB+bMeRlXsZnFJmGTmLql+Kn5?=
 =?us-ascii?Q?G823fsIVks3trj7UR4LBcOE4bmHMigqRZiAh+lu3eWF4NOInqVGZVuZoHBLd?=
 =?us-ascii?Q?dTGiEOGJcmcCr+KsjApGVFJllwunv5/phdBW4v2hMp1+8s1IELfRbXJREADJ?=
 =?us-ascii?Q?CbAHvgYN6teE0hrR7rpiBnohkYJUMKgtd4/q+hNIq0QCsIidOAfccytFwXKO?=
 =?us-ascii?Q?VK/zuLGWAnyNLfi7EgBUpkCXJTDqsHw9m4KYz4b7+6yQFmpiRBaeveRpayA+?=
 =?us-ascii?Q?5AdSBE/VnEKqAVCzDx8ZWlMHQOG9q0A0WCeRLyMjcL8uNcARkD9ayTsHYxwu?=
 =?us-ascii?Q?zrWX2wu9gID7teG6IJqu/stxX5yHn9NQgdYYf07ud5PDFhR5fqtbarB2009N?=
 =?us-ascii?Q?lWThn15VzVOVjgyuDIzTGWunhGPA53RgycehE5JdI34abOoJa1jPRJwjb2Q/?=
 =?us-ascii?Q?q3IVD0gYUkloVvDHua4WPv8sf2UZwovYfcgUU8SKuTCuJkijWf+nMc2AuTFI?=
 =?us-ascii?Q?zqT2NmIruXRPUUfUMy3r/XD4trOVKBydbf/23rd+9yxkfoWc7lHrIs8L4KxI?=
 =?us-ascii?Q?/yBF0vX9fFUEhXfGo7g+dRW2LPZBal53Go1qehoqMGDqtFdKzBPhYMnbzx7+?=
 =?us-ascii?Q?l6XGYFHqOu7rknb+AbAex0ONpDyAvq/k8Fbyaf6faY1AON/6wy8kjs5t+WWG?=
 =?us-ascii?Q?rx6F4+4zJte+UEXUVJG5w2sZ9FSNPzuy/SgWseIA2EtUWHiQablYJjrVS4Er?=
 =?us-ascii?Q?xwfYZI7CJW9IFOUt/abZNVkQ61ESHMMVaXtpC5KuHhJrxovruz7nziM4tJv+?=
 =?us-ascii?Q?l3JCqdZEUG0kdX2E0G1g5FdY+O0LKrM2iH9Mekb+tY+egSYCjc5y9yXRkezW?=
 =?us-ascii?Q?SDQ5tOGf9vK4aza+ZEol4kBHYq3ZHXtVdr+4hyxzsW3KcNaog5wQMlPVqcDY?=
 =?us-ascii?Q?U1E4HGJUJq7Ue8Bjl20USZRGIcYnM0yXQTh4urA98TB6abG8CzBmkCANjoER?=
 =?us-ascii?Q?Ux9Ij5UYt+uq8NBKJ0yxOavVG7jEOqCEqzEPgiyyO23eBLMTL5AEzQVQ9uS7?=
 =?us-ascii?Q?pqSCqgK6YMIBN5MxCEYC8Hs5ukRHEKYo8EK1GXT6UlLBrTg/kKJq1Dz6HiYv?=
 =?us-ascii?Q?ix61RcSAgD5qUH/FBTPJuEVz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb64f3c5-146f-47d1-705d-08d8d9381029
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2672.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2021 02:50:08.7031 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5C+eNz3DV1EUJat1DI6iEBc/iUw26z9SQO6esIORdxogL7R59THJaFf4pmysoH7kiQ2l64Zr+HVa2QynDtU2LA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2670
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

Currently callers have to provide handle of amdgpu_device,
which is not used by the implementation. It is unlikely this
parameter will become useful in future, thus removing it

Signed-off-by: Ramesh Errabolu <Ramesh.Errabolu@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c  | 3 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h      | 3 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 4 +---
 3 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
index 2808d5752de1..e83d73ec0e9d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
@@ -359,14 +359,13 @@ static void amdgpu_dma_buf_unmap(struct dma_buf_attachment *attach,
 	struct dma_buf *dma_buf = attach->dmabuf;
 	struct drm_gem_object *obj = dma_buf->priv;
 	struct amdgpu_bo *bo = gem_to_amdgpu_bo(obj);
-	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
 
 	if (sgt->sgl->page_link) {
 		dma_unmap_sgtable(attach->dev, sgt, dir, 0);
 		sg_free_table(sgt);
 		kfree(sgt);
 	} else {
-		amdgpu_vram_mgr_free_sgt(adev, attach->dev, dir, sgt);
+		amdgpu_vram_mgr_free_sgt(attach->dev, dir, sgt);
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
index 927d33d75c22..028f200a3509 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
@@ -121,8 +121,7 @@ int amdgpu_vram_mgr_alloc_sgt(struct amdgpu_device *adev,
 			      struct device *dev,
 			      enum dma_data_direction dir,
 			      struct sg_table **sgt);
-void amdgpu_vram_mgr_free_sgt(struct amdgpu_device *adev,
-			      struct device *dev,
+void amdgpu_vram_mgr_free_sgt(struct device *dev,
 			      enum dma_data_direction dir,
 			      struct sg_table *sgt);
 uint64_t amdgpu_vram_mgr_usage(struct ttm_resource_manager *man);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
index b325b067926b..14936bc713b0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
@@ -734,15 +734,13 @@ int amdgpu_vram_mgr_alloc_sgt(struct amdgpu_device *adev,
 /**
  * amdgpu_vram_mgr_free_sgt - allocate and fill a sg table
  *
- * @adev: amdgpu device pointer
  * @dev: device pointer
  * @dir: data direction of resource to unmap
  * @sgt: sg table to free
  *
  * Free a previously allocate sg table.
  */
-void amdgpu_vram_mgr_free_sgt(struct amdgpu_device *adev,
-			      struct device *dev,
+void amdgpu_vram_mgr_free_sgt(struct device *dev,
 			      enum dma_data_direction dir,
 			      struct sg_table *sgt)
 {
-- 
2.30.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
