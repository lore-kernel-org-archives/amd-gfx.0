Return-Path: <SRS0=Ip1/=KM=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8317FC433B4
	for <amd-gfx@archiver.kernel.org>; Mon, 17 May 2021 06:56:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4ABF761076
	for <amd-gfx@archiver.kernel.org>; Mon, 17 May 2021 06:56:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4ABF761076
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D323589FD3;
	Mon, 17 May 2021 06:56:26 +0000 (UTC)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 79F3D89FCC
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 May 2021 06:56:25 +0000 (UTC)
Received: by mail-ej1-x636.google.com with SMTP id c20so7544144ejm.3
 for <amd-gfx@lists.freedesktop.org>; Sun, 16 May 2021 23:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-transfer-encoding:content-language;
 bh=JDkFstx4C2H/WyD2bgrfw1Szju57npRTXiy2p67jTiQ=;
 b=fnN8WdoX0Po2Y1NvybM+5VHjyWA/gELX6JFVlGZj+HbdHncyvla6Q2g9DIghcNNoXj
 GpYdlnjVW3MWIzodfeYdTZgc+jdJlreYNd7N9q13Xt7ulZzQlo+kDH8jZQx+M7CFBq77
 dtCS0Hx6eB7i+VIf/LRaJhnsBS684wFSLpCOC6r20Psws5nsUED4fIli9KyR4JTw/icQ
 lZQ+nTED5xkwIariDNFUv00nxY9dkS2YD5npING1Pyef6KqfHbhbCD/37q/AUaGCrpRL
 8TQOIWqgbMQLqnKc8QM/QNgrz4CfrypENSV2OODmdcBptfvpAOmgrK83D319axWw3VYx
 /SEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=JDkFstx4C2H/WyD2bgrfw1Szju57npRTXiy2p67jTiQ=;
 b=n0woOb7TuTonJfcBXFmtZG3i1pnuNWSC7MIE3rHgmTs3qxpzjyLB0jtxNof5UPn4GU
 EMNFFfaBcEH96/+c41aZGLYJtcrmJKZRIfhEYuAmXvuo79jV7IFupacprim6DY+AJym7
 0p3vUxE8al4D4Gx1LoUQJNsq0gMRXmppm77nQjczP4kL1ewukYevXkzFNqe4IRwGyeeZ
 ytTiRgeGjDra8tVcdkZ8GFiOZ4FA5Q5OqsiXxaAlGivI3B0tMiDkmD0Bvam/ldE49XJz
 86hnXuQFPWReb2rqabSH7NATZfANt7/QLZhO2YpKQfMmzH7nVySByy+npDJg/xAZqzxt
 8d/A==
X-Gm-Message-State: AOAM532ucsBVlhJQ/w+Tv+LYjkgAVeSy20Fisppg8viEp7UVjrG4uJ3l
 eSCmfqm0xP1H4tWYSwCNouv5V2uqFc8=
X-Google-Smtp-Source: ABdhPJwL080k1ccDXxGAjx2gPaJ3Xc4CU39xX0EaQH4RqNd8NEPhuG3teSAz4fVZ3261u4Sy6R4Q1g==
X-Received: by 2002:a17:907:9729:: with SMTP id
 jg41mr30689500ejc.385.1621234584200; 
 Sun, 16 May 2021 23:56:24 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:6bbe:b48c:2de1:422d?
 ([2a02:908:1252:fb60:6bbe:b48c:2de1:422d])
 by smtp.gmail.com with ESMTPSA id e11sm10187032edq.76.2021.05.16.23.56.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 16 May 2021 23:56:23 -0700 (PDT)
Subject: Re: [PATCH] drm/amdgpu: optimize to drop preamble IB for old GPUs
To: "Chen, Jiansong (Simon)" <Jiansong.Chen@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20210517043940.99603-1-Jiansong.Chen@amd.com>
 <bc81cba1-b338-3ef3-c488-178768d14637@amd.com>
 <BY5PR12MB48858069A0EBCDBED03B6052EA2D9@BY5PR12MB4885.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <492b38eb-bf99-bdd1-b874-c95905b79a5f@gmail.com>
Date: Mon, 17 May 2021 08:56:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <BY5PR12MB48858069A0EBCDBED03B6052EA2D9@BY5PR12MB4885.namprd12.prod.outlook.com>
Content-Language: en-US
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

Am 17.05.21 um 08:51 schrieb Chen, Jiansong (Simon):
> [AMD Official Use Only]
>
> Doesn't  current solution always enable the optimization in a safe and more clear way?

No, we also need this for gfx8 where gfxoff is currently not implemented.

Additional to that we mix common frontend handling into the backend with 
this approach.

But you could clean up the code in amdgpu_ib_schedule() quite a bit.

Regards,
Christian.

> 1. for gfx8/9/10 we use load_ce_ram in context_control to control the optimization.
> 2. for gfx6/7, we directly drop the preamble ib.
>
> Regards,
> Jiansong
> -----Original Message-----
> From: Koenig, Christian <Christian.Koenig@amd.com>
> Sent: Monday, May 17, 2021 2:42 PM
> To: Chen, Jiansong (Simon) <Jiansong.Chen@amd.com>; amd-gfx@lists.freedesktop.org
> Subject: Re: [PATCH] drm/amdgpu: optimize to drop preamble IB for old GPUs
>
> Well NAK, as discussed checking the global flag is more flexible since it will still enable the preamble drop when gfxoff is disabled.
>
> Christian.
>
> Am 17.05.21 um 06:39 schrieb Jiansong Chen:
>> The optimization is safe for old GPUs and can help performance.
>>
>> Signed-off-by: Jiansong Chen <Jiansong.Chen@amd.com>
>> Change-Id: Id3b1250f1fe46dddbe8498894fb97e9753b7cafe
>> ---
>>    drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c | 6 ++++++
>>    drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c | 6 ++++++
>>    2 files changed, 12 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
>> b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
>> index 3a8d52a54873..c915cc439484 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
>> @@ -1873,6 +1873,12 @@ static void gfx_v6_0_ring_emit_ib(struct amdgpu_ring *ring,
>>                amdgpu_ring_write(ring, 0);
>>        }
>>
>> +     /* drop the CE preamble IB for the same context */
>> +     if ((ib->flags & AMDGPU_IB_FLAG_PREAMBLE) &&
>> +         !(flags & AMDGPU_HAVE_CTX_SWITCH) &&
>> +         !(flags & AMDGPU_PREAMBLE_IB_PRESENT_FIRST))
>> +             return;
>> +
>>        if (ib->flags & AMDGPU_IB_FLAG_CE)
>>                header = PACKET3(PACKET3_INDIRECT_BUFFER_CONST, 2);
>>        else
>> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
>> b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
>> index c35fdd2ef2d4..6d9ccae48024 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
>> @@ -2269,6 +2269,12 @@ static void gfx_v7_0_ring_emit_ib_gfx(struct amdgpu_ring *ring,
>>                amdgpu_ring_write(ring, 0);
>>        }
>>
>> +     /* drop the CE preamble IB for the same context */
>> +     if ((ib->flags & AMDGPU_IB_FLAG_PREAMBLE) &&
>> +         !(flags & AMDGPU_HAVE_CTX_SWITCH) &&
>> +         !(flags & AMDGPU_PREAMBLE_IB_PRESENT_FIRST))
>> +             return;
>> +
>>        if (ib->flags & AMDGPU_IB_FLAG_CE)
>>                header = PACKET3(PACKET3_INDIRECT_BUFFER_CONST, 2);
>>        else
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
