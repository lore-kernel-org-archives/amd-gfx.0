Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E2AACA5FFC
	for <amd-gfx@archiver.kernel.org>; Mon,  5 Oct 2026 19:30:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2124010E2AA;
	Mon,  5 Oct 2026 19:30:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YXVMZOV9";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011002.outbound.protection.outlook.com
 [40.93.194.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41EAA10E2AA
 for <amd-gfx@lists.freedesktop.org>; Mon,  5 Oct 2026 19:30:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hQ09oEPAfrlSnSol3LPiKKLrAxlGln6EMEeIuUN+BgmckS3C2/tM9cuyUaAYodmuj3sPVdoiQ7sRdg2sYAXhH4wT+KeXV4s1u0oiQ7mNbK95oso85wLRZ9OTnec7FV8Dq/p+oH6xWSZZQDUyHrTmc8Alcvqvujqg2asiZdmGWcSs6+R3mkoIm/OFM4ZWH5mFmJ9UUW+yM9q2lYvCnThPhizwmkR29ofQc9sCIK/e7kTryhKSj0LADlIzbxQniifdgQNTP6lPz9asFxcehK1SBXxW0uex2xXLHMfX9bK9a7MvRODcz9Qhc4wUJCtPXirEZxHfp5wHBKWP/pQpD1B4tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h1auYWmPLy/LzLaBsW3gqhLRz4z5cnQKeflbGcbPDGY=;
 b=bJnqeC7dyDxibTCD7bBegZp9yGHk+adSX5WQ96+0RUsWelP25AG+fRJ9npLxgfxf5Ew8+GlQzVW+t5PyrXnvk3r5mi7rEe3LnQeSrMzpBfPqDsxYQd+lrCgqokj80iwWZKFk00hpZKhEA7NvGeyviJJgvsAFF3d8Urrd9kSyEAWl0hLUbnTFQ/RTIcA9DH2WhQFgHTInSe9EakG1iI3ehlCQY+0wGx63bZ+kwXKSFdomdC4YB3OG6qBUv15lmEy+HMsZMLjxh+850BTmdECXy4oMNHqk47K9hyuENOvsUm+k0tPtN9b1QnDdb83uH6QPeWAY5DcKUBrqiMGfLf2eSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h1auYWmPLy/LzLaBsW3gqhLRz4z5cnQKeflbGcbPDGY=;
 b=YXVMZOV9m9DhoIcdqZ30yy7kBOn1of07rLeWQJjP8f3pAGb00+YGQ/qv6xZayaczxke7xUjGasfF2B4S4piA+pPxzREDjKOEnP2c5EQsWmEjENO7J452Jw0pftQV5Zdo0190UZpssDJuxuiICXcaWVstBV5rSZwzWkolKV5Yy38=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607) by PH7PR12MB7455.namprd12.prod.outlook.com
 (2603:10b6:510:20e::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Mon, 5 Oct
 2026 19:30:37 +0000
Received: from BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::3f44:4881:3c5a:943]) by BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 ([fe80::3f44:4881:3c5a:943%3]) with mapi id 15.21.0472.016; Mon, 5 Oct 2026
 19:30:37 +0000
Message-ID: <9ab809e9-03b1-4168-8ca0-978697a32b29@amd.com>
Date: Mon, 5 Oct 2026 15:30:36 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdkfd: stop userptr restore retries on device
 unplug
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Olivier Kaloudoff <olivier.kaloudoff@gmail.com>,
 amd-gfx@lists.freedesktop.org
Cc: xiaogang.chen@amd.com, alexander.deucher@amd.com
References: <20261003063817.36606-1-olivier.kaloudoff@gmail.com>
 <20261003063817.36606-3-olivier.kaloudoff@gmail.com>
 <7de6d58f-6037-45e5-917c-6c62b42e00be@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <7de6d58f-6037-45e5-917c-6c62b42e00be@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0355.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fc::25) To BN7PPF5F16C5C9C.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::607)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PPF5F16C5C9C:EE_|PH7PR12MB7455:EE_
