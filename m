Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44EB7F5A8D3
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Apr 2026 03:19:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D784510E0F0;
	Tue, 21 Apr 2026 03:19:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lPokuJE2";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012063.outbound.protection.outlook.com [40.107.209.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1ABA10E0F0
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Apr 2026 03:19:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qwj0vbtqizT0zrE/2EZYQnTjkRNPluG3pVkl8ROrdnPnRLaQqGkdfbysP8pUR/olttBoP4a8Ze8mIPWw2Az+gFI1KPneKVKqt5j55yyAwoagGNVGnhNMnbb9RgZF6HcTRqmWqggNcu3VQr9SW9p4HPxtLTDt/zjSqG2RDHnuCvtCC9kwGmQ+cUNkBSUvP8tTznO3qU/9+vtOm9j06Ngv3Lp5eIOm1IYeTr3+xUOK0sSpdhIZroo8VAdjkcrBvJDZVSCsGahBarLBB75HI7ClTH8fXWf1cNj3PW4EI5OgrILokC35NlD352podLomCeUBmNiVxlmpO8PsG/KSPk1UIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VzkHuOaWHtSe0C1m+STdyAOXVVnJyFHeTjbEvuPdfEw=;
 b=KUtO6aURGgSc3WVQ/z1C+pWCWVJ/ovLT0gMcZYdny8PvVoFATIGVgdXVqWqtsG2ygEKMAWt0Pl57uhhw4OtH9kVNtWdZaWKQB4NpO2ynJXc2/59ZmnnJmIv/OVv+ufjuZjIPq9RjDcQTPmJWWxvxYHMTEz5Q2bU58k8bCzLhpqd8lRW/H4ZGxxd38cmzKNQ52XHqsVPYkNvPSJKcuKESxDzRtHnJDHr22kRwDK+dnLwSOOXoshtri1A0ubGAtI8Gu+j7aPQz1szTGl6UIti+vCCKSBfvD96VMqxudsE/6KKzY2bu4TK7SkgTfVseddzJRYkiHYhN+FAPIbP1vCBEmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VzkHuOaWHtSe0C1m+STdyAOXVVnJyFHeTjbEvuPdfEw=;
 b=lPokuJE2IUJx6VBdweriCae8ut8AhdMPlNGtN7sQbCm6gllEflrdxAUJSc/ghR+AKSYaPt/rwhYgWyc9F29rcJTCRqDTsLyELxa8z0ls4Ixo1O+F41H3alUBz0yZPBbxhpNVgvsZ8VB0ZAEp+Yrn3FgD55X7u1O+dgDjShjHWVs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CY8PR12MB7635.namprd12.prod.outlook.com (2603:10b6:930:9e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.12; Tue, 21 Apr
 2026 03:19:46 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::230d:c588:d858:9977]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::230d:c588:d858:9977%6]) with mapi id 15.20.9846.016; Tue, 21 Apr 2026
 03:19:46 +0000
Message-ID: <8fdea885-7ac0-42f0-a166-2fe2c9fe178f@amd.com>
Date: Mon, 20 Apr 2026 23:19:44 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Terminate queues on surprise unplug with
 running processes
To: Mario Limonciello <mario.limonciello@amd.com>,
 Mario Limonciello <superm1@kernel.org>, amd-gfx@lists.freedesktop.org
Cc: Kent Russell <kent.russell@amd.com>, Xiaogang.chen@amd.com
References: <20260112182925.347303-1-mario.limonciello@amd.com>
 <2b4d4476-97a6-42f8-b5cf-5599ac8d0035@kernel.org>
 <60e1e12d-7705-4531-ba15-c956f4d268d4@amd.com>
