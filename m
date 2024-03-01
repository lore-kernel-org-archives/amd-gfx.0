Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36453C5478C
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Mar 2024 18:30:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C5F310E627;
	Fri,  1 Mar 2024 18:29:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jwlgTdEc";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC10A10E869
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Mar 2024 18:29:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I4TVR66v/XUgEoLKWM7Ja+wlejXLCm4vyybd4om/gJIMRYCnIHhQ4FUmglr4PRAYga9JR+0Ul2zFYNSzw3pUdv9IDWqDCNo1Xl5SfV6PrPRGxONq1TgfXh9Fduxj/z90VBq9J82+37R5+GwxdFOG56C9pAEBEzqqOyhaPARFFCEkljCePnTJOPzmKvm3/fcnyX6H61GWqLQFvvRkVI0jFiV2M/NTWik03UXpHHVV8hq7E2GePNCNxoaEzjnu7XrrPYnIMG1FL8WcJOUxL1gHlQJ01Q4MbrDiyjUjVt6VA79rwp7J9VjqXf4P5IBB3om775G9ptiM/egHIx6EoPHmfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V5Im8ZYNOJ2ObtaNKTA5BKcYU4olPiaKeduijbcg5Rk=;
 b=E65sABwCSz4EpOyiBjqiZUyN9TtBMOt4LrQeuio1Sj93eu2uyc91PuAzLLczZQueEJ8qdJ4iWfhR6c/h4zH6AaDe0MH4mq2GPVVOUbLj45Vw+PM+uCQPHube3e8izYY4mmw03UspAQgFodLGq4AgZbwI05rrrnDrSqGMNNl1RqLAKoNgpC6NopPMAUYZ2KmLzPvx5/06gBOb4HzRYnus9RlXmMJeDcy56+75LH0lwckaXpMpwoy9J7iRBJLvgFspaLVQ6G+seB8ZTs8R2tBxCOn0QpkR//UZ7GQf4Zm/jj03KqafgZKg355epki8rIrThXzQNeLTYSvpiFb/QYYiDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V5Im8ZYNOJ2ObtaNKTA5BKcYU4olPiaKeduijbcg5Rk=;
 b=jwlgTdEcDogxYiq1iVHJgCGJ2Cyr6kC1EkziIMzc30u6Ej6Y2rPHUn8UV36m9S1+hGJv6aaD5DTmMZSUyjIeIypac7Dm4cg+Qo6xxHQxs0Z7Y+l/oBNeJZL0qJM8rWe8NyKCz6yf1+qjG8uHMAO9E2yu6btJNapdARByNt7x23k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB5673.namprd12.prod.outlook.com (2603:10b6:a03:42b::13)
 by CH3PR12MB8901.namprd12.prod.outlook.com (2603:10b6:610:180::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.39; Fri, 1 Mar
 2024 18:29:54 +0000
Received: from SJ0PR12MB5673.namprd12.prod.outlook.com
 ([fe80::ff7e:b189:da4c:dab2]) by SJ0PR12MB5673.namprd12.prod.outlook.com
 ([fe80::ff7e:b189:da4c:dab2%6]) with mapi id 15.20.7316.037; Fri, 1 Mar 2024
 18:29:53 +0000
Content-Type: multipart/alternative;
 boundary="------------cBqVg5qO0H9zsAzR6IR1kQ5I"
Message-ID: <479d8b2b-b374-e882-7619-4cb970c5a554@amd.com>
Date: Fri, 1 Mar 2024 19:29:49 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v3] drm/amdgpu: change vm->task_info handling
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Christian Koenig <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
References: <20240205170508.974-1-shashank.sharma@amd.com>
 <486845c4-192c-47e5-9a18-b1497578c260@amd.com>
