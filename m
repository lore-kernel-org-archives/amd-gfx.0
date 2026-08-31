Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03DC8C624A5
	for <amd-gfx@archiver.kernel.org>; Mon, 31 Aug 2026 14:31:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 705DC10E923;
	Mon, 31 Aug 2026 14:31:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Zm3amR0E";
	dkim-atps=neutral
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com
 [209.85.216.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE60D10E917
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 14:30:59 +0000 (UTC)
Received: by mail-pj1-f44.google.com with SMTP id
 98e67ed59e1d1-38eca09faa2so270972a91.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 31 Aug 2026 07:30:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788186659; cv=none;
 d=google.com; s=arc-20260327;
 b=RDPnpTD7d8TfQPG3czMK1DhYaFDtlL9DWEYjzTJq7K8zcqkpd/fP/0GxrYCzkYMzZM
 NUHfP1fxhzWyfn6NybKUQYS2yjTTzYkK27Bg2heBkbP6Fo/HLWUiYu4Ashi2uzd6hPZv
 6OopU+CjEl+AXmQnhgz4AgMyp04eW/E0bLAWyQyJNZfFRg6+SsY9E5TGot7YrumL9e5H
 ZdJlX1it93tGZhN8gBRXzZ5oxwAq140UKUiO0j9LqRkXpZ+wPgAjROZWisBtA8LTyuHK
 zZ8IHZie9o6ToM8d7VRmpmSamBICpWhU7VwxAJyiNVhrIAGSOqF8jbovuzzXHMXSWupE
 qCXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=jwAByLoPLqoocjzFPyzsZC+xzGC/eZSiR4GVkvk53t8=;
 fh=/jXuF6kkEzGc76I89MWDwYajZhHhstOH8SMMdzCQivY=;
 b=g2q/PkAnqW6LMgcTc22MrVEoM1U0HzbX3xMirWj20y72dpfLUX5AwVaNkIDZJeshkD
 O/oYW7rk3Qes0q18aSRjccDhUC+01EOthkv0Me1OTNPaRmgu2GOssxQypnMXXHXegtf5
 FEVqGdhxAzs+/SlNRPs0zlLsn61N+iIANxMw8LTk6rCtde9zLQX6hfzqdl/DxgXaAluq
 4rUjMAFfuNmkmE6j4lpjhvTv5TiiJaY++MjBe0GgpX/VXEa8hmqL6l2cHug/pT5cOc2X
 EreKLPHT2D9YmO2yGnG5/3Pknis9bcAE1W3P1UlWKxatdH7QpwFlGLFa5KgUcvLDPqNo
 5Kxg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788186659; x=1788791459; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=jwAByLoPLqoocjzFPyzsZC+xzGC/eZSiR4GVkvk53t8=;
 b=Zm3amR0EJLbsjKRPTOy5a9KMYM5CFxqtnQ9wuaAero+5nKbfCXWBDGBFqMeaUTeI7T
 /7aykVWzF0iywN7WAA+zctraER9T3J4DmKqZnhWkmbEpmNSt+SwoNZNc856dK/prYiXd
 Z5eSGiPiE5cVSCysHEMzxO9MsAWNZP3tgjx5/M8/vna8aVM9S4GUoiCNUePq8ig2jXVP
 EEMB9pVRZ4q3EA8JHdwiBdHCUEqB+CDwsHvCQMc3FCbexfHe5QnawhUCj49LaMFH3DNk
 ntc/w3DSvIXsa4RkGk2J8JC8OGpwNbdgX7sau51HjavxSzs93FSEhY26QtnfeJulsd6a
 GY+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788186659; x=1788791459;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jwAByLoPLqoocjzFPyzsZC+xzGC/eZSiR4GVkvk53t8=;
 b=gSPngHJQCJlzVlWXzfIU5g6taRI+4PFbB1V22JNaXhMSjYuSi5d12GN7u+4wnQs7ne
 MAQseCQc62rSM30Kdngd0OOueOQhERKzCqGHZRINFnlQxULno2/aDuFvUkxZsNqxDAMi
 LcGQ/FYG2OskaTCdDZA+oafnkX21CwpQ1g8KfZHd6t9VkGiStjrOua+0XakekzPBfxuv
 rr0kzX2sX8x/b9M1ea9qTYJ/7kDa4ErYBItvc/crVGft4lbNm5bvgowLYeaiLbjrnPKs
 R+Ye7aheUKfGp/kSNcRsmZvLq2WP4JdZdKgnwJJ8Z+PqO09grVJVFFbZQphcbao5Z7qw
 QizA==
X-Gm-Message-State: AFuF++nKQ+o2Ralv4dLSVfRhIoXKXIQqvFax1Tnt5UQhVUkic05vgM0n
 AEJJDyzYchjlME/AVE/GzhBOLVrMQavYoZ4G4My98KX8R9UYaj4qCDy3W4ryD0XKEMSCqb/X4Ou
 JuiZs2P+ah0CtPgTQhv/CKyY5K5ZsP3M=
X-Gm-Gg: AYBFou1rI1giH5WPNmhC6YLYYxH3Cnunay8Us1l6pzauZASNz0IPr3si07zEGEcvaAz
 bNTzl6CIEjzZrebR19YCRKIuClD7afGwZPvoHoSZ3DvDHKP8S9SdpSNxw7ZQidsgL53PuTdYb1m
 UulQZswh8G36srg2OMcUg25frdaTe+ZGI4xTL3Y0EKfSCz7noPc3RlyYDamRr5gxuij6/EC7Mi7
 adjvceeR8Xxk+RVrK3fwyOdqt35J/2RbhTqE9a2N0nDhJJKbGmonhEe/TVcsggm0VVdt8Z/iECa
 lQoyaGK2Y1rKKLesNpv+C8l8gyQn1OVx4drH91DXsE8yjHaXKUIenLOdXQIwBMDI+8W1bTIGqAx
 Sm7q2BfDleFMEfgpi/pGQTlGnut6FsVQI
X-Received: by 2002:a17:90b:3c50:b0:38e:6d4c:14df with SMTP id
 98e67ed59e1d1-398ba94fd38mr14838783a91.1.1788186659071; Mon, 31 Aug 2026
 07:30:59 -0700 (PDT)
MIME-Version: 1.0
References: <20260831130051.2031435-1-mario.limonciello@amd.com>
In-Reply-To: <20260831130051.2031435-1-mario.limonciello@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 31 Aug 2026 10:30:47 -0400
X-Gm-Features: AcwNN1VN7y9Pn6VoxcGk4H3fIMPuy0jQsAAuFK3G5f4Y6kHn2XNNHOhKktG2czU
Message-ID: <CADnq5_Nsb9iau_qgDFssNbA4KVoyWmqCDEaDR4Q3Z-b7YORh4Q@mail.gmail.com>
Subject: Re: [PATCH] drm/amdkfd: fix scope of mqd_mgr dereference in
 pqm_debugfs_mqds
To: Mario Limonciello <mario.limonciello@amd.com>
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

On Mon, Aug 31, 2026 at 9:01=E2=80=AFAM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> Reading /sys/kernel/debug/kfd/mqds while a process holds an active KFD
> queue triggers a NULL pointer dereference because the for loop that
> calls mqd_mgr->debugfs_show_mqd() is incorrectly placed outside the
> if (pqn->q) block that initializes mqd_mgr.
>
> The queue list can contain entries where pqn->q is NULL (kernel queues
> where only pqn->kq is valid). In the original code:
>
>   if (pqn->q) {
>       ...
>       mqd_mgr =3D q->device->dqm->mqd_mgrs[mqd_type];
>       size =3D mqd_mgr->mqd_stride(...);
>   }
>
>   for (xcc =3D 0; xcc < num_xccs; xcc++) {  // WRONG: outside if block
>       mqd =3D q->mqd + size * xcc;
>       r =3D mqd_mgr->debugfs_show_mqd(m, mqd);
>   }
>
> When iterating over a queue node where pqn->q is NULL:
> 1. The if (pqn->q) block is skipped
> 2. mqd_mgr remains uninitialized (NULL from declaration)
> 3. The for loop executes anyway
> 4. mqd_mgr->debugfs_show_mqd(m, mqd) dereferences NULL
>
> The crash manifests as:
>
>   BUG: kernel NULL pointer dereference, address: 0000000000000000
>   #PF: supervisor instruction fetch in kernel mode
>   RIP: 0010:0x0
>   Call Trace:
>    pqm_debugfs_mqds+0x10c/0x1d0 [amdgpu]
>    kfd_debugfs_mqds_by_process+0x9b/0x110 [amdgpu]
>    seq_read_iter+0x132/0x4b0
>    ...
>
> Fix by moving the for loop inside the if (pqn->q) block, so mqd_mgr
> and related variables are only used when properly initialized.
>
> Cc: stable@vger.kernel.org
> Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/5689
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
>  .../gpu/drm/amd/amdkfd/kfd_process_queue_manager.c   | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c b/dri=
vers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> index 9e607098c3a09..fb2d8ad9c2c5e 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process_queue_manager.c
> @@ -1170,13 +1170,13 @@ int pqm_debugfs_mqds(struct seq_file *m, void *da=
ta)
>                         mqd_mgr =3D q->device->dqm->mqd_mgrs[mqd_type];
>                         size =3D mqd_mgr->mqd_stride(mqd_mgr,
>                                                         &q->properties);
> -               }
>
> -               for (xcc =3D 0; xcc < num_xccs; xcc++) {
> -                       mqd =3D q->mqd + size * xcc;
> -                       r =3D mqd_mgr->debugfs_show_mqd(m, mqd);
> -                       if (r !=3D 0)
> -                               break;
> +                       for (xcc =3D 0; xcc < num_xccs; xcc++) {
> +                               mqd =3D q->mqd + size * xcc;
> +                               r =3D mqd_mgr->debugfs_show_mqd(m, mqd);
> +                               if (r !=3D 0)
> +                                       break;
> +                       }
>                 }
>         }
>
> --
> 2.43.0
>
