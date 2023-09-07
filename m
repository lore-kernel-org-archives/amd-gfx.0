Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80850EC875A
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Sep 2023 20:15:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E51B710E258;
	Thu,  7 Sep 2023 20:15:17 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2056.outbound.protection.outlook.com [40.107.244.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF9DD10E249
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Sep 2023 20:15:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CLUfz5BHDTaKeBARUi7JfU4d+BOz4xsr+le3N0tbD+GrbulYbhxEvudd1giViEXSKbr/qlNd4Uqe1T8L+hJDB/gORlOteOnqH1ia1v0dIwLYObNmNfKSVcU+RbBToPA8SapQZ3ZA8jis4agTB2wRWWBktOIO/clcIbZ2NDa7MGZp35GlE2VaE5Sl950OY+3PsbRYLFPKIuqhcBxvcoBY86qSAugYCn91/AntRp9s4XTdpXlZyTGLPjksZuOhlOCpEOfFIS/vyi3AT+TmtGi6NK9Xl1yEMuSY+aC6uYkaAtGcKLZ9t1iRi4LE0hhtFlP3qjV65bj1p/7ROsEz5rTXTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TW6Fq+wYo1Q2HzU4x1S81lGKRvp5unME49e0CWxRQ14=;
 b=W3WdMZP153oq7iGRvZrDstNaDSnEp8XALB5SPhSd3j52hJuZ4ROdeAIK1RnuQYJ8OlvFx80xIUc14NO0iVdqrbDu3QD3fcHJ15BRSSrrvnegsp9/WZew1AKHyuFE2EGm5U/+4rVKZsylW5a3tAJd+lZPVh/wAxrZ8y5SGPl8fxhhaDJx13rYjVKJes4XCzn/Tsbe69bElvtsUeS4Hrql1Y5L0oqE5uTsuN4uEFi7XjyrdehTtVfmdI0CaUxTIvZMOj+lJ+L8HATlbNb3WchzsI9ORnevBhSNHigvGCCquEJ+6pNtFpsGj06SHuoxvXmUiZj53ZeD90VjBTpLhgInCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TW6Fq+wYo1Q2HzU4x1S81lGKRvp5unME49e0CWxRQ14=;
 b=hDDhwAGDV2hJ3yr6FSPFKnQ9NWf+pIhlgYVCoKKIw3iSpY6kLmpMPubZcVHhbDBZJWP6Z1O+DLoOWstVu3G+3n/vs81bJK5e8F4uRvb9sE1/JwXfInTtD8mdUO4jlMctsaXrcauEpYpUD4ZVZq5yWYCu+uxcyO5h8czMcSzqSBo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CY5PR12MB6324.namprd12.prod.outlook.com (2603:10b6:930:f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Thu, 7 Sep
 2023 20:15:14 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::ca28:efb4:a838:58fb]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::ca28:efb4:a838:58fb%4]) with mapi id 15.20.6745.035; Thu, 7 Sep 2023
 20:15:14 +0000
Message-ID: <e03375d6-4e51-236b-73dc-9d7ce5dbbe06@amd.com>
Date: Thu, 7 Sep 2023 16:15:11 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v3] drm/amdgpu: Add EXT_COHERENT memory allocation flags
Content-Language: en-US
To: "Yat Sin, David" <David.YatSin@amd.com>,
 "Francis, David" <David.Francis@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20230728193955.2607848-1-David.Francis@amd.com>
 <c689de95-ee76-ef2d-508d-76fff7e76d1e@amd.com>
 <DM6PR12MB5021544E5B879E1021446C3F95EFA@DM6PR12MB5021.namprd12.prod.outlook.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <DM6PR12MB5021544E5B879E1021446C3F95EFA@DM6PR12MB5021.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0151.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:8c::12) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|CY5PR12MB6324:EE_
