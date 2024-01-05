Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83C8AC3DA6E
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Jan 2024 13:32:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C1D510E5F2;
	Fri,  5 Jan 2024 13:32:18 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2062f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::62f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6263410E012
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Jan 2024 13:32:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iyc7cQjIJ287dVShyBxaKfq6s7G2/HHJU4isXxhEbRX8nrU5GugzaeSNqcnEe3KuUOS1GyCofbdaxzxjDqFwas5/lVcjy84PAPC9Gk/aYTCFL0BYs+q7+X6mIQgZaUT6lmGvgnOqdINT22TV0yVqkkpFKKcT2g3bwzaRWO9RWxh2HRsCQVcfyPdxo03pjZaSQS8bP9qF5nC/6IN1T9fgkoEyCZsUAnV13loKwj7E/+0ypiZSLZZ81UAxCc1959DZgmez/45gNGez6E0G2Z+uzfVMxeJiyd7/geQ9OcWZW3/TqbtWlcQsRkgr+ecZM4ZUKnuxxU1KtmIaCMG09kCIVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nIG2nZlTc6/9+xqpu5EAErDXl9zyTziXHRXuTNlGfQM=;
 b=HpzM69ikpwRrJRhhpKi7YTLQheMQiFV3nHuH8B79aDrz/xVul5pPoZVLXFZagVIycp8GH9d0rE2f7vTpqOeXjVD3CYQbvtUUsniAdtRIPP4qXXtUcpvrVgvbOjzxA/YP6Jo974bYAHCh4TUzbsvdFJma6/aWJ0IQQcFCCRucZ4n7NXQQiBI/D4Y1JTj5llKBej+S1yvgvo8sSSdoTQZe+LdARkVcLjqrBtt/7PMxJOo5ch2lnVm+EBNhfxY7YSV2R1wvleI6bp9KMO7vdRjNq64g/5ZWNERJiapdBunfFq7cooR6iQJdb+yCmhp97h0MIXa+WevSHQGTsD2qGlVaog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nIG2nZlTc6/9+xqpu5EAErDXl9zyTziXHRXuTNlGfQM=;
 b=MGQ28w82v1+PTfP2qrs8CxKqmWQ2EZnQMU+nvO1OUGarvTxvgX0ByKnOUKZ58MEGTUdxEuPPl/K5ylZrsIPrmcEgkIVkM0XVLGLgBDgvO7Ho+mdSQd9iM8SEuWw+X2uF+2SN6n4YEpz3B1PkkP0wrv8HkYzWjxRZ1cvSb8K5kEA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM4PR12MB5376.namprd12.prod.outlook.com (2603:10b6:5:39f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.16; Fri, 5 Jan
 2024 13:32:12 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::e1fb:4123:48b1:653]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::e1fb:4123:48b1:653%4]) with mapi id 15.20.7159.013; Fri, 5 Jan 2024
 13:32:12 +0000
Content-Type: multipart/alternative;
 boundary="------------ETniF00x9f0Ecatz80cXDe0Z"
Message-ID: <d80fddf5-5437-4d24-8baf-728dd4d5c0b4@amd.com>
Date: Fri, 5 Jan 2024 14:32:07 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Fix sparse __rcu annotation warnings
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
References: <20231205222026.2108094-1-Felix.Kuehling@amd.com>
 <e879ea47-4281-4830-a4db-5a144999198a@amd.com>
 <a6411c81-d0ea-4002-bfc6-a725a83eb9bf@gmail.com>
 <7b67d4f1-cfcd-47a9-a80e-f4c1eee235a1@amd.com>
 <ef8c4273-d54d-42b6-ac60-fed5f8ed3848@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <ef8c4273-d54d-42b6-ac60-fed5f8ed3848@amd.com>
