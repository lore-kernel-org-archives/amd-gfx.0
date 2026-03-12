Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E1E5106703B
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Mar 2026 14:32:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DEEC110EA4A;
	Thu, 12 Mar 2026 14:32:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XOcwu1Q4";
	dkim-atps=neutral
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com
 [74.125.82.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8521F10EA44
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Mar 2026 14:32:55 +0000 (UTC)
Received: by mail-dy1-f172.google.com with SMTP id
 5a478bee46e88-2be22d699c9so47795eec.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 12 Mar 2026 07:32:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773325974; cv=none;
 d=google.com; s=arc-20240605;
 b=NvB4JM9j4rHoFMfWUqCYTG+p+AUybyei51EDS3+NTKBcLzPb0QUP6qRRtX/+xGbYF+
 8ZTOE4ZiLoQ3y2zEwn/fXtXrTU5ElmWcbcvq5b+AusNVB9HKCngMo829xoANI/RNN8cl
 epXNcbpMxewQEfmLcyDbs6C20Nwwdf/smYu8B1ExHoxX3Rztr8z9jZjgpDnNETKF1bne
 MrAyVtnvDCfB+otymyGYzjCXMjLEXjSJD7JGLuW1e+6uz/i8GYHQPHVhhqyPrJ1LvXMA
 cCzq52X/VrqlmXT9iMfik3nr5rN1NUyZNatZP2BX+omfIamZoXN63A9efIe2QnRKzmtn
 SN7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=dzPtc4ymmlAOyUPjTjfboEQPnFwau7qXTjbFtq64Ozk=;
 fh=VBSzNdaH58xBFNDsrgEck+9cT6J+ULkJDCz7Z70orr8=;
 b=kqmMm5u6NEQFcmh1tF0IT5WH5D2HpmfelGF7HSXNE3tE26OlgdqEuEBDU/Sb5NaoX6
 HGllMhBTkdnwvEQ+RI5mxvYB+gmiyZaG+jGXqGJs2D3X1U3lFnkTTHeEW3giSkbGLGqt
 jpiVyuKJEzhyfJm0sfaDVOvdrcoDDZWNlawE00okjUs/dnunRjlUJ1vIoHONHtt1pLV1
 mIzqDQ9DcdaEe1vivHXbCQdZYhLEY4Dv2BM8E/q8XgfYx39hZhfMSJRZ9OSZoBqCX/cS
 f7shKEo80jLw4uRnzPHxXU1VfVgyR7dgli3sUY3aE9SvzRQxCiL8tNXsSUNJFYNfZvoF
 UXEg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773325974; x=1773930774; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dzPtc4ymmlAOyUPjTjfboEQPnFwau7qXTjbFtq64Ozk=;
 b=XOcwu1Q4PPBHfHo56C2CWG0q1no3pCG9h++ZC29hikksAJzG85Ml1vCOkgO4OQ7k0l
 OQT/yuS4Nk16VDlzcdVO5A37gu3uBMx9jVy4jzg4a3WYNDYVKtR45RKkrc3CKxQxyBDC
 4PUvPNGye4jsXizwYt/sMjtTIttJdQXD1NJ/iR9+7ne1LT+RMNQ0jW58ohu5afDr/N70
 EneiZ/rs+pl14orYyqN/aoALVXwbVwF6HNZGASsVBbxZ/az/oVYIEbbxTGJsmEmQcprU
 2rZT4i7mQJImz9PtKySqz6chbiwl3bJoVJF9uLMyeNPaP2Eqbe9txxGhsuYw3O4vw9cd
 yRHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773325974; x=1773930774;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dzPtc4ymmlAOyUPjTjfboEQPnFwau7qXTjbFtq64Ozk=;
 b=BWkS131cWUXOL966mISvYzfPFk9KTd4EVlMkBCxB93afZf6W3qC0BKyo/P1aUnUSYA
 NhjKSQA65UCfkGbTzATeeLSPM3FWsB4RwNoaRmOZcDlaLOeHV4Y8KQ+ummp9GftbP0c9
 RUNJKoAeoY79LdHfdFnDt982uLg6b8D1TGBUK+VfjoAi0MDQ+CeSOg8M2yud+VYCf3iF
 pynILxfqPWpVxqX1cUZxeioe/cDru/DWbsOZdsMQo8hZiWfPzPw2j+i89ssUHUBie+wb
 XzegBhlE4g39ZpNR1QLSBo6PNbn3I/fECFGkrFGDkJz4Dqh7OdMR9BuR/yusjECTVFpH
 bFsw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWDY8NfNcDCDVaz0WZL0rQOil42jgHBfGKxmn44/KJPgWlAYEALZ+/KcKKvIH29F8WIWe+wcSVg@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzoJXByt+FLb4vlY1gT1sHfgKSweQYYiFkS4vVTM4MgEgHO6Eo9
 ZcELqPto55OP+D/tjmd9oReAUlX9RT/vCj5G3jYDCXwRO6CnZOQiZ6BxVOa6e7kQz8Y6bQC5tdh
 7M+tZMCqkjSo0MLAc/Y/SVH3sVAPu5JQ=
X-Gm-Gg: ATEYQzzkHywNlbOTXm9+bOLdCkjjMlR2ac/pbqPYo80h+n09UrPpDCK/QcdBi+j0yDt
 ptQGkh9spVB2dgBqpr6gdA3qQWQZ2ZOSsocPxeZik9LNYL+VfdbbPV8qbsJkeaRkPZTU+Ca7qFP
 rbKWr0b5KZrNknhndpKCnQqOiB+xxxseJbmOuoOcXIyxiVbDfD4O38vsxZ28XgoN2dX+iQwFcBk
 aBETI3bj9eG++IIVj1ouSZk9SGb6QoUkBxKDqfAx0ULmXjLhrt5IJAQjFe1sFvVmdHNDQcySlM3
 CLdJxxf/TghVt8krnDI8DhaoS8RIqRRdSZGFND1ciPOLL9i2lLb42bQibJzjgcKcfmzLbA==
X-Received: by 2002:a05:7301:1f12:b0:2be:6e6:e479 with SMTP id
 5a478bee46e88-2be8a25c555mr1416151eec.2.1773325974370; Thu, 12 Mar 2026
 07:32:54 -0700 (PDT)
MIME-Version: 1.0
References: <20260312140331.1850721-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20260312140331.1850721-1-srinivasan.shanmugam@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 12 Mar 2026 10:32:42 -0400
X-Gm-Features: AaiRm50oNG98w9RHF_O3i4rBxj_XeAPp_6oysElG9jVo6WjMhXdJ3jDcI_cbA9o
Message-ID: <CADnq5_PKW2BSQzSc3HBNzd1rqQ44ut-+AOE_arOhJBqvtjDL0Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Reject unknown digital connector IDs in DVI
 mode validation
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org, 
 Dan Carpenter <dan.carpenter@linaro.org>,
 =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
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

On Thu, Mar 12, 2026 at 10:19=E2=80=AFAM Srinivasan Shanmugam
<srinivasan.shanmugam@amd.com> wrote:
>
> amdgpu_connector_dvi_mode_valid() assigns max_digital_pixel_clock_khz
> from a switch on connector_object_id, but the switch has no default
> case.
>
> Simply initializing the variable would silence the warning, but it would
> also hide an unexpected connector_object_id and continue mode validation
> with an arbitrary fallback limit. That makes the code less explicit and
> can mask invalid hardware or BIOS data.

I think this fix is effectively dead code.  The existing cases should
cover all possible digital connector types that this function would be
used for so we'd never hit that case.  I suppose if this function ever
got used for some other connector types it might be a problem, but
there would be other things missing as well, plus this is legacy code
so it won't be used on any new hardware.  If you update the commit
message along those lines and note that it's good practice to have a
default case, but it shouldn't ever be hit here, the patch is:
Acked-by: Alex Deucher <alexander.deucher@amd.com>

Alex

>
> Handle this by rejecting unknown digital connector IDs with MODE_BAD.
> This keeps the behavior explicit, avoids using an uninitialized value,
> and preserves the intended validation logic for known connector types.
>
> Fixes the below:
> drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c:1243 amdgpu_connector_dvi_=
mode_valid() error: uninitialized symbol 'max_digital_pixel_clock_khz'.
>
> Fixes: 585b2f685c56 ("drm/amdgpu: Respect max pixel clock for HDMI and DV=
I-D (v2)")
> Cc: Dan Carpenter <dan.carpenter@linaro.org>
> Cc: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_connectors.c
> index 04842e3f1ccc..a8ccc1602eb5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c
> @@ -1231,6 +1231,8 @@ static enum drm_mode_status amdgpu_connector_dvi_mo=
de_valid(struct drm_connector
>                 case CONNECTOR_OBJECT_ID_HDMI_TYPE_B:
>                         max_digital_pixel_clock_khz =3D max_dvi_single_li=
nk_pixel_clock * 2;
>                         break;
> +               default:
> +                       return MODE_BAD;
>                 }
>
>                 /* When the display EDID claims that it's an HDMI display=
,
> --
> 2.34.1
>
