Return-Path: <SRS0=c7t5=NP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B0F9C4338F
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Aug 2021 16:00:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5289460462
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Aug 2021 16:00:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5289460462
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DFF9C89B29;
	Tue, 24 Aug 2021 16:00:58 +0000 (UTC)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E813289B29
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Aug 2021 16:00:57 +0000 (UTC)
Received: by mail-ot1-x335.google.com with SMTP id
 l7-20020a0568302b0700b0051c0181deebso15647083otv.12
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Aug 2021 09:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=YBLAYZsg2IFNL2mhJVOnd5oocwM2ljiObWTT1lU+F8g=;
 b=SIy+NGwyJCv/lm0wVGeIyQO66k1kEXILXoAPh8hLIlk3tdnJFZsnWTP9cx79XQHXMv
 LFcqwfkCKipDJbPVfo5mBFKbzdG8c/2Lu6UyQH2FwBj2vqwvzl2IQCn7T1FRY7wW4dks
 AjtvVindckt6oap+df0s3gIos4Z5ZRpkz1fdNLjFNEiISSWTeofZU29/IgIgMXUce5GH
 4DOJx80EFO/bCqd7o4FudyDTEcEMr/mTRJu+0rvNdwPO0SX99uFvgX9oewXeRQpPs3Uc
 iE0NhHgfFdBJ2YW/fNY3PC6SvguYaLLTT12AU8RoGCbAkM9ztgXNiLOE8RnmzlgEs6uM
 BGYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=YBLAYZsg2IFNL2mhJVOnd5oocwM2ljiObWTT1lU+F8g=;
 b=iqtneWW2QunqXfvTeiz2k+5GWLOkKSjBTfgu8vUKpz5M1m8xX6tVhV5MILSsYnVu2m
 4kUftmNxlPfeRmm5g4wF6ibskH2oS/mnmqhBJKecgKq6u284v0h4onMBT7twvcA5bR6X
 sgY8OYXBW0IGpfcqA+ewOOQ3NGqyQPqUdRBUlRCZSEbkFwwewFwHMCyalR6WZ5Wa++pG
 kd2i+/tG7e/JHMZ2zCbyoQtKn/O/IIiuGCJqPI2RSWCP4SxBl4e1lTYAHRqR3SX+OC31
 JojyiwDKiqrTJkJPtCDnApAcRO3p60aaLWbWeNVAaZEK576UAFgTdILU31kmKD4ygwwC
 bb1A==
X-Gm-Message-State: AOAM53147loOhVWjF5SEQshp7orpKZJyxaQiZBqnhvDPDx38beDHv5eI
 NnX4IuCdpzlgUzFEEqboqqzOB+BaFflkcgdl+55oHnKZ
X-Google-Smtp-Source: ABdhPJw0QQrBcmqHnkA1VxNFhhg9jQ9ygGfjivz9N8pC/Y+oyCvd5JoNAdb6ZWbzGOshF3LTUNpFzEsjRq9Rh5enzmc=
X-Received: by 2002:a05:6808:483:: with SMTP id z3mr3238112oid.5.1629820857173; 
 Tue, 24 Aug 2021 09:00:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210824121618.99839-1-tom.stdenis@amd.com>
 <f0ada58f-f6c8-89f1-3036-065c908696b2@gmail.com>
 <DM6PR12MB35475954BCF1B73048B662FEF7C59@DM6PR12MB3547.namprd12.prod.outlook.com>
 <baeaf8da-6c4a-516b-823e-224a0ac80471@gmail.com>
 <CAAzXoRKWy74Wst_1br+N37dkO+5Uode4+zwQpEtM9su+JA9oLg@mail.gmail.com>
 <8d7546ee-0b10-8505-ee4e-bdf4b41b630f@gmail.com>
 <CAAzXoR+fiXObbWyk3-2SWPKtomaA+cV9sPPMSXSrCazn96iaCw@mail.gmail.com>
