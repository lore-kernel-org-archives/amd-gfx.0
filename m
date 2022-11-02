Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBE1FC433FE
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Nov 2022 03:16:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9561010E045;
	Wed,  2 Nov 2022 03:16:49 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2088.outbound.protection.outlook.com [40.107.237.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43DFF10E045
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Nov 2022 03:16:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GAPKL+dFWNKlPc0RlyTGvydA7flmfb6T43ozeNny36O2lTzBdKRzwKuDQ39YcBCG0nPIUJwu4L/n4/SiRtCmKvQpFY667JYQgOxdcpT7yKz6TRV7kVn5F3qjBPxsDs2D+G15vGjz9InrEXPk2wAiGWxE4Yvm7PegYlh40aa3+V1XKAmK7qaupwu8eYq+29rPlpWB/I1a6TnHdZ7V7/FjdbUNDQWZCV4nYw77jymf6EAQBmHtZlFnBK6flpuzUvTr5+4+SjRl369Qd1s3DkjuQlT4F23mW2eZ/avpnhI/n/hnF1se/IR1C/ROqP3CNPbApbT1STnQNAVSDaabLtJfCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n5cYlkskg7LgjmRPwvSAJIxoQEGBSv7aDrZMfLI8rPk=;
 b=Wy0hX5PvK+o8rV6qV4xkI8JahYdaZTaIi/7iFTol1kEE2Noaur9qMuzemvV4qS8su7EnSdwU+yr4s+CcvAw1qbxjgL6RQyooEUmkm+UBR1L9hHGNGt5F1/6Mbj1gLYtRvtfqKkt6n/Dgv4KUPYLVZT2jFFW9APaEktXvrnXZIbbuCB0ZIp7YVfjoXku2i176oK0g0FARoJXqcC1VCU7hlE3so6KY4vwyCfZamcDTgR3kUnigeaIRIQhupjvS2wheF8FRlH1eWwWiqJcDogEDEn/TQd2HSVWk8jyatVgpfXDokH73QdmXHIIU3lG4Fr00Nh//30P/IvElFzjfBpRAmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n5cYlkskg7LgjmRPwvSAJIxoQEGBSv7aDrZMfLI8rPk=;
 b=S/76zZO7jfThc+aNAwnq49QwdlKzrXoSjT1CJvGfpqfJYIId2eSQ/LKSxMWBsO5RR8fZ8J2c52HJL0v7x7Hqhv/S9GZxVrWsQb2Qp5SKEnwl+AgiyVul0pZzq2DNQ1a67uXAFDOgHE9fPPsr7BqPvqU1wNYSpvqWZjLhuVqL1fE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6351.namprd12.prod.outlook.com (2603:10b6:8:a2::6) by
 IA1PR12MB6649.namprd12.prod.outlook.com (2603:10b6:208:3a2::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5769.15; Wed, 2 Nov 2022 03:16:40 +0000
Received: from DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::dda9:dc0a:4491:ac2]) by DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::dda9:dc0a:4491:ac2%6]) with mapi id 15.20.5769.021; Wed, 2 Nov 2022
 03:16:40 +0000
Message-ID: <17af9fcd-8b3c-8e86-9640-69b39bd2b707@amd.com>
Date: Wed, 2 Nov 2022 11:16:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v4] drm/amdkfd: Fix the warning of
 array-index-out-of-bounds
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>, Ma Jun <Jun.Ma2@amd.com>,
 amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com
References: <20221101085211.305946-1-Jun.Ma2@amd.com>
 <99d64803-565a-e85a-c4a2-5b6ce0f197ed@amd.com>
