Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD982C67871
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Oct 2022 06:41:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D22F410E2CF;
	Thu, 27 Oct 2022 06:41:19 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2078.outbound.protection.outlook.com [40.107.94.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BE9E10E2CF
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Oct 2022 06:41:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i2nhhmCkNlw965vxoKCvMGEpqb9ubq/Z6I5ia3yELS6nZCBcLBxNuHcAFwuc84qqCcMPDTvju8U5rWuTDBbR626OXmKNlwjw4kR4NbdC5RP+96PPz03L9xDH9k4G/txq5h7lpljiH/tfylLBec/tIJmYKkJbw2Wmjra1bUPLbq991VDCxqAb/Dw3lyY7Ae61WDmJbjdCsT8eitr9/iylpkFhDlsGqK6NrOzGpy4soE4Zkzy7yuhlghcKmlkPEtHVCpXiW2zVsaAnAEx5Z3p6w5pt4Z/pgug+kFbd8nk40JwXYaw9Y80TGInLMNHw4i27PQKu8OpeFuCllJd2svMcuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=en1fqAyz0258Obvxq+f6Fe94sPUHfJHUXlW3A+3PRgI=;
 b=SJutzUnGmjZnskuJwAi8uOEE44aTfUAYL+YzuUSlKnalAWpX9PZOS8FOItyV01iz2HSt8mfVq5kcRtv1eqTaGb4csYIsR/sJWwzEqYaWwgFmdNHZ+BKnnbgbxTsb096vzYn0yyU0cP3a07oxOEe2mBhFaZnuwNJIKR3xiFdqY5LxzfZW1oZDwGkPvmz4xOGWh0Ql2CxI83T1QuiW4y7BBcaKNsWl11pwmsfJ4+wcn21BEO/0T5yWeSxgl0G7Hv/yK+l8uPM9/lCfu/VrLu4biu44bq4K0XQYTdI7VDsHeMBUU12OsZI4UBDi+9hZWoU+CVKlxk98E7jXC/sgaj6MLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=en1fqAyz0258Obvxq+f6Fe94sPUHfJHUXlW3A+3PRgI=;
 b=VS68TcK0BePkpuG7hE4iCfxlyAUDG5f59ZZKuaRsSyt3qN605zbIgmhWEdoaVRbwu2QC6qMXXmOUKFRfqoZNoPBTzbfJwwUQz/LmBcHM/DYCzpIGVwxcgHCfaa+moq2ku2dW5Ny/j8Bc58kEie9hdR7WS3jYOkg9ukiPJQDHR68=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3587.namprd12.prod.outlook.com (2603:10b6:408:43::13)
 by IA1PR12MB6067.namprd12.prod.outlook.com (2603:10b6:208:3ed::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Thu, 27 Oct
 2022 06:41:14 +0000
Received: from BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::a350:f29a:f287:7279]) by BN8PR12MB3587.namprd12.prod.outlook.com
 ([fe80::a350:f29a:f287:7279%4]) with mapi id 15.20.5746.023; Thu, 27 Oct 2022
 06:41:13 +0000
Message-ID: <973a3ee2-164b-5ca7-40c2-b192e237c133@amd.com>
Date: Thu, 27 Oct 2022 08:41:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH RESEND 1/1] drm/amd/display: add DCN support for ARM64
Content-Language: en-US
To: Ao Zhong <hacc1225@gmail.com>, Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Arnd Bergmann <arnd@arndb.de>, Nathan Chancellor <nathan@kernel.org>,
 Alex Deucher <alexander.deucher@amd.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>
References: <20221027002528.15983-1-hacc1225@gmail.com>
 <20221027002528.15983-2-hacc1225@gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
