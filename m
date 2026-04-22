Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 537E0F94CBE
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Apr 2026 22:02:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD36E10EAA8;
	Wed, 22 Apr 2026 22:02:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SW5s8km9";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012053.outbound.protection.outlook.com [40.107.209.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC40310EAA8
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Apr 2026 22:02:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D7u3Rbv4ipEKvJbx+UcDxlJYPkwYl7PonGHD75Wrao3rYGp0odETOiAJ5YtGi1AOABiE+imnS7dJX5ATBSQSAZk8umirOuImJWR638/9K938xKNXQgAoHWf/mJOnBwvEJUGZbOcs0nBoo/KMd31H68d+7hlmMdcOM8IyS9peVCrqihORJ14EOHaz9nTabAxWe7dQzu1jvKUG6oEA/071S71kpgJvJ2sMu/9pMmDyAw0s7gcLk6MStN3UvkzMWDC9+hLOcM73BcXXzWNOEG7pYQzLk9DOAl9j1DZb/Ok4dyijAuw8ln+oLML6+BetnN2EOGhUiWPZQ4HEBJAXulJiUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4dLFNsY9Q6mydWktn6XOVs28G+ww9IpuIP4D7DpJikc=;
 b=yfserg2ETmSv+Mifap7wW57FhRbv5UcyLypJaEUK/Fjay31Ky1Yo50U0m8MXkIxD1MTEgJbQHOrlXLAQTuhNdGy3Bdkyfbp0si29PyVtiOJuTpzUe+y7hRdVPKsiNridxQAY8C3yPX7j3SvES2myP68BBq+H4FEkTzBwvnYE5+qAQZe39PA+2rUW0JNyxgGSC1jVtAzFZTyBax0YsO9Ps9+joh8q2OO4YJo2mpagOZny7fgFuiSNIXyC+bUpXthp9eJTmlshf8s1PUIaMKyLQq7W686XX/o/l27zhpSafp6yjIf/naDH2JeJC/PC9w1KIndRYj/fXPACOQWp+l7VTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4dLFNsY9Q6mydWktn6XOVs28G+ww9IpuIP4D7DpJikc=;
 b=SW5s8km9WMikVHQjegkLKjA4v3D7ZvV5NxonB843WkSuKw3UC39WSO7OJl4O68wf0usa4jZqZdDb8LUV8ggF4hpf9yaB5E6O81yUuOmAOeL64yMphvp7TPUJKZkrgPxdC+Ex/sf7UEZWqdEH/UjdTQthcs1Mhk71qNwe+VHFyr4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4401.namprd12.prod.outlook.com (2603:10b6:5:2a9::15)
 by MW4PR12MB8609.namprd12.prod.outlook.com (2603:10b6:303:1e2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Wed, 22 Apr
 2026 22:02:15 +0000
Received: from DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::795e:4056:1c5f:6b33]) by DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::795e:4056:1c5f:6b33%5]) with mapi id 15.20.9846.019; Wed, 22 Apr 2026
 22:02:14 +0000
Message-ID: <59e14708-56db-4b49-be3a-d3b48e71c99b@amd.com>
Date: Wed, 22 Apr 2026 17:02:12 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: Terminate queues on surprise unplug with
 running processes
To: Felix Kuehling <felix.kuehling@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Mario Limonciello <superm1@kernel.org>, amd-gfx@lists.freedesktop.org
Cc: Kent Russell <kent.russell@amd.com>
References: <20260112182925.347303-1-mario.limonciello@amd.com>
 <2b4d4476-97a6-42f8-b5cf-5599ac8d0035@kernel.org>
 <60e1e12d-7705-4531-ba15-c956f4d268d4@amd.com>
 <5fc35475-e7a2-483e-84d8-1de7226e1e59@amd.com>
 <43f46559-fb74-4a34-9cd6-16de02b4147b@amd.com>
 <fbfaf548-0c34-4c09-9674-8802224f9349@amd.com>
 <339fdaba-5649-4bf3-bd09-6bd20c197118@amd.com>
Content-Language: en-US
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <339fdaba-5649-4bf3-bd09-6bd20c197118@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0103.namprd11.prod.outlook.com
 (2603:10b6:806:d1::18) To DM6PR12MB4401.namprd12.prod.outlook.com
 (2603:10b6:5:2a9::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4401:EE_|MW4PR12MB8609:EE_
X-MS-Office365-Filtering-Correlation-Id: c9d13b2a-4bc3-4e9f-0ad2-08dea0bacfdb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: fmb9cHefWnGuHrAq4+mRxNiyGN1y+yAy39cryov/M4S/CfKb04M26UT8nVc5warIshrvEV48YQD1UEWAAjj2qvQW8mrmxEBrk8DDqp4l7ZOenbeJIq+WRAd3GSP7HKXBLo8/kDLORml7CA6xPYO/xZtdm9As0/eRnqVXmq1FpY+//kkjJc3TVopeWAXvJHvbmrjucQ20e6Nq7r4BPXVaHsub+98qMvlXAC7lKJPbJAVicoj8KiiR1CsUf0vW/ai7ZkdLeBrTkcgaskwf2pMGV61SVgwuyh9vhfK1ipfoBotr9CdoLL2XkPfWYSJNWfswZTJ+5w9XXk2muv6vs8hg8wJimr6hILL0R5FpXzyOjj7lnfTN5puU/FTfsQJFplx9BpdX0qJ2FR1mGj+gEn4anQVmylb8jbjiXcB477J63doov3Ylt3Qy0cGVoTEn4AGKKIXMUTwsXFKnojxOZGjMzioxpVwLGAlQbuHeEC7um++/un31FRJv6yH4G/cSvMBpIz0cjNyvoqLrJba42GyukHyC9MqXXShLWxSzTnPPob1Zhzmg0B9oCrzJNkvL6m99D5Ea5PGqz85gKnY1w0HAz+wIxIFJLLp9nXH4zfcExqQ4QIMaaeYOWgIMS9YEUxMeddbsf3QbcJke7vqVN/f6Ffx4jTjTjEXa8dZq743vui5pC8fiMuQM6GJdGfJdVgS3igQTsTc7gyYUwWvS7ucMlN+JewdW6vF+v4SGPXbruuk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB4401.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RitqeUppd0x0cG0rUkx2SzkwKzR4b0ZvdUNmckNtOHI1eXdDdEhGcmx5S3FK?=
 =?utf-8?B?bjRNSys4M0k1YTRraWdQQzJCbWlsd1BEQUE1Tk05eGhvUVNUL1hNQVNERkZQ?=
 =?utf-8?B?cWhVTnplbjZjK2JDV05JL1pPaWZsSlNqa00zUjIxTlg2a0FWTHRFcFFlejdx?=
 =?utf-8?B?dU9CdWQ3RVdXSTdablRHWWsyTURDZ3lmSTZvSXdRT0FUMWdYSE5UZGNEQlp0?=
 =?utf-8?B?eW1KcVkxcVNVUVViUGl2OTFUZDlzQ2lwbTFNak9vMFc5QTM3WVppWFhzZTFS?=
 =?utf-8?B?RkdQYktBTzZKM0RzZXNIdWZISGdlMTAzQTFyVzRPaG9MN2Z4QkdRTWY4RzBH?=
 =?utf-8?B?NC82VXVhRmhBcXhvM2J0WDQ2ZzVMeHV4RmdlSnZVNlBFNVlRR1V0UlhXbzls?=
 =?utf-8?B?SzM1aTZiSFhOSW1UQUNDaTd2N2ZWYXBNSW1RODRyT1RjMXVQazNFSDdGSkFw?=
 =?utf-8?B?clJ2RzZOSjlSdHQ1b2NjNHRuTDdoQ25vN0hlTTNzOXR4bXo0L2xkS1p3QnFz?=
 =?utf-8?B?amFBM2pSSWRMY0NpajJxbjhrUGV3L2FMUGVBMS9sTnlub2NkT2tPZGtpS1FK?=
 =?utf-8?B?TUFLb2V2R1VHVmZTamVZZ2F4cjdDZ0M0S3pFZzhlYjIzajBnNW9MVytxKzEz?=
 =?utf-8?B?MVA4Q2kzbFpjdXQveDN3UkhQR0hlZHYwZk1udXpQOUVYbGFZSDVBYTFLdmk0?=
 =?utf-8?B?dldISDFMSzRVS0RuL2dvRUpnMHRhWUoyUjNwYkFIcjNQcHNLUlBkMjJjQVJV?=
 =?utf-8?B?V05QbWJZazRubVpQMXp4eUhYRVlId2lNVk5nOE1NTE9ieG1icTlhNlFGYmxR?=
 =?utf-8?B?SlcwRERsdTVjcFJwNUpPTVQ0MVlvZ0kvWTVBaUdLMkFMRWJiV3dtVWtkN3hq?=
 =?utf-8?B?Y25NclV5V1ZZbFMzTTh3dUNTSSs2endwckNWWWdkTTNLenQzV2twN2RFYTBS?=
 =?utf-8?B?KzNzYjJoeDk0b09BbzAwK1pSZUdkdmw4WXZmRzJ4ZVkwWTMyRENUVVFHTGxB?=
 =?utf-8?B?dmVXeXE2M2xRNGZnMWhMWTR5TlJIMUtLZkVJRUJxZEZWUXU0VUpNa0Jic092?=
 =?utf-8?B?eFZMRlNRUkNVZkM2STBXSm40L0NFUzlZTDVrdnJiaDFHL3FNbTB0dXg3Ymhx?=
 =?utf-8?B?ZFdScTEyRTdBa3hYQlFOOWh2bGkwcTRjMW9YbXVkYnl2VEJZNk9nbno5RzNW?=
 =?utf-8?B?QnlPaS9RSS9rWGQ5Z3J4dWJQMituQlBpL3FTbkc1Mnl6MzNicUIvRVhMMmRD?=
 =?utf-8?B?QzdUVnM5bmNNMVFUUHlYdUlaRnBYcmxuMUhUekJ6S3dBOUdWTkwvb0JOT3Nh?=
 =?utf-8?B?Q205OEpvSlhxMDlRMkNTV3JnQkFQQ3MzSXVlRXRGZmx4TnpEL3drZGNLQlFU?=
 =?utf-8?B?WHZza3RuTTlaajdGaGp6WUlvanRhNDNabzZub1JVUWtOUkpjd1pqVk52dkRQ?=
 =?utf-8?B?WkY5Q1VTdk16TmlLd2l5Nkc5aUxEK0wrRlUrYjVyRGQxdmVHMFVTM2tSWW9i?=
 =?utf-8?B?RFpGTG5vZnBnekozTGxSSVhZa2MrVjk3emxZUzBnRDVBY0tvTEdHRnZEN0Za?=
 =?utf-8?B?TC9MaGhIVkJkeWNCSElUQ09nbEliaGhoMmVTVUVVOGZEYVJtT2wyOXIxZStL?=
 =?utf-8?B?aElaQWRHaFh3ZzRpK0crTHBxZ3lkMU5xSmdvd1hKLzVyZXlXekxRNjZZZ1Ex?=
 =?utf-8?B?dHNsWDI3RWpEZjVmUUFSaFhnODNVVlJLbmE5ajF1bEFOOUsrSjVTVzIrdnc0?=
 =?utf-8?B?WGRHakZIL1poYllHN0lTRWdaMzg4enJZN2NLajBxVXdDVHd6SEUrRHdGWURS?=
 =?utf-8?B?RlFVa09vTFBEWndXNTVjUlhmZkkxTzA3REtQTmRrbTE2aXJWWXJGQzhOdzg2?=
 =?utf-8?B?dWNFaFNnbXpEUmJMSlI5RDRaa0oyTjNld1duZ1VoYnVydDBtamN4R05FYWZC?=
 =?utf-8?B?Nk0zZWlVRGFIMWwySVJOSm9ac0JUeU5xTkJnd29OTVdPZmdzVXZzYjlxUTNC?=
 =?utf-8?B?b1NLNXE5V2EyaFNxd0VSbW0waElsODI3T1I5RmEveXJSYi9BT3Q1QTVFRDhw?=
 =?utf-8?B?NlpvLzJEdHFrYWprQkpud1pwVGVrOTVWYXR4VjE3ZEt6cVFabjBDd282VEVQ?=
 =?utf-8?B?MzJnUXZOeGVxaWNjMkEyYklCSEgvR3JOOWpZcXQvTnVMMlpjQXozeUN4NlFI?=
 =?utf-8?B?MnZoWGp1MG1uTEtNTlBTRlR2WVdXSDZ3N3Z2bUZzSG50Q2I2cmZXTkY3SUxF?=
 =?utf-8?B?dnJWdUhXcGRjNVJzOXAvQmtYQlNnOG5OeFBObWtPQU1lZkdQL2tPVEZMQWYz?=
 =?utf-8?Q?bJkQpyxCftX9RdYbpX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9d13b2a-4bc3-4e9f-0ad2-08dea0bacfdb
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4401.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 22:02:14.6880 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dWgRzFbQSSNEhJMapMFtSWnB23inC4W+UanbKR9lArLfOqbVT8TEizUWykl7gR15
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB8609
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


On 4/22/2026 4:00 PM, Felix Kuehling wrote:
>
> On 2026-04-22 11:53, Chen, Xiaogang wrote:
>>
>> On 4/21/2026 8:56 PM, Kuehling, Felix wrote:
>>>
>>> On 2026-04-21 11:00, Chen, Xiaogang wrote:
>>>>
>>>> On 4/20/2026 4:25 PM, Mario Limonciello wrote:
>>>>>
>>>>>
>>>>> On 3/7/26 06:49, Mario Limonciello wrote:
>>>>>>
>>>>>>
>>>>>> On 1/12/26 12:29 PM, Mario Limonciello wrote:
>>>>>>> When a surprise unplug occurs while a process has active KFD 
>>>>>>> queues,
>>>>>>> userspace never gets a chance to call kfd_ioctl_destroy_queue() to
>>>>>>> properly clean them up. This leads to a WARN_ON in uninitialize()
>>>>>>> complaining about active_queue_count or processes_count being 
>>>>>>> non-zero.
>>>>>>>
>>>> During hot-unplug driver sends SIGBUS signal to all processes who 
>>>> are using the unplugged device. It is expected that affected 
>>>> processes will clean their workloads when get this signal.
>>>>
>>>> When a device got removed physically all sources from it will be 
>>>> removed. It is unnecessary(in theory) to clean them up. I am not 
>>>> surprised to see some software warnings due to hardware got 
>>>> physically removed since it is unexpected behavior at run time.
>>>>
>>>> I think what we need worry about is if there is memory leak. Driver 
>>>> also waits when an affected device is idle(by 
>>>> kgd2kfd_check_device_idle(adev)) by checking/waiting if there is 
>>>> process still using it. If there is no process using the being 
>>>> removed device the processes should have been terminated by same 
>>>> process termination logic from driver.
>>>
>>> The problem is, that a lot of the process termination stuff happens 
>>> in a worker thread. It can happen after the hot-unplug is already 
>>> done. That would lead to the cleanup worker accessing pointers to 
>>> device structures that are no longer there (or used by something else).
>>>
>>> We'd need to ensure proper synchronization so that the process 
>>> cleanup completes before the device unplug frees the device structures.
>>
>> How about at kgd2kfd_device_exit before doing any device clean up 
>> check/waiting there is no any kfd process run on this 
>> device(kgd2kfd_check_device_idle)?
>
> Looks like this should already be happening in this call chain: 
> amdgpu_device_ip_fini_early -> amdgpu_amdkfd_teardown_processes -> 
> kgd2kfd_teardown_processes -> kgd2kfd_check_device_idle
>
> Maybe whats missing at the end of kgd2kfd_teardown_processes is a 
> flush_workqueue(kfd_process_wq) to make sure that all the cleanup work 
> is done. After that, there should be no more process data structures 
> referencing the device.
>
We send signal SIGBUS to affected kfd processes(who are using the being 
removed device). The app signal handler will be executed asynchronously. 
There is a delay for signal handler got run. If call flush_workqueue 
immediately after sent the signal the kfd_process_ref_release(from 
kfd_release->kfd_unref_process) will not be got ran immediately after 
sent signal. Then flush_workqueue will not take effect since 
kfd_process_wq is empty or no filled work item yet.

Regards

Xiaogang


> Regards,
>   Felix
>
>
>>
>> Regards
>>
>> Xiaogang
>>
>>>
>>> Regards,
>>>   Felix
>>>
>>>
>>>
>>>>
>>>> Regards
>>>>
>>>> Xiaogang
>>>>
>>>>>>> The issue is that during surprise unplug:
>>>>>>> 1. amdgpu_device_fini_hw() checks drm_dev_is_unplugged()
>>>>>>> 2. It calls amdgpu_amdkfd_device_fini_sw()
>>>>>>> 3. This leads to kfd_cleanup_nodes() -> 
>>>>>>> device_queue_manager_uninit()
>>>>>>> 4. uninitialize() has: WARN_ON(dqm->active_queue_count > 0 ||
>>>>>>>     dqm->processes_count > 0)
>>>>>>>
>>>>>>> The warning triggers because the queues were never destroyed - 
>>>>>>> userspace
>>>>>>> had no opportunity to clean them up before the device disappeared.
>>>>>>>
>>>>>>> Fix this by checking for device unplug in kfd_cleanup_nodes() and
>>>>>>> calling process_termination for each affected process before
>>>>>>> uninitializing the DQM. This mirrors what happens during normal 
>>>>>>> process
>>>>>>> shutdown (kfd_process_notifier_release_internal), ensuring 
>>>>>>> queues are
>>>>>>> properly cleaned up even during surprise removal.
>>>>>>>
>>>>>>> Cc: Felix Kuehling <Felix.Kuehling@amd.com>
>>>>>>> Cc: Kent Russell <kent.russell@amd.com>
>>>>>>> Cc: Xiaogang.chen@amd.com
>>>>>>> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>>>>>>
>>>>>> Ping?
>>>>> Ping?
>>>>>>
>>>>>>> ---
>>>>>>>   drivers/gpu/drm/amd/amdkfd/kfd_device.c | 32 
>>>>>>> ++++++++++++++++++++++++
>>>>>>>   1 file changed, 32 insertions(+)
>>>>>>>
>>>>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c 
>>>>>>> b/drivers/gpu/ drm/amd/amdkfd/kfd_device.c
>>>>>>> index e9cfb80bd436..7727b66e6afb 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>>>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
>>>>>>> @@ -664,6 +664,38 @@ static void kfd_cleanup_nodes(struct 
>>>>>>> kfd_dev *kfd, unsigned int num_nodes)
>>>>>>>       flush_workqueue(kfd->ih_wq);
>>>>>>>       destroy_workqueue(kfd->ih_wq);
>>>>>>> +    /*
>>>>>>> +     * For surprise unplugs with running processes, we need to 
>>>>>>> clean up
>>>>>>> +     * queues before uninitializing the DQM to avoid WARN in 
>>>>>>> uninitialize.
>>>>>>> +     * This handles the case where userspace can't destroy 
>>>>>>> queues normally.
>>>>>>> +     */
>>>>>>> +    if (drm_dev_is_unplugged(adev_to_drm(kfd->adev))) {
>>>>>>> +        struct kfd_process *p;
>>>>>>> +        unsigned int temp;
>>>>>>> +        int idx;
>>>>>>> +
>>>>>>> +        idx = srcu_read_lock(&kfd_processes_srcu);
>>>>>>> +        hash_for_each_rcu(kfd_processes_table, temp, p, 
>>>>>>> kfd_processes) {
>>>>>>> +            int j;
>>>>>>> +
>>>>>>> +            for (j = 0; j < p->n_pdds; j++) {
>>>>>>> +                struct kfd_process_device *pdd = p->pdds[j];
>>>>>>> +
>>>>>>> +                if (pdd->dev->kfd != kfd)
>>>>>>> +                    continue;
>>>>>>> +
>>>>>>> +                dev_info(kfd_device,
>>>>>>> +                     "Terminating queues for process %d on 
>>>>>>> unplugged device\n",
>>>>>>> +                     p->lead_thread->pid);
>>>>>>> +
>>>>>>> + pdd->dev->dqm->ops.process_termination(pdd->dev->dqm,
>>>>>>> + &pdd->qpd);
>>>>>>> +                pdd->already_dequeued = true;
>>>>>>> +            }
>>>>>>> +        }
>>>>>>> +        srcu_read_unlock(&kfd_processes_srcu, idx);
>>>>>>> +    }
>>>>>>> +
>>>>>>>       for (i = 0; i < num_nodes; i++) {
>>>>>>>           knode = kfd->nodes[i];
>>>>>>>           device_queue_manager_uninit(knode->dqm);
>>>>>>
>>>>>>
>>>>>
