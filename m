Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B3AECA0FF7
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Sep 2023 18:47:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A76DF10E3E9;
	Tue,  5 Sep 2023 18:47:01 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2066.outbound.protection.outlook.com [40.107.244.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8520910E44F
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Sep 2023 18:46:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C4KaEX+OsnPqKW9p+tDKZiayKonjQIhpDDoC7CmmErA0IjsF/LPq8gMw3oQ/xd2YTt+AVsvDNcVqVmG4d2ib3PhA2aQbVsRdB89JQOA0PSKNG4CpMKqKwwx9d7OX46E40w4q6INv2kfVeoNStMp2lBVggO2oTRcPnfGrqkfwMf89CCawtTy1A95OT/XOxyK7ygbVt5GNQuLToYuKZqd7JQyl13Cc75lotV3LAPm10x/Sk9r7BgL+RfuZdf4QpFEI9fWhDU0/Sxv1Z1JEGQXZqElRMSEinAPQIERN/Ujt2jp0BlqAsg1KNxx85MtTsgN3yPXmVkv1kDlt5I/ZyaslxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EPMNNmwXJgDFP40NmtnPSwoSrZZMF21ufRgfpuu/QcQ=;
 b=XJjBtSOAt9AJIxkEJmtbTWfR+KloCmN8s0LaJj2285KK9aHYuQPOe0fcXhHWlMBdq8Ar5BMsL2KI+KxLDQivx345hrO4BEW7M2oZHqpASZjvXtWwxUrwUyTNiqUYCVX4+vXKBoTtCOQ9krbjDM6FtPwsjzy4VSXxPCtLB03G/48Gc5HR+nhPT0R3d/tT/t2kjCh1BNBakff0DgAPxfhh8nBo9x7zcgja97vV9CStFgTIgrsdkS7KgRZ2uCohjbtyVSPWx27AkOfUJMvOVrPK8Z2wSG9pf5lEHxwytmXfeYP3LyHUujbK/IsxHQ5PArkufnoj76CYxCLiBShJJ64Trw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EPMNNmwXJgDFP40NmtnPSwoSrZZMF21ufRgfpuu/QcQ=;
 b=Qvv2GnqJmgKuAaU7Ul7Rpls9cVlHR/p2zxkheZ+fIjp8wr0XGG+np+VIdSCd7SDBev5Azwudrde3YYgy+oSqAaAdlKaN88bLCHnX9bQwYIai/2tcdS8Wn5CTdmxZhmbMocmqMiri84aLDVqoWZ0sghWhrJWUZ+DrdA5pgZnmJ34=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3048.namprd12.prod.outlook.com (2603:10b6:a03:ad::33)
 by CH0PR12MB5108.namprd12.prod.outlook.com (2603:10b6:610:bf::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Tue, 5 Sep
 2023 18:46:56 +0000
Received: from BYAPR12MB3048.namprd12.prod.outlook.com
 ([fe80::1dd2:153c:f0bc:b80d]) by BYAPR12MB3048.namprd12.prod.outlook.com
 ([fe80::1dd2:153c:f0bc:b80d%6]) with mapi id 15.20.6745.030; Tue, 5 Sep 2023
 18:46:56 +0000
Message-ID: <0e06b822-cecf-2f2d-d2e6-da739ae479e9@amd.com>
Date: Tue, 5 Sep 2023 12:46:53 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 01/18] drm/amd/display: Skip entire amdgpu_dm build if
 !CONFIG_DRM_AMD_DC
Content-Language: en-US
To: amd-gfx@lists.freedesktop.org
References: <20230816212626.987519-1-alex.hung@amd.com>
 <20230816212626.987519-2-alex.hung@amd.com>
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <20230816212626.987519-2-alex.hung@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ2PR07CA0013.namprd07.prod.outlook.com
 (2603:10b6:a03:505::15) To BYAPR12MB3048.namprd12.prod.outlook.com
 (2603:10b6:a03:ad::33)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB3048:EE_|CH0PR12MB5108:EE_
X-MS-Office365-Filtering-Correlation-Id: be955522-614c-4524-10be-08dbae407aab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BwNsW9ZCS1A/7FdadL7xQCN9mIwj/5fq8+KroDIjLZXlQ2YG5NbGY4Ge3qW1aQ2hiLFdNps+8BUiqwHa0vQmB3+0gvMNoAyfilnT3RoZ9u0NXK8nCPPnlwe8ADuFgQojsbxyHJ/zvi5QN1ka9YiCq/ORZ1Su1DbpFZ4MV6QAHY+9KF7wVksjdDRdAGlL6+TySDvToPvZwoHiJuYG/hHQqPNZ7gFxDymkZwH0J2dQ5ETuVOtxiy07ui91cG2m3EYNIPAFMoqgGhMKiLw+FYdg1SS3aLtemNWL6i+gLxETHI80xhpv9lB7lUGHw0uhOMeizavHR8KI00vDzRW6smdjcyIfFyRWkXsSI70SR7XGd5V4UYEY4ZKBvM/1foFmozH6UiSKOxY7pZE/f9/DyolVL+R7YcIMa8EFVuXERCxRJihmU2AfqMohQ3DoGvPtFPUzT5QwwSvEk03XnPlgAd2DW6ePAuQ6gKMZ0C3wwhHikZ9uV8UUm/d6hRmGmisL0o/N9gubDPSgslOCxISRA8O4FkzYkctNEOg/+Jvi71hbXUll9MeG0OTF1cmALfViPPxALUWOW4JVGN8+pp5SQpcLr2xaIMBbME8TeRJjowPOap/1RzD6+gUfcfo2dn/jPAmTycibfAAzxp+T0UEUXNn0oQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3048.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(346002)(366004)(136003)(39860400002)(396003)(186009)(451199024)(1800799009)(31686004)(36756003)(53546011)(83380400001)(8936002)(31696002)(5660300002)(4326008)(44832011)(8676002)(6506007)(2616005)(6666004)(26005)(86362001)(41300700001)(6512007)(6486002)(478600001)(38100700002)(2906002)(316002)(66476007)(6916009)(66556008)(66946007)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NzI3NTRaOUVncndKRnBuYUh6UDVOdHF3MFpoTVVlc1lSK3ZoM3pxd09JT1BO?=
 =?utf-8?B?OFdNMTcyRFZuaXFtYjhtUnFyYkswQkxkSHppd01YVmxpZUhqR3FqajkrUS9D?=
 =?utf-8?B?RHpJc1BpYjc1d1ZxRks0YSsrY2Q5UjM2N3hheUtua1VaMEFQVmFaMWFvU0h5?=
 =?utf-8?B?ZHZ2dnBkRzRTOHhzREQwRlRabCs0K3hJeVFzSlVqbUxVdmNpTyswQmNwTG9T?=
 =?utf-8?B?ZUR1ZlJGcUVLYlB2OU1HV05kUG5CanVKa1d3RkY3SnhUTTVRdVJkTTRLeVl0?=
 =?utf-8?B?Z0VMVW9nZWVsS2h5MzBPZFZXcnhYM0Y1NlVqRllPMlVFQ241am5CWVJ6YUhr?=
 =?utf-8?B?dlRoaEFySnNRc2ZGdkpLa21vajA1SDh1QW1pNmhNQ1E1SUR4WHE3bTB4ZkJa?=
 =?utf-8?B?SUR1VXVFUzRxSFpLSWIxZS95amJjcGNoRWx6MkRjWjNyN0NsZnVTZHZRM3FD?=
 =?utf-8?B?RTRFYnBMSkdST1RDNmZjRDRvcUFzd3dEbFhvRnF1ZFlYdUFTNlBSVmg2MFlo?=
 =?utf-8?B?K0hNclhWMTIvRlRScHo5azI1d2k2SUpHQzJxMXdFV29aOEFxcEhwdUlrYTJw?=
 =?utf-8?B?ZkdTbVU5cWdoTEJCTWR1c2Y1eW4yN2REY0tHV3pEODAyOUpxSFZRRWhwMXBp?=
 =?utf-8?B?aW5MczBFVWxBRUtBajlHU2doZlk0RDU5T0lHc0twbXZnNUJxVGRMRzdXRzlG?=
 =?utf-8?B?dFE3WWZzYmdScFhqVzl6NGUwdHM0Ty9nS24yNk8wYzdiRjZYTDBoWWd0ZGVJ?=
 =?utf-8?B?R1prVXB0QXphZ0xaazI5RVptanBZUGg5RmNTTXlzUFBzZXZJZ0JrYnRabUdU?=
 =?utf-8?B?OEdqY2U0VFZreXRkV0xaZ1pSVGxlTDF4dnB0NDdITmJCTzQ5SkY2MG5BK3lq?=
 =?utf-8?B?Qkg3U01XaFJPWGdIR2VxT2NSckhqb2tZRWNKS3pUYlQ0elFxeDRvbm51RHh4?=
 =?utf-8?B?SmJrZUdHT2dOZG40RHc4cnU1amlqVTkvVzB6TWxEeHZJd1FNYnRscnpYSjFR?=
 =?utf-8?B?Wm5FeEl1cGYwRXZhaDZsQURxQ2VzRmQ5VkFqN0hkSG1McUN1ZTBCUDhBbU1w?=
 =?utf-8?B?QXRpUTBkRzhHTU9sS2ZYTHp3ZXIzeFVoNm8xc1pDL2c5bDcveWxvSlo0SWov?=
 =?utf-8?B?UU9ZUFlWdEowZzhtV3VUci93YlFkKzY4T0RXYTZsWTJqa2c5Ky81ajI1ZytC?=
 =?utf-8?B?d0lPNWZid1hQN1JxcEplWUpZc2tKSklIZ0g4WFpmWm1NdTVzNWhJV1BDcXpC?=
 =?utf-8?B?dWxzSzVVekMxemRjN1IxWE5FQzNjY0FqNk1Wbm1zNWplekM3MnhhSFUrUlZM?=
 =?utf-8?B?Tk9sMW8yZGdPNlRFZ0YwdFJyYTlzV2d6WVlLa1dicWpSb2FQbUZVV2UvZGFX?=
 =?utf-8?B?S3U2KzFiUDNVQUR0Tk43WVc4THorZmVXNzRrVkhiVEpQc1VoM3d3YjRiRW54?=
 =?utf-8?B?QWVEb3JaQkU5cmc0REpCajd1Y2tLWXIvanJvdVg2eFJSQlUyTHhKcUtnSWEv?=
 =?utf-8?B?UmdTNEhUbHpOQ0hZYW9OMnhGOVRQazEwTUJSTEdOOUZpcXVjd1lkWVdtRnpR?=
 =?utf-8?B?UFJxRmZxQTEyS3BBZUZERmN2Wi9OeGY1bk5QWFZLV1RqZTgwSDczR0luM2Vq?=
 =?utf-8?B?Z3h3Mm9vQ1cybDhISGttOFlHRkp0TWQ0LzQ0OEEyMG9veHp4NlV2UU9raXUr?=
 =?utf-8?B?K0J5K2cvU3FuK3FLaEhsb0w0TCtIeW9nTnkvY2lUamZJc0RIZVpLUnBIaFJX?=
 =?utf-8?B?bFBoTkNhMUVraUxwQ1pDeWxzZXRVZzhJL1gxTnpUM052aGNhLzc1MXVZS3Jw?=
 =?utf-8?B?RGNheXpoSzQveUhhb3orR1plVkJIN0pwdEhPOWN4RnpENHNhQXoyVEFxWHZP?=
 =?utf-8?B?UldvYkwvZjFPeGRHckRxZUlqSklCK3FHRHpIay9oNkdKUXFxNnZVMzNZNEF0?=
 =?utf-8?B?SnhvMndreGtETjdjSUVwYnJBQkRjbTM4SkM0SGF0VlEybDdJWXRNMTd4WnA2?=
 =?utf-8?B?YitzVGMvd1VHRHVFclJJYXpvRDRmbWtDMUNqQlVOMWVydk96V05qMmJvcFh5?=
 =?utf-8?B?QUJHWFN3UFMxaEgzaVAxQzdCWmt0V3dYanlESlJZcWM1NzFlMzJ4amhzR0l4?=
 =?utf-8?Q?Q/OepD3jaiVGSBOdEEHIznb6l?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be955522-614c-4524-10be-08dbae407aab
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2023 18:46:56.3838 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VfdKl0OuVqh1qaQmbhoNrycsC7pX+UHFX8iLfgzeMCnBtexM+eI5VtQZqkf6I3Zup0GKTWqxkwx6NRDJhl6PtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5108
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
Cc: alexander.deucher@amd.com, harry.wentland@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Alex Hung <alex.hung@amd.com>

On 2023-08-16 15:26, Alex Hung wrote:
> From: Harry Wentland <harry.wentland@amd.com>
> 
> [WHY]
> Previously this only excluded build for a few amdgpu_dm
> binaries which makes no sense.
> 
> [HOW]
> Wrap the entire Makefile in "ifneq ($(CONFIG_DRM_AMD_DC),)"
> 
> Signed-off-by: Harry Wentland <harry.wentland@amd.com>
> Signed-off-by: Alex Hung <alex.hung@amd.com>
> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/Makefile | 13 ++++++++-----
>   1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/Makefile b/drivers/gpu/drm/amd/display/amdgpu_dm/Makefile
> index 8bf94920d23e..063205ecb137 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/Makefile
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/Makefile
> @@ -25,22 +25,24 @@
>   
>   
>   
> +ifneq ($(CONFIG_DRM_AMD_DC),)
>   AMDGPUDM = \
>   	amdgpu_dm.o \
>   	amdgpu_dm_plane.o \
>   	amdgpu_dm_crtc.o \
>   	amdgpu_dm_irq.o \
>   	amdgpu_dm_mst_types.o \
> -	amdgpu_dm_color.o
> +	amdgpu_dm_color.o \
> +	amdgpu_dm_services.o \
> +	amdgpu_dm_helpers.o \
> +	amdgpu_dm_pp_smu.o \
> +	amdgpu_dm_psr.o \
> +	amdgpu_dm_replay.o
>   
>   ifdef CONFIG_DRM_AMD_DC_FP
>   AMDGPUDM += dc_fpu.o
>   endif
>   
> -ifneq ($(CONFIG_DRM_AMD_DC),)
> -AMDGPUDM += amdgpu_dm_services.o amdgpu_dm_helpers.o amdgpu_dm_pp_smu.o amdgpu_dm_psr.o amdgpu_dm_replay.o
> -endif
> -
>   AMDGPUDM += amdgpu_dm_hdcp.o
>   
>   ifneq ($(CONFIG_DEBUG_FS),)
> @@ -52,3 +54,4 @@ subdir-ccflags-y += -I$(FULL_AMD_DISPLAY_PATH)/dc
>   AMDGPU_DM = $(addprefix $(AMDDALPATH)/amdgpu_dm/,$(AMDGPUDM))
>   
>   AMD_DISPLAY_FILES += $(AMDGPU_DM)
> +endif
