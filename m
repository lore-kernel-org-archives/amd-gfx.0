Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02D54C4321E
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Jan 2022 15:56:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5AB5810EBC0;
	Fri, 28 Jan 2022 15:56:02 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on2079.outbound.protection.outlook.com [40.107.100.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F78610EBC0
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Jan 2022 15:56:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RaZkEhVV9wuWHj2ljF/J24+OHxtjG1uInpPJWG+9lsH9DDbVwwaJQaRhU6VOvfZ+sT+m6QR9VoWkSuuKN0iu1jC8p40zxKqBkODKWwcY8/VFFxHTDpCAw6oLuxyypn26UOcH3amShsi2SMpJyq8K3JMA7ZrO9Yj0Rlq5y/YYMcOBAKKLyTahH23h6FRvQGFxyiJMFxDv3sD64xhadBYmSqyRCLZ1sX/DfulUCX2kTnHtLg5wn6P2Pt69wIWSdDNQoaM+yXTw0AUntnniHiqOHVRy203VVP+YrUMFHBZJJicullY2KT4ITsGAxzqZns//4I/vOwkRDZ1U/noSuAW2Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fvhFmi+hqlQjFX2RiPwI6Zj5qLpBJGGXrhlVRhOIdus=;
 b=KrVCDs6L7akN3UcIMPadHaean+aNSr8n5T2AAzltoo3oNXkyZiAyUiLRYN4lnOQpt4WA2yL5fgYNfr3s69EYy20CxwmyDcYfbBch5fjBwsA3i8ZUgo0FPXUAlf9zcLLn9AsbKisuCwWFUSYKrR2HWrcM1MA089FY1QwjA7f6aP7ci7DRfN6NK2XTFxAOCsb6IsHQs4mJ0OX8MfY4fnOGbqply9dTRASPRTzwwpzxexmSqfWwco4tMXmmbhaiWAmTQu5us68YA8aJHDWIG3U6PdszXdwHHl9H/qajCD9SpqOLnZBdwKgbJij4sjALlPEdl4x42SszoVdN89DGsl6k8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fvhFmi+hqlQjFX2RiPwI6Zj5qLpBJGGXrhlVRhOIdus=;
 b=FlHpsykZQ48A7qrRhccpO3R5VzgXpdY04j/HpxSk9cfgxrphsg4DHAPIlgOWQkAlFKvv7vwOfsLWk7JbUC0HbNgHNOmGmMTBbRJhIiTOm5XXGjjQAz0Xl9UIgTL48lhnnen8U+UzqFNq5cHjbKkYuNFRyh8biF57Zbs7OjLCwOk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by MN2PR12MB4127.namprd12.prod.outlook.com (2603:10b6:208:1d1::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Fri, 28 Jan
 2022 15:55:57 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::971:531c:e4f4:8a9a]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::971:531c:e4f4:8a9a%7]) with mapi id 15.20.4930.019; Fri, 28 Jan 2022
 15:55:57 +0000
Message-ID: <a08812d4-a464-de08-8b5a-3c13408efff5@amd.com>
Date: Fri, 28 Jan 2022 10:55:54 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 2/2] drm/amdgpu: restructure amdgpu_fill_buffer
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 harish.kasiviswanathan@amd.com, benjaminadam.price@amd.com,
 amd-gfx@lists.freedesktop.org
References: <20220128151637.1403-1-christian.koenig@amd.com>
 <20220128151637.1403-2-christian.koenig@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20220128151637.1403-2-christian.koenig@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0194.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:67::23) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 145d51bc-de98-4950-475b-08d9e276ac3a
