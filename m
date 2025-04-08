Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20B38C369A4
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Apr 2025 16:36:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B6AC610E709;
	Tue,  8 Apr 2025 16:36:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="A7Ryzj6m";
	dkim-atps=neutral
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com
 [209.85.215.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CBF9510E709
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Apr 2025 16:36:47 +0000 (UTC)
Received: by mail-pg1-f182.google.com with SMTP id
 41be03b00d2f7-ad55376c2c8so404511a12.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 08 Apr 2025 09:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744130207; x=1744735007; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4NqKMwyNRa0vhY7nkBg5FnzWC5pVep5jYeFVM/iCq9I=;
 b=A7Ryzj6mQzT30eFNAJCcgT+vtlWfuxyK9NnzJy5ZXGGZDTryIybgccZA+M9GnDfZs/
 7LL/DuIbPRikwcHKCqlWksHjfTr0PmXb5HQbAiS4IPXLd4Pj7feQoE9mycO2hlnlbBJG
 MHgMyAZWKq2FY1GDHZE/4mlT78WZUQxJLf4seIf9AmNPZeUAaU0b8X5cqZ3M51goAi1a
 EtY47x43NuDfXl20rb30Uoo5KAW4u3qYIG5glnd/5oVfg3q8PHov4MgjO6u2sS2cq4/d
 LmotO3AH7Zyc8iIO5LJik7KRSV2AuP63coDqadV9BI0/EWsR9KsU+IE4h8ZakTJSeTV7
 69jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744130207; x=1744735007;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4NqKMwyNRa0vhY7nkBg5FnzWC5pVep5jYeFVM/iCq9I=;
 b=tWowzQ0waNtv4wkuisCoOejAJFoEV3cJBJGevjP6qeQA6bXdkFijNgI4XxH0/clEFp
 DhnbLFz4tc+W5FaD+8ERfZQd8cp+daITk2dIGhjZEdxuTYJ3NG7DsbgcQ0TET2/PPe6e
 Jdj3u8w7AEY+t+NaxLDRYfmw/wzoWmOmt6Fes4rDwwjNq8dTnpgvWAF2GefJmoN8gjmJ
 1tZTXPE8v3TKTo2Vl9Se3rHKcHNoqSkScpU7I+I2bCOZ8aahluQsWapbjYoYw2EU9eTU
 yRdtrFFgmHDX4nFEJw0OOU7hcKENzP7sH6NFp9kEGBzEvI86se8OPcAilahcJZMgBmff
 EWaQ==
X-Gm-Message-State: AOJu0YyezM9pWgObrPAdoj2Yv4kD5AT/tJcQ2SkOT0gWxU/EKaRK689G
 clIDz2RfiVI+R2PTX8fzzlD1q/AKEy9nolN0dnks2VokJLhCxB39uzJdfd9s/PSyQt5Ra2tvpcE
 DnHFTpNXHBjiaa4OIEQfncDoKJbI=
X-Gm-Gg: ASbGncsCPu/lIiR5kywGq+ZOxPvPK0bgqSxysbwhl6UvqA23zzR7MA3AeoCKwQYS6T0
 /UjepC/pUHnE7lUGKrj+u9r05riNEo+RvZAkxPryih//GSppN1y7eneeHRjIzr3SrAGCaKpdRch
 4N4JLojWHEhhcHG2GfCLkOOqBJbQ==
X-Google-Smtp-Source: AGHT+IHAgWpfgDqFmfbcldHTGfgggnr76dPGXyk34pkyBKSCHY8DTrhvGzkMfLHRBi7yWPd7EXzIyOSVswBI4jcgHSY=
X-Received: by 2002:a17:902:cecf:b0:224:88c:9255 with SMTP id
 d9443c01a7336-22a8a04bfd0mr94129565ad.3.1744130207065; Tue, 08 Apr 2025
 09:36:47 -0700 (PDT)
MIME-Version: 1.0
References: <20250328115219.1763423-1-Prike.Liang@amd.com>
In-Reply-To: <20250328115219.1763423-1-Prike.Liang@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 8 Apr 2025 12:36:34 -0400
X-Gm-Features: ATxdqUGxvcDrrmyhrou-p9cq1p9P6ZWCyFp6t9N49vEQwJ1bgxK2-aSRoZWff_U
Message-ID: <CADnq5_PYJrueyk_-Ecpuu++CgicJ-QtNjR+mJt=ZjUC_Q88Hqw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: remove the duplicated mes queue active state
 setting
To: Prike Liang <Prike.Liang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com
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

On Fri, Mar 28, 2025 at 7:52=E2=80=AFAM Prike Liang <Prike.Liang@amd.com> w=
rote:
>
> The MES queue deactivation and active status are already set in
> mes_userq_unmap|map(), so the caller needn't set the queue_active
> bit again.
>
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>

Acked-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm=
/amd/amdgpu/mes_userqueue.c
> index b469b800119f..b9705cbec74d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> @@ -358,10 +358,8 @@ mes_userq_mqd_destroy(struct amdgpu_userq_mgr *uq_mg=
r,
>  static int mes_userq_suspend(struct amdgpu_userq_mgr *uq_mgr,
>                                    struct amdgpu_usermode_queue *queue)
>  {
> -       if (queue->queue_active) {
> +       if (queue->queue_active)
>                 mes_userq_unmap(uq_mgr, queue);
> -               queue->queue_active =3D false;
> -       }
>
>         return 0;
>  }
> @@ -379,8 +377,6 @@ static int mes_userq_resume(struct amdgpu_userq_mgr *=
uq_mgr,
>                 DRM_ERROR("Failed to resume queue\n");
>                 return ret;
>         }
> -
> -       queue->queue_active =3D true;
>         return 0;
>  }
>
> --
> 2.34.1
>
