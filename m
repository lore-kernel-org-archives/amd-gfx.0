Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CCC7C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Jan 2022 09:07:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB84A10E5EF;
	Fri, 28 Jan 2022 09:07:07 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2045.outbound.protection.outlook.com [40.107.243.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 098ED10E5CB
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Jan 2022 09:07:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KjihDsA33e14k3eE8LPD3kv6rP1UKIm4yQcutQHwbbaQcYEeXn4RJyd+BMEv01I3hxCauKW5nVgBuBU9GegNsu5RfDyBBJiN2kBvoYnG64B5uEZcvzKJWfwes3rlWAefPVaTF/xhpBfeJ4Hc6r88HjHnXOop5K2qd5NpfVDcHrBPRSE8i9nrEcxukQMrSEVFNdgP1OoyDaUfIFTKYgUyBRfLqUiqrVc7mGCF6sHjOYSi9HtpuWOm0j9y0GcQjxtxiYOTA+IiqBEBdP70CTPLsfWaokyCwPw9GgtYyeBiHKLWlCp863TeP2NDQMBxgVqN7A4YUsN+seBssgikrLKlBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cQ2cBum6jKM+OJNV07dlRZ92rSwTnFPBSIpgDt/oKYs=;
 b=EKCA7U/H83sPEP1sjqYi8FekgsfasWEbGwtxFffITQcBQwpxgg5+tYG7gURxuaafg59GnuRU46SXteDDJhJVfIEQoJxA2up/07JgSz4nU+yhDpI1ccEivF52R6ZkXoFFtaoTJK3B/4iohfcNPHJMOvncbVhVPO1cafbVHwUMQKWG55sba5/xLmXuMIEqgcGT1I/QtoHSWLkxwWMA2ibLciXHSs5DL5yLDf9K4KvJHsxQeptdyUbmYwHmfxsZKGb3iWtk8f0TzV/dQiHmR/QsVq51fwBBPGpp01KtOEtRFmOytpaMwCnPd/+B6xbB95DFOYhUnca1xSyICZyzf9eRyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cQ2cBum6jKM+OJNV07dlRZ92rSwTnFPBSIpgDt/oKYs=;
 b=4VGKVlUMoIaT5PDEqDeWo6nFI3pyF0stwYTe01mXfIbbjoJncbGxWCqR7i12kwp1rmVINUk/c4C6QgNpgvMTsu8+tiUL+jF3apsb3hfdO+aN/bOFRxNTD3b9aVI8/ZLMAH4JtPTgkU+aNAZ+5dqxfrUctRkjQAsKVHf+pE4v5YU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by CH0PR12MB5043.namprd12.prod.outlook.com (2603:10b6:610:e2::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Fri, 28 Jan
 2022 09:07:04 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::b07d:3a18:d06d:cb0b]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::b07d:3a18:d06d:cb0b%4]) with mapi id 15.20.4909.017; Fri, 28 Jan 2022
 09:07:04 +0000
Message-ID: <e2976675-f3a3-084e-2d90-b3000f216098@amd.com>
Date: Fri, 28 Jan 2022 14:36:48 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v2] drm/amdgpu: add safeguards for querying GMC CG state
Content-Language: en-US
To: Lang Yu <Lang.Yu@amd.com>
References: <20220128065409.1479854-1-Lang.Yu@amd.com>
 <d8bf41f2-6aa8-8af5-c5a7-ba0750549a82@amd.com>
 <YfOuy/sVoKBpJI5+@lang-desktop>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <YfOuy/sVoKBpJI5+@lang-desktop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1PR0101CA0010.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:18::20) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4d12529a-91db-47cd-58d2-08d9e23d8ce9
