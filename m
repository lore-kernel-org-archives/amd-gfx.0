Return-Path: <SRS0=FOdb=NQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 900A0C4338F
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Aug 2021 11:09:06 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5422D610E5
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Aug 2021 11:09:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5422D610E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E2BD16E1CD;
	Wed, 25 Aug 2021 11:09:05 +0000 (UTC)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C59A6E1CD
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Aug 2021 11:09:04 +0000 (UTC)
Received: by mail-wm1-x32a.google.com with SMTP id g138so14715297wmg.4
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Aug 2021 04:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language;
 bh=n98eymh7n/f8Qye7iorqS+sOCkcj/wBMg9igSpLu1lE=;
 b=loMhu0gImOBstY2LHepe5VuPCfDbmfUC/G1ABx+ZiqVLbzHHQIl1qZNJIouUrqvO6V
 qXmXEfhs8+T5bW/dmoc6e7hgz8wYn2/YUdaN/wU31dh7POn9pi4waZB3H7BGdFY0qtSf
 eZTBY17tgKCf8lJM83Q3np3BMAgQGTocMw/TZfovHzi8ys+zb1FVKXTqxIHZkZdZTrbD
 8PJRMPrU7uejNwDJCXDGzTCVOA68Cu7qaNigaYlJehyZAlL+uz/GDXMyfYtfvfGPc9KK
 SqIG8DrAKCA38iYsOiUsAXE+ZqBxViOtnmUP58hrWFDPP9T1lo/+Vvl5UXe75Z3G2UZi
 S1og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language;
 bh=n98eymh7n/f8Qye7iorqS+sOCkcj/wBMg9igSpLu1lE=;
 b=qwsl711lUJppjg4XIEdGTtcnXwtbnIavbzFPD/LFhlPUf3L14h2DLMSyBJDCIOz+Fx
 XWVBXBmiPs6ZOsnItK51Oru4BZIXJrrhnP1ppPtZp9LRo14svu6TftSC3pBbXuqc5ba4
 80he8rz47k7GwX1qtvxbukscKy/O7n+MDXliQ54MKF8QudXsBdXaIOSr67/el2Vmbezd
 OPLaOO+PDbcv227Zrkxn/LOcZm7h37ahx2ncierFJlc8KnYmYGtAFoahEMbDKNe/GcIr
 kwDSmHL3hmGlitySxbSThCDpH8VWQYING+8hUe4fupXmm4qV4570XsA7KlAslqN4sEIu
 AAFQ==
X-Gm-Message-State: AOAM530WC7tPvqWMi/LB9kl5kZbtpRzAzSDf9hBdmd6hBFHZ0XeTwL9s
 eTWpwLMUngGB2nIfvWtHwK3iirH7i7VePNlU
X-Google-Smtp-Source: ABdhPJylueKIdKYrJzeQjp/CW00DMAOvZcU0DOynzmnN5B2RDauD0XwW4SxjCSuTOmiuXltDCjrjbg==
X-Received: by 2002:a1c:1d84:: with SMTP id d126mr8694912wmd.160.1629889742650; 
 Wed, 25 Aug 2021 04:09:02 -0700 (PDT)
Received: from [192.168.178.21] (p5b0ea1b5.dip0.t-ipconnect.de.
 [91.14.161.181])
 by smtp.gmail.com with ESMTPSA id o7sm4869125wmc.46.2021.08.25.04.09.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Aug 2021 04:09:02 -0700 (PDT)
Subject: Re: [PATCH] drm/amd/amdgpu: New debugfs interface for MMIO registers
 (v2)
To: Tom St Denis <tstdenis82@gmail.com>
Cc: Nirmoy Das <nirmoy.das@amd.com>, Tom St Denis <tom.stdenis@amd.com>,
 amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
References: <20210824133642.109072-1-tom.stdenis@amd.com>
 <de13fb00-3ce7-5f6c-8f22-e07e697de643@gmail.com>
 <CAAzXoRLzLjZm0AW1w=oEKMsRrVzwPDawbdimBiaKV86A7QF8nQ@mail.gmail.com>
 <84ddce49-012b-2fae-d14d-eeebf7e6c09a@gmail.com>
 <CAAzXoRJsSxm7UOt++H9Ko8pnnNdO0Zp=+hPgCh8TwUaQhv-e_w@mail.gmail.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <acad0e11-842f-52ff-c31a-eebf4777f746@gmail.com>
Date: Wed, 25 Aug 2021 13:09:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAAzXoRJsSxm7UOt++H9Ko8pnnNdO0Zp=+hPgCh8TwUaQhv-e_w@mail.gmail.com>
Content-Type: multipart/alternative;
 boundary="------------2A13EE35E58893FC2DB905B5"
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
--------------2A13EE35E58893FC2DB905B5
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

I suggest to give this command here at least a try (remembered the name 
after a moment):

pahole drivers/gpu/drm/amd/amdgpu/amdgpu.o -C amdgpu_debugfs_regs2_iocdata

It has a rather nifty output with padding holes, byte addresses, cache 
lines etc for your structure.

Christian.

