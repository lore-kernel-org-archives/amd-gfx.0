Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ED04E85367
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Apr 2026 14:01:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C1C1310F2FA;
	Fri,  3 Apr 2026 14:01:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="pK0cYI3C";
	dkim-atps=neutral
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D60C10F2FA
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Apr 2026 14:01:45 +0000 (UTC)
Received: by mail-dl1-f46.google.com with SMTP id
 a92af1059eb24-12a6b260693so112298c88.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 03 Apr 2026 07:01:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775224904; cv=none;
 d=google.com; s=arc-20240605;
 b=BCB/CW36TUY9IawdjVQJT/nESLzdJLmRSmlWllhMKJJ9aenqk2q1L5ZZkNreQNB6Qb
 7aSq55fMZ4czRpEbJxe0U2R9uIkdEjibCkIVty8ryitV/D2ChKC5SMni02G7rp0H1BWg
 wAEflEoRmIJo65eK/FNiqggV+6GKTW81IDddPNXZaRlr6dZTwz9SU/M4/+8aZbbjLYIW
 SaicMge5/X8pXcPJD1BxtkwP6J98S/WtjdZoNZ/btb8AvShqS+Kp95cZBU6bOzpwW0uC
 7LwID/9lwoWng7FKG0e+vSSI/HHvjeVfQyRSyedIxkrfi17ZyjpeaEZlCZE0ARx60BqL
 OJvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=LJ2nnaaeR2tfIM7of7QhXhKql8LCT2qYQ/cuHvT+1kc=;
 fh=IY98SR0cNO93Tj0qH750yd04bAXFkNbDKtBTzSqo1Bw=;
 b=HCyIV9Qj0M1OjEzbNU4FgHReHpnLbZnBmenAb5StzW58fGJhRB9RTtbCO2FFXLWvet
 acg6XDKJDNjcthkE8JnQu8Tty0xFWncPcIA8wWWIT+AgjeWokW7kG6HW7ls8moETjRov
 WOGrMH7RReFCSiC70YUBVQUqtYXxcVGmCWeC/ZctklBpwoVIrwXvpuhKPoe7R2corcna
 2qYIR4PuFulXqasFAUjTGgamWKZEw3RxrRfzN65ujPF3qjz6/UKcaRTT2Q5NJd9A3o9k
 C6/d4n8BbG74w3HM2Gdgd0Z2ve//oDQFgxRu28QcmtNdvyDzaLu/1VJX8D0Hh7qSDXZt
 HjOw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775224904; x=1775829704; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LJ2nnaaeR2tfIM7of7QhXhKql8LCT2qYQ/cuHvT+1kc=;
 b=pK0cYI3CDVBGL9FEvGqIvocgosl/id9H8bxJ4d5eJxJ5YCQ21IgvyAD+Lbeznw0x+E
 eaPWDNuInwWqFmFVPmzE3XoW6MWrLuJgaG5P5RsY730/ezUKDC4LzgJH5++wEN3twxfq
 DZ3Lr55w2aBwSbm4zLjlDdavZGe5GXdDbwTUOSEg0fOUYdlJ5WqJHvhfg8BmpywKBMbP
 j4tdpM6Q5rRj6/LOKSG7z3Ld4wSKYF37D/KHuLKAX8/mY252NO+2JNYgT+5Tj95Z6Fzd
 vzykE4dNm9or6FaXTVZLisJSM5ljnnxzIuNH0jtBMB8YKNf6rI57QmlHSVwB0F7r0rC2
 y2hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775224904; x=1775829704;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LJ2nnaaeR2tfIM7of7QhXhKql8LCT2qYQ/cuHvT+1kc=;
 b=K85ns2mobxS3QIVLlScXM8Y/TO6kavAN41jTe964MEKHVx5tmDpZBCfNt5k2iG8Pnw
 JjVeDVAxuMPxNg9afG7TL1kXRrnPutT9M3LyJlN3MNSxjLgKj+ZcAnZHHm6PmFay0OJo
 8Xixso5pYrf2NuVZ1siKprHz9vsqjuUj4f/uv1Oshp9jUxtSwNU4PDrKkhiz/uTlO7Jz
 C7741M3nRAuwAT/AIlsr8u8cRG8OT49zD/+3Shxmg7kOTrMlycwpKmdvzRGVEN6LeY1T
 KUHzeSAOTF/miwP3Bx+YAuozwoE5gGqhD2rx+BDSIX2xVtZXfRf+AnQiM7BNQg6klsnA
 1g2g==
