Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29E36C761A6
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 10:40:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 89B2910E18B;
	Thu, 30 Mar 2023 10:40:40 +0000 (UTC)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2AF1610E18B
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 10:40:38 +0000 (UTC)
Received: by mail-ed1-x534.google.com with SMTP id r11so74632525edd.5
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 03:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20210112; t=1680172836;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9sPHrSGxR0K3twHFs+FItgUvHLx41QmLql9ppIFsJ3w=;
 b=O4LWYl9H9jOc5asNz9wyWPmI8DP9yeha25Tm031IXhqGjgDXXH4vZGFn/nLs+ODBfy
 cx4NhHCcAHfZFxv6YAzTWl4V7jWyjFzQnVhH1i2K3YeAFHBivGlSQXeHjcoa9VyBKSTF
 nTnmBTgTDHZ078GwGvrVoYg2cM7nWOLN8K3dcnnnNUn24lgqvaPhKwGb64YUX2/fS9AJ
 AbhJFj7Ms4CW9v+qO9gpSsJYi38wEtLd3Dhons2lhT4fVk8qyY3NtS4vbkqFLsZx7kdh
 QbzI+nEG0YsITw+zqLZGB/spXPMPxl7zcUNEB8OLssUTu/9ljG+Z9uyD28/0Pgsw0Ogr
 kyag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1680172836;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9sPHrSGxR0K3twHFs+FItgUvHLx41QmLql9ppIFsJ3w=;
 b=0rfBj2sGVBZNQcMIbdLzlVDyusSI4nC051XYSUt6U8DotRMh5ASeaNfIgW/zCohB9U
 Z0czxzhbtvldYijsb7guRZE9yxy8e1IyUKblqbO89ZPyBUB+Xof+itpMOSniKkUm2LYb
 3nGsViuBwtBjfmZ+KzALat6H9eaTTGM4aXMuXSFNSjT1U9MwCQ6MjBxF5OQRpRKL9PnU
 Nr4d2HuZrbK1NPLHF/dqImy20jyW73dlWZG0D8futYTDshebXUlZYJvCjthVPvx0LKGy
 AfdIzAdsLk5f3b5EX53hUmJjDs9McSKi8c/AF7iq6sHdGQH+x7lNJ0Sk0ZQOPzwbwJv3
 5gjA==
X-Gm-Message-State: AAQBX9eUO6Fd2JUF/5TcKltSXR6r2w0fkwwiz5VtK24XlnCAizfzISkQ
 nxFXujzEYckFFmPVcyrS6vU=
X-Google-Smtp-Source: AKy350bhDKTluknkvAcIyEnOYJbJmwQALBz/rINKEtjGaS110bc+lx06VsaI+FdpnSPo4B+E8qzazw==
X-Received: by 2002:a05:6402:c4:b0:502:4875:721 with SMTP id
 i4-20020a05640200c400b0050248750721mr10810750edu.15.1680172836323; 
 Thu, 30 Mar 2023 03:40:36 -0700 (PDT)
Received: from [192.168.178.21] (p4fc2092b.dip0.t-ipconnect.de. [79.194.9.43])
 by smtp.gmail.com with ESMTPSA id
 u25-20020a50c2d9000000b004faf34064c8sm17810527edf.62.2023.03.30.03.40.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Mar 2023 03:40:35 -0700 (PDT)
Message-ID: <3c76552d-e6cf-cc89-1e57-e5ee789e79a6@gmail.com>
Date: Thu, 30 Mar 2023 12:40:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v3 1/9] drm/amdgpu: UAPI for user queue management
Content-Language: en-US
To: Shashank Sharma <shashank.sharma@amd.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric@damsy.net>,
 amd-gfx@lists.freedesktop.org
References: <20230329160445.1300-1-shashank.sharma@amd.com>
 <20230329160445.1300-2-shashank.sharma@amd.com>
 <71fc098c-c0cb-3097-4e11-c2d9bd9b4783@damsy.net>
 <48c60002-7f75-b0d0-fb7d-44b87d9cdedd@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <48c60002-7f75-b0d0-fb7d-44b87d9cdedd@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>,
 Christian Koenig <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 30.03.23 um 10:15 schrieb Shashank Sharma:
> Hello Pierre-Eric,
> [SNIP]
>> I'm also wondering why the doorbell needs a handle+offset but
>> other buffers are passed in as virtual addresses?
>>
> As you know, doorbell offset here will be an relative offset in this 
> doorbell page, but the MQD needs the absolute offset on the doorbell 
> PCI BAR.
>
> So kernel needs both the object as well as relative offset to 
> calculate absolute offset.
>
> something like: absolute offset = base offset of this doorbell page + 
> relative offset of this doorbell.

Another much more obvious reason is that the doorbell doesn't have a 
virtual address.

At least for GFX the doorbell is used to signal to the hw that new 
commands are available. So as long as we don't want a shader to kick of 
other work we don't need to map the doorbell into the GPUVM address space.

Christian.