X-MS-Office365-Filtering-Correlation-Id: 13da1a9f-dd20-4393-d31d-08df23172240
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|56012099006|22082099003|10067099003|5023799004|18002099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: vi5QkysmMyOYDIEb0XplqJY/hY5izSHuG3mOSbWcYXQFx9FFi5AbYBPvPPE4aTqGgCvYEY+/gHSpU+qe8Ayn0E87UQqkugfJWdf0C4q+xEzBAZJFQmveKSaKhwmKne3k+B0KsOwxlovAnAD298hriYI3ER3xgpAmg96YbnDkJaiLpb2F2h92a6Lf87tYR5Hy6dfRWMDka3kWf503EVCyLjjI1/5OOLM7CaWs2l02zwT7M9AawY6OcK9NF02wJ1OWNYT3UgwKZOR53S1Mcq6e4oni4gRUFV3Kj+LMnZI2sp7+2PM0npXX6sjqR+0KbTx5CcPszrLJ+e7u6R32oFU2EEj6QqXnd6FPPIc0nJztKRAyLQ3m5JkNbP7l9NZwfbOqN2VUu9m/dXgYL5IMA/lv2aznbAUklU8Q02eOUrXhW0StW9if72sSDnR4bNl3XLuCV6Ah7+eFy+AZd8jXzoT8xweo1t27blyN1b09orxtAHtRocKA2WyGZztlxMwsV1JaEyCh7jsUmspX1CE88cn76iuECkunkBr8SsVGmN7VQUckLywbO2i/9pBeo3dL1Gtbs7x/+1ImvDY9rV/sKoZeW13y4VszZM/+oOcdlS+CX69SYJXUBbvvDWd3t3VKNuvvHIP4ppIYNaoZzMs6BqCxZ9XZrL/N6zUulW193oTP2vo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN7PPF5F16C5C9C.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(56012099006)(22082099003)(10067099003)(5023799004)(18002099003)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SGZ0RU9iODQ2ZWQrNTlaaXRyTkN0ai85N3JsSEg0ang4UjJ0bk9Lc3MxREky?=
 =?utf-8?B?alBJbWNibWYvaEsvQ1ExQXl3ZTlZSVVwRmNHem10a2ZEWG8wcWVLQUdZODc1?=
 =?utf-8?B?THRBTGVlSGY3YWxUVjRSYmZ1bGRIM0lmV2NtK3V4UU1SL1ZqU1FDY3R6d0lC?=
 =?utf-8?B?b2dVNXZ5VVNtRklsSzN0Sm9YZk1JSHNsZXBkaFdleHFEbUpacnFHYU1hVDNT?=
 =?utf-8?B?N1JJRkYvS1NPc1ZETXNFczk0OXpBakJjcDZUN1RMbkpiZFJIeDYyNjNadXFl?=
 =?utf-8?B?eFRnenhHSDFtcDE3di80UndGVldGa29Wa1RHRWtUQ1dNdUkxSzNZZlJhNjRY?=
 =?utf-8?B?N2orMEphMEM4ak5KZWRCRHpGSnNBa0dYYmpLbXBPa2hTenp6ZExVUERpUGNq?=
 =?utf-8?B?SEJoTG1RQ201ZXFlM09La0ZXT2ptZDYyajFITTZxS0s4bEdtVWZtRi9KT1dL?=
 =?utf-8?B?aTlTTjNXQlN4MlFMSW5vQlU3d1ZKUG5IdEo1WlY5c2VJL2hDOWlTUFIybjVx?=
 =?utf-8?B?cTBiY1FvL3RoSmlORW84UGY0RWJKNlM4aUFFTFc4elVXenowejJFS2NlTVR0?=
 =?utf-8?B?VHJrOXFNRS9PUjQvYUVGeHhnbVVJazcreTJSMnJac0VZdnQzdW8xRE5yNlBQ?=
 =?utf-8?B?MEVYbWJsZkgxaUd5QVNqOTlRVU03MFphNnI3bGFDRGJQL3RtR3NPVWIzR0hR?=
 =?utf-8?B?Q1NnZno0U05LV2VPTDQ4SXRLWXpBODFqV1lnUXgyWlJza2VhdVMyVm81RC9N?=
 =?utf-8?B?UUlGT0hwZUJrYlRlOHBNckc4Q2lQTFJRdnA1THJLY0FHU2xCL2liWDFDQ0E0?=
 =?utf-8?B?U3d4UDRBVENhUWdlWXkva1E2OUJ5eWFrZWo3dE9BZm8wQ3VHZUo2YTNCM0F6?=
 =?utf-8?B?SjBmbmtLUjNIUDdFUlZRdy9pUERzUzUwUlI0L3RqSkxicHFPK0VvSGZMSHgv?=
 =?utf-8?B?S3hNamdBeC9YVHlhZnU1Uk1JLzRqbWxVMEF5VklCQ3p6MXh0Yy9yd1NCNjlT?=
 =?utf-8?B?clhWS0RremFHcDFIVkZhcEgybkxGcTRxd1UxUWpGRitxdW1IWTJaQi9VY1ZC?=
 =?utf-8?B?cmVlQTNjaFd2QUtGcGpDZG9MQ1JOUG1rV2dldmJBSitQczdPZFkwZFNOMk5K?=
 =?utf-8?B?QzdZUll0bW5UanFIc2RBaHVpZElSbUZpbFhITnBHL2JFSGxiMVhQUXg5L2RV?=
 =?utf-8?B?NnRNVHpTZVljRGhQQWVkb3psR21DY0NMT2tPOHNKTWVWVWxxZFFSNTRlL2pp?=
 =?utf-8?B?OXErYTZHZDlVaDdRNDBXalY5QzVJd21WaDVhMVg4QmVCYTh2MTRJMGpJbUVi?=
 =?utf-8?B?V21QK3BWcjgxaUFHY0x2QThtRHVuMXdVQktHUjN4RmJ5Q1I3ZFNwT2F4WkJG?=
 =?utf-8?B?eFNaTVNHbDJObC9LMkZBOUFvZjQ0OTZFSmdDcHJWN0FDRTRSRUorajR4TWJ0?=
 =?utf-8?B?ZjBNTUFlK2d0OUVuMlRwOWJJWVEydWYvazE4V3gwdkYwaGpRRzZkM2ZTUkh6?=
 =?utf-8?B?WVRrSjNMckxwSlVnT1lrZ1N4VmpoVGFwdVRNTVdSd2tvSVNYWFJDbkEvSzE0?=
 =?utf-8?B?UG04S25IRFpDSmJCZzBoeG5qTGhEOXl2RU1CTHAyeThJVnFNbEptaFlRYktH?=
 =?utf-8?B?MkYzWmxYYkJlV2VoMGszWmR5WWI3dVhYNjhzeGNvNTNlbGtZVncza3UwY3hD?=
 =?utf-8?B?N2RsRkt5emMwZkNtS0p4MWFNNWg5RmZWMGFCd1BHS0ZvVW1zYnJWVHNIYjcz?=
 =?utf-8?B?RUNlcmdOZDduWmM3bjVrQ3JsSVE2MHQybE0zSXJPTFY5anZRV2FDcnFvRmtu?=
 =?utf-8?B?SHQ0QVZzeUNVNCtlUmpnWGZQVEIvUlBJeUQ3b1lrWUdYblNMZHhycDZGNWlJ?=
 =?utf-8?B?TnkxeFpkWiszNGt2OEtVMC9KYzEzV2RtYTdnZkozbHpTQnQvbWlIaktseG42?=
 =?utf-8?B?eG9IRFRMeFF6M0ZWN3JXWk1nK1FXNEpIS2ltZTAwT29ZWjRSbDdzVlFpWWFB?=
 =?utf-8?B?ZzRKc042SERSeXk1OHltcXVCQ0FmVVcwU1diUXRpQk5KYUdrNXpyWXk2VGVM?=
 =?utf-8?B?YUpVS1JaTDQvOThlTERkTUljekRvZEpHNlUvVTVpTjdveTRxeW43L2ZHSkls?=
 =?utf-8?B?d1FITXNKQUVEcGtMTng1N0JKaXkrN2ZObnZ6R2tsSEVxVE91VE1ZVytNVWR3?=
 =?utf-8?B?ZHVkd0xuK2k1WEk1dEdZMHRtQStVZUxPN2F0WkFrN0tFL1JwbHIzRnBMWVpj?=
 =?utf-8?B?K2o4MUh4Y24zN1NsaDRQV1RTYmw5TW9UVTAxYWZ0S0N1L2ExVVB5SWZvZmhy?=
 =?utf-8?B?OGthcEhGdEtZQ0hmZHVJeG9XZjBhUUROYVZPZCtaN0hwbExJbGVnUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13da1a9f-dd20-4393-d31d-08df23172240
