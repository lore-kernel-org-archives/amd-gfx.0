Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EDF6C433FE
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Oct 2022 19:43:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E213D10E08B;
	Tue,  4 Oct 2022 19:43:47 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2072.outbound.protection.outlook.com [40.107.243.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B29810E08B
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Oct 2022 19:43:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gH9/dSokT8E/lOwmdile1FyCGJPzC2dSEAzQteKYJnguzq5xlLazqWtsIM8gWDZ2wwKe5nv0O2aD/LHag5KRgp6m90zW6c9zJ3chm02GEw0fBnTFrahQwGbQ4D4wKQlVxmqZWxva3CqInw98GjS2X3c04LvMdTGs2yd8rWMo2uxHk6+6xt2LBhGSeyCnudvYRjcrmGWKPnwIpeiHH8IQjqb4sdt2JaRHYUBHl8hNPLehsFa5KRCchdjv7qXWkAJcaiOO3GIDVz3zMab+bqSriXh8mKX6l6bDoZ+1GNd78WyaegtVPfjRQ6xQDKDghI5p3PEvZJrwFOnl9Hzd1zowkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TYMdxgRkKZ0kGofjoXCsADGRl0bSraS7kQeW6UXatgQ=;
 b=D52bRM8H+rf0k9x4DC7RsCj+vvBqCpQPeBcCCzM2esgSk0IVvl6VXBD0pb9AZQpRDp+OEpzxkmZWafBGhv3gsyWyn/J7ZQqYueTH5Rrfz5mnpcCkIRIeGKz8UTpjEg6PsUvtBNB52KWuxtN3S0smVpCLBMeZ0SXN3Qoe9DKbLjwdFXfcUjwbuSDv+ingpyq2tSQwpUFut/K8AXaNRKp16oJzK4FLpETIL9vDJbZnvLqXlsKLqwYc/QDWqGxotJk603B+1yS6vMUe17MVK5I2Wup9A6nt4gsDFvcHMK0Wxy57Ff2J3ZbZqLvh0+YixuwDZgLLLJxA/fG33jsln13KEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TYMdxgRkKZ0kGofjoXCsADGRl0bSraS7kQeW6UXatgQ=;
 b=qbZ3ttPR8kDllLu+PCwVjvt9RptwnewR7K6N1ztn8lVANwHjNh5UQil1bgLV/TppMthzF/5BcYznPSxUUdArjfPmoKzH4UhrvtxIq9mrsS95jgJevNtZ8xIuHSyUT1HY9WV64AbUnyEXRtlT/b+jvuXKpUXjdzUyDPH7XbRiaEQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by MW3PR12MB4380.namprd12.prod.outlook.com (2603:10b6:303:5a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.28; Tue, 4 Oct
 2022 19:43:40 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::2b12:fd3c:4197:4c97]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::2b12:fd3c:4197:4c97%7]) with mapi id 15.20.5676.030; Tue, 4 Oct 2022
 19:43:40 +0000
Message-ID: <e3354f27-f285-18dd-0352-c182128db88f@amd.com>
Date: Tue, 4 Oct 2022 15:43:38 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/1] drm/amdgpu: Correct amdgpu_amdkfd_total_mem_size
 calculation
Content-Language: en-CA
To: Felix Kuehling <felix.kuehling@amd.com>, Philip Yang
 <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20221004164154.9021-1-Philip.Yang@amd.com>
 <7bb97897-48be-4cc4-3802-201a16617b2b@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <7bb97897-48be-4cc4-3802-201a16617b2b@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL0PR02CA0143.namprd02.prod.outlook.com
 (2603:10b6:208:35::48) To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5149:EE_|MW3PR12MB4380:EE_