X-ClientProxiedBy: FR3P281CA0144.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::15) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM4PR12MB5376:EE_
X-MS-Office365-Filtering-Correlation-Id: ff2c41d9-0d86-4ed7-ddfd-08dc0df2b96a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: czbhCZZ/x6/R/eqaU5VloPY362DdidxDvbcvAbjtpkzV42NrJ2laoed92fPSlBlVuHM7LC9oHfr/aZxJsxCn08nUW0wYo3hGbr2/HSHNAJ75m6Dw9FnYspOIKhKbeep78cP1abSONcAM6zBo9zjivlM+nO4Z6LXIWwB4cqLg2GvHAQkprngn78H9NZtvA5cz92tBK3NGYc8zMyqAhECjax7Bc1dWi22GRrxVUNbQhF6HdJMi4KWUELNKhDTNModS7Q9SSDSxSB0IfOFiErlh4gm1hWVWy9Fvj266WlO6g03eEp5MfRJenx+XF58w9YBTssK9HiCElM0ieiSokQ/j9MrVVKZ5fVP+KmaqmuTaCyuomFvAhGSyBGQLISCqcM/xQWVOxd3qIaf+Uyvg6GgyvYjBEPr1Qhl/2Djj21RVRLd21CJp2zZ7+7+bCDTQX9vwwuWUD8Ps1uIMdSH1tdQGQEOszfTkfdtt+ooaL01F+zGA93PDqJIIKf+kxn/GyuLcV3uLHjWFyOEro1H637UD6I0PO1UxTAyWe7rWItXmcu6HWHbWHeJ90EJt4uPoHahGO10h6LvX+89jnI4EMB0E6RZ+jXnQpBMBCCQSJYhyqsKtq8jpNoZ1f0rrAUH09JDC
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(376002)(346002)(396003)(39860400002)(366004)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(26005)(53546011)(33964004)(2616005)(6506007)(966005)(6486002)(478600001)(6666004)(6512007)(83380400001)(66574015)(4001150100001)(30864003)(2906002)(5660300002)(41300700001)(66476007)(66946007)(66556008)(316002)(110136005)(8676002)(8936002)(4326008)(38100700002)(36756003)(31696002)(86362001)(166002)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MmthaUxrMmh0R25xYVNoQzVwVTBGZmFrZ2JPQmNKLzRUVktsWWN0OS9VZkU4?=
 =?utf-8?B?VUlTRWFhWWhpU3cxKzN6OFd5NkNYSUxqMzBvaWdSSmNsNjNlNlRaeTRRNHQ3?=
 =?utf-8?B?R1dsbklJNkkrOWREUTdPVDRTM0lEdENjUlZkQkJrd2VXWUdWdWlYYWZFRG9x?=
 =?utf-8?B?aEg0eUtvVm5UTXRLVkFkN3Q3ZGZUKzAwdHlOenpZL3RsZGhTRjl0amJ2L0tp?=
 =?utf-8?B?aVpWSTA0NFR2UEdjemJrL053M3NLTm9VdEZkcDVSNGNGL2JQSFdqMW91ZzRR?=
 =?utf-8?B?Y2FMUzEwSUpTeWd6MGhZWHV5Mk9LZDJPdFhNL2NKRE56cTFXS0IvKzNZOUVC?=
 =?utf-8?B?RzUySjc5dy82MlhVMkppL1EvbHZ4azE0TzQ2aUJubG8xTkdOWXd0OWhyZkN0?=
 =?utf-8?B?U0FHZS9XNzEzQzdxdk4wNHR1Z2FIalRWelY5VWZhZUlrWUdwMFNoYjkzam0r?=
 =?utf-8?B?Z1RQK09Da1dpYUNtcnp6ZGpFN2FxUzcrdGZTSFYrVWZXOFlRZlhXN0FSQkN0?=
 =?utf-8?B?aG41YnFnNGtzR0xPMjA4aHRBaVZGbVc0Vlh5R1NNKzFBeEpsV0k0V3c4ZGxJ?=
 =?utf-8?B?RVV5YktuSWdZNVJRcU82QTNqSkdWbTNVNTc0UWFQcllQYWpIWVNWZXpvTG5X?=
 =?utf-8?B?dEdmY3daOUlQYjY2TDNUZ0xyZzhTUW1zWnFtN3pCWmN3am9mdHp2Q25ickJM?=
 =?utf-8?B?bWFQdFpFZ09rTWRsWkNEaXlFNVgwVmFqcHQ0K1lPTWx2MUZ5ZGt4TGZ2Qmt6?=
 =?utf-8?B?aG9tbjNNbmZDR2dxN2FEbk5rK2dVU2I1S25QdFRLbTJaOUtsSkdBUWJVWEdT?=
 =?utf-8?B?TnFyNWltdDJ4ak42cFhJR2NhcUZzZU91eDFXTHVnMllZcy9SSUtqYVdoZVhx?=
 =?utf-8?B?RlQ2Q3pjZzU2bW1PNnVWanV0ODZXdEZaTlUrZGg5VlZiTW41ZXBXdWJmN1dZ?=
 =?utf-8?B?MDRoeWl1UURkc1RnQUtwOEtoeitVa0FGMWZiTXpQRjgzS0pFWXg2d0ZPV2RH?=
 =?utf-8?B?NzNCcUJCNEo4UE1xd3NZZERhbWJEVU95L0t3d1B1cWxIamRoM1ZObnpFVTVo?=
 =?utf-8?B?ODg4OEVIdXhrUEpIVFJ4QWRRM1VEQUxWM1E0eDc0Y1l2cUVFWUVxeGNBZnpt?=
 =?utf-8?B?NUZ3T3JIeThsNmZTNEtidGdWZDAwVFhpcUc0dWRnVTdpNnVESk5sT09ETHFK?=
 =?utf-8?B?OS9icjhEdkJFM0tVdFlLTTdFQzVQMDZxSFM1b1grYjUrZXJDSzlDK2daeldQ?=
 =?utf-8?B?elJ0VlByWUNTakVTL2Vjd1VvMG5xem90amx3Q0JpbHI3ZERNRHNZZWl6RSsv?=
 =?utf-8?B?TG90bytnN2ZQQUVHcytKekxWQ2d3bExPUUFiTmNVL0NJbkkyR1ptVnY4TVpv?=
 =?utf-8?B?Q0JEK2J6TmNzOVFmRlZpbnhEVCtaTmJRWFpPUWZyYlVvMXI0V2ZNRjc3V0Y4?=
 =?utf-8?B?bFBzRXZtTGpac01PcHJXOGtsSS9laEN1QUVZNjdmT3h2QWFzbGthTXBROGVi?=
 =?utf-8?B?QXlxaTBGTlF0ZzRaYlVKSXpNR21rRHo3OXozZk42TDdqWXFYY3FFQlFmaSs3?=
 =?utf-8?B?T1dpWFhIQy94ZEJYTkZDd3hlT25yaTJiNXN5ejhDSDJ0LzBjckJXNDFFODBj?=
 =?utf-8?B?ekkyTmZkYmlkRkpNQ2JtTXhkU0VkUjlqTjRWczkwTkZaazVoQWUxaVI0RDRl?=
 =?utf-8?B?K2VZdjRHVjRKWE8xZW1oMmEvRllxL29VdldWV1hLc1g0clpkNExaaXd5Sllj?=
 =?utf-8?B?aUlkV1FzVlJHNUxxT0NKMzJnM3VFTmdVcS9qdXNtNjZqUzdzY2FkV2tIbzlr?=
 =?utf-8?B?VXppeFZvVGhPVi9TTmQwQjkvYTJLTU1zY0ZzRkJGK1dIS3dXM21qaHJQdnBT?=
 =?utf-8?B?dEQydm10VnJsb2ZvRlVzZ1VGdWw1Vk5EdGZHZHNOaWlsbHZPeUU0L2lZUzRI?=
 =?utf-8?B?K1I2MUxFc0ZvRGpMbWZEa2ZZTXIzZldsakw5Rm5GTXM5SGFidGR5R240WWlI?=
 =?utf-8?B?ajRZWGs0aUpqeEU1S1RMN29RclMwVGxHZThjUzR3bDZjdnU5SXNTSXY2am9H?=
 =?utf-8?B?ajJUZmpMeFpuOEFoNGhMTEFvLzJMRzgyZi9kTWsvMDRsTlovakIyMm4wMFQy?=
 =?utf-8?Q?aZZgzu83t4J+AwUTVpe22sYX8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff2c41d9-0d86-4ed7-ddfd-08dc0df2b96a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2024 13:32:12.6677 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /LuCSuGR7E5ZOani+cfeJuQiHLm3Jd14YnfjSDL2Q+6hewgldEtmqfVjegXwzRYu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5376
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
Cc: linux-mm@kvack.org, kernel test robot <lkp@intel.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--------------ETniF00x9f0Ecatz80cXDe0Z
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 20.12.23 um 17:58 schrieb Felix Kuehling:
> On 2023-12-11 10:56, Felix Kuehling wrote:
>>
>> On 2023-12-08 05:11, Christian König wrote:
>>> Am 07.12.23 um 20:14 schrieb Felix Kuehling:
>>>>
>>>> On 2023-12-05 17:20, Felix Kuehling wrote:
>>>>> Properly mark kfd_process->ef as __rcu and consistently access it 
>>>>> with
>>>>> rcu_dereference_protected.
>>>>>
>>>>> Reported-by: kernel test robot <lkp@intel.com>
>>>>> Closes: 
>>>>> https://lore.kernel.org/oe-kbuild-all/202312052245.yFpBSgNH-lkp@intel.com/
>>>>> Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
>>>>
>>>> ping.
>>>>
>>>> Christian, would you review this patch, please?
>>>
>>> Looks a bit suspicious, especially the rcu_dereference_protected() use.
>>>
>>> What is the static checker complaining about in the first place?
>> From 
>> https://lore.kernel.org/oe-kbuild-all/202312052245.yFpBSgNH-lkp@intel.com/:
>>
>>>> drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_process.c:1671:9: sparse: 
>>>> sparse: incompatible types in comparison expression (different 
>>>> address spaces):  >> 
>>>> drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_process.c:1671:9: sparse: 
>> struct dma_fence [noderef] __rcu * >> 
>> drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_process.c:1671:9: sparse: 
>> struct dma_fence * ... >> 
>> drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c:2765:36: sparse: 
>> sparse: incompatible types in comparison expression (different 
>> address spaces): >> 
>> drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c:2765:36: sparse: 
>> struct dma_fence [noderef] __rcu * >> 
>> drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c:2765:36: sparse: 
>> struct dma_fence * >> 
>> drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c:2765:36: sparse: 
>> sparse: incompatible types in comparison expression (different 
>> address spaces): >> 
>> drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c:2765:36: sparse: 
>> struct dma_fence [noderef] __rcu * >> 
>> drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c:2765:36: sparse: 
>> struct dma_fence *
>>
>> As far as I can tell, the reason is, that I'm using 
>> dma_fence_get_rcu_safe and rcu_replace_pointer to get and update 
>> kfd_process->ef, without annotating the fence pointers with __rcu. 
>> This patch fixes that by marking kfd_process->ef as an __rcu pointer. 
>> The only place that was dereferencing it directly was 
>> kfd_process_wq_release, where I added rcu_dereference_protected. The 
>> condition I'm using here is, that the process ref count is 0 at that 
>> point, which means nobody else is referencing the process or this 
>> fence pointer at the time.
>
> Hi Christian,
>
> We discussed offline that you think rcu_dereference_protected is not 
> needed in the teardown function. After reading over rcupdate.h, I 
> think a simpler alternative would be to use rcu_access_pointer, after 
> a grace period to ensure there can be no more readers. Based on this 
> comment in rcupdate.h:
>
>   * It is also permissible to use rcu_access_pointer() when read-side
>   * access to the pointer was removed at least one grace period ago, as is
>   * the case in the context of the RCU callback that is freeing up the data,
>   * or after a synchronize_rcu() returns.  This can be useful when tearing
>   * down multi-linked structures after a grace period has elapsed.  However,
>   * rcu_dereference_protected() is normally preferred for this use case.
>
> The last sentence sounds like rcu_dereference_protected should also be 
> OK, though. Either way, it sounds like I need to add a synchronize_rcu 
> call in any case, before freeing the fence. Do you agree with this 
> proposal?
>

