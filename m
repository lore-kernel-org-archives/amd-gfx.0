Return-Path: <SRS0=OT/I=BY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEBEBC433E1
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2020 04:53:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A82D220639
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Aug 2020 04:53:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jKKnUSPl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A82D220639
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 402886E2D3;
	Fri, 14 Aug 2020 04:53:56 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C3C56E2D3
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Aug 2020 04:53:54 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id z18so7174125wrm.12
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Aug 2020 21:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=AxYOsbmFhv2DoSOe4PAq4KLaokBWayN2baAjast6VZY=;
 b=jKKnUSPlI7LfaXvYEQfcyIBN9KUjr3ufpF+SUlFyudVHxMb3Y79cc7RzjzJojyk4GV
 qMte9wrzPgp7+mgimx3IzJBQpojQdfBQJJCJrHW7VDo3B3qJHFqFGyKYwCEB9qpBOOrS
 4nF2OAlSAHACMfIjVYpw7lRgol0pCAM03P49tbIMStIIdMv4Na+UeKJnqOi/bt4+8XWa
 UbP1IjtpDah5m53g1mBkfjNHEQHvcHkaQrJhcBGE588RhJZvdZoX68nQ7vRy5GHXtC3+
 0YaR8kWylMkzTPRaotzM/R1CMtVOtSu+thcmzMLCmBg0ef3Jg/UBkv4IuIHw8Zt1qD3p
 MNIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=AxYOsbmFhv2DoSOe4PAq4KLaokBWayN2baAjast6VZY=;
 b=ZDojLClDuumrNN5+GjQK7zCkwv8G5SND2hAdHrR53j3RlcfJqMm4g+ofRFkdE7CL3P
 1Kq7pDVspeipDJGSpC5xbTfV654yqxHZpqekFKHicv+6tX10ixY1FQJoOV/SFupmI4Mc
 qQfcA48owDA4QxKJfwKB96YH1FHc5f8h5JD9pZK9mrYWmViblgfNHXavhzm+jvdO6cvK
 namv9J+Hl8Pkk2nAN37b55UvPOVel0N7WNSA3ULXIctqrN86eIio6vNdd/0supz/jHod
 IO49rpWJ9c94N6lj2QKR91e/ZSFSbT0PuJlqrxDu6xZOYKh909+nMc6TY8uxCIFElK8R
 KfGQ==
X-Gm-Message-State: AOAM532tvoTWbgrDkRpLyDQRA+kFOaEXrf+dcIt5fP281EVZ530pk4Ii
 Z0gj3ditNnnrTDfnGQpq+xs9QpSEwSf/k6ZosPKwAQ==
X-Google-Smtp-Source: ABdhPJyEuCJLEr5yKNmAHU2ttaI3omE0wVnaHWGpyKB/sZgxhxZp+bi2QqIYMnPkWbYPfB++70d1ZWLnQAsyva2queE=
X-Received: by 2002:adf:a351:: with SMTP id d17mr922300wrb.111.1597380833099; 
 Thu, 13 Aug 2020 21:53:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200814042126.6104-1-evan.quan@amd.com>
In-Reply-To: <20200814042126.6104-1-evan.quan@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 14 Aug 2020 00:53:42 -0400
Message-ID: <CADnq5_OwqADzFCTyJRBuaSgtqdjBGC4J7LTW5GWF73NTKgmmuw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/powerplay: suppress the kernel test robot warning
To: Evan Quan <evan.quan@amd.com>
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
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>,
 kernel test robot <lkp@intel.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Aug 14, 2020 at 12:22 AM Evan Quan <evan.quan@amd.com> wrote:
>
> Suppress the warning below:
>    In file included from drivers/gpu/drm/amd/amdgpu/../powerplay/smu_cmn.c:
> >> drivers/gpu/drm/amd/powerplay/smu_cmn.c:485:9: warning: Identical condition 'ret', second condition is always false [identicalConditionAfterEarlyExit]
>     return ret;
>            ^
>    drivers/gpu/drm/amd/powerplay/smu_cmn.c:477:6: note: first condition
>     if (ret)
>         ^
>    drivers/gpu/drm/amd/powerplay/smu_cmn.c:485:9: note: second condition
>     return ret;
>            ^
>
> Change-Id: I4b512008b8fe410fc7974e0483c39206ebec08ca
> Signed-off-by: Evan Quan <evan.quan@amd.com>
> Reported-by: kernel test robot <lkp@intel.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/powerplay/smu_cmn.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/powerplay/smu_cmn.c b/drivers/gpu/drm/amd/powerplay/smu_cmn.c
> index 968b734baac0..a58ea08cd115 100644
> --- a/drivers/gpu/drm/amd/powerplay/smu_cmn.c
> +++ b/drivers/gpu/drm/amd/powerplay/smu_cmn.c
> @@ -604,7 +604,7 @@ int smu_cmn_update_table(struct smu_context *smu,
>                 memcpy(table_data, table->cpu_addr, table_size);
>         }
>
> -       return ret;
> +       return 0;
>  }
>
>  int smu_cmn_write_watermarks_table(struct smu_context *smu)
> --
> 2.28.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
