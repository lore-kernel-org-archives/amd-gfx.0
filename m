Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5BDCF8FA88
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Apr 2026 15:00:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 861E410ECC2;
	Tue, 21 Apr 2026 15:00:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CzQ+Zqxc";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010068.outbound.protection.outlook.com [52.101.46.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 114B510ECC2
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Apr 2026 15:00:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lzmb+DTJ+7jGdqvaZhEXNYXralB0dUTSKff9SvIFZ4PX8pu2w5G+Uv4PB4zKOnKTu0NySu/vp4ke3defdlhsPxEzFmSAYlELwtzj4ufd0jA2pdEJDWjtKoM2UI56HtVaSd7X3fIr7nXZhFeapnZoj4WbUNjvaiXOHfKVfPpVx42E6lt/HI5/JIifjJSv0NIZlLLnd6x977yUEaYozV9HfRvwobdk3Wt8fcL6zfmVBslplR8V+AbSomrKY1Sw8P43jkK9DsXlAMEFr4s8bDMztDwoOrA7l69FyzP+jCOyZiTr8T+nKKjAkMCx2hqqG4l9eiO38cgriZPJ6398AwCpjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=swtvyWn4Meao+HB4u7UPD5VtoFAV+RQVV0qeHMWUh9c=;
 b=KVdQQMNabQ0sh3+i097MeA+kitgAgyzVsS7bQFcRvEcdi2T52VkA4MU+TK9uksWTHL6pS3vfoW9JxYiNoqHZeoGdXK2EI+uVmt+jtT8tUvnod6wYHBHZomS18JYWqXosqQpGLRkOmMDvA8zxzzihX2vBwCLzR9k9C31ZvJNHh3IPzuHSNrnJX+wBsKQS0olx/vJFUzR0miuywLfAFSbJTIMkX5BfwahAdcrpakxvgGd8N1y3V9I9IUoQia2XrLvRfR0QxbMVGIJvnx9yrPbWl1VfaGwyIyWB5WZr2MbC9Fv1sfZfcLgRp4+m1R9Jt7CkXZAqvQ63BNL+W6ihcbdVPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=swtvyWn4Meao+HB4u7UPD5VtoFAV+RQVV0qeHMWUh9c=;
 b=CzQ+ZqxcdcR1m05DBdzcgTsCJzHWMCi+GsiCQb1D5b0/RVTVRWN169psHy0fiAJwAkcM8T+uMdnf7pVdEFUxIR1t2kLiLpAK3SYiwJaBIzjid+o4xUuyXL6tfJ+8dt/dZ3LpMxB+1ttWB9VtHj+XMiM7zSQac8n6Lx+OJBtZ1cM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4416.namprd12.prod.outlook.com (2603:10b6:806:99::8)
 by DS7PR12MB6286.namprd12.prod.outlook.com (2603:10b6:8:95::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Tue, 21 Apr
 2026 15:00:33 +0000
Received: from SA0PR12MB4416.namprd12.prod.outlook.com
 ([fe80::6901:6c89:2155:ea8]) by SA0PR12MB4416.namprd12.prod.outlook.com
 ([fe80::6901:6c89:2155:ea8%7]) with mapi id 15.20.9846.016; Tue, 21 Apr 2026
 15:00:33 +0000
Message-ID: <5fc35475-e7a2-483e-84d8-1de7226e1e59@amd.com>
Date: Tue, 21 Apr 2026 10:00:30 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Terminate queues on surprise unplug with
 running processes
To: Mario Limonciello <mario.limonciello@amd.com>,
 Mario Limonciello <superm1@kernel.org>, amd-gfx@lists.freedesktop.org,
 Felix Kuehling <Felix.Kuehling@amd.com>
Cc: Kent Russell <kent.russell@amd.com>
References: <20260112182925.347303-1-mario.limonciello@amd.com>
 <2b4d4476-97a6-42f8-b5cf-5599ac8d0035@kernel.org>
 <60e1e12d-7705-4531-ba15-c956f4d268d4@amd.com>
Content-Language: en-US
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <60e1e12d-7705-4531-ba15-c956f4d268d4@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH5P222CA0012.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:610:1ee::7) To SA0PR12MB4416.namprd12.prod.outlook.com
 (2603:10b6:806:99::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4416:EE_|DS7PR12MB6286:EE_
X-MS-Office365-Filtering-Correlation-Id: 53aae75c-b520-4265-c030-08de9fb6bc8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|56012099003|18002099003|22082099003; 
X-Microsoft-Antispam-Message-Info: rP+OVjizK1Xptc+uCbn2R10hKxhDKw/nSeFl1QgIOHzFhDy8oMziUbmFh6yODMyj2dptGECE+OHMATmMMC/CfkspbJ4/UT8OVFDevDVPLuPGaWR3K4zOQ+d3qJ+UuOC+ffZ53t0sP+1Ofn3m6vpM79um8Zz7CFL3A6vYDdwRSw7LmG2gMhejUO3cXz6hQ2wWXi0D8LeQOjFQwplCHtDpBSmSf1c3d+IlWeOW60c6X1qxvWsLzV1R0Vh9HQHL9hEDaI+NtLzUfMbBuFL/yf8eD+1H4g5KvER9RFcY8MSGyNWGuJjLmux8eq7fP4pWFZrjVVo5+XoegiSxlg6+M/mlhIsuKmNT/1m0rysh0GynhuQa20tMu7HmzAWwiQSvGBgWh+sSHcGYxSQwSPI+4rBE1WHjyIH42AyhDrOKe8xd+sii+/oNFPNOuqcYabE83lPWbFMch+rmEuHC4ElgA8VYAXTXwycrv/OVuxM2622eFQSlvc0sOti1GxWnd1aBXoyNrDjxFXKu+vePBYZPVXqsQ3Z7lMEGbjYsXbk8Q5HxbBE7wuzZEdqrP89h420tONaksus+1JL/EaM6imJqVWWAF1HJ6f+RP6RQpK5YNmLLX8G00JSZS/oZwaqKDDy1pbz8sfcTY5eG5AqFHe6rT5VNV1Lij0LTJOYFHTJQ47qAHTGaJqPoLei3j1MLdY9k641elxb0YW9lSu4wBUNcAfxyv7GvvQnD0yco+5oCDqFe02I=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4416.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z2pGdzdUSFc1SHRrVVVPbWxuQkcwZTh4U05VazlXQU1BQ2t3dS9iZjBLTFk5?=
 =?utf-8?B?M2hXVkt4aWNGdzcwMFFxSFBOcGc3cFVQQ29zdmFZbUx4R2RUUHF3cGQyemMw?=
 =?utf-8?B?dkMveFhRbVlSTmozVFl4RzhJYXJNWDZYbDBxM052Y2Z2T2JIZXd6WVlNZDVj?=
 =?utf-8?B?aG80eXl1NUZreXpISkVwYXFSbUFBQUhUVC9JUGdxMVJlakpwa2krdFlQYXM4?=
 =?utf-8?B?ekNBK2FwZSswTCtub0I4RnBXRFR4c3dmZWNlUDNGbHNjbmJDY2RLMks5ZitF?=
 =?utf-8?B?bjZkL2REa3pzWTJjbzNjZUhWT2tydFJ6cU85MW10TXdOMVdOTE44QW02TTVK?=
 =?utf-8?B?V2RKaU9SZXBpOEQvZGxEL2ZJZXRjMHNxRG13KzhRanBEdkZTRUlpZEhRb2NF?=
 =?utf-8?B?VFpCOHpWTTE2MmtDVEloMnBIV2VBS1B0bXIwV3FlZlYzYk03RjZGMWNicGVZ?=
 =?utf-8?B?dzB5RytHNjZZSytreEZWN2ZGWWp4ckJVcElvd1g0R3pWbTFJV28vWUsyQ3Fm?=
 =?utf-8?B?dSttWEJUWU41MUdsMER2VFFWSnFWZDFXTjJ6MEVoTUM1bHlEMlRBWUhlandj?=
 =?utf-8?B?WEdUWjcrakY4QTVUdXZXcnp4cTVnR2VGaGNucXdZYzZFWmpWZ2d5S2FSN2Za?=
 =?utf-8?B?T0lxamlrUFpzbVZXRVJ1NlovYjRHMFpYTXQxT0svdjVMZHIrd2hUY0VjdnVi?=
 =?utf-8?B?YTVDOCtSY1kyN0ZKUHRSYURsbk9ydmVmTjVyUm9NQVlCQWdJdDRXNUE0andZ?=
 =?utf-8?B?dlc5VlA3SU5qeVJmMUxUUDZBWG1paHFDYVlEV3o2SGs2dlRlSmJGUUUvcWwy?=
 =?utf-8?B?cUlqZ3NUNzB1ZlRNSTE5OVZQcXdnNXE0cEFIUVFzZjVQWGYxNzJDWW9YbXNR?=
 =?utf-8?B?UU5MR0dnS2t5NlUzOEoxbUozckc0ZmEvaDBNa2o5Qm1wUHFpRVFBMzFwRHZK?=
 =?utf-8?B?MWFVTzRicy9vWjRvckhqL0JjQVNBSitZS3pUczN4TE90czI0ZkpVMFlFbkdq?=
 =?utf-8?B?dFRaQkNWQVZReUJIT1NieGduSVJrclpCNGp2WC81K1RubWI4bzI0bVJpL01U?=
 =?utf-8?B?eWE3RlBYSG9EOUd6b1N5SVBlR0hQQkxNSDYrNERYOFhWNStReWF5SXh4cVhG?=
 =?utf-8?B?VVlReVhBdHZxaGdUUVYrQUNod2g1L2E5OVJWNWRlczhaTUVlTG5wZGs2QjF6?=
 =?utf-8?B?Wmd2Lzc2Skg5aDl3N0NKdStLSkQwS2tlY2lWaW1yZjRvT25pa3hNbjVxWHdZ?=
 =?utf-8?B?amhGT3NqcXo2ZFBWY2lkK0oyZ0VESy9QODhTczJjUGI3WDdHc2diRzNyZlNW?=
 =?utf-8?B?ZVkxMmd0dDk1Tm0xaXJITm94Z1oxZ0RmTDNTc1BhaFFpTWs2Tm5SRzA1Zy9j?=
 =?utf-8?B?Nkhac1Rqa0krTjBqeDhYZmQzcFk5dGd0ejQ4Y1ArSEEzdU5hZkVKOFBmM0E5?=
 =?utf-8?B?UE9NaWd0RHJQYXNlcm1iaEx6VXUwZjFpZ1NHWmY0VmF1M29IRFRvc09VcC9u?=
 =?utf-8?B?dzh2bFd4ZGMvZndYRkVvYUh3Z2g0UktBTmNmdmJZejJvRWo4WjlIUTc2b0ZB?=
 =?utf-8?B?Z0ZNMkVKbktkRkJLa3BFTGx2TlZSaE54bkVuQ05mdElHQWovMnI5QnVZS202?=
 =?utf-8?B?ajlDVTk4V1I5dmsxTVVwbG1Ceko0azBFTXF2VWhEaVRkYWtnTGRXdEZBNVgv?=
 =?utf-8?B?M25hc2hFMXN0bzVpcEJ5TW9NTm54eXVoblRYcldTL083ekYrSkRiZ1dBYkky?=
 =?utf-8?B?cm5kRDd5alJGRmtqRWV3bU1vU3BwV2pBVnl2ZE9xaW9wWEJGUUZTN3Z3SFI5?=
 =?utf-8?B?UnJncDFycG9ZNFU4WHB4WS9kZVN4TS8zb1FEYzVDV2xlQzQ1WkRWOE1SS1c0?=
 =?utf-8?B?TnBxNWs4UjNpYkZVdTFkNW9DVFFZOHFhaTlrOUU4YWVBWU1lcHNuWWd0ZnNZ?=
 =?utf-8?B?aHo0NUVCUFpiRXNSQmhVbzZqKzR4OVNxYVFXQW8rTlJ2V09uQmkwUHl3dDl4?=
 =?utf-8?B?RG9Va0hhU3h5Q0tPUFhvSmpkWWxvZE5Lbk8vL1R0SGZvWG5OMmpzQkJTRXFs?=
 =?utf-8?B?cUlaSUZNZm10dnMzMHc1SW5KM2VIZEdNMzZTaU9vRzFHdVFKVE11VE9odVBm?=
 =?utf-8?B?bHFtVXNTeGhvcGZlQnJUT0dKaU9FbTIrSnRtUVF1eVVFd1pRdDdtQTZ5cHdh?=
 =?utf-8?B?Smh3WXdqMy9aWUF5NzRZaXFnNXRpTmJlU2ZNdWJBc2VwVHg0R3pJTy9ySjYz?=
 =?utf-8?B?K2IrWWNtM3UyWVpVQU1HWU1WSEhBTG1mTWlLWHIwY1A2azZIUHVCTkZBeFky?=
 =?utf-8?Q?pyW3OWZCAvv5wSwEAv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53aae75c-b520-4265-c030-08de9fb6bc8d
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4416.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 15:00:33.1739 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qjR3yS1xg08nDtbCYs4gsd0PHZzE54yM24lQC5iIamEx/XC3MjboQUtynxpFJMs9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6286
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


On 4/20/2026 4:25 PM, Mario Limonciello wrote:
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
During hot-unplug driver sends SIGBUS signal to all processes who are 
using the unplugged device. It is expected that affected processes will 
clean their workloads when get this signal.

When a device got removed physically all sources from it will be 
removed. It is unnecessary(in theory) to clean them up. I am not 
surprised to see some software warnings due to hardware got physically 
removed since it is unexpected behavior at run time.

I think what we need worry about is if there is memory leak. Driver also 
waits when an affected device is idle(by 
kgd2kfd_check_device_idle(adev)) by checking/waiting if there is process 
still using it. If there is no process using the being removed device 
the processes should have been terminated by same process termination 
logic from driver.

Regards

Xiaogang

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
