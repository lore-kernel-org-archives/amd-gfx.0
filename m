Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F405FC3DA6E
	for <amd-gfx@archiver.kernel.org>; Wed,  3 Jan 2024 09:47:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F42610E225;
	Wed,  3 Jan 2024 09:47:16 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::600])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5727810E225
 for <amd-gfx@lists.freedesktop.org>; Wed,  3 Jan 2024 09:47:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a2GD1tpmUnODokDTatXJuW6Xn+QiK3Fj0y34PJIefQwVfVracYAX7iD6uaT6lhSc2hmxF96zy/ZtzdWsBCDrR+EyuWhVWOoTMNjAdCUDK+kWnWWyptnr2Xdm2JF+eb9BDZZyCwFOdRaX7QT+zeLhCL4zoKriTrIHK95Bm9R87+AHGeviLsB5vJ95Vlr1ddgQGrwPBQE0pC7mT+pMIgiqbE4hO9u9y6GW+kVtAdpTlB5mrlPo2qx0yIPhf5zSORIk8vE1Hgr0UJjIBZ/1URATRR8SrF+kIMOxlVLx28Rsy/Sm7oE5t6ybxr2dLIe++6lZUxE4TwRNdv0k4FbcuQOr6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/+mIT39NlN2m2Bg8em3AGNUYMaWbP5kikGZF6sA4LNU=;
 b=YdtWxCfn5TiexzMq0pWhQyh2HIy+aRxR4XBDkzXWMjYTAQASOKdHLC6i5uN+RDr5GiAs22EMDi8a/mXTLbQh2A4rUZqXvlLUIZg02PxHxkRulevh4ibS4jFxk3e6DBdKGUxfXZ33ccn+Sf79veLtMj4yKxvxOXtEDBSr9QHoRJNcTfQIgyJZoq1a8cewwC+JEhc7eBVBuYGLK19YwsLE1OB7t/IPeU8ApXpEGxvqbtv2ioBZWH+Pj43Rv5eggCFBcOtTpzvSJ9ZOLR+Nn2t7ukn64PIAn+GBmTmlKzlui02W2xSZKnaFe0k1iKlAFUmHK9bTAReMwZj+CL4IUbKyGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/+mIT39NlN2m2Bg8em3AGNUYMaWbP5kikGZF6sA4LNU=;
 b=dyHO8vBCDSWSv4LJJvwciVK+z27jWODdtornzcToJtjcYQsHXUcZuEOnSq9ZkwBCKUVQrJHNnfBVSOuDsd0CDkH8Nxd2+DgS7aotYf6esZkgXFXOHecOyEka9BN/BpdnqBIPpSqKrJRfJqRBaQAkMVnpctp7L0Z5+kenQ10PuXI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by IA1PR12MB8407.namprd12.prod.outlook.com (2603:10b6:208:3d9::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.25; Wed, 3 Jan
 2024 09:47:11 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::f8bf:e004:1555:f21c]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::f8bf:e004:1555:f21c%6]) with mapi id 15.20.7135.023; Wed, 3 Jan 2024
 09:47:11 +0000
Message-ID: <83a56b0c-3622-50f3-2225-0e8f1bd5bc62@amd.com>
Date: Wed, 3 Jan 2024 10:47:06 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] drm/amdgpu: change vm->task_info handling
To: Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240102111235.137-1-shashank.sharma@amd.com>
 <beb4c574-60d1-4ce4-ab9c-c574ec94a23c@amd.com>
