Return-Path: <SRS0=FOdb=NQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79418C432BE
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Aug 2021 11:04:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D1FA611C9
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Aug 2021 11:04:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3D1FA611C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C25396E1B7;
	Wed, 25 Aug 2021 11:04:52 +0000 (UTC)
Received: from mail-vk1-xa2e.google.com (mail-vk1-xa2e.google.com
 [IPv6:2607:f8b0:4864:20::a2e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05F2F6E1B7
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Aug 2021 11:04:51 +0000 (UTC)
Received: by mail-vk1-xa2e.google.com with SMTP id d15so6400173vko.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Aug 2021 04:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=KVZsz3Jz28qifwHU6JncIULBA/6ZztTVu5mgCLpsCEQ=;
 b=lefjP2mvuX5pM3tbz5mdqqIG85VvrxRBarEtUpb/1MLN+TnlysRxwX9X3IHe+kN1H6
 4R+vcGUiOKBRSuvBLeH9G0uweNOr9jcPMwOLPA/mm2CHXe1tczBU4RUmtAnf8bttOwCC
 8ZrZkLMGSvtLnyyGce+dEzByrhfiUfHOKFE9Q5Cc86+1FPh0057ysho3FXdxJ/dwfbgL
 c8PCxvqlVDIrwjey9s5szLwesY+B0L32wT2w2OXw7YNdcneksMTEaz70GmWWHiurZcHm
 O1/CgfwNp2dJvtfuj0kODauvZgeGo6teTKlKwRxhKoHM04kvQ1hE/NA3SMeWb5cZqBnS
 oKcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=KVZsz3Jz28qifwHU6JncIULBA/6ZztTVu5mgCLpsCEQ=;
 b=gzkdFkEUPj8Tet2nAO9cTHi75YyGomQyFwdbXygMAhsagOu3iaPEpRp+X0jmHo0Pbf
 vte9WQzznzSAxHbAedYihN6UYp99PzdnRqkLTbnFMRiBOeFWsIGAUqxnHuEMQCUpPRJ4
 1y/6gcMBiL9G/NkDCKov6T0smU39c///AJN8sBSzbLHChANVgSCk58Ga6HfKNpia0QcC
 Zr2WAc1I+gcUeAYXCKN0J1FO85KjKovEjob478BrAHYsww9dKNbeboSCWWXilHs1mEtf
 eOEASOKKE45i4Of6/4mGXaQ1IBZfSEVpYBJVMJJSLqiMSdUhq+AggOjWIvxEo9lkbcdk
 sKbQ==
X-Gm-Message-State: AOAM531yZuukSehBRPUqYGJYamcknbcg4Mam8jsLKtQT+BQPANDo6Zyl
 SB91wXtOJCa53CDee8DJFVdU9/plgXoYOICdfgA=
X-Google-Smtp-Source: ABdhPJxhg//CGgHYI/6iwB9y0EptbrybfNkb8UegNpvgB/t5XNh7cOturkpsHbaHgYRsJmG6McqVNQ5qonKX9fqSc1U=
X-Received: by 2002:a1f:27cc:: with SMTP id n195mr11178302vkn.0.1629889488675; 
 Wed, 25 Aug 2021 04:04:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210824133642.109072-1-tom.stdenis@amd.com>
 <de13fb00-3ce7-5f6c-8f22-e07e697de643@gmail.com>
 <CAAzXoRLzLjZm0AW1w=oEKMsRrVzwPDawbdimBiaKV86A7QF8nQ@mail.gmail.com>
 <84ddce49-012b-2fae-d14d-eeebf7e6c09a@gmail.com>
In-Reply-To: <84ddce49-012b-2fae-d14d-eeebf7e6c09a@gmail.com>
From: Tom St Denis <tstdenis82@gmail.com>
Date: Wed, 25 Aug 2021 07:04:37 -0400
Message-ID: <CAAzXoRJsSxm7UOt++H9Ko8pnnNdO0Zp=+hPgCh8TwUaQhv-e_w@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/amdgpu: New debugfs interface for MMIO registers
 (v2)
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc: Nirmoy Das <nirmoy.das@amd.com>, Tom St Denis <tom.stdenis@amd.com>, 
 amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/alternative; boundary="000000000000fee71205ca60376f"
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

--000000000000fee71205ca60376f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I tested it by forcing bit patterns into the ioctl data and printing it out
in the kernel log.  I'm not siloed into it one way or the other.  I'll just
change it to u32.

On Wed, Aug 25, 2021 at 7:03 AM Christian K=C3=B6nig <
ckoenig.leichtzumerken@gmail.com> wrote:

> Using u8 is ok as well, just make sure that you don't have any hidden
> padding.
>
> Nirmoy had a tool to double check for paddings which I once more forgot
> the name of.
>
> Christian.
>
> Am 25.08.21 um 12:40 schrieb Tom St Denis:
>
> The struct works as is but I'll change them to u32.  The offset is an
> artefact of the fact this was an IOCTL originally.  I'm working both ends
> in parallel trying to make the changes at the same time because I'm only
> submitting the kernel patch if I've tested it in userspace.
>
> I'll send a v4 in a bit this morning....
>
> Tom
>
> On Wed, Aug 25, 2021 at 2:35 AM Christian K=C3=B6nig <
> ckoenig.leichtzumerken@gmail.com> wrote:
>
>>
>>
>> Am 24.08.21 um 15:36 schrieb Tom St Denis:
>> > This new debugfs interface uses an IOCTL interface in order to pass
>> > along state information like SRBM and GRBM bank switching.  This
>> > new interface also allows a full 32-bit MMIO address range which
>> > the previous didn't.  With this new design we have room to grow
>> > the flexibility of the file as need be.
>> >
>> > (v2): Move read/write to .read/.write, fix style, add comment
>> >        for IOCTL data structure
>> >
>> > Signed-off-by: Tom St Denis <tom.stdenis@amd.com>
>> > ---
>> >   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 162 ++++++++++++++++++=
++
>> >   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h |  32 ++++
>> >   2 files changed, 194 insertions(+)
>> >
>> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>> > index 277128846dd1..8e8f5743c8f5 100644
>> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>> > @@ -279,6 +279,156 @@ static ssize_t amdgpu_debugfs_regs_write(struct
>> file *f, const char __user *buf,
>> >       return amdgpu_debugfs_process_reg_op(false, f, (char __user
>> *)buf, size, pos);
>> >   }
>> >
>> > +static int amdgpu_debugfs_regs2_open(struct inode *inode, struct file
>> *file)
>> > +{
>> > +     struct amdgpu_debugfs_regs2_data *rd;
>> > +
>> > +     rd =3D kzalloc(sizeof *rd, GFP_KERNEL);
>> > +     if (!rd)
>> > +             return -ENOMEM;
>> > +     rd->adev =3D file_inode(file)->i_private;
>> > +     file->private_data =3D rd;
>> > +
>> > +     return 0;
>> > +}
>> > +
>> > +static int amdgpu_debugfs_regs2_release(struct inode *inode, struct
>> file *file)
>> > +{
>> > +     kfree(file->private_data);
>> > +     return 0;
>> > +}
>> > +
>> > +static ssize_t amdgpu_debugfs_regs2_op(struct file *f, char __user
>> *buf, size_t size, int write_en)
>> > +{
>> > +     struct amdgpu_debugfs_regs2_data *rd =3D f->private_data;
>> > +     struct amdgpu_device *adev =3D rd->adev;
>> > +     ssize_t result =3D 0;
>> > +     int r;
>> > +     uint32_t value;
>> > +
>> > +     if (size & 0x3 || rd->state.offset & 0x3)
>> > +             return -EINVAL;
>> > +
>> > +     if (rd->state.id.use_grbm) {
>> > +             if (rd->state.id.grbm.se =3D=3D 0x3FF)
>> > +                     rd->state.id.grbm.se =3D 0xFFFFFFFF;
>> > +             if (rd->state.id.grbm.sh =3D=3D 0x3FF)
>> > +                     rd->state.id.grbm.sh =3D 0xFFFFFFFF;
>> > +             if (rd->state.id.grbm.instance =3D=3D 0x3FF)
>> > +                     rd->state.id.grbm.instance =3D 0xFFFFFFFF;
>> > +     }
>> > +
>> > +     r =3D pm_runtime_get_sync(adev_to_drm(adev)->dev);
>> > +     if (r < 0) {
>> > +             pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>> > +             return r;
>> > +     }
>> > +
>> > +     r =3D amdgpu_virt_enable_access_debugfs(adev);
>> > +     if (r < 0) {
>> > +             pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>> > +             return r;
>> > +     }
>> > +
>> > +     if (rd->state.id.use_grbm) {
>> > +             if ((rd->state.id.grbm.sh !=3D 0xFFFFFFFF && rd->
>> state.id.grbm.sh >=3D adev->gfx.config.max_sh_per_se) ||
>> > +                 (rd->state.id.grbm.se !=3D 0xFFFFFFFF && rd->
>> state.id.grbm.se >=3D adev->gfx.config.max_shader_engines)) {
>> > +                     pm_runtime_mark_last_busy(adev_to_drm(adev)->dev=
);
>> > +
>>  pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>> > +                     amdgpu_virt_disable_access_debugfs(adev);
>> > +                     return -EINVAL;
>> > +             }
>> > +             mutex_lock(&adev->grbm_idx_mutex);
>> > +             amdgpu_gfx_select_se_sh(adev, rd->state.id.grbm.se,
>> > +                                                             rd->
>> state.id.grbm.sh,
>> > +
>>  rd->state.id.grbm.instance);
>> > +     }
>> > +
>> > +     if (rd->state.id.use_srbm) {
>> > +             mutex_lock(&adev->srbm_mutex);
>> > +             amdgpu_gfx_select_me_pipe_q(adev, rd->state.id.srbm.me,
>> rd->state.id.srbm.pipe,
>> > +
>>  rd->state.id.srbm.queue, rd->state.id.srbm.vmid);
>> > +     }
>> > +
>> > +     if (rd->state.id.pg_lock)
>> > +             mutex_lock(&adev->pm.mutex);
>> > +
>> > +     while (size) {
>> > +             if (!write_en) {
>> > +                     value =3D RREG32(rd->state.offset >> 2);
>> > +                     r =3D put_user(value, (uint32_t *)buf);
>> > +             } else {
>> > +                     r =3D get_user(value, (uint32_t *)buf);
>> > +                     if (!r)
>> > +                             amdgpu_mm_wreg_mmio_rlc(adev,
>> rd->state.offset >> 2, value);
>> > +             }
>> > +             if (r) {
>> > +                     result =3D r;
>> > +                     goto end;
>> > +             }
>> > +             rd->state.offset +=3D 4;
>> > +             size -=3D 4;
>> > +             result +=3D 4;
>> > +             buf +=3D 4;
>> > +     }
>> > +end:
>> > +     if (rd->state.id.use_grbm) {
>> > +             amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff,
>> 0xffffffff);
>> > +             mutex_unlock(&adev->grbm_idx_mutex);
>> > +     }
>> > +
>> > +     if (rd->state.id.use_srbm) {
>> > +             amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, 0);
>> > +             mutex_unlock(&adev->srbm_mutex);
>> > +     }
>> > +
>> > +     if (rd->state.id.pg_lock)
>> > +             mutex_unlock(&adev->pm.mutex);
>> > +
>> > +     // in umr (the likely user of this) flags are set per file
>> operation
>> > +     // which means they're never "unset" explicitly.  To avoid
>> breaking
>> > +     // this convention we unset the flags after each operation
>> > +     // flags are for a single call (need to be set for every
>> read/write)
>> > +     rd->state.id.use_grbm =3D 0;
>> > +     rd->state.id.use_srbm =3D 0;
>> > +     rd->state.id.pg_lock  =3D 0;
>> > +
>> > +     pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
>> > +     pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>> > +
>> > +     amdgpu_virt_disable_access_debugfs(adev);
>> > +     return result;
>> > +}
>> > +
>> > +static long amdgpu_debugfs_regs2_ioctl(struct file *f, unsigned int
>> cmd, unsigned long data)
>> > +{
>> > +     struct amdgpu_debugfs_regs2_data *rd =3D f->private_data;
>> > +
>> > +     switch (cmd) {
>> > +     case AMDGPU_DEBUGFS_REGS2_IOC_SET_STATE:
>> > +             if (copy_from_user(&rd->state.id, (struct
>> amdgpu_debugfs_regs2_iocdata *)data, sizeof rd->state.id))
>> > +                     return -EINVAL;
>> > +             break;
>> > +     default:
>> > +             return -EINVAL;
>> > +     }
>> > +     return 0;
>> > +}
>> > +
>> > +static ssize_t amdgpu_debugfs_regs2_read(struct file *f, char __user
>> *buf, size_t size, loff_t *pos)
>> > +{
>> > +     struct amdgpu_debugfs_regs2_data *rd =3D f->private_data;
>> > +     rd->state.offset =3D *pos;
>> > +     return amdgpu_debugfs_regs2_op(f, buf, size, 0);
>> > +}
>> > +
>> > +static ssize_t amdgpu_debugfs_regs2_write(struct file *f, const char
>> __user *buf, size_t size, loff_t *pos)
>> > +{
>> > +     struct amdgpu_debugfs_regs2_data *rd =3D f->private_data;
>> > +     rd->state.offset =3D *pos;
>> > +     return amdgpu_debugfs_regs2_op(f, (char __user *)buf, size, 1);
>> > +}
>> > +
>> >
>> >   /**
>> >    * amdgpu_debugfs_regs_pcie_read - Read from a PCIE register
>> > @@ -1091,6 +1241,16 @@ static ssize_t amdgpu_debugfs_gfxoff_read(struc=
t
>> file *f, char __user *buf,
>> >       return result;
>> >   }
>> >
>> > +static const struct file_operations amdgpu_debugfs_regs2_fops =3D {
>> > +     .owner =3D THIS_MODULE,
>> > +     .unlocked_ioctl =3D amdgpu_debugfs_regs2_ioctl,
>> > +     .read =3D amdgpu_debugfs_regs2_read,
>> > +     .write =3D amdgpu_debugfs_regs2_write,
>> > +     .open =3D amdgpu_debugfs_regs2_open,
>> > +     .release =3D amdgpu_debugfs_regs2_release,
>> > +     .llseek =3D default_llseek
>> > +};
>> > +
>> >   static const struct file_operations amdgpu_debugfs_regs_fops =3D {
>> >       .owner =3D THIS_MODULE,
>> >       .read =3D amdgpu_debugfs_regs_read,
>> > @@ -1148,6 +1308,7 @@ static const struct file_operations
>> amdgpu_debugfs_gfxoff_fops =3D {
>> >
>> >   static const struct file_operations *debugfs_regs[] =3D {
>> >       &amdgpu_debugfs_regs_fops,
>> > +     &amdgpu_debugfs_regs2_fops,
>> >       &amdgpu_debugfs_regs_didt_fops,
>> >       &amdgpu_debugfs_regs_pcie_fops,
>> >       &amdgpu_debugfs_regs_smc_fops,
>> > @@ -1160,6 +1321,7 @@ static const struct file_operations
>> *debugfs_regs[] =3D {
>> >
>> >   static const char *debugfs_regs_names[] =3D {
>> >       "amdgpu_regs",
>> > +     "amdgpu_regs2",
>> >       "amdgpu_regs_didt",
>> >       "amdgpu_regs_pcie",
>> >       "amdgpu_regs_smc",
>> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
>> > index 141a8474e24f..ec044df5d428 100644
>> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
>> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
>> > @@ -22,6 +22,8 @@
>> >    * OTHER DEALINGS IN THE SOFTWARE.
>> >    *
>> >    */
>> > +#include <linux/ioctl.h>
>> > +#include <uapi/drm/amdgpu_drm.h>
>> >
>> >   /*
>> >    * Debugfs
>> > @@ -38,3 +40,33 @@ void amdgpu_debugfs_fence_init(struct amdgpu_device
>> *adev);
>> >   void amdgpu_debugfs_firmware_init(struct amdgpu_device *adev);
>> >   void amdgpu_debugfs_gem_init(struct amdgpu_device *adev);
>> >   int amdgpu_debugfs_wait_dump(struct amdgpu_device *adev);
>> > +
>> > +/*
>> > + * MMIO debugfs IOCTL structure
>> > + */
>> > +struct amdgpu_debugfs_regs2_iocdata {
>> > +     __u8 use_srbm, use_grbm, pg_lock;
>>
>> You should consider using u32 here as well or add explicitly padding.
>>
>> > +     struct {
>> > +             __u32 se, sh, instance;
>> > +     } grbm;
>> > +     struct {
>> > +             __u32 me, pipe, queue, vmid;
>> > +     } srbm;
>> > +};
>> > +
>> > +/*
>> > + * MMIO debugfs state data (per file* handle)
>> > + */
>> > +struct amdgpu_debugfs_regs2_data {
>> > +     struct amdgpu_device *adev;
>> > +     struct {
>> > +             struct amdgpu_debugfs_regs2_iocdata id;
>> > +             __u32 offset;
>>
>> What is the offset good for here?
>>
>> Regards,
>> Christian.
>>
>> > +     } state;
>> > +};
>> > +
>> > +enum AMDGPU_DEBUGFS_REGS2_CMDS {
>> > +     AMDGPU_DEBUGFS_REGS2_CMD_SET_STATE=3D0,
>> > +};
>> > +
>> > +#define AMDGPU_DEBUGFS_REGS2_IOC_SET_STATE _IOWR(0x20,
>> AMDGPU_DEBUGFS_REGS2_CMD_SET_STATE, struct amdgpu_debugfs_regs2_iocdata)
>>
>>
>

