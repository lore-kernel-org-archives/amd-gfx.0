Return-Path: <SRS0=bbC/=KX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AC17C47087
	for <amd-gfx@archiver.kernel.org>; Fri, 28 May 2021 15:54:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48689613B6
	for <amd-gfx@archiver.kernel.org>; Fri, 28 May 2021 15:54:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48689613B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2E3F6E4C1;
	Fri, 28 May 2021 15:54:40 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3552A6E4C1
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 May 2021 15:54:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GwIPbbTtu3ZxjI1f5KaQg5Zqpe4WDF5EEGV2bXtF0dovgapIjdeSB47uPxR8NUuFcaU8wF/va0PMY7z5zOMAomfpDaEUuyYvVe5F9eXwckmZWdu+LkjLMkz2d8V4QH7vb0nltlFlp8NM/R/NhVEcIqgvPZuAubJlb6HSYyv9VPoxbDhteD/LnzVdb2Aoimyy0a3vDMrRmPgW6CoPAOCt0dylTKkwNDZSv/h4g/Pkw/K24CjxXpesY24aI/sItSDqp5wUOSVkvBvbUlJPKG07tXSh1buBl86syhd4yXwxVrohDxuOHgfeDyYSv2yuJRujHz3hGUsiPe8FflMLY8n3lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GZx8gctuP43/g3m1T0Yo7OBTvSqSLKoomf9axGUTTaY=;
 b=EyMl0wGUZb95jh78mS8ljW3ANdt1yjH+pp/2ewjf/lnLOWpdc/X0PuL+MqP9ry/XXd8jj8ToeprcsC+2ng+lL82RS0vXLL/QhLxuxSil7p0ZVsTv1hZx/f/YPdBJjGTH9brLM5m5AraY+omDZMZsjcvQgeBKtYKwLL3P2uJjlEwb3SwyHLQVPW4b3iAN70UK5LKbIQ8wOZXHT0gwtr+A8CWw4W05rbtdPa3dkqeKDS67C8WUy0yHFGo/pid+oQ+Ku5Hy0/QHY7Si0LQjwbeFlYFmUIzqx4DinYq/hx84KqX5gLo5c2csU2Ep/OMp2RD1JuhdWRMerB49MTTIOSS6Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GZx8gctuP43/g3m1T0Yo7OBTvSqSLKoomf9axGUTTaY=;
 b=OdRk3GGLTj6WjTqv4hMtgJ5/p7LEwBEOQOKDmFvRwwNvHB0fFraGeqAUHV9658w1oqkmBkJFA1eY0mrAmXYVGswQtQqzyC1cDm62eOw7M6Fi8PdZGH8gD6O4+5AlSqP/vxg2kR9v3T8iOGVXugRvH/DGldWo5f1uVdIJv8Q4AHY=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by DM8PR12MB5398.namprd12.prod.outlook.com (2603:10b6:8:3f::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4173.24; Fri, 28 May 2021 15:54:38 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::4074:4943:244:a5fa]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::4074:4943:244:a5fa%6]) with mapi id 15.20.4173.022; Fri, 28 May 2021
 15:54:38 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v3 1/1] drm/amdgpu: flush gart changes after all BO recovery
