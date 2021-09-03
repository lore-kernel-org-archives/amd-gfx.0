Return-Path: <SRS0=/nsf=NZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE74DC433EF
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Sep 2021 15:26:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97B9261107
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Sep 2021 15:26:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 97B9261107
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C4196E8A2;
	Fri,  3 Sep 2021 15:26:54 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2080.outbound.protection.outlook.com [40.107.94.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 338FD6E8A2
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Sep 2021 15:26:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CMKTiP0H3xd9hTnV0AeubyJgNJc7dgZYFaBHzquIGi8yyEbEE/aeXKmiaFMDlY6mGDriQmubzUBP0SHmy0sAJ7OT4fzzOCzmgut1E+E1iZBVsOCVgS+CeEVlXBDNkc5AbVNbfm4wdLWk0K0R3s1varqoZdW5FeRzPFr68Y4TBEXyPGLfOt/+um4FFbE11Jx200Iq5c3wwkMti3Y5OpleHe8CxaJ3N6FiDP3BRtbGDjc7W8mcB/11DJsM5SCJCcAI7ey1wIzO5r7OxLBfeuOpHH16hBK4GYiOJx2pCqCVvDUuhCk0wWt39mDx8almatUmxi8AvqTGkAotLWkcFRJ1VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=mFhfJvrea3EP+4A7LKAwdndFRmcR0pw2rs4L6nP3MWs=;
 b=jyeO/R3bSDfDbt9fllE0kbALmUDlqwbJMOWDypgKtYVT9HzWLlS69WpStGfH1g8Osh9toAsI72A5oOyAxREQ7RRBgIKNPqALAqMdDaPbtBbkgaXOXmeqUYcxGyqApSJSZD7PGckcxzGaEG3FLiMnEUGvjjsG6UoIdvBZHJ1/b2fP/poBxtjRtTqmg3hxJmylbINP49aEMXbBSdaRjCADyklwdySBRQNFbnQGW0+CGt6A3vVKMf/Zx0JGQoA8jFf5uP3qiTK3i5GOX1bCYWMGbBA2nqz/C9b9YiRJcqWm5aRV5lhlS2G43H/aunFLvMi+7QcrYd6AGEFyCul/GUOK3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mFhfJvrea3EP+4A7LKAwdndFRmcR0pw2rs4L6nP3MWs=;
 b=gLZs0dtfA3UILt4tQzkdwB8++IuUK7L1Iz6TuLAfx1jY4x7v79s4HQ6GwR9FaPDALYffM6JKwASLN98KzIuF0fsyv/jfVvLpepgLPBa4dmcXqZsG0eFWwyKnYDdTOWC+w6hMY3nTDImQS5hchPnkrQkFjDsNCl1IaP3ZN6OlDdg=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by DM8PR12MB5415.namprd12.prod.outlook.com (2603:10b6:8:25::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4478.17; Fri, 3 Sep 2021 15:26:51 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::9c06:d113:293:f09b]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::9c06:d113:293:f09b%8]) with mapi id 15.20.4478.022; Fri, 3 Sep 2021
 15:26:51 +0000
Subject: Re: [PATCH 2/2] drm/amdgpu: cleanup debugfs for amdgpu rings
To: "Das, Nirmoy" <nirmoy.das@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Christian.Koenig@amd.com
References: <20210902114459.3866-1-nirmoy.das@amd.com>
 <20210902114459.3866-2-nirmoy.das@amd.com>
 <e3a13fd6-f3f3-7980-14d6-b93948053535@amd.com>
 <29a155c4-085a-442c-08f7-50ea56f831d6@amd.com>
From: "Sharma, Shashank" <shashank.sharma@amd.com>
Message-ID: <ba709b1d-5eeb-e748-811f-fbea728ab0b9@amd.com>
Date: Fri, 3 Sep 2021 20:56:41 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <29a155c4-085a-442c-08f7-50ea56f831d6@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MAXPR0101CA0024.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:c::34) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
Received: from [192.168.68.104] (106.51.20.251) by
 MAXPR0101CA0024.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:c::34) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19 via Frontend
 Transport; Fri, 3 Sep 2021 15:26:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c7c572a0-f059-4bb5-b755-08d96eef40e1
