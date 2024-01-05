Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56238C3DA6E
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Jan 2024 14:11:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3D1A10E61B;
	Fri,  5 Jan 2024 14:11:05 +0000 (UTC)
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1307D10E61B
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Jan 2024 14:11:05 +0000 (UTC)
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-204301f2934so858716fac.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 05 Jan 2024 06:11:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704463864; x=1705068664; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hBKl/439vNd9Do+6XEv+AItyGxRDsZgIsmGcpoFZX3s=;
 b=W+zMqwFerZ8TQYulH/K3Bgbc862THJedkXLvdterpD8YKhV52EM0YPTXR6HsRrx81A
 Q+hnjJ8PKHsvTuCXeN02hevpW0KAGU52eLb3tujyxZzot5ph3vzrRhFTQoAG+NxJnKfm
 rUZs6SBOTDPRyGnkPJY9nOPM+l96IypueiRg45+oSY0uqAUkL3Oj93+odrJNHb24khgm
 zYsDhiixgiTmgqKQTybNf1ctKaopJvjRqTQwnkG8jX58qJZY8HxZzmIAcqnHxl9I+LWn
 h3waEDzOflvOteYQTzFDCm/G8HzA8hTl4D7zgQmVdXJk4Na6riOtP5Qf0LHvZJ1K3lve
 +T9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704463864; x=1705068664;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hBKl/439vNd9Do+6XEv+AItyGxRDsZgIsmGcpoFZX3s=;
 b=Lu23J7ur1Qq8xMtsRGHEPLNwBhswbAfhJqc+XP4lbz5Qvfo9zWFJjuqG0Ujl6vi36s
 j2JkvMIj+2h0x0C6xCP6BPfGkzzkTOYOQas6e5l6X6mhhtQq7eUeHUyb1BOT/EBbmBS0
 K0/aXV7Kt42Z9os+u8Hf5iraO+AMqWrl0dX/77cdyGpGdFXdHrOW69+YMpwK9PnziPXI
 JK3PaolpJn9GD0PEyWamGyqGaHewA/LePT2/6DuGoBQ9bKQKz50gSpUHUZgCPg0Z2Un4
 ON/jkewgWLDxdNZrJXTe49trLH3kZPhioO6TW6blmkfOrWfbupw+9tLT+131aQMi3VK/
 Xh2A==
X-Gm-Message-State: AOJu0YxvkvDrKJHmwAJn1lFWJ1QtzZHkRswt9ToU/yXsfz/n4J9Cp+X8
 SYeLz4nAvt58twCoOfCuNBmK4+Hjxwcui2shBWI=
X-Google-Smtp-Source: AGHT+IGNGh4NhSeAwh0Fmq3t9Cwr58KBs/20KAzD1+R3aNcjnw4zj3RTOJCPGjxNKoWXMXZlTXehM807oSihRsbfvZs=
X-Received: by 2002:a05:6870:a24e:b0:205:c427:da16 with SMTP id
 g14-20020a056870a24e00b00205c427da16mr2283775oai.101.1704463864221; Fri, 05
 Jan 2024 06:11:04 -0800 (PST)
MIME-Version: 1.0
References: <20240105104355.2773937-1-srinivasan.shanmugam@amd.com>
In-Reply-To: <20240105104355.2773937-1-srinivasan.shanmugam@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 5 Jan 2024 09:10:53 -0500
Message-ID: <CADnq5_Pg83Osve6yDsJ_V6bTzAeLiDRgZgG-D7R87_PRHqR8GA@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/powerplay: Fix kzalloc parameter
 'ATOM_Tonga_PPM_Table' in 'get_platform_power_management_table()'
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Eric Huang <JinHuiEric.Huang@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Fri, Jan 5, 2024 at 6:21=E2=80=AFAM Srinivasan Shanmugam
<srinivasan.shanmugam@amd.com> wrote:
>
> In struct phm_ppm_table *ptr allocation using kzalloc, an incorrect
> structure type is passed to sizeof() in kzalloc, larger structure types
> were used, thus using correct type 'struct phm_ppm_table' fixes the
> below:
>
> drivers/gpu/drm/amd/amdgpu/../pm/powerplay/hwmgr/process_pptables_v1_0.c:=
203 get_platform_power_management_table() warn: struct type mismatch 'phm_p=
pm_table vs _ATOM_Tonga_PPM_Table'
>
> Cc: Eric Huang <JinHuiEric.Huang@amd.com>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/pm/powerplay/hwmgr/process_pptables_v1_0.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/process_pptables_v1_0=
.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/process_pptables_v1_0.c
> index f2a55c1413f5..17882f8dfdd3 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/process_pptables_v1_0.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/process_pptables_v1_0.c
> @@ -200,7 +200,7 @@ static int get_platform_power_management_table(
>                 struct pp_hwmgr *hwmgr,
>                 ATOM_Tonga_PPM_Table *atom_ppm_table)
>  {
> -       struct phm_ppm_table *ptr =3D kzalloc(sizeof(ATOM_Tonga_PPM_Table=
), GFP_KERNEL);
> +       struct phm_ppm_table *ptr =3D kzalloc(sizeof(*ptr), GFP_KERNEL);
>         struct phm_ppt_v1_information *pp_table_information =3D
>                 (struct phm_ppt_v1_information *)(hwmgr->pptable);
>
> --
> 2.34.1
>
