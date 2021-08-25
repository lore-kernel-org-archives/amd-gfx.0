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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57303C4338F
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Aug 2021 11:31:13 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E7D960EFF
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Aug 2021 11:31:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1E7D960EFF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5A1D6E1DE;
	Wed, 25 Aug 2021 11:31:12 +0000 (UTC)
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com
 [IPv6:2607:f8b0:4864:20::92b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9B3C6E1DE
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Aug 2021 11:31:11 +0000 (UTC)
Received: by mail-ua1-x92b.google.com with SMTP id m39so14885091uad.9
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Aug 2021 04:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=EgP17NlyAyKYXMejHlpYvwN4WIYqZ1QNgKmawfSeFk8=;
 b=MZt2NUR/CQg78aKd7Av1sQMKgN1OaB95tNdU5B/TUcaFb/PbmFYbEnxmDZtNBSeyOD
 Sam+SU32v/gXfBpUEuKdaFKTsQmrwJYr15Fs++yTRlsJKlAXpu4R/2uJjKqBVu5ujb0E
 MBHTlx0eQbFXF5UvYsGcm8PUEBh7nkRw0n3iharr/uotqKz/zlYaO2NdCoQJkG21KwoT
 FRhgIZKg7zif5i8xa+ZNCItwWSda7L9uMSZk8dnd7Ll4jkLOThbydHfwUawEASq0Yy6N
 ULb4ZCcQWCgPSnTjHs20rXPES5ostTA9/+crMSJVogrp37ma+v0+r2CyyEIRpNphGMPI
 UizA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=EgP17NlyAyKYXMejHlpYvwN4WIYqZ1QNgKmawfSeFk8=;
 b=Sz96xU+CqT0bMLmr3tyXUI33ZEIQno3955Zd8/Uamm2DmaGPVFkXSPkqy7Q3cKSavw
 TLskS7y30tf7rPV0BM2RFmB2DMdxbrHar3BUSTpOf/e7ZSJyPCQg3R8EmaqNKQ9RBVQV
 VserPN/XiwLjPS3Wa999Pg/8ZznOfcEm7zIb/pwvDblsHaZ6xEvQlqizmgpIYpopXT+U
 V7+HUsuVVR074iXJDxpJDRFMju2eVRXY4w+xX1GpNxBEMWrkJFTl9WFLIkGBS9h+r9cW
 3fSNpkStVgBcjre7gTUa3CQUPbFfHgTlMJUBusy/tNcSFTbqNEsTvY/eOqbblVgPDt54
 q/7w==
X-Gm-Message-State: AOAM531Vxi1j/cTvzyByxZ6DtW5O2GumlAF8eRPgmwELhbJcXA/uXD3Q
 09BvXDmhGGMq50NvJ8sDYZollRN8qf3bW8glFDw=
X-Google-Smtp-Source: ABdhPJxMG0cGRd3Qp/MqmfRlHH3jFlBtbGKo4DTBycTEpVDyi+MXDDEWnDSZeA1ZyN5Kb2Ap1bG6xd4YnxM9UEMV968=
X-Received: by 2002:a9f:3701:: with SMTP id z1mr1338789uad.125.1629891070803; 
 Wed, 25 Aug 2021 04:31:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210824133642.109072-1-tom.stdenis@amd.com>
 <de13fb00-3ce7-5f6c-8f22-e07e697de643@gmail.com>
 <CAAzXoRLzLjZm0AW1w=oEKMsRrVzwPDawbdimBiaKV86A7QF8nQ@mail.gmail.com>
 <84ddce49-012b-2fae-d14d-eeebf7e6c09a@gmail.com>
 <CAAzXoRJsSxm7UOt++H9Ko8pnnNdO0Zp=+hPgCh8TwUaQhv-e_w@mail.gmail.com>
 <acad0e11-842f-52ff-c31a-eebf4777f746@gmail.com>
 <ee4246f1-ae2f-4b30-fb00-047b8184b8e1@amd.com>
In-Reply-To: <ee4246f1-ae2f-4b30-fb00-047b8184b8e1@amd.com>
From: Tom St Denis <tstdenis82@gmail.com>
Date: Wed, 25 Aug 2021 07:31:00 -0400
Message-ID: <CAAzXoR+-KywrwpajoOKB+4QynqiKeDTqmVeMgdE6BMTSYX7CMQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/amdgpu: New debugfs interface for MMIO registers
 (v2)
To: "Das, Nirmoy" <nirmoy.das@amd.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>, 
 Tom St Denis <tom.stdenis@amd.com>,
 amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/alternative; boundary="0000000000004c42c605ca6096ae"
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

--0000000000004c42c605ca6096ae
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

1 hole with u8, 0 holes with u32.  Is good?

On Wed, Aug 25, 2021 at 7:16 AM Das, Nirmoy <nirmoy.das@amd.com> wrote:

>
> On 8/25/2021 1:09 PM, Christian K=C3=B6nig wrote:
>
> I suggest to give this command here at least a try (remembered the name
> after a moment):
>
> pahole drivers/gpu/drm/amd/amdgpu/amdgpu.o -C amdgpu_debugfs_regs2_iocdat=
a
>
> It has a rather nifty output with padding holes, byte addresses, cache
> lines etc for your structure.
>
> Christian.
>
> Am 25.08.21 um 13:04 schrieb Tom St Denis:
>
> I tested it by forcing bit patterns into the ioctl data and printing it
> out in the kernel log.  I'm not siloed into it one way or the other.  I'l=
l
> just change it to u32.
>
> On Wed, Aug 25, 2021 at 7:03 AM Christian K=C3=B6nig <
> ckoenig.leichtzumerken@gmail.com> wrote:
>
>> Using u8 is ok as well, just make sure that you don't have any hidden
>> padding.
>>
>> Nirmoy had a tool to double check for paddings which I once more forgot
>> the name of.
>>
>
> Yes, pahole. pkg name: dwarves
>
>
> Nirmoy
>
>
>
>> Christian.
>>
>> Am 25.08.21 um 12:40 schrieb Tom St Denis:
>>
>> The struct works as is but I'll change them to u32.  The offset is an
>> artefact of the fact this was an IOCTL originally.  I'm working both end=
s
>> in parallel trying to make the changes at the same time because I'm only
>> submitting the kernel patch if I've tested it in userspace.
>>
>> I'll send a v4 in a bit this morning....
>>
>> Tom
>>
>> On Wed, Aug 25, 2021 at 2:35 AM Christian K=C3=B6nig <
>> ckoenig.leichtzumerken@gmail.com> wrote:
>>
>>>
>>>
>>> Am 24.08.21 um 15:36 schrieb Tom St Denis:
>>> > This new debugfs interface uses an IOCTL interface in order to pass
>>> > along state information like SRBM and GRBM bank switching.  This
>>> > new interface also allows a full 32-bit MMIO address range which
>>> > the previous didn't.  With this new design we have room to grow
>>> > the flexibility of the file as need be.
>>> >
>>> > (v2): Move read/write to .read/.write, fix style, add comment
>>> >        for IOCTL data structure
>>> >
>>> > Signed-off-by: Tom St Denis <tom.stdenis@amd.com>
>>> > ---
>>> >   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 162
>>> ++++++++++++++++++++
>>> >   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h |  32 ++++
>>> >   2 files changed, 194 insertions(+)
>>> >
>>> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>> > index 277128846dd1..8e8f5743c8f5 100644
>>> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>> > @@ -279,6 +279,156 @@ static ssize_t amdgpu_debugfs_regs_write(struct
>>> file *f, const char __user *buf,
>>> >       return amdgpu_debugfs_process_reg_op(false, f, (char __user
>>> *)buf, size, pos);
>>> >   }
>>> >
>>> > +static int amdgpu_debugfs_regs2_open(struct inode *inode, struct fil=
e
>>> *file)
>>> > +{
>>> > +     struct amdgpu_debugfs_regs2_data *rd;
>>> > +
>>> > +     rd =3D kzalloc(sizeof *rd, GFP_KERNEL);
>>> > +     if (!rd)
>>> > +             return -ENOMEM;
>>> > +     rd->adev =3D file_inode(file)->i_private;
>>> > +     file->private_data =3D rd;
>>> > +
>>> > +     return 0;
>>> > +}
>>> > +
>>> > +static int amdgpu_debugfs_regs2_release(struct inode *inode, struct
>>> file *file)
>>> > +{
>>> > +     kfree(file->private_data);
>>> > +     return 0;
>>> > +}
>>> > +
>>> > +static ssize_t amdgpu_debugfs_regs2_op(struct file *f, char __user
>>> *buf, size_t size, int write_en)
>>> > +{
>>> > +     struct amdgpu_debugfs_regs2_data *rd =3D f->private_data;
>>> > +     struct amdgpu_device *adev =3D rd->adev;
>>> > +     ssize_t result =3D 0;
>>> > +     int r;
>>> > +     uint32_t value;
>>> > +
>>> > +     if (size & 0x3 || rd->state.offset & 0x3)
>>> > +             return -EINVAL;
>>> > +
>>> > +     if (rd->state.id.use_grbm) {
>>> > +             if (rd->state.id.grbm.se
>>> <https://nam11.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fsta=
te.id.grbm.se%2F&data=3D04%7C01%7Cnirmoy.das%40amd.com%7Cf02eba2f047347488d=
5508d967b8bf96%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637654865456597=
676%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1=
haWwiLCJXVCI6Mn0%3D%7C1000&sdata=3DS7Fz7mMEeVYFqLF0paV%2BDr53Ty2e87lVIWFTvf=
ZTJ%2Bs%3D&reserved=3D0>
>>> =3D=3D 0x3FF)
>>> > +                     rd->state.id.grbm.se
>>> <https://nam11.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fsta=
te.id.grbm.se%2F&data=3D04%7C01%7Cnirmoy.das%40amd.com%7Cf02eba2f047347488d=
5508d967b8bf96%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637654865456597=
676%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1=
haWwiLCJXVCI6Mn0%3D%7C1000&sdata=3DS7Fz7mMEeVYFqLF0paV%2BDr53Ty2e87lVIWFTvf=
ZTJ%2Bs%3D&reserved=3D0>
>>> =3D 0xFFFFFFFF;
>>> > +             if (rd->state.id.grbm.sh
>>> <https://nam11.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fsta=
te.id.grbm.sh%2F&data=3D04%7C01%7Cnirmoy.das%40amd.com%7Cf02eba2f047347488d=
5508d967b8bf96%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637654865456607=
632%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1=
haWwiLCJXVCI6Mn0%3D%7C1000&sdata=3DiHxDEyZ7lz%2FGOdgSFHGbbAT2NPcQCQR0g58ISQ=
MHGhY%3D&reserved=3D0>
>>> =3D=3D 0x3FF)
>>> > +                     rd->state.id.grbm.sh
>>> <https://nam11.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fsta=
te.id.grbm.sh%2F&data=3D04%7C01%7Cnirmoy.das%40amd.com%7Cf02eba2f047347488d=
5508d967b8bf96%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637654865456607=
632%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1=
haWwiLCJXVCI6Mn0%3D%7C1000&sdata=3DiHxDEyZ7lz%2FGOdgSFHGbbAT2NPcQCQR0g58ISQ=
MHGhY%3D&reserved=3D0>
>>> =3D 0xFFFFFFFF;
>>> > +             if (rd->state.id.grbm.instance =3D=3D 0x3FF)
>>> > +                     rd->state.id.grbm.instance =3D 0xFFFFFFFF;
>>> > +     }
>>> > +
>>> > +     r =3D pm_runtime_get_sync(adev_to_drm(adev)->dev);
>>> > +     if (r < 0) {
>>> > +             pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>>> > +             return r;
>>> > +     }
>>> > +
>>> > +     r =3D amdgpu_virt_enable_access_debugfs(adev);
>>> > +     if (r < 0) {
>>> > +             pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>>> > +             return r;
>>> > +     }
>>> > +
>>> > +     if (rd->state.id.use_grbm) {
>>> > +             if ((rd->state.id.grbm.sh
>>> <https://nam11.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fsta=
te.id.grbm.sh%2F&data=3D04%7C01%7Cnirmoy.das%40amd.com%7Cf02eba2f047347488d=
5508d967b8bf96%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637654865456607=
632%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1=
haWwiLCJXVCI6Mn0%3D%7C1000&sdata=3DiHxDEyZ7lz%2FGOdgSFHGbbAT2NPcQCQR0g58ISQ=
MHGhY%3D&reserved=3D0>
>>> !=3D 0xFFFFFFFF && rd->state.id.grbm.sh
>>> <https://nam11.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fsta=
te.id.grbm.sh%2F&data=3D04%7C01%7Cnirmoy.das%40amd.com%7Cf02eba2f047347488d=
5508d967b8bf96%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637654865456617=
591%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1=
haWwiLCJXVCI6Mn0%3D%7C1000&sdata=3DjhS3kKxQAAn18tfFNC7pYnZKEKps4zVXdsX%2FIF=
LH7a4%3D&reserved=3D0>
>>> >=3D adev->gfx.config.max_sh_per_se) ||
>>> > +                 (rd->state.id.grbm.se
>>> <https://nam11.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fsta=
te.id.grbm.se%2F&data=3D04%7C01%7Cnirmoy.das%40amd.com%7Cf02eba2f047347488d=
5508d967b8bf96%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637654865456617=
591%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1=
haWwiLCJXVCI6Mn0%3D%7C1000&sdata=3DJ1WzngpR3KOnPsstL3mpbhltQIp0idV6B22%2BZq=
ZpXoQ%3D&reserved=3D0>
>>> !=3D 0xFFFFFFFF && rd->state.id.grbm.se
>>> <https://nam11.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fsta=
te.id.grbm.se%2F&data=3D04%7C01%7Cnirmoy.das%40amd.com%7Cf02eba2f047347488d=
5508d967b8bf96%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637654865456617=
591%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1=
haWwiLCJXVCI6Mn0%3D%7C1000&sdata=3DJ1WzngpR3KOnPsstL3mpbhltQIp0idV6B22%2BZq=
ZpXoQ%3D&reserved=3D0>
>>> >=3D adev->gfx.config.max_shader_engines)) {
>>> > +
>>>  pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
>>> > +
>>>  pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>>> > +                     amdgpu_virt_disable_access_debugfs(adev);
>>> > +                     return -EINVAL;
>>> > +             }
>>> > +             mutex_lock(&adev->grbm_idx_mutex);
>>> > +             amdgpu_gfx_select_se_sh(adev, rd->state.id.grbm.se
>>> <https://nam11.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fsta=
te.id.grbm.se%2F&data=3D04%7C01%7Cnirmoy.das%40amd.com%7Cf02eba2f047347488d=
5508d967b8bf96%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637654865456627=
544%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1=
haWwiLCJXVCI6Mn0%3D%7C1000&sdata=3DmElFqeL4bHf%2FcNlWTVyoxT6VhHnoLKVOCwCpsW=
iqLkM%3D&reserved=3D0>
>>> ,
>>> > +                                                             rd->
>>> state.id.grbm.sh
>>> <https://nam11.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fsta=
te.id.grbm.sh%2F&data=3D04%7C01%7Cnirmoy.das%40amd.com%7Cf02eba2f047347488d=
5508d967b8bf96%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637654865456627=
544%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1=
haWwiLCJXVCI6Mn0%3D%7C1000&sdata=3DR2jlWr%2BtB%2FKypqHKT36JV%2Fnk2CvO2oLYIs=
pKmfbco58%3D&reserved=3D0>
>>> ,
>>> > +
>>>  rd->state.id.grbm.instance);
>>> > +     }
>>> > +
>>> > +     if (rd->state.id.use_srbm) {
>>> > +             mutex_lock(&adev->srbm_mutex);
>>> > +             amdgpu_gfx_select_me_pipe_q(adev, rd->state.id.srbm.me
>>> <https://nam11.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fsta=
te.id.srbm.me%2F&data=3D04%7C01%7Cnirmoy.das%40amd.com%7Cf02eba2f047347488d=
5508d967b8bf96%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637654865456637=
501%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1=
haWwiLCJXVCI6Mn0%3D%7C1000&sdata=3Dv8e4VpGjaYi1LcWVBxTYx7f4v%2BUW9%2F6FTpYv=
GqygJc0%3D&reserved=3D0>,
>>> rd->state.id.srbm.pipe,
>>> > +
>>>  rd->state.id.srbm.queue, rd->state.id.srbm.vmid);
>>> > +     }
>>> > +
>>> > +     if (rd->state.id.pg_lock)
>>> > +             mutex_lock(&adev->pm.mutex);
>>> > +
>>> > +     while (size) {
>>> > +             if (!write_en) {
>>> > +                     value =3D RREG32(rd->state.offset >> 2);
>>> > +                     r =3D put_user(value, (uint32_t *)buf);
>>> > +             } else {
>>> > +                     r =3D get_user(value, (uint32_t *)buf);
>>> > +                     if (!r)
>>> > +                             amdgpu_mm_wreg_mmio_rlc(adev,
>>> rd->state.offset >> 2, value);
>>> > +             }
>>> > +             if (r) {
>>> > +                     result =3D r;
>>> > +                     goto end;
>>> > +             }
>>> > +             rd->state.offset +=3D 4;
>>> > +             size -=3D 4;
>>> > +             result +=3D 4;
>>> > +             buf +=3D 4;
>>> > +     }
>>> > +end:
>>> > +     if (rd->state.id.use_grbm) {
>>> > +             amdgpu_gfx_select_se_sh(adev, 0xffffffff, 0xffffffff,
>>> 0xffffffff);
>>> > +             mutex_unlock(&adev->grbm_idx_mutex);
>>> > +     }
>>> > +
>>> > +     if (rd->state.id.use_srbm) {
>>> > +             amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, 0);
>>> > +             mutex_unlock(&adev->srbm_mutex);
>>> > +     }
>>> > +
>>> > +     if (rd->state.id.pg_lock)
>>> > +             mutex_unlock(&adev->pm.mutex);
>>> > +
>>> > +     // in umr (the likely user of this) flags are set per file
>>> operation
>>> > +     // which means they're never "unset" explicitly.  To avoid
>>> breaking
>>> > +     // this convention we unset the flags after each operation
>>> > +     // flags are for a single call (need to be set for every
>>> read/write)
>>> > +     rd->state.id.use_grbm =3D 0;
>>> > +     rd->state.id.use_srbm =3D 0;
>>> > +     rd->state.id.pg_lock  =3D 0;
>>> > +
>>> > +     pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
>>> > +     pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>>> > +
>>> > +     amdgpu_virt_disable_access_debugfs(adev);
>>> > +     return result;
>>> > +}
>>> > +
>>> > +static long amdgpu_debugfs_regs2_ioctl(struct file *f, unsigned int
>>> cmd, unsigned long data)
>>> > +{
>>> > +     struct amdgpu_debugfs_regs2_data *rd =3D f->private_data;
>>> > +
>>> > +     switch (cmd) {
>>> > +     case AMDGPU_DEBUGFS_REGS2_IOC_SET_STATE:
>>> > +             if (copy_from_user(&rd->state.id
>>> <https://nam11.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fsta=
te.id%2F&data=3D04%7C01%7Cnirmoy.das%40amd.com%7Cf02eba2f047347488d5508d967=
b8bf96%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637654865456637501%7CUn=
known%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJ=
XVCI6Mn0%3D%7C1000&sdata=3DowOCPq7DugPj8bKIZW%2BPL9O1HXIViFHCq8ZqSkIT4X4%3D=
&reserved=3D0>,
>>> (struct amdgpu_debugfs_regs2_iocdata *)data, sizeof rd->state.id
>>> <https://nam11.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fsta=
te.id%2F&data=3D04%7C01%7Cnirmoy.das%40amd.com%7Cf02eba2f047347488d5508d967=
b8bf96%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637654865456637501%7CUn=
known%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJ=
XVCI6Mn0%3D%7C1000&sdata=3DowOCPq7DugPj8bKIZW%2BPL9O1HXIViFHCq8ZqSkIT4X4%3D=
&reserved=3D0>
>>> ))
>>> > +                     return -EINVAL;
>>> > +             break;
>>> > +     default:
>>> > +             return -EINVAL;
>>> > +     }
>>> > +     return 0;
>>> > +}
>>> > +
>>> > +static ssize_t amdgpu_debugfs_regs2_read(struct file *f, char __user
>>> *buf, size_t size, loff_t *pos)
>>> > +{
>>> > +     struct amdgpu_debugfs_regs2_data *rd =3D f->private_data;
>>> > +     rd->state.offset =3D *pos;
>>> > +     return amdgpu_debugfs_regs2_op(f, buf, size, 0);
>>> > +}
>>> > +
>>> > +static ssize_t amdgpu_debugfs_regs2_write(struct file *f, const char
>>> __user *buf, size_t size, loff_t *pos)
>>> > +{
>>> > +     struct amdgpu_debugfs_regs2_data *rd =3D f->private_data;
>>> > +     rd->state.offset =3D *pos;
>>> > +     return amdgpu_debugfs_regs2_op(f, (char __user *)buf, size, 1);
>>> > +}
>>> > +
>>> >
>>> >   /**
>>> >    * amdgpu_debugfs_regs_pcie_read - Read from a PCIE register
>>> > @@ -1091,6 +1241,16 @@ static ssize_t
>>> amdgpu_debugfs_gfxoff_read(struct file *f, char __user *buf,
>>> >       return result;
>>> >   }
>>> >
>>> > +static const struct file_operations amdgpu_debugfs_regs2_fops =3D {
>>> > +     .owner =3D THIS_MODULE,
>>> > +     .unlocked_ioctl =3D amdgpu_debugfs_regs2_ioctl,
>>> > +     .read =3D amdgpu_debugfs_regs2_read,
>>> > +     .write =3D amdgpu_debugfs_regs2_write,
>>> > +     .open =3D amdgpu_debugfs_regs2_open,
>>> > +     .release =3D amdgpu_debugfs_regs2_release,
>>> > +     .llseek =3D default_llseek
>>> > +};
>>> > +
>>> >   static const struct file_operations amdgpu_debugfs_regs_fops =3D {
>>> >       .owner =3D THIS_MODULE,
>>> >       .read =3D amdgpu_debugfs_regs_read,
>>> > @@ -1148,6 +1308,7 @@ static const struct file_operations
>>> amdgpu_debugfs_gfxoff_fops =3D {
>>> >
>>> >   static const struct file_operations *debugfs_regs[] =3D {
>>> >       &amdgpu_debugfs_regs_fops,
>>> > +     &amdgpu_debugfs_regs2_fops,
>>> >       &amdgpu_debugfs_regs_didt_fops,
>>> >       &amdgpu_debugfs_regs_pcie_fops,
>>> >       &amdgpu_debugfs_regs_smc_fops,
>>> > @@ -1160,6 +1321,7 @@ static const struct file_operations
>>> *debugfs_regs[] =3D {
>>> >
>>> >   static const char *debugfs_regs_names[] =3D {
>>> >       "amdgpu_regs",
>>> > +     "amdgpu_regs2",
>>> >       "amdgpu_regs_didt",
>>> >       "amdgpu_regs_pcie",
>>> >       "amdgpu_regs_smc",
>>> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
>>> > index 141a8474e24f..ec044df5d428 100644
>>> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
>>> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
>>> > @@ -22,6 +22,8 @@
>>> >    * OTHER DEALINGS IN THE SOFTWARE.
>>> >    *
>>> >    */
>>> > +#include <linux/ioctl.h>
>>> > +#include <uapi/drm/amdgpu_drm.h>
>>> >
>>> >   /*
>>> >    * Debugfs
>>> > @@ -38,3 +40,33 @@ void amdgpu_debugfs_fence_init(struct amdgpu_devic=
e
>>> *adev);
>>> >   void amdgpu_debugfs_firmware_init(struct amdgpu_device *adev);
>>> >   void amdgpu_debugfs_gem_init(struct amdgpu_device *adev);
>>> >   int amdgpu_debugfs_wait_dump(struct amdgpu_device *adev);
>>> > +
>>> > +/*
>>> > + * MMIO debugfs IOCTL structure
>>> > + */
>>> > +struct amdgpu_debugfs_regs2_iocdata {
>>> > +     __u8 use_srbm, use_grbm, pg_lock;
>>>
>>> You should consider using u32 here as well or add explicitly padding.
>>>
>>> > +     struct {
>>> > +             __u32 se, sh, instance;
>>> > +     } grbm;
>>> > +     struct {
>>> > +             __u32 me, pipe, queue, vmid;
>>> > +     } srbm;
>>> > +};
>>> > +
>>> > +/*
>>> > + * MMIO debugfs state data (per file* handle)
>>> > + */
>>> > +struct amdgpu_debugfs_regs2_data {
>>> > +     struct amdgpu_device *adev;
>>> > +     struct {
>>> > +             struct amdgpu_debugfs_regs2_iocdata id;
>>> > +             __u32 offset;
>>>
>>> What is the offset good for here?
>>>
>>> Regards,
>>> Christian.
>>>
>>> > +     } state;
>>> > +};
>>> > +
>>> > +enum AMDGPU_DEBUGFS_REGS2_CMDS {
>>> > +     AMDGPU_DEBUGFS_REGS2_CMD_SET_STATE=3D0,
>>> > +};
>>> > +
>>> > +#define AMDGPU_DEBUGFS_REGS2_IOC_SET_STATE _IOWR(0x20,
>>> AMDGPU_DEBUGFS_REGS2_CMD_SET_STATE, struct amdgpu_debugfs_regs2_iocdata=
)
>>>
>>>
>>
>

