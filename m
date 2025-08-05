Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D54A1C87FD1
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Aug 2025 14:11:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B74F10E277;
	Tue,  5 Aug 2025 14:11:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="A+3XrTO8";
	dkim-atps=neutral
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E8D3D10E277
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Aug 2025 14:11:12 +0000 (UTC)
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-2420c9e3445so8701965ad.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 05 Aug 2025 07:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754403072; x=1755007872; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=djwEfK8jIB/jKZvbEzImyVxoS6Fkzu8f82S5IyUIEKY=;
 b=A+3XrTO8Nqkx+Hm1/O0a7re85kmagYEy4iQDwdxNhKioCXIojoT4j/BAi8OBV0DZuP
 CGUoFnH3QWGcRV5LtOZYPoPW3OlrDfY4xf5E689GYxhV0vnB9Y7I16ZHPP5CmItzaISY
 cOw/RHNr0Zdede3zFTSzBUChHxxrElJFHJNi/HCyrQVYlCDNDVqqNBh+ZEErDsYzEeCi
 Y6lTqbx4lrtp7gKqznoBG3Nxwd78Y+hdStaALPW+rnEwmvk6Yc5xIWAdWevmaio46tsh
 QhlzNRdOwEmBbiWOsbm41X/eEpubCexmJczYOXcRl8+plR/yUTv9DbeluuTC0k0S2DEf
 /txw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754403072; x=1755007872;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=djwEfK8jIB/jKZvbEzImyVxoS6Fkzu8f82S5IyUIEKY=;
 b=DP6qD4UP5uaMTxgZ6MULmICyPiD9wwmhRb2Ijbmu4NJqcXkuJ5E4ovbHHALq+6JD33
 p14ANchH3G3YRagC2Enxk3AahSnNgQ2aviHxf+nei0v24q2DjYpFe2tHGg40r+tlMEwQ
 ERC8oYx4RNdxIgxowCTBEznQCz8VGNNLy+/Prg5BJhjQwHV02ufgp7vr2TQSpFxIe2at
 HDf7bKUioYVxAEeNeswMCq23OI1g0VTlflgfCrNuQIm8ZAy0ePzbDPqrAXU/K25ai3Wb
 3Ev5MP1wAD5LCii1Dk19R0Lmq7NtF+rttGgzogd7TR1gggI0HOrQAC8tZ0bOU3v51wZ8
 +kjg==
X-Gm-Message-State: AOJu0YyHhBnzIZZWrFNcFIZCX5MwBfg1LKgIjyNoJgkBE2uZPfOkH3B7
 Rq/VJAA+ah9xh9eA7TSGZjDErtnAsS+1NjB/9FDOu/XYC1p6Ot8t7WpEpCCmAHtAxZaT9a/Hnl2
 NJR3TTHqXi7ktG14ranfkralNVghJzX5waw==
X-Gm-Gg: ASbGncu5GsffUEfuhyccIz/iShSXHqQVxTTULmF/THOSNDKuqyBNxcpoxcUM8mV3xEu
 rdwcPegMlfELA289dOmJu0c2xBPkiF5RfEr5uaknEWN81SafPTM5CQx64iOyh+1SHyrJ87EpgRi
 vm3oSx8219/jVDeQHEE47BU6CD2GCUv65nXjNii3HXfzTeZxiSaniLrULy8AnGC38yqkvg0Y7VW
 MJYu3mT
X-Google-Smtp-Source: AGHT+IG19NS66qu+B35gtcYTUqgkto2nD+I9AtOEZ23vHtZjxEai9C4VOk1YPAqH/ceyddYA9ANYHR6wvcyGFceSsW4=
X-Received: by 2002:a17:903:124b:b0:240:967a:fead with SMTP id
 d9443c01a7336-24247004d90mr80289745ad.11.1754403072198; Tue, 05 Aug 2025
 07:11:12 -0700 (PDT)
MIME-Version: 1.0
References: <20250805140947.4159216-1-aurabindo.pillai@amd.com>
In-Reply-To: <20250805140947.4159216-1-aurabindo.pillai@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 5 Aug 2025 10:11:00 -0400
X-Gm-Features: Ac12FXwEHX5uzcMhug64SH3_eNOjXAudyUHQ2jH1xaRrTWdzpoU1ZB5xvqRRNCc
Message-ID: <CADnq5_PPEdyvVeBtNHnmURe3GZCDP9HRsOEM5c1+3-EL962-FQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Fix vupdate_offload_work doc
To: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: amd-gfx@lists.freedesktop.org, harry.wentland@amd.com, alexhung@amd.com, 
 Stephen Rothwell <sfr@canb.auug.org.au>
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

On Tue, Aug 5, 2025 at 10:09=E2=80=AFAM Aurabindo Pillai
<aurabindo.pillai@amd.com> wrote:
>
> Fix the following warning in struct documentation:
>
> drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h:168: warning: expecting=
 prototype for struct dm_vupdate_work. Prototype was for struct vupdate_off=
load_work instead
>
> Fixes: c210b757b400 ("drm/amd/display: fix dmub access race condition")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> index 94f312bae9ac..cbd107493f8a 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> @@ -154,7 +154,7 @@ struct idle_workqueue {
>  };
>
>  /**
> - * struct dm_vupdate_work - Work data for periodic action in idle
> + * struct vupdate_offload_work - Work data for offloading task from vupd=
ate handler
>   * @work: Kernel work data for the work event
>   * @adev: amdgpu_device back pointer
>   * @stream: DC stream associated with the crtc
> --
> 2.50.1
>
