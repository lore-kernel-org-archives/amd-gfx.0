Return-Path: <SRS0=a8HN=AA=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D63CDC433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Jun 2020 15:27:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADB40218AC
	for <amd-gfx@archiver.kernel.org>; Fri, 19 Jun 2020 15:27:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="shc8pz6C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADB40218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F2856E0B9;
	Fri, 19 Jun 2020 15:27:29 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 783F26E29A
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Jun 2020 15:27:27 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id a6so8130308wrm.4
 for <amd-gfx@lists.freedesktop.org>; Fri, 19 Jun 2020 08:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=/a92b2d0xxfT4k6ARStHrd4dDFZhp3XUKdlRugjYYXQ=;
 b=shc8pz6C5Yu53Tf3Wo6tfbLZ86uGdsjuqUToXRSukfPkwQgIr3SdK4ExkDIveZvgY4
 E/xSmnQhqjYXSc0mjIpAs+LP3vmLW0rOWFyS9cYanJShC3rZ/Uu6zx5c/MIEXr4HFMAA
 rXLOes/aAvSZ39iz7184vWJZXS5AkERlYz67XsdZJQ2vhgoP2TDvBY9VCsT/VJQOunMg
 7wRUjZ7NKVp9xS6zNEvMqy8qVEwH9Tb4sF2hIAsNvLfTcniT9hbXHeNYmmn86DdW55g8
 0Ll+W0wHJ/z1cFSUyotAuNcMpfRdIVrWXfjuCfiMSfLaTm95v3GF6S7WauZ9uBlWV9gB
 32uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/a92b2d0xxfT4k6ARStHrd4dDFZhp3XUKdlRugjYYXQ=;
 b=IvCOk+JjvJtNLMbvI3oXyif8qsvwhmaM75sIwz8cZc+nRaAG+o81CEBZJl/HaHbnXT
 Ti54A9K54fMIoIdtKVORuLNG7PcXE+VDTZ115wc/a6QyoAhHCb+TwPY0zEn3S7rvv4lO
 fiw4jbxcM6TOD9KOOYHnvxGwZWD51Oqx36MwP9LWjQn0yHhVpTO+AvVmuicgV2PCKgSj
 KUWXO+ZHREqD1CSxhOV/ECGNyf/EexMbtS+mhLViqwHNO259trTYKAOKJaJZwKUPTP/K
 YZmNfbxwljUsDKnObarQVXBRkTcyQTXPy+cOGNOOGJpLHf2qXutOK7thaqxLcwFVj7fo
 d7yg==
X-Gm-Message-State: AOAM532/xVgOI55L/Ui7x3jv8fKvJBtHYNrIZCFlQBVu4WtmG52QsVGr
 fuAYeJ66qKWMgUoTru4ey6nDoo6dbdmeudXlJIS+dQ==
X-Google-Smtp-Source: ABdhPJyYa4y4CMcWWNMI+KSQ2xou3GpI0XIXYikE8xcVmCYEQZ/JPZlshy7mKgPzDAQFYHOp/HvEuujYWrHwMg5y8CM=
X-Received: by 2002:adf:fd41:: with SMTP id h1mr4829567wrs.374.1592580446167; 
 Fri, 19 Jun 2020 08:27:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200618194936.9158-1-qingqing.zhuo@amd.com>
 <20200618194936.9158-2-qingqing.zhuo@amd.com>
In-Reply-To: <20200618194936.9158-2-qingqing.zhuo@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 19 Jun 2020 11:27:14 -0400
Message-ID: <CADnq5_NiJyjfS5zhE1zMCXPw9aDUwkXrhrAgpL6duM7OzoVriw@mail.gmail.com>
Subject: Re: [PATCH 1/1] drm/amd/display: fix compilation error on allmodconfig
To: Qingqing Zhuo <qingqing.zhuo@amd.com>
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
Cc: Lewis Huang <Lewis.Huang@amd.com>, "Cyr, Aric" <Aric.Cyr@amd.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>, "Wentland,
 Harry" <Harry.Wentland@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, Harry Wentland <hwentlan@amd.com>,
 "Kazlauskas, Nicholas" <Nicholas.Kazlauskas@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Jun 18, 2020 at 3:49 PM Qingqing Zhuo <qingqing.zhuo@amd.com> wrote:
>
> when compiled with allmodconfig option, there are error
> messages as below:
>
> ERROR: modpost:
> "mod_color_is_table_init"
> [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
> ERROR: modpost:
> "mod_color_get_table"
> [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
> ERROR: modpost:
> "mod_color_set_table_init_state"
> [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
>
> To fix the issue, this commits removes
> CONFIG_DRM_AMD_DC_DCN guard in color/makefile.
>
> Signed-off-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
> CC: Lewis Huang <Lewis.Huang@amd.com>
> CC: Aric Cyr <Aric.Cyr@amd.com>
> CC: Alexander Deucher <Alexander.Deucher@amd.com>
> CC: Harry Wentland <hwentlan@amd.com>
> CC: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
> CC: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
> CC: Stephen Rothwell <sfr@canb.auug.org.au>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/display/modules/color/Makefile | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/modules/color/Makefile b/drivers/gpu/drm/amd/display/modules/color/Makefile
> index 3ee7f27ff93b..e66c19a840c2 100644
> --- a/drivers/gpu/drm/amd/display/modules/color/Makefile
> +++ b/drivers/gpu/drm/amd/display/modules/color/Makefile
> @@ -23,11 +23,7 @@
>  # Makefile for the color sub-module of DAL.
>  #
>
> -MOD_COLOR = color_gamma.o
> -
> -ifdef CONFIG_DRM_AMD_DC_DCN
> -MOD_COLOR += color_table.o
> -endif
> +MOD_COLOR = color_gamma.o color_table.o
>
>  AMD_DAL_MOD_COLOR = $(addprefix $(AMDDALPATH)/modules/color/,$(MOD_COLOR))
>  #$(info ************  DAL COLOR MODULE MAKEFILE ************)
> --
> 2.17.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
