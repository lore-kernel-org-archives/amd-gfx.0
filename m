Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B9BCC25B7C
	for <amd-gfx@archiver.kernel.org>; Wed, 22 May 2024 13:51:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A020F10F34D;
	Wed, 22 May 2024 13:51:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TSbYvMoz";
	dkim-atps=neutral
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com
 [209.85.216.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 004E510EE76
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 May 2024 13:51:51 +0000 (UTC)
Received: by mail-pj1-f53.google.com with SMTP id
 98e67ed59e1d1-2ba1a0947cbso2084989a91.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 May 2024 06:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716385911; x=1716990711; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zvA7N/ndkBe36ThDd3bl1ajpCU8sLBmcFnJFbqUO8Z8=;
 b=TSbYvMozBP1ie6taVhI0z/BtSOYnchLKlLblg4RdjDBnaVWJJFNkMTbWIHDNJ8EoX7
 /8z+q1i479JeR+KIl6SscPAm5D36PEcI1C55vrOLG+nmECE4aKrCJlDn6upr2PD9VWSN
 /aEr4Ay2Ebj44CNPYlTl/mLON6fwXWJKsgd4fK8n+OT1aBBRmii+heeLbDLVoMH/jovU
 0jDu6aoiGAkZkjvgf+fTguj9jyOmQVKMtakfOrv5s1h+oApnsyokCpqE7qEG128fmlrD
 OX2PaJgNMmKam8GO20M9e5xpyk+85+66p615nQXDWgNt2/fqrkO3gzP4Ks0Uq4XA+G5e
 Ii1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716385911; x=1716990711;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zvA7N/ndkBe36ThDd3bl1ajpCU8sLBmcFnJFbqUO8Z8=;
 b=oofTLgIyIhDsZS3tKW3uo82aaCMsmI5sHyggbnIlWZRlljf0QFLKUw5UHCspNB8Cf6
 D7FmXIysdGiETKEz3QAhettg7yDvkXKp8ixQ9edPTfI9sy8CAx+ogCdsrL3oMedbTbDc
 Mu5FPWUOSEp4MmLf8O2x3PA8Nk50F8HxPEQPmvLV/E+/C2LfZ4q2J9sDAz67MwfDauRZ
 fsZFZ55L4bKLEDQBCT2eaA6vrQx7zhUfXwHmgXNMvukMnmMgE9B2jzwQ0WI1bgJUFA3/
 M7F4B/GTkFKADuv88I9bmjOjeYEgY1bC9Av/bbOfZT2sjdNIg5lX0eDA1PgjK25D+AxW
 px9g==
X-Forwarded-Encrypted: i=1;
 AJvYcCV2UKdjceOlBNPlElpjFGd39I937ftbvSMJ4jOst4DhDEK3spr1znEhr2rlXaI6gXq/ih2qk3r2s/7lpUk1hRvN5ToaHuELY+9z+Fmzjw==
X-Gm-Message-State: AOJu0YzlleIgK9P8D4EMkDkODKj4eX7HmvL86fb+WOket4bjEYkbVQ9/
 mU8Ixi6m7Hv/3DidAuAptxqrarDTBFo+HEMWkl34W3NilfBP7rQNt2rEcopV2tcQJNhQFC2jChj
 JZC3h24qHKU4S2BKqdRVulohytNE=
X-Google-Smtp-Source: AGHT+IGQx6eWjFvoahyRRyVJQsW6QhTBSGrPRhCQxVSm434F0GswmfmZZd57dGOUj956J4nzSeysk00Ro6pabvZaF3Q=
X-Received: by 2002:a17:90a:1048:b0:2bd:7610:e6ae with SMTP id
 98e67ed59e1d1-2bd9f46a199mr2188456a91.5.1716385911322; Wed, 22 May 2024
 06:51:51 -0700 (PDT)
MIME-Version: 1.0
References: <20240522072950.9162-1-sunil.khatri@amd.com>
 <20240522072950.9162-5-sunil.khatri@amd.com>
In-Reply-To: <20240522072950.9162-5-sunil.khatri@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 22 May 2024 09:51:39 -0400
Message-ID: <CADnq5_NT0Y7PSBwC7bk2yspTuU+qZS68PpuKs8cYTJWymCd+Ug@mail.gmail.com>
Subject: Re: [PATCH v1 04/10] drm/amdgpu: add prints while ip register dump
To: Sunil Khatri <sunil.khatri@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 amd-gfx@lists.freedesktop.org
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

On Wed, May 22, 2024 at 3:30=E2=80=AFAM Sunil Khatri <sunil.khatri@amd.com>=
 wrote:
>
> add prints before and after ip registers are
> dump. It avoids user to think of system being
> stuck/hung as register dump takes time after a
> gpu hang.
>
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_device.c
> index e72e774d17e6..844dbb3d43c5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -5373,11 +5373,13 @@ int amdgpu_do_asic_reset(struct list_head *device=
_list_handle,
>         if (!test_bit(AMDGPU_SKIP_COREDUMP, &reset_context->flags)) {
>                 amdgpu_reset_reg_dumps(tmp_adev);
>
> +               dev_info(tmp_adev->dev, "Dumping IP Registers\n");

Maybe say "Dumping IP state" since this could also contain
non-register state in the future.

>                 /* Trigger ip dump before we reset the asic */
>                 for (i =3D 0; i < tmp_adev->num_ip_blocks; i++)
>                         if (tmp_adev->ip_blocks[i].version->funcs->dump_i=
p_state)
>                                 tmp_adev->ip_blocks[i].version->funcs
>                                 ->dump_ip_state((void *)tmp_adev);
> +               dev_info(tmp_adev->dev, "Dumping IP Registers Completed\n=
");

Same here.  WIth that fixed, this patch is:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

>         }
>
>         reset_context->reset_device_list =3D device_list_handle;
> --
> 2.34.1
>
