Return-Path: <SRS0=yskd=HN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC6FDC433DB
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Feb 2021 14:39:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FB2864E77
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Feb 2021 14:39:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FB2864E77
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB5826E432;
	Thu, 11 Feb 2021 14:39:22 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2085.outbound.protection.outlook.com [40.107.244.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D87656E432
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Feb 2021 14:39:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jsOSZfiDDOCsIyNiPqxu0Kpfdx5zd0Ab2wsLxibbRJczptssY2OyQw6JTkIWere7h5KJDKUtlD9NkLVCCXGknKsuPYh+i2ajHx1lhrHBW4PoEePbNCVqj+FmogGYY/YWYLFKmua6LpDTyhoPj46SIst5644gofMWl+l6ye5BLaCSzJFrNVuecX8ezHu+MZAkaBiWdWOP1eKWWCohty8ANivV4cZ3D6PoD74Rr+4p6RrusC2UcsvQBtCTOqRjsRmdDv7zttv+/o4/jgM7zCUUh/Zpu/spDzOtIGDsPMbMzj15s5mcquU4LI8Dvu+FZIuizKaxyLVW6YQ+9h7M9poIpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yFkKzuB0GoiyyTUZmTnakIWqXIE9G3puC9vQZQuUJMw=;
 b=aYodPKV/0M3oQ4FNtv/cQsjjMNwH88i2bXJg5cVxP+6ErGabSSNJ1OAJbxhH1h9IZPRTX14Gmx/45UuH/Aut99sPjCh2Y7+qkAagjHlfrFR2/ZeXQ8kmzXWJQNz/Tj7Q5jIZv3X88rpiwlFrHk4krmZOvgUA6e5j00YR1V6FG8yF8OGRY0QzfYzXnc1JNoqe3709fMcMjB3K9dCJcL+dToAQ+lNGFfzw9B55n2riunnl45Y5P7yoRrCSVUFBU82i5PTZ1nlfFXZr1tKvbQLLTGYF1Lh/1sHUtSOsLOwqq/hyUUwgIu0FrU25HhjOb7x4WfLBEK+NINEvDNACgiXxEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yFkKzuB0GoiyyTUZmTnakIWqXIE9G3puC9vQZQuUJMw=;
 b=YX39SIO6siveKoGnGiJ1yQOV4A5eziFfg6VRIGxxCw76I7E/Dti0CZDy91wN/MJV8lpslv7jw2xO2Z8k/yzA0elmY/wbmbk3m7DF6J/Zr8qchRYWYBn95GNUXSuldoWH0EgSqn5HD8xmPaxbhl7rS3aFwlUHA3WakjWJ51dsGEw=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3916.namprd12.prod.outlook.com (2603:10b6:5:1ca::21)
 by DM6PR12MB4731.namprd12.prod.outlook.com (2603:10b6:5:35::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.27; Thu, 11 Feb
 2021 14:39:19 +0000
Received: from DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::452c:77af:fea7:a633]) by DM6PR12MB3916.namprd12.prod.outlook.com
 ([fe80::452c:77af:fea7:a633%6]) with mapi id 15.20.3846.027; Thu, 11 Feb 2021
 14:39:19 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: Christian.Koenig@amd.com
