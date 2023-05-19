Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D7C5C77B75
	for <amd-gfx@archiver.kernel.org>; Fri, 19 May 2023 20:37:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1221910E0D2;
	Fri, 19 May 2023 20:37:38 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2047.outbound.protection.outlook.com [40.107.244.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B331110E0D2
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 May 2023 20:37:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ODQX1HWvgnlHh5W3md0Xwo0Lsj1p91RWF2uPQ5ZS6ly9nID/2RsgW9ClBcqrleUH3YhVMBpI85ok8HnuSnDLAcIqnF9ugsbq5tP9WY+KNOE/2oUpT/rGPHgQIhT8OJXD5tvYg0J03sbYhN8FZGFQFPaSfe/PTTOFXYU2u9eMggkxkXgVovl175qMWuWrMm8eIC/YPst/XBy+AXCe4E8jWgoQxGUMqOQOW/9g6XOnZj0PqAmfHX+OD/qUSmyAbjAW7Oqqu7md96DdhM65wuTO4jvIEMeLHmDCpxQcQmtppegwNQpkPmLVGEbD9BTlzW0Lp2HA2sAGFDRSttvalDwt0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AK4D2kFDTwdWBJbl3rLULoYACc1cLvr02VMmJkdWccg=;
 b=CCu1A4MHCfai7cAeTA0tjwGFRIFEsix0BfYU30ls1G/LTvZPTGn2lq7mlSnkD+BKvyUEPXNyLVtb4P49+i8ODXJVi+ZRhqD8JMUmkoFXHJXLPMoITKcJsxRBOrvSKAV2BsgpY8ZDJh7Ptfzwd3Qt7QU3+RV3huwSwVEKIQc5MpHePps9pMHAfwkuzbovu2MHYYzxGsYB3CCwRbI+7J0I/xhTLHoIBcIYeQiIlhHlRsOrZ4cR2GdZYyH+mOS+4QQPgjTbBDglIZjhOYODSQXzgK87eO5MyxBglxJZx6hgUDulZpPYcfPfvMzCNLMTa+Mv945mZ2Vuwp1rdX15zgp3JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AK4D2kFDTwdWBJbl3rLULoYACc1cLvr02VMmJkdWccg=;
 b=YBsFIJzUS8s9eiFyWLQip6TYAeBsJ4Wp2G37sfeSGc9FUB/Cd9qK2+xYy4p6rjI+rFw0oRqvrQYC8XxeB4Be7OcQaAGdhA0AUa4dPrsBjfowfNvHLzpaS9b2YBsgIiGDUJnMNaFe11mh6UbRZmzoOLQzjTuVl9hrVi3qcN+d2m4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DM6PR12MB4467.namprd12.prod.outlook.com (2603:10b6:5:2a8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.21; Fri, 19 May
 2023 20:37:33 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::f170:8d72:ca64:bb26]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::f170:8d72:ca64:bb26%7]) with mapi id 15.20.6411.019; Fri, 19 May 2023
 20:37:33 +0000
