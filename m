Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05A71C433FE
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Oct 2022 02:11:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49C6D10E0AC;
	Thu, 27 Oct 2022 02:11:45 +0000 (UTC)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6121C10E328
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Oct 2022 21:17:21 +0000 (UTC)
Received: by mail-wr1-x42b.google.com with SMTP id bk15so28580214wrb.13
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Oct 2022 14:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mpUqJnN3IRrlpP6y/B/r/GfX6xnkl9vvgrz2WJRVxV0=;
 b=HeO8+7wnL7wg13wf0Go0QDw94KZH0uqiJwXiS5f/sWbicNmx1Jxd6M6LAS2dm6uMCV
 ZiGwXCnJq+FHE4Z3lE+y2xkNMp32zXutPb1RMMppBfW/lVDSszVHREP1eLmC+afd0tvQ
 LXOdbju1XwH/iLn4WRQ5HxvSiNmwOQCYjNXB2+94CLCN4AY+PDt5vAL3gzHR9vGmwih3
 mUdbrObDYKgp7nbmPzCjWI4/BfnzFhxgryEy3Zi4ejtbwUhyUMxycN6mfezTm7YCTh+W
 W92g0WZNITJQjDA3hKq/z2D5ecbrng0YAj/F6XYIk7m+sMe7ATcTfXzP6EeE35LCqHIm
 Tytg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mpUqJnN3IRrlpP6y/B/r/GfX6xnkl9vvgrz2WJRVxV0=;
 b=vRkjMwUrasV7YzOUPNM9x+8exDhGU5fw0rf4a27aYHpcWRh77zgQyqFJZMMKX6BC00
 C1spd2P7vn+PRtfXn2OlPWxAvIfQb6giD5vBG6+6qGG9GStJFHnxtGLFSmBsQ+C2YMOr
 alkTJGCCTP1exxEQrommVLD6am3E3a89nsfEbXc9Qw5+Gx5elfhRl2An8/dBQHsafPqi
 IfcRmGY3AWuNDO2D6mdqsce0w8q0yspNEFqUr0SQhH2mmiqIEwwNZlxwkHhhgx1pAoHW
 8WXOyuv0MVS1RuwiwmdgE28bWwB0A4OCMSiop5NrJgv9XR0Hr9hVUN/vdmpBk2zLd+yq
 vfbw==
X-Gm-Message-State: ACrzQf3Dh6QgBagcXO20LYPYdd8BKldJzfOGK2Di4eKo2dU1vl0ylUaF
 7oPQAk3vptpizK5QWIVhk2tzj5uLYJAMUrH1
X-Google-Smtp-Source: AMsMyM6t5iugkUU3Jl68fp2rEeVAJeKSzUAIr/QxVCIq72+KPoGwNQasxbbMcKgcyu7kZXZmZwXPIA==
X-Received: by 2002:a5d:64c4:0:b0:231:3d94:6eb2 with SMTP id
 f4-20020a5d64c4000000b002313d946eb2mr29519912wri.580.1666819039639; 
 Wed, 26 Oct 2022 14:17:19 -0700 (PDT)
Received: from ?IPV6:2a02:908:4f6:d280::9a6? ([2a02:908:4f6:d280::9a6])
 by smtp.gmail.com with ESMTPSA id
 h13-20020adfe98d000000b0022ccae2fa62sm5981606wrm.22.2022.10.26.14.17.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Oct 2022 14:17:19 -0700 (PDT)
Message-ID: <79d354e7-f61f-1f82-819d-91f4f2141fe6@gmail.com>
Date: Wed, 26 Oct 2022 23:17:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v3 2/2] drm/amd/display: move remaining FPU code to dml
 folder
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
References: <e4440d8d-61d3-5d71-ba48-79fec268f4af@amd.com>
 <20221026111258.25000-2-hacc1225@gmail.com>
 <d9de68d8-1c9e-7cef-cd82-ad0a6de59817@amd.com>
Content-Language: en-US
From: Ao Zhong <hacc1225@gmail.com>
In-Reply-To: <d9de68d8-1c9e-7cef-cd82-ad0a6de59817@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 27 Oct 2022 02:11:40 +0000
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

Hi Rodrigo,

Thanks for your review! This is my first time submitting a patch to the kernel.

I'm not very good at using these tools yet. 😂

Recently I got a Huawei Qingyun W510 (擎云 W510) ARM workstation

from the second-hand market in China. It's SBSA and has a Kunpeng 920 (3211k) SoC

with 24 Huawei-customized TSV110 cores. Since it's SFF form factor, and my machine

supports PCIe 4.0 (looks like some W510 have it disabled), I installed an RX 6400 on it

