Return-Path: <SRS0=+i0l=5W=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 805B3C2BA19
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Apr 2020 14:00:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5010C20768
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Apr 2020 14:00:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jD45tYIH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5010C20768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECA376E3D6;
	Mon,  6 Apr 2020 14:00:05 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B9CA6E3D6
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Apr 2020 14:00:04 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id h9so17592504wrc.8
 for <amd-gfx@lists.freedesktop.org>; Mon, 06 Apr 2020 07:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=V0NhZ2671y89RQkupyycZ9PT8u4TWqrmfo36mc64zVo=;
 b=jD45tYIHdMtM/Tc65fXwg/uvEWoklKRNPciwkxAvuKOFM1M59wxD9P4Zw/cvG4dZ8/
 UoZ3+K6kTOwnx6dE3bcqgjSG+zVmQG8LRwrKp+Jc63dtyIMiyZbaQzIu4QIast3yFW1Q
 HaD3VS8K1yjb8Wm63DzXmdtsaOlTiIuKd+RbKtfn9XxHQDlvNLtvdFbW6xsDtJ/0DKQY
 OJ7x+VdVzocT7LdAYIGSXV9eoqAzvUI6uiFedNQp7hB0ETeW3IdCpdeF4b1rQn7h8NtR
 szc+FE71ng2z9/Lz6uA6fMiiGXhH1Nik9CD+sEesMPQ5BDOvKDXqTajwoT2H+BYBaXYM
 IvtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=V0NhZ2671y89RQkupyycZ9PT8u4TWqrmfo36mc64zVo=;
 b=ft+9L2rS9e6PGuCZ128l8q+dz1yu5XtpWTAiyilGU7luYNhZhjq1cGRzMfBNdLLv0P
 Xi+hP8WzRkf3NFKEcNE2XdkcOmaUTUwTddEPn8lIBy1D0cI3DUFhVkAu4C3zBHDok4xZ
 5siuuByFo+JmFHkIUjJJ0a4ChLE6CR9f8fY15+G+qMkopjLKhqZ20h+1/aNAnsG+uXbm
 0rxVkfUvQuzxD70hqf0zVZwDJa540zURSWt0URL84QPba3RBO9Q0C96P8xxra+GhTT3b
 MA3zY1BkaOJHYF6yVl9Q+JdHAkzY3G8QMt3MMK1osv/Nj5geUtlstooUZD/mq4Ds69P8
 VJtA==
X-Gm-Message-State: AGi0PuaNlbbi7LMVj8GGj0NO3bo+QO5tyQs0L17ixYP9MRF0XO5cOBah
 hr+lvAKyWmbtzNYBDYzm8SDqDqRTQS0gFNInM1M=
X-Google-Smtp-Source: APiQypKQ9xi/Tv+xlOJ0GWUtLvpOj97O0xhYKCC/xQ9si/Jy4UEOKp2G85hm+CnsCHDt88TGGyEtuZN0S+VxVyxNIYQ=
X-Received: by 2002:a5d:4e4e:: with SMTP id r14mr4937083wrt.362.1586181602974; 
 Mon, 06 Apr 2020 07:00:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200406081254.22246-1-nirmoy.das@amd.com>
In-Reply-To: <20200406081254.22246-1-nirmoy.das@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 6 Apr 2020 09:59:51 -0400
Message-ID: <CADnq5_Pc9imJgmuEWgEU=VN4vRMDS3723V50+A=tUB+76yKT4Q@mail.gmail.com>
Subject: Re: [PATCH 1/1] drm/amd/powerplay: fix a typo
To: Nirmoy Das <nirmoy.aiemd@gmail.com>
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
Cc: Prike Liang <Prike.Liang@amd.com>, Nirmoy Das <nirmoy.das@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Mon, Apr 6, 2020 at 4:08 AM Nirmoy Das <nirmoy.aiemd@gmail.com> wrote:
>
> Util -> Until
> Fixes: 720de5122254e86 (drm/amd/powerplay: implement the is_dpm_running())
>
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/powerplay/renoir_ppt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
> index ff73a735b888..95eb44515e36 100644
> --- a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
> +++ b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
> @@ -896,7 +896,7 @@ static int renoir_read_sensor(struct smu_context *smu,
>  static bool renoir_is_dpm_running(struct smu_context *smu)
>  {
>         /*
> -        * Util now, the pmfw hasn't exported the interface of SMU
> +        * Until now, the pmfw hasn't exported the interface of SMU
>          * feature mask to APU SKU so just force on all the feature
>          * at early initial stage.
>          */
> --
> 2.26.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