X-MS-Office365-Filtering-Correlation-Id: bc283f2e-4e53-4eca-00d8-08daa640bcd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /Bc77/7s5O5LAYStzteknZoYu2KcjrnL7gZ5pInHI/XLLKwkMKWRjdaL/4F/ODo7In+fxT09mTHofP+c6C5M5YaTLCuRWFI/QIRvwBCwQC/TNvaNiSfeYBh7skLhraOcBIhf6kEuFYjOxp5UguhdTitneDIa74D0Xc5y1DGu9s3yZp7aTGDno8M5bJ73yekUa/8C1efMUlQ22Uq7B371CXcdvG06L/3CLlVnqj/ssK8T2HJb716pTuVPmRUggL9+aRy5XUQNSVVvS7Nb6wRXO4ytn2cYD6Z/nBOkt4d381uwgh+4NoZL5q4Q38oFOsZsxd+yBA0Qp+4D0Hgi6xwVZVeGTmdZZqQWYEY0wt1iPw57o/NU5grnoCZda2hgGYkjcv7/tJ1Ui3vmJeHOTXDimvP9zpaJ1t+/HjAPu9PpYpS2EtSlE2dvcS8UVq20kVkRM8q7fBqNHoq/Ox2Z6xKOOqPTDKjip4ieUI1TzUiDsbKR6uQdgaTE+b/UAqlf7BU5APmK4+6wXLFZZp/4bodj8qPJIgwkaQp0siGW8vw+py9k3No3yljqfYD1PFNSTeO6WYoNrN5kyvP6SCrQQWwPiz/evDrrbu1ONpd5RRNQ2UgDwlG5LRQ4NFYrTJnNpcDmwnfZo34BAwjvhY64UjOu1BuVnKw4XdFPOBkt7tyhlv2VRV8hEisORIYt5NwFYJhlDyOvbOLj0eYrNnBfJXDgwmeyoB9WsqzNbNUTG0KkpRM7kvEDZpWn5ljcaAc/9rbHqywcqU2xK33YflnDl9L0fVJdB+5x9jElHN2Dj9Tzz8g=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(136003)(396003)(366004)(376002)(39860400002)(451199015)(41300700001)(478600001)(6486002)(110136005)(66476007)(66556008)(8676002)(66946007)(316002)(36756003)(38100700002)(83380400001)(6512007)(53546011)(6506007)(31696002)(5660300002)(26005)(8936002)(2906002)(2616005)(186003)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Wk5qN0dSeVBzQ1VIeGg3ejJublpDVldvOUdyWXd3dTdxckdReTV0SHBFR1N1?=
 =?utf-8?B?K1U5eSs2R3Fhdk1DZ3ZVUi83Z0YvOFF3MUFIcW5IZDFUU2JwRnl5aHovM04y?=
 =?utf-8?B?c3RMTTY4M2NVWUErMm5rbnBGbVZVYkpuQ0hHakEveWZ3Nis3elcxeGFwWnVm?=
 =?utf-8?B?bWU2bUlVZnhPNnFtV211MmVCRVpjaW9TZU5qQVVaclc1V1NKQzVWZEdNZHJ2?=
 =?utf-8?B?alFUNW95UTBkUzlQeHpDakhRWDVxQmhKcHpsam9Bb3JpZGtiNDhzMGV6L1J5?=
 =?utf-8?B?L0lQUzRNZEtQR1lTMHVrWEVrTS9FVk53Rmt1Ull2SkZCSWpRUUVDM1B2SitF?=
 =?utf-8?B?Y1J5cTJXYWRmSmxCRjZENDdwV1UwL29qZ1pIcVpnNmNwTGVSZGQzTGdhWm05?=
 =?utf-8?B?ME4yZWpvMTFWcjJXTkRIVTVVUmRvRmlOcmVqMmU2RndsY2NnVXpsRzNXb3lN?=
 =?utf-8?B?SEQ4MENBMmNZQTcycnBucEJ6Wk4zc2h1U0pvZDE3c3RlcFpIRllUcjhxaUla?=
 =?utf-8?B?WUFJNGk0VC9pVVFQLzFrKzFqT1EzR1E1dFUwTFJvVlFXVmRuek5pRlRhSEt0?=
 =?utf-8?B?T1RmWnlHMS9TcmdtTDN0QWFXZUFFUGcwblRMTGN4NDRsZnBzdGpQY21RekNm?=
 =?utf-8?B?NWR0WDJXZmR4QW9kNDRBRitOQTg4c1RGbXFyb1JwMmVuVG50ekNkSzB6MnNI?=
 =?utf-8?B?dVVodk5INlJheDIwNXN3WnVxczFzWitoaGsrNzVXUVJCZzJaTmlMejREeHpt?=
 =?utf-8?B?NmlScTFSTVpTMEhIWG9vUjZVbUxpeEpYWVV2TkZObk1pREVCbGVNZ3hNNklJ?=
 =?utf-8?B?bERhWjNnZmtPUGZ2d2J4ZE12UTZlQm9Cc1dhMS9Mc1YzYUo2UjAwekhsbEtt?=
 =?utf-8?B?SFNTZzA2TW13aW1zcHNJT1dRT3dDbVNER0s3MGd6ZlhGK05kM0FvWkRYWC91?=
 =?utf-8?B?RlZ4eTQvbVhIeG9aeWRhV0NrRVFhMk5Gb0dhRzZrbmcyMk83OVVSeitnbGlv?=
 =?utf-8?B?djFpVWpyUkoyZzhoaE13UmZKek9rSXhwS21uVFZZcWp6UE1TbU9GYncrcyt3?=
 =?utf-8?B?eTVpclB6V1MrK0tkQXQySkIzT0VXOERQNE9hMW1zclVKUWdBdHRVQXIvZVc2?=
 =?utf-8?B?bXkrcCtMelN6bFhJaXVyNlpJcFphV1ZGQ3pkS3E1R242MWw0MkNhdlVCU3BM?=
 =?utf-8?B?VlduYWQ0aTA5WlNCR3ptNHp4aTZLRUtPbklhRnBkVUZpQU5iMkJrUEtuZ1Fk?=
 =?utf-8?B?dHk2L3dyTk5POVI0dENhUU5vSGZSci9mTG9sMDVRZlJEdGxhY0h3dkllZGYy?=
 =?utf-8?B?b0ZBdG45MU9hUXRwTFhTaGpTQURzRTA3QUo4bUc1NnQ1aVloV0xXU3pjOGY1?=
 =?utf-8?B?SWhzY3FVamw1TXIzNGt2em5sVUwyRnRkVlRjdzZXYXpXQ3lUQ2d6N2xoQlF2?=
 =?utf-8?B?dzFTMFd3Vm1nZm1NSmw1UGI0ZFd3Q0kwbXdJeXZjdStKU0htaWt6ait3UkNN?=
 =?utf-8?B?eGJadGhNd0l4ODRZQzNaa0JXT1Zvb3p4WGx0T1BDZVBmemFOMVRLSStObFlj?=
 =?utf-8?B?QUZucEVGc0UyenQ0dndpRjdwK2QyRDRmSnpkU0cyNXBVVzZFUWY1aWEzVDc0?=
 =?utf-8?B?c1Ewa3ZadklZaUtiZFdnY01lVldJakZOcHYyOHJkei9jY3l4WUM4VnFhZXpS?=
 =?utf-8?B?R1Y5QzNMemlWMUQvaTNmdUFMK2xkSnNGaFdiMEVKUmFDcEMyMmZUTEo5WGlZ?=
 =?utf-8?B?RGZXS3RKc293UnM3V1R6b24wcSs3cUQ4bFpCRmJkcXh0ZEVIMkNOVGVlbFJO?=
 =?utf-8?B?MWZLRlhvMzZMazVGbU8rTmhrVHJ6SnA1SzBVdTl4bFhMUXpkSkZYeTA5Y01I?=
 =?utf-8?B?VWxUbVpDamtCTkdBdGFnN2JIOGdUZzlwNjNyVG90VW5hUnJRSWxZeEdBQ0sx?=
 =?utf-8?B?c0ZTUVA3MWpQaEFwMFpseUlLaWorUDFRSjFpV3lYRkJIQmcxV1FJUXAzMkJw?=
 =?utf-8?B?anNZVzVLRHE1aUp6SC9RWVFMbHp6VDBDUUE2MlFvWjd4MmNudE10eXBibGJY?=
 =?utf-8?B?aldLOExXNnovU0d2YllEQlh2Ump2M0F5bmcwRXloMEhiMnRTYlN2anFNYUl5?=
 =?utf-8?Q?IbX6OHmPlfIZHiLq2gb0sRqtk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc283f2e-4e53-4eca-00d8-08daa640bcd2
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2022 19:43:40.4062 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r6I44h2ajmXVy3FavosYUG+5kt3/SMOVY4vXd9NU43p4afu2Ftu44D3bFkbhLhhe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4380
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