In-Reply-To: <20221027002528.15983-2-hacc1225@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS9PR06CA0049.eurprd06.prod.outlook.com
 (2603:10a6:20b:463::24) To BN8PR12MB3587.namprd12.prod.outlook.com
 (2603:10b6:408:43::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3587:EE_|IA1PR12MB6067:EE_
X-MS-Office365-Filtering-Correlation-Id: c9081d59-b139-4bc8-1059-08dab7e63da6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rUUfkJcZcIj09lI8bHmnXHjaQvB0Jzf9OgTYTVJ3qvbypM3eYgvnW/KYUiFLPS/dHzOzRkNntnCqroXJatFP9Y2BBfYY5g/qNedzWUk03EusVjVrisg934yKXgJLpIQCNLjP2JrR/25u4I260MPPEOubIdjhD54B1VVbhwvJNxSYKzExEvW9NvFB8RBp51D6zGWmTe/OaWak+iJAIOqtkh+ALW35pfAjMTPo73m4gU7OttBjTZDHjmxJdqPkGPoQT6qpCgmywt6QezIngo1ZPAnl8CegqznfdUr1rypzWE9D4j0nr18dY8ykLUwVpZi8hareVBBoikEuVpoiKarONHUmPv5vAFWcU/YK8L5MVPvV3lALjLo6drONlIqL/lXYECZkPyA/Z+yviQkUqJBjGGcxrzLGpgEVgOkHBVGMq8U5QXP3Sjl2SwC5c762UQ17/pDrEvRy08tQxOg202hQFawxrLsF87kfIxb+0DyJR9V8/YsYVAHE7y2nyu9DWghr69oglJf2zfNSiqJDM+BX47+rIkYfYXcdyegjzFDnrRRzZJDOJBwafldrILTx8d5/BB/vAWqOd4oo8d6sPyQGocv+El3kOxA8sCH5xV9Z1aYPId3Dj3Z5j7bpGRk8UDfSlZyAIwVX9/nUCcyqngkLSzIr+9hV5BkFV4Ks59sEsM5yoB33b0ADtcGAzDa4V+fBFM6RTH8E0YWhehKhBFIOBef0xI1Ln4XNPLpwCkDPKm7RfNqMQG4UJpwzYXK0cSqIZqmlsSEltnnIU53AofwKtGm49vAo6bIy3BST1Jidomw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN8PR12MB3587.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(376002)(366004)(39860400002)(346002)(396003)(451199015)(31686004)(31696002)(66476007)(6486002)(4326008)(478600001)(8936002)(38100700002)(8676002)(36756003)(83380400001)(86362001)(2906002)(186003)(6666004)(2616005)(66556008)(41300700001)(5660300002)(316002)(6512007)(6506007)(26005)(66946007)(110136005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ODJIVXRMbG1rL3gvRjhvR2tQdUtJYTN2dmJiVHBPK0F1a0hVWnlBVEw4NmtL?=
 =?utf-8?B?WUs4WkJTSWlnbVhjSEF2YWZ2YXdRNXBLZkhpN2ZOaDBEUDE1YitNcXJtWDV2?=
 =?utf-8?B?L052ZHI1SDd4THpPekNqNnBSNjZ2TWljc3ZyQVhkZHB5dVlYU1dFd3BFMTNl?=
 =?utf-8?B?MXNQeG5lS3ZFbVlOR3l2Y1F5NjIvQW1iTUVwSTdyNDdYelVvRVhSakYxL2pY?=
 =?utf-8?B?UjBUclNCdnE1RGczQ2ZkWXFNU3pjTkNFTUhpYnFmdXNWdnpPTm5Sb0pFWlJZ?=
 =?utf-8?B?TXZLZVVvandXaGF6Ymd0OFpvTGVROWEyT2F1Uk5xL0lxL3NJc3pFeWxOVlVs?=
 =?utf-8?B?b2RHRDRzdmZaTnhVbTltL0Q1SUQ2Z0hRZk9NV0dpTDMwb29VU1hJUURpUlR6?=
 =?utf-8?B?ck5mbjBSY0szU3pmUURaU3dlb3A5M3BrZE1WdytkVXlEcFliWkdsM0w1SWt0?=
 =?utf-8?B?aVh2OXBOb0Y2Z2hKSUZmWVZDWHVGakVYWllaNFgxOEovdHV2Zk10RGpJTVVM?=
 =?utf-8?B?U3liQyt2V0I4R3RKcFZKVnlzOU5HalVOSi95UzVBT1VRUi9NWmxjU3EzM2R2?=
 =?utf-8?B?L0dHSThMaTNVMGljVm0vdnU3TDhXd1k2azl0d1dtN0ZMYmFyakZvUmFmWE5j?=
 =?utf-8?B?dVBkRWZyYlZpclQ5SnZFQ0djSTk2SHdMYlVUZyswMjNrenhmZ0FmWkxNMVRG?=
 =?utf-8?B?YmsrK0s1SUgxQ0NjU3lQVTduRWpiUUxuTHM2cHhyZWZNbVlhZ3ZvMzZvSmVL?=
 =?utf-8?B?ZStnZW5BOFo1OTRGUVB1dWpCK1BYdzI0a0F3eEhlM0hXemFVRHdWUm1NUGli?=
 =?utf-8?B?UDBaUnFsWkJiaEpVaWFMdmhRWWdSNStlVkpJa3p6YTMySzkzZDlUK29ZdmVp?=
 =?utf-8?B?Tkh5S0M0NzgxRUZZcW9SUVhCZld2eXBuUDBsRVBUQTZBWWRZOVdKenlTL0pI?=
 =?utf-8?B?ZWIrOC96WHpZMVlreWVrYUxObkdDTE9SMmgrMlhsV0dObkUvaFl6Q2d6L1I4?=
 =?utf-8?B?MHgvalEzWEZrc0R2cVYzR0VVcFlYODlrbUZ3YXR0VGp3WkhHOVovRnNnSkhY?=
 =?utf-8?B?NFVxTnhRdkR2bS8wb2dQajVwZzhJcCtUMUorSGpLK3BLNGNJWjcyYXM3Nkpo?=
 =?utf-8?B?ZERnNy8yU1Nodjg0bjVpN1k2MDlNajZVWnRGZEl1RnlETk40WmdlL3YwS1JW?=
 =?utf-8?B?eFRzMFFMNUplQjFaTmlEZTBqbVUwZk5IZ0hEcTd0TjF3akg2VUt6Tzh5VVBr?=
 =?utf-8?B?ZUNZWktkM3MvUDFzTVdJSTMvWktkRlVKTDZwd0cvT05mMC83UTZxZ2dtaDVR?=
 =?utf-8?B?SGUwTi9YS1ZlMEtaYmMvV0xTOG5kcVhjSURDdG16SmIyMTA3bWd2enhicjRK?=
 =?utf-8?B?eTlOMXlEMHJ0UFloMVBqTzlKL0pGZlpZbTYxTTFZSk5OQ2hhYjlkenJ0YkVl?=
 =?utf-8?B?bENiQTU5amg4U3hseWxkaE40K3ZzR0NWemEwY09VcDdUZEI4RlpxRktuZTNs?=
 =?utf-8?B?ajhTSGFZZS9aMWFsTmwzcHlQWjV3QndycU1nOER4OERDZ1JwUmZwS3FEY0p5?=
 =?utf-8?B?QXA0a28rNHFwKzh4ekpjbEh6SkM2Tnlvb2JIWGFveFc0bXNqaDFuWUhBMkZ3?=
 =?utf-8?B?NEZpaXVOT3Vja2E4Rk9wZ0E4SDFoSlkyWnZTdVl5OW42L21NR3FQTzMvS2Fa?=
 =?utf-8?B?L2Q2NHBzc2pPWUVFZXM1QWRlcEJuNi82MUNBYnpUaEptZGpNOTZrL0g5WXp1?=
 =?utf-8?B?VlhTV0tzVUFsSjU3SWJmSE95ekE3T1Y0UzdiNzhZUlJPOFFGS3dLdUZ0VWV4?=
 =?utf-8?B?YmlJTTVrSjAxUTdZdGt2N2Q4cStERFdlOUN3YUtHRlpCYUtqNFRaUGpUMmhU?=
 =?utf-8?B?Z2NGbzRwaDdVQWMwME5sM0x1akl4aG10Z1NJKy9uZ080eVV5SlhnRGJRaU4w?=
 =?utf-8?B?MStJZitXeXdpeVpTNFA5VDRIK3ZkMEp0OFNXcjRCbkRMWnNYYlNHcXYxSCts?=
 =?utf-8?B?b0VGTDdKYTA0d1NsU2N5VW5UZ3V6d1RKRzRrM2dtdXVJZ2s3SWlOSUxmaHow?=
 =?utf-8?B?bCs3SGlRN0UzNlZwRllXWUxaRy9PaDZEdUpnZTdBdnhCcFc1ck9ka00vUUhV?=
 =?utf-8?Q?B246Ph1J5YQb1q2MJHBUB/puQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9081d59-b139-4bc8-1059-08dab7e63da6
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3587.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2022 06:41:13.5688 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iCJYDa72pvuiDxkLudXavhv4q4TOruLtusIfZwp0HZuj1QZi/v94XfQxiLXT23Vy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6067
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
Cc: amd-gfx@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 27.10.22 um 02:25 schrieb Ao Zhong:
> After moving all FPU code to the DML folder, we can enable DCN support
> for the ARM64 platform. Remove the -mgeneral-regs-only CFLAG from the
> code in the DML folder that needs to use hardware FPU, and add a control
> mechanism for ARM Neon.

It's nice to see that the FPU isolation work is so fruitful :)

> Signed-off-by: Ao Zhong <hacc1225@gmail.com>

Acked-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/display/Kconfig           |  2 +-
>   .../gpu/drm/amd/display/amdgpu_dm/dc_fpu.c    |  6 ++
>   drivers/gpu/drm/amd/display/dc/dml/Makefile   | 64 ++++++++++++-------
>   3 files changed, 49 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/Kconfig b/drivers/gpu/drm/amd/display/Kconfig
> index 0142affcdaa3..a7f1c4e51719 100644
> --- a/drivers/gpu/drm/amd/display/Kconfig
> +++ b/drivers/gpu/drm/amd/display/Kconfig
> @@ -6,7 +6,7 @@ config DRM_AMD_DC
>   	bool "AMD DC - Enable new display engine"
>   	default y
>   	select SND_HDA_COMPONENT if SND_HDA_CORE
> -	select DRM_AMD_DC_DCN if (X86 || PPC64)
> +	select DRM_AMD_DC_DCN if (X86 || PPC64 || (ARM64 && KERNEL_MODE_NEON))
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
> index d0c6cf61c676..3cdd109189e0 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/Makefile
> +++ b/drivers/gpu/drm/amd/display/dc/dml/Makefile
> @@ -33,6 +33,12 @@ ifdef CONFIG_PPC64
>   dml_ccflags := -mhard-float -maltivec
>   endif
>   
> +ifdef CONFIG_ARM64
> +ifdef CONFIG_DRM_AMD_DC_DCN
> +dml_rcflags_arm64 := -mgeneral-regs-only
> +endif
> +endif
> +
>   ifdef CONFIG_CC_IS_GCC
>   ifeq ($(call cc-ifversion, -lt, 0701, y), y)
>   IS_OLD_GCC = 1
> @@ -87,32 +93,46 @@ CFLAGS_$(AMDDALPATH)/dc/dml/dsc/rc_calc_fpu.o := $(dml_ccflags)
>   CFLAGS_$(AMDDALPATH)/dc/dml/calcs/dcn_calcs.o := $(dml_ccflags)
>   CFLAGS_$(AMDDALPATH)/dc/dml/calcs/dcn_calc_auto.o := $(dml_ccflags)
>   CFLAGS_$(AMDDALPATH)/dc/dml/calcs/dcn_calc_math.o := $(dml_ccflags) -Wno-tautological-compare
> -CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/display_mode_vba.o := $(dml_rcflags)
> +CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/display_mode_vba.o := $(dml_rcflags) $(dml_rcflags_arm64)
>   CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn2x/dcn2x.o := $(dml_rcflags)
> -CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn20/display_mode_vba_20.o := $(dml_rcflags)
> -CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn20/display_rq_dlg_calc_20.o := $(dml_rcflags)
> -CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn20/display_mode_vba_20v2.o := $(dml_rcflags)
> -CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn20/display_rq_dlg_calc_20v2.o := $(dml_rcflags)
> -CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn21/display_mode_vba_21.o := $(dml_rcflags)
> -CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn21/display_rq_dlg_calc_21.o := $(dml_rcflags)
> -CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn30/display_mode_vba_30.o := $(dml_rcflags)
> -CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn30/display_rq_dlg_calc_30.o := $(dml_rcflags)
> -CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn31/display_mode_vba_31.o := $(dml_rcflags)
> -CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn31/display_rq_dlg_calc_31.o := $(dml_rcflags)
> -CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn32/display_mode_vba_32.o := $(dml_rcflags)
> -CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn32/display_rq_dlg_calc_32.o := $(dml_rcflags)
> -CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn32/display_mode_vba_util_32.o := $(dml_rcflags)
> -CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn301/dcn301_fpu.o := $(dml_rcflags)
> -CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/display_mode_lib.o := $(dml_rcflags)
> -CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dsc/rc_calc_fpu.o  := $(dml_rcflags)
> +CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn20/display_mode_vba_20.o := $(dml_rcflags) $(dml_rcflags_arm64)
> +CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn20/display_rq_dlg_calc_20.o := $(dml_rcflags) $(dml_rcflags_arm64)
> +CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn20/display_mode_vba_20v2.o := $(dml_rcflags) $(dml_rcflags_arm64)
> +CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn20/display_rq_dlg_calc_20v2.o := $(dml_rcflags) $(dml_rcflags_arm64)
> +CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn21/display_mode_vba_21.o := $(dml_rcflags) $(dml_rcflags_arm64)
> +CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn21/display_rq_dlg_calc_21.o := $(dml_rcflags) $(dml_rcflags_arm64)
> +CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn30/display_mode_vba_30.o := $(dml_rcflags) $(dml_rcflags_arm64)
> +CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn30/display_rq_dlg_calc_30.o := $(dml_rcflags) $(dml_rcflags_arm64)
> +CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn31/display_mode_vba_31.o := $(dml_rcflags) $(dml_rcflags_arm64)
> +CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn31/display_rq_dlg_calc_31.o := $(dml_rcflags) $(dml_rcflags_arm64)
> +CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn32/display_mode_vba_32.o := $(dml_rcflags) $(dml_rcflags_arm64)
> +CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn32/display_rq_dlg_calc_32.o := $(dml_rcflags) $(dml_rcflags_arm64)
> +CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn32/display_mode_vba_util_32.o := $(dml_rcflags) $(dml_rcflags_arm64)
> +CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn301/dcn301_fpu.o := $(dml_rcflags) $(dml_rcflags_arm64)
> +CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/display_mode_lib.o := $(dml_rcflags) $(dml_rcflags_arm64)
> +CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dsc/rc_calc_fpu.o  := $(dml_rcflags) $(dml_rcflags_arm64)
> +ifdef CONFIG_ARM64
> +CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn10/dcn10_fpu.o := $(dml_rcflags_arm64)
> +CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn20/dcn20_fpu.o := $(dml_rcflags_arm64)
> +CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn314/display_mode_vba_314.o := $(dml_rcflags_arm64)
> +CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn314/display_rq_dlg_calc_314.o := $(dml_rcflags_arm64)
> +CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn314/dcn314_fpu.o := $(dml_rcflags_arm64)
> +CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn30/dcn30_fpu.o := $(dml_rcflags_arm64)
> +CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn32/dcn32_fpu.o := $(dml_rcflags_arm64)
> +CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn321/dcn321_fpu.o := $(dml_rcflags_arm64)
> +CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn31/dcn31_fpu.o := $(dml_rcflags_arm64)
> +CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn302/dcn302_fpu.o := $(dml_rcflags_arm64)
> +CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn303/dcn303_fpu.o := $(dml_rcflags_arm64)
> +CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/calcs/dcn_calc_math.o := $(dml_rcflags_arm64)
> +endif
>   endif
>   CFLAGS_$(AMDDALPATH)/dc/dml/dml1_display_rq_dlg_calc.o := $(dml_ccflags)
>   CFLAGS_$(AMDDALPATH)/dc/dml/display_rq_dlg_helpers.o := $(dml_ccflags)
> -CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dml1_display_rq_dlg_calc.o := $(dml_rcflags)
> -CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/display_rq_dlg_helpers.o := $(dml_rcflags)
> -CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/calcs/dcn_calcs.o := $(dml_rcflags)
> -CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/calcs/dcn_calc_auto.o := $(dml_rcflags)
> -CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/calcs/dcn_calc_math.o := $(dml_rcflags)
> +CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dml1_display_rq_dlg_calc.o := $(dml_rcflags) $(dml_rcflags_arm64)
> +CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/display_rq_dlg_helpers.o := $(dml_rcflags) $(dml_rcflags_arm64)
> +CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/calcs/dcn_calcs.o := $(dml_rcflags) $(dml_rcflags_arm64)
> +CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/calcs/dcn_calc_auto.o := $(dml_rcflags) $(dml_rcflags_arm64)
> +CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/calcs/dcn_calc_math.o := $(dml_rcflags) $(dml_rcflags_arm64)
>   
>   DML = calcs/dce_calcs.o calcs/custom_float.o calcs/bw_fixed.o
>   

