Return-Path: <SRS0=y7aQ=PK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E7F3C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Oct 2021 11:26:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61C8C60F4F
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Oct 2021 11:26:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 61C8C60F4F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F20606E5BD;
	Fri, 22 Oct 2021 11:26:50 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2059.outbound.protection.outlook.com [40.107.244.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B59F6E5BD
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Oct 2021 11:26:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=US41BWSi+Vh005/0MZn9PWeUaSejIFwyuwSVRyFQUBiS7h09r/Uz/uZj9btFpVprN7csluPqRF5ZD+p2I28VCbyf20kc6ZLKbIjzLl374W9q4xV7ADsOuv10UVKN3Ll2FgdSpn/K3uyXXaOX1t9PVh+3tRgXisanTHMVTpAXN84JPjvCS4bgzR6mtZHWf4Sdc1IHg96xOgtcHAb20o1wcxy7dq3Skv5sBA1NHHLeS2p81myVf4erUWaMCO2DHh1/3uG6m1P3usmGike6u8qBW6efEgmCUs+aNuvRdOIv/K1JyBqeC1cMQob2SddRHkrKv9Grv1VDSnt/PARf4MwNQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kFi5hIK2pPe3FFn3+Ve2J52v263h7d/fWkU+ojYKOJ4=;
 b=hfjYuSG2P3sLraG1hLynKMAmlRxpCBtWEfr3aKIBdWiIybyvonu03eE3HNutclVDgSTCim2JY9XyEULle5utKZLZa+FqcLAFwTjBWAzkrxiPcR47iqMduedq+xMI8ZK4YCqjkT5015BKDi1+n2B9tVsAtpYPDUst4v6babm0+DxQssd3eXGkkPd8wtPy9Em8/WSkX0zqIFJqv49T2hwoE5iMGjnUVmvce4zSQ1QN4ZriejZ7Db9k67A0lWICoCBEGnaegiEGYHkXdU2dhkUnw75DNQ24WmvuopwdZ/5LkRty7A/9uxz/b13TjiOwy6TmdrL97jIkFskcyw/qvt2wDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kFi5hIK2pPe3FFn3+Ve2J52v263h7d/fWkU+ojYKOJ4=;
 b=R+bxTrr3R0MdKDN9id4qolqtqlLkihb9T9OSgF3yRcwUimzzSkNkKTGwcyCvSMJuSkEt6YFMByn9mgUWkSn5TPwngzvkr38l6HDTJApYsz3h5ABesvFChZJO3hAGp4hBr0qaxRhxLxNrKoDj8ipx4JW/528Ke2aaL5dd9iOTlFA=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3930.namprd12.prod.outlook.com (2603:10b6:5:1c9::19)
 by DM6PR12MB2940.namprd12.prod.outlook.com (2603:10b6:5:15f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.18; Fri, 22 Oct
 2021 11:26:47 +0000
Received: from DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::591a:8986:aca2:c560]) by DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::591a:8986:aca2:c560%3]) with mapi id 15.20.4628.018; Fri, 22 Oct 2021
 11:26:47 +0000
Message-ID: <b6649c9f-219b-e2b5-57da-0b8a6dfd139b@amd.com>
Date: Fri, 22 Oct 2021 16:56:33 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 3/3] drm/amdgpu: Implement bad_page_threshold = -2 case
Content-Language: en-US
To: "Russell, Kent" <Kent.Russell@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Cc: "Tuikov, Luben" <Luben.Tuikov@amd.com>, "Joshi, Mukul"
 <Mukul.Joshi@amd.com>
References: <20211020163520.1167214-1-kent.russell@amd.com>
 <20211020163520.1167214-3-kent.russell@amd.com>
 <edd26c75-6cac-7d5d-97b8-4fc085a76417@amd.com>
 <DM6PR12MB3324757ADAEDEB293ED1A53B85BF9@DM6PR12MB3324.namprd12.prod.outlook.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <DM6PR12MB3324757ADAEDEB293ED1A53B85BF9@DM6PR12MB3324.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXPR01CA0027.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:c::13) To DM6PR12MB3930.namprd12.prod.outlook.com
 (2603:10b6:5:1c9::19)
