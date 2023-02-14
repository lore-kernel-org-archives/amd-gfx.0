Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A249C05027
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Feb 2023 06:56:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF14A10E7EB;
	Tue, 14 Feb 2023 06:56:09 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on20609.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5b::609])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D04D10E7EB
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Feb 2023 06:56:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E9mLuZvlIJh2dzU8cP7OeWwrbJkg4AyYYBubli7CRayRUmsjj+hSnajcm7NVCZdrHokNBF4VoJs8y/Tw/0eq+S2nAd7tJHgU4N1IC/ib3M69tWEL7b19EW7koONRdyzgBSONnAy8w+szTyMr2hB9pEvSNeH+pk/Xxibayhm75HBysM8x372l9YlPQ3qRWSYyIbtxqtSpzNVhNCjPsO0LaLCE4maePC2VzL7k54Xg9UIVNSne7OBmZUvWkqb/AkTJKqu1raSim1Z8dHmiAqoDrdPrsn7T4vPfyGSFF+HTmy/ZACMktESZBIxjL45Ql5tyTVq3SLVbGmnMLZsa6yLRsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c2X3lbCFb9YZNKgnw1W8MZPZ4cpNFsMGOAVchpU6R0A=;
 b=WJ34MHaCk0X9/x79gx3CWaKwiuZCqvm9YDJE+6INkCYsF3+Edhy2QgIn/8gcZGftqLVxfJT/pa1sA67G0WwV4S0x5KDTUvk/I7+8uke7CTC1TLOtuJvW225ov7tfRyI4zW+GY6dC+/ohPUMbUB9inCKRnxHTHBUOi9oj4xNfuILRZBz8XwbipzIb8s6w/1lT2+jA+YLNwDjRLEnDLBChCODkyTjjy/Ii7byHzFGqw2EgLIHYljMlZ4Vvrb2nrVsGudp45a/+J1aa4L1aRS2iMRwAFPAJ1t231M8gsviDQxDP3Ft54Cwvt8z6fuz2N7eHfFACs01DXlb1AiwxOd9xUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c2X3lbCFb9YZNKgnw1W8MZPZ4cpNFsMGOAVchpU6R0A=;
 b=0wesqmxJLFTeiazVLRpdVMAlFX8ID8+9peqXgHKllTcDUtbbEEjmSiQ1VIZ5h3TplNM6OI/9JWGNhnHx5IR+MB6AtDB/tUbQHKrFOk7bslQ53lpbLIuwjUtTrY+1HK7YPbymNE1Hw/RxnFWpO2kW4pkJrl6abmWiAdjOSMhyMEw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by DS7PR12MB8250.namprd12.prod.outlook.com (2603:10b6:8:db::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Tue, 14 Feb
 2023 06:56:04 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::66b2:8732:c7f0:d6ca]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::66b2:8732:c7f0:d6ca%5]) with mapi id 15.20.6086.024; Tue, 14 Feb 2023
 06:56:03 +0000
Message-ID: <15e79ef9-558b-e6c9-ab3d-40db7a2a625f@amd.com>
Date: Tue, 14 Feb 2023 12:25:51 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH] drm/amdgpu: don't increase UMC RAS UE count if no new bad
 page
Content-Language: en-US
To: "Zhou1, Tao" <Tao.Zhou1@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "Zhang, Hawking" <Hawking.Zhang@amd.com>,
 "Yang, Stanley" <Stanley.Yang@amd.com>, "Chai, Thomas"
 <YiPeng.Chai@amd.com>, "Li, Candice" <Candice.Li@amd.com>
