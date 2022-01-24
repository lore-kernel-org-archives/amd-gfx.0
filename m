Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07CF2C433FE
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Jan 2022 16:46:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6565110E1E2;
	Mon, 24 Jan 2022 16:46:45 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2083.outbound.protection.outlook.com [40.107.93.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CFA810E1E2
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Jan 2022 16:46:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bh6Y0xATQiG0T3y9WX0psRlptclVpJv2x3/I+OxSRPjLnnBV4EoKIvMrvNg+NbwgC6iRLX/3vIzMbvkdRD/GfOuQPOmR3DcKmlV5+D9cYksxWroeZ1FeLJaLEYnTUsX4s3xSddTkkRjqhiQeanuRQpvZMd3fLs11xSBTib7EabWf021J7J7JDTnFLNldYJAkg+MLSRgOUuQGD/pXVYDIswjLi3ERIQg75vNjxRBcYCO/Fj/xnHq2Ti1Q8gFZTp4NDLU/DkbdPubkvga0E4RjMuEN7izc+2zE3I1BddcPIqhrn5N8c/CurXhuW60QLc/E/i6jIZhA7cHZ9DK4j+dPqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n0rmr5drvvEBwnjGA3kElEhIYvE3MYG7hRVt9xpvWIg=;
 b=WQVRCauN19SJ6QnHS96s9CHdGEUXJ14SJiK/bojaxVcUDxb4tPgxC47K4Nq+pAbBeCX9Zms+3OwfpSKn6JhMVgyv+Rq9aEDhrG8wSNuF6hgFKNCwX9J5EwD+q6f7nsPHNw+7T2nPhrI80TuZDQujA+HDrMGd+RhVKwDbA+o6nescgK7j40hmUPruofiDbgUmyufHo7z28H2SASLsZr7EfNVTZaz7gB9a+58d+oM2fJjMhI0ZxuCvUbKacEnZqvZ41LRQa4uTNCtn5rD0BTzKyHsRAP9LGSda+qD2s8+TcEV1oSDorfRyEAuNCZNwcnua7aIZDRpjAJaB7Z1QW9dXxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n0rmr5drvvEBwnjGA3kElEhIYvE3MYG7hRVt9xpvWIg=;
 b=UiN1QfHwgcfeqhVpvWlaXuBreJrIRewJOjURmeypk+ocDdoqCSqvX5RGiUKXZi2y2S5JS+B2EFpIlUedYxB6zk7LBgIYeiEsw9zXtEPgdvaFl2zq+OAdXf2E2u8uQiP4MG/WvtiCCZ1MdqHt4fLPPmGjirRMcMlmCw908oH/HJY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5040.namprd12.prod.outlook.com (2603:10b6:5:38b::19)
 by BN6PR12MB1713.namprd12.prod.outlook.com (2603:10b6:404:106::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.7; Mon, 24 Jan
 2022 16:46:42 +0000
Received: from DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::84cf:cad7:192:8089]) by DM4PR12MB5040.namprd12.prod.outlook.com
 ([fe80::84cf:cad7:192:8089%8]) with mapi id 15.20.4909.017; Mon, 24 Jan 2022
 16:46:42 +0000
Message-ID: <88476e37-5069-867b-1192-022e8aa02162@amd.com>
Date: Mon, 24 Jan 2022 17:46:35 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 2/4] drm/amdgpu: add work function for GPU reset
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <b951f172-45f4-c88d-6655-8eec715c038c@amd.com>
 <5d71f21b-39fb-90f6-226b-fd5dd46ce010@amd.com>
From: "Sharma, Shashank" <shashank.sharma@amd.com>
In-Reply-To: <5d71f21b-39fb-90f6-226b-fd5dd46ce010@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM6P191CA0006.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:209:8b::19) To DM4PR12MB5040.namprd12.prod.outlook.com
 (2603:10b6:5:38b::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7d49b9ba-50a8-4104-e93f-08d9df591937
X-MS-TrafficTypeDiagnostic: BN6PR12MB1713:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB1713D17FB51679405BA995FAF25E9@BN6PR12MB1713.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2582;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9c3ZaKD4G6Rb0tntWZwMph5uPj2JemmOSk/leYqa+ARp4J41yjK6NvqhFTPPTuemdo4ZLsvugaqbHK5yUGOrfheS9s8R1wc7u9l7R0DUo4vGba9AH6Awc1gcr74zJ+eq80X7m7GNmJbO7AiedXoxmM9KcRaeCm/AsL63mtG/Qbb12lHAuxym2WAkviEf2gUQDzqmncdHloSc4EAno8ig088IKy16K/pOaXC2e2QUMYzLM+ime9+vDDw49Ap070GcLBzBaiqTMjM7Cnx0Gbv8DNW7sDMso14L7bKcT9aZ2i236ibs2x4X8lUTa0F1eWggHqHjXp9eGZoarvt/tr2ESh7nOmzOHkfMuU8wQI1btFC1F5Y0LQILnEt8UImmRdGTe5cQhxOUsHCJNu2sVHbyZZR86mba+FkNr1bxa5wO8SSYShGLZUoSs8Cn/e01NFoRLgUYKGSwoTR7GlVEu5JalI80x9kTK9/58aL6yZV+31XG2IA+7bpPA5zIrZB4CULx1Z8Tfte9qO1OS8jwo2aBKy4eNMwnUFWcYEd38AzYkdl+SvO0dD0BS88MBvjjsAm1cVO6Wad1ACUSG44FtE1mSNQ5gipynVk0pK2yZoPAxE/PVZFSI79o4tofiRpmRH+rcNnoPYxeinIQSOO9dRzxLFYNNL1s2JMu46pWFeRe0szUR1Ul70dOC8SVQLs+mR94y2vRfxk3lXbAn/PTatUtjiGMxtMlyofC2bvX2bARYsdB12ploQLnCro/ri5DU/iA
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5040.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(5660300002)(6506007)(26005)(8936002)(86362001)(31696002)(53546011)(316002)(6486002)(66946007)(4326008)(186003)(508600001)(2616005)(38100700002)(2906002)(36756003)(66556008)(6666004)(31686004)(8676002)(6512007)(66476007)(110136005)(54906003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RTVPVDhvZTV4Q3M3NjY3SGZkcDNxSnhDcFZZWkx4WGJTQjJ5NDJhaFJiTGFL?=
 =?utf-8?B?NDFpaVhENmJWRG1UanlJN2NPeFJVaFZXMzl2blFkOUZlV2tNdEp2RWtQU21V?=
 =?utf-8?B?NnhkeEsvWWN0azhJUWVVSDllSllLTWdtMzNoUnc0cWZtQ1Q1ME4rS25VeExZ?=
 =?utf-8?B?ejU0RWQvZXh6WGJ6dk5sVEVrekZPMzhYRERyTkExb1lJUlVIblNTQndqRkVh?=
 =?utf-8?B?ZE8wbDkwdmdMcG96NDh4dUlnNWtOa2Jvd1Rta2tzUkVFRjBLaWVDOEJQYXE4?=
 =?utf-8?B?WUV4OWMxTldtN05QemJpckJsSE41c0lGdTNEb2VtT3lVQU01NjJWd2ZRYXRz?=
 =?utf-8?B?MzZ6ZGhDZjJob2NSaEtFYlVJK0liQisybzFITGcrUDl4ZXU5dmpXL0JxMnZW?=
 =?utf-8?B?alh4Z2hJNmpFK2VETytYU1ZMZTc5OHlUdDhlaElPRDNLMStQSHBDOElpcTND?=
 =?utf-8?B?UjZKblE3M05ESVVyWTRBR3hPS2JrUkJrWmRlQWZONWk0NjVWUFRYYUNNT2My?=
 =?utf-8?B?UzdaVVl0V1NCWlhwNm9QcGpTZm9NUStuOWNsL3E4Z3hpTzQ2Z0h0UGJMSEdZ?=
 =?utf-8?B?K21WOEt6YjFjSmxaOWZlMjhyaWNJdXBPN2s5YzBRWkV5WmxFWUdDdnRnSnh5?=
 =?utf-8?B?dVEzelF4YTV3NHBKOTI5Wnd6OUF6R2c1OHBTYUpyeWg3VjZ0M2RrOHNVMFM2?=
 =?utf-8?B?ZmpRT0F0K3Z3WkhYMzZYVG1IV24vcTR0TVU5NkNRRVc1VnhTN0kvSm02RU12?=
 =?utf-8?B?Szd0UThuT3N3bU80T2luUDR3U1RHb2QzOC9rSGYvVjQ0Kyt4QWhISXBwM0hW?=
 =?utf-8?B?NFhMRHk0ekRXcTVJOFdNMGFrOHZLeCtzRDlrbGVTd1V5MWIvdTE1bzVJYVpY?=
 =?utf-8?B?TGJQdFkxTHFmVUozZE5uVU41b0V4RDI0SjM2bmVpL0Uvczloc3hHN2JMSVVy?=
 =?utf-8?B?Z3piODRHd2RQSmo3bktBYjRpMTd3TkRucDA5S3JzdXRGdmJJTmhkQmFEY1M3?=
 =?utf-8?B?dXZUUEd4aCtaNVN0SDlwZ3orV3lnSTMwR0dyZk9yWjRyZW5PRGRia2ErbmFD?=
 =?utf-8?B?bCtLaG1tOG9RL3lvSUpESWczT1c0MTg1VkhtQ09JL0xUNjZpMHFlMFlZbmNk?=
 =?utf-8?B?QmxsSE9QVHRhVXZoN1VTbjFFNENwQXhNNjNHdVNJRlo5VUhmMUVkWjBNZ0dS?=
 =?utf-8?B?NDdvemJDblpWbWEyeTRiZ1FQTjR5ZTRsdDk5clFsWEo2Ylpzb3ZEK2pybk1t?=
 =?utf-8?B?cjR6TWh3eDYxOEJ6SXdsUUxqWnRqOGRRTFRGUEZvdisxQzlWeDRodFF6NDBq?=
 =?utf-8?B?c1FacjVJTWltRzJKUkRTWmpKKzBRTmtwRzVWaU5HUFlwQWpUeVZaMCt2SVVv?=
 =?utf-8?B?Z2FFdUI5OTdVVlZiMnY4ZFF6UFZ0R1Y1M05IWXNSNS9jcUJKM1MxSkFIaWRq?=
 =?utf-8?B?YnBUZUhGYlZDbWhMYjJPUWhzQjlJZVEwaHZnd1Jsc1VmVDRkM0RNc01LQmpC?=
 =?utf-8?B?VHlDU3d5U2pyd0xiT3JPc2RZSWQrS0ViUTFHQkNuU1RtdDlySXZmNVZQS3dF?=
 =?utf-8?B?N20xYk90c3BIWkliWW1IZE82cFMwcDZ3d2hJdUR3eEsyWVM0eDZIVmdwekZQ?=
 =?utf-8?B?QW1ibzMvNWMvVDg3N3ZibDFNNUo3SXQ4clhnWUhJZEljU2owc2xPR3lZMmhX?=
 =?utf-8?B?Rms1T1NzYTVqTUhjY2R4ZGNZNHBBWkhSQzlzZnVqdzdWL2gvN3NuYjdsSFZX?=
 =?utf-8?B?a0dRTWJjYUsxbi91bU5kN1pXRCtOYUhmcmQvTGV5R2R2dDNNbzNaR3ZSZmIz?=
 =?utf-8?B?NFhuRE1JZmg4eFlJdXV6T0tBK09YSXVWZUI1bUg3T25uYTNhUllYRm10enNw?=
 =?utf-8?B?NGZUczQ4QXJHK0ZOMVpUNjBma0FvRjRpcThXdVdlK0hmNzZNY1Q4R2cxbU5l?=
 =?utf-8?B?TGEya3RwYzR6K1NTSmZYRjZkSXQybGxNNFpjMlpVYk03d2tMSFVvNEFPU3g2?=
 =?utf-8?B?N2RIZVY0T3AyUGp0L0JjRDUwS0I1UXE4NGxMbUdEbmVGMXRJVnpUNjFJSDB2?=
 =?utf-8?B?czlvTDdpUGszNmd1V3V0cUJTalJXV01EczJjTC9SN0diV0lTMkpIeTROaEhx?=
 =?utf-8?B?RHhNdE42cVNKTkhhT0R4cWRlUElsMWVtYXF3NUhjaHdMZ3dKdDllUHFwYU8v?=
 =?utf-8?Q?MSZF3PExKFbIP6ccPY1FuT0=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d49b9ba-50a8-4104-e93f-08d9df591937
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5040.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2022 16:46:42.1094 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HyhI1yeuuBCpHwM4JtIaKsbD2mBOKEArHRcL7uvZ8EQzUxeHuxG4SNL0Egb8Er2h/5A6qdnv4c9FHiwljxSO9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1713
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 1/24/2022 8:17 AM, Christian König wrote:
> Am 21.01.22 um 21:37 schrieb Sharma, Shashank:
>> From c598dd586dd15fc5ae0a883a2e6f4094ec024085 Mon Sep 17 00:00:00 2001
>> From: Shashank Sharma <shashank.sharma@amd.com>
>> Date: Fri, 21 Jan 2022 17:33:10 +0100
>> Subject: [PATCH 2/4] drm/amdgpu: add work function for GPU reset
>>
>> This patch adds a new work function, which will get scheduled
>> in event of a GPU reset, and will send a uevent to indicate the same.
>> The userspace can do some post-processing work like collecting data
>> from a trace event.
>>
>> Cc: Alexander Deucher <alexander.deucher@amd.com>
>> Cc: Christian Koenig <christian.koenig@amd.com>
>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  2 ++
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 14 ++++++++++++++
>>  2 files changed, 16 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> index 269437b01328..79192f43bb71 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
>> @@ -1057,6 +1057,8 @@ struct amdgpu_device {
>>      struct work_struct        xgmi_reset_work;
>>      struct list_head        reset_list;
>>
>> +    struct work_struct        gpu_reset_work;
> 
> This needs a different name. "gpu_reset_work" would indicate that it 
> does the GPU reset, but this really only signals the reset to userspace.
> 
Agree, let me come back with something like gpu_reset_housekeeping or 
something less weird that that :)

> Christian.
> 
>> +
>>      long                gfx_timeout;
>>      long                sdma_timeout;
>>      long                video_timeout;
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> index af9bdf16eefd..e29e58240869 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>> @@ -72,6 +72,7 @@
>>  #include <linux/pm_runtime.h>
>>
>>  #include <drm/drm_drv.h>
>> +#include <drm/drm_sysfs.h>
>>
>>  MODULE_FIRMWARE("amdgpu/vega10_gpu_info.bin");
>>  MODULE_FIRMWARE("amdgpu/vega12_gpu_info.bin");
>> @@ -3274,6 +3275,18 @@ bool amdgpu_device_has_dc_support(struct 
>> amdgpu_device *adev)
>>      return amdgpu_device_asic_has_dc_support(adev->asic_type);
>>  }
>>
>> +static void amdgpu_device_gpu_reset_func(struct work_struct *__work)
>> +{
>> +    struct amdgpu_device *adev =
>> +        container_of(__work, struct amdgpu_device, gpu_reset_work);
>> +
>> +    /*
>> +     * Inform userspace that a GPU reset happened, and it should collect
>> +     * data from the trace event.
>> +     */
>> +    drm_sysfs_gpu_reset_event(&adev->ddev);
>> +}
>> +
>>  static void amdgpu_device_xgmi_reset_func(struct work_struct *__work)
>>  {
>>      struct amdgpu_device *adev =
>> @@ -3506,6 +3519,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>>                amdgpu_device_delay_enable_gfx_off);
>>
>>      INIT_WORK(&adev->xgmi_reset_work, amdgpu_device_xgmi_reset_func);
>> +    INIT_WORK(&adev->gpu_reset_work, amdgpu_device_gpu_reset_func);
>>
>>      adev->gfx.gfx_off_req_count = 1;
>>      adev->pm.ac_power = power_supply_is_system_supplied() > 0;
> 
