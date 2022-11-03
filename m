Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B3E6C4332F
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Nov 2022 14:21:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 93C3B10E5FD;
	Thu,  3 Nov 2022 14:21:18 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2066.outbound.protection.outlook.com [40.107.101.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 430B210E5FD
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Nov 2022 14:21:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IgeTFhA6bqp0DHVUPwuoRB9fUHLkIk582Rjr/97C33XVIG91MoTlONrxDFC3mWbbHLf+y0R60IkhzunJdtAqo8HW1wz3ivISd0bzIUCkeHXSc89kcrs8bwsXB4V9FfZYrt/yikF3gzfwOqjjIlLTF/P+PXt+xU4JY14uaPal0OjI85T0MbhqYE4+IdEBbIqSq5eApLZxjyafGDhH7OTeTL4np3ldEwNWamZcAyG7+uEYe9gjzaIMLyc3bsdK1NxK/AyxKUXJcoDjevZK/3xX1plu6OlH9ImfxBof3b/ZlPvz3nBmMAMflpTNf10ewd/WGGhWYNuldfGWbGOMFTGKJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1rsypNtwPyqRgQxCwHondEKm6lcgmQwzJRfL7691+oc=;
 b=iIX0mdx3w27qAe7U2P2646W2sWkbQ6sAOOZalcu24AcBxJfEWEfxLDfX7LX12B1bvzTQqQo6XXvAxAyjUkyWmc1/cS6j+znayj3iMGpC7BgPAPMhIRqAUTJ3uWZtgub0nkN/FIvxCcklFEaI1yjR9u5TDiI2SaEc5mIrwOqzYHMYLUx+iD94v4tDGsGVsRMtUby+hH49eOLabO2tDqXO0tUZlqop/Durotc9iSWi3M/moOtJOddHX0jbiPfqY69G+GXcDZsLgTDDtDtazMBga089gi9EoR2XqR6g+G60tSSNzB8ODzV/bRqBmPTt+ryyLKHPonuBbzhGnVqcr14muA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1rsypNtwPyqRgQxCwHondEKm6lcgmQwzJRfL7691+oc=;
 b=mN/o/YCFnrEj3iRHIpazwN21h5+r8fUG/rWY2HHpl9dF3+Xx1rCtedciaF8nLilCdcRAsd9xbiYbTl3D0+OsqPGo4dzEVvpGJi+udsXZxQvJobl9vPIFDW4t6hu/2F2KxZ9xP1cy4aihENvxf/xwfAUV3zKSCma0SMwOsQyWfoQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB2941.namprd12.prod.outlook.com (2603:10b6:208:a9::12)
 by SN7PR12MB7202.namprd12.prod.outlook.com (2603:10b6:806:2a9::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19; Thu, 3 Nov
 2022 14:21:09 +0000
Received: from MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::588f:c941:4f62:9d89]) by MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::588f:c941:4f62:9d89%3]) with mapi id 15.20.5769.019; Thu, 3 Nov 2022
 14:21:09 +0000
Message-ID: <2f9d42a0-7f42-20b0-18b8-40c38ab10ceb@amd.com>
Date: Thu, 3 Nov 2022 10:21:08 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v4 1/1] drm/amd/display: add DCN support for ARM64
Content-Language: en-US
To: Nathan Chancellor <nathan@kernel.org>, Ao Zhong <hacc1225@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>
References: <20221031193738.23538-1-hacc1225@gmail.com>
 <20221031193738.23538-2-hacc1225@gmail.com>
 <6b5fb93f-fd23-c96d-0f1d-ba8bcd7a5079@amd.com>
 <Y2FJ5wXpEpKf9v/P@dev-arch.thelio-3990X>
