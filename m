Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30C6EEB64D9
	for <amd-gfx@archiver.kernel.org>; Mon, 19 Jun 2023 14:06:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3351B10E205;
	Mon, 19 Jun 2023 14:06:11 +0000 (UTC)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CDB210E205
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Jun 2023 14:06:08 +0000 (UTC)
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-6b58ae9cb79so169223a34.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 19 Jun 2023 07:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687183567; x=1689775567;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mEZeZ2o6S6e+Ord3MghMo2kA6KinYv3idspdHznpJY8=;
 b=WW4RQNnOak6y9qqY5QDM4Yws30Xee3+ZKAGH8i9fhoAwBC+IRcogiEdb+939rTxNMr
 vZfE0e28CgW01qJnDdeMeTqYfg0u4n3q90v0z0lJt2jEpnjfYhIYXV6gWCKxehEkGvxp
 GuPdEwnim+dpt+EbEsQQ6bQzqE+4AVdgd2AKEavg+tk0m+IXIC6A5c2CV69hvxB1LzTC
 nmdnZlPri7pznf13Qn49upnEZ4rwAGK7Dg89NvNLfJQnYIYWT4HGgqCnA+Bx6r8eH37U
 1dQNKxy7w2d/CQ2c6jsaES4wM5FAmTQjLMoQXszaQEs5vKGr0B1OWpZK8ijgEerGPVkR
 g09A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687183567; x=1689775567;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mEZeZ2o6S6e+Ord3MghMo2kA6KinYv3idspdHznpJY8=;
 b=faRGMZyDLH5MzmB68vNowmdyIfiydsUSD4XDmwoSBUhNd+FGz0UiR/Co513CEGGetr
 jEeHtNBmOGqqdgDlas9bY9cH0i6fay+8xSM45uU4pw2HhP4byZw61b+2aMxpp8e/PCeR
 bw7NMrvGLL1cJeN+VfY0o3F0JECZC6eas+tUOrp12+suDfG/I2LcP6HX8UHwb1iYG543
 fuV4mN6m/DDEOZHDoFGvFfj9TjDRvfQ7g1HnrCwDVYvIoYVrJr6FttC7IobmiqTTmUYg
 Ch75lbS9b6IGGY5WluJ7dfxNMaOk2vf/oy+ouG2be8WSwQvm1p2O11TxkUW7fUTZs7XW
 4edw==
X-Gm-Message-State: AC+VfDxcYYb8jSxlCnX+hoTFZpXRPkeJgPayzV5jJT7EE52AgkhEZPHN
 zva48/mRSNdFE9nZhMeJRZ4eALr4a0TFLNUqgzI=
X-Google-Smtp-Source: ACHHUZ7nnXDRUWyuNGmEpwINZie453Atfya1N2mftqq0iqcNlP0kjDyRZNOOIFi9mXZ0STvuWDUMUoISHF1Ksc/Uxrw=
X-Received: by 2002:a05:6808:15a0:b0:39e:ca2b:7246 with SMTP id
 t32-20020a05680815a000b0039eca2b7246mr3201908oiw.8.1687183566609; Mon, 19 Jun
 2023 07:06:06 -0700 (PDT)
MIME-Version: 1.0
References: <113ba574-90b4-1a7f-5982-d9de8d12c24b@debian.org>
In-Reply-To: <113ba574-90b4-1a7f-5982-d9de8d12c24b@debian.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 19 Jun 2023 10:05:55 -0400
Message-ID: <CADnq5_P6h1YQBO3TRWoEPBAzfSzJOCgUyY2xw2WWPmnW48Sq7A@mail.gmail.com>
Subject: Re: Warning appeared after c8b5a95 ("drm/amdgpu: Fix desktop freezed
 after gpu-reset")
To: Christian Kastner <ckk@debian.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Mon, Jun 19, 2023 at 9:05=E2=80=AFAM Christian Kastner <ckk@debian.org> =
wrote:
>
> Hi,
>
> On a Debian 12 ("bookworm") system, I observed a new warning when I
> upgraded from kernel 6.1.25 to 6.1.27. This is on a system with an RX
> 6800 XT GPU and 3500X processor.
>
> I've traced it down to commit c8b5a95 ("drm/amdgpu: Fix desktop freezed
> after gpu-reset"). Rebuilding the 6.1.27 kernel without this change
> makes the warning disappear.
>
> I can reliably trigger this (and another) warning with
>
>   $ sudo cat /sys/kernel/debug/dri/0/amdgpu_test_ib
>   run ib test:
>   ib ring tests passed.
>
> 5 or 6 seconds after this, two warnings are printed. I see these same
> two warnings on system shutdown (or, at least, they looked similar
> enough to the above that I didn't check for identity).
>
> I've attached
>   (1) the dmesg output after modprobe'ing amdgpu
>   (2) the dmesg output after triggering amdgpu_test_ib
>
> The system in question is only used for ROCm development. I haven't
> observed any other side effects there, other than the warning. There's
> no monitor attached. So I can't speak to the effect of a desktop freeze.

The warnings are harmless, but they have been fixed[1] and the fixes
are making their way back to stable kernels.

[1] - https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/co=
mmit/?id=3D08c677cb0b436a96a836792bb35a8ec5de4999c2

Alex
