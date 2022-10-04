Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22435C433F5
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Oct 2022 20:06:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D58510E0CF;
	Tue,  4 Oct 2022 20:06:12 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2076.outbound.protection.outlook.com [40.107.244.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50A5810E0DB
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Oct 2022 20:06:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O02Hu35waq668JC9djg0M9HT8bA9YN7I4849esFvOhA3Fsp8/h7No59nAxpUVvbnIL6z1rhjV1F6V4xWqS4XGJsD201uI25GslRJNGwG9Q5fBUiFpwLQu7JgKIj6SG012aPh+xV3Tb+gJ4RE5A1y8em/yFI0gv9HxB/pTOUCIgIDbra2vAwm3SUHzLu6HO8ubapoxmXVMjrlsoJJIc7P+LeZQfTjtl6ta2HfO5P0Z8K23V0jJ/yyIp2+UtxhC6JR6gJCLR/Nhe0WBEdSymtL7Ud3Y58+gxlIPNRcR5Ark+RQeDofyyuL1YvBXfsC8U6F/Af8dK7+loPGh1fCSN8QrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FIZEYrHBfnDa9Yc2jVx9HNPGywKdcmXfsI8iKp5pmpI=;
 b=RFUGhLcmRiBjgPXaAYTwrepxdKMTtEnAdcRyvwNgNLf744t/G9ac7ojvG7dEw2mIkHHVWKjEftVHsLCTbKC26/uxgfLnz+K/kHxF8Z6rF6Pjzg34nzCZP1uwGMwbmGgk0xWBLizxgYZBLsirAeTmnYylNcHLsUyANj26sb32MFDxqmICOR4lNpTGUxGkd1/DDiywXj/7bi0Qi+vAt8BlrAi0hcTIPUwiNPTHjfGVLzFRy60WtfjPuzNr54yCWs8BdcsfFrsLPkMyhYPem+lpXFlZ2+tN+XYpuHy+3L3Eoq+ysKowhiPeZjGS9mjr3BWH8/frdiXTCBnyRUX2Hh5ZWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FIZEYrHBfnDa9Yc2jVx9HNPGywKdcmXfsI8iKp5pmpI=;
 b=ZJerNF82UjQf8ZnVC2dT7By/yCQfG2WDFLj8nP91GLSn2/Ori8/VQMfQx0s+vN+ntp0DwRTJkwS47qB3IFPVwlO5BDza9PmY1PDYKE0AjDmK7eCxw+ulNJIoUhJIiTVBlRGSnj9xTsbMV5gwH7oEm8E9YDXCf66k7DWH2pZl1EI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by MW4PR12MB7285.namprd12.prod.outlook.com (2603:10b6:303:22e::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.24; Tue, 4 Oct
 2022 20:06:07 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::3de4:456f:800d:e013]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::3de4:456f:800d:e013%5]) with mapi id 15.20.5676.031; Tue, 4 Oct 2022
 20:06:07 +0000
Message-ID: <8b0c4c9d-81ca-8dbd-b56c-a30181ac2b57@amd.com>
Date: Tue, 4 Oct 2022 16:06:05 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/1] drm/amdgpu: Correct amdgpu_amdkfd_total_mem_size
 calculation
