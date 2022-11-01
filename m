Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C076C43217
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Nov 2022 14:36:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 653CD10E3D8;
	Tue,  1 Nov 2022 14:36:19 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2075.outbound.protection.outlook.com [40.107.237.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C7AB10E3D4
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Nov 2022 14:36:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jG/E+a2xDhfIQy6l3QhLaOJxYuNVvjl3sgYk32Be3HombszkY+dJT/4B7M2KTKmMr+fuI0tyzF7NR7Lrz7QxnrKvmTDcmiGjt2pD6IWemsjU8Bl8aMENtlHAsE1fbek+6XLAGzsk59smfbEOyO6uG6h7nibjn1S198GIjHkFAXFkv+q9gplWi74uF64GC+ZREdT2u7lHItttZ5YiqOoowRByWKVSP6VfserUelNKM+BAmJB2jDKQVmWYOs/1c/Cph3dl06SlfNN0qhJTkOqOzuE+9AWZgXO58Tps5bYFP1XIzW7vKRIehrx/Ws4w4i1TSPhb8iwNFUCrHeDh7uPknA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nHb/G9GScWtADWQnGuNmFRPUGI+yowTs3QqkjoElWz0=;
 b=PQp9EQrnBuDVVgn4pC7apAGqi/UaFtddt43OLFAe1Ov3VvjCcABgvwig7QR0jSOcXx2UShaPe+Jy44glj2X6N2YBvwHCwFRZkm5uvjYrpobpFlAKTdALAPzw/7hMrv4NWSg3dkc5xrUJbSX8KHVZjye6yZjfH77D2cX0fyWlXqux6QOtHxNecl6v5YPmljUo3b8ZQATM0FcHCaL+hK2Xap0ZjZrA0TRKC/dXBDcRCGd/eGGc1ZQnTOhkSljgMuX0mV4wxyufplPXv1sK5YLRrx/JXoHRuYSWlcf/CQnyC85ZBKnY8vOBOYOP+T6hh2aiToIhTmShrwyr7mtU/wcHpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nHb/G9GScWtADWQnGuNmFRPUGI+yowTs3QqkjoElWz0=;
 b=vct9oD3sHK75xAk3b/HPaItP0qq50gwbgZEci4aMiCruarsULpDriIO9M0PPOYbiEAdbwDK/ZmzswSYyyz54QMAa30J67CX5jhEZKp/tVhGuH1eQKOCg8jZCb0gqQe5nsnSjVQh/wT+XPqMUReFPvj9mgoA9mnVZv1bHChDOtpU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB2941.namprd12.prod.outlook.com (2603:10b6:208:a9::12)
 by CY8PR12MB7684.namprd12.prod.outlook.com (2603:10b6:930:87::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.27; Tue, 1 Nov
 2022 14:36:10 +0000
Received: from MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::588f:c941:4f62:9d89]) by MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::588f:c941:4f62:9d89%3]) with mapi id 15.20.5769.019; Tue, 1 Nov 2022
 14:36:10 +0000
Message-ID: <6b5fb93f-fd23-c96d-0f1d-ba8bcd7a5079@amd.com>
Date: Tue, 1 Nov 2022 10:36:08 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v4 1/1] drm/amd/display: add DCN support for ARM64
To: Ao Zhong <hacc1225@gmail.com>, Nathan Chancellor <nathan@kernel.org>
References: <20221031193738.23538-1-hacc1225@gmail.com>
 <20221031193738.23538-2-hacc1225@gmail.com>
