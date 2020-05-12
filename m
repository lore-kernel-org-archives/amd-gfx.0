Return-Path: <SRS0=6vDE=62=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67011CA90AF
	for <amd-gfx@archiver.kernel.org>; Tue, 12 May 2020 16:54:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 335FB206B9
	for <amd-gfx@archiver.kernel.org>; Tue, 12 May 2020 16:54:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="PMxqvMZz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 335FB206B9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D89AD6E94A;
	Tue, 12 May 2020 16:54:31 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680063.outbound.protection.outlook.com [40.107.68.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABAD36E948
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 May 2020 16:54:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dSUqjXurQuxOxH0kvDFQ26wW/eYJR3Dr96sWEMkVI1mA1hrvQaVquwF5UDB92uhae8f+xI9elvCTylFWb+YtY7NA+HRERkDhet4hoboFL5HGbWX4T7zt9/FuueSuPAhmvoMCiW9IR2Co8ZGEag3kprDEsKi2GW1s9GTVoLvF8KDWIHr80VtVO5hI9PpyB5eRhp9aXUBI7nqk9NiVdxF4XR0Nyz9cRlJFOMhsV+WDUva/rVBKcozvczZ4AJjolO0iXmAF42l6adIySiDIu5Mngy4qjtFEwdlyth7YdiFIFCh5s4ghdOSuz2ahPRlz1aYFcUzSN6PHl4692baU0SLR3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2QqTvf5tyYwYnka3XvNohvxp6tCnnUiUIZVMB7Zpj0o=;
 b=ZWyx7vAfgSs4p4GqekYZ5hsF2aZ6KS7bB+oCimF/tJUZYvKnWVB/qQOZPEyRBGOta5OtnsS6hXHTnEnUpGzA8v6zU8R5cJ1SDMQI+6hOH3W8Mz2vxsyekrlQSUN+2puBr3qpEVu4JmPIU7nWQstdwim/dis4VobO9+Y43U1SRuuferz9ORswhQM0nIpSX6+bqJVH1qcP1EqjpP4hFhn9iqJbO53e6+uIp6hwiXy5xY3czl56EGEO10S1C7Nz6tg5xNPuv5khUDrd8u46gUpGb7dlYRxkCDFoUnQk+qJxFORGEb2tuaihiWXKes8qwRi9XlubsG6u2lGaIIkOZC7INg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2QqTvf5tyYwYnka3XvNohvxp6tCnnUiUIZVMB7Zpj0o=;
 b=PMxqvMZz+zyEVX0upA8U7Qkk4Lef0nY4NxXwDKzDvX1QeaVwla9sP19C3HfOFf5iGFOE3Q4e08fgBeqj4tNlmmdg3i2LBsipiH/jv5qmPYPB8D9FWWgY5vmig705/ylYeqJNW4IHgWP9Z6TZOtZmpPLDvB8bSmTvvhUNrmyiiOU=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3560.namprd12.prod.outlook.com (2603:10b6:a03:ae::10)
 by BYAPR12MB3143.namprd12.prod.outlook.com (2603:10b6:a03:a8::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.34; Tue, 12 May
 2020 16:54:29 +0000
Received: from BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::fd29:4119:9ef5:8210]) by BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::fd29:4119:9ef5:8210%7]) with mapi id 15.20.2979.033; Tue, 12 May 2020
 16:54:29 +0000
Subject: Re: [PATCH 1/3] drm/amd/display: Add DC Debug mask to disable
 features for bringup
To: Harry Wentland <harry.wentland@amd.com>, amd-gfx@lists.freedesktop.org
References: <20200512164506.26861-1-harry.wentland@amd.com>
 <20200512164506.26861-2-harry.wentland@amd.com>
From: "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
Message-ID: <abc30620-b441-8f03-91c1-ade40d9ebf6e@amd.com>
Date: Tue, 12 May 2020 12:54:25 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <20200512164506.26861-2-harry.wentland@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0009.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::22) To BYAPR12MB3560.namprd12.prod.outlook.com
 (2603:10b6:a03:ae::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.148.234] (165.204.55.211) by
 YTXPR0101CA0009.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3000.20 via Frontend Transport; Tue, 12 May 2020 16:54:28 +0000
