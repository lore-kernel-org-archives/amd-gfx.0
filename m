Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB759C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 10 May 2022 15:26:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6482F10E57D;
	Tue, 10 May 2022 15:26:15 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2067.outbound.protection.outlook.com [40.107.93.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FB1210E57D
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 May 2022 15:26:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ON//p3Qrkm9bEXSkJJ/Ap4SW1CtVNVyd27odSB/aykhjpPALU9JEZLZKo4bdGjow4pffzgTFv+sHnoaeRSxSD9kKDFJREfBWbqjLKruUCIbUP3DslzmukjeHDXk7zvI014Vi+TqUw6OdGc1wD6iw4aYgzMj5mq+btOvFovMTXsxxQp8aKQITbWqrtB4L+y4JOKqzNvymp2MGP/fkARvc0fErCrt/lhQ+7ZOnq0MqX2N1iak+eAHr09x7+AtEEY0UbrDewx9Cpj85XRIONnuOCuaNXeA0JQlZAc/PM2NMQ5WUqEvVgLsefRjaz+SGao0d4WMFf8Ki528cneD4N3ljqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CY3MIlyB5uHYkCGstFviZEWdA69OtFQu/uqZ4eLaGJ4=;
 b=fuxQx+TLahs7EmVOhgo0DpXnXqnNhpU3P23jbu5qDIj1SbZp4JwCx7bEqTXNLOXys0UDGeHBdRXLEXJlyPx705Kczy72WO16n75MiZywYcWU35BfB7QYH0mNi/XfQGtRb6GbZHkA/x5KGzlZN2Hp4UxPCpkt4vVc8HDmzS+WPRPm9e2eWQCDggVaMxZUSlvXAzYFY7ytEvR2jlXjzp5N9+j7tULiilhC3Rrqz9GWYQxd8c8OU+FGdxLr8rJ7aPgoZF/L0AVMR9pItp1oyvD5bD+0haGVRN5CCJQ1T7cW/VPsULWEyYQDrnq5yLwQdLr8fwgKYHvzDz29/2/7etyhlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CY3MIlyB5uHYkCGstFviZEWdA69OtFQu/uqZ4eLaGJ4=;
 b=A/omdqbUT6VnslHT8Rh47N4nRxSs57F0CG5/+flumLAF3g+U2eZclS1Ly5UJ4XmoPvf1rtzr9+RC3vS71CNfjHw8P64n1suvERK3wiACTEbBdGIBgvMNLuHc1vFPijwdqfrS1KQYews7W7Eivsp+c2+SNmBUOxuRKf1vQ/mdPpk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by BN8PR12MB3586.namprd12.prod.outlook.com (2603:10b6:408:47::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Tue, 10 May
 2022 15:26:11 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::fdba:2c6c:b9ab:38f]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::fdba:2c6c:b9ab:38f%4]) with mapi id 15.20.5227.023; Tue, 10 May 2022
 15:26:11 +0000
Message-ID: <91bb776c-9898-51c5-dfdf-d514ac7a9305@amd.com>
Date: Tue, 10 May 2022 17:26:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/2] drm/amdgpu: fix start calculation in
 amdgpu_vram_mgr_new
Content-Language: en-US
To: Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20220510113649.879821-1-christian.koenig@amd.com>
 <90f223dd-d6bc-3f98-a620-e61df3af6f5b@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <90f223dd-d6bc-3f98-a620-e61df3af6f5b@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS8PR04CA0070.eurprd04.prod.outlook.com
 (2603:10a6:20b:313::15) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 10ae1009-28ce-413c-7e15-08da329969bc
