Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E96C0C47422
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jan 2024 18:54:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1272410F968;
	Thu, 25 Jan 2024 18:54:47 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F305810F7AF
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jan 2024 18:54:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d8IqHGnPxT8Bs56iPwsZ5SegaKgdYPx6drKwlRA1HDhQ7kVq25p4Wv/MSxSX3qS9ZF3Etfr2rCk9Nuon8bxvzjF+iE7AnhijwKo45HzWMExp2TLbjqCuWYFQVsGjQtbxMWyDGOz+Fc84Fn8a020cEjLBDUfeAWYWN/DGaAMwTNN03CmWmbx+0beYJFde+LMkjMcswpfJykLywdAkoyueKxwik9nt6qli4TLfTvaMYfk7828VQFRx93UEEBUNKFjES1gza1Mw4DKhv5fG6bz+RoJewSw2GNlYi5YReIWYAeh4SCdLsz6d5+VXl1mf7dXbtxzked5FlpKt4dQdgDQuGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8gXYZJgneJ0KUT2V1zcOE+wZkclWgS36Of/mrHhfPCM=;
 b=VNmrjYSt1Dq/NCJM5cayS3BtdZLhp2VVthfXCvYOQ1l6Dm53D3nVPCJIAMKAp8BJAkG0o2mqHjDV6mgn6ligw2z736ZE1Bka5TqX6fK83viltJ9poZlJmJo+sgQpoARHdq5pB773NjN61hk2tnJ0R9rD7viRN0zmkDg54QqoHUpvn9aXujnr0QJXU5O8O+5UDVyPOitz2cCGg6yH6de/BYlx6tx4U93j60pKnyV5FbdZ2m3/75DMrUQ+ijtnkzWNZTHYIfJKQyQVWN2XCCabdzfBRa6ctkWF/iuqL4sWj1fql5bejOxmKVVeEq1vasaK5PJ32a0UjLVJN6m5B4slFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8gXYZJgneJ0KUT2V1zcOE+wZkclWgS36Of/mrHhfPCM=;
 b=Xd+B7Haaegue1xd3ksNaFrj4OO1JJ3ZrXYaoWQhel/7Mi2792eR/nRQsYFht3/asWBTsBED11a5BD5WaSXw1DNzIj0DFNQ86qdkfuXrtNw9NJW4suRG7LC7msThWMEozmlkx8qBkak1GHaM6QcTzNkleRJ3U6pUszfC7wD8n+TI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by SA1PR12MB7295.namprd12.prod.outlook.com (2603:10b6:806:2b6::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.26; Thu, 25 Jan
 2024 18:54:42 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::6f2f:7892:e9fe:c62b]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::6f2f:7892:e9fe:c62b%5]) with mapi id 15.20.7228.027; Thu, 25 Jan 2024
 18:54:42 +0000
Message-ID: <bc688841-ce33-4df3-8c44-0f7ad37c7d95@amd.com>
Date: Thu, 25 Jan 2024 13:54:40 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: move the drm client creation behind drm
 device registration
