Return-Path: <SRS0=xdlw=LJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FE27C48BE5
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Jun 2021 06:54:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B1B561417
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Jun 2021 06:54:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B1B561417
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3159489DD3;
	Tue, 15 Jun 2021 06:54:00 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2069.outbound.protection.outlook.com [40.107.92.69])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3737E89DD3
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Jun 2021 06:53:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lguUW0rolk14xmySqkrdanBRaPcI7ru69OK7bpPiTXYAwMFMUg9t6B0h/H/4aeVP3d67lmnM71n3K6utbY8kbJE5hRogWnaFVipnMT1Aj68iDVWHH2yChDUtwBpsCjLkQfZ1IemFQ8B3Q7aYMGsGg0V2qA0nPOObiE80e7R9u9KFI0OBSvYr15QgSnbp0ZyFw5gc4tKHwUHfFTtB96kUROYQhKH7pKkrH5875ACDO+T3yxu8k96EILM3yNPCpyFJXltCTg8jwh8mqybb/HIKq6NX4zFH5Sxv+b0MxnQ+3JI7qOR7I0J+h3H7UWl99USCEkrbAnJ5fWjRYmMyC5v4MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YTio04kZ0S9oY8NTfpUoPBrZHCS09T4cWSbPxNeK3vs=;
 b=HRoSNBmulUn/bS9+dK3ea73uYHJgmA3JAIUCE4ZwMAn7Xb6Q+cBvWk8XKX/KgYv46Phz6t+KKmxPYaiaVR8zYFqGC8rUOIyNYg4LrOoptaKKpFy/pRo22GoIY903Opgi3BZXSKrNoqgTbQcKLNqf5ofZbXqgrY8dp47ldE8Pmc5a+txiYXsdxQpFlC4xHkusSEpU3wX9Eyxh9fCaVuC5ujL6BdaIXa+tIZbRQzNnLFxM0OtMxDlpCbjA0yqNZYy0eEgbZ00J2hQUto9nyZA7XNTcHz6lfb8/mRnVln1ljOflA1cyftR9V+4M90Q/8b4p4P6RUumll6F22f8EA3cy+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YTio04kZ0S9oY8NTfpUoPBrZHCS09T4cWSbPxNeK3vs=;
 b=lGBXjcog6Q0xkHVy4iNiMr9UpkQJA88UwrHkSXIwadLPgcHJgxyHEXv1ok23dwuY6vv6MhOkSBilNBfp25iqKO05GyAgkjVyeKuSiLKTtabcr9NsmH7qWyWwsfWHxPai2ZyzyL8cO692zvuCJQ3mNzDDVHXNGGxavCLMR0j9360=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by BL0PR12MB2516.namprd12.prod.outlook.com (2603:10b6:207:4e::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.22; Tue, 15 Jun
 2021 06:53:56 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6c9e:1e08:7617:f756]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::6c9e:1e08:7617:f756%5]) with mapi id 15.20.4219.025; Tue, 15 Jun 2021
 06:53:56 +0000