References: <20230210084529.9695-1-tao.zhou1@amd.com>
 <fe541c9c-4684-fd02-e5bc-f28b583744af@amd.com>
 <DM5PR12MB1770AF75B3AFA71C91FEC5D9B0A29@DM5PR12MB1770.namprd12.prod.outlook.com>
 <623a1379-5746-1bfd-b083-c49c3cd169ea@amd.com>
 <DM5PR12MB1770C510765BC7FA52342058B0A29@DM5PR12MB1770.namprd12.prod.outlook.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <DM5PR12MB1770C510765BC7FA52342058B0A29@DM5PR12MB1770.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0013.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25::18) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB4614:EE_|DS7PR12MB8250:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a64de1a-57b9-4f08-5c28-08db0e5888fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SGIKoEH1zC1l4ZGo/u8GVdmXERmhvEFwH+rRzVDYoOtlHpk+y0ucvmktx9skiYyMFDvUj11KyMdwN/8H27asvvWEinpoii5rOOyXyLIW9QVVlQ5HWUwz6IjJAv0SEccfn4pmiYG1St48ITfxHFBVnD7pH2InAFJOZ3oowg0dz1FKlpoP5sHmWU0lwuGxq6yZ23/Jk+s+3j4kdaeutROV1f/YhG01ytGwYqKA5rjfpSqQSOR/4VTyvKZ3zSa8nzQBpvDkLRYwcjQU0LdSeiUHq2Zu+pGcO+FaJG8RUJlUyr+XjuG0YyoKGR2MOc3qk0rd2ZYBNNhohYG5s2XKbBBIjBv2D8nZTwth/sMteugn6Xd/3hcZCKCIEjGJZIbwWKDktDk+tnK67bWpjDLY6VVazIGYyc/hyv6CQGNmvRQmNlSsXjfPFYSAw5zxcXh1JYZTuBYSnELOM7kkv+Zho9+lxwWXw0RbKfRRpKvMrc5cfvHw8UaQRyhZyZ3nl2hmWTwCYGc5Fcvp+Ph7/fPY2CjnOnDY0kg2W6ZR4pAch+Q016lktwJYLUspdQKijz1QT5RtVSD8wMH2E6WQoh/VPrhfGLvNxDxTTRj71VL5M8DvcAkO6boItwbex7eAwg+YLtTYG8XOMD0y/V1CAPd/6lGS6O/ZZoMMtNRwku9fRN/S3/xvVrPgoOq9OCgfnpbVkHaOxXI4AoNRw0tIRBaNtpeQauADjVoUtN68qYM1swHkOuO+XQsE4ymkOBgO/I0LpW0R
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230025)(4636009)(366004)(396003)(39860400002)(346002)(376002)(136003)(451199018)(8936002)(316002)(38100700002)(31686004)(5660300002)(110136005)(6636002)(41300700001)(478600001)(6486002)(31696002)(8676002)(66476007)(66556008)(66946007)(6666004)(53546011)(2906002)(6506007)(921005)(86362001)(26005)(186003)(6512007)(36756003)(2616005)(83380400001)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aytmcXNYWTRSdE9mc2ljK0FBM014cWlLcDdIQitRenNaUVJXMS9KR1Yrb3cz?=
 =?utf-8?B?QnZ2VDBoR1NjRDlzZGE1akhZUTNaUUpmYWExN3FJWHNVNzBGRWRRajl0K3NS?=
 =?utf-8?B?L1Z4eERxeXZZVFhnQ3E0SmozTy9qd1V5QjcvcHd6Mkc2Z0I4SFhjU1pvdWZi?=
 =?utf-8?B?b2NIN3hlRXpHRUxOUWVsRVI5TWJzbTR0UDhTd2NRd2VaOCtXdDJOTk9OeGxo?=
 =?utf-8?B?VlpGN1Z0SE5vTjJMM096a3g3TXhOSXhQam0xcFZETENoNHVHQlZtZUV0cy9o?=
 =?utf-8?B?US9McmNIL2JNcHloN29iWmwyRCtmbjFjcUlFMlFuTGxuY3I3empCaEJMaGha?=
 =?utf-8?B?dnRocmxwb0tvSkdVMXg2K3ZXMTh1Q1pvc0NrM0dIRFJ5VWM5TjQ2SXEwR1Q4?=
 =?utf-8?B?akw2TlpHc1o3c3NuZjUzc0FlWWtLc0pEL2g5eDYvY050NTBYYWJEZFg2WC9a?=
 =?utf-8?B?T3VQQmdCaDdoREVLMi9zNXZFTXhJSFpVcDZ6ZlRDaWNZVFFKNU82RXJCU21X?=
 =?utf-8?B?RGZ6dzBCUTVFVGtoYTJnU28wWjFHVXlQUm11d1NPYlBDYUdxNkNOdEovN0Fw?=
 =?utf-8?B?eFU0a3E5VGZteDFNZUZ5bjloRFBjdWRPUjllcEZ0YUhzcVhTSDN2dVpsVDkz?=
 =?utf-8?B?V0FCWVVDNmJIZlIvRVZqOUZ6WFA3ZnNGMGNacUtMTEQ0WWp3b1BMNjBsbG5P?=
 =?utf-8?B?c3NQUlBuZ1c5SmFieEZldEFpT2JnYVU2aEJ2ajNpdFpPL01iTVF5RzNCbVU5?=
 =?utf-8?B?YUhWMXJUZUE2aml3SVprSHRmM09oQmhHNVd4MHNJeXpVRENsYTNjMzhheTFS?=
 =?utf-8?B?SEQyeExHUTdrZHZBM1k0My9Sdmlsc2VVM1VKRjV5aE02TFNYWmFCTThwczNL?=
 =?utf-8?B?dnJKdTBrWU5Jbnpydk1zL3BkdEFDTmtQeHMxSG9kdHZ6cVh4SVEwMUI5MHFZ?=
 =?utf-8?B?WFpoaXBkcU5DclJ5QnRuRkE5MWNTajJIUmthSEJlSll4UFk2aWxZd2xnQjN0?=
 =?utf-8?B?MDhvRmRhc3N2TXVRdzNUaHJFNVArNWhsMTZldVpuMXg3QldoOVdqVEl0VnE0?=
 =?utf-8?B?SUhEOTE4eW03bVpLU2M4b2RER0RFdUFER25abXo1NVpDMHNlMStNQmtNd2gw?=
 =?utf-8?B?aUxmRmdUUGlKSUpwMTRueE41SkFkeTdZVSsyZGxkcjN1dVhjamgvNHJ6RXFr?=
 =?utf-8?B?Q3A3bEQzVTZ4S3VzU00zZ2FsNUJXb2s2VTdKU3BNbDYrRnFkLzhQeXhNUU0x?=
 =?utf-8?B?QnhoWnBJYzh2ZlBWVzhzem03Z3RCZm1FT3ZBWEdmclNtVVlnRy9rZ3A2cDhh?=
 =?utf-8?B?TTdRdzJyQWQ5WkprQkQ0aEE5MVhjU1NaOHNFczU2aDBZWVkxQ0ZEazBMNnJK?=
 =?utf-8?B?Qy9ITk9EKzRLaDgzdTZmVFNxWTAvY0xZSWF0ekl4aTFxdmNEcUtTTXNwTkdp?=
 =?utf-8?B?Nm1tc1kzUU1SdFRld29UUldtWG04NmlKM0ZCVU13YVovQ2tlYmhRTGU0alRW?=
 =?utf-8?B?M1lIM0JRNExFNlQ0MzBPN1pkQ0s2NGFhZ3E0eVVvc2tBUjBDMnlscTdkWjIw?=
 =?utf-8?B?aFl2SzBwd0JlTHpSMUZzRUlyT3cwdldlSnBQQkJvd3lUWGQvQnFoazlNai95?=
 =?utf-8?B?NHMySStYWndGYUo4TW5acEMzY2FCQ0dIWFJhelhjNGZrYS9wcGNsVVUrVG5V?=
 =?utf-8?B?d2x6enFyeERuYlp3bldHK0tsODVMaGhJQVRUMkZVWmR5YUczTjNkemgySGtj?=
 =?utf-8?B?YVVTeFRoSDJnZDg5VnhyQWxjeE9BdC82VUlHWmtadmxiWVlxTzRJbUdJcCta?=
 =?utf-8?B?VGNkeHRYTm45QTRUSEtIdjBLTk8vQmpFSjJCNUdQaWpDRVk4Q3ltcndJL0Rn?=
 =?utf-8?B?M0dRZ0ZHV2krZlZlQjFrR0QyWnhJTi9HSVVnNTlVMFhiZGd3QzJDL2FhN3FQ?=
 =?utf-8?B?eFppZWw3TllsaERMR20wcjJhODVvNHpjbjZpWWRnSEZ3NjVhZTZJNXNtbUdY?=
 =?utf-8?B?bDRCMkhJeFlqM1NibkhoWVRrbFdUc0YyTnE0ZEFWT2ZNYWpkNGsrc1IrZ3NR?=
 =?utf-8?B?RWJubUt6QU03Rkp2Q2JBa01ESnZMNXRaVmJHaGdiMXZ3allQNTBSYjF4cnVl?=
 =?utf-8?Q?srKcMwC/MlMKqKtsCyRd8cK+N?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a64de1a-57b9-4f08-5c28-08db0e5888fc
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2023 06:56:02.5114 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wPdcRRrqXeYOlTv2d+Big6SJo6tTLp4/BZ2k5qerC6BV4w/qfmXLdTJdNpsXUtsp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8250
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



