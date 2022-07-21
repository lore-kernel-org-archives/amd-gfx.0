Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6D7AC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 21 Jul 2022 19:16:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 15FDD10E148;
	Thu, 21 Jul 2022 19:16:56 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2041.outbound.protection.outlook.com [40.107.92.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E17E10FD8B
 for <amd-gfx@lists.freedesktop.org>; Thu, 21 Jul 2022 19:16:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GmkXCVTYGKvCJpAPv9PhEN8vd/o6BkpGq5K/M4nGToIygCQnAWeWPyoGfxZ9NHZEROLjoNHeEuRk3f3CGN2E1Z/wwGaPAptYWtt+19UBmS8ZbhyB2Ag778lYtLMoDcECvpvuAroXazXkUh6Te+xS+9ELnFl9fArtu3c2asEWteLrdoZbD0DyL7fKF8jbNHsNTm4NZGDeuDZlLqX9j0+NZ2xY+/BBM/c+Kt8nTUROBkeb5wGjHg9OKJNyPcNIMvgQUfGV4fdJq5he874BtFGK+b0xHpBrInf16jGd2i7tptxMX7MNxt32ZF4Y6Qydj5Nk5xPpY8zlgIz0yj4IZ3f8TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ijvdW65OmapnPNFnXretEb1svmEThbJSexpU1me5Au4=;
 b=GKC8n4YYerV5T6e2wkeHNHdQZpnFGPPjKi9S1PVI8mdxHvAn9MH1lK8ca7AZqP723/bMCtm2kcu82CjqTNiaizNHUt3TsED6TAatT7TtKQsFEqWbvJ1A1aNuD6+WQCfLJeXPyOPFc19I2NO0sB8i1lLC3Mt/oauC7H+yQ2DpnDvxENtaGM53nsupJ7t+B+jqmZDf2+5C1hdu6/k4BkBjbW6GUwCzFzKjJmgg10cieHK3vwIZACIxD+9mS6+6znlZGY/VTR8j92Ulh48eZfGKRTwYssF5KdkZ4chvd8W1GqjY9KNGbYK8gEfjbvlD2osIhADy/k8qlrSbTJESlGjLRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ijvdW65OmapnPNFnXretEb1svmEThbJSexpU1me5Au4=;
 b=ZugElvsnl4n7pd4wSyMNL3ZIbfxovg3eyoIk5ZwVNLTRIjFyGCEJGzBjlw1e9EXBThq1pNFAreHtiBruQRA9qw2F5kneFPmiFJLk3WLmuuE1Fls9sv5zAtV50rhq06VDopUZiuTDiFYR7KZLQJquaQGZX7tk6rFgiuB4SdBj+Vg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB2941.namprd12.prod.outlook.com (2603:10b6:208:a9::12)
 by MWHPR12MB1501.namprd12.prod.outlook.com (2603:10b6:301:f::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.21; Thu, 21 Jul
 2022 19:16:50 +0000
Received: from MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::d122:1dae:8445:2e43]) by MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::d122:1dae:8445:2e43%7]) with mapi id 15.20.5438.023; Thu, 21 Jul 2022
 19:16:49 +0000
Message-ID: <db744035-a588-3a32-0903-4274ad7b645f@amd.com>
Date: Thu, 21 Jul 2022 15:16:48 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 5/5] drm/amd/display: move FPU code from dcn301 clk mgr to
 DML folder
Content-Language: en-US
To: amd-gfx@lists.freedesktop.org
References: <20220720193208.1131493-1-mwen@igalia.com>
 <20220720193208.1131493-6-mwen@igalia.com>
 <158dc220-3901-26fc-2f51-ebcecc091e17@riseup.net>