X-MS-TrafficTypeDiagnostic: MN2PR12MB4127:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB4127CF0EA90E752292F39A1492229@MN2PR12MB4127.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tV6xjZ2XjB1imFTxd13jMyfItaUWEt8+96SEo735o44xhTnDiSUHnqLknrFsM4aa3+SQ3FgAKbwe1TMA5cwlc0Q4Yabbnjg2V28A+S4A1Vg/oVSAKpAdf4ncZx59TB/VXOwvKiIKo3SEiUAn+/5JIV7Yvb27Eo9qBnepdnEtovI2HTWf+BdP9FpDm8o6fXEmuNWOSKwhEQu6L3Tw5IWcScqEryr0eVuYPhO+d8EpJRW5R+LGwOD+Z+vEKa2wcq501hRg9FyR17Zlj5VnbUCKPz7F/f/lIw0IBr121Y4ci3BWrOPrRXNb6cbhzNAk9A/ye4eYQ958y5KEtKh0EtF38O7dBbM675WIkZvta3rPEfT5DY2znOYiJ9+p9Y25kLDgR6sCLq8teSAgE4ty0bgwfsao8Xoi3z9bqCM+wzA91CVHNy1f+m4DzkdgcAEPinqv2yznAd/Jrptkfz+CoQ/o9BGTLWV5DFZPac69OeA64+vL1oxLcMPkBimS3BsrKn17RpihE7AQ3F+5MiMKvXm9E6B5Vop9WWPkuUlcXZdiwkjzX3AFoVmoYnBdmLEvdjCmgQBC23aMo7tMTlk7zfnu17V62ftT6VxUmY1ghzBtQ7V+sWhQoQ7+9SVS0p3ygUxfAHOS0xv1iXw6k6E7FmzBMY1SEtmEBadNSW/2U99pxRV+Zl/ERXOFqbKbLTlbHjykKns8VZpIbzS3IVYbOdFvFQE9WO3s3On45WTyja9XmEU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(31686004)(5660300002)(2616005)(83380400001)(38100700002)(66946007)(316002)(44832011)(36756003)(66556008)(66476007)(30864003)(8676002)(8936002)(2906002)(6506007)(6486002)(508600001)(86362001)(6512007)(31696002)(6666004)(186003)(26005)(66574015)(45980500001)(43740500002)(20210929001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Sk9yTW00SndmYWp4Yy91bEhENzdaam56Tk5EOXpZcDFrK2N0N1drMktpRlVp?=
 =?utf-8?B?R1RlWmpGNzQraTFMOW45enoxRVNmamZpbVluUEdEYm9TaHRKUWJrRkMvaDRp?=
 =?utf-8?B?VnJvWGJwWlArU3RKKzB6UFkyTk9WbmM3ZzhyNk44UGc1WXVUNU9sM3Y3Qk1t?=
 =?utf-8?B?aCtmNGpGVTd0MWFtWjBDOVI4bUl5ZW5LeStDdU1xRWprSUdGM2U5aW9UNkRM?=
 =?utf-8?B?bkZ5VXAzYkUzazEzUHc1bXVFSVIyaVo5a1dYdk44cEtQUjlqenNHWElVcVha?=
 =?utf-8?B?dFRDQXVCcmJ0UUV5bjNhOEMzUExSWklJS1JORFhTRWlwSDErZ2JncVNWRkFY?=
 =?utf-8?B?QURlQTQzYVNGUStHSWVZQjIrMEttcUJCSjJJTUR2ZXNvWHBXbXBJYzl5a3lG?=
 =?utf-8?B?clhNbUFCVTlyeW9seVhCcUNFUm81QVpHOEFvMW1NT25OTlROQjF0cHJzaWQy?=
 =?utf-8?B?a0dSMXd3enZpVCsxZ25UUExhWHlqOEdvUTU1V1JJeWNWK0d3S0pvK0FCY21G?=
 =?utf-8?B?M2FIWnptdzIzS09MaEswbEI5cUZtYitRRnNiSGlwMWRXNTNPWWFnc0dCbFZZ?=
 =?utf-8?B?ZjZmQmZYck5pTFA4Y1FkUGNFZWlnbUZ1dzlibWIvS1h5OXVCTnB2UFpVdVAy?=
 =?utf-8?B?YkxLRStoN0Z4NU1NTU5FN1NiOXh1OXJOV3UxaFF3ZTl2MURWaWlsOEFjQjJF?=
 =?utf-8?B?SVN2MnhWWkpGVVUwNjRkbDB2K1hvUGZqQ3BWQ0pyc2FMbmh5VVU0VldIZ2w1?=
 =?utf-8?B?Q2ZTWTJmZGwzTG1KRC8yRWIyeS9kZEdRQ0NwRy81Z093Zkt0bVhEYlRNUFdY?=
 =?utf-8?B?OEk5dGNyRDI1c0lNODk5dUl1SWI3YlA4RjFlZGtBbCtzTXNvOGtLR05EN2sx?=
 =?utf-8?B?SmdCQzNqbWNDM3RWRzdyWS9UNUVGOWFRVXpkNzlLa0p2UmV2dWF6QTBlY0Jx?=
 =?utf-8?B?bFpMbWZhWjNtaERibVRqdW5BVWlOcmZZcTV4VlVUa2Nscm5FbG1yY3JsYnpG?=
 =?utf-8?B?aWcwR1U0c05ZSVYwdW1UL3NmcXdIcDRpTUR4NTVJRFJkWmUxWUF6SE1qRkxJ?=
 =?utf-8?B?K01raDk4b205QVVyWWEyQnBveUpPeS8zZmpmakU5RUFrazExaS92YVhLK2FU?=
 =?utf-8?B?LzhRbzNBUXlFS2RBK1dZMm1McmtFbnZiUVRkM1ZsMmNzSGFZdUdNMm9SdHE2?=
 =?utf-8?B?UVR2UGxYZjhIT3FJN3VjL3JhMk1VSzZELzR0YTU2RjE5WmlkVkhtSXhhUTBx?=
 =?utf-8?B?WGhBOFkzTm1hTVBBZ0dkU3VRbVZ2OVVTUzNGbTN4RWRGdGI4UFNvNjhiVVRW?=
 =?utf-8?B?UitNeFBQZkl5WDNYSkhPWXJHQ3laWENFYjdDTVBkQ283blllRkNoUDN1VlQ5?=
 =?utf-8?B?SGYxaTlPU2FQQ0tmTmFLZllUc1N5TnpwUks1azNJc29KSnNTa1lBYzBvMVdl?=
 =?utf-8?B?TG16RlFiR1lNdUpOT0pVMGYxVmJ1Y2wyeHR2aXFFSUtscmx1THFOdndOd0lO?=
 =?utf-8?B?UDFISHJJQkRWTmoxUU5uemp4ZmhBL0xTdVhTOTFhdlYzQjl2L2owS3ZKUE9z?=
 =?utf-8?B?ZmFxOXMzS3J3eDBkTytSRjZWdVFHa1dWM2hEQlMwTG15cVAwVUpXUm0zbCtm?=
 =?utf-8?B?YUdFTCtJV25QZjRKVklDQTJuVXJyY2NJZWYrR08xeUI2S0JXYkRwVHlOazN4?=
 =?utf-8?B?c1owVjNzVkptWjIzSFRrZXlWYzVOcWZkN0J1dG9idEZraDBDc1FJZ0p3Yksr?=
 =?utf-8?B?d2prdnU4bXQ4aDNJbk1OKzNPNXpZN2NtS1J4TklEU2JzcEN2SmNLZUJHRG14?=
 =?utf-8?B?b0RBc0NvNmlNWjZQMVJZNldpVnlNaVlqM3JBWUV3WTBrSnp4U1VsaUdLMXRM?=
 =?utf-8?B?VjJ2ZjlSSmlZVjBGRjVMQkNuMWllYzBpZHBlamZKR1cyT3IwWjFkNmhTK3BH?=
 =?utf-8?B?UWZxN3BGTng2c0dia0grRnY5NEo2cktzdVY0YlhOQkpTcTc0TXdQT0lmaUlL?=
 =?utf-8?B?ZkM5Z3pKOGRFdGJ0N2tRelBKalFCaTNtSldNS1AwV3FHRXZ5VHA5a09BaEQ0?=
 =?utf-8?B?V0wyL3JlNUc2NjJmRjhPUVJvZEl1UE9UdXkzZVk2djMxU0FhK2Jwd2hzR3Mw?=
 =?utf-8?B?UEM2clNWYzV0S1h4U3AwUDU5U0srcFJ4bkVoL2NvUCs2ZDVibm8zSkdFVWhV?=
 =?utf-8?Q?toVsMs63IaPPx+WdvKORalo=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 145d51bc-de98-4950-475b-08d9e276ac3a
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2022 15:55:57.5654 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SlO0uN6WmQ2ytCFn/RPuF0vPvNTevmkCDYiLbDlAUqCIwBKEBSCcllNCiEN7niq4mwiDcaYZJI6gpo2u1mscRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4127
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


Am 2022-01-28 um 10:16 schrieb Christian König:
> We ran into the problem that clearing really larger buffer (60GiB) caused an
> SDMA timeout.
>
> Restructure the function to use the dst window instead of mapping the whole
> buffer into the GART and then fill only 2MiB chunks at a time.
>
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 200 +++++++++++++-----------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h |   2 +
>   2 files changed, 114 insertions(+), 88 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 2b0e83e9fa8a..8671ba32fb52 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -296,9 +296,6 @@ int amdgpu_ttm_copy_mem_to_mem(struct amdgpu_device *adev,
>   			       struct dma_resv *resv,
>   			       struct dma_fence **f)
>   {
> -	const uint32_t GTT_MAX_BYTES = (AMDGPU_GTT_MAX_TRANSFER_SIZE *
> -					AMDGPU_GPU_PAGE_SIZE);
> -
>   	struct amdgpu_ring *ring = adev->mman.buffer_funcs_ring;
>   	struct amdgpu_res_cursor src_mm, dst_mm;
>   	struct dma_fence *fence = NULL;
> @@ -320,12 +317,15 @@ int amdgpu_ttm_copy_mem_to_mem(struct amdgpu_device *adev,
>   		uint32_t cur_size;
>   		uint64_t from, to;
>   
> -		/* Copy size cannot exceed GTT_MAX_BYTES. So if src or dst
> -		 * begins at an offset, then adjust the size accordingly
> +		/*
> +		 * Copy size cannot exceed AMDGPU_GTT_MAX_TRANSFER_BYTES. So if
> +		 * src or dst begins at an offset, then adjust the size
> +		 * accordingly
>   		 */
>   		cur_size = max(src_page_offset, dst_page_offset);
>   		cur_size = min(min3(src_mm.size, dst_mm.size, size),
> -			       (uint64_t)(GTT_MAX_BYTES - cur_size));
> +			       (uint64_t)(AMDGPU_GTT_MAX_TRANSFER_BYTES -
> +					  cur_size));
>   
>   		/* Map src to window 0 and dst to window 1. */
>   		r = amdgpu_ttm_map_buffer(src->bo, src->mem, &src_mm,
> @@ -395,8 +395,7 @@ static int amdgpu_move_blit(struct ttm_buffer_object *bo,
>   	    (abo->flags & AMDGPU_GEM_CREATE_VRAM_WIPE_ON_RELEASE)) {
>   		struct dma_fence *wipe_fence = NULL;
>   
> -		r = amdgpu_fill_buffer(ttm_to_amdgpu_bo(bo), AMDGPU_POISON,
> -				       NULL, &wipe_fence);
> +		r = amdgpu_fill_buffer(abo, AMDGPU_POISON, NULL, &wipe_fence);
>   		if (r) {
>   			goto error;
>   		} else if (wipe_fence) {
> @@ -1922,19 +1921,51 @@ void amdgpu_ttm_set_buffer_funcs_status(struct amdgpu_device *adev, bool enable)
>   	adev->mman.buffer_funcs_enabled = enable;
>   }
>   
> +static int amdgpu_ttm_prepare_job(struct amdgpu_device *adev,
> +				  bool direct_submit,
> +				  unsigned int num_dw,
> +				  struct dma_resv *resv,
> +				  bool vm_needs_flush,
> +				  struct amdgpu_job **job)
> +{
> +	enum amdgpu_ib_pool_type pool = direct_submit ?
> +		AMDGPU_IB_POOL_DIRECT :
> +		AMDGPU_IB_POOL_DELAYED;
> +	int r;
> +
> +	r = amdgpu_job_alloc_with_ib(adev, num_dw * 4, pool, job);
> +	if (r)
> +		return r;
> +
> +	if (vm_needs_flush) {
> +		(*job)->vm_pd_addr = amdgpu_gmc_pd_addr(adev->gmc.pdb0_bo ?
> +							adev->gmc.pdb0_bo :
> +							adev->gart.bo);
> +		(*job)->vm_needs_flush = true;
> +	}
> +	if (resv) {
> +		r = amdgpu_sync_resv(adev, &(*job)->sync, resv,
> +				     AMDGPU_SYNC_ALWAYS,
> +				     AMDGPU_FENCE_OWNER_UNDEFINED);
> +		if (r) {
> +			DRM_ERROR("sync failed (%d).\n", r);
> +			amdgpu_job_free(*job);
> +			return r;
> +		}
> +	}
> +	return 0;
> +}
> +
>   int amdgpu_copy_buffer(struct amdgpu_ring *ring, uint64_t src_offset,
>   		       uint64_t dst_offset, uint32_t byte_count,
>   		       struct dma_resv *resv,
>   		       struct dma_fence **fence, bool direct_submit,
>   		       bool vm_needs_flush, bool tmz)
>   {
> -	enum amdgpu_ib_pool_type pool = direct_submit ? AMDGPU_IB_POOL_DIRECT :
> -		AMDGPU_IB_POOL_DELAYED;
>   	struct amdgpu_device *adev = ring->adev;
> +	unsigned num_loops, num_dw;
>   	struct amdgpu_job *job;
> -
>   	uint32_t max_bytes;
> -	unsigned num_loops, num_dw;
>   	unsigned i;
>   	int r;
>   
> @@ -1946,26 +1977,11 @@ int amdgpu_copy_buffer(struct amdgpu_ring *ring, uint64_t src_offset,
>   	max_bytes = adev->mman.buffer_funcs->copy_max_bytes;
>   	num_loops = DIV_ROUND_UP(byte_count, max_bytes);
>   	num_dw = ALIGN(num_loops * adev->mman.buffer_funcs->copy_num_dw, 8);
> -
> -	r = amdgpu_job_alloc_with_ib(adev, num_dw * 4, pool, &job);
> +	r = amdgpu_ttm_prepare_job(adev, direct_submit, num_dw,
> +				   resv, vm_needs_flush, &job);
>   	if (r)
>   		return r;
>   
> -	if (vm_needs_flush) {
> -		job->vm_pd_addr = amdgpu_gmc_pd_addr(adev->gmc.pdb0_bo ?
> -					adev->gmc.pdb0_bo : adev->gart.bo);
> -		job->vm_needs_flush = true;
> -	}
> -	if (resv) {
> -		r = amdgpu_sync_resv(adev, &job->sync, resv,
> -				     AMDGPU_SYNC_ALWAYS,
> -				     AMDGPU_FENCE_OWNER_UNDEFINED);
> -		if (r) {
> -			DRM_ERROR("sync failed (%d).\n", r);
> -			goto error_free;
> -		}
> -	}
> -
>   	for (i = 0; i < num_loops; i++) {
>   		uint32_t cur_size_in_bytes = min(byte_count, max_bytes);
>   
> @@ -1995,77 +2011,35 @@ int amdgpu_copy_buffer(struct amdgpu_ring *ring, uint64_t src_offset,
>   	return r;
>   }
>   
> -int amdgpu_fill_buffer(struct amdgpu_bo *bo,
> -		       uint32_t src_data,
> -		       struct dma_resv *resv,
> -		       struct dma_fence **fence)
> +static int amdgpu_ttm_fill_mem(struct amdgpu_ring *ring, uint32_t src_data,
> +			       uint64_t dst_addr, uint32_t byte_count,
> +			       struct dma_resv *resv,
> +			       struct dma_fence **fence,
> +			       bool vm_needs_flush)
>   {
> -	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
> -	uint32_t max_bytes = adev->mman.buffer_funcs->fill_max_bytes;
> -	struct amdgpu_ring *ring = adev->mman.buffer_funcs_ring;
> -
> -	struct amdgpu_res_cursor cursor;
> +	struct amdgpu_device *adev = ring->adev;
>   	unsigned int num_loops, num_dw;
> -	uint64_t num_bytes;
> -
>   	struct amdgpu_job *job;
> +	uint32_t max_bytes;
> +	unsigned int i;
>   	int r;
>   
> -	if (!adev->mman.buffer_funcs_enabled) {
> -		DRM_ERROR("Trying to clear memory with ring turned off.\n");
> -		return -EINVAL;
> -	}
> -
> -	if (bo->tbo.resource->mem_type == AMDGPU_PL_PREEMPT) {

As far as I can see, you didn't add this check back elsewhere. The 
promise for preemptible BOs is, that we never have to wait for the GPU 
to finish accessing the BOs because the context using it is preemptible. 
This was a necessary condition to disable GTT usage accounting for such 
BOs. If you allow filling such BOs with this function, you're breaking 
that promise.


> -		DRM_ERROR("Trying to clear preemptible memory.\n");
> -		return -EINVAL;
> -	}
> -
> -	if (bo->tbo.resource->mem_type == TTM_PL_TT) {
> -		r = amdgpu_ttm_alloc_gart(&bo->tbo);
> -		if (r)
> -			return r;
> -	}
> -
> -	num_bytes = bo->tbo.resource->num_pages << PAGE_SHIFT;
> -	num_loops = 0;
> -
> -	amdgpu_res_first(bo->tbo.resource, 0, num_bytes, &cursor);
> -	while (cursor.remaining) {
> -		num_loops += DIV_ROUND_UP_ULL(cursor.size, max_bytes);
> -		amdgpu_res_next(&cursor, cursor.size);
> -	}
> -	num_dw = num_loops * adev->mman.buffer_funcs->fill_num_dw;
> -
> -	/* for IB padding */
> -	num_dw += 64;
> -
> -	r = amdgpu_job_alloc_with_ib(adev, num_dw * 4, AMDGPU_IB_POOL_DELAYED,
> -				     &job);
> +	max_bytes = adev->mman.buffer_funcs->fill_max_bytes;
> +	num_loops = DIV_ROUND_UP_ULL(byte_count, max_bytes);
> +	num_dw = ALIGN(num_loops * adev->mman.buffer_funcs->fill_num_dw, 8);
> +	r = amdgpu_ttm_prepare_job(adev, false, num_dw, resv, vm_needs_flush,
> +				   &job);
>   	if (r)
>   		return r;
>   
> -	if (resv) {
> -		r = amdgpu_sync_resv(adev, &job->sync, resv,
> -				     AMDGPU_SYNC_ALWAYS,
> -				     AMDGPU_FENCE_OWNER_UNDEFINED);
> -		if (r) {
> -			DRM_ERROR("sync failed (%d).\n", r);
> -			goto error_free;
> -		}
> -	}
> -
> -	amdgpu_res_first(bo->tbo.resource, 0, num_bytes, &cursor);
> -	while (cursor.remaining) {
> -		uint32_t cur_size = min_t(uint64_t, cursor.size, max_bytes);
> -		uint64_t dst_addr = cursor.start;
> +	for (i = 0; i < num_loops; i++) {
> +		uint32_t cur_size = min(byte_count, max_bytes);
>   
> -		dst_addr += amdgpu_ttm_domain_start(adev,
> -						    bo->tbo.resource->mem_type);
>   		amdgpu_emit_fill_buffer(adev, &job->ibs[0], src_data, dst_addr,
>   					cur_size);
>   
> -		amdgpu_res_next(&cursor, cur_size);
> +		dst_addr += cur_size;
> +		byte_count -= cur_size;
>   	}
>   
>   	amdgpu_ring_pad_ib(ring, &job->ibs[0]);
> @@ -2082,6 +2056,56 @@ int amdgpu_fill_buffer(struct amdgpu_bo *bo,
>   	return r;
>   }
>   
> +int amdgpu_fill_buffer(struct amdgpu_bo *bo,
> +			uint32_t src_data,
> +			struct dma_resv *resv,
> +			struct dma_fence **f)
> +{
> +	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
> +	struct amdgpu_ring *ring = adev->mman.buffer_funcs_ring;
> +	struct dma_fence *fence = NULL;
> +	struct amdgpu_res_cursor dst;
> +	int r;
> +
> +	if (!adev->mman.buffer_funcs_enabled) {
> +		DRM_ERROR("Trying to clear memory with ring turned off.\n");
> +		return -EINVAL;
> +	}
> +
> +	amdgpu_res_first(bo->tbo.resource, 0, amdgpu_bo_size(bo), &dst);
> +
> +	mutex_lock(&adev->mman.gtt_window_lock);
> +	while (dst.remaining) {
> +		struct dma_fence *next;
> +		uint32_t cur_size;
> +		uint64_t to;
> +
> +		cur_size = min_t(u64, dst.size, AMDGPU_GTT_MAX_TRANSFER_BYTES);

For VRAM, the cur_size could be much bigger because we're not limited by 
the GART transfer window. I'm pretty sure that 2MB is going to add too 
much overhead. For the extreme 60GB BO example, it would require 
30-thousand IBs and IB frames to fill the entire buffer. That's a lot of 
VMID-switching, IB execution, fence signalling, interrupts, etc.


> +
> +		r = amdgpu_ttm_map_buffer(&bo->tbo, bo->tbo.resource, &dst,
> +					  PFN_UP(cur_size), 1, ring, false,
> +					  &to);
> +		if (r)
> +			goto error;
> +
> +		r = amdgpu_ttm_fill_mem(ring, src_data, to, cur_size, resv,
> +					&next, false);

If amdgpu_ttm_map_buffer updated the page tables, shouldn't the 
vm_needs_flush parameter be true? This flag should probably be returned 
by amdgpu_ttm_map_buffer.

Regards,
   Felix


> +		if (r)
> +			goto error;
> +
> +		dma_fence_put(fence);
> +		fence = next;
> +
> +		amdgpu_res_next(&dst, cur_size);
> +	}
> +error:
> +	mutex_unlock(&adev->mman.gtt_window_lock);
> +	if (f)
> +		*f = dma_fence_get(fence);
> +	dma_fence_put(fence);
> +	return r;
> +}
> +
>   /**
>    * amdgpu_ttm_evict_resources - evict memory buffers
>    * @adev: amdgpu device object
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> index d9691f262f16..bcd34592e45d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> @@ -35,6 +35,8 @@
>   
>   #define AMDGPU_GTT_MAX_TRANSFER_SIZE	512
>   #define AMDGPU_GTT_NUM_TRANSFER_WINDOWS	2
> +#define AMDGPU_GTT_MAX_TRANSFER_BYTES	(AMDGPU_GTT_MAX_TRANSFER_SIZE * \
> +					 AMDGPU_GPU_PAGE_SIZE)
>   
>   #define AMDGPU_POISON	0xd0bed0be
>   