--0000000000004c42c605ca6096ae
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">1 hole with u8, 0 holes with u32.=C2=A0 Is good?</div><br>=
<div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Au=
g 25, 2021 at 7:16 AM Das, Nirmoy &lt;<a href=3D"mailto:nirmoy.das@amd.com"=
>nirmoy.das@amd.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">

 =20
  <div>
    <p><br>
    </p>
    <div>On 8/25/2021 1:09 PM, Christian K=C3=B6nig
      wrote:<br>
    </div>
    <blockquote type=3D"cite">
     =20
      I suggest to give this command here at least a try (remembered the
      name after a moment):<br>
      <br>
      pahole drivers/gpu/drm/amd/amdgpu/amdgpu.o -C
      amdgpu_debugfs_regs2_iocdata<br>
      <br>
      It has a rather nifty output with padding holes, byte addresses,
      cache lines etc for your structure.<br>
      <br>
      Christian.<br>
      <br>
      <div>Am 25.08.21 um 13:04 schrieb Tom St
        Denis:<br>
      </div>
      <blockquote type=3D"cite">
        <div dir=3D"ltr">I tested it by forcing bit patterns into the
          ioctl data and printing it out in the kernel log.=C2=A0 I&#39;m n=
ot
          siloed into it one way or the other.=C2=A0 I&#39;ll just change i=
