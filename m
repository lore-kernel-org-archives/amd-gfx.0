Return-Path: <SRS0=bavc=6T=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB4B3C47254
	for <amd-gfx@archiver.kernel.org>; Tue,  5 May 2020 19:20:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94801206B9
	for <amd-gfx@archiver.kernel.org>; Tue,  5 May 2020 19:20:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fcp1mNEP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94801206B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AAE156E0DD;
	Tue,  5 May 2020 19:20:37 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 234F76E0DD
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 May 2020 19:20:37 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id y24so3579391wma.4
 for <amd-gfx@lists.freedesktop.org>; Tue, 05 May 2020 12:20:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=aXjLj3WPHZg6N1sIT8bH9or7H5NXSbgU3dZ0zjFtmyU=;
 b=fcp1mNEPGiVYYRET//FeFvV6bUHcsG9I1Gh/zU7Fr3mgqyPLTq6aVdjVKnPAafOCkH
 PqOe4e2Sr+pgZk1DnOQcRvLnBNBwn5mjf2Ahr+3C7zzGIuwJ1fHw504Eg+Uzpw0hA9M/
 FjwwpPV3D3fIarsVhbkWsOgw01AyAhjNr8NgfPjraLVnbtHJx88/D0m0P5gdqNBb0QZl
 IwKIidLuhdUqvPMfihgpRWo6UccDhUZScuas0GDhIPSrxW5dQ6fmsCdHg2HvFqtR5qqY
 4BibBx2LMkOgquGHedELfOCkIc5mkXjzkb7Di9RDImRIY+hxGyRqI2jAYmc5H/wZGRye
 9hRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=aXjLj3WPHZg6N1sIT8bH9or7H5NXSbgU3dZ0zjFtmyU=;
 b=ht8eSaLFajIuI11KkT1wzS8Zyv99aQ8oEUF7M9xhYWJ6m20QPM+cplHPIUtYOJXSD/
 hSnHn41r429+J4YOQiFxxvSPnhWkDde5S05OQ6apljZ9sbLCTjSD6qG+XW/czgiOc4SW
 7diMZSg06PS/JyfgmEWqFofuG9U2sKIUTWsE5Tj/13zONxlLlltC7uiJTJoJ0mXH/wg0
 iFUjzNEzfoIwxQqE4t8SJ+GAjyUXhVXKjPRipbFFz/LXIloLGkVOGNwfb0gDBcJ+4HHc
 xe6jfz1rDzqAAMOZu7RKqgsuRBXEyUwLnDjwjf2ef6kkTyIvZ0ojzjImEob8SNBDjG6g
 QsPA==
X-Gm-Message-State: AGi0PubcjjVNDE65RutGf6XIW98o83soSXvxBWHHb6Jd7Gz9qq00h1SE
 1vJEZoUBZwuxnq2alDR1jdz9XzaG3DJQ77rWexk=
X-Google-Smtp-Source: APiQypLRkNost3XUJgwt6bmsRFLHQ4/1XNS6/1/KvOdIUnrAe4x//c10EpFTmM4mqOARk3taKiT8WW+3UldisnIjNqc=
X-Received: by 2002:a05:600c:258:: with SMTP id 24mr246316wmj.73.1588706435715; 
 Tue, 05 May 2020 12:20:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200505185708.23373-1-kent.russell@amd.com>
In-Reply-To: <20200505185708.23373-1-kent.russell@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 5 May 2020 15:20:24 -0400
Message-ID: <CADnq5_P_syiaE0di4U8+Fd5nPv5bG32LnYAt2d977sDNM14z7w@mail.gmail.com>
Subject: Re: [PATCH] Revert "Revert "drm/amdgpu: use the BAR if possible in
 amdgpu_device_vram_access v2""
To: Kent Russell <kent.russell@amd.com>
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Tue, May 5, 2020 at 2:57 PM Kent Russell <kent.russell@amd.com> wrote:
>
> This reverts commit e71391880aa72709fac53f98d96a2d4e8875b9fa.
>
> The RAS issue at the base of this problem appears to have been addressed
>
> Signed-off-by: Kent Russell <kent.russell@amd.com>
> Change-Id: I338a985e19cae8e103bd44b0f238314e9460d396

Would probably be cleaner to just re-apply the original patch with an
additional note in the commit than to revert the revert.  Either way:
Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 26 ++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index caa38e7d502e..bf302c799832 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -255,6 +255,32 @@ void amdgpu_device_vram_access(struct amdgpu_device *adev, loff_t pos,
>         uint32_t hi = ~0;
>         uint64_t last;
>
> +
> +#ifdef CONFIG_64BIT
> +       last = min(pos + size, adev->gmc.visible_vram_size);
> +       if (last > pos) {
> +               void __iomem *addr = adev->mman.aper_base_kaddr + pos;
> +               size_t count = last - pos;
> +
> +               if (write) {
> +                       memcpy_toio(addr, buf, count);
> +                       mb();
> +                       amdgpu_asic_flush_hdp(adev, NULL);
> +               } else {
> +                       amdgpu_asic_invalidate_hdp(adev, NULL);
> +                       mb();
> +                       memcpy_fromio(buf, addr, count);
> +               }
> +
> +               if (count == size)
> +                       return;
> +
> +               pos += count;
> +               buf += count / 4;
> +               size -= count;
> +       }
> +#endif
> +
>         spin_lock_irqsave(&adev->mmio_idx_lock, flags);
>         for (last = pos + size; pos < last; pos += 4) {
>                 uint32_t tmp = pos >> 31;
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
