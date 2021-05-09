Return-Path: <SRS0=4HPi=KF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95EC4C433B4
	for <amd-gfx@archiver.kernel.org>; Mon, 10 May 2021 08:26:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D4E86144F
	for <amd-gfx@archiver.kernel.org>; Mon, 10 May 2021 08:26:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D4E86144F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 164126E42A;
	Mon, 10 May 2021 08:26:26 +0000 (UTC)
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com
 [IPv6:2607:f8b0:4864:20::c31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 121D16E4B6
 for <amd-gfx@lists.freedesktop.org>; Sun,  9 May 2021 20:51:36 +0000 (UTC)
Received: by mail-oo1-xc31.google.com with SMTP id
 j17-20020a4ad6d10000b02901fef5280522so3086195oot.0
 for <amd-gfx@lists.freedesktop.org>; Sun, 09 May 2021 13:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=xqXDjaxgZUr1ssw4SsB5XI4NGW2zLP/+YYk0PCefzyo=;
 b=UaGMrCGUP5C3oyXuIXX50Hb/5G7GbhywfPQPUuWR7drWHFRNXtiBRgsnbWOQte2579
 Q7mULYN5oTLv7laiYlTnPA0wEVL3oBcWy9aHRBzUuZkIWWO0OMcieIdaCywZ3WE9C+le
 EWASeNcrITXxg+u6Wn5VK6SHzBohHhr3CLO3EmKdkwpsoQi0yG8aCT3dEVkGb0CNnQ/s
 WlXLDY8GoDJe5OR+dChzjwV7us8SoUYMFPhdOjorL+71uePic7FRfP2uCKSVxIrS2cWD
 kEXYqoooJdoidtZ/CCZzlJb33849Sz7XsK8FTJHmIXbBupNxfVft0OkLm83cq4zDTb/C
 wh4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=xqXDjaxgZUr1ssw4SsB5XI4NGW2zLP/+YYk0PCefzyo=;
 b=ueNlQMy/fmZJ3juVUqsLMzVGClKR1diCVBU1cNjBqPpQY1TW0jykWc5iraUmL/ZhTg
 0rqxN/reFBS2iShABBn0Es8dvrmqhG52Y4XciVi+LCySfdoaDuvQAwELEQSPlEenftxQ
 QEX2UnYk3oYZzU14mLtPIaZpOyr2h7QwV23YZY/PFw6tSG9ueXLR+JyP5o5x+WUzTVI5
 8BKtxrIVoa7Ie9ojlYeVcL8Jhs0XDhWtWn7HFJncVeAs9Zy53INGIRGkbG4tfsV2+LqH
 Ib6DD4lkrcYq2Wr75bQWElgIs/rgGHFNt5JDZ2fxsZfJRkL0JeF6svuAzNaHn0cRDW4J
 LSvQ==
X-Gm-Message-State: AOAM531pHfIur7r7Zd5oxdLDw5o3EjpsRjthH/2Q99b7tIp8bswWCeUH
 0QYt1GB+waVQA+EbRujc9226UzxekTjScdzhvMs=
X-Google-Smtp-Source: ABdhPJzf5cdw/R01DYu1emFd/pI6tdDCAE/1aL+EnWTkpDyyt1FbjWowRIGK+xSMkPlL0KvazrwbQ0BtNZY8zhgrd/c=
X-Received: by 2002:a4a:b389:: with SMTP id p9mr16197839ooo.71.1620593495327; 
 Sun, 09 May 2021 13:51:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6830:4118:0:0:0:0 with HTTP; Sun, 9 May 2021 13:51:34
 -0700 (PDT)
In-Reply-To: <CADnq5_MF0y0sHH6Vz8KZH5j=iXToq3WPw7+kW=BqMk=oNZ=Ppw@mail.gmail.com>
References: <20210414233533.24012-2-qingqing.zhuo@amd.com>
 <20210509121055.24728-1-youling257@gmail.com>
 <CADnq5_MF0y0sHH6Vz8KZH5j=iXToq3WPw7+kW=BqMk=oNZ=Ppw@mail.gmail.com>
From: youling 257 <youling257@gmail.com>
Date: Mon, 10 May 2021 04:51:34 +0800
Message-ID: <CAOzgRdZf0R7mVY+spDZz_CG1Kpf7qmP6oGaOJ_XKauZA3ZhZeg@mail.gmail.com>
Subject: Re: [PATCH 2/2] Revert "Revert "drm/amdgpu: Ensure that the modifier
 requested is supported by plane.""
To: Alex Deucher <alexdeucher@gmail.com>
X-Mailman-Approved-At: Mon, 10 May 2021 08:26:24 +0000
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
Cc: Mark Yacoub <markyacoub@chromium.org>,
 Qingqing Zhuo <qingqing.zhuo@amd.com>, "Siqueira,
 Rodrigo" <Rodrigo.Siqueira@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, "Wheeler,
 Daniel" <daniel.wheeler@amd.com>, Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
 "Deucher, Alexander" <alexander.deucher@amd.com>, "Kazlauskas,
 Nicholas" <nicholas.kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

look this video,
https://drive.google.com/file/d/1QklH_H2AlOTu8W1D3yl6_3rtZ7IqbjR_/view?usp=sharing

2021-05-09 23:52 GMT+08:00, Alex Deucher <alexdeucher@gmail.com>:
> On Sun, May 9, 2021 at 11:42 AM youling257 <youling257@gmail.com> wrote:
>>
>> I using amd 3400g running with android-x86, this patch is a bad commit
>> when i use android-x86 on amdgpu.
>
> Can you provide more details?  What sort of problem are you seeing?
> Please provide your dmesg output.
>
> Alex
>
>
>> _______________________________________________
>> amd-gfx mailing list
>> amd-gfx@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
