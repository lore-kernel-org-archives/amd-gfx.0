Return-Path: <SRS0=EQAg=5D=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F169AC4332E
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2020 21:08:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C711C20777
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2020 21:08:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="qN4+WX6l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C711C20777
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1CE686E96E;
	Wed, 18 Mar 2020 21:07:59 +0000 (UTC)
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20::443])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 690C46E89F
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Mar 2020 21:07:48 +0000 (UTC)
Received: by mail-pf1-x443.google.com with SMTP id 3so150965pff.4
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Mar 2020 14:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=UnW3oRxVQHnYvwZ2+HCKUVYxiIim+eBLvaQELpxrRqU=;
 b=qN4+WX6llXdXg7OP2ngw/tmuSenPNNwNDboXm8R0BqN7TKq6AnxLkKLG8Q99y9IZ6T
 YDfO8JIUTC9v2tBafpZVOOd0JFYHC0mDB+lxnynMKQQLixMFCn9aOM1p/8pLBMWijDoE
 rLQazFqDavwllYsf3wPN4aql2BpoZjato+DcTWKqNtpooKdE/nwFO0dcUImcroRCILJO
 aPVcdVsQK6Yfq1FM6t0YjsW0hhvgLZRy2qsN7Ze0/hX0uJaqnU3valz6jPspG792A5BE
 UiFdDU6CdJPC5k87CYj8sMC2aAKdppbSCjkh0rgWDLetIMv33zXhdzo2jCnPehDY1cV5
 BkdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=UnW3oRxVQHnYvwZ2+HCKUVYxiIim+eBLvaQELpxrRqU=;
 b=m7jypk1BjRoAS7S+i/+Y81ODZHboxBkrabQb2VyLh1VcPbyvHYzqME+o4X32/LP8yz
 eMjKRnGEm+VqgOZVI/3C55bkreSP8fwEXk16AF6eS41wKJo28IWTqQKi5WBiA35MUPN0
 IK7fwKRgaOe8aSrv0OhmWyD0pL0K7j2hJEyP6fzPrkKzGdCd5SMj0G485V6up7Vsxbx7
 0F5poUAGWeQVyJ/0X3qjEgLXOviSYwdtuTKmiXEymkqkQBqkkM5JX+hj6c5SMYnM/44i
 fljXHzdW2b+ejBhhi8MrmfsfEzmKgxX++e+CrDIahAQNFbPRvDh8aYW5iNOoQVIGIfdQ
 Cs8w==
X-Gm-Message-State: ANhLgQ1z7jfh445tlkiICgwR2/vUvY7/dXEj5AktzH3swuca1lMLtIL3
 gEI2FDpZw/08TkCV3N39uzAYJhlvjx+DUu5nMokZ2A==
X-Google-Smtp-Source: ADFU+vtrCbWLsD9Kl2sgpRCLWJgG9WETEekWUwb95aIHCLvQp5JpBJCHYMAZGw01/Hcy77aG8jAmyFceFlIcLkd5Les=
X-Received: by 2002:aa7:8b54:: with SMTP id i20mr215129pfd.39.1584565667463;
 Wed, 18 Mar 2020 14:07:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200318002500.52471-1-natechancellor@gmail.com>
 <20200318210408.4113-1-natechancellor@gmail.com>
In-Reply-To: <20200318210408.4113-1-natechancellor@gmail.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Wed, 18 Mar 2020 14:07:34 -0700
Message-ID: <CAKwvOdmjzemFW9jF-CW1RhLJJbMvFO_NrPUeyi=rdLNVZURsfw@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amdgpu: Remove unnecessary variable shadow in
 gfx_v9_0_rlcg_wreg
To: Nathan Chancellor <natechancellor@gmail.com>
X-Mailman-Approved-At: Wed, 18 Mar 2020 21:07:57 +0000
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
Cc: "David \(ChunMing\) Zhou" <David1.Zhou@amd.com>,
 LKML <linux-kernel@vger.kernel.org>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 clang-built-linux <clang-built-linux@googlegroups.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Alex Deucher <alexander.deucher@amd.com>, Joe Perches <joe@perches.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Mar 18, 2020 at 2:05 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> clang warns:
>
> drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:754:6: warning: variable 'shadow'
> is used uninitialized whenever 'if' condition is
> false [-Wsometimes-uninitialized]
>         if (offset == grbm_cntl || offset == grbm_idx)
>             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:757:6: note: uninitialized use
> occurs here
>         if (shadow) {
>             ^~~~~~
> drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:754:2: note: remove the 'if' if
> its condition is always true
>         if (offset == grbm_cntl || offset == grbm_idx)
>         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c:738:13: note: initialize the
> variable 'shadow' to silence this warning
>         bool shadow;
>                    ^
>                     = 0
> 1 warning generated.
>
> shadow is only assigned in one condition and used as the condition for
> another if statement; combine the two if statements and remove shadow
> to make the code cleaner and resolve this warning.
>
> Fixes: 2e0cc4d48b91 ("drm/amdgpu: revise RLCG access path")
> Link: https://github.com/ClangBuiltLinux/linux/issues/936
> Suggested-by: Joe Perches <joe@perches.com>
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>
> v1 -> v2:
>
> * Remove shadow altogether, as suggested by Joe Perches.
> * Add Nick's Reviewed-by, as I assume it still stands.

yep, thanks

>
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index 7bc2486167e7..496b9edca3c3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -735,7 +735,6 @@ void gfx_v9_0_rlcg_wreg(struct amdgpu_device *adev, u32 offset, u32 v)
>         static void *spare_int;
>         static uint32_t grbm_cntl;
>         static uint32_t grbm_idx;
> -       bool shadow;
>
>         scratch_reg0 = adev->rmmio + (adev->reg_offset[GC_HWIP][0][mmSCRATCH_REG0_BASE_IDX] + mmSCRATCH_REG0)*4;
>         scratch_reg1 = adev->rmmio + (adev->reg_offset[GC_HWIP][0][mmSCRATCH_REG1_BASE_IDX] + mmSCRATCH_REG1)*4;
> @@ -751,10 +750,7 @@ void gfx_v9_0_rlcg_wreg(struct amdgpu_device *adev, u32 offset, u32 v)
>                 return;
>         }
>
> -       if (offset == grbm_cntl || offset == grbm_idx)
> -               shadow = true;
> -
> -       if (shadow) {
> +       if (offset == grbm_cntl || offset == grbm_idx) {
>                 if (offset  == grbm_cntl)
>                         writel(v, scratch_reg2);
>                 else if (offset == grbm_idx)
> --
> 2.26.0.rc1
>


-- 
Thanks,
~Nick Desaulniers
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