t to
          u32.</div>
        <br>
        <div class=3D"gmail_quote">
          <div dir=3D"ltr" class=3D"gmail_attr">On Wed, Aug 25, 2021 at 7:0=
3
            AM Christian K=C3=B6nig &lt;<a href=3D"mailto:ckoenig.leichtzum=
erken@gmail.com" target=3D"_blank">ckoenig.leichtzumerken@gmail.com</a>&gt;
            wrote:<br>
          </div>
          <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8=
ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
            <div> Using u8 is ok as well, just make sure that you don&#39;t
              have any hidden padding.<br>
              <br>
              Nirmoy had a tool to double check for paddings which I
              once more forgot the name of.<br>
            </div>
          </blockquote>
        </div>
      </blockquote>
    </blockquote>
    <p><br>
    </p>
    <p>Yes, pahole. pkg name: dwarves</p>
    <p><br>
    </p>
    <p>Nirmoy<br>
    </p>
    <p><br>
    </p>
    <blockquote type=3D"cite">
      <blockquote type=3D"cite">
        <div class=3D"gmail_quote">
          <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8=
ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
            <div> <br>
              Christian.<br>
              <br>
              <div>Am 25.08.21 um 12:40 schrieb Tom St Denis:<br>
              </div>
              <blockquote type=3D"cite">
                <div dir=3D"ltr">The struct works as is but I&#39;ll change
                  them to u32.=C2=A0 The offset is an artefact of the fact
                  this was an IOCTL originally.=C2=A0 I&#39;m working both =
