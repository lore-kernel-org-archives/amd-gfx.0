Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6CBE109878D
	for <amd-gfx@archiver.kernel.org>; Fri, 20 Mar 2026 14:34:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DE4510EA9C;
	Fri, 20 Mar 2026 14:34:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TGQsqHho";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010051.outbound.protection.outlook.com
 [52.101.193.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 328C210EA9C
 for <amd-gfx@lists.freedesktop.org>; Fri, 20 Mar 2026 14:34:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UllOi3Zk9cJaI93PQV/0dewLbipVlvSSaNZRt6QTHY067l977dfE5rPyVkvS1hPFx5JfvUiqzbSQTEvQRc5sHBRl0i4e66FWnlUR5cpm/OfMBH3TwjMtOsY7ldU6d4o0F506l9fRQOQ79KrcdKtd5jUL1mlW2MZ/Hu92Ted+BQ+xiNy1R3DtoS7QmPwH7jKY2wRcGleXeTauydM3ZNV1w8Tkxddqh2ixpFrPMdpZJ+UGpeoDgVs4akFg2xvExgNimLH6vjEvEg3IGscsgwDAyKQuXdQU09lS1f0ch7wiIv4GII90UdwNvrfbeL5MAZc9rKYK/bKxs4RwxmL7Me3ugA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z5pYOsGY4DfsHAQkQ67skW6OS1xyoe/p3WZxjVKmsq4=;
 b=FsTtSdYv23hhWbKUnufeNHA9kY3tNwJWK0ny4nZ7fMLjLagv+PkDZwgjZHdFhAGNISLQUupiSkTLu+xy0fmWr+rzG52+9g5qTI8zgvBz5tY0fcOvnzUpPy09hifASlMb8+zACJeoxM80m7yNc50Su6KKDipuD1b2XkC8YbtqISId71LtyCAYqJ8kBOMxHHc4mh1K3Zi8JBomilit6cqgzxZImwt5nRkCkNWXoe3Y7bZPNXhygyu/FSySpegYFjPZAjZv4cNjoeLUqBbA0mfU0/z2AAB00I0r0LwnlkokC2accXmxq028nZ21hO/IY+VYPu9EabV47uQ/JuWuwQCx7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z5pYOsGY4DfsHAQkQ67skW6OS1xyoe/p3WZxjVKmsq4=;
 b=TGQsqHho0K4Sbmw2+Y/kaGJYdtl2j4SPgD+Ggn/NTS9S3JKUAwLlf0d8CaDn1mhtf1HbdDulJKKckxtRKMnJDgV24GuAnCL+EwW/wkbQg/qWsmdS5VymWuArT2MA5Mhwi6Wvasjk7Lmae/dnL+eb/7VH24mfJb8GaL4szeneImw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10)
 by SJ1PR12MB6148.namprd12.prod.outlook.com (2603:10b6:a03:459::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.13; Fri, 20 Mar
 2026 14:34:07 +0000
Received: from SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287]) by SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::885a:79b3:8288:287%5]) with mapi id 15.20.9745.007; Fri, 20 Mar 2026
 14:34:07 +0000
Message-ID: <f388c29e-4d1c-4d04-9eca-ce3b74f00931@amd.com>
Date: Fri, 20 Mar 2026 09:34:05 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdkfd: check system memory when set apu_prefer_gtt
To: "Zhang, Yifan" <Yifan1.Zhang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "Yuan, Perry" <Perry.Yuan@amd.com>, "Lin, Leo" <Leo.Lin@amd.com>,
 "Perry, David" <David.Perry@amd.com>
