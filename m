Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19E7FC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Apr 2022 14:43:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F29110EEB2;
	Tue, 19 Apr 2022 14:43:09 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2063.outbound.protection.outlook.com [40.107.102.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 55B3010EEA8
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Apr 2022 14:43:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NTGx9O88Yy8kyeOaUbXSRiug6e+kye40ukFdNhqrKEyZvpoheE449OM5pfhn820xmeQcJtxgCWCIviT3ix+QZJg1tCrtgTaYQquGkXkNHdr1QQuc2nNU0PaYOV+lwvnu4dsYy5q5Z7mFRYWgJrfbq8vjPohNu7BgRMFCzL8Brk83/04XwL8vR63VWAzmGTR/NZ+uktBbcoa44eGud1SPVMWJht8XIl+qYTXn+LJJJP7iLFeqjHFlFkInDN5nflT7ZbSd21Lf8YrbruxkHQzrYZAR1ECMuJoKKCM7ChlwbsPKUjKpub6p2lNvgWhhY6B2wzV38D/peHPp15gZywnvQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MM9QYfvu67ztkUaMPJK+aBJMBDZ+sQMSdjhqVv+KcxQ=;
 b=KH6euxuhRVV0EefzTu4Ihh5lLShQ5tg0f3k7DnYpUMSDOVRb/HXahzltEkFbDOJFt0PzZkfVZdZQVwHawxH5yhhHdfs1OHhKzLVJXnvxulIy8zbrSvzne7MA3mZYU2JRbNNZziL+B2Zt33cfZJfSbcCFig+MbVXUfxbTgIhdat2Jnmfz/vb3s1RrLKP6x/slmxw108gWMLhALrqEIi24pPY7lsoqRPv7bgKTrfOBeRTUc4L4AhnsR1S6oHLfxelW0P45BQU0etZukMS04Bhahs1ZDK62TKEcgX7+/Acv2yGIDJF+2yUS0SDd1b8uLiDbDmYyltbn7j8z36IEyJbO7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MM9QYfvu67ztkUaMPJK+aBJMBDZ+sQMSdjhqVv+KcxQ=;
 b=K5lvXJc4ZS+CfH9ns8OyHUXxgHyADy0FG1H6E9mQWh4TBh24uqKlezJFqO3FoxfhxntjZy6VWuwwpg+R63jW6tfrlBFUixUYmeWqYnuumjpl6Hp780TPVehMn5PVp1ngrSGv6Dajm18DF9wQYFktFTV8GSYsXYCPzP1tB/PBLkE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by MWHPR12MB1501.namprd12.prod.outlook.com (2603:10b6:301:f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Tue, 19 Apr
 2022 14:43:04 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::a5fb:7137:5e64:cf8]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::a5fb:7137:5e64:cf8%5]) with mapi id 15.20.5164.026; Tue, 19 Apr 2022
 14:43:04 +0000
Message-ID: <29e81464-ad03-a159-ef4c-3dd39563299b@amd.com>
Date: Tue, 19 Apr 2022 16:42:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 2/2] drm/amdgpu: remove pointless ttm_eu usage from DM
Content-Language: en-US
To: Harry Wentland <harry.wentland@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 Ryan.Taylor@amd.com, amd-gfx@lists.freedesktop.org
References: <20220419141915.122157-1-christian.koenig@amd.com>
 <20220419141915.122157-2-christian.koenig@amd.com>
 <a9ec25f0-0404-3b4b-64fd-8acf697ca3b9@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <a9ec25f0-0404-3b4b-64fd-8acf697ca3b9@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0006.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::16) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9c316a82-f23e-4110-e537-08da2212e8d3
