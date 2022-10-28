Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF076FA3746
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Oct 2022 15:35:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F83210E852;
	Fri, 28 Oct 2022 15:35:44 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2068.outbound.protection.outlook.com [40.107.95.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF0F710E852
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Oct 2022 15:35:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=URmAXmHTqnzujkv3iJxV5VjcoR/Ikqm16ZhKZbAIfQerYTkc1sBFprzYQCiHgKojytnntvjk3vjCRkYiiXTLwAzoSdubnKugRPgQLwJ+1WLuvNQOTsv0/ecoucKfLXd5T2pe+eXuj0EmxfzR2zFBNvVk/gtN80cVE0dizJvVAYu7VW5oMeLUnzgIJLeGgy4GN2GjAWawr6VPAsPv6MJotdS6HGnF7RUJvBzLyK1L7YFH0Fs4wXxFujG3jFscTlWIIWq3AewRc0eieuT4ffJX4gyz9HWO4SG9alsMjsk3RAIpOXcbOYHHezk6rzHTSvF2jZ8L+PW2jRJ7hLH20faIyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=19DGh5SMjqVuhetd3SHmGwb9jxIyr7OXsjGvJrsrqOU=;
 b=TA7a8nNrQsmqQ5jebmSgrugngy0AerBhaulYdZ2TrV15C03T2WqGlL5e5M8j19LYEpf4+RCj2qaxPk6eSg04r+neEIKbNN726Tno9gxc/v2DIm+LWhAi5uzpbTC3PWNYD8dCyCC25GQvqRahUlN/8XtNpH7/LSix+wPOiOQHopf0VQKkm6BQArddyCGyF5tVdExA845agkfGZ42VTYE4y9YfXdEdXLc3SeTKwOBABzYef5SfaUskZMQM+W98dIYisODT1XYSqwB9NfrWFBRUX2SYmLzxOJDtBJlLdFSRi0+jdM3Yt1piAt5OqxS0eVI82Chm0Mt0ocIdSnxnzdDIFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=19DGh5SMjqVuhetd3SHmGwb9jxIyr7OXsjGvJrsrqOU=;
 b=KsWbRqdD8jMNeLg6K+fQIyd47sMLeTIuTtbKczjqXbzAQFdwawahdELktrEC4pRBkff0zsYjQLeDbDCh1hQUvUhUjc4UCRJcNzDH+BUc5NCS9WYhLXXi07WGKU7qOzgRVlWCb0M7XUQTcHu2NyRig0tBMQYoagbLn7uSCoocT2s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB2941.namprd12.prod.outlook.com (2603:10b6:208:a9::12)
 by CH0PR12MB5028.namprd12.prod.outlook.com (2603:10b6:610:e3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.15; Fri, 28 Oct
 2022 15:35:34 +0000
Received: from MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::588f:c941:4f62:9d89]) by MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::588f:c941:4f62:9d89%3]) with mapi id 15.20.5769.015; Fri, 28 Oct 2022
 15:35:34 +0000
Message-ID: <f31b8573-336a-dd0b-1628-d60066ce533c@amd.com>
Date: Fri, 28 Oct 2022 11:35:32 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v3 1/1] drm/amd/display: add DCN support for ARM64
To: Nathan Chancellor <nathan@kernel.org>, Ao Zhong <hacc1225@gmail.com>
References: <20221027195227.5312-1-hacc1225@gmail.com>
 <20221027195227.5312-2-hacc1225@gmail.com>
 <Y1vwk3J3HPGugBJO@dev-arch.thelio-3990X>