Content-Language: en-US
From: Shashank Sharma <shashank.sharma@amd.com>
In-Reply-To: <beb4c574-60d1-4ce4-ab9c-c574ec94a23c@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BE1P281CA0417.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:83::18) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|IA1PR12MB8407:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fda8e8c-19aa-47f2-6252-08dc0c40f504
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OOXMH5vl2nlEcUh4ca1NtwPfu3KQsS4EFd1y9UgvtLc2nLTuLKHtmPg3SVoFkn9n8ivI02YkU8oMsJMEniidaFu2Rlgd1dwGBhwTVpWbTkLJg8KsZmSIlIpN1ctkJ/ZXOIA9UyL5XOgm0/ju/MAFF31xTmyxGI0ZgisnH1fa50mWnNzJCTsmaTq3ZbHC7VXT2WwDom3UbkKWFNA033vr1tTYUqxjwa8y4W4+Dmz6XtpnywaDEF+bdzpeZ5ufn15t+oc9qzYMXzIi9KJrtOZf6YvupjGphDqTfYoSJUyFS6680iAZrdPmfPtbJfwQgvU3KyPf2z7oHDUIjem3N04QloO7FK9Yw8EPRXxU+2eJTHMs2f1u5u6LTD/iZLqCjqNYYWZ29Vh/c3i6dq77CUPq8XpP7Bk3q1np9YkZd9LOFT1OsZEn9raWgd4zkl8Cucxo5FftRxEL6OKVdPpZ6OMDDxywkyuG4Xp+2b+MxwPmIYuIkiaQh7swJA9hVPYh9D3nTgyGXzUpACntxVnK2K9bXq4ftiOrjNxMgRqJoEw7MZKArpTgyQ5vRjmnwF6M41yNTb2oLcKyZjB7UawP+lFgdFA+PFQxEbsNSCWiSB8nROsTQbwqLBvMYJCkaGVP38m5xI72fY/Yni4I4yEWef2dpQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(376002)(366004)(346002)(396003)(136003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(6506007)(26005)(2616005)(83380400001)(6666004)(6512007)(53546011)(30864003)(5660300002)(4326008)(44832011)(41300700001)(478600001)(6486002)(66946007)(2906002)(316002)(8676002)(8936002)(66476007)(66556008)(54906003)(86362001)(31696002)(38100700002)(36756003)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RTZnUWFBSGFaaEV2ek44OHd4d3JHRU5nQ0FwTXJabytiN01tYUVXc0hnRGxt?=
 =?utf-8?B?WXFmb2tmdWFZQ0xhT0NVUkROaHFqbXdnN21PMk1VZXlvbkluamxpY2hxNWl0?=
 =?utf-8?B?cTRIZjQvWit5NGo3Yi9QcWNaMDNhMkYwdlBESDgrMzd3b2FpdVZ2Zjk0N0Fw?=
 =?utf-8?B?Wk1DUGR0ZUQ0TDZyaGRrSjFxdU5TZzkxV2Nkd043bnR2c1RTTStJYm5Zb25X?=
 =?utf-8?B?K0hFSVB3cEFjMnNTVFRBRDBjeFFKcGFtTGFXNy9HT0dtb1puN3NmbjJPanRR?=
 =?utf-8?B?MlRKbzJGanhpa2ZiNlBEbFYrOTJ0TVVaK0t2czVYbnlEdlhLeGlWTW0wMGp2?=
 =?utf-8?B?MmQ4T2NobjBhNUxRYTg1ODc0RGN4bUMreXJ3UG5aaXN4ME9tOHltZG0yU3NM?=
 =?utf-8?B?OUlYTE1FeStBanBneHI0WElhSVd3NjA4WUhxWS9jdlU4WDFzRmFXeml1L0dT?=
 =?utf-8?B?UUVrWjR0UWNKYjU1RllidmRpdVhraTJJd1NTWkEzTndFS1gralgveW9WeDBB?=
 =?utf-8?B?MU0vbnkvS2xlWkJLL3c2TWpDT0N1bU5uNERJV1A2SDc5akw3K09leGM0QnVO?=
 =?utf-8?B?ZGpuMXRzQ3IySlIySHpzSUdVcGNLK0VqbDJDeG9hU3lOUTN3eWdXSnBrUjcz?=
 =?utf-8?B?M2R2SjNCTEFIdWlVSFRlSWlzK1FvYUllTkJ3NWE5TDlZbjh3dlBxekdoL3FD?=
 =?utf-8?B?T0ZxT2lUeERLY1NGNWVOdXpSUjgrK2Y0Q0lVbjhEdTZxc1FTa3N6OXpGTHhT?=
 =?utf-8?B?MDVvQm56bnp1MlZ0OHpJako0TXJrRmZLT3drVnBxZEs4TGowMHYzRjY3ZHRL?=
 =?utf-8?B?bVVLeU8xTllhVjl2cWw5MFhuc1BPNnFMMThTMm1JSWtFT1lTRnBuVC9vNmVV?=
 =?utf-8?B?SEIvcUU0T1lCNlg0RlNibmFSL2s2MkszMnNRS3JheFE0OWtpbEl2UGQrM0V6?=
 =?utf-8?B?RWlRU1ZqcC9zN2prQzV5RytUMGZ2NzVjbElaaFZKejFOdk40cjBLaEJzK0FG?=
 =?utf-8?B?TmJmZTQvL3BId2k4Tk40ZzNZdDhiMFdHZC9YbjJ1K3k5SmZ0NitpT3dzczlz?=
 =?utf-8?B?TWV6NHVtSnhuejNiTDAweS9SRW1XU28rVWE2aEhoUkxGQlJoenp3eDAwOTdr?=
 =?utf-8?B?NFJLa1NmdGlrOGRnUFFsdUlTZm1vVWNPZmVkeHo4UEFEeHdUMWlGUGd0akNz?=
 =?utf-8?B?aWdpTkl3WG94NExyYklYcGlkd256bEtETDBGai8xQkVOdFkrWWk0YmlGQWxs?=
 =?utf-8?B?dkFvUGlZaDJweEdzNnB6NDFtRFFkVERnRG1WcnZ0TWkxTjBBT1ZmaXdrdTFI?=
 =?utf-8?B?U3JaZDN5bUNZRTBod0RON2xZbW1wMzkrYm1jbVJZdkdxMXhHU3dtbE8vUktp?=
 =?utf-8?B?WFVkWWFLYmZDcm45eU45cUJtd1N6cUdldDg1VWF5QjRqR0thSkhMTG1mRUJr?=
 =?utf-8?B?Y29WN01kOVN4a3ArdEsza1dyZWJybi8wbSsvQWRpd0hPK1hpVHd5a2JpTHZw?=
 =?utf-8?B?Vk9VSzcydUJiNWhpMEthSkNMamZZTEhRamtpdFlRb3R0UTZHcWp2Q2ZqRmxt?=
 =?utf-8?B?U3FMbWpMbW10Q3B2eVZvK3BGSThUcVdoc2hZTG1kc2pvTVVpQ2c2QXZ5T0Uw?=
 =?utf-8?B?Z1UvSStzbXN2QTduSnh0SXlCVERRa2JJdE5FZG9sNElYTFNqTGYyUG9Ma0wy?=
 =?utf-8?B?ZmN1V3BsYk55WlhxNW9NcnF3ZXlBZkFSRkZKajRyK2kwRzI5L0prUVpzMTdC?=
 =?utf-8?B?bFZuNDB5Q0RxR1YrS293WlFxWlJrazViSWlKaCsxV2dFVU1rb3BnMFNBYm05?=
 =?utf-8?B?dDNBV3RkaGNzd0dJK0pLNUpJVzd1ZjVzZnF6YWNuTFV0VXVhb3RxK1djd1gz?=
 =?utf-8?B?cEdCemFtajV3aEJBYzVuTzFuRVZ4dUYrVy8zdTkxRWVvT1hlWHRTWVBnbEh6?=
 =?utf-8?B?Z0xOR2tPbU5HUCtjdmVaSjJYNzFOVXp5THVVU0tycFFzREdDSTJaWmNkcnZ3?=
 =?utf-8?B?VWZzYmNmbU41ZmM3b1VOMlNYMHo2WUtDUVhWa050VGhSREN2b1Y5TzZFVENQ?=
 =?utf-8?B?ZGN5cm9CZWZKUHBiVlVIRzR2YjBSRDZmdXlTYVIxNTc3NGpiV1NDakkydVVN?=
 =?utf-8?Q?/zG6YxIuz+Z9Cfzt89nlaQN13?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fda8e8c-19aa-47f2-6252-08dc0c40f504
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2024 09:47:11.0663 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2EsK7wft9Ojb/qj5BbIS8zPddSC9efTVMcTVMDauLs991Vz1J4IGY/toOzdEpc8nNhgQngwox+BH7c+mXXm+tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8407
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

Hey Felix,

On 02/01/2024 19:02, Felix Kuehling wrote:
>
> On 2024-01-02 06:12, Shashank Sharma wrote:
>> drm/amdgpu: change vm->task_info handling
>>
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
>> Cc: Christian Koenig <christian.koenig@amd.com>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Cc: Felix Kuehling <Felix.Kuehling@amd.com>
>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |   7 +-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |  15 ++-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_job.c     |  17 ++-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c      | 142 +++++++++++++++++---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h      |  24 +++-
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c   |   2 +-
>>   drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c      |  27 ++--
>>   drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c      |  28 ++--
>>   drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c       |  26 ++--
>>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c       |  28 ++--
>>   drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c      |  20 +--
>>   drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c    |  19 +--
>>   drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c |  17 +--
>>   13 files changed, 259 insertions(+), 113 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>> index a4faea4fa0b5..111f8afb03a1 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>> @@ -1763,9 +1763,12 @@ static int amdgpu_debugfs_vm_info_show(struct 
>> seq_file *m, void *unused)
>>       list_for_each_entry(file, &dev->filelist, lhead) {
>>           struct amdgpu_fpriv *fpriv = file->driver_priv;
>>           struct amdgpu_vm *vm = &fpriv->vm;
>> +        struct amdgpu_task_info *ti;
>> +
>> +        ti = amdgpu_vm_get_task_info_vm(vm);
>> +        seq_printf(m, "pid:%d\tProcess:%s ----------\n", ti->pid, 
>> ti->process_name);
>> +        amdgpu_vm_put_task_info_vm(ti, vm);
>>   -        seq_printf(m, "pid:%d\tProcess:%s ----------\n",
>> -                vm->task_info.pid, vm->task_info.process_name);
>>           r = amdgpu_bo_reserve(vm->root.bo, true);
>>           if (r)
>>               break;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index 2b8356699f23..00516fa178b5 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -4952,10 +4952,17 @@ int amdgpu_do_asic_reset(struct list_head 
>> *device_list_handle,
>>                   tmp_adev->reset_vram_lost = vram_lost;
>>                   memset(&tmp_adev->reset_task_info, 0,
>>                           sizeof(tmp_adev->reset_task_info));
>> -                if (reset_context->job && reset_context->job->vm)
>> -                    tmp_adev->reset_task_info =
>> - reset_context->job->vm->task_info;
>> -                amdgpu_reset_capture_coredumpm(tmp_adev);
>> +                if (reset_context->job && reset_context->job->vm) {
>> +                    struct amdgpu_task_info *ti;
>> +                    struct amdgpu_vm *vm = reset_context->job->vm;
>> +
>> +                    ti = amdgpu_vm_get_task_info_vm(vm);
>> +                    if (ti) {
>> +                        tmp_adev->reset_task_info = *ti;
>> + amdgpu_reset_capture_coredumpm(tmp_adev);
>> +                        amdgpu_vm_put_task_info_vm(ti, vm);
>> +                    }
>> +                }
>>   #endif
>>                   if (vram_lost) {
>>                       DRM_INFO("VRAM is lost due to GPU reset!\n");
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
>> index 78476bc75b4e..b89ee6ab7db9 100644
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
>> @@ -58,12 +58,15 @@ static enum drm_gpu_sched_stat 
>> amdgpu_job_timedout(struct drm_sched_job *s_job)
>>           goto exit;
>>       }
>>   -    amdgpu_vm_get_task_info(ring->adev, job->pasid, &ti);
>> -    DRM_ERROR("ring %s timeout, signaled seq=%u, emitted seq=%u\n",
>> -          job->base.sched->name, 
>> atomic_read(&ring->fence_drv.last_seq),
>> -          ring->fence_drv.sync_seq);
>> -    DRM_ERROR("Process information: process %s pid %d thread %s pid 
>> %d\n",
>> -          ti.process_name, ti.tgid, ti.task_name, ti.pid);
>> +    ti = amdgpu_vm_get_task_info_pasid(ring->adev, job->pasid);
>> +    if (ti) {
>> +        DRM_ERROR("ring %s timeout, signaled seq=%u, emitted seq=%u\n",
>> +              job->base.sched->name, 
>> atomic_read(&ring->fence_drv.last_seq),
>> +              ring->fence_drv.sync_seq);
>> +        DRM_ERROR("Process information: process %s pid %d thread %s 
>> pid %d\n",
>> +              ti->process_name, ti->tgid, ti->task_name, ti->pid);
>> +        amdgpu_vm_put_task_info_pasid(ring->adev, ti, job->pasid);
>> +    }
>>         dma_fence_set_error(&s_job->s_fence->finished, -ETIME);
>>   diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> index 82f25996ff5e..0d655bffad7f 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> @@ -2332,6 +2332,9 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, 
>> struct amdgpu_vm *vm)
>>         amdgpu_amdkfd_gpuvm_destroy_cb(adev, vm);
>>   +    if (vm->task_info)
>> +        amdgpu_vm_put_task_info_vm(vm->task_info, vm);
>> +
>>       flush_work(&vm->pt_free_work);
>>         root = amdgpu_bo_ref(vm->root.bo);
>> @@ -2492,26 +2495,129 @@ int amdgpu_vm_ioctl(struct drm_device *dev, 
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
>> +        return -ENOMEM;
>> +    }
>> +
>> +    kref_init(&vm->task_info->refcount);
>> +    return 0;
>>   }
>>     /**
>> @@ -2521,17 +2627,23 @@ void amdgpu_vm_get_task_info(struct 
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
>> index 204ab13184ed..c2dce85d4f9e 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> @@ -183,10 +183,11 @@ struct amdgpu_vm_pte_funcs {
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
>> @@ -334,7 +335,7 @@ struct amdgpu_vm {
>>       uint64_t        pd_phys_addr;
>>         /* Some basic info about the task */
>> -    struct amdgpu_task_info task_info;
>> +    struct amdgpu_task_info *task_info;
>>         /* Store positions of group of BOs */
>>       struct ttm_lru_bulk_move lru_bulk_move;
>> @@ -466,8 +467,17 @@ bool amdgpu_vm_need_pipeline_sync(struct 
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
>> +struct amdgpu_task_info *amdgpu_vm_get_task_info_vm(struct amdgpu_vm 
>> *vm);
>> +
>> +void amdgpu_vm_put_task_info_vm(struct amdgpu_task_info *task_info, 
>> struct amdgpu_vm *vm);
>> +
>>   bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
>>                   u32 vmid, u32 node_id, uint64_t addr,
>>                   bool write_fault);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>> index 96d601e209b8..f8323957d8bf 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>> @@ -1032,7 +1032,7 @@ int amdgpu_vm_ptes_update(struct 
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
>> index fa87a85e1017..12c624876243 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>> @@ -107,7 +107,7 @@ static int gmc_v10_0_process_interrupt(struct 
>> amdgpu_device *adev,
>>       struct amdgpu_vmhub *hub = &adev->vmhub[vmhub_index];
>>       bool retry_fault = !!(entry->src_data[1] & 0x80);
>>       bool write_fault = !!(entry->src_data[1] & 0x20);
>> -    struct amdgpu_task_info task_info;
>> +    struct amdgpu_task_info *task_info;
>>       uint32_t status = 0;
>>       u64 addr;
>>   @@ -155,18 +155,19 @@ static int gmc_v10_0_process_interrupt(struct 
>> amdgpu_device *adev,
>>       if (!printk_ratelimit())
>>           return 0;
>>   -    memset(&task_info, 0, sizeof(struct amdgpu_task_info));
>> -    amdgpu_vm_get_task_info(adev, entry->pasid, &task_info);
>> -
>> -    dev_err(adev->dev,
>> -        "[%s] page fault (src_id:%u ring:%u vmid:%u pasid:%u, for 
>> process %s pid %d thread %s pid %d)\n",
>> -        entry->vmid_src ? "mmhub" : "gfxhub",
>> -        entry->src_id, entry->ring_id, entry->vmid,
>> -        entry->pasid, task_info.process_name, task_info.tgid,
>> -        task_info.task_name, task_info.pid);
>> -    dev_err(adev->dev, "  in page starting at address 0x%016llx from 
>> client 0x%x (%s)\n",
>> -        addr, entry->client_id,
>> -        soc15_ih_clientid_name[entry->client_id]);
>> +    task_info = amdgpu_vm_get_task_info_pasid(adev, entry->pasid);
>> +    if (task_info) {
> This drops a lot of useful information from entry if task_info is not 
> found for any reason. Please separate this so that entry->... 
> information can still be printed when there is no task_info.
>
Agree, I will fix this, and all others like this.

- Shashank

>
>> +        dev_err(adev->dev,
>> +            "[%s] page fault (src_id:%u ring:%u vmid:%u pasid:%u, 
>> for process %s pid %d thread %s pid %d)\n",
>> +            entry->vmid_src ? "mmhub" : "gfxhub",
>> +            entry->src_id, entry->ring_id, entry->vmid,
>> +            entry->pasid, task_info->process_name, task_info->tgid,
>> +            task_info->task_name, task_info->pid);
>> +        dev_err(adev->dev, "  in page starting at address 0x%016llx 
>> from client 0x%x (%s)\n",
>> +            addr, entry->client_id,
>> +            soc15_ih_clientid_name[entry->client_id]);
>> +        amdgpu_vm_put_task_info_pasid(adev, task_info, entry->pasid);
>> +    }
>>         if (!amdgpu_sriov_vf(adev))
>> hub->vmhub_funcs->print_l2_protection_fault_status(adev,
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
>> index e3b76fd28d15..ec61e371120a 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
>> @@ -120,19 +120,21 @@ static int gmc_v11_0_process_interrupt(struct 
>> amdgpu_device *adev,
>>       }
>>         if (printk_ratelimit()) {
>> -        struct amdgpu_task_info task_info;
>> -
>> -        memset(&task_info, 0, sizeof(struct amdgpu_task_info));
>> -        amdgpu_vm_get_task_info(adev, entry->pasid, &task_info);
>> -
>> -        dev_err(adev->dev,
>> -            "[%s] page fault (src_id:%u ring:%u vmid:%u pasid:%u, 
>> for process %s pid %d thread %s pid %d)\n",
>> -            entry->vmid_src ? "mmhub" : "gfxhub",
>> -            entry->src_id, entry->ring_id, entry->vmid,
>> -            entry->pasid, task_info.process_name, task_info.tgid,
>> -            task_info.task_name, task_info.pid);
>> -        dev_err(adev->dev, "  in page starting at address 0x%016llx 
>> from client %d\n",
>> -            addr, entry->client_id);
>> +        struct amdgpu_task_info *task_info;
>> +
>> +        task_info = amdgpu_vm_get_task_info_pasid(adev, entry->pasid);
>> +        if (task_info) {
>
> Same as above.
>
>
>> +            dev_err(adev->dev,
>> +                "[%s] page fault (src_id:%u ring:%u vmid:%u 
>> pasid:%u, for process %s pid %d thread %s pid %d)\n",
>> +                entry->vmid_src ? "mmhub" : "gfxhub",
>> +                entry->src_id, entry->ring_id, entry->vmid,
>> +                entry->pasid, task_info->process_name, task_info->tgid,
>> +                task_info->task_name, task_info->pid);
>> +            dev_err(adev->dev, "  in page starting at address 
>> 0x%016llx from client %d\n",
>> +                addr, entry->client_id);
>> +            amdgpu_vm_put_task_info_pasid(adev, task_info, 
>> entry->pasid);
>> +        }
>> +
>>           if (!amdgpu_sriov_vf(adev))
>> hub->vmhub_funcs->print_l2_protection_fault_status(adev, status);
>>       }
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
>> index 5af235202513..a33a5659713d 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
>> @@ -1446,18 +1446,20 @@ static int gmc_v8_0_process_interrupt(struct 
>> amdgpu_device *adev,
>>           gmc_v8_0_set_fault_enable_default(adev, false);
>>         if (printk_ratelimit()) {
>> -        struct amdgpu_task_info task_info;
>> -
>> -        memset(&task_info, 0, sizeof(struct amdgpu_task_info));
>> -        amdgpu_vm_get_task_info(adev, entry->pasid, &task_info);
>> -
>> -        dev_err(adev->dev, "GPU fault detected: %d 0x%08x for 
>> process %s pid %d thread %s pid %d\n",
>> -            entry->src_id, entry->src_data[0], task_info.process_name,
>> -            task_info.tgid, task_info.task_name, task_info.pid);
>> -        dev_err(adev->dev, " VM_CONTEXT1_PROTECTION_FAULT_ADDR   
>> 0x%08X\n",
>> -            addr);
>> -        dev_err(adev->dev, " VM_CONTEXT1_PROTECTION_FAULT_STATUS 
>> 0x%08X\n",
>> -            status);
>> +        struct amdgpu_task_info *task_info;
>> +
>> +        task_info = amdgpu_vm_get_task_info_pasid(adev, entry->pasid);
>> +        if (task_info) {
>
> Same as above.
>
>
>> +            dev_err(adev->dev, "GPU fault detected: %d 0x%08x for 
>> process %s pid %d thread %s pid %d\n",
>> +                entry->src_id, entry->src_data[0], 
>> task_info->process_name,
>> +                task_info->tgid, task_info->task_name, task_info->pid);
>> +            dev_err(adev->dev, " VM_CONTEXT1_PROTECTION_FAULT_ADDR   
>> 0x%08X\n",
>> +                addr);
>> +            dev_err(adev->dev, " VM_CONTEXT1_PROTECTION_FAULT_STATUS 
>> 0x%08X\n",
>> +                status);
>> +            amdgpu_vm_put_task_info_pasid(adev, task_info, 
>> entry->pasid);
>> +        }
>> +
>>           gmc_v8_0_vm_decode_fault(adev, status, addr, mc_client,
>>                        entry->pasid);
>>       }
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>> index f9a5a2c0573e..fefaa57d8669 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>> @@ -550,7 +550,7 @@ static int gmc_v9_0_process_interrupt(struct 
>> amdgpu_device *adev,
>>       bool retry_fault = !!(entry->src_data[1] & 0x80);
>>       bool write_fault = !!(entry->src_data[1] & 0x20);
>>       uint32_t status = 0, cid = 0, rw = 0;
>> -    struct amdgpu_task_info task_info;
>> +    struct amdgpu_task_info *task_info;
>>       struct amdgpu_vmhub *hub;
>>       const char *mmhub_cid;
>>       const char *hub_name;
>> @@ -625,19 +625,19 @@ static int gmc_v9_0_process_interrupt(struct 
>> amdgpu_device *adev,
>>       if (!printk_ratelimit())
>>           return 0;
>>   -
>> -    memset(&task_info, 0, sizeof(struct amdgpu_task_info));
>> -    amdgpu_vm_get_task_info(adev, entry->pasid, &task_info);
>> -
>> -    dev_err(adev->dev,
>> -        "[%s] %s page fault (src_id:%u ring:%u vmid:%u pasid:%u, for 
>> process %s pid %d thread %s pid %d)\n",
>> -        hub_name, retry_fault ? "retry" : "no-retry",
>> -        entry->src_id, entry->ring_id, entry->vmid,
>> -        entry->pasid, task_info.process_name, task_info.tgid,
>> -        task_info.task_name, task_info.pid);
>> -    dev_err(adev->dev, "  in page starting at address 0x%016llx from 
>> IH client 0x%x (%s)\n",
>> -        addr, entry->client_id,
>> -        soc15_ih_clientid_name[entry->client_id]);
>> +    task_info = amdgpu_vm_get_task_info_pasid(adev, entry->pasid);
>> +    if (task_info) {
>
> Same as above.
>
>
>> +        dev_err(adev->dev,
>> +            "[%s] %s page fault (src_id:%u ring:%u vmid:%u pasid:%u, 
>> for process %s pid %d thread %s pid %d)\n",
>> +            hub_name, retry_fault ? "retry" : "no-retry",
>> +            entry->src_id, entry->ring_id, entry->vmid,
>> +            entry->pasid, task_info->process_name, task_info->tgid,
>> +            task_info->task_name, task_info->pid);
>> +        dev_err(adev->dev, "  in page starting at address 0x%016llx 
>> from IH client 0x%x (%s)\n",
>> +            addr, entry->client_id,
>> +            soc15_ih_clientid_name[entry->client_id]);
>> +        amdgpu_vm_put_task_info_pasid(adev, task_info, entry->pasid);
>> +    }
>>         if (adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 4, 3))
>>           dev_err(adev->dev, "  cookie node_id %d fault from die 
>> %s%d%s\n",
>> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c 
>> b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
>> index cd37f45e01a1..02c8d4364c87 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
>> @@ -2112,7 +2112,7 @@ static int sdma_v4_0_print_iv_entry(struct 
>> amdgpu_device *adev,
>>                             struct amdgpu_iv_entry *entry)
>>   {
>>       int instance;
>> -    struct amdgpu_task_info task_info;
>> +    struct amdgpu_task_info *task_info;
>>       u64 addr;
>>         instance = sdma_v4_0_irq_id_to_seq(entry->client_id);
>> @@ -2125,14 +2125,16 @@ static int sdma_v4_0_print_iv_entry(struct 
>> amdgpu_device *adev,
>>       addr |= ((u64)entry->src_data[1] & 0xf) << 44;
>>         memset(&task_info, 0, sizeof(struct amdgpu_task_info));
>> -    amdgpu_vm_get_task_info(adev, entry->pasid, &task_info);
>> -
>> -    dev_dbg_ratelimited(adev->dev,
>> -           "[sdma%d] address:0x%016llx src_id:%u ring:%u vmid:%u "
>> -           "pasid:%u, for process %s pid %d thread %s pid %d\n",
>> -           instance, addr, entry->src_id, entry->ring_id, entry->vmid,
>> -           entry->pasid, task_info.process_name, task_info.tgid,
>> -           task_info.task_name, task_info.pid);
>> +    task_info = amdgpu_vm_get_task_info_pasid(adev, entry->pasid);
>> +    if (task_info) {
>
> Same as above.
>
>
>> +        dev_dbg_ratelimited(adev->dev,
>> +            "[sdma%d] address:0x%016llx src_id:%u ring:%u vmid:%u "
>> +            "pasid:%u, for process %s pid %d thread %s pid %d\n",
>> +            instance, addr, entry->src_id, entry->ring_id, entry->vmid,
>> +            entry->pasid, task_info->process_name, task_info->tgid,
>> +            task_info->task_name, task_info->pid);
>> +        amdgpu_vm_put_task_info_pasid(adev, task_info, entry->pasid);
>> +    }
>>       return 0;
>>   }
>>   diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c 
>> b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
>> index f413898dda37..b62a9bef72e2 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
>> @@ -1633,7 +1633,7 @@ static int sdma_v4_4_2_print_iv_entry(struct 
>> amdgpu_device *adev,
>>                             struct amdgpu_iv_entry *entry)
>>   {
>>       int instance;
>> -    struct amdgpu_task_info task_info;
>> +    struct amdgpu_task_info *task_info;
>>       u64 addr;
>>         instance = sdma_v4_4_2_irq_id_to_seq(entry->client_id);
>> @@ -1646,14 +1646,17 @@ static int sdma_v4_4_2_print_iv_entry(struct 
>> amdgpu_device *adev,
>>       addr |= ((u64)entry->src_data[1] & 0xf) << 44;
>>         memset(&task_info, 0, sizeof(struct amdgpu_task_info));
>> -    amdgpu_vm_get_task_info(adev, entry->pasid, &task_info);
>> +    task_info = amdgpu_vm_get_task_info_pasid(adev, entry->pasid);
>> +    if (task_info) {
>
> Same as above.
>
> Regards,
>   Felix
>
>
>> +        dev_dbg_ratelimited(adev->dev,
>> +            "[sdma%d] address:0x%016llx src_id:%u ring:%u vmid:%u "
>> +            "pasid:%u, for process %s pid %d thread %s pid %d\n",
>> +            instance, addr, entry->src_id, entry->ring_id, entry->vmid,
>> +            entry->pasid, task_info->process_name, task_info->tgid,
>> +            task_info->task_name, task_info->pid);
>> +        amdgpu_vm_put_task_info_pasid(adev, task_info, entry->pasid);
>> +    }
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
>> index d9953c2b2661..f6ed68fdff81 100644
>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
>> @@ -238,16 +238,17 @@ void 
>> kfd_smi_event_update_thermal_throttling(struct kfd_node *dev,
>>     void kfd_smi_event_update_vmfault(struct kfd_node *dev, uint16_t 
>> pasid)
>>   {
>> -    struct amdgpu_task_info task_info;
>> +    struct amdgpu_task_info *task_info;
>>         memset(&task_info, 0, sizeof(struct amdgpu_task_info));
>> -    amdgpu_vm_get_task_info(dev->adev, pasid, &task_info);
>> -    /* Report VM faults from user applications, not retry from 
>> kernel */
>> -    if (!task_info.pid)
>> -        return;
>> -
>> -    kfd_smi_event_add(0, dev, KFD_SMI_EVENT_VMFAULT, "%x:%s\n",
>> -              task_info.pid, task_info.task_name);
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
