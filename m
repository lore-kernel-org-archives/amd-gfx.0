Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57DEEC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Mar 2022 10:32:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05CF810E8AF;
	Fri, 11 Mar 2022 10:32:20 +0000 (UTC)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 30E1F10E8AF
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Mar 2022 10:32:19 +0000 (UTC)
Received: by mail-wr1-x429.google.com with SMTP id i8so12242976wrr.8
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Mar 2022 02:32:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=8HNi12eH2/tUMOkhKj7SfiAXS0jOz0BWGI15frgciXo=;
 b=MUEB7QpAZvrpQRal9yuaaXC6WsrJa8hha59Za+evdfWZqfKbXsr4IAcSbTKCcF7c3G
 Lh+YtWsLgTixo2BcYZGgGHESg4LKYVzu72HVs30b152H8tJLXxK2+2GV7C4tE4SiBRif
 Ts4BQhNwPjTBGjkoJfa5IZYRPyubA67sg3MidsICsa9+b/waYDWpftpIyeO/l6V1+EBY
 J3YS3rhjXgXZW/ZjTOGXv39luqnP1VMDihN7d33RaSFGX7KhTILvDqV+XU+7oHHjqqgv
 EgL6KgX+OKGV07Kfk+Xhvdc0pWigRjFKNRvbYx16zgVmzlJVDTwLRDyX3MdehXgEeZsQ
 U42Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=8HNi12eH2/tUMOkhKj7SfiAXS0jOz0BWGI15frgciXo=;
 b=mBfGhIBXybWW33ZLVFIs37crEzc6T8Sz1lu8ON3c4AVmal2ff28I9SO2BiDs6Vf0k7
 WiksArWDJrg8gFYMSggo2rSrpQTVaGVH16+6XGBsvf8O0j2zujdkttPwhT2S9nZqZH0z
 xAf4c3ela11OpJBC5UJlpsGW3Y0zhkw452vIvAPEetrSsEJz7X/8Ba5CI1IFNCAEFxCC
 UVKAmHOl+L/d7izAOpI673IsUPWy54wrhHWCKtyby28ucU8Od6tk3G+XWFpuq16fKOZW
 QpgyX1Nd7o+NpIEzUld8uLPtcYlm5J4YknnbxYKZH2bxOvdDXwdx6dVCjcWyACl9Zxhw
 rsCA==
X-Gm-Message-State: AOAM530uGHeTEFQJU+qUvQzOJK7zZq13OczL9Z1qH7e2FsI36a+M8U6u
 VMRS3/oCSgvcgob/2WoIgig=
X-Google-Smtp-Source: ABdhPJyeJfITMkE5WkTevMZW2giTr5vtnlzbJTVxxBFK+6JWUm7Jmg5WKAiIIzV4SfILqAswpvMBBw==
X-Received: by 2002:adf:a198:0:b0:1f0:2477:3b79 with SMTP id
 u24-20020adfa198000000b001f024773b79mr6652963wru.24.1646994737635; 
 Fri, 11 Mar 2022 02:32:17 -0800 (PST)
Received: from [192.168.178.21] (p5b0eab60.dip0.t-ipconnect.de. [91.14.171.96])
 by smtp.gmail.com with ESMTPSA id
 q125-20020a1c4383000000b003899720641dsm10341026wma.30.2022.03.11.02.32.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Mar 2022 02:32:16 -0800 (PST)
Message-ID: <541dc1eb-cf50-17d2-0ae3-5c3cb3dc3ac0@gmail.com>
Date: Fri, 11 Mar 2022 11:32:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] drm/amdgpu/gmc: use PCI BARs for APUs in passthrough
Content-Language: en-US
To: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel.daenzer@mailbox.org>,
 Alex Deucher <alexander.deucher@amd.com>
References: <20220310180615.2245997-1-alexander.deucher@amd.com>
 <ed66fa3d-51c8-1cd1-8709-30f66eb82fd3@mailbox.org>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <ed66fa3d-51c8-1cd1-8709-30f66eb82fd3@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

Am 11.03.22 um 11:24 schrieb Michel Dänzer:
> On 2022-03-10 19:06, Alex Deucher wrote:
>> If the GPU is passed through to a guest VM, use the PCI
>> BAR for CPU FB access rather than the physical address of
>> carve out.  The physical address is not valid in a guest.
> I think amdgpu_device_flush_hdp & amdgpu_device_invalidate_hdp need to be modified accordingly.
>
>
> Also, I wonder if BAR resizing could work with APUs?

At least trivial to implement.

The host had to resize the BAR for the client or otherwise the client 
could easily bring down the system.

Christian.