X-MS-TrafficTypeDiagnostic: CH0PR12MB5043:EE_
X-Microsoft-Antispam-PRVS: <CH0PR12MB50435BE40162166242EE9FA497229@CH0PR12MB5043.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PGysacrWhAwIa0trNcj12Pgo/LBxaSzT68QMJwfRXMxf8C/yDKmgw7tlFMjoGt3YyeNV3Pylx6hSwojH6Vk5ewjAU4cU8FClHriUalAkQndFyAQ+1hYyXtNUp4l5rZhQ6E5N3khXBvotpLtdR5vX9Ve5SyCk8UakCN3W/VHLIXpd6V4EviGvHDZsMdqaiIiUK6kvAwgoSydFlr4W6SNUau7DnLUwwNiBMo6FAa1dMwqzaBxIVrMiMRduGEgFyI+e+kNkj70C44zmBYrL1JPL4FssP6KI6VdUXAccZIlvAoCEubPnd+rpC3mSTGmoa8NIZ5SHVo9zlkjlqOvKeP16TW2NcX5H0N301VwmLDTeKluK2eVf/PsmQGAC2QExXi/7pka5VAGUleHHcP9UUYz7zJS9vSnZRkLc6GyfAgoLzT02i6BDgFRV9UgrBH/0pXhPkE4PxLFAL3SXkQmyrMwJOKkVx44yOkqYs5w8kLNbAeclb9rWbzSB/p9MYB8R3X0QMQrxH7uF9mA+cB326+cRU7RI67GBhEpz14K+a9Oif5vGF6UkCLD50KnPR5qk5/IOns4AIyI9fFbG3v9rNmHSfMw+yHm54K1Lcs7+MYiX/qF+Z2Cv94KUf8HDb84GQ7D0hsci4Cg3at6x9nCV5L9+MBfFhdMzA4ibUe0eao2XxAZnhCKk7mPAi7mGSB/mtoaeplgoILU+Evcp/M+ABKYs9cRH7m1Oq3e3ThjJVU+SBucrIeM3tWM6TF//Sgn3Eugy
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(2616005)(31686004)(5660300002)(66946007)(4326008)(26005)(8936002)(8676002)(186003)(6862004)(38100700002)(66556008)(66476007)(36756003)(83380400001)(53546011)(2906002)(86362001)(31696002)(6486002)(54906003)(316002)(37006003)(6636002)(508600001)(6666004)(6512007)(6506007)(45980500001)(43740500002)(20210929001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NlFORzEwVDNtQ2hvZEpDMmxobFF3cXhLMjVJMm1vVVFSOWRwdHVLcHpMT3hx?=
 =?utf-8?B?ODlxcmg5YlhtcG1ua0FIT3hycHlodmRmYVo1NlR2ZTVDMTZWNUhtaGlscHl5?=
 =?utf-8?B?RlJOVURMVjlyaUgrQ3I2SXZmdDJQZDVCM2Z0bTNBTnpDMXZCWnUrS0V4Q0pl?=
 =?utf-8?B?SmlRdVl6NU9ic3F0MTF6c3BsMUQrcU1pTU9GUTltVEJ6eVNZQ0pKRUo0VDZa?=
 =?utf-8?B?cUlSRlZXN1lpMXFGRzR4Vk5zZThGY2sxZm9rSk1BVTlpTTdLYkhnZDVtdnpM?=
 =?utf-8?B?dGhvZXB1ZVYwMS90Q0NOaldJZ2tvMDVvN1I5aHFFb0N0MEFPOU9mTFJ4ODAv?=
 =?utf-8?B?NFVFUEpNcTNtRHFtZzY1U3dxdGt6bDllaStVTlh2R3YzQVJ1aFRSVXRVZUs0?=
 =?utf-8?B?RVE2V01mdUlRaXE5aE1ZUm5XMDNKeC9DekFTN1o1dmVKaG5KbGF4dmp1MklX?=
 =?utf-8?B?Z1I4ekFSaDBvQTJjZ1lEdWlDdmJLTkdrMCtibXJKTk01emhWNkdmTlE2Sysx?=
 =?utf-8?B?aGN0TjIwZGN2NXZqWms5OXpwWEVHa2owNXhnSEppaHlnMk5XQ0hIRzd5aHBT?=
 =?utf-8?B?WnJjeExsUUtMOFNicEQ5LzZyT0Q0ZFB0N2ErRmhZOENpckszU2pLU2NyQUlp?=
 =?utf-8?B?TEtYRE9tWGd4ME4ySzBOeE1rZ2xtaWlqZGJrZFNRNzJhdmFwUTFrRXBRWWEx?=
 =?utf-8?B?V2lieU9td014VEMxVkRzWi9sRHI1cUo5UWQ5dFBuTGJtK3FhQTkrWUg4RHhM?=
 =?utf-8?B?T0htcnRYZ1JaTms2V2JHT2svam5xQjN6SXdGTnFIeFlOOFZMcjM3YkxaVTZj?=
 =?utf-8?B?K21WUUtUb0oramUrNzlYQkNCYnJIWmdVV0RNMUJkYzliMDg4cmdYSEJ5K1Fu?=
 =?utf-8?B?REttaHBlSG9DQ0I5c0dJa1NPWVZmbGkyQVplN2dHWG5PWXM2Ymlhd0pOYlZU?=
 =?utf-8?B?REpDSnplVUtqd1lHYkZQcjkzYXh3bzlNZGtQcVlFaDJXd3dBWDVMcm11V2xw?=
 =?utf-8?B?YkRSMmdzSjkzSzRUekVBTWl3SXNGWTNIWGdZWWlYZFR6Lzh5elRCbmgvNnRL?=
 =?utf-8?B?NWFqbmRreFpjdXRGUFI5eUtLTFdsUThJaWIyUE44Uk9OeHE1ajk4bzFQdnF5?=
 =?utf-8?B?OEFRK0FGdUR6MmpBQk44UlQraW1FZzFsejRjdTl5a1ZSb1FXZm5xUmVHNUNF?=
 =?utf-8?B?UGdOMC8zM0RTcHY1bi9yZC9oREV5cVhrNkJnV0UzQVVYR252YVR1MGcyblRw?=
 =?utf-8?B?SGxBQkM3MEJjekdDbHZTdEp5bHJCU1c1TTcvRmhEbVR4YklrYmhxNEdLM0E0?=
 =?utf-8?B?YjBRNFJkb3RrQ3ZFaVNldXlyZUVrSWs0d2VZOC9Lb2QvVnpzUWdXZGtpTzFn?=
 =?utf-8?B?WXN3TUZnL0R6NzBRaDBHYUNJTXpMZE9ndDkySWI4c25GWjlpWVBUS3o0WXNV?=
 =?utf-8?B?Vi9VTlo0SFNBS2k5Qmc3aXh5aGVGZTZjTC9OY3ZiVVVGdUE4UW00dkFpZjdD?=
 =?utf-8?B?UUpCb05PSU5IVGs4cHNTT0NucFVOMzltaGxVWEptVVhQUmpTMzJSS1RUaXlY?=
 =?utf-8?B?c3JFMGlGSVhEZjNwWGF6Vk9NTTRYektzTUVtMGxxUVB0bzQvRDYvM2ZvcUJh?=
 =?utf-8?B?dHdOTlZpYzFJSHZZMHNDU21WTWkrN1k5TzRETkZVaXFiQU05SXhnaXFTU1A1?=
 =?utf-8?B?Q05INWN3NllUQzhTYVJyaUxPbDRidi9GK2YzQk9oWlA4V3JyalZFU1BvcDYy?=
 =?utf-8?B?cERzYUd6eGxBVGE2VkI4YnB1RDFLZ0JPeks4RTJER2syWExLL1M0dGU2U1VX?=
 =?utf-8?B?ZWlNQWZUTVFHTkJQcWpNRGdKYkI2cUhDalM3bTczNDNDbHN1V3BOam01RDNJ?=
 =?utf-8?B?SnlFbUtDRnR1bmttVmYxaUt2dGI0eHZUMkNNS0ZHTjdmRXFTRmIwOEtSU0lC?=
 =?utf-8?B?bktpVldpTnlxNWNCVG5lTm0wdWsxTFNFUUcwWXQwN20xRWtaUGZSczhSV1RS?=
 =?utf-8?B?NC9DUm9Ndk9nVEgyTVArYnBrOTcxOUx2emZRQkUxZ2ZZNmRiNXVuTHlwOTJm?=
 =?utf-8?B?K1l4S25sRm9HTFRNV0UzUmExR3hYd0VuZjYrTE1XUGhUZis1eXJKZm80OFRp?=
 =?utf-8?Q?l/BY=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d12529a-91db-47cd-58d2-08d9e23d8ce9
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2022 09:07:03.8527 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5OFm85qan40AaO7XDIPC436SgBl1gBTSblXK88iNCIamHun47Xw1bbsdYgezwcRZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5043
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>,
 Christian Koenig <christian.koenig@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 1/28/2022 2:22 PM, Lang Yu wrote:
> On 01/28/ , Lazar, Lijo wrote:
>>
>>
>> On 1/28/2022 12:24 PM, Lang Yu wrote:
>>> We observed a GPU hang when querying GMC CG state(i.e.,
>>> cat amdgpu_pm_info) on cyan skillfish. Acctually, cyan
>>> skillfish doesn't support any CG features.
>>>
>>> Only allow ASICs which support GMC CG features accessing
>>> related registers. As some ASICs support GMC CG but cg_flags
>>> are not set. Use GC IP version instead of cg_flags to
>>> determine whether GMC CG is supported or not.
>>>
>>> v2:
>>>    - Use a function to encapsulate more functionality.(Christian)
>>>    - Use IP verion to determine whether CG is supported or not.(Lijo)
>>>
>>> Signed-off-by: Lang Yu <Lang.Yu@amd.com>
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 10 ++++++++++
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h |  1 +
>>>    drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c  |  3 +++
>>>    drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c   |  3 +++
>>>    drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   |  3 +++
>>>    5 files changed, 20 insertions(+)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>>> index d426de48d299..be1f03b02af6 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
>>> @@ -876,3 +876,13 @@ int amdgpu_gmc_vram_checking(struct amdgpu_device *adev)
>>>    	return 0;
>>>    }
>>> +
>>> +bool amdgpu_gmc_cg_enabled(struct amdgpu_device *adev)
>>> +{
>>> +	switch (adev->ip_versions[GC_HWIP][0]) {
>>> +	case IP_VERSION(10, 1, 3):
>>> +		return false;
>>> +	default:
>>> +		return true;
>>> +	}
>>> +}
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
>>> index 93505bb0a36c..b916e73c7de1 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
>>> @@ -338,4 +338,5 @@ uint64_t amdgpu_gmc_vram_mc2pa(struct amdgpu_device *adev, uint64_t mc_addr);
>>>    uint64_t amdgpu_gmc_vram_pa(struct amdgpu_device *adev, struct amdgpu_bo *bo);
>>>    uint64_t amdgpu_gmc_vram_cpu_pa(struct amdgpu_device *adev, struct amdgpu_bo *bo);
>>>    int amdgpu_gmc_vram_checking(struct amdgpu_device *adev);
>>> +bool amdgpu_gmc_cg_enabled(struct amdgpu_device *adev);
>>>    #endif
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>>> index 73ab0eebe4e2..4e46f618d6c1 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
>>> @@ -1156,6 +1156,9 @@ static void gmc_v10_0_get_clockgating_state(void *handle, u32 *flags)
>>>    {
>>>    	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>> +	if (!amdgpu_gmc_cg_enabled(adev))
>>> +		return;
>>> +
>>
>> I think Christian suggested amdgpu_gmc_cg_enabled function assuming it's a
>> common logic for all ASICs based on flags. Now that assumption has changed.
>> Now the logic is a specific IP version doesn't enable CG which is known
>> beforehand. So we could maintain the check in the specific IP version block
>> itself (gmc 10 in this example). No need to call another common function
>> which checks IP version again.
> 
> Thanks. You mean just like this?
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> index 73ab0eebe4e2..bddaf2417344 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> @@ -1156,6 +1156,9 @@ static void gmc_v10_0_get_clockgating_state(void *handle, u32 *flags)
>   {
>          struct amdgpu_device *adev = (struct amdgpu_device *)handle;
> 
> +       if (adev->ip_versions[GC_HWIP][0] == IP_VERSION(10, 1, 3))
		*flags = 0;

Yes, add the above line also.

Thanks,
Lijo
> +               return;
> +
>          adev->mmhub.funcs->get_clockgating(adev, flags);
> 
>          if (adev->ip_versions[ATHUB_HWIP][0] >= IP_VERSION(2, 1, 0))
> 
> Regards,
> Lang
> 
>> Thanks,
>> Lijo
>>
>>>    	adev->mmhub.funcs->get_clockgating(adev, flags);
>>>    	if (adev->ip_versions[ATHUB_HWIP][0] >= IP_VERSION(2, 1, 0))
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
>>> index ca9841d5669f..ff9dff2a6cf1 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
>>> @@ -1695,6 +1695,9 @@ static void gmc_v8_0_get_clockgating_state(void *handle, u32 *flags)
>>>    	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>>    	int data;
>>> +	if (!amdgpu_gmc_cg_enabled(adev))
>>> +		return;
>>> +
>>>    	if (amdgpu_sriov_vf(adev))
>>>    		*flags = 0;
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>>> index 4595027a8c63..faf017609dfe 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
>>> @@ -1952,6 +1952,9 @@ static void gmc_v9_0_get_clockgating_state(void *handle, u32 *flags)
>>>    {
>>>    	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
>>> +	if (!amdgpu_gmc_cg_enabled(adev))
>>> +		return;
>>> +
>>>    	adev->mmhub.funcs->get_clockgating(adev, flags);
>>>    	athub_v1_0_get_clockgating(adev, flags);
>>>
