Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53197FA1FC9
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Apr 2026 15:53:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C7BEB10EA66;
	Wed, 22 Apr 2026 15:53:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BUC4B4G8";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010071.outbound.protection.outlook.com [52.101.61.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFA8F10EE87
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Apr 2026 15:53:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tt5yH2byDL/33Twh6z0XQ1BcVOxIH8c17SwXToGVntjrPEYaxnm/5O16lwIOOiSexLk2KGs+tcZPklghlFVTi4V6s7t97/3TBTbXAmVAUBIi/nynEdQ3ZOdC01EHxHc0Desoc+mB/NeXsTamyooTTkl9XIoRg6nZYtmGe6gUiRfggEcwwM1HhJRHU2KxVqqtMQ8zf9KM+pkleiPI20fcWBCZaW/8WoxWlfd8qOUntaQM+XLqnGiZCiIusc7tc/qV9V3Z/jjOeEm1RErL0yPYU5HwXAkISlaEGjroyGaW6ZFiUtrTh6EKQLDiFhtZLaePqPvaS8SfQOW1xCP9uVy6XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CoJ5UV6OnYQlquMLQcpBLw2DA/l2vMNhKmbH4KNw0iY=;
 b=GMG1j23x52EnpXc0JMXhbOMqQJx6p9VrFGXdNThlwaylBuJU4D/H4H9q2jTYJYvPQnzushJ+lzhgceW9lHZh7C+m3TDcoi42Ph7ni4xLJcTHjxLrbeWUyfy5v7uIDOtDo4VEYRlh19uXGqL7wSl/d69V8/4Cmr79rcvbMFTAxhqgpZWi+WjiQdWbN03ZOAognd2yz6GapwvPXRq62n8VzYgaTsWraUlT6Au5S9iUGJ0fc8Aw8A0Cb5khH+i0BTJqDtwjzdMfCrivf+aGGRqEPKlxpv7lgdCX+s0/Kkur+I6IlwA4dzuQhQHEbkdmTdWiRZLjqyPMNKsNWirWM4iebA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CoJ5UV6OnYQlquMLQcpBLw2DA/l2vMNhKmbH4KNw0iY=;
 b=BUC4B4G8nfT5ulMAF7ZgbRkdJ6rDAOoj3jtqC2DKfWVNFZW9KcYr7Iobz61GOim3pO6+5SiEYwNF6a3/HQ1DJak2YmKKV9CIj0I37UlPF0VWjkvca+aYnPLEuVKVGetErJi65dKajW1Cez7IOl2IojcW1UUXr1MAIpgYAdJm0N4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4401.namprd12.prod.outlook.com (2603:10b6:5:2a9::15)
 by IA0PPF4D923B935.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bcd) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Wed, 22 Apr
 2026 15:53:36 +0000
Received: from DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::795e:4056:1c5f:6b33]) by DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::795e:4056:1c5f:6b33%5]) with mapi id 15.20.9846.019; Wed, 22 Apr 2026
 15:53:35 +0000
Message-ID: <fbfaf548-0c34-4c09-9674-8802224f9349@amd.com>
Date: Wed, 22 Apr 2026 10:53:33 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Terminate queues on surprise unplug with
 running processes
To: "Kuehling, Felix" <felix.kuehling@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Mario Limonciello <superm1@kernel.org>, amd-gfx@lists.freedesktop.org
Cc: Kent Russell <kent.russell@amd.com>
References: <20260112182925.347303-1-mario.limonciello@amd.com>
 <2b4d4476-97a6-42f8-b5cf-5599ac8d0035@kernel.org>
 <60e1e12d-7705-4531-ba15-c956f4d268d4@amd.com>
 <5fc35475-e7a2-483e-84d8-1de7226e1e59@amd.com>
 <43f46559-fb74-4a34-9cd6-16de02b4147b@amd.com>
