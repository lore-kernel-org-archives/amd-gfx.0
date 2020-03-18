Return-Path: <SRS0=EQAg=5D=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6E47C10DCE
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2020 20:14:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7732F20752
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Mar 2020 20:14:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="buSa8Rvh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7732F20752
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25D6989DFD;
	Wed, 18 Mar 2020 20:14:38 +0000 (UTC)
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com
 [IPv6:2607:f8b0:4864:20::541])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DA0689C94
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Mar 2020 20:11:14 +0000 (UTC)
Received: by mail-pg1-x541.google.com with SMTP id h8so14279212pgs.9
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Mar 2020 13:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=uyesW/I7eVgVyicQueL0CdgpIWranWUqdWTYkhPayEw=;
 b=buSa8RvhjkGTpbBdwHw59o+jZbhgGKbLiBhfH2emwRGZx+wImu/ULynC+CYcg4rbnN
 7u/sZ5xGCoq+T5kYpewP2vLW85uO1fq4YujHF493zxwEabsXuLVHqEVBgMO0yperyLOQ
 AtTa0SNg0Vpxa9cnuaCRmnDgdd6OUlcFvuwrqY2yQKESkO6+71cCLK0W7op0OVEM+m71
 bmHlAQZyTzrYwa9K+oAbP/9IT2f1hX4tKoj3P+qQzuyNSpl9vHmuXGkCkfMgsGFs75PI
 mWxN19hhTjPvb5ClZNqP2xO8sPSOSOpXKlWhnpcOAQxMrQLi1lorTBOjOJgOlh1AkNit
 ImZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=uyesW/I7eVgVyicQueL0CdgpIWranWUqdWTYkhPayEw=;
 b=JCfjCTe5iqB3Ewjo5Tq5FrmU7vuhlrUYXOitTQPp3uI8XRD+OhGFp31kA3x/wRoEhp
 N8/YZ+S5UDBTwSf5PxLT2Mb8CohzFjvgx1XVTeJ0ruYGhyiYsd9IXgRzQGe1Dd6WEfcN
 68G07errnnai+v9F3lkeSGFV3Vius0Jv9PSgnRokpcV0QOAbN98UG/JDL70JynYIdHYr
 W1odQMa2NIGFh9Z9wWcXJstuGYN2VYUKnCZ3BwzfLn0cnJoCSeR/WVepU9q+i7yjNJL+
 NAQTnNo4AMQEU8ZYBMUJUJ2FdsqiEdwGIkPGjMDmKPpTZKa/AElwq31/9b0SrRFKDDNH
 CR2w==
X-Gm-Message-State: ANhLgQ3FYC9QKLq5aXevwr7rBe9ULDH49krEgTD+ILTtuyxQ6HgNeDGy
 upVEzLIlP0BfFFfkxfJkGR+CD6XBesZEC8kW/WQx4A==
X-Google-Smtp-Source: ADFU+vsvmlakcRCCZHYwnyZMgY3Y37TRHQ0ECfXdqwlx7G77wz0frDIB6p4cU0iSRnIO6PsnQPSCLbvLu8yOZe6YOM8=
X-Received: by 2002:a63:4d6:: with SMTP id 205mr6229525pge.10.1584562273205;
 Wed, 18 Mar 2020 13:11:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200318002500.52471-1-natechancellor@gmail.com>
In-Reply-To: <20200318002500.52471-1-natechancellor@gmail.com>
From: Nick Desaulniers <ndesaulniers@google.com>
Date: Wed, 18 Mar 2020 13:11:00 -0700
Message-ID: <CAKwvOdkzdBYgixrSKKfo7=god4Q0GaMORmFWUfrJ27JiGhBx2Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Initialize shadow to false in
 gfx_v9_0_rlcg_wreg
To: Nathan Chancellor <natechancellor@gmail.com>
X-Mailman-Approved-At: Wed, 18 Mar 2020 20:14:36 +0000
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
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Mar 17, 2020 at 5:25 PM Nathan Chancellor
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
> It is not wrong so initialize shadow to false to ensure shadow is always
> used initialized.

Yep, thanks for the patch.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>
> Fixes: 2e0cc4d48b91 ("drm/amdgpu: revise RLCG access path")
> Link: https://github.com/ClangBuiltLinux/linux/issues/936
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index 7bc2486167e7..affbff76758c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -735,7 +735,7 @@ void gfx_v9_0_rlcg_wreg(struct amdgpu_device *adev, u32 offset, u32 v)
>         static void *spare_int;
>         static uint32_t grbm_cntl;
>         static uint32_t grbm_idx;
> -       bool shadow;
> +       bool shadow = false;
>
>         scratch_reg0 = adev->rmmio + (adev->reg_offset[GC_HWIP][0][mmSCRATCH_REG0_BASE_IDX] + mmSCRATCH_REG0)*4;
>         scratch_reg1 = adev->rmmio + (adev->reg_offset[GC_HWIP][0][mmSCRATCH_REG1_BASE_IDX] + mmSCRATCH_REG1)*4;
> --
> 2.26.0.rc1
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/20200318002500.52471-1-natechancellor%40gmail.com.



-- 
Thanks,
~Nick Desaulniers
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
