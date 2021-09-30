Return-Path: <SRS0=sE/Q=OU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 119CEC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Sep 2021 17:37:43 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A54A661439
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Sep 2021 17:37:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A54A661439
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 617E66EC3B;
	Thu, 30 Sep 2021 17:37:42 +0000 (UTC)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB68F6EC3B
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Sep 2021 17:30:03 +0000 (UTC)
Received: by mail-lf1-x12e.google.com with SMTP id i19so25177549lfu.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Sep 2021 10:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ye/qqO0p8PKVzbuUoEwamPcpYGy0s9HnvVApER+R6kA=;
 b=ftI3Z0SVqMbhoWdnhg5bUeF+owpQShwFKiFCCXBcdn4RZHbJbc2J0o5nj5aw/QCKc0
 Vdv2kgukq9RGNxjvjCA3DkRkCBBBad79JhJxxgNrkccjH4TiJmRBW0i0ltEOb3yFMdev
 fFeMeE/vjhHmOt6rD9YvGkHtfgRxvfpXrATQ9+w5QnzKHBDo8urSjo0OMyTAAQJAH+zc
 EwvsOhDC+BRkFf8OyUTq4uGhLOTBNWDzgLni0BSbv5tf0eiZ2g1db+Bz2V5XwFVunwsL
 zbC/56A/1fmE7NB8Ti2l0dQyedYulC894HG+7anlAY/mFjb5fTXbiZUoIMQ/I8y6CLKy
 8uww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ye/qqO0p8PKVzbuUoEwamPcpYGy0s9HnvVApER+R6kA=;
 b=ngk8SJJMPX0FXCBX965RobWzq15PoB0E4joC9sS5SZuuTM17zZaiHQGq4zRuvFbZrL
 3iuOypot8U8yZezI3DgxP/HPGyqLxy6GhX045roz2sOJ6MrR3bzil1iwu+qrfHjUOi2L
 iYznHJueFfL5eH7oSo+i3B297DSwxgHc24FXJMLPGSd/9ivF8y6SZSrxiqgpJagmdry0
 ebVro63XIivunC5wAvJGCqWuhymJ8GAGDapx0tysv3b6f3XUHH6pEF7UXp8clqL2xnND
 W+1lRtpbraXvL6IoK8vQ/cekbskLeWC9OgcFCUGrFF68r9S2jJWlj39iDeZIScCt5jUt
 7eIQ==
X-Gm-Message-State: AOAM532shbWWP+/lxX33zt+O1P+wTxncIPMLC0E9aCNGiThCuh9TNdkW
 tyXeI02iXaAPxcOdthBGQfWdR+5pjTYqnXO+LgSsTQ==
X-Google-Smtp-Source: ABdhPJyhCryWkdo+UwgKGKjWkIyiSDBhEOEx2SxpkNiPWf9uVV7dyEnhQqYnZexjKufQh9L+L+s2Toet+ZTQxKlAHrM=
X-Received: by 2002:a05:651c:b20:: with SMTP id
 b32mr7192491ljr.62.1633023000715; 
 Thu, 30 Sep 2021 10:30:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210930160142.2301257-1-nathan@kernel.org>
In-Reply-To: <20210930160142.2301257-1-nathan@kernel.org>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Thu, 30 Sep 2021 10:29:49 -0700
Message-ID: <CAKwvOdkrD4WuZzUnBc2LeCjLVAumBCKXJdyr=k=dPDX1BsMhOg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd: Guard IS_OLD_GCC assignment with CONFIG_CC_IS_GCC
To: Nathan Chancellor <nathan@kernel.org>
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 "Pan, Xinhui" <Xinhui.Pan@amd.com>, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Thu, 30 Sep 2021 17:37:41 +0000
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

On Thu, Sep 30, 2021 at 9:02 AM Nathan Chancellor <nathan@kernel.org> wrote:
>
> cc-ifversion only works for GCC, as clang pretends to be GCC 4.2.1 for
> glibc compatibility, which means IS_OLD_GCC will get set and unsupported
> flags will be passed to clang when building certain code within the DCN
> files:
>
> clang-14: error: unknown argument: '-mpreferred-stack-boundary=4'
> make[5]: *** [scripts/Makefile.build:277: drivers/gpu/drm/amd/amdgpu/../display/dc/dcn201/dcn201_resource.o] Error 1
>
> Guard the call to cc-ifversion with CONFIG_CC_IS_GCC so that everything
> continues to work properly. See commit 00db297106e8 ("drm/amdgpu: fix stack
> alignment ABI mismatch for GCC 7.1+") for more context.
>
> Fixes: ff7e396f822f ("drm/amd/display: add cyan_skillfish display support")
> Link: https://github.com/ClangBuiltLinux/linux/issues/1468
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Thanks for the patch!
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

$ grep -rn "ifdef IS_OLD_GCC" drivers/gpu/drm/amd/display/dc/ | wc -l
11

It's probably time to put this pattern in a Makefile under scripts/
and include it in all of these Makefiles.  Anything to minimize the
amount of code that has to be carried forward to new subdirs.

> ---
>  drivers/gpu/drm/amd/display/dc/dcn201/Makefile | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn201/Makefile b/drivers/gpu/drm/amd/display/dc/dcn201/Makefile
> index d98d69705117..96cbd4ccd344 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn201/Makefile
> +++ b/drivers/gpu/drm/amd/display/dc/dcn201/Makefile
> @@ -14,9 +14,11 @@ ifdef CONFIG_PPC64
>  CFLAGS_$(AMDDALPATH)/dc/dcn201/dcn201_resource.o := -mhard-float -maltivec
>  endif
>
> +ifdef CONFIG_CC_IS_GCC
>  ifeq ($(call cc-ifversion, -lt, 0701, y), y)
>  IS_OLD_GCC = 1
>  endif
> +endif
>
>  ifdef CONFIG_X86
>  ifdef IS_OLD_GCC
>
> base-commit: b47b99e30cca8906753c83205e8c6179045dd725
> --
> 2.33.0.591.gddb1055343
>


-- 
Thanks,
~Nick Desaulniers