In-Reply-To: <CAAzXoR+fiXObbWyk3-2SWPKtomaA+cV9sPPMSXSrCazn96iaCw@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 24 Aug 2021 12:00:46 -0400
Message-ID: <CADnq5_Pvr2Fe=YyzbWQHskFfyFem+wFHFJPWTPYCeZKLNf8y3A@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/amdgpu: New debugfs interface for MMIO registers
To: Tom St Denis <tstdenis82@gmail.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>, 
 "StDenis, Tom" <Tom.StDenis@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
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

Also, please use C style comments.

Alex

On Tue, Aug 24, 2021 at 9:28 AM Tom St Denis <tstdenis82@gmail.com> wrote:
>
> hehehe I just moved it to uapi... No worries, you're the maintainer, I'll=
 move it back before posting v2.
>
> Cheers,
> Tom
>
> On Tue, Aug 24, 2021 at 9:22 AM Christian K=C3=B6nig <ckoenig.leichtzumer=
ken@gmail.com> wrote:
>>
>> Am 24.08.21 um 14:42 schrieb Tom St Denis:
>>
>> The IOCTL data is in the debugfs header as it is.  I could move that to =
the amdgpu_drm.h and include it from amdgpu_debugfs.h.
>>
>>
>> Na, keep it like that and just add a comment.
>>
>> On second thought I don't want to raise any discussion on the mailing li=
st if we should have a debugfs structure in the UAPI headers.
>>
>> Christian.
>>
>>
>> I'll re-write the STATE IOCTL to use a struct and then test against what=
 I have in umr.
>>
>> Refactoring the read/write is trivial and I'll do that no problem (with =
style fixes).
>>
>> Cheers,
>> Tom
>>
>> On Tue, Aug 24, 2021 at 8:34 AM Christian K=C3=B6nig <ckoenig.leichtzume=
rken@gmail.com> wrote:
>>>
>>> Am 24.08.21 um 14:27 schrieb StDenis, Tom:
>>> > [AMD Official Use Only]
>>> >
>>> > What do you mean a "shared header?"  How would they be shared between=
 kernel and user?
>>>
>>> Somewhere in the include/uapi/drm/ folder I think. Either add that to
>>> amdgpu_drm.h or maybe amdgpu_debugfs.h?
>>>
>>> Or just keep it as a structure in amdgpu_debugfs.h with a comment that
>>> it is used for an IOCTL.
>>>
>>> Just not something hard coded like first byte is this, second that etc.=
...
>>>
>>> > As for why not read/write.  Jus wanted to keep it simple.  It's not r=
eally performance bound.  umr never does reads/writes larger than 32-bits a=
nyways.  It doesn't have to be this way though but I figured the fewer LOC =
the better.
>>>
>>> I think it would be cleaner if we would have separate functions for thi=
s.
>>>
>>> As far as I can see you also don't need the dance with the power
>>> managerment etc for the IOCTL. It's just get_user() into your structure=
.
>>>
>>> BTW: In the kernel coding style put "switch" and "case" on the same
>>> column, otherwise checkpatch.pl might complain.
>>>
>>> Christian.
>>>
>>> >
>>> > Tom
>>> >
>>> > ________________________________________
>>> > From: Christian K=C3=B6nig <ckoenig.leichtzumerken@gmail.com>
>>> > Sent: Tuesday, August 24, 2021 08:20
>>> > To: StDenis, Tom; amd-gfx@lists.freedesktop.org
>>> > Subject: Re: [PATCH] drm/amd/amdgpu: New debugfs interface for MMIO r=
egisters
>>> >
>>> >
>>> >
>>> > Am 24.08.21 um 14:16 schrieb Tom St Denis:
>>> >> This new debugfs interface uses an IOCTL interface in order to pass
>>> >> along state information like SRBM and GRBM bank switching.  This
>>> >> new interface also allows a full 32-bit MMIO address range which
>>> >> the previous didn't.  With this new design we have room to grow
>>> >> the flexibility of the file as need be.
>>> >>
>>> >> Signed-off-by: Tom St Denis <tom.stdenis@amd.com>
>>> >> ---
>>> >>    drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 177 +++++++++++++++=
+++++
>>> >>    drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h |  32 ++++
>>> >>    2 files changed, 209 insertions(+)
>>> >>
>>> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/g=
pu/drm/amd/amdgpu/amdgpu_debugfs.c
>>> >> index 277128846dd1..ab2d92f84da5 100644
>>> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>> >> @@ -279,6 +279,173 @@ static ssize_t amdgpu_debugfs_regs_write(struc=
t file *f, const char __user *buf,
>>> >>        return amdgpu_debugfs_process_reg_op(false, f, (char __user *=
)buf, size, pos);
>>> >>    }
>>> >>
>>> >> +static int amdgpu_debugfs_regs2_open(struct inode *inode, struct fi=
le *file)
>>> >> +{
>>> >> +     struct amdgpu_debugfs_regs2_data *rd;
>>> >> +
>>> >> +     rd =3D kzalloc(sizeof *rd, GFP_KERNEL);
>>> >> +     if (!rd)
>>> >> +             return -ENOMEM;
>>> >> +     rd->adev =3D file_inode(file)->i_private;
>>> >> +     file->private_data =3D rd;
>>> >> +
>>> >> +     return 0;
>>> >> +}
>>> >> +
>>> >> +static int amdgpu_debugfs_regs2_release(struct inode *inode, struct=
 file *file)