Date: Fri, 28 May 2021 17:54:28 +0200
Message-Id: <20210528155428.75487-1-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.31.1
X-Originating-IP: [217.86.100.114]
X-ClientProxiedBy: AM8P191CA0017.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:21a::22) To DM4PR12MB5136.namprd12.prod.outlook.com
 (2603:10b6:5:393::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brihaspati.fritz.box (217.86.100.114) by
 AM8P191CA0017.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:21a::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4173.20 via Frontend Transport; Fri, 28 May 2021 15:54:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 93498cfc-4c6b-4338-26a4-08d921f0e61f
X-MS-TrafficTypeDiagnostic: DM8PR12MB5398:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM8PR12MB539848E68693CA3BBC789CE98B229@DM8PR12MB5398.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W1lysdf2Bra5ol+Cx4vCG2UZmGbfT4V2TL9HuBZOUgX/CTYf2SB22DVCKEo+WLEpMytADiL3It+78XGCnIEpNSfwJcRhzxBdP3zWUNoJ6vIkMEQA6E4Puk70uj447Ji95POhLDF4SuPbaz5do40lXrml2mC24EdkMMHYYB5IC8712H4XD//tYK7pqF9ZcuV6bsg5bKrAnWsTxxwCVp9d/qAndFim8Yn/VqajmvNq9Aw7h5yM02u3F6t0ZSFLln9JZCXdqAmEQIxaSQ6CIwJgrzw53tfNycHza47zumeMFTKmNGLqXGrqvZfBr9xwMVJec9j30+9zbcya0Ygcs2NhQJb9zPqEatnmWwtnbCYD214IiSS9r5Yvm6rG88Sk1TuIYSPPERYIqQFMHtwjtBndvzEwHuKdW9HzNTu9zBA7HqyqEEThcvCp3LtNsyqpzDZ8pTqDN2vm9/23dFD3wR8RjFQlB1CseXdsQPps7UjXh4XumBtvcjUpjemzo4zYdOHsla0zJJjkhNOn5KjBZgZyglmZILFWftzoHLqOZTnhHikmd8McY2w3nz247Twb0+YnVdwLbCElkc1bliZZdROJTKWzBKvmpvyoolLpWHq8JexojEVB0MNmOoQ3GhxA9BHxfShvOhkewb6a5NOta/9RbYOVOhRC0X/mwuA4yAqh9Ww=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(36756003)(44832011)(26005)(52116002)(6506007)(6916009)(83380400001)(8676002)(1076003)(498600001)(6486002)(6666004)(66946007)(66556008)(66476007)(4326008)(5660300002)(8936002)(2616005)(6512007)(956004)(2906002)(86362001)(186003)(38100700002)(38350700002)(16526019);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?g0pMQQZ/2sJYXUON60aTuz1ddOfKTAmVbrfreey2cCfZuazFwv/6xy9INqnq?=
 =?us-ascii?Q?Ah3ePmOjoVLYXjezgwxAOiZBJshcDUvGTKki2nCFlxBNAdRupGyaZqV2KxNR?=
 =?us-ascii?Q?mH/WwnzcNzOJjLs+0CaIxa5Icrd9lMYIZLB9ZewwoQC6fW7meHnVPEuoMdJX?=
 =?us-ascii?Q?S9toptdK8zqa0CQcEkgLbpUAiES7w9nZXr76Qs6/bEX5k9lXFME6khT3gNqL?=
 =?us-ascii?Q?YrceBJfeu4K454fJsna/CxC01opEGW+Vf3yLVMwuHcjdeV4S3fpgEP9FqKuH?=
 =?us-ascii?Q?aVnKVniUv7oTxittInuUaIWu8+sGDtKgb3sS0nuzq/LlvG00Mzb1kBbCAm0H?=
 =?us-ascii?Q?WiB6RJ3ZvoKwWAYwgKcPyYbFKemHhkdm6Dtp84uUo3P1gVwWrpJPCzNUcIU9?=
 =?us-ascii?Q?jM7JufNyXh2eAC9PBquQ27IunYEcAunV79wd7oklokkki1hz6hd128iEy975?=
 =?us-ascii?Q?NIoEhlsqJkoRiD6C5lFQ4QGRdZ43to7XhXCFTSPXoiaXaapBEup7XOn6Onn/?=
 =?us-ascii?Q?YaBRyae77aLDmJ/lj+oTplknq4wHSdpzIy9cEPU20hrHN1XzFwTFyg51k2ge?=
 =?us-ascii?Q?ILx41EaSFAtCpvHX8hhABzkibfLZYe35caitL2DZLmtmDSpUtwnjcskGhHU1?=
 =?us-ascii?Q?T2YRHbDfzDEdjZa7BXurLWxXYk4enleiu055ghvOTa7voPu4n8YsOjkJX03g?=
 =?us-ascii?Q?daNIkjpx9W2fxQ9M/+2S7AFz2ag7rd0BnTel9dM4ldHinWI2FUeTdXiRKcr0?=
 =?us-ascii?Q?tnAMbB493i7vo6JbGOrW9SCh7NFk6N44oOdzGd0SrVertor/2DI16YAyORvs?=
 =?us-ascii?Q?1h0vQzLEK7RVwxlV77T0auezn1o6BzfVWLt6Mj2Wm8bGgtaVmQkHGGiX+Qqz?=
 =?us-ascii?Q?YGbI1KzV5DMcZwpled+9p6vng3tILgFdvDnV4193dCwVCG0MkIVcUc94zzaA?=
 =?us-ascii?Q?MPx1AGZhfo+cL2SIB72pc78pGPu29lP9IOe2NlT29vdDAAV0e02jhNEEjDsR?=
 =?us-ascii?Q?YXFVl0l94Zve/k6ZIHAPGrD5/gVM0UqDSzVnohEqSSmQXaHKzHbpRZNCB+ZR?=
 =?us-ascii?Q?fPc16QdIB8ihcxEjCGwuYyZcxi9qQV9hwp0MXSwNuBbsgNCH9yr+2dvP6dXB?=
 =?us-ascii?Q?qkSIm/Zk6uE/3yKR9FRfLNvS4+//LzdkuDnuIT6wwL4xxnwhl6J40IkmRToL?=
 =?us-ascii?Q?GqXD/SbEGzYzlCb9ocGETLxodFMgg4hcpPnolhiwE/WTGMUUUZNj5rYiAsK3?=
 =?us-ascii?Q?6GnIbV9Qenj407K2fQ+Depy+c5RukBIFwRiRJlVs2ZNZXwBG2D0Kjae9AZtM?=
 =?us-ascii?Q?kYk9rGwXPITeMDjVlzlYiQ+z?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93498cfc-4c6b-4338-26a4-08d921f0e61f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2021 15:54:38.7728 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /IL8BIirMPTTsc/MHB394XMFzD6D2G+mxIdAZrjU+UbNXPKX6dtifiYHFDNEASupHW2xV6+UZHjn1c3WYZv0Pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5398
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
Cc: Nirmoy Das <nirmoy.das@amd.com>, Christian.Koenig@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Don't flush gart changes after recovering each BO instead
do it after recovering all the BOs. Flishing gart also needed
for amdgpu_ttm_alloc_gart().

v3: rename amdgpu_gart_tlb_flush() -> amdgpu_gart_invalidate_tlb()
v2: abstract out gart tlb flushing logic to amdgpu_gart.c

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c    | 20 +++++++++++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h    |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c |  6 ++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c     |  1 +
 4 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
index 5562b5c90c03..992b59c29dd7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
@@ -322,16 +322,26 @@ int amdgpu_gart_bind(struct amdgpu_device *adev, uint64_t offset,
 	if (!adev->gart.ptr)
 		return 0;

-	r = amdgpu_gart_map(adev, offset, pages, dma_addr, flags,
-		    adev->gart.ptr);
-	if (r)
-		return r;
+	return amdgpu_gart_map(adev, offset, pages, dma_addr, flags,
+			       adev->gart.ptr);
+}
+
+/**
+ * amdgpu_gart_invalidate_tlb - invalidate gart TLB
+ *
+ * @adev: amdgpu device driver pointer
+ *
+ * Invalidate gart TLB which can be use as a way to flush gart changes
+ *
+ */
+void amdgpu_gart_invalidate_tlb(struct amdgpu_device *adev)
+{
+	int i;

 	mb();
 	amdgpu_asic_flush_hdp(adev, NULL);
 	for (i = 0; i < adev->num_vmhubs; i++)
 		amdgpu_gmc_flush_gpu_tlb(adev, 0, i, 0);
-	return 0;
 }

 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h
index a25fe97b0196..e104022197ae 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h
@@ -66,5 +66,5 @@ int amdgpu_gart_map(struct amdgpu_device *adev, uint64_t offset,
 int amdgpu_gart_bind(struct amdgpu_device *adev, uint64_t offset,
 		     int pages, struct page **pagelist,
 		     dma_addr_t *dma_addr, uint64_t flags);
-
+void amdgpu_gart_invalidate_tlb(struct amdgpu_device *adev);
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
index 8860545344c7..b01bc2346082 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
@@ -205,6 +205,7 @@ uint64_t amdgpu_gtt_mgr_usage(struct ttm_resource_manager *man)
  */
 int amdgpu_gtt_mgr_recover(struct ttm_resource_manager *man)
 {
+	struct amdgpu_device *adev = NULL;
 	struct amdgpu_gtt_mgr *mgr = to_gtt_mgr(man);
 	struct amdgpu_gtt_node *node;
 	struct drm_mm_node *mm_node;
@@ -216,9 +217,14 @@ int amdgpu_gtt_mgr_recover(struct ttm_resource_manager *man)
 		r = amdgpu_ttm_recover_gart(node->tbo);
 		if (r)
 			break;
+		if (!adev)
+			adev = amdgpu_ttm_adev(node->tbo->bdev);
 	}
 	spin_unlock(&mgr->lock);

+	if (adev)
+		amdgpu_gart_invalidate_tlb(adev);
+
 	return r;
 }

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index c0aef327292a..786650a4a493 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1014,6 +1014,7 @@ int amdgpu_ttm_alloc_gart(struct ttm_buffer_object *bo)
 			return r;
 		}

+		amdgpu_gart_invalidate_tlb(adev);
 		ttm_resource_free(bo, &bo->mem);
 		bo->mem = tmp;
 	}
--
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