Content-Language: en-US
From: "Kuehling, Felix" <felix.kuehling@amd.com>
In-Reply-To: <60e1e12d-7705-4531-ba15-c956f4d268d4@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT3PR01CA0133.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:83::10) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|CY8PR12MB7635:EE_
X-MS-Office365-Filtering-Correlation-Id: a503694f-7486-47eb-9648-08de9f54d675
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|11006099003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: /ee0GPvf2ui/kreY86xtXQXci+ScptOWbew8TkuvuR4JDAEya1nIZUM4eeE0lTCHngszYOOI+l7RZjzf7pzWlZBwCaceB+FhkhaRxIrSKBynNPC/W4K+PPDarGlzGxHeHggyrhiNtQOMwYdHU2etBbz5eU5vFde5KNlXejYlydVZ7fag8OJrOnybc8VKuPTny0l5jii3LmbpmhxggWOA5iK/2mlAhU/HOPwzfdOuzo58sbKYq7+WxRMclJCWrZgy2QKgL2cu+gLjTwjAjxkTiH1kKtjSPkCbOZy/Bveey0jYFpyHpmawdS9uDeYy3JDj/8qs4C9M0j4PiGl0s8bdRk6glhBIjx+Zs+0TZPQnt/8RwWjNjJiaN/lBibbf+9Yx/lmsKO2piJJLMEcK6lVbRQzKtxHwkLtoJOw+6+L53pb0cvS9gjbVhHIJOSafe9RbgS9zdjUFkSunwq/NuZjTHV6ob90yE4YhJyVLkd/KOG+bW+51gQn6gWUJ/xbTkzaaUSRbYKdAGmk9FAZI7dQsaTyKIBYfRfKB4oe8M+b17n9PxYFnmj3j0l8MucJhBD1OldPyeQevYQucw85iNsr7ZfLDxX3c+b2y7da5fYhnLpfrVOAxRM6rC8qU3Ug0CiCuHw21ZZq3mDSTlO+q0jXYJHoJGLjogXO5qKTlY7okGEjhLb15uOIyIRYxaNXNJveuymIf6Nl5k62UTJmoP3M2CMYFgLrQ4khhjk1bGICwA60=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(11006099003)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NE1kR1lVS08rYjh1bnQ1cU1JbXBwNlpwM2kyNGl4VFcxSE5oUE4yQ0FLaS9N?=
 =?utf-8?B?TVN2Vy84T3ZFN2t5NEQxaXNIbUJpS1NIYkNIVXQzS3ZLWVFGd0tyNDRxTUIz?=
 =?utf-8?B?YkhYaHBiL2dkVGVsMWl4RkhGZW55amx0ekhyQ1JLQmY0ZVp3c25iNktTSjBt?=
 =?utf-8?B?dVliaERwNG0yeEM2enZQUHJZSGk1QTh3eWdYMzVrQTFkYndYa25DY0wzbkpV?=
 =?utf-8?B?Z3ZsNFhsZkNZZ2ovVytGbE5mekpwTHNzVk1zNEM3d3E1bnJ1NFNyUW04WUJu?=
 =?utf-8?B?b2V0dGY4NnFxTWhBNmhENUo0akQzWWZrL1UxcUFDYTUvNUVnMUQ5M0RwZktF?=
 =?utf-8?B?NWMvV0wxVlVDUC9VTzAyNzBDUmNWL0hZZXN0Wm1ySXM4TmNkdU9iYUJ5MHRS?=
 =?utf-8?B?QlFndzJUYlg3TEswaDNEdzV4L0VHbndCQzBNZ2lLZDRLUzBSaVozcndxTW9x?=
 =?utf-8?B?bG0vUG5pZVM4azJpNXJ1SXc3bDA5RnBta2NnaFNiSWJaRi9CcklTekw3cXFF?=
 =?utf-8?B?emw2YTNkRDVwN0ZMN0pidjF1dmxTWENrMEVOMjdVMTdhTUV2WkdOZE9xa0w5?=
 =?utf-8?B?OVd3UVhiZWNKQU5tWDNsRzJLak9TS1RjQ2dSUi9mTXJXWHI2cFU3NjkzQlZl?=
 =?utf-8?B?MUk0Y3RJT0VjaFlBSjdveTFxdkR5VUJwRkNWdXB0Tk5YUFpVUWpHbm5wUzlY?=
 =?utf-8?B?YlVsODRjRzIvUWd0Q3lVZGcrTkRGZlpLMGFFbDdYM0w4anZudW5RNjFBWUJY?=
 =?utf-8?B?UnhjUmNZWkF5bzlQK2ZpYjRpNG8wOGx6NWtCQTNCWS9ueTlnVWxrbFhnRXJC?=
 =?utf-8?B?R2ZqOERqSUVidXNpRmJpMzRJT2d5ZE42c1c5QVJJYk9JRkQrVGlValQ3RWxq?=
 =?utf-8?B?UUJpRTVrd05ZQUlEb2sxTG5Vc2F1b2FPcFdzaGR6T1BhUjBVYW8wQjFpNHBn?=
 =?utf-8?B?c1JvNGNTcW4zSHhHdFZBdGdBOGo1cERJMldydGgxRTVvRE9YQWlZeW9TZ0Jh?=
 =?utf-8?B?NjhYZDZpR2czajdKLzhTaldRaDJlN3hGVm9sd1M3VVFVNFpXYlNLWWtVenph?=
 =?utf-8?B?SWNMclpSYlpsTkRWMzNJRjdCZVg4bklvMjllNmJRYlJLQ1oweUhMQ3p3clhi?=
 =?utf-8?B?TC8ybDlGc3N6eEI5a00xK2xlS2kzcGtFbnB3YkZDMTVJSUp1Q3V5VEJvYVVZ?=
 =?utf-8?B?OTdScFMwUCtsWm1rTjBqSm01WGdYcGZzSzhvaWgxb0Rob0xIZmFWL0FUems3?=
 =?utf-8?B?SU1JVnFObnpuQWtURFU3WXpkRnc0ZmJqVkNVNDgrNmxRQmwyNXJCZEVMWExG?=
 =?utf-8?B?V0lyY0ZnWlhkWlM1UW05czJoMUs0YStsSnlLb0NUUEdmekVUQnJMNkdoVTRH?=
 =?utf-8?B?V0RxK3JtWENNWFltelFzNytIMlhIMGxMUUhveXgzLzZKSFViV2JxcTk2blZF?=
 =?utf-8?B?ZGxBNGtNbi8rcWhYdWlkaVVReGpjLzFBai9ya0FoYWlINzVSQlVJcUJ5dGNk?=
 =?utf-8?B?YjhJdGZnbDNhV1pMczBhUFV1WVI4Qlh5N04yZjJqeGxZdW5hZnE4RW1UQ2ZB?=
 =?utf-8?B?cENhZ0c3dkFHUVdJeVRaTVlqYmhFMitWWHh6U2FFcUU4ZFhEcnlqNDkycUU3?=
 =?utf-8?B?b3MrWkNkM3lYVHBmYnR4OWZlQ2hPTWl3cnExMVdoSjdCVHFtV1J2L2dRc1Y3?=
 =?utf-8?B?c0hCaVdadG9rZ0Joc25TS3N4WFQvZSs1a0NkV2xBUWxETi80T0NFOEJCcWxM?=
 =?utf-8?B?ZFlmZEZmbzFhemtxbnYyTWhDUkZ6cmt0cXRtQVExeEZabm9MaFBqNnZ2QnE1?=
 =?utf-8?B?YURHV2NrUlk4Tm1vRzlJYlduY3BGQjlnVFdFT3NWVklrQk9LYVkzVWJuVmRR?=
 =?utf-8?B?NjgwbTdBMERtZE5meEZBaENIV1lPZlJEazRIQ01BQllVYjd0UmlObjRza1BN?=
 =?utf-8?B?WlZrZER0Y2dadWloeUtja1dDT3BSS3huUThzUTJqdjVLOEJUODJDWEw2cER1?=
 =?utf-8?B?bU9NU2ZEWXQ0Z1N1eXNLekVOZ0hQWFhnR2k3QzJlcytidWhRaEtHV1BNMEpP?=
 =?utf-8?B?ek5zTkU2Tm9ZYVhnR3BpOHFYc0pWKzc2YkhKK2d6SGJxSGRNeFdaSTQxeXFD?=
 =?utf-8?B?eVdZMi9Wc2Z1YXVXSFNiM29rWUlRZEppbERNajJHYVlpRGlBTzdYcnRNRW0w?=
 =?utf-8?B?amwzUnMyK05XL3VoN2VBM3V4WVJudnBQeFJPNEQ3aVJJODl4bGY5ZHR5c0du?=
 =?utf-8?B?S1pNcjVwbGovU3k3eXVpbUJSekpJaWJUNDVtSzgyeHBFTmY4MGl6T25BQXNv?=
 =?utf-8?B?VlJtYkd3cXdRbEZuYmwrZUFIVyt0cjU4QVJ4cDBhOWdRQk1LOUZaZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a503694f-7486-47eb-9648-08de9f54d675
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 03:19:46.2756 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GnJxjfNvIULp12Hv/HO3tzmZDqEJe7jz7HrmHruEBhpsA8LXrvJwScHmkDBnWEQ2QgQxRLUl/qSZXFISzENReQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7635
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