X-MS-Exchange-CrossTenant-AuthSource: BN7PPF5F16C5C9C.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 19:30:37.7950 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yF3DHXG5R8Qrs0L94Ns8RS8zgzGoMcviCu7wMpivNkFWgEgLz8WDHRIpWg2vMiYTtGhxpCoG3ag0vxgR1/U25g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7455
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

On 2026-10-05 03:44, Christian König wrote:
> On 10/3/26 08:38, Olivier Kaloudoff wrote:
>> amdgpu_amdkfd_restore_userptr_worker() reschedules itself every
>> AMDGPU_USERPTR_RESTORE_DELAY_MS whenever validation of invalidated
>> userptr BOs fails. On PCIe surprise removal the VM update paths
>> already fail fast: amdgpu_vm_update_pdes() and amdgpu_vm_update_range()
>> return -ENODEV when drm_dev_enter() fails, which propagates up through
>> process_update_pds()/update_gpuvm_pte()/validate_invalid_user_pages().
>> The worker ignores the error code and reschedules unconditionally,
>> producing an endless retry loop on a device that is permanently gone.

The worker should get canceled in amdgpu_amdkfd_gpuvm_destroy_cb when 
the VM is destroyed (when the render node device is closed as part of 
process termination). So I'm not sure why we need a special case in the 
restore worker for this.

