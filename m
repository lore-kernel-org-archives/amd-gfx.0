Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B751C88E53
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Sep 2026 13:16:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9858210E2A5;
	Tue, 15 Sep 2026 13:16:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="qGZiRks5";
	dkim-atps=neutral
Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com
 [74.125.227.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BAA0210E2A5
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Sep 2026 13:16:18 +0000 (UTC)
Received: by mail-pj2-f12.google.com with SMTP id
 d9443c01a7336-2dd8476135dso373405ad.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Sep 2026 06:16:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789478178; cv=none;
 d=google.com; s=arc-20260327;
 b=KihuqKNHMjXZlOmr6rlLifzKbe4RUQFFzI0s6y1HQqtUQwGu6mqz/L3J5bRaZcp1t/
 Te5Q7cS2/+Wwp76SpqP6CE3zPZfL29dr7qwgmE/WmQCi8p7q49+B4apHy8SzLkTzAl17
 nN2zjvAor2UPPuRMnb5nfPLJ24U7XUDzuA9kgcMQo5j8PGAAOPiC9bZFEMh4CDPXPmLd
 X59h7NLkbzcVUnNkEwiTKEECuHxMwA/r25VNlDyeM3oX2gfwWyzqKoA78lIRj61y+852
 yAnveJLbKnx+57LAlNlPt7YcN3knsdb6C45e0u1z4IKJqzDjd50uzmL7laU4cTDfiwof
 SOXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=40dgU6qQqb6dTdxX1to4cgoPEtY07lrdVwEJ0254YtU=;
 fh=2ODVRezT8Ewz3H/FTeFIRlbFApnUOct5TGkpGvmhybM=;
 b=Hlnrf1G75Uc2DjmtlwkoRp44KhI1Dzy0ZZFJPI7d2D+D7yaQBy7P8xpybnss6u1q0+
 QdB/JzprIf8hsvnodP2H5P0fl8LtGhd69t11lztC3tleVZdSMXB5COfc3kx/oGViaHgh
 3NCe3pNEiYs/EQMcvTj6avf/VDi3uXmEXHThMFtZ6X4FdRP9SSdzgC8L5BO/Ww2FrhTh
 KYFKdLxDnigFMPeBgUoJ+9vgPrPmH00+SxqftFO/hWq6a6Ya7zFxr+HXrG4nqvk4zUbC
 MwEnHJH9Ic09Gxy8nW53tDTMg+WE/V/mmDz7H4wld+v8vmX2S/JuL+CkTvUOU4Poc5OF
 H8Wg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789478178; x=1790082978; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=40dgU6qQqb6dTdxX1to4cgoPEtY07lrdVwEJ0254YtU=;
 b=qGZiRks5pK5HCbd5z4e5JM9UsB+R7hx8DIXKx/PsoixjpAvqD7NRic1pm1wzkY0fyI
 +gGhBCNc0O/jbo5gqUIBDv8VB6NJKGac5Gyg96UN68iljyjr9pBYeTy4MkpDuj+pvOq1
 K/DNVlYYQm6JTQnhXnal9qVSKrG0rL5QXs+MDoeVkDd6XRM5pEYUCkys+LK/Sy+ZHy2D
 OknR9Rwm8ZxCBUteJPm2n6v/uGWajFO5mMgXMsz2xNUHXpr1q3W25/zVo6ZMnZWBbCyI
 cE3mGn1hFPSB4s2R87hetm7Z9jphQ6jvqh/I9sXDc8vbGo9N5CWuIpYiGWKLC/5hzfGr
 fLAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789478178; x=1790082978;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=40dgU6qQqb6dTdxX1to4cgoPEtY07lrdVwEJ0254YtU=;
 b=B50JFQYSdyLAhkWTOjbgz0y7wvG5hwu8GvCOdwGlSromSlW7ADbJCbmFtB4YzT+SVZ
 SPRWm4RS7O3PhNLuP0h77/UbSe5NF5V2uJSAbKnKoqGOAr0q/3d5b/09fpmW0dH9Aw0d
 E6tAxst5x5iRXEkghTnUaq1ZixrLtlIMUK4o17vnDavrIpLm+kXcJWZCU8JxGQ7FUpEG
 Mq6ysbrj2gNYlipXpkKc6XqzOtbj30lhRNPwja5veottGG+V9y73GxNa0GhqHUokbCQv
 qKDlizeOOi0dbR1ekOJqNIU6M3iSgqiQwKwITvnCS9S5P2QvZJ9DbX8lB2lLH8gNsPQy
 Arhg==
X-Gm-Message-State: AFuF++mpQUuCE1ueRwkzOnSVgdY0iBA5Ll9RROniwVzgNoF9Aotz/ZqP
 lOkD5Jf0u1KbLGU6S9z4fBIrC8VhyCxhfrWgGkT8VK+Ibwb6/OznFSmi852gef/X7CAGZ1fQomy
 c7ICX7WsscXhz6T7J7r+cwauJRKOVMM8=
X-Gm-Gg: AYBFou3EHtP2tOttQvV9s8Kjf+T2TeQj6cDE9YNl5a3tUT1M7HFeFlL8B6sG766cTLR
 /qd7kSC22l1+dybpf57VsDvCoDdI6cRHi+rUD8YpYqrbJpSaDQMmvUH69ZkLC+oYv7pWrqNeQmh
 9xcAhsVhWSzOX1XmFKbAytvc2OvzPxeLvb8zY2M2QhL9FGnhMiRck7l9Acwp9jckpO8XgU4ndAY
 HTgQrjdtdkj/y2fAiTyKCcCP/BoKM4LfWBlrzwjGE3LFraF7W03UEmZg5v3ZEtoparSY/phC3Vj
 jPCe+KcrRuTNP6Wcn41Y9P+tUn3zlSwDuyYn5vPDij0gpWW8e6u4FmsZOWqJng2bL0OQFXY5wZG
 lVelb2XpCTuZUomvQHZ3S1O+3zIV7w74foU7H5hkIt+t+zcc7pYJd
X-Received: by 2002:a17:90b:2709:b0:39d:fcef:e241 with SMTP id
 98e67ed59e1d1-39dfcefe940mr6008219a91.2.1789478178048; Tue, 15 Sep 2026
 06:16:18 -0700 (PDT)
MIME-Version: 1.0
References: <20260915072432.1751101-1-YiPeng.Chai@amd.com>
 <20260915072432.1751101-3-YiPeng.Chai@amd.com>
In-Reply-To: <20260915072432.1751101-3-YiPeng.Chai@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 15 Sep 2026 09:16:06 -0400
X-Gm-Features: AcwNN1XBPaJ6RJzzRPGfBX2Vrd_DyvcNNCsYzc71Zf44SqPq5ob0hCovKaKMYiM
Message-ID: <CADnq5_N7n_8tt-3UkDKUgUcuu2D8Yf3VxMAi2RpkVkCSapnjiQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] drm/amd/ras: use __le32 pointer type to resolve the
 sparse warnings