From: Rodrigo Siqueira Jordao <Rodrigo.Siqueira@amd.com>
In-Reply-To: <158dc220-3901-26fc-2f51-ebcecc091e17@riseup.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0202.namprd03.prod.outlook.com
 (2603:10b6:610:e4::27) To MN2PR12MB2941.namprd12.prod.outlook.com
 (2603:10b6:208:a9::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b5b51105-fcd0-4669-8777-08da6b4d8fe6
X-MS-TrafficTypeDiagnostic: MWHPR12MB1501:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q8dfMW1upziTwnJOAMpGfaPPHxGmV/psr4OVQOaUnNrqGpNgvF1ALTpBDzm93L3LwnEf7mTE2RHRDJE9MJPG19GxKZxJl7EY7PedHl6kCigSNcDhuvZjPxpgjDekaRn/JrxaPBUCnjh7Daik7+WdZldRu7vVvQTjpPI9tmgF3hUTpb8t/wcy8HXlAj9hxGm6HStdX0u5K57iNSIG9SHW2MaObwAET8KNCEqmTBS+qEUE/MIKaYhVB9ZetKZusXJOZLpHflk7KmIXajQdCyoUs1csC5Weolb9kbh6YZd5RJsXrdDyPq9NC0DyQhyPPqWCZGAkBDwxtoSUdpZ+erLedvivf1tGVk3CTA9+M+cLxykyehcpfU61/+ECC6LNSzL5XM4UHEuTxQAfxC0FhjdbNT8y4DlqeIZ+qOgQ3aEeLFlmk4Vp8CV+fdjW8WdTUVBssZIE21jlh1pq9HFOs6wopLM8gQZb6fyBwahwqTGaLvcAau44Dg7E9npRWk9lK5xLms3BFOZQFdti6rhjhB6rs0i0HPuz2pi0cdbtJ2Qz14ihuz+WaCXAGxHMdha0R34KlgY5328oWFzR3UfPHw4HHxa847YVWkes+2nu9XSQqi0VU6npAIpKod/ylOVI+KM+qLVo1VPqyevwyDqfzVphw78G5NHMTjBPChAT7E+29e80Hqh3T0ehe7fmZAVagfzpXM8gbf56853Z1qVghJA+FLkhsnfMeP8b0MVR2wZ9Krt99OvYqAGFhV8eyKt0J3mJqFT/NQta2h4LflBLgyLOCsnTeqJUtQ1jyb7tmvg4ryR3cWUEi3pQb9/s366JjOQgpP4S7iqbQLNKsInnjr1JYQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB2941.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(376002)(396003)(39860400002)(136003)(366004)(5660300002)(8936002)(66946007)(66476007)(66556008)(6512007)(8676002)(2906002)(31696002)(83380400001)(86362001)(38100700002)(478600001)(6486002)(316002)(6916009)(53546011)(36756003)(186003)(2616005)(31686004)(66574015)(41300700001)(26005)(6506007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SStvUVNTaVlUZkh4dnJXeVE3cnRzaUQrY0M2QjUwZFFVR2U5bFRxS2lweVFG?=
 =?utf-8?B?YWdIUnF1VlRwYkFZc2EyUVJ4NzE5b2VCU2hGaStyM2J5RUxWdlc5TEx6RGRi?=
 =?utf-8?B?MEpBZlBUMEV2MXFxdkJIa3pVMGptUFV2OTEvVDM4SUExYTZHZCttNGNVVXZN?=
 =?utf-8?B?Q0pZMzgrVUJ1bHF2QkNRTlI4RnZZcUlITUR2MHZzTXdpVDluSkpWbTIvYlEz?=
 =?utf-8?B?cU9kOU1mbjM2ck14eHdVdlM1ZVZ1b3VCdmNDcFFERWRvMmlUZk9YUzZwUE9D?=
 =?utf-8?B?VmN5WHJtVjdnUHF5R3pTa01leHVZMFVGcTU5NTNzSVZFR3k3ZUkxeVRCSjAv?=
 =?utf-8?B?ci9jVzdUSmU4eWpSNGJZYURma3hVN01Ecm5xUGowVmZncEx2REt0bHlzNCtn?=
 =?utf-8?B?SDdvRk5ZNUhOaVBhT3FXalU5NGlVRk50TGZYZDlaKzZGUHhBS0pKTERZQ2F2?=
 =?utf-8?B?YmZwRUlxZU4zQzcxYngwamdna1BueC9Zb0puZGp2VjVaWlNMRS9RS01DV0J6?=
 =?utf-8?B?cGpHL2R6NFUrcWpjbUZxRFVJWk9aTStpYXlVWTZib3dRZHRrTzJxQmowZlN3?=
 =?utf-8?B?cEVaT0ZpYjJEQVJaVkEraitnZWpadVBZTFhvaG5iYnpXYUdWVmtnNjRQUGpC?=
 =?utf-8?B?b3l3RlhDeGFld3JtQk1kVWRYWWFoYUhyMFR1NEhXc0ZkRDdQZko1cFpiWUd1?=
 =?utf-8?B?K0p0VmQ0cFJuWGxRTE5BaGs0QisrelJnUjNpenRWREJRRWcvYjEyVWN4U2tH?=
 =?utf-8?B?UnNCQUI1ZHFXS0NvWExFMHFyRUpUOEk0dzNNc0dUMS8wSFUxd0xYTzhsQ05l?=
 =?utf-8?B?QjgrVjlaeHVqbldkMDkvQWRFN1JuQUJyd0htRHdmd215bmFSVGh2ZVhmS1p5?=
 =?utf-8?B?N3VUQkNZZmd1dWJLd0hSSzBCNGpmS25QcE1KVDJIY3lKMkJEQWduVUZtQVVr?=
 =?utf-8?B?YWU3RnZTTElWcGg2bll2ZGVJcktLM3NzeXF3WHN2MTFRZmMwTmRRdS91REZ6?=
 =?utf-8?B?ZzB0UUZxTll5L1NHajVDejdta0hGV2FIa2ZHdlFITjZlSHQ1U0xEZGRtODZF?=
 =?utf-8?B?bm5meXU1WEFrRVNITE9wbERUd3p4SnA3dHJCRXpVWGV0N0NsbkljSzBkRW5x?=
 =?utf-8?B?VHNSWDBTVElTUml6bWRYUm5pZWlrRkQyVjhiWEhKSlYybkJaYmwxWExHd0U1?=
 =?utf-8?B?MHpudE5qWmp1NGtkUGYwaks0ZGduVjVjbEkrdUlYZk42QXFCQnV0TWtzb2JR?=
 =?utf-8?B?OGIxZ3NoTUMvUGhuQ2NkYUc1OHAvekVLMDZIZ0YvTkgyYURvTncxSEkzL0d6?=
 =?utf-8?B?MXAzdGVFdDVldUZKSklTVDVSd0Q0dkFJbm10OXhFQ25tbW5KMitpRTJoOGt6?=
 =?utf-8?B?aVo4SmVUL1AwWlUzZExYWmdQMlRPRFJUV3BUQlBMS3JWZW9CRmpuMStNOUt3?=
 =?utf-8?B?N3FZQzRTUnh5M3IvaXJFY2J3eTBaYzFBaDViMXFmUnM1aHorUi9iOHdzdGF5?=
 =?utf-8?B?bnpFYndBVFY4bmZ4K1hwdEdHZmdHMFJGeGdEYU4vVEpjMnd6THgvMEg3ankv?=
 =?utf-8?B?bmV0elZzMnRXaEpLOUU0Tmt5ZEw0YWg3VTIzeGFGeXdnb2txQTI1QXJXNkhj?=
 =?utf-8?B?TEFKVkE0cVNDd003TXc4WnN6dHZwS1dITUpMcWlwZWJSVXQwRDFieEhIU1hD?=
 =?utf-8?B?N1p6dzlmdzViN0hQdzBsS1IrSTYreHhrY2RhbmV1SW1NOUF4NElqa0dEVklM?=
 =?utf-8?B?RGZKbyt4V2hucWtaR1FCTmREYzVJK3dPVDh5SUJtUFpGUXM5bC9QTkZ4aTlo?=
 =?utf-8?B?TzM3YzlpM0NveTY5L3RDS3QzSnBpRm1zaFJCWWJiN0NDQnBaYnU5Vk5BUTI3?=
 =?utf-8?B?QXN0K0lJS1Awa0ZuQU5pa0VJakh0VXBvM3BoMlFId3poWWdUUEhRLzlicE1P?=
 =?utf-8?B?K1R0bnFNY09zQTlCbkZQNkVhV2VlcnZyblhTQ21DN3l6WnJoc1Y1RTJQNUJS?=
 =?utf-8?B?RWNHWXpnY25LWEdNRUE2YUxmbUJXbVdnaCtWZFJvZXVHQUlDNUk3dDBTd200?=
 =?utf-8?B?Q0lNbFAzekp1WTZXQitwdzY3RE9BQ1JCMERhQ0lMYndKalU0YmI0b3FoenMx?=
 =?utf-8?Q?tMiziV5Uj8uNe6ixRMZWy3kYq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5b51105-fcd0-4669-8777-08da6b4d8fe6
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB2941.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2022 19:16:49.8812 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2kGXUsm6JrUNhtmAB+5JN3PyzQAyvTSEmUr62sftJ8p74Roaq16XHQsY81ES1I7vuru34LPB0Ya/k5iDc/52hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1501
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



On 2022-07-21 13:26, Maíra Canal wrote:
> Hi Melissa,
> 
> On 7/20/22 16:32, Melissa Wen wrote:
>> The -mno-gnu-attribute option in dcn301 clk mgr makefile hides a soft vs
>> hard fp error for powerpc. After removing this flag, we can see some FPU
>> code remains there:
>>
>> gcc-11.3.0-nolibc/powerpc64-linux/bin/powerpc64-linux-ld:
>> drivers/gpu/drm/amd/amdgpu/../display/dc/dml/display_mode_lib.o uses
>> hard float,
>> drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn301/vg_clk_mgr.o
>> uses soft float
>>
>> Therefore, remove the -mno-gnu-attribute flag for dcn301/powerpc and
>> move FPU-associated code to DML folder.
>>
>> Signed-off-by: Melissa Wen <mwen@igalia.com>
>> ---
>>   .../gpu/drm/amd/display/dc/clk_mgr/Makefile   |  6 --
>>   .../display/dc/clk_mgr/dcn301/vg_clk_mgr.c    | 86 ++-----------------
>>   .../display/dc/clk_mgr/dcn301/vg_clk_mgr.h    |  3 +
>>   .../amd/display/dc/dml/dcn301/dcn301_fpu.c    | 74 ++++++++++++++++
>>   4 files changed, 84 insertions(+), 85 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile b/drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile
>> index 15b660a951a5..271d8e573181 100644
>> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile
>> +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile
>> @@ -123,12 +123,6 @@ AMD_DISPLAY_FILES += $(AMD_DAL_CLK_MGR_DCN30)
>>   ###############################################################################
>>   CLK_MGR_DCN301 = vg_clk_mgr.o dcn301_smu.o
>>   
>> -# prevent build errors regarding soft-float vs hard-float FP ABI tags
>> -# this code is currently unused on ppc64, as it applies to VanGogh APUs only
>> -ifdef CONFIG_PPC64
>> -CFLAGS_$(AMDDALPATH)/dc/clk_mgr/dcn301/vg_clk_mgr.o := $(call cc-option,-mno-gnu-attribute)
>> -endif
>> -
>>   AMD_DAL_CLK_MGR_DCN301 = $(addprefix $(AMDDALPATH)/dc/clk_mgr/dcn301/,$(CLK_MGR_DCN301))
>>   
>>   AMD_DISPLAY_FILES += $(AMD_DAL_CLK_MGR_DCN301)
>> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c
>> index f310b0d25a07..65f224af03c0 100644
>> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c
>> +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.c
>> @@ -32,6 +32,10 @@
>>   // For dcn20_update_clocks_update_dpp_dto
>>   #include "dcn20/dcn20_clk_mgr.h"
>>   
>> +// For DML FPU code
>> +#include "dml/dcn20/dcn20_fpu.h"
>> +#include "dml/dcn301/dcn301_fpu.h"
>> +
> 
> I guess the "dml/dcn301/dcn301_fpu.h" header is not needed, as you only
> use dcn21_clk_mgr_set_bw_params_wm_table and the structs are on the
> source file.
> 
> Besides that, to the whole series:
> Reviewed-by: Maíra Canal <mairacanal@riseup.net>
> 
> Best Regards,
> - Maíra Canal

Nice catch!
I'll make this adjustment before I merge it.

Thanks
Siqueira

> 
>>   #include "vg_clk_mgr.h"
>>   #include "dcn301_smu.h"
>>   #include "reg_helper.h"
>> @@ -526,81 +530,6 @@ static struct clk_bw_params vg_bw_params = {
>>   
>>   };
>>   
>> -static struct wm_table ddr4_wm_table = {
>> -	.entries = {
>> -		{
>> -			.wm_inst = WM_A,
>> -			.wm_type = WM_TYPE_PSTATE_CHG,
>> -			.pstate_latency_us = 11.72,
>> -			.sr_exit_time_us = 6.09,
>> -			.sr_enter_plus_exit_time_us = 7.14,
>> -			.valid = true,
>> -		},
>> -		{
>> -			.wm_inst = WM_B,
>> -			.wm_type = WM_TYPE_PSTATE_CHG,
>> -			.pstate_latency_us = 11.72,
>> -			.sr_exit_time_us = 10.12,
>> -			.sr_enter_plus_exit_time_us = 11.48,
>> -			.valid = true,
>> -		},
>> -		{
>> -			.wm_inst = WM_C,
>> -			.wm_type = WM_TYPE_PSTATE_CHG,
>> -			.pstate_latency_us = 11.72,
>> -			.sr_exit_time_us = 10.12,
>> -			.sr_enter_plus_exit_time_us = 11.48,
>> -			.valid = true,
>> -		},
>> -		{
>> -			.wm_inst = WM_D,
>> -			.wm_type = WM_TYPE_PSTATE_CHG,
>> -			.pstate_latency_us = 11.72,
>> -			.sr_exit_time_us = 10.12,
>> -			.sr_enter_plus_exit_time_us = 11.48,
>> -			.valid = true,
>> -		},
>> -	}
>> -};
>> -
>> -static struct wm_table lpddr5_wm_table = {
>> -	.entries = {
>> -		{
>> -			.wm_inst = WM_A,
>> -			.wm_type = WM_TYPE_PSTATE_CHG,
>> -			.pstate_latency_us = 11.65333,
>> -			.sr_exit_time_us = 13.5,
>> -			.sr_enter_plus_exit_time_us = 16.5,
>> -			.valid = true,
>> -		},
>> -		{
>> -			.wm_inst = WM_B,
>> -			.wm_type = WM_TYPE_PSTATE_CHG,
>> -			.pstate_latency_us = 11.65333,
>> -			.sr_exit_time_us = 13.5,
>> -			.sr_enter_plus_exit_time_us = 16.5,
>> -			.valid = true,
>> -		},
>> -		{
>> -			.wm_inst = WM_C,
>> -			.wm_type = WM_TYPE_PSTATE_CHG,
>> -			.pstate_latency_us = 11.65333,
>> -			.sr_exit_time_us = 13.5,
>> -			.sr_enter_plus_exit_time_us = 16.5,
>> -			.valid = true,
>> -		},
>> -		{
>> -			.wm_inst = WM_D,
>> -			.wm_type = WM_TYPE_PSTATE_CHG,
>> -			.pstate_latency_us = 11.65333,
>> -			.sr_exit_time_us = 13.5,
>> -			.sr_enter_plus_exit_time_us = 16.5,
>> -			.valid = true,
>> -		},
>> -	}
>> -};
>> -
>> -
>>   static unsigned int find_dcfclk_for_voltage(const struct vg_dpm_clocks *clock_table,
>>   		unsigned int voltage)
>>   {
>> @@ -670,10 +599,9 @@ static void vg_clk_mgr_helper_populate_bw_params(
>>   		/*
>>   		 * WM set D will be re-purposed for memory retraining
>>   		 */
>> -		bw_params->wm_table.entries[WM_D].pstate_latency_us = LPDDR_MEM_RETRAIN_LATENCY;
>> -		bw_params->wm_table.entries[WM_D].wm_inst = WM_D;
>> -		bw_params->wm_table.entries[WM_D].wm_type = WM_TYPE_RETRAINING;
>> -		bw_params->wm_table.entries[WM_D].valid = true;
>> +		DC_FP_START();
>> +		dcn21_clk_mgr_set_bw_params_wm_table(bw_params);
>> +		DC_FP_END();
>>   	}
>>   
>>   }
>> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.h b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.h
>> index 7255477307f1..75884f572989 100644
>> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.h
>> +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn301/vg_clk_mgr.h
>> @@ -29,6 +29,9 @@
>>   
>>   struct watermarks;
>>   
>> +extern struct wm_table ddr4_wm_table;
>> +extern struct wm_table lpddr5_wm_table;
>> +
>>   struct smu_watermark_set {
>>   	struct watermarks *wm_set;
>>   	union large_integer mc_address;
>> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn301/dcn301_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn301/dcn301_fpu.c
>> index e4863f0bf0f6..7ef66e511ec8 100644
>> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn301/dcn301_fpu.c
>> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn301/dcn301_fpu.c
>> @@ -214,6 +214,80 @@ struct _vcs_dpi_soc_bounding_box_st dcn3_01_soc = {
>>   	.urgent_latency_adjustment_fabric_clock_reference_mhz = 0,
>>   };
>>   
>> +struct wm_table ddr4_wm_table = {
>> +	.entries = {
>> +		{
>> +			.wm_inst = WM_A,
>> +			.wm_type = WM_TYPE_PSTATE_CHG,
>> +			.pstate_latency_us = 11.72,
>> +			.sr_exit_time_us = 6.09,
>> +			.sr_enter_plus_exit_time_us = 7.14,
>> +			.valid = true,
>> +		},
>> +		{
>> +			.wm_inst = WM_B,
>> +			.wm_type = WM_TYPE_PSTATE_CHG,
>> +			.pstate_latency_us = 11.72,
>> +			.sr_exit_time_us = 10.12,
>> +			.sr_enter_plus_exit_time_us = 11.48,
>> +			.valid = true,
>> +		},
>> +		{
>> +			.wm_inst = WM_C,
>> +			.wm_type = WM_TYPE_PSTATE_CHG,
>> +			.pstate_latency_us = 11.72,
>> +			.sr_exit_time_us = 10.12,
>> +			.sr_enter_plus_exit_time_us = 11.48,
>> +			.valid = true,
>> +		},
>> +		{
>> +			.wm_inst = WM_D,
>> +			.wm_type = WM_TYPE_PSTATE_CHG,
>> +			.pstate_latency_us = 11.72,
>> +			.sr_exit_time_us = 10.12,
>> +			.sr_enter_plus_exit_time_us = 11.48,
>> +			.valid = true,
>> +		},
>> +	}
>> +};
>> +
>> +struct wm_table lpddr5_wm_table = {
>> +	.entries = {
>> +		{
>> +			.wm_inst = WM_A,
>> +			.wm_type = WM_TYPE_PSTATE_CHG,
>> +			.pstate_latency_us = 11.65333,
>> +			.sr_exit_time_us = 13.5,
>> +			.sr_enter_plus_exit_time_us = 16.5,
>> +			.valid = true,
>> +		},
>> +		{
>> +			.wm_inst = WM_B,
>> +			.wm_type = WM_TYPE_PSTATE_CHG,
>> +			.pstate_latency_us = 11.65333,
>> +			.sr_exit_time_us = 13.5,
>> +			.sr_enter_plus_exit_time_us = 16.5,
>> +			.valid = true,
>> +		},
>> +		{
>> +			.wm_inst = WM_C,
>> +			.wm_type = WM_TYPE_PSTATE_CHG,
>> +			.pstate_latency_us = 11.65333,
>> +			.sr_exit_time_us = 13.5,
>> +			.sr_enter_plus_exit_time_us = 16.5,
>> +			.valid = true,
>> +		},
>> +		{
>> +			.wm_inst = WM_D,
>> +			.wm_type = WM_TYPE_PSTATE_CHG,
>> +			.pstate_latency_us = 11.65333,
>> +			.sr_exit_time_us = 13.5,
>> +			.sr_enter_plus_exit_time_us = 16.5,
>> +			.valid = true,
>> +		},
>> +	}
>> +};
>> +
>>   static void calculate_wm_set_for_vlevel(int vlevel,
>>   		struct wm_range_table_entry *table_entry,
>>   		struct dcn_watermarks *wm_set,