--000000000000fee71205ca60376f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I tested it by forcing bit patterns into the ioctl data an=
d printing it out in the kernel log.=C2=A0 I&#39;m not siloed into it one w=
ay or the other.=C2=A0 I&#39;ll just change it to u32.</div><br><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Aug 25, 2021=
 at 7:03 AM Christian K=C3=B6nig &lt;<a href=3D"mailto:ckoenig.leichtzumerk=
en@gmail.com">ckoenig.leichtzumerken@gmail.com</a>&gt; wrote:<br></div><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left=
:1px solid rgb(204,204,204);padding-left:1ex">
 =20
   =20
 =20
  <div>
    Using u8 is ok as well, just make sure that you don&#39;t have any
    hidden padding.<br>
    <br>
    Nirmoy had a tool to double check for paddings which I once more
    forgot the name of.<br>
    <br>
    Christian.<br>
    <br>
    <div>Am 25.08.21 um 12:40 schrieb Tom St
      Denis:<br>
    </div>
    <blockquote type=3D"cite">
     =20
      <div dir=3D"ltr">The struct works as is but I&#39;ll change them to
        u32.=C2=A0 The offset is an artefact of the fact this was an IOCTL
        originally.=C2=A0 I&#39;m working both ends in parallel trying to m=
ake
        the changes at the same time because I&#39;m only submitting the
        kernel patch if I&#39;ve tested it in userspace.
        <div><br>
        </div>
        <div>I&#39;ll send a v4 in a bit this morning....</div>
        <div><br>
        </div>
        <div>Tom</div>
      </div>
      <br>
      <div class=3D"gmail_quote">
        <div dir=3D"ltr" class=3D"gmail_attr">On Wed, Aug 25, 2021 at 2:35
          AM Christian K=C3=B6nig &lt;<a href=3D"mailto:ckoenig.leichtzumer=