Content-Language: en-US
To: Philip Yang <yangp@amd.com>, Philip Yang <Philip.Yang@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20221004164154.9021-1-Philip.Yang@amd.com>
 <7bb97897-48be-4cc4-3802-201a16617b2b@amd.com>
 <e3354f27-f285-18dd-0352-c182128db88f@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <e3354f27-f285-18dd-0352-c182128db88f@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0P221CA0029.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:11d::7) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|MW4PR12MB7285:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ac58055-c007-42aa-f6c2-08daa643dfa7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6jyOTOgSpdgd6+Kys+88IXr+5yHNJtrjwAMq+n8IP/xtlb+1gDlprBM95rUAyxapkGtbelFuAZ3ukoesEzncNM6ErAlGM29/Tj0iwZVkOKU6AhNeiU40sBPCFGq0ZGxma5O4HaJA01r3cFbTxI+U2sEIXNuIfnCkmpjyIDpyieBVy1Q/PRJe82thPtYizV/te4Ud9jS/Oq1WxEcWXXlcAY9QSl6EZnGfQR0Yl1kEhGLXLtdUpShTrUrzmoYTEot87trO/Syk3E71fzFJrDslJnOlXiNfe9Ec+JPNrW+Ydb4UqVUtX4scCWrl5bqnL0Fc/ukPnT97dLyHKHG5VEmmmFwP9YKjzD535Fx4mTxuFzqErr92y/NWCDnIKFqYSNeitPlpJC00lHGuc3SlUtBmHq1wA2OUhZ+FccMZ613fIF6hS42oaqIdXaQ7Tz0m1SPRGO0kt0cCJaAXCWLNbpSr3iTjscmk/6wX07ypr2INvw1Iptx7D3HBIP11fgK+HF9wDrRb39Wrr8aYaeFcog6CXO4t34T6dlwFU755KnZeB+h/JyFZPks1Cio+6yXIhi7E413ixiRk5WqnH5f8pfsBlQg7prVYRz9yPYFe0Ni6ERzSr+LlqN97qaRuGYL0cDMFcZ2M6KvK3a1e7+KdrxXKckrdDzM4fjStQP3znmf+8Op/OAvsxXlN1eHWc4Wtk6yZJeU/B4zqVQf0gqbMxxB82G+hPfyxHlegVz9XGtw4yLaIkD4IpoFALzR2GN/59XV+ALg62q8gK9rTipdDaYyjTX0+1gE0cqAiz1dq7qvh37A=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(39860400002)(376002)(346002)(396003)(366004)(451199015)(31686004)(2616005)(186003)(6506007)(86362001)(31696002)(6512007)(53546011)(8676002)(36916002)(5660300002)(26005)(41300700001)(36756003)(38100700002)(83380400001)(6486002)(110136005)(316002)(44832011)(8936002)(2906002)(478600001)(66556008)(66476007)(66946007)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N21Mc1RrY2w4cEV1ZnJYZ0F1N2cyUWR5U1BCRisza3hWMkdibGlsQS8wWlk5?=
 =?utf-8?B?dWM5SUQ5WEt5dm1JN0phbjBiUmR2VzhIZEJqNjZ2QUQzNWUweU9mRDRZaEVN?=
 =?utf-8?B?bXBRTm1kVzJYbE9xK25yamZyOG1IT3dZUjlMa1M5SlJZTmhCRE91TDMrb3JJ?=
 =?utf-8?B?YzNEenJnYnlUcXdtZTY1eTJMTWRBL1JmM0N6OU1Td0JtaHNXaEdXcWlDM2tu?=
 =?utf-8?B?aHZQbWFYU2xVNVp2SExiYjNuOHRiRllpNmRucWpIVnVqb3RTQXhQNGN1bWsy?=
 =?utf-8?B?eHhxem9OVFpFZ0tKcFUwSkg3Mm5jM01LUlBVY3c4cWpyQ0dHV0FkdGZMZU9O?=
 =?utf-8?B?am5QOFphdGdTaTY2RGlkLzlQRXVkNmtBYS94OXZxZlBoNk9QeUV0YTZVS2Fv?=
 =?utf-8?B?SHdsaU5lbGZhNm1pdFZMWHlQcDJSV3F5K0lXcHFMMjFpL0VUMzl0QmhiNElN?=
 =?utf-8?B?MDk3NjBqK1o2YjR0MHEwb2x3RmxYMW5JY1dVbnc2V0pVSVNPd0ltZFQxaFI2?=
 =?utf-8?B?WTlkdVBlNHBBazdqVzJWMWo5UDB3ZDc4bUFVOXlxd1FleWtVUUxyblJaT0ls?=
 =?utf-8?B?NCtUL2N0djI1SFdjdDRXVlRsbzh5TWVCVndqSnNTSEcwVkxNdWc0SGZFMVZY?=
 =?utf-8?B?blViQ3lvZzI2MWxJallyMnVZR1Z5cjM5M3Jwa1A1RkVFclZROGZmY1J0Zkxz?=
 =?utf-8?B?Y1lWKzhaWDRRcWV1Lys4YnFRUm9jTy9yOGtYNHhIN3RiZHRGbXRkQTlsL295?=
 =?utf-8?B?VU1aQmtrc2wvSEVaM1FROVBLWm50MzlBLzRhdzhCNE1ITmR4ZTZEdjBTVVNJ?=
 =?utf-8?B?KzRkQ1ExdEhQenhkQXAxMWo0SjF5MG5CbWNicktFamVJVUlPRncrcm9NT2Rv?=
 =?utf-8?B?b0pFOFVYUmRzMFNRU2FmamNZcjA5dzJKcG1zS0ZGd0Z4T20wNWd5c2FxT1FG?=
 =?utf-8?B?c2JtdGV1U0M0Y2lyNUFSYVpIN3g2QkdLQmd4b0pYZHVhaGZQVVh0ZVJqd3Fi?=
 =?utf-8?B?VWdtQTFlVkhheS9IWEhGSFNvcHRMVnB1Y1N3b0F1WU1sV2hLSFJNY012eGFn?=
 =?utf-8?B?REVSLzgzYmdUYmExZENCZm5CN0pSczgvcHd3cnh4YzJhTnZON3k3TGZCRU1O?=
 =?utf-8?B?SG5reG51SWc3MkNlZmxpaW1iNDh0c3ozSHJuVWJGZExCWEMrcU9zbjFuNHVw?=
 =?utf-8?B?eXp6dThCSXg0bHpJVGJ3NE53WFAwSHJhNWdVRnlEYURpQi9hdmhUbzFZNUVF?=
 =?utf-8?B?cS9SMllLakdSSmdvNjUvdG1PamdUdlBsaDNxOWJ4Ti92MjRQUGl6dURpeFVS?=
 =?utf-8?B?b080bU9pd2l3SDdwNGNzQ3ZSWm5rQzhiK1lweEZCQSsxNFBURG05TGg2Y0U3?=
 =?utf-8?B?aE5DT1dlK0I5WlpHdVdROUFUZmV6UnMwVVE0aEFRZUJFQjJ2WmdIUVBDQ2U4?=
 =?utf-8?B?dTRGeDFReDRtbG9tSkJxdzYwZHBTaUlUejFGQWpUUmkvV1I1Y3Q5QXdZZjB3?=
 =?utf-8?B?OHlubEdWVVNxUk1hcEkwSFpLcVhMMHRHeHBpbjBRbE93U0ZDTC9CVzV1T1Jl?=
 =?utf-8?B?bHowRDErRXYvQlF2R2pYK25qUTNtWEg5YjJnYTdNRzNVWk1ZcVFCMjRpVUEx?=
 =?utf-8?B?ZGlFc2d6YUVFMld0Tml4OGFFSUg2aUQwV2YxeFg1RkFqUDRKeWszb2RuN3h6?=
 =?utf-8?B?RDcwSERNV2ZHVDhPSnIycDFjRk90UHNLSW1IK1pZM0dhZlE2TUt3a1E2MFpC?=
 =?utf-8?B?eUNkNm5CbWw1bmFjTmRUQ3FhZFVQMFBqbUxGcHZGeTJueEgwRTNJUDVYSlkr?=
 =?utf-8?B?RTdBTzd5TVFjZ2p6K1hxSFFMWVBCL1hod3RtTzZjRVl2K2UxUE5SMDdIYk9h?=
 =?utf-8?B?cG84UkNZTTB5TzVUaVJpeVhFb0JHVFprcCt4UDZoTi9MTGdLR2tpT0xadjJZ?=
 =?utf-8?B?SVpveDR5R1F0S2lPa2FOcE1zZFJFWCtCZTVQa2JHT09aU1g2a2NscjFyVXVx?=
 =?utf-8?B?eVc5YXNJRzBGMVFWdVAvd3cxTVFXSTlwbmRTdjYwYi9iWFdUeXZIZHFBTEtw?=
 =?utf-8?B?anlrdzhKUGRVQmRqNS9RdTlQZDY1b1Bta2hyNEIrVTJ3bkJjRGpDRHNyaGI3?=
 =?utf-8?Q?1osMaS3VVxcorrRKkOl+6y39l?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ac58055-c007-42aa-f6c2-08daa643dfa7
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2022 20:06:07.3109 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ImULoP1Es1uIWR6lvHMMH0bt5Q7/T9Dcpcksh/zrxj5iFWBER5KoU5ouO5YMXhQC72bzCOFzWkfF+mS2Uv69ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7285
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

