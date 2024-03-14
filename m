Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AFB0C5475B
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Mar 2024 04:41:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CAC8910EEDC;
	Thu, 14 Mar 2024 04:41:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="j89klOMl";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2056.outbound.protection.outlook.com [40.107.243.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35FA710EEDC
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Mar 2024 04:41:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hCpps37P/Tas9YnCbgxSJuk+zsqK6Q188ZgNIgIfnIyVTGLgTkfsBZdU6vX30b1Ccah9q7FcX6yJfmA0ohL/t8cOzc9kmHRDv+88NO1vBZ5ZNyhRuqbHW5tjOCLAVxvCtddZIFWlCtMpp+cxB9J/a7ydk4Elc4kzZV8Gi3lrl/D6F3fJHbnjd8TNC1w+SgTYvkc09bvihhDZOo/SfsxBXBiRHq3lmQCe8wSP/Vt4Ge+kXHeUWLCtNs+EDQzFrb9LE/9ffACMWK/RByqZbawdtDYZhJ9NPmNOgKQHhf2kLFf3z+h8c1ZmEncj82bhz6fwKcNK38jbrqS7AMn4rXRXfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tuVEKjBCbPj4Gr18YqpEdCcUDd8d+2nrKth3FinlG3A=;
 b=TInyLnJwTYdWZtmqLaWtRpoxG61DrNRbI/SGi+YYyqhEJbaCh5nLFs2EAOJei0H22HszrAhr+aRG9GBjkUhgj0Q5z0lEkVqVlULRp1BDe+jww/X9oYY+QE3T4T85R5dksoj7JkEzLEXfu4AcQ2WFl9u5O87wJ+OUyRcK1OARVDGxl2pwdFYpOUcrkQHLIb0M+VIkkJupWWgas4URP78NrlO6xtYV1gJx6Wqoi8t/ZdT62MQyVKK4rvzGFnasO8RJ3512DG0BpGsfpDRzm1ARvOkoJTTiXI6hQ8KMyBcQOsV2ahNgvMH3Irp0k9oqYmS4m+Q6gAOlDuWpJRj5ofTO3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tuVEKjBCbPj4Gr18YqpEdCcUDd8d+2nrKth3FinlG3A=;
 b=j89klOMl5/StC/fSpC2ArLlEdCEnYfYNx4IHwpny1UFAAX7wnZHC6EgA2PDCQd2PryO5lcom2HAeCmSsN0a+w8sEVbvoaaWuKxAU4Ghxzk8Wjbpv7uMETKUxdoFyhlsMq6mUcBMFIlTpUWqnLovC61dg2ikA9W534lsM+PfKoZw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) by
 CY8PR12MB7172.namprd12.prod.outlook.com (2603:10b6:930:5b::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7386.18; Thu, 14 Mar 2024 04:41:10 +0000
Received: from DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::f349:addf:ae3e:814]) by DS0PR12MB7804.namprd12.prod.outlook.com
 ([fe80::f349:addf:ae3e:814%5]) with mapi id 15.20.7386.017; Thu, 14 Mar 2024
 04:41:10 +0000
