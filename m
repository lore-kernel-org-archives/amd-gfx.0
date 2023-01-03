Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52093C3DA7D
	for <amd-gfx@archiver.kernel.org>; Tue,  3 Jan 2023 09:37:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BBEA10E3BF;
	Tue,  3 Jan 2023 09:37:43 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2056.outbound.protection.outlook.com [40.107.93.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8FBCB10E3BF
 for <amd-gfx@lists.freedesktop.org>; Tue,  3 Jan 2023 09:37:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kHoxblE6ke6vMqsc2J3FZuDxxtdD9q2SqyHrsw/9tmRtEjRGkhZQW+dXbzYF/FJgJ1Cb4BltORnvbJcv/k9lgsiyauQyQBWnL62jda5KncJfXU9UkkGKZQG22o0I/WF0GACBQnrLikteGM6KFjNmuk+i3NlwluJmEUtdAAe0r5xmVH3wDw+dEy/GTkMJPRFCHsUPdsjgMGwDcXASPmeTcuEqRgM3RjPAZKzkSGc3bqo+MXOstHEIMMcfdFshaftnRK3+wXe9iLCmLBcoshK0uwJmECvLZjE44xGVRktHJDYEZWP6FXdlZhgC+fIbOcv+yRXLX8irVwFqmLiMf59W2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TvlRJ+1XjlDUlmaXkk3e2ufN09talESESNIB/LS37So=;
 b=JvuszeDneENelvo/BasOxHAfG1xqVh7OsWnuy+wASkjx9O4v6nj8QtzPcVNLqRDzV7BI1+ns/vVKqGX+pdvObF+hIs+3a2dqUNGwCscHiurmfheG2+uiJDmSa5g7ApdF4k6hs2X5AxunKzo2pBbLnpFJBvlx5opurl9XB5gnP/t9rLZR4NjzlpDFmA8fpNO0uv0x5hrBh+fZ/KIemdCiQVa2hEB5k5NCxlOD/sGw4nh2w+8Wp0ue+XiEFuRsG7IhX48ziTTsXX1pyhUPf7+6pfVfNoIevV8boexLjDnGJ4+HVB+5AaB8kgiIKH934/JeTEUEfDgh9FIdW1veY6BFDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TvlRJ+1XjlDUlmaXkk3e2ufN09talESESNIB/LS37So=;
 b=33W1Ir3uLEmNUBQ9fnJVRkggvMJ0MrH2a1XgzfYcqKCOZusqb+hBr02Dj2vVCOqwiToxnqmIbj6Kqw4Mbj83M+LOV3QeboAfqO8Y2csSgy7agLPyGGJHYxYoXM80NKFXrisgIg3u4VWDf8//09qnMS46UeAlcN/BtKZ+fud53xM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by IA1PR12MB8408.namprd12.prod.outlook.com (2603:10b6:208:3db::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Tue, 3 Jan
 2023 09:37:39 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::ae3c:5792:8b56:6367]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::ae3c:5792:8b56:6367%5]) with mapi id 15.20.5944.019; Tue, 3 Jan 2023
 09:37:39 +0000
Message-ID: <51dae816-a809-0b35-03de-c05498b1e696@amd.com>
Date: Tue, 3 Jan 2023 10:37:28 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [RFC 4/7] drm/amdgpu: Allocate doorbell slot for user queue
Content-Language: en-US
To: Alex Deucher <alexdeucher@gmail.com>
References: <20221223193655.1972-1-shashank.sharma@amd.com>
 <20221223193655.1972-5-shashank.sharma@amd.com>
 <CADnq5_MLC5++t1GDsAXwKAXDuqTDk-RJHr5BCL0PKSfCOG4woQ@mail.gmail.com>