To: YiPeng Chai <YiPeng.Chai@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Hawking.Zhang@amd.com, Tao.Zhou1@amd.com, 
 Stanley.Yang@amd.com, kernel test robot <lkp@intel.com>
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

On Tue, Sep 15, 2026 at 4:01=E2=80=AFAM YiPeng Chai <YiPeng.Chai@amd.com> w=
rote:
>
> Use __le32 pointer type to resolve the sparse warnings.
>
> sparse warnings:
>  ras/core/eeprom.c:275:15: sparse: expected unsigned int [usertype]
>  ras/core/eeprom.c:275:15: sparse: got restricted __le32 [usertype]
>
>  ras/core/eeprom.c:277:15: sparse: expected unsigned int [usertype]
>  ras/core/eeprom.c:277:15: sparse: got restricted __le32 [usertype]
>
>  ras/core/eeprom.c:288:33: sparse: sparse: cast to restricted __le32
>  ras/core/eeprom.c:289:33: sparse: sparse: cast to restricted __le32
>  ras/core/eeprom.c:290:33: sparse: sparse: cast to restricted __le32
>  ras/core/eeprom.c:291:33: sparse: sparse: cast to restricted __le32
>
>  ras/core/eeprom.c:333:15: sparse: expected unsigned int [usertype]
>  ras/core/eeprom.c:333:15: sparse: got restricted __le32 [usertype]
>  ras/core/eeprom.c:343:15: sparse: sparse: cast to restricted __le32
>
> Fixes: d95700604fbc ("drm/amd/ras: rename core ras_* files and update inc=
lude guards")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202609101657.kczNjTnY-lkp@i=
ntel.com/
>
> Signed-off-by: YiPeng Chai <YiPeng.Chai@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/ras/core/eeprom.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/ras/core/eeprom.c b/drivers/gpu/drm/amd/=
ras/core/eeprom.c
> index e7aad113b98a..efa04cd8fbe0 100644
> --- a/drivers/gpu/drm/amd/ras/core/eeprom.c
> +++ b/drivers/gpu/drm/amd/ras/core/eeprom.c
> @@ -260,7 +260,7 @@ static void
>  __encode_table_header_to_buf(struct ras_eeprom_table_header *hdr,
>                              unsigned char *buf)
>  {
> -       u32 *pp =3D (uint32_t *)buf;
> +       __le32 *pp =3D (__le32 *)buf;
>
>         pp[0] =3D cpu_to_le32(hdr->header);
>         pp[1] =3D cpu_to_le32(hdr->version);
> @@ -273,7 +273,7 @@ static void
>  __decode_table_header_from_buf(struct ras_eeprom_table_header *hdr,
>                                unsigned char *buf)
>  {
> -       u32 *pp =3D (uint32_t *)buf;
> +       __le32 *pp =3D (__le32 *)buf;
>
>         hdr->header           =3D le32_to_cpu(pp[0]);
>         hdr->version          =3D le32_to_cpu(pp[1]);
> @@ -315,7 +315,7 @@ static void
>  __encode_table_ras_info_to_buf(struct ras_eeprom_table_ras_info *rai,
>                                unsigned char *buf)
>  {
> -       u32 *pp =3D (uint32_t *)buf;
> +       __le32 *pp =3D (__le32 *)buf;
>         u32 tmp;
>
>         tmp =3D ((uint32_t)(rai->rma_status) & 0xFF) |
> --
> 2.43.0
>