I'd prefer a separate patch and code review for the fini-case, because 
that addresses a different (potential) problem.

Thanks,
   Felix


On 2022-10-04 15:43, Philip Yang wrote:
>
> On 2022-10-04 15:16, Felix Kuehling wrote:
>> On 2022-10-04 12:41, Philip Yang wrote:
>>> amdkfd_total_mem_size is the size of total GPUs vram plus system memory
>>> to estimate page tables memory usage and leave enough VRAM room for 
>>> page
>>> tables allocation.
>>>
>>> Calculate amdkfd_total_mem_size in amdgpu_amdkfd_device_probe is
>>> incorrect because adev->gmc.real_vram_size is still 0 called from
>>> amdgpu_device_ip_early_init. Move the calculation
>>> to amdgpu_amdkfd_device_init to get the correct VRAM size.
>>>
>>> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
>>
>> Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
>>
>> Semi-related to this, there should probably be a reverse calculation 
>> in amdgpu_amdkfd_device_fini_sw to support hot-unplugging GPUs.
>
> I will add the reverse calculation then submit.
>
> Regards,
>
> Philip
>
>>
>> Regards,
>>   Felix
>>
>>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 5 ++---
>>>   1 file changed, 2 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>> index 9e98f3866edc..049d192c7cdf 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
>>> @@ -75,9 +75,6 @@ void amdgpu_amdkfd_device_probe(struct 
>>> amdgpu_device *adev)
>>>           return;
>>>         adev->kfd.dev = kgd2kfd_probe(adev, vf);
>>> -
>>> -    if (adev->kfd.dev)
>>> -        amdgpu_amdkfd_total_mem_size += adev->gmc.real_vram_size;
>>>   }
>>>     /**
>>> @@ -201,6 +198,8 @@ void amdgpu_amdkfd_device_init(struct 
>>> amdgpu_device *adev)
>>>           adev->kfd.init_complete = kgd2kfd_device_init(adev->kfd.dev,
>>>                           adev_to_drm(adev), &gpu_resources);
>>>   +        amdgpu_amdkfd_total_mem_size += adev->gmc.real_vram_size;
>>> +
>>>           INIT_WORK(&adev->kfd.reset_work, amdgpu_amdkfd_reset_work);
>>>       }
>>>   }