References: <20260319073250.147808-1-yifan1.zhang@amd.com>
 <80732b5f-27a9-4969-8afe-98f3156c725e@amd.com>
 <CY5PR12MB63693D88EBEAEE20CC4B6870C14CA@CY5PR12MB6369.namprd12.prod.outlook.com>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CY5PR12MB63693D88EBEAEE20CC4B6870C14CA@CY5PR12MB6369.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0020.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::25) To SA0PR12MB4557.namprd12.prod.outlook.com
 (2603:10b6:806:9d::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:EE_|SJ1PR12MB6148:EE_
X-MS-Office365-Filtering-Correlation-Id: 43bea318-d062-4393-1967-08de868dbe0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|22082099003|18002099003|56012099003|7053199007;
X-Microsoft-Antispam-Message-Info: O8gOWZ/22KVITbv2SN/1mznvzKRDe5DTlxyuiMi6HyARybbYxOZXEsYstUqw7bPbAN1sfAFyMr4j28sP/mh5BHFVXiVfHphttfKFPw1FV5zJ9Qhs8gMYRNDSug80BA6rQuMHa2u3KWh2XADtaisKvYqlbXxkE+MUdaoAsdTcO6coLvs0UA5ItZ55LdEhUHsH8Eaq/iEx5VwslFmNPdYFcckOzTuM0q4m4CM5AomHY92wXfQniEhWRhRm22ti2SbaEfhcqvr3uBFyhDTatTNAIV2BerTkCgupoDgTS030d9/MXSAcwe9TkqcTWGNrwE2yTPOn+RhCoWgJkHQwWAj83YUdjUp4DnhWsEXPIoYifhgvF9HJQgU22pY2thzGgGQuDpqR7r8qY0iAjcAcHwtnEge7ZiPy2G10m/9loN5PEpbevmpy3HiXF/W2WwW+E+W55D7E/TpVY8aD7nv4aG6s8wXu52bmvL0jO5QAkkwJDLcoC+2qsWxhLmCSnSJtVFFwLWbRT+8NlsvpruAKvMMogkMh7nCnwinz+m+dQFRuY9gPX2931JI6dB7R8CXHV/ZQmwjqn3j881T/e4FKSWdrKYi7GqW0AMyAowKDNXeHKBJUlubIFTY5qCPv6xH+S8X76jzss9OHJOv7dyLeFmHQkl2gxZnvdDnZGWyV8tDfxspdB2/Pgbeh73YZXlTKnXSmEiXDswy9OGvMU2nXeTyLGBzJkavCUGRSDlqPjwxvJ80=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA0PR12MB4557.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(18002099003)(56012099003)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y3NDNzN0NHZzdHRFRkc2Wk5UL1RqZlBaU3NLTHI2SDJ5SXFUdzE4T0FnOE03?=
 =?utf-8?B?YXVmWjdLRWlGZE1SVndaKzBUbGREV0hUY0t5R2Q1QS8xYmx1M0hKRUd1QjVm?=
 =?utf-8?B?TVZwNnBNbHpKWk45VmNOQnRSVk95bFlKdVJ0R1huRVc0cXl5dHVwc0lKKzh4?=
 =?utf-8?B?V1I3QVI1U2NmcVVvVGJUYUw4Q2JtNm1qVFFFRFRzL09FQ2gxYnc0ZU1XU2sw?=
 =?utf-8?B?MHJESVVlRDFPSjZUUFFtbnlXSUhRaGlzUFNSNksvVVU5NzJ0Z0w3cjVMVjZ1?=
 =?utf-8?B?Vis1Sjc4WS9IeFp6cHJ6aW9aOE5ZLzRmc1Q5eDNPTWhkaEJxWmoyNTBiQkk4?=
 =?utf-8?B?WUFXOTdSSFA0bXlRVGpWVkZaUGdmZWtqUWFTc0M2VWZYLy9GaGRqQzdVUGho?=
 =?utf-8?B?UzhrTFJFYjRPRjVHVHZMdEwwRWcxcFE5OTFudzhEaG9DTW5tcHdQaEU0cDJa?=
 =?utf-8?B?c3U1b1NtU0lJdzFmNXRsSTdGUEFuN3BZTE56Wm8wOVpBWDRuL3I0L3lVNERE?=
 =?utf-8?B?TDF5Z0IvR1BQNkpLVTFhYWVIYnRzVTVVL1EvSjhPNmZ1Q3cwNGZTWXlqaTlM?=
 =?utf-8?B?WGhkUGhsRWRlaGpxU3FqN0RWakt1QVFyelE0NGhMc2FBMS9TRmMvQ3FXbE91?=
 =?utf-8?B?bEk0UUJMaEtYdkN5NWEyYTZtbmRObERYQXJOV0JkT2NlN2libHFmVEN6emZz?=
 =?utf-8?B?TWxEWFgvYW0zbkZqVEl6dGJlRlc3cDd0cnpBcyswUTZiei90aVRrSFI4cFUy?=
 =?utf-8?B?VHBuN3BXRTdnZFNja29QSDgvN3BpTnBTYjY0eFhSSldBY1ppV3p6S0NRTXFF?=
 =?utf-8?B?ejNCa2MzRjc3S2k1bVdJblBSVlNncjBkM0JqeVRVRkZuem01d3U0b1Yxa0Yv?=
 =?utf-8?B?UHM5ZmgyL3crOU9uMDl3Qlh6b0UwVDZLUzdMdkdDRGVNZmg3dFdjYzNmTmhO?=
 =?utf-8?B?WGpGZDdLamtweHUyTjFZMnZRa2VBU005Y2VQMzF5Tm1PNUZTdHEyWG5wTk5o?=
 =?utf-8?B?OElOTldSWlRPbjBMZDZxQ3RQeWRRbGFtRVpodENETFZNaTJiZGN4blRJQUZp?=
 =?utf-8?B?VDlhNGgvSDVkVEY1WVhYMEUxZnkySE51aExxZzFITjV2OExmb2pMUENCWUhJ?=
 =?utf-8?B?WVcrR1V3cEc0MWtHTVJGOWtRYUQwYzFUYldhRmdLNDFnMXFtTERmY01FQXFs?=
 =?utf-8?B?aXBWNFJnN3lYdHJzWHBGTVBuWExSdnlHdDMyZ0xMaFRDK0t3N01QOFNsLytY?=
 =?utf-8?B?RVRIVU8rWnlFenZjbXNrb1d2NmphUWQ4SzFiNWtHV29hUElKRythZ1k5aVVr?=
 =?utf-8?B?cnppUGpqRWJlVzQyMUl3WVR6bkF2UVZJZ3I4ZjBWcit1VlltWnlBZG13bmVp?=
 =?utf-8?B?OUxvZjE1WkRlN0JncXg5NUVQa3BmTzUwZWhTWjJCQWJUaU9lUUEwQkpvZlZs?=
 =?utf-8?B?NThzZE8yMHdRQ2hmbUZoREJ4YlJxY1E1cmp0S3prd2p6SWhOeUJBWkRldksz?=
 =?utf-8?B?Yml2cXBMSWZGalB6aFJRellTSXNoMXp6djhpNWltYWJNQ0ZHcXpzV3pXVk5m?=
 =?utf-8?B?L3Jtdmg1TEtpK3BzbFFaZ1lLWmNZTTdlMm40UkxlY0lYNklJNFM4NS9lNTM5?=
 =?utf-8?B?ckhHUzRQb01IYTRMRk5jTk50dVFPZkhQMDlicGQ2eCtpRk4yUFkrdmlKSGo1?=
 =?utf-8?B?bzR6UHk1aytIVUtwOVRvbkU2UnNLQ01pYmgyakl3c3NoS2pkWHRxeG5tQ29a?=
 =?utf-8?B?ZGJKcGVkZytNNXVKaWd0dHJrS3ZCbVltdFZuZ3lQK2k4eHdKSWE1RUxhMDha?=
 =?utf-8?B?YlpFcVp6VTY3VFZpVVh2aHNWZWg1WlVuZC82cHYwVWtYREJtcjBpbjlPTXZh?=
 =?utf-8?B?KzIyQzJKUkViR0w3a2FvTHNJZUc0UWJva3BFdWdjbm9JSW94SGtKMnpWZFpj?=
 =?utf-8?B?b3dNSGtldElMOTNPNmUyN1lDVjRsSTFHSnZoNEp4cmVKVUM4Q09SbUNFOHZM?=
 =?utf-8?B?YTV0WTZMbTYwR3grTmZkVkZjU2pBYXUvVGhOZmZxR09DdWg4YzFVaGU0L1pn?=
 =?utf-8?B?U0FmRlhSbk4vb1FIVHZLZmRuQkx2UkQrcXhFbDg2anV6Y3dtMzRBOEZkYTJU?=
 =?utf-8?B?aVpKK2RhV1VUTUd6THJycmpOaFlPZzE1ekY5UlRrYjB0WW4zNC9INjY5U01J?=
 =?utf-8?B?WDIvYitJdjcrQWRTYThkMFdLVzU0Sk81UEJ3MStDTHM2VWtJSHhXR1hDNnJE?=
 =?utf-8?B?U2o5cTQ4dXFsZnRGZ0VOdjhQZVpZKzc4N2FUTFgyNXVvaGY4V2FXY2UwVFUw?=
 =?utf-8?B?SFdXcjg3L1RFckRaZFlDdmFha05hWUFXUmtNOTVsaVVkUnhIVk5CQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43bea318-d062-4393-1967-08de868dbe0d
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 14:34:07.1614 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uE46mL6fdeURjGrobgxA2qvv8RCLiWX/TeRLIGcQKyF9pgEKSRX+6yT/4aOk8Zqa3+E0iaNw6RFYpo/pHjLQog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6148
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

I think there is actually a very easy way to trigger it and it's not 
obvious that a user messed it up.

Assume you're on a 128GB system with VRAM set to 512MB.
1) Set TTM page limit corresponding to 96GB
2) Use uma_carveout sysfs or BIOS to set VRAM to 96GB
3) Reboot system
4) Now VRAM is 96GB, but the page limit was a module parameter and will 
be wrong.