X-Originating-IP: [165.204.55.211]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: dc0c5775-7d02-4a65-127b-08d7f69522b7
X-MS-TrafficTypeDiagnostic: BYAPR12MB3143:|BYAPR12MB3143:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB31433F5C8FC6105D2C362B9AECBE0@BYAPR12MB3143.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0401647B7F
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PLHJNwiNYavvcYQh99XBKCt+pxfnM9QQt7AOWlYJhR5cPpBnHWFWzpy1SxRBc0Rd06N4bUO+blQQCUAlvTrklhxBdh9zIS1HJ6kIvq0JjI+XpXR+2GjTlAElTUvlhYvAD0Y8HbrsGu9FgoFxBv4pC3v/j7AVNqPMmJ8AQNe/cGw6yvAcWFtIfWagdBLOfOnDyT8MoTCtoNuzX52bBw1aLiKX3BqNFdU8z8e+Ze8re5Aq6cwt+4IL5sil2mu3w+qGSOSg0768iXFQQ36etZ/OwVdcQvoADjop4gDP+O95i8wb9rJZkvGDusWTg5gzMtWjN1+tgeQ4dm5atYSilya4sVQoQyAWLxE9Iz1W06cHokhbtc8MXBBVZVBq7MtRen21MjidUsJ5iDAsLsUi/L7TlIikpAeg9hgrJZr2pf2mLBCYAP3oa0s5TLsgBVViaJM/arbD4o4jqbY48S/xZBwTQFI4bQJQqGXloDsfQD6vOnfvyDFMqp3e3AbPp2TgBXPc6E56bfmaQ6+LeGBqRmGlQ0pE3YsXOLMFLeYCfn0Q4VQ2t/TP62f/ThNZeu3juiJU
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BYAPR12MB3560.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(136003)(39860400002)(346002)(396003)(376002)(33430700001)(26005)(8676002)(5660300002)(66946007)(8936002)(31686004)(66556008)(956004)(31696002)(478600001)(66476007)(2906002)(6666004)(86362001)(316002)(16576012)(33440700001)(53546011)(36756003)(16526019)(52116002)(6486002)(186003)(2616005)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: NOCitOisHOWvYZZbH9RHD4yLbZ3gyUhImv36limnrMclyFL0rr1eBEoIElAN6l+lDil20G76rFnyJnvfLf77xV9sFDNxYG3ix56EMIaRmT8Td0cWPTLSau2sKErGinjiLDF2aTM8JsAKuTVRICXYaEJyov88SUvmMIBkCacgRh9tBgQZvh6JDwyik2JHpJeTKuRjd3i0iKRdgenYLFgy78lhZkHqTcDF32IUV8xmA/VepZo42Lp3E7wxSmzulvUaZwczDe+66RYf7MD5ObMGKqo4792evftKvgMreHbmqph5ECJ8zQ1IohuYKMggEOCkIbSuPCsmeZIRbh0VUlgTo781vH4SdRfiFtSbR/mzDsvuOfMI8Rdj6ieXC+3cMDJDKnLsZXjfAh7qQK1OPs3FXYygoAcAgKfcg9ZGfqt48QK/44+9eyw2CacfC7QbavA/vhzwdarvMgDeThP6u2hdYnw91esLQYNtP4mkJ07PLEY7H/0KfTBxDEE5juYWp9b+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc0c5775-7d02-4a65-127b-08d7f69522b7
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2020 16:54:29.1196 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tFOF+lgZiyMTCiunJG/bmniCMYJjv+gzcoN+CcT+VS2kiTddccFY2ur5U8g843w6+GJSkUj9fIikpt12hATXPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3143
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2020-05-12 12:45 p.m., Harry Wentland wrote:
> [Why]
> At bringup we want to be able to disable various power features.
> 
> [How]
> These features are already exposed as dc_debug_options and exercised
> on other OSes. Create a new dc_debug_mask module parameter and expose
> relevant bits, in particular
>   * DC_DISABLE_PIPE_SPLIT
>   * DC_DISABLE_STUTTER
>   * DC_DISABLE_DSC
>   * DC_DISABLE_CLOCK_GATING
> 
> Signed-off-by: Harry Wentland <harry.wentland@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu.h               |  1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c           |  8 ++++++++
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 14 ++++++++++++++
>   drivers/gpu/drm/amd/include/amd_shared.h          |  7 +++++++
>   4 files changed, 30 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 2a806cb55b78..13c8ccdb2948 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -173,6 +173,7 @@ extern int amdgpu_gpu_recovery;
>   extern int amdgpu_emu_mode;
>   extern uint amdgpu_smu_memory_pool_size;
>   extern uint amdgpu_dc_feature_mask;
> +extern uint amdgpu_dc_debug_mask;
>   extern uint amdgpu_dm_abm_level;
>   extern struct amdgpu_mgpu_info mgpu_info;
>   extern int amdgpu_ras_enable;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> index 589000938ab6..76707491657e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -140,6 +140,7 @@ int amdgpu_emu_mode = 0;
>   uint amdgpu_smu_memory_pool_size = 0;
>   /* FBC (bit 0) disabled by default*/
>   uint amdgpu_dc_feature_mask = 0;
> +uint amdgpu_dc_debug_mask = 0;
>   int amdgpu_async_gfx_ring = 1;
>   int amdgpu_mcbp = 0;
>   int amdgpu_discovery = -1;
> @@ -714,6 +715,13 @@ MODULE_PARM_DESC(queue_preemption_timeout_ms, "queue preemption timeout in ms (1
>   MODULE_PARM_DESC(dcfeaturemask, "all stable DC features enabled (default))");
>   module_param_named(dcfeaturemask, amdgpu_dc_feature_mask, uint, 0444);
>   
> +/**
> + * DOC: dcdebugmask (uint)
> + * Override display features enabled. See enum DC_DEBUG_MASK in drivers/gpu/drm/amd/include/amd_shared.h.
> + */
> +MODULE_PARM_DESC(dcdebugmask, "all debug options disabled (default))");
> +module_param_named(dcdebugmask, amdgpu_dc_debug_mask, uint, 0444);
> +
>   /**
>    * DOC: abmlevel (uint)
>    * Override the default ABM (Adaptive Backlight Management) level used for DC
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 60fe64aef11b..bf347ca43064 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -918,6 +918,20 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
>   		goto error;
>   	}
>   
> +	if (amdgpu_dc_debug_mask & DC_DISABLE_PIPE_SPLIT) {
> +		adev->dm.dc->debug.force_single_disp_pipe_split = false;
> +		adev->dm.dc->debug.pipe_split_policy = MPC_SPLIT_AVOID;
> +	}
> +
> +	if (amdgpu_dc_debug_mask & DC_DISABLE_STUTTER)
> +		adev->dm.dc->debug.disable_stutter = true;
> +
> +	if (amdgpu_dc_debug_mask & DC_DISABLE_DSC)
> +		adev->dm.dc->debug.disable_dsc = true;
> +
> +	if (amdgpu_dc_debug_mask & DC_DISABLE_CLOCK_GATING)
> +		adev->dm.dc->debug.disable_clock_gate = true;
> +

Series is Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

Note that we fill in device defaults during dc_create, but there are 
some debug options which we unfortunately do reference during 
dc_create() itself which would apply some options too late in the sequence.

Fortunately, I don't think that's the case for any of these debug 
options, but it's something to keep in mind at least. That's what the 
init_flags were added for I think, and those generally have preference 
over debug option overrides when available (from my understanding).

Regards,
Nicholas Kazlauskas

>   	r = dm_dmub_hw_init(adev);
>   	if (r) {
>   		DRM_ERROR("DMUB interface failed to initialize: status=%d\n", r);
> diff --git a/drivers/gpu/drm/amd/include/amd_shared.h b/drivers/gpu/drm/amd/include/amd_shared.h
> index d655a76bedc6..92126c54cb1c 100644
> --- a/drivers/gpu/drm/amd/include/amd_shared.h
> +++ b/drivers/gpu/drm/amd/include/amd_shared.h
> @@ -150,6 +150,13 @@ enum DC_FEATURE_MASK {
>   	DC_PSR_MASK = 0x8,
>   };
>   
> +enum DC_DEBUG_MASK {
> +	DC_DISABLE_PIPE_SPLIT = 0x1,
> +	DC_DISABLE_STUTTER = 0x2,
> +	DC_DISABLE_DSC = 0x4,
> +	DC_DISABLE_CLOCK_GATING = 0x8
> +};
> +
>   enum amd_dpm_forced_level;
>   /**
>    * struct amd_ip_funcs - general hooks for managing amdgpu IP Blocks
> 

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
