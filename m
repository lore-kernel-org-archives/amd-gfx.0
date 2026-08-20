Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEE8CC5DF81
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Aug 2026 15:21:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 30BE710F0A1;
	Thu, 20 Aug 2026 15:21:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="s+mPUAVl";
	dkim-atps=neutral
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com
 [209.85.221.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 52A6210F0A1
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Aug 2026 15:21:21 +0000 (UTC)
Received: by mail-vk1-f178.google.com with SMTP id
 71dfb90a1353d-5bfa60aa6caso1322e0c.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Aug 2026 08:21:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787239280; cv=none;
 d=google.com; s=arc-20260327;
 b=UEAfyUU8bQVCwiVR2UATjs/on8+61pQFTTWSpUUNUrlpOOGblpEJf9DV7V/oX8hw0O
 s3gIXsX73k0IQgFynkdpxuM55/107rDwg+WD5gLj5qYNAe9NAA8ysDiT/yFgNY5/s7mT
 2utct2yL8vCGGr6zlAKHHysKhz/8GHpGPJlYM+WQy6rPoy1nmonKaAEUqBQBkbWjWQ2i
 rB+EJZ1WhHeB07alQGypgXCWI3K7ZU6YFmR9Y/VMnZ3B2HlRWJiaC8YjesG3nO+BEW9C
 O8uIH7TfFagUjoacxJ7hGjpVRnCq1WpREcjYpRerw1hsb9b/XQhiiXrIdPELhCsk5QGh
 xY8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=R7bZXy0dMx0t46UyaTxKNCWYtIdJp2xGab0xl3HP0Jc=;
 fh=INgAn3Dz+hp99rlSHGoUboV5nmBkpKulC1yGIax4Mhc=;
 b=NpaAoox/ujuW1aegc7AFIdMnJcaIoWLOE9kCx3tA9d4Vj3wij6htD+3OXhflqG91Mm
 axCjwx3/vm0m8Hv3LCN4MSBHXQBCNbHreCGmcw5e6AsPDOy6926jO0kIs0fCHCSjIWH1
 3BUKkNTykm/VEJ/lmuKyIBZGHXjKtuPDosjPvWBg2OFjak5HK2wU16JmuL/oHSoOkNXu
 8dLl5zhNVWMblcqFR+Ljzck/3CnFQVAP+f48Er74pmDgIN0hhIBxYWsCLYDnMHiWFybW
 b7Ru1pBMe/Bv2sFobDZ8N28l19AsOp61MbGVVUGzf7ZTdCyB9XnqS868ftJGqVSFQxJN
 2oVQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787239280; x=1787844080; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=R7bZXy0dMx0t46UyaTxKNCWYtIdJp2xGab0xl3HP0Jc=;
 b=s+mPUAVlcq/Q4e8CeDlzezgZqh2cYJ7NQ2OnTQsImek/H2vhB6Pq0ZdjvhSf0U6dBo
 Ql7Ewm5BvMh4QXi1llLnc6kjQd+OlYu/AOjDuLolPVrA3K7KXHLfPNvveRK/xWpAmxKO
 LMVrmrfc2G+n0JbMQpcCnlaIuptj300BtnonlYrIeIYJKzlhqTepJz7kyAx1bcx8TnER
 Ca7qErIO6OOJbM8siXE5gSGX8tznaSAPTCmLyvtkz1edPRmX9MnvGZkR8lIVwhVYOemt
 kd8lHANceR1y2OsKSbMuhLGqyZ/Q4ni1XscNZiFeSzzJh9mIbvYpjFLi8G6KQauMqfZn
 nbAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787239280; x=1787844080;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=R7bZXy0dMx0t46UyaTxKNCWYtIdJp2xGab0xl3HP0Jc=;
 b=LPDnq0/RImFI1j9VJZFoqLlFaTVZlKqm8idGFFRvHOeOUnt4wphpqUNjVMDUcVqx99
 lgpi+5AZoTC2dJjfVYLv6eKI0CInQPM95XpOYUtL/htzCLhtJRcK78RHUH+6IJfq6zSO
 +DHdlPq2f2QnYgwXFpYUQvpi5yEsYYujjFL0Iy6DvvtbViDaKxVwB6j9vz+K4yzZF3YD
 sXTvl+Zq2/m05ftZD5vVrME+z0GXevQPdSQZZq6Rycof9haaL7JChdjXJELMYmi6pgAj
 C9YtPVRDXBHalJmRM+w7s5pfdqcCJGJE1AXlrgYg461XY65xrLK9bsJEES12GY66kVtQ
 ya/g==
X-Gm-Message-State: AOJu0YzknKGOgzAsQueIkLSApPPog281thyAobwgZXsxz+Rsigthkrlo
 4l/zrgYaQYX+3oBfHixSq9NZ3wAjwHSTbJeq4ovMZ0fA4uShdsc8PhaZk8G+S1cm1WO5XLLuMr3
 Q0PLQkiXI2+fr2gZ9CDNVDR5nn9aeL50=
X-Gm-Gg: AR+sD11s6mMPKibYtnPYLEWAngTqb+z3IcJU0+pPi0uiiTlVtyWe2gpOQQDEZ+gmGXW
 eTxNY0JCa0PAVhzP4K/4KJ/FUkZWIBNo/PbNcN3wbOU4+UiOqImzagMBQvr4fZVBvji/+3S/OHi
 DvhcD97vMQL6BMPUXKOhAkFR/RE0zgaoKm0rzYRNEnkHYuBGabQyDGSEucwdIGNAnhmaaQYQ+zk
 oZSbJOiIKJ7SsP36wbcZJPo7V60250WnLgOUgoyuQnBO1X3clrEjSgSeOhM29mpyY9soQinWwmG
 yYSjBTTOXyCo/y0oB/rCVCMw83MX3DmwlOv6tYZkpSn5tQjAds/GeYxlBo2u7e6I80z2ebe47jt
 ohP/vl5NbadpV3ctVsotI8PP97q9SW/8=
X-Received: by 2002:a05:6102:8024:b0:772:cccb:f7eb with SMTP id
 ada2fe7eead31-777fb1adaf4mr1994874137.2.1787239279784; Thu, 20 Aug 2026
 08:21:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260820045438.3974-1-yogesh.mohanmarimuthu@amd.com>
 <CADnq5_MNFZfbvkgQ6JYjBZOb5+E+kezXDphFHshaaw7h7yVk0w@mail.gmail.com>
 <CH0PR12MB52689AE98C9044860F3FB914FFA42@CH0PR12MB5268.namprd12.prod.outlook.com>
In-Reply-To: <CH0PR12MB52689AE98C9044860F3FB914FFA42@CH0PR12MB5268.namprd12.prod.outlook.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 20 Aug 2026 11:21:04 -0400
X-Gm-Features: AcwNN1Vy47JB15XM6ZMnzIYRbogFPwSMFPa5QvLJCGaoOErjA2Tanh9gYen95rM
Message-ID: <CADnq5_NL1vec9Xp=6EjUupmJb8DkkUu2dz44URLL5gf+f9bKxg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/userq: fix struct drm_amdgpu_info_device
 padding for 32bit compile
To: "Mohan Marimuthu, Yogesh" <Yogesh.Mohanmarimuthu@amd.com>
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, 
 "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Koenig,
 Christian" <Christian.Koenig@amd.com>, 
 "Khatri, Sunil" <Sunil.Khatri@amd.com>
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

On Thu, Aug 20, 2026 at 11:18=E2=80=AFAM Mohan Marimuthu, Yogesh
<Yogesh.Mohanmarimuthu@amd.com> wrote:
>
> AMD General
>
> Hi Alex,
>
> In 32bit mesa, I did not get the correct userq_ip_mask value.
> I checked for variable alignment and tcc_disabled_mask was not on 8 byte =
alignment. This patch fixes it.
>
> Can you please tell how it would break UAPI. What did I miss.

You are changing the layout of the structure that existing apps expect.

Alex

>
> Thank you,
> Yogesh
>
> ________________________________
> From: Alex Deucher <alexdeucher@gmail.com>
> Sent: Thursday, August 20, 2026 7:23 PM
> To: Mohan Marimuthu, Yogesh <Yogesh.Mohanmarimuthu@amd.com>
> Cc: amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; Deuche=
r, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian <Christian.Koen=
ig@amd.com>; Khatri, Sunil <Sunil.Khatri@amd.com>
> Subject: Re: [PATCH] drm/amdgpu/userq: fix struct drm_amdgpu_info_device =
padding for 32bit compile
>
> On Thu, Aug 20, 2026 at 12:55=E2=80=AFAM Yogesh Mohan Marimuthu
> <yogesh.mohanmarimuthu@amd.com> wrote:
> >
> > need to pad before __u64 tcc_disabled_mask variable.
> >
> > Signed-off-by: Yogesh Mohan Marimuthu <yogesh.mohanmarimuthu@amd.com>
>
> This will break UAPI.
>
> Alex
>
> > ---
> >  include/uapi/drm/amdgpu_drm.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/include/uapi/drm/amdgpu_drm.h b/include/uapi/drm/amdgpu_dr=
m.h
> > index 0a113529b..5beef3eaa 100644
> > --- a/include/uapi/drm/amdgpu_drm.h
> > +++ b/include/uapi/drm/amdgpu_drm.h
> > @@ -1517,6 +1517,7 @@ struct drm_amdgpu_info_device {
> >         __u64 high_va_max;
> >         /* gfx10 pa_sc_tile_steering_override */
> >         __u32 pa_sc_tile_steering_override;
> > +       __u32 pad;
> >         /* disabled TCCs */
> >         __u64 tcc_disabled_mask;
> >         __u64 min_engine_clock;
> > @@ -1541,7 +1542,6 @@ struct drm_amdgpu_info_device {
> >         __u32 csa_alignment;
> >         /* Userq IP mask (1 << AMDGPU_HW_IP_*) */
> >         __u32 userq_ip_mask;
> > -       __u32 pad;
> >  };
> >
> >  struct drm_amdgpu_info_hw_ip {
> > --
> > 2.43.0
> >
