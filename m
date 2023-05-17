Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADE16C77B7D
	for <amd-gfx@archiver.kernel.org>; Wed, 17 May 2023 19:26:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E27310E25F;
	Wed, 17 May 2023 19:26:45 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::601])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB04A10E25F
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 May 2023 19:26:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VkZX2cDqmpC561etTj6kw+r6FnVFOvTbutzQx2JGcjd93FgNCCQQk/hkK4B9k6L3pUEXwAG/yVRQ6WeljBBlFBCRYMZfchODeaPaaUpJyPcxHqbko93opC2Jy/P9D6T1ekN5Yc63D6Yp63dTghkLzeD5HpxI60B4j4Ye86PQ/BzsdMO0HfYufNA6kNnEvRqXc9Tr4ZGwpumY24rqe8OK0irRkj4MKVhe8HvESzlnexuYNkzNk/53va5Huz3pKmV0IWUbLhyFYuSyePeLs15pXamyjNpnRbYfmelW5bki8xVooSu1JjWTYjgT6Azkdy84CNjw5SfrTAqFFo3Gy2XOSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MdDvXMu8TwAG5gSofAH8a7R3GUx1ZDInScME1OWsZlo=;
 b=hrfD45xOclN1Pd5RvKWFxB7tENBD12YIOY4M5/JdqkvlqWb6SmwaUOP/nANf7paKB0vgANfsZbDdvYvAKjnPWOZJF22GytoLUB8loTqoRsAp0ojgsPsdyxK1P140+KYiHYNS1Q7t9bHHXF6XB0xDi9HkNVLzAx0F5yFHC4AfFNWGDMk899MMbjMtQKKqJz8nOsO7BHhwHuriiT9B0F3dQWxtCc4Neeke6Ii2eWXK4RnpyXs2NOVKDyL7Y3jFD8DxxDABD7xxV/8C9uDb8Y+vef3xys7nyv1HTWCmLPrCdmu3mHG6snVZqqvh/x2R+tl//RCjw2CGkK5M45NObOJsTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MdDvXMu8TwAG5gSofAH8a7R3GUx1ZDInScME1OWsZlo=;
 b=uqCTOyZUra0zhR+0WVM49ooxbgurLsEuauuay9QUimX0zf2tjn4AUEMrP8s4+fspk1/azo7MetNhNV9XBeoMt2t5PlBDpmE0hYutSXfrxbycsZpqNvNt7fLv2qdq5Hdv7m9zBoakmnBI1/ECP5wfiQ3UvxvSUkJzSE1WYNR6Bs4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by IA1PR12MB9029.namprd12.prod.outlook.com (2603:10b6:208:3f0::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.17; Wed, 17 May
 2023 19:26:41 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::f170:8d72:ca64:bb26]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::f170:8d72:ca64:bb26%7]) with mapi id 15.20.6387.033; Wed, 17 May 2023
 19:26:41 +0000
