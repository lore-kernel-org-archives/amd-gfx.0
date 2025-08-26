Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79966CA0FE7
	for <amd-gfx@archiver.kernel.org>; Tue, 26 Aug 2025 16:29:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FB5B10E114;
	Tue, 26 Aug 2025 16:29:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kr2PQ+xq";
	dkim-atps=neutral
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com
 [209.85.214.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B1FC910E114
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Aug 2025 16:29:39 +0000 (UTC)
Received: by mail-pl1-f180.google.com with SMTP id
 d9443c01a7336-2488be81066so417625ad.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 Aug 2025 09:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756225779; x=1756830579; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FBA9I+WtydPLfnTz1pTxEc/bS3G0j/+D5hlHVusJfZo=;
 b=kr2PQ+xq5qw4u8Y56+lnBS8gdyJ854lCEiVGLWjyTgGDHweByeA68hXma8tbGHem1M
 ECUi9QjzMlNMu1vqW+3WQEjgCnTbD56AjypGpoG5uAZNqqaP96HELzK0mGm0kUWSIPL1
 oMtjpNTYTJxpCRkDECGtY4a47foXN2oEO9CrWejfQHgs4LiWvKZcDcwmxKxtg+FZPt5F
 CquacIj8RmzDrGDmdXD/MFmNrYOVQ8xOVW/yUz7o3HmoUpk/ilntaC29ZITTbCiIkzjh
 Krr4HlVgud6Km5bpah9mvqiqutprADmv4LWblRD5sDa98VLx9fEKluM1jzUo7CFJMADn
 w4MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756225779; x=1756830579;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FBA9I+WtydPLfnTz1pTxEc/bS3G0j/+D5hlHVusJfZo=;
 b=m8vBHNdUUo0hGUYuQrs2wQMudcjFCsHfKcTsFjoUCQAYgsNGwV5Hp4GffDSo7izOVl
 sLuc2FxcG56SgwW8aHAKzlgFZGmvseQbLe7FEL1UOw8AmXxL99xe+6vZRUhAZF/jxRHv
 LGRfjgOYq5Os1SHd4VcO61dUQMhf7MdEqaCNBuKdW6kKUrk+28hkmaP1ACu0OPwLTpU/
 C60SP6KnRNKckNJOe0CT/3SmLMnOca+Zhnfk0MhbwSTSINChRRrryN4FmTSy826+xY4g
 amTYDQ03OiyWKpHEIvXB0L9P1tzF2oN1Sr6KU5ZTmezsHJg67nrKZZXYWeRnfelqd+Co
 TkOA==
X-Gm-Message-State: AOJu0YyxIdCJi962TBxnp5YfxLGyi2BvwIVls/lyFyMPtDd4X3Gp/L4d
 sgQjTqazcxq63Z76KThAJpUwL+EI6RsnOazF2j0bWWCEuXlQJ9fjdBXxco+URyH22tD+DfvMu/t
 iB+QRGG9F1wcK5Guy03yNwXZd1sL6MoeIgA==
X-Gm-Gg: ASbGnctIN3juFUHBL96s9qtAfEx8k4wSwtDiPREehUEVh1AUkT239zAJTD7NX5sbj0t
 3mqWotOiQmQW+oiGuygGU4EWCX3ELvzGzpGIiM7dl9fUxvroIBfssVpxR5xSl2YZ7NK9QzidDM+
 PaWDtR/MUiJmt0zvciKLIB3ldhzDkuLmPny6YWvytNyrRWw5+BIk7KCmqvKoFoZ+WsGra9VRttd
 H9i4D4VyroWrq2wxg==
X-Google-Smtp-Source: AGHT+IEGotkuCZ/b1sZoPlKP07k6z1kzzors6iWG5Yt/kwI4XsDAX+hYVsGOvvpN1K1KFqEeLS7SS2Vv9fTFKxEtBOg=
X-Received: by 2002:a17:902:f60d:b0:248:847b:8906 with SMTP id
 d9443c01a7336-248847b8b62mr9773885ad.11.1756225779035; Tue, 26 Aug 2025
 09:29:39 -0700 (PDT)
MIME-Version: 1.0
References: <20250822161515.1089247-1-alexander.deucher@amd.com>
In-Reply-To: <20250822161515.1089247-1-alexander.deucher@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 26 Aug 2025 12:29:27 -0400
X-Gm-Features: Ac12FXzdaMhhOH5Mldwxq5XatfhrP7YPE4wn5l4HTrAAQuZUul4j2SsuepSUkRk
Message-ID: <CADnq5_OXrEs8uJVobzufB8E4tZjTDnx-vT6Crr_+4_=PX3Sq0Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu/userq: fix error handling of invalid doorbell
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

On Fri, Aug 22, 2025 at 12:33=E2=80=AFPM Alex Deucher <alexander.deucher@am=
d.com> wrote:
>
> If the doorbell is invalid, be sure to set the r to an error
> state so the function returns an error.
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_userq.c
> index 424831997cb1a..28242ec2215da 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -426,6 +426,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_=
amdgpu_userq *args)
>         if (index =3D=3D (uint64_t)-EINVAL) {
>                 drm_file_err(uq_mgr->file, "Failed to get doorbell for qu=
eue\n");
>                 kfree(queue);
> +               r =3D -EINVAL;
>                 goto unlock;
>         }
>
> --
> 2.50.1
>
