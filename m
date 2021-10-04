Return-Path: <SRS0=otPk=OY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4DEEC433EF
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Oct 2021 13:32:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B68261090
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Oct 2021 13:32:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8B68261090
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 404186E1B5;
	Mon,  4 Oct 2021 13:32:17 +0000 (UTC)
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com
 [IPv6:2607:f8b0:4864:20::334])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 099A86E1B5
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Oct 2021 13:32:16 +0000 (UTC)
Received: by mail-ot1-x334.google.com with SMTP id
 77-20020a9d0ed3000000b00546e10e6699so21480219otj.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 04 Oct 2021 06:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=S0wUR3IsxmPT5gX+S0qwm8qlUrgetegAJvDqUt/bJgk=;
 b=gsT2aok70HcNYz+lllzYDCd/oRyOjBnT6C4ROW5g5VwysfvWKQTC6+bUqfcOHbXBZ8
 TnoxcKfI2UKEwZZRQrTcxJ02JGKhmb1VsciL29RanTYdbkJ5eQ8nwCj16MxyZXmnpC7A
 hnua074k8EpPJz7HZ3NlEZOXJNgxqPG7Mp5FtuTR+KJVnJ8PvOEIqn75vGY4tIGyb7cG
 r8aUqheoJXiNZH7Ym7sJB7jnGPkxMWm0E0j71hoHxGGtXkFBA4q5gvx0YYmP4f6X4Yhj
 4M+kM0Rj900td0sI4ECQuGYaHEjKbSAF5NZMJW8dLuwmxkHfjMs/HmE1v64OOrP+R5ey
 ObAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=S0wUR3IsxmPT5gX+S0qwm8qlUrgetegAJvDqUt/bJgk=;
 b=yCD9rFBtamoRmV21JxRIWdcjizBIP83UXN7rnQc3RHD06ah3ZezfmfCAnJORp1FDxe
 rS73RDTqf6pAlwY0Hse75kjUZuhmjy55ctv1cvFZxBl5C04dqphBDLPhBQuLJqCms+8L
 TykT+6Al0IUhisQlbT1swPl8tgCiebxpkmNzTzkkuoMpWrv0jO7ZdWk/CxQOE8uNbwy2
 Yv8VtDhRCUAuKuhuZk/EFjsN/vUgByx0ssus9FGqvv+BSLAtYuEodTYZH+LTVJREf3q5
 2za2WIDGjo+0BPSWEIqL9AS2TiAVxpylr/ScgE3wXqV1bvcgDeb0mTpOaj+PuzFJQErn
 pXsA==
X-Gm-Message-State: AOAM533KmKOyyGXFEmFBvxk2euo+SWqgFpI6fdAeprmsz+ByZmZtr8E1
 1IhGNic9MpREmGKQaaQZU25Ia81nr0X8jLlLJw0=
X-Google-Smtp-Source: ABdhPJzerfVfJf2OS+uge3wlEx+tY+lAtQWcSzy1q57EY+iEk0zP2W3zqC8Ug6YsZdxtJTQAtvcQMOothrfQKJTDpbM=
X-Received: by 2002:a05:6830:1bc6:: with SMTP id
 v6mr9398372ota.299.1633354335156; 
 Mon, 04 Oct 2021 06:32:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210930092611.13615-1-christian.koenig@amd.com>
 <ad72c18d-d0a6-51bb-540f-dde0688dc567@gmail.com>
In-Reply-To: <ad72c18d-d0a6-51bb-540f-dde0688dc567@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 4 Oct 2021 09:32:03 -0400
Message-ID: <CADnq5_P_cRROGGg3mhXR3viraq6cCm+GUb3bZthAAAO60WPxHw@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: revert "Add autodump debugfs node for gpu
 reset v8"
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>, 
 "Zhao, Jiange" <Jiange.Zhao@amd.com>
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

Acked-by: Alex Deucher <alexander.deucher@amd.com>