Content-Language: en-US
To: "Lazar, Lijo" <lijo.lazar@amd.com>, Le Ma <le.ma@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20240125080710.9091-1-le.ma@amd.com>
 <fa78f5d6-4940-4180-87c0-46e229b3ebcf@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <fa78f5d6-4940-4180-87c0-46e229b3ebcf@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0258.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:68::35) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|SA1PR12MB7295:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ff7fa40-ae2c-4ab9-a8ac-08dc1dd716f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ap4BrXtMwJfvfVWaGGlfEguZ24SyHKvp7aG0xsZcvnr7Q6M5Rjbr9z7WGpUumRrh8ASkF7ntRIZBEoxN+6zKMVk/bjHN675U4p+MoBm7+e9zP1SMHExRB+2Wbwttjr6s7Aw+nvMcrA9DtqJo/tEOjgmLTwZPX1IqEu1B7mXoz9xnZsQsEpAGQRh+s48C2gMtmF8fplHuTLYnHUzCE3bJNE/u0VlHnnlUqFLPfPWmt1HMX8g/N93a3DAN5RAH8OjolRL98s0FEvKaWLwYDzjo9Y1cm51+n2xi0gchufHNcXDBcfyhKQ6bm2UKE/maFqJeV5z05gjZV6RP5luvemOHBryinIdXurivG+0q2twv3shNEfGj+bbWctKhrHa5EWfTUNeee6sW5WPka566tJlq1smTnSlG/UbbGN5if+AnIBC9NZXNUy0ZMRQyLmPhGHcWyKQ2PU0CYkBXZ2LTWMIcnTO1in+6f9xt7HDKz3q5IbkMIA4lDti6D4Ck+DTWOIAIp70fG30Bex3ffXSmvxnhpZEf/CHqgfmlDUc52lT3RXDVSZRXcn00xYGFWK8IhB7oE0rXj2UStZyKsOFEjr5wmJA/djsV/GtD6xwnJTr1EDRBQmzArye42Wnuof3LtdkrSKJqhsSS1VXo5QOA3H0Fe3/tVeX20qOemOV99FT7wa9h7efm/swQY6E2MmBSe/jl
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(39860400002)(376002)(136003)(346002)(396003)(230173577357003)(230273577357003)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(83380400001)(2616005)(26005)(6512007)(38100700002)(8936002)(8676002)(5660300002)(4326008)(478600001)(44832011)(66556008)(6506007)(36916002)(53546011)(66476007)(6486002)(2906002)(66946007)(316002)(41300700001)(110136005)(31696002)(86362001)(36756003)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dXlkWDVRMU1IMHdMY2JmOXpGYTBrdVRjdnViWnpoRklwVjNiWVFPdGtqNTls?=
 =?utf-8?B?dlBIMzVQYlhuc0JkYklIN05iZW9nZ3FRUXMyWDJrQnJPSHpYdE9vUng0UzIw?=
 =?utf-8?B?dkZWVlgveHllMWlNTlloQmQ1ZEQxTmRwT0lxWmtsZ201UXNOcnE5ZHNOV1VF?=
 =?utf-8?B?NkdHdHRXdFpJZWU5SXJVbTNma3daWE81Sy9CSDdqbnAzaHo5UVR1QzNYdi9s?=
 =?utf-8?B?ckdlbm9TekxRZmJ6Ti9UY1VmeXo1RHJKWDJiWUVESTlyRDhJZk5LN1JaZWRE?=
 =?utf-8?B?cXBMb3puZlNodDI5MTZXUUdVdnlPRmNHYitNZndVdmd4ZUhMNFlvSWxqQTY3?=
 =?utf-8?B?Tzl4ejJCVDhRNk4vSlBIblI1c0lvc0daR3FPKzJWOTFNUFFORUczQmlYNWxk?=
 =?utf-8?B?eDNzWUV6RlFydllwd2l6VWkrQjhJdnk2eWVBdkhZL0FTdlhTVUpQTEdjejRL?=
 =?utf-8?B?RG5DYzBIN1hXTmF1Y2xveFZYVDdJTVBEdjJVNzQ5ai95dlhVK0hna0k0THA4?=
 =?utf-8?B?RHZ0SDk3aHc2d1ZKNzJ5cFBhbnFtSVUwZGprMmMwL3N2YVc3NkgzWUZadXIy?=
 =?utf-8?B?V1ZMTm5EMU0rU1lTTkRuZnBhaVZXc2JNWHYxdkY5TFFkelpib0ZBTzFiQ0VE?=
 =?utf-8?B?K25wd1pBZWpIOGUxK0hFdVc5R0JQWS9yVkwvZ1h6UHVqZGIzb3BGRGthbElt?=
 =?utf-8?B?ZkgwWTNzanJiY0RuLy9mdzNQcWtRS01TTE9nc1pJVnU1dGhqR2ZXSlRLRHBj?=
 =?utf-8?B?YTdjeW51cGFycGhGS0ZGcWM3M1RQd1AvLzA1bjJBcDFjOFlVTFJjTGYrNUpX?=
 =?utf-8?B?QTJadmJTYlk5c2JWMlF5ekUvc1FqdlM0bzRLMkZOaXphdG1GMnlsZDBVa0Y0?=
 =?utf-8?B?dld0cFdEQ0NFMTVna1FQWXd2R3pTR1VwdktiRWJ2SFlMQUxXR3hGTzJ6YzB0?=
 =?utf-8?B?TGgranF2M3FKd0orU0dWcjI5SkRJSnNzNmt6ZHF6SXFINE5FbVlVTFIrempq?=
 =?utf-8?B?NWhTOVMyN0ltQ3FRNElGY2tuNmxYZGVBeWpvaTN0WWM0QSt1VUMzTm54Tm5m?=
 =?utf-8?B?emlZb0dUK0U1MnBmSThqL2dhZnhqbCttWGowQ3lkUmdZQkpTeXZZN3lZSDNI?=
 =?utf-8?B?eGpuZmNOL2dEeUxpNVdWeFViUlVkcWR4UVJWWWI3aW1tdnIzUmxTZnJYTFVB?=
 =?utf-8?B?UHdacjZWUDRTR3ZuUWE3QlVYVW02TVVsYlVkRkgzNHhWbEpYTmhacTdrcys3?=
 =?utf-8?B?bHJaM21qY0tVMnY1VXY4YjhnQ1RlTDdMSzBjRE5UODhjelJFM1FrRGMrS2x2?=
 =?utf-8?B?U1R0VW1UOWV0Skk5TmV6R0FvQ2lWVDNKcnN3UE15S1I2THB2MjdwN3kycXBB?=
 =?utf-8?B?MEVoT1ZTdk1ILzhxZ1B5dFJ2M3BhajVIYU5aU0Y4d0w5M1hvaWNSdlc2cU5s?=
 =?utf-8?B?enhuRG9QOWxIMm9PSWljOE11eHJXRm9tSGVkWkdyRUcrRjc2R084ZjZtMG9M?=
 =?utf-8?B?NjF5bjJ4Ym5LTDdOc1BiaG9uYlpLT0dabFF5eWxxNEU3cFVBK1gveFVOaWlj?=
 =?utf-8?B?ZjFINVlqMjNCeFExNHd6cjlwYzg3dm4zQ1FYVW5BUHVkRlhOMnltTnd0RU1V?=
 =?utf-8?B?eE5LQXc4WmN6Q0RIcXE1QjFQM0htZVFNM0ZBN0NxVkxVTHFoYm5VcWIyYVBR?=
 =?utf-8?B?OXExSFJSL0lpSGg4M1JTeHBBSUNwNmJrNGRRWU45SVlPNGptbGg1MHRpWGJh?=
 =?utf-8?B?amNUbVdCVXdROEpYRDJxZ2YxcEVsanZQOXNOakRFQnZLekdQcUJsbHN5Zkdk?=
 =?utf-8?B?QVA0MzhydXlVTmwzQklYalNmUVltRmpXL1Z0Yk0rRitPTXlzUGNvS0dvWnlW?=
 =?utf-8?B?SHlVOTAyNU5GWW1GbGUrWGdQN3UzOXhLVkEzVE41MG01ZVBraGlLUm1rMUJY?=
 =?utf-8?B?bDFNTW5qUU5TTXJIbGkxaDhtZThyR3NVc1lnRkNqNUVaQk80c25XUTNtSWJS?=
 =?utf-8?B?OHBLbTdjMDZEK1pWM1JwUjRqMm4xTEJqQkQrdnNld1VaVFI5VUdzellISHpS?=
 =?utf-8?B?S2xQYmNkM1NkME9CTGgzMnQvYnZjWnJaMy9zR2lvV2gwNzFsTUdMY0ZuaVNa?=
 =?utf-8?Q?CoGBZetooEwfPXRTGzOj6EiNE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ff7fa40-ae2c-4ab9-a8ac-08dc1dd716f5
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2024 18:54:42.3555 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7GVa8ZQ770uvGUQEegvqFYztx33YwN/1dh3mmpnmjkr1mPeY99/hiVZS95efu91T1iri+d021hQ4dmMV4mHkAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7295
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
Cc: alexander.deucher@amd.com, hawking.zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2024-01-25 08:15, Lazar, Lijo wrote:
> On 1/25/2024 1:37 PM, Le Ma wrote:
>> This patch is to eliminate interrupt warning below:
>>
>>    "[drm] Fence fallback timer expired on ring sdma0.0".
>>
>> An early vm pt clearing job is sent to SDMA ahead of interrupt enabled,
>> introduced by patch below:
>>
>>    - drm/amdkfd: Export DMABufs from KFD using GEM handles
>>
> The drm client creation logic in this patch won't work well for dynamic
> partition switch cases. Better add a ''Fixes' tag also.