On 2026-04-20 17:25, Mario Limonciello wrote:
>
>
> On 3/7/26 06:49, Mario Limonciello wrote:
>>
>>
>> On 1/12/26 12:29 PM, Mario Limonciello wrote:
>>> When a surprise unplug occurs while a process has active KFD queues,
>>> userspace never gets a chance to call kfd_ioctl_destroy_queue() to
>>> properly clean them up. This leads to a WARN_ON in uninitialize()
>>> complaining about active_queue_count or processes_count being non-zero.
>>>
>>> The issue is that during surprise unplug:
>>> 1. amdgpu_device_fini_hw() checks drm_dev_is_unplugged()
>>> 2. It calls amdgpu_amdkfd_device_fini_sw()
>>> 3. This leads to kfd_cleanup_nodes() -> device_queue_manager_uninit()
>>> 4. uninitialize() has: WARN_ON(dqm->active_queue_count > 0 ||
>>>     dqm->processes_count > 0)
>>>
>>> The warning triggers because the queues were never destroyed - 
>>> userspace
>>> had no opportunity to clean them up before the device disappeared.
>>>
>>> Fix this by checking for device unplug in kfd_cleanup_nodes() and
>>> calling process_termination for each affected process before
>>> uninitializing the DQM. This mirrors what happens during normal process
>>> shutdown (kfd_process_notifier_release_internal), ensuring queues are
>>> properly cleaned up even during surprise removal.
>>>
>>> Cc: Felix Kuehling <Felix.Kuehling@amd.com>
>>> Cc: Kent Russell <kent.russell@amd.com>
>>> Cc: Xiaogang.chen@amd.com
>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>
>> Ping?
> Ping?

