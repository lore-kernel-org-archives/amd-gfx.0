Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E1E1EB64D9
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Jun 2023 13:53:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AADA810E10E;
	Thu, 29 Jun 2023 13:53:31 +0000 (UTC)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 14FD089089
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Jun 2023 13:53:29 +0000 (UTC)
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-6b74791c948so604241a34.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Jun 2023 06:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688046809; x=1690638809;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VFFy77mFWYUTHeAvsV4v8UzydEgkTXHO+bOz1fk0eOY=;
 b=Kxr7yIKrfc+5lhJCmuVPS8g8825WjgAjsw1droTmZnVUnfDGeL4nOqdsxm6k0nK5er
 1zhdq0WgTNw0X1s3fRsAkKMQnA1h1jUZzs+VWVq5XmkHgvBKVo6x4Y730iuG7sDqJknY
 rN7IXI2S8lKo+zzkYFNO1LxtJ2gqJ9goJ9YGmtRLLKQ5fh2edxrJ1/jH6LLY70BQ8Tyy
 8kNNojeIiBvV5LXRccUrla/8b75ZjWhl85jVVTxFQqjKekRYnB4CXeKqDn8GJe94FIlh
 LFsoKEcmfTWowkEsEZ9i31hTf5lUyBBIaq8RAequvFKfBzXA0N1G9crIKfmKKjpTeZw3
 KahA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688046809; x=1690638809;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VFFy77mFWYUTHeAvsV4v8UzydEgkTXHO+bOz1fk0eOY=;
 b=WgCl/ReiZv9Ku4/nx9aoNNVb3TNi57jDdNjQaW5XCt97B+wwLZCZkO6usWl/gIfBHX
 2cPRiT5HXYuOgVJIq7DreUji6q6/OGIl057QrnUSkjOB8DyyF7B0NgGTGcqipsKs7Um0
 pc8bO+tG4YdsvKBzeaROgDG9TD3v5ldFnqG4/Ej1lvCDlzZjeOWioWl8j9W9SRBoU0dZ
 GbnC5TNZ5APMQPQMx0mz+BMGA8VO3BzNh/3lLPR5ZXsLFeOOPDF1RiR49bk6IL1rR6EZ
 YQlO0Q66xDzcr7w2e6KtHdSoaGcvVeTOZmBdHyRlXc90v32kWhVgXH4lNvf4hBHXhUjJ
 tPTw==
X-Gm-Message-State: ABy/qLb620QH4WAv4jmMDU94prX969AJ7PPKPIAbyDswEGc/V2I3+q69
 je9OAyeog+tYVy7nnJDgvMGw4nYr2ggfkH+9NS4=
X-Google-Smtp-Source: APBJJlGwAJE7+TZkixT3eukn72wLfSC4OKAz5dLLUJVTQdYnGhSmEwSYGs/OPaUZMJm3SwejPuK2hmQqPhGZ3Qqc/Tg=
X-Received: by 2002:a05:6870:648d:b0:1b0:f38:90f6 with SMTP id
 cz13-20020a056870648d00b001b00f3890f6mr12705oab.7.1688046809142; Thu, 29 Jun
 2023 06:53:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230629044635.2266729-1-srinivasan.shanmugam@amd.com>
 <20230629044635.2266729-5-srinivasan.shanmugam@amd.com>
In-Reply-To: <20230629044635.2266729-5-srinivasan.shanmugam@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 29 Jun 2023 09:53:17 -0400
Message-ID: <CADnq5_MvZuEt_tAFZiggObrA3OJ1sXenm50su5VAjOLhWtQ1UQ@mail.gmail.com>
Subject: Re: [PATCH 4/6] drm/amd/display: Fix warning about msleep in
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
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On Thu, Jun 29, 2023 at 12:47=E2=80=AFAM Srinivasan Shanmugam
<srinivasan.shanmugam@amd.com> wrote:
>
> Fixes the following category of checkpatch warning:
>
> WARNING: msleep < 20ms can sleep for up to 20ms; see Documentation/timers=
/timers-howto.rst
> +               msleep(10);
>
> Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c b/=
drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> index c13b70629be6..a6be04ad387f 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_helpers.c
> @@ -643,7 +643,7 @@ static bool execute_synaptics_rc_command(struct drm_d=
p_aux *aux,
>                 if (rc_cmd =3D=3D cmd)
>                         // active is 0
>                         break;
> -               msleep(10);
> +               msleep(20);

This doesn't seem like the right fix.  The warning seems somewhat
bogus to begin with.  If the length really matters, I guess we should
use usleep_range(), but if not, I don't see any reason not to leave it
as is.  Sure, it might sleep longer, but it might not.  Better to have
the code stay as is since 10 was presumably the intended sleep time.

Alex


>         }
>
>         // read rc result
> --
> 2.25.1
>