X-MS-TrafficTypeDiagnostic: BN8PR12MB3586:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB3586AC6E8D5A8AD9CA5B46AB83C99@BN8PR12MB3586.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e1X0hX5v2wgscue5RsqxP7BKfO+QmhvitxZbtoN9XIdxEhxaXM89H3Gq/SBHtLPeMfHDNyYATnfo8jhLrEZA/A4dqSFrktqu6laWGXyWs+pw29Q96dEv2l0IDdCFt5/7K7Y3myg+9v0mV8oRCJuQyy6jYxHlD8pD2n4L/B1/t+fMluCR8gJ/PdUJHfQOeO9gKrCpSp1IWt3uNaqfZthoiV5Nfj6dwlxSuxbxAiB0F7iHWnfvsoxF26FBGCgM12p3Axr6S99Wjn7kY2ACbzMbOxQJuM0aZou3xc3ylrLTtmgo3vVC00YwpdjxMwLMvXdMFSzSHHfGP26saqlJQGDlgjR9z0slPRR1qEA+ljxCs17Gk0RnfuxQMSJAE6hFNaAJNKXu16zSBIF6rs+syiAoDl8egZ3X1em6MKZMkGG6Egk8bJa0Tb6lso5cx+h7UZ30t5XxgE+OupksUsxfq5ZQ52uovYFLlysuBSdTWxsvqGAWJjZyb2rAHQL0xoaBrILE8NhxknRzEjI23W6sa0qlVv+aB9YBIRPHNQW/s9OFhK2KhnRwM93/lx2tS8tDfnK7K7442ViaX1WrV6kM1Z5Azzv0W+PrXLccftrDPhr31uEF1tYVsowtXpGpV35u6g+LEiC54ped7s+0BPqBk0NAkfN5wY3xIhFLXxGT2bPSr5vZavDN6gKpHe6tX8xfXDrjRyS5KzqI/CwBzer5aCZ5HNAQwotloSNneRe8s0BFfVU0eNVKzS2q+ra11sKklyXY
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(66574015)(508600001)(6512007)(6486002)(6666004)(316002)(86362001)(6506007)(186003)(2906002)(5660300002)(83380400001)(36756003)(2616005)(66476007)(8676002)(66946007)(66556008)(38100700002)(31686004)(8936002)(110136005)(31696002)(53546011)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VytKRUhqQlQyaVM4ZlF6NGlwMXdDaGJpMTQwMmR5TU0ydHhtVy9vMmc4K0N3?=
 =?utf-8?B?SWxEYkFjTFVCR2tsYkVzNlpUenpaNmJiY212anNoaWxtcEgrQnIxOS91SzBN?=
 =?utf-8?B?NjZLbHhhTnYrdSt3VVdRYWlZVk01NU5oNENtczRpZEhoMmZwY2VPcTgvcDhQ?=
 =?utf-8?B?QjBHbHpZT3FpN1h1UGhOcW00Zm91eTJRRjJVbmNYdjdGYTlHY3V4eXlhcGJr?=
 =?utf-8?B?MW4wUTFGakZOdDF4aCt4WHZCZW5sWk1JakhaUW5ibUMvTXUrMlFZcGFSUS9p?=
 =?utf-8?B?bjNmRU1jWUhSMFlRaHExVkpBUzQwR004c0pKaXFrZ2dsVVEvakwzR3MzNU50?=
 =?utf-8?B?ekNvcXVkTWFJZmdWMFZ1UXpWM1gvZmJCNFMzTUhocDdJZXlINzBqYzU1bWxZ?=
 =?utf-8?B?S2RzekxQb3VDVXlDSTYxODJKcnRaREJOdlZzVGRjN3dCS1J0YWlEekwvbmNa?=
 =?utf-8?B?ZlUvOEswMlNRWkxLQitNbSswSFRjWll5VVlvaHJrYUFrbWszREdhYUU0Zk9u?=
 =?utf-8?B?Y3ZuOG5ON0Z2TDJYZ0JZdzZJMisrbUd2dEttNCs0U0FFNHVySXBYdFFwU3dE?=
 =?utf-8?B?aXA4MXJsTm05Mk9TblV6VW1nbFJtSGdkN3AxRnJUN2ordWRKU2ZwS3NDdGxZ?=
 =?utf-8?B?WFdtc2lkU0RmdUR4M2o4Q0tZbFdDbVZmc2x4K1pwcythUGQ2bkFQWnRZbnZl?=
 =?utf-8?B?MUJLMHd2YnRCOE1FZ1FISjQ2aSs1OU5FT3E2Q3gzVHBoaGZoZFROcEhWK21q?=
 =?utf-8?B?cjhxN1cxNmY5ZWZldFQxVkJoYnB6N25XTFJ1VVFLQ0dzSkVZVUNZanJIcjg3?=
 =?utf-8?B?TmtQM1JsQit2MFl3Z0JVTnZsNlVCemF0WlJZcG5yc1krM1V4b0pWYjF4M3pr?=
 =?utf-8?B?NVVSTlM4cU1wKzdzWUhUSzFiYktlNTI1R3pLSHhUSHY3Qm9HdkoyaGE1RVVB?=
 =?utf-8?B?QnpuQndVVEhXQndYOS9OQndkTXBoeXdTNnl4WGFRL1Zoa3hYQ01xR1VQL2pZ?=
 =?utf-8?B?ZzNMTEUwczNndjMvZmkwZTZQMyt4ZUZyWHkyVlZLQ005MHhEdnljcVlZejdF?=
 =?utf-8?B?SlNtSEJLdGJGeU5leUhMVTVaZEIyUGxEZTRaM3ViU0xuQUxvSTFPNU9SNmtO?=
 =?utf-8?B?WnBNN3BjMnduTU00MUF5UXBndnRTMmFZYk9WSFdNU1JIM2JnVGRCM0xoQ2h3?=
 =?utf-8?B?ZWxLS3Q3TmlUOGlXL2t0VlU2ZTByeVEydHpsVG5CVW1ENFJHMGw2QUNMRzFV?=
 =?utf-8?B?cHZIbXlmeUF3NjJMK3c0em1NMTVQcWJtb3RrZWgrT2NoSDg3eVNkMVo3UDdE?=
 =?utf-8?B?UnVLdjBtWCs1S1J5OTJvR3JFeG1oWUxFb1RFaHQ0NkFBQWZsZ2hCRjZJZkd0?=
 =?utf-8?B?VmtBclVHSUxFK01sNkgvMkVDSkFjUW9DL0hjOEFiWEVBa2dhTkd0SjRUVk9S?=
 =?utf-8?B?QVVCM2RhTkZKOUlwT3JwZm9GcFlpOGJVL01tN0RvODd4OUFxclNaTEU5dnhi?=
 =?utf-8?B?eWNQZVhRNUN4SEZ2R2hJV3JYdU5wTG5ZVCt1a0pISmFTdjVPZ083TC9QNEhY?=
 =?utf-8?B?NEhBd0dSRDZmZW91K3VtUFBMMmZtUCtCWFdDUHBXZGUyeDhpWXIvMm4vemRZ?=
 =?utf-8?B?VzVFVHpMMk5HNXMxOTFTNlhxNmhOV1lWeXh5UzhPOG9JZVhxSy9pdE1KaG9S?=
 =?utf-8?B?ODNZNFhJcXV5RS9vSVVvUUxZOVdiUXJESHdlY2ducElsN0M4dlN0TkxFbE1B?=
 =?utf-8?B?ZjA3QVFLeDJOSW1sc2JBVTA1ZThXM1JtWks5N2NERHJ1T3ZCQ2piV2o2WFli?=
 =?utf-8?B?Nmc0Tzd3NEswUk8vSldOWTR6WnJUbDd5ODVIUjBLYU5MS2xXeUNUZkFtRlcv?=
 =?utf-8?B?bjIwWUFkTXlxWXR5TGtOVFFzbnhFcGJkdTNiUm5pU1ZVT3NIL2VGSy9MTlpj?=
 =?utf-8?B?Zi84V3FpbnE1czVQQlBwcWpPRmRHVGRRNityMGVKN1JEc21RL1dDN0VYUkhq?=
 =?utf-8?B?NEk3NXl0bzV5NnVEQ3pGRVg3ZTdpUGNvMll0bkptRGM0OTdNUDZFc3o0S2p6?=
 =?utf-8?B?WDNUSnkwZDdVSHprZEM5RjQyUTR5bkxqVVRUaFNhQUdQREMwa0paUDJ4WHJT?=
 =?utf-8?B?ekpyZ1hmNzBkZmlMdytYeC94cXIvdjlHSDJqZElQK28xSkQ1ZWJJdkROSGRZ?=
 =?utf-8?B?Q3Zhclo3NzhaR0h2TkVsd0NZWCsxNllYTWNwcWl5OXRKWDZ4U0ZJNWE5VkxO?=
 =?utf-8?B?QUhoV3plKzc4Rnk4NG9lWVBQNlhuUU16NHpnTXI1Ti9jUEw1VEpKTGRKWnBs?=
 =?utf-8?B?cGlmdmMrdHp4OHJyeVdLQkZXTkY5cThRME9lM0xNbjNQTUR1YVNYaHg3UERT?=
 =?utf-8?Q?AqMBjDLf0gnYbjtvqzd5Oyol/SFwU8OwMBa5aZZUc4ACv?=
