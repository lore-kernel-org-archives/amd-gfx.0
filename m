Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DA0CCA600E
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Oct 2026 10:09:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DEA4210E6AC;
	Thu,  8 Oct 2026 10:09:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GGKpy/BX";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012056.outbound.protection.outlook.com
 [40.107.200.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F10E510E6AC
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Oct 2026 10:09:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=phLv2/J3bJx3YuR8bEhzmDtRe0P6ztahRfKunUk59Jxv+JwN61OgyPv5j+oSfHgXy51Mnr0RG7+W11Rv0LrOU0FXJNdemkwIdW5Nk2bgTKcH7SIqvmFptQGrUZuiqXf5RCNkU7LQx9Ks+0ICmGAFxOZUhr5pc0Su3wS/Jz6PUsmyyKJPPK4Y7LDqyFKAM1FyRhBsXeThrIt1EHa+6torWKAR6cloDnztfqisbWHAYVV1BNWBQ5JCNfa4dc7DeCUvtJG74ab58UWgfHKCTWxwQqN0GS5RdqccX7HcupWnQJMf1VVjml/c9FbeR65+ADECmSOLfQJ/3ymS0I/8veGTfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iN4opxwwsmVHC/xXTARm4oxQmNp15HsFZE5lA5rBvJ0=;
 b=ajX3VxwfyXZvjWQH5iLTOQe1hhwWNGMi0acZkr+ZaWIjVsDqbWys9SwO/QooTfztaFJ7o1kupbpLpWsWYLD5Zwxjr6XpRPgM+NHYugK28Bj2se9Z2bWJGexg0YBxcbL1QXVkD39Mlm0ZFAxt0bJQWDfV6qxdn4aTpy7+pwGaVsfK9ggWx34Sd4L5yFPK5d8jXldN3CnbnG0MM4BgbpowOXRKMsk6NoKvfR0Eq08QHLlYSxjXWSQvPP0U9U/Yj32zDTOE/WqfGATcqmb29vmxhZYboSvikIJgc6yn4D3loFffTGTBtnKcxhPAIbE81a9SBI3f2nahnvWn/jE8Fcm5qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iN4opxwwsmVHC/xXTARm4oxQmNp15HsFZE5lA5rBvJ0=;
 b=GGKpy/BXPDkvMq/JJ+ldzMU/QdCIFXvSF2cQxzjtjBL8dzjtc1r4Qt89KX/bGKLXX4lH6wg/gArYPy+cXuISGi9gMTVB8XCp65KWSKhrOUe/+DfHMZqesHrSbck67J4IqGcKC0WiAF4egLz9vqayXXCfDnj2JzKQeyAhu0yiiSc=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7794.namprd12.prod.outlook.com (2603:10b6:510:276::15)
 by CY0PR12MB177289.namprd12.prod.outlook.com (2603:10b6:930:138::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.16; Thu, 8 Oct
 2026 10:09:30 +0000
Received: from PH7PR12MB7794.namprd12.prod.outlook.com
 ([fe80::e0be:f851:96ea:cf85]) by PH7PR12MB7794.namprd12.prod.outlook.com
 ([fe80::e0be:f851:96ea:cf85%4]) with mapi id 15.21.0472.015; Thu, 8 Oct 2026
 10:09:29 +0000
Message-ID: <622cc749-f196-404f-b130-8c909b69d1b6@amd.com>
Date: Thu, 8 Oct 2026 15:39:19 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/3] drm/amdgpu: update the fw version for gfx11
 userqueues
To: "Zhang, Jesse(Jie)" <Jesse.Zhang@amd.com>,
 Alex Deucher <alexdeucher@gmail.com>, "Khatri, Sunil" <Sunil.Khatri@amd.com>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20260831150211.1486154-1-sunil.khatri@amd.com>
 <CADnq5_Mz1KrT70mLEbJ4EqikmFGGRiJLXXEWF++pfu2LQC+wQQ@mail.gmail.com>
 <DM4PR12MB5152CAC197B2A15B4D43596FE3932@DM4PR12MB5152.namprd12.prod.outlook.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <DM4PR12MB5152CAC197B2A15B4D43596FE3932@DM4PR12MB5152.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0208.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1ab::13) To PH7PR12MB7794.namprd12.prod.outlook.com
 (2603:10b6:510:276::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7794:EE_|CY0PR12MB177289:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e64d7d4-a36a-4875-938c-08df25243dac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|56012099006|4143699003|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: ZcCjf7mCHlCxs632b7bciuXBLAqBg+MWsHLTfEVrBS9IWM17pmktHjxX4NH3OkMabKtLKU0zK9tOTJsguf/7dSPlJW0JdbsOg1Nf8lefwrHdv53as9PENvvHcBtEnqutTSAZFWwRLWs7kJA+IBoGrPc2kn7TF++X7tXYvV0YU3bzHE9iTZULyT6CCdf82IZ0J5nbAcB+u9FI2tu08Sc2VqAMEjjsk9b+X6QioUZRI44DtcYLyot0uZ+eageBaToAVjMOA9GCznt0d6TP6jbrySNQLLgzQf9eU01LMG6Re4OV7rvqoDr/ixJltffqi1sP1Z47yptQl+rIGRt4tzIthu+VjuGG3SX/1z08TYiS44sjXcfKUDbaF9p1nfYM69MJZHbh10D3nYvZzoK2NqQsIAv3c8yBbDZynYhaoNmgcQdNLKK5WrcOHoJPnwbx/nHtnkZBwvja1QKuYx0R8SHzSNnfqIkjEzoYbzayU/nmgpHzGR49QnwaLlxRaU9G9ZteududXEB81XySE6lFjnmsL02z+BXiuW6+ecVE0YTZj4ViiO2yjq4/L6kBvvHSvxLlCOMynHeNwxPtQvN8e4KaZsrKM8sMwVb1uUgmzCYAX7YE4Tk1Lb5xGoJ/+ykHKcZGKOAGHXu1gvQ9XD4nIgioqacOX7A/BIWZB0yfQgo+niE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7794.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(56012099006)(4143699003)(11063799006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?STB4UWMwMEFvaFlIRXRYV0VsTlJBUlpqS2QydW04dW9xYVUvbGlZbHM4NzBv?=
 =?utf-8?B?aGxOQVIrc0FhYXFkNVRoMStRNmlSQWlFeGhKa003dXlBUHc2YXFPYjBLRjFC?=
 =?utf-8?B?Z1QyRGRDYWhRYnh3dWxoMkVZNU5SOVJGSlBjajFjNnVDTU95OEliRis0RlRV?=
 =?utf-8?B?b0VFNEJCNExlT1V4bVpTY3FRMEJtTWl0aHJzOWtidG4xcE9LdXVYbmxZOU1j?=
 =?utf-8?B?ZEFtd0NiWFpqNXJRUEVWZHl4em9vWEhSNU13aTEzZkNGNEJxQnBjdnNhYWNt?=
 =?utf-8?B?K29aNW5wdlhpN2RJTEpJaDMvYjB1S1VtWGgya0F4QXlOM0hGOWF5SmN1U1Uz?=
 =?utf-8?B?NTNta1RJOURGeXgxdXlLZGFXYW9TVDZpdWFzc1EvMkUrMFVoandUblhzaFdp?=
 =?utf-8?B?Z1Vvem9raGpXY1Z4M05pbmd5dDNDRHhQMHdqeXBaZVhCZlZ4cTU2MFdMZHVm?=
 =?utf-8?B?d2drM1VCdnc4azNoR0sxZXc4YmtjTEhLSElGVkE5OEFqQlVzS2JjNlorOXJD?=
 =?utf-8?B?U2h2QjlUQ3pMYm9BTUQ5Qk04Z2UrV3hyaXN1UFRGNTJmNHF1aEJ2NW8raTM0?=
 =?utf-8?B?alhhNmR5RDdodjlDNnlqeG5PZWljeEZmUDVCU1dBQllScWl1RmphRGd0NXlX?=
 =?utf-8?B?eHU4a0hFV25qWDEwNm10TDZZbjNCMFd6SVAzZ2xyVFRoSTMxeWlvbXF0UnRl?=
 =?utf-8?B?RHRBcXcwRzYzTERRNjRvTGRka0VTS242Qm9VdWM3SFFIbjhwZ0xIOTc3aVRF?=
 =?utf-8?B?SmxNYjFBSTB5eTUwMGVNTGtiNXg5MEo0dDB5Qzc5T202bWRWL0FGdFhqQUp2?=
 =?utf-8?B?SFI3akZLcmZacFRxTUt0RGp6WTZoTlVpNU1TeVpaV3BUdkZJSWZsSWk4RmZh?=
 =?utf-8?B?TzkrK05HaTFQSHpEeFFNOWZlYytiaW9heE56NnlWcDQ0ZVZySjN2bnU2Yk9v?=
 =?utf-8?B?UUI4YnlwOTVlUTgxRlBJUEpjcUJZdW9rTEdweVJWL2l0OHdhcGQ1Z0hPTmZ4?=
 =?utf-8?B?cjZiRXVOdlN4R2tnbjN4d3dNdjNzRFRWekNra1VUNm1HY3ZkbC9tTTZzdFNz?=
 =?utf-8?B?b3FWNnljcTI2RmVQandObUg5RlYxb0dqMjFDZ1laVmxvRThrd3Zna3BhS2dD?=
 =?utf-8?B?ZERKYzNkODEzUjlYWmFrYXlkRjVZYzVEcDdZakpsb2VHQ1RkOUxCSGpkMmg2?=
 =?utf-8?B?WWxyK0R4OWUyaE1iVkMrcWZ6dHVCUnc3QkZYVnBhQkZNWXVGY2RzWXg1blh1?=
 =?utf-8?B?RVdsQnA5RkFibGtpbTBtTE1YMlhqSXR3aWtmWFNXR29TeVhBZHdoaW9qY0Y3?=
 =?utf-8?B?UWkrTUF6MXVqMXlhejQ1SkRiNXVRS2IxK0JIMzU5ZXlaZFhFNVc1L2xaQ0p0?=
 =?utf-8?B?MVVjeGVzZWpQNkpqYUN1U1ZmTDZ0MFh5M25hUHZFeFY5U0JDV2d2dEd1VVFB?=
 =?utf-8?B?dG9TRGpuL0dCVXdicHlyTG9VV3pzTHhHYm1vTDM2SUtxYkIyeXdjZFlvZ3Nt?=
 =?utf-8?B?TW5qYkw1R05UVDdWQzEzOGtkVzZ5NCtLNGwrSEh3RmNmbHAxa2lVb1U0bEdx?=
 =?utf-8?B?NEZLRmhlOTJqSTBLU0lEY1FMdUFEY1VXb1crS0RuS1liY3JmYlF2dCs5bVNY?=
 =?utf-8?B?K0k3VFpyRGtCM2NjZVh3SGoyQkcvaUp1VFZLQXUxUnZZSWtUQ0kvYXZ1dUls?=
 =?utf-8?B?cE1hS09QQUs0bCtoSlpCVmRTL2dKN2M5cjRISVdZalBZcVFFYTVjcVVMNWFj?=
 =?utf-8?B?bzdOYng4ZlJqcFhlNnY2SkYrNml0NFQ2NGdnekNzOUFublBmblhxWXJSYkVo?=
 =?utf-8?B?YTFrMEpWa0JGOHE5ZzNzWHhrL3BxT0UvZDZ3WktEYTNKdGYzakhtMEU1aXd0?=
 =?utf-8?B?QXl5SENjTDl5MUhZcDJDdWpEL1VHcjZPRjIyWkJjdUtMMkJtcUpNa0tDK2hT?=
 =?utf-8?B?dldsUjVQT0ZrT25VMW9xTTQvWVRNeDBhOGVXUGlGQURmalU1YlAyd0M4c2x3?=
 =?utf-8?B?a1VWR0lueWl2QlZTSDdBZmpyQVprMkdVQk9XanRYMmlCT3RPYU12djdvcWF6?=
 =?utf-8?B?b0ZoMXVpV3NPNG0zVmxZWi9pZzQ2dFpBLzNzZjlsVDNHVGtYMTlVTXlTMjFh?=
 =?utf-8?B?SkYwVTlFdVlMc0NEUjhrNm4wZzZGRWtvVWorNDI5MUh1bkg3bUZWbHFSK1Nm?=
 =?utf-8?B?Lzl2R1dtYWdBZnVHdW9hUW1GSXF1REViZ0srQk4rRkh1WjM4R2svZkw1UmxP?=
 =?utf-8?B?UkNieGZHY21qNlhCR1Jod2tVNTZwWVJNS2Zlc3gwaEY1RGlTNjRucEtmbldr?=
 =?utf-8?B?TjFxczF2ZUNlTkNsaThvWUV5TTVWWVIycEplVjVlT1E1NUVlUU1MUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e64d7d4-a36a-4875-938c-08df25243dac
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7794.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 10:09:29.7343 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eilKiMdov1+XtDju+Ag+m20KDQWjZDZm4hXVnTSZfaOUYP9DxAjPXdIRDATb36G0R/HyNtsRAuH1sGSb+92csw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY0PR12MB177289
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


On 08-10-2026 01:36 pm, Zhang, Jesse(Jie) wrote:
> AMD General
>
> Hi Sunil,
>
> Could you please help confirm whether the firmware version check in this patch is correct?
>
> For example, the latest gfx11 ME firmware version I can see is 2550, but the patch requires me_fw_version >= 3090. That's quite a big gap, so I'd like to make sure these thresholds are intended for gfx11.
>
> I also noticed that the new values (ME 3090 / PFP 3190 / MEC 3450) match the versions in our recent gfx12 (navi48) CP firmware builds. Could they have been taken from gfx12 by mistake?
>
> If these numbers are correct, could you let me know which gfx11 firmware release they correspond to?
I see the same fixes merged for gfx11 too, i did not validate on gfx11 
myself but the assumption was to have that same version... probably i 
might have made a mistake not confirm on gfx11 target... I would say use 
the brahma utils and check the fw version on the target and update the 
patch ....

Regards
Sunil Khatri
>
> Thanks,
> Jesse
>
>> -----Original Message-----
>> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex
>> Deucher
>> Sent: Monday, August 31, 2026 11:13 PM
>> To: Khatri, Sunil <Sunil.Khatri@amd.com>
>> Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
>> <Christian.Koenig@amd.com>; amd-gfx@lists.freedesktop.org
>> Subject: Re: [PATCH v1 1/3] drm/amdgpu: update the fw version for gfx11
>> userqueues
>>
>> Patches 1 and 2:
>> Acked-by: Alex Deucher <alexander.deucher@amd.com>
>>
>> On Mon, Aug 31, 2026 at 11:02 AM Sunil Khatri <sunil.khatri@amd.com>
>> wrote:
>>> Update to the latest stable fw versions where userqueues is working as
>>> it is expected with major fixes.
>>>
>>> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c | 8 ++++----
>>>   1 file changed, 4 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>>> b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>>> index d704ce328e6e..2c160ec9dc57 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
>>> @@ -1655,10 +1655,10 @@ static int gfx_v11_0_sw_init(struct
>> amdgpu_ip_block *ip_block)
>>>          case IP_VERSION(11, 0, 2):
>>>          case IP_VERSION(11, 0, 3):
>>>                  if (!adev->gfx.disable_uq &&
>>> -                   adev->gfx.me_fw_version  >= 2420 &&
>>> -                   adev->gfx.pfp_fw_version >= 2580 &&
>>> -                   adev->gfx.mec_fw_version >= 2650 &&
>>> -                   adev->mes.fw_version[0] >= 120) {
>>> +                   adev->gfx.me_fw_version  >= 3090 &&
>>> +                   adev->gfx.pfp_fw_version >= 3190 &&
>>> +                   adev->gfx.mec_fw_version >= 3450 &&
>>> +                   adev->mes.fw_version[0] >= 147) {
>>>                          adev->userq_funcs[AMDGPU_HW_IP_GFX] =
>> &userq_mes_funcs;
>>>                          adev->userq_funcs[AMDGPU_HW_IP_COMPUTE] =
>> &userq_mes_funcs;
>>>                  }
>>> --
>>> 2.34.1
>>>