I agree. It would also be problematic with GPU resets. amdgpu_pci_probe 
seems to be the right place for this to ensure it only gets called once. 
The fix looks reasonable to me.

Reviewed-by: Felix Kuehling <felix.kuehling@amd.com>


>
> This looks fine to me, needs to be checked by Felix anyway.
>
> Thanks,
> Lijo
>
>> And re-locating the drm client creation following after drm_dev_register
>> looks like a more proper flow.
>>
>> v2: wrap the drm client creation
>>
>> Signed-off-by: Le Ma <le.ma@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 32 ++++++++++++++--------
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h |  2 ++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |  4 +++
>>   3 files changed, 27 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>> index 77e263660288..41db030ddc4e 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>> @@ -141,11 +141,31 @@ static void amdgpu_amdkfd_reset_work(struct work_struct *work)
>>   static const struct drm_client_funcs kfd_client_funcs = {
>>   	.unregister	= drm_client_release,
>>   };
>> +
>> +int amdgpu_amdkfd_drm_client_create(struct amdgpu_device *adev)
>> +{
>> +	int ret;
>> +
>> +	if (!adev->kfd.init_complete)
>> +		return 0;
>> +
>> +	ret = drm_client_init(&adev->ddev, &adev->kfd.client, "kfd",
>> +			      &kfd_client_funcs);
>> +	if (ret) {
>> +		dev_err(adev->dev, "Failed to init DRM client: %d\n",
>> +			ret);
>> +		return ret;
>> +	}
>> +
>> +	drm_client_register(&adev->kfd.client);
>> +
>> +	return 0;
>> +}
>> +
>>   void amdgpu_amdkfd_device_init(struct amdgpu_device *adev)
>>   {
>>   	int i;
>>   	int last_valid_bit;
>> -	int ret;
>>   
>>   	amdgpu_amdkfd_gpuvm_init_mem_limits();
>>   
>> @@ -164,12 +184,6 @@ void amdgpu_amdkfd_device_init(struct amdgpu_device *adev)
>>   			.enable_mes = adev->enable_mes,
>>   		};
>>   
>> -		ret = drm_client_init(&adev->ddev, &adev->kfd.client, "kfd", &kfd_client_funcs);
>> -		if (ret) {
>> -			dev_err(adev->dev, "Failed to init DRM client: %d\n", ret);
>> -			return;
>> -		}
>> -
>>   		/* this is going to have a few of the MSBs set that we need to
>>   		 * clear
>>   		 */
>> @@ -208,10 +222,6 @@ void amdgpu_amdkfd_device_init(struct amdgpu_device *adev)
>>   
>>   		adev->kfd.init_complete = kgd2kfd_device_init(adev->kfd.dev,
>>   							&gpu_resources);
>> -		if (adev->kfd.init_complete)
>> -			drm_client_register(&adev->kfd.client);
>> -		else
>> -			drm_client_release(&adev->kfd.client);
>>   
>>   		amdgpu_amdkfd_total_mem_size += adev->gmc.real_vram_size;
>>   
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>> index 584a0cea5572..da175c384adf 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
>> @@ -182,6 +182,8 @@ int amdgpu_queue_mask_bit_to_set_resource_bit(struct amdgpu_device *adev,
>>   struct amdgpu_amdkfd_fence *amdgpu_amdkfd_fence_create(u64 context,
>>   				struct mm_struct *mm,
>>   				struct svm_range_bo *svm_bo);
>> +
>> +int amdgpu_amdkfd_drm_client_create(struct amdgpu_device *adev);
>>   #if defined(CONFIG_DEBUG_FS)
>>   int kfd_debugfs_kfd_mem_limits(struct seq_file *m, void *data);
>>   #endif
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> index 475bd59c9ac2..91d5d9435067 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
>> @@ -2255,6 +2255,10 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
>>   	if (ret)
>>   		goto err_pci;
>>   
>> +	ret = amdgpu_amdkfd_drm_client_create(adev);
>> +	if (ret)
>> +		goto err_pci;
>> +
>>   	/*
>>   	 * 1. don't init fbdev on hw without DCE
>>   	 * 2. don't init fbdev if there are no connectors