From: "Ma, Jun" <majun@amd.com>
In-Reply-To: <99d64803-565a-e85a-c4a2-5b6ce0f197ed@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SGAP274CA0012.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::24)
 To DM4PR12MB6351.namprd12.prod.outlook.com
 (2603:10b6:8:a2::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6351:EE_|IA1PR12MB6649:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b7ec81f-63ed-429e-7794-08dabc80a8db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LxhGs5CyaBnKDS1ZV1DekrskDcKyX1fSVR4QNGKEgyEo5il9IPfC+hfytuKWVYaN6s/J7edt8fUXeUyJMvX226Ebyb3S9zHnPm4luUv5qx7TnWmGaAOsElrKVOIYIB0TQc1tak+PWC/7xrTLPFTtDM89Df1jtHdFcEvDsvaJUj+jMS8EVT8NTn97x6OoPnZ2aswrWmDCEGSrf7gm6QltWzFTU9BEmfkhmqfMkvG5yn4e3wjnJ8GUN7FuSmRiQN98xltoB04WgAfhG4rH9Pm9EsAm07ZxIydKnAO/ivzzldkkUPGF1qY4B2V/5fsGE9/oqPTL9B2HEBh1xtoUjqs2XMhjxOoONnfJZ2HeR7f+YmzoDrn4hj9HvrHLRgmzZjk0BCFZ2xOJlI5/tsUwUA3JFHHH4U6VBGUDtYrPXygRidTX1V3pmbJCECTqByd7KJ+npzLqTGDX8SNcBw/Ss9fv8zOWEeIu5EhKvy0zsXAcBhxdnbBVsBs3jxh/hylVLnUYuNDmnjfqRdZNUS7bLetI3p8jOgDb7/UZ3XAD0clrqrgF8DpeeYk7p9LsUjtG8MMegSNayAfCjEhGaRqT4uOErn5bm1Q8R5i1mvfbg6YEP01G4QWk7Tpc1zmGV5Cyxid8WYcQzKZ3DtyY4pc20pWwail0ZG7rSrlZSlh1gy58aR6N5DMKb6C90KoU87CaRxV/BCXO2k4rsrlDsAUAWV0ObVuhKN6aG6qZ6F8KR8FxTqFzUVV9++1lQzHL2e2uZzYZ3yV/M4M0kZTKgEQsNH7ItnZuE3qLcReR7KsR+6Jp79Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6351.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(376002)(39860400002)(366004)(396003)(346002)(451199015)(31686004)(66556008)(2906002)(5660300002)(8936002)(41300700001)(36756003)(8676002)(4326008)(6636002)(316002)(110136005)(6506007)(478600001)(31696002)(6666004)(6486002)(6512007)(53546011)(83380400001)(186003)(2616005)(66946007)(38100700002)(26005)(66476007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cjBqTzRPZ25TWlZsdWVPQVdQTFVWYlkrSmZpTjF5L2ZRMVNQMTdtMGZkaHpu?=
 =?utf-8?B?Mm5XRCtxT0xrNGlKRXZBSzdLK2UxQ0t0RjM4aEFUNmdVQmRmZGZhbzRFQ0c0?=
 =?utf-8?B?dkZwMUlGdGc0cC9SV0xqRHAyOUg3NXVVNDYydVd3REVJSFNVVmJURlJOUEtE?=
 =?utf-8?B?NHhTbEZleERYMFREdUdCVGd6SWk3dzh2RzJxblNuWEJhS0YxN2tMZVJ0ZnBs?=
 =?utf-8?B?dGdSQ3pUSEF5YTlQRFJTRTl6czhraHBoMEdzd2xFanF6R2NVVHNHWitNa1Ni?=
 =?utf-8?B?ekQ4dGs3dmNsaGxhc1lWZ2dkc05KaHBWaFlrMkE5RFlFQytTVFc0d1paZEdx?=
 =?utf-8?B?SElEbGtZMzFWcnJocEdiNEYxUGorbGxXallEY2ZOSzNVS05tT3pTUzltZnlG?=
 =?utf-8?B?dUFhM1NKZEVGRk9ncm1WVmVnRG5nRGg2WnJaTkE4S0lXK0Q5ZGNVdUw2NU9o?=
 =?utf-8?B?TnU5RUViUGF3cENiZGJIUm1QWDJBbG1kZzdDTjR2SFZ2MnNlNXYrSjhXQkha?=
 =?utf-8?B?Ylg2TVVXM0dEbHhVakFGR1pEZ01EVWpMYTBrU3RrKzZMQW1qRmJhR3h3U1RW?=
 =?utf-8?B?cWVqVWUzYzh4TjgwWS9kUVlCNnc4bTlPODRLNVE2VmxkMGU0cTM3dDBjRDRT?=
 =?utf-8?B?TU5NcmhDaXRKWDZ3ZGxLbEpyejFLRzhMTGdUd1laRENESDJpdmRtVThZT3Fu?=
 =?utf-8?B?OTZvY0FzZmxkWUh3anFjZzYvTWtaK3FjQmIvT3M0VUtXZVRMQXg3dll0Q0xO?=
 =?utf-8?B?UktJV0lmYVFCVHpBVy9sK3hYWnJodlJ0R0ZaMVFFYyt5R0tsbFkzaVdFSWty?=
 =?utf-8?B?dDhHUG5pQm8vYzk0SjA3dklBTThFTjNzYWY0TmZmSlFCMjB2cElETk8rQUZY?=
 =?utf-8?B?UlVNQlR3K05YcmhvTVVhYmZjNU9jVTZjZ1dqOVczYWNiaTdENWFwUTNSSkxa?=
 =?utf-8?B?Q2I3THdKaFR5RFJQY1ZQaUltQmhPQndtQngvSWZrbngvTkpOR0ZjMDFxU09R?=
 =?utf-8?B?dTJCdFJTWUl6SXJQNFRrNmRCWG9neHltRjJabXRMSGZSajRwUGFOTjRFbTdW?=
 =?utf-8?B?c3dhMVo0NW54dDJJRUUrSmZlcnhKSFVWMXRMc2E5M2s0SExFK0E0ZmlkWDZW?=
 =?utf-8?B?RlpHNjdjNHNtMy9yTTV3eTkyTk10ZURFYUlYS0J5R2xCaXZBaEpLeXZJaFl1?=
 =?utf-8?B?cGkvaC8rZTB5QjNzeThZSHd5SEFEMll6Q0hpTTNmS0pRRlZWM1BIa3NBZHQ2?=
 =?utf-8?B?dnBscnBScFI1bkUzWkdwbzJRVzNiZXg0TmFONk1DR1hUVmFjYjJzSmwremcv?=
 =?utf-8?B?LzRtWkhENkZCdll4U1p6R3RQVXgwbHg4US9CcWt0L0MrL1NTb09FWTk1Wk01?=
 =?utf-8?B?dGxUSG5IV1c5WjRma1JEQkpqZkRBMjZGdHdEZnJTL0dQcDA5MkF1V1ZjaUp6?=
 =?utf-8?B?V2M3SFFtcktkYlVSR1E4VjZYUWkvczM4WVBMQ1JuZkJ0Y2hIa3kxMGc3QTdu?=
 =?utf-8?B?aUp5ZGFNalpINDBYREFyWHZQUk9WTWtPZGk3Z2ZPY1AvL0RadytiUnlOWHB5?=
 =?utf-8?B?cjNsSFo4WCsxei9sSzVCbFUwVzF6TThJaXQ3QkhQME90b3Y0RUJuVm9mRElP?=
 =?utf-8?B?VUtONWljNkppSUVoa0Vsd1pNZG5SZDFZUEJPdW80KytUNFNMcXRhSFA5c3Mr?=
 =?utf-8?B?SGZTbmpaOWhKZlV4M2E4K3c4WTBNcVNCaE93UTJBS2RnVWwzSWRLaUVpNG42?=
 =?utf-8?B?V3F6ZzA2emhsdlNtNGtQRXBZK3V4b3RFRWllZFVlNVRnVFB2WEJNZlhBS2FG?=
 =?utf-8?B?SE5RN2JtcUc2WEdtemE1NzFNRHVTc2ZyTVVVRjFoN0lETkdHd2d3TEo5ZldW?=
 =?utf-8?B?eHYvamZ5dUwwK1lVeU9xNkxKOEVCelJUNlJicEVtMGdNdFZ3QTFLaFRQRnYv?=
 =?utf-8?B?Nzc1SEpaY2FPaE9nOUgyQlh1c0VJUGVQYy9xNmxOMTRTVENidWRGWTlFSzY5?=
 =?utf-8?B?YmNKL2l0b0VqT1JxaFlRL1NGMTh1aGJMVG1TYXJmQk9lVlJwdmRmWkd4a3Mr?=
 =?utf-8?B?UlhLT3h6S3c1TmtFUEZlS0VoUnBUVUpoSitZeXVwY3BxUUNVVFhrZlJlZkFD?=
 =?utf-8?Q?X8ddUNgM77GV5SDNgqhbz5mKk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b7ec81f-63ed-429e-7794-08dabc80a8db
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6351.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2022 03:16:40.4104 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t7yqaTINubw3MpDVa17T/lOACtj343e6YEGFAGPHpeeDeQgmtDuy4qMsVF3Z/IhY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6649
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
Cc: guchun.chen@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Felix,

On 11/2/2022 3:38 AM, Felix Kuehling wrote:
> 
> On 2022-11-01 04:52, Ma Jun wrote:
>> For some GPUs with more CUs, the original sibling_map[32]
>>
>> in struct crat_subtype_cache is not enough
>>
>> to save the cache information when create the VCRAT table,
>>
>> so skip filling the struct crat_subtype_cache info instead
>>
>> fill struct kfd_cache_properties directly to fix this problem.
>>
>> v4:
>> - Fix the bug when get cache info
>> v3:
>> - Drop processor id calc function
>> v2:
>> - Remove unnecessary sys interface "cache_ext"
>>
>> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
> 
> One more small comment inline. With that fixed, the patch is
> 
> Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
> 

Thanks for review. I will fix it when push.

Regards,
Ma Jun
 

>> ---
>>   drivers/gpu/drm/amd/amdkfd/kfd_crat.c     | 312 +++-------------------
>>   drivers/gpu/drm/amd/amdkfd/kfd_crat.h     |  12 +
>>   drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 245 ++++++++++++++++-
>>   drivers/gpu/drm/amd/amdkfd/kfd_topology.h |   5 +-
>>   4 files changed, 282 insertions(+), 292 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
>> index 3c7f0d49da59..f4a9d0e49072 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
> [snip]
>>   
>> -/* kfd_fill_gpu_cache_info - Fill GPU cache info using kfd_gpu_cache_info
>> - * tables
>> - *
>> - *	@kdev - [IN] GPU device
>> - *	@gpu_processor_id - [IN] GPU processor ID to which these caches
>> - *			    associate
>> - *	@available_size - [IN] Amount of memory available in pcache
>> - *	@cu_info - [IN] Compute Unit info obtained from KGD
>> - *	@pcache - [OUT] memory into which cache data is to be filled in.
>> - *	@size_filled - [OUT] amount of data used up in pcache.
>> - *	@num_of_entries - [OUT] number of caches added
>> - */
>> -static int kfd_fill_gpu_cache_info(struct kfd_dev *kdev,
>> -			int gpu_processor_id,
>> -			int available_size,
>> -			struct kfd_cu_info *cu_info,
>> -			struct crat_subtype_cache *pcache,
>> -			int *size_filled,
>> -			int *num_of_entries)
>> +int get_gpu_cache_info(struct kfd_dev *kdev, struct kfd_gpu_cache_info **pcache_info)
> 
> This function name should have a kfd_ prefix.
> 
> Regards,
>    Felix
> 
> 
