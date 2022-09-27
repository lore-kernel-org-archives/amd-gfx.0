Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32130C54EE9
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Sep 2022 14:20:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 111D010E36A;
	Tue, 27 Sep 2022 14:20:47 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2078.outbound.protection.outlook.com [40.107.223.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D0A510E36A
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Sep 2022 14:20:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O8Zwvt7VnMgiRrdpuIGzD+P5XeORmQ4BpCBLVgrTL9r5DXq/CEx0pItIKEhkufXRxeKYVn6LbkEOwJ3puqoipXyaIqboRNYdsyFZln7xHEir66whVqnpOPXStd9qAE2LPRWlaCw5bD92yLud61zxEOT4JPBYaC7MEF+/kSMty6WugIDPbqMJArgyAtRV5DNNwMIh92CqtotUdITj56sfT98T/Jw1lrNaCw/0FqiZf4HnvKEoxhyXorNiy8JAezrK1tiyq1wqe+4L+mmZkKz9crWgMHi5vxY/TpGsZpfVNOpZUVty7RYuC50gle967vONBKlM1a3Y+8SUU6esmWzInQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zs0Hdw7RlN7UMfowPzOFjYQ1oWumBxxFQXbz1HHqoZQ=;
 b=EUjW4wgZ0ZSKPoAeCAjzSx5yn9h8jRylWKWGqq+0d4V1pRGxZ4cpwd3MWn4UoCcg5NpA99cOjmA/zrw9afguTgvKD3xZm8hdZwDKarNUXrGFBNEyRWn81ObG+IUm4FcnPy1vkgcQvJbcjrd1e6rWO7eUvE/qyl8eVj0rnQ3zujEGUrAcOhX101Ze3I5+BJANr8KTNYbAsjZ6Wvur3WwcOZ0lm9Hi/bF2TPmTcaLPdbb9LR9F3cEQbof5QziMVR+X3DHTKNDXKUV/jhjx8iAVsqQqUf2H9e16i7EPtQWNpJAS9Wzl5FApb173qOGJbSJGs6QV8PL6m9mQi+lyFwXayQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zs0Hdw7RlN7UMfowPzOFjYQ1oWumBxxFQXbz1HHqoZQ=;
 b=WKm2g1SPWGaPPr1jx/MSfYL5kwY8lYGRoVAqoVmlITaHm5k8ycyZg6Wdj0xL59qAn7eTA0FaDU+DV/egAOIhvOl20rXrSXe/ucx4faLgoy4pgACZlE5+gqiNBunJDNpPKOEshJB3ribsQrLigl9xD89bOiO9ElOcwzZMUt/tTFs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB5673.namprd12.prod.outlook.com (2603:10b6:a03:42b::13)
 by SA1PR12MB7037.namprd12.prod.outlook.com (2603:10b6:806:24c::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.15; Tue, 27 Sep
 2022 14:20:38 +0000
Received: from SJ0PR12MB5673.namprd12.prod.outlook.com
 ([fe80::f508:b24b:35fb:178f]) by SJ0PR12MB5673.namprd12.prod.outlook.com
 ([fe80::f508:b24b:35fb:178f%4]) with mapi id 15.20.5654.024; Tue, 27 Sep 2022
 14:20:38 +0000
Message-ID: <38334f83-a4ad-2a53-543a-302d174950ae@amd.com>
Date: Tue, 27 Sep 2022 16:20:31 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 2/5] drm/amdgpu: add new functions to set GPU power
 profile
Content-Language: en-US
To: "Lazar, Lijo" <lijo.lazar@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220926214014.5450-1-shashank.sharma@amd.com>
 <20220926214014.5450-3-shashank.sharma@amd.com>
 <29782362-ca83-9174-c289-1ef973b8e736@amd.com>
 <ff4e61f2-f361-83c2-0bf4-443989e01ada@amd.com>
 <f8d1a1dc-056c-bfe0-2f61-cc9c0702e37b@amd.com>
 <6a90712b-d6bb-d1b8-e1b9-8e714be85094@amd.com>
 <0aced831-643a-f3db-eb71-6129d9ff008d@amd.com>
 <35e717d4-513a-7b61-9e22-6c853dc8afa2@amd.com>
 <7fc9db1b-9ff3-6102-d632-216976d1f595@amd.com>
 <6dbc17c2-729b-e3de-1b94-4b800354e816@amd.com>
 <76175d88-be18-3ac7-536c-96ee527c5f95@amd.com>
From: "Sharma, Shashank" <shashank.sharma@amd.com>
In-Reply-To: <76175d88-be18-3ac7-536c-96ee527c5f95@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0081.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::11) To SJ0PR12MB5673.namprd12.prod.outlook.com
 (2603:10b6:a03:42b::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5673:EE_|SA1PR12MB7037:EE_
X-MS-Office365-Filtering-Correlation-Id: ec7e5c10-7c1a-45d8-1b20-08daa0937328
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6LOxzzGxQGznJ0cI8fDCizUu2TFjrPxd0FKNne5qDHxoKg3wmZpwALs2+dhijB0YLZdIqQSKDDJ7TbyzPMmrvGbRz/vspDdiWzX4Bl858k5L6pVESKgn6bJehnnxz6Wd0gWmJC5OBbQGSoof5KNCfs1shU7MOD3NRAF6gGm6z3yGVHRPnLlG5NvOHqD24Fm095TSUrFdP2ang2A9hDXSU6QLetwjrqRIroQxwYj7jCso300n497xugvryjoe3ij2mXLT2/J+S7e5mq4aJaY67ZBKbZMEZW8Kv9WGvXv/Q69IH6SJmv2a0/DjHLOAT2F/CGSvdubWpXk3BqLIuk/fOFBIijcFr/xYIRTQufB4pOXwYFTUZp55Ex9v+R+2uczq3FlZje6Hfz4Y/9J706OgHxohoLR8usQ8oTnkZm9OaUXcLS4u9sP2lNmUPHW8DNTgCGHuzh5KNyICc9EViAc7/IZnfJ5FVcCP4P2SV8/9DmKbpVOXi3MirwcrN5kE5Ht0mXUWHIbCdqAVCchd9Jz4TcGKeFQ9SfcW1Vd771ezaeVjYSUsfedp7zSaBdSmsAghLAlZgHjBbCn1hMWF9WEEsYejJkNhCDaXCAoqQhnRi9zRxcaPTKu6Er/HPonsDPcx7X2vp8zFBpTNLP8/dwp6b1MZojL5K18t0IjXXGQVOHTm3pQAkuMmUWWh+nLoFrPtGCpsIGjehvnIHXe3OMVxCgTZhaWPGTntZ55ExD2kz0et61Ab9R38BTsEevVhZAS9HsENjIrUJrICM7fOz1BHNFotmN53ug0nkPxP5XBCINk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB5673.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(396003)(366004)(39860400002)(136003)(376002)(451199015)(30864003)(66899015)(6486002)(478600001)(6666004)(5660300002)(2616005)(31696002)(6512007)(8936002)(26005)(86362001)(316002)(53546011)(36756003)(6506007)(186003)(66946007)(66476007)(4326008)(38100700002)(66556008)(31686004)(41300700001)(2906002)(8676002)(83380400001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WGZaQzIyZzhSQTlReFVTdmpiQVIwY1c2Z0NwNlFKUWltNGYvWVprSHdNdW1E?=
 =?utf-8?B?a1pqbDhxaFd5U3lNbUU1cnU1aVoyNDVwTlNxbGIzM0QxcnZTcnV3NHB4Rkty?=
 =?utf-8?B?RnQ4Uit1aUw1dDd4U3laZ0JpQkRzd0VrVGpzSFFkbHZ3dkNGRkRwYll5dFA4?=
 =?utf-8?B?bStva3lnM1JuTVhuanhmZ0kwUFpGVVpGejFrOTVyS2FWTjc0QWdacXYvZHBR?=
 =?utf-8?B?M2ZlQ1BpRWJUeTR0YWthQjhFNmR4RzFJWFh4K2twNUlza0JpWTBSSVRZRVl2?=
 =?utf-8?B?RG5CWlhobEF2WHJ4c3FtaElzZGV4TFZXSndwYVYrWlFKVFRnc3hVZ2FSK20v?=
 =?utf-8?B?WC93TUZTaGltSm5BV0FhaFE3ZlFBa0lUVnNIV3JmLzhUWUYyZHpVUlI1VFkw?=
 =?utf-8?B?U0tBbWV6MGFKWnZHTkxwS3FXcEhQaXRXR2tEcTdneEV2dHlUcXNVVVl1NWxJ?=
 =?utf-8?B?bXcwSG9wZ2pVdlZGdUhEa1pJVVFtZmlqOGtXajBtV0FlUFVCM1R5djlOempy?=
 =?utf-8?B?TDFPK0RZR0lRNVpWbUo2bHAwNStYOEVXOENjM1RnWGc3cnFOUFppeWtGdE5v?=
 =?utf-8?B?ZWc1MHY2Wlo1K1J3TmxwcWJnWFBub1k5RlNHRGZrcWd6S3k4T3A1TEM0VDVn?=
 =?utf-8?B?amRhcU5sc0VmY0JjYzVqL2k3RExHSEhYZ0xObUorMk1YTlFDa3pXL2FMY2xL?=
 =?utf-8?B?dmhrblRIRVdvTS9icXF1aWhzNHR2VVZSL1NaSlhjTXBjdU93YjNORDlzUXRO?=
 =?utf-8?B?YnhoMHUvRS9QeDVnbjExMHN6YzNJWjZYRVVvejlFM1kzYkY2MnBwaU1paFIw?=
 =?utf-8?B?c0wxbHRJbXpCQ3dxSjdieGgvT2FvMWE5NUJSOTRWVFpmb2lpc0RsWVVDMUsx?=
 =?utf-8?B?NTRCeWh3eWdjc0ZhYTZHTUUxV3NGdGZWVmE3bGt4R25tRlU0V0RGSnNVYTVL?=
 =?utf-8?B?QTR2L3NEdUZiYzdBNzZBbGJKbmR3bU1ieE90MThSSTZYcHB3cDRQQTg5Uk5S?=
 =?utf-8?B?WHdXeGgyWUgrRzJmL2hHTkFLSzlGZ0VabFh1L0NRdElpV25oSllGcDRrQmRw?=
 =?utf-8?B?TnFJMUVESlo4MHRqRnNVajdRcnNscVhrSENJQTV3U3lCRlcrcm5CV2VJaTZv?=
 =?utf-8?B?eE1HMHFPMEIyWnB1RHdRSzN3eCtTMXJyWWdDVzArbkNKQlJiL2VjZnZPdjdU?=
 =?utf-8?B?TGpzNGJjakhJRUpJSm1vQmxMWW93bzlGS01iZGVqUVNrK1d3bEx3c0Z1c3hP?=
 =?utf-8?B?VHlUcEFnS0pVemd4akRSTDFlQVZnRDUydHpUbFN5S2RkblRzK1g2L2lTcGdG?=
 =?utf-8?B?OVBRblptaW8zcXJrRlpES1hDQVdrT0hvekFOQlk3MUdJNXJ6UHp4Z2tEREc4?=
 =?utf-8?B?djdHbmlJdXovWG5GSmtQOUVPWmtzdXRTL1IwUGwxWGRRTkVIT2d2bWhkQjRq?=
 =?utf-8?B?YitacDR2Rk9tZGhRMm8rQXNrVmJNVFpzeCtUdXFiK1ozWG44UjdJcURDZUoy?=
 =?utf-8?B?TWJDMTlGbEpqU3ZQeFgzM1o4RkUvMFl5L3FqWHF6K2xScThlV1U4cWdFd05m?=
 =?utf-8?B?dmdqa25DRGhMaW9WK29aV1lLV1NEQTlPaFpJM29OS1NVY05QblBINGI5aXRj?=
 =?utf-8?B?aERZazRndTlic25zMDFWVzA4NnV5dEV1K2RscTBKVUNJWEphQnhycFRKSmt2?=
 =?utf-8?B?UUhZMW1VTjR4NjFsdUVTdnZIeUl3WkhpN0JSbTFvOTcrR1J1c3ZaREEvT1ow?=
 =?utf-8?B?c01wcGJXSGdTRTBWWndFMGt2MXo5TXNnSGJmU1I1RHBZQ2ZpeW5IUitKL2Vx?=
 =?utf-8?B?alZWbVdCNmlKdVlER3NIaE1TM1grMnZxWFYzWGpINlU3WitCRXJWTmtTTFFL?=
 =?utf-8?B?QmdyNGwvL2JML0FCTmNFZmJ4VVpFekk2OEFJZGxLR3ZyRjcvcE8vVHRTb2sv?=
 =?utf-8?B?anBUZUtEd0ZzMXIzZ29xL05DOExvYk5NUjJ6REhnaW9ZNEN1SEpyWXhPNCs5?=
 =?utf-8?B?c1VoWEd6cUtvQURJTnJlOVlMWC8yc0F4ZSsrb0hsR0tCMDUxSlFjNjBXSFIy?=
 =?utf-8?B?SnNncjhLemNUdlFzOFAyaDMzTnZadWNaNUgrVWZnR28vVm9wc0hCTExUN25w?=
 =?utf-8?Q?J6vl08SfsCoftHsjxAt62Sc7F?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec7e5c10-7c1a-45d8-1b20-08daa0937328
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5673.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2022 14:20:38.1803 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s5n62+7+nrihF/7nG/UykT5/J7q8Hn1prI8FpN6Ev2MQnkmmynR1O9vKe2xHAZcZ+aB3jrJz//qSe3Ve5F96ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7037
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
Cc: alexander.deucher@amd.com, amaranath.somalapuram@amd.com,
 christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 9/27/2022 4:00 PM, Lazar, Lijo wrote:
> 
> 
> On 9/27/2022 7:17 PM, Sharma, Shashank wrote:
>>
>>
>> On 9/27/2022 3:29 PM, Lazar, Lijo wrote:
>>>
>>>
>>> On 9/27/2022 6:23 PM, Sharma, Shashank wrote:
>>>>
>>>>
>>>> On 9/27/2022 2:39 PM, Lazar, Lijo wrote:
>>>>>
>>>>>
>>>>> On 9/27/2022 5:53 PM, Sharma, Shashank wrote:
>>>>>>
>>>>>>
>>>>>> On 9/27/2022 2:10 PM, Lazar, Lijo wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 9/27/2022 5:11 PM, Sharma, Shashank wrote:
>>>>>>>>
>>>>>>>>
>>>>>>>> On 9/27/2022 11:58 AM, Lazar, Lijo wrote:
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> On 9/27/2022 3:10 AM, Shashank Sharma wrote:
>>>>>>>>>> This patch adds new functions which will allow a user to
>>>>>>>>>> change the GPU power profile based a GPU workload hint
>>>>>>>>>> flag.
>>>>>>>>>>
>>>>>>>>>> Cc: Alex Deucher <alexander.deucher@amd.com>
>>>>>>>>>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>>>>>>>>>> ---
>>>>>>>>>>   drivers/gpu/drm/amd/amdgpu/Makefile           |  2 +-
>>>>>>>>>>   .../gpu/drm/amd/amdgpu/amdgpu_ctx_workload.c  | 97 
>>>>>>>>>> +++++++++++++++++++
>>>>>>>>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    |  1 +
>>>>>>>>>>   .../gpu/drm/amd/include/amdgpu_ctx_workload.h | 54 +++++++++++
>>>>>>>>>>   drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h       |  5 +
>>>>>>>>>>   5 files changed, 158 insertions(+), 1 deletion(-)
>>>>>>>>>>   create mode 100644 
>>>>>>>>>> drivers/gpu/drm/amd/amdgpu/amdgpu_ctx_workload.c
>>>>>>>>>>   create mode 100644 
>>>>>>>>>> drivers/gpu/drm/amd/include/amdgpu_ctx_workload.h
>>>>>>>>>>
>>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile 
>>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/Makefile
>>>>>>>>>> index 5a283d12f8e1..34679c657ecc 100644
>>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/Makefile
>>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/Makefile
>>>>>>>>>> @@ -50,7 +50,7 @@ amdgpu-y += amdgpu_device.o amdgpu_kms.o \
>>>>>>>>>>       atombios_dp.o amdgpu_afmt.o amdgpu_trace_points.o \
>>>>>>>>>>       atombios_encoders.o amdgpu_sa.o atombios_i2c.o \
>>>>>>>>>>       amdgpu_dma_buf.o amdgpu_vm.o amdgpu_vm_pt.o amdgpu_ib.o 
>>>>>>>>>> amdgpu_pll.o \
>>>>>>>>>> -    amdgpu_ucode.o amdgpu_bo_list.o amdgpu_ctx.o amdgpu_sync.o \
>>>>>>>>>> +    amdgpu_ucode.o amdgpu_bo_list.o amdgpu_ctx.o 
>>>>>>>>>> amdgpu_ctx_workload.o amdgpu_sync.o \
>>>>>>>>>>       amdgpu_gtt_mgr.o amdgpu_preempt_mgr.o amdgpu_vram_mgr.o 
>>>>>>>>>> amdgpu_virt.o \
>>>>>>>>>>       amdgpu_atomfirmware.o amdgpu_vf_error.o amdgpu_sched.o \
>>>>>>>>>>       amdgpu_debugfs.o amdgpu_ids.o amdgpu_gmc.o \
>>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx_workload.c 
>>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx_workload.c
>>>>>>>>>> new file mode 100644
>>>>>>>>>> index 000000000000..a11cf29bc388
>>>>>>>>>> --- /dev/null
>>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx_workload.c
>>>>>>>>>> @@ -0,0 +1,97 @@
>>>>>>>>>> +/*
>>>>>>>>>> + * Copyright 2022 Advanced Micro Devices, Inc.
>>>>>>>>>> + *
>>>>>>>>>> + * Permission is hereby granted, free of charge, to any 
>>>>>>>>>> person obtaining a
>>>>>>>>>> + * copy of this software and associated documentation files 
>>>>>>>>>> (the "Software"),
>>>>>>>>>> + * to deal in the Software without restriction, including 
>>>>>>>>>> without limitation
>>>>>>>>>> + * the rights to use, copy, modify, merge, publish, 
>>>>>>>>>> distribute, sublicense,
>>>>>>>>>> + * and/or sell copies of the Software, and to permit persons 
>>>>>>>>>> to whom the
>>>>>>>>>> + * Software is furnished to do so, subject to the following 
>>>>>>>>>> conditions:
>>>>>>>>>> + *
>>>>>>>>>> + * The above copyright notice and this permission notice 
>>>>>>>>>> shall be included in
>>>>>>>>>> + * all copies or substantial portions of the Software.
>>>>>>>>>> + *
>>>>>>>>>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY 
>>>>>>>>>> KIND, EXPRESS OR
>>>>>>>>>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF 
>>>>>>>>>> MERCHANTABILITY,
>>>>>>>>>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN 
>>>>>>>>>> NO EVENT SHALL
>>>>>>>>>> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY 
>>>>>>>>>> CLAIM, DAMAGES OR
>>>>>>>>>> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR 
>>>>>>>>>> OTHERWISE,
>>>>>>>>>> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR 
>>>>>>>>>> THE USE OR
>>>>>>>>>> + * OTHER DEALINGS IN THE SOFTWARE.
>>>>>>>>>> + *
>>>>>>>>>> + */
>>>>>>>>>> +#include <drm/drm.h>
>>>>>>>>>> +#include "kgd_pp_interface.h"
>>>>>>>>>> +#include "amdgpu_ctx_workload.h"
>>>>>>>>>> +
>>>>>>>>>> +static enum PP_SMC_POWER_PROFILE
>>>>>>>>>> +amdgpu_workload_to_power_profile(uint32_t hint)
>>>>>>>>>> +{
>>>>>>>>>> +    switch (hint) {
>>>>>>>>>> +    case AMDGPU_CTX_WORKLOAD_HINT_NONE:
>>>>>>>>>> +    default:
>>>>>>>>>> +        return PP_SMC_POWER_PROFILE_BOOTUP_DEFAULT;
>>>>>>>>>> +
>>>>>>>>>> +    case AMDGPU_CTX_WORKLOAD_HINT_3D:
>>>>>>>>>> +        return PP_SMC_POWER_PROFILE_FULLSCREEN3D;
>>>>>>>>>> +    case AMDGPU_CTX_WORKLOAD_HINT_VIDEO:
>>>>>>>>>> +        return PP_SMC_POWER_PROFILE_VIDEO;
>>>>>>>>>> +    case AMDGPU_CTX_WORKLOAD_HINT_VR:
>>>>>>>>>> +        return PP_SMC_POWER_PROFILE_VR;
>>>>>>>>>> +    case AMDGPU_CTX_WORKLOAD_HINT_COMPUTE:
>>>>>>>>>> +        return PP_SMC_POWER_PROFILE_COMPUTE;
>>>>>>>>>> +    }
>>>>>>>>>> +}
>>>>>>>>>> +
>>>>>>>>>> +int amdgpu_set_workload_profile(struct amdgpu_device *adev,
>>>>>>>>>> +                uint32_t hint)
>>>>>>>>>> +{
>>>>>>>>>> +    int ret = 0;
>>>>>>>>>> +    enum PP_SMC_POWER_PROFILE profile =
>>>>>>>>>> +            amdgpu_workload_to_power_profile(hint);
>>>>>>>>>> +
>>>>>>>>>> +    if (adev->pm.workload_mode == hint)
>>>>>>>>>> +        return 0;
>>>>>>>>>> +
>>>>>>>>>> +    mutex_lock(&adev->pm.smu_workload_lock);
>>>>>>>>>
>>>>>>>>> If it's all about pm subsystem variable accesses, this API 
>>>>>>>>> should rather be inside amd/pm subsystem. No need to expose the 
>>>>>>>>> variable outside pm subsytem. Also currently all amdgpu_dpm* 
>>>>>>>>> calls are protected under one mutex. Then this extra lock won't 
>>>>>>>>> be needed.
>>>>>>>>>
>>>>>>>>
>>>>>>>> This is tricky, this is not all about PM subsystem. Note that 
>>>>>>>> the job management and scheduling is handled into amdgpu_ctx, so 
>>>>>>>> the workload hint is set in context_management API. The API is 
>>>>>>>> consumed when the job is actually run from amdgpu_run() layer. 
>>>>>>>> So its a joint interface between context and PM.
>>>>>>>>
>>>>>>>
>>>>>>> If you take out amdgpu_workload_to_power_profile() line, 
>>>>>>> everything else looks to touch only pm variables/functions. 
>>>>>>
>>>>>> That's not a line, that function converts a AMGPU_CTX hint to PPM 
>>>>>> profile. And going by that logic, this whole code was kept in the 
>>>>>> amdgpu_ctx.c file as well, coz this code is consuming the PM API. 
>>>>>> So to avoid these conflicts and having a new file is a better idea.
>>>>>>
>>>>>> You could still keep a
>>>>>>> wrapper though. Also dpm_* functions are protected, so the extra 
>>>>>>> mutex can be avoided as well.
>>>>>>>
>>>>>> The lock also protects pm.workload_mode writes.
>>>>>>
>>>>>>>>>> +
>>>>>>>>>> +    if (adev->pm.workload_mode == hint)
>>>>>>>>>> +        goto unlock;
>>>>>>>>>> +
>>>>>>>>>> +    ret = amdgpu_dpm_switch_power_profile(adev, profile, 1);
>>>>>>>>>> +    if (!ret)
>>>>>>>>>> +        adev->pm.workload_mode = hint;
>>>>>>>>>> +    atomic_inc(&adev->pm.workload_switch_ref);
>>>>>>>>>
>>>>>>>>> Why is this reference kept? The swtiching happens inside a lock 
>>>>>>>>> and there is already a check not to switch if the hint matches 
>>>>>>>>> with current workload.
>>>>>>>>>
>>>>>>>>
>>>>>>>> This reference is kept so that we would not reset the PM mode to 
>>>>>>>> DEFAULT when some other context has switched the PP mode. If you 
>>>>>>>> see the 4th patch, the PM mode will be changed when the job in 
>>>>>>>> that context is run, and a pm_reset function will be scheduled 
>>>>>>>> when the job is done. But in between if another job from another 
>>>>>>>> context has changed the PM mode, the refrence count will prevent 
>>>>>>>> us from resetting the PM mode.
>>>>>>>>
>>>>>>>
>>>>>>> This helps only if multiple jobs request the same mode. If they 
>>>>>>> request different modes, then this is not helping much.
>>>>>>
>>>>>> No that's certainly not the case. It's a counter, whose aim is to 
>>>>>> allow a PP reset only when the counter is 0. Do note that the 
>>>>>> reset() happens only in the job_free_cb(), which gets schedule 
>>>>>> later. If this counter is not zero, which means another work has 
>>>>>> changed the profile in between, and we should not reset it.
>>>>>>
>>>>>>>
>>>>>>> It could be useful to profile some apps assuming it has exclusive 
>>>>>>> access.
>>>>>>>
>>>>>>> However, in general, the API is not reliable from a user point as 
>>>>>>> the mode requested can be overridden by some other job. Then a 
>>>>>>> better thing to do is to document that and avoid the extra stuff 
>>>>>>> around it.
>>>>>>>
>>>>>> As I mentioned before, like any PM feature, the benefits can be 
>>>>>> seen only while running consistant workloads for long time. I an 
>>>>>> still add a doc note in the UAPI page.
>>>>>>
>>>>>
>>>>>
>>>>> a) What is the goal of the API? Is it guaranteeing the job to run 
>>>>> under a workprofile mode or something else?
>>>>
>>>> No, it does not guarentee anything. If you see the cover letter, it 
>>>> just provides an interface to an app to submit workload under a 
>>>> power profile which can be more suitable for its workload type. As I 
>>>> mentioned, it could be very useful for many scenarios like 
>>>> fullscreen 3D / fullscreen MM scenarios. It could also allow a 
>>>> system-gfx-manager to shift load balance towards one type of 
>>>> workload. There are many applications, once the UAPI is in place.
>>>>
>>>>>
>>>>> b) If it's to guarantee work profile mode, does it really guarantee 
>>>>> that - the answer is NO when some other job is running. It may or 
>>>>> may not work is the answer.
>>>>>
>>>>> c) What is the difference between one job resetting the profile 
>>>>> mode to NONE vs another job change the mode to say VIDEO when the 
>>>>> original request is for COMPUTE? While that is the case, what is 
>>>>> the use of any sort of 'pseudo-protection' other than running some 
>>>>> code to do extra lock/unlock stuff.
>>>>>
>>>>
>>>> Your understanding of protection is wrong here. There is 
>>>> intentionally no protection for a job changing another job's set 
>>>> workload profile, coz in that was we will end up 
>>>> seriazling/bottlenecking workload submission until PM profile is 
>>>> ready to be changed, which takes away benefit of having multiple 
>>>> queues of parallel submission.
>>>>
>>>> The protection provided by the ref counter is to avoid the clearing 
>>>> of the profile (to NONE), while another workload is in execution. 
>>>> The difference between NONE and VIDEO is still that NONE is the 
>>>> default profile without any fine tuning, and VIDEO is still fine 
>>>> tuned for VIDEO type of workloads.
>>>>
>>>
>>> Protection 1 is - mutex_lock(&adev->pm.smu_workload_lock);
>>>
>>> The line that follows is amdgpu_dpm_switch_power_profile() - this one 
>>> will allow only single client use- two jobs won't be able to switch 
>>> at the same time. All *dpm* APIs are protected like that.
>>>
>>
>> this also protects the pm.workload_mode variable which is being set 
>> after the amdgpu_dpm_switch_power_profile call is successful here:
>> adev->pm.workload_mode = hint;
>>
>>> Protection 2 is - ref counter.
>>>
>>> It helps only in this kind of scenario when two jobs requested the 
>>> same mode successively -
>>>      Job 1 requested compute
>>>      Job 2 requested compute
>>>      Job 1 ends (doesnt't reset)
>>>
>>> Scenario - 2
>>>      Job 1 requested compute
>>>      Job 2 requested compute
>>>      Job 3 requested 3D
>>>      Job 1 ends (doesnt't reset, it continues in 3D)
>>>
>>> In this mixed scenario case, I would say NONE is much more optimized 
>>> as it's under FW control. Actually, it does much more fine tuning 
>>> because of its background data collection.
>>>
>>
>>
>> It helps in mixed scenarios as well, consider this scenario:
>> Job 1 requests: 3D
>> Job 2 requests: Media
> 
> Ok, let's take this as the example.
> 
> Protection case :
> 
> Job 1 requests: 3D => adev->pm.workload_mode = 3D; and protected by 
> mutex_lock(&adev->pm.smu_workload_lock)
> 
> Jobe 2 requests  => adev->pm.workload_mode = Media;
> 
> What is the use of this variable then? Two jobs can come at different 
> times and change it independently? Any use in keeping this?

> Some other job came in and changed to some other value. So, what is the 
> use of this lock finally?
> 
?? The locks are not to save the variable from being changed, but to 
save the variable being changed out of context. If two threads try to 
change it at the same time, one of them will have to wait until the 
other critical section is done execution.

Do note that this variable is changed only when 
amdgpu_dpm_switch_power_profile() call is successful. Going by the same 
logic, what is the use of having these pm locks inside the function 
dpm_switch_power_profile(), as Job 1 changed the power profile to 3D, 
and Job 2 changed it to media :) ? Using those locks does not prevent 
chaning the PM profile, it makes sure that it happens in a serialized way.

> Use case:
> 
> Job 1 requests: 3D
> Job 2 requests: Media
> 
> Job 1 now runs under Media. What is achieved considering the intent of 
> the API and extra CPU cycles run to protect nothing?
> 

This is how it is intended to work, I have explained this multiple times 
before that we do not want to block the change in PP from two different 
jobs. The lock is to protect concurrancy sequence, not change in mode:

without that lock in the worst case scenario:

Thread: 1
Job 1 requests: 3D
PM mode changed to: 3D
just before writing (adev->pm.workload_mode = 3d) this thread schedules out

Thread:2
Job 2 requests: Media
PM mode changed to: Media
adev->pm.workload_mode = media

Thread 1 schedules in:
adev->pm.workload_mode = 3d but PM mode media.

State machine broken here. So the lock is to provide sequential 
execution of the code.


If your suggestion is we should not let the mode get changed until one 
job is done execution, that's a different discussion and certainly not 
being reflected from what you wrote above.

- Shashank

> Thanks,
> Lijo
> 
>> Job 1 finishes, but job 2 is ongoing
>> Job 1 calls reset(), but checks the counter is non-zero and doesn't reset
>>
>> So the media workload continues in Media mode, not None.
>>
>> - Shashank
>>
>>>> In the end, *again* the actual benefit comes when consistant 
>>>> workload is submitted for a long time, like fullscreen 3D game 
>>>> playback, fullscreen Video movie playback, and so on.
>>>>
>>>
>>> "only under consistent", doesn't justify any software protection 
>>> logic. Again, if the workload is consistent most likely PMFW could be 
>>> managing it better.
>>>
>>> Thanks,
>>> Lijo
>>>
>>>> - Shashank
>>>>
>>>>> Thanks,
>>>>> Lijo
>>>>>
>>>>>> - Shashank
>>>>>>
>>>>>>> Thanks,
>>>>>>> Lijo
>>>>>>>
>>>>>>>> - Shashank
>>>>>>>>
>>>>>>>>> Thanks,
>>>>>>>>> Lijo
>>>>>>>>>
>>>>>>>>>> +
>>>>>>>>>> +unlock:
>>>>>>>>>> +    mutex_unlock(&adev->pm.smu_workload_lock);
>>>>>>>>>> +    return ret;
>>>>>>>>>> +}
>>>>>>>>>> +
>>>>>>>>>> +int amdgpu_clear_workload_profile(struct amdgpu_device *adev,
>>>>>>>>>> +                  uint32_t hint)
>>>>>>>>>> +{
>>>>>>>>>> +    int ret = 0;
>>>>>>>>>> +    enum PP_SMC_POWER_PROFILE profile =
>>>>>>>>>> +            amdgpu_workload_to_power_profile(hint);
>>>>>>>>>> +
>>>>>>>>>> +    if (hint == AMDGPU_CTX_WORKLOAD_HINT_NONE)
>>>>>>>>>> +        return 0;
>>>>>>>>>> +
>>>>>>>>>> +    /* Do not reset GPU power profile if another reset is 
>>>>>>>>>> coming */
>>>>>>>>>> +    if (atomic_dec_return(&adev->pm.workload_switch_ref) > 0)
>>>>>>>>>> +        return 0;
>>>>>>>>>> +
>>>>>>>>>> +    mutex_lock(&adev->pm.smu_workload_lock);
>>>>>>>>>> +
>>>>>>>>>> +    if (adev->pm.workload_mode != hint)
>>>>>>>>>> +        goto unlock;
>>>>>>>>>> +
>>>>>>>>>> +    ret = amdgpu_dpm_switch_power_profile(adev, profile, 0);
>>>>>>>>>> +    if (!ret)
>>>>>>>>>> +        adev->pm.workload_mode = AMDGPU_CTX_WORKLOAD_HINT_NONE;
>>>>>>>>>> +
>>>>>>>>>> +unlock:
>>>>>>>>>> +    mutex_unlock(&adev->pm.smu_workload_lock);
>>>>>>>>>> +    return ret;
>>>>>>>>>> +}
>>>>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
>>>>>>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>>>>> index be7aff2d4a57..1f0f64662c04 100644
>>>>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
>>>>>>>>>> @@ -3554,6 +3554,7 @@ int amdgpu_device_init(struct 
>>>>>>>>>> amdgpu_device *adev,
>>>>>>>>>>       mutex_init(&adev->psp.mutex);
>>>>>>>>>>       mutex_init(&adev->notifier_lock);
>>>>>>>>>>       mutex_init(&adev->pm.stable_pstate_ctx_lock);
>>>>>>>>>> +    mutex_init(&adev->pm.smu_workload_lock);
>>>>>>>>>>       mutex_init(&adev->benchmark_mutex);
>>>>>>>>>>       amdgpu_device_init_apu_flags(adev);
>>>>>>>>>> diff --git a/drivers/gpu/drm/amd/include/amdgpu_ctx_workload.h 
>>>>>>>>>> b/drivers/gpu/drm/amd/include/amdgpu_ctx_workload.h
>>>>>>>>>> new file mode 100644
>>>>>>>>>> index 000000000000..6060fc53c3b0
>>>>>>>>>> --- /dev/null
>>>>>>>>>> +++ b/drivers/gpu/drm/amd/include/amdgpu_ctx_workload.h
>>>>>>>>>> @@ -0,0 +1,54 @@
>>>>>>>>>> +/*
>>>>>>>>>> + * Copyright 2022 Advanced Micro Devices, Inc.
>>>>>>>>>> + *
>>>>>>>>>> + * Permission is hereby granted, free of charge, to any 
>>>>>>>>>> person obtaining a
>>>>>>>>>> + * copy of this software and associated documentation files 
>>>>>>>>>> (the "Software"),
>>>>>>>>>> + * to deal in the Software without restriction, including 
>>>>>>>>>> without limitation
>>>>>>>>>> + * the rights to use, copy, modify, merge, publish, 
>>>>>>>>>> distribute, sublicense,
>>>>>>>>>> + * and/or sell copies of the Software, and to permit persons 
>>>>>>>>>> to whom the
>>>>>>>>>> + * Software is furnished to do so, subject to the following 
>>>>>>>>>> conditions:
>>>>>>>>>> + *
>>>>>>>>>> + * The above copyright notice and this permission notice 
>>>>>>>>>> shall be included in
>>>>>>>>>> + * all copies or substantial portions of the Software.
>>>>>>>>>> + *
>>>>>>>>>> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY 
>>>>>>>>>> KIND, EXPRESS OR
>>>>>>>>>> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF 
>>>>>>>>>> MERCHANTABILITY,
>>>>>>>>>> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN 
>>>>>>>>>> NO EVENT SHALL
>>>>>>>>>> + * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY 
>>>>>>>>>> CLAIM, DAMAGES OR
>>>>>>>>>> + * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR 
>>>>>>>>>> OTHERWISE,
>>>>>>>>>> + * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR 
>>>>>>>>>> THE USE OR
>>>>>>>>>> + * OTHER DEALINGS IN THE SOFTWARE.
>>>>>>>>>> + *
>>>>>>>>>> + */
>>>>>>>>>> +#ifndef _AMDGPU_CTX_WL_H_
>>>>>>>>>> +#define _AMDGPU_CTX_WL_H_
>>>>>>>>>> +#include <drm/amdgpu_drm.h>
>>>>>>>>>> +#include "amdgpu.h"
>>>>>>>>>> +
>>>>>>>>>> +/* Workload mode names */
>>>>>>>>>> +static const char * const amdgpu_workload_mode_name[] = {
>>>>>>>>>> +    "None",
>>>>>>>>>> +    "3D",
>>>>>>>>>> +    "Video",
>>>>>>>>>> +    "VR",
>>>>>>>>>> +    "Compute",
>>>>>>>>>> +    "Unknown",
>>>>>>>>>> +};
>>>>>>>>>> +
>>>>>>>>>> +static inline const
>>>>>>>>>> +char *amdgpu_workload_profile_name(uint32_t profile)
>>>>>>>>>> +{
>>>>>>>>>> +    if (profile >= AMDGPU_CTX_WORKLOAD_HINT_NONE &&
>>>>>>>>>> +        profile < AMDGPU_CTX_WORKLOAD_HINT_MAX)
>>>>>>>>>> +        return 
>>>>>>>>>> amdgpu_workload_mode_name[AMDGPU_CTX_WORKLOAD_INDEX(profile)];
>>>>>>>>>> +
>>>>>>>>>> +    return 
>>>>>>>>>> amdgpu_workload_mode_name[AMDGPU_CTX_WORKLOAD_HINT_MAX];
>>>>>>>>>> +}
>>>>>>>>>> +
>>>>>>>>>> +int amdgpu_clear_workload_profile(struct amdgpu_device *adev,
>>>>>>>>>> +                uint32_t hint);
>>>>>>>>>> +
>>>>>>>>>> +int amdgpu_set_workload_profile(struct amdgpu_device *adev,
>>>>>>>>>> +                uint32_t hint);
>>>>>>>>>> +
>>>>>>>>>> +#endif
>>>>>>>>>> diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h 
>>>>>>>>>> b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
>>>>>>>>>> index 65624d091ed2..565131f789d0 100644
>>>>>>>>>> --- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
>>>>>>>>>> +++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
>>>>>>>>>> @@ -361,6 +361,11 @@ struct amdgpu_pm {
>>>>>>>>>>       struct mutex            stable_pstate_ctx_lock;
>>>>>>>>>>       struct amdgpu_ctx       *stable_pstate_ctx;
>>>>>>>>>> +    /* SMU workload mode */
>>>>>>>>>> +    struct mutex smu_workload_lock;
>>>>>>>>>> +    uint32_t workload_mode;
>>>>>>>>>> +    atomic_t workload_switch_ref;
>>>>>>>>>> +
>>>>>>>>>>       struct config_table_setting config_table;
>>>>>>>>>>       /* runtime mode */
>>>>>>>>>>       enum amdgpu_runpm_mode rpm_mode;
>>>>>>>>>>