Content-Language: en-US
From: Rodrigo Siqueira Jordao <Rodrigo.Siqueira@amd.com>
In-Reply-To: <Y1vwk3J3HPGugBJO@dev-arch.thelio-3990X>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR08CA0006.namprd08.prod.outlook.com
 (2603:10b6:208:239::11) To MN2PR12MB2941.namprd12.prod.outlook.com
 (2603:10b6:208:a9::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB2941:EE_|CH0PR12MB5028:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b8c124e-7221-4f39-e95f-08dab8fa0dee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LG7OrquucT+UtlVTY9y/VQglKP6dX+Klg9OtJ6ADdQIrTgDdT9B4g+Z5JwwJeU6c1qnd2I5HVGtEoK19y0I7hx6I1eNNkLsgI46hTxn88l75wHIcF9WfTDMSK+QKvccS4PQLFv1Y75sY3lVbB/2fUC0eVv9TFwXJ3oegboIYSSmwU0B2IxjrTPUzaGR7hqofv/hV4Ra3aChXT0VstcNbweQLzkieajMTFHJxmmSl1If5oCBS5hMWDy2KgVvso+yxJyOrO7m2zrENIV5DR7ymm3cHkTV44Zo6zzoiN4elNnx9zvadCHKVYgGWLSBDa8M4spvaoUzjaTuJEhPa7DGCWz1TnwvIOamOFfqkqQ++XKyPniUZ95mSQUbAfPR02s3/kS0nZB9LG1U5ftd3BhxQ1Thp0NT8BKleENKr0bcxAhkkfNVjoH0gBgtLRl7vUVhVYH6CFSJwYxAjNjkbheN0QeAgoGDVm9b/hiLpG//sKvP4Sto09F9EOI0jf8kAwG0jzfWfKi5VIGp6hFr0eQNKT+q9EF82m3Pv+OQGau+oeuOuIZMydSzHkqI/BrJxnHoCBZbrryJfhFWaNf7TYVwCkpBmo0bcnv5uyiSbcLM1Es41r6ZVjVzJ2MgBIe20A1Q8zgI3DBucWkCq++pJOl8mN0D29LcqurAQvqxDrGbqf/DYUUGJvQXjen4bfnqR7OG1E3aalBuj83YLM/GQ3QOqr1ELO2PAvToH0RhuSjXwY9DFgRD1vRJ9iR8mv97HfRXY
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB2941.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(396003)(39860400002)(136003)(366004)(376002)(451199015)(31686004)(6486002)(478600001)(83380400001)(110136005)(54906003)(30864003)(966005)(8676002)(36756003)(2616005)(6506007)(4326008)(38100700002)(316002)(66476007)(66556008)(66946007)(6512007)(2906002)(53546011)(31696002)(8936002)(5660300002)(26005)(41300700001)(86362001)(4001150100001)(186003)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WU8za3F2a28vUEV3d1ZKazlGRm9JbjlwU2RNbTlmTFROeGJiODNxY1hRZFB0?=
 =?utf-8?B?SXNrcUIvVFBvOENqYUNEdDlaNTNUZ0VyMmxlem9tT1pMQWtqNGNHd3BpSGE0?=
 =?utf-8?B?SlE0bzY0VmtXMVJQaUtYVDVCUHd5Y0JGWk5xTzFPUVlsaHRYRXowR0ZVQ2gx?=
 =?utf-8?B?TnlDeE1GRFhHQkpqWGcvQkY1SDR2L1dETzlLaFN1ZHRJWmdFYTlKRGk2NHRx?=
 =?utf-8?B?aitOVWJwYlpybWNvbDY2WFlaVjh6OVNKTDNiQ3l2cVhTS1JOcEdhSW00S3Uv?=
 =?utf-8?B?Sm0xbjlHbCtpTWdsWFdudXBpb1A0dWVkejJ2SnQ0R2FVZWU1L25jK0lGY1hR?=
 =?utf-8?B?QzJPMWdwVGlTM05SMmx2QmtxV2dRNzF6YVgxUFljaEp1ZmpsMEdwTmcwTW5P?=
 =?utf-8?B?KzV3TWkyUGhGR2JlZGxrNlY1YnNNR2RuaTR6STNXZUhsUldoa0hzdGpoNEVH?=
 =?utf-8?B?NHI3STBZK04zTjRRc1Qva1NnUmpzQThtcTFJVC9XTk1GNEZLVVRrUXR0YlRa?=
 =?utf-8?B?M3RqeFhQT0lJdU04ZThwRnZESVNBZ1lSWlNGdHVRYURIRm1aMUVtdklrZzFR?=
 =?utf-8?B?RlhkY1piSE9xa3JJdHNsQmRMVmdtMlFtSjVsZWkyUUdUcW1wNDE5T1hOUncv?=
 =?utf-8?B?UXhaUTZVR0tIMzdSZ0Ztd2Yyc0wwTDNLNldQVGR2eGZqQ1ZLcjhMUXp6KzNv?=
 =?utf-8?B?VGIvM2gzNWlBRTBDYjZjcU5ST3lJd1NHSnFoT050ZmVWZTF2dnNyQWhvQTJV?=
 =?utf-8?B?U1FJNC9sRlRkVmVQU3M2TU51Rnh3a1BoT3RoczFSWlZDRCt1d3lhUkxhMTlv?=
 =?utf-8?B?WG5GYjZJSWhMUE1XNFp6aitjNUJZSExDZEhPZlNadjh1MzR0Tm0rSWx1YUNS?=
 =?utf-8?B?TmxEY3o3ZmlVS0ViUE9jRUhHemY4ZWxObDY2T3A5LzFpcTNDK1RTV1VXcGty?=
 =?utf-8?B?bC9wczVUVGpVenFCaWpXOTY2N3FzeGZqSlROanJDL3haMmxOMEc1TUR6blor?=
 =?utf-8?B?eU5ab212clJqN1VOK2dTUTF1SGVzVGJBbFNmVXlFOWpqL2cvcjRDMXV1Rndv?=
 =?utf-8?B?LzMrZmhmc2J2QnRWbGl1RWtMN3g4NlE4dmh6WGpiSUF1OUd2TVlnbzN1dWFv?=
 =?utf-8?B?QTRCZkhISENvZkFMeU9PZ2RDdm9EMnVqTmg5WVdYRFh3NDRUZDBZNXEyTVZN?=
 =?utf-8?B?eU5KdkxpNVlPSDBWYnZUSkdSTE1rYWpNRTJZZFFEdnAyR1NIRXc2VGdtUlhq?=
 =?utf-8?B?QkJhSjhkdGMxM21LSkRXYmE5bG9zSmVvM1ZGU2dIYTlVbkp1OENXQXM2Z1h3?=
 =?utf-8?B?MW81QysrWHo2ZzUrTmJ5OXA4cEczTUxDRmZuY2VnaHFNWnExeVFrWXloUHJE?=
 =?utf-8?B?aFhrRWZVc2tqRVEzb04wc0FSOGpLbkhwY2hISEd6WDdUVXMvN3pUUHNIYm1Z?=
 =?utf-8?B?eFl0YUtPY3lYMU9Xb2kxVzRPcE0xSUgyV0x0YnlYalZmejgvQnJnOEswYzlH?=
 =?utf-8?B?OFFtaWk4OFlJYVlKdHMrWEljTTlKNlIrdUs5SU9QYzJRZ1RUUGZibmVZUVpY?=
 =?utf-8?B?NDkyRmtyc0M4bll6eFBQMG1iUGpNQk15TWt4dzdaUHRrK1BjR0JlV2tQcXZr?=
 =?utf-8?B?STEvZzlYNUZod0xBYzVDaWltTmF6SzFUSHlsZGpFZHZkODFYVnpkQUZ3eE15?=
 =?utf-8?B?R0VxQjZvKy9qelZRMnM0Yk1OZmNLQzFIY24wbDh5T3ZxYTZmcUppbU1DTUJk?=
 =?utf-8?B?M0pZdzJWTXZnZzFSU0huZFQwM3pTalI4UTFuVnVpZGZxaFo5VzhrRkpNMzJp?=
 =?utf-8?B?eXJlSE51V1M3RGFyaTBFVE1rWUtib3lZS3hpYmlhREhhQmlBMG5zaVRUeHV3?=
 =?utf-8?B?VXNzTzdCQkluQ1BHdlhCSTVsKzUrYzBDRFVETUh0R2JlTGVzZjZDQWY2dm9C?=
 =?utf-8?B?ZTdOVmw2SHJldnRZaVZSeHU4MEhrSkFFcnFvQUZqcFp2amdQc2toNEpVWFRH?=
 =?utf-8?B?ZXoxYWNrT3RrSG9pcFk1aHJQa0NqRTQwNEw1Y2JocFZpT0F3eExKUVh0Nm5n?=
 =?utf-8?B?Yjk1dU1mKzFrZStYU0piQkU1VEE0ZldmRXViVDRSR3FZYjAwRFNXRUM0V1pN?=
 =?utf-8?Q?Vb738Typ/tApFAQK5Ik5K/49w?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b8c124e-7221-4f39-e95f-08dab8fa0dee
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB2941.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2022 15:35:34.3473 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aZrqxLjYQ/3dulMATjL8+uwvh4Xihxh1DvszvjONT0Txe/Z2vArqn4TE0kkB9BIQPvRqR74toCWrLEhGIEjNYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5028
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
 Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 linux-arm-kernel@lists.infradead.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 2022-10-28 11:09, Nathan Chancellor wrote:
> Hi Ao,
> 
> On Thu, Oct 27, 2022 at 09:52:29PM +0200, Ao Zhong wrote:
>> After moving all FPU code to the DML folder, we can enable DCN support
>> for the ARM64 platform. Remove the -mgeneral-regs-only CFLAG from the
>> code in the DML folder that needs to use hardware FPU, and add a control
>> mechanism for ARM Neon.
>>
>> Signed-off-by: Ao Zhong <hacc1225@gmail.com>
>> ---
>>   drivers/gpu/drm/amd/display/Kconfig           |  2 +-
>>   .../gpu/drm/amd/display/amdgpu_dm/dc_fpu.c    |  6 ++++++
>>   drivers/gpu/drm/amd/display/dc/dml/Makefile   | 20 +++++++++++++++----
>>   3 files changed, 23 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/display/Kconfig b/drivers/gpu/drm/amd/display/Kconfig
>> index 0142affcdaa3..a7f1c4e51719 100644
>> --- a/drivers/gpu/drm/amd/display/Kconfig
>> +++ b/drivers/gpu/drm/amd/display/Kconfig
>> @@ -6,7 +6,7 @@ config DRM_AMD_DC
>>   	bool "AMD DC - Enable new display engine"
>>   	default y
>>   	select SND_HDA_COMPONENT if SND_HDA_CORE
>> -	select DRM_AMD_DC_DCN if (X86 || PPC64)
>> +	select DRM_AMD_DC_DCN if (X86 || PPC64 || (ARM64 && KERNEL_MODE_NEON))
>>   	help
>>   	  Choose this option if you want to use the new display engine
>>   	  support for AMDGPU. This adds required support for Vega and
>> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c b/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c
>> index ab0c6d191038..1743ca0a3641 100644
>> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c
>> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c
>> @@ -31,6 +31,8 @@
>>   #elif defined(CONFIG_PPC64)
>>   #include <asm/switch_to.h>
>>   #include <asm/cputable.h>
>> +#elif defined(CONFIG_ARM64)
>> +#include <asm/neon.h>
>>   #endif
>>   
>>   /**
>> @@ -99,6 +101,8 @@ void dc_fpu_begin(const char *function_name, const int line)
>>   			preempt_disable();
>>   			enable_kernel_fp();
>>   		}
>> +#elif defined(CONFIG_ARM64)
>> +		kernel_neon_begin();
>>   #endif
>>   	}
>>   
>> @@ -136,6 +140,8 @@ void dc_fpu_end(const char *function_name, const int line)
>>   			disable_kernel_fp();
>>   			preempt_enable();
>>   		}
>> +#elif defined(CONFIG_ARM64)
>> +		kernel_neon_end();
>>   #endif
>>   	}
>>   
>> diff --git a/drivers/gpu/drm/amd/display/dc/dml/Makefile b/drivers/gpu/drm/amd/display/dc/dml/Makefile
>> index d0c6cf61c676..d4e93bed1c8e 100644
>> --- a/drivers/gpu/drm/amd/display/dc/dml/Makefile
>> +++ b/drivers/gpu/drm/amd/display/dc/dml/Makefile
>> @@ -33,6 +33,10 @@ ifdef CONFIG_PPC64
>>   dml_ccflags := -mhard-float -maltivec
>>   endif
>>   
>> +ifdef CONFIG_ARM64
>> +dml_rcflags := -mgeneral-regs-only
>> +endif
>> +
>>   ifdef CONFIG_CC_IS_GCC
>>   ifeq ($(call cc-ifversion, -lt, 0701, y), y)
>>   IS_OLD_GCC = 1
>> @@ -55,8 +59,6 @@ frame_warn_flag := -Wframe-larger-than=2048
>>   endif
>>   
>>   CFLAGS_$(AMDDALPATH)/dc/dml/display_mode_lib.o := $(dml_ccflags)
>> -
>> -ifdef CONFIG_DRM_AMD_DC_DCN
>>   CFLAGS_$(AMDDALPATH)/dc/dml/display_mode_vba.o := $(dml_ccflags)
>>   CFLAGS_$(AMDDALPATH)/dc/dml/dcn10/dcn10_fpu.o := $(dml_ccflags)
>>   CFLAGS_$(AMDDALPATH)/dc/dml/dcn20/dcn20_fpu.o := $(dml_ccflags)
>> @@ -88,7 +90,6 @@ CFLAGS_$(AMDDALPATH)/dc/dml/calcs/dcn_calcs.o := $(dml_ccflags)
>>   CFLAGS_$(AMDDALPATH)/dc/dml/calcs/dcn_calc_auto.o := $(dml_ccflags)
>>   CFLAGS_$(AMDDALPATH)/dc/dml/calcs/dcn_calc_math.o := $(dml_ccflags) -Wno-tautological-compare
>>   CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/display_mode_vba.o := $(dml_rcflags)
>> -CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn2x/dcn2x.o := $(dml_rcflags)
>>   CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn20/display_mode_vba_20.o := $(dml_rcflags)
>>   CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn20/display_rq_dlg_calc_20.o := $(dml_rcflags)
>>   CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn20/display_mode_vba_20v2.o := $(dml_rcflags)
>> @@ -105,7 +106,18 @@ CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn32/display_mode_vba_util_32.o := $(dml_rcf
>>   CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn301/dcn301_fpu.o := $(dml_rcflags)
>>   CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/display_mode_lib.o := $(dml_rcflags)
>>   CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dsc/rc_calc_fpu.o  := $(dml_rcflags)
>> -endif
>> +CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn10/dcn10_fpu.o := $(dml_rcflags)
>> +CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn20/dcn20_fpu.o := $(dml_rcflags)
>> +CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn314/display_mode_vba_314.o := $(dml_rcflags)
>> +CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn314/display_rq_dlg_calc_314.o := $(dml_rcflags)
>> +CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn314/dcn314_fpu.o := $(dml_rcflags)
>> +CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn30/dcn30_fpu.o := $(dml_rcflags)
>> +CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn32/dcn32_fpu.o := $(dml_rcflags)
>> +CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn321/dcn321_fpu.o := $(dml_rcflags)
>> +CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn31/dcn31_fpu.o := $(dml_rcflags)
>> +CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn302/dcn302_fpu.o := $(dml_rcflags)
>> +CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn303/dcn303_fpu.o := $(dml_rcflags)
>> +CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/calcs/dcn_calc_math.o := $(dml_rcflags)
>>   CFLAGS_$(AMDDALPATH)/dc/dml/dml1_display_rq_dlg_calc.o := $(dml_ccflags)
>>   CFLAGS_$(AMDDALPATH)/dc/dml/display_rq_dlg_helpers.o := $(dml_ccflags)
>>   CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dml1_display_rq_dlg_calc.o := $(dml_rcflags)
>> -- 
>> 2.37.4
>>
> 
> Enabling this code for arm64 reveals the following warnings when
> building allmodconfig with clang. A very recent change in LLVM added the
> variable and spill information so that will not be seen with older
> versions but I also saw the warnings with clang 15.0.0 from Fedora.
> 
>    drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c:1852:13: error: stack frame size (2112) exceeds limit (2048) in 'DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation' [-Werror,-Wframe-larger-than]
>    static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation(
>                ^
>    1152/2112 (54.55%) spills, 960/2112 (45.45%) variables
> 
>    drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_mode_vba_30.c:3542:6: error: stack frame size (2240) exceeds limit (2048) in 'dml30_ModeSupportAndSystemConfigurationFull' [-Werror,-Wframe-larger-than]
>    void dml30_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_lib)
>        ^
>    1451/2240 (64.78%) spills, 789/2240 (35.22%) variables
> 
>    drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn31/display_mode_vba_31.c:3791:6: error: stack frame size (2736) exceeds limit (2048) in 'dml31_ModeSupportAndSystemConfigurationFull' [-Werror,-Wframe-larger-than]
>    void dml31_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_lib)
>        ^
>    1342/2736 (49.05%) spills, 1394/2736 (50.95%) variables
> 
>    drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn314/display_mode_vba_314.c:3890:6: error: stack frame size (2720) exceeds limit (2048) in 'dml314_ModeSupportAndSystemConfigurationFull' [-Werror,-Wframe-larger-than]
>    void dml314_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_lib)
>        ^
>    1325/2720 (48.71%) spills, 1395/2720 (51.29%) variables
> 
>    drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_32.c:59:13: error: stack frame size (2208) exceeds limit (2048) in 'DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation' [-Werror,-Wframe-larger-than]
>    static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation(
>                ^
>    1397/2208 (63.27%) spills, 811/2208 (36.73%) variables
> 
>    drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_32.c:1681:6: error: stack frame size (2496) exceeds limit (2048) in 'dml32_ModeSupportAndSystemConfigurationFull' [-Werror,-Wframe-larger-than]
>    void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_lib)
>        ^
>    1504/2496 (60.26%) spills, 992/2496 (39.74%) variables
> 
> I can try to take a look at these next week, as I have prior obligations
> today, unless others wanted to help me out ;)

Hi Nathan,

Thanks a lot for checking this.

About those stack frame issues, I guess they are generic, right? I mean, 
I don't see why we only see it if we enable arm64.

> Additionally, I see the following errors with GCC 12.2.1 from Fedora
> when building allmodconfig. Seems like some $(dml_rcflags) might be
> missing.
> 
>    drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_resource.c: In function ‘dcn10_resource_construct_fp’:
>    drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_resource.c:1313:52: error: ‘-mgeneral-regs-only’ is incompatible with the use of floating-point types
>    1313 |                 dcn_soc->dram_clock_change_latency = 23;
>          |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~
>    drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_resource.c:1317:45: error: ‘-mgeneral-regs-only’ is incompatible with the use of floating-point types
>    1317 |                 dc->dcn_soc->urgent_latency = 3;
>          |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~
>    drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_resource.c:1319:64: error: ‘-mgeneral-regs-only’ is incompatible with the use of floating-point types
>    1319 |                 dc->dcn_soc->fabric_and_dram_bandwidth_vmax0p9 = 41.60f;
>          |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~
>    drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_resource.c:1329:64: error: ‘-mgeneral-regs-only’ is incompatible with the use of floating-point types
>    1329 |                 dc->dcn_soc->fabric_and_dram_bandwidth_vmax0p9 = 19.2f;
>          |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~
>    drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_resource.c:1330:64: error: ‘-mgeneral-regs-only’ is incompatible with the use of floating-point types
>    1330 |                 dc->dcn_soc->fabric_and_dram_bandwidth_vnom0p8 = 17.066f;
>          |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~
>    drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_resource.c:1331:65: error: ‘-mgeneral-regs-only’ is incompatible with the use of floating-point types
>    1331 |                 dc->dcn_soc->fabric_and_dram_bandwidth_vmid0p72 = 14.933f;
>          |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~
>    drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_resource.c:1332:65: error: ‘-mgeneral-regs-only’ is incompatible with the use of floating-point types
>    1332 |                 dc->dcn_soc->fabric_and_dram_bandwidth_vmin0p65 = 12.8f;
>          |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~
>    drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_resource.c:1334:72: error: ‘-mgeneral-regs-only’ is incompatible with the use of floating-point types
>    1334 |                         dc->dcn_soc->fabric_and_dram_bandwidth_vmax0p9 = 20.80f;
>          |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~
>    make[6]: *** [scripts/Makefile.build:250: drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_resource.o] Error 1
>    drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_resource.c: In function ‘dcn32_populate_dml_pipes_from_context’:
>    drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_resource.c:1921:70: error: ‘-mgeneral-regs-only’ is incompatible with the use of floating-point types
>    1921 |                 pipes[pipe_cnt].pipe.src.dcc_fraction_of_zs_req_luma = 0;
>          |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~
>    drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_resource.c:1922:72: error: ‘-mgeneral-regs-only’ is incompatible with the use of floating-point types
>    1922 |                 pipes[pipe_cnt].pipe.src.dcc_fraction_of_zs_req_chroma = 0;
>          |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~
>    make[6]: *** [scripts/Makefile.build:250: drivers/gpu/drm/amd/amdgpu/../display/dc/dcn32/dcn32_resource.o] Error 1

Could you check if you have this commit in your branch?

drm/amd/display: move remaining FPU code to dml folder

iirc, I merged it around Tue:
https://gitlab.freedesktop.org/agd5f/linux/-/commits/amd-staging-drm-next

Thanks
Siqueira

> 
> Cheers,
> Nathan