>>> >> +{
>>> >> +     kfree(file->private_data);
>>> >> +     return 0;
>>> >> +}
>>> >> +
>>> >> +static int amdgpu_debugfs_regs2_op(struct file *f, char __user *buf=
, int write_en)
>>> >> +{
>>> >> +     struct amdgpu_debugfs_regs2_data *rd =3D f->private_data;
>>> >> +     struct amdgpu_device *adev =3D rd->adev;
>>> >> +     int result =3D 0, r;
>>> >> +     uint32_t value;
>>> >> +
>>> >> +     if (rd->state.offset & 0x3)
>>> >> +             return -EINVAL;
>>> >> +
>>> >> +     if (rd->state.use_grbm) {
>>> >> +             if (rd->state.grbm.se =3D=3D 0x3FF)
>>> >> +                     rd->state.grbm.se =3D 0xFFFFFFFF;
>>> >> +             if (rd->state.grbm.sh =3D=3D 0x3FF)
>>> >> +                     rd->state.grbm.sh =3D 0xFFFFFFFF;
>>> >> +             if (rd->state.grbm.instance =3D=3D 0x3FF)
>>> >> +                     rd->state.grbm.instance =3D 0xFFFFFFFF;
>>> >> +     }
>>> >> +
>>> >> +     r =3D pm_runtime_get_sync(adev_to_drm(adev)->dev);
>>> >> +     if (r < 0) {
>>> >> +             pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>>> >> +             return r;
>>> >> +     }
>>> >> +
>>> >> +     r =3D amdgpu_virt_enable_access_debugfs(adev);
>>> >> +     if (r < 0) {
>>> >> +             pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>>> >> +             return r;
>>> >> +     }
>>> >> +
>>> >> +     if (rd->state.use_grbm) {
>>> >> +             if ((rd->state.grbm.sh !=3D 0xFFFFFFFF && rd->state.gr=
bm.sh >=3D adev->gfx.config.max_sh_per_se) ||
>>> >> +                 (rd->state.grbm.se !=3D 0xFFFFFFFF && rd->state.gr=
bm.se >=3D adev->gfx.config.max_shader_engines)) {
>>> >> +                     pm_runtime_mark_last_busy(adev_to_drm(adev)->d=
ev);
>>> >> +                     pm_runtime_put_autosuspend(adev_to_drm(adev)->=
dev);
>>> >> +                     amdgpu_virt_disable_access_debugfs(adev);
>>> >> +                     return -EINVAL;
>>> >> +             }
>>> >> +             mutex_lock(&adev->grbm_idx_mutex);
>>> >> +             amdgpu_gfx_select_se_sh(adev, rd->state.grbm.se,
>>> >> +                                                             rd->st=
ate.grbm.sh,
>>> >> +                                                             rd->st=
ate.grbm.instance);
>>> >> +     } else if (rd->state.use_grbm) {
>>> >> +             mutex_lock(&adev->srbm_mutex);
>>> >> +             amdgpu_gfx_select_me_pipe_q(adev, rd->state.srbm.me, r=
d->state.srbm.pipe,
>>> >> +                                                                   =
  rd->state.srbm.queue, rd->state.srbm.vmid);
>>> >> +     }
>>> >> +
>>> >> +     if (rd->state.pg_lock)
>>> >> +             mutex_lock(&adev->pm.mutex);
>>> >> +
>>> >> +     if (!write_en) {
>>> >> +             value =3D RREG32(rd->state.offset >> 2);
>>> >> +             r =3D put_user(value, (uint32_t *)buf);
>>> >> +     } else {
>>> >> +             r =3D get_user(value, (uint32_t *)buf);
>>> >> +             if (!r)
>>> >> +                     amdgpu_mm_wreg_mmio_rlc(adev, rd->state.offset=
 >> 2, value);
>>> >> +     }
>>> >> +     if (r) {
>>> >> +             result =3D r;
>>> >> +             goto end;
>>> >> +     }
>>> >> +     result =3D 0;
>>> >> +end:
>>> >> +     if (rd->state.use_grbm) {
>>> >> +             amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff, =
0xffffffff);
>>> >> +             mutex_unlock(&adev->grbm_idx_mutex);
>>> >> +     } else if (rd->state.use_srbm) {
>>> >> +             amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, 0);
>>> >> +             mutex_unlock(&adev->srbm_mutex);
>>> >> +     }
>>> >> +
>>> >> +     if (rd->state.pg_lock)
>>> >> +             mutex_unlock(&adev->pm.mutex);
>>> >> +
>>> >> +     // in umr (the likely user of this) flags are set per file ope=
ration
>>> >> +     // which means they're never "unset" explicitly.  To avoid bre=
aking
>>> >> +     // this convention we unset the flags after each operation
>>> >> +     // flags are for a single call (need to be set for every read/=
write)
>>> >> +     rd->state.use_grbm =3D 0;
>>> >> +     rd->state.use_srbm =3D 0;
>>> >> +     rd->state.pg_lock  =3D 0;
>>> >> +
>>> >> +     pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
>>> >> +     pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>>> >> +
>>> >> +     amdgpu_virt_disable_access_debugfs(adev);
>>> >> +     return result;
>>> >> +}
>>> >> +
>>> >> +static long amdgpu_debugfs_regs2_ioctl(struct file *f, unsigned int=
 cmd, unsigned long data)