Content-Language: en-US
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <43f46559-fb74-4a34-9cd6-16de02b4147b@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0360.namprd03.prod.outlook.com
 (2603:10b6:610:11a::11) To DM6PR12MB4401.namprd12.prod.outlook.com
 (2603:10b6:5:2a9::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4401:EE_|IA0PPF4D923B935:EE_
X-MS-Office365-Filtering-Correlation-Id: 2656d11f-f4b5-43e4-e10c-08dea0874fd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|22082099003|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info: PYrq6UmkakEiSUM78lUv1qY5TRn+CszDXvz2if0X3qnWZVVFxnwJ9B6vf//nj44g0LJ1QGjt3cLVMiUnK+LB4t5GAe7m7339O9biwsAE5A5+E6TEpKb5DYtHJdFWYQ/ISLPCG9PTeYyVsMLte8N9tDdQQYuUhv4shfcy/JKRJWn/boqDtAvcgyBG7P08ZKXhhA31Wd0iuskU0rXdWX5HwUmgZBD7+BIjC8y+6TnSTRGdiU+S5mYZnak7ufuSx+xcev/JaqOWKtwjjmExRzfhmPAU96EvZocFrD0/QBQZX1JDbKicNryCn9zbjorfotVYpMYiK1suPS5pENGkZDmXKAufZC09ZVXQMRBNCJhix0Kt4sCIXTt6WfhSQN/MiiiZyXipIewXfP+QAfDsmWgYLQgqKI+vo5Szf5Ci7l3HuipwDq62uZ8V3mfMqfvmGd4A+IwwvWrIC4qsxJ6zZp1+DHwloPb9zNc5xdg6unw+fwMWy3DsyL40w6QugQxM/wihNa6QeF7PhwKf1NaNXaRdQST8f6Ca718iAWerAK63IvsZWafx3GsHsd5VVl2pWsmFwAiEpRbhDzsIbvnc86u1auQt4Aizub6Dn7/Znp7+1KUVFBvv0mT6xOgIYN/hbNxBnOezL110MVyvDrKQOtW8Hz0Pmfs8SAdo8tiJT1U8PSPuoDcAxXEXgjrHYimdRTD12oo8Z94Km0NkhnrMo+Mol4ceeMN3Q4+tNRIK2/w2BRk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4401.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SjJTWTUrUjJsNjQ4d09HN0d6QW5lMjNwQ1pQT1BvdnBHdkRkOEp0MDl1VVpi?=
 =?utf-8?B?OVpCejAzQUhMNkYxT1FxTk51YVEwendrQ3FGeXpoS3FzVUZ1QmVhQXM3eXZB?=
 =?utf-8?B?V0pjVm83M3VDUWloQ3B5Q1JoOG9DS0MyNWFUS3FYN3kvTmhLNkdHbHQvUklp?=
 =?utf-8?B?Q21mc0NlOWZRMjNJZXZsY0pBV2JuUzd6RkMvR0pMazJXTjlrbzJTcVpWUFoz?=
 =?utf-8?B?L3Rva3BNL201akF5TEtPc2labUNydGwwdHFILytmSERILzdKU3llK1J6ZERa?=
 =?utf-8?B?T0xQdzd2SGNDbmFsZG12OW1hRUxLckE5SGNnNlFicTc4cjFIVy9wUFhHVjZa?=
 =?utf-8?B?TUFxdFV0aUZkM3Z4UC96bDFKQUdEb24vK3BWYVhnaG5qRE9WTDRSUjl5MEhX?=
 =?utf-8?B?MGtIZlNQU1lUc3NreHB2MVRaTkpWRVY2R09vcnl6WFQwd0ZxVlNrRm0yZlRO?=
 =?utf-8?B?aFBlV2RYQU4vWDhETWZHbEQ5bFJsYm5iZlJtY1lYSC92M2dGaEJaNmQxUFBZ?=
 =?utf-8?B?d002TFpabUpDeEtHMXZ5RVEyY1liNjMxenM2bDRVRVdocjdJTmhLalJXNW9x?=
 =?utf-8?B?enBCNC93ZGljNDZqYzYyQ0pZNmFHWlQ2TVRBY2VmYkJlMXpjZzBkT3FOZnNr?=
 =?utf-8?B?cHBDRFpPd0xKWWxQajluTXQ5bnh2aVhZZCtzQlFxVzFXWWRwVFpVY0RwSWti?=
 =?utf-8?B?bHUxSjZobUVzTm52UklFeXd2RHVTTEVQODNVcEdyUkRrekMwNFI1SDZHUk5h?=
 =?utf-8?B?NXJlclkrSlRqOUlsdDRkeXhvUFF1Ny9KNnZIcTBXeGdac3dKQ2tJYXU0QmVI?=
 =?utf-8?B?ZTJzRlBCRHNVYUpxWDJzRlhLUlBjdVRqLzdwaGpaNlBxRTZBSGNHWDFwSmds?=
 =?utf-8?B?Vno0RlQwK0VidW9keTZFeWREdEhTRTEvak9BVFBTL0dObTNhVmhHLy85U2tJ?=
 =?utf-8?B?cng3cmFtTmhWeTl4bEI2QWhDOHJzbnNOVXBkb1VZQklRdk1yREhMczJZWDNB?=
 =?utf-8?B?NlArd0xYUU55TTlMKzZTVFBwWWRXejB1WFVvNnN5ZGFjV05qZjE2ay91bVM5?=
 =?utf-8?B?dS9hbEpFMnZNR3FFcDFPZGJISDdmTXJFVi8wUTRsYWJER0xXVkwyaXlYNko1?=
 =?utf-8?B?ZzJZYzhlakRDbTVXZnZtcmw1MjF6bHlVODNXRzZKenlpL2dFMjJFSklOR0RJ?=
 =?utf-8?B?VWZMc0tHZnYzalpPOSszN0RqWUxiNEpOR3oyNDZyZVZCalhhSnVBdGs2a1A1?=
 =?utf-8?B?R1V5SVU4aklBdnI5cGcrZFJtdURqOTF2emt5aG9sYzFBRHZrcEgwNDVEc29w?=
 =?utf-8?B?Z3cva0pyYThnV1FpTXc1bW1PWTJIV3oyY2U0dWhQSytQYmpYbjdXcjF2ZmZx?=
 =?utf-8?B?Ynh5dTZzZ05yQkJzSjVFNEtOVXBiZXZqL3RTNHY1bUcrSDdtQWtwUCt2c2x6?=
 =?utf-8?B?UklvWVlnRjNvb0pKL1MvQVZKRFA5Z2U4SGZYOHNZREp3cVlaTU5JVzlZNzZu?=
 =?utf-8?B?QWxxOE1saDhtQy9VTldHQ2x5M0tBMzVhZFVmN2NCcVhaNEQwc29USC9pUVhI?=
 =?utf-8?B?Z2NGaGF3aVM2dlp6Mk95bm9LOTNpek45SkhQeWVsMUxaaUVjMG5Xc3ZkSEFU?=
 =?utf-8?B?eCthMmVOODd3elhpd0VvenZFc1VIZFQ0anNSdDFBbGI4NmdaMW9VMWFtRTBM?=
 =?utf-8?B?MGlVcVpwUE5SS25xU1FybVIxa2JiNUoyYjBIMFNJOElvYjlJdVgva05wY0hy?=
 =?utf-8?B?Y2dmMU1jRzF4MmNOdGtLTWt5MWJjWTN6YzN4SS9aT3kyR01hSGxwandyOWR1?=
 =?utf-8?B?Y2g0VHVvZXFNUkc2MlJOZnBlSEcwYVBiUEYvWExackF0bmorajFWTEROZ2Zz?=
 =?utf-8?B?TUhpNG5YYVR1NDZzdzE4Z0hFMDNrUFMveUxFcTlwNnA1TGVZZ3ZrTjBnZXJ2?=
 =?utf-8?B?N25jZS9kRW1BRmFDQmhkaUdkUGVGWENyNFAwUFJIbnFpTG5yakYyTFVLQmM5?=
 =?utf-8?B?OHJNNHJvS2xZN0MxeE1VZkZIdWRuU1QwZU5RNjBsdHVJZ0pSOGxpUzJLNEpy?=
 =?utf-8?B?QlZ6UkRVdzVZTjl4UStFcG1IVFJZZGlSMUlwWkZNTytVNzkyMVd3ZHMvNXFW?=
 =?utf-8?B?b2Z3N21TR2d0WVA4Sko1OWdQaVhyN1dLYmJWRGhNNVpTK09pQVZhTVBKVVlL?=
 =?utf-8?B?SzlSMDRYRXdrS2E1TEFVUnFVL1JKM00rR3k3YytacjA4V2pvZmlhWW9jOWhk?=
 =?utf-8?B?N3hwcVhDUVZQK2NnRnB4bW5Jd1JLeWhJZjB2cFUvWExjUVhXcW9uZDNwc3Ix?=
 =?utf-8?Q?m2xTXwwCFvMvpMri+7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2656d11f-f4b5-43e4-e10c-08dea0874fd4
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4401.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 15:53:35.5307 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UdtyafCeet6+9GHm9hVUFUfhgwRbGcIFMO25YxmXy4AXbg/DRlkKNMLHMF0Mgfu+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF4D923B935
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


On 4/21/2026 8:56 PM, Kuehling, Felix wrote:
>
> On 2026-04-21 11:00, Chen, Xiaogang wrote:
>>
>> On 4/20/2026 4:25 PM, Mario Limonciello wrote:
>>>
>>>
>>> On 3/7/26 06:49, Mario Limonciello wrote:
>>>>
>>>>
>>>> On 1/12/26 12:29 PM, Mario Limonciello wrote:
>>>>> When a surprise unplug occurs while a process has active KFD queues,
>>>>> userspace never gets a chance to call kfd_ioctl_destroy_queue() to
>>>>> properly clean them up. This leads to a WARN_ON in uninitialize()
>>>>> complaining about active_queue_count or processes_count being 
>>>>> non-zero.
>>>>>
>> During hot-unplug driver sends SIGBUS signal to all processes who are 
>> using the unplugged device. It is expected that affected processes 
>> will clean their workloads when get this signal.
>>
>> When a device got removed physically all sources from it will be 
>> removed. It is unnecessary(in theory) to clean them up. I am not 
>> surprised to see some software warnings due to hardware got 
>> physically removed since it is unexpected behavior at run time.
>>
>> I think what we need worry about is if there is memory leak. Driver 
>> also waits when an affected device is idle(by 
>> kgd2kfd_check_device_idle(adev)) by checking/waiting if there is 
>> process still using it. If there is no process using the being 
>> removed device the processes should have been terminated by same 
>> process termination logic from driver.
>
> The problem is, that a lot of the process termination stuff happens in 
> a worker thread. It can happen after the hot-unplug is already done. 
> That would lead to the cleanup worker accessing pointers to device 
> structures that are no longer there (or used by something else).
>
> We'd need to ensure proper synchronization so that the process cleanup 
> completes before the device unplug frees the device structures.

How about at kgd2kfd_device_exit before doing any device clean up 
check/waiting there is no any kfd process run on this 
device(kgd2kfd_check_device_idle)?

Regards

Xiaogang

>
> Regards,
>   Felix
>
>
>
>>
>> Regards
>>
>> Xiaogang
>>
>>>>> The issue is that during surprise unplug:
>>>>> 1. amdgpu_device_fini_hw() checks drm_dev_is_unplugged()
>>>>> 2. It calls amdgpu_amdkfd_device_fini_sw()
>>>>> 3. This leads to kfd_cleanup_nodes() -> device_queue_manager_uninit()
>>>>> 4. uninitialize() has: WARN_ON(dqm->active_queue_count > 0 ||
>>>>>     dqm->processes_count > 0)
>>>>>
>>>>> The warning triggers because the queues were never destroyed - 
>>>>> userspace
>>>>> had no opportunity to clean them up before the device disappeared.
>>>>>
>>>>> Fix this by checking for device unplug in kfd_cleanup_nodes() and
>>>>> calling process_termination for each affected process before
>>>>> uninitializing the DQM. This mirrors what happens during normal 
>>>>> process
>>>>> shutdown (kfd_process_notifier_release_internal), ensuring queues are
>>>>> properly cleaned up even during surprise removal.
>>>>>
>>>>> Cc: Felix Kuehling <Felix.Kuehling@amd.com>
>>>>> Cc: Kent Russell <kent.russell@amd.com>
>>>>> Cc: Xiaogang.chen@amd.com
>>>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>>>
>>>> Ping?
>>> Ping?
>>>>
>>>>> ---
>>>>>   drivers/gpu/drm/amd/amdkfd/kfd_device.c | 32 
>>>>> ++++++++++++++++++++++++
>>>>>   1 file changed, 32 insertions(+)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c 
>>>>> b/drivers/gpu/ drm/amd/amdkfd/kfd_device.c
>>>>> index e9cfb80bd436..7727b66e6afb 100644
>>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>>>> @@ -664,6 +664,38 @@ static void kfd_cleanup_nodes(struct kfd_dev 
>>>>> *kfd, unsigned int num_nodes)
>>>>>       flush_workqueue(kfd->ih_wq);
>>>>>       destroy_workqueue(kfd->ih_wq);
>>>>> +    /*
>>>>> +     * For surprise unplugs with running processes, we need to 
>>>>> clean up
>>>>> +     * queues before uninitializing the DQM to avoid WARN in 
>>>>> uninitialize.
>>>>> +     * This handles the case where userspace can't destroy queues 
>>>>> normally.
>>>>> +     */
>>>>> +    if (drm_dev_is_unplugged(adev_to_drm(kfd->adev))) {
>>>>> +        struct kfd_process *p;
>>>>> +        unsigned int temp;
>>>>> +        int idx;
>>>>> +
>>>>> +        idx = srcu_read_lock(&kfd_processes_srcu);
>>>>> +        hash_for_each_rcu(kfd_processes_table, temp, p, 
>>>>> kfd_processes) {
>>>>> +            int j;
>>>>> +
>>>>> +            for (j = 0; j < p->n_pdds; j++) {
>>>>> +                struct kfd_process_device *pdd = p->pdds[j];
>>>>> +
>>>>> +                if (pdd->dev->kfd != kfd)
>>>>> +                    continue;
>>>>> +
>>>>> +                dev_info(kfd_device,
>>>>> +                     "Terminating queues for process %d on 
>>>>> unplugged device\n",
>>>>> +                     p->lead_thread->pid);
>>>>> +
>>>>> + pdd->dev->dqm->ops.process_termination(pdd->dev->dqm,
>>>>> +                                       &pdd->qpd);
>>>>> +                pdd->already_dequeued = true;
>>>>> +            }
>>>>> +        }
>>>>> +        srcu_read_unlock(&kfd_processes_srcu, idx);
>>>>> +    }
>>>>> +
>>>>>       for (i = 0; i < num_nodes; i++) {
>>>>>           knode = kfd->nodes[i];
>>>>>           device_queue_manager_uninit(knode->dqm);
>>>>
>>>>
>>>
