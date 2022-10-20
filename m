Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82F8FC4332F
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Oct 2022 07:32:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8629210E601;
	Fri, 21 Oct 2022 07:32:46 +0000 (UTC)
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com
 [IPv6:2607:f8b0:4864:20::133])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F4B210E4CB
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Oct 2022 14:44:15 +0000 (UTC)
Received: by mail-il1-x133.google.com with SMTP id i9so10980631ilv.9
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Oct 2022 07:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linuxfoundation.org; s=google;
 h=content-transfer-encoding:in-reply-to:from:cc:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IBfoo0ZR1LqUTxxI8nZ0xV01VCZ+TW6nLMULNjoc3uo=;
 b=BeNrTxUjnoASgGvfLINqbhjWfHVS88LX8tTQXJI0f10WwgB/jKB95Jf7uMMF/Bob+1
 jtd7KEnqaaXaD1L8ufyDB8ejfChF/fAwOX/zb4odG+Te/k3bKgNmM4Kl0lHzsl4GYW10
 CmgjztShyYog+12GjTdYkSYajl4e9Ag8lv568=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:cc:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IBfoo0ZR1LqUTxxI8nZ0xV01VCZ+TW6nLMULNjoc3uo=;
 b=P+m9oLId9C4hzzZyE699Hdr8342NsGvlgBSUpHMSo5Q9TG23jgNRdH1f+TA0bgCAvj
 +LAC3bj28wWOxJua9N4xURVbgJeBiOyuVqwuqzov/RLfnZjY7LmE4dKKlf/tLmvEX5vR
 Rx0r6OVP2FC/hgqGnU0pK2uyzVs7TZqgKt53urY9ZojCoddwH8HKdizzodK4rYdhBZdf
 QlGeooBq1QNS7jYOVAsRK/3cA5DBVfyUyYGBsvKZh5wLImL24TaJQUvU/yZ5nBbFZaVh
 zMCHrB85J1TMsSJycuKHGcs47Df7HM3dZfov+O4B9Mq7tKLjbi7vp98LWTQpLJnJiuJU
 TytQ==
X-Gm-Message-State: ACrzQf2dg4e9rvDEibW/8ijGu8yqiuCgzmY4oBZE7E8UJMRYJfnS92kS
 hGDNRtQ7gps+KQpUfh+L0OtupQ==
X-Google-Smtp-Source: AMsMyM5naKfErMEQB2cSjcw+hXsHS9lDCeh77jiptJkXUIX3WtUsqbMT7Go7bDMoAjvstz+us2zbDw==
X-Received: by 2002:a05:6e02:1d04:b0:2f9:b199:b2ad with SMTP id
 i4-20020a056e021d0400b002f9b199b2admr10279363ila.198.1666277054120; 
 Thu, 20 Oct 2022 07:44:14 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1]) by smtp.gmail.com with ESMTPSA id
 k10-20020a6bba0a000000b006bbddd49984sm3428467iof.9.2022.10.20.07.44.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Oct 2022 07:44:13 -0700 (PDT)
Message-ID: <7e5388b0-fb60-9557-8bb6-588b3e320bfe@linuxfoundation.org>
Date: Thu, 20 Oct 2022 08:44:12 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] drm/amdgpu: fix sdma doorbell init ordering on APUs
Content-Language: en-US
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
References: <20221020034809.506525-1-alexander.deucher@amd.com>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20221020034809.506525-1-alexander.deucher@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Fri, 21 Oct 2022 07:30:36 +0000
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
Cc: Shuah Khan <skhan@linuxfoundation.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 10/19/22 21:48, Alex Deucher wrote:
> Commit 8795e182b02d ("PCI/portdrv: Don't disable AER reporting in get_port_device_capability()")
> uncovered a bug in amdgpu that required a reordering of the driver
> init sequence to avoid accessing a special register on the GPU
> before it was properly set up leading to an PCI AER error.  This
> reordering uncovered a different hw programming ordering dependency
> in some APUs where the SDMA doorbells need to be programmed before
> the GFX doorbells. To fix this, move the SDMA doorbell programming
> back into the soc15 common code, but use the actual doorbell range
> values directly rather than the values stored in the ring structure
> since those will not be initialized at this point.
> 
> This is a partial revert, but with the doorbell assignment
> fixed so the proper doorbell index is set before it's used.
> 
> Fixes: e3163bc8ffdfdb ("drm/amdgpu: move nbio sdma_doorbell_range() into sdma code for vega")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Cc: skhan@linuxfoundation.org

Thank you for fixing this quickly and getting me back to 6.1-rc1
on my primary system.

Reported-and-Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah


