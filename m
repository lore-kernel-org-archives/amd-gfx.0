Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08D2606A31C
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Nov 2026 17:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PYKl5tOU
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CEEE10FD01;
	Wed, 11 Nov 2026 17:19:38 +0000 (UTC)
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com
 [74.125.82.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CA95E10E431
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 17:19:32 +0000 (UTC)
Received: by mail-dy1-f182.google.com with SMTP id
 5a478bee46e88-376a4059061so92156eec.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Nov 2026 09:19:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794417572; cv=none;
 d=google.com; s=arc-20260327;
 b=gDjwQ6V7sG4GN+Njsf3rhSIV86eK5fmFCBWKln/JyqhcWVYh2iYY6suK/VNScrOxm9
 0YnauUNtigkGSPcVFGIC5g3vnF8OCr2UzK53qJFcwy1Veeibu/hLBQ1MPaULd9MPi4Mr
 vk7VzuVLoxMqTW02FRTGotK4mzHIxhqxNIEehr/9nt1uiJFSqQt/3O4B5aQK3FxF8LFt
 P6vtgFWRhOZN2Mv9Jf9nghNDVGKnd+UP1ceZ985j5s5E+/MHjHxW1V/JEMXkLAAkTxsu
 SFnnWoM6MO+HHeWFKw2HXZfzTwwu/zUmJPf4NHB/dc/Ms4/3WGufsDhZQbwrOckrgR23
 WxDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=KrAwE14sLjPV1wagWRb3nhUSBxA8ruoUwCfDea/0XLY=;
 fh=LILuGwAQevK6+EUT0j7Bg6PbYODygoeRpyTPOFQg4No=;
 b=IY62rHlpa7JzpScOj9hZjJLMw/E5ALgzk8Xxjmw2rFLni++RTUblsulQa0Rx82thtW
 uiN61VYW2YMN6MQJOCbW5hyoipX8Fw43bvad0SlybKBemo+rfWjlfs6BqEGWxif7k6qB
 OdlRl1XcWvPQD556Aw0lqgqUfKYX+wXPwqdp8pGBU3atk3EFZLWRAt7qmmrXVvhpgLP2
 XesYikWHwmzxE7twDYC4JgwpcmgkhCmPl01Hi6cnOoWYiSJJ739Z6+dNoanv4WM0lfNo
 b0jYpybgkCUJgs8TSTVcsUeLvEqrvJHQ9et/Y0IdENtysxOEaa6wObk4M+Lb1r7K4dOs
 xfWg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794417572; x=1795022372; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=KrAwE14sLjPV1wagWRb3nhUSBxA8ruoUwCfDea/0XLY=;
 b=PYKl5tOUE0BJabRDqvQv2Y/QIsGMiiIVqFIBOMdnnnrwqUaY03dHtP3ELPpzxDFI3i
 Pt0m6LMz+PJui5rXv3m6W1iYHm8b+bGp4AdXwJrl2Af0uR2DV8FrZ10P/Gsen0vQA3io
 ABc3/3xqHlE16commgyN2I3q7T1/r7ApluMEMuABwGJb66nDK1QSxH8zlp/lFUGz1mRn
 LS0gTMa4tCM5v0jFdJ021M3BkHCOoRfAlU9h6IQWAKetVkxRd96p8dzb1xB/vK+ab41z
 t0RJrP1g3nVRD5E8cVYTFgoqsExF/lv9pVTgryfckLMXN5aF/PDZ2jE3efrMUYWOYfQq
 NIBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794417572; x=1795022372;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KrAwE14sLjPV1wagWRb3nhUSBxA8ruoUwCfDea/0XLY=;
 b=ynQMjkU9clJ30U/Y1Y1etl4kem3FZq6Jqt34gEgtCH6CE5AaVhZ5ANv9bgwRrwMtYp
 xgtD5swGGSDtIhw7tZCTWvleS/E4go1lNlP8AtixDY+whOVl8ZhvWDdpR0fvlprTPEu4
 TJMHl88DvWiu8UAKcXgwCBa+rjtTT/64A0+4qoJEeto+GZg8M+gRADa21eexd4WiiWUg
 Tv/A4UokzqUFZULdrXWJtjol2gFojahZaNPkpF7a5MLMSg2FP7NMNmrXhSsAMM/hak9f
 L0Yf0EcahRvWGeee+BFdvpmF/TYtzoJ1ghzLk2VRTBqE4pVqYZ83iOqLYZ18nUI2oHee
 EQqw==
X-Forwarded-Encrypted: i=1;
 AL+hErGeBjjqas9W7i75GMfWsD40RmT5gDMWGO24fAsUtMXCUxonGmI2B1kouC9r9rkg6i143merY+tK@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/qEx8m4JVUw8qVwcK8FR0y/p/0lId1pHuqtmZpyktAGrlt2584
 sXWqG8WSjz34NTzGssYrIC0fyc46dEyJ48XxzZNW+35Ciwm9jbv58s8la6b+UD9GXJOOe3929hU
 IonXPTaTYaD57k6qu9KK7DVdC0fSx2hE=
X-Gm-Gg: AYBFou0eFsZw4Fot9OHP7zQ2531wS6Vr65olFVr2NnvjIcYT2rpvdF96q5db75QyDLa
 n512t+gWZYrq5G7x039jL0wDMGH+AC3VlluIAFag1jihLSuuOCZz5vZYXcl/47uVjVbkVf9hIsH
 Fa2VSkU9eThFlXctFR6It4RRiS0G5QGWbXTxMK0eKk6u+L1zZep0rKoMYiZsfnQcPRuYPUMFRQ/
 JgRrYMn3i/m0vwy9ue3W/uOmy0iH0yDQgdXmcvY8Q/vwcskfEcNXgVyKrD3/QEV7Mn0pa6IFFFw
 E0FkiiFfaS5lxbsR+/DJXLEd3f4Y2UrJvW+/CGw0QWFW7gcKynqlE6G9JiPSH58IEAP/80GmGso
 tHpjP63q347fkE4FRxMVRHYQ/ZKfUEbR9lLFJ/rRjIZ6q6n5g7lvhVt7tTNEp2Cuh+fjdN+DBVh
 hA6j+MfpsOqir6KKE9q8H54IOepQlxn8SiKVYPljEKyMbqdsucWKUI4IlRI2s=
X-Received: by 2002:a05:7022:3a86:b0:143:5c2a:e45f with SMTP id
 a92af1059eb24-1b3c01600d4mr4568870c88.0.1794417571814; Wed, 11 Nov 2026
 09:19:31 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261110215334.947250-1-colin.i.king@gmail.com>
In-Reply-To: <20261110215334.947250-1-colin.i.king@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 11 Nov 2026 12:19:19 -0500
X-Gm-Features: AclHuK9Ltzz1VkoOh3Aq7MLGRPgESiTW_dVehgDaxaFmKVDwtYC6QW68oRx-BvE
Message-ID: <CADnq5_PSk1mPj0t24ZjQfR5STAnVFvsB9wz-K6PqHjeWzoTS-Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: remove extra trailing semicolon from a
 couple of statements
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Austin Zheng <austin.zheng@amd.com>, Jun Lei <jun.lei@amd.com>, 
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Dillon Varone <Dillon.Varone@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, 
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Reviewed and applied.  Thanks!

On Tue, Nov 10, 2026 at 5:11=E2=80=AFPM Colin Ian King <colin.i.king@gmail.=
com> wrote:
>
> There are a couple of statements that are terminated with ;; - fix this
> by removing the extra redundant semicolon.
>
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  .../dml21/src/dml2_core/dml2_core_dcn6_funcs_mode_support.c   | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dm=
l2_core_dcn6_funcs_mode_support.c b/drivers/gpu/drm/amd/display/dc/dml2_0/d=
ml21/src/dml2_core/dml2_core_dcn6_funcs_mode_support.c
> index 71d14fb8c830..5dd22003f165 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core=
_dcn6_funcs_mode_support.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core=
_dcn6_funcs_mode_support.c
> @@ -328,7 +328,7 @@ void dcn6_ms_calculate_writeback_bandwidth(
>                 }
>         }
>
> -       DML_LOG_DEBUG_2D_ARRAY_DOUBLE(outputs->WriteBandwidth, display_cf=
g->num_planes, DML2_MAX_WRITEBACK);;
> +       DML_LOG_DEBUG_2D_ARRAY_DOUBLE(outputs->WriteBandwidth, display_cf=
g->num_planes, DML2_MAX_WRITEBACK);
>         DML_LOG_FUNC_EXIT();
>  }
>
> @@ -4255,7 +4255,7 @@ enum dml2_status dml2_core_dcn6_funcs_validate_solu=
tion(struct dml2_core_instanc
>         enum dml2_status status =3D DML2_STATUS_OK;
>         struct dml2_core_calculate_ms_context *calc_ms_ctx =3D &core->scr=
atch.mode_support_locals.calc_ms_ctx;
>         struct dml2_calculate_mcache_allocation_in_out *calc_mcache_alloc=
ation_params =3D
> -                       &core->scratch.mode_support_locals.calc_mcache_al=
location_params;;
> +                       &core->scratch.mode_support_locals.calc_mcache_al=
location_params;
>         struct dml2_core_internal_display_mode_lib *mode_lib =3D &core->c=
lean_me_up.mode_lib;
>         unsigned int i;
>
> --
> 2.55.0
>
