Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46D76C77B61
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Apr 2023 14:11:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF7CB10E740;
	Tue, 25 Apr 2023 14:11:56 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2042.outbound.protection.outlook.com [40.107.101.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E1B4410E741
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Apr 2023 14:11:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=frL0apiR09Mq8JJz73LMWoXVEuro+iP/XPE0urMPyVa3qe+5720eseMJ3MHGqk6B/PX8+QfRT7YNkLopLFMTQjINw0FBzWegENv0hMyF+Id08Z6F6CWYFyRZsnsufe3rdjjWq8IY9TJtMrSATj4IUMHE0Qr34GHKXfAuaQYHcpXJA/HqhiCe79SKnIKanIdAAn7+oJ4CK9byxJxW1poe+8KlysjaLS3VW8c4OtlKTz05ChNhD7nz4oLXSTrxUlBwsGoyEi4/eMj5kNGeqR9z+/CWzt+bg2wucFhzE94k4vT+J/utDPnaC1Abt/6OsOBBtI3eVuRs5ex8cbnjWC5ebA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ItU2AvJCvxr5xYti9rqbftnkooLPpYxZdlkn2VubVNI=;
 b=Y9cKlFT5UO/km0M3UCKABovINEXNgg3T8RjhbvycongjXjuwEDPRPJTXrlyqzW8E3Lv2ozvY9OgRVyBEMncPpiVd08bLAcuUcFbRY0A4GV9Yzp+Fam/g2iXJSomvujnpwn38wYLSWYoxFpN3QpXtpxEKoSzYT4lZ27b8Eb4QqqdJChimiKKWmi7u24Y3qMjv1BTGl/HQ1IAE2H1adLDh80B8iDa5ZmaadBn+enJSQQmh1WqS6+rLnXSzjzd7RfbZJZXz6pgUR1J7mWvslo3dS1QvWArHb1xtf+p6lChZxPRFZnJW79iR/+CjqUZvG3DMkZ9Q/5OOp9evLSoI1WCx+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ItU2AvJCvxr5xYti9rqbftnkooLPpYxZdlkn2VubVNI=;
 b=3P5ThC4UJkoufnoZgHXNsDT6553Wl88VJWgIUpFFTkEB/ezbh2aZf1HgMgoga6fEZcTnvdbLRB3O0/nFFJttDhRfTeqTETdKYrWlItVvN+KkkQOUwrc4DGX06GeZrp5V01ry8kDEDa2MJRbyIOcVmSTXH2IRPCqShAbw9jUrimQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5336.namprd12.prod.outlook.com (2603:10b6:208:314::8)
 by CYYPR12MB8924.namprd12.prod.outlook.com (2603:10b6:930:bd::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.34; Tue, 25 Apr
 2023 14:11:51 +0000
Received: from BL1PR12MB5336.namprd12.prod.outlook.com
 ([fe80::d5f4:ed47:53c1:ef9c]) by BL1PR12MB5336.namprd12.prod.outlook.com
 ([fe80::d5f4:ed47:53c1:ef9c%7]) with mapi id 15.20.6319.034; Tue, 25 Apr 2023
 14:11:51 +0000
Message-ID: <73c8c82e-907a-1666-b05b-4ba257363a01@amd.com>
Date: Tue, 25 Apr 2023 10:11:46 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] drm/amdgpu: Ignore KFD eviction fences invalidating
 preemptible DMABuf imports
To: Felix Kuehling <felix.kuehling@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org, "Koenig, Christian" <Christian.Koenig@amd.com>
References: <20230412222511.236384-1-jinhuieric.huang@amd.com>
 <ce2de03d-27c5-a7ad-1a76-814cbd92f15e@amd.com>
 <6d32ae76-08fa-64a4-6726-2d55e8c9fc08@gmail.com>
 <7df3dfd1-d89c-1f24-c3b9-789e1bedf138@amd.com>
Content-Language: en-US
From: Eric Huang <jinhuieric.huang@amd.com>
In-Reply-To: <7df3dfd1-d89c-1f24-c3b9-789e1bedf138@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0051.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:1::28) To BL1PR12MB5336.namprd12.prod.outlook.com
 (2603:10b6:208:314::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5336:EE_|CYYPR12MB8924:EE_
X-MS-Office365-Filtering-Correlation-Id: 559b297e-cc9e-4211-d5a5-08db459703a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cqmjo62usCPVymk0/NUeyMrFkTNJGI2nLQHO3KdpnPfd+INbv+g16U1hzGJs1w92XSoQ8gLd83j7jNqBW6tNvjxGpH0IPve4pI6IY3/E27ddxVc8MiKZLOHqOGsXpEMaAninB885+JEJZeTWSpE9oMXg6WwFU7uVG68+JJoPG6o/m1C14W1H0OQfi16dj8yXc2c4qvDit4Z2Tq9qHKnrYmr5WXeNX+bkeFa8Ccm9qPLEe/xGffImrT+5jq7ebz5DeUjh32mLC16I6cQ3Lrb4hcRroeuGBAKFJ9Xr/A7FFkfxOUb6afDEQx3Rb8gKkb91kOWAUnquEuvPLFvn3lnqQmnWhAz0sbSNccnxVGQlshlsj53QZjcMhIjc36pvIGj5Z1hij3fwJh79yP1YD/NVC5PbZoSIFKA/3Tds43YCjpgj7DlAdSUsgH+yyVD8LU229ByjBbXa2N59Rl5ONd7mkT9VfTSi/ptjI0YB4N7qT8rnwk7umMgZiLtwPOTwsTVDFSnmsanOGdOnNGAfcmhJjY7c6+j97rmb8olaGqtFi9hGaH5sXoUycgcANhf/LccKL/k8mxEcmfC2OYLXS7lL8Y2HtplQlGoYV9R7NJI6KjcH5+j7N58nHx9GCnhHORvBRjNp9VQqLv/izxHz2Dzj0g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5336.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(396003)(376002)(39860400002)(346002)(366004)(451199021)(36756003)(110136005)(6636002)(31696002)(86362001)(478600001)(38100700002)(41300700001)(8936002)(8676002)(2906002)(66476007)(66556008)(316002)(66946007)(5660300002)(186003)(6512007)(6506007)(26005)(53546011)(31686004)(83380400001)(66574015)(2616005)(6486002)(6666004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R1JPM0xVOGR2b2NjL1A4ZkgwSVVTdDUvcmRsMkFyaE1MWndtZUJ1MXhiSWVH?=
 =?utf-8?B?NkJDcUtpZnF1dkhhWktxNW1NWGpDNEltRDl3aStyOEVQZVJvakpNS3duYTRo?=
 =?utf-8?B?N1I2UW1qWHc0VzFHOU9USCtRdisxM2prYXY3WTRJNUdwejNnU1ZCNTB6Vmd2?=
 =?utf-8?B?bjRsZVIyRzFlYnErY1I5aEdHb1MxOGJrb3hPazAra3Vra0pDcGw2Qy8wWXV2?=
 =?utf-8?B?Y1NZMndEOHN2UlFlZnRUY05zOThvNGJFUm91YlhLN2liaG9UbWxzZ3pBbXFB?=
 =?utf-8?B?TDNiWEhHREVxbWJIdE9FUmw1cFg0cHZUWkJ6aS8zZmdtQzBMNGlDNW1ucEl0?=
 =?utf-8?B?MlNxd3hkZUQrUFdkMEFKU3c3RlF5a1E1TmFxNE5NUWNZMnR5OFYzSUJnTDFr?=
 =?utf-8?B?RWRwTC9nTFpQcTlMKzJXZlJVN2RUa2ZDd25ncitkUE1zUXlKN1VvRUNpVXIv?=
 =?utf-8?B?QzlNdmVJQnJ6Sk1YcENheVdwelhNYU5ka1VTd1NSRXhJc0dJZS91VFErV1Uy?=
 =?utf-8?B?YUt6TjhuMldYUndmckJscEVXU3RNZzY0c29IMFZBUHZFd0tIak9EMFZKL2tV?=
 =?utf-8?B?cWxCRGhoUE9mbjNhMXdCeXRNNUdvTE9HYzIvL1ptbkVkZDB2aDZMc0FsQ1pL?=
 =?utf-8?B?QjFFM3N6aVpZSzBjeGlaeW1DQXYvcEVLQVFVUnhta2FuaEE2RVNwOVdVQURv?=
 =?utf-8?B?S2dlTGMxeU94ejQ1QVFUVTE3cGF0eWwrOE9vTXM5cjl3aWh5dVV0eUNVVmZp?=
 =?utf-8?B?NDlvVlpmODdXZkdkSEo2eEJ3K2hkTHliN0VZMGZuVlh1cHFodmZ1M3llMFpR?=
 =?utf-8?B?L2xOUmVkM2YyNDlxV2lBRzQ3Q2l4ZWpPcmNqVGplbnAvWlArYjFSNVNITzFP?=
 =?utf-8?B?dG00Q1QrSHJHSU03VDhoRnNSZEJpQUl1dEIrUkJkcE5XaW9Eb0FCeGwvOEF1?=
 =?utf-8?B?cDlhbGhQbkJFYVVXeWpZY1Z2WFIvaHNEeTk0UnhUdDIvczZSVUx0Qjl3Z1ND?=
 =?utf-8?B?eHNMNDU0aTNvZkoyWW1UOUo3cU5OVGVhUlc0Nm5GTTA5cDNMWTNsK3NlMVMw?=
 =?utf-8?B?ZTF0QSs2OFd1aFVnM2pBRVhqK3NnM3V6SFFqMk5jQkFjV0YxUW5yMmFZSUZY?=
 =?utf-8?B?UXc5TWdCUkgwYUg4d1FjdXNNNGlIR0ZsSkRSOGovZ2RoblRZTTBZVElXMjBK?=
 =?utf-8?B?Znh2VnQydlVGTTkwWlRRRlpGT1VtWE5HRjlaTUNLN2lFUklJK01UM1RWOTEy?=
 =?utf-8?B?N0NyS0lZdklNSWRpRG1lY3hCWUR1VUJaeFN5VlF1ME9IZ0FQd3pmamExQ2x3?=
 =?utf-8?B?Q1RnWk1ldE41eG1PYUIrd2tpTzNmdDVsTE4zR2M3Rk9qVHlsc2tBcXEvSHJO?=
 =?utf-8?B?eStGZVJVVmxRNUFyMmt5SWgyeVNEU1pkU2lTRjBGamFmbVBjRmxGd0NPZld4?=
 =?utf-8?B?VGJpMGtZNVJFNWg5RzgzeWtYNDlYUUN4ZXdHb25ZWFJhWDBQa1dYTGdwT0xk?=
 =?utf-8?B?VXMvTXpSSEorSFRzNWNLbzhkbUEwYk1ZR2gyS2kxM2VZUzJKTVNtZndJM3h2?=
 =?utf-8?B?K0VSMEFTOUlQNVJZVjd5bVB3dm1mRzBHWkpYR3M3eFpvT1plUzE1NVkvVy9s?=
 =?utf-8?B?dTF3dmY4Q0VmdVNEWEJMTGxNWkRVMjVQdWVGeUtYd0pDb1MyRExUbUVObTRi?=
 =?utf-8?B?YXMyU3paUWY0YzFWNDlkbGl0S3hmbUVnbDQyUkwxekQrZXRWNEZ5VkgydXRS?=
 =?utf-8?B?c0ZBMkEvYkNGaEJKSUhNMStsN3UwayszNCtmeFNhdEZ0a0R6YWo3bDNQMWE3?=
 =?utf-8?B?U3BWcG9CditrZUd0MFFoaVBIOGptUjYvNWJJRXhMRlpZeWVxUkNrYkUwWnpV?=
 =?utf-8?B?ZVVjbHlLSUJhMEp0Skd2WElCNHpkOGFicHNMWFg5M2hKcW5wQUtoVEcrUHJt?=
 =?utf-8?B?OW9TTjNEU1V2UHNaS3haYzVucGZwdjFlOENjck9pY1hUT2R6UTNwcXpGcjBp?=
 =?utf-8?B?bW45dTU4bFJtVVF1Z3JYUmE4ZlJiWVJKL01ORnJsQTRXWm9UeDdlRWZNTkRx?=
 =?utf-8?B?dzQ1UGtMdWVqaXFyMmJwcUpxdEFtZXlnb3U2SFEwZWdjMFFKSU45eVdocmpv?=
 =?utf-8?Q?hwtGk7Ss7bniv9knxWWPGLshR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 559b297e-cc9e-4211-d5a5-08db459703a6
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5336.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2023 14:11:50.9497 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8GIghbbg5ttMEAJvw+1Oatfj5hRLbHydPbszutImr4rj4/m9DjcKj4HoKtj/RDYPUOLR64EH/+hcOxVUvCn+Ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8924
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

Hi Christian,

What do you think about Felix's explanation?

Regards,
Eric

On 2023-04-13 09:28, Felix Kuehling wrote:
> Am 2023-04-13 um 07:35 schrieb Christian König:
>> Am 13.04.23 um 03:01 schrieb Felix Kuehling:
>>> Am 2023-04-12 um 18:25 schrieb Eric Huang:
>>>> It is to avoid redundant eviction for KFD's DMAbuf import
>>>> bo when dmaunmapping DMAbuf. The DMAbuf import bo has
>>>> been set as AMDGPU_PL_PREEMPT in KFD when mapping.
>>>>
>>>> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>
>>>
>>> Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
>>>
>>> I'd like to get an Acked-by from Christian as well before submitting 
>>> this.
>>
>> I have to admit that I only partially followed the internal 
>> discussion, but in general you need a *really* good explanation for 
>> this.
>>
>> E.g. add code comment and explain in the commit message extensively 
>> why this is needed and why there are no alternatives.
>
> OK. I'll give it a shot:
>
>    This code path is used among other things when invalidating DMABuf
>    imports. These imports share a reservation object with the exported
>    BO. Waiting on all the fences in this reservation will trigger KFD
>    eviction fences unnecessarily, for example when a DMABuf import for
>    a DMA mapping on a secondary GPU is being unmapped explicitly. Only
>    moving the original exported BO requires stopping KFD user mode
>    queues. If the invalidation is triggered through a move notifier
>    from the exported BO, then moving the original BO already triggered
>    the eviction fence and we don't need to wait for it again on the 
> import.
>
>    We can identify DMABuf imports in KFD for secondary GPU DMA mappings
>    by the mem_type AMDGPU_PL_PREEMPT. In this case, use a wait
>    operation that ignores KFD eviction fences.
>
> How does this sound?
>
> Regards,
>   Felix
>
>
>>
>> Regards,
>> Christian.
>>
>>>
>>> Thanks,
>>>   Felix
>>>
>>>
>>>> ---
>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 7 ++++++-
>>>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c 
>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>> index 2430f3e9f3a7..64795fe9eecb 100644
>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>>>> @@ -526,7 +526,12 @@ static int amdgpu_bo_move(struct 
>>>> ttm_buffer_object *bo, bool evict,
>>>>       if ((old_mem->mem_type == TTM_PL_TT ||
>>>>            old_mem->mem_type == AMDGPU_PL_PREEMPT) &&
>>>>           new_mem->mem_type == TTM_PL_SYSTEM) {
>>>> -        r = ttm_bo_wait_ctx(bo, ctx);
>>>> +        if (old_mem->mem_type == AMDGPU_PL_PREEMPT)
>>>> +            r = amdgpu_bo_sync_wait(abo,
>>>> +                        AMDGPU_FENCE_OWNER_KFD,
>>>> +                        ctx->interruptible);
>>>> +        else
>>>> +            r = ttm_bo_wait_ctx(bo, ctx);
>>>>           if (r)
>>>>               return r;
>>