ken@gmail.com" target=3D"_blank">ckoenig.leichtzumerken@gmail.com</a>&gt;
          wrote:<br>
        </div>
        <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex=
;border-left:1px solid rgb(204,204,204);padding-left:1ex"><br>
          <br>
          Am 24.08.21 um 15:36 schrieb Tom St Denis:<br>
          &gt; This new debugfs interface uses an IOCTL interface in
          order to pass<br>
          &gt; along state information like SRBM and GRBM bank
          switching.=C2=A0 This<br>
          &gt; new interface also allows a full 32-bit MMIO address
          range which<br>
          &gt; the previous didn&#39;t.=C2=A0 With this new design we have =
room
          to grow<br>
          &gt; the flexibility of the file as need be.<br>
          &gt;<br>
          &gt; (v2): Move read/write to .read/.write, fix style, add
          comment<br>
          &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 for IOCTL data structure<br>
          &gt;<br>
          &gt; Signed-off-by: Tom St Denis &lt;<a href=3D"mailto:tom.stdeni=
s@amd.com" target=3D"_blank">tom.stdenis@amd.com</a>&gt;<br>
          &gt; ---<br>
          &gt;=C2=A0 =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 16=
2
          ++++++++++++++++++++<br>
          &gt;=C2=A0 =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h |=C2=
