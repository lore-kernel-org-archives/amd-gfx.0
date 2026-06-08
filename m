Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EDC1CD8CAC
	for <amd-gfx@archiver.kernel.org>; Tue,  9 Jun 2026 07:16:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0735D10E11D;
	Tue,  9 Jun 2026 07:16:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="pFxD7YIG";
	dkim-atps=neutral
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com
 [209.85.208.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AAC2B10F883
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Jun 2026 18:25:43 +0000 (UTC)
Received: by mail-ed1-f50.google.com with SMTP id
 4fb4d7f45d1cf-68acf0a15b3so6649151a12.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 08 Jun 2026 11:25:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780943142; cv=none;
 d=google.com; s=arc-20240605;
 b=N3Oi8VKjj7TMzMIVqlflGQrW3qjZWgnDXtJVFZ+bcja3FnH/DlA7mx2QsccLTuING6
 eunM06ByjEea0QTDP0zQnOFr4/0j76Hy2SV0bwSsb29UTe1mj9KJkEb8Gv71lG8maONN
 3kULG1Cfrc0PlNc1blka2Od0sFNaReN1/Ub8lULn+oMWXH6MErh8MtDxItwXBZORpPdN
 qHHUotdvqNb84J5ufG2EAAvfHdxhWGmvoWrDA73uVO1F7q0ytIUol3OAU5BaWZ7IY0bN
 ioiBOBMvST9bzcPi7Bhekj8s9IwDk3e/MCtwP7zucV46i/WKF3NUBOSWO0cX7VX4P+nu
 SAbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=bsRPENSdbfWpeWzjmLusfxbY/xjbYvZuSQQmkbsz4lc=;
 fh=KZY3QOO7P1hBPBPR3O4tht2l2C6s7AxiZ+AZlwqTHpQ=;
 b=P6Zm1RPxoAIC1fFWWLSDZcLC3h1SuQzp9g7rWRMw4TFupREdDhEsPPi1m1ur+a4ecA
 /51WB5PJob8yNladiCoivvnG8+WgfVgKMI+DX1+fge6HTjjBYONvZe6bZHq6zdaRaa3S
 G1ozvyfEJdzas61mYVH2Z9bO22S4nk5ni6BCR9a73AWMvY60j3PlO0LZOH0XGnt9bE8i
 qu/Z2tjrHCywE5CP8qb2Hqj5D9/byUE7jIwf0HFMY7YKZz0KoFpgKTwtLPrz7q0O+dgr
 uo1tLYxITIdFQbG6PVHDfJ1mp9klZcdBovxCSBYBQTDXtRdOND1JFqniMefNPmA/cxgo
 lIPg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780943142; x=1781547942; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bsRPENSdbfWpeWzjmLusfxbY/xjbYvZuSQQmkbsz4lc=;
 b=pFxD7YIGKzt4rdDAJlJBuD0sPd3KziHZbU+pZzdFtLxTwiABOntgUqs1+/XUc4Uphn
 QpQYHLy+PVz44rMytIRSrU2x/RTO5Xj5XOu/xEmM/xu5pXxKJBrCq/PAch1+rSs+7HTg
 RWmHgzvXiBtUBTvlSWEQAPjXYsUFvXYnhIfmeC1J2RWSusX+XcinAkJglp9/9o+74Soe
 Yg/RF5Zz+b14ttDRn9P1sT6oJyhNNdytqgmBOWIgDfzNqEv4BRUcUQiQY5kANAZhJEkf
 34S5Cqr15U96oZEq8tVLzFXFXMtLdoPueT8v5iQo1D2N2IpNrwdGdKZFEV+J9D7zTgzE
 5LwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780943142; x=1781547942;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bsRPENSdbfWpeWzjmLusfxbY/xjbYvZuSQQmkbsz4lc=;
 b=NOiiZNB26+JN6yvvgl8omESYAUCJuMlLfFFd12ElbzpFfDPuNnW7R+K29B+GXXP+ZB
 uHv/RM3ttZQzmMwfwbGakOh4nin5ilYWqXjDocXPZxATbygjz95NPHkUpR0U/dS6zDMk
 8Wu/nGsjDIWR+hlUiHZztZ9tVabd2uqEWhHm3L3wblXuNyPlNPHrztcmeJOYG2/eJJ96
 C9hapHpKmhvg9LAvmhn5iSrFUXZRTwedwMckO3WMSwYBub8OKg1El4nIb3mm70ZhsADv
 jHE5i2AnnXW8A0LIvG3S35VRnbvm6Zgq6XamB2XxmrEPcXIK8bTsJSxlApfP9LPollWk
 hC1w==
X-Forwarded-Encrypted: i=1;
 AFNElJ9gCu+50npRnUfNtbZGhcTqMqSFKoPOYqA5hEGHfOITSPW9GpPX3N3nPOxUas1x3uZSQIhIOPP5@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxsfeqex/qH41vQU8D3KTkz1XtAHXLIz+MxGRtgRJMER3/evLX6
 QbqvyBjjTARQwIVHoGh1EmF9zy01sDM3XWWsj+x6YXiqvYJQeDyoqh8kPo1GyWRVpIRcvtmEu7e
 pMHRxjIXyAlpm8fr+Frt5gjDFgFzuKeo=
X-Gm-Gg: Acq92OHHQptVlf4ugBrKlkW7NTdrzPNkXLmWpPvLI8Gf2/0Ztr1GPwP5KEViGuUGcji
 4jYBuA2viWg4PS6fz6txUALJTCr5uFAJMl2U8EqFlBRBSj1cBu7WKEeJfQkFYWkhqQDeErPK6NM
 33Pnt+6X1mf+Jtmu/hiMyAfE3iSXipysMBV9gQoxp4OxJ1O/r8O7jkHVIUWDg4dMR5JsmIL0O0F
 MSRhv6GBMEXyW+j3hvXRbABZcC703F7O7cQxByoYEc+O3XgxFurHV0kUtTdeW+Zrg08C5jrtQh1
 ItAEskso/yL4DZwrow==
X-Received: by 2002:a05:6402:27cd:b0:691:affa:38da with SMTP id
 4fb4d7f45d1cf-691affa3b75mr3213281a12.1.1780943141898; Mon, 08 Jun 2026
 11:25:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260526210048.1162477-1-edson.drosdeck@gmail.com>
 <4ebe7f6b-aa32-4441-84db-1b09cc69c075@amd.com>
 <CAMSsBRw16QVwXCWWq0aeoKcqe9soBF9x_un6fGj5A4P+iVCv-Q@mail.gmail.com>
 <d4cfb50b-3b70-4393-9d95-04566767c778@amd.com>
In-Reply-To: <d4cfb50b-3b70-4393-9d95-04566767c778@amd.com>
From: edson drosdeck <edson.drosdeck@gmail.com>
Date: Mon, 8 Jun 2026 15:25:30 -0300
X-Gm-Features: AVVi8CfXclb6j0YdrCqCKvFp-PCdAED1IRl-uc6SCc1u1i6sh-ACyg87M_5t90I
Message-ID: <CAMSsBRxR9Ar6p0qyutfMcCmJb7yLUNwE-CRh1JHKa-PZHHzRTg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Avoid using zero AC/DC brightness levels
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: harry.wentland@amd.com, sunpeng.li@amd.com, siqueira@igalia.com, 
 alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com, 
 simona@ffwll.ch, alex.hung@amd.com, Wayne.Lin@amd.com, 
 timur.kristof@gmail.com, superm1@kernel.org, aurabindo.pillai@amd.com, 
 ivan.lipski@amd.com, chen-yu.chen@amd.com, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Tue, 09 Jun 2026 07:16:41 +0000
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

Thanks for looking into this.

I tested the proposed change and it fixes the issue on my system. With
this patch applied,
the initial brightness level is set correctly during boot instead of
starting at the minimum level.


Em qua., 3 de jun. de 2026 =C3=A0s 16:23, Mario Limonciello
<mario.limonciello@amd.com> escreveu:
>
>
>
> On 5/29/26 14:13, edson drosdeck wrote:
> > Hi,
> >
> > Please find attached the requested ACPI dump and EDID files:
> >
> > acpidump.txt
> > edid.txt
> >
> > Thanks for taking a look.
>
> Sorry for my delay.  I looked through your acpidump and you don't have
> an ATIF method (which would indicate preferred brightness values for AC
> and DC).
>
> I had expected this case is handled by
> amdgpu_dm_update_backlight_caps(), but it appears that only sets min/max
> not ac/dc default levels.
>
> Can you see if this helps?
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 832223c06b3f5..e2831bf48eaab 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -5213,6 +5213,8 @@ static void amdgpu_dm_update_backlight_caps(struct
> amdgpu_display_manager *dm,
>          if (!caps->caps_valid) {
>                  caps->min_input_signal =3D AMDGPU_DM_DEFAULT_MIN_BACKLIG=
HT;
>                  caps->max_input_signal =3D AMDGPU_DM_DEFAULT_MAX_BACKLIG=
HT;
> +               caps->ac_level =3D 50;
> +               caps->dc_level =3D 50;
>                  caps->caps_valid =3D true;
>          }
>   #else
>
>
