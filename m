Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EB9AC46CD2
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Jan 2024 14:33:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C29A810EA23;
	Wed, 24 Jan 2024 14:33:06 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFA2810EA09
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Jan 2024 14:33:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Csza+s02tywDahmPbLkUbnO2T/Kg16AkWtW2mk0xxql7rMZRjKSz2W7QkvmSbLtaEAMdq2nr4p0JURf6ca+6UBmgj6b1QvKtasHIILdlZXpd9fYkp+Ana5gKkYllt4BCKJqGJvekqG9dDiVFClfOxAHVEwXvRUFnhfsrN+taggr1NFJXMmZ95K2vf5fVU1XXrBG+UXohY4E9/5NauGVS5yMsItKpl1IdHf18LEwgUywbTjQjuz6nKJx8ZVbXDrBu3CxpN1m/cuhCzKU6BtyyoDVxGQFmrWfrUn6wOIc/v0IX0ak8XuyFPnkemfcSMYANTbPwh+juaRAlIysxHj97qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uS+L9FDphzMLM+knVztcxLbxBXZt3o2kKkOsiQh2ciw=;
 b=EUIAKAiB4dzv9Y9AmAKSYmLuUWJQ4fgsqsUsNST7O1fwcuc5VQKgWN1PH7FEDCekySYnyqrvYhGFOwab2qn60dIYeu4F6ct+akyTVda184GqzySgYgQXu2Ww04JB319PyQbh6afoc1hDhFo/wocP4uY3sEtS7Hci1DHnhwLRsG/jgdblGIEuoMPKJisKJJeHvr7p6VcsdedB1kVVaumbwOU9tbD423SVdR8TN7GQ1aRu8mO9k5Y4dUbN8GyTTebKFnUM5m6fR40xmtfIkKf+Hc8+2GpCYiFMyq8ailfUQPvG65XdHvH/XA+CzjEhb8IfmjHUbHd9NqB09lzTrXogNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uS+L9FDphzMLM+knVztcxLbxBXZt3o2kKkOsiQh2ciw=;
 b=nf3Q+ERVFi6vHZ7X7VJ6fubJlgZjgKfC4LkkqYUuAgm8wO7ioJm6WPdS4S5OSUXlSBfMpJVcKtluoQNbgAN0BXSUevoZuCgvYPxLt69CKECeLvy3JiYTS2juzl5WKkE7jhycoWzctjnhfUbFJYY8lPRoODTVEWF/+WUCIOTwumM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB5673.namprd12.prod.outlook.com (2603:10b6:a03:42b::13)
 by IA0PR12MB7604.namprd12.prod.outlook.com (2603:10b6:208:438::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.37; Wed, 24 Jan
 2024 14:32:57 +0000
Received: from SJ0PR12MB5673.namprd12.prod.outlook.com
 ([fe80::e12:e3bc:a965:72ee]) by SJ0PR12MB5673.namprd12.prod.outlook.com
 ([fe80::e12:e3bc:a965:72ee%7]) with mapi id 15.20.7228.022; Wed, 24 Jan 2024
 14:32:57 +0000
Message-ID: <c77d4ca5-413a-0d18-e1c6-20cc6addc6e1@amd.com>
Date: Wed, 24 Jan 2024 15:32:51 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2] drm/amdgpu: change vm->task_info handling
To: Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240118192104.147-1-shashank.sharma@amd.com>
 <83155aae-3bb2-48ed-bcfc-48bd02bbcec6@amd.com>
