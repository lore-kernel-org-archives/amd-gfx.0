Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 804E6C38A2D
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Oct 2022 15:47:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99E7B10E3D6;
	Tue, 25 Oct 2022 15:47:47 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2042.outbound.protection.outlook.com [40.107.93.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B018F10E3D4
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Oct 2022 15:47:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=joSfneG4MvvnhaQ99MTSRORuFZhJa3fz15cBpggL1C5HAm7uc65gYkPF1IDi/KRfkEQNNW8lu1/B2R8RQWU0NA2Xt5lIZFVkfoRvb8JC5TKQRnoaivoSnIW+Ffqnagk/IvkCy92Zqdj49vBPUVuN9r8bTLEFLvUhi2n8Zyf6UVJbl0vSJe+df/CyCHjvd2LYplZ0NYP3n10zzKMx8WrQK2uCLrgdQrWiQul88gM3RtkHHsBfQlkN6B+aR9kdNKWy5nRU3xUhyOwfjiSbV6uM6S6Y2OMp9gUDQq2Y4RQxkWAsisi/+n+2KeGhF5/ZKBciNMWXDKzEkTvggun9ynyN5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KzEs93dpWEMh4rO0X+QyPz+YJ1OrWnH3MGyjxU5G6ec=;
 b=lLMyTPWlRxctNw3CeqJs4UkXVXW/CVjjoWPlQ0WHYnYUAVR2SMRiJmTRdHBvYf4yGW3ZaHC7pTQIz18ETYWLEwLLGsOKS4cg6yFqtEX4oO1nvO1mEyhXucb1yfknRWKKUvDTL85ToWAonUyuMzTyh1nggFzFoTH7CyUg5jbjeyrgA2wWIB3U2w+OADM6/EA94R+zDQuBAedszocCk7r1/vyG0jiu2OJTw8jczzOH6YqdVOr8H3+FWc8l/orLUWL7yav0oLGf8PcpEwcYwv77RvBT3dGe/3YFMANfbyEgRGg7ltGkj0OT/ov+XXeVnPr1YySUqmpwgcRPIMkjvO0n5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KzEs93dpWEMh4rO0X+QyPz+YJ1OrWnH3MGyjxU5G6ec=;
 b=YdY5QgVqj+g4e7pGhqXTlehYQ6uaEPeVM9jwA/IhJQ7gO1Mz7qyeguUTlFelaUcoRm3GSKX08MemSYCyEBzB3VFbfXZJo3pckZDIIf+Ut8vb1Hy9x+benqnjVX1iebpVB3C14/Ot1KdF9dXQcQIUJXYzkJAjWp4GD3Z1ncApvK0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB2941.namprd12.prod.outlook.com (2603:10b6:208:a9::12)
 by MW4PR12MB7144.namprd12.prod.outlook.com (2603:10b6:303:21b::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.27; Tue, 25 Oct
 2022 15:47:39 +0000
Received: from MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::588f:c941:4f62:9d89]) by MN2PR12MB2941.namprd12.prod.outlook.com
 ([fe80::588f:c941:4f62:9d89%3]) with mapi id 15.20.5723.026; Tue, 25 Oct 2022
 15:47:39 +0000
