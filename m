Return-Path: <SRS0=yWhT=GL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FBF1C433DB
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 18:16:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AEDF23A6A
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jan 2021 18:16:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AEDF23A6A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7A096E888;
	Fri,  8 Jan 2021 18:16:24 +0000 (UTC)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 49D476E88A
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Jan 2021 18:16:24 +0000 (UTC)
Received: by mail-ot1-x32b.google.com with SMTP id j20so10528326otq.5
 for <amd-gfx@lists.freedesktop.org>; Fri, 08 Jan 2021 10:16:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=RbPiksOuYgCNAiWR6hjw7YCJ/a0JrI1JtDU0ZkPZa+s=;
 b=I9ZANC0Hck3R0j4sUYOcAXo7wIphoNKT+5mbPml5smcqN4Sqx03S+a7Fl0BuK2mZGO
 AJWcjb8IHnOzxXruVU1tMKeMzWZ0OZqaEHgRh5ZSTZgl5jlWOMmf+7HKsbin2BzLUvDG
 07yB9lqCdCRmb0R3eUWw+ywdZaKKoDIjS5rQhfTRCaqm+68dMi5BN3ng8PRYnvCI5ZiF
 JawXHJq62P72S9IZ3spORfQQZ2lxuwFXiMBa992I4CrL0sfslkoqcQBkYbckeXMuJt2g
 Vb6jADJmTChXZuT5baMTH9InUuQ14HUpvVq04t6ufU2WoTbkmxp2N7TcJ5eec+IE0bPd
 WpBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=RbPiksOuYgCNAiWR6hjw7YCJ/a0JrI1JtDU0ZkPZa+s=;
 b=gKUhgWof7pLsm3N9G6xqHCi9reTH6nqdkwbZLUbiEBUvhHZbaHgV75kfMffEXKR8Jz
 ACZIcP7UfbVz1rowiUctk5xVN/Bluycr9G1mDJfy7CLXt20AKu6BJp0nS83tcEuGwRw/
 GmAUHu1Q7JhVOtIE1GD/ygN/fSHljQqrwuUwpTv6BRM/tKsTLbWgIgEMfKplQsHQj6sa
 UNosG4OWPhdT2gYnfDiQl7PWUEsReD/n5c/c0XYft2uAuenJ21vOfHZdTFaoNFKC8OIk
 bq4t0ULOMiGZKxlnQqyitcU4vanpct86o3fTa6kvbi2HgsNIl7rPSLTZBd8ICRlE4+mv
 R2Eg==
X-Gm-Message-State: AOAM531fmz7SaF9218Nsg7fV2RqOxD2YYrR9zt6Wj4Uq48COfsJZpHkA
 gN2CYoA/xK1mbvRqPTuvCFjdDDmgjIs94xuURvg=
X-Google-Smtp-Source: ABdhPJzfb9IZx3tjDvXbE2wuMm6SL1y8kWBPxap8QjhVh4YjBqQnztfHQFfGowL5J06UF33V3PuhstE+Gpq9yNpUs0c=
X-Received: by 2002:a9d:75d4:: with SMTP id c20mr3433545otl.311.1610129783602; 
 Fri, 08 Jan 2021 10:16:23 -0800 (PST)
MIME-Version: 1.0
References: <20210107235303.99848-1-alexandre.f.demers@gmail.com>
In-Reply-To: <20210107235303.99848-1-alexandre.f.demers@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 8 Jan 2021 13:16:12 -0500
Message-ID: <CADnq5_P72wZLVQ1zrgBJ87zYEVSEtbBBN95k7AwScddFkDbhaw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix DRM_INFO flood if display core is not
 supported (bug 210921)
To: Alexandre Demers <alexandre.f.demers@gmail.com>
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
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Jan 7, 2021 at 6:53 PM Alexandre Demers
<alexandre.f.demers@gmail.com> wrote:
>
> This fix bug 210921 where DRM_INFO floods log when hitting an unsupported ASIC in
> amdgpu_device_asic_has_dc_support(). This info should be only called once.
>
> Signed-off-by: Alexandre Demers <alexandre.f.demers@gmail.com>

Applied.  Thanks!

Alex


> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 1cb7d73f7317..9246c2ae7b63 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3034,7 +3034,7 @@ bool amdgpu_device_asic_has_dc_support(enum amd_asic_type asic_type)
>  #endif
>         default:
>                 if (amdgpu_dc > 0)
> -                       DRM_INFO("Display Core has been requested via kernel parameter "
> +                       DRM_INFO_ONCE("Display Core has been requested via kernel parameter "
>                                          "but isn't supported by ASIC, ignoring\n");
>                 return false;
>         }
> --
> 2.30.0
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