Content-Language: en-US
From: Shashank Sharma <shashank.sharma@amd.com>
In-Reply-To: <83155aae-3bb2-48ed-bcfc-48bd02bbcec6@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0435.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d1::14) To SJ0PR12MB5673.namprd12.prod.outlook.com
 (2603:10b6:a03:42b::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5673:EE_|IA0PR12MB7604:EE_
X-MS-Office365-Filtering-Correlation-Id: 35e0006b-8af5-4d4c-a381-08dc1ce95bb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qBQxtFlTQPzemn1iWDBgdB5SvhKl62aeGqBnDf3/+2gcwTxM/fdEazdHFrhgsABnSX523rhWpAYD726AcqNeR7KzHT/S/tgQMm9l9ExLQLEyymwH8JYZqRDygpQIzZv6mzOnmQ73kJDCwdmHloi7p/XG4Rs4wYK5Oc3Y6h7YPPRL3bw08yvJm8U72DB5BrUnzJeIofWHjilTYu8/si9GO8VgAKcRlaabFNQiVPdAWyLX9LzhFUUIWJkIdAh6qEj6yaLTNamP/fp79S5tLOdonBeEK+DRcISLuJbbA4DlZXdnTiGN+GEeRacq/x/pRnJ/Tc3E5Y+wkJDuDjvTzU/KAqJ1HU9KF75fLamNxrCEHhmG6choNiKFb6C780A4slMpy6j6Pyg9zotJPh5gS3m1tgRhy4pBljFS24J0r+qRAO+LM+dRrCZZusiEIV2Jxtu3exxndCuW16vlRsPrHyaD5j+nJL2BtWdHCBNbK1U3JJhNdWWIdWY3GKfXA+r7danxs7evoooO2cvSRJ5HzdxdEb3KZSL9orak8BrgTrhBXaSMQHqO1VWOqVaLEwfAM0vgWQPwq8L6c1aLVDxuGDV6ry/ktA6AU5hFl04Xb6+bZvm7gYp0+lJqk2s6QX92jrn6M+Oqmd9n4+u88Drxag1eaA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB5673.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(396003)(136003)(376002)(346002)(39860400002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(44832011)(4326008)(30864003)(38100700002)(41300700001)(86362001)(36756003)(31696002)(478600001)(54906003)(66556008)(6486002)(53546011)(316002)(8936002)(83380400001)(6666004)(5660300002)(8676002)(66476007)(6512007)(2906002)(66946007)(26005)(6506007)(2616005)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NnRsSW9ycWZzUTZxb2c2ZjlOUE1ON0kyaW9wZENSYTRIZkFteFJLei9RWUZF?=
 =?utf-8?B?UUt6a1pHRFpTR3JnY011Wm1FbHFUZTBib296bXh2VjNZSFVKY1hsTDVSbVBM?=
 =?utf-8?B?b0ZaNjhncitib0hET2pDNldGQnB2WWpQOWRtb0lUSDRTSUZDZEtoL2ZhV280?=
 =?utf-8?B?dVArYTVEazVZRmhWWmFRb1VpMGhDUDdjbmtXd2lIcTRGQld2aWQ0MUhVaUhM?=
 =?utf-8?B?Snl3TDZDOUlsZUQ0WXc4RWswQ05udFA4YUFIN2FpL3VuYy9UcjdsWnJaT1lo?=
 =?utf-8?B?eEZLR0k0MlpMaGlZTzRrcHp1bGpBaG9uZGNXVUYxdjFIbDFsaTZSNHRMQW9B?=
 =?utf-8?B?RW9xdk1sWkVDaHpKbW1zMkRvcldUSTlPL3ZBTEg3MmNuTDNMV25BZHprQ0Zn?=
 =?utf-8?B?WklYS0NmVm96bGtNUDNKMEtNZFNXYTJya243Z3Z0UVE0b21wVTJhYU9nZTBJ?=
 =?utf-8?B?cFZaYkpEanF4Z2RtRkZ3citIKzAxYUpTRTRlR2ZaWHZ6SkhtYTJQVERBRlZB?=
 =?utf-8?B?b3ZhOVJyS0o2aVpONUhWV1RTUnlKbjJ4Nkw3bHJNL3lxaWdBSGZzd0ZWNEtV?=
 =?utf-8?B?VHIwb1kwQzhxL0xYaUx6NU9ZaVE5bWxYdndYVC92M1RQdlB0S25kWjl6YXNv?=
 =?utf-8?B?YTJYT3BzWkFmK3p3RWNxQjlIK2xvZTR1Zy93V25DZTJUZmNLbi91Y0RzVE9D?=
 =?utf-8?B?S1djbThBejM0Q29oZXhyRlVmd3ArUUVZWkR1eDQxTVRjL2V3U29ESUNTSExQ?=
 =?utf-8?B?ZDFycWtPTTdiK2JoUWZJWlhHU0krRi9DbWlsbFlsa0YwOG16dG12WlByS0Ew?=
 =?utf-8?B?b3V0WFF3bEh0emhmOXR2SXFkQmdqSXZ1bDVaOVJudEhLcTRyUkVOeDVnME5N?=
 =?utf-8?B?cnc5NE5jMHVnRWtNNUJ5bS8zaG00WS8yR2plTHNzZWVFWC9xcDEzY09kNlg2?=
 =?utf-8?B?TE04V29uUkpDQlpyNmtBakZqWHk0Y25qZHpGQmYxNWtPb2M5TTZTRmtkTTI2?=
 =?utf-8?B?U2pUbkRVR1RZSFEvOVE4WDNzZXVhelZPbWxvRmxLaExkVXBUVFJCRTZuL0VD?=
 =?utf-8?B?clNML2UydUZLWVo1ZEl4bENpSDFJZjYxalVZSDdyRVZDMG1Uc3dxcUlqbjVK?=
 =?utf-8?B?VXFNTGhyUlpJTWxocngyMHFrdGJmaWhGYUdwbGVFMEFTMGhZaVpiUkVZZllo?=
 =?utf-8?B?bkVPa3c0ME95TFdGSm5uREluM0ZqajlFTW9aVitaQkRNMXlZZ2xMejdhVERM?=
 =?utf-8?B?Z0pmajhqamM5RjJqTndJMklvN2s2VW15cHNReDJBanVYT3cwbHdTZmV4a0da?=
 =?utf-8?B?dXpDMEpvSURFMGMwOStQeDFPVjNaM3ZNcnhRdFEvOS9wMnZLZnRacDBSelFa?=
 =?utf-8?B?aWMyYW5YQ0pDaGE0T1VmeUphZnJsU1ZycE11eS9hUXUzcG55NThra0gvR0xY?=
 =?utf-8?B?NlJaYzE3a2JMWXJvNTY5Qi9DVE5sOXNTdlV1MFFrNGluMk5GTGlsek52MUl4?=
 =?utf-8?B?SFlrUWk5Um1WeUNmako2OUdyUTRQU3RseUNISHdrakUrRlJZcjYzS2luOG9V?=
 =?utf-8?B?eVZLdGhKQW9rbnNsWmZXZ3ZrdzBkM0N0V0FISWlobDhkb1IzQWlXajhIcDFz?=
 =?utf-8?B?dngvSGhST1EzbERDZGg5VnB2a1lHV1VnT2gwdDFSeFd5WGU1anUrYXJ5ZkFG?=
 =?utf-8?B?ZThFdkV5UUJQWVpFV1hrQXdOQm95b2poYlRZajgyeUUwWnZVQU5XdGVxSnZm?=
 =?utf-8?B?dUdsb1BqV0oyNnlSaW9BcC8vQTdCSUNvMnRRMDFWZUM5ZlU5cU9ZeXFPd0xp?=
 =?utf-8?B?bzRBQjlZSGZiNWxFODdnSGVEdklkSDZWSkRiNkJmL3p5Qm51U0hseWRoYjZl?=
 =?utf-8?B?c1NsSkNGZ2VJZVIrclhhSStJVmZXcTVWWS9GbDlWMzM5L2U5RkU5QlkrRlZY?=
 =?utf-8?B?RzhJV0hzTFgvMHU4VlpoWWJMb0hFdWlCRm9WZmtmcU1FekhQVjllZEhhMUxH?=
 =?utf-8?B?Y0xNNG5iRkJrNjEwc0tJUnk2OE85Zi9RNmVna2I3WlZJMStoRGMrKy9ZVU52?=
 =?utf-8?B?WUlEL3pxR1JDcUNFVW43UTFiWFRLbFdjSFRveFJsTkY3Q3NLVDlsQjcrU0Q3?=
 =?utf-8?Q?FAC20unpLLC4wn2k6SgCdYZ4n?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35e0006b-8af5-4d4c-a381-08dc1ce95bb9
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5673.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 14:32:57.4453 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Zk94/NX3y5syZfSgsV/IvKs990u248hnCYgSUYFmpwpe/RAcp75YZ+deHbQDKRhJU750hGWvsielCGrg6UKjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7604
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 19/01/2024 21:23, Felix Kuehling wrote:
>
> On 2024-01-18 14:21, Shashank Sharma wrote:
>> This patch changes the handling and lifecycle of vm->task_info object.
>> The major changes are:
>> - vm->task_info is a dynamically allocated ptr now, and its uasge is
>>    reference counted.
>> - introducing two new helper funcs for task_info lifecycle management
>>      - amdgpu_vm_get_task_info: reference counts up task_info before
>>        returning this info
>>      - amdgpu_vm_put_task_info: reference counts down task_info
>> - last put to task_info() frees task_info from the vm.
>>
>> This patch also does logistical changes required for existing usage
>> of vm->task_info.
>>
>> V2: Do not block all the prints when task_info not found (Felix)
>>
>> Cc: Christian Koenig <christian.koenig@amd.com>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Cc: Felix Kuehling <Felix.Kuehling@amd.com>
>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>
> Nit-picks inline.
>
>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |   7 +-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_job.c     |  18 ++-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c   |  12 +-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c      | 142 +++++++++++++++++---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h      |  26 +++-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c   |   2 +-
>>   drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c      |  30 +++--
>>   drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c      |  31 +++--
>>   drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c       |  22 +--
>>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c       |  26 ++--
>>   drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c      |  26 ++--
>>   drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c    |  26 ++--
>>   drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c |  20 +--
>>   13 files changed, 287 insertions(+), 101 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>> index 0e61ebdb3f3e..99c736b6e32c 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>> @@ -1775,9 +1775,12 @@ static int amdgpu_debugfs_vm_info_show(struct 
>> seq_file *m, void *unused)
>>       list_for_each_entry(file, &dev->filelist, lhead) {
>>           struct amdgpu_fpriv *fpriv = file->driver_priv;
>>           struct amdgpu_vm *vm = &fpriv->vm;
>> +        struct amdgpu_task_info *ti;
>> +
>> +        ti = amdgpu_vm_get_task_info_vm(vm);
>
> Can ti be NULL here? I think it can, so you'd need a NULL check to 
> avoid a possible kernel oops.
Agree
>
>
>> +        seq_printf(m, "pid:%d\tProcess:%s ----------\n", ti->pid, 
>> ti->process_name);
>> +        amdgpu_vm_put_task_info_vm(ti, vm);
>>   -        seq_printf(m, "pid:%d\tProcess:%s ----------\n",
>> -                vm->task_info.pid, vm->task_info.process_name);
>>           r = amdgpu_bo_reserve(vm->root.bo, true);
>>           if (r)
>>               break;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>> index 1f357198533f..af23746821b7 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>> @@ -35,7 +35,7 @@ static enum drm_gpu_sched_stat 
>> amdgpu_job_timedout(struct drm_sched_job *s_job)
>>   {
>>       struct amdgpu_ring *ring = to_amdgpu_ring(s_job->sched);
>>       struct amdgpu_job *job = to_amdgpu_job(s_job);
>> -    struct amdgpu_task_info ti;
>> +    struct amdgpu_task_info *ti;
>>       struct amdgpu_device *adev = ring->adev;
>>       int idx;
>>       int r;
>> @@ -48,7 +48,7 @@ static enum drm_gpu_sched_stat 
>> amdgpu_job_timedout(struct drm_sched_job *s_job)
>>           return DRM_GPU_SCHED_STAT_ENODEV;
>>       }
>>   -    memset(&ti, 0, sizeof(struct amdgpu_task_info));
>> +
>>       adev->job_hang = true;
>>         if (amdgpu_gpu_recovery &&
>> @@ -58,12 +58,16 @@ static enum drm_gpu_sched_stat 
>> amdgpu_job_timedout(struct drm_sched_job *s_job)
>>           goto exit;
>>       }
>>   -    amdgpu_vm_get_task_info(ring->adev, job->pasid, &ti);
>>       DRM_ERROR("ring %s timeout, signaled seq=%u, emitted seq=%u\n",
>> -          job->base.sched->name, 
>> atomic_read(&ring->fence_drv.last_seq),
>> -          ring->fence_drv.sync_seq);
>> -    DRM_ERROR("Process information: process %s pid %d thread %s pid 
>> %d\n",
>> -          ti.process_name, ti.tgid, ti.task_name, ti.pid);
>> +              job->base.sched->name, 
>> atomic_read(&ring->fence_drv.last_seq),
>> +              ring->fence_drv.sync_seq);
>
> Unnecessary (and incorrect) indentation change.
>
>
Ah, my bad, looks like copy-paste screwed-up my editor config for 
alignment.
>> +
>> +    ti = amdgpu_vm_get_task_info_pasid(ring->adev, job->pasid);
>> +    if (ti) {
>> +        DRM_ERROR("Process information: process %s pid %d thread %s 
>> pid %d\n",
>> +              ti->process_name, ti->tgid, ti->task_name, ti->pid);
>> +        amdgpu_vm_put_task_info_pasid(ring->adev, ti, job->pasid);
>> +    }
>>         dma_fence_set_error(&s_job->s_fence->finished, -ETIME);
>>   diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
>> index 4baa300121d8..bfd7a6067edd 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
>> @@ -230,8 +230,16 @@ void amdgpu_coredump(struct amdgpu_device *adev, 
>> bool vram_lost,
>>         coredump->reset_vram_lost = vram_lost;
>>   -    if (reset_context->job && reset_context->job->vm)
>> -        coredump->reset_task_info = reset_context->job->vm->task_info;
>> +    if (reset_context->job && reset_context->job->vm) {
>> +        struct amdgpu_task_info *ti;
>> +        struct amdgpu_vm *vm = reset_context->job->vm;
>> +
>> +        ti = amdgpu_vm_get_task_info_vm(vm);
>> +        if (ti) {
>> +            coredump->reset_task_info = *ti;
>> +            amdgpu_vm_put_task_info_vm(ti, vm);
>> +        }
>> +    }
>>         coredump->adev = adev;
>>   diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> index d1b8afd105c9..0c95e10c815d 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> @@ -2347,6 +2347,9 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, 
>> struct amdgpu_vm *vm)
>>         amdgpu_amdkfd_gpuvm_destroy_cb(adev, vm);
>>   +    if (vm->task_info)
>> +        amdgpu_vm_put_task_info_vm(vm->task_info, vm);
>> +
>>       flush_work(&vm->pt_free_work);
>>         root = amdgpu_bo_ref(vm->root.bo);
>> @@ -2507,26 +2510,129 @@ int amdgpu_vm_ioctl(struct drm_device *dev, 
>> void *data, struct drm_file *filp)
>>       return 0;
>>   }
>>   +static void amdgpu_vm_destroy_task_info(struct kref *kref)
>> +{
>> +    struct amdgpu_task_info *ti = container_of(kref, struct 
>> amdgpu_task_info, refcount);
>> +
>> +    kfree(ti);
>> +}
>> +
>> +static inline struct amdgpu_vm *
>> +amdgpu_vm_get_vm_from_pasid(struct amdgpu_device *adev, u32 pasid)
>> +{
>> +    struct amdgpu_vm *vm;
>> +    unsigned long flags;
>> +
>> +    xa_lock_irqsave(&adev->vm_manager.pasids, flags);
>> +    vm = xa_load(&adev->vm_manager.pasids, pasid);
>> +    xa_unlock_irqrestore(&adev->vm_manager.pasids, flags);
>> +
>> +    return vm;
>> +}
>> +
>> +/**
>> + * amdgpu_vm_put_task_info_pasid - reference down the vm task_info ptr
>> + * frees the vm task_info ptr at the last put
>> + *
>> + * @adev: drm device pointer
>> + * @task_info: task_info struct under discussion.
>> + * @pasid: pasid of the VM which contains task_info
>> + */
>> +void amdgpu_vm_put_task_info_pasid(struct amdgpu_device *adev,
>> +                   struct amdgpu_task_info *task_info,
>> +                   u32 pasid)
>> +{
>> +    int ret;
>> +
>> +    ret = kref_put(&task_info->refcount, amdgpu_vm_destroy_task_info);
>> +
>> +    /* Clean up if object was removed in the last put */
>> +    if (ret == 1) {
>> +        struct amdgpu_vm *vm;
>> +
>> +        vm = amdgpu_vm_get_vm_from_pasid(adev, pasid);
>> +        if (!vm) {
>> +            WARN(1, "Invalid PASID %u to put task info\n", pasid);
>> +            return;
>> +        }
>> +
>> +        vm->task_info = NULL;
>
> This doesn't make sense. If there is a VM pointing to the task_info, 
> then the ref count should not go to 0. Therefore this whole "look up 
> the VM from PASID and clear vm->task_info" seams bogus.

Actually, (ret == 1) above indicates that cleanup function has been 
called and task_info has been freed, and the vm->task_info is a dangling 
ptr.

The current design is

- first open per process/fd creates vm->task_info

- last close per process/fd frees vm->task_info

>
> I'd expect the last put_task_info call to come from amdgpu_vm_fini. At 
> that point setting task_info to NULL is probably unnecessary. But if 
> we wanted that, we could set it to NULL in the caller.
>
Even this can be done, I can call the first get_vm_info() from vm_init 
and last put from vm_fini.

>
>> +    }
>> +}
>> +
>> +/**
>> + * amdgpu_vm_put_task_info_vm - reference down the vm task_info ptr
>> + * frees the vm task_info ptr at the last refdown
>> + *
>> + * @task_info: task_info struct under discussion.
>> + * @vm: VM which contains task_info
>> + */
>> +void amdgpu_vm_put_task_info_vm(struct amdgpu_task_info *task_info, 
>> struct amdgpu_vm *vm)
>> +{
>> +    int ret;
>> +
>> +    ret = kref_put(&task_info->refcount, amdgpu_vm_destroy_task_info);
>> +
>> +    /* Clean up if object was removed in the last put */
>> +    if (ret == 1)
>> +        vm->task_info = NULL;
>
> Similar to above: If a VM is pointing to task_info, the ref count 
> should not be 0.
>
> That means, you can merge the two functions into a single 
> amdgpu_vm_put_task_info. No need for a pasid or vm parameter.
>
Same as above.
>
>> +}
>> +
>>   /**
>> - * amdgpu_vm_get_task_info - Extracts task info for a PASID.
>> + * amdgpu_vm_get_task_info_pasid - Extracts task info for a PASID.
>>    *
>>    * @adev: drm device pointer
>>    * @pasid: PASID identifier for VM
>> - * @task_info: task_info to fill.
>> + *
>> + * Returns the respective task_info structure, which must be referenced
>> + * down with amdgpu_vm_put_task_info.
>>    */
>> -void amdgpu_vm_get_task_info(struct amdgpu_device *adev, u32 pasid,
>> -             struct amdgpu_task_info *task_info)
>> +struct amdgpu_task_info *
>> +amdgpu_vm_get_task_info_pasid(struct amdgpu_device *adev, u32 pasid)
>>   {
>>       struct amdgpu_vm *vm;
>> -    unsigned long flags;
>> +    struct amdgpu_task_info *ti = NULL;
>>   -    xa_lock_irqsave(&adev->vm_manager.pasids, flags);
>> +    vm = amdgpu_vm_get_vm_from_pasid(adev, pasid);
>> +    if (vm) {
>> +        ti = vm->task_info;
>> +        kref_get(&vm->task_info->refcount);
>> +    }
>>   -    vm = xa_load(&adev->vm_manager.pasids, pasid);
>> -    if (vm)
>> -        *task_info = vm->task_info;
>> +    return ti;
>> +}
>>   -    xa_unlock_irqrestore(&adev->vm_manager.pasids, flags);
>> +/**
>> + * amdgpu_vm_get_task_info_vm - Extracts task info for a vm.
>> + *
>> + * @vm: VM to get info from
>> + *
>> + * Returns the respective task_info structure, which must be referenced
>> + * down with amdgpu_vm_put_task_info.
>> + */
>> +struct amdgpu_task_info *
>> +amdgpu_vm_get_task_info_vm(struct amdgpu_vm *vm)
>> +{
>> +    struct amdgpu_task_info *ti = NULL;
>> +
>> +    if (vm) {
>> +        ti = vm->task_info;
>> +        kref_get(&vm->task_info->refcount);
>> +    }
>> +
>> +    return ti;
>> +}
>> +
>> +static int amdgpu_vm_create_task_info(struct amdgpu_vm *vm)
>> +{
>> +    vm->task_info = kzalloc(sizeof(struct amdgpu_task_info), 
>> GFP_KERNEL);
>> +    if (!vm->task_info) {
>> +        DRM_ERROR("OOM while creating task_info space\n");
>
> Printing OOM error messages is usually redundant. The allocators are 
> already very noisy when OOM happens. I think checkpatch.pl also warns 
> about that. Maybe it doesn't catch DRM_ERROR but only printk and friends.
>
Agree, I will make this debug instead of error.
>
>> +        return -ENOMEM;
>> +    }
>> +
>> +    kref_init(&vm->task_info->refcount);
>> +    return 0;
>>   }
>>     /**
>> @@ -2536,17 +2642,23 @@ void amdgpu_vm_get_task_info(struct 
>> amdgpu_device *adev, u32 pasid,
>>    */
>>   void amdgpu_vm_set_task_info(struct amdgpu_vm *vm)
>>   {
>> -    if (vm->task_info.pid)
>> +    if (!vm->task_info) {
>> +        if (amdgpu_vm_create_task_info(vm))
>> +            /* OOM */
>> +            return;
>> +    }
>> +
>> +    if (vm->task_info->pid == current->pid)
>>           return;
>>   -    vm->task_info.pid = current->pid;
>> -    get_task_comm(vm->task_info.task_name, current);
>> +    vm->task_info->pid = current->pid;
>> +    get_task_comm(vm->task_info->task_name, current);
>>         if (current->group_leader->mm != current->mm)
>>           return;
>>   -    vm->task_info.tgid = current->group_leader->pid;
>> -    get_task_comm(vm->task_info.process_name, current->group_leader);
>> +    vm->task_info->tgid = current->group_leader->pid;
>> +    get_task_comm(vm->task_info->process_name, current->group_leader);
>>   }
>>     /**
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> index 2cd86d2bf73f..c693772f8942 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> @@ -190,10 +190,11 @@ struct amdgpu_vm_pte_funcs {
>>   };
>>     struct amdgpu_task_info {
>> -    char    process_name[TASK_COMM_LEN];
>> -    char    task_name[TASK_COMM_LEN];
>> -    pid_t    pid;
>> -    pid_t    tgid;
>> +    char        process_name[TASK_COMM_LEN];
>> +    char        task_name[TASK_COMM_LEN];
>> +    pid_t        pid;
>> +    pid_t        tgid;
>> +    struct kref    refcount;
>>   };
>>     /**
>> @@ -356,7 +357,7 @@ struct amdgpu_vm {
>>       uint64_t        pd_phys_addr;
>>         /* Some basic info about the task */
>> -    struct amdgpu_task_info task_info;
>> +    struct amdgpu_task_info *task_info;
>>         /* Store positions of group of BOs */
>>       struct ttm_lru_bulk_move lru_bulk_move;
>> @@ -492,8 +493,19 @@ bool amdgpu_vm_need_pipeline_sync(struct 
>> amdgpu_ring *ring,
>>                     struct amdgpu_job *job);
>>   void amdgpu_vm_check_compute_bug(struct amdgpu_device *adev);
>>   -void amdgpu_vm_get_task_info(struct amdgpu_device *adev, u32 pasid,
>> -                 struct amdgpu_task_info *task_info);
>> +struct amdgpu_task_info *
>> +amdgpu_vm_get_task_info_pasid(struct amdgpu_device *adev, u32 pasid);
>> +
>> +void amdgpu_vm_put_task_info_pasid(struct amdgpu_device *adev,
>> +                   struct amdgpu_task_info *task_info,
>> +                   u32 pasid);
>> +
>> +struct amdgpu_task_info *
>> +amdgpu_vm_get_task_info_vm(struct amdgpu_vm *vm);
>> +
>> +void amdgpu_vm_put_task_info_vm(struct amdgpu_task_info *task_info,
>> +                   struct amdgpu_vm *vm);
>> +
>>   bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
>>                   u32 vmid, u32 node_id, uint64_t addr,
>>                   bool write_fault);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>> index a160265ddc07..d9e895cb0c10 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>> @@ -1027,7 +1027,7 @@ int amdgpu_vm_ptes_update(struct 
>> amdgpu_vm_update_params *params,
>>               trace_amdgpu_vm_update_ptes(params, frag_start, upd_end,
>>                               min(nptes, 32u), dst, incr,
>>                               upd_flags,
>> -                            vm->task_info.tgid,
>> +                            vm->task_info ? vm->task_info->tgid : 0,
>>                               vm->immediate.fence_context);
>>               amdgpu_vm_pte_update_flags(params, to_amdgpu_bo_vm(pt),
>>                              cursor.level, pe_start, dst,
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>> index a5a05c16c10d..e00b2a53b192 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>> @@ -105,7 +105,7 @@ static int gmc_v10_0_process_interrupt(struct 
>> amdgpu_device *adev,
>>       struct amdgpu_vmhub *hub = &adev->vmhub[vmhub_index];
>>       bool retry_fault = !!(entry->src_data[1] & 0x80);
>>       bool write_fault = !!(entry->src_data[1] & 0x20);
>> -    struct amdgpu_task_info task_info;
>> +    struct amdgpu_task_info *task_info;
>>       uint32_t status = 0;
>>       u64 addr;
>>   @@ -157,18 +157,26 @@ static int gmc_v10_0_process_interrupt(struct 
>> amdgpu_device *adev,
>>       if (!printk_ratelimit())
>>           return 0;
>>   -    memset(&task_info, 0, sizeof(struct amdgpu_task_info));
>> -    amdgpu_vm_get_task_info(adev, entry->pasid, &task_info);
>> +    task_info = amdgpu_vm_get_task_info_pasid(adev, entry->pasid);
>> +    if (task_info) {
>> +        dev_err(adev->dev,
>> +            "[%s] page fault (src_id:%u ring:%u vmid:%u pasid:%u, 
>> for process %s pid %d thread %s pid %d)\n",
>> +            entry->vmid_src ? "mmhub" : "gfxhub",
>> +            entry->src_id, entry->ring_id, entry->vmid,
>> +            entry->pasid, task_info->process_name, task_info->tgid,
>> +            task_info->task_name, task_info->pid);
>> +        amdgpu_vm_put_task_info_pasid(adev, task_info, entry->pasid);
>> +    } else {
>> +        dev_err(adev->dev,
>> +            "[%s] page fault (src_id:%u ring:%u vmid:%u pasid:%u, no 
>> process info)\n",
>> +            entry->vmid_src ? "mmhub" : "gfxhub",
>> +            entry->src_id, entry->ring_id, entry->vmid,
>> +            entry->pasid);
>
> Can we avoid the duplication here? It's too easy for them to get out 
> of sync. I think it's OK to change the message format so that the 
> process into is printed on a separate line. E.g.:
>
That's exactly I thought, but then I was afraid of breaking any existing 
scripts grepping for this exact text. I guess I can do this change and 
see if anyone complaints :).

- Shashank

> dev_err(adev->dev,
> -        "[%s] page fault (src_id:%u ring:%u vmid:%u pasid:%u, for 
> process %s pid %d thread %s pid %d)\n",
> +        "[%s] page fault (src_id:%u ring:%u vmid:%u pasid:%u)\n",
>          entry->vmid_src ? "mmhub" : "gfxhub",
>          entry->src_id, entry->ring_id, entry->vmid,
> -        entry->pasid, task_info.process_name, task_info.tgid,
> -        task_info.task_name, task_info.pid);
> +         entry->pasid);
> +    if (task_info) {
> +        dev_err(adev->dev, "  in process %s pid %d thread %s pid %d\n",
> +            task_info.process_name, task_info.tgid,
> +            task_info.task_name, task_info.pid);
> +    }
>
>
>> +    }
>>   -    dev_err(adev->dev,
>> -        "[%s] page fault (src_id:%u ring:%u vmid:%u pasid:%u, for 
>> process %s pid %d thread %s pid %d)\n",
>> -        entry->vmid_src ? "mmhub" : "gfxhub",
>> -        entry->src_id, entry->ring_id, entry->vmid,
>> -        entry->pasid, task_info.process_name, task_info.tgid,
>> -        task_info.task_name, task_info.pid);
>>       dev_err(adev->dev, "  in page starting at address 0x%016llx 
>> from client 0x%x (%s)\n",
>> -        addr, entry->client_id,
>> -        soc15_ih_clientid_name[entry->client_id]);
>> +            addr, entry->client_id,
>> +            soc15_ih_clientid_name[entry->client_id]);
>>         if (!amdgpu_sriov_vf(adev))
>> hub->vmhub_funcs->print_l2_protection_fault_status(adev,
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
>> index 23d7b548d13f..3dda6c310729 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
>> @@ -126,19 +126,28 @@ static int gmc_v11_0_process_interrupt(struct 
>> amdgpu_device *adev,
>>       }
>>         if (printk_ratelimit()) {
>> -        struct amdgpu_task_info task_info;
>> -
>> -        memset(&task_info, 0, sizeof(struct amdgpu_task_info));
>> -        amdgpu_vm_get_task_info(adev, entry->pasid, &task_info);
>> +        struct amdgpu_task_info *task_info;
>> +
>> +        task_info = amdgpu_vm_get_task_info_pasid(adev, entry->pasid);
>> +        if (task_info) {
>> +            dev_err(adev->dev,
>> +                "[%s] page fault (src_id:%u ring:%u vmid:%u 
>> pasid:%u, for process %s pid %d thread %s pid %d)\n",
>> +                entry->vmid_src ? "mmhub" : "gfxhub",
>> +                entry->src_id, entry->ring_id, entry->vmid,
>> +                entry->pasid, task_info->process_name, task_info->tgid,
>> +                task_info->task_name, task_info->pid);
>> +            amdgpu_vm_put_task_info_pasid(adev, task_info, 
>> entry->pasid);
>> +        } else {
>> +            dev_err(adev->dev,
>> +                "[%s] page fault (src_id:%u ring:%u vmid:%u 
>> pasid:%u, no process info)\n",
>> +                entry->vmid_src ? "mmhub" : "gfxhub",
>> +                entry->src_id, entry->ring_id, entry->vmid,
>> +                entry->pasid);
>> +        }
>
> Same as above.
>
>
>>   -        dev_err(adev->dev,
>> -            "[%s] page fault (src_id:%u ring:%u vmid:%u pasid:%u, 
>> for process %s pid %d thread %s pid %d)\n",
>> -            entry->vmid_src ? "mmhub" : "gfxhub",
>> -            entry->src_id, entry->ring_id, entry->vmid,
>> -            entry->pasid, task_info.process_name, task_info.tgid,
>> -            task_info.task_name, task_info.pid);
>>           dev_err(adev->dev, "  in page starting at address 0x%016llx 
>> from client %d\n",
>> -            addr, entry->client_id);
>> +                addr, entry->client_id);
>> +
>>           if (!amdgpu_sriov_vf(adev))
>> hub->vmhub_funcs->print_l2_protection_fault_status(adev, status);
>>       }
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
>> index ff4ae73d27ec..aa3887c3bb35 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
>> @@ -1444,18 +1444,24 @@ static int gmc_v8_0_process_interrupt(struct 
>> amdgpu_device *adev,
>>           gmc_v8_0_set_fault_enable_default(adev, false);
>>         if (printk_ratelimit()) {
>> -        struct amdgpu_task_info task_info;
>> -
>> -        memset(&task_info, 0, sizeof(struct amdgpu_task_info));
>> -        amdgpu_vm_get_task_info(adev, entry->pasid, &task_info);
>> +        struct amdgpu_task_info *task_info;
>> +
>> +        task_info = amdgpu_vm_get_task_info_pasid(adev, entry->pasid);
>> +        if (task_info) {
>> +            dev_err(adev->dev, "GPU fault detected: %d 0x%08x for 
>> process %s pid %d thread %s pid %d\n",
>> +                entry->src_id, entry->src_data[0], 
>> task_info->process_name,
>> +                task_info->tgid, task_info->task_name, task_info->pid);
>> +            amdgpu_vm_put_task_info_pasid(adev, task_info, 
>> entry->pasid);
>> +        } else {
>> +            dev_err(adev->dev, "GPU fault detected: %d 0x%08x (no 
>> process info)\n",
>> +                entry->src_id, entry->src_data[0]);
>> +        }
> Same as above.
>
>
>>   -        dev_err(adev->dev, "GPU fault detected: %d 0x%08x for 
>> process %s pid %d thread %s pid %d\n",
>> -            entry->src_id, entry->src_data[0], task_info.process_name,
>> -            task_info.tgid, task_info.task_name, task_info.pid);
>>           dev_err(adev->dev, " VM_CONTEXT1_PROTECTION_FAULT_ADDR   
>> 0x%08X\n",
>> -            addr);
>> +                addr);
>>           dev_err(adev->dev, " VM_CONTEXT1_PROTECTION_FAULT_STATUS 
>> 0x%08X\n",
>>               status);
>> +
>>           gmc_v8_0_vm_decode_fault(adev, status, addr, mc_client,
>>                        entry->pasid);
>>       }
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>> index 2ac5820e9c92..075d633109e3 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>> @@ -549,7 +549,7 @@ static int gmc_v9_0_process_interrupt(struct 
>> amdgpu_device *adev,
>>       bool retry_fault = !!(entry->src_data[1] & 0x80);
>>       bool write_fault = !!(entry->src_data[1] & 0x20);
>>       uint32_t status = 0, cid = 0, rw = 0;
>> -    struct amdgpu_task_info task_info;
>> +    struct amdgpu_task_info *task_info;
>>       struct amdgpu_vmhub *hub;
>>       const char *mmhub_cid;
>>       const char *hub_name;
>> @@ -626,15 +626,23 @@ static int gmc_v9_0_process_interrupt(struct 
>> amdgpu_device *adev,
>>       if (!printk_ratelimit())
>>           return 0;
>>   -    memset(&task_info, 0, sizeof(struct amdgpu_task_info));
>> -    amdgpu_vm_get_task_info(adev, entry->pasid, &task_info);
>> +    task_info = amdgpu_vm_get_task_info_pasid(adev, entry->pasid);
>> +    if (task_info) {
>> +        dev_err(adev->dev,
>> +            "[%s] %s page fault (src_id:%u ring:%u vmid:%u pasid:%u, 
>> for process %s pid %d thread %s pid %d)\n",
>> +            hub_name, retry_fault ? "retry" : "no-retry",
>> +            entry->src_id, entry->ring_id, entry->vmid,
>> +            entry->pasid, task_info->process_name, task_info->tgid,
>> +            task_info->task_name, task_info->pid);
>> +        amdgpu_vm_put_task_info_pasid(adev, task_info, entry->pasid);
>> +    } else {
>> +        dev_err(adev->dev,
>> +            "[%s] %s page fault (src_id:%u ring:%u vmid:%u pasid:%u, 
>> no process info)\n",
>> +            hub_name, retry_fault ? "retry" : "no-retry",
>> +            entry->src_id, entry->ring_id, entry->vmid,
>> +            entry->pasid);
>> +    }
> Same as above.
>
>
>>   -    dev_err(adev->dev,
>> -        "[%s] %s page fault (src_id:%u ring:%u vmid:%u pasid:%u, for 
>> process %s pid %d thread %s pid %d)\n",
>> -        hub_name, retry_fault ? "retry" : "no-retry",
>> -        entry->src_id, entry->ring_id, entry->vmid,
>> -        entry->pasid, task_info.process_name, task_info.tgid,
>> -        task_info.task_name, task_info.pid);
>>       dev_err(adev->dev, "  in page starting at address 0x%016llx 
>> from IH client 0x%x (%s)\n",
>>           addr, entry->client_id,
>>           soc15_ih_clientid_name[entry->client_id]);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
>> index 3d68dd5523c6..515d1a1ff141 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
>> @@ -2104,7 +2104,7 @@ static int sdma_v4_0_print_iv_entry(struct 
>> amdgpu_device *adev,
>>                             struct amdgpu_iv_entry *entry)
>>   {
>>       int instance;
>> -    struct amdgpu_task_info task_info;
>> +    struct amdgpu_task_info *task_info;
>>       u64 addr;
>>         instance = sdma_v4_0_irq_id_to_seq(entry->client_id);
>> @@ -2116,15 +2116,23 @@ static int sdma_v4_0_print_iv_entry(struct 
>> amdgpu_device *adev,
>>       addr = (u64)entry->src_data[0] << 12;
>>       addr |= ((u64)entry->src_data[1] & 0xf) << 44;
>>   -    memset(&task_info, 0, sizeof(struct amdgpu_task_info));
>> -    amdgpu_vm_get_task_info(adev, entry->pasid, &task_info);
>> +    task_info = amdgpu_vm_get_task_info_pasid(adev, entry->pasid);
>> +    if (task_info) {
>> +        dev_dbg_ratelimited(adev->dev,
>> +            "[sdma%d] address:0x%016llx src_id:%u ring:%u vmid:%u "
>> +            "pasid:%u, for process %s pid %d thread %s pid %d\n",
>> +            instance, addr, entry->src_id, entry->ring_id, entry->vmid,
>> +            entry->pasid, task_info->process_name, task_info->tgid,
>> +            task_info->task_name, task_info->pid);
>> +        amdgpu_vm_put_task_info_pasid(adev, task_info, entry->pasid);
>> +    } else {
>> +        dev_dbg_ratelimited(adev->dev,
>> +            "[sdma%d] address:0x%016llx src_id:%u ring:%u vmid:%u "
>> +            "pasid:%u, no process info\n",
>> +            instance, addr, entry->src_id, entry->ring_id, entry->vmid,
>> +            entry->pasid);
>> +    }
> Same as above.
>
>
>>   -    dev_dbg_ratelimited(adev->dev,
>> -           "[sdma%d] address:0x%016llx src_id:%u ring:%u vmid:%u "
>> -           "pasid:%u, for process %s pid %d thread %s pid %d\n",
>> -           instance, addr, entry->src_id, entry->ring_id, entry->vmid,
>> -           entry->pasid, task_info.process_name, task_info.tgid,
>> -           task_info.task_name, task_info.pid);
>>       return 0;
>>   }
>>   diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c 
>> b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
>> index 0f24af6f2810..d7e23bd90f7f 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
>> @@ -1642,7 +1642,7 @@ static int sdma_v4_4_2_print_iv_entry(struct 
>> amdgpu_device *adev,
>>                             struct amdgpu_iv_entry *entry)
>>   {
>>       int instance;
>> -    struct amdgpu_task_info task_info;
>> +    struct amdgpu_task_info *task_info;
>>       u64 addr;
>>         instance = sdma_v4_4_2_irq_id_to_seq(entry->client_id);
>> @@ -1654,15 +1654,23 @@ static int sdma_v4_4_2_print_iv_entry(struct 
>> amdgpu_device *adev,
>>       addr = (u64)entry->src_data[0] << 12;
>>       addr |= ((u64)entry->src_data[1] & 0xf) << 44;
>>   -    memset(&task_info, 0, sizeof(struct amdgpu_task_info));
>> -    amdgpu_vm_get_task_info(adev, entry->pasid, &task_info);
>> +    task_info = amdgpu_vm_get_task_info_pasid(adev, entry->pasid);
>> +    if (task_info) {
>> +        dev_dbg_ratelimited(adev->dev,
>> +            "[sdma%d] address:0x%016llx src_id:%u ring:%u vmid:%u "
>> +            "pasid:%u, for process %s pid %d thread %s pid %d\n",
>> +            instance, addr, entry->src_id, entry->ring_id, entry->vmid,
>> +            entry->pasid, task_info->process_name, task_info->tgid,
>> +            task_info->task_name, task_info->pid);
>> +        amdgpu_vm_put_task_info_pasid(adev, task_info, entry->pasid);
>> +    } else {
>> +        dev_dbg_ratelimited(adev->dev,
>> +            "[sdma%d] address:0x%016llx src_id:%u ring:%u vmid:%u "
>> +            "pasid:%u (no process info)\n",
>> +            instance, addr, entry->src_id, entry->ring_id, entry->vmid,
>> +            entry->pasid);
>> +    }
> Same as above.
>
> Regards,
>   Felix
>
>
>>   -    dev_dbg_ratelimited(adev->dev,
>> -           "[sdma%d] address:0x%016llx src_id:%u ring:%u vmid:%u "
>> -           "pasid:%u, for process %s pid %d thread %s pid %d\n",
>> -           instance, addr, entry->src_id, entry->ring_id, entry->vmid,
>> -           entry->pasid, task_info.process_name, task_info.tgid,
>> -           task_info.task_name, task_info.pid);
>>       return 0;
>>   }
>>   diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c 
>> b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
>> index d9953c2b2661..0dfe4b3bd18a 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
>> @@ -238,16 +238,16 @@ void 
>> kfd_smi_event_update_thermal_throttling(struct kfd_node *dev,
>>     void kfd_smi_event_update_vmfault(struct kfd_node *dev, uint16_t 
>> pasid)
>>   {
>> -    struct amdgpu_task_info task_info;
>> -
>> -    memset(&task_info, 0, sizeof(struct amdgpu_task_info));
>> -    amdgpu_vm_get_task_info(dev->adev, pasid, &task_info);
>> -    /* Report VM faults from user applications, not retry from 
>> kernel */
>> -    if (!task_info.pid)
>> -        return;
>> -
>> -    kfd_smi_event_add(0, dev, KFD_SMI_EVENT_VMFAULT, "%x:%s\n",
>> -              task_info.pid, task_info.task_name);
>> +    struct amdgpu_task_info *task_info;
>> +
>> +    task_info = amdgpu_vm_get_task_info_pasid(dev->adev, pasid);
>> +    if (task_info) {
>> +        /* Report VM faults from user applications, not retry from 
>> kernel */
>> +        if (task_info->pid)
>> +            kfd_smi_event_add(0, dev, KFD_SMI_EVENT_VMFAULT, "%x:%s\n",
>> +                     task_info->pid, task_info->task_name);
>> +        amdgpu_vm_put_task_info_pasid(dev->adev, task_info, pasid);
>> +    }
>>   }
>>     void kfd_smi_event_page_fault_start(struct kfd_node *node, pid_t 
>> pid,
