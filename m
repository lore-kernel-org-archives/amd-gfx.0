Return-Path: <SRS0=oPsV=PA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AB42C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Oct 2021 22:49:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46E4860F38
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Oct 2021 22:49:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 46E4860F38
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D928A6E9EF;
	Tue, 12 Oct 2021 22:49:39 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2063.outbound.protection.outlook.com [40.107.94.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 84FF76E9EF
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Oct 2021 22:49:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C5avDVEzgbBZlhohRsyfUCSyi5HriasuAUVTXkQdt5LT8ZDYYzKr/xHPmlGe8KTsfOsnUb7kFRWLMJNqCg6unyDsZQKN5rNL/0apACO5dQiNenCP/EA9PMipW6+GPpSRM499M5eC/FXmI1f4gV9LKqv43RI5iFbIRwresnNwrvnpebjwYcupP+cztCAozyg9rg7VcpJGkwaGJtSn6KxaLnAsMgZWhkhnxaeNKiQ3krC46ZaBKJ2bZfDQjx69lYyKrhk7ylFcrStRKo83gSCuncIlU3l6qyD+F6UZOwlZyiec/5PCgiwrVmJJN1uw9yFiPL/M7Fgx4Vq/wCclxXbVsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tjfx/QvjBNub/5sDCx2mr1SRDN3o6qYHvhG9jlirD/o=;
 b=QSWzwrfgOijgqES9L+vOl5asIIgneZlPcV80l/ea5Jw0gYD2I/OXd1dd++iSSsUU4EEuH283O1XRslYs+dccxmuUF0fV93mUZdLE9wKpqruU+abudKIS7krOxzFILZpFUJyAtwWYb65R3GsMEfwFXbjicJtdWcZaqtnTyND0j2AqsUbip6r6wU6zGzmxoVc4IreQPH7qENQ1yyah8d7HX+wcxny0UhEcV0ViS9WK3BLUO63bqkGX/MMl6NhDOYcobfkTCljnQZDxJElaDs+X8oQuWqSE9S3VsKcNuc4nQVlo5/rHAAa3Al2RKJWBjubKV84ctEblbk6KZ7LdwykCkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tjfx/QvjBNub/5sDCx2mr1SRDN3o6qYHvhG9jlirD/o=;
 b=UPh7BJSnNVGcsYknkyIRwflBLxX42icsGwF/QcKg/ynrPOUG9CAj+pg4ekK1hclL0URvFIr750WM8PGb1aOsg7wBVgFYmpEvVP0D46UubvouYhyVSIJcTg8cdPC/kRIUr0FMLDVWWaWXwYP+nRcXhluqaFz3iMB2c6LjIkXS/LQ=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM5PR1201MB2491.namprd12.prod.outlook.com (2603:10b6:3:eb::23)
 by DM6PR12MB3403.namprd12.prod.outlook.com (2603:10b6:5:11d::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.22; Tue, 12 Oct
 2021 22:49:37 +0000
Received: from DM5PR1201MB2491.namprd12.prod.outlook.com
 ([fe80::d153:3aa6:4677:e29]) by DM5PR1201MB2491.namprd12.prod.outlook.com
 ([fe80::d153:3aa6:4677:e29%7]) with mapi id 15.20.4587.026; Tue, 12 Oct 2021
 22:49:37 +0000
Subject: Re: [PATCH v2 1/3] drm/amdkfd: ratelimited svm debug messages
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211012135527.28083-1-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <04f133bf-8dd4-ad1e-c7cd-4b303e9bcb38@amd.com>
Date: Tue, 12 Oct 2021 18:49:35 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <20211012135527.28083-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0090.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::29) To DM5PR1201MB2491.namprd12.prod.outlook.com
 (2603:10b6:3:eb::23)
MIME-Version: 1.0
Received: from [192.168.2.100] (142.118.126.231) by
 YT1PR01CA0090.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2d::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4587.25 via Frontend Transport; Tue, 12 Oct 2021 22:49:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6780f50b-515b-46de-49b4-08d98dd29128
X-MS-TrafficTypeDiagnostic: DM6PR12MB3403:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3403F0D0D4A0F0B44585651092B69@DM6PR12MB3403.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1360;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DjDLz6G7jTVl0B58fMhyXdWI7iR1lWP6kSKStU3e/kMaWiivK0be+FH8qj6S9Q+JyRPddkTy2/WHtk1R2ptJaMMQvAqOQZQUeAVK5vvihOtQuH3Hk7eCEElu4Mk9J0XXySytXRKf3quUXbXRdJugU+FC6rQwWg4/hBFjViS7ALTCH7ekCmAI8cu1TcQABIS75zo+iDarXn+DApq+6GQABWexCVwJ9/MYi5hLFaX00IKRMldlIBrrwhwctdpnigJIHYsbRASqt8PEMQ0ITGgnYXyhFw1j0fyq0fzZo56u+Pb21a1Dnwht3RA6wp/JJS9GzwIerwcptjkELTpgvBvyppcN3rBgvOPPczvX3WLQpVeKcCbP5AbKFQubCnw7m8dcvP9xu991keEU2YwCJ4htJW9F9brLWRIg7ROSmg0IuVd9na/ThgRKy4AAMTTIcyLmCnXsl+wHaog81bfYbpazgu5ga13ipIVY41CcZFDrF6vMPYFPENYKUtJHjDbvnlrBvE1RfmUJISmLFmXDzBNqHOvZ/CjEGP86/VzR4v98uxQaZP/IB9D002FJMn46XlmOAwv/Ejse3a+MdKdD4dQxLP+VlZmVYQN0Oqd4VxXdZiByJ7XqwK6GhWLXFsRZLD41yeBbYZxAt3ZFHyivFx/xA7aEEmTEuqAJJI1f21M2kVFc3y890D4eZA54WUngTWXZxLm+lR2TfXQdnfoIZyUbflgrss0wXMx2HhTo5nOGD60=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR1201MB2491.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(86362001)(2906002)(31696002)(956004)(6486002)(2616005)(5660300002)(44832011)(66946007)(508600001)(15650500001)(316002)(26005)(4001150100001)(8676002)(186003)(16576012)(66476007)(8936002)(31686004)(38100700002)(83380400001)(36756003)(66556008)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L3JKY0FRYkVjWW1JSmtHQWhMN2d1S1dSSXR2Y0IwZHRpYUY4a3QrY3NBdmc4?=
 =?utf-8?B?S3o0dUZuL0dXd0o0ZGRGTXVxMllnRWk5V082NEtBVHBZb3JlbGhCV2hvRUhI?=
 =?utf-8?B?SjR6SUdUNEdocEZNaDJLTUV1b1E2MGZXTTYzNDlLdDRrU3JvVlQ1bGpSRWoz?=
 =?utf-8?B?WWI0bExsS2hRNmVKMUs0cGwwY0M3SnhiR09oQmxqR3RVN0hNdGFNUTk4N3JY?=
 =?utf-8?B?c1J5MlJTUjRNL1lVcUZaWkpVY3lyT0JzVW1KUmo5RXJDWDFDV3dkbWFnVjY0?=
 =?utf-8?B?YXBLbnY5Mit1YWhUVTJid3kzc1FhVkJETzRnM3loNUxjU1h3V2srbWFRRDRu?=
 =?utf-8?B?c3JrMURKc01SWUd1OXo0QW5vZ3pzN2hkTHB3WWQ3NFZhVzErcDh4c0JpRGVH?=
 =?utf-8?B?VzdKbERzSVJSeTBla0tIQXViRGV2RUNDbnVQZm5qdEhZaHN0bkZ0YVg2L3FI?=
 =?utf-8?B?bzQwWEVoZ1g2WjJZY2Jjb1duZU5qY21abVBDak1tQmF5ZE5EWEJoZnZneXhu?=
 =?utf-8?B?SlZnVVUwWEhNalNvQ0l4c2VwMURIakdCMjRURXRXcVBtOTZETVZuaDRFb3Q0?=
 =?utf-8?B?cG5MKzhYV0tvOE5CNnplM0xraG02VzRMRDVzSmZkUVlyeGs4dWcraUwxY1ov?=
 =?utf-8?B?bGZJdGkyaGpRSFFBN3BmeHlTS1Z3bUNCOVl5K293UGU2TkZ4MEU4RGlVN0Rt?=
 =?utf-8?B?R0kyOHl2a1k1eHNmbVdGWlVtbU1haU04MVhPS0VMNVI1RTVyVndKaEhYZGFk?=
 =?utf-8?B?Rk9QbDM1aFdZU3NLZDYvMGQ4Vjg5akx3Q01CVmFUbkI2Q2pXV2NRSUVQQWp4?=
 =?utf-8?B?bmdiSkFWdTBtU3RFaFNrSFZUNnJiYW5kR01SYU55QmVsRWZ3UUoraXV2QlBx?=
 =?utf-8?B?NENPaFB2eE9QZkRYSmFjYytMSjhCTGxFUGlpUUJpZ3hTYXpNRDhLWUdWQjRS?=
 =?utf-8?B?ZjVKbHRKUGNRUHBCaVBMY3pjU3dRZEFKWGJRQzRwampYSWQvRUp5aDNON080?=
 =?utf-8?B?VEppYk1ieG9HOVdhb1pNdDFkVFFKTEtqL2hXT2xKamJHV3JiUW04ZXRpMjkw?=
 =?utf-8?B?ZXdqeEthRjRuaTZKOU5RcTlwd2NxN3lLbms4OWFkQXpPK2t6SVExQjZHMnBT?=
 =?utf-8?B?NXdiZm1FTXhmZVNwYnkrdlNweDArUGRwd1I3V1RBb1F3eG1nbzg3MlVUeDVR?=
 =?utf-8?B?bXRBMVE0dnVDTEhUWXZLaGRMMVVqVk9penBrSWoyZU9jOFl4VUE0dFV0SHBn?=
 =?utf-8?B?OU5xR3RnamYwY1g4Ri9yazhUMHEvbTUybDlHSUtlRVM1UVkvSHBlSFRTV0Ir?=
 =?utf-8?B?NWY0aEM4bnE5R3ZvUkdNOC9GU0dyQW0rSG9mdHpJdmJwZjFFZld5bVdkMWZS?=
 =?utf-8?B?OHJsMHNJU1RpaVFKK1VoaTh5RG51ellQOWFiNHBlYXQ4MVRvZG1zc1lFMG5v?=
 =?utf-8?B?Ym5FVG1jSDNkVXdVY1pCdUd5SDlsQUFrSjdKMTJPUHd1YVVZaTlvZzYzRmNv?=
 =?utf-8?B?eVZ3UkNITGI0SGdBV2JORHlhak55UHh5VkowaTl1c0tkM3pJTjhvNXg4YzZV?=
 =?utf-8?B?bStqRElxL3NvVlk3U0pWT0ZmMTJFa2lDdzlJVHFiaXpkTzNyOElvdFIyZkJ6?=
 =?utf-8?B?c1BaczVBNUZQSFlpS2lreWsvQ3dQdHZnZ3hlV1BteHpmaWxuUytjNk1OU1hi?=
 =?utf-8?B?cUZ2S3VEdzQwMVNJWGF5MHFZMjJZNk9JTCtQZnk0QXp3NmpGMVdselVCdU9k?=
 =?utf-8?Q?OMimu19UiXljAz0gVeXhRuoOdWtKx1ag8RE26Tx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6780f50b-515b-46de-49b4-08d98dd29128
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1201MB2491.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2021 22:49:36.9220 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BXk8ozOXiaoTUrfQKBUibZy9tUwOveir/o7K5WfuLUjNeiRULjqV9AqmUkWdcozEghTmHTtvW0bPLevyrGIceg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3403
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 2021-10-12 um 9:55 a.m. schrieb Philip Yang:
> No function change, use pr_debug_ratelimited to avoid per page debug
> message overflowing dmesg buf and console log.
>
> use dev_err to show error message from unexpected situation, to provide
> clue to help debug without enabling dynamic debug log. Define dev_fmt to
> output function name in error message.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 34 +++++++++++++-----------
>  drivers/gpu/drm/amd/amdkfd/kfd_svm.c     | 17 +++++++-----
>  2 files changed, 30 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> index f53e17a94ad8..b05c0579d0b9 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> @@ -20,7 +20,6 @@
>   * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
>   * OTHER DEALINGS IN THE SOFTWARE.
>   */
> -
>  #include <linux/types.h>
>  #include <linux/hmm.h>
>  #include <linux/dma-direction.h>
> @@ -34,6 +33,11 @@
>  #include "kfd_svm.h"
>  #include "kfd_migrate.h"
>  
> +#ifdef dev_fmt
> +#undef dev_fmt
> +#endif
> +#define dev_fmt(fmt) "kfd_migrate: %s: " fmt, __func__
> +
>  static uint64_t
>  svm_migrate_direct_mapping_addr(struct amdgpu_device *adev, uint64_t addr)
>  {
> @@ -151,14 +155,14 @@ svm_migrate_copy_memory_gart(struct amdgpu_device *adev, dma_addr_t *sys,
>  			gart_d = svm_migrate_direct_mapping_addr(adev, *vram);
>  		}
>  		if (r) {
> -			pr_debug("failed %d to create gart mapping\n", r);
> +			dev_err(adev->dev, "fail %d create gart mapping\n", r);
>  			goto out_unlock;
>  		}
>  
>  		r = amdgpu_copy_buffer(ring, gart_s, gart_d, size * PAGE_SIZE,
>  				       NULL, &next, false, true, false);
>  		if (r) {
> -			pr_debug("failed %d to copy memory\n", r);
> +			dev_err(adev->dev, "fail %d to copy memory\n", r);
>  			goto out_unlock;
>  		}
>  
> @@ -285,7 +289,7 @@ svm_migrate_copy_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
>  
>  	r = svm_range_vram_node_new(adev, prange, true);
>  	if (r) {
> -		pr_debug("failed %d get 0x%llx pages from vram\n", r, npages);
> +		dev_err(adev->dev, "fail %d to alloc vram\n", r);
>  		goto out;
>  	}
>  
> @@ -305,7 +309,7 @@ svm_migrate_copy_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
>  					      DMA_TO_DEVICE);
>  			r = dma_mapping_error(dev, src[i]);
>  			if (r) {
> -				pr_debug("failed %d dma_map_page\n", r);
> +				dev_err(adev->dev, "fail %d dma_map_page\n", r);
>  				goto out_free_vram_pages;
>  			}
>  		} else {
> @@ -325,8 +329,8 @@ svm_migrate_copy_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
>  			continue;
>  		}
>  
> -		pr_debug("dma mapping src to 0x%llx, page_to_pfn 0x%lx\n",
> -			 src[i] >> PAGE_SHIFT, page_to_pfn(spage));
> +		pr_debug_ratelimited("dma mapping src to 0x%llx, pfn 0x%lx\n",
> +				     src[i] >> PAGE_SHIFT, page_to_pfn(spage));
>  
>  		if (j >= (cursor.size >> PAGE_SHIFT) - 1 && i < npages - 1) {
>  			r = svm_migrate_copy_memory_gart(adev, src + i - j,
> @@ -405,8 +409,8 @@ svm_migrate_vma_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
>  
>  	r = migrate_vma_setup(&migrate);
>  	if (r) {
> -		pr_debug("failed %d prepare migrate svms 0x%p [0x%lx 0x%lx]\n",
> -			 r, prange->svms, prange->start, prange->last);
> +		dev_err(adev->dev, "vma setup fail %d range [0x%lx 0x%lx]\n", r,
> +			prange->start, prange->last);
>  		goto out_free;
>  	}
>  	if (migrate.cpages != npages) {
> @@ -506,7 +510,7 @@ static void svm_migrate_page_free(struct page *page)
>  	struct svm_range_bo *svm_bo = page->zone_device_data;
>  
>  	if (svm_bo) {
> -		pr_debug("svm_bo ref left: %d\n", kref_read(&svm_bo->kref));
> +		pr_debug_ratelimited("ref: %d\n", kref_read(&svm_bo->kref));
>  		svm_range_bo_unref(svm_bo);
>  	}
>  }
> @@ -572,12 +576,12 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
>  		dst[i] = dma_map_page(dev, dpage, 0, PAGE_SIZE, DMA_FROM_DEVICE);
>  		r = dma_mapping_error(dev, dst[i]);
>  		if (r) {
> -			pr_debug("failed %d dma_map_page\n", r);
> +			dev_err(adev->dev, "fail %d dma_map_page\n", r);
>  			goto out_oom;
>  		}
>  
> -		pr_debug("dma mapping dst to 0x%llx, page_to_pfn 0x%lx\n",
> -			      dst[i] >> PAGE_SHIFT, page_to_pfn(dpage));
> +		pr_debug_ratelimited("dma mapping dst to 0x%llx, pfn 0x%lx\n",
> +				     dst[i] >> PAGE_SHIFT, page_to_pfn(dpage));
>  
>  		migrate->dst[i] = migrate_pfn(page_to_pfn(dpage));
>  		migrate->dst[i] |= MIGRATE_PFN_LOCKED;
> @@ -631,8 +635,8 @@ svm_migrate_vma_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
>  
>  	r = migrate_vma_setup(&migrate);
>  	if (r) {
> -		pr_debug("failed %d prepare migrate svms 0x%p [0x%lx 0x%lx]\n",
> -			 r, prange->svms, prange->start, prange->last);
> +		dev_err(adev->dev, "vma setup fail %d range [0x%lx 0x%lx]\n", r,
> +			prange->start, prange->last);
>  		goto out_free;
>  	}
>  
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 425d55deca10..49c92713c2ad 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -33,6 +33,11 @@
>  #include "kfd_svm.h"
>  #include "kfd_migrate.h"
>  
> +#ifdef dev_fmt
> +#undef dev_fmt
> +#endif
> +#define dev_fmt(fmt) "kfd_svm: %s: " fmt, __func__
> +
>  #define AMDGPU_SVM_RANGE_RESTORE_DELAY_MS 1
>  
>  /* Long enough to ensure no retry fault comes after svm range is restored and
> @@ -158,17 +163,17 @@ svm_range_dma_map_dev(struct amdgpu_device *adev, struct svm_range *prange,
>  				   bo_adev->vm_manager.vram_base_offset -
>  				   bo_adev->kfd.dev->pgmap.range.start;
>  			addr[i] |= SVM_RANGE_VRAM_DOMAIN;
> -			pr_debug("vram address detected: 0x%llx\n", addr[i]);
> +			pr_debug_ratelimited("vram address: 0x%llx\n", addr[i]);
>  			continue;
>  		}
>  		addr[i] = dma_map_page(dev, page, 0, PAGE_SIZE, dir);
>  		r = dma_mapping_error(dev, addr[i]);
>  		if (r) {
> -			pr_debug("failed %d dma_map_page\n", r);
> +			dev_err(dev, "failed %d dma_map_page\n", r);
>  			return r;
>  		}
> -		pr_debug("dma mapping 0x%llx for page addr 0x%lx\n",
> -			 addr[i] >> PAGE_SHIFT, page_to_pfn(page));
> +		pr_debug_ratelimited("dma mapping 0x%llx for page addr 0x%lx\n",
> +				     addr[i] >> PAGE_SHIFT, page_to_pfn(page));
>  	}
>  	return 0;
>  }
> @@ -217,7 +222,7 @@ void svm_range_dma_unmap(struct device *dev, dma_addr_t *dma_addr,
>  	for (i = offset; i < offset + npages; i++) {
>  		if (!svm_is_valid_dma_mapping_addr(dev, dma_addr[i]))
>  			continue;
> -		pr_debug("dma unmapping 0x%llx\n", dma_addr[i] >> PAGE_SHIFT);
> +		pr_debug_ratelimited("unmap 0x%llx\n", dma_addr[i] >> PAGE_SHIFT);
>  		dma_unmap_page(dev, dma_addr[i], PAGE_SIZE, dir);
>  		dma_addr[i] = 0;
>  	}
> @@ -1454,7 +1459,7 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
>  		/* This should never happen. actual_loc gets set by
>  		 * svm_migrate_ram_to_vram after allocating a BO.
>  		 */
> -		WARN(1, "VRAM BO missing during validation\n");
> +		WARN_ONCE(1, "VRAM BO missing during validation\n");
>  		return -EINVAL;
>  	}
>  