From: Shashank Sharma <shashank.sharma@amd.com>
In-Reply-To: <CADnq5_MLC5++t1GDsAXwKAXDuqTDk-RJHr5BCL0PKSfCOG4woQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0124.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::18) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|IA1PR12MB8408:EE_
X-MS-Office365-Filtering-Correlation-Id: 3edada90-6b37-49ce-c830-08daed6e2772
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BzG98u/2VyoUlg4X7tAtG3Q/RMY4rxFESFAKD1gnvGsYQUIRAQ5raxu8pqkGTsD1PqS3CKVddoP0VpihQqoWq7kbGcZ20aZ4dIP2Z7w/9TtlMP5hrbEzSbKVlFUifSt/089rHIs3MqJSKL9ObS9jIEozUpf3s80klKrD7LRhAh405w4hypCUSk5wu46aA6U86HS6SClYavt0vCmD4Sf6HwMvRgThII0+GV/I7qWBROS6zCWalhAZCX41Od7t7HHMhykm4E7DA/GdW4+CywP9artBzoXhBblWp+t/XjBUUky62Gmvaf3meagFqvMiwrhGdd8WIEdflhB75OtSwtYWYypVbeNurQPdLjFR+rFm8/hRtWPmYHjgKk45/mpmxBHu68W7Kp013NRYNIbIjNT5M8i3EnqnaW1mdgWOPZQqyQLgDHTBtjvQH52AoLGHmIM+Vq/QpmfMiZ8n52rP4ZI/TdUmf6Vf7+Sbk6lA7JEpIoBZG6aNCQSWXvdlNwQyMdIfGRZvDGZazks1W/05/sDlQVHsDnOL23iyYQg1W4d58ZDbKsKZD405T9Uw2KsauVYokY2rX0jiFBVRayzMKshOWOsG2k7SH8HkNteortShX3CW/csiuj/GI3X+qPjhhU6u0QXPqiCz3XfB/ayPy/LJKGzJw+thEod0r+dvD9sxNA5nZl1bJVKWMS3hcXwhFhrso2sWAUHRstvN2Wd6w2+4jdZ/iiCnu9dts7KxelxzUyKyzdl3vlxGrWiqVQK8TocP
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(396003)(136003)(376002)(366004)(39860400002)(451199015)(38100700002)(31696002)(86362001)(66556008)(66946007)(66476007)(8676002)(6916009)(41300700001)(4326008)(54906003)(316002)(6506007)(2906002)(8936002)(5660300002)(2616005)(44832011)(83380400001)(478600001)(6512007)(53546011)(6486002)(26005)(186003)(6666004)(31686004)(36756003)(22166006)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VmNWeXhZK0E5dXdsSXJIb2RKalU3YkRQVktkSDlQYWZ5UDNPRmdFeERyOTFj?=
 =?utf-8?B?MjVndGRrRlZiNVR3OXhuVGZEM3ZkekxzSU1nQTduMGZlUUJJdmozZTQ1K1p6?=
 =?utf-8?B?VVd3eWhVQW1aM013NGJpVWRsNkJYa2JHZUtyWmtQWGJGRS9RTkJNZ09SRmVX?=
 =?utf-8?B?NnR3WXZ1bkgxdUt3WUZQZnM1bnNvSTNJcWllSTVrU2FwVUx1K3AyaEJQZzFj?=
 =?utf-8?B?ZVFOVFc2ckFFMElYUHIvTkUweVM5MzJXSkFjNDhKamlqRmZPNmhNRnNxbHBq?=
 =?utf-8?B?ZXlCb3JVdVhHRGF0TFBrZVlVTk5XaklrK1o0bkI1VFBycEFLK0J3dE5lcVM5?=
 =?utf-8?B?bzhScmpNK1RBMGpFZGwvbkZKamdiclArOTdwSnFCVWVwZVNNOVBybDkySjBK?=
 =?utf-8?B?MzBaL2hBZVVIck93Rk5ZcXEzc0tzS2M1QkZ1L1JIK2ExZE52K1p5WjZBOVRm?=
 =?utf-8?B?ek1xWVMvY095R1lQWVVyM2h3TkVGdVg1aFpvdnZDU0tadWc5bEdwblJ3L2pr?=
 =?utf-8?B?MzNjQ3FjdFNzWVBMTEM4Y05HWVpZUGxhYjRFMDZsUmJFWWJqWXZtRDhtSUZT?=
 =?utf-8?B?b3d2ZmtIN2NUSWxOS3FpclQ1dFlRRXFzOWQrNzJHOHNSRDBpdjc5N21XSUdz?=
 =?utf-8?B?L0I5alAwaXdTNWs4Y1FJUTRwQVBqdjY2bUZoMlozZGFlQ1V1dDVsMzN4akor?=
 =?utf-8?B?QW5rbllPN1NQVGhWVTlXejVVTjVDcTM1N1lGMlRkVGtNdGtzRENTYWh6QkJn?=
 =?utf-8?B?cHVtRXV3SUliNDJZUEhuL2NGU21LZ1ZLd0dpT3FFSnZVYmhKUi95YUI1VGRR?=
 =?utf-8?B?VkJzQ3lJcGw3UXg1RFFKRkhURGpZQjM4T2lhTURCMVgxMWFtTG1kUFJNSUpk?=
 =?utf-8?B?Um1lN2pKR2dkeHVPQ3p6M0RZY09sa21qOUNIMWNDbUdJbjJieUlUS05qalBv?=
 =?utf-8?B?UVg5eEgvc2J5YjBJWExNZE9qOVIrTi9HUHpidG9Fc0tsUmxzZDRpTUdId3Vy?=
 =?utf-8?B?T3p4QTU1YlBoY3hjU0ovR3JzMGprcytGamVLNUZCV2tyZmFxVW52NWZXeksy?=
 =?utf-8?B?WERoT3pEVDR0R3lyK013dU55b1dwd2pVV2hlZGxHZFNLd0l6VS9YejM3QjdF?=
 =?utf-8?B?Q1ZiRDB4VkFkV2NhVk5KcDlzTXg2MmdCSU8rOTZsaVd5NFpmUXo2ZWZ2SWdV?=
 =?utf-8?B?anVoMFljOTlQemtLd0ltRkJFKzRhcjM4WDFISC8vejI4WGxKeEVNelpXOUpo?=
 =?utf-8?B?Y1JVWUtxcXQwczhuK3hNVzFSUUxlK2xPVlpISEZWelNpaTBrSllMbEJ1M09G?=
 =?utf-8?B?RmhSdUUxNFdyU3VHYWFmcnJoUExMeVZ3VCt2eCs2NHg1bEVsWjZGWGZ2ZlVO?=
 =?utf-8?B?bGJKV0FmLzVmOW01VGVRUzdZdTBPeHg1ZEFZZEdXd3JVWFYxMTNDUUk5dzhp?=
 =?utf-8?B?QmFIYjVzNUJWSXhHRG8rRFV2V2RGd2RLN0F3S1hVMEdDSVJncjl0M1VsZFhX?=
 =?utf-8?B?bE9MN0lDVDZyYklCckp5bGRmVVhwbUkvKzBJeVNyZDB1azNTWUxXMFNTMzRY?=
 =?utf-8?B?alExOXNHdHNVS2QwZ3FXTThYcGV4K05iamtmVVhhZE11V3EzTm56blg4aXBj?=
 =?utf-8?B?eEZoanJQL3dIRWRFTzlIdGhQMTlUUGFOdk5qTXhJc05ydHN2cmc0emRxSVRo?=
 =?utf-8?B?dVltY2xEU0ZVTlBrUm93aGJDMTU4bXRzN3gvVGRTR0pwZGVDcDk1YUVPTU1l?=
 =?utf-8?B?QkZNQjRKTnhtTWtOWU1zMnJCK255WFBZVUM1YlJtUndRY2JsMWlNUnl1SEFM?=
 =?utf-8?B?RXc5SzJSSXl6OS9WQmY5S2FNNEcvR2FCT1d6NUtFZGdCaU40N3dyc2UwV0hQ?=
 =?utf-8?B?QmdnL3oxKzZ6dzM4aG1rWUhhb2tVRXJaenVVdXZTRllDdDJaRStsZ3pIMStu?=
 =?utf-8?B?Yi9VNlJZR3VSZzZXeW0zRDE2bTRuWjZOR0Y5RmdFbDdycnl6K25EKzRjbkQ5?=
 =?utf-8?B?L2VBNmRneDNnK0VuSlBSdGN5UlMvM2pod2N0bFVnZnprOHRqMlhkYzdhLzdq?=
 =?utf-8?B?OWdITHdTMG5ROWlQZmhCbThQbkNBSFllK1ZOUUJQTnZoM3BWVGcvUkptYkhi?=
 =?utf-8?Q?Zo7/uTnelFvZQDqmoCPRp5eiq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3edada90-6b37-49ce-c830-08daed6e2772
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2023 09:37:39.3177 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NavtVDcor+5/64RPxMxlnD5YC6HEk1gj4rv4Ib6fH8+ZIS+wU3BD4pSxB50VzrEJgaRhq+7ZjINb9Ej//k3+oA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8408
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
Cc: Alex Deucher <alexander.deucher@amd.com>, arvind.yadav@amd.com,
 Christian Koenig <christian.koenig@amd.com>, amd-gfx@lists.freedesktop.org,
 arunpravin.paneerselvam@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 29/12/2022 18:50, Alex Deucher wrote:
> On Fri, Dec 23, 2022 at 2:37 PM Shashank Sharma <shashank.sharma@amd.com> wrote:
>> This patch allocates a doorbell slot in the bar, for the usermode queue.
>> We are using the unique queue-id to get this slot from MES.
> We should manage the doorbell BAR just like VRAM.  I had a set of
> patches to convert doorbell memory to GEM objects.  The user should be
> able to allocate doorbell memory via the GEM IOCTL just like VRAM or
> GTT.  Then when the user calls the USERQ IOCTL, we can just look up
> the GEM object from the handle and then calculate the doorbell offset
> based on the offset of the GEM object from the start of the BAR.
>
> Alex

Noted,

- Shashank

>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Cc: Christian Koenig <christian.koenig@amd.com>
>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c | 28 +++++++++++++++++++
>>   1 file changed, 28 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>> index a91cc304cb9e..b566ce4cb7f0 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userqueue.c
>> @@ -50,6 +50,25 @@ amdgpu_userqueue_remove_index(struct amdgpu_device *adev, struct amdgpu_usermode
>>       ida_simple_remove(&uqg->ida, queue->queue_id);
>>   }
>>
>> +static int
>> +amdgpu_userqueue_get_doorbell(struct amdgpu_device *adev,
>> +                    struct amdgpu_usermode_queue *queue)
>> +{
>> +    int r;
>> +    unsigned int doorbell_index;
>> +
>> +    r = amdgpu_mes_alloc_process_doorbells(adev, &doorbell_index);
>> +       if (r < 0) {
>> +        DRM_ERROR("Failed to allocate doorbell for user queue\n");
>> +        return r;
>> +    }
>> +
>> +    /* We are using qnique queue-id to get doorbell here */
>> +    queue->doorbell_index = amdgpu_mes_get_doorbell_dw_offset_in_bar(adev,
>> +                           doorbell_index, queue->queue_id);
>> +    return 0;
>> +}
>> +
>>   static void
>>   amdgpu_userqueue_setup_mqd(struct amdgpu_device *adev, struct amdgpu_usermode_queue *queue)
>>   {
>> @@ -257,12 +276,21 @@ int amdgpu_userqueue_create(struct amdgpu_device *adev, struct drm_file *filp,
>>           goto free_queue;
>>       }
>>
>> +    r = amdgpu_userqueue_get_doorbell(adev, queue);
>> +    if (r) {
>> +        DRM_ERROR("Failed to create doorbell for queue\n");
>> +        goto free_mqd;
>> +    }
>> +
>>       ctx->userq = queue;
>>       args->out.q_id = queue->queue_id;
>>       args->out.flags = 0;
>>       mutex_unlock(&adev->userq.userq_mutex);
>>       return 0;
>>
>> +free_mqd:
>> +    amdgpu_userqueue_destroy_mqd(queue);
>> +
>>   free_queue:
>>       amdgpu_userqueue_remove_index(adev, queue);
>>       mutex_unlock(&adev->userq.userq_mutex);
>> --
>> 2.34.1
>>