Subject: Re: [PATCH v2 1/2] drm/amdgpu: parameterize ttm BO destroy callback
To: Nirmoy Das <nirmoy.das@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210614192653.18239-1-nirmoy.das@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <66e1a5db-17f7-fb27-5155-29e194556210@amd.com>
Date: Tue, 15 Jun 2021 08:53:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <20210614192653.18239-1-nirmoy.das@amd.com>
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:f438:4e93:3853:400c]
X-ClientProxiedBy: PR1PR01CA0002.eurprd01.prod.exchangelabs.com
 (2603:10a6:102::15) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:f438:4e93:3853:400c]
 (2a02:908:1252:fb60:f438:4e93:3853:400c) by
 PR1PR01CA0002.eurprd01.prod.exchangelabs.com (2603:10a6:102::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.24 via Frontend
 Transport; Tue, 15 Jun 2021 06:53:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9b25db4f-16b6-440e-6063-08d92fca584a
X-MS-TrafficTypeDiagnostic: BL0PR12MB2516:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB251689EA112229BF407A9E6883309@BL0PR12MB2516.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lYrAGkDAJudnNTq9rHulmM+yEajHyTRRWbWDn6z/SNGf8hKFfBI3VCsh3VDSVCqyCX4BRsxzK1GE54fu0csRwD7HQPCjJCRBZVN9f+9UoZRUtHwWQbtDkPce+ssUjw8wLsNEZRjKMHODakJU9l9ZFSq7cyZpd7+XKzWQEBHJn+dEL0LvYvWPX6J5fnm/6DgB1uTui3ET8Me4n8vGDmw7BzpE4K6MnbqeQIVDpNdxistlczYQE50yNUI+ZhAArHERUHDSlAgD9xJgpO40fge/Zcj2a5SxOWr318OQ06UkGkkKXnnL8W4ROTSSGOGZVqFHsTzlWgh2vc96KAPqTkHVAGzSyCad/fUtQ68sH/iWGngRgAq6NlvTcpCZavv1Nd7zeIvXNQ1Vr6WUDHO71EOnSmXhY117qI41D31ykNr6pawuy+TcLwjy/xHy293VwGuB5d8MIQ9K+/J/1MqUDRUhERJKSTJHaqQ8PStqCgbf3lp9Wgc13Cbf8GTWd944DYVkX7KpQ1iHJjs5lNh2jaAgUmEfKf/zDCj+Fld5xzOzJxhhJOdgkL8tO7NTZMWAbMq+y5dn8OwYHGF0vCNOZcA6aU/I/LI4pPJX9NKCpu9a06CNi0RPY3GT/eUBEYeEmNxxy2v4B/YFgfqdCwkvE50r5nz38LHgSpc+Nc4hKYyW3Pw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3775.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(396003)(39860400002)(136003)(376002)(86362001)(36756003)(66556008)(8936002)(316002)(8676002)(83380400001)(478600001)(66946007)(31686004)(66476007)(6666004)(2906002)(6486002)(186003)(5660300002)(16526019)(2616005)(31696002)(38100700002)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WHRmbFdwUU8wTE9HUTdUQkVuRmN2REozb3JHRklXdFNzc2tiYUZnZ3Z4cjIv?=
 =?utf-8?B?dkpGMUZmbGgrMkIxY2txR2piSnZzNnhZZFQvUDViZVdwNUtaREhwZzZDdldC?=
 =?utf-8?B?ZDhvUVFjMkRMNEExWFJKeUs2eXhTZmpJaUJoVDgxWHcvQXdRUmRGQkU5Rm9v?=
 =?utf-8?B?TStMSktldFJyOWkxL29CQTZZMWEzMFBWb093SHJlUGZWU1ovZW5DS29WTXU2?=
 =?utf-8?B?TFBIS1pDellrQXMzK2JuMVNkUG9EbEtZbTJKOWRydDFoUEFsZjRXaVl1Kytq?=
 =?utf-8?B?M2xwMlVTTVRZNXhwZlJkckVMcCtoYlJQbkZFUk9UZUNSdXkvUE5FQjlINWJr?=
 =?utf-8?B?KzZ2V2ZoZnlwZWRkTEJKSHBPRDk2ZVNLUVhEanU1TVpxSkdPZmYxb1pVMjht?=
 =?utf-8?B?QU9kRFNlZWl3S0JDb251dEtMeEdCRW9uakZsSEtCclNaejNnRzllV0JiMXZx?=
 =?utf-8?B?WjNFU0JpSi9TaWF5aE1HUG04TVRYZDA3dzRZblYxbFlzWGVveTZidFJrUExH?=
 =?utf-8?B?aDNmbk1JZk9BQ0FmOXJPTjlPRTBtOUlOMW9ZVDR3d3JzdEgzYjdNelFHM0Z1?=
 =?utf-8?B?TnFscG1iSWRSamRZYlAxR1ZEMjM4M05yM1JtSzdpRGZZWkRqc3NXdjM0a3VJ?=
 =?utf-8?B?NXlMekdKT2dZc0ZXWlVUR1NvUW53SUorblpzNVJIamFRNkhwUERsYlN1b2NC?=
 =?utf-8?B?MW5LM29iR1hlVTdvdEE5NkF5RDVGSGRjWXJSbkdQZjhxdjhLQThrVE9jdWVC?=
 =?utf-8?B?R1pwMERLVUUvZ2VWWVpYNmtsUkUvaExJOVU2VVRIaEFTTTFIdDlYYkVZQ2hx?=
 =?utf-8?B?SXArWXRxdy9rcnE1WmZhMEh5dkZpT0h2SmJzbXlRZGgzZGNiSUpZTG1hb1Bw?=
 =?utf-8?B?K3FUMmpIbDhQdnlKVCtRaVY2czFOWFVuK0lidE9PZGZTTVFSbGlQZmgrMWhj?=
 =?utf-8?B?QndsMEtBVXhXRG85Vyt5NGc2MG1VenYyQzE3dnBicFdPM3NWQUtnQlpMRUM4?=
 =?utf-8?B?S2orSGhVNmtJaldSZ0dKWUpDME5OVzBDUmpQSkp1VkRMRXN4cmExc2E5dzJJ?=
 =?utf-8?B?OHNSMGIwUTVTK3dwKzJpRFhqOGVveUE2SlA4Nmx1eXNBNDc2M3ludjN6cHFv?=
 =?utf-8?B?Y3NMdktBaU05TFNWazIyK25VazNnWWVxTDZtQ2NIdHlLSjE0UWlMTm82MjNW?=
 =?utf-8?B?bTVNRUdhWTVvQWI3MmFWZUdCUW9RV0JVQVJZKzI1RjQyVnpzK0NLQXU2ZklM?=
 =?utf-8?B?N21qMTFzRVdjMUV5bEt1WmcxZTlYQ0pLWGhTUjY0YWF6NnNrOWRyekozM1RJ?=
 =?utf-8?B?dDcwVlQ4WFNCYTFZci90S1lJSFlzSFBCTXVvMTJXNVRKSWo4eVJWTWhBMDdB?=
 =?utf-8?B?Sk1xWmNyWCtaUlphOHVPTisvdnMxRzc2eUU0L1ZwbDZaV1FnTlVTUWhKWGZ1?=
 =?utf-8?B?NzIydENvc2RycGU1emlXYVFGcThjRWVSd29NQ1N1MGVXbW9oNTN5SnpMZ2t2?=
 =?utf-8?B?NHhENURLa2R2dU9NdFZ6TE1qUmIwc1FrZDVyRTlYNkJIc2VOTkQ5NW9zeW52?=
 =?utf-8?B?VTVBMS82RjlLcGdJcE9qWWQrZzVlVjA2TnJTcDFxVDhldHF4Vkp2WHB1OUhn?=
 =?utf-8?B?Znp5OXVGVzljK1lOeTMyQ0IwalpNYkhVNEdZOFlVZTFtbVdzdkNubHJoQkps?=
 =?utf-8?B?UXhFTmRIYTEyczdzS1JaRVFlMmVTMkdJSGpQVjZBR2swVnprdzYvNXRzeEVQ?=
 =?utf-8?B?ZkI3ckdMeUZBS0s1SkNBbTJzazdic2FEMlQzRkZ5L09qajdSQnhjTXNyYWZj?=
 =?utf-8?B?Y0lRRGZkSlpBT3k5ZGZNN3NDa0UzVjFwcHFMd2xzNmNoR0I5ZEVrd3ArdGo2?=
 =?utf-8?Q?cJni8MSSULwdD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b25db4f-16b6-440e-6063-08d92fca584a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2021 06:53:56.2053 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gno76B+BWpvFdsbmaspBupDZezAbbB0VCVPp57hyaooL4OBzKJMH47vl/77DQUPJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2516
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 14.06.21 um 21:26 schrieb Nirmoy Das:
> Make provision to pass different ttm BO destroy callback
> while creating a amdgpu_bo.
>
> v2: pass destroy callback using amdgpu_bo_param.
>
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 52 +++++++++++++++++-----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |  3 +-
>   2 files changed, 42 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index 9092ac12a270..f4f57a73d095 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -12,7 +12,7 @@
>    *
>    * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
>    * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> - * FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SHALL
> + * FITNEsS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SHALL
>    * THE COPYRIGHT HOLDERS, AUTHORS AND/OR ITS SUPPLIERS BE LIABLE FOR ANY CLAIM,
>    * DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
>    * OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE
> @@ -73,11 +73,9 @@ static void amdgpu_bo_subtract_pin_size(struct amdgpu_bo *bo)
>   	}
>   }
>
> -static void amdgpu_bo_destroy(struct ttm_buffer_object *tbo)
> +static void amdgpu_bo_destroy_base(struct ttm_buffer_object *tbo)
>   {
> -	struct amdgpu_device *adev = amdgpu_ttm_adev(tbo->bdev);
>   	struct amdgpu_bo *bo = ttm_to_amdgpu_bo(tbo);
> -	struct amdgpu_bo_user *ubo;
>
>   	if (bo->tbo.pin_count > 0)
>   		amdgpu_bo_subtract_pin_size(bo);
> @@ -87,18 +85,40 @@ static void amdgpu_bo_destroy(struct ttm_buffer_object *tbo)
>   	if (bo->tbo.base.import_attach)
>   		drm_prime_gem_destroy(&bo->tbo.base, bo->tbo.sg);
>   	drm_gem_object_release(&bo->tbo.base);
> +	amdgpu_bo_unref(&bo->parent);
> +}
> +
> +static void amdgpu_bo_destroy(struct ttm_buffer_object *tbo)
> +{
> +	struct amdgpu_bo *bo = ttm_to_amdgpu_bo(tbo);
> +
> +	amdgpu_bo_destroy_base(tbo);
> +	kvfree(bo);
> +}
> +
> +static void amdgpu_bo_user_destroy(struct ttm_buffer_object *tbo)
> +{
> +	struct amdgpu_bo *bo = ttm_to_amdgpu_bo(tbo);
> +	struct amdgpu_bo_user *ubo;
> +
> +	amdgpu_bo_destroy_base(tbo);
> +	ubo = to_amdgpu_bo_user(bo);
> +	kfree(ubo->metadata);
> +	kvfree(bo);

Why not freeing the metadata first and having the kvfree() in 
amdgpu_bo_destroy()?

Apart from that looks good to me.

Christian.

> +}
> +
> +static void amdgpu_bo_vm_destroy(struct ttm_buffer_object *tbo)
> +{
> +	struct amdgpu_device *adev = amdgpu_ttm_adev(tbo->bdev);
> +	struct amdgpu_bo *bo = ttm_to_amdgpu_bo(tbo);
> +
> +	amdgpu_bo_destroy_base(tbo);
>   	/* in case amdgpu_device_recover_vram got NULL of bo->parent */
>   	if (!list_empty(&bo->shadow_list)) {
>   		mutex_lock(&adev->shadow_list_lock);
>   		list_del_init(&bo->shadow_list);
>   		mutex_unlock(&adev->shadow_list_lock);
>   	}
> -	amdgpu_bo_unref(&bo->parent);
> -
> -	if (bo->tbo.type != ttm_bo_type_kernel) {
> -		ubo = to_amdgpu_bo_user(bo);
> -		kfree(ubo->metadata);
> -	}
>
>   	kvfree(bo);
>   }
> @@ -115,8 +135,11 @@ static void amdgpu_bo_destroy(struct ttm_buffer_object *tbo)
>    */
>   bool amdgpu_bo_is_amdgpu_bo(struct ttm_buffer_object *bo)
>   {
> -	if (bo->destroy == &amdgpu_bo_destroy)
> +	if (bo->destroy == &amdgpu_bo_destroy ||
> +	    bo->destroy == &amdgpu_bo_user_destroy ||
> +	    bo->destroy == &amdgpu_bo_vm_destroy)
>   		return true;
> +
>   	return false;
>   }
>
> @@ -592,9 +615,12 @@ int amdgpu_bo_create(struct amdgpu_device *adev,
>   	if (bp->type == ttm_bo_type_kernel)
>   		bo->tbo.priority = 1;
>
> +	if (!bp->destroy)
> +		bp->destroy = &amdgpu_bo_destroy;
> +
>   	r = ttm_bo_init_reserved(&adev->mman.bdev, &bo->tbo, size, bp->type,
>   				 &bo->placement, page_align, &ctx,  NULL,
> -				 bp->resv, &amdgpu_bo_destroy);
> +				 bp->resv, bp->destroy);
>   	if (unlikely(r != 0))
>   		return r;
>
> @@ -658,6 +684,7 @@ int amdgpu_bo_create_user(struct amdgpu_device *adev,
>   	int r;
>
>   	bp->bo_ptr_size = sizeof(struct amdgpu_bo_user);
> +	bp->destroy = &amdgpu_bo_user_destroy;
>   	r = amdgpu_bo_create(adev, bp, &bo_ptr);
>   	if (r)
>   		return r;
> @@ -689,6 +716,7 @@ int amdgpu_bo_create_vm(struct amdgpu_device *adev,
>   	 * num of amdgpu_vm_pt entries.
>   	 */
>   	BUG_ON(bp->bo_ptr_size < sizeof(struct amdgpu_bo_vm));
> +	bp->destroy = &amdgpu_bo_vm_destroy;
>   	r = amdgpu_bo_create(adev, bp, &bo_ptr);
>   	if (r)
>   		return r;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> index e36b84516b4e..a8c702634e1b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> @@ -55,7 +55,8 @@ struct amdgpu_bo_param {
>   	u64				flags;
>   	enum ttm_bo_type		type;
>   	bool				no_wait_gpu;
> -	struct dma_resv	*resv;
> +	struct dma_resv			*resv;
> +	void				(*destroy)(struct ttm_buffer_object *bo);
>   };
>
>   /* bo virtual addresses in a vm */
> --
> 2.31.1
>

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