ends
                  in parallel trying to make the changes at the same
                  time because I&#39;m only submitting the kernel patch if
                  I&#39;ve tested it in userspace.
                  <div><br>
                  </div>
                  <div>I&#39;ll send a v4 in a bit this morning....</div>
                  <div><br>
                  </div>
                  <div>Tom</div>
                </div>
                <br>
                <div class=3D"gmail_quote">
                  <div dir=3D"ltr" class=3D"gmail_attr">On Wed, Aug 25, 202=
1
                    at 2:35 AM Christian K=C3=B6nig &lt;<a href=3D"mailto:c=
koenig.leichtzumerken@gmail.com" target=3D"_blank">ckoenig.leichtzumerken@g=
mail.com</a>&gt;
                    wrote:<br>
                  </div>
                  <blockquote class=3D"gmail_quote" style=3D"margin:0px 0px=
 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><br>
                    <br>
                    Am 24.08.21 um 15:36 schrieb Tom St Denis:<br>
                    &gt; This new debugfs interface uses an IOCTL
                    interface in order to pass<br>
                    &gt; along state information like SRBM and GRBM bank
                    switching.=C2=A0 This<br>
                    &gt; new interface also allows a full 32-bit MMIO
                    address range which<br>
                    &gt; the previous didn&#39;t.=C2=A0 With this new desig=
n we
                    have room to grow<br>
                    &gt; the flexibility of the file as need be.<br>
                    &gt;<br>
                    &gt; (v2): Move read/write to .read/.write, fix
                    style, add comment<br>
                    &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 for IOCTL data structur=
