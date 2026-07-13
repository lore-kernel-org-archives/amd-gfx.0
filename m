Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6854DC43458
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jul 2026 13:53:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0395410E542;
	Mon, 13 Jul 2026 13:53:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="W3+jGADn";
	dkim-atps=neutral
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2549110E542
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jul 2026 13:53:13 +0000 (UTC)
Received: by mail-pl1-f174.google.com with SMTP id
 d9443c01a7336-2caf18d4904so7504805ad.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jul 2026 06:53:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783950793; cv=none;
 d=google.com; s=arc-20260327;
 b=BblRHmmkoV+a8xxYFVO0qIoW05IoRLc0dEVvWagFELR8AEsYq/u8cgo/UYMYaoHXsp
 vJMA8Sr5LmVNvJFhuT6hdmyDMgwGhdVeKMLpBz0qiZ9zNo1l+meYokRBIiB/XtMqMfRz
 OYEc26UHIapct+6IQBTnGoBtDv8/3H/0R/s8m1nmflx6dj4rEUqqxh9FDpRUUujA79Dh
 m8a0F4IyGGfiVnSClFcRGCRBZ3xR1ekKYOj/nfB+JEUZD3mPT88/3k/AHsRM1TGXIog3
 WUPUqtCStuERuVA5GRW1qFRrLMN4hiyLO9Rr5Lbvc4pcSGPInOx1I33DObts8aU8p5DC
 hlng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=6Ju7JkIl5UIVeq+e4m/4INBwT5l7DAudqFtY95A7Hsc=;
 fh=UCmQF1hYC+nU64AKGSmOqe7UwqTgX6L1hAWSpxYIIzc=;
 b=Fcq5/vPTZtJ+3ZNL1TywCDpJm1zUPVYTw0rXqG+hM3VjU6x371c4MBMPBgHwhGo7hh
 FpKCgr+zKtBE7tJ8rUl5znMC/mrIXxPFqSAh8tuYlDmFZmGgvf/zvkPUtpZoB8ZI/cgr
 O8EdcpVdfdn9dD4kUjeCOEg4kZMsu7NDhHdux7h2WUiKa9IvucPnInSwjOhsKTAsAEZ2
 WREWOfG/Loea3NED0nKixLj/7iVHbnGXeETI0SloEcivXWD0F6f7RPS0C10Pd37OAstz
 xQSKmvggILyJZWA71P5oEQ3ev9ZyZZ+RwzqjE2zVwtCxsLumEgvruw74x+1+QHfXF9Qn
 ZMXw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783950793; x=1784555593; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=6Ju7JkIl5UIVeq+e4m/4INBwT5l7DAudqFtY95A7Hsc=;
 b=W3+jGADnI3pPhNpCnq7ML35pTCqu5algQDOQAJS0qz7Wvsn2WsxNsXF514rITFqPXw
 dLmnbtAA2zPn7RWC+hDCdJvndwPCMgdg1i7+uIw4pLns0sVICZ+9B+x/e1tvIqRBMwHm
 cwomi+V+7Ho6bTGRCg+Q1MngNP5sDpTUEZGoNSPClsw9DiqtsTV4bje0QZIrRTTVNiRN
 pPl2MV0K/rLeRmCnTV2hdrb3j89C2qpkf38Cq/wn1AQDX38HnwklEWdA5+p94TbBrHCD
 CnC6+chTC0VE6zFnmkCuZLksrSJn1AhNWBMBoXiwyJPzvnReHdPBQAxP9JNN51/tF9d6
 WAlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783950793; x=1784555593;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=6Ju7JkIl5UIVeq+e4m/4INBwT5l7DAudqFtY95A7Hsc=;
 b=Xw5dz3E4Z1G8qOwyJEm+sPVeTJU+1dWVBJRA+Qcvr0mmpeULl/Gi2ktCTduxpZV9uj
 vLpIzL0oTWxkNt5cd9kjc1byUqJsuS8RL0+ZWNc/m88lRC6/OR4jbhDPofWV7yqc98m0
 8DXVKTuSLpzhVfku+X50MyQVLdxU9UVdgm+Ss8v6uXAoHzMRj9Faexmxl07uPxcgrLnM
 Tz0rEGK82dVKdoGfc4JDaT/rRxe6YQQRoltNYgUMKTz9qBK6Z3Bdk08dZWumLckI8JO3
 7/6ih5XUkelET4VZDLXese6z0vWhQw0+thxO0UkOgGrkczGFTU7UbkhO0lDe+ciJ2r2B
 GQTg==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro/jU/KX8VfdP+0ujlem3yXkLIbhch/FXtPe5EW9kwORwYK9VWJed/rLQ9I+EnaF+KZN/UxW94W@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxd+XTZhAaS+E0eQAD+bLLqdb5oQpTvmJShhqljdZB5NeCHYf8j
 ZyNRmQOGvvKs0jLXGRaEo41Nw1DmOcr4VmjiIc0wwpzF2GDFTfHr2AcXCe/Q8wA1wG1kAkQoiJj
 uA3uTcx6h8kf7775+9l9iVuPgkUErxtk=
