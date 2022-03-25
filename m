Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00842C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Mar 2022 14:04:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BF0A10E9E1;
	Fri, 25 Mar 2022 14:04:27 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2085.outbound.protection.outlook.com [40.107.93.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6966810E93D
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Mar 2022 14:04:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n/LMvjDQciYWNCa+5aPRu8yTP1QiLnUNX8/wS1R7Ky0rVc6DXu586rpuVbDr9D7BoBSwejTflcP68T44p/FFEZxC3KljvLfrPa038tzCoouNw277BxJFIRZnr+5QZQgdd0CmZtK03eoxny74gdZ666OnL0lnaoQg4HQ5e5zHMVdnapiBIAh1Vh2d6x11x2mMF+gctGa18SXFvFx+ZrBZzC6GSSD/0BCEiXowHb/11389IJQxXvFB1zY111nwcy1AZ8sdVSKhUF43HiUlkUBm4PzR27gVpvFnZv3dv9KiODriijGSM3nPc0UnnudDy05LddbP1Gqy5APjTVoCc8vT5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wvLFjzD5ORXcUIkAlT90254bPeqLeEkb7mhCDv1SLPQ=;
 b=TM2XndKGl/ZsYvT49qsN3U9OorUIXs/PZq4IGKRJFa21nd6DuJvhr4+2F9Hqb64l+U0fAKnFQhlXar72bsl56FIDp/W/TCL+olmNjAm0rio0MsiRsMG2BozvVutDZkEZwNyHl3hu6tWy31nLV5+UMww6Z4Bndbq8oO0mMm8P9MEFotMdqIYSkvXKrybTwRaDAeJJ5+0HnMoyxraErAsS9B43RseOkBns4cG3p1IUAqVlhNNuTSccRp7rcLvnIvAbg9lufTHsK+yg0oO1ydos6aS3wkStwQq0nplmsKjrnZT7L+KyPApMbjcq/ozjopRWbCcZmxyrAeBPyCJMgY3VYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wvLFjzD5ORXcUIkAlT90254bPeqLeEkb7mhCDv1SLPQ=;
 b=4yLOR48GYkOWPHDcB85LtXHHljuYWtsFkjhFWQr03GklwCn2KkiuV2RpeTpArLfqdimtQfuZC89UAVNBzU0DZfFOdcA3B6V263g2Kp5N9f4g03RK663J1Syv1CwRtbWQLJDBxnaqzyxJOiJGWCSAVF15QnpK3qjR1Evq4cofZK0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4614.namprd12.prod.outlook.com (2603:10b6:a03:a6::22)
 by DM6PR12MB4746.namprd12.prod.outlook.com (2603:10b6:5:35::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.18; Fri, 25 Mar
 2022 14:04:23 +0000
Received: from BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::d851:76d6:b1e6:4a06]) by BYAPR12MB4614.namprd12.prod.outlook.com
 ([fe80::d851:76d6:b1e6:4a06%5]) with mapi id 15.20.5102.019; Fri, 25 Mar 2022
 14:04:20 +0000