Message-ID: <8055465a-4a0e-722b-c436-f39d6818ec73@amd.com>
Date: Tue, 25 Oct 2022 11:48:22 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH] drm/amd/display: add DCN support for ARM64
Content-Language: en-US
To: Ao Zhong <hacc1225@gmail.com>, Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>
References: <20221021003114.25881-1-hacc1225@gmail.com>
 <20221021043135.261320-1-hacc1225@gmail.com>
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
In-Reply-To: <20221021043135.261320-1-hacc1225@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR04CA0047.namprd04.prod.outlook.com
 (2603:10b6:610:77::22) To MN2PR12MB2941.namprd12.prod.outlook.com
 (2603:10b6:208:a9::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB2941:EE_|MW4PR12MB7144:EE_
X-MS-Office365-Filtering-Correlation-Id: 06433f52-3321-40da-297c-08dab6a03f07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UvfwES39sG5AzINaGMRjIC5tT3HXYOHwbd46b+YmcEDIh6S1a78VEoLdZiIcPsbB9PdfcXLN6HlUg3u4L8d8MQ4yn7eAa+e5Ym3U86UVPQfRp3W4lo21CEc4G+diTmUOP2Ej3h1k76F0mdlyb536OrErg6bGNcd47wNVX4Y0aC0ynV87ZgZQm558wmGQ7YLKnB6LO7bTvXPbjzyE2np7OynmNk34UiidB88CRjVDwyHO/2Gk0AHa4E6j8V9hB2PTBm43hzB8G32OGFSHGDkc0a8pWrUNFJO8O7+kvYr0sTHHs7+5IHtT2KgdPx3iNO/rubWRxKdEHEemLIxXARDt/Ilg/QK41C8nO+yZcckiZ/GLt1lo48fd1FtlTSM3D6pl9ceypSCc50jfelS3/R8L+NAP/QpA/QGpjaK0Ldcx4SfeUOTNu4pGqzawCFEA9sQOKlunXpq6K6c7Cw/mspnhdv3VsjrFWlAJNiLTOYEL821yGvFgPE+dAYWCqFu3tBB7K4Kz//IGC2qGouH+bBxpI/ggvCj4pdn+LJEYW7CrHjaBrwieUeRpQ18HRTYMIw8iLCKpGowpowZrzYz9kVNrc8vD1GAegR4dbxzn4Am4lBV9PHIktoKzDC6aj0yx0cQq2wnd1Q5eWz8jWellG7oH+qfQvdYs1zagu1wgBiw/eYwoE2p5gl85QGN0VETX3mOC7uNK7OeN4Hg8LWb51ZXVo1rDv61fj2bGTdmjTEQavFykvj9dz8386OcNR+hb16CqaGg1F4H7nz6K2seMk/aMvScB7MogZwJHxGxGNflYwFI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB2941.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(366004)(346002)(396003)(376002)(136003)(39860400002)(451199015)(83380400001)(31696002)(86362001)(38100700002)(2906002)(186003)(5660300002)(8936002)(8676002)(66946007)(66476007)(66556008)(6506007)(41300700001)(6666004)(2616005)(6512007)(110136005)(478600001)(53546011)(6636002)(6486002)(316002)(4326008)(31686004)(36756003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OXc3Zm9xTlVZQ1ZWTktiQjZkOWdXbWFvVFBKUkZOQU9JVUNhcUJpZGc2b29X?=
 =?utf-8?B?Z2ZhTmdkTVNhTU12ZjJaUlFDSk1KYnZsV1Z6SkRoeC9nRzF4UnBQMDJOdW1I?=
 =?utf-8?B?a1pLUjYxWkYzSG1QUjZkYk03Y0U2NERkNmgvblRnajVFSUtqN3RHTTc0V1JY?=
 =?utf-8?B?UDNmanFRV0s5c0ZQTmRUVDdCQlkvMmN6ZncwZHlheFpXcDE0RTVuZ1NFV0pB?=
 =?utf-8?B?VmZpNEUxZVNWckxhTnRrZmxxNzlnUE9NNEJYNmR6bG05NzdnWWV3anIyVHA3?=
 =?utf-8?B?QWdyRnhQZmNtdlpidTR2M3JxYXY5SnlXZVdSaFVvWnQrS3h6Nks2dnNsbUQ5?=
 =?utf-8?B?S3c0U1F2THYyOXdXUFBvUjRPZitKekRONnZZSHFWYUJleXljblhGMWNMaVVZ?=
 =?utf-8?B?a2JWbXM4bUZZSDNSSWRpbThQcnVLbnErdHF5Z0paQy9vOW94RFUwNnlCMWlZ?=
 =?utf-8?B?eGxJcE5JM2IrcVdTS0NlMi85R3dBNTc5czQrZVpocjNlTUs2R0VqWlRVWlBl?=
 =?utf-8?B?akJQQ25NbnM3WlV0dEVLNUJ5RkJremVVSXZIb0xzL2VkeTJWOFpldmVLRFZ2?=
 =?utf-8?B?aG9kTEtuTmpGWVI0ZFBnbXN1OWpDdklsZDdPM0hpeUhMZStMNmFPZ2svalhj?=
 =?utf-8?B?cWxoOUFEN2IvWGN2aVJVaDEvMlFyZHM0ekRFR1BGT05yUmdyRjNUYUNTNVBs?=
 =?utf-8?B?WXVqVUhNUmU5VnB3QTZOQUdobStsUFZYNEQvNnRkS3ViSitHQkoxLzk2dUdC?=
 =?utf-8?B?eHJQUHZSQ1lFL2Y4RUg5SlZRTGI5dlg1YXloZ3ZrcUdYVi80MjhjQzhqdGp2?=
 =?utf-8?B?amN3WmtJTk9kQUpqRWRpZzFmYU0vWDYxNFdjQ0VQYWdWUm9pVzRRb2g0Q3JQ?=
 =?utf-8?B?aWZmbld5SUgxb1hid1lWWUszZUp5cGEyZEFpTjRJK0hPV1RpL1VNYVVOOFdH?=
 =?utf-8?B?OHl5cWd5dXIvdFlDSG5PRFpvb0Jodno5c29ZRWN0ek9oU2RZYll6K1g1SlBR?=
 =?utf-8?B?VlplQVJUeURRSjdKdzZjQ05UNFRwOEFFU3BOVlZPTUpsaDR3ZkFETGFtWlVh?=
 =?utf-8?B?VmlmdktKY1Vpa3hodTU2L1hCRUhnV3BLR2RQSGh1OW1QcjI0ZnlxQ2VROHpU?=
 =?utf-8?B?dGNONC84TzIrYkpDTVdpZkNnU0pXZDFBRlI3eTk0Z3lZNE5oMUs2dGMzb1FP?=
 =?utf-8?B?SEJFamdYaFhQbkZYTTg1OVo2bXpZc2xCY2NtdDFCTTRDTjFlODkwZDVlSm9N?=
 =?utf-8?B?RkE3d3Zubi90bmd1Uk9oUnhZVTJoVDMwN3FqaWJRbzlQSm9yYTRTaEVjK0Ri?=
 =?utf-8?B?b1l3cHNxZTdkYSs3Qi9ZSXM5bUFBWDVWOEdvdkx3UjBZSnhJT3JrSkFGWm5U?=
 =?utf-8?B?UUE3S1M3M1JScTBTTDFKQWVBSnU5anRJRmJsQ1VkVnFZcmNuUVZrZERmOHI1?=
 =?utf-8?B?YitMdUp6VUkvM25nQ2hEMHRMZGdWakc5NHJMK09ZOGdnMjU5K2dBaGZmbENz?=
 =?utf-8?B?Z0dOV2R2NzMvYVdZZFNpN1pMU1pqOXNEczNwbmtCTXg0aERnUjRrc1dpeFQ5?=
 =?utf-8?B?N2dYMFVGcEo0THk4Rk5hM3Rvc0lyTFFOK2VicFM5Y2VFTDREdTdERExvb2li?=
 =?utf-8?B?UXRpR0dMNStnNFZBK1RFZ2wrWm1nOGZzcFBMeERadklDeW0zRVg5V0p3VUFp?=
 =?utf-8?B?S3JDU2lHVlhqMmg3TzhMWVNMaE96MDR0cFVMTmdMUUtXa3Y0WFptbzRIYlNx?=
 =?utf-8?B?VnV6YmVvcWdEWUNYb25Dc214ZUFheGNpTjdHZ3pKaTJ3NitWamc3RGU3MzhO?=
 =?utf-8?B?dlNhYWV4SUlMMVRvckhPUUlzWWpOY05iNlZKUHBkc3h2bDNiUWEvdG9ORlAz?=
 =?utf-8?B?NytVS08vcnpFcEd0ZmFOTDh4a0JSMTRKZ3M1VS9qWm03Mzk5WXl0YjFCT1p1?=
 =?utf-8?B?b3JRQkpGL3RTQWs1WWEvZG8rYlhkOTM0SW55V3lDalJUVVgxdVZKckVYYXpz?=
 =?utf-8?B?NUxIMi83YTFNcEhVbkQwLzdlSndKdzk4YzZqK1dUODJaQVphYzFWVVMyQWhw?=
 =?utf-8?B?YXdpZHQ3NWlCT0twLzZ5NnZtb2lybThhNHFUd3hKSCtIV0N5Y3VkWlQ1a0NL?=
 =?utf-8?B?U3NDV3JkRTFsZzVYYTBaMHFCUjdhbUJxNmRpUVRLczlLS3ZaR2w2UmlZUVhF?=
 =?utf-8?Q?YzaakiZlUCNW3DDsNW/8bZY=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06433f52-3321-40da-297c-08dab6a03f07
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB2941.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2022 15:47:39.6677 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yT1tSS9n1nttjsKzItzxqRmxj7HdCKr6Yqi4pG3h9l4lUiAS6LL7JNQJ4T0hnB6niSAFwwWBiLWOmeinbrYyJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7144
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>



On 10/21/22 00:31, Ao Zhong wrote:
> After moving all FPU code to the DML folder, we can enable DCN support
> for the ARM64 platform. Remove the -mgeneral-regs-only CFLAG form the
> code in the DML folder that needs to use hardware FPU, and add a control
> mechanism for ARM Neon.
> 
> Signed-off-by: Ao Zhong <hacc1225@gmail.com>
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

Hi Ao,

This patch lgtm, but let's focus in the FPU isolation for DCN10/32 first.

After we get it merge, resend this patch but this time also add Arnd 
Bergmann, Nathan Chancellor, Stephen Rothwell, and Alex Deucher.

Thanks
Siqueira