MIME-Version: 1.0
Received: from [10.252.81.250] (165.204.159.242) by
 BMXPR01CA0027.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:c::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4628.18 via Frontend Transport; Fri, 22 Oct 2021 11:26:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 707e0a1d-8936-44ce-4add-08d9954ed57b
X-MS-TrafficTypeDiagnostic: DM6PR12MB2940:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB294075D094F94A9C78FDD38497809@DM6PR12MB2940.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rJrIQD6NqL4lGI3YD9zlH5mNYzvD2c3sSeoYpxQb3V8rUA+4ay+gkjSRfqaSmiP0AmaoS3z1kdSFllxf0RQHPOhDMIzDyobHlc2Db+otXtwJbqh6pSH3lUg/zmqINT3riZ7uQfPjgS8f7LEDamlU4wnBv7OD4IkXOK6pU7gDNoIVSzSGe/kUw3/yQnKVNL6LCR9b06pfJSRGfycrLMuJrOZ/Dgy8ZmqK/5MowWTl1bEngsRCGrfNOqrYo2gOfiSgEgpWahCVzIpFaixMX6f2q+Sdzl+/yqedMWNxgsyjLVw1jZLFS/iv+FjppihCadrxLdHlA8TB3Bqln8uQf7RVj/xrTbWum5F16HQGpB1OQ9P6HtuxsJVVotQzxIqUMW4+6Hy8vVXgZ5bcqEUERiWmmNRU2VvhbHIfkoptrN36Q6zlMTGIOTtQ+5CnwoMHXKPLncUZbVd0s/nYxwBmmk3teTLOgLHFzp8DlX3KLpkPsKorOG+9hql2axXeUfUATnQLBqGs7CYI1n6H2/OlODHpy2m9qOaSM9aM/SBzeph7pAduEGdEsF71L7pKbMclqRu03qsrGwm5OHtmmUkrg0FKkrRxIABNS4ZK4mHR5t36cRbUs5L6BVzxPu4spKDfRmthvVuw4d/k6ziOHYie+LlEh0HWnUdI6B5trCZMO3awVaS+FZh1XoLHocKJXOFJdlW+2RolQMLNJZTdYgqztAukxk6LaHfgpoLgXqfEiCkFDco=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3930.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(86362001)(6486002)(5660300002)(53546011)(31696002)(83380400001)(316002)(36756003)(8936002)(4326008)(66476007)(16576012)(2906002)(8676002)(66556008)(956004)(31686004)(186003)(2616005)(54906003)(508600001)(26005)(110136005)(66946007)(6666004)(38100700002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U3JEdUlRMXNmQWI0VmNGaXlmazhxMDNsdFh0Skc5VE9qVnBEYURsSDNhaC9v?=
 =?utf-8?B?WVpWRS9Uc2wwb3ZPcWRUMWVuaGwvMWQ0R05RRXRMOFIvUFJPS2g2MXlrWlNl?=
 =?utf-8?B?S0dRMXNLSFZHcHRSWm05MzlzSDI1TmI5alh6QU9sdVlNdExaT2lWRWJ3THpR?=
 =?utf-8?B?SmdUR2ZLR2w5L0tld1R2OUNLMjV5c0pRV2NxSVdpV00yMmpDMzJVMy9pWFRt?=
 =?utf-8?B?MldyRkN0OWlQQkJBYmpLU3JVRlR4TFVhckJjc0tLNjM3V0dWUTJPWENoVmlZ?=
 =?utf-8?B?QzROYk9vdEFsREg1ZmNKWGhpT0V3L0FodlV2U0lTT0dNK2FJN01zRXIyUnZ5?=
 =?utf-8?B?clFyc01SY1lDcmpxendYQVhGdjZJb1ZCZks4ekRVOCtuSjM0aW15ekZIL3Y1?=
 =?utf-8?B?NnlGSnJ5cUZSQ3FKRytxVWtEVWlLMXdKWG8rYUZScm92OFNwd1FTR3JZWHI4?=
 =?utf-8?B?Ky9XR2xrcUxyM1l2WlFBdURtelBaWnJvMEdSQ1pkbFhteTFiWEE3NGlabUdV?=
 =?utf-8?B?ZTkyZk1oSXdDUGtPbEVJTVNFUitzRGphbGlhOEc0YTVKUUdSVElZQUxqeng1?=
 =?utf-8?B?emhGbWNsTlRVeERtaFJBU25mQm5XZW5aQ0NlcHpmc1VKWEJoWjR3NXRqS2w0?=
 =?utf-8?B?eEhzek1LaTV0REdYTk5OaFljUUJ2NzZ0NnlIUzhiUmJ5WXpjakEzODRvMWdI?=
 =?utf-8?B?a3NvbGpYc3NsYTFlM0JYbDEzeXpEVTFqdFNvNldlWkhmSHFjMzA0QWc1aVFH?=
 =?utf-8?B?RUg5cHJPRTIwcHMvMkxpR0ZjV1oxOGhqbXBLSXZkWmx1bnl5ck5KRUpkancy?=
 =?utf-8?B?MFFJTDdBTWRPaVFPNTQxcmRwZXd5QUFEemxjZHlYc25ybm01Q1Yzc1VZc3Jw?=
 =?utf-8?B?TS82bUVQUUJhMmhNZVI0YzdRYjd0Y3hPT2FNRHUwS2ZCQUllSzBBMzhSMkRt?=
 =?utf-8?B?dTdVazk5SEd2Y1hKTk9ycmxYa3B5L2lEd3lraTE1Q3Uxelh6eHZWSkJYTjlO?=
 =?utf-8?B?MEVHdC8xL3RxUk9OWWNpbWRxU2hacGd5OE9RWG43MktEeWJMN1B3M0QzWm9x?=
 =?utf-8?B?cmpYRTA5a25jMk5ncENrcHA2WUxqUGV3MlZDakk1ZGYrUEdyZmZneDJiVFVP?=
 =?utf-8?B?YzhCcUN0SHVRRHRQNnhYTFExbk1lSmlpL2hNVGxRSkorNGpnWW9Fb0lWM1F4?=
 =?utf-8?B?dnoyR0lrQlJ5N3EwSnphUGpmcGVqOWxsSTl0WSs0SjFKUmN6UUloVkVIcXBJ?=
 =?utf-8?B?d1V0dFJtV1hqLzJPRnRZUlNoSGlHcW8raVkxaysybWdsSHU5bEphK05SRGNF?=
 =?utf-8?B?a1hUaWlzemtaVzdwa1ZvWDJyV3ZkTkd6UEJ4NHNWRDlreWlOL2NPMjhzelVE?=
 =?utf-8?B?bUdBUFNCSjdOb0FWaiszOVVRSE9kb3Q4UHc4bkFiYU5wSkloZkFqOGtxaFRJ?=
 =?utf-8?B?Y2g1ZFZBeTA0UVJQWlNCb2dsY0REODlTUGdEQ0dSNnczNS9yKzFxSUtZKy9m?=
 =?utf-8?B?bHNIeFRBMnJjamYvVHUxQmVZajl5aW9LOUh3b2EzalpjbDEyMzZVVDRHaG54?=
 =?utf-8?B?b3RTQ0NjdDFoc3g2OXAxOEQzRk5NWTlWb0p5bmZYR2hManR6elJ6dEpjYXA2?=
 =?utf-8?B?ZnkrN0Yzd01qWWhsQ0N2TUtKcHNLOHVYRE4ra1l1elNCZ0FTTW8xL2VtSjNQ?=
 =?utf-8?B?MHZOOVBIN3VoeGc3WFZCMS9sbUJhWjRWUzdQN3BTZWMyOWg5RER3L0FTWU04?=
 =?utf-8?Q?aieHNIwgJRkGVmbWGF/jpQDG/LVtLQUTQmHnZWa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 707e0a1d-8936-44ce-4add-08d9954ed57b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3930.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2021 11:26:47.4738 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: llazar@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2940
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



On 10/21/2021 7:26 PM, Russell, Kent wrote:
> [AMD Official Use Only]
> 
> 
> 
>> -----Original Message-----
>> From: Lazar, Lijo <Lijo.Lazar@amd.com>
>> Sent: Thursday, October 21, 2021 1:25 AM
>> To: Russell, Kent <Kent.Russell@amd.com>; amd-gfx@lists.freedesktop.org
>> Cc: Tuikov, Luben <Luben.Tuikov@amd.com>; Joshi, Mukul <Mukul.Joshi@amd.com>
>> Subject: Re: [PATCH 3/3] drm/amdgpu: Implement bad_page_threshold = -2 case
>>
>>
>>
>> On 10/20/2021 10:05 PM, Kent Russell wrote:
>>> If the bad_page_threshold kernel parameter is set to -2,
>>> continue to post the GPU. Print a warning to dmesg that this action has
>>> been done, and that page retirement will obviously not work for said GPU
>>>
>>> Cc: Luben Tuikov <luben.tuikov@amd.com>
>>> Cc: Mukul Joshi <Mukul.Joshi@amd.com>
>>> Signed-off-by: Kent Russell <kent.russell@amd.com>
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c | 13 +++++++++----
>>>    1 file changed, 9 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
>>> index 1ede0f0d6f55..31852330c1db 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
>>> @@ -1115,11 +1115,16 @@ int amdgpu_ras_eeprom_init(struct
>> amdgpu_ras_eeprom_control *control,
>>>    			res = amdgpu_ras_eeprom_correct_header_tag(control,
>>>    								   RAS_TABLE_HDR_VAL);
>>>    		} else {
>>> -			*exceed_err_limit = true;
>>> -			dev_err(adev->dev,
>>> -				"RAS records:%d exceed threshold:%d, "
>>> -				"GPU will not be initialized. Replace this GPU or increase the
>> threshold",
>>> +			dev_err(adev->dev, "RAS records:%d exceed threshold:%d",
>>>    				control->ras_num_recs, ras->bad_page_cnt_threshold);
>>> +			if (amdgpu_bad_page_threshold == -2) {
>>> +				dev_warn(adev->dev, "GPU will be initialized due to
>> bad_page_threshold = -2.");
>>> +				dev_warn(adev->dev, "Page retirement will not work for
>> this GPU in this state.");
>>
>> Now, this looks as good as booting with 0 = disable bad page retirement.
>> I thought page retirement will work as long as EEPROM has space, but it
>> won't bother about the threshold. If the intent is to ignore bad page
>> retirement, then 0 is good enough and -2 is not required.
>>
>> Also, when user passes threshold=-2, what is the threshold being
>> compared against to say *exceed_err_limit = true?
> 
> My thought on having the -2 option is that we'll still enable page retirement, we just won't shut the GPU down when it hits the threshold. The bad pages will still be retired as we hit them, it will just never disable the GPU. The comment about retirement not working is definitely incorrect now (leftover from previous local patches), so I'll remove that. In this case, I don't think we'd ever exceed the error limit. exceed_err_limit is only really used when we are disabling the GPU, so we wouldn't want to set that to true. Otherwise we wouldn't be loading the bad pages in gpu_recovery_init, and we'll still return 0 from gpu_recovery_init.
> 

Probably, this is too late as this patch is superseded. Replying to this 
to keep the context.

I realized that the question went in the wrong direction because of 
*exceed_err_limit = true. Saw it in the earlier line but didn't realize 
that it was removed.

Anyway, main question I wanted to ask was -
	
	"When user passes threshold=-2, what is the threshold being compared 
against?"

Looked it up today and saw this piece of code.
	        if (amdgpu_bad_page_threshold < 0) {
                 u64 val = adev->gmc.mc_vram_size;

                 do_div(val, RAS_BAD_PAGE_COVER);
                 con->bad_page_cnt_threshold = min(lower_32_bits(val),
                                                   max_count);


For a user who has been specifying say bad_page_threshold=100 in the 
command line and unable to boot, now this is doing something else.

The comparison in next boot is done against a different threshold. In 
fact, it won't even come to this comparison logic in the next boot as 
the threshold is raised by default when this parameter is specified.

The only case this parameter takes effect is when a user is unable to 
boot because bad page retirements have exceeded the "default threshold". 
In other cases it just resets the comparison limit. Hope that is the 
intention.

Thanks,
Lijo


>   Kent
>>
>> Thanks,
>> Lijo
>>
>>> +				res = 0;
>>> +			} else {
>>> +				*exceed_err_limit = true;
>>> +				dev_err(adev->dev, "GPU will not be initialized. Replace this
>> GPU or increase the threshold.");
>>> +			}
>>>    		}
>>>    	} else {
>>>    		DRM_INFO("Creating a new EEPROM table");
>>>