From: Rodrigo Siqueira Jordao <Rodrigo.Siqueira@amd.com>
In-Reply-To: <Y2FJ5wXpEpKf9v/P@dev-arch.thelio-3990X>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL0PR0102CA0003.prod.exchangelabs.com
 (2603:10b6:207:18::16) To MN2PR12MB2941.namprd12.prod.outlook.com
 (2603:10b6:208:a9::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB2941:EE_|SN7PR12MB7202:EE_
X-MS-Office365-Filtering-Correlation-Id: c06e0b07-b1a8-4996-145a-08dabda6a739
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 82iVyzrMXlN0i8ciLC2K0tZ6qap7wfhkb09EG+sPrrlsbPAWxtwgtqKirH25v75EVVdgBptfv0tAlBohivHZgy8WJ30ENVXmoqdAvkFvt5PIQT70avyBDSF9nrKXn152EuSHbLPAPIbPpCZ+BMXKEWrBZzIwUHkK1FZ2WXQ9b2XK+4lZZlByxvrR7VNm2xj2teId7dcqiCXKBBWYmhtBKkzMAdLfXoitUdiUw2Dta6yeYZBGNtxg0TecNSnIW2XZ0Xwv/D0y2SdYBiKwJLaWm4x231Pn2zQ56mdNAfVlK5hwTZuxwjvl+FCA/YGn6SrZm2JGzu7CFW5/R+QsHqiSsPcSojJQdDhn21KHoq90RcudKaP+dEOEmctCL3NQYIHVwY1D5VMoHjJ5hEasfmq0jdK20IY+AlVzi8pDjfHjKXF2SjT03DIZ1+HLNq0qC1nwYyNoNPWuXBiBOVPb4Oa9TLB5IyRqES9o4gCd7vj0m+r1QOmw9Djk1VosGrkwb7CdVd21OLQVleALGr+is0Jdo4MlI6nzNJ2qj/IzjJWiAc3xK7dMymkjzHotX4yazCC8LNeOvwiIzozJgsYUaDVfSyf4BE2r90/a/+VnuziVa3OcERAtb9jrQszOBxbQWzPRtZ0MuaFVTg7LIBgzZFwwJRPbRUFCxAQ4Rz0f/j2lY1RbasrOoXEnoQlBAq2qhJhP2xj3/mYoxjb0ZieDjZ24KiG9vqaDDteFl3AP7k0hpTOWQ03s+gPB9kvy8wgUaA44hmiytAW6JU7S7MTgEkIe8OHu1oIZQFivwmssx/lbBNT96TFS5dxEN13ekzyCsbXQW6YQBREA5jDKteVZC/Xluw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB2941.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(376002)(366004)(346002)(396003)(39860400002)(451199015)(36756003)(66556008)(31686004)(4001150100001)(6636002)(31696002)(5660300002)(8676002)(2906002)(83380400001)(86362001)(186003)(38100700002)(966005)(6512007)(110136005)(478600001)(6486002)(2616005)(26005)(54906003)(53546011)(41300700001)(4326008)(66946007)(316002)(66476007)(6506007)(8936002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q1Z0YVd1c2xzbVMzT0ZFS3FEWGExSmZiQ0xiN25IZk5acUhzRnc2TDNmUldw?=
 =?utf-8?B?S2g4Y2FENnNQakl1dm16NUhrc0lDckNseVdmT1lVbWpsb0VBckVEVzkrQk1G?=
 =?utf-8?B?eXJiMmhEaG5pdC9aTCtNa0o5QWh3bURuSnJ2MENlODlvTmdBTkl0c3RuUWM0?=
 =?utf-8?B?emdra2VjVUFpaE5GYWU1a1dpeDNBcTBRMC83cEtBSFl2eXlydzFsWGlCbldF?=
 =?utf-8?B?c1RxMW10ak42aEdyT09qRC8vemdHL2hqN0ZsVkhRdVNWeHU2VnE1eVJCb2p2?=
 =?utf-8?B?bjlzV0piemtVUlZmUkIzMFV4NER5ZlplWWwwNG95U0RUaHhaRWVZRmxOQlh6?=
 =?utf-8?B?UE5hY1lXQXVDTGt3eUNrR0VhdHVWakdiVFNzUERlYU1ZeTRMcWR0d292K0Fz?=
 =?utf-8?B?N2c3dmwwcEhocEVLN3c2TGRML1ZJb0JoTzJPS2ZPaG1MQ3hwSFhxeDBmOGRo?=
 =?utf-8?B?NjBXMGkvT2MzeHMwY1JZUlVGaEpTUDZWSWx4NkIvMEU0bnFDSC9pOXpYT1Nq?=
 =?utf-8?B?MXBob0s4eUx5YmU5bGFmcnBBQzVoZ2ZleFBnT21JY2F2NWVBclU4OFpZVWIy?=
 =?utf-8?B?bkxmTERLTnhCL0kyUmF6Zm5oL3hLMERQZGdlMnpibnkyYlllbU9ybStGL29W?=
 =?utf-8?B?ZlJUd3B5Qy9OR0J0YWNmK2Z3RE9zWjBxZ2txSStFdXYxRWVHbXFGb3Faekl2?=
 =?utf-8?B?VEhWcDNaVTgzYWVZSjBkekNIUXNWcFJ1MisrdEhya3JIbGozRHphSlBDVWZS?=
 =?utf-8?B?QzhpSEFERmEzMVJKS1NwS1lQRkJMNmE4QThxbjRRM2pkMmlDOUd1Y3FJWWJ4?=
 =?utf-8?B?ZktveWpkdENyZXVDVzg0dmtaVm5PUEwzNXhFU0RMR0xsRTNydmpabG84Mzc5?=
 =?utf-8?B?ZEVNSWpNQjRwYWhmdU80YmtBcStIUXB1WnBEeEZhTXl6OVIxa0xNR3dtaU5q?=
 =?utf-8?B?WU5xUmlEMmp5UlJnQXRudTFUTHh2Rng3Mjl1QzNSV2J3aGlXYS9wQjlRUkNx?=
 =?utf-8?B?WXlDcGo1RlFuR0QweFdkSmdxa2NDTVphcW80VVBNOCtLVitRejE5cW1wNTVs?=
 =?utf-8?B?T3NuUDB4NStNZ1FISThvZmVEMTB6WnBlaFNrMHdtTktSdVNpdE0zYnQrSTNF?=
 =?utf-8?B?WkZxeUJQZ3NYQlp6SXhPajU0VlN0S2prVlYrMnd6bWprcll5OHVVZWZpS1B1?=
 =?utf-8?B?cVhkT2NramV2eXRFT2hCRWI1VUh2QjFjY1FobmllekpIbEVKTi9lc3dzZGVM?=
 =?utf-8?B?bjdhcUsvdnE2eWhvZzJyTjQ5ZkxYMkIzY0VDdlhFZjd2c0xWV092andIamRH?=
 =?utf-8?B?Uk9SOWE1bGFBV3R1K01iVjFKZGJYS2U3eWxpT2E5cGVSSkU3SHgyenRSL3JP?=
 =?utf-8?B?R2NuL1lqN3FHZlJQcU02aGtnYitiMnJOSSs0bG1iWUxHVWZNcE0raWE1R3BU?=
 =?utf-8?B?aWgzTXhkUExZUTBLVCtvcnVtZnpucjk2WG9WOGl5L3czUkNxdnZOWElLU3E2?=
 =?utf-8?B?WVhrU3hxZlg0YXNGYVNzWWtHWjRBSzE2aWZublZMamxqRk5EU0doUlNQN1My?=
 =?utf-8?B?REhieXpQRGpSdGdveVhKT3pMdysyRENsU1lkOTU3SXdFaDIzL0FLQzZRSWc2?=
 =?utf-8?B?OUN2WUR6cWhvcytWVXpjaXE5VlBYUktvamVkZEtIRmE2OXR2Q0ZqODYwN0R0?=
 =?utf-8?B?MGlrbzk3MnQ0WGFqRkhYRFpwMHlIbFB0OWJCSldCSnRtNndORUV6U3owZmNt?=
 =?utf-8?B?bS8zeUY5VWFSamZtbWhKbkI4Wm43cENZSk5Qdk9WNUtQei9Kdml2U24yYnZC?=
 =?utf-8?B?OFpzNHY3UWgwZ2FzeHhNN2VLb3lLdGNDd1pOYXpPaVhNbjR4UkN4aXVZaTR4?=
 =?utf-8?B?R0pmWit2SFk3Ymp1Qnh5NUxwSG5tOUYyTzlEdTVRaU1JYVdISWNSNm1TQ3A3?=
 =?utf-8?B?a1AzdDlwU2lJa2FyRGJXRC95RHZMVGZvYjJqVWsva3pBaWdxY2E2dDNleGtT?=
 =?utf-8?B?N256TFNqdXh0YkttWUNwMC9qV0JxdlJEVUo3eWVFbzByM0JjcmN6bEJha1ll?=
 =?utf-8?B?RHRnT3JLRXJLMkg3a0hZc0pLWmRIZmpLMGc5a21Bdno1UjB0cThMenlOb1lo?=
 =?utf-8?Q?R3oCBLa0Zxdr4R5JnZzUNeEmr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c06e0b07-b1a8-4996-145a-08dabda6a739
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB2941.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2022 14:21:09.5040 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EiCoAQc9psnv+q/lkjfLtBY+l+E3b1jalm9Zxg7YkYzRnO8s1dMx0MINdVVc8uUjZ1F4jhuZw1F2y3O6m5tthg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7202
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
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Arnd Bergmann <arnd@arndb.de>,
 Leo Li <sunpeng.li@amd.com>, amd-gfx@lists.freedesktop.org,
 Harry Wentland <harry.wentland@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 linux-arm-kernel@lists.infradead.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2022-11-01 12:31, Nathan Chancellor wrote:
> On Tue, Nov 01, 2022 at 10:36:08AM -0400, Rodrigo Siqueira Jordao wrote:
>>
>>
>> On 2022-10-31 15:37, Ao Zhong wrote:
>>> After moving all FPU code to the DML folder, we can enable DCN support
>>> for the ARM64 platform. Remove the -mgeneral-regs-only CFLAG from the
>>> code in the DML folder that needs to use hardware FPU, and add a control
>>> mechanism for ARM Neon.
>>>
>>> Signed-off-by: Ao Zhong <hacc1225@gmail.com>
>>> ---
>>>    drivers/gpu/drm/amd/display/Kconfig           |  3 ++-
>>>    .../gpu/drm/amd/display/amdgpu_dm/dc_fpu.c    |  6 ++++++
>>>    drivers/gpu/drm/amd/display/dc/dml/Makefile   | 20 +++++++++++++++----
>>>    3 files changed, 24 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/display/Kconfig b/drivers/gpu/drm/amd/display/Kconfig
>>> index 0142affcdaa3..843a55a6a3ac 100644
>>> --- a/drivers/gpu/drm/amd/display/Kconfig
>>> +++ b/drivers/gpu/drm/amd/display/Kconfig
>>> @@ -6,7 +6,8 @@ config DRM_AMD_DC
>>>    	bool "AMD DC - Enable new display engine"
>>>    	default y
>>>    	select SND_HDA_COMPONENT if SND_HDA_CORE
>>> -	select DRM_AMD_DC_DCN if (X86 || PPC64)
>>> +	# !CC_IS_CLANG: https://github.com/ClangBuiltLinux/linux/issues/1752>>>> +	select DRM_AMD_DC_DCN if (X86 || PPC64 || (ARM64 && KERNEL_MODE_NEON && !CC_IS_CLANG))
>>>    	help
>>>    	  Choose this option if you want to use the new display engine
>>>    	  support for AMDGPU. This adds required support for Vega and
>>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c b/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c
>>> index ab0c6d191038..1743ca0a3641 100644
>>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c
>>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c
>>> @@ -31,6 +31,8 @@
>>>    #elif defined(CONFIG_PPC64)
>>>    #include <asm/switch_to.h>
>>>    #include <asm/cputable.h>
>>> +#elif defined(CONFIG_ARM64)
>>> +#include <asm/neon.h>
>>>    #endif
>>>    /**
>>> @@ -99,6 +101,8 @@ void dc_fpu_begin(const char *function_name, const int line)
>>>    			preempt_disable();
>>>    			enable_kernel_fp();
>>>    		}
>>> +#elif defined(CONFIG_ARM64)
>>> +		kernel_neon_begin();
>>>    #endif
>>>    	}
>>> @@ -136,6 +140,8 @@ void dc_fpu_end(const char *function_name, const int line)
>>>    			disable_kernel_fp();
>>>    			preempt_enable();
>>>    		}
>>> +#elif defined(CONFIG_ARM64)
>>> +		kernel_neon_end();
>>>    #endif
>>>    	}
>>> diff --git a/drivers/gpu/drm/amd/display/dc/dml/Makefile b/drivers/gpu/drm/amd/display/dc/dml/Makefile
>>> index d0c6cf61c676..d4e93bed1c8e 100644
>>> --- a/drivers/gpu/drm/amd/display/dc/dml/Makefile
>>> +++ b/drivers/gpu/drm/amd/display/dc/dml/Makefile
>>> @@ -33,6 +33,10 @@ ifdef CONFIG_PPC64
>>>    dml_ccflags := -mhard-float -maltivec
>>>    endif
>>> +ifdef CONFIG_ARM64
>>> +dml_rcflags := -mgeneral-regs-only
>>> +endif
>>> +
>>>    ifdef CONFIG_CC_IS_GCC
>>>    ifeq ($(call cc-ifversion, -lt, 0701, y), y)
>>>    IS_OLD_GCC = 1
>>> @@ -55,8 +59,6 @@ frame_warn_flag := -Wframe-larger-than=2048
>>>    endif
>>>    CFLAGS_$(AMDDALPATH)/dc/dml/display_mode_lib.o := $(dml_ccflags)
>>> -
>>> -ifdef CONFIG_DRM_AMD_DC_DCN
>>>    CFLAGS_$(AMDDALPATH)/dc/dml/display_mode_vba.o := $(dml_ccflags)
>>>    CFLAGS_$(AMDDALPATH)/dc/dml/dcn10/dcn10_fpu.o := $(dml_ccflags)
>>>    CFLAGS_$(AMDDALPATH)/dc/dml/dcn20/dcn20_fpu.o := $(dml_ccflags)
>>> @@ -88,7 +90,6 @@ CFLAGS_$(AMDDALPATH)/dc/dml/calcs/dcn_calcs.o := $(dml_ccflags)
>>>    CFLAGS_$(AMDDALPATH)/dc/dml/calcs/dcn_calc_auto.o := $(dml_ccflags)
>>>    CFLAGS_$(AMDDALPATH)/dc/dml/calcs/dcn_calc_math.o := $(dml_ccflags) -Wno-tautological-compare
>>>    CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/display_mode_vba.o := $(dml_rcflags)
>>> -CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn2x/dcn2x.o := $(dml_rcflags)
>>>    CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn20/display_mode_vba_20.o := $(dml_rcflags)
>>>    CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn20/display_rq_dlg_calc_20.o := $(dml_rcflags)
>>>    CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn20/display_mode_vba_20v2.o := $(dml_rcflags)
>>> @@ -105,7 +106,18 @@ CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn32/display_mode_vba_util_32.o := $(dml_rcf
>>>    CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn301/dcn301_fpu.o := $(dml_rcflags)
>>>    CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/display_mode_lib.o := $(dml_rcflags)
>>>    CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dsc/rc_calc_fpu.o  := $(dml_rcflags)
>>> -endif
>>> +CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn10/dcn10_fpu.o := $(dml_rcflags)
>>> +CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn20/dcn20_fpu.o := $(dml_rcflags)
>>> +CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn314/display_mode_vba_314.o := $(dml_rcflags)
>>> +CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn314/display_rq_dlg_calc_314.o := $(dml_rcflags)
>>> +CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn314/dcn314_fpu.o := $(dml_rcflags)
>>> +CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn30/dcn30_fpu.o := $(dml_rcflags)
>>> +CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn32/dcn32_fpu.o := $(dml_rcflags)
>>> +CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn321/dcn321_fpu.o := $(dml_rcflags)
>>> +CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn31/dcn31_fpu.o := $(dml_rcflags)
>>> +CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn302/dcn302_fpu.o := $(dml_rcflags)
>>> +CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn303/dcn303_fpu.o := $(dml_rcflags)
>>> +CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/calcs/dcn_calc_math.o := $(dml_rcflags)
>>>    CFLAGS_$(AMDDALPATH)/dc/dml/dml1_display_rq_dlg_calc.o := $(dml_ccflags)
>>>    CFLAGS_$(AMDDALPATH)/dc/dml/display_rq_dlg_helpers.o := $(dml_ccflags)
>>>    CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dml1_display_rq_dlg_calc.o := $(dml_rcflags)
>>
>> lgtm,
>>
>> Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
>>
>> Nathan,
>>
>> If it is ok for you, I can merge this change.
> 
> Yes, this version looks good to me, as the code can no longer be built
> for arm64 when using clang.
> 
> Cheers,
> Nathan

I just merged this patch to amd-staging-drm-next.

Thanks
Siqueira