X-Gm-Message-State: AOJu0YzGoGnjwtAq4CaIj3FCyVr/m+0aCDmU9qwgvXt6RGFGooygn7aN
 bcVK+/GOke07E4KOXPB4HU8pTDUDgShF95UQ1/W7VgrIq/sx8wsqFELaOwu5LMl4DcTL+E9aSdD
 /+N443DdXw5sPhRFbLpxU29wYO0gPa6NekQ==
X-Gm-Gg: ATEYQzxeMnKGY22Ux1M/cBaE6k3ZW6sXcjzqWJarBvKciKoNf+uL9zX2Rq+54mWtpQ9
 W8O2qg5vit3LViR0T0hXBfXgsf9eFjqAL6rGmT79KzS/2sdTN27hvMdbNRtylW10LmiWVBNR0wY
 /B3kutvYMCVeU8DtJPjkY2PguOLtcKsF8YhmAQhJxeB/yYGQpdiLaz3phDPtcvzLKTU80+DpanY
 kcNUdfjHyu1bEPoi/ZCzmL6WQss7IzU8Q2aS3R64GjmpjsswZc2p+VWmcexSa55NnZY7J5k8iNQ
 lllVU+4tbjy0bGgFcCTCZPWPG2I94n+PoQjmWWWGOJYYcFIgL/HnIg1qxCPm33kaIBQMHw==
X-Received: by 2002:a05:7022:6086:b0:12a:716c:d29c with SMTP id
 a92af1059eb24-12bfb788ae1mr606746c88.7.1775224904159; Fri, 03 Apr 2026
 07:01:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260326175140.52753-1-alexander.deucher@amd.com>
In-Reply-To: <20260326175140.52753-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 3 Apr 2026 10:01:32 -0400
X-Gm-Features: AQROBzDOOSqpJ0mlVCal5osiJ5PJ_CGQAuaj8-ts0krRpPt3x8QPIciM9Zd3AnE
Message-ID: <CADnq5_ONMWOCPR3wdWLEKPz7EeOHDS3ZMeFe9VD_5N5CXQ3Piw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/sdma7.1: add support for disable_kq
To: Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
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

Ping?

On Thu, Mar 26, 2026 at 2:09=E2=80=AFPM Alex Deucher <alexander.deucher@amd=
.com> wrote:
>
> Plumb in support for disabling kernel queues and make it
> the default.  For testing, kernel queues can be re-enabled
> by setting amdgpu.user_queue=3D0.  Kernel queues are still
> created for use by the kernel driver for memory management,
> etc., just not user submissions.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c b/drivers/gpu/drm/amd=
/amdgpu/sdma_v7_1.c
> index f20e0fc3fc743..061934a2e93a3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_1.c
> @@ -1268,6 +1268,18 @@ static int sdma_v7_1_early_init(struct amdgpu_ip_b=
lock *ip_block)
>         struct amdgpu_device *adev =3D ip_block->adev;
>         int r;
>
> +       switch (amdgpu_user_queue) {
> +       case -1:
> +       default:
> +               adev->sdma.no_user_submission =3D true;
> +               adev->sdma.disable_uq =3D true;
> +               break;
> +       case 0:
> +               adev->sdma.no_user_submission =3D false;
> +               adev->sdma.disable_uq =3D true;
> +               break;
> +       }
> +
>         r =3D amdgpu_sdma_init_microcode(adev, 0, true);
>         if (r) {
>                 DRM_ERROR("Failed to init sdma firmware!\n");
> --
> 2.53.0
>