e<br>
                    &gt;<br>
                    &gt; Signed-off-by: Tom St Denis &lt;<a href=3D"mailto:=
tom.stdenis@amd.com" target=3D"_blank">tom.stdenis@amd.com</a>&gt;<br>
                    &gt; ---<br>
                    &gt;=C2=A0 =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_debu=
gfs.c |
                    162 ++++++++++++++++++++<br>
                    &gt;=C2=A0 =C2=A0drivers/gpu/drm/amd/amdgpu/amdgpu_debu=
gfs.h
                    |=C2=A0 32 ++++<br>
                    &gt;=C2=A0 =C2=A02 files changed, 194 insertions(+)<br>
                    &gt;<br>
                    &gt; diff --git
                    a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
                    b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c<br>
                    &gt; index 277128846dd1..8e8f5743c8f5 100644<br>
                    &gt; ---
                    a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c<br>
                    &gt; +++
                    b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c<br>
                    &gt; @@ -279,6 +279,156 @@ static ssize_t
                    amdgpu_debugfs_regs_write(struct file *f, const char
                    __user *buf,<br>
                    &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return
                    amdgpu_debugfs_process_reg_op(false, f, (char __user
                    *)buf, size, pos);<br>
                    &gt;=C2=A0 =C2=A0}<br>
                    &gt;=C2=A0 =C2=A0<br>
                    &gt; +static int amdgpu_debugfs_regs2_open(struct
                    inode *inode, struct file *file)<br>
                    &gt; +{<br>
                    &gt; +=C2=A0 =C2=A0 =C2=A0struct amdgpu_debugfs_regs2_d=
ata *rd;<br>
                    &gt; +<br>
                    &gt; +=C2=A0 =C2=A0 =C2=A0rd =3D kzalloc(sizeof *rd, GF=
P_KERNEL);<br>
                    &gt; +=C2=A0 =C2=A0 =C2=A0if (!rd)<br>
                    &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0r=
eturn -ENOMEM;<br>
                    &gt; +=C2=A0 =C2=A0 =C2=A0rd-&gt;adev =3D
                    file_inode(file)-&gt;i_private;<br>
                    &gt; +=C2=A0 =C2=A0 =C2=A0file-&gt;private_data =3D rd;=
<br>
                    &gt; +<br>
                    &gt; +=C2=A0 =C2=A0 =C2=A0return 0;<br>
                    &gt; +}<br>
                    &gt; +<br>
                    &gt; +static int amdgpu_debugfs_regs2_release(struct
                    inode *inode, struct file *file)<br>
                    &gt; +{<br>
                    &gt; +=C2=A0 =C2=A0 =C2=A0kfree(file-&gt;private_data);=
<br>
                    &gt; +=C2=A0 =C2=A0 =C2=A0return 0;<br>
                    &gt; +}<br>
                    &gt; +<br>
                    &gt; +static ssize_t amdgpu_debugfs_regs2_op(struct
                    file *f, char __user *buf, size_t size, int
                    write_en)<br>
                    &gt; +{<br>
                    &gt; +=C2=A0 =C2=A0 =C2=A0struct amdgpu_debugfs_regs2_d=
ata *rd =3D
                    f-&gt;private_data;<br>
                    &gt; +=C2=A0 =C2=A0 =C2=A0struct amdgpu_device *adev =
=3D rd-&gt;adev;<br>
                    &gt; +=C2=A0 =C2=A0 =C2=A0ssize_t result =3D 0;<br>
                    &gt; +=C2=A0 =C2=A0 =C2=A0int r;<br>
                    &gt; +=C2=A0 =C2=A0 =C2=A0uint32_t value;<br>
                    &gt; +<br>
                    &gt; +=C2=A0 =C2=A0 =C2=A0if (size &amp; 0x3 || rd-&gt;=
state.offset
                    &amp; 0x3)<br>
                    &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0r=
eturn -EINVAL;<br>
                    &gt; +<br>
                    &gt; +=C2=A0 =C2=A0 =C2=A0if (rd-&gt;state.id.use_grbm)=
 {<br>
                    &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0i=
f (rd-&gt;<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3D=
http%3A%2F%2Fstate.id.grbm.se%2F&amp;data=3D04%7C01%7Cnirmoy.das%40amd.com%=
7Cf02eba2f047347488d5508d967b8bf96%7C3dd8961fe4884e608e11a82d994e183d%7C0%7=
C0%7C637654865456597676%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjo=
iV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DS7Fz7mMEeVYFqLF0=
paV%2BDr53Ty2e87lVIWFTvfZTJ%2Bs%3D&amp;reserved=3D0" rel=3D"noreferrer" tar=
get=3D"_blank">state.id.grbm.se</a> =3D=3D
                    0x3FF)<br>
                    &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0rd-&gt;<a href=3D"https://nam11.safelinks.protec=
tion.outlook.com/?url=3Dhttp%3A%2F%2Fstate.id.grbm.se%2F&amp;data=3D04%7C01=
%7Cnirmoy.das%40amd.com%7Cf02eba2f047347488d5508d967b8bf96%7C3dd8961fe4884e=
608e11a82d994e183d%7C0%7C0%7C637654865456597676%7CUnknown%7CTWFpbGZsb3d8eyJ=
WIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;=
sdata=3DS7Fz7mMEeVYFqLF0paV%2BDr53Ty2e87lVIWFTvfZTJ%2Bs%3D&amp;reserved=3D0=
" rel=3D"noreferrer" target=3D"_blank">state.id.grbm.se</a> =3D
                    0xFFFFFFFF;<br>
                    &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0i=
f (rd-&gt;<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3D=
http%3A%2F%2Fstate.id.grbm.sh%2F&amp;data=3D04%7C01%7Cnirmoy.das%40amd.com%=
7Cf02eba2f047347488d5508d967b8bf96%7C3dd8961fe4884e608e11a82d994e183d%7C0%7=
C0%7C637654865456607632%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjo=
iV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DiHxDEyZ7lz%2FGOd=
gSFHGbbAT2NPcQCQR0g58ISQMHGhY%3D&amp;reserved=3D0" rel=3D"noreferrer" targe=
t=3D"_blank">state.id.grbm.sh</a> =3D=3D
                    0x3FF)<br>
                    &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0rd-&gt;<a href=3D"https://nam11.safelinks.protec=
tion.outlook.com/?url=3Dhttp%3A%2F%2Fstate.id.grbm.sh%2F&amp;data=3D04%7C01=
%7Cnirmoy.das%40amd.com%7Cf02eba2f047347488d5508d967b8bf96%7C3dd8961fe4884e=
608e11a82d994e183d%7C0%7C0%7C637654865456607632%7CUnknown%7CTWFpbGZsb3d8eyJ=
WIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;=
sdata=3DiHxDEyZ7lz%2FGOdgSFHGbbAT2NPcQCQR0g58ISQMHGhY%3D&amp;reserved=3D0" =
rel=3D"noreferrer" target=3D"_blank">state.id.grbm.sh</a> =3D
                    0xFFFFFFFF;<br>
                    &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0i=
f (rd-&gt;state.id.grbm.instance
                    =3D=3D 0x3FF)<br>
                    &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0
                    =C2=A0rd-&gt;state.id.grbm.instance =3D 0xFFFFFFFF;<br>
                    &gt; +=C2=A0 =C2=A0 =C2=A0}<br>
                    &gt; +<br>
                    &gt; +=C2=A0 =C2=A0 =C2=A0r =3D
                    pm_runtime_get_sync(adev_to_drm(adev)-&gt;dev);<br>
                    &gt; +=C2=A0 =C2=A0 =C2=A0if (r &lt; 0) {<br>
                    &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
                    =C2=A0pm_runtime_put_autosuspend(adev_to_drm(adev)-&gt;=
dev);<br>
                    &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0r=
eturn r;<br>
                    &gt; +=C2=A0 =C2=A0 =C2=A0}<br>
                    &gt; +<br>
                    &gt; +=C2=A0 =C2=A0 =C2=A0r =3D
                    amdgpu_virt_enable_access_debugfs(adev);<br>
                    &gt; +=C2=A0 =C2=A0 =C2=A0if (r &lt; 0) {<br>
                    &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
                    =C2=A0pm_runtime_put_autosuspend(adev_to_drm(adev)-&gt;=
dev);<br>
                    &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0r=
eturn r;<br>
                    &gt; +=C2=A0 =C2=A0 =C2=A0}<br>
                    &gt; +<br>
                    &gt; +=C2=A0 =C2=A0 =C2=A0if (rd-&gt;state.id.use_grbm)=
 {<br>
                    &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0i=
f ((rd-&gt;<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=
=3Dhttp%3A%2F%2Fstate.id.grbm.sh%2F&amp;data=3D04%7C01%7Cnirmoy.das%40amd.c=
om%7Cf02eba2f047347488d5508d967b8bf96%7C3dd8961fe4884e608e11a82d994e183d%7C=
0%7C0%7C637654865456607632%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQ=
IjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DiHxDEyZ7lz%2F=
GOdgSFHGbbAT2NPcQCQR0g58ISQMHGhY%3D&amp;reserved=3D0" rel=3D"noreferrer" ta=
rget=3D"_blank">state.id.grbm.sh</a> !=3D
                    0xFFFFFFFF &amp;&amp; rd-&gt;<a href=3D"https://nam11.s=
afelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fstate.id.grbm.sh%2F&amp=
;data=3D04%7C01%7Cnirmoy.das%40amd.com%7Cf02eba2f047347488d5508d967b8bf96%7=
C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637654865456617591%7CUnknown%7C=
TWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0=
%3D%7C1000&amp;sdata=3DjhS3kKxQAAn18tfFNC7pYnZKEKps4zVXdsX%2FIFLH7a4%3D&amp=
;reserved=3D0" rel=3D"noreferrer" target=3D"_blank">state.id.grbm.sh</a> &g=
t;=3D
                    adev-&gt;gfx.config.max_sh_per_se) ||<br>
                    &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0(rd-&gt;<a href=3D"https://nam11.safelinks.protection.outlook.=
com/?url=3Dhttp%3A%2F%2Fstate.id.grbm.se%2F&amp;data=3D04%7C01%7Cnirmoy.das=
%40amd.com%7Cf02eba2f047347488d5508d967b8bf96%7C3dd8961fe4884e608e11a82d994=
e183d%7C0%7C0%7C637654865456617591%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAw=
MDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DJ1Wzn=
gpR3KOnPsstL3mpbhltQIp0idV6B22%2BZqZpXoQ%3D&amp;reserved=3D0" rel=3D"norefe=
rrer" target=3D"_blank">state.id.grbm.se</a> !=3D
                    0xFFFFFFFF &amp;&amp; rd-&gt;<a href=3D"https://nam11.s=
afelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fstate.id.grbm.se%2F&amp=
;data=3D04%7C01%7Cnirmoy.das%40amd.com%7Cf02eba2f047347488d5508d967b8bf96%7=
C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637654865456617591%7CUnknown%7C=
TWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0=
%3D%7C1000&amp;sdata=3DJ1WzngpR3KOnPsstL3mpbhltQIp0idV6B22%2BZqZpXoQ%3D&amp=
;reserved=3D0" rel=3D"noreferrer" target=3D"_blank">state.id.grbm.se</a> &g=
t;=3D
                    adev-&gt;gfx.config.max_shader_engines)) {<br>
                    &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0
                    =C2=A0pm_runtime_mark_last_busy(adev_to_drm(adev)-&gt;d=
ev);<br>
                    &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0
                    =C2=A0pm_runtime_put_autosuspend(adev_to_drm(adev)-&gt;=
dev);<br>
                    &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0
                    =C2=A0amdgpu_virt_disable_access_debugfs(adev);<br>
                    &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<br>
                    &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}=
<br>
                    &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
                    =C2=A0mutex_lock(&amp;adev-&gt;grbm_idx_mutex);<br>
                    &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0a=
mdgpu_gfx_select_se_sh(adev,
                    rd-&gt;<a href=3D"https://nam11.safelinks.protection.ou=
tlook.com/?url=3Dhttp%3A%2F%2Fstate.id.grbm.se%2F&amp;data=3D04%7C01%7Cnirm=
oy.das%40amd.com%7Cf02eba2f047347488d5508d967b8bf96%7C3dd8961fe4884e608e11a=
82d994e183d%7C0%7C0%7C637654865456627544%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC=
4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=
=3DmElFqeL4bHf%2FcNlWTVyoxT6VhHnoLKVOCwCpsWiqLkM%3D&amp;reserved=3D0" rel=
=3D"noreferrer" target=3D"_blank">state.id.grbm.se</a>,<br>
                    &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
                    =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
rd-&gt;<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhtt=
p%3A%2F%2Fstate.id.grbm.sh%2F&amp;data=3D04%7C01%7Cnirmoy.das%40amd.com%7Cf=
02eba2f047347488d5508d967b8bf96%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%=
7C637654865456627544%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2=
luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DR2jlWr%2BtB%2FKypqH=
KT36JV%2Fnk2CvO2oLYIspKmfbco58%3D&amp;reserved=3D0" rel=3D"noreferrer" targ=
et=3D"_blank">state.id.grbm.sh</a>,<br>
                    &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
                    =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
rd-&gt;state.id.grbm.instance);<br>
                    &gt; +=C2=A0 =C2=A0 =C2=A0}<br>
                    &gt; +<br>
                    &gt; +=C2=A0 =C2=A0 =C2=A0if (rd-&gt;state.id.use_srbm)=
 {<br>
                    &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
                    =C2=A0mutex_lock(&amp;adev-&gt;srbm_mutex);<br>
                    &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0a=
mdgpu_gfx_select_me_pipe_q(adev,
                    rd-&gt;<a href=3D"https://nam11.safelinks.protection.ou=
tlook.com/?url=3Dhttp%3A%2F%2Fstate.id.srbm.me%2F&amp;data=3D04%7C01%7Cnirm=
oy.das%40amd.com%7Cf02eba2f047347488d5508d967b8bf96%7C3dd8961fe4884e608e11a=
82d994e183d%7C0%7C0%7C637654865456637501%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC=
4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=
=3Dv8e4VpGjaYi1LcWVBxTYx7f4v%2BUW9%2F6FTpYvGqygJc0%3D&amp;reserved=3D0" rel=
=3D"noreferrer" target=3D"_blank">state.id.srbm.me</a>,
                    rd-&gt;state.id.srbm.pipe,<br>
                    &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
                    =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0rd-&gt;state.id.srbm.queue,
                    rd-&gt;state.id.srbm.vmid);<br>
                    &gt; +=C2=A0 =C2=A0 =C2=A0}<br>
                    &gt; +<br>
                    &gt; +=C2=A0 =C2=A0 =C2=A0if (rd-&gt;state.id.pg_lock)<=
br>
                    &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
                    =C2=A0mutex_lock(&amp;adev-&gt;pm.mutex);<br>
                    &gt; +<br>
                    &gt; +=C2=A0 =C2=A0 =C2=A0while (size) {<br>
                    &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0i=
f (!write_en) {<br>
                    &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0value =3D
                    RREG32(rd-&gt;state.offset &gt;&gt; 2);<br>
                    &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0r =3D put_user(value,
                    (uint32_t *)buf);<br>
                    &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}=
 else {<br>
                    &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0r =3D get_user(value,
                    (uint32_t *)buf);<br>
                    &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0if (!r)<br>
                    &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
                    =C2=A0amdgpu_mm_wreg_mmio_rlc(adev, rd-&gt;state.offset
                    &gt;&gt; 2, value);<br>
                    &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}=
<br>
                    &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0i=
f (r) {<br>
                    &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0result =3D r;<br>
                    &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0goto end;<br>
                    &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}=
<br>
                    &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0r=
d-&gt;state.offset +=3D 4;<br>
                    &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s=
ize -=3D 4;<br>
                    &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0r=
esult +=3D 4;<br>
                    &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0b=
uf +=3D 4;<br>
                    &gt; +=C2=A0 =C2=A0 =C2=A0}<br>
                    &gt; +end:<br>
                    &gt; +=C2=A0 =C2=A0 =C2=A0if (rd-&gt;state.id.use_grbm)=
 {<br>
                    &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0a=
mdgpu_gfx_select_se_sh(adev,
                    0xffffffff, 0xffffffff, 0xffffffff);<br>
                    &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
                    =C2=A0mutex_unlock(&amp;adev-&gt;grbm_idx_mutex);<br>
                    &gt; +=C2=A0 =C2=A0 =C2=A0}<br>
                    &gt; +<br>
                    &gt; +=C2=A0 =C2=A0 =C2=A0if (rd-&gt;state.id.use_srbm)=
 {<br>
                    &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0a=
mdgpu_gfx_select_me_pipe_q(adev,
                    0, 0, 0, 0);<br>
                    &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
                    =C2=A0mutex_unlock(&amp;adev-&gt;srbm_mutex);<br>
                    &gt; +=C2=A0 =C2=A0 =C2=A0}<br>
                    &gt; +<br>
                    &gt; +=C2=A0 =C2=A0 =C2=A0if (rd-&gt;state.id.pg_lock)<=
br>
                    &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0
                    =C2=A0mutex_unlock(&amp;adev-&gt;pm.mutex);<br>
                    &gt; +<br>
                    &gt; +=C2=A0 =C2=A0 =C2=A0// in umr (the likely user of=
 this) flags
                    are set per file operation<br>
                    &gt; +=C2=A0 =C2=A0 =C2=A0// which means they&#39;re ne=
