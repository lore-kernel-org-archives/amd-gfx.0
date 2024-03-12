Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BDEBC54E66
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Mar 2024 10:20:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97E3010F6FA;
	Tue, 12 Mar 2024 10:20:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OD2nxHAa";
	dkim-atps=neutral
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com
 [209.85.167.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F91510F360
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Mar 2024 10:20:41 +0000 (UTC)
Received: by mail-lf1-f48.google.com with SMTP id
 2adb3069b0e04-513af1a29b1so1801443e87.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Mar 2024 03:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710238840; x=1710843640; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=E5lYM+poTbyZPbKmS5yDOJdwVky2nCNCI6GrNJvDjl4=;
 b=OD2nxHAa/P2Q7oFUhls1EHulw8pLkYGZxH3lDqIAAIORZ7WKXUXf3sPASABgGf0fMq
 YAiIjTUwDbcHCS1NPO4pdCz/xrWO5FKnBLGq+STr0N7nn4R8tDHkCR2ZwxWMq5kYR5pe
 W4DgmyHuU66CQHhtlDKKqoXwM5NgsZNEoqED9VHKd/PdcREPze5mtgLcC846rE191Ogz
 ZlIpYV5DW2G/lepyO2T0CpxZN4L/WdTyDmXUwhgID2HJpRpdRoVSrF5rT+5NLIXCntf5
 KoSJ5zCFpcXUQJ5ePM8Te4FIVAZCRQBpy+GHw3/Su+E/kRqb/siHeZ+w91EpNVMCRISY
 INig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710238840; x=1710843640;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=E5lYM+poTbyZPbKmS5yDOJdwVky2nCNCI6GrNJvDjl4=;
 b=Zl0QHa7Gl9DBu6u0taq7P0Mt0HnNhjOmJNfDSrXosLJ9aSgUuCoyuU0BRFhKb8okcZ
 /Q+bqqhca+e1oYF55f/tItJt9/AdwLA5aDPDCi0wyLGN4Dyl3tNmIGzXlS3QZDugLl8+
 HbdV4uiuunHiPKgoBq5BFcoqJlRJ+owBegnnythAYXE7JdwwDFvce3DZobqqNm4JNiZ7
 xT6pCwYKgR4uXE1IBriHd0u9wizu8Lx+oO/W585sefvdtRU18ncnIwOUeZjE9hDjG2I7
 OyYlfQpvEUEV29P6on3b62kO3GwJFkhdITDgjY4e7dR+QQ7flFBhQmBLFRqtpcnTvliU
 vSKw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUhV6KCJG5q36ovaBMBp6ttoTiT+AkNVWRTwj9T0Qv9VdbBvOpwHBv3/kI00PV2ZjVgbCArOeFZdBgDJz5I3aMmZ2Ys8eoHzfb+39abw==
X-Gm-Message-State: AOJu0YzmUVfgTXUeEl+MCKbd2u65kzOduNb5tq2eX/zX+lAsBY68qUZE
 IIdB2GparIn+p/pWyyOsytU1KGoC8eVaSJDgZdo/doFosYHBNcq9ER9mPEBxkuk=
X-Google-Smtp-Source: AGHT+IFQykNU5cc/YBJ9IfqKeFQkvf1EhWjwV9iXkkzPYLq0MGvp+GUccrh18jggBeEMU55WW4QMfg==
X-Received: by 2002:ac2:57c3:0:b0:513:95b6:2e78 with SMTP id
 k3-20020ac257c3000000b0051395b62e78mr5169183lfo.59.1710238839404; 
 Tue, 12 Mar 2024 03:20:39 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 v9-20020a05600c470900b0041312e8ef2bsm12081223wmo.26.2024.03.12.03.20.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Mar 2024 03:20:39 -0700 (PDT)
Message-ID: <bbd11daf-edba-4986-ae33-4abf2ee36f61@gmail.com>
Date: Tue, 12 Mar 2024 11:20:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/43] drm/amd/display: Enable 2to1 ODM policy for DCN35
Content-Language: en-US
To: Wayne Lin <Wayne.Lin@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Harry.Wentland@amd.com, Sunpeng.Li@amd.com, Rodrigo.Siqueira@amd.com,
 Aurabindo.Pillai@amd.com, roman.li@amd.com, agustin.gutierrez@amd.com,
 chiahsuan.chung@amd.com, hersenxs.wu@amd.com, jerry.zuo@amd.com
References: <20240312092036.3283319-1-Wayne.Lin@amd.com>
 <20240312092036.3283319-4-Wayne.Lin@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20240312092036.3283319-4-Wayne.Lin@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

Just another general comment on how to upstream patches.

When publishing a large set of patches it is usually good convention to 
sort them:
1. Bug fixes which might even get backported
2. Comment and other non function cleanups
3. Functional cleanups
4. New features

One good reason for that is that it usually makes fixes much easier to 
port to older kernel versions, but it also makes things easier to review.

If you are in doubt if a patch set is still fully compiling after 
re-ordering things you can use the command

git rebase -x make base_branch

On your branch and git will run a make between after applying each 
patch. This way you can double check that everything still builds fine.

Working like that is not a must have, but really good practice.

Regards,
Christian.

Am 12.03.24 um 10:19 schrieb Wayne Lin:
> From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
>
> [Why & How]
> Enable 2to1 ODM policy for DCN35
>
> Acked-by: Wayne Lin <wayne.lin@amd.com>
> Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> ---
>   drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
> index 5d52853cac96..a8f4023ff3b1 100644
> --- a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
> @@ -769,7 +769,7 @@ static const struct dc_debug_options debug_defaults_drv = {
>   	.support_eDP1_5 = true,
>   	.enable_hpo_pg_support = false,
>   	.enable_legacy_fast_update = true,
> -	.enable_single_display_2to1_odm_policy = false,
> +	.enable_single_display_2to1_odm_policy = true,
>   	.disable_idle_power_optimizations = false,
>   	.dmcub_emulation = false,
>   	.disable_boot_optimizations = false,

