Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35E33C4725D
	for <amd-gfx@archiver.kernel.org>; Mon, 22 Jan 2024 12:45:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF71110EE7E;
	Mon, 22 Jan 2024 12:45:13 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2052.outbound.protection.outlook.com [40.107.223.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DBD8E10EE7E
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 Jan 2024 12:45:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gNMLAhNDu7WdH7Hsh83K1zQoLo4U3bRUQdxbb2z4adJehO1QbnKhoSmfuJwIe9kkOnjfpDXYgaDseMZ8dt2BobngC9ahxF6RcqUspe9kjOppAS48oeofUwMxG+ONs289rR468+MMzrgxhbKzygtep9I8H8wk9+MDoh1aPGVIBVSLpHTBsaGv/i4PJJ6iylq+HtwfxV8U4odgBlFF/rt7nzVVegr3F88eZ7+p8pTTJU2PcykuDU8Q5myIMiTWs+bTudE4MxCFOQF1wva6A+SB6ZogQL/2rfI/Nj2H9d7o6ezqtdK3V5qV1CBOSdkAU+tWYtMwlErsDYLlX4Q/l8tlXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HlYjNPOrfPYYp2gMDhtNVpq3fchJcTC7Sg0Si9Wl8YI=;
 b=Gx8WY6IkMcSMNPbcNgrXMIXVt979dASWKj8+zyRDVogW4Gtmpl2bkMy7xTtFIjfXxfU32WgN/FX7BLpkzWNcPTo4vaan4ZYsHXm/HDcIDOjEEMU76TOZVkb7HSmFLYFmhb1/Bew7ZRD2Ilv//YPx3JRS/pV2sbHPrZ5Zh7R0bH3kS6VGCNG1db9AVT2Vpk2deEH3AdtkoTu2UashTQtKRn/wbhjUogKaosCDcQhECFXRG6IY1aLuiDMOKSKQhBzkIbfKsMSx3EHw8xTyOmB/Q9ROn4t81UiIbCq4Mx4IP5gfaQAtrzl7TT08grSj3ezbGKmVAbF+T1BhduKNwMs6hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HlYjNPOrfPYYp2gMDhtNVpq3fchJcTC7Sg0Si9Wl8YI=;
 b=H6j2MgJcJulhmFfB2eVVRY1EyFfWzVTHug7SITNY3uWe4zc86R3ObfFqiTHQvpjR2C39/6mWGzwV+nUXZ7zguS9xSpq8Gotp5siyxqlvqSKy6EvNKWfqgQuVJoqdsNsVpGBhLyODZAVsoh9CmNDSts5fNvf97FVAf6qUC1TCiY4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB7820.namprd12.prod.outlook.com (2603:10b6:510:268::8)
 by MW4PR12MB7031.namprd12.prod.outlook.com (2603:10b6:303:1ef::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Mon, 22 Jan
 2024 12:45:06 +0000
Received: from PH7PR12MB7820.namprd12.prod.outlook.com
 ([fe80::5b3b:867e:c8bd:8bf8]) by PH7PR12MB7820.namprd12.prod.outlook.com
 ([fe80::5b3b:867e:c8bd:8bf8%7]) with mapi id 15.20.7202.031; Mon, 22 Jan 2024
 12:45:06 +0000
Message-ID: <bd6cb136-4e4d-433e-bb26-ed5b5cc80c22@amd.com>
Date: Mon, 22 Jan 2024 18:14:58 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/amdgpu/pm: Use macro definitions in the smu IH
 process function
Content-Language: en-US
To: Ma Jun <Jun.Ma2@amd.com>, amd-gfx@lists.freedesktop.org
References: <20240122084240.1053190-1-Jun.Ma2@amd.com>
 <20240122084240.1053190-2-Jun.Ma2@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20240122084240.1053190-2-Jun.Ma2@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0068.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:99::9) To PH7PR12MB7820.namprd12.prod.outlook.com
 (2603:10b6:510:268::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB7820:EE_|MW4PR12MB7031:EE_
X-MS-Office365-Filtering-Correlation-Id: d88b706f-c1b8-44ce-5dc8-08dc1b47f5d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f8DZbD7AVYlkMlQ0ZkoUTwEfv9XewostI7kWQzMmj0JHSB/qcU0Kkw3Hyzr6x1QEWbZO17XDk2nU74Bb27WsvwhJ/9oAe1AETR3lKRJytW+g79sZHm3f9Oyi3ioxdq5Oh0/Dmfy1sEYgEYM7wCgFMu8v/Bgxg8Ke6ph9gcdtxS3tzlmspIAcBovqXV/QBHLmadIYc1rk0gZbhIfDe1BwnW9oFLNsGExGbePztKxWNjyKERO+NRRZyIwosL5fGnwWvGXxyP4D/Ba2hjI93UL3m2hUfKJFneRrbFiGTz+VGgD+jPXSu2bafa0qQIlcmgSfm2GlNu9fSX7twISeBgde3WYQlhpz3AJA4SZDPaqGNZspyntX6+09EVJmfWLhl1oonB2ub0vKuu56UV3Hh9sN47UC/lljBr1m6Y+wzECkotEiYNi2l0NedbKONfu5uhj0MdmT9n6FJm+KCazzJv0hqIl/Mol5GYIZoooKG6nO3cb6l53bB3VIMEoV6n7A9f1lDGtikWkq7NyATHDrkSnCDc3U+hvw274VKKOzqFNh8BQN5JemUxvPRoofAZw69r48DXe7vPS8L6JUQ4Rt+vzFWQ/4UhSC9mQIy2/1eJlCTugP2CprWbBuP+Rp8p9K76LJ16ky9ovAax6nxBWIF44x3w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB7820.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(396003)(136003)(366004)(346002)(39860400002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(316002)(6512007)(66476007)(66556008)(66946007)(2616005)(5660300002)(31686004)(53546011)(6506007)(478600001)(6486002)(26005)(6666004)(83380400001)(4326008)(2906002)(31696002)(86362001)(41300700001)(36756003)(38100700002)(8676002)(8936002)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Uk5ZR29ZZis5UHFaQXJJY1dqeWlYdjdYTWdMY3AwcGlaT3NkRyt5WlBMamhJ?=
 =?utf-8?B?UStvSEszMWZIa0Q2KzRJV3V2L2wwbDhwNVd1VTEvbFhha0RtTmFQTFF4MXBK?=
 =?utf-8?B?UW15K1NoT0JRR3VZbW5vOUwvSTNNNGo5T1hXTURWSVlPbmlXOXRSWmtUT05L?=
 =?utf-8?B?WXVNaUl5WWNaNFhQRXF4RTRXd2xZeHpQZEVhNm9qMnFuUGt5NDlDUWlQVFZy?=
 =?utf-8?B?WEVmMHBaZGhucXJtcU9WZkZITmlyQTJHNmxJdXRQeUVsamNpYUNJZ2VDTlNT?=
 =?utf-8?B?elNVR3EvSkI5UUdXOHZqYmp3TitUdlhQY3hEdWI4WXFsbXJMZGZJVW9JY290?=
 =?utf-8?B?Y1MvbGdQL2tJV1FWdGNCeEFUNHVlbGltYzY3NFFmL3p3bWlnL2hUbU0xanQ3?=
 =?utf-8?B?N2JrM2tOMFBRSjNYZDdlaHRZWkszWUpPMjcwUE15S0R3SXh0UUljdEZQSzdo?=
 =?utf-8?B?czNaV1hoaWR2dEl6TzlzVnNFRFM0VEk2YmszSVhCc0NJV3g0WTEvVDdnNlNO?=
 =?utf-8?B?M1lMSngvWEJVb0hVRkRWNisvUHFuMkRMZlpPRTFYc2JrSWdPRnJaZWZrb2tE?=
 =?utf-8?B?VFVrSVVaOVBPaFdieU9xVFg3R3k5aVhnZWtjL1R6b1FEdi93NWJXcjl0aDMv?=
 =?utf-8?B?MG1LYWVZbVZ0dCs4VW9KMVVqM2YxU2p2WWZZaHB2SVZqVlRwdVo1ajg0U3hG?=
 =?utf-8?B?SllpR3BXZFkvbUw5NEN2U1R0eFhjcjFjemEwdEZKbDBPeTBMazJTK3hsd3ZP?=
 =?utf-8?B?MHA5TWYwcXhJYm45UHg0eEV2ckRLcXdJTVNxQ2NldEl3dEg3MGpMc3NVWkN4?=
 =?utf-8?B?WDExaDVQVHNyMzJxajg4STdzOUwxQUVLSnA4VkJIYjhZQUhCMmZTZ0c4eVl3?=
 =?utf-8?B?R3lEdnkzeVRJZ3NRV2phU3dhd3RaS0k2MDZJNjZKdFVDbzVuUEE4azlLSytZ?=
 =?utf-8?B?RmJCbzFDTC9zbUNvUDlHVDI0bG9mdkkxd2JDKzJOT0pEdHVQNXZ6YldpdHRO?=
 =?utf-8?B?a2xtK3NBS3l2anJtMWlGSzA1dlBVQlkwSjBHcUhKb3N5WVpTVWNVeDczUGxB?=
 =?utf-8?B?MElrbWVkaWw0L29NVXl6Q1U1SEpINVRkTWZGM1BzMldrcEpiT1FZdWlXeHdh?=
 =?utf-8?B?TXcvL1R3MkVLVUI5V3ZBdVY2b1YvNGpVUWRkemdMaFJnUVhBeDVZL2NzQXJS?=
 =?utf-8?B?WXhmUnNxbXlQV1ZpV2RYejUvTStpS2JHNk5PdFRhNHNObnV1cmc2Wi9YYTd6?=
 =?utf-8?B?UllKTEo4ekRJZHI1WWo1QnMxa0htZE5GL0dxUmtka1NNMU9maTZMeUJJa05M?=
 =?utf-8?B?UGUxVExiYUk2enJsa2JERGpLUGRsR3M2cUU0NFFPcjB3MEduYXBabGI4Wktt?=
 =?utf-8?B?VUxRY1IzZnQyd0hrSGtUaTd6Nmp5d0haZlptOTM3MTZVVXU1Y2VDcGlOOEJU?=
 =?utf-8?B?SnVscXNoRmxyaTNteHFoNjk1NTN1RjZTMDdLTXBXc3hCaGtIeGdPWmFtalBq?=
 =?utf-8?B?dGlzSXVRbklYWnE4VW1vRWtlaXBXSWE5YmlTTHFKRGpLdWFoQnBPYTBXd0tp?=
 =?utf-8?B?VHQ5TmluSUEzOCtQMmhmeXlTc08zdldLSEdTV2cxVVJ3ZGdwN1RQbDdWVHhQ?=
 =?utf-8?B?RzRWbWxRR2J6UDQybmU2NU5ZWjdvVm9wKzJ2UStyS05tT1ZvZW1yellKb2pv?=
 =?utf-8?B?cTVRcEpZMmZpY2lQWnNabGRWQktDc0Z4NUJzS3BSV1JKcXFUY2ViY01Oc1Rp?=
 =?utf-8?B?a1Z3SzMyMmVOQ0dWblhYdFNNMDZqa2c5NVFpNlVzQlU5QUJQSTVCQzhuRzNh?=
 =?utf-8?B?Qm9ySVJ6cTZLMldORTFOUnBlNUZxSmpnWmhWTERSWmRSUTdjWmJPOUdKQzJ6?=
 =?utf-8?B?UDBvV3pXOEQ2ZWtQazFwdWFzdi9YMTc3cDQ2L2kyWG16ZWV2NzZqZ1NvQUcv?=
 =?utf-8?B?UmNYQUZhZG1NdE9iVG0rdllIQmFZT0dlRGE4RHRzTG05RHNWWFFKZTExZjhV?=
 =?utf-8?B?QThrY1BRdEJleUJvcXU0MkhBWjF3bFA3V015RkgwVUlySGY4aXorZTgvNk9i?=
 =?utf-8?B?Y01vU0h2a2I3bEFFUWNJSGtLMGp0QnhCSEpYYTZ3bHhJU0EzanFXTFlvVlpi?=
 =?utf-8?Q?XhhBC6/hr4JghypiO9xuut12t?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d88b706f-c1b8-44ce-5dc8-08dc1b47f5d2
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7820.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2024 12:45:06.4664 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b+Pc6WIlDu88h3s8P8zs9+bMvtI9fvTYApcwThBZAihYr3DJ7dH/vCR4aBZLpnZP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7031
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
Cc: Alexander.Deucher@amd.com, Kenneth.Feng@amd.com, kevinyang.wang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 1/22/2024 2:12 PM, Ma Jun wrote:
> Replace the hard-coded numbers with macro definition
> 
> Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
> ---
>  .../pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_0.h | 11 +----------
>  .../pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_7.h | 11 -----------
>  drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h       |  5 +++++
>  drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h       | 10 ++++++++++
>  drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h       |  2 ++
>  drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c     | 10 +++++-----
>  drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c     | 14 +++++++-------
>  drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c     |  2 +-
>  8 files changed, 31 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_0.h
> index b114d14fc053..c6b7f904e742 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_0.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_0.h
> @@ -1618,15 +1618,6 @@ typedef struct {
>  #define TABLE_WIFIBAND                12
>  #define TABLE_COUNT                   13
>  
> -//IH Interupt ID
> -#define IH_INTERRUPT_ID_TO_DRIVER                   0xFE
> -#define IH_INTERRUPT_CONTEXT_ID_BACO                0x2
> -#define IH_INTERRUPT_CONTEXT_ID_AC                  0x3
> -#define IH_INTERRUPT_CONTEXT_ID_DC                  0x4
> -#define IH_INTERRUPT_CONTEXT_ID_AUDIO_D0            0x5
> -#define IH_INTERRUPT_CONTEXT_ID_AUDIO_D3            0x6
> -#define IH_INTERRUPT_CONTEXT_ID_THERMAL_THROTTLING  0x7
> -#define IH_INTERRUPT_CONTEXT_ID_FAN_ABNORMAL        0x8
> -#define IH_INTERRUPT_CONTEXT_ID_FAN_RECOVERY        0x9
> +
>  
>  #endif
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_7.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_7.h
> index 8b1496f8ce58..33937c1d984f 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_7.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_7.h
> @@ -1608,15 +1608,4 @@ typedef struct {
>  #define TABLE_WIFIBAND                12
>  #define TABLE_COUNT                   13
>  
> -//IH Interupt ID
> -#define IH_INTERRUPT_ID_TO_DRIVER                   0xFE
> -#define IH_INTERRUPT_CONTEXT_ID_BACO                0x2
> -#define IH_INTERRUPT_CONTEXT_ID_AC                  0x3
> -#define IH_INTERRUPT_CONTEXT_ID_DC                  0x4
> -#define IH_INTERRUPT_CONTEXT_ID_AUDIO_D0            0x5
> -#define IH_INTERRUPT_CONTEXT_ID_AUDIO_D3            0x6
> -#define IH_INTERRUPT_CONTEXT_ID_THERMAL_THROTTLING  0x7
> -#define IH_INTERRUPT_CONTEXT_ID_FAN_ABNORMAL        0x8
> -#define IH_INTERRUPT_CONTEXT_ID_FAN_RECOVERY        0x9
> -
>  #endif
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h
> index a0e5ad0381d6..9fe26497e75e 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v11_0.h
> @@ -63,6 +63,11 @@
>  #define LINK_WIDTH_MAX			6
>  #define LINK_SPEED_MAX			3
>  
> +#define IH_INTERRUPT_ID_TO_DRIVER                   0xFE
> +#define IH_INTERRUPT_CONTEXT_ID_AC                  0x3
> +#define IH_INTERRUPT_CONTEXT_ID_DC                  0x4
> +#define IH_INTERRUPT_CONTEXT_ID_THERMAL_THROTTLING  0x7
> +
>  static const __maybe_unused uint16_t link_width[] = {0, 1, 2, 4, 8, 12, 16};
>  
>  static const
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
> index 46b972f36666..436705a18e99 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
> @@ -59,6 +59,16 @@ extern const int pmfw_decoded_link_width[7];
>  #define DECODE_GEN_SPEED(gen_speed_idx)		(pmfw_decoded_link_speed[gen_speed_idx])
>  #define DECODE_LANE_WIDTH(lane_width_idx)	(pmfw_decoded_link_width[lane_width_idx])
>  
> +#define IH_INTERRUPT_ID_TO_DRIVER                   0xFE
> +#define IH_INTERRUPT_CONTEXT_ID_BACO                0x2
> +#define IH_INTERRUPT_CONTEXT_ID_AC                  0x3
> +#define IH_INTERRUPT_CONTEXT_ID_DC                  0x4
> +#define IH_INTERRUPT_CONTEXT_ID_AUDIO_D0            0x5
> +#define IH_INTERRUPT_CONTEXT_ID_AUDIO_D3            0x6
> +#define IH_INTERRUPT_CONTEXT_ID_THERMAL_THROTTLING  0x7
> +#define IH_INTERRUPT_CONTEXT_ID_FAN_ABNORMAL        0x8
> +#define IH_INTERRUPT_CONTEXT_ID_FAN_RECOVERY        0x9
> +

Since the context_ids are unique across SOCs, these may be kept in
smu_cmn.h.

Thanks,
Lijo

>  struct smu_13_0_max_sustainable_clocks {
>  	uint32_t display_clock;
>  	uint32_t phy_clock;
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h
> index 3f7463c1c1a9..c92ad3f533c5 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h
> +++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h
> @@ -44,6 +44,8 @@
>  #define MAX_DPM_LEVELS 16
>  #define MAX_PCIE_CONF 3
>  
> +#define IH_INTERRUPT_ID_TO_DRIVER                   0xFE
> +
>  struct smu_14_0_max_sustainable_clocks {
>  	uint32_t display_clock;
>  	uint32_t phy_clock;
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> index d74343adaa5f..232e9b1ea006 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c
> @@ -1432,24 +1432,24 @@ static int smu_v11_0_irq_process(struct amdgpu_device *adev,
>  		dev_emerg(adev->dev, "ERROR: System is going to shutdown due to GPU HW CTF!\n");
>  		orderly_poweroff(true);
>  	} else if (client_id == SOC15_IH_CLIENTID_MP1) {
> -		if (src_id == 0xfe) {
> +		if (src_id == IH_INTERRUPT_ID_TO_DRIVER) {
>  			/* ACK SMUToHost interrupt */
>  			data = RREG32_SOC15(MP1, 0, mmMP1_SMN_IH_SW_INT_CTRL);
>  			data = REG_SET_FIELD(data, MP1_SMN_IH_SW_INT_CTRL, INT_ACK, 1);
>  			WREG32_SOC15(MP1, 0, mmMP1_SMN_IH_SW_INT_CTRL, data);
>  
>  			switch (ctxid) {
> -			case 0x3:
> +			case IH_INTERRUPT_CONTEXT_ID_AC:
>  				dev_dbg(adev->dev, "Switched to AC mode!\n");
>  				schedule_work(&smu->interrupt_work);
>  				adev->pm.ac_power = true;
>  				break;
> -			case 0x4:
> +			case IH_INTERRUPT_CONTEXT_ID_DC:
>  				dev_dbg(adev->dev, "Switched to DC mode!\n");
>  				schedule_work(&smu->interrupt_work);
>  				adev->pm.ac_power = false;
>  				break;
> -			case 0x7:
> +			case IH_INTERRUPT_CONTEXT_ID_THERMAL_THROTTLING:
>  				/*
>  				 * Increment the throttle interrupt counter
>  				 */
> @@ -1508,7 +1508,7 @@ int smu_v11_0_register_irq_handler(struct smu_context *smu)
>  		return ret;
>  
>  	ret = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_MP1,
> -				0xfe,
> +				IH_INTERRUPT_ID_TO_DRIVER,
>  				irq_src);
>  	if (ret)
>  		return ret;
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> index fc7c04e19b18..c8fc7eccab06 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
> @@ -1368,24 +1368,24 @@ static int smu_v13_0_irq_process(struct amdgpu_device *adev,
>  		dev_emerg(adev->dev, "ERROR: System is going to shutdown due to GPU HW CTF!\n");
>  		orderly_poweroff(true);
>  	} else if (client_id == SOC15_IH_CLIENTID_MP1) {
> -		if (src_id == 0xfe) {
> +		if (src_id == IH_INTERRUPT_ID_TO_DRIVER) {
>  			/* ACK SMUToHost interrupt */
>  			data = RREG32_SOC15(MP1, 0, regMP1_SMN_IH_SW_INT_CTRL);
>  			data = REG_SET_FIELD(data, MP1_SMN_IH_SW_INT_CTRL, INT_ACK, 1);
>  			WREG32_SOC15(MP1, 0, regMP1_SMN_IH_SW_INT_CTRL, data);
>  
>  			switch (ctxid) {
> -			case 0x3:
> +			case IH_INTERRUPT_CONTEXT_ID_AC:
>  				dev_dbg(adev->dev, "Switched to AC mode!\n");
>  				smu_v13_0_ack_ac_dc_interrupt(smu);
>  				adev->pm.ac_power = true;
>  				break;
> -			case 0x4:
> +			case IH_INTERRUPT_CONTEXT_ID_DC:
>  				dev_dbg(adev->dev, "Switched to DC mode!\n");
>  				smu_v13_0_ack_ac_dc_interrupt(smu);
>  				adev->pm.ac_power = false;
>  				break;
> -			case 0x7:
> +			case IH_INTERRUPT_CONTEXT_ID_THERMAL_THROTTLING:
>  				/*
>  				 * Increment the throttle interrupt counter
>  				 */
> @@ -1398,7 +1398,7 @@ static int smu_v13_0_irq_process(struct amdgpu_device *adev,
>  					schedule_work(&smu->throttling_logging_work);
>  
>  				break;
> -			case 0x8:
> +			case IH_INTERRUPT_CONTEXT_ID_FAN_ABNORMAL:
>  				high = smu->thermal_range.software_shutdown_temp +
>  					smu->thermal_range.software_shutdown_temp_offset;
>  				high = min_t(typeof(high),
> @@ -1415,7 +1415,7 @@ static int smu_v13_0_irq_process(struct amdgpu_device *adev,
>  				data = data & (~THM_THERMAL_INT_CTRL__THERM_TRIGGER_MASK_MASK);
>  				WREG32_SOC15(THM, 0, regTHM_THERMAL_INT_CTRL, data);
>  				break;
> -			case 0x9:
> +			case IH_INTERRUPT_CONTEXT_ID_FAN_RECOVERY:
>  				high = min_t(typeof(high),
>  					     SMU_THERMAL_MAXIMUM_ALERT_TEMP,
>  					     smu->thermal_range.software_shutdown_temp);
> @@ -1476,7 +1476,7 @@ int smu_v13_0_register_irq_handler(struct smu_context *smu)
>  		return ret;
>  
>  	ret = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_MP1,
> -				0xfe,
> +				IH_INTERRUPT_ID_TO_DRIVER,
>  				irq_src);
>  	if (ret)
>  		return ret;
> diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
> index 4894f7ee737b..9a8b7fd6995d 100644
> --- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
> +++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
> @@ -892,7 +892,7 @@ int smu_v14_0_register_irq_handler(struct smu_context *smu)
>  	// TODO: THM related
>  
>  	ret = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_MP1,
> -				0xfe,
> +				IH_INTERRUPT_ID_TO_DRIVER,
>  				irq_src);
>  	if (ret)
>  		return ret;