ver &quot;unset&quot;
                    explicitly.=C2=A0 To avoid breaking<br>
                    &gt; +=C2=A0 =C2=A0 =C2=A0// this convention we unset t=
he flags
                    after each operation<br>
                    &gt; +=C2=A0 =C2=A0 =C2=A0// flags are for a single cal=
l (need to
                    be set for every read/write)<br>
                    &gt; +=C2=A0 =C2=A0 =C2=A0rd-&gt;state.id.use_grbm =3D =
0;<br>
                    &gt; +=C2=A0 =C2=A0 =C2=A0rd-&gt;state.id.use_srbm =3D =
0;<br>
                    &gt; +=C2=A0 =C2=A0 =C2=A0rd-&gt;state.id.pg_lock=C2=A0=
 =3D 0;<br>
                    &gt; +<br>
                    &gt; +=C2=A0 =C2=A0
                    =C2=A0pm_runtime_mark_last_busy(adev_to_drm(adev)-&gt;d=
ev);<br>
                    &gt; +=C2=A0 =C2=A0
                    =C2=A0pm_runtime_put_autosuspend(adev_to_drm(adev)-&gt;=
dev);<br>
                    &gt; +<br>
                    &gt; +=C2=A0 =C2=A0 =C2=A0amdgpu_virt_disable_access_de=