X-MS-TrafficTypeDiagnostic: DM8PR12MB5415:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM8PR12MB54150721395EABB368FDBCBEF2CF9@DM8PR12MB5415.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qpCAfaC0GRE/CbCV1pxN2YT/ZaPcB3BJ0xcuTKYnIZrOoaS82LxGjnljf9f3kjgkH/t2kKanJTL6SGpZaVRZhIZyNba3B1YARB6znF5Se1KCTaHsfEtb6UPW2ttGD8h7162fuScs92dI+KVdS2xa0tKKdHdfgPmUtSfi7Esebu2XXMhA7sVu3iuAAXKNMiolJ+wQ+eDJg+3aauKLLDivWYfI8pl/5AmDBCPp0F11ljqssFzzA9DCPbexQwYwYrxAk84hBBfVIp86AkNRiAQ+w6u3AweVKhtKnrAJ428QVw7Ixdjiq6mVGxbwO3rtj2rIQfWIjjE2edk59ehB7Xz9vZDs81NMTMoxhfr8rq9wLnRpCjpIT5WWCwD7knF2CY3roh8WmVwyi7nZzuEGsGwQhb62tQd/pB7ZR3JplnsUSFA69c+jRsL6LR8YuK/OyovzjfGHuO23jV95Hm82ngXfpqaAhYmK8jvnVv0AMD3oCxIsVvoi3bXkhFLDOyuvtgku+KXdd7sdKO/MxJXTCs0ixzB+YvUrYjsF6SaJ9HG2EluqI/ksqsZLXchLFU9O55ve8sz+Ur0ssasUOAi82D2vDTxWuQL5H7KP/hU0UKKQ0nc7XKEzeWxdjoEyv0rJpsBIGUxLoPzDYmwiKIbkrTu9BoZQLHqQADTOSNlN9uQueATjvdzKaugODpRW+XU/uyqfNjRu4Yb5HoCuATmH/7RLyfr1vg0NQDKjkIE5dOGxtio/MPHJWl7f9vMfyr55cUsx
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5040.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(136003)(366004)(39860400002)(346002)(8936002)(956004)(86362001)(38100700002)(2616005)(36756003)(478600001)(5660300002)(316002)(16576012)(8676002)(1006002)(53546011)(6666004)(2906002)(55236004)(186003)(66476007)(31696002)(31686004)(26005)(4326008)(83380400001)(66556008)(6486002)(66946007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bXh2UU5yYjE3bmN2U1R4Zm5EOUp1d1g3bnBDbndKcW9hTDRxK3ZEVVc2Tld5?=
 =?utf-8?B?MGRwRVpWR2htSzdIRXc4dlVXYzNaL1UxUDBweWlaT1NQYjhLNWRJclpQVUVo?=
 =?utf-8?B?U2FWOGQvSC9hWGprdmdoYWo0SlIvZm1QQnZ1Q0hhaE9PYjNRRlIxQlA3WURE?=
 =?utf-8?B?VWM0ajZLMUw0RDE0bEQ2WXdBZEpBUlNKT3lMTHlEaTBkSGFKSDV6SG5DelRX?=
 =?utf-8?B?dXdmcW80ejJlYWV5ZTRVVjNrblFxc3d0VHA4Z2IwME9wTW53ZG9nN0NhZnNq?=
 =?utf-8?B?WXJyRmk3ekNoOUhQQjVGNHNQMVNXeDR3T1k4SVdJOGZsaVgxSU5lelBaYVUx?=
 =?utf-8?B?V1RxdzIrMldSSXAwckIrUWhmTGtnT1RJVWxyY3RWQU9mVHIwcG1ybWRNMEhM?=
 =?utf-8?B?Y0pLekhuTmJJbzlnZVBDOHl6ZWtLcVlzeVYyWER6d1h3RHZNVkhpSFpRVHBi?=
 =?utf-8?B?QnNtZllXVkwxVkxnbUFsU2VuaC9ONk41OHF1MC9jL25xNTk3VDZzQ3NwSjJK?=
 =?utf-8?B?SjNzVzZoeUFRQzNoRVlUcDVYMlROQXFGbmhXREQyWktrMGRZTC8xd2xSa2tN?=
 =?utf-8?B?UkltQU5ZU0d1aXppZEFjMmR1eGFyb0dvTmdwSlg2N01Yb3BrYllyTkhySnVr?=
 =?utf-8?B?NDBhSFd4NXF1dG1IelI0b1BHd3VEbnlCbCtOQ0V2Z2tBK0FDOGVrOG5jSVhR?=
 =?utf-8?B?ZTRuUS9pRzNOV2tZa29JWGM0ZHpOeTZiT3hMYUFWbzNzZmE5NFhXZlNFd2ZH?=
 =?utf-8?B?YzA1WXVPVTU5QTc4aWZPTm9hRzE4QW9wenJ1d3JuMDA3MStnZW0wNlBDaGZm?=
 =?utf-8?B?dHlaZDJnTk4wNzdqcUd3WCtpVnAxcXAvd3pNUk1EVjhiZzJSWXArNnNxSFlv?=
 =?utf-8?B?Y3NZQXluK09aN2FWaVM1R0hJN0cxVzl3NktlejZvYVNWNi9qSFhQeWhkN0ZU?=
 =?utf-8?B?ajNzemcwckNJZTBvNTUzMHFISkQ3cVVTTEUvRStxZ00vNXlGYXpoUnpvTkhN?=
 =?utf-8?B?dlVwUm82Qk9uMkJUSVQ5azgxZlo5ekl6cmdxNkl4WWlrRUxsanlBZ0pHZlFq?=
 =?utf-8?B?N3V2SVF0aUViY1FlVitBVTM3eGNmYXRpSUYxeDBjbTFjQlRJU3UxL3FOY1A5?=
 =?utf-8?B?bWZkSkpEOGJ4VWpPNDl2RXlvb1o3cHRoTE00aHZ4R3oyU0E3aXBCVVNvalBO?=
 =?utf-8?B?aHZNVFZXYnR2QmhiTkdxdkhlOGJFSTVOUlNtZGZDQU1ZdkhRQlJxbGJVb3VB?=
 =?utf-8?B?WVR3Nkdqdkx0SzdwejJZYzlVaW1iVk1uYmR4TnJWUVAxVENPRXcydTBmaFdo?=
 =?utf-8?B?dE0rTUpkWkZTanRPZVFUMC9NSndOYm5kZ0JLTGVQRjE4azZnbW9QdThaTTRS?=
 =?utf-8?B?TkRaeTNxbmg0bS9OaVN4T0lWamVrVWtudUFCVU1zUS81UEdldkJFTVlYRWNm?=
 =?utf-8?B?dTBVVFlsaWg3Mm9xalZ6UDRkVDdwUGtkbGFRdjBlK2lFSllJUE5ycHVybHJQ?=
 =?utf-8?B?VkQ2aEtTNGRtNE51TWhncUVoajRPWHo2ZU5mblY3bERid0VoK0J1eTdXbE5l?=
 =?utf-8?B?MVc2emU2Q2dOc0lRQkVzMGkvSnUvMkVvUTNpQkhxTU9VcmNaVDVPSkZrRnJn?=
 =?utf-8?B?MS9lUkRVN093V2hkMmQrenp4SnprOTBqdUlHNGdaSGFVanlOQXpxaUpPUWNU?=
 =?utf-8?B?YUIzQ09pOVQySTRJdlFIR3hzTXNSYjVKTGpXbk5ZTHdldUQ2Z0VkU01NSnZX?=
 =?utf-8?Q?M+Ns08nvc1PUF2ZDqnpIYHybjrB+szpXn9QXCWS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7c572a0-f059-4bb5-b755-08d96eef40e1
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2021 15:26:51.5902 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IFXUpG1womSe1l8uvVnGaixzlHLwPxQD2vKjpqOo7cJesQAIGHh8aokcGfJauWo0PNgNdYc8w+a1c4K9TZw/Fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5415
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



On 9/3/2021 1:39 PM, Das, Nirmoy wrote:
> 
> On 9/3/2021 8:36 AM, Sharma, Shashank wrote:
>>
>>
>> On 9/2/2021 5:14 PM, Nirmoy Das wrote:
>>> Use debugfs_create_file_size API for creating ring debugfs
>>> file, also cleanup surrounding code.
>>>
>>> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |  4 +---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c    | 16 +++++-----------
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h    |  8 +-------
>>>   3 files changed, 7 insertions(+), 21 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>> index 077f9baf74fe..dee56ab19a8f 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>> @@ -1734,9 +1734,7 @@ int amdgpu_debugfs_init(struct amdgpu_device 
>>> *adev)
>>>           if (!ring)
>>>               continue;
>>>   -        if (amdgpu_debugfs_ring_init(adev, ring)) {
>>> -            DRM_ERROR("Failed to register debugfs file for rings !\n");
>>> -        }
>>> +        amdgpu_debugfs_ring_init(adev, ring);
>>>       }
>>>         amdgpu_ras_debugfs_create_all(adev);
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>>> index f40753e1a60d..968521d80514 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
>>> @@ -415,26 +415,20 @@ static const struct file_operations 
>>> amdgpu_debugfs_ring_fops = {
>>>     #endif
>>>   -int amdgpu_debugfs_ring_init(struct amdgpu_device *adev,
>>> +void amdgpu_debugfs_ring_init(struct amdgpu_device *adev,
>>>                    struct amdgpu_ring *ring)
>>>   {
>>>   #if defined(CONFIG_DEBUG_FS)
>>>       struct drm_minor *minor = adev_to_drm(adev)->primary;
>>> -    struct dentry *ent, *root = minor->debugfs_root;
>>> +    struct dentry *root = minor->debugfs_root;
>>>       char name[32];
>>>         sprintf(name, "amdgpu_ring_%s", ring->name);
>>>   -    ent = debugfs_create_file(name,
>>> -                  S_IFREG | S_IRUGO, root,
>>> -                  ring, &amdgpu_debugfs_ring_fops);
>>> -    if (IS_ERR(ent))
>>> -        return -ENOMEM;
>>
>> Why are we doing this ? Why to make it void from int ?
> 
> 
> We tend to ignore debugfs return values as those are not serious errors. 
> This to sync with rest of our
> 
> debugfs calls.
> 
> 
> Regards,
> 
> Nirmoy
> 


I am not suere if completely removing the provision of return value is a 
good way of doing it, we can always ignore it at the caller side, isn't 
it ?

- Shashank

>>
>> - Shashank
>>
>>
>>> -
>>> -    i_size_write(ent->d_inode, ring->ring_size + 12);
>>> -    ring->ent = ent;
>>> +    debugfs_create_file_size(name, S_IFREG | S_IRUGO, root, ring,
>>> +                 &amdgpu_debugfs_ring_fops,
>>> +                 ring->ring_size + 12);
>>>   #endif
>>> -    return 0;
>>>   }
>>>     /**
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>>> index 88d80eb3fea1..c29fbce0a5b4 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
>>> @@ -253,10 +253,6 @@ struct amdgpu_ring {
>>>       bool            has_compute_vm_bug;
>>>       bool            no_scheduler;
>>>       int            hw_prio;
>>> -
>>> -#if defined(CONFIG_DEBUG_FS)
>>> -    struct dentry *ent;
>>> -#endif
>>>   };
>>>     #define amdgpu_ring_parse_cs(r, p, ib) ((r)->funcs->parse_cs((p), 
>>> (ib)))
>>> @@ -356,8 +352,6 @@ static inline void 
>>> amdgpu_ring_write_multiple(struct amdgpu_ring *ring,
>>>     int amdgpu_ring_test_helper(struct amdgpu_ring *ring);
>>>   -int amdgpu_debugfs_ring_init(struct amdgpu_device *adev,
>>> +void amdgpu_debugfs_ring_init(struct amdgpu_device *adev,
>>>                    struct amdgpu_ring *ring);
>>> -void amdgpu_debugfs_ring_fini(struct amdgpu_ring *ring);
>>> -
>>>   #endif
>>>
