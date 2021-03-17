Return-Path: <SRS0=2fSF=IP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D852EC433E6
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Mar 2021 07:47:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EF9964F97
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Mar 2021 07:47:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EF9964F97
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A3DB6E4D4;
	Wed, 17 Mar 2021 07:47:38 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C70256E4D2
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Mar 2021 07:47:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UuZfGp+1epCG5iAiiiyqtlGwwywCcP6Ag9wgVQuLgZ4ZinBkVivItDcfPFNf5KyymavTR+3vuOKDoPOQppHcCoNFYnWqUzIRvgjuLbE6Vppg1VjpHKcQm+O1e8sdS4FsUvaaqbe0DZ/zBR5AEN2MWz2ml2J5Grm6hKQpF0UjyoazJINrV/bMFOwNuu9sxje/SvYZcQMoBpBfBAe3azx3/Iaf5csvWnOUwAxmwcaVCOqXRAxtum6kuH7Tz7PXf4S1KvU3Iwnt7dQfr48SSIjFmjQpZCt/EXEW5yczU60QzvB3cgG5mrezGP6dbO/RbXPcmXQ4MVVhexNA2xayDy8JNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SKEi98WdiD3+JKEbLYv3WHLrtyaUpc6Mj+vRV4KB8qk=;
 b=X/JR+8FITeHbz7VvtAZ3ek3/xYLKt9w6HI/mKUZ6AVBcBR8H3ZWMBOnydh/FzYla8V9C115ZKXvWMonSermHUQujUl1lLjijLWctMCRM1qjGlvD7boc+sXc9eHaVgfPYeE+5p/WzLr8ZUwARvDZyXxufTO4+OtXiRasH7L0jNKhf/QyErwoJzhis51YDUdz0804t402BHDJGqyXzGNoLAwYDIPNfihgul1ij4R30jM7dJbiizUP3RRyEgLvLZKd1MPaq6rKbS7jLBMnFS06w5prebdBnyk+GTJMEbCZL/zvJSohJ5ZxWU55GaOCkHlndBXNHoJdKzCza6OUwhzbz8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SKEi98WdiD3+JKEbLYv3WHLrtyaUpc6Mj+vRV4KB8qk=;
 b=fGmueyCXvAkCr65TLIRlm4sGQFDJ9pp5VZa+FF/xCfEYbcMeOOjLhZWgNEGxElaP+5gUvnrC36AhR1NRlM3+HwnmUABjkI9p6vbjAUyRJAtifLpdSGBakezGOWPhyJAkuCEQH5mlDmFd9iAjGOUKeK+tX8H0gXoEfeT7a2sCmlQ=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from CY4PR12MB1463.namprd12.prod.outlook.com (2603:10b6:910:e::19)
 by CY4PR12MB1847.namprd12.prod.outlook.com (2603:10b6:903:11c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.32; Wed, 17 Mar
 2021 07:47:33 +0000
Received: from CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::6504:7fc4:d02f:77f2]) by CY4PR12MB1463.namprd12.prod.outlook.com
 ([fe80::6504:7fc4:d02f:77f2%3]) with mapi id 15.20.3933.032; Wed, 17 Mar 2021
 07:47:33 +0000