From: "Sharma, Shashank" <shashank.sharma@amd.com>
In-Reply-To: <486845c4-192c-47e5-9a18-b1497578c260@amd.com>
X-ClientProxiedBy: FR0P281CA0060.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::17) To SJ0PR12MB5673.namprd12.prod.outlook.com
 (2603:10b6:a03:42b::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5673:EE_|CH3PR12MB8901:EE_
X-MS-Office365-Filtering-Correlation-Id: 469f9baf-b492-48ef-95b9-08dc3a1d9699
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G1oHDZolXZ8JDZ526KMYC1SfkMwK3InvjNSHcq5JwkGfcFCpxlwbk4yRt/gJQe+v9qi1+WVIHCUSQB1q2V+Sq8fFQvSDfOUjtxbwqtQq85WDCHHGA/aQ/imc4NwZu6JkeSYT2gb9DZQC6h1zLuZzonDdQu1VTIxVbDJW3jg1kwvToeYMNDUbeHSMcCiNuYXif+N3WLzGIxhT6wAgudn0gU7qFgEWAxfHz/tP2ruGDmK46tkrI0DZKHthWbHwpaS29kVNb/Sn9v9NAHJ1ayYc+v7AnoOCrFKiU0LftHIVcpa7tuLdouXRZeboDaRd3D3g5ICLjGiwEZ8XSjvefq04LInuvF5/O+IbOlqRc5+oQDPrO1GILAdW8yGXNA4dKqLqw/Cw/ES2xmBbyNaBX3hO2v7EJ/OGDAetTJAiikRtS8/ffvwU4lkWdA1/jIXA8/vHnEZdkMABckbwa7R3YVOLoCWRWqg442KMn3Iyn0BUImxh6Td+Le+3rXnlFyZoQGIg7MTcgWjM/JQMOtPzNaLOc8nS6Y/jtWvsJ99Cfm9on6S3fns/MQJZ5cbMNurv7xJtP4afmDUpM2mYSobXA2WgTlmhM9YQYS4epyTOyQOMU1L/8c/FIBGjtwIWxJxIUVFT
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB5673.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QThRYWFuVmE1elZReGxvQ050N2s1WlFsanVPNC83QVA5b2pOektkT2YxUnBW?=
 =?utf-8?B?OVFpd3BiY2V6S2V4cy9xOTdGcUw4TzVXSmNZTDdQck4yY0RSZTdXZGErSGZY?=
 =?utf-8?B?MHBubVZyaU9LakpTUUlCMUNjUXZlSHdDSlV5eUIvWnJOcThzUFNjZWJxVmdU?=
 =?utf-8?B?cEdFL09QYzdNVEFUa1NGbk9NSWJmVTlCRE42SlFIek5mQlA0L2N4b3k3RVd5?=
 =?utf-8?B?dXd0ejFUT05xb0RlazJWaVJqNHVyZ2h2VTBOOHhxK2xrRkFFKzJ0VVhsaHB3?=
 =?utf-8?B?RldpQkxCVDJtUWFuOVQ2ME1RNHdDZ2dFbVpjT2RLdm1kTmQ4RWxmTGZ3ckxZ?=
 =?utf-8?B?OEhBaWJVZmQ5MVBCU0puaWtrdElZRWlyOEx4MlVXcmRGVXJVc2VwQkRZemlT?=
 =?utf-8?B?WmFuRWlHKzlHaWhLQ2V5YzBmb0tkaXJjdTlMMHFWd3JCVHF3VGVYY0pxZTFW?=
 =?utf-8?B?cXBFeFdxd01HQzVnZnhsUlY2S0E1clZmOE9HV1RNck5ubE9JMGw4VHc3T214?=
 =?utf-8?B?TkxuaWhtdjJjc2hNZkU5d0xYbDNTWVlyVnc0dmNWaHczTXNHOGxpSTZVcmpV?=
 =?utf-8?B?Uzh3Wms1S0RSMzVDN0k3WG5hYUIrY0hGR3NPdUthVXorMDBXaGpkSjlUVmVh?=
 =?utf-8?B?LzkwVjljeXQwdGoycGNGbitXWk9JZ3B5ZnpXN3lmc2hCbUNEL2FDWkhTRm05?=
 =?utf-8?B?V2graUphSWlQVnBzUnUzaUZkaW5tWmM3K3ZSOFhqV1c3NzlRSzB2WDcyVjgy?=
 =?utf-8?B?RWZ2WlBxTFNHeXFxZTJFb3U4ME1NM2RmcUpxSlIzekFLQXpvZFRaUVJZQlcy?=
 =?utf-8?B?Q1kyaWp2V2F2eUVSckhLdFQwZFk1ZHR4NHNNS0ZQV1B4UjgwRHRqaFp3TUpJ?=
 =?utf-8?B?Q0NsWi96NDhUT3Jtb0pGR1NzekF5VGsxekk3T0dLdWdhV2xwR01wamV3SzA0?=
 =?utf-8?B?YVFPK0MzeHdHbmJnOWl4N1RlMXJVd1RVcXBUaHp6aURPWEQyZ09hMlg0TG5H?=
 =?utf-8?B?TkhYK2J5T0lzT0pLVEhhbTliS2gzTm1OU3M0NGlvditGVTBGNmJpK1V1ei9T?=
 =?utf-8?B?cUZzZUJNRlhBWmF3TnNTTHhOdE93SEd0TWwvd2dyRDZrT0RGcnBhZS96WW5h?=
 =?utf-8?B?RVNoNkl6VTY1Mk5wK2taWndJa09WUFpBbmJoaVlWVlYrZzU2UTlwOWtmYWRP?=
 =?utf-8?B?dW8yUytDMDB3MEhTdkUxSmphRDBxbm5VK1ArUTM0QjE0NnRLT3MyT0Rldzcr?=
 =?utf-8?B?OXdYU1phTjNoL3dKU3h3bGNMaEhiZ0F4cTRmRjU5cW5vM1R3NlVYTjVBL25h?=
 =?utf-8?B?QVdxSnZacERYOW0yc0FhRnFnd0dranBFYUNNaElZVXk5MEp4MXRYSFI0alRG?=
 =?utf-8?B?VTJpck9NVzZEZXdkRkg2R2NvZXdidVZPbmkvSGMxTk5vTzdCSTFKdmo3U0Zv?=
 =?utf-8?B?T2tmcUtPcS95eHJ6N3dobXlwS3g4Y0lUZ2k3T0l0eXVudjJzTzluanlzY3Yr?=
 =?utf-8?B?RUlrZzBsTXpWTGd0RVE4RmhMeWlwRXVHeEg5dlVnb04reWcxbFhHV3FvdEdH?=
 =?utf-8?B?RlJUN3hqeG5qTC9MT3pabkZsTHRlOXJyNWd1dWRKM1E2akZ0YmRuMjFXZ2wy?=
 =?utf-8?B?YldZU09hUTlaL1I4ckVSTHh5Q2V5c1FWSmNwMEppUGVKWlJoSXl6aU52Zk50?=
 =?utf-8?B?K1NrWlJDWThZamt3UU4xU09KWkxSVFFhcEdpZDNSQkRxanZpaEJNM1FDbGhv?=
 =?utf-8?B?eGhlK1ovbzlCS28xV2RoMXN4dEUvZXFKL2VLRW9OcXMxNXgwRnczV3hjR25P?=
 =?utf-8?B?UytEZk9hN1NXUlYyUjN2OHpoQjlXekZXTVRjd0VJbStJNVp0N0IvR0VtTmNU?=
 =?utf-8?B?My9OU1JpQzY5Vy82ODRlM2ZyVXFKRG5wVzAyc3dJNFh6VU9kUUJFMm5UbStQ?=
 =?utf-8?B?NUd2Zmw2aS9BaURZa1FKMWFqRWlkek1kbUg5UVdvK2NYWXg2ZTlLTlhzbXEw?=
 =?utf-8?B?TWVIRFo2K1Q2dmZIL2lFT0VKMXovSlQxQ2VjcXd1amR1OG4xTVl2cjRRTDNq?=
 =?utf-8?B?ekQ4RGthNGpWWHJjWlBpcnVPRFZIZjU0a1VGVFAyaU5paWVCRDRtZkwvMkpy?=
 =?utf-8?Q?3u1NOHpvyopcpwFcM3sGPcwve?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 469f9baf-b492-48ef-95b9-08dc3a1d9699
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5673.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2024 18:29:53.8526 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9sqtPEHlEOhUbfvY4a9KxaCaJ/+2Q2sZFlATNUVsNLHy2Jv/94qutT8tT0DXWUAvWBrNaSSaBPv+8DlIoJ/qhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8901
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

--------------cBqVg5qO0H9zsAzR6IR1kQ5I
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 01/03/2024 18:07, Felix Kuehling wrote:
> On 2024-02-05 12:05, Shashank Sharma wrote:
>> This patch changes the handling and lifecycle of vm->task_info object.
>> The major changes are:
>> - vm->task_info is a dynamically allocated ptr now, and its uasge is
>>    reference counted.
>> - introducing two new helper funcs for task_info lifecycle management
>>      - amdgpu_vm_get_task_info: reference counts up task_info before
>>        returning this info
>>      - amdgpu_vm_put_task_info: reference counts down task_info
>> - last put to task_info() frees task_info from the vm.
>>
>> This patch also does logistical changes required for existing usage
>> of vm->task_info.
>>
>> V2: Do not block all the prints when task_info not found (Felix)
>> V3: (Felix)
>>     - Fix wrong indentation
>>     - No debug message for -ENOMEM
>>     - Add NULL check for task_info
>>     - Do not duplicate the debug messages (ti vs no ti)
>>     - Get first reference of task_info in vm_init(), put last
>>       in vm_fini()
>>
>> Cc: Christian Koenig<christian.koenig@amd.com>
>> Cc: Alex Deucher<alexander.deucher@amd.com>
>> Cc: Felix Kuehling<Felix.Kuehling@amd.com>
>> Signed-off-by: Shashank Sharma<shashank.sharma@amd.com>
>
> One nit-pick and one bug inline. With those fixed, the patch
>
> Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>
>
>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |   9 +-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_job.c     |  18 ++-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c   |  12 +-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c      | 158 ++++++++++++++------
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h      |  21 ++-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c   |   2 +-
>>   drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c      |  24 +--
>>   drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c      |  23 +--
>>   drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c       |  20 ++-
>>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c       |  23 +--
>>   drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c      |  23 +--
>>   drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c    |  22 +--
>>   drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c |  20 +--
>>   13 files changed, 251 insertions(+), 124 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>> index 0e61ebdb3f3e..f9eb12697b95 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>> @@ -1775,9 +1775,14 @@ static int amdgpu_debugfs_vm_info_show(struct seq_file *m, void *unused)
>>   	list_for_each_entry(file, &dev->filelist, lhead) {
>>   		struct amdgpu_fpriv *fpriv = file->driver_priv;
>>   		struct amdgpu_vm *vm = &fpriv->vm;
>> +		struct amdgpu_task_info *ti;
>> +
>> +		ti = amdgpu_vm_get_task_info_vm(vm);
>> +		if (ti) {
>> +			seq_printf(m, "pid:%d\tProcess:%s ----------\n", ti->pid, ti->process_name);
>> +			amdgpu_vm_put_task_info(ti);
>> +		}
>>   
>> -		seq_printf(m, "pid:%d\tProcess:%s ----------\n",
>> -				vm->task_info.pid, vm->task_info.process_name);
>>   		r = amdgpu_bo_reserve(vm->root.bo, true);
>>   		if (r)
>>   			break;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>> index 1f357198533f..e6e6d56398f2 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>> @@ -35,7 +35,7 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
>>   {
>>   	struct amdgpu_ring *ring = to_amdgpu_ring(s_job->sched);
>>   	struct amdgpu_job *job = to_amdgpu_job(s_job);
>> -	struct amdgpu_task_info ti;
>> +	struct amdgpu_task_info *ti;
>>   	struct amdgpu_device *adev = ring->adev;
>>   	int idx;
>>   	int r;
>> @@ -48,7 +48,7 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
>>   		return DRM_GPU_SCHED_STAT_ENODEV;
>>   	}
>>   
>> -	memset(&ti, 0, sizeof(struct amdgpu_task_info));
>> +
>>   	adev->job_hang = true;
>>   
>>   	if (amdgpu_gpu_recovery &&
>> @@ -58,12 +58,16 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
>>   		goto exit;
>>   	}
>>   
>> -	amdgpu_vm_get_task_info(ring->adev, job->pasid, &ti);
>>   	DRM_ERROR("ring %s timeout, signaled seq=%u, emitted seq=%u\n",
>> -		  job->base.sched->name, atomic_read(&ring->fence_drv.last_seq),
>> -		  ring->fence_drv.sync_seq);
>> -	DRM_ERROR("Process information: process %s pid %d thread %s pid %d\n",
>> -		  ti.process_name, ti.tgid, ti.task_name, ti.pid);
>> +		   job->base.sched->name, atomic_read(&ring->fence_drv.last_seq),
>> +		   ring->fence_drv.sync_seq);
>> +
>> +	ti = amdgpu_vm_get_task_info_pasid(ring->adev, job->pasid);
>> +	if (ti) {
>> +		DRM_ERROR("Process information: process %s pid %d thread %s pid %d\n",
>> +			  ti->process_name, ti->tgid, ti->task_name, ti->pid);
>> +		amdgpu_vm_put_task_info(ti);
>> +	}
>>   
>>   	dma_fence_set_error(&s_job->s_fence->finished, -ETIME);
>>   
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
>> index 4baa300121d8..a59364e9b6ed 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
>> @@ -230,8 +230,16 @@ void amdgpu_coredump(struct amdgpu_device *adev, bool vram_lost,
>>   
>>   	coredump->reset_vram_lost = vram_lost;
>>   
>> -	if (reset_context->job && reset_context->job->vm)
>> -		coredump->reset_task_info = reset_context->job->vm->task_info;
>> +	if (reset_context->job && reset_context->job->vm) {
>> +		struct amdgpu_task_info *ti;
>> +		struct amdgpu_vm *vm = reset_context->job->vm;
>> +
>> +		ti = amdgpu_vm_get_task_info_vm(vm);
>> +		if (ti) {
>> +			coredump->reset_task_info = *ti;
>> +			amdgpu_vm_put_task_info(ti);
>> +		}
>> +	}
>>   
>>   	coredump->adev = adev;
>>   
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> index d1b8afd105c9..8414567af683 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> @@ -2127,6 +2127,117 @@ long amdgpu_vm_wait_idle(struct amdgpu_vm *vm, long timeout)
>>   	return dma_fence_wait_timeout(vm->last_unlocked, true, timeout);
>>   }
>>   
>> +static void amdgpu_vm_destroy_task_info(struct kref *kref)
>> +{
>> +	struct amdgpu_task_info *ti = container_of(kref, struct amdgpu_task_info, refcount);
>> +
>> +	kfree(ti);
>> +}
>> +
>> +static inline struct amdgpu_vm *
>> +amdgpu_vm_get_vm_from_pasid(struct amdgpu_device *adev, u32 pasid)
>> +{
>> +	struct amdgpu_vm *vm;
>> +	unsigned long flags;
>> +
>> +	xa_lock_irqsave(&adev->vm_manager.pasids, flags);
>> +	vm = xa_load(&adev->vm_manager.pasids, pasid);
>> +	xa_unlock_irqrestore(&adev->vm_manager.pasids, flags);
>> +
>> +	return vm;
>> +}
>> +
>> +/**
>> + * amdgpu_vm_put_task_info - reference down the vm task_info ptr
>> + *
>> + * @task_info: task_info struct under discussion.
>> + *
>> + * frees the vm task_info ptr at the last put
>> + */
>> +void amdgpu_vm_put_task_info(struct amdgpu_task_info *task_info)
>> +{
>> +	kref_put(&task_info->refcount, amdgpu_vm_destroy_task_info);
>> +}
>> +
>> +/**
>> + * amdgpu_vm_get_task_info_pasid - Extracts task info for a PASID.
>> + *
>> + * @adev: drm device pointer
>> + * @pasid: PASID identifier for VM
>> + *
>> + * Returns the reference counted task_info structure, which must be
>> + * referenced down with amdgpu_vm_put_task_info.
>> + */
>> +struct amdgpu_task_info *
>> +amdgpu_vm_get_task_info_pasid(struct amdgpu_device *adev, u32 pasid)
>> +{
>> +	struct amdgpu_vm *vm;
>> +	struct amdgpu_task_info *ti = NULL;
>> +
>> +	vm = amdgpu_vm_get_vm_from_pasid(adev, pasid);
>> +	if (vm) {
>> +		ti = vm->task_info;
>> +		kref_get(&vm->task_info->refcount);
>> +	}
>
> This could be more concise and elegant if you implemented it in terms 
> of amdgpu_vm_get_task_info_vm. I.e.:
>
> 	return amdgpu_vm_get_task_info_vm(
> 		amdgpu_vm_get_vm_from_pasid(adev, pasid));

Certainly looks better this way.

>
>> +
>> +	return ti;
>> +}
>> +
>> +/**
>> + * amdgpu_vm_get_task_info_vm - Extracts task info for a vm.
>> + *
>> + * @vm: VM to get info from
>> + *
>> + * Returns the reference counted task_info structure, which must be
>> + * referenced down with amdgpu_vm_put_task_info.
>> + */
>> +struct amdgpu_task_info *
>> +amdgpu_vm_get_task_info_vm(struct amdgpu_vm *vm)
>> +{
>> +	struct amdgpu_task_info *ti = NULL;
>> +
>> +	if (vm) {
>> +		ti = vm->task_info;
>> +		kref_get(&vm->task_info->refcount);
>> +	}
>> +
>> +	return ti;
>> +}
>> +
>> +static int amdgpu_vm_create_task_info(struct amdgpu_vm *vm)
>> +{
>> +	vm->task_info = kzalloc(sizeof(struct amdgpu_task_info), GFP_KERNEL);
>> +	if (!vm->task_info)
>> +		return -ENOMEM;
>> +
>> +	kref_init(&vm->task_info->refcount);
>> +	kref_get(&vm->task_info->refcount);
>
> kref_init initializes the refcount to 1. I don't think you should to 
> take another reference here because that reference never gets released.
>
Thanks for this input, I wasn't aware of this and I realized the destroy 
function was never getting called due to this. After fixing this it is 
getting called properly.

I will do this change and push the patch.

- Shashank

> Regards,
>   Felix
>
>
>> +	return 0;
>> +}
>> +
>> +/**
>> + * amdgpu_vm_set_task_info - Sets VMs task info.
>> + *
>> + * @vm: vm for which to set the info
>> + */
>> +void amdgpu_vm_set_task_info(struct amdgpu_vm *vm)
>> +{
>> +	if (!vm->task_info)
>> +		return;
>> +
>> +	if (vm->task_info->pid == current->pid)
>> +		return;
>> +
>> +	vm->task_info->pid = current->pid;
>> +	get_task_comm(vm->task_info->task_name, current);
>> +
>> +	if (current->group_leader->mm != current->mm)
>> +		return;
>> +
>> +	vm->task_info->tgid = current->group_leader->pid;
>> +	get_task_comm(vm->task_info->process_name, current->group_leader);
>> +}
>> +
>>   /**
>>    * amdgpu_vm_init - initialize a vm instance
>>    *
>> @@ -2212,6 +2323,10 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>>   	if (r)
>>   		goto error_free_root;
>>   
>> +	r = amdgpu_vm_create_task_info(vm);
>> +	if (r)
>> +		DRM_DEBUG("Failed to create task info for VM\n");
>> +
>>   	amdgpu_bo_unreserve(vm->root.bo);
>>   	amdgpu_bo_unref(&root_bo);
>>   
>> @@ -2351,6 +2466,7 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>>   
>>   	root = amdgpu_bo_ref(vm->root.bo);
>>   	amdgpu_bo_reserve(root, true);
>> +	amdgpu_vm_put_task_info(vm->task_info);
>>   	amdgpu_vm_set_pasid(adev, vm, 0);
>>   	dma_fence_wait(vm->last_unlocked, false);
>>   	dma_fence_put(vm->last_unlocked);
>> @@ -2507,48 +2623,6 @@ int amdgpu_vm_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
>>   	return 0;
>>   }
>>   
>> -/**
>> - * amdgpu_vm_get_task_info - Extracts task info for a PASID.
>> - *
>> - * @adev: drm device pointer
>> - * @pasid: PASID identifier for VM
>> - * @task_info: task_info to fill.
>> - */
>> -void amdgpu_vm_get_task_info(struct amdgpu_device *adev, u32 pasid,
>> -			 struct amdgpu_task_info *task_info)
>> -{
>> -	struct amdgpu_vm *vm;
>> -	unsigned long flags;
>> -
>> -	xa_lock_irqsave(&adev->vm_manager.pasids, flags);
>> -
>> -	vm = xa_load(&adev->vm_manager.pasids, pasid);
>> -	if (vm)
>> -		*task_info = vm->task_info;
>> -
>> -	xa_unlock_irqrestore(&adev->vm_manager.pasids, flags);
>> -}
>> -
>> -/**
>> - * amdgpu_vm_set_task_info - Sets VMs task info.
>> - *
>> - * @vm: vm for which to set the info
>> - */
>> -void amdgpu_vm_set_task_info(struct amdgpu_vm *vm)
>> -{
>> -	if (vm->task_info.pid)
>> -		return;
>> -
>> -	vm->task_info.pid = current->pid;
>> -	get_task_comm(vm->task_info.task_name, current);
>> -
>> -	if (current->group_leader->mm != current->mm)
>> -		return;
>> -
>> -	vm->task_info.tgid = current->group_leader->pid;
>> -	get_task_comm(vm->task_info.process_name, current->group_leader);
>> -}
>> -
>>   /**
>>    * amdgpu_vm_handle_fault - graceful handling of VM faults.
>>    * @adev: amdgpu device pointer
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> index 2cd86d2bf73f..a74b94c3c9ba 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> @@ -190,10 +190,11 @@ struct amdgpu_vm_pte_funcs {
>>   };
>>   
>>   struct amdgpu_task_info {
>> -	char	process_name[TASK_COMM_LEN];
>> -	char	task_name[TASK_COMM_LEN];
>> -	pid_t	pid;
>> -	pid_t	tgid;
>> +	char		process_name[TASK_COMM_LEN];
>> +	char		task_name[TASK_COMM_LEN];
>> +	pid_t		pid;
>> +	pid_t		tgid;
>> +	struct kref	refcount;
>>   };
>>   
>>   /**
>> @@ -356,7 +357,7 @@ struct amdgpu_vm {
>>   	uint64_t		pd_phys_addr;
>>   
>>   	/* Some basic info about the task */
>> -	struct amdgpu_task_info task_info;
>> +	struct amdgpu_task_info *task_info;
>>   
>>   	/* Store positions of group of BOs */
>>   	struct ttm_lru_bulk_move lru_bulk_move;
>> @@ -492,8 +493,14 @@ bool amdgpu_vm_need_pipeline_sync(struct amdgpu_ring *ring,
>>   				  struct amdgpu_job *job);
>>   void amdgpu_vm_check_compute_bug(struct amdgpu_device *adev);
>>   
>> -void amdgpu_vm_get_task_info(struct amdgpu_device *adev, u32 pasid,
>> -			     struct amdgpu_task_info *task_info);
>> +struct amdgpu_task_info *
>> +amdgpu_vm_get_task_info_pasid(struct amdgpu_device *adev, u32 pasid);
>> +
>> +struct amdgpu_task_info *
>> +amdgpu_vm_get_task_info_vm(struct amdgpu_vm *vm);
>> +
>> +void amdgpu_vm_put_task_info(struct amdgpu_task_info *task_info);
>> +
>>   bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
>>   			    u32 vmid, u32 node_id, uint64_t addr,
>>   			    bool write_fault);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>> index a160265ddc07..d9e895cb0c10 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>> @@ -1027,7 +1027,7 @@ int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params *params,
>>   			trace_amdgpu_vm_update_ptes(params, frag_start, upd_end,
>>   						    min(nptes, 32u), dst, incr,
>>   						    upd_flags,
>> -						    vm->task_info.tgid,
>> +						    vm->task_info ? vm->task_info->tgid : 0,
>>   						    vm->immediate.fence_context);
>>   			amdgpu_vm_pte_update_flags(params, to_amdgpu_bo_vm(pt),
>>   						   cursor.level, pe_start, dst,
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>> index a5a05c16c10d..7098f0be83c7 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>> @@ -105,7 +105,7 @@ static int gmc_v10_0_process_interrupt(struct amdgpu_device *adev,
>>   	struct amdgpu_vmhub *hub = &adev->vmhub[vmhub_index];
>>   	bool retry_fault = !!(entry->src_data[1] & 0x80);
>>   	bool write_fault = !!(entry->src_data[1] & 0x20);
>> -	struct amdgpu_task_info task_info;
>> +	struct amdgpu_task_info *task_info;
>>   	uint32_t status = 0;
>>   	u64 addr;
>>   
>> @@ -157,18 +157,22 @@ static int gmc_v10_0_process_interrupt(struct amdgpu_device *adev,
>>   	if (!printk_ratelimit())
>>   		return 0;
>>   
>> -	memset(&task_info, 0, sizeof(struct amdgpu_task_info));
>> -	amdgpu_vm_get_task_info(adev, entry->pasid, &task_info);
>> -
>>   	dev_err(adev->dev,
>> -		"[%s] page fault (src_id:%u ring:%u vmid:%u pasid:%u, for process %s pid %d thread %s pid %d)\n",
>> +		"[%s] page fault (src_id:%u ring:%u vmid:%u pasid:%u)\n",
>>   		entry->vmid_src ? "mmhub" : "gfxhub",
>> -		entry->src_id, entry->ring_id, entry->vmid,
>> -		entry->pasid, task_info.process_name, task_info.tgid,
>> -		task_info.task_name, task_info.pid);
>> +		entry->src_id, entry->ring_id, entry->vmid, entry->pasid);
>> +	task_info = amdgpu_vm_get_task_info_pasid(adev, entry->pasid);
>> +	if (task_info) {
>> +		dev_err(adev->dev,
>> +			" in process %s pid %d thread %s pid %d\n",
>> +			task_info->process_name, task_info->tgid,
>> +			task_info->task_name, task_info->pid);
>> +		amdgpu_vm_put_task_info(task_info);
>> +	}
>> +
>>   	dev_err(adev->dev, "  in page starting at address 0x%016llx from client 0x%x (%s)\n",
>> -		addr, entry->client_id,
>> -		soc15_ih_clientid_name[entry->client_id]);
>> +			addr, entry->client_id,
>> +			soc15_ih_clientid_name[entry->client_id]);
>>   
>>   	if (!amdgpu_sriov_vf(adev))
>>   		hub->vmhub_funcs->print_l2_protection_fault_status(adev,
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
>> index 23d7b548d13f..bff88070bb00 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
>> @@ -126,19 +126,24 @@ static int gmc_v11_0_process_interrupt(struct amdgpu_device *adev,
>>   	}
>>   
>>   	if (printk_ratelimit()) {
>> -		struct amdgpu_task_info task_info;
>> -
>> -		memset(&task_info, 0, sizeof(struct amdgpu_task_info));
>> -		amdgpu_vm_get_task_info(adev, entry->pasid, &task_info);
>> +		struct amdgpu_task_info *task_info;
>>   
>>   		dev_err(adev->dev,
>> -			"[%s] page fault (src_id:%u ring:%u vmid:%u pasid:%u, for process %s pid %d thread %s pid %d)\n",
>> +			"[%s] page fault (src_id:%u ring:%u vmid:%u pasid:%u)\n",
>>   			entry->vmid_src ? "mmhub" : "gfxhub",
>> -			entry->src_id, entry->ring_id, entry->vmid,
>> -			entry->pasid, task_info.process_name, task_info.tgid,
>> -			task_info.task_name, task_info.pid);
>> +			entry->src_id, entry->ring_id, entry->vmid, entry->pasid);
>> +		task_info = amdgpu_vm_get_task_info_pasid(adev, entry->pasid);
>> +		if (task_info) {
>> +			dev_err(adev->dev,
>> +				" in process %s pid %d thread %s pid %d)\n",
>> +				task_info->process_name, task_info->tgid,
>> +				task_info->task_name, task_info->pid);
>> +			amdgpu_vm_put_task_info(task_info);
>> +		}
>> +
>>   		dev_err(adev->dev, "  in page starting at address 0x%016llx from client %d\n",
>> -			addr, entry->client_id);
>> +				addr, entry->client_id);
>> +
>>   		if (!amdgpu_sriov_vf(adev))
>>   			hub->vmhub_funcs->print_l2_protection_fault_status(adev, status);
>>   	}
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
>> index ff4ae73d27ec..ba1f18978487 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
>> @@ -1444,18 +1444,24 @@ static int gmc_v8_0_process_interrupt(struct amdgpu_device *adev,
>>   		gmc_v8_0_set_fault_enable_default(adev, false);
>>   
>>   	if (printk_ratelimit()) {
>> -		struct amdgpu_task_info task_info;
>> +		struct amdgpu_task_info *task_info;
>>   
>> -		memset(&task_info, 0, sizeof(struct amdgpu_task_info));
>> -		amdgpu_vm_get_task_info(adev, entry->pasid, &task_info);
>> +		dev_err(adev->dev, "GPU fault detected: %d 0x%08x\n",
>> +			entry->src_id, entry->src_data[0]);
>> +
>> +		task_info = amdgpu_vm_get_task_info_pasid(adev, entry->pasid);
>> +		if (task_info) {
>> +			dev_err(adev->dev, " for process %s pid %d thread %s pid %d\n",
>> +				task_info->process_name, task_info->tgid,
>> +				task_info->task_name, task_info->pid);
>> +			amdgpu_vm_put_task_info(task_info);
>> +		}
>>   
>> -		dev_err(adev->dev, "GPU fault detected: %d 0x%08x for process %s pid %d thread %s pid %d\n",
>> -			entry->src_id, entry->src_data[0], task_info.process_name,
>> -			task_info.tgid, task_info.task_name, task_info.pid);
>>   		dev_err(adev->dev, "  VM_CONTEXT1_PROTECTION_FAULT_ADDR   0x%08X\n",
>> -			addr);
>> +				addr);
>>   		dev_err(adev->dev, "  VM_CONTEXT1_PROTECTION_FAULT_STATUS 0x%08X\n",
>>   			status);
>> +
>>   		gmc_v8_0_vm_decode_fault(adev, status, addr, mc_client,
>>   					 entry->pasid);
>>   	}
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>> index 2ac5820e9c92..cc0968f553a1 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>> @@ -549,7 +549,7 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
>>   	bool retry_fault = !!(entry->src_data[1] & 0x80);
>>   	bool write_fault = !!(entry->src_data[1] & 0x20);
>>   	uint32_t status = 0, cid = 0, rw = 0;
>> -	struct amdgpu_task_info task_info;
>> +	struct amdgpu_task_info *task_info;
>>   	struct amdgpu_vmhub *hub;
>>   	const char *mmhub_cid;
>>   	const char *hub_name;
>> @@ -626,15 +626,20 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
>>   	if (!printk_ratelimit())
>>   		return 0;
>>   
>> -	memset(&task_info, 0, sizeof(struct amdgpu_task_info));
>> -	amdgpu_vm_get_task_info(adev, entry->pasid, &task_info);
>> -
>>   	dev_err(adev->dev,
>> -		"[%s] %s page fault (src_id:%u ring:%u vmid:%u pasid:%u, for process %s pid %d thread %s pid %d)\n",
>> -		hub_name, retry_fault ? "retry" : "no-retry",
>> -		entry->src_id, entry->ring_id, entry->vmid,
>> -		entry->pasid, task_info.process_name, task_info.tgid,
>> -		task_info.task_name, task_info.pid);
>> +		"[%s] %s page fault (src_id:%u ring:%u vmid:%u pasid:%u)\n", hub_name,
>> +		retry_fault ? "retry" : "no-retry",
>> +		entry->src_id, entry->ring_id, entry->vmid, entry->pasid);
>> +
>> +	task_info = amdgpu_vm_get_task_info_pasid(adev, entry->pasid);
>> +	if (task_info) {
>> +		dev_err(adev->dev,
>> +			" for process %s pid %d thread %s pid %d)\n",
>> +			task_info->process_name, task_info->tgid,
>> +			task_info->task_name, task_info->pid);
>> +		amdgpu_vm_put_task_info(task_info);
>> +	}
>> +
>>   	dev_err(adev->dev, "  in page starting at address 0x%016llx from IH client 0x%x (%s)\n",
>>   		addr, entry->client_id,
>>   		soc15_ih_clientid_name[entry->client_id]);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
>> index 3d68dd5523c6..43775cb67ff5 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
>> @@ -2104,7 +2104,7 @@ static int sdma_v4_0_print_iv_entry(struct amdgpu_device *adev,
>>   					      struct amdgpu_iv_entry *entry)
>>   {
>>   	int instance;
>> -	struct amdgpu_task_info task_info;
>> +	struct amdgpu_task_info *task_info;
>>   	u64 addr;
>>   
>>   	instance = sdma_v4_0_irq_id_to_seq(entry->client_id);
>> @@ -2116,15 +2116,20 @@ static int sdma_v4_0_print_iv_entry(struct amdgpu_device *adev,
>>   	addr = (u64)entry->src_data[0] << 12;
>>   	addr |= ((u64)entry->src_data[1] & 0xf) << 44;
>>   
>> -	memset(&task_info, 0, sizeof(struct amdgpu_task_info));
>> -	amdgpu_vm_get_task_info(adev, entry->pasid, &task_info);
>> -
>>   	dev_dbg_ratelimited(adev->dev,
>> -		   "[sdma%d] address:0x%016llx src_id:%u ring:%u vmid:%u "
>> -		   "pasid:%u, for process %s pid %d thread %s pid %d\n",
>> -		   instance, addr, entry->src_id, entry->ring_id, entry->vmid,
>> -		   entry->pasid, task_info.process_name, task_info.tgid,
>> -		   task_info.task_name, task_info.pid);
>> +			   "[sdma%d] address:0x%016llx src_id:%u ring:%u vmid:%u pasid:%u\n",
>> +			   instance, addr, entry->src_id, entry->ring_id, entry->vmid,
>> +			   entry->pasid);
>> +
>> +	task_info = amdgpu_vm_get_task_info_pasid(adev, entry->pasid);
>> +	if (task_info) {
>> +		dev_dbg_ratelimited(adev->dev,
>> +				    " for process %s pid %d thread %s pid %d\n",
>> +				    task_info->process_name, task_info->tgid,
>> +				    task_info->task_name, task_info->pid);
>> +		amdgpu_vm_put_task_info(task_info);
>> +	}
>> +
>>   	return 0;
>>   }
>>   
>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
>> index 0f24af6f2810..51a17d7076ec 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
>> @@ -1642,7 +1642,7 @@ static int sdma_v4_4_2_print_iv_entry(struct amdgpu_device *adev,
>>   					      struct amdgpu_iv_entry *entry)
>>   {
>>   	int instance;
>> -	struct amdgpu_task_info task_info;
>> +	struct amdgpu_task_info *task_info;
>>   	u64 addr;
>>   
>>   	instance = sdma_v4_4_2_irq_id_to_seq(entry->client_id);
>> @@ -1654,15 +1654,19 @@ static int sdma_v4_4_2_print_iv_entry(struct amdgpu_device *adev,
>>   	addr = (u64)entry->src_data[0] << 12;
>>   	addr |= ((u64)entry->src_data[1] & 0xf) << 44;
>>   
>> -	memset(&task_info, 0, sizeof(struct amdgpu_task_info));
>> -	amdgpu_vm_get_task_info(adev, entry->pasid, &task_info);
>> -
>>   	dev_dbg_ratelimited(adev->dev,
>> -		   "[sdma%d] address:0x%016llx src_id:%u ring:%u vmid:%u "
>> -		   "pasid:%u, for process %s pid %d thread %s pid %d\n",
>> -		   instance, addr, entry->src_id, entry->ring_id, entry->vmid,
>> -		   entry->pasid, task_info.process_name, task_info.tgid,
>> -		   task_info.task_name, task_info.pid);
>> +			    "[sdma%d] address:0x%016llx src_id:%u ring:%u vmid:%u pasid:%u\n",
>> +			    instance, addr, entry->src_id, entry->ring_id, entry->vmid,
>> +			    entry->pasid);
>> +
>> +	task_info = amdgpu_vm_get_task_info_pasid(adev, entry->pasid);
>> +	if (task_info) {
>> +		dev_dbg_ratelimited(adev->dev, " for process %s pid %d thread %s pid %d\n",
>> +				    task_info->process_name, task_info->tgid,
>> +				    task_info->task_name, task_info->pid);
>> +		amdgpu_vm_put_task_info(task_info);
>> +	}
>> +
>>   	return 0;
>>   }
>>   
>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
>> index d9953c2b2661..06ac835190f9 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
>> @@ -238,16 +238,16 @@ void kfd_smi_event_update_thermal_throttling(struct kfd_node *dev,
>>   
>>   void kfd_smi_event_update_vmfault(struct kfd_node *dev, uint16_t pasid)
>>   {
>> -	struct amdgpu_task_info task_info;
>> -
>> -	memset(&task_info, 0, sizeof(struct amdgpu_task_info));
>> -	amdgpu_vm_get_task_info(dev->adev, pasid, &task_info);
>> -	/* Report VM faults from user applications, not retry from kernel */
>> -	if (!task_info.pid)
>> -		return;
>> -
>> -	kfd_smi_event_add(0, dev, KFD_SMI_EVENT_VMFAULT, "%x:%s\n",
>> -			  task_info.pid, task_info.task_name);
>> +	struct amdgpu_task_info *task_info;
>> +
>> +	task_info = amdgpu_vm_get_task_info_pasid(dev->adev, pasid);
>> +	if (task_info) {
>> +		/* Report VM faults from user applications, not retry from kernel */
>> +		if (task_info->pid)
>> +			kfd_smi_event_add(0, dev, KFD_SMI_EVENT_VMFAULT, "%x:%s\n",
>> +					 task_info->pid, task_info->task_name);
>> +		amdgpu_vm_put_task_info(task_info);
>> +	}
>>   }
>>   
>>   void kfd_smi_event_page_fault_start(struct kfd_node *node, pid_t pid,
--------------cBqVg5qO0H9zsAzR6IR1kQ5I
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 01/03/2024 18:07, Felix Kuehling
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:486845c4-192c-47e5-9a18-b1497578c260@amd.com">
      
      <div class="moz-cite-prefix">On 2024-02-05 12:05, Shashank Sharma
        wrote:<br>
      </div>
      <blockquote type="cite" cite="mid:20240205170508.974-1-shashank.sharma@amd.com">
        <pre class="moz-quote-pre" wrap="">This patch changes the handling and lifecycle of vm-&gt;task_info object.
The major changes are:
- vm-&gt;task_info is a dynamically allocated ptr now, and its uasge is
  reference counted.
- introducing two new helper funcs for task_info lifecycle management
    - amdgpu_vm_get_task_info: reference counts up task_info before
      returning this info
    - amdgpu_vm_put_task_info: reference counts down task_info
- last put to task_info() frees task_info from the vm.

This patch also does logistical changes required for existing usage
of vm-&gt;task_info.

V2: Do not block all the prints when task_info not found (Felix)
V3: (Felix)
   - Fix wrong indentation
   - No debug message for -ENOMEM
   - Add NULL check for task_info
   - Do not duplicate the debug messages (ti vs no ti)
   - Get first reference of task_info in vm_init(), put last
     in vm_fini()

Cc: Christian Koenig <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig@amd.com" moz-do-not-send="true">&lt;christian.koenig@amd.com&gt;</a>
Cc: Alex Deucher <a class="moz-txt-link-rfc2396E" href="mailto:alexander.deucher@amd.com" moz-do-not-send="true">&lt;alexander.deucher@amd.com&gt;</a>
Cc: Felix Kuehling <a class="moz-txt-link-rfc2396E" href="mailto:Felix.Kuehling@amd.com" moz-do-not-send="true">&lt;Felix.Kuehling@amd.com&gt;</a>
Signed-off-by: Shashank Sharma <a class="moz-txt-link-rfc2396E" href="mailto:shashank.sharma@amd.com" moz-do-not-send="true">&lt;shashank.sharma@amd.com&gt;</a></pre>
      </blockquote>
      <p>One nit-pick and one bug inline. With those fixed, the patch</p>
      <p>Reviewed-by: Felix Kuehling <a class="moz-txt-link-rfc2396E" href="mailto:felix.kuehling@amd.com" moz-do-not-send="true">&lt;felix.kuehling@amd.com&gt;</a><br>
      </p>
      <p><br>
      </p>
      <blockquote type="cite" cite="mid:20240205170508.974-1-shashank.sharma@amd.com">
        <pre class="moz-quote-pre" wrap="">---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |   9 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c     |  18 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c   |  12 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c      | 158 ++++++++++++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h      |  21 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c   |   2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c      |  24 +--
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c      |  23 +--
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c       |  20 ++-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c       |  23 +--
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c      |  23 +--
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c    |  22 +--
 drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c |  20 +--
 13 files changed, 251 insertions(+), 124 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 0e61ebdb3f3e..f9eb12697b95 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -1775,9 +1775,14 @@ static int amdgpu_debugfs_vm_info_show(struct seq_file *m, void *unused)
 	list_for_each_entry(file, &amp;dev-&gt;filelist, lhead) {
 		struct amdgpu_fpriv *fpriv = file-&gt;driver_priv;
 		struct amdgpu_vm *vm = &amp;fpriv-&gt;vm;
+		struct amdgpu_task_info *ti;
+
+		ti = amdgpu_vm_get_task_info_vm(vm);
+		if (ti) {
+			seq_printf(m, &quot;pid:%d\tProcess:%s ----------\n&quot;, ti-&gt;pid, ti-&gt;process_name);
+			amdgpu_vm_put_task_info(ti);
+		}
 
-		seq_printf(m, &quot;pid:%d\tProcess:%s ----------\n&quot;,
-				vm-&gt;task_info.pid, vm-&gt;task_info.process_name);
 		r = amdgpu_bo_reserve(vm-&gt;root.bo, true);
 		if (r)
 			break;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index 1f357198533f..e6e6d56398f2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -35,7 +35,7 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 {
 	struct amdgpu_ring *ring = to_amdgpu_ring(s_job-&gt;sched);
 	struct amdgpu_job *job = to_amdgpu_job(s_job);
-	struct amdgpu_task_info ti;
+	struct amdgpu_task_info *ti;
 	struct amdgpu_device *adev = ring-&gt;adev;
 	int idx;
 	int r;
@@ -48,7 +48,7 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 		return DRM_GPU_SCHED_STAT_ENODEV;
 	}
 
-	memset(&amp;ti, 0, sizeof(struct amdgpu_task_info));
+
 	adev-&gt;job_hang = true;
 
 	if (amdgpu_gpu_recovery &amp;&amp;
@@ -58,12 +58,16 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
 		goto exit;
 	}
 
-	amdgpu_vm_get_task_info(ring-&gt;adev, job-&gt;pasid, &amp;ti);
 	DRM_ERROR(&quot;ring %s timeout, signaled seq=%u, emitted seq=%u\n&quot;,
-		  job-&gt;base.sched-&gt;name, atomic_read(&amp;ring-&gt;fence_drv.last_seq),
-		  ring-&gt;fence_drv.sync_seq);
-	DRM_ERROR(&quot;Process information: process %s pid %d thread %s pid %d\n&quot;,
-		  ti.process_name, ti.tgid, ti.task_name, ti.pid);
+		   job-&gt;base.sched-&gt;name, atomic_read(&amp;ring-&gt;fence_drv.last_seq),
+		   ring-&gt;fence_drv.sync_seq);
+
+	ti = amdgpu_vm_get_task_info_pasid(ring-&gt;adev, job-&gt;pasid);
+	if (ti) {
+		DRM_ERROR(&quot;Process information: process %s pid %d thread %s pid %d\n&quot;,
+			  ti-&gt;process_name, ti-&gt;tgid, ti-&gt;task_name, ti-&gt;pid);
+		amdgpu_vm_put_task_info(ti);
+	}
 
 	dma_fence_set_error(&amp;s_job-&gt;s_fence-&gt;finished, -ETIME);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
index 4baa300121d8..a59364e9b6ed 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
@@ -230,8 +230,16 @@ void amdgpu_coredump(struct amdgpu_device *adev, bool vram_lost,
 
 	coredump-&gt;reset_vram_lost = vram_lost;
 
-	if (reset_context-&gt;job &amp;&amp; reset_context-&gt;job-&gt;vm)
-		coredump-&gt;reset_task_info = reset_context-&gt;job-&gt;vm-&gt;task_info;
+	if (reset_context-&gt;job &amp;&amp; reset_context-&gt;job-&gt;vm) {
+		struct amdgpu_task_info *ti;
+		struct amdgpu_vm *vm = reset_context-&gt;job-&gt;vm;
+
+		ti = amdgpu_vm_get_task_info_vm(vm);
+		if (ti) {
+			coredump-&gt;reset_task_info = *ti;
+			amdgpu_vm_put_task_info(ti);
+		}
+	}
 
 	coredump-&gt;adev = adev;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index d1b8afd105c9..8414567af683 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2127,6 +2127,117 @@ long amdgpu_vm_wait_idle(struct amdgpu_vm *vm, long timeout)
 	return dma_fence_wait_timeout(vm-&gt;last_unlocked, true, timeout);
 }
 
+static void amdgpu_vm_destroy_task_info(struct kref *kref)
+{
+	struct amdgpu_task_info *ti = container_of(kref, struct amdgpu_task_info, refcount);
+
+	kfree(ti);
+}
+
+static inline struct amdgpu_vm *
+amdgpu_vm_get_vm_from_pasid(struct amdgpu_device *adev, u32 pasid)
+{
+	struct amdgpu_vm *vm;
+	unsigned long flags;
+
+	xa_lock_irqsave(&amp;adev-&gt;vm_manager.pasids, flags);
+	vm = xa_load(&amp;adev-&gt;vm_manager.pasids, pasid);
+	xa_unlock_irqrestore(&amp;adev-&gt;vm_manager.pasids, flags);
+
+	return vm;
+}
+
+/**
+ * amdgpu_vm_put_task_info - reference down the vm task_info ptr
+ *
+ * @task_info: task_info struct under discussion.
+ *
+ * frees the vm task_info ptr at the last put
+ */
+void amdgpu_vm_put_task_info(struct amdgpu_task_info *task_info)
+{
+	kref_put(&amp;task_info-&gt;refcount, amdgpu_vm_destroy_task_info);
+}
+
+/**
+ * amdgpu_vm_get_task_info_pasid - Extracts task info for a PASID.
+ *
+ * @adev: drm device pointer
+ * @pasid: PASID identifier for VM
+ *
+ * Returns the reference counted task_info structure, which must be
+ * referenced down with amdgpu_vm_put_task_info.
+ */
+struct amdgpu_task_info *
+amdgpu_vm_get_task_info_pasid(struct amdgpu_device *adev, u32 pasid)
+{
+	struct amdgpu_vm *vm;
+	struct amdgpu_task_info *ti = NULL;
+
+	vm = amdgpu_vm_get_vm_from_pasid(adev, pasid);
+	if (vm) {
+		ti = vm-&gt;task_info;
+		kref_get(&amp;vm-&gt;task_info-&gt;refcount);
+	}</pre>
      </blockquote>
      <p>This could be more concise and elegant if you implemented it in
        terms of amdgpu_vm_get_task_info_vm. I.e.:</p>
      <pre>	return amdgpu_vm_get_task_info_vm(
		amdgpu_vm_get_vm_from_pasid(adev, pasid));</pre>
    </blockquote>
    <p>Certainly looks better this way. <br>
    </p>
    <blockquote type="cite" cite="mid:486845c4-192c-47e5-9a18-b1497578c260@amd.com">
      <pre>
</pre>
      <p><br>
      </p>
      <blockquote type="cite" cite="mid:20240205170508.974-1-shashank.sharma@amd.com">
        <pre class="moz-quote-pre" wrap="">+
+	return ti;
+}
+
+/**
+ * amdgpu_vm_get_task_info_vm - Extracts task info for a vm.
+ *
+ * @vm: VM to get info from
+ *
+ * Returns the reference counted task_info structure, which must be
+ * referenced down with amdgpu_vm_put_task_info.
+ */
+struct amdgpu_task_info *
+amdgpu_vm_get_task_info_vm(struct amdgpu_vm *vm)
+{
+	struct amdgpu_task_info *ti = NULL;
+
+	if (vm) {
+		ti = vm-&gt;task_info;
+		kref_get(&amp;vm-&gt;task_info-&gt;refcount);
+	}
+
+	return ti;
+}
+
+static int amdgpu_vm_create_task_info(struct amdgpu_vm *vm)
+{
+	vm-&gt;task_info = kzalloc(sizeof(struct amdgpu_task_info), GFP_KERNEL);
+	if (!vm-&gt;task_info)
+		return -ENOMEM;
+
+	kref_init(&amp;vm-&gt;task_info-&gt;refcount);
+	kref_get(&amp;vm-&gt;task_info-&gt;refcount);</pre>
      </blockquote>
      <p>kref_init initializes the refcount to 1. I don't think you
        should to take another reference here because that reference
        never gets released.<br>
      </p>
    </blockquote>
    <p>Thanks for this input, I wasn't aware of this and I realized the
      destroy function was never getting called due to this. After
      fixing this it is getting called properly.&nbsp; <br>
    </p>
    <p>I will do this change and push the patch. <br>
    </p>
    <p>- Shashank<br>
    </p>
    <blockquote type="cite" cite="mid:486845c4-192c-47e5-9a18-b1497578c260@amd.com">
      <p>Regards,<br>
        &nbsp; Felix</p>
      <p><br>
      </p>
      <blockquote type="cite" cite="mid:20240205170508.974-1-shashank.sharma@amd.com">
        <pre class="moz-quote-pre" wrap="">+	return 0;
+}
+
+/**
+ * amdgpu_vm_set_task_info - Sets VMs task info.
+ *
+ * @vm: vm for which to set the info
+ */
+void amdgpu_vm_set_task_info(struct amdgpu_vm *vm)
+{
+	if (!vm-&gt;task_info)
+		return;
+
+	if (vm-&gt;task_info-&gt;pid == current-&gt;pid)
+		return;
+
+	vm-&gt;task_info-&gt;pid = current-&gt;pid;
+	get_task_comm(vm-&gt;task_info-&gt;task_name, current);
+
+	if (current-&gt;group_leader-&gt;mm != current-&gt;mm)
+		return;
+
+	vm-&gt;task_info-&gt;tgid = current-&gt;group_leader-&gt;pid;
+	get_task_comm(vm-&gt;task_info-&gt;process_name, current-&gt;group_leader);
+}
+
 /**
  * amdgpu_vm_init - initialize a vm instance
  *
@@ -2212,6 +2323,10 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	if (r)
 		goto error_free_root;
 
+	r = amdgpu_vm_create_task_info(vm);
+	if (r)
+		DRM_DEBUG(&quot;Failed to create task info for VM\n&quot;);
+
 	amdgpu_bo_unreserve(vm-&gt;root.bo);
 	amdgpu_bo_unref(&amp;root_bo);
 
@@ -2351,6 +2466,7 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 
 	root = amdgpu_bo_ref(vm-&gt;root.bo);
 	amdgpu_bo_reserve(root, true);
+	amdgpu_vm_put_task_info(vm-&gt;task_info);
 	amdgpu_vm_set_pasid(adev, vm, 0);
 	dma_fence_wait(vm-&gt;last_unlocked, false);
 	dma_fence_put(vm-&gt;last_unlocked);
@@ -2507,48 +2623,6 @@ int amdgpu_vm_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 	return 0;
 }
 
-/**
- * amdgpu_vm_get_task_info - Extracts task info for a PASID.
- *
- * @adev: drm device pointer
- * @pasid: PASID identifier for VM
- * @task_info: task_info to fill.
- */
-void amdgpu_vm_get_task_info(struct amdgpu_device *adev, u32 pasid,
-			 struct amdgpu_task_info *task_info)
-{
-	struct amdgpu_vm *vm;
-	unsigned long flags;
-
-	xa_lock_irqsave(&amp;adev-&gt;vm_manager.pasids, flags);
-
-	vm = xa_load(&amp;adev-&gt;vm_manager.pasids, pasid);
-	if (vm)
-		*task_info = vm-&gt;task_info;
-
-	xa_unlock_irqrestore(&amp;adev-&gt;vm_manager.pasids, flags);
-}
-
-/**
- * amdgpu_vm_set_task_info - Sets VMs task info.
- *
- * @vm: vm for which to set the info
- */
-void amdgpu_vm_set_task_info(struct amdgpu_vm *vm)
-{
-	if (vm-&gt;task_info.pid)
-		return;
-
-	vm-&gt;task_info.pid = current-&gt;pid;
-	get_task_comm(vm-&gt;task_info.task_name, current);
-
-	if (current-&gt;group_leader-&gt;mm != current-&gt;mm)
-		return;
-
-	vm-&gt;task_info.tgid = current-&gt;group_leader-&gt;pid;
-	get_task_comm(vm-&gt;task_info.process_name, current-&gt;group_leader);
-}
-
 /**
  * amdgpu_vm_handle_fault - graceful handling of VM faults.
  * @adev: amdgpu device pointer
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 2cd86d2bf73f..a74b94c3c9ba 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -190,10 +190,11 @@ struct amdgpu_vm_pte_funcs {
 };
 
 struct amdgpu_task_info {
-	char	process_name[TASK_COMM_LEN];
-	char	task_name[TASK_COMM_LEN];
-	pid_t	pid;
-	pid_t	tgid;
+	char		process_name[TASK_COMM_LEN];
+	char		task_name[TASK_COMM_LEN];
+	pid_t		pid;
+	pid_t		tgid;
+	struct kref	refcount;
 };
 
 /**
@@ -356,7 +357,7 @@ struct amdgpu_vm {
 	uint64_t		pd_phys_addr;
 
 	/* Some basic info about the task */
-	struct amdgpu_task_info task_info;
+	struct amdgpu_task_info *task_info;
 
 	/* Store positions of group of BOs */
 	struct ttm_lru_bulk_move lru_bulk_move;
@@ -492,8 +493,14 @@ bool amdgpu_vm_need_pipeline_sync(struct amdgpu_ring *ring,
 				  struct amdgpu_job *job);
 void amdgpu_vm_check_compute_bug(struct amdgpu_device *adev);
 
-void amdgpu_vm_get_task_info(struct amdgpu_device *adev, u32 pasid,
-			     struct amdgpu_task_info *task_info);
+struct amdgpu_task_info *
+amdgpu_vm_get_task_info_pasid(struct amdgpu_device *adev, u32 pasid);
+
+struct amdgpu_task_info *
+amdgpu_vm_get_task_info_vm(struct amdgpu_vm *vm);
+
+void amdgpu_vm_put_task_info(struct amdgpu_task_info *task_info);
+
 bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
 			    u32 vmid, u32 node_id, uint64_t addr,
 			    bool write_fault);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
index a160265ddc07..d9e895cb0c10 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -1027,7 +1027,7 @@ int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params *params,
 			trace_amdgpu_vm_update_ptes(params, frag_start, upd_end,
 						    min(nptes, 32u), dst, incr,
 						    upd_flags,
-						    vm-&gt;task_info.tgid,
+						    vm-&gt;task_info ? vm-&gt;task_info-&gt;tgid : 0,
 						    vm-&gt;immediate.fence_context);
 			amdgpu_vm_pte_update_flags(params, to_amdgpu_bo_vm(pt),
 						   cursor.level, pe_start, dst,
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index a5a05c16c10d..7098f0be83c7 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -105,7 +105,7 @@ static int gmc_v10_0_process_interrupt(struct amdgpu_device *adev,
 	struct amdgpu_vmhub *hub = &amp;adev-&gt;vmhub[vmhub_index];
 	bool retry_fault = !!(entry-&gt;src_data[1] &amp; 0x80);
 	bool write_fault = !!(entry-&gt;src_data[1] &amp; 0x20);
-	struct amdgpu_task_info task_info;
+	struct amdgpu_task_info *task_info;
 	uint32_t status = 0;
 	u64 addr;
 
@@ -157,18 +157,22 @@ static int gmc_v10_0_process_interrupt(struct amdgpu_device *adev,
 	if (!printk_ratelimit())
 		return 0;
 
-	memset(&amp;task_info, 0, sizeof(struct amdgpu_task_info));
-	amdgpu_vm_get_task_info(adev, entry-&gt;pasid, &amp;task_info);
-
 	dev_err(adev-&gt;dev,
-		&quot;[%s] page fault (src_id:%u ring:%u vmid:%u pasid:%u, for process %s pid %d thread %s pid %d)\n&quot;,
+		&quot;[%s] page fault (src_id:%u ring:%u vmid:%u pasid:%u)\n&quot;,
 		entry-&gt;vmid_src ? &quot;mmhub&quot; : &quot;gfxhub&quot;,
-		entry-&gt;src_id, entry-&gt;ring_id, entry-&gt;vmid,
-		entry-&gt;pasid, task_info.process_name, task_info.tgid,
-		task_info.task_name, task_info.pid);
+		entry-&gt;src_id, entry-&gt;ring_id, entry-&gt;vmid, entry-&gt;pasid);
+	task_info = amdgpu_vm_get_task_info_pasid(adev, entry-&gt;pasid);
+	if (task_info) {
+		dev_err(adev-&gt;dev,
+			&quot; in process %s pid %d thread %s pid %d\n&quot;,
+			task_info-&gt;process_name, task_info-&gt;tgid,
+			task_info-&gt;task_name, task_info-&gt;pid);
+		amdgpu_vm_put_task_info(task_info);
+	}
+
 	dev_err(adev-&gt;dev, &quot;  in page starting at address 0x%016llx from client 0x%x (%s)\n&quot;,
-		addr, entry-&gt;client_id,
-		soc15_ih_clientid_name[entry-&gt;client_id]);
+			addr, entry-&gt;client_id,
+			soc15_ih_clientid_name[entry-&gt;client_id]);
 
 	if (!amdgpu_sriov_vf(adev))
 		hub-&gt;vmhub_funcs-&gt;print_l2_protection_fault_status(adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index 23d7b548d13f..bff88070bb00 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -126,19 +126,24 @@ static int gmc_v11_0_process_interrupt(struct amdgpu_device *adev,
 	}
 
 	if (printk_ratelimit()) {
-		struct amdgpu_task_info task_info;
-
-		memset(&amp;task_info, 0, sizeof(struct amdgpu_task_info));
-		amdgpu_vm_get_task_info(adev, entry-&gt;pasid, &amp;task_info);
+		struct amdgpu_task_info *task_info;
 
 		dev_err(adev-&gt;dev,
-			&quot;[%s] page fault (src_id:%u ring:%u vmid:%u pasid:%u, for process %s pid %d thread %s pid %d)\n&quot;,
+			&quot;[%s] page fault (src_id:%u ring:%u vmid:%u pasid:%u)\n&quot;,
 			entry-&gt;vmid_src ? &quot;mmhub&quot; : &quot;gfxhub&quot;,
-			entry-&gt;src_id, entry-&gt;ring_id, entry-&gt;vmid,
-			entry-&gt;pasid, task_info.process_name, task_info.tgid,
-			task_info.task_name, task_info.pid);
+			entry-&gt;src_id, entry-&gt;ring_id, entry-&gt;vmid, entry-&gt;pasid);
+		task_info = amdgpu_vm_get_task_info_pasid(adev, entry-&gt;pasid);
+		if (task_info) {
+			dev_err(adev-&gt;dev,
+				&quot; in process %s pid %d thread %s pid %d)\n&quot;,
+				task_info-&gt;process_name, task_info-&gt;tgid,
+				task_info-&gt;task_name, task_info-&gt;pid);
+			amdgpu_vm_put_task_info(task_info);
+		}
+
 		dev_err(adev-&gt;dev, &quot;  in page starting at address 0x%016llx from client %d\n&quot;,
-			addr, entry-&gt;client_id);
+				addr, entry-&gt;client_id);
+
 		if (!amdgpu_sriov_vf(adev))
 			hub-&gt;vmhub_funcs-&gt;print_l2_protection_fault_status(adev, status);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
index ff4ae73d27ec..ba1f18978487 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
@@ -1444,18 +1444,24 @@ static int gmc_v8_0_process_interrupt(struct amdgpu_device *adev,
 		gmc_v8_0_set_fault_enable_default(adev, false);
 
 	if (printk_ratelimit()) {
-		struct amdgpu_task_info task_info;
+		struct amdgpu_task_info *task_info;
 
-		memset(&amp;task_info, 0, sizeof(struct amdgpu_task_info));
-		amdgpu_vm_get_task_info(adev, entry-&gt;pasid, &amp;task_info);
+		dev_err(adev-&gt;dev, &quot;GPU fault detected: %d 0x%08x\n&quot;,
+			entry-&gt;src_id, entry-&gt;src_data[0]);
+
+		task_info = amdgpu_vm_get_task_info_pasid(adev, entry-&gt;pasid);
+		if (task_info) {
+			dev_err(adev-&gt;dev, &quot; for process %s pid %d thread %s pid %d\n&quot;,
+				task_info-&gt;process_name, task_info-&gt;tgid,
+				task_info-&gt;task_name, task_info-&gt;pid);
+			amdgpu_vm_put_task_info(task_info);
+		}
 
-		dev_err(adev-&gt;dev, &quot;GPU fault detected: %d 0x%08x for process %s pid %d thread %s pid %d\n&quot;,
-			entry-&gt;src_id, entry-&gt;src_data[0], task_info.process_name,
-			task_info.tgid, task_info.task_name, task_info.pid);
 		dev_err(adev-&gt;dev, &quot;  VM_CONTEXT1_PROTECTION_FAULT_ADDR   0x%08X\n&quot;,
-			addr);
+				addr);
 		dev_err(adev-&gt;dev, &quot;  VM_CONTEXT1_PROTECTION_FAULT_STATUS 0x%08X\n&quot;,
 			status);
+
 		gmc_v8_0_vm_decode_fault(adev, status, addr, mc_client,
 					 entry-&gt;pasid);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 2ac5820e9c92..cc0968f553a1 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -549,7 +549,7 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
 	bool retry_fault = !!(entry-&gt;src_data[1] &amp; 0x80);
 	bool write_fault = !!(entry-&gt;src_data[1] &amp; 0x20);
 	uint32_t status = 0, cid = 0, rw = 0;
-	struct amdgpu_task_info task_info;
+	struct amdgpu_task_info *task_info;
 	struct amdgpu_vmhub *hub;
 	const char *mmhub_cid;
 	const char *hub_name;
@@ -626,15 +626,20 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
 	if (!printk_ratelimit())
 		return 0;
 
-	memset(&amp;task_info, 0, sizeof(struct amdgpu_task_info));
-	amdgpu_vm_get_task_info(adev, entry-&gt;pasid, &amp;task_info);
-
 	dev_err(adev-&gt;dev,
-		&quot;[%s] %s page fault (src_id:%u ring:%u vmid:%u pasid:%u, for process %s pid %d thread %s pid %d)\n&quot;,
-		hub_name, retry_fault ? &quot;retry&quot; : &quot;no-retry&quot;,
-		entry-&gt;src_id, entry-&gt;ring_id, entry-&gt;vmid,
-		entry-&gt;pasid, task_info.process_name, task_info.tgid,
-		task_info.task_name, task_info.pid);
+		&quot;[%s] %s page fault (src_id:%u ring:%u vmid:%u pasid:%u)\n&quot;, hub_name,
+		retry_fault ? &quot;retry&quot; : &quot;no-retry&quot;,
+		entry-&gt;src_id, entry-&gt;ring_id, entry-&gt;vmid, entry-&gt;pasid);
+
+	task_info = amdgpu_vm_get_task_info_pasid(adev, entry-&gt;pasid);
+	if (task_info) {
+		dev_err(adev-&gt;dev,
+			&quot; for process %s pid %d thread %s pid %d)\n&quot;,
+			task_info-&gt;process_name, task_info-&gt;tgid,
+			task_info-&gt;task_name, task_info-&gt;pid);
+		amdgpu_vm_put_task_info(task_info);
+	}
+
 	dev_err(adev-&gt;dev, &quot;  in page starting at address 0x%016llx from IH client 0x%x (%s)\n&quot;,
 		addr, entry-&gt;client_id,
 		soc15_ih_clientid_name[entry-&gt;client_id]);
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index 3d68dd5523c6..43775cb67ff5 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -2104,7 +2104,7 @@ static int sdma_v4_0_print_iv_entry(struct amdgpu_device *adev,
 					      struct amdgpu_iv_entry *entry)
 {
 	int instance;
-	struct amdgpu_task_info task_info;
+	struct amdgpu_task_info *task_info;
 	u64 addr;
 
 	instance = sdma_v4_0_irq_id_to_seq(entry-&gt;client_id);
@@ -2116,15 +2116,20 @@ static int sdma_v4_0_print_iv_entry(struct amdgpu_device *adev,
 	addr = (u64)entry-&gt;src_data[0] &lt;&lt; 12;
 	addr |= ((u64)entry-&gt;src_data[1] &amp; 0xf) &lt;&lt; 44;
 
-	memset(&amp;task_info, 0, sizeof(struct amdgpu_task_info));
-	amdgpu_vm_get_task_info(adev, entry-&gt;pasid, &amp;task_info);
-
 	dev_dbg_ratelimited(adev-&gt;dev,
-		   &quot;[sdma%d] address:0x%016llx src_id:%u ring:%u vmid:%u &quot;
-		   &quot;pasid:%u, for process %s pid %d thread %s pid %d\n&quot;,
-		   instance, addr, entry-&gt;src_id, entry-&gt;ring_id, entry-&gt;vmid,
-		   entry-&gt;pasid, task_info.process_name, task_info.tgid,
-		   task_info.task_name, task_info.pid);
+			   &quot;[sdma%d] address:0x%016llx src_id:%u ring:%u vmid:%u pasid:%u\n&quot;,
+			   instance, addr, entry-&gt;src_id, entry-&gt;ring_id, entry-&gt;vmid,
+			   entry-&gt;pasid);
+
+	task_info = amdgpu_vm_get_task_info_pasid(adev, entry-&gt;pasid);
+	if (task_info) {
+		dev_dbg_ratelimited(adev-&gt;dev,
+				    &quot; for process %s pid %d thread %s pid %d\n&quot;,
+				    task_info-&gt;process_name, task_info-&gt;tgid,
+				    task_info-&gt;task_name, task_info-&gt;pid);
+		amdgpu_vm_put_task_info(task_info);
+	}
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index 0f24af6f2810..51a17d7076ec 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -1642,7 +1642,7 @@ static int sdma_v4_4_2_print_iv_entry(struct amdgpu_device *adev,
 					      struct amdgpu_iv_entry *entry)
 {
 	int instance;
-	struct amdgpu_task_info task_info;
+	struct amdgpu_task_info *task_info;
 	u64 addr;
 
 	instance = sdma_v4_4_2_irq_id_to_seq(entry-&gt;client_id);
@@ -1654,15 +1654,19 @@ static int sdma_v4_4_2_print_iv_entry(struct amdgpu_device *adev,
 	addr = (u64)entry-&gt;src_data[0] &lt;&lt; 12;
 	addr |= ((u64)entry-&gt;src_data[1] &amp; 0xf) &lt;&lt; 44;
 
-	memset(&amp;task_info, 0, sizeof(struct amdgpu_task_info));
-	amdgpu_vm_get_task_info(adev, entry-&gt;pasid, &amp;task_info);
-
 	dev_dbg_ratelimited(adev-&gt;dev,
-		   &quot;[sdma%d] address:0x%016llx src_id:%u ring:%u vmid:%u &quot;
-		   &quot;pasid:%u, for process %s pid %d thread %s pid %d\n&quot;,
-		   instance, addr, entry-&gt;src_id, entry-&gt;ring_id, entry-&gt;vmid,
-		   entry-&gt;pasid, task_info.process_name, task_info.tgid,
-		   task_info.task_name, task_info.pid);
+			    &quot;[sdma%d] address:0x%016llx src_id:%u ring:%u vmid:%u pasid:%u\n&quot;,
+			    instance, addr, entry-&gt;src_id, entry-&gt;ring_id, entry-&gt;vmid,
+			    entry-&gt;pasid);
+
+	task_info = amdgpu_vm_get_task_info_pasid(adev, entry-&gt;pasid);
+	if (task_info) {
+		dev_dbg_ratelimited(adev-&gt;dev, &quot; for process %s pid %d thread %s pid %d\n&quot;,
+				    task_info-&gt;process_name, task_info-&gt;tgid,
+				    task_info-&gt;task_name, task_info-&gt;pid);
+		amdgpu_vm_put_task_info(task_info);
+	}
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
index d9953c2b2661..06ac835190f9 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
@@ -238,16 +238,16 @@ void kfd_smi_event_update_thermal_throttling(struct kfd_node *dev,
 
 void kfd_smi_event_update_vmfault(struct kfd_node *dev, uint16_t pasid)
 {
-	struct amdgpu_task_info task_info;
-
-	memset(&amp;task_info, 0, sizeof(struct amdgpu_task_info));
-	amdgpu_vm_get_task_info(dev-&gt;adev, pasid, &amp;task_info);
-	/* Report VM faults from user applications, not retry from kernel */
-	if (!task_info.pid)
-		return;
-
-	kfd_smi_event_add(0, dev, KFD_SMI_EVENT_VMFAULT, &quot;%x:%s\n&quot;,
-			  task_info.pid, task_info.task_name);
+	struct amdgpu_task_info *task_info;
+
+	task_info = amdgpu_vm_get_task_info_pasid(dev-&gt;adev, pasid);
+	if (task_info) {
+		/* Report VM faults from user applications, not retry from kernel */
+		if (task_info-&gt;pid)
+			kfd_smi_event_add(0, dev, KFD_SMI_EVENT_VMFAULT, &quot;%x:%s\n&quot;,
+					 task_info-&gt;pid, task_info-&gt;task_name);
+		amdgpu_vm_put_task_info(task_info);
+	}
 }
 
 void kfd_smi_event_page_fault_start(struct kfd_node *node, pid_t pid,
</pre>
      </blockquote>
    </blockquote>
  </body>
</html>

--------------cBqVg5qO0H9zsAzR6IR1kQ5I--