Message-ID: <d12db2ad-a2b3-8a90-a880-b749fc55fadf@amd.com>
Date: Fri, 19 May 2023 16:37:31 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2] drm/amdgpu: Fix the EPERM error when get user pages
Content-Language: en-US
To: Ma Jun <Jun.Ma2@amd.com>, amd-gfx@lists.freedesktop.org
References: <20230519120252.3383090-1-Jun.Ma2@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20230519120252.3383090-1-Jun.Ma2@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR01CA0040.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:2::12) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|DM6PR12MB4467:EE_
X-MS-Office365-Filtering-Correlation-Id: 799e20a9-f8f5-47e6-3157-08db58a8df9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xeCF8f84GwjtGPeflOyXHArSS460fmjVMZ/qbK92GJ8lnFV5sYro6fh/RRFwVjx+aAvtFCKVkfDFjBPaGMBs9Zqy41BC6iEVjrPs/23B3PpTz0gzsuJMtl74iOtz9kobmqOHb8tONFnaDJYWRQHL1v6vVoGC/g4dQrpOazMwQbBcbVgROHRtl5A+o6gip4pBQbdvPch/pnsOdNfkUHQ98cAI7/ENzAEWFIB1+EDIJ9Au/cOWEgVgzxDm1DfsqzdkT/4sgM8X0jlqkbm8KldIuVx4aojC5rKU+EFK2JwDB67sXh/kfynsmP6IU7Li6phYMCLGy6+r5ERorDEMu9WclkpkEttXOv+ZoUGdiELjYopvj41mipLMe/3/oylWvFuXVEvAO0Mb1LJpHH7waRGYlvGbRbVknSr0+scfzuS9IeZOMo8wsLs8Ob4+1hzxXZRLP73sGhOBSOBB5qjOK+hfzSWnhv0lhNaqxa/rSE5xvzXSj0ee6D6HqYBM3TbPYj4xOCOFncrvUDcimlSN6heby4jYwYaXxWw/tRcamjEeoDDGnGXdF3MvADGmXlyCLRbw2ZAt4VuYRFvrsgBisZNv0Sc1DwC1mjzOfU7nau4pd08BblHUEcKh5qzkyAyo100LEfTcu9UZp+KenGUiKL/ulg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(396003)(136003)(39860400002)(366004)(376002)(451199021)(31686004)(4326008)(66476007)(478600001)(36916002)(66556008)(66946007)(316002)(31696002)(36756003)(86362001)(83380400001)(26005)(186003)(6512007)(6506007)(53546011)(2616005)(5660300002)(8676002)(2906002)(8936002)(44832011)(6486002)(41300700001)(38100700002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?anhFVm1CNUE0RmxKRG9JUElTOEpvUHJ1SWdUdzJQR3dtcURrM1JqMlZnSFAx?=
 =?utf-8?B?ejZRaWlXdTladE9FdzVOak0yRWwzVW9hUUJkZFI1M1VidVZRaFVabFJibFBu?=
 =?utf-8?B?czRaWWUvRVVmM3VEY1podWJNektkTzYrQ3c5ZTBRN0NKQkh5OGhIWXQwNmpt?=
 =?utf-8?B?NDRVdTdxeUxNVVQ2ODdtU1N2aERGZ2tNVkxJb1VXN01BR0w0eU9nMmRJaEJx?=
 =?utf-8?B?VlpEeEVEb1JHblA3dHNIbEMwc29WQ2Z4ZENlWitHOWJxK0d2cU5wRUp2OC9F?=
 =?utf-8?B?WEdySUEyb3pWRUJnUWNrUHh5a1FOaVppMHg2SWtGcnMyRnBhWklTamhEbGZj?=
 =?utf-8?B?dHZEUmJWUU5TRFdjWXdrZjVzV2RvQitwTDJBWXdPY3dyVitRMlEyN0kyUHk2?=
 =?utf-8?B?TjVxWU9SUmxOcUxNaWh6RmVJcWJseXczeTNhaDhJRk5ZdVZXSkNHUUo0NEQx?=
 =?utf-8?B?a01KQ0dhcU4rMTNhNnR6NHNyYks1cXlJY1JUWHYvVW94SEozdVV5WVNNQnha?=
 =?utf-8?B?ang0SE9DMUl3Q0V5RFc4S0FBaS9QdjEvcE1IKzBHUDN6ZjhDSjBjazZZZUVG?=
 =?utf-8?B?QlBLTHlPNXdPUlVhUGRjZERNNlZZektOeGFxakdpcVBaVTduRXRBL05LeURy?=
 =?utf-8?B?UXRiUUtmSGhZVnVWMHk2aWIwZFhSanRXWWNPS2lKMldYUGc4MHcra2tuRTF4?=
 =?utf-8?B?cFNiejRnczJVMWxkVTV1R2I4NnJ6U3AreWJwYnJHWCtJcHdGOGxoM2w2R2J6?=
 =?utf-8?B?Z0ozL1JBbC9EaXZuL0NXV1lqT3RHS0l6eXVvMVdlWThndjFwMFFRTGxoMnRB?=
 =?utf-8?B?R1lRWlF4REt6WEJuNkJTT0VyZmdtc3grMHJQUE9zVzJSeVVrc0NVbWlBMWQy?=
 =?utf-8?B?dGVjZjFzRGhLMXB2N1R2c2czWlJXblllSWxWTFBUN21uNklaeXVKQzlBLzBn?=
 =?utf-8?B?QWFPSzVMcjdUN0pYMXJWOEl1RHQwYWdkZGJ3dXhwWUo4dkRpblBHTGJCZ28v?=
 =?utf-8?B?UEU0WEUzUHNRMWxkbHZQN05ydEVVTDlrenhDZHB3UFBpN0dLbitTQk5rMkYz?=
 =?utf-8?B?QmZVWU9vSFpwM1l3N2tQY2xuRlJHWHhTWjNXWVA4WUhiQ0htUnZkU3pObkFk?=
 =?utf-8?B?VWZtbGxnSlVqbGQ5RDd3UXU2WHExOEwvSXdIZGJYVm9YN21veWhNUHVXZDVp?=
 =?utf-8?B?RDB1ZlJIVlJjWnNsN2NSaGNzN2VrZGZic05oUmM3U1F6ZXFhMUdJR0lTVmdo?=
 =?utf-8?B?UVU4OXF1RE0zZ2FnWWtucjNsTHk1VEtZaTJYdnFIdFVGSDRkeklZUlJZZmlE?=
 =?utf-8?B?cWZGN2FTUEdGeXI4d0FUWmtySE9jL2xmcXp6UnJyWGJpRFZQRTByL3VJSnRl?=
 =?utf-8?B?c05vQ3RTdnNkQlU4OTV1aWdacnpvWE9Ua0VJdFNIYnVYcUgvYkVGc3VQYzY5?=
 =?utf-8?B?eVczNDVVV3A1dTBLYkZyUWU1Nk5NMzFxOU9hb2RxNHFOckdYSHY4MVV0SXVU?=
 =?utf-8?B?QTVibXh2YVUrOXh1NEFEeUtMMWlPOEF1Wkp1MlIweTlCSDFTeW5jSi85RFZ2?=
 =?utf-8?B?L3AvZ3pYQk9odzl2OTZwb1hUb0FLb2dEdTJRcnd4V0JsbUZheFZ6QWVpOUtu?=
 =?utf-8?B?dGt0ZE5YRDA3N210TDdrbytMOERzRDBEY1BKL2Vva2J1ZEc4b29lUXVIYlVS?=
 =?utf-8?B?VVR1aXJJVEpRTHkxK0J3NURuZzZOcXZuOG5vQmJ6TWgrdW1MVUxsejd4SjFN?=
 =?utf-8?B?NHR4ZlVLanh5dFNBZmJEUGl5VzBkak5DQjdBemZYN1hCVkJhMWdZZTl1bGtx?=
 =?utf-8?B?bUY3SzhnWGJvZ29EaWQxakZuRlhnRDdNaUFuUHAyMWVReUNvdTJubzVYNDdu?=
 =?utf-8?B?alpzZjFUaHJuaS94K2ZMUDhTcS92dUlRenRDUlZRMlB1TUkwQVBUN2d3S3pS?=
 =?utf-8?B?LzFoUUxsVWxiQXBiM0V2NEVkTFh3TlJSeFNUcGJOeHZHOUpnQnZYemxiTFZn?=
 =?utf-8?B?Uis2VjhuNnpnMjdBOTE5OUJjeXN3bWFOekFyeG5iTTVPZlV1bE5zWTBadGQ5?=
 =?utf-8?B?Nk03N0p1WmdGVXIvWXgzWVdBYXNoallVZUZpd1puTlRwMHJTZW51ekowM1NQ?=
 =?utf-8?Q?yq469WUATdru9QAgV066gj0vb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 799e20a9-f8f5-47e6-3157-08db58a8df9e
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2023 20:37:33.3974 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F2JudAm3Wc5q3gmSotOlYx5xIM8YrfR6MRtkDQOE+3oyNds7miW40vbgKepU8rKPUejRf+nB+2voknNm3PoFtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4467
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
Cc: alex.sierra@amd.com, Alexander.Deucher@amd.com, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2023-05-19 08:02, Ma Jun wrote:
> Check and pass the readonly flags when set amdgpu_ttm_tt flags
>
> for readonly ptr pages. Otherwise, there is EPERM error returned
>
> during the KFDExceptionTest.PermissionFaultUserPointer test on
>
> ploaris10.

I remember you asked me about this maybe 2 weeks ago. I'm still not sure 
how your test is supposed to work correctly. Someone needs to decide 
whether to set KFD_IOC_ALLOC_MEM_FLAGS_WRITABLE when registering the 
userptr. How does this happen? I think you need some code that checks 
that the VMA is read-only and then clears the WRITABLE flag from 
mem->alloc_flags. But I don't see that anywhere. I don't think we ever 
added proper support for read-only userptrs in KFD. Your patch is a 
partial fix at best, and I don't see how this helps.

Two more nit-picks inline.


>
> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index d426333e865a..85d1087439c0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -1036,10 +1036,17 @@ static int init_user_pages(struct kgd_mem *mem, uint64_t user_addr,
>   	struct ttm_operation_ctx ctx = { true, false };
>   	struct hmm_range *range;
>   	int ret = 0;
> +	uint32_t tt_flags = 0;
>   
>   	mutex_lock(&process_info->lock);
>   
> -	ret = amdgpu_ttm_tt_set_userptr(&bo->tbo, user_addr, 0);
> +	if (!(mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_WRITABLE))
> +		tt_flags |= AMDGPU_GEM_USERPTR_READONLY;
> +	else
> +		tt_flags = 0;

This else-branch is unnecessary because you initialized tt_flags to 0 above.


> +
> +

Double blank lines. One is enough.

Regards,
   Felix


> +	ret = amdgpu_ttm_tt_set_userptr(&bo->tbo, user_addr, tt_flags);
>   	if (ret) {
>   		pr_err("%s: Failed to set userptr: %d\n", __func__, ret);
>   		goto out;