Am 25.08.21 um 13:04 schrieb Tom St Denis:
> I tested it by forcing bit patterns into the ioctl data and printing 
> it out in the kernel log.  I'm not siloed into it one way or the 
> other.  I'll just change it to u32.
>
> On Wed, Aug 25, 2021 at 7:03 AM Christian König 
> <ckoenig.leichtzumerken@gmail.com 
> <mailto:ckoenig.leichtzumerken@gmail.com>> wrote:
>
>     Using u8 is ok as well, just make sure that you don't have any
>     hidden padding.
>
>     Nirmoy had a tool to double check for paddings which I once more
>     forgot the name of.
>
>     Christian.
>
>     Am 25.08.21 um 12:40 schrieb Tom St Denis:
>>     The struct works as is but I'll change them to u32.  The offset
>>     is an artefact of the fact this was an IOCTL originally.  I'm
>>     working both ends in parallel trying to make the changes at the
>>     same time because I'm only submitting the kernel patch if I've
>>     tested it in userspace.
>>
>>     I'll send a v4 in a bit this morning....
>>
>>     Tom
>>
>>     On Wed, Aug 25, 2021 at 2:35 AM Christian König
>>     <ckoenig.leichtzumerken@gmail.com
>>     <mailto:ckoenig.leichtzumerken@gmail.com>> wrote:
>>
>>
>>
>>         Am 24.08.21 um 15:36 schrieb Tom St Denis:
>>         > This new debugfs interface uses an IOCTL interface in order
>>         to pass
>>         > along state information like SRBM and GRBM bank switching. 
>>         This
>>         > new interface also allows a full 32-bit MMIO address range
>>         which
>>         > the previous didn't.  With this new design we have room to grow
>>         > the flexibility of the file as need be.
>>         >
>>         > (v2): Move read/write to .read/.write, fix style, add comment
>>         >        for IOCTL data structure
>>         >
>>         > Signed-off-by: Tom St Denis <tom.stdenis@amd.com
>>         <mailto:tom.stdenis@amd.com>>
>>         > ---
>>         >   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 162
>>         ++++++++++++++++++++
>>         >   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h | 32 ++++
>>         >   2 files changed, 194 insertions(+)
>>         >
>>         > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>         b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>         > index 277128846dd1..8e8f5743c8f5 100644
>>         > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>         > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
>>         > @@ -279,6 +279,156 @@ static ssize_t
>>         amdgpu_debugfs_regs_write(struct file *f, const char __user *buf,
>>         >       return amdgpu_debugfs_process_reg_op(false, f, (char
>>         __user *)buf, size, pos);
>>         >   }
>>         >
>>         > +static int amdgpu_debugfs_regs2_open(struct inode *inode,
>>         struct file *file)
>>         > +{
>>         > +     struct amdgpu_debugfs_regs2_data *rd;
>>         > +
>>         > +     rd = kzalloc(sizeof *rd, GFP_KERNEL);
>>         > +     if (!rd)
>>         > +             return -ENOMEM;
>>         > +     rd->adev = file_inode(file)->i_private;
>>         > +     file->private_data = rd;
>>         > +
>>         > +     return 0;
>>         > +}
>>         > +
>>         > +static int amdgpu_debugfs_regs2_release(struct inode
>>         *inode, struct file *file)
>>         > +{
>>         > +     kfree(file->private_data);
>>         > +     return 0;
>>         > +}
>>         > +
>>         > +static ssize_t amdgpu_debugfs_regs2_op(struct file *f,
>>         char __user *buf, size_t size, int write_en)
>>         > +{
>>         > +     struct amdgpu_debugfs_regs2_data *rd = f->private_data;
>>         > +     struct amdgpu_device *adev = rd->adev;
>>         > +     ssize_t result = 0;
>>         > +     int r;
>>         > +     uint32_t value;
>>         > +
>>         > +     if (size & 0x3 || rd->state.offset & 0x3)
>>         > +             return -EINVAL;
>>         > +
>>         > +     if (rd->state.id.use_grbm) {
>>         > +             if (rd->state.id.grbm.se
>>         <http://state.id.grbm.se> == 0x3FF)
>>         > +                     rd->state.id.grbm.se
>>         <http://state.id.grbm.se> = 0xFFFFFFFF;
>>         > +             if (rd->state.id.grbm.sh
>>         <http://state.id.grbm.sh> == 0x3FF)
>>         > +                     rd->state.id.grbm.sh
>>         <http://state.id.grbm.sh> = 0xFFFFFFFF;
>>         > +             if (rd->state.id.grbm.instance == 0x3FF)
>>         > +  rd->state.id.grbm.instance = 0xFFFFFFFF;
>>         > +     }
>>         > +
>>         > +     r = pm_runtime_get_sync(adev_to_drm(adev)->dev);
>>         > +     if (r < 0) {
>>         > +  pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>>         > +             return r;
>>         > +     }
>>         > +
>>         > +     r = amdgpu_virt_enable_access_debugfs(adev);
>>         > +     if (r < 0) {
>>         > +  pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>>         > +             return r;
>>         > +     }
>>         > +
>>         > +     if (rd->state.id.use_grbm) {
>>         > +             if ((rd->state.id.grbm.sh
>>         <http://state.id.grbm.sh> != 0xFFFFFFFF &&
>>         rd->state.id.grbm.sh <http://state.id.grbm.sh> >=
>>         adev->gfx.config.max_sh_per_se) ||
>>         > +                 (rd->state.id.grbm.se
>>         <http://state.id.grbm.se> != 0xFFFFFFFF &&
>>         rd->state.id.grbm.se <http://state.id.grbm.se> >=
>>         adev->gfx.config.max_shader_engines)) {
>>         > +  pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
>>         > +  pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>>         > +  amdgpu_virt_disable_access_debugfs(adev);
>>         > +                     return -EINVAL;
>>         > +             }
>>         > +  mutex_lock(&adev->grbm_idx_mutex);
>>         > +             amdgpu_gfx_select_se_sh(adev,
>>         rd->state.id.grbm.se <http://state.id.grbm.se>,
>>         > +              rd->state.id.grbm.sh <http://state.id.grbm.sh>,
>>         > +              rd->state.id.grbm.instance);
>>         > +     }
>>         > +
>>         > +     if (rd->state.id.use_srbm) {
>>         > +  mutex_lock(&adev->srbm_mutex);
>>         > +             amdgpu_gfx_select_me_pipe_q(adev,
>>         rd->state.id.srbm.me <http://state.id.srbm.me>,
>>         rd->state.id.srbm.pipe,
>>         > +                      rd->state.id.srbm.queue,
>>         rd->state.id.srbm.vmid);
>>         > +     }
>>         > +
>>         > +     if (rd->state.id.pg_lock)
>>         > +             mutex_lock(&adev->pm.mutex);
>>         > +
>>         > +     while (size) {
>>         > +             if (!write_en) {
>>         > +                     value = RREG32(rd->state.offset >> 2);
>>         > +                     r = put_user(value, (uint32_t *)buf);
>>         > +             } else {
>>         > +                     r = get_user(value, (uint32_t *)buf);
>>         > +                     if (!r)
>>         > +  amdgpu_mm_wreg_mmio_rlc(adev, rd->state.offset >> 2, value);
>>         > +             }
>>         > +             if (r) {
>>         > +                     result = r;
>>         > +                     goto end;
>>         > +             }
>>         > +             rd->state.offset += 4;
>>         > +             size -= 4;
>>         > +             result += 4;
>>         > +             buf += 4;
>>         > +     }
>>         > +end:
>>         > +     if (rd->state.id.use_grbm) {
>>         > +             amdgpu_gfx_select_se_sh(adev, 0xffffffff,
>>         0xffffffff, 0xffffffff);
>>         > +  mutex_unlock(&adev->grbm_idx_mutex);
>>         > +     }
>>         > +
>>         > +     if (rd->state.id.use_srbm) {
>>         > +             amdgpu_gfx_select_me_pipe_q(adev, 0, 0, 0, 0);
>>         > +  mutex_unlock(&adev->srbm_mutex);
>>         > +     }
>>         > +
>>         > +     if (rd->state.id.pg_lock)
>>         > +  mutex_unlock(&adev->pm.mutex);
>>         > +
>>         > +     // in umr (the likely user of this) flags are set per
>>         file operation
>>         > +     // which means they're never "unset" explicitly.  To
>>         avoid breaking
>>         > +     // this convention we unset the flags after each
>>         operation
>>         > +     // flags are for a single call (need to be set for
>>         every read/write)
>>         > +     rd->state.id.use_grbm = 0;
>>         > +     rd->state.id.use_srbm = 0;
>>         > +     rd->state.id.pg_lock  = 0;
>>         > +
>>         > +  pm_runtime_mark_last_busy(adev_to_drm(adev)->dev);
>>         > +  pm_runtime_put_autosuspend(adev_to_drm(adev)->dev);
>>         > +
>>         > +     amdgpu_virt_disable_access_debugfs(adev);
>>         > +     return result;
>>         > +}
>>         > +
>>         > +static long amdgpu_debugfs_regs2_ioctl(struct file *f,
>>         unsigned int cmd, unsigned long data)
>>         > +{
>>         > +     struct amdgpu_debugfs_regs2_data *rd = f->private_data;
>>         > +
>>         > +     switch (cmd) {
>>         > +     case AMDGPU_DEBUGFS_REGS2_IOC_SET_STATE:
>>         > +             if (copy_from_user(&rd->state.id
>>         <http://state.id>, (struct amdgpu_debugfs_regs2_iocdata
>>         *)data, sizeof rd->state.id <http://state.id>))
>>         > +                     return -EINVAL;
>>         > +             break;
>>         > +     default:
>>         > +             return -EINVAL;
>>         > +     }
>>         > +     return 0;
>>         > +}
>>         > +
>>         > +static ssize_t amdgpu_debugfs_regs2_read(struct file *f,
>>         char __user *buf, size_t size, loff_t *pos)
>>         > +{
>>         > +     struct amdgpu_debugfs_regs2_data *rd = f->private_data;
>>         > +     rd->state.offset = *pos;
>>         > +     return amdgpu_debugfs_regs2_op(f, buf, size, 0);
>>         > +}
>>         > +
>>         > +static ssize_t amdgpu_debugfs_regs2_write(struct file *f,
>>         const char __user *buf, size_t size, loff_t *pos)
>>         > +{
>>         > +     struct amdgpu_debugfs_regs2_data *rd = f->private_data;
>>         > +     rd->state.offset = *pos;
>>         > +     return amdgpu_debugfs_regs2_op(f, (char __user *)buf,
>>         size, 1);
>>         > +}
>>         > +
>>         >
>>         >   /**
>>         >    * amdgpu_debugfs_regs_pcie_read - Read from a PCIE register
>>         > @@ -1091,6 +1241,16 @@ static ssize_t
>>         amdgpu_debugfs_gfxoff_read(struct file *f, char __user *buf,
>>         >       return result;
>>         >   }
>>         >
>>         > +static const struct file_operations
>>         amdgpu_debugfs_regs2_fops = {
>>         > +     .owner = THIS_MODULE,
>>         > +     .unlocked_ioctl = amdgpu_debugfs_regs2_ioctl,
>>         > +     .read = amdgpu_debugfs_regs2_read,
>>         > +     .write = amdgpu_debugfs_regs2_write,
>>         > +     .open = amdgpu_debugfs_regs2_open,
>>         > +     .release = amdgpu_debugfs_regs2_release,
>>         > +     .llseek = default_llseek
>>         > +};
>>         > +
>>         >   static const struct file_operations
>>         amdgpu_debugfs_regs_fops = {
>>         >       .owner = THIS_MODULE,
>>         >       .read = amdgpu_debugfs_regs_read,
>>         > @@ -1148,6 +1308,7 @@ static const struct file_operations
>>         amdgpu_debugfs_gfxoff_fops = {
>>         >
>>         >   static const struct file_operations *debugfs_regs[] = {
>>         >       &amdgpu_debugfs_regs_fops,
>>         > +     &amdgpu_debugfs_regs2_fops,
>>         >       &amdgpu_debugfs_regs_didt_fops,
>>         >       &amdgpu_debugfs_regs_pcie_fops,
>>         >       &amdgpu_debugfs_regs_smc_fops,
>>         > @@ -1160,6 +1321,7 @@ static const struct file_operations
>>         *debugfs_regs[] = {
>>         >
>>         >   static const char *debugfs_regs_names[] = {
>>         >       "amdgpu_regs",
>>         > +     "amdgpu_regs2",
>>         >       "amdgpu_regs_didt",
>>         >       "amdgpu_regs_pcie",
>>         >       "amdgpu_regs_smc",
>>         > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
>>         b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
>>         > index 141a8474e24f..ec044df5d428 100644
>>         > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
>>         > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
>>         > @@ -22,6 +22,8 @@
>>         >    * OTHER DEALINGS IN THE SOFTWARE.
>>         >    *
>>         >    */
>>         > +#include <linux/ioctl.h>
>>         > +#include <uapi/drm/amdgpu_drm.h>
>>         >
>>         >   /*
>>         >    * Debugfs
>>         > @@ -38,3 +40,33 @@ void amdgpu_debugfs_fence_init(struct
>>         amdgpu_device *adev);
>>         >   void amdgpu_debugfs_firmware_init(struct amdgpu_device
>>         *adev);
>>         >   void amdgpu_debugfs_gem_init(struct amdgpu_device *adev);
>>         >   int amdgpu_debugfs_wait_dump(struct amdgpu_device *adev);
>>         > +
>>         > +/*
>>         > + * MMIO debugfs IOCTL structure
>>         > + */
>>         > +struct amdgpu_debugfs_regs2_iocdata {
>>         > +     __u8 use_srbm, use_grbm, pg_lock;
>>
>>         You should consider using u32 here as well or add explicitly
>>         padding.
>>
>>         > +     struct {
>>         > +             __u32 se, sh, instance;
>>         > +     } grbm;
>>         > +     struct {
>>         > +             __u32 me, pipe, queue, vmid;
>>         > +     } srbm;
>>         > +};
>>         > +
>>         > +/*
>>         > + * MMIO debugfs state data (per file* handle)
>>         > + */
>>         > +struct amdgpu_debugfs_regs2_data {
>>         > +     struct amdgpu_device *adev;
>>         > +     struct {
>>         > +             struct amdgpu_debugfs_regs2_iocdata id;
>>         > +             __u32 offset;
>>
>>         What is the offset good for here?
>>
>>         Regards,
>>         Christian.
>>
>>         > +     } state;
>>         > +};
>>         > +
>>         > +enum AMDGPU_DEBUGFS_REGS2_CMDS {
>>         > +     AMDGPU_DEBUGFS_REGS2_CMD_SET_STATE=0,
>>         > +};
>>         > +
>>         > +#define AMDGPU_DEBUGFS_REGS2_IOC_SET_STATE _IOWR(0x20,
>>         AMDGPU_DEBUGFS_REGS2_CMD_SET_STATE, struct
>>         amdgpu_debugfs_regs2_iocdata)
>>
>


--------------2A13EE35E58893FC2DB905B5
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
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
    <div class="moz-cite-prefix">Am 25.08.21 um 13:04 schrieb Tom St
      Denis:<br>
    </div>
    <blockquote type="cite"
cite="mid:CAAzXoRJsSxm7UOt++H9Ko8pnnNdO0Zp=+hPgCh8TwUaQhv-e_w@mail.gmail.com">
      <meta http-equiv="content-type" content="text/html; charset=UTF-8">
      <div dir="ltr">I tested it by forcing bit patterns into the ioctl
        data and printing it out in the kernel log.  I'm not siloed into
        it one way or the other.  I'll just change it to u32.</div>
      <br>
      <div class="gmail_quote">
        <div dir="ltr" class="gmail_attr">On Wed, Aug 25, 2021 at 7:03
          AM Christian König &lt;<a
            href="mailto:ckoenig.leichtzumerken@gmail.com"
            moz-do-not-send="true">ckoenig.leichtzumerken@gmail.com</a>&gt;
          wrote:<br>
        </div>
        <blockquote class="gmail_quote" style="margin:0px 0px 0px
          0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
          <div> Using u8 is ok as well, just make sure that you don't
            have any hidden padding.<br>
            <br>
            Nirmoy had a tool to double check for paddings which I once
            more forgot the name of.<br>
            <br>
            Christian.<br>
            <br>
            <div>Am 25.08.21 um 12:40 schrieb Tom St Denis:<br>
            </div>
            <blockquote type="cite">
              <div dir="ltr">The struct works as is but I'll change them
                to u32.  The offset is an artefact of the fact this was
                an IOCTL originally.  I'm working both ends in parallel
                trying to make the changes at the same time because I'm
                only submitting the kernel patch if I've tested it in
                userspace.
                <div><br>
                </div>
                <div>I'll send a v4 in a bit this morning....</div>
                <div><br>
                </div>
                <div>Tom</div>
              </div>
              <br>
              <div class="gmail_quote">
                <div dir="ltr" class="gmail_attr">On Wed, Aug 25, 2021
                  at 2:35 AM Christian König &lt;<a
                    href="mailto:ckoenig.leichtzumerken@gmail.com"
                    target="_blank" moz-do-not-send="true">ckoenig.leichtzumerken@gmail.com</a>&gt;
                  wrote:<br>
                </div>
                <blockquote class="gmail_quote" style="margin:0px 0px
                  0px 0.8ex;border-left:1px solid
                  rgb(204,204,204);padding-left:1ex"><br>
                  <br>
                  Am 24.08.21 um 15:36 schrieb Tom St Denis:<br>
                  &gt; This new debugfs interface uses an IOCTL
                  interface in order to pass<br>
                  &gt; along state information like SRBM and GRBM bank
                  switching.  This<br>
                  &gt; new interface also allows a full 32-bit MMIO
                  address range which<br>
                  &gt; the previous didn't.  With this new design we
                  have room to grow<br>
                  &gt; the flexibility of the file as need be.<br>
                  &gt;<br>
                  &gt; (v2): Move read/write to .read/.write, fix style,
                  add comment<br>
                  &gt;        for IOCTL data structure<br>
                  &gt;<br>
                  &gt; Signed-off-by: Tom St Denis &lt;<a
                    href="mailto:tom.stdenis@amd.com" target="_blank"
                    moz-do-not-send="true">tom.stdenis@amd.com</a>&gt;<br>
                  &gt; ---<br>
                  &gt;   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |
                  162 ++++++++++++++++++++<br>
                  &gt;   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h | 
                  32 ++++<br>
                  &gt;   2 files changed, 194 insertions(+)<br>
                  &gt;<br>
                  &gt; diff --git
                  a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
                  b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c<br>
                  &gt; index 277128846dd1..8e8f5743c8f5 100644<br>
                  &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c<br>
                  &gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c<br>
                  &gt; @@ -279,6 +279,156 @@ static ssize_t
                  amdgpu_debugfs_regs_write(struct file *f, const char
                  __user *buf,<br>
                  &gt;       return amdgpu_debugfs_process_reg_op(false,
                  f, (char __user *)buf, size, pos);<br>
                  &gt;   }<br>
                  &gt;   <br>
                  &gt; +static int amdgpu_debugfs_regs2_open(struct
                  inode *inode, struct file *file)<br>
                  &gt; +{<br>
                  &gt; +     struct amdgpu_debugfs_regs2_data *rd;<br>
                  &gt; +<br>
                  &gt; +     rd = kzalloc(sizeof *rd, GFP_KERNEL);<br>
                  &gt; +     if (!rd)<br>
                  &gt; +             return -ENOMEM;<br>
                  &gt; +     rd-&gt;adev =
                  file_inode(file)-&gt;i_private;<br>
                  &gt; +     file-&gt;private_data = rd;<br>
                  &gt; +<br>
                  &gt; +     return 0;<br>
                  &gt; +}<br>
                  &gt; +<br>
                  &gt; +static int amdgpu_debugfs_regs2_release(struct
                  inode *inode, struct file *file)<br>
                  &gt; +{<br>
                  &gt; +     kfree(file-&gt;private_data);<br>
                  &gt; +     return 0;<br>
                  &gt; +}<br>
                  &gt; +<br>
                  &gt; +static ssize_t amdgpu_debugfs_regs2_op(struct
                  file *f, char __user *buf, size_t size, int write_en)<br>
                  &gt; +{<br>
                  &gt; +     struct amdgpu_debugfs_regs2_data *rd =
                  f-&gt;private_data;<br>
                  &gt; +     struct amdgpu_device *adev = rd-&gt;adev;<br>
                  &gt; +     ssize_t result = 0;<br>
                  &gt; +     int r;<br>
                  &gt; +     uint32_t value;<br>
                  &gt; +<br>
                  &gt; +     if (size &amp; 0x3 || rd-&gt;state.offset
                  &amp; 0x3)<br>
                  &gt; +             return -EINVAL;<br>
                  &gt; +<br>
                  &gt; +     if (rd-&gt;state.id.use_grbm) {<br>
                  &gt; +             if (rd-&gt;<a
                    href="http://state.id.grbm.se" rel="noreferrer"
                    target="_blank" moz-do-not-send="true">state.id.grbm.se</a>
                  == 0x3FF)<br>
                  &gt; +                     rd-&gt;<a
                    href="http://state.id.grbm.se" rel="noreferrer"
                    target="_blank" moz-do-not-send="true">state.id.grbm.se</a>
                  = 0xFFFFFFFF;<br>
                  &gt; +             if (rd-&gt;<a
                    href="http://state.id.grbm.sh" rel="noreferrer"
                    target="_blank" moz-do-not-send="true">state.id.grbm.sh</a>
                  == 0x3FF)<br>
                  &gt; +                     rd-&gt;<a
                    href="http://state.id.grbm.sh" rel="noreferrer"
                    target="_blank" moz-do-not-send="true">state.id.grbm.sh</a>
                  = 0xFFFFFFFF;<br>
                  &gt; +             if (rd-&gt;state.id.grbm.instance
                  == 0x3FF)<br>
                  &gt; +                   
                   rd-&gt;state.id.grbm.instance = 0xFFFFFFFF;<br>
                  &gt; +     }<br>
                  &gt; +<br>
                  &gt; +     r =
                  pm_runtime_get_sync(adev_to_drm(adev)-&gt;dev);<br>
                  &gt; +     if (r &lt; 0) {<br>
                  &gt; +           
                   pm_runtime_put_autosuspend(adev_to_drm(adev)-&gt;dev);<br>
                  &gt; +             return r;<br>
                  &gt; +     }<br>
                  &gt; +<br>
                  &gt; +     r =
                  amdgpu_virt_enable_access_debugfs(adev);<br>
                  &gt; +     if (r &lt; 0) {<br>
                  &gt; +           
                   pm_runtime_put_autosuspend(adev_to_drm(adev)-&gt;dev);<br>
                  &gt; +             return r;<br>
                  &gt; +     }<br>
                  &gt; +<br>
                  &gt; +     if (rd-&gt;state.id.use_grbm) {<br>
                  &gt; +             if ((rd-&gt;<a
                    href="http://state.id.grbm.sh" rel="noreferrer"
                    target="_blank" moz-do-not-send="true">state.id.grbm.sh</a>
                  != 0xFFFFFFFF &amp;&amp; rd-&gt;<a
                    href="http://state.id.grbm.sh" rel="noreferrer"
                    target="_blank" moz-do-not-send="true">state.id.grbm.sh</a>
                  &gt;= adev-&gt;gfx.config.max_sh_per_se) ||<br>
                  &gt; +                 (rd-&gt;<a
                    href="http://state.id.grbm.se" rel="noreferrer"
                    target="_blank" moz-do-not-send="true">state.id.grbm.se</a>
                  != 0xFFFFFFFF &amp;&amp; rd-&gt;<a
                    href="http://state.id.grbm.se" rel="noreferrer"
                    target="_blank" moz-do-not-send="true">state.id.grbm.se</a>
                  &gt;= adev-&gt;gfx.config.max_shader_engines)) {<br>
                  &gt; +                   
                   pm_runtime_mark_last_busy(adev_to_drm(adev)-&gt;dev);<br>
                  &gt; +                   
                   pm_runtime_put_autosuspend(adev_to_drm(adev)-&gt;dev);<br>
                  &gt; +                   
                   amdgpu_virt_disable_access_debugfs(adev);<br>
                  &gt; +                     return -EINVAL;<br>
                  &gt; +             }<br>
                  &gt; +           
                   mutex_lock(&amp;adev-&gt;grbm_idx_mutex);<br>
                  &gt; +             amdgpu_gfx_select_se_sh(adev,
                  rd-&gt;<a href="http://state.id.grbm.se"
                    rel="noreferrer" target="_blank"
                    moz-do-not-send="true">state.id.grbm.se</a>,<br>
                  &gt; +                                               
                               rd-&gt;<a href="http://state.id.grbm.sh"
                    rel="noreferrer" target="_blank"
                    moz-do-not-send="true">state.id.grbm.sh</a>,<br>
                  &gt; +                                               
                               rd-&gt;state.id.grbm.instance);<br>
                  &gt; +     }<br>
                  &gt; +<br>
                  &gt; +     if (rd-&gt;state.id.use_srbm) {<br>
                  &gt; +           
                   mutex_lock(&amp;adev-&gt;srbm_mutex);<br>
                  &gt; +             amdgpu_gfx_select_me_pipe_q(adev,
                  rd-&gt;<a href="http://state.id.srbm.me"
                    rel="noreferrer" target="_blank"
                    moz-do-not-send="true">state.id.srbm.me</a>,
                  rd-&gt;state.id.srbm.pipe,<br>
                  &gt; +                                               
                                       rd-&gt;state.id.srbm.queue,
                  rd-&gt;state.id.srbm.vmid);<br>
                  &gt; +     }<br>
                  &gt; +<br>
                  &gt; +     if (rd-&gt;state.id.pg_lock)<br>
                  &gt; +             mutex_lock(&amp;adev-&gt;pm.mutex);<br>
                  &gt; +<br>
                  &gt; +     while (size) {<br>
                  &gt; +             if (!write_en) {<br>
                  &gt; +                     value =
                  RREG32(rd-&gt;state.offset &gt;&gt; 2);<br>
                  &gt; +                     r = put_user(value,
                  (uint32_t *)buf);<br>
                  &gt; +             } else {<br>
                  &gt; +                     r = get_user(value,
                  (uint32_t *)buf);<br>
                  &gt; +                     if (!r)<br>
                  &gt; +                           
                   amdgpu_mm_wreg_mmio_rlc(adev, rd-&gt;state.offset
                  &gt;&gt; 2, value);<br>
                  &gt; +             }<br>
                  &gt; +             if (r) {<br>
                  &gt; +                     result = r;<br>
                  &gt; +                     goto end;<br>
                  &gt; +             }<br>
                  &gt; +             rd-&gt;state.offset += 4;<br>
                  &gt; +             size -= 4;<br>
                  &gt; +             result += 4;<br>
                  &gt; +             buf += 4;<br>
                  &gt; +     }<br>
                  &gt; +end:<br>
                  &gt; +     if (rd-&gt;state.id.use_grbm) {<br>
                  &gt; +             amdgpu_gfx_select_se_sh(adev,
                  0xffffffff, 0xffffffff, 0xffffffff);<br>
                  &gt; +           
                   mutex_unlock(&amp;adev-&gt;grbm_idx_mutex);<br>
                  &gt; +     }<br>
                  &gt; +<br>
                  &gt; +     if (rd-&gt;state.id.use_srbm) {<br>
                  &gt; +             amdgpu_gfx_select_me_pipe_q(adev,
                  0, 0, 0, 0);<br>
                  &gt; +           
                   mutex_unlock(&amp;adev-&gt;srbm_mutex);<br>
                  &gt; +     }<br>
                  &gt; +<br>
                  &gt; +     if (rd-&gt;state.id.pg_lock)<br>
                  &gt; +           
                   mutex_unlock(&amp;adev-&gt;pm.mutex);<br>
                  &gt; +<br>
                  &gt; +     // in umr (the likely user of this) flags
                  are set per file operation<br>
                  &gt; +     // which means they're never "unset"
                  explicitly.  To avoid breaking<br>
                  &gt; +     // this convention we unset the flags after
                  each operation<br>
                  &gt; +     // flags are for a single call (need to be
                  set for every read/write)<br>
                  &gt; +     rd-&gt;state.id.use_grbm = 0;<br>
                  &gt; +     rd-&gt;state.id.use_srbm = 0;<br>
                  &gt; +     rd-&gt;state.id.pg_lock  = 0;<br>
                  &gt; +<br>
                  &gt; +   
                   pm_runtime_mark_last_busy(adev_to_drm(adev)-&gt;dev);<br>
                  &gt; +   
                   pm_runtime_put_autosuspend(adev_to_drm(adev)-&gt;dev);<br>
                  &gt; +<br>
                  &gt; +     amdgpu_virt_disable_access_debugfs(adev);<br>
                  &gt; +     return result;<br>
                  &gt; +}<br>
                  &gt; +<br>
                  &gt; +static long amdgpu_debugfs_regs2_ioctl(struct
                  file *f, unsigned int cmd, unsigned long data)<br>
                  &gt; +{<br>
                  &gt; +     struct amdgpu_debugfs_regs2_data *rd =
                  f-&gt;private_data;<br>
                  &gt; +<br>
                  &gt; +     switch (cmd) {<br>
                  &gt; +     case AMDGPU_DEBUGFS_REGS2_IOC_SET_STATE:<br>
                  &gt; +             if (copy_from_user(&amp;rd-&gt;<a
                    href="http://state.id" rel="noreferrer"
                    target="_blank" moz-do-not-send="true">state.id</a>,
                  (struct amdgpu_debugfs_regs2_iocdata *)data, sizeof
                  rd-&gt;<a href="http://state.id" rel="noreferrer"
                    target="_blank" moz-do-not-send="true">state.id</a>))<br>
                  &gt; +                     return -EINVAL;<br>
                  &gt; +             break;<br>
                  &gt; +     default:<br>
                  &gt; +             return -EINVAL;<br>
                  &gt; +     }<br>
                  &gt; +     return 0;<br>
                  &gt; +}<br>
                  &gt; +<br>
                  &gt; +static ssize_t amdgpu_debugfs_regs2_read(struct
                  file *f, char __user *buf, size_t size, loff_t *pos)<br>
                  &gt; +{<br>
                  &gt; +     struct amdgpu_debugfs_regs2_data *rd =
                  f-&gt;private_data;<br>
                  &gt; +     rd-&gt;state.offset = *pos;<br>
                  &gt; +     return amdgpu_debugfs_regs2_op(f, buf,
                  size, 0);<br>
                  &gt; +}<br>
                  &gt; +<br>
                  &gt; +static ssize_t amdgpu_debugfs_regs2_write(struct
                  file *f, const char __user *buf, size_t size, loff_t
                  *pos)<br>
                  &gt; +{<br>
                  &gt; +     struct amdgpu_debugfs_regs2_data *rd =
                  f-&gt;private_data;<br>
                  &gt; +     rd-&gt;state.offset = *pos;<br>
                  &gt; +     return amdgpu_debugfs_regs2_op(f, (char
                  __user *)buf, size, 1);<br>
                  &gt; +}<br>
                  &gt; +<br>
                  &gt;   <br>
                  &gt;   /**<br>
                  &gt;    * amdgpu_debugfs_regs_pcie_read - Read from a
                  PCIE register<br>
                  &gt; @@ -1091,6 +1241,16 @@ static ssize_t
                  amdgpu_debugfs_gfxoff_read(struct file *f, char __user
                  *buf,<br>
                  &gt;       return result;<br>
                  &gt;   }<br>
                  &gt;   <br>
                  &gt; +static const struct file_operations
                  amdgpu_debugfs_regs2_fops = {<br>
                  &gt; +     .owner = THIS_MODULE,<br>
                  &gt; +     .unlocked_ioctl =
                  amdgpu_debugfs_regs2_ioctl,<br>
                  &gt; +     .read = amdgpu_debugfs_regs2_read,<br>
                  &gt; +     .write = amdgpu_debugfs_regs2_write,<br>
                  &gt; +     .open = amdgpu_debugfs_regs2_open,<br>
                  &gt; +     .release = amdgpu_debugfs_regs2_release,<br>
                  &gt; +     .llseek = default_llseek<br>
                  &gt; +};<br>
                  &gt; +<br>
                  &gt;   static const struct file_operations
                  amdgpu_debugfs_regs_fops = {<br>
                  &gt;       .owner = THIS_MODULE,<br>
                  &gt;       .read = amdgpu_debugfs_regs_read,<br>
                  &gt; @@ -1148,6 +1308,7 @@ static const struct
                  file_operations amdgpu_debugfs_gfxoff_fops = {<br>
                  &gt;   <br>
                  &gt;   static const struct file_operations
                  *debugfs_regs[] = {<br>
                  &gt;       &amp;amdgpu_debugfs_regs_fops,<br>
                  &gt; +     &amp;amdgpu_debugfs_regs2_fops,<br>
                  &gt;       &amp;amdgpu_debugfs_regs_didt_fops,<br>
                  &gt;       &amp;amdgpu_debugfs_regs_pcie_fops,<br>
                  &gt;       &amp;amdgpu_debugfs_regs_smc_fops,<br>
                  &gt; @@ -1160,6 +1321,7 @@ static const struct
                  file_operations *debugfs_regs[] = {<br>
                  &gt;   <br>
                  &gt;   static const char *debugfs_regs_names[] = {<br>
                  &gt;       "amdgpu_regs",<br>
                  &gt; +     "amdgpu_regs2",<br>
                  &gt;       "amdgpu_regs_didt",<br>
                  &gt;       "amdgpu_regs_pcie",<br>
                  &gt;       "amdgpu_regs_smc",<br>
                  &gt; diff --git
                  a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h
                  b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h<br>
                  &gt; index 141a8474e24f..ec044df5d428 100644<br>
                  &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h<br>
                  &gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.h<br>
                  &gt; @@ -22,6 +22,8 @@<br>
                  &gt;    * OTHER DEALINGS IN THE SOFTWARE.<br>
                  &gt;    *<br>
                  &gt;    */<br>
                  &gt; +#include &lt;linux/ioctl.h&gt;<br>
                  &gt; +#include &lt;uapi/drm/amdgpu_drm.h&gt;<br>
                  &gt;   <br>
                  &gt;   /*<br>
                  &gt;    * Debugfs<br>
                  &gt; @@ -38,3 +40,33 @@ void
                  amdgpu_debugfs_fence_init(struct amdgpu_device *adev);<br>
                  &gt;   void amdgpu_debugfs_firmware_init(struct
                  amdgpu_device *adev);<br>
                  &gt;   void amdgpu_debugfs_gem_init(struct
                  amdgpu_device *adev);<br>
                  &gt;   int amdgpu_debugfs_wait_dump(struct
                  amdgpu_device *adev);<br>
                  &gt; +<br>
                  &gt; +/*<br>
                  &gt; + * MMIO debugfs IOCTL structure<br>
                  &gt; + */<br>
                  &gt; +struct amdgpu_debugfs_regs2_iocdata {<br>
                  &gt; +     __u8 use_srbm, use_grbm, pg_lock;<br>
                  <br>
                  You should consider using u32 here as well or add
                  explicitly padding.<br>
                  <br>
                  &gt; +     struct {<br>
                  &gt; +             __u32 se, sh, instance;<br>
                  &gt; +     } grbm;<br>
                  &gt; +     struct {<br>
                  &gt; +             __u32 me, pipe, queue, vmid;<br>
                  &gt; +     } srbm;<br>
                  &gt; +};<br>
                  &gt; +<br>
                  &gt; +/*<br>
                  &gt; + * MMIO debugfs state data (per file* handle)<br>
                  &gt; + */<br>
                  &gt; +struct amdgpu_debugfs_regs2_data {<br>
                  &gt; +     struct amdgpu_device *adev;<br>
                  &gt; +     struct {<br>
                  &gt; +             struct amdgpu_debugfs_regs2_iocdata
                  id;<br>
                  &gt; +             __u32 offset;<br>
                  <br>
                  What is the offset good for here?<br>
                  <br>
                  Regards,<br>
                  Christian.<br>
                  <br>
                  &gt; +     } state;<br>
                  &gt; +};<br>
                  &gt; +<br>
                  &gt; +enum AMDGPU_DEBUGFS_REGS2_CMDS {<br>
                  &gt; +     AMDGPU_DEBUGFS_REGS2_CMD_SET_STATE=0,<br>
                  &gt; +};<br>
                  &gt; +<br>
                  &gt; +#define AMDGPU_DEBUGFS_REGS2_IOC_SET_STATE
                  _IOWR(0x20, AMDGPU_DEBUGFS_REGS2_CMD_SET_STATE, struct
                  amdgpu_debugfs_regs2_iocdata)<br>
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
  </body>
</html>

--------------2A13EE35E58893FC2DB905B5--
