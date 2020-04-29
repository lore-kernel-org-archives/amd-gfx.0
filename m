Return-Path: <SRS0=m206=6N=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB44EC83004
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Apr 2020 15:23:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B105F21D79
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Apr 2020 15:23:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tus7bxqL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B105F21D79
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 998686E9F0;
	Wed, 29 Apr 2020 15:23:28 +0000 (UTC)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F28416E47A;
 Wed, 29 Apr 2020 15:23:26 +0000 (UTC)
Received: by mail-wm1-x342.google.com with SMTP id k12so2483680wmj.3;
 Wed, 29 Apr 2020 08:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Ty18jkh7zkBHOD6czGW8SkI58aj/+4PBnyEc+GD/orI=;
 b=tus7bxqLbV6hNyOMoOR6rWwDXhsBMRK+6jioSAfK0KlwrSwSOr0fmUyBIRvGaBMJ3D
 J+JlxtgqA3bkzn5APaglpsmiIS6twFCJ3AGHR5NZDxsBKV4m7NcmKV4qvCZkCiCLHj0F
 wVoQWAC+k03amUFqge3cecu7wfI7kFyy9QCAe9F0i/n0P6dtZnLi+UdaSFW/3XXvzdXs
 TUbRmLQoCXCdOo1JndE/p4Fgcxzj2LoOcuMtDw1VvF15eL/AOqIuI98VYfVmRkbb39Db
 n62qJSCybrymus8vXGkZZxI/36eSFoxKIoJO96tDCyBieKuVk79quKpuUGc0iTWLojHU
 Mn8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Ty18jkh7zkBHOD6czGW8SkI58aj/+4PBnyEc+GD/orI=;
 b=bo3zIxYjSAHJuVryfhjJMx81B+/fGwwMWdRFMd4YTD6H9/vZFbN01lrsZGPyCCJvEm
 1Np9qrTlVtvyOSicMnjS+vACz5GC5eYGFTU+zfAwprM+iPlDVOvDHVUtZmqpOdSMODHj
 toSUdD55cY7A7DxHuCXX72pbWWGqsLxBJiXEG0mJUu5yMcRXTKk+5e7ocaDUTXmB5ppQ
 tj6O8vIAWk5YZ6LKJ4sLclS7QweM14Nyfu2zMcEDqjA8VR6ck/s8U55/dcJg+ZVVO3nO
 9UOuqer/THQvOBu88PkspuOBh+J0cflLsAle8R56lb5Yj+SvR4KX5wbrtcRA/N6wCl0U
 yfTA==
X-Gm-Message-State: AGi0PuaL8lzOQY+iJOHZS8+Hkn4JX5u1j/YZnUm5A3v6uBxLEaHW5gVC
 56CzICtxMDmCsTyc2SUataGeiFvjViUnFxtmKcM=
X-Google-Smtp-Source: APiQypIiNPHG4tyU4vIdIHmmJj7Iq3g5WXyRokunvJVlTuVMH/ieeXBCWNyF731wp2ksSFgu4BuTKHLynCFHmZpLiIs=
X-Received: by 2002:a7b:cc8e:: with SMTP id p14mr3795755wma.70.1588173804710; 
 Wed, 29 Apr 2020 08:23:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200428063101.25556-1-yanaijie@huawei.com>
In-Reply-To: <20200428063101.25556-1-yanaijie@huawei.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 29 Apr 2020 11:23:13 -0400
Message-ID: <CADnq5_MR5ZmcGXi70KAoqpHthhzCsyJfH4ZaXvjVDO5z9CLD3Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: remove duplicate assignment of
 dcn21_funcs members
To: Jason Yan <yanaijie@huawei.com>
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
Cc: Chunming Zhou <David1.Zhou@amd.com>,
 "Leo \(Sunpeng\) Li" <sunpeng.li@amd.com>, Anthony Koo <Anthony.Koo@amd.com>,
 LKML <linux-kernel@vger.kernel.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, Dave Airlie <airlied@linux.ie>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Daniel Vetter <daniel@ffwll.ch>, "Deucher,
 Alexander" <alexander.deucher@amd.com>, "Wentland,
 Harry" <harry.wentland@amd.com>, Christian Koenig <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, Apr 28, 2020 at 8:46 AM Jason Yan <yanaijie@huawei.com> wrote:
>
> Fix the following coccicheck warning:
>
> drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c:31:51-52:
> exit_optimized_pwr_state: first occurrence line 86, second occurrence
> line 92
> drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c:31:51-52:
> optimize_pwr_state: first occurrence line 85, second occurrence line 91
> drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c:31:51-52:
> set_cursor_attribute: first occurrence line 71, second occurrence line
> 89
> drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c:31:51-52:
> set_cursor_position: first occurrence line 70, second occurrence line 88
> drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c:31:51-52:
> set_cursor_sdr_white_level: first occurrence line 72, second occurrence
> line 90
>
> Signed-off-by: Jason Yan <yanaijie@huawei.com>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c
> index 8410a6305a9a..fe64bcb49456 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c
> @@ -85,11 +85,6 @@ static const struct hw_sequencer_funcs dcn21_funcs = {
>         .optimize_pwr_state = dcn21_optimize_pwr_state,
>         .exit_optimized_pwr_state = dcn21_exit_optimized_pwr_state,
>         .get_vupdate_offset_from_vsync = dcn10_get_vupdate_offset_from_vsync,
> -       .set_cursor_position = dcn10_set_cursor_position,
> -       .set_cursor_attribute = dcn10_set_cursor_attribute,
> -       .set_cursor_sdr_white_level = dcn10_set_cursor_sdr_white_level,
> -       .optimize_pwr_state = dcn21_optimize_pwr_state,
> -       .exit_optimized_pwr_state = dcn21_exit_optimized_pwr_state,
>         .power_down = dce110_power_down,
>  };
>
> --
> 2.21.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