Subject: [PATCH 1/1] drm/amdgpu: remove CONFIG_DRM_AMDGPU_GART_DEBUGFS
Date: Thu, 11 Feb 2021 15:39:02 +0100
Message-Id: <20210211143902.73181-1-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.30.0
X-Originating-IP: [217.86.97.172]
X-ClientProxiedBy: AM4PR07CA0007.eurprd07.prod.outlook.com
 (2603:10a6:205:1::20) To DM6PR12MB3916.namprd12.prod.outlook.com
 (2603:10b6:5:1ca::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brihaspati.fritz.box (217.86.97.172) by
 AM4PR07CA0007.eurprd07.prod.outlook.com (2603:10a6:205:1::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3868.11 via Frontend Transport; Thu, 11 Feb 2021 14:39:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0f107fbf-dbeb-4cba-baa9-08d8ce9ad04b
X-MS-TrafficTypeDiagnostic: DM6PR12MB4731:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB4731679D4E905081FA5956FC8B8C9@DM6PR12MB4731.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vdjNJW/R3+Vp8/xtqP8JL/RZ+dYMBbc+Shw1G1W96N9BXdCXKvKQSFsRKD6EPQMKZlHbMYTA0WrM3leoGh9HwVWtnIWyr3P0NO8AJEm7GJtps2buh7Sdvey5mMJbzj/jCTrBH/zr7NnTsEeYMjobAY/ub4XzgVnyKf+IbefD7981mzoi5ytKF0laq40iIoVYoqTunjQwRdWhew28US8ylg4dBLG+EgJbGO6OZqMwzMTrcUTzMUEq8AXAgjybxzIEj/NYim4OyOzI3QXB0pwLmBdOZXftgawJgL8+LR+GgYGiT93Csz2sRsqEbuzDRwdQnwYo7OpE7xI5Nmpwx7W4rUpz5vlUvevZ3jtMxVQM3yrIFjXqlMNXLD0rpWZny4iwHUAflHI/4tHdJwEgnPy3yUpZT8glD8YHPi7ITgXmzO1svpnNR756qZl8sevm3iNYcJHy+JOKdVNRDHbBNATS1OapKhN/rfXyfaw5cQzWMlC1GdDMUkB7oWvxBwzXrOl7W2fKK5JOiGGQxwgcFCEBuQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3916.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(346002)(376002)(396003)(39860400002)(2906002)(86362001)(44832011)(36756003)(6486002)(2616005)(956004)(16526019)(83380400001)(6506007)(186003)(52116002)(26005)(1076003)(6636002)(6666004)(34206002)(5660300002)(4326008)(6512007)(478600001)(37006003)(316002)(8676002)(66476007)(66946007)(8936002)(66556008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?WKvfuUTMtb8QQkvstX3WlpcALm1/GQ2UzHofd4FzdSCSqmXqGP3tdcaANhsu?=
 =?us-ascii?Q?xBBE6yATsPGlYIHsTpW6r8jN83KLVR+GlKFhT668LhDlOL8wXtNBYxSLCcHD?=
 =?us-ascii?Q?DjjazGoAEub9lgZ0lhKbPgOotSZixqdv1dkRc95bduFJcrUZOYSHSm/SHTBi?=
 =?us-ascii?Q?VaJZ47GR/9EXY2o3bW6E4xedeKUBO7/3x1dVWR1CVnlTegDG7wGqsIaRpL1D?=
 =?us-ascii?Q?WJ+sedi46AHvF9tHQUYbtOiUV/Lq6ytPk7/VJ42D4Mdm2t6TWSwLt15YMjKa?=
 =?us-ascii?Q?x8OdOxbd/Hc3oy5su4RERC93dL/CTP1xCAnc+EN/hXZmEwJIdhX/nb1A1rGp?=
 =?us-ascii?Q?eHflRtD1TFzDzLWYBcvy8jsqL/BN5RCRdm+kVbJgsQ+dciAlfW57/nr1TaZG?=
 =?us-ascii?Q?rfzDT0SBJfuJVmOT3R5b+dEll2R40md8QsX7D+YnMcOfDdtxCAdoe9DjyzoT?=
 =?us-ascii?Q?XqdXis+HggKIwXq5qatFD1GZub3WD+6omxCz9cl+SJ0UWsnOt0PiRUqp4LFJ?=
 =?us-ascii?Q?DoRFKWgd9Q7I9mDDilqfeTGbNJY5gC0TbSeZclZraONOCKpHifBs+L0+NZkr?=
 =?us-ascii?Q?xbCTlTRn5jPIfZLlndxvpcmrYcisjck13JVUwhL2IvOQ7I6phqMoXOCGL52/?=
 =?us-ascii?Q?71AYmpEwAhhD7lUk/W3YqRIdNEzuJ7DXc4puSxtoFPASUyAQ9RFyiAGNdBKP?=
 =?us-ascii?Q?e/ujQMPjpFs9pL7ullMrtaHEf+dSY7Fm+R7V5DF6IazfFHlxcmD2DNol8HUz?=
 =?us-ascii?Q?QyG3Tlb0LODYjjLDV/rivU7A6DLw01cbULveHk1/r7Bd8vLTM5G5xe4rYpTp?=
 =?us-ascii?Q?lyWDaTUK6qS33pB7BQAFbGGO5+YkLtGRN54g/gjME1KYS0a5riduSZf1Ak/B?=
 =?us-ascii?Q?hXKoi8ErdoFbshe6wxvEZAllfamLKYQ7nukup6FKLzRwgVYSP8m7J1aOaNjL?=
 =?us-ascii?Q?go8MX9TlQ+Np5cyN1Av3oJvo1wi88whAy3aF0Hrgh85m1O3OVL23rDY9Gkc/?=
 =?us-ascii?Q?nSZkNxcCYw+czS6eMHd9Km7MvLbTPuihHCzLzSvkBQ59lIRjqhFrVgSgEow0?=
 =?us-ascii?Q?H7yoMYOgHEsBrggexhUBbpoA60VW2zNjej0r2TEfuPSCm034BE8I9REXHfnf?=
 =?us-ascii?Q?qTL75GamOOCZ0sMZBwNodvGPpWx/gIu0q8K4828+38Sw5EqDq27TUa+bmxnF?=
 =?us-ascii?Q?XOJZD6ZNgKruYvHjgHtG6gUzB7W4RUJxx9tNsc6HDss3ieQvkiQZr4TY4AGX?=
 =?us-ascii?Q?AlIaXNRX4wAzgX8+iVgWUWhOItlisP7gQgTsyDXjP2DtytCh7ArBGdqQ/tGb?=
 =?us-ascii?Q?ND2gYZQ2SemisjVgn0ZndH2V?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f107fbf-dbeb-4cba-baa9-08d8ce9ad04b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3916.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2021 14:39:18.9523 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1WfG63ZaopxVGhupGCF3cy9sKyE36ooQUUD4j8o0Yh5qn9e688qrKzSDjWq4GeypVJG+RJjhms25vsnj3jS80w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4731
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
Cc: Nirmoy Das <nirmoy.das@amd.com>, amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Removed unused CONFIG_DRM_AMDGPU_GART_DEBUGFS code.
We can used umr instead of this gart debugfs.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Kconfig       |  9 ----
 drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c | 25 -----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h |  3 --
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c  | 57 ------------------------
 4 files changed, 94 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/Kconfig b/drivers/gpu/drm/amd/amdgpu/Kconfig
index 9375e7f12420..74a8105fd2c0 100644
--- a/drivers/gpu/drm/amd/amdgpu/Kconfig
+++ b/drivers/gpu/drm/amd/amdgpu/Kconfig
@@ -34,15 +34,6 @@ config DRM_AMDGPU_USERPTR
 	  This option selects CONFIG_HMM and CONFIG_HMM_MIRROR if it
 	  isn't already selected to enabled full userptr support.
 
-config DRM_AMDGPU_GART_DEBUGFS
-	bool "Allow GART access through debugfs"
-	depends on DRM_AMDGPU
-	depends on DEBUG_FS
-	default n
-	help
-	  Selecting this option creates a debugfs file to inspect the mapped
-	  pages. Uses more memory for housekeeping, enable only for debugging.
-
 source "drivers/gpu/drm/amd/acp/Kconfig"
 source "drivers/gpu/drm/amd/display/Kconfig"
 source "drivers/gpu/drm/amd/amdkfd/Kconfig"
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
index 0db933026722..23823a57374f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
@@ -236,9 +236,6 @@ int amdgpu_gart_unbind(struct amdgpu_device *adev, uint64_t offset,
 	t = offset / AMDGPU_GPU_PAGE_SIZE;
 	p = t / AMDGPU_GPU_PAGES_IN_CPU_PAGE;
 	for (i = 0; i < pages; i++, p++) {
-#ifdef CONFIG_DRM_AMDGPU_GART_DEBUGFS
-		adev->gart.pages[p] = NULL;
-#endif
 		page_base = adev->dummy_page_addr;
 		if (!adev->gart.ptr)
 			continue;
@@ -312,9 +309,6 @@ int amdgpu_gart_bind(struct amdgpu_device *adev, uint64_t offset,
 		     int pages, struct page **pagelist, dma_addr_t *dma_addr,
 		     uint64_t flags)
 {
-#ifdef CONFIG_DRM_AMDGPU_GART_DEBUGFS
-	unsigned t,p;
-#endif
 	int r, i;
 
 	if (!adev->gart.ready) {
@@ -322,13 +316,6 @@ int amdgpu_gart_bind(struct amdgpu_device *adev, uint64_t offset,
 		return -EINVAL;
 	}
 
-#ifdef CONFIG_DRM_AMDGPU_GART_DEBUGFS
-	t = offset / AMDGPU_GPU_PAGE_SIZE;
-	p = t / AMDGPU_GPU_PAGES_IN_CPU_PAGE;
-	for (i = 0; i < pages; i++, p++)
-		adev->gart.pages[p] = pagelist ? pagelist[i] : NULL;
-#endif
-
 	if (!adev->gart.ptr)
 		return 0;
 
@@ -373,14 +360,6 @@ int amdgpu_gart_init(struct amdgpu_device *adev)
 	DRM_INFO("GART: num cpu pages %u, num gpu pages %u\n",
 		 adev->gart.num_cpu_pages, adev->gart.num_gpu_pages);
 
-#ifdef CONFIG_DRM_AMDGPU_GART_DEBUGFS
-	/* Allocate pages table */
-	adev->gart.pages = vzalloc(array_size(sizeof(void *),
-					      adev->gart.num_cpu_pages));
-	if (adev->gart.pages == NULL)
-		return -ENOMEM;
-#endif
-
 	return 0;
 }
 
@@ -393,9 +372,5 @@ int amdgpu_gart_init(struct amdgpu_device *adev)
  */
 void amdgpu_gart_fini(struct amdgpu_device *adev)
 {
-#ifdef CONFIG_DRM_AMDGPU_GART_DEBUGFS
-	vfree(adev->gart.pages);
-	adev->gart.pages = NULL;
-#endif
 	amdgpu_gart_dummy_page_fini(adev);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h
index afa2e2877d87..a25fe97b0196 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h
@@ -46,9 +46,6 @@ struct amdgpu_gart {
 	unsigned			num_gpu_pages;
 	unsigned			num_cpu_pages;
 	unsigned			table_size;
-#ifdef CONFIG_DRM_AMDGPU_GART_DEBUGFS
-	struct page			**pages;
-#endif
 	bool				ready;
 
 	/* Asic default pte flags */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 27abfbc480fc..ce92768cd146 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -2364,58 +2364,6 @@ static const struct file_operations amdgpu_ttm_vram_fops = {
 	.llseek = default_llseek,
 };
 
-#ifdef CONFIG_DRM_AMDGPU_GART_DEBUGFS
-
-/*
- * amdgpu_ttm_gtt_read - Linear read access to GTT memory
- */
-static ssize_t amdgpu_ttm_gtt_read(struct file *f, char __user *buf,
-				   size_t size, loff_t *pos)
-{
-	struct amdgpu_device *adev = file_inode(f)->i_private;
-	ssize_t result = 0;
-	int r;
-
-	while (size) {
-		loff_t p = *pos / PAGE_SIZE;
-		unsigned off = *pos & ~PAGE_MASK;
-		size_t cur_size = min_t(size_t, size, PAGE_SIZE - off);
-		struct page *page;
-		void *ptr;
-
-		if (p >= adev->gart.num_cpu_pages)
-			return result;
-
-		page = adev->gart.pages[p];
-		if (page) {
-			ptr = kmap(page);
-			ptr += off;
-
-			r = copy_to_user(buf, ptr, cur_size);
-			kunmap(adev->gart.pages[p]);
-		} else
-			r = clear_user(buf, cur_size);
-
-		if (r)
-			return -EFAULT;
-
-		result += cur_size;
-		buf += cur_size;
-		*pos += cur_size;
-		size -= cur_size;
-	}
-
-	return result;
-}
-
-static const struct file_operations amdgpu_ttm_gtt_fops = {
-	.owner = THIS_MODULE,
-	.read = amdgpu_ttm_gtt_read,
-	.llseek = default_llseek
-};
-
-#endif
-
 /*
  * amdgpu_iomem_read - Virtual read access to GPU mapped memory
  *
@@ -2543,11 +2491,6 @@ int amdgpu_ttm_debugfs_init(struct amdgpu_device *adev)
 
 	debugfs_create_file_size("amdgpu_vram", mode, root, adev,
 				 &amdgpu_ttm_vram_fops, adev->gmc.mc_vram_size);
-#ifdef CONFIG_DRM_AMDGPU_GART_DEBUGFS
-	debugfs_create_file_size("amdgpu_gtt", mode, root, adev,
-				 &amdgpu_ttm_gtt_fops, adev->gmc.gart_size);
-#endif
-
 	debugfs_create_file("amdgpu_iomem", mode, root, adev,
 			    &amdgpu_ttm_iomem_fops);
 	count = ARRAY_SIZE(amdgpu_ttm_debugfs_list);
-- 
2.30.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
