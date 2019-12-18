Return-Path: <SRS0=4PMp=2I=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4386FC43603
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Dec 2019 20:11:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10E622176D
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Dec 2019 20:11:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RHrQ37zd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10E622176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9B136EA69;
	Wed, 18 Dec 2019 20:11:57 +0000 (UTC)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 263036EA69;
 Wed, 18 Dec 2019 20:11:57 +0000 (UTC)
Received: by mail-wm1-x342.google.com with SMTP id p9so3169507wmc.2;
 Wed, 18 Dec 2019 12:11:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=asjBFAc442UzOKCO94ECHDPGR6UOLGBjJoWcETKLgww=;
 b=RHrQ37zd7pZ1Ol32SljckI6ty3rBZXzVoS1TBltTsFzON8fQ63O6OfA994LtZYp9lN
 17stnxMuVRXa3G3uCuKKMgMR4Od4+bP0vNpmuPs+KvsGj9IZj0DxhDxoCwnp7dtqiQyj
 iehJp4M0U5p4wmmKswfZpSiL+y1fYHiDC0qpEGDniHjSU/88k+yN5Ph/b4pqg4PKHsAd
 vpu+8IqIS8WI5Y+viJpkkybZqHyuFzLRt/8XBefG0psrXlqvPQCxXLSAI6UHzxOrsbEE
 aatzZP3Hzh6vkUJqw+rAK0/zqGAqwF5Vq8gHApc7Jt+22YfIckGkOb/xNpw67CwIw0KN
 vKPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=asjBFAc442UzOKCO94ECHDPGR6UOLGBjJoWcETKLgww=;
 b=Zc+HFuukdDFL1EbVpvSPcOMxheZ2CvQyOfSCoE111Wz0R5mVUFp/3LaAYtusqfqayo
 Gdj9IK3nkmvlhvkRqD/01PVMj+Y0T7PXOVUSxT2rRHRN/K6R46Lb5lxA9a+4y8tO19fy
 tzUZWZ4DCSB7jyWWZzT9ItQOxUOcPgX36wN9TVWScFOemUDBjh7QVC7INfhDS4X0wMk5
 7qU0LMAV+wN4+6saL+9LAW2Y0LQP2HdUxolZukrbDck/4FMX/gH41HkWA6j+vXEg9GSo
 PLqo/NuAo0q/1YrQuyQvlixambmJF46VUju56GkJWqsXU5Vvmf2438c0IZHMPEwSE2QF
 V7hA==
X-Gm-Message-State: APjAAAUxyI7aWFO1IAb6ytEei0ljMwz50TVr++eyVu/ZpMr4v9NxzebX
 2RI2C+dlxKlZ24rUOhv4zhzD6EprQGuJhwM/4Uw=
X-Google-Smtp-Source: APXvYqyDcj+8JBYZx+iJu5kmpX47FYUUmcFFn7vpG8sArbbMcs6yo1LPH1elohOVN5VqTG3bb/D1fywuF7VaeZuHui4=
X-Received: by 2002:a1c:f30e:: with SMTP id q14mr5330685wmq.65.1576699915830; 
 Wed, 18 Dec 2019 12:11:55 -0800 (PST)
MIME-Version: 1.0
References: <1576641008-14880-1-git-send-email-zhangpan26@huawei.com>
In-Reply-To: <1576641008-14880-1-git-send-email-zhangpan26@huawei.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 18 Dec 2019 15:11:43 -0500
Message-ID: <CADnq5_Ozj+PjFGO9V9O3bajujNBcuBiL+vJYbV7dHUhZhNhdGw@mail.gmail.com>
Subject: Re: [PATCH 3/3] gpu: drm: dead code elimination
To: Pan Zhang <zhangpan26@huawei.com>
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
Cc: Chunming Zhou <David1.Zhou@amd.com>, hushiyuan@huawei.com,
 LKML <linux-kernel@vger.kernel.org>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 Dave Airlie <airlied@linux.ie>, amd-gfx list <amd-gfx@lists.freedesktop.org>,
 Daniel Vetter <daniel@ffwll.ch>, "Deucher,
 Alexander" <alexander.deucher@amd.com>,
 Christian Koenig <christian.koenig@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Wed, Dec 18, 2019 at 3:14 AM Pan Zhang <zhangpan26@huawei.com> wrote:
>
> this set adds support for removal of gpu drm dead code.
>
> patch3 is similar with patch 1:
> `num` is a data of u8 type and ATOM_MAX_HW_I2C_READ == 255,
>
> so there is a impossible condition '(num > 255) => (0-255 > 255)'.
>
> Signed-off-by: Pan Zhang <zhangpan26@huawei.com>

Applied.  thanks!

Alex

> ---
>  drivers/gpu/drm/radeon/atombios_i2c.c | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/atombios_i2c.c b/drivers/gpu/drm/radeon/atombios_i2c.c
> index a570ce4..ab4d210 100644
> --- a/drivers/gpu/drm/radeon/atombios_i2c.c
> +++ b/drivers/gpu/drm/radeon/atombios_i2c.c
> @@ -68,11 +68,6 @@ static int radeon_process_i2c_ch(struct radeon_i2c_chan *chan,
>                         memcpy(&out, &buf[1], num);
>                 args.lpI2CDataOut = cpu_to_le16(out);
>         } else {
> -               if (num > ATOM_MAX_HW_I2C_READ) {
> -                       DRM_ERROR("hw i2c: tried to read too many bytes (%d vs 255)\n", num);
> -                       r = -EINVAL;
> -                       goto done;
> -               }
>                 args.ucRegIndex = 0;
>                 args.lpI2CDataOut = 0;
>         }
> --
> 2.7.4
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