Message-ID: <da31a740-84ce-9889-61fc-c671b94b6138@amd.com>
Date: Wed, 17 May 2023 15:26:38 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/amdkfd: fix stack size in svm_range_validate_and_map
Content-Language: en-US
To: amd-gfx@lists.freedesktop.org,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20230517190605.205199-1-alexander.deucher@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20230517190605.205199-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0060.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:88::27) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|IA1PR12MB9029:EE_
X-MS-Office365-Filtering-Correlation-Id: abd8d197-5f8e-41dd-356c-08db570ca412
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gl0iIFZphrODkQQhO5F6wT7Xhw1hk2U/1YdxqGWXnJZM15R32cuVvCzg8g8c+7psKtn3OiIhhEGnOQIijyPeHHjAZJa6FddnSbJy5j/jmXwg37sxpbWblX+lr/Wwbg0DgqV2ABlveW/yJ+aBGjz3Hz+EK6uZyjjd0FvtGLPM31XwWv0byAIH0HSisT6TmDiQsXvt6pfy5M7isu6oULcytVc7V3MU4ZCHC3tmXOeqPzoTP2X0OFKN+Xz5qhYS4CIrJwKYDAuJDGbKxmtRm+PVQsJ3Q6ptyTeqgYaLZnm33Yu31pkO9zLLCO62FB9BkfZ13LoragqYtupnJzpzcw2eD2AGKtm3At69rE9DhrayYWwcRwfkvS9N+RdDMg7a0gvNjwdadQvqqQ3OsFJ1HNGwdLx0VwVUZxSZIjcIiMd2ixE9ifUe/oou99ZPAXHGjyBJWqzm+Uy9ZM0WHaRVcIPpdQ7pfe9akj5cRzCIelc1Q/Q4O02naRxguOZakBcuafl83zWWI6y8Et0DKJCLhdZiw3P7rvTnVC9HDANScdsTJ4ZCIGj+rrcgsMwIBWQKXS1MDqE//Ye+V1hspIw7Me/wexETr06VNQgFqIYG2z50RA1Z4mszT9pfyhEz5anWaOJk55/sTmzVXeJeF8gPD5hYxA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(376002)(136003)(346002)(39860400002)(366004)(451199021)(83380400001)(6486002)(36916002)(478600001)(37006003)(2616005)(6666004)(26005)(186003)(44832011)(6506007)(53546011)(6512007)(8936002)(5660300002)(8676002)(36756003)(6862004)(6636002)(41300700001)(66556008)(38100700002)(66476007)(2906002)(66946007)(86362001)(316002)(31696002)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UWlOVCtWcGVVWU9ZM0N5R0UrU2kweWJXZWRnVmRIQkliM1Avam5XSjdLdkNI?=
 =?utf-8?B?YjhQNkFFTXRRUllmc2xMMkxXb0JHMGlGV0s5eVl5VXdkaThKWlZjWFBWbXpG?=
 =?utf-8?B?cG0yc2dsUXg0dHNsZ2xOdmUwS09IY2JtODJBRVNSNGNHOVZGR3dpMDIxSStE?=
 =?utf-8?B?Szd2MlIzWU0wZ1RXTjg1NkdQa01BWFRWT2tvQmxHVENZcnVnVisvNXRDWGZw?=
 =?utf-8?B?UXZqczNlNTYxcTdETkRwNThKbHRPQ0hXWEZXSExqNnpuemJkNWpMTDNscEdY?=
 =?utf-8?B?UjU5ODQ3VktkVkx4K3dCSkNkWHAxanV1V3llNWJuMVdRM08xSXF5N0VMVmhv?=
 =?utf-8?B?OU5Gd2szWVMrZWtycVVqQXRDMWMxSVR1TTZMWHptTFFVaEhoVkdVemZQblNs?=
 =?utf-8?B?S0tJQkNsVlkwaUovNkM2eXVaZjlocW5jdi9GOE5LRGtDbTVsOEpvSWd4YWhO?=
 =?utf-8?B?V25WaXlMb3dFMnB3MTR2MDFUSGJUaTlHdEFkOGxkcTl5Y1pvOHRnRUlFTFF5?=
 =?utf-8?B?YUpZZXFCRHZkWnlPNThrdGhBRXFVUUQvWEtOVC9SMXdOR3ErZnVFcWRXazFB?=
 =?utf-8?B?aWVnY0V4RTlpM0lCS2dnM0Y5eElMbm92Y3hXeC9ST2NFa1Y0ajE4aXFsVVd2?=
 =?utf-8?B?NnRWeEVMbEluYVEyMHdHZnFEZ0ZSTk10SE5aQmtwRVRoSGJ3Tm5qaXVWd3Va?=
 =?utf-8?B?U29aV0NYVmMyVTBaOGliNlpYTDVwMExIU1JYaGVSbTA5dVVGaktOSFhJU2Uw?=
 =?utf-8?B?Z3NoSDJ5VzVVSHlBQ2VNYlNSbHFwSk9rZUliTEtpdzdla21iQlVzU2dQdVVD?=
 =?utf-8?B?anA3VktEREhSbXduWjk2alZ6QTJMT2RZb1JnRktiak85dHRQbXF1ZjBqT29F?=
 =?utf-8?B?WDJCTnZiMkJzRmpRUm5oQzA3VVdIR1BZVk9idVdaRVA3OW5hZ0ZzZmZEaDlP?=
 =?utf-8?B?RFNCd1MzQ1lzQ2NBYVk4aHVZT0lzVlNvbFoxU0hWaUxiWmszenhrb04wV093?=
 =?utf-8?B?Z1NHb20wL1Q5VDNlMzVLK2Y0QzhCQ1VHTVoxRlJJRUN3cHAxQ0drV1NxRkMr?=
 =?utf-8?B?T0dYdUVLZkxMWWxqUUNVeDBNcG9Qdm1Mb0lnSUFmYXYvbGlUZFRWNXpWdmJk?=
 =?utf-8?B?NmFJQ2h3am5HSlZSUlprWE5RNXFVZWJZdnpsR2ltcTkwVmFwWUdZcThKcnly?=
 =?utf-8?B?N2U4ZE9jTW5iR0Q1TWVhZTNBVjEwNFlmVkltQngrZzhCYTUxVzNRS1ZlUDJi?=
 =?utf-8?B?d3RISldnSm9XRDBuckJYOC9HTFQzV012ZlhpSi9XSktOUksrVmVKN3FtZStt?=
 =?utf-8?B?ZkwwZWxDV2RIaDNxcHJkNmJwSUNZOEF0ZDdMVEs2QlNNbFpObFFxTFM2M3N0?=
 =?utf-8?B?cmtvZHFrWWlRcjZGRFAyR2pYbzZzQmxuVVdTWDlyQloyaHBPNyt3UDg0N1Ny?=
 =?utf-8?B?VEVEZFVJWGYyOThYZVQxeWRJaFVTYWUwQjJwVjN0Zk5PUFpGN0NINTh5a0tT?=
 =?utf-8?B?K0h4SUhyS1UvRTZTbGtwNkRhU29IWENxRm1KRE1vd3dEc2xpdTFYNGM3bzB6?=
 =?utf-8?B?VVY4dmRycWVZZllaeG1xcTB6NkpyTVdHbjdlYkViS3FIb0pMTldCM3ZpVUtn?=
 =?utf-8?B?akVQeFo5WHdtUGcycjhuZXhNcVFxUHBHMXgzQnNPdTlta3pOWlRaeVRNVk9X?=
 =?utf-8?B?TS94RUViMk5wMlQ5eFpEMFhwMXNXaTFVTUhXQzhzdDlGOEF0VmhDazNVQXpn?=
 =?utf-8?B?V2RMTGlFV1pvT2ZmMVNKdUxBbE5Bb2k1SlQvMHlTWGZlOHdMRHltZksrWHZK?=
 =?utf-8?B?ckRXTENITG5PbTFJcFVtVWI1T2M5bHZjNVlDdEdrSlp6dVFWbmFWZUpJQnRM?=
 =?utf-8?B?SHFXVnlKd3JOMW5BSnhKRXA3eTk2WDlnNldIUkJ5ak5YeGZaQkhMZGlqTGZN?=
 =?utf-8?B?SmhFbU1MdFpUNW95anBmUmNBT3RMZlluY0JwZHNGMHJjLzArMlVJK0t3OXhk?=
 =?utf-8?B?MWlKNmhXcnNQZ3FaQk1USm1Ha0x1TnBwZG1sNm9EM1MrdDZ1YWNvQk9Qcmtx?=
 =?utf-8?B?L2ZvallCVG9iaGNEV0M0STJmVHZJZDU4SCt2N2RreFVJTitYemRyeDNFSDF4?=
 =?utf-8?Q?DNHNxEd6UzGwatARK3iGzPfu2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abd8d197-5f8e-41dd-356c-08db570ca412
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2023 19:26:40.9395 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FdgvD28rja6/r1x0nsfieBFEAOgF/bHDcLOckGsvMvG6yR71nAZ9QJ+9jvQhzoiR1ShNzFWODSHt5Kj6OVdxGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9029
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