>>> >> +{
>>> >> +     struct amdgpu_debugfs_regs2_data *rd =3D f->private_data;
>>> >> +     unsigned char st[32], v;
>>> >> +     int r, x;
>>> >> +
>>> >> +     // always read first 4 bytes of data
>>> >> +     for (x =3D 0; x < 4; x++) {
>>> >> +             if ((r =3D get_user(v, (unsigned char *)data))) {
>>> >> +                     return r;
>>> >> +             }
>>> >> +             ++data;
>>> >> +             st[x] =3D v;
>>> >> +     }
>>> >> +
>>> >> +     // first 4 bytes are offset
>>> >> +     rd->state.offset =3D ((u32)st[0]) | ((u32)st[1] << 8) |
>>> >> +                                        ((u32)st[2] << 16) | ((u32)=
st[3] << 24);
>>> >> +
>>> >> +     switch (cmd) {
>>> >> +             case AMDGPU_DEBUGFS_REGS2_IOC_SET_STATE:
>>> >> +                     for (x =3D 4; x < 32; x++) {
>>> >> +                             if ((r =3D get_user(v, (unsigned char =
*)data))) {
>>> >> +                                     return r;
>>> >> +                             }
>>> >> +                             ++data;
>>> >> +                             st[x] =3D v;
>>> >> +                     }
>>> >> +
>>> >> +                     // next byte contains the flag
>>> >> +                     // we only consume the remainder of the state =
if bit 1 is set
>>> >> +                     // this allows the subsequent read/write
>>> >> +                     rd->state.use_grbm =3D (st[4] & 1) ? 1 : 0;
>>> >> +                     rd->state.use_srbm =3D (st[4] & 2) ? 1 : 0;
>>> >> +                     rd->state.pg_lock  =3D (st[4] & 4) ? 1 : 0;
>>> >> +
>>> >> +                     // next 6 bytes are grbm data
>>> >> +                     rd->state.grbm.se       =3D  ((u32)st[5]) | ((=
u32)st[6] << 8);
>>> >> +                     rd->state.grbm.sh       =3D  ((u32)st[7]) | ((=
u32)st[8] << 8);
>>> >> +                     rd->state.grbm.instance =3D  ((u32)st[9]) | ((=
u32)st[10] << 8);
>>> >> +
>>> >> +                     // next 8 are srbm data
>>> >> +                     rd->state.srbm.me       =3D  ((u32)st[11]) | (=
(u32)st[12] << 8);
>>> >> +                     rd->state.srbm.pipe     =3D  ((u32)st[13]) | (=
(u32)st[14] << 8);
>>> >> +                     rd->state.srbm.queue    =3D  ((u32)st[15]) | (=
(u32)st[16] << 8);
>>> >> +                     rd->state.srbm.vmid     =3D  ((u32)st[17]) | (=
(u32)st[18] << 8);
>>> >> +                     break;
>>> >> +             case AMDGPU_DEBUGFS_REGS2_IOC_READ:
>>> >> +                     return amdgpu_debugfs_regs2_op(f, (char __user=
 *)data, 0);
>>> >> +             case AMDGPU_DEBUGFS_REGS2_IOC_WRITE:
>>> >> +                     return amdgpu_debugfs_regs2_op(f, (char __user=
 *)data, 1);
>>> >> +             default:
>>> >> +                     return -EINVAL;
>>> >> +     }
>>> >> +     return 0;
>>> >> +}
>>> >>
>>> >>    /**
>>> >>     * amdgpu_debugfs_regs_pcie_read - Read from a PCIE register
>>> >> @@ -1091,6 +1258,14 @@ static ssize_t amdgpu_debugfs_gfxoff_read(str=
uct file *f, char __user *buf,
>>> >>        return result;
>>> >>    }
>>> >>
>>> >> +static const struct file_operations amdgpu_debugfs_regs2_fops =3D {
>>> >> +     .owner =3D THIS_MODULE,
>>> >> +     .unlocked_ioctl =3D amdgpu_debugfs_regs2_ioctl,
>>> >> +     .open =3D amdgpu_debugfs_regs2_open,
>>> >> +     .release =3D amdgpu_debugfs_regs2_release,
>>> >> +     .llseek =3D default_llseek
>>> >> +};
>>> >> +
>>> >>    static const struct file_operations amdgpu_debugfs_regs_fops =3D =
{
>>> >>        .owner =3D THIS_MODULE,
>>> >>        .read =3D amdgpu_debugfs_regs_read,
>>> >> @@ -1148,6 +1323,7 @@ static const struct file_operations amdgpu_deb=
ugfs_gfxoff_fops =3D {
>>> >>
>>> >>    static const struct file_operations *debugfs_regs[] =3D {
>>> >>        &amdgpu_debugfs_regs_fops,
>>> >> +     &amdgpu_debugfs_regs2_fops,
>>> >>        &amdgpu_debugfs_regs_didt_fops,
>>> >>        &amdgpu_debugfs_regs_pcie_fops,
>>> >>        &amdgpu_debugfs_regs_smc_fops,
>>> >> @@ -1160,6 +1336,7 @@ static const struct file_operations *debugfs_r=
egs[] =3D {
>>> >>
>>> >>    static const char *debugfs_regs_names[] =3D {
>>> >>        "amdgpu_regs",
>>> >> +     "amdgpu_regs2",
>>> >>        "amdgpu_regs_didt",
>>> >>        "amdgpu_regs_pcie",
>>> >>        "amdgpu_regs_smc",
>>> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h b/drivers/g=
pu/drm/amd/amdgpu/amdgpu_debugfs.h
>>> >> index 141a8474e24f..04c81cd4bcc7 100644
>>> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
>>> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
>>> >> @@ -22,6 +22,7 @@
>>> >>     * OTHER DEALINGS IN THE SOFTWARE.
>>> >>     *
>>> >>     */
>>> >> +#include <linux/ioctl.h>
>>> >>
>>> >>    /*
>>> >>     * Debugfs
>>> >> @@ -38,3 +39,34 @@ void amdgpu_debugfs_fence_init(struct amdgpu_devi=
ce *adev);
>>> >>    void amdgpu_debugfs_firmware_init(struct amdgpu_device *adev);
>>> >>    void amdgpu_debugfs_gem_init(struct amdgpu_device *adev);
>>> >>    int amdgpu_debugfs_wait_dump(struct amdgpu_device *adev);
>>> >> +
>>> >> +struct amdgpu_debugfs_regs2_data {
>>> >> +     struct amdgpu_device *adev;
>>> >> +     struct {
>>> >> +             // regs state
>>> >> +             int use_srbm,
>>> >> +                 use_grbm,
>>> >> +                 pg_lock;
>>> >> +             struct {
>>> >> +                     u32 se, sh, instance;
>>> >> +             } grbm;
>>> >> +             struct {
>>> >> +                     u32 me, pipe, queue, vmid;
>>> >> +             } srbm;
>>> >> +             u32 offset;
>>> >> +     } state;
>>> >> +};
>>> > This stuff needs to be in some shared header then.
>>> >
>>> >> +
>>> >> +enum AMDGPU_DEBUGFS_REGS2_CMDS {
>>> >> +     AMDGPU_DEBUGFS_REGS2_CMD_SET_STATE=3D0,
>>> >> +     AMDGPU_DEBUGFS_REGS2_CMD_READ,
>>> >> +     AMDGPU_DEBUGFS_REGS2_CMD_WRITE,
>>> > Why not just using the normal read and write functions?
>>> >
>>> > Christian.
>>> >
>>> >> +};
>>> >> +
>>> >> +struct amdgpu_debugfs_regs2_iocdata {
>>> >> +     unsigned char t[32];
>>> >> +};
>>> >> +
>>> >> +#define AMDGPU_DEBUGFS_REGS2_IOC_SET_STATE _IOWR(0x20, AMDGPU_DEBUG=
FS_REGS2_CMD_SET_STATE, struct amdgpu_debugfs_regs2_iocdata)
>>> >> +#define AMDGPU_DEBUGFS_REGS2_IOC_READ _IOWR(0x20, AMDGPU_DEBUGFS_RE=
GS2_CMD_WRITE, struct amdgpu_debugfs_regs2_iocdata)
>>> >> +#define AMDGPU_DEBUGFS_REGS2_IOC_WRITE _IOWR(0x20, AMDGPU_DEBUGFS_R=
EGS2_CMD_READ, struct amdgpu_debugfs_regs2_iocdata)
>>>
>>
