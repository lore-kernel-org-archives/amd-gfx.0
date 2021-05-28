Return-Path: <SRS0=bbC/=KX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F96AC2B9F7
	for <amd-gfx@archiver.kernel.org>; Fri, 28 May 2021 14:44:19 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0989611CD
	for <amd-gfx@archiver.kernel.org>; Fri, 28 May 2021 14:44:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0989611CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86E836E425;
	Fri, 28 May 2021 14:44:18 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2096C6E425
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 May 2021 14:44:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nypwzkwKghQZqfQjgzh/Vzv2fS1qCgKJVMcKy4312QIYeII1ncjtnqkVJZKGFro6qoXUw0eKTCD24LzGgBgVqTQoHoNiwIiqT020F7jA7qr5KE6Sl45rAA/cyAwdAXuI/DO8TT/pMfM74iCvw9CODo0ZwVwaTyMRqXenY3cGfSW6KqcNGUfCmKSRTLq9vfVXcw2b13wVbHzHsjUfMyjWx5A2RPXCLHl5w49BliyPIB+aWPamtEv0k1B5aME9ua2KNebXlGoYCDQKlwqJeJqpe4YCpL0YHoYlk2MT7Ow1e5zt0TcWs64oOmxVYwAUyR6HmsLlSIEH2r2xNn+Ku+wq4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O+MiZ9o2HJfq1DLpeGHFkdhRIMdpPpI2KQJ+e3N7bhA=;
 b=XwU9TPzCtcb3MO0rhQZpt0rIRDUXfaQaNFcoeaw0r8IMNMtlzzV11Gu6x3jbO/adlVMxQb8J3Sw6HE+RJ/jq0AWm0mlP9Umqbtbyy6noWfR/MLuRTz3TE2HItuMwqv39tXzk7RoAUvvnsOkIZwe5rJpcl7HcQQUn6C2WepNY8Nm9YI8zK4a+KIl0uAg7YN522L4Zoucx7wEFhpt4tAORrN9gyVB7w9e9ZPfPfBXZVH7/kzSHR467IaZLcs8NwpDorHISiYYkR5hR5RthSS6Nm3boT/1XTXqkPx9SpN+aszda7Cmza+o8l/tFGX5lxTMxkhjRyOHJjz0IdqfNG/gSrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O+MiZ9o2HJfq1DLpeGHFkdhRIMdpPpI2KQJ+e3N7bhA=;
 b=xoqVe1RW5XR4FYCyo/yw3DWRUMyeShn1pkzdFAtysYxxn4UY0pxoJhSc6uEztUW9Ts5b1qPHtjUC1X5OYl8nx0SxMsdj882RuLETEA8jdrTkZKSgQT6Y5hIUf71t+fGW06Izg2y6gnelXQkpDGm8YD/kqy+1ezWCCRrW80JggBs=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5136.namprd12.prod.outlook.com (2603:10b6:5:393::23)
 by DM6PR12MB5536.namprd12.prod.outlook.com (2603:10b6:5:1ba::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.21; Fri, 28 May
 2021 14:44:15 +0000
Received: from DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::4074:4943:244:a5fa]) by DM4PR12MB5136.namprd12.prod.outlook.com
 ([fe80::4074:4943:244:a5fa%6]) with mapi id 15.20.4173.022; Fri, 28 May 2021
 14:44:15 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v2 1/1] drm/amdgpu: cleanup gart tlb flush logic