Hi Mario,

Sorry for not responding. I think one of the reasons is that the people 
you CC'ed may not know how hot-unplug is even supposed to work with KFD. 
I think most of what the process_termination function does is 
unnecessary because the GPU is being unplugged anyway. But without it 
you would leak the MQDs. I think that's the only good reason to go 
through this. One the other hand, could this be done later when the 
process actually terminates?

I'm also worried that we have pdd->dev pointers that will probably be 
dangling after unplug. So maybe this is only the tip of the iceberg and 
we should really be cleaning up all the process-device data structures 
on unplug. Then we'd also need to make sure that all the code that loops 
over p->pdds is able to handle NULL pointers gracefully.

Regards,
   Felix


>>
>>> ---
>>>   drivers/gpu/drm/amd/amdkfd/kfd_device.c | 32 ++++++++++++++++++++++++
>>>   1 file changed, 32 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/ 
>>> drm/amd/amdkfd/kfd_device.c
>>> index e9cfb80bd436..7727b66e6afb 100644
>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>> @@ -664,6 +664,38 @@ static void kfd_cleanup_nodes(struct kfd_dev 
>>> *kfd, unsigned int num_nodes)
>>>       flush_workqueue(kfd->ih_wq);
>>>       destroy_workqueue(kfd->ih_wq);
>>> +    /*
>>> +     * For surprise unplugs with running processes, we need to 
>>> clean up
>>> +     * queues before uninitializing the DQM to avoid WARN in 
>>> uninitialize.
>>> +     * This handles the case where userspace can't destroy queues 
>>> normally.
>>> +     */
>>> +    if (drm_dev_is_unplugged(adev_to_drm(kfd->adev))) {
>>> +        struct kfd_process *p;
>>> +        unsigned int temp;
>>> +        int idx;
>>> +
>>> +        idx = srcu_read_lock(&kfd_processes_srcu);
>>> +        hash_for_each_rcu(kfd_processes_table, temp, p, 
>>> kfd_processes) {
>>> +            int j;
>>> +
>>> +            for (j = 0; j < p->n_pdds; j++) {
>>> +                struct kfd_process_device *pdd = p->pdds[j];
>>> +
>>> +                if (pdd->dev->kfd != kfd)
>>> +                    continue;
>>> +
>>> +                dev_info(kfd_device,
>>> +                     "Terminating queues for process %d on 
>>> unplugged device\n",
>>> +                     p->lead_thread->pid);
>>> +
>>> + pdd->dev->dqm->ops.process_termination(pdd->dev->dqm,
>>> +                                       &pdd->qpd);
>>> +                pdd->already_dequeued = true;
>>> +            }
>>> +        }
>>> +        srcu_read_unlock(&kfd_processes_srcu, idx);
>>> +    }
>>> +
>>>       for (i = 0; i < num_nodes; i++) {
>>>           knode = kfd->nodes[i];
>>>           device_queue_manager_uninit(knode->dqm);
>>
>>
>
