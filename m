Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30D96CA5FA5
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Sep 2026 08:56:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1F1310EDA3;
	Tue, 29 Sep 2026 08:56:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iMX7lQfC";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010037.outbound.protection.outlook.com [52.101.56.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F2B810E127
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Sep 2026 08:56:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FQcZjvltw+ONoRj7diF+NeLDDF8xPG/hO+Ds3maIJ5WqVvZzatZnRj0VG9McPloLeCqB5kTXTqwKzIbFgCPFlJNQgoWgjQragOJh6HrW1WgLLyHRtz8NKkH70N4m2bPHee+ru32aePz7rssYRO4H/2n7qFnbW0gfv3vIerZYaHsBIIajFlfKyYG+NudmRnVCqh9xWvTRh1raKevFAFIaSGy/l2aT31pcygCxuml6ZjLf7Rg4baIw+wW+NjhB/OzYAUBNpfSEIHpHuWHuC4JVDQlADEt29yzW0uWm87HRs1vJfLQp83F5Nhcih1gNCNZ31TDKBIFoNoILROev0lUBwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RgG20FSb1zjt5UBKPQA5PdidtiJDnk6rqnnKffnmEqE=;
 b=hhR7u+tPhr25cWY1xiw9mPXpqz9CavjAHKBPcJKuCKSri7AgUlSXpTTuTHgsapS5JtINPioXlMvVZSlXgxfiU2KLrMsfF9lz7rFinneVJWtv/cUpX3xOKmGo/U07Q3a+2hmEnVZf2GuRbjebyE0L3ERtYWRYAtSaaO9kjM4VKEg/DbJVn3i788Mip32oFWCuvRV8IA7uBM2l26A9ilBdFhD4g5xlfOFfCsBxWj31wddNSJ87wJPWN93ndPhVhcGXYrLLTSoZkkSCNaDfepf/e/wozU4zCmov5t7KbiseqLO7MaC+CfpR5HR8GW2tQxZGwOmXrcNeeht/8qHrEkJDMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RgG20FSb1zjt5UBKPQA5PdidtiJDnk6rqnnKffnmEqE=;
 b=iMX7lQfCjcKtHa9f9wcrGeEaTOffGdtcFIpjzA1E5nmdvbuideZbOFWAEDpwK/GZA3qZSlc7LDWRhcvGp8DG0YhYrAvIKs286gZW/VX97LNjmhIpWCR9AUkH03Bq6OBwOXp8MOW+BQST8cWL2a/QXjuvLjRVbMWXW1quevLCaCw=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DSVPR12MB999308.namprd12.prod.outlook.com (2603:10b6:8:423::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Tue, 29 Sep
 2026 08:56:29 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0451.022; Tue, 29 Sep 2026
 08:56:29 +0000
Message-ID: <269ff7a7-e952-438c-8dba-79cefaf14868@amd.com>
Date: Tue, 29 Sep 2026 10:56:26 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/18] drm/amdgpu: don't block wait gpu reset whthin userq
 lock
To: vitaly prosyak <vprosyak@amd.com>, Prike Liang <Prike.Liang@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Vitaly.Prosyak@amd.com
References: <20260902125001.621629-1-Prike.Liang@amd.com>
 <20260902125001.621629-12-Prike.Liang@amd.com>
 <123fa18d-1bf7-48e7-bace-cdf429148128@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <123fa18d-1bf7-48e7-bace-cdf429148128@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0408.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d0::6) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DSVPR12MB999308:EE_