X-MS-TrafficTypeDiagnostic: MWHPR12MB1501:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB150105008B51A2396928A48983F29@MWHPR12MB1501.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z+kSrh120C8BFZBiYh5kjEFz9/EwZD/gQ0FnKvJYMpMnGuUgnuvcFQXbevWXIb4Ha7ElASi0WqnJGPV+ZdR4mchRhMDS34t8KYxJ78cnfbhB2Q0Qen9n6IoPfP65YPoACQXQyIWfgEHCWOaix24iWbGukHWkALHf0Eb+w/mf8UzA+CEEn96Ve0vqfd8I9zVW7WCyVeitDLCMGY0JwkRng+XX+fFXLpZXG0/BrEppruDoyH6h60bcUcyHp205H+CyY/cYke+slmP+jzm/cfr9qPQOKBPj40zJ7ZZR11UKulSFSOF85tDoHHZ8tREoSVersCmimL8BAqErIPwWmla4qPUwBtfGL8O4m1mY89stUW7d1Tdvwwf4j7PnFBf1wt6lWVCjjjtnGxn7r1yNW3L1sRtBFXdKhCBLLNdEIxsmMIiwgmbiJ0UuJhPD1VfQ6+Y+89ympkb5Xy85lk7mpO38pGy620LMo//haD36Rotpz0Vbct/EPkwFoWGE44MRi56YhR7MKAnKLfgX0GcDOJQF8NUUcE7fSaxNJfRA+9eMvsTYt55WdoKw0mjVjhShcC8bMQ+SLqQefpRiP1EHL5RtsKAdsPEPT9hyvqAbFlufOGXvpOkGUmShz0t59/e7m326JL+MC3q5ZW+aXkeO/bLcIyjLMTLetOUOxYX/oGJpQeoRh3xtXtGM5Zx4Lt4F7d1rbo7vLzmGAglLlLspkknSn0VsxSNXgYeDrhO41AdXucak0JOmsTk8Gq+TK/xYcDoz
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6512007)(53546011)(6666004)(83380400001)(66946007)(66574015)(186003)(2906002)(5660300002)(8936002)(2616005)(6486002)(110136005)(6506007)(66476007)(8676002)(316002)(66556008)(508600001)(38100700002)(36756003)(31686004)(31696002)(86362001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b1hTUjN0S3FTM3FYSkxUTittR0hKZTMwQzQ5bkFuaFpwVGs1UytkTzZSUFA1?=
 =?utf-8?B?YmhBZ0p1U0RlZEVQVDRVMlFhOXg2bXdnbTNxYzNNa2QzVFZpd09WbktJWjdm?=
 =?utf-8?B?a2RNVEh1K0JuM3RKcENIcFFkMnNWbVh0SVV1UG9pS3JXZE5qT0d4ZHlucm1m?=
 =?utf-8?B?ZVArU3RuVFJJZE1RdzU1eGNqckpzbXJGUDI2U1ZYOE9XcmQrVHY3UTB4T2Jy?=
 =?utf-8?B?Sll5REZBSlZxaWRnNVhJRjFaeVk1a0JKZkl4Y0JZQ0M0VVNEKzZhR3liU3Fz?=
 =?utf-8?B?N0Q1N0tyeDBDSC80TUEvSGt2bXJlQUU2RDRUME9qQXNJYWlLb280Zm1ua3d1?=
 =?utf-8?B?ZTl1WXM0SU16T1cyVVhCcnkyWmRwU0ZINFJZM3FPTjVHYzhTOUg2VlU1MlJl?=
 =?utf-8?B?eFA5c2owYlZZRWdWWCtZbm43bW05QWdhSzNmQjZkV0NndnZhcUREeU1ndkFZ?=
 =?utf-8?B?dC9XbTIwZi9CTFNKaUswOGovWTdTdUh1Z1lJZzl1Q3pGT3B5TTluT3ZuejJK?=
 =?utf-8?B?T2dHeGxaOWNsQzBJSkJuU1NYalFKMGkzSUhpeXE0ZEhwTGNpaE9aVjc4OVBQ?=
 =?utf-8?B?OTMvcnNPVUZxeEpKcXhzOHhsT2tOVlNDYkVYdFlRakJrZVVUMFVlcU00UGZt?=
 =?utf-8?B?eUUwUEdKeFBidkNTcjR1NDFsT0JyNjdoQWl5SlQ3SzBvMjZBZExDUkJyS0o1?=
 =?utf-8?B?OTc1N3pqWC9JK01DWitBdnJreWI3UHJlblJpWHNLeGZJYVJGTi9VR3dkb2JO?=
 =?utf-8?B?Y2ZJek00aHlMNjRTS0V2dU9ld0Z5cE0rTTAzQ0FUazM5d1JicEs2YUZqcUxa?=
 =?utf-8?B?R3B6cXd6SFRYRVlmczlvSW9YS3VaVXcwL2dtN3FLRzJtOTQrNGowTzJEUWlr?=
 =?utf-8?B?ZUNFZTdyZ05kRkhLTFBnU1A5bGFkcitmeit2K3E4ZHpOSFFCTGpLcFp6OG1j?=
 =?utf-8?B?UnNSUnVqMlVZQlJiZTRpcGJscFBqRnl2YUtWeVhwa1RMZUdPUTJJUk1wRGVa?=
 =?utf-8?B?emxwL0RMa0p5V1lMYzZkMTVkN25GRGthMExKZWg5eG45SEVrVWJGR25uck9l?=
 =?utf-8?B?SjFxZzRvOTNlR20zRTNrc1o3aDJDNzdhTkxGZGZqdHY1ZjhqZktsYVh6MXUv?=
 =?utf-8?B?REdqei8wYm5jZVlwR0hmenJGQmZuQWdkRWxsS2svblk1S2IxTUVOa0xIdFVm?=
 =?utf-8?B?aFZtRGJ3Y1FXcExndVRFQlhianNsUTlZN2dIemNuaXZMNllDRlp6QzJQYS9a?=
 =?utf-8?B?eDk1YlRURmsvTmtlYzJxMi9zUUR4NDJTcU1WRFRMWVMvUHFMUVVqNGQxejJh?=
 =?utf-8?B?VUhWcHk0N0RjOFU1cWRBdGFxTnB4alROcC9DWlpoUU5QTFRHZnpkTXgvUHpC?=
 =?utf-8?B?QjdTZXJvM0QwUVlCVjdqY2JYYUVRcDVkSjBVc0xQN3I3RTBPWlFSTVNhQW8w?=
 =?utf-8?B?M3J3ZDR4V20vZmdHb0wwc0FOOUZwbDFqVjNSTDRHVDAwM2xvQ0o1T3YvN0Ev?=
 =?utf-8?B?MVB0SGdhdEZEa3ZaQXYyT0h4RituV1phSjhoSkF0Q3AvdHZsUmNKNVlhU1Rk?=
 =?utf-8?B?Y1dhYjE4NGVZSi8zZUxQOFhoNjFvYXk4QXZwaGNnTXYzdXoxeHQ2LzNrYXNx?=
 =?utf-8?B?L09ZRTJKTkU4OVpDS0crWjRGMzRzYnh5T1V5SzQvNDhvY2ZBNThQTnh1c1FT?=
 =?utf-8?B?ZWxGTGJLZnBYcDhDVmM4MVVhZndWNGFVSXhIemwxWk9RWWplK3JxU0Z3UHp1?=
 =?utf-8?B?dG1BYUdvblVZZDR2TkNyZ0tzdVI2UllmSjhYclJ3MUdES0VzVjZoOHA3bThF?=
 =?utf-8?B?UHJya3p2ZHMzTlpwTkFpVk5QMHg3TUdnazJQSjVhSTNOaXU3WXdLVGR2eWZR?=
 =?utf-8?B?ZWh6T29CQ0ljRHZXdWlQOUlKZ1Ntb3ZCSjFFbkdGU3JCd2x5NGtiSC9xaGYx?=
 =?utf-8?B?WEh5d2t6L2psM05TUkF0YTVsczNzV0Jqbzl5ZTRHazBXV0FqM0tUVXVEOUxI?=
 =?utf-8?B?bWZsM2hBUWdNVE56UVQ0Tm5JSzRLbjNnaDMzQTJUaER1TWhtTXdRbW02NE9r?=
 =?utf-8?B?ZGJTcCswS2lBVytqd0hXRG1WS2tDcDlwaUxVNThZR2tiTjZ6RzJucWEyYWlq?=
 =?utf-8?B?VlQ3WkxveHhoNElINjJVdWkxWEJyZGZoaGxlazhwRjlkS0hCWWRsSVczdkpy?=
 =?utf-8?B?ajZVU3FQYnZNaTNhZXpKOFJpV1c3UFRML0pSQjR3bktZZmw3dmJQeWw3N0E0?=
 =?utf-8?B?eWNESnByRXFiUm9jNklEbVpHZVlJcTVsTEpJYnFuQTJST0xiSEl6SnRVbm5i?=
 =?utf-8?B?c3RVUjlicjJpYmhOby9KbkQ1Q1phRVIrT2J4dW1maUpCTEIyTitEeUdvY1gw?=
 =?utf-8?Q?7kUoqQm8kpv8SLwt9MB6hZRW8bJRJ+Fhy/lSntfuuo3WH?=
X-MS-Exchange-AntiSpam-MessageData-1: 9Daej/VBmkUOig==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c316a82-f23e-4110-e537-08da2212e8d3
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2022 14:43:03.9646 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dJBh38N8MNitAJnlUePEhlO2PjS8/WVK1C5VB3xpIWjPbKXbgDBlAUBzW3OdRe1n
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1501
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

Am 19.04.22 um 16:37 schrieb Harry Wentland:
>
>
> On 2022-04-19 10:19, Christian König wrote:
>> We just need to reserve the BO here, no need for using ttm_eu.
>>
>> Signed-off-by: Christian König <christian.koenig@amd.com>
>
> Acked-by: Harry Wentland <harry.wentland@amd.com>

What about the second patch? Who takes care of amdgpu_vkms.c? You guys 
or should I ping Alex?

Thanks,
Christian.

>
> Harry
>
>> ---
>>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 32 ++++++++++---------
>>   1 file changed, 17 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c 
>> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> index 73423b805b54..91e9922b95b3 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>> @@ -7583,9 +7583,6 @@ static int dm_plane_helper_prepare_fb(struct 
>> drm_plane *plane,
>>       struct amdgpu_device *adev;
>>       struct amdgpu_bo *rbo;
>>       struct dm_plane_state *dm_plane_state_new, *dm_plane_state_old;
>> -    struct list_head list;
>> -    struct ttm_validate_buffer tv;
>> -    struct ww_acquire_ctx ticket;
>>       uint32_t domain;
>>       int r;
>>   @@ -7598,18 +7595,19 @@ static int 
>> dm_plane_helper_prepare_fb(struct drm_plane *plane,
>>       obj = new_state->fb->obj[0];
>>       rbo = gem_to_amdgpu_bo(obj);
>>       adev = amdgpu_ttm_adev(rbo->tbo.bdev);
>> -    INIT_LIST_HEAD(&list);
>>   -    tv.bo = &rbo->tbo;
>> -    tv.num_shared = 1;
>> -    list_add(&tv.head, &list);
>> -
>> -    r = ttm_eu_reserve_buffers(&ticket, &list, false, NULL);
>> +    r = amdgpu_bo_reserve(rbo, true);
>>       if (r) {
>>           dev_err(adev->dev, "fail to reserve bo (%d)\n", r);
>>           return r;
>>       }
>>   +    r = dma_resv_reserve_fences(rbo->tbo.base.resv, 1);
>> +    if (r) {
>> +        dev_err(adev->dev, "reserving fence slot failed (%d)\n", r);
>> +        goto error_unlock;
>> +    }
>> +
>>       if (plane->type != DRM_PLANE_TYPE_CURSOR)
>>           domain = amdgpu_display_supported_domains(adev, rbo->flags);
>>       else
>> @@ -7619,19 +7617,16 @@ static int dm_plane_helper_prepare_fb(struct 
>> drm_plane *plane,
>>       if (unlikely(r != 0)) {
>>           if (r != -ERESTARTSYS)
>>               DRM_ERROR("Failed to pin framebuffer with error %d\n", r);
>> -        ttm_eu_backoff_reservation(&ticket, &list);
>> -        return r;
>> +        goto error_unlock;
>>       }
>>         r = amdgpu_ttm_alloc_gart(&rbo->tbo);
>>       if (unlikely(r != 0)) {
>> -        amdgpu_bo_unpin(rbo);
>> -        ttm_eu_backoff_reservation(&ticket, &list);
>>           DRM_ERROR("%p bind failed\n", rbo);
>> -        return r;
>> +        goto error_unpin;
>>       }
>>   -    ttm_eu_backoff_reservation(&ticket, &list);
>> +    amdgpu_bo_unreserve(rbo);
>>         afb->address = amdgpu_bo_gpu_offset(rbo);
>>   @@ -7663,6 +7658,13 @@ static int dm_plane_helper_prepare_fb(struct 
>> drm_plane *plane,
>>       }
>>         return 0;
>> +
>> +error_unpin:
>> +    amdgpu_bo_unpin(rbo);
>> +
>> +error_unlock:
>> +    amdgpu_bo_unreserve(rbo);
>> +    return r;
>>   }
>>     static void dm_plane_helper_cleanup_fb(struct drm_plane *plane,