Content-Language: en-US
From: Rodrigo Siqueira Jordao <Rodrigo.Siqueira@amd.com>
In-Reply-To: <20221031193738.23538-2-hacc1225@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0189.namprd13.prod.outlook.com
 (2603:10b6:208:2be::14) To MN2PR12MB2941.namprd12.prod.outlook.com
 (2603:10b6:208:a9::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB2941:EE_|CY8PR12MB7684:EE_
X-MS-Office365-Filtering-Correlation-Id: 71a24e3c-91e7-4cc2-f392-08dabc166b30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S67QDYTj+r25DUcR/78leWel9/AwR49CNN+XwuFEGL8E7yZ7o4cSNRhsGHggKaz29/NUGAYNn7msKVcd+VdTBFyKtfK0Pg0pZTNqVEBW2yORlvP2wAeCFI22dKYoSBPfrhetIja57UKgkrpY50W7kV5vo7m4wXDPPpVX05WiyqPW8kvMyHswf71V1ETm6KoxtwPca2Duk7Xi0fMJyTnY9HSSnVq0iej0aW6HVcI0wWqgWzD7TaXhkeZH2JU854guqPXc1KI0t8un6W9rqa6q9VlXk+ANOOPSLLDTA0wrPF11JNpnFoKM8Tku0+xIwmH6I/Sr5CBMe6e+hTiU8tfQJusQbUguXfOhaB8sf65s7M0nBBpRfP+OW9nIH9GK/fHDEHdyqUKvxIURhYAq2zzVe+f5c4J1oaEdcAs0QHVwBakbCyqklOhuwbLQilRTsrie5BDaGAaJdhTfXAz0H0VbwtX64RRq4dFG0OSLGvUD5dKLvfRRCh5DeAMt3IPu8DwuTjVQ9tA1pYRAS97pGMTv+EAlI68eYGNbBAegVLBHPThoMZz4EhBFl95mD58X3Z8jCQviQSZ7NP3OUlFqs+gS9iMwR/M2BcP0DXERnoyU2pobFVk4xt95NLXK8yikTDMptgFjgziQBJBjAhyHqmLf37O7k+B4JgAtP4kjH/XTc5q/JAWpAENZJT7H/1JtQ1Nz3D1hxpL4oSa7L25FacINseFH6CicpCWMSkkE0mE0UNa8fhS9dve42GQ3w1PioAgbeiWB3bqYzmhHktMVwnYR97Ck2ptbRMxfShJSDO+BOn57Z6W3h0DrqiNaDiSlVhRK1/RsTGv6pJbKL3ShjLofOQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB2941.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(366004)(376002)(136003)(39860400002)(346002)(451199015)(31686004)(2906002)(316002)(6486002)(41300700001)(54906003)(26005)(6506007)(6512007)(53546011)(8676002)(4326008)(86362001)(110136005)(36756003)(966005)(66476007)(5660300002)(66556008)(31696002)(4001150100001)(66946007)(38100700002)(478600001)(83380400001)(8936002)(2616005)(186003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y2FUU3dUbThFSVdGTUJIa2xjWENMdDQ0UG9SMGY5WHRzUUtOL2JDZjZFU21x?=
 =?utf-8?B?Y0ZnWVNRdzRtSy9WTGZ2dDFkN2NTVUJYWXhWeko4YzRNaTJJTUdBZ08wTDEv?=
 =?utf-8?B?Tk1DVGdJYzRaOFRUSDV5VGpENVBCeW0vNHlsUHo2YkRwTi9vUkpTbDdyUWxm?=
 =?utf-8?B?alV4WkNjVFdHckJRSTZKTis1TmE4emVEUjJ2OWg3citSRk9pZVJTMG1BcHJr?=
 =?utf-8?B?OG4wSmg1MnJxdG1sR0ppa3pYRmhMNTkzUFEyblJwUDgvZkRWNlZ5VFhtcTFU?=
 =?utf-8?B?cTZucFh5bDFHNnhIUUN5a3NwdlgxZDJVNGJnd29YSGk5ZXNJSlJCNU1FNjl4?=
 =?utf-8?B?S1QzS3NXVHRCUHVyR1ZBbFZ3ekRZSHJqb0JTOEFFT2crTTA3a21RT2JrUG9H?=
 =?utf-8?B?U2t6Qk5oVHpDRW5kQ3p3ZExVSXVlNFgrRm4wNDU0NnF2S0daWml1QnhRbURy?=
 =?utf-8?B?U1ZiRkIvZFdHK2wyRHIxM01wWkpzbjBEUFh3K1FyN0x0QmhKdk5JYnVuU2Y2?=
 =?utf-8?B?K1FJeWhDUFZBRWxMZmN2SUEzSTZTZXA2dGJZbVRWdDFnelJ3VHVhMUtpWXJU?=
 =?utf-8?B?aUJGUElISGxub0pGaGtmWStQazF3QWVJTnErRnZTaDUvMXRyais1UlhBdW9I?=
 =?utf-8?B?SGRZTWFNSzlwcGNmK3BDaXZXS3NXV3R1TzBqb2JiQXQxazVTdlk5THFGQzlw?=
 =?utf-8?B?cHBzeHdzeUs4MjIzWmc0VlVnOHJOeE1sWHZGbkNKYmtOS2k2S2NJNWljWTVL?=
 =?utf-8?B?dGpHZjc3NHEyRGJnZjMrNXIvVE5rUzhRRjdzR04rR05MQnJWYWFDWG5PT0JC?=
 =?utf-8?B?OERXbXFQcW14YzczbFRRblN4SnpSeXN6TmQxNHVBeG42b0VlZE9qdExrRkVt?=
 =?utf-8?B?U3FQVWdmeTczZW16L2JHTWlLQWFmdUdkemphdXV3Sno0U3Y2Y29YOXVKcmxj?=
 =?utf-8?B?RmVXNjBBN3JiUENVazBpbDdRZmtRSEZma2EwU25vZTkxYmdEeGIzdDdxMzRo?=
 =?utf-8?B?SmJOajkzVDV2SDNURGlTT2pRMHdhUHN1djFoWVJkRWszaDlrcm9TbjE2bmRq?=
 =?utf-8?B?WVpBRU9qZzVCVWFwQmJ3Qi9PYjJzMXVUYmpZNWx0RjJ5WTRLVldiKzVBWUxJ?=
 =?utf-8?B?Q0pxRDliT2ExL1o4Z1EzVTJhcHp1Z3IwYUtIOCtHcHA4SFp2V0JxM1VEWTlz?=
 =?utf-8?B?QWg3T3V0VStXckE3MG02Ym5BVUNqcDJBVHB3NXRBbWNBMFQrblU5d2NXZ2RY?=
 =?utf-8?B?Y2Z1SytsNDU0aWhKbDZ6MnIwL3k0Rkc1Umx5aU5hK3gzam5WUlRGQkFBSHcr?=
 =?utf-8?B?VGkyU2RvK1BjSGl4cXV3UnNFd1dsZ3dQZUdZUGdtSVlyeXBaT2lha0prZWpi?=
 =?utf-8?B?NXdHbjNBMUpIanpwRkZ4RGNzOHpUV0hJaGs4MWNKamNMYjg1MEtwck5SN3RP?=
 =?utf-8?B?cHRJbnArUWpzeXVwbnBnZE1xT0pyMDA3eElsaUxIa1JYZUprVERJL2FuZ3Ax?=
 =?utf-8?B?L21HUUFnbkRJN2dPZ0ZueEdWME0vQnhkMWxyQnJHMXVxbDlaOGdpdzVpbjVH?=
 =?utf-8?B?c3B3V1NDdGZic0F1WHh3K3REZ2FKcUZ6ZlI0VlAvZmxnQ3hzaDlKZDQ5Wi9k?=
 =?utf-8?B?Z095QmY2T1AxdWNtOERZTGFZT2NLWWJhTDYxdzhJVXJpYVA5V1VieTJ3cCsz?=
 =?utf-8?B?dm8rcCs3OEp6OFB2MDdpR3UzbDdwcmxHbEpKcGEzSk5HRXRaOVR2VWFpSEdl?=
 =?utf-8?B?UE5LcHhzQU05WWxzS3g4emhNc1gxRklJRE5DTGlmaVhhRytycWVRaExzVUt3?=
 =?utf-8?B?WjNCMW1zMGtXUzFodW1LR1JPcnUzQlRJQ3ZORXZPQkxsYzArK09MbGFzVEFI?=
 =?utf-8?B?WVpNTmNZSWVTSTlRVVEzUE11emFObmpiblQycjdLTFRPTGpJWW1qRmJPcWV5?=
 =?utf-8?B?LzhqeFE3NzNyajlYa1V6YVhCUnZic0JjbWRJUTRBRnkrSXJHSm1vSmFjOVBQ?=
 =?utf-8?B?TVNPOGdqSU9UT1N0V0EwVmNNWXFmRk9wTDlQdnhBa3hkTkZEdGd3aGM1T25z?=
 =?utf-8?B?WWRtcnhVSG0yejdtYm5wQUxsdHhhQ0J3eXR0aFl0R0JHd2FkSlo0VkJlRWl0?=
 =?utf-8?Q?HjdopU5le+1EsUSB4aix8bIuy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71a24e3c-91e7-4cc2-f392-08dabc166b30
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB2941.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2022 14:36:10.3925 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tU22lIreXRB8+AGeuJsgDTE1CW/rPAMSVo3qxUrePnnzVLvea42Q2l49mEBavPsH00Go142CwmuGpkJF6IRrWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7684
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



On 2022-10-31 15:37, Ao Zhong wrote:
> After moving all FPU code to the DML folder, we can enable DCN support
> for the ARM64 platform. Remove the -mgeneral-regs-only CFLAG from the
> code in the DML folder that needs to use hardware FPU, and add a control
> mechanism for ARM Neon.
> 
> Signed-off-by: Ao Zhong <hacc1225@gmail.com>
> ---
>   drivers/gpu/drm/amd/display/Kconfig           |  3 ++-
>   .../gpu/drm/amd/display/amdgpu_dm/dc_fpu.c    |  6 ++++++
>   drivers/gpu/drm/amd/display/dc/dml/Makefile   | 20 +++++++++++++++----
>   3 files changed, 24 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/Kconfig b/drivers/gpu/drm/amd/display/Kconfig
> index 0142affcdaa3..843a55a6a3ac 100644
> --- a/drivers/gpu/drm/amd/display/Kconfig
> +++ b/drivers/gpu/drm/amd/display/Kconfig
> @@ -6,7 +6,8 @@ config DRM_AMD_DC
>   	bool "AMD DC - Enable new display engine"
>   	default y
>   	select SND_HDA_COMPONENT if SND_HDA_CORE
> -	select DRM_AMD_DC_DCN if (X86 || PPC64)
> +	# !CC_IS_CLANG: https://github.com/ClangBuiltLinux/linux/issues/1752
> +	select DRM_AMD_DC_DCN if (X86 || PPC64 || (ARM64 && KERNEL_MODE_NEON && !CC_IS_CLANG))
>   	help
>   	  Choose this option if you want to use the new display engine
>   	  support for AMDGPU. This adds required support for Vega and
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c b/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c
> index ab0c6d191038..1743ca0a3641 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/dc_fpu.c
> @@ -31,6 +31,8 @@
>   #elif defined(CONFIG_PPC64)
>   #include <asm/switch_to.h>
>   #include <asm/cputable.h>
> +#elif defined(CONFIG_ARM64)
> +#include <asm/neon.h>
>   #endif
>   
>   /**
> @@ -99,6 +101,8 @@ void dc_fpu_begin(const char *function_name, const int line)
>   			preempt_disable();
>   			enable_kernel_fp();
>   		}
> +#elif defined(CONFIG_ARM64)
> +		kernel_neon_begin();
>   #endif
>   	}
>   
> @@ -136,6 +140,8 @@ void dc_fpu_end(const char *function_name, const int line)
>   			disable_kernel_fp();
>   			preempt_enable();
>   		}
> +#elif defined(CONFIG_ARM64)
> +		kernel_neon_end();
>   #endif
>   	}
>   
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/Makefile b/drivers/gpu/drm/amd/display/dc/dml/Makefile
> index d0c6cf61c676..d4e93bed1c8e 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/Makefile
> +++ b/drivers/gpu/drm/amd/display/dc/dml/Makefile
> @@ -33,6 +33,10 @@ ifdef CONFIG_PPC64
>   dml_ccflags := -mhard-float -maltivec
>   endif
>   
> +ifdef CONFIG_ARM64
> +dml_rcflags := -mgeneral-regs-only
> +endif
> +
>   ifdef CONFIG_CC_IS_GCC
>   ifeq ($(call cc-ifversion, -lt, 0701, y), y)
>   IS_OLD_GCC = 1
> @@ -55,8 +59,6 @@ frame_warn_flag := -Wframe-larger-than=2048
>   endif
>   
>   CFLAGS_$(AMDDALPATH)/dc/dml/display_mode_lib.o := $(dml_ccflags)
> -
> -ifdef CONFIG_DRM_AMD_DC_DCN
>   CFLAGS_$(AMDDALPATH)/dc/dml/display_mode_vba.o := $(dml_ccflags)
>   CFLAGS_$(AMDDALPATH)/dc/dml/dcn10/dcn10_fpu.o := $(dml_ccflags)
>   CFLAGS_$(AMDDALPATH)/dc/dml/dcn20/dcn20_fpu.o := $(dml_ccflags)
> @@ -88,7 +90,6 @@ CFLAGS_$(AMDDALPATH)/dc/dml/calcs/dcn_calcs.o := $(dml_ccflags)
>   CFLAGS_$(AMDDALPATH)/dc/dml/calcs/dcn_calc_auto.o := $(dml_ccflags)
>   CFLAGS_$(AMDDALPATH)/dc/dml/calcs/dcn_calc_math.o := $(dml_ccflags) -Wno-tautological-compare
>   CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/display_mode_vba.o := $(dml_rcflags)
> -CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn2x/dcn2x.o := $(dml_rcflags)
>   CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn20/display_mode_vba_20.o := $(dml_rcflags)
>   CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn20/display_rq_dlg_calc_20.o := $(dml_rcflags)
>   CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn20/display_mode_vba_20v2.o := $(dml_rcflags)
> @@ -105,7 +106,18 @@ CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn32/display_mode_vba_util_32.o := $(dml_rcf
>   CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn301/dcn301_fpu.o := $(dml_rcflags)
>   CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/display_mode_lib.o := $(dml_rcflags)
>   CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dsc/rc_calc_fpu.o  := $(dml_rcflags)
> -endif
> +CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn10/dcn10_fpu.o := $(dml_rcflags)
> +CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn20/dcn20_fpu.o := $(dml_rcflags)
> +CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn314/display_mode_vba_314.o := $(dml_rcflags)
> +CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn314/display_rq_dlg_calc_314.o := $(dml_rcflags)
> +CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn314/dcn314_fpu.o := $(dml_rcflags)
> +CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn30/dcn30_fpu.o := $(dml_rcflags)
> +CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn32/dcn32_fpu.o := $(dml_rcflags)
> +CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn321/dcn321_fpu.o := $(dml_rcflags)
> +CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn31/dcn31_fpu.o := $(dml_rcflags)
> +CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn302/dcn302_fpu.o := $(dml_rcflags)
> +CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn303/dcn303_fpu.o := $(dml_rcflags)
> +CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/calcs/dcn_calc_math.o := $(dml_rcflags)
>   CFLAGS_$(AMDDALPATH)/dc/dml/dml1_display_rq_dlg_calc.o := $(dml_ccflags)
>   CFLAGS_$(AMDDALPATH)/dc/dml/display_rq_dlg_helpers.o := $(dml_ccflags)
>   CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dml1_display_rq_dlg_calc.o := $(dml_rcflags)

lgtm,

Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

Nathan,

If it is ok for you, I can merge this change.

Thanks
Siqueira