On 2023-05-17 15:06, Alex Deucher wrote:
> Allocate large local variable on heap to avoid exceeding the
> stack size:
> drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_svm.c: In function ‘svm_range_validate_and_map’:
> drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_svm.c:1690:1: warning: the frame size of 2360 bytes is larger than 2048 bytes [-Wframe-larger-than=]
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

I guess the structure grew too big when we increased MAX_GPU_INSTANCE. 
The patch is

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 56 ++++++++++++++++------------
>   1 file changed, 33 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 9ae5ebf47eb5..fdcf56b4812e 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -1553,48 +1553,54 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
>   				      struct svm_range *prange, int32_t gpuidx,
>   				      bool intr, bool wait, bool flush_tlb)
>   {
> -	struct svm_validate_context ctx;
> +	struct svm_validate_context *ctx;
>   	unsigned long start, end, addr;
>   	struct kfd_process *p;
>   	void *owner;
>   	int32_t idx;
>   	int r = 0;
>   
> -	ctx.process = container_of(prange->svms, struct kfd_process, svms);
> -	ctx.prange = prange;
> -	ctx.intr = intr;
> +	ctx = kzalloc(sizeof(struct svm_validate_context), GFP_KERNEL);
> +	if (!ctx)
> +		return -ENOMEM;
> +	ctx->process = container_of(prange->svms, struct kfd_process, svms);
> +	ctx->prange = prange;
> +	ctx->intr = intr;
>   
>   	if (gpuidx < MAX_GPU_INSTANCE) {
> -		bitmap_zero(ctx.bitmap, MAX_GPU_INSTANCE);
> -		bitmap_set(ctx.bitmap, gpuidx, 1);
> -	} else if (ctx.process->xnack_enabled) {
> -		bitmap_copy(ctx.bitmap, prange->bitmap_aip, MAX_GPU_INSTANCE);
> +		bitmap_zero(ctx->bitmap, MAX_GPU_INSTANCE);
> +		bitmap_set(ctx->bitmap, gpuidx, 1);
> +	} else if (ctx->process->xnack_enabled) {
> +		bitmap_copy(ctx->bitmap, prange->bitmap_aip, MAX_GPU_INSTANCE);
>   
>   		/* If prefetch range to GPU, or GPU retry fault migrate range to
>   		 * GPU, which has ACCESS attribute to the range, create mapping
>   		 * on that GPU.
>   		 */
>   		if (prange->actual_loc) {
> -			gpuidx = kfd_process_gpuidx_from_gpuid(ctx.process,
> +			gpuidx = kfd_process_gpuidx_from_gpuid(ctx->process,
>   							prange->actual_loc);
>   			if (gpuidx < 0) {
>   				WARN_ONCE(1, "failed get device by id 0x%x\n",
>   					 prange->actual_loc);
> -				return -EINVAL;
> +				r = -EINVAL;
> +				goto free_ctx;
>   			}
>   			if (test_bit(gpuidx, prange->bitmap_access))
> -				bitmap_set(ctx.bitmap, gpuidx, 1);
> +				bitmap_set(ctx->bitmap, gpuidx, 1);
>   		}
>   	} else {
> -		bitmap_or(ctx.bitmap, prange->bitmap_access,
> +		bitmap_or(ctx->bitmap, prange->bitmap_access,
>   			  prange->bitmap_aip, MAX_GPU_INSTANCE);
>   	}
>   
> -	if (bitmap_empty(ctx.bitmap, MAX_GPU_INSTANCE)) {
> -		if (!prange->mapped_to_gpu)
> -			return 0;
> +	if (bitmap_empty(ctx->bitmap, MAX_GPU_INSTANCE)) {
> +		if (!prange->mapped_to_gpu) {
> +			r = 0;
> +			goto free_ctx;
> +		}
>   
> -		bitmap_copy(ctx.bitmap, prange->bitmap_access, MAX_GPU_INSTANCE);
> +		bitmap_copy(ctx->bitmap, prange->bitmap_access, MAX_GPU_INSTANCE);
>   	}
>   
>   	if (prange->actual_loc && !prange->ttm_res) {
> @@ -1602,15 +1608,16 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
>   		 * svm_migrate_ram_to_vram after allocating a BO.
>   		 */
>   		WARN_ONCE(1, "VRAM BO missing during validation\n");
> -		return -EINVAL;
> +		r = -EINVAL;
> +		goto free_ctx;
>   	}
>   
> -	svm_range_reserve_bos(&ctx);
> +	svm_range_reserve_bos(ctx);
>   
>   	p = container_of(prange->svms, struct kfd_process, svms);
> -	owner = kfd_svm_page_owner(p, find_first_bit(ctx.bitmap,
> +	owner = kfd_svm_page_owner(p, find_first_bit(ctx->bitmap,
>   						MAX_GPU_INSTANCE));
> -	for_each_set_bit(idx, ctx.bitmap, MAX_GPU_INSTANCE) {
> +	for_each_set_bit(idx, ctx->bitmap, MAX_GPU_INSTANCE) {
>   		if (kfd_svm_page_owner(p, idx) != owner) {
>   			owner = NULL;
>   			break;
> @@ -1647,7 +1654,7 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
>   		}
>   
>   		offset = (addr - start) >> PAGE_SHIFT;
> -		r = svm_range_dma_map(prange, ctx.bitmap, offset, npages,
> +		r = svm_range_dma_map(prange, ctx->bitmap, offset, npages,
>   				      hmm_range->hmm_pfns);
>   		if (r) {
>   			pr_debug("failed %d to dma map range\n", r);
> @@ -1667,7 +1674,7 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
>   		}
>   
>   		r = svm_range_map_to_gpus(prange, offset, npages, readonly,
> -					  ctx.bitmap, wait, flush_tlb);
> +					  ctx->bitmap, wait, flush_tlb);
>   
>   unlock_out:
>   		svm_range_unlock(prange);
> @@ -1681,11 +1688,14 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
>   	}
>   
>   unreserve_out:
> -	svm_range_unreserve_bos(&ctx);
> +	svm_range_unreserve_bos(ctx);
>   
>   	if (!r)
>   		prange->validate_timestamp = ktime_get_boottime();
>   
> +free_ctx:
> +	kfree(ctx);
> +
>   	return r;
>   }
>   