=A0 32 ++++<br>
          &gt;=C2=A0 =C2=A02 files changed, 194 insertions(+)<br>
          &gt;<br>
          &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
          b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c<br>
          &gt; index 277128846dd1..8e8f5743c8f5 100644<br>
          &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c<br>
          &gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c<br>
          &gt; @@ -279,6 +279,156 @@ static ssize_t
          amdgpu_debugfs_regs_write(struct file *f, const char __user
          *buf,<br>
          &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return amdgpu_debugfs_process_reg_=
op(false, f,
          (char __user *)buf, size, pos);<br>
          &gt;=C2=A0 =C2=A0}<br>
          &gt;=C2=A0 =C2=A0<br>
          &gt; +static int amdgpu_debugfs_regs2_open(struct inode
          *inode, struct file *file)<br>
          &gt; +{<br>
          &gt; +=C2=A0 =C2=A0 =C2=A0struct amdgpu_debugfs_regs2_data *rd;<b=
r>
          &gt; +<br>
          &gt; +=C2=A0 =C2=A0 =C2=A0rd =3D kzalloc(sizeof *rd, GFP_KERNEL);=
<br>
          &gt; +=C2=A0 =C2=A0 =C2=A0if (!rd)<br>
          &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENO=
MEM;<br>
          &gt; +=C2=A0 =C2=A0 =C2=A0rd-&gt;adev =3D file_inode(file)-&gt;i_=
private;<br>
          &gt; +=C2=A0 =C2=A0 =C2=A0file-&gt;private_data =3D rd;<br>
          &gt; +<br>
          &gt; +=C2=A0 =C2=A0 =C2=A0return 0;<br>
          &gt; +}<br>
          &gt; +<br>
          &gt; +static int amdgpu_debugfs_regs2_release(struct inode
          *inode, struct file *file)<br>
          &gt; +{<br>
          &gt; +=C2=A0 =C2=A0 =C2=A0kfree(file-&gt;private_data);<br>
          &gt; +=C2=A0 =C2=A0 =C2=A0return 0;<br>
          &gt; +}<br>
          &gt; +<br>
          &gt; +static ssize_t amdgpu_debugfs_regs2_op(struct file *f,
          char __user *buf, size_t size, int write_en)<br>
          &gt; +{<br>
          &gt; +=C2=A0 =C2=A0 =C2=A0struct amdgpu_debugfs_regs2_data *rd =
=3D
          f-&gt;private_data;<br>
          &gt; +=C2=A0 =C2=A0 =C2=A0struct amdgpu_device *adev =3D rd-&gt;a=
dev;<br>
          &gt; +=C2=A0 =C2=A0 =C2=A0ssize_t result =3D 0;<br>
          &gt; +=C2=A0 =C2=A0 =C2=A0int r;<br>
          &gt; +=C2=A0 =C2=A0 =C2=A0uint32_t value;<br>
          &gt; +<br>
          &gt; +=C2=A0 =C2=A0 =C2=A0if (size &amp; 0x3 || rd-&gt;state.offs=
et &amp;
          0x3)<br>
          &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EIN=
VAL;<br>
          &gt; +<br>
          &gt; +=C2=A0 =C2=A0 =C2=A0if (rd-&gt;state.id.use_grbm) {<br>
          &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (rd-&gt;=
<a href=3D"http://state.id.grbm.se" rel=3D"noreferrer" target=3D"_blank">st=
ate.id.grbm.se</a>
          =3D=3D 0x3FF)<br>
          &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0rd-&gt;<a href=3D"http://state.id.grbm.se" rel=3D"noreferr=
er" target=3D"_blank">state.id.grbm.se</a>
          =3D 0xFFFFFFFF;<br>
          &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (rd-&gt;=
<a href=3D"http://state.id.grbm.sh" rel=3D"noreferrer" target=3D"_blank">st=
ate.id.grbm.sh</a>
          =3D=3D 0x3FF)<br>
          &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0rd-&gt;<a href=3D"http://state.id.grbm.sh" rel=3D"noreferr=
er" target=3D"_blank">state.id.grbm.sh</a>
          =3D 0xFFFFFFFF;<br>
          &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (rd-&gt;=
state.id.grbm.instance =3D=3D 0x3FF)<br>
          &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0rd-&gt;state.id.grbm.instance =3D
          0xFFFFFFFF;<br>
          &gt; +=C2=A0 =C2=A0 =C2=A0}<br>
          &gt; +<br>
          &gt; +=C2=A0 =C2=A0 =C2=A0r =3D pm_runtime_get_sync(adev_to_drm(a=
dev)-&gt;dev);<br>
          &gt; +=C2=A0 =C2=A0 =C2=A0if (r &lt; 0) {<br>
          &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
          =C2=A0pm_runtime_put_autosuspend(adev_to_drm(adev)-&gt;dev);<br>
          &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return r;<b=
r>
          &gt; +=C2=A0 =C2=A0 =C2=A0}<br>
          &gt; +<br>
          &gt; +=C2=A0 =C2=A0 =C2=A0r =3D amdgpu_virt_enable_access_debugfs=
(adev);<br>
          &gt; +=C2=A0 =C2=A0 =C2=A0if (r &lt; 0) {<br>
          &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
          =C2=A0pm_runtime_put_autosuspend(adev_to_drm(adev)-&gt;dev);<br>
          &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return r;<b=
r>
          &gt; +=C2=A0 =C2=A0 =C2=A0}<br>
          &gt; +<br>
          &gt; +=C2=A0 =C2=A0 =C2=A0if (rd-&gt;state.id.use_grbm) {<br>
          &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if ((rd-&gt=
;<a href=3D"http://state.id.grbm.sh" rel=3D"noreferrer" target=3D"_blank">s=
tate.id.grbm.sh</a>
          !=3D 0xFFFFFFFF &amp;&amp; rd-&gt;<a href=3D"http://state.id.grbm=
.sh" rel=3D"noreferrer" target=3D"_blank">state.id.grbm.sh</a>
          &gt;=3D adev-&gt;gfx.config.max_sh_per_se) ||<br>
          &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0(rd-&gt;<a href=3D"http://state.id.grbm.se" rel=3D"noreferrer" target=3D=
"_blank">state.id.grbm.se</a>
          !=3D 0xFFFFFFFF &amp;&amp; rd-&gt;<a href=3D"http://state.id.grbm=
.se" rel=3D"noreferrer" target=3D"_blank">state.id.grbm.se</a>
          &gt;=3D adev-&gt;gfx.config.max_shader_engines)) {<br>
          &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0
          =C2=A0pm_runtime_mark_last_busy(adev_to_drm(adev)-&gt;dev);<br>
          &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0
          =C2=A0pm_runtime_put_autosuspend(adev_to_drm(adev)-&gt;dev);<br>
          &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0
          =C2=A0amdgpu_virt_disable_access_debugfs(adev);<br>
          &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0return -EINVAL;<br>
          &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
          &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mutex_lock(=
&amp;adev-&gt;grbm_idx_mutex);<br>
          &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0amdgpu_gfx_=
select_se_sh(adev, rd-&gt;<a href=3D"http://state.id.grbm.se" rel=3D"norefe=
rrer" target=3D"_blank">state.id.grbm.se</a>,<br>
          &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
          =C2=A0 =C2=A0 =C2=A0rd-&gt;<a href=3D"http://state.id.grbm.sh" re=
l=3D"noreferrer" target=3D"_blank">state.id.grbm.sh</a>,<br>
          &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
          =C2=A0 =C2=A0 =C2=A0rd-&gt;state.id.grbm.instance);<br>
          &gt; +=C2=A0 =C2=A0 =C2=A0}<br>
          &gt; +<br>
          &gt; +=C2=A0 =C2=A0 =C2=A0if (rd-&gt;state.id.use_srbm) {<br>
          &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mutex_lock(=
&amp;adev-&gt;srbm_mutex);<br>
          &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0amdgpu_gfx_=
select_me_pipe_q(adev, rd-&gt;<a href=3D"http://state.id.srbm.me" rel=3D"no=
referrer" target=3D"_blank">state.id.srbm.me</a>,
          rd-&gt;state.id.srbm.pipe,<br>
          &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
          =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rd-&gt;state.id.s=
rbm.queue,
          rd-&gt;state.id.srbm.vmid);<br>
          &gt; +=C2=A0 =C2=A0 =C2=A0}<br>
          &gt; +<br>
          &gt; +=C2=A0 =C2=A0 =C2=A0if (rd-&gt;state.id.pg_lock)<br>
          &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mutex_lock(=
&amp;adev-&gt;pm.mutex);<br>
          &gt; +<br>
          &gt; +=C2=A0 =C2=A0 =C2=A0while (size) {<br>
          &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!write_=
en) {<br>
          &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0value =3D RREG32(rd-&gt;state.offset
          &gt;&gt; 2);<br>
          &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0r =3D put_user(value, (uint32_t
          *)buf);<br>
          &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br=
>
          &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0r =3D get_user(value, (uint32_t
          *)buf);<br>
          &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0if (!r)<br>
          &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
          =C2=A0amdgpu_mm_wreg_mmio_rlc(adev, rd-&gt;state.offset &gt;&gt; =
2,
          value);<br>
          &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
          &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (r) {<br=
>
          &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0result =3D r;<br>
          &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0goto end;<br>
          &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
          &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rd-&gt;stat=
e.offset +=3D 4;<br>
          &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0size -=3D 4=
;<br>
          &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0result +=3D=
 4;<br>
          &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0buf +=3D 4;=
<br>
          &gt; +=C2=A0 =C2=A0 =C2=A0}<br>
          &gt; +end:<br>
          &gt; +=C2=A0 =C2=A0 =C2=A0if (rd-&gt;state.id.use_grbm) {<br>
          &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0amdgpu_gfx_=
select_se_sh(adev, 0xffffffff,
          0xffffffff, 0xffffffff);<br>
          &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mutex_unloc=
k(&amp;adev-&gt;grbm_idx_mutex);<br>
          &gt; +=C2=A0 =C2=A0 =C2=A0}<br>
          &gt; +<br>
          &gt; +=C2=A0 =C2=A0 =C2=A0if (rd-&gt;state.id.use_srbm) {<br>
          &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0amdgpu_gfx_=
select_me_pipe_q(adev, 0, 0, 0,
          0);<br>
          &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mutex_unloc=
k(&amp;adev-&gt;srbm_mutex);<br>
          &gt; +=C2=A0 =C2=A0 =C2=A0}<br>
          &gt; +<br>
          &gt; +=C2=A0 =C2=A0 =C2=A0if (rd-&gt;state.id.pg_lock)<br>
          &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mutex_unloc=
k(&amp;adev-&gt;pm.mutex);<br>
          &gt; +<br>
          &gt; +=C2=A0 =C2=A0 =C2=A0// in umr (the likely user of this) fla=
gs are set
          per file operation<br>
          &gt; +=C2=A0 =C2=A0 =C2=A0// which means they&#39;re never &quot;=
unset&quot; explicitly.=C2=A0
          To avoid breaking<br>
          &gt; +=C2=A0 =C2=A0 =C2=A0// this convention we unset the flags a=
fter each
          operation<br>
          &gt; +=C2=A0 =C2=A0 =C2=A0// flags are for a single call (need to=
 be set for
          every read/write)<br>
          &gt; +=C2=A0 =C2=A0 =C2=A0rd-&gt;state.id.use_grbm =3D 0;<br>
          &gt; +=C2=A0 =C2=A0 =C2=A0rd-&gt;state.id.use_srbm =3D 0;<br>
          &gt; +=C2=A0 =C2=A0 =C2=A0rd-&gt;state.id.pg_lock=C2=A0 =3D 0;<br=
>
          &gt; +<br>
          &gt; +=C2=A0 =C2=A0
          =C2=A0pm_runtime_mark_last_busy(adev_to_drm(adev)-&gt;dev);<br>
          &gt; +=C2=A0 =C2=A0
          =C2=A0pm_runtime_put_autosuspend(adev_to_drm(adev)-&gt;dev);<br>
          &gt; +<br>
          &gt; +=C2=A0 =C2=A0 =C2=A0amdgpu_virt_disable_access_debugfs(adev=
);<br>
          &gt; +=C2=A0 =C2=A0 =C2=A0return result;<br>
          &gt; +}<br>
          &gt; +<br>
          &gt; +static long amdgpu_debugfs_regs2_ioctl(struct file *f,
          unsigned int cmd, unsigned long data)<br>
          &gt; +{<br>
          &gt; +=C2=A0 =C2=A0 =C2=A0struct amdgpu_debugfs_regs2_data *rd =
=3D
          f-&gt;private_data;<br>
          &gt; +<br>
          &gt; +=C2=A0 =C2=A0 =C2=A0switch (cmd) {<br>
          &gt; +=C2=A0 =C2=A0 =C2=A0case AMDGPU_DEBUGFS_REGS2_IOC_SET_STATE=
:<br>
          &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (copy_fr=
om_user(&amp;rd-&gt;<a href=3D"http://state.id" rel=3D"noreferrer" target=
=3D"_blank">state.id</a>, (struct
          amdgpu_debugfs_regs2_iocdata *)data, sizeof rd-&gt;<a href=3D"htt=
p://state.id" rel=3D"noreferrer" target=3D"_blank">state.id</a>))<br>
          &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0return -EINVAL;<br>
          &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
          &gt; +=C2=A0 =C2=A0 =C2=A0default:<br>
          &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EIN=
VAL;<br>
          &gt; +=C2=A0 =C2=A0 =C2=A0}<br>
          &gt; +=C2=A0 =C2=A0 =C2=A0return 0;<br>
          &gt; +}<br>
          &gt; +<br>
          &gt; +static ssize_t amdgpu_debugfs_regs2_read(struct file *f,
          char __user *buf, size_t size, loff_t *pos)<br>
          &gt; +{<br>
          &gt; +=C2=A0 =C2=A0 =C2=A0struct amdgpu_debugfs_regs2_data *rd =
=3D
          f-&gt;private_data;<br>
          &gt; +=C2=A0 =C2=A0 =C2=A0rd-&gt;state.offset =3D *pos;<br>
          &gt; +=C2=A0 =C2=A0 =C2=A0return amdgpu_debugfs_regs2_op(f, buf, =
size, 0);<br>
          &gt; +}<br>
          &gt; +<br>
          &gt; +static ssize_t amdgpu_debugfs_regs2_write(struct file
          *f, const char __user *buf, size_t size, loff_t *pos)<br>
          &gt; +{<br>
          &gt; +=C2=A0 =C2=A0 =C2=A0struct amdgpu_debugfs_regs2_data *rd =
=3D
          f-&gt;private_data;<br>
          &gt; +=C2=A0 =C2=A0 =C2=A0rd-&gt;state.offset =3D *pos;<br>
          &gt; +=C2=A0 =C2=A0 =C2=A0return amdgpu_debugfs_regs2_op(f, (char=
 __user
          *)buf, size, 1);<br>
          &gt; +}<br>
          &gt; +<br>
          &gt;=C2=A0 =C2=A0<br>
          &gt;=C2=A0 =C2=A0/**<br>
          &gt;=C2=A0 =C2=A0 * amdgpu_debugfs_regs_pcie_read - Read from a P=
CIE
          register<br>
          &gt; @@ -1091,6 +1241,16 @@ static ssize_t
          amdgpu_debugfs_gfxoff_read(struct file *f, char __user *buf,<br>
          &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return result;<br>
          &gt;=C2=A0 =C2=A0}<br>
          &gt;=C2=A0 =C2=A0<br>
          &gt; +static const struct file_operations
          amdgpu_debugfs_regs2_fops =3D {<br>
          &gt; +=C2=A0 =C2=A0 =C2=A0.owner =3D THIS_MODULE,<br>
          &gt; +=C2=A0 =C2=A0 =C2=A0.unlocked_ioctl =3D amdgpu_debugfs_regs=
2_ioctl,<br>
          &gt; +=C2=A0 =C2=A0 =C2=A0.read =3D amdgpu_debugfs_regs2_read,<br=
>
          &gt; +=C2=A0 =C2=A0 =C2=A0.write =3D amdgpu_debugfs_regs2_write,<=
br>
          &gt; +=C2=A0 =C2=A0 =C2=A0.open =3D amdgpu_debugfs_regs2_open,<br=
>
          &gt; +=C2=A0 =C2=A0 =C2=A0.release =3D amdgpu_debugfs_regs2_relea=
se,<br>
          &gt; +=C2=A0 =C2=A0 =C2=A0.llseek =3D default_llseek<br>
          &gt; +};<br>
          &gt; +<br>
          &gt;=C2=A0 =C2=A0static const struct file_operations
          amdgpu_debugfs_regs_fops =3D {<br>
          &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0.owner =3D THIS_MODULE,<br>
          &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0.read =3D amdgpu_debugfs_regs_read=
,<br>
          &gt; @@ -1148,6 +1308,7 @@ static const struct file_operations
          amdgpu_debugfs_gfxoff_fops =3D {<br>
          &gt;=C2=A0 =C2=A0<br>
          &gt;=C2=A0 =C2=A0static const struct file_operations *debugfs_reg=
s[] =3D {<br>
          &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;amdgpu_debugfs_regs_fops,<br>
          &gt; +=C2=A0 =C2=A0 =C2=A0&amp;amdgpu_debugfs_regs2_fops,<br>
          &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;amdgpu_debugfs_regs_didt_fops=
,<br>
          &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;amdgpu_debugfs_regs_pcie_fops=
,<br>
          &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;amdgpu_debugfs_regs_smc_fops,=
<br>
          &gt; @@ -1160,6 +1321,7 @@ static const struct file_operations
          *debugfs_regs[] =3D {<br>
          &gt;=C2=A0 =C2=A0<br>
          &gt;=C2=A0 =C2=A0static const char *debugfs_regs_names[] =3D {<br=
>
          &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;amdgpu_regs&quot;,<br>
          &gt; +=C2=A0 =C2=A0 =C2=A0&quot;amdgpu_regs2&quot;,<br>
          &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;amdgpu_regs_didt&quot;,<br>
          &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;amdgpu_regs_pcie&quot;,<br>
          &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;amdgpu_regs_smc&quot;,<br>
          &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
          b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h<br>
          &gt; index 141a8474e24f..ec044df5d428 100644<br>
          &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h<br>
          &gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h<br>
          &gt; @@ -22,6 +22,8 @@<br>
          &gt;=C2=A0 =C2=A0 * OTHER DEALINGS IN THE SOFTWARE.<br>
          &gt;=C2=A0 =C2=A0 *<br>
          &gt;=C2=A0 =C2=A0 */<br>
          &gt; +#include &lt;linux/ioctl.h&gt;<br>
          &gt; +#include &lt;uapi/drm/amdgpu_drm.h&gt;<br>
          &gt;=C2=A0 =C2=A0<br>
          &gt;=C2=A0 =C2=A0/*<br>
          &gt;=C2=A0 =C2=A0 * Debugfs<br>
          &gt; @@ -38,3 +40,33 @@ void amdgpu_debugfs_fence_init(struct
          amdgpu_device *adev);<br>
          &gt;=C2=A0 =C2=A0void amdgpu_debugfs_firmware_init(struct amdgpu_=
device
          *adev);<br>
          &gt;=C2=A0 =C2=A0void amdgpu_debugfs_gem_init(struct amdgpu_devic=
e
          *adev);<br>
          &gt;=C2=A0 =C2=A0int amdgpu_debugfs_wait_dump(struct amdgpu_devic=
e
          *adev);<br>
          &gt; +<br>
          &gt; +/*<br>
          &gt; + * MMIO debugfs IOCTL structure<br>
          &gt; + */<br>
          &gt; +struct amdgpu_debugfs_regs2_iocdata {<br>
          &gt; +=C2=A0 =C2=A0 =C2=A0__u8 use_srbm, use_grbm, pg_lock;<br>
          <br>
          You should consider using u32 here as well or add explicitly
          padding.<br>
          <br>
          &gt; +=C2=A0 =C2=A0 =C2=A0struct {<br>
          &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0__u32 se, s=
h, instance;<br>
          &gt; +=C2=A0 =C2=A0 =C2=A0} grbm;<br>
          &gt; +=C2=A0 =C2=A0 =C2=A0struct {<br>
          &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0__u32 me, p=
ipe, queue, vmid;<br>
          &gt; +=C2=A0 =C2=A0 =C2=A0} srbm;<br>
          &gt; +};<br>
          &gt; +<br>
          &gt; +/*<br>
          &gt; + * MMIO debugfs state data (per file* handle)<br>
          &gt; + */<br>
          &gt; +struct amdgpu_debugfs_regs2_data {<br>
          &gt; +=C2=A0 =C2=A0 =C2=A0struct amdgpu_device *adev;<br>
          &gt; +=C2=A0 =C2=A0 =C2=A0struct {<br>
          &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct amdg=
pu_debugfs_regs2_iocdata id;<br>
          &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0__u32 offse=
t;<br>
          <br>
          What is the offset good for here?<br>
          <br>
          Regards,<br>
          Christian.<br>
          <br>
          &gt; +=C2=A0 =C2=A0 =C2=A0} state;<br>
          &gt; +};<br>
          &gt; +<br>
          &gt; +enum AMDGPU_DEBUGFS_REGS2_CMDS {<br>
          &gt; +=C2=A0 =C2=A0 =C2=A0AMDGPU_DEBUGFS_REGS2_CMD_SET_STATE=3D0,=
<br>
          &gt; +};<br>
          &gt; +<br>
          &gt; +#define AMDGPU_DEBUGFS_REGS2_IOC_SET_STATE _IOWR(0x20,
          AMDGPU_DEBUGFS_REGS2_CMD_SET_STATE, struct
          amdgpu_debugfs_regs2_iocdata)<br>
          <br>
        </blockquote>
      </div>
    </blockquote>
    <br>
  </div>

</blockquote></div>

--000000000000fee71205ca60376f--
