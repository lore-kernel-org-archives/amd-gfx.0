Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDFA3C27C5F
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Jun 2024 16:37:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 79FAD10E233;
	Thu,  6 Jun 2024 16:37:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dc0/Enbv";
	dkim-atps=neutral
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com
 [209.85.214.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF26610E233
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Jun 2024 16:37:10 +0000 (UTC)
Received: by mail-pl1-f171.google.com with SMTP id
 d9443c01a7336-1f6342c5fa8so11678805ad.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 06 Jun 2024 09:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717691830; x=1718296630; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W1rTEgW292w/9jdgOkTr0gT8bnB3WllQ2ZQGP9f+TH4=;
 b=dc0/EnbvBklzTZA/s/iox3JxMHl423pEbGpLv0Vk3GxBUkYZy1x0DDbKKtNCZzHsck
 8TenUspyxiDIi9ZkukVrYkAV8iG6OTBiWkBdqp0sGStYi56aPqwZ9oXsLjsoC0Mv+tev
 6dIhsZkZehkERBDn4xifezdN8t+qobB7nE1DGpSup9/iObarbky67iNjc1bo1gmw9sC7
 h0a5itZC20qf6TGAUE3AXJd5V3Nw3rXkI5Dn20SlxSR8SpDXbNey53dwU26YjwUK4KJu
 bEPITU50UqriERelpxWuSVYF6aqy1dqWmj+bohqILThD0TX8sdDorSOfSc0sUjshJ9T4
 ojWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717691830; x=1718296630;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W1rTEgW292w/9jdgOkTr0gT8bnB3WllQ2ZQGP9f+TH4=;
 b=w1a6LI5m6nuJb5PC4LhM1yUKkfGlCiGka4g8lo6L2fCdoTAAMP8Ab4+0+IjviX60qJ
 rLyK+Wx3wOQTkEbyxvroMdxYPraReMi3QinqNvkVDdUQPwuF49PjOZujmSWEQAwebZze
 MbvKdVAGACZuayqPTZBTkzoEP4zeA54jhOnCTSn6RJBwFngWxqFRu2KgAbwXQ7JEt0Nn
 ZMowI1lVsXkJrJuzb9INR/TL/Xy1ChYTtpYkL0mCorZ8xx0b4rC32lKsGAV52/GCxawp
 wsxB/ma0ZFpinR9H5qdH9HHW60ILY+GdrPCv3GTTAr3G3HyDo96mxarc0OBz7vetAR0M
 /Rng==
X-Gm-Message-State: AOJu0Yz5GWrPX9uNQoslcMoDpgkRieiXJoGP9T1q8namFOXpL3cMwbyH
 SqASmkJw9e6ch6aOJdxVthxd00Kr/BMfL5Scik62tUR1zhyaOSaAZECUwQf8N8pYqFS/x58K+/r
 mT2mqgZwagj0wwInwquue5tqdZI4ldw==
X-Google-Smtp-Source: AGHT+IGiPt3O9HyZuQ4uG1FCTIpcefIJAQSCl7Cl3YNq0U6ksfwZEZWNO2bjAUIQBxyrZsAmJOVGYjB7XftkNvk2k+o=
X-Received: by 2002:a17:902:d506:b0:1f4:a026:4888 with SMTP id
 d9443c01a7336-1f6d02e65d2mr1686055ad.21.1717691829959; Thu, 06 Jun 2024
 09:37:09 -0700 (PDT)
MIME-Version: 1.0
References: <20240606154300.100140-1-jinhuieric.huang@amd.com>
In-Reply-To: <20240606154300.100140-1-jinhuieric.huang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Thu, 6 Jun 2024 12:36:57 -0400
Message-ID: <CADnq5_Nkf7Jm5QfLwwnv99XNuWZq3RMABMd54xd48qWJGSEjvA@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: fix NULL pointer in amdgpu_reset_get_desc
To: Eric Huang <jinhuieric.huang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Lijo.Lazar@amd.com
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

On Thu, Jun 6, 2024 at 11:52=E2=80=AFAM Eric Huang <jinhuieric.huang@amd.co=
m> wrote:
>
> amdgpu_job_ring may return NULL, which causes kernel NULL
> pointer error, using another way to print ring name instead
> of ring->name.
>
> Suggested-by: Lijo Lazar <Lijo.Lazar@amd.com>
> Signed-off-by: Eric Huang <jinhuieric.huang@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_reset.c
> index 9deb41d61e8d..66c1a868c0e1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_reset.c
> @@ -164,16 +164,14 @@ void amdgpu_device_unlock_reset_domain(struct amdgp=
u_reset_domain *reset_domain)
>  void amdgpu_reset_get_desc(struct amdgpu_reset_context *rst_ctxt, char *=
buf,
>                            size_t len)
>  {
> -       struct amdgpu_ring *ring;
> -
>         if (!buf || !len)
>                 return;
>
>         switch (rst_ctxt->src) {
>         case AMDGPU_RESET_SRC_JOB:
>                 if (rst_ctxt->job) {
> -                       ring =3D amdgpu_job_ring(rst_ctxt->job);
> -                       snprintf(buf, len, "job hang on ring:%s", ring->n=
ame);
> +                       snprintf(buf, len, "job hang on ring:%s",
> +                                rst_ctxt->job->base.sched->name);
>                 } else {
>                         strscpy(buf, "job hang", len);
>                 }
> --
> 2.34.1
>