X-MS-Office365-Filtering-Correlation-Id: c42a3b54-b3d7-497a-1177-08dbafdf250f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A2V6MVGJ/tlMRMDZi/iwQbJ1cPUPFYSAt84yNpBZwp4dQFjnEuswX+q0oX0wopmzh5p2kDtyp0HzrMhXNsMTQgMi/1VKXk8kpf/jwne/hAJ+W3plnXMelMGYcbGSdOj7W6Jg4d5szqrpfHnBUDxrm9kpHiocHUrz+ce+0yYm3rrejXQSAC7djtQmr6N72I7nqlWRHYzV06hneS9J1O0oXJT+O71UdBVN0xdJcNlj8Cb2c/msNaUvYGJXyMByhwc74ygfPZ6GfU8i1XNGKn9O6ESXgxFmFRzU2QX/PMgo8GBE50JkvudEEzMZyTf/enCNc+l+ruTyne4x7g6DD6cAEEhr3bETDUan1d+YfsHaMog7DK7NKyEjI57jP16rmqprOi7dNQJ0CC2/W9PvhclgpQ4po3QyjzAAXLt2M9oeePsu04tYILM5+oprNPS9gQMOuDJs6iD5cfDePAzsOoy4FQHqyk/0ARPf049pPBBAZJ6pdnmBYvwts+Txo8xutytCN1l3FHmU8vL40nTQh9K37jCNCHF+Hcm5vx8KPbPVYBTzPrslhIO/8uqAeVmBiRdLk9i2O4Sh3qBKpb3Km2P74t4lFCgx3xnWNw0VxbI6k1YfDC5krBEmUVE2rdcVlCQBHOZXIozarTp7JGjtG92/DQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(136003)(376002)(396003)(346002)(366004)(186009)(1800799009)(451199024)(6486002)(6506007)(36916002)(6666004)(53546011)(6512007)(966005)(478600001)(83380400001)(2616005)(26005)(2906002)(41300700001)(44832011)(66476007)(66556008)(66946007)(316002)(110136005)(5660300002)(8676002)(8936002)(36756003)(31696002)(86362001)(38100700002)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cHFsWGxnVWZDakZJMHNBVUNPeGI3eDFCay9LMDlIbFBrMnFtWU1hZ2RhWllN?=
 =?utf-8?B?bXNoNTFLakw0YWlSdVdYYzd2YUN0V0RkZW45YXlaSElrVmwrTUJKbUZFLzI3?=
 =?utf-8?B?WDlzWVhJajc5aFpONy9vUUQyeFdjTWg5cnNEUllLZDJkRGdYRk5GRWJPZktF?=
 =?utf-8?B?dTBhWmIzQmNpWFEvMXVta1NIM2FuUnB5Rmdqc3hUYkJWWDZsVEEwZFpxaElx?=
 =?utf-8?B?cHcyZG5zNXFuM1FyMFJkZGxFbk5TZEQwdFJjOTY1VzZ1ZUh4MFBrR2pnKy9F?=
 =?utf-8?B?ZXJ1U3dOY3FtMHNHR0U5cENVZVNra1h4M2hzbTVKMWJKQUxtbEFheHl0d3Ri?=
 =?utf-8?B?NWhkeCt4QzRRY2Z5SE1SQzVTMXhad1FtbTM0aUpTYk95QVl1VndtMjhSTUpD?=
 =?utf-8?B?UjV6NHRpUlVsdndVVDk0ZVVFcER6N09kN2FxTFF1cExMRTVpZ3hMYW9IbjlP?=
 =?utf-8?B?Uk01eVQvNUJ1bnFsYzJPWnpveVBYdnEyQUFpTjJlWlRXb255N01YeGc3UW1G?=
 =?utf-8?B?VE1CZmdmRTFQZHVUQkpYUEMzVWo4ME5DVkJURzBhdEdkSjh4NVNITzdDMW02?=
 =?utf-8?B?cStSR09oUVE4OWd6MndJMW1uVEFoOUdlKzBRb3VhWUVHaUp1cFpSWWp0Snd1?=
 =?utf-8?B?NWhhT0dvNzJ1bVJWZS9YL2gwdU1oZjY4ZXAyQlFoQXc4elN4OEJTdEZNNkpl?=
 =?utf-8?B?ei9GeC91OWVlalJPYW9XdmEyZUh2aTZQT1FlRHZGRUF1Uk94ZC9LSXBDdjlj?=
 =?utf-8?B?ZmVSTytuczZ5NUp2bnpML3BnK1ZjYVFqYlRaK2JlVEZsQk0zdnVZcDZVSisx?=
 =?utf-8?B?c1BWOEkrNWsxYXhqVjQ0WHJhQzMyT3VYYXd6Q2VzeWF6aEdoZXpVekNsUDdn?=
 =?utf-8?B?QkhvSXZUQWJUaEFNMnhUOW9uOE1JOHlVYkxZaHpqTVNxQzB6YTNuVzgwVnNs?=
 =?utf-8?B?VlZ0RFJoMTREZWxhZXY4bFZ3MWVnVjlqMGoxcEhMbG9DN1lFQWRoaElHZDZx?=
 =?utf-8?B?bHFVYzFFYllEK0RHcnltVVJObjY0WEx3bzhPcld6RjNWZjE3QzVpL1ZSZFBO?=
 =?utf-8?B?Zy9jY2dQUGkzTGtCbkJGaFc1bnU4NElrTlN4VlRwRlIxSk11akhvM0dyOWFw?=
 =?utf-8?B?TGsvTGtiNTIzVEJCdWpTOW9IdE5paG5XSzRicVRwRmJ2Wmk2NnNaU09VZ0JO?=
 =?utf-8?B?TmdzK3hPdCs3K0V5SWV4NjhrZnhCUUNUMjB0UzNVVmUyeUZ0YmFPL3RFNzJj?=
 =?utf-8?B?VFlxdU9EQzFOZWZvWk41MG9mNnFSWXdDWERqZnZVMEl2Y0JNUUtGWHdPQlRE?=
 =?utf-8?B?N0lMWTZxZDBWQkUycEhndHhWQkNvRXh4S1o3cW9pVTZtc2V3YmJyc1MvVitK?=
 =?utf-8?B?WTZXNXR3QkpzUDhPMlRtemlRUytRSDdMV25XenkxNFVodHhZMENLZEpxK2N1?=
 =?utf-8?B?eFhORnNSZjEvT3RhN3dKMFdXY25NZUdrZ0VwSjN3NEVyOFV5bjNGcHJPV2Z5?=
 =?utf-8?B?dENOWHdtS0dQbU1tcitGc2hqQXZHRHVtclVpdHR0UitkYW1kWnU4K2ZNcnRJ?=
 =?utf-8?B?STlyS2dVRURUeUh5clVEVzN4dFJvYTJpTXJyQUtpYm5VK0VQdWtZem8vSEhI?=
 =?utf-8?B?S2dGblR4M2tHUjRRc3lNUWc5WldmcWpOMVlZZzhDeEtlU0g3L0xUMWFxMTFU?=
 =?utf-8?B?VWYvNFkxWFl3Y090alFlN08rUUx3SjZrZDRXQXEyTXV3QWduY0dNbzJlbEpm?=
 =?utf-8?B?QXV4cDU3dlFTWnZsZDBpTzIrczhjUVh6WHRHWUZBcGIzV0tFTDNtWHI1d1RV?=
 =?utf-8?B?clBTK1VON29JODJhaGhLVjVucnZkWTduYm96TWZRSVI1WmlBbTNlQmI0VnQ1?=
 =?utf-8?B?NDRIVmgwWFRJUGh3RTB4Y2czd1ZVRVNZeFZ5ZzlRVWVOOUhMK2FUb2lCWW0x?=
 =?utf-8?B?bXNUOUVEOW9EV05iQWJLcFRGQXhEWUxrWlpGL2gwaEVacG1rY1A3Undtd3BC?=
 =?utf-8?B?THNCYlBkSTcwMWVxMVlabEkrTWFzMCttQ2xmd2VVREF3OXdTT01yb2U1STRR?=
 =?utf-8?B?R0pBc0IzRGJDcm11RitlRTgraElIZGIwSThrYVpieEtQdTdvak1vcGlSaU0z?=
 =?utf-8?Q?C3A1GHimNC5xeWcznQgak6TqD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c42a3b54-b3d7-497a-1177-08dbafdf250f
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2023 20:15:13.8989 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FLbF5BiV4kTT+zES0Gd6snzqu7HRlBb0TykP0MRKK593ZxYOCCUbszpzc3P1Ew2XDGwCRi0IoNK+PlLWjp4qqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6324
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

