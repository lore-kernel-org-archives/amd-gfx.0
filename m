Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14940EB64DC
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Jun 2023 14:03:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B30810E3CC;
	Thu, 29 Jun 2023 14:03:28 +0000 (UTC)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EEE5510E3CC
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Jun 2023 14:03:26 +0000 (UTC)
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-3a37909a64eso294035b6e.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Jun 2023 07:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688047405; x=1690639405;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dkb9egEsW5KSI2wNqiVuF1mk4/C/9eEIIR0e6j0MX14=;
 b=AUPq9Ud/8W7LTrVSVebLEl7O+AY6SyHj7di7E9Veo+pgwBGk33xsBtf/+6VVCJaaR7
 C3xlGmBlSgQDGv0nPiiGAy/QSDdVC3sEf1CuVc/DbuQNnfXoZIKD26Wtf8p46W9NyXeD
 tpJqUNfOnjvrnZQ8neZ3vFL31opo0FYvaQsJAAvTQDchD/pNrdn03u04qtWekJzM8tJ/
 H4jFOli+xTYX5nupovCdSgk0OyxhtJKQs/5iUaGOru7EpnGR6arYRVX9NOuAFV6t0J3/
 dNhHm5CL8TmaoZaetBKJBBNoOopicdM8KKG+15RVsdRa5ypPOty1AD/iGqhjGG3zWM+i
 rnJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688047405; x=1690639405;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dkb9egEsW5KSI2wNqiVuF1mk4/C/9eEIIR0e6j0MX14=;
 b=UwQrECsOnlTc6ckVdTGhCdspojBz1S8mQyZmfR4LJsXtBzcO/c7bGQWOLzHUF8PDyn
 JGhspBHRULm52xYN8qqHG0McGkmIGWQgRz5mnXTzZqHgAHfKK77T6ww7l1Am4x2FfHP8
 kYAOaJVfmKgMwBCh+E+PzcC2M9xir4PlCScVZ7zHjzN02JjuNW/28ZHTey6N4nWB6mWx
 pHf/DzZHT9qBWn16PI1t0I8Zkh2yP+T/E9MEQg3GSsXFi9RJ09jZMUC6Qw/rCfWOkBqB
 jLPHa2kAgRsPSQLSq5AlTf8owjcTYKbli2I6ujR47jqQGAfouL8dITW5fw91w6Pn6hUH
 BUeQ==
X-Gm-Message-State: AC+VfDwX48n9AN2Espv8mX70AY40uEnuX9J+30qt2iMAC7/RxcTUJphD
 4CxVE8t+w99SFRg8h7m2xUHo6Zcp2TbCMd755hraf46t
X-Google-Smtp-Source: ACHHUZ7sxkus5M1BfRQL6hc4N3XVCgb2znbZJcSgqUchflEd12AsNsepgmY8ir4VndvJ5ssuwRYko5/H4RYMCMrweaI=
X-Received: by 2002:a05:6808:2a77:b0:3a3:6c7d:a5cc with SMTP id
 fu23-20020a0568082a7700b003a36c7da5ccmr3818510oib.24.1688047405563; Thu, 29
 Jun 2023 07:03:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230629044635.2266729-1-srinivasan.shanmugam@amd.com>
 <20230629044635.2266729-2-srinivasan.shanmugam@amd.com>
In-Reply-To: <20230629044635.2266729-2-srinivasan.shanmugam@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 29 Jun 2023 10:03:14 -0400
Message-ID: <CADnq5_OVAZUcx8O_wnM99PxitfT8kmszTDUhfBDSRM2dNBk2OQ@mail.gmail.com>
Subject: Re: [PATCH 1/6] drm/amd/display: Remove unnecessary casts in
 amdgpu_dm_helpers.c
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
Cc: Harry Wentland <harry.wentland@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

On Thu, Jun 29, 2023 at 12:47=E2=80=AFAM Srinivasan Shanmugam
<srinivasan.shanmugam@amd.com> wrote:
>
> Fixes the following category of checkpatch complaints:
>
> WARNING: unnecessary cast may hide bugs, see http://c-faq.com/malloc/mall=
ocnocast.html
> +               char *buf =3D (char *)kvcalloc(total, sizeof(char), GFP_K=
ERNEL);
>
> Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/=
drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> index d9a482908380..c13b70629be6 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> @@ -426,7 +426,7 @@ void dm_dtn_log_append_v(struct dc_context *ctx,
>         total =3D log_ctx->pos + n + 1;
>
>         if (total > log_ctx->size) {
> -               char *buf =3D (char *)kvcalloc(total, sizeof(char), GFP_K=
ERNEL);
> +               char *buf =3D kvcalloc(total, sizeof(char), GFP_KERNEL);
>
>                 if (buf) {
>                         memcpy(buf, log_ctx->buf, log_ctx->pos);
> --
> 2.25.1
>
