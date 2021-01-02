Return-Path: <SRS0=sK2M=GF=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CA8EC433E0
	for <amd-gfx@archiver.kernel.org>; Sat,  2 Jan 2021 14:05:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E870F22482
	for <amd-gfx@archiver.kernel.org>; Sat,  2 Jan 2021 14:05:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E870F22482
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=basnieuwenhuizen.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17BC589907;
	Sat,  2 Jan 2021 14:05:41 +0000 (UTC)
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com
 [IPv6:2607:f8b0:4864:20::d32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F301898EE
 for <amd-gfx@lists.freedesktop.org>; Sat,  2 Jan 2021 14:05:39 +0000 (UTC)
Received: by mail-io1-xd32.google.com with SMTP id p187so20899942iod.4
 for <amd-gfx@lists.freedesktop.org>; Sat, 02 Jan 2021 06:05:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=basnieuwenhuizen.nl; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=p4qVqwA7jrTtstjwMuxg0ZT53Kp0X36l0PsmxPDjju0=;
 b=bdnGkeIDB61DTRcS1SWlGze5QNewmYaVuEFLme/eIw+ng3pwRYU/A3vu590WrHbjUb
 Q4EnaH9biey3W/ZJdjc2DI/VSihukazHSBubXhxNu1/bjzJisWIaDTHcbeUZnnBBvdkc
 bi5iVLjSeuUEl1+JJh0Gj6PAr1DeGPboJ2gwoLh4pI42OTt8uYAhLg8jpfxkEpWGQD1v
 aRCWaO07j88xrBvhGGuQWiMD8klmpyhUK4Kkvy8HxyKkG5CcFhKuJt3QL0DMiWZ3+5x4
 J6oLg3BEcbNZAAZ2dO7niM8GcSdNIxUtVmzfxLxcbai/9QAJx0K7oKnyHJ1CgtLCsYhT
 FG+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=p4qVqwA7jrTtstjwMuxg0ZT53Kp0X36l0PsmxPDjju0=;
 b=PhbC9PdZ/ewMPc2SQQy5ZFqzRyNwuKcUAz5SYLzWNToXfQ7RsgE0KAnxJ73EQ2s+ib
 E75YFj2rSIgy1pkAHHpj56VbTw+Anu0oJD68OOnHzjJ+B5hyB52ZM5w2moSZFDq+Co8g
 SLeOJsMnPhXiaXDJjFodtPAGz5Pv30d2q+oZduSOk9YSdTg/TQV1UtMrhZ8wv1k4zJRo
 GKWXU/HDBGD2f3WTFMu8m7c7Wp8/eb7Dru8zWJLH6Igt6goqbnlX4N7B9REr9/a1KVPp
 4yvPClTEZacCYIhBu7SHsTuRvrsWDrfQWfifRw3otUeJphW3VdmVVRjfx9p4Y1JjouyI
 z1OQ==
X-Gm-Message-State: AOAM530KRCYczVj7mS0I2Fmc6ty44Y0bxCrTBTni+KBYnvzNPdR40tH8
 AiwUG+5a3KvPMtV8CNxZGOkHhR4Ed03hKAbqDAY0BQ==
X-Google-Smtp-Source: ABdhPJzmgvRotmWbK/dERf1wNHHzVf5tSLEYjyH5bXTmBshnxK1ACWCUYysnZ9nGsPIs83U0aXAqMnIcldrhr+lrV7Q=
X-Received: by 2002:a6b:b2cf:: with SMTP id b198mr53293625iof.19.1609596339089; 
 Sat, 02 Jan 2021 06:05:39 -0800 (PST)
MIME-Version: 1.0
References: <20201231205136.11422-1-mario.kleiner.de@gmail.com>
In-Reply-To: <20201231205136.11422-1-mario.kleiner.de@gmail.com>
From: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
Date: Sat, 2 Jan 2021 15:05:49 +0100
Message-ID: <CAP+8YyE4H5mL3uj-T4uG0nz75XmgaZ6etXX6YxxdtO4-rL=5qA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Fix pageflipping for XOrg in Linux 5.11+
To: Mario Kleiner <mario.kleiner.de@gmail.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 amd-gfx mailing list <amd-gfx@lists.freedesktop.org>,
 ML dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

I think the problem here is that application A can set the FB and then
application B can use getfb2 (say ffmpeg).

https://lists.freedesktop.org/archives/dri-devel/2021-January/292761.html
would be my alternative patch.

(I'm not good at detecting the effects of tearing  apparently but
tested this avoids the pageflip failure by debug-prints)

On Thu, Dec 31, 2020 at 9:52 PM Mario Kleiner
<mario.kleiner.de@gmail.com> wrote:
>
> Commit 816853f9dc4057b6c7ee3c45ca9bd5905 ("drm/amd/display: Set new
> format info for converted metadata.") may fix the getfb2 ioctl, but
> in exchange it completely breaks all pageflipping for classic user
> space, e.g., XOrg, as tested with both amdgpu-ddx and modesetting-ddx.
> This leads to massive tearing, broken visual timing/timestamping etc.
>
> Reason is that the classic pageflip ioctl doesn't allow a fb format
> change during flip, and at least X uses classic pageflip ioctl and no
> atomic modesetting api at all.
>
> As one attempted workaround, only set the new format info for converted
> metadata if the calling client isn't X. Not sure if this is the best
> way, or if a better check would not be "not all atomic clients" or
> similar? In any case it works for XOrg X-Server. Checking the ddx
> code of intel-ddx/modesetting-ddx/amdgpu-ddx as well as grepping over
> Mesa doesn't show any users of the getfb2 ioctl(), so the need for this
> format info assignment seems to be more the exception than the rule?
>
> Fixes: 816853f9dc40 ("drm/amd/display: Set new format info for converted metadata.")
> Cc: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Mario Kleiner <mario.kleiner.de@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_display.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> index f764803c53a4..cb414b3d327a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
> @@ -828,7 +828,8 @@ static int convert_tiling_flags_to_modifier(struct amdgpu_framebuffer *afb)
>                         if (!format_info)
>                                 return -EINVAL;
>
> -                       afb->base.format = format_info;
> +                       if (afb->base.comm[0] != 'X')
> +                               afb->base.format = format_info;
>                 }
>         }
>
> --
> 2.25.1
>
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