Message-ID: <efb8eb2b-9951-4eec-981f-a945b4880200@amd.com>
Date: Thu, 14 Mar 2024 10:11:02 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: Do a basic health check before reset
Content-Language: en-US
To: Felix Kuehling <felix.kuehling@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Hawking.Zhang@amd.com, Alexander.Deucher@amd.com, Asad.Kamal@amd.com
References: <20240313094132.668370-1-lijo.lazar@amd.com>
 <aec029aa-8ceb-4450-9139-27c7dda43f98@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <aec029aa-8ceb-4450-9139-27c7dda43f98@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0207.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e9::18) To DS0PR12MB7804.namprd12.prod.outlook.com
 (2603:10b6:8:142::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7804:EE_|CY8PR12MB7172:EE_
X-MS-Office365-Filtering-Correlation-Id: 122de263-d71c-46d0-76c1-08dc43e0f8af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0xPSAjIo+RFZ5zMaqPQe0zhYEskA9m5onFe/5livfYRVHdgqWp99ya2VfFglIVlDc6WVOdkzsdSDeUwYgAstX7zsfMg08A27S/Sa4dxl7HLMSpfd7JneQgdJVfQHI+YwwqsaQ0q8263VdqbobZGiTang+hqWQQ0nOtZWlh/50Gem6X6RucDMVeuWrm6QAP/OuRxcG5tDZFoUeScC1fO6m2Pol30NvrMChizibMBi1wogU74edKnKRIBVr5YVEzixwlvIltCPCSWftJpb/z43Ze9c67Ve23YNCQML6OiHbxtynqYOKMvplfphST/T6QewhN1KUFt6au/Z3835wQex/803QHutdZeSkpU0g/cXAYj7BsNRQDNJY16PssSF1Rk53+GE3HcqKp5L8g1YTXaIVzT0FOD7HLWY4kEHKqiclsgQZlru0kzdGhfRJge58mDdqmg4Qf48P+dWRuGf5PyjaY2aalT2rgUxOigmW/gigwx0bvNNGqG1icbqUSOlo2+/N0wXo4YdEfSCwJd/CU3QOhjYowE3PxdguAer3IvYs3Kc+AhLaujLuJVrb93XcwEQHl2D5esa5KqiqrrKpSaEX6ChRrfB1ERn1tKjcXd8cgXuiHsBze00CVl1C5Vlw0buQ1/SjBonZPXc/zEkxjpswVriksEmK+mzrhTjLx2XqVo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7804.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YytOL0dHMzZCTzNXam9MdXNnSGgvekZPbG1HcStCZGpaTXF6TVlNRDdzdDB0?=
 =?utf-8?B?RXBYaE9aVWxmck1HZ2xBOVBTQzhiTGsrWU9URERzUkliOVRaQ0xoSmFidm1y?=
 =?utf-8?B?VkZZc1Evb1RMVkR6RUY4N0tEWTJpQWVnZVFqMHZKbXdaTXhoUWVOYTYxL3ZQ?=
 =?utf-8?B?SnlGdkUrTVQyL1dzNXdTbEN2UllDaGFwUHpFY2VQYlUrMzlkVnhjamtoUGpC?=
 =?utf-8?B?c1BaNlB0TG4rRi8yMnNmT2l5bytqTWpyM1A2eW9rWGg5b3gvaHdPa3lMR3gy?=
 =?utf-8?B?QnRwemplS0Z2Vk1kaW1XTDFUYTVaVVZVV0hlVm1IL1V0K1pmNUNwNTI5eUxH?=
 =?utf-8?B?SGw3YmpuWi9yYlNPQW04cEFoSFJmeUxSVXpFTjVaWlFyZDFoL1FrU2E1NWJj?=
 =?utf-8?B?WFR1WVlGbXFDaXkzSzN2RlN5dW9ZVUFRL3JBMmZId0RyR1NjOVhHYXNTNkF5?=
 =?utf-8?B?Zlc2WGQ3dUNRVVgxYkFzQzUvMWRQSUdGMzhaYitKdEh0amF3UUNVcHRMU1JB?=
 =?utf-8?B?RDhFRXVzZlM2UmZjTVlOaU9IcUE4R1JiK2d6THJraFpDcDIrWDk3YXhFYUNx?=
 =?utf-8?B?dG5pMUdhTkt5aVZrTW9yN05lSCtkQS84UEtQdXNMV3c0WXEybzc1aTBOWlh6?=
 =?utf-8?B?VGJSbTV0Sms3Q1l6dDlQUHliVnBTZC9uUTY0czNwQlRSSXZJWG02Z3ViQm1x?=
 =?utf-8?B?QVVTaVg0NUhkZ1Z0dnlOc3ZqaGV5SGFmc0cxZFk3R3YrSUpPR1E1bkVSdm8z?=
 =?utf-8?B?Rjdab0Iyd0FrMnJ2S2pmeStqM2QyT0ZaN1QyYThPTTQ4Qy9sM1YxRGFaTzJ5?=
 =?utf-8?B?TEYxSlVqYjhxWHd5YS9NMk9CSURvV29vL2xlOGUraUdmdFRvSzhvem0yQUht?=
 =?utf-8?B?Q2IrUk9mVlk0RW1ZQ0Z0WENuaXA3ampMem9ZMi9OM2VFeCthUG1XcEpNVnlU?=
 =?utf-8?B?aWthUS93UmxwWUs3SHA4Q04ya3NWVmtDaTN0a2thMDV0N1FzWFZ6dnVtSzA2?=
 =?utf-8?B?cDdEVkZvTzJLSE1oYktuaG9zV0sxYUxJc1g0ekNaejVJVWJzYWp6OThldEJl?=
 =?utf-8?B?a2NnNFhBVWJxcmFFZ3A2ek1GczRIRmNkTTUvSzhyWS9UdTh4ODgraEg2Wm5z?=
 =?utf-8?B?bW81WGE4YVc3RzdoU2U4aTNFbDF2VHRZUThXL21UWVNyWHFqeTkxOStGLzlm?=
 =?utf-8?B?eHNIRnlzZWNXeTg3K28yelNnS2c5dmtqeWFoSkUvSW91a2ZTa1p4cktQN3Fz?=
 =?utf-8?B?ajFZZjF4OTlJVVEvdEwyS3pXUVUzS0t5Rk9kQTdOT1p3SjBEaHF5Mmhnckgv?=
 =?utf-8?B?Ti9BSXlza0l0TU41ZnljZ2FhRVdwNTZhOW8rMTV0dWdUWGJCaGJ5aVpwdVBv?=
 =?utf-8?B?OVBsOEI2d1JkTUJLNlE0RjBiaHJTUGVMOTg2QjZhQ1c4VkFvcHl5TFFWSzFv?=
 =?utf-8?B?K1NIbDNvcFNsWjF0dkhRQzJTcmM0Z08yS3RTYm14ekc5UUExQkZ0V1dDaXh3?=
 =?utf-8?B?U2Q5R0lUZ3FGS0NxT3Y3UTlrOU5aZlQrSUFQVGdYTldMVU1HZS9PWDBtMTl1?=
 =?utf-8?B?RUgxOHh4dGlOa1FVTm14SDllVDIwUHBUeTBwT0Y3Sk84SHMwZTJRQUdjR0Q0?=
 =?utf-8?B?MEN5ZFFzbUVsT1VydGd6MGc5RVBkV2p4amdYRGkyNkIyNHR4alVndi9rYXVj?=
 =?utf-8?B?bWtxeDBEK1RRdUZ2am5qc3JqSUdvQzZzWjNGMERUWEtHWlhtTkJCb1hQYXZV?=
 =?utf-8?B?TndSSGRpcEo2TDZCRmJERXdLdFVMWGczUWJnanVVbm9lRXh6VGpMenQzdjd6?=
 =?utf-8?B?TkpBVmN4VWtUTHdsaTFnVkFveHRRek9ndFJRSndxcFZaTG5raFJOSU85MFhl?=
 =?utf-8?B?VTkrMnBIc2l6QkFQSnNJV3hHRGdMQVhhZHBPd2JtOTA2cHFTdDNSK25qWmow?=
 =?utf-8?B?T1drMDR5djZuREtuL3p5YkpVd1hRNHVlVTBGeE5DWlVLa1p0aWVmUElsNjNa?=
 =?utf-8?B?cEl5OHdoL2lYN0RscExIRE5kd3pTdVI3QWxodStGb1hOYklMbkFmYzdDK0hE?=
 =?utf-8?B?N2FGWG1JMG95b1NRUHh0SksrWUtDanlpWklEblRqYWNkRTVZNTJxOUpGYlNL?=
 =?utf-8?Q?wUEzCGgbfAkhBzkNT7hkyIhpP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 122de263-d71c-46d0-76c1-08dc43e0f8af
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7804.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2024 04:41:10.7402 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MV/0/xZlIGx59Gs3ZStsOWEdsM1JlESHZLbM/CdzmRBE+a2BiTf6gUkQqB0jsSSE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7172
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



On 3/14/2024 1:19 AM, Felix Kuehling wrote:
> 
> On 2024-03-13 5:41, Lijo Lazar wrote:
>> Check if the device is present in the bus before trying to recover. It
>> could be that device itself is lost from the bus in some hang
>> situations.
>>
>> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 24 ++++++++++++++++++++++
>>   1 file changed, 24 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index 1e9454e6e4cb..b37113b79483 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -5536,6 +5536,23 @@ static inline void
>> amdgpu_device_stop_pending_resets(struct amdgpu_device *adev)
>>     }
>>   +static int amdgpu_device_health_check(struct list_head
>> *device_list_handle)
>> +{
>> +    struct amdgpu_device *tmp_adev;
>> +    int ret = 0;
>> +    u32 status;
>> +
>> +    list_for_each_entry(tmp_adev, device_list_handle, reset_list) {
>> +        pci_read_config_dword(tmp_adev->pdev, PCI_COMMAND, &status);
>> +        if (PCI_POSSIBLE_ERROR(status)) {
>> +            dev_err(tmp_adev->dev, "device lost from bus!");
>> +            ret = -ENODEV;
> 
> You could just return here. What's the point of looking for other
> devices if you're going to return an error anyway?
> 

This for XGMI case; the error is primarily for informational purpose to
know which all devices in the hive got into a bad state.

Thanks,
Lijo

> Regards,
>   Felix
> 
> 
>> +        }
>> +    }
>> +
>> +    return ret;
>> +}
>> +
>>   /**
>>    * amdgpu_device_gpu_recover - reset the asic and recover scheduler
>>    *
>> @@ -5607,6 +5624,12 @@ int amdgpu_device_gpu_recover(struct
>> amdgpu_device *adev,
>>           device_list_handle = &device_list;
>>       }
>>   +    if (!amdgpu_sriov_vf(adev)) {
>> +        r = amdgpu_device_health_check(device_list_handle);
>> +        if (r)
>> +            goto end_reset;
>> +    }
>> +
>>       /* We need to lock reset domain only once both for XGMI and
>> single device */
>>       tmp_adev = list_first_entry(device_list_handle, struct
>> amdgpu_device,
>>                       reset_list);
>> @@ -5772,6 +5795,7 @@ int amdgpu_device_gpu_recover(struct
>> amdgpu_device *adev,
>>                           reset_list);
>>       amdgpu_device_unlock_reset_domain(tmp_adev->reset_domain);
>>   +end_reset:
>>       if (hive) {
>>           mutex_unlock(&hive->hive_lock);
>>           amdgpu_put_xgmi_hive(hive);