From: Nirmoy Das <nirmoy.das@amd.com>
To: Christian.Koenig@amd.com
Subject: [PATCH 4/4] drm/amdgpu: use amdgpu_bo_dmabuf for shared prime count
Date: Wed, 17 Mar 2021 08:47:16 +0100
Message-Id: <20210317074716.5547-4-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210317074716.5547-1-nirmoy.das@amd.com>
References: <20210317074716.5547-1-nirmoy.das@amd.com>
X-Originating-IP: [217.86.96.184]
X-ClientProxiedBy: FR2P281CA0014.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::24) To CY4PR12MB1463.namprd12.prod.outlook.com
 (2603:10b6:910:e::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from brihaspati.fritz.box (217.86.96.184) by
 FR2P281CA0014.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:a::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3955.10 via Frontend Transport; Wed, 17 Mar 2021 07:47:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2e06820e-41d5-44b4-d292-08d8e918ec94
X-MS-TrafficTypeDiagnostic: CY4PR12MB1847:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB18472A79E417ADC195F999708B6A9@CY4PR12MB1847.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xb3ef/CR7g+U68WxVsUv32CRn387d/GswBRfSui90+0E73xQ0xDRHjEsMwFQwviN0xfbm8EtsbkEbPtDaY29yBsR4ePB7bfbVkxE1i7vrrR36cNdbSRXo+k48GbcH1qufn4aDqFiw/hgdl+KaJyJTymqJ5prqJbKIJuD3MiBrCVpfF0H6jAiRW7Cvj1+1Glzfnk6tM7GzffwsqFn7butO49EjbvMhvyR2jQzvhs1bTUdDMZp2UIgf/V95DiwBR4uWlkmURhtVurz60q2cGlpib8LZwaW4h9gv7TVouSIuAmA2MYemr3CtoOc35V99PKUYVVgF0z1I9VieX77TawypnpQ37S8L8NPTa+GQGbmRBNgGifuSIBt1BUhEe9khotT4EF5ZnXBDlMBQfkKrprNTwwfFabRWSL5F3oWu6AE/rZuedaNuc50Hb1kGDnl1H7ZUVjwqeT7g6ob+KOeu3nTp/YIltNyg3zQwv3NOheyyvD9bliG5US3MbOfQb9LM8CZ5cB6apLEPeyL+Z5xxeF47eHokPQdbhG59+Nws6bUINsteY+vOjVe6n9rl5+3N0MX
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR12MB1463.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(376002)(346002)(396003)(136003)(39860400002)(37006003)(316002)(1076003)(8936002)(66556008)(52116002)(478600001)(6506007)(34206002)(36756003)(4326008)(6636002)(6512007)(5660300002)(2616005)(6486002)(86362001)(66946007)(6666004)(186003)(16526019)(8676002)(26005)(2906002)(44832011)(956004)(66476007)(83380400001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?78Tqx9+4/4ZqwPXQh3qRuQ6AQ17iVTjzpG6uQ15c4BJj0jLl4zag45QdwXwL?=
 =?us-ascii?Q?A+1mUyuL+KtNf/4erCD9Lrb9KYGMYn2O/7Llu/hHJGzIikhne03VEYijTKOr?=
 =?us-ascii?Q?qifbmddYaVB5kA9j/xcuqM765HN2rhBw8WErvn1jl6FTPZMkTeus4adMckk8?=
 =?us-ascii?Q?14qTUUpKBB3ZunanbDadweCFKwx24wibojHsQDkPuLdaao+7m4Ru2XY4KzTj?=
 =?us-ascii?Q?ZoqOooA6kdap+RmS/mP7umjSNGuVoOt63p+LitaT9SWt+RxvUB61hegGLXLf?=
 =?us-ascii?Q?+AiQihYTQwJbSuVjO85Qz5XdCsKlNvFLsX+9QCePuVH8slebjZM/6Buwtob2?=
 =?us-ascii?Q?p0WDtwrDyzBTp+Ga46LKcxvlPUEunvzOAfohm8KYt2c11eAhqaT6nVvQ4BVj?=
 =?us-ascii?Q?H9wrwER7Y6QG7za5XzMAhNxrEX/EAfHsfkGt9bp4FTq8imY++fylOPPru9cP?=
 =?us-ascii?Q?HTTP9BI0aY63+WWHLhhMZkTivdNJCzZ52RT70d0Q4M8BeWiUzDgK5XyYXUNd?=
 =?us-ascii?Q?Q6oOEGjUF99bvdfWYWJuhWlzllDd8+XE3+qlXged9ZF3bxcHaIrSXXVmk4mt?=
 =?us-ascii?Q?FBRC967bh9ld6pnPQo/lFFRxf38ajznhNfG3iHeSyXN+9YgCmURoliZ+UJOv?=
 =?us-ascii?Q?oANGTR1xwKZqvwEJNDUCJJklUQcYQ65vs4UF5IJ7n8zCD1kCpxLhq9nQBL9M?=
 =?us-ascii?Q?7nb9yzAgkJ1W6YdWh1z3otAWRw0KcFwX1yGAKEsyPacP5f9ZisTRY8SUPqBv?=
 =?us-ascii?Q?VCYK0bGKhjvULdyU3May23/Nx52e2hXnyBR2LP8p/NSMxUkwH0nnloMuY9ij?=
 =?us-ascii?Q?vaV8UNOX/d58szZ+zw4e8MZkfW11ua51mLoiH4zEikjPdr65r4Zm/AjYFLDd?=
 =?us-ascii?Q?K8Ej/K5CB6XX9VPk97+QbJ+bfyXVVEHBniiISn0ZzQH7TSk99jJP78ev9ZKm?=
 =?us-ascii?Q?UBLyDeYnY3KD3K0+9/j1hyiXG4sSrmJxSFtaX/OCRUAPszXKc2qVTCKdaxax?=
 =?us-ascii?Q?lf1m4GMi5ffLQ+oBpu8IajapVFR4xVFqrGf9YRQZxusKm6ONcGc32WDVlYkd?=
 =?us-ascii?Q?M0UcGevOtosJI9sbCogy1QUgUAVIgZ/1kDQ9uyTJNSzAOf4PH/ImWPQRE49a?=
 =?us-ascii?Q?hb0SPToUZNn6XlF6sy0/PyXaSa7LWXhDCAhoDhs4y7VZIzIgYM43sQFJWSp3?=
 =?us-ascii?Q?3wPEt8fyL2hU1vPrSob0hacUiOZod711HVAg5PSqiLD5MgmUHnc4QuvU36UI?=
 =?us-ascii?Q?VoFScYI9sbFu+bwkde22luOANR1jmCZ1glWDNaQKu4Klwa4A7ijKdL6fxPml?=
 =?us-ascii?Q?JZNdUrt0cIf8pZJigbFDBcFa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e06820e-41d5-44b4-d292-08d8e918ec94
X-MS-Exchange-CrossTenant-AuthSource: CY4PR12MB1463.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2021 07:47:33.2627 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 70ovkg/WpL7oaxTrg6piyF5mlw3NQPcwtRATESrg3eo5HGNSdnd6HoLlKpPbeSufkETTa8cjsov5vkTsUnn+Mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1847
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

Remove prime_shared_count from base class and use that
the subclass, amdgpu_bo_dmabuf.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c      |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c | 12 ++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c     |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c  |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h  |  1 -
 5 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index b5c766998045..04994757cc9c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -618,7 +618,7 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
 		struct amdgpu_bo *bo = ttm_to_amdgpu_bo(e->tv.bo);
 
 		/* Make sure we use the exclusive slot for shared BOs */
-		if (bo->prime_shared_count)
+		if (is_amdgpu_bo_dmabuf(bo))
 			e->tv.num_shared = 0;
 		e->bo_va = amdgpu_vm_bo_find(vm, bo);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
index e0c4f7c7f1b9..3cf57ea56499 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
@@ -143,6 +143,7 @@ static int amdgpu_dma_buf_attach(struct dma_buf *dmabuf,
 {
 	struct drm_gem_object *obj = dmabuf->priv;
 	struct amdgpu_bo *bo = gem_to_amdgpu_bo(obj);
+	struct amdgpu_bo_dmabuf *dbo = to_amdgpu_bo_dmabuf(bo);
 	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
 	int r;
 
@@ -172,7 +173,7 @@ static int amdgpu_dma_buf_attach(struct dma_buf *dmabuf,
 	if (r)
 		goto out;
 
-	bo->prime_shared_count++;
+	dbo->prime_shared_count++;
 	amdgpu_bo_unreserve(bo);
 	return 0;
 
@@ -194,10 +195,11 @@ static void amdgpu_dma_buf_detach(struct dma_buf *dmabuf,
 {
 	struct drm_gem_object *obj = dmabuf->priv;
 	struct amdgpu_bo *bo = gem_to_amdgpu_bo(obj);
+	struct amdgpu_bo_dmabuf *dbo = to_amdgpu_bo_dmabuf(bo);
 	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
 
-	if (attach->dev->driver != adev->dev->driver && bo->prime_shared_count)
-		bo->prime_shared_count--;
+	if (attach->dev->driver != adev->dev->driver && dbo->prime_shared_count)
+		dbo->prime_shared_count--;
 
 	pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
 	pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
@@ -431,6 +433,7 @@ amdgpu_dma_buf_create_obj(struct drm_device *dev, struct dma_buf *dma_buf)
 	struct amdgpu_device *adev = drm_to_adev(dev);
 	struct drm_gem_object *gobj;
 	struct amdgpu_bo *bo;
+	struct amdgpu_bo_dmabuf *dbo;
 	uint64_t flags = 0;
 	int ret;
 
@@ -449,10 +452,11 @@ amdgpu_dma_buf_create_obj(struct drm_device *dev, struct dma_buf *dma_buf)
 		goto error;
 
 	bo = gem_to_amdgpu_bo(gobj);
+	dbo = to_amdgpu_bo_dmabuf(bo);
 	bo->allowed_domains = AMDGPU_GEM_DOMAIN_GTT;
 	bo->preferred_domains = AMDGPU_GEM_DOMAIN_GTT;
 	if (dma_buf->ops != &amdgpu_dmabuf_ops)
-		bo->prime_shared_count = 1;
+		dbo->prime_shared_count = 1;
 
 	dma_resv_unlock(resv);
 	return gobj;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 5366a806be2b..7cce8aa29fd7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -783,7 +783,7 @@ int amdgpu_gem_op_ioctl(struct drm_device *dev, void *data,
 		break;
 	}
 	case AMDGPU_GEM_OP_SET_PLACEMENT:
-		if (robj->prime_shared_count && (args->value & AMDGPU_GEM_DOMAIN_VRAM)) {
+		if (is_amdgpu_bo_dmabuf(robj) && (args->value & AMDGPU_GEM_DOMAIN_VRAM)) {
 			r = -EINVAL;
 			amdgpu_bo_unreserve(robj);
 			break;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index ad615eec1e8c..435bf85991e5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -965,7 +965,7 @@ int amdgpu_bo_pin_restricted(struct amdgpu_bo *bo, u32 domain,
 		return -EINVAL;
 
 	/* A shared bo cannot be migrated to VRAM */
-	if (bo->prime_shared_count || bo->tbo.base.import_attach) {
+	if (is_amdgpu_bo_dmabuf(bo) || bo->tbo.base.import_attach) {
 		if (domain & AMDGPU_GEM_DOMAIN_GTT)
 			domain = AMDGPU_GEM_DOMAIN_GTT;
 		else
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
index 3d23ad247b1b..2f1abcc4e1e7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
@@ -93,7 +93,6 @@ struct amdgpu_bo {
 	struct ttm_buffer_object	tbo;
 	struct ttm_bo_kmap_obj		kmap;
 	u64				flags;
-	unsigned			prime_shared_count;
 	/* per VM structure for page tables and with virtual addresses */
 	struct amdgpu_vm_bo_base	*vm_bo;
 	/* Constant after initialization */
-- 
2.30.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