X-MS-Office365-Filtering-Correlation-Id: f080a94a-5b5f-4f70-c0a3-08df1e078d2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|11063799006|10067099003|6133799003|56012099006|18002099003|22082099003|4143699003;
X-Microsoft-Antispam-Message-Info: niBsVJo1xwDAUPqEVXdREZSaVeYbld3p2691kOCGJw00/hMNnSlJlsAr5n3oEsytI0LrmGsEz7IIkWWBbivAQchl7t/TfQyQjiQsrRzJ5jjAUFuOPAlvTT5XMqKoVT5yumCJlsAolNmgFNajzwG0v8k5P2eQBkv5XXwvhQL7nnMULsT5MKCalB1YCsqiCKnP4h8Jdi9O8Bo6O2XxG1q0VFB6BDs9KzIk8T3S1ivsICFpOkMql+UNCCnEbzUtSfTq0JSSNAtS8pj0w4wb0ThkBiY1z3I5ZdjJa9F9Qws1V8tuIXeymVGeWvQ5iEwEbUKhlw69TdMPmqLuWrg1a7F0PPYX3f4osXksbE/dmE3hRX6oVcFKp0vEU6qMWVkAR8waHNyeciITkK7Os02LKFJISCDmvQdS0xSkqxOIR1+Sdwstf+aSHE3O7QJDN+GnZo5WK67wmBHY1ayNh3ZaRXF1iX0QZ3dRz/jJ6Z9ZU1jW+alw4faIZmCbbNqP70FvF1SDY4ri2tl70GCVaEveZhCtEjj7XCUBV/sfVLPvLuiKQttvnSx/vE9g2eJsz2slnoolo0Td/SUNParcDYTE9nh9D87XSi5wn8H+DJKgeBZhtLWBEnqxm+u6N6sA0Ln00ePgqLAkHBU/n0FzPDd1GESuYazyOj+IikSRT1tNraqrgDA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(11063799006)(10067099003)(6133799003)(56012099006)(18002099003)(22082099003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OTY2eTNXa0FXdVdlS1J2amkzeno1dksva1hPcCtKbzA3cmtCVnR1NEpwQk53?=
 =?utf-8?B?T1EzK0JjZTdKYVVUTWRmN0F5R3NXaDFac3pmd2FpOEVxTmw2YmdqWlRackt1?=
 =?utf-8?B?T3ZtSjZFOHFnMnZ6UkpVSUNtZWNiaUdPVXFPWUJaK2YxMTlmNGM4QnpnT1cz?=
 =?utf-8?B?TnhReW9FMkFIYU5rVmVMd0xlMEhZMzZGREpoajZ4bDJCRVpGWWlsb09zNlBN?=
 =?utf-8?B?K0tyQ0JBM2JxM3hMNnVSeXJjOXlQYkJmVEludFFmaDQvVGNVcHc4TFdoRzdZ?=
 =?utf-8?B?SHNGeWhzd0NmYzA2ZklITkFxYW1xeGhSVjVXU1JtR2dNWXhUbjVMOWhzRzE5?=
 =?utf-8?B?QlNnbkt5QUt4Q2lBWHZ5MUY5Z2dSbVExcHdPMjUxL1dTTmNrNGpNaG5KQzJE?=
 =?utf-8?B?aVNSeFhVT0N1S1MyL1BDV0N2NnNTNEtna29oQkdJOXVCQm1keEZndTlaVU53?=
 =?utf-8?B?cmI4M0dEc21SazBFY2dIbnRxcFF0MEVmWVU4ejkvZTdObm1TU2d1dm9NZGtK?=
 =?utf-8?B?MytvRHJtNmlYd0RKcVpySXdsdGNaVEZhR3ZRUCtUc2JodVczT0EzdFFsUjRY?=
 =?utf-8?B?dDFmK1Nwa2tMSFA3amx3Y1g2RjBpS1J4dDEvNUl4STZEOGlJMnZsaWVlNmVW?=
 =?utf-8?B?MEdsTnYwektSY3l4YVFUWDA0am01R1FoK1hMNU95dHhsZjZQUmw3dWRwVitu?=
 =?utf-8?B?TXhGREhacXVmWHRQV01wZXhETXFYR0lLcE9PbkxGSldtRURTR2V6b3dWdUlD?=
 =?utf-8?B?UHp3R0lYUDArdjZKZUlOeUNSZUNVUGZoNFRBdW5zN0l1NlNueitFRjVqeFZr?=
 =?utf-8?B?dklyRkFiQmFtM2dpaU9ZQTI2VDBNR091d0F0YXNhWHZtd1FSZWF2YmM4YmQw?=
 =?utf-8?B?WDI3eVJFeEQ4cVR2Y0VNbitFZm9nYmxNaG1OdjNiYXcyUDZhVkRuVWR0OVlH?=
 =?utf-8?B?dG5yRC9oR3NTZnp3TGVXN09CT0tQKyt4bTJHcUxZNUhhYVFFZTBLMndZdmY4?=
 =?utf-8?B?UXJwWlNLbldiZjZvYVV3NjRhNkV5dWFnbDdWWCs1YWJkR3NiRTVwaUNGb3lw?=
 =?utf-8?B?cmtzVzFWNms5RjY4OG1acWxVMSttV3hYMnhBcndsdlV3RXJHUzZMU3kzQ3hL?=
 =?utf-8?B?OEZOOTZDZGI0d2FFQWltVkQrK2Frd01JQzMvVkEzaE1rNWZjcnJEWVIzaWw2?=
 =?utf-8?B?RWRCQmZsalNEVU9NZDVXYUZwWE1naVNhQTdjMXBrWXdqMitXS1ZDZGNlQkRU?=
 =?utf-8?B?cURuNS9NMDFBNDVKbWQrZzBreUc1SDdhaTJtMFZGMGRwaFQvY2tob0ZvUmU4?=
 =?utf-8?B?N3Y0VVMwVHhlakNvbkVESzg5ZE9yS3BuMTN2eUxkZWxIUEFMMm53eUh1bVVN?=
 =?utf-8?B?K1VjMG8zMWRIQk5LdER3M2xaMEF0WUhYWUo1ZVVGaU96WGd2eEh4K1FBM2oz?=
 =?utf-8?B?cms5VkZLSGN2NmRGdVdIdmtqS0hrLzNuRVVuNWkzUThyUk9OUGQ5Z25LRlhL?=
 =?utf-8?B?di9NMzE3VmJ1YzFSVzlCV21IOFVSMUJCRTNyR3FMTkZ0Ymttc0ZQNHJaV0Z2?=
 =?utf-8?B?elkrRG1SVXhWWTNIdGlIL3dER25FYktzTTc2ejZlaUtXTjZKV1lqcFZTaVUv?=
 =?utf-8?B?cTRpMWF1d1N6bzYvRlhuUlRORVQxOWlYTC9XK3h5NU1qd3NUQWlXcXBpNjU1?=
 =?utf-8?B?cm1ZQkJYanY4SE5nMEczVTZ1azB3NTg0a29IdWExeEZWeVk4M0p2blNhY2Zu?=
 =?utf-8?B?SGlRR3BuZ2dqbktjRnZKaGk2d1EzUmJLTGVyVmdSdld1ZTFXTDJIYTlpTm9M?=
 =?utf-8?B?aG5sTEcrSllFOUNWMkd5MWpvUzdFR0NNQWpGcFVmbXpzeGxhU2I3V25Qb2dt?=
 =?utf-8?B?dWJxa2MzSDNuVmxNbFNuMEhUVGZobjYrbzU1RTNXUkRNVWowQi9MV2VtbFRz?=
 =?utf-8?B?RlRhb2ttcTJnU1pvZ3F5UkJmc0swdTJmeHFPQUc5QnNjNmNUeHVsSllBUTBS?=
 =?utf-8?B?aFZJWGNkRkhLRHRWU3hSRkpXRmpUYzdNN3JpbFltNUR3VnF5UUJKRGZOYnJJ?=
 =?utf-8?B?ZkxGamRvQldONnVMeVFHajlRSE84ZUkwbzI3SVE2Ync0aDVMc08zZ2IrUDdr?=
 =?utf-8?B?Umw5cUNtSTlNaW0vTXVFYnBYa0Y1VkUydHFCemFUaEliS1VyZVFDaHZOSGpP?=
 =?utf-8?B?bU5IM0JVeDF1WU0rb3RJZ1NDT2gvTU9sNzFGS1lBVDFEWUpqTGt4cFprSFV3?=
 =?utf-8?B?Wko3VDR4bTZMRjZOVHpuL3Y5UnYxVmJibm5STjFaSk9lV2J3d1ZQUU9PeHpI?=
 =?utf-8?Q?H2yixZ5aET4V59mIwJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f080a94a-5b5f-4f70-c0a3-08df1e078d2c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 08:56:29.3587 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GhifA8LvlxtGJcyAwiqW9obbe7Ray2OUOEwqe/2hWpmIXx6yLB0hZDXZqaxSIGOQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR12MB999308
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

Sorry to be late to the party, but absolute clear NAK to that.

The userq mutex is part of the eviction handling and that eviction handling in turn depends on resets to complete.

So it's absolutely forbidden to take the userq mutex inside the reset handler!

That is like the third time I have to fix this.

Regards,
Christian.

On 9/29/26 00:49, vitaly prosyak wrote:
> Reviewed-by: Vitaly Prosyak <vitaly.prosyak@amd.com> 
> 
> I have tested this patch on nv31. It successfully resolves the lockdep deadlock warning triggered during the reverse 
> 
> ordering of &reset_domain->sem and &userq_mgr->userq_mutex. Please note that this patch requires a rebase to apply
> 
>  cleanly onto the current target branch. Once rebased, the lock inversion issue is gone, and the trylock-and-retry logic 
> 
> works cleanly to unblock recovery execution path interactions. We can safely enable this on the CI.
> 
> On 2026-09-02 08:49, Prike Liang wrote:
>> The offending edge was code that did a blocking
>> down_read(&adev->reset_domain->sem) as following, while
>> holding userq_mutex. Since GPU recovery takes reset_domain
>> ->sem for write and then transitively acquires userq_mutex,
>> the reverse ordering could deadlock.
>>
>> .569196]
>>                other info that might help us debug this:
>>
>> [  307.569516] Chain exists of:
>>                  &adev->firmware.mutex --> &userq_mgr->userq_mutex --> &reset_domain->sem
>>
>> [  307.570011]  Possible unsafe locking scenario:
>>
>> [  307.570250]        CPU0                    CPU1
>> [  307.570438]        ----                    ----
>> [  307.570624]   lock(&reset_domain->sem);
>> [  307.570785]                                lock(&userq_mgr->userq_mutex);
>> [  307.571061]                                lock(&reset_domain->sem);
>> [  307.571320]   lock(&adev->firmware.mutex);
>> [  307.571491]
>>                 *** DEADLOCK ***
>>
>> Signed-off-by: Prike Liang <Prike.Liang@amd.com>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 51 ++++++++++++++++++++---
>>  1 file changed, 45 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> index 2534e4a1a530..a7d5ca741a3b 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
>> @@ -422,9 +422,12 @@ static void amdgpu_userq_detach_doorbell(struct amdgpu_usermode_queue *queue)
>>  {
>>  	struct amdgpu_device *adev = queue->userq_mgr->adev;
>>  
>> -	down_read(&adev->reset_domain->sem);
>> +	/*
>> +	 * The caller serializes doorbell removal against an in-progress GPU
>> +	 * reset by holding adev->reset_domain->sem for read.
>> +	 */
>> +	lockdep_assert_held_read(&adev->reset_domain->sem);
>>  	xa_erase_irq(&adev->userq_doorbell_xa, queue->doorbell_index);
>> -	up_read(&adev->reset_domain->sem);
>>  }
>>  
>>  /**
>> @@ -544,11 +547,34 @@ amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_que
>>  
>>  	cancel_delayed_work_sync(&uq_mgr->resume_work);
>>  
>> +	/*
>> +	 * Cancel hang detection before serializing against a GPU reset. Hang
>> +	 * detection triggers recovery, which takes reset_domain->sem for write,
>> +	 * so it must not be canceled while that semaphore is held for read.
>> +	 * A reset IRQ can restart hang detection, so this is repeated on retry.
>> +	 */
>> +	cancel_delayed_work_sync(&queue->hang_detect_work);
>> +retry:
>>  	mutex_lock(&uq_mgr->userq_mutex);
>>  	amdgpu_userq_wait_for_last_fence(queue);
>>  
>> +	/*
>> +	 * Serialize queue teardown (doorbell detach and MES unmap) against an
>> +	 * in-progress GPU reset. Do not block on the reset semaphore while
>> +	 * holding userq_mutex: recovery takes the semaphore for write and then
>> +	 * (transitively) userq_mutex, so blocking here would invert that order
>> +	 * and deadlock. If the trylock fails, drop userq_mutex, wait for
>> +	 * recovery to finish, and retry.
>> +	 */
>> +	if (!down_read_trylock(&adev->reset_domain->sem)) {
>> +		mutex_unlock(&uq_mgr->userq_mutex);
>> +
>> +		down_read(&adev->reset_domain->sem);
>> +		up_read(&adev->reset_domain->sem);
>> +		goto retry;
>> +	}
>> +
>>  	amdgpu_userq_detach_doorbell(queue);
>> -	cancel_delayed_work_sync(&queue->hang_detect_work);
>>  
>>  #if defined(CONFIG_DEBUG_FS)
>>  	debugfs_remove_recursive(queue->debugfs_queue);
>> @@ -557,6 +583,7 @@ amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_que
>>  	atomic_dec(&uq_mgr->userq_count[queue->queue_type]);
>>  	amdgpu_userq_fence_driver_free(queue);
>>  	queue->fence_drv = NULL;
>> +	up_read(&adev->reset_domain->sem);
>>  	mutex_unlock(&uq_mgr->userq_mutex);
>>  
>>  	/*
>> @@ -734,16 +761,28 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
>>  	if (r)
>>  		goto clean_mqd;
>>  
>> +map_retry:
>>  	amdgpu_userq_ensure_ev_fence(&fpriv->userq_mgr, &fpriv->evf_mgr);
>>  
>>  	/* don't map the queue if scheduling is halted */
>>  	if (!adev->userq_halt_for_enforce_isolation ||
>>  	    ((queue->queue_type != AMDGPU_HW_IP_GFX) &&
>>  	     (queue->queue_type != AMDGPU_HW_IP_COMPUTE))) {
>> -		/* Serialize the map against an in-progress GPU reset (MES is
>> -		 * unresponsive during recovery), matching amdgpu_userq_detach_doorbell().
>> +		/*
>> +		 * Serialize the map against an in-progress GPU reset (MES is
>> +		 * unresponsive during recovery). Do not block on the reset
>> +		 * semaphore while holding userq_mutex: recovery takes the
>> +		 * semaphore for write and then (transitively) userq_mutex, so
>> +		 * blocking here would invert that order and deadlock. If the
>> +		 * trylock fails, drop userq_mutex, wait for recovery, and retry.
>>  		 */
>> -		down_read(&adev->reset_domain->sem);
>> +		if (!down_read_trylock(&adev->reset_domain->sem)) {
>> +			mutex_unlock(&uq_mgr->userq_mutex);
>> +
>> +			down_read(&adev->reset_domain->sem);
>> +			up_read(&adev->reset_domain->sem);
>> +			goto map_retry;
>> +		}
>>  		r = amdgpu_userq_map_helper(queue);
>>  		up_read(&adev->reset_domain->sem);
>>  		if (r) {

