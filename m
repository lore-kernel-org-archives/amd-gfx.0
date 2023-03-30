Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AFABC6FD1D
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 18:12:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E79F910EF6C;
	Thu, 30 Mar 2023 18:12:11 +0000 (UTC)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 950E110EF6A
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 18:12:09 +0000 (UTC)
Received: by mail-wm1-x335.google.com with SMTP id
 l15-20020a05600c4f0f00b003ef6d684102so8612356wmq.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 11:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ffwll.ch; s=google; t=1680199928; x=1682791928;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=seHCnSN9fc24OYrcfpBdgfwWSuQMWUtLp0CPwn3+aMk=;
 b=Ew2vSHlLWxT4SG2ip0bGA2R6eX6YWrkt2/fi0g2GWygsYHHNs8rzsEhazvys0UqyGL
 5kkCL9eySmcHibaebWxtOS7kO5X1XxGYTm8CD9LqXXCZzK/WRXybwuJeGhCyftu9IMpi
 +hxZnCx9BTiGQNJUYucCVvUdqg3vsuP34HjsE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1680199928; x=1682791928;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=seHCnSN9fc24OYrcfpBdgfwWSuQMWUtLp0CPwn3+aMk=;
 b=MPzJAql7ThY88ipMI9r4N972IQ2o25NpD0QbONgQkqVT+kIha25eP4jXtCKhkIA+bK
 eE82t8XRB8nKP95Ud58akHmWesunOn4FiLyYbuEwuio80hXPB96jsinHR5qs1ihGUg1D
 YpoyqwTSLwc9Ka7fpCqCodYuFHOtqBU5DC9B/uny9v06UyPUxRzOEkD7tNAEn91Vof0V
 PQwjwfqbWSRfcFupnC3q2++rMqr2HZ85b/e8zRotQx6EPP4LdYPOX+tAnQMIJC7eEXni
 U+9MqLiqrX1BppYiP3zXvUGhaDyPhZdCA4XvrI+lUSAf9MVOS1E1+SehHjgV+R132lx3
 rYaw==
X-Gm-Message-State: AAQBX9eb2LASf5LfKUt0uPSTUxUpIkGncRoF2EKoJl11DBO8eHCwpVAD
 rHpdXVYzeRbUnMrpR8uUM0ngdQ==
X-Google-Smtp-Source: AKy350aBfkHrD19cfljv2cx+BMmhlX4WzWEZwpj221HqqkcsiMky1WcqHJLfWgas6NUV6dFKX7500A==
X-Received: by 2002:a05:600c:3b91:b0:3f0:3d41:548f with SMTP id
 n17-20020a05600c3b9100b003f03d41548fmr1516098wms.3.1680199928082; 
 Thu, 30 Mar 2023 11:12:08 -0700 (PDT)
Received: from phenom.ffwll.local (212-51-149-33.fiber7.init7.net.
 [212.51.149.33]) by smtp.gmail.com with ESMTPSA id
 c1-20020a05600c0a4100b003ee5fa61f45sm7515953wmq.3.2023.03.30.11.12.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Mar 2023 11:12:07 -0700 (PDT)
Date: Thu, 30 Mar 2023 20:12:04 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Alex Deucher <alexander.deucher@amd.com>
Subject: Re: [pull] amdgpu drm-fixes-6.3
Message-ID: <ZCXQ9MkO7xO9zaF2@phenom.ffwll.local>
References: <20230330153859.18332-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230330153859.18332-1-alexander.deucher@amd.com>
X-Operating-System: Linux phenom 6.1.0-6-amd64 
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
Cc: daniel.vetter@ffwll.ch, airlied@gmail.com, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Mar 30, 2023 at 11:38:59AM -0400, Alex Deucher wrote:
> Hi Dave, Daniel,
> 
> A regression fix for 6.3.
> 
> The following changes since commit 68dc1846c3a44d5e633be145c169ce2fd5420695:
> 
>   drm/amd/display: Take FEC Overhead into Timeslot Calculation (2023-03-29 17:21:06 -0400)
> 
> are available in the Git repository at:
> 
>   https://gitlab.freedesktop.org/agd5f/linux.git tags/amd-drm-fixes-6.3-2023-03-30
> 
> for you to fetch changes up to 2fec9dc8e0acc3dfb56d1389151bcf405f087b10:
> 
>   drm/amdgpu: allow more APUs to do mode2 reset when go to S4 (2023-03-30 11:23:58 -0400)
> 
> ----------------------------------------------------------------
> amd-drm-fixes-6.3-2023-03-30:
> 
> amdgpu:
> - Hibernation regression fix

Yeah for a regression fix a 2nd pull makes sense, pulled, thanks.
> 
> ----------------------------------------------------------------
> Tim Huang (1):
>       drm/amdgpu: allow more APUs to do mode2 reset when go to S4
> 
>  drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