X-MS-Exchange-AntiSpam-MessageData-1: qDcGEu6QaQXZtQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10ae1009-28ce-413c-7e15-08da329969bc
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2022 15:26:11.4660 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sogMw92oWlPxcwHtWwDrao6KJIPLBpI9Y7UF39371j+E3ZcfvGtgs6w/GhJwzWML
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3586
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

Am 10.05.22 um 17:20 schrieb Arunpravin Paneer Selvam:
> Hi Christian,
>
> On 5/10/2022 5:06 PM, Christian König wrote:
>> We still need to calculate a virtual start address for the resource to
>> aid checking of it is visible or not.
>>
>> Signed-off-by: Christian König <christian.koenig@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 22 +++++++++++++-------
>>   1 file changed, 14 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
>> index 49e4092f447f..51d9d3a4456c 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
>> @@ -496,16 +496,22 @@ static int amdgpu_vram_mgr_new(struct 
>> ttm_resource_manager *man,
>>               list_splice_tail(trim_list, &vres->blocks);
>>       }
>>   -    list_for_each_entry(block, &vres->blocks, link)
>> -        vis_usage += amdgpu_vram_mgr_vis_size(adev, block);
>> +    vres->base.start = 0;
>> +    list_for_each_entry(block, &vres->blocks, link) {
>> +        unsigned long start;
>>   -    block = amdgpu_vram_mgr_first_block(&vres->blocks);
>> -    if (!block) {
>> -        r = -EINVAL;
>> -        goto error_fini;
>> -    }
>> +        start = amdgpu_vram_mgr_block_start(block) +
>> +            amdgpu_vram_mgr_block_size(block);
>> +        start >>= PAGE_SHIFT;
>>   -    vres->base.start = amdgpu_vram_mgr_block_start(block) >> 
>> PAGE_SHIFT;
>> +        if (start > vres->base.num_pages)
>> +            start -= vres->base.num_pages;
> I think this works for continuous blocks of addresses, but for a non 
> continuous blocks allocated at different
> locations and linked together using list, this might fetch an invalid 
> address. I will check this patch on my
> setup and inform you.

It indeed does fetch an invalid address and that is perfectly expected 
behavior.

See the resource->start value for non-contiguous allocations is just the 
maximum allocated address.

This makes it possible to easily check if a buffer is inside the CPU 
accessible VRAM window or not.

As I said we should probably get rid of that, but for now it's necessary.

Regards,
Christian.

>
> Regards,
> Arun
>> +        else
>> +            start = 0;
>> +        vres->base.start = max(vres->base.start, start);
>> +
>> +        vis_usage += amdgpu_vram_mgr_vis_size(adev, block);
>> +    }
>>         if (amdgpu_is_vram_mgr_blocks_contiguous(&vres->blocks))
>>           vres->base.placement |= TTM_PL_FLAG_CONTIGUOUS;
>