as my daily drive machine. It has decent performance. I uploaded a benchmark result on Geekbench.

Link: https://browser.geekbench.com/v5/cpu/18237269

Ao

Am 26.10.22 um 18:12 schrieb Rodrigo Siqueira:
>
>
> On 10/26/22 07:13, Ao Zhong wrote:
>> pipes[pipe_cnt].pipe.src.dcc_fraction_of_zs_req_luma = 0;
>> pipes[pipe_cnt].pipe.src.dcc_fraction_of_zs_req_chroma = 0;
>> these two operations in dcn32/dcn32_resource.c still need to use FPU,
>> This will cause compilation to fail on ARM64 platforms because
>> -mgeneral-regs-only is enabled by default to disable the hardware FPU.
>> Therefore, imitate the dcn31_zero_pipe_dcc_fraction function in
>> dml/dcn31/dcn31_fpu.c, declare the dcn32_zero_pipe_dcc_fraction function
>> in dcn32_fpu.c, and move above two operations into this function.
>>
>> Acked-by: Christian König <christian.koenig@amd.com>
>> Signed-off-by: Ao Zhong <hacc1225@gmail.com>
>> ---
>>   drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c | 5 +++--
>>   drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  | 8 ++++++++
>>   drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.h  | 3 +++
>>   3 files changed, 14 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
>> index a88dd7b3d1c1..287b7fa9bf41 100644
>> --- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
>> +++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
>> @@ -1918,8 +1918,9 @@ int dcn32_populate_dml_pipes_from_context(
>>           timing = &pipe->stream->timing;
>>             pipes[pipe_cnt].pipe.src.gpuvm = true;
>> -        pipes[pipe_cnt].pipe.src.dcc_fraction_of_zs_req_luma = 0;
>> -        pipes[pipe_cnt].pipe.src.dcc_fraction_of_zs_req_chroma = 0;
>> +        DC_FP_START();
>> +        dcn32_zero_pipe_dcc_fraction(pipes, pipe_cnt);
>> +        DC_FP_END();
>>           pipes[pipe_cnt].pipe.dest.vfront_porch = timing->v_front_porch;
>>           pipes[pipe_cnt].pipe.src.gpuvm_min_page_size_kbytes = 256; // according to spreadsheet
>>           pipes[pipe_cnt].pipe.src.unbounded_req_mode = false;
>> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
>> index 819de0f11012..58772fce6437 100644
>> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
>> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
>> @@ -2521,3 +2521,11 @@ void dcn32_update_bw_bounding_box_fpu(struct dc *dc, struct clk_bw_params *bw_pa
>>       }
>>   }
>>   +void dcn32_zero_pipe_dcc_fraction(display_e2e_pipe_params_st *pipes,
>> +                  int pipe_cnt)
>> +{
>> +    dc_assert_fp_enabled();
>> +
>> +    pipes[pipe_cnt].pipe.src.dcc_fraction_of_zs_req_luma = 0;
>> +    pipes[pipe_cnt].pipe.src.dcc_fraction_of_zs_req_chroma = 0;
>> +}
>> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.h b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.h
>> index 3a3dc2ce4c73..ab010e7e840b 100644
>> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.h
>> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.h
>> @@ -73,4 +73,7 @@ int dcn32_find_dummy_latency_index_for_fw_based_mclk_switch(struct dc *dc,
>>     void dcn32_patch_dpm_table(struct clk_bw_params *bw_params);
>>   +void dcn32_zero_pipe_dcc_fraction(display_e2e_pipe_params_st *pipes,
>> +                  int pipe_cnt);
>> +
>>   #endif
>
> Hi Ao,
>
> First of all, thanks a lot for your patchset.
>
> For both patches:
>
> Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
>
> And I also applied them to amd-staging-drm-next.
>
> Btw, if you are using git-send-email for sending patches, I recommend the following options:
>
> git send-email --annotate --cover-letter --thread --no-chain-reply-to --to="EMAILS" --cc="mailing@list.com" <SHA>
>
> Always add a cover letter, it makes it easier to follow the patchset, and you can also describe each change in the cover letter.
>
> When you send that other patch enabling ARM64, please add as many details as possible in the cover letter. Keep in mind that we have been working for isolating those FPU codes in a way that we do not regress any of our ASICs, which means that every change was well-tested on multiple devices. Anyway, maybe you can refer to this cover letter to write down the commit message:
>
> https://patchwork.freedesktop.org/series/93042/
>
> Finally, do you have a use case for this change? I mean, ARM64 + AMD dGPU.
>
> Thanks again!
> Siqueira
>