Message-ID: <ba649960-5956-787b-8eac-4cedd52f492c@amd.com>
Date: Fri, 25 Mar 2022 19:34:05 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] drm/amd/pm: Check feature support using IP version
Content-Language: en-US
To: "Wang, Yang(Kevin)" <KevinYang.Wang@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20220325083115.1311275-1-lijo.lazar@amd.com>
 <CO6PR12MB5473D304FAB582F9E208A6AE821A9@CO6PR12MB5473.namprd12.prod.outlook.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <CO6PR12MB5473D304FAB582F9E208A6AE821A9@CO6PR12MB5473.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BM1PR0101CA0014.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:18::24) To BYAPR12MB4614.namprd12.prod.outlook.com
 (2603:10b6:a03:a6::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2a4a9a95-a01d-4540-227a-08da0e685ad3
X-MS-TrafficTypeDiagnostic: DM6PR12MB4746:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB47464AD65D5C886ED338A597971A9@DM6PR12MB4746.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /6somTSFX4LOoa1ckWtILOiPpc3fUHHy3795n0TG+d9bsBGe5p/sBMT0TTHVXUZN1RouVgrGz4fyvic3lVA/kFQbj7MQSpA45tbkhPdYFBmpZHFVQRkltC1OK38/syfjgSYqkVe76KbfigssiCXWJOS4nzu6KZZtSAD8yQj7CInUFOzPhv0EZwV6ZvISl549DnZHFPfHAO1Eubdleyy2BU6TMw6vOXUfQ072Yf81PFOGZ/uDh5zqGC2fVWRcu1Rxk7GC02dYfF0RtpT1iLQ4k49mXNmgBUr0fAzukczL1VFJz/GY8FmJQe9lqKhFHND9bAVGoDEAFyn/ryQNZwzqmbbPR/BDQPxsYm1Hrlttifln13Y+0LwXHEsL7k8A4YrZsZbyCO9HXafoFjkWkuDLDC0t/CnETja6EN/B38TWwIN5HufZ4/NyuAyp7OHb3oFp85gOH30RGsCjrNa/p/2+jAW37tywWi9SXSj9YP35b9eBb+cr45ckzbZyqR9tOwE0Pg/C41miI8Wn6vC+jvY9+X1vTZlKJhuzqfE48rhKdRjHUmEsT09kZqbfDWmP5e8KClBKwNlk9IA1tkWoOBZFrKYgSTQsXjw6f/Tr5ypQuHOXpiP5Wpy6cYUVeinmIt+vAAQF0+czHMFglVezm/zms3dQeuFRLi/5RgmHo8h1DAHl10x/oqwfodRjfkvHCmTyPKA/VtiZ6CV/J4Nl0M+vXvNu2G2zDoyXnUc9Ftx2F5WHI6Tq4Ln304k/khwe3UNT
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB4614.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(6512007)(186003)(26005)(2906002)(2616005)(38100700002)(83380400001)(6666004)(316002)(6486002)(31696002)(36756003)(8936002)(110136005)(54906003)(8676002)(66946007)(66476007)(4326008)(66556008)(31686004)(508600001)(53546011)(86362001)(5660300002)(6506007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M0gyeVpsL1VFakd3QStMeURsc0dOV2ZteSttSW5pcGdrb1V5a2lndVNvYXBL?=
 =?utf-8?B?bFdjZFMyMmwrYWVVbE51c09jdU9OOFB1aHpId0t2dkx3bEZtUkhCVVdyRXJD?=
 =?utf-8?B?aEFjb1A1a2psR0gwd3ZKbCtYejA4cUh6WWtnVk04WGYzUGtOcmtMclVHNjVN?=
 =?utf-8?B?NDhtS3p2emhmb3pFZXYyN2xXL1VkQ1RhMERmdjgvVGlUbzloTEdlUy9scVNt?=
 =?utf-8?B?QW4xUFdKRkE2Rmw1STE2dDk1RTI1YUhHRmJYVjRhVzFVY2dKbGVWYVpaZTdY?=
 =?utf-8?B?MXFWbitSVjdHT0lkT0g0YlRvcVdGd3l5V0wxQk5ldnRHSmJVZ3BpR01qcWJh?=
 =?utf-8?B?UDFCMGFobzN0OFlDMWF0S3ZxNEtPYnROTnpBbEhkd3FXQVFiV3c5RVI1bXBR?=
 =?utf-8?B?enJTUTNLUndmUFNiZWw5TGN3dkpJZStkaHhhL1hHRkZsY3BuM2RTaWhkYS9k?=
 =?utf-8?B?eTBNYWcwTjdJNjFzcGJXdWlTQzEzdkp1R0lTRGoySUZzakF1ZHNKTzI3ZS9m?=
 =?utf-8?B?aWprNTRVTklZTHBGemJpZ0V3bUFTZk9JN3lxWlcxNzhtTUh6V1ArcmdwT3lG?=
 =?utf-8?B?R0hzZDUvVmhoWHRqL3o4dGdjT3ZxaDlpZWxmOVRIRmpFMER5M3AvWUNjbk5m?=
 =?utf-8?B?enJKdkVqSVRQWnhNY3U1bElaSURpVm5KSnhmd1c4RjV1V1VySUxOQlZOdUJu?=
 =?utf-8?B?Nk1PUTJVdnVORlU4cmVxNi9qUHZ5UEdNWjJJTVY5UCswZ2RFcHZPempVbjRR?=
 =?utf-8?B?SW5uTzFpNnVFalpwRjkwZHplL04wOUFYY25DNXQyNk9hbnVYNjNoR2c0cy9k?=
 =?utf-8?B?WUxlUjllWmRpT25pdmZVbkZRV3Byb2dXOXlRTW1QaHZEMnVuUEdyV0syL0NZ?=
 =?utf-8?B?eHJHQjE1RlVqelNwMkhsTitlT0JXSDV0cnVldndxMlZpRWtpSTdWbzZKaXlp?=
 =?utf-8?B?K1V4QW14WC9YRkNROGxnUzB1OCtTZVZlcnpoUUQwVHBtbGF3U2MwSzhPL2JQ?=
 =?utf-8?B?dFl6Z1ZIT1pYTzlaN1U1enBIdWRBeExaeG5sSWp1NHVMSlNlTjNXN0NSM0M0?=
 =?utf-8?B?TEF1SE95aEVYN1ZNVDNwNGJTbHJXQlZSNENRTVQ0VGsrRURaa25Oc3lUN1VX?=
 =?utf-8?B?SkxGLzRlZjV0S21VU0E5MDNmK3NpZzF1R0tHOFphTHVhTUFmTVRTR0RqUTA5?=
 =?utf-8?B?blBXQkU4RFA3M3E1djljcTZuNXh6Si94Nm1HMmt3U3JTY0RMNkY4M0VCRURR?=
 =?utf-8?B?RjRzd2FiVm1kSCtLMGdTOWtFOFdjcVYzWm8vTXE2WjZaQWdERjZwdEVnci8z?=
 =?utf-8?B?TzFVZlRKOWZGZDJRd2JCN1c2eXFnZnUybzBKa2dPZTZWdFdtU3FaYUVmR1dQ?=
 =?utf-8?B?blQzUHFZQTNUNkwrd0pla0dTUUdmZ2xYR3JCU2M2a1VsUGo4S2xodWJKZHZY?=
 =?utf-8?B?Y1pnL2hUSG1ITGUzSEIrL0J4SCtrK3ZnUWN1ckd4TFk1OUxhVXB2ck04SERW?=
 =?utf-8?B?RTk4WjFsei9GVkpCQWJJNW55bnhVdjdUbzlEMnJQanBkekpvVU90aXlFMWJ2?=
 =?utf-8?B?TDJVWmRidDFzbmxRQ0orQkRBWWF2UEUwR1ZieERndWkvN1FoeEo5aXpNQ3BT?=
 =?utf-8?B?d1VNb0VTQmEyb0xkc0lTSlZzRFhnOC9GNnk1UWFYN1hMaWk5MnBEd0Nwd0pK?=
 =?utf-8?B?SXNHRGJCQnFDRXN6cFVpUERXNk5JSUkwVGNsWUpSQ29wZGdUaS9DM3NFOTRq?=
 =?utf-8?B?U015L2p6NExraTVsaVBBaFAzYk5IY2ZnaDFZbEpTelRPWkljR3YyMGQ2MVdp?=
 =?utf-8?B?VVN4R0FsbkE5aHpVQnkzNjhOQ3ByNGxudCtDWnZ6T1dJbnVzN05mdVBobFdR?=
 =?utf-8?B?Q1BFemd3OHVyTUJsTFd3a2Z2R29rd1U1Zks0aURPWW5WT0ZlSVVaY1ZRUy9h?=
 =?utf-8?Q?kNHfNWOhVzpY/4ibXipzOHppmNpj6Cc2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a4a9a95-a01d-4540-227a-08da0e685ad3
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4614.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2022 14:04:19.5613 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kk0+M5STkRsk72RoDwWfYmo3o2ShpMAs6yuQwVosmx4w8bFffwQbUxoQyeuFaSJx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4746
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Quan,
 Evan" <Evan.Quan@amd.com>, "Zhang, Hawking" <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 3/25/2022 4:55 PM, Wang, Yang(Kevin) wrote:
> [AMD Official Use Only]
> 
> 
>         if (adev->asic_type > CHIP_VEGA20) {
> +       if (gc_ver != IP_VERSION(9, 4, 0) && mp1_ver > IP_VERSION(9, 0, 
> 0)) {
>                   /* VCN clocks */
> [kevin]:
> 
> please put some comments here (why mp1_ver and gc_ver is needed both), 
> it can help developer to understand some backgrounds.
> thanks.
> 

Sure, will add them. > VEGA_20 includes RAVEN whose GC and MP1 IP 
versions are lesser than VG20. For clarity, I will add something like > 
VEG20 supports this.

Thanks,
Lijo

> Reviewed-by: Kevin Wang <kevinyang.wang@amd.com>
> Best Regards,
> Kevin
> ------------------------------------------------------------------------
> *From:* Lazar, Lijo <Lijo.Lazar@amd.com>
> *Sent:* Friday, March 25, 2022 4:31 PM
> *To:* amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
> *Cc:* Zhang, Hawking <Hawking.Zhang@amd.com>; Deucher, Alexander 
> <Alexander.Deucher@amd.com>; Wang, Yang(Kevin) <KevinYang.Wang@amd.com>; 
> Quan, Evan <Evan.Quan@amd.com>
> *Subject:* [PATCH] drm/amd/pm: Check feature support using IP version
> Instead of ASIC type, use GC and MP1 IP versions for feature support checks.
> 
> Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
> ---
>   drivers/gpu/drm/amd/pm/amdgpu_pm.c | 72 ++++++++++++++++--------------
>   1 file changed, 39 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c 
> b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> index 5cd67ddf8495..f89e0ff3f5a4 100644
> --- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> +++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
> @@ -1954,8 +1954,9 @@ static int default_attr_update(struct 
> amdgpu_device *adev, struct amdgpu_device_
>                                  uint32_t mask, enum 
> amdgpu_device_attr_states *states)
>   {
>           struct device_attribute *dev_attr = &attr->dev_attr;
> +       uint32_t mp1_ver = adev->ip_versions[MP1_HWIP][0];
> +       uint32_t gc_ver = adev->ip_versions[GC_HWIP][0];
>           const char *attr_name = dev_attr->attr.name;
> -       enum amd_asic_type asic_type = adev->asic_type;
> 
>           if (!(attr->flags & mask)) {
>                   *states = ATTR_STATE_UNSUPPORTED;
> @@ -1965,53 +1966,55 @@ static int default_attr_update(struct 
> amdgpu_device *adev, struct amdgpu_device_
>   #define DEVICE_ATTR_IS(_name)   (!strcmp(attr_name, #_name))
> 
>           if (DEVICE_ATTR_IS(pp_dpm_socclk)) {
> -               if (asic_type < CHIP_VEGA10)
> +               if (gc_ver < IP_VERSION(9, 0, 0))
>                           *states = ATTR_STATE_UNSUPPORTED;
>           } else if (DEVICE_ATTR_IS(pp_dpm_dcefclk)) {
> -               if (asic_type < CHIP_VEGA10 ||
> -                   asic_type == CHIP_ARCTURUS ||
> -                   asic_type == CHIP_ALDEBARAN)
> +               if (gc_ver < IP_VERSION(9, 0, 0) ||
> +                   gc_ver == IP_VERSION(9, 4, 1) ||
> +                   gc_ver == IP_VERSION(9, 4, 2))
>                           *states = ATTR_STATE_UNSUPPORTED;
>           } else if (DEVICE_ATTR_IS(pp_dpm_fclk)) {
> -               if (asic_type < CHIP_VEGA20)
> +               if (mp1_ver < IP_VERSION(10, 0, 0))
>                           *states = ATTR_STATE_UNSUPPORTED;
>           } else if (DEVICE_ATTR_IS(pp_od_clk_voltage)) {
>                   *states = ATTR_STATE_UNSUPPORTED;
>                   if (amdgpu_dpm_is_overdrive_supported(adev))
>                           *states = ATTR_STATE_SUPPORTED;
>           } else if (DEVICE_ATTR_IS(mem_busy_percent)) {
> -               if (adev->flags & AMD_IS_APU || asic_type == CHIP_VEGA10)
> +               if (adev->flags & AMD_IS_APU || gc_ver == IP_VERSION(9, 
> 0, 1))
>                           *states = ATTR_STATE_UNSUPPORTED;
>           } else if (DEVICE_ATTR_IS(pcie_bw)) {
>                   /* PCIe Perf counters won't work on APU nodes */
>                   if (adev->flags & AMD_IS_APU)
>                           *states = ATTR_STATE_UNSUPPORTED;
>           } else if (DEVICE_ATTR_IS(unique_id)) {
> -               if (asic_type != CHIP_VEGA10 &&
> -                   asic_type != CHIP_VEGA20 &&
> -                   asic_type != CHIP_ARCTURUS &&
> -                   asic_type != CHIP_ALDEBARAN)
> +               if (gc_ver != IP_VERSION(9, 0, 1) &&
> +                   gc_ver != IP_VERSION(9, 4, 0) &&
> +                   gc_ver != IP_VERSION(9, 4, 1) &&
> +                   gc_ver != IP_VERSION(9, 4, 2))
>                           *states = ATTR_STATE_UNSUPPORTED;
>           } else if (DEVICE_ATTR_IS(pp_features)) {
> -               if (adev->flags & AMD_IS_APU || asic_type < CHIP_VEGA10)
> +               if (adev->flags & AMD_IS_APU || gc_ver < IP_VERSION(9, 
> 0, 0))
>                           *states = ATTR_STATE_UNSUPPORTED;
>           } else if (DEVICE_ATTR_IS(gpu_metrics)) {
> -               if (asic_type < CHIP_VEGA12)
> +               if (gc_ver < IP_VERSION(9, 1, 0))
>                           *states = ATTR_STATE_UNSUPPORTED;
>           } else if (DEVICE_ATTR_IS(pp_dpm_vclk)) {
> -               if (!(asic_type == CHIP_VANGOGH || asic_type == 
> CHIP_SIENNA_CICHLID))
> +               if (!(gc_ver == IP_VERSION(10, 3, 1) ||
> +                     gc_ver == IP_VERSION(10, 3, 0)))
>                           *states = ATTR_STATE_UNSUPPORTED;
>           } else if (DEVICE_ATTR_IS(pp_dpm_dclk)) {
> -               if (!(asic_type == CHIP_VANGOGH || asic_type == 
> CHIP_SIENNA_CICHLID))
> +               if (!(gc_ver == IP_VERSION(10, 3, 1) ||
> +                     gc_ver == IP_VERSION(10, 3, 0)))
>                           *states = ATTR_STATE_UNSUPPORTED;
>           } else if (DEVICE_ATTR_IS(pp_power_profile_mode)) {
>                   if (amdgpu_dpm_get_power_profile_mode(adev, NULL) == 
> -EOPNOTSUPP)
>                           *states = ATTR_STATE_UNSUPPORTED;
>           }
> 
> -       switch (asic_type) {
> -       case CHIP_ARCTURUS:
> -       case CHIP_ALDEBARAN:
> +       switch (gc_ver) {
> +       case IP_VERSION(9, 4, 1):
> +       case IP_VERSION(9, 4, 2):
>                   /* the Mi series card does not support standalone 
> mclk/socclk/fclk level setting */
>                   if (DEVICE_ATTR_IS(pp_dpm_mclk) ||
>                       DEVICE_ATTR_IS(pp_dpm_socclk) ||
> @@ -2026,7 +2029,7 @@ static int default_attr_update(struct 
> amdgpu_device *adev, struct amdgpu_device_
> 
>           if (DEVICE_ATTR_IS(pp_dpm_dcefclk)) {
>                   /* SMU MP1 does not support dcefclk level setting */
> -               if (asic_type >= CHIP_NAVI10) {
> +               if (gc_ver >= IP_VERSION(10, 0, 0)) {
>                           dev_attr->attr.mode &= ~S_IWUGO;
>                           dev_attr->store = NULL;
>                   }
> @@ -2864,8 +2867,9 @@ static ssize_t 
> amdgpu_hwmon_show_power_label(struct device *dev,
>                                            char *buf)
>   {
>           struct amdgpu_device *adev = dev_get_drvdata(dev);
> +       uint32_t gc_ver = adev->ip_versions[GC_HWIP][0];
> 
> -       if (adev->asic_type == CHIP_VANGOGH)
> +       if (gc_ver == IP_VERSION(10, 3, 1))
>                   return sysfs_emit(buf, "%s\n",
>                                     to_sensor_dev_attr(attr)->index == 
> PP_PWR_TYPE_FAST ?
>                                     "fastPPT" : "slowPPT");
> @@ -3177,6 +3181,7 @@ static umode_t hwmon_attributes_visible(struct 
> kobject *kobj,
>           struct device *dev = kobj_to_dev(kobj);
>           struct amdgpu_device *adev = dev_get_drvdata(dev);
>           umode_t effective_mode = attr->mode;
> +       uint32_t gc_ver = adev->ip_versions[GC_HWIP][0];
> 
>           /* under multi-vf mode, the hwmon attributes are all not 
> supported */
>           if (amdgpu_sriov_vf(adev) && !amdgpu_sriov_is_pp_one_vf(adev))
> @@ -3245,18 +3250,18 @@ static umode_t hwmon_attributes_visible(struct 
> kobject *kobj,
>                 attr == &sensor_dev_attr_pwm1_enable.dev_attr.attr)) /* 
> can't manage state */
>                   effective_mode &= ~S_IWUSR;
> 
> +       /* not implemented yet for GC 10.3.1 APUs */
>           if (((adev->family == AMDGPU_FAMILY_SI) ||
> -                ((adev->flags & AMD_IS_APU) &&
> -             (adev->asic_type != CHIP_VANGOGH))) &&     /* not 
> implemented yet */
> +            ((adev->flags & AMD_IS_APU) && (gc_ver != IP_VERSION(10, 3, 
> 1)))) &&
>               (attr == &sensor_dev_attr_power1_cap_max.dev_attr.attr ||
> -            attr == &sensor_dev_attr_power1_cap_min.dev_attr.attr||
> +            attr == &sensor_dev_attr_power1_cap_min.dev_attr.attr ||
>                attr == &sensor_dev_attr_power1_cap.dev_attr.attr ||
>                attr == &sensor_dev_attr_power1_cap_default.dev_attr.attr))
>                   return 0;
> 
> +       /* not implemented yet for APUs having <= GC 9.3.0 */
>           if (((adev->family == AMDGPU_FAMILY_SI) ||
> -            ((adev->flags & AMD_IS_APU) &&
> -             (adev->asic_type < CHIP_RENOIR))) &&       /* not 
> implemented yet */
> +            ((adev->flags & AMD_IS_APU) && (gc_ver < IP_VERSION(9, 3, 
> 0)))) &&
>               (attr == &sensor_dev_attr_power1_average.dev_attr.attr))
>                   return 0;
> 
> @@ -3294,8 +3299,7 @@ static umode_t hwmon_attributes_visible(struct 
> kobject *kobj,
>                   return 0;
> 
>           /* only SOC15 dGPUs support hotspot and mem temperatures */
> -       if (((adev->flags & AMD_IS_APU) ||
> -            adev->asic_type < CHIP_VEGA10) &&
> +       if (((adev->flags & AMD_IS_APU) || gc_ver < IP_VERSION(9, 0, 0)) &&
>               (attr == &sensor_dev_attr_temp2_crit.dev_attr.attr ||
>                attr == &sensor_dev_attr_temp2_crit_hyst.dev_attr.attr ||
>                attr == &sensor_dev_attr_temp3_crit.dev_attr.attr ||
> @@ -3310,13 +3314,13 @@ static umode_t hwmon_attributes_visible(struct 
> kobject *kobj,
>                   return 0;
> 
>           /* only Vangogh has fast PPT limit and power labels */
> -       if (!(adev->asic_type == CHIP_VANGOGH) &&
> +       if (!(gc_ver == IP_VERSION(10, 3, 1)) &&
>               (attr == &sensor_dev_attr_power2_average.dev_attr.attr ||
> -                attr == &sensor_dev_attr_power2_cap_max.dev_attr.attr ||
> +            attr == &sensor_dev_attr_power2_cap_max.dev_attr.attr ||
>                attr == &sensor_dev_attr_power2_cap_min.dev_attr.attr ||
> -                attr == &sensor_dev_attr_power2_cap.dev_attr.attr ||
> -                attr == 
> &sensor_dev_attr_power2_cap_default.dev_attr.attr ||
> -                attr == &sensor_dev_attr_power2_label.dev_attr.attr))
> +            attr == &sensor_dev_attr_power2_cap.dev_attr.attr ||
> +            attr == &sensor_dev_attr_power2_cap_default.dev_attr.attr ||
> +            attr == &sensor_dev_attr_power2_label.dev_attr.attr))
>                   return 0;
> 
>           return effective_mode;
> @@ -3421,6 +3425,8 @@ static void amdgpu_debugfs_prints_cpu_info(struct 
> seq_file *m,
> 
>   static int amdgpu_debugfs_pm_info_pp(struct seq_file *m, struct 
> amdgpu_device *adev)
>   {
> +       uint32_t mp1_ver = adev->ip_versions[MP1_HWIP][0];
> +       uint32_t gc_ver = adev->ip_versions[GC_HWIP][0];
>           uint32_t value;
>           uint64_t value64 = 0;
>           uint32_t query = 0;
> @@ -3467,7 +3473,7 @@ static int amdgpu_debugfs_pm_info_pp(struct 
> seq_file *m, struct amdgpu_device *a
>           if (!amdgpu_dpm_read_sensor(adev, 
> AMDGPU_PP_SENSOR_ENABLED_SMC_FEATURES_MASK, (void *)&value64, &size))
>                   seq_printf(m, "SMC Feature Mask: 0x%016llx\n", value64);
> 
> -       if (adev->asic_type > CHIP_VEGA20) {
> +       if (gc_ver != IP_VERSION(9, 4, 0) && mp1_ver > IP_VERSION(9, 0, 
> 0)) {
>                   /* VCN clocks */
>                   if (!amdgpu_dpm_read_sensor(adev, 
> AMDGPU_PP_SENSOR_VCN_POWER_STATE, (void *)&value, &size)) {
>                           if (!value) {
> -- 
> 2.25.1
> 
