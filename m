Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 910E6F94CBC
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Apr 2026 01:56:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 041D710E1AE;
	Wed, 22 Apr 2026 01:56:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lzqAWG+l";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012057.outbound.protection.outlook.com [52.101.43.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1CE310E1AE
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Apr 2026 01:56:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cP9NX1/+VSWxJjwCp+ry6Hq+vTi1ByDJjsmYKpCWoiluUPy26HjoHOGfeZszZfvJ4AZPF033+hCuy644inQHdflXjky8Q0b+/UYfF4Io7gsfUfsmoZwmqZzSWohpjSq06UJkXTs8gvOkQ26h7qm36fKjbxhn98/8v26brY+pVwJAj1bOszLPn5e+Q34X943TMnGU6dnTP8EQZ1qmM8niJ5ztYZyjCShsCEY0DAl1L7lZcAgAOxPW/H0eWryIxMBCLRwN5QzAYSTsiZ8KCBaUTIadk6e1t2Z6OLv8/Ng84PFA02Ap/JPs7JnVoJDw36Li2AlTmj3Md59wSSyG6q1ihw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lr0r59m+BUzeIBPZAgzE3x3/iQJTv9lbUrj0/Dme1TY=;
 b=wdweQJ/SNE5bg7ucXGxU53QeA9cYOlJeDlD/cpqtINQL+1zaYkCbXDVLXY0uadeizfstxSQUQQfz9IStUQOeN+o2Fe4bQ9AOvCyIWFCf8doPAQtvPZQ6ClmmIWVocrUH+4Yl6e9PjbZpp7j8sW0o6UbMFowbv7CSsZhAoC8HVjdaXG9hvRBAYqTwYB5FZwsaos45xVFm8cKFQkBX5wdvFKny9+1v2UNpHxK+W9U3AwJPPh4cbA8N/sIcCus32P/YXaWMpg0WrqC/PAZxd7QflcaBDeV+zHhhMsR36zv+ISvbkvrtpTIiD/5mjv5YvJ2jyeRVZqtuyz3RpVVgv88L8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lr0r59m+BUzeIBPZAgzE3x3/iQJTv9lbUrj0/Dme1TY=;
 b=lzqAWG+l1q1MIeDUTjfd1aISOWICueioE38UeMvD7EtLuZHFoteHuon+wNQEdKnlTiYC33WMa98yq15D6ngdC0EJM9kGpLCF0ghbjBMA51eBMw2e7O9b89a8SrqFmi3wicm6Se4dXeReCkSSqBz0P/BJgOdM774sBEjrKpseqRY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5112.namprd12.prod.outlook.com (2603:10b6:208:316::16)
 by DM3PR12MB9326.namprd12.prod.outlook.com (2603:10b6:0:3d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.18; Wed, 22 Apr
 2026 01:56:24 +0000
Received: from BL1PR12MB5112.namprd12.prod.outlook.com
 ([fe80::d977:95c9:e89:ff27]) by BL1PR12MB5112.namprd12.prod.outlook.com
 ([fe80::d977:95c9:e89:ff27%6]) with mapi id 15.20.9846.016; Wed, 22 Apr 2026
 01:56:23 +0000
Message-ID: <43f46559-fb74-4a34-9cd6-16de02b4147b@amd.com>
Date: Tue, 21 Apr 2026 21:56:22 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Terminate queues on surprise unplug with
 running processes
To: "Chen, Xiaogang" <xiaogang.chen@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Mario Limonciello <superm1@kernel.org>, amd-gfx@lists.freedesktop.org
Cc: Kent Russell <kent.russell@amd.com>
References: <20260112182925.347303-1-mario.limonciello@amd.com>
 <2b4d4476-97a6-42f8-b5cf-5599ac8d0035@kernel.org>
 <60e1e12d-7705-4531-ba15-c956f4d268d4@amd.com>
 <5fc35475-e7a2-483e-84d8-1de7226e1e59@amd.com>
Content-Language: en-US
From: "Kuehling, Felix" <felix.kuehling@amd.com>
In-Reply-To: <5fc35475-e7a2-483e-84d8-1de7226e1e59@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0426.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10b::10) To BL1PR12MB5112.namprd12.prod.outlook.com
 (2603:10b6:208:316::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5112:EE_|DM3PR12MB9326:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f26eddb-4e24-49e5-f48a-08dea0125ad4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|18002099003|22082099003|56012099003; 
X-Microsoft-Antispam-Message-Info: M0qSH2LPjJxgm4uGeFPWrEkycdePirz/RatB9cgqRlInbFyqwcKc/u1s5EbYcPTDK0idkq5Grj5tm2PDre56U8EcJ7qRtV/a5qZi6ow5NlDsF1CKRzEfwhBWNOVHfJkrDxgLx8w7QcB/eaM3vqUN9hriAoPFXHqvPw8Vw/pI/9dhmRLseBEaodyHUGiJma6UrhlewLh6R0WQUv/EUAY+pmJfhD5r5EVAtAJLGLDFAxLwO1FgxfV+uBRuMqq3/WsQRut3O7Q5vK/KUB3DQvU7QamVa7BRULnVNvDDzBIRja7rm6Fs5cBogWFEQcD8ebAbRplwjyp6oOI0fgTSd9RkZMB/MNujaqSl7EDJqxPe3/Jo9YJDmdO+wY8XE/Whq2/g53uta5R4PHs1dZVuHwkycsRnMj/T5L7DtMzLuiUtuG0M8C9f0uE92GS5k5Z0hEk3ncGXe0Q+/qexNrSOHt6iv5/iIsI7u2fJikPNLwZYtyqzkpTa+csCEIzRmCsk9k89DHwqInqwrl4YCbB58Qaf2Owk6tSX94qDOA44AGpxiV2HKjCP11eKpZVw+lwj4eM3GP/npwROrlrHeT5n1C0THOIkUll1Yk5m1ZQ9F3h34ODaOjmR//LM1wJPt9uu8Us2RxbjhjaUCI+3UfZOWwyVTcS8tH9CDzuUgmp+6u9J6YrkmpMSkRcT5Fq1fVQF8Osq0tPoDSV+4rS/Q99JOw7MuQys7ufYHg1aqppC/rhgW04=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5112.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?azRxVGx0QXRMUy9qQitvM1RsOTRZUXJMK0ROTnZ5T2ZuNldjQ2JpWDM5U2JS?=
 =?utf-8?B?amRmVmRpN3liMFVyVStzSFRJNUNPKzhsSFAxaXZRYzBFV3hjb1hLSTFmR1JE?=
 =?utf-8?B?NEgrczB0QXBRa3p4UEp5enpVanFIMVlYckVWMDhWd3ByTUFkMHdzOG5LWGtB?=
 =?utf-8?B?cE92eWFyQVVVMUxhRlIxcE9xTzFJWUdQR2J3QmNOTXVsZFlhVUhBOVhNREdG?=
 =?utf-8?B?L2p3eFhCU1MwSWt4WVp1b0c4Q3pGVlREVVFnUFc4dkNZaWNVcFMvMjBFWWk5?=
 =?utf-8?B?c2o5OWxaZ0gwWlF2WktiUElLOEY4eUhYZDVmbThBUFFZZVJtb1ZMR0g4NDBn?=
 =?utf-8?B?L3RCRGRESElvTDFUcFNmUHZxeEM5bEtFdFhHYUFUYTBSN01jM1BmQ2NYWTUr?=
 =?utf-8?B?Y0N1em1tMmNqVEhyOERJR2ltRmZXZkwyYnVQUUpwbTlTWVc3bWQ3UjNrY0hC?=
 =?utf-8?B?VkFMbmVaUGJxS1ZFdjR1Wi9yZmxzNTh2cG05VGJNQ3YxRVgxS1pIVisvWmFO?=
 =?utf-8?B?ZU82NmYvc3JVbHpQdjd6cnpMTDVpajZldXFxdkRKNTc5WDJsL2xwbmFaaEdF?=
 =?utf-8?B?TnEzUlJXQ2tDTXRUMHNRcHdPck9la254aGlwUmhLblVPNHNHWWZXb0dtZlEw?=
 =?utf-8?B?NUVXclBOZk0wVFJmZVFzZDl4RlFZRjNFK29ONDJCUCtzellaZVp5NHE3b3dE?=
 =?utf-8?B?WlZOcmh1SWU5b2N2cE9KREYwMlZDWXQ3dWlmRXVpdjk4NnZzUFI4ODNPeEtm?=
 =?utf-8?B?cUJzT3BuREE0c0RkeWhyMDVxVFVVYlZjNUZvSXRKZ1p1TVRtOC8xcUVEaDAx?=
 =?utf-8?B?cHkzZDk2U3ZmNnFpTG5WeW0vVEVDSWY2ZGhnMHRqY1lrQlJMUTFsWXVWeUNk?=
 =?utf-8?B?eFk0Zm41RXhKbFY3bHE3UDdwb2hVRXNZalRxN3JFQ1JYeTA2c1RWVUROSEFl?=
 =?utf-8?B?ZDJ2b1hKNkM4VXpPQzIyTERlNGlmZ3pIU0JhZVZxR3lOaGNHWU5jOUZpQ2dB?=
 =?utf-8?B?c3pnSDZxcllvck83U1RKSWNlWldMbm16aElNSVZFSlNXczhaaDNuSkNOdWNE?=
 =?utf-8?B?cklnRzZoMVE2Wk5uc04rS2gySExOUUh0NXJRTEZIdjNteWF5bUdweUZYS0E4?=
 =?utf-8?B?Tm9oaldwQ3NMRWhRTm8waGxUTkwydURhclUzYzBuN0xobCtQMkk3ai9NNW9q?=
 =?utf-8?B?eC83N3R3dUlXVmgzVURaZXJqTXZlY21sUDJtNEl6eUhheGQ4UXVQakl1alFn?=
 =?utf-8?B?U3RzRnYrSXJZZFNVMG1VNW5PdGNWcWtoYkFDVFZqcktCYkJxUUluNjZrNEJK?=
 =?utf-8?B?WkZHeGZsczNOSWVzWTJxaDhaakFydjRySVdDSjROc1NkR2JQV3VyU0l6ZGh5?=
 =?utf-8?B?YjFySTVxd3F0eCtTU2V1UTU1K2ZKSjJoRW9oM1kzZThSTlZ1U3QzbFNNaVVU?=
 =?utf-8?B?QXZEQmdZMk8wQlVSWmwxa0RubDVLZUdKL0xFQVZiN1VYeDBHRHNxdDZBRUFS?=
 =?utf-8?B?eTVER0pFZ1M5TWVVNFhDYXpLc0Y5SlBvVTFvWjlzUnVFSDhTNlRnK3BIVmR1?=
 =?utf-8?B?QUxFQ1dOT0xKRldXdFp4eUM0QXNUM2NpODhhcHBnVXBKbzFtZDdXSjlkaTk1?=
 =?utf-8?B?YW5VZEtsUEt1cjduSWJtK244Y3JCcVkvYXMyWUJlK3RwVnVxZ0J5OWNnYTJ3?=
 =?utf-8?B?R2oyVnJCWE5tMkRBZ0NQZ204V2ZiYU9WSWlzWXdyeERaWkJEOEdzZVhqQTZa?=
 =?utf-8?B?ejE4ZGFFNGZUWUhsL1ZKUWJSWWxoNGg3NmVmckZWQStDSTNsZ25TWU0ySXF4?=
 =?utf-8?B?ejRDUmU3NVk2RVlnbnpBUlpUaDFzeVpjWllOcHgycVFCTGUyVXZrVUR4ektY?=
 =?utf-8?B?aG5xSjVrSUZZeU5EOVZjV0pWSU5uNFg1VHdiR2IzcTVGcU1RQ2VqMktZYVN6?=
 =?utf-8?B?VnptaWRzTHNRK0I2Q3l3ZFZUdWJZU2ZJVldQdU5XVjJPTCt0OGtmWnV4Ui9x?=
 =?utf-8?B?WS9BN1Y2ei9kSzkvelArd3o5cEEyMWsxVlQya3NIdnV0bktzcE9JdmZrZVJO?=
 =?utf-8?B?U0tMUi9YaEl6aFFuWmxrcktOSFZwM3V4eXFzRUwzWHU2Rnk5eEEwSWxha09P?=
 =?utf-8?B?OEk2eTcyWGZkQW9EN01iTVYwWmpMU0RNcFJvVWhzVi9Ocy9JcVhTRXlhYWVx?=
 =?utf-8?B?dnovOVNMc1dZWVY4MUFBcDZiOXZkaCtLQ2ZCSEtaQm9IZDA5VTdVT3hOeVdx?=
 =?utf-8?B?Szc1TjNnNXJGTVVzNHd3VFRCaTYxWGZZR0lYWWc3TmxaZjA3TTkzNmV4a042?=
 =?utf-8?B?NGo1dVZXajhXTFZNU1FWZ1NNZG4yOWsrNHFVZW8xV1o0Mk0rUzdXZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f26eddb-4e24-49e5-f48a-08dea0125ad4
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5112.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 01:56:22.9186 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ft5cKVneERIBKuaDGj/AI27vYjIcVhAogOsSWT3prJo5QO7yAqfQOMbgoEJ2SiNeR3fd1YJE56/EvM/PW6TfJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9326
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


On 2026-04-21 11:00, Chen, Xiaogang wrote:
>
> On 4/20/2026 4:25 PM, Mario Limonciello wrote:
>>
>>
>> On 3/7/26 06:49, Mario Limonciello wrote:
>>>
>>>
>>> On 1/12/26 12:29 PM, Mario Limonciello wrote:
>>>> When a surprise unplug occurs while a process has active KFD queues,
>>>> userspace never gets a chance to call kfd_ioctl_destroy_queue() to
>>>> properly clean them up. This leads to a WARN_ON in uninitialize()
>>>> complaining about active_queue_count or processes_count being 
>>>> non-zero.
>>>>
> During hot-unplug driver sends SIGBUS signal to all processes who are 
> using the unplugged device. It is expected that affected processes 
> will clean their workloads when get this signal.
>
> When a device got removed physically all sources from it will be 
> removed. It is unnecessary(in theory) to clean them up. I am not 
> surprised to see some software warnings due to hardware got physically 
> removed since it is unexpected behavior at run time.
>
> I think what we need worry about is if there is memory leak. Driver 
> also waits when an affected device is idle(by 
> kgd2kfd_check_device_idle(adev)) by checking/waiting if there is 
> process still using it. If there is no process using the being removed 
> device the processes should have been terminated by same process 
> termination logic from driver.

The problem is, that a lot of the process termination stuff happens in a 
worker thread. It can happen after the hot-unplug is already done. That 
would lead to the cleanup worker accessing pointers to device structures 
that are no longer there (or used by something else).

We'd need to ensure proper synchronization so that the process cleanup 
completes before the device unplug frees the device structures.

Regards,
   Felix



>
> Regards
>
> Xiaogang
>
>>>> The issue is that during surprise unplug:
>>>> 1. amdgpu_device_fini_hw() checks drm_dev_is_unplugged()
>>>> 2. It calls amdgpu_amdkfd_device_fini_sw()
>>>> 3. This leads to kfd_cleanup_nodes() -> device_queue_manager_uninit()
>>>> 4. uninitialize() has: WARN_ON(dqm->active_queue_count > 0 ||
>>>>     dqm->processes_count > 0)
>>>>
>>>> The warning triggers because the queues were never destroyed - 
>>>> userspace
>>>> had no opportunity to clean them up before the device disappeared.
>>>>
>>>> Fix this by checking for device unplug in kfd_cleanup_nodes() and
>>>> calling process_termination for each affected process before
>>>> uninitializing the DQM. This mirrors what happens during normal 
>>>> process
>>>> shutdown (kfd_process_notifier_release_internal), ensuring queues are
>>>> properly cleaned up even during surprise removal.
>>>>
>>>> Cc: Felix Kuehling <Felix.Kuehling@amd.com>
>>>> Cc: Kent Russell <kent.russell@amd.com>
>>>> Cc: Xiaogang.chen@amd.com
>>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>>
>>> Ping?
>> Ping?
>>>
>>>> ---
>>>>   drivers/gpu/drm/amd/amdkfd/kfd_device.c | 32 
>>>> ++++++++++++++++++++++++
>>>>   1 file changed, 32 insertions(+)
>>>>
>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/ 
>>>> drm/amd/amdkfd/kfd_device.c
>>>> index e9cfb80bd436..7727b66e6afb 100644
>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>>> @@ -664,6 +664,38 @@ static void kfd_cleanup_nodes(struct kfd_dev 
>>>> *kfd, unsigned int num_nodes)
>>>>       flush_workqueue(kfd->ih_wq);
>>>>       destroy_workqueue(kfd->ih_wq);
>>>> +    /*
>>>> +     * For surprise unplugs with running processes, we need to 
>>>> clean up
>>>> +     * queues before uninitializing the DQM to avoid WARN in 
>>>> uninitialize.
>>>> +     * This handles the case where userspace can't destroy queues 
>>>> normally.
>>>> +     */
>>>> +    if (drm_dev_is_unplugged(adev_to_drm(kfd->adev))) {
>>>> +        struct kfd_process *p;
>>>> +        unsigned int temp;
>>>> +        int idx;
>>>> +
>>>> +        idx = srcu_read_lock(&kfd_processes_srcu);
>>>> +        hash_for_each_rcu(kfd_processes_table, temp, p, 
>>>> kfd_processes) {
>>>> +            int j;
>>>> +
>>>> +            for (j = 0; j < p->n_pdds; j++) {
>>>> +                struct kfd_process_device *pdd = p->pdds[j];
>>>> +
>>>> +                if (pdd->dev->kfd != kfd)
>>>> +                    continue;
>>>> +
>>>> +                dev_info(kfd_device,
>>>> +                     "Terminating queues for process %d on 
>>>> unplugged device\n",
>>>> +                     p->lead_thread->pid);
>>>> +
>>>> + pdd->dev->dqm->ops.process_termination(pdd->dev->dqm,
>>>> +                                       &pdd->qpd);
>>>> +                pdd->already_dequeued = true;
>>>> +            }
>>>> +        }
>>>> +        srcu_read_unlock(&kfd_processes_srcu, idx);
>>>> +    }
>>>> +
>>>>       for (i = 0; i < num_nodes; i++) {
>>>>           knode = kfd->nodes[i];
>>>>           device_queue_manager_uninit(knode->dqm);
>>>
>>>
>>
