Return-Path: <SRS0=c7t5=NP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 347C7C4338F
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Aug 2021 13:22:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA06761262
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Aug 2021 13:22:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org EA06761262
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75990899E7;
	Tue, 24 Aug 2021 13:22:29 +0000 (UTC)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76EFB899E7
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Aug 2021 13:22:28 +0000 (UTC)
Received: by mail-wm1-x334.google.com with SMTP id
 j14-20020a1c230e000000b002e748b9a48bso1829651wmj.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Aug 2021 06:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language;
 bh=uB7XZBgEI6Iw6pAtx91c2eR3eoq3wMdYSkIPqPs93pA=;
 b=LPMwEo+ZSr/SRYQyOkJuxleYJ6kJZ8IBIU5ZJ5nihylhTsjIwTx7lHNgoCWmkxBpCx
 XeA70Xnfa8ZLr73z6ee/yGPoOwMvLgc00nv8u4VzNMHfXPMb3ev60oM9adbgwORo0b55
 5eiYVk0weGmqwjkt8dgK4NV0RFJE4aLrXYt6krDw51s+RPe8kxTVwwJFLaLA6fnPWV+D
 9iVQac1W2spMX8ZSka3raVhfjpnDKDI98PHLC9k30z4dUxDpVSTWxC6J806dlz6ErOHP
 HfK5MFjDAT1ksjch8OWHxcRGY5Qn5wPybSnoXaA5lVtWzjM8bTzpBkM7GgpJV+zJKHB2
 LohA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language;
 bh=uB7XZBgEI6Iw6pAtx91c2eR3eoq3wMdYSkIPqPs93pA=;
 b=nMczeubA0yHv5Hi9ZEd/MFCDXY6b4fAYixa69+BGqPpgGh0M8vOFjkiGQt+5X5j/Yl
 oQTuekxtYHSuBlIfWxxPE1DDora7Awqike45A40Eq5lmAmxd8OJj+MnEjoXmgZDXZbuj
 Zu8s1F6N7LFCf4M3LK1ZSlqlkLQYqFGiHeF6PO4kn03+dfGDSv0x5Jn0dCP8F4wvXVhB
 ZQxFRChR8XKKrDxZ0fW4/fCe0YLT7Clknps8xz0jeRH4V9Zrfu1mYgrR5NmVs6N7dytY
 Si3pG36UxZ5bmN1YAOxVZUy55BzUF8HQpwt3NF5TRKBY4Eg1ODjKYlkZb84vRoURS76+
 TLug==
X-Gm-Message-State: AOAM533jYbMxLWZfeFm8VI2wm4Uy2rtNg21VZS7f78cCSId3lUi9Lr1v
 9gDn0mxgPK0oYUKsDxEAGNOY9VhOczI31JZu
X-Google-Smtp-Source: ABdhPJy3BfSAWe+52zwXbyMH56J380ukMKZ5WrSllqC+QDQkIiVw1PtWqDgh2uXl5CvAWVM2IT0TwQ==
X-Received: by 2002:a1c:7f90:: with SMTP id a138mr4063022wmd.33.1629811347022; 
 Tue, 24 Aug 2021 06:22:27 -0700 (PDT)
Received: from [192.168.178.21] (p5b0ea1b5.dip0.t-ipconnect.de.
 [91.14.161.181])
 by smtp.gmail.com with ESMTPSA id a133sm2338205wme.5.2021.08.24.06.22.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Aug 2021 06:22:20 -0700 (PDT)
Subject: Re: [PATCH] drm/amd/amdgpu: New debugfs interface for MMIO registers
To: Tom St Denis <tstdenis82@gmail.com>
Cc: "StDenis, Tom" <Tom.StDenis@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20210824121618.99839-1-tom.stdenis@amd.com>
 <f0ada58f-f6c8-89f1-3036-065c908696b2@gmail.com>
 <DM6PR12MB35475954BCF1B73048B662FEF7C59@DM6PR12MB3547.namprd12.prod.outlook.com>
 <baeaf8da-6c4a-516b-823e-224a0ac80471@gmail.com>
 <CAAzXoRKWy74Wst_1br+N37dkO+5Uode4+zwQpEtM9su+JA9oLg@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <8d7546ee-0b10-8505-ee4e-bdf4b41b630f@gmail.com>
Date: Tue, 24 Aug 2021 15:22:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAAzXoRKWy74Wst_1br+N37dkO+5Uode4+zwQpEtM9su+JA9oLg@mail.gmail.com>
Content-Type: multipart/alternative;
 boundary="------------387DDBF763F9491FC7706089"
Content-Language: en-US
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

This is a multi-part message in MIME format.
--------------387DDBF763F9491FC7706089
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 24.08.21 um 14:42 schrieb Tom St Denis:
> The IOCTL data is in the debugfs header as it is. I could move that to 
> the amdgpu_drm.h and include it from amdgpu_debugfs.h.

Na, keep it like that and just add a comment.

On second thought I don't want to raise any discussion on the mailing 
list if we should have a debugfs structure in the UAPI headers.

Christian.