bugfs(adev);<br>
                    &gt; +=C2=A0 =C2=A0 =C2=A0return result;<br>
                    &gt; +}<br>
                    &gt; +<br>
                    &gt; +static long amdgpu_debugfs_regs2_ioctl(struct
                    file *f, unsigned int cmd, unsigned long data)<br>
                    &gt; +{<br>
                    &gt; +=C2=A0 =C2=A0 =C2=A0struct amdgpu_debugfs_regs2_d=
ata *rd =3D
                    f-&gt;private_data;<br>
                    &gt; +<br>
                    &gt; +=C2=A0 =C2=A0 =C2=A0switch (cmd) {<br>
                    &gt; +=C2=A0 =C2=A0 =C2=A0case AMDGPU_DEBUGFS_REGS2_IOC=
_SET_STATE:<br>
                    &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0i=
f (copy_from_user(&amp;rd-&gt;<a href=3D"https://nam11.safelinks.protection=
.outlook.com/?url=3Dhttp%3A%2F%2Fstate.id%2F&amp;data=3D04%7C01%7Cnirmoy.da=
s%40amd.com%7Cf02eba2f047347488d5508d967b8bf96%7C3dd8961fe4884e608e11a82d99=
4e183d%7C0%7C0%7C637654865456637501%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjA=
wMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DowOC=
Pq7DugPj8bKIZW%2BPL9O1HXIViFHCq8ZqSkIT4X4%3D&amp;reserved=3D0" rel=3D"noref=
errer" target=3D"_blank">state.id</a>, (struct
                    amdgpu_debugfs_regs2_iocdata *)data, sizeof rd-&gt;<a h=
ref=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fs=
tate.id%2F&amp;data=3D04%7C01%7Cnirmoy.das%40amd.com%7Cf02eba2f047347488d55=
08d967b8bf96%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C63765486545663750=
1%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1ha=
WwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=3DowOCPq7DugPj8bKIZW%2BPL9O1HXIViFHCq8Zq=
SkIT4X4%3D&amp;reserved=3D0" rel=3D"noreferrer" target=3D"_blank">state.id<=
/a>))<br>
                    &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;<br>
                    &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0b=
reak;<br>
                    &gt; +=C2=A0 =C2=A0 =C2=A0default:<br>
                    &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0r=
eturn -EINVAL;<br>
                    &gt; +=C2=A0 =C2=A0 =C2=A0}<br>
                    &gt; +=C2=A0 =C2=A0 =C2=A0return 0;<br>
                    &gt; +}<br>
                    &gt; +<br>
                    &gt; +static ssize_t
                    amdgpu_debugfs_regs2_read(struct file *f, char
                    __user *buf, size_t size, loff_t *pos)<br>
                    &gt; +{<br>
                    &gt; +=C2=A0 =C2=A0 =C2=A0struct amdgpu_debugfs_regs2_d=
ata *rd =3D
                    f-&gt;private_data;<br>
                    &gt; +=C2=A0 =C2=A0 =C2=A0rd-&gt;state.offset =3D *pos;=
<br>
                    &gt; +=C2=A0 =C2=A0 =C2=A0return amdgpu_debugfs_regs2_o=
p(f, buf,
                    size, 0);<br>
                    &gt; +}<br>
                    &gt; +<br>
                    &gt; +static ssize_t
                    amdgpu_debugfs_regs2_write(struct file *f, const
                    char __user *buf, size_t size, loff_t *pos)<br>
                    &gt; +{<br>
                    &gt; +=C2=A0 =C2=A0 =C2=A0struct amdgpu_debugfs_regs2_d=
ata *rd =3D
                    f-&gt;private_data;<br>
                    &gt; +=C2=A0 =C2=A0 =C2=A0rd-&gt;state.offset =3D *pos;=
<br>
                    &gt; +=C2=A0 =C2=A0 =C2=A0return amdgpu_debugfs_regs2_o=
p(f, (char
                    __user *)buf, size, 1);<br>
                    &gt; +}<br>
                    &gt; +<br>
                    &gt;=C2=A0 =C2=A0<br>
                    &gt;=C2=A0 =C2=A0/**<br>
                    &gt;=C2=A0 =C2=A0 * amdgpu_debugfs_regs_pcie_read - Rea=
d from
                    a PCIE register<br>
                    &gt; @@ -1091,6 +1241,16 @@ static ssize_t
                    amdgpu_debugfs_gfxoff_read(struct file *f, char
                    __user *buf,<br>
                    &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0return result;<br>
                    &gt;=C2=A0 =C2=A0}<br>
                    &gt;=C2=A0 =C2=A0<br>
                    &gt; +static const struct file_operations
                    amdgpu_debugfs_regs2_fops =3D {<br>
                    &gt; +=C2=A0 =C2=A0 =C2=A0.owner =3D THIS_MODULE,<br>
                    &gt; +=C2=A0 =C2=A0 =C2=A0.unlocked_ioctl =3D
                    amdgpu_debugfs_regs2_ioctl,<br>
                    &gt; +=C2=A0 =C2=A0 =C2=A0.read =3D amdgpu_debugfs_regs=
2_read,<br>
                    &gt; +=C2=A0 =C2=A0 =C2=A0.write =3D amdgpu_debugfs_reg=
s2_write,<br>
                    &gt; +=C2=A0 =C2=A0 =C2=A0.open =3D amdgpu_debugfs_regs=
2_open,<br>
                    &gt; +=C2=A0 =C2=A0 =C2=A0.release =3D amdgpu_debugfs_r=
egs2_release,<br>
                    &gt; +=C2=A0 =C2=A0 =C2=A0.llseek =3D default_llseek<br=
>
                    &gt; +};<br>
                    &gt; +<br>
                    &gt;=C2=A0 =C2=A0static const struct file_operations
                    amdgpu_debugfs_regs_fops =3D {<br>
                    &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0.owner =3D THIS_MODULE,<=
br>
                    &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0.read =3D amdgpu_debugfs=
_regs_read,<br>
                    &gt; @@ -1148,6 +1308,7 @@ static const struct
                    file_operations amdgpu_debugfs_gfxoff_fops =3D {<br>
                    &gt;=C2=A0 =C2=A0<br>
                    &gt;=C2=A0 =C2=A0static const struct file_operations
                    *debugfs_regs[] =3D {<br>
                    &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;amdgpu_debugfs_regs=
_fops,<br>
                    &gt; +=C2=A0 =C2=A0 =C2=A0&amp;amdgpu_debugfs_regs2_fop=
s,<br>
                    &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;amdgpu_debugfs_regs=
_didt_fops,<br>
                    &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;amdgpu_debugfs_regs=
_pcie_fops,<br>
                    &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;amdgpu_debugfs_regs=
_smc_fops,<br>
                    &gt; @@ -1160,6 +1321,7 @@ static const struct
                    file_operations *debugfs_regs[] =3D {<br>
                    &gt;=C2=A0 =C2=A0<br>
                    &gt;=C2=A0 =C2=A0static const char *debugfs_regs_names[=
] =3D {<br>
                    &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;amdgpu_regs&quot;,=
<br>
                    &gt; +=C2=A0 =C2=A0 =C2=A0&quot;amdgpu_regs2&quot;,<br>
                    &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;amdgpu_regs_didt&q=
uot;,<br>
                    &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;amdgpu_regs_pcie&q=
uot;,<br>
                    &gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;amdgpu_regs_smc&qu=
ot;,<br>
                    &gt; diff --git
                    a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
                    b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h<br>
                    &gt; index 141a8474e24f..ec044df5d428 100644<br>
                    &gt; ---
                    a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h<br>
                    &gt; +++
                    b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h<br>
                    &gt; @@ -22,6 +22,8 @@<br>
                    &gt;=C2=A0 =C2=A0 * OTHER DEALINGS IN THE SOFTWARE.<br>
                    &gt;=C2=A0 =C2=A0 *<br>
                    &gt;=C2=A0 =C2=A0 */<br>
                    &gt; +#include &lt;linux/ioctl.h&gt;<br>
                    &gt; +#include &lt;uapi/drm/amdgpu_drm.h&gt;<br>
                    &gt;=C2=A0 =C2=A0<br>
                    &gt;=C2=A0 =C2=A0/*<br>
                    &gt;=C2=A0 =C2=A0 * Debugfs<br>
                    &gt; @@ -38,3 +40,33 @@ void
                    amdgpu_debugfs_fence_init(struct amdgpu_device
                    *adev);<br>
                    &gt;=C2=A0 =C2=A0void amdgpu_debugfs_firmware_init(stru=
ct
                    amdgpu_device *adev);<br>
                    &gt;=C2=A0 =C2=A0void amdgpu_debugfs_gem_init(struct
                    amdgpu_device *adev);<br>
                    &gt;=C2=A0 =C2=A0int amdgpu_debugfs_wait_dump(struct
                    amdgpu_device *adev);<br>
                    &gt; +<br>
                    &gt; +/*<br>
                    &gt; + * MMIO debugfs IOCTL structure<br>
                    &gt; + */<br>
                    &gt; +struct amdgpu_debugfs_regs2_iocdata {<br>
                    &gt; +=C2=A0 =C2=A0 =C2=A0__u8 use_srbm, use_grbm, pg_l=
ock;<br>
                    <br>
                    You should consider using u32 here as well or add
                    explicitly padding.<br>
                    <br>
                    &gt; +=C2=A0 =C2=A0 =C2=A0struct {<br>
                    &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0_=
_u32 se, sh, instance;<br>
                    &gt; +=C2=A0 =C2=A0 =C2=A0} grbm;<br>
                    &gt; +=C2=A0 =C2=A0 =C2=A0struct {<br>
                    &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0_=
_u32 me, pipe, queue, vmid;<br>
                    &gt; +=C2=A0 =C2=A0 =C2=A0} srbm;<br>
                    &gt; +};<br>
                    &gt; +<br>
                    &gt; +/*<br>
                    &gt; + * MMIO debugfs state data (per file* handle)<br>
                    &gt; + */<br>
                    &gt; +struct amdgpu_debugfs_regs2_data {<br>
                    &gt; +=C2=A0 =C2=A0 =C2=A0struct amdgpu_device *adev;<b=
r>
                    &gt; +=C2=A0 =C2=A0 =C2=A0struct {<br>
                    &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0s=
truct
                    amdgpu_debugfs_regs2_iocdata id;<br>
                    &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0_=
_u32 offset;<br>
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
                    &gt; +=C2=A0 =C2=A0 =C2=A0AMDGPU_DEBUGFS_REGS2_CMD_SET_=
STATE=3D0,<br>
                    &gt; +};<br>
                    &gt; +<br>
                    &gt; +#define AMDGPU_DEBUGFS_REGS2_IOC_SET_STATE
                    _IOWR(0x20, AMDGPU_DEBUGFS_REGS2_CMD_SET_STATE,
                    struct amdgpu_debugfs_regs2_iocdata)<br>
                    <br>
                  </blockquote>
                </div>
              </blockquote>
              <br>
            </div>
          </blockquote>
        </div>
      </blockquote>
      <br>
    </blockquote>
  </div>

</blockquote></div>

--0000000000004c42c605ca6096ae--