Yeah, completely agree. I think the reference to using 
rcu_dereference_protected() is when you protect the pointer with some 
lock, which isn't the case here.

And the question is who is accessing this pointer? If you can guarantee 
that there are no more readers you don't need an synchronize_rcu(), if 
you can't then yes a grace period is necessary here.

Regards,
Christian.

> Regards,
>   Felix
>
>
>>
>> Regards,
>>   Felix
>>
>>
>>>
>>> Regards,
>>> Christian.
>>>
>>>>
>>>> Thanks,
>>>>   Felix
>>>>
>>>>
>>>>
>>>>> ---
>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h       | 2 +-
>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 4 ++--
>>>>>   drivers/gpu/drm/amd/amdkfd/kfd_priv.h            | 2 +-
>>>>>   drivers/gpu/drm/amd/amdkfd/kfd_process.c         | 6 ++++--
>>>>>   4 files changed, 8 insertions(+), 6 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h 
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>>>> index f2e920734c98..20cb266dcedd 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>>>>> @@ -314,7 +314,7 @@ void 
>>>>> amdgpu_amdkfd_gpuvm_unmap_gtt_bo_from_kernel(struct kgd_mem *mem);
>>>>>   int amdgpu_amdkfd_map_gtt_bo_to_gart(struct amdgpu_device *adev, 
>>>>> struct amdgpu_bo *bo);
>>>>>     int amdgpu_amdkfd_gpuvm_restore_process_bos(void *process_info,
>>>>> -                        struct dma_fence **ef);
>>>>> +                        struct dma_fence __rcu **ef);
>>>>>   int amdgpu_amdkfd_gpuvm_get_vm_fault_info(struct amdgpu_device 
>>>>> *adev,
>>>>>                             struct kfd_vm_fault_info *info);
>>>>>   int amdgpu_amdkfd_gpuvm_import_dmabuf_fd(struct amdgpu_device 
>>>>> *adev, int fd,
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c 
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>>>> index 7d91f99acb59..8ba6f6c8363d 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>>>> @@ -2806,7 +2806,7 @@ static void 
>>>>> amdgpu_amdkfd_restore_userptr_worker(struct work_struct *work)
>>>>>       put_task_struct(usertask);
>>>>>   }
>>>>>   -static void replace_eviction_fence(struct dma_fence **ef,
>>>>> +static void replace_eviction_fence(struct dma_fence __rcu **ef,
>>>>>                      struct dma_fence *new_ef)
>>>>>   {
>>>>>       struct dma_fence *old_ef = rcu_replace_pointer(*ef, new_ef, 
>>>>> true
>>>>> @@ -2841,7 +2841,7 @@ static void replace_eviction_fence(struct 
>>>>> dma_fence **ef,
>>>>>    * 7.  Add fence to all PD and PT BOs.
>>>>>    * 8.  Unreserve all BOs
>>>>>    */
>>>>> -int amdgpu_amdkfd_gpuvm_restore_process_bos(void *info, struct 
>>>>> dma_fence **ef)
>>>>> +int amdgpu_amdkfd_gpuvm_restore_process_bos(void *info, struct 
>>>>> dma_fence __rcu **ef)
>>>>>   {
>>>>>       struct amdkfd_process_info *process_info = info;
>>>>>       struct amdgpu_vm *peer_vm;
>>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h 
>>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>>>> index 45366b4ca976..5a24097a9f28 100644
>>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
>>>>> @@ -917,7 +917,7 @@ struct kfd_process {
>>>>>        * fence will be triggered during eviction and new one will 
>>>>> be created
>>>>>        * during restore
>>>>>        */
>>>>> -    struct dma_fence *ef;
>>>>> +    struct dma_fence __rcu *ef;
>>>>>         /* Work items for evicting and restoring BOs */
>>>>>       struct delayed_work eviction_work;
>>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c 
>>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>>>> index 71df51fcc1b0..14b11d61f8dd 100644
>>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>>>> @@ -1110,6 +1110,8 @@ static void kfd_process_wq_release(struct 
>>>>> work_struct *work)
>>>>>   {
>>>>>       struct kfd_process *p = container_of(work, struct kfd_process,
>>>>>                            release_work);
>>>>> +    struct dma_fence *ef = rcu_dereference_protected(p->ef,
>>>>> +        kref_read(&p->ref) == 0);
>>>>>         kfd_process_dequeue_from_all_devices(p);
>>>>>       pqm_uninit(&p->pqm);
>>>>> @@ -1118,7 +1120,7 @@ static void kfd_process_wq_release(struct 
>>>>> work_struct *work)
>>>>>        * destroyed. This allows any BOs to be freed without
>>>>>        * triggering pointless evictions or waiting for fences.
>>>>>        */
>>>>> -    dma_fence_signal(p->ef);
>>>>> +    dma_fence_signal(ef);
>>>>>         kfd_process_remove_sysfs(p);
>>>>>   @@ -1127,7 +1129,7 @@ static void kfd_process_wq_release(struct 
>>>>> work_struct *work)
>>>>>       svm_range_list_fini(p);
>>>>>         kfd_process_destroy_pdds(p);
>>>>> -    dma_fence_put(p->ef);
>>>>> +    dma_fence_put(ef);
>>>>>         kfd_event_free_process(p);
>>>
>>

--------------ETniF00x9f0Ecatz80cXDe0Z
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    Am 20.12.23 um 17:58 schrieb Felix Kuehling:<br>
    <blockquote type="cite" cite="mid:ef8c4273-d54d-42b6-ac60-fed5f8ed3848@amd.com">
      
      <div class="moz-cite-prefix">On 2023-12-11 10:56, Felix Kuehling
        wrote:<br>
      </div>
      <blockquote type="cite" cite="mid:7b67d4f1-cfcd-47a9-a80e-f4c1eee235a1@amd.com"> <br>
        On 2023-12-08 05:11, Christian König wrote: <br>
        <blockquote type="cite">Am 07.12.23 um 20:14 schrieb Felix
          Kuehling: <br>
          <blockquote type="cite"> <br>
            On 2023-12-05 17:20, Felix Kuehling wrote: <br>
            <blockquote type="cite">Properly mark kfd_process-&gt;ef as
              __rcu and consistently access it with <br>
              rcu_dereference_protected. <br>
              <br>
              Reported-by: kernel test robot <a class="moz-txt-link-rfc2396E" href="mailto:lkp@intel.com" moz-do-not-send="true">&lt;lkp@intel.com&gt;</a>
              <br>
              Closes:
              <a class="moz-txt-link-freetext" href="https://lore.kernel.org/oe-kbuild-all/202312052245.yFpBSgNH-lkp@intel.com/" moz-do-not-send="true">https://lore.kernel.org/oe-kbuild-all/202312052245.yFpBSgNH-lkp@intel.com/</a><br>
              Signed-off-by: Felix Kuehling <a class="moz-txt-link-rfc2396E" href="mailto:Felix.Kuehling@amd.com" moz-do-not-send="true">&lt;Felix.Kuehling@amd.com&gt;</a>
              <br>
            </blockquote>
            <br>
            ping. <br>
            <br>
            Christian, would you review this patch, please? <br>
          </blockquote>
          <br>
          Looks a bit suspicious, especially the
          rcu_dereference_protected() use. <br>
          <br>
          What is the static checker complaining about in the first
          place? <br>
        </blockquote>
        From
        <a class="moz-txt-link-freetext" href="https://lore.kernel.org/oe-kbuild-all/202312052245.yFpBSgNH-lkp@intel.com/" moz-do-not-send="true">https://lore.kernel.org/oe-kbuild-all/202312052245.yFpBSgNH-lkp@intel.com/</a>:<br>
        <br>
        <blockquote type="cite">
          <blockquote type="cite">drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_process.c:1671:9:
            sparse: sparse: incompatible types in comparison expression
            (different address spaces):&nbsp; &gt;&gt;
            drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_process.c:1671:9:
            sparse: </blockquote>
        </blockquote>
        struct dma_fence [noderef] __rcu * &gt;&gt;
        drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_process.c:1671:9:
        sparse: struct dma_fence * ... &gt;&gt;
        drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c:2765:36:
        sparse: sparse: incompatible types in comparison expression
        (different address spaces): &gt;&gt;
        drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c:2765:36:
        sparse: struct dma_fence [noderef] __rcu * &gt;&gt;
        drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c:2765:36:
        sparse: struct dma_fence * &gt;&gt;
        drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c:2765:36:
        sparse: sparse: incompatible types in comparison expression
        (different address spaces): &gt;&gt;
        drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c:2765:36:
        sparse: struct dma_fence [noderef] __rcu * &gt;&gt;
        drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c:2765:36:
        sparse: struct dma_fence * <br>
        <br>
        As far as I can tell, the reason is, that I'm using
        dma_fence_get_rcu_safe and rcu_replace_pointer to get and update
        kfd_process-&gt;ef, without annotating the fence pointers with
        __rcu. This patch fixes that by marking kfd_process-&gt;ef as an
        __rcu pointer. The only place that was dereferencing it directly
        was kfd_process_wq_release, where I added
        rcu_dereference_protected. The condition I'm using here is, that
        the process ref count is 0 at that point, which means nobody
        else is referencing the process or this fence pointer at the
        time. <br>
      </blockquote>
      <p>Hi Christian,</p>
      <p>We discussed offline that you think rcu_dereference_protected
        is not needed in the teardown function. After reading over
        rcupdate.h, I think a simpler alternative would be to use
        rcu_access_pointer, after a grace period to ensure there can be
        no more readers. Based on this comment in rcupdate.h:</p>
      <pre> * It is also permissible to use rcu_access_pointer() when read-side
 * access to the pointer was removed at least one grace period ago, as is
 * the case in the context of the RCU callback that is freeing up the data,
 * or after a synchronize_rcu() returns.  This can be useful when tearing
 * down multi-linked structures after a grace period has elapsed.  However,
 * rcu_dereference_protected() is normally preferred for this use case.
</pre>
      <p>The last sentence sounds like rcu_dereference_protected should
        also be OK, though. Either way, it sounds like I need to add a
        synchronize_rcu call in any case, before freeing the fence. Do
        you agree with this proposal?</p>
    </blockquote>
    <br>
    Yeah, completely agree. I think the reference to using
    rcu_dereference_protected() is when you protect the pointer with
    some lock, which isn't the case here.<br>
    <br>
    And the question is who is accessing this pointer? If you can
    guarantee that there are no more readers you don't need an
    synchronize_rcu(), if you can't then yes a grace period is necessary
    here.<br>
    <br>
    Regards,<br>
    Christian.<br>
    <br>
    <blockquote type="cite" cite="mid:ef8c4273-d54d-42b6-ac60-fed5f8ed3848@amd.com">
      <p>Regards,<br>
        &nbsp; Felix<br>
      </p>
      <p><br>
      </p>
      <blockquote type="cite" cite="mid:7b67d4f1-cfcd-47a9-a80e-f4c1eee235a1@amd.com"> <br>
        Regards, <br>
        &nbsp; Felix <br>
        <br>
        <br>
        <blockquote type="cite"> <br>
          Regards, <br>
          Christian. <br>
          <br>
          <blockquote type="cite"> <br>
            Thanks, <br>
            &nbsp; Felix <br>
            <br>
            <br>
            <br>
            <blockquote type="cite">--- <br>
              &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 2 +-
              <br>
              &nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 4
              ++-- <br>
              &nbsp; drivers/gpu/drm/amd/amdkfd/kfd_priv.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 2 +-
              <br>
              &nbsp; drivers/gpu/drm/amd/amdkfd/kfd_process.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 6
              ++++-- <br>
              &nbsp; 4 files changed, 8 insertions(+), 6 deletions(-) <br>
              <br>
              diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
              b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h <br>
              index f2e920734c98..20cb266dcedd 100644 <br>
              --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h <br>
              +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h <br>
              @@ -314,7 +314,7 @@ void
              amdgpu_amdkfd_gpuvm_unmap_gtt_bo_from_kernel(struct
              kgd_mem *mem); <br>
              &nbsp; int amdgpu_amdkfd_map_gtt_bo_to_gart(struct
              amdgpu_device *adev, struct amdgpu_bo *bo); <br>
              &nbsp; &nbsp; int amdgpu_amdkfd_gpuvm_restore_process_bos(void
              *process_info, <br>
              -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dma_fence **ef); <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dma_fence __rcu **ef); <br>
              &nbsp; int amdgpu_amdkfd_gpuvm_get_vm_fault_info(struct
              amdgpu_device *adev, <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_vm_fault_info
              *info); <br>
              &nbsp; int amdgpu_amdkfd_gpuvm_import_dmabuf_fd(struct
              amdgpu_device *adev, int fd, <br>
              diff --git
              a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
              b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c <br>
              index 7d91f99acb59..8ba6f6c8363d 100644 <br>
              --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c <br>
              +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c <br>
              @@ -2806,7 +2806,7 @@ static void
              amdgpu_amdkfd_restore_userptr_worker(struct work_struct
              *work) <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; put_task_struct(usertask); <br>
              &nbsp; } <br>
              &nbsp; -static void replace_eviction_fence(struct dma_fence
              **ef, <br>
              +static void replace_eviction_fence(struct dma_fence __rcu
              **ef, <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dma_fence *new_ef) <br>
              &nbsp; { <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dma_fence *old_ef = rcu_replace_pointer(*ef,
              new_ef, true <br>
              @@ -2841,7 +2841,7 @@ static void
              replace_eviction_fence(struct dma_fence **ef, <br>
              &nbsp;&nbsp; * 7.&nbsp; Add fence to all PD and PT BOs. <br>
              &nbsp;&nbsp; * 8.&nbsp; Unreserve all BOs <br>
              &nbsp;&nbsp; */ <br>
              -int amdgpu_amdkfd_gpuvm_restore_process_bos(void *info,
              struct dma_fence **ef) <br>
              +int amdgpu_amdkfd_gpuvm_restore_process_bos(void *info,
              struct dma_fence __rcu **ef) <br>
              &nbsp; { <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdkfd_process_info *process_info = info; <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_vm *peer_vm; <br>
              diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
              b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h <br>
              index 45366b4ca976..5a24097a9f28 100644 <br>
              --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h <br>
              +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h <br>
              @@ -917,7 +917,7 @@ struct kfd_process { <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * fence will be triggered during eviction and new
              one will be created <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * during restore <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */ <br>
              -&nbsp;&nbsp;&nbsp; struct dma_fence *ef; <br>
              +&nbsp;&nbsp;&nbsp; struct dma_fence __rcu *ef; <br>
              &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Work items for evicting and restoring BOs */ <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct delayed_work eviction_work; <br>
              diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
              b/drivers/gpu/drm/amd/amdkfd/kfd_process.c <br>
              index 71df51fcc1b0..14b11d61f8dd 100644 <br>
              --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c <br>
              +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c <br>
              @@ -1110,6 +1110,8 @@ static void
              kfd_process_wq_release(struct work_struct *work) <br>
              &nbsp; { <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct kfd_process *p = container_of(work, struct
              kfd_process, <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; release_work); <br>
              +&nbsp;&nbsp;&nbsp; struct dma_fence *ef =
              rcu_dereference_protected(p-&gt;ef, <br>
              +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kref_read(&amp;p-&gt;ref) == 0); <br>
              &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_process_dequeue_from_all_devices(p); <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pqm_uninit(&amp;p-&gt;pqm); <br>
              @@ -1118,7 +1120,7 @@ static void
              kfd_process_wq_release(struct work_struct *work) <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * destroyed. This allows any BOs to be freed
              without <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * triggering pointless evictions or waiting for
              fences. <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */ <br>
              -&nbsp;&nbsp;&nbsp; dma_fence_signal(p-&gt;ef); <br>
              +&nbsp;&nbsp;&nbsp; dma_fence_signal(ef); <br>
              &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_process_remove_sysfs(p); <br>
              &nbsp; @@ -1127,7 +1129,7 @@ static void
              kfd_process_wq_release(struct work_struct *work) <br>
              &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; svm_range_list_fini(p); <br>
              &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_process_destroy_pdds(p); <br>
              -&nbsp;&nbsp;&nbsp; dma_fence_put(p-&gt;ef); <br>
              +&nbsp;&nbsp;&nbsp; dma_fence_put(ef); <br>
              &nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; kfd_event_free_process(p); <br>
            </blockquote>
          </blockquote>
          <br>
        </blockquote>
        <br>
      </blockquote>
    </blockquote>
    <br>
  </body>
</html>

--------------ETniF00x9f0Ecatz80cXDe0Z--
