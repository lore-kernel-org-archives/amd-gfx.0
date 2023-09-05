Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78C8AC83F2C
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Sep 2023 10:40:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DE1F10E045;
	Tue,  5 Sep 2023 10:40:18 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06FE010E045
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Sep 2023 10:40:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PhPSGlXjKTZrRZ1dyhGpY/54nhMwW1olMvHk1I9Z5Q8rP5EfhiuugBK2zaatSTxq4WqFpb7lfWt+I9JYY+6A+zuusO9XBKM+tjmU+bS+7wPWJNCbH/a244TOurv7CjPD3ZDnFSMZvUwN7OghnVpVvvj+gTnRKPOPgAGPwolJXCC+asPvgmxKBzWOGV4TYCbSeYbmMOjGbFTaCIeDN+0VcfslashzhziX8jidiOVYFDMkfIIZ5WTMWH2TNQx3iwHRvWoq9zEm7R6M1arSICRruGjzDYeGI7oL003IYpN0Bi0uq18bE0ThHp6pfmouZq6SEFGIC2e4TqueA/O3hYXcWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C/WHZGyCbwzbnKVW/m0ylChq3CPPiD/lNvT/n1ik0xI=;
 b=Mula7fO9hhUjLVg6lnP90AlvwxvDcA0KbhITb9DdnJpHX+bggRvZOwq7P0rUCoWt7/7ve7x8bT0t3Rjz2LZB0wppCPLr+GTXUxQ2lAoDMh8QDE14yJg+jkrYEVEQ3Rw8PWEaSJI4qnQaVPtfKsVF+IH6f8MmJLu8zlAYHHSFg9/1enJOMmVmwGnMJklblfF9QMkLXYdhGILfD3lpWE5Agu1hSATrQ7ZMo93Gi25w6ggAutMsGl/b+f/vQr0gG9gfRlv4wv0mrB2UIdNltv6TPk3btZe1YL9tQ2lmkqYnCxgyVSIyY4rEMuF3GpTYVh10D2J+U77xuM8HYJ6j0FFRVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C/WHZGyCbwzbnKVW/m0ylChq3CPPiD/lNvT/n1ik0xI=;
 b=iC3XYt+3otcWzViLMrKsmXZAvNolCEToKU+vdArynkM563dafInCUUuUnppnh3mD2n4GWupFySVPvzHOXxudF8329ckPGA99xcc+spTlKJ4paM5OGLLTl3KtWUGv0tJJQuvGXkTGXUSJfJtBb4IuRfnLqRe/DXYXibLkyj6CVe0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6351.namprd12.prod.outlook.com (2603:10b6:8:a2::6) by
 IA1PR12MB6092.namprd12.prod.outlook.com (2603:10b6:208:3ec::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Tue, 5 Sep
 2023 10:40:13 +0000
Received: from DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::d713:8aa1:8769:af10]) by DM4PR12MB6351.namprd12.prod.outlook.com
 ([fe80::d713:8aa1:8769:af10%7]) with mapi id 15.20.6745.030; Tue, 5 Sep 2023
 10:40:13 +0000
Message-ID: <eb33aa99-1f84-eb4a-6230-36cc32b161b0@amd.com>
Date: Tue, 5 Sep 2023 18:40:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] drm/amd: Fix the flag setting code for interrupt request
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Ma Jun <Jun.Ma2@amd.com>, amd-gfx@lists.freedesktop.org,
 Alexander.Deucher@amd.com
References: <20230904060501.2942018-1-Jun.Ma2@amd.com>
 <22adf274-ba4e-63d5-df8f-f7cafdb1075b@amd.com>
