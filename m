Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF98DC25B7A
	for <amd-gfx@archiver.kernel.org>; Thu, 23 May 2024 18:45:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1720110E7DB;
	Thu, 23 May 2024 18:45:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gs3tvqdK";
	dkim-atps=neutral
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com
 [209.85.210.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3AC7210E7DB
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 May 2024 18:44:59 +0000 (UTC)
Received: by mail-pf1-f176.google.com with SMTP id
 d2e1a72fcca58-6f8e819a540so137488b3a.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 May 2024 11:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716489899; x=1717094699; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TUL4IHMC8icb/6U6wnQ5jEo8TkSOmmKiKqNypd/iXmo=;
 b=gs3tvqdKt5G6VEC/d8BXHw/xqFUsFIwmwRYtSj7q0OImdOnmcE1myMxt1vnByU3es2
 WbjOKmi8SHfu9aHnZRqZKMSYcObc4k6Zy3UZZ9WKkmdi/D+PusOO2HQ1puPLh1F0ohs0
 yjBSraYY4Cavo89Q7eKla3Tce9i0FzsWwtdlIQmXDGzB6dO06ZKi2Me1d0Eir+JeTlhM
 oYVcM0OBxvcMZJBLnhlhANCUoLpKivhXb+UDdIebXuzGjG+pCP7jedaS4DVmo/FIvPSI
 +4nkAfP00Qo+abH7NtDVhATyZvQYgcyf5sgl+YBycXu0nTzKHv/LDHIZb7XKyRbXO7eH
 5WUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716489899; x=1717094699;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TUL4IHMC8icb/6U6wnQ5jEo8TkSOmmKiKqNypd/iXmo=;
 b=o/McK31QYN1Fv+SIC/Ugrl9/vATtWh/kLvDJfKLmbV5fSKtAsbu3U4VRNa5/RrxuME
 7hjIjTPcKQT8CREY5pOTBjqhCIMLaxoR7bLymAW/W6isuqA+X1R9ESWBhcxjdK+EfOIW
 4uzgeMIEzCFze+ABcWn/9lXbihG6R2/gCB4i6Z/rb1sOjL5lENzMQxvvzPERPYPmexz1
 zAS92aMgoW4GT4K5+KtSpdHb9W/HNQQnpfeaVbO8VhCEnKU+N+lpa6nBfiJUlJ5NpqEs
 g4iXylmgaevNqOjeHierkXBaKo77A0n3PVr1Qy2epVaCLPnucc9/kanBj54Lsya3aJfl
 Zz8A==
X-Gm-Message-State: AOJu0YyEbWREYZryezRGj9rJoWNfITyzr5swb4yVUPbWk29eI7ukR74c
 cM91rbPyo7O0wxiFGCSxJMD1GYUOEllmoSewKKVml8iTil0eLlV8aeUaWpKSm5b9evR5vk7iOj3
 ytysFB7FHFRF/A7RrXF3KK3/UmZM=
X-Google-Smtp-Source: AGHT+IEG3lZEGfcUhS98cYPSKm5TwCIIyDpo+i3vdVc2EQRAvdbh3BMH5Nn50gWFGtNCRZnPYDq1XnAW2x8uPIcCzpQ=
X-Received: by 2002:a17:903:1c8:b0:1f3:61c:30a2 with SMTP id
 d9443c01a7336-1f4486d4ffamr2155145ad.2.1716489898656; Thu, 23 May 2024
 11:44:58 -0700 (PDT)
MIME-Version: 1.0
References: <20240516135501.2214792-1-alexander.deucher@amd.com>
In-Reply-To: <20240516135501.2214792-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 23 May 2024 14:44:47 -0400
Message-ID: <CADnq5_MwxfE+Hsgksn+QWiV8Jf7F5Je+dOJZ1yVOVmWis8e9MQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: silence UBSAN warning
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

On Thu, May 16, 2024 at 10:32=E2=80=AFAM Alex Deucher <alexander.deucher@am=
d.com> wrote:
>
> Convert a variable sized array from [1] to [].
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/include/atomfirmware.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/include/atomfirmware.h b/drivers/gpu/drm=
/amd/include/atomfirmware.h
> index af3eebb4c9bcb..f732182218330 100644
> --- a/drivers/gpu/drm/amd/include/atomfirmware.h
> +++ b/drivers/gpu/drm/amd/include/atomfirmware.h
> @@ -3540,7 +3540,7 @@ struct atom_gpio_voltage_object_v4
>     uint8_t  phase_delay_us;                      // phase delay in unit =
of micro second
>     uint8_t  reserved;
>     uint32_t gpio_mask_val;                         // GPIO Mask value
> -   struct atom_voltage_gpio_map_lut voltage_gpio_lut[1];
> +   struct atom_voltage_gpio_map_lut voltage_gpio_lut[] __counted_by(gpio=
_entry_num);
>  };
>
>  struct  atom_svid2_voltage_object_v4
> --
> 2.45.0
>
