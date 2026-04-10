Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D753AF44873
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Apr 2026 14:14:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B5D910E965;
	Fri, 10 Apr 2026 14:14:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mCVpz0PH";
	dkim-atps=neutral
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0347510E968
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Apr 2026 14:14:23 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4888375f735so20570335e9.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Apr 2026 07:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775830462; x=1776435262; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9EukcYSmpBUld9Ge/JlVPoPxylRKBCE5eGSP4FbNDB8=;
 b=mCVpz0PH+Lph1Xbn+moQe3G4WQH2g+3sJUhFWj71rqI0fzWnJBv/FfzC64dU9W9+Z4
 PuZ3rmJs8HdgLxfOsOPYg5q+fJbtrfg5/JOoPjCbqhwpP7H7RbowcnUQ+8kKjsHs10ZL
 +jpt4cRsf+Lz6Ov3CK02XytC8uMvJRgbJ2jpSeVRmotKlQ4mqxACWvz06wBNLUNe4Ys1
 Ui1lcj4v2l/MF2MKXXDqDkyHqq/QaWypYkQM3WFz4PQXrErSOzYyePV/74kY1lEuyzsd
 ZTf2Q2hVS4lL5p1AopfpDxBPtwFx3mjBsM6GtyLuEvRSAacQUZeq4zEZdQyzNpbw3knu
 XlHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775830462; x=1776435262;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9EukcYSmpBUld9Ge/JlVPoPxylRKBCE5eGSP4FbNDB8=;
 b=ArH4SwVFW9H1ke3+i4Cp/NhaAHvk0b4QW8xjfLVyVwnN7zebCucvty6JWn7r6puhA6
 AX3NFAfjNeqDKB83DdGGMpmy8NIINlFevLVWG8mlasuJ20YxjEjPer/b774qD54mrgHo
 G0kPueDS2zbC0V/KTcfFfBLlbAEbfsRRFqfK18oV7/A1f1hvgCf5gVaYH1nRD/XfhAVR
 0GbljeImqO5wben3G4jJ5mZ8Mxn8tGjIBZKegL2cKGLpk+7TdjfU2mT+sF2DkKmcJPgY
 BswMN7UNmnlercE6jiVG0JchXwCtq5pVRpR99pZK76b372sryQCoFyg3ADZBZfzoFsWu
 J3wg==
X-Gm-Message-State: AOJu0YwkuEbgPeb4fRDUllIwn1prvJ5nR2mZBKX87Sgn87wg1Qd5OR8V
 uhUrkfOvTqc1Gc0vMgI13xCthYU/JPfZLeBuxxtfCvWQ+ale40T7M5sQ
X-Gm-Gg: AeBDievT/0YqQVN9H384CVU+zOatUVg7MR3Xdhx7UrfrEbkGWO1hdzhAucYVUNc+W2J
 jduUiu570eC3hH1SOQtnW2R+vISfZZy9q5aBzr+gkdkY47KhVXhA3oYOJmuWewGN0Vpp9zJuC2Q
 5d+KSGk4cR7bmTIV6kgSeIWByP5YStJnVt8eCYe60FvEpZQsPfKelFGzq0ethgfTPGacfRzh4QI
 f9c13Ofkcu58X8xCmMdN7xFAToOGyY1KTpp/zCyZy5uKhoAezF0vRnCV5vs7umR0vZCiePw02qR
 NJgDG82fzUvxrsfdTMVAcotZUZNVoK92JWABX4hOxK2f6+MhFu5A4QrhZqozukk34Ptfbx8T64k
 X3kSQZoAeKAFa7djvmb0ZsMRxjobaVpGXiZOgTePd6+IReSxdnykv6G91Atam1Lv08yMKT7qFDK
 FZ7aPq0ZMpY4oew76hrsH+cjHjDwlpNux10Lll8eHbhkV5TQfTfvQ9bXTLZaHPu6nmu7DofQ0=
X-Received: by 2002:a05:600c:3149:b0:488:ae4e:519c with SMTP id
 5b1f17b1804b1-488d683d505mr40902675e9.18.1775830462258; 
 Fri, 10 Apr 2026 07:14:22 -0700 (PDT)
Received: from timur-hyperion.localnet (5401D3D3.dsl.pool.telekom.hu.
 [84.1.211.211]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488d531f229sm104957935e9.3.2026.04.10.07.14.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Apr 2026 07:14:21 -0700 (PDT)
From: Timur =?UTF-8?B?S3Jpc3TDs2Y=?= <timur.kristof@gmail.com>
To: Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Cc: amd-gfx@lists.freedesktop.org,
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Dan Carpenter <error27@gmail.com>
Subject: Re: [PATCH] drm/amd/pm: smu7: Remove stale error check in
 smu7_hwmgr_backend_init
Date: Fri, 10 Apr 2026 16:14:20 +0200
Message-ID: <2213119.9o76ZdvQCi@timur-hyperion>
In-Reply-To: <20260410124006.2293461-1-srinivasan.shanmugam@amd.com>
References: <20260410124006.2293461-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
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

On Friday, April 10, 2026 2:40:06=E2=80=AFPM Central European Summer Time S=
rinivasan=20
Shanmugam wrote:
> smu7_hwmgr_backend_init() is responsible for initializing the SMU7 power
> management backend. It allocates and sets up the backend structure,
> initializes voltage tables, configures dependency tables, and prepares
> platform-specific power and clock parameters.
>=20
> The function follows a typical pattern where each initialization step
> returns a status in "result", and failures are handled via a common
> "goto fail" path that performs cleanup.
>=20
> Commit 2c21648bb814 ("drm/amd/pm/smu7: Remove non-functional SMU7
> voltage dependency on DAL") removed a function call in this
> initialization sequence, but left behind the corresponding error check.
>=20
> As a result, "result" is checked twice without being updated in between:
>=20
>     result =3D smu7_init_voltage_dependency_on_display_clock_table(hwmgr);
>     if (result)
>         goto fail;
>=20
>     ...
>=20
>     if (result)
>         goto fail;
>=20
> The second check is redundant and unreachable for any new failure, since
> no operation modifies "result" between the two checks. This triggers a
> Smatch warning about a duplicate zero check and reduces code clarity.
>=20
> Remove the stale error check to keep the control flow correct and
> readable.
>=20
> Fixes: 2c21648bb814 ("drm/amd/pm/smu7: Remove non-functional SMU7 voltage
> dependency on DAL") Reported-by: Dan Carpenter <error27@gmail.com>
> Cc: Timur Krist=C3=B3f <timur.kristof@gmail.com>
> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

This makes good sense. Thank you for fixing this.

Reviewed-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>


> ---
>  drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c | 3 ---
>  1 file changed, 3 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
> b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c index
> 1381902547b8..4436ab2bb51f 100644
> --- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
> +++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu7_hwmgr.c
> @@ -3062,9 +3062,6 @@ static int smu7_hwmgr_backend_init(struct pp_hwmgr
> *hwmgr) smu7_set_private_data_based_on_pptable_v0(hwmgr);
>  	}
>=20
> -	if (result)
> -		goto fail;
> -
>  	data->is_tlu_enabled =3D false;
>=20
>  	hwmgr->platform_descriptor.hardwareActivityPerformanceLevels =3D