Regards,
   Felix


>>
>> Observed on MI50 eGPU TB3 surprise removal: ~11k rescheduled restore
>> cycles, the worker holding reclaim-related locks until the system
>> soft-locked up.
>>
>> Stop rescheduling when the validation failure is -ENODEV: the device
>> is gone for good and the affected processes are being torn down
>> anyway. Other errors keep the existing retry behavior, as they may be
>> transient.
>>
>> Cc: Xiaogang Chen <xiaogang.chen@amd.com>
>> Signed-off-by: Olivier Kaloudoff <olivier.kaloudoff@gmail.com>
>> ---
>>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 22 ++++++++++++++-----
>>   1 file changed, 16 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> index d668816..6c040ed 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> @@ -2827,6 +2827,7 @@ static void amdgpu_amdkfd_restore_userptr_worker(struct work_struct *work)
>>   	struct task_struct *usertask;
>>   	struct mm_struct *mm;
>>   	uint32_t evicted_bos;
>> +	int ret = 0;
> Please don't initialize return values when it isn't necessary.
>
> Initialize it before the goto.
>
>>   
>>   	mutex_lock(&process_info->notifier_lock);
>>   	evicted_bos = process_info->evicted_bos;
>> @@ -2846,14 +2847,16 @@ static void amdgpu_amdkfd_restore_userptr_worker(struct work_struct *work)
>>   
>>   	mutex_lock(&process_info->lock);
>>   
>> -	if (update_invalid_user_pages(process_info, mm))
>> +	ret = update_invalid_user_pages(process_info, mm);
>> +	if (ret)
>>   		goto unlock_out;
>>   	/* userptr_inval_list can be empty if all evicted userptr BOs
>>   	 * have been freed. In that case there is nothing to validate
>>   	 * and we can just restart the queues.
>>   	 */
>>   	if (!list_empty(&process_info->userptr_inval_list)) {
>> -		if (validate_invalid_user_pages(process_info))
>> +		ret = validate_invalid_user_pages(process_info);
>> +		if (ret)
>>   			goto unlock_out;
>>   	}
>>   	/* Final check for concurrent evicton and atomic update. If
>> @@ -2886,11 +2889,18 @@ unlock_out:
>>   
>>   	/* If validation failed, reschedule another attempt */
>>   	if (evicted_bos) {
>> -		queue_delayed_work(system_freezable_wq,
>> -			&process_info->restore_userptr_work,
>> -			msecs_to_jiffies(AMDGPU_USERPTR_RESTORE_DELAY_MS));
>> +		if (ret == -ENODEV) {
>> +			/* Device is gone for good, stop retrying */
>> +			pr_warn_once("%s: device unplugged, aborting userptr restore (pid %d, %s)\n",
>> +				     __func__, pid_nr(process_info->pid),
>> +				     usertask->comm);
> That warning is most likely unnecessary and maybe even harmful.
>
> That the device is hot removed should just be a perfectly normal abortion condition for the worker.
>
> Regards,
> Christian.
>
>> +		} else {
>> +			queue_delayed_work(system_freezable_wq,
>> +				&process_info->restore_userptr_work,
>> +				msecs_to_jiffies(AMDGPU_USERPTR_RESTORE_DELAY_MS));
>>   
>> -		kfd_smi_event_queue_restore_rescheduled(mm);
>> +			kfd_smi_event_queue_restore_rescheduled(mm);
>> +		}
>>   	}
>>   	mmput(mm);
>>   	put_task_struct(usertask);
