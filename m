Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDE11C433EF
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Mar 2022 21:20:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8FF4B10E124;
	Mon, 28 Mar 2022 21:20:19 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2068.outbound.protection.outlook.com [40.107.92.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0D4C10E124
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Mar 2022 21:20:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HJikPrCTlMQC1gsRgz78CENu9ofNh51nsUCInIIZQJ++LPHGIlfQf6NBLtgPl2tWMoo3gfv6amAKnqf7B4oPT1svpVtIUWy6vq4+X6gRKvjnyElero2qPPryfSLPKB0cV2aBvxA2GYg9XTKM2V54fhVgrR+8AW9nWSXE5JndUHJUpdsYJSjQ1KH61QokDRXkE5FxGtg9hn1wc3a7rDZd/jpxlNlE4iq3XUjkBXjRRC5jb1yeuJRceu0eyW1/JIU2EZb66+C/g07eMEz+zxkGmHZDRX/EwzB3UNIvfAXI0stMm3gBAZUPs1L1IphNwOpUpOTOxlMrNIRbQ4pgyqvsVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hHm9K/fdOtlWxGlupZ4MHxiziEiiHC97GKztdihyulU=;
 b=L1bER02Jpm9ZgZZrkMUJtP3uFd/QkBCtnOGqq56d8R/LzvNqE+uaTcYHCvOgL7bCVfFIIhr6VJlI+kTb0/8lesMdAlWjjeQFU+eY43cwx4aB56mNNHaiB8iIVzltYal7WxzjouF8AZKhAwCyohGfuG80o10qYjD2UfO5XPBrN+wlHo9Zkyx11u/OLqnbAVGLMkVYHnx9CcQGkrlSGZFPbH+jqxQa/neIZtk0vccPihSaSZLRoao/jFSYHlHi67olUBUr5e4a5wsg2ZfvZV67j+EWq0euoXc7Rr3OITwLhdMNmLV4/KSv8GCjIt7ezgZpnv4GKt9+jVK8x+skCx/uKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hHm9K/fdOtlWxGlupZ4MHxiziEiiHC97GKztdihyulU=;
 b=Z7ypmZg8M2g0wqJPzU9Zfz/Ewi5wBzA1QzH7cfUmfswh62eTfofIqcQxqo2ne5C6lHhO7RNqKrH6dYs8702+r/x54oI/U+sgO3JVy4AtQKEpqH2TAB47rHT6XAeETfvJUIIOEwYALBg5DjRkbg7p5LXK9CNpPeaATTmbgFWhRjM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by MN2PR12MB4656.namprd12.prod.outlook.com (2603:10b6:208:182::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.22; Mon, 28 Mar
 2022 21:20:16 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::192:5346:4ece:7ca3]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::192:5346:4ece:7ca3%4]) with mapi id 15.20.5102.023; Mon, 28 Mar 2022
 21:20:15 +0000
Message-ID: <d7214967-c77d-5abd-92f9-e60cc98988be@amd.com>
Date: Mon, 28 Mar 2022 17:20:10 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] amd/display: set backlight only if required
Content-Language: en-US
To: "S, Shirish" <Shirish.S@amd.com>,
 "Kazlauskas, Nicholas" <Nicholas.Kazlauskas@amd.com>,
 "Lakha, Bhawanpreet" <Bhawanpreet.Lakha@amd.com>
