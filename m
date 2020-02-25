Return-Path: <SRS0=Kz8i=4N=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86E69C35E04
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Feb 2020 15:05:41 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 576E12082F
	for <amd-gfx@archiver.kernel.org>; Tue, 25 Feb 2020 15:05:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R3A82NAa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 576E12082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E142F6EB29;
	Tue, 25 Feb 2020 15:05:40 +0000 (UTC)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F7566EB13;
 Tue, 25 Feb 2020 15:05:39 +0000 (UTC)
Received: by mail-wm1-x341.google.com with SMTP id p17so3496168wma.1;
 Tue, 25 Feb 2020 07:05:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=r7RmpUlHRyrdl4Ij2+xzKKWEEb70EyMwIdUyaPKBWHM=;
 b=R3A82NAa/uw4zA2GaMHN4wQKlKTBMeb9jJ6zMIDMMHoLK/XxFIQbJcc0L2Ki3+yvFj
 yxpyC6FdWlYlRYnWvGTn6zeomT9vLy0FD++LjOn67mzf9FZYOkrzXXpRyOjizKp2Wxe9
 quaB7+Zp2qBvkzt7s7yjoFxrEpR9HQJAFq8A4RzEkk8n1v/mHb6qK4kHTSOgtDWYQhlp
 07VLTA9Rr3bGPXR18KOPCMz34eYkXWRLJHp2bILREpBXIRHcg1RlorcjYvfsuvfCz1za
 V6evnpd8umP2v3Gyx+XxrfbMuSINL8jEAxJvqV8AVWfC6tqfWyH+TYoXmrPhu0MFkOWc
 G7AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=r7RmpUlHRyrdl4Ij2+xzKKWEEb70EyMwIdUyaPKBWHM=;
 b=tVkoT4s6Rp/2om8D2fBALyZP+eZ4LuiGcDJtnoUJ4nfk0KDCGDwQDKT02HWDzFkIie
 3T99WWj84FDXezs43QY0YTRAt2v9eNc1sdgipEm8Y0osLj2W4ZbdKXLO22Y/JYrhSn/5
 VceG/1BzHfuUpFcsRKHp7iwjkE6SA05OSTA4ZmBjPVIewKYFsQlkF20bi/Dwvp9MjMwF
 dbsPoj8Vit5XJ6SqQJOLQZDBvE6tQxkHYfeVmfu1xOHi0jlqOPC0xprRWrM5FoW+EWGo
 Me3qP+cjRV3WnOlnsJLERqCeUCuk6kyF8iyCYOkcOYzxhHs63on7XQ9ASyNDtd8Wm5oA
 Zf4A==
X-Gm-Message-State: APjAAAXTAwhIB2JLjucMEeNCBaja4erRo8Vj5nA837S/W63w6jmvGYcS
 5lXesfUfo7ReSxmT/DFlu5/Hvvjq2h0Y4dlAMQM=
X-Google-Smtp-Source: APXvYqxamkV18hd8RMOkHpaLfKNXGsJAnJPKR6dxW+maJw1T8Ozr00KpCqAbTEghrzqJnprPz2AY/+kL7zl5pzkzFzA=
X-Received: by 2002:a05:600c:218b:: with SMTP id
 e11mr5878703wme.56.1582643137974; 
 Tue, 25 Feb 2020 07:05:37 -0800 (PST)
MIME-Version: 1.0
References: <20200221132433.16532-1-yuehaibing@huawei.com>
In-Reply-To: <20200221132433.16532-1-yuehaibing@huawei.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 25 Feb 2020 10:05:26 -0500
Message-ID: <CADnq5_O7YQB6_hfsFMCCpoZzrhrcYECocZ56DB6ZuE76sACicg@mail.gmail.com>
Subject: Re: [PATCH -next] drm/amd/display: remove set but not used variable
 'mc_vm_apt_default'
To: YueHaibing <yuehaibing@huawei.com>
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
Cc: Chunming Zhou <David1.Zhou@amd.com>, Eric Yang <Eric.Yang2@amd.com>,
 joseph.gravenor@amd.com, "Leo \(Sunpeng\) Li" <sunpeng.li@amd.com>, "Cheng,
 Tony" <tony.cheng@amd.com>, "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
 LKML <linux-kernel@vger.kernel.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>, Dave Airlie <airlied@linux.ie>,
 Yongqiang Sun <yongqiang.sun@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, Daniel Vetter <daniel@ffwll.ch>,
 "Deucher, Alexander" <alexander.deucher@amd.com>, jaehyun.chung@amd.com,
 "Wentland, Harry" <harry.wentland@amd.com>,
 Christian Koenig <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Feb 21, 2020 at 10:33 AM YueHaibing <yuehaibing@huawei.com> wrote:
>
> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn21/dcn21_hubp.c:
>  In function hubp21_set_vm_system_aperture_settings:
> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn21/dcn21_hubp.c:343:23:
>  warning: variable mc_vm_apt_default set but not used [-Wunused-but-set-variable]
>
> It is never used, so remove it.
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied.  thanks!

Alex


> ---
>  drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubp.c | 4 ----
>  1 file changed, 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubp.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubp.c
> index aa7b0e7..d285ba6 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubp.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_hubp.c
> @@ -340,13 +340,9 @@ void hubp21_set_vm_system_aperture_settings(struct hubp *hubp,
>  {
>         struct dcn21_hubp *hubp21 = TO_DCN21_HUBP(hubp);
>
> -       PHYSICAL_ADDRESS_LOC mc_vm_apt_default;
>         PHYSICAL_ADDRESS_LOC mc_vm_apt_low;
>         PHYSICAL_ADDRESS_LOC mc_vm_apt_high;
>
> -       // The format of default addr is 48:12 of the 48 bit addr
> -       mc_vm_apt_default.quad_part = apt->sys_default.quad_part >> 12;
> -
>         // The format of high/low are 48:18 of the 48 bit addr
>         mc_vm_apt_low.quad_part = apt->sys_low.quad_part >> 18;
>         mc_vm_apt_high.quad_part = apt->sys_high.quad_part >> 18;
> --
> 2.7.4
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