>
> I'll re-write the STATE IOCTL to use a struct and then test against 
> what I have in umr.
>
> Refactoring the read/write is trivial and I'll do that no problem 
> (with style fixes).
>
> Cheers,
> Tom
>
> On Tue, Aug 24, 2021 at 8:34 AM Christian König 
> <ckoenig.leichtzumerken@gmail.com 
> <mailto:ckoenig.leichtzumerken@gmail.com>> wrote:
>
>     Am 24.08.21 um 14:27 schrieb StDenis, Tom:
>     > [AMD Official Use Only]
>     >
>     > What do you mean a "shared header?"  How would they be shared
>     between kernel and user?
>
>     Somewhere in the include/uapi/drm/ folder I think. Either add that to
>     amdgpu_drm.h or maybe amdgpu_debugfs.h?
>
>     Or just keep it as a structure in amdgpu_debugfs.h with a comment
>     that
>     it is used for an IOCTL.
>
>     Just not something hard coded like first byte is this, second that
>     etc....
>
>     > As for why not read/write.  Jus wanted to keep it simple.  It's
>     not really performance bound.  umr never does reads/writes larger
>     than 32-bits anyways.  It doesn't have to be this way though but I
>     figured the fewer LOC the better.
>
>     I think it would be cleaner if we would have separate functions
>     for this.
>
>     As far as I can see you also don't need the dance with the power
>     managerment etc for the IOCTL. It's just get_user() into your
>     structure.
>
>     BTW: In the kernel coding style put "switch" and "case" on the same
>     column, otherwise checkpatch.pl <http://checkpatch.pl> might complain.
>
>     Christian.
>
>     >
>     > Tom
>     >
>     > ________________________________________
>     > From: Christian König <ckoenig.leichtzumerken@gmail.com
>     <mailto:ckoenig.leichtzumerken@gmail.com>>
>     > Sent: Tuesday, August 24, 2021 08:20
>     > To: StDenis, Tom; amd-gfx@lists.freedesktop.org
>     <mailto:amd-gfx@lists.freedesktop.org>
>     > Subject: Re: [PATCH] drm/amd/amdgpu: New debugfs interface for
>     MMIO registers
>     >
>     >
>     >
>     > Am 24.08.21 um 14:16 schrieb Tom St Denis:
>     >> This new debugfs interface uses an IOCTL interface in order to pass
>     >> along state information like SRBM and GRBM bank switching.  This
>     >> new interface also allows a full 32-bit MMIO address range which
>     >> the previous didn't.  With this new design we have room to grow
>     >> the flexibility of the file as need be.
>     >>
>     >> Signed-off-by: Tom St Denis <tom.stdenis@amd.com
>     <mailto:tom.stdenis@amd.com>>
>     >> ---
>     >>    drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 177
>     ++++++++++++++++++++
>     >>    drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h |  32 ++++
>     >>    2 files changed, 209 insertions(+)
>     >>
>     >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>     b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>     >> index 277128846dd1..ab2d92f84da5 100644
>     >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>     >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>     >> @@ -279,6 +279,173 @@ static ssize_t
>     amdgpu_debugfs_regs_write(struct file *f, const char __user *buf,
>     >>        return amdgpu_debugfs_process_reg_op(false, f, (char
>     __user *)buf, size, pos);
>     >>    }
>     >>
>     >> +static int amdgpu_debugfs_regs2_open(struct inode *inode,
>     struct file *file)
>     >> +{
>     >> +     struct amdgpu_debugfs_regs2_data *rd;
>     >> +
>     >> +     rd = kzalloc(sizeof *rd, GFP_KERNEL);
>     >> +     if (!rd)
>     >> +             return -ENOMEM;
>     >> +     rd->adev = file_inode(file)->i_private;
>     >> +     file->private_data = rd;
>     >> +
>     >> +     return 0;
>     >> +}
>     >> +
>     >> +static int amdgpu_debugfs_regs2_release(struct inode *inode,
>     struct file *file)
>     >> +{
>     >> +     kfree(file->private_data);
>     >> +     return 0;
>     >> +}
>     >> +
>     >> +static int amdgpu_debugfs_regs2_op(struct file *f, char __user
>     *buf, int write_en)
>     >> +{
>     >> +     struct amdgpu_debugfs_regs2_data *rd = f->private_data;
>     >> +     struct amdgpu_device *adev = rd->adev;
>     >> +     int result = 0, r;
>     >> +     uint32_t value;
>     >> +
>     >> +     if (rd->state.offset & 0x3)
>     >> +             return -EINVAL;
>     >> +
>     >> +     if (rd->state.use_grbm) {
>     >> +             if (rd->state.grbm.se <http://state.grbm.se> ==
>     0x3FF)
>     >> +                     rd->state.grbm.se <http://state.grbm.se>
>     = 0xFFFFFFFF;
>     >> +             if (rd->state.grbm.sh <http://state.grbm.sh> ==
>     0x3FF)
>     >> +                     rd->state.grbm.sh <http://state.grbm.sh>
>     = 0xFFFFFFFF;
>     >> +             if (rd->state.grbm.instance == 0x3FF)
>     >> +                     rd->state.grbm.instance = 0xFFFFFFFF;
>     >> +     }
>     >> +
>     >> +     r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
>     >> +     if (r < 0) {
>     >> +  pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>     >> +             return r;
>     >> +     }
>     >> +
>     >> +     r = amdgpu_virt_enable_access_debugfs(adev);
>     >> +     if (r < 0) {
>     >> +  pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>     >> +             return r;
>     >> +     }
>     >> +
>     >> +     if (rd->state.use_grbm) {
>     >> +             if ((rd->state.grbm.sh <http://state.grbm.sh> !=
>     0xFFFFFFFF && rd->state.grbm.sh <http://state.grbm.sh> >=
>     adev->gfx.config.max_sh_per_se) ||
>     >> +                 (rd->state.grbm.se <http://state.grbm.se> !=
>     0xFFFFFFFF && rd->state.grbm.se <http://state.grbm.se> >=
>     adev->gfx.config.max_shader_engines)) {
>     >> +  pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
>     >> +  pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>     >> +  amdgpu_virt_disable_access_debugfs(adev);
>     >> +                     return -EINVAL;
>     >> +             }
>     >> +  mutex_lock(&adev->grbm_idx_mutex);
>     >> +             amdgpu_gfx_select_se_sh(adev, rd->state.grbm.se
>     <http://state.grbm.se>,
>     >> +          rd->state.grbm.sh <http://state.grbm.sh>,
>     >> +          rd->state.grbm.instance);
>     >> +     } else if (rd->state.use_grbm) {
>     >> +             mutex_lock(&adev->srbm_mutex);
>     >> +             amdgpu_gfx_select_me_pipe_q(adev,
>     rd->state.srbm.me <http://state.srbm.me>, rd->state.srbm.pipe,
>     >> +                  rd->state.srbm.queue, rd->state.srbm.vmid);
>     >> +     }
>     >> +
>     >> +     if (rd->state.pg_lock)
>     >> +             mutex_lock(&adev->pm.mutex);
>     >> +
>     >> +     if (!write_en) {
>     >> +             value = RREG32(rd->state.offset >> 2);
>     >> +             r = put_user(value, (uint32_t *)buf);
>     >> +     } else {
>     >> +             r = get_user(value, (uint32_t *)buf);
>     >> +             if (!r)
>     >> +                     amdgpu_mm_wreg_mmio_rlc(adev,
>     rd->state.offset >> 2, value);
>     >> +     }
>     >> +     if (r) {
>     >> +             result = r;
>     >> +             goto end;
>     >> +     }
>     >> +     result = 0;
>     >> +end:
>     >> +     if (rd->state.use_grbm) {
>     >> +             amdgpu_gfx_select_se_sh(adev, 0xffffffff,
>     0xffffffff, 0xffffffff);
>     >> +  mutex_unlock(&adev->grbm_idx_mutex);
>     >> +     } else if (rd->state.use_srbm) {
>     >> +             amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, 0);
>     >> +             mutex_unlock(&adev->srbm_mutex);
>     >> +     }
>     >> +
>     >> +     if (rd->state.pg_lock)
>     >> +             mutex_unlock(&adev->pm.mutex);
>     >> +
>     >> +     // in umr (the likely user of this) flags are set per
>     file operation
>     >> +     // which means they're never "unset" explicitly.  To
>     avoid breaking
>     >> +     // this convention we unset the flags after each operation
>     >> +     // flags are for a single call (need to be set for every
>     read/write)
>     >> +     rd->state.use_grbm = 0;
>     >> +     rd->state.use_srbm = 0;
>     >> +     rd->state.pg_lock  = 0;
>     >> +
>     >> +  pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
>     >> +  pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>     >> +
>     >> +     amdgpu_virt_disable_access_debugfs(adev);
>     >> +     return result;
>     >> +}
>     >> +
>     >> +static long amdgpu_debugfs_regs2_ioctl(struct file *f,
>     unsigned int cmd, unsigned long data)
>     >> +{
>     >> +     struct amdgpu_debugfs_regs2_data *rd = f->private_data;
>     >> +     unsigned char st[32], v;
>     >> +     int r, x;
>     >> +
>     >> +     // always read first 4 bytes of data
>     >> +     for (x = 0; x < 4; x++) {
>     >> +             if ((r = get_user(v, (unsigned char *)data))) {
>     >> +                     return r;
>     >> +             }
>     >> +             ++data;
>     >> +             st[x] = v;
>     >> +     }
>     >> +
>     >> +     // first 4 bytes are offset
>     >> +     rd->state.offset = ((u32)st[0]) | ((u32)st[1] << 8) |
>     >> +                                        ((u32)st[2] << 16) |
>     ((u32)st[3] << 24);
>     >> +
>     >> +     switch (cmd) {
>     >> +             case AMDGPU_DEBUGFS_REGS2_IOC_SET_STATE:
>     >> +                     for (x = 4; x < 32; x++) {
>     >> +                             if ((r = get_user(v, (unsigned
>     char *)data))) {
>     >> +                                     return r;
>     >> +                             }
>     >> +                             ++data;
>     >> +                             st[x] = v;
>     >> +                     }
>     >> +
>     >> +                     // next byte contains the flag
>     >> +                     // we only consume the remainder of the
>     state if bit 1 is set
>     >> +                     // this allows the subsequent read/write
>     >> +                     rd->state.use_grbm = (st[4] & 1) ? 1 : 0;
>     >> +                     rd->state.use_srbm = (st[4] & 2) ? 1 : 0;
>     >> +                     rd->state.pg_lock  = (st[4] & 4) ? 1 : 0;
>     >> +
>     >> +                     // next 6 bytes are grbm data
>     >> +                     rd->state.grbm.se <http://state.grbm.se> 
>          = ((u32)st[5]) | ((u32)st[6] << 8);
>     >> +                     rd->state.grbm.sh <http://state.grbm.sh> 
>          = ((u32)st[7]) | ((u32)st[8] << 8);
>     >> +                     rd->state.grbm.instance = ((u32)st[9]) |
>     ((u32)st[10] << 8);
>     >> +
>     >> +                     // next 8 are srbm data
>     >> +                     rd->state.srbm.me <http://state.srbm.me> 
>          = ((u32)st[11]) | ((u32)st[12] << 8);
>     >> +                     rd->state.srbm.pipe     = ((u32)st[13]) |
>     ((u32)st[14] << 8);
>     >> +                     rd->state.srbm.queue    = ((u32)st[15]) |
>     ((u32)st[16] << 8);
>     >> +                     rd->state.srbm.vmid     = ((u32)st[17]) |
>     ((u32)st[18] << 8);
>     >> +                     break;
>     >> +             case AMDGPU_DEBUGFS_REGS2_IOC_READ:
>     >> +                     return amdgpu_debugfs_regs2_op(f, (char
>     __user *)data, 0);
>     >> +             case AMDGPU_DEBUGFS_REGS2_IOC_WRITE:
>     >> +                     return amdgpu_debugfs_regs2_op(f, (char
>     __user *)data, 1);
>     >> +             default:
>     >> +                     return -EINVAL;
>     >> +     }
>     >> +     return 0;
>     >> +}
>     >>
>     >>    /**
>     >>     * amdgpu_debugfs_regs_pcie_read - Read from a PCIE register
>     >> @@ -1091,6 +1258,14 @@ static ssize_t
>     amdgpu_debugfs_gfxoff_read(struct file *f, char __user *buf,
>     >>        return result;
>     >>    }
>     >>
>     >> +static const struct file_operations amdgpu_debugfs_regs2_fops = {
>     >> +     .owner = THIS_MODULE,
>     >> +     .unlocked_ioctl = amdgpu_debugfs_regs2_ioctl,
>     >> +     .open = amdgpu_debugfs_regs2_open,
>     >> +     .release = amdgpu_debugfs_regs2_release,
>     >> +     .llseek = default_llseek
>     >> +};
>     >> +
>     >>    static const struct file_operations amdgpu_debugfs_regs_fops = {
>     >>        .owner = THIS_MODULE,
>     >>        .read = amdgpu_debugfs_regs_read,
>     >> @@ -1148,6 +1323,7 @@ static const struct file_operations
>     amdgpu_debugfs_gfxoff_fops = {
>     >>
>     >>    static const struct file_operations *debugfs_regs[] = {
>     >>        &amdgpu_debugfs_regs_fops,
>     >> +     &amdgpu_debugfs_regs2_fops,
>     >>        &amdgpu_debugfs_regs_didt_fops,
>     >>        &amdgpu_debugfs_regs_pcie_fops,
>     >>        &amdgpu_debugfs_regs_smc_fops,
>     >> @@ -1160,6 +1336,7 @@ static const struct file_operations
>     *debugfs_regs[] = {
>     >>
>     >>    static const char *debugfs_regs_names[] = {
>     >>        "amdgpu_regs",
>     >> +     "amdgpu_regs2",
>     >>        "amdgpu_regs_didt",
>     >>        "amdgpu_regs_pcie",
>     >>        "amdgpu_regs_smc",
>     >> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
>     b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
>     >> index 141a8474e24f..04c81cd4bcc7 100644
>     >> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
>     >> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
>     >> @@ -22,6 +22,7 @@
>     >>     * OTHER DEALINGS IN THE SOFTWARE.
>     >>     *
>     >>     */
>     >> +#include <linux/ioctl.h>
>     >>
>     >>    /*
>     >>     * Debugfs
>     >> @@ -38,3 +39,34 @@ void amdgpu_debugfs_fence_init(struct
>     amdgpu_device *adev);
>     >>    void amdgpu_debugfs_firmware_init(struct amdgpu_device *adev);
>     >>    void amdgpu_debugfs_gem_init(struct amdgpu_device *adev);
>     >>    int amdgpu_debugfs_wait_dump(struct amdgpu_device *adev);
>     >> +
>     >> +struct amdgpu_debugfs_regs2_data {
>     >> +     struct amdgpu_device *adev;
>     >> +     struct {
>     >> +             // regs state
>     >> +             int use_srbm,
>     >> +                 use_grbm,
>     >> +                 pg_lock;
>     >> +             struct {
>     >> +                     u32 se, sh, instance;
>     >> +             } grbm;
>     >> +             struct {
>     >> +                     u32 me, pipe, queue, vmid;
>     >> +             } srbm;
>     >> +             u32 offset;
>     >> +     } state;
>     >> +};
>     > This stuff needs to be in some shared header then.
>     >
>     >> +
>     >> +enum AMDGPU_DEBUGFS_REGS2_CMDS {
>     >> +     AMDGPU_DEBUGFS_REGS2_CMD_SET_STATE=0,
>     >> +     AMDGPU_DEBUGFS_REGS2_CMD_READ,
>     >> +     AMDGPU_DEBUGFS_REGS2_CMD_WRITE,
>     > Why not just using the normal read and write functions?
>     >
>     > Christian.
>     >
>     >> +};
>     >> +
>     >> +struct amdgpu_debugfs_regs2_iocdata {
>     >> +     unsigned char t[32];
>     >> +};
>     >> +
>     >> +#define AMDGPU_DEBUGFS_REGS2_IOC_SET_STATE _IOWR(0x20,
>     AMDGPU_DEBUGFS_REGS2_CMD_SET_STATE, struct
>     amdgpu_debugfs_regs2_iocdata)
>     >> +#define AMDGPU_DEBUGFS_REGS2_IOC_READ _IOWR(0x20,
>     AMDGPU_DEBUGFS_REGS2_CMD_WRITE, struct amdgpu_debugfs_regs2_iocdata)
>     >> +#define AMDGPU_DEBUGFS_REGS2_IOC_WRITE _IOWR(0x20,
>     AMDGPU_DEBUGFS_REGS2_CMD_READ, struct amdgpu_debugfs_regs2_iocdata)
>


--------------387DDBF763F9491FC7706089
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    Am 24.08.21 um 14:42 schrieb Tom St Denis:<br>
    <blockquote type="cite"
cite="mid:CAAzXoRKWy74Wst_1br+N37dkO+5Uode4+zwQpEtM9su+JA9oLg@mail.gmail.com">
      <meta http-equiv="content-type" content="text/html; charset=UTF-8">
      <div dir="ltr">The IOCTL data is in the debugfs header as it is. 
        I could move that to the amdgpu_drm.h and include it from
        amdgpu_debugfs.h.</div>
    </blockquote>
    <br>
    Na, keep it like that and just add a comment.<br>
    <br>
    On second thought I don't want to raise any discussion on the
    mailing list if we should have a debugfs structure in the UAPI
    headers.<br>
    <br>
    Christian.<br>
    <br>
    <blockquote type="cite"
cite="mid:CAAzXoRKWy74Wst_1br+N37dkO+5Uode4+zwQpEtM9su+JA9oLg@mail.gmail.com">
      <div dir="ltr">
        <div><br>
        </div>
        <div>I'll re-write the STATE IOCTL to use a struct and then test
          against what I have in umr.</div>
        <div><br>
        </div>
        <div>Refactoring the read/write is trivial and I'll do that no
          problem (with style fixes).</div>
        <div><br>
        </div>
        <div>Cheers,</div>
        <div>Tom</div>
      </div>
      <br>
      <div class="gmail_quote">
        <div dir="ltr" class="gmail_attr">On Tue, Aug 24, 2021 at 8:34
          AM Christian König &lt;<a
            href="mailto:ckoenig.leichtzumerken@gmail.com"
            moz-do-not-send="true">ckoenig.leichtzumerken@gmail.com</a>&gt;
          wrote:<br>
        </div>
        <blockquote class="gmail_quote" style="margin:0px 0px 0px
          0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Am
          24.08.21 um 14:27 schrieb StDenis, Tom:<br>
          &gt; [AMD Official Use Only]<br>
          &gt;<br>
          &gt; What do you mean a "shared header?"  How would they be
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
          &gt; As for why not read/write.  Jus wanted to keep it
          simple.  It's not really performance bound.  umr never does
          reads/writes larger than 32-bits anyways.  It doesn't have to
          be this way though but I figured the fewer LOC the better.<br>
          <br>
          I think it would be cleaner if we would have separate
          functions for this.<br>
          <br>
          As far as I can see you also don't need the dance with the
          power <br>
          managerment etc for the IOCTL. It's just get_user() into your
          structure.<br>
          <br>
          BTW: In the kernel coding style put "switch" and "case" on the
          same <br>
          column, otherwise <a href="http://checkpatch.pl"
            rel="noreferrer" target="_blank" moz-do-not-send="true">checkpatch.pl</a>
          might complain.<br>
          <br>
          Christian.<br>
          <br>
          &gt;<br>
          &gt; Tom<br>
          &gt;<br>
          &gt; ________________________________________<br>
          &gt; From: Christian König &lt;<a
            href="mailto:ckoenig.leichtzumerken@gmail.com"
            target="_blank" moz-do-not-send="true">ckoenig.leichtzumerken@gmail.com</a>&gt;<br>
          &gt; Sent: Tuesday, August 24, 2021 08:20<br>
          &gt; To: StDenis, Tom; <a
            href="mailto:amd-gfx@lists.freedesktop.org" target="_blank"
            moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a><br>
          &gt; Subject: Re: [PATCH] drm/amd/amdgpu: New debugfs
          interface for MMIO registers<br>
          &gt;<br>
          &gt;<br>
          &gt;<br>
          &gt; Am 24.08.21 um 14:16 schrieb Tom St Denis:<br>
          &gt;&gt; This new debugfs interface uses an IOCTL interface in
          order to pass<br>
          &gt;&gt; along state information like SRBM and GRBM bank
          switching.  This<br>
          &gt;&gt; new interface also allows a full 32-bit MMIO address
          range which<br>
          &gt;&gt; the previous didn't.  With this new design we have
          room to grow<br>
          &gt;&gt; the flexibility of the file as need be.<br>
          &gt;&gt;<br>
          &gt;&gt; Signed-off-by: Tom St Denis &lt;<a
            href="mailto:tom.stdenis@amd.com" target="_blank"
            moz-do-not-send="true">tom.stdenis@amd.com</a>&gt;<br>
          &gt;&gt; ---<br>
          &gt;&gt;    drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 177
          ++++++++++++++++++++<br>
          &gt;&gt;    drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h |  32
          ++++<br>
          &gt;&gt;    2 files changed, 209 insertions(+)<br>
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
          &gt;&gt;        return amdgpu_debugfs_process_reg_op(false, f,
          (char __user *)buf, size, pos);<br>
          &gt;&gt;    }<br>
          &gt;&gt;<br>
          &gt;&gt; +static int amdgpu_debugfs_regs2_open(struct inode
          *inode, struct file *file)<br>
          &gt;&gt; +{<br>
          &gt;&gt; +     struct amdgpu_debugfs_regs2_data *rd;<br>
          &gt;&gt; +<br>
          &gt;&gt; +     rd = kzalloc(sizeof *rd, GFP_KERNEL);<br>
          &gt;&gt; +     if (!rd)<br>
          &gt;&gt; +             return -ENOMEM;<br>
          &gt;&gt; +     rd-&gt;adev = file_inode(file)-&gt;i_private;<br>
          &gt;&gt; +     file-&gt;private_data = rd;<br>
          &gt;&gt; +<br>
          &gt;&gt; +     return 0;<br>
          &gt;&gt; +}<br>
          &gt;&gt; +<br>
          &gt;&gt; +static int amdgpu_debugfs_regs2_release(struct inode
          *inode, struct file *file)<br>
          &gt;&gt; +{<br>
          &gt;&gt; +     kfree(file-&gt;private_data);<br>
          &gt;&gt; +     return 0;<br>
          &gt;&gt; +}<br>
          &gt;&gt; +<br>
          &gt;&gt; +static int amdgpu_debugfs_regs2_op(struct file *f,
          char __user *buf, int write_en)<br>
          &gt;&gt; +{<br>
          &gt;&gt; +     struct amdgpu_debugfs_regs2_data *rd =
          f-&gt;private_data;<br>
          &gt;&gt; +     struct amdgpu_device *adev = rd-&gt;adev;<br>
          &gt;&gt; +     int result = 0, r;<br>
          &gt;&gt; +     uint32_t value;<br>
          &gt;&gt; +<br>
          &gt;&gt; +     if (rd-&gt;state.offset &amp; 0x3)<br>
          &gt;&gt; +             return -EINVAL;<br>
          &gt;&gt; +<br>
          &gt;&gt; +     if (rd-&gt;state.use_grbm) {<br>
          &gt;&gt; +             if (rd-&gt;<a
            href="http://state.grbm.se" rel="noreferrer" target="_blank"
            moz-do-not-send="true">state.grbm.se</a> == 0x3FF)<br>
          &gt;&gt; +                     rd-&gt;<a
            href="http://state.grbm.se" rel="noreferrer" target="_blank"
            moz-do-not-send="true">state.grbm.se</a> = 0xFFFFFFFF;<br>
          &gt;&gt; +             if (rd-&gt;<a
            href="http://state.grbm.sh" rel="noreferrer" target="_blank"
            moz-do-not-send="true">state.grbm.sh</a> == 0x3FF)<br>
          &gt;&gt; +                     rd-&gt;<a
            href="http://state.grbm.sh" rel="noreferrer" target="_blank"
            moz-do-not-send="true">state.grbm.sh</a> = 0xFFFFFFFF;<br>
          &gt;&gt; +             if (rd-&gt;state.grbm.instance ==
          0x3FF)<br>
          &gt;&gt; +                     rd-&gt;state.grbm.instance =
          0xFFFFFFFF;<br>
          &gt;&gt; +     }<br>
          &gt;&gt; +<br>
          &gt;&gt; +     r =
          pm_runtime_get_sync(adev_to_drm(adev)-&gt;dev);<br>
          &gt;&gt; +     if (r &lt; 0) {<br>
          &gt;&gt; +           
           pm_runtime_put_autosuspend(adev_to_drm(adev)-&gt;dev);<br>
          &gt;&gt; +             return r;<br>
          &gt;&gt; +     }<br>
          &gt;&gt; +<br>
          &gt;&gt; +     r = amdgpu_virt_enable_access_debugfs(adev);<br>
          &gt;&gt; +     if (r &lt; 0) {<br>
          &gt;&gt; +           
           pm_runtime_put_autosuspend(adev_to_drm(adev)-&gt;dev);<br>
          &gt;&gt; +             return r;<br>
          &gt;&gt; +     }<br>
          &gt;&gt; +<br>
          &gt;&gt; +     if (rd-&gt;state.use_grbm) {<br>
          &gt;&gt; +             if ((rd-&gt;<a
            href="http://state.grbm.sh" rel="noreferrer" target="_blank"
            moz-do-not-send="true">state.grbm.sh</a> != 0xFFFFFFFF
          &amp;&amp; rd-&gt;<a href="http://state.grbm.sh"
            rel="noreferrer" target="_blank" moz-do-not-send="true">state.grbm.sh</a>
          &gt;= adev-&gt;gfx.config.max_sh_per_se) ||<br>
          &gt;&gt; +                 (rd-&gt;<a
            href="http://state.grbm.se" rel="noreferrer" target="_blank"
            moz-do-not-send="true">state.grbm.se</a> != 0xFFFFFFFF
          &amp;&amp; rd-&gt;<a href="http://state.grbm.se"
            rel="noreferrer" target="_blank" moz-do-not-send="true">state.grbm.se</a>
          &gt;= adev-&gt;gfx.config.max_shader_engines)) {<br>
          &gt;&gt; +                   
           pm_runtime_mark_last_busy(adev_to_drm(adev)-&gt;dev);<br>
          &gt;&gt; +                   
           pm_runtime_put_autosuspend(adev_to_drm(adev)-&gt;dev);<br>
          &gt;&gt; +                   
           amdgpu_virt_disable_access_debugfs(adev);<br>
          &gt;&gt; +                     return -EINVAL;<br>
          &gt;&gt; +             }<br>
          &gt;&gt; +           
           mutex_lock(&amp;adev-&gt;grbm_idx_mutex);<br>
          &gt;&gt; +             amdgpu_gfx_select_se_sh(adev, rd-&gt;<a
            href="http://state.grbm.se" rel="noreferrer" target="_blank"
            moz-do-not-send="true">state.grbm.se</a>,<br>
          &gt;&gt; +                                                   
                   rd-&gt;<a href="http://state.grbm.sh"
            rel="noreferrer" target="_blank" moz-do-not-send="true">state.grbm.sh</a>,<br>
          &gt;&gt; +                                                   
                   rd-&gt;state.grbm.instance);<br>
          &gt;&gt; +     } else if (rd-&gt;state.use_grbm) {<br>
          &gt;&gt; +             mutex_lock(&amp;adev-&gt;srbm_mutex);<br>
          &gt;&gt; +             amdgpu_gfx_select_me_pipe_q(adev,
          rd-&gt;<a href="http://state.srbm.me" rel="noreferrer"
            target="_blank" moz-do-not-send="true">state.srbm.me</a>,
          rd-&gt;state.srbm.pipe,<br>
          &gt;&gt; +                                                   
                           rd-&gt;state.srbm.queue,
          rd-&gt;state.srbm.vmid);<br>
          &gt;&gt; +     }<br>
          &gt;&gt; +<br>
          &gt;&gt; +     if (rd-&gt;state.pg_lock)<br>
          &gt;&gt; +             mutex_lock(&amp;adev-&gt;pm.mutex);<br>
          &gt;&gt; +<br>
          &gt;&gt; +     if (!write_en) {<br>
          &gt;&gt; +             value = RREG32(rd-&gt;state.offset
          &gt;&gt; 2);<br>
          &gt;&gt; +             r = put_user(value, (uint32_t *)buf);<br>
          &gt;&gt; +     } else {<br>
          &gt;&gt; +             r = get_user(value, (uint32_t *)buf);<br>
          &gt;&gt; +             if (!r)<br>
          &gt;&gt; +                     amdgpu_mm_wreg_mmio_rlc(adev,
          rd-&gt;state.offset &gt;&gt; 2, value);<br>
          &gt;&gt; +     }<br>
          &gt;&gt; +     if (r) {<br>
          &gt;&gt; +             result = r;<br>
          &gt;&gt; +             goto end;<br>
          &gt;&gt; +     }<br>
          &gt;&gt; +     result = 0;<br>
          &gt;&gt; +end:<br>
          &gt;&gt; +     if (rd-&gt;state.use_grbm) {<br>
          &gt;&gt; +             amdgpu_gfx_select_se_sh(adev,
          0xffffffff, 0xffffffff, 0xffffffff);<br>
          &gt;&gt; +           
           mutex_unlock(&amp;adev-&gt;grbm_idx_mutex);<br>
          &gt;&gt; +     } else if (rd-&gt;state.use_srbm) {<br>
          &gt;&gt; +             amdgpu_gfx_select_me_pipe_q(adev, 0, 0,
          0, 0);<br>
          &gt;&gt; +             mutex_unlock(&amp;adev-&gt;srbm_mutex);<br>
          &gt;&gt; +     }<br>
          &gt;&gt; +<br>
          &gt;&gt; +     if (rd-&gt;state.pg_lock)<br>
          &gt;&gt; +             mutex_unlock(&amp;adev-&gt;pm.mutex);<br>
          &gt;&gt; +<br>
          &gt;&gt; +     // in umr (the likely user of this) flags are
          set per file operation<br>
          &gt;&gt; +     // which means they're never "unset"
          explicitly.  To avoid breaking<br>
          &gt;&gt; +     // this convention we unset the flags after
          each operation<br>
          &gt;&gt; +     // flags are for a single call (need to be set
          for every read/write)<br>
          &gt;&gt; +     rd-&gt;state.use_grbm = 0;<br>
          &gt;&gt; +     rd-&gt;state.use_srbm = 0;<br>
          &gt;&gt; +     rd-&gt;state.pg_lock  = 0;<br>
          &gt;&gt; +<br>
          &gt;&gt; +   
           pm_runtime_mark_last_busy(adev_to_drm(adev)-&gt;dev);<br>
          &gt;&gt; +   
           pm_runtime_put_autosuspend(adev_to_drm(adev)-&gt;dev);<br>
          &gt;&gt; +<br>
          &gt;&gt; +     amdgpu_virt_disable_access_debugfs(adev);<br>
          &gt;&gt; +     return result;<br>
          &gt;&gt; +}<br>
          &gt;&gt; +<br>
          &gt;&gt; +static long amdgpu_debugfs_regs2_ioctl(struct file
          *f, unsigned int cmd, unsigned long data)<br>
          &gt;&gt; +{<br>
          &gt;&gt; +     struct amdgpu_debugfs_regs2_data *rd =
          f-&gt;private_data;<br>
          &gt;&gt; +     unsigned char st[32], v;<br>
          &gt;&gt; +     int r, x;<br>
          &gt;&gt; +<br>
          &gt;&gt; +     // always read first 4 bytes of data<br>
          &gt;&gt; +     for (x = 0; x &lt; 4; x++) {<br>
          &gt;&gt; +             if ((r = get_user(v, (unsigned char
          *)data))) {<br>
          &gt;&gt; +                     return r;<br>
          &gt;&gt; +             }<br>
          &gt;&gt; +             ++data;<br>
          &gt;&gt; +             st[x] = v;<br>
          &gt;&gt; +     }<br>
          &gt;&gt; +<br>
          &gt;&gt; +     // first 4 bytes are offset<br>
          &gt;&gt; +     rd-&gt;state.offset = ((u32)st[0]) |
          ((u32)st[1] &lt;&lt; 8) |<br>
          &gt;&gt; +                                        ((u32)st[2]
          &lt;&lt; 16) | ((u32)st[3] &lt;&lt; 24);<br>
          &gt;&gt; +<br>
          &gt;&gt; +     switch (cmd) {<br>
          &gt;&gt; +             case
          AMDGPU_DEBUGFS_REGS2_IOC_SET_STATE:<br>
          &gt;&gt; +                     for (x = 4; x &lt; 32; x++) {<br>
          &gt;&gt; +                             if ((r = get_user(v,
          (unsigned char *)data))) {<br>
          &gt;&gt; +                                     return r;<br>
          &gt;&gt; +                             }<br>
          &gt;&gt; +                             ++data;<br>
          &gt;&gt; +                             st[x] = v;<br>
          &gt;&gt; +                     }<br>
          &gt;&gt; +<br>
          &gt;&gt; +                     // next byte contains the flag<br>
          &gt;&gt; +                     // we only consume the
          remainder of the state if bit 1 is set<br>
          &gt;&gt; +                     // this allows the subsequent
          read/write<br>
          &gt;&gt; +                     rd-&gt;state.use_grbm = (st[4]
          &amp; 1) ? 1 : 0;<br>
          &gt;&gt; +                     rd-&gt;state.use_srbm = (st[4]
          &amp; 2) ? 1 : 0;<br>
          &gt;&gt; +                     rd-&gt;state.pg_lock  = (st[4]
          &amp; 4) ? 1 : 0;<br>
          &gt;&gt; +<br>
          &gt;&gt; +                     // next 6 bytes are grbm data<br>
          &gt;&gt; +                     rd-&gt;<a
            href="http://state.grbm.se" rel="noreferrer" target="_blank"
            moz-do-not-send="true">state.grbm.se</a>       = 
          ((u32)st[5]) | ((u32)st[6] &lt;&lt; 8);<br>
          &gt;&gt; +                     rd-&gt;<a
            href="http://state.grbm.sh" rel="noreferrer" target="_blank"
            moz-do-not-send="true">state.grbm.sh</a>       = 
          ((u32)st[7]) | ((u32)st[8] &lt;&lt; 8);<br>
          &gt;&gt; +                     rd-&gt;state.grbm.instance = 
          ((u32)st[9]) | ((u32)st[10] &lt;&lt; 8);<br>
          &gt;&gt; +<br>
          &gt;&gt; +                     // next 8 are srbm data<br>
          &gt;&gt; +                     rd-&gt;<a
            href="http://state.srbm.me" rel="noreferrer" target="_blank"
            moz-do-not-send="true">state.srbm.me</a>       = 
          ((u32)st[11]) | ((u32)st[12] &lt;&lt; 8);<br>
          &gt;&gt; +                     rd-&gt;state.srbm.pipe     = 
          ((u32)st[13]) | ((u32)st[14] &lt;&lt; 8);<br>
          &gt;&gt; +                     rd-&gt;state.srbm.queue    = 
          ((u32)st[15]) | ((u32)st[16] &lt;&lt; 8);<br>
          &gt;&gt; +                     rd-&gt;state.srbm.vmid     = 
          ((u32)st[17]) | ((u32)st[18] &lt;&lt; 8);<br>
          &gt;&gt; +                     break;<br>
          &gt;&gt; +             case AMDGPU_DEBUGFS_REGS2_IOC_READ:<br>
          &gt;&gt; +                     return
          amdgpu_debugfs_regs2_op(f, (char __user *)data, 0);<br>
          &gt;&gt; +             case AMDGPU_DEBUGFS_REGS2_IOC_WRITE:<br>
          &gt;&gt; +                     return
          amdgpu_debugfs_regs2_op(f, (char __user *)data, 1);<br>
          &gt;&gt; +             default:<br>
          &gt;&gt; +                     return -EINVAL;<br>
          &gt;&gt; +     }<br>
          &gt;&gt; +     return 0;<br>
          &gt;&gt; +}<br>
          &gt;&gt;<br>
          &gt;&gt;    /**<br>
          &gt;&gt;     * amdgpu_debugfs_regs_pcie_read - Read from a
          PCIE register<br>
          &gt;&gt; @@ -1091,6 +1258,14 @@ static ssize_t
          amdgpu_debugfs_gfxoff_read(struct file *f, char __user *buf,<br>
          &gt;&gt;        return result;<br>
          &gt;&gt;    }<br>
          &gt;&gt;<br>
          &gt;&gt; +static const struct file_operations
          amdgpu_debugfs_regs2_fops = {<br>
          &gt;&gt; +     .owner = THIS_MODULE,<br>
          &gt;&gt; +     .unlocked_ioctl = amdgpu_debugfs_regs2_ioctl,<br>
          &gt;&gt; +     .open = amdgpu_debugfs_regs2_open,<br>
          &gt;&gt; +     .release = amdgpu_debugfs_regs2_release,<br>
          &gt;&gt; +     .llseek = default_llseek<br>
          &gt;&gt; +};<br>
          &gt;&gt; +<br>
          &gt;&gt;    static const struct file_operations
          amdgpu_debugfs_regs_fops = {<br>
          &gt;&gt;        .owner = THIS_MODULE,<br>
          &gt;&gt;        .read = amdgpu_debugfs_regs_read,<br>
          &gt;&gt; @@ -1148,6 +1323,7 @@ static const struct
          file_operations amdgpu_debugfs_gfxoff_fops = {<br>
          &gt;&gt;<br>
          &gt;&gt;    static const struct file_operations
          *debugfs_regs[] = {<br>
          &gt;&gt;        &amp;amdgpu_debugfs_regs_fops,<br>
          &gt;&gt; +     &amp;amdgpu_debugfs_regs2_fops,<br>
          &gt;&gt;        &amp;amdgpu_debugfs_regs_didt_fops,<br>
          &gt;&gt;        &amp;amdgpu_debugfs_regs_pcie_fops,<br>
          &gt;&gt;        &amp;amdgpu_debugfs_regs_smc_fops,<br>
          &gt;&gt; @@ -1160,6 +1336,7 @@ static const struct
          file_operations *debugfs_regs[] = {<br>
          &gt;&gt;<br>
          &gt;&gt;    static const char *debugfs_regs_names[] = {<br>
          &gt;&gt;        "amdgpu_regs",<br>
          &gt;&gt; +     "amdgpu_regs2",<br>
          &gt;&gt;        "amdgpu_regs_didt",<br>
          &gt;&gt;        "amdgpu_regs_pcie",<br>
          &gt;&gt;        "amdgpu_regs_smc",<br>
          &gt;&gt; diff --git
          a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
          b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h<br>
          &gt;&gt; index 141a8474e24f..04c81cd4bcc7 100644<br>
          &gt;&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h<br>
          &gt;&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h<br>
          &gt;&gt; @@ -22,6 +22,7 @@<br>
          &gt;&gt;     * OTHER DEALINGS IN THE SOFTWARE.<br>
          &gt;&gt;     *<br>
          &gt;&gt;     */<br>
          &gt;&gt; +#include &lt;linux/ioctl.h&gt;<br>
          &gt;&gt;<br>
          &gt;&gt;    /*<br>
          &gt;&gt;     * Debugfs<br>
          &gt;&gt; @@ -38,3 +39,34 @@ void
          amdgpu_debugfs_fence_init(struct amdgpu_device *adev);<br>
          &gt;&gt;    void amdgpu_debugfs_firmware_init(struct
          amdgpu_device *adev);<br>
          &gt;&gt;    void amdgpu_debugfs_gem_init(struct amdgpu_device
          *adev);<br>
          &gt;&gt;    int amdgpu_debugfs_wait_dump(struct amdgpu_device
          *adev);<br>
          &gt;&gt; +<br>
          &gt;&gt; +struct amdgpu_debugfs_regs2_data {<br>
          &gt;&gt; +     struct amdgpu_device *adev;<br>
          &gt;&gt; +     struct {<br>
          &gt;&gt; +             // regs state<br>
          &gt;&gt; +             int use_srbm,<br>
          &gt;&gt; +                 use_grbm,<br>
          &gt;&gt; +                 pg_lock;<br>
          &gt;&gt; +             struct {<br>
          &gt;&gt; +                     u32 se, sh, instance;<br>
          &gt;&gt; +             } grbm;<br>
          &gt;&gt; +             struct {<br>
          &gt;&gt; +                     u32 me, pipe, queue, vmid;<br>
          &gt;&gt; +             } srbm;<br>
          &gt;&gt; +             u32 offset;<br>
          &gt;&gt; +     } state;<br>
          &gt;&gt; +};<br>
          &gt; This stuff needs to be in some shared header then.<br>
          &gt;<br>
          &gt;&gt; +<br>
          &gt;&gt; +enum AMDGPU_DEBUGFS_REGS2_CMDS {<br>
          &gt;&gt; +     AMDGPU_DEBUGFS_REGS2_CMD_SET_STATE=0,<br>
          &gt;&gt; +     AMDGPU_DEBUGFS_REGS2_CMD_READ,<br>
          &gt;&gt; +     AMDGPU_DEBUGFS_REGS2_CMD_WRITE,<br>
          &gt; Why not just using the normal read and write functions?<br>
          &gt;<br>
          &gt; Christian.<br>
          &gt;<br>
          &gt;&gt; +};<br>
          &gt;&gt; +<br>
          &gt;&gt; +struct amdgpu_debugfs_regs2_iocdata {<br>
          &gt;&gt; +     unsigned char t[32];<br>
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
  </body>
</html>

--------------387DDBF763F9491FC7706089--