On 2022-10-04 15:16, Felix Kuehling wrote:
> On 2022-10-04 12:41, Philip Yang wrote:
>> amdkfd_total_mem_size is the size of total GPUs vram plus system memory
>> to estimate page tables memory usage and leave enough VRAM room for page
>> tables allocation.
>>
>> Calculate amdkfd_total_mem_size in amdgpu_amdkfd_device_probe is
>> incorrect because adev->gmc.real_vram_size is still 0 called from
>> amdgpu_device_ip_early_init. Move the calculation
>> to amdgpu_amdkfd_device_init to get the correct VRAM size.
>>
>> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
>
> Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
>
> Semi-related to this, there should probably be a reverse calculation 
> in amdgpu_amdkfd_device_fini_sw to support hot-unplugging GPUs.

I will add the reverse calculation then submit.

Regards,

Philip

>
> Regards,
>   Felix
>
>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 5 ++---
>>   1 file changed, 2 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>> index 9e98f3866edc..049d192c7cdf 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>> @@ -75,9 +75,6 @@ void amdgpu_amdkfd_device_probe(struct 
>> amdgpu_device *adev)
>>           return;
>>         adev->kfd.dev = kgd2kfd_probe(adev, vf);
>> -
>> -    if (adev->kfd.dev)
>> -        amdgpu_amdkfd_total_mem_size += adev->gmc.real_vram_size;
>>   }
>>     /**
>> @@ -201,6 +198,8 @@ void amdgpu_amdkfd_device_init(struct 
>> amdgpu_device *adev)
>>           adev->kfd.init_complete = kgd2kfd_device_init(adev->kfd.dev,
>>                           adev_to_drm(adev), &gpu_resources);
>>   +        amdgpu_amdkfd_total_mem_size += adev->gmc.real_vram_size;
>> +
>>           INIT_WORK(&adev->kfd.reset_work, amdgpu_amdkfd_reset_work);
>>       }
>>   }