On 2/14/2023 11:42 AM, Zhou1, Tao wrote:
> 
> 
>> -----Original Message-----
>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>> Sent: Tuesday, February 14, 2023 12:55 PM
>> To: Zhou1, Tao <Tao.Zhou1@amd.com>; amd-gfx@lists.freedesktop.org; Zhang,
>> Hawking <Hawking.Zhang@amd.com>; Yang, Stanley
>> <Stanley.Yang@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>; Li, Candice
>> <Candice.Li@amd.com>
>> Subject: Re: [PATCH] drm/amdgpu: don't increase UMC RAS UE count if no new
>> bad page
>>
>>
>>
>> On 2/14/2023 7:56 AM, Zhou1, Tao wrote:
>>>
>>>
>>>> -----Original Message-----
>>>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>>>> Sent: Monday, February 13, 2023 8:38 PM
>>>> To: Zhou1, Tao <Tao.Zhou1@amd.com>; amd-gfx@lists.freedesktop.org;
>>>> Zhang, Hawking <Hawking.Zhang@amd.com>; Yang, Stanley
>>>> <Stanley.Yang@amd.com>; Chai, Thomas <YiPeng.Chai@amd.com>; Li,
>>>> Candice <Candice.Li@amd.com>
>>>> Subject: Re: [PATCH] drm/amdgpu: don't increase UMC RAS UE count if
>>>> no new bad page
>>>>
>>>>
>>>>
>>>> On 2/10/2023 2:15 PM, Tao Zhou wrote:
>>>>> If a UMC bad page is reserved but not freed by an application, the
>>>>> application may trigger uncorrectable error repeatly by accessing the page.
>>>>>
>>>>
>>>> There is amdgpu_ras_check_bad_page which checks if address is already
>>>> part of an existing bad page. Can't that be used?
>>>>
>>>> Thanks,
>>>> Lijo
>>>
>>> [Tao] amdgpu_ras_check_bad_page is already called in
>> amdgpu_ras_add_bad_pages, this patch just makes use of the result of
>> amdgpu_ras_check_bad_page.
>>>
>>
>> In the patch, below two are called after error count is set to 0.
>> 	amdgpu_ras_save_bad_pages
>> 	amdgpu_dpm_send_hbm_bad_pages_num
>>
>> Instead of that, just check if it's an existing badpage which is repeatedly
>> accessed and proceed directly to the next step (reset if
>> specified)
>>
>> 	if (amdgpu_ras_check_bad_page(adev, address))
>> 		set error count to 0;
>> 		goto reset_logic;
>>
>> Thanks,
>> Lijo
> 
> [Tao] 1. amdgpu_ras_check_bad_page checks only one page, but one ue can generate 16 or more pages.

