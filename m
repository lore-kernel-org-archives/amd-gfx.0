Return-Path: <SRS0=c7t5=NP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFFF0C4338F
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Aug 2021 13:28:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B25E560FD8
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Aug 2021 13:28:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B25E560FD8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C6E1489C17;
	Tue, 24 Aug 2021 13:28:41 +0000 (UTC)
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com
 [IPv6:2607:f8b0:4864:20::92a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 227A689C17
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Aug 2021 13:28:41 +0000 (UTC)
Received: by mail-ua1-x92a.google.com with SMTP id j31so4606501uad.10
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Aug 2021 06:28:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=KRmcbttpDfWl/UGbIyadYIqaFk8LLayE0T5HOjOVdz4=;
 b=iNr5By9L9CqVcjgFZQpqea/grxDtxf/9YgnVAilpJU5MYdJdHYwtJNM5z5P3CI+2p2
 R6PC8dpjKUurU90nmrPp44pDAE14O8VnAtZj6VNCbx14mmKIN/DZsMMmUfN1oF7P92Kb
 3YUhah2aT4T402lp8DyEj9l8UJB28+O75REr425vOsScjts56wF6R0ZT05Vh6lldng+e
 bpPe/jy/ikpk6/2ugm6s9TIcJtmivvf8UmyZhCVlSjW70disWv0lO0iX89fHinaCKIn4
 Cu1UH2rdD+GwmIGJgwIAyCqYtXiIFdFDU25ZOHj5sIHO0bn/tGq68SljV2J7vbYXbv5c
 IzGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=KRmcbttpDfWl/UGbIyadYIqaFk8LLayE0T5HOjOVdz4=;
 b=gwJaErS3ptNPyOhXZGqCXPtelyahDnAGic0oiT34EtHJiEur+gGc0GtwelWsVg2tn7
 8pPEtLkqgMSgLmoagn8e3FWsVTL1iffG/YrUIm81CM1DrmKTNpP1ELKMktviGa25xjpf
 F60huSTrIwsFOkafyweo0Q64TI9AyQYJkZcSY1vtp6RyR5mRBdkVtQYv0exzgfCa60rk
 rvYuHi9ZmI17OLBPd+gBMJgy3IMLelxY8VymJgwPf6G8S8TIucTT3ItV0W4eVjUzQyTn
 r8lBrmvRXhzzlrVHPhdZ0dNIm/qeJAsu9XphuEmk8XStQtcVuSGaJvp48eSn7oE5HFtU
 owVQ==
X-Gm-Message-State: AOAM530gCNOqKvUD28uJtXcbKwzGT4IgfwiOYsTKtcZTVJ9IVE1WXFu9
 OVXWfYaAmLOZKNpmX2lJO9vcIwZCT14ZPpW1F2Q=
X-Google-Smtp-Source: ABdhPJw2trtePcuHs0P3J8uxlNhAsPRqWUpdM9HRZl3aNuGUq9p6F002Zd1JqzjM1KpnzcgljxJzE5X+AkJsqJqFmcc=
X-Received: by 2002:a05:6102:e96:: with SMTP id
 l22mr26964191vst.19.1629811716011; 
 Tue, 24 Aug 2021 06:28:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210824121618.99839-1-tom.stdenis@amd.com>
 <f0ada58f-f6c8-89f1-3036-065c908696b2@gmail.com>
 <DM6PR12MB35475954BCF1B73048B662FEF7C59@DM6PR12MB3547.namprd12.prod.outlook.com>
 <baeaf8da-6c4a-516b-823e-224a0ac80471@gmail.com>
 <CAAzXoRKWy74Wst_1br+N37dkO+5Uode4+zwQpEtM9su+JA9oLg@mail.gmail.com>
 <8d7546ee-0b10-8505-ee4e-bdf4b41b630f@gmail.com>
In-Reply-To: <8d7546ee-0b10-8505-ee4e-bdf4b41b630f@gmail.com>
From: Tom St Denis <tstdenis82@gmail.com>
Date: Tue, 24 Aug 2021 09:28:24 -0400
Message-ID: <CAAzXoR+fiXObbWyk3-2SWPKtomaA+cV9sPPMSXSrCazn96iaCw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/amdgpu: New debugfs interface for MMIO registers
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc: "StDenis, Tom" <Tom.StDenis@amd.com>, 
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/alternative; boundary="000000000000625db405ca4e1c1a"
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

--000000000000625db405ca4e1c1a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

hehehe I just moved it to uapi... No worries, you're the maintainer, I'll
move it back before posting v2.

Cheers,
Tom

On Tue, Aug 24, 2021 at 9:22 AM Christian K=C3=B6nig <
ckoenig.leichtzumerken@gmail.com> wrote:

> Am 24.08.21 um 14:42 schrieb Tom St Denis:
>
> The IOCTL data is in the debugfs header as it is.  I could move that to
> the amdgpu_drm.h and include it from amdgpu_debugfs.h.
>
>
> Na, keep it like that and just add a comment.
>
> On second thought I don't want to raise any discussion on the mailing lis=
t
> if we should have a debugfs structure in the UAPI headers.
>
> Christian.
>
>
> I'll re-write the STATE IOCTL to use a struct and then test against what =
I
> have in umr.
>
> Refactoring the read/write is trivial and I'll do that no problem (with
> style fixes).
>
> Cheers,
> Tom
>
> On Tue, Aug 24, 2021 at 8:34 AM Christian K=C3=B6nig <
> ckoenig.leichtzumerken@gmail.com> wrote:
>
>> Am 24.08.21 um 14:27 schrieb StDenis, Tom:
>> > [AMD Official Use Only]
>> >
>> > What do you mean a "shared header?"  How would they be shared between
>> kernel and user?
>>
>> Somewhere in the include/uapi/drm/ folder I think. Either add that to
>> amdgpu_drm.h or maybe amdgpu_debugfs.h?
>>
>> Or just keep it as a structure in amdgpu_debugfs.h with a comment that
>> it is used for an IOCTL.
>>
>> Just not something hard coded like first byte is this, second that etc..=
..
>>
>> > As for why not read/write.  Jus wanted to keep it simple.  It's not
>> really performance bound.  umr never does reads/writes larger than 32-bi=
ts
>> anyways.  It doesn't have to be this way though but I figured the fewer =
LOC
>> the better.
>>
>> I think it would be cleaner if we would have separate functions for this=
.
>>
>> As far as I can see you also don't need the dance with the power
>> managerment etc for the IOCTL. It's just get_user() into your structure.
>>
>> BTW: In the kernel coding style put "switch" and "case" on the same
>> column, otherwise checkpatch.pl might complain.
>>
>> Christian.
>>
>> >
>> > Tom
>> >
>> > ________________________________________
>> > From: Christian K=C3=B6nig <ckoenig.leichtzumerken@gmail.com>
>> > Sent: Tuesday, August 24, 2021 08:20
>> > To: StDenis, Tom; amd-gfx@lists.freedesktop.org
>> > Subject: Re: [PATCH] drm/amd/amdgpu: New debugfs interface for MMIO
>> registers
>> >
>> >
>> >
>> > Am 24.08.21 um 14:16 schrieb Tom St Denis:
>> >> This new debugfs interface uses an IOCTL interface in order to pass
>> >> along state information like SRBM and GRBM bank switching.  This
>> >> new interface also allows a full 32-bit MMIO address range which
>> >> the previous didn't.  With this new design we have room to grow
>> >> the flexibility of the file as need be.
>> >>
>> >> Signed-off-by: Tom St Denis <tom.stdenis@amd.com>
>> >> ---
>> >>    drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 177
>> ++++++++++++++++++++
>> >>    drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h |  32 ++++
>> >>    2 files changed, 209 insertions(+)
>> >>
>> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>> >> index 277128846dd1..ab2d92f84da5 100644
>> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>> >> @@ -279,6 +279,173 @@ static ssize_t amdgpu_debugfs_regs_write(struct
>> file *f, const char __user *buf,
>> >>        return amdgpu_debugfs_process_reg_op(false, f, (char __user
>> *)buf, size, pos);
>> >>    }
>> >>
>> >> +static int amdgpu_debugfs_regs2_open(struct inode *inode, struct fil=
e
>> *file)
>> >> +{
>> >> +     struct amdgpu_debugfs_regs2_data *rd;
>> >> +
>> >> +     rd =3D kzalloc(sizeof *rd, GFP_KERNEL);
>> >> +     if (!rd)
>> >> +             return -ENOMEM;
>> >> +     rd->adev =3D file_inode(file)->i_private;
>> >> +     file->private_data =3D rd;
>> >> +
>> >> +     return 0;
>> >> +}
>> >> +
>> >> +static int amdgpu_debugfs_regs2_release(struct inode *inode, struct
>> file *file)
>> >> +{
>> >> +     kfree(file->private_data);
>> >> +     return 0;
>> >> +}
>> >> +
>> >> +static int amdgpu_debugfs_regs2_op(struct file *f, char __user *buf,
>> int write_en)
>> >> +{
>> >> +     struct amdgpu_debugfs_regs2_data *rd =3D f->private_data;
>> >> +     struct amdgpu_device *adev =3D rd->adev;
>> >> +     int result =3D 0, r;
>> >> +     uint32_t value;
>> >> +
>> >> +     if (rd->state.offset & 0x3)
>> >> +             return -EINVAL;
>> >> +
>> >> +     if (rd->state.use_grbm) {
>> >> +             if (rd->state.grbm.se =3D=3D 0x3FF)
>> >> +                     rd->state.grbm.se =3D 0xFFFFFFFF;
>> >> +             if (rd->state.grbm.sh =3D=3D 0x3FF)
>> >> +                     rd->state.grbm.sh =3D 0xFFFFFFFF;
>> >> +             if (rd->state.grbm.instance =3D=3D 0x3FF)
>> >> +                     rd->state.grbm.instance =3D 0xFFFFFFFF;
>> >> +     }
>> >> +
>> >> +     r =3D pm_runtime_get_sync(adev_to_drm(adev)->dev);
>> >> +     if (r < 0) {
>> >> +             pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>> >> +             return r;
>> >> +     }
>> >> +
>> >> +     r =3D amdgpu_virt_enable_access_debugfs(adev);
>> >> +     if (r < 0) {
>> >> +             pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>> >> +             return r;
>> >> +     }
>> >> +
>> >> +     if (rd->state.use_grbm) {
>> >> +             if ((rd->state.grbm.sh !=3D 0xFFFFFFFF && rd->
>> state.grbm.sh >=3D adev->gfx.config.max_sh_per_se) ||
>> >> +                 (rd->state.grbm.se !=3D 0xFFFFFFFF && rd->
>> state.grbm.se >=3D adev->gfx.config.max_shader_engines)) {
>> >> +
>>  pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
>> >> +
>>  pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>> >> +                     amdgpu_virt_disable_access_debugfs(adev);
>> >> +                     return -EINVAL;
>> >> +             }
>> >> +             mutex_lock(&adev->grbm_idx_mutex);
>> >> +             amdgpu_gfx_select_se_sh(adev, rd->state.grbm.se,
>> >> +                                                             rd->
>> state.grbm.sh,
>> >> +
>>  rd->state.grbm.instance);
>> >> +     } else if (rd->state.use_grbm) {
>> >> +             mutex_lock(&adev->srbm_mutex);
>> >> +             amdgpu_gfx_select_me_pipe_q(adev, rd->state.srbm.me,
>> rd->state.srbm.pipe,
>> >> +
>>  rd->state.srbm.queue, rd->state.srbm.vmid);
>> >> +     }
>> >> +
>> >> +     if (rd->state.pg_lock)
>> >> +             mutex_lock(&adev->pm.mutex);
>> >> +
>> >> +     if (!write_en) {
>> >> +             value =3D RREG32(rd->state.offset >> 2);
>> >> +             r =3D put_user(value, (uint32_t *)buf);
>> >> +     } else {
>> >> +             r =3D get_user(value, (uint32_t *)buf);
>> >> +             if (!r)
>> >> +                     amdgpu_mm_wreg_mmio_rlc(adev, rd->state.offset
>> >> 2, value);
>> >> +     }
>> >> +     if (r) {
>> >> +             result =3D r;
>> >> +             goto end;
>> >> +     }
>> >> +     result =3D 0;
>> >> +end:
>> >> +     if (rd->state.use_grbm) {
>> >> +             amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff,
>> 0xffffffff);
>> >> +             mutex_unlock(&adev->grbm_idx_mutex);
>> >> +     } else if (rd->state.use_srbm) {
>> >> +             amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, 0);
>> >> +             mutex_unlock(&adev->srbm_mutex);
>> >> +     }
>> >> +
>> >> +     if (rd->state.pg_lock)
>> >> +             mutex_unlock(&adev->pm.mutex);
>> >> +
>> >> +     // in umr (the likely user of this) flags are set per file
>> operation
>> >> +     // which means they're never "unset" explicitly.  To avoid
>> breaking
>> >> +     // this convention we unset the flags after each operation
>> >> +     // flags are for a single call (need to be set for every
>> read/write)
>> >> +     rd->state.use_grbm =3D 0;
>> >> +     rd->state.use_srbm =3D 0;
>> >> +     rd->state.pg_lock  =3D 0;
>> >> +
>> >> +     pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
>> >> +     pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>> >> +
>> >> +     amdgpu_virt_disable_access_debugfs(adev);
>> >> +     return result;
>> >> +}
>> >> +
>> >> +static long amdgpu_debugfs_regs2_ioctl(struct file *f, unsigned int
>> cmd, unsigned long data)
>> >> +{
>> >> +     struct amdgpu_debugfs_regs2_data *rd =3D f->private_data;
>> >> +     unsigned char st[32], v;
>> >> +     int r, x;
>> >> +
>> >> +     // always read first 4 bytes of data
>> >> +     for (x =3D 0; x < 4; x++) {
>> >> +             if ((r =3D get_user(v, (unsigned char *)data))) {
>> >> +                     return r;
>> >> +             }
>> >> +             ++data;
>> >> +             st[x] =3D v;
>> >> +     }
>> >> +
>> >> +     // first 4 bytes are offset
>> >> +     rd->state.offset =3D ((u32)st[0]) | ((u32)st[1] << 8) |
>> >> +                                        ((u32)st[2] << 16) |
>> ((u32)st[3] << 24);
>> >> +
>> >> +     switch (cmd) {
>> >> +             case AMDGPU_DEBUGFS_REGS2_IOC_SET_STATE:
>> >> +                     for (x =3D 4; x < 32; x++) {
>> >> +                             if ((r =3D get_user(v, (unsigned char
>> *)data))) {
>> >> +                                     return r;
>> >> +                             }
>> >> +                             ++data;
>> >> +                             st[x] =3D v;
>> >> +                     }
>> >> +
>> >> +                     // next byte contains the flag
>> >> +                     // we only consume the remainder of the state i=
f
>> bit 1 is set
>> >> +                     // this allows the subsequent read/write
>> >> +                     rd->state.use_grbm =3D (st[4] & 1) ? 1 : 0;
>> >> +                     rd->state.use_srbm =3D (st[4] & 2) ? 1 : 0;
>> >> +                     rd->state.pg_lock  =3D (st[4] & 4) ? 1 : 0;
>> >> +
>> >> +                     // next 6 bytes are grbm data
>> >> +                     rd->state.grbm.se       =3D  ((u32)st[5]) |
>> ((u32)st[6] << 8);
>> >> +                     rd->state.grbm.sh       =3D  ((u32)st[7]) |
>> ((u32)st[8] << 8);
>> >> +                     rd->state.grbm.instance =3D  ((u32)st[9]) |
>> ((u32)st[10] << 8);
>> >> +
>> >> +                     // next 8 are srbm data
>> >> +                     rd->state.srbm.me       =3D  ((u32)st[11]) |
>> ((u32)st[12] << 8);
>> >> +                     rd->state.srbm.pipe     =3D  ((u32)st[13]) |
>> ((u32)st[14] << 8);
>> >> +                     rd->state.srbm.queue    =3D  ((u32)st[15]) |
>> ((u32)st[16] << 8);
>> >> +                     rd->state.srbm.vmid     =3D  ((u32)st[17]) |
>> ((u32)st[18] << 8);
>> >> +                     break;
>> >> +             case AMDGPU_DEBUGFS_REGS2_IOC_READ:
>> >> +                     return amdgpu_debugfs_regs2_op(f, (char __user
>> *)data, 0);
>> >> +             case AMDGPU_DEBUGFS_REGS2_IOC_WRITE:
>> >> +                     return amdgpu_debugfs_regs2_op(f, (char __user
>> *)data, 1);
>> >> +             default:
>> >> +                     return -EINVAL;
>> >> +     }
>> >> +     return 0;
>> >> +}
>> >>
>> >>    /**
>> >>     * amdgpu_debugfs_regs_pcie_read - Read from a PCIE register
>> >> @@ -1091,6 +1258,14 @@ static ssize_t
>> amdgpu_debugfs_gfxoff_read(struct file *f, char __user *buf,
>> >>        return result;
>> >>    }
>> >>
>> >> +static const struct file_operations amdgpu_debugfs_regs2_fops =3D {
>> >> +     .owner =3D THIS_MODULE,
>> >> +     .unlocked_ioctl =3D amdgpu_debugfs_regs2_ioctl,
>> >> +     .open =3D amdgpu_debugfs_regs2_open,
>> >> +     .release =3D amdgpu_debugfs_regs2_release,
>> >> +     .llseek =3D default_llseek
>> >> +};
>> >> +
>> >>    static const struct file_operations amdgpu_debugfs_regs_fops =3D {
>> >>        .owner =3D THIS_MODULE,
>> >>        .read =3D amdgpu_debugfs_regs_read,
>> >> @@ -1148,6 +1323,7 @@ static const struct file_operations
>> amdgpu_debugfs_gfxoff_fops =3D {
>> >>
>> >>    static const struct file_operations *debugfs_regs[] =3D {
>> >>        &amdgpu_debugfs_regs_fops,
>> >> +     &amdgpu_debugfs_regs2_fops,
>> >>        &amdgpu_debugfs_regs_didt_fops,
>> >>        &amdgpu_debugfs_regs_pcie_fops,
>> >>        &amdgpu_debugfs_regs_smc_fops,
>> >> @@ -1160,6 +1336,7 @@ static const struct file_operations
>> *debugfs_regs[] =3D {
>> >>
>> >>    static const char *debugfs_regs_names[] =3D {
>> >>        "amdgpu_regs",
>> >> +     "amdgpu_regs2",
>> >>        "amdgpu_regs_didt",
>> >>        "amdgpu_regs_pcie",
>> >>        "amdgpu_regs_smc",
>> >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
>> >> index 141a8474e24f..04c81cd4bcc7 100644
>> >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
>> >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
>> >> @@ -22,6 +22,7 @@
>> >>     * OTHER DEALINGS IN THE SOFTWARE.
>> >>     *
>> >>     */
>> >> +#include <linux/ioctl.h>
>> >>
>> >>    /*
>> >>     * Debugfs
>> >> @@ -38,3 +39,34 @@ void amdgpu_debugfs_fence_init(struct amdgpu_devic=
e
>> *adev);
>> >>    void amdgpu_debugfs_firmware_init(struct amdgpu_device *adev);
>> >>    void amdgpu_debugfs_gem_init(struct amdgpu_device *adev);
>> >>    int amdgpu_debugfs_wait_dump(struct amdgpu_device *adev);
>> >> +
>> >> +struct amdgpu_debugfs_regs2_data {
>> >> +     struct amdgpu_device *adev;
>> >> +     struct {
>> >> +             // regs state
>> >> +             int use_srbm,
>> >> +                 use_grbm,
>> >> +                 pg_lock;
>> >> +             struct {
>> >> +                     u32 se, sh, instance;
>> >> +             } grbm;
>> >> +             struct {
>> >> +                     u32 me, pipe, queue, vmid;
>> >> +             } srbm;
>> >> +             u32 offset;
>> >> +     } state;
>> >> +};
>> > This stuff needs to be in some shared header then.
>> >
>> >> +
>> >> +enum AMDGPU_DEBUGFS_REGS2_CMDS {
>> >> +     AMDGPU_DEBUGFS_REGS2_CMD_SET_STATE=3D0,
>> >> +     AMDGPU_DEBUGFS_REGS2_CMD_READ,
>> >> +     AMDGPU_DEBUGFS_REGS2_CMD_WRITE,
>> > Why not just using the normal read and write functions?
>> >
>> > Christian.
>> >
>> >> +};
>> >> +
>> >> +struct amdgpu_debugfs_regs2_iocdata {
>> >> +     unsigned char t[32];
>> >> +};
>> >> +
>> >> +#define AMDGPU_DEBUGFS_REGS2_IOC_SET_STATE _IOWR(0x20,
>> AMDGPU_DEBUGFS_REGS2_CMD_SET_STATE, struct amdgpu_debugfs_regs2_iocdata)
>> >> +#define AMDGPU_DEBUGFS_REGS2_IOC_READ _IOWR(0x20,
>> AMDGPU_DEBUGFS_REGS2_CMD_WRITE, struct amdgpu_debugfs_regs2_iocdata)
>> >> +#define AMDGPU_DEBUGFS_REGS2_IOC_WRITE _IOWR(0x20,
>> AMDGPU_DEBUGFS_REGS2_CMD_READ, struct amdgpu_debugfs_regs2_iocdata)
>>
>>
>

--000000000000625db405ca4e1c1a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">hehehe I just moved it to uapi... No worries, you&#39;re t=
he maintainer, I&#39;ll move it back before posting v2.<div><br></div><div>=
Cheers,</div><div>Tom</div></div><br><div class=3D"gmail_quote"><div dir=3D=
"ltr" class=3D"gmail_attr">On Tue, Aug 24, 2021 at 9:22 AM Christian K=C3=
=B6nig &lt;<a href=3D"mailto:ckoenig.leichtzumerken@gmail.com">ckoenig.leic=
htzumerken@gmail.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex">
 =20
   =20
 =20
  <div>
    Am 24.08.21 um 14:42 schrieb Tom St Denis:<br>
    <blockquote type=3D"cite">
     =20
      <div dir=3D"ltr">The IOCTL data is in the debugfs header as it is.=C2=
=A0
        I could move that to the amdgpu_drm.h and include it from
        amdgpu_debugfs.h.</div>
    </blockquote>
    <br>
    Na, keep it like that and just add a comment.<br>
    <br>
    On second thought I don&#39;t want to raise any discussion on the
    mailing list if we should have a debugfs structure in the UAPI
    headers.<br>
    <br>
    Christian.<br>
    <br>
    <blockquote type=3D"cite">
      <div dir=3D"ltr">
        <div><br>
        </div>
        <div>I&#39;ll re-write the STATE IOCTL to use a struct and then tes=
t
          against what I have in umr.</div>
        <div><br>
        </div>
        <div>Refactoring the read/write is trivial and I&#39;ll do that no
          problem (with style fixes).</div>
        <div><br>
        </div>
        <div>Cheers,</div>
        <div>Tom</div>
      </div>
      <br>
      <div class=3D"gmail_quote">
        <div dir=3D"ltr" class=3D"gmail_attr">On Tue, Aug 24, 2021 at 8:34
          AM Christian K=C3=B6nig &lt;<a href=3D"mailto:ckoenig.leichtzumer=
ken@gmail.com" target=3D"_blank">ckoenig.leichtzumerken@gmail.com</a>&gt;
          wrote:<br>
        </div>
        <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex=
;border-left:1px solid rgb(204,204,204);padding-left:1ex">Am
          24.08.21 um 14:27 schrieb StDenis, Tom:<br>
          &gt; [AMD Official Use Only]<br>
          &gt;<br>
          &gt; What do you mean a &quot;shared header?&quot;=C2=A0 How woul=
d they be
          shared between kernel and user?<br>
          <br>
          Somewhere in the include/uapi/drm/ folder I think. Either add
          that to <br>
          amdgpu_drm.h or maybe amdgpu_debugfs.h?<br>
          <br>
          Or just keep it as a structure in amdgpu_debugfs.h with a
          comment that <br>
          it is used for an IOCTL.<br>
          <br>
          Just not something hard coded like first byte is this, second
          that etc....<br>
          <br>
          &gt; As for why not read/write.=C2=A0 Jus wanted to keep it
          simple.=C2=A0 It&#39;s not really performance bound.=C2=A0 umr ne=
ver does
          reads/writes larger than 32-bits anyways.=C2=A0 It doesn&#39;t ha=
ve to
          be this way though but I figured the fewer LOC the better.<br>
          <br>
          I think it would be cleaner if we would have separate
          functions for this.<br>
          <br>
          As far as I can see you also don&#39;t need the dance with the
          power <br>
          managerment etc for the IOCTL. It&#39;s just get_user() into your
          structure.<br>
          <br>
          BTW: In the kernel coding style put &quot;switch&quot; and &quot;=
case&quot; on the
          same <br>
          column, otherwise <a href=3D"http://checkpatch.pl" rel=3D"norefer=
rer" target=3D"_blank">checkpatch.pl</a>
          might complain.<br>
          <br>
          Christian.<br>
          <br>
          &gt;<br>
          &gt; Tom<br>
          &gt;<br>
          &gt; ________________________________________<br>
          &gt; From: Christian K=C3=B6nig &lt;<a href=3D"mailto:ckoenig.lei=
chtzumerken@gmail.com" target=3D"_blank">ckoenig.leichtzumerken@gmail.com</=
a>&gt;<br>
          &gt; Sent: Tuesday, August 24, 2021 08:20<br>
          &gt; To: StDenis, Tom; <a href=3D"mailto:amd-gfx@lists.freedeskto=
p.org" target=3D"_blank">amd-gfx@lists.freedesktop.org</a><br>
          &gt; Subject: Re: [PATCH] drm/amd/amdgpu: New debugfs
          interface for MMIO registers<br>
          &gt;<br>
          &gt;<br>
          &gt;<br>
          &gt; Am 24.08.21 um 14:16 schrieb Tom St Denis:<br>
          &gt;&gt; This new debugfs interface uses an IOCTL interface in
          order to pass<br>
          &gt;&gt; along state information like SRBM and GRBM bank
          switching.=C2=A0 This<br>
          &gt;&gt; new interface also allows a full 32-bit MMIO address
          range which<br>
          &gt;&gt; the previous didn&#39;t.=C2=A0 With this new design we h=
ave
          room to grow<br>
          &gt;&gt; the flexibility of the file as need be.<br>
          &gt;&gt;<br>
          &gt;&gt; Signed-off-by: Tom St Denis &lt;<a href=3D"mailto:tom.st=
denis@amd.com" target=3D"_blank">tom.stdenis@amd.com</a>&gt;<br>
          &gt;&gt; ---<br>
          &gt;&gt;=C2=A0 =C2=A0 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c=
 | 177
          ++++++++++++++++++++<br>
          &gt;&gt;=C2=A0 =C2=A0 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h=
 |=C2=A0 32
          ++++<br>
          &gt;&gt;=C2=A0 =C2=A0 2 files changed, 209 insertions(+)<br>
          &gt;&gt;<br>
          &gt;&gt; diff --git
          a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
          b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c<br>
          &gt;&gt; index 277128846dd1..ab2d92f84da5 100644<br>
          &gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c<br>
          &gt;&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c<br>
          &gt;&gt; @@ -279,6 +279,173 @@ static ssize_t
          amdgpu_debugfs_regs_write(struct file *f, const char __user
          *buf,<br>
          &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 return amdgpu_debugfs_process=
_reg_op(false, f,
          (char __user *)buf, size, pos);<br>
          &gt;&gt;=C2=A0 =C2=A0 }<br>
          &gt;&gt;<br>
          &gt;&gt; +static int amdgpu_debugfs_regs2_open(struct inode
          *inode, struct file *file)<br>
          &gt;&gt; +{<br>
          &gt;&gt; +=C2=A0 =C2=A0 =C2=A0struct amdgpu_debugfs_regs2_data *r=
d;<br>
          &gt;&gt; +<br>
          &gt;&gt; +=C2=A0 =C2=A0 =C2=A0rd =3D kzalloc(sizeof *rd, GFP_KERN=
EL);<br>
          &gt;&gt; +=C2=A0 =C2=A0 =C2=A0if (!rd)<br>
          &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return =
-ENOMEM;<br>
          &gt;&gt; +=C2=A0 =C2=A0 =C2=A0rd-&gt;adev =3D file_inode(file)-&g=
t;i_private;<br>
          &gt;&gt; +=C2=A0 =C2=A0 =C2=A0file-&gt;private_data =3D rd;<br>
          &gt;&gt; +<br>
          &gt;&gt; +=C2=A0 =C2=A0 =C2=A0return 0;<br>
          &gt;&gt; +}<br>
          &gt;&gt; +<br>
          &gt;&gt; +static int amdgpu_debugfs_regs2_release(struct inode
          *inode, struct file *file)<br>
          &gt;&gt; +{<br>
          &gt;&gt; +=C2=A0 =C2=A0 =C2=A0kfree(file-&gt;private_data);<br>
          &gt;&gt; +=C2=A0 =C2=A0 =C2=A0return 0;<br>
          &gt;&gt; +}<br>
          &gt;&gt; +<br>
          &gt;&gt; +static int amdgpu_debugfs_regs2_op(struct file *f,
          char __user *buf, int write_en)<br>
          &gt;&gt; +{<br>
          &gt;&gt; +=C2=A0 =C2=A0 =C2=A0struct amdgpu_debugfs_regs2_data *r=
d =3D
          f-&gt;private_data;<br>
          &gt;&gt; +=C2=A0 =C2=A0 =C2=A0struct amdgpu_device *adev =3D rd-&=
gt;adev;<br>
          &gt;&gt; +=C2=A0 =C2=A0 =C2=A0int result =3D 0, r;<br>
          &gt;&gt; +=C2=A0 =C2=A0 =C2=A0uint32_t value;<br>
          &gt;&gt; +<br>
          &gt;&gt; +=C2=A0 =C2=A0 =C2=A0if (rd-&gt;state.offset &amp; 0x3)<=
br>
          &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return =
-EINVAL;<br>
          &gt;&gt; +<br>
          &gt;&gt; +=C2=A0 =C2=A0 =C2=A0if (rd-&gt;state.use_grbm) {<br>
          &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (rd-=
&gt;<a href=3D"http://state.grbm.se" rel=3D"noreferrer" target=3D"_blank">s=
tate.grbm.se</a> =3D=3D 0x3FF)<br>
          &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0rd-&gt;<a href=3D"http://state.grbm.se" rel=3D"norefer=
rer" target=3D"_blank">state.grbm.se</a> =3D 0xFFFFFFFF;<br>
          &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (rd-=
&gt;<a href=3D"http://state.grbm.sh" rel=3D"noreferrer" target=3D"_blank">s=
tate.grbm.sh</a> =3D=3D 0x3FF)<br>
          &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0rd-&gt;<a href=3D"http://state.grbm.sh" rel=3D"norefer=
rer" target=3D"_blank">state.grbm.sh</a> =3D 0xFFFFFFFF;<br>
          &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (rd-=
&gt;state.grbm.instance =3D=3D
          0x3FF)<br>
          &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0rd-&gt;state.grbm.instance =3D
          0xFFFFFFFF;<br>
          &gt;&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
          &gt;&gt; +<br>
          &gt;&gt; +=C2=A0 =C2=A0 =C2=A0r =3D
          pm_runtime_get_sync(adev_to_drm(adev)-&gt;dev);<br>
          &gt;&gt; +=C2=A0 =C2=A0 =C2=A0if (r &lt; 0) {<br>
          &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
          =C2=A0pm_runtime_put_autosuspend(adev_to_drm(adev)-&gt;dev);<br>
          &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return =
r;<br>
          &gt;&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
          &gt;&gt; +<br>
          &gt;&gt; +=C2=A0 =C2=A0 =C2=A0r =3D amdgpu_virt_enable_access_deb=
ugfs(adev);<br>
          &gt;&gt; +=C2=A0 =C2=A0 =C2=A0if (r &lt; 0) {<br>
          &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
          =C2=A0pm_runtime_put_autosuspend(adev_to_drm(adev)-&gt;dev);<br>
          &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return =
r;<br>
          &gt;&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
          &gt;&gt; +<br>
          &gt;&gt; +=C2=A0 =C2=A0 =C2=A0if (rd-&gt;state.use_grbm) {<br>
          &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if ((rd=
-&gt;<a href=3D"http://state.grbm.sh" rel=3D"noreferrer" target=3D"_blank">=
state.grbm.sh</a> !=3D 0xFFFFFFFF
          &amp;&amp; rd-&gt;<a href=3D"http://state.grbm.sh" rel=3D"norefer=
rer" target=3D"_blank">state.grbm.sh</a>
          &gt;=3D adev-&gt;gfx.config.max_sh_per_se) ||<br>
          &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0(rd-&gt;<a href=3D"http://state.grbm.se" rel=3D"noreferrer" target=
=3D"_blank">state.grbm.se</a> !=3D 0xFFFFFFFF
          &amp;&amp; rd-&gt;<a href=3D"http://state.grbm.se" rel=3D"norefer=
rer" target=3D"_blank">state.grbm.se</a>
          &gt;=3D adev-&gt;gfx.config.max_shader_engines)) {<br>
          &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0
          =C2=A0pm_runtime_mark_last_busy(adev_to_drm(adev)-&gt;dev);<br>
          &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0
          =C2=A0pm_runtime_put_autosuspend(adev_to_drm(adev)-&gt;dev);<br>
          &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0
          =C2=A0amdgpu_virt_disable_access_debugfs(adev);<br>
          &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<br>
          &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
          &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
          =C2=A0mutex_lock(&amp;adev-&gt;grbm_idx_mutex);<br>
          &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0amdgpu_=
gfx_select_se_sh(adev, rd-&gt;<a href=3D"http://state.grbm.se" rel=3D"noref=
errer" target=3D"_blank">state.grbm.se</a>,<br>
          &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
          =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rd-&gt;<a href=3D"http://state.=
grbm.sh" rel=3D"noreferrer" target=3D"_blank">state.grbm.sh</a>,<br>
          &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
          =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rd-&gt;state.grbm.instance);<br=
>
          &gt;&gt; +=C2=A0 =C2=A0 =C2=A0} else if (rd-&gt;state.use_grbm) {=
<br>
          &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mutex_l=
ock(&amp;adev-&gt;srbm_mutex);<br>
          &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0amdgpu_=
gfx_select_me_pipe_q(adev,
          rd-&gt;<a href=3D"http://state.srbm.me" rel=3D"noreferrer" target=
=3D"_blank">state.srbm.me</a>,
          rd-&gt;state.srbm.pipe,<br>
          &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
          =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rd-=
&gt;state.srbm.queue,
          rd-&gt;state.srbm.vmid);<br>
          &gt;&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
          &gt;&gt; +<br>
          &gt;&gt; +=C2=A0 =C2=A0 =C2=A0if (rd-&gt;state.pg_lock)<br>
          &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mutex_l=
ock(&amp;adev-&gt;pm.mutex);<br>
          &gt;&gt; +<br>
          &gt;&gt; +=C2=A0 =C2=A0 =C2=A0if (!write_en) {<br>
          &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0value =
=3D RREG32(rd-&gt;state.offset
          &gt;&gt; 2);<br>
          &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0r =3D p=
ut_user(value, (uint32_t *)buf);<br>
          &gt;&gt; +=C2=A0 =C2=A0 =C2=A0} else {<br>
          &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0r =3D g=
et_user(value, (uint32_t *)buf);<br>
          &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!r)=
<br>
          &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0amdgpu_mm_wreg_mmio_rlc(adev,
          rd-&gt;state.offset &gt;&gt; 2, value);<br>
          &gt;&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
          &gt;&gt; +=C2=A0 =C2=A0 =C2=A0if (r) {<br>
          &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0result =
=3D r;<br>
          &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto en=
d;<br>
          &gt;&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
          &gt;&gt; +=C2=A0 =C2=A0 =C2=A0result =3D 0;<br>
          &gt;&gt; +end:<br>
          &gt;&gt; +=C2=A0 =C2=A0 =C2=A0if (rd-&gt;state.use_grbm) {<br>
          &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0amdgpu_=
gfx_select_se_sh(adev,
          0xffffffff, 0xffffffff, 0xffffffff);<br>
          &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
          =C2=A0mutex_unlock(&amp;adev-&gt;grbm_idx_mutex);<br>
          &gt;&gt; +=C2=A0 =C2=A0 =C2=A0} else if (rd-&gt;state.use_srbm) {=
<br>
          &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0amdgpu_=
gfx_select_me_pipe_q(adev, 0, 0,
          0, 0);<br>
          &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mutex_u=
nlock(&amp;adev-&gt;srbm_mutex);<br>
          &gt;&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
          &gt;&gt; +<br>
          &gt;&gt; +=C2=A0 =C2=A0 =C2=A0if (rd-&gt;state.pg_lock)<br>
          &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mutex_u=
nlock(&amp;adev-&gt;pm.mutex);<br>
          &gt;&gt; +<br>
          &gt;&gt; +=C2=A0 =C2=A0 =C2=A0// in umr (the likely user of this)=
 flags are
          set per file operation<br>
          &gt;&gt; +=C2=A0 =C2=A0 =C2=A0// which means they&#39;re never &q=
uot;unset&quot;
          explicitly.=C2=A0 To avoid breaking<br>
          &gt;&gt; +=C2=A0 =C2=A0 =C2=A0// this convention we unset the fla=
gs after
          each operation<br>
          &gt;&gt; +=C2=A0 =C2=A0 =C2=A0// flags are for a single call (nee=
d to be set
          for every read/write)<br>
          &gt;&gt; +=C2=A0 =C2=A0 =C2=A0rd-&gt;state.use_grbm =3D 0;<br>
          &gt;&gt; +=C2=A0 =C2=A0 =C2=A0rd-&gt;state.use_srbm =3D 0;<br>
          &gt;&gt; +=C2=A0 =C2=A0 =C2=A0rd-&gt;state.pg_lock=C2=A0 =3D 0;<b=
r>
          &gt;&gt; +<br>
          &gt;&gt; +=C2=A0 =C2=A0
          =C2=A0pm_runtime_mark_last_busy(adev_to_drm(adev)-&gt;dev);<br>
          &gt;&gt; +=C2=A0 =C2=A0
          =C2=A0pm_runtime_put_autosuspend(adev_to_drm(adev)-&gt;dev);<br>
          &gt;&gt; +<br>
          &gt;&gt; +=C2=A0 =C2=A0 =C2=A0amdgpu_virt_disable_access_debugfs(=
adev);<br>
          &gt;&gt; +=C2=A0 =C2=A0 =C2=A0return result;<br>
          &gt;&gt; +}<br>
          &gt;&gt; +<br>
          &gt;&gt; +static long amdgpu_debugfs_regs2_ioctl(struct file
          *f, unsigned int cmd, unsigned long data)<br>
          &gt;&gt; +{<br>
          &gt;&gt; +=C2=A0 =C2=A0 =C2=A0struct amdgpu_debugfs_regs2_data *r=
d =3D
          f-&gt;private_data;<br>
          &gt;&gt; +=C2=A0 =C2=A0 =C2=A0unsigned char st[32], v;<br>
          &gt;&gt; +=C2=A0 =C2=A0 =C2=A0int r, x;<br>
          &gt;&gt; +<br>
          &gt;&gt; +=C2=A0 =C2=A0 =C2=A0// always read first 4 bytes of dat=
a<br>
          &gt;&gt; +=C2=A0 =C2=A0 =C2=A0for (x =3D 0; x &lt; 4; x++) {<br>
          &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if ((r =
=3D get_user(v, (unsigned char
          *)data))) {<br>
          &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0return r;<br>
          &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
          &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0++data;=
<br>
          &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0st[x] =
=3D v;<br>
          &gt;&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
          &gt;&gt; +<br>
          &gt;&gt; +=C2=A0 =C2=A0 =C2=A0// first 4 bytes are offset<br>
          &gt;&gt; +=C2=A0 =C2=A0 =C2=A0rd-&gt;state.offset =3D ((u32)st[0]=
) |
          ((u32)st[1] &lt;&lt; 8) |<br>
          &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 ((u32)st[2]
          &lt;&lt; 16) | ((u32)st[3] &lt;&lt; 24);<br>
          &gt;&gt; +<br>
          &gt;&gt; +=C2=A0 =C2=A0 =C2=A0switch (cmd) {<br>
          &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case
          AMDGPU_DEBUGFS_REGS2_IOC_SET_STATE:<br>
          &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0for (x =3D 4; x &lt; 32; x++) {<br>
          &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if ((r =3D get_user(v,
          (unsigned char *)data))) {<br>
          &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0return r;<br>
          &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
          &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0++data;<br>
          &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0st[x] =3D v;<br>
          &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0}<br>
          &gt;&gt; +<br>
          &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0// next byte contains the flag<br>
          &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0// we only consume the
          remainder of the state if bit 1 is set<br>
          &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0// this allows the subsequent
          read/write<br>
          &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0rd-&gt;state.use_grbm =3D (st[4]
          &amp; 1) ? 1 : 0;<br>
          &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0rd-&gt;state.use_srbm =3D (st[4]
          &amp; 2) ? 1 : 0;<br>
          &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0rd-&gt;state.pg_lock=C2=A0 =3D (st[4]
          &amp; 4) ? 1 : 0;<br>
          &gt;&gt; +<br>
          &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0// next 6 bytes are grbm data<br>
          &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0rd-&gt;<a href=3D"http://state.grbm.se" rel=3D"norefer=
rer" target=3D"_blank">state.grbm.se</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D=C2=
=A0
          ((u32)st[5]) | ((u32)st[6] &lt;&lt; 8);<br>
          &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0rd-&gt;<a href=3D"http://state.grbm.sh" rel=3D"norefer=
rer" target=3D"_blank">state.grbm.sh</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D=C2=
=A0
          ((u32)st[7]) | ((u32)st[8] &lt;&lt; 8);<br>
          &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0rd-&gt;state.grbm.instance =3D=C2=A0
          ((u32)st[9]) | ((u32)st[10] &lt;&lt; 8);<br>
          &gt;&gt; +<br>
          &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0// next 8 are srbm data<br>
          &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0rd-&gt;<a href=3D"http://state.srbm.me" rel=3D"norefer=
rer" target=3D"_blank">state.srbm.me</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D=C2=
=A0
          ((u32)st[11]) | ((u32)st[12] &lt;&lt; 8);<br>
          &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0rd-&gt;state.srbm.pipe=C2=A0 =C2=A0 =C2=A0=3D=C2=A0
          ((u32)st[13]) | ((u32)st[14] &lt;&lt; 8);<br>
          &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0rd-&gt;state.srbm.queue=C2=A0 =C2=A0 =3D=C2=A0
          ((u32)st[15]) | ((u32)st[16] &lt;&lt; 8);<br>
          &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0rd-&gt;state.srbm.vmid=C2=A0 =C2=A0 =C2=A0=3D=C2=A0
          ((u32)st[17]) | ((u32)st[18] &lt;&lt; 8);<br>
          &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0break;<br>
          &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case AM=
DGPU_DEBUGFS_REGS2_IOC_READ:<br>
          &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0return
          amdgpu_debugfs_regs2_op(f, (char __user *)data, 0);<br>
          &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case AM=
DGPU_DEBUGFS_REGS2_IOC_WRITE:<br>
          &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0return
          amdgpu_debugfs_regs2_op(f, (char __user *)data, 1);<br>
          &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0default=
:<br>
          &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<br>
          &gt;&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
          &gt;&gt; +=C2=A0 =C2=A0 =C2=A0return 0;<br>
          &gt;&gt; +}<br>
          &gt;&gt;<br>
          &gt;&gt;=C2=A0 =C2=A0 /**<br>
          &gt;&gt;=C2=A0 =C2=A0 =C2=A0* amdgpu_debugfs_regs_pcie_read - Rea=
d from a
          PCIE register<br>
          &gt;&gt; @@ -1091,6 +1258,14 @@ static ssize_t
          amdgpu_debugfs_gfxoff_read(struct file *f, char __user *buf,<br>
          &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 return result;<br>
          &gt;&gt;=C2=A0 =C2=A0 }<br>
          &gt;&gt;<br>
          &gt;&gt; +static const struct file_operations
          amdgpu_debugfs_regs2_fops =3D {<br>
          &gt;&gt; +=C2=A0 =C2=A0 =C2=A0.owner =3D THIS_MODULE,<br>
          &gt;&gt; +=C2=A0 =C2=A0 =C2=A0.unlocked_ioctl =3D amdgpu_debugfs_=
regs2_ioctl,<br>
          &gt;&gt; +=C2=A0 =C2=A0 =C2=A0.open =3D amdgpu_debugfs_regs2_open=
,<br>
          &gt;&gt; +=C2=A0 =C2=A0 =C2=A0.release =3D amdgpu_debugfs_regs2_r=
elease,<br>
          &gt;&gt; +=C2=A0 =C2=A0 =C2=A0.llseek =3D default_llseek<br>
          &gt;&gt; +};<br>
          &gt;&gt; +<br>
          &gt;&gt;=C2=A0 =C2=A0 static const struct file_operations
          amdgpu_debugfs_regs_fops =3D {<br>
          &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 .owner =3D THIS_MODULE,<br>
          &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 .read =3D amdgpu_debugfs_regs=
_read,<br>
          &gt;&gt; @@ -1148,6 +1323,7 @@ static const struct
          file_operations amdgpu_debugfs_gfxoff_fops =3D {<br>
          &gt;&gt;<br>
          &gt;&gt;=C2=A0 =C2=A0 static const struct file_operations
          *debugfs_regs[] =3D {<br>
          &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;amdgpu_debugfs_regs_fops=
,<br>
          &gt;&gt; +=C2=A0 =C2=A0 =C2=A0&amp;amdgpu_debugfs_regs2_fops,<br>
          &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;amdgpu_debugfs_regs_didt=
_fops,<br>
          &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;amdgpu_debugfs_regs_pcie=
_fops,<br>
          &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &amp;amdgpu_debugfs_regs_smc_=
fops,<br>
          &gt;&gt; @@ -1160,6 +1336,7 @@ static const struct
          file_operations *debugfs_regs[] =3D {<br>
          &gt;&gt;<br>
          &gt;&gt;=C2=A0 =C2=A0 static const char *debugfs_regs_names[] =3D=
 {<br>
          &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;amdgpu_regs&quot;,<br>
          &gt;&gt; +=C2=A0 =C2=A0 =C2=A0&quot;amdgpu_regs2&quot;,<br>
          &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;amdgpu_regs_didt&quot;,=
<br>
          &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;amdgpu_regs_pcie&quot;,=
<br>
          &gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;amdgpu_regs_smc&quot;,<=
br>
          &gt;&gt; diff --git
          a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
          b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h<br>
          &gt;&gt; index 141a8474e24f..04c81cd4bcc7 100644<br>
          &gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h<br>
          &gt;&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h<br>
          &gt;&gt; @@ -22,6 +22,7 @@<br>
          &gt;&gt;=C2=A0 =C2=A0 =C2=A0* OTHER DEALINGS IN THE SOFTWARE.<br>
          &gt;&gt;=C2=A0 =C2=A0 =C2=A0*<br>
          &gt;&gt;=C2=A0 =C2=A0 =C2=A0*/<br>
          &gt;&gt; +#include &lt;linux/ioctl.h&gt;<br>
          &gt;&gt;<br>
          &gt;&gt;=C2=A0 =C2=A0 /*<br>
          &gt;&gt;=C2=A0 =C2=A0 =C2=A0* Debugfs<br>
          &gt;&gt; @@ -38,3 +39,34 @@ void
          amdgpu_debugfs_fence_init(struct amdgpu_device *adev);<br>
          &gt;&gt;=C2=A0 =C2=A0 void amdgpu_debugfs_firmware_init(struct
          amdgpu_device *adev);<br>
          &gt;&gt;=C2=A0 =C2=A0 void amdgpu_debugfs_gem_init(struct amdgpu_=
device
          *adev);<br>
          &gt;&gt;=C2=A0 =C2=A0 int amdgpu_debugfs_wait_dump(struct amdgpu_=
device
          *adev);<br>
          &gt;&gt; +<br>
          &gt;&gt; +struct amdgpu_debugfs_regs2_data {<br>
          &gt;&gt; +=C2=A0 =C2=A0 =C2=A0struct amdgpu_device *adev;<br>
          &gt;&gt; +=C2=A0 =C2=A0 =C2=A0struct {<br>
          &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0// regs=
 state<br>
          &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int use=
_srbm,<br>
          &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0use_grbm,<br>
          &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0pg_lock;<br>
          &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct =
{<br>
          &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0u32 se, sh, instance;<br>
          &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} grbm;=
<br>
          &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct =
{<br>
          &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0u32 me, pipe, queue, vmid;<br>
          &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} srbm;=
<br>
          &gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0u32 off=
set;<br>
          &gt;&gt; +=C2=A0 =C2=A0 =C2=A0} state;<br>
          &gt;&gt; +};<br>
          &gt; This stuff needs to be in some shared header then.<br>
          &gt;<br>
          &gt;&gt; +<br>
          &gt;&gt; +enum AMDGPU_DEBUGFS_REGS2_CMDS {<br>
          &gt;&gt; +=C2=A0 =C2=A0 =C2=A0AMDGPU_DEBUGFS_REGS2_CMD_SET_STATE=
=3D0,<br>
          &gt;&gt; +=C2=A0 =C2=A0 =C2=A0AMDGPU_DEBUGFS_REGS2_CMD_READ,<br>
          &gt;&gt; +=C2=A0 =C2=A0 =C2=A0AMDGPU_DEBUGFS_REGS2_CMD_WRITE,<br>
          &gt; Why not just using the normal read and write functions?<br>
          &gt;<br>
          &gt; Christian.<br>
          &gt;<br>
          &gt;&gt; +};<br>
          &gt;&gt; +<br>
          &gt;&gt; +struct amdgpu_debugfs_regs2_iocdata {<br>
          &gt;&gt; +=C2=A0 =C2=A0 =C2=A0unsigned char t[32];<br>
          &gt;&gt; +};<br>
          &gt;&gt; +<br>
          &gt;&gt; +#define AMDGPU_DEBUGFS_REGS2_IOC_SET_STATE
          _IOWR(0x20, AMDGPU_DEBUGFS_REGS2_CMD_SET_STATE, struct
          amdgpu_debugfs_regs2_iocdata)<br>
          &gt;&gt; +#define AMDGPU_DEBUGFS_REGS2_IOC_READ _IOWR(0x20,
          AMDGPU_DEBUGFS_REGS2_CMD_WRITE, struct
          amdgpu_debugfs_regs2_iocdata)<br>
          &gt;&gt; +#define AMDGPU_DEBUGFS_REGS2_IOC_WRITE _IOWR(0x20,
          AMDGPU_DEBUGFS_REGS2_CMD_READ, struct
          amdgpu_debugfs_regs2_iocdata)<br>
          <br>
        </blockquote>
      </div>
    </blockquote>
    <br>
  </div>

</blockquote></div>

--000000000000625db405ca4e1c1a--