I actually /think/ that the RFC [1] I proposed a few weeks ago could be 
a good way to prevent this.  By using EFI variable instead, TTM could 
sanity check anything it reads at startup and save sane values to EFI 
for the next reboot (if they're insane).

https://lore.kernel.org/dri-devel/20260306055439.1822879-1-mario.limonciello@amd.com/ 
[1]

On 3/20/2026 9:28 AM, Zhang, Yifan wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
> Yes, I agree. I’ve just been notified that this memory configuration is a mistake rather than a valid user case. So the fix is low priority for now.
> 
> -----Original Message-----
> From: Limonciello, Mario <Mario.Limonciello@amd.com>
> Sent: Friday, March 20, 2026 11:14 AM
> To: Zhang, Yifan <Yifan1.Zhang@amd.com>; amd-gfx@lists.freedesktop.org
> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>; Limonciello, Mario <Mario.Limonciello@amd.com>; Yuan, Perry <Perry.Yuan@amd.com>
> Subject: Re: [PATCH v2] drm/amdkfd: check system memory when set apu_prefer_gtt
> 
> 
> 
> On 3/19/2026 2:32 AM, Yifan Zhang wrote:
>> Current apu_prefer_gtt setting only check gtt_size, which could be set
>> by user to a larger than system memory value (via ttm modules
>> parameter pages_limit). E.g. carveout vram 32GB, gtt_size 50GB (via
>> ttm modules parameter pages_limit), system memory 31GB. In that case,
>> apu_prefer_gtt will be set incorrectly. Take system memory into
>> account when set apu_prefer_gtt.
>>
> 
> Wouldn't it be cleaner to do this in TTM?  IE test that a bad option was set by user pages_limit value and then show something like:
> 
> if (user > possible) {
>       pr_warn("Requested invalid %d pages, limiting to %d pages", user, possible);
>       user = possible;
> }
> 
> Then we can always trust what we get from TTM.
> 
>> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
>> ---
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c       | 2 --
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h       | 4 ++--
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 6 ++++--
>>    drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c          | 7 ++++++-
>>    4 files changed, 12 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>> index 3bfd79c89df3..a6ee9d9bfafb 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>> @@ -170,8 +170,6 @@ void amdgpu_amdkfd_device_init(struct amdgpu_device *adev)
>>        int i;
>>        int last_valid_bit;
>>
>> -     amdgpu_amdkfd_gpuvm_init_mem_limits();
>> -
>>        if (adev->kfd.dev) {
>>                struct kgd2kfd_shared_resources gpu_resources = {
>>                        .compute_vmid_bitmap =
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>> index cdbab7f8cee8..13cada7da4a9 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>> @@ -369,7 +369,7 @@ u64 amdgpu_amdkfd_xcp_memory_size(struct
>> amdgpu_device *adev, int xcp_id);
>>
>>
>>    #if IS_ENABLED(CONFIG_HSA_AMD)
>> -void amdgpu_amdkfd_gpuvm_init_mem_limits(void);
>> +uint64_t amdgpu_amdkfd_gpuvm_init_mem_limits(void);
>>    void amdgpu_amdkfd_gpuvm_destroy_cb(struct amdgpu_device *adev,
>>                                struct amdgpu_vm *vm);
>>
>> @@ -382,7 +382,7 @@ void amdgpu_amdkfd_release_notify(struct amdgpu_bo *bo);
>>    void amdgpu_amdkfd_reserve_system_mem(uint64_t size);
>>    #else
>>    static inline
>> -void amdgpu_amdkfd_gpuvm_init_mem_limits(void)
>> +uint64_t amdgpu_amdkfd_gpuvm_init_mem_limits(void)
>>    {
>>    }
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> index 8a869fe41acd..4fba7d2f34a9 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>> @@ -109,13 +109,13 @@ static bool reuse_dmamap(struct amdgpu_device *adev, struct amdgpu_device *bo_ad
>>     *  System (TTM + userptr) memory - 15/16th System RAM
>>     *  TTM memory - 3/8th System RAM
>>     */
>> -void amdgpu_amdkfd_gpuvm_init_mem_limits(void)
>> +uint64_t amdgpu_amdkfd_gpuvm_init_mem_limits(void)
>>    {
>>        struct sysinfo si;
>>        uint64_t mem;
>>
>>        if (kfd_mem_limit.max_system_mem_limit)
>> -             return;
>> +             return kfd_mem_limit.max_system_mem_limit;
>>
>>        si_meminfo(&si);
>>        mem = si.totalram - si.totalhigh;
>> @@ -132,6 +132,8 @@ void amdgpu_amdkfd_gpuvm_init_mem_limits(void)
>>        pr_debug("Kernel memory limit %lluM, TTM limit %lluM\n",
>>                (kfd_mem_limit.max_system_mem_limit >> 20),
>>                (kfd_mem_limit.max_ttm_mem_limit >> 20));
>> +
>> +     return kfd_mem_limit.max_system_mem_limit;
>>    }
>>
>>    void amdgpu_amdkfd_reserve_system_mem(uint64_t size) diff --git
>> a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> index 714fd8d12ca5..df98ece071e1 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
>> @@ -2071,6 +2071,7 @@ static void amdgpu_ttm_buffer_entity_fini(struct amdgpu_gtt_mgr *mgr,
>>    int amdgpu_ttm_init(struct amdgpu_device *adev)
>>    {
>>        uint64_t gtt_size;
>> +     uint64_t max_system_mem_limit;
>>        int r;
>>
>>        dma_set_max_seg_size(adev->dev, UINT_MAX); @@ -2210,8 +2211,12 @@
>> int amdgpu_ttm_init(struct amdgpu_device *adev)
>>        dev_info(adev->dev, " %uM of GTT memory ready.\n",
>>                 (unsigned int)(gtt_size / (1024 * 1024)));
>>
>> +
>> +     max_system_mem_limit = amdgpu_amdkfd_gpuvm_init_mem_limits();
>> +
>>        if (adev->flags & AMD_IS_APU) {
>> -             if (adev->gmc.real_vram_size < gtt_size)
>> +             if (adev->gmc.real_vram_size < gtt_size &&
>> +                     adev->gmc.real_vram_size < max_system_mem_limit)
>>                        adev->apu_prefer_gtt = true;
>>        }
>>
> 