In this case, it makes sense to do as per the patch. Thanks for the 
explanation.

Thanks,
Lijo

> 2. if no new bad page is found, amdgpu_ras_save_bad_pages will do nothing and ras_num_recs won't increase.
> 3. gpu reset logic should follow the old way even ue count is set to 0.
> 
> This patch only set ue count to 0 if there is no new bad page, but other logic has no change.
> 
>>
>>>>
>>>>> Signed-off-by: Tao Zhou <tao.zhou1@amd.com>
>>>>> ---
>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 9 ++++++++-
>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c | 6 +++++-
>>>>>     2 files changed, 13 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
>>>>> index e85c4689ce2c..eafe01a24349 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
>>>>> @@ -2049,7 +2049,7 @@ int amdgpu_ras_add_bad_pages(struct
>>>> amdgpu_device *adev,
>>>>>     {
>>>>>     	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
>>>>>     	struct ras_err_handler_data *data;
>>>>> -	int ret = 0;
>>>>> +	int ret = 0, old_cnt;
>>>>>     	uint32_t i;
>>>>>
>>>>>     	if (!con || !con->eh_data || !bps || pages <= 0) @@ -2060,6
>>>>> +2060,8 @@ int amdgpu_ras_add_bad_pages(struct amdgpu_device *adev,
>>>>>     	if (!data)
>>>>>     		goto out;
>>>>>
>>>>> +	old_cnt = data->count;
>>>>> +
>>>>>     	for (i = 0; i < pages; i++) {
>>>>>     		if (amdgpu_ras_check_bad_page_unlock(con,
>>>>>     			bps[i].retired_page << AMDGPU_GPU_PAGE_SHIFT))
>>>> @@ -2079,6
>>>>> +2081,11 @@ int amdgpu_ras_add_bad_pages(struct amdgpu_device
>> *adev,
>>>>>     		data->count++;
>>>>>     		data->space_left--;
>>>>>     	}
>>>>> +
>>>>> +	/* all pages have been reserved before, no new bad page */
>>>>> +	if (old_cnt == data->count)
>>>>> +		ret = -EEXIST;
>>>>> +
>>>>>     out:
>>>>>     	mutex_unlock(&con->recovery_lock);
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
>>>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
>>>>> index 1c7fcb4f2380..772c431e4065 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_umc.c
>>>>> @@ -145,8 +145,12 @@ static int
>> amdgpu_umc_do_page_retirement(struct
>>>>> amdgpu_device *adev,
>>>>>
>>>>>     		if ((amdgpu_bad_page_threshold != 0) &&
>>>>>     			err_data->err_addr_cnt) {
>>>>> -			amdgpu_ras_add_bad_pages(adev, err_data->err_addr,
>>>>> +			ret = amdgpu_ras_add_bad_pages(adev, err_data-
>>>>> err_addr,
>>>>>     						err_data->err_addr_cnt);
>>>>> +			/* if no new bad page is found, no need to increase ue
>>>> count */
>>>>> +			if (ret == -EEXIST)
>>>>> +				err_data->ue_count = 0;
>>>>> +
>>>>>     			amdgpu_ras_save_bad_pages(adev);
>>>>>
>>>>>     			amdgpu_dpm_send_hbm_bad_pages_num(adev,
>>>>> con->eeprom_control.ras_num_recs);