I'd like to see checks for nonsensical flag combinations in the kernel 
mode driver as well. We can only make some of those combinations valid 
and meaningful in the future, if we implement well defined behaviour 
(i.e. return an error) now. Otherwise we risk breaking misbehaving user 
mode applications expecting a particular undefined behaviour later on.

Regards,
   Felix


On 2023-09-06 15:25, Yat Sin, David wrote:
> [AMD Official Use Only - General]
>
> Reviewed-by: David Yat Sin <David.YatSin@amd.com>
>
>> -----Original Message-----
>> From: Kuehling, Felix <Felix.Kuehling@amd.com>
>> Sent: Friday, July 28, 2023 4:00 PM
>> To: Francis, David <David.Francis@amd.com>; amd-gfx@lists.freedesktop.org;
>> Yat Sin, David <David.YatSin@amd.com>
>> Subject: Re: [PATCH v3] drm/amdgpu: Add EXT_COHERENT memory allocation
>> flags
>>
>> On 2023-07-28 15:39, David Francis wrote:
>>> These flags (for GEM and SVM allocations) allocate memory that allows
>>> for system-scope atomic semantics.
>>>
>>> On GFX943 these flags cause caches to be avoided on non-local memory.
>>>
>>> On all other ASICs they are identical in functionality to the
>>> equivalent COHERENT flags.
>>>
>>> Corresponding Thunk patch is at
>>> https://github.com/RadeonOpenCompute/ROCT-Thunk-Interface/pull/88
>>>
>>> v3: changed name of flag
>>>
>>> Signed-off-by: David Francis <David.Francis@amd.com>
>> I made one comment on the user mode patch regarding the explicit handling
>> of invalid combinations of Uncached, Coherent, ExtCoherent flags. I'm not
>> sure what we agreed on any more. But I don't think we want to just leave it up
>> to chance. Other than that, this patch looks good to me.
>>
>> Regards,
>>     Felix
>>
>>
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c |  2 ++
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c      |  1 +
>>>    drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c           |  1 +
>>>    drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c           |  1 +
>>>    drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c            |  5 ++++-
>>>    drivers/gpu/drm/amd/amdkfd/kfd_svm.c             | 10 +++++++++-
>>>    include/uapi/drm/amdgpu_drm.h                    | 10 +++++++++-
>>>    include/uapi/linux/kfd_ioctl.h                   |  3 +++
>>>    8 files changed, 30 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>> index d34c3ef8f3ed..a1ce261f2d06 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>> @@ -1738,6 +1738,8 @@ int
>> amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
>>>      if (flags & KFD_IOC_ALLOC_MEM_FLAGS_COHERENT)
>>>              alloc_flags |= AMDGPU_GEM_CREATE_COHERENT;
>>> +   if (flags & KFD_IOC_ALLOC_MEM_FLAGS_EXT_COHERENT)
>>> +           alloc_flags |= AMDGPU_GEM_CREATE_EXT_COHERENT;
>>>      if (flags & KFD_IOC_ALLOC_MEM_FLAGS_UNCACHED)
>>>              alloc_flags |= AMDGPU_GEM_CREATE_UNCACHED;
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
>>> index 12210598e5b8..76b618735dc0 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
>>> @@ -331,6 +331,7 @@ amdgpu_dma_buf_create_obj(struct drm_device
>> *dev,
>>> struct dma_buf *dma_buf)
>>>
>>>              flags |= other->flags &
>> (AMDGPU_GEM_CREATE_CPU_GTT_USWC |
>>>                                       AMDGPU_GEM_CREATE_COHERENT
>> |
>>> +
>> AMDGPU_GEM_CREATE_EXT_COHERENT |
>> AMDGPU_GEM_CREATE_UNCACHED);
>>>      }
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>>> b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>>> index 6b430e10d38e..301ffe30824f 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>>> @@ -632,6 +632,7 @@ static void gmc_v10_0_get_vm_pte(struct
>> amdgpu_device *adev,
>>>      }
>>>
>>>      if (bo && bo->flags & (AMDGPU_GEM_CREATE_COHERENT |
>>> +                          AMDGPU_GEM_CREATE_EXT_COHERENT |
>>>                             AMDGPU_GEM_CREATE_UNCACHED))
>>>              *flags = (*flags & ~AMDGPU_PTE_MTYPE_NV10_MASK) |
>>>                       AMDGPU_PTE_MTYPE_NV10(MTYPE_UC); diff --git
>>> a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
>>> b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
>>> index a6ee0220db56..846894e212e7 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
>>> @@ -540,6 +540,7 @@ static void gmc_v11_0_get_vm_pte(struct
>> amdgpu_device *adev,
>>>      }
>>>
>>>      if (bo && bo->flags & (AMDGPU_GEM_CREATE_COHERENT |
>>> +                          AMDGPU_GEM_CREATE_EXT_COHERENT |
>>>                             AMDGPU_GEM_CREATE_UNCACHED))
>>>              *flags = (*flags & ~AMDGPU_PTE_MTYPE_NV10_MASK) |
>>>                       AMDGPU_PTE_MTYPE_NV10(MTYPE_UC); diff --git
>>> a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>>> b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>>> index 880460cd3239..92a623e130d9 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>>> @@ -1183,7 +1183,8 @@ static void gmc_v9_0_get_coherence_flags(struct
>> amdgpu_device *adev,
>>>    {
>>>      struct amdgpu_device *bo_adev = amdgpu_ttm_adev(bo->tbo.bdev);
>>>      bool is_vram = bo->tbo.resource->mem_type == TTM_PL_VRAM;
>>> -   bool coherent = bo->flags & AMDGPU_GEM_CREATE_COHERENT;
>>> +   bool coherent = bo->flags & (AMDGPU_GEM_CREATE_COHERENT |
>> AMDGPU_GEM_CREATE_EXT_COHERENT);
>>> +   bool ext_coherent = bo->flags &
>> AMDGPU_GEM_CREATE_EXT_COHERENT;
>>>      bool uncached = bo->flags & AMDGPU_GEM_CREATE_UNCACHED;
>>>      struct amdgpu_vm *vm = mapping->bo_va->base.vm;
>>>      unsigned int mtype_local, mtype;
>>> @@ -1251,6 +1252,8 @@ static void gmc_v9_0_get_coherence_flags(struct
>> amdgpu_device *adev,
>>>              snoop = true;
>>>              if (uncached) {
>>>                      mtype = MTYPE_UC;
>>> +           } else if (ext_coherent) {
>>> +                   mtype = is_local ? MTYPE_CC : MTYPE_UC;
>>>              } else if (adev->flags & AMD_IS_APU) {
>>>                      mtype = is_local ? mtype_local : MTYPE_NC;
>>>              } else {
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>> b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>> index 1b50eae051a4..e9ffcfc5dedc 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
>>> @@ -1155,7 +1155,8 @@ svm_range_get_pte_flags(struct kfd_node
>> *node,
>>>      uint32_t mapping_flags = 0;
>>>      uint64_t pte_flags;
>>>      bool snoop = (domain != SVM_RANGE_VRAM_DOMAIN);
>>> -   bool coherent = flags & KFD_IOCTL_SVM_FLAG_COHERENT;
>>> +   bool coherent = flags & (KFD_IOCTL_SVM_FLAG_COHERENT |
>> KFD_IOCTL_SVM_FLAG_EXT_COHERENT);
>>> +   bool ext_coherent = flags & KFD_IOCTL_SVM_FLAG_EXT_COHERENT;
>>>      bool uncached = false; /*flags &
>> KFD_IOCTL_SVM_FLAG_UNCACHED;*/
>>>      unsigned int mtype_local;
>>>
>>> @@ -1203,6 +1204,13 @@ svm_range_get_pte_flags(struct kfd_node
>> *node,
>>>              snoop = true;
>>>              if (uncached) {
>>>                      mapping_flags |= AMDGPU_VM_MTYPE_UC;
>>> +           } else if (ext_coherent) {
>>> +                   /* local HBM region close to partition */
>>> +                   if (bo_node->adev == node->adev &&
>>> +                       (!bo_node->xcp || !node->xcp || bo_node->xcp-
>>> mem_id == node->xcp->mem_id))
>>> +                           mapping_flags |= AMDGPU_VM_MTYPE_CC;
>>> +                   else
>>> +                           mapping_flags |= AMDGPU_VM_MTYPE_UC;
>>>              } else if (domain == SVM_RANGE_VRAM_DOMAIN) {
>>>                      /* local HBM region close to partition */
>>>                      if (bo_node->adev == node->adev && diff --git
>>> a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_drm.h
>> index
>>> 79b14828d542..629860dbc9ec 100644
>>> --- a/include/uapi/drm/amdgpu_drm.h
>>> +++ b/include/uapi/drm/amdgpu_drm.h
>>> @@ -145,7 +145,7 @@ extern "C" {
>>>     */
>>>    #define AMDGPU_GEM_CREATE_DISCARDABLE             (1 << 12)
>>>    /* Flag that BO is shared coherently between multiple devices or CPU
>> threads.
>>> - * May depend on GPU instructions to flush caches explicitly
>>> + * May depend on GPU instructions to flush caches to system scope
>> explicitly.
>>>     *
>>>     * This influences the choice of MTYPE in the PTEs on GFXv9 and later GPUs
>> and
>>>     * may override the MTYPE selected in AMDGPU_VA_OP_MAP.
>>> @@ -158,6 +158,14 @@ extern "C" {
>>>     * may override the MTYPE selected in AMDGPU_VA_OP_MAP.
>>>     */
>>>    #define AMDGPU_GEM_CREATE_UNCACHED                (1 << 14)
>>> +/* Flag that BO should be coherent across devices when using
>>> +device-level
>>> + * atomics. May depend on GPU instructions to flush caches to device
>>> +scope
>>> + * explicitly, promoting them to system scope automatically.
>>> + *
>>> + * This influences the choice of MTYPE in the PTEs on GFXv9 and later
>>> +GPUs and
>>> + * may override the MTYPE selected in AMDGPU_VA_OP_MAP.
>>> + */
>>> +#define AMDGPU_GEM_CREATE_EXT_COHERENT             (1 << 15)
>>>
>>>    struct drm_amdgpu_gem_create_in  {
>>>      /** the requested memory size */
>>> diff --git a/include/uapi/linux/kfd_ioctl.h
>>> b/include/uapi/linux/kfd_ioctl.h index eeb2fdcbdcb7..f0ed68974c54
>>> 100644
>>> --- a/include/uapi/linux/kfd_ioctl.h
>>> +++ b/include/uapi/linux/kfd_ioctl.h
>>> @@ -405,6 +405,7 @@ struct kfd_ioctl_acquire_vm_args {
>>>    #define KFD_IOC_ALLOC_MEM_FLAGS_AQL_QUEUE_MEM     (1 << 27)
>>>    #define KFD_IOC_ALLOC_MEM_FLAGS_COHERENT  (1 << 26)
>>>    #define KFD_IOC_ALLOC_MEM_FLAGS_UNCACHED  (1 << 25)
>>> +#define KFD_IOC_ALLOC_MEM_FLAGS_EXT_COHERENT       (1 << 24)
>>>
>>>    /* Allocate memory for later SVM (shared virtual memory) mapping.
>>>     *
>>> @@ -659,6 +660,8 @@ enum kfd_mmio_remap {
>>>    #define KFD_IOCTL_SVM_FLAG_GPU_READ_MOSTLY     0x00000020
>>>    /* Keep GPU memory mapping always valid as if XNACK is disable */
>>>    #define KFD_IOCTL_SVM_FLAG_GPU_ALWAYS_MAPPED   0x00000040
>>> +/* Fine grained coherency between all devices using device-scope atomics
>> */
>>> +#define KFD_IOCTL_SVM_FLAG_EXT_COHERENT        0x00000080
>>>
>>>    /**
>>>     * kfd_ioctl_svm_op - SVM ioctl operations