From: "Ma, Jun" <majun@amd.com>
In-Reply-To: <22adf274-ba4e-63d5-df8f-f7cafdb1075b@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR01CA0042.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::23) To DM4PR12MB6351.namprd12.prod.outlook.com
 (2603:10b6:8:a2::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6351:EE_|IA1PR12MB6092:EE_
X-MS-Office365-Filtering-Correlation-Id: bd1cbc33-ec9b-4eb8-98c0-08dbadfc7c22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sHUH6Es0OCmSWDEuktmJQT4U7sYelMLVtDfqqyt1NRKsLmIKlO1JQUkd06bx4Ubi8qQuB+wyudycvxv2ICbWEPK6sRbenE2UCcvRrkm4Wy7sFSETs3H5/1sDyEf/NLR2881+zH95a4M+SgULYw3SwVMpJtqz+OhcVaUlHtMMGc7HivaPKIZEvz7dIEiROsFLDfsgbq7KrgCoCPDI8Jmaqv2+M/A7b8UiFIZMyfbU3LBDYT6ivFrLY2jVogm3pATSNNXKqxCYdm1J6I7Q9MPYjlVoVqHgYsOvPU4mPOSsOwktQ4henmeuL6CAf5sp+ADJoPj3cyU1AcDw2v8a3TeNYrNvIWHOGLL2dfebWI9P6ZWB65RlhJL60/9I4+i2aT4icaZhGZi3Q/pqc6l08/DZ6dYCDmqVUE6Hy27GeKjkwwpcgv+uqPQbard1XgZl84Tc8oNbmdnVBhsDumFchDqC+lN3zhChAcEdjqU/JZSyo5xrqKJJmU1t4ZdwJ7WZNFwmymuFW25i9JYpFRPYS1YBk5qr2YrEx/57sTruzWpb6OFvAvcFJHE92VK9zDeg5P/+241zeax5w/TZxRxUmwE13G8SnA6gtpdVsKriujrY9U2dO2VjviwZopObrRvU9I0RO8KaE4z/ziTjztKSznTygA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB6351.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(39860400002)(346002)(376002)(136003)(366004)(186009)(1800799009)(451199024)(5660300002)(38100700002)(478600001)(6666004)(316002)(6636002)(66946007)(66476007)(66556008)(110136005)(41300700001)(4326008)(8936002)(8676002)(83380400001)(31696002)(2906002)(26005)(66574015)(36756003)(31686004)(6512007)(53546011)(2616005)(6486002)(6506007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cWh4M0R1REIvNkJ0TW80QzhHVTdWQy9IQyt1TDUvVUNSU0JpdGFTR3ZTaE5U?=
 =?utf-8?B?OFF1UHFVSmZJcS9mUHgrMUVHeDczcjVmM1NvZFE0S0FKVUZlTERIVi9IekV1?=
 =?utf-8?B?ZHFtdUFlVC9YWmNEVGptOEhvaUpjbzY0WGt6VkRwWlZlR1Z0d0VmNWdmZzdr?=
 =?utf-8?B?UE9yRTBQUnBtYW9tbU9ENWdHcjlFcVRTQU50TzRFNEpUTzdpRU9KNGJtc1Mx?=
 =?utf-8?B?Q0JhUDlXRmwvalNYc1VGVGtxdCtnemtrWnhKanQrQytvSmg5RzFZNGtzNndl?=
 =?utf-8?B?ZjFCMmZnbFV3cUo1NDJYSjVxTjV4ZzJmWi9Pd1VSYUUxUDYrTFVJb2JxS2t1?=
 =?utf-8?B?YnphL21xREIwZ1J4bGw0c3JNd1VGczRFVnNPNkp2SGQwWFpSdy93eDJFV3RZ?=
 =?utf-8?B?ZFlZVEdSa1YyUisxNitSTWJ5dXBsNjFUaXY0Q3BlWkhBN0Z2TnRzMkZnU1JQ?=
 =?utf-8?B?ak5JQ0Nzc2VMVFE4SUdDNmcxV09oYlJ4R2ZLRzFHQlY5TTV6andvYi9ZUklL?=
 =?utf-8?B?TTRKdCsvbkFPYkd5UFVXMlpWTlpCejhyQWE2bUNkall4OFBlVFI2MXhKdDdU?=
 =?utf-8?B?eTJHV3lESS8vbGRKa2JDNTI2alA3NWtJSWg5aTV4cW4rOHgzSkREaGNJaEVX?=
 =?utf-8?B?NG1lWUJiMFhqaEJwZ1JIRkVNbjR6THJBbW4rbUF5Q2k2eVp6eXovUlJVN3F3?=
 =?utf-8?B?ZTRXN0tGNkxUTkYrVTBYeXpXR3I3NmptSklRU2RHN1ZoV2ZSQTB3U0tUZkE1?=
 =?utf-8?B?MUtCVnN2NU5ubE1zZ1VGcDlYcVZFUUYvN2tpSXZKRTFwYVR4dFpORStqMW90?=
 =?utf-8?B?dU94TmxCeTY2Ym5Mb3pqZXY0cW52SkJkYnNZS2JNS0lWeFNlSDg0RzRwQlFW?=
 =?utf-8?B?NmxHcFRpVnZTQ2FRUll6YjZWdW9uVHBEVEdiYXBhWmxJS1piSmZRVTdJWnI0?=
 =?utf-8?B?cDhvclBPbGNzTW41bXpJVE56aS85c1ZGbitLNktKNE1WdWxUaFl1OEZUZUcz?=
 =?utf-8?B?MnJ3bXhzamJ2dXZxTWVodTdnYnIwQVN5U2w0cnRWaThCMmkxblNId0Nnb2dF?=
 =?utf-8?B?YmdjYkVKaUNYUWVhNnpvSHJ4TEo0anIxKzRTdFpOV0U3MzVkU05zSnRXNGdE?=
 =?utf-8?B?elBMRHZPR2FBdGhiWFBiNURsMm9zV0taTERyVGlGNlFPaUxPRVMvQU9Vdno1?=
 =?utf-8?B?aXVoclZ3QjhWRWRyb21Fa3FKdDBWY0JvamhOVWJUWXJZSWRGelkvNmZJS0hw?=
 =?utf-8?B?TmlvODRmTExONGsvZi9jUWp2cENnOUVZVE9jdHAyMzc0RVFSRE1QYUZpRXp0?=
 =?utf-8?B?Q0RuUnB6dnlyUEE0TFpndDBiejJLY2NiSWtJb01jZVpWeXlLYzA3RUV1RWNM?=
 =?utf-8?B?Y2dTakRSb0dsbkxuc0RmdE95bExpYlZDcXA4RDVEM1VOcUNycWRsTC92K0Nn?=
 =?utf-8?B?dDk4UVIveXFkYkpqWHZMaEJGYmhzS3RoWm1lNllqbjBHTDBkY3V0eXJGblFZ?=
 =?utf-8?B?M1VpbFZ2OWlzWlBKT2xlNFYxNm9wZ2pHVDB1R1V3KzdQamhRK2d5NmNSNFlG?=
 =?utf-8?B?aEhMVXR6MjFSTVJ4Zkp4UzdVWTJ6d2VTSHMwWWQ3T2o2b3hoUjd2d3Y4QkE3?=
 =?utf-8?B?eTZxUXVFSC94dWIva3Q5Q2JPd1c5U1EwSnJ5eEFRcGJIeGNxNXZuejhuWCtI?=
 =?utf-8?B?Q20wZk83cWkyWUtjYzlGWTlFb3NYZ3pIMDlPeEJ5ZnphOXNjbFMyV0NwM2pi?=
 =?utf-8?B?RU5Kb2N0YTg1VHM2bGJiaGQ5WWJMTk5xVHNGMWJTdXkrR04zVENKN3hVYkhO?=
 =?utf-8?B?bnlkajc2QUFNZk10RENHU05WQnhWdHBKZ2lhMnd2TURTVUtuWkhOdmNGbEVa?=
 =?utf-8?B?Y1Q0a3lWQVRDSzMzN3VJWWxxb0plQWZ3WWpDRzg1dTRPaUw4NEJBVlpib2Ra?=
 =?utf-8?B?c1d3OWF1a0NyaHNFTHFwUGpKTExVUExqSDV3dUJrL2ZHVzZDWUxYYVlRNXRK?=
 =?utf-8?B?RmFjZHUrakZ6V0YwcVQwUFExQXFsQTREVjlzbUhjM25JeHZTSC82dFVCM2l5?=
 =?utf-8?B?RnJCNkZ0V3ZtSS94ZGZST2FWN2FuWGxVU3JGYnN4K041WTZoMEV0N0dBbThO?=
 =?utf-8?Q?FWjU7c+SpCwYlL5IPcw5hyBs1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd1cbc33-ec9b-4eb8-98c0-08dbadfc7c22
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6351.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2023 10:40:13.0400 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ll5cmrLcNeB2XyqiV0s5nXx4MJ4nTAYC0PRpLtwfL3qgVGAfr4dR8rQzypfue0T7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6092
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



On 9/5/2023 1:24 PM, Christian König wrote:
> Am 04.09.23 um 08:05 schrieb Ma Jun:
>> [1] Remove the irq flags setting code since pci_alloc_irq_vectors()
>> handles these flags.
>> [2] Free the msi vectors in case of error.
>>
>> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c | 43 ++++++++++++++-----------
>>   1 file changed, 25 insertions(+), 18 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
>> index fa6d0adcec20..17043a1e37a5 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
>> @@ -271,28 +271,28 @@ static void amdgpu_restore_msix(struct amdgpu_device *adev)
>>   int amdgpu_irq_init(struct amdgpu_device *adev)
>>   {
>>   	int r = 0;
> 
> While at it please remove the assignment here.
> 
> Unless really necessary initializing local variables is rather frowned upon.
> 

Thanks for review. Will fix it in the next version.

Regards,
Ma Jun

> Apart from that Alex needs to take a look at this, I'm not that familiar 
> with this code.
> 
> Christian.
> 
>> -	unsigned int irq;
>> +	unsigned int irq, flags;
>>   
>>   	spin_lock_init(&adev->irq.lock);
>>   
>>   	/* Enable MSI if not disabled by module parameter */
>>   	adev->irq.msi_enabled = false;
>>   
>> +	if (amdgpu_msi_ok(adev))
>> +		flags = PCI_IRQ_MSI | PCI_IRQ_MSIX;
>> +	else
>> +		flags = PCI_IRQ_LEGACY;
>> +
>> +	/* we only need one vector */
>> +	r = pci_alloc_irq_vectors(adev->pdev, 1, 1, flags);
>> +	if (r < 0) {
>> +		dev_err(adev->dev, "Failed to alloc msi vectors\n");
>> +		return r;
>> +	}
>> +
>>   	if (amdgpu_msi_ok(adev)) {
>> -		int nvec = pci_msix_vec_count(adev->pdev);
>> -		unsigned int flags;
>> -
>> -		if (nvec <= 0)
>> -			flags = PCI_IRQ_MSI;
>> -		else
>> -			flags = PCI_IRQ_MSI | PCI_IRQ_MSIX;
>> -
>> -		/* we only need one vector */
>> -		nvec = pci_alloc_irq_vectors(adev->pdev, 1, 1, flags);
>> -		if (nvec > 0) {
>> -			adev->irq.msi_enabled = true;
>> -			dev_dbg(adev->dev, "using MSI/MSI-X.\n");
>> -		}
>> +		adev->irq.msi_enabled = true;
>> +		dev_dbg(adev->dev, "using MSI/MSI-X.\n");
>>   	}
>>   
>>   	INIT_WORK(&adev->irq.ih1_work, amdgpu_irq_handle_ih1);
>> @@ -302,22 +302,29 @@ int amdgpu_irq_init(struct amdgpu_device *adev)
>>   	/* Use vector 0 for MSI-X. */
>>   	r = pci_irq_vector(adev->pdev, 0);
>>   	if (r < 0)
>> -		return r;
>> +		goto free_vectors;
>>   	irq = r;
>>   
>>   	/* PCI devices require shared interrupts. */
>>   	r = request_irq(irq, amdgpu_irq_handler, IRQF_SHARED, adev_to_drm(adev)->driver->name,
>>   			adev_to_drm(adev));
>>   	if (r)
>> -		return r;
>> +		goto free_vectors;
>> +
>>   	adev->irq.installed = true;
>>   	adev->irq.irq = irq;
>>   	adev_to_drm(adev)->max_vblank_count = 0x00ffffff;
>>   
>>   	DRM_DEBUG("amdgpu: irq initialized.\n");
>>   	return 0;
>> -}
>>   
>> +free_vectors:
>> +	if (adev->irq.msi_enabled)
>> +		pci_free_irq_vectors(adev->pdev);
>> +
>> +	adev->irq.msi_enabled = false;
>> +	return r;
>> +}
>>   
>>   void amdgpu_irq_fini_hw(struct amdgpu_device *adev)
>>   {
> 