References: <20220311153320.101332-1-shirish.s@amd.com>
 <0b094720-8c17-db60-bccf-7cdb4ecf6dee@amd.com>
 <3d397907-4845-3900-1046-47a6a5cd3fb6@amd.com>
 <MWHPR12MB126408E512075A72E08F21A6F2169@MWHPR12MB1264.namprd12.prod.outlook.com>
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <MWHPR12MB126408E512075A72E08F21A6F2169@MWHPR12MB1264.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0157.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:e::30) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7895615e-45f9-43c1-f0d7-08da1100bfd2
X-MS-TrafficTypeDiagnostic: MN2PR12MB4656:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB465650CF7DBB246B1350FCC98C1D9@MN2PR12MB4656.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DfA+s3zSWySMrRkCxDl9X3r+rR0/TGywG3DCBLA9BBQAjeBVUBSL6BOroUDXHorx7na3AqD5+gEFxtCfX0aN4Oigy6+R42+3oUvM0tOw8Exc48sIqXz3fSrnltyUHJKEQgCadeui65j755Wx3mej9mYJiO4YvAVyOlLn09O3YOgD75EGzekqr1aV0emO4bNndUi1YS4AhQKaASsjM3GaRB9/nzrd7/W1sSIWBsktImqVbP57UYX+l77JiMfUO+MNI2z59rOm6rRzBqMJ7QpFcRKlkq65p/Px8VS1g2p5WUBd0IMxIs+/fMWtymrHhdxoiAjQzrk+eQK3Zw0v4sM4VrsFAPbLjISn5sm0RJZm39rw8znYlvselHRVeik7AgXyAZLUZMvSPrqtChuPdeo6KRMVrPs3YYsK1HuLe7VGY3Iofa+h1BOExkLbdlHFOQYS/g3thV5X/AZVkMfbKN5HBGZQpnd83ZMsKQWylhJpaKk2GPn5gaLPbPFekhFhj1tFutEI3TKw1SbR8aWdVzD9R7uuhXGt+MFidevz1PfyeDE5agDifGnYN5TsLHlanBXtaqFq5UVZQ907rnpoLxpSINXSnXLuvzKcuNyk2aSKB27nQV7enCzdqbmkGmAzX1C8X/cE0IboUIg0+xWNaAFe2XwwbKklIgZLgutTMlKMQg41s06YVrA7yUGxZMq3r51plluCJJKqhJM+oLyW0fc0RjX8noxp/j2MaInxBzKRPZU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO6PR12MB5427.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(508600001)(86362001)(8936002)(2906002)(66476007)(53546011)(44832011)(66556008)(6506007)(8676002)(4326008)(66946007)(26005)(6666004)(6636002)(31686004)(186003)(36756003)(38100700002)(5660300002)(316002)(83380400001)(110136005)(6512007)(31696002)(6486002)(2616005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dm9ubTRtUUpJeGtBT0dMOVN0bUgyWGdsSjM0NjVpZFpadVBjbnhTWEdHUXcw?=
 =?utf-8?B?ZnpvNE1DaEpSOXlXaVh5WUJHN0NBZDVpVUFXUUtJbmUvbnNadmhqNHBwdE1E?=
 =?utf-8?B?M3Q0YzdzQk5rSi9tN2dvK1ZNY0gvQWhJZTl5OVJtZkFaWGpwSXZCRE00Z3Qy?=
 =?utf-8?B?QytBMGVaOURYQnp6cXVVNGRKNmpidlNNaHRmbm5MSTZkQmVKdzEvdlphNytu?=
 =?utf-8?B?T3NjVWl2NzhEUEhBa3VQMHMwaEtib0dDRFhwSjhBV1RudnpablZHVTc4MlAw?=
 =?utf-8?B?RW0zOU5US0Z1SjBveERQVFJLelZsTlpOa1NKZ3ZGanRkVytTallwcTU3akp5?=
 =?utf-8?B?QW9VTFRhdC9RUlJ5NVQyWUluN3diOTlFQ3pENjUydzhGdTFON1hlUC9xK0Z5?=
 =?utf-8?B?a3RnVDVjMHkwYVVCVGtnVHNjTWxGTTlsQWllYWRpa3RYMElLczUxdjFCcnNj?=
 =?utf-8?B?V2dxcWV3OW9BOEJNY1M3VTdLMzFsZ1ZodVNHcUIzM2NMWm01SGpzQ1QvVkk5?=
 =?utf-8?B?KzlmYlJxOWRlTlVYTm9vS0xiejZnTzlpRzV2azlXU0F5VUk3Qk9BNjBnWTJK?=
 =?utf-8?B?RkVmQ1pkRjN2Y0RjYktLdW9lMDd0NTFYUTllbGhQZWpSTlpSRzJkMW0vejFS?=
 =?utf-8?B?S05tcXhwZmJKL0FRblFncVp0bW8zbDlwWnd0d2lMRlhZdmRPTUs4cm5heklm?=
 =?utf-8?B?U1BRSVAxVW5TYk9PYTJpWDE4SlgzZzJ5eS9XSjNWOFVsYUNLT090NXRqT0RF?=
 =?utf-8?B?eTNjSTA3bHoxSTZIU3dSQTluVmRyZmFReTJ1bnBKTTdmR1FjU2RBbGt1elFM?=
 =?utf-8?B?dk9EcVIxRGlQYkxDeThNck5Hc3Q4amR0RUpqeG9mWmQ2UXF6ekNMc3A2cWF3?=
 =?utf-8?B?U0hnYjI5QnRWMGZZbW5WYzFQSzFycWFraVdESVNWdnpuWE9RcktuWU1HdjVW?=
 =?utf-8?B?Vkljeit5UFdkUThnRkV1WFIxemsvZ2lvRE5qWW40d2tUZVdNTm90NFcrTC9M?=
 =?utf-8?B?M1RpT1ZwcnE0d3llNFFBd09iQUl4bWRla3pQeUFDY25wQkQxZnhiTmxvSDZX?=
 =?utf-8?B?R3RueHI5K0VqL1NESEovbXBFUEhmdXRVZTk5clZ5Nkp0NGRDcG55QjllY0Fz?=
 =?utf-8?B?TVFiWUpkSkh4R21Rb0tBVEswd3BxUTRjSFJ4TVBHeTMrRUR6OEQ5M2Y3cTB0?=
 =?utf-8?B?cUtFN0ViUHpISXJJcWtEaVA5N2lNUEdWaGhJY3hRRmQ0cEdnT2t0VEExNXdo?=
 =?utf-8?B?OG5XdnYyeXdiQUFQWFpOcGRPaGNnV3JQWm5FcGcxZnlXVFFhNXhyaUFJbmw2?=
 =?utf-8?B?Sm5jZVBYZS9TUlpNcWEwTlJodjBJRlZXbW94OW84SFM4bTVTMzhiOSt1eEFy?=
 =?utf-8?B?dW14Q0RobjdVVlowcitQZGlYdmNYM2ZnSlZ6WktpVVp2d1loenN4akJtenI0?=
 =?utf-8?B?MGhxK2RTNWFQdUNFZDNvVTZnVWZKeXZVUlFVaGFTcDZuaU91SFgvR2VUd1dp?=
 =?utf-8?B?S3FzS2k1eERHSE9xRVViQStmSDIzdlY1MmM1MUFpRU1nMng4M0E2aEkxQk9L?=
 =?utf-8?B?MzE0RUZpOHVnNXpsbjNMdCtpM05uVVA0Rmhuc2gwb3BPdVVxNVBjWUZkYmNQ?=
 =?utf-8?B?bmZKcWRGVW9Fd0FRVlNGNlBLZUNPUXVLd1E4YXdKek5QdFlPMkRVTWl4S2hw?=
 =?utf-8?B?TDFNU2R0ZS9KYWw4VUs0cVpETUVlQ2lmUG9XbklrR1F5TWVoSS9yS09tUnlN?=
 =?utf-8?B?cldoSWZsUjdKV1YvOHcrN2hNQmdSWUZ4eE9XNWR4aVpUT1NCd1QrNnlMZGZv?=
 =?utf-8?B?NHpORTZpM255TUJkMG83OFJieWlIREpKeWhYaGp4NDJJZHc4L0grRWt5aGVy?=
 =?utf-8?B?WEVZazhDeDlBZzU4L05JaTA1WGRpUGVKMXJnSCt5MW9ubnNQZkNEdzZqVTBq?=
 =?utf-8?B?dHVRbmo0ZDVYV1hBSjczN1VXZ2krcThTa2t1OC8zdm9jdjFSMWtGWHZ2T3g2?=
 =?utf-8?B?aXRpamNZcmRWdGF1ZzEvanpqK1QvNy9PcGhYdkprRFRIU3dnRC8ybkdTT1V6?=
 =?utf-8?B?ZmpMZ0R5Z0VKOHpzZEtvV1lZbVNFWnpDSVdkZnIvR1VVeEJJUndmeEFucUMx?=
 =?utf-8?B?Qlo2RFBKZ2VySGlML1VWY29xQUVoRGF5aysrZ2JLcGlPSlEyYkNOSVZYMUdz?=
 =?utf-8?B?VnhWVHdsZUNBVnd6MHBtNm5pSW55a2tlS0RNbndvMThEQmpwaElFcFlON1FP?=
 =?utf-8?B?QmZQektVZm9IZkdsQkJUTEVoRzFRbUVwNnN2b2VwUEFCalNRZ0pmV1c3aEhK?=
 =?utf-8?B?WXhNNlBCaE00VDBMMDdrcFNKcEZZV2FNOFlZZ3F1YVJkVGhNb1F4dz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7895615e-45f9-43c1-f0d7-08da1100bfd2
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2022 21:20:15.8226 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JzU7jQh0c9QvW3AfVAWMBlTusoW/luXZU4xqc2Q20vbLfVhFezo5s9OsDstePILAwQihZnaz5kzNC0J1IvZ3SQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4656
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
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2022-03-20 23:47, S, Shirish wrote:
> [AMD Official Use Only]
> 
> Ping!
> 

After internal discussions it turns out that the readback
is indeed not expected to match the value being set if ABM
is enabled. The suggested way to deal with this is to track
the previous value in SW, i.e. exactly what this patch is doing.

Based on that this patch is
Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> 
> 
> 
> Regards,
> Shirish S
> 
> -----Original Message-----
> From: S, Shirish <sshankar@amd.com> 
> Sent: Monday, March 14, 2022 12:24 PM
> To: Wentland, Harry <Harry.Wentland@amd.com>; S, Shirish <Shirish.S@amd.com>; Wentland, Harry <Harry.Wentland@amd.com>; Kazlauskas, Nicholas <Nicholas.Kazlauskas@amd.com>; Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>
> Cc: amd-gfx@lists.freedesktop.org
> Subject: Re: [PATCH] amd/display: set backlight only if required
> 
> 
> On 3/11/2022 9:11 PM, Harry Wentland wrote:
>>
>> On 3/11/22 10:33, Shirish S wrote:
>>> [Why]
>>> comparing pwm bl values (coverted) with user brightness(converted) 
>>> levels in commit_tail leads to continuous setting of backlight via 
>>> dmub as they don't to match.
>> Why do the values not match?
> 
> Here is a sample of values:
> 
> dmub_abm_get_current_backlight() reads backlight value as 11526 =>
> convert_to_user() as 45.
> 
> user_brightness value to be set at this point is 159 =>
> convert_from_user() gives 40863.
> 
> Now, we are continuously comparing 45 (current backlight) with 159 (to be set from user space) in every commit tail till any actual changes happen to brightness.
> 
> Ideally, current brightness/backlight value read from pwm register, when converted should yield 159 but it returns 45.
> 
> Hence, I believe, there's a bug either in conversion back and forth of user space levels or pwm register is not the right way to arrive at current brightness values.
> 
>>   It looks like the value mismatch
>> is our root cause.
> Yes, apparently I could not find any other register read that could bail us out here and provide actual/proper values, hence this patch.
>> I remember a while back looking at an issue where we the readback was 
>> from DMCU while we were setting BL directly via PWM. I wonder if the 
>> opposite is happening now.
>>
>> See this for the previous fix:
>> 2bf3d62dabcc drm/amd/display: Get backlight from PWM if DMCU is not 
>> initialized
> 
> The sample values mentioned above are with this patch applied.
> 
> Is there a better way of reading current backlight levels, that reflect user space ones?
> 
> 
>>> This leads overdrive in queuing of commands to DMCU that sometimes lead
>>> to depending on load on DMCU fw:
>>>
>>> "[drm:dc_dmub_srv_wait_idle] *ERROR* Error waiting for DMUB idle: status=3"
>>>
>>> [How]
>>> Store last successfully set backlight value and compare with it instead
>>> of pwm reads which is not what we should compare with.
>>>
>> Does BL work reliably after S3 or S4 with your change? I wonder if
>> there are use-cases that might break because we're no longer comparing
>> against the actual BL value but against a stored variable.
> I've verified this patch for boot, S0i3 and GUI method of changing 
> brightness on ChromeOS
>>
>>> Signed-off-by: Shirish S <shirish.s@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 7 ++++---
>>>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h | 6 ++++++
>>>   2 files changed, 10 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>> index df0980ff9a63..2b8337e47861 100644
>>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
>>> @@ -3972,7 +3972,7 @@ static u32 convert_brightness_to_user(const struct amdgpu_dm_backlight_caps *cap
>>>   				 max - min);
>>>   }
>>>   
>>> -static int amdgpu_dm_backlight_set_level(struct amdgpu_display_manager *dm,
>>> +static void amdgpu_dm_backlight_set_level(struct amdgpu_display_manager *dm,
>>>   					 int bl_idx,
>>>   					 u32 user_brightness)
>>>   {
>>> @@ -4003,7 +4003,8 @@ static int amdgpu_dm_backlight_set_level(struct amdgpu_display_manager *dm,
>>>   			DRM_DEBUG("DM: Failed to update backlight on eDP[%d]\n", bl_idx);
>>>   	}
>>>   
>>> -	return rc ? 0 : 1;
>>> +	if (rc)
>>> +		dm->actual_brightness[bl_idx] = user_brightness;
>>>   }
>>>   
>>>   static int amdgpu_dm_backlight_update_status(struct backlight_device *bd)
>>> @@ -9944,7 +9945,7 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
>>>   	/* restore the backlight level */
>>>   	for (i = 0; i < dm->num_of_edps; i++) {
>>>   		if (dm->backlight_dev[i] &&
>>> -		    (amdgpu_dm_backlight_get_level(dm, i) != dm->brightness[i]))
>>> +		    (dm->actual_brightness[i] != dm->brightness[i]))
>>>   			amdgpu_dm_backlight_set_level(dm, i, dm->brightness[i]);
>>>   	}
>>>   #endif
>>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
>>> index 372f9adf091a..321279bc877b 100644
>>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
>>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
>>> @@ -540,6 +540,12 @@ struct amdgpu_display_manager {
>>>   	 * cached backlight values.
>>>   	 */
>>>   	u32 brightness[AMDGPU_DM_MAX_NUM_EDP];
>>> +	/**
>>> +	 * @actual_brightness:
>> "actual" seems misleading here. We might want to call this
>> "last" or something along those lines.
>>
>> But let's first see if we can fix the mismatch of BL reads
>> and writes.
> 
> Yes, lets thoroughly evaluate if there is any other way.
> 
> Regards,
> 
> Shirish S
> 
>>
>> Harry
>>
>>> +	 *
>>> +	 * last successfully applied backlight values.
>>> +	 */
>>> +	u32 actual_brightness[AMDGPU_DM_MAX_NUM_EDP];
>>>   };
>>>   
>>>   enum dsc_clock_force_state {

