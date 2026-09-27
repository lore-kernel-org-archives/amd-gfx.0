Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2124C98338
	for <amd-gfx@archiver.kernel.org>; Sun, 27 Sep 2026 19:23:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17A0910E00A;
	Sun, 27 Sep 2026 19:23:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="S9tUS3lG";
	dkim-atps=neutral
Received: from mail-dl2-f12.google.com (mail-dl2-f12.google.com
 [74.125.229.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4A36610E00A
 for <amd-gfx@lists.freedesktop.org>; Sun, 27 Sep 2026 19:23:21 +0000 (UTC)
Received: by mail-dl2-f12.google.com with SMTP id
 a92af1059eb24-141a5cf1371so137353c88.2
 for <amd-gfx@lists.freedesktop.org>; Sun, 27 Sep 2026 12:23:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790537000; cv=none;
 d=google.com; s=arc-20260327;
 b=d4l78mjJbSUCNzhSGp47N7fYBWS1LuwC5u5ynr7C2hxNdHUq5Ped48sgc0+tbB3HD1
 peC2yUJDL9Ggb+oqxO2oBCasNzyBS34UG749WdueryuFqUyPP0CA3QwprBEJRY5wDZTK
 c8c9RtP9PVqQsan/OoAiJMMx+JFyGmR5Yue4xYV+zEKD6G7iZu0grz9v3S6KCXN94DM5
 p9+nZCbZeluog3YomLmSRnoDUIa3cHawk1mzmgX6ezv//XreYqyegcjkl8P3MZCj/SaB
 wzio6sEQl0DL/TJrQS39ewVrsZCF/iyprtcBcm6o0YQOx0EfXbD5f52pFU7cGimRROny
 n9nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=GQ1aNNlcd5tc7JMvOSQAmrryeFFMB3Nt+WvcOu7O2ZQ=;
 fh=4sbRE/uM8MXXzHG0M0XLsTgNclE7f4g3YNAsC+9kYac=;
 b=pUr96dA/Hm3ZAmh0IBD42vFYNCMmcbRTL1iaYX5WwL4zWBXkqrJldh03hR+bSiyxrV
 +tM0vG9qQK7HidoYOze8baOnof819oG+PKYzVpZMQltwCPBukWp2JuR7WAyaxVi3FI4l
 jplCMKXq8S6BD66pnlEFCEcOv3+eGuQrQL2pE8FmUg6XjEaNlpbHaHx+5+kRJuk2WTRC
 yt8ofbV53AuOYZI4qjTY1jOqSObcYQWkQUvyh5rZxr0E2RlCRd6ycF5tEvEWNahsDvVR
 9SDm9TBcR1BxwOcNTx9sUiuxmrCwp60cXwIDm7UcZc/E3vug6SajzotVmY47ZPY/jvy/
 Snag==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790537000; x=1791141800; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=GQ1aNNlcd5tc7JMvOSQAmrryeFFMB3Nt+WvcOu7O2ZQ=;
 b=S9tUS3lGMC8NQb9NlptnoUv38cfwA2Oz86KRo7a3wWA0ndtsLydtpDNG49YW093D9I
 OGs7KnWEv9GXa/ZOAsvu6NJFVRQ0pGgaSTtgmtnz1dlUF56lwLpFQB4Su8arNB5LKZ7Z
 ceTiuYTGhEpJOIMrb0ke526PDpIg6dY3+4VyeZUzEsdeeysVpAXGvkJqqp0qLFLsjN4+
 hru6zsHO7QhjlQmz2z0CILDHNQG063ZQ4Yif5eGyz2ltKF9OcMzGvrPu24tyZ4z3fTh+
 G+uaszi+DPdcVvTeQ4jdFKV9ovFTD/IOANSn5cYosCv4ddyCK/P4j9cg23GFu5ktSVi0
 IOSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790537000; x=1791141800;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GQ1aNNlcd5tc7JMvOSQAmrryeFFMB3Nt+WvcOu7O2ZQ=;
 b=wp0wW0OjgRj+Hz6+1N55SklZfoFs4fX3xBZSmGk6Yix3xJoJW3LjNMDznWIMDxsqPS
 9bqFiENBHeLy71HHBFfIQXVtVLjVYIhfKAtBNQ3j2xZKifaQwZBv2t1K0k8bzEH3Ot+W
 fZK3c0cNlbEj5zh07zRGmU8FNDsM7Rsph+tAIZWr9IDD36I7GGxPpxve6OFBSp+3kOsn
 aQ3SaqqmuD0wgngoGEB7sIqbLNhY+tzjqMsbFSihhyQhR0aYbud33LnZHnGivScZV2If
 tpjMwdKLqxxLLrxLLBnwIO1P9eV3C+Rsy7hmgEgkpD/6Lt0FOafjTT4HWrdrrxPP3Fsa
 TcvA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwbaiGhVdUkIokADBZKpd/KUQ/4xF46CIxI/Zub0pJMYihrX0V61bDkT6BGeg1cEdm6TgcJFWge@lists.freedesktop.org
X-Gm-Message-State: AFuF++krkgHVTFKy0zk5C+d7Ed6CTpYJ2DEdFvOPvmwv01jTN7JgknPl
 S/isbIwE1PUXrON9bzvFzZD39WszzT9EtnLgVvwJPEihA0yj10iJsaYCSuov9UrvZl5raAdyIVz
 jAYYlSyqzV8tE2XMJk6Tf/gwXeQahbgQ=
X-Gm-Gg: AYBFou3FlJPfbmdhki8Zc3dn4aJ08Biym4Tb1H8o9t9IOOr+zeoct+IpivGCCq9mrjY
 48ZnwlLQH/ycN6nCSa6deMARijTBRKIkwv/pG0y5kly0y864fRUmeFufiqBh/5eGBWQl+tirH9x
 GRVp33OdCwccQclEsTZLHN5YMUUgamYSLKjJDWHIMuqBq4qe5ZgYvUl9BfscZfhBBiYr/zfDCDQ
 uTyoC4KR5siExnBIWvZL/IRUlhs3Y1YID8NrqWLvs25G26iLnfiU2wWr8CsEvnTccqC1ODbY+yn
 eQRmXjRpKhAthfbsd8NUUQ/hWX5vmDW+iLAJYOA3mdi0pZdY0xHMgNahc8723E4n55Pwppcfk2M
 YJdN5n56W1UjlkXv/OntfI5PWa7LoCFst38qVL+tIZQ==
X-Received: by 2002:a05:701b:4542:20b0:139:81c6:67a1 with SMTP id
 a92af1059eb24-146cf7ee6efmr11412357c88.1.1790536999746; Sun, 27 Sep 2026
 12:23:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260927161601.1183525-1-sashal@kernel.org>
In-Reply-To: <20260927161601.1183525-1-sashal@kernel.org>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Sun, 27 Sep 2026 15:23:08 -0400
X-Gm-Features: AclHuK8wUu5keriArIOfnqcjTa0PI5BDk7mnauwk6N-t9qf1EcExXFN7ZB-zoKE
Message-ID: <CADnq5_PBt-8TZ2i90m9fs8OKWQHmdpLqCx9+my32duvb78Yaiw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Fix sanitizer check for the DML frame
 size limit
To: Sasha Levin <sashal@kernel.org>
Cc: Austin Zheng <austin.zheng@amd.com>, Jun Lei <jun.lei@amd.com>, 
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Nathan Chancellor <nathan@kernel.org>, Alex Hung <alex.hung@amd.com>, 
 Rodrigo Siqueira <siqueira@igalia.com>,
 Nick Desaulniers <ndesaulniers@google.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Applied.  Thanks.  Will include this in my -fixes PR later this week.

Alex

On Sun, Sep 27, 2026 at 12:26=E2=80=AFPM Sasha Levin <sashal@kernel.org> wr=
ote:
>
> Building x86_64 allmodconfig with clang fails:
>
>   .../dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c:10491:13:
>   error: stack frame size (3128) exceeds limit (3072) in
>   'dml_core_mode_programming' [-Werror,-Wframe-larger-than]
>
> That config enables both KASAN and UBSAN, and should get the 4096
> byte limit meant for clang COMPILE_TEST sanitizer builds. The check
> in the dml and dml2_0 Makefiles concatenates the three symbols with
> no separator:
>
>   ifeq ($(filter y,$(CONFIG_KASAN)$(CONFIG_KCSAN)$(CONFIG_UBSAN)),y)
>
> KASAN and KCSAN cannot be enabled together, so before UBSAN was
> added the string was at most "y". UBSAN can be enabled alongside
> either of them, and with both set the string becomes "yy",
> $(filter y,yy) is empty, and the build falls through to the
> non-sanitizer limit of 3072. Adding UBSAN to the check therefore
> lowered the limit for the most heavily instrumented builds instead
> of raising it.
>
> Separate the symbols with spaces so that $(filter) sees individual
> words, and test for a non-empty result. Only the configs with two
> sanitizers enabled change behaviour.
>
> Found by KernelCI builds of the linus-next tree.
>
> Fixes: ebf8b0fd8508 ("drm/amd/display: Relax DML frame limit with UBSAN")
> Assisted-by: LLM
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  drivers/gpu/drm/amd/display/dc/dml/Makefile    | 2 +-
>  drivers/gpu/drm/amd/display/dc/dml2_0/Makefile | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/Makefile b/drivers/gpu/dr=
m/amd/display/dc/dml/Makefile
> index 91465ac05c971..eb4ce5b1ecfbb 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/Makefile
> +++ b/drivers/gpu/drm/amd/display/dc/dml/Makefile
> @@ -29,7 +29,7 @@ dml_ccflags :=3D $(CC_FLAGS_FPU)
>  dml_rcflags :=3D $(CC_FLAGS_NO_FPU)
>
>  ifneq ($(CONFIG_FRAME_WARN),0)
> -    ifeq ($(filter y,$(CONFIG_KASAN)$(CONFIG_KCSAN)$(CONFIG_UBSAN)),y)
> +    ifneq ($(filter y,$(CONFIG_KASAN) $(CONFIG_KCSAN) $(CONFIG_UBSAN)),)
>          ifeq ($(CONFIG_CC_IS_CLANG)$(CONFIG_COMPILE_TEST),yy)
>              frame_warn_limit :=3D 4096
>          else
> diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/Makefile b/drivers/gpu=
/drm/amd/display/dc/dml2_0/Makefile
> index e8bd061be05c1..2181079c89d0e 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml2_0/Makefile
> +++ b/drivers/gpu/drm/amd/display/dc/dml2_0/Makefile
> @@ -28,7 +28,7 @@ dml2_ccflags :=3D $(CC_FLAGS_FPU)
>  dml2_rcflags :=3D $(CC_FLAGS_NO_FPU)
>
>  ifneq ($(CONFIG_FRAME_WARN),0)
> -    ifeq ($(filter y,$(CONFIG_KASAN)$(CONFIG_KCSAN)$(CONFIG_UBSAN)),y)
> +    ifneq ($(filter y,$(CONFIG_KASAN) $(CONFIG_KCSAN) $(CONFIG_UBSAN)),)
>          ifeq ($(CONFIG_CC_IS_CLANG)$(CONFIG_COMPILE_TEST),yy)
>              frame_warn_limit :=3D 4096
>          else
> --
> 2.53.0
>