On Mon, Oct 4, 2021 at 4:31 AM Christian K=C3=B6nig
<ckoenig.leichtzumerken@gmail.com> wrote:
>
> Ping? Alex any objections to this?
>
> Otherwise I'm going to push it with Nirmoy's acked-by.
>
> Christian.
>
> Am 30.09.21 um 11:26 schrieb Christian K=C3=B6nig:
> > This reverts commit 728e7e0cd61899208e924472b9e641dbeb0775c4.
> >
> > Further discussion reveals that this feature is severely broken
> > and needs to be reverted ASAP.
> >
> > GPU reset can never be delayed by userspace even for debugging or
> > otherwise we can run into in kernel deadlocks.
> >
> > Signed-off-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu.h         |  2 -
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 80 --------------------=
-
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h |  5 --
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |  4 --
> >   4 files changed, 91 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu.h
> > index dc3c6b3a00e5..6a1928a720a6 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > @@ -1078,8 +1078,6 @@ struct amdgpu_device {
> >       char                            product_name[32];
> >       char                            serial[20];
> >
> > -     struct amdgpu_autodump          autodump;
> > -
> >       atomic_t                        throttling_logging_enabled;
> >       struct ratelimit_state          throttling_logging_rs;
> >       uint32_t                        ras_hw_enabled;
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_debugfs.c
> > index 277128846dd1..0b89ba142a59 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> > @@ -27,7 +27,6 @@
> >   #include <linux/pci.h>
> >   #include <linux/uaccess.h>
> >   #include <linux/pm_runtime.h>
> > -#include <linux/poll.h>
> >
> >   #include "amdgpu.h"
> >   #include "amdgpu_pm.h"
> > @@ -37,85 +36,7 @@
> >   #include "amdgpu_securedisplay.h"
> >   #include "amdgpu_fw_attestation.h"
> >
> > -int amdgpu_debugfs_wait_dump(struct amdgpu_device *adev)
> > -{
> >   #if defined(CONFIG_DEBUG_FS)
> > -     unsigned long timeout =3D 600 * HZ;
> > -     int ret;
> > -
> > -     wake_up_interruptible(&adev->autodump.gpu_hang);
> > -
> > -     ret =3D wait_for_completion_interruptible_timeout(&adev->autodump=
.dumping, timeout);
> > -     if (ret =3D=3D 0) {
> > -             pr_err("autodump: timeout, move on to gpu recovery\n");
> > -             return -ETIMEDOUT;
> > -     }
> > -#endif
> > -     return 0;
> > -}
> > -
> > -#if defined(CONFIG_DEBUG_FS)
> > -
> > -static int amdgpu_debugfs_autodump_open(struct inode *inode, struct fi=
le *file)
> > -{
> > -     struct amdgpu_device *adev =3D inode->i_private;
> > -     int ret;
> > -
> > -     file->private_data =3D adev;
> > -
> > -     ret =3D down_read_killable(&adev->reset_sem);
> > -     if (ret)
> > -             return ret;
> > -
> > -     if (adev->autodump.dumping.done) {
> > -             reinit_completion(&adev->autodump.dumping);
> > -             ret =3D 0;
> > -     } else {
> > -             ret =3D -EBUSY;
> > -     }
> > -
> > -     up_read(&adev->reset_sem);
> > -
> > -     return ret;
> > -}
> > -
> > -static int amdgpu_debugfs_autodump_release(struct inode *inode, struct=
 file *file)
> > -{
> > -     struct amdgpu_device *adev =3D file->private_data;
> > -
> > -     complete_all(&adev->autodump.dumping);
> > -     return 0;
> > -}
> > -
> > -static unsigned int amdgpu_debugfs_autodump_poll(struct file *file, st=
ruct poll_table_struct *poll_table)
> > -{
> > -     struct amdgpu_device *adev =3D file->private_data;
> > -
> > -     poll_wait(file, &adev->autodump.gpu_hang, poll_table);
> > -
> > -     if (amdgpu_in_reset(adev))
> > -             return POLLIN | POLLRDNORM | POLLWRNORM;
> > -
> > -     return 0;
> > -}
> > -
> > -static const struct file_operations autodump_debug_fops =3D {
> > -     .owner =3D THIS_MODULE,
> > -     .open =3D amdgpu_debugfs_autodump_open,
> > -     .poll =3D amdgpu_debugfs_autodump_poll,
> > -     .release =3D amdgpu_debugfs_autodump_release,
> > -};
> > -
> > -static void amdgpu_debugfs_autodump_init(struct amdgpu_device *adev)
> > -{
> > -     init_completion(&adev->autodump.dumping);
> > -     complete_all(&adev->autodump.dumping);
> > -     init_waitqueue_head(&adev->autodump.gpu_hang);
> > -
> > -     debugfs_create_file("amdgpu_autodump", 0600,
> > -             adev_to_drm(adev)->primary->debugfs_root,
> > -             adev, &autodump_debug_fops);
> > -}
> >
> >   /**
> >    * amdgpu_debugfs_process_reg_op - Handle MMIO register reads/writes
> > @@ -1590,7 +1511,6 @@ int amdgpu_debugfs_init(struct amdgpu_device *ade=
v)
> >       }
> >
> >       amdgpu_ras_debugfs_create_all(adev);
> > -     amdgpu_debugfs_autodump_init(adev);
> >       amdgpu_rap_debugfs_init(adev);
> >       amdgpu_securedisplay_debugfs_init(adev);
> >       amdgpu_fw_attestation_debugfs_init(adev);
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h b/drivers/gpu/=
drm/amd/amdgpu/amdgpu_debugfs.h
> > index 141a8474e24f..8b641f40fdf6 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
> > @@ -26,10 +26,6 @@
> >   /*
> >    * Debugfs
> >    */
> > -struct amdgpu_autodump {
> > -     struct completion               dumping;
> > -     struct wait_queue_head          gpu_hang;
> > -};
> >
> >   int amdgpu_debugfs_regs_init(struct amdgpu_device *adev);
> >   int amdgpu_debugfs_init(struct amdgpu_device *adev);
> > @@ -37,4 +33,3 @@ void amdgpu_debugfs_fini(struct amdgpu_device *adev);
> >   void amdgpu_debugfs_fence_init(struct amdgpu_device *adev);
> >   void amdgpu_debugfs_firmware_init(struct amdgpu_device *adev);
> >   void amdgpu_debugfs_gem_init(struct amdgpu_device *adev);
> > -int amdgpu_debugfs_wait_dump(struct amdgpu_device *adev);
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_device.c
> > index 41c6b3aacd37..4d34b2da8582 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > @@ -4458,10 +4458,6 @@ int amdgpu_device_pre_asic_reset(struct amdgpu_d=
evice *adev,
> >       if (reset_context->reset_req_dev =3D=3D adev)
> >               job =3D reset_context->job;
> >
> > -     /* no need to dump if device is not in good state during probe pe=
riod */
> > -     if (!adev->gmc.xgmi.pending_reset)
> > -             amdgpu_debugfs_wait_dump(adev);
> > -
> >       if (amdgpu_sriov_vf(adev)) {
> >               /* stop the data exchange thread */
> >               amdgpu_virt_fini_data_exchange(adev);
>