Date: Fri, 28 May 2021 16:44:01 +0200
Message-Id: <20210528144401.14046-1-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.31.1
X-Originating-IP: [217.86.100.114]
X-ClientProxiedBy: PR3P189CA0057.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:102:53::32) To DM4PR12MB5136.namprd12.prod.outlook.com
 (2603:10b6:5:393::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brihaspati.fritz.box (217.86.100.114) by
 PR3P189CA0057.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:53::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4173.20 via Frontend Transport; Fri, 28 May 2021 14:44:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: be0f5a7b-9666-48e0-7dee-08d921e710d1
X-MS-TrafficTypeDiagnostic: DM6PR12MB5536:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB5536B5D5B9D40F7C862B93FB8B229@DM6PR12MB5536.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RnXqdnO085pG1vYirQ79poiWsCA6f7uKQj6OqJj0d9NV4sK1lQ9diaNfUIeuWlTqWC8tXvmlUUNj4NmR6jh9Sj4M+AumjXknY4PigX3yKKe9z053IfvopAUUG8Vro3lsQ1glVI7rg3WqKA4Lx/TbzNxnHWl3SE5MBKdCubn8btVxcsAMhah4Xcb8mx1IcuisDJpX0u5/nbaGYyv4C+5V4Wzw12w+FncB4QaVQWSOucnMlYGThuiP+tZTczg0Qo29nRmXr0Wgzvp3AxG3a59A4aUWVv8GSk/Gu5x6agTPV13/2vAthIaFTaAk5pkU49MrnN5/F6TVlbqjyaEDzCszl9r0oveKAHTVheT8E0tYbFph7IDQ7nbxqukgtOQy7z4cUFC8M3GbZe8v/49KW+PRrsYk+Ta/APdFm/MMcQcnVuDUpFb4tOgP/z4Od72SkdOcJAxFk7ofO6KBSTcJSMkYT92GG8DOna+cU2My6ytLklqDoRxBRseZMd+wSdVK0rPMun+QjgpgVHc9J+iDXmdF+Q9+sje5kU84nRAxgWpaVrRIkBxd/HeJkOlUpBngPa2fqC3c7+QcYg7nTbqNcg3u8wjoSFhZvxulvPsqZ0I3zTGBn9UEegGUqiFGmsLKG/8xRHMfIutJAz+xoMtiIf+mjjz4trm39viF2lOrDhMGLSI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5136.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(136003)(376002)(366004)(346002)(478600001)(6486002)(8936002)(38350700002)(4326008)(2616005)(6666004)(956004)(16526019)(186003)(38100700002)(316002)(6512007)(44832011)(5660300002)(86362001)(83380400001)(2906002)(8676002)(66556008)(66476007)(6916009)(1076003)(66946007)(26005)(52116002)(6506007)(36756003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?E1424GAOv9cCj9BTLQ9nS0BCkSqT4j/qNoTZ0N9LvKozgGZP2oAr31Vi+Q2A?=
 =?us-ascii?Q?WszoyREFD/mHhzD91y96hV23z2xd6576JUA7MliJxmmShlLAba6E/YeE+5te?=
 =?us-ascii?Q?z2Eo+bETUpTEixOY4/ZgTvzCzVakTjRSbLQKkJvP8KhnNucJLO4Q9ctM8/YR?=
 =?us-ascii?Q?ipLJ3lS2k5/iKrSAQIAQxWZpk+T4ZFm8FGWDaZHv4n7CgkM5iMvNcvx491Ec?=
 =?us-ascii?Q?0G9oTl4/39RpcEPrnRS6nHDT2F5t7lxXrFjMzmO586jgRPcPJXN408F3HdxE?=
 =?us-ascii?Q?5bUipch3mg6cieweOJYlgdA7J5KBEj8BDILbsqZO+o5zClJVmXCIQjXKDZ0Q?=
 =?us-ascii?Q?Z0BqyomvFDn0bDhNI+6KuZdxI1PY3tWb2UNGCMzBKgymuXi/TkAb5NGp6tVo?=
 =?us-ascii?Q?jy7QZx8keLAMvoLI7p9+SW/jG4DZFUg2f2x2bSE+csDBS8sQjXUj3dreoUCM?=
 =?us-ascii?Q?0IBK4wfj1XksC6d7zujJWJzO4D7KjEHhzfUz36pFTZbvHmnEeiEuYQtp40Ht?=
 =?us-ascii?Q?CA1t+4IYDT4YuHUXh+LRummfa1ArgT2VwLUk574RSXF4jBKY9ejQjQCTNSmW?=
 =?us-ascii?Q?gYa0xfDVSRIQ4W9/Qp2v54rC+yFZdW0yzTeGjeyeGsfk/xXtbzKU5cPxh1hc?=
 =?us-ascii?Q?/RzXkxum9lNQpr0f5ITlBZzMexAidsfB451VjGEK4/psPZMIOMKP73wRyrTw?=
 =?us-ascii?Q?xQPWqUOFuOThUHxh/NMaPgHH+IlquErp6Von/PMpSUCeJ3l3NCBjVfErTOyB?=
 =?us-ascii?Q?Y1j1AGy1bWDNreWFHkUX19FS49prwd1K+hCuR/ZZdLD3T5LZUjXzO6po5phf?=
 =?us-ascii?Q?01EXvcFZijlm5UNWdWB3ujrJKJRkT1FfQAXheQUKh656LThWKxZo3d9uu/Gj?=
 =?us-ascii?Q?EiKPbcHYrxEL6OGgGnriGH5jmpz509rbwKQU59rtODw8b42/A07A3pSUuS6i?=
 =?us-ascii?Q?RZFvCfsJP/U7NlzoZuuQ8pW9b073STU3ULMv7DrfJdlsj2gHtbMWcjUZjGOo?=
 =?us-ascii?Q?Q+yWIg3NWjXFPhXutf3A8u5NAcMVbocBIvfge+eKPlRLngYvHuFPLsT5G2UY?=
 =?us-ascii?Q?CXMAPjhoC9zJJ1zt+xhYX6YOsGQz7+Iv7vK+SIJN4kgFxE5lVNd6ejUPYBuX?=
 =?us-ascii?Q?lM9p5vfZvnjxErGZm1CDSuD42f83A4nGPjZ21rUz0Vn+gzAkhPJ0KX9jV10o?=
 =?us-ascii?Q?QPDAiSw8W9Vbc6q7cS4I4TTTAkSIfi8tCj8zsuSFD7RpZSdwEoZRZKGR8jfy?=
 =?us-ascii?Q?t5htU9KibeOtXU/8UYC06Bf9Q+9QR+JKFiFK43MwsPpOLuSHVShLLh00o1xO?=
 =?us-ascii?Q?GBOGe3IpqeYpOOu41T7lC50b?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be0f5a7b-9666-48e0-7dee-08d921e710d1
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5136.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2021 14:44:15.4366 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DN2gX1LzriPLcm3uzhwn57KaowJtNrc/3MgN/pndwBQncEyJyhwRSJQ17psOQrVAZgPOQyBA3DzSp/sSZnPcJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5536
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

Don't flush gpu tlb after recovering each BO instead
do it after receovering all the BOs.

v2: abstract out gart tlb flushing logic to amdgpu_gart.c

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
Is there a better way to get adev in amdgpu_gtt_mgr_recover()?

 drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c    | 20 +++++++++++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h    |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c |  6 ++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c     |  1 +
 4 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
index 5562b5c90c03..e2059f7ed639 100644
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
+ * amdgpu_gart_tlb_flush - flush gart TLB
+ *
+ * @adev: amdgpu device driver pointer
+ *
+ * Flush TLB of gart page table.
+ *
+ */
+void amdgpu_gart_tlb_flush(struct amdgpu_device *adev)
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
index a25fe97b0196..c853b70a24cf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h
@@ -66,5 +66,5 @@ int amdgpu_gart_map(struct amdgpu_device *adev, uint64_t offset,
 int amdgpu_gart_bind(struct amdgpu_device *adev, uint64_t offset,
 		     int pages, struct page **pagelist,
 		     dma_addr_t *dma_addr, uint64_t flags);
-
+void amdgpu_gart_tlb_flush(struct amdgpu_device *adev);
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
index 8860545344c7..b61a54f6d95d 100644
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
+		amdgpu_gart_tlb_flush(adev);
+
 	return r;
 }

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index c0aef327292a..5e514759d319 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1014,6 +1014,7 @@ int amdgpu_ttm_alloc_gart(struct ttm_buffer_object *bo)
 			return r;
 		}

+		amdgpu_gart_tlb_flush(adev);
 		ttm_resource_free(bo, &bo->mem);
 		bo->mem = tmp;
 	}
--
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