X-Gm-Gg: AfdE7ckKknnnRNuOAMRhgXA+e0l9QsfFTVp9hm4iQYtSoD8xYegmaBTRrVEbf9z9/Ez
 fH0xg/sbEJKwAIDZohrbzS8ctett5GFWAXKYU9YU4ntTt0Tz8u0lR7St6a7MQd1XFbPhtnHMn8m
 pNtE3Y7WNKElIAlSe0SYVaE1ohbC+qP/x0fAyjvtE6/CfuEvxSbslq0EVFiL6gqVq9JpLQR7QSx
 XFKxslN70GGQgzKIiSqaGr5u9khVlIgB11zy+iBW69GDqBU5AHvz2vnQUwUffuCzwLzypCJLJrO
 Mi7JIJiCZDVpDi0G7OSH8OGIX1sDsm69c5Ovn6qXEWDzVtIGKtmNgi5845E=
X-Received: by 2002:a17:902:d552:b0:2ca:11ee:b002 with SMTP id
 d9443c01a7336-2ce9f16e095mr70950855ad.5.1783950792608; Mon, 13 Jul 2026
 06:53:12 -0700 (PDT)
MIME-Version: 1.0
References: <20260711112108.8980-1-timur.kristof@gmail.com>
 <43c2ca71-c468-41f1-adbc-cc170109de14@amd.com>
In-Reply-To: <43c2ca71-c468-41f1-adbc-cc170109de14@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 13 Jul 2026 09:53:00 -0400
X-Gm-Features: AVVi8Ce8WLyKNmn2oNsvvShbz1yBi5ACSZZs1_clI6r66K__7nIlFUw6cWjxGHQ
Message-ID: <CADnq5_PwktZb9tuUZ6sZX-=3wkQ_X56pmEUaswHh2k=fz6xQjg@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/amdgpu: Print vmid,
 pasid and more task info in devcoredump
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>, 
 amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, pierre-eric.pelloux-prayer@amd.com, 
 Natalie Vock <natalie.vock@gmx.de>
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

Applied the series.  Thanks!

On Mon, Jul 13, 2026 at 7:09=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> On 7/11/26 13:21, Timur Krist=C3=B3f wrote:
> > These are in the dmesg logs but are missing from devcoredumps.
> >
> > Signed-off-by: Timur Krist=C3=B3f <timur.kristof@gmail.com>
>
> Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c | 7 ++++++-
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.h | 1 +
> >  2 files changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c b/drivers=
/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
> > index 4fd0df3aa70d..aaf091b7f9d0 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
> > @@ -356,10 +356,14 @@ amdgpu_devcoredump_format(char *buffer, size_t co=
unt, struct amdgpu_coredump_inf
> >       drm_printf(&p, "kernel: %s\n", init_utsname()->release);
> >       drm_printf(&p, "module: " KBUILD_MODNAME "\n");
> >       drm_printf(&p, "time: %ptSp\n", &coredump->reset_time);
> > +     drm_printf(&p, "pasid: %u\n", coredump->pasid);
> > +     drm_printf(&p, "vmid: %u\n", coredump->vmid);
> >
> >       if (coredump->reset_task_info.task.pid)
> > -             drm_printf(&p, "process_name: %s PID: %d\n",
> > +             drm_printf(&p, "process_name: %s TGID: %d thread: %s PID:=
 %d\n",
> >                          coredump->reset_task_info.process_name,
> > +                        coredump->reset_task_info.tgid,
> > +                        coredump->reset_task_info.task.comm,
> >                          coredump->reset_task_info.task.pid);
> >
> >       /* SOC Information */
> > @@ -563,6 +567,7 @@ void amdgpu_coredump(struct amdgpu_device *adev, bo=
ol skip_vram_check,
> >                       amdgpu_vm_put_task_info(ti);
> >               }
> >               coredump->pasid =3D job->pasid;
> > +             coredump->vmid =3D job->vmid;
> >               coredump->num_ibs =3D job->num_ibs;
> >               for (i =3D 0; i < job->num_ibs; ++i) {
> >                       coredump->ibs[i].gpu_addr =3D job->ibs[i].gpu_add=
r;
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.h b/drivers=
/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.h
> > index 2371e20fc68b..63f27337c09a 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.h
> > @@ -63,6 +63,7 @@ struct amdgpu_coredump_info {
> >       char                            *formatted;
> >
> >       unsigned int                    pasid;
> > +     unsigned int                    vmid;
> >       int                             num_ibs;
> >       struct amdgpu_coredump_ib_info  ibs[] __counted_by(num_ibs);
> >  };
>
